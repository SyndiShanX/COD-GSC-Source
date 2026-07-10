require("x64:2675595fa323085")
require("x64:610fa6ebdf6af8b")
require("x64:a9255c570c68aa8")
require("x64:a1e2d7b19f5deb0")
CoD.PC_CoDAccount_EditableOption = InheritFrom(LUI.UIElement)
CoD.PC_CoDAccount_EditableOption.__defaultWidth = 750
CoD.PC_CoDAccount_EditableOption.__defaultHeight = 60
CoD.PC_CoDAccount_EditableOption.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_CoDAccount_EditableOption)
	self.id = "PC_CoDAccount_EditableOption"
	self.soundSet = "ChooseDecal"
	self.onlyChildrenFocusable = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local emptyFocusable = CoD.emptyFocusable.new(f1_arg0, f1_arg1, 0, 0, 0, 750, 0, 0, 0, 60)
	self:addElement(emptyFocusable)
	self.emptyFocusable = emptyFocusable
	local Backing = LUI.UIImage.new(0, 1, 0, -344, 0, 1, 0, 0)
	Backing:setRGB(0.13, 0.12, 0.12)
	Backing:setAlpha(0.5)
	self:addElement(Backing)
	self.Backing = Backing
	local Frame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 1, 0, -344, 0, 1, 0, 0)
	Frame:setRGB(0.78, 0.74, 0.67)
	Frame:setAlpha(0.04)
	self:addElement(Frame)
	self.Frame = Frame
	local ActionText = LUI.UIText.new(0, 0, 12, 352, 0.5, 0.5, -9.5, 10.5)
	ActionText:setRGB(0.78, 0.74, 0.67)
	ActionText:setTTF("ttmussels_regular")
	ActionText:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ActionText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	ActionText:linkToElementModel(self, "displayText", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ActionText:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(ActionText)
	self.ActionText = ActionText
	local StartMenuframenoBG00 = CoD.StartMenu_frame_noBG.new(f1_arg0, f1_arg1, 0.58, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(StartMenuframenoBG00)
	self.StartMenuframenoBG00 = StartMenuframenoBG00
	local CurrentText = CoD.PC_CoDAccount_EditableOption_EditBox.new(f1_arg0, f1_arg1, 1, 1, -340, 0, 0, 0, 0, 60)
	CurrentText:linkToElementModel(self, nil, false, function(model)
		CurrentText:setModel(model, f1_arg1)
	end)
	CurrentText:linkToElementModel(self, "currentText", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			CurrentText.TextBox:setText(f4_local0)
		end
	end)
	self:addElement(CurrentText)
	self.CurrentText = CurrentText
	emptyFocusable.id = "emptyFocusable"
	CurrentText.id = "CurrentText"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_CoDAccount_EditableOption.__resetProperties = function(f5_arg0)
	f5_arg0.Frame:completeAnimation()
	f5_arg0.Backing:completeAnimation()
	f5_arg0.Frame:setAlpha(0.04)
	f5_arg0.Backing:setRGB(0.13, 0.12, 0.12)
	f5_arg0.Backing:setAlpha(0.5)
end
CoD.PC_CoDAccount_EditableOption.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.Backing:completeAnimation()
			f7_arg0.Backing:setRGB(0.78, 0.74, 0.67)
			f7_arg0.Backing:setAlpha(0.2)
			f7_arg0.clipFinished(f7_arg0.Backing)
			f7_arg0.Frame:completeAnimation()
			f7_arg0.Frame:setAlpha(0.6)
			f7_arg0.clipFinished(f7_arg0.Frame)
		end,
	},
}
CoD.PC_CoDAccount_EditableOption.__onClose = function(f8_arg0)
	f8_arg0.emptyFocusable:close()
	f8_arg0.Frame:close()
	f8_arg0.ActionText:close()
	f8_arg0.StartMenuframenoBG00:close()
	f8_arg0.CurrentText:close()
end
