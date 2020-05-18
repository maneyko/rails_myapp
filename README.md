# README

To set up, install [RVM](https://rvm.io/rvm/install), and create postgres databases.

Most of the initial setup was done follwing these tutorials from Digital Ocean:
* <https://www.digitalocean.com/community/tutorials/how-to-deploy-a-rails-app-with-unicorn-and-nginx-on-ubuntu-14-04>
* <https://www.digitalocean.com/community/tutorials/how-to-use-postgresql-with-your-ruby-on-rails-application-on-ubuntu-18-04>

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
sudo ln -s /etc/init.d/unicorn_rails_myapp config/unicorn_init

sudo update-rc.d unicorn_rails_myapp defaults

# You may need to run this twice
sudo service unicorn_rails_myapp restart
```

Set up NGINX (perform from inside the project git repo):

```bash
repo_root="$(git rev-parse --show-toplevel)"
sudo ln -s /etc/nginx/sites-available/rails_myapp.conf "${repo_root}/config/nginx.conf"
sudo ln -s /etc/nginx/sites-available/rails_myapp.conf /etc/nginx/site-enabled/rails_myapp.conf
sudo ln -s "$repo_root" /var/www/

sudo service nginx restart
```

Generate a secret key:

```bash
key="$(rake secret RAILS_ENV=production)"
echo "SECRET_KEY_BASE=$key >> .env"
```
