require("x64:52a3feb9a90b658")
CoD.PC_HUD_FastLoadoutContainer_TinyLoadoutList = InheritFrom(LUI.UIElement)
CoD.PC_HUD_FastLoadoutContainer_TinyLoadoutList.__defaultWidth = 380
CoD.PC_HUD_FastLoadoutContainer_TinyLoadoutList.__defaultHeight = 100
CoD.PC_HUD_FastLoadoutContainer_TinyLoadoutList.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_HUD_FastLoadoutContainer_TinyLoadoutList)
	self.id = "PC_HUD_FastLoadoutContainer_TinyLoadoutList"
	self.soundSet = "none"
	self.onlyChildrenFocusable = CoD.isPC
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local customClasssList = LUI.UIList.new(f1_arg0, f1_arg1, -4, 0, nil, false, false, false, false)
	customClasssList:mergeStateConditions({
		{
			stateName = "Equipped",
			condition = function(menu, element, event)
				return CoD.CACUtility.IsLoadoutEquipped(menu, element, f1_arg1)
			end,
		},
		{
			stateName = "Locked",
			condition = function(menu, element, event)
				return CoD.CACUtility.IsLoadoutLocked(menu, element, f1_arg1)
			end,
		},
	})
	local f1_local2 = customClasssList
	local TextBox = customClasssList.subscribeToModel
	local f1_local4 = Engine[0x4DF5CFBC1771947](f1_arg1)
	TextBox(f1_local2, f1_local4.selectedCustomClass, function(f4_arg0)
		f1_arg0:updateElementState(customClasssList, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "selectedCustomClass",
		})
	end, false)
	customClasssList:setLeftRight(0.5, 0.5, -46, 270)
	customClasssList:setTopBottom(0.5, 0.5, -54, 54)
	customClasssList:setAlpha(0)
	customClasssList:setScale(0.5, 0.5)
	customClasssList:setWidgetType(CoD.CustomClassListButtonInGame)
	customClasssList:setHorizontalCount(6)
	customClasssList:setVerticalCount(2)
	customClasssList:setSpacing(-4)
	customClasssList:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	customClasssList:setDataSource("ChooseClass_TinyLoadout")
	self:addElement(customClasssList)
	self.customClasssList = customClasssList
	TextBox = LUI.UIText.new(0, 0, -184, 179, 0.5, 0.5, -10.5, 10.5)
	TextBox:setAlpha(0)
	TextBox:setTTF("ttmussels_regular")
	TextBox:setMaterial(LUI.UIImage.GetCachedMaterial(0x71E049B161CD00A))
	TextBox:setLetterSpacing(2)
	TextBox:setAlignment(Enum[0x7A5123B654282D2][0x830CFD395E6AA0A])
	TextBox:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	self:addElement(TextBox)
	self.TextBox = TextBox
	TextBox:linkToElementModel(customClasssList, "customClassName", true, function(model)
		local f5_local0 = model:get()
		if f5_local0 ~= nil then
			TextBox:setText(f5_local0)
		end
	end)
	customClasssList.id = "customClasssList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	f1_local2 = self
	CoD.PCWidgetUtility.PrepareFastLoadoutTinyNumbersList(self, f1_arg1, f1_arg0, self.customClasssList)
	return self
end
CoD.PC_HUD_FastLoadoutContainer_TinyLoadoutList.__resetProperties = function(f6_arg0)
	f6_arg0.TextBox:completeAnimation()
	f6_arg0.customClasssList:completeAnimation()
	f6_arg0.TextBox:setAlpha(0)
	f6_arg0.customClasssList:setAlpha(0)
end
CoD.PC_HUD_FastLoadoutContainer_TinyLoadoutList.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(1)
			f7_arg0.TextBox:completeAnimation()
			f7_arg0.TextBox:setAlpha(0)
			f7_arg0.clipFinished(f7_arg0.TextBox)
		end,
		OpenFastLoadout = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(2)
			local f8_local0 = function(f9_arg0)
				f8_arg0.customClasssList:beginAnimation(150)
				f8_arg0.customClasssList:setAlpha(1)
				f8_arg0.customClasssList:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.customClasssList:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.customClasssList:completeAnimation()
			f8_arg0.customClasssList:setAlpha(0)
			f8_local0(f8_arg0.customClasssList)
			local f8_local1 = function(f10_arg0)
				f8_arg0.TextBox:beginAnimation(150)
				f8_arg0.TextBox:setAlpha(1)
				f8_arg0.TextBox:registerEventHandler("interrupted_keyframe", f8_arg0.clipInterrupted)
				f8_arg0.TextBox:registerEventHandler("transition_complete_keyframe", f8_arg0.clipFinished)
			end
			f8_arg0.TextBox:completeAnimation()
			f8_arg0.TextBox:setAlpha(0)
			f8_local1(f8_arg0.TextBox)
		end,
		CloseFastLoadout = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			local f11_local0 = function(f12_arg0)
				f11_arg0.customClasssList:beginAnimation(810)
				f11_arg0.customClasssList:setAlpha(0)
				f11_arg0.customClasssList:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.customClasssList:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.customClasssList:completeAnimation()
			f11_arg0.customClasssList:setAlpha(1)
			f11_local0(f11_arg0.customClasssList)
			local f11_local1 = function(f13_arg0)
				f11_arg0.TextBox:beginAnimation(810)
				f11_arg0.TextBox:setAlpha(0)
				f11_arg0.TextBox:registerEventHandler("interrupted_keyframe", f11_arg0.clipInterrupted)
				f11_arg0.TextBox:registerEventHandler("transition_complete_keyframe", f11_arg0.clipFinished)
			end
			f11_arg0.TextBox:completeAnimation()
			f11_arg0.TextBox:setAlpha(1)
			f11_local1(f11_arg0.TextBox)
		end,
	},
}
CoD.PC_HUD_FastLoadoutContainer_TinyLoadoutList.__onClose = function(f14_arg0)
	f14_arg0.TextBox:close()
	f14_arg0.customClasssList:close()
end
