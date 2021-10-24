---
title: Hexagonal-architecture
---

# Hexagonal architecture

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