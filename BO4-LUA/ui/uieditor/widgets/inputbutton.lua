require("x64:3625a0d08a5c80d")
require("x64:a1e2d7b19f5deb0")
CoD.InputButton = InheritFrom(LUI.UIElement)
CoD.InputButton.__defaultWidth = 577
CoD.InputButton.__defaultHeight = 51
CoD.InputButton.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.InputButton)
	self.id = "InputButton"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local StartMenuframenoBG0 = CoD.StartMenu_frame_noBG.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 1, 0, -2)
	self:addElement(StartMenuframenoBG0)
	self.StartMenuframenoBG0 = StartMenuframenoBG0
	local Text = LUI.UIText.new(0, 1, 10.5, -13.5, 0, 0, 13, 43)
	Text:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/new"))
	Text:setTTF("dinnext_regular")
	Text:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Text:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Text)
	self.Text = Text
	local FocusBarB = CoD.FE_FocusBarContainer.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 1, 1, -5, 0)
	FocusBarB:setAlpha(0)
	FocusBarB:setZoom(1)
	self:addElement(FocusBarB)
	self.FocusBarB = FocusBarB
	local FocusBarT = CoD.FE_FocusBarContainer.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, -1, 5)
	FocusBarT:setAlpha(0)
	FocusBarT:setZoom(1)
	self:addElement(FocusBarT)
	self.FocusBarT = FocusBarT
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.InputButton.__resetProperties = function(f2_arg0)
	f2_arg0.FocusBarB:completeAnimation()
	f2_arg0.FocusBarT:completeAnimation()
	f2_arg0.Text:completeAnimation()
	f2_arg0.FocusBarB:setAlpha(0)
	f2_arg0.FocusBarT:setAlpha(0)
	f2_arg0.Text:setRGB(1, 1, 1)
end
CoD.InputButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		LoseFocus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(2)
			f5_arg0.FocusBarB:completeAnimation()
			f5_arg0.FocusBarB:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.FocusBarB)
			f5_arg0.FocusBarT:completeAnimation()
			f5_arg0.FocusBarT:setAlpha(1)
			f5_arg0.clipFinished(f5_arg0.FocusBarT)
		end,
	},
	Disabled = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.Text:completeAnimation()
			f6_arg0.Text:setRGB(0.5, 0.51, 0.52)
			f6_arg0.clipFinished(f6_arg0.Text)
		end,
	},
}
CoD.InputButton.__onClose = function(f7_arg0)
	f7_arg0.StartMenuframenoBG0:close()
	f7_arg0.FocusBarB:close()
	f7_arg0.FocusBarT:close()
end
