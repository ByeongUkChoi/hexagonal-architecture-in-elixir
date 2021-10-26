---
title: Layer
---

# Layer
```
 +------------------------------------------+  
 |                  adapter                 |  
 |          +--------------------+          |  
 |          |     application    |          |  
 |          |    +----------+    |          |  
 |          |    |  domain  |    |          |  
 |          |    +----------+    |          |  
 |          +--------------------+          |  
 +------------------------------------------+  
```
## domain
It is business logic layer.  
It include domain models, domain service and repository.

## application
Abstract definition of what the user wants to do.  

## adapter
It is technical details layer.  
It include web controller, http api, rpc, database, messaging queue, etc.  

# directory
```
├── application
└── domain
```