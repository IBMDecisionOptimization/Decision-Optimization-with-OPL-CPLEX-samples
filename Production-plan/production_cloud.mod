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

include "production_data.mod";

/// variables.
dvar float+ Inside [Products];
dvar float+ Outside[Products];

dexpr float totalInsideCost  = sum(p in Products)  p.insideCost * Inside[p];
dexpr float totalOutsideCost = sum(p in Products)  p.outsideCost * Outside[p];

minimize
  totalInsideCost + totalOutsideCost;
   
subject to {
  forall( r in Resources )
    ctCapacity: 
      sum( k in Consumptions, p in Products 
           : k.resourceId == r.name && p.name == k.productId ) 
        k.consumption* Inside[p] <= r.capacity;

  forall(p in Products)
    ctDemand:
      Inside[p] + Outside[p] >= p.demand;
}

{TPlannedProduction} plan;
 
execute PRINT_SOLUTION {
  plan.clear();
  for (var p in Products) {
     writeln(" product: ", p.name, ", in=", Inside[p], ", out=", Outside[p]);
     // store results in output table.
     plan.addOnly(p.name, Inside[p], Outside[p]); 
  }
}
 