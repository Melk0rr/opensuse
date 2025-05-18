# INFO: Applications
set -gx EDITOR 'nvim'
set -gx TERMINAL 'ghostty'

if status is-interactive
  # INFO: Vim keybindings
	# fish_vi_key_bindings

  # HACK: Set cursor style
  set fish_cursor_default block blink
  set fish_cursor_insert  line  blink
  set fish_cursor_visual  block
  set fish_vi_force_cursor 1

  function fish_user_key_bindings
    fish_default_key_bindings -M insert
    fish_vi_key_bindings --no-erase insert
  end
	oh-my-posh init fish --config ~/.config/oh-my-posh/omp.json | source

  #INFO: Functions
	# HACK: Fish greeting message
	function fish_greeting
	end

	# HACK: Print fish history
	function history
		builtin history --show-time='%F %T'
	end

  # HACK: Last history events
	function histop
		history | awk '{print $2}' | sort | uniq -c | sort -nr | head -10
	end

	# HACK: Clear fish history
	function clear-fish-history
		echo 'Clearing fish history...'
		rm -fv ~/.local/share/fish/fish_history
		sudo rm -fv /root/.local/share/fish/fish_history
		rm -fv ~/.config/fish/fish_history
		sudo rm -fv /root/.config/fish/fish_history
	end

	# HACK: Empty trash directories
	function empty-trash
		echo 'Emptying trash...'
		
		# Global trash
		rm -rfv ~/.local/share/Trash/*
		sudo rm -rfv /root/.local/share/Trash/*
	end

	# HACK: Clear temporary files
	function clear-temp
		echo 'Clearing temporary files...'
		sudo rm -rfv /tmp/*
		sudo rm -rfv /var/tmp/*
	end

	# HACK: Clear crash reports
	function clear-crash-reports
		echo 'Clearing crash reports...'
		sudo rm -rfv /var/crash/*
		sudo rm -rfv /var/lib/systemd/coredump/
	end

	# HACK: Clear system logs
	function clear-syslogs
		echo 'Clearing system logs...'
		if ! command -v 'journalctl' &> /dev/null
			echo 'Skipping because journalctl was not found'
		else
			sudo journalctl --vacuum-time=1s
		end

		sudo rm -rfv /run/log/journal/*
		sudo rm -rfv /var/log/journal/*
	end

	# INFO: Combined cleanup
	function cleanup
		empty-trash
		clear-temp
		clear-crash-reports
		clear-syslogs
	end

	# HACK: Create a backup of the given file
	function backup-file --argument filename
		sudo cp $filename $filename.bak
	end

	# HACK: Copy file
	function copy
		set count (count $argv | tr -d \n)
		if test "$count" = 2; and test -d "$argv[1]"
			set from (echo $argv[1] | trim-right /)
			set to (echo $argv[2])
			command cp -r $from $to
		else
			command cp $argv
		end
	end

  # INFO: Aliases & Abbreviations
	alias grep='grep --color'
	abbr install-date 'stat -c %w / | cut -b 1-16'

	abbr ff 'fastfetch'

	# NOTE: Process and journals
	abbr psa 'ps auxf'
	abbr psmem 'ps auxf | sort -nr -k 4'
	abbr pscpu 'ps auxf | sort -nr -k 3'
	abbr jctl 'journalctl -p 3 -xb'

	# NOTE: LS
	alias ls='eza -la --color=always --group-directories-first --icons'
	alias la='eza -a --color=always --group-directories-first --icons'
	alias ll='eza -l --color=always --group-directories-first --icons'
	alias lt='eza -aT --color=always --group-directories-first --icons'

	# NOTE: Zypper
  abbr za 'sudo zypper in'
  abbr zc 'sudo zypper cc'
  abbr zi 'sudo zypper se -i'
  abbr zr 'sudo zypper rm'
  abbr zs 'sudo zypper se'
	abbr zu 'sudo zypper ref && sudo zypper up'
	abbr zU 'sudo zypper dup'

  # NOTE: DNS
	abbr dnstls-opt 'sudo sed -i "/^DNSOverTLS=/c\DNSOverTLS=opportunistic" /etc/systemd/resolved.conf; sudo systemctl restart systemd-resolved'
	abbr dnstls-yes 'sudo sed -i "/^DNSOverTLS=/c\DNSOverTLS=yes" /etc/systemd/resolved.conf; sudo systemctl restart systemd-resolved'

	# NOTE: Rclone
	abbr rcc 'rclone copy'

	# NOTE: Git & dev
	abbr gcl 'git clone'
	abbr gcm 'git commit -m'
	abbr ga 'git add'
	abbr gaa 'git add --all'
	abbr gs 'git status'
	abbr gst 'git stash'
	abbr gp 'git push'
	abbr gpl 'git pull'
	abbr gdi 'git diff'
	abbr gmr 'git merge'
	abbr gco 'git checkout'
	abbr gb 'git branch'
	abbr gre 'git rebase'
        abbr gra 'git remote add origin'

	alias py='python3'


	# NOTE: Zoxide
	zoxide init --cmd cd fish | source
end

