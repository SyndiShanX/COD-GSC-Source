require("x64:e201e7e41431aa7")
CoD.PC_SeekerMine_Text = InheritFrom(LUI.UIElement)
CoD.PC_SeekerMine_Text.__defaultWidth = 300
CoD.PC_SeekerMine_Text.__defaultHeight = 30
CoD.PC_SeekerMine_Text.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_SeekerMine_Text)
	self.id = "PC_SeekerMine_Text"
	self.soundSet = "default"
	local PCtext = LUI.UIText.new(0, 0, 0, 300, 0, 0, 0, 30)
	PCtext:setText(Engine[0xF9F1239CFD921FE](0xFB6FEE8FACA0DA9))
	PCtext:setTTF("ttmussels_regular")
	PCtext:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	PCtext:setBackingType(1)
	PCtext:setBackingWidget(CoD.FE_ButtonPanel, f1_arg0, f1_arg1)
	PCtext:setBackingColor(0, 0, 0)
	PCtext:setBackingAlpha(0.62)
	PCtext:setBackingXPadding(10)
	PCtext:setBackingYPadding(-2)
	self:addElement(PCtext)
	self.PCtext = PCtext
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
