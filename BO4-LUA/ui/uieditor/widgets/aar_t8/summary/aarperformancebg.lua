CoD.AARPerformanceBg = InheritFrom(LUI.UIElement)
CoD.AARPerformanceBg.__defaultWidth = 354
CoD.AARPerformanceBg.__defaultHeight = 140
CoD.AARPerformanceBg.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AARPerformanceBg)
	self.id = "AARPerformanceBg"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local blurBg = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	blurBg:setAlpha(0)
	blurBg:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	blurBg:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(blurBg)
	self.blurBg = blurBg
	local Tint = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Tint:setRGB(0.92, 0.92, 0.92)
	Tint:setAlpha(0.03)
	Tint:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(Tint)
	self.Tint = Tint
	local PerformBracketBlur = LUI.UIImage.new(0, 1, -3.5, 4.5, 1, 1, -14, 6)
	PerformBracketBlur:setAlpha(0.3)
	PerformBracketBlur:setImage(RegisterImage(0xD4F19B775CF07F8))
	PerformBracketBlur:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	PerformBracketBlur:setShaderVector(0, 0, 0, 0, 0)
	PerformBracketBlur:setupNineSliceShader(174, 10)
	self:addElement(PerformBracketBlur)
	self.PerformBracketBlur = PerformBracketBlur
	local PerformBg = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	PerformBg:setAlpha(0.8)
	PerformBg:setImage(RegisterImage(0xF95A1671A1AB874))
	PerformBg:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	PerformBg:setShaderVector(0, 0, 0, 0, 0)
	PerformBg:setupNineSliceShader(172, 136)
	self:addElement(PerformBg)
	self.PerformBg = PerformBg
	local infoBracketBot = LUI.UIImage.new(0, 1, -1, 1, 1, 1, -7, 1)
	infoBracketBot:setAlpha(0.5)
	infoBracketBot:setImage(RegisterImage(0xC325BED3F226657))
	infoBracketBot:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	infoBracketBot:setShaderVector(0, 0, 0, 0, 0)
	infoBracketBot:setupNineSliceShader(16, 4)
	self:addElement(infoBracketBot)
	self.infoBracketBot = infoBracketBot
	local DotPipL = LUI.UIImage.new(0, 0, -2, 2, 1, 1, -12.5, -8.5)
	DotPipL:setAlpha(0.5)
	DotPipL:setImage(RegisterImage(0x3854665C02218EF))
	DotPipL:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(DotPipL)
	self.DotPipL = DotPipL
	local DotPipR = LUI.UIImage.new(1, 1, -2, 2, 1, 1, -12.5, -8.5)
	DotPipR:setAlpha(0.5)
	DotPipR:setImage(RegisterImage(0x3854665C02218EF))
	DotPipR:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(DotPipR)
	self.DotPipR = DotPipR
	self:mergeStateConditions({
		{
			stateName = "Objective",
			condition = function(menu, element, event)
				return CoD.AARUtility.IsGametypeObjectiveType(f1_arg1)
			end,
		},
	})
	local f1_local8 = self
	local f1_local9 = self.subscribeToModel
	local f1_local10 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local9(f1_local8, f1_local10["AAR.gametype"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "AAR.gametype",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
