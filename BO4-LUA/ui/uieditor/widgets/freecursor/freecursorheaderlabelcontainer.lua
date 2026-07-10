require("x64:ace9434f0901742")
require("x64:d643b71542c63bf")
CoD.freeCursorHeaderLabelContainer = InheritFrom(LUI.UIElement)
CoD.freeCursorHeaderLabelContainer.__defaultWidth = 405
CoD.freeCursorHeaderLabelContainer.__defaultHeight = 36
CoD.freeCursorHeaderLabelContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.freeCursorHeaderLabelContainer)
	self.id = "freeCursorHeaderLabelContainer"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local titlePC = nil
	titlePC = CoD.freeCursorHeaderLabelPC.new(f1_arg0, f1_arg1, 0, 0, 0, 405, 0, 0, 0, 36)
	titlePC:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.FreeCursorUtility.IsTooltipTitleVisible(element, f1_arg1) and not CoD.FreeCursorUtility.IsTooltipInDetailedView(self, f1_arg1)
			end,
		},
		{
			stateName = "VisibleDetailed",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	titlePC:linkToElementModel(titlePC, "title", true, function(model)
		f1_arg0:updateElementState(titlePC, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "title",
		})
	end)
	local f1_local2 = titlePC
	local title = titlePC.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	title(f1_local2, f1_local4["ButtonBits." .. Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA]], function(f5_arg0)
		f1_arg0:updateElementState(titlePC, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "ButtonBits." .. Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA],
		})
	end, false)
	titlePC:linkToElementModel(titlePC, "detailedViewPC", true, function(model)
		f1_arg0:updateElementState(titlePC, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "detailedViewPC",
		})
	end)
	titlePC:linkToElementModel(titlePC, "detailedDescription", true, function(model)
		f1_arg0:updateElementState(titlePC, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "detailedDescription",
		})
	end)
	titlePC:linkToElementModel(self, nil, false, function(model)
		titlePC:setModel(model, f1_arg1)
	end)
	self:addElement(titlePC)
	self.titlePC = titlePC
	title = CoD.freeCursorHeaderLabel.new(f1_arg0, f1_arg1, 0, 0, 0, 405, 0, 0, 0, 36)
	title:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.FreeCursorUtility.IsTooltipTitleVisible(element, f1_arg1) and not CoD.FreeCursorUtility.IsTooltipInDetailedView(self, f1_arg1)
			end,
		},
		{
			stateName = "VisibleDetailed",
			condition = function(menu, element, event)
				return CoD.FreeCursorUtility.IsTooltipTitleVisible(element, f1_arg1)
			end,
		},
	})
	title:linkToElementModel(title, "title", true, function(model)
		f1_arg0:updateElementState(title, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "title",
		})
	end)
	f1_local4 = title
	f1_local2 = title.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local2(f1_local4, f1_local5["ButtonBits." .. Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA]], function(f12_arg0)
		f1_arg0:updateElementState(title, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "ButtonBits." .. Enum[0x3DD78803F918E9D][0x820DDD869ABBFAA],
		})
	end, false)
	title:linkToElementModel(title, "detailedViewPC", true, function(model)
		f1_arg0:updateElementState(title, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "detailedViewPC",
		})
	end)
	title:linkToElementModel(title, "detailedDescription", true, function(model)
		f1_arg0:updateElementState(title, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "detailedDescription",
		})
	end)
	title:linkToElementModel(self, nil, false, function(model)
		title:setModel(model, f1_arg1)
	end)
	self:addElement(title)
	self.title = title
	self:mergeStateConditions({
		{
			stateName = "DefaultStateKBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f17_arg0, f17_arg1)
		f17_arg1.menu = f17_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f17_arg1)
	end)
	f1_local4 = self
	f1_local2 = self.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local2(f1_local4, f1_local5.LastInput, function(f18_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f18_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.freeCursorHeaderLabelContainer.__resetProperties = function(f19_arg0)
	f19_arg0.title:completeAnimation()
	f19_arg0.titlePC:completeAnimation()
	f19_arg0.title:setAlpha(1)
	f19_arg0.titlePC:setAlpha(1)
end
CoD.freeCursorHeaderLabelContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(2)
			f20_arg0.titlePC:completeAnimation()
			f20_arg0.titlePC:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.titlePC)
			f20_arg0.title:completeAnimation()
			f20_arg0.title:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.title)
		end,
	},
	DefaultStateKBM = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(2)
			f21_arg0.titlePC:completeAnimation()
			f21_arg0.titlePC:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.titlePC)
			f21_arg0.title:completeAnimation()
			f21_arg0.title:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.title)
		end,
	},
}
CoD.freeCursorHeaderLabelContainer.__onClose = function(f22_arg0)
	f22_arg0.titlePC:close()
	f22_arg0.title:close()
end
