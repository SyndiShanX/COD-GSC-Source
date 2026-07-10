require("x64:15c023510ca7d16")
require("x64:f6482b855bfca9f")
CoD.ArenaEventButton = InheritFrom(LUI.UIElement)
CoD.ArenaEventButton.__defaultWidth = 200
CoD.ArenaEventButton.__defaultHeight = 70
CoD.ArenaEventButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ArenaEventButton)
	self.id = "ArenaEventButton"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ArenaButtonInternal = CoD.ArenaEventButtonInternal.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	ArenaButtonInternal:mergeStateConditions({
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
	ArenaButtonInternal:linkToElementModel(ArenaButtonInternal, "locked", true, function(model)
		f1_arg0:updateElementState(ArenaButtonInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "locked",
		})
	end)
	ArenaButtonInternal:linkToElementModel(ArenaButtonInternal, "featureItemIndex", true, function(model)
		f1_arg0:updateElementState(ArenaButtonInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "featureItemIndex",
		})
	end)
	local f1_local2 = ArenaButtonInternal
	local newIcon = ArenaButtonInternal.subscribeToModel
	local f1_local4 = Engine[@"getglobalmodel"]()
	newIcon(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f6_arg0)
		f1_arg0:updateElementState(ArenaButtonInternal, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	ArenaButtonInternal.Tint:setRGB(0.05, 0.08, 0.11)
	ArenaButtonInternal.Tint:setAlpha(0.25)
	ArenaButtonInternal.MiddleTextFocus:setTTF("ttmussels_regular")
	ArenaButtonInternal.LeaderActivityText:setText("")
	ArenaButtonInternal.MiddleText:setTTF("ttmussels_regular")
	ArenaButtonInternal:linkToElementModel(self, nil, false, function(model)
		ArenaButtonInternal:setModel(model, f1_arg1)
	end)
	ArenaButtonInternal:linkToElementModel(self, "subtitle", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			ArenaButtonInternal.MiddleTextFocus:setText(LocalizeToUpperString(f8_local0))
		end
	end)
	ArenaButtonInternal:linkToElementModel(self, "subtitle", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			ArenaButtonInternal.MiddleText:setText(LocalizeToUpperString(f9_local0))
		end
	end)
	self:addElement(ArenaButtonInternal)
	self.ArenaButtonInternal = ArenaButtonInternal
	newIcon = CoD.NewBreadcrumb.new(f1_arg0, f1_arg1, 0, 0, 179, 197, 0.5, 0.5, -32, -14)
	newIcon:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return IsLive() and CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "hasBreadcrumb")
			end,
		},
	})
	f1_local4 = newIcon
	f1_local2 = newIcon.subscribeToModel
	local f1_local5 = Engine[@"getglobalmodel"]()
	f1_local2(f1_local4, f1_local5["lobbyRoot.lobbyNetworkMode"], function(f11_arg0)
		f1_arg0:updateElementState(newIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f11_arg0:get(),
			modelName = "lobbyRoot.lobbyNetworkMode",
		})
	end, false)
	f1_local4 = newIcon
	f1_local2 = newIcon.subscribeToModel
	f1_local5 = Engine[@"getglobalmodel"]()
	f1_local2(f1_local4, f1_local5["lobbyRoot.lobbyNav"], function(f12_arg0)
		f1_arg0:updateElementState(newIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
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
	ArenaButtonInternal.id = "ArenaButtonInternal"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaEventButton.__resetProperties = function(f19_arg0)
	f19_arg0.ArenaButtonInternal:completeAnimation()
	f19_arg0.newIcon:completeAnimation()
	f19_arg0.ArenaButtonInternal:setAlpha(1)
	f19_arg0.ArenaButtonInternal:setZoom(0)
	f19_arg0.ArenaButtonInternal:setScale(1, 1)
	f19_arg0.newIcon:setAlpha(1)
end
CoD.ArenaEventButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(1)
			f21_arg0.ArenaButtonInternal:completeAnimation()
			f21_arg0.ArenaButtonInternal:setZoom(5)
			f21_arg0.ArenaButtonInternal:setScale(1.05, 1.05)
			f21_arg0.clipFinished(f21_arg0.ArenaButtonInternal)
		end,
		GainChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(1)
			local f22_local0 = function(f23_arg0)
				f22_arg0.ArenaButtonInternal:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f22_arg0.ArenaButtonInternal:setZoom(5)
				f22_arg0.ArenaButtonInternal:setScale(1.05, 1.05)
				f22_arg0.ArenaButtonInternal:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.ArenaButtonInternal:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.ArenaButtonInternal:completeAnimation()
			f22_arg0.ArenaButtonInternal:setZoom(0)
			f22_arg0.ArenaButtonInternal:setScale(1, 1)
			f22_local0(f22_arg0.ArenaButtonInternal)
		end,
		LoseChildFocus = function(f24_arg0, f24_arg1)
			f24_arg0:__resetProperties()
			f24_arg0:setupElementClipCounter(1)
			local f24_local0 = function(f25_arg0)
				f24_arg0.ArenaButtonInternal:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f24_arg0.ArenaButtonInternal:setZoom(0)
				f24_arg0.ArenaButtonInternal:setScale(1, 1)
				f24_arg0.ArenaButtonInternal:registerEventHandler("interrupted_keyframe", f24_arg0.clipInterrupted)
				f24_arg0.ArenaButtonInternal:registerEventHandler("transition_complete_keyframe", f24_arg0.clipFinished)
			end
			f24_arg0.ArenaButtonInternal:completeAnimation()
			f24_arg0.ArenaButtonInternal:setZoom(5)
			f24_arg0.ArenaButtonInternal:setScale(1.05, 1.05)
			f24_local0(f24_arg0.ArenaButtonInternal)
		end,
	},
	Hidden = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(2)
			f26_arg0.ArenaButtonInternal:completeAnimation()
			f26_arg0.ArenaButtonInternal:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.ArenaButtonInternal)
			f26_arg0.newIcon:completeAnimation()
			f26_arg0.newIcon:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.newIcon)
		end,
	},
	Locked = {
		DefaultClip = function(f27_arg0, f27_arg1)
			f27_arg0:__resetProperties()
			f27_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f28_arg0, f28_arg1)
			f28_arg0:__resetProperties()
			f28_arg0:setupElementClipCounter(1)
			f28_arg0.ArenaButtonInternal:completeAnimation()
			f28_arg0.ArenaButtonInternal:setScale(1.05, 1.05)
			f28_arg0.clipFinished(f28_arg0.ArenaButtonInternal)
		end,
		GainChildFocus = function(f29_arg0, f29_arg1)
			f29_arg0:__resetProperties()
			f29_arg0:setupElementClipCounter(1)
			local f29_local0 = function(f30_arg0)
				f29_arg0.ArenaButtonInternal:beginAnimation(200)
				f29_arg0.ArenaButtonInternal:setScale(1.05, 1.05)
				f29_arg0.ArenaButtonInternal:registerEventHandler("interrupted_keyframe", f29_arg0.clipInterrupted)
				f29_arg0.ArenaButtonInternal:registerEventHandler("transition_complete_keyframe", f29_arg0.clipFinished)
			end
			f29_arg0.ArenaButtonInternal:completeAnimation()
			f29_arg0.ArenaButtonInternal:setScale(1, 1)
			f29_local0(f29_arg0.ArenaButtonInternal)
		end,
		LoseChildFocus = function(f31_arg0, f31_arg1)
			f31_arg0:__resetProperties()
			f31_arg0:setupElementClipCounter(1)
			local f31_local0 = function(f32_arg0)
				f31_arg0.ArenaButtonInternal:beginAnimation(200)
				f31_arg0.ArenaButtonInternal:setScale(1, 1)
				f31_arg0.ArenaButtonInternal:registerEventHandler("interrupted_keyframe", f31_arg0.clipInterrupted)
				f31_arg0.ArenaButtonInternal:registerEventHandler("transition_complete_keyframe", f31_arg0.clipFinished)
			end
			f31_arg0.ArenaButtonInternal:completeAnimation()
			f31_arg0.ArenaButtonInternal:setScale(1.05, 1.05)
			f31_local0(f31_arg0.ArenaButtonInternal)
		end,
	},
	Unselectable = {
		DefaultClip = function(f33_arg0, f33_arg1)
			f33_arg0:__resetProperties()
			f33_arg0:setupElementClipCounter(0)
		end,
	},
	Visible = {
		DefaultClip = function(f34_arg0, f34_arg1)
			f34_arg0:__resetProperties()
			f34_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f35_arg0, f35_arg1)
			f35_arg0:__resetProperties()
			f35_arg0:setupElementClipCounter(1)
			f35_arg0.ArenaButtonInternal:completeAnimation()
			f35_arg0.ArenaButtonInternal:setScale(1.05, 1.05)
			f35_arg0.clipFinished(f35_arg0.ArenaButtonInternal)
		end,
		GainChildFocus = function(f36_arg0, f36_arg1)
			f36_arg0:__resetProperties()
			f36_arg0:setupElementClipCounter(1)
			local f36_local0 = function(f37_arg0)
				f36_arg0.ArenaButtonInternal:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f36_arg0.ArenaButtonInternal:setScale(1.05, 1.05)
				f36_arg0.ArenaButtonInternal:registerEventHandler("interrupted_keyframe", f36_arg0.clipInterrupted)
				f36_arg0.ArenaButtonInternal:registerEventHandler("transition_complete_keyframe", f36_arg0.clipFinished)
			end
			f36_arg0.ArenaButtonInternal:completeAnimation()
			f36_arg0.ArenaButtonInternal:setScale(1, 1)
			f36_local0(f36_arg0.ArenaButtonInternal)
		end,
		LoseChildFocus = function(f38_arg0, f38_arg1)
			f38_arg0:__resetProperties()
			f38_arg0:setupElementClipCounter(1)
			local f38_local0 = function(f39_arg0)
				f38_arg0.ArenaButtonInternal:beginAnimation(200, Enum[@"luitween"][@"luitween_ease_both"])
				f38_arg0.ArenaButtonInternal:setScale(1, 1)
				f38_arg0.ArenaButtonInternal:registerEventHandler("interrupted_keyframe", f38_arg0.clipInterrupted)
				f38_arg0.ArenaButtonInternal:registerEventHandler("transition_complete_keyframe", f38_arg0.clipFinished)
			end
			f38_arg0.ArenaButtonInternal:completeAnimation()
			f38_arg0.ArenaButtonInternal:setScale(1.05, 1.05)
			f38_local0(f38_arg0.ArenaButtonInternal)
		end,
	},
}
CoD.ArenaEventButton.__onClose = function(f40_arg0)
	f40_arg0.ArenaButtonInternal:close()
	f40_arg0.newIcon:close()
end
