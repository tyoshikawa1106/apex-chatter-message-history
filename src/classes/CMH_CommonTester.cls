public with sharing class CMH_CommonTester {
    
    /**
     * Get Test User
     */
    public static User getLoginUser() {
        return new User(Id = UserInfo.getUserId());
    }

    /**
     * Create User
     */
    public static User createUser(Id profileId, Boolean isInsert) {
        
        User user = new User(
             LastName = 'LastName'
            ,Alias = 'Alias'
            ,Email = 'user@sfdcdevelopers.com.test'
            ,Username = 'user@sfdcdevelopers.com.test'
            ,CommunityNickname = 'TestUser'
            ,EmailEncodingKey = 'ISO-2022-JP'
            ,TimeZoneSidKey = 'Asia/Tokyo'
            ,LocaleSidKey = 'ja_JP'
            ,LanguageLocaleKey = 'ja'
            ,ProfileId = profileId
        );
        
        if (isInsert) {
            insert user;
        }
        
        return user;
    }

    /**
     * Send Chatter Message
     */
    public static ConnectApi.ChatterMessage doSendChatterMessage(String message, Id userId) {
        ConnectApi.ChatterMessage chatterMessage = ConnectApi.ChatterMessages.sendMessage(message, userId);
        return chatterMessage;
    }
}