require("x64:dbb04b55fa27ac6")
CoD.CommonTab = InheritFrom(LUI.UIElement)
CoD.CommonTab.__defaultWidth = 234
CoD.CommonTab.__defaultHeight = 34
CoD.CommonTab.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonTab)
	self.id = "CommonTab"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ZMTabBackingGlowRed = LUI.UIImage.new(0, 1, -111, 111, 0, 1, -111, 111)
	ZMTabBackingGlowRed:setAlpha(0)
	ZMTabBackingGlowRed:setImage(RegisterImage(0x4E64BF345836DCC))
	ZMTabBackingGlowRed:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	ZMTabBackingGlowRed:setShaderVector(0, 1.36, 0, 0, 0)
	self:addElement(ZMTabBackingGlowRed)
	self.ZMTabBackingGlowRed = ZMTabBackingGlowRed
	local ZMTabBackingRed = LUI.UIImage.new(0, 1, -67, 67, 0, 1, -32, 32)
	ZMTabBackingRed:setAlpha(0)
	ZMTabBackingRed:setImage(RegisterImage(0x4188F6C6CDE87B1))
	ZMTabBackingRed:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	ZMTabBackingRed:setShaderVector(0, 0.9, 0, 0, 0)
	self:addElement(ZMTabBackingRed)
	self.ZMTabBackingRed = ZMTabBackingRed
	local ZMBacker = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	ZMBacker:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	ZMBacker:setAlpha(0)
	self:addElement(ZMBacker)
	self.ZMBacker = ZMBacker
	local ZMTextFocus = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, -10, 10)
	ZMTextFocus:setRGB(0.03, 0.03, 0.03)
	ZMTextFocus:setAlpha(0)
	ZMTextFocus:setTTF("notosans_regular")
	ZMTextFocus:setLetterSpacing(3)
	ZMTextFocus:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ZMTextFocus:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	ZMTextFocus:linkToElementModel(self, "tabName", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ZMTextFocus:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(ZMTextFocus)
	self.ZMTextFocus = ZMTextFocus
	local ZMText = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, -9, 9)
	ZMText:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	ZMText:setAlpha(0)
	ZMText:setTTF("notosans_regular")
	ZMText:setLetterSpacing(3)
	ZMText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ZMText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	ZMText:linkToElementModel(self, "tabName", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ZMText:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(ZMText)
	self.ZMText = ZMText
	local ZMTabEndRight = LUI.UIImage.new(1, 1, -8, 0, 0, 0, 0, 35)
	ZMTabEndRight:setAlpha(0)
	ZMTabEndRight:setImage(RegisterImage(0xB48CD982934DAD0))
	self:addElement(ZMTabEndRight)
	self.ZMTabEndRight = ZMTabEndRight
	local ZMTabEndLeft = LUI.UIImage.new(0, 0, 0, 8, 0, 0, 0, 35)
	ZMTabEndLeft:setAlpha(0)
	ZMTabEndLeft:setImage(RegisterImage(0x9A262142D19A9F))
	self:addElement(ZMTabEndLeft)
	self.ZMTabEndLeft = ZMTabEndLeft
	local TabBackingGlow = LUI.UIImage.new(0, 1, -117, 117, 0, 1, -111, 111)
	TabBackingGlow:setAlpha(0)
	TabBackingGlow:setImage(RegisterImage(0x223AD1B40A93955))
	TabBackingGlow:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	TabBackingGlow:setShaderVector(0, 1.36, 0, 0, 0)
	self:addElement(TabBackingGlow)
	self.TabBackingGlow = TabBackingGlow
	local TabBacking = LUI.UIImage.new(0, 1, -66, 66, 0, 1, -30, 30)
	TabBacking:setAlpha(0)
	TabBacking:setImage(RegisterImage(0x3F09D20CA138B49))
	TabBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	TabBacking:setShaderVector(0, 0.9, 0, 0, 0)
	self:addElement(TabBacking)
	self.TabBacking = TabBacking
	local TabTitle = LUI.UIText.new(0, 1, 11, -9, 0.5, 0.5, -10.5, 10.5)
	TabTitle:setRGB(0.66, 0.63, 0.52)
	TabTitle:setAlpha(0)
	TabTitle:setTTF("ttmussels_demibold")
	TabTitle:setLetterSpacing(3)
	TabTitle:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	TabTitle:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	TabTitle:linkToElementModel(self, "tabName", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			TabTitle:setText(LocalizeToUpperString(f4_local0))
		end
	end)
	self:addElement(TabTitle)
	self.TabTitle = TabTitle
	local TabTitleFocus = LUI.UIText.new(0, 1, 11, -9, 0.5, 0.5, -10.5, 10.5)
	TabTitleFocus:setRGB(0, 0, 0)
	TabTitleFocus:setAlpha(0)
	TabTitleFocus:setTTF("ttmussels_demibold")
	TabTitleFocus:setLetterSpacing(3)
	TabTitleFocus:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	TabTitleFocus:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	TabTitleFocus:linkToElementModel(self, "tabName", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			TabTitleFocus:setText(LocalizeToUpperString(f5_local0))
		end
	end)
	self:addElement(TabTitleFocus)
	self.TabTitleFocus = TabTitleFocus
	local TabEndLeft = LUI.UIImage.new(0, 0, 9, 17, 0, 0, 0, 35)
	TabEndLeft:setAlpha(0)
	TabEndLeft:setImage(RegisterImage(0x9A262142D19A9F))
	self:addElement(TabEndLeft)
	self.TabEndLeft = TabEndLeft
	local TabEndRight = LUI.UIImage.new(0, 0, 217, 225, 0, 0, 0, 35)
	TabEndRight:setAlpha(0)
	TabEndRight:setImage(RegisterImage(0xB48CD982934DAD0))
	self:addElement(TabEndRight)
	self.TabEndRight = TabEndRight
	local newIcon = CoD.NewBreadcrumbCount.new(f1_arg0, f1_arg1, 0, 0, 203, 221, 0.5, 0.5, -26, -8)
	newIcon:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "breadcrumbCount", 0)
			end,
		},
	})
	newIcon:linkToElementModel(newIcon, "breadcrumbCount", true, function(model)
		f1_arg0:updateElementState(newIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "breadcrumbCount",
		})
	end)
	newIcon:linkToElementModel(self, "breadcrumb", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			newIcon:setModel(f8_local0, f1_arg1)
		end
	end)
	self:addElement(newIcon)
	self.newIcon = newIcon
	self:mergeStateConditions({
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueNilOrTrue(self, f1_arg1, "available")
			end,
		},
		{
			stateName = "Zombies",
			condition = function(menu, element, event)
				return IsZombies()
			end,
		},
	})
	self:linkToElementModel(self, "available", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "available",
		})
	end)
	local f1_local15 = self
	local f1_local16 = self.subscribeToModel
	local f1_local17 = Engine[0x8DF2E5447F384B9]()
	f1_local16(f1_local15, f1_local17["lobbyRoot.lobbyNav"], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CommonTab.__resetProperties = function(f13_arg0)
	f13_arg0.TabTitleFocus:completeAnimation()
	f13_arg0.TabTitle:completeAnimation()
	f13_arg0.TabBackingGlow:completeAnimation()
	f13_arg0.TabEndLeft:completeAnimation()
	f13_arg0.TabEndRight:completeAnimation()
	f13_arg0.TabBacking:completeAnimation()
	f13_arg0.ZMText:completeAnimation()
	f13_arg0.ZMTabBackingGlowRed:completeAnimation()
	f13_arg0.ZMTabBackingRed:completeAnimation()
	f13_arg0.ZMTextFocus:completeAnimation()
	f13_arg0.ZMTabEndLeft:completeAnimation()
	f13_arg0.ZMTabEndRight:completeAnimation()
	f13_arg0.TabTitleFocus:setLeftRight(0, 1, 11, -9)
	f13_arg0.TabTitleFocus:setRGB(0, 0, 0)
	f13_arg0.TabTitleFocus:setAlpha(0)
	f13_arg0.TabTitle:setRGB(0.66, 0.63, 0.52)
	f13_arg0.TabTitle:setAlpha(0)
	f13_arg0.TabBackingGlow:setAlpha(0)
	f13_arg0.TabEndLeft:setLeftRight(0, 0, 9, 17)
	f13_arg0.TabEndLeft:setAlpha(0)
	f13_arg0.TabEndRight:setLeftRight(0, 0, 217, 225)
	f13_arg0.TabEndRight:setAlpha(0)
	f13_arg0.TabBacking:setAlpha(0)
	f13_arg0.TabBacking:setShaderVector(0, 0.9, 0, 0, 0)
	f13_arg0.ZMText:setRGB(ColorSet.T8__BEIGE__HEADER.r, ColorSet.T8__BEIGE__HEADER.g, ColorSet.T8__BEIGE__HEADER.b)
	f13_arg0.ZMText:setAlpha(0)
	f13_arg0.ZMTabBackingGlowRed:setAlpha(0)
	f13_arg0.ZMTabBackingRed:setAlpha(0)
	f13_arg0.ZMTabBackingRed:setShaderVector(0, 0.9, 0, 0, 0)
	f13_arg0.ZMTextFocus:setAlpha(0)
	f13_arg0.ZMTabEndLeft:setLeftRight(0, 0, 0, 8)
	f13_arg0.ZMTabEndLeft:setAlpha(0)
	f13_arg0.ZMTabEndRight:setLeftRight(1, 1, -8, 0)
	f13_arg0.ZMTabEndRight:setAlpha(0)
end
CoD.CommonTab.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(2)
			f14_arg0.TabTitle:completeAnimation()
			f14_arg0.TabTitle:setRGB(0.66, 0.63, 0.52)
			f14_arg0.TabTitle:setAlpha(1)
			f14_arg0.clipFinished(f14_arg0.TabTitle)
			f14_arg0.TabTitleFocus:completeAnimation()
			f14_arg0.TabTitleFocus:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.TabTitleFocus)
		end,
		Active = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(6)
			local f15_local0 = function(f16_arg0)
				f15_arg0.TabBackingGlow:beginAnimation(200)
				f15_arg0.TabBackingGlow:setAlpha(0.95)
				f15_arg0.TabBackingGlow:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.TabBackingGlow:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.TabBackingGlow:completeAnimation()
			f15_arg0.TabBackingGlow:setAlpha(0)
			f15_local0(f15_arg0.TabBackingGlow)
			local f15_local1 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					f18_arg0:beginAnimation(49)
					f18_arg0:setAlpha(0.5)
					f18_arg0:setShaderVector(0, 1, 0, 0, 0)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
				end
				f17_arg0:beginAnimation(50)
				f17_arg0:setAlpha(0.25)
				f17_arg0:setShaderVector(0, 2, 0, 0, 0)
				f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f15_arg0.TabBacking:beginAnimation(100)
			f15_arg0.TabBacking:setAlpha(0)
			f15_arg0.TabBacking:setShaderVector(0, 1, 0, 0, 0)
			f15_arg0.TabBacking:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
			f15_arg0.TabBacking:registerEventHandler("transition_complete_keyframe", f15_local1)
			local f15_local2 = function(f19_arg0)
				f15_arg0.TabTitle:beginAnimation(100)
				f15_arg0.TabTitle:setAlpha(0)
				f15_arg0.TabTitle:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.TabTitle:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.TabTitle:completeAnimation()
			f15_arg0.TabTitle:setAlpha(1)
			f15_local2(f15_arg0.TabTitle)
			local f15_local3 = function(f20_arg0)
				f15_arg0.TabTitleFocus:beginAnimation(100)
				f15_arg0.TabTitleFocus:setAlpha(1)
				f15_arg0.TabTitleFocus:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.TabTitleFocus:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.TabTitleFocus:completeAnimation()
			f15_arg0.TabTitleFocus:setAlpha(0)
			f15_local3(f15_arg0.TabTitleFocus)
			local f15_local4 = function(f21_arg0)
				local f21_local0 = function(f22_arg0)
					f22_arg0:beginAnimation(40)
					f22_arg0:setLeftRight(0, 0, 1, 9)
					f22_arg0:setAlpha(1)
					f22_arg0:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
				end
				f15_arg0.TabEndLeft:beginAnimation(160)
				f15_arg0.TabEndLeft:setLeftRight(0, 0, -2, 6)
				f15_arg0.TabEndLeft:setAlpha(0.8)
				f15_arg0.TabEndLeft:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.TabEndLeft:registerEventHandler("transition_complete_keyframe", f21_local0)
			end
			f15_arg0.TabEndLeft:completeAnimation()
			f15_arg0.TabEndLeft:setLeftRight(0, 0, 17, 25)
			f15_arg0.TabEndLeft:setAlpha(0)
			f15_local4(f15_arg0.TabEndLeft)
			local f15_local5 = function(f23_arg0)
				local f23_local0 = function(f24_arg0)
					f24_arg0:beginAnimation(40)
					f24_arg0:setLeftRight(0, 0, 225, 233)
					f24_arg0:setAlpha(1)
					f24_arg0:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
				end
				f15_arg0.TabEndRight:beginAnimation(160)
				f15_arg0.TabEndRight:setLeftRight(0, 0, 228, 236)
				f15_arg0.TabEndRight:setAlpha(0.8)
				f15_arg0.TabEndRight:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.TabEndRight:registerEventHandler("transition_complete_keyframe", f23_local0)
			end
			f15_arg0.TabEndRight:completeAnimation()
			f15_arg0.TabEndRight:setLeftRight(0, 0, 210, 218)
			f15_arg0.TabEndRight:setAlpha(0)
			f15_local5(f15_arg0.TabEndRight)
		end,
		ActiveAndFocus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(1)
			f25_arg0.TabTitle:completeAnimation()
			f25_arg0.TabTitle:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f25_arg0.TabTitle:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.TabTitle)
		end,
		Focus = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(1)
			f26_arg0.TabTitle:completeAnimation()
			f26_arg0.TabTitle:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f26_arg0.TabTitle:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.TabTitle)
		end,
		ActiveToFocus = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(1)
			local f27_local0 = function(f28_arg0)
				f27_arg0.TabTitle:beginAnimation(150)
				f27_arg0.TabTitle:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
				f27_arg0.TabTitle:registerEventHandler("interrupted_keyframe", f27_arg0.clipInterrupted)
				f27_arg0.TabTitle:registerEventHandler("transition_complete_keyframe", f27_arg0.clipFinished)
			end
			f27_arg0.TabTitle:completeAnimation()
			f27_arg0.TabTitle:setRGB(0.92, 0.92, 0.92)
			f27_arg0.TabTitle:setAlpha(1)
			f27_local0(f27_arg0.TabTitle)
		end,
	},
	Unavailable = {
		DefaultClip = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(1)
			f29_arg0.TabTitle:completeAnimation()
			f29_arg0.TabTitle:setRGB(0.13, 0.13, 0.13)
			f29_arg0.TabTitle:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.TabTitle)
		end,
	},
	Zombies = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(2)
			f30_arg0.ZMText:completeAnimation()
			f30_arg0.ZMText:setAlpha(0)
			f30_arg0.clipFinished(f30_arg0.ZMText)
			f30_arg0.TabTitle:completeAnimation()
			f30_arg0.TabTitle:setRGB(0.92, 0.89, 0.72)
			f30_arg0.TabTitle:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.TabTitle)
		end,
		Active = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(7)
			local f31_local0 = function(f32_arg0)
				f31_arg0.ZMTabBackingGlowRed:beginAnimation(200)
				f31_arg0.ZMTabBackingGlowRed:setAlpha(0.95)
				f31_arg0.ZMTabBackingGlowRed:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.ZMTabBackingGlowRed:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.ZMTabBackingGlowRed:completeAnimation()
			f31_arg0.ZMTabBackingGlowRed:setAlpha(0)
			f31_local0(f31_arg0.ZMTabBackingGlowRed)
			local f31_local1 = function(f33_arg0)
				local f33_local0 = function(f34_arg0)
					local f34_local0 = function(f35_arg0)
						f35_arg0:beginAnimation(49)
						f35_arg0:setAlpha(0.5)
						f35_arg0:setShaderVector(0, 0.9, 0, 0, 0)
						f35_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
					end
					f34_arg0:beginAnimation(50)
					f34_arg0:setAlpha(0.25)
					f34_arg0:setShaderVector(0, 2, 0, 0, 0)
					f34_arg0:registerEventHandler("transition_complete_keyframe", f34_local0)
				end
				f31_arg0.ZMTabBackingRed:beginAnimation(100)
				f31_arg0.ZMTabBackingRed:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.ZMTabBackingRed:registerEventHandler("transition_complete_keyframe", f33_local0)
			end
			f31_arg0.ZMTabBackingRed:completeAnimation()
			f31_arg0.ZMTabBackingRed:setAlpha(0)
			f31_arg0.ZMTabBackingRed:setShaderVector(0, 0.9, 0, 0, 0)
			f31_local1(f31_arg0.ZMTabBackingRed)
			f31_arg0.ZMTextFocus:completeAnimation()
			f31_arg0.ZMTextFocus:setAlpha(0)
			f31_arg0.clipFinished(f31_arg0.ZMTextFocus)
			local f31_local2 = function(f36_arg0)
				local f36_local0 = function(f37_arg0)
					f37_arg0:beginAnimation(40)
					f37_arg0:setLeftRight(1, 1, -9, -1)
					f37_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
				end
				f31_arg0.ZMTabEndRight:beginAnimation(160)
				f31_arg0.ZMTabEndRight:setLeftRight(1, 1, -6, 2)
				f31_arg0.ZMTabEndRight:setAlpha(1)
				f31_arg0.ZMTabEndRight:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.ZMTabEndRight:registerEventHandler("transition_complete_keyframe", f36_local0)
			end
			f31_arg0.ZMTabEndRight:completeAnimation()
			f31_arg0.ZMTabEndRight:setLeftRight(1, 1, -24, -16)
			f31_arg0.ZMTabEndRight:setAlpha(0)
			f31_local2(f31_arg0.ZMTabEndRight)
			local f31_local3 = function(f38_arg0)
				local f38_local0 = function(f39_arg0)
					f39_arg0:beginAnimation(40)
					f39_arg0:setLeftRight(0, 0, 1, 9)
					f39_arg0:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
				end
				f31_arg0.ZMTabEndLeft:beginAnimation(160)
				f31_arg0.ZMTabEndLeft:setLeftRight(0, 0, -2, 6)
				f31_arg0.ZMTabEndLeft:setAlpha(1)
				f31_arg0.ZMTabEndLeft:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.ZMTabEndLeft:registerEventHandler("transition_complete_keyframe", f38_local0)
			end
			f31_arg0.ZMTabEndLeft:completeAnimation()
			f31_arg0.ZMTabEndLeft:setLeftRight(0, 0, 17, 25)
			f31_arg0.ZMTabEndLeft:setAlpha(0)
			f31_local3(f31_arg0.ZMTabEndLeft)
			local f31_local4 = function(f40_arg0)
				f31_arg0.TabTitle:beginAnimation(100)
				f31_arg0.TabTitle:setAlpha(0)
				f31_arg0.TabTitle:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.TabTitle:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.TabTitle:completeAnimation()
			f31_arg0.TabTitle:setRGB(0.92, 0.89, 0.72)
			f31_arg0.TabTitle:setAlpha(1)
			f31_local4(f31_arg0.TabTitle)
			local f31_local5 = function(f41_arg0)
				f31_arg0.TabTitleFocus:beginAnimation(100)
				f31_arg0.TabTitleFocus:setAlpha(1)
				f31_arg0.TabTitleFocus:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.TabTitleFocus:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.TabTitleFocus:completeAnimation()
			f31_arg0.TabTitleFocus:setLeftRight(-0, 1, 11, -9)
			f31_arg0.TabTitleFocus:setRGB(0, 0, 0)
			f31_arg0.TabTitleFocus:setAlpha(0)
			f31_local5(f31_arg0.TabTitleFocus)
		end,
		Focus = function(f42_arg0, f42_arg1)
			f42_arg0:__resetProperties()
			f42_arg0:setupElementClipCounter(2)
			f42_arg0.ZMTabBackingGlowRed:completeAnimation()
			f42_arg0.ZMTabBackingGlowRed:setAlpha(0.95)
			f42_arg0.clipFinished(f42_arg0.ZMTabBackingGlowRed)
			f42_arg0.ZMText:completeAnimation()
			f42_arg0.ZMText:setRGB(0, 0, 0)
			f42_arg0.clipFinished(f42_arg0.ZMText)
		end,
	},
}
if not CoD.isPC then
	CoD.CommonTab.__clipsPerState.DefaultState.ActiveAndFocus = nil
	CoD.CommonTab.__clipsPerState.DefaultState.Focus = nil
end
CoD.CommonTab.__onClose = function(f43_arg0)
	f43_arg0.ZMTextFocus:close()
	f43_arg0.ZMText:close()
	f43_arg0.TabTitle:close()
	f43_arg0.TabTitleFocus:close()
	f43_arg0.newIcon:close()
end
