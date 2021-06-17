# USEAGE: Save this script outside of the recently cloned folder, but run from inside: sh ../setUpstream.sh
# This script sets new local branches that track the remote release branches

rem=origin ; #// put here the name of the remote you want
mbranch=`git branch | grep -wo "main\|master"`
[ `echo $mbranch | wc -w` -ne 1 ] && echo "Error: branch error" && exit 1
git checkout $mbranch
git remote update
for brname in `git branch | grep -v $mbranch | awk '{print $1}'`; do
	git branch -D $brname
done

for brname in `git branch -r | grep $rem | grep -v $rem/$mbranch | grep -v HEAD | sed "s/  $rem\///g"`
do
	git checkout --track $rem/$brname
done

git checkout $mbranch
