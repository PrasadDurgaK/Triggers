public class ContactToAccountHelper {
    
    public static void ContactToAccountTrig(List<Contact> conList){
        
        Set<Id> accountIdSet = new Set<Id>();
        Map<Id, Id> contactIdSet = new Map<Id, Id>();
        List<AccountContactRelation> listtoInsert = new List<AccountContactRelation>();
        Set<ID> allParents = new Set<ID>();
        
        Boolean allDone;
        //Current Contact and Account Id
        for(Contact currcon : conList){
            
            If(currcon.AccountId != null){
                accountIdSet.add(currcon.AccountId);
                contactIdSet.put(currcon.Id,currcon.AccountId);
            }   
        }
         
        List<Account> theAccount = [select Id,ParentID from Account where Id in:accountIdSet];
        if(!theAccount.isEmpty()){
            Account Accn =  theAccount.get(0);
            allParents.add(Accn.Id);
            if(Accn.ParentID != Null)
            {
            
            allParents.add(Accn.ParentID);
        }
        }
        
        //Main loop to traverse through the Hierarchy
        do{
            //Set the flag to indicate loop should stop
            allDone = true;
            //Get a list of accounts with IDs or Parent IDs in the AllParents Set
            //This will produce 1 SOQL for each level in the Hierachy 
            for(Account a : [Select ID, ParentID From Account Where ID IN :allParents OR ParentID IN :allParents]){
                
                if(!allParents.contains(a.ID) || ( !allParents.contains(a.parentID) && a.parentID != null)){
                    
                    if(a.parentID != null)
                        allParents.add(a.parentID);
                    
                    allParents.add(a.id); 
                    allDone = false;
                    
                }
                
            }
            
        } while(allDone == false);
        
        allParents.removeAll(accountIdSet);
        String[] listtoInsert2 = new List<Id>(AllParents);
        
        
        //Fetch the details and add it to list
        for (Contact c : [select Id , AccountId,(SELECT AccountId, ContactId FROM AccountContactRelations) from Contact where AccountId in :accountIdSet]){
            
            String cona = contactIdSet.get(c.Id);
            if(contactIdSet.containsKey(c.Id)){
                
                if(cona == c.AccountId){
                    
                    for(Integer i=0;i<listtoInsert2.size();i++) {
                        
                        AccountContactRelation   acr =  new AccountContactRelation();
                        acr.AccountId = listtoInsert2[i];
                        acr.contactId = c.Id;
                        listtoInsert.add(acr);
                    }
                } 
            }
        }  
        //Insert the relationship records
        if(!listtoInsert.isEmpty()){
        insert listtoInsert;
        }
    }
}