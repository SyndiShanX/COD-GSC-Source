require("ui/uieditor/widgets/debug/lobbyprocessqueuedebug")
CoD.LobbyDebugOverlay = InheritFrom(LUI.UIElement)
CoD.LobbyDebugOverlay.__defaultWidth = 1920
CoD.LobbyDebugOverlay.__defaultHeight = 1080
CoD.LobbyDebugOverlay.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LobbyDebugOverlay)
	self.id = "LobbyDebugOverlay"
	self.soundSet = "MultiplayerMain"
	self.anyChildUsesUpdateState = true
	local LobbyProcessQueueDebug = CoD.LobbyProcessQueueDebug.new(f1_arg0, f1_arg1, 0, 0, 601, 1374, 0, 0, 186, 1026)
	LobbyProcessQueueDebug.List:setVerticalCount(50)
	self:addElement(LobbyProcessQueueDebug)
	self.LobbyProcessQueueDebug = LobbyProcessQueueDebug
	LobbyProcessQueueDebug.id = "LobbyProcessQueueDebug"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LobbyDebugOverlay.__onClose = function(f2_arg0)
	f2_arg0.LobbyProcessQueueDebug:close()
end
