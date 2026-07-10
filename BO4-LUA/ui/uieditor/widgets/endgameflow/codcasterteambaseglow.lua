CoD.CODCasterTeamBaseGlow = InheritFrom(LUI.UIElement)
CoD.CODCasterTeamBaseGlow.__defaultWidth = 366
CoD.CODCasterTeamBaseGlow.__defaultHeight = 865
CoD.CODCasterTeamBaseGlow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CODCasterTeamBaseGlow)
	self.id = "CODCasterTeamBaseGlow"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local GlowCODCaster = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	GlowCODCaster:setAlpha(0)
	GlowCODCaster:setImage(RegisterImage(0xC71A85C6EC3CE40))
	GlowCODCaster:subscribeToGlobalModel(f1_arg1, "DeadSpectate", "playerIndex", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			GlowCODCaster:setRGB(TeamColorFromPlayerIndex(f1_arg1, f2_local0))
		end
	end)
	self:addElement(GlowCODCaster)
	self.GlowCODCaster = GlowCODCaster
	local GlowDefault = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	GlowDefault:setRGB(0.74, 0.3, 0)
	GlowDefault:setAlpha(0)
	GlowDefault:setImage(RegisterImage(0xC71A85C6EC3CE40))
	self:addElement(GlowDefault)
	self.GlowDefault = GlowDefault
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
CoD.CODCasterTeamBaseGlow.__resetProperties = function(f5_arg0)
	f5_arg0.GlowDefault:completeAnimation()
	f5_arg0.GlowCODCaster:completeAnimation()
	f5_arg0.GlowDefault:setAlpha(0)
	f5_arg0.GlowCODCaster:setAlpha(0)
end
CoD.CODCasterTeamBaseGlow.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.GlowCODCaster:completeAnimation()
			f6_arg0.GlowCODCaster:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.GlowCODCaster)
			f6_arg0.GlowDefault:completeAnimation()
			f6_arg0.GlowDefault:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.GlowDefault)
		end,
	},
	CODCaster = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.GlowCODCaster:completeAnimation()
			f7_arg0.GlowCODCaster:setAlpha(0.8)
			f7_arg0.clipFinished(f7_arg0.GlowCODCaster)
			f7_arg0.GlowDefault:completeAnimation()
			f7_arg0.GlowDefault:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.GlowDefault)
		end,
	},
}
CoD.CODCasterTeamBaseGlow.__onClose = function(f8_arg0)
	f8_arg0.GlowCODCaster:close()
end
