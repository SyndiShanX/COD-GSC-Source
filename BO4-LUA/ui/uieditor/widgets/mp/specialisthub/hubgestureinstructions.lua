CoD.HubGestureInstructions = InheritFrom(LUI.UIElement)
CoD.HubGestureInstructions.__defaultWidth = 410
CoD.HubGestureInstructions.__defaultHeight = 18
CoD.HubGestureInstructions.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HubGestureInstructions)
	self.id = "HubGestureInstructions"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LobbyGestureInstruct = LUI.UIText.new(0.5, 0.5, -205, 205, 0.5, 0.5, -9, 9)
	LobbyGestureInstruct:setRGB(ColorSet.T8__OFF__GRAY.r, ColorSet.T8__OFF__GRAY.g, ColorSet.T8__OFF__GRAY.b)
	LobbyGestureInstruct:setText(Engine[0xF9F1239CFD921FE](0x81261AF40E18937))
	LobbyGestureInstruct:setTTF("dinnext_regular")
	LobbyGestureInstruct:setLetterSpacing(2)
	LobbyGestureInstruct:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	LobbyGestureInstruct:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(LobbyGestureInstruct)
	self.LobbyGestureInstruct = LobbyGestureInstruct
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not IsBooleanDvarSet("lobby_gestures_enabled")
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.HubGestureInstructions.__resetProperties = function(f3_arg0)
	f3_arg0.LobbyGestureInstruct:completeAnimation()
	f3_arg0.LobbyGestureInstruct:setAlpha(1)
end
CoD.HubGestureInstructions.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		Hidden = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.LobbyGestureInstruct:beginAnimation(230)
			f5_arg0.LobbyGestureInstruct:setAlpha(0)
			f5_arg0.LobbyGestureInstruct:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
			f5_arg0.LobbyGestureInstruct:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
		end,
	},
	Hidden = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.LobbyGestureInstruct:completeAnimation()
			f6_arg0.LobbyGestureInstruct:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.LobbyGestureInstruct)
		end,
	},
}
