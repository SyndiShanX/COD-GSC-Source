require("x64:b36c29b92386d79")
require("x64:fd51e83e2e6dbd1")
CoD.ItemWeaponLevel = InheritFrom(LUI.UIElement)
CoD.ItemWeaponLevel.__defaultWidth = 1580
CoD.ItemWeaponLevel.__defaultHeight = 12
CoD.ItemWeaponLevel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ItemWeaponLevel)
	self.id = "ItemWeaponLevel"
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
	local progressBar = CoD.WeaponLevelMeter.new(f1_arg0, f1_arg1, 0, 0, 0, 1580, 0, 0, 0, 12)
	progressBar:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	progressBar:linkToElementModel(self, nil, false, function(model)
		progressBar:setModel(model, f1_arg1)
	end)
	self:addElement(progressBar)
	self.progressBar = progressBar
	local levelLabel = LUI.UIText.new(0, 0, 7.5, 236.5, 0, 0, -24.5, -4.5)
	levelLabel:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	levelLabel:setTTF("0arame_mono_stencil")
	levelLabel:setLetterSpacing(2)
	levelLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	levelLabel:setBackingType(3)
	levelLabel:setBackingColor(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	levelLabel:setBackingXPadding(13)
	levelLabel:setBackingYPadding(6)
	levelLabel:setBackingImage(RegisterImage(0x7D0A70047B9795C))
	levelLabel:setBackingMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	levelLabel:setBackingShaderVector(0, 0, 0, 0, 0)
	levelLabel:setupBackingNineSliceShader(55, 16)
	levelLabel:linkToElementModel(self, "itemIndex", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			levelLabel:setText(CoD.CACUtility.LocalizeCurrentWeaponLevelIntoString(f1_arg0, 0xD8F445CA5BD1B0E, f1_arg1, f4_local0))
		end
	end)
	self:addElement(levelLabel)
	self.levelLabel = levelLabel
	local prestigeStar2 = CoD.onOffImage.new(f1_arg0, f1_arg1, 0, 0, -14, -3, 1, 1, -12, -1)
	prestigeStar2:setRGB(0.97, 0.93, 0.07)
	prestigeStar2.image:setImage(RegisterImage(0x1CEC5168AA639BA))
	prestigeStar2:linkToElementModel(self, nil, false, function(model)
		prestigeStar2:setModel(model, f1_arg1)
	end)
	self:addElement(prestigeStar2)
	self.prestigeStar2 = prestigeStar2
	local prestigeStar1 = CoD.onOffImage.new(f1_arg0, f1_arg1, 0, 0, -14, -3, 1, 1, -31, -20)
	prestigeStar1:setRGB(0.97, 0.93, 0.07)
	prestigeStar1.image:setImage(RegisterImage(0x1CEC5168AA639BA))
	prestigeStar1:linkToElementModel(self, nil, false, function(model)
		prestigeStar1:setModel(model, f1_arg1)
	end)
	self:addElement(prestigeStar1)
	self.prestigeStar1 = prestigeStar1
	local Glow = LUI.UIImage.new(0, 0, -3, 7, 0, 0, -36, 8)
	Glow:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	Glow:setImage(RegisterImage(0x3BF2E37984B1A8B))
	Glow:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	Glow:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(Glow)
	self.Glow = Glow
	self:mergeStateConditions({
		{
			stateName = "DoubleWeaponXP",
			condition = function(menu, element, event)
				local f7_local0 = CoD.CACUtility.IsCACGunLevelExists(menu, element, f1_arg1)
				if f7_local0 then
					if not CoD.CACUtility.IsCACGunLevelMax(menu, element, f1_arg1) then
						f7_local0 = CoD.DoubleXPUtility.HasDoubleWeaponXP(f1_arg1, element)
						if f7_local0 then
							f7_local0 = not IsArenaMode()
						end
					else
						f7_local0 = false
					end
				end
				return f7_local0
			end,
		},
		{
			stateName = "DisplayLevel",
			condition = function(menu, element, event)
				local f8_local0 = CoD.CACUtility.IsCACGunLevelExists(menu, element, f1_arg1)
				if f8_local0 then
					if not CoD.CACUtility.IsCACGunLevelMax(menu, element, f1_arg1) and not CoD.DoubleXPUtility.HasDoubleWeaponXP(f1_arg1, element) then
						f8_local0 = not IsArenaMode()
					else
						f8_local0 = false
					end
				end
				return f8_local0
			end,
		},
		{
			stateName = "MaxLevel",
			condition = function(menu, element, event)
				local f9_local0 = CoD.CACUtility.IsCACGunLevelExists(menu, element, f1_arg1)
				if f9_local0 then
					f9_local0 = CoD.CACUtility.IsCACGunLevelMax(menu, element, f1_arg1)
					if f9_local0 then
						f9_local0 = not IsArenaMode()
					end
				end
				return f9_local0
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
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = DataSources.AutoEvents.getModel(f1_arg1)
	f1_local9(f1_local8, f1_local10.cycled, function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "cycled",
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = Engine[0x8DF2E5447F384B9]()
	f1_local9(f1_local8, f1_local10["lobbyRoot.lobbyNav"], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ItemWeaponLevel.__resetProperties = function(f14_arg0)
	f14_arg0.levelBg:completeAnimation()
	f14_arg0.levelLabel:completeAnimation()
	f14_arg0.prestigeStar1:completeAnimation()
	f14_arg0.prestigeStar2:completeAnimation()
	f14_arg0.bg:completeAnimation()
	f14_arg0.progressBar:completeAnimation()
	f14_arg0.Glow:completeAnimation()
	f14_arg0.levelBg:setAlpha(0)
	f14_arg0.levelLabel:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	f14_arg0.levelLabel:setAlpha(1)
	f14_arg0.levelLabel:setBackingColor(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	f14_arg0.prestigeStar1:setRGB(0.97, 0.93, 0.07)
	f14_arg0.prestigeStar1:setAlpha(1)
	f14_arg0.prestigeStar2:setRGB(0.97, 0.93, 0.07)
	f14_arg0.prestigeStar2:setAlpha(1)
	f14_arg0.bg:setAlpha(0)
	f14_arg0.progressBar:setAlpha(1)
	f14_arg0.progressBar.progressBarColorless:setRGB(1, 1, 1)
	f14_arg0.Glow:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	f14_arg0.Glow:setAlpha(1)
end
CoD.ItemWeaponLevel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(7)
			f15_arg0.bg:completeAnimation()
			f15_arg0.bg:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.bg)
			f15_arg0.levelBg:completeAnimation()
			f15_arg0.levelBg:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.levelBg)
			f15_arg0.progressBar:completeAnimation()
			f15_arg0.progressBar:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.progressBar)
			f15_arg0.levelLabel:completeAnimation()
			f15_arg0.levelLabel:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.levelLabel)
			f15_arg0.prestigeStar2:completeAnimation()
			f15_arg0.prestigeStar2:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.prestigeStar2)
			f15_arg0.prestigeStar1:completeAnimation()
			f15_arg0.prestigeStar1:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.prestigeStar1)
			f15_arg0.Glow:completeAnimation()
			f15_arg0.Glow:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.Glow)
		end,
	},
	DoubleWeaponXP = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(5)
			f16_arg0.progressBar:completeAnimation()
			f16_arg0.progressBar.progressBarColorless:completeAnimation()
			f16_arg0.progressBar.progressBarColorless:setRGB(0.62, 0.35, 0.79)
			f16_arg0.clipFinished(f16_arg0.progressBar)
			f16_arg0.levelLabel:completeAnimation()
			f16_arg0.levelLabel:setRGB(0.62, 0.35, 0.79)
			f16_arg0.levelLabel:setBackingColor(0.62, 0.35, 0.79)
			f16_arg0.clipFinished(f16_arg0.levelLabel)
			f16_arg0.prestigeStar2:completeAnimation()
			f16_arg0.prestigeStar2:setRGB(0.62, 0.35, 0.79)
			f16_arg0.clipFinished(f16_arg0.prestigeStar2)
			f16_arg0.prestigeStar1:completeAnimation()
			f16_arg0.prestigeStar1:setRGB(0.62, 0.35, 0.79)
			f16_arg0.clipFinished(f16_arg0.prestigeStar1)
			f16_arg0.Glow:completeAnimation()
			f16_arg0.Glow:setRGB(0.62, 0.35, 0.79)
			f16_arg0.clipFinished(f16_arg0.Glow)
		end,
	},
	DisplayLevel = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(3)
			f17_arg0.progressBar:completeAnimation()
			f17_arg0.progressBar.progressBarColorless:completeAnimation()
			f17_arg0.progressBar.progressBarColorless:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
			f17_arg0.clipFinished(f17_arg0.progressBar)
			f17_arg0.prestigeStar2:completeAnimation()
			f17_arg0.prestigeStar2:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
			f17_arg0.clipFinished(f17_arg0.prestigeStar2)
			f17_arg0.prestigeStar1:completeAnimation()
			f17_arg0.prestigeStar1:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
			f17_arg0.clipFinished(f17_arg0.prestigeStar1)
		end,
	},
	MaxLevel = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(4)
			f18_arg0.bg:completeAnimation()
			f18_arg0.bg:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.bg)
			f18_arg0.progressBar:completeAnimation()
			f18_arg0.progressBar:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.progressBar)
			f18_arg0.prestigeStar2:completeAnimation()
			f18_arg0.prestigeStar2:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
			f18_arg0.clipFinished(f18_arg0.prestigeStar2)
			f18_arg0.prestigeStar1:completeAnimation()
			f18_arg0.prestigeStar1:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
			f18_arg0.clipFinished(f18_arg0.prestigeStar1)
		end,
	},
}
CoD.ItemWeaponLevel.__onClose = function(f19_arg0)
	f19_arg0.progressBar:close()
	f19_arg0.levelLabel:close()
	f19_arg0.prestigeStar2:close()
	f19_arg0.prestigeStar1:close()
end
