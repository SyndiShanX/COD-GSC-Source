CoD.zm_game_timer = InheritFrom(CoD.Menu)
LUI.createMenu.zm_game_timer = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("zm_game_timer", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.zm_game_timer)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	local Seconds = LUI.UIText.new(0, 0, 977, 1032, 0, 0, 85, 154)
	Seconds:setTTF("default")
	Seconds:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	Seconds:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Seconds:linkToElementModel(self, "seconds", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Seconds:setText(f2_local0)
		end
	end)
	self:addElement(Seconds)
	self.Seconds = Seconds
	local Zero = LUI.UIText.new(0, 0, 977, 1032, 0, 0, 85, 154)
	Zero:setText(Engine[0xF9F1239CFD921FE](0x197E75CDE0D3589))
	Zero:setTTF("default")
	Zero:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Zero:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Zero:linkToElementModel(self, "showzero", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Zero:setAlpha(f3_local0)
		end
	end)
	self:addElement(Zero)
	self.Zero = Zero
	local COLON = LUI.UIText.new(0, 0, 960, 977, 0, 0, 78, 147)
	COLON:setText(Engine[0xF9F1239CFD921FE](0xFD0B0842931D48A))
	COLON:setTTF("default")
	COLON:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	COLON:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(COLON)
	self.COLON = COLON
	local Minutes = LUI.UIText.new(0, 0, 897, 952, 0, 0, 85, 154)
	Minutes:setTTF("default")
	Minutes:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	Minutes:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Minutes:linkToElementModel(self, "minutes", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Minutes:setText(f4_local0)
		end
	end)
	self:addElement(Minutes)
	self.Minutes = Minutes
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.zm_game_timer.__onClose = function(f5_arg0)
	f5_arg0.Seconds:close()
	f5_arg0.Zero:close()
	f5_arg0.Minutes:close()
end
