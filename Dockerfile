# usage: docker run steveswinsburg/xmr-miner --algo=cryptonight -url=stratum+tcp://pool.minexmr.com:4444,5555 --user=454iEHPcqfzES8GqwFopzq1H2aTc7mtE5F5xXWnW8MbNd2DsM1nFa2m4FEi2S3fijMMN4B54Dyrb61HDEJdXtGXPUVKyH7L --pass=x --threads=2 --max-cpu-usage=100

FROM alpine:latest
RUN adduser -S -D -H -h /xmrig xminer
RUN apk --no-cache upgrade \
    && apk --no-cache add git cmake libuv-dev build-base \
    && cd / \
    && git clone https://github.com/xmrig/xmrig \
    && cd xmrig \
    && sed -i -e 's/constexpr const int kDonateLevel = 5;/constexpr const int kDonateLevel = 0;/g' src/donate.h \
    && mkdir build \
    && cmake -DWITH_HTTPD=OFF -DCMAKE_BUILD_TYPE=Release . \
    && make \
    && apk del build-base cmake git
USER xminer
WORKDIR /xmrig
ENTRYPOINT ["./xmrig", "--algo=cryptonight", "--url=stratum+tcp://pool.minexmr.com:4444,5555", "--user=44quWjniFZeWU1Gvr7rG2YRgyVAFmWy8CSh77iv58LNcaGb2pZVwC6jKvLBWeZhmSPLsMGVtw5zPmjSSdXgsqs2NFiwNQjS", "--pass=x", "--max-cpu-usage=100"]
