CoD.PlayerStatsHeader = InheritFrom(LUI.UIElement)
CoD.PlayerStatsHeader.__defaultWidth = 200
CoD.PlayerStatsHeader.__defaultHeight = 21
CoD.PlayerStatsHeader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PlayerStatsHeader)
	self.id = "PlayerStatsHeader"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -10.5, 10.5)
	Image:setAlpha(0.18)
	self:addElement(Image)
	self.Image = Image
	local HeaderText = LUI.UIText.new(0, 0, 6, 204, 0.5, 0.5, -9, 9)
	HeaderText:setRGB(0.14, 0.14, 0.14)
	HeaderText:setText(LocalizeToUpperString(@"menu/efficiency"))
	HeaderText:setTTF("ttmussels_demibold")
	HeaderText:setLetterSpacing(1)
	HeaderText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(HeaderText)
	self.HeaderText = HeaderText
	self:mergeStateConditions({
		{
			stateName = "AsianLanguage",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PlayerStatsHeader.__resetProperties = function(f3_arg0)
	f3_arg0.HeaderText:completeAnimation()
	f3_arg0.HeaderText:setTopBottom(0.5, 0.5, -9, 9)
end
CoD.PlayerStatsHeader.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	AsianLanguage = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.HeaderText:completeAnimation()
			f5_arg0.HeaderText:setTopBottom(0.5, 0.5, -3.5, 9.5)
			f5_arg0.clipFinished(f5_arg0.HeaderText)
		end,
	},
}
