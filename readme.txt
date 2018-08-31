This script was written to help in trouble shooting communication issues, typically seen between web and db servers.
Windows perfmon tool does not allow you to capture port status over time which makes tracking port exhaustion tricky.

I've written this script with the help of Ben Thompson from Rackspace to run in the background and to dump the number of ports in each status
Date,Time,TIME_WAIT,ESTABLISHED,CLOSE_WAIT,
31/08/2018,08:41:49,14,54,6,
31/08/2018,08:41:54,14,54,6,

The output is written in CSV format so that it can be quickly opened in excel and then have a filter applied to it. 
It also makes it simple to graph the connection count over time to see if you have a pattern to the port status.

The V1 of the script can be run indefinitely by selecting -1 iterations.  A more elegant solution may follow in a latter release.

Each time the script is run it outputs to a file format of:
NETSTAT_LOG_HOSTNAME_20180831_08-41-47
The hostname allows you to run the script on multiple machines and not lose data when combining logs.
The date and time prevent you over writing logs if you stop and start the script.
