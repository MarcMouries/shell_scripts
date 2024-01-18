#!/bin/zsh

# Print table header
printf "%-30s %-30s\n" "Folder" "Git Status"
printf "%-30s %-30s\n" "------" "----------"

# Go through each subfolder
for folder in */ ; do
    # Go into the subfolder
    cd "$folder"

    # Check if the subfolder is a git repository
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        printf "%-30s %-30s\n" "$folder" "❌ Not a git repository"
        cd ..
        continue
    fi

    # Get current branch name of the subfolder
    current_branch=$(git rev-parse --abbrev-ref HEAD)

    # Check the status of the current branch
    git_status=$(git status)

    statuses=""
    if [[ $git_status == *"Your branch is up to date"* ]]; then
        statuses+="✅ Up-to-date with remote repo"
    fi
    if [[ $git_status == *"Your branch is behind"* ]]; then
        statuses+="🔽 Behind Remote "
    fi
    if [[ $git_status == *"Your branch is ahead"* ]]; then
        statuses+="🔼 Ahead of Remote "
    fi
    if [[ $git_status == *"Changes not staged for commit"* ]]; then
        statuses+=" 💩 Changes not committed "
    fi
    if [[ $git_status == *"Untracked files"* ]]; then
        statuses+=" 🚫 Untracked files"
    fi
    if [[ -z $statuses ]]; then
        statuses="❓ Other Status"
    fi

    # Print the folder name and git status in table format
    printf "%-30s %-30s\n" "$folder" "$statuses"

    # Go back to the parent folder
    cd ..
done
