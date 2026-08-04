require("ui/uieditor/widgets/cac/newbreadcrumb")
CoD.StartMenu_Identity_SubTitle = InheritFrom(LUI.UIElement)
CoD.StartMenu_Identity_SubTitle.__defaultWidth = 672
CoD.StartMenu_Identity_SubTitle.__defaultHeight = 37
CoD.StartMenu_Identity_SubTitle.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 10, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.StartMenu_Identity_SubTitle)
	self.id = "StartMenu_Identity_SubTitle"
	self.soundSet = "ChooseDecal"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local SubtitleText = LUI.UIText.new(0, 0, 0, 631, 0.5, 0.5, -11.5, 13.5)
	SubtitleText:setText("")
	SubtitleText:setTTF("ttmussels_regular")
	SubtitleText:setLetterSpacing(1.5)
	SubtitleText:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	self:addElement(SubtitleText)
	self.SubtitleText = SubtitleText
	local newIcon = CoD.NewBreadcrumb.new(f1_arg0, f1_arg1, 1, 1, -672, -654, 0.5, 0.5, -9, 9)
	newIcon:setAlpha(0)
	self:addElement(newIcon)
	self.newIcon = newIcon
	self:mergeStateConditions({
		{
			stateName = "HasNew",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Identity_SubTitle.__resetProperties = function(f3_arg0)
	f3_arg0.newIcon:completeAnimation()
	f3_arg0.newIcon:setAlpha(0)
end
CoD.StartMenu_Identity_SubTitle.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
	},
	HasNew = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			f5_arg0.newIcon:completeAnimation()
			f5_arg0.newIcon:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.newIcon)
		end,
	},
}
CoD.StartMenu_Identity_SubTitle.__onClose = function(f6_arg0)
	f6_arg0.newIcon:close()
end
