#!/usr/bin/env bash

yum clean all
yum -y update
yum -y install rpm-build make createrepo tree

mkdir -p ~/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}

zip -r package-repository.zip /package-repository

mv package-repository.zip ~/rpmbuild/SOURCES/
cp /package-repository/package-repository.spec ~/rpmbuild/SPECS/

cd ~/rpmbuild/SOURCES/
unzip package-repository.zip

rpmbuild -ba ~/rpmbuild/SPECS/package-repository.spec --define "_release $1"

[ -d /package-repository/build ] || mkdir /package-repository/build
[ -d /package-repository/build/source-packages ] || mkdir /package-repository/build/source-packages
[ -d /package-repository/build/source-packages/$2 ] || mkdir /package-repository/build/source-packages/$2
[ -d /package-repository/build/source-packages/$2/$3 ] || mkdir /package-repository/build/source-packages/$2/$3
[ -d /package-repository/build/source-packages/$2/$3/no-arch ] || mkdir /package-repository/build/source-packages/$2/$3/no-arch
[ -d /package-repository/build/$2 ] || mkdir /package-repository/build/$2
[ -d /package-repository/build/$2/$3 ] || mkdir /package-repository/build/$2/$3
[ -d /package-repository/build/$2/$3/no-arch ] || mkdir /package-repository/build/$2/$3/no-arch

for a in ~/rpmbuild/RPMS/noarch ; do createrepo -v --deltas $a/ ; done

cp -r ~/rpmbuild/SRPMS/noarch/* /package-repository/build/source-packages/$2/$3/no-arch
cp -r ~/rpmbuild/RPMS/noarch/* /package-repository/build/$2/$3/no-arch
