#!/bin/bash
# This file contains definitions of Bash built-in functions and variables
# for use with tree-sitter-stack-graphs.

#
# Common Bash utility functions
#

# Echo with color
function echo_color() {
  local color="$1"
  local message="$2"
  
  case "$color" in
    "red")    echo -e "\033[31m$message\033[0m" ;;
    "green")  echo -e "\033[32m$message\033[0m" ;;
    "yellow") echo -e "\033[33m$message\033[0m" ;;
    "blue")   echo -e "\033[34m$message\033[0m" ;;
    "purple") echo -e "\033[35m$message\033[0m" ;;
    "cyan")   echo -e "\033[36m$message\033[0m" ;;
    *)        echo "$message" ;;
  esac
}

# Check if a string contains a substring
function contains() {
  local string="$1"
  local substring="$2"
  
  if [[ "$string" == *"$substring"* ]]; then
    return 0
  else
    return 1
  fi
}

# Trim whitespace from a string
function trim() {
  local string="$1"
  echo "$string" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'
}

# Check if a command exists
function command_exists() {
  command -v "$1" &> /dev/null
}

# Get script directory
function get_script_dir() {
  local dir
  dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  echo "$dir"
}

# Safe source a file
function safe_source() {
  local file="$1"
  if [[ -f "$file" ]]; then
    source "$file"
    return 0
  else
    echo "Error: File '$file' not found"
    return 1
  fi
}

# Join array elements with a delimiter
function join_by() {
  local delimiter="$1"
  shift
  local first="$1"
  shift
  printf "%s" "$first" "${@/#/$delimiter}"
}

# Check if a value exists in an array
function array_contains() {
  local needle="$1"
  shift
  local haystack=("$@")
  
  for item in "${haystack[@]}"; do
    if [[ "$item" == "$needle" ]]; then
      return 0
    fi
  done
  return 1
}

# Get keys from an associative array
function get_keys() {
  local -n arr="$1"
  echo "${!arr[@]}"
}

# Read a file line by line
function read_file() {
  local file="$1"
  local line
  
  if [[ ! -f "$file" ]]; then
    echo "Error: File '$file' not found"
    return 1
  fi
  
  while IFS= read -r line; do
    echo "$line"
  done < "$file"
}

# Parse command line arguments
function parse_args() {
  local POSITIONAL=()
  
  while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
      -h|--help)
        show_help
        exit 0
        ;;
      -v|--verbose)
        VERBOSE=true
        shift
        ;;
      -o|--output)
        OUTPUT_FILE="$2"
        shift 2
        ;;
      *)
        POSITIONAL+=("$1")
        shift
        ;;
    esac
  done
  
  set -- "${POSITIONAL[@]}"
}

# Print usage information
function show_help() {
  echo "Usage: $0 [options] [arguments]"
  echo
  echo "Options:"
  echo "  -h, --help     Show this help message and exit"
  echo "  -v, --verbose  Enable verbose output"
  echo "  -o, --output   Specify output file"
}

# Create a backup of a file
function backup_file() {
  local file="$1"
  local backup="${file}.bak"
  
  if [[ -f "$file" ]]; then
    cp "$file" "$backup"
    echo "Backup created: $backup"
  else
    echo "Error: File '$file' not found"
    return 1
  fi
}

# Log messages with timestamps
function log() {
  local level="$1"
  local message="$2"
  local timestamp
  
  timestamp=$(date '+%Y-%m-%d %H:%M:%S')
  
  case "$level" in
    "INFO")    echo -e "[$timestamp] \033[32mINFO\033[0m: $message" ;;
    "WARN")    echo -e "[$timestamp] \033[33mWARN\033[0m: $message" ;;
    "ERROR")   echo -e "[$timestamp] \033[31mERROR\033[0m: $message" ;;
    "DEBUG")   
      if [[ "$DEBUG" == "true" ]]; then
        echo -e "[$timestamp] \033[36mDEBUG\033[0m: $message"
      fi
      ;;
    *)         echo -e "[$timestamp] $message" ;;
  esac
}

# Check if script is run as root
function check_root() {
  if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" 
    exit 1
  fi
}

# Set up trap for cleanup
function setup_trap() {
  local func="$1"
  trap "$func" EXIT INT TERM
}

# Cleanup function template
function cleanup() {
  # Remove temporary files
  if [[ -n "$TEMP_FILES" ]]; then
    rm -f "${TEMP_FILES[@]}"
  fi
  
  # Other cleanup tasks
  echo "Cleanup complete"
}

# Check exit status and handle errors
function check_exit() {
  local status="$1"
  local message="$2"
  
  if [[ $status -ne 0 ]]; then
    echo "Error: $message (status: $status)"
    exit $status
  fi
}

# Wait for a file to exist
function wait_for_file() {
  local file="$1"
  local timeout="${2:-30}"
  local interval="${3:-1}"
  local elapsed=0
  
  while [[ ! -f "$file" && $elapsed -lt $timeout ]]; do
    sleep $interval
    elapsed=$((elapsed + interval))
  done
  
  if [[ ! -f "$file" ]]; then
    echo "Timeout waiting for file: $file"
    return 1
  fi
  
  return 0
}

# Simple spinner for long-running tasks
function show_spinner() {
  local pid="$1"
  local message="${2:-Loading...}"
  local delay="${3:-0.1}"
  local spinstr='|/-\'
  
  while ps -p $pid > /dev/null; do
    local temp=${spinstr#?}
    printf "\r%s %c" "$message" "$spinstr"
    spinstr=$temp${spinstr%"$temp"}
    sleep $delay
  done
  
  printf "\r%s Done!    \n" "$message"
}

# Run a command with timeout
function run_with_timeout() {
  local timeout="$1"
  shift
  local cmd=("$@")
  
  (
    eval "${cmd[@]}" &
    local cmd_pid=$!
    
    (
      sleep $timeout
      kill $cmd_pid 2> /dev/null
    ) &
    local timeout_pid=$!
    
    wait $cmd_pid
    local cmd_status=$?
    
    kill $timeout_pid 2> /dev/null
    
    return $cmd_status
  )
}

# Export variables safely with values that might contain special characters
function export_safe() {
  local name="$1"
  local value="$2"
  
  # Escape special characters in the value
  value="${value//\\/\\\\}"
  value="${value//\"/\\\"}"
  
  eval "export $name=\"$value\""
}

# URL encode a string
function urlencode() {
  local string="$1"
  local length="${#string}"
  local encoded=""
  
  for (( i = 0; i < length; i++ )); do
    local c="${string:i:1}"
    case "$c" in
      [a-zA-Z0-9.~_-]) encoded+="$c" ;;
      *) printf -v hex '%%%02X' "'$c"
         encoded+="$hex" ;;
    esac
  done
  
  echo "$encoded"
}

# URL decode a string
function urldecode() {
  local encoded="$1"
  local decoded=""
  
  # Use printf to decode URL-encoded string
  printf -v decoded '%b' "${encoded//%/\\x}"
  echo "$decoded"
}

# Parse JSON using jq if available, otherwise fallback
function parse_json() {
  local json="$1"
  local key="$2"
  
  if command_exists jq; then
    echo "$json" | jq -r "$key"
  else
    # Simple fallback for basic cases
    echo "$json" | grep -o "\"$key\":[^,}]*" | cut -d':' -f2 | tr -d '"' | tr -d ' '
  fi
}

# Validate IP address
function is_valid_ip() {
  local ip="$1"
  local regex='^([0-9]{1,3}\.){3}[0-9]{1,3}$'
  
  if [[ ! $ip =~ $regex ]]; then
    return 1
  fi
  
  IFS='.' read -ra OCTET <<< "$ip"
  for oct in "${OCTET[@]}"; do
    if [[ $oct -gt 255 ]]; then
      return 1
    fi
  done
  
  return 0
}

# Generate a random string
function random_string() {
  local length="${1:-16}"
  local chars="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
  local result=""
  
  for (( i = 0; i < length; i++ )); do
    local pos=$((RANDOM % ${#chars}))
    result+="${chars:pos:1}"
  done
  
  echo "$result"
}

# Check if port is in use
function is_port_in_use() {
  local port="$1"
  netstat -tuln | grep -q ":$port "
}

# Find available port starting from a given number
function find_available_port() {
  local start_port="${1:-8000}"
  local port=$start_port
  
  while is_port_in_use $port; do
    port=$((port + 1))
  done
  
  echo $port
}

# Check OS type
function get_os() {
  case "$(uname -s)" in
    Linux*)     echo "Linux" ;;
    Darwin*)    echo "MacOS" ;;
    CYGWIN*)    echo "Cygwin" ;;
    MINGW*)     echo "MinGw" ;;
    MSYS*)      echo "MSYS" ;;
    *)          echo "Unknown" ;;
  esac
}

# Normalize path (resolve symbolic links and remove double slashes)
function normalize_path() {
  local path="$1"
  local result
  
  # Resolve path
  result="$(cd "$(dirname "$path")" 2>/dev/null && pwd)/$(basename "$path")"
  
  # If path doesn't exist, just clean it up
  if [[ $? -ne 0 ]]; then
    result="$(echo "$path" | sed 's#//*#/#g')"
  fi
  
  echo "$result"
}

#
# Common environment variables
#

# Set default values for variables if not already set
: "${DEBUG:=false}"
: "${VERBOSE:=false}"
: "${TEMP_DIR:=/tmp}"
: "${LOG_FILE:=/tmp/script.log}"

# Example usage of special parameters
# $1, $2, ... - Positional parameters
# $# - Number of positional parameters
# $* - All positional parameters as a single word
# $@ - All positional parameters as separate words
# $? - Exit status of the most recently executed command
# $$ - Process ID of the current shell
# $! - Process ID of the most recently executed background command
# $0 - Name of the script

