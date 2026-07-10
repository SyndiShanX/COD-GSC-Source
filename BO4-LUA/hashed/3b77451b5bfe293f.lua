CoD.Tcm_Rule_Entry = InheritFrom(LUI.UIElement)
CoD.Tcm_Rule_Entry.__defaultWidth = 500
CoD.Tcm_Rule_Entry.__defaultHeight = 44
CoD.Tcm_Rule_Entry.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.Tcm_Rule_Entry)
	self.id = "Tcm_Rule_Entry"
	self.soundSet = "none"
	local RuleTextShadow = LUI.UIText.new(0.5, 0.5, -225, 225, 0, 0, 0, 18)
	RuleTextShadow:setRGB(0, 0, 0)
	RuleTextShadow:setAlpha(0.5)
	RuleTextShadow:setTTF("skorzhen")
	RuleTextShadow:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_2AE166D9BA8C6907"))
	RuleTextShadow:setShaderVector(0, 0.4, 0, 0, 0)
	RuleTextShadow:setShaderVector(1, 0.2, 0, 0, 0)
	RuleTextShadow:setShaderVector(2, 0, 0, 0, 0)
	RuleTextShadow:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	RuleTextShadow:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	RuleTextShadow:linkToElementModel(self, "text", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			RuleTextShadow:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(RuleTextShadow)
	self.RuleTextShadow = RuleTextShadow
	local RuleText = LUI.UIText.new(0.5, 0.5, -225, 225, 0, 0, 0, 18)
	RuleText:setRGB(ColorSet.T8__SILVER.r, ColorSet.T8__SILVER.g, ColorSet.T8__SILVER.b)
	RuleText:setTTF("skorzhen")
	RuleText:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_2AE166D9BA8C6907"))
	RuleText:setShaderVector(0, 0, 0, 0, 0)
	RuleText:setShaderVector(1, 0, 0, 0, 0)
	RuleText:setShaderVector(2, 1, 0, 0, 0)
	RuleText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	RuleText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	RuleText:linkToElementModel(self, "text", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			RuleText:setText(Engine[@"hash_4F9F1239CFD921FE"](f3_local0))
		end
	end)
	self:addElement(RuleText)
	self.RuleText = RuleText
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Tcm_Rule_Entry.__onClose = function(f4_arg0)
	f4_arg0.RuleTextShadow:close()
	f4_arg0.RuleText:close()
end
