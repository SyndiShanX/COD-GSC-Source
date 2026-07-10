CoD.kickerinternal = InheritFrom(LUI.UIElement)
CoD.kickerinternal.__defaultWidth = 400
CoD.kickerinternal.__defaultHeight = 40
CoD.kickerinternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 8, false)
	self:setAlignment(LUI.Alignment.Center)
	self:setClass(CoD.kickerinternal)
	self.id = "kickerinternal"
	self.soundSet = "default"
	local ContentIcon = LUI.UIImage.new(0, 0, 0, 40, 0, 0, 0, 40)
	ContentIcon:setImage(RegisterImage(0x373AE7CA3DB4B97))
	self:addElement(ContentIcon)
	self.ContentIcon = ContentIcon
	local NotifTextMain = LUI.UIText.new(0, 0, 48, 400, 0.5, 0.5, -13.5, 13.5)
	NotifTextMain:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	NotifTextMain:setTTF("ttmussels_regular")
	NotifTextMain:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(NotifTextMain)
	self.NotifTextMain = NotifTextMain
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
