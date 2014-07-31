# dashing-oracle-samples
few samples for integrating oracle source into dashing

I have been using Dashing http://dashing.io/ with great success. It is absolutely amazingly simple framework even for non-ruby developers. Here is a simple recipe how to create jobs pulling data from Oracle database.


## Version


1.0

## Oracle Thin Client Setup

I am running centOS 6.5 64bit, bit in general this shoud work on any platform with few twists, install Oracle thin client and install ruby-oci9


  - get 3 zips (or rpms or …) from Oracle web site http://www.oracle.com/technetwork/topics/linuxx86-64soft-092277.html
  - run the install, in my case there are 3 ZIPs

```bash
cd ~
mkdir oracle
cd oracle

unzip instantclient-basic-linux.x64-12.1.0.1.0.zip
unzip instantclient-sdk-linux.x64-12.1.0.1.0.zip
unzip instantclient-sqlplus-linux.x64-12.1.0.1.0.zip
 
export ORACLE_HOME=~/oracle
export LD_LIBRARY_PATH=$ORACLE_HOME/instantclient_12_1
 
cd ~/oracle/instantclient12_1
ln -s libclntsh.so.12.1 libclntsh.so
```
 
  - setup oci9 (perhaps run few tests if you want)

```ruby
gem install ruby-oci8
```


## setup around dashing

  - install dashing (there are tons of great examples)
  - edit gem file in your dashing project and add

```ruby
require 'ruby-oci8'
```

  - setup username/password/oracle server, For simplicity I will setup UID/PSW as shell variable

```bash
export ORACLE_USER=myid
export ORACLE_PASSWORD=mypassword
export ORACLE_TNS=myoracleserver/myService
```

## create jobs
sample jobs are .... well samples. You need to at bare minimum change SQL in each sample job and place them in jobs directory

enjoy!


## License

MIT


**Free Software, Hell Yeah!**
