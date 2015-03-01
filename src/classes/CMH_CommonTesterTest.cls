@isTest
private class CMH_CommonTesterTest {

    private static User testAdminUser = CMH_CommonTester.getLoginUser();
    
    /**
     * Get Test User
     */
    static testMethod void getLoginUserTest() {
        
        System.runAs(testAdminUser) {
            Test.startTest();
            
            User result = CMH_CommonTester.getLoginUser();
            System.assertEquals(result.Id, UserInfo.getUserId());
            
            Test.stopTest();
        }
    }

    /**
     * Create User
     */
    static testMethod void createUserTest() {

        System.runAs(testAdminUser) {
            Id profileId = UserInfo.getProfileId();
            
            Test.startTest();
            
            // Not Insert
            User user = CMH_CommonTester.createUser(profileId, false);
            System.assertEquals(String.isEmpty(user.Id), true);
            
            // Insert
            user = CMH_CommonTester.createUser(profileId, true);
            System.assertEquals(String.isNotEmpty(user.Id), true);
            
            Test.stopTest();
        }
    }

    /**
     * Send Chatter Message
     */
    @isTest(SeeAllData=true)
    static void doSendChatterMessageTest() {
        
        System.runAs(testAdminUser) {

            Id profileId = UserInfo.getProfileId();
            User user = CMH_CommonTester.createUser(profileId, true);

            String message = 'Message!!';
            Id userId = user.Id;

            Test.startTest();
            
            ConnectApi.ChatterMessage chatterMessage = CMH_CommonTester.doSendChatterMessage(message, userId);
            
            Test.stopTest();
        }
    }
}