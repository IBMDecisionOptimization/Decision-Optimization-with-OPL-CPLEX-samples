# IBM® Decision Optimization Modeling with OPL and CPLEX 

Welcome to  IBM® Decision Optimization Modeling with OPL and CPLEX on IBM® Decision Optimization on Cloud (DOcplexcloud)

This library contains various model examples with different file types. For each sample you can find the:
* **documentation** - a pdf file describing the optimization problem and the OPL model
* **model and data files** - a folder containing the .mod, .dat or .xls files


You can solve OPL models with CPLEX on DOcplexcloud  by

- uploading a MOD file with optional JSON file(s) and/or zero or more DAT file(s) and/or zero or more Excel files.
- uploading an OPLPROJECT file with a default run configuration, one or more MOD file(s), zero or more DAT file(s), and an optional OPS file.

An OPL project can have only one default run configuration.

All files must be in the same root directory; uploads containing multiple directories are not supported. Problem files cannot connect to an external data source. You cannot drag and drop files directly from an archive viewer into the DropSolve interface. All files must be dropped on the DropSolve interface simultaneously.

Solving with the IBM Decision Optimization on Cloud service (DOcplexcloud) requires that you
[Register for a DropSolve account](https://dropsolve-oaas.docloud.ibmcloud.com/software/analytics/docloud). You can register for the DOcplexcloud free trial and use it free for 30 days.


## License

This library is delivered under the  Apache License Version 2.0, January 2004 (see LICENSE.txt).
