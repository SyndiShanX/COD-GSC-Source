require("x64:4d398821a441c41")
require("x64:16a180f17b86d32")
require("x64:2592480ec6fb20")
require("x64:82e483682822deb")
require("x64:8aedb8c71f568d4")
CoD.vhud_attack_helicopter_internal = InheritFrom(LUI.UIElement)
CoD.vhud_attack_helicopter_internal.__defaultWidth = 1920
CoD.vhud_attack_helicopter_internal.__defaultHeight = 1080
CoD.vhud_attack_helicopter_internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_attack_helicopter_internal)
	self.id = "vhud_attack_helicopter_internal"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	local VignetteContainer = CoD.VehicleGround_VignetteContainer.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	VignetteContainer:setAlpha(0.1)
	self:addElement(VignetteContainer)
	self.VignetteContainer = VignetteContainer
	local VehicleGroundIris = CoD.vhud_ms_Iris.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	VehicleGroundIris:setRGB(1, 0.35, 0.35)
	VehicleGroundIris:linkToElementModel(self, nil, false, function(model)
		VehicleGroundIris:setModel(model, f1_arg1)
	end)
	VehicleGroundIris:registerEventHandler("menu_loaded", function(element, event)
		local f3_local0 = nil
		if element.menuLoaded then
			f3_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f3_local0 = element.super:menuLoaded(event)
		end
		PlayClipOnElement(self, {
			elementName = "VehicleGroundIris",
			clipName = "StartUp",
		}, f1_arg1)
		if not f3_local0 then
			f3_local0 = element:dispatchEventToChildren(event)
		end
		return f3_local0
	end)
	self:addElement(VehicleGroundIris)
	self.VehicleGroundIris = VehicleGroundIris
	local reticle = CoD.vhud_attack_helicopter_reticle.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	reticle:linkToElementModel(self, nil, false, function(model)
		reticle:setModel(model, f1_arg1)
	end)
	self:addElement(reticle)
	self.reticle = reticle
	local dpsVehicleReticle = CoD.vhud_ms_Reticle.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	dpsVehicleReticle:mergeStateConditions({
		{
			stateName = "Zoom",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "zoomed")
			end,
		},
	})
	dpsVehicleReticle:linkToElementModel(dpsVehicleReticle, "zoomed", true, function(model)
		f1_arg0:updateElementState(dpsVehicleReticle, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "zoomed",
		})
	end)
	dpsVehicleReticle:setRGB(1, 0.59, 0.59)
	dpsVehicleReticle:setAlpha(0)
	dpsVehicleReticle:linkToElementModel(self, nil, false, function(model)
		dpsVehicleReticle:setModel(model, f1_arg1)
	end)
	dpsVehicleReticle:registerEventHandler("menu_loaded", function(element, event)
		local f8_local0 = nil
		if element.menuLoaded then
			f8_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f8_local0 = element.super:menuLoaded(event)
		end
		PlayClipOnElement(self, {
			elementName = "dpsVehicleReticle",
			clipName = "StartUp",
		}, f1_arg1)
		if not f8_local0 then
			f8_local0 = element:dispatchEventToChildren(event)
		end
		return f8_local0
	end)
	self:addElement(dpsVehicleReticle)
	self.dpsVehicleReticle = dpsVehicleReticle
	local ButtonLayout = CoD.vhud_attack_helicopter_button_layout.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	ButtonLayout:linkToElementModel(self, "bindings", false, function(model)
		ButtonLayout:setModel(model, f1_arg1)
	end)
	self:addElement(ButtonLayout)
	self.ButtonLayout = ButtonLayout
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_attack_helicopter_internal.__onClose = function(f10_arg0)
	f10_arg0.VignetteContainer:close()
	f10_arg0.VehicleGroundIris:close()
	f10_arg0.reticle:close()
	f10_arg0.dpsVehicleReticle:close()
	f10_arg0.ButtonLayout:close()
end
