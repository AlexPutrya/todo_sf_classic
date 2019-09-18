@isTest
public with sharing class TodoControllerTest {

    @isTest
    static void addTaskTest() {
        TodoController todoController = new ToDoController();
        todoController.taskText = 'Go to market';
        todoController.addTask();
        System.assertEquals(1, [SELECT Description__c FROM To_do__c WHERE Description__c = 'Go to market'].size());
    }

    @isTest
    static void changeDoneTaskTest() {
        TodoController todoController = new ToDoController();
        To_do__c todo = new To_do__c(
            Description__c = 'Go to market',
            Done__c = false
        );
        insert todo;
        todoController.taskId = todo.Id;
        todoController.changeDone();
        To_do__c changedTodo = [SELECT Id, Done__c FROM To_do__c WHERE Id=:todo.Id];
        system.assertEquals(true, changedTodo.Done__c);
    }

    @isTest
    static void deleteTaskTest(){
        To_do__c todo = new To_do__c(
            Description__c = 'Go to market'
        );
        insert todo;
        TodoController todoController = new ToDoController();
        todoController.taskId = todo.Id;
        todoController.deleteTask();
        System.assertEquals(0, [SELECT Id FROM To_do__c WHERE Id=:todo.id].size());
    }

    @isTest
    static void nulifyTest(){
        TodoController todoController = new ToDoController();
        todoController.taskText = 'Go to market';
        todoController.nulify();
        System.assert(todoController.taskText == '');
    }

    @isTest
    static void getTasksSetDateTest() {
        Date selectedDate = Date.newInstance(2019,9, 17);
        TodoController todoController = new ToDoController();
        todoController.selectedDate = selectedDate;
        List<To_do__c> todos = new List<To_do__c>();
        for(Integer i=0; i<10; i++){
            todos.add(new To_do__c(
                Date__c = selectedDate,
                Description__c = 'Create project'+i
            ));
        }
        insert todos;
        System.assertEquals(10, todoController.todos.size() );
    }

    @isTest
    static void getTasksNoDateTest() {
        TodoController todoController = new ToDoController();
        List<To_do__c> todos = new List<To_do__c>();
        for(Integer i=0; i<10; i++){
            todos.add(new To_do__c(
                Date__c = Date.today(),
                Description__c = 'Create project'+i
            ));
        }
        insert todos;
        System.assertEquals(10, todoController.todos.size() );
    }
}