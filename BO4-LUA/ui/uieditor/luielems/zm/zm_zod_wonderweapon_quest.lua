CoD.zm_zod_wonderweapon_quest = InheritFrom(CoD.Menu)
LUI.createMenu.zm_zod_wonderweapon_quest = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("zm_zod_wonderweapon_quest", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.zm_zod_wonderweapon_quest)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local CarryingDecay = LUI.UIText.new(0, 0, 1349, 1657, 0, 0, 796.5, 833.5)
	CarryingDecay:setRGB(0.03, 0.81, 0.33)
	CarryingDecay:setText(Engine[0xF9F1239CFD921FE](0x8AC3267C4DA5F02))
	CarryingDecay:setTTF("default")
	CarryingDecay:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	CarryingDecay:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	CarryingDecay:linkToElementModel(self, "decay", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CarryingDecay:setAlpha(f2_local0)
		end
	end)
	self:addElement(CarryingDecay)
	self.CarryingDecay = CarryingDecay
	local CarryingPurity = LUI.UIText.new(0, 0, 1349, 1657, 0, 0, 796.5, 833.5)
	CarryingPurity:setRGB(0, 0.52, 0.82)
	CarryingPurity:setText(Engine[0xF9F1239CFD921FE](0xF028C52DDB2044D))
	CarryingPurity:setTTF("default")
	CarryingPurity:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	CarryingPurity:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	CarryingPurity:linkToElementModel(self, "purity", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			CarryingPurity:setAlpha(f3_local0)
		end
	end)
	self:addElement(CarryingPurity)
	self.CarryingPurity = CarryingPurity
	local CarryingPlasma = LUI.UIText.new(0, 0, 1349, 1657, 0, 0, 796.5, 833.5)
	CarryingPlasma:setRGB(1, 0, 0)
	CarryingPlasma:setText(Engine[0xF9F1239CFD921FE](0x19A6271DDFE132))
	CarryingPlasma:setTTF("default")
	CarryingPlasma:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	CarryingPlasma:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	CarryingPlasma:linkToElementModel(self, "plasma", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			CarryingPlasma:setAlpha(f4_local0)
		end
	end)
	self:addElement(CarryingPlasma)
	self.CarryingPlasma = CarryingPlasma
	local CarryingRadiance = LUI.UIText.new(0, 0, 1349, 1657, 0, 0, 796.5, 833.5)
	CarryingRadiance:setRGB(0.93, 1, 0)
	CarryingRadiance:setText(Engine[0xF9F1239CFD921FE](0x9906C8B5560C85D))
	CarryingRadiance:setTTF("default")
	CarryingRadiance:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	CarryingRadiance:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	CarryingRadiance:linkToElementModel(self, "radiance", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			CarryingRadiance:setAlpha(f5_local0)
		end
	end)
	self:addElement(CarryingRadiance)
	self.CarryingRadiance = CarryingRadiance
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7])
			end,
		},
	})
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local7(f1_local6, f1_local8["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f7_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.zm_zod_wonderweapon_quest.__resetProperties = function(f8_arg0)
	f8_arg0.CarryingRadiance:completeAnimation()
	f8_arg0.CarryingPlasma:completeAnimation()
	f8_arg0.CarryingPurity:completeAnimation()
	f8_arg0.CarryingDecay:completeAnimation()
	f8_arg0.CarryingRadiance:setTopBottom(0, 0, 796.5, 833.5)
	f8_arg0.CarryingPlasma:setTopBottom(0, 0, 796.5, 833.5)
	f8_arg0.CarryingPurity:setTopBottom(0, 0, 796.5, 833.5)
	f8_arg0.CarryingDecay:setTopBottom(0, 0, 796.5, 833.5)
end
CoD.zm_zod_wonderweapon_quest.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(4)
			f10_arg0.CarryingDecay:completeAnimation()
			f10_arg0.CarryingDecay:setTopBottom(0, 0, 796.5, 796.5)
			f10_arg0.clipFinished(f10_arg0.CarryingDecay)
			f10_arg0.CarryingPurity:completeAnimation()
			f10_arg0.CarryingPurity:setTopBottom(0, 0, 796.5, 796.5)
			f10_arg0.clipFinished(f10_arg0.CarryingPurity)
			f10_arg0.CarryingPlasma:completeAnimation()
			f10_arg0.CarryingPlasma:setTopBottom(0, 0, 796.5, 796.5)
			f10_arg0.clipFinished(f10_arg0.CarryingPlasma)
			f10_arg0.CarryingRadiance:completeAnimation()
			f10_arg0.CarryingRadiance:setTopBottom(0, 0, 796.5, 796.5)
			f10_arg0.clipFinished(f10_arg0.CarryingRadiance)
		end,
	},
}
CoD.zm_zod_wonderweapon_quest.__onClose = function(f11_arg0)
	f11_arg0.CarryingDecay:close()
	f11_arg0.CarryingPurity:close()
	f11_arg0.CarryingPlasma:close()
	f11_arg0.CarryingRadiance:close()
end
