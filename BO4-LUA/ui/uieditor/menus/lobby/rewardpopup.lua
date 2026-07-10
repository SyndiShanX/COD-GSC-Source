require("x64:4cee61320cd1f1b")
require("x64:c13cdf83d1e2b76")
require("x64:c829ac7d797ba4c")
CoD.RewardPopup = InheritFrom(CoD.Menu)
LUI.createMenu.RewardPopup = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("RewardPopup", f1_arg0)
	local f1_local1 = self
	if not IsPC() then
		MenuHidesFreeCursor(f1_local1, f1_arg0)
	elseif IsPC() then
		MenuHidesFreeCursor(f1_local1, f1_arg0)
		CoD.PCUtility.LockUIShortcutInput(f1_local1, f1_arg0)
	end
	self:setClass(CoD.RewardPopup)
	self.soundSet = "MultiplayerMain"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local backing = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	backing:setRGB(0, 0, 0)
	backing:setMaterial(LUI.UIImage.GetCachedMaterial(0xE2354BE557C4C7A))
	backing:setShaderVector(0, 0, 0, 0, 0)
	self:addElement(backing)
	self.backing = backing
	local BackgroundImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	BackgroundImage:setAlpha(0.85)
	BackgroundImage:setImage(RegisterImage(0x4BF88A437F4C579))
	self:addElement(BackgroundImage)
	self.BackgroundImage = BackgroundImage
	local f1_local4 = nil
	f1_local4 = LUI.UIElement.createFake()
	self.FooterContainerFrontendRight = f1_local4
	local RewardBacking = LUI.UIImage.new(0.5, 0.5, -578, 578, 0.5, 0.5, -140, 196)
	RewardBacking:setRGB(0, 0, 0)
	RewardBacking:setAlpha(0.1)
	RewardBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0xA02C44161370F6D))
	RewardBacking:setShaderVector(0, 0, 0, 0, 0)
	RewardBacking:setShaderVector(1, 1, 1, 0, 0)
	RewardBacking:setShaderVector(2, 0, 0, 0, 0)
	self:addElement(RewardBacking)
	self.RewardBacking = RewardBacking
	local NoiseTiledBacking = LUI.UIImage.new(0.5, 0.5, -577.5, 577.5, 0.5, 0.5, -140.5, 195.5)
	NoiseTiledBacking:setAlpha(0.15)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local RewardDotTiledBacking2 = CoD.StoreCommonTextBacking02.new(f1_local1, f1_arg0, 0.5, 0.5, -578, 578, 0.5, 0.5, -140, 196)
	self:addElement(RewardDotTiledBacking2)
	self.RewardDotTiledBacking2 = RewardDotTiledBacking2
	local RewardImage = LUI.UIImage.new(0.5, 0.5, -578, 578, 0.5, 0.5, -140.5, 195.5)
	RewardImage:setImage(RegisterImage(0xD9F3B069441FE5))
	self:addElement(RewardImage)
	self.RewardImage = RewardImage
	local featureOverlayButtonMouseOnly = nil
	featureOverlayButtonMouseOnly = CoD.featureOverlay_Button_MouseOnly.new(f1_local1, f1_arg0, 0.5, 0.5, 519.5, 679.5, 0.5, 0.5, 264, 324)
	featureOverlayButtonMouseOnly:mergeStateConditions({
		{
			stateName = "Hide",
			condition = function(menu, element, event)
				return not IsPC()
			end,
		},
	})
	featureOverlayButtonMouseOnly.featureOverlayButtonContainer.Title:setText(Engine[0xF9F1239CFD921FE](0x6393FF34EA56966))
	featureOverlayButtonMouseOnly:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f3_local0
	end)
	f1_local1:AddButtonCallbackFunction(featureOverlayButtonMouseOnly, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		CoD.EntitlementUtility.CloseRewardPopup(menu, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(featureOverlayButtonMouseOnly)
	self.featureOverlayButtonMouseOnly = featureOverlayButtonMouseOnly
	local OptionDesc = LUI.UIText.new(0.5, 0.5, -577.5, 577.5, 0.5, 0.5, -209, -184)
	OptionDesc:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	OptionDesc:setText(LocalizeHash(0xD79A51ACF66B185))
	OptionDesc:setTTF("dinnext_regular")
	OptionDesc:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	OptionDesc:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	self:addElement(OptionDesc)
	self.OptionDesc = OptionDesc
	local Codpoints = CoD.StartMenu_CODpoints.new(f1_local1, f1_arg0, 0.5, 0.5, 414, 628, 0.5, 0.5, -302, -253)
	Codpoints:setAlpha(0)
	Codpoints:subscribeToGlobalModel(f1_arg0, "LootStreamProgress", "codPoints", function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			Codpoints.codpointsCount:setText(SetValueIfNumberEqualTo(-1, "-", f6_local0))
		end
	end)
	self:addElement(Codpoints)
	self.Codpoints = Codpoints
	local Title = LUI.UIText.new(0.5, 0.5, -577.5, 391.5, 0.5, 0.5, -315, -240)
	Title:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Title:setText(LocalizeToUpperString(0x47950E1D81DD119))
	Title:setTTF("ttmussels_regular")
	Title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Title:setAlignment(Enum[0x7A5123B654282D2][0xE821F0ECFF8D1C7])
	self:addElement(Title)
	self.Title = Title
	local BoundaryBot2 = LUI.UIImage.new(0.5, 0.5, -880.5, -319.5, 0.5, 0.5, -61, -45)
	BoundaryBot2:setAlpha(0.15)
	BoundaryBot2:setZRot(-90)
	BoundaryBot2:setImage(RegisterImage(0x614FFDE5DDC2DFB))
	BoundaryBot2:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	BoundaryBot2:setShaderVector(0, 0, 0, 0, 0)
	BoundaryBot2:setupNineSliceShader(66, 8)
	self:addElement(BoundaryBot2)
	self.BoundaryBot2 = BoundaryBot2
	local BoundaryBot = LUI.UIImage.new(0.5, 0.5, 319.5, 880.5, 0.5, 0.5, -61, -45)
	BoundaryBot:setAlpha(0.15)
	BoundaryBot:setZRot(90)
	BoundaryBot:setImage(RegisterImage(0x614FFDE5DDC2DFB))
	BoundaryBot:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	BoundaryBot:setShaderVector(0, 0, 0, 0, 0)
	BoundaryBot:setupNineSliceShader(66, 8)
	self:addElement(BoundaryBot)
	self.BoundaryBot = BoundaryBot
	local Banner = LUI.UIImage.new(0.5, 0.5, -600, 600, 0.5, 0.5, -464.5, -344.5)
	Banner:setImage(RegisterImage(CoD.EntitlementUtility.GetBannerImage(f1_arg0, 0x7615068F50B3D66)))
	self:addElement(Banner)
	self.Banner = Banner
	local FrontendFocusPip = LUI.UIImage.new(0.5, 0.5, -582, 583, 0.5, 0.5, -145.5, 200.5)
	FrontendFocusPip:setAlpha(0.15)
	FrontendFocusPip:setImage(RegisterImage(0x793C73633F620BB))
	FrontendFocusPip:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrontendFocusPip:setShaderVector(0, 0, 0, 0, 0)
	FrontendFocusPip:setupNineSliceShader(44, 44)
	self:addElement(FrontendFocusPip)
	self.FrontendFocusPip = FrontendFocusPip
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if not IsPC() then
			CoD.EntitlementUtility.CloseRewardPopup(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if not IsPC() then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x5BE4A02B20F31F1, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local4:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		featureOverlayButtonMouseOnly.id = "featureOverlayButtonMouseOnly"
	end
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
CoD.RewardPopup.__onClose = function(f9_arg0)
	f9_arg0.FooterContainerFrontendRight:close()
	f9_arg0.RewardDotTiledBacking2:close()
	f9_arg0.featureOverlayButtonMouseOnly:close()
	f9_arg0.Codpoints:close()
end
