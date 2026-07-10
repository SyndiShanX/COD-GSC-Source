require("x64:240f945b3b804af")
CoD.freeCursorInfoPanelContainer = InheritFrom(LUI.UIElement)
CoD.freeCursorInfoPanelContainer.__defaultWidth = 405
CoD.freeCursorInfoPanelContainer.__defaultHeight = 963
CoD.freeCursorInfoPanelContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.freeCursorInfoPanelContainer)
	self.id = "freeCursorInfoPanelContainer"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local infoPanel = CoD.freeCursorInfoPanel.new(f1_arg0, f1_arg1, 0, 0, 0, 707, 0, 0, 0, 401)
	infoPanel:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"hash_7948AC2378B0CBF"))
	infoPanel:setShaderVector(0, 1.05, 0, 0, 0)
	infoPanel:setShaderVector(1, 0.05, 0, 0, 0)
	infoPanel:setShaderVector(2, 1.05, 0, 0, 0)
	infoPanel:setShaderVector(3, 0.05, 0, 0, 0)
	infoPanel:setShaderVector(4, 0, 0, 0, 0)
	infoPanel:linkToElementModel(self, "contextualInfo", false, function(model)
		infoPanel:setModel(model, f1_arg1)
	end)
	self:addElement(infoPanel)
	self.infoPanel = infoPanel
	self:mergeStateConditions({
		{
			stateName = "HasFocus",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "hasFocus") and not IsMouseOrKeyboard(f1_arg1)
			end,
		},
		{
			stateName = "HasFocusPC",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "hasFocus") and IsMouseOrKeyboard(f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "hasFocus", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "hasFocus",
		})
	end)
	self:appendEventHandler("input_source_changed", function(f6_arg0, f6_arg1)
		f6_arg1.menu = f6_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f6_arg1)
	end)
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local3(f1_local2, f1_local4.LastInput, function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "LastInput",
		})
	end, false)
	infoPanel.id = "infoPanel"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.freeCursorInfoPanelContainer.__resetProperties = function(f8_arg0)
	f8_arg0.infoPanel:completeAnimation()
	f8_arg0.infoPanel:setAlpha(1)
	f8_arg0.infoPanel:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"hash_7948AC2378B0CBF"))
	f8_arg0.infoPanel:setShaderVector(0, 1.05, 0, 0, 0)
	f8_arg0.infoPanel:setShaderVector(1, 0.05, 0, 0, 0)
	f8_arg0.infoPanel:setShaderVector(2, 1.05, 0, 0, 0)
	f8_arg0.infoPanel:setShaderVector(3, 0.05, 0, 0, 0)
	f8_arg0.infoPanel:setShaderVector(4, 0, 0, 0, 0)
end
CoD.freeCursorInfoPanelContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.infoPanel:completeAnimation()
			f9_arg0.infoPanel:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.infoPanel)
		end,
		HasFocus = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			local f10_local0 = function(f11_arg0)
				f10_arg0.infoPanel:beginAnimation(200)
				f10_arg0.infoPanel:setShaderVector(0, 1.05, 0, 0, 0)
				f10_arg0.infoPanel:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.infoPanel:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.infoPanel:completeAnimation()
			f10_arg0.infoPanel:setAlpha(1)
			f10_arg0.infoPanel:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"hash_7948AC2378B0CBF"))
			f10_arg0.infoPanel:setShaderVector(0, 0, 0, 0, 0)
			f10_arg0.infoPanel:setShaderVector(1, 0.05, 0, 0, 0)
			f10_arg0.infoPanel:setShaderVector(2, 1.05, 0, 0, 0)
			f10_arg0.infoPanel:setShaderVector(3, 0.05, 0, 0, 0)
			f10_arg0.infoPanel:setShaderVector(4, 0, 0, 0, 0)
			f10_local0(f10_arg0.infoPanel)
		end,
		HasFocusPC = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.infoPanel:completeAnimation()
			f12_arg0.infoPanel:setAlpha(1)
			f12_arg0.infoPanel:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"hash_7948AC2378B0CBF"))
			f12_arg0.infoPanel:setShaderVector(0, 1.05, 0, 0, 0)
			f12_arg0.infoPanel:setShaderVector(1, 0.05, 0, 0, 0)
			f12_arg0.infoPanel:setShaderVector(2, 1.05, 0, 0, 0)
			f12_arg0.infoPanel:setShaderVector(3, 0.05, 0, 0, 0)
			f12_arg0.infoPanel:setShaderVector(4, 0, 0, 0, 0)
			f12_arg0.clipFinished(f12_arg0.infoPanel)
		end,
	},
	HasFocus = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
		DefaultState = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(1)
			local f14_local0 = function(f15_arg0)
				f14_arg0.infoPanel:beginAnimation(200)
				f14_arg0.infoPanel:setShaderVector(0, 0, 0, 0, 0)
				f14_arg0.infoPanel:registerEventHandler("interrupted_keyframe", f14_arg0.clipInterrupted)
				f14_arg0.infoPanel:registerEventHandler("transition_complete_keyframe", f14_arg0.clipFinished)
			end
			f14_arg0.infoPanel:completeAnimation()
			f14_arg0.infoPanel:setAlpha(1)
			f14_arg0.infoPanel:setRFTMaterial(LUI.UIImage.GetCachedMaterial(@"hash_7948AC2378B0CBF"))
			f14_arg0.infoPanel:setShaderVector(0, 1.05, 0, 0, 0)
			f14_arg0.infoPanel:setShaderVector(1, 0.05, 0, 0, 0)
			f14_arg0.infoPanel:setShaderVector(2, 1.05, 0, 0, 0)
			f14_arg0.infoPanel:setShaderVector(3, 0.05, 0, 0, 0)
			f14_arg0.infoPanel:setShaderVector(4, 0, 0, 0, 0)
			f14_local0(f14_arg0.infoPanel)
		end,
	},
	HasFocusPC = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.freeCursorInfoPanelContainer.__onClose = function(f17_arg0)
	f17_arg0.infoPanel:close()
end
