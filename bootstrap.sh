#!/usr/bin/env zsh

source ./scripts/init
source ./scripts/brew
source ./scripts/app_store
source ./scripts/brew_cask
source ./scripts/preferences
source ./scripts/customizes

cp -r ./home/ ~

git clone https://github.com/ecleya/dotfiles.git ~/Projects/dotfiles

mkdir -p ~/Projects
ln -s ~/Projects/dotfiles/apps/vscode ~/Library/Application\ Support/Code/User

mkdir -p ~/.config
ln -s ~/Projects/dotfiles/apps/karabiner ~/.config/karabiner

# Claude Code 공용 설정 심링크
mkdir -p ~/.claude
ln -sf ~/Projects/dotfiles/home/.claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -sf ~/Projects/dotfiles/home/.claude/skills ~/.claude/skills

# cron 등록: 매일 22시 dev-runner 실행
(crontab -l 2>/dev/null | grep -v dev-runner.sh; echo "0 22 * * * /Users/ecleya/Projects/dotfiles/scripts/dev-runner.sh >> ~/.claude/dev-runner.log 2>&1") | crontab -

# Done
echo "Done. Note that some of these changes require a logout/restart to take effect."
