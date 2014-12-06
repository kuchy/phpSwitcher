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

#TODO rebuid to delete and add new row with module not comment out
#TODO check if selected php version is instaled if not try to install
#TODO check if brew installed

#comment out active php module for apache2
sudo sed -i '' 's/^LoadModule\ php5/#LoadModule\ php5/' /etc/apache2/httpd.conf

#uncomment selected version for apache
sudo sed -i '' 's/\#LoadModule\ php5_module\ \/usr\/local\/Cellar\/'$PHP'/\LoadModule\ php5_module\ \/usr\/local\/Cellar\/'$PHP'/' /etc/apache2/httpd.conf

#link new php to console
brew unlink $PHP && brew link --overwrite $PHP

#restart apache
sudo apachectl -k restart