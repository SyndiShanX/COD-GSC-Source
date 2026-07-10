CoD.InvalidCmdPrompt = InheritFrom(LUI.UIElement)
CoD.InvalidCmdPrompt.__defaultWidth = 1920
CoD.InvalidCmdPrompt.__defaultHeight = 24
CoD.InvalidCmdPrompt.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.InvalidCmdPrompt)
	self.id = "InvalidCmdPrompt"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local text = LUI.UIText.new(0.5, 0.5, -960, 960, 0, 0, 0, 24)
	text:setTTF("ttmussels_regular")
	text:setLetterSpacing(1)
	text:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	text:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	text:setBackingType(2)
	text:setBackingColor(0, 0, 0)
	text:setBackingAlpha(0.62)
	text:setBackingXPadding(12)
	text:setBackingYPadding(2)
	text:subscribeToGlobalModel(f1_arg1, "HUDItems", "invalidCmdHintEnum", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			text:setText(CoD.NotificationUtility.GetInvalidCmdHint(f2_local0))
		end
	end)
	self:addElement(text)
	self.text = text
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				local f3_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_guided_missile"])
				if not f3_local0 then
					f3_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_killcam"])
					if not f3_local0 then
						f3_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"])
						if not f3_local0 then
							f3_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_in_vehicle"])
							if not f3_local0 then
								f3_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_is_flash_banged"])
								if not f3_local0 then
									f3_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_selecting_location"])
									if not f3_local0 then
										f3_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_spectating_client"])
										if not f3_local0 then
											f3_local0 = Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_ui_active"])
										end
									end
								end
							end
						end
					end
				end
				return f3_local0
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"]], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_guided_missile"],
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"]], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_killcam"],
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"]], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_remote_killstreak_static"],
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"]], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_in_vehicle"],
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"]], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_is_flash_banged"],
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_selecting_location"]], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_selecting_location"],
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"]], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_spectating_client"],
		})
	end, false)
	f1_local2 = self
	f1_local3 = self.subscribeToModel
	f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"]], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_ui_active"],
		})
	end, false)
	self:subscribeToGlobalModel(f1_arg1, "HUDItems", "invalidCmdHintTime", function(model)
		local f12_local0 = self
		PlayClip(self, "Prompt", f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.InvalidCmdPrompt.__resetProperties = function(f13_arg0)
	f13_arg0.text:completeAnimation()
	f13_arg0.text:setAlpha(1)
end
CoD.InvalidCmdPrompt.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.text:completeAnimation()
			f14_arg0.text:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.text)
		end,
		Prompt = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			local f15_local0 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					local f17_local0 = function(f18_arg0)
						local f18_local0 = function(f19_arg0)
							local f19_local0 = function(f20_arg0)
								f20_arg0:beginAnimation(380)
								f20_arg0:setAlpha(0)
								f20_arg0:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
							end
							f19_arg0:beginAnimation(280)
							f19_arg0:setAlpha(0.5)
							f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
						end
						f18_arg0:beginAnimation(279)
						f18_arg0:setAlpha(1)
						f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
					end
					f17_arg0:beginAnimation(280)
					f17_arg0:setAlpha(0.5)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
				end
				f15_arg0.text:beginAnimation(280)
				f15_arg0.text:setAlpha(1)
				f15_arg0.text:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.text:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f15_arg0.text:completeAnimation()
			f15_arg0.text:setAlpha(0)
			f15_local0(f15_arg0.text)
		end,
	},
	Hidden = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			f21_arg0.text:completeAnimation()
			f21_arg0.text:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.text)
		end,
	},
}
CoD.InvalidCmdPrompt.__onClose = function(f22_arg0)
	f22_arg0.text:close()
end
