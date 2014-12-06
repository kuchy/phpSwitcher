#!/bin/bash


#
# Print help text to output.
#
function print_help {

  echo "Change brewed php version in mac os x system and set apache2 to use it."
  echo ""
  echo "Usage: switchPhp <php>"
  echo ""
  echo "<php> is the php version to activate."
  echo ""
  echo "Note: old php wil bew deactivated."
  echo ""
  echo "Example: switch 54"
  exit

}

#
# Main().
#
while getopts "h" flag
do
  case $flag in
    h) print_help;
  esac
done

if [ -z $1 ]
  then
  print_help;
fi

PHP=php$1

#TODO check if selected php version is instaled if not try to install
#TODO check if brew installed

#get path to apache libs from brew
PATH_TO_PHP=`brew list $PHP | grep libexec`

#replace loaded module with new one
sudo sed -i '.orig' 's|^LoadModule\ php5_module.*$|LoadModule\ php5_module\ '$PATH_TO_PHP'|' /etc/apache2/httpd.conf

#link new php to console
brew unlink $PHP && brew link --overwrite $PHP

#restart apache
sudo apachectl -k restart