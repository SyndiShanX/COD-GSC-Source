require("x64:b2a99bc6e64af75")
CoD.VoDViewerFooterContainer = InheritFrom(LUI.UIElement)
CoD.VoDViewerFooterContainer.__defaultWidth = 1920
CoD.VoDViewerFooterContainer.__defaultHeight = 1080
CoD.VoDViewerFooterContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.VoDViewerFooterContainer)
	self.id = "VoDViewerFooterContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LiveEventViewerFooter0 = CoD.VoDViewerFooter.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 1, 1, -98, 0)
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
	self:mergeStateConditions({
		{
			stateName = "KeyboardMouse",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f4_arg1)
	end)
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4.LastInput, function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
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
CoD.VoDViewerFooterContainer.__resetProperties = function(f7_arg0)
	f7_arg0.LiveEventViewerFooter0:completeAnimation()
	f7_arg0.LiveEventViewerFooter0:setAlpha(1)
end
CoD.VoDViewerFooterContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	KeyboardMouse = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.LiveEventViewerFooter0:completeAnimation()
			f9_arg0.LiveEventViewerFooter0:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.LiveEventViewerFooter0)
		end,
	},
}
CoD.VoDViewerFooterContainer.__onClose = function(f10_arg0)
	f10_arg0.LiveEventViewerFooter0:close()
end
