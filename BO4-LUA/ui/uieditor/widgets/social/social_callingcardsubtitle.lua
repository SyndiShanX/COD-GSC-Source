require("x64:bd6207aa7efa728")
CoD.Social_CallingCardSubTitle = InheritFrom(LUI.UIElement)
CoD.Social_CallingCardSubTitle.__defaultWidth = 93
CoD.Social_CallingCardSubTitle.__defaultHeight = 27
CoD.Social_CallingCardSubTitle.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Social_CallingCardSubTitle)
	self.id = "Social_CallingCardSubTitle"
	self.soundSet = "ModeSelection"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FEListSubHeaderPanel0 = CoD.FE_ListSubHeaderPanel.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	FEListSubHeaderPanel0:setRGB(0, 0, 0)
	FEListSubHeaderPanel0:setAlpha(0)
	self:addElement(FEListSubHeaderPanel0)
	self.FEListSubHeaderPanel0 = FEListSubHeaderPanel0
	local Label0 = LUI.UIText.new(0, 0, 0, 92, 0, 0, 0, 27)
	Label0:setText("")
	Label0:setTTF("dinnext_regular")
	Label0:setLetterSpacing(0.5)
	Label0:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Label0:setBackingType(2)
	Label0:setBackingColor(0, 0, 0)
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
CoD.Social_CallingCardSubTitle.__resetProperties = function(f3_arg0)
	f3_arg0.Label0:completeAnimation()
	f3_arg0.FEListSubHeaderPanel0:completeAnimation()
	f3_arg0.Label0:setAlpha(1)
	f3_arg0.FEListSubHeaderPanel0:setAlpha(0)
end
CoD.Social_CallingCardSubTitle.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	Invisible = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.FEListSubHeaderPanel0:completeAnimation()
			f5_arg0.FEListSubHeaderPanel0:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.FEListSubHeaderPanel0)
			f5_arg0.Label0:completeAnimation()
			f5_arg0.Label0:setAlpha(0)
			f5_arg0.clipFinished(f5_arg0.Label0)
		end,
	},
}
CoD.Social_CallingCardSubTitle.__onClose = function(f6_arg0)
	f6_arg0.FEListSubHeaderPanel0:close()
end
