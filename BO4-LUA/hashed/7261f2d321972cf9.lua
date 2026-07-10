CoD.CombatTrainingSkirmishNames = InheritFrom(LUI.UIElement)
CoD.CombatTrainingSkirmishNames.__defaultWidth = 234
CoD.CombatTrainingSkirmishNames.__defaultHeight = 93
CoD.CombatTrainingSkirmishNames.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CombatTrainingSkirmishNames)
	self.id = "CombatTrainingSkirmishNames"
	self.soundSet = "default"
	local NamesBacking = LUI.UIImage.new(0, 0, 0, 234, 0, 0, 0, 93)
	NamesBacking:setRGB(0, 0, 0)
	NamesBacking:setAlpha(0.85)
	self:addElement(NamesBacking)
	self.NamesBacking = NamesBacking
	local DiffSkirmishName = LUI.UIText.new(0, 0, 5, 234, 0, 0, 6, 24)
	DiffSkirmishName:setTTF("ttmussels_regular")
	DiffSkirmishName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	DiffSkirmishName:linkToElementModel(self, "difficulty", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			DiffSkirmishName:setText(LocalizeToUpperString(CoD.CTUtility.CTDifficultyToSkirmishName(f2_local0)))
		end
	end)
	self:addElement(DiffSkirmishName)
	self.DiffSkirmishName = DiffSkirmishName
	local GametypeName = LUI.UIText.new(0, 0, 5, 234, 0, 0, 34, 58)
	GametypeName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	GametypeName:setTTF("ttmussels_regular")
	GametypeName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	GametypeName:linkToElementModel(self, "gametype", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			GametypeName:setText(GameTypeToLocalizedGameType(f3_local0))
		end
	end)
	self:addElement(GametypeName)
	self.GametypeName = GametypeName
	local MapName = LUI.UIText.new(0, 0, 5, 234, 0, 0, 60, 93)
	MapName:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	MapName:setTTF("ttmussels_regular")
	MapName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	MapName:linkToElementModel(self, "map", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			MapName:setText(CoD.MapUtility.MapNameToLocalizedToUpperName(f4_local0))
		end
	end)
	self:addElement(MapName)
	self.MapName = MapName
	local Line = LUI.UIImage.new(0, 0, 5, 229, 0, 0, 29, 31)
	Line:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	self:addElement(Line)
	self.Line = Line
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CombatTrainingSkirmishNames.__onClose = function(f5_arg0)
	f5_arg0.DiffSkirmishName:close()
	f5_arg0.GametypeName:close()
	f5_arg0.MapName:close()
end
