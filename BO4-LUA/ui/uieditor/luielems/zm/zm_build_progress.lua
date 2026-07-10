CoD.zm_build_progress = InheritFrom(CoD.Menu)
LUI.createMenu.zm_build_progress = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("zm_build_progress", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.zm_build_progress)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local backing = LUI.UIImage.new(0.5, 0.5, -140, 140, 0.5, 0.5, -150, -130)
	backing:setRGB(0, 0, 0)
	backing:setAlpha(0.6)
	self:addElement(backing)
	self.backing = backing
	local fill = LUI.UIImage.new(0.5, 0.5, -135, 135, 0.5, 0.5, -150, -130)
	fill:setImage(RegisterImage(0x72AF76649EA8E9B))
	fill:setMaterial(LUI.UIImage.GetCachedMaterial(0x316E67E1DF2198E))
	fill:setShaderVector(1, 0, 0, 0, 0)
	fill:setShaderVector(2, 1, 0, 0, 0)
	fill:setShaderVector(3, 0, 0, 0, 0)
	fill:setShaderVector(4, 0, 0, 0, 0)
	fill:linkToElementModel(self, "progress", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			fill:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(fill)
	self.fill = fill
	local text = LUI.UIText.new(0.5, 0.5, -960, 960, 0.5, 0.5, -192.5, -155.5)
	text:setText(Engine[0xF9F1239CFD921FE](0xA6866A0DC9013F8))
	text:setTTF("default")
	text:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	text:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(text)
	self.text = text
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				local f3_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954])
				if not f3_local0 then
					f3_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40])
					if not f3_local0 then
						f3_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x59333FC97F7870])
						if not f3_local0 then
							f3_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769])
							if not f3_local0 then
								if Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]) then
									f3_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8])
									if not f3_local0 then
										f3_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
										if not f3_local0 then
											f3_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7])
											if not f3_local0 then
												f3_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E])
												if not f3_local0 then
													f3_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x6668F0686232679])
													if not f3_local0 then
														f3_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E])
														if not f3_local0 then
															f3_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2])
															if not f3_local0 then
																f3_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F])
																if not f3_local0 then
																	f3_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
																	if not f3_local0 then
																		f3_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
																		if not f3_local0 then
																			f3_local0 = not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xBB045E46E88E762])
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
									f3_local0 = true
								end
							end
						end
					end
				end
				return f3_local0
			end,
		},
	})
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954]], function(f4_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f4_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40]], function(f5_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f5_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870]], function(f6_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769]], function(f7_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f8_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8]], function(f9_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f10_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7]], function(f11_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E]], function(f12_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679]], function(f13_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E]], function(f14_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2]], function(f15_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f16_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f17_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]], function(f18_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6],
		})
	end, false)
	f1_local5 = self
	f1_local6 = self.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local6(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762]], function(f19_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762],
		})
	end, false)
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.zm_build_progress.__resetProperties = function(f20_arg0)
	f20_arg0.text:completeAnimation()
	f20_arg0.fill:completeAnimation()
	f20_arg0.backing:completeAnimation()
	f20_arg0.text:setAlpha(1)
	f20_arg0.fill:setAlpha(1)
	f20_arg0.backing:setAlpha(0.6)
end
CoD.zm_build_progress.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(3)
			f22_arg0.backing:completeAnimation()
			f22_arg0.backing:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.backing)
			f22_arg0.fill:completeAnimation()
			f22_arg0.fill:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.fill)
			f22_arg0.text:completeAnimation()
			f22_arg0.text:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.text)
		end,
	},
}
CoD.zm_build_progress.__onClose = function(f23_arg0)
	f23_arg0.fill:close()
end
