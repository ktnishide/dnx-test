To run this server locally, run as follows:

```bash
$ dotnet run --project AppDotNet.csproj
```

To build docker image, run as follows:

```bash
$ docker build -t <image name> .  
```

To run docker image, run as follows:

```bash
$ docker run --publish 8000:80 <image name>
```

Swagger url:
```
http://localhost:8000/swagger/index.html
```

