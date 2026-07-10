require("x64:f841dd83b370a80")
CoD.ChallengesCategoryButton = InheritFrom(LUI.UIElement)
CoD.ChallengesCategoryButton.__defaultWidth = 1000
CoD.ChallengesCategoryButton.__defaultHeight = 100
CoD.ChallengesCategoryButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ChallengesCategoryButton)
	self.id = "ChallengesCategoryButton"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ChallengesCategoryButtonInternal = CoD.Challenges_Category_ButtonInternal.new(f1_arg0, f1_arg1, 0.5, 0.5, -500, 500, 0.5, 0.5, -50, 50)
	ChallengesCategoryButtonInternal:linkToElementModel(self, nil, false, function(model)
		ChallengesCategoryButtonInternal:setModel(model, f1_arg1)
	end)
	self:addElement(ChallengesCategoryButtonInternal)
	self.ChallengesCategoryButtonInternal = ChallengesCategoryButtonInternal
	self:mergeStateConditions({
		{
			stateName = "Complete",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "percentComplete", 1)
			end,
		},
		{
			stateName = "Disabled",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "categoryLocked")
			end,
		},
	})
	self:linkToElementModel(self, "percentComplete", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "percentComplete",
		})
	end)
	self:linkToElementModel(self, "categoryLocked", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "categoryLocked",
		})
	end)
	ChallengesCategoryButtonInternal.id = "ChallengesCategoryButtonInternal"
	self.__defaultFocus = ChallengesCategoryButtonInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	CoD.BaseUtility.SyncChildStateToSelfState(self, f1_arg1, self.ChallengesCategoryButtonInternal)
	return self
end
CoD.ChallengesCategoryButton.__resetProperties = function(f7_arg0)
	f7_arg0.ChallengesCategoryButtonInternal:completeAnimation()
	f7_arg0.ChallengesCategoryButtonInternal:setScale(1, 1)
end
CoD.ChallengesCategoryButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.ChallengesCategoryButtonInternal:completeAnimation()
			f9_arg0.ChallengesCategoryButtonInternal:setScale(1.05, 1.05)
			f9_arg0.clipFinished(f9_arg0.ChallengesCategoryButtonInternal)
		end,
		GainChildFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			local f10_local0 = function(f11_arg0)
				f10_arg0.ChallengesCategoryButtonInternal:beginAnimation(200)
				f10_arg0.ChallengesCategoryButtonInternal:setScale(1.05, 1.05)
				f10_arg0.ChallengesCategoryButtonInternal:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.ChallengesCategoryButtonInternal:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.ChallengesCategoryButtonInternal:completeAnimation()
			f10_arg0.ChallengesCategoryButtonInternal:setScale(1, 1)
			f10_local0(f10_arg0.ChallengesCategoryButtonInternal)
		end,
		LoseChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			local f12_local0 = function(f13_arg0)
				f12_arg0.ChallengesCategoryButtonInternal:beginAnimation(200)
				f12_arg0.ChallengesCategoryButtonInternal:setScale(1, 1)
				f12_arg0.ChallengesCategoryButtonInternal:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.ChallengesCategoryButtonInternal:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.ChallengesCategoryButtonInternal:completeAnimation()
			f12_arg0.ChallengesCategoryButtonInternal:setScale(1.05, 1.05)
			f12_local0(f12_arg0.ChallengesCategoryButtonInternal)
		end,
	},
	Complete = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
	},
	Disabled = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.ChallengesCategoryButton.__onClose = function(f16_arg0)
	f16_arg0.ChallengesCategoryButtonInternal:close()
end
