CoD.LeftStickPagination = InheritFrom(LUI.UIElement)
CoD.LeftStickPagination.__defaultWidth = 80
CoD.LeftStickPagination.__defaultHeight = 30
CoD.LeftStickPagination.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LeftStickPagination)
	self.id = "LeftStickPagination"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local LeftLine = LUI.UIImage.new(0, 0.5, -13, -27, 0, 0, 13, 16)
	self:addElement(LeftLine)
	self.LeftLine = LeftLine
	local RightLine = LUI.UIImage.new(0.5, 1, 27, 13, 0, 0, 13, 16)
	self:addElement(RightLine)
	self.RightLine = RightLine
	local RightStickNoArrows = LUI.UIImage.new(0.5, 0.5, -12, 12, 0, 0, 4, 28)
	RightStickNoArrows:setImage(RegisterImage(0xEF50552ABDEFC62))
	self:addElement(RightStickNoArrows)
	self.RightStickNoArrows = RightStickNoArrows
	local KBMArrowIcon = nil
	KBMArrowIcon = LUI.UIImage.new(0.5, 0.5, -16, 15, 0, 0, -1, 30)
	KBMArrowIcon:setAlpha(0)
	KBMArrowIcon:setImage(RegisterImage(0x8EB901AAE424A2B))
	self:addElement(KBMArrowIcon)
	self.KBMArrowIcon = KBMArrowIcon
	local ArrowLeft01 = LUI.UIImage.new(0.5, 0.5, -21, -9, 0, 0, 2.5, 26.5)
	ArrowLeft01:setAlpha(0)
	ArrowLeft01:setImage(RegisterImage(0xDFF31298BAE91D7))
	ArrowLeft01:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	ArrowLeft01:setShaderVector(0, 0, 1, 0, 0)
	ArrowLeft01:setShaderVector(1, 0, 0, 0, 0)
	ArrowLeft01:setShaderVector(2, 0, 1, 0, 0)
	ArrowLeft01:setShaderVector(3, 0, 0, 0, 0)
	ArrowLeft01:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(ArrowLeft01)
	self.ArrowLeft01 = ArrowLeft01
	local ArrowRight01 = LUI.UIImage.new(0.5, 0.5, 7, 19, 0, 0, 2.5, 26.5)
	ArrowRight01:setAlpha(0)
	ArrowRight01:setYRot(180)
	ArrowRight01:setImage(RegisterImage(0xDFF31298BAE91D7))
	ArrowRight01:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	ArrowRight01:setShaderVector(0, 0, 1, 0, 0)
	ArrowRight01:setShaderVector(1, 0, 0, 0, 0)
	ArrowRight01:setShaderVector(2, 0.01, 1, 0, 0)
	ArrowRight01:setShaderVector(3, 0, 0, 0, 0)
	ArrowRight01:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(ArrowRight01)
	self.ArrowRight01 = ArrowRight01
	self:mergeStateConditions({
		{
			stateName = "KBM",
			condition = function(menu, element, event)
				return IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "Gamepad",
			condition = function(menu, element, event)
				return IsGamepad(f1_arg1)
			end,
		},
	})
	self:appendEventHandler("input_source_changed", function(f4_arg0, f4_arg1)
		f4_arg1.menu = f4_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f4_arg1)
	end)
	local f1_local7 = self
	local f1_local8 = self.subscribeToModel
	local f1_local9 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local8(f1_local7, f1_local9.LastInput, function(f5_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f5_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LeftStickPagination.__resetProperties = function(f6_arg0)
	f6_arg0.KBMArrowIcon:completeAnimation()
	f6_arg0.RightStickNoArrows:completeAnimation()
	f6_arg0.RightLine:completeAnimation()
	f6_arg0.LeftLine:completeAnimation()
	f6_arg0.ArrowLeft01:completeAnimation()
	f6_arg0.ArrowRight01:completeAnimation()
	f6_arg0.KBMArrowIcon:setAlpha(0)
	f6_arg0.RightStickNoArrows:setAlpha(1)
	f6_arg0.RightLine:setLeftRight(0.5, 1, 27, 13)
	f6_arg0.RightLine:setTopBottom(0, 0, 13, 16)
	f6_arg0.LeftLine:setLeftRight(0, 0.5, -13, -27)
	f6_arg0.ArrowLeft01:setLeftRight(0.5, 0.5, -21, -9)
	f6_arg0.ArrowLeft01:setTopBottom(0, 0, 2.5, 26.5)
	f6_arg0.ArrowLeft01:setAlpha(0)
	f6_arg0.ArrowLeft01:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	f6_arg0.ArrowLeft01:setShaderVector(0, 0, 1, 0, 0)
	f6_arg0.ArrowLeft01:setShaderVector(1, 0, 0, 0, 0)
	f6_arg0.ArrowLeft01:setShaderVector(2, 0, 1, 0, 0)
	f6_arg0.ArrowLeft01:setShaderVector(3, 0, 0, 0, 0)
	f6_arg0.ArrowLeft01:setShaderVector(4, 0, 0, 0, 0)
	f6_arg0.ArrowRight01:setLeftRight(0.5, 0.5, 7, 19)
	f6_arg0.ArrowRight01:setTopBottom(0, 0, 2.5, 26.5)
	f6_arg0.ArrowRight01:setAlpha(0)
	f6_arg0.ArrowRight01:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	f6_arg0.ArrowRight01:setShaderVector(0, 0, 1, 0, 0)
	f6_arg0.ArrowRight01:setShaderVector(1, 0, 0, 0, 0)
	f6_arg0.ArrowRight01:setShaderVector(2, 0.01, 1, 0, 0)
	f6_arg0.ArrowRight01:setShaderVector(3, 0, 0, 0, 0)
	f6_arg0.ArrowRight01:setShaderVector(4, 0, 0, 0, 0)
end
CoD.LeftStickPagination.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	KBM = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(4)
			f8_arg0.LeftLine:completeAnimation()
			f8_arg0.LeftLine:setLeftRight(0, 0.84, -13, -27)
			f8_arg0.clipFinished(f8_arg0.LeftLine)
			f8_arg0.RightLine:completeAnimation()
			f8_arg0.RightLine:setLeftRight(0.16, 1, 27, 13)
			f8_arg0.RightLine:setTopBottom(0, 0, 13, 16)
			f8_arg0.clipFinished(f8_arg0.RightLine)
			f8_arg0.RightStickNoArrows:completeAnimation()
			f8_arg0.RightStickNoArrows:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.RightStickNoArrows)
			f8_arg0.KBMArrowIcon:completeAnimation()
			f8_arg0.KBMArrowIcon:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.KBMArrowIcon)
		end,
	},
	Gamepad = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(3)
			f9_arg0.KBMArrowIcon:completeAnimation()
			f9_arg0.KBMArrowIcon:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.KBMArrowIcon)
			local f9_local0 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					local f11_local0 = function(f12_arg0)
						local f12_local0 = function(f13_arg0)
							local f13_local0 = function(f14_arg0)
								f14_arg0:beginAnimation(500)
								f14_arg0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
							end
							f13_arg0:beginAnimation(600, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
							f13_arg0:setLeftRight(0.5, 0.5, -27, -15)
							f13_arg0:setAlpha(0)
							f13_arg0:registerEventHandler("transition_complete_keyframe", f13_local0)
						end
						f12_arg0:beginAnimation(349)
						f12_arg0:setLeftRight(0.5, 0.5, -23, -11)
						f12_arg0:setAlpha(0.55)
						f12_arg0:registerEventHandler("transition_complete_keyframe", f12_local0)
					end
					f11_arg0:beginAnimation(150)
					f11_arg0:setLeftRight(0.5, 0.5, -21.38, -9.38)
					f11_arg0:setAlpha(0.86)
					f11_arg0:setShaderVector(2, 0.01, 1, 0, 0)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f11_local0)
				end
				f9_arg0.ArrowLeft01:beginAnimation(150)
				f9_arg0.ArrowLeft01:setLeftRight(0.5, 0.5, -20.69, -8.69)
				f9_arg0.ArrowLeft01:setAlpha(1)
				f9_arg0.ArrowLeft01:setShaderVector(2, 0.26, 0.75, 0, 0)
				f9_arg0.ArrowLeft01:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.ArrowLeft01:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f9_arg0.ArrowLeft01:completeAnimation()
			f9_arg0.ArrowLeft01:setLeftRight(0.5, 0.5, -20, -8)
			f9_arg0.ArrowLeft01:setTopBottom(0, 0, 2.5, 26.5)
			f9_arg0.ArrowLeft01:setAlpha(0)
			f9_arg0.ArrowLeft01:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
			f9_arg0.ArrowLeft01:setShaderVector(0, 0, 1, 0, 0)
			f9_arg0.ArrowLeft01:setShaderVector(1, 0, 0, 0, 0)
			f9_arg0.ArrowLeft01:setShaderVector(2, 0.5, 0.51, 0, 0)
			f9_arg0.ArrowLeft01:setShaderVector(3, 0, 0, 0, 0)
			f9_arg0.ArrowLeft01:setShaderVector(4, 0, 0, 0, 0)
			f9_local0(f9_arg0.ArrowLeft01)
			local f9_local1 = function(f15_arg0)
				local f15_local0 = function(f16_arg0)
					local f16_local0 = function(f17_arg0)
						local f17_local0 = function(f18_arg0)
							local f18_local0 = function(f19_arg0)
								f19_arg0:beginAnimation(500)
								f19_arg0:registerEventHandler("transition_complete_keyframe", f9_arg0.clipFinished)
							end
							f18_arg0:beginAnimation(600, Enum[0xF50FFF429AB1890][0x6F6186B702830BC])
							f18_arg0:setLeftRight(0.5, 0.5, 15, 27)
							f18_arg0:setAlpha(0)
							f18_arg0:registerEventHandler("transition_complete_keyframe", f18_local0)
						end
						f17_arg0:beginAnimation(349)
						f17_arg0:setLeftRight(0.5, 0.5, 11, 23)
						f17_arg0:setAlpha(0.55)
						f17_arg0:registerEventHandler("transition_complete_keyframe", f17_local0)
					end
					f16_arg0:beginAnimation(150)
					f16_arg0:setLeftRight(0.5, 0.5, 9.38, 21.38)
					f16_arg0:setAlpha(0.86)
					f16_arg0:setShaderVector(2, 0.01, 1, 0, 0)
					f16_arg0:registerEventHandler("transition_complete_keyframe", f16_local0)
				end
				f9_arg0.ArrowRight01:beginAnimation(150)
				f9_arg0.ArrowRight01:setLeftRight(0.5, 0.5, 8.69, 20.69)
				f9_arg0.ArrowRight01:setAlpha(1)
				f9_arg0.ArrowRight01:setShaderVector(2, 0.26, 0.75, 0, 0)
				f9_arg0.ArrowRight01:registerEventHandler("interrupted_keyframe", f9_arg0.clipInterrupted)
				f9_arg0.ArrowRight01:registerEventHandler("transition_complete_keyframe", f15_local0)
			end
			f9_arg0.ArrowRight01:completeAnimation()
			f9_arg0.ArrowRight01:setLeftRight(0.5, 0.5, 8, 20)
			f9_arg0.ArrowRight01:setTopBottom(0, 0, 2.5, 26.5)
			f9_arg0.ArrowRight01:setAlpha(0)
			f9_arg0.ArrowRight01:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
			f9_arg0.ArrowRight01:setShaderVector(0, 0, 1, 0, 0)
			f9_arg0.ArrowRight01:setShaderVector(1, 0, 0, 0, 0)
			f9_arg0.ArrowRight01:setShaderVector(2, 0.5, 0.51, 0, 0)
			f9_arg0.ArrowRight01:setShaderVector(3, 0, 0, 0, 0)
			f9_arg0.ArrowRight01:setShaderVector(4, 0, 0, 0, 0)
			f9_local1(f9_arg0.ArrowRight01)
			f9_arg0.nextClip = "DefaultClip"
		end,
	},
}
