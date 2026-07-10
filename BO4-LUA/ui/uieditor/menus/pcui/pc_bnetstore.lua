require("x64:ce1e6b6549d478c")
require("x64:262783dc22b4707")
require("x64:606983d188de2b0")
require("x64:3a1772776cde124")
CoD.PC_BnetStore = InheritFrom(CoD.Menu)
LUI.createMenu.PC_BnetStore = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("PC_BnetStore", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.PC_BnetStore)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local Background = LUI.UIImage.new(-0.1, 1.1, 0, 0, 0, 1, 0, 0)
	Background:setRGB(0, 0, 0)
	self:addElement(Background)
	self.Background = Background
	local PCBnetStoreKeyart = CoD.PC_BnetStore_Keyart.new(f1_local1, f1_arg0, 0.5, 0.5, -1160, 760, 1, 1, -1305, 0)
	self:addElement(PCBnetStoreKeyart)
	self.PCBnetStoreKeyart = PCBnetStoreKeyart
	local DevsLogos = CoD.PC_BnetStore_DevsLogos.new(f1_local1, f1_arg0, 0.5, 0.5, -887.5, 887.5, 1, 1, -111.5, -86.5)
	self:addElement(DevsLogos)
	self.DevsLogos = DevsLogos
	local FooterContainerFrontendRight = CoD.FooterContainer_Frontend_Right.new(f1_local1, f1_arg0, 0, 1, 0, 0, 1, 1, -48, 0)
	self:addElement(FooterContainerFrontendRight)
	self.FooterContainerFrontendRight = FooterContainerFrontendRight
	local FooterBlocker = LUI.UIImage.new(-0.1, 1.1, 0, 0, 1, 1, -62, 66)
	FooterBlocker:setRGB(0.07, 0.06, 0.06)
	FooterBlocker:setAlpha(0)
	self:addElement(FooterBlocker)
	self.FooterBlocker = FooterBlocker
	local PCBnetStoreContainer = CoD.PC_BnetStore_Container.new(f1_local1, f1_arg0, 0.5, 0.5, 185, 825, 1, 1, -1007, -163)
	PCBnetStoreContainer.StageTitle:setText(LocalizeToUpperString(@"hash_54A067A2D7727CE4"))
	self:addElement(PCBnetStoreContainer)
	self.PCBnetStoreContainer = PCBnetStoreContainer
	local PrePurchase = LUI.UIText.new(0.5, 0.5, -822, -528, 1, 1, -1018, -990)
	PrePurchase:setRGB(0, 0, 0)
	PrePurchase:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_688BFFCBDA7E5396"))
	PrePurchase:setTTF("0arame_mono_stencil")
	PrePurchase:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PrePurchase:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(PrePurchase)
	self.PrePurchase = PrePurchase
	local ReleaseDate = LUI.UIText.new(0.5, 0.5, -822, -528, 1, 1, -990, -959)
	ReleaseDate:setRGB(0.36, 0.36, 0.36)
	ReleaseDate:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_42CD01365C5A2E61"))
	ReleaseDate:setTTF("0arame_mono_stencil")
	ReleaseDate:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	self:addElement(ReleaseDate)
	self.ReleaseDate = ReleaseDate
	local ReleaseDate2 = LUI.UIText.new(0.5, 0.5, -905.5, 905.5, 1, 1, -148, -131)
	ReleaseDate2:setAlpha(0.15)
	ReleaseDate2:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_7F3200402A68058B"))
	ReleaseDate2:setTTF("dinnext_regular")
	ReleaseDate2:setLineSpacing(2)
	ReleaseDate2:setAlignment(Enum[@"luialignment"][@"lui_alignment_center"])
	ReleaseDate2:setAlignment(Enum[@"luialignment"][@"lui_alignment_bottom"])
	self:addElement(ReleaseDate2)
	self.ReleaseDate2 = ReleaseDate2
	self:registerEventHandler("close_all_ingame_menus", function(self, event)
		local f2_local0 = nil
		CoD.PCUtility.ShortcutMenuGoBack(f1_local1, f1_arg0)
		if not f2_local0 then
			f2_local0 = self:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	FooterContainerFrontendRight:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		FooterContainerFrontendRight.id = "FooterContainerFrontendRight"
	end
	PCBnetStoreContainer.id = "PCBnetStoreContainer"
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = FooterContainerFrontendRight
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local11 = self
	return self
end
CoD.PC_BnetStore.__onClose = function(f5_arg0)
	f5_arg0.PCBnetStoreKeyart:close()
	f5_arg0.DevsLogos:close()
	f5_arg0.FooterContainerFrontendRight:close()
	f5_arg0.PCBnetStoreContainer:close()
end
