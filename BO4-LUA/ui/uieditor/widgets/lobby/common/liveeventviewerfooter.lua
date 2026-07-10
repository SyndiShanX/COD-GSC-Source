require("x64:d7ba7c36104672")
require("x64:f32d325330c30cd")
require("x64:fd51e83e2e6dbd1")
CoD.LiveEventViewerFooter = InheritFrom(LUI.UIElement)
CoD.LiveEventViewerFooter.__defaultWidth = 1920
CoD.LiveEventViewerFooter.__defaultHeight = 97
CoD.LiveEventViewerFooter.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LiveEventViewerFooter)
	self.id = "LiveEventViewerFooter"
	self.soundSet = "default"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	local blackleftBG = LUI.UIImage.new(0, 1, -185, 197, 1, 1, -60, 224)
	blackleftBG:setRGB(0, 0, 0)
	blackleftBG:setAlpha(0.6)
	self:addElement(blackleftBG)
	self.blackleftBG = blackleftBG
	local LineLeft = LUI.UIImage.new(0, 1, -185, 197, 1, 1, -63, -57)
	LineLeft:setAlpha(0.55)
	LineLeft:setImage(RegisterImage(@"uie_t7_menu_frontend_featuredframeum"))
	LineLeft:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(LineLeft)
	self.LineLeft = LineLeft
	local feLeftContainer = CoD.fe_LeftContainer_NOTLobby.new(f1_arg0, f1_arg1, 0, 0, 23, 825, 1, 1, -72, -6)
	feLeftContainer:linkToElementModel(self, nil, false, function(model)
		feLeftContainer:setModel(model, f1_arg1)
	end)
	self:addElement(feLeftContainer)
	self.feLeftContainer = feLeftContainer
	local twitchIcon = CoD.onOffImage.new(f1_arg0, f1_arg1, 1, 1, -54, -16, 1, 1, -48, -10)
	twitchIcon:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				return not CoD.VideoStreamingUtility.IsMLGStream(f1_arg1)
			end,
		},
	})
	local f1_local5 = twitchIcon
	local LiveEventViewerStreamerCount0 = twitchIcon.subscribeToModel
	local f1_local7 = Engine[@"getglobalmodel"]()
	LiveEventViewerStreamerCount0(f1_local5, f1_local7["liveEventViewer.stream"], function(f4_arg0)
		f1_arg0:updateElementState(twitchIcon, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "liveEventViewer.stream",
		})
	end, false)
	twitchIcon.image:setImage(RegisterImage(@"uie_twitch_icon_white"))
	self:addElement(twitchIcon)
	self.twitchIcon = twitchIcon
	LiveEventViewerStreamerCount0 = CoD.LiveEventViewerStreamerCount.new(f1_arg0, f1_arg1, 1, 1, -285, -49, 1, 1, -49, -11)
	self:addElement(LiveEventViewerStreamerCount0)
	self.LiveEventViewerStreamerCount0 = LiveEventViewerStreamerCount0
	if CoD.isPC then
		feLeftContainer.id = "feLeftContainer"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LiveEventViewerFooter.__onClose = function(f5_arg0)
	f5_arg0.feLeftContainer:close()
	f5_arg0.twitchIcon:close()
	f5_arg0.LiveEventViewerStreamerCount0:close()
end
