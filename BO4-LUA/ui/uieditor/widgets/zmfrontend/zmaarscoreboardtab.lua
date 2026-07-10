require("x64:f00a10fc8301da2")
require("x64:df000c52aa8e445")
CoD.ZMAARScoreboardTab = InheritFrom(LUI.UIElement)
CoD.ZMAARScoreboardTab.__defaultWidth = 1920
CoD.ZMAARScoreboardTab.__defaultHeight = 900
CoD.ZMAARScoreboardTab.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMAARScoreboardTab)
	self.id = "ZMAARScoreboardTab"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local AarMpBacking = CoD.AARCommonBacking.new(f1_arg0, f1_arg1, 0.5, 0.5, -349, 1007, 0, 0, 43, 878)
	AarMpBacking.Backer:setRGB(0.02, 0, 0)
	AarMpBacking.Backer:setAlpha(0.4)
	self:addElement(AarMpBacking)
	self.AarMpBacking = AarMpBacking
	local ScoreboardZM = CoD.ZMAARScoreboardTabInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 1920, 0, 0, 93, 993)
	ScoreboardZM:linkToElementModel(self, nil, false, function(model)
		ScoreboardZM:setModel(model, f1_arg1)
	end)
	self:addElement(ScoreboardZM)
	self.ScoreboardZM = ScoreboardZM
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueEqualToEnum(f1_arg1, "AAR.activeTab", CoD.AARUtility.AARTabs.ZM_AAR_SCOREBOARD)
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["AAR.activeTab"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "AAR.activeTab",
		})
	end, false)
	ScoreboardZM.id = "ScoreboardZM"
	self.__defaultFocus = ScoreboardZM
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMAARScoreboardTab.__resetProperties = function(f5_arg0)
	f5_arg0.ScoreboardZM:completeAnimation()
	f5_arg0.AarMpBacking:completeAnimation()
	f5_arg0.ScoreboardZM:setAlpha(1)
	f5_arg0.AarMpBacking:setAlpha(1)
end
CoD.ZMAARScoreboardTab.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.AarMpBacking:completeAnimation()
			f6_arg0.AarMpBacking:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.AarMpBacking)
			f6_arg0.ScoreboardZM:completeAnimation()
			f6_arg0.ScoreboardZM:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.ScoreboardZM)
		end,
	},
	Visible = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			local f7_local0 = function(f8_arg0)
				f7_arg0.AarMpBacking:beginAnimation(150, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
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
				f7_arg0.ScoreboardZM:beginAnimation(150)
				f7_arg0.ScoreboardZM:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.ScoreboardZM:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f7_arg0.ScoreboardZM:completeAnimation()
			f7_arg0.ScoreboardZM:setAlpha(0)
			f7_local1(f7_arg0.ScoreboardZM)
		end,
	},
}
CoD.ZMAARScoreboardTab.__onClose = function(f11_arg0)
	f11_arg0.AarMpBacking:close()
	f11_arg0.ScoreboardZM:close()
end
