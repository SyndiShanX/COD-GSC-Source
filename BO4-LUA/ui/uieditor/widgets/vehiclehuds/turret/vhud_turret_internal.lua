require("x64:cacf05396a4a836")
require("x64:2592480ec6fb20")
require("x64:fd9c58738e6a329")
CoD.vhud_turret_internal = InheritFrom(LUI.UIElement)
CoD.vhud_turret_internal.__defaultWidth = 1920
CoD.vhud_turret_internal.__defaultHeight = 1080
CoD.vhud_turret_internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_turret_internal)
	self.id = "vhud_turret_internal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local vignetteCenter = LUI.UIImage.new(0, 1, -300, 300, 0, 1, -188, 188)
	vignetteCenter:setAlpha(0.5)
	vignetteCenter:setImage(RegisterImage(0xEE4980C2A8CEA50))
	self:addElement(vignetteCenter)
	self.vignetteCenter = vignetteCenter
	local VignetteContainer = CoD.VehicleGround_VignetteContainer.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	VignetteContainer:setScale(1.2, 1.2)
	self:addElement(VignetteContainer)
	self.VignetteContainer = VignetteContainer
	local buttons = CoD.vhud_generic_button_layout.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	buttons:linkToElementModel(self, "bindings", false, function(model)
		buttons:setModel(model, f1_arg1)
	end)
	buttons:registerEventHandler("menu_loaded", function(element, event)
		local f3_local0 = nil
		if element.menuLoaded then
			f3_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f3_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg1)
		if not f3_local0 then
			f3_local0 = element:dispatchEventToChildren(event)
		end
		return f3_local0
	end)
	self:addElement(buttons)
	self.buttons = buttons
	local vhudturretreticle = CoD.vhud_turret_reticle.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	vhudturretreticle:mergeStateConditions({
		{
			stateName = "Zoom",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "zoomed")
			end,
		},
	})
	vhudturretreticle:linkToElementModel(vhudturretreticle, "zoomed", true, function(model)
		f1_arg0:updateElementState(vhudturretreticle, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "zoomed",
		})
	end)
	vhudturretreticle:linkToElementModel(self, nil, false, function(model)
		vhudturretreticle:setModel(model, f1_arg1)
	end)
	vhudturretreticle:registerEventHandler("menu_loaded", function(element, event)
		local f7_local0 = nil
		if element.menuLoaded then
			f7_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f7_local0 = element.super:menuLoaded(event)
		end
		PlayClipOnElement(self, {
			elementName = "vhudturretreticle",
			clipName = "StartUp",
		}, f1_arg1)
		if not f7_local0 then
			f7_local0 = element:dispatchEventToChildren(event)
		end
		return f7_local0
	end)
	self:addElement(vhudturretreticle)
	self.vhudturretreticle = vhudturretreticle
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_turret_internal.__onClose = function(f8_arg0)
	f8_arg0.VignetteContainer:close()
	f8_arg0.buttons:close()
	f8_arg0.vhudturretreticle:close()
end
