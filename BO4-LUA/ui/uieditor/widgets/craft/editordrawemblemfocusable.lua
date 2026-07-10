CoD.EditorDrawEmblemFocusable = InheritFrom(LUI.UIElement)
CoD.EditorDrawEmblemFocusable.__defaultWidth = 1920
CoD.EditorDrawEmblemFocusable.__defaultHeight = 1080
CoD.EditorDrawEmblemFocusable.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EditorDrawEmblemFocusable)
	self.id = "EditorDrawEmblemFocusable"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local emblemDrawingArea = nil
	emblemDrawingArea = LUI.UIElement.new(0, 1, 0, 0, 0, 1, 0, 0)
	emblemDrawingArea:subscribeToGlobalModel(f1_arg1, "Customization", "type", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			emblemDrawingArea:setupEmblem(f2_local0)
		end
	end)
	emblemDrawingArea:registerEventHandler("input_source_changed", function(element, event)
		local f3_local0 = nil
		if IsPC() and IsMouseOrKeyboard(f1_arg1) then
			SetUsingFocusInterraction(element, true)
			UpdateState(self, event)
		elseif IsPC() and IsGamepad(f1_arg1) then
			SetUsingFocusInterraction(element, false)
			UpdateState(self, event)
		end
		if not f3_local0 then
			f3_local0 = element:dispatchEventToChildren(event)
		end
		return f3_local0
	end)
	self:addElement(emblemDrawingArea)
	self.emblemDrawingArea = emblemDrawingArea
	self:mergeStateConditions({
		{
			stateName = "PCGamePad",
			condition = function(menu, element, event)
				return IsPC() and IsGamepad(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f5_arg1)
	end)
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4.LastInput, function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local3 = self
	f1_local3 = emblemDrawingArea
	if IsPC() and IsMouseOrKeyboard(f1_arg1) then
		SetUsingFocusInterraction(f1_local3, true)
	elseif IsPC() and IsGamepad(f1_arg1) then
		SetUsingFocusInterraction(f1_local3, false)
	end
	return self
end
CoD.EditorDrawEmblemFocusable.__resetProperties = function(f7_arg0)
	f7_arg0.emblemDrawingArea:completeAnimation()
	f7_arg0.emblemDrawingArea:setAlpha(1)
end
CoD.EditorDrawEmblemFocusable.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.emblemDrawingArea:completeAnimation()
			f9_arg0.emblemDrawingArea:setAlpha(1)
			f9_arg0.clipFinished(f9_arg0.emblemDrawingArea)
		end,
	},
	PCGamePad = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
}
if not CoD.isPC then
	CoD.EditorDrawEmblemFocusable.__clipsPerState.DefaultState.Focus = nil
end
CoD.EditorDrawEmblemFocusable.__onClose = function(f11_arg0)
	f11_arg0.emblemDrawingArea:close()
end
