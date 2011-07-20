alias mongostart="sudo mongod -f /opt/local/etc/mongodb/mongod.conf"
mongostop_func () {

#  local mongopid=`ps -o pid,command -ax | grep mongod | awk '!/awk/ && !/grep/{print $1}'`;
#  just find a simpler way
    local mongopid=`less /opt/local/var/db/mongodb_data/mongod.lock`;
    if [[ $mongopid =~ [[:digit:]] ]]; then
        sudo kill -15 $mongopid;
        echo mongod process $mongopid terminated;
    else
        echo mongo process $mongopid not exist;
    fi
}
alias mongostop="mongostop_func"
