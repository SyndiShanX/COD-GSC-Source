require("x64:55aca670e9903a3")
require("x64:a9255c570c68aa8")
require("x64:a1e2d7b19f5deb0")
CoD.StartMenu_Options_TextBoxOption = InheritFrom(LUI.UIElement)
CoD.StartMenu_Options_TextBoxOption.__defaultWidth = 760
CoD.StartMenu_Options_TextBoxOption.__defaultHeight = 60
CoD.StartMenu_Options_TextBoxOption.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_Options_TextBoxOption)
	self.id = "StartMenu_Options_TextBoxOption"
	self.soundSet = "ChooseDecal"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Backing:setRGB(0.13, 0.12, 0.12)
	Backing:setAlpha(0.5)
	self:addElement(Backing)
	self.Backing = Backing
	local Frame = CoD.StartMenuOptionsMainFrame.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	Frame:setRGB(0.78, 0.74, 0.67)
	Frame:setAlpha(0.04)
	self:addElement(Frame)
	self.Frame = Frame
	local Corner = CoD.StartMenuOptionsMainCorners.new(f1_arg0, f1_arg1, 0.5, 0.5, -380, 380, 0, 1, 0, 0)
	self:addElement(Corner)
	self.Corner = Corner
	local ActionText = LUI.UIText.new(0, 0, 12, 352, 0.5, 0.5, -10.5, 10.5)
	ActionText:setRGB(0.78, 0.74, 0.67)
	ActionText:setTTF("ttmussels_regular")
	ActionText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ActionText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	ActionText:linkToElementModel(self, "displayText", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ActionText:setText(Engine[0xF9F1239CFD921FE](f2_local0))
		end
	end)
	self:addElement(ActionText)
	self.ActionText = ActionText
	local CurrentText = LUI.UIText.new(0, 0, 483, 738, 0.5, 0.5, -10.5, 10.5)
	CurrentText:setRGB(0.78, 0.74, 0.67)
	CurrentText:setTTF("notosans_regular")
	CurrentText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	CurrentText:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	CurrentText:linkToElementModel(self, "currentText", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			CurrentText:setText(f3_local0)
		end
	end)
	self:addElement(CurrentText)
	self.CurrentText = CurrentText
	local StartMenuframenoBG00 = CoD.StartMenu_frame_noBG.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, 0)
	self:addElement(StartMenuframenoBG00)
	self.StartMenuframenoBG00 = StartMenuframenoBG00
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_Options_TextBoxOption.__resetProperties = function(f4_arg0)
	f4_arg0.Backing:completeAnimation()
	f4_arg0.Frame:completeAnimation()
	f4_arg0.Corner:completeAnimation()
	f4_arg0.Backing:setRGB(0.13, 0.12, 0.12)
	f4_arg0.Backing:setAlpha(0.5)
	f4_arg0.Frame:setAlpha(0.04)
	f4_arg0.Corner:setScale(1, 1)
end
CoD.StartMenu_Options_TextBoxOption.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(3)
			f6_arg0.Backing:completeAnimation()
			f6_arg0.Backing:setRGB(0.78, 0.74, 0.67)
			f6_arg0.Backing:setAlpha(0.2)
			f6_arg0.clipFinished(f6_arg0.Backing)
			f6_arg0.Frame:completeAnimation()
			f6_arg0.Frame:setAlpha(0.6)
			f6_arg0.clipFinished(f6_arg0.Frame)
			f6_arg0.Corner:completeAnimation()
			f6_arg0.Corner:setScale(0.98, 0.83)
			f6_arg0.clipFinished(f6_arg0.Corner)
		end,
		GainFocus = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(3)
			local f7_local0 = function(f8_arg0)
				f7_arg0.Backing:beginAnimation(200)
				f7_arg0.Backing:setRGB(0.78, 0.74, 0.67)
				f7_arg0.Backing:setAlpha(0.2)
				f7_arg0.Backing:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.Backing:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.Backing:completeAnimation()
			f7_arg0.Backing:setRGB(0.13, 0.12, 0.12)
			f7_arg0.Backing:setAlpha(0.5)
			f7_local0(f7_arg0.Backing)
			local f7_local1 = function(f9_arg0)
				f7_arg0.Frame:beginAnimation(200)
				f7_arg0.Frame:setAlpha(0.6)
				f7_arg0.Frame:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.Frame:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.Frame:completeAnimation()
			f7_arg0.Frame:setAlpha(0.04)
			f7_local1(f7_arg0.Frame)
			local f7_local2 = function(f10_arg0)
				f7_arg0.Corner:beginAnimation(200)
				f7_arg0.Corner:setScale(0.98, 0.83)
				f7_arg0.Corner:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.Corner:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.Corner:completeAnimation()
			f7_arg0.Corner:setScale(1, 1)
			f7_local2(f7_arg0.Corner)
		end,
		LoseFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			local f11_local0 = function(f12_arg0)
				f11_arg0.Backing:beginAnimation(200)
				f11_arg0.Backing:setRGB(0.13, 0.12, 0.12)
				f11_arg0.Backing:setAlpha(0.5)
				f11_arg0.Backing:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Backing:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.Backing:completeAnimation()
			f11_arg0.Backing:setRGB(0.78, 0.74, 0.67)
			f11_arg0.Backing:setAlpha(0.2)
			f11_local0(f11_arg0.Backing)
			local f11_local1 = function(f13_arg0)
				f11_arg0.Frame:beginAnimation(200)
				f11_arg0.Frame:setAlpha(0.04)
				f11_arg0.Frame:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Frame:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.Frame:completeAnimation()
			f11_arg0.Frame:setAlpha(0.6)
			f11_local1(f11_arg0.Frame)
			local f11_local2 = function(f14_arg0)
				f11_arg0.Corner:beginAnimation(200)
				f11_arg0.Corner:setScale(1, 1)
				f11_arg0.Corner:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Corner:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.Corner:completeAnimation()
			f11_arg0.Corner:setScale(0.98, 0.83)
			f11_local2(f11_arg0.Corner)
		end,
	},
}
CoD.StartMenu_Options_TextBoxOption.__onClose = function(f15_arg0)
	f15_arg0.Frame:close()
	f15_arg0.Corner:close()
	f15_arg0.ActionText:close()
	f15_arg0.CurrentText:close()
	f15_arg0.StartMenuframenoBG00:close()
end
