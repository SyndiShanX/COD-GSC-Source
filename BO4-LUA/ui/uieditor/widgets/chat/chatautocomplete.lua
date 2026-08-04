require("ui/uieditor/widgets/chat/chatautocompleteaction")
require("ui/uieditor/widgets/emptyfocusable")
CoD.ChatAutoComplete = InheritFrom(LUI.UIElement)
CoD.ChatAutoComplete.__defaultWidth = 233
CoD.ChatAutoComplete.__defaultHeight = 253
CoD.ChatAutoComplete.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ChatAutoComplete)
	self.id = "ChatAutoComplete"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FocusBlocker = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(FocusBlocker)
	self.FocusBlocker = FocusBlocker
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Background:setRGB(0.02, 0.02, 0.02)
	self:addElement(Background)
	self.Background = Background
	local NoiseBackground = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	NoiseBackground:setRGB(0.92, 0.92, 0.92)
	NoiseBackground:setAlpha(0.7)
	NoiseBackground:setImage(RegisterImage("uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseBackground:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseBackground:setShaderVector(0, 0, 0, 0, 0)
	NoiseBackground:setupNineSliceShader(64, 64)
	self:addElement(NoiseBackground)
	self.NoiseBackground = NoiseBackground
	local Border = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Border:setRGB(0.42, 0.42, 0.42)
	Border:setAlpha(0.3)
	Border:setImage(RegisterImage("uie_highlight_border_line"))
	Border:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_normal"))
	Border:setShaderVector(0, 0, 0, 0, 0)
	Border:setupNineSliceShader(4, 4)
	self:addElement(Border)
	self.Border = Border
	local ActionList = LUI.UIList.new(f1_arg0, f1_arg1, 0, 0, nil, false, false, false, false)
	ActionList:setLeftRight(0, 1, 0, 0)
	ActionList:setTopBottom(0, 0, 0, 203)
	ActionList:setAutoScaleContent(true)
	ActionList:setWidgetType(CoD.ChatAutoCompleteAction)
	ActionList:setVerticalCount(7)
	ActionList:setSpacing(0)
	ActionList:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	ActionList:setDataSource("ContextualMenuActionsList")
	self:addElement(ActionList)
	self.ActionList = ActionList
	local EmptyListBg = LUI.UIImage.new(0, 1, 0, 0, 0, 0.16, 0, 0)
	EmptyListBg:setRGB(0.18, 0.17, 0.17)
	EmptyListBg:setAlpha(0)
	self:addElement(EmptyListBg)
	self.EmptyListBg = EmptyListBg
	local EmptyListTitle = LUI.UIText.new(0, 0, 10, 223, 0, 0, 6, 33)
	EmptyListTitle:setRGB(0.76, 0.76, 0.76)
	EmptyListTitle:setAlpha(0)
	EmptyListTitle:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_4DB82C5BB5F4D8BC"))
	EmptyListTitle:setTTF("default")
	EmptyListTitle:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	self:addElement(EmptyListTitle)
	self.EmptyListTitle = EmptyListTitle
	self:mergeStateConditions({
		{
			stateName = "NoItems",
			condition = function(menu, element, event)
				return not ListElementHasElements(self.ActionList)
			end,
		},
	})
	self:appendEventHandler("grid_updated", function(f3_arg0, f3_arg1)
		f3_arg1.menu = f3_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f3_arg1)
	end)
	FocusBlocker.id = "FocusBlocker"
	ActionList.id = "ActionList"
	self.__defaultFocus = ActionList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local8 = self
	DisableKeyboardNavigationByElement(FocusBlocker)
	return self
end
CoD.ChatAutoComplete.__resetProperties = function(f4_arg0)
	f4_arg0.ActionList:completeAnimation()
	f4_arg0.EmptyListBg:completeAnimation()
	f4_arg0.EmptyListTitle:completeAnimation()
	f4_arg0.ActionList:setAlpha(1)
	f4_arg0.EmptyListBg:setAlpha(0)
	f4_arg0.EmptyListTitle:setTopBottom(0, 0, 6, 33)
	f4_arg0.EmptyListTitle:setAlpha(0)
end
CoD.ChatAutoComplete.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	NoItems = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(3)
			f6_arg0.ActionList:completeAnimation()
			f6_arg0.ActionList:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.ActionList)
			f6_arg0.EmptyListBg:completeAnimation()
			f6_arg0.EmptyListBg:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.EmptyListBg)
			f6_arg0.EmptyListTitle:completeAnimation()
			f6_arg0.EmptyListTitle:setTopBottom(0, 0, 6, 32)
			f6_arg0.EmptyListTitle:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.EmptyListTitle)
		end,
	},
}
CoD.ChatAutoComplete.__onClose = function(f7_arg0)
	f7_arg0.FocusBlocker:close()
	f7_arg0.ActionList:close()
end
