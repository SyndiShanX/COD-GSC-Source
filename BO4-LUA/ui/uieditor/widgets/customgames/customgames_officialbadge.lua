CoD.CustomGames_OfficialBadge = InheritFrom(LUI.UIElement)
CoD.CustomGames_OfficialBadge.__defaultWidth = 200
CoD.CustomGames_OfficialBadge.__defaultHeight = 30
CoD.CustomGames_OfficialBadge.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CustomGames_OfficialBadge)
	self.id = "CustomGames_OfficialBadge"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local OfficialIcon = LUI.UIImage.new(0, 0, 0, 30, 0, 0, 0, 30)
	OfficialIcon:setImage(RegisterImage(@"uie_menu_mp_frontend_icon_medal"))
	self:addElement(OfficialIcon)
	self.OfficialIcon = OfficialIcon
	local CustomIcon = LUI.UIImage.new(0, 0, 0, 30, 0, 0, 0, 30)
	CustomIcon:setRGB(0.93, 0.45, 0.05)
	CustomIcon:setAlpha(0)
	CustomIcon:setImage(RegisterImage(@"uie_t7_gamesettings_asteriskicon"))
	self:addElement(CustomIcon)
	self.CustomIcon = CustomIcon
	local SettingLabel = LUI.UIText.new(0, 0, 32, 200, 0.5, 0.5, -10.5, 10.5)
	SettingLabel:setRGB(0.78, 0.74, 0.67)
	SettingLabel:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_63428A4FD23FDA2A"))
	SettingLabel:setTTF("ttmussels_regular")
	SettingLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(SettingLabel)
	self.SettingLabel = SettingLabel
	self:mergeStateConditions({
		{
			stateName = "Custom",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CustomGames_OfficialBadge.__resetProperties = function(f4_arg0)
	f4_arg0.OfficialIcon:completeAnimation()
	f4_arg0.CustomIcon:completeAnimation()
	f4_arg0.SettingLabel:completeAnimation()
	f4_arg0.OfficialIcon:setAlpha(1)
	f4_arg0.CustomIcon:setAlpha(0)
	f4_arg0.SettingLabel:setRGB(0.78, 0.74, 0.67)
	f4_arg0.SettingLabel:setAlpha(1)
	f4_arg0.SettingLabel:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_63428A4FD23FDA2A"))
end
CoD.CustomGames_OfficialBadge.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	Custom = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(3)
			f6_arg0.OfficialIcon:completeAnimation()
			f6_arg0.OfficialIcon:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.OfficialIcon)
			f6_arg0.CustomIcon:completeAnimation()
			f6_arg0.CustomIcon:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.CustomIcon)
			f6_arg0.SettingLabel:completeAnimation()
			f6_arg0.SettingLabel:setRGB(0.93, 0.45, 0.05)
			f6_arg0.SettingLabel:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_1DD2BE2574C9D2CC"))
			f6_arg0.clipFinished(f6_arg0.SettingLabel)
		end,
	},
	Hidden = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(3)
			f7_arg0.OfficialIcon:completeAnimation()
			f7_arg0.OfficialIcon:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.OfficialIcon)
			f7_arg0.CustomIcon:completeAnimation()
			f7_arg0.CustomIcon:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.CustomIcon)
			f7_arg0.SettingLabel:completeAnimation()
			f7_arg0.SettingLabel:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.SettingLabel)
		end,
	},
}
