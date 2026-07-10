require("x64:f6482b855bfca9f")
require("x64:bb65ae797e77e7b")
require("x64:1f846296f1a1b81")
CoD.DirectorPreGameButton = InheritFrom(LUI.UIElement)
CoD.DirectorPreGameButton.__defaultWidth = 230
CoD.DirectorPreGameButton.__defaultHeight = 70
CoD.DirectorPreGameButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorPreGameButton)
	self.id = "DirectorPreGameButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DirectorCustomStartButton = CoD.DirectorSelectButtonMiniInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	DirectorCustomStartButton:mergeStateConditions({
		{
			stateName = "TrialLocked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "trialLocked")
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.IsDirectorButtonOptionLocked(menu, self, f1_arg1)
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return IsSelfInState(self, "Unselectable")
			end,
		},
	})
	DirectorCustomStartButton:linkToElementModel(DirectorCustomStartButton, "trialLocked", true, function(model)
		f1_arg0:updateElementState(DirectorCustomStartButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "trialLocked",
		})
	end)
	DirectorCustomStartButton:linkToElementModel(DirectorCustomStartButton, "locked", true, function(model)
		f1_arg0:updateElementState(DirectorCustomStartButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "locked",
		})
	end)
	DirectorCustomStartButton:linkToElementModel(DirectorCustomStartButton, "featureItemIndex", true, function(model)
		f1_arg0:updateElementState(DirectorCustomStartButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "featureItemIndex",
		})
	end)
	local altNewIcon = DirectorCustomStartButton
	local newIcon = DirectorCustomStartButton.subscribeToModel
	local RestrictedIcon = Engine[0x8DF2E5447F384B9]()
	newIcon(altNewIcon, RestrictedIcon["lobbyRoot.lobbyNav"], function(f8_arg0)
		f1_arg0:updateElementState(DirectorCustomStartButton, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	DirectorCustomStartButton.Tint:setRGB(0.05, 0.08, 0.11)
	DirectorCustomStartButton.Tint:setAlpha(0.25)
	DirectorCustomStartButton.LeaderActivityText:setText("")
	DirectorCustomStartButton.MiddleText:setTTF("ttmussels_regular")
	DirectorCustomStartButton.MiddleTextFocus:setTTF("ttmussels_regular")
	DirectorCustomStartButton:linkToElementModel(self, nil, false, function(model)
		DirectorCustomStartButton:setModel(model, f1_arg1)
	end)
	DirectorCustomStartButton:linkToElementModel(self, "subtitle", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			DirectorCustomStartButton.MiddleText:setText(LocalizeToUpperString(f10_local0))
		end
	end)
	DirectorCustomStartButton:linkToElementModel(self, "subtitle", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			DirectorCustomStartButton.MiddleTextFocus:setText(LocalizeToUpperString(f11_local0))
		end
	end)
	self:addElement(DirectorCustomStartButton)
	self.DirectorCustomStartButton = DirectorCustomStartButton
	newIcon = CoD.NewBreadcrumb.new(f1_arg0, f1_arg1, 1, 1, -21, -3, 0, 0, 3, 21)
	newIcon:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return IsLive() and CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "hasBreadcrumb")
			end,
		},
	})
	RestrictedIcon = newIcon
	altNewIcon = newIcon.subscribeToModel
	local f1_local5 = Engine[0x8DF2E5447F384B9]()
	altNewIcon(RestrictedIcon, f1_local5["lobbyRoot.lobbyNetworkMode"], function(f13_arg0)
		f1_arg0:updateElementState(newIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f13_arg0:get(),
			modelName = "lobbyRoot.lobbyNetworkMode",
		})
	end, false)
	RestrictedIcon = newIcon
	altNewIcon = newIcon.subscribeToModel
	f1_local5 = Engine[0x8DF2E5447F384B9]()
	altNewIcon(RestrictedIcon, f1_local5["lobbyRoot.lobbyNav"], function(f14_arg0)
		f1_arg0:updateElementState(newIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	newIcon:linkToElementModel(newIcon, "hasBreadcrumb", true, function(model)
		f1_arg0:updateElementState(newIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "hasBreadcrumb",
		})
	end)
	newIcon:linkToElementModel(self, nil, false, function(model)
		newIcon:setModel(model, f1_arg1)
	end)
	self:addElement(newIcon)
	self.newIcon = newIcon
	altNewIcon = CoD.NewBreadcrumb.new(f1_arg0, f1_arg1, 1, 1, -21, -3, 0, 0, 3, 21)
	altNewIcon:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return IsLive() and CoD.ModelUtility.IsSelfModelPathValueGreaterThan(element, f1_arg1, "breadcrumbModel->breadcrumbCount", 0)
			end,
		},
	})
	f1_local5 = altNewIcon
	RestrictedIcon = altNewIcon.subscribeToModel
	local f1_local6 = Engine[0x8DF2E5447F384B9]()
	RestrictedIcon(f1_local5, f1_local6["lobbyRoot.lobbyNetworkMode"], function(f18_arg0)
		f1_arg0:updateElementState(altNewIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "lobbyRoot.lobbyNetworkMode",
		})
	end, false)
	f1_local5 = altNewIcon
	RestrictedIcon = altNewIcon.subscribeToModel
	f1_local6 = Engine[0x8DF2E5447F384B9]()
	RestrictedIcon(f1_local5, f1_local6["lobbyRoot.lobbyNav"], function(f19_arg0)
		f1_arg0:updateElementState(altNewIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f19_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	altNewIcon:linkToElementModel(altNewIcon, "breadcrumbModel", true, function(model)
		if altNewIcon["__stateValidation_breadcrumbModel->breadcrumbCount"] then
			altNewIcon:removeSubscription(altNewIcon["__stateValidation_breadcrumbModel->breadcrumbCount"])
			altNewIcon["__stateValidation_breadcrumbModel->breadcrumbCount"] = nil
		end
		if model then
			local f20_local0 = model:get()
			local f20_local1 = model:get()
			model = f20_local0 and f20_local1.breadcrumbCount
		end
		if model then
			altNewIcon["__stateValidation_breadcrumbModel->breadcrumbCount"] = altNewIcon:subscribeToModel(model, function(model)
				f1_arg0:updateElementState(altNewIcon, {
					name = "model_validation",
					menu = f1_arg0,
					controller = f1_arg1,
					modelValue = model:get(),
					modelName = "breadcrumbModel->breadcrumbCount",
				})
			end)
		end
	end)
	altNewIcon:linkToElementModel(self, nil, false, function(model)
		altNewIcon:setModel(model, f1_arg1)
	end)
	self:addElement(altNewIcon)
	self.altNewIcon = altNewIcon
	RestrictedIcon = CoD.RestrictedItemWarningBar.new(f1_arg0, f1_arg1, 0.5, 0.5, -110, 110, 1, 1, -16, 6)
	RestrictedIcon:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f23_local0
				if not CoD.DirectorUtility.ShowDirectorPregame(f1_arg1) and not IsPublicWZLobby() then
					f23_local0 = CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isRestricted")
					if f23_local0 then
						f23_local0 = not IsZombies()
					end
				else
					f23_local0 = false
				end
				return f23_local0
			end,
		},
	})
	f1_local6 = RestrictedIcon
	f1_local5 = RestrictedIcon.subscribeToModel
	local f1_local7 = Engine[0x8DF2E5447F384B9]()
	f1_local5(f1_local6, f1_local7["lobbyRoot.lobbyNav"], function(f24_arg0)
		f1_arg0:updateElementState(RestrictedIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f24_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	RestrictedIcon:linkToElementModel(RestrictedIcon, "isRestricted", true, function(model)
		f1_arg0:updateElementState(RestrictedIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isRestricted",
		})
	end)
	RestrictedIcon:linkToElementModel(self, nil, false, function(model)
		RestrictedIcon:setModel(model, f1_arg1)
	end)
	self:addElement(RestrictedIcon)
	self.RestrictedIcon = RestrictedIcon
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Unselectable",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	DirectorCustomStartButton.id = "DirectorCustomStartButton"
	self.__defaultFocus = DirectorCustomStartButton
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorPreGameButton.__resetProperties = function(f31_arg0)
	f31_arg0.DirectorCustomStartButton:completeAnimation()
	f31_arg0.RestrictedIcon:completeAnimation()
	f31_arg0.newIcon:completeAnimation()
	f31_arg0.altNewIcon:completeAnimation()
	f31_arg0.DirectorCustomStartButton:setAlpha(1)
	f31_arg0.DirectorCustomStartButton:setZoom(0)
	f31_arg0.DirectorCustomStartButton:setScale(1, 1)
	f31_arg0.RestrictedIcon:setTopBottom(1, 1, -16, 6)
	f31_arg0.RestrictedIcon:setAlpha(1)
	f31_arg0.RestrictedIcon:setScale(1, 1)
	f31_arg0.newIcon:setLeftRight(1, 1, -21, -3)
	f31_arg0.newIcon:setTopBottom(0, 0, 3, 21)
	f31_arg0.newIcon:setAlpha(1)
	f31_arg0.newIcon:setScale(1, 1)
	f31_arg0.altNewIcon:setLeftRight(1, 1, -21, -3)
	f31_arg0.altNewIcon:setTopBottom(0, 0, 3, 21)
	f31_arg0.altNewIcon:setScale(1, 1)
end
CoD.DirectorPreGameButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f32_arg0, f32_arg1)
			f32_arg0:__resetProperties()
			f32_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(4)
			f33_arg0.DirectorCustomStartButton:completeAnimation()
			f33_arg0.DirectorCustomStartButton:setZoom(5)
			f33_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f33_arg0.clipFinished(f33_arg0.DirectorCustomStartButton)
			f33_arg0.newIcon:completeAnimation()
			f33_arg0.newIcon:setLeftRight(1, 1, -16, 2)
			f33_arg0.newIcon:setTopBottom(0, 0, 1, 19)
			f33_arg0.newIcon:setScale(1.05, 1.05)
			f33_arg0.clipFinished(f33_arg0.newIcon)
			f33_arg0.altNewIcon:completeAnimation()
			f33_arg0.altNewIcon:setLeftRight(1, 1, -16, 2)
			f33_arg0.altNewIcon:setTopBottom(0, 0, 1, 19)
			f33_arg0.altNewIcon:setScale(1.05, 1.05)
			f33_arg0.clipFinished(f33_arg0.altNewIcon)
			f33_arg0.RestrictedIcon:completeAnimation()
			f33_arg0.RestrictedIcon:setTopBottom(1, 1, -14, 8)
			f33_arg0.RestrictedIcon:setScale(1.05, 1.05)
			f33_arg0.clipFinished(f33_arg0.RestrictedIcon)
		end,
		GainChildFocus = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(4)
			local f34_local0 = function(f35_arg0)
				f34_arg0.DirectorCustomStartButton:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f34_arg0.DirectorCustomStartButton:setZoom(5)
				f34_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
				f34_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f34_arg0.clipInterrupted)
				f34_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f34_arg0.clipFinished)
			end
			f34_arg0.DirectorCustomStartButton:completeAnimation()
			f34_arg0.DirectorCustomStartButton:setZoom(0)
			f34_arg0.DirectorCustomStartButton:setScale(1, 1)
			f34_local0(f34_arg0.DirectorCustomStartButton)
			local f34_local1 = function(f36_arg0)
				f34_arg0.newIcon:beginAnimation(200)
				f34_arg0.newIcon:setLeftRight(1, 1, -16, 2)
				f34_arg0.newIcon:setTopBottom(0, 0, 1, 19)
				f34_arg0.newIcon:setScale(1.05, 1.05)
				f34_arg0.newIcon:registerEventHandler("interrupted_keyframe", f34_arg0.clipInterrupted)
				f34_arg0.newIcon:registerEventHandler("transition_complete_keyframe", f34_arg0.clipFinished)
			end
			f34_arg0.newIcon:completeAnimation()
			f34_arg0.newIcon:setLeftRight(1, 1, -21, -3)
			f34_arg0.newIcon:setTopBottom(0, 0, 3, 21)
			f34_arg0.newIcon:setScale(1, 1)
			f34_local1(f34_arg0.newIcon)
			local f34_local2 = function(f37_arg0)
				f34_arg0.altNewIcon:beginAnimation(200)
				f34_arg0.altNewIcon:setLeftRight(1, 1, -16, 2)
				f34_arg0.altNewIcon:setTopBottom(0, 0, 1, 19)
				f34_arg0.altNewIcon:setScale(1.05, 1.05)
				f34_arg0.altNewIcon:registerEventHandler("interrupted_keyframe", f34_arg0.clipInterrupted)
				f34_arg0.altNewIcon:registerEventHandler("transition_complete_keyframe", f34_arg0.clipFinished)
			end
			f34_arg0.altNewIcon:completeAnimation()
			f34_arg0.altNewIcon:setLeftRight(1, 1, -21, -3)
			f34_arg0.altNewIcon:setTopBottom(0, 0, 3, 21)
			f34_arg0.altNewIcon:setScale(1, 1)
			f34_local2(f34_arg0.altNewIcon)
			local f34_local3 = function(f38_arg0)
				f34_arg0.RestrictedIcon:beginAnimation(200)
				f34_arg0.RestrictedIcon:setTopBottom(1, 1, -14, 8)
				f34_arg0.RestrictedIcon:setScale(1.05, 1.05)
				f34_arg0.RestrictedIcon:registerEventHandler("interrupted_keyframe", f34_arg0.clipInterrupted)
				f34_arg0.RestrictedIcon:registerEventHandler("transition_complete_keyframe", f34_arg0.clipFinished)
			end
			f34_arg0.RestrictedIcon:completeAnimation()
			f34_arg0.RestrictedIcon:setTopBottom(1, 1, -16, 6)
			f34_arg0.RestrictedIcon:setScale(1, 1)
			f34_local3(f34_arg0.RestrictedIcon)
		end,
		LoseChildFocus = function(f39_arg0, f39_arg1)
			f39_arg0:__resetProperties()
			f39_arg0:setupElementClipCounter(4)
			local f39_local0 = function(f40_arg0)
				f39_arg0.DirectorCustomStartButton:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f39_arg0.DirectorCustomStartButton:setZoom(0)
				f39_arg0.DirectorCustomStartButton:setScale(1, 1)
				f39_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
			end
			f39_arg0.DirectorCustomStartButton:completeAnimation()
			f39_arg0.DirectorCustomStartButton:setZoom(5)
			f39_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f39_local0(f39_arg0.DirectorCustomStartButton)
			local f39_local1 = function(f41_arg0)
				f39_arg0.newIcon:beginAnimation(200)
				f39_arg0.newIcon:setLeftRight(1, 1, -21, -3)
				f39_arg0.newIcon:setTopBottom(0, 0, 3, 21)
				f39_arg0.newIcon:setScale(1, 1)
				f39_arg0.newIcon:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.newIcon:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
			end
			f39_arg0.newIcon:completeAnimation()
			f39_arg0.newIcon:setLeftRight(1, 1, -16, 2)
			f39_arg0.newIcon:setTopBottom(0, 0, 1, 19)
			f39_arg0.newIcon:setScale(1.05, 1.05)
			f39_local1(f39_arg0.newIcon)
			local f39_local2 = function(f42_arg0)
				f39_arg0.altNewIcon:beginAnimation(200)
				f39_arg0.altNewIcon:setLeftRight(1, 1, -21, -3)
				f39_arg0.altNewIcon:setTopBottom(0, 0, 3, 21)
				f39_arg0.altNewIcon:setScale(1, 1)
				f39_arg0.altNewIcon:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.altNewIcon:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
			end
			f39_arg0.altNewIcon:completeAnimation()
			f39_arg0.altNewIcon:setLeftRight(1, 1, -16, 2)
			f39_arg0.altNewIcon:setTopBottom(0, 0, 1, 19)
			f39_arg0.altNewIcon:setScale(1.05, 1.05)
			f39_local2(f39_arg0.altNewIcon)
			local f39_local3 = function(f43_arg0)
				f39_arg0.RestrictedIcon:beginAnimation(200)
				f39_arg0.RestrictedIcon:setTopBottom(1, 1, -16, 6)
				f39_arg0.RestrictedIcon:setScale(1, 1)
				f39_arg0.RestrictedIcon:registerEventHandler("interrupted_keyframe", f39_arg0.clipInterrupted)
				f39_arg0.RestrictedIcon:registerEventHandler("transition_complete_keyframe", f39_arg0.clipFinished)
			end
			f39_arg0.RestrictedIcon:completeAnimation()
			f39_arg0.RestrictedIcon:setTopBottom(1, 1, -14, 8)
			f39_arg0.RestrictedIcon:setScale(1.05, 1.05)
			f39_local3(f39_arg0.RestrictedIcon)
		end,
	},
	Hidden = {
		DefaultClip = function(f44_arg0, f44_arg1)
			f44_arg0:__resetProperties()
			f44_arg0:setupElementClipCounter(3)
			f44_arg0.DirectorCustomStartButton:completeAnimation()
			f44_arg0.DirectorCustomStartButton:setAlpha(0)
			f44_arg0.clipFinished(f44_arg0.DirectorCustomStartButton)
			f44_arg0.newIcon:completeAnimation()
			f44_arg0.newIcon:setAlpha(0)
			f44_arg0.clipFinished(f44_arg0.newIcon)
			f44_arg0.RestrictedIcon:completeAnimation()
			f44_arg0.RestrictedIcon:setAlpha(0)
			f44_arg0.clipFinished(f44_arg0.RestrictedIcon)
		end,
	},
	Locked = {
		DefaultClip = function(f45_arg0, f45_arg1)
			f45_arg0:__resetProperties()
			f45_arg0:setupElementClipCounter(1)
			f45_arg0.RestrictedIcon:completeAnimation()
			f45_arg0.RestrictedIcon:setAlpha(0)
			f45_arg0.clipFinished(f45_arg0.RestrictedIcon)
		end,
		ChildFocus = function(f46_arg0, f46_arg1)
			f46_arg0:__resetProperties()
			f46_arg0:setupElementClipCounter(1)
			f46_arg0.DirectorCustomStartButton:completeAnimation()
			f46_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f46_arg0.clipFinished(f46_arg0.DirectorCustomStartButton)
		end,
		GainChildFocus = function(f47_arg0, f47_arg1)
			f47_arg0:__resetProperties()
			f47_arg0:setupElementClipCounter(1)
			local f47_local0 = function(f48_arg0)
				f47_arg0.DirectorCustomStartButton:beginAnimation(200)
				f47_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
				f47_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f47_arg0.clipInterrupted)
				f47_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f47_arg0.clipFinished)
			end
			f47_arg0.DirectorCustomStartButton:completeAnimation()
			f47_arg0.DirectorCustomStartButton:setScale(1, 1)
			f47_local0(f47_arg0.DirectorCustomStartButton)
		end,
		LoseChildFocus = function(f49_arg0, f49_arg1)
			f49_arg0:__resetProperties()
			f49_arg0:setupElementClipCounter(1)
			local f49_local0 = function(f50_arg0)
				f49_arg0.DirectorCustomStartButton:beginAnimation(200)
				f49_arg0.DirectorCustomStartButton:setScale(1, 1)
				f49_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f49_arg0.clipInterrupted)
				f49_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f49_arg0.clipFinished)
			end
			f49_arg0.DirectorCustomStartButton:completeAnimation()
			f49_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f49_local0(f49_arg0.DirectorCustomStartButton)
		end,
	},
	Unselectable = {
		DefaultClip = function(f51_arg0, f51_arg1)
			f51_arg0:__resetProperties()
			f51_arg0:setupElementClipCounter(0)
		end,
	},
	Visible = {
		DefaultClip = function(f52_arg0, f52_arg1)
			f52_arg0:__resetProperties()
			f52_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f53_arg0, f53_arg1)
			f53_arg0:__resetProperties()
			f53_arg0:setupElementClipCounter(4)
			f53_arg0.DirectorCustomStartButton:completeAnimation()
			f53_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f53_arg0.clipFinished(f53_arg0.DirectorCustomStartButton)
			f53_arg0.newIcon:completeAnimation()
			f53_arg0.newIcon:setLeftRight(1, 1, -16, 2)
			f53_arg0.newIcon:setTopBottom(0, 0, 1, 19)
			f53_arg0.clipFinished(f53_arg0.newIcon)
			f53_arg0.altNewIcon:completeAnimation()
			f53_arg0.altNewIcon:setLeftRight(1, 1, -16, 2)
			f53_arg0.altNewIcon:setTopBottom(0, 0, 1, 19)
			f53_arg0.clipFinished(f53_arg0.altNewIcon)
			f53_arg0.RestrictedIcon:completeAnimation()
			f53_arg0.RestrictedIcon:setTopBottom(1, 1, -14, 8)
			f53_arg0.RestrictedIcon:setScale(1.05, 1.05)
			f53_arg0.clipFinished(f53_arg0.RestrictedIcon)
		end,
		GainChildFocus = function(f54_arg0, f54_arg1)
			f54_arg0:__resetProperties()
			f54_arg0:setupElementClipCounter(4)
			local f54_local0 = function(f55_arg0)
				f54_arg0.DirectorCustomStartButton:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f54_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
				f54_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f54_arg0.clipInterrupted)
				f54_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f54_arg0.clipFinished)
			end
			f54_arg0.DirectorCustomStartButton:completeAnimation()
			f54_arg0.DirectorCustomStartButton:setScale(1, 1)
			f54_local0(f54_arg0.DirectorCustomStartButton)
			local f54_local1 = function(f56_arg0)
				f54_arg0.newIcon:beginAnimation(200)
				f54_arg0.newIcon:setLeftRight(1, 1, -16, 2)
				f54_arg0.newIcon:setTopBottom(0, 0, 1, 19)
				f54_arg0.newIcon:setScale(1.05, 1.05)
				f54_arg0.newIcon:registerEventHandler("interrupted_keyframe", f54_arg0.clipInterrupted)
				f54_arg0.newIcon:registerEventHandler("transition_complete_keyframe", f54_arg0.clipFinished)
			end
			f54_arg0.newIcon:completeAnimation()
			f54_arg0.newIcon:setLeftRight(1, 1, -21, -3)
			f54_arg0.newIcon:setTopBottom(0, 0, 3, 21)
			f54_arg0.newIcon:setScale(1, 1)
			f54_local1(f54_arg0.newIcon)
			local f54_local2 = function(f57_arg0)
				f54_arg0.altNewIcon:beginAnimation(200)
				f54_arg0.altNewIcon:setLeftRight(1, 1, -16, 2)
				f54_arg0.altNewIcon:setTopBottom(0, 0, 1, 19)
				f54_arg0.altNewIcon:setScale(1.05, 1.05)
				f54_arg0.altNewIcon:registerEventHandler("interrupted_keyframe", f54_arg0.clipInterrupted)
				f54_arg0.altNewIcon:registerEventHandler("transition_complete_keyframe", f54_arg0.clipFinished)
			end
			f54_arg0.altNewIcon:completeAnimation()
			f54_arg0.altNewIcon:setLeftRight(1, 1, -21, -3)
			f54_arg0.altNewIcon:setTopBottom(0, 0, 3, 21)
			f54_arg0.altNewIcon:setScale(1, 1)
			f54_local2(f54_arg0.altNewIcon)
			local f54_local3 = function(f58_arg0)
				f54_arg0.RestrictedIcon:beginAnimation(200)
				f54_arg0.RestrictedIcon:setTopBottom(1, 1, -14, 8)
				f54_arg0.RestrictedIcon:setScale(1.05, 1.05)
				f54_arg0.RestrictedIcon:registerEventHandler("interrupted_keyframe", f54_arg0.clipInterrupted)
				f54_arg0.RestrictedIcon:registerEventHandler("transition_complete_keyframe", f54_arg0.clipFinished)
			end
			f54_arg0.RestrictedIcon:completeAnimation()
			f54_arg0.RestrictedIcon:setTopBottom(1, 1, -16, 6)
			f54_arg0.RestrictedIcon:setScale(1, 1)
			f54_local3(f54_arg0.RestrictedIcon)
		end,
		LoseChildFocus = function(f59_arg0, f59_arg1)
			f59_arg0:__resetProperties()
			f59_arg0:setupElementClipCounter(4)
			local f59_local0 = function(f60_arg0)
				f59_arg0.DirectorCustomStartButton:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f59_arg0.DirectorCustomStartButton:setScale(1, 1)
				f59_arg0.DirectorCustomStartButton:registerEventHandler("interrupted_keyframe", f59_arg0.clipInterrupted)
				f59_arg0.DirectorCustomStartButton:registerEventHandler("transition_complete_keyframe", f59_arg0.clipFinished)
			end
			f59_arg0.DirectorCustomStartButton:completeAnimation()
			f59_arg0.DirectorCustomStartButton:setScale(1.05, 1.05)
			f59_local0(f59_arg0.DirectorCustomStartButton)
			local f59_local1 = function(f61_arg0)
				f59_arg0.newIcon:beginAnimation(200)
				f59_arg0.newIcon:setLeftRight(1, 1, -21, -3)
				f59_arg0.newIcon:setTopBottom(0, 0, 3, 21)
				f59_arg0.newIcon:setScale(1, 1)
				f59_arg0.newIcon:registerEventHandler("interrupted_keyframe", f59_arg0.clipInterrupted)
				f59_arg0.newIcon:registerEventHandler("transition_complete_keyframe", f59_arg0.clipFinished)
			end
			f59_arg0.newIcon:completeAnimation()
			f59_arg0.newIcon:setLeftRight(1, 1, -16, 2)
			f59_arg0.newIcon:setTopBottom(0, 0, 1, 19)
			f59_arg0.newIcon:setScale(1.05, 1.05)
			f59_local1(f59_arg0.newIcon)
			local f59_local2 = function(f62_arg0)
				f59_arg0.altNewIcon:beginAnimation(200)
				f59_arg0.altNewIcon:setLeftRight(1, 1, -21, -3)
				f59_arg0.altNewIcon:setTopBottom(0, 0, 3, 21)
				f59_arg0.altNewIcon:setScale(1, 1)
				f59_arg0.altNewIcon:registerEventHandler("interrupted_keyframe", f59_arg0.clipInterrupted)
				f59_arg0.altNewIcon:registerEventHandler("transition_complete_keyframe", f59_arg0.clipFinished)
			end
			f59_arg0.altNewIcon:completeAnimation()
			f59_arg0.altNewIcon:setLeftRight(1, 1, -16, 2)
			f59_arg0.altNewIcon:setTopBottom(0, 0, 1, 19)
			f59_arg0.altNewIcon:setScale(1.05, 1.05)
			f59_local2(f59_arg0.altNewIcon)
			local f59_local3 = function(f63_arg0)
				f59_arg0.RestrictedIcon:beginAnimation(200)
				f59_arg0.RestrictedIcon:setTopBottom(1, 1, -16, 6)
				f59_arg0.RestrictedIcon:setScale(1, 1)
				f59_arg0.RestrictedIcon:registerEventHandler("interrupted_keyframe", f59_arg0.clipInterrupted)
				f59_arg0.RestrictedIcon:registerEventHandler("transition_complete_keyframe", f59_arg0.clipFinished)
			end
			f59_arg0.RestrictedIcon:completeAnimation()
			f59_arg0.RestrictedIcon:setTopBottom(1, 1, -14, 8)
			f59_arg0.RestrictedIcon:setScale(1.05, 1.05)
			f59_local3(f59_arg0.RestrictedIcon)
		end,
	},
}
CoD.DirectorPreGameButton.__onClose = function(f64_arg0)
	f64_arg0.DirectorCustomStartButton:close()
	f64_arg0.newIcon:close()
	f64_arg0.altNewIcon:close()
	f64_arg0.RestrictedIcon:close()
end
