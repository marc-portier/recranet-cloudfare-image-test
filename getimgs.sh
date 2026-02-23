#! /usr/bin/env bash

# base images are served here
base_host="files.recranet.app" 
base_img_url="https://${base_host}/organizations/1631/2025-10-29-13-50-55/p3300073.jpg"

# processed images are served here
proc_host="recranet.app"
proc_img_url="https://${proc_host}/cdn-cgi/image/format=auto,width=600,height=280,dpr=1,q=85,fit=crop/${base_img_url}"
proc_trace_url="https://${proc_host}/cdn-cgi/trace"

# output is storede 
rpt_file="rpt-$(date --iso).txt" 
rm -rf ${rpt_file} 2>/dev/null

echo "===="                         >> ${rpt_file}

echo "my location..."               >> ${rpt_file}
echo "----"                         >> ${rpt_file}
curl "http://ip-api.com/json/"      >> ${rpt_file}
echo  -e "\n===="                   >> ${rpt_file}

# note this will only reveal something if couldflare is using geoDNS
# but they are not, they use AnyCast in stead
#echo "IP of servers (cdn location)" >> ${rpt_file}
#echo "----"                         >> ${rpt_file}
#echo "resolved IP for ${base_host}" >> ${rpt_file}
#host "${base_host}"                 >> ${rpt_file}
#echo "resolved IP for ${proc_host}" >> ${rpt_file}
#host "${proc_host}"                 >> ${rpt_file}
#echo "===="                         >> ${rpt_file}

echo "get ${base_img_url}"          >> ${rpt_file}
echo "----"                         >> ${rpt_file}
curl -LI --url "${base_img_url}"    >> ${rpt_file}
echo "===="                         >> ${rpt_file}

echo "get ${proc_img_url}"          >> ${rpt_file}
echo "----"                         >> ${rpt_file}
curl -LI --url "${proc_img_url}"    >> ${rpt_file}
echo "===="                         >> ${rpt_file}

echo "trace the cdn service"        >> ${rpt_file}
echo "----"                         >> ${rpt_file}
curl -L --url "${proc_trace_url}"   >> ${rpt_file}
echo "===="                         >> ${rpt_file}


cat >> ${rpt_file}<< EOM 
Notes:
- Check the cf-ray indicator in the headers of the http-responses above they identify the cluster/node that actually was processing the request
- Additionally check the colo= parameter in the trace response -- it indicates the "cluster" that is dealing with the requests coming from you region

more than 48 hours after initial report to recranet -- the observation remains that requests handled by colo=BRU are faulty most of the time.
EOM

cat ${rpt_file}
echo "done"
exit 0
