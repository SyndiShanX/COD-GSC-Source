require("x64:58c18133f12be4a")
require("x64:bce07fcd345de2a")
CoD.PaintshopChoosePaintSide = InheritFrom(LUI.UIElement)
CoD.PaintshopChoosePaintSide.__defaultWidth = 243
CoD.PaintshopChoosePaintSide.__defaultHeight = 40
CoD.PaintshopChoosePaintSide.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PaintshopChoosePaintSide)
	self.id = "PaintshopChoosePaintSide"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PaintshopChooseSide = CoD.PaintshopChooseSide.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	PaintshopChooseSide.text:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	PaintshopChooseSide:subscribeToGlobalModel(f1_arg1, "Customization", "view_string_ref", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PaintshopChooseSide.text:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(PaintshopChooseSide)
	self.PaintshopChooseSide = PaintshopChooseSide
	local rightStick = CoD.EmblemEditorButtonPrompt.new(f1_arg0, f1_arg1, 0, 0, 4, 42, 0, 1, 0, -6)
	rightStick:setAlpha(0)
	rightStick.label:setText("")
	rightStick:subscribeToGlobalModel(f1_arg1, "Controller", "move_right_stick_button_image", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			rightStick.buttonPromptImage:setImage(RegisterImage(f3_local0))
		end
	end)
	self:addElement(rightStick)
	self.rightStick = rightStick
	local Image0 = LUI.UIImage.new(0, 0, 49, 52, 0, 0, 0, 38)
	Image0:setRGB(0, 0, 0)
	Image0:setAlpha(0)
	self:addElement(Image0)
	self.Image0 = Image0
	local downArrow = LUI.UIImage.new(0.5, 0.5, 96, 120, 0.5, 0.5, -8, 4)
	downArrow:setRGB(0, 0, 0)
	downArrow:setAlpha(0)
	downArrow:setZRot(-90)
	downArrow:setImage(RegisterImage(@"uie_img_t7_menu_arrow"))
	self:addElement(downArrow)
	self.downArrow = downArrow
	local upArrow = LUI.UIImage.new(0.5, 0.5, 76, 100, 0.5, 0.5, -8, 4)
	upArrow:setRGB(0, 0, 0)
	upArrow:setAlpha(0)
	upArrow:setZRot(90)
	upArrow:setImage(RegisterImage(@"uie_img_t7_menu_arrow"))
	self:addElement(upArrow)
	self.upArrow = upArrow
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PaintshopChoosePaintSide.__resetProperties = function(f4_arg0)
	f4_arg0.rightStick:completeAnimation()
	f4_arg0.Image0:completeAnimation()
	f4_arg0.downArrow:completeAnimation()
	f4_arg0.upArrow:completeAnimation()
	f4_arg0.rightStick:setLeftRight(0, 0, 4, 42)
	f4_arg0.rightStick:setTopBottom(0, 1, 0, -6)
	f4_arg0.rightStick:setAlpha(0)
	f4_arg0.Image0:setLeftRight(0, 0, 49, 52)
	f4_arg0.Image0:setTopBottom(0, 0, 0, 38)
	f4_arg0.Image0:setAlpha(0)
	f4_arg0.downArrow:setLeftRight(0.5, 0.5, 96, 120)
	f4_arg0.downArrow:setTopBottom(0.5, 0.5, -8, 4)
	f4_arg0.downArrow:setAlpha(0)
	f4_arg0.downArrow:setScale(1, 1)
	f4_arg0.upArrow:setLeftRight(0.5, 0.5, 76, 100)
	f4_arg0.upArrow:setTopBottom(0.5, 0.5, -8, 4)
	f4_arg0.upArrow:setAlpha(0)
	f4_arg0.upArrow:setScale(1, 1)
end
CoD.PaintshopChoosePaintSide.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	BrowseModeControlsState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(4)
			f6_arg0.rightStick:completeAnimation()
			f6_arg0.rightStick:setLeftRight(0, 0, 1, 39)
			f6_arg0.rightStick:setTopBottom(0, 1, 0, -6)
			f6_arg0.rightStick:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.rightStick)
			f6_arg0.Image0:completeAnimation()
			f6_arg0.Image0:setLeftRight(0, 0, 43, 46)
			f6_arg0.Image0:setTopBottom(0, 0, 0, 38)
			f6_arg0.Image0:setAlpha(0.47)
			f6_arg0.clipFinished(f6_arg0.Image0)
			f6_arg0.downArrow:completeAnimation()
			f6_arg0.downArrow:setLeftRight(0.5, 0.5, 98, 122)
			f6_arg0.downArrow:setTopBottom(0.5, 0.5, -8, 4)
			f6_arg0.downArrow:setAlpha(1)
			f6_arg0.downArrow:setScale(0.8, 0.8)
			f6_arg0.clipFinished(f6_arg0.downArrow)
			f6_arg0.upArrow:completeAnimation()
			f6_arg0.upArrow:setLeftRight(0.5, 0.5, -77, -53)
			f6_arg0.upArrow:setTopBottom(0.5, 0.5, -8, 4)
			f6_arg0.upArrow:setAlpha(1)
			f6_arg0.upArrow:setScale(0.8, 0.8)
			f6_arg0.clipFinished(f6_arg0.upArrow)
		end,
	},
}
CoD.PaintshopChoosePaintSide.__onClose = function(f7_arg0)
	f7_arg0.PaintshopChooseSide:close()
	f7_arg0.rightStick:close()
end
