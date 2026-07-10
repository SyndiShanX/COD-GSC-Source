require("x64:9e7be51d884ab71")
CoD.MPJoinedInProgressLoss = InheritFrom(LUI.UIElement)
CoD.MPJoinedInProgressLoss.__defaultWidth = 1919
CoD.MPJoinedInProgressLoss.__defaultHeight = 48
CoD.MPJoinedInProgressLoss.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.MPJoinedInProgressLoss)
	self.id = "MPJoinedInProgressLoss"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local GameTypeHintText = CoD.PrematchCountdown_BeginsIn.new(f1_arg0, f1_arg1, 0.5, 0.5, -959.5, 959.5, 0.5, 0.5, -24, 24)
	GameTypeHintText.MatchText:setAlpha(1)
	GameTypeHintText.MatchText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_78659165510B8525"))
	GameTypeHintText.MatchText:setTTF("ttmussels_demibold")
	GameTypeHintText.MatchText:setLetterSpacing(1)
	GameTypeHintText:subscribeToGlobalModel(f1_arg1, "PerController", "scriptNotify", function(model)
		local f2_local0 = GameTypeHintText
		if CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "scriptNotify", @"hash_728CE4656ACC985A") then
			PlayClip(self, "ShowMessage", f1_arg1)
		end
	end)
	self:addElement(GameTypeHintText)
	self.GameTypeHintText = GameTypeHintText
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.MPJoinedInProgressLoss.__resetProperties = function(f3_arg0)
	f3_arg0.GameTypeHintText:completeAnimation()
	f3_arg0.GameTypeHintText:setAlpha(1)
end
CoD.MPJoinedInProgressLoss.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.GameTypeHintText:completeAnimation()
			f4_arg0.GameTypeHintText:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.GameTypeHintText)
		end,
		ShowMessage = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					f7_arg0:beginAnimation(400)
					f7_arg0:setAlpha(1)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
				end
				f5_arg0.GameTypeHintText:beginAnimation(400)
				f5_arg0.GameTypeHintText:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.GameTypeHintText:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f5_arg0.GameTypeHintText:completeAnimation()
			f5_arg0.GameTypeHintText:setAlpha(0)
			f5_local0(f5_arg0.GameTypeHintText)
		end,
	},
}
CoD.MPJoinedInProgressLoss.__onClose = function(f8_arg0)
	f8_arg0.GameTypeHintText:close()
end
