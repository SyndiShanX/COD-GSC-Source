CoD.ObituaryCalloutContainerDamageDealt = InheritFrom(LUI.UIElement)
CoD.ObituaryCalloutContainerDamageDealt.__defaultWidth = 221
CoD.ObituaryCalloutContainerDamageDealt.__defaultHeight = 26
CoD.ObituaryCalloutContainerDamageDealt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 14, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.ObituaryCalloutContainerDamageDealt)
	self.id = "ObituaryCalloutContainerDamageDealt"
	self.soundSet = "default"
	local ContribDamage = LUI.UIText.new(0, 0, -7, 41, 0, 0, 0, 27)
	ContribDamage:setRGB(ColorSet.EnemyOrange.r, ColorSet.EnemyOrange.g, ColorSet.EnemyOrange.b)
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
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ObituaryCalloutContainerDamageDealt.__onClose = function(f3_arg0)
	f3_arg0.ContribDamage:close()
end
