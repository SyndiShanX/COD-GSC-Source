require("x64:fa3f15fd69b38b3")
require("x64:94acc3cb318e13b")
require("x64:8ffe7c4e01e7052")
require("x64:5f8cf56752aa71b")
require("x64:fd51e83e2e6dbd1")
require("x64:2d361ac3553c22a")
CoD.LootWeaponOptionButtonInternal = InheritFrom(LUI.UIElement)
CoD.LootWeaponOptionButtonInternal.__defaultWidth = 152
CoD.LootWeaponOptionButtonInternal.__defaultHeight = 152
CoD.LootWeaponOptionButtonInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LootWeaponOptionButtonInternal)
	self.id = "LootWeaponOptionButtonInternal"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseTiledBacking:setAlpha(0.8)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local Icon = LUI.UIImage.new(0, 1, 5, -5, 0, 1, 5, -5)
	Icon:linkToElementModel(self, "icon", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Icon:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(Icon)
	self.Icon = Icon
	local Name = LUI.UIText.new(0, 1, 5, -5, 1, 1, -21, -3)
	Name:setAlpha(0)
	Name:setTTF("ttmussels_demibold")
	Name:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Name:linkToElementModel(self, "displayName", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Name:setText(ToUpper(f3_local0))
		end
	end)
	self:addElement(Name)
	self.Name = Name
	local LockTickBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	LockTickBacking:setRGB(ColorSet.Title.r, ColorSet.Title.g, ColorSet.Title.b)
	LockTickBacking:setAlpha(0)
	LockTickBacking:setImage(RegisterImage(0xCE50842B84CCD5D))
	self:addElement(LockTickBacking)
	self.LockTickBacking = LockTickBacking
	local LockedIcon = LUI.UIImage.new(0.5, 0.5, -15, 15, 0.5, 0.5, -15, 15)
	LockedIcon:setAlpha(0)
	LockedIcon:setImage(RegisterImage(0xB8AD8D12CEB707D))
	self:addElement(LockedIcon)
	self.LockedIcon = LockedIcon
	local BMLock = CoD.BM_Lock.new(f1_arg0, f1_arg1, 0.5, 0.5, -24, 24, 0.5, 0.5, -24, 24)
	BMLock:setAlpha(0)
	BMLock:setScale(0.6, 0.6)
	self:addElement(BMLock)
	self.BMLock = BMLock
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
	local EquippedMarkerTick = CoD.onOffImage.new(f1_arg0, f1_arg1, 1, 1, -34, 10, 0, 0, -9, 35)
	EquippedMarkerTick:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				return IsElementModelConditionFn(menu, self, self, f1_arg1, "isEquippedFn")
			end,
		},
	})
	EquippedMarkerTick:setZoom(4)
	EquippedMarkerTick.image:setImage(RegisterImage(0x9A8B26C9B001758))
	EquippedMarkerTick:linkToElementModel(self, nil, false, function(model)
		EquippedMarkerTick:setModel(model, f1_arg1)
	end)
	self:addElement(EquippedMarkerTick)
	self.EquippedMarkerTick = EquippedMarkerTick
	self:mergeStateConditions({
		{
			stateName = "PrestigeAttachmentLocked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isPrestigeAttachment") and CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isLocked")
			end,
		},
		{
			stateName = "PrestigeAttachment",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isPrestigeAttachment")
			end,
		},
		{
			stateName = "Unavailable",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "available")
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
				local f11_local0
				if not CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isPrestigeAttachment") then
					f11_local0 = IsElementModelConditionFn(menu, self, self, f1_arg1, "isNewFn")
				else
					f11_local0 = false
				end
				return f11_local0
			end,
		},
	})
	self:linkToElementModel(self, "isPrestigeAttachment", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isPrestigeAttachment",
		})
	end)
	self:linkToElementModel(self, "isLocked", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isLocked",
		})
	end)
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
	self:subscribeToGlobalModel(f1_arg1, "WeaponCharmList", "updateSelections", function(model)
		local f17_local0 = self
		UpdateElementState(self, "EquippedMarkerTick", f1_arg1)
	end)
	self:subscribeToGlobalModel(f1_arg1, "WeaponDeathFxList", "updateSelections", function(model)
		local f18_local0 = self
		UpdateElementState(self, "EquippedMarkerTick", f1_arg1)
	end)
	CommonButtonOutline.id = "CommonButtonOutline"
	self.__defaultFocus = CommonButtonOutline
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LootWeaponOptionButtonInternal.__resetProperties = function(f19_arg0)
	f19_arg0.BMLock:completeAnimation()
	f19_arg0.Icon:completeAnimation()
	f19_arg0.Name:completeAnimation()
	f19_arg0.LockedIcon:completeAnimation()
	f19_arg0.LockTickBacking:completeAnimation()
	f19_arg0.BMGoldBar:completeAnimation()
	f19_arg0.TrialWidget:completeAnimation()
	f19_arg0.BreadcrumbNew:completeAnimation()
	f19_arg0.BMLock:setRGB(1, 1, 1)
	f19_arg0.BMLock:setAlpha(0)
	f19_arg0.BMLock:setScale(0.6, 0.6)
	f19_arg0.Icon:setRGB(1, 1, 1)
	f19_arg0.Icon:setAlpha(1)
	f19_arg0.Name:setAlpha(0)
	f19_arg0.LockedIcon:setAlpha(0)
	f19_arg0.LockTickBacking:setAlpha(0)
	f19_arg0.BMGoldBar:setAlpha(0)
	f19_arg0.TrialWidget:setAlpha(0)
	f19_arg0.BreadcrumbNew:setAlpha(0)
end
CoD.LootWeaponOptionButtonInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.BMLock:completeAnimation()
			f20_arg0.BMLock:setScale(0.6, 0.6)
			f20_arg0.clipFinished(f20_arg0.BMLock)
		end,
		ChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			f21_arg0.BMLock:completeAnimation()
			f21_arg0.BMLock:setScale(0.6, 0.6)
			f21_arg0.clipFinished(f21_arg0.BMLock)
		end,
		GainChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			f22_arg0.BMLock:completeAnimation()
			f22_arg0.BMLock:setScale(0.6, 0.6)
			f22_arg0.clipFinished(f22_arg0.BMLock)
		end,
		LoseChildFocus = function(f23_arg0, f23_arg1)
			f23_arg0:__resetProperties()
			f23_arg0:setupElementClipCounter(1)
			f23_arg0.BMLock:completeAnimation()
			f23_arg0.BMLock:setScale(0.6, 0.6)
			f23_arg0.clipFinished(f23_arg0.BMLock)
		end,
	},
	PrestigeAttachmentLocked = {
		DefaultClip = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(4)
			f24_arg0.Icon:completeAnimation()
			f24_arg0.Icon:setRGB(0.29, 0.29, 0.29)
			f24_arg0.clipFinished(f24_arg0.Icon)
			f24_arg0.Name:completeAnimation()
			f24_arg0.Name:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.Name)
			f24_arg0.LockTickBacking:completeAnimation()
			f24_arg0.LockTickBacking:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.LockTickBacking)
			f24_arg0.LockedIcon:completeAnimation()
			f24_arg0.LockedIcon:setAlpha(1)
			f24_arg0.clipFinished(f24_arg0.LockedIcon)
		end,
		ChildFocus = function(f25_arg0, f25_arg1)
			f25_arg0:__resetProperties()
			f25_arg0:setupElementClipCounter(4)
			f25_arg0.Icon:completeAnimation()
			f25_arg0.Icon:setRGB(0.49, 0.49, 0.49)
			f25_arg0.clipFinished(f25_arg0.Icon)
			f25_arg0.Name:completeAnimation()
			f25_arg0.Name:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.Name)
			f25_arg0.LockTickBacking:completeAnimation()
			f25_arg0.LockTickBacking:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.LockTickBacking)
			f25_arg0.LockedIcon:completeAnimation()
			f25_arg0.LockedIcon:setAlpha(1)
			f25_arg0.clipFinished(f25_arg0.LockedIcon)
		end,
		GainChildFocus = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(4)
			local f26_local0 = function(f27_arg0)
				f26_arg0.Icon:beginAnimation(200)
				f26_arg0.Icon:setRGB(0.49, 0.49, 0.49)
				f26_arg0.Icon:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.Icon:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.Icon:completeAnimation()
			f26_arg0.Icon:setRGB(0.29, 0.29, 0.29)
			f26_local0(f26_arg0.Icon)
			f26_arg0.Name:completeAnimation()
			f26_arg0.Name:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.Name)
			f26_arg0.LockTickBacking:completeAnimation()
			f26_arg0.LockTickBacking:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.LockTickBacking)
			f26_arg0.LockedIcon:completeAnimation()
			f26_arg0.LockedIcon:setAlpha(1)
			f26_arg0.clipFinished(f26_arg0.LockedIcon)
		end,
		LoseChildFocus = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(4)
			local f28_local0 = function(f29_arg0)
				f28_arg0.Icon:beginAnimation(200)
				f28_arg0.Icon:setRGB(0.29, 0.29, 0.29)
				f28_arg0.Icon:registerEventHandler("interrupted_keyframe", f28_arg0.clipInterrupted)
				f28_arg0.Icon:registerEventHandler("transition_complete_keyframe", f28_arg0.clipFinished)
			end
			f28_arg0.Icon:completeAnimation()
			f28_arg0.Icon:setRGB(0.49, 0.49, 0.49)
			f28_local0(f28_arg0.Icon)
			f28_arg0.Name:completeAnimation()
			f28_arg0.Name:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.Name)
			f28_arg0.LockTickBacking:completeAnimation()
			f28_arg0.LockTickBacking:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.LockTickBacking)
			f28_arg0.LockedIcon:completeAnimation()
			f28_arg0.LockedIcon:setAlpha(1)
			f28_arg0.clipFinished(f28_arg0.LockedIcon)
		end,
	},
	PrestigeAttachment = {
		DefaultClip = function(f30_arg0, f30_arg1)
			f30_arg0:__resetProperties()
			f30_arg0:setupElementClipCounter(1)
			f30_arg0.Name:completeAnimation()
			f30_arg0.Name:setAlpha(1)
			f30_arg0.clipFinished(f30_arg0.Name)
		end,
		ChildFocus = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(1)
			f31_arg0.Name:completeAnimation()
			f31_arg0.Name:setAlpha(1)
			f31_arg0.clipFinished(f31_arg0.Name)
		end,
		GainChildFocus = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(1)
			f32_arg0.Name:completeAnimation()
			f32_arg0.Name:setAlpha(1)
			f32_arg0.clipFinished(f32_arg0.Name)
		end,
		LoseChildFocus = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(1)
			f33_arg0.Name:completeAnimation()
			f33_arg0.Name:setAlpha(1)
			f33_arg0.clipFinished(f33_arg0.Name)
		end,
	},
	Unavailable = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(2)
			f34_arg0.Icon:completeAnimation()
			f34_arg0.Icon:setAlpha(0)
			f34_arg0.clipFinished(f34_arg0.Icon)
			f34_arg0.BMGoldBar:completeAnimation()
			f34_arg0.BMGoldBar:setAlpha(1)
			f34_arg0.clipFinished(f34_arg0.BMGoldBar)
		end,
	},
	Locked = {
		DefaultClip = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(2)
			f35_arg0.Icon:completeAnimation()
			f35_arg0.Icon:setRGB(0.29, 0.29, 0.29)
			f35_arg0.clipFinished(f35_arg0.Icon)
			f35_arg0.BMLock:completeAnimation()
			f35_arg0.BMLock:setRGB(1, 1, 1)
			f35_arg0.BMLock:setAlpha(1)
			f35_arg0.clipFinished(f35_arg0.BMLock)
		end,
		ChildFocus = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(2)
			f36_arg0.Icon:completeAnimation()
			f36_arg0.Icon:setRGB(0.49, 0.49, 0.49)
			f36_arg0.clipFinished(f36_arg0.Icon)
			f36_arg0.BMLock:completeAnimation()
			f36_arg0.BMLock:setAlpha(1)
			f36_arg0.clipFinished(f36_arg0.BMLock)
		end,
		GainChildFocus = function(f37_arg0, f37_arg1)
			f37_arg0:__resetProperties()
			f37_arg0:setupElementClipCounter(2)
			local f37_local0 = function(f38_arg0)
				f37_arg0.Icon:beginAnimation(200)
				f37_arg0.Icon:setRGB(0.49, 0.49, 0.49)
				f37_arg0.Icon:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.Icon:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
			end
			f37_arg0.Icon:completeAnimation()
			f37_arg0.Icon:setRGB(0.29, 0.29, 0.29)
			f37_local0(f37_arg0.Icon)
			local f37_local1 = function(f39_arg0)
				f37_arg0.BMLock:beginAnimation(200)
				f37_arg0.BMLock:registerEventHandler("interrupted_keyframe", f37_arg0.clipInterrupted)
				f37_arg0.BMLock:registerEventHandler("transition_complete_keyframe", f37_arg0.clipFinished)
			end
			f37_arg0.BMLock:completeAnimation()
			f37_arg0.BMLock:setRGB(1, 1, 1)
			f37_arg0.BMLock:setAlpha(1)
			f37_local1(f37_arg0.BMLock)
		end,
		LoseChildFocus = function(f40_arg0, f40_arg1)
			f40_arg0:__resetProperties()
			f40_arg0:setupElementClipCounter(2)
			local f40_local0 = function(f41_arg0)
				f40_arg0.Icon:beginAnimation(200)
				f40_arg0.Icon:setRGB(0.29, 0.29, 0.29)
				f40_arg0.Icon:registerEventHandler("interrupted_keyframe", f40_arg0.clipInterrupted)
				f40_arg0.Icon:registerEventHandler("transition_complete_keyframe", f40_arg0.clipFinished)
			end
			f40_arg0.Icon:completeAnimation()
			f40_arg0.Icon:setRGB(0.49, 0.49, 0.49)
			f40_local0(f40_arg0.Icon)
			local f40_local1 = function(f42_arg0)
				f40_arg0.BMLock:beginAnimation(200)
				f40_arg0.BMLock:registerEventHandler("interrupted_keyframe", f40_arg0.clipInterrupted)
				f40_arg0.BMLock:registerEventHandler("transition_complete_keyframe", f40_arg0.clipFinished)
			end
			f40_arg0.BMLock:completeAnimation()
			f40_arg0.BMLock:setRGB(1, 1, 1)
			f40_arg0.BMLock:setAlpha(1)
			f40_local1(f40_arg0.BMLock)
		end,
	},
	TrialLocked = {
		DefaultClip = function(f43_arg0, f43_arg1)
			f43_arg0:__resetProperties()
			f43_arg0:setupElementClipCounter(2)
			f43_arg0.BMLock:completeAnimation()
			f43_arg0.BMLock:setScale(0.6, 0.6)
			f43_arg0.clipFinished(f43_arg0.BMLock)
			f43_arg0.TrialWidget:completeAnimation()
			f43_arg0.TrialWidget:setAlpha(1)
			f43_arg0.clipFinished(f43_arg0.TrialWidget)
		end,
		ChildFocus = function(f44_arg0, f44_arg1)
			f44_arg0:__resetProperties()
			f44_arg0:setupElementClipCounter(2)
			f44_arg0.BMLock:completeAnimation()
			f44_arg0.BMLock:setScale(0.6, 0.6)
			f44_arg0.clipFinished(f44_arg0.BMLock)
			f44_arg0.TrialWidget:completeAnimation()
			f44_arg0.TrialWidget:setAlpha(1)
			f44_arg0.clipFinished(f44_arg0.TrialWidget)
		end,
		GainChildFocus = function(f45_arg0, f45_arg1)
			f45_arg0:__resetProperties()
			f45_arg0:setupElementClipCounter(2)
			f45_arg0.BMLock:completeAnimation()
			f45_arg0.BMLock:setScale(0.6, 0.6)
			f45_arg0.clipFinished(f45_arg0.BMLock)
			f45_arg0.TrialWidget:completeAnimation()
			f45_arg0.TrialWidget:setAlpha(1)
			f45_arg0.clipFinished(f45_arg0.TrialWidget)
		end,
		LoseChildFocus = function(f46_arg0, f46_arg1)
			f46_arg0:__resetProperties()
			f46_arg0:setupElementClipCounter(2)
			f46_arg0.BMLock:completeAnimation()
			f46_arg0.BMLock:setScale(0.6, 0.6)
			f46_arg0.clipFinished(f46_arg0.BMLock)
			f46_arg0.TrialWidget:completeAnimation()
			f46_arg0.TrialWidget:setAlpha(1)
			f46_arg0.clipFinished(f46_arg0.TrialWidget)
		end,
	},
	New = {
		DefaultClip = function(f47_arg0, f47_arg1)
			f47_arg0:__resetProperties()
			f47_arg0:setupElementClipCounter(2)
			f47_arg0.BMLock:completeAnimation()
			f47_arg0.BMLock:setScale(0.6, 0.6)
			f47_arg0.clipFinished(f47_arg0.BMLock)
			f47_arg0.BreadcrumbNew:completeAnimation()
			f47_arg0.BreadcrumbNew:setAlpha(1)
			f47_arg0.clipFinished(f47_arg0.BreadcrumbNew)
		end,
		ChildFocus = function(f48_arg0, f48_arg1)
			f48_arg0:__resetProperties()
			f48_arg0:setupElementClipCounter(2)
			f48_arg0.BMLock:completeAnimation()
			f48_arg0.BMLock:setScale(0.6, 0.6)
			f48_arg0.clipFinished(f48_arg0.BMLock)
			local f48_local0 = function(f49_arg0)
				local f49_local0 = function(f50_arg0)
					f50_arg0:beginAnimation(200)
					f50_arg0:setAlpha(0)
					f50_arg0:registerEventHandler("transition_complete_keyframe", f48_arg0.clipFinished)
				end
				f48_arg0.BreadcrumbNew:beginAnimation(400)
				f48_arg0.BreadcrumbNew:registerEventHandler("interrupted_keyframe", f48_arg0.clipInterrupted)
				f48_arg0.BreadcrumbNew:registerEventHandler("transition_complete_keyframe", f49_local0)
			end
			f48_arg0.BreadcrumbNew:completeAnimation()
			f48_arg0.BreadcrumbNew:setAlpha(1)
			f48_local0(f48_arg0.BreadcrumbNew)
		end,
		GainChildFocus = function(f51_arg0, f51_arg1)
			f51_arg0:__resetProperties()
			f51_arg0:setupElementClipCounter(2)
			f51_arg0.BMLock:completeAnimation()
			f51_arg0.BMLock:setScale(0.6, 0.6)
			f51_arg0.clipFinished(f51_arg0.BMLock)
			f51_arg0.BreadcrumbNew:completeAnimation()
			f51_arg0.BreadcrumbNew:setAlpha(1)
			f51_arg0.clipFinished(f51_arg0.BreadcrumbNew)
		end,
		LoseChildFocus = function(f52_arg0, f52_arg1)
			f52_arg0:__resetProperties()
			f52_arg0:setupElementClipCounter(1)
			f52_arg0.BMLock:completeAnimation()
			f52_arg0.BMLock:setScale(0.6, 0.6)
			f52_arg0.clipFinished(f52_arg0.BMLock)
		end,
	},
}
CoD.LootWeaponOptionButtonInternal.__onClose = function(f53_arg0)
	f53_arg0.Icon:close()
	f53_arg0.Name:close()
	f53_arg0.BMLock:close()
	f53_arg0.BMGoldBar:close()
	f53_arg0.CommonButtonOutline:close()
	f53_arg0.BreadcrumbNew:close()
	f53_arg0.TrialWidget:close()
	f53_arg0.EquippedMarkerTick:close()
end
