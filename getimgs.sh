#! /usr/bin/env bash

# base images are served here
base_host="files.recranet.app" 
base_img_url="https://${base_host}/organizations/1631/2025-10-29-13-50-55/p3300073.jpg"

# processed images are served here
proc_host="recranet.app"
proc_img_url="https://${proc_host}/cdn-cgi/image/format=auto,width=600,height=280,dpr=1,q=85,fit=crop/${base_img_url}"

# output is storede 
rpt_file="rpt-$(date --iso).txt" 
rm -rf ${rpt_file} 2>/dev/null

echo "===="                         >> ${rpt_file}

echo "my location..."               >> ${rpt_file}
echo "----"                         >> ${rpt_file}
curl "http://ip-api.com/json/"      >> ${rpt_file}
echo  -e "\n===="                   >> ${rpt_file}

echo "IP of servers (cdn location)" >> ${rpt_file}
echo "----"                         >> ${rpt_file}
echo "resolved IP for ${base_host}" >> ${rpt_file}
host "${base_host}"                 >> ${rpt_file}
echo "resolved IP for ${proc_host}" >> ${rpt_file}
host "${proc_host}"                 >> ${rpt_file}
echo "===="                         >> ${rpt_file}

echo "get ${base_img_url}"          >> ${rpt_file}
echo "----"                         >> ${rpt_file}
curl -LI --url "${base_img_url}"    >> ${rpt_file}
echo "===="                         >> ${rpt_file}

echo "get ${proc_img_url}"          >> ${rpt_file}
echo "----"                         >> ${rpt_file}
curl -LI --url "${proc_img_url}"    >> ${rpt_file}
echo "===="                         >> ${rpt_file}

cat ${rpt_file}
echo "done"
exit 0
