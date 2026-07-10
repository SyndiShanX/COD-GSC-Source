require("x64:e201e7e41431aa7")
CoD.ScrStk_MeterPanel = InheritFrom(LUI.UIElement)
CoD.ScrStk_MeterPanel.__defaultWidth = 10
CoD.ScrStk_MeterPanel.__defaultHeight = 180
CoD.ScrStk_MeterPanel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScrStk_MeterPanel)
	self.id = "ScrStk_MeterPanel"
	self.soundSet = "HUD"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Fill2 = LUI.UIImage.new(0, 0, -13, 20, 0.5, 0.5, -62, 96)
	Fill2:setRGB(0, 0, 0)
	Fill2:setImage(RegisterImage(0x611F9CF3D5F823))
	self:addElement(Fill2)
	self.Fill2 = Fill2
	local Fill = LUI.UIImage.new(0, 0, -2, 10, 0.5, 0.5, -90, 90)
	Fill:setRGB(0, 0, 0)
	Fill:setAlpha(0)
	Fill:setImage(RegisterImage(0xA1726B8A4CE14DC))
	self:addElement(Fill)
	self.Fill = Fill
	local Slots = LUI.UIImage.new(0, 0, -4, 12, 0, 0, 28, 182)
	Slots:setAlpha(0.08)
	Slots:setImage(RegisterImage(0xBECC85DF0ADD5A3))
	self:addElement(Slots)
	self.Slots = Slots
	local FEButtonPanel0 = CoD.FE_ButtonPanel.new(f1_arg0, f1_arg1, 0, 0, -6, 15, 0, 0, 0, 180)
	FEButtonPanel0:setRGB(0, 0, 0)
	FEButtonPanel0:setAlpha(0)
	self:addElement(FEButtonPanel0)
	self.FEButtonPanel0 = FEButtonPanel0
	local Image0 = LUI.UIImage.new(0, 0, -76, 80, 0, 0, -49, 219)
	Image0:setRGB(0, 0, 0)
	Image0:setAlpha(0)
	Image0:setImage(RegisterImage(0x5BE416E17DAB33B))
	self:addElement(Image0)
	self.Image0 = Image0
	self:mergeStateConditions({
		{
			stateName = "Combat",
			condition = function(menu, element, event)
				return IsSpecificGadgetInUse(f1_arg1, element, "gadget_combat_efficiency")
			end,
		},
	})
	self:linkToElementModel(self, "id", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "id",
		})
	end)
	self:linkToElementModel(self, "state", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "state",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ScrStk_MeterPanel.__resetProperties = function(f5_arg0)
	f5_arg0.FEButtonPanel0:completeAnimation()
	f5_arg0.Image0:completeAnimation()
	f5_arg0.FEButtonPanel0:setAlpha(0)
	f5_arg0.Image0:setAlpha(0)
end
CoD.ScrStk_MeterPanel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
		Combat = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			local f7_local0 = function(f8_arg0)
				f7_arg0.FEButtonPanel0:beginAnimation(300)
				f7_arg0.FEButtonPanel0:setAlpha(0.5)
				f7_arg0.FEButtonPanel0:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.FEButtonPanel0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.FEButtonPanel0:completeAnimation()
			f7_arg0.FEButtonPanel0:setAlpha(0)
			f7_local0(f7_arg0.FEButtonPanel0)
			local f7_local1 = function(f9_arg0)
				f7_arg0.Image0:beginAnimation(300)
				f7_arg0.Image0:setAlpha(0.26)
				f7_arg0.Image0:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.Image0:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.Image0:completeAnimation()
			f7_arg0.Image0:setAlpha(0)
			f7_local1(f7_arg0.Image0)
		end,
	},
	Combat = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.FEButtonPanel0:completeAnimation()
			f10_arg0.FEButtonPanel0:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.FEButtonPanel0)
			f10_arg0.Image0:completeAnimation()
			f10_arg0.Image0:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.Image0)
		end,
		DefaultState = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			local f11_local0 = function(f12_arg0)
				f11_arg0.FEButtonPanel0:beginAnimation(300)
				f11_arg0.FEButtonPanel0:setAlpha(0)
				f11_arg0.FEButtonPanel0:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.FEButtonPanel0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.FEButtonPanel0:completeAnimation()
			f11_arg0.FEButtonPanel0:setAlpha(0.5)
			f11_local0(f11_arg0.FEButtonPanel0)
			local f11_local1 = function(f13_arg0)
				f11_arg0.Image0:beginAnimation(300)
				f11_arg0.Image0:setAlpha(0)
				f11_arg0.Image0:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.Image0:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.Image0:completeAnimation()
			f11_arg0.Image0:setAlpha(0.26)
			f11_local1(f11_arg0.Image0)
		end,
	},
}
CoD.ScrStk_MeterPanel.__onClose = function(f14_arg0)
	f14_arg0.FEButtonPanel0:close()
end
