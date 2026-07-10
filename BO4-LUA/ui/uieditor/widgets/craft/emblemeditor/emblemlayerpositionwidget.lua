CoD.EmblemLayerPositionWidget = InheritFrom(LUI.UIElement)
CoD.EmblemLayerPositionWidget.__defaultWidth = 173
CoD.EmblemLayerPositionWidget.__defaultHeight = 90
CoD.EmblemLayerPositionWidget.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.EmblemLayerPositionWidget)
	self.id = "EmblemLayerPositionWidget"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local TopBottomText = LUI.UIText.new(0, 0, 0, 173, 0, 0, -2, 22)
	TopBottomText:setTTF("dinnext_regular")
	TopBottomText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	TopBottomText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(TopBottomText)
	self.TopBottomText = TopBottomText
	self.TopBottomText:linkToElementModel(self, "topBottomText", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TopBottomText:setText(f2_local0)
		end
	end)
	self:mergeStateConditions({
		{
			stateName = "LowerText",
			condition = function(menu, element, event)
				return not IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "KBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f5_arg0, f5_arg1)
		f5_arg1.menu = f5_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f5_arg1)
	end)
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
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
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.EmblemLayerPositionWidget.__resetProperties = function(f7_arg0)
	f7_arg0.TopBottomText:completeAnimation()
	f7_arg0.TopBottomText:setTopBottom(0, 0, -2, 22)
	f7_arg0.TopBottomText:setRGB(1, 1, 1)
	f7_arg0.TopBottomText:setAlpha(1)
	f7_arg0.TopBottomText:setLetterSpacing(0)
	f7_arg0.TopBottomText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
end
CoD.EmblemLayerPositionWidget.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
	LowerText = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.TopBottomText:completeAnimation()
			f9_arg0.TopBottomText:setTopBottom(0, 0, 56, 80)
			f9_arg0.clipFinished(f9_arg0.TopBottomText)
		end,
	},
	KBM = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.TopBottomText:completeAnimation()
			f10_arg0.TopBottomText:setTopBottom(0, 0, 2, 15)
			f10_arg0.TopBottomText:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f10_arg0.TopBottomText:setAlpha(1)
			f10_arg0.TopBottomText:setLetterSpacing(2)
			f10_arg0.TopBottomText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
			f10_arg0.clipFinished(f10_arg0.TopBottomText)
		end,
	},
}
CoD.EmblemLayerPositionWidget.__onClose = function(f11_arg0)
	f11_arg0.TopBottomText:close()
end
