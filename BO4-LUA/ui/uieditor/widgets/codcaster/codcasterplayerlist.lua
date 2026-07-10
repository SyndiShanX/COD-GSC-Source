require("x64:33e1a0fa33f250e")
require("x64:61746fdfad55210")
require("x64:3cf319e54d85b71")
CoD.CodCasterPlayerList = InheritFrom(LUI.UIElement)
CoD.CodCasterPlayerList.__defaultWidth = 408
CoD.CodCasterPlayerList.__defaultHeight = 726
CoD.CodCasterPlayerList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterPlayerList)
	self.id = "CodCasterPlayerList"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local topimage = CoD.codcaster_playlist_infobg.new(f1_arg0, f1_arg1, 1, 1, -196.5, 3.5, 0, 0, -2, 114)
	topimage:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return IsSelfInState(self, "Visible")
			end,
		},
		{
			stateName = "NonTeamBased",
			condition = function(menu, element, event)
				return IsSelfInState(self, "NonTeamBased")
			end,
		},
	})
	self:addElement(topimage)
	self.topimage = topimage
	local PlayerListInternal = CoD.CodcasterPlayerlistInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 408, 0, 0, 27, 763)
	PlayerListInternal:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return IsSelfInState(self, "Visible")
			end,
		},
	})
	self:addElement(PlayerListInternal)
	self.PlayerListInternal = PlayerListInternal
	local CodcasterNonTeamBasedPlayerListInternal = CoD.CodcasterNonTeamBasedPlayerListInternal.new(f1_arg0, f1_arg1, 0, 0, 0, 408, 0, 0, 32, 452)
	CodcasterNonTeamBasedPlayerListInternal:mergeStateConditions({
		{
			stateName = "NonTeamBased",
			condition = function(menu, element, event)
				return IsSelfInState(self, "NonTeamBased")
			end,
		},
	})
	CodcasterNonTeamBasedPlayerListInternal:setAlpha(0)
	self:addElement(CodcasterNonTeamBasedPlayerListInternal)
	self.CodcasterNonTeamBasedPlayerListInternal = CodcasterNonTeamBasedPlayerListInternal
	PlayerListInternal.id = "PlayerListInternal"
	CodcasterNonTeamBasedPlayerListInternal.id = "CodcasterNonTeamBasedPlayerListInternal"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterPlayerList.__resetProperties = function(f6_arg0)
	f6_arg0.topimage:completeAnimation()
	f6_arg0.PlayerListInternal:completeAnimation()
	f6_arg0.CodcasterNonTeamBasedPlayerListInternal:completeAnimation()
	f6_arg0.topimage:setAlpha(1)
	f6_arg0.PlayerListInternal:setAlpha(1)
	f6_arg0.CodcasterNonTeamBasedPlayerListInternal:setAlpha(0)
end
CoD.CodCasterPlayerList.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(3)
			f7_arg0.topimage:completeAnimation()
			f7_arg0.topimage:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.topimage)
			f7_arg0.PlayerListInternal:completeAnimation()
			f7_arg0.PlayerListInternal:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.PlayerListInternal)
			f7_arg0.CodcasterNonTeamBasedPlayerListInternal:completeAnimation()
			f7_arg0.CodcasterNonTeamBasedPlayerListInternal:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.CodcasterNonTeamBasedPlayerListInternal)
		end,
	},
	Visible = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	NonTeamBased = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.PlayerListInternal:completeAnimation()
			f9_arg0.PlayerListInternal:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.PlayerListInternal)
			f9_arg0.CodcasterNonTeamBasedPlayerListInternal:completeAnimation()
			f9_arg0.CodcasterNonTeamBasedPlayerListInternal:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.CodcasterNonTeamBasedPlayerListInternal)
		end,
	},
}
CoD.CodCasterPlayerList.__onClose = function(f10_arg0)
	f10_arg0.topimage:close()
	f10_arg0.PlayerListInternal:close()
	f10_arg0.CodcasterNonTeamBasedPlayerListInternal:close()
end
