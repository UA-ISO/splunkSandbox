#!/bin/bash

set -e

case "$1" in
  splunk)
    /opt/splunk/bin/splunk start
    /bin/bash
    ;;
  bash)
  /bin/bash
esac
