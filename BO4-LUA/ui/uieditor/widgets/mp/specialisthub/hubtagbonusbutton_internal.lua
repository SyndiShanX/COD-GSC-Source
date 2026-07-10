require("x64:fa3f15fd69b38b3")
require("x64:94acc3cb318e13b")
require("x64:8ffe7c4e01e7052")
require("x64:5f8cf56752aa71b")
require("x64:2d361ac3553c22a")
CoD.HubTagBonusButton_Internal = InheritFrom(LUI.UIElement)
CoD.HubTagBonusButton_Internal.__defaultWidth = 152
CoD.HubTagBonusButton_Internal.__defaultHeight = 152
CoD.HubTagBonusButton_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HubTagBonusButton_Internal)
	self.id = "HubTagBonusButton_Internal"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setRGB(1, 0.78, 0)
	NoiseTiledBacking:setAlpha(0.8)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local BGAdd = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BGAdd:setRGB(0.77, 0.78, 0)
	BGAdd:setAlpha(0.02)
	BGAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(BGAdd)
	self.BGAdd = BGAdd
	local FrameBorder = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -2, 2)
	FrameBorder:setRGB(1, 0.58, 0)
	FrameBorder:setImage(RegisterImage(0x185E11D74ECA3D7))
	FrameBorder:setMaterial(LUI.UIImage.GetCachedMaterial(0xDAB59B2CAE01851))
	FrameBorder:setShaderVector(0, 0, 0, 0, 0)
	FrameBorder:setShaderVector(1, 1, 0, 0, 0)
	FrameBorder:setupNineSliceShader(12, 12)
	self:addElement(FrameBorder)
	self.FrameBorder = FrameBorder
	local tag = LUI.UIImage.new(0, 1, 5, -5, 0, 1, 5, -5)
	tag:linkToElementModel(self, "image", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			tag:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(tag)
	self.tag = tag
	local caclock = CoD.BM_Lock.new(f1_arg0, f1_arg1, 0.5, 0.5, -24, 24, 0.5, 0.5, -24, 24)
	caclock:setAlpha(0)
	caclock:setScale(0.6, 0.6)
	self:addElement(caclock)
	self.caclock = caclock
	local BMGoldBar = CoD.BM_GoldBarMed.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0.5, 0.5, -15, 15)
	BMGoldBar:setAlpha(0)
	self:addElement(BMGoldBar)
	self.BMGoldBar = BMGoldBar
	local FrontendFrame = LUI.UIImage.new(0, 1, -1, 1, 0, 1, -1, 1)
	FrontendFrame:setAlpha(0.2)
	FrontendFrame:setImage(RegisterImage(0x185E11D74ECA3D7))
	FrontendFrame:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrontendFrame:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrame:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrame)
	self.FrontendFrame = FrontendFrame
	local CommonButtonOutline = CoD.CommonButtonOutline.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	CommonButtonOutline.Lines:setAlpha(0)
	self:addElement(CommonButtonOutline)
	self.CommonButtonOutline = CommonButtonOutline
	local BreadcrumbNew = CoD.ItemNewBreadcrumbWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -78, 78, 0.5, 0.5, -18, 18)
	BreadcrumbNew:setAlpha(0)
	self:addElement(BreadcrumbNew)
	self.BreadcrumbNew = BreadcrumbNew
	local TrialWidget = CoD.TrialWidget.new(f1_arg0, f1_arg1, 0, 0, 5, 30, 0, 0, 5, 30)
	TrialWidget:setAlpha(0)
	self:addElement(TrialWidget)
	self.TrialWidget = TrialWidget
	self:mergeStateConditions({
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "available")
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "owned")
			end,
		},
		{
			stateName = "TrialLocked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "trialLocked")
			end,
		},
		{
			stateName = "New",
			condition = function(menu, element, event)
				return CoD.BreadcrumbUtility.IsSpecialistSprayGestureNew(menu, element, f1_arg1)
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
	self:linkToElementModel(self, "owned", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "owned",
		})
	end)
	self:linkToElementModel(self, "trialLocked", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "trialLocked",
		})
	end)
	self:linkToElementModel(self, "index", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "index",
		})
	end)
	CommonButtonOutline.id = "CommonButtonOutline"
	self.__defaultFocus = CommonButtonOutline
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.HubTagBonusButton_Internal.__resetProperties = function(f12_arg0)
	f12_arg0.caclock:completeAnimation()
	f12_arg0.tag:completeAnimation()
	f12_arg0.BMGoldBar:completeAnimation()
	f12_arg0.TrialWidget:completeAnimation()
	f12_arg0.BreadcrumbNew:completeAnimation()
	f12_arg0.caclock:setRGB(1, 1, 1)
	f12_arg0.caclock:setAlpha(0)
	f12_arg0.caclock:setScale(0.6, 0.6)
	f12_arg0.tag:setRGB(1, 1, 1)
	f12_arg0.tag:setAlpha(1)
	f12_arg0.BMGoldBar:setAlpha(0)
	f12_arg0.TrialWidget:setAlpha(0)
	f12_arg0.BreadcrumbNew:setAlpha(0)
end
CoD.HubTagBonusButton_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.caclock:completeAnimation()
			f13_arg0.caclock:setScale(0.6, 0.6)
			f13_arg0.clipFinished(f13_arg0.caclock)
		end,
		ChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.caclock:completeAnimation()
			f14_arg0.caclock:setScale(0.6, 0.6)
			f14_arg0.clipFinished(f14_arg0.caclock)
		end,
		GainChildFocus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.caclock:completeAnimation()
			f15_arg0.caclock:setScale(0.6, 0.6)
			f15_arg0.clipFinished(f15_arg0.caclock)
		end,
		LoseChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.caclock:completeAnimation()
			f16_arg0.caclock:setScale(0.6, 0.6)
			f16_arg0.clipFinished(f16_arg0.caclock)
		end,
	},
	Unavailable = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(2)
			f17_arg0.tag:completeAnimation()
			f17_arg0.tag:setAlpha(0)
			f17_arg0.clipFinished(f17_arg0.tag)
			f17_arg0.BMGoldBar:completeAnimation()
			f17_arg0.BMGoldBar:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.BMGoldBar)
		end,
	},
	Hidden = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			f18_arg0.tag:completeAnimation()
			f18_arg0.tag:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.tag)
		end,
	},
	Locked = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(2)
			f19_arg0.tag:completeAnimation()
			f19_arg0.tag:setRGB(0.29, 0.29, 0.29)
			f19_arg0.clipFinished(f19_arg0.tag)
			f19_arg0.caclock:completeAnimation()
			f19_arg0.caclock:setRGB(1, 1, 1)
			f19_arg0.caclock:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.caclock)
		end,
		ChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(2)
			f20_arg0.tag:completeAnimation()
			f20_arg0.tag:setRGB(0.49, 0.49, 0.49)
			f20_arg0.clipFinished(f20_arg0.tag)
			f20_arg0.caclock:completeAnimation()
			f20_arg0.caclock:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.caclock)
		end,
		GainChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			local f21_local0 = function(f22_arg0)
				f21_arg0.tag:beginAnimation(200)
				f21_arg0.tag:setRGB(0.49, 0.49, 0.49)
				f21_arg0.tag:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.tag:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.tag:completeAnimation()
			f21_arg0.tag:setRGB(0.29, 0.29, 0.29)
			f21_local0(f21_arg0.tag)
			local f21_local1 = function(f23_arg0)
				f21_arg0.caclock:beginAnimation(200)
				f21_arg0.caclock:registerEventHandler("interrupted_keyframe", f21_arg0.clipInterrupted)
				f21_arg0.caclock:registerEventHandler("transition_complete_keyframe", f21_arg0.clipFinished)
			end
			f21_arg0.caclock:completeAnimation()
			f21_arg0.caclock:setRGB(1, 1, 1)
			f21_arg0.caclock:setAlpha(1)
			f21_local1(f21_arg0.caclock)
		end,
		LoseChildFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			local f24_local0 = function(f25_arg0)
				f24_arg0.tag:beginAnimation(200)
				f24_arg0.tag:setRGB(0.29, 0.29, 0.29)
				f24_arg0.tag:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.tag:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.tag:completeAnimation()
			f24_arg0.tag:setRGB(0.49, 0.49, 0.49)
			f24_local0(f24_arg0.tag)
			local f24_local1 = function(f26_arg0)
				f24_arg0.caclock:beginAnimation(200)
				f24_arg0.caclock:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.caclock:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.caclock:completeAnimation()
			f24_arg0.caclock:setRGB(1, 1, 1)
			f24_arg0.caclock:setAlpha(1)
			f24_local1(f24_arg0.caclock)
		end,
	},
	TrialLocked = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(2)
			f27_arg0.caclock:completeAnimation()
			f27_arg0.caclock:setScale(0.6, 0.6)
			f27_arg0.clipFinished(f27_arg0.caclock)
			f27_arg0.TrialWidget:completeAnimation()
			f27_arg0.TrialWidget:setAlpha(1)
			f27_arg0.clipFinished(f27_arg0.TrialWidget)
		end,
		ChildFocus = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(2)
			f28_arg0.caclock:completeAnimation()
			f28_arg0.caclock:setScale(0.6, 0.6)
			f28_arg0.clipFinished(f28_arg0.caclock)
			f28_arg0.TrialWidget:completeAnimation()
			f28_arg0.TrialWidget:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.TrialWidget)
		end,
		GainChildFocus = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(2)
			f29_arg0.caclock:completeAnimation()
			f29_arg0.caclock:setScale(0.6, 0.6)
			f29_arg0.clipFinished(f29_arg0.caclock)
			f29_arg0.TrialWidget:completeAnimation()
			f29_arg0.TrialWidget:setAlpha(1)
			f29_arg0.clipFinished(f29_arg0.TrialWidget)
		end,
		LoseChildFocus = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(2)
			f30_arg0.caclock:completeAnimation()
			f30_arg0.caclock:setScale(0.6, 0.6)
			f30_arg0.clipFinished(f30_arg0.caclock)
			f30_arg0.TrialWidget:completeAnimation()
			f30_arg0.TrialWidget:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.TrialWidget)
		end,
	},
	New = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(2)
			f31_arg0.caclock:completeAnimation()
			f31_arg0.caclock:setScale(0.6, 0.6)
			f31_arg0.clipFinished(f31_arg0.caclock)
			f31_arg0.BreadcrumbNew:completeAnimation()
			f31_arg0.BreadcrumbNew:setAlpha(1)
			f31_arg0.clipFinished(f31_arg0.BreadcrumbNew)
		end,
		ChildFocus = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(2)
			f32_arg0.caclock:completeAnimation()
			f32_arg0.caclock:setScale(0.6, 0.6)
			f32_arg0.clipFinished(f32_arg0.caclock)
			local f32_local0 = function(f33_arg0)
				local f33_local0 = function(f34_arg0)
					f34_arg0:beginAnimation(200)
					f34_arg0:setAlpha(0)
					f34_arg0:registerEventHandler("transition_complete_keyframe", f32_arg0.clipFinished)
				end
				f32_arg0.BreadcrumbNew:beginAnimation(400)
				f32_arg0.BreadcrumbNew:registerEventHandler("interrupted_keyframe", f32_arg0.clipInterrupted)
				f32_arg0.BreadcrumbNew:registerEventHandler("transition_complete_keyframe", f33_local0)
			end
			f32_arg0.BreadcrumbNew:completeAnimation()
			f32_arg0.BreadcrumbNew:setAlpha(1)
			f32_local0(f32_arg0.BreadcrumbNew)
		end,
		GainChildFocus = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(2)
			f35_arg0.caclock:completeAnimation()
			f35_arg0.caclock:setScale(0.6, 0.6)
			f35_arg0.clipFinished(f35_arg0.caclock)
			f35_arg0.BreadcrumbNew:completeAnimation()
			f35_arg0.BreadcrumbNew:setAlpha(1)
			f35_arg0.clipFinished(f35_arg0.BreadcrumbNew)
		end,
		LoseChildFocus = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(2)
			f36_arg0.caclock:completeAnimation()
			f36_arg0.caclock:setScale(0.6, 0.6)
			f36_arg0.clipFinished(f36_arg0.caclock)
			f36_arg0.BreadcrumbNew:completeAnimation()
			f36_arg0.BreadcrumbNew:setAlpha(1)
			f36_arg0.clipFinished(f36_arg0.BreadcrumbNew)
		end,
	},
}
CoD.HubTagBonusButton_Internal.__onClose = function(f37_arg0)
	f37_arg0.tag:close()
	f37_arg0.caclock:close()
	f37_arg0.BMGoldBar:close()
	f37_arg0.CommonButtonOutline:close()
	f37_arg0.BreadcrumbNew:close()
	f37_arg0.TrialWidget:close()
end
