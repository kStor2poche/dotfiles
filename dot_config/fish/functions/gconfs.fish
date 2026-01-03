function gconfs
    if set -q argv[1]
        gcloud config configurations activate $argv[1]
    else
        gcloud config configurations list
    end
end
