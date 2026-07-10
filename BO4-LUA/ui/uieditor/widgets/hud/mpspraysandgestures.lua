require("x64:e53b80d4668a156")
require("x64:d454b077a7fea61")
require("x64:be39623686bc47e")
require("x64:2675595fa323085")
CoD.MPSpraysAndGestures = InheritFrom(LUI.UIElement)
CoD.MPSpraysAndGestures.__defaultWidth = 1920
CoD.MPSpraysAndGestures.__defaultHeight = 1080
CoD.MPSpraysAndGestures.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setUseCylinderMapping(false)
	self:setClass(CoD.MPSpraysAndGestures)
	self.id = "MPSpraysAndGestures"
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
	CenterCircle:setImage(RegisterImage(@"uie_ui_hud_radial_menu_center_circle"))
	CenterCircle:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_F755127C95CF5B6"))
	CenterCircle:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(CenterCircle)
	self.CenterCircle = CenterCircle
	local SpraysAndGestures = LUI.WheelLayout.new(f1_arg0, f1_arg1, nil)
	SpraysAndGestures:setLeftRight(0.5, 0.5, -177, 177)
	SpraysAndGestures:setTopBottom(0.5, 0.5, -177, 177)
	SpraysAndGestures:setWidgetType(CoD.SprayOrGesture)
	SpraysAndGestures:setCount(8)
	SpraysAndGestures:setDataSource("SpraysAndGestures")
	self:addElement(SpraysAndGestures)
	self.SpraysAndGestures = SpraysAndGestures
	local MPWheelPrompt = CoD.MPWheelPrompt.new(f1_arg0, f1_arg1, 0.5, 0.5, -40, 40, 0.5, 0.5, -40, 40)
	MPWheelPrompt:subscribeToGlobalModel(f1_arg1, "Controller", "move_right_stick_button_image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			MPWheelPrompt.RStick:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(MPWheelPrompt)
	self.MPWheelPrompt = MPWheelPrompt
	local Pointer = CoD.WheelTriangleIndicator.new(f1_arg0, f1_arg1, 0.5, 0.5, -12, 12, 0.5, 0.5, -12, 12)
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
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f4_local0
	end)
	f1_arg0:AddButtonCallbackFunction(emptyFocusable, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if IsPC() then
			SetElementState(self, self, controller, "DefaultState")
			return true
		else
		end
	end, function(element, menu, controller)
		if IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
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
				local f7_local0 = CoD.HUDUtility.IsSpraysAndGesturesButtonHeld(f1_arg1)
				if f7_local0 then
					if not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_game_ended"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_missile"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_vehicle"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_demo_playing"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_player_dead"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_round_end_killcam"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]) and not Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_spectating_client"]) and not CoD.HUDUtility.HideWheelInPrematch(f1_arg1) then
						f7_local0 = not CoD.ModelUtility.IsClientModelValueTrue(f1_arg1, "isInLastStand")
					else
						f7_local0 = false
					end
				end
				return f7_local0
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["ButtonBits.actionSlots.Sprays_Boasts"], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "ButtonBits.actionSlots.Sprays_Boasts",
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["hudItems.PCWheels.sprayGestureWheelKeyPressed"], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "hudItems.PCWheels.sprayGestureWheelKeyPressed",
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["hudItems.PCWheels.calloutWheelKeyPressed"], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "hudItems.PCWheels.calloutWheelKeyPressed",
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"]], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_game_ended"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_missile"]], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_missile"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"]], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_demo_playing"]], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_demo_playing"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_player_dead"]], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_player_dead"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_round_end_killcam"]], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_round_end_killcam"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"]], function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[@"getmodelforclient"](Engine[@"getclientnum"](f1_arg1))
	f1_local8(f1_local7, f1_local9.isInLastStand, function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "isInLastStand",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f22_arg2, f22_arg3, f22_arg4)
		if IsSelfInState(self, "Visible") then
			CoD.HUDUtility.MenuDelayedSetRightStickLock(f1_arg0, controller, 0, true)
		else
			CoD.HUDUtility.MenuDelayedSetRightStickLock(f1_arg0, controller, 125, false)
			CoD.HUDUtility.DisableWheelSelection(controller, self, self.SpraysAndGestures)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "RightStick", "Length", function(model)
		local f23_local0 = self
		if IsSelfInState(self, "Visible") then
			CoD.HUDUtility.UpdateSelectionModelFromLength(f1_arg1, self, self.SpraysAndGestures, model, false)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "RightStick", "Degrees", function(model)
		local f24_local0 = self
		if IsSelfInState(self, "Visible") then
			CoD.HUDUtility.UpdateSelectionModelFromDegrees(f1_arg1, self, self.SpraysAndGestures, false)
		end
	end)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "ButtonBits.actionSlots.Sprays_Boasts", function(model)
		local f25_local0 = self
		if CoD.ModelUtility.IsParamModelEqualToEnum(model, Enum[@"hash_1A3A4D6F29781E2C"][@"hash_643535815622BB59"]) then
			CoD.HUDUtility.AddQuickSprayCallback(f1_arg1)
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
	CoD.HUDUtility.AddSprayGestureCallback(f1_arg1, self.SpraysAndGestures)
	CoD.HUDUtility.InitWheelPCForMouseDrag(self, f1_arg1, f1_arg0, self.SpraysAndGestures)
	return self
end
CoD.MPSpraysAndGestures.__resetProperties = function(f26_arg0)
	f26_arg0.SpraysAndGestures:completeAnimation()
	f26_arg0.CenterCircle:completeAnimation()
	f26_arg0.BGDarkening:completeAnimation()
	f26_arg0.Pointer:completeAnimation()
	f26_arg0.MPWheelPrompt:completeAnimation()
	f26_arg0.emptyFocusable:completeAnimation()
	f26_arg0.SpraysAndGestures:setAlpha(1)
	f26_arg0.CenterCircle:setAlpha(1)
	f26_arg0.BGDarkening:setAlpha(0.65)
	f26_arg0.Pointer:setAlpha(1)
	f26_arg0.MPWheelPrompt:setAlpha(1)
	f26_arg0.emptyFocusable:setAlpha(1)
end
CoD.MPSpraysAndGestures.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(6)
			f27_arg0.BGDarkening:completeAnimation()
			f27_arg0.BGDarkening:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.BGDarkening)
			f27_arg0.CenterCircle:completeAnimation()
			f27_arg0.CenterCircle:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.CenterCircle)
			f27_arg0.SpraysAndGestures:completeAnimation()
			f27_arg0.SpraysAndGestures:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.SpraysAndGestures)
			f27_arg0.MPWheelPrompt:completeAnimation()
			f27_arg0.MPWheelPrompt:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.MPWheelPrompt)
			f27_arg0.Pointer:completeAnimation()
			f27_arg0.Pointer:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.Pointer)
			f27_arg0.emptyFocusable:completeAnimation()
			f27_arg0.emptyFocusable:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.emptyFocusable)
		end,
		Visible = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(5)
			local f28_local0 = function(f29_arg0)
				f28_arg0.BGDarkening:beginAnimation(60)
				f28_arg0.BGDarkening:setAlpha(0.4)
				f28_arg0.BGDarkening:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.BGDarkening:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.BGDarkening:completeAnimation()
			f28_arg0.BGDarkening:setAlpha(0)
			f28_local0(f28_arg0.BGDarkening)
			local f28_local1 = function(f30_arg0)
				f28_arg0.CenterCircle:beginAnimation(60)
				f28_arg0.CenterCircle:setAlpha(1)
				f28_arg0.CenterCircle:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.CenterCircle:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.CenterCircle:completeAnimation()
			f28_arg0.CenterCircle:setAlpha(0)
			f28_local1(f28_arg0.CenterCircle)
			local f28_local2 = function(f31_arg0)
				f28_arg0.SpraysAndGestures:beginAnimation(60)
				f28_arg0.SpraysAndGestures:setAlpha(1)
				f28_arg0.SpraysAndGestures:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.SpraysAndGestures:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.SpraysAndGestures:completeAnimation()
			f28_arg0.SpraysAndGestures:setAlpha(0)
			f28_local2(f28_arg0.SpraysAndGestures)
			local f28_local3 = function(f32_arg0)
				f28_arg0.MPWheelPrompt:beginAnimation(60)
				f28_arg0.MPWheelPrompt:setAlpha(1)
				f28_arg0.MPWheelPrompt:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.MPWheelPrompt:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.MPWheelPrompt:completeAnimation()
			f28_arg0.MPWheelPrompt:setAlpha(0)
			f28_local3(f28_arg0.MPWheelPrompt)
			local f28_local4 = function(f33_arg0)
				f28_arg0.Pointer:beginAnimation(60)
				f28_arg0.Pointer:setAlpha(1)
				f28_arg0.Pointer:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.Pointer:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.Pointer:completeAnimation()
			f28_arg0.Pointer:setAlpha(0)
			f28_local4(f28_arg0.Pointer)
		end,
	},
	Visible = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(0)
		end,
		DefaultState = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(5)
			local f35_local0 = function(f36_arg0)
				f35_arg0.BGDarkening:beginAnimation(60)
				f35_arg0.BGDarkening:setAlpha(0)
				f35_arg0.BGDarkening:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.BGDarkening:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.BGDarkening:completeAnimation()
			f35_arg0.BGDarkening:setAlpha(0.4)
			f35_local0(f35_arg0.BGDarkening)
			local f35_local1 = function(f37_arg0)
				f35_arg0.CenterCircle:beginAnimation(60)
				f35_arg0.CenterCircle:setAlpha(0)
				f35_arg0.CenterCircle:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.CenterCircle:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.CenterCircle:completeAnimation()
			f35_arg0.CenterCircle:setAlpha(1)
			f35_local1(f35_arg0.CenterCircle)
			local f35_local2 = function(f38_arg0)
				f35_arg0.SpraysAndGestures:beginAnimation(60)
				f35_arg0.SpraysAndGestures:setAlpha(0)
				f35_arg0.SpraysAndGestures:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.SpraysAndGestures:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.SpraysAndGestures:completeAnimation()
			f35_arg0.SpraysAndGestures:setAlpha(1)
			f35_local2(f35_arg0.SpraysAndGestures)
			local f35_local3 = function(f39_arg0)
				f35_arg0.MPWheelPrompt:beginAnimation(60)
				f35_arg0.MPWheelPrompt:setAlpha(0)
				f35_arg0.MPWheelPrompt:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.MPWheelPrompt:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.MPWheelPrompt:completeAnimation()
			f35_arg0.MPWheelPrompt:setAlpha(1)
			f35_local3(f35_arg0.MPWheelPrompt)
			local f35_local4 = function(f40_arg0)
				f35_arg0.Pointer:beginAnimation(60)
				f35_arg0.Pointer:setAlpha(0)
				f35_arg0.Pointer:registerEventHandler("interrupted_keyframe", f35_arg0.clipInterrupted)
				f35_arg0.Pointer:registerEventHandler("transition_complete_keyframe", f35_arg0.clipFinished)
			end
			f35_arg0.Pointer:completeAnimation()
			f35_arg0.Pointer:setAlpha(1)
			f35_local4(f35_arg0.Pointer)
		end,
	},
}
CoD.MPSpraysAndGestures.__onClose = function(f41_arg0)
	f41_arg0.SpraysAndGestures:close()
	f41_arg0.MPWheelPrompt:close()
	f41_arg0.Pointer:close()
	f41_arg0.emptyFocusable:close()
end
