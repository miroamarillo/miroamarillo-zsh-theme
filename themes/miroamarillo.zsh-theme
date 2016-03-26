#
# Miroamarillo ZSH Theme
#
# Author: Julian Pineda, miroamarillo.com
# License: MIT
# https://github.com/miroamarillo/miroamarillo-zsh-theme
# Credits:
# Denys Dovhan - https://github.com/denysdovhan/spaceship-zsh-theme
# Arialdo Martini - https://github.com/arialdomartini/oh-my-git

#Build Custom Prompt
build_prompt () {
	#Print Working Directory
	#local get_pwd="${PWD/$HOME/~}"
	#Get git info
	local current_commit_hash="$(git rev-parse HEAD 2> /dev/null)"
	local is_git_repo="$reset_color\uf008"
	local current_branch="[\uf020 $(current_branch)]"
	local git_status="$(git status --porcelain 2> /dev/null)"

	local number_of_untracked_files="$(\grep -c "^??" <<< "${git_status}")"
	local git_untracked="[\uf02d $number_of_untracked_files]"

	local number_of_modified="$(\grep -c " M" <<< "${git_status}")"
	local git_modified="[\uf04d $number_of_modified]"

	local number_of_added="$(\grep -c "A " <<< "${git_status}")"
	local git_added="[\uf06b $number_of_added]"

	local number_of_deleted="$(\grep -c "D " <<< "${git_status}")"
	local git_deleted="[\uf0d0 $number_of_deleted]"

	local prompt=""

	ZSH_THEME_GIT_PROMPT_DIRTY="$fg[red]"
	ZSH_THEME_GIT_PROMPT_CLEAN="$fg[green]"

	#if git repo - show relevant info in second line
	#Check that folder is a git repo
	if [[ -n $current_commit_hash ]]; then
		local is_a_git_repo=true
	fi

	if [[ $is_a_git_repo == true ]]; then
		prompt+="$fg[cyan]%m: $fg[yellow]${PWD/$HOME/~}\n"
		prompt+="$is_git_repo $(parse_git_dirty) $current_branch"
		#Modified files
		if [[ $number_of_modified -gt 0 ]]; then
			prompt+="$fg[cyan]$git_modified"
		fi
		#Untracked Files
		if [[ $number_of_untracked_files -gt 0 ]]; then
			prompt+="$fg[yellow]$git_untracked"
		fi
		#Added Files
		if [[ $number_of_added -gt 0 ]]; then
			prompt+="$fg[green]$git_added"
		fi
		#Deleted Files
		if [[ $number_of_deleted -gt 0 ]]; then
			prompt+="$fg[red]$git_deleted"
		fi
		prompt+="\n$fg[green]→ $reset_color"
	else
		prompt+="$fg[cyan]%m: $fg[yellow]${PWD/$HOME/~}\n"
		prompt+="$fg[green]→ $reset_color"
	fi

	#Print Prompt
	echo $prompt
}
#Execute Build Custom Prompt
PROMPT='$(build_prompt)'
