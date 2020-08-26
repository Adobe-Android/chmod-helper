#!/bin/sh

clear_tty()
{
  clear >"$(tty)"
}

exit_0()
{
  exit 0
}

fancy_exit()
{
  clear_tty
  echo "You never were good at following instructions, were you?"
  echo "Exiting..."
  exit 0
}

get_help()
{
  help="Usage: ch\nOptions:\n--help, -help, or -h displays this information.\n--version, -version, or -v displays ch version information.\n\nch does not support any options other than those shown here."
}

get_version()
{
  version="ch version 0.1"
}

compute_special()
{
  # Special permissions
  case $su in
  "x" | "X")
    chmod=$((chmod+4000))
    
    case "$(echo $ucs | cut -c 3)" in
    "x")
      ucs="$(echo $ucs | cut -c 1-2)"
      ucs="$ucs""s";;
    "-")
      ucs="$(echo $ucs | cut -c 1-2)"
      ucs="$ucs""S";;
    esac;;
  '' | ' ')
    su=" "
    chmod=$chmod;;
  *)
    fancy_exit
  esac

  case $sg in
  "x" | "X")
    chmod=$((chmod+2000))

    case "$(echo $gcs | cut -c 3)" in
    "x")
      gcs="$(echo $gcs | cut -c 1-2)"
      gcs="$gcs""s";;
    "-")
      gcs="$(echo $gcs | cut -c 1-2)"
      gcs="$gcs""S";;
    esac;;
  '' | ' ')
    sg=" "
    chmod=$chmod;;
  *)
    fancy_exit
  esac

  case $sb in
  "x" | "X")
    chmod=$((chmod+1000))

    case "$(echo $ocs | cut -c 3)" in
    "x")
      ocs="$(echo $ocs | cut -c 1-2)"
      ocs="$ocs""t";;
    "-")
      ocs="$(echo $ocs | cut -c 1-2)"
      ocs="$ocs""T";;
    esac;;
  '' | ' ')
    sb=" "
    chmod=$chmod;;
  *)
    fancy_exit
  esac
}

compute_owner()
{
  # Owner permissions
  ucs=""
  case $ur in
  "x" | "X")
    ucs="$ucs""r"
    chmod=$((chmod+400));;
  '' | ' ')
    ucs="$ucs""-"
    ur=" "
    chmod=$chmod;;
  *)
    fancy_exit
  esac

  case $uw in
  "x" | "X")
    ucs="$ucs""w"
    chmod=$((chmod+200));;
  '' | ' ')
    ucs="$ucs""-"
    uw=" "
    chmod=$chmod;;
  *)
    fancy_exit
  esac

  case $ue in
  "x" | "X")
    ucs="$ucs""x"
    chmod=$((chmod+100));;
  '' | ' ')
    ucs="$ucs""-"
    ue=" "
    chmod=$chmod;;
  *)
    fancy_exit
  esac
}

compute_group()
{
  # Group permissions
  gcs=""
  case $gr in
  "x" | "X")
    gcs="$gcs""r"
    chmod=$((chmod+40));;
  '' | ' ')
    gcs="$gcs""-"
    gr=" "
    chmod=$chmod;;
  *)
    fancy_exit
  esac

  case $gw in
  "x" | "X")
    gcs="$gcs""w"
    chmod=$((chmod+20));;
  '' | ' ')
    gcs="$gcs""-"
    gw=" "
    chmod=$chmod;;
  *)
    fancy_exit
  esac

  case $ge in
  "x" | "X")
    gcs="$gcs""x"
    chmod=$((chmod+10));;
  '' | ' ')
    gcs="$gcs""-"
    ge=" "
    chmod=$chmod;;
  *)
    fancy_exit
  esac
}

compute_other()
{
  # Other permissions
  ocs=""
  case $or in
  "x" | "X")
    ocs="$ocs""r"
    chmod=$((chmod+4));;
  '' | ' ')
    ocs="$ocs""-"
    or=" "
    chmod=$chmod;;
  *)
    fancy_exit
  esac

  case $ow in
  "x" | "X")
    ocs="$ocs""w"
    chmod=$((chmod+2));;
  '' | ' ')
    ocs="$ocs""-"
    ow=" "
    chmod=$chmod;;
  *)
    fancy_exit
  esac

  case $oe in
  "x" | "X")
    ocs="$ocs""x"
    chmod=$((chmod+1));;
  '' | ' ')
    ocs="$ocs""-"
    oe=" "
    chmod=$chmod;;
  *)
    fancy_exit
  esac
}

main()
{
  echo "___________________________________________"
  echo "|         Welcome to chmod-helper         |"
  echo "-------------------------------------------"
  echo "| Owner(u)    | Group(g)    | Other(o)    |"
  echo "|  Read    [] |  Read    [] |  Read    [] |"
  echo "|  Write   [] |  Write   [] |  Write   [] |"
  echo "|  Execute [] |  Execute [] |  Execute [] |"
  echo "-------------------------------------------"
  echo "Type x to set the permission."
  echo "Leave it blank to skip."
  echo "Then hit Enter."
  printf 'Owner(u) Read: '
  read -r ur
  printf 'Owner(u) Write: '
  read -r uw
  printf 'Owner(u) Execute: '
  read -r ue
  # Other chmod symbol, Owner(u) Read, Write, Execute
  compute_owner "$chmod" "$ucs" "$ur" "$uw" "$ue"
  printf 'Group(g) Read: '
  read -r gr
  printf 'Group(g) Write: '
  read -r gw
  printf 'Group(g) Execute: '
  read -r ge
  # Group chmod symbol, Group(g) Read, Write, Execute
  compute_group "$chmod" "$gcs" "$gr" "$gw" "$ge"
  printf 'Other(o) Read: '
  read -r or
  printf 'Other(o) Write: '
  read -r ow
  printf 'Other(o) Execute: '
  read -r oe
  # Other chmod symbol, Other(o) Read, Write, Execute
  compute_other "$chmod" "$ocs" "$or" "$ow" "$oe"
  printf 'Setuid: '
  read -r su
  printf 'Setgid: '
  read -r sg
  printf 'Sticky Bit: '
  read -r sb
  compute_special "$chmod" "$scs" "$su" "$sg" "$sb" "$ucs" $"$gcs" "$ocs"
  clear_tty
  # Prepend x character y times
  echo "______________________________________________"
  printf "|                 chmod %03d                 |\n" $chmod
  echo "|                 $ucs$gcs$ocs                  |"
  echo "----------------------------------------------"
  echo "| Owner(u)     | Group(g)     | Other(o)     |"
  echo "|  Read    [$ur] |  Read    [$gr] |  Read    [$or] |"
  echo "|  Write   [$uw] |  Write   [$gw] |  Write   [$ow] |"
  echo "|  Execute [$ue] |  Execute [$ge] |  Execute [$oe] |"
  echo "----------------------------------------------"  
}

case $1 in
  '')
    main;;
  "--version" | "-version" | "version" | "-v")
    get_version
    echo "$version"
    exit_0;;
  "--help" | "-help" | "help" |"-h")
    get_help
    echo "$help"
    exit_0;;
  *)
    printf "ch: invalid option\nuse 'ch --help' to show valid options.\n"
    exit_0
esac