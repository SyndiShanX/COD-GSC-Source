CoD.PCSocialMenu_GenericButton_Container = InheritFrom(LUI.UIElement)
CoD.PCSocialMenu_GenericButton_Container.__defaultWidth = 194
CoD.PCSocialMenu_GenericButton_Container.__defaultHeight = 103
CoD.PCSocialMenu_GenericButton_Container.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PCSocialMenu_GenericButton_Container)
	self.id = "PCSocialMenu_GenericButton_Container"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 14, 0)
	Background:setRGB(0.13, 0.12, 0.12)
	self:addElement(Background)
	self.Background = Background
	local Title = LUI.UIText.new(0.05, 0.95, 0, 0, 0.5, 0.5, -8, 16)
	Title:setText(Engine[0xF9F1239CFD921FE](0x93E719493E9E18F))
	Title:setTTF("ttmussels_demibold")
	Title:setLetterSpacing(3)
	Title:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	Title:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	self:addElement(Title)
	self.Title = Title
	local CornerDotBLAnim = LUI.UIImage.new(0, 0, 1, 2, 1, 1, -2, -1)
	self:addElement(CornerDotBLAnim)
	self.CornerDotBLAnim = CornerDotBLAnim
	local CornerDotBR = LUI.UIImage.new(1, 1, -2, -1, 0, 0, 15, 16)
	self:addElement(CornerDotBR)
	self.CornerDotBR = CornerDotBR
	local CornerDotBRAnim = LUI.UIImage.new(1, 1, -2, -1, 1, 1, -2, -1)
	self:addElement(CornerDotBRAnim)
	self.CornerDotBRAnim = CornerDotBRAnim
	local CornerDotBL = LUI.UIImage.new(0, 0, 1, 2, 0, 0, 15, 16)
	self:addElement(CornerDotBL)
	self.CornerDotBL = CornerDotBL
	local Glow = LUI.UIImage.new(0, 1, 0, 0, 0, 0, -55, 7)
	Glow:setAlpha(0)
	Glow:setImage(RegisterImage(0xC3B2316BAE91099))
	self:addElement(Glow)
	self.Glow = Glow
	local TopBorder = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 6)
	TopBorder:setRGB(0.78, 0.74, 0.67)
	TopBorder:setAlpha(0.4)
	self:addElement(TopBorder)
	self.TopBorder = TopBorder
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PCSocialMenu_GenericButton_Container.__resetProperties = function(f2_arg0)
	f2_arg0.Title:completeAnimation()
	f2_arg0.Glow:completeAnimation()
	f2_arg0.Background:completeAnimation()
	f2_arg0.Title:setRGB(1, 1, 1)
	f2_arg0.Glow:setLeftRight(0, 1, 0, 0)
	f2_arg0.Glow:setTopBottom(0, 0, -55, 7)
	f2_arg0.Glow:setAlpha(0)
	f2_arg0.Background:setRGB(0.13, 0.12, 0.12)
end
CoD.PCSocialMenu_GenericButton_Container.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		Focus = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(3)
			f4_arg0.Background:completeAnimation()
			f4_arg0.Background:setRGB(0.1, 0.1, 0.1)
			f4_arg0.clipFinished(f4_arg0.Background)
			f4_arg0.Title:completeAnimation()
			f4_arg0.Title:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f4_arg0.clipFinished(f4_arg0.Title)
			f4_arg0.Glow:completeAnimation()
			f4_arg0.Glow:setLeftRight(0, 1, 0, 0)
			f4_arg0.Glow:setTopBottom(0, 0, -55, 7)
			f4_arg0.Glow:setAlpha(1)
			f4_arg0.clipFinished(f4_arg0.Glow)
		end,
		LoseFocus = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(3)
			local f5_local0 = function(f6_arg0)
				f5_arg0.Background:beginAnimation(100)
				f5_arg0.Background:setRGB(0.13, 0.12, 0.12)
				f5_arg0.Background:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.Background:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.Background:completeAnimation()
			f5_arg0.Background:setRGB(0.1, 0.1, 0.1)
			f5_local0(f5_arg0.Background)
			local f5_local1 = function(f7_arg0)
				f5_arg0.Title:beginAnimation(100)
				f5_arg0.Title:setRGB(1, 1, 1)
				f5_arg0.Title:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.Title:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.Title:completeAnimation()
			f5_arg0.Title:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
			f5_local1(f5_arg0.Title)
			local f5_local2 = function(f8_arg0)
				f5_arg0.Glow:beginAnimation(100)
				f5_arg0.Glow:setAlpha(0)
				f5_arg0.Glow:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.Glow:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
			end
			f5_arg0.Glow:completeAnimation()
			f5_arg0.Glow:setAlpha(1)
			f5_local2(f5_arg0.Glow)
		end,
	},
}
