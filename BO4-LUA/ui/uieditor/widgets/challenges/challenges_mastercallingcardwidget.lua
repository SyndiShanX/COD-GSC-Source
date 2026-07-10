require("x64:6e8674364edc8a4")
CoD.Challenges_MasterCallingCardWidget = InheritFrom(LUI.UIElement)
CoD.Challenges_MasterCallingCardWidget.__defaultWidth = 1131
CoD.Challenges_MasterCallingCardWidget.__defaultHeight = 100
CoD.Challenges_MasterCallingCardWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Challenges_MasterCallingCardWidget)
	self.id = "Challenges_MasterCallingCardWidget"
	self.soundSet = "FrontendMain"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local CallingCards = CoD.Challenges_MasterCallingCardWidget_Internal.new(f1_arg0, f1_arg1, 0.5, 0.5, -565.5, 565.5, 0.5, 0.5, -50, 50)
	CallingCards:linkToElementModel(self, nil, false, function(model)
		CallingCards:setModel(model, f1_arg1)
	end)
	self:addElement(CallingCards)
	self.CallingCards = CallingCards
	self:mergeStateConditions({
		{
			stateName = "Classified",
			condition = function(menu, element, event)
				return AlwaysFalse() and CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isLocked")
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "isLocked")
			end,
		},
		{
			stateName = "Complete",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "percentComplete", 1)
			end,
		},
		{
			stateName = "Hidden",
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
	self:linkToElementModel(self, "percentComplete", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "percentComplete",
		})
	end)
	CallingCards.id = "CallingCards"
	self.__defaultFocus = CallingCards
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	CoD.BaseUtility.SyncChildStateToSelfState(self, f1_arg1, self.CallingCards)
	return self
end
CoD.Challenges_MasterCallingCardWidget.__resetProperties = function(f9_arg0)
	f9_arg0.CallingCards:completeAnimation()
	f9_arg0.CallingCards:setAlpha(1)
	f9_arg0.CallingCards:setScale(1, 1)
end
CoD.Challenges_MasterCallingCardWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.CallingCards:completeAnimation()
			f11_arg0.CallingCards:setScale(1.05, 1.05)
			f11_arg0.clipFinished(f11_arg0.CallingCards)
		end,
		GainChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			local f12_local0 = function(f13_arg0)
				f12_arg0.CallingCards:beginAnimation(200)
				f12_arg0.CallingCards:setScale(1.05, 1.05)
				f12_arg0.CallingCards:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.CallingCards:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.CallingCards:completeAnimation()
			f12_arg0.CallingCards:setScale(1, 1)
			f12_local0(f12_arg0.CallingCards)
		end,
		LoseChildFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			local f14_local0 = function(f15_arg0)
				f14_arg0.CallingCards:beginAnimation(200)
				f14_arg0.CallingCards:setScale(1, 1)
				f14_arg0.CallingCards:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.CallingCards:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.CallingCards:completeAnimation()
			f14_arg0.CallingCards:setScale(1.05, 1.05)
			f14_local0(f14_arg0.CallingCards)
		end,
	},
	Classified = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
	},
	Locked = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(0)
		end,
	},
	Complete = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(1)
			f19_arg0.CallingCards:completeAnimation()
			f19_arg0.CallingCards:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.CallingCards)
		end,
	},
}
CoD.Challenges_MasterCallingCardWidget.__onClose = function(f20_arg0)
	f20_arg0.CallingCards:close()
end
