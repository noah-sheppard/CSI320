countingCurlAccess() {

  cat /var/log/apache2/access.log | grep -E "page2.html|page1.html|index.html" | awk '{print $7}' | sort | uniq -c | sort -nr
}

countingCurlAccess
