require("x64:e201e7e41431aa7")
CoD.TabletLocationSelector_HintText = InheritFrom(LUI.UIElement)
CoD.TabletLocationSelector_HintText.__defaultWidth = 1080
CoD.TabletLocationSelector_HintText.__defaultHeight = 36
CoD.TabletLocationSelector_HintText.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.ModelUtility.InitDataSourceModelIfNotSet(f1_arg1, "HUDItems", "tabletLocationSelectorText", "")
	self:setClass(CoD.TabletLocationSelector_HintText)
	self.id = "TabletLocationSelector_HintText"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FEButtonPanel0 = CoD.FE_ButtonPanel.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	FEButtonPanel0:setRGB(0, 0, 0)
	FEButtonPanel0:setAlpha(0)
	self:addElement(FEButtonPanel0)
	self.FEButtonPanel0 = FEButtonPanel0
	local CursorHintText = LUI.UIText.new(0.5, 0.5, -540, 540, 0.5, 0.5, -11.5, 6.5)
	CursorHintText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6C1D1D888C9B0714"))
	CursorHintText:setTTF("0arame_mono_stencil")
	CursorHintText:setLetterSpacing(0.5)
	CursorHintText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	CursorHintText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	LUI.OverrideFunction_CallOriginalFirst(CursorHintText, "setText", function(element, controller)
		ScaleWidgetToLabelCentered(self, element, 5)
	end)
	self:addElement(CursorHintText)
	self.CursorHintText = CursorHintText
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsGlobalDataSourceModelValueNonEmptyString(f1_arg1, "HUDItems", "tabletLocationSelectorText")
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = DataSources.HUDItems.getModel(f1_arg1)
	f1_local4(f1_local3, f1_local5.tabletLocationSelectorText, function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "tabletLocationSelectorText",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.TabletLocationSelector_HintText.__resetProperties = function(f5_arg0)
	f5_arg0.FEButtonPanel0:completeAnimation()
	f5_arg0.CursorHintText:completeAnimation()
	f5_arg0.FEButtonPanel0:setAlpha(0)
	f5_arg0.CursorHintText:setAlpha(1)
end
CoD.TabletLocationSelector_HintText.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.FEButtonPanel0:completeAnimation()
			f7_arg0.FEButtonPanel0:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.FEButtonPanel0)
			f7_arg0.CursorHintText:completeAnimation()
			f7_arg0.CursorHintText:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.CursorHintText)
		end,
	},
}
CoD.TabletLocationSelector_HintText.__onClose = function(f8_arg0)
	f8_arg0.FEButtonPanel0:close()
end
