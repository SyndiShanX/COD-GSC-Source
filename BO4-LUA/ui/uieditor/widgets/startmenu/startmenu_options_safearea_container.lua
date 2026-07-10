require("x64:3863141f8b496f8")
require("x64:f9a3b11d5a51171")
CoD.StartMenu_Options_SafeArea_Container = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_SafeArea_Container.__defaultWidth = 1920
CoD.StartMenu_Options_SafeArea_Container.__defaultHeight = 1080
CoD.StartMenu_Options_SafeArea_Container.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_SafeArea_Container)
	self.id = "StartMenu_Options_SafeArea_Container"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local backgroundImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	backgroundImage:setRGB(0, 0, 0)
	backgroundImage:setAlpha(0)
	self:addElement(backgroundImage)
	self.backgroundImage = backgroundImage
	local PCBackingBackground = nil
	PCBackingBackground = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	PCBackingBackground:setRGB(0.69, 0.69, 0.69)
	PCBackingBackground:setAlpha(0)
	PCBackingBackground:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	self:addElement(PCBackingBackground)
	self.PCBackingBackground = PCBackingBackground
	local upArrow = LUI.UIImage.new(0.5, 0.5, -48, 48, 0, 0, 0, 96)
	upArrow:setZRot(270)
	upArrow:setImage(RegisterImage(@"safe_area_arrow"))
	self:addElement(upArrow)
	self.upArrow = upArrow
	local downArrow = LUI.UIImage.new(0.5, 0.5, -48, 48, 1, 1, -96, 0)
	downArrow:setZRot(90)
	downArrow:setImage(RegisterImage(@"safe_area_arrow"))
	self:addElement(downArrow)
	self.downArrow = downArrow
	local leftArrow = LUI.UIImage.new(0, 0, 0, 96, 0.5, 0.5, -48, 48)
	leftArrow:setImage(RegisterImage(@"safe_area_arrow"))
	self:addElement(leftArrow)
	self.leftArrow = leftArrow
	local rightArrow = LUI.UIImage.new(1, 1, -96, 0, 0.5, 0.5, -48, 48)
	rightArrow:setZRot(180)
	rightArrow:setImage(RegisterImage(@"safe_area_arrow"))
	self:addElement(rightArrow)
	self.rightArrow = rightArrow
	local RBorder = nil
	RBorder = CoD.PC_StartMenu_Options_SafeAreaBorder_Horiz.new(f1_arg0, f1_arg1, 1, 1, -100, 0, 0, 1, 0, 0)
	RBorder:setZRot(180)
	LUI.OverrideFunction_CallOriginalFirst(RBorder, "childFocusGained", function(element)
		PlayClipOnElement(self, {
			elementName = "LBorder",
			clipName = "GainChildFocus",
		}, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(RBorder, "childFocusLost", function(element)
		PlayClipOnElement(self, {
			elementName = "LBorder",
			clipName = "LoseChildFocus",
		}, f1_arg1)
	end)
	self:addElement(RBorder)
	self.RBorder = RBorder
	local LBorder = nil
	LBorder = CoD.PC_StartMenu_Options_SafeAreaBorder_Horiz.new(f1_arg0, f1_arg1, 0, 0, 0, 100, 0, 1, 0, 0)
	LUI.OverrideFunction_CallOriginalFirst(LBorder, "childFocusGained", function(element)
		PlayClipOnElement(self, {
			elementName = "RBorder",
			clipName = "GainChildFocus",
		}, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(LBorder, "childFocusLost", function(element)
		PlayClipOnElement(self, {
			elementName = "RBorder",
			clipName = "LoseChildFocus",
		}, f1_arg1)
	end)
	self:addElement(LBorder)
	self.LBorder = LBorder
	local TBorder = nil
	TBorder = CoD.PC_StartMenu_Options_SafeAreaBorder_Vert.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 0, 100)
	LUI.OverrideFunction_CallOriginalFirst(TBorder, "childFocusGained", function(element)
		PlayClipOnElement(self, {
			elementName = "BBorder",
			clipName = "GainChildFocus",
		}, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(TBorder, "childFocusLost", function(element)
		PlayClipOnElement(self, {
			elementName = "BBorder",
			clipName = "LoseChildFocus",
		}, f1_arg1)
	end)
	self:addElement(TBorder)
	self.TBorder = TBorder
	local BBorder = nil
	BBorder = CoD.PC_StartMenu_Options_SafeAreaBorder_Vert.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 1, 1, -100, 0)
	BBorder:setZRot(180)
	LUI.OverrideFunction_CallOriginalFirst(BBorder, "childFocusGained", function(element)
		PlayClipOnElement(self, {
			elementName = "TBorder",
			clipName = "GainChildFocus",
		}, f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalFirst(BBorder, "childFocusLost", function(element)
		PlayClipOnElement(self, {
			elementName = "TBorder",
			clipName = "LoseChildFocus",
		}, f1_arg1)
	end)
	self:addElement(BBorder)
	self.BBorder = BBorder
	self:mergeStateConditions({
		{
			stateName = "FirstTime",
			condition = function(menu, element, event)
				return IsMainFirstTimeSetup(f1_arg1)
			end,
		},
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	if CoD.isPC then
		RBorder.id = "RBorder"
	end
	if CoD.isPC then
		LBorder.id = "LBorder"
	end
	if CoD.isPC then
		TBorder.id = "TBorder"
	end
	if CoD.isPC then
		BBorder.id = "BBorder"
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_SafeArea_Container.__resetProperties = function(f12_arg0)
	f12_arg0.backgroundImage:completeAnimation()
	f12_arg0.rightArrow:completeAnimation()
	f12_arg0.leftArrow:completeAnimation()
	f12_arg0.downArrow:completeAnimation()
	f12_arg0.upArrow:completeAnimation()
	f12_arg0.PCBackingBackground:completeAnimation()
	f12_arg0.backgroundImage:setAlpha(0)
	f12_arg0.rightArrow:setAlpha(1)
	f12_arg0.leftArrow:setAlpha(1)
	f12_arg0.downArrow:setAlpha(1)
	f12_arg0.upArrow:setAlpha(1)
	f12_arg0.PCBackingBackground:setAlpha(0)
end
CoD.StartMenu_Options_SafeArea_Container.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(1)
			f13_arg0.backgroundImage:completeAnimation()
			f13_arg0.backgroundImage:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.backgroundImage)
		end,
	},
	FirstTime = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
	},
	PC = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(6)
			f15_arg0.backgroundImage:completeAnimation()
			f15_arg0.backgroundImage:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.backgroundImage)
			f15_arg0.PCBackingBackground:completeAnimation()
			f15_arg0.PCBackingBackground:setAlpha(0.02)
			f15_arg0.clipFinished(f15_arg0.PCBackingBackground)
			f15_arg0.upArrow:completeAnimation()
			f15_arg0.upArrow:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.upArrow)
			f15_arg0.downArrow:completeAnimation()
			f15_arg0.downArrow:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.downArrow)
			f15_arg0.leftArrow:completeAnimation()
			f15_arg0.leftArrow:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.leftArrow)
			f15_arg0.rightArrow:completeAnimation()
			f15_arg0.rightArrow:setAlpha(0)
			f15_arg0.clipFinished(f15_arg0.rightArrow)
		end,
	},
}
CoD.StartMenu_Options_SafeArea_Container.__onClose = function(f16_arg0)
	f16_arg0.RBorder:close()
	f16_arg0.LBorder:close()
	f16_arg0.TBorder:close()
	f16_arg0.BBorder:close()
end
