CoD.BM_SmallContractProgress = InheritFrom(LUI.UIElement)
CoD.BM_SmallContractProgress.__defaultWidth = 68
CoD.BM_SmallContractProgress.__defaultHeight = 68
CoD.BM_SmallContractProgress.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BM_SmallContractProgress)
	self.id = "BM_SmallContractProgress"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local EmptyFill = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	EmptyFill:setRGB(0.45, 0.45, 0.45)
	EmptyFill:setAlpha(0)
	EmptyFill:setImage(RegisterImage(0x5EE487F3CC2F5EE))
	self:addElement(EmptyFill)
	self.EmptyFill = EmptyFill
	local EmptyRing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	EmptyRing:setRGB(0.45, 0.45, 0.45)
	EmptyRing:setAlpha(0)
	EmptyRing:setImage(RegisterImage(0xA63A1E82AA367D2))
	self:addElement(EmptyRing)
	self.EmptyRing = EmptyRing
	local ProgressBarBack = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	ProgressBarBack:setRGB(0.45, 0.45, 0.45)
	ProgressBarBack:setImage(RegisterImage(0x9A7834DA6C08B1A))
	self:addElement(ProgressBarBack)
	self.ProgressBarBack = ProgressBarBack
	local ProgressBarFront = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	ProgressBarFront:setRGB(ColorSet.PlayerYellow.r, ColorSet.PlayerYellow.g, ColorSet.PlayerYellow.b)
	ProgressBarFront:setImage(RegisterImage(0xBAD1467C2B4564C))
	ProgressBarFront:setMaterial(LUI.UIImage.GetCachedMaterial(0xD5CA1A25ED87F4F))
	ProgressBarFront:setShaderVector(1, 0.5, 0, 0, 0)
	ProgressBarFront:setShaderVector(2, 0.5, 0, 0, 0)
	ProgressBarFront:setShaderVector(3, 0, 0, 0, 0)
	ProgressBarFront:setShaderVector(4, 0, 0, 0, 0)
	ProgressBarFront:linkToElementModel(self, "progressRatio", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ProgressBarFront:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	self:addElement(ProgressBarFront)
	self.ProgressBarFront = ProgressBarFront
	local ProgressBarComplete = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	ProgressBarComplete:setAlpha(0)
	ProgressBarComplete:setImage(RegisterImage(0x200DFB498DD9B4E))
	ProgressBarComplete:setMaterial(LUI.UIImage.GetCachedMaterial(0xD5CA1A25ED87F4F))
	ProgressBarComplete:setShaderVector(1, 0.5, 0, 0, 0)
	ProgressBarComplete:setShaderVector(2, 0.5, 0, 0, 0)
	ProgressBarComplete:setShaderVector(3, 0, 0, 0, 0)
	ProgressBarComplete:setShaderVector(4, 0, 0, 0, 0)
	ProgressBarComplete:linkToElementModel(self, "progressRatio", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ProgressBarComplete:setShaderVector(0, CoD.GetVectorComponentFromString(f3_local0, 1), CoD.GetVectorComponentFromString(f3_local0, 2), CoD.GetVectorComponentFromString(f3_local0, 3), CoD.GetVectorComponentFromString(f3_local0, 4))
		end
	end)
	self:addElement(ProgressBarComplete)
	self.ProgressBarComplete = ProgressBarComplete
	local Icon = LUI.UIImage.new(0.5, 0.5, -20, 20, 0.5, 0.5, -20, 20)
	Icon:linkToElementModel(self, "contractIcon", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Icon:setImage(RegisterImage(f4_local0))
		end
	end)
	self:addElement(Icon)
	self.Icon = Icon
	local Plus = LUI.UIImage.new(0.5, 0.5, -32, 32, 0.5, 0.5, -32, 32)
	Plus:setRGB(0.45, 0.45, 0.45)
	Plus:setAlpha(0)
	Plus:setImage(RegisterImage(0x8CCA2C769C2E30))
	self:addElement(Plus)
	self.Plus = Plus
	local Check = LUI.UIImage.new(0.5, 0.5, -32, 32, 0.5, 0.5, -32, 32)
	Check:setAlpha(0)
	Check:setImage(RegisterImage(0xD1E7BB277F7D37A))
	self:addElement(Check)
	self.Check = Check
	self:mergeStateConditions({
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(element, f1_arg1, "displayName", 0x0)
			end,
		},
		{
			stateName = "Completed",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(element, f1_arg1, "completed")
			end,
		},
	})
	self:linkToElementModel(self, "displayName", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "displayName",
		})
	end)
	self:linkToElementModel(self, "completed", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "completed",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BM_SmallContractProgress.__resetProperties = function(f9_arg0)
	f9_arg0.Icon:completeAnimation()
	f9_arg0.Plus:completeAnimation()
	f9_arg0.ProgressBarFront:completeAnimation()
	f9_arg0.ProgressBarBack:completeAnimation()
	f9_arg0.EmptyRing:completeAnimation()
	f9_arg0.EmptyFill:completeAnimation()
	f9_arg0.ProgressBarComplete:completeAnimation()
	f9_arg0.Check:completeAnimation()
	f9_arg0.Icon:setRGB(1, 1, 1)
	f9_arg0.Icon:setAlpha(1)
	f9_arg0.Plus:setRGB(0.45, 0.45, 0.45)
	f9_arg0.Plus:setAlpha(0)
	f9_arg0.ProgressBarFront:setAlpha(1)
	f9_arg0.ProgressBarBack:setAlpha(1)
	f9_arg0.EmptyRing:setAlpha(0)
	f9_arg0.EmptyFill:setAlpha(0)
	f9_arg0.ProgressBarComplete:setAlpha(0)
	f9_arg0.Check:setAlpha(0)
end
CoD.BM_SmallContractProgress.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
	Empty = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(6)
			f11_arg0.EmptyFill:completeAnimation()
			f11_arg0.EmptyFill:setAlpha(0.05)
			f11_arg0.clipFinished(f11_arg0.EmptyFill)
			f11_arg0.EmptyRing:completeAnimation()
			f11_arg0.EmptyRing:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.EmptyRing)
			f11_arg0.ProgressBarBack:completeAnimation()
			f11_arg0.ProgressBarBack:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.ProgressBarBack)
			f11_arg0.ProgressBarFront:completeAnimation()
			f11_arg0.ProgressBarFront:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.ProgressBarFront)
			f11_arg0.Icon:completeAnimation()
			f11_arg0.Icon:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Icon)
			f11_arg0.Plus:completeAnimation()
			f11_arg0.Plus:setRGB(0.45, 0.45, 0.45)
			f11_arg0.Plus:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.Plus)
		end,
	},
	Completed = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(4)
			f12_arg0.ProgressBarFront:completeAnimation()
			f12_arg0.ProgressBarFront:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.ProgressBarFront)
			f12_arg0.ProgressBarComplete:completeAnimation()
			f12_arg0.ProgressBarComplete:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.ProgressBarComplete)
			f12_arg0.Icon:completeAnimation()
			f12_arg0.Icon:setRGB(0.64, 0.64, 0.64)
			f12_arg0.clipFinished(f12_arg0.Icon)
			f12_arg0.Check:completeAnimation()
			f12_arg0.Check:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.Check)
		end,
	},
}
CoD.BM_SmallContractProgress.__onClose = function(f13_arg0)
	f13_arg0.ProgressBarFront:close()
	f13_arg0.ProgressBarComplete:close()
	f13_arg0.Icon:close()
end
