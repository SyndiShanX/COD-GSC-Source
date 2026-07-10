require("x64:96ef316933545b7")
CoD.GameEndScore_EliminatorContainer = InheritFrom(LUI.UIElement)
CoD.GameEndScore_EliminatorContainer.__defaultWidth = 1000
CoD.GameEndScore_EliminatorContainer.__defaultHeight = 150
CoD.GameEndScore_EliminatorContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.GameEndScore_EliminatorContainer)
	self.id = "GameEndScore_EliminatorContainer"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PlayerIndentity = CoD.GameEndScore_PlayerIndentity.new(f1_arg0, f1_arg1, 0, 0, 65, 579, 0, 0, 20, 130)
	PlayerIndentity:mergeStateConditions({
		{
			stateName = "Self",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	PlayerIndentity:linkToElementModel(self, "attackerClientModel", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			PlayerIndentity:setModel(f3_local0, f1_arg1)
		end
	end)
	self:addElement(PlayerIndentity)
	self.PlayerIndentity = PlayerIndentity
	local WeaponName = LUI.UIText.new(0, 0, 625, 971, 0, 0, 106, 130)
	WeaponName:setRGB(0.92, 0.92, 0.92)
	WeaponName:setTTF("ttmussels_demibold")
	WeaponName:setLetterSpacing(4)
	WeaponName:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	WeaponName:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	WeaponName:linkToElementModel(self, "weaponName", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			WeaponName:setText(Engine[0xF9F1239CFD921FE](f4_local0))
		end
	end)
	self:addElement(WeaponName)
	self.WeaponName = WeaponName
	local WeaponImage = LUI.UIFixedAspectRatioImage.new(0, 0, 725, 864, 0, 0, 13, 89)
	WeaponImage:linkToElementModel(self, "weaponImage", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			WeaponImage:setImage(CoD.BaseUtility.AlreadyRegistered(f5_local0))
		end
	end)
	self:addElement(WeaponImage)
	self.WeaponImage = WeaponImage
	local MeansOfDeathLabel = LUI.UIText.new(0, 0, 220, 780, 0, 0, -71.5, -34.5)
	MeansOfDeathLabel:setAlpha(0)
	MeansOfDeathLabel:setTTF("ttmussels_regular")
	MeansOfDeathLabel:setLetterSpacing(6)
	MeansOfDeathLabel:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	MeansOfDeathLabel:linkToElementModel(self, "meansOfDeathLabel", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			MeansOfDeathLabel:setText(Engine[0xF9F1239CFD921FE](f6_local0))
		end
	end)
	self:addElement(MeansOfDeathLabel)
	self.MeansOfDeathLabel = MeansOfDeathLabel
	local MeansOfDeathImage = LUI.UIFixedAspectRatioImage.new(0, 0, 450, 550, 0, 0, -195, -95)
	MeansOfDeathImage:setAlpha(0)
	MeansOfDeathImage:linkToElementModel(self, "meansOfDeathIcon", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			MeansOfDeathImage:setImage(RegisterImage(f7_local0))
		end
	end)
	self:addElement(MeansOfDeathImage)
	self.MeansOfDeathImage = MeansOfDeathImage
	self:mergeStateConditions({
		{
			stateName = "NoAttacker",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelPathValueGreaterThan(element, f1_arg1, "meansOfDeath", 0)
			end,
		},
	})
	self:linkToElementModel(self, "meansOfDeath", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "meansOfDeath",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local6 = self
	CallCustomElementFunction_Element(PlayerIndentity, "setAlignment", Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	return self
end
CoD.GameEndScore_EliminatorContainer.__resetProperties = function(f10_arg0)
	f10_arg0.MeansOfDeathImage:completeAnimation()
	f10_arg0.MeansOfDeathLabel:completeAnimation()
	f10_arg0.WeaponName:completeAnimation()
	f10_arg0.WeaponImage:completeAnimation()
	f10_arg0.PlayerIndentity:completeAnimation()
	f10_arg0.MeansOfDeathImage:setTopBottom(0, 0, -195, -95)
	f10_arg0.MeansOfDeathImage:setAlpha(0)
	f10_arg0.MeansOfDeathLabel:setTopBottom(0, 0, -71.5, -34.5)
	f10_arg0.MeansOfDeathLabel:setAlpha(0)
	f10_arg0.WeaponName:setAlpha(1)
	f10_arg0.WeaponImage:setAlpha(1)
	f10_arg0.PlayerIndentity:setAlpha(1)
end
CoD.GameEndScore_EliminatorContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
	},
	NoAttacker = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(5)
			f12_arg0.PlayerIndentity:completeAnimation()
			f12_arg0.PlayerIndentity:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.PlayerIndentity)
			f12_arg0.WeaponName:completeAnimation()
			f12_arg0.WeaponName:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.WeaponName)
			f12_arg0.WeaponImage:completeAnimation()
			f12_arg0.WeaponImage:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.WeaponImage)
			f12_arg0.MeansOfDeathLabel:completeAnimation()
			f12_arg0.MeansOfDeathLabel:setTopBottom(0, 0, 106.5, 143.5)
			f12_arg0.MeansOfDeathLabel:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.MeansOfDeathLabel)
			f12_arg0.MeansOfDeathImage:completeAnimation()
			f12_arg0.MeansOfDeathImage:setTopBottom(0, 0, 4.5, 104.5)
			f12_arg0.MeansOfDeathImage:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.MeansOfDeathImage)
		end,
	},
}
CoD.GameEndScore_EliminatorContainer.__onClose = function(f13_arg0)
	f13_arg0.PlayerIndentity:close()
	f13_arg0.WeaponName:close()
	f13_arg0.WeaponImage:close()
	f13_arg0.MeansOfDeathLabel:close()
	f13_arg0.MeansOfDeathImage:close()
end
