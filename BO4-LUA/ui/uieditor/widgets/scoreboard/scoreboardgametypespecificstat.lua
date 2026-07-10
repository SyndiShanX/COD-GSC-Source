CoD.ScoreboardGameTypeSpecificStat = InheritFrom(LUI.UIElement)
CoD.ScoreboardGameTypeSpecificStat.__defaultWidth = 94
CoD.ScoreboardGameTypeSpecificStat.__defaultHeight = 26
CoD.ScoreboardGameTypeSpecificStat.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 12, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.ScoreboardGameTypeSpecificStat)
	self.id = "ScoreboardGameTypeSpecificStat"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local StatValue = LUI.UIText.new(0, 0, 0, 76, 0, 0, 0, 21)
	StatValue:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	StatValue:setAlpha(0.7)
	StatValue:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	StatValue:setTTF("0arame_mono_stencil")
	StatValue:setLetterSpacing(2)
	StatValue:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	StatValue:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(StatValue)
	self.StatValue = StatValue
	local StatName = LUI.UIText.new(0, 0, 88, 164, 0, 0, 0, 21)
	StatName:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	StatName:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	StatName:setTTF("ttmussels_regular")
	StatName:setLetterSpacing(2)
	StatName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(StatName)
	self.StatName = StatName
	self:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ScoreboardGameTypeSpecificStat.__resetProperties = function(f3_arg0)
	f3_arg0.StatName:completeAnimation()
	f3_arg0.StatName:setLeftRight(0, 0, 88, 164)
end
CoD.ScoreboardGameTypeSpecificStat.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	PC = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.StatName:completeAnimation()
			f5_arg0.StatName:setLeftRight(0, 0, 88, 451)
			f5_arg0.clipFinished(f5_arg0.StatName)
		end,
	},
}
