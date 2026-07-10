CoD.CODCasterTeamBaseBarColor = InheritFrom(LUI.UIElement)
CoD.CODCasterTeamBaseBarColor.__defaultWidth = 12
CoD.CODCasterTeamBaseBarColor.__defaultHeight = 149
CoD.CODCasterTeamBaseBarColor.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CODCasterTeamBaseBarColor)
	self.id = "CODCasterTeamBaseBarColor"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local GlowBaseBarCODCaster = LUI.UIImage.new(0, 0, 0, 12, 0, 0, 0, 149)
	GlowBaseBarCODCaster:setAlpha(0)
	GlowBaseBarCODCaster:subscribeToGlobalModel(f1_arg1, "DeadSpectate", "playerIndex", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			GlowBaseBarCODCaster:setRGB(TeamColorFromPlayerIndex(f1_arg1, f2_local0))
		end
	end)
	self:addElement(GlowBaseBarCODCaster)
	self.GlowBaseBarCODCaster = GlowBaseBarCODCaster
	local GlowBaseBarDefault = LUI.UIImage.new(0, 0, 0, 12, 0, 0, 0, 149)
	GlowBaseBarDefault:setRGB(0.74, 0.3, 0)
	GlowBaseBarDefault:setAlpha(0)
	self:addElement(GlowBaseBarDefault)
	self.GlowBaseBarDefault = GlowBaseBarDefault
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
CoD.CODCasterTeamBaseBarColor.__resetProperties = function(f5_arg0)
	f5_arg0.GlowBaseBarDefault:completeAnimation()
	f5_arg0.GlowBaseBarCODCaster:completeAnimation()
	f5_arg0.GlowBaseBarDefault:setAlpha(0)
	f5_arg0.GlowBaseBarCODCaster:setAlpha(0)
end
CoD.CODCasterTeamBaseBarColor.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(2)
			f6_arg0.GlowBaseBarCODCaster:completeAnimation()
			f6_arg0.GlowBaseBarCODCaster:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.GlowBaseBarCODCaster)
			f6_arg0.GlowBaseBarDefault:completeAnimation()
			f6_arg0.GlowBaseBarDefault:setAlpha(1)
			f6_arg0.clipFinished(f6_arg0.GlowBaseBarDefault)
		end,
	},
	CODCaster = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.GlowBaseBarCODCaster:completeAnimation()
			f7_arg0.GlowBaseBarCODCaster:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.GlowBaseBarCODCaster)
			f7_arg0.GlowBaseBarDefault:completeAnimation()
			f7_arg0.GlowBaseBarDefault:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.GlowBaseBarDefault)
		end,
	},
}
CoD.CODCasterTeamBaseBarColor.__onClose = function(f8_arg0)
	f8_arg0.GlowBaseBarCODCaster:close()
end
