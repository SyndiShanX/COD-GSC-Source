require("x64:e5f9309bc7d99ca")
CoD.WZTeamScoreboard = InheritFrom(LUI.UIElement)
CoD.WZTeamScoreboard.__defaultWidth = 1920
CoD.WZTeamScoreboard.__defaultHeight = 750
CoD.WZTeamScoreboard.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZTeamScoreboard)
	self.id = "WZTeamScoreboard"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local WZTeamScoreboard = LUI.UIList.new(f1_arg0, f1_arg1, 10, 0, nil, false, false, false, false)
	WZTeamScoreboard:setLeftRight(0.5, 0.5, -481, 481)
	WZTeamScoreboard:setTopBottom(0, 0, 53, 393)
	WZTeamScoreboard:setWidgetType(CoD.WZTeamScoreboard_Row)
	WZTeamScoreboard:setVerticalCount(5)
	WZTeamScoreboard:setSpacing(10)
	WZTeamScoreboard:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	WZTeamScoreboard:setDataSource("WZTeamScoreboard")
	WZTeamScoreboard:linkToElementModel(WZTeamScoreboard, "clientNum", true, function(model, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end)
	local Column1Header = WZTeamScoreboard
	local PlayerColumnHeader = WZTeamScoreboard.subscribeToModel
	local Column2Header = Engine[0x4DF5CFBC1771947](f1_arg1)
	PlayerColumnHeader(Column1Header, Column2Header["deadSpectator.playerIndex"], function(f3_arg0, f3_arg1)
		CoD.Menu.UpdateButtonShownState(f3_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	Column1Header = WZTeamScoreboard
	PlayerColumnHeader = WZTeamScoreboard.subscribeToModel
	Column2Header = Engine[0x4DF5CFBC1771947](f1_arg1)
	PlayerColumnHeader(Column1Header, Column2Header["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]], function(f4_arg0, f4_arg1)
		CoD.Menu.UpdateButtonShownState(f4_arg1, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
	end, false)
	WZTeamScoreboard:registerEventHandler("gain_focus", function(element, event)
		local f5_local0 = nil
		if element.gainFocus then
			f5_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f5_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f5_local0
	end)
	f1_arg0:AddButtonCallbackFunction(WZTeamScoreboard, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if not IsScoreboardPlayerSelf(element, controller) and IsScoreboardPlayerMuted(controller, element) then
			CoD.ScoreboardUtility.ToggleClientMute(element, controller)
			UpdateButtonPromptState(menu, element, controller, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
			return true
		elseif not IsScoreboardPlayerSelf(element, controller) then
			CoD.ScoreboardUtility.ToggleClientMute(element, controller)
			UpdateButtonPromptState(menu, element, controller, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsScoreboardPlayerSelf(element, controller) and IsScoreboardPlayerMuted(controller, element) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x39685D9366015DB, nil, nil)
			return true
		elseif not IsScoreboardPlayerSelf(element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x12FAB6BE7D9F2EA, nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(WZTeamScoreboard)
	self.WZTeamScoreboard = WZTeamScoreboard
	PlayerColumnHeader = LUI.UIText.new(0, 0, 547, 987, 0, 0, 30, 48)
	PlayerColumnHeader:setRGB(0.92, 0.92, 0.92)
	PlayerColumnHeader:setText(Engine[0xF9F1239CFD921FE](0x1995691035EAE4E))
	PlayerColumnHeader:setTTF("0arame_mono_stencil")
	PlayerColumnHeader:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	PlayerColumnHeader:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(PlayerColumnHeader)
	self.PlayerColumnHeader = PlayerColumnHeader
	Column1Header = LUI.UIText.new(0, 0, 1012.5, 1152.5, 0, 0, 30, 48)
	Column1Header:setRGB(0.92, 0.92, 0.92)
	Column1Header:setText(GetScoreboardColumnHeader(f1_arg1, 0, 0x0))
	Column1Header:setTTF("0arame_mono_stencil")
	Column1Header:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Column1Header:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(Column1Header)
	self.Column1Header = Column1Header
	Column2Header = LUI.UIText.new(0, 0, 1155, 1295, 0, 0, 30, 48)
	Column2Header:setRGB(0.92, 0.92, 0.92)
	Column2Header:setText(GetScoreboardColumnHeader(f1_arg1, 1, 0x0))
	Column2Header:setTTF("0arame_mono_stencil")
	Column2Header:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Column2Header:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(Column2Header)
	self.Column2Header = Column2Header
	local Column3Header = LUI.UIText.new(0, 0, 1298, 1438, 0, 0, 30, 48)
	Column3Header:setRGB(0.92, 0.92, 0.92)
	Column3Header:setText(GetScoreboardColumnHeader(f1_arg1, 2, 0x0))
	Column3Header:setTTF("0arame_mono_stencil")
	Column3Header:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Column3Header:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(Column3Header)
	self.Column3Header = Column3Header
	local ColumnExtraHeader = LUI.UIText.new(0, 0, 1441, 1581, 0, 0, 30, 48)
	ColumnExtraHeader:setRGB(0.92, 0.92, 0.92)
	ColumnExtraHeader:setAlpha(0)
	ColumnExtraHeader:setText(GetScoreboardColumnHeader(f1_arg1, 9, 0x0))
	ColumnExtraHeader:setTTF("0arame_mono_stencil")
	ColumnExtraHeader:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	ColumnExtraHeader:setAlignment(Enum[0x7A5123B654282D2][0x70510683C22104B])
	self:addElement(ColumnExtraHeader)
	self.ColumnExtraHeader = ColumnExtraHeader
	self:mergeStateConditions({
		{
			stateName = "Deposit",
			condition = function(menu, element, event)
				return CoD.HUDUtility.IsGameTypeEqualToString("warzone_deposit")
			end,
		},
	})
	WZTeamScoreboard.id = "WZTeamScoreboard"
	self.__defaultFocus = WZTeamScoreboard
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZTeamScoreboard.__resetProperties = function(f9_arg0)
	f9_arg0.Column2Header:completeAnimation()
	f9_arg0.Column3Header:completeAnimation()
	f9_arg0.ColumnExtraHeader:completeAnimation()
	f9_arg0.Column2Header:setLeftRight(0, 0, 1155, 1295)
	f9_arg0.Column3Header:setLeftRight(0, 0, 1298, 1438)
	f9_arg0.ColumnExtraHeader:setLeftRight(0, 0, 1441, 1581)
	f9_arg0.ColumnExtraHeader:setAlpha(0)
end
CoD.WZTeamScoreboard.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
	Deposit = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			f11_arg0.Column2Header:completeAnimation()
			f11_arg0.Column2Header:setLeftRight(0, 0, 1298, 1438)
			f11_arg0.clipFinished(f11_arg0.Column2Header)
			f11_arg0.Column3Header:completeAnimation()
			f11_arg0.Column3Header:setLeftRight(0, 0, 1441, 1581)
			f11_arg0.clipFinished(f11_arg0.Column3Header)
			local f11_local0 = function(f12_arg0)
				f11_arg0.ColumnExtraHeader:beginAnimation(100)
				f11_arg0.ColumnExtraHeader:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.ColumnExtraHeader:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.ColumnExtraHeader:completeAnimation()
			f11_arg0.ColumnExtraHeader:setLeftRight(0, 0, 1155, 1295)
			f11_arg0.ColumnExtraHeader:setAlpha(1)
			f11_local0(f11_arg0.ColumnExtraHeader)
		end,
	},
}
CoD.WZTeamScoreboard.__onClose = function(f13_arg0)
	f13_arg0.WZTeamScoreboard:close()
end
