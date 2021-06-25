#!/usr/bin/env php
<?php

// increase memory limit since the XML file is quite large
ini_set('memory_limit', '2048M');

// simple progress bar function
function progress_bar(int $done, int $total, string $info = "", int $width = 50): string
{
    $perc = round(($done * 100) / $total);
    $bar = ceil(($width * $perc) / 100);

    return sprintf(
        "[%s>%s] %s%% %s\r",
        str_repeat("=", (int) $bar),
        str_repeat(" ", (int) floor($width - $bar)),
        $perc,
        $info
    );
}

function usage(): void
{
    $file = basename(__FILE__);
    die(
    <<<USAGE
You need to provide a source and a target file
    \033[1;37m-s\033[0m source xml file
    \033[1;37m-t\033[0m location of the sqllite db

\033[1;31mWarning\033[0;31m: Any existing data will be lost!\033[0m

 => download the source file from: https://download.swissmedicinfo.ch/

example usage:
\033[0;33m$ ./$file -s <path to xml> -t <path to .db file>\033[0m

USAGE);
}

// get script arguments
$options = getopt(
    's:t:',
);

/** @var ?string $source */
$source = $options['s'] ?? null;
/** @var ?string $target */
$target = $options['t'] ?? null;

if ($source === null || $target === null) {
    usage();
}

$source = realpath($source);
// realpath can only be used on existing files
$target = realpath($target) ?: $target;

if (!file_exists($source) || !is_readable($source)) {
    echo <<<ERROR
Error: source file ($source) not found or not readable
ERROR;
    usage();
}

if (file_exists($target) && !is_writable($target)) {
    echo <<<ERROR
error: target file ($target) not writable
ERROR;
    usage();
}

touch($target); // ensure file exists
$db = new PDO('sqlite:'.$target);
// todo: create db if not exists, drop otherwise
if (!$db->query("SELECT name FROM sqlite_master WHERE type='table' AND name='medications'")->fetch()) {
    echo "Setting up db\n";
    // create basic table
    $db->query(
        <<<SQL
create table medications
(
    title text not null,
    authHolder text not null,
    atcCode text,
    substances text,
    authNrs text,
    remark text,
    style text not null,
    content text not null,
    sections text,
    type text,
    version text,
    lang text,
    safetyRelevant integer,
    informationUpdate text
);
SQL
    );
} else {
    echo "Cleaning existing db\n";
    // clean DB if it exists
    $db->query('delete from medications');
}

echo "Loading XML file (< 1min)...\n";
$xml = simplexml_load_string(file_get_contents($source));

$current = 0;
$total = $xml->count();

echo "Writing data into DB file...\n";
/** @var SimpleXMLElement $child */
foreach ($xml as $child) {
    echo progress_bar(++$current, $total);

    $attributes = [];
    foreach ($child->attributes() as $key => $value) {
        $attributes[$key] = $value;
    }

    $sections = [];

    foreach ($child as $element) {
        if ($element->getName() === 'sections') {
            /** @var SimpleXMLElement $section */
            foreach ($element as $section) {
                foreach ($section->attributes() as $key => $value) {
                    if ($key === 'id') {
                        $sections[(string) $value] = (string) $section->title;
                    }
                }
            }
        }
    }

    if ((string) $attributes['type'] === 'fi') {
        // we only need the patient's information
        continue;
    }

    if ((string) $attributes['lang'] !== 'de') {
        // for now only german
        continue;
    }

    $prepared = $db->prepare(
        "
insert into medications
    (title, authHolder, atcCode, substances, authNrs, remark, style, content, sections, type, version, lang, safetyRelevant, informationUpdate)
    values
    (:title, :authHolder, :atcCode, :substances, :authNrs, :remark, :style, :content, :sections, :type, :version, :lang, :safetyRelevant, :informationUpdate);
"
    );

    $prepared->bindValue('title', (string) $child->title, SQLITE3_TEXT);
    $prepared->bindValue('authHolder', (string) $child->authHolder, SQLITE3_TEXT);
    $prepared->bindValue('atcCode', ((string) $child->atcCode) ?: null, SQLITE3_TEXT);
    $prepared->bindValue('substances', ((string) $child->substances) ?: null, SQLITE3_TEXT);
    $prepared->bindValue('authNrs', ((string) $child->authNrs) ?: null, SQLITE3_TEXT);
    $prepared->bindValue('remark', ((string) $child->remark) ?: null, SQLITE3_TEXT);

    //$prepared->bindValue('style', (string) $child->style, SQLITE3_TEXT);
    // we don't really need the style information so we import them as empty for now
    $prepared->bindValue('style', '', SQLITE3_TEXT);
    $prepared->bindValue('content', (string) $child->content, SQLITE3_TEXT);

    $prepared->bindValue('sections', json_encode($sections, JSON_FORCE_OBJECT + JSON_THROW_ON_ERROR), SQLITE3_TEXT);
    // Patienteninformationen (PI) Fachinformationen (FI)

    $prepared->bindValue('type', (string) $attributes['type'], SQLITE3_TEXT);
    $prepared->bindValue('version', (string) $attributes['version'], SQLITE3_TEXT);
    $prepared->bindValue('lang', (string) $attributes['lang'], SQLITE3_TEXT);
    $prepared->bindValue('safetyRelevant', ((string) $attributes['safetyRelevant']) === 'true', SQLITE3_INTEGER);
    $prepared->bindValue('informationUpdate', (string) $attributes['informationUpdate'], SQLITE3_TEXT);
    $prepared->execute();
}
