// --------------------------------------------------------------------------
// Licensed Materials - Property of IBM
//
// 5725-A06 5725-A29 5724-Y48 5724-Y49 5724-Y54 5724-Y55
// Copyright IBM Corporation 1998, 2013. All Rights Reserved.
//
// Note to U.S. Government Users Restricted Rights:
// Use, duplication or disclosure restricted by GSA ADP Schedule
// Contract with IBM Corp.
// --------------------------------------------------------------------------

// Problem 3 from Model Building in Mathematical Programming, 3rd ed.
//   by HP Williams
// Factory Planning 
// This model is described in the documentation. 
// See "Samples" in the Documentation home page.

tuple TProduct {
  key string name;
  float profit;
}
{TProduct} Products = ...;

///
/// months are integer from 1 to nbMonths
/// number of work hours per month is a float
/// calendar-related data are in a single-row table Calendar
tuple TCalendar {
  int nbMonths;
  float hoursPerMonth;
}
TCalendar Calendar = ...;

///
/// Inventory data: 
/// - initial & final quantity (hard constraints)
/// - maximum quantity held in stock for each period (month)
/// - cost incurred for each unit in stock.
///
/// Cost data are stored in a single-row table Inventory

tuple TInventoryData {
   float initialQuantity;
   float finalQuantity;
   float maxQuantity;
   float costPerUnit;
}
TInventoryData Inventory = ...;

///
/// A process is a resource (a machine) identified by its name.
tuple TProcess {
  key string name;
}
{TProcess} Processes = ...;

///
/// This table stores, for each process type and month,
/// the number of available machines.
/// As this could be an average, it is modeled as a float.
tuple TProcessNum {
   key string process;
   key int month;
   float num;
}
{TProcessNum} NumProcessPerMonth = ...;

///
/// This table stores the quantity of process r required by product p.
tuple TProcessProduct {
   key string process;
   key string product;
   float required;
}
{TProcessProduct} ProcessPerProduct = ...;

///
/// This table stores an upper bound on the quantity of product 
/// that can be sold in agiven month.
tuple TProductForecastPerMonth {
  key string product;
  key int month;
  float forecast;
}
{TProductForecastPerMonth} MarketForecastPerMonth = ...;


/// Output Table
/// The output is a set of tuples, indicating, for each (product, mpnth)
/// which quantities are produced, sold, and held in stock.
tuple TPlan {
   key string product;
   key int month;
   float make;
   float sell;
   float hold;
}

/// ---
/// Internal modeling Data
/// for convenience, we transform table data into OPL arrays
/// ----
int NbMonths = Calendar.nbMonths;
range Months = 1..NbMonths;


float forecasts[p in Products][m in Months] = sum(f in MarketForecastPerMonth: f.month==m && f.product == p.name) f.forecast;
float processUsages[ r in Processes][p in Products] = sum(u in ProcessPerProduct: u.process == r.name && u.product==p.name) u.required;
float processCapacities[ r in Processes][m in Months] = sum(np in NumProcessPerMonth : np.process == r.name && m == np.month) np.num;

dvar float+ Make[Products][Months];

/// REMARK: Hold variable range from 0, not 1 as we take into account initial stock
dvar float+ Hold[Products][0..NbMonths] in 0..Inventory.maxQuantity;
dvar float+ Sell[p in Products][m in Months] in 0..forecasts[p][m];

dexpr float totalProfit = 
  sum (p in Products, m in Months) p.profit * Sell[p][m];
dexpr float totalInventoryCost = 
  sum (p in Products, m in Months) Inventory.costPerUnit * Hold[p][m];
  
maximize totalProfit - totalInventoryCost;
        
subject to {
  // Limits on process capacity 
  forall(m in Months, r in Processes)
    ctCapacity: 
      sum(p in Products) processUsages[r][p] * Make[p][m]
           <= processCapacities[r][m] * Calendar.hoursPerMonth;

  // Inventory balance
  forall(p in Products, m in Months)
    ct_inventory_balance:
    Hold[p][m-1] + Make[p][m] == Sell[p][m] + Hold[p][m];

  // Initial and final inventories are fixed
  forall(p in Products) {
    ct_initial_inventory:
     Hold[p][0] == Inventory.initialQuantity;    
    ct_final_inventory:
     Hold[p][NbMonths] == Inventory.finalQuantity;
  }
}

{TPlan} plan; /// to be filled in post-processing.

///
/// This block fills the output table.
///
execute POSTPROCESS {
   for(var m in Months) {
      for(var p in Products) {
         plan.addOnly(p.name, m, Make[p][m], Sell[p][m], Hold[p][m]);
         writeln(" plan[",m,", ",p.name,"] = <Make: ",Make[p][m],", Sell: ",Sell[p][m],", Hold: ",Hold[p][m],">");    
      }//for
   }//for    
}

/*
// solution (optimal) with objective 93715.1785714286
plan[1][Prod1] = <Make:500, Sell:500, Hold:0>
plan[1][Prod2] = <Make:888.571, Sell:888.571, Hold:0>
plan[1][Prod3] = <Make:382.5, Sell:300, Hold:82.5>
plan[1][Prod4] = <Make:300, Sell:300, Hold:0>
plan[1][Prod5] = <Make:800, Sell:800, Hold:0>
plan[1][Prod6] = <Make:200, Sell:200, Hold:0>
plan[1][Prod7] = <Make:0, Sell:0, Hold:0>
plan[2][Prod1] = <Make:700, Sell:600, Hold:100>
plan[2][Prod2] = <Make:600, Sell:500, Hold:100>
plan[2][Prod3] = <Make:117.5, Sell:200, Hold:0>
plan[2][Prod4] = <Make:0, Sell:0, Hold:0>
plan[2][Prod5] = <Make:500, Sell:400, Hold:100>
plan[2][Prod6] = <Make:300, Sell:300, Hold:0>
plan[2][Prod7] = <Make:250, Sell:150, Hold:100>
plan[3][Prod1] = <Make:0, Sell:100, Hold:0>
plan[3][Prod2] = <Make:0, Sell:100, Hold:0>
plan[3][Prod3] = <Make:0, Sell:0, Hold:0>
plan[3][Prod4] = <Make:0, Sell:0, Hold:0>
plan[3][Prod5] = <Make:0, Sell:100, Hold:0>
plan[3][Prod6] = <Make:400, Sell:400, Hold:0>
plan[3][Prod7] = <Make:0, Sell:100, Hold:0>
plan[4][Prod1] = <Make:200, Sell:200, Hold:0>
plan[4][Prod2] = <Make:300, Sell:300, Hold:0>
plan[4][Prod3] = <Make:400, Sell:400, Hold:0>
plan[4][Prod4] = <Make:500, Sell:500, Hold:0>
plan[4][Prod5] = <Make:200, Sell:200, Hold:0>
plan[4][Prod6] = <Make:0, Sell:0, Hold:0>
plan[4][Prod7] = <Make:100, Sell:100, Hold:0>
plan[5][Prod1] = <Make:0, Sell:0, Hold:0>
plan[5][Prod2] = <Make:100, Sell:100, Hold:0>
plan[5][Prod3] = <Make:600, Sell:500, Hold:100>
plan[5][Prod4] = <Make:100, Sell:100, Hold:0>
plan[5][Prod5] = <Make:1100, Sell:1000, Hold:100>
plan[5][Prod6] = <Make:300, Sell:300, Hold:0>
plan[5][Prod7] = <Make:100, Sell:0, Hold:100>
plan[6][Prod1] = <Make:550, Sell:500, Hold:50>
plan[6][Prod2] = <Make:550, Sell:500, Hold:50>
plan[6][Prod3] = <Make:0, Sell:50, Hold:50>
plan[6][Prod4] = <Make:350, Sell:300, Hold:50>
plan[6][Prod5] = <Make:0, Sell:50, Hold:50>
plan[6][Prod6] = <Make:550, Sell:500, Hold:50>
plan[6][Prod7] = <Make:0, Sell:50, Hold:50>
*/
