require("x64:ad2dd10539beaf7")
CoD.mp_laststand_client = InheritFrom(CoD.Menu)
LUI.createMenu.mp_laststand_client = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("mp_laststand_client", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.mp_laststand_client)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local DecorativeBGAnim = CoD.Hud_ZM_LastStand_DecorativeBGInternal.new(f1_local1, f1_arg0, 0, 0, 872, 1048, 0, 0, 667, 843)
	DecorativeBGAnim:setRGB(0, 0, 0)
	self:addElement(DecorativeBGAnim)
	self.DecorativeBGAnim = DecorativeBGAnim
	local bleedout_clock = LUI.UIImage.new(0.5, 0.5, -128, 0, 1, 1, -268.5, -140.5)
	bleedout_clock:setRGB(1, 0, 0)
	bleedout_clock:setAlpha(0.9)
	bleedout_clock:setMaterial(LUI.UIImage.GetCachedMaterial(0xD5CA1A25ED87F4F))
	bleedout_clock:setShaderVector(0, -0.03, 0, 0, 0)
	bleedout_clock:setShaderVector(1, 0.5, 0, 0, 0)
	bleedout_clock:setShaderVector(2, 0.5, 0, 0, 0)
	bleedout_clock:setShaderVector(3, 0.18, 0, 0, 0)
	bleedout_clock:setShaderVector(4, 4, 0.04, 0, 0)
	self:addElement(bleedout_clock)
	self.bleedout_clock = bleedout_clock
	local revive_clock = LUI.UIImage.new(0.5, 0.5, 0, 136, 1, 1, -268.5, -140.5)
	revive_clock:setRGB(0.12, 1, 0)
	revive_clock:setYRot(180)
	revive_clock:setMaterial(LUI.UIImage.GetCachedMaterial(0xD5CA1A25ED87F4F))
	revive_clock:setShaderVector(0, -0.21, 0, 0, 0)
	revive_clock:setShaderVector(1, 0.5, 0, 0, 0)
	revive_clock:setShaderVector(2, 0.5, 0, 0, 0)
	revive_clock:setShaderVector(3, 0, 0, 0, 0)
	revive_clock:setShaderVector(4, 0, 0.06, 0, 0)
	self:addElement(revive_clock)
	self.revive_clock = revive_clock
	local bleedout_label = LUI.UIText.new(0, 0, 860, 1060, 0, 0, 709.5, 739.5)
	bleedout_label:setText(Engine[0xF9F1239CFD921FE](0x5F0B7103756F36))
	bleedout_label:setTTF("0arame_mono_stencil")
	bleedout_label:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	bleedout_label:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(bleedout_label)
	self.bleedout_label = bleedout_label
	local ReviveBarBG2 = LUI.UIImage.new(0.5, 0.5, -148, 148, 0, 0, 760, 788)
	ReviveBarBG2:setAlpha(0)
	ReviveBarBG2:setYRot(180)
	ReviveBarBG2:setScale(0.81, 0.6)
	ReviveBarBG2:setImage(RegisterImage(0x7B21FDA82833F75))
	self:addElement(ReviveBarBG2)
	self.ReviveBarBG2 = ReviveBarBG2
	local revive_bar = LUI.UIImage.new(0.5, 0.5, -148, 148, 0, 0, 760, 788)
	revive_bar:setAlpha(0)
	revive_bar:setScale(0.8, 0.6)
	revive_bar:setImage(RegisterImage(0x7C02FDA828F9801))
	revive_bar:setMaterial(LUI.UIImage.GetCachedMaterial(0x316E67E1DF2198E))
	revive_bar:setShaderVector(1, 0, 0, 0, 0)
	revive_bar:setShaderVector(2, 1, 0, 0, 0)
	revive_bar:setShaderVector(3, 0, 0, 0, 0)
	revive_bar:setShaderVector(4, 0, 0, 0, 0)
	revive_bar:linkToElementModel(self, "revive_progress", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			revive_bar:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(revive_bar)
	self.revive_bar = revive_bar
	local ReviveBarBG = LUI.UIImage.new(0.5, 0.5, -148, 148, 0, 0, 740, 768)
	ReviveBarBG:setImage(RegisterImage(0x7B21FDA82833F75))
	self:addElement(ReviveBarBG)
	self.ReviveBarBG = ReviveBarBG
	local bleedout_bar = LUI.UIImage.new(0.5, 0.5, -148, 148, 0, 0, 740, 768)
	bleedout_bar:setImage(RegisterImage(0x396E2656C26F8BC))
	bleedout_bar:setMaterial(LUI.UIImage.GetCachedMaterial(0x316E67E1DF2198E))
	bleedout_bar:setShaderVector(1, 0, 0, 0, 0)
	bleedout_bar:setShaderVector(2, 1, 0, 0, 0)
	bleedout_bar:setShaderVector(3, 0, 0, 0, 0)
	bleedout_bar:setShaderVector(4, 0, 0.02, 0.05, 0)
	bleedout_bar:linkToElementModel(self, "bleedout_progress", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			bleedout_bar:setShaderVector(0, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4))
		end
	end)
	self:addElement(bleedout_bar)
	self.bleedout_bar = bleedout_bar
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				local f4_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954])
				if not f4_local0 then
					f4_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40])
					if not f4_local0 then
						f4_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x198075B069840DC])
						if not f4_local0 then
							if Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]) then
								f4_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8])
								if not f4_local0 then
									f4_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2])
									if not f4_local0 then
										f4_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04])
										if not f4_local0 then
											f4_local0 = Engine[0xDD333420C49E6D0](f1_arg0, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6])
										end
									end
								end
							else
								f4_local0 = true
							end
						end
					end
				end
				return f4_local0
			end,
		},
		{
			stateName = "Revive",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg0, "revive_progress", 0)
			end,
		},
	})
	local f1_local10 = self
	local f1_local11 = self.subscribeToModel
	local f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local11(f1_local10, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954]], function(f6_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954],
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local11(f1_local10, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40]], function(f7_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40],
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local11(f1_local10, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f8_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local11(f1_local10, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f9_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local11(f1_local10, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8]], function(f10_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8],
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local11(f1_local10, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f11_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local11(f1_local10, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f12_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	f1_local10 = self
	f1_local11 = self.subscribeToModel
	f1_local12 = Engine[0x4DF5CFBC1771947](f1_arg0)
	f1_local11(f1_local10, f1_local12["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]], function(f13_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6],
		})
	end, false)
	self:linkToElementModel(self, "revive_progress", true, function(model)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = model:get(),
			modelName = "revive_progress",
		})
	end)
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
CoD.mp_laststand_client.__resetProperties = function(f15_arg0)
	f15_arg0.DecorativeBGAnim:completeAnimation()
	f15_arg0.bleedout_bar:completeAnimation()
	f15_arg0.ReviveBarBG:completeAnimation()
	f15_arg0.bleedout_label:completeAnimation()
	f15_arg0.revive_clock:completeAnimation()
	f15_arg0.bleedout_clock:completeAnimation()
	f15_arg0.revive_bar:completeAnimation()
	f15_arg0.ReviveBarBG2:completeAnimation()
	f15_arg0.DecorativeBGAnim:setAlpha(1)
	f15_arg0.DecorativeBGAnim:setScale(1, 1)
	f15_arg0.bleedout_bar:setAlpha(1)
	f15_arg0.bleedout_bar:setScale(1, 1)
	f15_arg0.ReviveBarBG:setAlpha(1)
	f15_arg0.ReviveBarBG:setScale(1, 1)
	f15_arg0.bleedout_label:setAlpha(1)
	f15_arg0.bleedout_label:setScale(1, 1)
	f15_arg0.revive_clock:setAlpha(1)
	f15_arg0.bleedout_clock:setAlpha(0.9)
	f15_arg0.revive_bar:setAlpha(0)
	f15_arg0.revive_bar:setScale(0.8, 0.6)
	f15_arg0.ReviveBarBG2:setAlpha(0)
	f15_arg0.ReviveBarBG2:setScale(0.81, 0.6)
end
CoD.mp_laststand_client.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(4)
			local f16_local0 = function(f17_arg0)
				f16_arg0.DecorativeBGAnim:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f16_arg0.DecorativeBGAnim:setAlpha(1)
				f16_arg0.DecorativeBGAnim:setScale(1, 1)
				f16_arg0.DecorativeBGAnim:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.DecorativeBGAnim:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.DecorativeBGAnim:completeAnimation()
			f16_arg0.DecorativeBGAnim:setAlpha(0)
			f16_arg0.DecorativeBGAnim:setScale(2, 2)
			f16_local0(f16_arg0.DecorativeBGAnim)
			local f16_local1 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					f19_arg0:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f19_arg0:setAlpha(1)
					f19_arg0:setScale(1, 1)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
				end
				f16_arg0.bleedout_label:beginAnimation(100)
				f16_arg0.bleedout_label:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.bleedout_label:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f16_arg0.bleedout_label:completeAnimation()
			f16_arg0.bleedout_label:setAlpha(0)
			f16_arg0.bleedout_label:setScale(2, 2)
			f16_local1(f16_arg0.bleedout_label)
			local f16_local2 = function(f20_arg0)
				local f20_local0 = function(f21_arg0)
					f21_arg0:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f21_arg0:setAlpha(1)
					f21_arg0:setScale(1, 1)
					f21_arg0:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
				end
				f16_arg0.ReviveBarBG:beginAnimation(200)
				f16_arg0.ReviveBarBG:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.ReviveBarBG:registerEventHandler("transition_complete_keyframe", f20_local0)
			end
			f16_arg0.ReviveBarBG:completeAnimation()
			f16_arg0.ReviveBarBG:setAlpha(0)
			f16_arg0.ReviveBarBG:setScale(2, 2)
			f16_local2(f16_arg0.ReviveBarBG)
			local f16_local3 = function(f22_arg0)
				local f22_local0 = function(f23_arg0)
					f23_arg0:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f23_arg0:setAlpha(1)
					f23_arg0:setScale(1, 1)
					f23_arg0:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
				end
				f16_arg0.bleedout_bar:beginAnimation(200)
				f16_arg0.bleedout_bar:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.bleedout_bar:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f16_arg0.bleedout_bar:completeAnimation()
			f16_arg0.bleedout_bar:setAlpha(0)
			f16_arg0.bleedout_bar:setScale(2, 2)
			f16_local3(f16_arg0.bleedout_bar)
		end,
	},
	Hidden = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(6)
			f24_arg0.DecorativeBGAnim:completeAnimation()
			f24_arg0.DecorativeBGAnim:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.DecorativeBGAnim)
			f24_arg0.bleedout_clock:completeAnimation()
			f24_arg0.bleedout_clock:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.bleedout_clock)
			f24_arg0.revive_clock:completeAnimation()
			f24_arg0.revive_clock:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.revive_clock)
			f24_arg0.bleedout_label:completeAnimation()
			f24_arg0.bleedout_label:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.bleedout_label)
			f24_arg0.ReviveBarBG:completeAnimation()
			f24_arg0.ReviveBarBG:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.ReviveBarBG)
			f24_arg0.bleedout_bar:completeAnimation()
			f24_arg0.bleedout_bar:setAlpha(0)
			f24_arg0.clipFinished(f24_arg0.bleedout_bar)
		end,
	},
	Revive = {
		DefaultClip = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(2)
			local f25_local0 = function(f26_arg0)
				f25_arg0.ReviveBarBG2:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f25_arg0.ReviveBarBG2:setAlpha(1)
				f25_arg0.ReviveBarBG2:setScale(0.81, 0.6)
				f25_arg0.ReviveBarBG2:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.ReviveBarBG2:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.ReviveBarBG2:completeAnimation()
			f25_arg0.ReviveBarBG2:setAlpha(0)
			f25_arg0.ReviveBarBG2:setScale(1.62, 1.2)
			f25_local0(f25_arg0.ReviveBarBG2)
			local f25_local1 = function(f27_arg0)
				f25_arg0.revive_bar:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f25_arg0.revive_bar:setAlpha(1)
				f25_arg0.revive_bar:setScale(0.8, 0.6)
				f25_arg0.revive_bar:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.revive_bar:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.revive_bar:completeAnimation()
			f25_arg0.revive_bar:setAlpha(0)
			f25_arg0.revive_bar:setScale(1.6, 1.2)
			f25_local1(f25_arg0.revive_bar)
		end,
	},
}
CoD.mp_laststand_client.__onClose = function(f28_arg0)
	f28_arg0.DecorativeBGAnim:close()
	f28_arg0.revive_bar:close()
	f28_arg0.bleedout_bar:close()
end
