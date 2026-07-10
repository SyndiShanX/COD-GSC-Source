require("x64:2ba7e67fe4fa792")
CoD.NineBangReticle_Internal = InheritFrom(LUI.UIElement)
CoD.NineBangReticle_Internal.__defaultWidth = 150
CoD.NineBangReticle_Internal.__defaultHeight = 150
CoD.NineBangReticle_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.NineBangReticle_Internal)
	self.id = "NineBangReticle_Internal"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local Backer = LUI.UIImage.new(0, 0, 26.5, 126.5, 0, 0, 113, 143)
	Backer:setImage(RegisterImage(0xAD1CDB71E011B8))
	self:addElement(Backer)
	self.Backer = Backer
	local Pip9 = CoD.NineBangReticle_Pip.new(f1_arg0, f1_arg1, 0, 0, 91, 121, 0, 0, 122, 133)
	Pip9:mergeStateConditions({
		{
			stateName = "Active",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "CurrentWeapon", "cookOffProgress", 1)
			end,
		},
	})
	local Pip3 = Pip9
	local Pip6 = Pip9.subscribeToModel
	local Reticle = DataSources.CurrentWeapon.getModel(f1_arg1)
	Pip6(Pip3, Reticle.cookOffProgress, function(f3_arg0)
		f1_arg0:updateElementState(Pip9, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "cookOffProgress",
		})
	end, false)
	Pip9:setZRot(30)
	LUI.OverrideFunction_CallOriginalFirst(Pip9, "setState", function(element, controller, f4_arg2, f4_arg3, f4_arg4)
		if IsElementInState(element, "Active") and IsElementPropertyValue(element, "_alreadyPlayedSound", false) then
			PlaySoundAlias("wpn_flashbang_button_3")
			SetElementProperty(element, "_alreadyPlayedSound", true)
		elseif not IsElementInState(element, "Active") then
			SetElementProperty(element, "_alreadyPlayedSound", false)
		end
	end)
	self:addElement(Pip9)
	self.Pip9 = Pip9
	Pip6 = CoD.NineBangReticle_Pip.new(f1_arg0, f1_arg1, 0, 0, 61.5, 92.5, 0, 0, 130, 141)
	Pip6:mergeStateConditions({
		{
			stateName = "Active",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "CurrentWeapon", "cookOffProgress", 0.5)
			end,
		},
	})
	Reticle = Pip6
	Pip3 = Pip6.subscribeToModel
	local f1_local6 = DataSources.CurrentWeapon.getModel(f1_arg1)
	Pip3(Reticle, f1_local6.cookOffProgress, function(f6_arg0)
		f1_arg0:updateElementState(Pip6, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "cookOffProgress",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(Pip6, "setState", function(element, controller, f7_arg2, f7_arg3, f7_arg4)
		if IsElementInState(element, "Active") and IsElementPropertyValue(element, "_alreadyPlayedSound", false) then
			PlaySoundAlias("wpn_flashbang_button_2")
			SetElementProperty(element, "_alreadyPlayedSound", true)
		elseif not IsElementInState(element, "Active") then
			SetElementProperty(element, "_alreadyPlayedSound", false)
		end
	end)
	self:addElement(Pip6)
	self.Pip6 = Pip6
	Pip3 = CoD.NineBangReticle_Pip.new(f1_arg0, f1_arg1, 0, 0, 31.5, 62.5, 0, 0, 122, 133)
	Pip3:mergeStateConditions({
		{
			stateName = "Active",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	Pip3:setZRot(-30)
	self:addElement(Pip3)
	self.Pip3 = Pip3
	Reticle = LUI.UIImage.new(0, 0, 60.5, 92.5, 0, 0, 59, 91)
	Reticle:setImage(RegisterImage(0xCE2DEFE7CFE38B3))
	self:addElement(Reticle)
	self.Reticle = Reticle
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.NineBangReticle_Internal.__onClose = function(f9_arg0)
	f9_arg0.Pip9:close()
	f9_arg0.Pip6:close()
	f9_arg0.Pip3:close()
end
