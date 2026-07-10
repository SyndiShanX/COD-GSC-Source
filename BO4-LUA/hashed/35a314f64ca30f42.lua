CoD.JobFeedItemIcons = InheritFrom(LUI.UIElement)
CoD.JobFeedItemIcons.__defaultWidth = 46
CoD.JobFeedItemIcons.__defaultHeight = 46
CoD.JobFeedItemIcons.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.JobFeedItemIcons)
	self.id = "JobFeedItemIcons"
	self.soundSet = "default"
	local CoinImage = LUI.UIImage.new(0, 0, 0, 46, 0.5, 0.5, -23, 23)
	CoinImage:setScale(1.3, 1.3)
	CoinImage:linkToElementModel(self, "medalAsset", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			CoinImage:setImage(RegisterImage(CoD.HUDUtility.GetScriptBundleField(f1_arg1, @"iconsmall", f2_local0)))
		end
	end)
	self:addElement(CoinImage)
	self.CoinImage = CoinImage
	local MultiUseCounter = LUI.UIImage.new(0.5, 0.5, -32, 32, 0.5, 0.5, -32, 32)
	MultiUseCounter:setScale(1.05, 1.05)
	MultiUseCounter:setImage(RegisterImage(@"uie_ui_icon_jobfeed_special_coinpips"))
	MultiUseCounter:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_clock_normal"))
	MultiUseCounter:setShaderVector(1, 0.5, 0, 0, 0)
	MultiUseCounter:setShaderVector(2, 0.5, 0, 0, 0)
	MultiUseCounter:setShaderVector(3, 0, 0, 0, 0)
	MultiUseCounter:setShaderVector(4, 0, 0, 0, 0)
	MultiUseCounter:linkToElementModel(self, "multiUseCount", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			MultiUseCounter:setShaderVector(0, CoD.JobFeedUtility.CalcMultiUseWipe(CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4)))
		end
	end)
	self:addElement(MultiUseCounter)
	self.MultiUseCounter = MultiUseCounter
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.JobFeedItemIcons.__onClose = function(f4_arg0)
	f4_arg0.CoinImage:close()
	f4_arg0.MultiUseCounter:close()
end
