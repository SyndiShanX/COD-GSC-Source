CoD.FE_ButtonPanelShaderContainer = InheritFrom(LUI.UIElement)
CoD.FE_ButtonPanelShaderContainer.__defaultWidth = 420
CoD.FE_ButtonPanelShaderContainer.__defaultHeight = 42
CoD.FE_ButtonPanelShaderContainer.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FE_ButtonPanelShaderContainer)
	self.id = "FE_ButtonPanelShaderContainer"
	self.soundSet = "FrontendMain"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FEButtonPanel = LUI.UIImage.new(0, 1, -2, 2, 0, 1, -3, 3)
	FEButtonPanel:setImage(RegisterImage("uie_t7_menu_frontend_buttonpanelfull"))
	FEButtonPanel:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	FEButtonPanel:setShaderVector(0, 0, 0, 0, 0)
	FEButtonPanel:setupNineSliceShader(12, 12)
	self:addElement(FEButtonPanel)
	self.FEButtonPanel = FEButtonPanel
	self:mergeStateConditions({
		{
			stateName = "Transparent",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueEqualTo("hideWorldForStreamer", 1)
			end,
		},
	})
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine.GetGlobalModel()
	f1_local3(f1_local2, f1_local4.hideWorldForStreamer, function(f3_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "hideWorldForStreamer",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.FE_ButtonPanelShaderContainer.__resetProperties = function(f4_arg0)
	f4_arg0.FEButtonPanel:completeAnimation()
	f4_arg0.FEButtonPanel:setAlpha(1)
end
CoD.FE_ButtonPanelShaderContainer.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(0)
		end,
	},
	Transparent = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.FEButtonPanel:completeAnimation()
			f6_arg0.FEButtonPanel:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.FEButtonPanel)
		end,
		DefaultState = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.FEButtonPanel:beginAnimation(300)
				f7_arg0.FEButtonPanel:setAlpha(1)
				f7_arg0.FEButtonPanel:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.FEButtonPanel:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.FEButtonPanel:completeAnimation()
			f7_arg0.FEButtonPanel:setAlpha(0)
			f7_local0(f7_arg0.FEButtonPanel)
		end,
	},
}
