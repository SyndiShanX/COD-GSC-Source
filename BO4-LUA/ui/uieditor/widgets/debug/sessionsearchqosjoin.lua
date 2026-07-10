CoD.SessionSearchQoSJoin = InheritFrom(LUI.UIElement)
CoD.SessionSearchQoSJoin.__defaultWidth = 762
CoD.SessionSearchQoSJoin.__defaultHeight = 13
CoD.SessionSearchQoSJoin.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SessionSearchQoSJoin)
	self.id = "SessionSearchQoSJoin"
	self.soundSet = "MultiplayerMain"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background:setRGB(0, 0, 0)
	Background:setAlpha(0.35)
	self:addElement(Background)
	self.Background = Background
	local Status = LUI.UIText.new(0, 0, 626, 760, 0, 0, -3, 17)
	Status:setTTF("default")
	Status:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Status:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Status:linkToElementModel(self, "status", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Status:setText(f2_local0)
		end
	end)
	self:addElement(Status)
	self.Status = Status
	local QoSPing = LUI.UIText.new(0, 0, 552, 615, 0, 0, -3, 17)
	QoSPing:setTTF("default")
	QoSPing:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	QoSPing:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	QoSPing:linkToElementModel(self, "qosPing", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			QoSPing:setText(f3_local0)
		end
	end)
	self:addElement(QoSPing)
	self.QoSPing = QoSPing
	local NATType = LUI.UIText.new(0, 0, 492, 547, 0, 0, -3, 17)
	NATType:setTTF("default")
	NATType:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	NATType:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	NATType:linkToElementModel(self, "natType", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			NATType:setText(f4_local0)
		end
	end)
	self:addElement(NATType)
	self.NATType = NATType
	local PrivateIPAddress = LUI.UIText.new(0, 0, 398, 489, 0, 0, -3, 17)
	PrivateIPAddress:setTTF("default")
	PrivateIPAddress:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	PrivateIPAddress:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	PrivateIPAddress:linkToElementModel(self, "privateIPAddress", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			PrivateIPAddress:setText(f5_local0)
		end
	end)
	self:addElement(PrivateIPAddress)
	self.PrivateIPAddress = PrivateIPAddress
	local PublicIPAddress = LUI.UIText.new(0, 0, 267, 398, 0, 0, -3, 17)
	PublicIPAddress:setTTF("default")
	PublicIPAddress:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	PublicIPAddress:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	PublicIPAddress:linkToElementModel(self, "publicIPAddress", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			PublicIPAddress:setText(f6_local0)
		end
	end)
	self:addElement(PublicIPAddress)
	self.PublicIPAddress = PublicIPAddress
	local Gamertag = LUI.UIText.new(0, 0, 112, 256, 0, 0, -3, 17)
	Gamertag:setTTF("notosans_regular")
	Gamertag:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Gamertag:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Gamertag:linkToElementModel(self, "gamertag", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			Gamertag:setText(f7_local0)
		end
	end)
	self:addElement(Gamertag)
	self.Gamertag = Gamertag
	local Xuid = LUI.UIText.new(0, 0, 0, 110, 0, 0, -3, 17)
	Xuid:setTTF("default")
	Xuid:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Xuid:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	Xuid:linkToElementModel(self, "xuid", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			Xuid:setText(f8_local0)
		end
	end)
	self:addElement(Xuid)
	self.Xuid = Xuid
	local NoResults = LUI.UIText.new(0, 1, 0, 0, 0, 0, -2, 13)
	NoResults:setTTF("default")
	NoResults:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	NoResults:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	NoResults:linkToElementModel(self, "noResults", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			NoResults:setText(f9_local0)
		end
	end)
	self:addElement(NoResults)
	self.NoResults = NoResults
	local AsyncMatchmakingString = LUI.UIText.new(0, 1, 0, 0, 0, 0, -2, 13)
	AsyncMatchmakingString:setTTF("default")
	AsyncMatchmakingString:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	AsyncMatchmakingString:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	AsyncMatchmakingString:linkToElementModel(self, "asyncMatchmakingString", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			AsyncMatchmakingString:setText(f10_local0)
		end
	end)
	self:addElement(AsyncMatchmakingString)
	self.AsyncMatchmakingString = AsyncMatchmakingString
	self:mergeStateConditions({
		{
			stateName = "Left",
			condition = function(menu, element, event)
				return IsWidgetInFocus(self, "LeftContainer", event)
			end,
		},
		{
			stateName = "Right",
			condition = function(menu, element, event)
				return IsWidgetInFocus(self, "ClientList", event)
			end,
		},
	})
	self:appendEventHandler("record_curr_focused_elem_id", function(f13_arg0, f13_arg1)
		f13_arg1.menu = f13_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f13_arg1)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SessionSearchQoSJoin.__onClose = function(f14_arg0)
	f14_arg0.Status:close()
	f14_arg0.QoSPing:close()
	f14_arg0.NATType:close()
	f14_arg0.PrivateIPAddress:close()
	f14_arg0.PublicIPAddress:close()
	f14_arg0.Gamertag:close()
	f14_arg0.Xuid:close()
	f14_arg0.NoResults:close()
	f14_arg0.AsyncMatchmakingString:close()
end
