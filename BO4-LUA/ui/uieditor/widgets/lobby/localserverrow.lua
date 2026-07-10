CoD.LocalServerRow = InheritFrom(LUI.UIElement)
CoD.LocalServerRow.__defaultWidth = 1070
CoD.LocalServerRow.__defaultHeight = 37
CoD.LocalServerRow.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.LocalServerRow)
	self.id = "LocalServerRow"
	self.soundSet = "default"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local BlackBar = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 1, 1)
	BlackBar:setRGB(0.78, 0.78, 0.78)
	BlackBar:setAlpha(0.01)
	self:addElement(BlackBar)
	self.BlackBar = BlackBar
	local Status = LUI.UIText.new(0, 0, 830, 1031, 0, 0, 6.5, 30.5)
	Status:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Status:setTTF("ttmussels_regular")
	Status:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Status:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(Status)
	self.Status = Status
	local GameType = LUI.UIText.new(0, 0, 551, 824, 0, 0, 6.5, 30.5)
	GameType:setRGB(0.78, 0.78, 0.78)
	GameType:setTTF("ttmussels_regular")
	GameType:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	GameType:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(GameType)
	self.GameType = GameType
	local ClientCount = LUI.UIText.new(0, 0, 413, 470, 0, 0, 6.5, 30.5)
	ClientCount:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	ClientCount:setTTF("0arame_mono_stencil")
	ClientCount:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ClientCount:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(ClientCount)
	self.ClientCount = ClientCount
	local HostName = LUI.UIText.new(0, 0, 15, 413, 0, 0, 6.5, 30.5)
	HostName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	HostName:setTTF("ttmussels_regular")
	HostName:setLetterSpacing(1)
	HostName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	HostName:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(HostName)
	self.HostName = HostName
	self.Status:linkToElementModel(self, "status", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Status:setText(Engine[@"hash_4F9F1239CFD921FE"](LocalServerStatusToString(f2_local0)))
		end
	end)
	self.GameType:linkToElementModel(self, "sessionMode", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			GameType:setText(SessionModeToLocalizedSessionMode(f3_local0))
		end
	end)
	self.ClientCount:linkToElementModel(self, "clientCount", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			ClientCount:setText(f4_local0)
		end
	end)
	HostName.__String_Reference = function(f5_arg0)
		local f5_local0 = f5_arg0:get()
		if f5_local0 ~= nil then
			HostName:setText(PrependClanTagToHostname(self:getModel(), f5_local0))
		end
	end
	self.HostName:linkToElementModel(self, "gamertag", true, HostName.__String_Reference)
	HostName.__String_Reference_FullPath = function()
		local f6_local0 = self.HostName:getModel()
		if f6_local0 then
			f6_local0 = self.HostName:getModel()
			f6_local0 = f6_local0.gamertag
		end
		if f6_local0 then
			HostName.__String_Reference(f6_local0)
		end
	end
	HostName:linkToElementModel(self, "clantag", true, HostName.__String_Reference_FullPath)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.LocalServerRow.__resetProperties = function(f7_arg0)
	f7_arg0.BlackBar:completeAnimation()
	f7_arg0.HostName:completeAnimation()
	f7_arg0.ClientCount:completeAnimation()
	f7_arg0.GameType:completeAnimation()
	f7_arg0.Status:completeAnimation()
	f7_arg0.BlackBar:setRGB(0.78, 0.78, 0.78)
	f7_arg0.BlackBar:setAlpha(0.01)
	f7_arg0.HostName:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	f7_arg0.HostName:setAlpha(1)
	f7_arg0.ClientCount:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	f7_arg0.GameType:setRGB(0.78, 0.78, 0.78)
	f7_arg0.Status:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
end
CoD.LocalServerRow.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			f8_arg0.BlackBar:completeAnimation()
			f8_arg0.BlackBar:setRGB(0.71, 0.71, 0.71)
			f8_arg0.BlackBar:setAlpha(0.01)
			f8_arg0.clipFinished(f8_arg0.BlackBar)
			f8_arg0.HostName:completeAnimation()
			f8_arg0.HostName:setAlpha(1)
			f8_arg0.clipFinished(f8_arg0.HostName)
		end,
		Focus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(5)
			f9_arg0.BlackBar:completeAnimation()
			f9_arg0.BlackBar:setRGB(0.82, 0.82, 0.82)
			f9_arg0.BlackBar:setAlpha(0.05)
			f9_arg0.clipFinished(f9_arg0.BlackBar)
			f9_arg0.Status:completeAnimation()
			f9_arg0.Status:setRGB(0.86, 0.86, 0.86)
			f9_arg0.clipFinished(f9_arg0.Status)
			f9_arg0.GameType:completeAnimation()
			f9_arg0.GameType:setRGB(0.94, 0.94, 0.94)
			f9_arg0.clipFinished(f9_arg0.GameType)
			f9_arg0.ClientCount:completeAnimation()
			f9_arg0.ClientCount:setRGB(0.94, 0.94, 0.94)
			f9_arg0.clipFinished(f9_arg0.ClientCount)
			f9_arg0.HostName:completeAnimation()
			f9_arg0.HostName:setRGB(0.93, 0.93, 0)
			f9_arg0.clipFinished(f9_arg0.HostName)
		end,
	},
}
CoD.LocalServerRow.__onClose = function(f10_arg0)
	f10_arg0.Status:close()
	f10_arg0.GameType:close()
	f10_arg0.ClientCount:close()
	f10_arg0.HostName:close()
end
