require("x64:49ac2183ff0bf98")
require("x64:90d35a4c67e29f1")
require("x64:7e6d4ee936eb3e8")
require("x64:e75077bbac65e75")
require("x64:6180207311bd274")
CoD.SwipeTak5_Internal = InheritFrom(LUI.UIElement)
CoD.SwipeTak5_Internal.__defaultWidth = 750
CoD.SwipeTak5_Internal.__defaultHeight = 450
CoD.SwipeTak5_Internal.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.SwipeTak5_Internal)
	self.id = "SwipeTak5_Internal"
	self.soundSet = "none"
	Engine[0xF0AF2C4A29D15D7](f1_arg1, 3, 750, 450)
	self:setUI3DWindow(3)
	self.anyChildUsesUpdateState = true
	local background = LUI.UIImage.new(0.5, 1.5, -375, -375, 0.5, 1.5, -225, -225)
	background:setRGB(0, 0, 0)
	background:setAlpha(0.75)
	self:addElement(background)
	self.background = background
	local BgGridDark = LUI.UIImage.new(0, 0, -2.5, 753.5, 0, 0, -1.5, 454.5)
	BgGridDark:setRGB(0.09, 0.09, 0.09)
	BgGridDark:setAlpha(0.4)
	BgGridDark:setImage(RegisterImage(0x632CC0A04FE04A1))
	BgGridDark:setMaterial(LUI.UIImage.GetCachedMaterial(0xF755127C95CF5B6))
	BgGridDark:setShaderVector(0, 1, 0, 0, 0)
	self:addElement(BgGridDark)
	self.BgGridDark = BgGridDark
	local BgGrid = LUI.UIImage.new(0, 0, -3, 753, 0, 0, -3, 453)
	BgGrid:setAlpha(0.5)
	BgGrid:setImage(RegisterImage(0x632CC0A04FE04A1))
	BgGrid:setMaterial(LUI.UIImage.GetCachedMaterial(0x1CC85D0A86303B0))
	BgGrid:setShaderVector(0, 2, 0, 0, 0)
	self:addElement(BgGrid)
	self.BgGrid = BgGrid
	local GridPlus = CoD.SwipeTak5_LayoutPlusGrid.new(f1_arg0, f1_arg1, 0, 0, 109.5, 639.5, 0, 0, 63.5, 385.5)
	self:addElement(GridPlus)
	self.GridPlus = GridPlus
	local GridPlus2 = CoD.SwipeTak5_LayoutPlusGrid.new(f1_arg0, f1_arg1, 0, 0, 109.5, 639.5, 0, 0, 63.5, 385.5)
	self:addElement(GridPlus2)
	self.GridPlus2 = GridPlus2
	local PlayerGrid = LUI.GridLayout.new(f1_arg0, f1_arg1, false, 0, 0, -30, 0, nil, nil, false, false, false, false)
	PlayerGrid:setLeftRight(0, 0, 0, 750)
	PlayerGrid:setTopBottom(0, 0, 50, 450)
	PlayerGrid:setWidgetType(CoD.SwipeTak5_CharacterHealWidget)
	PlayerGrid:setHorizontalCount(6)
	PlayerGrid:setSpacing(-30)
	PlayerGrid:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	PlayerGrid:setDataSource("HealthBoostPlayerList")
	self:addElement(PlayerGrid)
	self.PlayerGrid = PlayerGrid
	local ConfirmButton = CoD.SwipeTak5_ConfirmButton.new(f1_arg0, f1_arg1, 0.5, 0.5, -150, 150, 1, 1, -117, -17)
	self:addElement(ConfirmButton)
	self.ConfirmButton = ConfirmButton
	local TabletTak5ConnectionText = CoD.TabletTak5_ConnectionText.new(f1_arg0, f1_arg1, 0, 0, 295, 455, 0, 0, 14, 44)
	self:addElement(TabletTak5ConnectionText)
	self.TabletTak5ConnectionText = TabletTak5ConnectionText
	local LayoutElements = CoD.SwipeTak5_LayoutElements.new(f1_arg0, f1_arg1, 0, 0, 4, 746, 0, 0, 1.5, 447.5)
	self:addElement(LayoutElements)
	self.LayoutElements = LayoutElements
	PlayerGrid.id = "PlayerGrid"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.SwipeTak5_Internal.__onClose = function(f2_arg0)
	f2_arg0.GridPlus:close()
	f2_arg0.GridPlus2:close()
	f2_arg0.PlayerGrid:close()
	f2_arg0.ConfirmButton:close()
	f2_arg0.TabletTak5ConnectionText:close()
	f2_arg0.LayoutElements:close()
end
