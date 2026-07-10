CoD.WeaponNameWidget = InheritFrom(LUI.UIElement)
CoD.WeaponNameWidget.__defaultWidth = 154
CoD.WeaponNameWidget.__defaultHeight = 51
CoD.WeaponNameWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WeaponNameWidget)
	self.id = "WeaponNameWidget"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local weaponNameLabel = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, -22, 23)
	weaponNameLabel:setRGB(0.92, 0.92, 0.92)
	weaponNameLabel:setTTF("ttmussels_demibold")
	weaponNameLabel:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_171E049B161CD00A"))
	weaponNameLabel:setLetterSpacing(5.6)
	weaponNameLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	weaponNameLabel:linkToElementModel(self, "name", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			weaponNameLabel:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(weaponNameLabel, "setText", function(element, controller)
		ScaleWidgetToLabel(self, element, 2)
		SetStateFromText(self, element, "DefaultState", "NoText", f1_arg1)
	end)
	self:addElement(weaponNameLabel)
	self.weaponNameLabel = weaponNameLabel
	self:mergeStateConditions({
		{
			stateName = "NoText",
			condition = function(menu, element, event)
				return IsSelfInState(self, "NoText")
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WeaponNameWidget.__resetProperties = function(f5_arg0)
	f5_arg0.weaponNameLabel:completeAnimation()
	f5_arg0.weaponNameLabel:setAlpha(1)
end
CoD.WeaponNameWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	NoText = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.weaponNameLabel:completeAnimation()
			f7_arg0.weaponNameLabel:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.weaponNameLabel)
		end,
	},
}
CoD.WeaponNameWidget.__onClose = function(f8_arg0)
	f8_arg0.weaponNameLabel:close()
end
