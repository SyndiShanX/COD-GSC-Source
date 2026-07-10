CoD.StartMenu_QuitButtonFill = InheritFrom(LUI.UIElement)
CoD.StartMenu_QuitButtonFill.__defaultWidth = 320
CoD.StartMenu_QuitButtonFill.__defaultHeight = 128
CoD.StartMenu_QuitButtonFill.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_QuitButtonFill)
	self.id = "StartMenu_QuitButtonFill"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local HoldButtonFill = LUI.UIImage.new(0, 1, 0, 0, 0, 1, -16, 16)
	HoldButtonFill:setImage(RegisterImage(0x746B4D04E0617E5))
	HoldButtonFill:setMaterial(LUI.UIImage.GetCachedMaterial(0x910274CA3518744))
	HoldButtonFill:setShaderVector(1, 0, 0, 0, 0)
	HoldButtonFill:setShaderVector(2, 1, 0, 0, 0)
	HoldButtonFill:setShaderVector(3, 0, 0, 0, 0)
	HoldButtonFill:setShaderVector(4, 0, 0, 0, 0)
	HoldButtonFill.__X_Fraction = function(f2_arg0)
		local f2_local0 = f2_arg0:get()
		if f2_local0 ~= nil then
			HoldButtonFill:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end
	HoldButtonFill:linkToElementModel(self, "buttonBit", true, function(model, f3_arg1)
		if f3_arg1["__HoldButtonFill.__X_Fraction_buttonBit->progress"] then
			f3_arg1:removeSubscription(f3_arg1["__HoldButtonFill.__X_Fraction_buttonBit->progress"])
			f3_arg1["__HoldButtonFill.__X_Fraction_buttonBit->progress"] = nil
		end
		if model then
			local f3_local0 = model:get()
			local f3_local1 = model:get()
			model = f3_local0 and f3_local1.progress
		end
		if model then
			f3_arg1["__HoldButtonFill.__X_Fraction_buttonBit->progress"] = f3_arg1:subscribeToModel(model, HoldButtonFill.__X_Fraction)
		end
	end)
	self:addElement(HoldButtonFill)
	self.HoldButtonFill = HoldButtonFill
	self:mergeStateConditions({
		{
			stateName = "Playing",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
	})
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f5_arg2, f5_arg3, f5_arg4)
		if IsSelfInState(self, "Playing") then
			PlaySoundAlias("uin_mp_end_bar")
		elseif IsSelfInState(self, "DefaultState") then
			StopSoundAlias("uin_mp_end_bar")
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_QuitButtonFill.__onClose = function(f6_arg0)
	f6_arg0.HoldButtonFill:close()
end
