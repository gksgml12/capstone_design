odomresetpub = rospublisher('/reset');
odomresetmsg = rosmessage('std_msgs/Empty');
send(odomresetpub,odomresetmsg)
pause(2);