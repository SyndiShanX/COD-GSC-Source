require("x64:e7c4814f0e345b8")
require("x64:13d5a17c4f0faca")
CoD.FileshareCategoryContentListMini = InheritFrom(LUI.UIElement)
CoD.FileshareCategoryContentListMini.__defaultWidth = 678
CoD.FileshareCategoryContentListMini.__defaultHeight = 430
CoD.FileshareCategoryContentListMini.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.FileshareCategoryContentListMini)
	self.id = "FileshareCategoryContentListMini"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local MiddleText = LUI.UIText.new(0, 1, 3, -3, 0.5, 0.5, -212.5, -187.5)
	MiddleText:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	MiddleText:setText(LocalizeToUpperString(0xA43B10D9DA121A))
	MiddleText:setTTF("ttmussels_regular")
	MiddleText:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	MiddleText:setLetterSpacing(3)
	MiddleText:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	MiddleText:setAlignment(Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED])
	self:addElement(MiddleText)
	self.MiddleText = MiddleText
	local FileshareSpinner = CoD.FileshareSpinner.new(f1_arg0, f1_arg1, 0.5, 0.5, -48, 48, 0.55, 0.55, -48, 48)
	self:addElement(FileshareSpinner)
	self.FileshareSpinner = FileshareSpinner
	local EmptyText = LUI.UIText.new(0.01, 0.49, 0, 0, 0.5, 0.5, -90, -70)
	EmptyText:setRGB(0.36, 0.35, 0.35)
	EmptyText:setText(Engine[0xF9F1239CFD921FE](0x9E740AD10EEAD80))
	EmptyText:setTTF("ttmussels_regular")
	EmptyText:setAlignment(Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041])
	EmptyText:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(EmptyText)
	self.EmptyText = EmptyText
	local FrameBorder1 = LUI.UIImage.new(0.91, 0.91, -611, -282, 0.29, 0.29, -81, 105)
	FrameBorder1:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	FrameBorder1:setAlpha(0.15)
	FrameBorder1:setImage(RegisterImage(0x185E11D74ECA3D7))
	FrameBorder1:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrameBorder1:setShaderVector(0, 0, 0, 0, 0)
	FrameBorder1:setupNineSliceShader(12, 12)
	self:addElement(FrameBorder1)
	self.FrameBorder1 = FrameBorder1
	local FrameBorder2 = LUI.UIImage.new(0.91, 0.91, -264, 65, 0.29, 0.29, -81, 105)
	FrameBorder2:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	FrameBorder2:setAlpha(0.15)
	FrameBorder2:setImage(RegisterImage(0x185E11D74ECA3D7))
	FrameBorder2:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrameBorder2:setShaderVector(0, 0, 0, 0, 0)
	FrameBorder2:setupNineSliceShader(12, 12)
	self:addElement(FrameBorder2)
	self.FrameBorder2 = FrameBorder2
	local FrameBorder3 = LUI.UIImage.new(0.91, 0.91, -611, -282, 0.29, 0.29, 125, 311)
	FrameBorder3:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	FrameBorder3:setAlpha(0.15)
	FrameBorder3:setImage(RegisterImage(0x185E11D74ECA3D7))
	FrameBorder3:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrameBorder3:setShaderVector(0, 0, 0, 0, 0)
	FrameBorder3:setupNineSliceShader(12, 12)
	self:addElement(FrameBorder3)
	self.FrameBorder3 = FrameBorder3
	local FrameBorder4 = LUI.UIImage.new(0.91, 0.91, -264, 65, 0.29, 0.29, 125, 311)
	FrameBorder4:setRGB(ColorSet.T8__OFF__WHITE.r, ColorSet.T8__OFF__WHITE.g, ColorSet.T8__OFF__WHITE.b)
	FrameBorder4:setAlpha(0.15)
	FrameBorder4:setImage(RegisterImage(0x185E11D74ECA3D7))
	FrameBorder4:setMaterial(LUI.UIImage.GetCachedMaterial(0xFD777557404A7B3))
	FrameBorder4:setShaderVector(0, 0, 0, 0, 0)
	FrameBorder4:setupNineSliceShader(12, 12)
	self:addElement(FrameBorder4)
	self.FrameBorder4 = FrameBorder4
	local contentList = LUI.UIList.new(f1_arg0, f1_arg1, 20, 0, nil, false, false, false, false)
	contentList:setLeftRight(0, 0, 4, 678)
	contentList:setTopBottom(0, 0, 42, 434)
	contentList:setWidgetType(CoD.FileshareSelectorItemWide)
	contentList:setHorizontalCount(2)
	contentList:setVerticalCount(2)
	contentList:setSpacing(20)
	contentList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	contentList:setDataSource("FilesharePublishedList")
	contentList:registerEventHandler("menu_loaded", function(element, event)
		local f2_local0 = nil
		if element.menuLoaded then
			f2_local0 = element:menuLoaded(event)
		elseif element.super.menuLoaded then
			f2_local0 = element.super:menuLoaded(event)
		end
		if FileshareIsCommunityMode(element, f1_arg1) then
		else
		end
		if not f2_local0 then
			f2_local0 = element:dispatchEventToChildren(event)
		end
		return f2_local0
	end)
	contentList:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		if not ListElementHasElements(self.contentList) then
			SetLoseFocusToElement(self, "contentList", f1_arg1)
		else
			CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F])
			CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[0x3DD78803F918E9D][0x22361E23588705A])
		end
		return f3_local0
	end)
	contentList:registerEventHandler("list_item_gain_focus", function(element, event)
		local f4_local0 = nil
		FileshareSetSelectedItem(self, element, f1_arg1, "")
		return f4_local0
	end)
	contentList:registerEventHandler("list_item_lose_focus", function(element, event)
		return nil
	end)
	f1_arg0:AddButtonCallbackFunction(contentList, f1_arg1, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], nil, function(element, menu, controller, model)
		ProcessListAction(self, element, controller, menu)
		return true
	end, function(element, menu, controller)
		CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F], 0xD0BB36CD318F55F, nil, nil)
		return true
	end, false)
	f1_arg0:AddButtonCallbackFunction(contentList, f1_arg1, Enum[0x3DD78803F918E9D][0x22361E23588705A], nil, function(element, menu, controller, model)
		if FileshareCanShowOptionsMenu(controller) then
			PreserveThumbnails(controller, true)
			return true
		else
		end
	end, function(element, menu, controller)
		if FileshareCanShowOptionsMenu(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[0x3DD78803F918E9D][0x22361E23588705A], 0x8E7772DFD9BBDEB, nil, nil)
			return true
		else
			return false
		end
	end, false)
	contentList:subscribeToGlobalModel(f1_arg1, "FileshareRoot", "dirty", function(model)
		UpdateDataSource(self, contentList, f1_arg1)
	end)
	contentList:subscribeToGlobalModel(f1_arg1, "FileshareRoot", "ready", function(model)
		local f11_local0 = contentList
		if FileshareIsReady(f1_arg1) then
			UpdateDataSource(self, f11_local0, f1_arg1)
		end
	end)
	self:addElement(contentList)
	self.contentList = contentList
	self:mergeStateConditions({
		{
			stateName = "Busy",
			condition = function(menu, element, event)
				return not FileshareIsReady(f1_arg1)
			end,
		},
		{
			stateName = "Empty",
			condition = function(menu, element, event)
				local f13_local0 = FileshareIsReady(f1_arg1)
				if f13_local0 then
					if not CoD.ModelUtility.IsGlobalModelValueTrue("fileshareRoot.dirty") then
						f13_local0 = not ListElementHasElements(self.contentList)
					else
						f13_local0 = false
					end
				end
				return f13_local0
			end,
		},
	})
	local f1_local9 = self
	local f1_local10 = self.subscribeToModel
	local f1_local11 = Engine[0x8DF2E5447F384B9]()
	f1_local10(f1_local9, f1_local11["fileshareRoot.ready"], function(f14_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f14_arg0:get(),
			modelName = "fileshareRoot.ready",
		})
	end, false)
	f1_local9 = self
	f1_local10 = self.subscribeToModel
	f1_local11 = Engine[0x8DF2E5447F384B9]()
	f1_local10(f1_local9, f1_local11["fileshareRoot.dirty"], function(f15_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f15_arg0:get(),
			modelName = "fileshareRoot.dirty",
		})
	end, false)
	self:appendEventHandler("grid_updated", function(f16_arg0, f16_arg1)
		f16_arg1.menu = f16_arg1.menu or f1_arg0
		f1_arg0:updateElementState(self, f16_arg1)
	end)
	self:subscribeToGlobalModel(f1_arg1, "FileshareRoot", "itemsCount", function(model)
		local f17_local0 = self
		ShowWidget(self.contentList)
		EnableNavigation(self, "contentList")
	end)
	contentList.id = "contentList"
	self.__defaultFocus = contentList
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.FileshareCategoryContentListMini.__resetProperties = function(f18_arg0)
	f18_arg0.contentList:completeAnimation()
	f18_arg0.FileshareSpinner:completeAnimation()
	f18_arg0.EmptyText:completeAnimation()
	f18_arg0.contentList:setAlpha(1)
	f18_arg0.FileshareSpinner:setAlpha(1)
	f18_arg0.EmptyText:setAlpha(1)
end
CoD.FileshareCategoryContentListMini.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(3)
			f19_arg0.FileshareSpinner:completeAnimation()
			f19_arg0.FileshareSpinner:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.FileshareSpinner)
			f19_arg0.EmptyText:completeAnimation()
			f19_arg0.EmptyText:setAlpha(0)
			f19_arg0.clipFinished(f19_arg0.EmptyText)
			f19_arg0.contentList:completeAnimation()
			f19_arg0.contentList:setAlpha(1)
			f19_arg0.clipFinished(f19_arg0.contentList)
		end,
	},
	Busy = {
		DefaultClip = function(f20_arg0, f20_arg1)
			f20_arg0:__resetProperties()
			f20_arg0:setupElementClipCounter(3)
			f20_arg0.FileshareSpinner:completeAnimation()
			f20_arg0.FileshareSpinner:setAlpha(1)
			f20_arg0.clipFinished(f20_arg0.FileshareSpinner)
			f20_arg0.EmptyText:completeAnimation()
			f20_arg0.EmptyText:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.EmptyText)
			f20_arg0.contentList:completeAnimation()
			f20_arg0.contentList:setAlpha(0)
			f20_arg0.clipFinished(f20_arg0.contentList)
		end,
	},
	Empty = {
		DefaultClip = function(f21_arg0, f21_arg1)
			f21_arg0:__resetProperties()
			f21_arg0:setupElementClipCounter(3)
			f21_arg0.FileshareSpinner:completeAnimation()
			f21_arg0.FileshareSpinner:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.FileshareSpinner)
			f21_arg0.EmptyText:completeAnimation()
			f21_arg0.EmptyText:setAlpha(1)
			f21_arg0.clipFinished(f21_arg0.EmptyText)
			f21_arg0.contentList:completeAnimation()
			f21_arg0.contentList:setAlpha(0)
			f21_arg0.clipFinished(f21_arg0.contentList)
		end,
	},
}
CoD.FileshareCategoryContentListMini.__onClose = function(f22_arg0)
	f22_arg0.FileshareSpinner:close()
	f22_arg0.contentList:close()
end
