require("x64:a4d69066248fe6b")
CoD.ReadyEvents = InheritFrom(LUI.UIElement)
CoD.ReadyEvents.__defaultWidth = 600
CoD.ReadyEvents.__defaultHeight = 180
CoD.ReadyEvents.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ReadyEvents)
	self.id = "ReadyEvents"
	self.soundSet = "HUD"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DarkenBG = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	DarkenBG:setRGB(0, 0, 0)
	DarkenBG:setAlpha(0)
	DarkenBG:setMaterial(LUI.UIImage.GetCachedMaterial(0x655565C7B387234))
	self:addElement(DarkenBG)
	self.DarkenBG = DarkenBG
	local Description = LUI.UIText.new(0.5, 0.5, -300, 300, 0.5, 0.5, 12, 42)
	Description:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	Description:setTTF("ttmussels_demibold")
	Description:setLetterSpacing(0.5)
	Description:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Description:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Description)
	self.Description = Description
	local Scorestreak = CoD.ReadyEvents_Scorestreaks.new(f1_arg0, f1_arg1, 0.5, 0.5, -150, 150, 0.5, 0.5, -42.5, 7.5)
	self:addElement(Scorestreak)
	self.Scorestreak = Scorestreak
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				local f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954])
				if not f2_local0 then
					f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40])
					if not f2_local0 then
						f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x59333FC97F7870])
						if not f2_local0 then
							if Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]) then
								f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8])
								if not f2_local0 then
									f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
									if not f2_local0 then
										f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7])
										if not f2_local0 then
											f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E])
											if not f2_local0 then
												f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x6668F0686232679])
												if not f2_local0 then
													f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E])
													if not f2_local0 then
														f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2])
														if not f2_local0 then
															f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F])
															if not f2_local0 then
																f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
																if not f2_local0 then
																	f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
																	if not f2_local0 then
																		f2_local0 = not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xBB045E46E88E762])
																	end
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
								f2_local0 = true
							end
						end
					end
				end
				return f2_local0
			end,
		},
		{
			stateName = "HiddenHacked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "hudItems.hacked", 0)
			end,
		},
		{
			stateName = "CodcasterHidden",
			condition = function(menu, element, event)
				return IsCodCaster(f1_arg1) and not CoD.CodCasterUtility.IsCodCasterWithProfileValueEqualTo(f1_arg1, "shoutcaster_ds_scorestreaks_notification", 1)
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954]], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40]], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870]], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8]], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7]], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E]], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679]], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E]], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2]], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762]], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["hudItems.hacked"], function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "hudItems.hacked",
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["factions.isCoDCaster"], function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = DataSources.CodCaster.getModel(f1_arg1)
	f1_local5(f1_local4, f1_local6.profileSettingsUpdated, function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local5 = self
	CoD.NotificationUtility.ReadyEventsPostLoad(self, f1_arg1)
	return self
end
CoD.ReadyEvents.__resetProperties = function(f23_arg0)
	f23_arg0.Description:completeAnimation()
	f23_arg0.Scorestreak:completeAnimation()
	f23_arg0.Description:setAlpha(1)
	f23_arg0.Scorestreak:setAlpha(1)
end
CoD.ReadyEvents.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			f24_arg0.Description:completeAnimation()
			f24_arg0.Description:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.Description)
			f24_arg0.Scorestreak:completeAnimation()
			f24_arg0.Scorestreak:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.Scorestreak)
		end,
		ShowNotification = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(2)
			local f25_local0 = function(f26_arg0)
				local f26_local0 = function(f27_arg0)
					local f27_local0 = function(f28_arg0)
						f28_arg0:beginAnimation(160)
						f28_arg0:setAlpha(0)
						f28_arg0:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
					end
					f27_arg0:beginAnimation(2750)
					f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
				end
				f25_arg0.Description:beginAnimation(250)
				f25_arg0.Description:setAlpha(1)
				f25_arg0.Description:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.Description:registerEventHandler("transition_complete_keyframe", f26_local0)
			end
			f25_arg0.Description:completeAnimation()
			f25_arg0.Description:setAlpha(0)
			f25_local0(f25_arg0.Description)
			local f25_local1 = function(f29_arg0)
				local f29_local0 = function(f30_arg0)
					local f30_local0 = function(f31_arg0)
						f31_arg0:beginAnimation(160)
						f31_arg0:setAlpha(0)
						f31_arg0:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
					end
					f30_arg0:beginAnimation(2750)
					f30_arg0:registerEventHandler("transition_complete_keyframe", f30_local0)
				end
				f25_arg0.Scorestreak:beginAnimation(250)
				f25_arg0.Scorestreak:setAlpha(1)
				f25_arg0.Scorestreak:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.Scorestreak:registerEventHandler("transition_complete_keyframe", f29_local0)
			end
			f25_arg0.Scorestreak:completeAnimation()
			f25_arg0.Scorestreak:setAlpha(0)
			f25_local1(f25_arg0.Scorestreak)
		end,
	},
	Hidden = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(2)
			f32_arg0.Description:completeAnimation()
			f32_arg0.Description:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.Description)
			f32_arg0.Scorestreak:completeAnimation()
			f32_arg0.Scorestreak:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.Scorestreak)
		end,
	},
	HiddenHacked = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(2)
			f33_arg0.Description:completeAnimation()
			f33_arg0.Description:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.Description)
			f33_arg0.Scorestreak:completeAnimation()
			f33_arg0.Scorestreak:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.Scorestreak)
		end,
	},
	CodcasterHidden = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(2)
			f34_arg0.Description:completeAnimation()
			f34_arg0.Description:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.Description)
			f34_arg0.Scorestreak:completeAnimation()
			f34_arg0.Scorestreak:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.Scorestreak)
		end,
	},
}
CoD.ReadyEvents.__onClose = function(f35_arg0)
	f35_arg0.Scorestreak:close()
end
