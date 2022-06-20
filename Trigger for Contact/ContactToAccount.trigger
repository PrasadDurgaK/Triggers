trigger ContactToAccount on Contact (before insert,before update,before delete,after insert,after update,after delete,after undelete) {
    if(trigger.IsAfter){
        ContactToAccountHelper.ContactToAccountTrig(Trigger.new);  
    }
 
}
