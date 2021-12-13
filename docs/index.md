---
title: Hexagonal architecture
layout: home
---

The main keyword of hexagonal architecture is the separation of domains and infrastructure.  
It means separating "Bussiness logic" and "Technical details".  
And the important rule is that the infrastructure depends on the domain.  

Then we can get maintainable software.
```
 +------------------------------------------+  
 |              infrastructure              |  
 |                                          |  
 |               +----------+               |  
-+--dependency-->|  domain  |<--dependency--+-  
 |               +----------+               |  
 |                                          |  
 +------------------------------------------+  
```
---
## Layer
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
### domain
It is business logic layer.  
It include domain models, domain service and repository.

### application
Abstract definition of what the user wants to do.  

### adapter
It is technical details layer.  
It include web controller, http api, rpc, database, messaging queue, etc.  
