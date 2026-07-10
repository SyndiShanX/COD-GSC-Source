require("x64:e53b80d4668a156")
require("x64:2c675b2e8bcdb4d")
require("x64:be39623686bc47e")
require("x64:2675595fa323085")
CoD.MPCalloutItems = InheritFrom(LUI.UIElement)
CoD.MPCalloutItems.__defaultWidth = 1920
CoD.MPCalloutItems.__defaultHeight = 1080
CoD.MPCalloutItems.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setUseCylinderMapping(false)
	self:setClass(CoD.MPCalloutItems)
	self.id = "MPCalloutItems"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BGDarkening = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGDarkening:setRGB(0, 0, 0)
	BGDarkening:setAlpha(0.65)
	self:addElement(BGDarkening)
	self.BGDarkening = BGDarkening
	local CenterCircle = LUI.UIImage.new(0.5, 0.5, -78, 78, 0.5, 0.5, -78, 78)
	CenterCircle:setImage(RegisterImage(0x9795F40414AD24A))
	CenterCircle:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	CenterCircle:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(CenterCircle)
	self.CenterCircle = CenterCircle
	local CalloutItems = LUI.WheelLayout.new(f1_arg0, f1_arg1, nil)
	CalloutItems:setLeftRight(0.5, 0.5, -177, 177)
	CalloutItems:setTopBottom(0.5, 0.5, -177, 177)
	CalloutItems:setWidgetType(CoD.CalloutItem)
	CalloutItems:setCount(10)
	CalloutItems:setDataSource("CalloutWheel")
	self:addElement(CalloutItems)
	self.CalloutItems = CalloutItems
	local MPWheelPrompt = CoD.MPWheelPrompt.new(f1_arg0, f1_arg1, 0.5, 0.5, -9.5, 9.5, 0.5, 0.5, -5.5, 5.5)
	MPWheelPrompt:subscribeToGlobalModel(f1_arg1, "Controller", "move_right_stick_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			MPWheelPrompt.RStick:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(MPWheelPrompt)
	self.MPWheelPrompt = MPWheelPrompt
	local Pointer = CoD.WheelTriangleIndicator.new(f1_arg0, f1_arg1, 0.5, 0.5, -9.5, 9.5, 0.5, 0.5, -5.5, 5.5)
	Pointer:subscribeToGlobalModel(f1_arg1, "HUDItems", "wheelPointerDegrees", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Pointer:setZRot(f3_local0)
		end
	end)
	self:addElement(Pointer)
	self.Pointer = Pointer
	local emptyFocusable = nil
	emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	emptyFocusable:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f4_local0
	end)
	f1_arg0:AddButtonCallbackFunction(emptyFocusable, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		if IsPC() then
			SetElementState(self, self, controller, "DefaultState")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f7_local0 = CoD.HUDUtility.IsCalloutsButtonPressed(f1_arg1)
				if f7_local0 then
					if not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC]) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x534C7B2375D2D47]) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5]) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]) and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD]) then
						f7_local0 = CoD.HUDUtility.EnableCalloutWheel()
						if f7_local0 then
							if not CoD.HUDUtility.HideWheelInPrematch(f1_arg1) and not IsInTheaterMode() then
								f7_local0 = not CoD.ModelUtility.IsClientModelValueTrue(f1_arg1, "isInLastStand")
							else
								f7_local0 = false
							end
						else
							return f7_local0
						end
					end
					f7_local0 = false
				end
				return f7_local0
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["ButtonBits.actionSlots.Flourish_Callouts"], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "ButtonBits.actionSlots.Flourish_Callouts",
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["hudItems.PCWheels.calloutWheelKeyPressed"], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "hudItems.PCWheels.calloutWheelKeyPressed",
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["hudItems.PCWheels.sprayGestureWheelKeyPressed"], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "hudItems.PCWheels.sprayGestureWheelKeyPressed",
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x534C7B2375D2D47]], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x534C7B2375D2D47],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5]], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD]], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x8DF2E5447F384B9]()
	f1_local8(f1_local7, f1_local9["lobbyRoot.lobbyNav"], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0xE4D2F32833CFA6C](Engine[0x761955642304848](f1_arg1))
	f1_local8(f1_local7, f1_local9.isInLastStand, function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "isInLastStand",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f18_arg2, f18_arg3, f18_arg4)
		if IsSelfInState(self, "Visible") then
			CoD.HUDUtility.MenuDelayedSetRightStickLock(f1_arg0, controller, 0, true)
		else
			CoD.HUDUtility.MenuDelayedSetRightStickLock(f1_arg0, controller, 125, false)
			CoD.HUDUtility.DisableWheelSelection(controller, self, self.CalloutItems)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "RightStick", "Length", function(model)
		local f19_local0 = self
		if IsSelfInState(self, "Visible") then
			CoD.HUDUtility.UpdateSelectionModelFromLength(f1_arg1, self, self.CalloutItems, model, false)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "RightStick", "Degrees", function(model)
		local f20_local0 = self
		if IsSelfInState(self, "Visible") then
			CoD.HUDUtility.UpdateSelectionModelFromDegrees(f1_arg1, self, self.CalloutItems, false)
		end
	end)
	if CoD.isPC then
		emptyFocusable.id = "emptyFocusable"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local8 = self
	CoD.HUDUtility.AddCalloutWheelCallback(f1_arg1, self.CalloutItems)
	CoD.HUDUtility.InitWheelPCForMouseDrag(self, f1_arg1, f1_arg0, self.CalloutItems)
	return self
end
CoD.MPCalloutItems.__resetProperties = function(f21_arg0)
	f21_arg0.CalloutItems:completeAnimation()
	f21_arg0.Pointer:completeAnimation()
	f21_arg0.CenterCircle:completeAnimation()
	f21_arg0.BGDarkening:completeAnimation()
	f21_arg0.MPWheelPrompt:completeAnimation()
	f21_arg0.emptyFocusable:completeAnimation()
	f21_arg0.CalloutItems:setAlpha(1)
	f21_arg0.Pointer:setAlpha(1)
	f21_arg0.CenterCircle:setAlpha(1)
	f21_arg0.BGDarkening:setAlpha(0.65)
	f21_arg0.MPWheelPrompt:setAlpha(1)
	f21_arg0.emptyFocusable:setAlpha(1)
end
CoD.MPCalloutItems.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(6)
			f22_arg0.BGDarkening:completeAnimation()
			f22_arg0.BGDarkening:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.BGDarkening)
			f22_arg0.CenterCircle:completeAnimation()
			f22_arg0.CenterCircle:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.CenterCircle)
			f22_arg0.CalloutItems:completeAnimation()
			f22_arg0.CalloutItems:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.CalloutItems)
			f22_arg0.MPWheelPrompt:completeAnimation()
			f22_arg0.MPWheelPrompt:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.MPWheelPrompt)
			f22_arg0.Pointer:completeAnimation()
			f22_arg0.Pointer:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.Pointer)
			f22_arg0.emptyFocusable:completeAnimation()
			f22_arg0.emptyFocusable:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.emptyFocusable)
		end,
		Visible = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(6)
			local f23_local0 = function(f24_arg0)
				f23_arg0.BGDarkening:beginAnimation(60)
				f23_arg0.BGDarkening:setAlpha(0.65)
				f23_arg0.BGDarkening:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.BGDarkening:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.BGDarkening:completeAnimation()
			f23_arg0.BGDarkening:setAlpha(0)
			f23_local0(f23_arg0.BGDarkening)
			local f23_local1 = function(f25_arg0)
				f23_arg0.CenterCircle:beginAnimation(60)
				f23_arg0.CenterCircle:setAlpha(1)
				f23_arg0.CenterCircle:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.CenterCircle:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.CenterCircle:completeAnimation()
			f23_arg0.CenterCircle:setAlpha(0)
			f23_local1(f23_arg0.CenterCircle)
			local f23_local2 = function(f26_arg0)
				f23_arg0.CalloutItems:beginAnimation(60)
				f23_arg0.CalloutItems:setAlpha(1)
				f23_arg0.CalloutItems:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.CalloutItems:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.CalloutItems:completeAnimation()
			f23_arg0.CalloutItems:setAlpha(0)
			f23_local2(f23_arg0.CalloutItems)
			local f23_local3 = function(f27_arg0)
				f23_arg0.MPWheelPrompt:beginAnimation(60)
				f23_arg0.MPWheelPrompt:setAlpha(1)
				f23_arg0.MPWheelPrompt:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.MPWheelPrompt:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.MPWheelPrompt:completeAnimation()
			f23_arg0.MPWheelPrompt:setAlpha(0)
			f23_local3(f23_arg0.MPWheelPrompt)
			local f23_local4 = function(f28_arg0)
				f23_arg0.Pointer:beginAnimation(60)
				f23_arg0.Pointer:setAlpha(1)
				f23_arg0.Pointer:registerEventHandler("interrupted_keyframe", f23_arg0.clipInterrupted)
				f23_arg0.Pointer:registerEventHandler("transition_complete_keyframe", f23_arg0.clipFinished)
			end
			f23_arg0.Pointer:completeAnimation()
			f23_arg0.Pointer:setAlpha(0)
			f23_local4(f23_arg0.Pointer)
			f23_arg0.emptyFocusable:completeAnimation()
			f23_arg0.emptyFocusable:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.emptyFocusable)
		end,
	},
	Visible = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(0)
		end,
		DefaultState = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(5)
			local f30_local0 = function(f31_arg0)
				local f31_local0 = function(f32_arg0)
					f32_arg0:beginAnimation(380)
					f32_arg0:setAlpha(0)
					f32_arg0:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
				end
				f30_arg0.BGDarkening:beginAnimation(120)
				f30_arg0.BGDarkening:setAlpha(0.4)
				f30_arg0.BGDarkening:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.BGDarkening:registerEventHandler("transition_complete_keyframe", f31_local0)
			end
			f30_arg0.BGDarkening:completeAnimation()
			f30_arg0.BGDarkening:setAlpha(0.65)
			f30_local0(f30_arg0.BGDarkening)
			local f30_local1 = function(f33_arg0)
				local f33_local0 = function(f34_arg0)
					f34_arg0:beginAnimation(380)
					f34_arg0:setAlpha(0)
					f34_arg0:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
				end
				f30_arg0.CenterCircle:beginAnimation(120)
				f30_arg0.CenterCircle:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.CenterCircle:registerEventHandler("transition_complete_keyframe", f33_local0)
			end
			f30_arg0.CenterCircle:completeAnimation()
			f30_arg0.CenterCircle:setAlpha(1)
			f30_local1(f30_arg0.CenterCircle)
			local f30_local2 = function(f35_arg0)
				f30_arg0.CalloutItems:beginAnimation(500, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
				f30_arg0.CalloutItems:setAlpha(0)
				f30_arg0.CalloutItems:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.CalloutItems:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
			end
			f30_arg0.CalloutItems:completeAnimation()
			f30_arg0.CalloutItems:setAlpha(1)
			f30_local2(f30_arg0.CalloutItems)
			local f30_local3 = function(f36_arg0)
				f30_arg0.MPWheelPrompt:beginAnimation(120)
				f30_arg0.MPWheelPrompt:setAlpha(0)
				f30_arg0.MPWheelPrompt:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.MPWheelPrompt:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
			end
			f30_arg0.MPWheelPrompt:completeAnimation()
			f30_arg0.MPWheelPrompt:setAlpha(1)
			f30_local3(f30_arg0.MPWheelPrompt)
			local f30_local4 = function(f37_arg0)
				f30_arg0.Pointer:beginAnimation(120)
				f30_arg0.Pointer:setAlpha(0)
				f30_arg0.Pointer:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.Pointer:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
			end
			f30_arg0.Pointer:completeAnimation()
			f30_arg0.Pointer:setAlpha(1)
			f30_local4(f30_arg0.Pointer)
		end,
	},
}
CoD.MPCalloutItems.__onClose = function(f38_arg0)
	f38_arg0.CalloutItems:close()
	f38_arg0.MPWheelPrompt:close()
	f38_arg0.Pointer:close()
	f38_arg0.emptyFocusable:close()
end
