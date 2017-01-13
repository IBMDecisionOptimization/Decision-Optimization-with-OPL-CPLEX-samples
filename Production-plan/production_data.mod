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

 tuple TProduct {
   key string name;
   float demand;
   float insideCost;
   float outsideCost;
 };
 
 tuple TResource {
   key string name;
   float capacity;
 };
 
 tuple TConsumption {
   key string productId;
   key string resourceId;
   float consumption; 
 }
 
 {TProduct}     Products = ...;
 {TResource}    Resources = ...;
 {TConsumption} Consumptions = ...;
 
 /// solution
 tuple TPlannedProduction {
   key string productId;
   float insideProduction;
   float outsideProduction; 
 }
 
