#!/bin/sh
set -Cefu

tm='/Library/Preferences/com.apple.TimeMachine'

tm_exclude_list() {
	defaults read $tm SkipPaths
}

tm_exclude_write() {
	sudo defaults write $tm SkipPaths -array "$@"
}

tm_exclude_load() {
	file="$1"

	eval tm_exclude_write "$(cat "$file")"
}

tm_exclude_system() {
	sudo mdfind "com_apple_backup_excludeItem = 'com.apple.backupd'"
}

tm_exclude_dump() {
	tm_exclude_list | awk '
	/\(/ { in_array=1; next }
	/^\)/ { in_array=0 }
	in_array {
		gsub(/^[ \t]+|[,)\\]+$/,"",$0)
		gsub(/^"+|"+$/,"",$0)
		printf "\"%s\"\n", $0
	}' | usort_join
}

usort_join() {
	sort -u | paste -d ' ' -s -
}

case $- in
*i*)
	set +Cefu
	return 0
esac

errmsg() {
	msg="${1:?}"

	printf "${red}error:${reset} %s\n" "$msg"
	exit 1
} >&2

checkfile() {
	file=$1

	[ -e "$file" ] || errmsg "$file: No such file or directory"
	[ -d "$file" ] && errmsg "$file: Is a directory."
	[ -r "$file" ] || errmsg "$file: Permission denied."
}

usage() {
	progname=${0##*/}
	progname="${progname%.*}"

	printf '%s\n' "usage: $progname <command> ..." "" \
		"Commands:" \
		"  list        List current exclusions" \
		"  dump        Write exclusions to output" \
		"  load <file> Load excludes from file" \
		"  system      List built-in system excludes" \

	exit 1
} >&2

main() {
	[ $# -lt 1 ] || [ $# -gt 2 ] && usage

	  cmd=${1:-}
	 file=${2:-}
	reset='\033[0m'
	  red='\033[31m'

	[ -n "$file" ] && checkfile "$file"

	case $cmd in
	list) tm_exclude_list ;;
	dump) tm_exclude_dump ;;
	load) tm_exclude_load "$file" ;;
	 sys) tm_exclude_system ;;
	   *) usage
	esac
}

main "$@"
