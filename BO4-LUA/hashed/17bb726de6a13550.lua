require("x64:dec4adeaa0cc751")
require("x64:74864184d366296")
require("x64:a24b28b508f6914")
require("x64:3dd43113c4e1bd6")
require("x64:f027dcc6409e42c")
CoD.FTUEGameIntroduction = InheritFrom(CoD.Menu)
LUI.createMenu.FTUEGameIntroduction = function(f1_arg0, f1_arg1)
	local self = CoD.Menu.NewForUIEditor("FTUEGameIntroduction", f1_arg0)
	local f1_local1 = self
	CoD.FTUEUtility.SetCurrentSequence(self, f1_arg0, "GameIntroduction")
	EnableAnyController(self, f1_arg0)
	self:setClass(CoD.FTUEGameIntroduction)
	self.soundSet = "none"
	self:setOwner(f1_arg0)
	self:setLeftRight(0, 1, 0, 0)
	self:setTopBottom(0, 1, 0, 0)
	self:playSound("menu_open", f1_arg0)
	self.anyChildUsesUpdateState = true
	local StartMenuBackground = CoD.StartMenu_Background.new(f1_local1, f1_arg0, 0, 1, 0, 0, 0, 1, 0, 0)
	StartMenuBackground:setAlpha(0)
	self:addElement(StartMenuBackground)
	self.StartMenuBackground = StartMenuBackground
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
	local f1_local5 = nil
	f1_local5 = LUI.UIElement.createFake()
	self.FooterContainerFrontendRight = f1_local5
	local Title = LUI.UIText.new(0.5, 0.5, -734.5, 546.5, 0, 0, 102, 167)
	Title:setRGB(ColorSet.GroupName.r, ColorSet.GroupName.g, ColorSet.GroupName.b)
	Title:setText(Engine[0xF9F1239CFD921FE](0x9413BCBC84F738A))
	Title:setTTF("ttmussels_regular")
	Title:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0x58C8A85F2048829]))
	Title:setAlignment(Engine[0x7F8853DC3581AA4](Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3]))
	self:addElement(Title)
	self.Title = Title
	local List = LUI.UIList.new(f1_local1, f1_arg0, 90, 0, nil, false, false, false, false)
	List:setLeftRight(0.5, 0.5, -734.5, 719.5)
	List:setTopBottom(0, 0, 202, 626)
	List:setWidgetType(CoD.FTUEGameIntroductionInfo)
	List:setHorizontalCount(4)
	List:setSpacing(90)
	List:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	List:setDataSource("FTUEEntries")
	self:addElement(List)
	self.List = List
	local PCMOTDButtons = nil
	PCMOTDButtons = CoD.PC_MOTD_Buttons.new(f1_local1, f1_arg0, 0.5, 0.5, -734.5, -494.5, 0.8, 0.8, 48.5, 126.5)
	PCMOTDButtons.OptionText:setText(LocalizeToUpperString(0x6393FF34EA56966))
	PCMOTDButtons:linkToElementModel(self, "image", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			PCMOTDButtons.Icon:setImage(RegisterImage(f2_local0))
		end
	end)
	PCMOTDButtons:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_local1, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
		return f3_local0
	end)
	f1_local1:AddButtonCallbackFunction(PCMOTDButtons, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "ui_confirm", function(element, menu, controller, model)
		CoD.FTUEUtility.AdvanceCurrentSequence(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x0, nil, "ui_confirm")
		return false
	end, false)
	self:addElement(PCMOTDButtons)
	self.PCMOTDButtons = PCMOTDButtons
	local BoxHighlighted = CoD.CommonBgLayoutElement03.new(f1_local1, f1_arg0, 0.5, 0.5, -810.5, -734.5, 0, 0, 84.5, 464.5)
	BoxHighlighted:setScale(0.4, 0.4)
	self:addElement(BoxHighlighted)
	self.BoxHighlighted = BoxHighlighted
	local CornerPip = LUI.UIImage.new(0.5, 0.5, -779, -756, 0, 0, 173, 196)
	CornerPip:setAlpha(0.25)
	CornerPip:setImage(RegisterImage(0x8DC834094E7A02C))
	self:addElement(CornerPip)
	self.CornerPip = CornerPip
	local CornerPip2 = LUI.UIImage.new(0.5, 0.5, -779, -756, 0, 0, 893.5, 916.5)
	CornerPip2:setAlpha(0.25)
	CornerPip2:setZRot(90)
	CornerPip2:setImage(RegisterImage(0x8DC834094E7A02C))
	self:addElement(CornerPip2)
	self.CornerPip2 = CornerPip2
	local CornerPip3 = LUI.UIImage.new(0.5, 0.5, 739, 762, 0, 0, 893.5, 916.5)
	CornerPip3:setAlpha(0.25)
	CornerPip3:setZRot(180)
	CornerPip3:setImage(RegisterImage(0x8DC834094E7A02C))
	self:addElement(CornerPip3)
	self.CornerPip3 = CornerPip3
	local CornerPip4 = LUI.UIImage.new(0.5, 0.5, 739, 762, 0, 0, 173, 196)
	CornerPip4:setAlpha(0.25)
	CornerPip4:setZRot(270)
	CornerPip4:setImage(RegisterImage(0x8DC834094E7A02C))
	self:addElement(CornerPip4)
	self.CornerPip4 = CornerPip4
	local dotline = LUI.UIImage.new(0.5, 0.5, -734.5, 719.5, 0, 0, 895.5, 899.5)
	dotline:setAlpha(0.25)
	dotline:setImage(RegisterImage(0xF9C7F41C631866E))
	dotline:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	dotline:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(dotline)
	self.dotline = dotline
	local dotline2 = LUI.UIImage.new(0.5, 0.5, -734.5, 719.5, 0, 0, 192, 196)
	dotline2:setAlpha(0.25)
	dotline2:setImage(RegisterImage(0xF9C7F41C631866E))
	dotline2:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	dotline2:setShaderVector(0, 1.2, 0, 0, 0)
	self:addElement(dotline2)
	self.dotline2 = dotline2
	local TabbedScoreboardFuiBox = CoD.TabbedScoreboardFuiBox.new(f1_local1, f1_arg0, 0, 0, 1581.5, 1679.5, 0, 0, 178.5, 190.5)
	self:addElement(TabbedScoreboardFuiBox)
	self.TabbedScoreboardFuiBox = TabbedScoreboardFuiBox
	f1_local1:AddButtonCallbackFunction(self, f1_arg0, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], "MOUSE1", function(element, menu, controller, model)
		CoD.FTUEUtility.AdvanceCurrentSequence(self, controller)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0x6393FF34EA56966, nil, "MOUSE1")
		return true
	end, false)
	f1_local5:setModel(self.buttonModel, f1_arg0)
	List.id = "List"
	if CoD.isPC then
		PCMOTDButtons.id = "PCMOTDButtons"
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
CoD.FTUEGameIntroduction.__onClose = function(f8_arg0)
	f8_arg0.StartMenuBackground:close()
	f8_arg0.FooterContainerFrontendRight:close()
	f8_arg0.List:close()
	f8_arg0.PCMOTDButtons:close()
	f8_arg0.BoxHighlighted:close()
	f8_arg0.TabbedScoreboardFuiBox:close()
end
