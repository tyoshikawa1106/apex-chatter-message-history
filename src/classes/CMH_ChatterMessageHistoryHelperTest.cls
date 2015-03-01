@isTest
private class CMH_ChatterMessageHistoryHelperTest {

    private static CMH_ChatterMessageHistoryDao dao = new CMH_ChatterMessageHistoryDao();
    private static CMH_ChatterMessageHistoryHelper helper = new CMH_ChatterMessageHistoryHelper();
    private static User testAdminUser = CMH_CommonTester.getLoginUser();
    private static User testSendMessageUser = CMH_CommonTester.createUser(UserInfo.getProfileId(), true);
    
    /**
     * Get ConversationId
     */
    static testMethod void getConversationIdTest1() {
        
        System.runAs(testSendMessageUser) {

            List<ChatterMessage> chatterMessages = new List<ChatterMessage>();

            Test.startTest();
            
            Set<Id> results = helper.getConversationId(chatterMessages);
            
            Test.stopTest();

            System.assertEquals(results.isEmpty(), true);
        }
    }

    /**
     * Get ConversationId
     */
    @isTest(SeeAllData=true)
    static void getConversationIdTest2() {
        
        System.runAs(testSendMessageUser) {

            // SendMessage
            ConnectApi.ChatterMessage chatterMessage = CMH_CommonTester.doSendChatterMessage('message', testAdminUser.Id);
            // Get ChatterMessage
            List<ChatterMessage> chatterMessages = dao.getChatterMessages();
            System.assertEquals(chatterMessages.size(), 1);

            Test.startTest();
            
            Set<Id> results = helper.getConversationId(chatterMessages);
            
            Test.stopTest();

            System.assertEquals(results.size(), 1);
        }
    }

    /**
     * Get ChatterConversationMemberMap
     */
    static testMethod void getChatterConversationMemberMapTest1() {
        
        System.runAs(testSendMessageUser) {

            List<ChatterConversationMember> chatterMembers = new List<ChatterConversationMember>();

            Test.startTest();
            
            Map<Id, Id> results = helper.getChatterConversationMemberMap(chatterMembers);
            
            Test.stopTest();

            System.assertEquals(results.isEmpty(), true);
        }
    }

    /**
     * Get ChatterConversationMemberMap
     */
    @isTest(SeeAllData=true)
    static void getChatterConversationMemberMapTest2() {
        
        System.runAs(testSendMessageUser) {

            // SendMessage
            ConnectApi.ChatterMessage chatterMessage = CMH_CommonTester.doSendChatterMessage('message', testAdminUser.Id);
            // Get ChatterMessage
            List<ChatterMessage> chatterMessages = dao.getChatterMessages();
            // Get ConversationId
            Set<Id> conversationIds = helper.getConversationId(chatterMessages);
            // Get ChatterConversationMember
            List<ChatterConversationMember> chatterMembers = dao.getChatterConversationMember(conversationIds);

            Test.startTest();
            
            Map<Id, Id> results = helper.getChatterConversationMemberMap(chatterMembers);
            
            Test.stopTest();

            System.assertEquals(results.size(), 1);
        }
    }

    /**
     * Get ChatterConversationMemberId
     */
    static testMethod void getChatterConversationMemberIdTest1() {
        
        System.runAs(testSendMessageUser) {

            List<ChatterConversationMember> chatterMembers = new List<ChatterConversationMember>();

            Test.startTest();
            
            Set<Id> results = helper.getChatterConversationMemberId(chatterMembers);
            
            Test.stopTest();

            System.assertEquals(results.isEmpty(), true);
        }
    }

    /**
     * Get ChatterConversationMemberId
     */
    @isTest(SeeAllData=true)
    static void getChatterConversationMemberIdTest2() {
        
        System.runAs(testSendMessageUser) {

            // SendMessage
            ConnectApi.ChatterMessage chatterMessage = CMH_CommonTester.doSendChatterMessage('message', testAdminUser.Id);
            // Get ChatterMessage
            List<ChatterMessage> chatterMessages = dao.getChatterMessages();
            System.assertEquals(chatterMessages.size(), 1);
            // Get ConversationId
            Set<Id> conversationIds = helper.getConversationId(chatterMessages);
            // Get ChatterConversationMember
            List<ChatterConversationMember> chatterMembers = dao.getChatterConversationMember(conversationIds);

            Test.startTest();
            
            Set<Id> results = helper.getChatterConversationMemberId(chatterMembers);
            
            Test.stopTest();

            System.assertEquals(results.size(), 2);
        }
    }

    /**
     * Get ChatterMessageHistoryWrapperList
     */
    static testMethod void getChatterMessageHistoryWrapperListTest1() {
        
        System.runAs(testSendMessageUser) {

            List<ChatterMessage> chatterMessages = new List<ChatterMessage>();
            Map<Id, Id> chatterMemberMap = new Map<Id, Id>();
            Map<Id, User> userMap = new Map<Id, User>();

            Test.startTest();
            
            List<CMH_ChatterMessageHistoryWrapper> results = helper.getChatterMessageHistoryWrapperList(chatterMessages, chatterMemberMap, userMap);
            
            Test.stopTest();

            System.assertEquals(results.isEmpty(), true);
        }
    }

    /**
     * Get ChatterMessageHistoryWrapperList
     */
    @isTest(SeeAllData=true)
    static void getChatterMessageHistoryWrapperListTest2() {
        
        System.runAs(testSendMessageUser) {

            // SendMessage
            ConnectApi.ChatterMessage chatterMessage = CMH_CommonTester.doSendChatterMessage('message', testAdminUser.Id);
            // Get ChatterMessage
            List<ChatterMessage> chatterMessages = dao.getChatterMessages();
            System.assertEquals(chatterMessages.size(), 1);
            // Get ConversationId
            Set<Id> conversationIds = helper.getConversationId(chatterMessages);
            // Get ChatterConversationMember
            List<ChatterConversationMember> chatterMembers = dao.getChatterConversationMember(conversationIds);
            // Get ChatterConversationMemberMap
            Map<Id, Id> chatterMemberMap = helper.getChatterConversationMemberMap(chatterMembers);
            // Get ChatterConversationMemberId
            Set<Id> memberIds = helper.getChatterConversationMemberId(chatterMembers);
            // Get User
            List<User> users = dao.getUsers(memberIds);
            // User Map
            Map<Id, User> userMap = new Map<Id, User>(users);

            Test.startTest();
            
            List<CMH_ChatterMessageHistoryWrapper> results = helper.getChatterMessageHistoryWrapperList(chatterMessages, chatterMemberMap, userMap);
            
            Test.stopTest();

            System.assertEquals(results.size(), 1);
        }
    }

    /**
     * Check Delete Id
     */
    static testMethod void isEmptyDeleteIdTest1() {
        
        System.runAs(testSendMessageUser) {

            Id deleteId = null;

            Test.startTest();
            
            String result = helper.isEmptyDeleteId(deleteId);
            
            Test.stopTest();

            System.assertEquals(String.isNotEmpty(result), true);
        }
    }

    /**
     * Check Delete Id
     */
    @isTest(SeeAllData=true)
    static void isEmptyDeleteIdTest2() {
        
        System.runAs(testSendMessageUser) {

            // SendMessage
            ConnectApi.ChatterMessage chatterMessage = CMH_CommonTester.doSendChatterMessage('message', testAdminUser.Id);
            Id deleteId = chatterMessage.Id;

            Test.startTest();
            
            String result = helper.isEmptyDeleteId(deleteId);
            
            Test.stopTest();

            System.assertEquals(String.isEmpty(result), true);
        }
    }
}