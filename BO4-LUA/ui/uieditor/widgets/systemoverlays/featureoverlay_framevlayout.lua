require("ui/uieditor/widgets/systemoverlays/featureoverlay_framevlayout_buttons")
CoD.featureOverlay_frameVLayout = InheritFrom(LUI.UIElement)
CoD.featureOverlay_frameVLayout.__defaultWidth = 1920
CoD.featureOverlay_frameVLayout.__defaultHeight = 750
CoD.featureOverlay_frameVLayout.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIVerticalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Top)
	self:setClass(CoD.featureOverlay_frameVLayout)
	self.id = "featureOverlay_frameVLayout"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local frame = LUI.UIFrame.new(f1_arg0, f1_arg1, 0, 0, true)
	frame:setLeftRight(0, 1, 0, 0)
	frame:setTopBottom(0, 0, 0, 699)
	frame:linkToElementModel(self, nil, false, function(model)
		frame:setModel(model, f1_arg1)
	end)
	frame:linkToElementModel(self, "frameWidget", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			frame:changeFrameWidget(f3_local0)
		end
	end)
	self:addElement(frame)
	self.frame = frame
	local buttons = CoD.featureOverlay_frameVLayout_Buttons.new(f1_arg0, f1_arg1, 0, 0, 0, 1920, 0, 0, 699, 753)
	self:addElement(buttons)
	self.buttons = buttons
	frame.id = "frame"
	if CoD.isPC then
		buttons.id = "buttons"
	end
	self.__defaultFocus = frame
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.featureOverlay_frameVLayout.__onClose = function(f4_arg0)
	f4_arg0.frame:close()
	f4_arg0.buttons:close()
end
