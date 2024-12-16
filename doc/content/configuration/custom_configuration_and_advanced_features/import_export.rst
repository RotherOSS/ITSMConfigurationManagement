Import/Export
--------------

1. **From CSV**: You can import and export data as a .csv file, which can even be automated - for example, by dropping a .csv file into a specific directory that's set up to import regularly into OTOBO via a CronJob (command: bin/otobo.Console.pl Admin::ITSM::ImportExport::Import).
2. **Using Web Services**: Another option is to use web services to import and export data. For instance, you could set it up so that whenever a new config item is created or changed in a distributed system connected to the OTOBO CMDB via a web service, a new config item is also created or an existing one updated in the CMDB. 