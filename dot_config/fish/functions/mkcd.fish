function mkcd
    mkdir $argv
    if set -q argv[2]
        echo "multiple directories created, cd'ing into the first one."
    end
    cd $argv[1]
end
