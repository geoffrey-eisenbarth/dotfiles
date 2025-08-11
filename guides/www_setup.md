# Basic NGINX config

```
> mkdir -p /var/www/example.com/html
> chown -R www-data:www-data /var/www/example.com/html
> chmod -R 755 /var/www/example.com/html
```

```
> vim /etc/nginx/sites-available/example.com

    server {
      listen 80;
      listen [::]:80;

      server_name example.com www.example.com;

      root /var/www/example.com/html;
      index index.html;

      location / {
        try_files $uri $uri/ =404;
      }
    }
```

```
> ln -s /etc/nginx/sites-available/example.com /etc/nginx/sites-enabled/
> nginx -t
> certbot --nginx -d example.com -d www.example.com
> nginx -t
> /etc/init.d/nginx restart
```
