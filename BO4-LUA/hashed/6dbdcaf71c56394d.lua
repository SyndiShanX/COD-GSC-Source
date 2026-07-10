CoD.WarzoneUseTimerPlayerIcon = InheritFrom(LUI.UIElement)
CoD.WarzoneUseTimerPlayerIcon.__defaultWidth = 36
CoD.WarzoneUseTimerPlayerIcon.__defaultHeight = 36
CoD.WarzoneUseTimerPlayerIcon.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WarzoneUseTimerPlayerIcon)
	self.id = "WarzoneUseTimerPlayerIcon"
	self.soundSet = "default"
	local Backer = LUI.UIImage.new(0, 0, 3, 33, 0, 0, 3, 33)
	Backer.__Color = function(f2_arg0)
		local f2_local0 = f2_arg0:get()
		if f2_local0 ~= nil then
			Backer:setRGB(CoD.WZUtility.TeamPlayerColorForClientNum(f1_arg1, f2_local0))
		end
	end
	Backer:subscribeToGlobalModel(f1_arg1, "HUDItems", "laststand.revivingClientNum", Backer.__Color)
	Backer.__Color_FullPath = function()
		local f3_local0 = DataSources.HUDItems.getModel(f1_arg1)
		f3_local0 = f3_local0["laststand.revivingClientNum"]
		if f3_local0 then
			Backer.__Color(f3_local0)
		end
	end
	self:addElement(Backer)
	self.Backer = Backer
	local TeamNumber = LUI.UIText.new(0, 0, 0, 36, 0, 0, 3, 33)
	TeamNumber:setTTF("dinnext_regular")
	TeamNumber:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	TeamNumber:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	TeamNumber:subscribeToGlobalModel(f1_arg1, "HUDItems", "laststand.revivingClientNum", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			TeamNumber:setText(CoD.WZUtility.ShownPlayerIndexForClientNum(f1_arg1, f4_local0))
		end
	end)
	self:addElement(TeamNumber)
	self.TeamNumber = TeamNumber
	Backer:linkToElementModel(self, "team", true, Backer.__Color_FullPath)
	local f1_local3 = Backer
	local f1_local4 = Backer.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["profile.colorblindMode"], Backer.__Color_FullPath)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WarzoneUseTimerPlayerIcon.__onClose = function(f5_arg0)
	f5_arg0.Backer:close()
	f5_arg0.TeamNumber:close()
end
