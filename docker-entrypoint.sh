#!/bin/sh
set -e

# Render config file
cat filebeat.yml | sed "s|LOGSTASH_HOST|${LOGSTASH_HOST}|g" | sed "s|LOGSTASH_PORT|${LOGSTASH_PORT}|g" | sed "s|LOG_PATH_DIR|${LOG_PATH_DIR}|g" | sed "s|LOG_DOC_TYPE|${LOG_DOC_TYPE}|g"  > filebeat.yml.tmp
cat filebeat.yml.tmp > filebeat.yml
rm filebeat.yml.tmp

exec "$@"
