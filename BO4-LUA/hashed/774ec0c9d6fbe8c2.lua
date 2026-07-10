require("x64:372d1afeb57608e")
CoD.PC_Theater_Keyboard_Shortcut_Legend = InheritFrom(LUI.UIElement)
CoD.PC_Theater_Keyboard_Shortcut_Legend.__defaultWidth = 840
CoD.PC_Theater_Keyboard_Shortcut_Legend.__defaultHeight = 350
CoD.PC_Theater_Keyboard_Shortcut_Legend.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PC_Theater_Keyboard_Shortcut_Legend)
	self.id = "PC_Theater_Keyboard_Shortcut_Legend"
	self.soundSet = "none"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local KeyboardShortcutsList = LUI.UIList.new(f1_arg0, f1_arg1, 0, 0, nil, false, false, false, false)
	KeyboardShortcutsList:setLeftRight(0, 0, 0, 840)
	KeyboardShortcutsList:setTopBottom(0, 0, 0, 350)
	KeyboardShortcutsList:setWidgetType(CoD.PC_Theater_Keyboard_Shortcut_Container)
	KeyboardShortcutsList:setHorizontalCount(3)
	KeyboardShortcutsList:setVerticalCount(7)
	KeyboardShortcutsList:setSpacing(0)
	KeyboardShortcutsList:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	KeyboardShortcutsList:setDataSource("BasicDemoShortcutsKBM")
	self:addElement(KeyboardShortcutsList)
	self.KeyboardShortcutsList = KeyboardShortcutsList
	local ModeTittle = LUI.UIText.new(0, 0, 0, 950, 0, 0, -25, 0)
	ModeTittle:setRGB(ColorSet.T8__BUTTON__UNSELECTED__HEADER.r, ColorSet.T8__BUTTON__UNSELECTED__HEADER.g, ColorSet.T8__BUTTON__UNSELECTED__HEADER.b)
	ModeTittle:setText(LocalizeToUpperString(@"hash_FC244F0B9CC213B"))
	ModeTittle:setTTF("dinnext_regular")
	ModeTittle:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	ModeTittle:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(ModeTittle)
	self.ModeTittle = ModeTittle
	local Title = LUI.UIText.new(0, 0, 0, 950, 0, 0, -60, -25)
	Title:setRGB(ColorSet.T8__OCHRE.r, ColorSet.T8__OCHRE.g, ColorSet.T8__OCHRE.b)
	Title:setText(Engine[@"hash_4F9F1239CFD921FE"](@"hash_693AC596F9C2A96C"))
	Title:setTTF("ttmussels_regular")
	Title:setAlignment(Enum[@"luialignment"][@"lui_alignment_left"])
	Title:setAlignment(Enum[@"luialignment"][@"hash_E821F0ECFF8D1C7"])
	self:addElement(Title)
	self.Title = Title
	self:mergeStateConditions({
		{
			stateName = "BasicMode",
			condition = function(menu, element, event)
				return IsDemoContextBasicMode()
			end,
		},
		{
			stateName = "DirectorMode",
			condition = function(menu, element, event)
				return IsDemoContextDirectorMode()
			end,
		},
		{
			stateName = "ObjectLinkMode",
			condition = function(menu, element, event)
				return IsDemoContextObjectLinkMode()
			end,
		},
		{
			stateName = "LighterMode",
			condition = function(menu, element, event)
				return IsDemoContextLighterMode()
			end,
		},
	})
	local f1_local4 = self
	local f1_local5 = self.subscribeToModel
	local f1_local6 = Engine[@"getglobalmodel"]()
	f1_local5(f1_local4, f1_local6["demo.contextMode"], function(f6_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f6_arg0:get(),
			modelName = "demo.contextMode",
		})
	end, false)
	LUI.OverrideFunction_CallOriginalFirst(self, "setState", function(element, controller, f7_arg2, f7_arg3, f7_arg4)
		UpdateElementDataSource(self, "KeyboardShortcutsList")
	end)
	KeyboardShortcutsList.id = "KeyboardShortcutsList"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.PC_Theater_Keyboard_Shortcut_Legend.__resetProperties = function(f8_arg0)
	f8_arg0.KeyboardShortcutsList:completeAnimation()
	f8_arg0.ModeTittle:completeAnimation()
	f8_arg0.KeyboardShortcutsList:setAlpha(1)
	f8_arg0.ModeTittle:setText(LocalizeToUpperString(@"hash_FC244F0B9CC213B"))
end
CoD.PC_Theater_Keyboard_Shortcut_Legend.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.KeyboardShortcutsList:completeAnimation()
			f9_arg0.KeyboardShortcutsList:setAlpha(0)
			f9_arg0.clipFinished(f9_arg0.KeyboardShortcutsList)
		end,
	},
	BasicMode = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(2)
			f10_arg0.KeyboardShortcutsList:completeAnimation()
			f10_arg0.KeyboardShortcutsList:setAlpha(1)
			f10_arg0.clipFinished(f10_arg0.KeyboardShortcutsList)
			f10_arg0.ModeTittle:completeAnimation()
			f10_arg0.ModeTittle:setText(LocalizeToUpperString(@"hash_42466B35790D15BF"))
			f10_arg0.clipFinished(f10_arg0.ModeTittle)
		end,
	},
	DirectorMode = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(1)
			f11_arg0.KeyboardShortcutsList:completeAnimation()
			f11_arg0.KeyboardShortcutsList:setAlpha(1)
			f11_arg0.clipFinished(f11_arg0.KeyboardShortcutsList)
		end,
	},
	ObjectLinkMode = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.KeyboardShortcutsList:completeAnimation()
			f12_arg0.KeyboardShortcutsList:setAlpha(1)
			f12_arg0.clipFinished(f12_arg0.KeyboardShortcutsList)
			f12_arg0.ModeTittle:completeAnimation()
			f12_arg0.ModeTittle:setText(LocalizeToUpperString(@"hash_72961AAF61FB5B21"))
			f12_arg0.clipFinished(f12_arg0.ModeTittle)
		end,
	},
	LighterMode = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(2)
			f13_arg0.KeyboardShortcutsList:completeAnimation()
			f13_arg0.KeyboardShortcutsList:setAlpha(1)
			f13_arg0.clipFinished(f13_arg0.KeyboardShortcutsList)
			f13_arg0.ModeTittle:completeAnimation()
			f13_arg0.ModeTittle:setText(LocalizeToUpperString(@"hash_7EBDDCC281D5C214"))
			f13_arg0.clipFinished(f13_arg0.ModeTittle)
		end,
	},
}
CoD.PC_Theater_Keyboard_Shortcut_Legend.__onClose = function(f14_arg0)
	f14_arg0.KeyboardShortcutsList:close()
end
