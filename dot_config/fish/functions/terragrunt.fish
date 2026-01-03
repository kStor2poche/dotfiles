function terragrunt
    # set to_file "/tmp/terragrunt_git_timeout"
    # if [ -e $to_file ]
    #     set last_access (grep -E ^(pwd):.[0-9]\*\$ $to_file | string split -r -m1 -f2 :)
    #     if [ -n "$last_access" ]
    #         set elapsed (math (date --utc '+%s') - $last_access)
    #         # last 5 mins after last command in same pwd
    #         sed $to_file -i -E -e "s|($(pwd | string escape --style=regex)):[0-9]*|\1:$(date --utc '+%s')|g"
    #         if [ $elapsed -ge 300 ]
    #             git remote update
    #             git status -uno
    #             echo -en "\n\nrun "; set_color -i; echo -n "terragrunt $argv"; set_color normal; echo " ? [y/anything]"
    #             read answer
    #             if [ "$answer" = "y" ]
    #                 /usr/bin/terragrunt $argv
    #                 return $status
    #             else
    #                 return 0
    #             end
    #         else
    #             /usr/bin/terragrunt $argv
    #             return $status
    #         end
    #     end
    # end
    #
    # # if no file or pwd is found in file
    # echo -n (pwd): >> $to_file
    # date --utc '+%s' >> $to_file
    #
    git remote update
    git status -uno
    echo -en "\n\nRun "; set_color -i; echo -n "terragrunt $argv"; set_color normal; echo " ? [y/anything]"
    read answer
    if [ "$answer" = "y" ]
        /usr/bin/terragrunt $argv
        return $status
    end
end
