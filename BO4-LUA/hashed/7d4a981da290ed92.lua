require("x64:d91c3fc92dc2355")
require("x64:5677da2fba4b1c9")
CoD.ZM_Trials_Title_Splash = InheritFrom(LUI.UIElement)
CoD.ZM_Trials_Title_Splash.__defaultWidth = 1920
CoD.ZM_Trials_Title_Splash.__defaultHeight = 230
CoD.ZM_Trials_Title_Splash.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZM_Trials_Title_Splash)
	self.id = "ZM_Trials_Title_Splash"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DescriptionDivider = LUI.UIImage.new(0, 0, 672, 1248, 0, 0, 181, 183)
	DescriptionDivider:setRGB(0.96, 0.67, 0)
	self:addElement(DescriptionDivider)
	self.DescriptionDivider = DescriptionDivider
	local RoundDescriptionText = LUI.UIText.new(0, 0, 0, 1920, 0, 0, 195, 228)
	RoundDescriptionText:setTTF("dinnext_regular")
	RoundDescriptionText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	RoundDescriptionText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	RoundDescriptionText:subscribeToGlobalModel(f1_arg1, "ZMHudGlobal", "trials.roundDescription", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			RoundDescriptionText:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(RoundDescriptionText)
	self.RoundDescriptionText = RoundDescriptionText
	local RoundTitleText = LUI.UIText.new(0, 0, 0, 1920, 0, 0, 112, 179)
	RoundTitleText:setRGB(0.96, 0.67, 0)
	RoundTitleText:setTTF("skorzhen")
	RoundTitleText:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	RoundTitleText:setShaderVector(0, 0.02, 0, 0, 0)
	RoundTitleText:setShaderVector(1, 0.04, 0, 0, 0)
	RoundTitleText:setShaderVector(2, 0, 0, 0, 1)
	RoundTitleText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	RoundTitleText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	RoundTitleText:subscribeToGlobalModel(f1_arg1, "ZMHudGlobal", "trials.roundTitle", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			RoundTitleText:setText(Engine[0xF9F1239CFD921FE](f3_local0))
		end
	end)
	self:addElement(RoundTitleText)
	self.RoundTitleText = RoundTitleText
	local ZmRndContainer = CoD.ZmRndContainer.new(f1_arg0, f1_arg1, 0, 0, 820.5, 1156.5, 0, 0, -85.5, 141.5)
	ZmRndContainer:mergeStateConditions({
		{
			stateName = "TrialsShow",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsAnyGameType(f1_arg1, "ztrials")
			end,
		},
	})
	local f1_local5 = ZmRndContainer
	local ZMTitleFog = ZmRndContainer.subscribeToModel
	local f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMTitleFog(f1_local5, f1_local7["hudItems.playerSpawned"], function(f5_arg0)
		f1_arg0:updateElementState(ZmRndContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "hudItems.playerSpawned",
		})
	end, false)
	f1_local5 = ZmRndContainer
	ZMTitleFog = ZmRndContainer.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMTitleFog(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954]], function(f6_arg0)
		f1_arg0:updateElementState(ZmRndContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xB8E9B69F4B87954],
		})
	end, false)
	f1_local5 = ZmRndContainer
	ZMTitleFog = ZmRndContainer.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMTitleFog(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40]], function(f7_arg0)
		f1_arg0:updateElementState(ZmRndContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD3ABF9A2753CE40],
		})
	end, false)
	f1_local5 = ZmRndContainer
	ZMTitleFog = ZmRndContainer.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMTitleFog(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870]], function(f8_arg0)
		f1_arg0:updateElementState(ZmRndContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x59333FC97F7870],
		})
	end, false)
	f1_local5 = ZmRndContainer
	ZMTitleFog = ZmRndContainer.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMTitleFog(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769]], function(f9_arg0)
		f1_arg0:updateElementState(ZmRndContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f9_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x69C28E2FCA82769],
		})
	end, false)
	f1_local5 = ZmRndContainer
	ZMTitleFog = ZmRndContainer.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMTitleFog(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7]], function(f10_arg0)
		f1_arg0:updateElementState(ZmRndContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f10_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xADC477DDE486DD7],
		})
	end, false)
	f1_local5 = ZmRndContainer
	ZMTitleFog = ZmRndContainer.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMTitleFog(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8]], function(f11_arg0)
		f1_arg0:updateElementState(ZmRndContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x23CD9BAB9B9F4C8],
		})
	end, false)
	f1_local5 = ZmRndContainer
	ZMTitleFog = ZmRndContainer.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMTitleFog(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2]], function(f12_arg0)
		f1_arg0:updateElementState(ZmRndContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x8A5E996D4528DA2],
		})
	end, false)
	f1_local5 = ZmRndContainer
	ZMTitleFog = ZmRndContainer.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMTitleFog(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7]], function(f13_arg0)
		f1_arg0:updateElementState(ZmRndContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x7B52A87BC9AA4C7],
		})
	end, false)
	f1_local5 = ZmRndContainer
	ZMTitleFog = ZmRndContainer.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMTitleFog(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E]], function(f14_arg0)
		f1_arg0:updateElementState(ZmRndContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x9BF57CE75A8755E],
		})
	end, false)
	f1_local5 = ZmRndContainer
	ZMTitleFog = ZmRndContainer.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMTitleFog(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679]], function(f15_arg0)
		f1_arg0:updateElementState(ZmRndContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x6668F0686232679],
		})
	end, false)
	f1_local5 = ZmRndContainer
	ZMTitleFog = ZmRndContainer.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMTitleFog(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E]], function(f16_arg0)
		f1_arg0:updateElementState(ZmRndContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f16_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x3AEEAA452536E6E],
		})
	end, false)
	f1_local5 = ZmRndContainer
	ZMTitleFog = ZmRndContainer.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMTitleFog(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2]], function(f17_arg0)
		f1_arg0:updateElementState(ZmRndContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f17_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xD298E43D0B6FEF2],
		})
	end, false)
	f1_local5 = ZmRndContainer
	ZMTitleFog = ZmRndContainer.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMTitleFog(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F]], function(f18_arg0)
		f1_arg0:updateElementState(ZmRndContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x24E603C16FCC38F],
		})
	end, false)
	f1_local5 = ZmRndContainer
	ZMTitleFog = ZmRndContainer.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMTitleFog(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function(f19_arg0)
		f1_arg0:updateElementState(ZmRndContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04],
		})
	end, false)
	f1_local5 = ZmRndContainer
	ZMTitleFog = ZmRndContainer.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMTitleFog(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]], function(f20_arg0)
		f1_arg0:updateElementState(ZmRndContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f20_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6],
		})
	end, false)
	f1_local5 = ZmRndContainer
	ZMTitleFog = ZmRndContainer.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMTitleFog(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762]], function(f21_arg0)
		f1_arg0:updateElementState(ZmRndContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f21_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xBB045E46E88E762],
		})
	end, false)
	f1_local5 = ZmRndContainer
	ZMTitleFog = ZmRndContainer.subscribeToModel
	f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	ZMTitleFog(f1_local5, f1_local7["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f22_arg0)
		f1_arg0:updateElementState(ZmRndContainer, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f22_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC],
		})
	end, false)
	self:addElement(ZmRndContainer)
	self.ZmRndContainer = ZmRndContainer
	ZMTitleFog = CoD.ZM_Title_Fog.new(f1_arg0, f1_arg1, 0, 0, 691, 1203, 0, 0, -166, 346)
	ZMTitleFog:setAlpha(0)
	ZMTitleFog:setScale(1.5, 0.8)
	self:addElement(ZMTitleFog)
	self.ZMTitleFog = ZMTitleFog
	self:mergeStateConditions({
		{
			stateName = "Show",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueTrue("ZMHudGlobal.trials.roundSplashPlay")
			end,
		},
	})
	f1_local7 = self
	f1_local5 = self.subscribeToModel
	local f1_local8 = Engine[0x8DF2E5447F384B9]()
	f1_local5(f1_local7, f1_local8["ZMHudGlobal.trials.roundSplashPlay"], function(f24_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "ZMHudGlobal.trials.roundSplashPlay",
		})
	end, false)
	self:subscribeToGlobalModel(f1_arg1, "ZMHudGlobal", "trials.roundSplashPlay", function(model)
		local f25_local0 = self
		if CoD.ModelUtility.IsGlobalModelValueTrue("ZMHudGlobal.trials.roundSplashPlay") then
			SetState(self, "Show", f1_arg1)
			PlayClip(self, "DefaultClip", f1_arg1)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZM_Trials_Title_Splash.__resetProperties = function(f26_arg0)
	f26_arg0.RoundTitleText:completeAnimation()
	f26_arg0.RoundDescriptionText:completeAnimation()
	f26_arg0.DescriptionDivider:completeAnimation()
	f26_arg0.ZmRndContainer:completeAnimation()
	f26_arg0.ZMTitleFog:completeAnimation()
	f26_arg0.RoundTitleText:setLeftRight(0, 0, 0, 1920)
	f26_arg0.RoundTitleText:setTopBottom(0, 0, 112, 179)
	f26_arg0.RoundTitleText:setAlpha(1)
	f26_arg0.RoundTitleText:setScale(1, 1)
	f26_arg0.RoundDescriptionText:setLeftRight(0, 0, 0, 1920)
	f26_arg0.RoundDescriptionText:setTopBottom(0, 0, 195, 228)
	f26_arg0.RoundDescriptionText:setAlpha(1)
	f26_arg0.RoundDescriptionText:setScale(1, 1)
	f26_arg0.DescriptionDivider:setAlpha(1)
	f26_arg0.ZmRndContainer:setLeftRight(0, 0, 820.5, 1156.5)
	f26_arg0.ZmRndContainer:setAlpha(1)
	f26_arg0.ZmRndContainer:setScale(1, 1)
	f26_arg0.ZMTitleFog:setTopBottom(0, 0, -166, 346)
	f26_arg0.ZMTitleFog:setAlpha(0)
	f26_arg0.ZMTitleFog:setScale(1.5, 0.8)
end
CoD.ZM_Trials_Title_Splash.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(4)
			f27_arg0.DescriptionDivider:completeAnimation()
			f27_arg0.DescriptionDivider:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.DescriptionDivider)
			f27_arg0.RoundDescriptionText:completeAnimation()
			f27_arg0.RoundDescriptionText:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.RoundDescriptionText)
			f27_arg0.RoundTitleText:completeAnimation()
			f27_arg0.RoundTitleText:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.RoundTitleText)
			f27_arg0.ZmRndContainer:completeAnimation()
			f27_arg0.ZmRndContainer:setAlpha(0)
			f27_arg0.clipFinished(f27_arg0.ZmRndContainer)
		end,
	},
	Show = {
		DefaultClip = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(5)
			local f28_local0 = function(f29_arg0)
				local f29_local0 = function(f30_arg0)
					local f30_local0 = function(f31_arg0)
						local f31_local0 = function(f32_arg0)
							local f32_local0 = function(f33_arg0)
								local f33_local0 = function(f34_arg0)
									f34_arg0:beginAnimation(439)
									f34_arg0:setAlpha(0)
									f34_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
								end
								f33_arg0:beginAnimation(510)
								f33_arg0:registerEventHandler("transition_complete_keyframe", f33_local0)
							end
							f32_arg0:beginAnimation(2110)
							f32_arg0:registerEventHandler("transition_complete_keyframe", f32_local0)
						end
						f31_arg0:beginAnimation(3639)
						f31_arg0:registerEventHandler("transition_complete_keyframe", f31_local0)
					end
					f30_arg0:beginAnimation(1040)
					f30_arg0:setAlpha(1)
					f30_arg0:registerEventHandler("transition_complete_keyframe", f30_local0)
				end
				f28_arg0.DescriptionDivider:beginAnimation(1960)
				f28_arg0.DescriptionDivider:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.DescriptionDivider:registerEventHandler("transition_complete_keyframe", f29_local0)
			end
			f28_arg0.DescriptionDivider:completeAnimation()
			f28_arg0.DescriptionDivider:setAlpha(0)
			f28_local0(f28_arg0.DescriptionDivider)
			local f28_local1 = function(f35_arg0)
				local f35_local0 = function(f36_arg0)
					local f36_local0 = function(f37_arg0)
						local f37_local0 = function(f38_arg0)
							local f38_local0 = function(f39_arg0)
								f39_arg0:beginAnimation(439)
								f39_arg0:setAlpha(0)
								f39_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
							end
							f38_arg0:beginAnimation(510)
							f38_arg0:registerEventHandler("transition_complete_keyframe", f38_local0)
						end
						f37_arg0:beginAnimation(5750)
						f37_arg0:registerEventHandler("transition_complete_keyframe", f37_local0)
					end
					f36_arg0:beginAnimation(1040, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f36_arg0:setAlpha(1)
					f36_arg0:registerEventHandler("transition_complete_keyframe", f36_local0)
				end
				f28_arg0.RoundDescriptionText:beginAnimation(1960)
				f28_arg0.RoundDescriptionText:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.RoundDescriptionText:registerEventHandler("transition_complete_keyframe", f35_local0)
			end
			f28_arg0.RoundDescriptionText:completeAnimation()
			f28_arg0.RoundDescriptionText:setLeftRight(0, 0, 0, 1920)
			f28_arg0.RoundDescriptionText:setTopBottom(0, 0, 197, 230)
			f28_arg0.RoundDescriptionText:setAlpha(0)
			f28_arg0.RoundDescriptionText:setScale(1, 1)
			f28_local1(f28_arg0.RoundDescriptionText)
			local f28_local2 = function(f40_arg0)
				local f40_local0 = function(f41_arg0)
					local f41_local0 = function(f42_arg0)
						local f42_local0 = function(f43_arg0)
							local f43_local0 = function(f44_arg0)
								f44_arg0:beginAnimation(439)
								f44_arg0:setAlpha(0)
								f44_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
							end
							f43_arg0:beginAnimation(510)
							f43_arg0:registerEventHandler("transition_complete_keyframe", f43_local0)
						end
						f42_arg0:beginAnimation(5750)
						f42_arg0:registerEventHandler("transition_complete_keyframe", f42_local0)
					end
					f41_arg0:beginAnimation(1040)
					f41_arg0:setAlpha(1)
					f41_arg0:registerEventHandler("transition_complete_keyframe", f41_local0)
				end
				f28_arg0.RoundTitleText:beginAnimation(1960)
				f28_arg0.RoundTitleText:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.RoundTitleText:registerEventHandler("transition_complete_keyframe", f40_local0)
			end
			f28_arg0.RoundTitleText:completeAnimation()
			f28_arg0.RoundTitleText:setLeftRight(0, 0, 0, 1920)
			f28_arg0.RoundTitleText:setTopBottom(0, 0, 114, 181)
			f28_arg0.RoundTitleText:setAlpha(0)
			f28_arg0.RoundTitleText:setScale(1, 1)
			f28_local2(f28_arg0.RoundTitleText)
			local f28_local3 = function(f45_arg0)
				local f45_local0 = function(f46_arg0)
					local f46_local0 = function(f47_arg0)
						local f47_local0 = function(f48_arg0)
							f48_arg0:beginAnimation(819)
							f48_arg0:setAlpha(0)
							f48_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
						end
						f47_arg0:beginAnimation(6250)
						f47_arg0:registerEventHandler("transition_complete_keyframe", f47_local0)
					end
					f46_arg0:beginAnimation(1310)
					f46_arg0:setAlpha(1)
					f46_arg0:registerEventHandler("transition_complete_keyframe", f46_local0)
				end
				f28_arg0.ZmRndContainer:beginAnimation(1190)
				f28_arg0.ZmRndContainer:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.ZmRndContainer:registerEventHandler("transition_complete_keyframe", f45_local0)
			end
			f28_arg0.ZmRndContainer:completeAnimation()
			f28_arg0.ZmRndContainer:setLeftRight(0, 0, 820.5, 1156.5)
			f28_arg0.ZmRndContainer:setAlpha(0)
			f28_arg0.ZmRndContainer:setScale(1, 1)
			f28_local3(f28_arg0.ZmRndContainer)
			local f28_local4 = function(f49_arg0)
				local f49_local0 = function(f50_arg0)
					local f50_local0 = function(f51_arg0)
						local f51_local0 = function(f52_arg0)
							local f52_local0 = function(f53_arg0)
								f53_arg0:beginAnimation(1619)
								f53_arg0:setAlpha(0)
								f53_arg0:setScale(1.8, 0.6)
								f53_arg0:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
							end
							f52_arg0:beginAnimation(920)
							f52_arg0:setAlpha(1)
							f52_arg0:setScale(1.6, 0.9)
							f52_arg0:registerEventHandler("transition_complete_keyframe", f52_local0)
						end
						f51_arg0:beginAnimation(5460)
						f51_arg0:setAlpha(0.2)
						f51_arg0:setScale(1.59, 0.8)
						f51_arg0:registerEventHandler("transition_complete_keyframe", f51_local0)
					end
					f50_arg0:beginAnimation(1730)
					f50_arg0:setAlpha(0)
					f50_arg0:setScale(1.52, 0.8)
					f50_arg0:registerEventHandler("transition_complete_keyframe", f50_local0)
				end
				f28_arg0.ZMTitleFog:beginAnimation(1270)
				f28_arg0.ZMTitleFog:setAlpha(1)
				f28_arg0.ZMTitleFog:setScale(1.5, 0.8)
				f28_arg0.ZMTitleFog:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.ZMTitleFog:registerEventHandler("transition_complete_keyframe", f49_local0)
			end
			f28_arg0.ZMTitleFog:completeAnimation()
			f28_arg0.ZMTitleFog:setTopBottom(0, 0, -103, 321)
			f28_arg0.ZMTitleFog:setAlpha(0)
			f28_arg0.ZMTitleFog:setScale(1.5, 0.6)
			f28_local4(f28_arg0.ZMTitleFog)
		end,
	},
}
CoD.ZM_Trials_Title_Splash.__onClose = function(f54_arg0)
	f54_arg0.RoundDescriptionText:close()
	f54_arg0.RoundTitleText:close()
	f54_arg0.ZmRndContainer:close()
	f54_arg0.ZMTitleFog:close()
end
