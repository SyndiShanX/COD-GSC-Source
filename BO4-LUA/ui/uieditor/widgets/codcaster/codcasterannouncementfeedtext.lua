CoD.CodCasterAnnouncementFeedText = InheritFrom(LUI.UIElement)
CoD.CodCasterAnnouncementFeedText.__defaultWidth = 605
CoD.CodCasterAnnouncementFeedText.__defaultHeight = 15
CoD.CodCasterAnnouncementFeedText.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterAnnouncementFeedText)
	self.id = "CodCasterAnnouncementFeedText"
	self.soundSet = "default"
	local AnnouncementFeedHeader = LUI.UIText.new(0.5, 0.5, -302.5, 302.5, 0.5, 0.5, -9.5, 8.5)
	AnnouncementFeedHeader:setText(Engine[0xF9F1239CFD921FE](0x89BC51ECA1CF2FF))
	AnnouncementFeedHeader:setTTF("notosans_bold")
	AnnouncementFeedHeader:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	AnnouncementFeedHeader:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(AnnouncementFeedHeader)
	self.AnnouncementFeedHeader = AnnouncementFeedHeader
	local AnnouncementFeed = LUI.UIText.new(0.5, 0.5, -302.5, 302.5, 0.5, 0.5, -9.5, 8.5)
	AnnouncementFeed:setText(Engine[0xF9F1239CFD921FE](0x89BC51ECA1CF2FF))
	AnnouncementFeed:setTTF("notosans_bold")
	AnnouncementFeed:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	AnnouncementFeed:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(AnnouncementFeed)
	self.AnnouncementFeed = AnnouncementFeed
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
