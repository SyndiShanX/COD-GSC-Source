require("ui/uieditor/widgets/footer/fe_leftcontainer_notlobby")
require("ui/uieditor/widgets/menuspecificwidgets/scorestreaks/scorestreakvignettecontainer")
require("ui/uieditor/widgets/systemoverlays/systemoverlay_alertstatusbar")
require("ui/uieditor/widgets/systemoverlays/systemoverlay_freecursor_full_basicframe")
CoD.systemOverlay_FreeCursor_Full_Layout = InheritFrom(LUI.UIElement)
CoD.systemOverlay_FreeCursor_Full_Layout.__defaultWidth = 1920
CoD.systemOverlay_FreeCursor_Full_Layout.__defaultHeight = 1080
CoD.systemOverlay_FreeCursor_Full_Layout.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.systemOverlay_FreeCursor_Full_Layout)
	self.id = "systemOverlay_FreeCursor_Full_Layout"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local darkbg = LUI.UIImage.new(0, 1, 4, 0, 0, 1, -30, 0)
	darkbg:setRGB(0, 0, 0)
	darkbg:setAlpha(0.8)
	self:addElement(darkbg)
	self.darkbg = darkbg
	local blur = LUI.UIImage.new(0, 0, 0, 1920, 0, 0, 277, 759)
	blur:setAlpha(0)
	blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(blur)
	self.blur = blur
	local backing = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 273, 759)
	backing:setRGB(0.19, 0.19, 0.19)
	backing:setAlpha(0.7)
	self:addElement(backing)
	self.backing = backing
	local NoiseTiledBacking = LUI.UIImage.new(0, 0, 0, 1920, 0.09, 0.09, 184, 667)
	NoiseTiledBacking:setAlpha(0.65)
	NoiseTiledBacking:setImage(RegisterImage("uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local buttonBacking = LUI.UIImage.new(0, 1, 0, 0, 1, 1, -321, -273)
	buttonBacking:setRGB(0.13, 0.11, 0.12)
	buttonBacking:setAlpha(0)
	self:addElement(buttonBacking)
	self.buttonBacking = buttonBacking
	local scorestreakVignetteContainer = CoD.scorestreakVignetteContainer.new(f1_arg0, f1_arg1, 0, 1, 4, 0, 0, 1, 0, 0)
	scorestreakVignetteContainer:setAlpha(0)
	self:addElement(scorestreakVignetteContainer)
	self.scorestreakVignetteContainer = scorestreakVignetteContainer
	local BlackBarBGTop = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 271, 287)
	BlackBarBGTop:setRGB(0, 0, 0)
	BlackBarBGTop:setAlpha(0.85)
	self:addElement(BlackBarBGTop)
	self.BlackBarBGTop = BlackBarBGTop
	local BlackBarBGBtm = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 745, 761)
	BlackBarBGBtm:setRGB(0, 0, 0)
	BlackBarBGBtm:setAlpha(0.85)
	self:addElement(BlackBarBGBtm)
	self.BlackBarBGBtm = BlackBarBGBtm
	local frameWidget = LUI.UIFrame.new(f1_arg0, f1_arg1, 0, 0, false)
	frameWidget:setLeftRight(0.5, 0.5, -960, 960)
	frameWidget:setTopBottom(0, 0, 276, 756)
	frameWidget:linkToElementModel(self, nil, false, function(model)
		frameWidget:setModel(model, f1_arg1)
	end)
	frameWidget:linkToElementModel(self, "frameWidget", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			frameWidget:changeFrameWidget(f3_local0)
		end
	end)
	self:addElement(frameWidget)
	self.frameWidget = frameWidget
	local alertStatusBar = CoD.systemOverlay_alertStatusBar.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 270, 276)
	alertStatusBar:linkToElementModel(self, nil, false, function(model)
		alertStatusBar:setModel(model, f1_arg1)
	end)
	self:addElement(alertStatusBar)
	self.alertStatusBar = alertStatusBar
	local alertStatusBar2 = CoD.systemOverlay_alertStatusBar.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 756, 762)
	alertStatusBar2:linkToElementModel(self, nil, false, function(model)
		alertStatusBar2:setModel(model, f1_arg1)
	end)
	self:addElement(alertStatusBar2)
	self.alertStatusBar2 = alertStatusBar2
	local buttons = CoD.fe_LeftContainer_NOTLobby.new(f1_arg0, f1_arg1, 0, 0, 614, 1262, 1, 1, -373, -325)
	self:addElement(buttons)
	self.buttons = buttons
	frameWidget.id = "frameWidget"
	if CoD.isPC then
		buttons.id = "buttons"
	end
	self.__defaultFocus = frameWidget
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.systemOverlay_FreeCursor_Full_Layout.__resetProperties = function(f6_arg0)
	f6_arg0.frameWidget:completeAnimation()
	f6_arg0.buttonBacking:completeAnimation()
	f6_arg0.buttons:completeAnimation()
	f6_arg0.alertStatusBar:completeAnimation()
	f6_arg0.darkbg:completeAnimation()
	f6_arg0.scorestreakVignetteContainer:completeAnimation()
	f6_arg0.NoiseTiledBacking:completeAnimation()
	f6_arg0.backing:completeAnimation()
	f6_arg0.blur:completeAnimation()
	f6_arg0.alertStatusBar2:completeAnimation()
	f6_arg0.BlackBarBGBtm:completeAnimation()
	f6_arg0.BlackBarBGTop:completeAnimation()
	f6_arg0.frameWidget:setAlpha(1)
	f6_arg0.buttonBacking:setAlpha(0)
	f6_arg0.buttons:setAlpha(1)
	f6_arg0.alertStatusBar:setLeftRight(0, 1, 0, 0)
	f6_arg0.alertStatusBar:setTopBottom(0, 0, 270, 276)
	f6_arg0.alertStatusBar:setAlpha(1)
	f6_arg0.darkbg:setAlpha(0.8)
	f6_arg0.scorestreakVignetteContainer:setAlpha(0)
	f6_arg0.NoiseTiledBacking:setAlpha(0.65)
	f6_arg0.backing:setAlpha(0.7)
	f6_arg0.blur:setAlpha(0)
	f6_arg0.alertStatusBar2:setTopBottom(0, 0, 756, 762)
	f6_arg0.alertStatusBar2:setAlpha(1)
	f6_arg0.BlackBarBGBtm:setAlpha(0.85)
	f6_arg0.BlackBarBGTop:setAlpha(0.85)
end
CoD.systemOverlay_FreeCursor_Full_Layout.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(12)
			local f7_local0 = function(f8_arg0)
				local f8_local0 = function(f9_arg0)
					f9_arg0:beginAnimation(30)
					f9_arg0:setAlpha(0.85)
					f9_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
				end
				f7_arg0.darkbg:beginAnimation(40)
				f7_arg0.darkbg:setAlpha(0.75)
				f7_arg0.darkbg:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.darkbg:registerEventHandler("transition_complete_keyframe", f8_local0)
			end
			f7_arg0.darkbg:completeAnimation()
			f7_arg0.darkbg:setAlpha(0)
			f7_local0(f7_arg0.darkbg)
			local f7_local1 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					f11_arg0:beginAnimation(30)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
				end
				f7_arg0.blur:beginAnimation(40)
				f7_arg0.blur:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.blur:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f7_arg0.blur:completeAnimation()
			f7_arg0.blur:setAlpha(0)
			f7_local1(f7_arg0.blur)
			local f7_local2 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					f13_arg0:beginAnimation(30)
					f13_arg0:setAlpha(0.7)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
				end
				f7_arg0.backing:beginAnimation(40)
				f7_arg0.backing:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.backing:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f7_arg0.backing:completeAnimation()
			f7_arg0.backing:setAlpha(0.01)
			f7_local2(f7_arg0.backing)
			local f7_local3 = function(f14_arg0)
				local f14_local0 = function(f15_arg0)
					f15_arg0:beginAnimation(30)
					f15_arg0:setAlpha(0.65)
					f15_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
				end
				f7_arg0.NoiseTiledBacking:beginAnimation(40)
				f7_arg0.NoiseTiledBacking:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.NoiseTiledBacking:registerEventHandler("transition_complete_keyframe", f14_local0)
			end
			f7_arg0.NoiseTiledBacking:completeAnimation()
			f7_arg0.NoiseTiledBacking:setAlpha(0)
			f7_local3(f7_arg0.NoiseTiledBacking)
			local f7_local4 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					f17_arg0:beginAnimation(30)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
				end
				f7_arg0.buttonBacking:beginAnimation(70)
				f7_arg0.buttonBacking:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.buttonBacking:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f7_arg0.buttonBacking:completeAnimation()
			f7_arg0.buttonBacking:setAlpha(0)
			f7_local4(f7_arg0.buttonBacking)
			local f7_local5 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					f19_arg0:beginAnimation(30)
					f19_arg0:setAlpha(1)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
				end
				f7_arg0.scorestreakVignetteContainer:beginAnimation(40)
				f7_arg0.scorestreakVignetteContainer:setAlpha(0.5)
				f7_arg0.scorestreakVignetteContainer:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.scorestreakVignetteContainer:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f7_arg0.scorestreakVignetteContainer:completeAnimation()
			f7_arg0.scorestreakVignetteContainer:setAlpha(0)
			f7_local5(f7_arg0.scorestreakVignetteContainer)
			local f7_local6 = function(f20_arg0)
				f7_arg0.BlackBarBGTop:beginAnimation(70)
				f7_arg0.BlackBarBGTop:setAlpha(0.85)
				f7_arg0.BlackBarBGTop:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.BlackBarBGTop:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.BlackBarBGTop:completeAnimation()
			f7_arg0.BlackBarBGTop:setAlpha(0)
			f7_local6(f7_arg0.BlackBarBGTop)
			local f7_local7 = function(f21_arg0)
				f7_arg0.BlackBarBGBtm:beginAnimation(70)
				f7_arg0.BlackBarBGBtm:setAlpha(0.85)
				f7_arg0.BlackBarBGBtm:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.BlackBarBGBtm:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.BlackBarBGBtm:completeAnimation()
			f7_arg0.BlackBarBGBtm:setAlpha(0)
			f7_local7(f7_arg0.BlackBarBGBtm)
			local f7_local8 = function(f22_arg0)
				local f22_local0 = function(f23_arg0)
					local f23_local0 = function(f24_arg0)
						local f24_local0 = function(f25_arg0)
							local f25_local0 = function(f26_arg0)
								f26_arg0:beginAnimation(9, Enum[@"luitween"][@"luitween_ease_both"])
								f26_arg0:setAlpha(1)
								f26_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
							end
							f25_arg0:beginAnimation(10, Enum[@"luitween"][@"luitween_ease_out"])
							f25_arg0:setAlpha(0)
							f25_arg0:registerEventHandler("transition_complete_keyframe", f25_local0)
						end
						f24_arg0:beginAnimation(9, Enum[@"luitween"][@"luitween_ease_out"])
						f24_arg0:setAlpha(1)
						f24_arg0:registerEventHandler("transition_complete_keyframe", f24_local0)
					end
					f23_arg0:beginAnimation(30)
					f23_arg0:registerEventHandler("transition_complete_keyframe", f23_local0)
				end
				f7_arg0.frameWidget:beginAnimation(40)
				f7_arg0.frameWidget:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.frameWidget:registerEventHandler("transition_complete_keyframe", f22_local0)
			end
			f7_arg0.frameWidget:completeAnimation()
			f7_arg0.frameWidget:setAlpha(0)
			f7_local8(f7_arg0.frameWidget)
			local f7_local9 = function(f27_arg0)
				local f27_local0 = function(f28_arg0)
					f28_arg0:beginAnimation(30)
					f28_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
				end
				f7_arg0.alertStatusBar:beginAnimation(70, Enum[@"luitween"][@"luitween_ease_in"])
				f7_arg0.alertStatusBar:setTopBottom(0, 0, 270, 276)
				f7_arg0.alertStatusBar:setAlpha(1)
				f7_arg0.alertStatusBar:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.alertStatusBar:registerEventHandler("transition_complete_keyframe", f27_local0)
			end
			f7_arg0.alertStatusBar:completeAnimation()
			f7_arg0.alertStatusBar:setLeftRight(0, 1, 0, 0)
			f7_arg0.alertStatusBar:setTopBottom(0, 0, -18, -12)
			f7_arg0.alertStatusBar:setAlpha(0)
			f7_local9(f7_arg0.alertStatusBar)
			local f7_local10 = function(f29_arg0)
				f7_arg0.alertStatusBar2:beginAnimation(70)
				f7_arg0.alertStatusBar2:setTopBottom(0, 0, 755, 761)
				f7_arg0.alertStatusBar2:setAlpha(1)
				f7_arg0.alertStatusBar2:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.alertStatusBar2:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.alertStatusBar2:completeAnimation()
			f7_arg0.alertStatusBar2:setTopBottom(0, 0, 876, 882)
			f7_arg0.alertStatusBar2:setAlpha(0)
			f7_local10(f7_arg0.alertStatusBar2)
			local f7_local11 = function(f30_arg0)
				local f30_local0 = function(f31_arg0)
					local f31_local0 = function(f32_arg0)
						f32_arg0:beginAnimation(30)
						f32_arg0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
					end
					f31_arg0:beginAnimation(30)
					f31_arg0:setAlpha(1)
					f31_arg0:registerEventHandler("transition_complete_keyframe", f31_local0)
				end
				f7_arg0.buttons:beginAnimation(40)
				f7_arg0.buttons:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.buttons:registerEventHandler("transition_complete_keyframe", f30_local0)
			end
			f7_arg0.buttons:completeAnimation()
			f7_arg0.buttons:setAlpha(0)
			f7_local11(f7_arg0.buttons)
		end,
	},
}
CoD.systemOverlay_FreeCursor_Full_Layout.__onClose = function(f33_arg0)
	f33_arg0.scorestreakVignetteContainer:close()
	f33_arg0.frameWidget:close()
	f33_arg0.alertStatusBar:close()
	f33_arg0.alertStatusBar2:close()
	f33_arg0.buttons:close()
end
