require("x64:226ed7c297df6a5")
CoD.WZObituaryVictim = InheritFrom(LUI.UIElement)
CoD.WZObituaryVictim.__defaultWidth = 168
CoD.WZObituaryVictim.__defaultHeight = 26
CoD.WZObituaryVictim.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 4, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.WZObituaryVictim)
	self.id = "WZObituaryVictim"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Icon = CoD.WZObituaryTeamIcon.new(f1_arg0, f1_arg1, 0, 0, 12, 38, 0, 0, 1, 27)
	Icon:setAlpha(0)
	Icon.Backer.__TeamColor = function(f2_arg0)
		local f2_local0 = f2_arg0:get()
		if f2_local0 ~= nil then
			Icon.Backer:setRGB(CoD.WZUtility.TeamPlayerColorForClientNum(f1_arg1, f2_local0))
		end
	end
	Icon:linkToElementModel(self, "victimClientNum", true, Icon.Backer.__TeamColor)
	Icon.Backer.__TeamColor_FullPath = function()
		local f3_local0 = self:getModel()
		if f3_local0 then
			f3_local0 = self:getModel()
			f3_local0 = f3_local0.victimClientNum
		end
		if f3_local0 then
			Icon.Backer.__TeamColor(f3_local0)
		end
	end
	Icon:linkToElementModel(self, "victimClientNum", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Icon.TeamNumber:setText(CoD.WZUtility.ShownPlayerIndexForClientNum(f1_arg1, f4_local0))
		end
	end)
	self:addElement(Icon)
	self.Icon = Icon
	local Name = LUI.UIText.new(0, 0, 42, 210, 0.48, 0.48, -12.5, 13.5)
	Name:setTTF("notosans_regular")
	Name:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Name.__Color = function(f5_arg0)
		local f5_local0 = f5_arg0:get()
		if f5_local0 ~= nil then
			Name:setRGB(ConsoleColorFromIndex(f1_arg1, f5_local0))
		end
	end
	Name:linkToElementModel(self, "victimColor", true, Name.__Color)
	Name.__Color_FullPath = function()
		local f6_local0 = self:getModel()
		if f6_local0 then
			f6_local0 = self:getModel()
			f6_local0 = f6_local0.victimColor
		end
		if f6_local0 then
			Name.__Color(f6_local0)
		end
	end
	Name:linkToElementModel(self, "victim", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			Name:setText(CoD.SocialUtility.CleanGamerTag(f7_local0))
		end
	end)
	self:addElement(Name)
	self.Name = Name
	Icon:linkToElementModel(self, "team", true, Icon.Backer.__TeamColor_FullPath)
	local f1_local3 = Icon
	local f1_local4 = Icon.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["profile.colorblindMode"], Icon.Backer.__TeamColor_FullPath)
	f1_local3 = Name
	f1_local4 = Name.subscribeToModel
	f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["profile.colorblindMode"], Name.__Color_FullPath)
	self:mergeStateConditions({
		{
			stateName = "Friendly",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueGreaterThanOrEqualTo(element, f1_arg1, "victimClientNum", 0)
			end,
		},
	})
	self:linkToElementModel(self, "victimClientNum", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "victimClientNum",
		})
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZObituaryVictim.__resetProperties = function(f10_arg0)
	f10_arg0.Icon:completeAnimation()
	f10_arg0.Icon:setAlpha(0)
end
CoD.WZObituaryVictim.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(0)
		end,
	},
	Friendly = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(1)
			f12_arg0.Icon:beginAnimation(100)
			f12_arg0.Icon:setAlpha(1)
			f12_arg0.Icon:registerEventHandler("interrupted_keyframe", f12_arg0.clipInterrupted)
			f12_arg0.Icon:registerEventHandler("transition_complete_keyframe", f12_arg0.clipFinished)
		end,
	},
}
CoD.WZObituaryVictim.__onClose = function(f13_arg0)
	f13_arg0.Icon:close()
	f13_arg0.Name:close()
end
