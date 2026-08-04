require("ui/uieditor/widgets/social/social_friendinvitedlcnotification_internal")
CoD.Social_FriendInviteDLCNotification = InheritFrom(LUI.UIElement)
CoD.Social_FriendInviteDLCNotification.__defaultWidth = 615
CoD.Social_FriendInviteDLCNotification.__defaultHeight = 50
CoD.Social_FriendInviteDLCNotification.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_FriendInviteDLCNotification)
	self.id = "Social_FriendInviteDLCNotification"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local SocialFriendInviteDLCNotificationInternal = CoD.Social_FriendInviteDLCNotification_Internal.new(f1_arg0, f1_arg1, 0, 0, 0, 615, 0, 0, 0, 50)
	SocialFriendInviteDLCNotificationInternal:linkToElementModel(self, nil, false, function(model)
		SocialFriendInviteDLCNotificationInternal:setModel(model, f1_arg1)
	end)
	self:addElement(SocialFriendInviteDLCNotificationInternal)
	self.SocialFriendInviteDLCNotificationInternal = SocialFriendInviteDLCNotificationInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Social_FriendInviteDLCNotification.__onClose = function(f3_arg0)
	f3_arg0.SocialFriendInviteDLCNotificationInternal:close()
end
