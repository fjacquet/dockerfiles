yum install -y deltarpm firewalld policycoreutils-python zlib bzip2 openssl libxslt initscripts  logrotate && yum -y update && yum clean all
#setsebool -P nis_enabled 1
# firewall-cmd --permanent --zone=trusted --add-interface=lo
# firewall-cmd --permanent --zone=trusted --add-port=5672/tcp
# firewall-cmd --permanent --zone=trusted --add-port=4369/tcp
# firewall-cmd --permanent --add-port=8440/tcp
# firewall-cmd --reload
tar xzvf ./IBM_Spectrum_Control_Base_Edition-3.2.1-9432-x86_64.tar.gz
rpm -ivh  ./IBM_Spectrum_Control_Base_Edition-3.2.1-9432-x86_64/rhel7/*.rpm
chmod +x ./IBM_Spectrum_Control_Base_Edition-3.2.1-9432-x86_64/ibm_spectrum_control-3.2.1-9432-x86_64.bin
yes 1 | ./IBM_Spectrum_Control_Base_Edition-3.2.1-9432-x86_64/ibm_spectrum_control-3.2.1-9432-x86_64.bin
rm -rf ./IBM_Spectrum_Control_Base_Edition-3.2.1*
exit 0