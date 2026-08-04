require("ui/uieditor/widgets/lobby/common/fe_listsubheaderpanel")
CoD.Social_CallingCardTitle = InheritFrom(LUI.UIElement)
CoD.Social_CallingCardTitle.__defaultWidth = 450
CoD.Social_CallingCardTitle.__defaultHeight = 30
CoD.Social_CallingCardTitle.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_CallingCardTitle)
	self.id = "Social_CallingCardTitle"
	self.soundSet = "ModeSelection"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FEListSubHeaderPanel0 = CoD.FE_ListSubHeaderPanel.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	FEListSubHeaderPanel0:setRGB(0, 0, 0)
	self:addElement(FEListSubHeaderPanel0)
	self.FEListSubHeaderPanel0 = FEListSubHeaderPanel0
	local Label0 = LUI.UIText.new(0, 0, 6, 446, 0, 0, 0, 30)
	Label0:setText("")
	Label0:setTTF("dinnext_regular")
	Label0:setLetterSpacing(0.5)
	Label0:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	LUI.OverrideFunction_CallOriginalFirst(Label0, "setText", function(element, controller)
		ScaleWidgetToLabel(self, element, 2)
	end)
	self:addElement(Label0)
	self.Label0 = Label0
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Social_CallingCardTitle.__resetProperties = function(f3_arg0)
	f3_arg0.Label0:completeAnimation()
	f3_arg0.Label0:setLeftRight(0, 0, 6, 446)
	f3_arg0.Label0:setTopBottom(0, 0, 0, 30)
end
CoD.Social_CallingCardTitle.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			f4_arg0.Label0:completeAnimation()
			f4_arg0.Label0:setLeftRight(0, 0, 6, 446)
			f4_arg0.Label0:setTopBottom(0, 0, 0, 30)
			f4_arg0.clipFinished(f4_arg0.Label0)
		end,
	},
	Invisible = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.Social_CallingCardTitle.__onClose = function(f6_arg0)
	f6_arg0.FEListSubHeaderPanel0:close()
end
