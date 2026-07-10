CoD.ChooseClassSlideOutBacking = InheritFrom(LUI.UIElement)
CoD.ChooseClassSlideOutBacking.__defaultWidth = 1920
CoD.ChooseClassSlideOutBacking.__defaultHeight = 600
CoD.ChooseClassSlideOutBacking.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ChooseClassSlideOutBacking)
	self.id = "ChooseClassSlideOutBacking"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PCCyclingBacking = nil
	PCCyclingBacking = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -347, -300)
	PCCyclingBacking:setRGB(0, 0, 0)
	PCCyclingBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	PCCyclingBacking:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(PCCyclingBacking)
	self.PCCyclingBacking = PCCyclingBacking
	local PCCyclingBacking2 = nil
	PCCyclingBacking2 = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -347, -300)
	PCCyclingBacking2:setRGB(ColorSet.HealthBarBackgroundEnemy.r, ColorSet.HealthBarBackgroundEnemy.g, ColorSet.HealthBarBackgroundEnemy.b)
	PCCyclingBacking2:setAlpha(0.99)
	self:addElement(PCCyclingBacking2)
	self.PCCyclingBacking2 = PCCyclingBacking2
	local FullBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	FullBacking:setRGB(ColorSet.HealthBarBackgroundEnemy.r, ColorSet.HealthBarBackgroundEnemy.g, ColorSet.HealthBarBackgroundEnemy.b)
	FullBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	FullBacking:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(FullBacking)
	self.FullBacking = FullBacking
	local FullBacking2 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	FullBacking2:setRGB(ColorSet.HealthBarBackgroundEnemy.r, ColorSet.HealthBarBackgroundEnemy.g, ColorSet.HealthBarBackgroundEnemy.b)
	FullBacking2:setAlpha(0.99)
	self:addElement(FullBacking2)
	self.FullBacking2 = FullBacking2
	local background2 = LUI.UIImage.new(0, 1, 0, 0, 0, 0, -12, 42)
	background2:setRGB(0, 0, 0)
	background2:setAlpha(0.2)
	self:addElement(background2)
	self.background2 = background2
	local BGSceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 0, -12, 42)
	BGSceneBlur:setRGB(0.15, 0.15, 0.15)
	BGSceneBlur:setAlpha(0.6)
	self:addElement(BGSceneBlur)
	self.BGSceneBlur = BGSceneBlur
	local background1 = LUI.UIImage.new(0, 1, 0, 0, 0, 0, -12, 36)
	background1:setRGB(0, 0, 0)
	background1:setAlpha(0.2)
	self:addElement(background1)
	self.background1 = background1
	local f1_local8 = nil
	self.TopBar2 = LUI.UIElement.createFake()
	local f1_local9 = nil
	self.TopBar = LUI.UIElement.createFake()
	local TopBar4 = nil
	TopBar4 = LUI.UIImage.new(-0.1, 1.1, 0, 0, 0, 0, -15, -12)
	TopBar4:setAlpha(0.12)
	TopBar4:setImage(RegisterImage(0x42BCCF45B82FBED))
	TopBar4:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(TopBar4)
	self.TopBar4 = TopBar4
	local TopBar3 = nil
	TopBar3 = LUI.UIImage.new(-0.11, 1.09, 0, 0, 0, 0, -47.5, -44.5)
	TopBar3:setAlpha(0.2)
	TopBar3:setZoom(2)
	TopBar3:setImage(RegisterImage(0x42BCCF45B82FBED))
	TopBar3:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(TopBar3)
	self.TopBar3 = TopBar3
	local VerticalBGPattern2 = nil
	VerticalBGPattern2 = LUI.UIImage.new(-0.11, 1.09, 0, 0, 1, 1, -647, -611)
	VerticalBGPattern2:setAlpha(0.02)
	VerticalBGPattern2:setImage(RegisterImage(0x5D167EAB3F49E4B))
	VerticalBGPattern2:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	VerticalBGPattern2:setShaderVector(0, 0, 0, 0, 0)
	VerticalBGPattern2:setupNineSliceShader(256, 256)
	self:addElement(VerticalBGPattern2)
	self.VerticalBGPattern2 = VerticalBGPattern2
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ChooseClassSlideOutBacking.__resetProperties = function(f2_arg0)
	f2_arg0.FullBacking:completeAnimation()
	f2_arg0.FullBacking:setLeftRight(0, 1, 0, 0)
	f2_arg0.FullBacking:setTopBottom(0, 1, 0, 0)
	f2_arg0.FullBacking:setAlpha(1)
end
CoD.ChooseClassSlideOutBacking.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f3_arg0, f3_arg1)
			f3_arg0:__resetProperties()
			f3_arg0:setupElementClipCounter(0)
		end,
		Open = function(f4_arg0, f4_arg1)
			f4_arg0:__resetProperties()
			f4_arg0:setupElementClipCounter(1)
			local f4_local0 = function(f5_arg0)
				f4_arg0.FullBacking:beginAnimation(200)
				f4_arg0.FullBacking:setLeftRight(-0, 1, 191.96, 191.96)
				f4_arg0.FullBacking:setTopBottom(0, 1, 0, 0)
				f4_arg0.FullBacking:setAlpha(1)
				f4_arg0.FullBacking:registerEventHandler("interrupted_keyframe", f4_arg0.clipInterrupted)
				f4_arg0.FullBacking:registerEventHandler("transition_complete_keyframe", f4_arg0.clipFinished)
			end
			f4_arg0.FullBacking:completeAnimation()
			f4_arg0.FullBacking:setLeftRight(0, 0, -768, 192)
			f4_arg0.FullBacking:setTopBottom(0, 0, 12, 1092)
			f4_arg0.FullBacking:setAlpha(0)
			f4_local0(f4_arg0.FullBacking)
		end,
	},
	Open = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.FullBacking:completeAnimation()
			f6_arg0.FullBacking:setLeftRight(-0, 1, 191.96, 191.96)
			f6_arg0.FullBacking:setTopBottom(0, 1, 12, 12)
			f6_arg0.FullBacking:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.FullBacking)
		end,
		Close = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.FullBacking:beginAnimation(200)
				f7_arg0.FullBacking:setLeftRight(0, 0, -768, 192)
				f7_arg0.FullBacking:setTopBottom(0, 0, 0, 1080)
				f7_arg0.FullBacking:setAlpha(0)
				f7_arg0.FullBacking:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.FullBacking:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.FullBacking:completeAnimation()
			f7_arg0.FullBacking:setLeftRight(0, 0, 192, 1042)
			f7_arg0.FullBacking:setTopBottom(0, 0, 12, 1092)
			f7_arg0.FullBacking:setAlpha(1)
			f7_local0(f7_arg0.FullBacking)
		end,
	},
	Close = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.FullBacking:completeAnimation()
			f9_arg0.FullBacking:setLeftRight(0, 0, -768, 192)
			f9_arg0.FullBacking:setTopBottom(0, 0, 12, 1092)
			f9_arg0.FullBacking:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.FullBacking)
		end,
		Open = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			local f10_local0 = function(f11_arg0)
				f10_arg0.FullBacking:beginAnimation(200)
				f10_arg0.FullBacking:setLeftRight(-0, 1, 191.96, 191.96)
				f10_arg0.FullBacking:setTopBottom(0, 1, 0, 0)
				f10_arg0.FullBacking:setAlpha(1)
				f10_arg0.FullBacking:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.FullBacking:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.FullBacking:completeAnimation()
			f10_arg0.FullBacking:setLeftRight(0, 0, -768, 192)
			f10_arg0.FullBacking:setTopBottom(0, 0, 12, 1092)
			f10_arg0.FullBacking:setAlpha(0)
			f10_local0(f10_arg0.FullBacking)
		end,
	},
}
