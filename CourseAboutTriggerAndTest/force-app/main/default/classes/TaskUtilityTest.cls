@isTest
private with sharing class TaskUtilityTest {
    
    @isTest
    private static void taskPriorityTestIsOk() {
        String p = TaskUtility.taskPriority('NY');
        System.assertEquals('Normal', p, 'Testing priority task ok');
    }
    
    @isTest
    private static void taskPriorityTestIsNull() {
        String p = TaskUtility.taskPriority('');
        System.assertEquals(null, p, 'Testing priority task null');
    }
    
    @isTest
    private static void taskPriorityTestHasLengthBiggerThenTwo() {
        String p = TaskUtility.taskPriority('ABC');
        System.assertEquals(null, p, 'Testing priority task with length bigger then two');
    }
    
    @isTest
    private static void taskPriorityTestIsCa() {
        String p = TaskUtility.taskPriority('CA');
        System.assertEquals('High', p, 'Testing priority task is High');
    }
}