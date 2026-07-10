CoD.HealthBarPulse = InheritFrom(LUI.UIElement)
CoD.HealthBarPulse.__defaultWidth = 130
CoD.HealthBarPulse.__defaultHeight = 16
CoD.HealthBarPulse.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HealthBarPulse)
	self.id = "HealthBarPulse"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local PulseBar = LUI.UIImage.new(0, 0, -2, 132, 0, 0, 2.5, 12.5)
	PulseBar:setImage(RegisterImage(0xD5B703C3B0F386D))
	PulseBar:setMaterial(LUI.UIImage.GetCachedMaterial(0x7EA4827662D4CD4))
	PulseBar:setShaderVector(0, 4, 1, 0, 0)
	PulseBar:setShaderVector(1, 0, 1, -0, 1)
	PulseBar.__Color = function(f2_arg0)
		local f2_local0 = f2_arg0:get()
		if f2_local0 ~= nil then
			PulseBar:setRGB(CoD.HUDUtility.GetFriendlyOrEnemyHealthBarPulseColorByTeamId(f1_arg1, f2_local0))
		end
	end
	PulseBar:linkToElementModel(self, "team", true, PulseBar.__Color)
	PulseBar.__Color_FullPath = function()
		local f3_local0 = self:getModel()
		if f3_local0 then
			f3_local0 = self:getModel()
			f3_local0 = f3_local0.team
		end
		if f3_local0 then
			PulseBar.__Color(f3_local0)
		end
	end
	self:addElement(PulseBar)
	self.PulseBar = PulseBar
	local f1_local2 = PulseBar
	local f1_local3 = PulseBar.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["factions.playerFactionTeamEnum"], PulseBar.__Color_FullPath)
	f1_local2 = PulseBar
	f1_local3 = PulseBar.subscribeToModel
	f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local3(f1_local2, f1_local4["profile.colorblindMode"], PulseBar.__Color_FullPath)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.HealthBarPulse.__resetProperties = function(f4_arg0)
	f4_arg0.PulseBar:completeAnimation()
	f4_arg0.PulseBar:setLeftRight(0, 0, -2, 132)
	f4_arg0.PulseBar:setTopBottom(0, 0, 2.5, 12.5)
	f4_arg0.PulseBar:setAlpha(1)
end
CoD.HealthBarPulse.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f5_arg0, f5_arg1)
			f5_arg0:__resetProperties()
			f5_arg0:setupElementClipCounter(1)
			local f5_local0 = function(f6_arg0)
				local f6_local0 = function(f7_arg0)
					local f7_local0 = function(f8_arg0)
						f8_arg0:beginAnimation(59)
						f8_arg0:setTopBottom(0, 0, -292.5, 307.5)
						f8_arg0:setAlpha(0)
						f8_arg0:registerEventHandler("transition_complete_keyframe", f5_arg0.clipFinished)
					end
					f7_arg0:beginAnimation(60)
					f7_arg0:setTopBottom(0, 0, -155, 170)
					f7_arg0:setAlpha(0.25)
					f7_arg0:registerEventHandler("transition_complete_keyframe", f7_local0)
				end
				f5_arg0.PulseBar:beginAnimation(40)
				f5_arg0.PulseBar:setTopBottom(0, 0, -17.5, 32.5)
				f5_arg0.PulseBar:setAlpha(1)
				f5_arg0.PulseBar:registerEventHandler("interrupted_keyframe", f5_arg0.clipInterrupted)
				f5_arg0.PulseBar:registerEventHandler("transition_complete_keyframe", f6_local0)
			end
			f5_arg0.PulseBar:completeAnimation()
			f5_arg0.PulseBar:setLeftRight(0, 0, -2, 132)
			f5_arg0.PulseBar:setTopBottom(0, 0, 2.5, 12.5)
			f5_arg0.PulseBar:setAlpha(0)
			f5_local0(f5_arg0.PulseBar)
		end,
	},
}
CoD.HealthBarPulse.__onClose = function(f9_arg0)
	f9_arg0.PulseBar:close()
end
