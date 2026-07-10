CoD.ScoreboardCoreStat = InheritFrom(LUI.UIElement)
CoD.ScoreboardCoreStat.__defaultWidth = 76
CoD.ScoreboardCoreStat.__defaultHeight = 51
CoD.ScoreboardCoreStat.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 5, false)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.ScoreboardCoreStat)
	self.id = "ScoreboardCoreStat"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local StatName = LUI.UIText.new(-0.8, -0.8, 61, 137, 0, 0, 0, 21)
	StatName:setRGB(0.92, 0.89, 0.72)
	StatName:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_16B234CB46B5ACD4"))
	StatName:setTTF("ttmussels_regular")
	StatName:setLetterSpacing(2)
	StatName:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(StatName)
	self.StatName = StatName
	local StatValue = LUI.UIText.new(0, 0, 19, 57, 0.5, 0.5, 0.5, 39.5)
	StatValue:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	StatValue:setAlpha(0.7)
	StatValue:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	StatValue:setTTF("0arame_mono_stencil")
	StatValue:setLetterSpacing(2)
	StatValue:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	StatValue:setBackingType(2)
	StatValue:setBackingColor(0, 0, 0)
	StatValue:setBackingAlpha(0.6)
	StatValue:setBackingXPadding(16)
	StatValue:setBackingYPadding(3)
	self:addElement(StatValue)
	self.StatValue = StatValue
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
CoD.ScoreboardCoreStat.__resetProperties = function(f3_arg0)
	f3_arg0.StatName:completeAnimation()
	f3_arg0.StatValue:completeAnimation()
	f3_arg0.StatName:setLeftRight(-0.8, -0.8, 61, 137)
	f3_arg0.StatValue:setLeftRight(0, 0, 19, 57)
	f3_arg0.StatValue:setTopBottom(0.5, 0.5, 0.5, 39.5)
end
CoD.ScoreboardCoreStat.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	PC = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.StatName:completeAnimation()
			f5_arg0.StatName:setLeftRight(0, 0, 0, 76)
			f5_arg0.clipFinished(f5_arg0.StatName)
			f5_arg0.StatValue:completeAnimation()
			f5_arg0.StatValue:setLeftRight(0, 0, 19, 57)
			f5_arg0.StatValue:setTopBottom(0, 0, 24, 51)
			f5_arg0.clipFinished(f5_arg0.StatValue)
		end,
	},
}
