require("x64:d7ba7c36104672")
require("x64:87edb7802d72c0e")
require("x64:46be910b5a0082a")
CoD.systemOverlay_Compact_Layout = InheritFrom(LUI.UIElement)
CoD.systemOverlay_Compact_Layout.__defaultWidth = 1920
CoD.systemOverlay_Compact_Layout.__defaultHeight = 1080
CoD.systemOverlay_Compact_Layout.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.systemOverlay_Compact_Layout)
	self.id = "systemOverlay_Compact_Layout"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local background = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	background:setRGB(0, 0, 0)
	background:setAlpha(0.9)
	self:addElement(background)
	self.background = background
	local blur = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 273, 575)
	blur:setAlpha(0)
	blur:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	blur:setShaderVector(0, 0.2, 0, 0, 0)
	self:addElement(blur)
	self.blur = blur
	local backing = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 270, 575)
	backing:setRGB(0.19, 0.19, 0.19)
	backing:setAlpha(0.94)
	self:addElement(backing)
	self.backing = backing
	local NoiseTiledBacking = LUI.UIImage.new(0, 1, 0, 0, 0.09, 0.09, 183, 480)
	NoiseTiledBacking:setAlpha(0.65)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local buttonBacking = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, 91, 145)
	buttonBacking:setRGB(0.13, 0.11, 0.12)
	buttonBacking:setAlpha(0)
	self:addElement(buttonBacking)
	self.buttonBacking = buttonBacking
	local frameWidget = LUI.UIFrame.new(f1_arg0, f1_arg1, 0, 0, false)
	frameWidget:setLeftRight(0.5, 0.5, -960, 960)
	frameWidget:setTopBottom(0, 0, 276, 552)
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
	local BlackBarBGTop = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 270, 286)
	BlackBarBGTop:setRGB(0, 0, 0)
	BlackBarBGTop:setAlpha(0.85)
	self:addElement(BlackBarBGTop)
	self.BlackBarBGTop = BlackBarBGTop
	local BlackBarBGBtm = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 562, 578)
	BlackBarBGBtm:setRGB(0, 0, 0)
	BlackBarBGBtm:setAlpha(0.85)
	self:addElement(BlackBarBGBtm)
	self.BlackBarBGBtm = BlackBarBGBtm
	local alertStatusBar2 = CoD.systemOverlay_alertStatusBar.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 572, 578)
	alertStatusBar2:linkToElementModel(self, nil, false, function(model)
		alertStatusBar2:setModel(model, f1_arg1)
	end)
	self:addElement(alertStatusBar2)
	self.alertStatusBar2 = alertStatusBar2
	local alertStatusBar = CoD.systemOverlay_alertStatusBar.new(f1_arg0, f1_arg1, 0, 1, 0, 0, 0, 0, 270, 276)
	alertStatusBar:linkToElementModel(self, nil, false, function(model)
		alertStatusBar:setModel(model, f1_arg1)
	end)
	self:addElement(alertStatusBar)
	self.alertStatusBar = alertStatusBar
	local buttons = CoD.fe_LeftContainer_NOTLobby.new(f1_arg0, f1_arg1, 0.5, 0.5, -358, 290, 0, 0, 517, 565)
	self:addElement(buttons)
	self.buttons = buttons
	self:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
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
CoD.systemOverlay_Compact_Layout.__resetProperties = function(f7_arg0)
	f7_arg0.alertStatusBar:completeAnimation()
	f7_arg0.buttons:completeAnimation()
	f7_arg0.frameWidget:completeAnimation()
	f7_arg0.buttonBacking:completeAnimation()
	f7_arg0.alertStatusBar2:completeAnimation()
	f7_arg0.NoiseTiledBacking:completeAnimation()
	f7_arg0.blur:completeAnimation()
	f7_arg0.backing:completeAnimation()
	f7_arg0.alertStatusBar:setLeftRight(0, 1, 0, 0)
	f7_arg0.alertStatusBar:setTopBottom(0, 0, 270, 276)
	f7_arg0.alertStatusBar:setAlpha(1)
	f7_arg0.buttons:setAlpha(1)
	f7_arg0.frameWidget:setLeftRight(0.5, 0.5, -960, 960)
	f7_arg0.frameWidget:setTopBottom(0, 0, 276, 552)
	f7_arg0.frameWidget:setAlpha(1)
	f7_arg0.buttonBacking:setAlpha(0)
	f7_arg0.alertStatusBar2:setAlpha(1)
	f7_arg0.NoiseTiledBacking:setAlpha(0.65)
	f7_arg0.blur:setAlpha(0)
	f7_arg0.backing:setAlpha(0.94)
end
CoD.systemOverlay_Compact_Layout.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(7)
			local f8_local0 = function(f9_arg0)
				local f9_local0 = function(f10_arg0)
					local f10_local0 = function(f11_arg0)
						f11_arg0:beginAnimation(100)
						f11_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
					end
					f10_arg0:beginAnimation(70)
					f10_arg0:registerEventHandler("transition_complete_keyframe", f10_local0)
				end
				f8_arg0.blur:beginAnimation(30)
				f8_arg0.blur:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.blur:registerEventHandler("transition_complete_keyframe", f9_local0)
			end
			f8_arg0.blur:completeAnimation()
			f8_arg0.blur:setAlpha(0)
			f8_local0(f8_arg0.blur)
			local f8_local1 = function(f12_arg0)
				local f12_local0 = function(f13_arg0)
					local f13_local0 = function(f14_arg0)
						f14_arg0:beginAnimation(100)
						f14_arg0:setAlpha(0.7)
						f14_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
					end
					f13_arg0:beginAnimation(70)
					f13_arg0:setAlpha(0)
					f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
				end
				f8_arg0.NoiseTiledBacking:beginAnimation(30)
				f8_arg0.NoiseTiledBacking:setAlpha(0.7)
				f8_arg0.NoiseTiledBacking:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.NoiseTiledBacking:registerEventHandler("transition_complete_keyframe", f12_local0)
			end
			f8_arg0.NoiseTiledBacking:completeAnimation()
			f8_arg0.NoiseTiledBacking:setAlpha(0)
			f8_local1(f8_arg0.NoiseTiledBacking)
			local f8_local2 = function(f15_arg0)
				f8_arg0.buttonBacking:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f8_arg0.buttonBacking:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.buttonBacking:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.buttonBacking:completeAnimation()
			f8_arg0.buttonBacking:setAlpha(0)
			f8_local2(f8_arg0.buttonBacking)
			local f8_local3 = function(f16_arg0)
				local f16_local0 = function(f17_arg0)
					f17_arg0:beginAnimation(39, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f17_arg0:setAlpha(1)
					f17_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
				end
				f8_arg0.frameWidget:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f8_arg0.frameWidget:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.frameWidget:registerEventHandler("transition_complete_keyframe", f16_local0)
			end
			f8_arg0.frameWidget:completeAnimation()
			f8_arg0.frameWidget:setLeftRight(0.5, 0.5, -960, 960)
			f8_arg0.frameWidget:setTopBottom(0, 0, 276, 552)
			f8_arg0.frameWidget:setAlpha(0)
			f8_local3(f8_arg0.frameWidget)
			local f8_local4 = function(f18_arg0)
				local f18_local0 = function(f19_arg0)
					local f19_local0 = function(f20_arg0)
						f20_arg0:beginAnimation(100)
						f20_arg0:setAlpha(1)
						f20_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
					end
					f19_arg0:beginAnimation(70)
					f19_arg0:setAlpha(0)
					f19_arg0:registerEventHandler("transition_complete_keyframe", f19_local0)
				end
				f8_arg0.alertStatusBar2:beginAnimation(30)
				f8_arg0.alertStatusBar2:setAlpha(1)
				f8_arg0.alertStatusBar2:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.alertStatusBar2:registerEventHandler("transition_complete_keyframe", f18_local0)
			end
			f8_arg0.alertStatusBar2:completeAnimation()
			f8_arg0.alertStatusBar2:setAlpha(0)
			f8_local4(f8_arg0.alertStatusBar2)
			local f8_local5 = function(f21_arg0)
				local f21_local0 = function(f22_arg0)
					local f22_local0 = function(f23_arg0)
						f23_arg0:beginAnimation(100)
						f23_arg0:setTopBottom(0, 0, 270, 276)
						f23_arg0:setAlpha(1)
						f23_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
					end
					f22_arg0:beginAnimation(70)
					f22_arg0:setTopBottom(0, 0, 265.88, 271.88)
					f22_arg0:setAlpha(0)
					f22_arg0:registerEventHandler("transition_complete_keyframe", f22_local0)
				end
				f8_arg0.alertStatusBar:beginAnimation(30, Enum[0xF50FFF429AB1890][0x53CEB9A0427197])
				f8_arg0.alertStatusBar:setTopBottom(0, 0, 263, 269)
				f8_arg0.alertStatusBar:setAlpha(1)
				f8_arg0.alertStatusBar:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.alertStatusBar:registerEventHandler("transition_complete_keyframe", f21_local0)
			end
			f8_arg0.alertStatusBar:completeAnimation()
			f8_arg0.alertStatusBar:setLeftRight(0, 1, 0, 0)
			f8_arg0.alertStatusBar:setTopBottom(0, 0, -105, -99)
			f8_arg0.alertStatusBar:setAlpha(0)
			f8_local5(f8_arg0.alertStatusBar)
			local f8_local6 = function(f24_arg0)
				local f24_local0 = function(f25_arg0)
					f25_arg0:beginAnimation(39, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
					f25_arg0:setAlpha(1)
					f25_arg0:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
				end
				f8_arg0.buttons:beginAnimation(200, Enum[0xF50FFF429AB1890][0x5193EA7825DC097])
				f8_arg0.buttons:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.buttons:registerEventHandler("transition_complete_keyframe", f24_local0)
			end
			f8_arg0.buttons:completeAnimation()
			f8_arg0.buttons:setAlpha(0)
			f8_local6(f8_arg0.buttons)
		end,
	},
	PC = {
		DefaultClip = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(8)
			f26_arg0.blur:completeAnimation()
			f26_arg0.blur:setAlpha(0)
			f26_arg0.clipFinished(f26_arg0.blur)
			local f26_local0 = function(f27_arg0)
				local f27_local0 = function(f28_arg0)
					local f28_local0 = function(f29_arg0)
						local f29_local0 = function(f30_arg0)
							f30_arg0:beginAnimation(39)
							f30_arg0:setAlpha(0.15)
							f30_arg0:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
						end
						f29_arg0:beginAnimation(100)
						f29_arg0:registerEventHandler("transition_complete_keyframe", f29_local0)
					end
					f28_arg0:beginAnimation(70)
					f28_arg0:setAlpha(0)
					f28_arg0:registerEventHandler("transition_complete_keyframe", f28_local0)
				end
				f26_arg0.backing:beginAnimation(30)
				f26_arg0.backing:setAlpha(0.15)
				f26_arg0.backing:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.backing:registerEventHandler("transition_complete_keyframe", f27_local0)
			end
			f26_arg0.backing:completeAnimation()
			f26_arg0.backing:setAlpha(0)
			f26_local0(f26_arg0.backing)
			local f26_local1 = function(f31_arg0)
				local f31_local0 = function(f32_arg0)
					local f32_local0 = function(f33_arg0)
						f33_arg0:beginAnimation(100)
						f33_arg0:setAlpha(0.7)
						f33_arg0:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
					end
					f32_arg0:beginAnimation(70)
					f32_arg0:setAlpha(0)
					f32_arg0:registerEventHandler("transition_complete_keyframe", f32_local0)
				end
				f26_arg0.NoiseTiledBacking:beginAnimation(30)
				f26_arg0.NoiseTiledBacking:setAlpha(0.7)
				f26_arg0.NoiseTiledBacking:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.NoiseTiledBacking:registerEventHandler("transition_complete_keyframe", f31_local0)
			end
			f26_arg0.NoiseTiledBacking:completeAnimation()
			f26_arg0.NoiseTiledBacking:setAlpha(0)
			f26_local1(f26_arg0.NoiseTiledBacking)
			local f26_local2 = function(f34_arg0)
				f26_arg0.buttonBacking:beginAnimation(200)
				f26_arg0.buttonBacking:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.buttonBacking:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.buttonBacking:completeAnimation()
			f26_arg0.buttonBacking:setAlpha(0)
			f26_local2(f26_arg0.buttonBacking)
			local f26_local3 = function(f35_arg0)
				local f35_local0 = function(f36_arg0)
					f36_arg0:beginAnimation(39)
					f36_arg0:setTopBottom(0, 0, 276, 552)
					f36_arg0:setAlpha(1)
					f36_arg0:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
				end
				f26_arg0.frameWidget:beginAnimation(200)
				f26_arg0.frameWidget:setTopBottom(0, 0, 275.83, 551.83)
				f26_arg0.frameWidget:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.frameWidget:registerEventHandler("transition_complete_keyframe", f35_local0)
			end
			f26_arg0.frameWidget:completeAnimation()
			f26_arg0.frameWidget:setLeftRight(0.5, 0.5, -960, 960)
			f26_arg0.frameWidget:setTopBottom(0, 0, 275, 551)
			f26_arg0.frameWidget:setAlpha(0)
			f26_local3(f26_arg0.frameWidget)
			local f26_local4 = function(f37_arg0)
				local f37_local0 = function(f38_arg0)
					local f38_local0 = function(f39_arg0)
						f39_arg0:beginAnimation(100)
						f39_arg0:setAlpha(1)
						f39_arg0:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
					end
					f38_arg0:beginAnimation(70)
					f38_arg0:setAlpha(0)
					f38_arg0:registerEventHandler("transition_complete_keyframe", f38_local0)
				end
				f26_arg0.alertStatusBar2:beginAnimation(30)
				f26_arg0.alertStatusBar2:setAlpha(1)
				f26_arg0.alertStatusBar2:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.alertStatusBar2:registerEventHandler("transition_complete_keyframe", f37_local0)
			end
			f26_arg0.alertStatusBar2:completeAnimation()
			f26_arg0.alertStatusBar2:setAlpha(0)
			f26_local4(f26_arg0.alertStatusBar2)
			local f26_local5 = function(f40_arg0)
				local f40_local0 = function(f41_arg0)
					local f41_local0 = function(f42_arg0)
						f42_arg0:beginAnimation(100)
						f42_arg0:setAlpha(1)
						f42_arg0:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
					end
					f41_arg0:beginAnimation(70)
					f41_arg0:setAlpha(0)
					f41_arg0:registerEventHandler("transition_complete_keyframe", f41_local0)
				end
				f26_arg0.alertStatusBar:beginAnimation(30)
				f26_arg0.alertStatusBar:setAlpha(1)
				f26_arg0.alertStatusBar:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.alertStatusBar:registerEventHandler("transition_complete_keyframe", f40_local0)
			end
			f26_arg0.alertStatusBar:completeAnimation()
			f26_arg0.alertStatusBar:setAlpha(0)
			f26_local5(f26_arg0.alertStatusBar)
			local f26_local6 = function(f43_arg0)
				local f43_local0 = function(f44_arg0)
					f44_arg0:beginAnimation(39)
					f44_arg0:setAlpha(1)
					f44_arg0:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
				end
				f26_arg0.buttons:beginAnimation(200)
				f26_arg0.buttons:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.buttons:registerEventHandler("transition_complete_keyframe", f43_local0)
			end
			f26_arg0.buttons:completeAnimation()
			f26_arg0.buttons:setAlpha(0)
			f26_local6(f26_arg0.buttons)
		end,
	},
}
CoD.systemOverlay_Compact_Layout.__onClose = function(f45_arg0)
	f45_arg0.frameWidget:close()
	f45_arg0.alertStatusBar2:close()
	f45_arg0.alertStatusBar:close()
	f45_arg0.buttons:close()
end
