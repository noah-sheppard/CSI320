cat /var/log/apache2/access.log | grep -w  "/page2.html" | awk '{print $1, $7}'
