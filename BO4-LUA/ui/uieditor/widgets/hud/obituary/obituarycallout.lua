require("x64:4e9bd79df2dd918")
require("x64:c406e1f7d7b070f")
CoD.ObituaryCallout = InheritFrom(LUI.UIElement)
CoD.ObituaryCallout.__defaultWidth = 280
CoD.ObituaryCallout.__defaultHeight = 40
CoD.ObituaryCallout.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ObituaryCallout)
	self.id = "ObituaryCallout"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PlayerName = CoD.ObituaryCalloutContainer.new(f1_arg0, f1_arg1, 0, 0, 0, 280, 0, 0, 0, 30)
	PlayerName:setAlpha(0)
	PlayerName:linkToElementModel(self, nil, false, function(model)
		PlayerName:setModel(model, f1_arg1)
	end)
	self:addElement(PlayerName)
	self.PlayerName = PlayerName
	local ExpandedCallout = CoD.ObituaryCalloutExpandedContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -400, 400, 0.5, 0.5, -40, 40)
	ExpandedCallout:linkToElementModel(self, nil, false, function(model)
		ExpandedCallout:setModel(model, f1_arg1)
	end)
	self:addElement(ExpandedCallout)
	self.ExpandedCallout = ExpandedCallout
	self:mergeStateConditions({
		{
			stateName = "Hacked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueGreaterThan(f1_arg1, "hudItems.hacked", 0)
			end,
		},
		{
			stateName = "EMP",
			condition = function(menu, element, event)
				return IsVisibilityBitSet(f1_arg1, Enum[0x7F032C2EF103A1A][0x59333FC97F7870])
			end,
		},
		{
			stateName = "ThirdPersonVisible",
			condition = function(menu, element, event)
				local f6_local0
				if
					not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954])
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
					and not IsGameTypeCombatTraining()
				then
					f6_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x79E684E90DF4625])
				else
					f6_local0 = false
				end
				return f6_local0
			end,
		},
		{
			stateName = "CodCasterVisible",
			condition = function(menu, element, event)
				local f7_local0
				if
					not CoD.CodCasterUtility.IsCodCasterWithProfileValueEqualTo(f1_arg1, "shoutcaster_ds_notification_kills", 0)
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
					and not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
				then
					f7_local0 = not IsGameTypeCombatTraining()
				else
					f7_local0 = false
				end
				return f7_local0
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f8_local0
				if
					not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954])
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
					f8_local0 = not IsGameTypeCombatTraining()
				else
					f8_local0 = false
				end
				return f8_local0
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["hudItems.hacked"], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "hudItems.hacked",
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870]], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954]], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40]], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD0ED50E60CFCFF9]], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD0ED50E60CFCFF9],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF]], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x534C7B2375D2D47]], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x534C7B2375D2D47],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5]], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD]], function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6FFF566DCC09BBD],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]], function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x79E684E90DF4625]], function(f23_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x79E684E90DF4625],
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = DataSources.CodCaster.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5.profileSettingsUpdated, function(f24_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "profileSettingsUpdated",
		})
	end, false)
	ExpandedCallout.id = "ExpandedCallout"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local4 = self
	CoD.HUDUtility.InitObituaryCallout(self, f1_arg1)
	return self
end
CoD.ObituaryCallout.__resetProperties = function(f25_arg0)
	f25_arg0.PlayerName:completeAnimation()
	f25_arg0.ExpandedCallout:completeAnimation()
	f25_arg0.PlayerName:setLeftRight(0, 0, 0, 280)
	f25_arg0.PlayerName:setTopBottom(0, 0, 0, 30)
	f25_arg0.PlayerName:setAlpha(0)
	f25_arg0.PlayerName:setScale(1, 1)
	f25_arg0.ExpandedCallout:setLeftRight(0.5, 0.5, -400, 400)
	f25_arg0.ExpandedCallout:setTopBottom(0.5, 0.5, -40, 40)
	f25_arg0.ExpandedCallout:setAlpha(1)
	f25_arg0.ExpandedCallout:setScale(1, 1)
end
CoD.ObituaryCallout.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(2)
			f26_arg0.PlayerName:completeAnimation()
			f26_arg0.PlayerName:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.PlayerName)
			f26_arg0.ExpandedCallout:completeAnimation()
			f26_arg0.ExpandedCallout:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.ExpandedCallout)
		end,
	},
	Hacked = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(2)
			f27_arg0.PlayerName:completeAnimation()
			f27_arg0.PlayerName:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.PlayerName)
			f27_arg0.ExpandedCallout:completeAnimation()
			f27_arg0.ExpandedCallout:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.ExpandedCallout)
		end,
	},
	EMP = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(2)
			f28_arg0.PlayerName:completeAnimation()
			f28_arg0.PlayerName:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.PlayerName)
			f28_arg0.ExpandedCallout:completeAnimation()
			f28_arg0.ExpandedCallout:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.ExpandedCallout)
		end,
	},
	ThirdPersonVisible = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(2)
			f29_arg0.PlayerName:completeAnimation()
			f29_arg0.PlayerName:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.PlayerName)
			f29_arg0.ExpandedCallout:completeAnimation()
			f29_arg0.ExpandedCallout:setAlpha(0)
			f29_arg0.clipFinished(f29_arg0.ExpandedCallout)
		end,
		Show = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(2)
			local f30_local0 = function(f31_arg0)
				f30_arg0.PlayerName:beginAnimation(2200)
				f30_arg0.PlayerName:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.PlayerName:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
			end
			f30_arg0.PlayerName:completeAnimation()
			f30_arg0.PlayerName:setLeftRight(0, 0, 0, 280)
			f30_arg0.PlayerName:setTopBottom(0, 0, -88, -48)
			f30_arg0.PlayerName:setAlpha(0)
			f30_arg0.PlayerName:setScale(0.7, 0.7)
			f30_local0(f30_arg0.PlayerName)
			local f30_local1 = function(f32_arg0)
				local f32_local0 = function(f33_arg0)
					local f33_local0 = function(f34_arg0)
						local f34_local0 = function(f35_arg0)
							local f35_local0 = function(f36_arg0)
								local f36_local0 = function(f37_arg0)
									local f37_local0 = function(f38_arg0)
										local f38_local0 = function(f39_arg0)
											local f39_local0 = function(f40_arg0)
												local f40_local0 = function(f41_arg0)
													local f41_local0 = function(f42_arg0)
														local f42_local0 = function(f43_arg0)
															f43_arg0:beginAnimation(200)
															f43_arg0:registerEventHandler("transition_complete_keyframe", f30_arg0.clipFinished)
														end
														f42_arg0:beginAnimation(29)
														f42_arg0:setAlpha(0)
														f42_arg0:registerEventHandler("transition_complete_keyframe", f42_local0)
													end
													f41_arg0:beginAnimation(29)
													f41_arg0:setAlpha(0.8)
													f41_arg0:registerEventHandler("transition_complete_keyframe", f41_local0)
												end
												f40_arg0:beginAnimation(30)
												f40_arg0:setAlpha(0.2)
												f40_arg0:registerEventHandler("transition_complete_keyframe", f40_local0)
											end
											f39_arg0:beginAnimation(49)
											f39_arg0:setAlpha(1)
											f39_arg0:registerEventHandler("transition_complete_keyframe", f39_local0)
										end
										f38_arg0:beginAnimation(60)
										f38_arg0:setAlpha(0.2)
										f38_arg0:registerEventHandler("transition_complete_keyframe", f38_local0)
									end
									f37_arg0:beginAnimation(1579)
									f37_arg0:registerEventHandler("transition_complete_keyframe", f37_local0)
								end
								f36_arg0:beginAnimation(19)
								f36_arg0:setTopBottom(0, 0, 0, 40)
								f36_arg0:setAlpha(1)
								f36_arg0:registerEventHandler("transition_complete_keyframe", f36_local0)
							end
							f35_arg0:beginAnimation(19)
							f35_arg0:setTopBottom(0, 0, -2, 38)
							f35_arg0:setAlpha(0.91)
							f35_arg0:registerEventHandler("transition_complete_keyframe", f35_local0)
						end
						f34_arg0:beginAnimation(20)
						f34_arg0:setTopBottom(0, 0, 0, 40)
						f34_arg0:setAlpha(0.82)
						f34_arg0:registerEventHandler("transition_complete_keyframe", f34_local0)
					end
					f33_arg0:beginAnimation(30)
					f33_arg0:setTopBottom(0, 0, -5, 35)
					f33_arg0:setAlpha(0.73)
					f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
				end
				f30_arg0.ExpandedCallout:beginAnimation(130)
				f30_arg0.ExpandedCallout:setTopBottom(0, 0, 0, 40)
				f30_arg0.ExpandedCallout:setAlpha(0.59)
				f30_arg0.ExpandedCallout:registerEventHandler("interrupted_keyframe", f30_arg0.clipInterrupted)
				f30_arg0.ExpandedCallout:registerEventHandler("transition_complete_keyframe", f32_local0)
			end
			f30_arg0.ExpandedCallout:completeAnimation()
			f30_arg0.ExpandedCallout:setLeftRight(0, 0, 0, 280)
			f30_arg0.ExpandedCallout:setTopBottom(0, 0, -88, -48)
			f30_arg0.ExpandedCallout:setAlpha(0)
			f30_arg0.ExpandedCallout:setScale(0.7, 0.7)
			f30_local1(f30_arg0.ExpandedCallout)
		end,
	},
	CodCasterVisible = {
		DefaultClip = function(f44_arg0, f44_arg1)
			f44_arg0:__resetProperties()
			f44_arg0:setupElementClipCounter(2)
			f44_arg0.PlayerName:completeAnimation()
			f44_arg0.PlayerName:setAlpha(0)
			f44_arg0.clipFinished(f44_arg0.PlayerName)
			f44_arg0.ExpandedCallout:completeAnimation()
			f44_arg0.ExpandedCallout:setAlpha(0)
			f44_arg0.clipFinished(f44_arg0.ExpandedCallout)
		end,
		Show = function(f45_arg0, f45_arg1)
			f45_arg0:__resetProperties()
			f45_arg0:setupElementClipCounter(2)
			f45_arg0.PlayerName:completeAnimation()
			f45_arg0.PlayerName:setLeftRight(0, 0, 0, 280)
			f45_arg0.PlayerName:setTopBottom(0, 0, -88, -48)
			f45_arg0.PlayerName:setAlpha(0)
			f45_arg0.clipFinished(f45_arg0.PlayerName)
			local f45_local0 = function(f46_arg0)
				local f46_local0 = function(f47_arg0)
					local f47_local0 = function(f48_arg0)
						local f48_local0 = function(f49_arg0)
							local f49_local0 = function(f50_arg0)
								local f50_local0 = function(f51_arg0)
									local f51_local0 = function(f52_arg0)
										local f52_local0 = function(f53_arg0)
											local f53_local0 = function(f54_arg0)
												local f54_local0 = function(f55_arg0)
													local f55_local0 = function(f56_arg0)
														local f56_local0 = function(f57_arg0)
															f57_arg0:beginAnimation(200)
															f57_arg0:registerEventHandler("transition_complete_keyframe", f45_arg0.clipFinished)
														end
														f56_arg0:beginAnimation(29)
														f56_arg0:setAlpha(0)
														f56_arg0:registerEventHandler("transition_complete_keyframe", f56_local0)
													end
													f55_arg0:beginAnimation(29)
													f55_arg0:setAlpha(0.8)
													f55_arg0:registerEventHandler("transition_complete_keyframe", f55_local0)
												end
												f54_arg0:beginAnimation(30)
												f54_arg0:setAlpha(0.2)
												f54_arg0:registerEventHandler("transition_complete_keyframe", f54_local0)
											end
											f53_arg0:beginAnimation(49)
											f53_arg0:setAlpha(1)
											f53_arg0:registerEventHandler("transition_complete_keyframe", f53_local0)
										end
										f52_arg0:beginAnimation(60)
										f52_arg0:setAlpha(0.2)
										f52_arg0:registerEventHandler("transition_complete_keyframe", f52_local0)
									end
									f51_arg0:beginAnimation(1579)
									f51_arg0:registerEventHandler("transition_complete_keyframe", f51_local0)
								end
								f50_arg0:beginAnimation(19)
								f50_arg0:setTopBottom(0, 0, 0, 40)
								f50_arg0:setAlpha(1)
								f50_arg0:registerEventHandler("transition_complete_keyframe", f50_local0)
							end
							f49_arg0:beginAnimation(19)
							f49_arg0:setTopBottom(0, 0, -2, 38)
							f49_arg0:setAlpha(0.91)
							f49_arg0:registerEventHandler("transition_complete_keyframe", f49_local0)
						end
						f48_arg0:beginAnimation(20)
						f48_arg0:setTopBottom(0, 0, 0, 40)
						f48_arg0:setAlpha(0.82)
						f48_arg0:registerEventHandler("transition_complete_keyframe", f48_local0)
					end
					f47_arg0:beginAnimation(30)
					f47_arg0:setTopBottom(0, 0, -5, 35)
					f47_arg0:setAlpha(0.73)
					f47_arg0:registerEventHandler("transition_complete_keyframe", f47_local0)
				end
				f45_arg0.ExpandedCallout:beginAnimation(130)
				f45_arg0.ExpandedCallout:setTopBottom(0, 0, 0, 40)
				f45_arg0.ExpandedCallout:setAlpha(0.59)
				f45_arg0.ExpandedCallout:registerEventHandler("interrupted_keyframe", f45_arg0.clipInterrupted)
				f45_arg0.ExpandedCallout:registerEventHandler("transition_complete_keyframe", f46_local0)
			end
			f45_arg0.ExpandedCallout:completeAnimation()
			f45_arg0.ExpandedCallout:setLeftRight(0, 0, 0, 280)
			f45_arg0.ExpandedCallout:setTopBottom(0, 0, -88, -48)
			f45_arg0.ExpandedCallout:setAlpha(0)
			f45_local0(f45_arg0.ExpandedCallout)
		end,
	},
	Visible = {
		DefaultClip = function(f58_arg0, f58_arg1)
			f58_arg0:__resetProperties()
			f58_arg0:setupElementClipCounter(2)
			f58_arg0.PlayerName:completeAnimation()
			f58_arg0.PlayerName:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.PlayerName)
			f58_arg0.ExpandedCallout:completeAnimation()
			f58_arg0.ExpandedCallout:setAlpha(0)
			f58_arg0.clipFinished(f58_arg0.ExpandedCallout)
		end,
		Show = function(f59_arg0, f59_arg1)
			f59_arg0:__resetProperties()
			f59_arg0:setupElementClipCounter(2)
			f59_arg0.PlayerName:completeAnimation()
			f59_arg0.PlayerName:setLeftRight(0, 0, 0, 280)
			f59_arg0.PlayerName:setTopBottom(0, 0, -88, -48)
			f59_arg0.PlayerName:setAlpha(0)
			f59_arg0.clipFinished(f59_arg0.PlayerName)
			local f59_local0 = function(f60_arg0)
				local f60_local0 = function(f61_arg0)
					local f61_local0 = function(f62_arg0)
						local f62_local0 = function(f63_arg0)
							local f63_local0 = function(f64_arg0)
								local f64_local0 = function(f65_arg0)
									local f65_local0 = function(f66_arg0)
										local f66_local0 = function(f67_arg0)
											local f67_local0 = function(f68_arg0)
												local f68_local0 = function(f69_arg0)
													local f69_local0 = function(f70_arg0)
														local f70_local0 = function(f71_arg0)
															f71_arg0:beginAnimation(200)
															f71_arg0:registerEventHandler("transition_complete_keyframe", f59_arg0.clipFinished)
														end
														f70_arg0:beginAnimation(29)
														f70_arg0:setAlpha(0)
														f70_arg0:registerEventHandler("transition_complete_keyframe", f70_local0)
													end
													f69_arg0:beginAnimation(29)
													f69_arg0:setAlpha(0.8)
													f69_arg0:registerEventHandler("transition_complete_keyframe", f69_local0)
												end
												f68_arg0:beginAnimation(30)
												f68_arg0:setAlpha(0.2)
												f68_arg0:registerEventHandler("transition_complete_keyframe", f68_local0)
											end
											f67_arg0:beginAnimation(49)
											f67_arg0:setAlpha(1)
											f67_arg0:registerEventHandler("transition_complete_keyframe", f67_local0)
										end
										f66_arg0:beginAnimation(60)
										f66_arg0:setAlpha(0.2)
										f66_arg0:registerEventHandler("transition_complete_keyframe", f66_local0)
									end
									f65_arg0:beginAnimation(1579)
									f65_arg0:registerEventHandler("transition_complete_keyframe", f65_local0)
								end
								f64_arg0:beginAnimation(19)
								f64_arg0:setTopBottom(0, 0, 0, 40)
								f64_arg0:setAlpha(1)
								f64_arg0:registerEventHandler("transition_complete_keyframe", f64_local0)
							end
							f63_arg0:beginAnimation(19)
							f63_arg0:setTopBottom(0, 0, -2, 38)
							f63_arg0:setAlpha(0.91)
							f63_arg0:registerEventHandler("transition_complete_keyframe", f63_local0)
						end
						f62_arg0:beginAnimation(20)
						f62_arg0:setTopBottom(0, 0, 0, 40)
						f62_arg0:setAlpha(0.82)
						f62_arg0:registerEventHandler("transition_complete_keyframe", f62_local0)
					end
					f61_arg0:beginAnimation(30)
					f61_arg0:setTopBottom(0, 0, -5, 35)
					f61_arg0:setAlpha(0.73)
					f61_arg0:registerEventHandler("transition_complete_keyframe", f61_local0)
				end
				f59_arg0.ExpandedCallout:beginAnimation(130)
				f59_arg0.ExpandedCallout:setTopBottom(0, 0, 0, 40)
				f59_arg0.ExpandedCallout:setAlpha(0.59)
				f59_arg0.ExpandedCallout:registerEventHandler("interrupted_keyframe", f59_arg0.clipInterrupted)
				f59_arg0.ExpandedCallout:registerEventHandler("transition_complete_keyframe", f60_local0)
			end
			f59_arg0.ExpandedCallout:completeAnimation()
			f59_arg0.ExpandedCallout:setLeftRight(0, 0, 0, 280)
			f59_arg0.ExpandedCallout:setTopBottom(0, 0, -88, -48)
			f59_arg0.ExpandedCallout:setAlpha(0)
			f59_local0(f59_arg0.ExpandedCallout)
		end,
	},
}
CoD.ObituaryCallout.__onClose = function(f72_arg0)
	f72_arg0.PlayerName:close()
	f72_arg0.ExpandedCallout:close()
end
