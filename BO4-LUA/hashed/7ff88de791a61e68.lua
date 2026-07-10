CoD.HealthBar = InheritFrom(LUI.UIElement)
CoD.HealthBar.__defaultWidth = 138
CoD.HealthBar.__defaultHeight = 16
CoD.HealthBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HealthBar)
	self.id = "HealthBar"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Blur = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 2.5, 14.5)
	Blur:setYRot(180)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(0x81EEB1F96D4BE0A))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local Backer = LUI.UIImage.new(0, 1, 0, 0, 0.5, 0.5, -6, 6)
	Backer:setRGB(0, 0, 0)
	Backer:setAlpha(0.7)
	Backer:setYRot(180)
	Backer:setImage(RegisterImage(0x3F02AF56D3B7437))
	Backer:setMaterial(LUI.UIImage.GetCachedMaterial(0x31E7B3C72564429))
	Backer:setShaderVector(0, 0, 0, 0, 0)
	Backer:setShaderVector(1, 4, 1, 0, 0)
	Backer:setShaderVector(2, 0, 1, 0, 1)
	Backer:setupNineSliceShader(6, 6)
	self:addElement(Backer)
	self.Backer = Backer
	local HealthBackground = LUI.UIImage.new(0, 0.99, 1, 1, 0, 0, 4, 13)
	HealthBackground:setRGB(0.37, 0.4, 0.44)
	HealthBackground:setImage(RegisterImage(0x75CDE8BCCBD6F24))
	HealthBackground:setMaterial(LUI.UIImage.GetCachedMaterial(0xBEEFD90021D3628))
	HealthBackground:setShaderVector(0, 0, 0, 0, 0)
	HealthBackground:setShaderVector(1, 4, 1, 0, 0)
	HealthBackground:setShaderVector(2, 0, 1, 0, 1)
	HealthBackground:setupNineSliceShader(4, 6)
	self:addElement(HealthBackground)
	self.HealthBackground = HealthBackground
	local CleanseBarBG = LUI.UIImage.new(0, 0.99, 1, 1, 0, 0, 4, 13)
	CleanseBarBG:setRGB(ColorSet.CleanseBar.r, ColorSet.CleanseBar.g, ColorSet.CleanseBar.b)
	CleanseBarBG:setImage(RegisterImage(0x75961ABECF3E11A))
	CleanseBarBG:setMaterial(LUI.UIImage.GetCachedMaterial(0x7E89392B94A41DE))
	CleanseBarBG:setShaderVector(0, 0, 0, 0, 0)
	CleanseBarBG:setShaderVector(1, 4, 1, 0, 0)
	CleanseBarBG:setShaderVector(2, 0, 1, 0, 1)
	CleanseBarBG:setupNineSliceShader(4, 6)
	self:addElement(CleanseBarBG)
	self.CleanseBarBG = CleanseBarBG
	local HealthFill = LUI.UIImage.new(0, 0.99, 1, 1, 0, 0, 4, 13)
	HealthFill:setImage(RegisterImage(0x700B275CC09FEF2))
	HealthFill:setMaterial(LUI.UIImage.GetCachedMaterial(0x7E89392B94A41DE))
	HealthFill:setShaderVector(0, 0, 0, 0, 0)
	HealthFill:setShaderVector(1, 4, 1, 0, 0)
	HealthFill:setShaderVector(2, 0, 1, 0, 1)
	HealthFill:setupNineSliceShader(4, 6)
	self:addElement(HealthFill)
	self.HealthFill = HealthFill
	local LowHealthFill = LUI.UIImage.new(0, 0.99, 1, 1, 0, 0, 4, 13)
	LowHealthFill:setRGB(1, 0, 0)
	LowHealthFill:setAlpha(0)
	LowHealthFill:setImage(RegisterImage(0x700B275CC09FEF2))
	LowHealthFill:setMaterial(LUI.UIImage.GetCachedMaterial(0x7E89392B94A41DE))
	LowHealthFill:setShaderVector(0, 0, 0, 0, 0)
	LowHealthFill:setShaderVector(1, 4, 1, 0, 0)
	LowHealthFill:setShaderVector(2, 0, 1, 0, 1)
	LowHealthFill:setupNineSliceShader(4, 6)
	self:addElement(LowHealthFill)
	self.LowHealthFill = LowHealthFill
	local WoundBar = LUI.UIImage.new(0, 0.99, 1, 1, 0, 0, 6.5, 10.5)
	WoundBar:setImage(RegisterImage(0xC31716385F5211C))
	WoundBar:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	WoundBar:setShaderVector(0, 0, 1, 0, 0)
	WoundBar:setShaderVector(1, 0, 0, 0, 0)
	WoundBar:setShaderVector(2, 0, 1, 0, 0)
	WoundBar:setShaderVector(3, 0, 0, 0, 0)
	WoundBar:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(WoundBar)
	self.WoundBar = WoundBar
	local CleanseBar = LUI.UIImage.new(0, 0.99, 1, 1, 0, 0, 4, 13)
	CleanseBar:setRGB(ColorSet.CleanseBar.r, ColorSet.CleanseBar.g, ColorSet.CleanseBar.b)
	CleanseBar:setImage(RegisterImage(0x700B275CC09FEF2))
	CleanseBar:setMaterial(LUI.UIImage.GetCachedMaterial(0x7E89392B94A41DE))
	CleanseBar:setShaderVector(0, 0, 0, 0, 0)
	CleanseBar:setShaderVector(1, 4, 1, 0, 0)
	CleanseBar:setShaderVector(2, 0, 1, 0, 1)
	CleanseBar:setupNineSliceShader(4, 6)
	self:addElement(CleanseBar)
	self.CleanseBar = CleanseBar
	local LED = LUI.UIImage.new(0, 0, -24.5, 156.5, 0, 0, -11.5, 28.5)
	LED:setRGB(0, 0, 0)
	LED:setAlpha(0.09)
	LED:setScale(0.94, 0.94)
	LED:setImage(RegisterImage(0x832BA507D0E7663))
	LED:setMaterial(LUI.UIImage.GetCachedMaterial(0xE992BD5A540E2D))
	LED:setShaderVector(0, 0.11, 0.92, 0, 0)
	LED:setShaderVector(1, 0, 0, 0, 0)
	LED:setShaderVector(2, 0.34, 0.63, 0, 0)
	LED:setShaderVector(3, 0, 0, 0, 0)
	LED:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(LED)
	self.LED = LED
	self:mergeStateConditions({
		{
			stateName = "LowHealthAlert",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.HealthBar.__resetProperties = function(f4_arg0)
	f4_arg0.LowHealthFill:completeAnimation()
	f4_arg0.Backer:completeAnimation()
	f4_arg0.HealthBackground:completeAnimation()
	f4_arg0.CleanseBarBG:completeAnimation()
	f4_arg0.HealthFill:completeAnimation()
	f4_arg0.CleanseBar:completeAnimation()
	f4_arg0.Blur:completeAnimation()
	f4_arg0.LED:completeAnimation()
	f4_arg0.LowHealthFill:setAlpha(0)
	f4_arg0.Backer:setAlpha(0.7)
	f4_arg0.HealthBackground:setAlpha(1)
	f4_arg0.CleanseBarBG:setAlpha(1)
	f4_arg0.HealthFill:setAlpha(1)
	f4_arg0.CleanseBar:setAlpha(1)
	f4_arg0.Blur:setAlpha(1)
	f4_arg0.LED:setAlpha(0.09)
end
CoD.HealthBar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	LowHealthAlert = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			local f6_local0 = function(f7_arg0)
				local f7_local0 = function(f8_arg0)
					local f8_local0 = function(f9_arg0)
						f9_arg0:beginAnimation(199)
						f9_arg0:setAlpha(0)
						f9_arg0:registerEventHandler("transition_complete_keyframe", f6_arg0.clipFinished)
					end
					f8_arg0:beginAnimation(600)
					f8_arg0:registerEventHandler("transition_complete_keyframe", f8_local0)
				end
				f6_arg0.LowHealthFill:beginAnimation(200)
				f6_arg0.LowHealthFill:setAlpha(1)
				f6_arg0.LowHealthFill:registerEventHandler("interrupted_keyframe", f6_arg0.clipInterrupted)
				f6_arg0.LowHealthFill:registerEventHandler("transition_complete_keyframe", f7_local0)
			end
			f6_arg0.LowHealthFill:completeAnimation()
			f6_arg0.LowHealthFill:setAlpha(0)
			f6_local0(f6_arg0.LowHealthFill)
			f6_arg0.nextClip = "DefaultClip"
		end,
	},
	Hidden = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(8)
			f10_arg0.Blur:completeAnimation()
			f10_arg0.Blur:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Blur)
			f10_arg0.Backer:completeAnimation()
			f10_arg0.Backer:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Backer)
			f10_arg0.HealthBackground:completeAnimation()
			f10_arg0.HealthBackground:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.HealthBackground)
			f10_arg0.CleanseBarBG:completeAnimation()
			f10_arg0.CleanseBarBG:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.CleanseBarBG)
			f10_arg0.HealthFill:completeAnimation()
			f10_arg0.HealthFill:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.HealthFill)
			f10_arg0.LowHealthFill:completeAnimation()
			f10_arg0.LowHealthFill:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.LowHealthFill)
			f10_arg0.CleanseBar:completeAnimation()
			f10_arg0.CleanseBar:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.CleanseBar)
			f10_arg0.LED:completeAnimation()
			f10_arg0.LED:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.LED)
		end,
	},
}
