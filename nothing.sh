checkForDir()
{
    if [[ -d $1 || -L $1 ]]
    then
        echo "It is there"
    fi
}

checkForDir $1
