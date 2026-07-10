CoD.ScoreInfoEscortBarProgress = InheritFrom(LUI.UIElement)
CoD.ScoreInfoEscortBarProgress.__defaultWidth = 164
CoD.ScoreInfoEscortBarProgress.__defaultHeight = 6
CoD.ScoreInfoEscortBarProgress.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.ScoreInfoEscortBarProgress)
	self.id = "ScoreInfoEscortBarProgress"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local meterBacking = LUI.UIImage.new(0.5, 0.5, -133, 133, 0.5, 0.5, -8, 8)
	meterBacking:setRGB(0.21, 0.21, 0.21)
	meterBacking:setAlpha(0.8)
	meterBacking:setScale(0.63, 0.63)
	meterBacking:setImage(RegisterImage(0x3674F9B5EAEF4ED))
	meterBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0xE125638BF94665F))
	meterBacking:setShaderVector(0, 0.01, 0.02, 0.01, 0.02)
	self:addElement(meterBacking)
	self.meterBacking = meterBacking
	local ProgressBar = LUI.UIImage.new(0, 1, 0, 0, 0, 0, -1, 7)
	ProgressBar:setImage(RegisterImage(0x3B9CBB9BBA5608))
	ProgressBar:setMaterial(LUI.UIImage.GetCachedMaterial(0x316E67E1DF2198E))
	ProgressBar:setShaderVector(1, 0, 0, 0, 0)
	ProgressBar:setShaderVector(2, 1, 0, 0, 0)
	ProgressBar:setShaderVector(3, 0, 0, 0, 0)
	ProgressBar:setShaderVector(4, 0, 0, 0, 0)
	ProgressBar:subscribeToGlobalModel(f1_arg1, "Escort", "robotProgress", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ProgressBar:setShaderVector(0, CoD.GetVectorComponentFromString(f2_local0, 1), CoD.GetVectorComponentFromString(f2_local0, 2), CoD.GetVectorComponentFromString(f2_local0, 3), CoD.GetVectorComponentFromString(f2_local0, 4))
		end
	end)
	ProgressBar:linkToElementModel(self, "color", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ProgressBar:setRGB(CoD.WaypointUtility.ConvertToBaseColor(f3_local0))
		end
	end)
	self:addElement(ProgressBar)
	self.ProgressBar = ProgressBar
	local ProgressToBeat = LUI.UIImage.new(0, 0, -5, 5, 0, 0, -2, 8)
	ProgressToBeat:setImage(RegisterImage(0xD1DE2C85ADA1241))
	ProgressToBeat:subscribeToGlobalModel(f1_arg1, "Escort", "robotProgressToBeat", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			ProgressToBeat:setLeftPct(f4_local0)
		end
	end)
	ProgressToBeat:linkToElementModel(self, "color", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			ProgressToBeat:setRGB(CoD.WaypointUtility.ConvertToBrightColor(f5_local0))
		end
	end)
	self:addElement(ProgressToBeat)
	self.ProgressToBeat = ProgressToBeat
	self:mergeStateConditions({
		{
			stateName = "Overtime",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsGlobalModelValueGreaterThan("Escort.robotProgressToBeat", 0)
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[0x8DF2E5447F384B9]()
	f1_local5(f1_local4, f1_local6["Escort.robotProgressToBeat"], function(f7_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f7_arg0:get(),
			modelName = "Escort.robotProgressToBeat",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.ScoreInfoEscortBarProgress.__resetProperties = function(f8_arg0)
	f8_arg0.ProgressToBeat:completeAnimation()
	f8_arg0.ProgressToBeat:setAlpha(1)
end
CoD.ScoreInfoEscortBarProgress.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.ProgressToBeat:completeAnimation()
			f9_arg0.ProgressToBeat:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.ProgressToBeat)
		end,
	},
	Overtime = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.ScoreInfoEscortBarProgress.__onClose = function(f11_arg0)
	f11_arg0.ProgressBar:close()
	f11_arg0.ProgressToBeat:close()
end
