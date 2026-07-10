CoD.ActorOverheadName_ZM = InheritFrom(LUI.UIElement)
CoD.ActorOverheadName_ZM.__defaultWidth = 200
CoD.ActorOverheadName_ZM.__defaultHeight = 75
CoD.ActorOverheadName_ZM.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ActorOverheadName_ZM)
	self.id = "ActorOverheadName_ZM"
	self.soundSet = "default"
	local PlayerName = LUI.UIText.new(0, 0, 0, 200, 0, 0, 26.5, 53.5)
	PlayerName:setTTF("notosans_regular")
	PlayerName:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	PlayerName:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	PlayerName:linkToElementModel(self, "displayName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PlayerName:setText(f2_local0)
		end
	end)
	self:addElement(PlayerName)
	self.PlayerName = PlayerName
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ActorOverheadName_ZM.__onClose = function(f3_arg0)
	f3_arg0.PlayerName:close()
end
