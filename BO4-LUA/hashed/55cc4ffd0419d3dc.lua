require("x64:96ef316933545b7")
require("x64:6be4f736d62e809")
require("x64:5422f1464c83779")
CoD.HVOCardInternal = InheritFrom(LUI.UIElement)
CoD.HVOCardInternal.__defaultWidth = 632
CoD.HVOCardInternal.__defaultHeight = 964
CoD.HVOCardInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.HVOCardInternal)
	self.id = "HVOCardInternal"
	self.soundSet = "default"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Blur = LUI.UIImage.new(0, 0, 67, 566, 0, 0, 57, 904)
	Blur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	Blur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(Blur)
	self.Blur = Blur
	local PanelLight = LUI.UIImage.new(0, 0, 67, 566, 0, 0, 772, 904)
	PanelLight:setRGB(0.11, 0.11, 0.11)
	PanelLight:setAlpha(0.88)
	self:addElement(PanelLight)
	self.PanelLight = PanelLight
	local PanelDark = LUI.UIImage.new(0, 0, 67, 566, 0, 0, 60, 771)
	PanelDark:setRGB(0.09, 0.09, 0.09)
	PanelDark:setAlpha(0.98)
	self:addElement(PanelDark)
	self.PanelDark = PanelDark
	local GridTiled = LUI.UIImage.new(0.2, 0.2, -63.5, 443.5, 0.19, 0.19, -39.5, 588.5)
	GridTiled:setAlpha(0.2)
	GridTiled:setScale(1.01, 1.01)
	GridTiled:setImage(RegisterImage(@"uie_ui_menu_store_bg_grid"))
	GridTiled:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	GridTiled:setShaderVector(0, 0, 0, 0, 0)
	GridTiled:setupNineSliceShader(64, 64)
	self:addElement(GridTiled)
	self.GridTiled = GridTiled
	local PixelGridTiledBacking = LUI.UIImage.new(0.02, 0.02, 55.5, 560.5, 0.31, 0.31, -243, 471)
	PixelGridTiledBacking:setAlpha(0.05)
	PixelGridTiledBacking:setImage(RegisterImage(@"uie_ui_hud_notifications_pixelpattern"))
	PixelGridTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	PixelGridTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	PixelGridTiledBacking:setupNineSliceShader(128, 128)
	self:addElement(PixelGridTiledBacking)
	self.PixelGridTiledBacking = PixelGridTiledBacking
	local PixelGridTiledBacking2 = LUI.UIImage.new(0.02, 0.02, 55.5, 560.5, 0.31, 0.31, 471, 604)
	PixelGridTiledBacking2:setAlpha(0.15)
	PixelGridTiledBacking2:setImage(RegisterImage(@"uie_ui_hud_notifications_pixelpattern"))
	PixelGridTiledBacking2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	PixelGridTiledBacking2:setShaderVector(0, 0, 0, 0, 0)
	PixelGridTiledBacking2:setupNineSliceShader(128, 128)
	self:addElement(PixelGridTiledBacking2)
	self.PixelGridTiledBacking2 = PixelGridTiledBacking2
	local BackerGold = LUI.UIImage.new(0, 0, -0.5, 631.5, 0, 0, 0, 964)
	BackerGold:setImage(RegisterImage(@"hash_3A8B2771AD77EBF6"))
	self:addElement(BackerGold)
	self.BackerGold = BackerGold
	local BackerGray = LUI.UIImage.new(0, 0, -0.5, 631.5, 0, 0, 0, 964)
	BackerGray:setImage(RegisterImage(@"hash_3A8B2771AD77EBF6"))
	self:addElement(BackerGray)
	self.BackerGray = BackerGray
	local Image = LUI.UIImage.new(0.5, 0.5, -185, 189, 0, 0, 141, 515)
	Image:setAlpha(0)
	Image:linkToElementModel(self, "cardImage", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Image:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(Image)
	self.Image = Image
	local PlayerIdentity = CoD.GameEndScore_PlayerIndentity.new(f1_arg0, f1_arg1, 0, 0, 66, 580, 0, 0, 779, 889)
	PlayerIdentity:setScale(0.9, 0.9)
	PlayerIdentity.ClanTag:setAlpha(0)
	PlayerIdentity.ClientName:setAlpha(0)
	PlayerIdentity:linkToElementModel(self, "perClient", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			PlayerIdentity:setModel(f3_local0, f1_arg1)
		end
	end)
	self:addElement(PlayerIdentity)
	self.PlayerIdentity = PlayerIdentity
	local Title = LUI.UIText.new(0, 0, 66, 566, 0, 0, 527.5, 575.5)
	Title:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Title:setAlpha(0)
	Title:setTTF("ttmussels_demibold")
	Title:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_90D57B1E92D39D7"))
	Title:setShaderVector(0, 1.13, 0, 0, 0)
	Title:setShaderVector(1, -0.29, 0, 0, 0)
	Title:setShaderVector(2, 1, 1, 1, 0.2)
	Title:setLetterSpacing(4)
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Title:linkToElementModel(self, "cardTitle", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Title:setText(LocalizeToUpperString(f4_local0))
		end
	end)
	self:addElement(Title)
	self.Title = Title
	local Description = LUI.UIText.new(0, 0, 66, 566, 0, 0, 577.5, 599.5)
	Description:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	Description:setAlpha(0)
	Description:setTTF("dinnext_regular")
	Description:setLetterSpacing(4)
	Description:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Description:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Description:linkToElementModel(self, "cardTitle", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Description:setText(Engine[@"hash_4F9F1239CFD921FE"](f5_local0))
		end
	end)
	self:addElement(Description)
	self.Description = Description
	local StatList = LUI.UIList.new(f1_arg0, f1_arg1, 8, 0, nil, false, false, false, false)
	StatList:setLeftRight(0, 0, 87.5, 487.5)
	StatList:setTopBottom(0, 0, 624, 760)
	StatList:setWidgetType(CoD.HVOStat)
	StatList:setVerticalCount(3)
	StatList:setSpacing(8)
	StatList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	StatList:linkToElementModel(self, "statsDataSource", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			StatList:setDataSource(f6_local0)
		end
	end)
	self:addElement(StatList)
	self.StatList = StatList
	local RankLevel = CoD.HVOCardTitle.new(f1_arg0, f1_arg1, 0, 0, 80, 561, 0, 0, 78.5, 124.5)
	RankLevel:setAlpha(0)
	RankLevel:linkToElementModel(self, nil, false, function(model)
		RankLevel:setModel(model, f1_arg1)
	end)
	self:addElement(RankLevel)
	self.RankLevel = RankLevel
	local TeamBarAnim = LUI.UIImage.new(0, 0, 163.5, 469.5, 0, 0, 23, 86)
	TeamBarAnim:setImage(RegisterImage(@"hash_3855C1829CEAEDB0"))
	TeamBarAnim:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook_add"))
	TeamBarAnim:setShaderVector(0, 3, 20, 0, 0)
	TeamBarAnim:setShaderVector(1, 30, 0, 0, 0)
	TeamBarAnim.__Color = function(f8_arg0)
		local f8_local0 = f8_arg0:get()
		if f8_local0 ~= nil then
			TeamBarAnim:setRGB(CoD.HUDUtility.GetFriendlyOrEnemyBrightColor(f1_arg1, f8_local0))
		end
	end
	TeamBarAnim:linkToElementModel(self, "perClient", true, function(model, f9_arg1)
		if f9_arg1["__TeamBarAnim.__Color_perClient->team"] then
			f9_arg1:removeSubscription(f9_arg1["__TeamBarAnim.__Color_perClient->team"])
			f9_arg1["__TeamBarAnim.__Color_perClient->team"] = nil
		end
		if model then
			local f9_local0 = model:get()
			local f9_local1 = model:get()
			model = f9_local0 and f9_local1.team
		end
		if model then
			f9_arg1["__TeamBarAnim.__Color_perClient->team"] = f9_arg1:subscribeToModel(model, TeamBarAnim.__Color)
		end
	end)
	self:addElement(TeamBarAnim)
	self.TeamBarAnim = TeamBarAnim
	local TeamBarBase = LUI.UIImage.new(0, 0, 151.5, 475.5, 0, 0, 36, 72)
	TeamBarBase:setImage(RegisterImage(@"hash_48863AFCAB54A9"))
	TeamBarBase.__Color = function(f10_arg0)
		local f10_local0 = f10_arg0:get()
		if f10_local0 ~= nil then
			TeamBarBase:setRGB(CoD.HUDUtility.GetFriendlyOrEnemyBaseColor(f1_arg1, f10_local0))
		end
	end
	TeamBarBase:linkToElementModel(self, "perClient", true, function(model, f11_arg1)
		if f11_arg1["__TeamBarBase.__Color_perClient->team"] then
			f11_arg1:removeSubscription(f11_arg1["__TeamBarBase.__Color_perClient->team"])
			f11_arg1["__TeamBarBase.__Color_perClient->team"] = nil
		end
		if model then
			local f11_local0 = model:get()
			local f11_local1 = model:get()
			model = f11_local0 and f11_local1.team
		end
		if model then
			f11_arg1["__TeamBarBase.__Color_perClient->team"] = f11_arg1:subscribeToModel(model, TeamBarBase.__Color)
		end
	end)
	self:addElement(TeamBarBase)
	self.TeamBarBase = TeamBarBase
	local TeamBarMuted = LUI.UIImage.new(0, 0, 151.5, 475.5, 0, 0, 49.5, 58.5)
	TeamBarMuted:setImage(RegisterImage(@"hash_48863AFCAB54A9"))
	TeamBarMuted:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	TeamBarMuted.__Color = function(f12_arg0)
		local f12_local0 = f12_arg0:get()
		if f12_local0 ~= nil then
			TeamBarMuted:setRGB(CoD.HUDUtility.GetFriendlyOrEnemyMutedColor(f1_arg1, f12_local0))
		end
	end
	TeamBarMuted:linkToElementModel(self, "perClient", true, function(model, f13_arg1)
		if f13_arg1["__TeamBarMuted.__Color_perClient->team"] then
			f13_arg1:removeSubscription(f13_arg1["__TeamBarMuted.__Color_perClient->team"])
			f13_arg1["__TeamBarMuted.__Color_perClient->team"] = nil
		end
		if model then
			local f13_local0 = model:get()
			local f13_local1 = model:get()
			model = f13_local0 and f13_local1.team
		end
		if model then
			f13_arg1["__TeamBarMuted.__Color_perClient->team"] = f13_arg1:subscribeToModel(model, TeamBarMuted.__Color)
		end
	end)
	self:addElement(TeamBarMuted)
	self.TeamBarMuted = TeamBarMuted
	local TeamBarBright = LUI.UIImage.new(0, 0, 151.5, 475.5, 0, 0, 36, 72)
	TeamBarBright:setImage(RegisterImage(@"hash_48863AFCAB54A9"))
	TeamBarBright:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	TeamBarBright:setShaderVector(0, 2, 0, 0, 0)
	TeamBarBright.__Color = function(f14_arg0)
		local f14_local0 = f14_arg0:get()
		if f14_local0 ~= nil then
			TeamBarBright:setRGB(CoD.HUDUtility.GetFriendlyOrEnemyBrightColor(f1_arg1, f14_local0))
		end
	end
	TeamBarBright:linkToElementModel(self, "perClient", true, function(model, f15_arg1)
		if f15_arg1["__TeamBarBright.__Color_perClient->team"] then
			f15_arg1:removeSubscription(f15_arg1["__TeamBarBright.__Color_perClient->team"])
			f15_arg1["__TeamBarBright.__Color_perClient->team"] = nil
		end
		if model then
			local f15_local0 = model:get()
			local f15_local1 = model:get()
			model = f15_local0 and f15_local1.team
		end
		if model then
			f15_arg1["__TeamBarBright.__Color_perClient->team"] = f15_arg1:subscribeToModel(model, TeamBarBright.__Color)
		end
	end)
	self:addElement(TeamBarBright)
	self.TeamBarBright = TeamBarBright
	local TeamBarAnim2 = LUI.UIImage.new(0, 0, 163.5, 469.5, 0, 0, 32, 76)
	TeamBarAnim2:setAlpha(0.7)
	TeamBarAnim2:setImage(RegisterImage(@"hash_3855C1829CEAEDB0"))
	TeamBarAnim2:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_flipbook_add"))
	TeamBarAnim2:setShaderVector(0, 3, 20, 0, 0)
	TeamBarAnim2:setShaderVector(1, 30, 0, 0, 0)
	self:addElement(TeamBarAnim2)
	self.TeamBarAnim2 = TeamBarAnim2
	local GlowBase = LUI.UIImage.new(0, 0, 0, 632, 0, 0, 0, 964)
	GlowBase:setAlpha(0)
	GlowBase:setImage(RegisterImage(@"hash_24D5B522898DA78D"))
	GlowBase.__Color = function(f16_arg0)
		local f16_local0 = f16_arg0:get()
		if f16_local0 ~= nil then
			GlowBase:setRGB(CoD.HUDUtility.GetFriendlyOrEnemyBaseColor(f1_arg1, f16_local0))
		end
	end
	GlowBase:linkToElementModel(self, "perClient", true, function(model, f17_arg1)
		if f17_arg1["__GlowBase.__Color_perClient->team"] then
			f17_arg1:removeSubscription(f17_arg1["__GlowBase.__Color_perClient->team"])
			f17_arg1["__GlowBase.__Color_perClient->team"] = nil
		end
		if model then
			local f17_local0 = model:get()
			local f17_local1 = model:get()
			model = f17_local0 and f17_local1.team
		end
		if model then
			f17_arg1["__GlowBase.__Color_perClient->team"] = f17_arg1:subscribeToModel(model, GlowBase.__Color)
		end
	end)
	self:addElement(GlowBase)
	self.GlowBase = GlowBase
	local GlowMuted = LUI.UIImage.new(0, 0, 0, 632, 0, 0, 0, 964)
	GlowMuted:setAlpha(0)
	GlowMuted:setImage(RegisterImage(@"hash_24D5B522898DA78D"))
	GlowMuted:setMaterial(LUI.UIImage.GetCachedMaterial(@"ui_add"))
	GlowMuted.__Color = function(f18_arg0)
		local f18_local0 = f18_arg0:get()
		if f18_local0 ~= nil then
			GlowMuted:setRGB(CoD.HUDUtility.GetFriendlyOrEnemyMutedColor(f1_arg1, f18_local0))
		end
	end
	GlowMuted:linkToElementModel(self, "perClient", true, function(model, f19_arg1)
		if f19_arg1["__GlowMuted.__Color_perClient->team"] then
			f19_arg1:removeSubscription(f19_arg1["__GlowMuted.__Color_perClient->team"])
			f19_arg1["__GlowMuted.__Color_perClient->team"] = nil
		end
		if model then
			local f19_local0 = model:get()
			local f19_local1 = model:get()
			model = f19_local0 and f19_local1.team
		end
		if model then
			f19_arg1["__GlowMuted.__Color_perClient->team"] = f19_arg1:subscribeToModel(model, GlowMuted.__Color)
		end
	end)
	self:addElement(GlowMuted)
	self.GlowMuted = GlowMuted
	local GlowBright = LUI.UIImage.new(0, 0, 0, 632, 0, 0, 0, 964)
	GlowBright:setAlpha(0)
	GlowBright:setImage(RegisterImage(@"hash_24D5B522898DA78D"))
	GlowBright:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_31CC85D0A86303B0"))
	GlowBright:setShaderVector(0, 1.5, 0, 0, 0)
	GlowBright.__Color = function(f20_arg0)
		local f20_local0 = f20_arg0:get()
		if f20_local0 ~= nil then
			GlowBright:setRGB(CoD.HUDUtility.GetFriendlyOrEnemyBrightColor(f1_arg1, f20_local0))
		end
	end
	GlowBright:linkToElementModel(self, "perClient", true, function(model, f21_arg1)
		if f21_arg1["__GlowBright.__Color_perClient->team"] then
			f21_arg1:removeSubscription(f21_arg1["__GlowBright.__Color_perClient->team"])
			f21_arg1["__GlowBright.__Color_perClient->team"] = nil
		end
		if model then
			local f21_local0 = model:get()
			local f21_local1 = model:get()
			model = f21_local0 and f21_local1.team
		end
		if model then
			f21_arg1["__GlowBright.__Color_perClient->team"] = f21_arg1:subscribeToModel(model, GlowBright.__Color)
		end
	end)
	self:addElement(GlowBright)
	self.GlowBright = GlowBright
	StatList.id = "StatList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.HVOCardInternal.__onClose = function(f22_arg0)
	f22_arg0.Image:close()
	f22_arg0.PlayerIdentity:close()
	f22_arg0.Title:close()
	f22_arg0.Description:close()
	f22_arg0.StatList:close()
	f22_arg0.RankLevel:close()
	f22_arg0.TeamBarAnim:close()
	f22_arg0.TeamBarBase:close()
	f22_arg0.TeamBarMuted:close()
	f22_arg0.TeamBarBright:close()
	f22_arg0.GlowBase:close()
	f22_arg0.GlowMuted:close()
	f22_arg0.GlowBright:close()
end
