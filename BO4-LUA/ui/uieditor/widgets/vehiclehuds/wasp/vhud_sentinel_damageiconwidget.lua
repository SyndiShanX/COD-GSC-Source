require("x64:65054b8f0650c5d")
CoD.vhud_sentinel_DamageIconWidget = InheritFrom(LUI.UIElement)
CoD.vhud_sentinel_DamageIconWidget.__defaultWidth = 237
CoD.vhud_sentinel_DamageIconWidget.__defaultHeight = 106
CoD.vhud_sentinel_DamageIconWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_sentinel_DamageIconWidget)
	self.id = "vhud_sentinel_DamageIconWidget"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DamageIconLine0 = LUI.UIImage.new(0.5, 0.5, -119, 119, 0.5, 0.5, -53.5, 53.5)
	DamageIconLine0:setRGB(0.6, 0.82, 0.91)
	DamageIconLine0:setAlpha(0.3)
	DamageIconLine0:setZoom(-20)
	DamageIconLine0:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_wasp_damageiconline"))
	DamageIconLine0:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(DamageIconLine0)
	self.DamageIconLine0 = DamageIconLine0
	local DamageIconRed = LUI.UIImage.new(0.5, 0.5, -119, 119, 0.5, 0.5, -53.5, 53.5)
	DamageIconRed:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_wasp_damageiconred"))
	DamageIconRed:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_wipe"))
	DamageIconRed:setShaderVector(1, 0, 0, 0, 0)
	DamageIconRed:setShaderVector(2, 1, 0, 0, 0)
	DamageIconRed:setShaderVector(3, 0, 0, 0, 0)
	DamageIconRed:setShaderVector(4, 0, 0, 0, 0)
	DamageIconRed:linkToElementModel(self, "damage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			DamageIconRed:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(DamageIconRed)
	self.DamageIconRed = DamageIconRed
	local DamageIconLine = LUI.UIImage.new(0.5, 0.5, -119, 119, 0.5, 0.5, -53.5, 53.5)
	DamageIconLine:setRGB(0.6, 0.82, 0.91)
	DamageIconLine:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_wasp_damageiconline"))
	DamageIconLine:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(DamageIconLine)
	self.DamageIconLine = DamageIconLine
	local DamageIconDots = LUI.UIImage.new(0.5, 0.5, -119, 119, 0.5, 0.5, -53.5, 53.5)
	DamageIconDots:setRGB(0.6, 0.82, 0.91)
	DamageIconDots:setImage(RegisterImage(@"uie_t7_cp_hud_vehicle_wasp_damageicondots"))
	DamageIconDots:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(DamageIconDots)
	self.DamageIconDots = DamageIconDots
	local genericVHUDdamageArea0 = CoD.genericVHUDdamageArea.new(f1_arg0, f1_arg1, 0, 0, 43, 193, 0, 0, -22, 128)
	genericVHUDdamageArea0:setAlpha(0)
	genericVHUDdamageArea0:linkToElementModel(self, nil, false, function(model)
		genericVHUDdamageArea0:setModel(model, f1_arg1)
	end)
	self:addElement(genericVHUDdamageArea0)
	self.genericVHUDdamageArea0 = genericVHUDdamageArea0
	self:mergeStateConditions({
		{
			stateName = "RAPS",
			condition = function(menu, element, event)
				return IsCampaign() and IsVehicleOfType(f1_arg1, "raps")
			end,
		},
	})
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[@"getglobalmodel"]()
	f1_local7(f1_local6, f1_local8["lobbyRoot.lobbyNav"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local6 = self
	f1_local7 = self.subscribeToModel
	f1_local8 = DataSources.VehicleInfo.getModel(f1_arg1)
	f1_local7(f1_local6, f1_local8.vehicleType, function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "vehicleType",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_sentinel_DamageIconWidget.__resetProperties = function(f7_arg0)
	f7_arg0.DamageIconLine0:completeAnimation()
	f7_arg0.DamageIconRed:completeAnimation()
	f7_arg0.DamageIconLine:completeAnimation()
	f7_arg0.DamageIconDots:completeAnimation()
	f7_arg0.genericVHUDdamageArea0:completeAnimation()
	f7_arg0.DamageIconLine0:setAlpha(0.3)
	f7_arg0.DamageIconRed:setAlpha(1)
	f7_arg0.DamageIconLine:setAlpha(1)
	f7_arg0.DamageIconDots:setAlpha(1)
	f7_arg0.genericVHUDdamageArea0:setAlpha(0)
end
CoD.vhud_sentinel_DamageIconWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	RAPS = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(5)
			f9_arg0.DamageIconLine0:completeAnimation()
			f9_arg0.DamageIconLine0:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.DamageIconLine0)
			f9_arg0.DamageIconRed:completeAnimation()
			f9_arg0.DamageIconRed:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.DamageIconRed)
			f9_arg0.DamageIconLine:completeAnimation()
			f9_arg0.DamageIconLine:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.DamageIconLine)
			f9_arg0.DamageIconDots:completeAnimation()
			f9_arg0.DamageIconDots:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.DamageIconDots)
			f9_arg0.genericVHUDdamageArea0:completeAnimation()
			f9_arg0.genericVHUDdamageArea0:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.genericVHUDdamageArea0)
		end,
	},
}
CoD.vhud_sentinel_DamageIconWidget.__onClose = function(f10_arg0)
	f10_arg0.DamageIconRed:close()
	f10_arg0.genericVHUDdamageArea0:close()
end
