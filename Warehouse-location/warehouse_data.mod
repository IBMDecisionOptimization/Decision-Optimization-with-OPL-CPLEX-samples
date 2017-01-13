
tuple TWarehouse {
  key string name;
  int capacity;
  float fixedCost;
}

tuple TSupplyCost {
   key string warehouseName;
   key int storeId;
   float cost;
}

tuple TPlan {
   int nbStores;
}

TPlan plan = ...;
{TWarehouse} warehouses = ...;
{TSupplyCost} supplyCosts = ...;