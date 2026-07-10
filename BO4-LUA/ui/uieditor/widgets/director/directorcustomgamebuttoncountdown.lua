require("x64:29187ea00d726c3")
CoD.DirectorCustomGameButtonCountdown = InheritFrom(LUI.UIElement)
CoD.DirectorCustomGameButtonCountdown.__defaultWidth = 360
CoD.DirectorCustomGameButtonCountdown.__defaultHeight = 45
CoD.DirectorCustomGameButtonCountdown.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.DirectorCustomGameButtonCountdown)
	self.id = "DirectorCustomGameButtonCountdown"
	self.soundSet = "default"
	local timer = LUI.UIText.new(0, 0, -10, 70, 0.5, 0.5, -22.5, 22.5)
	timer:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	timer:setTTF("ttmussels_demibold")
	timer:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	timer:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	timer:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "lobbyTimeRemaining", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			timer:setText(f2_local0)
		end
	end)
	self:addElement(timer)
	self.timer = timer
	local Spacer = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 70, 90, 0, 0, 0, 45)
	self:addElement(Spacer)
	self.Spacer = Spacer
	local CountdownText = LUI.UIText.new(0, 0, 90, 370, 0.5, 0.5, -12, 12)
	CountdownText:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	CountdownText:setTTF("ttmussels_demibold")
	CountdownText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	CountdownText:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "lobbyStatus", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			CountdownText:setText(ToUpper(f3_local0))
		end
	end)
	self:addElement(CountdownText)
	self.CountdownText = CountdownText
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorCustomGameButtonCountdown.__onClose = function(f4_arg0)
	f4_arg0.timer:close()
	f4_arg0.Spacer:close()
	f4_arg0.CountdownText:close()
end
