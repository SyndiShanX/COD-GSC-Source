CoD.MapVoteMapNameGameModeLayout = InheritFrom(LUI.UIElement)
CoD.MapVoteMapNameGameModeLayout.__defaultWidth = 263
CoD.MapVoteMapNameGameModeLayout.__defaultHeight = 50
CoD.MapVoteMapNameGameModeLayout.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 4, false)
	self:setAlignment(LUI.Alignment.Bottom)
	self:setClass(CoD.MapVoteMapNameGameModeLayout)
	self.id = "MapVoteMapNameGameModeLayout"
	self.soundSet = "none"
	local MapName = LUI.UIText.new(0, 0, 19, 248, 0, 0, 2, 23)
	MapName:setRGB(0.14, 0.14, 0.14)
	MapName:setText(Engine[@"hash_4F9F1239CFD921FE"](@"mpui/offshore"))
	MapName:setTTF("ttmussels_demibold")
	MapName:setLetterSpacing(4)
	MapName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	MapName:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	MapName:setBackingType(2)
	MapName:setBackingColor(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	MapName:setBackingAlpha(0.5)
	MapName:setBackingXPadding(2)
	self:addElement(MapName)
	self.MapName = MapName
	local GameMode = LUI.UIText.new(0, 0, 19, 248, 0, 0, 30, 51)
	GameMode:setRGB(0.75, 0.73, 0.73)
	GameMode:setText(Engine[@"hash_4F9F1239CFD921FE"](0xD5F2EC9F7E1CF0))
	GameMode:setTTF("ttmussels_regular")
	GameMode:setLetterSpacing(4)
	GameMode:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	GameMode:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	GameMode:setBackingType(2)
	GameMode:setBackingColor(0, 0, 0)
	GameMode:setBackingAlpha(0.9)
	GameMode:setBackingXPadding(2)
	self:addElement(GameMode)
	self.GameMode = GameMode
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
