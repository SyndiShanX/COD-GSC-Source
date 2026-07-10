require("x64:e3be79df0c2cf28")
CoD.ReservesPromoImagePopup = InheritFrom(CoD.Menu)
LUI.createMenu.ReservesPromoImagePopup = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("ReservesPromoImagePopup", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.ReservesPromoImagePopup)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local f1_local2 = nil
	self.background = LUI.UIElement.createFake()
	local PromoImage = LUI.UIImage.new(0, 1, 0, 0, 0, 1, 0, 0)
	PromoImage:subscribeToGlobalModel(f1_arg0, "ReservesPromoPopup", "image", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PromoImage:setImage(RegisterImage(f2_local0))
		end
	end)
	self:addElement(PromoImage)
	self.PromoImage = PromoImage
	local LiveEventViewerFooterContainer0 = CoD.VoDViewerFooterContainer.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0.5, 1.5, -540, -540)
	self:addElement(LiveEventViewerFooterContainer0)
	self.LiveEventViewerFooterContainer0 = LiveEventViewerFooterContainer0
	local PromoTitle = LUI.UIText.new(0.5, 0.5, -815.5, 815.5, 0, 0, 86.5, 158.5)
	PromoTitle:setTTF("ttmussels_demibold")
	PromoTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PromoTitle:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	PromoTitle:subscribeToGlobalModel(f1_arg0, "ReservesPromoPopup", "title", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			PromoTitle:setText(LocalizeToUpperString(f3_local0))
		end
	end)
	self:addElement(PromoTitle)
	self.PromoTitle = PromoTitle
	local PromoDesc = LUI.UIText.new(0.5, 0.5, -815.5, 815.5, 0, 0, 158.5, 188.5)
	PromoDesc:setTTF("ttmussels_regular")
	PromoDesc:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	PromoDesc:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	PromoDesc:subscribeToGlobalModel(f1_arg0, "ReservesPromoPopup", "desc", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			PromoDesc:setText(Engine[@"hash_4F9F1239CFD921FE"](f4_local0))
		end
	end)
	self:addElement(PromoDesc)
	self.PromoDesc = PromoDesc
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/close", nil, nil)
		return true
	end, false)
	LiveEventViewerFooterContainer0:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		LiveEventViewerFooterContainer0.id = "LiveEventViewerFooterContainer0"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	local f1_local7 = self
	if IsPC() then
		SizeToWidthOfScreen(f1_local7, f1_arg0)
	end
	return self
end
CoD.ReservesPromoImagePopup.__onClose = function(f7_arg0)
	f7_arg0.PromoImage:close()
	f7_arg0.LiveEventViewerFooterContainer0:close()
	f7_arg0.PromoTitle:close()
	f7_arg0.PromoDesc:close()
end
