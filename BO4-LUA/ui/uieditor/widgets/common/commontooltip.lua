require("x64:213634351838d49")
CoD.CommonToolTip = InheritFrom(LUI.UIElement)
CoD.CommonToolTip.__defaultWidth = 292
CoD.CommonToolTip.__defaultHeight = 45
CoD.CommonToolTip.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CommonToolTip)
	self.id = "CommonToolTip"
	self.soundSet = "FrontendMain"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local textCenterAlign = LUI.UIText.new(0, 1, 0, 0, 0.5, 0.5, -8, 8)
	textCenterAlign:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	textCenterAlign:setText("")
	textCenterAlign:setTTF("dinnext_regular")
	textCenterAlign:setLineSpacing(2)
	textCenterAlign:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	textCenterAlign:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	textCenterAlign:setBackingType(1)
	textCenterAlign:setBackingWidget(CoD.CommonToolTipBacking, f1_arg0, f1_arg1)
	textCenterAlign:setBackingXPadding(20)
	textCenterAlign:setBackingYPadding(7)
	self:addElement(textCenterAlign)
	self.textCenterAlign = textCenterAlign
	self:mergeStateConditions({
		{
			stateName = "Mouse",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "NoHintText",
			condition = function(menu, element, event)
				return not HasHintText(element)
			end,
		},
		{
			stateName = "CenterAlign",
			condition = function(menu, element, event)
				return true
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
	self:linkToElementModel(self, nil, true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = nil,
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CommonToolTip.__resetProperties = function(f8_arg0)
	f8_arg0.textCenterAlign:completeAnimation()
	f8_arg0.textCenterAlign:setAlpha(1)
end
CoD.CommonToolTip.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	Mouse = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.textCenterAlign:completeAnimation()
			f10_arg0.textCenterAlign:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.textCenterAlign)
		end,
	},
	NoHintText = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.textCenterAlign:completeAnimation()
			f11_arg0.textCenterAlign:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.textCenterAlign)
		end,
	},
	CenterAlign = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(0)
		end,
	},
}
