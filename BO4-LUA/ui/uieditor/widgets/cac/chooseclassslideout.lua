require("x64:c2ef150edc05149")
require("x64:f10adbfcdc07f8d")
CoD.ChooseClassSlideOut = InheritFrom(LUI.UIElement)
CoD.ChooseClassSlideOut.__defaultWidth = 1920
CoD.ChooseClassSlideOut.__defaultHeight = 600
CoD.ChooseClassSlideOut.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ChooseClassSlideOut)
	self.id = "ChooseClassSlideOut"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = CoD.ChooseClassSlideOutBacking.new(f1_arg0, f1_arg1, -0.1, 1.1, 0, 0, 1, 1, -600, 0)
	self:addElement(Backing)
	self.Backing = Backing
	local VerticalBGPattern2 = LUI.UIImage.new(0.5, 0.5, -1152, 1152, 0, 0, -6, 36)
	VerticalBGPattern2:setAlpha(0.02)
	VerticalBGPattern2:setImage(RegisterImage(@"uie_ui_menu_cac_vertical_pattern_bg"))
	VerticalBGPattern2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	VerticalBGPattern2:setShaderVector(0, 0, 0, 0, 0)
	VerticalBGPattern2:setupNineSliceShader(256, 256)
	self:addElement(VerticalBGPattern2)
	self.VerticalBGPattern2 = VerticalBGPattern2
	local customClassInternal = CoD.ChooseClassSlideOutInternal.new(f1_arg0, f1_arg1, 0.5, 0.5, -960, 960, 1, 1, -600, 0)
	self:addElement(customClassInternal)
	self.customClassInternal = customClassInternal
	customClassInternal.id = "customClassInternal"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PreLoadFunc then
		PreLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local4 = self
	CoD.BaseUtility.SetUpPassCustomFunctionToChild(self, self.customClassInternal, f1_arg1, f1_arg0, "_chooseClass")
	f1_local4 = Backing
	if IsPC() then
		SizeToWidthOfScreen(f1_local4, f1_arg1)
	elseif IsSplitscreenAndInGame(f1_arg1) then
		SizeToWidthOfScreen(f1_local4, f1_arg1)
	end
	f1_local4 = VerticalBGPattern2
	if IsPC() then
		SizeToWidthOfScreen(f1_local4, f1_arg1)
	elseif IsSplitscreenAndInGame(f1_arg1) then
		SizeToWidthOfScreen(f1_local4, f1_arg1)
	end
	return self
end
CoD.ChooseClassSlideOut.__resetProperties = function(f2_arg0)
	f2_arg0.customClassInternal:completeAnimation()
	f2_arg0.customClassInternal:setLeftRight(0.5, 0.5, -960, 960)
	f2_arg0.customClassInternal:setTopBottom(1, 1, -600, 0)
	f2_arg0.customClassInternal:setAlpha(1)
end
CoD.ChooseClassSlideOut.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		Open = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			local f4_local0 = function(f5_arg0)
				f4_arg0.customClassInternal:beginAnimation(200)
				f4_arg0.customClassInternal:setLeftRight(0, 0, 64.5, 814.5)
				f4_arg0.customClassInternal:setAlpha(1)
				f4_arg0.customClassInternal:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.customClassInternal:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			end
			f4_arg0.customClassInternal:completeAnimation()
			f4_arg0.customClassInternal:setLeftRight(0, 0, -774.5, -24.5)
			f4_arg0.customClassInternal:setTopBottom(0, 0, 0, 848)
			f4_arg0.customClassInternal:setAlpha(0)
			f4_local0(f4_arg0.customClassInternal)
		end,
	},
	Open = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.customClassInternal:completeAnimation()
			f6_arg0.customClassInternal:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.customClassInternal)
		end,
		Close = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.customClassInternal:beginAnimation(200)
				f7_arg0.customClassInternal:setLeftRight(0.5, 0.5, -774.5, 1145.5)
				f7_arg0.customClassInternal:setAlpha(0)
				f7_arg0.customClassInternal:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.customClassInternal:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.customClassInternal:completeAnimation()
			f7_arg0.customClassInternal:setLeftRight(0, 0, 64.5, 814.5)
			f7_arg0.customClassInternal:setTopBottom(0, 0, 0, 848)
			f7_arg0.customClassInternal:setAlpha(1)
			f7_local0(f7_arg0.customClassInternal)
		end,
	},
	Close = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.customClassInternal:completeAnimation()
			f9_arg0.customClassInternal:setLeftRight(0, 0, -774.5, -24.5)
			f9_arg0.customClassInternal:setTopBottom(0, 0, 0, 848)
			f9_arg0.customClassInternal:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.customClassInternal)
		end,
		Open = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			local f10_local0 = function(f11_arg0)
				f10_arg0.customClassInternal:beginAnimation(200)
				f10_arg0.customClassInternal:setLeftRight(0.5, 0.5, 64.5, 1984.5)
				f10_arg0.customClassInternal:setAlpha(1)
				f10_arg0.customClassInternal:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.customClassInternal:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.customClassInternal:completeAnimation()
			f10_arg0.customClassInternal:setLeftRight(0, 0, -774.5, -24.5)
			f10_arg0.customClassInternal:setTopBottom(0, 0, 0, 848)
			f10_arg0.customClassInternal:setAlpha(0)
			f10_local0(f10_arg0.customClassInternal)
		end,
	},
}
CoD.ChooseClassSlideOut.__onClose = function(f12_arg0)
	f12_arg0.Backing:close()
	f12_arg0.VerticalBGPattern2:close()
	f12_arg0.customClassInternal:close()
end
