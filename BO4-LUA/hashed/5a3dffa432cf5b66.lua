require("x64:e201e7e41431aa7")
CoD.ContextNotification_SpecialistWeaponHintList = InheritFrom(LUI.UIElement)
CoD.ContextNotification_SpecialistWeaponHintList.__defaultWidth = 300
CoD.ContextNotification_SpecialistWeaponHintList.__defaultHeight = 30
CoD.ContextNotification_SpecialistWeaponHintList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ContextNotification_SpecialistWeaponHintList)
	self.id = "ContextNotification_SpecialistWeaponHintList"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NotificationTextCenter = LUI.UIText.new(0, 0, 0, 300, 0, 0, 0, 30)
	NotificationTextCenter:setTTF("ttmussels_regular")
	NotificationTextCenter:setLetterSpacing(1)
	NotificationTextCenter:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	NotificationTextCenter:setBackingType(1)
	NotificationTextCenter:setBackingWidget(CoD.FE_ButtonPanel, f1_arg0, f1_arg1)
	NotificationTextCenter:setBackingColor(0, 0, 0)
	NotificationTextCenter:setBackingAlpha(0.62)
	NotificationTextCenter:setBackingXPadding(12)
	NotificationTextCenter:subscribeToGlobalModel(f1_arg1, "HUDItems", "abilityHintIndex", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			NotificationTextCenter:setText(CoD.HUDUtility.GetSpecialistWeaponHintStringLower(1, f2_local0))
		end
	end)
	self:addElement(NotificationTextCenter)
	self.NotificationTextCenter = NotificationTextCenter
	local NotificationTextLeft = LUI.UIText.new(0, 0, -170, 130, 0, 0, 0, 30)
	NotificationTextLeft:setAlpha(0)
	NotificationTextLeft:setTTF("ttmussels_regular")
	NotificationTextLeft:setLetterSpacing(1)
	NotificationTextLeft:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	NotificationTextLeft:setBackingType(1)
	NotificationTextLeft:setBackingWidget(CoD.FE_ButtonPanel, f1_arg0, f1_arg1)
	NotificationTextLeft:setBackingColor(0, 0, 0)
	NotificationTextLeft:setBackingAlpha(0.62)
	NotificationTextLeft:setBackingXPadding(12)
	NotificationTextLeft:subscribeToGlobalModel(f1_arg1, "HUDItems", "abilityHintIndex", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			NotificationTextLeft:setText(CoD.HUDUtility.GetSpecialistWeaponHintStringLower(1, f3_local0))
		end
	end)
	self:addElement(NotificationTextLeft)
	self.NotificationTextLeft = NotificationTextLeft
	local NotificationTextRight = LUI.UIText.new(0, 0, 170, 470, 0, 0, 0, 30)
	NotificationTextRight:setAlpha(0)
	NotificationTextRight:setTTF("ttmussels_regular")
	NotificationTextRight:setLetterSpacing(1)
	NotificationTextRight:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	NotificationTextRight:setBackingType(1)
	NotificationTextRight:setBackingWidget(CoD.FE_ButtonPanel, f1_arg0, f1_arg1)
	NotificationTextRight:setBackingColor(0, 0, 0)
	NotificationTextRight:setBackingAlpha(0.62)
	NotificationTextRight:setBackingXPadding(12)
	NotificationTextRight:subscribeToGlobalModel(f1_arg1, "HUDItems", "abilityHintIndex", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			NotificationTextRight:setText(CoD.HUDUtility.GetSpecialistWeaponHintStringLower(2, f4_local0))
		end
	end)
	self:addElement(NotificationTextRight)
	self.NotificationTextRight = NotificationTextRight
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				local f5_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954])
				if not f5_local0 then
					f5_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40])
					if not f5_local0 then
						f5_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x59333FC97F7870])
						if not f5_local0 then
							f5_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769])
							if not f5_local0 then
								if Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]) then
									f5_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8])
									if not f5_local0 then
										f5_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
										if not f5_local0 then
											f5_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7])
											if not f5_local0 then
												f5_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E])
												if not f5_local0 then
													f5_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x6668F0686232679])
													if not f5_local0 then
														f5_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E])
														if not f5_local0 then
															f5_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2])
															if not f5_local0 then
																f5_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F])
																if not f5_local0 then
																	f5_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
																	if not f5_local0 then
																		f5_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
																	end
																end
															end
														end
													end
												end
											end
										end
									end
								else
									f5_local0 = true
								end
							end
						end
					end
				end
				return f5_local0
			end,
		},
		{
			stateName = "TwoEntries",
			condition = function(menu, element, event)
				return CoD.HUDUtility.SpecialistWeaponHintStringLowerNumElements(f1_arg1, 2)
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954]], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40]], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870]], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769]], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8]], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7]], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E]], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679]], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E]], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2]], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]], function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local5(f1_local4, f1_local6.abilityHintIndex, function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "abilityHintIndex",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ContextNotification_SpecialistWeaponHintList.__resetProperties = function(f23_arg0)
	f23_arg0.NotificationTextCenter:completeAnimation()
	f23_arg0.NotificationTextLeft:completeAnimation()
	f23_arg0.NotificationTextRight:completeAnimation()
	f23_arg0.NotificationTextCenter:setAlpha(1)
	f23_arg0.NotificationTextLeft:setAlpha(0)
	f23_arg0.NotificationTextRight:setAlpha(0)
end
CoD.ContextNotification_SpecialistWeaponHintList.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(3)
			f25_arg0.NotificationTextCenter:completeAnimation()
			f25_arg0.NotificationTextCenter:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.NotificationTextCenter)
			f25_arg0.NotificationTextLeft:completeAnimation()
			f25_arg0.NotificationTextLeft:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.NotificationTextLeft)
			f25_arg0.NotificationTextRight:completeAnimation()
			f25_arg0.NotificationTextRight:setAlpha(0)
			f25_arg0.clipFinished(f25_arg0.NotificationTextRight)
		end,
	},
	TwoEntries = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(3)
			f26_arg0.NotificationTextCenter:completeAnimation()
			f26_arg0.NotificationTextCenter:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.NotificationTextCenter)
			f26_arg0.NotificationTextLeft:completeAnimation()
			f26_arg0.NotificationTextLeft:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.NotificationTextLeft)
			f26_arg0.NotificationTextRight:completeAnimation()
			f26_arg0.NotificationTextRight:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.NotificationTextRight)
		end,
	},
}
CoD.ContextNotification_SpecialistWeaponHintList.__onClose = function(f27_arg0)
	f27_arg0.NotificationTextCenter:close()
	f27_arg0.NotificationTextLeft:close()
	f27_arg0.NotificationTextRight:close()
end
