require("x64:db806626fb64f10")
require("x64:e78af23a00c327")
CoD.BribeMenu = InheritFrom(CoD.Menu)
LUI.createMenu.BribeMenu = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("BribeMenu", f1_arg0)
	local f1_local1 = self
	self:setClass(CoD.BribeMenu)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local GenericMenuFrameIdentity = CoD.GenericMenuFrameIdentity.new(f1_local1, f1_arg0, 0.5, 0.5, -960, 960, 0, 1, 0, 0)
	GenericMenuFrameIdentity.CommonHeader.subtitle.StageTitle:setText(LocalizeToUpperString(@"menu/bribes"))
	GenericMenuFrameIdentity:subscribeToGlobalModel(f1_arg0, "LobbyRoot", "lobbyTitle", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			GenericMenuFrameIdentity.CommonHeader.subtitle.subtitle:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	self:addElement(GenericMenuFrameIdentity)
	self.GenericMenuFrameIdentity = GenericMenuFrameIdentity
	local BribeList = LUI.UIList.new(f1_local1, f1_arg0, 10, 0, nil, false, false, false, false)
	BribeList:setLeftRight(0, 0, 128.5, 678.5)
	BribeList:setTopBottom(0, 0, 160, 920)
	BribeList:setWidgetType(CoD.BM_Bribe_Widget)
	BribeList:setHorizontalCount(2)
	BribeList:setVerticalCount(5)
	BribeList:setSpacing(10)
	BribeList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	BribeList:setDataSource("BribeListItem")
	BribeList:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f3_local0
	end)
	f1_local1:AddButtonCallbackFunction(BribeList, f1_arg0, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		local f4_local0 = CoD.BlackMarketUtility.TriggerOpenBribeSequence
		local f4_local1 = controller
		local f4_local2 = menu
		local f4_local3 = {}
		local f4_local4 = element:getModel()
		f4_local3.crateType = f4_local4.crateType:get()
		f4_local0(f4_local1, f4_local2, f4_local3)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"hash_9C695BAD15F589A", nil, nil)
		return true
	end, false)
	self:addElement(BribeList)
	self.BribeList = BribeList
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], nil, function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"menu/back", nil, nil)
		return true
	end, false)
	GenericMenuFrameIdentity:setModel(self.buttonModel, f1_arg0)
	GenericMenuFrameIdentity.id = "GenericMenuFrameIdentity"
	BribeList.id = "BribeList"
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
CoD.BribeMenu.__onClose = function(f8_arg0)
	f8_arg0.GenericMenuFrameIdentity:close()
	f8_arg0.BribeList:close()
end
