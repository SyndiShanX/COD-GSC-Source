require("x64:9dba513915b5a12")
require("x64:932297a0c0ad05c")
CoD.WarzoneDirectorStageIndicator = InheritFrom(LUI.UIElement)
CoD.WarzoneDirectorStageIndicator.__defaultWidth = 529
CoD.WarzoneDirectorStageIndicator.__defaultHeight = 70
CoD.WarzoneDirectorStageIndicator.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneDirectorStageIndicator)
	self.id = "WarzoneDirectorStageIndicator"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local blur = LUI.UIImage.new(0, 0, 2, 527, 0, 0, 1, 59)
	blur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(blur)
	self.blur = blur
	local bg = LUI.UIImage.new(0, 0, 2, 527, 0, 0, 2, 49)
	bg:setRGB(0, 0, 0)
	bg:setAlpha(0.8)
	self:addElement(bg)
	self.bg = bg
	local led = LUI.UIImage.new(0, 0, 2, 294, 0, 0, 4.5, 44.5)
	led:setAlpha(0.02)
	led:setImage(RegisterImage(0xC07F7432F86DA83))
	led:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	led:setShaderVector(0, 0, 1, 0, 0)
	led:setShaderVector(1, 0, 0, 0, 0)
	led:setShaderVector(2, 0, 1, 0, 0)
	led:setShaderVector(3, 0, 0, 0, 0)
	led:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(led)
	self.led = led
	local led2 = LUI.UIImage.new(0, 0, 290, 582, 0, 0, 4.5, 44.5)
	led2:setAlpha(0.02)
	led2:setImage(RegisterImage(0xC07F7432F86DA83))
	led2:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	led2:setShaderVector(0, 0, 0.79, 0, 0)
	led2:setShaderVector(1, 0, 0, 0, 0)
	led2:setShaderVector(2, 0, 1, 0, 0)
	led2:setShaderVector(3, 0, 0, 0, 0)
	led2:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(led2)
	self.led2 = led2
	local Border = LUI.UIImage.new(0, 0, -8, 548, 0, 0, -6.5, 77.5)
	Border:setRGB(0.39, 0.39, 0.39)
	Border:setImage(RegisterImage(0x4DA3B52DFEFD271))
	self:addElement(Border)
	self.Border = Border
	local Stage1 = CoD.WarzoneDirectorStageBar.new(f1_arg0, f1_arg1, 0, 0, 2, 182, 0, 0, 46.5, 70.5)
	self:addElement(Stage1)
	self.Stage1 = Stage1
	local Stage2 = CoD.WarzoneDirectorStageBar.new(f1_arg0, f1_arg1, 0, 0, 174.5, 354.5, 0, 0, 46.5, 70.5)
	self:addElement(Stage2)
	self.Stage2 = Stage2
	local Stage3 = CoD.WarzoneDirectorStageBar.new(f1_arg0, f1_arg1, 0, 0, 347, 527, 0, 0, 46.5, 70.5)
	self:addElement(Stage3)
	self.Stage3 = Stage3
	local Stage4 = CoD.WarzoneDirectorStagesPulsing.new(f1_arg0, f1_arg1, 0, 0, 2, 528, 0, 0, 46.5, 70.5)
	Stage4:setRFTMaterial(LUI.UIImage.GetCachedMaterial(0x1DE43899593E67E))
	Stage4:setShaderVector(0, 0, 1, 0, 0)
	Stage4:setShaderVector(1, 1, 1, 1, 0)
	Stage4:setShaderVector(2, 0, 1, 0, 0)
	Stage4:setShaderVector(3, 0, 0, 0, 0)
	self:addElement(Stage4)
	self.Stage4 = Stage4
	local StageTitle = LUI.UIText.new(0, 0, 9, 320, 0, 0, 12.5, 40.5)
	StageTitle:setRGB(0.86, 0.74, 0.25)
	StageTitle:setText(LocalizeToUpperString(0x968D3B043BAE7EA))
	StageTitle:setTTF("ttmussels_regular")
	StageTitle:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	StageTitle:setShaderVector(0, 1.11, 0, 0, 0)
	StageTitle:setShaderVector(1, -0.06, 0, 0, 0)
	StageTitle:setShaderVector(2, 0.86, 0.74, 0.25, 0.24)
	StageTitle:setLetterSpacing(8)
	StageTitle:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	StageTitle:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(StageTitle)
	self.StageTitle = StageTitle
	local subtitle = LUI.UIText.new(0, 0, 321, 520, 0, 0, 15.5, 37.5)
	subtitle:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	subtitle:setText(LocalizeToUpperString(0x585FA7FA77BD040))
	subtitle:setTTF("ttmussels_regular")
	subtitle:setMaterial(LUI.UIImage.GetCachedMaterial(0x90D57B1E92D39D7))
	subtitle:setShaderVector(0, 0.56, 0, 0, 0)
	subtitle:setShaderVector(1, 0, 0, 0, 0)
	subtitle:setShaderVector(2, 1, 1, 1, 0.23)
	subtitle:setLetterSpacing(4)
	subtitle:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	subtitle:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(subtitle)
	self.subtitle = subtitle
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneDirectorStageIndicator.__resetProperties = function(f2_arg0)
	f2_arg0.Stage3:completeAnimation()
	f2_arg0.Stage2:completeAnimation()
	f2_arg0.Stage1:completeAnimation()
	f2_arg0.Stage4:completeAnimation()
	f2_arg0.Stage3:setAlpha(1)
	f2_arg0.Stage2:setAlpha(1)
	f2_arg0.Stage1:setAlpha(1)
	f2_arg0.Stage4:setAlpha(1)
	f2_arg0.Stage4:setShaderVector(0, 0, 1, 0, 0)
	f2_arg0.Stage4:setShaderVector(1, 1, 1, 1, 0)
	f2_arg0.Stage4:setShaderVector(2, 0, 1, 0, 0)
	f2_arg0.Stage4:setShaderVector(3, 0, 0, 0, 0)
end
CoD.WarzoneDirectorStageIndicator.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(4)
			f4_arg0.Stage1:completeAnimation()
			f4_arg0.Stage1:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Stage1)
			f4_arg0.Stage2:completeAnimation()
			f4_arg0.Stage2:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Stage2)
			f4_arg0.Stage3:completeAnimation()
			f4_arg0.Stage3:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Stage3)
			f4_arg0.Stage4:completeAnimation()
			f4_arg0.Stage4:setAlpha(0)
			f4_arg0.clipFinished(f4_arg0.Stage4)
		end,
	},
	PlayWaitingAnimation = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					f7_arg0:beginAnimation(750)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
				end
				f5_arg0.Stage4:beginAnimation(750)
				f5_arg0.Stage4:setShaderVector(0, 1, 1.2, 0, 0)
				f5_arg0.Stage4:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.Stage4:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f5_arg0.Stage4:completeAnimation()
			f5_arg0.Stage4:setShaderVector(0, -0.2, 0, 0, 0)
			f5_arg0.Stage4:setShaderVector(1, 0.1, 0.1, 0, 0)
			f5_arg0.Stage4:setShaderVector(2, 0, 1, 0, 0)
			f5_arg0.Stage4:setShaderVector(3, 0, 0, 0, 0)
			f5_local0(f5_arg0.Stage4)
			f5_arg0.nextClip = "DefaultClip"
		end,
	},
}
CoD.WarzoneDirectorStageIndicator.__onClose = function(f8_arg0)
	f8_arg0.Stage1:close()
	f8_arg0.Stage2:close()
	f8_arg0.Stage3:close()
	f8_arg0.Stage4:close()
end
