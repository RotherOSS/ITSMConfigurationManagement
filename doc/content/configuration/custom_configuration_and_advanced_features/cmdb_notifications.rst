CMDB Notifications
^^^^^^^^^^^^^^^^^^

The CMDB ships with a simple mechanism to create time based tickets for config items. This can be used for example to create a task and notify agents prior to a license expiring or similar. The functionality can be used by activating and configuring the rules (`CMDBNotifications::Rules###`) and the cron task job (`Daemon::SchedulerCronTaskManager::Task###CMDBNotifications`) in the SysConfig.
For this feature to work, it is mandatory to have a ticket dynamic field of type checkbox which will work as indicator that the ticket was automatically created. It must be configured in the rules.
