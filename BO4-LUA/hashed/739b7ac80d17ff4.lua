require("x64:ef643b0f71e0bc5")
require("x64:12c2c83a0059738")
CoD.HUD_ZM_Arcade_Multiplier = InheritFrom(LUI.UIElement)
CoD.HUD_ZM_Arcade_Multiplier.__defaultWidth = 127
CoD.HUD_ZM_Arcade_Multiplier.__defaultHeight = 37
CoD.HUD_ZM_Arcade_Multiplier.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	SetProperty(self, "lastMultiplier", 0)
	self:setClass(CoD.HUD_ZM_Arcade_Multiplier)
	self.id = "HUD_ZM_Arcade_Multiplier"
	self.soundSet = "HUD"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ZmFxSpark2Ext = CoD.ZmFx_Spark2Ext.new(f1_arg0, f1_arg1, 0, 0, -12, 89, 0, 0, -122, 29)
	ZmFxSpark2Ext:setAlpha(0)
	self:addElement(ZmFxSpark2Ext)
	self.ZmFxSpark2Ext = ZmFxSpark2Ext
	local Multiplier = LUI.UIText.new(0, 0, 0, 218, 0.01, 0.01, 0, 39)
	Multiplier:setTTF("skorzhen")
	Multiplier:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Multiplier:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	Multiplier:setBackingType(2)
	Multiplier:setBackingXPadding(5)
	Multiplier:setBackingYPadding(3)
	Multiplier:setBackingImage(RegisterImage(0x75D661B612187DF))
	Multiplier:linkToElementModel(self, "multiplier_count", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Multiplier:setText(LocalizeIntoString(0x674D175D3480E09, f2_local0))
		end
	end)
	self:addElement(Multiplier)
	self.Multiplier = Multiplier
	local Image = LUI.UIImage.new(0.5, 0.5, -63.5, -8.5, 0.5, 0.5, -77, 87)
	Image:setRGB(1, 0.84, 0)
	Image:setAlpha(0)
	Image:setZRot(90)
	Image:setImage(RegisterImage(0x5BE416E17DAB33B))
	Image:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Image)
	self.Image = Image
	local flare12 = CoD.Hud_ZM_Flare_Multiplier.new(f1_arg0, f1_arg1, 0, 0, -728, 184, 0, 0, -509.5, 51.5)
	flare12:linkToElementModel(self, nil, false, function(model)
		flare12:setModel(model, f1_arg1)
	end)
	self:addElement(flare12)
	self.flare12 = flare12
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ZombieUtility.IsClientnumFromElementEqualToOurs(f1_arg1, self)
			end,
		},
		{
			stateName = "Multiplier100",
			condition = function(menu, element, event)
				local f5_local0
				if not CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "playerScoreShown", 0) then
					f5_local0 = CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "multiplier_count", 100)
				else
					f5_local0 = false
				end
				return f5_local0
			end,
		},
		{
			stateName = "Multiplier75",
			condition = function(menu, element, event)
				local f6_local0
				if not CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "playerScoreShown", 0) then
					f6_local0 = CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "multiplier_count", 75)
				else
					f6_local0 = false
				end
				return f6_local0
			end,
		},
		{
			stateName = "Multiplier50",
			condition = function(menu, element, event)
				local f7_local0
				if not CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "playerScoreShown", 0) then
					f7_local0 = CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "multiplier_count", 50)
				else
					f7_local0 = false
				end
				return f7_local0
			end,
		},
		{
			stateName = "Multiplier25",
			condition = function(menu, element, event)
				local f8_local0
				if not CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "playerScoreShown", 0) then
					f8_local0 = CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "multiplier_count", 25)
				else
					f8_local0 = false
				end
				return f8_local0
			end,
		},
		{
			stateName = "Multiplier0",
			condition = function(menu, element, event)
				local f9_local0
				if not CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "playerScoreShown", 0) then
					f9_local0 = CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "multiplier_count", 2)
				else
					f9_local0 = false
				end
				return f9_local0
			end,
		},
	})
	self:linkToElementModel(self, "clientNum", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "clientNum",
		})
	end)
	self:linkToElementModel(self, "playerScoreShown", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "playerScoreShown",
		})
	end)
	self:linkToElementModel(self, "multiplier_count", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "multiplier_count",
		})
	end)
	self:linkToElementModel(self, "multiplier_count", true, function(model)
		local f13_local0 = self
		if not CoD.ModelUtility.IsSelfModelValueEqualTo(f13_local0, f1_arg1, "playerScoreShown", 0) and CoD.ZombieUtility.IsSelfModelValueGreaterThanCachedValue(f1_arg1, self, "multiplier_count", "lastMultiplier") then
			SetElementProperty(f13_local0, "lastMultiplier", model:get())
			PlayClip(self, "Increase", f1_arg1)
		elseif not CoD.ModelUtility.IsSelfModelValueEqualTo(f13_local0, f1_arg1, "playerScoreShown", 0) then
			SetElementProperty(f13_local0, "lastMultiplier", model:get())
		end
	end)
	self:linkToElementModel(self, "multiplier_blink", true, function(model)
		local f14_local0 = self
		if not CoD.ModelUtility.IsSelfModelValueEqualTo(f14_local0, f1_arg1, "playerScoreShown", 0) and not CoD.ModelUtility.IsSelfModelValueNilOrZero(f14_local0, f1_arg1, "multiplier_blink") then
			PlayClip(self, "Flash", f1_arg1)
		elseif not CoD.ModelUtility.IsSelfModelValueEqualTo(f14_local0, f1_arg1, "playerScoreShown", 0) and CoD.ModelUtility.IsSelfModelValueNilOrZero(f14_local0, f1_arg1, "multiplier_blink") then
			PlayClip(self, "DefaultClip", f1_arg1)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.HUD_ZM_Arcade_Multiplier.__resetProperties = function(f15_arg0)
	f15_arg0.Multiplier:completeAnimation()
	f15_arg0.flare12:completeAnimation()
	f15_arg0.ZmFxSpark2Ext:completeAnimation()
	f15_arg0.Multiplier:setLeftRight(0, 0, 0, 218)
	f15_arg0.Multiplier:setTopBottom(0.01, 0.01, 0, 39)
	f15_arg0.Multiplier:setRGB(1, 1, 1)
	f15_arg0.Multiplier:setAlpha(1)
	f15_arg0.Multiplier:setZRot(0)
	f15_arg0.Multiplier:setScale(1, 1)
	f15_arg0.flare12:setAlpha(1)
	f15_arg0.ZmFxSpark2Ext:setLeftRight(0, 0, -12, 89)
	f15_arg0.ZmFxSpark2Ext:setTopBottom(0, 0, -122, 29)
	f15_arg0.ZmFxSpark2Ext:setAlpha(0)
	f15_arg0.ZmFxSpark2Ext:setScale(1, 1)
end
CoD.HUD_ZM_Arcade_Multiplier.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(2)
			f16_arg0.Multiplier:completeAnimation()
			f16_arg0.Multiplier:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.Multiplier)
			f16_arg0.flare12:completeAnimation()
			f16_arg0.flare12:setAlpha(0)
			f16_arg0.clipFinished(f16_arg0.flare12)
		end,
	},
	Hidden = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			f17_arg0.Multiplier:completeAnimation()
			f17_arg0.Multiplier:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.Multiplier)
			f17_arg0.flare12:completeAnimation()
			f17_arg0.flare12:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.flare12)
		end,
	},
	Multiplier100 = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			f18_arg0.Multiplier:completeAnimation()
			f18_arg0.Multiplier:setTopBottom(0.01, 0.01, -12, 55)
			f18_arg0.Multiplier:setRGB(1, 0.9, 0)
			f18_arg0.Multiplier:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.Multiplier)
		end,
		Increase = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(2)
			local f19_local0 = function(f20_arg0)
				local f20_local0 = function(f21_arg0)
					local f21_local0 = function(f22_arg0)
						local f22_local0 = function(f23_arg0)
							f23_arg0:beginAnimation(140)
							f23_arg0:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
						end
						f22_arg0:beginAnimation(160)
						f22_arg0:setLeftRight(0, 0, -20.5, 63.5)
						f22_arg0:setTopBottom(0, 0, -79.5, 46.5)
						f22_arg0:setScale(1.1, 1.1)
						f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
					end
					f21_arg0:beginAnimation(110)
					f21_arg0:setLeftRight(0, 0, -11.5, 72.5)
					f21_arg0:setTopBottom(0, 0, -107, 19)
					f21_arg0:registerEventHandler("transition_complete_keyframe", f21_local0)
				end
				f19_arg0.ZmFxSpark2Ext:beginAnimation(80)
				f19_arg0.ZmFxSpark2Ext:setLeftRight(0, 0, -9.5, 74.5)
				f19_arg0.ZmFxSpark2Ext:setTopBottom(0, 0, -87, 39)
				f19_arg0.ZmFxSpark2Ext:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.ZmFxSpark2Ext:registerEventHandler("transition_complete_keyframe", f20_local0)
			end
			f19_arg0.ZmFxSpark2Ext:completeAnimation()
			f19_arg0.ZmFxSpark2Ext:setLeftRight(0, 0, -20.5, 63.5)
			f19_arg0.ZmFxSpark2Ext:setTopBottom(0, 0, -84.5, 41.5)
			f19_arg0.ZmFxSpark2Ext:setAlpha(0)
			f19_arg0.ZmFxSpark2Ext:setScale(1.9, 1.9)
			f19_local0(f19_arg0.ZmFxSpark2Ext)
			local f19_local1 = function(f24_arg0)
				local f24_local0 = function(f25_arg0)
					local f25_local0 = function(f26_arg0)
						local f26_local0 = function(f27_arg0)
							local f27_local0 = function(f28_arg0)
								local f28_local0 = function(f29_arg0)
									local f29_local0 = function(f30_arg0)
										f30_arg0:beginAnimation(59)
										f30_arg0:setTopBottom(0, 0, -12, 55)
										f30_arg0:setZRot(0)
										f30_arg0:registerEventHandler("transition_complete_keyframe", f19_arg0.clipFinished)
									end
									f29_arg0:beginAnimation(60)
									f29_arg0:setTopBottom(0, 0, -7, 60)
									f29_arg0:setZRot(9)
									f29_arg0:registerEventHandler("transition_complete_keyframe", f29_local0)
								end
								f28_arg0:beginAnimation(90)
								f28_arg0:setTopBottom(0, 0, -16, 59)
								f28_arg0:setZRot(-2)
								f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
							end
							f27_arg0:beginAnimation(49)
							f27_arg0:setTopBottom(0.01, 0.01, -13.43, 56.43)
							f27_arg0:setZRot(10)
							f27_arg0:registerEventHandler("transition_complete_keyframe", f27_local0)
						end
						f26_arg0:beginAnimation(49)
						f26_arg0:setTopBottom(0.01, 0.01, -12, 55)
						f26_arg0:setZRot(2)
						f26_arg0:registerEventHandler("transition_complete_keyframe", f26_local0)
					end
					f25_arg0:beginAnimation(40)
					f25_arg0:setTopBottom(0.01, 0.01, -19.5, 52.5)
					f25_arg0:setZRot(-15)
					f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
				end
				f19_arg0.Multiplier:beginAnimation(70)
				f19_arg0.Multiplier:setTopBottom(0.01, 0.01, -12, 55)
				f19_arg0.Multiplier:setZRot(-6)
				f19_arg0.Multiplier:registerEventHandler("interrupted_keyframe", f19_arg0.clipInterrupted)
				f19_arg0.Multiplier:registerEventHandler("transition_complete_keyframe", f24_local0)
			end
			f19_arg0.Multiplier:completeAnimation()
			f19_arg0.Multiplier:setTopBottom(0, 0, -12, 55)
			f19_arg0.Multiplier:setRGB(1, 0.9, 0)
			f19_arg0.Multiplier:setAlpha(1)
			f19_arg0.Multiplier:setZRot(9)
			f19_local1(f19_arg0.Multiplier)
		end,
		Flash = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(1)
			local f31_local0 = function(f32_arg0)
				local f32_local0 = function(f33_arg0)
					f33_arg0:beginAnimation(250)
					f33_arg0:setAlpha(0)
					f33_arg0:setScale(1, 1)
					f33_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
				end
				f31_arg0.Multiplier:beginAnimation(250)
				f31_arg0.Multiplier:setAlpha(1)
				f31_arg0.Multiplier:setScale(0.9, 0.9)
				f31_arg0.Multiplier:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.Multiplier:registerEventHandler("transition_complete_keyframe", f32_local0)
			end
			f31_arg0.Multiplier:completeAnimation()
			f31_arg0.Multiplier:setTopBottom(0, 0, -12, 55)
			f31_arg0.Multiplier:setRGB(1, 0.9, 0)
			f31_arg0.Multiplier:setAlpha(0)
			f31_arg0.Multiplier:setScale(1, 1)
			f31_local0(f31_arg0.Multiplier)
			f31_arg0.nextClip = "Flash"
		end,
		Multiplier75 = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(1)
			local f34_local0 = function(f35_arg0)
				f34_arg0.Multiplier:beginAnimation(200)
				f34_arg0.Multiplier:setTopBottom(0, 0, -7, 50)
				f34_arg0.Multiplier:setRGB(1, 0.99, 0.33)
				f34_arg0.Multiplier:registerEventHandler("interrupted_keyframe", f34_arg0.clipInterrupted)
				f34_arg0.Multiplier:registerEventHandler("transition_complete_keyframe", f34_arg0.clipFinished)
			end
			f34_arg0.Multiplier:completeAnimation()
			f34_arg0.Multiplier:setTopBottom(0, 0, -12.5, 54.5)
			f34_arg0.Multiplier:setRGB(1, 0.9, 0)
			f34_arg0.Multiplier:setAlpha(1)
			f34_local0(f34_arg0.Multiplier)
		end,
	},
	Multiplier75 = {
		DefaultClip = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(1)
			f36_arg0.Multiplier:completeAnimation()
			f36_arg0.Multiplier:setTopBottom(0, 0, -7, 50)
			f36_arg0.Multiplier:setRGB(1, 0.99, 0.33)
			f36_arg0.Multiplier:setAlpha(1)
			f36_arg0.clipFinished(f36_arg0.Multiplier)
		end,
		Increase = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(2)
			local f37_local0 = function(f38_arg0)
				local f38_local0 = function(f39_arg0)
					local f39_local0 = function(f40_arg0)
						local f40_local0 = function(f41_arg0)
							f41_arg0:beginAnimation(140)
							f41_arg0:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
						end
						f40_arg0:beginAnimation(160)
						f40_arg0:setLeftRight(0, 0, -20.5, 63.5)
						f40_arg0:setTopBottom(0, 0, -79.5, 46.5)
						f40_arg0:setScale(0.9, 0.9)
						f40_arg0:registerEventHandler("transition_complete_keyframe", f40_local0)
					end
					f39_arg0:beginAnimation(110)
					f39_arg0:setLeftRight(0, 0, -11.5, 72.5)
					f39_arg0:setTopBottom(0, 0, -107, 19)
					f39_arg0:registerEventHandler("transition_complete_keyframe", f39_local0)
				end
				f37_arg0.ZmFxSpark2Ext:beginAnimation(80)
				f37_arg0.ZmFxSpark2Ext:setLeftRight(0, 0, -9.5, 74.5)
				f37_arg0.ZmFxSpark2Ext:setTopBottom(0, 0, -87, 39)
				f37_arg0.ZmFxSpark2Ext:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.ZmFxSpark2Ext:registerEventHandler("transition_complete_keyframe", f38_local0)
			end
			f37_arg0.ZmFxSpark2Ext:completeAnimation()
			f37_arg0.ZmFxSpark2Ext:setLeftRight(0, 0, -20.5, 63.5)
			f37_arg0.ZmFxSpark2Ext:setTopBottom(0, 0, -84.5, 41.5)
			f37_arg0.ZmFxSpark2Ext:setAlpha(0)
			f37_arg0.ZmFxSpark2Ext:setScale(1.7, 1.7)
			f37_local0(f37_arg0.ZmFxSpark2Ext)
			local f37_local1 = function(f42_arg0)
				local f42_local0 = function(f43_arg0)
					local f43_local0 = function(f44_arg0)
						local f44_local0 = function(f45_arg0)
							local f45_local0 = function(f46_arg0)
								local f46_local0 = function(f47_arg0)
									f47_arg0:beginAnimation(120)
									f47_arg0:setLeftRight(0, 0, 0, 218)
									f47_arg0:setTopBottom(0, 0, -7, 50)
									f47_arg0:setZRot(0)
									f47_arg0:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
								end
								f46_arg0:beginAnimation(60)
								f46_arg0:setLeftRight(0, 0, -6.5, 211.5)
								f46_arg0:setTopBottom(0, 0, -16.5, 42.5)
								f46_arg0:setZRot(9)
								f46_arg0:registerEventHandler("transition_complete_keyframe", f46_local0)
							end
							f45_arg0:beginAnimation(60)
							f45_arg0:setTopBottom(0.01, 0.01, -5.5, 41.5)
							f45_arg0:setZRot(-2)
							f45_arg0:registerEventHandler("transition_complete_keyframe", f45_local0)
						end
						f44_arg0:beginAnimation(100)
						f44_arg0:setTopBottom(0.01, 0.01, -14.5, 44.5)
						f44_arg0:setZRot(9)
						f44_arg0:registerEventHandler("transition_complete_keyframe", f44_local0)
					end
					f43_arg0:beginAnimation(60)
					f43_arg0:setTopBottom(0.01, 0.01, -13.5, 36.5)
					f43_arg0:setZRot(-9)
					f43_arg0:registerEventHandler("transition_complete_keyframe", f43_local0)
				end
				f37_arg0.Multiplier:beginAnimation(60)
				f37_arg0.Multiplier:setTopBottom(0.01, 0.01, -1, 39)
				f37_arg0.Multiplier:setZRot(12)
				f37_arg0.Multiplier:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.Multiplier:registerEventHandler("transition_complete_keyframe", f42_local0)
			end
			f37_arg0.Multiplier:completeAnimation()
			f37_arg0.Multiplier:setLeftRight(0, 0, 0, 218)
			f37_arg0.Multiplier:setTopBottom(0, 0, -7, 50)
			f37_arg0.Multiplier:setRGB(1, 0.99, 0.33)
			f37_arg0.Multiplier:setAlpha(1)
			f37_arg0.Multiplier:setZRot(0)
			f37_local1(f37_arg0.Multiplier)
		end,
		Flash = function(f48_arg0, f48_arg1)
			f48_arg0:__resetProperties()
			f48_arg0:setupElementClipCounter(1)
			local f48_local0 = function(f49_arg0)
				local f49_local0 = function(f50_arg0)
					f50_arg0:beginAnimation(250)
					f50_arg0:setAlpha(0)
					f50_arg0:setScale(1, 1)
					f50_arg0:registerEventHandler("transition_complete_keyframe", f48_arg0.clipFinished)
				end
				f48_arg0.Multiplier:beginAnimation(250)
				f48_arg0.Multiplier:setAlpha(1)
				f48_arg0.Multiplier:setScale(0.9, 0.9)
				f48_arg0.Multiplier:registerEventHandler("interrupted_keyframe", f48_arg0.clipInterrupted)
				f48_arg0.Multiplier:registerEventHandler("transition_complete_keyframe", f49_local0)
			end
			f48_arg0.Multiplier:completeAnimation()
			f48_arg0.Multiplier:setTopBottom(0, 0, -7, 50)
			f48_arg0.Multiplier:setRGB(1, 0.99, 0.33)
			f48_arg0.Multiplier:setAlpha(0)
			f48_arg0.Multiplier:setScale(1, 1)
			f48_local0(f48_arg0.Multiplier)
			f48_arg0.nextClip = "Flash"
		end,
		Multiplier100 = function(f51_arg0, f51_arg1)
			f51_arg0:__resetProperties()
			f51_arg0:setupElementClipCounter(1)
			local f51_local0 = function(f52_arg0)
				local f52_local0 = function(f53_arg0)
					f53_arg0:beginAnimation(100)
					f53_arg0:setTopBottom(0, 0, -12.5, 54.5)
					f53_arg0:setRGB(1, 0.9, 0)
					f53_arg0:setZRot(0)
					f53_arg0:registerEventHandler("transition_complete_keyframe", f51_arg0.clipFinished)
				end
				f51_arg0.Multiplier:beginAnimation(200)
				f51_arg0.Multiplier:setTopBottom(0.01, 0.01, -18.5, 61.5)
				f51_arg0.Multiplier:setRGB(1, 0.93, 0.11)
				f51_arg0.Multiplier:setZRot(9)
				f51_arg0.Multiplier:registerEventHandler("interrupted_keyframe", f51_arg0.clipInterrupted)
				f51_arg0.Multiplier:registerEventHandler("transition_complete_keyframe", f52_local0)
			end
			f51_arg0.Multiplier:completeAnimation()
			f51_arg0.Multiplier:setTopBottom(0, 0, -7, 50)
			f51_arg0.Multiplier:setRGB(1, 0.99, 0.33)
			f51_arg0.Multiplier:setAlpha(1)
			f51_arg0.Multiplier:setZRot(0)
			f51_local0(f51_arg0.Multiplier)
		end,
		Multiplier50 = function(f54_arg0, f54_arg1)
			f54_arg0:__resetProperties()
			f54_arg0:setupElementClipCounter(1)
			local f54_local0 = function(f55_arg0)
				f54_arg0.Multiplier:beginAnimation(200)
				f54_arg0.Multiplier:setTopBottom(0, 0, -4, 47)
				f54_arg0.Multiplier:setRGB(1, 0.99, 0.54)
				f54_arg0.Multiplier:registerEventHandler("interrupted_keyframe", f54_arg0.clipInterrupted)
				f54_arg0.Multiplier:registerEventHandler("transition_complete_keyframe", f54_arg0.clipFinished)
			end
			f54_arg0.Multiplier:completeAnimation()
			f54_arg0.Multiplier:setTopBottom(0, 0, -7, 50)
			f54_arg0.Multiplier:setRGB(1, 0.99, 0.33)
			f54_arg0.Multiplier:setAlpha(1)
			f54_local0(f54_arg0.Multiplier)
		end,
	},
	Multiplier50 = {
		DefaultClip = function(f56_arg0, f56_arg1)
			f56_arg0:__resetProperties()
			f56_arg0:setupElementClipCounter(1)
			f56_arg0.Multiplier:completeAnimation()
			f56_arg0.Multiplier:setTopBottom(0.01, 0.01, -4, 47)
			f56_arg0.Multiplier:setRGB(1, 0.99, 0.54)
			f56_arg0.Multiplier:setAlpha(1)
			f56_arg0.clipFinished(f56_arg0.Multiplier)
		end,
		Increase = function(f57_arg0, f57_arg1)
			f57_arg0:__resetProperties()
			f57_arg0:setupElementClipCounter(2)
			local f57_local0 = function(f58_arg0)
				local f58_local0 = function(f59_arg0)
					local f59_local0 = function(f60_arg0)
						local f60_local0 = function(f61_arg0)
							f61_arg0:beginAnimation(140)
							f61_arg0:registerEventHandler("transition_complete_keyframe", f57_arg0.clipFinished)
						end
						f60_arg0:beginAnimation(160)
						f60_arg0:setLeftRight(0, 0, -20.5, 63.5)
						f60_arg0:setTopBottom(0, 0, -79.5, 46.5)
						f60_arg0:setScale(0.9, 0.9)
						f60_arg0:registerEventHandler("transition_complete_keyframe", f60_local0)
					end
					f59_arg0:beginAnimation(110)
					f59_arg0:setLeftRight(0, 0, -11.5, 72.5)
					f59_arg0:setTopBottom(0, 0, -107, 19)
					f59_arg0:registerEventHandler("transition_complete_keyframe", f59_local0)
				end
				f57_arg0.ZmFxSpark2Ext:beginAnimation(80)
				f57_arg0.ZmFxSpark2Ext:setLeftRight(0, 0, -9.5, 74.5)
				f57_arg0.ZmFxSpark2Ext:setTopBottom(0, 0, -87, 39)
				f57_arg0.ZmFxSpark2Ext:registerEventHandler("interrupted_keyframe", f57_arg0.clipInterrupted)
				f57_arg0.ZmFxSpark2Ext:registerEventHandler("transition_complete_keyframe", f58_local0)
			end
			f57_arg0.ZmFxSpark2Ext:completeAnimation()
			f57_arg0.ZmFxSpark2Ext:setLeftRight(0, 0, -20.5, 63.5)
			f57_arg0.ZmFxSpark2Ext:setTopBottom(0, 0, -84.5, 41.5)
			f57_arg0.ZmFxSpark2Ext:setAlpha(0)
			f57_arg0.ZmFxSpark2Ext:setScale(1.7, 1.7)
			f57_local0(f57_arg0.ZmFxSpark2Ext)
			local f57_local1 = function(f62_arg0)
				local f62_local0 = function(f63_arg0)
					local f63_local0 = function(f64_arg0)
						local f64_local0 = function(f65_arg0)
							local f65_local0 = function(f66_arg0)
								local f66_local0 = function(f67_arg0)
									f67_arg0:beginAnimation(120)
									f67_arg0:setLeftRight(0, 0, 0, 218)
									f67_arg0:setTopBottom(0, 0, -4, 47)
									f67_arg0:setZRot(0)
									f67_arg0:registerEventHandler("transition_complete_keyframe", f57_arg0.clipFinished)
								end
								f66_arg0:beginAnimation(60)
								f66_arg0:setLeftRight(0, 0, -6.5, 211.5)
								f66_arg0:setTopBottom(0, 0, -16.5, 42.5)
								f66_arg0:setZRot(9)
								f66_arg0:registerEventHandler("transition_complete_keyframe", f66_local0)
							end
							f65_arg0:beginAnimation(60)
							f65_arg0:setTopBottom(0.01, 0.01, -5.5, 41.5)
							f65_arg0:setZRot(-2)
							f65_arg0:registerEventHandler("transition_complete_keyframe", f65_local0)
						end
						f64_arg0:beginAnimation(100)
						f64_arg0:setTopBottom(0.01, 0.01, -14.5, 44.5)
						f64_arg0:setZRot(9)
						f64_arg0:registerEventHandler("transition_complete_keyframe", f64_local0)
					end
					f63_arg0:beginAnimation(60)
					f63_arg0:setTopBottom(0.01, 0.01, -13.5, 36.5)
					f63_arg0:setZRot(-9)
					f63_arg0:registerEventHandler("transition_complete_keyframe", f63_local0)
				end
				f57_arg0.Multiplier:beginAnimation(60)
				f57_arg0.Multiplier:setTopBottom(0.01, 0.01, -1, 39)
				f57_arg0.Multiplier:setZRot(12)
				f57_arg0.Multiplier:registerEventHandler("interrupted_keyframe", f57_arg0.clipInterrupted)
				f57_arg0.Multiplier:registerEventHandler("transition_complete_keyframe", f62_local0)
			end
			f57_arg0.Multiplier:completeAnimation()
			f57_arg0.Multiplier:setLeftRight(0, 0, 0, 218)
			f57_arg0.Multiplier:setTopBottom(0, 0, -4, 47)
			f57_arg0.Multiplier:setRGB(1, 0.99, 0.54)
			f57_arg0.Multiplier:setAlpha(1)
			f57_arg0.Multiplier:setZRot(0)
			f57_local1(f57_arg0.Multiplier)
		end,
		Flash = function(f68_arg0, f68_arg1)
			f68_arg0:__resetProperties()
			f68_arg0:setupElementClipCounter(1)
			local f68_local0 = function(f69_arg0)
				local f69_local0 = function(f70_arg0)
					f70_arg0:beginAnimation(250)
					f70_arg0:setAlpha(0)
					f70_arg0:setScale(1, 1)
					f70_arg0:registerEventHandler("transition_complete_keyframe", f68_arg0.clipFinished)
				end
				f68_arg0.Multiplier:beginAnimation(250)
				f68_arg0.Multiplier:setAlpha(1)
				f68_arg0.Multiplier:setScale(0.9, 0.9)
				f68_arg0.Multiplier:registerEventHandler("interrupted_keyframe", f68_arg0.clipInterrupted)
				f68_arg0.Multiplier:registerEventHandler("transition_complete_keyframe", f69_local0)
			end
			f68_arg0.Multiplier:completeAnimation()
			f68_arg0.Multiplier:setTopBottom(0.01, 0.01, -4, 47)
			f68_arg0.Multiplier:setRGB(1, 0.99, 0.54)
			f68_arg0.Multiplier:setAlpha(0)
			f68_arg0.Multiplier:setScale(1, 1)
			f68_local0(f68_arg0.Multiplier)
			f68_arg0.nextClip = "Flash"
		end,
		Multiplier75 = function(f71_arg0, f71_arg1)
			f71_arg0:__resetProperties()
			f71_arg0:setupElementClipCounter(1)
			local f71_local0 = function(f72_arg0)
				local f72_local0 = function(f73_arg0)
					f73_arg0:beginAnimation(100)
					f73_arg0:setTopBottom(0, 0, -7, 50)
					f73_arg0:setRGB(1, 0.99, 0.33)
					f73_arg0:setZRot(0)
					f73_arg0:registerEventHandler("transition_complete_keyframe", f71_arg0.clipFinished)
				end
				f71_arg0.Multiplier:beginAnimation(200)
				f71_arg0.Multiplier:setTopBottom(0.01, 0.01, -18.5, 61.5)
				f71_arg0.Multiplier:setRGB(1, 0.99, 0.4)
				f71_arg0.Multiplier:setZRot(9)
				f71_arg0.Multiplier:registerEventHandler("interrupted_keyframe", f71_arg0.clipInterrupted)
				f71_arg0.Multiplier:registerEventHandler("transition_complete_keyframe", f72_local0)
			end
			f71_arg0.Multiplier:completeAnimation()
			f71_arg0.Multiplier:setTopBottom(0.01, 0.01, -4, 47)
			f71_arg0.Multiplier:setRGB(1, 0.99, 0.54)
			f71_arg0.Multiplier:setAlpha(1)
			f71_arg0.Multiplier:setZRot(0)
			f71_local0(f71_arg0.Multiplier)
		end,
		Multiplier25 = function(f74_arg0, f74_arg1)
			f74_arg0:__resetProperties()
			f74_arg0:setupElementClipCounter(1)
			local f74_local0 = function(f75_arg0)
				f74_arg0.Multiplier:beginAnimation(200)
				f74_arg0.Multiplier:setTopBottom(0, 0, -0.5, 43.5)
				f74_arg0.Multiplier:setRGB(1, 0.99, 0.75)
				f74_arg0.Multiplier:registerEventHandler("interrupted_keyframe", f74_arg0.clipInterrupted)
				f74_arg0.Multiplier:registerEventHandler("transition_complete_keyframe", f74_arg0.clipFinished)
			end
			f74_arg0.Multiplier:completeAnimation()
			f74_arg0.Multiplier:setTopBottom(0, 0, -4, 47)
			f74_arg0.Multiplier:setRGB(1, 0.99, 0.54)
			f74_arg0.Multiplier:setAlpha(1)
			f74_local0(f74_arg0.Multiplier)
		end,
	},
	Multiplier25 = {
		DefaultClip = function(f76_arg0, f76_arg1)
			f76_arg0:__resetProperties()
			f76_arg0:setupElementClipCounter(1)
			f76_arg0.Multiplier:completeAnimation()
			f76_arg0.Multiplier:setTopBottom(0.01, 0.01, -0.5, 43.5)
			f76_arg0.Multiplier:setRGB(1, 0.99, 0.75)
			f76_arg0.Multiplier:setAlpha(1)
			f76_arg0.clipFinished(f76_arg0.Multiplier)
		end,
		Increase = function(f77_arg0, f77_arg1)
			f77_arg0:__resetProperties()
			f77_arg0:setupElementClipCounter(2)
			local f77_local0 = function(f78_arg0)
				local f78_local0 = function(f79_arg0)
					local f79_local0 = function(f80_arg0)
						local f80_local0 = function(f81_arg0)
							f81_arg0:beginAnimation(140)
							f81_arg0:registerEventHandler("transition_complete_keyframe", f77_arg0.clipFinished)
						end
						f80_arg0:beginAnimation(160)
						f80_arg0:setLeftRight(0, 0, -20.5, 63.5)
						f80_arg0:setTopBottom(0, 0, -79.5, 46.5)
						f80_arg0:setScale(0.9, 0.9)
						f80_arg0:registerEventHandler("transition_complete_keyframe", f80_local0)
					end
					f79_arg0:beginAnimation(110)
					f79_arg0:setLeftRight(0, 0, -11.5, 72.5)
					f79_arg0:setTopBottom(0, 0, -107, 19)
					f79_arg0:registerEventHandler("transition_complete_keyframe", f79_local0)
				end
				f77_arg0.ZmFxSpark2Ext:beginAnimation(80)
				f77_arg0.ZmFxSpark2Ext:setLeftRight(0, 0, -9.5, 74.5)
				f77_arg0.ZmFxSpark2Ext:setTopBottom(0, 0, -87, 39)
				f77_arg0.ZmFxSpark2Ext:registerEventHandler("interrupted_keyframe", f77_arg0.clipInterrupted)
				f77_arg0.ZmFxSpark2Ext:registerEventHandler("transition_complete_keyframe", f78_local0)
			end
			f77_arg0.ZmFxSpark2Ext:completeAnimation()
			f77_arg0.ZmFxSpark2Ext:setLeftRight(0, 0, -20.5, 63.5)
			f77_arg0.ZmFxSpark2Ext:setTopBottom(0, 0, -84.5, 41.5)
			f77_arg0.ZmFxSpark2Ext:setAlpha(0)
			f77_arg0.ZmFxSpark2Ext:setScale(1.5, 1.5)
			f77_local0(f77_arg0.ZmFxSpark2Ext)
			local f77_local1 = function(f82_arg0)
				local f82_local0 = function(f83_arg0)
					local f83_local0 = function(f84_arg0)
						local f84_local0 = function(f85_arg0)
							local f85_local0 = function(f86_arg0)
								f86_arg0:beginAnimation(80)
								f86_arg0:setTopBottom(0, 0, -0.5, 43.5)
								f86_arg0:setZRot(0)
								f86_arg0:registerEventHandler("transition_complete_keyframe", f77_arg0.clipFinished)
							end
							f85_arg0:beginAnimation(70)
							f85_arg0:setTopBottom(0.01, 0.01, -2.5, 44.5)
							f85_arg0:setZRot(-2)
							f85_arg0:registerEventHandler("transition_complete_keyframe", f85_local0)
						end
						f84_arg0:beginAnimation(89)
						f84_arg0:setTopBottom(0.01, 0.01, -9, 39)
						f84_arg0:setZRot(9)
						f84_arg0:registerEventHandler("transition_complete_keyframe", f84_local0)
					end
					f83_arg0:beginAnimation(60)
					f83_arg0:setTopBottom(0.01, 0.01, -13.5, 36.5)
					f83_arg0:setZRot(-9)
					f83_arg0:registerEventHandler("transition_complete_keyframe", f83_local0)
				end
				f77_arg0.Multiplier:beginAnimation(60)
				f77_arg0.Multiplier:setTopBottom(0.01, 0.01, -1, 39)
				f77_arg0.Multiplier:setZRot(12)
				f77_arg0.Multiplier:registerEventHandler("interrupted_keyframe", f77_arg0.clipInterrupted)
				f77_arg0.Multiplier:registerEventHandler("transition_complete_keyframe", f82_local0)
			end
			f77_arg0.Multiplier:completeAnimation()
			f77_arg0.Multiplier:setLeftRight(0, 0, 0, 218)
			f77_arg0.Multiplier:setTopBottom(0, 0, -0.5, 43.5)
			f77_arg0.Multiplier:setRGB(1, 0.99, 0.75)
			f77_arg0.Multiplier:setAlpha(1)
			f77_arg0.Multiplier:setZRot(0)
			f77_local1(f77_arg0.Multiplier)
		end,
		Flash = function(f87_arg0, f87_arg1)
			f87_arg0:__resetProperties()
			f87_arg0:setupElementClipCounter(1)
			local f87_local0 = function(f88_arg0)
				local f88_local0 = function(f89_arg0)
					f89_arg0:beginAnimation(250)
					f89_arg0:setAlpha(0)
					f89_arg0:setScale(1, 1)
					f89_arg0:registerEventHandler("transition_complete_keyframe", f87_arg0.clipFinished)
				end
				f87_arg0.Multiplier:beginAnimation(250)
				f87_arg0.Multiplier:setRGB(1, 0.99, 0.75)
				f87_arg0.Multiplier:setAlpha(1)
				f87_arg0.Multiplier:setScale(0.9, 0.9)
				f87_arg0.Multiplier:registerEventHandler("interrupted_keyframe", f87_arg0.clipInterrupted)
				f87_arg0.Multiplier:registerEventHandler("transition_complete_keyframe", f88_local0)
			end
			f87_arg0.Multiplier:completeAnimation()
			f87_arg0.Multiplier:setTopBottom(0.01, 0.01, -0.5, 43.5)
			f87_arg0.Multiplier:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
			f87_arg0.Multiplier:setAlpha(0)
			f87_arg0.Multiplier:setScale(1, 1)
			f87_local0(f87_arg0.Multiplier)
			f87_arg0.nextClip = "Flash"
		end,
		Multiplier50 = function(f90_arg0, f90_arg1)
			f90_arg0:__resetProperties()
			f90_arg0:setupElementClipCounter(1)
			local f90_local0 = function(f91_arg0)
				local f91_local0 = function(f92_arg0)
					local f92_local0 = function(f93_arg0)
						f93_arg0:beginAnimation(70)
						f93_arg0:setTopBottom(0, 0, -4, 47)
						f93_arg0:setRGB(1, 0.99, 0.54)
						f93_arg0:setZRot(0)
						f93_arg0:registerEventHandler("transition_complete_keyframe", f90_arg0.clipFinished)
					end
					f92_arg0:beginAnimation(30)
					f92_arg0:setTopBottom(0, 0, -10.65, 53.65)
					f92_arg0:setRGB(1, 0.99, 0.59)
					f92_arg0:setZRot(9)
					f92_arg0:registerEventHandler("transition_complete_keyframe", f92_local0)
				end
				f90_arg0.Multiplier:beginAnimation(200)
				f90_arg0.Multiplier:setTopBottom(0, 0, -13.5, 56.5)
				f90_arg0.Multiplier:setRGB(1, 0.99, 0.61)
				f90_arg0.Multiplier:setZRot(8)
				f90_arg0.Multiplier:registerEventHandler("interrupted_keyframe", f90_arg0.clipInterrupted)
				f90_arg0.Multiplier:registerEventHandler("transition_complete_keyframe", f91_local0)
			end
			f90_arg0.Multiplier:completeAnimation()
			f90_arg0.Multiplier:setTopBottom(0, 0, -0.5, 43.5)
			f90_arg0.Multiplier:setRGB(1, 0.99, 0.75)
			f90_arg0.Multiplier:setAlpha(1)
			f90_arg0.Multiplier:setZRot(0)
			f90_local0(f90_arg0.Multiplier)
		end,
		Multiplier0 = function(f94_arg0, f94_arg1)
			f94_arg0:__resetProperties()
			f94_arg0:setupElementClipCounter(1)
			local f94_local0 = function(f95_arg0)
				f94_arg0.Multiplier:beginAnimation(200)
				f94_arg0.Multiplier:setTopBottom(0, 0, 0, 39)
				f94_arg0.Multiplier:setRGB(ColorSet.WaypointNeutral.r, ColorSet.WaypointNeutral.g, ColorSet.WaypointNeutral.b)
				f94_arg0.Multiplier:registerEventHandler("interrupted_keyframe", f94_arg0.clipInterrupted)
				f94_arg0.Multiplier:registerEventHandler("transition_complete_keyframe", f94_arg0.clipFinished)
			end
			f94_arg0.Multiplier:completeAnimation()
			f94_arg0.Multiplier:setTopBottom(0.01, 0.01, -0.5, 43.5)
			f94_arg0.Multiplier:setRGB(1, 0.99, 0.75)
			f94_arg0.Multiplier:setAlpha(1)
			f94_local0(f94_arg0.Multiplier)
		end,
	},
	Multiplier0 = {
		DefaultClip = function(f96_arg0, f96_arg1)
			f96_arg0:__resetProperties()
			f96_arg0:setupElementClipCounter(1)
			f96_arg0.Multiplier:completeAnimation()
			f96_arg0.Multiplier:setAlpha(1)
			f96_arg0.clipFinished(f96_arg0.Multiplier)
		end,
		Increase = function(f97_arg0, f97_arg1)
			f97_arg0:__resetProperties()
			f97_arg0:setupElementClipCounter(2)
			local f97_local0 = function(f98_arg0)
				local f98_local0 = function(f99_arg0)
					local f99_local0 = function(f100_arg0)
						local f100_local0 = function(f101_arg0)
							f101_arg0:beginAnimation(140)
							f101_arg0:registerEventHandler("transition_complete_keyframe", f97_arg0.clipFinished)
						end
						f100_arg0:beginAnimation(160)
						f100_arg0:setLeftRight(0, 0, -20.5, 63.5)
						f100_arg0:setTopBottom(0, 0, -79.5, 46.5)
						f100_arg0:setScale(0.9, 0.9)
						f100_arg0:registerEventHandler("transition_complete_keyframe", f100_local0)
					end
					f99_arg0:beginAnimation(110)
					f99_arg0:setLeftRight(0, 0, -11.5, 72.5)
					f99_arg0:setTopBottom(0, 0, -107, 19)
					f99_arg0:registerEventHandler("transition_complete_keyframe", f99_local0)
				end
				f97_arg0.ZmFxSpark2Ext:beginAnimation(80)
				f97_arg0.ZmFxSpark2Ext:setLeftRight(0, 0, -9.5, 74.5)
				f97_arg0.ZmFxSpark2Ext:setTopBottom(0, 0, -87, 39)
				f97_arg0.ZmFxSpark2Ext:registerEventHandler("interrupted_keyframe", f97_arg0.clipInterrupted)
				f97_arg0.ZmFxSpark2Ext:registerEventHandler("transition_complete_keyframe", f98_local0)
			end
			f97_arg0.ZmFxSpark2Ext:completeAnimation()
			f97_arg0.ZmFxSpark2Ext:setLeftRight(0, 0, -6.5, 77.5)
			f97_arg0.ZmFxSpark2Ext:setTopBottom(0, 0, -88.5, 37.5)
			f97_arg0.ZmFxSpark2Ext:setAlpha(0)
			f97_arg0.ZmFxSpark2Ext:setScale(1.5, 1.5)
			f97_local0(f97_arg0.ZmFxSpark2Ext)
			local f97_local1 = function(f102_arg0)
				local f102_local0 = function(f103_arg0)
					local f103_local0 = function(f104_arg0)
						local f104_local0 = function(f105_arg0)
							f105_arg0:beginAnimation(100)
							f105_arg0:setLeftRight(0, 0, 0, 218)
							f105_arg0:setTopBottom(0, 0, 0, 39)
							f105_arg0:registerEventHandler("transition_complete_keyframe", f97_arg0.clipFinished)
						end
						f104_arg0:beginAnimation(90)
						f104_arg0:setLeftRight(0, 0, -1.05, 216.95)
						f104_arg0:setTopBottom(0.01, 0.01, -0.5, 36.5)
						f104_arg0:setZRot(0)
						f104_arg0:registerEventHandler("transition_complete_keyframe", f104_local0)
					end
					f103_arg0:beginAnimation(60)
					f103_arg0:setLeftRight(0, 0, -2, 216)
					f103_arg0:setTopBottom(0.01, 0.01, -1.5, 35.5)
					f103_arg0:setZRot(-9)
					f103_arg0:registerEventHandler("transition_complete_keyframe", f103_local0)
				end
				f97_arg0.Multiplier:beginAnimation(80)
				f97_arg0.Multiplier:setLeftRight(0, 0, -15.5, 202.5)
				f97_arg0.Multiplier:setTopBottom(0.01, 0.01, -22, 18)
				f97_arg0.Multiplier:setZRot(9)
				f97_arg0.Multiplier:registerEventHandler("interrupted_keyframe", f97_arg0.clipInterrupted)
				f97_arg0.Multiplier:registerEventHandler("transition_complete_keyframe", f102_local0)
			end
			f97_arg0.Multiplier:completeAnimation()
			f97_arg0.Multiplier:setLeftRight(0, 0, 0, 218)
			f97_arg0.Multiplier:setTopBottom(0, 0, 0, 39)
			f97_arg0.Multiplier:setRGB(ColorSet.WaypointNeutral.r, ColorSet.WaypointNeutral.g, ColorSet.WaypointNeutral.b)
			f97_arg0.Multiplier:setAlpha(1)
			f97_arg0.Multiplier:setZRot(0)
			f97_local1(f97_arg0.Multiplier)
		end,
		Flash = function(f106_arg0, f106_arg1)
			f106_arg0:__resetProperties()
			f106_arg0:setupElementClipCounter(1)
			local f106_local0 = function(f107_arg0)
				local f107_local0 = function(f108_arg0)
					f108_arg0:beginAnimation(250)
					f108_arg0:setAlpha(0)
					f108_arg0:setScale(1, 1)
					f108_arg0:registerEventHandler("transition_complete_keyframe", f106_arg0.clipFinished)
				end
				f106_arg0.Multiplier:beginAnimation(250)
				f106_arg0.Multiplier:setAlpha(1)
				f106_arg0.Multiplier:setScale(0.9, 0.9)
				f106_arg0.Multiplier:registerEventHandler("interrupted_keyframe", f106_arg0.clipInterrupted)
				f106_arg0.Multiplier:registerEventHandler("transition_complete_keyframe", f107_local0)
			end
			f106_arg0.Multiplier:completeAnimation()
			f106_arg0.Multiplier:setAlpha(0)
			f106_arg0.Multiplier:setScale(1, 1)
			f106_local0(f106_arg0.Multiplier)
			f106_arg0.nextClip = "Flash"
		end,
		Multiplier25 = function(f109_arg0, f109_arg1)
			f109_arg0:__resetProperties()
			f109_arg0:setupElementClipCounter(1)
			local f109_local0 = function(f110_arg0)
				local f110_local0 = function(f111_arg0)
					local f111_local0 = function(f112_arg0)
						f112_arg0:beginAnimation(240)
						f112_arg0:setTopBottom(0, 0, -0.5, 43.5)
						f112_arg0:setRGB(1, 0.99, 0.75)
						f112_arg0:setZRot(0)
						f112_arg0:registerEventHandler("transition_complete_keyframe", f109_arg0.clipFinished)
					end
					f111_arg0:beginAnimation(59)
					f111_arg0:setTopBottom(0.01, 0.01, -3.3, 46.3)
					f111_arg0:setRGB(1, 0.99, 0.88)
					f111_arg0:registerEventHandler("transition_complete_keyframe", f111_local0)
				end
				f109_arg0.Multiplier:beginAnimation(150)
				f109_arg0.Multiplier:setTopBottom(0.01, 0.01, -4, 47)
				f109_arg0.Multiplier:setRGB(1, 1, 0.92)
				f109_arg0.Multiplier:setZRot(9)
				f109_arg0.Multiplier:registerEventHandler("interrupted_keyframe", f109_arg0.clipInterrupted)
				f109_arg0.Multiplier:registerEventHandler("transition_complete_keyframe", f110_local0)
			end
			f109_arg0.Multiplier:completeAnimation()
			f109_arg0.Multiplier:setTopBottom(0, 0, 0, 39)
			f109_arg0.Multiplier:setRGB(ColorSet.WaypointNeutral.r, ColorSet.WaypointNeutral.g, ColorSet.WaypointNeutral.b)
			f109_arg0.Multiplier:setAlpha(1)
			f109_arg0.Multiplier:setZRot(0)
			f109_local0(f109_arg0.Multiplier)
		end,
	},
}
CoD.HUD_ZM_Arcade_Multiplier.__onClose = function(f113_arg0)
	f113_arg0.ZmFxSpark2Ext:close()
	f113_arg0.Multiplier:close()
	f113_arg0.flare12:close()
end
