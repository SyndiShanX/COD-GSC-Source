require("x64:a30c8c5e357a72")
require("x64:2958075134fe8aa")
CoD.ScrStk_NumberMove = InheritFrom(LUI.UIElement)
CoD.ScrStk_NumberMove.__defaultWidth = 79
CoD.ScrStk_NumberMove.__defaultHeight = 33
CoD.ScrStk_NumberMove.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScrStk_NumberMove)
	self.id = "ScrStk_NumberMove"
	self.soundSet = "HUD"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PanelAmmo = CoD.DamageWidgetMP_PanelContainer.new(f1_arg0, f1_arg1, 0.5, 0.5, -36, 16, 0.5, 0.5, -16, 16)
	PanelAmmo:setRGB(0.55, 0.58, 0.6)
	PanelAmmo:setAlpha(0)
	PanelAmmo:setZoom(-4)
	self:addElement(PanelAmmo)
	self.PanelAmmo = PanelAmmo
	local NumberFrame = LUI.UIImage.new(0, 0, 10, 82, 0, 0, 4, 28)
	NumberFrame:setAlpha(0)
	NumberFrame:setImage(RegisterImage(@"uie_t7_mp_hud_scorestreak_nmbrbox"))
	NumberFrame:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_aberration_no_blur"))
	NumberFrame:setShaderVector(0, 0.1, 1, 0, 0)
	NumberFrame:setShaderVector(1, 0, 0, 0, 0)
	NumberFrame:setShaderVector(2, 0, 0, 0, 0)
	NumberFrame:setShaderVector(3, 0, 0, 0, 0)
	NumberFrame:setShaderVector(4, 0, 0, 0, 0)
	self:addElement(NumberFrame)
	self.NumberFrame = NumberFrame
	local TextBox = CoD.ScrStk_NumberText.new(f1_arg0, f1_arg1, 0, 0, -5, 55, 0, 0, 8, 24)
	self:addElement(TextBox)
	self.TextBox = TextBox
	self:mergeStateConditions({
		{
			stateName = "Hidden",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalDataSourceModelValueEqualTo(f1_arg1, "KillstreakRewards", "targetMomentum", 0)
			end,
		},
		{
			stateName = "ComSec",
			condition = function(menu, element, event)
				return CoD.ScorestreakInGameUtility.IsScorestreakDiscountActive(f1_arg1)
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = DataSources.KillstreakRewards.getModel(f1_arg1)
	f1_local5(f1_local4, f1_local6.targetMomentum, function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "targetMomentum",
		})
	end, false)
	self:subscribeToGlobalModel(f1_arg1, "PerController", "scriptNotify", function(model)
		local f5_local0 = self
		if CoD.ModelUtility.IsParamModelEqualToHashString(model, @"hash_21E30E91084F7E66") then
			UpdateSelfState(self, f1_arg1)
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ScrStk_NumberMove.__resetProperties = function(f6_arg0)
	f6_arg0.TextBox:completeAnimation()
	f6_arg0.TextBox:setRGB(1, 1, 1)
	f6_arg0.TextBox:setAlpha(1)
	f6_arg0.TextBox.TextBox:setRGB(1, 1, 1)
end
CoD.ScrStk_NumberMove.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	Hidden = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.TextBox:completeAnimation()
			f8_arg0.TextBox:setAlpha(0)
			f8_arg0.clipFinished(f8_arg0.TextBox)
		end,
	},
	ComSec = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.TextBox:completeAnimation()
			f9_arg0.TextBox.TextBox:completeAnimation()
			f9_arg0.TextBox:setRGB(1, 1, 1)
			f9_arg0.TextBox.TextBox:setRGB(0.13, 0.87, 0.94)
			f9_arg0.clipFinished(f9_arg0.TextBox)
		end,
	},
}
CoD.ScrStk_NumberMove.__onClose = function(f10_arg0)
	f10_arg0.PanelAmmo:close()
	f10_arg0.TextBox:close()
end
