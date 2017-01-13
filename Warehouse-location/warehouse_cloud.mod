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

include "warehouse_data.mod";


range stores = 1..plan.nbStores;

dvar boolean Open[ warehouses ];
dvar boolean Supply[ stores ][ warehouses ];

// expression
dexpr float totalOpeningCost = sum( w in warehouses ) w.fixedCost * Open[w];
dexpr float totalSupplyCost  = sum( w in warehouses , s in stores, k in supplyCosts : k.storeId == s && k.warehouseName == w.name ) 
    Supply[s][w] * k.cost;

minimize
  totalOpeningCost + totalSupplyCost;

subject to {
  forall( s in stores )
    ctEachStoreHasOneWarehouse:
      sum( w in  warehouses ) Supply[s][w] == 1;
      
  forall( w in warehouses, s in stores )
    ctUseOpenWarehouses:
      Supply[s][w] <= Open[w];
      
  forall( w in warehouses )
    ctMaxUseOfWarehouse:         
      sum( s in stores) Supply[s][w] <= w.capacity;
}


{int} StoresSupplied[w in warehouses] = { s | s in stores : Supply[s][w] == 1 };
{string} OpenWarehouses = { w.name | w in warehouses : Open[w] == 1 };
tuple TSuppliedStore {
  string warehouseName;
  int storeId;
}
{TSuppliedStore} network;

execute DISPLAY_RESULTS{
  network.clear();
  writeln("* Open Warehouses=", OpenWarehouses);
  for ( var w in warehouses) {
     if ( Open[w] ==1)   {
        writeln("* stores supplied by ", w.name, ": ", StoresSupplied[w]);
	for (var s in stores) {
	  if (Supply[s][w] == 1) {
	    network.addOnly(w.name, s);
	  }
	}
     }
  }
}
 