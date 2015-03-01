public with sharing class CMH_ChatterMessageHistoryDao {

    /**
     * Constructor
     */
    public CMH_ChatterMessageHistoryDao() {
        
    }

    /**
     * Get ChatterMessage
     */
    public List<ChatterMessage> getChatterMessages() {
        return [
            SELECT
                 Id
                ,Body
                ,ConversationId
                ,SenderId
                ,SentDate
            FROM
                ChatterMessage
            WHERE
                SenderId =: UserInfo.getUserId()
            ORDER BY SentDate DESC
            LIMIT 200
        ];
    }

    /**
     * Get ChatterConversationMember
     */
    public List<ChatterConversationMember> getChatterConversationMember(Set<Id> conversationIds) {
        return [
            SELECT
                 ConversationId
                ,MemberId
            FROM
                ChatterConversationMember
            WHERE
                ConversationId IN: conversationIds
        ];
    }

    /**
     * Get User
     */
    public List<User> getUsers(Set<Id> memberIds) {
        return [
            SELECT
                 Id
                ,LastName
                ,SmallPhotoUrl
            FROM
                User
            WHERE Id IN: memberIds
        ];
    }

    /**
     * Get DeleteChatterMessage
     */
    public ChatterMessage getDeleteChatterMessage(Id deleteId) {
        List<ChatterMessage> deleteChatterMessages = [
            SELECT
                Id
            FROM
                ChatterMessage
            WHERE
                Id =: deleteId
            LIMIT 1
        ];

        return deleteChatterMessages.isEmpty() ? new ChatterMessage() : deleteChatterMessages[0];
    }
}