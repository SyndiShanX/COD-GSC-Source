require("x64:227b5dd83a4801c")
require("x64:6466c2aec2cf6a4")
CoD.WeaponLevelMeterPrimary = InheritFrom(LUI.UIElement)
CoD.WeaponLevelMeterPrimary.__defaultWidth = 1580
CoD.WeaponLevelMeterPrimary.__defaultHeight = 12
CoD.WeaponLevelMeterPrimary.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WeaponLevelMeterPrimary)
	self.id = "WeaponLevelMeterPrimary"
	self.soundSet = "CAC"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local bg = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 24)
	bg:setRGB(0, 0, 0)
	bg:setAlpha(0)
	self:addElement(bg)
	self.bg = bg
	local levelBg = LUI.UIImage.new(0, 0, 0, 123, 0, 0, 0, 24)
	levelBg:setRGB(0.97, 0.92, 0.07)
	levelBg:setAlpha(0)
	self:addElement(levelBg)
	self.levelBg = levelBg
	local progressBar = CoD.progressBarPrimary.new(f1_arg0, f1_arg1, 0, 0, 7, 1587, 0, 0, 0, 12)
	progressBar:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	progressBar:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	progressBar:linkToElementModel(self, nil, false, function(model)
		progressBar:setModel(model, f1_arg1)
	end)
	self:addElement(progressBar)
	self.progressBar = progressBar
	local LvlBg = LUI.UIImage.new(0, 0, -4.5, 105.5, 0, 0, -29.5, 0.5)
	LvlBg:setAlpha(0)
	LvlBg:setScale(1.05, 1.05)
	LvlBg:setImage(RegisterImage(@"uie_ui_menu_cac_attachment_lvl_bg_01"))
	self:addElement(LvlBg)
	self.LvlBg = LvlBg
	local WeaponLevelWidget = CoD.WeaponLevelWidget.new(f1_arg0, f1_arg1, 0, 0, 15, 138, 0, 0, -171.5, -111.5)
	WeaponLevelWidget:linkToElementModel(self, nil, false, function(model)
		WeaponLevelWidget:setModel(model, f1_arg1)
	end)
	self:addElement(WeaponLevelWidget)
	self.WeaponLevelWidget = WeaponLevelWidget
	self:mergeStateConditions({
		{
			stateName = "DoubleWeaponXP",
			condition = function(menu, element, event)
				local f5_local0 = CoD.CACUtility.IsCACGunLevelExists(menu, element, f1_arg1)
				if f5_local0 then
					if not CoD.CACUtility.IsCACGunLevelMax(menu, element, f1_arg1) then
						f5_local0 = CoD.DoubleXPUtility.HasDoubleWeaponXP(f1_arg1, element)
						if f5_local0 then
							f5_local0 = not IsArenaMode()
						end
					else
						f5_local0 = false
					end
				end
				return f5_local0
			end,
		},
		{
			stateName = "DisplayLevel",
			condition = function(menu, element, event)
				local f6_local0 = CoD.CACUtility.IsCACGunLevelExists(menu, element, f1_arg1)
				if f6_local0 then
					if not CoD.CACUtility.IsCACGunLevelMax(menu, element, f1_arg1) and not CoD.DoubleXPUtility.HasDoubleWeaponXP(f1_arg1, element) then
						f6_local0 = not IsArenaMode()
					else
						f6_local0 = false
					end
				end
				return f6_local0
			end,
		},
		{
			stateName = "MaxLevel",
			condition = function(menu, element, event)
				local f7_local0 = CoD.CACUtility.IsCACGunLevelExists(menu, element, f1_arg1)
				if f7_local0 then
					f7_local0 = CoD.CACUtility.IsCACGunLevelMax(menu, element, f1_arg1)
					if f7_local0 then
						f7_local0 = not IsArenaMode()
					end
				end
				return f7_local0
			end,
		},
	})
	self:linkToElementModel(self, "itemIndex", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "itemIndex",
		})
	end)
	self:linkToElementModel(self, "hasDoubleWeaponXP", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "hasDoubleWeaponXP",
		})
	end)
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = DataSources.AutoEvents.getModel(f1_arg1)
	f1_local7(f1_local6, f1_local8.cycled, function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "cycled",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = Engine[@"getglobalmodel"]()
	f1_local7(f1_local6, f1_local8["lobbyRoot.lobbyNav"], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WeaponLevelMeterPrimary.__resetProperties = function(f12_arg0)
	f12_arg0.levelBg:completeAnimation()
	f12_arg0.bg:completeAnimation()
	f12_arg0.progressBar:completeAnimation()
	f12_arg0.WeaponLevelWidget:completeAnimation()
	f12_arg0.levelBg:setRGB(0.97, 0.92, 0.07)
	f12_arg0.levelBg:setAlpha(0)
	f12_arg0.bg:setAlpha(0)
	f12_arg0.progressBar:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	f12_arg0.progressBar:setAlpha(1)
	f12_arg0.WeaponLevelWidget:setAlpha(1)
	f12_arg0.WeaponLevelWidget.LevelLabel:setRGB(ColorSet.GroupName.r, ColorSet.GroupName.g, ColorSet.GroupName.b)
	f12_arg0.WeaponLevelWidget.PrestigeStar1:setRGB(ColorSet.GroupName.r, ColorSet.GroupName.g, ColorSet.GroupName.b)
	f12_arg0.WeaponLevelWidget.PrestigeStar2:setRGB(ColorSet.GroupName.r, ColorSet.GroupName.g, ColorSet.GroupName.b)
end
CoD.WeaponLevelMeterPrimary.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(4)
			f13_arg0.bg:completeAnimation()
			f13_arg0.bg:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.bg)
			f13_arg0.levelBg:completeAnimation()
			f13_arg0.levelBg:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.levelBg)
			f13_arg0.progressBar:completeAnimation()
			f13_arg0.progressBar:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.progressBar)
			f13_arg0.WeaponLevelWidget:completeAnimation()
			f13_arg0.WeaponLevelWidget:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.WeaponLevelWidget)
		end,
	},
	DoubleWeaponXP = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(3)
			f14_arg0.levelBg:completeAnimation()
			f14_arg0.levelBg:setRGB(0.31, 0.13, 0.47)
			f14_arg0.clipFinished(f14_arg0.levelBg)
			f14_arg0.progressBar:completeAnimation()
			f14_arg0.progressBar:setRGB(0.78, 0.43, 1)
			f14_arg0.clipFinished(f14_arg0.progressBar)
			f14_arg0.WeaponLevelWidget:completeAnimation()
			f14_arg0.WeaponLevelWidget.LevelLabel:completeAnimation()
			f14_arg0.WeaponLevelWidget.PrestigeStar1:completeAnimation()
			f14_arg0.WeaponLevelWidget.PrestigeStar2:completeAnimation()
			f14_arg0.WeaponLevelWidget.LevelLabel:setRGB(0.78, 0.43, 1)
			f14_arg0.WeaponLevelWidget.PrestigeStar1:setRGB(0.78, 0.43, 1)
			f14_arg0.WeaponLevelWidget.PrestigeStar2:setRGB(0.78, 0.43, 1)
			f14_arg0.clipFinished(f14_arg0.WeaponLevelWidget)
		end,
	},
	DisplayLevel = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.WeaponLevelWidget:completeAnimation()
			f15_arg0.WeaponLevelWidget.LevelLabel:completeAnimation()
			f15_arg0.WeaponLevelWidget.PrestigeStar1:completeAnimation()
			f15_arg0.WeaponLevelWidget.PrestigeStar2:completeAnimation()
			f15_arg0.WeaponLevelWidget.LevelLabel:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
			f15_arg0.WeaponLevelWidget.PrestigeStar1:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
			f15_arg0.WeaponLevelWidget.PrestigeStar2:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
			f15_arg0.clipFinished(f15_arg0.WeaponLevelWidget)
		end,
	},
	MaxLevel = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(3)
			f16_arg0.bg:completeAnimation()
			f16_arg0.bg:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.bg)
			f16_arg0.progressBar:completeAnimation()
			f16_arg0.progressBar:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.progressBar)
			f16_arg0.WeaponLevelWidget:completeAnimation()
			f16_arg0.WeaponLevelWidget.LevelLabel:completeAnimation()
			f16_arg0.WeaponLevelWidget.PrestigeStar1:completeAnimation()
			f16_arg0.WeaponLevelWidget.PrestigeStar2:completeAnimation()
			f16_arg0.WeaponLevelWidget.LevelLabel:setRGB(0.58, 0.78, 0.32)
			f16_arg0.WeaponLevelWidget.PrestigeStar1:setRGB(0.58, 0.78, 0.32)
			f16_arg0.WeaponLevelWidget.PrestigeStar2:setRGB(0.58, 0.78, 0.32)
			f16_arg0.clipFinished(f16_arg0.WeaponLevelWidget)
		end,
	},
}
CoD.WeaponLevelMeterPrimary.__onClose = function(f17_arg0)
	f17_arg0.progressBar:close()
	f17_arg0.WeaponLevelWidget:close()
end
