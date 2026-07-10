CoD.CPVoteSkippingScene = InheritFrom(LUI.UIElement)
CoD.CPVoteSkippingScene.__defaultWidth = 280
CoD.CPVoteSkippingScene.__defaultHeight = 37
CoD.CPVoteSkippingScene.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CPVoteSkippingScene)
	self.id = "CPVoteSkippingScene"
	self.soundSet = "default"
	local Label0 = LUI.UIText.new(0, 1, 21, -21, 0, 1, 0.5, 0.5)
	Label0:setText(Engine[0xF9F1239CFD921FE](0x11AB825AF710768))
	Label0:setTTF("default")
	Label0:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	self:addElement(Label0)
	self.Label0 = Label0
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
