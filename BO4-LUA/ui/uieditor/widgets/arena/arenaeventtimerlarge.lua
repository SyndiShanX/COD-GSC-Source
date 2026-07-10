CoD.ArenaEventTimerLarge = InheritFrom(LUI.UIElement)
CoD.ArenaEventTimerLarge.__defaultWidth = 260
CoD.ArenaEventTimerLarge.__defaultHeight = 25
CoD.ArenaEventTimerLarge.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.CreateGlobalModel("lobbyPlaylist.name")
	self:setClass(CoD.ArenaEventTimerLarge)
	self.id = "ArenaEventTimerLarge"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local EventEndsIn = LUI.UIText.new(0, 0, 0, 260, 0, 0, 4, 25)
	EventEndsIn:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	EventEndsIn:setAlpha(0)
	EventEndsIn:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	EventEndsIn:setTTF("dinnext_regular")
	EventEndsIn:setLetterSpacing(1)
	EventEndsIn:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	EventEndsIn:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(EventEndsIn)
	self.EventEndsIn = EventEndsIn
	local EventStartsIn = LUI.UIText.new(0, 0, 0, 260, 0, 0, 4, 25)
	EventStartsIn:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	EventStartsIn:setAlpha(0)
	EventStartsIn:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	EventStartsIn:setTTF("dinnext_regular")
	EventStartsIn:setLetterSpacing(1)
	EventStartsIn:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	EventStartsIn:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(EventStartsIn)
	self.EventStartsIn = EventStartsIn
	self:mergeStateConditions({
		{
			stateName = "Event",
			condition = function(menu, element, event)
				return CoD.ArenaUtility.CurrentArenaEventTypeEquals(self, Enum[@"hash_6C0EA92D04BC003B"][@"hash_5C32571741C5B730"]) and CoD.ArenaUtility.IsEventCompleteTimer(self, f1_arg1, element)
			end,
		},
		{
			stateName = "NextEvent",
			condition = function(menu, element, event)
				local f3_local0
				if not CoD.ArenaUtility.CurrentArenaEventTypeEquals(self, Enum[@"hash_6C0EA92D04BC003B"][@"hash_5C32571741C5B730"]) then
					f3_local0 = CoD.ArenaUtility.IsNextEventCompleteTimer(self, f1_arg1, element)
				else
					f3_local0 = false
				end
				return f3_local0
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[@"getglobalmodel"]()
	f1_local4(f1_local3, f1_local5["lobbyPlaylist.name"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "lobbyPlaylist.name",
		})
	end, false)
	f1_local3 = self
	f1_local4 = self.subscribeToModel
	f1_local5 = Engine[@"getglobalmodel"]()
	f1_local4(f1_local3, f1_local5["lobbyRoot.lobbyNav"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaEventTimerLarge.__resetProperties = function(f6_arg0)
	f6_arg0.EventEndsIn:completeAnimation()
	f6_arg0.EventStartsIn:completeAnimation()
	f6_arg0.EventEndsIn:setAlpha(0)
	f6_arg0.EventStartsIn:setAlpha(0)
end
CoD.ArenaEventTimerLarge.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	Event = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.EventEndsIn:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_out"])
				f8_arg0.EventEndsIn:setAlpha(1)
				f8_arg0.EventEndsIn:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.EventEndsIn:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.EventEndsIn:completeAnimation()
			f8_arg0.EventEndsIn:setAlpha(0)
			f8_local0(f8_arg0.EventEndsIn)
		end,
	},
	NextEvent = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			local f10_local0 = function(f11_arg0)
				f10_arg0.EventStartsIn:beginAnimation(300, Enum[@"luitween"][@"luitween_ease_out"])
				f10_arg0.EventStartsIn:setAlpha(1)
				f10_arg0.EventStartsIn:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.EventStartsIn:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.EventStartsIn:completeAnimation()
			f10_arg0.EventStartsIn:setAlpha(0)
			f10_local0(f10_arg0.EventStartsIn)
		end,
	},
}
