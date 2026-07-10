require("x64:228a7baa572b047")
require("x64:2eff9733aa0a59e")
CoD.freeCursorIdentityPanel = InheritFrom(LUI.UIElement)
CoD.freeCursorIdentityPanel.__defaultWidth = 369
CoD.freeCursorIdentityPanel.__defaultHeight = 89
CoD.freeCursorIdentityPanel.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.freeCursorIdentityPanel)
	self.id = "freeCursorIdentityPanel"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Image = LUI.UIImage.new(0, 0, 0, 112, 0, 0, 0.5, 64.5)
	Image:setRGB(0, 0, 0)
	Image:setAlpha(0.8)
	Image:setZoom(1)
	self:addElement(Image)
	self.Image = Image
	local emblem = LUI.UIImage.new(0, 0, 2.5, 108.5, 0, 0, 0.5, 64.5)
	emblem:setZoom(1)
	emblem:linkToElementModel(self, "xuid", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			emblem:setupPlayerEmblemByXUID(f2_local0)
		end
	end)
	self:addElement(emblem)
	self.emblem = emblem
	local CallingCardsFrameWidget = CoD.CallingCards_FrameWidget.new(f1_arg0, f1_arg1, 0, 0, 112, 372, 0, 0, 0.5, 65.5)
	CallingCardsFrameWidget:setRGB(0.9, 0.9, 0.9)
	CallingCardsFrameWidget:linkToElementModel(self, nil, false, function(model)
		CallingCardsFrameWidget:setModel(model, f1_arg1)
	end)
	self:addElement(CallingCardsFrameWidget)
	self.CallingCardsFrameWidget = CallingCardsFrameWidget
	local sizeElement = LUI.UIImage.new(0, 0, 0, 369, 0, 0, 0.5, 64.5)
	sizeElement:setAlpha(0)
	self:addElement(sizeElement)
	self.sizeElement = sizeElement
	local gamertag = LUI.UIText.new(0, 0, 118.5, 367.5, 0, 0, 6.5, 32.5)
	gamertag:setTTF("notosans_regular")
	gamertag:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	gamertag:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	gamertag:linkToElementModel(self, "xuid", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			gamertag:setText(CoD.FreeCursorUtility.XUIDToClientName(f1_arg1, f4_local0))
		end
	end)
	self:addElement(gamertag)
	self.gamertag = gamertag
	local clantag = LUI.UIText.new(0, 0, 118.5, 367.5, 0, 0, 31, 52)
	clantag:setTTF("notosans_regular")
	clantag:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	clantag:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	clantag:linkToElementModel(self, "xuid", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			clantag:setText(StringAsClanTag(CoD.FreeCursorUtility.XUIDToClanTag(f1_arg1, f5_local0)))
		end
	end)
	self:addElement(clantag)
	self.clantag = clantag
	local PartyLeaderText = CoD.freeCursorPartyLeader.new(f1_arg0, f1_arg1, 0, 0, 0, 369, 0, 0, 65, 89)
	self:addElement(PartyLeaderText)
	self.PartyLeaderText = PartyLeaderText
	self:mergeStateConditions({
		{
			stateName = "PartyLeader",
			condition = function(menu, element, event)
				return CoD.ModelUtility.IsSelfModelValueEqualTo(self, f1_arg1, "isLeader", 1)
			end,
		},
	})
	self:linkToElementModel(self, "isLeader", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "isLeader",
		})
	end)
	CallingCardsFrameWidget.id = "CallingCardsFrameWidget"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local8 = self
	CoD.FreeCursorUtility.UseSelfHeightIfElementVisible(self, self)
	return self
end
CoD.freeCursorIdentityPanel.__resetProperties = function(f8_arg0)
	f8_arg0.PartyLeaderText:completeAnimation()
	f8_arg0.PartyLeaderText:setAlpha(1)
end
CoD.freeCursorIdentityPanel.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.PartyLeaderText:completeAnimation()
			f9_arg0.PartyLeaderText:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.PartyLeaderText)
		end,
	},
	PartyLeader = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.freeCursorIdentityPanel.__onClose = function(f11_arg0)
	f11_arg0.emblem:close()
	f11_arg0.CallingCardsFrameWidget:close()
	f11_arg0.gamertag:close()
	f11_arg0.clantag:close()
	f11_arg0.PartyLeaderText:close()
end
