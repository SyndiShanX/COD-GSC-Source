require("x64:33abf882f693ea5")
require("x64:37707168e577a79")
CoD.vhud_ai_tank_button_layout = InheritFrom(LUI.UIElement)
CoD.vhud_ai_tank_button_layout.__defaultWidth = 1920
CoD.vhud_ai_tank_button_layout.__defaultHeight = 1080
CoD.vhud_ai_tank_button_layout.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.vhud_ai_tank_button_layout)
	self.id = "vhud_ai_tank_button_layout"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local vhudgenerickeymouselayout = nil
	vhudgenerickeymouselayout = CoD.vhud_generic_key_mouse_layout.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	vhudgenerickeymouselayout:setAlpha(0)
	vhudgenerickeymouselayout:linkToElementModel(self, nil, false, function(model)
		vhudgenerickeymouselayout:setModel(model, f1_arg1)
	end)
	self:addElement(vhudgenerickeymouselayout)
	self.vhudgenerickeymouselayout = vhudgenerickeymouselayout
	local vhudgenericgamepadlayout = CoD.vhud_generic_gamepad_layout.new(f1_arg0, f1_arg1, 0, 0.95, 0, 0, 0, 1, 0, 0)
	vhudgenericgamepadlayout:linkToElementModel(self, nil, false, function(model)
		vhudgenericgamepadlayout:setModel(model, f1_arg1)
	end)
	self:addElement(vhudgenericgamepadlayout)
	self.vhudgenericgamepadlayout = vhudgenericgamepadlayout
	self:mergeStateConditions({
		{
			stateName = "UsingKeyboardMouse",
			condition = function(menu, element, event)
				return not IsGamepad(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f5_arg1)
	end)
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5.LastInput, function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.vhud_ai_tank_button_layout.__resetProperties = function(f7_arg0)
	f7_arg0.vhudgenerickeymouselayout:completeAnimation()
	f7_arg0.vhudgenericgamepadlayout:completeAnimation()
	f7_arg0.vhudgenerickeymouselayout:setAlpha(0)
	f7_arg0.vhudgenericgamepadlayout:setAlpha(1)
end
CoD.vhud_ai_tank_button_layout.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	UsingKeyboardMouse = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.vhudgenerickeymouselayout:completeAnimation()
			f9_arg0.vhudgenerickeymouselayout:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.vhudgenerickeymouselayout)
			f9_arg0.vhudgenericgamepadlayout:completeAnimation()
			f9_arg0.vhudgenericgamepadlayout:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.vhudgenericgamepadlayout)
		end,
	},
}
CoD.vhud_ai_tank_button_layout.__onClose = function(f10_arg0)
	f10_arg0.vhudgenerickeymouselayout:close()
	f10_arg0.vhudgenericgamepadlayout:close()
end
