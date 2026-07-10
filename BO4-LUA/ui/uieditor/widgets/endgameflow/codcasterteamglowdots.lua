CoD.CODCasterTeamGlowDots = InheritFrom(LUI.UIElement)
CoD.CODCasterTeamGlowDots.__defaultWidth = 10
CoD.CODCasterTeamGlowDots.__defaultHeight = 146
CoD.CODCasterTeamGlowDots.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CODCasterTeamGlowDots)
	self.id = "CODCasterTeamGlowDots"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local GlowDotsCODCaster = LUI.UIImage.new(0, 0, 0, 10, 0, 0, 0, 146)
	GlowDotsCODCaster:setAlpha(0)
	GlowDotsCODCaster:setImage(RegisterImage(0xED10A9493081AC0))
	GlowDotsCODCaster:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	GlowDotsCODCaster:setShaderVector(0, 1.5, 0, 0, 0)
	GlowDotsCODCaster:subscribeToGlobalModel(f1_arg1, "DeadSpectate", "playerIndex", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			GlowDotsCODCaster:setRGB(TeamColorFromPlayerIndex(f1_arg1, f2_local0))
		end
	end)
	self:addElement(GlowDotsCODCaster)
	self.GlowDotsCODCaster = GlowDotsCODCaster
	local GlowDotsDefault = LUI.UIImage.new(0, 0, 0, 10, 0, 0, 0, 146)
	GlowDotsDefault:setRGB(1, 0.68, 0)
	GlowDotsDefault:setAlpha(0)
	GlowDotsDefault:setImage(RegisterImage(0xED10A9493081AC0))
	GlowDotsDefault:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	GlowDotsDefault:setShaderVector(0, 1.5, 0, 0, 0)
	self:addElement(GlowDotsDefault)
	self.GlowDotsDefault = GlowDotsDefault
	self:mergeStateConditions({
		{
			stateName = "CODCaster",
			condition = function(menu, element, event)
				return IsCodCaster(f1_arg1)
			end,
		},
	})
	local f1_local3 = self
	local f1_local4 = self.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["factions.isCoDCaster"], function(f4_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "factions.isCoDCaster",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.CODCasterTeamGlowDots.__resetProperties = function(f5_arg0)
	f5_arg0.GlowDotsCODCaster:completeAnimation()
	f5_arg0.GlowDotsDefault:completeAnimation()
	f5_arg0.GlowDotsCODCaster:setAlpha(0)
	f5_arg0.GlowDotsDefault:setAlpha(0)
end
CoD.CODCasterTeamGlowDots.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.GlowDotsCODCaster:completeAnimation()
			f6_arg0.GlowDotsCODCaster:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.GlowDotsCODCaster)
			f6_arg0.GlowDotsDefault:completeAnimation()
			f6_arg0.GlowDotsDefault:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.GlowDotsDefault)
		end,
	},
	CODCaster = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.GlowDotsCODCaster:completeAnimation()
			f7_arg0.GlowDotsCODCaster:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.GlowDotsCODCaster)
			f7_arg0.GlowDotsDefault:completeAnimation()
			f7_arg0.GlowDotsDefault:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.GlowDotsDefault)
		end,
	},
}
CoD.CODCasterTeamGlowDots.__onClose = function(f8_arg0)
	f8_arg0.GlowDotsCODCaster:close()
end
