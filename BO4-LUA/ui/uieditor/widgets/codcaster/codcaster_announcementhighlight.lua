CoD.Codcaster_AnnouncementHighlight = InheritFrom(LUI.UIElement)
CoD.Codcaster_AnnouncementHighlight.__defaultWidth = 63
CoD.Codcaster_AnnouncementHighlight.__defaultHeight = 28
CoD.Codcaster_AnnouncementHighlight.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Codcaster_AnnouncementHighlight)
	self.id = "Codcaster_AnnouncementHighlight"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ledBL = LUI.UIImage.new(0, 0, 0, 56, 0, 0, 0, 28)
	ledBL:setAlpha(0)
	ledBL:setImage(RegisterImage(@"uie_codcaster_announcement_blackled"))
	self:addElement(ledBL)
	self.ledBL = ledBL
	local ledBL2 = LUI.UIImage.new(0, 0, -1, 59, 0, 0, 0, 28)
	ledBL2:setImage(RegisterImage(@"uie_codcaster_announcement_teamcolorled_01"))
	self:addElement(ledBL2)
	self.ledBL2 = ledBL2
	local separator = LUI.UIImage.new(0, 0, 55, 63, 0, 0, 2, 26)
	separator:setImage(RegisterImage(@"hash_1941AB093A82A1F7"))
	self:addElement(separator)
	self.separator = separator
	self:mergeStateConditions({
		{
			stateName = "HiddenDueToScoreboard",
			condition = function(menu, element, event)
				return true
			end,
		},
		{
			stateName = "NoRoundAndLives",
			condition = function(menu, element, event)
				local f3_local0
				if not CoD.HUDUtility.ShouldShowTeamLives(f1_arg1) and not IsGametypeSettingsValue("roundLimit", 3) then
					f3_local0 = not CoD.HUDUtility.IsGameTypeEqualToString("ctf")
				else
					f3_local0 = false
				end
				return f3_local0
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
