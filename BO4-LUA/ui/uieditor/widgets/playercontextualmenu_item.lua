CoD.PlayerContextualMenu_Item = InheritFrom(LUI.UIElement)
CoD.PlayerContextualMenu_Item.__defaultWidth = 200
CoD.PlayerContextualMenu_Item.__defaultHeight = 24
CoD.PlayerContextualMenu_Item.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.PlayerContextualMenu_Item)
	self.id = "PlayerContextualMenu_Item"
	self.soundSet = "none"
	f1_arg0:addElementToPendingUpdateStateList(self)
	local ActionName = LUI.UIText.new(0, 0, 0, 160, 0, 0, 0, 25)
	ActionName:setTTF("default")
	ActionName:setAlignment(Enum.LUIAlignment[@"lui_alignment_left"])
	ActionName:linkToElementModel(self, "name", true, function(model)
		local f2_local0 = model:get()
		if f2_local0 ~= nil then
			ActionName:setText(Engine[@"hash_4F9F1239CFD921FE"](f2_local0))
		end
	end)
	LUI.OverrideFunction_CallOriginalFirst(ActionName, "setText", function(element, controller)
		ScaleWidgetToLabel(self, element, 2)
	end)
	self:addElement(ActionName)
	self.ActionName = ActionName
	self.__on_menuOpened_self = function(f4_arg0, f4_arg1, f4_arg2, f4_arg3)
		local f4_local0 = self
		SetStateByElementModel(self, self, f4_arg1, "enabled")
	end
	f1_arg0:addMenuOpenedCallback(self.__on_menuOpened_self)
	self.__on_close_removeOverrides = function()
		f1_arg0:removeMenuOpenedCallback(self.__on_menuOpened_self)
	end
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	local f1_local2 = self
	EnableMouseButton(self, f1_arg1)
	CoD.PCWidgetUtility.SetupPlayerContextualMenuItem(self, f1_arg1)
	CoD.PCUtility.SetForceMouseEventDispatch(self, true)
	return self
end
CoD.PlayerContextualMenu_Item.__resetProperties = function(f6_arg0)
	f6_arg0.ActionName:completeAnimation()
	f6_arg0.ActionName:setRGB(1, 1, 1)
end
CoD.PlayerContextualMenu_Item.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f7_arg0, f7_arg1)
			f7_arg0:__resetProperties()
			f7_arg0:setupElementClipCounter(0)
		end,
		Over = function(f8_arg0, f8_arg1)
			f8_arg0:__resetProperties()
			f8_arg0:setupElementClipCounter(1)
			f8_arg0.ActionName:completeAnimation()
			f8_arg0.ActionName:setRGB(0.87, 0.05, 0.05)
			f8_arg0.clipFinished(f8_arg0.ActionName)
		end,
		Focus = function(f9_arg0, f9_arg1)
			f9_arg0:__resetProperties()
			f9_arg0:setupElementClipCounter(1)
			f9_arg0.ActionName:completeAnimation()
			f9_arg0.ActionName:setRGB(0.87, 0.05, 0.05)
			f9_arg0.clipFinished(f9_arg0.ActionName)
		end,
	},
	Disabled = {
		DefaultClip = function(f10_arg0, f10_arg1)
			f10_arg0:__resetProperties()
			f10_arg0:setupElementClipCounter(1)
			f10_arg0.ActionName:completeAnimation()
			f10_arg0.ActionName:setRGB(0.43, 0.43, 0.43)
			f10_arg0.clipFinished(f10_arg0.ActionName)
		end,
	},
}
CoD.PlayerContextualMenu_Item.__onClose = function(f11_arg0)
	f11_arg0.__on_close_removeOverrides()
	f11_arg0.ActionName:close()
end
