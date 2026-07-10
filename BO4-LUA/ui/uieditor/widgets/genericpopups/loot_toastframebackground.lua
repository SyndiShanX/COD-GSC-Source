CoD.LOOT_ToastFrameBackground = InheritFrom(LUI.UIElement)
CoD.LOOT_ToastFrameBackground.__defaultWidth = 520
CoD.LOOT_ToastFrameBackground.__defaultHeight = 169
CoD.LOOT_ToastFrameBackground.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LOOT_ToastFrameBackground)
	self.id = "LOOT_ToastFrameBackground"
	self.soundSet = "default"
	local bot = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -74, -1)
	bot:setImage(RegisterImage(0xB0A262C11127FB7))
	self:addElement(bot)
	self.bot = bot
	local mod = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 72, -74)
	mod:setImage(RegisterImage(0x4720AE2E903C329))
	self:addElement(mod)
	self.mod = mod
	local top = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 1, 72)
	top:setImage(RegisterImage(0xC5343861EB3FCBF))
	self:addElement(top)
	self.top = top
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
