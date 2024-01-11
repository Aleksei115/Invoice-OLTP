
`	`**![](readme/Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.001.png)![](readme/Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.002.png)**

**Project 1** 

**Invoices**

**Structured Database**

**Equipment 05**

**Members**

**Fredin Alberto Vázquez Martínez**

**Aleksei Ithan Garcia Diaz**

**Requirements sheet:**

![](readme/Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.003.png)

![](readme/Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.004.png)

**Entity - Relationship Diagram (elaborated in PowerDesigner):**

![](readme/Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.005.png)


**Relational model (elaborated in PowerDesigner):**

![](readme/Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.006.png)

**Creation of the database:**

![](readme/Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.007.png)

**Insertion of tables**

![](readme/Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.008.png)

Code

![](readme/Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.009.png)



![](readme/Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.010.png)

![](readme/Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.011.png)




**Creation of indexes**

Indexes used to avoid the search to be executed in the whole column, instead it will be executed only in one column, that is why it should be placed in common query leader fields and not in all the attributes. So the common query ones were placed.

It is reminded that for UNIQUE and PK their indexes are automatically generated.

![](readme/Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.012.png)

**Code**

![](readme/Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.013.png)


**Creation of procedures**

**Procedures for adding records**

**Add Payment\_method**

![](readme/Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.014.png)

**Add customers**

![](readme/Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.015.png)

**Add payment types**

![](readme/Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.016.png)

**Add product**

![](readme/Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.017.png)

**Add invoice![](readme/Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.018.png)**











**Procedure for automatic generation of primary keys:**

![](readme/Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.019.png)


**Procedures sp**

**sp\_inserts**

Procedure for inserting a category

![](readme/Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.020.png)

**sp\_delete**

Procedure to perform a category deletion given its ID as a parameter.

![](readme/Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.021.png)

**Triggers**

Trigger used so that when a record is added to the payment method table, the type of payment being made is verified first, this way you can know how to act.

![](readme/Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.022.png)

Creation in the database

![](readme/Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.023.png)



**Insertion of records**

**Correct**

Inserting records for categories

![](readme/Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.024.png)



Inserting product records

![](readme/Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.025.png)

Inserting customers

![](readme/Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.026.png)

![](readme/Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.027.png)

Insert payment methods

![](readme/Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.028.png)

**Incorrect**

CALL insert\_payment\_method('Transfer', NULL, 8000);

Incorrect because you have a payment amount and that is only available for payment types such as check or cash.

![](readme/Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.029.png)

CALL insert\_payment\_method('Check', '89012345678901234567', NULL);

You have a check and are passing an account number, which is not used for this method of payment.

![](readme/Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.030.png)

**Inquiries**

Consultations requested:

1. Given the customer's name, know the orders he/she has placed during the last year, specifying for each order whether he/she has requested an invoice or not.

![](readme/Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.031.png)

![](readme/Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.032.png)

1. Given the number of a product, know the number of invoices that have been requested for it by customers.

   ![](readme/Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.033.png)


1. Given a payment type, know the name of the customers who use it.

   ![](readme/Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.034.png)

1. Given an account number, know the payment methods used by the account owner.

![](readme/Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.035.png)

1. Obtain the names of the customers and the amount to be paid, as their invoice was generated in the year 2023.



![](readme/Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.036.png)

![](readme/Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.037.png)

Consultation procedure

![ref1]![ref2]

![ref3]

[ref1]: Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.038.png
[ref2]: Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.039.png
[ref3]: Aspose.Words.66dba48a-46ec-4796-921c-722bb705e0dd.040.png
