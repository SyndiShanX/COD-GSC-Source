CoD.uplink_IconandTextArmorbg = InheritFrom(LUI.UIElement)
CoD.uplink_IconandTextArmorbg.__defaultWidth = 61
CoD.uplink_IconandTextArmorbg.__defaultHeight = 30
CoD.uplink_IconandTextArmorbg.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.uplink_IconandTextArmorbg)
	self.id = "uplink_IconandTextArmorbg"
	self.soundSet = "default"
	local background = LUI.UIImage.new(0, 1, -54, 28, 0, 1, -2, 2)
	background:setAlpha(0.3)
	background:setImage(RegisterImage(0xAADD20019A84C5F))
	background:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	background:setShaderVector(0, 0, 0, 0, 0)
	background:setupNineSliceShader(30, 15)
	self:addElement(background)
	self.background = background
	local Shield = LUI.UIImage.new(0, 0, -33, -3, 0, 0, 0, 30)
	Shield:setImage(RegisterImage(0x1B0E9D6F6646DE))
	self:addElement(Shield)
	self.Shield = Shield
	local armorLabel = LUI.UIText.new(0, 0, 0, 62, 0, 0, 0, 30)
	armorLabel:setText(Engine[0xF9F1239CFD921FE](0x62964D05398F61A))
	armorLabel:setTTF("ttmussels_demibold")
	armorLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	LUI.OverrideFunction_CallOriginalFirst(armorLabel, "setText", function(element, controller)
		ScaleWidgetToLabel(self, element, 1)
	end)
	self:addElement(armorLabel)
	self.armorLabel = armorLabel
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
