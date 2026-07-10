require("x64:6c0a92e345d6635")
require("x64:1f3dba742640cfa")
require("x64:98de092f5b8db48")
require("x64:c373b5a993aef46")
require("x64:a7a13e373e49761")
require("x64:4f3b540fe46fb34")
CoD.HealthInfo = InheritFrom(LUI.UIElement)
CoD.HealthInfo.__defaultWidth = 238
CoD.HealthInfo.__defaultHeight = 112
CoD.HealthInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HealthInfo)
	self.id = "HealthInfo"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ArmorPortrait = CoD.ArmorPortrait.new(f1_arg0, f1_arg1, 0, 0, 357, 407, 0, 0, 27, 77)
	ArmorPortrait:linkToElementModel(self, nil, false, function(model)
		ArmorPortrait:setModel(model, f1_arg1)
	end)
	self:addElement(ArmorPortrait)
	self.ArmorPortrait = ArmorPortrait
	local HealCooldown = CoD.HealCooldown.new(f1_arg0, f1_arg1, 0, 0, 107, 179, 0, 0, 35, 75)
	HealCooldown:setAlpha(0)
	HealCooldown:subscribeToGlobalModel(f1_arg1, "PlayerAbilities", "playerGadget1", function(model)
		HealCooldown:setModel(model, f1_arg1)
	end)
	self:addElement(HealCooldown)
	self.HealCooldown = HealCooldown
	local ArmorBar = CoD.ArmorBar.new(f1_arg0, f1_arg1, 0, 0, 131, 279, 0, 0, 27, 31)
	ArmorBar:linkToElementModel(self, nil, false, function(model)
		ArmorBar:setModel(model, f1_arg1)
	end)
	self:addElement(ArmorBar)
	self.ArmorBar = ArmorBar
	local HealthBar = CoD.HealthBarWidget.new(f1_arg0, f1_arg1, 0, 0, 129, 281, 0, 0, 34, 45)
	HealthBar:linkToElementModel(self, "health", false, function(model)
		HealthBar:setModel(model, f1_arg1)
	end)
	self:addElement(HealthBar)
	self.HealthBar = HealthBar
	local GlowBlueOver = LUI.UIImage.new(0, 0, 86, 134, 0, 0, 14.5, 282.5)
	GlowBlueOver:setAlpha(0)
	GlowBlueOver:setZRot(90)
	GlowBlueOver:setImage(RegisterImage(0x5BE416E17DAB33B))
	GlowBlueOver:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(GlowBlueOver)
	self.GlowBlueOver = GlowBlueOver
	local HealthValue = LUI.UIText.new(0, 0, 287, 351, 0, 0, 38, 64)
	HealthValue:setTTF("0arame_mono_stencil")
	HealthValue:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	HealthValue:setShaderVector(0, 0.8, 0, 0, 0)
	HealthValue:setShaderVector(1, 0, 0, 0, 0)
	HealthValue:setShaderVector(2, 1, 1, 1, 0.25)
	HealthValue:setLetterSpacing(2)
	HealthValue:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	HealthValue:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	HealthValue:linkToElementModel(self, "health.healthValue", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			HealthValue:setText(CoD.BaseUtility.AlreadyLocalized(f6_local0))
		end
	end)
	self:addElement(HealthValue)
	self.HealthValue = HealthValue
	local HealthDOT = CoD.HealthDOT.new(f1_arg0, f1_arg1, 0, 0, 267, 367, 0, 0, 66, 94)
	HealthDOT:setAlpha(0)
	self:addElement(HealthDOT)
	self.HealthDOT = HealthDOT
	local HealthBoostNotificationContainer = CoD.HealthBoostNotificationContainer.new(f1_arg0, f1_arg1, 0, 0, 279, 343, 0, 0, 38, 64)
	self:addElement(HealthBoostNotificationContainer)
	self.HealthBoostNotificationContainer = HealthBoostNotificationContainer
	local LED = LUI.UIImage.new(0, 0, 116.5, 297.5, 0, 0, 20.5, 60.5)
	LED:setRGB(0, 0, 0)
	LED:setAlpha(0.24)
	LED:setScale(0.94, 0.94)
	LED:setImage(RegisterImage(0x832BA507D0E7663))
	LED:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	LED:setShaderVector(0, 0.03, 0.93, 0, 0)
	LED:setShaderVector(1, 0, 0, 0, 0)
	LED:setShaderVector(2, 0.37, 0.6, 0, 0)
	LED:setShaderVector(3, 0, 0, 0, 0)
	LED:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(LED)
	self.LED = LED
	self:mergeStateConditions({
		{
			stateName = "Invisible",
			condition = function(menu, element, event)
				local f7_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954])
				if not f7_local0 then
					f7_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40])
					if not f7_local0 then
						f7_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x59333FC97F7870])
						if not f7_local0 then
							f7_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769])
							if not f7_local0 then
								if Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]) then
									f7_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8])
									if not f7_local0 then
										f7_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
										if not f7_local0 then
											f7_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7])
											if not f7_local0 then
												f7_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E])
												if not f7_local0 then
													f7_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x6668F0686232679])
													if not f7_local0 then
														f7_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E])
														if not f7_local0 then
															f7_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2])
															if not f7_local0 then
																f7_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F])
																if not f7_local0 then
																	f7_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
																	if not f7_local0 then
																		f7_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
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
									f7_local0 = true
								end
							end
						end
					end
				end
				return f7_local0
			end,
		},
		{
			stateName = "LowHealth",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsCharacterInCriticalState(self, f1_arg1)
			end,
		},
	})
	local f1_local10 = self
	local f1_local11 = self.subscribeToModel
	local f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local11(f1_local10, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954]], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954],
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local11(f1_local10, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40]], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40],
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local11(f1_local10, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870]], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870],
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local11(f1_local10, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769]], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769],
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local11(f1_local10, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local11(f1_local10, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8]], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8],
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local11(f1_local10, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local11(f1_local10, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7]], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7],
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local11(f1_local10, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E]], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E],
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local11(f1_local10, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679]], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679],
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local11(f1_local10, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E]], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E],
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local11(f1_local10, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2]], function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2],
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local11(f1_local10, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local11(f1_local10, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local11(f1_local10, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]], function(f23_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6],
		})
	end, false)
	self:linkToElementModel(self, "health.healthValue", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "health.healthValue",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local11 = self
	if IsMultiplayer() then
		CoD.HUDUtility.UpdateClientHealth(self, f1_arg1)
		CoD.HealthUtility.InitHealthBarLossPulse(self, self.HealthBar, f1_arg1, CoD.HealthBarWidgetPulse, f1_arg0)
	elseif IsZombies() then
		CoD.HUDUtility.UpdateClientHealth(self, f1_arg1)
		CoD.HealthUtility.InitHealthBarLossPulse(self, self.HealthBar, f1_arg1, CoD.HealthBarWidgetPulse, f1_arg0)
	else
		CoD.HUDUtility.UpdateClientHealth(self, f1_arg1)
	end
	f1_local11 = HealthBoostNotificationContainer
	if IsMultiplayer() then
		CoD.HUDUtility.InitHealthBoostNotification(self, f1_local11, f1_arg1, f1_arg0, CoD.HealthBoostNotification)
	end
	return self
end
CoD.HealthInfo.__resetProperties = function(f25_arg0)
	f25_arg0.HealthValue:completeAnimation()
	f25_arg0.GlowBlueOver:completeAnimation()
	f25_arg0.HealthDOT:completeAnimation()
	f25_arg0.HealCooldown:completeAnimation()
	f25_arg0.HealthValue:setRGB(1, 1, 1)
	f25_arg0.HealthValue:setAlpha(1)
	f25_arg0.HealthValue:setShaderVector(0, 0.8, 0, 0, 0)
	f25_arg0.HealthValue:setShaderVector(1, 0, 0, 0, 0)
	f25_arg0.HealthValue:setShaderVector(2, 1, 1, 1, 0.25)
	f25_arg0.GlowBlueOver:setAlpha(0)
	f25_arg0.HealthDOT:setAlpha(0)
	f25_arg0.HealCooldown:setAlpha(0)
end
CoD.HealthInfo.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(0)
		end,
	},
	Invisible = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(3)
			f27_arg0.GlowBlueOver:completeAnimation()
			f27_arg0.GlowBlueOver:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.GlowBlueOver)
			f27_arg0.HealthValue:completeAnimation()
			f27_arg0.HealthValue:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.HealthValue)
			f27_arg0.HealthDOT:completeAnimation()
			f27_arg0.HealthDOT:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.HealthDOT)
		end,
	},
	LowHealth = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(2)
			f28_arg0.HealCooldown:completeAnimation()
			f28_arg0.HealCooldown:setAlpha(0)
			f28_arg0.clipFinished(f28_arg0.HealCooldown)
			local f28_local0 = function(f29_arg0)
				local f29_local0 = function(f30_arg0)
					local f30_local0 = function(f31_arg0)
						local f31_local0 = function(f32_arg0)
							f32_arg0:beginAnimation(350)
							f32_arg0:setRGB(1, 0.42, 0.42)
							f32_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
						end
						f31_arg0:beginAnimation(440)
						f31_arg0:registerEventHandler("transition_complete_keyframe", f31_local0)
					end
					f30_arg0:beginAnimation(460)
					f30_arg0:setRGB(1, 0, 0)
					f30_arg0:registerEventHandler("transition_complete_keyframe", f30_local0)
				end
				f28_arg0.HealthValue:beginAnimation(330)
				f28_arg0.HealthValue:setRGB(1, 0.42, 0.42)
				f28_arg0.HealthValue:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.HealthValue:registerEventHandler("transition_complete_keyframe", f29_local0)
			end
			f28_arg0.HealthValue:completeAnimation()
			f28_arg0.HealthValue:setRGB(1, 0.04, 0.04)
			f28_arg0.HealthValue:setShaderVector(0, 0.8, 0, 0, 0)
			f28_arg0.HealthValue:setShaderVector(1, 0, 0, 0, 0)
			f28_arg0.HealthValue:setShaderVector(2, 1, 0, 0, 0.55)
			f28_local0(f28_arg0.HealthValue)
			f28_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.HealthInfo.__onClose = function(f33_arg0)
	f33_arg0.ArmorPortrait:close()
	f33_arg0.HealCooldown:close()
	f33_arg0.ArmorBar:close()
	f33_arg0.HealthBar:close()
	f33_arg0.HealthValue:close()
	f33_arg0.HealthDOT:close()
	f33_arg0.HealthBoostNotificationContainer:close()
end
