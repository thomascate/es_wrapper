# es_wrapper

Simple elasticsearch setup cookbook intended to be run with chef-solo.

Typical usage would look like this

clone repo into /home/centos
then run
chef-solo -c /home/centos/es_wrapper/solo.rb -o recipe[es_wrapper]