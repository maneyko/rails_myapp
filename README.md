# README

To set up, install [RVM](https://rvm.io/rvm/install), and create postgres databases.

Most of the initial setup was done follwing these tutorials from Digital Ocean:
* [How To Deploy a Rails App with Unicorn and Nginx on Ubuntu 14.04](https://www.digitalocean.com/community/tutorials/how-to-deploy-a-rails-app-with-unicorn-and-nginx-on-ubuntu-14-04)
* [How To Deploy a Rails App with Puma and Nginx on Ubuntu 14.04](https://www.digitalocean.com/community/tutorials/how-to-deploy-a-rails-app-with-puma-and-nginx-on-ubuntu-14-04)
* [How To Use PostgreSQL with Your Ruby on Rails Application on Ubuntu 18.04](https://www.digitalocean.com/community/tutorials/how-to-use-postgresql-with-your-ruby-on-rails-application-on-ubuntu-18-04)

To install all the gems, run:

```bash
bundle
```

To setup PostgreSQL on Ubuntu, do these commands:
```bash
sudo -u postgres createuser -s rails_myapp

# Go into postgres console
sudo -u postgres psql
```

Set up a password for the user in the postgres console:

```
postgres=# \password rails_myapp
```

Now add the password into the repo root `.env` file:

```bash
password="my_secret_password"
echo "DB_PASSWORD=$password" >> .env
```

Then setup the databases:

```bash
rails db:setup
rails db:setup RAILS_ENV=production
```

Create the script that will be in `/etc/init.d`:

```bash
sudo ln -s /etc/init.d/puma_rails_myapp config/puma_init.sh

sudo update-rc.d puma_rails_myapp defaults
systemctl daemon-reload

sudo service puma_rails_myapp restart
```

Set up NGINX (perform from inside the project git repo):

```bash
repo_root="$(git rev-parse --show-toplevel)"
sudo ln -s "${repo_root}/config/nginx.conf" /etc/nginx/sites-available/rails_myapp.conf
sudo ln -s /etc/nginx/sites-available/rails_myapp.conf /etc/nginx/site-enabled/rails_myapp.conf
sudo ln -s "$repo_root" /var/www/

sudo service nginx restart
```

Generate a secret key:

```bash
key="$(rake secret RAILS_ENV=production)"
echo "SECRET_KEY_BASE=$key >> .env"
```
