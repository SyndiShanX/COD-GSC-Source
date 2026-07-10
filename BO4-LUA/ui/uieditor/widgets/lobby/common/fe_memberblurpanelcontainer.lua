require("x64:86efbc2f8bdf0be")
CoD.FE_MemberBlurPanelContainer = InheritFrom(LUI.UIElement)
CoD.FE_MemberBlurPanelContainer.__defaultWidth = 522
CoD.FE_MemberBlurPanelContainer.__defaultHeight = 42
CoD.FE_MemberBlurPanelContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FE_MemberBlurPanelContainer)
	self.id = "FE_MemberBlurPanelContainer"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FEMemberBlurPanel0 = CoD.FE_MemberBlurPanel.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(FEMemberBlurPanel0)
	self.FEMemberBlurPanel0 = FEMemberBlurPanel0
	self:mergeStateConditions({
		{
			stateName = "Transparent",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("hideWorldForStreamer", 1)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4.hideWorldForStreamer, function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "hideWorldForStreamer",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.FE_MemberBlurPanelContainer.__resetProperties = function(f4_arg0)
	f4_arg0.FEMemberBlurPanel0:completeAnimation()
	f4_arg0.FEMemberBlurPanel0:setAlpha(1)
end
CoD.FE_MemberBlurPanelContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	Transparent = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.FEMemberBlurPanel0:completeAnimation()
			f6_arg0.FEMemberBlurPanel0:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.FEMemberBlurPanel0)
		end,
		DefaultState = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.FEMemberBlurPanel0:beginAnimation(300)
				f7_arg0.FEMemberBlurPanel0:setAlpha(1)
				f7_arg0.FEMemberBlurPanel0:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.FEMemberBlurPanel0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.FEMemberBlurPanel0:completeAnimation()
			f7_arg0.FEMemberBlurPanel0:setAlpha(0)
			f7_local0(f7_arg0.FEMemberBlurPanel0)
		end,
	},
}
CoD.FE_MemberBlurPanelContainer.__onClose = function(f9_arg0)
	f9_arg0.FEMemberBlurPanel0:close()
end
