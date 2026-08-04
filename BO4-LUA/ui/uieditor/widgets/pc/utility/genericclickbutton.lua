require("ui/uieditor/widgets/lobby/common/fe_focusbarcontainer")
local f0_local0 = function(f1_arg0, f1_arg1, f1_arg2)
	f1_arg0:setHandleMouse(true)
	f1_arg0:registerEventHandler("button_action", function(element, event)
		if element.m_button then
			CoD.PCUtil.SimulateButtonPress(f1_arg1, element.m_button)
		end
		return true
	end)
	f1_arg0.setButton = function(f3_arg0, f3_arg1)
		f1_arg0.m_button = f3_arg1
	end
end
local PostLoadFunc = function(self, controller, menu)
	if CoD.isPC then
		f0_local0(self, controller, menu)
	end
end
CoD.GenericClickButton = InheritFrom(LUI.UIElement)
CoD.GenericClickButton.__defaultWidth = 202
CoD.GenericClickButton.__defaultHeight = 60
CoD.GenericClickButton.new = function(f5_arg0, f5_arg1, f5_arg2, f5_arg3, f5_arg4, f5_arg5, f5_arg6, f5_arg7, f5_arg8, f5_arg9)
	local self = LUI.UIElement.new(f5_arg2, f5_arg3, f5_arg4, f5_arg5, f5_arg6, f5_arg7, f5_arg8, f5_arg9)
	self:setClass(CoD.GenericClickButton)
	self.id = "GenericClickButton"
	self.soundSet = "default"
	f5_arg0:addElementToPendingUpdateStateList(self)
	local FEButtonFocus = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	FEButtonFocus:setZoom(10)
	FEButtonFocus:setImage(RegisterImage("uie_t7_menu_frontend_buttonfocusfull"))
	FEButtonFocus:setMaterial(LUI.UIImage.GetCachedMaterial("uie_nineslice_add"))
	FEButtonFocus:setShaderVector(0, 0, 0, 0.38, 0.2)
	FEButtonFocus:setupNineSliceShader(90, 30)
	self:addElement(FEButtonFocus)
	self.FEButtonFocus = FEButtonFocus
	local FocusBarB = CoD.FE_FocusBarContainer.new(f5_arg0, f5_arg1, 0, 1, 34, -34, 1, 1, -9.5, -12.5)
	FocusBarB:setAlpha(0)
	FocusBarB:setZoom(1)
	self:addElement(FocusBarB)
	self.FocusBarB = FocusBarB
	local FocusBarT = CoD.FE_FocusBarContainer.new(f5_arg0, f5_arg1, 0, 1, 34, -34, 0, 0, 10.5, 7.5)
	FocusBarT:setAlpha(0)
	FocusBarT:setZRot(180)
	FocusBarT:setZoom(1)
	self:addElement(FocusBarT)
	self.FocusBarT = FocusBarT
	local Arrow = LUI.UIImage.new(0, 0, 0, -18, 0.5, 0.5, -10.5, 10.5)
	Arrow:setYRot(180)
	Arrow:setZoom(10)
	Arrow:setImage(RegisterImage("uie_t7_menu_frontend_buttonfocusarrow"))
	Arrow:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(Arrow)
	self.Arrow = Arrow
	local Glow21 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, -4, 4)
	Glow21:setAlpha(0)
	Glow21:setImage(RegisterImage("uie_t7_cp_hud_enemytarget_glow"))
	Glow21:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(Glow21)
	self.Glow21 = Glow21
	local label = LUI.UIText.new(0, 1, 26, -6, 0.5, 0.5, -16.5, 16.5)
	label:setRGB(0, 0, 0)
	label:setText(Engine[@"hash_4F9F1239CFD921FE"]("menu/yes_caps"))
	label:setTTF("ttmussels_demibold")
	label:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_2AE166D9BA8C6907"))
	label:setShaderVector(0, 0, 0, 0, 0)
	label:setShaderVector(1, 0, 0, 0, 0)
	label:setShaderVector(2, 1, 0, 0, 0)
	label:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	label:setAlignment(Enum.LUIAlignment[@"lui_alignment_top"])
	self:addElement(label)
	self.label = label
	local Glow2 = LUI.UIImage.new(0, 1, -72, 104, 0, 0, -37, 87)
	Glow2:setImage(RegisterImage("uie_t7_cp_hud_enemytarget_glow"))
	Glow2:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(Glow2)
	self.Glow2 = Glow2
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f5_arg1, f5_arg0)
	end
	return self
end
CoD.GenericClickButton.__resetProperties = function(f6_arg0)
	f6_arg0.Arrow:completeAnimation()
	f6_arg0.Glow2:completeAnimation()
	f6_arg0.Glow21:completeAnimation()
	f6_arg0.FocusBarB:completeAnimation()
	f6_arg0.FocusBarT:completeAnimation()
	f6_arg0.Arrow:setLeftRight(0, 0, 0, -18)
	f6_arg0.Arrow:setTopBottom(0.5, 0.5, -10.5, 10.5)
	f6_arg0.Glow2:setAlpha(1)
	f6_arg0.Glow21:setAlpha(0)
	f6_arg0.FocusBarB:setLeftRight(0, 1, 34, -34)
	f6_arg0.FocusBarB:setTopBottom(1, 1, -9.5, -12.5)
	f6_arg0.FocusBarT:setLeftRight(0, 1, 34, -34)
	f6_arg0.FocusBarT:setTopBottom(0, 0, 10.5, 7.5)
end
CoD.GenericClickButton.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.Arrow:completeAnimation()
			f7_arg0.Arrow:setLeftRight(0, 0, 0, -18)
			f7_arg0.Arrow:setTopBottom(0.5, 0.5, -11, 10)
			f7_arg0.clipFinished(f7_arg0.Arrow)
			f7_arg0.Glow2:completeAnimation()
			f7_arg0.Glow2:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.Glow2)
		end,
		Focus = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.Arrow:completeAnimation()
			f8_arg0.Arrow:setLeftRight(0, 0, 12, -6)
			f8_arg0.Arrow:setTopBottom(0.5, 0.5, -11, 10)
			f8_arg0.clipFinished(f8_arg0.Arrow)
			f8_arg0.Glow21:completeAnimation()
			f8_arg0.Glow21:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.Glow21)
		end,
		GainFocus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(5)
			f9_arg0.FocusBarB:completeAnimation()
			f9_arg0.FocusBarB:setLeftRight(0, 1, 22, -22)
			f9_arg0.FocusBarB:setTopBottom(1, 1, -8, -14)
			f9_arg0.clipFinished(f9_arg0.FocusBarB)
			f9_arg0.FocusBarT:completeAnimation()
			f9_arg0.FocusBarT:setLeftRight(0, 1, 22, -22)
			f9_arg0.FocusBarT:setTopBottom(0, 0, 13, 7)
			f9_arg0.clipFinished(f9_arg0.FocusBarT)
			local f9_local0 = function(f10_arg0)
				f9_arg0.Arrow:beginAnimation(140)
				f9_arg0.Arrow:setLeftRight(0, 0, 12, -6)
				f9_arg0.Arrow:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.Arrow:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.Arrow:completeAnimation()
			f9_arg0.Arrow:setLeftRight(0, 0, 0, -18)
			f9_arg0.Arrow:setTopBottom(0.5, 0.5, -11, 10)
			f9_local0(f9_arg0.Arrow)
			local f9_local1 = function(f11_arg0)
				f9_arg0.Glow21:beginAnimation(140)
				f9_arg0.Glow21:setAlpha(1)
				f9_arg0.Glow21:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.Glow21:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.Glow21:completeAnimation()
			f9_arg0.Glow21:setAlpha(0)
			f9_local1(f9_arg0.Glow21)
			local f9_local2 = function(f12_arg0)
				f9_arg0.Glow2:beginAnimation(140)
				f9_arg0.Glow2:setAlpha(1)
				f9_arg0.Glow2:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.Glow2:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
			end
			f9_arg0.Glow2:completeAnimation()
			f9_arg0.Glow2:setAlpha(0)
			f9_local2(f9_arg0.Glow2)
		end,
	},
}
CoD.GenericClickButton.__onClose = function(f13_arg0)
	f13_arg0.FocusBarB:close()
	f13_arg0.FocusBarT:close()
end
