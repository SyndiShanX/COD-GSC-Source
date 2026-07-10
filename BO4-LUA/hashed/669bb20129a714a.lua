CoD.hud_speedometer_widget = InheritFrom(LUI.UIElement)
CoD.hud_speedometer_widget.__defaultWidth = 252
CoD.hud_speedometer_widget.__defaultHeight = 132
CoD.hud_speedometer_widget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.hud_speedometer_widget)
	self.id = "hud_speedometer_widget"
	self.soundSet = "none"
	local frameblur = LUI.UIImage.new(0, 0, 0, 252, 0, 0, 0, 132)
	frameblur:setImage(RegisterImage(0x9D3ABB870D7F2CD))
	frameblur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	frameblur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(frameblur)
	self.frameblur = frameblur
	local redzone = LUI.UIImage.new(0, 0, 198, 262, 0, 0, 38.5, 106.5)
	redzone:setRGB(1, 0, 0)
	redzone:setImage(RegisterImage(0x7D606C43E14EEDF))
	self:addElement(redzone)
	self.redzone = redzone
	local redzone2 = LUI.UIImage.new(0, 0, 198, 262, 0, 0, 38.5, 106.5)
	redzone2:setRGB(1, 0, 0)
	redzone2:setImage(RegisterImage(0x7D606C43E14EEDF))
	self:addElement(redzone2)
	self.redzone2 = redzone2
	local frame = LUI.UIImage.new(0, 0, 0, 252, 0, 0, 0, 132)
	frame:setImage(RegisterImage(0xFF7C4C17D5AB27E))
	frame:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(frame)
	self.frame = frame
	local fill = LUI.UIImage.new(0.5, 0.5, -126, 126, 0, 0, 4, 136)
	fill:setImage(RegisterImage(0xC003D8EC72486C5))
	fill:setMaterial(LUI.UIImage.GetCachedMaterial(0xD5CA1A25ED87F4F))
	fill:setShaderVector(1, 0.5, 0, 0, 0)
	fill:setShaderVector(2, 1, 0, 0, 0)
	fill:setShaderVector(3, 0, 0, 0, 0)
	fill:setShaderVector(4, 0, 0, 0, 0)
	fill:subscribeToGlobalModel(f1_arg1, "PerController", "vehicle.speed", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			fill:setShaderVector(0, CoD.VehicleUtility.ScaleClockVectorWithSpeed(0, 15.5, 0, 0.3, 0.15, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4)))
		end
	end)
	self:addElement(fill)
	self.fill = fill
	local arrow = LUI.UIImage.new(0.5, 0.5, -6, 6, 0, 0, 76, 197)
	arrow:setImage(RegisterImage(0xBA297CB535037BE))
	arrow:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	arrow:subscribeToGlobalModel(f1_arg1, "PerController", "vehicle.speed", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			arrow:setZRot(CoD.VehicleUtility.ScaleWithSpeed(0, 15.5, 68, -68, f3_local0))
		end
	end)
	self:addElement(arrow)
	self.arrow = arrow
	local line = LUI.UIImage.new(0.5, 0.5, -6, 6, 0, 0, 32.5, 249.5)
	line:setImage(RegisterImage(0x3847D97169AAAAF))
	line:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	line:subscribeToGlobalModel(f1_arg1, "PerController", "vehicle.speed", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			line:setZRot(CoD.VehicleUtility.ScaleWithSpeed(0, 15.5, 68, -68, f4_local0))
		end
	end)
	self:addElement(line)
	self.line = line
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.hud_speedometer_widget.__onClose = function(f5_arg0)
	f5_arg0.fill:close()
	f5_arg0.arrow:close()
	f5_arg0.line:close()
end
