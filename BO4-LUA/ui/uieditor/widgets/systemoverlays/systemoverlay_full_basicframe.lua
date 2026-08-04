require("ui/uieditor/widgets/systemoverlays/systemoverlay_layout_genericforeground_full")
require("ui/uieditor/widgets/systemoverlays/systemoverlay_supportwidget")
CoD.systemOverlay_Full_BasicFrame = InheritFrom(LUI.UIElement)
CoD.systemOverlay_Full_BasicFrame.__defaultWidth = 1920
CoD.systemOverlay_Full_BasicFrame.__defaultHeight = 480
CoD.systemOverlay_Full_BasicFrame.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.systemOverlay_Full_BasicFrame)
	self.id = "systemOverlay_Full_BasicFrame"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local largeImage = LUI.UIImage.new(0, 0, 0, 528, 0, 1, 0, 0)
	largeImage:setAlpha(0)
	largeImage:linkToElementModel(self, "image", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			largeImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(largeImage)
	self.largeImage = largeImage
	local foreground = CoD.systemOverlay_Layout_GenericForeground_Full.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	foreground:linkToElementModel(self, nil, false, function(model)
		foreground:setModel(model, f1_arg1)
	end)
	self:addElement(foreground)
	self.foreground = foreground
	local supportInfo = CoD.systemOverlay_supportWidget.new(f1_arg0, f1_arg1, 0, 0, 0, 528, 1, 1, -36, 0)
	supportInfo:linkToElementModel(self, nil, false, function(model)
		supportInfo:setModel(model, f1_arg1)
	end)
	self:addElement(supportInfo)
	self.supportInfo = supportInfo
	foreground.id = "foreground"
	self.__defaultFocus = foreground
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.systemOverlay_Full_BasicFrame.__onClose = function(f5_arg0)
	f5_arg0.largeImage:close()
	f5_arg0.foreground:close()
	f5_arg0.supportInfo:close()
end
