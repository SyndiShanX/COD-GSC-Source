require("x64:a4e58ff04ef52d1")
CoD.LobbyProcessQueueDebugItem = InheritFrom(LUI.UIElement)
CoD.LobbyProcessQueueDebugItem.__defaultWidth = 1119
CoD.LobbyProcessQueueDebugItem.__defaultHeight = 20
CoD.LobbyProcessQueueDebugItem.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LobbyProcessQueueDebugItem)
	self.id = "LobbyProcessQueueDebugItem"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background:setRGB(0, 0, 0)
	Background:setAlpha(0.7)
	self:addElement(Background)
	self.Background = Background
	local LobbyProcessQueueDebugItemText = CoD.LobbyProcessQueueDebugItemText.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 4.7, 0, 0)
	self:addElement(LobbyProcessQueueDebugItemText)
	self.LobbyProcessQueueDebugItemText = LobbyProcessQueueDebugItemText
	self.LobbyProcessQueueDebugItemText:linkToElementModel(self, nil, false, function(model)
		LobbyProcessQueueDebugItemText:setModel(model, f1_arg1)
	end)
	self.LobbyProcessQueueDebugItemText:linkToElementModel(self, "processName", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			LobbyProcessQueueDebugItemText.Name:setText(CoD.BaseUtility.AlreadyLocalized(f3_local0))
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "Process",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "type", "process")
			end,
		},
		{
			stateName = "Action",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "type", "action")
			end,
		},
	})
	self:linkToElementModel(self, "type", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "type",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LobbyProcessQueueDebugItem.__resetProperties = function(f7_arg0)
	f7_arg0.Background:completeAnimation()
	f7_arg0.Background:setRGB(0, 0, 0)
	f7_arg0.Background:setAlpha(0.7)
end
CoD.LobbyProcessQueueDebugItem.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	Process = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.Background:completeAnimation()
			f9_arg0.Background:setRGB(0, 0.04, 0.43)
			f9_arg0.clipFinished(f9_arg0.Background)
		end,
	},
	Action = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.Background:completeAnimation()
			f10_arg0.Background:setAlpha(0.7)
			f10_arg0.clipFinished(f10_arg0.Background)
		end,
	},
}
CoD.LobbyProcessQueueDebugItem.__onClose = function(f11_arg0)
	f11_arg0.LobbyProcessQueueDebugItemText:close()
end
