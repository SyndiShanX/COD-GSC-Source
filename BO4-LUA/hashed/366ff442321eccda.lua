require("x64:6300b2a585cf679")
CoD.vhud_tank_robot_internal = InheritFrom(LUI.UIElement)
CoD.vhud_tank_robot_internal.__defaultWidth = 1920
CoD.vhud_tank_robot_internal.__defaultHeight = 1080
CoD.vhud_tank_robot_internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_tank_robot_internal)
	self.id = "vhud_tank_robot_internal"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local vhudtankrobotreticle = CoD.vhud_tank_robot_reticle.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	vhudtankrobotreticle:linkToElementModel(self, nil, false, function(model)
		vhudtankrobotreticle:setModel(model, f1_arg1)
	end)
	self:addElement(vhudtankrobotreticle)
	self.vhudtankrobotreticle = vhudtankrobotreticle
	local f1_local2 = nil
	self.ExitPrompt = LUI.UIElement.createFake()
	local f1_local3 = nil
	self.LockOnPrompt = LUI.UIElement.createFake()
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local4 = self
	if IsPC() then
		SizeToHudArea(self.vhudtankrobotreticle, f1_arg1)
	end
	return self
end
CoD.vhud_tank_robot_internal.__onClose = function(f3_arg0)
	f3_arg0.vhudtankrobotreticle:close()
	f3_arg0.ExitPrompt:close()
	f3_arg0.LockOnPrompt:close()
end
