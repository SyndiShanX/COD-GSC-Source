CoD.WZObituaryCalloutContainerDamageDealt = InheritFrom(LUI.UIElement)
CoD.WZObituaryCalloutContainerDamageDealt.__defaultWidth = 221
CoD.WZObituaryCalloutContainerDamageDealt.__defaultHeight = 26
CoD.WZObituaryCalloutContainerDamageDealt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 14, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.WZObituaryCalloutContainerDamageDealt)
	self.id = "WZObituaryCalloutContainerDamageDealt"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ContribDamage = LUI.UIText.new(0, 0, -7, 41, 0, 0, 0, 27)
	ContribDamage:setRGB(1, 0.99, 0.99)
	ContribDamage:setTTF("ttmussels_demibold")
	ContribDamage:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	ContribDamage:setShaderVector(0, 1, 0, 0, 0)
	ContribDamage:setShaderVector(1, 0, 0, 0, 0)
	ContribDamage:setShaderVector(2, 0, 0, 0, 0.35)
	ContribDamage:setLetterSpacing(4)
	ContribDamage:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ContribDamage:linkToElementModel(self, "damageDealt", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ContribDamage:setText(CoD.BaseUtility.AlreadyLocalized(f2_local0))
		end
	end)
	self:addElement(ContribDamage)
	self.ContribDamage = ContribDamage
	local ContribText = LUI.UIText.new(0, 0, 55, 228, 0, 0, 0, 27)
	ContribText:setRGB(1, 0.99, 0.99)
	ContribText:setText(LocalizeToUpperString(0x95155665E8F3F4B))
	ContribText:setTTF("ttmussels_regular")
	ContribText:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	ContribText:setShaderVector(0, 1, 0, 0, 0)
	ContribText:setShaderVector(1, 0, 0, 0, 0)
	ContribText:setShaderVector(2, 0, 0, 0, 0.35)
	ContribText:setLetterSpacing(4)
	ContribText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(ContribText)
	self.ContribText = ContribText
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelPathValueGreaterThan(element, f1_arg1, "damageDealt", 0)
			end,
		},
	})
	self:linkToElementModel(self, "damageDealt", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "damageDealt",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZObituaryCalloutContainerDamageDealt.__resetProperties = function(f5_arg0)
	f5_arg0.ContribText:completeAnimation()
	f5_arg0.ContribDamage:completeAnimation()
	f5_arg0.ContribText:setAlpha(1)
	f5_arg0.ContribDamage:setAlpha(1)
end
CoD.WZObituaryCalloutContainerDamageDealt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.ContribDamage:completeAnimation()
			f6_arg0.ContribDamage:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.ContribDamage)
			f6_arg0.ContribText:completeAnimation()
			f6_arg0.ContribText:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.ContribText)
		end,
	},
	Visible = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.WZObituaryCalloutContainerDamageDealt.__onClose = function(f8_arg0)
	f8_arg0.ContribDamage:close()
end
