CoD.StartMenu_Options_Network_PingListItem = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_Network_PingListItem.__defaultWidth = 126
CoD.StartMenu_Options_Network_PingListItem.__defaultHeight = 126
CoD.StartMenu_Options_Network_PingListItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_Network_PingListItem)
	self.id = "StartMenu_Options_Network_PingListItem"
	self.soundSet = "ChooseDecal"
	local pingImage = LUI.UIImage.new(0.5, 0.5, -48, 48, 0, 0, 0, 96)
	self:addElement(pingImage)
	self.pingImage = pingImage
	local pingText = LUI.UIText.new(0.5, 0.5, -150, 150, 0, 0, 97.5, 118.5)
	pingText:setRGB(0.78, 0.74, 0.67)
	pingText:setTTF("dinnext_regular")
	pingText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(pingText)
	self.pingText = pingText
	self.pingImage:linkToElementModel(self, "pingIndex", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			pingImage:setImage(RegisterImage(GetScoreboardPlayerPingBarImage(f2_local0)))
		end
	end)
	self.pingText:linkToElementModel(self, "pingIndex", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			pingText:setText(GetScoreboardPlayerPingRange(f3_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_Network_PingListItem.__onClose = function(f4_arg0)
	f4_arg0.pingImage:close()
	f4_arg0.pingText:close()
end
