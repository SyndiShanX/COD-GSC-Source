require("x64:7ec6bc10fa8e6b3")
require("x64:29187ea00d726c3")
CoD.ArenaLeagueEventTimer = InheritFrom(LUI.UIElement)
CoD.ArenaLeagueEventTimer.__defaultWidth = 595
CoD.ArenaLeagueEventTimer.__defaultHeight = 25
CoD.ArenaLeagueEventTimer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 1, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.ArenaLeagueEventTimer)
	self.id = "ArenaLeagueEventTimer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local event = LUI.UIText.new(0, 0, 0, 111, 0, 0, 0, 25)
	event:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	event:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6FB561925D7F1E7E"))
	event:setTTF("ttmussels_demibold")
	event:setLetterSpacing(2)
	event:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(event)
	self.event = event
	local VerticalListSpacer = CoD.VerticalListSpacer.new(f1_arg0, f1_arg1, 0, 0, 112, 137, 0, 0, 0, 25)
	self:addElement(VerticalListSpacer)
	self.VerticalListSpacer = VerticalListSpacer
	local ArenaEventTimerLarge = CoD.ArenaEventTimerLarge.new(f1_arg0, f1_arg1, 0, 0, 138, 398, 0, 0, 0, 25)
	ArenaEventTimerLarge:subscribeToGlobalModel(f1_arg1, "Arena", "arenaEventTimer", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ArenaEventTimerLarge.EventEndsIn:setText(f2_local0)
		end
	end)
	self:addElement(ArenaEventTimerLarge)
	self.ArenaEventTimerLarge = ArenaEventTimerLarge
	self:mergeStateConditions({
		{
			stateName = "Unranked",
			condition = function(menu, element, event)
				return CoD.ArenaUtility.CurrentArenaEventTypeEquals(self, Enum[@"hash_6C0EA92D04BC003B"][@"hash_4185075D2D3D8497"])
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[@"getglobalmodel"]()
	f1_local5(f1_local4, f1_local6["lobbyPlaylist.name"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "lobbyPlaylist.name",
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getglobalmodel"]()
	f1_local5(f1_local4, f1_local6["lobbyRoot.lobbyNav"], function(f5_arg0)
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
CoD.ArenaLeagueEventTimer.__resetProperties = function(f6_arg0)
	f6_arg0.ArenaEventTimerLarge:completeAnimation()
	f6_arg0.ArenaEventTimerLarge:setAlpha(1)
end
CoD.ArenaLeagueEventTimer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	Unranked = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.ArenaEventTimerLarge:completeAnimation()
			f8_arg0.ArenaEventTimerLarge:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.ArenaEventTimerLarge)
		end,
	},
}
CoD.ArenaLeagueEventTimer.__onClose = function(f9_arg0)
	f9_arg0.VerticalListSpacer:close()
	f9_arg0.ArenaEventTimerLarge:close()
end
