require("x64:d228e345f027bac")
require("x64:dd2971a6510d135")
CoD.LaboratoryListItemNebuliumPlasmaDiscount = InheritFrom(LUI.UIElement)
CoD.LaboratoryListItemNebuliumPlasmaDiscount.__defaultWidth = 482
CoD.LaboratoryListItemNebuliumPlasmaDiscount.__defaultHeight = 150
CoD.LaboratoryListItemNebuliumPlasmaDiscount.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LaboratoryListItemNebuliumPlasmaDiscount)
	self.id = "LaboratoryListItemNebuliumPlasmaDiscount"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Description = CoD.LaboratoryOfferNameAndDescription.new(f1_arg0, f1_arg1, 0.5, 0.5, -217.5, 217.5, 0, 0, 176, 218)
	Description:setAlpha(0)
	Description:linkToElementModel(self, nil, false, function(model)
		Description:setModel(model, f1_arg1)
	end)
	Description:linkToElementModel(self, "labelName", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Description.name:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	self:addElement(Description)
	self.Description = Description
	local Corner = LUI.UIImage.new(0.5, 0.5, -10.5, 10.5, 0, 0, 154, 171)
	Corner:setAlpha(0)
	Corner:setImage(RegisterImage(@"uie_zm_hud_cornerdecoration_half"))
	self:addElement(Corner)
	self.Corner = Corner
	local Button = CoD.LaboratoryListItemNebuliumPlasmaDiscount_Internal.new(f1_arg0, f1_arg1, 0.5, 0.5, -241, 241, 0.5, 0.5, -75, 75)
	Button:linkToElementModel(self, nil, false, function(model)
		Button:setModel(model, f1_arg1)
	end)
	self:addElement(Button)
	self.Button = Button
	self:mergeStateConditions({
		{
			stateName = "Enabled",
			condition = function(menu, element, event)
				local f5_local0 = CoD.ZMLaboratoryUtility.CanPurchaseMore(f1_arg1, element)
				if f5_local0 then
					if not CoD.ModelUtility.IsModelValueEqualTo(f1_arg1, "Laboratory.disableInput", 1) then
						f5_local0 = CoD.ZMLaboratoryUtility.IsInAnimState1(f1_arg1, CoD.ZMLaboratoryUtility.LabAnimState.NOT_PLAYING)
					else
						f5_local0 = false
					end
				end
				return f5_local0
			end,
		},
	})
	self:linkToElementModel(self, "maxQuantity", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "maxQuantity",
		})
	end)
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["Laboratory.disableInput"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "Laboratory.disableInput",
		})
	end, false)
	f1_local4 = self
	f1_local5 = self.subscribeToModel
	f1_local6 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local5(f1_local4, f1_local6["Laboratory.animState"], function(f8_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f8_arg0:get(),
			modelName = "Laboratory.animState",
		})
	end, false)
	Button.id = "Button"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LaboratoryListItemNebuliumPlasmaDiscount.__resetProperties = function(f9_arg0)
	f9_arg0.Button:completeAnimation()
	f9_arg0.Description:completeAnimation()
	f9_arg0.Corner:completeAnimation()
	f9_arg0.Button:setScale(1, 1)
	f9_arg0.Description:setAlpha(0)
	f9_arg0.Corner:setAlpha(0)
end
CoD.LaboratoryListItemNebuliumPlasmaDiscount.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
		ChildFocus = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(3)
			f11_arg0.Description:completeAnimation()
			f11_arg0.Description:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.Description)
			f11_arg0.Corner:completeAnimation()
			f11_arg0.Corner:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.Corner)
			f11_arg0.Button:completeAnimation()
			f11_arg0.Button:setScale(1.05, 1.05)
			f11_arg0.clipFinished(f11_arg0.Button)
		end,
		GainChildFocus = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(3)
			local f12_local0 = function(f13_arg0)
				f12_arg0.Description:beginAnimation(100)
				f12_arg0.Description:setAlpha(1)
				f12_arg0.Description:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.Description:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.Description:completeAnimation()
			f12_arg0.Description:setAlpha(0)
			f12_local0(f12_arg0.Description)
			local f12_local1 = function(f14_arg0)
				f12_arg0.Corner:beginAnimation(150)
				f12_arg0.Corner:setAlpha(1)
				f12_arg0.Corner:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.Corner:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.Corner:completeAnimation()
			f12_arg0.Corner:setAlpha(0)
			f12_local1(f12_arg0.Corner)
			local f12_local2 = function(f15_arg0)
				f12_arg0.Button:beginAnimation(200)
				f12_arg0.Button:setScale(1.05, 1.05)
				f12_arg0.Button:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
				f12_arg0.Button:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
			end
			f12_arg0.Button:completeAnimation()
			f12_arg0.Button:setScale(1, 1)
			f12_local2(f12_arg0.Button)
		end,
		LoseChildFocus = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(3)
			local f16_local0 = function(f17_arg0)
				f16_arg0.Description:beginAnimation(100)
				f16_arg0.Description:setAlpha(0)
				f16_arg0.Description:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.Description:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.Description:completeAnimation()
			f16_arg0.Description:setAlpha(1)
			f16_local0(f16_arg0.Description)
			local f16_local1 = function(f18_arg0)
				f16_arg0.Corner:beginAnimation(150)
				f16_arg0.Corner:setAlpha(0)
				f16_arg0.Corner:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.Corner:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.Corner:completeAnimation()
			f16_arg0.Corner:setAlpha(1)
			f16_local1(f16_arg0.Corner)
			local f16_local2 = function(f19_arg0)
				f16_arg0.Button:beginAnimation(200)
				f16_arg0.Button:setScale(1, 1)
				f16_arg0.Button:registerEventHandler("interrupted_keyframe", f16_arg0.clipInterrupted)
				f16_arg0.Button:registerEventHandler("transition_complete_keyframe", f16_arg0.clipFinished)
			end
			f16_arg0.Button:completeAnimation()
			f16_arg0.Button:setScale(1.05, 1.05)
			f16_local2(f16_arg0.Button)
		end,
	},
	Enabled = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(1)
			f20_arg0.Button:completeAnimation()
			f20_arg0.Button:setScale(1, 1)
			f20_arg0.clipFinished(f20_arg0.Button)
		end,
		ChildFocus = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(3)
			f21_arg0.Description:completeAnimation()
			f21_arg0.Description:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.Description)
			f21_arg0.Corner:completeAnimation()
			f21_arg0.Corner:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.Corner)
			f21_arg0.Button:completeAnimation()
			f21_arg0.Button:setScale(1.05, 1.05)
			f21_arg0.clipFinished(f21_arg0.Button)
		end,
		GainChildFocus = function(f22_arg0, f22_arg1)
			f22_arg0:__resetProperties()
			f22_arg0:setupElementClipCounter(3)
			local f22_local0 = function(f23_arg0)
				f22_arg0.Description:beginAnimation(100)
				f22_arg0.Description:setAlpha(1)
				f22_arg0.Description:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.Description:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.Description:completeAnimation()
			f22_arg0.Description:setAlpha(0)
			f22_local0(f22_arg0.Description)
			local f22_local1 = function(f24_arg0)
				f22_arg0.Corner:beginAnimation(150)
				f22_arg0.Corner:setAlpha(1)
				f22_arg0.Corner:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.Corner:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.Corner:completeAnimation()
			f22_arg0.Corner:setAlpha(0)
			f22_local1(f22_arg0.Corner)
			local f22_local2 = function(f25_arg0)
				f22_arg0.Button:beginAnimation(200)
				f22_arg0.Button:setScale(1.05, 1.05)
				f22_arg0.Button:registerEventHandler("interrupted_keyframe", f22_arg0.clipInterrupted)
				f22_arg0.Button:registerEventHandler("transition_complete_keyframe", f22_arg0.clipFinished)
			end
			f22_arg0.Button:completeAnimation()
			f22_arg0.Button:setScale(1, 1)
			f22_local2(f22_arg0.Button)
		end,
		LoseChildFocus = function(f26_arg0, f26_arg1)
			f26_arg0:__resetProperties()
			f26_arg0:setupElementClipCounter(3)
			local f26_local0 = function(f27_arg0)
				f26_arg0.Description:beginAnimation(100)
				f26_arg0.Description:setAlpha(0)
				f26_arg0.Description:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.Description:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.Description:completeAnimation()
			f26_arg0.Description:setAlpha(1)
			f26_local0(f26_arg0.Description)
			local f26_local1 = function(f28_arg0)
				f26_arg0.Corner:beginAnimation(150)
				f26_arg0.Corner:setAlpha(0)
				f26_arg0.Corner:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.Corner:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.Corner:completeAnimation()
			f26_arg0.Corner:setAlpha(1)
			f26_local1(f26_arg0.Corner)
			local f26_local2 = function(f29_arg0)
				f26_arg0.Button:beginAnimation(200)
				f26_arg0.Button:setScale(1, 1)
				f26_arg0.Button:registerEventHandler("interrupted_keyframe", f26_arg0.clipInterrupted)
				f26_arg0.Button:registerEventHandler("transition_complete_keyframe", f26_arg0.clipFinished)
			end
			f26_arg0.Button:completeAnimation()
			f26_arg0.Button:setScale(1.05, 1.05)
			f26_local2(f26_arg0.Button)
		end,
	},
}
CoD.LaboratoryListItemNebuliumPlasmaDiscount.__onClose = function(f30_arg0)
	f30_arg0.Description:close()
	f30_arg0.Button:close()
end
