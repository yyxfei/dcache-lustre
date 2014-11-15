dirnum=`find /var/log -type d|wc -l`
filenum=`find /var/log -type f|wc -l`
dnum=0
fnum=0
for dir in `find /var/log -type d`
  do
    let dnum++
    echo -ne "($dnum)/($dirnum)" '\r'
    sleep 1
  done

echo -ne '\n'

for file in `find /var/log -type f`
  do
    #echo -ne "$ssss" '\r'
    let fnum++
  done
