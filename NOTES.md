### Run
In progress. See the https://github.com/piarmy/piarmy-scripts swarm directory for swarm deployment options.

# Build
clear && \
  cd /home/pi/images/piarmy-lambda && \
  docker build -t mattwiater/piarmy-lambda . && \
  docker push mattwiater/piarmy-lambda

# Interactive
docker run -it --rm -p 8002:80 mattwiater/piarmy-lambda /bin/bash
sudo thin start -p 80 -R config.ru

# Enter running container
docker exec -it $(docker ps | grep piarmy-lambda | awk '{print $1}') /bin/bash

# Scale
docker service scale piarmy_lambda=1

### Apache Benchmark Testing

#### Pi: 1 Replica

```
ab -n 10 -c 5 http://piarmy01:9999/
```

```
Concurrency Level:      5
Time taken for tests:   24.138 seconds
Complete requests:      10
Failed requests:        0
Total transferred:      1640 bytes
HTML transferred:       280 bytes
Requests per second:    0.41 [#/sec] (mean)
Time per request:       12068.781 [ms] (mean)
Time per request:       2413.756 [ms] (mean, across all concurrent requests)
Transfer rate:          0.07 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        1    3   1.0      3       4
Processing: 11731 12065 351.5  12398   12399
Waiting:     2336 11058 3082.5  11731   12398
Total:      11735 12068 350.6  12400   12401

Percentage of the requests served within a certain time (ms)
  50%  12400
  66%  12400
  75%  12400
  80%  12401
  90%  12401
  95%  12401
  98%  12401
  99%  12401
 100%  12401 (longest request)
```

-----

#### Pi: 2 Replicas

```
ab -n 10 -c 5 http://piarmy01:9999/
```

```
Document Path:          /pi
Document Length:        28 bytes

Concurrency Level:      5
Time taken for tests:   16.466 seconds
Complete requests:      10
Failed requests:        0
Total transferred:      1640 bytes
HTML transferred:       280 bytes
Requests per second:    0.61 [#/sec] (mean)
Time per request:       8233.128 [ms] (mean)
Time per request:       1646.626 [ms] (mean, across all concurrent requests)
Transfer rate:          0.10 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        1    1   0.2      1       2
Processing:  2185 6377 3597.3   7392   11978
Waiting:     2184 6376 3597.0   7391   11978
Total:       2186 6378 3597.4   7393   11980

Percentage of the requests served within a certain time (ms)
  50%   7393
  66%   9449
  75%   9450
  80%   9450
  90%  11980
  95%  11980
  98%  11980
  99%  11980
 100%  11980 (longest request)

```

-----

#### Pi: 3 Replicas

```
ab -n 10 -c 5 http://piarmy01:9999/
```

```
Document Path:          /pi
Document Length:        28 bytes

Concurrency Level:      5
Time taken for tests:   9.129 seconds
Complete requests:      10
Failed requests:        0
Total transferred:      1640 bytes
HTML transferred:       280 bytes
Requests per second:    1.10 [#/sec] (mean)
Time per request:       4564.318 [ms] (mean)
Time per request:       912.864 [ms] (mean, across all concurrent requests)
Transfer rate:          0.18 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        1    2   0.8      1       4
Processing:  2198 3745 1265.7   4339    5913
Waiting:     2198 3744 1265.5   4339    5912
Total:       2200 3746 1266.1   4340    5917
WARNING: The median and mean for the initial connection time are not within a normal deviation
        These results are probably not that reliable.

Percentage of the requests served within a certain time (ms)
  50%   4340
  66%   4516
  75%   4517
  80%   4659
  90%   5917
  95%   5917
  98%   5917
  99%   5917
 100%   5917 (longest request)
```

-----

#### Pi: 4 Replicas

```
ab -n 10 -c 5 http://piarmy01:9999/
```

```
Concurrency Level:      5
Time taken for tests:   6.673 seconds
Complete requests:      10
Failed requests:        0
Total transferred:      1640 bytes
HTML transferred:       280 bytes
Requests per second:    1.50 [#/sec] (mean)
Time per request:       3336.283 [ms] (mean)
Time per request:       667.256 [ms] (mean, across all concurrent requests)
Transfer rate:          0.24 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        1    4   3.0      3       8
Processing:  2187 2924 981.5   2306    4454
Waiting:     2187 2698 840.0   2268    4449
Total:       2189 2928 981.8   2314    4457

Percentage of the requests served within a certain time (ms)
  50%   2314
  66%   3001
  75%   3971
  80%   4456
  90%   4457
  95%   4457
  98%   4457
  99%   4457
 100%   4457 (longest request)

```
