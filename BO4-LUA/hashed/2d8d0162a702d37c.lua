require("x64:d212aaef11b3b80")
require("x64:733a92eae7bba93")
require("x64:f1259b8b773d765")
CoD.AttackerVictimInfoBar = InheritFrom(LUI.UIElement)
CoD.AttackerVictimInfoBar.__defaultWidth = 1920
CoD.AttackerVictimInfoBar.__defaultHeight = 180
CoD.AttackerVictimInfoBar.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.AttackerVictimInfoBar)
	self.id = "AttackerVictimInfoBar"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local versus_backing_right = LUI.UIImage.new(0, 0, 960, 1920, 0, 0, 0, 180)
	versus_backing_right:setRGB(0.1, 0.1, 0.1)
	versus_backing_right:setZRot(180)
	versus_backing_right:setImage(RegisterImage(@"uie_ui_hud_spawnselect_versus_backing"))
	self:addElement(versus_backing_right)
	self.versus_backing_right = versus_backing_right
	local versus_backing_left = LUI.UIImage.new(0, 0, 0, 960, 0, 0, 0, 180)
	versus_backing_left:setRGB(0.1, 0.1, 0.1)
	versus_backing_left:setImage(RegisterImage(@"uie_ui_hud_spawnselect_versus_backing"))
	self:addElement(versus_backing_left)
	self.versus_backing_left = versus_backing_left
	local IdentityBackingFillVictim = LUI.UIImage.new(0, 0, 1283, 1729, 0, 0, 0, 180)
	IdentityBackingFillVictim:setRGB(0.14, 0.14, 0.14)
	IdentityBackingFillVictim:setAlpha(0.5)
	self:addElement(IdentityBackingFillVictim)
	self.IdentityBackingFillVictim = IdentityBackingFillVictim
	local IdentityBackerVictim = LUI.UIImage.new(0, 0, 1279, 1735, 0, 0, 0, 180)
	IdentityBackerVictim:setRGB(0, 0, 0)
	IdentityBackerVictim:setImage(RegisterImage(@"uie_ui_hud_spawnselect_identity_backing"))
	self:addElement(IdentityBackerVictim)
	self.IdentityBackerVictim = IdentityBackerVictim
	local IdentityBackingFillAttacker = LUI.UIImage.new(0, 0, 191, 637, 0, 0, 0, 180)
	IdentityBackingFillAttacker:setRGB(0.14, 0.14, 0.14)
	IdentityBackingFillAttacker:setAlpha(0.5)
	self:addElement(IdentityBackingFillAttacker)
	self.IdentityBackingFillAttacker = IdentityBackingFillAttacker
	local IdentityBackerAttacker = LUI.UIImage.new(0, 0, 186, 642, 0, 0, 0, 180)
	IdentityBackerAttacker:setRGB(0, 0, 0)
	IdentityBackerAttacker:setImage(RegisterImage(@"uie_ui_hud_spawnselect_identity_backing"))
	self:addElement(IdentityBackerAttacker)
	self.IdentityBackerAttacker = IdentityBackerAttacker
	local KillsBacking = LUI.UIImage.new(0, 0, 899.5, 1019.5, 0, 0, 35, 65)
	KillsBacking:setRGB(0.81, 0.38, 0.07)
	self:addElement(KillsBacking)
	self.KillsBacking = KillsBacking
	local KillsLabel = LUI.UIText.new(0.5, 0.5, -62.5, 62.5, 0.5, 0.5, -57, -24)
	KillsLabel:setRGB(0, 0, 0)
	KillsLabel:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_3149A2DE2833BAD4"))
	KillsLabel:setTTF("ttmussels_demibold")
	KillsLabel:setLetterSpacing(10)
	KillsLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	KillsLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(KillsLabel)
	self.KillsLabel = KillsLabel
	local VSLabel = LUI.UIText.new(0.5, 0.5, -62.5, 62.5, 0.5, 0.5, -20, 42)
	VSLabel:setRGB(0.81, 0.38, 0.07)
	VSLabel:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_74AE51EFE63F0158"))
	VSLabel:setTTF("ttmussels_demibold")
	VSLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	VSLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(VSLabel)
	self.VSLabel = VSLabel
	local KilledByLabel = LUI.UIText.new(0, 0, 199.5, 322.5, 0, 0, 13, 37)
	KilledByLabel:setRGB(0.63, 0.63, 0.63)
	KilledByLabel:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_69B24B4F4628C7C"))
	KilledByLabel:setTTF("default")
	KilledByLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	KilledByLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_middle"])
	self:addElement(KilledByLabel)
	self.KilledByLabel = KilledByLabel
	local KillcamWeaponInfo = CoD.KillcamWeaponInfo.new(f1_arg0, f1_arg1, 0.18, 1.48, 77, 77, 0.5, 0.5, -77, -45)
	self:addElement(KillcamWeaponInfo)
	self.KillcamWeaponInfo = KillcamWeaponInfo
	local WeaponImage = LUI.UIImage.new(0, 0, 261, 414, 0, 0, 5, 46)
	WeaponImage:setYRot(180)
	WeaponImage:subscribeToGlobalModel(f1_arg1, "HUDItems", "killcamWeapon.weaponIcon", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			WeaponImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(WeaponImage)
	self.WeaponImage = WeaponImage
	local AttackerImage = LUI.UIImage.new(0, 0, 58.5, 178.5, 0, 0, 33, 153)
	AttackerImage:subscribeToGlobalModel(f1_arg1, "Attacker", "roleIndex", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			AttackerImage:setImage(RegisterImage(GetPositionDraftIconByIndex(f3_local0)))
		end
	end)
	self:addElement(AttackerImage)
	self.AttackerImage = AttackerImage
	local VictimImage = LUI.UIImage.new(0, 0, 1753, 1873, 0, 0, 33, 153)
	VictimImage:subscribeToGlobalModel(f1_arg1, "Victim", "roleIndex", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			VictimImage:setImage(RegisterImage(GetPositionDraftIconByIndex(f4_local0)))
		end
	end)
	self:addElement(VictimImage)
	self.VictimImage = VictimImage
	local VictimPlayerCard = CoD.PlayerCardMenu.new(f1_arg0, f1_arg1, 0, 0, 1277, 1735, 0, 0, 49, 131)
	VictimPlayerCard:subscribeToGlobalModel(f1_arg1, "Victim", nil, function(model)
		VictimPlayerCard:setModel(model, f1_arg1)
	end)
	VictimPlayerCard:linkToElementModel(self, "heading", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			VictimPlayerCard.CalloutHeading:setText(Engine[@"hash_4F9F1239CFD921FE"](f6_local0))
		end
	end)
	self:addElement(VictimPlayerCard)
	self.VictimPlayerCard = VictimPlayerCard
	local AttackerPlayerCard = CoD.PlayerCardMenu.new(f1_arg0, f1_arg1, 0, 0, 185, 643, 0, 0, 49, 131)
	AttackerPlayerCard:subscribeToGlobalModel(f1_arg1, "Attacker", nil, function(model)
		AttackerPlayerCard:setModel(model, f1_arg1)
	end)
	AttackerPlayerCard:linkToElementModel(self, "heading", true, function(model)
		local f8_local0 = model:get()
		if f8_local0 ~= nil then
			AttackerPlayerCard.CalloutHeading:setText(Engine[@"hash_4F9F1239CFD921FE"](f8_local0))
		end
	end)
	self:addElement(AttackerPlayerCard)
	self.AttackerPlayerCard = AttackerPlayerCard
	local KillcamKillCountAttacker = CoD.KillcamKillCount.new(f1_arg0, f1_arg1, 0, 0, 1050.5, 1170.5, 0, 0, 30, 150)
	KillcamKillCountAttacker:subscribeToGlobalModel(f1_arg1, "Victim", "kills", function(model)
		local f9_local0 = model:get()
		if f9_local0 ~= nil then
			KillcamKillCountAttacker.Numbers:setText(f9_local0)
		end
	end)
	self:addElement(KillcamKillCountAttacker)
	self.KillcamKillCountAttacker = KillcamKillCountAttacker
	local KillcamKillCountAttacker2 = CoD.KillcamKillCount.new(f1_arg0, f1_arg1, 0, 0, 749.5, 869.5, 0, 0, 30, 150)
	KillcamKillCountAttacker2:subscribeToGlobalModel(f1_arg1, "Attacker", "kills", function(model)
		local f10_local0 = model:get()
		if f10_local0 ~= nil then
			KillcamKillCountAttacker2.Numbers:setText(f10_local0)
		end
	end)
	self:addElement(KillcamKillCountAttacker2)
	self.KillcamKillCountAttacker2 = KillcamKillCountAttacker2
	local IdentityHeaderVicitm = LUI.UIImage.new(0, 0, 181, 647, 0, 0, 0, 12)
	IdentityHeaderVicitm:setImage(RegisterImage(@"uie_ui_hud_spawnselect_identity_bar"))
	self:addElement(IdentityHeaderVicitm)
	self.IdentityHeaderVicitm = IdentityHeaderVicitm
	local IdentityCornerBottomRight = LUI.UIImage.new(0, 0, 1014.5, 1024.5, 0, 0, 140, 150)
	IdentityCornerBottomRight:setAlpha(0.1)
	IdentityCornerBottomRight:setZRot(-180)
	IdentityCornerBottomRight:setImage(RegisterImage(@"hash_1D7AC5089314462A"))
	self:addElement(IdentityCornerBottomRight)
	self.IdentityCornerBottomRight = IdentityCornerBottomRight
	local IdentityCornerTopRight = LUI.UIImage.new(0, 0, 1015, 1025, 0, 0, 30, 40)
	IdentityCornerTopRight:setAlpha(0.1)
	IdentityCornerTopRight:setZRot(-90)
	IdentityCornerTopRight:setImage(RegisterImage(@"hash_1D7AC5089314462A"))
	self:addElement(IdentityCornerTopRight)
	self.IdentityCornerTopRight = IdentityCornerTopRight
	local IdentityCornerTopLeft = LUI.UIImage.new(0, 0, 894.5, 904.5, 0, 0, 30, 40)
	IdentityCornerTopLeft:setAlpha(0.1)
	IdentityCornerTopLeft:setImage(RegisterImage(@"hash_1D7AC5089314462A"))
	self:addElement(IdentityCornerTopLeft)
	self.IdentityCornerTopLeft = IdentityCornerTopLeft
	local IdentityCornerBottomLeft = LUI.UIImage.new(0, 0, 894.5, 904.5, 0, 0, 140, 150)
	IdentityCornerBottomLeft:setAlpha(0.1)
	IdentityCornerBottomLeft:setZRot(90)
	IdentityCornerBottomLeft:setImage(RegisterImage(@"hash_1D7AC5089314462A"))
	self:addElement(IdentityCornerBottomLeft)
	self.IdentityCornerBottomLeft = IdentityCornerBottomLeft
	local IdentityHeaderVicitm2 = LUI.UIImage.new(0, 0, 1274, 1740, 0, 0, 0, 12)
	IdentityHeaderVicitm2:setImage(RegisterImage(@"uie_ui_hud_spawnselect_identity_bar"))
	self:addElement(IdentityHeaderVicitm2)
	self.IdentityHeaderVicitm2 = IdentityHeaderVicitm2
	local IdentityConnectorBackingAttacker = LUI.UIImage.new(0, 0, 643.5, 751.5, 0, 0, 69.5, 111.5)
	IdentityConnectorBackingAttacker:setAlpha(0.02)
	IdentityConnectorBackingAttacker:setImage(RegisterImage(@"uie_ui_hud_spawnselect_identity_connector"))
	self:addElement(IdentityConnectorBackingAttacker)
	self.IdentityConnectorBackingAttacker = IdentityConnectorBackingAttacker
	local IdentityConnectorLinesAttacker = LUI.UIImage.new(0, 0, 643.5, 751.5, 0, 0, 70, 112)
	IdentityConnectorLinesAttacker:setAlpha(0.5)
	IdentityConnectorLinesAttacker:setImage(RegisterImage(@"uie_ui_hud_spawnselect_identity_connector_lines"))
	self:addElement(IdentityConnectorLinesAttacker)
	self.IdentityConnectorLinesAttacker = IdentityConnectorLinesAttacker
	local IdentityConnectorBackingVictim = LUI.UIImage.new(0, 0, 1168.5, 1276.5, 0, 0, 69.5, 111.5)
	IdentityConnectorBackingVictim:setAlpha(0.03)
	IdentityConnectorBackingVictim:setZRot(180)
	IdentityConnectorBackingVictim:setImage(RegisterImage(@"uie_ui_hud_spawnselect_identity_connector"))
	self:addElement(IdentityConnectorBackingVictim)
	self.IdentityConnectorBackingVictim = IdentityConnectorBackingVictim
	local IdentityConnectorLinesVicitm = LUI.UIImage.new(0, 0, 1168.5, 1276.5, 0, 0, 69.5, 111.5)
	IdentityConnectorLinesVicitm:setAlpha(0.5)
	IdentityConnectorLinesVicitm:setZRot(180)
	IdentityConnectorLinesVicitm:setImage(RegisterImage(@"uie_ui_hud_spawnselect_identity_connector_lines"))
	self:addElement(IdentityConnectorLinesVicitm)
	self.IdentityConnectorLinesVicitm = IdentityConnectorLinesVicitm
	local NemesisLabel = LUI.UIText.new(0.5, 0.5, -50, 50, 0, 0, -35, 2)
	NemesisLabel:setAlpha(0)
	NemesisLabel:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_330FB1CA77CF4B0C"))
	NemesisLabel:setTTF("default")
	NemesisLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	NemesisLabel:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(NemesisLabel)
	self.NemesisLabel = NemesisLabel
	self:mergeStateConditions({
		{
			stateName = "NemesisKillcam",
			condition = function(menu, element, event)
				return Engine[@"isvisibilitybitset"](f1_arg1, Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"])
			end,
		},
	})
	local f1_local30 = self
	local f1_local31 = self.subscribeToModel
	local f1_local32 = Engine[@"getmodelforcontroller"](f1_arg1)
	f1_local31(f1_local30, f1_local32["UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"]], function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "UIVisibilityBit." .. Enum[@"uivisibilitybit"][@"bit_nemesis_killcam"],
		})
	end, false)
	VictimPlayerCard.id = "VictimPlayerCard"
	AttackerPlayerCard.id = "AttackerPlayerCard"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.AttackerVictimInfoBar.__resetProperties = function(f13_arg0)
	f13_arg0.versus_backing_left:completeAnimation()
	f13_arg0.versus_backing_right:completeAnimation()
	f13_arg0.NemesisLabel:completeAnimation()
	f13_arg0.versus_backing_left:setRGB(0.1, 0.1, 0.1)
	f13_arg0.versus_backing_right:setRGB(0.1, 0.1, 0.1)
	f13_arg0.NemesisLabel:setAlpha(0)
end
CoD.AttackerVictimInfoBar.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(0)
		end,
	},
	NemesisKillcam = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(3)
			f15_arg0.versus_backing_right:completeAnimation()
			f15_arg0.versus_backing_right:setRGB(0.72, 0.15, 0.15)
			f15_arg0.clipFinished(f15_arg0.versus_backing_right)
			f15_arg0.versus_backing_left:completeAnimation()
			f15_arg0.versus_backing_left:setRGB(0.72, 0.15, 0.15)
			f15_arg0.clipFinished(f15_arg0.versus_backing_left)
			f15_arg0.NemesisLabel:completeAnimation()
			f15_arg0.NemesisLabel:setAlpha(1)
			f15_arg0.clipFinished(f15_arg0.NemesisLabel)
		end,
	},
}
CoD.AttackerVictimInfoBar.__onClose = function(f16_arg0)
	f16_arg0.KillcamWeaponInfo:close()
	f16_arg0.WeaponImage:close()
	f16_arg0.AttackerImage:close()
	f16_arg0.VictimImage:close()
	f16_arg0.VictimPlayerCard:close()
	f16_arg0.AttackerPlayerCard:close()
	f16_arg0.KillcamKillCountAttacker:close()
	f16_arg0.KillcamKillCountAttacker2:close()
end
