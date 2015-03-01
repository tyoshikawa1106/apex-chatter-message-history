@isTest
private class CMH_ChatterMessageHistoryWrapperTest {

    private static CMH_ChatterMessageHistoryDao dao = new CMH_ChatterMessageHistoryDao();
    private static CMH_ChatterMessageHistoryHelper helper = new CMH_ChatterMessageHistoryHelper();
    private static User testAdminUser = CMH_CommonTester.getLoginUser();
    private static User testSendMessageUser = CMH_CommonTester.createUser(UserInfo.getProfileId(), true);
    
    /**
     * Constructor
     */
    static testMethod void CMH_ChatterMessageHistoryWrapperTest1() {
        
        System.runAs(testSendMessageUser) {

            ChatterMessage chatterMessage = new ChatterMessage();
            Map<Id, Id> chatterMemberMap = new Map<Id, Id>();
            Map<Id, User> userMap = new Map<Id, User>();

            Test.startTest();
            
            CMH_ChatterMessageHistoryWrapper result = new CMH_ChatterMessageHistoryWrapper(chatterMessage, chatterMemberMap, userMap);
            
            Test.stopTest();

            System.assertEquals(String.isEmpty(result.user.Id), true);
            System.assertEquals(String.isEmpty(result.chatterMessage.Id), true);
            System.assertEquals(String.isEmpty(result.sentDate), true);
        }
    }

    /**
     * Constructor
     */
    @isTest(SeeAllData=true)
    static void CMH_ChatterMessageHistoryWrapperTest2() {
        
        System.runAs(testSendMessageUser) {

            // SendMessage
            ConnectApi.ChatterMessage chatterMessage = CMH_CommonTester.doSendChatterMessage('message', testAdminUser.Id);
            // Get ChatterMessage
            List<ChatterMessage> chatterMessages = dao.getChatterMessages();
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
            
            CMH_ChatterMessageHistoryWrapper result = new CMH_ChatterMessageHistoryWrapper(chatterMessages[0], chatterMemberMap, userMap);
            
            Test.stopTest();

            System.assertEquals(String.isNotEmpty(result.user.Id), true);
            System.assertEquals(String.isNotEmpty(result.chatterMessage.Id), true);
            System.assertEquals(String.isNotEmpty(result.sentDate), true);
        }
    }
}