CoD.LoadingScreenPlayerStats = InheritFrom(LUI.UIElement)
CoD.LoadingScreenPlayerStats.__defaultWidth = 465
CoD.LoadingScreenPlayerStats.__defaultHeight = 70
CoD.LoadingScreenPlayerStats.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LoadingScreenPlayerStats)
	self.id = "LoadingScreenPlayerStats"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BackingTint = LUI.UIImage.new(0, 0, 2.5, 464.5, 0, 0, 0, 70)
	BackingTint:setRGB(0.22, 0.22, 0.22)
	self:addElement(BackingTint)
	self.BackingTint = BackingTint
	local BackingNoise = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackingNoise:setAlpha(0.5)
	BackingNoise:setImage(RegisterImage("uie_ui_menu_specialist_hub_repeat_bg"))
	BackingNoise:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	BackingNoise:setShaderVector(0, 0, 0, 0, 0)
	BackingNoise:setupNineSliceShader(196, 88)
	self:addElement(BackingNoise)
	self.BackingNoise = BackingNoise
	local Stat1Label = LUI.UIText.new(0, 0, 5, 148, 0, 0, 14, 32)
	Stat1Label:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Stat1Label:setTTF("ttmussels_regular")
	Stat1Label:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	Stat1Label:linkToElementModel(self, "stat1Label", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Stat1Label:setText(LocalizeToUpperString(f2_local0))
		end
	end)
	self:addElement(Stat1Label)
	self.Stat1Label = Stat1Label
	local Stat1 = LUI.UIText.new(0, 0, 5, 148, 0, 0, 37, 67)
	Stat1:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	Stat1:setTTF("0arame_mono_stencil")
	Stat1:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	Stat1:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	Stat1:linkToElementModel(self, "stat1", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Stat1:setText(f3_local0)
		end
	end)
	self:addElement(Stat1)
	self.Stat1 = Stat1
	local Stat2Label = LUI.UIText.new(0, 0, 161, 304, 0, 0, 14, 32)
	Stat2Label:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Stat2Label:setTTF("ttmussels_regular")
	Stat2Label:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	Stat2Label:linkToElementModel(self, "stat2Label", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Stat2Label:setText(LocalizeToUpperString(f4_local0))
		end
	end)
	self:addElement(Stat2Label)
	self.Stat2Label = Stat2Label
	local Stat2 = LUI.UIText.new(0, 0, 161, 304, 0, 0, 37, 67)
	Stat2:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	Stat2:setTTF("0arame_mono_stencil")
	Stat2:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	Stat2:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	Stat2:linkToElementModel(self, "stat2", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Stat2:setText(f5_local0)
		end
	end)
	self:addElement(Stat2)
	self.Stat2 = Stat2
	local Stat3Label = LUI.UIText.new(0, 0, 317, 460, 0, 0, 14, 32)
	Stat3Label:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Stat3Label:setTTF("ttmussels_regular")
	Stat3Label:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	Stat3Label:linkToElementModel(self, "stat3Label", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			Stat3Label:setText(LocalizeToUpperString(f6_local0))
		end
	end)
	self:addElement(Stat3Label)
	self.Stat3Label = Stat3Label
	local Stat3 = LUI.UIText.new(0, 0, 317, 460, 0, 0, 37, 67)
	Stat3:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	Stat3:setTTF("0arame_mono_stencil")
	Stat3:setAlignment(Enum.LUIAlignment[@"lui_alignment_center"])
	Stat3:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	Stat3:linkToElementModel(self, "stat3", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			Stat3:setText(f7_local0)
		end
	end)
	self:addElement(Stat3)
	self.Stat3 = Stat3
	local Divider = LUI.UIImage.new(0, 0, 154, 155, 0.5, 0.5, -30, 30)
	Divider:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Divider:setAlpha(0.5)
	self:addElement(Divider)
	self.Divider = Divider
	local Divider2 = LUI.UIImage.new(0, 0, 309.5, 310.5, 0.5, 0.5, -30, 30)
	Divider2:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Divider2:setAlpha(0.5)
	self:addElement(Divider2)
	self.Divider2 = Divider2
	local Arrow = LUI.UIImage.new(0, 0, 66.5, 86.5, 0, 0, -5, 15)
	Arrow:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Arrow:setAlpha(0.7)
	Arrow:setImage(RegisterImage("uie_ui_loadscreen_arrow"))
	self:addElement(Arrow)
	self.Arrow = Arrow
	local Image = LUI.UIImage.new(0, 0, 222.5, 242.5, 0, 0, -5, 15)
	Image:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Image:setAlpha(0.7)
	Image:setImage(RegisterImage("uie_ui_loadscreen_arrow"))
	self:addElement(Image)
	self.Image = Image
	local Image2 = LUI.UIImage.new(0, 0, 378.5, 398.5, 0, 0, -5, 15)
	Image2:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Image2:setAlpha(0.7)
	Image2:setImage(RegisterImage("uie_ui_loadscreen_arrow"))
	self:addElement(Image2)
	self.Image2 = Image2
	local TitleModesStats = LUI.UIText.new(0, 0, 0, 960, 0, 0, -26, -5)
	TitleModesStats:setRGB(0.66, 0.66, 0.66)
	TitleModesStats:setText(LocalizeToUpperString(@"hash_49271DCE3B09CFBF"))
	TitleModesStats:setTTF("ttmussels_demibold")
	TitleModesStats:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	TitleModesStats:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(TitleModesStats)
	self.TitleModesStats = TitleModesStats
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "statsValid")
			end,
		},
	})
	self:linkToElementModel(self, "statsValid", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "statsValid",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LoadingScreenPlayerStats.__resetProperties = function(f10_arg0)
	f10_arg0.Stat3:completeAnimation()
	f10_arg0.Stat3Label:completeAnimation()
	f10_arg0.Stat2:completeAnimation()
	f10_arg0.Stat2Label:completeAnimation()
	f10_arg0.Stat1:completeAnimation()
	f10_arg0.Stat1Label:completeAnimation()
	f10_arg0.TitleModesStats:completeAnimation()
	f10_arg0.Arrow:completeAnimation()
	f10_arg0.Image:completeAnimation()
	f10_arg0.Image2:completeAnimation()
	f10_arg0.Divider2:completeAnimation()
	f10_arg0.Divider:completeAnimation()
	f10_arg0.Stat3:setAlpha(1)
	f10_arg0.Stat3Label:setAlpha(1)
	f10_arg0.Stat2:setAlpha(1)
	f10_arg0.Stat2Label:setAlpha(1)
	f10_arg0.Stat1:setAlpha(1)
	f10_arg0.Stat1Label:setAlpha(1)
	f10_arg0.TitleModesStats:setAlpha(1)
	f10_arg0.Arrow:setAlpha(0.7)
	f10_arg0.Image:setAlpha(0.7)
	f10_arg0.Image2:setAlpha(0.7)
	f10_arg0.Divider2:setAlpha(0.5)
	f10_arg0.Divider:setAlpha(0.5)
end
CoD.LoadingScreenPlayerStats.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(12)
			f12_arg0.Stat1Label:completeAnimation()
			f12_arg0.Stat1Label:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Stat1Label)
			f12_arg0.Stat1:completeAnimation()
			f12_arg0.Stat1:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Stat1)
			f12_arg0.Stat2Label:completeAnimation()
			f12_arg0.Stat2Label:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Stat2Label)
			f12_arg0.Stat2:completeAnimation()
			f12_arg0.Stat2:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Stat2)
			f12_arg0.Stat3Label:completeAnimation()
			f12_arg0.Stat3Label:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Stat3Label)
			f12_arg0.Stat3:completeAnimation()
			f12_arg0.Stat3:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Stat3)
			f12_arg0.Divider:completeAnimation()
			f12_arg0.Divider:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Divider)
			f12_arg0.Divider2:completeAnimation()
			f12_arg0.Divider2:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Divider2)
			f12_arg0.Arrow:completeAnimation()
			f12_arg0.Arrow:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Arrow)
			f12_arg0.Image:completeAnimation()
			f12_arg0.Image:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Image)
			f12_arg0.Image2:completeAnimation()
			f12_arg0.Image2:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Image2)
			f12_arg0.TitleModesStats:completeAnimation()
			f12_arg0.TitleModesStats:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.TitleModesStats)
		end,
	},
}
CoD.LoadingScreenPlayerStats.__onClose = function(f13_arg0)
	f13_arg0.Stat1Label:close()
	f13_arg0.Stat1:close()
	f13_arg0.Stat2Label:close()
	f13_arg0.Stat2:close()
	f13_arg0.Stat3Label:close()
	f13_arg0.Stat3:close()
end
