CoD.CodCasterPlayerListRowHighlight = InheritFrom(LUI.UIElement)
CoD.CodCasterPlayerListRowHighlight.__defaultWidth = 404
CoD.CodCasterPlayerListRowHighlight.__defaultHeight = 16
CoD.CodCasterPlayerListRowHighlight.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CodCasterPlayerListRowHighlight)
	self.id = "CodCasterPlayerListRowHighlight"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local alliesbg = LUI.UIImage.new(0.5, 0.5, -202, 202, 0, 0, 0, 16)
	alliesbg:setImage(RegisterImage(@"hash_BD8D43404DC456"))
	alliesbg:subscribeToGlobalModel(f1_arg1, "Factions", "alliesFactionColor", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			alliesbg:setRGB(f2_local0)
		end
	end)
	self:addElement(alliesbg)
	self.alliesbg = alliesbg
	local axisbg = LUI.UIImage.new(0.5, 0.5, -202, 202, 0, 0, 0, 16)
	axisbg:setImage(RegisterImage(@"hash_BD8D43404DC456"))
	axisbg:subscribeToGlobalModel(f1_arg1, "Factions", "axisFactionColor", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			axisbg:setRGB(f3_local0)
		end
	end)
	self:addElement(axisbg)
	self.axisbg = axisbg
	local freebg = LUI.UIImage.new(0.5, 0.5, -202, 202, 0, 0, 0, 16)
	freebg:setImage(RegisterImage(@"hash_BD8D43404DC456"))
	self:addElement(freebg)
	self.freebg = freebg
	self:mergeStateConditions({
		{
			stateName = "Allies",
			condition = function(menu, element, event)
				local f4_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "team", Enum[@"team_t"][@"team_allies"])
				if f4_local0 then
					f4_local0 = IsGametypeTeambased()
					if f4_local0 then
						f4_local0 = CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "health.healthValue", 0)
					end
				end
				return f4_local0
			end,
		},
		{
			stateName = "Axis",
			condition = function(menu, element, event)
				local f5_local0 = CoD.ModelUtility.IsSelfModelValueEqualToEnum(element, f1_arg1, "team", Enum[@"team_t"][@"team_axis"])
				if f5_local0 then
					f5_local0 = IsGametypeTeambased()
					if f5_local0 then
						f5_local0 = CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "health.healthValue", 0)
					end
				end
				return f5_local0
			end,
		},
		{
			stateName = "Free",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	self:linkToElementModel(self, "team", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "team",
		})
	end)
	self:linkToElementModel(self, "health.healthValue", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "health.healthValue",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CodCasterPlayerListRowHighlight.__resetProperties = function(f9_arg0)
	f9_arg0.freebg:completeAnimation()
	f9_arg0.axisbg:completeAnimation()
	f9_arg0.alliesbg:completeAnimation()
	f9_arg0.freebg:setRGB(1, 1, 1)
	f9_arg0.freebg:setAlpha(1)
	f9_arg0.axisbg:setAlpha(1)
	f9_arg0.alliesbg:setAlpha(1)
end
CoD.CodCasterPlayerListRowHighlight.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
	Allies = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.axisbg:completeAnimation()
			f11_arg0.axisbg:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.axisbg)
			f11_arg0.freebg:completeAnimation()
			f11_arg0.freebg:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.freebg)
		end,
	},
	Axis = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.alliesbg:completeAnimation()
			f12_arg0.alliesbg:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.alliesbg)
			f12_arg0.freebg:completeAnimation()
			f12_arg0.freebg:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.freebg)
		end,
	},
	Free = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(3)
			f13_arg0.alliesbg:completeAnimation()
			f13_arg0.alliesbg:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.alliesbg)
			f13_arg0.axisbg:completeAnimation()
			f13_arg0.axisbg:setAlpha(0)
			f13_arg0.clipFinished(f13_arg0.axisbg)
			f13_arg0.freebg:completeAnimation()
			f13_arg0.freebg:setRGB(0.49, 0.49, 0.49)
			f13_arg0.clipFinished(f13_arg0.freebg)
		end,
	},
}
CoD.CodCasterPlayerListRowHighlight.__onClose = function(f14_arg0)
	f14_arg0.alliesbg:close()
	f14_arg0.axisbg:close()
end
