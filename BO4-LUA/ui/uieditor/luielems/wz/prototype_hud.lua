require("x64:8293fdfde8af5f3")
require("x64:3c12759cdd48c2d")
require("x64:7b2b59e28ed4c45")
require("x64:31fac280b1c11fc")
require("x64:34c9f21854c740b")
require("x64:507c4d91ba82906")
require("x64:8d447a0d3920f3e")
require("x64:a333ad4686f031a")
CoD.prototype_hud = InheritFrom(CoD.Menu)
LUI.createMenu.prototype_hud = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("prototype_hud", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.prototype_hud)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.ignoreCursor = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local PromptBackground = LUI.UIImage.new(0.5, 0.5, 418.5, 874.5, 0.5, 0.5, -243.5, -207.5)
	PromptBackground:setRGB(0.24, 0.24, 0.24)
	PromptBackground:linkToElementModel(self, "barrier_prompt_visibility", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PromptBackground:setAlpha(f2_local0)
		end
	end)
	self:addElement(PromptBackground)
	self.PromptBackground = PromptBackground
	local Prompt = LUI.UIText.new(0.5, 0.5, 389, 910, 0.5, 0.5, -238.5, -211.5)
	Prompt:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_78E86CC3A7EBB960"))
	Prompt:setTTF("default")
	Prompt:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_56250C6FCAC36BD4"))
	Prompt:setShaderVector(0, 0.09, 0, 0, 0)
	Prompt:setShaderVector(1, 0, 0, 0, 1)
	Prompt:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Prompt:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Prompt:linkToElementModel(self, "barrier_prompt_visibility", true, function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			Prompt:setAlpha(f3_local0)
		end
	end)
	self:addElement(Prompt)
	self.Prompt = Prompt
	local PromptBackground2 = LUI.UIImage.new(0.5, 0.5, 418.5, 874.5, 0.5, 0.5, -199.5, -163.5)
	PromptBackground2:setRGB(0.24, 0.24, 0.24)
	PromptBackground2:linkToElementModel(self, "deploy_prompt_visibility", true, function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			PromptBackground2:setAlpha(f4_local0)
		end
	end)
	self:addElement(PromptBackground2)
	self.PromptBackground2 = PromptBackground2
	local Prompt2 = LUI.UIText.new(0.5, 0.5, 389, 910, 0.5, 0.5, -194.5, -167.5)
	Prompt2:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_63E2C0F2EABE6FF5"))
	Prompt2:setTTF("default")
	Prompt2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_56250C6FCAC36BD4"))
	Prompt2:setShaderVector(0, 0.09, 0, 0, 0)
	Prompt2:setShaderVector(1, 0, 0, 0, 1)
	Prompt2:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	Prompt2:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	Prompt2:linkToElementModel(self, "deploy_prompt_visibility", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			Prompt2:setAlpha(f5_local0)
		end
	end)
	self:addElement(Prompt2)
	self.Prompt2 = Prompt2
	local ObjectiveString = LUI.UIText.new(0.5, 0.5, -465.5, 465.5, 0.5, 0.5, -362.5, -326.5)
	ObjectiveString:setRGB(0.96, 0.66, 0)
	ObjectiveString:setTTF("default")
	ObjectiveString:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_56250C6FCAC36BD4"))
	ObjectiveString:setShaderVector(0, 0.24, 0, 0, 0)
	ObjectiveString:setShaderVector(1, 0, 0, 0, 1)
	ObjectiveString:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ObjectiveString:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	ObjectiveString:setBackingType(1)
	ObjectiveString:setBackingWidget(CoD.ObituaryBlurBacking, f1_local1, f1_arg0)
	ObjectiveString:setBackingAlpha(0.8)
	ObjectiveString:setBackingXPadding(8)
	ObjectiveString:setBackingYPadding(4)
	ObjectiveString:linkToElementModel(self, "objective_prompt_visibility", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			ObjectiveString:setAlpha(f6_local0)
		end
	end)
	ObjectiveString:linkToElementModel(self, "active_objective_string", true, function(model)
		local f7_local0 = model:get()
		if f7_local0 ~= nil then
			ObjectiveString:setText(Engine[@"hash_4F9F1239CFD921FE"](f7_local0))
		end
	end)
	self:addElement(ObjectiveString)
	self.ObjectiveString = ObjectiveString
	local ResourceBackground = LUI.UIImage.new(0.5, 0.5, 716.5, 874.5, 0.5, 0.5, -386.5, -266.5)
	ResourceBackground:setRGB(0.24, 0.24, 0.24)
	ResourceBackground:linkToElementModel(self, "resource_count_visibility", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			ResourceBackground:setAlpha(f8_local0)
		end
	end)
	self:addElement(ResourceBackground)
	self.ResourceBackground = ResourceBackground
	local DefenseResourceImage = LUI.UIImage.new(0, 0, 1691.5, 1755.5, 0, 0, 164, 228)
	DefenseResourceImage:setImage(RegisterImage(0x5048DCEA2C3497))
	DefenseResourceImage:linkToElementModel(self, "resource_count_visibility", true, function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			DefenseResourceImage:setAlpha(f9_local0)
		end
	end)
	self:addElement(DefenseResourceImage)
	self.DefenseResourceImage = DefenseResourceImage
	local DefenseResourceCount = LUI.UIText.new(0, 0, 1623.5, 1823.5, 0, 0, 228, 265)
	DefenseResourceCount:setRGB(0.11, 0.63, 1)
	DefenseResourceCount:setTTF("default")
	DefenseResourceCount:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_56250C6FCAC36BD4"))
	DefenseResourceCount:setShaderVector(0, 0.4, 0, 0, 0)
	DefenseResourceCount:setShaderVector(1, 0, 0, 0, 1)
	DefenseResourceCount:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	DefenseResourceCount:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	DefenseResourceCount:linkToElementModel(self, "resource_count_visibility", true, function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			DefenseResourceCount:setAlpha(f10_local0)
		end
	end)
	DefenseResourceCount:linkToElementModel(self, "defense_resource_count", true, function(model)
		local f11_local0 = model:get()
		if f11_local0 ~= nil then
			DefenseResourceCount:setText(f11_local0)
		end
	end)
	self:addElement(DefenseResourceCount)
	self.DefenseResourceCount = DefenseResourceCount
	local UpgradeResourceImage = LUI.UIImage.new(0, 0, 1760.5, 1824.5, 0, 0, 164, 228)
	UpgradeResourceImage:setImage(RegisterImage(@"hash_2F65D54FFBEB9AC5"))
	UpgradeResourceImage:linkToElementModel(self, "resource_count_visibility", true, function(model)
		local f12_local0 = model:get()
		if f12_local0 ~= nil then
			UpgradeResourceImage:setAlpha(f12_local0)
		end
	end)
	self:addElement(UpgradeResourceImage)
	self.UpgradeResourceImage = UpgradeResourceImage
	local UpgradeResourceCount = LUI.UIText.new(0, 0, 1692.5, 1892.5, 0, 0, 228, 265)
	UpgradeResourceCount:setRGB(1, 0, 0)
	UpgradeResourceCount:setTTF("default")
	UpgradeResourceCount:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_56250C6FCAC36BD4"))
	UpgradeResourceCount:setShaderVector(0, 0.4, 0, 0, 0)
	UpgradeResourceCount:setShaderVector(1, 0, 0, 0, 1)
	UpgradeResourceCount:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	UpgradeResourceCount:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	UpgradeResourceCount:linkToElementModel(self, "resource_count_visibility", true, function(model)
		local f13_local0 = model:get()
		if f13_local0 ~= nil then
			UpgradeResourceCount:setAlpha(f13_local0)
		end
	end)
	UpgradeResourceCount:linkToElementModel(self, "upgrade_resource_count", true, function(model)
		local f14_local0 = model:get()
		if f14_local0 ~= nil then
			UpgradeResourceCount:setText(f14_local0)
		end
	end)
	self:addElement(UpgradeResourceCount)
	self.UpgradeResourceCount = UpgradeResourceCount
	local PromptProgressBar = CoD.progressBar.new(f1_local1, f1_arg0, 0, 0, 1378.5, 1834.5, 0, 0, 332.5, 340.5)
	PromptProgressBar:setRGB(0.96, 0.66, 0)
	PromptProgressBar.ProgressBar:setRGB(0.96, 0.66, 0)
	PromptProgressBar:linkToElementModel(self, "barrier_prompt_visibility", true, function(model)
		local f15_local0 = model:get()
		if f15_local0 ~= nil then
			PromptProgressBar:setAlpha(f15_local0)
		end
	end)
	PromptProgressBar:linkToElementModel(self, "craft_progress", true, function(model)
		local f16_local0 = model:get()
		if f16_local0 ~= nil then
			PromptProgressBar.ProgressBar:setShaderVector(0, CoD.GetVectorComponentFromString(f16_local0, 1), CoD.GetVectorComponentFromString(f16_local0, 2), CoD.GetVectorComponentFromString(f16_local0, 3), CoD.GetVectorComponentFromString(f16_local0, 4))
		end
	end)
	self:addElement(PromptProgressBar)
	self.PromptProgressBar = PromptProgressBar
	local ObjectiveLog = CoD.ObjectiveLog.new(f1_local1, f1_arg0, 0, 0, 98, 448, 0, 0, 60, 660)
	ObjectiveLog:setAlpha(0)
	ObjectiveLog:linkToElementModel(self, "objective3_string", true, function(model)
		local f17_local0 = model:get()
		if f17_local0 ~= nil then
			ObjectiveLog.ObjectiveLine3:setText(Engine[@"hash_4F9F1239CFD921FE"](f17_local0))
		end
	end)
	ObjectiveLog:linkToElementModel(self, "objective2_string", true, function(model)
		local f18_local0 = model:get()
		if f18_local0 ~= nil then
			ObjectiveLog.ObjectiveLine2:setText(Engine[@"hash_4F9F1239CFD921FE"](f18_local0))
		end
	end)
	ObjectiveLog:linkToElementModel(self, "objective1_string", true, function(model)
		local f19_local0 = model:get()
		if f19_local0 ~= nil then
			ObjectiveLog.ObjectiveLine1:setText(Engine[@"hash_4F9F1239CFD921FE"](f19_local0))
		end
	end)
	ObjectiveLog:linkToElementModel(self, "active_objective_string", true, function(model)
		local f20_local0 = model:get()
		if f20_local0 ~= nil then
			ObjectiveLog.ActiveObjective:setText(Engine[@"hash_4F9F1239CFD921FE"](f20_local0))
		end
	end)
	ObjectiveLog:linkToElementModel(self, "objective1_strike", true, function(model)
		local f21_local0 = model:get()
		if f21_local0 ~= nil then
			ObjectiveLog.Strikethrough1:setAlpha(f21_local0)
		end
	end)
	ObjectiveLog:linkToElementModel(self, "objective3_strike", true, function(model)
		local f22_local0 = model:get()
		if f22_local0 ~= nil then
			ObjectiveLog.Strikethrough3:setAlpha(f22_local0)
		end
	end)
	ObjectiveLog:linkToElementModel(self, "objective2_strike", true, function(model)
		local f23_local0 = model:get()
		if f23_local0 ~= nil then
			ObjectiveLog.Strikethrough2:setAlpha(f23_local0)
		end
	end)
	self:addElement(ObjectiveLog)
	self.ObjectiveLog = ObjectiveLog
	local PixelGrid = LUI.UIImage.new(0, 0, 714.5, 1204.5, 0, 0, 234.5, 409.5)
	PixelGrid:setRGB(0.64, 1, 0.64)
	PixelGrid:setImage(RegisterImage(@"uie_ui_hud_notifications_pixelpattern"))
	PixelGrid:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	PixelGrid:setShaderVector(0, 0, 0, 0, 0)
	PixelGrid:setupNineSliceShader(100, 100)
	PixelGrid:linkToElementModel(self, "fanfare_visibility", true, function(model)
		local f24_local0 = model:get()
		if f24_local0 ~= nil then
			PixelGrid:setAlpha(f24_local0)
		end
	end)
	self:addElement(PixelGrid)
	self.PixelGrid = PixelGrid
	local HeaderRight = CoD.WeaponLevelUpHeaderRight.new(f1_local1, f1_arg0, 0, 0, 1134.5, 1204.5, 0, 0, 224.5, 232.5)
	HeaderRight:linkToElementModel(self, "fanfare_visibility", true, function(model)
		local f25_local0 = model:get()
		if f25_local0 ~= nil then
			HeaderRight:setAlpha(f25_local0)
		end
	end)
	self:addElement(HeaderRight)
	self.HeaderRight = HeaderRight
	local Header = CoD.WeaponLevelUpHeaderStripe.new(f1_local1, f1_arg0, 0, 0, 714.5, 1132.5, 0, 0, 224.5, 232.5)
	Header.HeaderBacking:setRGB(0, 0, 0)
	Header.HeaderBacking:setShaderVector(0, 0, 0.5, 0, 0)
	Header:linkToElementModel(self, "fanfare_visibility", true, function(model)
		local f26_local0 = model:get()
		if f26_local0 ~= nil then
			Header:setAlpha(f26_local0)
		end
	end)
	self:addElement(Header)
	self.Header = Header
	local Hashes = CoD.WeaponLevelUpSideHashes.new(f1_local1, f1_arg0, 0, 0, 700.5, 1219.5, 0, 0, 308.5, 328.5)
	Hashes:linkToElementModel(self, "fanfare_visibility", true, function(model)
		local f27_local0 = model:get()
		if f27_local0 ~= nil then
			Hashes:setAlpha(f27_local0)
		end
	end)
	self:addElement(Hashes)
	self.Hashes = Hashes
	local Brackets = CoD.WeaponLevelUpBrackets.new(f1_local1, f1_arg0, 0, 0, 702.5, 1216.5, 0, 0, 212.5, 422.5)
	Brackets:linkToElementModel(self, "fanfare_visibility", true, function(model)
		local f28_local0 = model:get()
		if f28_local0 ~= nil then
			Brackets:setAlpha(f28_local0)
		end
	end)
	self:addElement(Brackets)
	self.Brackets = Brackets
	local FanfareText = LUI.UIText.new(0, 0, 761.5, 1158.5, 0, 0, 365.5, 401.5)
	FanfareText:setRGB(0.31, 1, 0.3)
	FanfareText:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_18AF89F3E3E8DAE8"))
	FanfareText:setTTF("ttmussels_demibold")
	FanfareText:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_56250C6FCAC36BD4"))
	FanfareText:setShaderVector(0, 0.25, 0, 0, 0)
	FanfareText:setShaderVector(1, 0, 0, 0, 1)
	FanfareText:setLetterSpacing(2)
	FanfareText:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	FanfareText:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	FanfareText:setBackingType(-1)
	FanfareText:setBackingXPadding(40)
	FanfareText:linkToElementModel(self, "fanfare_visibility", true, function(model)
		local f29_local0 = model:get()
		if f29_local0 ~= nil then
			FanfareText:setAlpha(f29_local0)
		end
	end)
	self:addElement(FanfareText)
	self.FanfareText = FanfareText
	local Image = LUI.UIImage.new(0, 0, 896, 1024, 0, 0, 237.5, 365.5)
	Image:setImage(RegisterImage(@"ui_icon_medal_victor_large"))
	Image:linkToElementModel(self, "fanfare_visibility", true, function(model)
		local f30_local0 = model:get()
		if f30_local0 ~= nil then
			Image:setAlpha(f30_local0)
		end
	end)
	self:addElement(Image)
	self.Image = Image
	local PixelGrid2 = LUI.UIImage.new(0, 0, 714.5, 1204.5, 0, 0, 234.5, 409.5)
	PixelGrid2:setRGB(1, 0.67, 0.67)
	PixelGrid2:setImage(RegisterImage(@"uie_ui_hud_notifications_pixelpattern"))
	PixelGrid2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	PixelGrid2:setShaderVector(0, 0, 0, 0, 0)
	PixelGrid2:setupNineSliceShader(100, 100)
	PixelGrid2:linkToElementModel(self, "fail_fanfare_visibility", true, function(model)
		local f31_local0 = model:get()
		if f31_local0 ~= nil then
			PixelGrid2:setAlpha(f31_local0)
		end
	end)
	self:addElement(PixelGrid2)
	self.PixelGrid2 = PixelGrid2
	local HeaderRight2 = CoD.WeaponLevelUpHeaderRight.new(f1_local1, f1_arg0, 0, 0, 1134.5, 1204.5, 0, 0, 224.5, 232.5)
	HeaderRight2:linkToElementModel(self, "fail_fanfare_visibility", true, function(model)
		local f32_local0 = model:get()
		if f32_local0 ~= nil then
			HeaderRight2:setAlpha(f32_local0)
		end
	end)
	self:addElement(HeaderRight2)
	self.HeaderRight2 = HeaderRight2
	local Header2 = CoD.WeaponLevelUpHeaderStripe.new(f1_local1, f1_arg0, 0, 0, 714.5, 1132.5, 0, 0, 224.5, 232.5)
	Header2.HeaderBacking:setRGB(0, 0, 0)
	Header2.HeaderBacking:setShaderVector(0, 0, 0.5, 0, 0)
	Header2:linkToElementModel(self, "fail_fanfare_visibility", true, function(model)
		local f33_local0 = model:get()
		if f33_local0 ~= nil then
			Header2:setAlpha(f33_local0)
		end
	end)
	self:addElement(Header2)
	self.Header2 = Header2
	local Hashes2 = CoD.WeaponLevelUpSideHashes.new(f1_local1, f1_arg0, 0, 0, 700.5, 1219.5, 0, 0, 308.5, 328.5)
	Hashes2:linkToElementModel(self, "fail_fanfare_visibility", true, function(model)
		local f34_local0 = model:get()
		if f34_local0 ~= nil then
			Hashes2:setAlpha(f34_local0)
		end
	end)
	self:addElement(Hashes2)
	self.Hashes2 = Hashes2
	local Brackets2 = CoD.WeaponLevelUpBrackets.new(f1_local1, f1_arg0, 0, 0, 702.5, 1216.5, 0, 0, 212.5, 422.5)
	Brackets2:linkToElementModel(self, "fail_fanfare_visibility", true, function(model)
		local f35_local0 = model:get()
		if f35_local0 ~= nil then
			Brackets2:setAlpha(f35_local0)
		end
	end)
	self:addElement(Brackets2)
	self.Brackets2 = Brackets2
	local FanfareText2 = LUI.UIText.new(0, 0, 761.5, 1158.5, 0, 0, 365.5, 401.5)
	FanfareText2:setRGB(1, 0.38, 0.38)
	FanfareText2:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_3CA1BA4B6F3B4AF6"))
	FanfareText2:setTTF("ttmussels_demibold")
	FanfareText2:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_56250C6FCAC36BD4"))
	FanfareText2:setShaderVector(0, 0.25, 0, 0, 0)
	FanfareText2:setShaderVector(1, 0, 0, 0, 1)
	FanfareText2:setLetterSpacing(2)
	FanfareText2:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	FanfareText2:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	FanfareText2:setBackingType(-1)
	FanfareText2:setBackingXPadding(40)
	FanfareText2:linkToElementModel(self, "fail_fanfare_visibility", true, function(model)
		local f36_local0 = model:get()
		if f36_local0 ~= nil then
			FanfareText2:setAlpha(f36_local0)
		end
	end)
	self:addElement(FanfareText2)
	self.FanfareText2 = FanfareText2
	local Image2 = LUI.UIImage.new(0, 0, 896, 1024, 0, 0, 237.5, 365.5)
	Image2:setImage(RegisterImage(@"ui_icon_medal_victor_large"))
	Image2:linkToElementModel(self, "fail_fanfare_visibility", true, function(model)
		local f37_local0 = model:get()
		if f37_local0 ~= nil then
			Image2:setAlpha(f37_local0)
		end
	end)
	self:addElement(Image2)
	self.Image2 = Image2
	self.HeaderRight:linkToElementModel(self, nil, false, function(model)
		HeaderRight:setModel(model, f1_arg0)
	end)
	self.Header:linkToElementModel(self, nil, false, function(model)
		Header:setModel(model, f1_arg0)
	end)
	self.FanfareText:linkToElementModel(self, nil, false, function(model)
		FanfareText:setBackingModel(model, f1_arg0)
	end)
	self.HeaderRight2:linkToElementModel(self, nil, false, function(model)
		HeaderRight2:setModel(model, f1_arg0)
	end)
	self.Header2:linkToElementModel(self, nil, false, function(model)
		Header2:setModel(model, f1_arg0)
	end)
	self.FanfareText2:linkToElementModel(self, nil, false, function(model)
		FanfareText2:setBackingModel(model, f1_arg0)
	end)
	self:mergeStateConditions({
		{
			stateName = "WZMapOpen",
			condition = function(menu, element, event)
				return ScoreboardVisible(f1_arg0)
			end,
		},
		{
			stateName = "PlaySound",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	local f1_local28 = self
	local f1_local29 = self.subscribeToModel
	local f1_local30 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local29(f1_local28, f1_local30.forceScoreboard, function(f46_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f46_arg0:get(),
			modelName = "forceScoreboard",
		})
	end, false)
	f1_local28 = self
	f1_local29 = self.subscribeToModel
	f1_local30 = Engine[@"getmodelforcontroller"](f1_arg0)
	f1_local29(f1_local28, f1_local30["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"]], function(f47_arg0)
		f1_local1:updateElementState(self, {
			name = "model_validation",
			menu = f1_local1,
			controller = f1_arg0,
			modelValue = f47_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_scoreboard_open"],
		})
	end, false)
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
CoD.prototype_hud.__resetProperties = function(f48_arg0)
	f48_arg0.ObjectiveLog:completeAnimation()
	f48_arg0.ObjectiveLog:setAlpha(0)
end
CoD.prototype_hud.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f49_arg0, f49_arg1)
			f49_arg0:__resetProperties()
			f49_arg0:setupElementClipCounter(0)
		end,
		WZMapOpen = function(f50_arg0, f50_arg1)
			f50_arg0:__resetProperties()
			f50_arg0:setupElementClipCounter(1)
			f50_arg0.ObjectiveLog:completeAnimation()
			f50_arg0.ObjectiveLog:setAlpha(1)
			f50_arg0.clipFinished(f50_arg0.ObjectiveLog)
		end,
	},
	WZMapOpen = {
		DefaultClip = function(f51_arg0, f51_arg1)
			f51_arg0:__resetProperties()
			f51_arg0:setupElementClipCounter(1)
			f51_arg0.ObjectiveLog:completeAnimation()
			f51_arg0.ObjectiveLog:setAlpha(1)
			f51_arg0.clipFinished(f51_arg0.ObjectiveLog)
		end,
	},
	PlaySound = {
		DefaultClip = function(f52_arg0, f52_arg1)
			f52_arg0:__resetProperties()
			f52_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.prototype_hud.__onClose = function(f53_arg0)
	f53_arg0.PromptBackground:close()
	f53_arg0.Prompt:close()
	f53_arg0.PromptBackground2:close()
	f53_arg0.Prompt2:close()
	f53_arg0.ObjectiveString:close()
	f53_arg0.ResourceBackground:close()
	f53_arg0.DefenseResourceImage:close()
	f53_arg0.DefenseResourceCount:close()
	f53_arg0.UpgradeResourceImage:close()
	f53_arg0.UpgradeResourceCount:close()
	f53_arg0.PromptProgressBar:close()
	f53_arg0.ObjectiveLog:close()
	f53_arg0.PixelGrid:close()
	f53_arg0.HeaderRight:close()
	f53_arg0.Header:close()
	f53_arg0.Hashes:close()
	f53_arg0.Brackets:close()
	f53_arg0.FanfareText:close()
	f53_arg0.Image:close()
	f53_arg0.PixelGrid2:close()
	f53_arg0.HeaderRight2:close()
	f53_arg0.Header2:close()
	f53_arg0.Hashes2:close()
	f53_arg0.Brackets2:close()
	f53_arg0.FanfareText2:close()
	f53_arg0.Image2:close()
end
