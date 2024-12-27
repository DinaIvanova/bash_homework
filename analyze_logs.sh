#!/bin/bash
(echo "Отчет о логе веб-сервера"
echo "========================"
awk 'END {print "Общее количество запросов:\t" NR}' access.log
awk '!ip_num[$1]++ {count++} END {print "Количество уникальных IP-адресов:\t" count}' access.log
echo ""
echo -e "Количество запросов по методам:"
awk '{gsub(/"/, "", $6); count[$6]++} END {for (i in count) print "   " count[i], i}' access.log | sort -k1 -nr
echo ""
awk '{sub(/ HTTP.*/, "", $7); count[$7]++} END {max = 0; popular = ""; for (url in count) {if (count[url] > max) {max = count[url]; popular = url}} print "Самый популярный URL:\t" max, popular}' access.log
echo ""
) > report.txt
echo "Отчет сохранен в файл report.txt"
