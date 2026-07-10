CoD.zm_arcade_timer = InheritFrom(CoD.Menu)
LUI.createMenu.zm_arcade_timer = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("zm_arcade_timer", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.zm_arcade_timer)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	local Minutes = LUI.UIText.new(0, 0, 855, 899, 0, 0, 181, 228)
	Minutes:setTTF("dinnext_regular")
	Minutes:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	Minutes:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Minutes:linkToElementModel(self, "minutes", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Minutes:setText(f2_local0)
		end
	end)
	self:addElement(Minutes)
	self.Minutes = Minutes
	local COLON = LUI.UIText.new(0, 0, 899, 909, 0, 0, 181, 222)
	COLON:setText(Engine[0xF9F1239CFD921FE](0xFD0B0842931D48A))
	COLON:setTTF("dinnext_regular")
	COLON:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	COLON:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(COLON)
	self.COLON = COLON
	local Zero = LUI.UIText.new(0, 0, 909, 935, 0, 0, 181, 227)
	Zero:setText(Engine[0xF9F1239CFD921FE](0x197E75CDE0D3589))
	Zero:setTTF("dinnext_regular")
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
	local Seconds = LUI.UIText.new(0, 0, 932, 960, 0, 0, 181, 228)
	Seconds:setTTF("dinnext_regular")
	Seconds:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	Seconds:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Seconds:linkToElementModel(self, "seconds", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Seconds:setText(f4_local0)
		end
	end)
	self:addElement(Seconds)
	self.Seconds = Seconds
	local timerTitle = LUI.UIText.new(0, 0, 305.5, 1586.5, 0, 0, 130, 159)
	timerTitle:setTTF("dinnext_regular")
	timerTitle:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	timerTitle:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	timerTitle:linkToElementModel(self, "title", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			timerTitle:setText(Engine[0xF9F1239CFD921FE](f5_local0))
		end
	end)
	self:addElement(timerTitle)
	self.timerTitle = timerTitle
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
CoD.zm_arcade_timer.__onClose = function(f6_arg0)
	f6_arg0.Minutes:close()
	f6_arg0.Zero:close()
	f6_arg0.Seconds:close()
	f6_arg0.timerTitle:close()
end
