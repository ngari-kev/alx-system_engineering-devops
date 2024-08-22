# 0x1A-application_server

<img src="https://s3.amazonaws.com/alx-intranet.hbtn.io/uploads/medias/2018/9/c7d1ed0a2e10d1b4e9b3.jpg?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIARDDGGGOUSBVO6H7D%2F20240822%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240822T095425Z&X-Amz-Expires=86400&X-Amz-SignedHeaders=host&X-Amz-Signature=bd886e5aa02e76e64452b44401f5a71cd08e0f7f5ab5f2041975711f1cbf169d">

## Resources

Read or watch:

- [Application server vs web server](https://intranet.alxswe.com/rltoken/meOqLRoAcbQENYWfzui7OQ)
- [How to Serve a Flask Application with Gunicorn and Nginx on Ubuntu 16.04](https://intranet.alxswe.com/rltoken/kpG6RwmwRJHzRmGUM_ERcA) (As mentioned in the video, do not install Gunicorn using virtualenv, just install everything globally)
- [Running Gunicorn](https://intranet.alxswe.com/rltoken/2LF1j7xKJGYaUtD1HKgUeQ)
- [Be careful with the way Flask manages slash](https://intranet.alxswe.com/rltoken/zTCSTQxrH2za4hxbkt8K3g) in [route](https://intranet.alxswe.com/rltoken/n5A0nmah-Si78zbNvdb4GA) - `strict_slashes`
- [Upstart documentation](https://intranet.alxswe.com/rltoken/cldrneY3Qr7LlDysygzRHw)

## Tasks

### 0.Set up development with Python

Let’s serve what you built for [AirBnB clone v2 - Web framework](https://github.com/ngari-kev/AirBnB_clone_v2/tree/master/web_flask) on `web-01`. This task is an exercise in setting up your development environment, which is used for testing and debugging your code before deploying it to production.

Requirements:

- Make sure that task #3 of your SSH project is completed for web-01. The checker will connect to your servers.
- Install the net-tools package on your server: sudo apt install -y net-tools
- Git clone your AirBnB_clone_v2 on your web-01 server.
- Configure the file web_flask/0-hello_route.py to serve its content from the route /airbnb-onepage/ on port 5000.
- Your Flask application object must be named app (This will allow us to run and check your code).

Example:

- Window 1:

```bash
ubuntu@229-web-01:~/AirBnB_clone_v2$ python3 -m web_flask.0-hello_route
 * Serving Flask app "0-hello_route" (lazy loading)
 * Environment: production
   WARNING: Do not use the development server in a production environment.
   Use a production WSGI server instead.
 * Debug mode: off
 * Running on http://0.0.0.0:5000/ (Press CTRL+C to quit)
35.231.193.217 - - [02/May/2019 22:19:42] "GET /airbnb-onepage/ HTTP/1.1" 200 -
```

- Window 2:

```bash
ubuntu@229-web-01:~/AirBnB_clone_v2$ curl 127.0.0.1:5000/airbnb-onepage/
Hello HBNB!ubuntu@229-web-01:~/AirBnB_clone_v2$
```
