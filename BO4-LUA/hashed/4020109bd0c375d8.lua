require("x64:f00a10fc8301da2")
require("x64:1a70a3d7e2725e9")
require("x64:4fef7f34e3f5ca0")
require("x64:6ee653ade3452f5")
CoD.AARMeritReportTab = InheritFrom(LUI.UIElement)
CoD.AARMeritReportTab.__defaultWidth = 1920
CoD.AARMeritReportTab.__defaultHeight = 900
CoD.AARMeritReportTab.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.AARUtility.SetupMeritRewardModels(f1_arg0, f1_arg1, true)
	self:setClass(CoD.AARMeritReportTab)
	self.id = "AARMeritReportTab"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AarMpBacking = CoD.AARCommonBacking.new(f1_arg0, f1_arg1, 0.5, 0.5, -1000, 1000, 0.5, 0.5, -540, 540)
	AarMpBacking.Backer:setRGB(0, 0, 0)
	AarMpBacking.Backer:setAlpha(0.5)
	self:addElement(AarMpBacking)
	self.AarMpBacking = AarMpBacking
	local ScorestreakAspectRatioFix = nil
	ScorestreakAspectRatioFix = CoD.Scorestreak_AspectRatioFix.new(f1_arg0, f1_arg1, 0, 1, 0, 0, -0.1, 1.1, 0, 0)
	ScorestreakAspectRatioFix:mergeStateConditions({
		{
			stateName = "Warzone",
			condition = function(menu, element, event)
				return AlwaysTrue()
			end,
		},
	})
	self:addElement(ScorestreakAspectRatioFix)
	self.ScorestreakAspectRatioFix = ScorestreakAspectRatioFix
	local MeritReport = CoD.MeritReportWidget.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 0.5, 0.5, -540, 540)
	MeritReport:mergeStateConditions({
		{
			stateName = "ContractsEnabled",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "ContractsEnabledTabs",
			condition = function(menu, element, event)
				return IsBooleanDvarSet("ui_enableContractsAndBounties")
			end,
		},
	})
	MeritReport:subscribeToGlobalModel(f1_arg1, "AARMeritReport", nil, function(model)
		MeritReport:setModel(model, f1_arg1)
	end)
	self:addElement(MeritReport)
	self.MeritReport = MeritReport
	local DoubleXPIcon = CoD.DoubleXPIcon.new(f1_arg0, f1_arg1, 0.5, 0.5, 605, 677, 0.5, 0.5, 348, 420)
	self:addElement(DoubleXPIcon)
	self.DoubleXPIcon = DoubleXPIcon
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "AAR.activeTab", CoD.AARUtility.AARTabs.AAR_MERIT)
			end,
		},
	})
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["AAR.activeTab"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "AAR.activeTab",
		})
	end, false)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "AAR.activeTab", function(model)
		local f8_local0 = self
		if CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "AAR.activeTab", CoD.AARUtility.AARTabs.AAR_MERIT) then
			CoD.AARUtility.SetupMeritRewardModels(f1_arg0, f1_arg1, true)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AARMeritReportTab.__resetProperties = function(f9_arg0)
	f9_arg0.MeritReport:completeAnimation()
	f9_arg0.AarMpBacking:completeAnimation()
	f9_arg0.DoubleXPIcon:completeAnimation()
	f9_arg0.MeritReport:setAlpha(1)
	f9_arg0.AarMpBacking:setAlpha(1)
	f9_arg0.DoubleXPIcon:setAlpha(1)
end
CoD.AARMeritReportTab.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(3)
			f10_arg0.AarMpBacking:completeAnimation()
			f10_arg0.AarMpBacking:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.AarMpBacking)
			f10_arg0.MeritReport:completeAnimation()
			f10_arg0.MeritReport:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.MeritReport)
			f10_arg0.DoubleXPIcon:completeAnimation()
			f10_arg0.DoubleXPIcon:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.DoubleXPIcon)
		end,
	},
	Visible = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			local f11_local0 = function(f12_arg0)
				f11_arg0.AarMpBacking:beginAnimation(150, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f11_arg0.AarMpBacking:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.AarMpBacking:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.AarMpBacking:completeAnimation()
			f11_arg0.AarMpBacking:setAlpha(1)
			f11_local0(f11_arg0.AarMpBacking)
			local f11_local1 = function(f13_arg0)
				local f13_local0 = function(f14_arg0)
					f14_arg0:beginAnimation(150)
					f14_arg0:setAlpha(1)
					f14_arg0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
				end
				f11_arg0.MeritReport:beginAnimation(150)
				f11_arg0.MeritReport:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.MeritReport:registerEventHandler("transition_complete_keyframe", f13_local0)
			end
			f11_arg0.MeritReport:completeAnimation()
			f11_arg0.MeritReport:setAlpha(0)
			f11_local1(f11_arg0.MeritReport)
			local f11_local2 = function(f15_arg0)
				f11_arg0.DoubleXPIcon:beginAnimation(300)
				f11_arg0.DoubleXPIcon:setAlpha(1)
				f11_arg0.DoubleXPIcon:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.DoubleXPIcon:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.DoubleXPIcon:completeAnimation()
			f11_arg0.DoubleXPIcon:setAlpha(0)
			f11_local2(f11_arg0.DoubleXPIcon)
		end,
	},
}
CoD.AARMeritReportTab.__onClose = function(f16_arg0)
	f16_arg0.AarMpBacking:close()
	f16_arg0.ScorestreakAspectRatioFix:close()
	f16_arg0.MeritReport:close()
	f16_arg0.DoubleXPIcon:close()
end
