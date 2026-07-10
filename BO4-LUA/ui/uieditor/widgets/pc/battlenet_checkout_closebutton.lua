CoD.Battlenet_Checkout_CloseButton = InheritFrom(LUI.UIElement)
CoD.Battlenet_Checkout_CloseButton.__defaultWidth = 90
CoD.Battlenet_Checkout_CloseButton.__defaultHeight = 90
CoD.Battlenet_Checkout_CloseButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Battlenet_Checkout_CloseButton)
	self.id = "Battlenet_Checkout_CloseButton"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Image:setRGB(0.39, 0.44, 0.54)
	Image:setImage(RegisterImage(0x5023C927DE406D2))
	self:addElement(Image)
	self.Image = Image
	self:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				return not CoD.PCUtility.IsBattlenetCheckoutReady(f1_arg1)
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return not CoD.PCUtility.CanCancelBattlenetCheckout(f1_arg1)
			end,
		},
		{
			stateName = "MouseDown",
			condition = function(menu, element, event)
				return CoD.PCUtility.IsLeftMouseDown(f1_arg1) and IsElementInFocus(self)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4.battlenetCheckoutStatus, function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "battlenetCheckoutStatus",
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["KeyPressBits.MOUSE1"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "KeyPressBits.MOUSE1",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Battlenet_Checkout_CloseButton.__resetProperties = function(f7_arg0)
	f7_arg0.Image:completeAnimation()
	f7_arg0.Image:setRGB(0.39, 0.44, 0.54)
	f7_arg0.Image:setAlpha(1)
end
CoD.Battlenet_Checkout_CloseButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.Image:completeAnimation()
			f9_arg0.Image:setRGB(1, 1, 1)
			f9_arg0.clipFinished(f9_arg0.Image)
		end,
	},
	Invisible = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.Image:completeAnimation()
			f10_arg0.Image:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Image)
		end,
	},
	Disabled = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
	},
	MouseDown = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.Image:completeAnimation()
			f13_arg0.Image:setRGB(0.4, 0.4, 0.4)
			f13_arg0.clipFinished(f13_arg0.Image)
		end,
	},
}
