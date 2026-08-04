CoD.systemOverlay_alertStatusBar = InheritFrom(LUI.UIElement)
CoD.systemOverlay_alertStatusBar.__defaultWidth = 1920
CoD.systemOverlay_alertStatusBar.__defaultHeight = 6
CoD.systemOverlay_alertStatusBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.systemOverlay_alertStatusBar)
	self.id = "systemOverlay_alertStatusBar"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local glow = LUI.UIImage.new(0, 1, -1.5, -1.5, 0, 0, -8, 11)
	glow:setRGB(0.42, 0.4, 0.31)
	glow:setAlpha(0.5)
	glow:setImage(RegisterImage(@"hash_5333C8E36E45B362"))
	glow:setMaterial(LUI.UIImage.GetCachedMaterial("ui_add"))
	self:addElement(glow)
	self.glow = glow
	local alertStatus = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	alertStatus:setRGB(0.66, 0.63, 0.52)
	self:addElement(alertStatus)
	self.alertStatus = alertStatus
	self:mergeStateConditions({
		{
			stateName = "Alert",
			condition = function(menu, element, event)
				return IsAlertOverlay(self, f1_arg1)
			end,
		},
		{
			stateName = "Blackmarket",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	self:linkToElementModel(self, "categoryType", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "categoryType",
		})
	end)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.systemOverlay_alertStatusBar.__resetProperties = function(f6_arg0)
	f6_arg0.alertStatus:completeAnimation()
	f6_arg0.alertStatus:setRGB(0.66, 0.63, 0.52)
end
CoD.systemOverlay_alertStatusBar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
	},
	Alert = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			local f8_local0 = function(f9_arg0)
				f8_arg0.alertStatus:beginAnimation(590)
				f8_arg0.alertStatus:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.alertStatus:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.alertStatus:completeAnimation()
			f8_arg0.alertStatus:setRGB(0.66, 0.63, 0.52)
			f8_local0(f8_arg0.alertStatus)
		end,
	},
	Blackmarket = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			local f10_local0 = function(f11_arg0)
				f10_arg0.alertStatus:beginAnimation(590)
				f10_arg0.alertStatus:setRGB(0.66, 0.63, 0.52)
				f10_arg0.alertStatus:registerEventHandler("interrupted_keyframe", f10_arg0.clipInterrupted)
				f10_arg0.alertStatus:registerEventHandler("transition_complete_keyframe", f10_arg0.clipFinished)
			end
			f10_arg0.alertStatus:completeAnimation()
			f10_arg0.alertStatus:setRGB(0.25, 0.38, 0.35)
			f10_local0(f10_arg0.alertStatus)
		end,
	},
	PC = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.alertStatus:completeAnimation()
			f12_arg0.alertStatus:setRGB(0.66, 0.63, 0.52)
			f12_arg0.clipFinished(f12_arg0.alertStatus)
		end,
	},
}
