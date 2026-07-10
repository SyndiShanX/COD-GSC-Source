require("x64:f6482b855bfca9f")
CoD.WeaponPersonalizationTextBreadcrumb = InheritFrom(LUI.UIElement)
CoD.WeaponPersonalizationTextBreadcrumb.__defaultWidth = 350
CoD.WeaponPersonalizationTextBreadcrumb.__defaultHeight = 45
CoD.WeaponPersonalizationTextBreadcrumb.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	self:setClass(CoD.WeaponPersonalizationTextBreadcrumb)
	self.id = "WeaponPersonalizationTextBreadcrumb"
	self.soundSet = "FrontendMain"
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local textCenterAlign = LUI.UIText.new(-0.02, 0.98, 6, -6, 0.5, 0.5, -10, 10)
	textCenterAlign:setRGB(0.8, 0.79, 0.78)
	textCenterAlign:setText("")
	textCenterAlign:setTTF("dinnext_regular")
	textCenterAlign:setAlignment(Enum[0x7A5123B654282D2][0x58C8A85F2048829])
	textCenterAlign:setAlignment(Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3])
	textCenterAlign:setBackingType(1)
	textCenterAlign:setBackingXPadding(15)
	textCenterAlign:setBackingYPadding(7)
	self:addElement(textCenterAlign)
	self.textCenterAlign = textCenterAlign
	local Breadcrumb = CoD.NewBreadcrumb.new(f1_arg0, f1_arg1, 0, 0, 314, 344, 0, 0, 7.5, 37.5)
	Breadcrumb:mergeStateConditions({
		{
			stateName = "Visible",
			condition = function(menu, element, event)
				local f2_local0 = IsLive()
				if f2_local0 then
					if not IsInGame() then
						f2_local0 = CoD.ModelUtility.IsSelfModelValueGreaterThan(element, f1_arg1, "breadcrumbCount", 0)
					else
						f2_local0 = false
					end
				end
				return f2_local0
			end,
		},
	})
	local f1_local3 = Breadcrumb
	local f1_local4 = Breadcrumb.subscribeToModel
	local f1_local5 = Engine[0x8DF2E5447F384B9]()
	f1_local4(f1_local3, f1_local5["lobbyRoot.lobbyNetworkMode"], function(f3_arg0)
		f1_arg0:updateElementState(Breadcrumb, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f3_arg0:get(),
			modelName = "lobbyRoot.lobbyNetworkMode",
		})
	end, false)
	f1_local3 = Breadcrumb
	f1_local4 = Breadcrumb.subscribeToModel
	f1_local5 = Engine[0x8DF2E5447F384B9]()
	f1_local4(f1_local3, f1_local5["lobbyRoot.lobbyNav"], function(f4_arg0)
		f1_arg0:updateElementState(Breadcrumb, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f4_arg0:get(),
			modelName = "lobbyRoot.lobbyNav",
		})
	end, false)
	Breadcrumb:linkToElementModel(Breadcrumb, "breadcrumbCount", true, function(model)
		f1_arg0:updateElementState(Breadcrumb, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "breadcrumbCount",
		})
	end)
	Breadcrumb:setScale(0.8, 0.8)
	Breadcrumb:linkToElementModel(self, nil, false, function(model)
		Breadcrumb:setModel(model, f1_arg1)
	end)
	self:addElement(Breadcrumb)
	self.Breadcrumb = Breadcrumb
	self:mergeStateConditions({
		{
			stateName = "NoHintText",
			condition = function(menu, element, event)
				return AlwaysFalse()
			end,
		},
		{
			stateName = "ShowText",
			condition = function(menu, element, event)
				return true
			end,
		},
	})
	self:linkToElementModel(self, "weaponModelSlotIndex", true, function(model)
		local f9_local0 = self
		UpdateElementState(self, "Breadcrumb", f1_arg1)
	end)
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.WeaponPersonalizationTextBreadcrumb.__resetProperties = function(f10_arg0)
	f10_arg0.textCenterAlign:completeAnimation()
	f10_arg0.Breadcrumb:completeAnimation()
	f10_arg0.textCenterAlign:setAlpha(1)
	f10_arg0.Breadcrumb:setAlpha(1)
end
CoD.WeaponPersonalizationTextBreadcrumb.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f11_arg0, f11_arg1)
			f11_arg0:__resetProperties()
			f11_arg0:setupElementClipCounter(2)
			f11_arg0.textCenterAlign:completeAnimation()
			f11_arg0.textCenterAlign:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.textCenterAlign)
			f11_arg0.Breadcrumb:completeAnimation()
			f11_arg0.Breadcrumb:setAlpha(0)
			f11_arg0.clipFinished(f11_arg0.Breadcrumb)
		end,
	},
	NoHintText = {
		DefaultClip = function(f12_arg0, f12_arg1)
			f12_arg0:__resetProperties()
			f12_arg0:setupElementClipCounter(2)
			f12_arg0.textCenterAlign:completeAnimation()
			f12_arg0.textCenterAlign:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.textCenterAlign)
			f12_arg0.Breadcrumb:completeAnimation()
			f12_arg0.Breadcrumb:setAlpha(0)
			f12_arg0.clipFinished(f12_arg0.Breadcrumb)
		end,
	},
	ShowText = {
		DefaultClip = function(f13_arg0, f13_arg1)
			f13_arg0:__resetProperties()
			f13_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.WeaponPersonalizationTextBreadcrumb.__onClose = function(f14_arg0)
	f14_arg0.Breadcrumb:close()
end
