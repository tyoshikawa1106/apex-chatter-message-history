@isTest
private class CMH_ChatterMessageHistoryDaoTest {

    private static CMH_ChatterMessageHistoryHelper helper = new CMH_ChatterMessageHistoryHelper();
    private static CMH_ChatterMessageHistoryDao dao = new CMH_ChatterMessageHistoryDao();
    private static User testAdminUser = CMH_CommonTester.getLoginUser();
    private static User testSendMessageUser = CMH_CommonTester.createUser(UserInfo.getProfileId(), true);
    
    /**
     * Get ChatterMessage
     */
    static testMethod void getChatterMessagesTest1() {
        
        System.runAs(testSendMessageUser) {

            Test.startTest();
            
            List<ChatterMessage> results = dao.getChatterMessages();
            
            Test.stopTest();

            System.assertEquals(results.isEmpty(), true);
        }
    }

    /**
     * Get ChatterMessage
     */
    @isTest(SeeAllData=true)
    static void getChatterMessagesTest2() {
        
        System.runAs(testSendMessageUser) {

            // SendMessage
            ConnectApi.ChatterMessage chatterMessage = CMH_CommonTester.doSendChatterMessage('message', testAdminUser.Id);

            Test.startTest();
            
            // Get ChatterMessage
            List<ChatterMessage> results = dao.getChatterMessages();
            
            Test.stopTest();

            System.assertEquals(results.size(), 1);
        }
    }

    /**
     * Get ChatterConversationMember
     */
    static testMethod void getChatterConversationMemberTest1() {
        
        System.runAs(testSendMessageUser) {

            Set<Id> conversationIds = new Set<Id>();

            Test.startTest();
            
            List<ChatterConversationMember> results = dao.getChatterConversationMember(conversationIds);
            
            Test.stopTest();

            System.assertEquals(results.isEmpty(), true);
        }
    }

    /**
     * Get ChatterConversationMember
     */
    @isTest(SeeAllData=true)
    static void getChatterConversationMemberTest2() {
        
        System.runAs(testSendMessageUser) {

            // SendMessage
            ConnectApi.ChatterMessage chatterMessage = CMH_CommonTester.doSendChatterMessage('message', testAdminUser.Id);
            // Get ChatterMessage
            List<ChatterMessage> chatterMessages = dao.getChatterMessages();
            // Get ConversationId
            Set<Id> conversationIds = helper.getConversationId(chatterMessages);

            Test.startTest();
            
            List<ChatterConversationMember> results = dao.getChatterConversationMember(conversationIds);
            
            Test.stopTest();

            System.assertEquals(results.size(), 2);
        }
    }

    /**
     * Get User
     */
    static testMethod void getUsersTest1() {
        
        System.runAs(testSendMessageUser) {

            Set<Id> memberIds = new Set<Id>();

            Test.startTest();
            
            List<User> results = dao.getUsers(memberIds);
            
            Test.stopTest();

            System.assertEquals(results.isEmpty(), true);
        }
    }

    /*
     * Get User
     */
    static testMethod void getUsersTest2() {
        
        System.runAs(testSendMessageUser) {

            Set<Id> memberIds = new Set<Id>{testAdminUser.Id, testSendMessageUser.Id};

            Test.startTest();
            
            List<User> results = dao.getUsers(memberIds);
            
            Test.stopTest();

            System.assertEquals(results.size(), 2);
        }
    }

    /**
     * Get DeleteChatterMessage
     */
    static testMethod void getDeleteChatterMessageTest1() {
        
        System.runAs(testSendMessageUser) {

            Id deleteId = null;

            Test.startTest();
            
            ChatterMessage result = dao.getDeleteChatterMessage(deleteId);
            
            Test.stopTest();

            System.assertEquals(String.isEmpty(result.Id), true);
        }
    }

    /**
     * Get DeleteChatterMessage
     */
    @isTest(SeeAllData=true)
    static void getDeleteChatterMessageTest2() {
        
        System.runAs(testSendMessageUser) {

            // SendMessage
            ConnectApi.ChatterMessage chatterMessage = CMH_CommonTester.doSendChatterMessage('message', testAdminUser.Id);
            Id deleteId = chatterMessage.Id;

            Test.startTest();
            
            ChatterMessage result = dao.getDeleteChatterMessage(deleteId);
            
            Test.stopTest();

            System.assertEquals(String.isNotEmpty(result.Id), true);
            System.assertEquals(result.Id, deleteId);
        }
    }
}