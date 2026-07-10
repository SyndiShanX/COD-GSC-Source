require("x64:f00a10fc8301da2")
require("x64:9bf8b4f75b10e85")
require("x64:14c38de54a0f4cc")
CoD.AARSummaryTab = InheritFrom(LUI.UIElement)
CoD.AARSummaryTab.__defaultWidth = 1920
CoD.AARSummaryTab.__defaultHeight = 900
CoD.AARSummaryTab.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARSummaryTab)
	self.id = "AARSummaryTab"
	self.soundSet = "none"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AarMpBacking = CoD.AARCommonBacking.new(f1_arg0, f1_arg1, 0.5, 0.5, -349, 1007, 0, 0, 43, 878)
	self:addElement(AarMpBacking)
	self.AarMpBacking = AarMpBacking
	local AARSummaryTabInternal = CoD.AARSummaryTabInternal.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -357, 543)
	AARSummaryTabInternal:linkToElementModel(self, nil, false, function(model)
		AARSummaryTabInternal:setModel(model, f1_arg1)
	end)
	self:addElement(AARSummaryTabInternal)
	self.AARSummaryTabInternal = AARSummaryTabInternal
	local IGRPerksAAR = nil
	IGRPerksAAR = CoD.PC_IGR_AAR_BonusXP.new(f1_arg0, f1_arg1, 1, 1, -631, -281, 0.01, 0.01, 34, 223)
	self:addElement(IGRPerksAAR)
	self.IGRPerksAAR = IGRPerksAAR
	self:mergeStateConditions({
		{
			stateName = "Arena",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "AAR.activeTab", CoD.AARUtility.AARTabs.AAR_SUMMARY) and IsArenaMode()
			end,
		},
		{
			stateName = "ZM",
			condition = function(menu, element, event)
				return IsZombies() and CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "AAR.activeTab", CoD.AARUtility.AARTabs.AAR_SUMMARY)
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "AAR.activeTab", CoD.AARUtility.AARTabs.AAR_SUMMARY)
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["AAR.activeTab"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "AAR.activeTab",
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getglobalmodel"]()
	f1_local5(f1_local4, f1_local6["lobbyRoot.lobbyNav"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	AARSummaryTabInternal.id = "AARSummaryTabInternal"
	self.__defaultFocus = AARSummaryTabInternal
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARSummaryTab.__resetProperties = function(f8_arg0)
	f8_arg0.AARSummaryTabInternal:completeAnimation()
	f8_arg0.AarMpBacking:completeAnimation()
	f8_arg0.AARSummaryTabInternal:setAlpha(1)
	f8_arg0.AarMpBacking:setAlpha(1)
	f8_arg0.AarMpBacking.Backer:setRGB(0.67, 0.67, 0.67)
	f8_arg0.AarMpBacking.Backer:setAlpha(0.02)
end
CoD.AARSummaryTab.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.AarMpBacking:completeAnimation()
			f9_arg0.AarMpBacking:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.AarMpBacking)
			f9_arg0.AARSummaryTabInternal:completeAnimation()
			f9_arg0.AARSummaryTabInternal:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.AARSummaryTabInternal)
		end,
	},
	Arena = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
	ZM = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			local f11_local0 = function(f12_arg0)
				f11_arg0.AarMpBacking:beginAnimation(150, Enum[@"luitween"][@"luitween_ease_in"])
				f11_arg0.AarMpBacking:setAlpha(1)
				f11_arg0.AarMpBacking:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.AarMpBacking:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.AarMpBacking:completeAnimation()
			f11_arg0.AarMpBacking.Backer:completeAnimation()
			f11_arg0.AarMpBacking:setAlpha(0)
			f11_arg0.AarMpBacking.Backer:setRGB(0.02, 0, 0)
			f11_arg0.AarMpBacking.Backer:setAlpha(0.4)
			f11_local0(f11_arg0.AarMpBacking)
			local f11_local1 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					f14_arg0:beginAnimation(150)
					f14_arg0:setAlpha(1)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.AARSummaryTabInternal:beginAnimation(150)
				f11_arg0.AARSummaryTabInternal:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.AARSummaryTabInternal:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f11_arg0.AARSummaryTabInternal:completeAnimation()
			f11_arg0.AARSummaryTabInternal:setAlpha(0)
			f11_local1(f11_arg0.AARSummaryTabInternal)
		end,
	},
	Visible = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(2)
			local f15_local0 = function(f16_arg0)
				f15_arg0.AarMpBacking:beginAnimation(150, Enum[@"luitween"][@"luitween_ease_in"])
				f15_arg0.AarMpBacking:setAlpha(1)
				f15_arg0.AarMpBacking:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.AarMpBacking:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
			end
			f15_arg0.AarMpBacking:completeAnimation()
			f15_arg0.AarMpBacking:setAlpha(0)
			f15_local0(f15_arg0.AarMpBacking)
			local f15_local1 = function(f17_arg0)
				local f17_local0 = function(f18_arg0)
					f18_arg0:beginAnimation(150)
					f18_arg0:setAlpha(1)
					f18_arg0:registerEventHandler("transition_complete_keyframe", f15_arg0.clipFinished)
				end
				f15_arg0.AARSummaryTabInternal:beginAnimation(150)
				f15_arg0.AARSummaryTabInternal:registerEventHandler("interrupted_keyframe", f15_arg0.clipInterrupted)
				f15_arg0.AARSummaryTabInternal:registerEventHandler("transition_complete_keyframe", f17_local0)
			end
			f15_arg0.AARSummaryTabInternal:completeAnimation()
			f15_arg0.AARSummaryTabInternal:setAlpha(0)
			f15_local1(f15_arg0.AARSummaryTabInternal)
		end,
	},
}
CoD.AARSummaryTab.__onClose = function(f19_arg0)
	f19_arg0.AarMpBacking:close()
	f19_arg0.AARSummaryTabInternal:close()
	f19_arg0.IGRPerksAAR:close()
end
