CoD.WarzoneCollapseProgress = InheritFrom(LUI.UIElement)
CoD.WarzoneCollapseProgress.__defaultWidth = 260
CoD.WarzoneCollapseProgress.__defaultHeight = 8
CoD.WarzoneCollapseProgress.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneCollapseProgress)
	self.id = "WarzoneCollapseProgress"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local meterBacking = LUI.UIImage.new(-0.01, -0.01, 0, 266, -0.5, -0.5, 0, 16)
	meterBacking:setRGB(0.35, 0.35, 0.35)
	meterBacking:setAlpha(0.45)
	meterBacking:setImage(RegisterImage(@"uie_wz_hud_map_danger_bar_empty"))
	meterBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_edges"))
	meterBacking:setShaderVector(0, 0.01, 0.02, 0.01, 0.02)
	self:addElement(meterBacking)
	self.meterBacking = meterBacking
	local meterFill = LUI.UIImage.new(0, 1, 0, -16, -0.25, 1.25, 0, 0)
	meterFill:setImage(RegisterImage(@"uie_wz_hud_map_danger_bar"))
	meterFill:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe_delta_normal"))
	meterFill:setShaderVector(1, 0, 0, 0, 0)
	meterFill:setShaderVector(2, 0, 1, 0, 0)
	meterFill:setShaderVector(3, 0.2, 0.2, 0, 0)
	meterFill:setShaderVector(4, 0, 0, 0, 0)
	meterFill:subscribeToGlobalModel(f1_arg1, "WarzoneGlobal", "collapseProgress", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			meterFill:setShaderVector(0, SwapVectorComponents(1, 2, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4)))
		end
	end)
	self:addElement(meterFill)
	self.meterFill = meterFill
	local safeZone2 = LUI.UIImage.new(1, 1, -17.5, 1.5, -1.75, -1.75, 10, 26)
	safeZone2:setImage(RegisterImage(@"hash_7DA0E88765F528A9"))
	safeZone2:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_edges"))
	safeZone2:setShaderVector(0, 0.02, 0.02, 0.02, 0.02)
	self:addElement(safeZone2)
	self.safeZone2 = safeZone2
	local safeZone = LUI.UIImage.new(1, 1, -17.5, 1.5, -1.75, -1.75, 9, 27)
	safeZone:setImage(RegisterImage(@"hash_7DA0E88765F528A9"))
	safeZone:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_feather_edges"))
	safeZone:setShaderVector(0, 0.02, 0.02, 0.02, 0.02)
	self:addElement(safeZone)
	self.safeZone = safeZone
	local playerPosition = LUI.UIImage.new(0.7, 0.7, -14, 14, 1, 1, -18, 10)
	playerPosition:setImage(RegisterImage(@"ui_icon_global_runningman"))
	playerPosition:subscribeToGlobalModel(f1_arg1, "HUDItems", "distanceFromDeathCircle", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			playerPosition:setLeftPct(CoD.WZUtility.AdjustDistanceFromDeathCircle(0.94, 0.96, f3_local0))
		end
	end)
	self:addElement(playerPosition)
	self.playerPosition = playerPosition
	local vehiclePosition = LUI.UIImage.new(0.4, 0.4, -26, 26, 1, 1, -30, 22)
	vehiclePosition:setAlpha(0)
	vehiclePosition:setZRot(270)
	vehiclePosition:setImage(RegisterImage(@"hash_2B024F5E0D917C61"))
	vehiclePosition:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook"))
	vehiclePosition:setShaderVector(0, 4, 4, 0, 0)
	vehiclePosition:setShaderVector(1, 30, 0, 0, 0)
	vehiclePosition:subscribeToGlobalModel(f1_arg1, "HUDItems", "insertionVehicleProgress", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			vehiclePosition:setLeftPct(f4_local0)
		end
	end)
	self:addElement(vehiclePosition)
	self.vehiclePosition = vehiclePosition
	self:mergeStateConditions({
		{
			stateName = "InfiltrationVehicle",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "hudItems.infiltrationVehicle", 1)
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["hudItems.infiltrationVehicle"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "hudItems.infiltrationVehicle",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneCollapseProgress.__resetProperties = function(f7_arg0)
	f7_arg0.meterFill:completeAnimation()
	f7_arg0.meterBacking:completeAnimation()
	f7_arg0.safeZone2:completeAnimation()
	f7_arg0.safeZone:completeAnimation()
	f7_arg0.playerPosition:completeAnimation()
	f7_arg0.meterFill:setAlpha(1)
	f7_arg0.meterBacking:setAlpha(0.45)
	f7_arg0.safeZone2:setAlpha(1)
	f7_arg0.safeZone:setAlpha(1)
	f7_arg0.playerPosition:setAlpha(1)
end
CoD.WarzoneCollapseProgress.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	InfiltrationVehicle = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(5)
			f9_arg0.meterBacking:completeAnimation()
			f9_arg0.meterBacking:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.meterBacking)
			f9_arg0.meterFill:completeAnimation()
			f9_arg0.meterFill:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.meterFill)
			f9_arg0.safeZone2:completeAnimation()
			f9_arg0.safeZone2:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.safeZone2)
			f9_arg0.safeZone:completeAnimation()
			f9_arg0.safeZone:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.safeZone)
			f9_arg0.playerPosition:completeAnimation()
			f9_arg0.playerPosition:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.playerPosition)
		end,
	},
}
CoD.WarzoneCollapseProgress.__onClose = function(f10_arg0)
	f10_arg0.meterFill:close()
	f10_arg0.playerPosition:close()
	f10_arg0.vehiclePosition:close()
end
