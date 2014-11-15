#!/bin/bash

# This Script is used for regist posix files to dCache Chimear database as HSM
# Author Yan Xiaofei 2014-09-03
# Email yanxf@ihep.ac.cn
#
#
# Usage: change SOURCE_DIR as your dcache backend storage.
#        change PNFS_DIR as your dcache mount point for backend storage.

SOURCE_DIR=/besfs/groups/grid/zhanggang
PNFS_DIR=/dcache/bes/lustre
echo -ne 'Calculating dir numbers ... \n'
dirnum=`find  ${SOURCE_DIR} -type d | wc -l`
echo -ne 'Calculating file numbers ... \n'
filnum=`find  ${SOURCE_DIR} -type f | wc -l`
dnum=0
fnum=0

echo "*******************"
echo "Making dirs ..."
for dir in `find  ${SOURCE_DIR} -type d`; do
    mkdir -p "${PNFS_DIR}${dir}"
    let dnum++
    echo -ne "($dnum)/($dirnum)" '\r'
done

echo -ne '\n'

echo "Registing files ..."
for file in `find  ${SOURCE_DIR} -type f`; do
    touch ${PNFS_DIR}${file}
    filestatF=`stat -c "%a %g %u %s" ${file}`
    imod=`echo ${filestatF}|awk '{print $1}'`
    igid=`echo ${filestatF}|awk '{print $2}'`
    iuid=`echo ${filestatF}|awk '{print $3}'`
    size=`echo ${filestatF}|awk '{print $4}'`
    fileatime=`stat -c "%x" ${file}`
    filemtime=`stat -c "%y" ${file}`
    filectime=`stat -c "%z" ${file}`
    filepath=`dirname ${PNFS_DIR}${file}`
    filename=`basename ${PNFS_DIR}${file}`
    touch ${filepath}/".(fset)(${filename})(size)(${size})"
    # set the storageinfo
    cd ${filepath}
    pnfsid=`cat ".(id)(${filename})"`
    #isum=`/opt/hsm/adler.py ${file}`
    isum=aa2b59dd
    #echo ${PNFS_DIR}${file}   $pnfsid  $isum 
    #echo "${file} imod igid iuid size fileatime filemtime filectime filepath filename"
    #echo "${file} $imod $igid $iuid $size $fileatime $filemtime $filectime $filepath $filename"
    #echo "${PNFS_DIR}${file}"
    /opt/hsm/conn_chimera.py $pnfsid $isum $file $imod $iuid $igid $fileatime $filectime $filemtime
    let fnum++
    echo -ne "($fnum)/($filnum)" '\r'
done 

echo -ne '\n'
