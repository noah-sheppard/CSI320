ip addr | grep 'inet ' | awk '{print $2}' | grep '^10\.' | cut -d'/' -f1
