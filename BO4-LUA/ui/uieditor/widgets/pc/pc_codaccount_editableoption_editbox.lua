require("x64:55aca670e9903a3")
require("x64:a9255c570c68aa8")
CoD.PC_CoDAccount_EditableOption_EditBox = InheritFrom(LUI.UIElement)
CoD.PC_CoDAccount_EditableOption_EditBox.__defaultWidth = 340
CoD.PC_CoDAccount_EditableOption_EditBox.__defaultHeight = 60
CoD.PC_CoDAccount_EditableOption_EditBox.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_CoDAccount_EditableOption_EditBox)
	self.id = "PC_CoDAccount_EditableOption_EditBox"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0, 0, 0)
	Backing:setAlpha(0.5)
	self:addElement(Backing)
	self.Backing = Backing
	local Frame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Frame:setRGB(0.78, 0.74, 0.67)
	Frame:setAlpha(0.04)
	self:addElement(Frame)
	self.Frame = Frame
	local Corner = CoD.StartMenuOptionsMainCorners.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(Corner)
	self.Corner = Corner
	local TextBox = LUI.UIText.new(0, 0, 20, 320, 0.5, 0.5, -10.5, 10.5)
	TextBox:setRGB(0.78, 0.74, 0.67)
	TextBox:setTTF("notosans_regular")
	TextBox:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	TextBox:linkToElementModel(self, "currentText", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			TextBox:setText(f2_local0)
		end
	end)
	self:addElement(TextBox)
	self.TextBox = TextBox
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local5 = self
	CoD.PCUtility.SetupEditControlWithControllerModel(self, f1_arg1, f1_arg0, "CODAccountInfo")
	CoD.BaseUtility.SetUseStencil(self)
	DisableModelStringReplacement(TextBox)
	return self
end
CoD.PC_CoDAccount_EditableOption_EditBox.__resetProperties = function(f3_arg0)
	f3_arg0.Corner:completeAnimation()
	f3_arg0.Frame:completeAnimation()
	f3_arg0.Backing:completeAnimation()
	f3_arg0.TextBox:completeAnimation()
	f3_arg0.Corner:setScale(1, 1)
	f3_arg0.Frame:setAlpha(0.04)
	f3_arg0.Backing:setAlpha(0.5)
	f3_arg0.TextBox:setRGB(0.78, 0.74, 0.67)
end
CoD.PC_CoDAccount_EditableOption_EditBox.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(3)
			f5_arg0.Backing:completeAnimation()
			f5_arg0.Backing:setAlpha(0.8)
			f5_arg0.clipFinished(f5_arg0.Backing)
			f5_arg0.Frame:completeAnimation()
			f5_arg0.Frame:setAlpha(0.6)
			f5_arg0.clipFinished(f5_arg0.Frame)
			f5_arg0.Corner:completeAnimation()
			f5_arg0.Corner:setScale(0.98, 0.9)
			f5_arg0.clipFinished(f5_arg0.Corner)
		end,
		GainFocus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(3)
			local f6_local0 = function(f7_arg0)
				f6_arg0.Backing:beginAnimation(200)
				f6_arg0.Backing:setAlpha(0.8)
				f6_arg0.Backing:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.Backing:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.Backing:completeAnimation()
			f6_arg0.Backing:setAlpha(0.5)
			f6_local0(f6_arg0.Backing)
			local f6_local1 = function(f8_arg0)
				f6_arg0.Frame:beginAnimation(200)
				f6_arg0.Frame:setAlpha(0.6)
				f6_arg0.Frame:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.Frame:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.Frame:completeAnimation()
			f6_arg0.Frame:setAlpha(0.04)
			f6_local1(f6_arg0.Frame)
			local f6_local2 = function(f9_arg0)
				f6_arg0.Corner:beginAnimation(200)
				f6_arg0.Corner:setScale(0.98, 0.9)
				f6_arg0.Corner:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.Corner:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
			end
			f6_arg0.Corner:completeAnimation()
			f6_arg0.Corner:setScale(1, 1)
			f6_local2(f6_arg0.Corner)
		end,
		LoseFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(3)
			local f10_local0 = function(f11_arg0)
				f10_arg0.Backing:beginAnimation(200)
				f10_arg0.Backing:setAlpha(0.5)
				f10_arg0.Backing:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.Backing:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.Backing:completeAnimation()
			f10_arg0.Backing:setAlpha(0.8)
			f10_local0(f10_arg0.Backing)
			local f10_local1 = function(f12_arg0)
				f10_arg0.Frame:beginAnimation(200)
				f10_arg0.Frame:setAlpha(0.04)
				f10_arg0.Frame:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.Frame:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.Frame:completeAnimation()
			f10_arg0.Frame:setAlpha(0.6)
			f10_local1(f10_arg0.Frame)
			local f10_local2 = function(f13_arg0)
				f10_arg0.Corner:beginAnimation(200)
				f10_arg0.Corner:setScale(1, 1)
				f10_arg0.Corner:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.Corner:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.Corner:completeAnimation()
			f10_arg0.Corner:setScale(0.98, 0.9)
			f10_local2(f10_arg0.Corner)
		end,
		InputFocus = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			f14_arg0.TextBox:completeAnimation()
			f14_arg0.TextBox:setRGB(1, 1, 1)
			f14_arg0.clipFinished(f14_arg0.TextBox)
		end,
	},
}
CoD.PC_CoDAccount_EditableOption_EditBox.__onClose = function(f15_arg0)
	f15_arg0.Frame:close()
	f15_arg0.Corner:close()
	f15_arg0.TextBox:close()
end
