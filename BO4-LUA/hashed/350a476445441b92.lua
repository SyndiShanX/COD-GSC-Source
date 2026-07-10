require("x64:b255e86c69fe33f")
require("x64:bf7ef70b7404b31")
require("x64:e1ae605b30b1f72")
CoD.vhud_ai_tank_internal = InheritFrom(LUI.UIElement)
CoD.vhud_ai_tank_internal.__defaultWidth = 1920
CoD.vhud_ai_tank_internal.__defaultHeight = 1080
CoD.vhud_ai_tank_internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_ai_tank_internal)
	self.id = "vhud_ai_tank_internal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local vignetteCenter = LUI.UIImage.new(0, 1, -300, 300, 0, 1, -188, 188)
	vignetteCenter:setAlpha(0.6)
	vignetteCenter:setImage(RegisterImage(0xEE4980C2A8CEA50))
	self:addElement(vignetteCenter)
	self.vignetteCenter = vignetteCenter
	local Vignette = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Vignette:setAlpha(0.85)
	Vignette:setImage(RegisterImage(0xC4A3981E8245142))
	self:addElement(Vignette)
	self.Vignette = Vignette
	local vhudagrreticle = CoD.vhud_agr_reticle.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	vhudagrreticle:mergeStateConditions({
		{
			stateName = "Zoom",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "zoomed")
			end,
		},
	})
	vhudagrreticle:linkToElementModel(vhudagrreticle, "zoomed", true, function(model)
		f1_arg0:updateElementState(vhudagrreticle, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "zoomed",
		})
	end)
	vhudagrreticle:linkToElementModel(self, nil, false, function(model)
		vhudagrreticle:setModel(model, f1_arg1)
	end)
	vhudagrreticle:registerEventHandler("menu_loaded", function(element, event)
		local f5_local0 = nil
		if element.menuLoaded then
			f5_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f5_local0 = element.super:menuLoaded(event)
		end
		PlayClipOnElement(self, {
			elementName = "vhudagrreticle",
			clipName = "StartUp",
		}, f1_arg1)
		if not f5_local0 then
			f5_local0 = element:dispatchEventToChildren(event)
		end
		return f5_local0
	end)
	self:addElement(vhudagrreticle)
	self.vhudagrreticle = vhudagrreticle
	local vignetteRight = LUI.UIImage.new(1, 1, -450, 0, 0.5, 0.5, -540, 540)
	vignetteRight:setAlpha(0.2)
	vignetteRight:setImage(RegisterImage(0x560D4F00008F7B7))
	self:addElement(vignetteRight)
	self.vignetteRight = vignetteRight
	local vignetteLeft = LUI.UIImage.new(0, 0, 0, 450, 0.5, 0.5, -540, 540)
	vignetteLeft:setAlpha(0.2)
	vignetteLeft:setYRot(-180)
	vignetteLeft:setImage(RegisterImage(0x560D4F00008F7B7))
	self:addElement(vignetteLeft)
	self.vignetteLeft = vignetteLeft
	local vhudagrButtonContainer = CoD.vhud_ai_tank_button_layout.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	vhudagrButtonContainer:linkToElementModel(self, "bindings", false, function(model)
		vhudagrButtonContainer:setModel(model, f1_arg1)
	end)
	vhudagrButtonContainer:registerEventHandler("menu_loaded", function(element, event)
		local f7_local0 = nil
		if element.menuLoaded then
			f7_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f7_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg1)
		if not f7_local0 then
			f7_local0 = element:dispatchEventToChildren(event)
		end
		return f7_local0
	end)
	self:addElement(vhudagrButtonContainer)
	self.vhudagrButtonContainer = vhudagrButtonContainer
	local aitankhealthbar = CoD.ai_tank_health_bar.new(f1_arg0, f1_arg1, 0, 0, 225, 634, 0, 0, 517.5, 562.5)
	aitankhealthbar:setZRot(-90)
	aitankhealthbar:linkToElementModel(self, nil, false, function(model)
		aitankhealthbar:setModel(model, f1_arg1)
	end)
	self:addElement(aitankhealthbar)
	self.aitankhealthbar = aitankhealthbar
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_ai_tank_internal.__onClose = function(f9_arg0)
	f9_arg0.vhudagrreticle:close()
	f9_arg0.vhudagrButtonContainer:close()
	f9_arg0.aitankhealthbar:close()
end
