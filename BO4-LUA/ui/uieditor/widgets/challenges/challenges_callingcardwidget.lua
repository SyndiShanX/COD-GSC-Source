require("x64:f15c63f70691173")
CoD.Challenges_CallingCardWidget = InheritFrom(LUI.UIElement)
CoD.Challenges_CallingCardWidget.__defaultWidth = 360
CoD.Challenges_CallingCardWidget.__defaultHeight = 126
CoD.Challenges_CallingCardWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Challenges_CallingCardWidget)
	self.id = "Challenges_CallingCardWidget"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local NoiseTiledBacking = CoD.Challenges_CallingCardWidgetInternal.new(f1_arg0, f1_arg1, 0.5, 0.5, -180, 180, 0.5, 0.5, -63, 63)
	NoiseTiledBacking:mergeStateConditions({
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsSelfInState(self, "Locked")
			end,
		},
		{
			stateName = "Classified",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsSelfInState(self, "Classified")
			end,
		},
		{
			stateName = "ClassifiedShowProgress",
			condition = function(menu, element, event)
				return CoD.BaseUtility.IsSelfInState(self, "ClassifiedShowProgress")
			end,
		},
	})
	NoiseTiledBacking:linkToElementModel(self, nil, false, function(model)
		NoiseTiledBacking:setModel(model, f1_arg1)
	end)
	NoiseTiledBacking:linkToElementModel(self, "title", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			NoiseTiledBacking.Label:setText(LocalizeToUpperString(f6_local0))
		end
	end)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	self:mergeStateConditions({
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isLocked")
			end,
		},
		{
			stateName = "Classified",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "ClassifiedShowProgress",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	self:linkToElementModel(self, "isLocked", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isLocked",
		})
	end)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f11_arg2, f11_arg3, f11_arg4)
		UpdateElementState(self, "NoiseTiledBacking", controller)
	end)
	NoiseTiledBacking.id = "NoiseTiledBacking"
	self.__defaultFocus = NoiseTiledBacking
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Challenges_CallingCardWidget.__resetProperties = function(f12_arg0)
	f12_arg0.NoiseTiledBacking:completeAnimation()
	f12_arg0.NoiseTiledBacking:setScale(1, 1)
end
CoD.Challenges_CallingCardWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.NoiseTiledBacking:completeAnimation()
			f14_arg0.NoiseTiledBacking:setScale(1.05, 1.05)
			f14_arg0.clipFinished(f14_arg0.NoiseTiledBacking)
		end,
		GainChildFocus = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(1)
			local f15_local0 = function(f16_arg0)
				f15_arg0.NoiseTiledBacking:beginAnimation(200)
				f15_arg0.NoiseTiledBacking:setScale(1.05, 1.05)
				f15_arg0.NoiseTiledBacking:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.NoiseTiledBacking:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.NoiseTiledBacking:completeAnimation()
			f15_arg0.NoiseTiledBacking:setScale(1, 1)
			f15_local0(f15_arg0.NoiseTiledBacking)
		end,
		LoseChildFocus = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			local f17_local0 = function(f18_arg0)
				f17_arg0.NoiseTiledBacking:beginAnimation(200)
				f17_arg0.NoiseTiledBacking:setScale(1, 1)
				f17_arg0.NoiseTiledBacking:registerEventHandler("interrupted_keyframe", f17_arg0.clipInterrupted)
				f17_arg0.NoiseTiledBacking:registerEventHandler("transition_complete_keyframe", f17_arg0.clipFinished)
			end
			f17_arg0.NoiseTiledBacking:completeAnimation()
			f17_arg0.NoiseTiledBacking:setScale(1.05, 1.05)
			f17_local0(f17_arg0.NoiseTiledBacking)
		end,
	},
	Locked = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(0)
		end,
	},
	Classified = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(0)
		end,
	},
	ClassifiedShowProgress = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.Challenges_CallingCardWidget.__onClose = function(f22_arg0)
	f22_arg0.NoiseTiledBacking:close()
end
