CoD.TabbedScoreboardHeaderTitle = InheritFrom(LUI.UIElement)
CoD.TabbedScoreboardHeaderTitle.__defaultWidth = 938
CoD.TabbedScoreboardHeaderTitle.__defaultHeight = 25
CoD.TabbedScoreboardHeaderTitle.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 10, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.TabbedScoreboardHeaderTitle)
	self.id = "TabbedScoreboardHeaderTitle"
	self.soundSet = "default"
	local GameType = LUI.UIText.new(0, 0, 0, 324, 0, 0, 0, 25)
	GameType:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	GameType:setText(ToUpper(LocalizeString(GetGameMode())))
	GameType:setTTF("ttmussels_demibold")
	GameType:setLetterSpacing(2)
	GameType:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(GameType)
	self.GameType = GameType
	local MapText = LUI.UIText.new(0.5, 0.5, -135, 321, 0, 0, 0, 25)
	MapText:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	MapText:setText(ToUpper(GetMapName()))
	MapText:setTTF("ttmussels_regular")
	MapText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(MapText)
	self.MapText = MapText
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
