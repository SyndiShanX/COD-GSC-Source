CoD.zm_arcade_keys = InheritFrom(CoD.Menu)
LUI.createMenu.zm_arcade_keys = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("zm_arcade_keys", f1_arg0)
	local f1_local1 = self
	SetProperty(self, "cachedKeyCount", 0)
	self:setClass(CoD.zm_arcade_keys)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local KeyEmptyBg = LUI.UIImage.new(0, 0, 14.5, 230.5, 0, 0, 69, 151)
	KeyEmptyBg:setImage(RegisterImage(0xC326F68BED7EC04))
	self:addElement(KeyEmptyBg)
	self.KeyEmptyBg = KeyEmptyBg
	local Glow = LUI.UIImage.new(0, 0, 163, 291, 0, 0, 53, 152)
	Glow:setRGB(1, 0.26, 0)
	Glow:setAlpha(0)
	Glow:setImage(RegisterImage(0x5BE416E17DAB33B))
	Glow:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Glow)
	self.Glow = Glow
	local KeyFull = LUI.UIImage.new(0, 0, 43, 151, 0, 0, 86, 138)
	KeyFull:setAlpha(0)
	KeyFull:setImage(RegisterImage(0x92C3826B1AB38D))
	self:addElement(KeyFull)
	self.KeyFull = KeyFull
	local KeyEnabled = LUI.UIImage.new(0, 0, 43, 151, 0, 0, 86, 138)
	KeyEnabled:setImage(RegisterImage(0x92C3826B1AB38D))
	self:addElement(KeyEnabled)
	self.KeyEnabled = KeyEnabled
	local KeyCount = LUI.UIText.new(0, 0, 171.5, 202.5, 0, 0, 95.5, 128.5)
	KeyCount:setText(Engine[0xF9F1239CFD921FE](0x78C6299DB16E268))
	KeyCount:setTTF("skorzhen")
	KeyCount:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	KeyCount:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(KeyCount)
	self.KeyCount = KeyCount
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				local f2_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954])
				if not f2_local0 then
					f2_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40])
					if not f2_local0 then
						f2_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x59333FC97F7870])
						if not f2_local0 then
							f2_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF])
							if not f2_local0 then
								f2_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x198075B069840DC])
								if not f2_local0 then
									f2_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769])
									if not f2_local0 then
										if Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]) then
											f2_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8])
											if not f2_local0 then
												f2_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
												if not f2_local0 then
													f2_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7])
													if not f2_local0 then
														f2_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x6668F0686232679])
														if not f2_local0 then
															f2_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E])
															if not f2_local0 then
																f2_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2])
																if not f2_local0 then
																	f2_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F])
																	if not f2_local0 then
																		f2_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5])
																		if not f2_local0 then
																			f2_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
																			if not f2_local0 then
																				f2_local0 = not Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xBB045E46E88E762])
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
					end
				end
				return f2_local0
			end,
		},
		{
			stateName = "HiddenCopy",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueNilOrZero(element, f1_arg0, "key_count")
			end,
		},
		{
			stateName = "Full",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg0, "key_count", 1)
			end,
		},
	})
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954]], function(f5_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f5_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40]], function(f6_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870]], function(f7_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF]], function(f8_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x1CDCB451655ABCF],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f9_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769]], function(f10_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f11_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8]], function(f12_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f13_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7]], function(f14_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679]], function(f15_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E]], function(f16_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2]], function(f17_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f18_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5]], function(f19_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x4828BED794DA0A5],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]], function(f20_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6],
		})
	end, false)
	f1_local7 = self
	f1_local8 = self.subscribeToModel
	f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local8(f1_local7, f1_local9["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762]], function(f21_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f21_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762],
		})
	end, false)
	self:linkToElementModel(self, "key_count", true, function(model)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "key_count",
		})
	end)
	self:linkToElementModel(self, "key_count", true, function(model)
		local f23_local0 = self
		if CoD.ZombieUtility.IsSelfModelValueGreaterThanCachedValue(f1_arg0, self, "key_count", "cachedKeyCount") and CoD.ModelUtility.IsParamModelGreaterThanOrEqualTo(model, 2) then
			SetElementProperty(f23_local0, "cachedKeyCount", model:get())
			PlayClip(self, "AddKey", f1_arg0)
		elseif not CoD.ZombieUtility.IsSelfModelValueGreaterThanCachedValue(f1_arg0, self, "key_count", "cachedKeyCount") and CoD.ModelUtility.IsParamModelGreaterThanOrEqualTo(model, 1) then
			SetElementProperty(f23_local0, "cachedKeyCount", model:get())
			PlayClip(self, "BurnKey", f1_arg0)
		else
			SetElementProperty(f23_local0, "cachedKeyCount", model:get())
		end
	end)
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	SizeToSafeArea(self, f1_arg0)
	return self
end
CoD.zm_arcade_keys.__resetProperties = function(f24_arg0)
	f24_arg0.KeyCount:completeAnimation()
	f24_arg0.KeyEnabled:completeAnimation()
	f24_arg0.KeyFull:completeAnimation()
	f24_arg0.Glow:completeAnimation()
	f24_arg0.KeyEmptyBg:completeAnimation()
	f24_arg0.KeyCount:setAlpha(1)
	f24_arg0.KeyEnabled:setLeftRight(0, 0, 43, 151)
	f24_arg0.KeyEnabled:setTopBottom(0, 0, 86, 138)
	f24_arg0.KeyEnabled:setAlpha(1)
	f24_arg0.KeyFull:setLeftRight(0, 0, 43, 151)
	f24_arg0.KeyFull:setTopBottom(0, 0, 86, 138)
	f24_arg0.KeyFull:setAlpha(0)
	f24_arg0.Glow:setLeftRight(0, 0, 163, 291)
	f24_arg0.Glow:setTopBottom(0, 0, 53, 152)
	f24_arg0.Glow:setRGB(1, 0.26, 0)
	f24_arg0.Glow:setAlpha(0)
	f24_arg0.KeyEmptyBg:setAlpha(1)
end
CoD.zm_arcade_keys.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(5)
			f26_arg0.KeyEmptyBg:completeAnimation()
			f26_arg0.KeyEmptyBg:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.KeyEmptyBg)
			f26_arg0.Glow:completeAnimation()
			f26_arg0.Glow:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.Glow)
			f26_arg0.KeyFull:completeAnimation()
			f26_arg0.KeyFull:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.KeyFull)
			f26_arg0.KeyEnabled:completeAnimation()
			f26_arg0.KeyEnabled:setTopBottom(0, 0, 26, 78)
			f26_arg0.KeyEnabled:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.KeyEnabled)
			f26_arg0.KeyCount:completeAnimation()
			f26_arg0.KeyCount:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.KeyCount)
		end,
	},
	HiddenCopy = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(5)
			f27_arg0.KeyEmptyBg:completeAnimation()
			f27_arg0.KeyEmptyBg:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.KeyEmptyBg)
			f27_arg0.Glow:completeAnimation()
			f27_arg0.Glow:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.Glow)
			f27_arg0.KeyFull:completeAnimation()
			f27_arg0.KeyFull:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.KeyFull)
			f27_arg0.KeyEnabled:completeAnimation()
			f27_arg0.KeyEnabled:setTopBottom(0, 0, 26, 78)
			f27_arg0.KeyEnabled:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.KeyEnabled)
			f27_arg0.KeyCount:completeAnimation()
			f27_arg0.KeyCount:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.KeyCount)
		end,
		Full = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(4)
			f28_arg0.KeyEmptyBg:completeAnimation()
			f28_arg0.KeyEmptyBg:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.KeyEmptyBg)
			local f28_local0 = function(f29_arg0)
				local f29_local0 = function(f30_arg0)
					f30_arg0:beginAnimation(130)
					f30_arg0:setAlpha(0)
					f30_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
				end
				f28_arg0.Glow:beginAnimation(700)
				f28_arg0.Glow:setLeftRight(0, 0, -34, 278)
				f28_arg0.Glow:setTopBottom(0, 0, 36.5, 165.5)
				f28_arg0.Glow:setAlpha(0.8)
				f28_arg0.Glow:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.Glow:registerEventHandler("transition_complete_keyframe", f29_local0)
			end
			f28_arg0.Glow:completeAnimation()
			f28_arg0.Glow:setLeftRight(0, 0, 735, 1047)
			f28_arg0.Glow:setTopBottom(0, 0, 91.5, 220.5)
			f28_arg0.Glow:setRGB(ColorSet.CoreMartial.r, ColorSet.CoreMartial.g, ColorSet.CoreMartial.b)
			f28_arg0.Glow:setAlpha(1)
			f28_local0(f28_arg0.Glow)
			local f28_local1 = function(f31_arg0)
				local f31_local0 = function(f32_arg0)
					f32_arg0:beginAnimation(130)
					f32_arg0:setAlpha(1)
					f32_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
				end
				f28_arg0.KeyFull:beginAnimation(700)
				f28_arg0.KeyFull:setLeftRight(0, 0, 43, 151)
				f28_arg0.KeyFull:setTopBottom(0, 0, 86, 138)
				f28_arg0.KeyFull:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.KeyFull:registerEventHandler("transition_complete_keyframe", f31_local0)
			end
			f28_arg0.KeyFull:completeAnimation()
			f28_arg0.KeyFull:setLeftRight(0, 0, 41, 186)
			f28_arg0.KeyFull:setTopBottom(0, 0, 69, 139)
			f28_arg0.KeyFull:setAlpha(0)
			f28_local1(f28_arg0.KeyFull)
			local f28_local2 = function(f33_arg0)
				local f33_local0 = function(f34_arg0)
					f34_arg0:beginAnimation(130)
					f34_arg0:setAlpha(0)
					f34_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
				end
				f28_arg0.KeyEnabled:beginAnimation(700)
				f28_arg0.KeyEnabled:setLeftRight(0, 0, 43, 151)
				f28_arg0.KeyEnabled:setTopBottom(0, 0, 86, 138)
				f28_arg0.KeyEnabled:setAlpha(0.7)
				f28_arg0.KeyEnabled:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.KeyEnabled:registerEventHandler("transition_complete_keyframe", f33_local0)
			end
			f28_arg0.KeyEnabled:completeAnimation()
			f28_arg0.KeyEnabled:setLeftRight(0, 0, 779, 1003)
			f28_arg0.KeyEnabled:setTopBottom(0, 0, 97, 205)
			f28_arg0.KeyEnabled:setAlpha(1)
			f28_local2(f28_arg0.KeyEnabled)
		end,
	},
	Full = {
		DefaultClip = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(2)
			f35_arg0.KeyEmptyBg:completeAnimation()
			f35_arg0.KeyEmptyBg:setAlpha(1)
			f35_arg0.clipFinished(f35_arg0.KeyEmptyBg)
			f35_arg0.KeyEnabled:completeAnimation()
			f35_arg0.KeyEnabled:setAlpha(1)
			f35_arg0.clipFinished(f35_arg0.KeyEnabled)
		end,
		AddKey = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(4)
			f36_arg0.KeyEmptyBg:completeAnimation()
			f36_arg0.KeyEmptyBg:setAlpha(1)
			f36_arg0.clipFinished(f36_arg0.KeyEmptyBg)
			local f36_local0 = function(f37_arg0)
				local f37_local0 = function(f38_arg0)
					f38_arg0:beginAnimation(130)
					f38_arg0:setAlpha(0)
					f38_arg0:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
				end
				f36_arg0.Glow:beginAnimation(700)
				f36_arg0.Glow:setLeftRight(0, 0, -34, 278)
				f36_arg0.Glow:setTopBottom(0, 0, 34, 163)
				f36_arg0.Glow:setAlpha(0.8)
				f36_arg0.Glow:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.Glow:registerEventHandler("transition_complete_keyframe", f37_local0)
			end
			f36_arg0.Glow:completeAnimation()
			f36_arg0.Glow:setLeftRight(0, 0, 735, 1047)
			f36_arg0.Glow:setTopBottom(0, 0, 91.5, 220.5)
			f36_arg0.Glow:setRGB(ColorSet.CoreMartial.r, ColorSet.CoreMartial.g, ColorSet.CoreMartial.b)
			f36_arg0.Glow:setAlpha(1)
			f36_local0(f36_arg0.Glow)
			f36_arg0.KeyFull:completeAnimation()
			f36_arg0.KeyFull:setLeftRight(0, 0, 43, 151)
			f36_arg0.KeyFull:setTopBottom(0, 0, 86, 138)
			f36_arg0.KeyFull:setAlpha(1)
			f36_arg0.clipFinished(f36_arg0.KeyFull)
			local f36_local1 = function(f39_arg0)
				local f39_local0 = function(f40_arg0)
					f40_arg0:beginAnimation(130)
					f40_arg0:setAlpha(0)
					f40_arg0:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
				end
				f36_arg0.KeyEnabled:beginAnimation(700)
				f36_arg0.KeyEnabled:setLeftRight(0, 0, 43, 151)
				f36_arg0.KeyEnabled:setTopBottom(0, 0, 86, 138)
				f36_arg0.KeyEnabled:setAlpha(0.7)
				f36_arg0.KeyEnabled:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.KeyEnabled:registerEventHandler("transition_complete_keyframe", f39_local0)
			end
			f36_arg0.KeyEnabled:completeAnimation()
			f36_arg0.KeyEnabled:setLeftRight(0, 0, 779, 1003)
			f36_arg0.KeyEnabled:setTopBottom(0, 0, 97, 205)
			f36_arg0.KeyEnabled:setAlpha(1)
			f36_local1(f36_arg0.KeyEnabled)
		end,
		BurnKey = function(f41_arg0, f41_arg1)
			f41_arg0:__resetProperties()
			f41_arg0:setupElementClipCounter(3)
			f41_arg0.KeyEmptyBg:completeAnimation()
			f41_arg0.KeyEmptyBg:setAlpha(1)
			f41_arg0.clipFinished(f41_arg0.KeyEmptyBg)
			f41_arg0.KeyFull:completeAnimation()
			f41_arg0.KeyFull:setLeftRight(0, 0, 43, 151)
			f41_arg0.KeyFull:setTopBottom(0, 0, 86, 138)
			f41_arg0.KeyFull:setAlpha(1)
			f41_arg0.clipFinished(f41_arg0.KeyFull)
			local f41_local0 = function(f42_arg0)
				f41_arg0.KeyEnabled:beginAnimation(1000)
				f41_arg0.KeyEnabled:setTopBottom(0, 0, 222, 274)
				f41_arg0.KeyEnabled:setAlpha(0)
				f41_arg0.KeyEnabled:registerEventHandler("interrupted_keyframe", f41_arg0.clipInterrupted)
				f41_arg0.KeyEnabled:registerEventHandler("transition_complete_keyframe", f41_arg0.clipFinished)
			end
			f41_arg0.KeyEnabled:completeAnimation()
			f41_arg0.KeyEnabled:setLeftRight(0, 0, 43, 151)
			f41_arg0.KeyEnabled:setTopBottom(0, 0, 86, 138)
			f41_arg0.KeyEnabled:setAlpha(1)
			f41_local0(f41_arg0.KeyEnabled)
		end,
		HiddenCopy = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties()
			f43_arg0:setupElementClipCounter(3)
			local f43_local0 = function(f44_arg0)
				f43_arg0.KeyEmptyBg:beginAnimation(1000)
				f43_arg0.KeyEmptyBg:setAlpha(0)
				f43_arg0.KeyEmptyBg:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.KeyEmptyBg:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
			end
			f43_arg0.KeyEmptyBg:completeAnimation()
			f43_arg0.KeyEmptyBg:setAlpha(1)
			f43_local0(f43_arg0.KeyEmptyBg)
			local f43_local1 = function(f45_arg0)
				f43_arg0.KeyFull:beginAnimation(1000)
				f43_arg0.KeyFull:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.KeyFull:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
			end
			f43_arg0.KeyFull:completeAnimation()
			f43_arg0.KeyFull:setLeftRight(0, 0, 43, 151)
			f43_arg0.KeyFull:setTopBottom(0, 0, 86, 138)
			f43_arg0.KeyFull:setAlpha(0)
			f43_local1(f43_arg0.KeyFull)
			local f43_local2 = function(f46_arg0)
				f43_arg0.KeyEnabled:beginAnimation(1000)
				f43_arg0.KeyEnabled:setTopBottom(0, 0, 283.5, 353.5)
				f43_arg0.KeyEnabled:setAlpha(0)
				f43_arg0.KeyEnabled:registerEventHandler("interrupted_keyframe", f43_arg0.clipInterrupted)
				f43_arg0.KeyEnabled:registerEventHandler("transition_complete_keyframe", f43_arg0.clipFinished)
			end
			f43_arg0.KeyEnabled:completeAnimation()
			f43_arg0.KeyEnabled:setLeftRight(0, 0, 43, 151)
			f43_arg0.KeyEnabled:setTopBottom(0, 0, 86, 138)
			f43_arg0.KeyEnabled:setAlpha(1)
			f43_local2(f43_arg0.KeyEnabled)
		end,
	},
}
CoD.zm_arcade_keys.__onClose = function(f47_arg0) end
