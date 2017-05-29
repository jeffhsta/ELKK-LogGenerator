FROM docker.elastic.co/logstash/logstash:5.4.0

RUN logstash-plugin remove logstash-input-kafka
RUN logstash-plugin remove logstash-output-kafka
RUN logstash-plugin install --version 4.2.0 logstash-input-kafka
RUN logstash-plugin install --version 4.0.4 logstash-output-kafka

CMD ["-f", "/logstash.conf"]
