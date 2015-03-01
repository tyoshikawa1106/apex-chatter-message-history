public with sharing class CMH_ChatterMessageHistoryWrapper {

    public User user {get; set;}
    public String sentDate {get; set;}
    public ChatterMessage  chatterMessage {get; set;}

    /**
     * Constructor
     */
    public CMH_ChatterMessageHistoryWrapper(ChatterMessage chatterMessage, Map<Id, Id> chatterMemberMap, Map<Id, User> userMap) {
        this.user = getUser(chatterMessage, chatterMemberMap, userMap);
        this.sentDate = getSentDate(chatterMessage);
        this.chatterMessage = chatterMessage;
    }

    /**
     * Get SentDate
     */
    private String getSentDate(ChatterMessage chatterMessage) {
        String sentDate = '';
        if (chatterMessage.SentDate != null) {
            sentDate = String.valueOf(chatterMessage.SentDate);
        }

        return sentDate;
    }

    /**
     * Get User
     */
    private User getUser(ChatterMessage chatterMessage, Map<Id, Id> chatterMemberMap, Map<Id, User> userMap) {
        User user = new User();
        Id memberId = null;

        if (chatterMemberMap.containsKey(chatterMessage.ConversationId)) {
            memberId = chatterMemberMap.get(chatterMessage.ConversationId);
        }

        if (userMap.containsKey(memberId)) {
            user = userMap.get(memberId);
        }

        return user;
    }
}