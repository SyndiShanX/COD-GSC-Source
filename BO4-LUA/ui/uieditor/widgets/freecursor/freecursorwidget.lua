require("x64:fd74afd453ac21")
require("x64:bef7e101bf9de8a")
CoD.freeCursorWidget = InheritFrom(LUI.UIElement)
CoD.freeCursorWidget.__defaultWidth = 140
CoD.freeCursorWidget.__defaultHeight = 140
CoD.freeCursorWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.freeCursorWidget)
	self.id = "freeCursorWidget"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local infoPanelContainer = CoD.freeCursorInfoPanelContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, 33, 438, 0.5, 0.5, 32, 995)
	infoPanelContainer:linkToElementModel(self, nil, false, function(model)
		infoPanelContainer:setModel(model, f1_arg1)
	end)
	self:addElement(infoPanelContainer)
	self.infoPanelContainer = infoPanelContainer
	local infoPanelContainerPC = nil
	infoPanelContainerPC = CoD.freeCursorInfoPanelContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, 33, 438, 0.5, 0.5, 32, 995)
	infoPanelContainerPC:setAlpha(0)
	infoPanelContainerPC:linkToElementModel(self, nil, false, function(model)
		infoPanelContainerPC:setModel(model, f1_arg1)
	end)
	self:addElement(infoPanelContainerPC)
	self.infoPanelContainerPC = infoPanelContainerPC
	local freeCursorCursor = CoD.freeCursorCursor.new(f1_arg0, f1_arg1, -0.01, 0.99, 0, 0, 0, 1, 0, 0)
	freeCursorCursor:linkToElementModel(self, nil, false, function(model)
		freeCursorCursor:setModel(model, f1_arg1)
	end)
	self:addElement(freeCursorCursor)
	self.freeCursorCursor = freeCursorCursor
	self:mergeStateConditions({
		{
			stateName = "PCHidden",
			condition = function(menu, element, event)
				return IsPC() and IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f6_arg0, f6_arg1)
		f6_arg1.menu = f6_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f6_arg1)
	end)
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6.LastInput, function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	infoPanelContainer.id = "infoPanelContainer"
	if CoD.isPC then
		infoPanelContainerPC.id = "infoPanelContainerPC"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local5 = self
	if IsMouseOrKeyboard(f1_arg1) then
		CallCustomElementFunction_Self(self, "setupFreeCursor", f1_arg1)
		CoD.FreeCursorUtility.PrepareTooltipPC(self.infoPanelContainerPC, f1_arg1, f1_arg0)
		CoD.FreeCursorUtility.ConfinePositionToScreenSafe(self.infoPanelContainer, f1_arg1)
	else
		CallCustomElementFunction_Self(self, "setupFreeCursor", f1_arg1)
		CoD.FreeCursorUtility.ConfinePositionToScreenSafe(self.infoPanelContainer, f1_arg1)
	end
	return self
end
CoD.freeCursorWidget.__resetProperties = function(f8_arg0)
	f8_arg0.freeCursorCursor:completeAnimation()
	f8_arg0.infoPanelContainer:completeAnimation()
	f8_arg0.infoPanelContainerPC:completeAnimation()
	f8_arg0.freeCursorCursor:setAlpha(1)
	f8_arg0.infoPanelContainer:setAlpha(1)
	f8_arg0.infoPanelContainerPC:setAlpha(0)
end
CoD.freeCursorWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	PCHidden = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(3)
			f10_arg0.infoPanelContainer:completeAnimation()
			f10_arg0.infoPanelContainer:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.infoPanelContainer)
			f10_arg0.infoPanelContainerPC:completeAnimation()
			f10_arg0.infoPanelContainerPC:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.infoPanelContainerPC)
			f10_arg0.freeCursorCursor:completeAnimation()
			f10_arg0.freeCursorCursor:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.freeCursorCursor)
		end,
	},
}
CoD.freeCursorWidget.__onClose = function(f11_arg0)
	f11_arg0.infoPanelContainer:close()
	f11_arg0.infoPanelContainerPC:close()
	f11_arg0.freeCursorCursor:close()
end
