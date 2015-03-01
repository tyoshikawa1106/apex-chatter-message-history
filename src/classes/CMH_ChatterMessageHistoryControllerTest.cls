@isTest
private class CMH_ChatterMessageHistoryControllerTest {

    private static User testAdminUser = CMH_CommonTester.getLoginUser();
    private static User testSendMessageUser = CMH_CommonTester.createUser(UserInfo.getProfileId(), true);
    
    /**
     * Constructor
     */
    static testMethod void CMH_ChatterMessageHistoryControllerTest1() {
        
        System.runAs(testSendMessageUser) {

            Test.startTest();
            
            CMH_ChatterMessageHistoryController cls = new CMH_ChatterMessageHistoryController();
            cls.doInit();
            
            Test.stopTest();

            System.assertEquals(cls.deleteId, null);
            System.assertEquals(String.isEmpty(cls.errorMessage), true);
            System.assertEquals(cls.wrapperList.isEmpty(), true);
        }
    }

    /**
     * Constructor
     */
    @isTest(SeeAllData=true)
    static void CMH_ChatterMessageHistoryControllerTest2() {
        
        System.runAs(testSendMessageUser) {

            // SendMessage
            ConnectApi.ChatterMessage chatterMessage = CMH_CommonTester.doSendChatterMessage('message', testAdminUser.Id);

            Test.startTest();
            
            CMH_ChatterMessageHistoryController cls = new CMH_ChatterMessageHistoryController();
            cls.doInit();
            
            Test.stopTest();

            System.assertEquals(cls.deleteId, null);
            System.assertEquals(String.isEmpty(cls.errorMessage), true);
            System.assertEquals(cls.wrapperList.size(), 1);
        }
    }

    /**
     * Constructor
     */
    @isTest(SeeAllData=true)
    static void CMH_ChatterMessageHistoryControllerTest3() {
        
        System.runAs(testSendMessageUser) {

            // SendMessage
            ConnectApi.ChatterMessage chatterMessage1 = CMH_CommonTester.doSendChatterMessage('message1', testAdminUser.Id);
            ConnectApi.ChatterMessage chatterMessage2 = CMH_CommonTester.doSendChatterMessage('message2', testAdminUser.Id);

            Test.startTest();
            
            CMH_ChatterMessageHistoryController cls = new CMH_ChatterMessageHistoryController();
            cls.doInit();
            
            Test.stopTest();

            System.assertEquals(cls.deleteId, null);
            System.assertEquals(String.isEmpty(cls.errorMessage), true);
            System.assertEquals(cls.wrapperList.size(), 2);
        }
    }

    /**
     * Constructor
     */
    @isTest(SeeAllData=true)
    static void doDeleteTest1() {
        
        System.runAs(testSendMessageUser) {

            // SendMessage
            ConnectApi.ChatterMessage chatterMessage = CMH_CommonTester.doSendChatterMessage('message', testAdminUser.Id);

            CMH_ChatterMessageHistoryController cls = new CMH_ChatterMessageHistoryController();
            cls.doInit();

            System.assertEquals(cls.deleteId, null);
            System.assertEquals(String.isEmpty(cls.errorMessage), true);
            System.assertEquals(cls.wrapperList.size(), 1);

            Test.startTest();
            
            cls.deleteId = null;
            cls.doDelete();
            
            Test.stopTest();

            System.assertEquals(cls.deleteId, null);
            System.assertEquals(String.isNotEmpty(cls.errorMessage), true);
            System.assertEquals(cls.wrapperList.size(), 1);
        }
    }

    /**
     * Constructor
     */
    @isTest(SeeAllData=true)
    static void doDeleteTest2() {
        
        System.runAs(testSendMessageUser) {

            // SendMessage
            ConnectApi.ChatterMessage chatterMessage = CMH_CommonTester.doSendChatterMessage('message', testAdminUser.Id);

            CMH_ChatterMessageHistoryController cls = new CMH_ChatterMessageHistoryController();
            cls.doInit();

            System.assertEquals(cls.deleteId, null);
            System.assertEquals(String.isEmpty(cls.errorMessage), true);
            System.assertEquals(cls.wrapperList.size(), 1);

            Test.startTest();
            
            cls.deleteId = chatterMessage.Id;
            cls.doDelete();
            
            Test.stopTest();

            System.assertEquals(cls.deleteId, null);
            System.assertEquals(String.isEmpty(cls.errorMessage), true);
            System.assertEquals(cls.wrapperList.size(), 0);
        }
    }
}