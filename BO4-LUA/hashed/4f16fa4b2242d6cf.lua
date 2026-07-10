require("x64:3d9aadaa1ad41a6")
require("x64:1227ca3bac54971")
require("x64:19ca44b5fdfaba4")
CoD.WZObituaryCallout = InheritFrom(LUI.UIElement)
CoD.WZObituaryCallout.__defaultWidth = 280
CoD.WZObituaryCallout.__defaultHeight = 40
CoD.WZObituaryCallout.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZObituaryCallout)
	self.id = "WZObituaryCallout"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PlayerName = CoD.WZObituaryCalloutContainer.new(f1_arg0, f1_arg1, 0, 0, 0, 280, 0, 0, 0, 40)
	PlayerName:linkToElementModel(self, nil, false, function(model)
		PlayerName:setModel(model, f1_arg1)
	end)
	self:addElement(PlayerName)
	self.PlayerName = PlayerName
	local ExpandedCallout = CoD.WZObituaryCalloutExpandedContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -400, 400, 0, 0, -18, 62)
	ExpandedCallout:linkToElementModel(self, nil, false, function(model)
		ExpandedCallout:setModel(model, f1_arg1)
	end)
	self:addElement(ExpandedCallout)
	self.ExpandedCallout = ExpandedCallout
	local WZObituarySquadKilled = CoD.WZObituarySquadKilled.new(f1_arg0, f1_arg1, 0.5, 0.5, -251.5, 251.5, 0.5, 0.5, -114, -66)
	WZObituarySquadKilled:linkToElementModel(self, nil, false, function(model)
		WZObituarySquadKilled:setModel(model, f1_arg1)
	end)
	self:addElement(WZObituarySquadKilled)
	self.WZObituarySquadKilled = WZObituarySquadKilled
	self:mergeStateConditions({
		{
			stateName = "HiddenPreference",
			condition = function(menu, element, event)
				return CoD.WZUtility.IsWarzoneUIHidden(f1_arg1, "wzHideKillIdentityUI", "warzoneHideKillIdentity")
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f6_local0
				if
					not CoD.CodCasterUtility.IsCodCasterWithProfileValueEqualTo(f1_arg1, "shoutcaster_ds_calloutcards", 1)
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD0ED50E60CFCFF9])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x534C7B2375D2D47])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD])
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
				then
					f6_local0 = not IsGameTypeCombatTraining()
				else
					f6_local0 = false
				end
				return f6_local0
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6.PlayerSettingsUpdate, function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "PlayerSettingsUpdate",
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = DataSources.CodCaster.getModel(f1_arg1)
	f1_local5(f1_local4, f1_local6.profileSettingsUpdated, function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954]], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40]], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD0ED50E60CFCFF9]], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD0ED50E60CFCFF9],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF]], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x534C7B2375D2D47]], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x534C7B2375D2D47],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5]], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD]], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD],
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]], function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6],
		})
	end, false)
	ExpandedCallout.id = "ExpandedCallout"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local5 = self
	CoD.HUDUtility.InitObituaryCallout(self, f1_arg1)
	return self
end
CoD.WZObituaryCallout.__resetProperties = function(f21_arg0)
	f21_arg0.PlayerName:completeAnimation()
	f21_arg0.ExpandedCallout:completeAnimation()
	f21_arg0.PlayerName:setLeftRight(0, 0, 0, 280)
	f21_arg0.PlayerName:setTopBottom(0, 0, 0, 40)
	f21_arg0.PlayerName:setAlpha(1)
	f21_arg0.ExpandedCallout:setTopBottom(0, 0, -18, 62)
	f21_arg0.ExpandedCallout:setAlpha(1)
end
CoD.WZObituaryCallout.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			f22_arg0.PlayerName:completeAnimation()
			f22_arg0.PlayerName:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.PlayerName)
			f22_arg0.ExpandedCallout:completeAnimation()
			f22_arg0.ExpandedCallout:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.ExpandedCallout)
		end,
	},
	HiddenPreference = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(2)
			f23_arg0.PlayerName:completeAnimation()
			f23_arg0.PlayerName:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.PlayerName)
			f23_arg0.ExpandedCallout:completeAnimation()
			f23_arg0.ExpandedCallout:setAlpha(0)
			f23_arg0.clipFinished(f23_arg0.ExpandedCallout)
		end,
	},
	Visible = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			f24_arg0.PlayerName:completeAnimation()
			f24_arg0.PlayerName:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.PlayerName)
			f24_arg0.ExpandedCallout:completeAnimation()
			f24_arg0.ExpandedCallout:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.ExpandedCallout)
		end,
		Show = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(2)
			local f25_local0 = function(f26_arg0)
				local f26_local0 = function(f27_arg0)
					local f27_local0 = function(f28_arg0)
						local f28_local0 = function(f29_arg0)
							local f29_local0 = function(f30_arg0)
								local f30_local0 = function(f31_arg0)
									local f31_local0 = function(f32_arg0)
										local f32_local0 = function(f33_arg0)
											local f33_local0 = function(f34_arg0)
												local f34_local0 = function(f35_arg0)
													local f35_local0 = function(f36_arg0)
														local f36_local0 = function(f37_arg0)
															f37_arg0:beginAnimation(200)
															f37_arg0:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
														end
														f36_arg0:beginAnimation(29, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
														f36_arg0:setAlpha(0)
														f36_arg0:registerEventHandler("transition_complete_keyframe", f36_local0)
													end
													f35_arg0:beginAnimation(29)
													f35_arg0:setAlpha(0.8)
													f35_arg0:registerEventHandler("transition_complete_keyframe", f35_local0)
												end
												f34_arg0:beginAnimation(30)
												f34_arg0:setAlpha(0.2)
												f34_arg0:registerEventHandler("transition_complete_keyframe", f34_local0)
											end
											f33_arg0:beginAnimation(49)
											f33_arg0:setAlpha(1)
											f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
										end
										f32_arg0:beginAnimation(60)
										f32_arg0:setAlpha(0.2)
										f32_arg0:registerEventHandler("transition_complete_keyframe", f32_local0)
									end
									f31_arg0:beginAnimation(1579)
									f31_arg0:registerEventHandler("transition_complete_keyframe", f31_local0)
								end
								f30_arg0:beginAnimation(19, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
								f30_arg0:setTopBottom(0, 0, 0, 40)
								f30_arg0:setAlpha(1)
								f30_arg0:registerEventHandler("transition_complete_keyframe", f30_local0)
							end
							f29_arg0:beginAnimation(19)
							f29_arg0:setTopBottom(0, 0, -2, 38)
							f29_arg0:setAlpha(0.98)
							f29_arg0:registerEventHandler("transition_complete_keyframe", f29_local0)
						end
						f28_arg0:beginAnimation(20)
						f28_arg0:setTopBottom(0, 0, 0, 40)
						f28_arg0:setAlpha(0.92)
						f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
					end
					f27_arg0:beginAnimation(30)
					f27_arg0:setTopBottom(0, 0, -5, 35)
					f27_arg0:setAlpha(0.83)
					f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
				end
				f25_arg0.PlayerName:beginAnimation(130)
				f25_arg0.PlayerName:setTopBottom(0, 0, 0, 40)
				f25_arg0.PlayerName:setAlpha(0.64)
				f25_arg0.PlayerName:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.PlayerName:registerEventHandler("transition_complete_keyframe", f26_local0)
			end
			f25_arg0.PlayerName:completeAnimation()
			f25_arg0.PlayerName:setLeftRight(0, 0, 0, 280)
			f25_arg0.PlayerName:setTopBottom(0, 0, -88, -48)
			f25_arg0.PlayerName:setAlpha(0)
			f25_local0(f25_arg0.PlayerName)
			local f25_local1 = function(f38_arg0)
				local f38_local0 = function(f39_arg0)
					local f39_local0 = function(f40_arg0)
						local f40_local0 = function(f41_arg0)
							local f41_local0 = function(f42_arg0)
								local f42_local0 = function(f43_arg0)
									local f43_local0 = function(f44_arg0)
										local f44_local0 = function(f45_arg0)
											f45_arg0:beginAnimation(200)
											f45_arg0:registerEventHandler("transition_complete_keyframe", function(element, event)
												element:playClip("DefaultClip")
												f25_arg0.clipFinished(element, event)
											end)
										end
										f44_arg0:beginAnimation(29)
										f44_arg0:setAlpha(0)
										f44_arg0:registerEventHandler("transition_complete_keyframe", f44_local0)
									end
									f43_arg0:beginAnimation(29)
									f43_arg0:setAlpha(0.8)
									f43_arg0:registerEventHandler("transition_complete_keyframe", f43_local0)
								end
								f42_arg0:beginAnimation(30)
								f42_arg0:setAlpha(0.2)
								f42_arg0:registerEventHandler("transition_complete_keyframe", f42_local0)
							end
							f41_arg0:beginAnimation(49)
							f41_arg0:setAlpha(1)
							f41_arg0:registerEventHandler("transition_complete_keyframe", f41_local0)
						end
						f40_arg0:beginAnimation(60)
						f40_arg0:setAlpha(0.2)
						f40_arg0:registerEventHandler("transition_complete_keyframe", f40_local0)
					end
					f39_arg0:beginAnimation(1579)
					f39_arg0:registerEventHandler("transition_complete_keyframe", f39_local0)
				end
				f25_arg0.ExpandedCallout:playClip("DefaultClip")
				f25_arg0.ExpandedCallout:beginAnimation(220)
				f25_arg0.ExpandedCallout:setTopBottom(0, 0, -18, 62)
				f25_arg0.ExpandedCallout:setAlpha(1)
				f25_arg0.ExpandedCallout:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.ExpandedCallout:registerEventHandler("transition_complete_keyframe", f38_local0)
			end
			f25_arg0.ExpandedCallout:completeAnimation()
			f25_arg0.ExpandedCallout:setTopBottom(0, 0, -134, -54)
			f25_arg0.ExpandedCallout:setAlpha(0)
			f25_local1(f25_arg0.ExpandedCallout)
		end,
	},
}
CoD.WZObituaryCallout.__onClose = function(f47_arg0)
	f47_arg0.PlayerName:close()
	f47_arg0.ExpandedCallout:close()
	f47_arg0.WZObituarySquadKilled:close()
end
