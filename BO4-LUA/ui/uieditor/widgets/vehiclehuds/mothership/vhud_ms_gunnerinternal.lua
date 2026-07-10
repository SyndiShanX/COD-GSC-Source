require("x64:cacf05396a4a836")
require("x64:2592480ec6fb20")
require("x64:82e483682822deb")
require("x64:b5455f43e394c57")
CoD.vhud_ms_GunnerInternal = InheritFrom(LUI.UIElement)
CoD.vhud_ms_GunnerInternal.__defaultWidth = 1920
CoD.vhud_ms_GunnerInternal.__defaultHeight = 1080
CoD.vhud_ms_GunnerInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_ms_GunnerInternal)
	self.id = "vhud_ms_GunnerInternal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local VignetteContainer = CoD.VehicleGround_VignetteContainer.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	VignetteContainer:setAlpha(0.1)
	self:addElement(VignetteContainer)
	self.VignetteContainer = VignetteContainer
	local VehicleGroundIris = CoD.vhud_ms_Iris.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	VehicleGroundIris:setRGB(1, 0.35, 0.35)
	VehicleGroundIris:setAlpha(0.8)
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
	local dpsVehicleReticle = CoD.vhud_ms_ReticleGunner.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
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
	dpsVehicleReticle:setAlpha(0.38)
	dpsVehicleReticle:linkToElementModel(self, nil, false, function(model)
		dpsVehicleReticle:setModel(model, f1_arg1)
	end)
	dpsVehicleReticle:registerEventHandler("menu_loaded", function(element, event)
		local f7_local0 = nil
		if element.menuLoaded then
			f7_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f7_local0 = element.super:menuLoaded(event)
		end
		PlayClipOnElement(self, {
			elementName = "dpsVehicleReticle",
			clipName = "StartUp",
		}, f1_arg1)
		if not f7_local0 then
			f7_local0 = element:dispatchEventToChildren(event)
		end
		return f7_local0
	end)
	self:addElement(dpsVehicleReticle)
	self.dpsVehicleReticle = dpsVehicleReticle
	local vhudgenericbuttonlayout0 = CoD.vhud_generic_button_layout.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	vhudgenericbuttonlayout0:linkToElementModel(self, "bindings", false, function(model)
		vhudgenericbuttonlayout0:setModel(model, f1_arg1)
	end)
	vhudgenericbuttonlayout0:registerEventHandler("menu_loaded", function(element, event)
		local f9_local0 = nil
		if element.menuLoaded then
			f9_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f9_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg1)
		if not f9_local0 then
			f9_local0 = element:dispatchEventToChildren(event)
		end
		return f9_local0
	end)
	self:addElement(vhudgenericbuttonlayout0)
	self.vhudgenericbuttonlayout0 = vhudgenericbuttonlayout0
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_ms_GunnerInternal.__resetProperties = function(f10_arg0)
	f10_arg0.dpsVehicleReticle:completeAnimation()
	f10_arg0.VehicleGroundIris:completeAnimation()
	f10_arg0.VignetteContainer:completeAnimation()
	f10_arg0.dpsVehicleReticle:setRGB(1, 0.59, 0.59)
	f10_arg0.dpsVehicleReticle:setAlpha(0.38)
	f10_arg0.VehicleGroundIris:setRGB(1, 0.35, 0.35)
	f10_arg0.VehicleGroundIris:setAlpha(0.8)
	f10_arg0.VignetteContainer:setAlpha(0.1)
end
CoD.vhud_ms_GunnerInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			f11_arg0.VignetteContainer:completeAnimation()
			f11_arg0.VignetteContainer:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.VignetteContainer)
			f11_arg0.VehicleGroundIris:completeAnimation()
			f11_arg0.VehicleGroundIris:setRGB(1, 1, 1)
			f11_arg0.VehicleGroundIris:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.VehicleGroundIris)
			f11_arg0.dpsVehicleReticle:completeAnimation()
			f11_arg0.dpsVehicleReticle:setRGB(1, 1, 1)
			f11_arg0.dpsVehicleReticle:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.dpsVehicleReticle)
		end,
	},
}
CoD.vhud_ms_GunnerInternal.__onClose = function(f12_arg0)
	f12_arg0.VignetteContainer:close()
	f12_arg0.VehicleGroundIris:close()
	f12_arg0.dpsVehicleReticle:close()
	f12_arg0.vhudgenericbuttonlayout0:close()
end
