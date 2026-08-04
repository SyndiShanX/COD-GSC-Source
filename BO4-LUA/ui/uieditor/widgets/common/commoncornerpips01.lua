CoD.CommonCornerPips01 = InheritFrom(LUI.UIElement)
CoD.CommonCornerPips01.__defaultWidth = 150
CoD.CommonCornerPips01.__defaultHeight = 33
CoD.CommonCornerPips01.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonCornerPips01)
	self.id = "CommonCornerPips01"
	self.soundSet = "default"
	local CornerTopLeft = LUI.UIImage.new(0, 0, -2, 2, 0, 0, -2, 2)
	CornerTopLeft:setImage(RegisterImage("uie_ui_hud_notifications_cornerpip"))
	self:addElement(CornerTopLeft)
	self.CornerTopLeft = CornerTopLeft
	local CornerBottomLeft = LUI.UIImage.new(0, 0, -2, 2, 1, 1, -2, 2)
	CornerBottomLeft:setImage(RegisterImage("uie_ui_hud_notifications_cornerpip"))
	self:addElement(CornerBottomLeft)
	self.CornerBottomLeft = CornerBottomLeft
	local CornerBottomRight = LUI.UIImage.new(1, 1, -2, 2, 1, 1, -2, 2)
	CornerBottomRight:setImage(RegisterImage("uie_ui_hud_notifications_cornerpip"))
	self:addElement(CornerBottomRight)
	self.CornerBottomRight = CornerBottomRight
	local CornerTopRight = LUI.UIImage.new(1, 1, -2, 2, 0, 0, -2, 2)
	CornerTopRight:setImage(RegisterImage("uie_ui_hud_notifications_cornerpip"))
	self:addElement(CornerTopRight)
	self.CornerTopRight = CornerTopRight
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
