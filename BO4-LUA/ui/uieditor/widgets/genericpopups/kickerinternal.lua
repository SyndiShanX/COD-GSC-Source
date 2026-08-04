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
	ContentIcon:setImage(RegisterImage(@"hash_3373AE7CA3DB4B97"))
	self:addElement(ContentIcon)
	self.ContentIcon = ContentIcon
	local NotifTextMain = LUI.UIText.new(0, 0, 48, 400, 0.5, 0.5, -13.5, 13.5)
	NotifTextMain:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	NotifTextMain:setTTF("ttmussels_regular")
	NotifTextMain:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	self:addElement(NotifTextMain)
	self.NotifTextMain = NotifTextMain
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
