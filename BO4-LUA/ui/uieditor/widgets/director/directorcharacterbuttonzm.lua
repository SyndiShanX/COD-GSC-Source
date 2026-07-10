require("x64:6fdf3ce4c17c64e")
require("x64:740fb8de094e3e0")
CoD.DirectorCharacterButtonZM = InheritFrom(LUI.UIElement)
CoD.DirectorCharacterButtonZM.__defaultWidth = 272
CoD.DirectorCharacterButtonZM.__defaultHeight = 379
CoD.DirectorCharacterButtonZM.new = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	local self = LUI.UIElement.new(f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
	CoD.BaseUtility.InitGlobalModel("ZMLobbyExclusions.PrivateMatchName", true)
	self:setClass(CoD.DirectorCharacterButtonZM)
	self.id = "DirectorCharacterButtonZM"
	self.soundSet = "default"
	self.onlyChildrenFocusable = true
	self.anyChildUsesUpdateState = true
	f1_arg0:addElementToPendingUpdateStateList(self)
	local DirectorDraftSelectLoadout = CoD.DirectorDraftSelectLoadout.new(f1_arg0, f1_arg1, 0.5, 0.5, -15.5, 59.5, 1, 1, -320, -245)
	DirectorDraftSelectLoadout:setAlpha(0)
	DirectorDraftSelectLoadout.DirectorDraftSelectLoadoutInternal.LoadoutText:setText(LocalizeToUpperString(@"menu/select_loadout"))
	local f1_local2 = DirectorDraftSelectLoadout
	local ZMLoadoutPreview = DirectorDraftSelectLoadout.subscribeToModel
	local f1_local4 = Engine[@"getglobalmodel"]()
	ZMLoadoutPreview(f1_local2, f1_local4["lobbyRoot.lobbyNav"], function(f2_arg0, f2_arg1)
		CoD.Menu.UpdateButtonShownState(f2_arg1, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
	end, false)
	DirectorDraftSelectLoadout:registerEventHandler("gain_focus", function(element, event)
		local f3_local0 = nil
		if element.gainFocus then
			f3_local0 = element:gainFocus(event)
		elseif element.super.gainFocus then
			f3_local0 = element.super:gainFocus(event)
		end
		CoD.Menu.UpdateButtonShownState(element, f1_arg0, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"])
		return f3_local0
	end)
	f1_arg0:AddButtonCallbackFunction(DirectorDraftSelectLoadout, f1_arg1, Enum[@"luibutton"][@"lui_key_xba_pscross"], nil, function(element, menu, controller, model)
		if CoD.DirectorUtility.ShowDirectorPrivate(element, controller) then
			CoD.ZombieUtility.ShowZMLoadoutPreviewPrivate(controller)
			PlaySoundAlias("uin_toggle_generic")
			return true
		elseif CoD.DirectorUtility.ShowDirectorPublic(controller) then
			CoD.ZombieUtility.ShowZMLoadoutPreviewPublic(controller)
			PlaySoundAlias("uin_toggle_generic")
			return true
		elseif CoD.DirectorUtility.ShowDirectorCustom(element, controller) then
			DataSourceHelperRecreate(controller, "DirectorCharacterButtonZMList")
			CoD.ZombieUtility.ShowZMLoadoutPreviewCustom(controller)
			PlaySoundAlias("uin_toggle_generic")
			return true
		else
		end
	end, function(element, menu, controller)
		if CoD.DirectorUtility.ShowDirectorPrivate(element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select_loadout", nil, nil)
			return true
		elseif CoD.DirectorUtility.ShowDirectorPublic(controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select_loadout", nil, nil)
			return true
		elseif CoD.DirectorUtility.ShowDirectorCustom(element, controller) then
			CoD.Menu.SetButtonLabel(menu, Enum[@"luibutton"][@"lui_key_xba_pscross"], @"menu/select_loadout", nil, nil)
			return true
		else
			return false
		end
	end, false)
	self:addElement(DirectorDraftSelectLoadout)
	self.DirectorDraftSelectLoadout = DirectorDraftSelectLoadout
	ZMLoadoutPreview = CoD.ZMLoadoutPreviewLobbyClient.new(f1_arg0, f1_arg1, 0.5, 0.5, -136, 136, 1, 1, -379, 0)
	ZMLoadoutPreview:setAlpha(0)
	ZMLoadoutPreview:linkToElementModel(self, "info", true, function(model)
		local f6_local0 = model:get()
		if f6_local0 ~= nil then
			ZMLoadoutPreview:setModel(f6_local0, f1_arg1)
		end
	end)
	self:addElement(ZMLoadoutPreview)
	self.ZMLoadoutPreview = ZMLoadoutPreview
	self:mergeStateConditions({
		{
			stateName = "LoadoutPreviewLocal",
			condition = function(menu, element, event)
				local f7_local0
				if not CoD.ModelUtility.IsSelfModelValueNilOrZero(element, f1_arg1, "xuid") then
					f7_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "DirectorZMLoadoutPreview", "ZMLoadoutPreviewWidgetShown")
					if f7_local0 then
						f7_local0 = CoD.DirectorUtility.IsPrimaryLocalClientByXUID(element, f1_arg1, "xuid")
					end
				else
					f7_local0 = false
				end
				return f7_local0
			end,
		},
		{
			stateName = "LoadoutPreview",
			condition = function(menu, element, event)
				local f8_local0
				if not CoD.ModelUtility.IsSelfModelValueNilOrZero(element, f1_arg1, "xuid") then
					f8_local0 = CoD.ModelUtility.IsGlobalDataSourceModelValueTrue(f1_arg1, "DirectorZMLoadoutPreview", "ZMLoadoutPreviewWidgetShown")
				else
					f8_local0 = false
				end
				return f8_local0
			end,
		},
		{
			stateName = "Visible3DModelLoadout",
			condition = function(menu, element, event)
				local f9_local0
				if not CoD.ModelUtility.IsSelfModelValueNilOrZero(element, f1_arg1, "xuid") then
					f9_local0 = CoD.DirectorUtility.IsPrimaryLocalClientByXUID(element, f1_arg1, "xuid")
				else
					f9_local0 = false
				end
				return f9_local0
			end,
		},
		{
			stateName = "Visible3DModel",
			condition = function(menu, element, event)
				return not CoD.ModelUtility.IsSelfModelValueNilOrZero(element, f1_arg1, "xuid")
			end,
		},
	})
	self:linkToElementModel(self, "xuid", true, function(model)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = model:get(),
			modelName = "xuid",
		})
	end)
	f1_local4 = self
	f1_local2 = self.subscribeToModel
	local f1_local5 = DataSources.DirectorZMLoadoutPreview.getModel(f1_arg1)
	f1_local2(f1_local4, f1_local5.ZMLoadoutPreviewWidgetShown, function(f12_arg0)
		f1_arg0:updateElementState(self, {
			name = "model_validation",
			menu = f1_arg0,
			controller = f1_arg1,
			modelValue = f12_arg0:get(),
			modelName = "ZMLoadoutPreviewWidgetShown",
		})
	end, false)
	self:linkToElementModel(self, "xuid", true, function(model)
		local f13_local0 = self
		DataSourceHelperRecreate(f1_arg1, "DirectorCharacterButtonZMList")
	end)
	DirectorDraftSelectLoadout.id = "DirectorDraftSelectLoadout"
	ZMLoadoutPreview.id = "ZMLoadoutPreview"
	LUI.OverrideFunction_CallOriginalSecond(self, "close", self.__onClose)
	if PostLoadFunc then
		PostLoadFunc(self, f1_arg1, f1_arg0)
	end
	return self
end
CoD.DirectorCharacterButtonZM.__resetProperties = function(f14_arg0)
	f14_arg0.ZMLoadoutPreview:completeAnimation()
	f14_arg0.DirectorDraftSelectLoadout:completeAnimation()
	f14_arg0.ZMLoadoutPreview:setAlpha(0)
	f14_arg0.DirectorDraftSelectLoadout:setAlpha(0)
end
CoD.DirectorCharacterButtonZM.__clipsPerState = {
	DefaultState = {
		DefaultClip = function(f15_arg0, f15_arg1)
			f15_arg0:__resetProperties()
			f15_arg0:setupElementClipCounter(0)
		end,
	},
	LoadoutPreviewLocal = {
		DefaultClip = function(f16_arg0, f16_arg1)
			f16_arg0:__resetProperties()
			f16_arg0:setupElementClipCounter(0)
		end,
	},
	LoadoutPreview = {
		DefaultClip = function(f17_arg0, f17_arg1)
			f17_arg0:__resetProperties()
			f17_arg0:setupElementClipCounter(1)
			f17_arg0.ZMLoadoutPreview:completeAnimation()
			f17_arg0.ZMLoadoutPreview:setAlpha(1)
			f17_arg0.clipFinished(f17_arg0.ZMLoadoutPreview)
		end,
	},
	Visible3DModelLoadout = {
		DefaultClip = function(f18_arg0, f18_arg1)
			f18_arg0:__resetProperties()
			f18_arg0:setupElementClipCounter(1)
			f18_arg0.DirectorDraftSelectLoadout:completeAnimation()
			f18_arg0.DirectorDraftSelectLoadout:setAlpha(1)
			f18_arg0.clipFinished(f18_arg0.DirectorDraftSelectLoadout)
		end,
	},
	Visible3DModel = {
		DefaultClip = function(f19_arg0, f19_arg1)
			f19_arg0:__resetProperties()
			f19_arg0:setupElementClipCounter(0)
		end,
	},
}
CoD.DirectorCharacterButtonZM.__onClose = function(f20_arg0)
	f20_arg0.DirectorDraftSelectLoadout:close()
	f20_arg0.ZMLoadoutPreview:close()
end
