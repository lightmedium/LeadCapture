LeadCapture - Developer Assessment project
==========================================

My aim with this project was not just to meet the requirements of the assessment and bang out another list->detail/form application.  
I also wanted to further explore some concepts I've been toying with for the past several weeks.

1. Limit, as much as possible, the amount of monotonous configuration-based logic that tends to gum up UITableView delegates.
2. Create an architecture in which the majority of logic that governs the way that the domain model, configuration, and UI work together is abstracted in such a way that concrete domain, configuration, and UI can be added or removed with very little effort spent on "plumbing."
3. Take a step toward an application that can be assembled at runtime by applying a remote configuration to resources available in the bundle, providing the ability to tweak the native experience without releasing a new binary.

I tried to accomplish those goals through focusing on:

1. Sticking a data model structure that marries nicely with the indexPath nature of UITableView and UICollectionView.
2. Adding configuration data to the domain data in those models.
3. Using inferrence instead of if/else and switch/case statements to guide indirection.
4. Inversion of control when it comes to the relationship between the UITableView delegate and the UITableViewCell.

I look forward to your feedback!