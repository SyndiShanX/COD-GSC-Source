require("ui/uieditor/widgets/pc/startmenu/controlsoptions/pc_startmenu_options_controls_descriptionimage")
require("ui/uieditor/widgets/pc/startmenu/controlsoptions/pc_startmenu_options_controls_descriptiontext")
require("ui/uieditor/widgets/pc/startmenu/pc_startmenu_options_pagination")
CoD.PC_StartMenu_Options_Description = InheritFrom(LUI.UIElement)
CoD.PC_StartMenu_Options_Description.__defaultWidth = 675
CoD.PC_StartMenu_Options_Description.__defaultHeight = 600
CoD.PC_StartMenu_Options_Description.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_StartMenu_Options_Description)
	self.id = "PC_StartMenu_Options_Description"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DescriptionTextBox = CoD.PC_StartMenu_Options_Controls_DescriptionText.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 1, 1, -192, 0)
	DescriptionTextBox.detailedDescription:setText("")
	DescriptionTextBox.OptionName:setText(LocalizeToUpperString(@"menu/new"))
	self:addElement(DescriptionTextBox)
	self.DescriptionTextBox = DescriptionTextBox
	local Pagination = LUI.UIList.new(f1_arg0, f1_arg1, 15, 0, nil, false, false, false, false)
	Pagination:setLeftRight(0.5, 0.5, -180, 180)
	Pagination:setTopBottom(0, 0, 391, 399)
	Pagination:setAutoScaleContent(true)
	Pagination:setWidgetType(CoD.PC_StartMenu_Options_Pagination)
	Pagination:setHorizontalCount(5)
	Pagination:setSpacing(15)
	Pagination:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	self:addElement(Pagination)
	self.Pagination = Pagination
	local DescriptionImage = CoD.PC_StartMenu_Options_Controls_DescriptionImage.new(f1_arg0, f1_arg1, 0, 0, 0, 675, 0, 0, 0, 380)
	self:addElement(DescriptionImage)
	self.DescriptionImage = DescriptionImage
	Pagination.id = "Pagination"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local4 = self
	if AlwaysFalse() then
		CoD.PCWidgetUtility.PrepareOptionDescriptionPanel(f1_local4, f1_arg1)
	end
	return self
end
CoD.PC_StartMenu_Options_Description.__resetProperties = function(f2_arg0)
	f2_arg0.DescriptionImage:completeAnimation()
	f2_arg0.DescriptionTextBox:completeAnimation()
	f2_arg0.Pagination:completeAnimation()
	f2_arg0.DescriptionImage:setLeftRight(0, 0, 0, 675)
	f2_arg0.DescriptionImage:setAlpha(1)
	f2_arg0.DescriptionTextBox:setLeftRight(0, 1, 0, 0)
	f2_arg0.DescriptionTextBox:setAlpha(1)
	f2_arg0.DescriptionTextBox.detailedDescription:setAlpha(1)
	f2_arg0.Pagination:setLeftRight(0.5, 0.5, -180, 180)
	f2_arg0.Pagination:setAlpha(1)
end
CoD.PC_StartMenu_Options_Description.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(1)
			local f3_local0 = function(f4_arg0)
				f3_arg0.DescriptionImage:beginAnimation(110)
				f3_arg0.DescriptionImage:setLeftRight(0, 1, 0, 0)
				f3_arg0.DescriptionImage:setAlpha(1)
				f3_arg0.DescriptionImage:registerEventHandler("interrupted_keyframe", f3_arg0.clipInterrupted)
				f3_arg0.DescriptionImage:registerEventHandler("transition_complete_keyframe", f3_arg0.clipFinished)
			end
			f3_arg0.DescriptionImage:completeAnimation()
			f3_arg0.DescriptionImage:setLeftRight(0, 1, 50, 50)
			f3_arg0.DescriptionImage:setAlpha(0)
			f3_local0(f3_arg0.DescriptionImage)
		end,
		DescIntro = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(3)
			local f5_local0 = function(f6_arg0)
				f5_arg0.DescriptionTextBox:beginAnimation(190)
				f5_arg0.DescriptionTextBox:setLeftRight(0, 1, 0, 0)
				f5_arg0.DescriptionTextBox:setAlpha(1)
				f5_arg0.DescriptionTextBox:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.DescriptionTextBox:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.DescriptionTextBox:completeAnimation()
			f5_arg0.DescriptionTextBox:setLeftRight(0, 1, 30, 30)
			f5_arg0.DescriptionTextBox:setAlpha(0)
			f5_local0(f5_arg0.DescriptionTextBox)
			local f5_local1 = function(f7_arg0)
				f5_arg0.Pagination:beginAnimation(190)
				f5_arg0.Pagination:setLeftRight(0.5, 0.5, -180, 180)
				f5_arg0.Pagination:setAlpha(1)
				f5_arg0.Pagination:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.Pagination:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.Pagination:completeAnimation()
			f5_arg0.Pagination:setLeftRight(0.5, 0.5, -150, 210)
			f5_arg0.Pagination:setAlpha(0)
			f5_local1(f5_arg0.Pagination)
			local f5_local2 = function(f8_arg0)
				f5_arg0.DescriptionImage:beginAnimation(190)
				f5_arg0.DescriptionImage:setLeftRight(0, 1, 0, 0)
				f5_arg0.DescriptionImage:setAlpha(1)
				f5_arg0.DescriptionImage:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.DescriptionImage:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.DescriptionImage:completeAnimation()
			f5_arg0.DescriptionImage:setLeftRight(0, 1, 30, 30)
			f5_arg0.DescriptionImage:setAlpha(0)
			f5_local2(f5_arg0.DescriptionImage)
		end,
	},
	Empty = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(3)
			f9_arg0.DescriptionTextBox:completeAnimation()
			f9_arg0.DescriptionTextBox.detailedDescription:completeAnimation()
			f9_arg0.DescriptionTextBox.detailedDescription:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.DescriptionTextBox)
			f9_arg0.Pagination:completeAnimation()
			f9_arg0.Pagination:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.Pagination)
			f9_arg0.DescriptionImage:completeAnimation()
			f9_arg0.DescriptionImage:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.DescriptionImage)
		end,
	},
	TextOnly = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.Pagination:completeAnimation()
			f10_arg0.Pagination:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Pagination)
			f10_arg0.DescriptionImage:completeAnimation()
			f10_arg0.DescriptionImage:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.DescriptionImage)
		end,
	},
	Gamepad = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.Pagination:completeAnimation()
			f11_arg0.Pagination:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Pagination)
			f11_arg0.DescriptionImage:completeAnimation()
			f11_arg0.DescriptionImage:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.DescriptionImage)
		end,
	},
}
CoD.PC_StartMenu_Options_Description.__onClose = function(f12_arg0)
	f12_arg0.DescriptionTextBox:close()
	f12_arg0.Pagination:close()
	f12_arg0.DescriptionImage:close()
end
