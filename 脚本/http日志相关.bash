查看有多少IP访问
awk '{print $1}' log_file|sort |uniq |wc -log_file|sort