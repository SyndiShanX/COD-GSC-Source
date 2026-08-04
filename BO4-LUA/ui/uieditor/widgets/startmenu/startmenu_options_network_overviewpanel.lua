require("ui/uieditor/widgets/startmenu/startmenu_options_network_pinglistitem")
CoD.StartMenu_Options_Network_OverviewPanel = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_Network_OverviewPanel.__defaultWidth = 880
CoD.StartMenu_Options_Network_OverviewPanel.__defaultHeight = 775
CoD.StartMenu_Options_Network_OverviewPanel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_Network_OverviewPanel)
	self.id = "StartMenu_Options_Network_OverviewPanel"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local VersionLabel = LUI.UIText.new(0.5, 0.5, -440, 265, 0, 0, 463, 493)
	VersionLabel:setRGB(0.63, 0.57, 0.2)
	VersionLabel:setText(LocalizeToUpperString("menu/options_network_version"))
	VersionLabel:setTTF("ttmussels_regular")
	VersionLabel:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	self:addElement(VersionLabel)
	self.VersionLabel = VersionLabel
	local VersionValueLabel = LUI.UIText.new(0.5, 0.5, -440, 265, 0, 0, 512.5, 533.5)
	VersionValueLabel:setRGB(0.92, 0.92, 0.92)
	VersionValueLabel:setTTF("dinnext_regular")
	VersionValueLabel:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	VersionValueLabel:subscribeToGlobalModel(f1_arg1, "NetworkInfo", "version", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			VersionValueLabel:setText(CoD.BaseUtility.AlreadyLocalized(f2_local0))
		end
	end)
	self:addElement(VersionValueLabel)
	self.VersionValueLabel = VersionValueLabel
	local AboutPingBarsDesc = LUI.UIText.new(0.5, 0.5, -440, 265, 0, 0, 162.5, 183.5)
	AboutPingBarsDesc:setRGB(0.92, 0.92, 0.92)
	AboutPingBarsDesc:setText(Engine[@"hash_4F9F1239CFD921FE"]("menu/options_network_about_ping_bars_des"))
	AboutPingBarsDesc:setTTF("dinnext_regular")
	AboutPingBarsDesc:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	AboutPingBarsDesc:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(AboutPingBarsDesc)
	self.AboutPingBarsDesc = AboutPingBarsDesc
	local AboutPingBarsLabel = LUI.UIText.new(0.5, 0.5, -440, 265, 0, 0, 113, 143)
	AboutPingBarsLabel:setRGB(0.63, 0.57, 0.2)
	AboutPingBarsLabel:setText(LocalizeToUpperString("menu/options_network_about_ping_bars"))
	AboutPingBarsLabel:setTTF("ttmussels_regular")
	AboutPingBarsLabel:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	self:addElement(AboutPingBarsLabel)
	self.AboutPingBarsLabel = AboutPingBarsLabel
	local SupportLinkLabel = LUI.UIText.new(0.5, 0.5, -440, 265, 0, 0, 52.5, 73.5)
	SupportLinkLabel:setRGB(0.92, 0.92, 0.92)
	SupportLinkLabel:setText(Engine[@"hash_4F9F1239CFD921FE"]("menu/options_network_customer_service_link"))
	SupportLinkLabel:setTTF("dinnext_regular")
	SupportLinkLabel:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	self:addElement(SupportLinkLabel)
	self.SupportLinkLabel = SupportLinkLabel
	local SupportLabel = LUI.UIText.new(0.5, 0.5, -440, 265, 0, 0, 0, 30)
	SupportLabel:setRGB(0.63, 0.57, 0.2)
	SupportLabel:setText(LocalizeToUpperString("menu/options_network_support_link"))
	SupportLabel:setTTF("ttmussels_regular")
	SupportLabel:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	self:addElement(SupportLabel)
	self.SupportLabel = SupportLabel
	local ConnectivityLabel = LUI.UIText.new(0.5, 0.5, -440, 265, 0, 0, 542.5, 563.5)
	ConnectivityLabel:setRGB(0.92, 0.92, 0.92)
	ConnectivityLabel:setTTF("dinnext_regular")
	ConnectivityLabel:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	ConnectivityLabel:subscribeToGlobalModel(f1_arg1, "NetworkInfo", "connectivityInfo", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ConnectivityLabel:setText(CoD.BaseUtility.AlreadyLocalized(f3_local0))
		end
	end)
	self:addElement(ConnectivityLabel)
	self.ConnectivityLabel = ConnectivityLabel
	local pingList = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, 15, 0, nil, nil, false, false, false, false)
	pingList:setLeftRight(0.5, 0.5, -427.5, 262.5)
	pingList:setTopBottom(0, 0, 240, 366)
	pingList:setWidgetType(CoD.StartMenu_Options_Network_PingListItem)
	pingList:setHorizontalCount(5)
	pingList:setSpacing(15)
	pingList:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	pingList:setDataSource("AboutPingBars")
	self:addElement(pingList)
	self.pingList = pingList
	self:mergeStateConditions({
		{
			stateName = "DefaultStatePC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
		{
			stateName = "HideSupportLink",
			condition = function(menu, element, event)
				return CoD.DirectorUtility.DisableForCurrentMilestone(f1_arg1)
			end,
		},
	})
	pingList.id = "pingList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_Network_OverviewPanel.__resetProperties = function(f6_arg0)
	f6_arg0.pingList:completeAnimation()
	f6_arg0.AboutPingBarsDesc:completeAnimation()
	f6_arg0.AboutPingBarsLabel:completeAnimation()
	f6_arg0.VersionLabel:completeAnimation()
	f6_arg0.VersionValueLabel:completeAnimation()
	f6_arg0.ConnectivityLabel:completeAnimation()
	f6_arg0.SupportLabel:completeAnimation()
	f6_arg0.SupportLinkLabel:completeAnimation()
	f6_arg0.pingList:setAlpha(1)
	f6_arg0.AboutPingBarsDesc:setAlpha(1)
	f6_arg0.AboutPingBarsLabel:setAlpha(1)
	f6_arg0.VersionLabel:setTopBottom(0, 0, 463, 493)
	f6_arg0.VersionValueLabel:setTopBottom(0, 0, 512.5, 533.5)
	f6_arg0.ConnectivityLabel:setTopBottom(0, 0, 542.5, 563.5)
	f6_arg0.SupportLabel:setAlpha(1)
	f6_arg0.SupportLinkLabel:setAlpha(1)
end
CoD.StartMenu_Options_Network_OverviewPanel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	DefaultStatePC = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(6)
			f8_arg0.VersionLabel:completeAnimation()
			f8_arg0.VersionLabel:setTopBottom(0, 0, 175, 205)
			f8_arg0.clipFinished(f8_arg0.VersionLabel)
			f8_arg0.VersionValueLabel:completeAnimation()
			f8_arg0.VersionValueLabel:setTopBottom(0, 0, 221.5, 242.5)
			f8_arg0.clipFinished(f8_arg0.VersionValueLabel)
			f8_arg0.AboutPingBarsDesc:completeAnimation()
			f8_arg0.AboutPingBarsDesc:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.AboutPingBarsDesc)
			f8_arg0.AboutPingBarsLabel:completeAnimation()
			f8_arg0.AboutPingBarsLabel:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.AboutPingBarsLabel)
			f8_arg0.ConnectivityLabel:completeAnimation()
			f8_arg0.ConnectivityLabel:setTopBottom(0, 0, 271.5, 292.5)
			f8_arg0.clipFinished(f8_arg0.ConnectivityLabel)
			f8_arg0.pingList:completeAnimation()
			f8_arg0.pingList:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.pingList)
		end,
	},
	HideSupportLink = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(2)
			f9_arg0.SupportLinkLabel:completeAnimation()
			f9_arg0.SupportLinkLabel:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.SupportLinkLabel)
			f9_arg0.SupportLabel:completeAnimation()
			f9_arg0.SupportLabel:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.SupportLabel)
		end,
	},
}
CoD.StartMenu_Options_Network_OverviewPanel.__onClose = function(f10_arg0)
	f10_arg0.VersionValueLabel:close()
	f10_arg0.ConnectivityLabel:close()
	f10_arg0.pingList:close()
end
