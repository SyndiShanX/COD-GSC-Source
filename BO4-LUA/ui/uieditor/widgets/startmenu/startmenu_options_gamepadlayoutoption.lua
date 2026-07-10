require("x64:3625a0d08a5c80d")
require("x64:a1e2d7b19f5deb0")
CoD.StartMenu_Options_GamepadLayoutOption = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_GamepadLayoutOption.__defaultWidth = 750
CoD.StartMenu_Options_GamepadLayoutOption.__defaultHeight = 60
CoD.StartMenu_Options_GamepadLayoutOption.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_GamepadLayoutOption)
	self.id = "StartMenu_Options_GamepadLayoutOption"
	self.soundSet = "ChooseDecal"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local fullBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	fullBacking:setRGB(0.1, 0.1, 0.1)
	fullBacking:setAlpha(0)
	self:addElement(fullBacking)
	self.fullBacking = fullBacking
	local fullBorder = CoD.StartMenu_frame_noBG.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	fullBorder:setRGB(0.87, 0.37, 0)
	fullBorder:setAlpha(0)
	self:addElement(fullBorder)
	self.fullBorder = fullBorder
	local actionText = LUI.UIText.new(0, 0, 12, 297, 0, 0, 11, 49)
	actionText:setTTF("default")
	actionText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	actionText:linkToElementModel(self, "label", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			actionText:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(actionText)
	self.actionText = actionText
	local valueBacking = LUI.UIImage.new(1, 1, -375, -90, 0, 1, 8, -8)
	valueBacking:setRGB(0.87, 0.37, 0)
	valueBacking:setAlpha(0)
	self:addElement(valueBacking)
	self.valueBacking = valueBacking
	local valueText = LUI.UIText.new(1, 1, -375, -90, 0, 0, 11, 49)
	valueText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	valueText:setTTF("default")
	valueText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	valueText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(valueText)
	self.valueText = valueText
	local StartMenuframenoBG00 = CoD.StartMenu_frame_noBG.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(StartMenuframenoBG00)
	self.StartMenuframenoBG00 = StartMenuframenoBG00
	local FocusBarT = CoD.FE_FocusBarContainer.new(f1_arg0, f1_arg1, 0, 1, 0, -4, 0, 0, 0, 6)
	FocusBarT:setAlpha(0)
	FocusBarT:setZoom(1)
	self:addElement(FocusBarT)
	self.FocusBarT = FocusBarT
	local FocusBarB = CoD.FE_FocusBarContainer.new(f1_arg0, f1_arg1, 0, 1, 0, -4, 1, 1, -8, 0)
	FocusBarB:setAlpha(0)
	FocusBarB:setZoom(1)
	self:addElement(FocusBarB)
	self.FocusBarB = FocusBarB
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_GamepadLayoutOption.__resetProperties = function(f3_arg0)
	f3_arg0.valueBacking:completeAnimation()
	f3_arg0.valueText:completeAnimation()
	f3_arg0.fullBorder:completeAnimation()
	f3_arg0.FocusBarT:completeAnimation()
	f3_arg0.FocusBarB:completeAnimation()
	f3_arg0.valueBacking:setRGB(0.87, 0.37, 0)
	f3_arg0.valueText:setAlpha(1)
	f3_arg0.fullBorder:setAlpha(0)
	f3_arg0.FocusBarT:setLeftRight(0, 1, 0, -4)
	f3_arg0.FocusBarT:setTopBottom(0, 0, 0, 6)
	f3_arg0.FocusBarT:setAlpha(0)
	f3_arg0.FocusBarB:setLeftRight(0, 1, 0, -4)
	f3_arg0.FocusBarB:setTopBottom(1, 1, -8, 0)
	f3_arg0.FocusBarB:setAlpha(0)
end
CoD.StartMenu_Options_GamepadLayoutOption.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(2)
			f4_arg0.valueBacking:completeAnimation()
			f4_arg0.valueBacking:setRGB(0.39, 0.39, 0.39)
			f4_arg0.clipFinished(f4_arg0.valueBacking)
			f4_arg0.valueText:completeAnimation()
			f4_arg0.valueText:setAlpha(0.5)
			f4_arg0.clipFinished(f4_arg0.valueText)
		end,
		Focus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(3)
			f5_arg0.fullBorder:completeAnimation()
			f5_arg0.fullBorder:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.fullBorder)
			f5_arg0.FocusBarT:completeAnimation()
			f5_arg0.FocusBarT:setLeftRight(0, 1, 0, 0)
			f5_arg0.FocusBarT:setTopBottom(0, 0, 0, 6)
			f5_arg0.FocusBarT:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.FocusBarT)
			f5_arg0.FocusBarB:completeAnimation()
			f5_arg0.FocusBarB:setLeftRight(0, 1, 0, 0)
			f5_arg0.FocusBarB:setTopBottom(1, 1, -8, 0)
			f5_arg0.FocusBarB:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.FocusBarB)
		end,
	},
}
CoD.StartMenu_Options_GamepadLayoutOption.__onClose = function(f6_arg0)
	f6_arg0.fullBorder:close()
	f6_arg0.actionText:close()
	f6_arg0.StartMenuframenoBG00:close()
	f6_arg0.FocusBarT:close()
	f6_arg0.FocusBarB:close()
end
