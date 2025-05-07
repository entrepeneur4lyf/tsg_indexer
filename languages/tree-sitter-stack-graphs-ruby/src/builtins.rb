# This file contains minimal definitions of Ruby standard library classes
# for use with tree-sitter-stack-graphs.

# Basic Object class
class Object
  def nil?; end
  def is_a?(klass); end
  def class; end
  def to_s; end
  def inspect; end
  def ==; end
  def eql?; end
  def hash; end
  def freeze; end
  def frozen?; end
  def dup; end
  def clone; end
  def method(name); end
  def respond_to?(method_name); end
  def send(method_name, *args); end
  def instance_variable_get(name); end
  def instance_variable_set(name, value); end
end

# String class
class String < Object
  include Comparable
  
  def length; end
  def size; end
  def empty?; end
  def [](index); end
  def []=(index, value); end
  def +(other); end
  def *(count); end
  def <<(obj); end
  def upcase; end
  def downcase; end
  def capitalize; end
  def strip; end
  def chomp; end
  def split(pattern = nil, limit = 0); end
  def gsub(pattern, replacement = nil); end
  def sub(pattern, replacement = nil); end
  def match(pattern); end
  def start_with?(*prefixes); end
  def end_with?(*suffixes); end
  def include?(other_str); end
  def to_i; end
  def to_f; end
  def to_sym; end
  def each_line; end
  def bytes; end
  def chars; end
  def lines; end
end

# Array class
class Array < Object
  include Enumerable
  
  def [](index); end
  def []=(index, value); end
  def length; end
  def size; end
  def empty?; end
  def first; end
  def last; end
  def push(obj); end
  def <<(obj); end
  def pop; end
  def shift; end
  def unshift(*args); end
  def each; end
  def map; end
  def select; end
  def reject; end
  def join(separator = $,); end
  def sort; end
  def sort_by; end
  def include?(obj); end
  def any?; end
  def all?; end
  def none?; end
  def flatten; end
  def compact; end
  def uniq; end
  def reverse; end
  def sample; end
  def shuffle; end
  def +(other_ary); end
  def -(other_ary); end
  def &(other_ary); end
  def |(other_ary); end
end

# Hash class
class Hash < Object
  include Enumerable
  
  def [](key); end
  def []=(key, value); end
  def key?(key); end
  def has_key?(key); end
  def include?(key); end
  def member?(key); end
  def value?(value); end
  def has_value?(value); end
  def keys; end
  def values; end
  def length; end
  def size; end
  def empty?; end
  def delete(key); end
  def clear; end
  def merge(other_hash); end
  def merge!(other_hash); end
  def each; end
  def each_pair; end
  def each_key; end
  def each_value; end
  def map; end
  def select; end
  def reject; end
  def transform_keys; end
  def transform_values; end
  def to_a; end
  def to_h; end
  def fetch(key, default = nil); end
  def values_at(*keys); end
  def dig(*keys); end
end

# Kernel module
module Kernel
  def puts(*args); end
  def print(*args); end
  def p(*args); end
  def gets(separator = $/, limit = nil); end
  def sleep(seconds = nil); end
  def rand(max = 0); end
  def srand(number = 0); end
  def exit(status = true); end
  def abort(msg = nil); end
  def raise(exception = nil, string = nil, array = nil); end
  def fail(exception = nil, string = nil, array = nil); end
  def require(name); end
  def require_relative(string); end
  def load(filename, wrap = false); end
  def lambda; end
  def proc; end
  def system(*args); end
  def eval(string, binding = nil, filename = nil, lineno = nil); end
  def catch(tag = nil); end
  def throw(tag, obj = nil); end
  def warn(*msgs); end
  def sprintf(format, *args); end
  def format(format, *args); end
  def loop; end
  def exec(*args); end
  def fork; end
end

# Enumerable module
module Enumerable
  def all?; end
  def any?; end
  def collect; end
  def map; end
  def each_with_index; end
  def find; end
  def detect; end
  def find_all; end
  def select; end
  def filter; end
  def reject; end
  def grep(pattern); end
  def reduce(initial = nil, sym = nil); end
  def inject(initial = nil, sym = nil); end
  def first(n = nil); end
  def count(item = nil); end
  def to_a; end
  def entries; end
  def to_h; end
  def zip(*lists); end
  def min; end
  def max; end
  def minmax; end
  def sort; end
  def sort_by; end
  def include?(obj); end
  def member?(obj); end
  def each_with_object(obj); end
  def flat_map; end
  def collect_concat; end
  def group_by; end
  def partition; end
end

# IO class
class IO < Object
  def read(length = nil, outbuf = nil); end
  def write(string); end
  def puts(*args); end
  def print(*args); end
  def printf(format, *args); end
  def flush; end
  def close; end
  def closed?; end
  def each_line; end
  def readline; end
  def readlines; end
  def getc; end
  def gets; end
  def eof?; end
  def rewind; end
  def seek(amount, whence = SEEK_SET); end
  def reopen(other_IO); end
  def tell; end
  def sync; end
  def sync=; end
  def fsync; end
  def fileno; end
  def to_io; end
end

# File class
class File < IO
  def self.exist?(path); end
  def self.exists?(path); end
  def self.file?(path); end
  def self.directory?(path); end
  def self.dirname(path); end
  def self.basename(path, suffix = ''); end
  def self.extname(path); end
  def self.expand_path(path, default_dir = nil); end
  def self.join(*parts); end
  def self.stat(path); end
  def self.lstat(path); end
  def self.ftype(path); end
  def self.atime(path); end
  def self.ctime(path); end
  def self.mtime(path); end
  def self.size(path); end
  def self.zero?(path); end
  def self.readable?(path); end
  def self.writable?(path); end
  def self.executable?(path); end
  def self.symlink?(path); end
  def self.readlink(path); end
  def self.delete(*paths); end
  def self.unlink(*paths); end
  def self.rename(old_name, new_name); end
  def self.link(old_name, new_name); end
  def self.symlink(old_name, new_name); end
  def self.chmod(mode, *paths); end
  def self.chown(owner, group, *paths); end
  def self.truncate(path, length); end
  def self.open(path, mode = 'r', perm = nil, **opts); end
  def self.read(path, length = nil, offset = 0, **opts); end
  def self.readlines(path, sep = $/); end
  def self.write(path, string, offset = nil, **opts); end
end

# Dir class
class Dir < Object
  def self.pwd; end
  def self.getwd; end
  def self.chdir(path = nil); end
  def self.glob(pattern, flags = 0); end
  def self.entries(dirname); end
  def self.each_child(dirname); end
  def self.mkdir(dirname, mode = 0777); end
  def self.rmdir(dirname); end
  def self.exist?(dirname); end
  def self.exists?(dirname); end
  def self.home(user = nil); end
  def self.open(dirname); end
  def self.delete(dirname); end
  def self.unlink(dirname); end
  def close; end
  def each; end
  def read; end
  def rewind; end
  def tell; end
  def seek(position); end
  def path; end
end

# Exception classes
class Exception
  def message; end
  def backtrace; end
  def backtrace_locations; end
  def set_backtrace(backtrace); end
  def cause; end
  def inspect; end
  def to_s; end
end

class StandardError < Exception; end
class RuntimeError < StandardError; end
class ArgumentError < StandardError; end
class NameError < StandardError; end
class NoMethodError < NameError; end
class TypeError < StandardError; end
class LoadError < StandardError; end
class SyntaxError < StandardError; end

# Time class
class Time < Object
  include Comparable
  
  def self.now; end
  def self.new(year = nil, month = nil, day = nil, hour = nil, min = nil, sec = nil, usec_with_frac = nil, utc_offset = nil); end
  def self.at(time); end
  def self.utc(year, month = nil, day = nil, hour = nil, min = nil, sec = nil, usec = nil); end
  def self.gm(year, month = nil, day = nil, hour = nil, min = nil, sec = nil, usec = nil); end
  def self.local(year, month = nil, day = nil, hour = nil, min = nil, sec = nil, usec = nil); end
  def self.mktime(year, month = nil, day = nil, hour = nil, min = nil, sec = nil, usec = nil); end
  def self.parse(date_string, now = Time.now); end
  def +(other); end
  def -(other); end
  def to_s; end
  def to_i; end
  def to_f; end
  def to_a; end
  def year; end
  def month; end
  def day; end
  def hour; end
  def min; end
  def sec; end
  def usec; end
  def nsec; end
  def wday; end
  def yday; end
  def dst?; end
  def zone; end
  def strftime(format); end
  def utc; end
  def getutc; end
  def utc?; end
  def getlocal; end
  def localtime; end
  def gmtime; end
  def ctime; end
  def gmt?; end
  def round(digits = 0); end
  def floor(digits = 0); end
  def ceil(digits = 0); end
end