function nvid
    neovide --fork $argv &
    disown $last_pid
end
