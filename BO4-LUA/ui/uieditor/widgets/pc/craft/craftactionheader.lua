CoD.CraftActionHeader = InheritFrom(LUI.UIElement)
CoD.CraftActionHeader.__defaultWidth = 375
CoD.CraftActionHeader.__defaultHeight = 55
CoD.CraftActionHeader.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CraftActionHeader)
	self.id = "CraftActionHeader"
	self.soundSet = "SelectColor"
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -35, 0)
	Backing:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	Backing:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	Backing:setShaderVector(0, 0, 0, 0, 0)
	Backing:setupNineSliceShader(196, 88)
	self:addElement(Backing)
	self.Backing = Backing
	local Frame = LUI.UIImage.new(0, 1, -1, 1, 1, 1, -36, 1)
	Frame:setAlpha(0.2)
	Frame:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	Frame:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	Frame:setShaderVector(0, 0, 0, 0, 0)
	Frame:setupNineSliceShader(16, 16)
	self:addElement(Frame)
	self.Frame = Frame
	local text = LUI.UIText.new(0, 1, 10, -10, 1, 1, -24, -8)
	text:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	text:setTTF("ttmussels_demibold")
	text:setLetterSpacing(6)
	text:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	text:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(text)
	self.text = text
	self.text:linkToElementModel(self, "actionName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			text:setText(LocalizeToUpperString(f2_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CraftActionHeader.__onClose = function(f3_arg0)
	f3_arg0.text:close()
end
