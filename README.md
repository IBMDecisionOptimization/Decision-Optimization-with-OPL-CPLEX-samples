# IBM® Decision Optimization Modeling with OPL and CPLEX 

Welcome to  IBM® Decision Optimization Modeling with OPL and CPLEX on IBM® Decision Optimization on Cloud (DOcplexcloud)

This library contains various model examples with different file types. Brief descriptions of these models are provided later in this file. For each sample you can find the:
* **documentation** - a pdf file describing the optimization problem and the OPL model
* **model and data files** - a folder containing the .mod, .dat or .xls files


You can solve OPL models with CPLEX on DOcplexcloud  by

- uploading a MOD file with optional JSON file(s) and/or zero or more DAT file(s) and/or zero or more Excel files.
- uploading an OPLPROJECT file with a default run configuration, one or more MOD file(s), zero or more DAT file(s), and an optional OPS file.

An OPL project can have only one default run configuration.

All files must be in the same root directory; uploads containing multiple directories are not supported. Problem files cannot connect to an external data source. You cannot drag and drop files directly from an archive viewer into the DropSolve interface. All files must be dropped on the DropSolve interface simultaneously.

Solving with the IBM Decision Optimization on Cloud service (DOcplexcloud) requires that you
[Register for a DropSolve account](https://dropsolve-oaas.docloud.ibmcloud.com/software/analytics/docloud). You can register for the DOcplexcloud free trial and use it free for 30 days.

## Model descriptions
### Factory-planning
How do you find the optimal way to use your factory to increase your profits?

This sample shows how to find the optimal mix of products to manufacture, given production capacities and marketing limitations. You have a factory that makes seven different types of metal products. You use five different machines to process the products and each product requires the use of certain machine processes for varying lengths of time. Some products are more profitable than others, but these often require greater utilization of the machinery. There are marketing limits to the products as well. You will not be able to sell more of certain products during certain months, even if you can manufacture more. Finally, the machines used in some processes will be down for maintenance during certain months.

This is an example of a multi-period production problem. A single-period production problem just evaluates the best manufacturing decisions for each month separately. However, in this model, it's possible to store certain products. So, you want to create a model that links all the months and takes into account the amounts of products held in storage.

This sample shows how to make a six-month plan that optimizes your factory's profits.

This sample uses a Microsoft **Excel** file as a data source.

### Production-plan
How does a company decide what proportion of its products to produce inside the company and what to buy from outside the company?

To meet the demands of its customers, a company manufactures products in its own factories (inside production) or buys them from other companies (outside production). The problem is to determine how much of each product should be produced inside the company and how much outside, while minimizing the overall production cost, meeting the demand, and satisfying the resource constraints.

The model minimizes the production cost for a number of products while satisfying customer demand. Each product can be produced either inside the company, or outside at a higher cost. The inside production is constrained by the company's resources, while outside production is considered unlimited.

The model first declares the products and the resources. The data consists of a description of the products, that is, the demand, the inside and outside costs, the resource consumption, and the capacity of the various resources. The variables for this problem are the inside and outside production for each product.

A production planning problem exists because there are limited production resources that cannot be stored from period to period. Choices must be made as to which resources to include and how to model their capacity, their consumption, and their costs.

This production problem uses Mixed Integer-Linear Programming (MILP), which includes both integer and real variables.

### Warehouse-location
Where is the best location to build a warehouse so that it can supply its existing stores at a minimal cost?

A retail company is considering a number of locations for building warehouses to supply existing stores. Each possible warehouse has a fixed maintenance cost and a maximum capacity specifying how many stores it can support. In addition, each store can be supplied by only one warehouse and the supply cost to the store differs according to the warehouse selected.

The problem consists of choosing which warehouses to build and which of them should supply the various stores while minimizing the total cost, that is, the sum of the fixed and supply costs.

Warehouse location is a typical discrete optimization problem that uses Integer Programming (IP). Integer Programming is the class of problems defined as the optimization of a linear function, subject to linear constraints over integer variables. IP programs are generally harder to solve than linear programs and, to be solved efficiently, need to be smaller than linear programs.


## License

This library is delivered under the  Apache License Version 2.0, January 2004 (see LICENSE.txt).
