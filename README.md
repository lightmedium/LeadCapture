LeadCapture
===========
- Developer Assessment project
------------------------------
______________________________________________________________________________

My aim with this project was not just to meet the requirements of the assessment   
and bang out another list/detail/form application. I also wanted to further explore  
some concepts I've been toying with for the past several weeks.  

My goals were:
--------------

1. Limit, as much as possible, the amount of monotonous configuration-based logic that   
tends to gum up UITableView delegates.
2. Create an architecture in which the majority of logic that governs the way that the   
domain model, configuration, and UI work together is abstracted in such a way that   
concrete domain, configuration, and UI can be added or removed with very little effort   
spent on "plumbing."
3. Take a step toward an application that can be assembled at runtime by applying a   
remote configuration to resources available in the bundle, providing the ability to   
tweak the native experience without releasing a new binary.
______________________________________________________________________________

Approach was:
-------------------------------------------------

1. Stick to a data model structure that marries nicely with the indexPath nature   
of UITableView and UICollectionView.
2. Add configuration data to the domain data in those models.
3. Use inferrence instead of if/else and switch/case statements to guide indirection.
4. Employ inversion of control when it comes to the relationship between the UITableView   
delegate and the UITableViewCell.
______________________________________________________________________________

Some things I would do differently:
-----------------------------------

1. Eliminate use of performSelector when reading properties from the domain model in   
the -(NSDictionary *)serializedForSave; method.
2. Isolate and abstract the dependency between control logic and UITableView/UITableViewCell   
so that it would be trivial to swap it out for UICollectionView.
3. Wrap the iOS 7-only apis so this builds in iOS 6.1
______________________________________________________________________________

Notes: 
* The SalesForce SDK doesn't appear to compiled for 64bit architectures.
* This app will only run (for now) under iOS 7 - I have a reference to an iOS 7-only  
api that needs to be wrapped and handled for both 6 and 7.

I look forward to your feedback!
================================
______________________________________________________________________________