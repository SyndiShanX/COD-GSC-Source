CoD.Client_Gamertag = InheritFrom(LUI.UIElement)
CoD.Client_Gamertag.__defaultWidth = 189
CoD.Client_Gamertag.__defaultHeight = 18
CoD.Client_Gamertag.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIHorizontalList.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9, 0, false)
	self:setAlignment(LUI.Alignment.Left)
	self:setClass(CoD.Client_Gamertag)
	self.id = "Client_Gamertag"
	self.soundSet = "default"
	local Gamertag = LUI.UIText.new(0, 0, 0, 157, 0, 0, 0, 18)
	Gamertag:setTTF("notosans_regular")
	Gamertag:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Gamertag:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	Gamertag:linkToElementModel(self, "clientNum", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Gamertag:setRGB(ClientGamertagColor(f1_arg1, f2_local0))
		end
	end)
	Gamertag:linkToElementModel(self, "playerName", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Gamertag:setText(CoD.SocialUtility.CleanGamerTag(f3_local0))
		end
	end)
	self:addElement(Gamertag)
	self.Gamertag = Gamertag
	local VOIPImage = LUI.UIImage.new(0, 0, 157, 175, 0, 0, 0, 18)
	VOIPImage:linkToElementModel(self, "clientNum", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			VOIPImage:setupVoipImage(f4_local0)
		end
	end)
	self:addElement(VOIPImage)
	self.VOIPImage = VOIPImage
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.Client_Gamertag.__onClose = function(f5_arg0)
	f5_arg0.Gamertag:close()
	f5_arg0.VOIPImage:close()
end
