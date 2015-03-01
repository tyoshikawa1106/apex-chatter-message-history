public with sharing class CMH_ChatterMessageHistoryHelper {
    
    /**
     * Constructor
     */
    public CMH_ChatterMessageHistoryHelper() {
        
    }

    /**
     * Get ConversationId
     */
    public Set<Id> getConversationId(List<ChatterMessage> chatterMessages) {
        Set<Id> conversationIds = new Set<Id>();
        for (ChatterMessage c : chatterMessages) {
            conversationIds.add(c.ConversationId);
        }

        return conversationIds;
    }

    /**
     * Get ChatterConversationMemberMap
     */
    public Map<Id, Id> getChatterConversationMemberMap(List<ChatterConversationMember> chatterMembers) {
        Map<Id, Id> chatterMemberMap = new Map<Id, Id>();
        for (ChatterConversationMember c : chatterMembers) {
            chatterMemberMap.put(c.ConversationId, c.MemberId);
        }

        return chatterMemberMap;
    }

    /**
     * Get ChatterConversationMemberId
     */
    public Set<Id> getChatterConversationMemberId(List<ChatterConversationMember> chatterMembers) {
        Set<Id> memberIds = new Set<Id>();
        for (ChatterConversationMember c : chatterMembers) {
            memberIds.add(c.MemberId);
        }

        return memberIds;
    }

    /**
     * Get ChatterMessageHistoryWrapperList
     */
    public List<CMH_ChatterMessageHistoryWrapper> getChatterMessageHistoryWrapperList(List<ChatterMessage> chatterMessages, Map<Id, Id> chatterMemberMap, Map<Id, User> userMap) {
        List<CMH_ChatterMessageHistoryWrapper> wrapperList = new List<CMH_ChatterMessageHistoryWrapper>();
        for (ChatterMessage c : chatterMessages) {
            wrapperList.add(new CMH_ChatterMessageHistoryWrapper(c, chatterMemberMap, userMap));
        }

        return wrapperList;
    }

    /**
     * Check Delete Id
     */
    public String isEmptyDeleteId(Id deleteId) {
        if (deleteId == null) {
            return System.Label.CMH_NotRecord;
        }

        return '';
    }
}