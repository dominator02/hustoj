iptables -D OUTPUT -m owner --uid-owner 1536 -j DROP
cd /home/judge

apt-get -y install libmysql++-dev python3 python3-pip redis-server systemd python-dev libxml2-dev libxslt1-dev zlib1g-dev

pip3 install -U pip -i https://pypi.douban.com/simple/

cp src/install/onlineTestNginx.conf /etc/nginx/sites-available
cp src/install/daphne.service /etc/systemd/system/
cp src/install/runworker.service /etc/systemd/system/

cp -r src/onlineTest /home/judge
chown -R judge:judge /home/judge/onlineTest

cd /home/judge/onlineTest

# 不这样pip版本还是旧的
echo "pip3 install -i https://pypi.douban.com/simple/ python-docx" | bash
echo "pip3 install -i https://pypi.douban.com/simple/ xlwt" | bash
echo "pip3 install django==1.9.9 -i https://pypi.douban.com/simple/" | bash
echo "pip3 install pymysql -i https://pypi.douban.com/simple/" | bash
echo "pip3 install -i https://pypi.douban.com/simple/ channels==1.1.8" | bash
echo "pip3 install -i https://pypi.douban.com/simple/ asgi_redis" | bash

mkdir -r /home/judge/log

python3 manage.py makemigrations
python3 manage.py migrate
python3 manage.py loaddata init_data.json
python3 manage.py createsuperuser
python3 manage.py collectstatic

chown -R judge:judge /home/judge/log

ln -s /etc/nginx/sites-available/onlineTestNginx.conf /etc/nginx/sites-enabled/
rm /etc/nginx/sites-enabled/default

systemctl enable /etc/systemd/system/daphne.service
systemctl enable /etc/systemd/system/runworker.service

service systemd restart
service nginx restart

service php5-fpm stop
service memcached stop
