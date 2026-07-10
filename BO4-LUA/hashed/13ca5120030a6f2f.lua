require("x64:ab38ac0c74d7a80")
CoD.ScannerReticle_Internal = InheritFrom(LUI.UIElement)
CoD.ScannerReticle_Internal.__defaultWidth = 600
CoD.ScannerReticle_Internal.__defaultHeight = 600
CoD.ScannerReticle_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScannerReticle_Internal)
	self.id = "ScannerReticle_Internal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Indicator3 = CoD.ReticleEnemyIndicator.new(f1_arg0, f1_arg1, 0, 0, 0, 600, 0, 0, 0, 600)
	Indicator3:linkToElementModel(self, "weaponReticle.indicator3", false, function(model)
		Indicator3:setModel(model, f1_arg1)
	end)
	self:addElement(Indicator3)
	self.Indicator3 = Indicator3
	local Indicator2 = CoD.ReticleEnemyIndicator.new(f1_arg0, f1_arg1, 0, 0, 0, 600, 0, 0, 0, 600)
	Indicator2:linkToElementModel(self, "weaponReticle.indicator2", false, function(model)
		Indicator2:setModel(model, f1_arg1)
	end)
	self:addElement(Indicator2)
	self.Indicator2 = Indicator2
	local Indicator1 = CoD.ReticleEnemyIndicator.new(f1_arg0, f1_arg1, 0, 0, 0, 600, 0, 0, 0, 600)
	Indicator1:linkToElementModel(self, "weaponReticle.indicator1", false, function(model)
		Indicator1:setModel(model, f1_arg1)
	end)
	self:addElement(Indicator1)
	self.Indicator1 = Indicator1
	local Indicator0 = CoD.ReticleEnemyIndicator.new(f1_arg0, f1_arg1, 0, 0, 0, 600, 0, 0, 0, 600)
	Indicator0:linkToElementModel(self, "weaponReticle.indicator0", false, function(model)
		Indicator0:setModel(model, f1_arg1)
	end)
	self:addElement(Indicator0)
	self.Indicator0 = Indicator0
	local DirectlyOverEnemy = LUI.UIImage.new(0.5, 0.5, -64, 64, 0.5, 0.5, -64, 64)
	DirectlyOverEnemy:setAlpha(0.8)
	DirectlyOverEnemy:setImage(RegisterImage(@"uie_ui_hud_reticle_scanner_circle"))
	DirectlyOverEnemy:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	DirectlyOverEnemy:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(DirectlyOverEnemy)
	self.DirectlyOverEnemy = DirectlyOverEnemy
	self:mergeStateConditions({
		{
			stateName = "CrosshairsOverEnemy",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsModelValueTrue(f1_arg1, "hudItems.traceHitEnemy")
			end,
		},
	})
	local f1_local6 = self
	local f1_local7 = self.subscribeToModel
	local f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local7(f1_local6, f1_local8["hudItems.traceHitEnemy"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "hudItems.traceHitEnemy",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ScannerReticle_Internal.__resetProperties = function(f8_arg0)
	f8_arg0.DirectlyOverEnemy:completeAnimation()
	f8_arg0.DirectlyOverEnemy:setAlpha(0.8)
	f8_arg0.DirectlyOverEnemy:setScale(1, 1)
	f8_arg0.DirectlyOverEnemy:setShaderVector(0, 1, 0, 0, 0)
end
CoD.ScannerReticle_Internal.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.DirectlyOverEnemy:completeAnimation()
			f9_arg0.DirectlyOverEnemy:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.DirectlyOverEnemy)
		end,
	},
	CrosshairsOverEnemy = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			local f10_local0 = function(f11_arg0)
				f10_arg0.DirectlyOverEnemy:beginAnimation(50, Enum[@"luitween"][@"luitween_ease_in"])
				f10_arg0.DirectlyOverEnemy:setScale(1.1, 1.1)
				f10_arg0.DirectlyOverEnemy:setShaderVector(0, 1.2, 0, 0, 0)
				f10_arg0.DirectlyOverEnemy:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.DirectlyOverEnemy:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.DirectlyOverEnemy:completeAnimation()
			f10_arg0.DirectlyOverEnemy:setScale(1, 1)
			f10_arg0.DirectlyOverEnemy:setShaderVector(0, 1, 0, 0, 0)
			f10_local0(f10_arg0.DirectlyOverEnemy)
		end,
	},
}
CoD.ScannerReticle_Internal.__onClose = function(f12_arg0)
	f12_arg0.Indicator3:close()
	f12_arg0.Indicator2:close()
	f12_arg0.Indicator1:close()
	f12_arg0.Indicator0:close()
end
