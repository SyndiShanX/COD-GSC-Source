CoD.KilledByHeader = InheritFrom(LUI.UIElement)
CoD.KilledByHeader.__defaultWidth = 600
CoD.KilledByHeader.__defaultHeight = 150
CoD.KilledByHeader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.KilledByHeader)
	self.id = "KilledByHeader"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TextBackground = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -16, 16)
	TextBackground:setRGB(0, 0, 0)
	TextBackground:setAlpha(0.8)
	TextBackground:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	TextBackground:setShaderVector(0, 0, 1, 0, 0)
	TextBackground:setShaderVector(1, 0.15, 0.15, 0, 0)
	TextBackground:setShaderVector(2, 0, 1, 0, 0)
	TextBackground:setShaderVector(3, 0, 0, 0, 0)
	TextBackground:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(TextBackground)
	self.TextBackground = TextBackground
	local MistakesText = LUI.UIText.new(0.5, 0.5, -206.5, 206.5, 0.5, 0.5, -18.5, 18.5)
	MistakesText:setText(LocalizeToUpperString(0x1838FDD5EA1D43A))
	MistakesText:setTTF("notosans_regular")
	MistakesText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	MistakesText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	MistakesText:subscribeToGlobalModel(f1_arg1, "HUDItems", "killedByMOD", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			MistakesText:setAlpha(Negate(CoD.DeathCamUtility.KilledByMOD_UnkownToAlpha(f2_local0)))
		end
	end)
	self:addElement(MistakesText)
	self.MistakesText = MistakesText
	local WeaponImage = LUI.UIFixedAspectRatioImage.new(0.5, 0.5, -64, 64, 0.5, 0.5, -64, 64)
	WeaponImage:setScale(0.6, 0.6)
	WeaponImage:subscribeToGlobalModel(f1_arg1, "HUDItems", "killedByMOD", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			WeaponImage:setAlpha(CoD.DeathCamUtility.KilledByMOD_UnkownToAlpha(f3_local0))
		end
	end)
	WeaponImage:subscribeToGlobalModel(f1_arg1, "HUDItems", "killedByItemIndex", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			WeaponImage:setImage(RegisterImage(GetWeaponItemImageFromIndex(f4_local0)))
		end
	end)
	self:addElement(WeaponImage)
	self.WeaponImage = WeaponImage
	local DeathTypeText = LUI.UIText.new(0.5, 0.5, -276.5, -76.5, 0.5, 0.5, -18.5, 18.5)
	DeathTypeText:setTTF("notosans_regular")
	DeathTypeText:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	DeathTypeText:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	DeathTypeText:subscribeToGlobalModel(f1_arg1, "HUDItems", "killedByMOD", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			DeathTypeText:setAlpha(CoD.DeathCamUtility.KilledByMOD_UnkownToAlpha(f5_local0))
		end
	end)
	DeathTypeText:subscribeToGlobalModel(f1_arg1, "HUDItems", "killedByMOD", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			DeathTypeText:setText(CoD.SocialUtility.CleanGamerTag(LocalizeToUpperString(CoD.DeathCamUtility.KilledByMODToDeathType(f6_local0))))
		end
	end)
	self:addElement(DeathTypeText)
	self.DeathTypeText = DeathTypeText
	local DeathWeaponName = LUI.UIText.new(0.5, 0.5, 77, 277, 0.5, 0.5, -18.5, 18.5)
	DeathWeaponName:setTTF("notosans_regular")
	DeathWeaponName:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	DeathWeaponName:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	DeathWeaponName:subscribeToGlobalModel(f1_arg1, "HUDItems", "killedByMOD", function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			DeathWeaponName:setAlpha(CoD.DeathCamUtility.KilledByMOD_UnkownToAlpha(f7_local0))
		end
	end)
	DeathWeaponName:subscribeToGlobalModel(f1_arg1, "HUDItems", "killedByItemIndex", function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			DeathWeaponName:setText(LocalizeToUpperString(GetItemNameFromIndex(Enum[0x6EB546760F890D2][0x3057ABF96AF8289], f8_local0)))
		end
	end)
	self:addElement(DeathWeaponName)
	self.DeathWeaponName = DeathWeaponName
	self:mergeStateConditions({
		{
			stateName = "InSpawnSelect",
			condition = function(menu, element, event)
				return CoD.SpawnSelectionUtility.IsSpawnSelectActive(f1_arg1)
			end,
		},
	})
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local7(f1_local6, f1_local8["hudItems.showSpawnSelect"], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "hudItems.showSpawnSelect",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.KilledByHeader.__resetProperties = function(f11_arg0)
	f11_arg0.TextBackground:completeAnimation()
	f11_arg0.TextBackground:setAlpha(0.8)
end
CoD.KilledByHeader.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
	},
	InSpawnSelect = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.TextBackground:completeAnimation()
			f13_arg0.TextBackground:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.TextBackground)
		end,
	},
}
CoD.KilledByHeader.__onClose = function(f14_arg0)
	f14_arg0.MistakesText:close()
	f14_arg0.WeaponImage:close()
	f14_arg0.DeathTypeText:close()
	f14_arg0.DeathWeaponName:close()
end
