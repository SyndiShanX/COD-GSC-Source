CoD.WeaponLevelWidget = InheritFrom(LUI.UIElement)
CoD.WeaponLevelWidget.__defaultWidth = 124
CoD.WeaponLevelWidget.__defaultHeight = 60
CoD.WeaponLevelWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WeaponLevelWidget)
	self.id = "WeaponLevelWidget"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LevelLabel = LUI.UIText.new(0, 0, 4.5, 204.5, 0, 0, 21.5, 42.5)
	LevelLabel:setRGB(ColorSet.GroupName.r, ColorSet.GroupName.g, ColorSet.GroupName.b)
	LevelLabel:setTTF("0arame_mono_stencil")
	LevelLabel:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	LevelLabel:setShaderVector(0, 0.7, 0, 0, 0)
	LevelLabel:setShaderVector(1, 0, 0, 0, 0)
	LevelLabel:setShaderVector(2, 0, 0, 0, 0.5)
	LevelLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	LevelLabel:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	LevelLabel:linkToElementModel(self, "itemIndex", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			LevelLabel:setText(LocalizeIntoString(0xDD5565F2B354F84, CoD.CACUtility.GetCurrentWeaponLevel(f1_arg0, f1_arg1, f2_local0)))
		end
	end)
	self:addElement(LevelLabel)
	self.LevelLabel = LevelLabel
	local PrestigeStar1 = LUI.UIImage.new(0, 0, 3, 14, 0, 0, 26.5, 37.5)
	PrestigeStar1:setRGB(ColorSet.GroupName.r, ColorSet.GroupName.g, ColorSet.GroupName.b)
	PrestigeStar1:setAlpha(0)
	PrestigeStar1:setImage(RegisterImage(0xB94BBEF24882247))
	self:addElement(PrestigeStar1)
	self.PrestigeStar1 = PrestigeStar1
	local PrestigeStar2 = LUI.UIImage.new(0, 0, 15.5, 26.5, 0, 0, 26.5, 37.5)
	PrestigeStar2:setRGB(ColorSet.GroupName.r, ColorSet.GroupName.g, ColorSet.GroupName.b)
	PrestigeStar2:setAlpha(0)
	PrestigeStar2:setImage(RegisterImage(0xB94BBEF24882247))
	self:addElement(PrestigeStar2)
	self.PrestigeStar2 = PrestigeStar2
	self:mergeStateConditions({
		{
			stateName = "PrestigeOneState",
			condition = function(menu, element, event)
				local f3_local0
				if not IsPaintshop(f1_arg1) then
					f3_local0 = CoD.CACUtility.IsCACGunPrestigeLevelOne(menu, element, f1_arg1)
					if f3_local0 then
						f3_local0 = CoD.CACUtility.IsCACGunLevelExists(menu, element, f1_arg1)
					end
				else
					f3_local0 = false
				end
				return f3_local0
			end,
		},
		{
			stateName = "PrestigeTwoState",
			condition = function(menu, element, event)
				local f4_local0
				if not IsPaintshop(f1_arg1) then
					f4_local0 = CoD.CACUtility.IsCACGunPrestigeLevelMax(menu, element, f1_arg1)
					if f4_local0 then
						f4_local0 = CoD.CACUtility.IsCACGunLevelExists(menu, element, f1_arg1)
					end
				else
					f4_local0 = false
				end
				return f4_local0
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
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WeaponLevelWidget.__resetProperties = function(f6_arg0)
	f6_arg0.PrestigeStar1:completeAnimation()
	f6_arg0.PrestigeStar2:completeAnimation()
	f6_arg0.LevelLabel:completeAnimation()
	f6_arg0.PrestigeStar1:setAlpha(0)
	f6_arg0.PrestigeStar2:setAlpha(0)
	f6_arg0.LevelLabel:setLeftRight(0, 0, 4.5, 204.5)
end
CoD.WeaponLevelWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.PrestigeStar1:completeAnimation()
			f7_arg0.PrestigeStar1:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.PrestigeStar1)
			f7_arg0.PrestigeStar2:completeAnimation()
			f7_arg0.PrestigeStar2:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.PrestigeStar2)
		end,
	},
	PrestigeOneState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(3)
			f8_arg0.LevelLabel:completeAnimation()
			f8_arg0.LevelLabel:setLeftRight(0, 0, 17.5, 217.5)
			f8_arg0.clipFinished(f8_arg0.LevelLabel)
			f8_arg0.PrestigeStar1:completeAnimation()
			f8_arg0.PrestigeStar1:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.PrestigeStar1)
			f8_arg0.PrestigeStar2:completeAnimation()
			f8_arg0.PrestigeStar2:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.PrestigeStar2)
		end,
	},
	PrestigeTwoState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(3)
			f9_arg0.LevelLabel:completeAnimation()
			f9_arg0.LevelLabel:setLeftRight(0, 0, 28.5, 228.5)
			f9_arg0.clipFinished(f9_arg0.LevelLabel)
			f9_arg0.PrestigeStar1:completeAnimation()
			f9_arg0.PrestigeStar1:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.PrestigeStar1)
			f9_arg0.PrestigeStar2:completeAnimation()
			f9_arg0.PrestigeStar2:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.PrestigeStar2)
		end,
	},
}
CoD.WeaponLevelWidget.__onClose = function(f10_arg0)
	f10_arg0.LevelLabel:close()
end
