require("x64:acbf06924421e35")
require("x64:410513393f3b18c")
require("x64:f027dcc6409e42c")
CoD.BOPassPopup = InheritFrom(CoD.Menu)
LUI.createMenu.BOPassPopup = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("BOPassPopup", f1_arg0)
	local f1_local1 = self
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	self:setClass(CoD.BOPassPopup)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
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
	local Title = LUI.UIText.new(0.5, 0.5, -571, 561, 0.5, 0.5, -426, -351)
	Title:setRGB(ColorSet.T8__BIEGE.r, ColorSet.T8__BIEGE.g, ColorSet.T8__BIEGE.b)
	Title:setText(LocalizeToUpperString(0xDADF4DAD3B581AC))
	Title:setTTF("ttmussels_regular")
	Title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Title:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(Title)
	self.Title = Title
	local BoundaryBot2 = LUI.UIImage.new(0.5, 0.5, -1000.5, -240.5, 0.5, 0.5, -55, -39)
	BoundaryBot2:setAlpha(0.15)
	BoundaryBot2:setZRot(-90)
	BoundaryBot2:setImage(RegisterImage(0x614FFDE5DDC2DFB))
	BoundaryBot2:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	BoundaryBot2:setShaderVector(0, 0, 0, 0, 0)
	BoundaryBot2:setupNineSliceShader(66, 8)
	self:addElement(BoundaryBot2)
	self.BoundaryBot2 = BoundaryBot2
	local BoundaryBot = LUI.UIImage.new(0.5, 0.5, 240.5, 1000.5, 0.5, 0.5, -63, -47)
	BoundaryBot:setAlpha(0.15)
	BoundaryBot:setZRot(90)
	BoundaryBot:setImage(RegisterImage(0x614FFDE5DDC2DFB))
	BoundaryBot:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	BoundaryBot:setShaderVector(0, 0, 0, 0, 0)
	BoundaryBot:setupNineSliceShader(66, 8)
	self:addElement(BoundaryBot)
	self.BoundaryBot = BoundaryBot
	local Backing = LUI.UIImage.new(0.5, 0.5, 52.5, 461.5, 0.5, 0.5, -226.5, 142.5)
	Backing:setAlpha(0.01)
	self:addElement(Backing)
	self.Backing = Backing
	local NoiseTiledBacking = LUI.UIImage.new(0.5, 0.5, 45, 469, 0.5, 0.5, -234, 150)
	NoiseTiledBacking:setAlpha(0.4)
	NoiseTiledBacking:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking)
	self.NoiseTiledBacking = NoiseTiledBacking
	local NoiseTiledBackingAdd = LUI.UIImage.new(0.5, 0.5, 52.5, 461.5, 0.5, 0.5, -226.5, 142.5)
	NoiseTiledBackingAdd:setAlpha(0.35)
	NoiseTiledBackingAdd:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBackingAdd:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	NoiseTiledBackingAdd:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBackingAdd:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBackingAdd)
	self.NoiseTiledBackingAdd = NoiseTiledBackingAdd
	local NoiseTiledBackingAdd2 = LUI.UIImage.new(0.5, 0.5, 57, 457, 0.5, 0.5, 34.5, 138.5)
	NoiseTiledBackingAdd2:setAlpha(0.35)
	NoiseTiledBackingAdd2:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBackingAdd2:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	NoiseTiledBackingAdd2:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBackingAdd2:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBackingAdd2)
	self.NoiseTiledBackingAdd2 = NoiseTiledBackingAdd2
	local CommonCornerPips = CoD.CommonCornerPips01.new(f1_local1, f1_arg0, 0.5, 0.5, 52.5, 461.5, 0.5, 0.5, -226.5, 142.5)
	self:addElement(CommonCornerPips)
	self.CommonCornerPips = CommonCornerPips
	local Backing2 = LUI.UIImage.new(0.5, 0.5, -464.5, -55.5, 0.5, 0.5, -226.5, 142.5)
	Backing2:setAlpha(0.01)
	self:addElement(Backing2)
	self.Backing2 = Backing2
	local NoiseTiledBacking2 = LUI.UIImage.new(0.5, 0.5, -472, -48, 0.5, 0.5, -234, 150)
	NoiseTiledBacking2:setAlpha(0.4)
	NoiseTiledBacking2:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBacking2:setMaterial(LUI.UIImage.GetCachedMaterial(0x6CBE95C250C6D15))
	NoiseTiledBacking2:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBacking2:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBacking2)
	self.NoiseTiledBacking2 = NoiseTiledBacking2
	local NoiseTiledBackingAdd3 = LUI.UIImage.new(0.5, 0.5, -464.5, -55.5, 0.5, 0.5, -226.5, 142.5)
	NoiseTiledBackingAdd3:setAlpha(0.35)
	NoiseTiledBackingAdd3:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBackingAdd3:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	NoiseTiledBackingAdd3:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBackingAdd3:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBackingAdd3)
	self.NoiseTiledBackingAdd3 = NoiseTiledBackingAdd3
	local NoiseTiledBackingAdd4 = LUI.UIImage.new(0.5, 0.5, -460, -60, 0.5, 0.5, 34.5, 138.5)
	NoiseTiledBackingAdd4:setAlpha(0.35)
	NoiseTiledBackingAdd4:setImage(RegisterImage(0x34839E8065B1E53))
	NoiseTiledBackingAdd4:setMaterial(LUI.UIImage.GetCachedMaterial(0x7C9C02F608D0A75))
	NoiseTiledBackingAdd4:setShaderVector(0, 0, 0, 0, 0)
	NoiseTiledBackingAdd4:setupNineSliceShader(196, 88)
	self:addElement(NoiseTiledBackingAdd4)
	self.NoiseTiledBackingAdd4 = NoiseTiledBackingAdd4
	local CommonCornerPips2 = CoD.CommonCornerPips01.new(f1_local1, f1_arg0, 0.5, 0.5, -464.5, -55.5, 0.5, 0.5, -226.5, 142.5)
	self:addElement(CommonCornerPips2)
	self.CommonCornerPips2 = CommonCornerPips2
	local cpcoins1000 = LUI.UIImage.new(0.5, 0.5, -472, -48, 0.5, 0.5, -234, 150)
	cpcoins1000:setImage(RegisterImage(0xC0AC0371A79726E))
	self:addElement(cpcoins1000)
	self.cpcoins1000 = cpcoins1000
	local plasmaicon = LUI.UIImage.new(0.5, 0.5, 45, 469, 0.5, 0.5, -234, 150)
	plasmaicon:setImage(RegisterImage(0x4C30AB0AA3800B6))
	self:addElement(plasmaicon)
	self.plasmaicon = plasmaicon
	local item1desc = LUI.UIText.new(0.5, 0.5, -460, -60, 0.5, 0.5, 95, 131)
	item1desc:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	item1desc:setText(Engine[0xF9F1239CFD921FE](0xFD3412692341CF1))
	item1desc:setTTF("ttmussels_demibold")
	item1desc:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(item1desc)
	self.item1desc = item1desc
	local item1price = LUI.UIText.new(0.5, 0.5, -460, -60, 0.5, 0.5, 40, 103)
	item1price:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	item1price:setText(Engine[0xF9F1239CFD921FE](0x845B392792028A6))
	item1price:setTTF("ttmussels_demibold")
	item1price:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(item1price)
	self.item1price = item1price
	local item2desc = LUI.UIText.new(0.5, 0.5, 57, 457, 0.5, 0.5, 95, 131)
	item2desc:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	item2desc:setText(Engine[0xF9F1239CFD921FE](0xFC243269225AD24))
	item2desc:setTTF("ttmussels_demibold")
	item2desc:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(item2desc)
	self.item2desc = item2desc
	local item2price = LUI.UIText.new(0.5, 0.5, 57, 457, 0.5, 0.5, 40, 103)
	item2price:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	item2price:setText(Engine[0xF9F1239CFD921FE](0x1F2937EBE39E92D))
	item2price:setTTF("ttmussels_demibold")
	item2price:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	self:addElement(item2price)
	self.item2price = item2price
	local RedeemButtonPC = nil
	RedeemButtonPC = CoD.PC_MOTD_Buttons.new(f1_local1, f1_arg0, 0.5, 0.5, 324.5, 564.5, 0.5, 0.5, 342, 422)
	RedeemButtonPC.OptionText:setText(LocalizeToUpperString(0x867BE59364DD53B))
	RedeemButtonPC:linkToElementModel(self, "image", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			RedeemButtonPC.Icon:setImage(RegisterImage(f2_local0))
		end
	end)
	RedeemButtonPC:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f3_local0
	end)
	f1_local1:AddButtonCallbackFunction(RedeemButtonPC, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if CoD.EntitlementUtility.HasSeasonPassToken(controller) then
			CoD.EntitlementUtility.OpenRedeemBOPassPopup(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.EntitlementUtility.HasSeasonPassToken(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x867BE59364DD53B, nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(RedeemButtonPC)
	self.RedeemButtonPC = RedeemButtonPC
	local BOPassRewardsandDisclaimers = CoD.BOPassRewardsandDisclaimers.new(f1_local1, f1_arg0, 0.5, 0.5, -549, 51, 0.5, 0.5, 173, 273)
	BOPassRewardsandDisclaimers:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	self:addElement(BOPassRewardsandDisclaimers)
	self.BOPassRewardsandDisclaimers = BOPassRewardsandDisclaimers
	self:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	self:registerEventHandler("occlusion_change", function(self, event)
		local f7_local0 = nil
		if self.OcclusionChange then
			f7_local0 = self:OcclusionChange(event)
		elseif self.super.OcclusionChange then
			f7_local0 = self.super:OcclusionChange(event)
		end
		UpdateButtonPromptState(f1_local1, self, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		if not f7_local0 then
			f7_local0 = self:dispatchEventToChildren(event)
		end
		return f7_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		if CoD.EntitlementUtility.HasSeasonPassToken(controller) then
			CoD.EntitlementUtility.OpenRedeemBOPassPopup(menu, controller)
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.EntitlementUtility.HasSeasonPassToken(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x867BE59364DD53B, nil, nil)
			return true
		else
			return false
		end
	end, false)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], "ESCAPE", function(element, menu, controller, model)
		CoD.EntitlementUtility.GoBackAndOpenEntitlementPopups(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x805EFA15E9E7E5A], 0x6C253CF816B40B5, nil, "ESCAPE")
		return true
	end, false)
	f1_local4:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		RedeemButtonPC.id = "RedeemButtonPC"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local26 = self
	if IsPC() then
		CoD.PCUtility.LockUIShortcutInput(f1_local1, f1_arg0)
	end
	return self
end
CoD.BOPassPopup.__resetProperties = function(f12_arg0)
	f12_arg0.BOPassRewardsandDisclaimers:completeAnimation()
	f12_arg0.item2price:completeAnimation()
	f12_arg0.item2desc:completeAnimation()
	f12_arg0.item1price:completeAnimation()
	f12_arg0.item1desc:completeAnimation()
	f12_arg0.plasmaicon:completeAnimation()
	f12_arg0.cpcoins1000:completeAnimation()
	f12_arg0.CommonCornerPips2:completeAnimation()
	f12_arg0.NoiseTiledBackingAdd4:completeAnimation()
	f12_arg0.NoiseTiledBackingAdd3:completeAnimation()
	f12_arg0.NoiseTiledBacking2:completeAnimation()
	f12_arg0.Backing2:completeAnimation()
	f12_arg0.CommonCornerPips:completeAnimation()
	f12_arg0.NoiseTiledBackingAdd2:completeAnimation()
	f12_arg0.NoiseTiledBackingAdd:completeAnimation()
	f12_arg0.NoiseTiledBacking:completeAnimation()
	f12_arg0.Backing:completeAnimation()
	f12_arg0.BOPassRewardsandDisclaimers:setTopBottom(0.5, 0.5, 173, 273)
	f12_arg0.item2price:setTopBottom(0.5, 0.5, 40, 103)
	f12_arg0.item2desc:setTopBottom(0.5, 0.5, 95, 131)
	f12_arg0.item1price:setTopBottom(0.5, 0.5, 40, 103)
	f12_arg0.item1desc:setTopBottom(0.5, 0.5, 95, 131)
	f12_arg0.plasmaicon:setTopBottom(0.5, 0.5, -234, 150)
	f12_arg0.cpcoins1000:setTopBottom(0.5, 0.5, -234, 150)
	f12_arg0.CommonCornerPips2:setTopBottom(0.5, 0.5, -226.5, 142.5)
	f12_arg0.NoiseTiledBackingAdd4:setTopBottom(0.5, 0.5, 34.5, 138.5)
	f12_arg0.NoiseTiledBackingAdd3:setTopBottom(0.5, 0.5, -226.5, 142.5)
	f12_arg0.NoiseTiledBacking2:setTopBottom(0.5, 0.5, -234, 150)
	f12_arg0.Backing2:setTopBottom(0.5, 0.5, -226.5, 142.5)
	f12_arg0.CommonCornerPips:setTopBottom(0.5, 0.5, -226.5, 142.5)
	f12_arg0.NoiseTiledBackingAdd2:setTopBottom(0.5, 0.5, 34.5, 138.5)
	f12_arg0.NoiseTiledBackingAdd:setTopBottom(0.5, 0.5, -226.5, 142.5)
	f12_arg0.NoiseTiledBacking:setTopBottom(0.5, 0.5, -234, 150)
	f12_arg0.Backing:setTopBottom(0.5, 0.5, -226.5, 142.5)
end
CoD.BOPassPopup.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
	},
	PC = {
		DefaultClip = function(f14_arg0, f14_arg1)
			f14_arg0:__resetProperties()
			f14_arg0:setupElementClipCounter(17)
			f14_arg0.Backing:completeAnimation()
			f14_arg0.Backing:setTopBottom(0.5, 0.5, -261.5, 107.5)
			f14_arg0.clipFinished(f14_arg0.Backing)
			f14_arg0.NoiseTiledBacking:completeAnimation()
			f14_arg0.NoiseTiledBacking:setTopBottom(0.5, 0.5, -269, 115)
			f14_arg0.clipFinished(f14_arg0.NoiseTiledBacking)
			f14_arg0.NoiseTiledBackingAdd:completeAnimation()
			f14_arg0.NoiseTiledBackingAdd:setTopBottom(0.5, 0.5, -261.5, 107.5)
			f14_arg0.clipFinished(f14_arg0.NoiseTiledBackingAdd)
			f14_arg0.NoiseTiledBackingAdd2:completeAnimation()
			f14_arg0.NoiseTiledBackingAdd2:setTopBottom(0.5, 0.5, -0.5, 103.5)
			f14_arg0.clipFinished(f14_arg0.NoiseTiledBackingAdd2)
			f14_arg0.CommonCornerPips:completeAnimation()
			f14_arg0.CommonCornerPips:setTopBottom(0.5, 0.5, -261.5, 107.5)
			f14_arg0.clipFinished(f14_arg0.CommonCornerPips)
			f14_arg0.Backing2:completeAnimation()
			f14_arg0.Backing2:setTopBottom(0.5, 0.5, -261.5, 107.5)
			f14_arg0.clipFinished(f14_arg0.Backing2)
			f14_arg0.NoiseTiledBacking2:completeAnimation()
			f14_arg0.NoiseTiledBacking2:setTopBottom(0.5, 0.5, -269, 115)
			f14_arg0.clipFinished(f14_arg0.NoiseTiledBacking2)
			f14_arg0.NoiseTiledBackingAdd3:completeAnimation()
			f14_arg0.NoiseTiledBackingAdd3:setTopBottom(0.5, 0.5, -261.5, 107.5)
			f14_arg0.clipFinished(f14_arg0.NoiseTiledBackingAdd3)
			f14_arg0.NoiseTiledBackingAdd4:completeAnimation()
			f14_arg0.NoiseTiledBackingAdd4:setTopBottom(0.5, 0.5, -0.5, 103.5)
			f14_arg0.clipFinished(f14_arg0.NoiseTiledBackingAdd4)
			f14_arg0.CommonCornerPips2:completeAnimation()
			f14_arg0.CommonCornerPips2:setTopBottom(0.5, 0.5, -261.5, 107.5)
			f14_arg0.clipFinished(f14_arg0.CommonCornerPips2)
			f14_arg0.cpcoins1000:completeAnimation()
			f14_arg0.cpcoins1000:setTopBottom(0.5, 0.5, -269, 115)
			f14_arg0.clipFinished(f14_arg0.cpcoins1000)
			f14_arg0.plasmaicon:completeAnimation()
			f14_arg0.plasmaicon:setTopBottom(0.5, 0.5, -269, 115)
			f14_arg0.clipFinished(f14_arg0.plasmaicon)
			f14_arg0.item1desc:completeAnimation()
			f14_arg0.item1desc:setTopBottom(0.5, 0.5, 60, 96)
			f14_arg0.clipFinished(f14_arg0.item1desc)
			f14_arg0.item1price:completeAnimation()
			f14_arg0.item1price:setTopBottom(0.5, 0.5, 5, 68)
			f14_arg0.clipFinished(f14_arg0.item1price)
			f14_arg0.item2desc:completeAnimation()
			f14_arg0.item2desc:setTopBottom(0.5, 0.5, 60, 96)
			f14_arg0.clipFinished(f14_arg0.item2desc)
			f14_arg0.item2price:completeAnimation()
			f14_arg0.item2price:setTopBottom(0.5, 0.5, 5, 68)
			f14_arg0.clipFinished(f14_arg0.item2price)
			f14_arg0.BOPassRewardsandDisclaimers:completeAnimation()
			f14_arg0.BOPassRewardsandDisclaimers:setTopBottom(0.5, 0.5, 151, 251)
			f14_arg0.clipFinished(f14_arg0.BOPassRewardsandDisclaimers)
		end,
	},
}
CoD.BOPassPopup.__onClose = function(f15_arg0)
	f15_arg0.FooterContainerFrontendRight:close()
	f15_arg0.CommonCornerPips:close()
	f15_arg0.CommonCornerPips2:close()
	f15_arg0.RedeemButtonPC:close()
	f15_arg0.BOPassRewardsandDisclaimers:close()
end
