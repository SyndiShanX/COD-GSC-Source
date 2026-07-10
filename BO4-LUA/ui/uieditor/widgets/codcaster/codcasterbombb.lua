CoD.codcasterBombB = InheritFrom(LUI.UIElement)
CoD.codcasterBombB.__defaultWidth = 60
CoD.codcasterBombB.__defaultHeight = 60
CoD.codcasterBombB.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.codcasterBombB)
	self.id = "codcasterBombB"
	self.soundSet = "default"
	local siteBLED = LUI.UIImage.new(0.55, 0.55, -33, 27, 0.45, 0.45, -27, 33)
	siteBLED:setScale(0.45, 0.45)
	siteBLED:setImage(RegisterImage(@"uie_ui_hud_core_waypoint_led"))
	siteBLED:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.ObjectiveB.color", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			siteBLED:setRGB(f2_local0)
		end
	end)
	self:addElement(siteBLED)
	self.siteBLED = siteBLED
	local siteBEmpty = LUI.UIImage.new(0.55, 0.55, -33, 27, 0.45, 0.45, -27, 33)
	siteBEmpty:setScale(0.45, 0.45)
	siteBEmpty:setImage(RegisterImage(@"uie_ui_hud_core_waypoint_domination_empty"))
	self:addElement(siteBEmpty)
	self.siteBEmpty = siteBEmpty
	local siteBFill = LUI.UIImage.new(0.55, 0.55, -33, 27, 0.45, 0.45, -27, 33)
	siteBFill:setScale(0.45, 0.45)
	siteBFill:setImage(RegisterImage(@"uie_ui_hud_core_waypoint_domination_fill_02"))
	siteBFill:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_clock_normal"))
	siteBFill:setShaderVector(1, 0.5, 0, 0, 0)
	siteBFill:setShaderVector(2, 0.5, 0, 0, 0)
	siteBFill:setShaderVector(3, 0, 0, 0, 0)
	siteBFill:setShaderVector(4, 0, 0, 0, 0)
	siteBFill:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.attackTeamColor", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			siteBFill:setRGB(f3_local0)
		end
	end)
	siteBFill:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.ObjectiveB.progress", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			siteBFill:setShaderVector(0, CoD.GetVectorComponentFromString(f4_local0, 1), CoD.GetVectorComponentFromString(f4_local0, 2), CoD.GetVectorComponentFromString(f4_local0, 3), CoD.GetVectorComponentFromString(f4_local0, 4))
		end
	end)
	self:addElement(siteBFill)
	self.siteBFill = siteBFill
	local siteBLetter = LUI.UIImage.new(0.55, 0.55, -33, 27, 0.45, 0.45, -27, 33)
	siteBLetter:setScale(0.45, 0.45)
	siteBLetter:setImage(RegisterImage(@"uie_ui_hud_core_waypoint_letter_b_02"))
	siteBLetter:subscribeToGlobalModel(f1_arg1, "HUDItems", "codcaster.ObjectiveB.color", function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			siteBLetter:setRGB(f5_local0)
		end
	end)
	self:addElement(siteBLetter)
	self.siteBLetter = siteBLetter
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.codcasterBombB.__onClose = function(f6_arg0)
	f6_arg0.siteBLED:close()
	f6_arg0.siteBFill:close()
	f6_arg0.siteBLetter:close()
end
