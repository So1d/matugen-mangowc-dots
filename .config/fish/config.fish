if status is-interactive
    # Commands to run in interactive sessions can go here
alias zp="sudo zypper"
alias zps="sudo zypper refresh && sudo zypper dup --no-recommends"
alias call="distrobox enter"
alias sonofman="flatpak run org.hlwd.sonofman"
alias legacylauncher="java -jar /home/machado/Jogos/MinecraftLL/LegacyLauncher_legacy.jar"
alias wlm="wl-mirror eDP-1 & disown"
alias wlm-c="wl-mirror -c eDP-1 & disown"
alias fish-alias="nano .config/fish/config.fish"
alias zen='flatpak run app.zen_browser.zen'
alias waybar-reset='killall waybar && waybar & disown && exit 0'
alias tlauncher='~/Jogos/tlauncher/TLauncher.jar java -jar && exit'  
alias podman-desktop='flatpak run io.podman_desktop.PodmanDesktop'
end

function last_history_item
    echo $history[1]
end

abbr -a !! --position anywhere --function last_history_item
