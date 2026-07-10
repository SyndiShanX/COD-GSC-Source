CoD.Hud_ZM_HintText = InheritFrom(LUI.UIElement)
CoD.Hud_ZM_HintText.__defaultWidth = 1288
CoD.Hud_ZM_HintText.__defaultHeight = 42
CoD.Hud_ZM_HintText.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Hud_ZM_HintText)
	self.id = "Hud_ZM_HintText"
	self.soundSet = "default"
	local ZMHintText = LUI.UIText.new(0.5, 0.5, -864, 864, 0.5, 0.5, -18, 15)
	ZMHintText:setText("")
	ZMHintText:setTTF("skorzhen")
	ZMHintText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ZMHintText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	ZMHintText:setBackingType(2)
	ZMHintText:setBackingColor(0, 0, 0)
	ZMHintText:setBackingXPadding(7)
	ZMHintText:setBackingYPadding(7)
	ZMHintText:setBackingImage(RegisterImage(0x75D661B612187DF))
	self:addElement(ZMHintText)
	self.ZMHintText = ZMHintText
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
