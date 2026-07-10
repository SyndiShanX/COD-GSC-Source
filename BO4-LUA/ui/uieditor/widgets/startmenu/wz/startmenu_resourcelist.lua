require("x64:1b2a0d6dc1d4f04")
require("x64:bf776923c7291f4")
CoD.StartMenu_ResourceList = InheritFrom(LUI.UIElement)
CoD.StartMenu_ResourceList.__defaultWidth = 220
CoD.StartMenu_ResourceList.__defaultHeight = 144
CoD.StartMenu_ResourceList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.StartMenu_ResourceList)
	self.id = "StartMenu_ResourceList"
	self.soundSet = "none"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local Backing = LUI.UIImage.new(0, 1, 0, 0, -0.02, 0.98, 59, 19)
	Backing:setRGB(0.45, 0.45, 0.45)
	Backing:setAlpha(0)
	self:addElement(Backing)
	self.Backing = Backing
	local HeaderBacking = LUI.UIImage.new(0, 1, 0, 0, 0, 0, 0, 33)
	HeaderBacking:setRGB(0, 0, 0)
	HeaderBacking:setAlpha(0)
	self:addElement(HeaderBacking)
	self.HeaderBacking = HeaderBacking
	local HeaderImage = LUI.UIImage.new(1, 1, -80.5, -16.5, 0, 0, -15.5, 48.5)
	HeaderImage:setAlpha(0)
	HeaderImage:setImage(RegisterImage(0x7615068F50B3D66))
	self:addElement(HeaderImage)
	self.HeaderImage = HeaderImage
	local f1_local4 = nil
	f1_local4 = LUI.UIElement.createFake()
	self.List = f1_local4
	local f1_local5 = nil
	local ListPC = LUI.UIList.new(f1_arg0, f1_arg1, 20, 0, nil, false, false, false, false)
	ListPC:setLeftRight(0, 0, 0, 212)
	ListPC:setTopBottom(0, 0, 37, 133)
	ListPC:setAlpha(0)
	ListPC:setWidgetType(CoD.WarzoneResourceMenuItemSmall)
	ListPC:setHorizontalCount(2)
	ListPC:setSpacing(20)
	ListPC:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	ListPC:setDataSource("WarzoneResources")
	ListPC:subscribeToGlobalModel(f1_arg1, "WarzoneInventoryGlobal", "resourceCount", function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ListPC:setVerticalCount(f2_local0)
		end
	end)
	self:addElement(ListPC)
	self.ListPC = ListPC
	local BottomBracket9Slice = LUI.UIImage.new(0, 0, -1, 220, 0, 0, -2, 7)
	BottomBracket9Slice:setRGB(0.55, 0.54, 0.49)
	BottomBracket9Slice:setZRot(180)
	BottomBracket9Slice:setImage(RegisterImage(0xC325BED3F226657))
	BottomBracket9Slice:setMaterial(LUI.UIImage.GetCachedMaterial(0x44484DDFAF5C093))
	BottomBracket9Slice:setShaderVector(0, 0, 0, 0, 0)
	BottomBracket9Slice:setupNineSliceShader(16, 4)
	self:addElement(BottomBracket9Slice)
	self.BottomBracket9Slice = BottomBracket9Slice
	local Title = LUI.UIText.new(0, 0, 15, 115, 0, 0, 1.5, 23.5)
	Title:setRGB(0, 0, 0)
	Title:setText(LocalizeToUpperString(0xA73F5EE9B97B6BD))
	Title:setTTF("ttmussels_regular")
	Title:setLetterSpacing(4)
	Title:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	Title:setBackingType(1)
	Title:setBackingWidget(CoD.WZBox9Slice, f1_arg0, f1_arg1)
	Title:setBackingColor(0.55, 0.54, 0.49)
	Title:setBackingXPadding(16)
	Title:setBackingYPadding(2)
	self:addElement(Title)
	self.Title = Title
	self:mergeStateConditions({
		{
			stateName = "VisiblePC",
			condition = function(menu, element, event)
				return IsPC() and IsGametypeSettingsValue("wzEnableSprayCans", 1)
			end,
		},
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				return IsGametypeSettingsValue("wzEnableSprayCans", 1)
			end,
		},
	})
	f1_local4.id = "List"
	ListPC.id = "ListPC"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.StartMenu_ResourceList.__resetProperties = function(f5_arg0)
	f5_arg0.List:completeAnimation()
	f5_arg0.HeaderImage:completeAnimation()
	f5_arg0.Title:completeAnimation()
	f5_arg0.HeaderBacking:completeAnimation()
	f5_arg0.Backing:completeAnimation()
	f5_arg0.BottomBracket9Slice:completeAnimation()
	f5_arg0.ListPC:completeAnimation()
	f5_arg0.List:setAlpha(1)
	f5_arg0.HeaderImage:setAlpha(0)
	f5_arg0.Title:setAlpha(1)
	f5_arg0.HeaderBacking:setAlpha(0)
	f5_arg0.Backing:setAlpha(0)
	f5_arg0.BottomBracket9Slice:setLeftRight(0, 0, -1, 220)
	f5_arg0.BottomBracket9Slice:setAlpha(1)
	f5_arg0.ListPC:setAlpha(0)
end
CoD.StartMenu_ResourceList.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f6_arg0, f6_arg1)
			f6_arg0:__resetProperties()
			f6_arg0:setupElementClipCounter(5)
			f6_arg0.Backing:completeAnimation()
			f6_arg0.Backing:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Backing)
			f6_arg0.HeaderBacking:completeAnimation()
			f6_arg0.HeaderBacking:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.HeaderBacking)
			f6_arg0.HeaderImage:completeAnimation()
			f6_arg0.HeaderImage:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.HeaderImage)
			f6_arg0.List:completeAnimation()
			f6_arg0.List:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.List)
			f6_arg0.BottomBracket9Slice:completeAnimation()
			f6_arg0.BottomBracket9Slice:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.BottomBracket9Slice)
			f6_arg0.Title:completeAnimation()
			f6_arg0.Title:setAlpha(0)
			f6_arg0.clipFinished(f6_arg0.Title)
		end,
	},
	VisiblePC = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(2)
			f7_arg0.List:completeAnimation()
			f7_arg0.List:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.List)
			f7_arg0.ListPC:completeAnimation()
			f7_arg0.ListPC:setAlpha(1)
			f7_arg0.clipFinished(f7_arg0.ListPC)
			f7_arg0.BottomBracket9Slice:completeAnimation()
			f7_arg0.BottomBracket9Slice:setLeftRight(0, 0, -1, 206)
			f7_arg0.clipFinished(f7_arg0.BottomBracket9Slice)
		end,
	},
	Visible = {
		DefaultClip = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.StartMenu_ResourceList.__onClose = function(f9_arg0)
	f9_arg0.List:close()
	f9_arg0.ListPC:close()
end
