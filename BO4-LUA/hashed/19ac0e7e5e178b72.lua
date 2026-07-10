require("x64:ef643b0f71e0bc5")
CoD.Hud_ZM_Trial_Strikes = InheritFrom(LUI.UIElement)
CoD.Hud_ZM_Trial_Strikes.__defaultWidth = 224
CoD.Hud_ZM_Trial_Strikes.__defaultHeight = 80
CoD.Hud_ZM_Trial_Strikes.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Hud_ZM_Trial_Strikes)
	self.id = "Hud_ZM_Trial_Strikes"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Strike1 = LUI.UIImage.new(0, 0, 2, 82, 0, 0, 0, 80)
	Strike1:setImage(RegisterImage(0x3A6C1FB3B354832))
	self:addElement(Strike1)
	self.Strike1 = Strike1
	local Strike2 = LUI.UIImage.new(0, 0, 72, 152, 0, 0, 0, 80)
	Strike2:setImage(RegisterImage(0x3A6C1FB3B354832))
	self:addElement(Strike2)
	self.Strike2 = Strike2
	local Strike3 = LUI.UIImage.new(0, 0, 142, 222, 0, 0, 0, 80)
	Strike3:setImage(RegisterImage(0x3A6C1FB3B354832))
	self:addElement(Strike3)
	self.Strike3 = Strike3
	local cross2 = LUI.UIImage.new(0, 0, 72, 152, 0, 0, 2.5, 82.5)
	cross2:setAlpha(0)
	cross2:setImage(RegisterImage(0xE4DE8D9B8388B9F))
	self:addElement(cross2)
	self.cross2 = cross2
	local cross1 = LUI.UIImage.new(0, 0, 2, 82, 0, 0, 3.5, 83.5)
	cross1:setAlpha(0)
	cross1:setImage(RegisterImage(0xE4DE8D9B8388B9F))
	self:addElement(cross1)
	self.cross1 = cross1
	local cross3 = LUI.UIImage.new(0, 0, 142, 222, 0, 0, 2.5, 82.5)
	cross3:setAlpha(0)
	cross3:setImage(RegisterImage(0xE4DE8D9B8388B9F))
	self:addElement(cross3)
	self.cross3 = cross3
	local StrikeBackground = LUI.UIImage.new(0, 0, -20, 244, 0, 0, 56, 88)
	StrikeBackground:setImage(RegisterImage(0x5934421691476D2))
	self:addElement(StrikeBackground)
	self.StrikeBackground = StrikeBackground
	local ZmFxSpark2Ext = CoD.ZmFx_Spark2Ext.new(f1_arg0, f1_arg1, 0, 0, 35.5, 108.5, 0, 0, -85.5, 24.5)
	ZmFxSpark2Ext:setAlpha(0)
	self:addElement(ZmFxSpark2Ext)
	self.ZmFxSpark2Ext = ZmFxSpark2Ext
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.HUDUtility.IsAnyGameType(f1_arg1, "ztrials")
			end,
		},
		{
			stateName = "HiddenRoundFail",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.gameState", 0)
			end,
		},
		{
			stateName = "HiddenCopy",
			condition = function(menu, element, event)
				local f4_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954])
				if not f4_local0 then
					f4_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40])
					if not f4_local0 then
						f4_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x59333FC97F7870])
						if not f4_local0 then
							f4_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF])
							if not f4_local0 then
								f4_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC])
								if not f4_local0 then
									f4_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769])
									if not f4_local0 then
										if Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]) then
											f4_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8])
											if not f4_local0 then
												f4_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
												if not f4_local0 then
													f4_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7])
													if not f4_local0 then
														f4_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E])
														if not f4_local0 then
															f4_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x6668F0686232679])
															if not f4_local0 then
																f4_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E])
																if not f4_local0 then
																	f4_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2])
																	if not f4_local0 then
																		f4_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F])
																		if not f4_local0 then
																			f4_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5])
																			if not f4_local0 then
																				f4_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
																				if not f4_local0 then
																					f4_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
																					if not f4_local0 then
																						f4_local0 = not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xBB045E46E88E762])
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
											end
										else
											f4_local0 = true
										end
									end
								end
							end
						end
					end
				end
				return f4_local0
			end,
		},
		{
			stateName = "Show",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.strikes", 0) and AlwaysFalse()
			end,
		},
		{
			stateName = "Strikes1",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.strikes", 1)
			end,
		},
		{
			stateName = "Strikes2",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.strikes", 2)
			end,
		},
		{
			stateName = "Strikes3",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("ZMHudGlobal.trials.strikes", 3)
			end,
		},
	})
	local f1_local9 = self
	local f1_local10 = self.subscribeToModel
	local f1_local11 = Engine[0x8DF2E5447F384B9]()
	f1_local10(f1_local9, f1_local11["ZMHudGlobal.trials.gameState"], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "ZMHudGlobal.trials.gameState",
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954]], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954],
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40]], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40],
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870]], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870],
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF]], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF],
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769]], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769],
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8]], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8],
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7]], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7],
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E]], function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E],
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679]], function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679],
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E]], function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E],
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2]], function(f23_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2],
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f24_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5]], function(f25_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f25_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5],
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f26_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f26_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]], function(f27_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f27_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6],
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local10(f1_local9, f1_local11["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762]], function(f28_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f28_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762],
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[0x8DF2E5447F384B9]()
	f1_local10(f1_local9, f1_local11["ZMHudGlobal.trials.strikes"], function(f29_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f29_arg0:get(),
			modelName = "ZMHudGlobal.trials.strikes",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Hud_ZM_Trial_Strikes.__resetProperties = function(f30_arg0)
	f30_arg0.Strike2:completeAnimation()
	f30_arg0.Strike3:completeAnimation()
	f30_arg0.Strike1:completeAnimation()
	f30_arg0.StrikeBackground:completeAnimation()
	f30_arg0.cross2:completeAnimation()
	f30_arg0.cross3:completeAnimation()
	f30_arg0.cross1:completeAnimation()
	f30_arg0.ZmFxSpark2Ext:completeAnimation()
	f30_arg0.Strike2:setLeftRight(0, 0, 72, 152)
	f30_arg0.Strike2:setTopBottom(0, 0, 0, 80)
	f30_arg0.Strike2:setRGB(1, 1, 1)
	f30_arg0.Strike2:setAlpha(1)
	f30_arg0.Strike2:setImage(RegisterImage(0x3A6C1FB3B354832))
	f30_arg0.Strike3:setLeftRight(0, 0, 142, 222)
	f30_arg0.Strike3:setTopBottom(0, 0, 0, 80)
	f30_arg0.Strike3:setRGB(1, 1, 1)
	f30_arg0.Strike3:setAlpha(1)
	f30_arg0.Strike1:setLeftRight(0, 0, 2, 82)
	f30_arg0.Strike1:setTopBottom(0, 0, 0, 80)
	f30_arg0.Strike1:setRGB(1, 1, 1)
	f30_arg0.Strike1:setAlpha(1)
	f30_arg0.Strike1:setImage(RegisterImage(0x3A6C1FB3B354832))
	f30_arg0.StrikeBackground:setAlpha(1)
	f30_arg0.cross2:setLeftRight(0, 0, 72, 152)
	f30_arg0.cross2:setTopBottom(0, 0, 2.5, 82.5)
	f30_arg0.cross2:setAlpha(0)
	f30_arg0.cross3:setLeftRight(0, 0, 142, 222)
	f30_arg0.cross3:setTopBottom(0, 0, 2.5, 82.5)
	f30_arg0.cross3:setAlpha(0)
	f30_arg0.cross1:setLeftRight(0, 0, 2, 82)
	f30_arg0.cross1:setTopBottom(0, 0, 3.5, 83.5)
	f30_arg0.cross1:setAlpha(0)
	f30_arg0.ZmFxSpark2Ext:setLeftRight(0, 0, 35.5, 108.5)
	f30_arg0.ZmFxSpark2Ext:setTopBottom(0, 0, -85.5, 24.5)
	f30_arg0.ZmFxSpark2Ext:setAlpha(0)
end
CoD.Hud_ZM_Trial_Strikes.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(4)
			f31_arg0.Strike1:completeAnimation()
			f31_arg0.Strike1:setLeftRight(0, 0, 2, 82)
			f31_arg0.Strike1:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.Strike1)
			f31_arg0.Strike2:completeAnimation()
			f31_arg0.Strike2:setLeftRight(0, 0, 72, 152)
			f31_arg0.Strike2:setTopBottom(0, 0, 0, 80)
			f31_arg0.Strike2:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.Strike2)
			f31_arg0.Strike3:completeAnimation()
			f31_arg0.Strike3:setLeftRight(0, 0, 142, 222)
			f31_arg0.Strike3:setTopBottom(0, 0, 0, 80)
			f31_arg0.Strike3:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.Strike3)
			f31_arg0.StrikeBackground:completeAnimation()
			f31_arg0.StrikeBackground:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.StrikeBackground)
		end,
	},
	Hidden = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(6)
			f32_arg0.Strike1:completeAnimation()
			f32_arg0.Strike1:setLeftRight(0, 0, 3, 83)
			f32_arg0.Strike1:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.Strike1)
			f32_arg0.Strike2:completeAnimation()
			f32_arg0.Strike2:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.Strike2)
			f32_arg0.Strike3:completeAnimation()
			f32_arg0.Strike3:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.Strike3)
			f32_arg0.cross2:completeAnimation()
			f32_arg0.cross2:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.cross2)
			f32_arg0.cross3:completeAnimation()
			f32_arg0.cross3:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.cross3)
			f32_arg0.StrikeBackground:completeAnimation()
			f32_arg0.StrikeBackground:setAlpha(0)
			f32_arg0.clipFinished(f32_arg0.StrikeBackground)
		end,
	},
	HiddenRoundFail = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(6)
			f33_arg0.Strike1:completeAnimation()
			f33_arg0.Strike1:setLeftRight(0, 0, 3, 83)
			f33_arg0.Strike1:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.Strike1)
			f33_arg0.Strike2:completeAnimation()
			f33_arg0.Strike2:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.Strike2)
			f33_arg0.Strike3:completeAnimation()
			f33_arg0.Strike3:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.Strike3)
			f33_arg0.cross2:completeAnimation()
			f33_arg0.cross2:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.cross2)
			f33_arg0.cross3:completeAnimation()
			f33_arg0.cross3:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.cross3)
			f33_arg0.StrikeBackground:completeAnimation()
			f33_arg0.StrikeBackground:setAlpha(0)
			f33_arg0.clipFinished(f33_arg0.StrikeBackground)
		end,
	},
	HiddenCopy = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(6)
			f34_arg0.Strike1:completeAnimation()
			f34_arg0.Strike1:setLeftRight(0, 0, 3, 83)
			f34_arg0.Strike1:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.Strike1)
			f34_arg0.Strike2:completeAnimation()
			f34_arg0.Strike2:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.Strike2)
			f34_arg0.Strike3:completeAnimation()
			f34_arg0.Strike3:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.Strike3)
			f34_arg0.cross2:completeAnimation()
			f34_arg0.cross2:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.cross2)
			f34_arg0.cross3:completeAnimation()
			f34_arg0.cross3:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.cross3)
			f34_arg0.StrikeBackground:completeAnimation()
			f34_arg0.StrikeBackground:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.StrikeBackground)
		end,
	},
	Show = {
		DefaultClip = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(3)
			f35_arg0.Strike1:completeAnimation()
			f35_arg0.Strike1:setLeftRight(0, 0, 2, 82)
			f35_arg0.clipFinished(f35_arg0.Strike1)
			f35_arg0.Strike2:completeAnimation()
			f35_arg0.Strike2:setLeftRight(0, 0, 72, 152)
			f35_arg0.Strike2:setTopBottom(0, 0, 0, 80)
			f35_arg0.clipFinished(f35_arg0.Strike2)
			f35_arg0.Strike3:completeAnimation()
			f35_arg0.Strike3:setLeftRight(0, 0, 142, 222)
			f35_arg0.Strike3:setTopBottom(0, 0, 0, 80)
			f35_arg0.clipFinished(f35_arg0.Strike3)
		end,
		Strikes1 = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(5)
			f36_arg0.Strike1:completeAnimation()
			f36_arg0.Strike1:setLeftRight(0, 0, 2, 82)
			f36_arg0.Strike1:setTopBottom(0, 0, 0, 80)
			f36_arg0.Strike1:setRGB(1, 1, 1)
			f36_arg0.Strike1:setImage(RegisterImage(0x3A6C1FB3B354832))
			f36_arg0.clipFinished(f36_arg0.Strike1)
			f36_arg0.Strike2:completeAnimation()
			f36_arg0.Strike2:setRGB(1, 1, 1)
			f36_arg0.clipFinished(f36_arg0.Strike2)
			f36_arg0.Strike3:completeAnimation()
			f36_arg0.Strike3:setLeftRight(0, 0, 142, 222)
			f36_arg0.Strike3:setTopBottom(0, 0, 0, 80)
			f36_arg0.clipFinished(f36_arg0.Strike3)
			local f36_local0 = function(f37_arg0)
				f36_arg0.cross1:beginAnimation(2000)
				f36_arg0.cross1:setAlpha(1)
				f36_arg0.cross1:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.cross1:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
			end
			f36_arg0.cross1:completeAnimation()
			f36_arg0.cross1:setTopBottom(0, 0, 3.5, 83.5)
			f36_arg0.cross1:setAlpha(0)
			f36_local0(f36_arg0.cross1)
			local f36_local1 = function(f38_arg0)
				local f38_local0 = function(f39_arg0)
					local f39_local0 = function(f40_arg0)
						f40_arg0:beginAnimation(269)
						f40_arg0:setAlpha(0)
						f40_arg0:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
					end
					f39_arg0:beginAnimation(790)
					f39_arg0:setLeftRight(0, 0, 9, 82)
					f39_arg0:setTopBottom(0, 0, -38, 72)
					f39_arg0:setAlpha(0.2)
					f39_arg0:registerEventHandler("transition_complete_keyframe", f39_local0)
				end
				f36_arg0.ZmFxSpark2Ext:beginAnimation(210)
				f36_arg0.ZmFxSpark2Ext:setLeftRight(0, 0, 20.46, 93.46)
				f36_arg0.ZmFxSpark2Ext:setTopBottom(0, 0, -70, 40)
				f36_arg0.ZmFxSpark2Ext:setAlpha(0.8)
				f36_arg0.ZmFxSpark2Ext:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.ZmFxSpark2Ext:registerEventHandler("transition_complete_keyframe", f38_local0)
			end
			f36_arg0.ZmFxSpark2Ext:completeAnimation()
			f36_arg0.ZmFxSpark2Ext:setLeftRight(0, 0, 23.5, 96.5)
			f36_arg0.ZmFxSpark2Ext:setTopBottom(0, 0, -78.5, 31.5)
			f36_arg0.ZmFxSpark2Ext:setAlpha(0)
			f36_local1(f36_arg0.ZmFxSpark2Ext)
		end,
	},
	Strikes1 = {
		DefaultClip = function(f41_arg0, f41_arg1)
			f41_arg0:__resetProperties()
			f41_arg0:setupElementClipCounter(5)
			f41_arg0.Strike1:completeAnimation()
			f41_arg0.Strike1:setLeftRight(0, 0, 2, 82)
			f41_arg0.Strike1:setTopBottom(0, 0, 0, 80)
			f41_arg0.Strike1:setRGB(1, 1, 1)
			f41_arg0.Strike1:setImage(RegisterImage(0x3A6C1FB3B354832))
			f41_arg0.clipFinished(f41_arg0.Strike1)
			f41_arg0.Strike2:completeAnimation()
			f41_arg0.Strike2:setRGB(1, 1, 1)
			f41_arg0.clipFinished(f41_arg0.Strike2)
			f41_arg0.Strike3:completeAnimation()
			f41_arg0.Strike3:setLeftRight(0, 0, 142, 222)
			f41_arg0.Strike3:setTopBottom(0, 0, 0, 80)
			f41_arg0.clipFinished(f41_arg0.Strike3)
			f41_arg0.cross1:completeAnimation()
			f41_arg0.cross1:setAlpha(1)
			f41_arg0.clipFinished(f41_arg0.cross1)
			f41_arg0.ZmFxSpark2Ext:completeAnimation()
			f41_arg0.ZmFxSpark2Ext:setLeftRight(0, 0, 23.5, 96.5)
			f41_arg0.ZmFxSpark2Ext:setTopBottom(0, 0, -78.5, 31.5)
			f41_arg0.ZmFxSpark2Ext:setAlpha(0)
			f41_arg0.clipFinished(f41_arg0.ZmFxSpark2Ext)
		end,
		Strikes2 = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(6)
			f42_arg0.Strike1:completeAnimation()
			f42_arg0.Strike1:setLeftRight(0, 0, 2, 82)
			f42_arg0.Strike1:setRGB(1, 1, 1)
			f42_arg0.clipFinished(f42_arg0.Strike1)
			f42_arg0.Strike2:completeAnimation()
			f42_arg0.Strike2:setRGB(1, 1, 1)
			f42_arg0.Strike2:setImage(RegisterImage(0x3A6C1FB3B354832))
			f42_arg0.clipFinished(f42_arg0.Strike2)
			f42_arg0.Strike3:completeAnimation()
			f42_arg0.Strike3:setLeftRight(0, 0, 142, 222)
			f42_arg0.Strike3:setTopBottom(0, 0, 0, 80)
			f42_arg0.clipFinished(f42_arg0.Strike3)
			local f42_local0 = function(f43_arg0)
				f42_arg0.cross2:beginAnimation(2000)
				f42_arg0.cross2:setAlpha(1)
				f42_arg0.cross2:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.cross2:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
			end
			f42_arg0.cross2:completeAnimation()
			f42_arg0.cross2:setLeftRight(0, 0, 72, 152)
			f42_arg0.cross2:setTopBottom(0, 0, 3.5, 83.5)
			f42_arg0.cross2:setAlpha(0)
			f42_local0(f42_arg0.cross2)
			f42_arg0.cross1:completeAnimation()
			f42_arg0.cross1:setLeftRight(0, 0, 2, 82)
			f42_arg0.cross1:setTopBottom(0, 0, 3.5, 83.5)
			f42_arg0.cross1:setAlpha(1)
			f42_arg0.clipFinished(f42_arg0.cross1)
			local f42_local1 = function(f44_arg0)
				local f44_local0 = function(f45_arg0)
					local f45_local0 = function(f46_arg0)
						f46_arg0:beginAnimation(190)
						f46_arg0:setAlpha(0)
						f46_arg0:registerEventHandler("transition_complete_keyframe", f42_arg0.clipFinished)
					end
					f45_arg0:beginAnimation(790)
					f45_arg0:setLeftRight(0, 0, 82, 155)
					f45_arg0:setTopBottom(0, 0, -38, 72)
					f45_arg0:setAlpha(0.2)
					f45_arg0:registerEventHandler("transition_complete_keyframe", f45_local0)
				end
				f42_arg0.ZmFxSpark2Ext:beginAnimation(210)
				f42_arg0.ZmFxSpark2Ext:setLeftRight(0, 0, 100.57, 173.57)
				f42_arg0.ZmFxSpark2Ext:setTopBottom(0, 0, -70, 40)
				f42_arg0.ZmFxSpark2Ext:setAlpha(0.8)
				f42_arg0.ZmFxSpark2Ext:registerEventHandler("interrupted_keyframe", f42_arg0.clipInterrupted)
				f42_arg0.ZmFxSpark2Ext:registerEventHandler("transition_complete_keyframe", f44_local0)
			end
			f42_arg0.ZmFxSpark2Ext:completeAnimation()
			f42_arg0.ZmFxSpark2Ext:setLeftRight(0, 0, 105.5, 178.5)
			f42_arg0.ZmFxSpark2Ext:setTopBottom(0, 0, -78.5, 31.5)
			f42_arg0.ZmFxSpark2Ext:setAlpha(0)
			f42_local1(f42_arg0.ZmFxSpark2Ext)
		end,
	},
	Strikes2 = {
		DefaultClip = function(f47_arg0, f47_arg1)
			f47_arg0:__resetProperties()
			f47_arg0:setupElementClipCounter(6)
			f47_arg0.Strike1:completeAnimation()
			f47_arg0.Strike1:setLeftRight(0, 0, 2, 82)
			f47_arg0.Strike1:setRGB(1, 1, 1)
			f47_arg0.clipFinished(f47_arg0.Strike1)
			f47_arg0.Strike2:completeAnimation()
			f47_arg0.Strike2:setRGB(1, 1, 1)
			f47_arg0.Strike2:setImage(RegisterImage(0x3A6C1FB3B354832))
			f47_arg0.clipFinished(f47_arg0.Strike2)
			f47_arg0.Strike3:completeAnimation()
			f47_arg0.Strike3:setLeftRight(0, 0, 142, 222)
			f47_arg0.Strike3:setTopBottom(0, 0, 0, 80)
			f47_arg0.clipFinished(f47_arg0.Strike3)
			f47_arg0.cross2:completeAnimation()
			f47_arg0.cross2:setAlpha(1)
			f47_arg0.clipFinished(f47_arg0.cross2)
			f47_arg0.cross1:completeAnimation()
			f47_arg0.cross1:setLeftRight(0, 0, 2, 82)
			f47_arg0.cross1:setTopBottom(0, 0, 3.5, 83.5)
			f47_arg0.cross1:setAlpha(1)
			f47_arg0.clipFinished(f47_arg0.cross1)
			f47_arg0.ZmFxSpark2Ext:completeAnimation()
			f47_arg0.ZmFxSpark2Ext:setLeftRight(0, 0, 105.5, 178.5)
			f47_arg0.ZmFxSpark2Ext:setTopBottom(0, 0, -78.5, 31.5)
			f47_arg0.ZmFxSpark2Ext:setAlpha(0)
			f47_arg0.clipFinished(f47_arg0.ZmFxSpark2Ext)
		end,
		Strikes3 = function(f48_arg0, f48_arg1)
			f48_arg0:__resetProperties()
			f48_arg0:setupElementClipCounter(7)
			f48_arg0.Strike1:completeAnimation()
			f48_arg0.Strike1:setLeftRight(0, 0, 2, 82)
			f48_arg0.Strike1:setRGB(1, 1, 1)
			f48_arg0.clipFinished(f48_arg0.Strike1)
			f48_arg0.Strike2:completeAnimation()
			f48_arg0.Strike2:setLeftRight(0, 0, 72, 152)
			f48_arg0.Strike2:setRGB(1, 1, 1)
			f48_arg0.Strike2:setImage(RegisterImage(0x3A6C1FB3B354832))
			f48_arg0.clipFinished(f48_arg0.Strike2)
			f48_arg0.Strike3:completeAnimation()
			f48_arg0.Strike3:setLeftRight(0, 0, 142, 222)
			f48_arg0.Strike3:setTopBottom(0, 0, 0, 80)
			f48_arg0.Strike3:setRGB(1, 1, 1)
			f48_arg0.clipFinished(f48_arg0.Strike3)
			f48_arg0.cross2:completeAnimation()
			f48_arg0.cross2:setLeftRight(0, 0, 72, 152)
			f48_arg0.cross2:setTopBottom(0, 0, 3.5, 83.5)
			f48_arg0.cross2:setAlpha(1)
			f48_arg0.clipFinished(f48_arg0.cross2)
			f48_arg0.cross1:completeAnimation()
			f48_arg0.cross1:setTopBottom(0, 0, 3.5, 83.5)
			f48_arg0.cross1:setAlpha(1)
			f48_arg0.clipFinished(f48_arg0.cross1)
			local f48_local0 = function(f49_arg0)
				f48_arg0.cross3:beginAnimation(1990)
				f48_arg0.cross3:setAlpha(1)
				f48_arg0.cross3:registerEventHandler("interrupted_keyframe", f48_arg0.clipInterrupted)
				f48_arg0.cross3:registerEventHandler("transition_complete_keyframe", f48_arg0.clipFinished)
			end
			f48_arg0.cross3:completeAnimation()
			f48_arg0.cross3:setLeftRight(0, 0, 142, 222)
			f48_arg0.cross3:setTopBottom(0, 0, 3.5, 83.5)
			f48_arg0.cross3:setAlpha(0)
			f48_local0(f48_arg0.cross3)
			local f48_local1 = function(f50_arg0)
				local f50_local0 = function(f51_arg0)
					local f51_local0 = function(f52_arg0)
						f52_arg0:beginAnimation(240)
						f52_arg0:setAlpha(0)
						f52_arg0:registerEventHandler("transition_complete_keyframe", f48_arg0.clipFinished)
					end
					f51_arg0:beginAnimation(790)
					f51_arg0:setLeftRight(0, 0, 149, 222)
					f51_arg0:setTopBottom(0, 0, -38, 72)
					f51_arg0:setAlpha(0.2)
					f51_arg0:registerEventHandler("transition_complete_keyframe", f51_local0)
				end
				f48_arg0.ZmFxSpark2Ext:beginAnimation(210)
				f48_arg0.ZmFxSpark2Ext:setLeftRight(0, 0, 169.94, 242.94)
				f48_arg0.ZmFxSpark2Ext:setTopBottom(0, 0, -77.11, 32.89)
				f48_arg0.ZmFxSpark2Ext:setAlpha(0.8)
				f48_arg0.ZmFxSpark2Ext:registerEventHandler("interrupted_keyframe", f48_arg0.clipInterrupted)
				f48_arg0.ZmFxSpark2Ext:registerEventHandler("transition_complete_keyframe", f50_local0)
			end
			f48_arg0.ZmFxSpark2Ext:completeAnimation()
			f48_arg0.ZmFxSpark2Ext:setLeftRight(0, 0, 175.5, 248.5)
			f48_arg0.ZmFxSpark2Ext:setTopBottom(0, 0, -87.5, 22.5)
			f48_arg0.ZmFxSpark2Ext:setAlpha(0)
			f48_local1(f48_arg0.ZmFxSpark2Ext)
		end,
	},
	Strikes3 = {
		DefaultClip = function(f53_arg0, f53_arg1)
			f53_arg0:__resetProperties()
			f53_arg0:setupElementClipCounter(7)
			f53_arg0.Strike1:completeAnimation()
			f53_arg0.Strike1:setLeftRight(0, 0, 2, 82)
			f53_arg0.Strike1:setRGB(1, 1, 1)
			f53_arg0.clipFinished(f53_arg0.Strike1)
			f53_arg0.Strike2:completeAnimation()
			f53_arg0.Strike2:setLeftRight(0, 0, 72, 152)
			f53_arg0.Strike2:setRGB(1, 1, 1)
			f53_arg0.Strike2:setImage(RegisterImage(0x3A6C1FB3B354832))
			f53_arg0.clipFinished(f53_arg0.Strike2)
			f53_arg0.Strike3:completeAnimation()
			f53_arg0.Strike3:setLeftRight(0, 0, 142, 222)
			f53_arg0.Strike3:setTopBottom(0, 0, 0, 80)
			f53_arg0.Strike3:setRGB(1, 1, 1)
			f53_arg0.clipFinished(f53_arg0.Strike3)
			f53_arg0.cross2:completeAnimation()
			f53_arg0.cross2:setLeftRight(0, 0, 72, 152)
			f53_arg0.cross2:setTopBottom(0, 0, 3.5, 83.5)
			f53_arg0.cross2:setAlpha(1)
			f53_arg0.clipFinished(f53_arg0.cross2)
			f53_arg0.cross1:completeAnimation()
			f53_arg0.cross1:setTopBottom(0, 0, 3.5, 83.5)
			f53_arg0.cross1:setAlpha(1)
			f53_arg0.clipFinished(f53_arg0.cross1)
			f53_arg0.cross3:completeAnimation()
			f53_arg0.cross3:setAlpha(1)
			f53_arg0.clipFinished(f53_arg0.cross3)
			f53_arg0.ZmFxSpark2Ext:completeAnimation()
			f53_arg0.ZmFxSpark2Ext:setLeftRight(0, 0, 175.5, 248.5)
			f53_arg0.ZmFxSpark2Ext:setTopBottom(0, 0, -87.5, 22.5)
			f53_arg0.ZmFxSpark2Ext:setAlpha(0)
			f53_arg0.clipFinished(f53_arg0.ZmFxSpark2Ext)
		end,
	},
}
CoD.Hud_ZM_Trial_Strikes.__onClose = function(f54_arg0)
	f54_arg0.ZmFxSpark2Ext:close()
end
