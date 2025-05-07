<?php
// This file contains minimal definitions of PHP standard library functions and classes
// for use with tree-sitter-stack-graphs.

// Core interfaces
interface Traversable {}

interface Iterator extends Traversable {
    public function current();
    public function key();
    public function next();
    public function rewind();
    public function valid();
}

interface IteratorAggregate extends Traversable {
    public function getIterator();
}

interface ArrayAccess {
    public function offsetExists($offset);
    public function offsetGet($offset);
    public function offsetSet($offset, $value);
    public function offsetUnset($offset);
}

interface Throwable {
    public function getMessage();
    public function getCode();
    public function getFile();
    public function getLine();
    public function getTrace();
    public function getTraceAsString();
    public function getPrevious();
    public function __toString();
}

// Core classes
class Exception implements Throwable {
    protected $message;
    protected $code;
    protected $file;
    protected $line;
    
    public function __construct($message = "", $code = 0, Throwable $previous = null) {}
    public function getMessage() {}
    public function getCode() {}
    public function getFile() {}
    public function getLine() {}
    public function getTrace() {}
    public function getTraceAsString() {}
    public function getPrevious() {}
    public function __toString() {}
}

class Error implements Throwable {
    protected $message;
    protected $code;
    protected $file;
    protected $line;
    
    public function __construct($message = "", $code = 0, Throwable $previous = null) {}
    public function getMessage() {}
    public function getCode() {}
    public function getFile() {}
    public function getLine() {}
    public function getTrace() {}
    public function getTraceAsString() {}
    public function getPrevious() {}
    public function __toString() {}
}

class Closure {
    public static function bind(Closure $closure, ?object $newThis, object|string|null $newScope = "static") {}
    public static function bindTo(?object $newThis, object|string|null $newScope = "static") {}
    public static function fromCallable(callable $callback) {}
    public function call(object $newThis, mixed ...$args) {}
}

class Generator implements Iterator {
    public function current() {}
    public function key() {}
    public function next() {}
    public function rewind() {}
    public function send($value) {}
    public function throw(Throwable $exception) {}
    public function valid() {}
    public function getReturn() {}
}

class DateTime implements DateTimeInterface {
    public const ATOM = 'Y-m-d\TH:i:sP';
    public const COOKIE = 'l, d-M-Y H:i:s T';
    public const ISO8601 = 'Y-m-d\TH:i:sO';
    public const RFC822 = 'D, d M y H:i:s O';
    public const RFC850 = 'l, d-M-y H:i:s T';
    public const RFC1036 = 'D, d M y H:i:s O';
    public const RFC1123 = 'D, d M Y H:i:s O';
    public const RFC2822 = 'D, d M Y H:i:s O';
    public const RFC3339 = 'Y-m-d\TH:i:sP';
    public const RFC3339_EXTENDED = 'Y-m-d\TH:i:s.vP';
    public const RFC7231 = 'D, d M Y H:i:s \G\M\T';
    public const RSS = 'D, d M Y H:i:s O';
    public const W3C = 'Y-m-d\TH:i:sP';
    
    public function __construct(string $datetime = "now", ?DateTimeZone $timezone = null) {}
    public function format(string $format) {}
    public function getTimezone() {}
    public function setTimezone(DateTimeZone $timezone) {}
    public function getOffset() {}
    public function getTimestamp() {}
    public function setTimestamp(int $timestamp) {}
    public function diff(DateTimeInterface $datetime2, bool $absolute = false) {}
    public function modify(string $modifier) {}
    public function add(DateInterval $interval) {}
    public function sub(DateInterval $interval) {}
    public static function createFromImmutable(DateTimeImmutable $object) {}
    public static function createFromInterface(DateTimeInterface $object) {}
    public static function createFromFormat(string $format, string $datetime, ?DateTimeZone $timezone = null) {}
    public static function getLastErrors() {}
}

interface DateTimeInterface {
    public function format(string $format);
    public function getTimezone();
    public function getOffset();
    public function getTimestamp();
    public function diff(DateTimeInterface $datetime2, bool $absolute = false);
}

class DateTimeImmutable implements DateTimeInterface {
    public function __construct(string $datetime = "now", ?DateTimeZone $timezone = null) {}
    public function format(string $format) {}
    public function getTimezone() {}
    public function setTimezone(DateTimeZone $timezone) {}
    public function getOffset() {}
    public function getTimestamp() {}
    public function setTimestamp(int $timestamp) {}
    public function diff(DateTimeInterface $datetime2, bool $absolute = false) {}
    public function modify(string $modifier) {}
    public function add(DateInterval $interval) {}
    public function sub(DateInterval $interval) {}
    public static function createFromMutable(DateTime $object) {}
    public static function createFromInterface(DateTimeInterface $object) {}
    public static function createFromFormat(string $format, string $datetime, ?DateTimeZone $timezone = null) {}
    public static function getLastErrors() {}
}

class DateTimeZone {
    public const AFRICA = 1;
    public const AMERICA = 2;
    public const ANTARCTICA = 4;
    public const ARCTIC = 8;
    public const ASIA = 16;
    public const ATLANTIC = 32;
    public const AUSTRALIA = 64;
    public const EUROPE = 128;
    public const INDIAN = 256;
    public const PACIFIC = 512;
    public const UTC = 1024;
    public const ALL = 2047;
    public const ALL_WITH_BC = 4095;
    public const PER_COUNTRY = 4096;
    
    public function __construct(string $timezone) {}
    public function getName() {}
    public function getOffset(DateTimeInterface $datetime) {}
    public function getTransitions(int $timestampBegin = 0, int $timestampEnd = 0) {}
    public function getLocation() {}
    public static function listAbbreviations() {}
    public static function listIdentifiers(int $timezoneGroup = DateTimeZone::ALL, ?string $countryCode = null) {}
}

class PDO {
    public function __construct(string $dsn, ?string $username = null, ?string $password = null, ?array $options = null) {}
    public function beginTransaction() {}
    public function commit() {}
    public function exec(string $statement) {}
    public function getAttribute(int $attribute) {}
    public function lastInsertId(?string $name = null) {}
    public function prepare(string $query, array $options = []) {}
    public function query(string $query, ?int $fetchMode = null) {}
    public function quote(string $string, int $type = PDO::PARAM_STR) {}
    public function rollBack() {}
    public function setAttribute(int $attribute, mixed $value) {}
}

class PDOStatement implements Traversable {
    public function bindColumn(string|int $column, mixed &$var, int $type = PDO::PARAM_STR, int $maxLength = 0, mixed $driverOptions = null) {}
    public function bindParam(string|int $param, mixed &$var, int $type = PDO::PARAM_STR, int $maxLength = 0, mixed $driverOptions = null) {}
    public function bindValue(string|int $param, mixed $value, int $type = PDO::PARAM_STR) {}
    public function closeCursor() {}
    public function columnCount() {}
    public function debugDumpParams() {}
    public function errorCode() {}
    public function errorInfo() {}
    public function execute(?array $params = null) {}
    public function fetch(int $mode = PDO::FETCH_DEFAULT, int $cursorOrientation = PDO::FETCH_ORI_NEXT, int $cursorOffset = 0) {}
    public function fetchAll(int $mode = PDO::FETCH_DEFAULT) {}
    public function fetchColumn(int $column = 0) {}
    public function fetchObject(?string $class = "stdClass", array $constructorArgs = []) {}
    public function getAttribute(int $attribute) {}
    public function getColumnMeta(int $column) {}
    public function nextRowset() {}
    public function rowCount() {}
    public function setAttribute(int $attribute, mixed $value) {}
    public function setFetchMode(int $mode) {}
}

// Core array functions
function array_chunk(array $array, int $length, bool $preserve_keys = false) {}
function array_column(array $array, int|string|null $column_key, int|string|null $index_key = null) {}
function array_combine(array $keys, array $values) {}
function array_count_values(array $array) {}
function array_diff(array $array, array ...$arrays) {}
function array_fill(int $start_index, int $count, mixed $value) {}
function array_filter(array $array, ?callable $callback = null, int $mode = 0) {}
function array_flip(array $array) {}
function array_intersect(array $array, array ...$arrays) {}
function array_key_exists(string|int $key, array $array) {}
function array_keys(array $array, mixed $search_value = null, bool $strict = false) {}
function array_map(?callable $callback, array $array, array ...$arrays) {}
function array_merge(array ...$arrays) {}
function array_pop(array &$array) {}
function array_push(array &$array, mixed ...$values) {}
function array_reduce(array $array, callable $callback, mixed $initial = null) {}
function array_reverse(array $array, bool $preserve_keys = false) {}
function array_search(mixed $needle, array $haystack, bool $strict = false) {}
function array_shift(array &$array) {}
function array_slice(array $array, int $offset, ?int $length = null, bool $preserve_keys = false) {}
function array_splice(array &$array, int $offset, ?int $length = null, mixed $replacement = []) {}
function array_sum(array $array) {}
function array_unique(array $array, int $flags = SORT_STRING) {}
function array_unshift(array &$array, mixed ...$values) {}
function array_values(array $array) {}
function array_walk(array &$array, callable $callback, mixed $arg = null) {}
function count(Countable|array $value, int $mode = COUNT_NORMAL) {}
function in_array(mixed $needle, array $haystack, bool $strict = false) {}
function sort(array &$array, int $flags = SORT_REGULAR) {}

// Core string functions
function explode(string $separator, string $string, int $limit = PHP_INT_MAX) {}
function implode(string|array $separator, ?array $array = null) {}
function str_contains(string $haystack, string $needle) {}
function str_ends_with(string $haystack, string $needle) {}
function str_pad(string $string, int $length, string $pad_string = " ", int $pad_type = STR_PAD_RIGHT) {}
function str_replace(array|string $search, array|string $replace, string|array $subject, int &$count = null) {}
function str_starts_with(string $haystack, string $needle) {}
function strlen(string $string) {}
function strpos(string $haystack, string $needle, int $offset = 0) {}
function strtolower(string $string) {}
function strtoupper(string $string) {}
function substr(string $string, int $offset, ?int $length = null) {}
function trim(string $string, string $characters = " \n\r\t\v\0") {}

// Date and time functions
function date(string $format, ?int $timestamp = null) {}
function strtotime(string $datetime, ?int $baseTimestamp = null) {}
function time() {}

// File system functions
function file_exists(string $filename) {}
function file_get_contents(string $filename, bool $use_include_path = false, ?resource $context = null, int $offset = 0, ?int $length = null) {}
function file_put_contents(string $filename, mixed $data, int $flags = 0, ?resource $context = null) {}
function fclose(resource $stream) {}
function fopen(string $filename, string $mode, bool $use_include_path = false, ?resource $context = null) {}
function fread(resource $stream, int $length) {}
function fwrite(resource $stream, string $data, ?int $length = null) {}
function mkdir(string $directory, int $permissions = 0777, bool $recursive = false, ?resource $context = null) {}
function realpath(string $path) {}
function rmdir(string $directory, ?resource $context = null) {}
function unlink(string $filename, ?resource $context = null) {}

// Variable handling
function empty(mixed $var) {}
function is_array(mixed $var) {}
function is_bool(mixed $var) {}
function is_int(mixed $var) {}
function is_null(mixed $var) {}
function is_numeric(mixed $var) {}
function is_string(mixed $var) {}
function isset(mixed $var, mixed ...$vars) {}
function unset(mixed $var, mixed ...$vars) {}
function var_dump(mixed $value, mixed ...$values) {}

// Output functions
function echo(string $arg, string ...$args) {}
function print(string $arg) {}
function printf(string $format, mixed ...$values) {}
function sprintf(string $format, mixed ...$values) {}

// Laravel framework classes (common in PHP projects)
namespace Illuminate\Foundation {
    class Application {}
}

namespace Illuminate\Support {
    class Collection {}
}

namespace Illuminate\Database\Eloquent {
    class Model {}
}

namespace Illuminate\Http {
    class Request {}
    class Response {}
}

// Symfony framework classes (common in PHP projects)
namespace Symfony\Component\HttpFoundation {
    class Request {}
    class Response {}
}