# {{- if (eq .chezmoi.os "darwin") -}}
#!/bin/bash

set -eufo pipefail

formulae=(
	autojump
	bat
	curl
	deno
	fzf
	git
	git-delta
	git-gui
	jq
	less
	nano
	nvm
	tealdeer
	wget
	yarn
	zplug
)
casks=(
	aerial
	clipy
	fig
	google-chrome
	kap
	iterm2
	visual-studio-code
)

# {{ if .work_device }}
formulae+=(
	docker
	exa
	go
	go-jira
	mitmproxy
	rancher
	TomAnthony/brews/itermocil
	x3270
)
casks+=(
	beyond-compare
	bluejeans
	hex-fiend
	microsoft-teams
	p4v
	postman
	slack
	stats
)
# {{ end }}

brew update

brew install ${formulae[@]}
brew install --cask ${casks[@]}

brew cleanup
{{ end }}
