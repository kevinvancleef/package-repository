%define deployuser root
%define deployusergroup root

# Define the name of the RPM package
%define pkgname package-repository

Name:           %{pkgname}
Version:        0.1
Release:        %{_release}
Summary:        www.developmentstudio.nl

Group:          Applications/Internet
License:        Proprietary
URL:            http://www.developmentstudio.nl
Source0:        package-repository.zip
BuildRoot:      %{_tmppath}
BuildArch:      noarch

%description
The Development Studio package repository.

%prep
%setup -n %{pkgname}
exit 0

%install
rm -rf $RPM_BUILD_ROOT
install -d $RPM_BUILD_ROOT%{_sysconfdir}/yum.repos.d
cp -a ./development-studio.repo $RPM_BUILD_ROOT%{_sysconfdir}/yum.repos.d/development-studio.repo

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-, %{deployuser}, %{deployusergroup})
/etc/yum.repos.d/development-studio.repo

%changelog
* Mon Jul 10 2017 Kevin van Cleef <kevin@developmentstudio.nl> - 0.1-%{release}
- Initial package specification of development studio package repository.
