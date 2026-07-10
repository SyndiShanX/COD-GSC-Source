require("x64:4fdeea0a60636b2")
require("x64:2cb7dfe8738a015")
CoD.TabletIcePickSecondaryWindow = InheritFrom(LUI.UIElement)
CoD.TabletIcePickSecondaryWindow.__defaultWidth = 308
CoD.TabletIcePickSecondaryWindow.__defaultHeight = 345
CoD.TabletIcePickSecondaryWindow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	SetControllerModelValue(f1_arg1, "IcePickInfo.currentHackFlavorText", "")
	self:setClass(CoD.TabletIcePickSecondaryWindow)
	self.id = "TabletIcePickSecondaryWindow"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local IcePickHackFeedBg = CoD.IcePickHackFeedBg.new(f1_arg0, f1_arg1, 0, 0, 0, 308, 0, 0, 0, 344)
	self:addElement(IcePickHackFeedBg)
	self.IcePickHackFeedBg = IcePickHackFeedBg
	local IcePickHackFeed = CoD.IcePickHackFeed.new(f1_arg0, f1_arg1, 0.5, 0.5, -124, 124, 0.5, 0.5, -164.5, 150.5)
	self:addElement(IcePickHackFeed)
	self.IcePickHackFeed = IcePickHackFeed
	self:linkToElementModel(self, "currentHackFlavorText", true, function(model)
		local f2_local0 = self
		CoD.HUDUtility.IcePickAddItemToFeed(self.IcePickHackFeed, model, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local3 = self
	CoD.HUDUtility.SetupIcePickHackFeed(self, self.IcePickHackFeed, f1_arg0, f1_arg1)
	return self
end
CoD.TabletIcePickSecondaryWindow.__onClose = function(f3_arg0)
	f3_arg0.IcePickHackFeedBg:close()
	f3_arg0.IcePickHackFeed:close()
end
