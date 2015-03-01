public with sharing class CMH_ChatterMessageHistoryController {

    private CMH_ChatterMessageHistoryHelper helper = new CMH_ChatterMessageHistoryHelper();
    private CMH_ChatterMessageHistoryDao dao = new CMH_ChatterMessageHistoryDao();
    
    public List<CMH_ChatterMessageHistoryWrapper> wrapperList {get; set;}
    public Id deleteId {get; set;}
    public String errorMessage {get; set;}

    /**
     * Constructor
     */
    public CMH_ChatterMessageHistoryController() {
        
    }

    /**
     * Init
     */
    public PageReference doInit() {
        try {
            // new
            this.errorMessage = '';
            this.deleteId = null;
            this.wrapperList = new List<CMH_ChatterMessageHistoryWrapper>();
            // Get Chagger Message
            List<ChatterMessage> chatterMessages = this.dao.getChatterMessages();
            // Get ConversationId
            Set<Id> conversationIds = this.helper.getConversationId(chatterMessages);
            
            // Get ChatterConversationMember
            List<ChatterConversationMember> chatterMembers = this.dao.getChatterConversationMember(conversationIds);
            // Get MemberMap
            Map<Id, Id> chatterMemberMap = this.helper.getChatterConversationMemberMap(chatterMembers);
            // Get MemberId
            Set<Id> memberIds = this.helper.getChatterConversationMemberId(chatterMembers);
            
            // Get User
            List<User> users = this.dao.getUsers(memberIds);
            // User Map
            Map<Id, User> userMap = new Map<Id, User>(users);

            // Get Wrapper List
            this.wrapperList = this.helper.getChatterMessageHistoryWrapperList(chatterMessages, chatterMemberMap, userMap);
        } catch (Exception e) {
            this.errorMessage = e.getMessage();
            return null;
        }

        return null;
    }

    /**
     * Delete
     */
    public void doDelete() {
        try {
            // Get DeleteChatter Message
            ChatterMessage delChatterMessage = this.dao.getDeleteChatterMessage(this.deleteId);
            // Check DeleteId
            this.errorMessage = this.helper.isEmptyDeleteId(delChatterMessage.Id);
            if (String.isNotEmpty(this.errorMessage)) return;
            // Delete
            delete delChatterMessage;
            // Init
            doInit();
        } catch (DmlException e) {
            this.errorMessage = e.getDmlMessage(0);
        } catch (Exception e) {
            this.errorMessage = e.getMessage();
        }
    }
}