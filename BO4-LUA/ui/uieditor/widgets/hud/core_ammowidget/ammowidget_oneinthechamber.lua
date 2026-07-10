require("x64:f3f5b1130ad7b72")
require("x64:d3b48853e408bdd")
require("x64:729e84a5e6a8211")
CoD.AmmoWidget_OneInTheChamber = InheritFrom(LUI.UIElement)
CoD.AmmoWidget_OneInTheChamber.__defaultWidth = 360
CoD.AmmoWidget_OneInTheChamber.__defaultHeight = 88
CoD.AmmoWidget_OneInTheChamber.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidget_OneInTheChamber)
	self.id = "AmmoWidget_OneInTheChamber"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backer = LUI.UIImage.new(0, 0, -77, 290, 0, 0, -15.5, 77.5)
	Backer:setAlpha(0)
	Backer:setImage(RegisterImage(0xA3887D32AFD1940))
	Backer:setMaterial(LUI.UIImage.GetCachedMaterial(0xE125638BF94665F))
	Backer:setShaderVector(0, 0.05, 0.2, 0.05, 0.2)
	self:addElement(Backer)
	self.Backer = Backer
	local PanelLight = LUI.UIImage.new(0, 0, 220.5, 327.5, 0, 0, 13.5, 74.5)
	PanelLight:setRGB(0.22, 0.21, 0.19)
	PanelLight:setAlpha(0.75)
	self:addElement(PanelLight)
	self.PanelLight = PanelLight
	local PanelDark = LUI.UIImage.new(0, 0, 15.5, 220.5, 0, 0, 14, 74)
	PanelDark:setRGB(0.18, 0.17, 0.16)
	PanelDark:setAlpha(0.94)
	self:addElement(PanelDark)
	self.PanelDark = PanelDark
	local LEDgraph = LUI.UIImage.new(0, 0, 20, 360, 0, 0, 1, 87)
	LEDgraph:setRGB(0, 0, 0)
	LEDgraph:setAlpha(0.75)
	LEDgraph:setImage(RegisterImage(0x995EF23F488EAFE))
	self:addElement(LEDgraph)
	self.LEDgraph = LEDgraph
	local Frame = LUI.UIImage.new(0, 0, -1, 359, 0, 0, 1, 87)
	Frame:setImage(RegisterImage(0xA956421DAB808DF))
	self:addElement(Frame)
	self.Frame = Frame
	local OneInTheChamberLives = CoD.OneInTheChamberLives.new(f1_arg0, f1_arg1, 0, 0, -9, 141, 0, 0, 24, 74)
	self:addElement(OneInTheChamberLives)
	self.OneInTheChamberLives = OneInTheChamberLives
	local AmmoWidgetOICBullets = CoD.AmmoWidget_OIC_Bullets.new(f1_arg0, f1_arg1, 0, 0, 119, 219, 0, 0, 24, 74)
	self:addElement(AmmoWidgetOICBullets)
	self.AmmoWidgetOICBullets = AmmoWidgetOICBullets
	local Hacked = LUI.UIImage.new(0.5, 0.5, -131.5, 131.5, 0.5, 0.5, -30, 30)
	Hacked:setRGB(0.32, 0.44, 0.52)
	Hacked:setAlpha(0)
	Hacked:setZRot(180)
	Hacked:setImage(RegisterImage(0x74A8C8624AAE4D2))
	Hacked:setMaterial(LUI.UIImage.GetCachedMaterial(0x9227A50BA2B8D21))
	Hacked:setShaderVector(0, 4, 4, 0, 0)
	Hacked:setShaderVector(1, 30, 0, 0, 0)
	self:addElement(Hacked)
	self.Hacked = Hacked
	local WeaponImage = LUI.UIFixedAspectRatioImage.new(0, 0, 221.5, 325.5, 0, 0, 15, 71)
	WeaponImage:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	WeaponImage:setShaderVector(0, 1, 0, 0, 0)
	WeaponImage:setStretchedDimension(4)
	WeaponImage:linkToElementModel(self, "weapon", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			WeaponImage:setImage(RegisterImage(GetHudImageFromItemIndex(f2_local0)))
		end
	end)
	self:addElement(WeaponImage)
	self.WeaponImage = WeaponImage
	local oicLED = LUI.UIImage.new(0, 0, 3, 363, 0, 0, 7, 95)
	oicLED:setImage(RegisterImage(0xABF790B0DAA8AC7))
	oicLED:setMaterial(LUI.UIImage.GetCachedMaterial(0x655565C7B387234))
	self:addElement(oicLED)
	self.oicLED = oicLED
	local Lives = LUI.UIText.new(0, 0, 21.5, 117.5, 0, 0, 18, 30)
	Lives:setRGB(0.73, 0.71, 0.64)
	Lives:setText(Engine[0xF9F1239CFD921FE](0x1E4F4E133081C25))
	Lives:setTTF("ttmussels_demibold")
	Lives:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	Lives:setLetterSpacing(1)
	Lives:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Lives:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Lives)
	self.Lives = Lives
	local HeroAbilityUseString = CoD.AmmoWidget_WeaponName.new(f1_arg0, f1_arg1, 0, 0, 129.5, 249.5, 0, 0, 17.5, 29.5)
	HeroAbilityUseString:setScale(1.12, 1.12)
	HeroAbilityUseString:linkToElementModel(self, "weaponName", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			HeroAbilityUseString.HeroAbilityUseString:setText(ConvertToUpperString(CoD.BaseUtility.AlreadyLocalized(f3_local0)))
		end
	end)
	self:addElement(HeroAbilityUseString)
	self.HeroAbilityUseString = HeroAbilityUseString
	self:mergeStateConditions({
		{
			stateName = "Hacked",
			condition = function(menu, element, event)
				local f4_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "HUDItems", "hacked", 1)
				if f4_local0 then
					if not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]) then
						f4_local0 = not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F])
					else
						f4_local0 = false
					end
				end
				return f4_local0
			end,
		},
		{
			stateName = "AsianLanguage",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsCurrentLanguageAsian()
			end,
		},
	})
	local f1_local13 = self
	local f1_local14 = self.subscribeToModel
	local f1_local15 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local14(f1_local13, f1_local15.hacked, function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "hacked",
		})
	end, false)
	f1_local13 = self
	f1_local14 = self.subscribeToModel
	f1_local15 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local14(f1_local13, f1_local15["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	f1_local13 = self
	f1_local14 = self.subscribeToModel
	f1_local15 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local14(f1_local13, f1_local15["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	OneInTheChamberLives.id = "OneInTheChamberLives"
	AmmoWidgetOICBullets.id = "AmmoWidgetOICBullets"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AmmoWidget_OneInTheChamber.__resetProperties = function(f9_arg0)
	f9_arg0.Hacked:completeAnimation()
	f9_arg0.HeroAbilityUseString:completeAnimation()
	f9_arg0.Hacked:setAlpha(0)
	f9_arg0.HeroAbilityUseString:setLeftRight(0, 0, 129.5, 249.5)
	f9_arg0.HeroAbilityUseString:setScale(1.12, 1.12)
end
CoD.AmmoWidget_OneInTheChamber.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.Hacked:beginAnimation(3000)
			f10_arg0.Hacked:setAlpha(0)
			f10_arg0.Hacked:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
			f10_arg0.Hacked:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
		end,
	},
	Hacked = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.Hacked:beginAnimation(3000)
			f11_arg0.Hacked:setAlpha(1)
			f11_arg0.Hacked:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
			f11_arg0.Hacked:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
		end,
	},
	AsianLanguage = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.HeroAbilityUseString:completeAnimation()
			f12_arg0.HeroAbilityUseString:setLeftRight(0, 0, 117.5, 237.5)
			f12_arg0.HeroAbilityUseString:setScale(0.9, 0.9)
			f12_arg0.clipFinished(f12_arg0.HeroAbilityUseString)
		end,
	},
}
CoD.AmmoWidget_OneInTheChamber.__onClose = function(f13_arg0)
	f13_arg0.OneInTheChamberLives:close()
	f13_arg0.AmmoWidgetOICBullets:close()
	f13_arg0.WeaponImage:close()
	f13_arg0.HeroAbilityUseString:close()
end
