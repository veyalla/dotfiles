# After running Erlang CT tests it's often necessary to navigate into a ct_run
# run directory and inspect the files that were left by the tests. All the
# ct_run directories are typically stored in the logs/ directory and are named
# with the pattern ct_run.<app>@<host>.<time>. We need to always find the
# directory with the highest timestamp if we want the latest one. Then we can
# `cd` to the directory.

ct_latest() {
    # Some approaches:
    #
    ## Create a symlink
    #rm logs/ct_run.latest; ln -s $(cd logs && find . -maxdepth 1 -mindepth 1 -type d | sort -r | head -1) logs/ct_run.latest
    #
    ## Does something? Someone in IRC sent this to me
    #make test install || ( find ../src/ -mmin 1 \( -name 'raw.log' -o -name 'server.log' \) -printf '%C@ %p\n' | sort -r | cut -d ' ' -f 2 | xargs cat && exit 1 )

    # If we are already in a ct_run directory `cd` to the root directory first
    if [[ "$PWD" =~ ct_run.* ]]; then
        cd ../..
    fi

    # Change to the right directory
    DIR="logs/$(cd logs && find . -name 'ct_run.*' -maxdepth 1 -mindepth 1 -type d | sort -r | head -1)"
    cd $DIR
}
