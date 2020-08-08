#!/bin/bash

clear
echo
echo "  # This script is a simple means to obtain codes per student number."
echo 

sqlite3 db.sqlite3 ".headers on" ".mode column" ".width 6 12 20" "SELECT number, pass, name FROM Student"
echo 