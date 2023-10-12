public with sharing class Vehicles {

    @auraEnabled(cacheable = true)
    public static List<Vehicles__c> getVehicles() {
        List<Vehicles__c> lVehicles = new List<Vehicles__c>(); 

        lVehicles = [SELECT Id, Name, Year__c, Preview__c, Brand__c, Sold__c FROM Vehicles__c WHERE Sold__c = false];

        return lVehicles;
    }

    @auraEnabled
    public static void persistPurchase(Id carId) {
        try {
            List<Vehicles__c> lVehicles = [SELECT Id, Name, Year__c, Preview__c, Brand__c, Sold__c FROM Vehicles__c WHERE Id =: carId];
            lVehicles[0].Sold__c = true;
            update lVehicles;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}