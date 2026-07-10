require("x64:ea4a19da0cecd3a")
CoD.LiveEventViewerFooterContainer = InheritFrom(LUI.UIElement)
CoD.LiveEventViewerFooterContainer.__defaultWidth = 1920
CoD.LiveEventViewerFooterContainer.__defaultHeight = 1080
CoD.LiveEventViewerFooterContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LiveEventViewerFooterContainer)
	self.id = "LiveEventViewerFooterContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	local LiveEventViewerFooter0 = CoD.LiveEventViewerFooter.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 1, 1, -98, 0)
	LiveEventViewerFooter0:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		SizeToSafeArea(element, f1_arg1)
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	self:addElement(LiveEventViewerFooter0)
	self.LiveEventViewerFooter0 = LiveEventViewerFooter0
	LiveEventViewerFooter0:appendEventHandler("menu_loaded", function()
		LiveEventViewerFooter0:setModel(f1_arg0.buttonModel, f1_arg1)
	end)
	if CoD.isPC then
		LiveEventViewerFooter0.id = "LiveEventViewerFooter0"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LiveEventViewerFooterContainer.__onClose = function(f4_arg0)
	f4_arg0.LiveEventViewerFooter0:close()
end
