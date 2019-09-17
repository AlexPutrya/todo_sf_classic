public with sharing class TodoController {
    
    public Date selectedDate{get;set;}
    public String taskText{get;set;}
    public Id taskId{get;set;}
    public List<To_do__c> todos{
        get{
            if(this.selectedDate==null){
                this.selectedDate = Date.today();
            }
            return [SELECT Id,Description__c, Done__c FROM To_do__c WHERE Date__c = :this.selectedDate ORDER BY CreatedDate DESC];
        }
        set{}
    }

    public void addTask() {
        if(this.taskText != '') {
            To_do__c newTask = new To_do__c(Description__c = this.taskText, Done__c = false, Date__c = this.selectedDate);
            insert newTask;
            nulify();
        }
    }

    public void changeDone(){
        To_do__c todo = [SELECT Id, Done__c FROM To_do__c WHERE Id = :this.TaskId];
        todo.Done__c = !todo.Done__c;
        update todo;
    }
    
    public void deleteTask(){
        To_do__c todo = [SELECT Id FROM To_do__c WHERE Id = :this.TaskId];
        delete todo;
    }

    public void nulify(){
        this.taskText = '';
    }
}
