CoD.DirectorMatchmakingTimerInternal = InheritFrom(LUI.UIElement)
CoD.DirectorMatchmakingTimerInternal.__defaultWidth = 286
CoD.DirectorMatchmakingTimerInternal.__defaultHeight = 76
CoD.DirectorMatchmakingTimerInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.DirectorMatchmakingTimerInternal)
	self.id = "DirectorMatchmakingTimerInternal"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ElapsedTime = LUI.UIText.new(0, 0, 10, 310, 0, 0, 30, 48)
	ElapsedTime:setRGB(0.92, 0.92, 0.92)
	ElapsedTime:setTTF("ttmussels_demibold")
	ElapsedTime:setLetterSpacing(6)
	ElapsedTime:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ElapsedTime:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	ElapsedTime:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "publicLobby.matchmakingElapsedTime", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ElapsedTime:setText(CoD.DirectorUtility.GetMatchmakingElapsedTimeString(f2_local0))
		end
	end)
	self:addElement(ElapsedTime)
	self.ElapsedTime = ElapsedTime
	local EstimatedTime = LUI.UIText.new(0, 0, 10, 310, 0, 0, 10, 28)
	EstimatedTime:setRGB(0.92, 0.92, 0.92)
	EstimatedTime:setTTF("ttmussels_demibold")
	EstimatedTime:setLetterSpacing(6)
	EstimatedTime:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	EstimatedTime:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	EstimatedTime:subscribeToGlobalModel(f1_arg1, "LobbyRoot", "publicLobby.matchmakingEstimatedTime", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			EstimatedTime:setText(CoD.DirectorUtility.GetMatchmakingEstimatedTimeString(f3_local0))
		end
	end)
	self:addElement(EstimatedTime)
	self.EstimatedTime = EstimatedTime
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorMatchmakingTimerInternal.__resetProperties = function(f4_arg0)
	f4_arg0.EstimatedTime:completeAnimation()
	f4_arg0.ElapsedTime:completeAnimation()
	f4_arg0.EstimatedTime:setLeftRight(0, 0, 10, 310)
	f4_arg0.EstimatedTime:setTopBottom(0, 0, 10, 28)
	f4_arg0.EstimatedTime:setAlpha(1)
	f4_arg0.ElapsedTime:setLeftRight(0, 0, 10, 310)
	f4_arg0.ElapsedTime:setTopBottom(0, 0, 30, 48)
	f4_arg0.ElapsedTime:setAlpha(1)
end
CoD.DirectorMatchmakingTimerInternal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.ElapsedTime:completeAnimation()
			f5_arg0.ElapsedTime:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.ElapsedTime)
			f5_arg0.EstimatedTime:completeAnimation()
			f5_arg0.EstimatedTime:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.EstimatedTime)
		end,
		EstimatedTimeHidden = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			local f6_local0 = function(f7_arg0)
				f6_arg0.ElapsedTime:beginAnimation(500)
				f6_arg0.ElapsedTime:setTopBottom(0, 0, 21, 39)
				f6_arg0.ElapsedTime:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.ElapsedTime:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.ElapsedTime:completeAnimation()
			f6_arg0.ElapsedTime:setLeftRight(0, 0, 10, 320)
			f6_arg0.ElapsedTime:setTopBottom(0, 0, 30, 48)
			f6_arg0.ElapsedTime:setAlpha(1)
			f6_local0(f6_arg0.ElapsedTime)
			local f6_local1 = function(f8_arg0)
				f6_arg0.EstimatedTime:beginAnimation(500)
				f6_arg0.EstimatedTime:setAlpha(0)
				f6_arg0.EstimatedTime:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.EstimatedTime:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.EstimatedTime:completeAnimation()
			f6_arg0.EstimatedTime:setAlpha(1)
			f6_local1(f6_arg0.EstimatedTime)
		end,
	},
	EstimatedTimeHidden = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.ElapsedTime:completeAnimation()
			f9_arg0.ElapsedTime:setLeftRight(0, 0, 10, 320)
			f9_arg0.ElapsedTime:setTopBottom(0, 0, 21, 39)
			f9_arg0.ElapsedTime:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.ElapsedTime)
			f9_arg0.EstimatedTime:completeAnimation()
			f9_arg0.EstimatedTime:setLeftRight(0, 0, 28, 286)
			f9_arg0.EstimatedTime:setTopBottom(0, 0, 3, 40)
			f9_arg0.EstimatedTime:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.EstimatedTime)
		end,
	},
}
CoD.DirectorMatchmakingTimerInternal.__onClose = function(f10_arg0)
	f10_arg0.ElapsedTime:close()
	f10_arg0.EstimatedTime:close()
end
