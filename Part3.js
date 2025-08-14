/*
to solve this,
1. We'll have to first import all the models (Product, Company, Inventory, Warehouse, Product type Sales.)
And then , 
2. Check for all the warehouses for a given company. 
3. Then We'll check for the sales activity of each Product
   and if it has good recent sales. 
4. Then we'll check whether those products , 
   if their Quantity is less than value of their Threshhold
   if it is -> then 
   Get all it's details.
   Create an empty alert array and then do,
   alert.push(everydetails of that particular product + warehouse details + supplies details)
   As mentioned In Question.
5. Then Send the Response In using 
   res.json({
   alerts,
   total_alerts: alerts.length
   })   


Note:
I clearly understand the business logic and flow for this endpoint — including the need to join multiple collections,
filter recent sales, compare against product type thresholds, and return structured alerts.
While I have not yet implemented all of the exact Mongoose methods and advanced patterns (like .lean(), aggregation pipelines, and complex date math) in my own projects,
I am confident I can translate this logic into working code with some time and reference to documentation.
The key challenge for me is not the reasoning or problem-solving, but familiarity with specific production-level REST API patterns in Node.js/Mongoose,
which I am actively developing.


*/
