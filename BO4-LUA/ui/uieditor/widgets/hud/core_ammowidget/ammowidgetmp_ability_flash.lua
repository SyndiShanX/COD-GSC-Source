CoD.AmmoWidgetMP_Ability_Flash = InheritFrom(LUI.UIElement)
CoD.AmmoWidgetMP_Ability_Flash.__defaultWidth = 68
CoD.AmmoWidgetMP_Ability_Flash.__defaultHeight = 59
CoD.AmmoWidgetMP_Ability_Flash.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AmmoWidgetMP_Ability_Flash)
	self.id = "AmmoWidgetMP_Ability_Flash"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Line = LUI.UIImage.new(0, 0, 0.5, 108.5, 0, 0, 47, 44)
	Line:setAlpha(0)
	self:addElement(Line)
	self.Line = Line
	local Backing = LUI.UIImage.new(0, 0, -17, 82, 0, 0, -14, 81)
	Backing:setRGB(0.89, 0.89, 0.89)
	Backing:setAlpha(0)
	Backing:setZRot(180)
	Backing:setImage(RegisterImage(0x7B36897EA2EA839))
	Backing:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Backing)
	self.Backing = Backing
	local scanline = LUI.UIImage.new(0, 0, -1, 65, 0, 0, 20, 48)
	scanline:setRGB(0.8, 0.8, 0.8)
	scanline:setAlpha(0)
	scanline:setImage(RegisterImage(0xB905E625E84E15))
	scanline:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(scanline)
	self.scanline = scanline
	local Mask3 = LUI.UIImage.new(0.5, 0.5, -63, 63, 0, 0, 63, 94)
	Mask3:setRGB(0, 0, 0)
	self:addElement(Mask3)
	self.Mask3 = Mask3
	local Mask4 = LUI.UIImage.new(1, 1, 1, 29, 0, 0, 0, 63)
	Mask4:setRGB(0, 0, 0)
	self:addElement(Mask4)
	self.Mask4 = Mask4
	local Mask2 = LUI.UIImage.new(0, 0, -29, 1, 0, 0, 0, 63)
	Mask2:setRGB(0, 0, 0)
	self:addElement(Mask2)
	self.Mask2 = Mask2
	local Mask = LUI.UIImage.new(0.5, 0.5, -63, 63, 0, 0, -31, 0)
	Mask:setRGB(0, 0, 0)
	self:addElement(Mask)
	self.Mask = Mask
	self:mergeStateConditions({
		{
			stateName = "Full",
			condition = function(menu, element, event)
				return CoD.HUDUtility.AbilityFlashIsFull(element, f1_arg1)
			end,
		},
		{
			stateName = "Deployed",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualToEnum(self, f1_arg1, "state", Enum[0xF0447219F15F7F3][0x1873A43E9D1620E])
			end,
		},
	})
	self:linkToElementModel(self, "state", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "state",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AmmoWidgetMP_Ability_Flash.__resetProperties = function(f5_arg0)
	f5_arg0.Line:completeAnimation()
	f5_arg0.Backing:completeAnimation()
	f5_arg0.scanline:completeAnimation()
	f5_arg0.Line:setLeftRight(0, 0, 0.5, 108.5)
	f5_arg0.Line:setTopBottom(0, 0, 47, 44)
	f5_arg0.Line:setAlpha(0)
	f5_arg0.Backing:setLeftRight(0, 0, -17, 82)
	f5_arg0.Backing:setTopBottom(0, 0, -14, 81)
	f5_arg0.Backing:setAlpha(0)
	f5_arg0.scanline:setLeftRight(0, 0, -1, 65)
	f5_arg0.scanline:setTopBottom(0, 0, 20, 48)
	f5_arg0.scanline:setAlpha(0)
end
CoD.AmmoWidgetMP_Ability_Flash.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(3)
			f6_arg0.Line:completeAnimation()
			f6_arg0.Line:setLeftRight(0, 0, 1.5, 105.5)
			f6_arg0.Line:setTopBottom(0, 0, 47, 44)
			f6_arg0.Line:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Line)
			local f6_local0 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					local f8_local0 = function(f9_arg0)
						f9_arg0:beginAnimation(720)
						f9_arg0:setAlpha(0)
						f9_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
					end
					f8_arg0:beginAnimation(190)
					f8_arg0:setAlpha(0.62)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
				end
				f6_arg0.Backing:beginAnimation(560)
				f6_arg0.Backing:setTopBottom(0, 0, -14, 78)
				f6_arg0.Backing:setAlpha(0.46)
				f6_arg0.Backing:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.Backing:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f6_arg0.Backing:completeAnimation()
			f6_arg0.Backing:setLeftRight(0, 0, -17, 84)
			f6_arg0.Backing:setTopBottom(0, 0, -14, 71)
			f6_arg0.Backing:setAlpha(0)
			f6_local0(f6_arg0.Backing)
			local f6_local1 = function(f10_arg0)
				local f10_local0 = function(f11_arg0)
					f11_arg0:beginAnimation(810)
					f11_arg0:setTopBottom(0, 0, -12, 12)
					f11_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
				end
				f6_arg0.scanline:beginAnimation(660)
				f6_arg0.scanline:setTopBottom(0, 0, 20.5, 44.5)
				f6_arg0.scanline:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.scanline:registerEventHandler("transition_complete_keyframe", f10_local0)
			end
			f6_arg0.scanline:completeAnimation()
			f6_arg0.scanline:setLeftRight(0, 0, -3, 71)
			f6_arg0.scanline:setTopBottom(0, 0, 47, 71)
			f6_arg0.scanline:setAlpha(1)
			f6_local1(f6_arg0.scanline)
			f6_arg0.nextClip = "DefaultClip"
		end,
		Full = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			f12_arg0.Line:completeAnimation()
			f12_arg0.Line:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Line)
			f12_arg0.Backing:completeAnimation()
			f12_arg0.Backing:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Backing)
			f12_arg0.scanline:completeAnimation()
			f12_arg0.scanline:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.scanline)
		end,
	},
	Full = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(3)
			f13_arg0.Line:completeAnimation()
			f13_arg0.Line:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Line)
			f13_arg0.Backing:completeAnimation()
			f13_arg0.Backing:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.Backing)
			f13_arg0.scanline:completeAnimation()
			f13_arg0.scanline:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.scanline)
		end,
	},
	Deployed = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(3)
			f14_arg0.Line:completeAnimation()
			f14_arg0.Line:setLeftRight(0, 0, 1.5, 105.5)
			f14_arg0.Line:setTopBottom(0, 0, 47, 44)
			f14_arg0.Line:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.Line)
			local f14_local0 = function(f15_arg0)
				local f15_local0 = function(f16_arg0)
					f16_arg0:beginAnimation(750)
					f16_arg0:setAlpha(0)
					f16_arg0:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
				end
				f14_arg0.Backing:beginAnimation(720)
				f14_arg0.Backing:setAlpha(0.62)
				f14_arg0.Backing:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.Backing:registerEventHandler("transition_complete_keyframe", f15_local0)
			end
			f14_arg0.Backing:completeAnimation()
			f14_arg0.Backing:setAlpha(0)
			f14_local0(f14_arg0.Backing)
			local f14_local1 = function(f17_arg0)
				f14_arg0.scanline:beginAnimation(1470)
				f14_arg0.scanline:setTopBottom(0, 0, 47, 71)
				f14_arg0.scanline:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.scanline:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.scanline:completeAnimation()
			f14_arg0.scanline:setLeftRight(0, 0, -1, 65)
			f14_arg0.scanline:setTopBottom(0, 0, -12, 12)
			f14_arg0.scanline:setAlpha(1)
			f14_local1(f14_arg0.scanline)
			f14_arg0.nextClip = "DefaultClip"
		end,
	},
}
