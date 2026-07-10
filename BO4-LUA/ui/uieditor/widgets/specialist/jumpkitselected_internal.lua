require("x64:fa3f15fd69b38b3")
require("x64:94acc3cb318e13b")
require("x64:8ffe7c4e01e7052")
require("x64:fd51e83e2e6dbd1")
require("x64:2d361ac3553c22a")
CoD.JumpkitSelected_Internal = InheritFrom(LUI.UIElement)
CoD.JumpkitSelected_Internal.__defaultWidth = 152
CoD.JumpkitSelected_Internal.__defaultHeight = 152
CoD.JumpkitSelected_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.JumpkitSelected_Internal)
	self.id = "JumpkitSelected_Internal"
	self.soundSet = "FrontendMain"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.5)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local icon = LUI.UIImage.new(0, 1, 5, -5, 0, 1, 5, -5)
	icon:linkToElementModel(self, "icon", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			icon:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(icon)
	self.icon = icon
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
	FrontendFrame:setAlpha(0.1)
	FrontendFrame:setImage(RegisterImage(@"uie_ui_menu_store_common_frame"))
	FrontendFrame:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_add"))
	FrontendFrame:setShaderVector(0, 0, 0, 0, 0)
	FrontendFrame:setupNineSliceShader(12, 12)
	self:addElement(FrontendFrame)
	self.FrontendFrame = FrontendFrame
	local BreadcrumbNew = CoD.ItemNewBreadcrumbWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -78, 78, 0.5, 0.5, -18, 18)
	BreadcrumbNew:setAlpha(0)
	self:addElement(BreadcrumbNew)
	self.BreadcrumbNew = BreadcrumbNew
	local TrialWidget = CoD.TrialWidget.new(f1_arg0, f1_arg1, 0, 0, 5, 30, 0, 0, 5, 30)
	TrialWidget:setAlpha(0)
	self:addElement(TrialWidget)
	self.TrialWidget = TrialWidget
	local EquippedMarkerTick = CoD.onOffImage.new(f1_arg0, f1_arg1, 1, 1, -34, 10, 0, 0, -9, 35)
	EquippedMarkerTick:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				return CoD.PlayerRoleUtility.IsEquippedJumpkitItem(menu, f1_arg1, element)
			end,
		},
	})
	local f1_local9 = EquippedMarkerTick
	local f1_local10 = EquippedMarkerTick.subscribeToModel
	local f1_local11 = DataSources.WZJumpKitItems.getModel(f1_arg1)
	f1_local10(f1_local9, f1_local11.updateSelections, function(f4_arg0)
		f1_arg0:updateElementState(EquippedMarkerTick, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "updateSelections",
		})
	end, false)
	EquippedMarkerTick:setZoom(4)
	EquippedMarkerTick.image:setImage(RegisterImage(@"uie_ui_menu_cac_equipped_marker_tick"))
	EquippedMarkerTick:linkToElementModel(self, nil, false, function(model)
		EquippedMarkerTick:setModel(model, f1_arg1)
	end)
	self:addElement(EquippedMarkerTick)
	self.EquippedMarkerTick = EquippedMarkerTick
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
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.JumpkitSelected_Internal.__resetProperties = function(f13_arg0)
	f13_arg0.caclock:completeAnimation()
	f13_arg0.icon:completeAnimation()
	f13_arg0.BMGoldBar:completeAnimation()
	f13_arg0.TrialWidget:completeAnimation()
	f13_arg0.caclock:setRGB(1, 1, 1)
	f13_arg0.caclock:setAlpha(0)
	f13_arg0.caclock:setScale(0.6, 0.6)
	f13_arg0.icon:setRGB(1, 1, 1)
	f13_arg0.icon:setAlpha(1)
	f13_arg0.BMGoldBar:setAlpha(0)
	f13_arg0.TrialWidget:setAlpha(0)
end
CoD.JumpkitSelected_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.caclock:completeAnimation()
			f14_arg0.caclock:setScale(0.6, 0.6)
			f14_arg0.clipFinished(f14_arg0.caclock)
		end,
		ChildFocus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			f15_arg0.caclock:completeAnimation()
			f15_arg0.caclock:setScale(0.6, 0.6)
			f15_arg0.clipFinished(f15_arg0.caclock)
		end,
		GainChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(1)
			f16_arg0.caclock:completeAnimation()
			f16_arg0.caclock:setScale(0.6, 0.6)
			f16_arg0.clipFinished(f16_arg0.caclock)
		end,
		LoseChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.caclock:completeAnimation()
			f17_arg0.caclock:setScale(0.6, 0.6)
			f17_arg0.clipFinished(f17_arg0.caclock)
		end,
	},
	Unavailable = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(2)
			f18_arg0.icon:completeAnimation()
			f18_arg0.icon:setAlpha(0)
			f18_arg0.clipFinished(f18_arg0.icon)
			f18_arg0.BMGoldBar:completeAnimation()
			f18_arg0.BMGoldBar:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.BMGoldBar)
		end,
	},
	Hidden = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			f19_arg0.icon:completeAnimation()
			f19_arg0.icon:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.icon)
		end,
		ChildFocus = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(2)
			f20_arg0.icon:completeAnimation()
			f20_arg0.icon:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.icon)
			f20_arg0.caclock:completeAnimation()
			f20_arg0.caclock:setScale(0.6, 0.6)
			f20_arg0.clipFinished(f20_arg0.caclock)
		end,
		GainChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			f21_arg0.icon:completeAnimation()
			f21_arg0.icon:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.icon)
			f21_arg0.caclock:completeAnimation()
			f21_arg0.caclock:setScale(0.6, 0.6)
			f21_arg0.clipFinished(f21_arg0.caclock)
		end,
		LoseChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(2)
			f22_arg0.icon:completeAnimation()
			f22_arg0.icon:setAlpha(0)
			f22_arg0.clipFinished(f22_arg0.icon)
			f22_arg0.caclock:completeAnimation()
			f22_arg0.caclock:setScale(0.6, 0.6)
			f22_arg0.clipFinished(f22_arg0.caclock)
		end,
	},
	Locked = {
		DefaultClip = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(2)
			f23_arg0.icon:completeAnimation()
			f23_arg0.icon:setRGB(0.29, 0.29, 0.29)
			f23_arg0.clipFinished(f23_arg0.icon)
			f23_arg0.caclock:completeAnimation()
			f23_arg0.caclock:setRGB(1, 1, 1)
			f23_arg0.caclock:setAlpha(1)
			f23_arg0.clipFinished(f23_arg0.caclock)
		end,
		ChildFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(2)
			f24_arg0.icon:completeAnimation()
			f24_arg0.icon:setRGB(0.49, 0.49, 0.49)
			f24_arg0.clipFinished(f24_arg0.icon)
			f24_arg0.caclock:completeAnimation()
			f24_arg0.caclock:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.caclock)
		end,
		GainChildFocus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(2)
			local f25_local0 = function(f26_arg0)
				f25_arg0.icon:beginAnimation(200)
				f25_arg0.icon:setRGB(0.49, 0.49, 0.49)
				f25_arg0.icon:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.icon:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.icon:completeAnimation()
			f25_arg0.icon:setRGB(0.29, 0.29, 0.29)
			f25_local0(f25_arg0.icon)
			local f25_local1 = function(f27_arg0)
				f25_arg0.caclock:beginAnimation(200)
				f25_arg0.caclock:registerEventHandler("interrupted_keyframe", f25_arg0.clipInterrupted)
				f25_arg0.caclock:registerEventHandler("transition_complete_keyframe", f25_arg0.clipFinished)
			end
			f25_arg0.caclock:completeAnimation()
			f25_arg0.caclock:setRGB(1, 1, 1)
			f25_arg0.caclock:setAlpha(1)
			f25_local1(f25_arg0.caclock)
		end,
		LoseChildFocus = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(2)
			local f28_local0 = function(f29_arg0)
				f28_arg0.icon:beginAnimation(200)
				f28_arg0.icon:setRGB(0.29, 0.29, 0.29)
				f28_arg0.icon:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.icon:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.icon:completeAnimation()
			f28_arg0.icon:setRGB(0.49, 0.49, 0.49)
			f28_local0(f28_arg0.icon)
			local f28_local1 = function(f30_arg0)
				f28_arg0.caclock:beginAnimation(200)
				f28_arg0.caclock:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.caclock:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.caclock:completeAnimation()
			f28_arg0.caclock:setRGB(1, 1, 1)
			f28_arg0.caclock:setAlpha(1)
			f28_local1(f28_arg0.caclock)
		end,
	},
	TrialLocked = {
		DefaultClip = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(2)
			f31_arg0.caclock:completeAnimation()
			f31_arg0.caclock:setScale(0.6, 0.6)
			f31_arg0.clipFinished(f31_arg0.caclock)
			f31_arg0.TrialWidget:completeAnimation()
			f31_arg0.TrialWidget:setAlpha(1)
			f31_arg0.clipFinished(f31_arg0.TrialWidget)
		end,
		ChildFocus = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(2)
			f32_arg0.caclock:completeAnimation()
			f32_arg0.caclock:setScale(0.6, 0.6)
			f32_arg0.clipFinished(f32_arg0.caclock)
			f32_arg0.TrialWidget:completeAnimation()
			f32_arg0.TrialWidget:setAlpha(1)
			f32_arg0.clipFinished(f32_arg0.TrialWidget)
		end,
		GainChildFocus = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(2)
			f33_arg0.caclock:completeAnimation()
			f33_arg0.caclock:setScale(0.6, 0.6)
			f33_arg0.clipFinished(f33_arg0.caclock)
			f33_arg0.TrialWidget:completeAnimation()
			f33_arg0.TrialWidget:setAlpha(1)
			f33_arg0.clipFinished(f33_arg0.TrialWidget)
		end,
		LoseChildFocus = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(2)
			f34_arg0.caclock:completeAnimation()
			f34_arg0.caclock:setScale(0.6, 0.6)
			f34_arg0.clipFinished(f34_arg0.caclock)
			f34_arg0.TrialWidget:completeAnimation()
			f34_arg0.TrialWidget:setAlpha(1)
			f34_arg0.clipFinished(f34_arg0.TrialWidget)
		end,
	},
}
CoD.JumpkitSelected_Internal.__onClose = function(f35_arg0)
	f35_arg0.icon:close()
	f35_arg0.caclock:close()
	f35_arg0.BMGoldBar:close()
	f35_arg0.BreadcrumbNew:close()
	f35_arg0.TrialWidget:close()
	f35_arg0.EquippedMarkerTick:close()
end
