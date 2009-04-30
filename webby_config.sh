gem install rails --no-rdoc --no-ri
gem install cucumber --no-rdoc --no-ri

wget http://sphinxsearch.com/downloads/sphinx-0.9.8.1.tar.gz
tar xzf sphinx-0.9.8.1.tar.gz
cd sphinx-0.9.8.1
./configure && make && sudo make install
cd ..
rm -fR sphinx-0.9.8.1
rm sphinx-0.9.8.1.tar.gx

echo WC_DB_ENGINE=${WC_DB_ENGINE}

echo "
login: &login
  adapter: ${WC_DB_ENGINE}
  database: ${WC_APP_NAME}
  username: ${WC_APP_NAME}
  password: ${WC_DB_PASSWORD}
  host: localhost
  
" > config/database.yml
 
if [ "${WC_DB_ENGINE}" == "mysql" ]; then
echo "
production:
  <<: *login
  encoding: utf8
" >> config/database.yml
fi
 
if [ "${WC_DB_ENGINE}" == "postgresql" ]; then
echo "
production:
  <<: *login
  encoding: unicode
  pool: 5
  port: 5432
" >> config/database.yml
fi

rake install

chown www-data log