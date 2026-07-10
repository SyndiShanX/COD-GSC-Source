CoD.AmmoWidget_ctfflag = InheritFrom(LUI.UIElement)
CoD.AmmoWidget_ctfflag.__defaultWidth = 105
CoD.AmmoWidget_ctfflag.__defaultHeight = 105
CoD.AmmoWidget_ctfflag.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitControllerModel(f1_arg1, "hudItems.SDBombClient", -1)
	CoD.BaseUtility.CreateControllerModel(f1_arg1, "deadSpectator.playerIndex")
	CoD.BaseUtility.CreateControllerModel(f1_arg1, "Demolition.defending")
	CoD.BaseUtility.CreateControllerModel(f1_arg1, "SearchAndDestroy.defending")
	self:setClass(CoD.AmmoWidget_ctfflag)
	self.id = "AmmoWidget_ctfflag"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local backplate = LUI.UIImage.new(0, 0, 15, 107, 0, 0, 20.5, 84.5)
	backplate:setImage(RegisterImage(0xDD08B725AA00DD6))
	self:addElement(backplate)
	self.backplate = backplate
	local glow = LUI.UIImage.new(0, 0, 15, 107, 0, 0, 20.5, 83.5)
	glow:setRGB(1, 0.17, 0)
	glow:setAlpha(0.25)
	glow:setImage(RegisterImage(0xE0F9061AF34A631))
	glow:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(glow)
	self.glow = glow
	local SndItem3 = LUI.UIImage.new(0, 0, 3, 119, 0, 0, 6.5, 98.5)
	SndItem3:setImage(RegisterImage(0x53C64277C5C7A9F))
	self:addElement(SndItem3)
	self.SndItem3 = SndItem3
	local PanelGlow = LUI.UIImage.new(0, 0, -24, 127, 0, 0, -22, 131)
	PanelGlow:setRGB(0.56, 0.08, 0.08)
	PanelGlow:setAlpha(0.41)
	PanelGlow:setImage(RegisterImage(0x5BE416E17DAB33B))
	PanelGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(PanelGlow)
	self.PanelGlow = PanelGlow
	self:mergeStateConditions({
		{
			stateName = "Hide",
			condition = function(menu, element, event)
				local f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954])
				if not f2_local0 then
					f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40])
					if not f2_local0 then
						f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x59333FC97F7870])
						if not f2_local0 then
							f2_local0 = Engine[0xDD333420C49E6D0](f1_arg1, Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769])
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
				end
				return f2_local0
			end,
		},
		{
			stateName = "Show",
			condition = function(menu, element, event)
				local f3_local0 = AmICarryingEnemyFlag(f1_arg1)
				if f3_local0 then
					if not CoD.HUDUtility.IsAnyGameType(f1_arg1, "war", "infil") then
						f3_local0 = not IsCodCaster(f1_arg1)
					else
						f3_local0 = false
					end
				end
				return f3_local0
			end,
		},
	})
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954]], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40]], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870]], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769]], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8]], function(f9_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f10_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7]], function(f11_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E]], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679]], function(f13_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E]], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2]], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f16_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f17_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]], function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762]], function(f19_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["CTF.enemyFlagCarrier"], function(f20_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "CTF.enemyFlagCarrier",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["CTF.friendlyFlagCarrier"], function(f21_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "CTF.friendlyFlagCarrier",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["deadSpectator.playerIndex"], function(f22_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "deadSpectator.playerIndex",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = DataSources.CurrentWeapon.getModel(f1_arg1)
	f1_local6(f1_local5, f1_local7.ammoInDWClip, function(f23_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f23_arg0:get(),
			modelName = "ammoInDWClip",
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["factions.isCoDCaster"], function(f24_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AmmoWidget_ctfflag.__resetProperties = function(f25_arg0)
	f25_arg0.PanelGlow:completeAnimation()
	f25_arg0.glow:completeAnimation()
	f25_arg0.backplate:completeAnimation()
	f25_arg0.SndItem3:completeAnimation()
	f25_arg0.PanelGlow:setAlpha(0.41)
	f25_arg0.glow:setLeftRight(0, 0, 15, 107)
	f25_arg0.glow:setTopBottom(0, 0, 20.5, 83.5)
	f25_arg0.glow:setRGB(1, 0.17, 0)
	f25_arg0.glow:setAlpha(0.25)
	f25_arg0.glow:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	f25_arg0.backplate:setAlpha(1)
	f25_arg0.SndItem3:setAlpha(1)
end
CoD.AmmoWidget_ctfflag.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(4)
			f26_arg0.backplate:completeAnimation()
			f26_arg0.backplate:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.backplate)
			f26_arg0.glow:completeAnimation()
			f26_arg0.glow:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.glow)
			f26_arg0.SndItem3:completeAnimation()
			f26_arg0.SndItem3:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.SndItem3)
			f26_arg0.PanelGlow:completeAnimation()
			f26_arg0.PanelGlow:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.PanelGlow)
		end,
	},
	Hide = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(4)
			f27_arg0.backplate:completeAnimation()
			f27_arg0.backplate:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.backplate)
			f27_arg0.glow:completeAnimation()
			f27_arg0.glow:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.glow)
			f27_arg0.SndItem3:completeAnimation()
			f27_arg0.SndItem3:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.SndItem3)
			f27_arg0.PanelGlow:completeAnimation()
			f27_arg0.PanelGlow:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.PanelGlow)
		end,
	},
	Show = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(2)
			f28_arg0.glow:completeAnimation()
			f28_arg0.glow:setLeftRight(0, 0, 15, 107)
			f28_arg0.glow:setTopBottom(0, 0, 20.5, 83.5)
			f28_arg0.glow:setRGB(1, 0.17, 0)
			f28_arg0.glow:setAlpha(0.1)
			f28_arg0.glow:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
			f28_arg0.clipFinished(f28_arg0.glow)
			local f28_local0 = function(f29_arg0)
				local f29_local0 = function(f30_arg0)
					f30_arg0:beginAnimation(1000)
					f30_arg0:setAlpha(0.7)
					f30_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
				end
				f28_arg0.PanelGlow:beginAnimation(1000)
				f28_arg0.PanelGlow:setAlpha(0.1)
				f28_arg0.PanelGlow:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.PanelGlow:registerEventHandler("transition_complete_keyframe", f29_local0)
			end
			f28_arg0.PanelGlow:completeAnimation()
			f28_arg0.PanelGlow:setAlpha(0.7)
			f28_local0(f28_arg0.PanelGlow)
			f28_arg0.nextClip = "DefaultClip"
		end,
	},
}
