#! /usr/bin/env bash

base_img_url="https://files.recranet.app/organizations/1631/2025-10-29-13-50-55/p3300073.jpg"

variant_img_url="https://recranet.app/cdn-cgi/image/format=auto,width=600,height=280,dpr=1,q=85,fit=crop/${base_img_url}"

rpt_file="rpt-$(date --iso).txt" 
rm -rf ${rpt_file} 2>/dev/null

echo "----"                         >> ${rpt_file}
echo "my location..."               >> ${rpt_file}
echo "----"                         >> ${rpt_file}
curl "http://ip-api.com/json/"      >> ${rpt_file}
echo "----"                         >> ${rpt_file}
echo "get ${base_img_url}"          >> ${rpt_file}
echo "----"                         >> ${rpt_file}
curl -LI --url "${base_img_url}"    >> ${rpt_file}
echo "----"                         >> ${rpt_file}
echo "get ${variant_img_url}"       >> ${rpt_file}
echo "----"                         >> ${rpt_file}
curl -LI --url "${variant_img_url}" >> ${rpt_file}
echo "----"                         >> ${rpt_file}
cat ${rpt_file}
echo "done"
exit 0
