require("x64:4f41483c58f36b0")
require("x64:6466c2aec2cf6a4")
CoD.ButtonWeaponLevel = InheritFrom(LUI.UIElement)
CoD.ButtonWeaponLevel.__defaultWidth = 550
CoD.ButtonWeaponLevel.__defaultHeight = 12
CoD.ButtonWeaponLevel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ButtonWeaponLevel)
	self.id = "ButtonWeaponLevel"
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
	local progressBarBgExtraOpacity = LUI.UIImage.new(0, 0, 1, 265, 0, 0, 4.5, 7.5)
	progressBarBgExtraOpacity:setRGB(0, 0, 0)
	progressBarBgExtraOpacity:setAlpha(0.5)
	self:addElement(progressBarBgExtraOpacity)
	self.progressBarBgExtraOpacity = progressBarBgExtraOpacity
	local progressBarBg = LUI.UIImage.new(0.5, 0.5, -269.5, -12.5, 0, 0, -96, 9)
	progressBarBg:setRGB(0, 0, 0)
	progressBarBg:setScale(1.1, 1.1)
	progressBarBg:setImage(RegisterImage(@"uie_ui_menu_cac_weapon_select_button_bar"))
	self:addElement(progressBarBg)
	self.progressBarBg = progressBarBg
	local progressBar = CoD.WeaponLevelMeterSmall.new(f1_arg0, f1_arg1, 0, 0, 0, 1580, 0, 0, 0, 12)
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
	local WeaponLevelWidget = CoD.WeaponLevelWidget.new(f1_arg0, f1_arg1, 0, 0, 0, 123, 0, 0, -130, -70)
	WeaponLevelWidget:linkToElementModel(self, nil, false, function(model)
		WeaponLevelWidget:setModel(model, f1_arg1)
	end)
	self:addElement(WeaponLevelWidget)
	self.WeaponLevelWidget = WeaponLevelWidget
	self:mergeStateConditions({
		{
			stateName = "DoubleWeaponXP",
			condition = function(menu, element, event)
				local f5_local0
				if not IsArenaMode() and not IsPaintshop(f1_arg1) then
					f5_local0 = CoD.CACUtility.IsCACGunLevelExists(menu, element, f1_arg1)
					if f5_local0 then
						if not CoD.CACUtility.IsCACGunLevelMax(menu, element, f1_arg1) then
							f5_local0 = CoD.DoubleXPUtility.HasDoubleWeaponXP(f1_arg1, element)
						else
							f5_local0 = false
						end
					end
				else
					f5_local0 = false
				end
				return f5_local0
			end,
		},
		{
			stateName = "DisplayLevel",
			condition = function(menu, element, event)
				local f6_local0
				if not IsArenaMode() and not IsPaintshop(f1_arg1) then
					f6_local0 = CoD.CACUtility.IsCACGunLevelExists(menu, element, f1_arg1)
					if f6_local0 then
						if not CoD.CACUtility.IsCACGunLevelMax(menu, element, f1_arg1) then
							f6_local0 = not CoD.DoubleXPUtility.HasDoubleWeaponXP(f1_arg1, element)
						else
							f6_local0 = false
						end
					end
				else
					f6_local0 = false
				end
				return f6_local0
			end,
		},
		{
			stateName = "MaxLevel",
			condition = function(menu, element, event)
				local f7_local0
				if not IsArenaMode() and not IsPaintshop(f1_arg1) then
					f7_local0 = CoD.CACUtility.IsCACGunLevelExists(menu, element, f1_arg1)
					if f7_local0 then
						f7_local0 = CoD.CACUtility.IsCACGunLevelMax(menu, element, f1_arg1)
					end
				else
					f7_local0 = false
				end
				return f7_local0
			end,
		},
	})
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = Engine[@"getglobalmodel"]()
	f1_local9(f1_local8, f1_local10["lobbyRoot.lobbyNav"], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
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
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = DataSources.AutoEvents.getModel(f1_arg1)
	f1_local9(f1_local8, f1_local10.cycled, function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "cycled",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ButtonWeaponLevel.__resetProperties = function(f12_arg0)
	f12_arg0.levelBg:completeAnimation()
	f12_arg0.bg:completeAnimation()
	f12_arg0.progressBar:completeAnimation()
	f12_arg0.LvlBg:completeAnimation()
	f12_arg0.WeaponLevelWidget:completeAnimation()
	f12_arg0.progressBarBg:completeAnimation()
	f12_arg0.progressBarBgExtraOpacity:completeAnimation()
	f12_arg0.levelBg:setRGB(0.97, 0.92, 0.07)
	f12_arg0.levelBg:setAlpha(0)
	f12_arg0.bg:setAlpha(0)
	f12_arg0.progressBar:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	f12_arg0.progressBar:setAlpha(1)
	f12_arg0.LvlBg:setAlpha(0)
	f12_arg0.WeaponLevelWidget:setAlpha(1)
	f12_arg0.WeaponLevelWidget.LevelLabel:setRGB(ColorSet.GroupName.r, ColorSet.GroupName.g, ColorSet.GroupName.b)
	f12_arg0.WeaponLevelWidget.PrestigeStar1:setRGB(ColorSet.GroupName.r, ColorSet.GroupName.g, ColorSet.GroupName.b)
	f12_arg0.WeaponLevelWidget.PrestigeStar2:setRGB(ColorSet.GroupName.r, ColorSet.GroupName.g, ColorSet.GroupName.b)
	f12_arg0.progressBarBg:setAlpha(1)
	f12_arg0.progressBarBgExtraOpacity:setAlpha(0.5)
end
CoD.ButtonWeaponLevel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(7)
			f13_arg0.bg:completeAnimation()
			f13_arg0.bg:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.bg)
			f13_arg0.levelBg:completeAnimation()
			f13_arg0.levelBg:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.levelBg)
			f13_arg0.progressBarBgExtraOpacity:completeAnimation()
			f13_arg0.progressBarBgExtraOpacity:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.progressBarBgExtraOpacity)
			f13_arg0.progressBarBg:completeAnimation()
			f13_arg0.progressBarBg:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.progressBarBg)
			f13_arg0.progressBar:completeAnimation()
			f13_arg0.progressBar:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.progressBar)
			f13_arg0.LvlBg:completeAnimation()
			f13_arg0.LvlBg:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.LvlBg)
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
			f14_arg0.progressBar:setRGB(0.62, 0.35, 0.79)
			f14_arg0.clipFinished(f14_arg0.progressBar)
			f14_arg0.WeaponLevelWidget:completeAnimation()
			f14_arg0.WeaponLevelWidget.LevelLabel:completeAnimation()
			f14_arg0.WeaponLevelWidget.PrestigeStar1:completeAnimation()
			f14_arg0.WeaponLevelWidget.PrestigeStar2:completeAnimation()
			f14_arg0.WeaponLevelWidget.LevelLabel:setRGB(0.62, 0.35, 0.79)
			f14_arg0.WeaponLevelWidget.PrestigeStar1:setRGB(0.62, 0.35, 0.79)
			f14_arg0.WeaponLevelWidget.PrestigeStar2:setRGB(0.62, 0.35, 0.79)
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
			f15_arg0.WeaponLevelWidget.LevelLabel:setRGB(0.89, 0.69, 0.04)
			f15_arg0.WeaponLevelWidget.PrestigeStar1:setRGB(0.89, 0.7, 0.04)
			f15_arg0.WeaponLevelWidget.PrestigeStar2:setRGB(0.89, 0.7, 0.04)
			f15_arg0.clipFinished(f15_arg0.WeaponLevelWidget)
		end,
	},
	MaxLevel = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(5)
			f16_arg0.bg:completeAnimation()
			f16_arg0.bg:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.bg)
			f16_arg0.progressBarBgExtraOpacity:completeAnimation()
			f16_arg0.progressBarBgExtraOpacity:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.progressBarBgExtraOpacity)
			f16_arg0.progressBarBg:completeAnimation()
			f16_arg0.progressBarBg:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.progressBarBg)
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
CoD.ButtonWeaponLevel.__onClose = function(f17_arg0)
	f17_arg0.progressBar:close()
	f17_arg0.WeaponLevelWidget:close()
end
