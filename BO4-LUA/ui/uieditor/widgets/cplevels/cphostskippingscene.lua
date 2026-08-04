CoD.CPHostSkippingScene = InheritFrom(LUI.UIElement)
CoD.CPHostSkippingScene.__defaultWidth = 280
CoD.CPHostSkippingScene.__defaultHeight = 37
CoD.CPHostSkippingScene.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CPHostSkippingScene)
	self.id = "CPHostSkippingScene"
	self.soundSet = "default"
	local Label0 = LUI.UIText.new(0, 1, 21, -21, 0, 1, 0.5, 0.5)
	Label0:setText(Engine[@"hash_4F9F1239CFD921FE"]("menu/host_skipping_scene"))
	Label0:setTTF("default")
	Label0:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	self:addElement(Label0)
	self.Label0 = Label0
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
