require("x64:91abf36175e7af9")
require("x64:c54482aba1c66e0")
require("x64:fd51e83e2e6dbd1")
CoD.WZTeamPlayerInfo = InheritFrom(LUI.UIElement)
CoD.WZTeamPlayerInfo.__defaultWidth = 385
CoD.WZTeamPlayerInfo.__defaultHeight = 27
CoD.WZTeamPlayerInfo.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 2, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.WZTeamPlayerInfo)
	self.id = "WZTeamPlayerInfo"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	local IDBacker = CoD.WZTeamPlayerInfoNumber.new(f1_arg0, f1_arg1, 0, 0, 0, 23, 0, 0, 2, 25)
	IDBacker:linkToElementModel(self, nil, false, function(model)
		IDBacker:setModel(model, f1_arg1)
	end)
	self:addElement(IDBacker)
	self.IDBacker = IDBacker
	local LblClan = LUI.UIText.new(0, 0, 25, 70, 1, 1, -22.5, -4.5)
	LblClan:setTTF("notosans_regular")
	LblClan:setLetterSpacing(1)
	LblClan:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	LblClan:linkToElementModel(self, "clanTag", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			LblClan:setText(StringAsClanTag(f3_local0))
		end
	end)
	self:addElement(LblClan)
	self.LblClan = LblClan
	local Gamertag = LUI.UIText.new(0, 0, 72, 180, 0, 0, 4.5, 22.5)
	Gamertag:setText("")
	Gamertag:setTTF("notosans_regular")
	Gamertag:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Gamertag:linkToElementModel(self, "playerName", true, function(model)
		CoD.ModelUtility.SetTextIfNotNilAndNotEmptyString(Gamertag, model)
	end)
	self:addElement(Gamertag)
	self.Gamertag = Gamertag
	local voipCustomElement = CoD.VoipContainer.new(f1_arg0, f1_arg1, 0, 0, 182, 203, 0, 0, 3, 24)
	voipCustomElement:linkToElementModel(self, nil, false, function(model)
		voipCustomElement:setModel(model, f1_arg1)
	end)
	self:addElement(voipCustomElement)
	self.voipCustomElement = voipCustomElement
	local Marker = CoD.onOffImage.new(f1_arg0, f1_arg1, 0, 0, 205, 226, 0, 0, 3, 24)
	Marker:mergeStateConditions({
		{
			stateName = "On",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueTrue(self, f1_arg1, "isMarkerIconPlaced")
			end,
		},
	})
	Marker:linkToElementModel(Marker, "isMarkerIconPlaced", true, function(model)
		f1_arg0:updateElementState(Marker, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isMarkerIconPlaced",
		})
	end)
	Marker.image:setImage(RegisterImage(@"hash_1D7A457D12DA6B12"))
	Marker.image:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_normal"))
	Marker.__Color = function(f8_arg0)
		local f8_local0 = f8_arg0:get()
		if f8_local0 ~= nil then
			Marker:setRGB(CoD.WZUtility.TeamPlayerColorForTeammateIndex(f1_arg1, f8_local0))
		end
	end
	Marker:linkToElementModel(self, "teammateIndex", true, Marker.__Color)
	Marker.__Color_FullPath = function()
		local f9_local0 = self:getModel()
		if f9_local0 then
			f9_local0 = self:getModel()
			f9_local0 = f9_local0.teammateIndex
		end
		if f9_local0 then
			Marker.__Color(f9_local0)
		end
	end
	Marker:linkToElementModel(self, nil, false, function(model)
		Marker:setModel(model, f1_arg1)
	end)
	self:addElement(Marker)
	self.Marker = Marker
	Marker:linkToElementModel(self, "team", true, Marker.__Color_FullPath)
	local f1_local6 = Marker
	local f1_local7 = Marker.subscribeToModel
	local f1_local8 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local7(f1_local6, f1_local8["profile.colorblindMode"], Marker.__Color_FullPath)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WZTeamPlayerInfo.__onClose = function(f11_arg0)
	f11_arg0.IDBacker:close()
	f11_arg0.LblClan:close()
	f11_arg0.Gamertag:close()
	f11_arg0.voipCustomElement:close()
	f11_arg0.Marker:close()
end
