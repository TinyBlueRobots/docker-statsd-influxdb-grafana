{
    influxdb: {
        host: '127.0.0.1',
        port: 8086,
        database: 'statsd',
        username: 'root',
        password: 'root',
        version: 0.9,
        flush: {
            enable: true
        },
        proxy: {
            enable: false,
            suffix: 'raw',
            flushInterval: 1000
        },
        includeStatsdMetrics: true,
        includeInfluxdbMetrics: true,
    },
    port: 8125,
    backends: ['./backends/console', 'statsd-influxdb-backend'],
    debug: true,
    legacyNamespace: false
}