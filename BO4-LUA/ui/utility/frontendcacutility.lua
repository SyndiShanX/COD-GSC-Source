CoD.FrontendCACUtility = {}
require("x64:f3c5259f470592d")
CoD.FrontendCACUtility.ClassOptionsPreLoad = function(f1_arg0, f1_arg1)
	if not Engine[@"issplitscreen"]() then
		f1_arg0.animateInFromOffset = 340
	end
	f1_arg0:setModel(CoD.perController[f1_arg1].classModel)
	f1_arg0.handleKeyboardComplete = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3)
		local f2_local0 = f2_arg3.input
		local f2_local1 = CoD.BaseUtility.GetMenuSessionMode(f2_arg0)
		local f2_local2 = CoD.BaseUtility.GetMenuModel(f2_arg0)
		local f2_local3 = f2_local2.classNum:get()
		if f2_arg3.type == Enum[@"keyboardtype"][@"keyboard_type_custom_class"] then
			if f2_local0 ~= nil then
				f2_local2.customClassName:set(f2_local0)
				local f2_local4 = Engine[@"getcacroot"](f2_arg2, f2_local3, f2_local1)
				if f2_local4 and f2_local4.customClassName and f2_local4.customClassName[f2_local3] then
					f2_local4.customClassName[f2_local3]:set(f2_local0)
					SaveLoadoutGeneric(f2_arg2)
				end
			end
			GoBack(f2_arg0, f2_arg2)
		elseif f2_arg3.type == Enum[@"keyboardtype"][@"keyboard_type_class_set"] then
			if f2_local0 ~= nil then
				Engine[@"setclasssetname"](f2_arg2, Engine[@"getcurrentclasssetindex"](f2_arg2), f2_local0)
			end
			local f2_local4 = GoBack(f2_arg0, f2_arg2)
			f2_local4:dispatchEventToChildren({
				name = "class_set_name_change",
				controller = f2_arg2,
			})
		end
	end
end
CoD.OverlayUtility.AddSystemOverlay("CopyClass", {
	menuName = "SystemOverlay_Full",
	frameWidget = "CoD.systemOverlay_ClassOptionsFrame",
	title = Engine[@"hash_4F9F1239CFD921FE"](@"hash_7FB972E2F65A6D5E"),
	description = function(f3_arg0)
		local f3_local0 = ""
		local f3_local1 = CoD.BaseUtility.GetMenuModel(f3_arg0)
		if f3_local1 then
			f3_local0 = f3_local1.customClassName:get() or ""
		end
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_5F9260EB62FD79D9", f3_local0)
	end,
	categoryType = CoD.OverlayUtility.OverlayTypes.GenericMessage,
	preCreateStep = function(f4_arg0, f4_arg1, f4_arg2)
		f4_arg0._model = f4_arg2._model
		f4_arg0._sessionMode = f4_arg2._sessionMode
		f4_arg0._excludeLockedClasses = true
	end,
	listDatasource = "ChooseClassList",
	[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
	[CoD.OverlayUtility.ProcessActionPropertyName] = function()
		return function(f6_arg0, f6_arg1, f6_arg2, f6_arg3, f6_arg4)
			ClassOptionsCopyLoadout(f6_arg0, f6_arg1, f6_arg2, f6_arg4)
		end
	end,
})
CoD.OverlayUtility.AddSystemOverlay("ResetToDefault", {
	menuName = "SystemOverlay_Full",
	frameWidget = "CoD.systemOverlay_ClassOptionsFrame",
	title = Engine[@"hash_4F9F1239CFD921FE"](@"hash_3345C72CB8A9CA70"),
	description = function(f7_arg0)
		local f7_local0 = ""
		local f7_local1 = CoD.BaseUtility.GetMenuModel(f7_arg0)
		if f7_local1 then
			f7_local0 = f7_local1.customClassName:get() or ""
		end
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_6C7FD70D0AC5247", f7_local0)
	end,
	categoryType = CoD.OverlayUtility.OverlayTypes.GenericMessage,
	listDatasource = "ResetDefaultClass",
	preCreateStep = function(f8_arg0, f8_arg1, f8_arg2)
		f8_arg0._model = f8_arg2._model
		f8_arg0._sessionMode = f8_arg2._sessionMode
	end,
	[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
	[CoD.OverlayUtility.ProcessActionPropertyName] = function()
		return function(f10_arg0, f10_arg1, f10_arg2, f10_arg3, f10_arg4)
			ClassOptionsResetToDefault(f10_arg0, f10_arg1, f10_arg2, f10_arg4)
		end
	end,
})
CoD.OverlayUtility.AddSystemOverlay("CopyClassSet", {
	menuName = "SystemOverlay_Full",
	frameWidget = "CoD.systemOverlay_ClassOptionsFrame",
	title = Engine[@"hash_4F9F1239CFD921FE"](@"hash_1E8CF7E8544DBAC3"),
	description = Engine[@"hash_4F9F1239CFD921FE"](@"hash_25ABE88C167FE510"),
	categoryType = CoD.OverlayUtility.OverlayTypes.GenericMessage,
	listDatasource = "ClassSetTabs",
	[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
	[CoD.OverlayUtility.ProcessActionPropertyName] = function()
		return function(f12_arg0, f12_arg1, f12_arg2)
			ClassOptionsCopyClassSet(f12_arg0, f12_arg1, f12_arg2)
		end
	end,
})
CoD.FrontendCACUtility.GoBackAndPurchaseCodpointsAction = function(f13_arg0, f13_arg1, f13_arg2, f13_arg3, f13_arg4)
	GoBackAndOpenOverlayOnParent(f13_arg4, "Store_CodPoints", f13_arg2)
end
CoD.OverlayUtility.AddSystemOverlay("PurchaseExtraSlotsConfirmation", {
	menuName = "SystemOverlay_Full",
	frameWidget = "CoD.SystemOverlay_ExtraSlots",
	title = function(f14_arg0, f14_arg1)
		if f14_arg1.itemCODPointCost > 0 and Engine[@"hash_2F40679B550DCCA2"](f14_arg0, CoD.Currencies.COD_POINTS) < f14_arg1.itemCODPointCost then
			return @"hash_6924599FE45E0286"
		else
			return Engine[@"toupper"](Engine[@"hash_4F9F1239CFD921FE"](0x815271F5DDF1C8))
		end
	end,
	description = function(f15_arg0, f15_arg1)
		if f15_arg1.itemCODPointCost > 0 and Engine[@"hash_2F40679B550DCCA2"](f15_arg0, CoD.Currencies.COD_POINTS) < f15_arg1.itemCODPointCost then
			return Engine[@"hash_4F9F1239CFD921FE"](@"hash_3F1D4F9815C2714B", f15_arg1.displayText)
		else
			return Engine[@"hash_4F9F1239CFD921FE"](@"hash_7E30E8F4251F2FC0", f15_arg1.displayText)
		end
	end,
	codpointcost = function(f16_arg0, f16_arg1)
		return f16_arg1.itemCODPointCost
	end,
	codpointcostString = function(f17_arg0, f17_arg1)
		if f17_arg1.itemCODPointCost > 0 and Engine[@"hash_2F40679B550DCCA2"](f17_arg0, CoD.Currencies.COD_POINTS) < f17_arg1.itemCODPointCost then
			return Engine[@"hash_4F9F1239CFD921FE"](@"hash_23B61EC19CA8A6D", f17_arg1.itemCODPointCost)
		else
			return ""
		end
	end,
	categoryType = CoD.OverlayUtility.OverlayTypes.GenericMessage,
	listDatasource = function(f18_arg0, f18_arg1)
		DataSources.PurchaseExtraSlotsMenuList = DataSourceHelpers.ListSetup("PurchaseExtraSlotsMenuList", function(f19_arg0, f19_arg1)
			local f19_local0 = {}
			if f19_arg1.purchasingExtraSlots then
				return {}
			end
			local f19_local1 = function(f20_arg0, f20_arg1, f20_arg2, f20_arg3)
				return {
					models = {
						displayText = f20_arg0,
						disabled = f20_arg3,
					},
					properties = {
						action = f20_arg1,
						actionParam = f18_arg1,
						selectIndex = f20_arg2,
					},
				}
			end
			local f19_local2 = function(f21_arg0, f21_arg1, f21_arg2, f21_arg3, f21_arg4)
				if not DoesPlayerHaveExtraSlotsItem(f21_arg2) then
					local f21_local0 = Dvar[@"hash_CF99BC22D677A8D"]:get()
					if f21_local0 == 0 or not Engine[@"hash_29EF65378FF2525E"](f21_arg2, tostring(f21_local0)) then
						LuaUtils.UI_ShowErrorMessageDialog(f21_arg2, @"hash_4133DE36D3F6B23E", "")
						GoBack(f21_arg4, f21_arg2)
						return
					end
					f21_arg0:setState(f21_arg2, "Purchasing")
					f21_arg0.PurchasingWidget:playClip("StartPurchasing")
					f21_arg0.PurchasingWidget.nextClip = "Purchasing"
					f19_arg1.purchasingExtraSlots = true
					f19_arg1:updateDataSource()
					f21_arg4[CoD.OverlayUtility.GoBackPropertyName] = nil
					f19_arg1.disabled = true
					CoD.Menu.UpdateAllButtonPrompts(f21_arg4, f21_arg2)
					f21_arg0.PurchasingWidget:registerEventHandler("clip_over", function(element, event)
						if Engine[@"isinventorybusy"](f21_arg2) or Engine[@"getpurchasedwskuresult"](f21_arg2) == Enum[@"inventorypurchaseresult"][@"inventory_purchase_result_inprogress"] then
							LUI.UIElement.clipOver(element, event)
						else
							element:playClip("StopPurchasing")
							element:registerEventHandler("clip_over", function(element, event)
								element:registerEventHandler("clip_over", LUI.UIElement.clipOver)
								f21_arg0:setState(f21_arg2, "DefaultState")
								if Engine[@"getpurchasedwskuresult"](f21_arg2) == Enum[@"inventorypurchaseresult"][@"inventory_purchase_result_success"] then
									CoD.OverlayUtility.CreateOverlay(f21_arg2, GoBack(f21_arg4, f21_arg2), "PurchaseExtraSlotsComplete", f21_arg2)
								else
									LuaUtils.UI_ShowErrorMessageDialog(f21_arg2, @"hash_4133DE36D3F6B23E", "")
									GoBack(f21_arg4, f21_arg2)
								end
							end)
						end
					end)
				end
			end
			local f19_local3 = function(f24_arg0, f24_arg1, f24_arg2, f24_arg3, f24_arg4)
				GoBack(f24_arg4, f24_arg2)
			end
			if f18_arg1.itemCODPointCost > 0 and Engine[@"hash_2F40679B550DCCA2"](f19_arg0, CoD.Currencies.COD_POINTS) < f18_arg1.itemCODPointCost then
				table.insert(f19_local0, f19_local1(@"hash_263D5409DEC36DFA", CoD.FrontendCACUtility.GoBackAndPurchaseCodpointsAction, true, false))
			elseif f18_arg1.itemCODPointCost > 0 then
				table.insert(f19_local0, f19_local1(Engine[@"hash_4F9F1239CFD921FE"](@"hash_6804EA01CE713AC", CoD.CACUtility.GetExtraSlotCODPointCost()), f19_local2, true, false))
			end
			table.insert(f19_local0, f19_local1(@"hash_26DA4540B4705513", f19_local3, false, false))
			return f19_local0
		end, true)
		return "PurchaseExtraSlotsMenuList"
	end,
	[CoD.OverlayUtility.GoBackPropertyName] = CoD.OverlayUtility.DefaultGoBack,
})
CoD.OverlayUtility.AddSystemOverlay("PurchaseExtraSlotsComplete", {
	menuName = "SystemOverlay_Compact",
	frameWidget = "CoD.SystemOverlay_ExtraSlotsPurchased",
	title = function(f25_arg0, f25_arg1)
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_3A833716CBB8F05A")
	end,
	description = function(f26_arg0, f26_arg1)
		return Engine[@"hash_4F9F1239CFD921FE"](@"hash_46E962892BD26FA8")
	end,
	categoryType = CoD.OverlayUtility.OverlayTypes.GenericMessage,
	listDatasource = function(f27_arg0, f27_arg1)
		DataSources.PurchaseExtraSlotsCompleteMenuList = DataSourceHelpers.ListSetup("PurchaseExtraSlotsCompleteMenuList", function(f28_arg0)
			local f28_local0 = {}
			local f28_local1 = function(f29_arg0, f29_arg1, f29_arg2, f29_arg3)
				return {
					models = {
						displayText = f29_arg0,
						disabled = f29_arg3,
					},
					properties = {
						action = f29_arg1,
						actionParam = f27_arg1,
						selectIndex = f29_arg2,
					},
				}
			end
			table.insert(
				f28_local0,
				f28_local1("MENU_OK", function(f30_arg0, f30_arg1, f30_arg2, f30_arg3, f30_arg4)
					local f30_local0 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f30_arg2), "classSetsUpdated")
					if f30_local0 then
						Engine[@"forcenotifymodelsubscriptions"](f30_local0)
					end
					GoBack(f30_arg4, f30_arg2)
				end, true, false)
			)
			return f28_local0
		end, true)
		return "PurchaseExtraSlotsCompleteMenuList"
	end,
	[CoD.OverlayUtility.GoBackPropertyName] = function()
		return function(f32_arg0, f32_arg1)
			local f32_local0 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f32_arg1), "classSetsUpdated")
			if f32_local0 then
				Engine[@"forcenotifymodelsubscriptions"](f32_local0)
			end
			GoBack(f32_arg0, f32_arg1)
		end
	end,
})
CoD.FrontendCACUtility.ClassOptionsListPrepare = function(f33_arg0)
	local f33_local0 = {}
	local f33_local1 = function(f34_arg0, f34_arg1, f34_arg2, f34_arg3, f34_arg4)
		return {
			models = {
				displayText = f34_arg0,
				icon = f34_arg1,
				description = f34_arg2,
			},
			properties = {
				action = f34_arg3,
				actionParam = f34_arg4,
			},
		}
	end
	local f33_local2 = function(f35_arg0, f35_arg1, f35_arg2, f35_arg3, f35_arg4)
		ShowKeyboard(f35_arg0, f35_arg1, f35_arg2, "KEYBOARD_TYPE_CUSTOM_CLASS")
	end
	local f33_local3 = function(f36_arg0, f36_arg1, f36_arg2, f36_arg3, f36_arg4)
		CoD.OverlayUtility.CreateOverlay(f36_arg2, f36_arg4, "CopyClass", {
			_sessionMode = CoD.BaseUtility.GetMenuSessionMode(f36_arg4),
			_model = CoD.BaseUtility.GetMenuModel(f36_arg4),
		})
	end
	local f33_local4 = function(f37_arg0, f37_arg1, f37_arg2, f37_arg3, f37_arg4)
		CoD.OverlayUtility.CreateOverlay(f37_arg2, f37_arg4, "ResetToDefault", {
			_sessionMode = CoD.BaseUtility.GetMenuSessionMode(f37_arg4),
			_model = CoD.BaseUtility.GetMenuModel(f37_arg4),
		})
	end
	local f33_local5 = function(f38_arg0, f38_arg1, f38_arg2, f38_arg3, f38_arg4)
		ClassOptionsClearLoadout(f38_arg0, f38_arg1, f38_arg2, f38_arg4)
		GoBack(f38_arg0, f38_arg2)
	end
	if not CoD.isPC then
		table.insert(f33_local0, f33_local1(@"hash_6D3D8A176056AD52", "t7_icon_menu_simple_rename", @"hash_41EE9CD5194170FF", f33_local2))
	end
	table.insert(f33_local0, f33_local1(@"hash_1A4D4C13AEECF34E", "t7_icon_menu_simple_copy", @"hash_640C0201ADBDA6AF", f33_local3))
	table.insert(f33_local0, f33_local1(@"hash_149770A897DE23D4", "t7_icon_menu_simple_revertsetting", @"hash_5CF897E6D58FEB53", f33_local4))
	if not IsCampaign() and not IsZombies() then
		table.insert(f33_local0, f33_local1(@"hash_4E9BA912AFB1F83D", "t7_icon_menu_simple_delete", @"hash_7630F4D735D328DD", f33_local5))
	end
	return f33_local0
end
CoD.FrontendCACUtility.ClassOptionsGlobalModels = {
	getModel = function(f39_arg0)
		local f39_local0 = Engine[@"getmodelforcontroller"](f39_arg0)
		f39_local0 = f39_local0:create("CACClassOptions")
		f39_local0:create("customClassOptionsHintText")
		f39_local0:create("customClassName")
		f39_local0:create("currentClassName")
		return f39_local0
	end,
}
DataSources.CACClassOptions = DataSourceHelpers.ListSetup("CACClassOptions", CoD.FrontendCACUtility.ClassOptionsListPrepare, true, CoD.FrontendCACUtility.ClassOptionsGlobalModels)
