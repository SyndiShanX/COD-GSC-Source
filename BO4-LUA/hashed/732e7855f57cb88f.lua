require("x64:50e649745950dee")
require("x64:ba943b96e09571")
require("x64:b205cf1d1d5deaa")
require("x64:6c3c7eaaa5e3862")
CoD.WZObituaryCalloutContainerStyle = InheritFrom(LUI.UIElement)
CoD.WZObituaryCalloutContainerStyle.__defaultWidth = 550
CoD.WZObituaryCalloutContainerStyle.__defaultHeight = 26
CoD.WZObituaryCalloutContainerStyle.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WZObituaryCalloutContainerStyle)
	self.id = "WZObituaryCalloutContainerStyle"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FinishText = CoD.WZObituaryCalloutContainerFinish.new(f1_arg0, f1_arg1, 0.5, 0.5, -275, 275, 0, 0, 0, 26)
	FinishText:linkToElementModel(self, nil, false, function(model)
		FinishText:setModel(model, f1_arg1)
	end)
	self:addElement(FinishText)
	self.FinishText = FinishText
	local KillConfirmText = CoD.WZObituaryCalloutContainerKillConfirm.new(f1_arg0, f1_arg1, 0.5, 0.5, -275, 275, 0, 0, 0, 26)
	KillConfirmText:linkToElementModel(self, nil, false, function(model)
		KillConfirmText:setModel(model, f1_arg1)
	end)
	self:addElement(KillConfirmText)
	self.KillConfirmText = KillConfirmText
	local DownText = CoD.WZObituaryCalloutContainerDown.new(f1_arg0, f1_arg1, 0.5, 0.5, -275, 275, 0, 0, 0, 26)
	DownText:linkToElementModel(self, nil, false, function(model)
		DownText:setModel(model, f1_arg1)
	end)
	self:addElement(DownText)
	self.DownText = DownText
	local KillText = CoD.WZObituaryCalloutContainerKill.new(f1_arg0, f1_arg1, 0.5, 0.5, -275, 275, 0, 0, 0, 26)
	KillText:linkToElementModel(self, nil, false, function(model)
		KillText:setModel(model, f1_arg1)
	end)
	self:addElement(KillText)
	self.KillText = KillText
	self:mergeStateConditions({
		{
			stateName = "Down",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, f1_arg1, "style", 1)
			end,
		},
		{
			stateName = "KillConfirm",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, f1_arg1, "style", 2)
			end,
		},
		{
			stateName = "Finish",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelPathValueEqualTo(element, f1_arg1, "style", 3)
			end,
		},
	})
	self:linkToElementModel(self, "style", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "style",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZObituaryCalloutContainerStyle.__resetProperties = function(f10_arg0)
	f10_arg0.DownText:completeAnimation()
	f10_arg0.KillConfirmText:completeAnimation()
	f10_arg0.FinishText:completeAnimation()
	f10_arg0.KillText:completeAnimation()
	f10_arg0.DownText:setAlpha(1)
	f10_arg0.KillConfirmText:setAlpha(1)
	f10_arg0.FinishText:setAlpha(1)
	f10_arg0.KillText:setAlpha(1)
end
CoD.WZObituaryCalloutContainerStyle.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			f11_arg0.FinishText:completeAnimation()
			f11_arg0.FinishText:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.FinishText)
			f11_arg0.KillConfirmText:completeAnimation()
			f11_arg0.KillConfirmText:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.KillConfirmText)
			f11_arg0.DownText:completeAnimation()
			f11_arg0.DownText:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.DownText)
		end,
	},
	Down = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			f12_arg0.FinishText:completeAnimation()
			f12_arg0.FinishText:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.FinishText)
			f12_arg0.KillConfirmText:completeAnimation()
			f12_arg0.KillConfirmText:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.KillConfirmText)
			f12_arg0.KillText:completeAnimation()
			f12_arg0.KillText:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.KillText)
		end,
	},
	KillConfirm = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(3)
			f13_arg0.FinishText:completeAnimation()
			f13_arg0.FinishText:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.FinishText)
			f13_arg0.DownText:completeAnimation()
			f13_arg0.DownText:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.DownText)
			f13_arg0.KillText:completeAnimation()
			f13_arg0.KillText:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.KillText)
		end,
	},
	Finish = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(3)
			f14_arg0.KillConfirmText:completeAnimation()
			f14_arg0.KillConfirmText:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.KillConfirmText)
			f14_arg0.DownText:completeAnimation()
			f14_arg0.DownText:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.DownText)
			f14_arg0.KillText:completeAnimation()
			f14_arg0.KillText:setAlpha(0)
			f14_arg0.clipFinished(f14_arg0.KillText)
		end,
	},
}
CoD.WZObituaryCalloutContainerStyle.__onClose = function(f15_arg0)
	f15_arg0.FinishText:close()
	f15_arg0.KillConfirmText:close()
	f15_arg0.DownText:close()
	f15_arg0.KillText:close()
end
