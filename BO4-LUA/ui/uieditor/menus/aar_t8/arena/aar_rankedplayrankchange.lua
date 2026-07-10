require("x64:7b88198daa752db")
require("x64:d019ee604df7ce4")
CoD.AAR_RankedPlayRankChange = InheritFrom(CoD.Menu)
LUI.createMenu.AAR_RankedPlayRankChange = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("AAR_RankedPlayRankChange", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.AAR_RankedPlayRankChange)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	self.anyChildUsesUpdateState = true
	local bg = LUI.UIImage.new(0, 0, 0, 1920, 0, 0, 0.5, 1080.5)
	bg:setRGB(0.37, 0.07, 0.14)
	self:addElement(bg)
	self.bg = bg
	local RankUpDown = LUI.UIText.new(0, 0, 824, 1024, 0, 0, 130.5, 167.5)
	RankUpDown:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_448F89A07B04731"))
	RankUpDown:setTTF("default")
	RankUpDown:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	RankUpDown:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(RankUpDown)
	self.RankUpDown = RankUpDown
	local RankedPlaylist = LUI.UIText.new(0, 0, 824, 1024, 0, 0, 503, 540)
	RankedPlaylist:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7DCA39A7569B2F75"))
	RankedPlaylist:setTTF("default")
	RankedPlaylist:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	RankedPlaylist:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(RankedPlaylist)
	self.RankedPlaylist = RankedPlaylist
	local SoloTeam = LUI.UIText.new(0, 0, 824, 1024, 0, 0, 540, 577)
	SoloTeam:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_73CE110E4D3EAB56"))
	SoloTeam:setTTF("default")
	SoloTeam:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	SoloTeam:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(SoloTeam)
	self.SoloTeam = SoloTeam
	local RankIcon = LUI.UIImage.new(0, 0, 896, 1024, 0, 0, 286, 414)
	RankIcon:subscribeToGlobalModel(f1_arg0, "Arena", "arenaRankIconLarge", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			RankIcon:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(RankIcon)
	self.RankIcon = RankIcon
	local ContinueButtonPrompt = CoD.buttonprompt.new(f1_local1, f1_arg0, 0, 0, 1518.5, 1758.5, 0, 0, 897.5, 959.5)
	ContinueButtonPrompt.label:setText(Engine[@"hash_4F9F1239CFD921FE"](@"menu/continue"))
	ContinueButtonPrompt:subscribeToGlobalModel(f1_arg0, "Controller", "primary_button_image", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			ContinueButtonPrompt.buttonPromptImage:setImage(RegisterImage(f3_local0))
		end
	end)
	ContinueButtonPrompt:linkToElementModel(self, "" .. Enum[@"luibutton"][@"lui_key_xba_pscross"], false, function(model)
		ContinueButtonPrompt:setModel(model, f1_arg0)
	end)
	self:addElement(ContinueButtonPrompt)
	self.ContinueButtonPrompt = ContinueButtonPrompt
	local AARRankedPlayStarsList = CoD.AAR_RankUpStarsList.new(f1_local1, f1_arg0, 0, 0, 690.5, 1295.5, 0, 0, 624.5, 959.5)
	self:addElement(AARRankedPlayStarsList)
	self.AARRankedPlayStarsList = AARRankedPlayStarsList
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, "ui_confirm")
		return false
	end, false)
	AARRankedPlayStarsList.id = "AARRankedPlayStarsList"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.AAR_RankedPlayRankChange.__onClose = function(f7_arg0)
	f7_arg0.RankIcon:close()
	f7_arg0.ContinueButtonPrompt:close()
	f7_arg0.AARRankedPlayStarsList:close()
end
