A simple Dart HTTP server using [package:shelf](https://pub.dev/packages/shelf).

- Listens on "any IP" (0.0.0.0) instead of loop-back (localhost, 127.0.0.1) to
  allow remote connections.
- Defaults to listening on port `8000`, but this can be configured by setting
  the `PORT` environment variable. (This is also the convention used by
  [Cloud Run](https://cloud.google.com/run).)
- Includes `Dockerfile` for easy containerization

To deploy on [Cloud Run](https://cloud.google.com/run), follow
[these instructions](https://cloud.google.com/run/docs/quickstarts/build-and-deploy/other).

To run this server locally, run as follows:

```bash
$ dart run lib/server.dart
```


To run server tests locally, run as follows:

```bash
$ dart test
```

To build docker image, run as follows:

```bash
$ docker build -t <image name> .  
```

To run docker image, run as follows:

```bash
$ docker run --publish 8000:8000 bubble
```

Curl call examples:

post order
```bash
$ curl -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "store_number=1&order_number=1&flavours=brown sugar&toppings=tapioca pearls&amount_of_ice=Full&total_order_price=50.99" http://localhost:8000/order/
```

get report
```bash
$ curl -X GET http://localhost:8000/order/report?monthYear=2021-09
```