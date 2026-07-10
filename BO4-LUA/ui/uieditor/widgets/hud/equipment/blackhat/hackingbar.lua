CoD.HackingBar = InheritFrom(LUI.UIElement)
CoD.HackingBar.__defaultWidth = 108
CoD.HackingBar.__defaultHeight = 144
CoD.HackingBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HackingBar)
	self.id = "HackingBar"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BarScanning = LUI.UIImage.new(0, 0, 0, 88, 0, 0, 0, 164)
	BarScanning:setZRot(180)
	BarScanning:setImage(RegisterImage(0x7B9A25ACFCE156B))
	BarScanning:setMaterial(LUI.UIImage.GetCachedMaterial(0x910274CA3518744))
	BarScanning:setShaderVector(0, 1, 0, 0, 0)
	BarScanning:setShaderVector(1, 0, 0, 0, 0)
	BarScanning:setShaderVector(3, 0.04, 0, 0, 0)
	BarScanning:setShaderVector(4, 0, 0, 0, 0)
	BarScanning:subscribeToGlobalModel(f1_arg1, "Blackhat", "perc", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			BarScanning:setShaderVector(2, BlackhatHackingPercentageShaderValue(f1_arg1, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4)))
		end
	end)
	self:addElement(BarScanning)
	self.BarScanning = BarScanning
	local BarHacking = LUI.UIImage.new(0, 0, 0, 88, 0, 0, 0, 164)
	BarHacking:setAlpha(0)
	BarHacking:setZRot(180)
	BarHacking:setImage(RegisterImage(0x86D6288D6970407))
	BarHacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x910274CA3518744))
	BarHacking:setShaderVector(0, 1, 0, 0, 0)
	BarHacking:setShaderVector(1, 0, 0, 0, 0)
	BarHacking:setShaderVector(3, 0.03, 0, 0, 0)
	BarHacking:setShaderVector(4, 0, 0, 0, 0)
	BarHacking:subscribeToGlobalModel(f1_arg1, "Blackhat", "perc", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			BarHacking:setShaderVector(2, BlackhatHackingPercentageShaderValue(f1_arg1, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4)))
		end
	end)
	self:addElement(BarHacking)
	self.BarHacking = BarHacking
	local BarBreaching = LUI.UIImage.new(0, 0, 0, 88, 0, 0, 0, 164)
	BarBreaching:setAlpha(0)
	BarBreaching:setZRot(180)
	BarBreaching:setImage(RegisterImage(0x41132447B531A13))
	BarBreaching:setMaterial(LUI.UIImage.GetCachedMaterial(0x910274CA3518744))
	BarBreaching:setShaderVector(0, 1, 0, 0, 0)
	BarBreaching:setShaderVector(1, 0, 0, 0, 0)
	BarBreaching:setShaderVector(3, 0.03, 0, 0, 0)
	BarBreaching:setShaderVector(4, 0, 0, 0, 0)
	BarBreaching:subscribeToGlobalModel(f1_arg1, "Blackhat", "perc", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			BarBreaching:setShaderVector(2, BlackhatHackingPercentageShaderValue(f1_arg1, CoD.GetVectorComponentFromString(f4_local0, 1), CoD.GetVectorComponentFromString(f4_local0, 2), CoD.GetVectorComponentFromString(f4_local0, 3), CoD.GetVectorComponentFromString(f4_local0, 4)))
		end
	end)
	self:addElement(BarBreaching)
	self.BarBreaching = BarBreaching
	self:mergeStateConditions({
		{
			stateName = "Hacking",
			condition = function(menu, element, event)
				return IsBlackhatHacking(f1_arg1)
			end,
		},
		{
			stateName = "Breaching",
			condition = function(menu, element, event)
				return IsBlackhatBreaching(f1_arg1)
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local5(f1_local4, f1_local6["hudItems.blackhat.status"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "hudItems.blackhat.status",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.HackingBar.__resetProperties = function(f8_arg0, f8_arg1)
	f8_arg0.BarHacking:completeAnimation()
	f8_arg0.BarScanning:completeAnimation()
	f8_arg0.BarBreaching:completeAnimation()
	f8_arg0.BarHacking:setAlpha(0)
	f8_arg0.BarHacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x910274CA3518744))
	f8_arg0.BarHacking:setShaderVector(0, 1, 0, 0, 0)
	f8_arg0.BarHacking:setShaderVector(1, 0, 0, 0, 0)
	f8_arg0.BarHacking:setShaderVector(3, 0.03, 0, 0, 0)
	f8_arg0.BarHacking:setShaderVector(4, 0, 0, 0, 0)
	f8_arg0.BarScanning:setAlpha(1)
	f8_arg0.BarBreaching:setAlpha(0)
	f8_arg0.BarBreaching:setMaterial(LUI.UIImage.GetCachedMaterial(0x910274CA3518744))
	f8_arg0.BarBreaching:setShaderVector(0, 1, 0, 0, 0)
	f8_arg0.BarBreaching:setShaderVector(1, 0, 0, 0, 0)
	f8_arg0.BarBreaching:setShaderVector(3, 0.03, 0, 0, 0)
	f8_arg0.BarBreaching:setShaderVector(4, 0, 0, 0, 0)
end
CoD.HackingBar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties(f9_arg1)
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	Hacking = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties(f10_arg1)
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.BarScanning:completeAnimation()
			f10_arg0.BarScanning:setAlpha(0)
			f10_arg0.clipFinished(f10_arg0.BarScanning)
			f10_arg0.BarHacking:completeAnimation()
			f10_arg0.BarHacking:setAlpha(1)
			f10_arg0.BarHacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x910274CA3518744))
			f10_arg0.BarHacking:setShaderVector(0, 1, 0, 0, 0)
			f10_arg0.BarHacking:setShaderVector(1, 0, 0, 0, 0)
			f10_arg0.BarHacking:setShaderVector(3, 0.04, 0, 0, 0)
			f10_arg0.BarHacking:setShaderVector(4, 0, 0, 0, 0)
			f10_arg0.clipFinished(f10_arg0.BarHacking)
		end,
	},
	Breaching = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties(f11_arg1)
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.BarScanning:completeAnimation()
			f11_arg0.BarScanning:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.BarScanning)
			f11_arg0.BarBreaching:completeAnimation()
			f11_arg0.BarBreaching:setAlpha(1)
			f11_arg0.BarBreaching:setMaterial(LUI.UIImage.GetCachedMaterial(0x910274CA3518744))
			f11_arg0.BarBreaching:setShaderVector(0, 1, 0, 0, 0)
			f11_arg0.BarBreaching:setShaderVector(1, 0, 0, 0, 0)
			f11_arg0.BarBreaching:setShaderVector(3, 0.04, 0, 0, 0)
			f11_arg0.BarBreaching:setShaderVector(4, 0, 0, 0, 0)
			f11_arg0.clipFinished(f11_arg0.BarBreaching)
		end,
	},
}
CoD.HackingBar.__onClose = function(f12_arg0)
	f12_arg0.BarScanning:close()
	f12_arg0.BarHacking:close()
	f12_arg0.BarBreaching:close()
end
