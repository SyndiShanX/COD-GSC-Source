CoD.WarzoneDpadButton = InheritFrom(LUI.UIElement)
CoD.WarzoneDpadButton.__defaultWidth = 64
CoD.WarzoneDpadButton.__defaultHeight = 64
CoD.WarzoneDpadButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneDpadButton)
	self.id = "WarzoneDpadButton"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local downImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	downImage:setAlpha(0)
	downImage:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	downImage:setShaderVector(0, 0.33, 0.67, 0, 0)
	downImage:setShaderVector(1, 0, 0, 0, 0)
	downImage:setShaderVector(2, 0, 0.4, 0, 0)
	downImage:setShaderVector(3, 0, 0, 0, 0)
	downImage:setShaderVector(4, 0, 0, 0, 0)
	downImage:subscribeToGlobalModel(f1_arg1, "Controller", "dpad_up_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			downImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(downImage)
	self.downImage = downImage
	local downImage2 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	downImage2:setImage(RegisterImage(0x6D448065C5FDC56))
	self:addElement(downImage2)
	self.downImage2 = downImage2
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return true
			end,
		},
		{
			stateName = "VisibleForCallout",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneDpadButton.__resetProperties = function(f5_arg0)
	f5_arg0.downImage:completeAnimation()
	f5_arg0.downImage2:completeAnimation()
	f5_arg0.downImage:setAlpha(0)
	f5_arg0.downImage2:setAlpha(1)
end
CoD.WarzoneDpadButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.downImage:completeAnimation()
			f6_arg0.downImage:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.downImage)
			f6_arg0.downImage2:completeAnimation()
			f6_arg0.downImage2:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.downImage2)
		end,
	},
	Visible = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.downImage:completeAnimation()
			f7_arg0.downImage:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.downImage)
		end,
	},
	VisibleForCallout = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.downImage:completeAnimation()
			f8_arg0.downImage:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.downImage)
		end,
	},
}
CoD.WarzoneDpadButton.__onClose = function(f9_arg0)
	f9_arg0.downImage:close()
end
