CoD.LobbyStreamerBlackFade = InheritFrom(LUI.UIElement)
CoD.LobbyStreamerBlackFade.__defaultWidth = 1920
CoD.LobbyStreamerBlackFade.__defaultHeight = 1080
CoD.LobbyStreamerBlackFade.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LobbyStreamerBlackFade)
	self.id = "LobbyStreamerBlackFade"
	self.soundSet = "MultiplayerMain"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Black = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Black:setRGB(0, 0, 0)
	Black:setAlpha(0)
	self:addElement(Black)
	self.Black = Black
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LobbyStreamerBlackFade.__resetProperties = function(f2_arg0)
	f2_arg0.Black:completeAnimation()
	f2_arg0.Black:setAlpha(0)
end
CoD.LobbyStreamerBlackFade.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.Black:completeAnimation()
			f3_arg0.Black:setAlpha(1)
			f3_arg0.clipFinished(f3_arg0.Black)
		end,
		Transparent = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			local f4_local0 = function(f5_arg0)
				f4_arg0.Black:beginAnimation(300)
				f4_arg0.Black:setAlpha(0)
				f4_arg0.Black:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.Black:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			end
			f4_arg0.Black:completeAnimation()
			f4_arg0.Black:setAlpha(1)
			f4_local0(f4_arg0.Black)
		end,
	},
	Transparent = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
}
