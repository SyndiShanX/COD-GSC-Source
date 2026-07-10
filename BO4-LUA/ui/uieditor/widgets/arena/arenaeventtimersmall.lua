require("x64:eed3e1046bfa5f2")
require("x64:ccd687a331e7a31")
CoD.ArenaEventTimerSmall = InheritFrom(LUI.UIElement)
CoD.ArenaEventTimerSmall.__defaultWidth = 140
CoD.ArenaEventTimerSmall.__defaultHeight = 14
CoD.ArenaEventTimerSmall.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.CreateGlobalModel("lobbyPlaylist.name")
	self:setClass(CoD.ArenaEventTimerSmall)
	self.id = "ArenaEventTimerSmall"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local EventStartsIn = CoD.ArenaEventTimerSmallStartsIn.new(f1_arg0, f1_arg1, 0, 0, 0, 140, 0, 0, 0, 14)
	EventStartsIn:setAlpha(0)
	self:addElement(EventStartsIn)
	self.EventStartsIn = EventStartsIn
	local EventEndsIn = CoD.ArenaEventTimerSmallEndsIn.new(f1_arg0, f1_arg1, 0, 0, 0, 140, 0, 0, 0, 14)
	EventEndsIn:setAlpha(0)
	self:addElement(EventEndsIn)
	self.EventEndsIn = EventEndsIn
	self:mergeStateConditions({
		{
			stateName = "Event",
			condition = function(menu, element, event)
				return CoD.ArenaUtility.CurrentArenaEventTypeEquals(self, Enum[0xC0EA92D04BC003B][0xC32571741C5B730]) and CoD.ArenaUtility.IsEventCompleteTimer(self, f1_arg1, element)
			end,
		},
		{
			stateName = "NextEvent",
			condition = function(menu, element, event)
				local f3_local0
				if not CoD.ArenaUtility.CurrentArenaEventTypeEquals(self, Enum[0xC0EA92D04BC003B][0xC32571741C5B730]) then
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
	local f1_local5 = Engine[0x8DF2E5447F384B9]()
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
	f1_local5 = Engine[0x8DF2E5447F384B9]()
	f1_local4(f1_local3, f1_local5["lobbyRoot.lobbyNav"], function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ArenaEventTimerSmall.__resetProperties = function(f6_arg0)
	f6_arg0.EventEndsIn:completeAnimation()
	f6_arg0.EventStartsIn:completeAnimation()
	f6_arg0.EventEndsIn:setAlpha(0)
	f6_arg0.EventStartsIn:setAlpha(0)
end
CoD.ArenaEventTimerSmall.__clipsPerState = {
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
				f8_arg0.EventEndsIn:beginAnimation(300)
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
				f10_arg0.EventStartsIn:beginAnimation(300)
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
CoD.ArenaEventTimerSmall.__onClose = function(f12_arg0)
	f12_arg0.EventStartsIn:close()
	f12_arg0.EventEndsIn:close()
end
