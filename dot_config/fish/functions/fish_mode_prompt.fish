function fish_mode_prompt --description 'Display vi prompt mode'
    # Do nothing if not in vi mode
    if test "$fish_key_bindings" = fish_vi_key_bindings
        or test "$fish_key_bindings" = fish_hybrid_key_bindings
        switch $fish_bind_mode
            case default
                set_color --background white
                set_color --bold black
                echo -n ' N'
                set_color normal
                set_color white
                echo '█'
            case insert
                set_color --background brblue
                set_color --bold black
                echo ' I'
                set_color normal
                set_color brblue
                echo '█'
            case replace_one
                set_color --background brpurple
                set_color --bold black
                echo ' R'
                set_color normal
                set_color brpurple
                echo '█'
            case replace
                set_color --background brred
                set_color --bold black
                echo ' R'
                set_color normal
                set_color brred
                echo '█'
            case visual
                set_color --background FE8019
                set_color --bold black
                echo ' V'
                set_color normal
                set_color FE8019
                echo '█'
        end
        set_color normal
        echo -n ' '
    end
end
