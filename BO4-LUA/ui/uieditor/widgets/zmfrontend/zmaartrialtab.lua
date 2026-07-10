require("x64:f00a10fc8301da2")
require("x64:601b37c4440aa49")
CoD.ZMAARTrialTab = InheritFrom(LUI.UIElement)
CoD.ZMAARTrialTab.__defaultWidth = 1920
CoD.ZMAARTrialTab.__defaultHeight = 900
CoD.ZMAARTrialTab.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMAARTrialTab)
	self.id = "ZMAARTrialTab"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AarMpBacking = CoD.AARCommonBacking.new(f1_arg0, f1_arg1, 0.5, 0.5, -349, 1007, 0, 0, 43, 878)
	AarMpBacking.Backer:setRGB(0.02, 0, 0)
	AarMpBacking.Backer:setAlpha(0.4)
	self:addElement(AarMpBacking)
	self.AarMpBacking = AarMpBacking
	local AARTrialInfo = CoD.ZMAARTrialTabInternal.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -450, 450)
	AARTrialInfo:linkToElementModel(self, nil, false, function(model)
		AARTrialInfo:setModel(model, f1_arg1)
	end)
	self:addElement(AARTrialInfo)
	self.AARTrialInfo = AARTrialInfo
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "AAR.activeTab", CoD.AARUtility.AARTabs.AAR_TRIAL)
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local4(f1_local3, f1_local5["AAR.activeTab"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "AAR.activeTab",
		})
	end, false)
	AARTrialInfo.id = "AARTrialInfo"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMAARTrialTab.__resetProperties = function(f5_arg0)
	f5_arg0.AARTrialInfo:completeAnimation()
	f5_arg0.AarMpBacking:completeAnimation()
	f5_arg0.AARTrialInfo:setAlpha(1)
	f5_arg0.AarMpBacking:setAlpha(1)
end
CoD.ZMAARTrialTab.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.AarMpBacking:completeAnimation()
			f6_arg0.AarMpBacking:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.AarMpBacking)
			f6_arg0.AARTrialInfo:completeAnimation()
			f6_arg0.AARTrialInfo:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.AARTrialInfo)
		end,
	},
	Visible = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			local f7_local0 = function(f8_arg0)
				f7_arg0.AarMpBacking:beginAnimation(150, Enum[@"luitween"][@"luitween_ease_in"])
				f7_arg0.AarMpBacking:setAlpha(1)
				f7_arg0.AarMpBacking:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.AarMpBacking:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.AarMpBacking:completeAnimation()
			f7_arg0.AarMpBacking:setAlpha(0)
			f7_local0(f7_arg0.AarMpBacking)
			local f7_local1 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					f10_arg0:beginAnimation(150)
					f10_arg0:setAlpha(1)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
				end
				f7_arg0.AARTrialInfo:beginAnimation(150)
				f7_arg0.AARTrialInfo:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.AARTrialInfo:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f7_arg0.AARTrialInfo:completeAnimation()
			f7_arg0.AARTrialInfo:setAlpha(0)
			f7_local1(f7_arg0.AARTrialInfo)
		end,
	},
}
CoD.ZMAARTrialTab.__onClose = function(f11_arg0)
	f11_arg0.AarMpBacking:close()
	f11_arg0.AARTrialInfo:close()
end
