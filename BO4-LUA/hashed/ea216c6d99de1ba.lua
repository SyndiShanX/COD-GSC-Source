require("x64:2d64ca9d3c705ce")
require("x64:877a413a004c441")
require("x64:9e155239e6593c")
require("x64:174f0fb9f1f7e0d")
require("x64:9d187b5785a45d7")
require("x64:7038e33134e509a")
require("x64:20a0021e04d224d")
require("x64:1a3f133f2b623ac")
require("x64:35dde2f09c696a7")
CoD.BountyHunterBuyInternal = InheritFrom(LUI.UIElement)
CoD.BountyHunterBuyInternal.__defaultWidth = 1920
CoD.BountyHunterBuyInternal.__defaultHeight = 1080
CoD.BountyHunterBuyInternal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.BountyHunterBuyInternal)
	self.id = "BountyHunterBuyInternal"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	local SceneBlur = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	SceneBlur:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_E2354BE557C4C7A"))
	SceneBlur:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(SceneBlur)
	self.SceneBlur = SceneBlur
	local DarkBG = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	DarkBG:setRGB(0, 0, 0)
	DarkBG:setAlpha(0.95)
	self:addElement(DarkBG)
	self.DarkBG = DarkBG
	local CommonCornerBrackets = CoD.CommonCornerBrackets01.new(f1_arg0, f1_arg1, 0.5, 0.5, -925, 925, 0.5, 0.5, -402, 468)
	CommonCornerBrackets:setAlpha(0.3)
	self:addElement(CommonCornerBrackets)
	self.CommonCornerBrackets = CommonCornerBrackets
	local NoiseTiledBacking = LUI.UIImage.new(0.5, 0.5, -893.5, 893.5, 0.5, 0.5, -374.5, 440.5)
	NoiseTiledBacking:setRGB(0.52, 0.52, 0.52)
	NoiseTiledBacking:setAlpha(0.65)
	NoiseTiledBacking:setImage(RegisterImage(@"uie_ui_menu_specialist_hub_repeat_bg"))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local CommonHeaderBG01 = CoD.CommonHeaderHUDBG01.new(f1_arg0, f1_arg1, 0.5, 0.5, -337.5, 337.5, 0.5, 0.5, -511, -459)
	self:addElement(CommonHeaderBG01)
	self.CommonHeaderBG01 = CommonHeaderBG01
	local CommonSubheaderBG = CoD.CommonSubHeaderBG01.new(f1_arg0, f1_arg1, 0.5, 0.5, -337.5, 337.5, 0.5, 0.5, -454, -420)
	self:addElement(CommonSubheaderBG)
	self.CommonSubheaderBG = CommonSubheaderBG
	local CommonSubheaderBG01 = CoD.CommonSubHeaderBG01.new(f1_arg0, f1_arg1, 0.5, 0.5, -868, -741, 0.5, 0.5, -349, -334)
	CommonSubheaderBG01:setRGB(0.39, 0.39, 0.39)
	CommonSubheaderBG01.NoiseTiledBacking:setAlpha(0.8)
	CommonSubheaderBG01.NoiseTiledBacking3:setAlpha(0)
	CommonSubheaderBG01.NoiseTiledBacking2:setAlpha(0)
	self:addElement(CommonSubheaderBG01)
	self.CommonSubheaderBG01 = CommonSubheaderBG01
	local CommonSubheaderBG02 = CoD.CommonSubHeaderBG01.new(f1_arg0, f1_arg1, 0.5, 0.5, -692, -412, 0.5, 0.5, -349, -334)
	CommonSubheaderBG02:setRGB(0.39, 0.39, 0.39)
	CommonSubheaderBG02.NoiseTiledBacking:setAlpha(0.8)
	CommonSubheaderBG02.NoiseTiledBacking3:setAlpha(0)
	CommonSubheaderBG02.NoiseTiledBacking2:setAlpha(0)
	self:addElement(CommonSubheaderBG02)
	self.CommonSubheaderBG02 = CommonSubheaderBG02
	local CommonSubheaderBG03 = CoD.CommonSubHeaderBG01.new(f1_arg0, f1_arg1, 0.5, 0.5, -387, 463, 0.5, 0.5, -349, -334)
	CommonSubheaderBG03:setRGB(0.39, 0.39, 0.39)
	CommonSubheaderBG03.NoiseTiledBacking:setAlpha(0.8)
	CommonSubheaderBG03.NoiseTiledBacking3:setAlpha(0)
	CommonSubheaderBG03.NoiseTiledBacking2:setAlpha(0)
	self:addElement(CommonSubheaderBG03)
	self.CommonSubheaderBG03 = CommonSubheaderBG03
	local CommonSubheaderBG04 = CoD.CommonSubHeaderBG01.new(f1_arg0, f1_arg1, 0.5, 0.5, -868, -741, 0.5, 0.5, -125, -110)
	CommonSubheaderBG04:setRGB(0.39, 0.39, 0.39)
	CommonSubheaderBG04.NoiseTiledBacking:setAlpha(0.8)
	CommonSubheaderBG04.NoiseTiledBacking3:setAlpha(0)
	CommonSubheaderBG04.NoiseTiledBacking2:setAlpha(0)
	self:addElement(CommonSubheaderBG04)
	self.CommonSubheaderBG04 = CommonSubheaderBG04
	local CommonSubheaderBG05 = CoD.CommonSubHeaderBG01.new(f1_arg0, f1_arg1, 0.5, 0.5, -692, -412, 0.5, 0.5, -125, -110)
	CommonSubheaderBG05:setRGB(0.39, 0.39, 0.39)
	CommonSubheaderBG05.NoiseTiledBacking:setAlpha(0.8)
	CommonSubheaderBG05.NoiseTiledBacking3:setAlpha(0)
	CommonSubheaderBG05.NoiseTiledBacking2:setAlpha(0)
	self:addElement(CommonSubheaderBG05)
	self.CommonSubheaderBG05 = CommonSubheaderBG05
	local CommonSubheaderBG06 = CoD.CommonSubHeaderBG01.new(f1_arg0, f1_arg1, 0.5, 0.5, -387, 463, 0.5, 0.5, -125, -110)
	CommonSubheaderBG06:setRGB(0.39, 0.39, 0.39)
	CommonSubheaderBG06.NoiseTiledBacking:setAlpha(0.8)
	CommonSubheaderBG06.NoiseTiledBacking3:setAlpha(0)
	CommonSubheaderBG06.NoiseTiledBacking2:setAlpha(0)
	self:addElement(CommonSubheaderBG06)
	self.CommonSubheaderBG06 = CommonSubheaderBG06
	local CommonSubheaderBG07 = CoD.CommonSubHeaderBG01.new(f1_arg0, f1_arg1, 0.5, 0.5, -868, -741, 0.5, 0.5, 98, 113)
	CommonSubheaderBG07:setRGB(0.39, 0.39, 0.39)
	CommonSubheaderBG07.NoiseTiledBacking:setAlpha(0.8)
	CommonSubheaderBG07.NoiseTiledBacking3:setAlpha(0)
	CommonSubheaderBG07.NoiseTiledBacking2:setAlpha(0)
	self:addElement(CommonSubheaderBG07)
	self.CommonSubheaderBG07 = CommonSubheaderBG07
	local CommonSubheaderBG08 = CoD.CommonSubHeaderBG01.new(f1_arg0, f1_arg1, 0.5, 0.5, -692, -127, 0.5, 0.5, 98, 113)
	CommonSubheaderBG08:setRGB(0.39, 0.39, 0.39)
	CommonSubheaderBG08.NoiseTiledBacking:setAlpha(0.8)
	CommonSubheaderBG08.NoiseTiledBacking3:setAlpha(0)
	CommonSubheaderBG08.NoiseTiledBacking2:setAlpha(0)
	self:addElement(CommonSubheaderBG08)
	self.CommonSubheaderBG08 = CommonSubheaderBG08
	local CommonSubheaderBG09 = CoD.CommonSubHeaderBG01.new(f1_arg0, f1_arg1, 0.5, 0.5, -101, 464, 0.5, 0.5, 98, 113)
	CommonSubheaderBG09:setRGB(0.39, 0.39, 0.39)
	CommonSubheaderBG09.NoiseTiledBacking:setAlpha(0.8)
	CommonSubheaderBG09.NoiseTiledBacking3:setAlpha(0)
	CommonSubheaderBG09.NoiseTiledBacking2:setAlpha(0)
	self:addElement(CommonSubheaderBG09)
	self.CommonSubheaderBG09 = CommonSubheaderBG09
	local CommonSubheaderBG10 = CoD.CommonSubHeaderBG01.new(f1_arg0, f1_arg1, 0.5, 0.5, -692, -127, 0.5, 0.5, 268, 283)
	CommonSubheaderBG10:setRGB(0.39, 0.39, 0.39)
	CommonSubheaderBG10.NoiseTiledBacking:setAlpha(0.8)
	CommonSubheaderBG10.NoiseTiledBacking3:setAlpha(0)
	CommonSubheaderBG10.NoiseTiledBacking2:setAlpha(0)
	self:addElement(CommonSubheaderBG10)
	self.CommonSubheaderBG10 = CommonSubheaderBG10
	local CommonSubheaderBG11 = CoD.CommonSubHeaderBG01.new(f1_arg0, f1_arg1, 0.5, 0.5, -101, 464, 0.5, 0.5, 268, 283)
	CommonSubheaderBG11:setRGB(0.39, 0.39, 0.39)
	CommonSubheaderBG11.NoiseTiledBacking:setAlpha(0.8)
	CommonSubheaderBG11.NoiseTiledBacking3:setAlpha(0)
	CommonSubheaderBG11.NoiseTiledBacking2:setAlpha(0)
	self:addElement(CommonSubheaderBG11)
	self.CommonSubheaderBG11 = CommonSubheaderBG11
	local Bank = CoD.BountyHunterBank.new(f1_arg0, f1_arg1, 0.5, 0.5, -138.5, 138.5, 0.5, 0.5, -454, -421)
	Bank:linkToElementModel(self, nil, false, function(model)
		Bank:setModel(model, f1_arg1)
	end)
	self:addElement(Bank)
	self.Bank = Bank
	local StageTitle = LUI.UIText.new(0.5, 0.5, -335, 335, 0.5, 0.5, -506, -462)
	StageTitle:setRGB(0, 0, 0)
	StageTitle:setText(Engine[@"hash_4F9F1239CFD921FE"](0xE8E14CAAF997B8))
	StageTitle:setTTF("ttmussels_demibold")
	StageTitle:setLetterSpacing(8)
	StageTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	StageTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(StageTitle)
	self.StageTitle = StageTitle
	local f1_local20 = nil
	f1_local20 = LUI.UIElement.createFake()
	self.FooterContainerFrontendRight = f1_local20
	local PrimaryBuy = CoD.BountyHunterWeaponBuy.new(f1_arg0, f1_arg1, 0.5, 0.5, -692, -412, 0.5, 0.5, -329, -202)
	PrimaryBuy.Header:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_23F59D1A91AF7F94"))
	PrimaryBuy:linkToElementModel(self, "primaryModel", false, function(model)
		PrimaryBuy:setModel(model, f1_arg1)
	end)
	PrimaryBuy:registerEventHandler("gain_focus", function(element, event)
		local f4_local0 = nil
		if element.gainFocus then
			f4_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f4_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f4_local0
	end)
	f1_arg0:AddButtonCallbackFunction(PrimaryBuy, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if CoD.BountyHunterUtility.IsBuyMenuVisible(self) and not IsDemoPlaying() then
			CoD.BountyHunterUtility.OpenBountyHunterOverlay(self, menu, controller, "BountyHunterPackageSelect", "primary")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.BountyHunterUtility.IsBuyMenuVisible(self) and not IsDemoPlaying() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(PrimaryBuy)
	self.PrimaryBuy = PrimaryBuy
	local SecondaryUpgradeHeader = LUI.UIText.new(0.5, 0.5, -238.5, -38.5, 0.5, 0.5, -137, -100)
	SecondaryUpgradeHeader:setAlpha(0)
	SecondaryUpgradeHeader:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6B74FA313E2030A0"))
	SecondaryUpgradeHeader:setTTF("default")
	SecondaryUpgradeHeader:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(SecondaryUpgradeHeader)
	self.SecondaryUpgradeHeader = SecondaryUpgradeHeader
	local PrimaryUpgradesHeader = LUI.UIText.new(0.5, 0.5, -146.5, 53.5, 0.5, 0.5, -337, -300)
	PrimaryUpgradesHeader:setAlpha(0)
	PrimaryUpgradesHeader:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_327B1CF8082C4D08"))
	PrimaryUpgradesHeader:setTTF("default")
	PrimaryUpgradesHeader:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(PrimaryUpgradesHeader)
	self.PrimaryUpgradesHeader = PrimaryUpgradesHeader
	local SecondaryBuy = CoD.BountyHunterWeaponBuy.new(f1_arg0, f1_arg1, 0.5, 0.5, -692, -412, 0.5, 0.5, -105, 22)
	SecondaryBuy.Header:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7296B5FAFF3D120C"))
	SecondaryBuy:linkToElementModel(self, "secondaryModel", false, function(model)
		SecondaryBuy:setModel(model, f1_arg1)
	end)
	SecondaryBuy:registerEventHandler("gain_focus", function(element, event)
		local f8_local0 = nil
		if element.gainFocus then
			f8_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f8_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f8_local0
	end)
	f1_arg0:AddButtonCallbackFunction(SecondaryBuy, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if CoD.BountyHunterUtility.IsBuyMenuVisible(self) and not IsDemoPlaying() then
			CoD.BountyHunterUtility.OpenBountyHunterOverlay(self, menu, controller, "BountyHunterPackageSelect", "secondary")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.BountyHunterUtility.IsBuyMenuVisible(self) and not IsDemoPlaying() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(SecondaryBuy)
	self.SecondaryBuy = SecondaryBuy
	local ArmorBuy = CoD.BountyHunterGenericBuy.new(f1_arg0, f1_arg1, 0.5, 0.5, -868, -741, 0.5, 0.5, -329, -202)
	ArmorBuy.Header:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5B1C3B30E1F15C09"))
	ArmorBuy:linkToElementModel(self, "armorModel", false, function(model)
		ArmorBuy:setModel(model, f1_arg1)
	end)
	ArmorBuy:registerEventHandler("gain_focus", function(element, event)
		local f12_local0 = nil
		if element.gainFocus then
			f12_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f12_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f12_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ArmorBuy, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if CoD.BountyHunterUtility.IsBuyMenuVisible(self) and not IsDemoPlaying() then
			CoD.BountyHunterUtility.OpenBountyHunterOverlay(self, menu, controller, "BountyHunterPackageSelect", "armor")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.BountyHunterUtility.IsBuyMenuVisible(self) and not IsDemoPlaying() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(ArmorBuy)
	self.ArmorBuy = ArmorBuy
	local ScorestreakBuy = CoD.BountyHunterGenericBuy.new(f1_arg0, f1_arg1, 0.5, 0.5, -868, -741, 0.5, 0.5, -105, 22)
	ScorestreakBuy.Header:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_549F052E5AE3E0AA"))
	ScorestreakBuy:linkToElementModel(self, "scorestreakModel", false, function(model)
		ScorestreakBuy:setModel(model, f1_arg1)
	end)
	ScorestreakBuy:registerEventHandler("gain_focus", function(element, event)
		local f16_local0 = nil
		if element.gainFocus then
			f16_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f16_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f16_local0
	end)
	f1_arg0:AddButtonCallbackFunction(ScorestreakBuy, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if CoD.BountyHunterUtility.IsBuyMenuVisible(self) and not IsDemoPlaying() then
			CoD.BountyHunterUtility.OpenBountyHunterOverlay(self, menu, controller, "BountyHunterPackageSelect", "scorestreak")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.BountyHunterUtility.IsBuyMenuVisible(self) and not IsDemoPlaying() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(ScorestreakBuy)
	self.ScorestreakBuy = ScorestreakBuy
	local EquipmentBuy = CoD.BountyHunterGenericBuy.new(f1_arg0, f1_arg1, 0.5, 0.5, -868, -741, 0.5, 0.5, 118, 245)
	EquipmentBuy.Header:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6E5B4A22F58A0272"))
	EquipmentBuy:linkToElementModel(self, "equipmentModel", false, function(model)
		EquipmentBuy:setModel(model, f1_arg1)
	end)
	EquipmentBuy:registerEventHandler("gain_focus", function(element, event)
		local f20_local0 = nil
		if element.gainFocus then
			f20_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f20_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f20_local0
	end)
	f1_arg0:AddButtonCallbackFunction(EquipmentBuy, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], "ui_confirm", function(element, menu, controller, model)
		if CoD.BountyHunterUtility.IsBuyMenuVisible(self) and not IsDemoPlaying() then
			CoD.BountyHunterUtility.OpenBountyHunterOverlay(self, menu, controller, "BountyHunterPackageSelect", "equipment")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.BountyHunterUtility.IsBuyMenuVisible(self) and not IsDemoPlaying() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select", nil, "ui_confirm")
			return true
		else
			return false
		end
	end, false)
	self:addElement(EquipmentBuy)
	self.EquipmentBuy = EquipmentBuy
	local PrimaryAmmoBuy = CoD.BountyHunterAmmoBuy.new(f1_arg0, f1_arg1, 0.5, 0.5, -692, -412, 0.5, 0.5, -197.5, -149.5)
	PrimaryAmmoBuy:linkToElementModel(self, "primaryModel", false, function(model)
		PrimaryAmmoBuy:setModel(model, f1_arg1)
	end)
	PrimaryAmmoBuy:registerEventHandler("gain_focus", function(element, event)
		local f24_local0 = nil
		if element.gainFocus then
			f24_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f24_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f24_local0
	end)
	f1_arg0:AddButtonCallbackFunction(PrimaryAmmoBuy, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if CoD.BountyHunterUtility.IsBuyMenuVisible(self) and not IsDemoPlaying() then
			CoD.BountyHunterUtility.BuyBountyPackageAmmo(controller, menu, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.BountyHunterUtility.IsBuyMenuVisible(self) and not IsDemoPlaying() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	self:addElement(PrimaryAmmoBuy)
	self.PrimaryAmmoBuy = PrimaryAmmoBuy
	local SecondaryAmmoBuy = CoD.BountyHunterAmmoBuy.new(f1_arg0, f1_arg1, 0.5, 0.5, -692, -412, 0.5, 0.5, 22, 70)
	SecondaryAmmoBuy:linkToElementModel(self, "secondaryModel", false, function(model)
		SecondaryAmmoBuy:setModel(model, f1_arg1)
	end)
	SecondaryAmmoBuy:registerEventHandler("gain_focus", function(element, event)
		local f28_local0 = nil
		if element.gainFocus then
			f28_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f28_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f28_local0
	end)
	f1_arg0:AddButtonCallbackFunction(SecondaryAmmoBuy, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if CoD.BountyHunterUtility.IsBuyMenuVisible(self) and not IsDemoPlaying() then
			CoD.BountyHunterUtility.BuyBountyPackageAmmo(controller, menu, element)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.BountyHunterUtility.IsBuyMenuVisible(self) and not IsDemoPlaying() then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_0", nil, nil)
			return false
		else
			return false
		end
	end, false)
	self:addElement(SecondaryAmmoBuy)
	self.SecondaryAmmoBuy = SecondaryAmmoBuy
	local MobilityUpgrades = CoD.BountyHunterTrackBuy.new(f1_arg0, f1_arg1, 0.5, 0.5, -692, -565, 0.5, 0.5, 118, 245)
	MobilityUpgrades.PackageTiers:setFilter(function(f31_arg0)
		return f31_arg0.packageType:get() == "mobility"
	end)
	MobilityUpgrades.PackageTiers:setDataSource("BountyHunterPackages")
	MobilityUpgrades.Header:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6AE4B345BCF69C5D"))
	MobilityUpgrades:linkToElementModel(self, "mobilityTrack", false, function(model)
		MobilityUpgrades:setModel(model, f1_arg1)
	end)
	self:addElement(MobilityUpgrades)
	self.MobilityUpgrades = MobilityUpgrades
	local ReconUpgrades = CoD.BountyHunterTrackBuy.new(f1_arg0, f1_arg1, 0.5, 0.5, -101, 26, 0.5, 0.5, 118, 245)
	ReconUpgrades.PackageTiers:setFilter(function(f33_arg0)
		return f33_arg0.packageType:get() == "recon"
	end)
	ReconUpgrades.PackageTiers:setDataSource("BountyHunterPackages")
	ReconUpgrades.Header:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7C33A77C747F9BEF"))
	ReconUpgrades:linkToElementModel(self, "reconTrack", false, function(model)
		ReconUpgrades:setModel(model, f1_arg1)
	end)
	self:addElement(ReconUpgrades)
	self.ReconUpgrades = ReconUpgrades
	local SupportUpgrades = CoD.BountyHunterTrackBuy.new(f1_arg0, f1_arg1, 0.5, 0.5, -101, 26, 0.5, 0.5, 288, 415)
	SupportUpgrades.PackageTiers:setFilter(function(f35_arg0)
		return f35_arg0.packageType:get() == "support"
	end)
	SupportUpgrades.PackageTiers:setDataSource("BountyHunterPackages")
	SupportUpgrades.Header:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_3BDD6ACC3F0AFE23"))
	SupportUpgrades:linkToElementModel(self, "supportTrack", false, function(model)
		SupportUpgrades:setModel(model, f1_arg1)
	end)
	self:addElement(SupportUpgrades)
	self.SupportUpgrades = SupportUpgrades
	local AssaultUpgrades = CoD.BountyHunterTrackBuy.new(f1_arg0, f1_arg1, 0.5, 0.5, -692, -565, 0.5, 0.5, 288, 415)
	AssaultUpgrades.PackageTiers:setFilter(function(f37_arg0)
		return f37_arg0.packageType:get() == "assault"
	end)
	AssaultUpgrades.PackageTiers:setDataSource("BountyHunterPackages")
	AssaultUpgrades.Header:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_5A150653B64E279F"))
	AssaultUpgrades:linkToElementModel(self, "assaultTrack", false, function(model)
		AssaultUpgrades:setModel(model, f1_arg1)
	end)
	self:addElement(AssaultUpgrades)
	self.AssaultUpgrades = AssaultUpgrades
	local PrimaryAttachments = CoD.BountyHunterTrackBuy.new(f1_arg0, f1_arg1, 0.5, 0.5, -387, -260, 0.5, 0.5, -329, -202)
	PrimaryAttachments.PackageTiers:setDataSource("BountyHunterPrimaryAttachments")
	PrimaryAttachments.Header:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_327B1CF8082C4D08"))
	self:addElement(PrimaryAttachments)
	self.PrimaryAttachments = PrimaryAttachments
	local SecondaryAttachments = CoD.BountyHunterTrackBuy.new(f1_arg0, f1_arg1, 0.5, 0.5, -387, -260, 0.5, 0.5, -105, 22)
	SecondaryAttachments.PackageTiers:setDataSource("BountyHunterSecondaryAttachments")
	SecondaryAttachments.Header:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6B74FA313E2030A0"))
	self:addElement(SecondaryAttachments)
	self.SecondaryAttachments = SecondaryAttachments
	local PackagePreview = CoD.BountyHunterPackagePreview.new(f1_arg0, f1_arg1, 0.5, 0.5, 488.5, 868.5, 0.5, 0.5, -349, 416)
	self:addElement(PackagePreview)
	self.PackagePreview = PackagePreview
	local HorizAccentTop = LUI.UIImage.new(0.5, 0.5, -870, 870, 0.5, 0.5, -388, -380)
	HorizAccentTop:setAlpha(0.15)
	HorizAccentTop:setImage(RegisterImage(@"hash_2FE30A9AF719A400"))
	HorizAccentTop:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	HorizAccentTop:setShaderVector(0, 0, 0, 0, 0)
	HorizAccentTop:setupNineSliceShader(8, 4)
	self:addElement(HorizAccentTop)
	self.HorizAccentTop = HorizAccentTop
	local HorizAccentTL = LUI.UIImage.new(0.5, 0.5, -896, -876, 0.5, 0.5, -388, -380)
	HorizAccentTL:setAlpha(0.07)
	HorizAccentTL:setImage(RegisterImage(@"hash_2FE30A9AF719A400"))
	HorizAccentTL:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	HorizAccentTL:setShaderVector(0, 0, 0, 0, 0)
	HorizAccentTL:setupNineSliceShader(8, 4)
	self:addElement(HorizAccentTL)
	self.HorizAccentTL = HorizAccentTL
	local HorizAccentTR = LUI.UIImage.new(0.5, 0.5, 874.5, 894.5, 0.5, 0.5, -388, -380)
	HorizAccentTR:setAlpha(0.07)
	HorizAccentTR:setImage(RegisterImage(@"hash_2FE30A9AF719A400"))
	HorizAccentTR:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	HorizAccentTR:setShaderVector(0, 0, 0, 0, 0)
	HorizAccentTR:setupNineSliceShader(8, 4)
	self:addElement(HorizAccentTR)
	self.HorizAccentTR = HorizAccentTR
	local HorizAccentBtm = LUI.UIImage.new(0.5, 0.5, -870, 870, 0.5, 0.5, 447, 455)
	HorizAccentBtm:setAlpha(0.15)
	HorizAccentBtm:setImage(RegisterImage(@"hash_2FE30A9AF719A400"))
	HorizAccentBtm:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	HorizAccentBtm:setShaderVector(0, 0, 0, 0, 0)
	HorizAccentBtm:setupNineSliceShader(8, 4)
	self:addElement(HorizAccentBtm)
	self.HorizAccentBtm = HorizAccentBtm
	local HorizAccentBL = LUI.UIImage.new(0.5, 0.5, -896, -876, 0.5, 0.5, 447, 455)
	HorizAccentBL:setAlpha(0.07)
	HorizAccentBL:setImage(RegisterImage(@"hash_2FE30A9AF719A400"))
	HorizAccentBL:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	HorizAccentBL:setShaderVector(0, 0, 0, 0, 0)
	HorizAccentBL:setupNineSliceShader(8, 4)
	self:addElement(HorizAccentBL)
	self.HorizAccentBL = HorizAccentBL
	local HorizAccentBR = LUI.UIImage.new(0.5, 0.5, 874.5, 894.5, 0.5, 0.5, 447, 455)
	HorizAccentBR:setAlpha(0.07)
	HorizAccentBR:setImage(RegisterImage(@"hash_2FE30A9AF719A400"))
	HorizAccentBR:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	HorizAccentBR:setShaderVector(0, 0, 0, 0, 0)
	HorizAccentBR:setupNineSliceShader(8, 4)
	self:addElement(HorizAccentBR)
	self.HorizAccentBR = HorizAccentBR
	local LinePattern01 = LUI.UIImage.new(0.5, 0.5, -868.5, 868.5, 0.5, 0.5, 458, 470)
	LinePattern01:setAlpha(0.02)
	LinePattern01:setImage(RegisterImage(@"uie_hud_common_stripe_pattern01"))
	LinePattern01:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_16CBE95C250C6D15"))
	LinePattern01:setShaderVector(0, 0, 0, 0, 0)
	LinePattern01:setupNineSliceShader(24, 12)
	self:addElement(LinePattern01)
	self.LinePattern01 = LinePattern01
	local BarAccentLeft = LUI.UIImage.new(0.5, 0.5, -951, -907, 0.5, 0.5, 27.5, 40.5)
	BarAccentLeft:setAlpha(0.07)
	BarAccentLeft:setImage(RegisterImage(@"hash_2FE30A9AF719A400"))
	BarAccentLeft:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	BarAccentLeft:setShaderVector(0, 0, 0, 0, 0)
	BarAccentLeft:setupNineSliceShader(8, 2)
	self:addElement(BarAccentLeft)
	self.BarAccentLeft = BarAccentLeft
	local BarAccentRight = LUI.UIImage.new(0.5, 0.5, 901, 945, 0.5, 0.5, 27.5, 40.5)
	BarAccentRight:setAlpha(0.07)
	BarAccentRight:setImage(RegisterImage(@"hash_2FE30A9AF719A400"))
	BarAccentRight:setMaterial(LUI.UIImage.GetCachedMaterial(@"uie_nineslice_normal"))
	BarAccentRight:setShaderVector(0, 0, 0, 0, 0)
	BarAccentRight:setupNineSliceShader(8, 2)
	self:addElement(BarAccentRight)
	self.BarAccentRight = BarAccentRight
	self:linkToElementModel(self, "primary", true, function(model)
		local f39_local0 = self
		CoD.BountyHunterUtility.SetPackageInSlotByPackageId(self, "primary", model)
	end)
	self:linkToElementModel(self, "secondary", true, function(model)
		local f40_local0 = self
		CoD.BountyHunterUtility.SetPackageInSlotByPackageId(self, "secondary", model)
	end)
	self:linkToElementModel(self, "armor", true, function(model)
		local f41_local0 = self
		CoD.BountyHunterUtility.SetPackageInSlotByPackageId(self, "armor", model)
	end)
	self:linkToElementModel(self, "scorestreak", true, function(model)
		local f42_local0 = self
		CoD.BountyHunterUtility.SetPackageInSlotByPackageId(self, "scorestreak", model)
	end)
	self:linkToElementModel(self, "equipment", true, function(model)
		local f43_local0 = self
		CoD.BountyHunterUtility.SetPackageInSlotByPackageId(self, "equipment", model)
	end)
	f1_local20:appendEventHandler("menu_loaded", function()
		f1_local20:setModel(f1_arg0.buttonModel, f1_arg1)
	end)
	PrimaryBuy.id = "PrimaryBuy"
	SecondaryBuy.id = "SecondaryBuy"
	ArmorBuy.id = "ArmorBuy"
	ScorestreakBuy.id = "ScorestreakBuy"
	EquipmentBuy.id = "EquipmentBuy"
	PrimaryAmmoBuy.id = "PrimaryAmmoBuy"
	SecondaryAmmoBuy.id = "SecondaryAmmoBuy"
	MobilityUpgrades.id = "MobilityUpgrades"
	ReconUpgrades.id = "ReconUpgrades"
	SupportUpgrades.id = "SupportUpgrades"
	AssaultUpgrades.id = "AssaultUpgrades"
	PrimaryAttachments.id = "PrimaryAttachments"
	SecondaryAttachments.id = "SecondaryAttachments"
	self.__defaultFocus = ArmorBuy
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.BountyHunterBuyInternal.__onClose = function(f45_arg0)
	f45_arg0.CommonCornerBrackets:close()
	f45_arg0.CommonHeaderBG01:close()
	f45_arg0.CommonSubheaderBG:close()
	f45_arg0.CommonSubheaderBG01:close()
	f45_arg0.CommonSubheaderBG02:close()
	f45_arg0.CommonSubheaderBG03:close()
	f45_arg0.CommonSubheaderBG04:close()
	f45_arg0.CommonSubheaderBG05:close()
	f45_arg0.CommonSubheaderBG06:close()
	f45_arg0.CommonSubheaderBG07:close()
	f45_arg0.CommonSubheaderBG08:close()
	f45_arg0.CommonSubheaderBG09:close()
	f45_arg0.CommonSubheaderBG10:close()
	f45_arg0.CommonSubheaderBG11:close()
	f45_arg0.Bank:close()
	f45_arg0.FooterContainerFrontendRight:close()
	f45_arg0.PrimaryBuy:close()
	f45_arg0.SecondaryBuy:close()
	f45_arg0.ArmorBuy:close()
	f45_arg0.ScorestreakBuy:close()
	f45_arg0.EquipmentBuy:close()
	f45_arg0.PrimaryAmmoBuy:close()
	f45_arg0.SecondaryAmmoBuy:close()
	f45_arg0.MobilityUpgrades:close()
	f45_arg0.ReconUpgrades:close()
	f45_arg0.SupportUpgrades:close()
	f45_arg0.AssaultUpgrades:close()
	f45_arg0.PrimaryAttachments:close()
	f45_arg0.SecondaryAttachments:close()
	f45_arg0.PackagePreview:close()
end
