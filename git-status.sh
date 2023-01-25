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
    ## current_branch=$(git rev-parse --abbrev-ref HEAD)

    # Check the status of the current branch
    git_status=$(git status)

    # Print the folder name and git status in table format
    if [[ $git_status == *"Your branch is up to date"* ]]; then
        printf "%-30s %-30s\n" "$folder" "✅ Up-to-date"
    elif [[ $git_status == *"Your branch is behind"* ]]; then
        printf "%-30s %-30s\n" "$folder" "🔽 Behind Remote"
    elif [[ $git_status == *"Your branch is ahead"* ]]; then
        printf "%-30s %-30s\n" "$folder" "🔼 Ahead of Remote"
    elif [[ $git_status == *"Changes not staged for commit"* ]]; then
        printf "%-30s %-30s\n" "$folder" "💩 Changes not committed"
    else
        printf "%-30s %-30s\n" "$folder" "❓ Other Status"
    fi

    # Go back to the parent folder
    cd ..
done
