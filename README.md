# recranet-cloudfare-image-test


## about
on 2026-02-20 high error rates (~95%) for reschaled images on the recreanet app (using cloudflare services) were detected.

this repo shares some tools and indicative outputs to assist in the digital forensics of the case


## what to find

- a simple sh script that captures ip-location of the client running this prior to both testing accessing the base_source image prior to rescale and crop, as well as the rescaled variant (through the cloudflare service) 


- a folder with reports coming from it:

  - rpt-2026-02-20-odd-succes :: a sudden succesful retrieval on the home network on the day of retrieval
  - rpt-2026-02-21-thuis and rpt-2026-02-21-ugent -- roughly same time but from 2 distinct networks in belgium / flanders

- note that the script also is setup to run as a github action -- just to be able to test from whatever azure-cloud-cluster they happen to use (apparently denver) 


## observations

* error seems to be non existent for clients on networks outside belgium / flanders
* within the trouble area the problem is very persistent (error rate esitmate 95% since 2nd half of 2026-02-20 (UTC) -- and still above 20% 24 hours later...)

* when the error occurs, this is the unexpected behaviour we see:
  * the client can always directly succesfully (200) access the base image
  * when retrieving it through the cdn-cgi/images service it however yields 404 with a nested 9404 which hints that the internal traffic between the base-storage 


## hypothesis

* cloudflare distributes their services around the globe in local datacenters / clusters
* cloudflare cdn routes client requests to be handled as close to origin as possible
* while the images service globally has no issue, there seems to be one down in the cluster servicing belgium / flanders

* as noted above the nature of the problem seems to be in the communication between the base-image storage and the rescaling service


