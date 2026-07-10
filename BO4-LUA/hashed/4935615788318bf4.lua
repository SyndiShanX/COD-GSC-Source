require("x64:24adaf674659a70")
CoD.ContractActiveBanner = InheritFrom(LUI.UIElement)
CoD.ContractActiveBanner.__defaultWidth = 150
CoD.ContractActiveBanner.__defaultHeight = 25
CoD.ContractActiveBanner.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ContractActiveBanner)
	self.id = "ContractActiveBanner"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ActiveTitle = LUI.UIText.new(0.5, 0.5, -73, 73, 0.5, 0.5, -9, 9)
	ActiveTitle:setRGB(0, 0.55, 0.33)
	ActiveTitle:setText(LocalizeToUpperString(@"menu/contract_active"))
	ActiveTitle:setTTF("ttmussels_demibold")
	ActiveTitle:setLetterSpacing(4)
	ActiveTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ActiveTitle:setBackingType(1)
	ActiveTitle:setBackingWidget(CoD.ContractActiveBannerBacker, f1_arg0, f1_arg1)
	ActiveTitle:setBackingXPadding(8)
	ActiveTitle:setBackingYPadding(2)
	self:addElement(ActiveTitle)
	self.ActiveTitle = ActiveTitle
	self:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return CoD.ContractUtility.IsElementContractActive(element, f1_arg1)
			end,
		},
	})
	self:linkToElementModel(self, "contractId", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "contractId",
		})
	end)
	local f1_local2 = self
	local f1_local3 = self.subscribeToModel
	local f1_local4 = Engine[@"getglobalmodel"]()
	f1_local3(f1_local2, f1_local4.ContractsForceUpdate, function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "ContractsForceUpdate",
		})
	end, false)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ContractActiveBanner.__resetProperties = function(f5_arg0)
	f5_arg0.ActiveTitle:completeAnimation()
	f5_arg0.ActiveTitle:setAlpha(1)
end
CoD.ContractActiveBanner.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(1)
			f6_arg0.ActiveTitle:completeAnimation()
			f6_arg0.ActiveTitle:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.ActiveTitle)
		end,
	},
	Visible = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			local f7_local0 = function(f8_arg0)
				f7_arg0.ActiveTitle:beginAnimation(100, Enum[@"luitween"][@"luitween_ease_in"])
				f7_arg0.ActiveTitle:setAlpha(1)
				f7_arg0.ActiveTitle:registerEventHandler("interrupted_keyframe", f7_arg0.clipInterrupted)
				f7_arg0.ActiveTitle:registerEventHandler("transition_complete_keyframe", f7_arg0.clipFinished)
			end
			f7_arg0.ActiveTitle:completeAnimation()
			f7_arg0.ActiveTitle:setAlpha(0)
			f7_local0(f7_arg0.ActiveTitle)
		end,
	},
}
