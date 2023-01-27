#!/bin/sh
sed 's/<user_password>.*<\/user_password>/<user_password>newpassword<\/user_password>/g' $1