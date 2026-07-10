CoD.TabbedScoreboardHeaderScoreFriendly = InheritFrom(LUI.UIElement)
CoD.TabbedScoreboardHeaderScoreFriendly.__defaultWidth = 157
CoD.TabbedScoreboardHeaderScoreFriendly.__defaultHeight = 64
CoD.TabbedScoreboardHeaderScoreFriendly.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.TabbedScoreboardHeaderScoreFriendly)
	self.id = "TabbedScoreboardHeaderScoreFriendly"
	self.soundSet = "default"
	local FriendlyKills = LUI.UIText.new(0, 0, 0, 157, 0, 0, 0, 64)
	FriendlyKills:setTTF("0arame_mono_stencil")
	FriendlyKills:setLetterSpacing(2)
	FriendlyKills:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	FriendlyKills:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	FriendlyKills:linkToElementModel(self, "factionScore", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			FriendlyKills:setText(f2_local0)
		end
	end)
	self:addElement(FriendlyKills)
	self.FriendlyKills = FriendlyKills
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabbedScoreboardHeaderScoreFriendly.__onClose = function(f3_arg0)
	f3_arg0.FriendlyKills:close()
end
