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

echo "Loading XML file (< 1min)...\n";
$xml = simplexml_load_string(file_get_contents($source));

$current = 0;
$total = $xml->count();

$file = fopen($target, 'w');
fwrite($file, '['); // open brackets for JSON
echo "Writing data into JSON file...\n";

$entry_id = 1;
$has_written_first_entry = false;
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

    $json_data = [
        'id' => $entry_id++,
        'name' => (string) $child->title,
        'substances' => ((string) $child->substances) ?: null,
        'authHolder' => (string) $child->authHolder,
    ];

    fwrite($file, "\n");
    if ($has_written_first_entry) {
        fwrite($file, ",");
    }
    fwrite($file, json_encode($json_data, JSON_PRETTY_PRINT + JSON_UNESCAPED_SLASHES + JSON_UNESCAPED_UNICODE));
    $has_written_first_entry = true;
}
fwrite($file, ']');
fclose($file);
