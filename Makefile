all: source install

source: carbon whisper graphite-web

carbon:
	git clone https://github.com/graphite-project/carbon.git
	cp Makefile.pyinstall carbon/Makefile
	cd carbon && git checkout 0.9.x
	cp carbon_setup.cfg carbon/setup.cfg
	cd carbon && $(MAKE)

whisper:
	git clone https://github.com/graphite-project/whisper.git
	cp Makefile.pyinstall whisper/Makefile
	cd whisper && git checkout 0.9.x && $(MAKE)

graphite-web:
	git clone https://github.com/graphite-project/graphite-web.git
	cp Makefile.pyinstall graphite-web/Makefile
	cd graphite-web && git checkout 0.9.x 
	cd graphite-web && $(MAKE)

clean:
	rm -rf carbon whisper graphite-web

install:
	echo Please ensure the password for mysql server root user is set to 'xun'
	cp carbon.conf /opt/graphite/conf/carbon.conf
	cp carbon_storage-schemas.conf /opt/graphite/conf/storage-schemas.conf
	cp carbon_storage-aggregation.conf /opt/graphite/conf/storage-aggregation.conf
	cp local_settings.py /opt/graphite/webapp/graphite
#       custom code to support 'batched' mode
	cp conf.py cache.py writer.py /opt/graphite/lib/carbon/
	apt-get install python-pip build-essential mysql-server libmysqlclient-dev libffi-dev python-dev libzmq-dev 
	pip install django django-tagging twisted pytz pyparsing cairocffi pyzmq mysql-python
	cat README.install
