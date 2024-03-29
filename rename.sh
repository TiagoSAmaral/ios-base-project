#!/bin/bash

#Support to SED
export LC_CTYPE=C
export LANG=C

ORIGINAL_NAME="ios-base-project"
ORIGINAL_NAME_FILE="ios-base-project.xcodeproj"
ORIGINAL_BUNDLE_ID="com.domain-developer"
ORIGINAL_ORG_NAME="developer_organization_name"
IS_YES="y"

echo "Before any configuration setup the correct name of project."
echo "You can cancel the process pressioning 'CTRL + C'. If you make a mistake, dont worry, run the command: 'git checkout .' and try again!"

# Prompt by new name of project
echo "Type new name to project (Not use space, special characters, character '@' and accented letters!!!):"
read -p "New name: " NEWNAME

# Prompt by new bundle identifier
echo "Type new bundle identifier. This is like your e-mail, but inverted. (Not use space or special characters or accented letters!!!):"
echo "example: com.mydomain-my.name"
read -p "New bundle identifier: " NEW_BUNDLE_IDENTIFIER

# Prompt by new name organization
echo "Type the organization name (Not use space or special characters or accented letters!!!):"
echo "example: My business"
read -p "New organization name: " NEW_ORG_NAME

#Rename the name of project
find . -type f -not -path "*git/*" ! -name 'rename.sh' -print0 | xargs -0 sed -i ""  "s/$ORIGINAL_NAME/$NEWNAME/g"

#Rename the BUNDLE ID
find . -type f -not -path "*git/*" ! -name 'rename.sh' -print0 | xargs -0 sed -i ""  "s/$ORIGINAL_BUNDLE_ID/$NEW_BUNDLE_IDENTIFIER/g"

#Rename Organization Name
find . -type f -not -path "*git/*" ! -name 'rename.sh' -print0 | xargs -0 sed -i ""  "s/$ORIGINAL_ORG_NAME/$NEW_ORG_NAME/g"

# Rename file of project with new name.
mv $ORIGINAL_NAME_FILE "$NEWNAME.xcodeproj"

#Rename root folder of project 
find . -depth -type d -name <$ORIGINAL_NAME> -execdir mv {} <$NEWNAME> \;

# Update git remote URL

Show list of current URL remote repository
function show_current_git_remote_url() {
    printf "This is the current ORIGIN URL of folder: \n\n"
    git remote -v
}

show_current_git_remote_url

printf "\n"
echo "Do you want update this URL?"
read -p "Update url? (y/n)" IS_TO_UPDATE_GIT_REMOTE_URL

# Dialog to update remote repository URL
if [ $IS_TO_UPDATE_GIT_REMOTE_URL = $IS_YES ]
then
    read -p "Enter the new valid URL: " URL_GIT_REMOTE
    git remote set-url origin $URL_GIT_REMOTE

    show_current_git_remote_url
    printf "\n\nDone! After finish setup, commit the changes and push!."
fi
 
# Rename the current directory.
mv ../{$ORIGINAL_NAME,$NEWNAME}

printf "THIS IS IMPORTANT!!! CLOSE THE CURRENT TERMINAL AND OPEN THE NEW FOLDER OF PROJECT!"
printf "\n\nCongratulations! Finish the inital setup. Go ahead to Readme file.\n\m"