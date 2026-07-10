require("x64:f7a27cd81266e39")
require("x64:9052afdd42d6865")
require("x64:ec03253ae743ad4")
CoD.Hud_SafeAreaContainer_Front = InheritFrom(LUI.UIElement)
CoD.Hud_SafeAreaContainer_Front.__defaultWidth = 1920
CoD.Hud_SafeAreaContainer_Front.__defaultHeight = 1080
CoD.Hud_SafeAreaContainer_Front.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Hud_SafeAreaContainer_Front)
	self.id = "Hud_SafeAreaContainer_Front"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local safeframeplayercard = CoD.safeframe_playercard.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	safeframeplayercard:setAlpha(0.9)
	self:addElement(safeframeplayercard)
	self.safeframeplayercard = safeframeplayercard
	local AbilityCalloutQueue = CoD.AbilityCallout_Queue.new(f1_arg0, f1_arg1, 0, 0, 24, 324, 0, 0, 417.5, 492.5)
	self:addElement(AbilityCalloutQueue)
	self.AbilityCalloutQueue = AbilityCalloutQueue
	local ProneBlocked = CoD.HelpMessageContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 1, 1, -364, -340)
	self:addElement(ProneBlocked)
	self.ProneBlocked = ProneBlocked
	self:mergeStateConditions({
		{
			stateName = "MPSplitscreen",
			condition = function(menu, element, event)
				return IsMultiplayer() and IsSplitscreenAndInGame(f1_arg1)
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[0x8DF2E5447F384B9]()
	f1_local5(f1_local4, f1_local6["lobbyRoot.lobbyNav"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	safeframeplayercard.id = "safeframeplayercard"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Hud_SafeAreaContainer_Front.__onClose = function(f4_arg0)
	f4_arg0.safeframeplayercard:close()
	f4_arg0.AbilityCalloutQueue:close()
	f4_arg0.ProneBlocked:close()
end
