require("x64:29187ea00d726c3")
CoD.ObituaryEKIAContainer = InheritFrom(LUI.UIElement)
CoD.ObituaryEKIAContainer.__defaultWidth = 800
CoD.ObituaryEKIAContainer.__defaultHeight = 27
CoD.ObituaryEKIAContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 10, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.ObituaryEKIAContainer)
	self.id = "ObituaryEKIAContainer"
	self.soundSet = "default"
	local Ekia = LUI.UIText.new(0.5, 0.5, -265, -138, 0.5, 0.5, -13.5, 13.5)
	Ekia:setRGB(1, 0.99, 0.99)
	Ekia:setText(LocalizeToUpperString(@"aar/ekia"))
	Ekia:setTTF("ttmussels_regular")
	Ekia:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	Ekia:setShaderVector(0, 1, 0, 0, 0)
	Ekia:setShaderVector(1, 0, 0, 0, 0)
	Ekia:setShaderVector(2, 0, 0, 0, 0.35)
	Ekia:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(Ekia)
	self.Ekia = Ekia
	local Separator = LUI.UIImage.new(0.5, 0.5, -128, -126, 0.5, 0.5, -10, 10)
	self:addElement(Separator)
	self.Separator = Separator
	local Spacer = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0.5, 0.5, -116, -115, 0.5, 0.5, -13.5, 13.5)
	self:addElement(Spacer)
	self.Spacer = Spacer
	local ContribDamage = LUI.UIText.new(0, 0, 295, 353, 0, 0, 0, 27)
	ContribDamage:setRGB(ColorSet.EnemyOrange.r, ColorSet.EnemyOrange.g, ColorSet.EnemyOrange.b)
	ContribDamage:setTTF("ttmussels_demibold")
	ContribDamage:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	ContribDamage:setShaderVector(0, 1, 0, 0, 0)
	ContribDamage:setShaderVector(1, 0, 0, 0, 0)
	ContribDamage:setShaderVector(2, 0, 0, 0, 0.35)
	ContribDamage:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ContribDamage:linkToElementModel(self, "damageDealt", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ContribDamage:setText(CoD.BaseUtility.AlreadyLocalized(f2_local0))
		end
	end)
	self:addElement(ContribDamage)
	self.ContribDamage = ContribDamage
	local ContribText = LUI.UIText.new(0, 0, 363, 665, 0, 0, 0, 27)
	ContribText:setRGB(1, 0.99, 0.99)
	ContribText:setText(LocalizeToUpperString(@"hash_395155665E8F3F4B"))
	ContribText:setTTF("ttmussels_regular")
	ContribText:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	ContribText:setShaderVector(0, 1, 0, 0, 0)
	ContribText:setShaderVector(1, 0, 0, 0, 0)
	ContribText:setShaderVector(2, 0, 0, 0, 0.35)
	ContribText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(ContribText)
	self.ContribText = ContribText
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ObituaryEKIAContainer.__onClose = function(f3_arg0)
	f3_arg0.Spacer:close()
	f3_arg0.ContribDamage:close()
end
