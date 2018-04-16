#!/bin/sh

sudo yum -y remove ruby
sudo yum update
sudo systemctl stop firewalld
sudo systemctl mask firewalld

sudo yum install -y git vim
# rubyのインストールに必要なパッケージをインストール
sudo yum install -y bzip2 gcc gcc-c++ openssl-devel readline-devel zlib-devel
sudo yum install -y epel-release
sudo yum install -y nodejs --enablerepo=epel

# maria -> mysql
yum remove -y mariadb-libs
rm -rf /var/lib/mysql/
sudo yum -y localinstall http://dev.mysql.com/get/mysql57-community-release-el7-7.noarch.rpm
sudo yum -y install mysql mysql-devel mysql-server mysql-utilities
sudo systemctl start mysqld
sudo systemctl enable mysqld.service
# password: grep password /var/log/mysqld.log
# mysql -u root -p
# uninstall plugin validate_password;
# set password = password('root');
# create user 'vagrant' identified by 'vagrant'
# grant all on *.* to vagrant;
# ADD TO GEM: gem 'mysql2', '~> 0.3.20'

#sqlite
sudo yum install -y sqlite-devel

# rbenv
if [ ! -e '/home/vagrant/.rbenv' ]; then
  source ~/.bashrc
  git clone git://github.com/sstephenson/rbenv.git .rbenv
  git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
  echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
fi
if [ ! -e '/home/vagrant/.rbenv/plugins/ruby-build' ]; then
  source ~/.bash_profile
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
  rbenv install -f 2.4.4
  rbenv global 2.4.4

  rbenv exec gem install bundler
  rbenv rehash
  gem install rails -v '5.1.4'
fi
