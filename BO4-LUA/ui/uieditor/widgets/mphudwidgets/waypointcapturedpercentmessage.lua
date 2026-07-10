CoD.WaypointCapturedPercentMessage = InheritFrom(LUI.UIElement)
CoD.WaypointCapturedPercentMessage.__defaultWidth = 610
CoD.WaypointCapturedPercentMessage.__defaultHeight = 27
CoD.WaypointCapturedPercentMessage.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 20, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.WaypointCapturedPercentMessage)
	self.id = "WaypointCapturedPercentMessage"
	self.soundSet = "default"
	local ContribText = LUI.UIText.new(0.5, 0.5, -310, 90, 0.5, 0.5, -13.5, 16.5)
	ContribText:setText(LocalizeToUpperString(0x85431C36F266D33))
	ContribText:setTTF("ttmussels_demibold")
	ContribText:setLetterSpacing(2)
	ContribText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ContribText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(ContribText)
	self.ContribText = ContribText
	local Percentage = LUI.UIText.new(0.5, 0.5, 110, 310, 0.5, 0.5, -13.5, 16.5)
	Percentage:setRGB(ColorSet.FriendlyBlue.r, ColorSet.FriendlyBlue.g, ColorSet.FriendlyBlue.b)
	Percentage:setTTF("ttmussels_demibold")
	Percentage:setLetterSpacing(2)
	Percentage:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Percentage:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Percentage:linkToElementModel(self, "percentage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Percentage:setText(NumberAsPercent(f2_local0))
		end
	end)
	self:addElement(Percentage)
	self.Percentage = Percentage
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local3 = self
	if IsCurrentLanguageReversed() then
		ReverseChildrenOrder(self)
	end
	return self
end
CoD.WaypointCapturedPercentMessage.__onClose = function(f3_arg0)
	f3_arg0.Percentage:close()
end
