CoD.PC_TooltipsPromptsBackground = InheritFrom(LUI.UIElement)
CoD.PC_TooltipsPromptsBackground.__defaultWidth = 100
CoD.PC_TooltipsPromptsBackground.__defaultHeight = 100
CoD.PC_TooltipsPromptsBackground.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_TooltipsPromptsBackground)
	self.id = "PC_TooltipsPromptsBackground"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DropShadow = LUI.UIImage.new(0, 1, -10, 30, 0, 1, -12, 28)
	DropShadow:setRGB(0, 0, 0)
	DropShadow:setAlpha(0.6)
	DropShadow:setImage(RegisterImage(0xF8AD9AE7EF787EF))
	DropShadow:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	DropShadow:setShaderVector(0, 0, 0, 0, 0)
	DropShadow:setupNineSliceShader(60, 60)
	self:addElement(DropShadow)
	self.DropShadow = DropShadow
	local BG = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BG:setRGB(0.3, 0.3, 0.3)
	BG:setZRot(180)
	self:addElement(BG)
	self.BG = BG
	local BG2 = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BG2:setRGB(0.86, 0.74, 0.25)
	BG2:setAlpha(0)
	BG2:setZRot(180)
	self:addElement(BG2)
	self.BG2 = BG2
	local Outline = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	Outline:setAlpha(0.05)
	Outline:setImage(RegisterImage(0xF1E3082B39E99BB))
	Outline:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	Outline:setShaderVector(0, 0, 0, 0, 0)
	Outline:setupNineSliceShader(6, 6)
	self:addElement(Outline)
	self.Outline = Outline
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsModelValueTrue(f1_arg1, "FreeCursor.contextualInfo.hasContextualPrompts")
			end,
		},
	})
	local f1_local5 = self
	local f1_local6 = self.subscribeToModel
	local f1_local7 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local6(f1_local5, f1_local7["FreeCursor.contextualInfo.hasContextualPrompts"], function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "FreeCursor.contextualInfo.hasContextualPrompts",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local6 = self
	CoD.FreeCursorUtility.UseMaxVisibleChildHeight(self)
	return self
end
CoD.PC_TooltipsPromptsBackground.__resetProperties = function(f4_arg0)
	f4_arg0.Outline:completeAnimation()
	f4_arg0.BG2:completeAnimation()
	f4_arg0.BG:completeAnimation()
	f4_arg0.DropShadow:completeAnimation()
	f4_arg0.Outline:setAlpha(0.05)
	f4_arg0.BG2:setAlpha(0)
	f4_arg0.BG:setAlpha(1)
	f4_arg0.DropShadow:setAlpha(0.6)
end
CoD.PC_TooltipsPromptsBackground.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(4)
			f6_arg0.DropShadow:completeAnimation()
			f6_arg0.DropShadow:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.DropShadow)
			f6_arg0.BG:completeAnimation()
			f6_arg0.BG:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.BG)
			f6_arg0.BG2:completeAnimation()
			f6_arg0.BG2:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.BG2)
			f6_arg0.Outline:completeAnimation()
			f6_arg0.Outline:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Outline)
		end,
	},
}
