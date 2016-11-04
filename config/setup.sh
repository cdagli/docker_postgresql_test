# These tasks are run as root
CONF="/etc/postgresql/9.5/main/postgresql.conf"

# CE Instance Communication
echo "local    all             all                         trust" > /etc/postgresql/9.5/main/pg_hba.conf
echo "host    all             all             0.0.0.0/0               trust" >> /etc/postgresql/9.5/main/pg_hba.conf

# Listen on all ip addresses
echo "listen_addresses = '*'" >> /etc/postgresql/9.5/main/postgresql.conf
echo "data_directory = '/var/database'" >> /etc/postgresql/9.5/main/postgresql.conf
echo "port = 5432" >> /etc/postgresql/9.5/main/postgresql.conf
