CoD.OverheadName_WZ_PlayerNumber = InheritFrom(LUI.UIElement)
CoD.OverheadName_WZ_PlayerNumber.__defaultWidth = 27
CoD.OverheadName_WZ_PlayerNumber.__defaultHeight = 27
CoD.OverheadName_WZ_PlayerNumber.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.OverheadName_WZ_PlayerNumber)
	self.id = "OverheadName_WZ_PlayerNumber"
	self.soundSet = "default"
	local Image = LUI.UIImage.new(0.43, 1.43, -11.5, -11.5, 0, 1, 0, 0)
	Image:setImage(RegisterImage(0xB63170C49335443))
	Image.__Color = function(f2_arg0)
		local f2_local0 = f2_arg0:get()
		if f2_local0 ~= nil then
			Image:setRGB(CoD.WZUtility.TeamPlayerColorForTeammateIndex(f1_arg1, f2_local0))
		end
	end
	Image:linkToElementModel(self, "teammateIndex", true, Image.__Color)
	Image.__Color_FullPath = function()
		local f3_local0 = self:getModel()
		if f3_local0 then
			f3_local0 = self:getModel()
			f3_local0 = f3_local0.teammateIndex
		end
		if f3_local0 then
			Image.__Color(f3_local0)
		end
	end
	self:addElement(Image)
	self.Image = Image
	local IDNumber2 = LUI.UIText.new(0.5, 0.5, -11, 12, 0, 0, 2.5, 25.5)
	IDNumber2:setTTF("ttmussels_demibold")
	IDNumber2:setMaterial(LUI.UIImage.GetCachedMaterial(0x336C1AE82B1520A))
	IDNumber2:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	IDNumber2:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	IDNumber2:linkToElementModel(self, "teammateIndex", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			IDNumber2:setText(StringAdd(1, CoD.BaseUtility.AlreadyLocalized(f4_local0)))
		end
	end)
	self:addElement(IDNumber2)
	self.IDNumber2 = IDNumber2
	Image:linkToElementModel(self, "team", true, Image.__Color_FullPath)
	local f1_local3 = Image
	local f1_local4 = Image.subscribeToModel
	local f1_local5 = Engine[0x4DF5CFBC1771947](f1_arg1)
	f1_local4(f1_local3, f1_local5["profile.colorblindMode"], Image.__Color_FullPath)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.OverheadName_WZ_PlayerNumber.__onClose = function(f5_arg0)
	f5_arg0.Image:close()
	f5_arg0.IDNumber2:close()
end
