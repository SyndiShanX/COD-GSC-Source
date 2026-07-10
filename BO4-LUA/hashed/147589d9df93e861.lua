require("x64:1b66f971ffa1f09")
require("x64:19c1945d2e472b0")
require("x64:63355d9a3377f1d")
CoD.SpecialistBio = InheritFrom(CoD.Menu)
LUI.createMenu.SpecialistBio = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("SpecialistBio", f1_arg0)
	local f1_local1 = self
	CoD.BaseUtility.SetPropertiesFromUserData(self, f1_arg1)
	MenuHidesFreeCursor(f1_local1, f1_arg0)
	self:setClass(CoD.SpecialistBio)
	self.soundSet = "MultiplayerMain"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	f1_local1:addElementToPendingUpdateStateList(self)
	local CommomCenteredPopup = CoD.CommonCenteredPopup.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	CommomCenteredPopup.TitleText:setText("")
	CommomCenteredPopup.HeaderBackground:setAlpha(0)
	CommomCenteredPopup.HeaderTopBar:setAlpha(0)
	CommomCenteredPopup.HeaderBottomBar:setAlpha(0)
	self:addElement(CommomCenteredPopup)
	self.CommomCenteredPopup = CommomCenteredPopup
	local Image = LUI.UIImage.new(0.5, 0.5, -271.5, 271.5, 0.5, 0.5, -423, -231)
	Image:subscribeToGlobalModel(f1_arg0, "SpecialistHeadquarters", "ChosenSpecialistID", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			Image:setImage(RegisterImage(CoD.CTUtility.PlayerRoleIndexToBioHeaderImage(f2_local0)))
		end
	end)
	self:addElement(Image)
	self.Image = Image
	local DescBacking = CoD.StoreCommonTextBacking.new(f1_local1, f1_arg0, 0.5, 0.5, -271.5, 271.5, 0.5, 0.5, -49, 341)
	DescBacking:setAlpha(0.4)
	DescBacking.TiledShaderImage:setupNineSliceShader(42, 42)
	self:addElement(DescBacking)
	self.DescBacking = DescBacking
	local SpecialistName = LUI.UIText.new(0.5, 0.5, -271.5, 271.5, 0.5, 0.5, -224, -134)
	SpecialistName:setRGB(0.92, 0.89, 0.72)
	SpecialistName:setAlpha(0.7)
	SpecialistName:setZoom(3)
	SpecialistName:setTTF("ttmussels_regular")
	SpecialistName:setLetterSpacing(10)
	SpecialistName:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	SpecialistName:subscribeToGlobalModel(f1_arg0, "SpecialistHeadquarters", "ChosenSpecialistID", function(model)
		local f3_local0 = model:get()
		if f3_local0 ~= nil then
			SpecialistName:setText(LocalizeToUpperString(CoD.CTUtility.PlayerRoleIndexToName(f3_local0)))
		end
	end)
	self:addElement(SpecialistName)
	self.SpecialistName = SpecialistName
	local BioHeader = LUI.UIText.new(0.5, 0.5, -271.5, 271.5, 0.5, 0.5, -83, -59)
	BioHeader:setRGB(0.92, 0.92, 0.92)
	BioHeader:setText(LocalizeToUpperString(@"hash_2BECB6115D1FE883"))
	BioHeader:setTTF("ttmussels_regular")
	BioHeader:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	BioHeader:setAlignment(Enum[@"luialignment"][@"lui_alignment_top"])
	self:addElement(BioHeader)
	self.BioHeader = BioHeader
	local Bio = CoD.verticalScrollingTextBox.new(f1_local1, f1_arg0, 0.5, 0.5, -262, 270, 0.5, 0.5, -31, 324)
	Bio:subscribeToGlobalModel(f1_arg0, "SpecialistDossier", "bioFull", function(model)
		local f4_local0 = model:get()
		if f4_local0 ~= nil then
			Bio.textBox.text:setText(Engine[@"hash_4F9F1239CFD921FE"](f4_local0))
		end
	end)
	self:addElement(Bio)
	self.Bio = Bio
	local DescBackingTopBar = LUI.UIImage.new(0.5, 0.5, -4, 0, 0.5, 0.5, -320.5, 222.5)
	DescBackingTopBar:setAlpha(0.09)
	DescBackingTopBar:setZRot(90)
	DescBackingTopBar:setImage(RegisterImage(@"hash_C49B0C8991A541F"))
	DescBackingTopBar:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	DescBackingTopBar:setShaderVector(0, 0, 0, 0, 0)
	DescBackingTopBar:setupNineSliceShader(4, 8)
	self:addElement(DescBackingTopBar)
	self.DescBackingTopBar = DescBackingTopBar
	local DescBackingBottomBar = LUI.UIImage.new(0.5, 0.5, -4, 0, 0.5, 0.5, 69.5, 612.5)
	DescBackingBottomBar:setAlpha(0.09)
	DescBackingBottomBar:setZRot(90)
	DescBackingBottomBar:setImage(RegisterImage(@"hash_C49B0C8991A541F"))
	DescBackingBottomBar:setMaterial(LUI.UIImage.GetCachedMaterial(@"hash_67C9C02F608D0A75"))
	DescBackingBottomBar:setShaderVector(0, 0, 0, 0, 0)
	DescBackingBottomBar:setupNineSliceShader(4, 8)
	self:addElement(DescBackingBottomBar)
	self.DescBackingBottomBar = DescBackingBottomBar
	self:mergeStateConditions({
		{
			stateName = "PC",
			condition = function(menu, element, event)
				return IsPC()
			end,
		},
	})
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], "ESCAPE", function(element, menu, controller, model)
		GoBack(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xbb_pscircle"], @"mp/back", nil, "ESCAPE")
		return true
	end, false)
	CommomCenteredPopup.buttons:setModel(self.buttonModel, f1_arg0)
	if CoD.isPC then
		CommomCenteredPopup.id = "CommomCenteredPopup"
	end
	self:processEvent({
		name = "menu_loaded",
		controller = f1_arg0,
	})
	self.__defaultFocus = CommomCenteredPopup
	if CoD.isPC and (IsKeyboard(f1_arg0) or self.ignoreCursor) then
		self:restoreState(f1_arg0)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg0)
	end
	return self
end
CoD.SpecialistBio.__resetProperties = function(f8_arg0)
	f8_arg0.BioHeader:completeAnimation()
	f8_arg0.DescBacking:completeAnimation()
	f8_arg0.Bio:completeAnimation()
	f8_arg0.DescBackingTopBar:completeAnimation()
	f8_arg0.BioHeader:setTopBottom(0.5, 0.5, -83, -59)
	f8_arg0.DescBacking:setTopBottom(0.5, 0.5, -49, 341)
	f8_arg0.Bio:setTopBottom(0.5, 0.5, -31, 324)
	f8_arg0.DescBackingTopBar:setTopBottom(0.5, 0.5, -320.5, 222.5)
end
CoD.SpecialistBio.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(0)
		end,
	},
	PC = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(4)
			f10_arg0.DescBacking:completeAnimation()
			f10_arg0.DescBacking:setTopBottom(0.5, 0.5, -90, 341)
			f10_arg0.clipFinished(f10_arg0.DescBacking)
			f10_arg0.BioHeader:completeAnimation()
			f10_arg0.BioHeader:setTopBottom(0.5, 0.5, -123, -99)
			f10_arg0.clipFinished(f10_arg0.BioHeader)
			f10_arg0.Bio:completeAnimation()
			f10_arg0.Bio:setTopBottom(0.5, 0.5, -84, 330)
			f10_arg0.clipFinished(f10_arg0.Bio)
			f10_arg0.DescBackingTopBar:completeAnimation()
			f10_arg0.DescBackingTopBar:setTopBottom(0.5, 0.5, -361.5, 181.5)
			f10_arg0.clipFinished(f10_arg0.DescBackingTopBar)
		end,
	},
}
CoD.SpecialistBio.__onClose = function(f11_arg0)
	f11_arg0.CommomCenteredPopup:close()
	f11_arg0.Image:close()
	f11_arg0.DescBacking:close()
	f11_arg0.SpecialistName:close()
	f11_arg0.Bio:close()
end
