require("x64:30c77dc7ecb3f24")
CoD.vhud_generic_key_mouse_layout = InheritFrom(LUI.UIElement)
CoD.vhud_generic_key_mouse_layout.__defaultWidth = 1920
CoD.vhud_generic_key_mouse_layout.__defaultHeight = 1080
CoD.vhud_generic_key_mouse_layout.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_generic_key_mouse_layout)
	self.id = "vhud_generic_key_mouse_layout"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local Right0 = CoD.vhud_ms_ButtonWidget.new(f1_arg0, f1_arg1, 1, 1, -226.5, -97.5, 1, 1, -216, -52)
	Right0:setYRot(-50)
	Right0:setZRot(-10)
	Right0:linkToElementModel(self, "RIGHT_0", false, function(model)
		Right0:setModel(model, f1_arg1)
	end)
	self:addElement(Right0)
	self.Right0 = Right0
	local Right1 = CoD.vhud_ms_ButtonWidget.new(f1_arg0, f1_arg1, 1, 1, -224.5, -95.5, 1, 1, -342, -178)
	Right1:setYRot(-50)
	Right1:setZRot(-10)
	Right1:linkToElementModel(self, "RIGHT_1", false, function(model)
		Right1:setModel(model, f1_arg1)
	end)
	self:addElement(Right1)
	self.Right1 = Right1
	local Right3 = CoD.vhud_ms_ButtonWidget.new(f1_arg0, f1_arg1, 1, 1, -226.5, -97.5, 1, 1, -469, -305)
	Right3:setYRot(-50)
	Right3:setZRot(-10)
	Right3:linkToElementModel(self, "RIGHT_2", false, function(model)
		Right3:setModel(model, f1_arg1)
	end)
	self:addElement(Right3)
	self.Right3 = Right3
	local Right4 = CoD.vhud_ms_ButtonWidget.new(f1_arg0, f1_arg1, 1, 1, -226.5, -97.5, 1, 1, -593, -429)
	Right4:setYRot(-50)
	Right4:setZRot(-10)
	Right4:linkToElementModel(self, "RIGHT_3", false, function(model)
		Right4:setModel(model, f1_arg1)
	end)
	self:addElement(Right4)
	self.Right4 = Right4
	local Left00 = CoD.vhud_ms_ButtonWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, 0, 129, 1, 1, -216, -52)
	Left00:linkToElementModel(self, "LEFT_0", false, function(model)
		Left00:setModel(model, f1_arg1)
	end)
	self:addElement(Left00)
	self.Left00 = Left00
	local Left10 = CoD.vhud_ms_ButtonWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -258, -129, 1, 1, -216, -52)
	Left10:linkToElementModel(self, "LEFT_1", false, function(model)
		Left10:setModel(model, f1_arg1)
	end)
	self:addElement(Left10)
	self.Left10 = Left10
	local Left20 = CoD.vhud_ms_ButtonWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -129, 0, 1, 1, -216, -52)
	Left20:linkToElementModel(self, "LEFT_2", false, function(model)
		Left20:setModel(model, f1_arg1)
	end)
	self:addElement(Left20)
	self.Left20 = Left20
	local Left30 = CoD.vhud_ms_ButtonWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, 129, 258, 1, 1, -216, -52)
	Left30:linkToElementModel(self, "LEFT_3", false, function(model)
		Left30:setModel(model, f1_arg1)
	end)
	self:addElement(Left30)
	self.Left30 = Left30
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_generic_key_mouse_layout.__onClose = function(f10_arg0)
	f10_arg0.Right0:close()
	f10_arg0.Right1:close()
	f10_arg0.Right3:close()
	f10_arg0.Right4:close()
	f10_arg0.Left00:close()
	f10_arg0.Left10:close()
	f10_arg0.Left20:close()
	f10_arg0.Left30:close()
end
