CoD.WaypointArrow = InheritFrom(LUI.UIElement)
CoD.WaypointArrow.__defaultWidth = 60
CoD.WaypointArrow.__defaultHeight = 36
CoD.WaypointArrow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WaypointArrow)
	self.id = "WaypointArrow"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WhiteArrow = LUI.UIImage.new(0.5, 0.5, -40, 40, 0.5, 0.5, -38, 38)
	WhiteArrow:setImage(RegisterImage("uie_ui_hud_core_waypoint_arrow_02"))
	self:addElement(WhiteArrow)
	self.WhiteArrow = WhiteArrow
	local ColorArrow = LUI.UIImage.new(0.5, 0.5, -40, 40, 0.5, 0.5, -38, 38)
	ColorArrow:setImage(RegisterImage("uie_ui_hud_core_waypoint_arrow_02"))
	ColorArrow:linkToElementModel(self, "color", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ColorArrow:setRGB(CoD.WaypointUtility.ConvertToBaseColor(f2_local0))
		end
	end)
	self:addElement(ColorArrow)
	self.ColorArrow = ColorArrow
	local ColorArrow2 = LUI.UIImage.new(0.5, 0.5, -40, 40, 0.5, 0.5, -38, 38)
	ColorArrow2:setAlpha(0.75)
	ColorArrow2:setImage(RegisterImage("uie_ui_hud_core_waypoint_arrow_02"))
	ColorArrow2:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	ColorArrow2:linkToElementModel(self, "color", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ColorArrow2:setRGB(CoD.WaypointUtility.ConvertToMutedColor(f3_local0))
		end
	end)
	self:addElement(ColorArrow2)
	self.ColorArrow2 = ColorArrow2
	local ColorArrow3 = LUI.UIImage.new(0.5, 0.5, -40, 40, 0.5, 0.5, -38, 38)
	ColorArrow3:setImage(RegisterImage("uie_ui_hud_core_waypoint_arrow_02"))
	ColorArrow3:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	ColorArrow3:linkToElementModel(self, "color", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			ColorArrow3:setRGB(CoD.WaypointUtility.ConvertToBrightColor(f4_local0))
		end
	end)
	self:addElement(ColorArrow3)
	self.ColorArrow3 = ColorArrow3
	self:mergeStateConditions({
		{
			stateName = "ColorArrow",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsObjectiveXHashPropertyValueEqualTo(self, 0x28D5F5EA7B6E874, 1)
			end,
		},
	})
	self:linkToElementModel(self, "id", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "id",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WaypointArrow.__resetProperties = function(f7_arg0)
	f7_arg0.WhiteArrow:completeAnimation()
	f7_arg0.ColorArrow:completeAnimation()
	f7_arg0.WhiteArrow:setAlpha(1)
	f7_arg0.ColorArrow:setAlpha(1)
end
CoD.WaypointArrow.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.WhiteArrow:completeAnimation()
			f8_arg0.WhiteArrow:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.WhiteArrow)
			f8_arg0.ColorArrow:completeAnimation()
			f8_arg0.ColorArrow:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.ColorArrow)
		end,
	},
	ColorArrow = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.WhiteArrow:completeAnimation()
			f9_arg0.WhiteArrow:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.WhiteArrow)
			f9_arg0.ColorArrow:completeAnimation()
			f9_arg0.ColorArrow:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.ColorArrow)
		end,
	},
}
CoD.WaypointArrow.__onClose = function(f10_arg0)
	f10_arg0.ColorArrow:close()
	f10_arg0.ColorArrow2:close()
	f10_arg0.ColorArrow3:close()
end
