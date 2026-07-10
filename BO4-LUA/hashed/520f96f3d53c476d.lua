CoD.ButtonFrame_RankInfo = InheritFrom(LUI.UIElement)
CoD.ButtonFrame_RankInfo.__defaultWidth = 400
CoD.ButtonFrame_RankInfo.__defaultHeight = 200
CoD.ButtonFrame_RankInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ButtonFrame_RankInfo)
	self.id = "ButtonFrame_RankInfo"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local RankText = LUI.UIText.new(0.5, 0.5, 99, 230, 0, 0, 53, 129)
	RankText:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	RankText:setText("")
	RankText:setTTF("0arame_mono_stencil")
	RankText:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	RankText:setShaderVector(0, 1, 0, 0, 0)
	RankText:setShaderVector(1, 0, 0, 0, 0)
	RankText:setShaderVector(2, 0.3, 0.3, 0.2, 0.2)
	RankText:setLetterSpacing(2)
	RankText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	RankText:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(RankText)
	self.RankText = RankText
	local RankIconLarge = LUI.UIImage.new(0.5, 0.5, -91, 69, 0, 0, 0, 160)
	self:addElement(RankIconLarge)
	self.RankIconLarge = RankIconLarge
	local RankTitle = LUI.UIText.new(0.5, 0.5, -136.5, 114.5, 1, 1, -40, -19)
	RankTitle:setRGB(0.92, 0.92, 0.92)
	RankTitle:setAlpha(0.5)
	RankTitle:setText("")
	RankTitle:setTTF("ttmussels_demibold")
	RankTitle:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	RankTitle:setShaderVector(0, 1, 0, 0, 0)
	RankTitle:setShaderVector(1, 0, 0, 0, 0)
	RankTitle:setShaderVector(2, 0, 0, 0, 0.5)
	RankTitle:setLetterSpacing(2)
	RankTitle:setLineSpacing(1)
	RankTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	self:addElement(RankTitle)
	self.RankTitle = RankTitle
	local LevelText = LUI.UIText.new(0.5, 0.5, 99, 230, 0, 0, 32, 53)
	LevelText:setRGB(0.92, 0.92, 0.92)
	LevelText:setAlpha(0.5)
	LevelText:setText(LocalizeToUpperString(@"menu/level"))
	LevelText:setTTF("ttmussels_demibold")
	LevelText:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	LevelText:setShaderVector(0, 1, 0, 0, 0)
	LevelText:setShaderVector(1, 0, 0, 0, 0)
	LevelText:setShaderVector(2, 0, 0, 0, 0.5)
	LevelText:setLetterSpacing(2)
	LevelText:setLineSpacing(1)
	LevelText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	LevelText:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	self:addElement(LevelText)
	self.LevelText = LevelText
	self:mergeStateConditions({
		{
			stateName = "Warzone",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "WarzoneMaxRank",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ButtonFrame_RankInfo.__resetProperties = function(f4_arg0)
	f4_arg0.RankIconLarge:completeAnimation()
	f4_arg0.RankTitle:completeAnimation()
	f4_arg0.RankText:completeAnimation()
	f4_arg0.LevelText:completeAnimation()
	f4_arg0.RankIconLarge:setTopBottom(0, 0, 0, 160)
	f4_arg0.RankIconLarge:setScale(1, 1)
	f4_arg0.RankTitle:setTopBottom(1, 1, -40, -19)
	f4_arg0.RankText:setLeftRight(0.5, 0.5, 99, 230)
	f4_arg0.LevelText:setLeftRight(0.5, 0.5, 99, 230)
end
CoD.ButtonFrame_RankInfo.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	Warzone = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(4)
			f6_arg0.RankText:completeAnimation()
			f6_arg0.RankText:setLeftRight(0.5, 0.5, 91, 229)
			f6_arg0.clipFinished(f6_arg0.RankText)
			f6_arg0.RankIconLarge:completeAnimation()
			f6_arg0.RankIconLarge:setTopBottom(0, 0, -12, 148)
			f6_arg0.RankIconLarge:setScale(0.9, 0.85)
			f6_arg0.clipFinished(f6_arg0.RankIconLarge)
			f6_arg0.RankTitle:completeAnimation()
			f6_arg0.RankTitle:setTopBottom(1, 1, -64, -43)
			f6_arg0.clipFinished(f6_arg0.RankTitle)
			f6_arg0.LevelText:completeAnimation()
			f6_arg0.LevelText:setLeftRight(0.5, 0.5, 91, 229)
			f6_arg0.clipFinished(f6_arg0.LevelText)
		end,
	},
	WarzoneMaxRank = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(4)
			f7_arg0.RankText:completeAnimation()
			f7_arg0.RankText:setLeftRight(0.5, 0.5, 91, 283)
			f7_arg0.clipFinished(f7_arg0.RankText)
			f7_arg0.RankIconLarge:completeAnimation()
			f7_arg0.RankIconLarge:setTopBottom(0, 0, -12, 148)
			f7_arg0.RankIconLarge:setScale(0.9, 0.85)
			f7_arg0.clipFinished(f7_arg0.RankIconLarge)
			f7_arg0.RankTitle:completeAnimation()
			f7_arg0.RankTitle:setTopBottom(1, 1, -64, -43)
			f7_arg0.clipFinished(f7_arg0.RankTitle)
			f7_arg0.LevelText:completeAnimation()
			f7_arg0.LevelText:setLeftRight(0.5, 0.5, 91, 283)
			f7_arg0.clipFinished(f7_arg0.LevelText)
		end,
	},
}
