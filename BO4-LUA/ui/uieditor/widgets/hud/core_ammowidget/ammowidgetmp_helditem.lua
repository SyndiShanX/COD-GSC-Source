require("x64:dd9edb55dc03abb")
require("x64:e8b4c435a1e7674")
require("x64:b3ff9f106da5e7b")
require("x64:18ced87ee825d0f")
require("x64:df55cb39b6ff10b")
require("x64:7b03cd64ad0a79")
require("x64:653dea5df24d16e")
CoD.AmmoWidgetMP_HeldItem = InheritFrom(LUI.UIElement)
CoD.AmmoWidgetMP_HeldItem.__defaultWidth = 138
CoD.AmmoWidgetMP_HeldItem.__defaultHeight = 184
CoD.AmmoWidgetMP_HeldItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidgetMP_HeldItem)
	self.id = "AmmoWidgetMP_HeldItem"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AmmoWidgetCPDataPackage = CoD.AmmoWidget_CPDataPackage.new(f1_arg0, f1_arg1, 0, 0, 15.5, 120.5, 0, 0, 37.5, 142.5)
	AmmoWidgetCPDataPackage:mergeStateConditions({
		{
			stateName = "Hide",
			condition = function(menu, element, event)
				local f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954])
				if not f2_local0 then
					f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40])
					if not f2_local0 then
						f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x59333FC97F7870])
						if not f2_local0 then
							f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC])
							if not f2_local0 then
								if Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]) then
									f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8])
									if not f2_local0 then
										f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
										if not f2_local0 then
											f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7])
											if not f2_local0 then
												f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x6668F0686232679])
												if not f2_local0 then
													f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E])
													if not f2_local0 then
														f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2])
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
								else
									f2_local0 = true
								end
							end
						end
					end
				end
				return f2_local0
			end,
		},
	})
	local AmmoWidgetBall = AmmoWidgetCPDataPackage
	local AmmoWidgetSDBomb = AmmoWidgetCPDataPackage.subscribeToModel
	local AmmoWidgetCarryItemBattery = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetSDBomb(AmmoWidgetBall, AmmoWidgetCarryItemBattery["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954]], function(f3_arg0)
		f1_arg0:updateElementState(AmmoWidgetCPDataPackage, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954],
		})
	end, false)
	AmmoWidgetBall = AmmoWidgetCPDataPackage
	AmmoWidgetSDBomb = AmmoWidgetCPDataPackage.subscribeToModel
	AmmoWidgetCarryItemBattery = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetSDBomb(AmmoWidgetBall, AmmoWidgetCarryItemBattery["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40]], function(f4_arg0)
		f1_arg0:updateElementState(AmmoWidgetCPDataPackage, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40],
		})
	end, false)
	AmmoWidgetBall = AmmoWidgetCPDataPackage
	AmmoWidgetSDBomb = AmmoWidgetCPDataPackage.subscribeToModel
	AmmoWidgetCarryItemBattery = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetSDBomb(AmmoWidgetBall, AmmoWidgetCarryItemBattery["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870]], function(f5_arg0)
		f1_arg0:updateElementState(AmmoWidgetCPDataPackage, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870],
		})
	end, false)
	AmmoWidgetBall = AmmoWidgetCPDataPackage
	AmmoWidgetSDBomb = AmmoWidgetCPDataPackage.subscribeToModel
	AmmoWidgetCarryItemBattery = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetSDBomb(AmmoWidgetBall, AmmoWidgetCarryItemBattery["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f6_arg0)
		f1_arg0:updateElementState(AmmoWidgetCPDataPackage, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	AmmoWidgetBall = AmmoWidgetCPDataPackage
	AmmoWidgetSDBomb = AmmoWidgetCPDataPackage.subscribeToModel
	AmmoWidgetCarryItemBattery = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetSDBomb(AmmoWidgetBall, AmmoWidgetCarryItemBattery["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f7_arg0)
		f1_arg0:updateElementState(AmmoWidgetCPDataPackage, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	AmmoWidgetBall = AmmoWidgetCPDataPackage
	AmmoWidgetSDBomb = AmmoWidgetCPDataPackage.subscribeToModel
	AmmoWidgetCarryItemBattery = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetSDBomb(AmmoWidgetBall, AmmoWidgetCarryItemBattery["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8]], function(f8_arg0)
		f1_arg0:updateElementState(AmmoWidgetCPDataPackage, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8],
		})
	end, false)
	AmmoWidgetBall = AmmoWidgetCPDataPackage
	AmmoWidgetSDBomb = AmmoWidgetCPDataPackage.subscribeToModel
	AmmoWidgetCarryItemBattery = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetSDBomb(AmmoWidgetBall, AmmoWidgetCarryItemBattery["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f9_arg0)
		f1_arg0:updateElementState(AmmoWidgetCPDataPackage, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	AmmoWidgetBall = AmmoWidgetCPDataPackage
	AmmoWidgetSDBomb = AmmoWidgetCPDataPackage.subscribeToModel
	AmmoWidgetCarryItemBattery = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetSDBomb(AmmoWidgetBall, AmmoWidgetCarryItemBattery["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7]], function(f10_arg0)
		f1_arg0:updateElementState(AmmoWidgetCPDataPackage, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7],
		})
	end, false)
	AmmoWidgetBall = AmmoWidgetCPDataPackage
	AmmoWidgetSDBomb = AmmoWidgetCPDataPackage.subscribeToModel
	AmmoWidgetCarryItemBattery = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetSDBomb(AmmoWidgetBall, AmmoWidgetCarryItemBattery["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679]], function(f11_arg0)
		f1_arg0:updateElementState(AmmoWidgetCPDataPackage, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679],
		})
	end, false)
	AmmoWidgetBall = AmmoWidgetCPDataPackage
	AmmoWidgetSDBomb = AmmoWidgetCPDataPackage.subscribeToModel
	AmmoWidgetCarryItemBattery = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetSDBomb(AmmoWidgetBall, AmmoWidgetCarryItemBattery["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E]], function(f12_arg0)
		f1_arg0:updateElementState(AmmoWidgetCPDataPackage, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E],
		})
	end, false)
	AmmoWidgetBall = AmmoWidgetCPDataPackage
	AmmoWidgetSDBomb = AmmoWidgetCPDataPackage.subscribeToModel
	AmmoWidgetCarryItemBattery = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetSDBomb(AmmoWidgetBall, AmmoWidgetCarryItemBattery["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2]], function(f13_arg0)
		f1_arg0:updateElementState(AmmoWidgetCPDataPackage, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2],
		})
	end, false)
	AmmoWidgetBall = AmmoWidgetCPDataPackage
	AmmoWidgetSDBomb = AmmoWidgetCPDataPackage.subscribeToModel
	AmmoWidgetCarryItemBattery = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetSDBomb(AmmoWidgetBall, AmmoWidgetCarryItemBattery["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f14_arg0)
		f1_arg0:updateElementState(AmmoWidgetCPDataPackage, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	AmmoWidgetBall = AmmoWidgetCPDataPackage
	AmmoWidgetSDBomb = AmmoWidgetCPDataPackage.subscribeToModel
	AmmoWidgetCarryItemBattery = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetSDBomb(AmmoWidgetBall, AmmoWidgetCarryItemBattery["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]], function(f15_arg0)
		f1_arg0:updateElementState(AmmoWidgetCPDataPackage, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6],
		})
	end, false)
	AmmoWidgetBall = AmmoWidgetCPDataPackage
	AmmoWidgetSDBomb = AmmoWidgetCPDataPackage.subscribeToModel
	AmmoWidgetCarryItemBattery = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetSDBomb(AmmoWidgetBall, AmmoWidgetCarryItemBattery["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762]], function(f16_arg0)
		f1_arg0:updateElementState(AmmoWidgetCPDataPackage, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762],
		})
	end, false)
	AmmoWidgetBall = AmmoWidgetCPDataPackage
	AmmoWidgetSDBomb = AmmoWidgetCPDataPackage.subscribeToModel
	AmmoWidgetCarryItemBattery = DataSources.CPGamePlayBundleData.getModel(f1_arg1)
	AmmoWidgetSDBomb(AmmoWidgetBall, AmmoWidgetCarryItemBattery.briefcaseClient, function(f17_arg0)
		f1_arg0:updateElementState(AmmoWidgetCPDataPackage, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "briefcaseClient",
		})
	end, false)
	AmmoWidgetCPDataPackage:setAlpha(0)
	self:addElement(AmmoWidgetCPDataPackage)
	self.AmmoWidgetCPDataPackage = AmmoWidgetCPDataPackage
	AmmoWidgetSDBomb = CoD.AmmoWidget_SDBomb.new(f1_arg0, f1_arg1, 0, 0, 16.5, 121.5, 0, 0, 37.5, 142.5)
	AmmoWidgetSDBomb:mergeStateConditions({
		{
			stateName = "Hide",
			condition = function(menu, element, event)
				local f18_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954])
				if not f18_local0 then
					f18_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40])
					if not f18_local0 then
						f18_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x59333FC97F7870])
						if not f18_local0 then
							f18_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC])
							if not f18_local0 then
								if Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]) then
									f18_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8])
									if not f18_local0 then
										f18_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
										if not f18_local0 then
											f18_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7])
											if not f18_local0 then
												f18_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x6668F0686232679])
												if not f18_local0 then
													f18_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E])
													if not f18_local0 then
														f18_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2])
														if not f18_local0 then
															f18_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
															if not f18_local0 then
																f18_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
																if not f18_local0 then
																	f18_local0 = not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xBB045E46E88E762])
																end
															end
														end
													end
												end
											end
										end
									end
								else
									f18_local0 = true
								end
							end
						end
					end
				end
				return f18_local0
			end,
		},
	})
	AmmoWidgetCarryItemBattery = AmmoWidgetSDBomb
	AmmoWidgetBall = AmmoWidgetSDBomb.subscribeToModel
	local AmmoWidgetBountyBag = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetBall(AmmoWidgetCarryItemBattery, AmmoWidgetBountyBag["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954]], function(f19_arg0)
		f1_arg0:updateElementState(AmmoWidgetSDBomb, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954],
		})
	end, false)
	AmmoWidgetCarryItemBattery = AmmoWidgetSDBomb
	AmmoWidgetBall = AmmoWidgetSDBomb.subscribeToModel
	AmmoWidgetBountyBag = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetBall(AmmoWidgetCarryItemBattery, AmmoWidgetBountyBag["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40]], function(f20_arg0)
		f1_arg0:updateElementState(AmmoWidgetSDBomb, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40],
		})
	end, false)
	AmmoWidgetCarryItemBattery = AmmoWidgetSDBomb
	AmmoWidgetBall = AmmoWidgetSDBomb.subscribeToModel
	AmmoWidgetBountyBag = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetBall(AmmoWidgetCarryItemBattery, AmmoWidgetBountyBag["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870]], function(f21_arg0)
		f1_arg0:updateElementState(AmmoWidgetSDBomb, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870],
		})
	end, false)
	AmmoWidgetCarryItemBattery = AmmoWidgetSDBomb
	AmmoWidgetBall = AmmoWidgetSDBomb.subscribeToModel
	AmmoWidgetBountyBag = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetBall(AmmoWidgetCarryItemBattery, AmmoWidgetBountyBag["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f22_arg0)
		f1_arg0:updateElementState(AmmoWidgetSDBomb, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	AmmoWidgetCarryItemBattery = AmmoWidgetSDBomb
	AmmoWidgetBall = AmmoWidgetSDBomb.subscribeToModel
	AmmoWidgetBountyBag = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetBall(AmmoWidgetCarryItemBattery, AmmoWidgetBountyBag["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f23_arg0)
		f1_arg0:updateElementState(AmmoWidgetSDBomb, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	AmmoWidgetCarryItemBattery = AmmoWidgetSDBomb
	AmmoWidgetBall = AmmoWidgetSDBomb.subscribeToModel
	AmmoWidgetBountyBag = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetBall(AmmoWidgetCarryItemBattery, AmmoWidgetBountyBag["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8]], function(f24_arg0)
		f1_arg0:updateElementState(AmmoWidgetSDBomb, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8],
		})
	end, false)
	AmmoWidgetCarryItemBattery = AmmoWidgetSDBomb
	AmmoWidgetBall = AmmoWidgetSDBomb.subscribeToModel
	AmmoWidgetBountyBag = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetBall(AmmoWidgetCarryItemBattery, AmmoWidgetBountyBag["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f25_arg0)
		f1_arg0:updateElementState(AmmoWidgetSDBomb, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f25_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	AmmoWidgetCarryItemBattery = AmmoWidgetSDBomb
	AmmoWidgetBall = AmmoWidgetSDBomb.subscribeToModel
	AmmoWidgetBountyBag = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetBall(AmmoWidgetCarryItemBattery, AmmoWidgetBountyBag["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7]], function(f26_arg0)
		f1_arg0:updateElementState(AmmoWidgetSDBomb, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f26_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7],
		})
	end, false)
	AmmoWidgetCarryItemBattery = AmmoWidgetSDBomb
	AmmoWidgetBall = AmmoWidgetSDBomb.subscribeToModel
	AmmoWidgetBountyBag = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetBall(AmmoWidgetCarryItemBattery, AmmoWidgetBountyBag["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679]], function(f27_arg0)
		f1_arg0:updateElementState(AmmoWidgetSDBomb, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f27_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679],
		})
	end, false)
	AmmoWidgetCarryItemBattery = AmmoWidgetSDBomb
	AmmoWidgetBall = AmmoWidgetSDBomb.subscribeToModel
	AmmoWidgetBountyBag = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetBall(AmmoWidgetCarryItemBattery, AmmoWidgetBountyBag["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E]], function(f28_arg0)
		f1_arg0:updateElementState(AmmoWidgetSDBomb, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f28_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E],
		})
	end, false)
	AmmoWidgetCarryItemBattery = AmmoWidgetSDBomb
	AmmoWidgetBall = AmmoWidgetSDBomb.subscribeToModel
	AmmoWidgetBountyBag = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetBall(AmmoWidgetCarryItemBattery, AmmoWidgetBountyBag["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2]], function(f29_arg0)
		f1_arg0:updateElementState(AmmoWidgetSDBomb, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f29_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2],
		})
	end, false)
	AmmoWidgetCarryItemBattery = AmmoWidgetSDBomb
	AmmoWidgetBall = AmmoWidgetSDBomb.subscribeToModel
	AmmoWidgetBountyBag = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetBall(AmmoWidgetCarryItemBattery, AmmoWidgetBountyBag["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f30_arg0)
		f1_arg0:updateElementState(AmmoWidgetSDBomb, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f30_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	AmmoWidgetCarryItemBattery = AmmoWidgetSDBomb
	AmmoWidgetBall = AmmoWidgetSDBomb.subscribeToModel
	AmmoWidgetBountyBag = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetBall(AmmoWidgetCarryItemBattery, AmmoWidgetBountyBag["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]], function(f31_arg0)
		f1_arg0:updateElementState(AmmoWidgetSDBomb, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f31_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6],
		})
	end, false)
	AmmoWidgetCarryItemBattery = AmmoWidgetSDBomb
	AmmoWidgetBall = AmmoWidgetSDBomb.subscribeToModel
	AmmoWidgetBountyBag = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetBall(AmmoWidgetCarryItemBattery, AmmoWidgetBountyBag["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762]], function(f32_arg0)
		f1_arg0:updateElementState(AmmoWidgetSDBomb, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f32_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762],
		})
	end, false)
	AmmoWidgetCarryItemBattery = AmmoWidgetSDBomb
	AmmoWidgetBall = AmmoWidgetSDBomb.subscribeToModel
	AmmoWidgetBountyBag = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetBall(AmmoWidgetCarryItemBattery, AmmoWidgetBountyBag["hudItems.SDBombClient"], function(f33_arg0)
		f1_arg0:updateElementState(AmmoWidgetSDBomb, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f33_arg0:get(),
			modelName = "hudItems.SDBombClient",
		})
	end, false)
	AmmoWidgetCarryItemBattery = AmmoWidgetSDBomb
	AmmoWidgetBall = AmmoWidgetSDBomb.subscribeToModel
	AmmoWidgetBountyBag = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetBall(AmmoWidgetCarryItemBattery, AmmoWidgetBountyBag["deadSpectator.playerIndex"], function(f34_arg0)
		f1_arg0:updateElementState(AmmoWidgetSDBomb, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f34_arg0:get(),
			modelName = "deadSpectator.playerIndex",
		})
	end, false)
	AmmoWidgetCarryItemBattery = AmmoWidgetSDBomb
	AmmoWidgetBall = AmmoWidgetSDBomb.subscribeToModel
	AmmoWidgetBountyBag = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetBall(AmmoWidgetCarryItemBattery, AmmoWidgetBountyBag["Demolition.defending"], function(f35_arg0)
		f1_arg0:updateElementState(AmmoWidgetSDBomb, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f35_arg0:get(),
			modelName = "Demolition.defending",
		})
	end, false)
	AmmoWidgetCarryItemBattery = AmmoWidgetSDBomb
	AmmoWidgetBall = AmmoWidgetSDBomb.subscribeToModel
	AmmoWidgetBountyBag = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetBall(AmmoWidgetCarryItemBattery, AmmoWidgetBountyBag["SearchAndDestroy.defending"], function(f36_arg0)
		f1_arg0:updateElementState(AmmoWidgetSDBomb, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f36_arg0:get(),
			modelName = "SearchAndDestroy.defending",
		})
	end, false)
	AmmoWidgetCarryItemBattery = AmmoWidgetSDBomb
	AmmoWidgetBall = AmmoWidgetSDBomb.subscribeToModel
	AmmoWidgetBountyBag = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetBall(AmmoWidgetCarryItemBattery, AmmoWidgetBountyBag["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xABEA46F8DE7F02F]], function(f37_arg0)
		f1_arg0:updateElementState(AmmoWidgetSDBomb, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f37_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xABEA46F8DE7F02F],
		})
	end, false)
	AmmoWidgetCarryItemBattery = AmmoWidgetSDBomb
	AmmoWidgetBall = AmmoWidgetSDBomb.subscribeToModel
	AmmoWidgetBountyBag = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetBall(AmmoWidgetCarryItemBattery, AmmoWidgetBountyBag["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xABEA56F8DE7F1E2]], function(f38_arg0)
		f1_arg0:updateElementState(AmmoWidgetSDBomb, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f38_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xABEA56F8DE7F1E2],
		})
	end, false)
	AmmoWidgetCarryItemBattery = AmmoWidgetSDBomb
	AmmoWidgetBall = AmmoWidgetSDBomb.subscribeToModel
	AmmoWidgetBountyBag = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetBall(AmmoWidgetCarryItemBattery, AmmoWidgetBountyBag["factions.isCoDCaster"], function(f39_arg0)
		f1_arg0:updateElementState(AmmoWidgetSDBomb, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f39_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	self:addElement(AmmoWidgetSDBomb)
	self.AmmoWidgetSDBomb = AmmoWidgetSDBomb
	AmmoWidgetBall = CoD.AmmoWidget_Ball.new(f1_arg0, f1_arg1, 0, 0, 15.5, 120.5, 0, 0, 37.5, 142.5)
	AmmoWidgetBall:mergeStateConditions({
		{
			stateName = "Hide",
			condition = function(menu, element, event)
				local f40_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954])
				if not f40_local0 then
					f40_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40])
					if not f40_local0 then
						f40_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x59333FC97F7870])
						if not f40_local0 then
							f40_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC])
							if not f40_local0 then
								if Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]) then
									f40_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8])
									if not f40_local0 then
										f40_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
										if not f40_local0 then
											f40_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7])
											if not f40_local0 then
												f40_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x6668F0686232679])
												if not f40_local0 then
													f40_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E])
													if not f40_local0 then
														f40_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2])
														if not f40_local0 then
															f40_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
															if not f40_local0 then
																f40_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
																if not f40_local0 then
																	f40_local0 = not Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xBB045E46E88E762])
																end
															end
														end
													end
												end
											end
										end
									end
								else
									f40_local0 = true
								end
							end
						end
					end
				end
				return f40_local0
			end,
		},
	})
	AmmoWidgetBountyBag = AmmoWidgetBall
	AmmoWidgetCarryItemBattery = AmmoWidgetBall.subscribeToModel
	local AmmoWidgetctfflag = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetCarryItemBattery(AmmoWidgetBountyBag, AmmoWidgetctfflag["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954]], function(f41_arg0)
		f1_arg0:updateElementState(AmmoWidgetBall, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f41_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954],
		})
	end, false)
	AmmoWidgetBountyBag = AmmoWidgetBall
	AmmoWidgetCarryItemBattery = AmmoWidgetBall.subscribeToModel
	AmmoWidgetctfflag = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetCarryItemBattery(AmmoWidgetBountyBag, AmmoWidgetctfflag["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40]], function(f42_arg0)
		f1_arg0:updateElementState(AmmoWidgetBall, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f42_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40],
		})
	end, false)
	AmmoWidgetBountyBag = AmmoWidgetBall
	AmmoWidgetCarryItemBattery = AmmoWidgetBall.subscribeToModel
	AmmoWidgetctfflag = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetCarryItemBattery(AmmoWidgetBountyBag, AmmoWidgetctfflag["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870]], function(f43_arg0)
		f1_arg0:updateElementState(AmmoWidgetBall, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f43_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870],
		})
	end, false)
	AmmoWidgetBountyBag = AmmoWidgetBall
	AmmoWidgetCarryItemBattery = AmmoWidgetBall.subscribeToModel
	AmmoWidgetctfflag = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetCarryItemBattery(AmmoWidgetBountyBag, AmmoWidgetctfflag["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f44_arg0)
		f1_arg0:updateElementState(AmmoWidgetBall, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f44_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	AmmoWidgetBountyBag = AmmoWidgetBall
	AmmoWidgetCarryItemBattery = AmmoWidgetBall.subscribeToModel
	AmmoWidgetctfflag = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetCarryItemBattery(AmmoWidgetBountyBag, AmmoWidgetctfflag["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f45_arg0)
		f1_arg0:updateElementState(AmmoWidgetBall, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f45_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	AmmoWidgetBountyBag = AmmoWidgetBall
	AmmoWidgetCarryItemBattery = AmmoWidgetBall.subscribeToModel
	AmmoWidgetctfflag = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetCarryItemBattery(AmmoWidgetBountyBag, AmmoWidgetctfflag["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8]], function(f46_arg0)
		f1_arg0:updateElementState(AmmoWidgetBall, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f46_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8],
		})
	end, false)
	AmmoWidgetBountyBag = AmmoWidgetBall
	AmmoWidgetCarryItemBattery = AmmoWidgetBall.subscribeToModel
	AmmoWidgetctfflag = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetCarryItemBattery(AmmoWidgetBountyBag, AmmoWidgetctfflag["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f47_arg0)
		f1_arg0:updateElementState(AmmoWidgetBall, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f47_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	AmmoWidgetBountyBag = AmmoWidgetBall
	AmmoWidgetCarryItemBattery = AmmoWidgetBall.subscribeToModel
	AmmoWidgetctfflag = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetCarryItemBattery(AmmoWidgetBountyBag, AmmoWidgetctfflag["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7]], function(f48_arg0)
		f1_arg0:updateElementState(AmmoWidgetBall, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f48_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7],
		})
	end, false)
	AmmoWidgetBountyBag = AmmoWidgetBall
	AmmoWidgetCarryItemBattery = AmmoWidgetBall.subscribeToModel
	AmmoWidgetctfflag = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetCarryItemBattery(AmmoWidgetBountyBag, AmmoWidgetctfflag["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679]], function(f49_arg0)
		f1_arg0:updateElementState(AmmoWidgetBall, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f49_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679],
		})
	end, false)
	AmmoWidgetBountyBag = AmmoWidgetBall
	AmmoWidgetCarryItemBattery = AmmoWidgetBall.subscribeToModel
	AmmoWidgetctfflag = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetCarryItemBattery(AmmoWidgetBountyBag, AmmoWidgetctfflag["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E]], function(f50_arg0)
		f1_arg0:updateElementState(AmmoWidgetBall, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f50_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E],
		})
	end, false)
	AmmoWidgetBountyBag = AmmoWidgetBall
	AmmoWidgetCarryItemBattery = AmmoWidgetBall.subscribeToModel
	AmmoWidgetctfflag = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetCarryItemBattery(AmmoWidgetBountyBag, AmmoWidgetctfflag["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2]], function(f51_arg0)
		f1_arg0:updateElementState(AmmoWidgetBall, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f51_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2],
		})
	end, false)
	AmmoWidgetBountyBag = AmmoWidgetBall
	AmmoWidgetCarryItemBattery = AmmoWidgetBall.subscribeToModel
	AmmoWidgetctfflag = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetCarryItemBattery(AmmoWidgetBountyBag, AmmoWidgetctfflag["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f52_arg0)
		f1_arg0:updateElementState(AmmoWidgetBall, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f52_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	AmmoWidgetBountyBag = AmmoWidgetBall
	AmmoWidgetCarryItemBattery = AmmoWidgetBall.subscribeToModel
	AmmoWidgetctfflag = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetCarryItemBattery(AmmoWidgetBountyBag, AmmoWidgetctfflag["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]], function(f53_arg0)
		f1_arg0:updateElementState(AmmoWidgetBall, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f53_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6],
		})
	end, false)
	AmmoWidgetBountyBag = AmmoWidgetBall
	AmmoWidgetCarryItemBattery = AmmoWidgetBall.subscribeToModel
	AmmoWidgetctfflag = Engine[0x4DF5CFBC1771947](f1_arg1)
	AmmoWidgetCarryItemBattery(AmmoWidgetBountyBag, AmmoWidgetctfflag["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762]], function(f54_arg0)
		f1_arg0:updateElementState(AmmoWidgetBall, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f54_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762],
		})
	end, false)
	AmmoWidgetBountyBag = AmmoWidgetBall
	AmmoWidgetCarryItemBattery = AmmoWidgetBall.subscribeToModel
	AmmoWidgetctfflag = DataSources.CurrentWeapon.getModel(f1_arg1)
	AmmoWidgetCarryItemBattery(AmmoWidgetBountyBag, AmmoWidgetctfflag.viewmodelWeaponName, function(f55_arg0)
		f1_arg0:updateElementState(AmmoWidgetBall, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f55_arg0:get(),
			modelName = "viewmodelWeaponName",
		})
	end, false)
	AmmoWidgetBall:setAlpha(0)
	self:addElement(AmmoWidgetBall)
	self.AmmoWidgetBall = AmmoWidgetBall
	AmmoWidgetCarryItemBattery = CoD.AmmoWidget_CarryItem_Battery.new(f1_arg0, f1_arg1, 0, 0, 16, 121, 0, 0, 37, 142)
	AmmoWidgetCarryItemBattery:setAlpha(0)
	self:addElement(AmmoWidgetCarryItemBattery)
	self.AmmoWidgetCarryItemBattery = AmmoWidgetCarryItemBattery
	AmmoWidgetBountyBag = CoD.AmmoWidget_BountyBag.new(f1_arg0, f1_arg1, 0, 0, 16.5, 121.5, 0, 0, 37.5, 142.5)
	self:addElement(AmmoWidgetBountyBag)
	self.AmmoWidgetBountyBag = AmmoWidgetBountyBag
	AmmoWidgetctfflag = CoD.AmmoWidget_ctfflag.new(f1_arg0, f1_arg1, 0, 0, 16.5, 121.5, 0, 0, 37.5, 142.5)
	self:addElement(AmmoWidgetctfflag)
	self.AmmoWidgetctfflag = AmmoWidgetctfflag
	local AmmoWidgetCleanTacos = CoD.AmmoWidget_CleanTacos.new(f1_arg0, f1_arg1, 0, 0, 17, 122, 0, 0, 37.5, 142.5)
	AmmoWidgetCleanTacos:setAlpha(0)
	self:addElement(AmmoWidgetCleanTacos)
	self.AmmoWidgetCleanTacos = AmmoWidgetCleanTacos
	self:mergeStateConditions({
		{
			stateName = "Fracture",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsGameTypeEqualToString("clean")
			end,
		},
		{
			stateName = "WeaponDual",
			condition = function(menu, element, event)
				local f57_local0 = WeaponUsesAmmo(f1_arg1)
				if f57_local0 then
					f57_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueGreaterThan(f1_arg1, "CurrentWeapon", "ammoInDWClip", -1)
					if f57_local0 then
						f57_local0 = not CoD.HUDUtility.IsCurrentViewmodelWeaponGamemodeHiddenDWAmmo(f1_arg1)
					end
				end
				return f57_local0
			end,
		},
		{
			stateName = "Hide",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = DataSources.CurrentWeapon.getModel(f1_arg1)
	f1_local9(f1_local8, f1_local10.weapon, function(f59_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f59_arg0:get(),
			modelName = "weapon",
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = DataSources.CurrentWeapon.getModel(f1_arg1)
	f1_local9(f1_local8, f1_local10.ammoInDWClip, function(f60_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f60_arg0:get(),
			modelName = "ammoInDWClip",
		})
	end, false)
	f1_local8 = self
	f1_local9 = self.subscribeToModel
	f1_local10 = DataSources.CurrentWeapon.getModel(f1_arg1)
	f1_local9(f1_local8, f1_local10.viewmodelWeaponName, function(f61_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f61_arg0:get(),
			modelName = "viewmodelWeaponName",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AmmoWidgetMP_HeldItem.__resetProperties = function(f62_arg0)
	f62_arg0.AmmoWidgetSDBomb:completeAnimation()
	f62_arg0.AmmoWidgetBountyBag:completeAnimation()
	f62_arg0.AmmoWidgetCleanTacos:completeAnimation()
	f62_arg0.AmmoWidgetBall:completeAnimation()
	f62_arg0.AmmoWidgetSDBomb:setLeftRight(0, 0, 16.5, 121.5)
	f62_arg0.AmmoWidgetSDBomb:setTopBottom(0, 0, 37.5, 142.5)
	f62_arg0.AmmoWidgetSDBomb:setAlpha(1)
	f62_arg0.AmmoWidgetBountyBag:setAlpha(1)
	f62_arg0.AmmoWidgetCleanTacos:setAlpha(0)
	f62_arg0.AmmoWidgetBall:setLeftRight(0, 0, 15.5, 120.5)
	f62_arg0.AmmoWidgetBall:setTopBottom(0, 0, 37.5, 142.5)
end
CoD.AmmoWidgetMP_HeldItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f63_arg0, f63_arg1)
			f63_arg0:__resetProperties()
			f63_arg0:setupElementClipCounter(1)
			f63_arg0.AmmoWidgetSDBomb:completeAnimation()
			f63_arg0.AmmoWidgetSDBomb:setAlpha(0)
			f63_arg0.clipFinished(f63_arg0.AmmoWidgetSDBomb)
		end,
	},
	Fracture = {
		DefaultClip = function(f64_arg0, f64_arg1)
			f64_arg0:__resetProperties()
			f64_arg0:setupElementClipCounter(3)
			f64_arg0.AmmoWidgetSDBomb:completeAnimation()
			f64_arg0.AmmoWidgetSDBomb:setAlpha(0)
			f64_arg0.clipFinished(f64_arg0.AmmoWidgetSDBomb)
			f64_arg0.AmmoWidgetBountyBag:completeAnimation()
			f64_arg0.AmmoWidgetBountyBag:setAlpha(0)
			f64_arg0.clipFinished(f64_arg0.AmmoWidgetBountyBag)
			f64_arg0.AmmoWidgetCleanTacos:completeAnimation()
			f64_arg0.AmmoWidgetCleanTacos:setAlpha(1)
			f64_arg0.clipFinished(f64_arg0.AmmoWidgetCleanTacos)
		end,
	},
	WeaponDual = {
		DefaultClip = function(f65_arg0, f65_arg1)
			f65_arg0:__resetProperties()
			f65_arg0:setupElementClipCounter(2)
			f65_arg0.AmmoWidgetSDBomb:completeAnimation()
			f65_arg0.AmmoWidgetSDBomb:setLeftRight(0, 0, -106.5, -1.5)
			f65_arg0.AmmoWidgetSDBomb:setTopBottom(0, 0, 39.5, 144.5)
			f65_arg0.clipFinished(f65_arg0.AmmoWidgetSDBomb)
			f65_arg0.AmmoWidgetBall:completeAnimation()
			f65_arg0.AmmoWidgetBall:setLeftRight(0, 0, -106.5, -1.5)
			f65_arg0.AmmoWidgetBall:setTopBottom(0, 0, 39.5, 144.5)
			f65_arg0.clipFinished(f65_arg0.AmmoWidgetBall)
		end,
	},
	Hide = {
		DefaultClip = function(f66_arg0, f66_arg1)
			f66_arg0:__resetProperties()
			f66_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.AmmoWidgetMP_HeldItem.__onClose = function(f67_arg0)
	f67_arg0.AmmoWidgetCPDataPackage:close()
	f67_arg0.AmmoWidgetSDBomb:close()
	f67_arg0.AmmoWidgetBall:close()
	f67_arg0.AmmoWidgetCarryItemBattery:close()
	f67_arg0.AmmoWidgetBountyBag:close()
	f67_arg0.AmmoWidgetctfflag:close()
	f67_arg0.AmmoWidgetCleanTacos:close()
end
