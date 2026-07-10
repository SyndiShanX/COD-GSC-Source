require("x64:785e3fb024ffd43")
CoD.PlayerContextualMenu = InheritFrom(LUI.UIElement)
CoD.PlayerContextualMenu.__defaultWidth = 300
CoD.PlayerContextualMenu.__defaultHeight = 200
CoD.PlayerContextualMenu.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PlayerContextualMenu)
	self.id = "PlayerContextualMenu"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image3 = LUI.UIImage.new(0, 0, 0, 189, 0, 0, 12, 200)
	Image3:setRGB(0.2, 0.2, 0.2)
	Image3:setAlpha(0.75)
	self:addElement(Image3)
	self.Image3 = Image3
	local ActionsList = LUI.UIList.new(f1_arg0, f1_arg1, 2, 0, nil, false, false, false, false)
	ActionsList:setLeftRight(0, 0, 11.5, 211.5)
	ActionsList:setTopBottom(0, 0, 20, 200)
	ActionsList:setAutoScaleContent(true)
	ActionsList:setWidgetType(CoD.PlayerContextualMenu_Item)
	ActionsList:setVerticalCount(7)
	ActionsList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ActionsList:setDataSource("PlayerContextualMenuOptionsList")
	self:addElement(ActionsList)
	self.ActionsList = ActionsList
	ActionsList.id = "ActionsList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local3 = self
	CoD.PCUtility.SetForceMouseEventDispatch(self, true)
	MakeNotFocusable(self.ActionsList, f1_arg1)
	f1_local3 = Image3
	ScaleWidgetToLabelLeftJustify(self, self.ActionsList, 2)
	return self
end
CoD.PlayerContextualMenu.__resetProperties = function(f2_arg0)
	f2_arg0.Image3:completeAnimation()
	f2_arg0.ActionsList:completeAnimation()
	f2_arg0.Image3:setRGB(0.2, 0.2, 0.2)
	f2_arg0.Image3:setAlpha(0.75)
	f2_arg0.ActionsList:setAlpha(1)
end
CoD.PlayerContextualMenu.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			f3_arg0.Image3:completeAnimation()
			f3_arg0.Image3:setRGB(0.2, 0.2, 0.2)
			f3_arg0.clipFinished(f3_arg0.Image3)
		end,
		InputFocus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.Image3:completeAnimation()
			f4_arg0.Image3:setRGB(0.2, 0.2, 0.2)
			f4_arg0.clipFinished(f4_arg0.Image3)
		end,
	},
	Closed = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.Image3:completeAnimation()
			f5_arg0.Image3:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Image3)
			f5_arg0.ActionsList:completeAnimation()
			f5_arg0.ActionsList:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.ActionsList)
		end,
	},
}
CoD.PlayerContextualMenu.__onClose = function(f6_arg0)
	f6_arg0.Image3:close()
	f6_arg0.ActionsList:close()
end
