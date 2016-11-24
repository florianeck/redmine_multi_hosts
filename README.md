# Redmine MultiHosts Plugin

Support for running one Redmine Installation under multiple host names by assigning a hostname to every user.
Links in sent emails will then point to the hostname assigned to the user instead of the hostname set in the Redmine settings.
Also custom styles for different host names can be applied

## Usecase
Running the same Redmine installation under multiple hosts (e.g. via ReverseProxy).
This nmight happen when customers should get a customized login to the Redmine System

## Caveats
As Redmine uses the BCC field to send an email to multiple recipients, mixups between users/hostnames might happen.
The plugin always uses the first found hostname if the are any users included in the recipients list that have a custom host.


## Info

This Plugin was created by Florian Eck ([EL Digital Solutions](http://www.el-digital.de)) for [akquinet finance & controlling GmbH](http://www.akquinet.de/).

It is licensed under GNU GENERAL PUBLIC LICENSE.

It has been tested with EasyRedmine, but should also work for regular Redmine installations. If you find any bugs, please file an issue or create a PR.