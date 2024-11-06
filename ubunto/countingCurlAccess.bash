countingCurlAccess() {
  cat /var/log/apache2/access.log | grep -i "curl" | awk '{print $1, $12}' | sort | uniq -c | sort -nr
}

countingCurlAccess
