require("x64:1bd7a98cc365538")
require("x64:28679d45921cbd1")
require("x64:c3166633f638a68")
CoD.StartMenu_ConnectionMeter = InheritFrom(LUI.UIElement)
CoD.StartMenu_ConnectionMeter.__defaultWidth = 745
CoD.StartMenu_ConnectionMeter.__defaultHeight = 115
CoD.StartMenu_ConnectionMeter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_ConnectionMeter)
	self.id = "StartMenu_ConnectionMeter"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local bg1 = LUI.UIImage.new(0, 0, 179.5, 355.5, 0, 0, 2, 113)
	bg1:setRGB(0, 0, 0)
	bg1:setAlpha(0.7)
	self:addElement(bg1)
	self.bg1 = bg1
	local bg0 = LUI.UIImage.new(0, 0, 4.5, 180.5, 0, 0, 2, 113)
	bg0:setRGB(0, 0, 0)
	bg0:setAlpha(0.4)
	self:addElement(bg0)
	self.bg0 = bg0
	local PingLabel = LUI.UIText.new(0, 0, 185, 273, 0, 0, 10.5, 30.5)
	PingLabel:setText(Engine[0xF9F1239CFD921FE](0xC82D7F8B4BBEF0A))
	PingLabel:setTTF("default")
	PingLabel:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	PingLabel:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(PingLabel)
	self.PingLabel = PingLabel
	local bg10 = LUI.UIImage.new(0, 0, 562.5, 738.5, 0, 0, 2, 113)
	bg10:setRGB(0, 0, 0)
	bg10:setAlpha(0.7)
	self:addElement(bg10)
	self.bg10 = bg10
	local bg00 = LUI.UIImage.new(0, 0, 387.5, 563.5, 0, 0, 2, 113)
	bg00:setRGB(0, 0, 0)
	bg00:setAlpha(0.4)
	self:addElement(bg00)
	self.bg00 = bg00
	local TextBox0 = LUI.UIText.new(0, 0, 569.5, 657.5, 0, 0, 10.5, 30.5)
	TextBox0:setText(Engine[0xF9F1239CFD921FE](0x670B328A0A31250))
	TextBox0:setTTF("default")
	TextBox0:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TextBox0:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(TextBox0)
	self.TextBox0 = TextBox0
	local PingTextBox = LUI.UIText.new(0, 0, 288.5, 339.5, 0, 0, 69, 99)
	PingTextBox:setTTF("default")
	PingTextBox:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	PingTextBox:subscribeToGlobalModel(f1_arg1, "NetStatsInfo", "NETSTATS_LATENCY", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PingTextBox:setText(AppendString("ms", f2_local0))
		end
	end)
	self:addElement(PingTextBox)
	self.PingTextBox = PingTextBox
	local PingTextBox0 = LUI.UIText.new(0, 0, 678, 729, 0, 0, 69, 99)
	PingTextBox0:setTTF("default")
	PingTextBox0:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	PingTextBox0:subscribeToGlobalModel(f1_arg1, "NetStatsInfo", "NETSTATS_PACKETLOSS", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			PingTextBox0:setText(AppendString("%", f3_local0))
		end
	end)
	self:addElement(PingTextBox0)
	self.PingTextBox0 = PingTextBox0
	local PingBarGraph = CoD.StartMenu_StenciledConnectionMeter.new(f1_arg0, f1_arg1, 0, 0, 4.5, 179.5, 0, 0, 0.5, 111.5)
	self:addElement(PingBarGraph)
	self.PingBarGraph = PingBarGraph
	local PacketLossGraph = CoD.StartMenu_StenciledConnectionMeter.new(f1_arg0, f1_arg1, 0, 0, 387.5, 562.5, 0, 0, 0.5, 111.5)
	PacketLossGraph.PingBarGraph:setGraphMode(2)
	self:addElement(PacketLossGraph)
	self.PacketLossGraph = PacketLossGraph
	local StartMenuConnectionMeterPingImage = CoD.StartMenu_ConnectionMeter_PingImage.new(f1_arg0, f1_arg1, 0, 0, 296.5, 339.5, 0, 0, 10, 56)
	StartMenuConnectionMeterPingImage:subscribeToGlobalModel(f1_arg1, "NetStatsInfo", nil, function(model)
		StartMenuConnectionMeterPingImage:setModel(model, f1_arg1)
	end)
	self:addElement(StartMenuConnectionMeterPingImage)
	self.StartMenuConnectionMeterPingImage = StartMenuConnectionMeterPingImage
	local StartMenuConnectionMeterPacketLossImage = CoD.StartMenu_ConnectionMeter_PacketLossImage.new(f1_arg0, f1_arg1, 0, 0, 686, 729, 0, 0, 10, 56)
	StartMenuConnectionMeterPacketLossImage:subscribeToGlobalModel(f1_arg1, "NetStatsInfo", nil, function(model)
		StartMenuConnectionMeterPacketLossImage:setModel(model, f1_arg1)
	end)
	self:addElement(StartMenuConnectionMeterPacketLossImage)
	self.StartMenuConnectionMeterPacketLossImage = StartMenuConnectionMeterPacketLossImage
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_ConnectionMeter.__onClose = function(f6_arg0)
	f6_arg0.PingTextBox:close()
	f6_arg0.PingTextBox0:close()
	f6_arg0.PingBarGraph:close()
	f6_arg0.PacketLossGraph:close()
	f6_arg0.StartMenuConnectionMeterPingImage:close()
	f6_arg0.StartMenuConnectionMeterPacketLossImage:close()
end
