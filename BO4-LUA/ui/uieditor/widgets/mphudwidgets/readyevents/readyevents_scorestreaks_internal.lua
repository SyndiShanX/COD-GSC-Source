require("x64:608a04210db0950")
CoD.ReadyEvents_Scorestreaks_Internal = InheritFrom(LUI.UIElement)
CoD.ReadyEvents_Scorestreaks_Internal.__defaultWidth = 300
CoD.ReadyEvents_Scorestreaks_Internal.__defaultHeight = 50
CoD.ReadyEvents_Scorestreaks_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ReadyEvents_Scorestreaks_Internal)
	self.id = "ReadyEvents_Scorestreaks_Internal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local Spacer = LUI.UIImage.new(0, 0, 62, 72, 0, 1, 0, 0)
	Spacer:setImage(RegisterImage(@"blacktransparent"))
	self:addElement(Spacer)
	self.Spacer = Spacer
	local Text = LUI.UIText.new(0, 0, 72, 312, 0, 0, 5.5, 47.5)
	Text:setRGB(0, 0, 0)
	Text:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/killstreak_ready"))
	Text:setTTF("ttmussels_demibold")
	Text:setLetterSpacing(1)
	Text:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	LUI.OverrideFunction_CallOriginalFirst(Text, "setText", function(element, controller)
		RecalculateScaleToElementWidth(self, self)
	end)
	self:addElement(Text)
	self.Text = Text
	local IconContainer = CoD.ReadyEvents_Scorestreaks_Iconcontainer.new(f1_arg0, f1_arg1, 0, 0, 0, 62, 0, 0, 0, 50)
	self:addElement(IconContainer)
	self.IconContainer = IconContainer
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ReadyEvents_Scorestreaks_Internal.__onClose = function(f3_arg0)
	f3_arg0.IconContainer:close()
end
