require("x64:1c6bd5c481bc2be")
require("x64:1ff27ba8f489b41")
CoD.ZMAARScoreboardTabInternal = InheritFrom(LUI.UIElement)
CoD.ZMAARScoreboardTabInternal.__defaultWidth = 1920
CoD.ZMAARScoreboardTabInternal.__defaultHeight = 900
CoD.ZMAARScoreboardTabInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ZMAARScoreboardTabInternal)
	self.id = "ZMAARScoreboardTabInternal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ScoreboardZM = CoD.ScoreboardZM.new(f1_arg0, f1_arg1, 0, 0, 661, 1661, 0, 0, 95, 495)
	self:addElement(ScoreboardZM)
	self.ScoreboardZM = ScoreboardZM
	local ZMAARGameInfo = CoD.ZMAARGameInfo.new(f1_arg0, f1_arg1, 0, 0, 614, 1588, 0, 0, -45, 68)
	ZMAARGameInfo:linkToElementModel(self, nil, false, function(model)
		ZMAARGameInfo:setModel(model, f1_arg1)
	end)
	self:addElement(ZMAARGameInfo)
	self.ZMAARGameInfo = ZMAARGameInfo
	ScoreboardZM.id = "ScoreboardZM"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ZMAARScoreboardTabInternal.__resetProperties = function(f3_arg0)
	f3_arg0.ZMAARGameInfo:completeAnimation()
	f3_arg0.ScoreboardZM:completeAnimation()
	f3_arg0.ZMAARGameInfo:setAlpha(1)
	f3_arg0.ScoreboardZM:setAlpha(1)
end
CoD.ZMAARScoreboardTabInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			local f4_local0 = function(f5_arg0)
				local f5_local0 = function(f6_arg0)
					f6_arg0:beginAnimation(149)
					f6_arg0:setAlpha(1)
					f6_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
				end
				f4_arg0.ScoreboardZM:beginAnimation(200)
				f4_arg0.ScoreboardZM:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.ScoreboardZM:registerEventHandler("transition_complete_keyframe", f5_local0)
			end
			f4_arg0.ScoreboardZM:completeAnimation()
			f4_arg0.ScoreboardZM:setAlpha(0)
			f4_local0(f4_arg0.ScoreboardZM)
			local f4_local1 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					f8_arg0:beginAnimation(100, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
					f8_arg0:setAlpha(1)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
				end
				f4_arg0.ZMAARGameInfo:beginAnimation(50)
				f4_arg0.ZMAARGameInfo:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.ZMAARGameInfo:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f4_arg0.ZMAARGameInfo:completeAnimation()
			f4_arg0.ZMAARGameInfo:setAlpha(0)
			f4_local1(f4_arg0.ZMAARGameInfo)
		end,
	},
}
CoD.ZMAARScoreboardTabInternal.__onClose = function(f9_arg0)
	f9_arg0.ScoreboardZM:close()
	f9_arg0.ZMAARGameInfo:close()
end
