CoD.CODCasterTeamFlare = InheritFrom(LUI.UIElement)
CoD.CODCasterTeamFlare.__defaultWidth = 180
CoD.CODCasterTeamFlare.__defaultHeight = 180
CoD.CODCasterTeamFlare.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.CODCasterTeamFlare)
	self.id = "CODCasterTeamFlare"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local FlareBase = LUI.UIImage.new(0.5, 0.5, -90, 90, 0.5, 0.5, -90, 90)
	FlareBase:setAlpha(0)
	FlareBase:setImage(RegisterImage(0xC4CCD81B90B0241))
	FlareBase:subscribeToGlobalModel(f1_arg1, "DeadSpectate", "playerIndex", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			FlareBase:setRGB(TeamColorFromPlayerIndex(f1_arg1, f2_local0))
		end
	end)
	self:addElement(FlareBase)
	self.FlareBase = FlareBase
	local FlareTop = LUI.UIImage.new(0.5, 0.5, -66, 66, 0.5, 0.5, -66, 66)
	FlareTop:setAlpha(0)
	FlareTop:setImage(RegisterImage(0x86A85E0C09931D2))
	FlareTop:setMaterial(LUI.UIImage.GetCachedMaterial(0x4E6CE42E0799F57))
	self:addElement(FlareTop)
	self.FlareTop = FlareTop
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
CoD.CODCasterTeamFlare.__resetProperties = function(f5_arg0)
	f5_arg0.FlareBase:completeAnimation()
	f5_arg0.FlareTop:completeAnimation()
	f5_arg0.FlareBase:setAlpha(0)
	f5_arg0.FlareTop:setAlpha(0)
end
CoD.CODCasterTeamFlare.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(0)
		end,
	},
	CODCaster = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.FlareBase:completeAnimation()
			f7_arg0.FlareBase:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.FlareBase)
			f7_arg0.FlareTop:completeAnimation()
			f7_arg0.FlareTop:setAlpha(0.8)
			f7_arg0.clipFinished(f7_arg0.FlareTop)
		end,
	},
}
CoD.CODCasterTeamFlare.__onClose = function(f8_arg0)
	f8_arg0.FlareBase:close()
end
