@isTest
public class ContactToAccountHelperTest 
{
    public static testMethod void successfullContactCreation()
    {
        Account accRecord = new account();
        accRecord.Name = 'Test Acc1114';
        insert accRecord;
        
        Account accRecord2 = new account();
        accRecord2.Name = 'Test Acc2';
        accRecord2.ParentId = accRecord.Id;    
        insert accRecord2;
        
        contact conRecord = new contact();
        conRecord.AccountId = accRecord.id;
        conrecord.lastname = 'TestCon13';
        insert conRecord;
        
        
    }
    
    
}