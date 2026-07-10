CoD.PlayerRoleUtility = {}
CoD.PlayerRoleUtility.Heroes = {}
CoD.PlayerRoleUtility.Heroes.heroUpdateEvent = "updateHero"
CoD.PlayerRoleUtility.Heroes.HeroList = {}
CoD.PlayerRoleUtility.Heroes.HeroListSorted = {}
CoD.PlayerRoleUtility.Heroes.HeroInfo = {}
CoD.PlayerRoleUtility.Heroes.HeroCustomization = {}
CoD.PlayerRoleUtility.EquippedOutfitItems = {}
CoD.PlayerRoleUtility.customizationMode = nil
CoD.PlayerRoleUtility.FirstTimeFlowState = LuaEnum.createEnum("None", "Overview", "SelectionChanged", "Complete")
CoD.PlayerRoleUtility.PersonalizeHeroData = {}
CoD.PlayerRoleUtility.PersonalizeHeroData.Modes = LuaEnum.createEnum("ExploringOptions", "EdittingOption")
CoD.PlayerRoleUtility.PersonalizeHeroData.EdittingArea = nil
CoD.PlayerRoleUtility.PersonalizeHeroData.EdittingAreaItemIndex = nil
CoD.PlayerRoleUtility.PersonalizeHeroData.EdittingElement = nil
CoD.PlayerRoleUtility.PersonalizeHeroData.CurrentColors = nil
CoD.PlayerRoleUtility.PersonalizeHeroData.MaxWeaponAttachments = 8
CoD.PlayerRoleUtility.PersonalizeHeroData.SpecialistEpicItemIndex = 9
CoD.PlayerRoleUtility.PersonalizeHeroData.CompletionEpicItemIndex = 10
CoD.PlayerRoleUtility.PersonalizeHeroData.SpacerRows = {}
CoD.PlayerRoleUtility.ShowcaseWeaponCategoryIndex = Enum[0xFCC6A2D2EB0FDA7][0x997A52C773DD143]
CoD.PlayerRoleUtility.DraftStage = LuaEnum.createEnum("DRAFT_STAGE_NONE", "DRAFT_STAGE_INITIALIZE", "DRAFT_STAGE_WAITING_FOR_PLAYERS", "DRAFT_STAGE_DRAFT", "DRAFT_STAGE_ALL_CLIENTS_READY", "DRAFT_STAGE_ASSIGNMENT", "DRAFT_STAGE_GAME_START", "DRAFT_STAGE_FINALIZE", "DRAFT_STAGE_CHOOSE_POST_DRAFT")
CoD.PlayerRoleUtility.JumpkitOptions = {
	{
		type = Enum[0x8037372CBD17C20][0xBF99C226E97F1DB],
		typeName = 0xBCAC088311E46B2,
	},
	{
		type = Enum[0x8037372CBD17C20][0x711A76E11C936FF],
		typeName = 0x1C7C2BF1D8C309D,
	},
	{
		type = Enum[0x8037372CBD17C20][0xD7DC1BB143B4455],
		typeName = 0x1676BE6AC5BA578,
	},
}
CoD.PlayerRoleUtility.CreatePersonalizeColorDatasource = function(f1_arg0, f1_arg1, f1_arg2, f1_arg3)
	DataSources[f1_arg1] = DataSourceHelpers.ListSetup(f1_arg1, function(f2_arg0)
		local f2_local0 = {}
		for f2_local9, f2_local10 in ipairs(DataSources[f1_arg1].colorTable) do
			local f2_local11 = {
				models = {
					color = f2_local10.red .. " " .. f2_local10.green .. " " .. f2_local10.blue,
					icon = f2_local10.icon or "$white",
					xOfY = Engine[0xF9F1239CFD921FE](0x3D235B06A9B195B, f2_local9, #DataSources[f1_arg1].colorTable),
				},
				properties = {
					optionIndex = f2_local9,
				},
			}
			if f1_arg3 then
				for f2_local7, f2_local8 in pairs(f1_arg3(f2_local9)) do
					f2_local11.properties[f2_local7] = f2_local8
				end
			end
			table.insert(f2_local0, f2_local11)
		end
		return f2_local0
	end, true)
	DataSources[f1_arg1].colorTable = f1_arg2
	return f1_arg1
end
CoD.PlayerRoleUtility.GetHeroList = function(f3_arg0)
	if not f3_arg0 then
		f3_arg0 = CoD.PlayerRoleUtility.customizationMode
	end
	if not CoD.PlayerRoleUtility.Heroes.HeroList[f3_arg0] then
		CoD.PlayerRoleUtility.Heroes.HeroList[f3_arg0] = Engine[0xA5B5E7CABA5C3AB](f3_arg0)
	end
	return CoD.PlayerRoleUtility.Heroes.HeroList[f3_arg0]
end
CoD.PlayerRoleUtility.GetHeroListSorted = function(f4_arg0)
	if not f4_arg0 then
		f4_arg0 = CoD.PlayerRoleUtility.customizationMode
	end
	if not CoD.PlayerRoleUtility.Heroes.HeroListSorted[f4_arg0] then
		local f4_local0 = {}
		for f4_local8, f4_local9 in ipairs(CoD.PlayerRoleUtility.GetHeroList(f4_arg0)) do
			if not f4_local9[0x810366D1F05BBBD] or CoD.BaseUtility.IsDvarEnabled(f4_local9[0x810366D1F05BBBD]) then
				local f4_local4 = #f4_local0 + 1
				for f4_local5 = #f4_local0, 1, -1 do
					if Engine[0xF9F1239CFD921FE](f4_local0[f4_local5].displayName) < Engine[0xF9F1239CFD921FE](f4_local9.displayName) then
						break
					end
					f4_local4 = f4_local4 - 1
				end
				table.insert(f4_local0, f4_local4, f4_local9)
			end
		end
		CoD.PlayerRoleUtility.Heroes.HeroListSorted[f4_arg0] = f4_local0
	end
	return CoD.PlayerRoleUtility.Heroes.HeroListSorted[f4_arg0]
end
CoD.PlayerRoleUtility.GetFirstHeroFromHeroList = function(f5_arg0)
	return CoD.PlayerRoleUtility.GetFirstHeroFromHeroListForMode(CoD.BaseUtility.GetMenuSessionMode(f5_arg0))
end
CoD.PlayerRoleUtility.GetFirstHeroFromHeroListForMode = function(f6_arg0)
	if not f6_arg0 then
		f6_arg0 = CoD.PlayerRoleUtility.customizationMode or Engine[0x3EAC408F958FF05]()
	end
	if not CoD.PlayerRoleUtility.FirstHeroCharacterIndex then
		local f6_local0, f6_local1, f6_local2 = ipairs(CoD.PlayerRoleUtility.GetHeroList(f6_arg0))
		local f6_local3, f6_local4 = f6_local0(f6_local1, f6_local2)
		if f6_local3 ~= nil then
			f6_local2 = f6_local3
			CoD.PlayerRoleUtility.FirstHeroCharacterIndex = f6_local4.bodyIndex
		else
		end
	end
	return CoD.PlayerRoleUtility.FirstHeroCharacterIndex
end
CoD.PlayerRoleUtility.GetCachedHeroInfo = function(f7_arg0, f7_arg1)
	if not CoD.PlayerRoleUtility.Heroes.HeroInfo[f7_arg0] then
		CoD.PlayerRoleUtility.Heroes.HeroInfo[f7_arg0] = {}
	end
	if not CoD.PlayerRoleUtility.Heroes.HeroInfo[f7_arg0][f7_arg1] then
		CoD.PlayerRoleUtility.Heroes.HeroInfo[f7_arg0][f7_arg1] = Engine[0x11ACC52E5BA9A37](f7_arg0, f7_arg1)
	end
	return CoD.PlayerRoleUtility.Heroes.HeroInfo[f7_arg0][f7_arg1]
end
CoD.PlayerRoleUtility.GetCachedHeroCustomization = function(f8_arg0, f8_arg1)
	if not CoD.PlayerRoleUtility.Heroes.HeroCustomization[f8_arg0] then
		CoD.PlayerRoleUtility.Heroes.HeroCustomization[f8_arg0] = {}
	end
	if not CoD.PlayerRoleUtility.Heroes.HeroCustomization[f8_arg0][f8_arg1] then
		CoD.PlayerRoleUtility.Heroes.HeroCustomization[f8_arg0][f8_arg1] = Engine[0x4C5185056289C6C](f8_arg0, f8_arg1)
	end
	return CoD.PlayerRoleUtility.Heroes.HeroCustomization[f8_arg0][f8_arg1]
end
CoD.PlayerRoleUtility.SetPerControllerTablePropertyToHeroClass = function(f9_arg0, f9_arg1, f9_arg2)
	SetPerControllerTableProperty(f9_arg0, f9_arg1, Engine[0x6C0CB7BD099633F](f9_arg2, CoD.PlayerRoleUtility.GetSelectedCharacterIndex(f9_arg0)))
end
CoD.PlayerRoleUtility.GetSelectedCharacterIndex = function(f10_arg0)
	local f10_local0 = nil
	if InFrontend() then
		local f10_local1 = CoD.PlayerRoleUtility.customizationMode
		if not f10_local1 then
			f10_local1 = Engine[0x3EAC408F958FF05]()
		end
		if f10_local1 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
			f10_local0 = CoD.SafeGetModelValue(Engine[0x4DF5CFBC1771947](f10_arg0), "PositionEditLoadout.SelectedCharacterIndex")
			if f10_local0 == nil then
				f10_local0 = Engine[0x1DC6357002DC122](f10_arg0, f10_local1)
			end
		elseif f10_local1 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
			local f10_local2 = Engine[0x93B19E01B1FD1C7](f10_arg0)
			local f10_local3 = Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2]
			return Engine[0x40145EEB2E913D2](f10_arg0, Engine[0xEFBAAD12776201D](f10_local3, Engine[0xC3DF042E7492B66](f10_local3), f10_local2))
		else
			return CoD.PlayerRoleUtility.GetFirstHeroFromHeroListForMode(f10_local1)
		end
	else
		f10_local0 = Engine[0x40145EEB2E913D2](f10_arg0, Engine[0x761955642304848](f10_arg0))
	end
	return f10_local0
end
CoD.PlayerRoleUtility.SetCACSelectedSpecialistAsActive = function(f11_arg0, f11_arg1, f11_arg2)
	f11_arg1.positions:findItem({
		characterIndex = f11_arg2:get(),
	}, nil, true, nil)
end
CoD.PlayerRoleUtility.GetHeroDisplayNameAndIndex = function(f12_arg0, f12_arg1)
	for f12_local3, f12_local4 in ipairs(CoD.PlayerRoleUtility.GetHeroList(f12_arg0)) do
		if f12_local4.assetName == f12_arg1 then
			return f12_local4.displayName, f12_local4.bodyIndex
		end
	end
	return 0x0, nil
end
CoD.PlayerRoleUtility.Heroes.GetPersonalizationNewCount = function(f13_arg0, f13_arg1)
	local f13_local0 = CoD.PlayerRoleUtility.customizationMode
	local f13_local1 = 0
	if f13_arg1 then
		for f13_local2 = 0, Enum[0xFCC6A2D2EB0FDA7][0x997A52C773DD143] - 1, 1 do
			local f13_local5 = Engine[0xC3BCAC70D9C1A2D](f13_arg0, f13_arg1, outfitIndex, f13_local2, f13_local0)
			f13_local1 = f13_local1 + f13_local5.total
		end
	end
	return f13_local1
end
CoD.PlayerRoleUtility.ChooseGender = function(f14_arg0, f14_arg1)
	local f14_local0 = Engine[0x3EAC408F958FF05]()
	if f14_local0 == Enum[0x9C0C2196D8313A0][0x60063C67132EB69] then
		selectedGender = Engine[0xB6596E4282630DA](f14_arg1, f14_arg0.gender)
	elseif f14_local0 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		local f14_local1 = Engine[0xFC41172469DB251](f14_arg1)
		f14_local1 = f14_local1[0xA8BD5071BCB463C]
		if f14_arg0.characterIndex ~= f14_local1:get() then
			local f14_local2 = Engine[0xB678B832BC9DC0](Engine[0x3EAC408F958FF05](), CoD.PlayerRoleUtility.GetSelectedCharacterIndex(f14_arg1))
			if f14_local2[0xC9366DE09ED7379] == 1 then
				PositionDraftSelectCharacterFrontend(f14_arg0, f14_arg0, f14_arg1)
			end
			f14_local1:set(f14_arg0.characterIndex)
			Engine[0xE6C09FDF6C8D188](f14_arg1, f14_local0)
			DataSources.WZDefaultCharacterInfo.recreate(f14_arg1)
		end
	end
end
CoD.PlayerRoleUtility.PreviewGender = function(f15_arg0, f15_arg1)
	Engine[0x6ABA4D7F0840A1E](f15_arg1, "updateSpecialistCustomization" .. CoD.GetLocalClientAdjustedNum(f15_arg1), {
		event_name = "changeHero",
		character_index = f15_arg0.characterIndex,
		mode = Engine[0x3EAC408F958FF05](),
	})
end
CoD.PlayerRoleUtility.LoadMenuCharacter = function(f16_arg0, f16_arg1)
	local f16_local0 = CoD.SafeGetModelValue(f16_arg0:getModel(), "characterIndex")
	if not f16_local0 then
		f16_local0 = list.menu._selectIndex
	end
	Engine[0x6ABA4D7F0840A1E](f16_arg1, "updateSpecialistCustomization" .. CoD.GetLocalClientAdjustedNum(f16_arg1), {
		event_name = "changeHero",
		character_index = f16_local0,
		mode = Engine[0x3EAC408F958FF05](),
	})
end
CoD.PlayerRoleUtility.GetCharacterListForGender = function(f17_arg0, f17_arg1, f17_arg2)
	local f17_local0 = "GenderCharacterList" .. f17_arg0 .. f17_arg1
	DataSources[f17_local0] = DataSourceHelpers.ListSetup(f17_local0, function(f18_arg0)
		local f18_local0 = {}
		for f18_local4, f18_local5 in ipairs(CoD.PlayerRoleUtility.GetHeroList(f17_arg0)) do
			local f18_local6 = f18_local5.bodyIndex
			local f18_local7 = Engine[0xB678B832BC9DC0](f17_arg0, f18_local6)
			if f18_local7[0xE69216C2DA7060A] == f17_arg0 and f18_local7[0xC9366DE09ED7379] == 1 and f18_local5.gender == f17_arg1 then
				table.insert(f18_local0, {
					models = {
						name = f18_local5.displayName,
						fullName = f18_local5[0xCB98543E7EC137] or 0x0,
						icon = f18_local5.positionDraftIcon,
						characterIndex = f18_local6,
						disabled = f18_local7[0x9173E55822A88B5] == 1,
						jobTitle = CoD.PlayerRoleUtility.GetCharacterTraitTitle(f17_arg0, f18_local6),
						characterInT4 = f18_local7[0xBF1CCE3018DC22F] == 1,
						characterInT5 = f18_local7[0xBF1CBE3018DC07C] == 1,
						characterInT6 = f18_local7[0xBF1CEE3018DC595] == 1,
						characterInT7 = f18_local7[0xBF1CDE3018DC3E2] == 1,
						characterInT8 = f18_local7[0xBF1D0E3018DC8FB] == 1,
						isSelected = f17_arg2 == f18_local6,
					},
					properties = {
						characterIndex = f18_local6,
						character = f18_local5,
						sortIndex = f18_local4,
						selectIndex = f17_arg2 == f18_local6,
						gender = f17_arg1,
					},
				})
			end
		end
		return f18_local0
	end)
	return f17_local0
end
CoD.PlayerRoleUtility.GenderListPrepare = function(f19_arg0)
	local f19_local0 = nil
	local f19_local1 = Engine[0x3EAC408F958FF05]()
	local f19_local2 = nil
	if f19_local1 == Enum[0x9C0C2196D8313A0][0x60063C67132EB69] then
		f19_local0 = Engine[0x353F5BE07C3EB](f19_arg0, Enum[0x9C0C2196D8313A0][0x60063C67132EB69])
	elseif f19_local1 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		local f19_local3 = Engine[0xFC41172469DB251](f19_arg0)
		f19_local2 = f19_local3[0xA8BD5071BCB463C]:get()
		if f19_local2 then
			local f19_local4 = CoD.PlayerRoleUtility.GetCachedHeroInfo(Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39], f19_local2)
			f19_local0 = f19_local4 and f19_local4.gender
		end
	end
	local f19_local3 = function(f20_arg0, f20_arg1)
		return {
			models = {
				tabName = f20_arg1,
				charactersDataSource = CoD.PlayerRoleUtility.GetCharacterListForGender(f19_local1, f20_arg0, f19_local2),
			},
			properties = {
				gender = f20_arg0,
				selectIndex = f20_arg0 == f19_local0,
			},
		}
	end
	local f19_local4 = {}
	local f19_local5 = f19_local3(Enum[0x8BFED7BA33F8942][0xB99A2B81BECD183], 0x27C8255032AA99D)
	local f19_local6 = f19_local3(Enum[0x8BFED7BA33F8942][0xE21A9F63A6B925A], 0x2B1674419CAA7C0)
	return f19_local5
end
DataSources.GendersList = DataSourceHelpers.ListSetup("GendersList", CoD.PlayerRoleUtility.GenderListPrepare, true)
CoD.PlayerRoleUtility.HeadListPrepare = function(f21_arg0)
	local f21_local0 = CoD.PlayerRoleUtility.customizationMode
	local f21_local1 = Engine[0x947EEAE452D2DC9](f21_local0, Engine[0x353F5BE07C3EB](f21_arg0, f21_local0))
	local f21_local2 = {}
	for f21_local6, f21_local7 in ipairs(f21_local1) do
		table.insert(f21_local2, {
			models = {
				name = f21_local7.displayName,
				headExtraCamInfo = "" .. CoD.PlayerRoleUtility.customizationMode .. ";" .. f21_local7.headIndex .. ";" .. f21_arg0,
			},
			properties = {
				headIndex = f21_local7.headIndex,
			},
		})
	end
	return f21_local2
end
DataSources.HeroFaceButtonList = DataSourceHelpers.ListSetup("HeroFaceButtonList", CoD.PlayerRoleUtility.HeadListPrepare, true)
CoD.PlayerRoleUtility.GetPositionRoleDefaultInfo = function(f22_arg0, f22_arg1)
	local f22_local0 = Engine[0xE6A05FAABDB1597](f22_arg0, f22_arg1)
	local f22_local1 = f22_local0.primarygrenade
	local f22_local2 = f22_local0.herogadget
	local f22_local3
	if f22_local1 then
		f22_local3 = Engine[0xD97229B24C685D5](f22_local1.refHash, f22_arg0)
		if not f22_local3 then
		else
			local f22_local4
			if f22_local2 then
				f22_local4 = Engine[0xD97229B24C685D5](f22_local2.refHash, f22_arg0)
				if not f22_local4 then
				else
					local f22_local5 = {}
					local f22_local6 = {}
					local f22_local7
					if f22_local1 then
						f22_local7 = f22_local1.displayName
						if not f22_local7 then
						else
							f22_local6.displayName = f22_local7
							if f22_local1 then
								f22_local7 = f22_local1.description
								if not f22_local7 then
								else
									f22_local6.description = f22_local7
									if f22_local1 then
										f22_local7 = f22_local1.image
										if not f22_local7 then
										else
											f22_local6.image = f22_local7
											if f22_local1 then
												f22_local7 = f22_local1.refHash
												if not f22_local7 then
												else
													f22_local6.refHash = f22_local7
													f22_local6.itemIndex = f22_local3
													f22_local6.isRestricted = Engine[0x23577A128ED85F3](f22_local3, false)
													f22_local5.equipment = f22_local6
													f22_local6 = {}
													if f22_local2 then
														f22_local7 = f22_local2.displayName
														if not f22_local7 then
														else
															f22_local6.displayName = f22_local7
															if f22_local2 then
																f22_local7 = f22_local2.description
																if not f22_local7 then
																else
																	f22_local6.description = f22_local7
																	if f22_local2 then
																		f22_local7 = f22_local2.image
																		if not f22_local7 then
																		else
																			f22_local6.image = f22_local7
																			if f22_local2 then
																				f22_local7 = f22_local2.refHash
																				if not f22_local7 then
																				else
																					f22_local6.refHash = f22_local7
																					f22_local6.itemIndex = f22_local4
																					f22_local6.isRestricted = Engine[0x23577A128ED85F3](f22_local4, false)
																					f22_local5.ability = f22_local6
																					return f22_local5
																				end
																			end
																			f22_local7 = 0x0
																		end
																	end
																	f22_local7 = 0x7615068F50B3D66
																end
															end
															f22_local7 = 0x0
														end
													end
													f22_local7 = 0x0
												end
											end
											f22_local7 = 0x0
										end
									end
									f22_local7 = 0x7615068F50B3D66
								end
							end
							f22_local7 = 0x0
						end
					end
					f22_local7 = 0x0
				end
			end
			f22_local4 = 0
		end
	end
	f22_local3 = 0
end
CoD.PlayerRoleUtility.ZMHiddenFrontendPositionRoles = {
	[0x6BC80636F0FDAC4] = true,
	[0x6B92E1337B43236] = true,
	[0xBCEBDF1BEF33311] = true,
	[0xDF0037E3F390B15] = true,
	[0x4CB4663E341A940] = true,
	[0x8AA6812C38263BA] = true,
	[0x3D71FF1E886BBE9] = true,
	[0xFD4157DCAFC6E45] = true,
}
CoD.PlayerRoleUtility.ZMMapHiddenFrontendPositionRoles = {
	[0x15977E191D13967] = {
		0xA005252D762E06A,
	},
	[0xC0932FA55EE6E5B] = {
		0xA005252D762E06A,
	},
	[0xE8F51EC275A4A38] = {
		0xA005252D762E06A,
	},
	[0xEBF024E1559C04A] = {
		0xA005252D762E06A,
	},
}
CoD.PlayerRoleUtility.WeaponSchemaOverrideKBM = {
	[0x20EBBC5F603E4D4] = 0x120CDB8FEDDBFCB,
	[0x95DA416D84F50C] = 0xB33D070E5D24B3,
}
CoD.PlayerRoleUtility.SetWeaponSchemaString = function(f23_arg0, f23_arg1, f23_arg2)
	return IsMouseOrKeyboard(f23_arg1) and CoD.PlayerRoleUtility.WeaponSchemaOverrideKBM[f23_arg2] or f23_arg2
end
CoD.PlayerRoleUtility.GetCharacterIndexForClientNum = function(f24_arg0, f24_arg1)
	return Engine[0x40145EEB2E913D2](f24_arg0, f24_arg1)
end
CoD.PlayerRoleUtility.CanSetAsShowcaseCharacter = function(f25_arg0, f25_arg1)
	return not CoD.ModelUtility.IsSelfModelValueTrue(f25_arg1, f25_arg0, "isBMLocked")
end
DataSources.PositionLoadoutList = ListHelper_SetupDataSource("PositionLoadoutList", function(f26_arg0, f26_arg1)
	local f26_local0 = {}
	local f26_local1 = Engine[0x3EAC408F958FF05]()
	if f26_arg1.menu and CoD.BaseUtility.GetMenuSessionMode(f26_arg1.menu) then
		f26_local1 = CoD.BaseUtility.GetMenuSessionMode(f26_arg1.menu)
	end
	local f26_local2 = f26_arg1.menu._selectIndex
	if not f26_local2 then
		f26_local2 = Engine[0x1DC6357002DC122](f26_arg0, f26_local1)
	end
	local f26_local3 = DataSources.CharacterBreadcrumbs.recreateCharacterBreadcrumbModelsIfNeeded(f26_arg0, f26_local1)
	local f26_local4 = CoD.PlayerStatsUtility.GetStorageBufferForPlayer(f26_arg0) or {}
	return CoD.PlayerRoleUtility.GetPlayerRolesListHelper(f26_arg1, f26_arg0, f26_local1, function(f27_arg0, f27_arg1, f27_arg2, f27_arg3, f27_arg4)
		local f27_local0 = f27_arg4.models.characterIndex
		if CoD.isFrontend and CoD.isZombie and f27_arg2 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
			local f27_local1 = Engine[0x82C5756563934AE](f27_arg2, f27_local0)
			local f27_local2 = function(f28_arg0)
				if CoD.PlayerRoleUtility.ZMHiddenFrontendPositionRoles[f28_arg0] then
					return true
				end
				local f28_local0 = CoD.PlayerRoleUtility.ZMMapHiddenFrontendPositionRoles[f28_arg0]
				if f28_local0 then
					for f28_local4, f28_local5 in ipairs(f28_local0) do
						if Engine[0xC3C68A8BA45A52D](f28_local5) then
							return false
						end
					end
					return true
				end
				return false
			end
			if f27_local2(f27_local1) then
				return false
			end
		end
		local f27_local1 = f27_arg4.properties.character
		local f27_local3 = CoD.PlayerRoleUtility.GetPositionRoleDefaultInfo(f27_arg2, f27_local0)
		if f27_arg4.properties.character[0x810366D1F05BBBD] and not CoD.BaseUtility.IsDvarEnabled(f27_arg4.properties.character[0x810366D1F05BBBD]) then
			return false
		elseif CoD.PlayerRoleUtility.IsRoleBMUnavailable(f27_arg1, f27_arg2, f27_local0) then
			return false
		end
		f27_arg4.models.isBMLocked = CoD.PlayerRoleUtility.IsRoleBMLocked(f27_arg1, f27_arg2, f27_local0)
		f27_arg4.models.noContextWidget = true
		f27_arg4.models.previewEnabled = f27_arg2 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5]
		f27_arg4.models.detailedDesc = Engine[0xF9F1239CFD921FE](CoD.PlayerRoleUtility.GetCharacterTraitSummary(f27_arg2, f27_local0))
		f27_arg4.models.breadcrumb = f26_local3[CoD.BreadcrumbUtility.CharacterBreadcrumbModelPrefixTable[f27_arg2] .. f27_local0]
		f27_arg4.properties.selectIndex = f26_local2 == f27_local0
		f27_arg4.models.isRestricted = CoD.CACUtility.IsItemIndexRestricted(f27_local3.equipment.itemIndex)
		f27_arg4.models.requiredDvar = f27_arg4.properties.character[0x810366D1F05BBBD]
		f27_arg4.models.bio = f27_local1[0x541919134FDFF1] or 0x0
		f27_arg4.models.bioHeader = f27_local1[0x668EA0FEF74A8D4] or 0x0
		f27_arg4.models.bioHeaderImage = f27_local1[0x15AC9DAAD709DE1] or 0x7615068F50B3D66
		f27_arg4.models.brandingImage = f27_local1[0xB2781A0B1BF2B7A] or 0x7615068F50B3D66
		f27_arg4.models.equipment = f27_local3.equipment
		f27_arg4.models.equipment.statValue = CoD.GetCombatRecordStatFromArgPath(f26_local4, 0x62F9B6A10FA7D66, f27_local3.equipment.refHash, 0xFADC643DBA6DBF2)
		f27_arg4.models.equipment.statTitle = f27_local1[0xE5D532BF7F3B6CF]
		f27_arg4.models.weaponHeaderImage = f27_local1[0xA923C4F85EF2BB1] or 0x7615068F50B3D66
		f27_arg4.models.weaponValue = CoD.GetCombatRecordStatFromArgPath(f26_local4, 0xD59E8BFAC78A33B, f27_local1[0x6F1AB17EE1FC9A3], 0x3BF77799B56C06C)
		f27_arg4.models.weaponSchema = f27_local1[0x2231AE94A1F7E22]
		f27_arg4.models.weaponMovie = {
			stillPreview = f27_local1[0x628C417CD81F2EF],
			lowResVideo = {
				movieName = f27_local1[0xBEAF31C99615565],
				isStreamed = f27_local1[0xA03B8EE98FB2C3C] ~= 0,
				isLooping = true,
			},
			hiResVideo = {
				movieName = f27_local1[0xFBBA1DF8FF319C8],
				isStreamed = f27_local1[0x47ED06FF5BD1C9] ~= 0,
				isLooping = true,
			},
		}
		f27_arg4.models.ability = f27_local3.ability
		f27_arg4.models.ability.statValue = CoD.GetCombatRecordStatFromArgPath(f26_local4, 0x62F9B6A10FA7D66, f27_local3.ability.refHash, 0xFADC643DBA6DBF2)
		f27_arg4.models.ability.statTitle = f27_local1[0xF8D5FE32C560DA2]
		f27_arg4.models.specialIssueSchema = f27_local1[0xEB140A2F390287C]
		f27_arg4.models.specialIssueMovie = {
			stillPreview = f27_local1[0x50B2C3997AE3F1],
			lowResVideo = {
				movieName = f27_local1[0x7C51D1E674D2017],
				isStreamed = f27_local1[0xEB7D2E73B168DF6] ~= 0,
				isLooping = true,
			},
			hiResVideo = {
				movieName = f27_local1[0xBEC19FE390B9682],
				isStreamed = f27_local1[0x5932B79A4D639BB] ~= 0,
				isLooping = true,
			},
		}
		f27_arg4.models.tipsMovie = {
			stillPreview = f27_local1[0x96F2EF68C44B161],
			lowResVideo = {
				movieName = f27_local1[0x31DFD147586991B],
				isStreamed = f27_local1[0xACF3E87A62C59A2] ~= 0,
				isLooping = true,
			},
			hiResVideo = {
				movieName = f27_local1[0x1AD03E44598DCAA],
				isStreamed = f27_local1[0x9B117DE4840DFD3] ~= 0,
				isLooping = true,
			},
		}
		return true
	end)
end, false)
CoD.PlayerRoleUtility.DisableVideoPlayer = function(f29_arg0, f29_arg1)
	if not CoD.ModelUtility.IsSelfModelValueNonEmptyString(f29_arg0, f29_arg1, "lowResVideo.movieName") then
		return true
	else
		return false
	end
end
CoD.PlayerRoleUtility.OpenPersonalizeCharacterFromCharacter = function(f30_arg0, f30_arg1, f30_arg2)
	OpenOverlay(f30_arg0, "PersonalizeCharacter", f30_arg2, {
		model = f30_arg1:getModel(),
		properties = {
			_sessionMode = f30_arg0._sessionMode,
		},
	})
end
CoD.PlayerRoleUtility.HasCustomization = function(f31_arg0, f31_arg1)
	if IsLobbyNetworkModeLAN() then
		return false
	end
	local f31_local0 = #f31_arg1.outfits > 1
	if not f31_local0 then
		for f31_local9, f31_local10 in ipairs(CoDLoadoutsShared.characterCustomizationRegions) do
			if f31_local10.usedForPersonalizationPrompt then
				for f31_local7, f31_local8 in ipairs(f31_arg1.outfits[1][f31_local10.name]) do
					if f31_local7 > 1 and f31_local8.isValid then
						f31_local0 = true
						break
					end
				end
				if f31_local0 then
				end
			end
		end
	end
	return f31_local0
end
DataSources.MPSpecialistHUBOptions = ListHelper_SetupDataSource("MPSpecialistHUBOptions", function(f32_arg0, f32_arg1)
	local f32_local0 = {}
	local f32_local1 = Engine[0x3EAC408F958FF05]()
	local f32_local2 = f32_arg1.menu:getModel()
	if not f32_local2 then
		f32_local2 = f32_arg1.menu._model
	end
	local f32_local3 = CoD.SafeGetModelValue(f32_local2, "characterIndex")
	if not f32_local3 then
		f32_local3 = f32_arg1.menu._selectIndex
	end
	local f32_local4 = CoD.PlayerRoleUtility.HasCustomization(f32_arg0, CoD.PlayerRoleUtility.GetCachedHeroCustomization(f32_local1, f32_local3))
	local f32_local5 = CoD.BreadcrumbUtility.GetStorageLoadoutBufferForPlayer(f32_arg0, f32_local1)
	local f32_local6 = DataSources.SprayGestureBreadcrumbs.getModel(f32_arg0)
	local f32_local7 = DataSources.SpecialistOutfitBreadcrumbs.getBreadcrumbModelForCharacter(f32_arg0, f32_local1, f32_local3)
	if f32_local1 ~= Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] or f32_local2 and f32_local2.customizationMode:get() ~= Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] and (IsBooleanDvarSet(0x95DD5258AC4E66B) or f32_local2.customizationMode:get() ~= Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A]) then
		if f32_local4 then
			table.insert(f32_local0, {
				models = {
					name = 0xAEABC7E65D1B259,
					breadcrumb = f32_local7.outfits,
				},
				properties = {
					action = function(f33_arg0, f33_arg1, f33_arg2, f33_arg3, f33_arg4)
						OpenOverlay(f33_arg4, "PersonalizeCharacter", f33_arg2, {
							model = f32_arg1.menu._model or f32_local2,
							properties = {
								_storageLoadoutBuffer = f32_local5,
								_sessionMode = f32_local1,
							},
						})
					end,
				},
			})
		end
	elseif f32_local1 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] and f32_local2 and f32_local2.isDefaultCharacter:get() then
		table.insert(f32_local0, {
			models = {
				name = 0xF5CA503839CA925,
			},
			properties = {
				action = function(f34_arg0, f34_arg1, f34_arg2, f34_arg3, f34_arg4)
					OpenOverlay(f34_arg4, "PersonalizeDefaultWZCharacter", f34_arg2, nil)
				end,
			},
		})
	end
	table.insert(f32_local0, {
		models = {
			name = 0xB825BF2939A8267,
			breadcrumb = f32_local6.gestures,
		},
		properties = {
			action = function(f35_arg0, f35_arg1, f35_arg2, f35_arg3, f35_arg4)
				OpenOverlay(f35_arg4, "MPSpecialistHUBGestures", f35_arg2, {
					model = f32_arg1.menu._model or f32_local2,
					properties = {
						_storageLoadoutBuffer = f32_local5,
						_sessionMode = f32_local1,
					},
				})
			end,
		},
	})
	table.insert(f32_local0, {
		models = {
			name = 0x13A845278D53F22,
			breadcrumb = f32_local6.totaltags,
		},
		properties = {
			action = function(f36_arg0, f36_arg1, f36_arg2, f36_arg3, f36_arg4)
				OpenOverlay(f36_arg4, "MPSpecialistHUBTags", f36_arg2, {
					model = f32_arg1.menu._model or f32_local2,
					properties = {
						_storageLoadoutBuffer = f32_local5,
						_sessionMode = f32_local1,
					},
				})
			end,
		},
	})
	if f32_local1 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] and IsBooleanDvarSet(0x9CF9B57D5140714) then
		table.insert(f32_local0, {
			models = {
				name = 0x2A8D9058AD56819,
				breadcrumb = DataSources.JumpkitBreadcrumbs.getModel(f32_arg0),
			},
			properties = {
				action = function(f37_arg0, f37_arg1, f37_arg2, f37_arg3, f37_arg4)
					OpenOverlay(f37_arg4, "WZJumpKitSelector", f37_arg2, {
						model = f32_arg1.menu._model or f32_local2,
						properties = {
							_storageLoadoutBuffer = f32_local5,
							_sessionMode = f32_local1,
						},
					})
				end,
			},
		})
	end
	return f32_local0
end, true)
CoD.PlayerRoleUtility.GetCharacterDisplayNameByIndex = function(f38_arg0, f38_arg1)
	if f38_arg0 == nil then
		return 0x0
	end
	local f38_local0 = CoD.PlayerRoleUtility.GetCachedHeroInfo(f38_arg1, f38_arg0)
	if f38_local0 == nil then
		return 0x0
	elseif f38_arg1 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		local f38_local1 = Engine[0xB678B832BC9DC0](f38_arg1, f38_arg0)
		if f38_local1[0xC9366DE09ED7379] == 1 then
			return 0x0
		end
	end
	return f38_local0.displayName
end
DataSourceHelpers.PerControllerDataSourceSetup("PositionEditLoadout", "PositionEditLoadout", function(f39_arg0, f39_arg1)
	local f39_local0 = CoD.PlayerRoleUtility.GetSelectedCharacterIndex(f39_arg1)
	local f39_local1 = CoD.PlayerRoleUtility.customizationMode
	if not f39_local1 then
		f39_local1 = Engine[0x3EAC408F958FF05]()
	end
	local f39_local2 = f39_arg0:create("characterIndex")
	f39_local2:set(f39_local0)
	f39_local2 = f39_arg0:create("name")
	f39_local2:set(CoD.PlayerRoleUtility.GetCharacterDisplayNameByIndex(f39_local0, f39_local1))
	f39_local2 = nil
	if f39_local0 == nil then
		f39_local2 = 0
	else
		f39_local2 = Engine[0x6C0CB7BD099633F](f39_local1, f39_local0)
	end
	local f39_local3 = f39_arg0:create("classModel")
	CoD.CACUtility.GetCustomClassModel(f39_arg1, f39_local2, f39_local3, nil, f39_local1)
	CoD.perController[f39_arg1].classModel = f39_local3
end)
CoD.PlayerRoleUtility.CreateOutfitsForTheme = function(f40_arg0, f40_arg1, f40_arg2, f40_arg3, f40_arg4, f40_arg5)
	local f40_local0 = "ThemeOutfit" .. f40_arg3
	DataSources[f40_local0] = DataSourceHelpers.ListSetup(f40_local0, function(f41_arg0, f41_arg1)
		local f41_local0 = {}
		for f41_local15, f41_local16 in ipairs(f40_arg4.presets) do
			if f41_local16.isValid then
				local f41_local4 = CoD.BlackMarketTableUtility.LootInfoLookup(f41_arg0, f41_local16.lootId)
				local f41_local5 = f41_local16.entitlement
				if f41_local5 then
					f41_local5 = f41_local16.entitlement ~= 0x0
				end
				local f41_local6 = ""
				local f41_local7 = true
				for f41_local8 = 0, Enum[0xFCC6A2D2EB0FDA7][0x997A52C773DD143] - 1, 1 do
					local f41_local11 = nil
					if f41_local8 == Enum[0xFCC6A2D2EB0FDA7][0x41B42F0A58AC50F] then
						f41_local11 = f41_local16.arms
					elseif f41_local8 == Enum[0xFCC6A2D2EB0FDA7][0x7AD40A4111A72FE] then
						f41_local11 = f41_local16.head
					elseif f41_local8 == Enum[0xFCC6A2D2EB0FDA7][0xFF8573E011622F4] then
						f41_local11 = f41_local16.headgear
					elseif f41_local8 == Enum[0xFCC6A2D2EB0FDA7][0x83CBB806B732B11] then
						f41_local11 = f41_local16.legs
					elseif f41_local8 == Enum[0xFCC6A2D2EB0FDA7][0x922FE5C41D9EE8B] then
						f41_local11 = f41_local16.palette
					elseif f41_local8 == Enum[0xFCC6A2D2EB0FDA7][0x9DDCEC39BA98B97] then
						f41_local11 = f41_local16.torso
					end
					if f41_local11 and f41_local7 then
						f41_local7 = f41_local11 == CoD.PlayerRoleUtility.EquippedOutfitItems[f41_arg0][0xBF0EE676636AA4F][f40_arg3][f41_local8]
					end
					f41_local6 = f41_local6 .. (f41_local11 or 0) .. ";"
				end
				local f41_local8 = f41_local4.unlockInfo
				if not f41_local8 then
					f41_local8 = ""
				end
				local f41_local9 = ""
				if f41_local4.isLoot and f41_local4.available and f41_local4.disableWhenAvailable and not f41_local4.owned then
					f41_local9 = f41_local8
					f41_local8 = ""
				end
				local f41_local10 = table.insert
				local f41_local12 = f41_local0
				local f41_local11 = {}
				local f41_local13 = {
					displayName = Engine[0xF9F1239CFD921FE](f41_local16.displayName),
					icon = f41_local16.icon,
					outfitIndex = f40_arg3,
					itemType = Enum[0xFCC6A2D2EB0FDA7][0x922FE5C41D9EE8B],
					itemIndex = f41_local16.palette,
					lootId = f41_local16.lootId,
				}
				local f41_local14 = CoD.BlackMarketUtility.LootIdRarities[f41_local4.rarity]
				if not f41_local14 then
					f41_local14 = Enum[0x704F69F9B0BDCEC][0x8556B83CAD0D180]
				end
				f41_local13.rarity = f41_local14
				f41_local13.category = 0x7B3BEA931147DB0
				f41_local13.unlockInfo = f41_local8
				f41_local13.alertMessage = f41_local9
				f41_local14 = f41_local4.available
				if not f41_local14 then
					f41_local14 = not f41_local4.isLoot
				end
				f41_local13.available = f41_local14
				f41_local14 = f41_local4.owned
				if not f41_local14 then
					f41_local14 = not f41_local4.isLoot
				end
				f41_local13.owned = f41_local14
				f41_local14 = f40_arg5
				if not f41_local14 then
					f41_local14 = f41_local4.available
					if f41_local14 then
						f41_local14 = f41_local4.disableWhenAvailable
					end
				end
				f41_local13.disabled = f41_local14
				f41_local13.skipDefaultTitle = f41_local4.isNotDefault
				f41_local14 = f41_local4.hideRarity
				if not f41_local14 then
					f41_local14 = f41_local5 or false
				end
				f41_local13.hideRarity = f41_local14
				f41_local13.presets = f41_local6
				f41_local13.arms = f41_local16.arms
				f41_local13.head = f41_local16.head
				f41_local13.headgear = f41_local16.headgear
				f41_local13.legs = f41_local16.legs
				f41_local13.palette = f41_local16.palette
				f41_local13.torso = f41_local16.torso
				f41_local13.presetIndex = f41_local15 - 1
				f41_local13.checkEquippedOutfit = true
				f41_local11.models = f41_local13
				f41_local11.properties = {
					selectIndex = f41_local7,
					entitlement = f41_local16.entitlement,
					accessoryCount = 0,
					lootData = f41_local4,
				}
				f41_local11.options = {}
				f41_local10(f41_local12, f41_local11)
			end
		end
		f41_local1 = {}
		for f41_local5, f41_local6 in
			LUI.IterateTableBySortedKeys(f41_local0, function(f42_arg0, f42_arg1)
				f42_arg0 = f41_local0[f42_arg0]
				f42_arg1 = f41_local0[f42_arg1]
				if f42_arg0.properties.owned ~= f42_arg1.properties.owned then
					return f42_arg0.properties.owned
				elseif f42_arg0.properties.available ~= f42_arg1.properties.available then
					return f42_arg0.properties.available
				else
					return f42_arg0.models.itemIndex < f42_arg1.models.itemIndex
				end
			end, function(f43_arg0, f43_arg1)
				if f43_arg1.properties.lootData.isLoot then
					local f43_local0 = f43_arg1.properties.lootData.owned
					if not f43_local0 then
						f43_local0 = f43_arg1.properties.lootData.available
						if f43_local0 then
							f43_local0 = f43_arg1.properties.lootData.disableWhenAvailable
						end
					end
					return f43_local0
				else
					local f43_local0
					if f43_arg1.properties.entitlement ~= 0x0 then
						f43_local0 = Engine[0xB521CB398C92692](f41_arg0, f43_arg1.properties.entitlement)
					else
						f43_local0 = true
					end
				end
				return f43_local0
			end)
		do
			table.insert(f41_local1, f41_local6)
		end
		return f41_local1
	end, true)
	return f40_local0
end
CoD.PlayerRoleUtility.CreateDecalsForTheme = function(f44_arg0, f44_arg1, f44_arg2, f44_arg3, f44_arg4)
	if #f44_arg4.decals <= 1 then
		return ""
	else
		local f44_local0 = "ThemeDecals" .. f44_arg3
		DataSources[f44_local0] = DataSourceHelpers.ListSetup(f44_local0, function(f45_arg0, f45_arg1)
			local f45_local0 = {}
			for f45_local10, f45_local11 in ipairs(f44_arg4.decals) do
				if f45_local11.isValid then
					local f45_local4 = CoD.BlackMarketTableUtility.LootInfoLookup(f45_arg0, f45_local11.lootId)
					local f45_local5 = table.insert
					local f45_local6 = f45_local0
					local f45_local7 = {}
					local f45_local8 = {
						displayName = Engine[0xF9F1239CFD921FE](f45_local11.displayName),
						icon = f45_local11.image,
						outfitIndex = f44_arg3,
						itemType = Enum[0xFCC6A2D2EB0FDA7][0x7852FCB3BFCC8D1],
						itemIndex = f45_local10 - 1,
					}
					local f45_local9 = CoD.BlackMarketUtility.LootIdRarities[f45_local4.rarity]
					if not f45_local9 then
						f45_local9 = Enum[0x704F69F9B0BDCEC][0x8556B83CAD0D180]
					end
					f45_local8.rarity = f45_local9
					f45_local8.category = 0x8A92677478F2E1B
					f45_local8.unlockInfo = f45_local4.unlockInfo or ""
					f45_local9 = f45_local4.available
					if not f45_local9 then
						f45_local9 = not f45_local4.isLoot
					end
					f45_local8.available = f45_local9
					f45_local9 = f45_local4.owned
					if not f45_local9 then
						f45_local9 = not f45_local4.isLoot
					end
					f45_local8.owned = f45_local9
					f45_local8.skipDefaultTitle = f45_local4.isNotDefault
					f45_local8.hideRarity = f45_local4.hideRarity or false
					f45_local8.presets = ""
					f45_local8.presetIndex = -1
					f45_local8.checkEquippedOutfit = true
					f45_local7.models = f45_local8
					f45_local7.properties = {
						selectIndex = f45_local10 - 1 == CoD.PlayerRoleUtility.EquippedOutfitItems[f45_arg0][0xBF0EE676636AA4F][f44_arg3][Enum[0xFCC6A2D2EB0FDA7][0x7852FCB3BFCC8D1]],
						lootData = f45_local4,
						lootId = f45_local11.lootId,
					}
					f45_local5(f45_local6, f45_local7)
				end
			end
			f45_local1 = {}
			for f45_local5, f45_local6 in
				LUI.IterateTableBySortedKeys(f45_local0, function(f46_arg0, f46_arg1)
					f46_arg0 = f45_local0[f46_arg0]
					f46_arg1 = f45_local0[f46_arg1]
					if f46_arg0.properties.owned ~= f46_arg1.properties.owned then
						return f46_arg0.properties.owned
					elseif f46_arg0.properties.available ~= f46_arg1.properties.available then
						return f46_arg0.properties.available
					else
						return f46_arg0.models.itemIndex < f46_arg1.models.itemIndex
					end
				end, function(f47_arg0, f47_arg1)
					if f47_arg1.properties.lootData.isLoot then
						return f47_arg1.properties.lootData.owned
					else
						return true
					end
				end)
			do
				table.insert(f45_local1, f45_local6)
			end
			return f45_local1
		end, true)
		return f44_local0
	end
end
CoD.PlayerRoleUtility.CreateWarPaintsForTheme = function(f48_arg0, f48_arg1, f48_arg2, f48_arg3, f48_arg4, f48_arg5)
	local f48_local0 = "ThemeWarPaints" .. f48_arg3
	DataSources[f48_local0] = DataSourceHelpers.ListSetup(f48_local0, function(f49_arg0, f49_arg1)
		local f49_local0 = {}
		for f49_local10, f49_local11 in ipairs(f48_arg4.warPaints) do
			if f49_local10 > 1 and f49_local11.isValid then
				local f49_local4 = CoD.PlayerRoleUtility.LookupLootForWarPaint(f49_arg0, f49_local11, f48_arg4.presets)
				local f49_local5 = table.insert
				local f49_local6 = f49_local0
				local f49_local7 = {}
				local f49_local8 = {
					displayName = Engine[0xF9F1239CFD921FE](f49_local11.displayName),
					icon = f49_local11.image,
					outfitIndex = f48_arg3,
					itemType = Enum[0xFCC6A2D2EB0FDA7][0x8E3A65D78229DC1],
					itemIndex = f49_local10 - 1,
					lootId = f49_local11.lootId,
				}
				local f49_local9 = CoD.BlackMarketUtility.LootIdRarities[f49_local4.rarity]
				if not f49_local9 then
					f49_local9 = Enum[0x704F69F9B0BDCEC][0x8556B83CAD0D180]
				end
				f49_local8.rarity = f49_local9
				f49_local8.category = 0x1ADD4C3535DC47
				f49_local8.unlockInfo = f49_local4.unlockInfo or ""
				f49_local9 = f49_local4.available
				if not f49_local9 then
					f49_local9 = not f49_local4.isLoot
				end
				f49_local8.available = f49_local9
				f49_local9 = f49_local4.owned
				if not f49_local9 then
					f49_local9 = not f49_local4.isLoot
				end
				f49_local8.owned = f49_local9
				f49_local8.skipDefaultTitle = f49_local4.isNotDefault
				f49_local8.hideRarity = f49_local4.hideRarity or false
				f49_local8.presets = ""
				f49_local8.presetIndex = -1
				f49_local8.checkEquippedOutfit = true
				f49_local7.models = f49_local8
				f49_local7.properties = {
					selectIndex = f49_local10 - 1 == CoD.PlayerRoleUtility.EquippedOutfitItems[f49_arg0][0xBF0EE676636AA4F][f48_arg3][Enum[0xFCC6A2D2EB0FDA7][0x8E3A65D78229DC1]],
					lootData = f49_local4,
					entitlement = f49_local11.entitlement,
				}
				f49_local5(f49_local6, f49_local7)
			end
		end
		f49_local1 = {}
		for f49_local5, f49_local6 in
			LUI.IterateTableBySortedKeys(f49_local0, function(f50_arg0, f50_arg1)
				f50_arg0 = f49_local0[f50_arg0]
				f50_arg1 = f49_local0[f50_arg1]
				if f50_arg0.properties.owned ~= f50_arg1.properties.owned then
					return f50_arg0.properties.owned
				elseif f50_arg0.properties.available ~= f50_arg1.properties.available then
					return f50_arg0.properties.available
				else
					return f50_arg0.models.itemIndex < f50_arg1.models.itemIndex
				end
			end, function(f51_arg0, f51_arg1)
				if f51_arg1.properties.lootData.isLoot then
					return f51_arg1.properties.lootData.owned
				else
					local f51_local0
					if f51_arg1.properties.entitlement and f51_arg1.properties.entitlement ~= 0x0 then
						f51_local0 = Engine[0xB521CB398C92692](f49_arg0, f51_arg1.properties.entitlement)
					else
						f51_local0 = true
					end
				end
				return f51_local0
			end)
		do
			table.insert(f49_local1, f49_local6)
		end
		return f49_local1
	end, true)
	return f48_local0
end
CoD.PlayerRoleUtility.IsPaletteOwned = function(f52_arg0, f52_arg1)
	local f52_local0 = CoD.BlackMarketTableUtility.LootInfoLookup(f52_arg0, f52_arg1.lootId)
	if f52_local0.isLoot then
		return f52_local0.owned
	else
		local f52_local1
		if f52_arg1.entitlement ~= 0x0 then
			f52_local1 = Engine[0xB521CB398C92692](f52_arg0, f52_arg1.entitlement)
		else
			f52_local1 = true
		end
	end
	return f52_local1
end
CoD.PlayerRoleUtility.IsPresetOwned = function(f53_arg0, f53_arg1)
	local f53_local0, f53_local1 = CoD.BlackMarketTableUtility.SimpleLootLookup(f53_arg0, f53_arg1.lootId, f53_arg1.entitlement)
	local f53_local2
	if f53_local0 ~= CoD.BlackMarketTableUtility.SimpleLootLookupTypes[0xC0D17BAD169557B] then
		f53_local2 = f53_local1
	else
		f53_local2 = true
	end
	return f53_local2
end
CoD.PlayerRoleUtility.LookupLootForWarPaint = function(f54_arg0, f54_arg1, f54_arg2)
	local f54_local0 = CoD.BlackMarketTableUtility.LootInfoLookup(f54_arg0, f54_arg1.lootId)
	if not f54_local0.isLoot then
		for f54_local4, f54_local5 in ipairs(f54_arg2) do
			if f54_local5.matchedWarPaintLootId == f54_arg1.lootId then
				f54_local0 = CoD.BlackMarketTableUtility.LootInfoLookup(f54_arg0, f54_local5.lootId)
				break
			end
		end
	end
	return f54_local0
end
CoD.PlayerRoleUtility.IsWarPaintOwned = function(f55_arg0, f55_arg1, f55_arg2)
	if not f55_arg1.isValid then
		return false
	end
	local f55_local0, f55_local1 = CoD.BlackMarketTableUtility.SimpleLootLookup(f55_arg0, f55_arg1.lootId, f55_arg1.entitlement)
	if f55_local0 ~= CoD.BlackMarketTableUtility.SimpleLootLookupTypes[0xC0D17BAD169557B] then
		return f55_local1
	end
	for f55_local5, f55_local6 in ipairs(f55_arg2) do
		if f55_local6.matchedWarPaintLootId == f55_arg1.lootId then
			return CoD.PlayerRoleUtility.IsPresetOwned(f55_arg0, f55_local6)
		end
	end
	return true
end
DataSources.MPSpecialistThemes = DataSourceHelpers.ListSetup(
	"MPSpecialistThemes",
	function(f56_arg0, f56_arg1)
		local f56_local0 = f56_arg1.menu:getModel()
		local f56_local1 = f56_local0.characterIndex:get()
		local f56_local2 = Engine[0x3EAC408F958FF05]()
		local f56_local3 = {}
		local f56_local4 = CoD.PlayerRoleUtility.GetCachedHeroCustomization(f56_local2, f56_local1)
		CoD.PlayerRoleUtility.EquippedOutfitItems[f56_arg0] = Engine[0x823ED148924D7BD](f56_arg0, f56_local2, f56_local1) or {}
		local f56_local5 = DataSources.MPOutfitCategories.getModel(f56_arg0)
		f56_local5 = f56_local5.selectedCategory
		if not f56_arg1._selectedCategorySub then
			f56_arg1._selectedCategorySub = f56_arg1:subscribeToModel(f56_local5, function()
				f56_arg1:updateDataSource()
			end, false)
		end
		local f56_local6 = DataSources.MPSpecialistThemes.getCurrentCategoryHelper(f56_arg0, f56_local4, f56_local2, f56_local1)
		if f56_local6 then
			local f56_local7 = {}
			local f56_local8 = true
			for f56_local16, f56_local17 in LUI.IterateTableBySortedKeys(f56_local4.outfits, f56_local6.sort, f56_local6.filter) do
				f56_local8 = true
				if f56_local7[f56_local17.displayName] then
					f56_local8 = false
				end
				if f56_local8 then
					local f56_local12 = f56_local16 - 1
					local f56_local13 = f56_local6.getBreadcrumbModel(f56_local12)
					local f56_local14 = f56_local6.lookupHighestRarity(f56_local16, f56_local17)
					local f56_local15 = f56_local6.isDisabled(f56_local17)
					table.insert(f56_local3, {
						models = {
							displayName = Engine[0xF9F1239CFD921FE](f56_local17.displayName),
							datasourceName = f56_local6.dataSourceFunction(f56_arg0, f56_local2, f56_local1, f56_local12, f56_local17, f56_local15),
							decalDataSourceName = f56_local6.decalDataSourceFunction(f56_arg0, f56_local2, f56_local1, f56_local12, f56_local17),
							decalCount = #f56_local17.decals,
							outfitIndex = f56_local12,
							category = 0x4106C155ACE8F96,
							rarity = f56_local14,
							available = true,
							disabled = f56_local15,
							hideRarity = f56_local14 == Enum[0x704F69F9B0BDCEC][0x8556B83CAD0D180],
							unlockInfo = f56_local6.getUnlockInfo(f56_local17),
							alertMessage = f56_local6.getAlertMessage(f56_local17),
							breadcrumb = f56_local13,
						},
						properties = {
							selectIndex = f56_local12 == f56_local6.selectedIndex(),
						},
					})
				end
				f56_local7[f56_local17.displayName] = true
			end
		end
		return f56_local3
	end,
	true,
	{
		getModel = function(f58_arg0)
			local f58_local0 = Engine[0x4DF5CFBC1771947](f58_arg0)
			f58_local0 = f58_local0:create("MPSpecialistThemes")
			if not f58_local0.update then
				f58_local0:create("update")
			end
			return f58_local0
		end,
		getCurrentCategoryHelper = function(f59_arg0, f59_arg1, f59_arg2, f59_arg3)
			local f59_local0 = DataSources.MPOutfitCategories.getModel(f59_arg0)
			local f59_local1 = DataSources.MPSpecialistThemes.getCategoryHelperFunctions[f59_local0.selectedCategory:get()]
			return f59_local1 and f59_local1(f59_arg0, f59_arg1, f59_arg2, f59_arg3)
		end,
		getCategoryHelperFunctions = {
			[0xBD6E1F8964DCE86] = function(f60_arg0, f60_arg1, f60_arg2, f60_arg3)
				local f60_local0 = function(f61_arg0)
					if #f61_arg0.presets == 3 and (f61_arg0.presets[2].lootId == 0xAC40E28D648CB3 or f61_arg0.presets[2].lootId == 0x37D456548D22D4) then
						for f61_local3, f61_local4 in ipairs(f61_arg0.presets) do
							f61_local4.isValid = false
						end
					end
					for f61_local3, f61_local4 in ipairs(f61_arg0.presets) do
						if f61_local4.isValid and CoD.PlayerRoleUtility.IsPresetOwned(f60_arg0, f61_local4) then
							return true
						end
					end
					return false
				end
				local f60_local1 = function(f62_arg0)
					for f62_local4, f62_local5 in ipairs(f62_arg0.presets) do
						if f62_local5.isValid then
							local f62_local3 = CoD.BlackMarketTableUtility.LootInfoLookup(f60_arg0, f62_local5.lootId)
							return f62_local3.available and f62_local3.disableWhenAvailable
						end
					end
					return false
				end
				local f60_local2 = function(f63_arg0, f63_arg1)
					local f63_local0 = Enum[0x704F69F9B0BDCEC][0x8556B83CAD0D180]
					for f63_local5, f63_local6 in ipairs(f63_arg1.presets) do
						local f63_local7 = CoD.BlackMarketTableUtility.LootInfoLookup(f60_arg0, f63_local6.lootId)
						if f63_local7.isLoot then
							local f63_local4 = CoD.BlackMarketUtility.LootIdRarities[f63_local7.rarity]
							if not f63_local4 then
								f63_local4 = Enum[0x704F69F9B0BDCEC][0x8556B83CAD0D180]
							end
							if f63_local4 ~= Enum[0x704F69F9B0BDCEC][0x8556B83CAD0D180] then
								if f63_local0 == Enum[0x704F69F9B0BDCEC][0x8556B83CAD0D180] then
									f63_local0 = f63_local4
								else
									f63_local0 = math.max(f63_local0, f63_local4)
								end
							end
						end
					end
					return f63_local0
				end
				return {
					filter = function(f64_arg0, f64_arg1)
						if not f64_arg1.isValid then
							return false
						end
						local f64_local0 = f60_local0(f64_arg1)
						if not f64_local0 then
							f64_local0 = f60_local1(f64_arg1)
						end
						return f64_local0
					end,
					sort = function(f65_arg0, f65_arg1)
						local f65_local0 = f60_local0(f60_arg1.outfits[f65_arg0])
						if f65_local0 ~= f60_local0(f60_arg1.outfits[f65_arg1]) then
							return f65_local0
						elseif f65_arg0 == 1 then
							return false
						elseif f65_arg1 == 1 then
							return true
						else
							return f60_local2(f65_arg1, f60_arg1.outfits[f65_arg1]) < f60_local2(f65_arg0, f60_arg1.outfits[f65_arg0])
						end
					end,
					lookupHighestRarity = f60_local2,
					selectedIndex = function()
						return CoD.PlayerRoleUtility.EquippedOutfitItems[f60_arg0][0xF7F78E9EBEFCE27]
					end,
					dataSourceFunction = CoD.PlayerRoleUtility.CreateOutfitsForTheme,
					decalDataSourceFunction = CoD.PlayerRoleUtility.CreateDecalsForTheme,
					getBreadcrumbModel = function(f67_arg0)
						return DataSources.SpecialistOutfitBreadcrumbs.getBreadcrumbModelForThemePresetCategory(f60_arg0, f60_arg2, f60_arg3, f67_arg0)
					end,
					getUnlockInfo = function(f68_arg0)
						if f60_local0(f68_arg0) then
							for f68_local4, f68_local5 in ipairs(f68_arg0.presets) do
								if f68_local5.isValid then
									local f68_local3 = CoD.BlackMarketTableUtility.LootInfoLookup(f60_arg0, f68_local5.lootId)
									if f68_local3.available and f68_local3.disableWhenAvailable then
										return f68_local3.unlockInfo or ""
									end
								end
							end
						end
						return ""
					end,
					getAlertMessage = function(f69_arg0)
						if not f60_local0(f69_arg0) then
							for f69_local4, f69_local5 in ipairs(f69_arg0.presets) do
								if f69_local5.isValid then
									local f69_local3 = CoD.BlackMarketTableUtility.LootInfoLookup(f60_arg0, f69_local5.lootId)
									if f69_local3.available and f69_local3.disableWhenAvailable then
										return f69_local3.unlockInfo or ""
									end
								end
							end
						end
						return ""
					end,
					isDisabled = function(f70_arg0)
						return not f60_local0(f70_arg0)
					end,
				}
			end,
			[0xFB8B65946FBF7A2] = function(f71_arg0, f71_arg1, f71_arg2, f71_arg3)
				local f71_local0 = function(f72_arg0, f72_arg1)
					local f72_local0 = Enum[0x704F69F9B0BDCEC][0x8556B83CAD0D180]
					for f72_local5, f72_local6 in ipairs(f72_arg1.warPaints) do
						local f72_local7 = CoD.PlayerRoleUtility.LookupLootForWarPaint(f71_arg0, f72_local6, f72_arg1.presets)
						if f72_local7.isLoot then
							local f72_local4 = CoD.BlackMarketUtility.LootIdRarities[f72_local7.rarity]
							if not f72_local4 then
								f72_local4 = Enum[0x704F69F9B0BDCEC][0x8556B83CAD0D180]
							end
							if f72_local4 ~= Enum[0x704F69F9B0BDCEC][0x8556B83CAD0D180] then
								if f72_local0 == Enum[0x704F69F9B0BDCEC][0x8556B83CAD0D180] then
									f72_local0 = f72_local4
								else
									f72_local0 = math.max(f72_local0, f72_local4)
								end
							end
						end
					end
					return f72_local0
				end
				local f71_local1 = function(f73_arg0)
					local f73_local0 = false
					for f73_local4, f73_local5 in ipairs(f73_arg0.warPaints) do
						if f73_local4 > 1 and CoD.PlayerRoleUtility.IsWarPaintOwned(f71_arg0, f73_local5, f73_arg0.presets) then
							f73_local0 = true
							break
						end
					end
					return f73_local0
				end
				return {
					filter = function(f74_arg0, f74_arg1)
						if not f74_arg1.isValid then
							return false
						else
							return f71_local1(f74_arg1)
						end
					end,
					sort = function(f75_arg0, f75_arg1)
						if f75_arg0 == 1 then
							return false
						elseif f75_arg1 == 1 then
							return true
						else
							return f71_local0(f75_arg1, f71_arg1.outfits[f75_arg1]) < f71_local0(f75_arg0, f71_arg1.outfits[f75_arg0])
						end
					end,
					lookupHighestRarity = f71_local0,
					selectedIndex = function()
						return CoD.PlayerRoleUtility.EquippedOutfitItems[f71_arg0][0xD9FCEAC8FF24CBD]
					end,
					dataSourceFunction = CoD.PlayerRoleUtility.CreateWarPaintsForTheme,
					decalDataSourceFunction = function()
						return ""
					end,
					getBreadcrumbModel = function(f78_arg0)
						return DataSources.SpecialistOutfitBreadcrumbs.getBreadcrumbModelForThemeItemType(f71_arg0, f71_arg2, f71_arg3, f78_arg0, Enum[0xFCC6A2D2EB0FDA7][0x8E3A65D78229DC1])
					end,
					getUnlockInfo = function(f79_arg0)
						return ""
					end,
					getAlertMessage = function(f80_arg0)
						return ""
					end,
					isDisabled = function(f81_arg0)
						return false
					end,
				}
			end,
		},
	}
)
DataSources.MPOutfitCategories = DataSourceHelpers.ListSetup(
	"MPOutfitCategories",
	function(f82_arg0, f82_arg1)
		local f82_local0 = f82_arg1.menu:getModel()
		local f82_local1 = f82_local0.characterIndex:get()
		local f82_local2 = Engine[0x3EAC408F958FF05]()
		local f82_local3 = f82_local0.customizationMode and f82_local0.customizationMode:get() or f82_local2
		local f82_local4 = {}
		if f82_local3 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
			table.insert(f82_local4, {
				models = {
					tabName = 0x3C743FD222BE966,
					category = 0xBD6E1F8964DCE86,
					breadcrumb = DataSources.SpecialistOutfitBreadcrumbs.getBreadcrumbModelForPresetsCategory(f82_arg0, f82_local2, f82_local1),
					camera = "character",
				},
			})
		end
		local f82_local5 = CoD.PlayerRoleUtility.GetCachedHeroCustomization(f82_local2, f82_local1)
		local f82_local6 = false
		for f82_local15, f82_local16 in ipairs(f82_local5.outfits) do
			if f82_local16.isValid then
				for f82_local13, f82_local14 in ipairs(f82_local16.warPaints) do
					if f82_local13 > 1 and CoD.PlayerRoleUtility.IsWarPaintOwned(f82_arg0, f82_local14, f82_local16.presets) then
						f82_local6 = true
						break
					end
				end
			end
			if f82_local6 then
			end
		end
		table.insert(f82_local4, {
			models = {
				tabName = 0x1ADD4C3535DC47,
				disabled = not f82_local6,
				category = 0xFB8B65946FBF7A2,
				breadcrumb = DataSources.SpecialistOutfitBreadcrumbs.getBreadcrumbModelForItemTypeCategory(f82_arg0, f82_local2, f82_local1, Enum[0xFCC6A2D2EB0FDA7][0x8E3A65D78229DC1]),
				camera = "face",
			},
		})
		return f82_local4
	end,
	true,
	{
		getModel = function(f83_arg0)
			local f83_local0 = Engine[0x4DF5CFBC1771947](f83_arg0)
			f83_local0 = f83_local0:create("MPOutfitCategories")
			if not f83_local0.selectedCategory then
				local f83_local1 = f83_local0:create("selectedCategory")
				f83_local1:set(0xBD6E1F8964DCE86)
			end
			return f83_local0
		end,
	}
)
DataSources.WZJumpKitItems = DataSourceHelpers.ListSetup(
	"WZJumpKitItems",
	function(f84_arg0, f84_arg1)
		local f84_local0 = Engine[0xA7E3CD65E63086F](0xC4900FCA46D6C74)
		local f84_local1 = f84_arg1.menu:getModel()
		local f84_local2 = {}
		local f84_local3 = Engine[0xD67CC9D9A0B5948](f84_arg0, Engine[0x3EAC408F958FF05](), Enum[0x8037372CBD17C20][0xBF99C226E97F1DB])
		for f84_local21, f84_local22 in ipairs(f84_local0) do
			local f84_local23 = CoD.BlackMarketTableUtility.LootInfoLookup(f84_arg0, f84_local22[0x28887F70BF5EBA], f84_local22[0x562938AF86028A0])
			local f84_local24 = f84_local23.isLoot or f84_local23.isEntitlement
			if not f84_local24 or f84_local23.owned then
				local f84_local7 = Engine[0xE00B2F29271C60B](Engine[0xC53F8D38DF9042B](f84_local22[0x72D7D6554D61FBC]))
				local f84_local8 = Engine[0xE00B2F29271C60B](Engine[0xC53F8D38DF9042B](f84_local22[0x540D91B083332C7]))
				local f84_local9 = Engine[0xE00B2F29271C60B](Engine[0xC53F8D38DF9042B](f84_local22[0xF69520E335E1DC6]))
				local f84_local10 = {
					[Enum[0x8037372CBD17C20][0xBF99C226E97F1DB]] = {
						small = f84_local7[0xBFF4CC56C2092F0],
						large = f84_local7[0x3B783D946B4EE55],
					},
					[Enum[0x8037372CBD17C20][0x711A76E11C936FF]] = {
						small = f84_local9[0xBFF4CC56C2092F0],
						large = f84_local9[0x3B783D946B4EE55],
					},
					[Enum[0x8037372CBD17C20][0xD7DC1BB143B4455]] = {
						small = f84_local8[0xBFF4CC56C2092F0],
						large = f84_local8[0x3B783D946B4EE55],
					},
				}
				for f84_local16, f84_local17 in ipairs(CoD.PlayerRoleUtility.JumpkitOptions) do
					local f84_local18 = table.insert
					local f84_local19 = f84_local2
					local f84_local20 = {}
					local f84_local15 = {
						displayName = Engine[0xF9F1239CFD921FE](f84_local22[0x55F116BF695C8F6] or 0x0),
						icon = f84_local10[f84_local17.type].small or 0x7615068F50B3D66,
						largeIcon = f84_local10[f84_local17.type].large or 0x7615068F50B3D66,
						itemIndex = f84_local21 - 1,
						lootId = f84_local22[0x28887F70BF5EBA],
						type = f84_local17.type,
						category = f84_local17.typeName,
						unlockInfo = f84_local23.unlockInfo or "",
					}
					local f84_local14 = CoD.BlackMarketUtility.LootIdRarities[f84_local23.rarity]
					if not f84_local14 then
						f84_local14 = Enum[0x704F69F9B0BDCEC][0x8556B83CAD0D180]
					end
					f84_local15.rarity = f84_local14
					f84_local14 = f84_local23.owned
					if not f84_local14 then
						f84_local14 = f84_local23.available or not f84_local24
					end
					f84_local15.available = f84_local14
					f84_local15.owned = f84_local23.owned or not f84_local24
					f84_local15.skipDefaultTitle = f84_local23.isNotDefault
					f84_local14 = f84_local23.hideRarity
					if not f84_local14 then
						f84_local14 = f84_local23.isEntitlement or false
					end
					f84_local15.hideRarity = f84_local14
					f84_local20.models = f84_local15
					f84_local15 = {
						lootData = f84_local23,
					}
					if f84_local17.type ~= Enum[0x8037372CBD17C20][0xBF99C226E97F1DB] or f84_local21 ~= f84_local3 then
						f84_local14 = false
					else
						f84_local14 = true
					end
					f84_local15.selectIndex = f84_local14
					f84_local20.properties = f84_local15
					f84_local18(f84_local19, f84_local20)
				end
			end
		end
		return f84_local2
	end,
	true,
	{
		getModel = function(f85_arg0)
			local f85_local0 = Engine[0x4DF5CFBC1771947](f85_arg0)
			f85_local0 = f85_local0:create("WZJumpKitItems")
			f85_local0:create("updateSelections")
			return f85_local0
		end,
	}
)
DataSources.WZJumpKitSelectedItems = DataSourceHelpers.ListSetup("WZJumpKitSelectedItems", function(f86_arg0, f86_arg1)
	local f86_local0 = Engine[0xA7E3CD65E63086F](0xC4900FCA46D6C74)
	local f86_local1 = Engine[0x3EAC408F958FF05]()
	local f86_local2 = {}
	for f86_local14, f86_local15 in ipairs(CoD.PlayerRoleUtility.JumpkitOptions) do
		local f86_local16 = f86_local15.type
		local f86_local17 = f86_local0[Engine[0xD67CC9D9A0B5948](f86_arg0, f86_local1, f86_local16) + 1]
		if f86_local17 then
			local f86_local6 = CoD.BlackMarketTableUtility.LootInfoLookup(f86_arg0, f86_local17[0x28887F70BF5EBA], f86_local17[0x562938AF86028A0])
			if not f86_local6.isLoot or f86_local6.owned then
				local f86_local7, f86_local8 = nil
				if f86_local16 == Enum[0x8037372CBD17C20][0xBF99C226E97F1DB] then
					local f86_local9 = Engine[0xE00B2F29271C60B](Engine[0xC53F8D38DF9042B](f86_local17[0x72D7D6554D61FBC]))
					f86_local7 = f86_local9[0xBFF4CC56C2092F0]
					f86_local8 = f86_local9[0x3B783D946B4EE55]
				elseif f86_local16 == Enum[0x8037372CBD17C20][0x711A76E11C936FF] then
					local f86_local9 = Engine[0xE00B2F29271C60B](Engine[0xC53F8D38DF9042B](f86_local17[0xF69520E335E1DC6]))
					f86_local7 = f86_local9[0xBFF4CC56C2092F0]
					f86_local8 = f86_local9[0x3B783D946B4EE55]
				elseif f86_local16 == Enum[0x8037372CBD17C20][0xD7DC1BB143B4455] then
					local f86_local9 = Engine[0xE00B2F29271C60B](Engine[0xC53F8D38DF9042B](f86_local17[0x540D91B083332C7]))
					f86_local7 = f86_local9[0xBFF4CC56C2092F0]
					f86_local8 = f86_local9[0x3B783D946B4EE55]
				end
				local f86_local9 = table.insert
				local f86_local10 = f86_local2
				local f86_local11 = {}
				local f86_local12 = {
					displayName = Engine[0xF9F1239CFD921FE](f86_local17[0x55F116BF695C8F6]),
				}
				local f86_local13
				if f86_local7 then
					f86_local13 = Engine[0xC53F8D38DF9042B](f86_local7)
					if not f86_local13 then
					else
						f86_local12.icon = f86_local13
						if f86_local8 then
							f86_local13 = Engine[0xC53F8D38DF9042B](f86_local8)
							if not f86_local13 then
							else
								f86_local12.largeIcon = f86_local13
								f86_local12.itemIndex = -1
								f86_local12.lootId = f86_local17[0x28887F70BF5EBA]
								f86_local12.type = f86_local16
								f86_local12.category = f86_local15.typeName
								f86_local12.unlockInfo = f86_local6.unlockInfo or ""
								f86_local13 = CoD.BlackMarketUtility.LootIdRarities[f86_local6.rarity]
								if not f86_local13 then
									f86_local13 = Enum[0x704F69F9B0BDCEC][0x8556B83CAD0D180]
								end
								f86_local12.rarity = f86_local13
								f86_local12.available = true
								f86_local12.owned = true
								f86_local12.skipDefaultTitle = f86_local6.isNotDefault
								f86_local12.hideRarity = f86_local6.hideRarity or false
								f86_local11.models = f86_local12
								f86_local11.properties = {
									lootData = f86_local6,
								}
								f86_local9(f86_local10, f86_local11)
							end
						end
						f86_local13 = 0x7615068F50B3D66
					end
				end
				f86_local13 = 0x7615068F50B3D66
			end
		end
	end
	return f86_local2
end, true)
CoD.PlayerRoleUtility.EquipJumpkitItem = function(f87_arg0, f87_arg1, f87_arg2)
	local f87_local0 = CoD.SafeGetModelValue(f87_arg2:getModel(), "itemIndex")
	local f87_local1 = CoD.SafeGetModelValue(f87_arg2:getModel(), "type")
	if f87_local0 and f87_local1 then
		Engine[0x3E1093DB4887D7D](f87_arg1, Engine[0x3EAC408F958FF05](), f87_local1, f87_local0)
		local f87_local2 = DataSources.WZJumpKitItems.getModel(f87_arg1)
		f87_local2.updateSelections:forceNotifySubscriptions()
		f87_local2 = CoD.SafeGetModelValue(f87_arg2:getModel(), "lootId") or 0x0
		if f87_local1 == 0 then
			Engine[0xDE279ECDDDD966](f87_arg1, 0xCD849658F801A88, {
				[0xAB83A8CC61E6325] = f87_local2,
				[0xA4F18CFDFE19A20] = "parachute",
			})
		elseif f87_local1 == 1 then
			Engine[0xDE279ECDDDD966](f87_arg1, 0xCD849658F801A88, {
				[0xAB83A8CC61E6325] = f87_local2,
				[0xA4F18CFDFE19A20] = "trail",
			})
		elseif f87_local1 == 2 then
			Engine[0xDE279ECDDDD966](f87_arg1, 0xCD849658F801A88, {
				[0xAB83A8CC61E6325] = f87_local2,
				[0xA4F18CFDFE19A20] = "wingsuit",
			})
		end
	end
end
CoD.PlayerRoleUtility.IsEquippedJumpkitItem = function(f88_arg0, f88_arg1, f88_arg2)
	local f88_local0 = CoD.SafeGetModelValue(f88_arg2:getModel(), "itemIndex")
	local f88_local1 = CoD.SafeGetModelValue(f88_arg2:getModel(), "type")
	if f88_local0 and f88_local1 then
		return f88_local0 == Engine[0xD67CC9D9A0B5948](f88_arg1, Engine[0x3EAC408F958FF05](), f88_local1)
	else
		return false
	end
end
CoD.PlayerRoleUtility[0x18E8191AD006E3E] = function(f89_arg0)
	local f89_local0 = Engine[0x3EAC408F958FF05]()
	if f89_local0 ~= Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		return
	end
	local f89_local1 = Engine[0xA7E3CD65E63086F](0xC4900FCA46D6C74)
	for f89_local8, f89_local9 in ipairs(CoD.PlayerRoleUtility.JumpkitOptions) do
		local f89_local10 = f89_local9.type
		local f89_local11 = f89_local1[Engine[0xD67CC9D9A0B5948](f89_arg0, f89_local0, f89_local10) + 1]
		local f89_local5 = false
		if not f89_local11 then
			f89_local5 = true
		else
			local f89_local6, f89_local7 = CoD.BlackMarketTableUtility.SimpleLootLookup(f89_arg0, f89_local11[0x28887F70BF5EBA], f89_local11[0x562938AF86028A0])
			if f89_local6 ~= CoD.BlackMarketTableUtility.SimpleLootLookupTypes[0xC0D17BAD169557B] and not f89_local7 then
				f89_local5 = true
			end
		end
		if f89_local5 then
			Engine[0x3E1093DB4887D7D](f89_arg0, f89_local0, f89_local10, 0)
		end
	end
end
CoD.PlayerRoleUtility.CreateCustomizationOptions = function(f90_arg0, f90_arg1, f90_arg2, f90_arg3, f90_arg4)
	local f90_local0 = "OutfitOptions" .. f90_arg4.type
	DataSources[f90_local0] = DataSourceHelpers.ListSetup(f90_local0, function(f91_arg0, f91_arg1)
		local f91_local0 = {}
		local f91_local1 = CoD.PlayerRoleUtility.EquippedOutfitItems[f91_arg0][0xF7F78E9EBEFCE27]
		if f90_arg4.type == Enum[0xFCC6A2D2EB0FDA7][0x8E3A65D78229DC1] then
			f91_local1 = CoD.PlayerRoleUtility.EquippedOutfitItems[f91_arg0][0xD9FCEAC8FF24CBD]
		end
		for f91_local15, f91_local16 in ipairs(f90_arg3) do
			local f91_local17 = f91_local15 - 1
			for f91_local12, f91_local13 in ipairs(f91_local16[f90_arg4.name]) do
				if f91_local12 > 1 and f91_local13.isValid then
					local f91_local5 = f91_local12 - 1
					local f91_local6 = CoD.BlackMarketTableUtility.LootInfoLookup(f91_arg0, f91_local13.lootId)
					local f91_local7 = table.insert
					local f91_local8 = f91_local0
					local f91_local9 = {}
					local f91_local10 = {
						displayName = Engine[0xF9F1239CFD921FE](f91_local13.displayName),
						icon = f91_local13.image,
						itemType = f90_arg4.type,
						category = f90_arg4.displayName,
						itemIndex = f91_local5,
						outfitIndex = f91_local17,
						unlockInfo = f91_local6.unlockInfo or "",
					}
					local f91_local11 = CoD.BlackMarketUtility.LootIdRarities[f91_local6.rarity]
					if not f91_local11 then
						f91_local11 = Enum[0x704F69F9B0BDCEC][0x8556B83CAD0D180]
					end
					f91_local10.rarity = f91_local11
					f91_local11 = f91_local6.available
					if not f91_local11 then
						f91_local11 = not f91_local6.isLoot
					end
					f91_local10.available = f91_local11
					f91_local11 = f91_local6.owned
					if not f91_local11 then
						f91_local11 = not f91_local6.isLoot
					end
					f91_local10.owned = f91_local11
					f91_local10.skipDefaultTitle = f91_local6.isNotDefault
					f91_local10.hideRarity = f91_local6.hideRarity or false
					f91_local10.presets = ""
					f91_local10.presetIndex = -1
					f91_local10.checkEquippedOutfit = true
					f91_local9.models = f91_local10
					f91_local10 = {}
					if f91_local17 ~= f91_local1 or f91_local5 ~= CoD.PlayerRoleUtility.EquippedOutfitItems[f91_arg0][0xBF0EE676636AA4F][f91_local17][f90_arg4.type] then
						f91_local11 = false
					else
						f91_local11 = true
					end
					f91_local10.selectIndex = f91_local11
					f91_local10.lootData = f91_local6
					f91_local9.properties = f91_local10
					f91_local7(f91_local8, f91_local9)
				end
			end
		end
		f91_local2 = function(f92_arg0, f92_arg1)
			f92_arg0 = f91_local0[f92_arg0]
			f92_arg1 = f91_local0[f92_arg1]
			if f92_arg0.models.owned ~= f92_arg1.models.owned then
				return f92_arg0.models.owned
			elseif f92_arg0.models.available ~= f92_arg1.models.available then
				return f92_arg0.models.available
			else
				local f92_local0 = f92_arg0.models.rarity
				local f92_local1 = Enum[0x704F69F9B0BDCEC][0x8556B83CAD0D180]
				f92_local0 = REG5 and Enum[0x704F69F9B0BDCEC][0xFA11ABBEBCE1980] or f92_arg0.models.rarity
				f92_local1 = f92_arg1.models.rarity
				local f92_local2 = Enum[0x704F69F9B0BDCEC][0x8556B83CAD0D180]
				return (REG8 and Enum[0x704F69F9B0BDCEC][0xFA11ABBEBCE1980] or f92_arg1.models.rarity) < f92_local0
			end
		end
		f91_local3 = function(f93_arg0)
			return f91_local0[f93_arg0].models.available
		end
		f91_local4 = {}
		for f91_local18, f91_local19 in LUI.IterateTableBySortedKeys(f91_local0, f91_local2, f91_local3) do
			table.insert(f91_local4, f91_local19)
		end
		return f91_local4
	end, true)
	return f90_local0
end
DataSources.ZMOutfitCategories = DataSourceHelpers.ListSetup("ZMOutfitCategories", function(f94_arg0, f94_arg1)
	local f94_local0 = f94_arg1.menu:getModel()
	local f94_local1 = f94_local0.characterIndex:get()
	local f94_local2 = Engine[0x3EAC408F958FF05]()
	local f94_local3 = {}
	local f94_local4 = CoD.PlayerRoleUtility.GetCachedHeroCustomization(f94_local2, f94_local1)
	CoD.PlayerRoleUtility.EquippedOutfitItems[f94_arg0] = Engine[0x823ED148924D7BD](f94_arg0, f94_local2, f94_local1) or {}
	local f94_local5 = f94_local4.outfits[1]
	DataSources.CharacterBreadcrumbs.updateAllCurrentSpecialistOutfitItemBreadcrumbs(f94_arg1.menu, f94_arg0, f94_local1, f94_local4, false)
	for f94_local9, f94_local10 in ipairs(CoDLoadoutsShared.characterCustomizationRegions) do
		if #f94_local5[f94_local10.name] > 1 then
			table.insert(f94_local3, {
				models = {
					displayName = f94_local10.displayName,
					datasourceName = CoD.PlayerRoleUtility.CreateCustomizationOptions(f94_arg0, f94_local2, f94_local1, f94_local4.outfits, f94_local10),
					itemType = f94_local10.type,
					breadcrumb = DataSources.SpecialistOutfitBreadcrumbs.getBreadcrumbModelForItemTypeCategory(f94_arg0, f94_local2, specialistIndex, f94_local10.type),
				},
			})
		end
	end
	return f94_local3
end, true)
CoD.PlayerRoleUtility[0x9F1E0063F7B530D] = function(f95_arg0, f95_arg1, f95_arg2, f95_arg3)
	local f95_local0 = nil
	for f95_local9, f95_local10 in ipairs(f95_arg1.presets) do
		if f95_local10.isValid and CoD.PlayerRoleUtility.IsPresetOwned(f95_arg0, f95_local10) then
			local f95_local4 = true
			for f95_local5 = 0, Enum[0xFCC6A2D2EB0FDA7][0x997A52C773DD143] - 1, 1 do
				local f95_local8 = nil
				if f95_local5 == Enum[0xFCC6A2D2EB0FDA7][0x41B42F0A58AC50F] then
					f95_local8 = f95_local10.arms
				elseif f95_local5 == Enum[0xFCC6A2D2EB0FDA7][0x7AD40A4111A72FE] then
					f95_local8 = f95_local10.head
				elseif f95_local5 == Enum[0xFCC6A2D2EB0FDA7][0xFF8573E011622F4] then
					f95_local8 = f95_local10.headgear
				elseif f95_local5 == Enum[0xFCC6A2D2EB0FDA7][0x83CBB806B732B11] then
					f95_local8 = f95_local10.legs
				elseif f95_local5 == Enum[0xFCC6A2D2EB0FDA7][0x922FE5C41D9EE8B] then
					f95_local8 = f95_local10.palette
				elseif f95_local5 == Enum[0xFCC6A2D2EB0FDA7][0x9DDCEC39BA98B97] then
					f95_local8 = f95_local10.torso
				end
				if f95_local8 and f95_local8 ~= f95_arg2[f95_local5] then
					f95_local4 = false
					break
				end
			end
			if f95_local4 then
				return true
			elseif not f95_local0 then
				f95_local0 = f95_local10
			end
		end
	end
	if f95_local0 then
		for f95_local1 = 0, Enum[0xFCC6A2D2EB0FDA7][0x997A52C773DD143] - 1, 1 do
			f95_local10 = nil
			if f95_local1 == Enum[0xFCC6A2D2EB0FDA7][0x41B42F0A58AC50F] then
				f95_local10 = f95_local0.arms
			elseif f95_local1 == Enum[0xFCC6A2D2EB0FDA7][0x7AD40A4111A72FE] then
				f95_local10 = f95_local0.head
			elseif f95_local1 == Enum[0xFCC6A2D2EB0FDA7][0xFF8573E011622F4] then
				f95_local10 = f95_local0.headgear
			elseif f95_local1 == Enum[0xFCC6A2D2EB0FDA7][0x83CBB806B732B11] then
				f95_local10 = f95_local0.legs
			elseif f95_local1 == Enum[0xFCC6A2D2EB0FDA7][0x922FE5C41D9EE8B] then
				f95_local10 = f95_local0.palette
			elseif f95_local1 == Enum[0xFCC6A2D2EB0FDA7][0x9DDCEC39BA98B97] then
				f95_local10 = f95_local0.torso
			end
			if f95_local10 and f95_local10 ~= f95_arg2[f95_local1] then
				f95_arg3(f95_local1, f95_local10)
			end
		end
	end
	return f95_local0 ~= nil
end
CoD.PlayerRoleUtility[0x55B379B8ED13B02] = function(f96_arg0, f96_arg1, f96_arg2, f96_arg3)
	local f96_local0 = f96_arg2[Enum[0xFCC6A2D2EB0FDA7][0x8E3A65D78229DC1]]
	if f96_local0 == 0 then
		return true
	end
	local f96_local1 = f96_arg1.warPaints[f96_local0 + 1]
	if f96_local1 and CoD.PlayerRoleUtility.IsWarPaintOwned(f96_arg0, f96_local1, f96_arg1.presets) then
		return true
	end
	local f96_local2 = nil
	for f96_local6, f96_local7 in ipairs(f96_arg1.warPaints) do
		if f96_local6 > 1 and f96_local6 + 1 ~= f96_local0 and CoD.PlayerRoleUtility.IsWarPaintOwned(f96_arg0, f96_local7, f96_arg1.presets) then
			f96_local2 = f96_local6 - 1
			break
		end
	end
	f96_arg3(Enum[0xFCC6A2D2EB0FDA7][0x8E3A65D78229DC1], f96_local2 or 0)
	return f96_local2 ~= nil
end
CoD.PlayerRoleUtility[0x2B307D12327547E] = function(f97_arg0)
	local f97_local0 = Engine[0x3EAC408F958FF05]()
	local f97_local1 = CoD.PlayerRoleUtility.GetHeroList(f97_local0)
	local f97_local2 = false
	if f97_local1 then
		for f97_local20, f97_local21 in ipairs(f97_local1) do
			local f97_local22 = f97_local21.bodyIndex
			local f97_local23 = Engine[0x823ED148924D7BD](f97_arg0, f97_local0, f97_local22)
			if f97_local23 then
				local f97_local6 = CoD.PlayerRoleUtility.GetCachedHeroCustomization(f97_local0, f97_local22)
				local f97_local7 = f97_local0
				if f97_local0 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
					local f97_local8 = Engine[0xB678B832BC9DC0](f97_local0, f97_local22)
					f97_local7 = f97_local8 and f97_local8[0xE69216C2DA7060A]
				end
				if f97_local7 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
					for f97_local11, f97_local12 in ipairs(f97_local6.outfits) do
						local f97_local13 = function(f98_arg0, f98_arg1)
							f97_local2 = true
							Engine[0xFD8CC50F67C9E2](f97_arg0, f97_local0, f97_local22, f97_local11 - 1, f98_arg0, f98_arg1)
						end
						local f97_local14 = f97_local23[0xBF0EE676636AA4F][f97_local11 - 1]
						if not CoD.PlayerRoleUtility[0x9F1E0063F7B530D](f97_arg0, f97_local12, f97_local14, f97_local13) and f97_local23[0xF7F78E9EBEFCE27] == f97_local11 - 1 then
							f97_local2 = true
							Engine[0xB02A702F818D9A3](f97_arg0, f97_local0, f97_local22, 0)
						end
						if not CoD.PlayerRoleUtility[0x55B379B8ED13B02](f97_arg0, f97_local12, f97_local14, f97_local13) and f97_local23[0xD9FCEAC8FF24CBD] == f97_local11 - 1 then
							f97_local2 = true
							Engine[0x449414086A8231D](f97_arg0, f97_local0, f97_local22, 0)
						end
					end
				elseif f97_local7 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
					for f97_local11, f97_local12 in ipairs(f97_local6.outfits) do
						for f97_local16, f97_local17 in ipairs(CoDLoadoutsShared.characterCustomizationRegions) do
							local f97_local19 = f97_local12[f97_local17.name][f97_local23[0xBF0EE676636AA4F][f97_local11 - 1][f97_local17.type] + 1]
							if f97_local19 then
								local f97_local15 = CoD.BlackMarketTableUtility.LootInfoLookup(f97_arg0, f97_local19.lootId)
								if f97_local15.isLoot and not f97_local15.owned then
									f97_local2 = true
									Engine[0xFD8CC50F67C9E2](f97_arg0, f97_local0, f97_local22, f97_local11 - 1, f97_local17.type, 0)
								end
							end
							f97_local2 = true
							Engine[0xFD8CC50F67C9E2](f97_arg0, f97_local0, f97_local22, f97_local11 - 1, f97_local17.type, 0)
						end
					end
				end
			end
		end
	end
	if f97_local2 then
		CoD.PlayerRoleUtility.SaveCharacterCustomizations(f97_arg0)
	end
end
CoD.PlayerRoleUtility[0xD150AB859D3C2D7] = function(f99_arg0)
	local f99_local0 = Engine[0x3EAC408F958FF05]()
	if f99_local0 ~= Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] and f99_local0 ~= Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		return
	end
	local f99_local1 = CoDShared.GetDefaultLoadoutForCurrentMode()
	if not f99_local1 then
		return
	end
	local f99_local2 = Engine[0xB2E4CCC119597B0]()
	for f99_local9, f99_local10 in ipairs(Engine[0x88987BA1B9D616B](f99_arg0, f99_local0)) do
		local f99_local8 = false
		if f99_local2[f99_local10] then
			local f99_local6 = f99_local2[f99_local10]
			local f99_local7 = CoD.BlackMarketTableUtility.LootInfoLookup(f99_arg0, f99_local6[0x14C91FFB3BA4240], f99_local6[0x562938AF86028A0])
			if not CoD.PlayerRoleUtility.AllowSprayOrGesture(f99_arg0, f99_local6, f99_local7) then
				f99_local8 = true
			elseif f99_local7.isLoot and not f99_local7.owned then
				f99_local8 = true
			end
		else
			f99_local8 = true
		end
		if f99_local8 then
			local f99_local6 = CoD.CACUtility[0xD1AA40064EFC4B7](f99_local2, f99_local1, f99_local9 - 1)
			if f99_local6 then
				Engine[0x6994F951ED2C61E](f99_arg0, f99_local0, f99_local9 - 1, f99_local6)
			end
		end
	end
end
CoD.PlayerRoleUtility.GetTagIconFromIndex = function(f100_arg0)
	local f100_local0 = Engine[0xB2E4CCC119597B0]()
	local f100_local1 = f100_local0[f100_arg0 + 1]
	if f100_local1 and f100_local1[0x79439EF7BFA9C2D] == 0x6D7AB194448A4F3 then
		return f100_local1[0xBFF4CC56C2092F0]
	else
		return 0x7615068F50B3D66
	end
end
CoD.PlayerRoleUtility.AllowSprayOrGesture = function(f101_arg0, f101_arg1, f101_arg2)
	local f101_local0 = function()
		return f101_arg1[0x562938AF86028A0] and f101_arg1[0x562938AF86028A0] ~= 0x0
	end
	if f101_arg1[0x486837B8286880E] ~= 1 and not f101_arg2.isLoot and not f101_local0() and not IsBooleanDvarSet(0xCDC482A7D159F8) then
		return false
	elseif f101_arg2.isLoot and not f101_arg2.owned and not f101_arg2.available and not f101_arg2.inSet and not IsBooleanDvarSet(0x22A538E0F11B88E) then
		return false
	elseif f101_local0() and not Engine[0xB521CB398C92692](f101_arg0, f101_arg1[0x562938AF86028A0]) then
		return false
	else
		return true
	end
end
DataSources.SpecialistTagsList = DataSourceHelpers.ListSetup("SpecialistTagsList", function(f103_arg0, f103_arg1)
	return CoD.PlayerRoleUtility[0x9E4FE4B8A2E7B36]
end, true)
DataSources.SpecialistTagSetsList = DataSourceHelpers.ListSetup("SpecialistTagSetsList", function(f104_arg0, f104_arg1)
	return CoD.PlayerRoleUtility[0x1435A1010208496]
end, true)
DataSources.SpecialistGesturesList = DataSourceHelpers.ListSetup("SpecialistGesturesList", function(f105_arg0, f105_arg1)
	return CoD.PlayerRoleUtility[0x9618A04E02FEFA3]
end, true)
DataSources.TagCategories = DataSourceHelpers.ListSetup(
	"TagCategories",
	function(f106_arg0, f106_arg1)
		CoD.PlayerRoleUtility[0x9E4FE4B8A2E7B36] = {}
		local f106_local0 = {}
		CoD.PlayerRoleUtility[0x1435A1010208496] = {}
		CoD.PlayerRoleUtility[0x9618A04E02FEFA3] = {}
		local f106_local1 = f106_arg1.menu._selectIndex
		local f106_local2 = nil
		local f106_local3 = Engine[0xB2E4CCC119597B0]()
		local f106_local4 = DataSources.SprayGestureBreadcrumbs.getModel(f106_arg0)
		local f106_local5 = 0
		local f106_local6 = 0
		local f106_local7 = 0
		for f106_local21, f106_local22 in ipairs(f106_local3) do
			if f106_local22[0x79439EF7BFA9C2D] == 0x6D7AB194448A4F3 then
				local f106_local11 = CoD.BlackMarketTableUtility.LootInfoLookup(f106_arg0, f106_local22[0x14C91FFB3BA4240], f106_local22[0x562938AF86028A0])
				if CoD.PlayerRoleUtility.AllowSprayOrGesture(f106_arg0, f106_local22, f106_local11) then
					local f106_local12 = f106_local22[0x562938AF86028A0]
					if f106_local12 then
						f106_local12 = f106_local22[0x562938AF86028A0] ~= 0x0
					end
					local f106_local13 = f106_local22[0x486837B8286880E]
					if f106_local13 then
						f106_local13 = f106_local22[0x486837B8286880E] == 1
					end
					local f106_local14 = Engine[0xF9F1239CFD921FE](f106_local22[0xA31296C0C1B6029])
					if f106_local11.isLoot and not f106_local11.available then
						f106_local14 = Engine[0xF9F1239CFD921FE](0x8C899D3B96CB850)
					end
					local f106_local15 = f106_local1 == f106_local21
					local f106_local16 = {}
					local f106_local17 = {
						image = f106_local22[0xBFF4CC56C2092F0],
						displayName = f106_local14,
						category = 0xC1A8B9514E01F25,
						setInfo = "",
						unlockInfo = f106_local11.unlockInfo or "",
						index = f106_local21,
					}
					local f106_local18 = CoD.BlackMarketUtility.LootIdRarities[f106_local11.rarity]
					if not f106_local18 then
						f106_local18 = Enum[0x704F69F9B0BDCEC][0x8556B83CAD0D180]
					end
					f106_local17.rarity = f106_local18
					f106_local18 = f106_local11.owned
					if not f106_local18 then
						f106_local18 = not f106_local11.isLoot
					end
					f106_local17.owned = f106_local18
					f106_local18 = f106_local11.available
					if not f106_local18 then
						f106_local18 = not f106_local11.isLoot
					end
					f106_local17.available = f106_local18
					f106_local17.skipDefaultTitle = f106_local11.isNotDefault
					f106_local18 = f106_local11.hideRarity
					if not f106_local18 then
						f106_local18 = f106_local12 or false
					end
					f106_local17.hideRarity = f106_local18
					f106_local17.presets = ""
					f106_local17.presetIndex = -1
					f106_local18 = f106_local11.isLoot
					if f106_local18 then
						f106_local18 = f106_local11.owned
						if f106_local18 then
							f106_local18 = Engine[0xCB675CA7856DA25]()
						end
					end
					f106_local17.trialLocked = f106_local18
					f106_local18 = f106_local11.isLoot
					if f106_local18 then
						f106_local18 = not f106_local11.owned
					end
					f106_local17.lootLocked = f106_local18
					f106_local16.models = f106_local17
					f106_local16.properties = {
						lootData = f106_local11,
						selectIndex = f106_local15,
					}
					if not f106_local11 or not f106_local11.inSet then
						if not f106_local11.isLoot or f106_local11.owned or f106_local11.available then
							if not f106_local13 and (f106_local12 or f106_local11.owned) and CoD.BreadcrumbUtility.IsStatSpecialistSprayGestureNew(f106_arg1.menu, f106_arg0, f106_local21) then
								f106_local5 = f106_local5 + 1
							end
							f106_local16.properties.category = "tags"
							table.insert(CoD.PlayerRoleUtility[0x9E4FE4B8A2E7B36], f106_local16)
							if f106_local15 then
								f106_local2 = CoD.PlayerRoleUtility[0x9E4FE4B8A2E7B36]
							end
						end
					end
					if f106_local11.owned and CoD.BreadcrumbUtility.IsStatSpecialistSprayGestureNew(f106_arg1.menu, f106_arg0, f106_local21) then
						f106_local6 = f106_local6 + 1
					end
					f106_local16.properties.category = "tagsets"
					table.insert(f106_local0, f106_local16)
					if f106_local15 then
						f106_local2 = CoD.PlayerRoleUtility[0x1435A1010208496]
					end
				end
			end
			if f106_local22[0x79439EF7BFA9C2D] == 0x3391A0572202ED4 then
				local f106_local12 = CoD.BlackMarketTableUtility.LootInfoLookup(f106_arg0, f106_local22[0x14C91FFB3BA4240], f106_local22[0x562938AF86028A0])
				if CoD.PlayerRoleUtility.AllowSprayOrGesture(f106_arg0, f106_local22, f106_local12) and (not f106_local12.isLoot or f106_local12.owned or f106_local12.available) then
					local f106_local13 = f106_local22[0x562938AF86028A0]
					if f106_local13 then
						f106_local13 = f106_local22[0x562938AF86028A0] ~= 0x0
					end
					local f106_local14 = Engine[0xF9F1239CFD921FE](f106_local22[0xA31296C0C1B6029])
					if f106_local12.isLoot and not f106_local12.available then
						f106_local14 = Engine[0xF9F1239CFD921FE](0x8C899D3B96CB850)
					end
					if (f106_local13 or f106_local12.owned) and CoD.BreadcrumbUtility.IsStatSpecialistSprayGestureNew(f106_arg1.menu, f106_arg0, f106_local21) then
						f106_local7 = f106_local7 + 1
					end
					local f106_local15 = f106_local1 == f106_local21
					local f106_local16 = table.insert
					local f106_local17 = CoD.PlayerRoleUtility[0x9618A04E02FEFA3]
					local f106_local18 = {}
					local f106_local19 = {
						image = f106_local22[0xBFF4CC56C2092F0],
						displayName = f106_local14,
						category = 0x1C35414911C9A0E,
						setInfo = "",
					}
					local f106_local20 = f106_local12.unlockInfo
					if not f106_local20 then
						f106_local20 = ""
					end
					f106_local19.unlockInfo = f106_local20
					f106_local19.index = f106_local21
					f106_local20 = CoD.BlackMarketUtility.LootIdRarities[f106_local12.rarity]
					if not f106_local20 then
						f106_local20 = Enum[0x704F69F9B0BDCEC][0x8556B83CAD0D180]
					end
					f106_local19.rarity = f106_local20
					f106_local20 = f106_local12.owned
					if not f106_local20 then
						f106_local20 = not f106_local12.isLoot
					end
					f106_local19.owned = f106_local20
					f106_local20 = f106_local12.available
					if not f106_local20 then
						f106_local20 = not f106_local12.isLoot
					end
					f106_local19.available = f106_local20
					f106_local19.skipDefaultTitle = f106_local12.isNotDefault
					f106_local20 = f106_local12.hideRarity
					if not f106_local20 then
						f106_local20 = f106_local13 or false
					end
					f106_local19.hideRarity = f106_local20
					f106_local19.presets = ""
					f106_local19.presetIndex = -1
					f106_local20 = f106_local12.isLoot
					if f106_local20 then
						f106_local20 = f106_local12.owned
						if f106_local20 then
							f106_local20 = Engine[0xCB675CA7856DA25]()
						end
					end
					f106_local19.trialLocked = f106_local20
					f106_local20 = f106_local12.isLoot
					if f106_local20 then
						f106_local20 = not f106_local12.owned
					end
					f106_local19.lootLocked = f106_local20
					f106_local18.models = f106_local19
					f106_local18.properties = {
						lootData = f106_local12,
						selectIndex = f106_local15,
						category = "gestures",
					}
					f106_local16(f106_local17, f106_local18)
					if f106_local15 then
						f106_local2 = CoD.PlayerRoleUtility[0x9618A04E02FEFA3]
					end
				end
			end
		end
		f106_local8 = {}
		if #CoD.PlayerRoleUtility[0x9E4FE4B8A2E7B36] > 0 then
			table.sort(CoD.PlayerRoleUtility[0x9E4FE4B8A2E7B36], function(f107_arg0, f107_arg1)
				if f107_arg0.models.owned ~= f107_arg1.models.owned then
					return f107_arg0.models.owned
				elseif f107_arg0.models.rarity ~= f107_arg1.models.rarity then
					if f107_arg0.models.rarity == Enum[0x704F69F9B0BDCEC][0x8556B83CAD0D180] then
						return false
					elseif f107_arg1.models.rarity == Enum[0x704F69F9B0BDCEC][0x8556B83CAD0D180] then
						return true
					elseif f107_arg1.models.rarity < f107_arg0.models.rarity then
						return true
					elseif f107_arg0.models.rarity < f107_arg1.models.rarity then
						return false
					end
				end
				if f107_arg0.models.available ~= f107_arg1.models.available then
					return f107_arg0.models.available
				end
				return false
			end)
			f106_local9 = f106_local4:create("tags")
			f106_local10 = f106_local9:create("breadcrumbCount")
			f106_local10:set(f106_local5)
			table.insert(f106_local8, {
				models = {
					tabName = 0x13A845278D53F22,
					tabWidget = "CoD.MPSpecialistHUBTags_TagFrame",
					breadcrumb = f106_local9,
				},
				properties = {
					selectIndex = f106_local2 == CoD.PlayerRoleUtility[0x9E4FE4B8A2E7B36],
					sortOrder = 2,
				},
			})
		end
		if #f106_local0 > 0 then
			f106_local9 = {}
			f106_local10 = {}
			for f106_local12, f106_local13 in ipairs(f106_local0) do
				local f106_local14 = f106_local13.properties.lootData
				if not f106_local9[f106_local14.inSet] then
					f106_local9[f106_local14.inSet] = {
						setTitle = CoD.BlackMarketTableUtility.GetLootBonusStringRef(f106_arg0, f106_local14.inSet),
						items = {},
						master = nil,
						numAvailable = 0,
						numOwned = 0,
						rarity = Enum[0x704F69F9B0BDCEC][0xFA11ABBEBCE1980],
					}
					table.insert(f106_local10, f106_local14.inSet)
				end
				if f106_local14.setMaster then
					f106_local9[f106_local14.inSet].master = f106_local13
				end
				if f106_local14.available then
					f106_local9[f106_local14.inSet].numAvailable = f106_local9[f106_local14.inSet].numAvailable + 1
				end
				if f106_local14.owned then
					f106_local9[f106_local14.inSet].numOwned = f106_local9[f106_local14.inSet].numOwned + 1
				end
				table.insert(f106_local9[f106_local14.inSet].items, f106_local13)
			end
			table.sort(f106_local10, function(f108_arg0, f108_arg1)
				f108_arg0 = f106_local9[f108_arg0]
				f108_arg1 = f106_local9[f108_arg1]
				if f108_arg1.rarity < f108_arg0.rarity then
					return true
				elseif f108_arg0.rarity < f108_arg1.rarity then
					return false
				elseif f108_arg1.numOwned < f108_arg0.numOwned then
					return true
				elseif f108_arg0.numOwned < f108_arg1.numOwned then
					return false
				else
					return f108_arg1.numAvailable < f108_arg0.numAvailable
				end
			end)
			for f106_local12, f106_local13 in ipairs(f106_local10) do
				local f106_local14 = f106_local9[f106_local13]
				if f106_local14.numAvailable > 0 or f106_local14.numOwned > 0 then
					local f106_local15 = ""
					if f106_local14.setTitle then
						f106_local15 = Engine[0xF9F1239CFD921FE](f106_local14.setTitle)
					end
					local f106_local16 = Engine[0xF9F1239CFD921FE](0x587BB89C78FFE9A, f106_local15, f106_local14.numOwned, #f106_local14.items)
					for f106_local20, f106_local23 in ipairs(f106_local14.items) do
						f106_local23.models.setName = f106_local14.setTitle
						f106_local23.models.setInfo = f106_local16
						table.insert(CoD.PlayerRoleUtility[0x1435A1010208496], f106_local23)
					end
					for f106_local17 = #f106_local14.items + 1, 5, 1 do
						f106_local20 = f106_local17
						table.insert(CoD.PlayerRoleUtility[0x1435A1010208496], {
							models = {
								image = 0x7615068F50B3D66,
								displayName = "",
								available = false,
							},
						})
					end
					if IsJapaneseSku() then
						table.insert(CoD.PlayerRoleUtility[0x1435A1010208496], {
							models = {
								image = 0x7615068F50B3D66,
								displayName = "",
								available = false,
							},
						})
					end
					f106_local17 = f106_local14.master
					if not f106_local17 then
						f106_local17 = {
							models = {},
							properties = {},
						}
					end
					f106_local14.master = f106_local17
					f106_local14.master.models.setName = f106_local14.setTitle
					f106_local14.master.models.setInfo = Engine[0xF9F1239CFD921FE](0xF4082FA89EBEDBA, f106_local15, Engine[0xF9F1239CFD921FE](0x20BF14474EB8696, Engine[0xF9F1239CFD921FE](0xC1A8B9514E01F25)))
					if f106_local14.master.models.owned then
						f106_local14.master.models.unlockInfo = Engine[0xF9F1239CFD921FE](0xC5DD764B51C08A5)
					else
						f106_local14.master.models.unlockInfo = Engine[0xF9F1239CFD921FE](0x1DA22AC662BBEFE)
					end
					f106_local14.master.properties.customWidgetOverride = CoD.HubTagBonusButton
					table.insert(CoD.PlayerRoleUtility[0x1435A1010208496], f106_local14.master)
				end
			end
			if #CoD.PlayerRoleUtility[0x1435A1010208496] > 0 then
				f106_local21 = f106_local4:create("tagsets")
				f106_local22 = f106_local21:create("breadcrumbCount")
				f106_local22:set(f106_local6)
				table.insert(f106_local8, {
					models = {
						tabName = 0xAACD14AF3BFBE5F,
						tabWidget = "CoD.MPSpecialistHUBTags_TagSetsFrame",
						breadcrumb = f106_local21,
					},
					properties = {
						selectIndex = f106_local2 == CoD.PlayerRoleUtility[0x1435A1010208496],
						sortOrder = 3,
					},
				})
			end
		end
		if #CoD.PlayerRoleUtility[0x9618A04E02FEFA3] > 0 then
			table.sort(CoD.PlayerRoleUtility[0x9618A04E02FEFA3], function(f109_arg0, f109_arg1)
				if f109_arg0.models.owned ~= f109_arg1.models.owned then
					return f109_arg0.models.owned
				elseif f109_arg0.models.rarity ~= f109_arg1.models.rarity then
					if f109_arg0.models.rarity == Enum[0x704F69F9B0BDCEC][0x8556B83CAD0D180] then
						return false
					elseif f109_arg1.models.rarity == Enum[0x704F69F9B0BDCEC][0x8556B83CAD0D180] then
						return true
					elseif f109_arg1.models.rarity < f109_arg0.models.rarity then
						return true
					elseif f109_arg0.models.rarity < f109_arg1.models.rarity then
						return false
					end
				end
				if f109_arg0.models.available ~= f109_arg1.models.available then
					return f109_arg0.models.available
				end
				return f109_arg0.models.index < f109_arg1.models.index
			end)
			f106_local9 = f106_local4:create("gestures")
			f106_local10 = f106_local9:create("breadcrumbCount")
			f106_local10:set(f106_local7)
			table.insert(f106_local8, {
				models = {
					tabName = 0xB825BF2939A8267,
					tabWidget = "CoD.MPSpecialistHUBGesturesInternal",
					breadcrumb = f106_local9,
				},
				properties = {
					selectIndex = f106_local2 == CoD.PlayerRoleUtility[0x9618A04E02FEFA3],
					sortOrder = 1,
				},
			})
		end
		table.sort(f106_local8, function(f110_arg0, f110_arg1)
			if f110_arg0.properties.sortOrder and f110_arg1.properties.sortOrder then
				return f110_arg0.properties.sortOrder < f110_arg1.properties.sortOrder
			elseif f110_arg1.properties.sortOrder then
				return false
			else
				return true
			end
		end)
		return f106_local8
	end,
	true,
	{
		cleanup = function(f111_arg0, f111_arg1)
			CoD.PlayerRoleUtility[0x9E4FE4B8A2E7B36] = nil
			CoD.PlayerRoleUtility[0x1435A1010208496] = nil
			CoD.PlayerRoleUtility[0x9618A04E02FEFA3] = nil
			ListHelper_Cleanup(f111_arg0, f111_arg1)
		end,
	}
)
DataSources.PersonalizationCategories = DataSourceHelpers.ListSetup(
	"PersonalizationCategories",
	function(f112_arg0, f112_arg1)
		local f112_local0 = {}
		local f112_local1 = Engine[0x3EAC408F958FF05]()
		local f112_local2 = Engine[0x4DF5CFBC1771947](f112_arg0)
		f112_local2 = f112_local2:create("PersonalizationCategories")
		table.insert(f112_local0, {
			models = {
				tabName = 0xB825BF2939A8267,
				breadcrumb = DataSources.SprayGestureBreadcrumbs.getModel(f112_arg0),
				tabWidget = "CoD.MPSpecialistHUBBindWheelInternal",
			},
			properties = {
				tabId = 0xA35DE40ECAF45C5,
			},
		})
		if f112_local1 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
			table.insert(f112_local0, {
				models = {
					tabName = 0x2A8D9058AD56819,
					breadcrumb = DataSources.JumpkitBreadcrumbs.getModel(f112_arg0),
					tabWidget = "CoD.WZJumpKitSelectorInternal",
				},
				properties = {
					tabId = 0xC4900FCA46D6C74,
				},
			})
		end
		if #f112_local0 > 1 then
			local f112_local3 = f112_local2:create("showPersonalizationTabs")
			f112_local3:set(true)
		else
			local f112_local3 = f112_local2:create("showPersonalizationTabs")
			f112_local3:set(false)
		end
		return f112_local0
	end,
	true,
	{
		cleanup = function(f113_arg0, f113_arg1)
			ListHelper_Cleanup(f113_arg0, f113_arg1)
		end,
	}
)
CoD.PlayerRoleUtility.CleanupOutfitData = function(f114_arg0)
	CoD.PlayerRoleUtility.EquippedOutfitItems[f114_arg0] = nil
end
CoD.PlayerRoleUtility.UpdatePersonalizeSpecialistOutfit = function(f115_arg0, f115_arg1)
	local f115_local0 = CoD.SafeGetModelValue(f115_arg1:getModel(), "outfitIndex")
	if f115_local0 then
		local f115_local1 = DataSources.MPOutfitCategories.getModel(f115_arg0)
		if f115_local1.selectedCategory:get() == 0xFB8B65946FBF7A2 then
			Engine[0x6ABA4D7F0840A1E](f115_arg0, "updateSpecialistCustomization" .. CoD.GetLocalClientAdjustedNum(f115_arg0), {
				event_name = "changeWarPaintOutfit",
				outfit_index = f115_local0,
			})
		else
			Engine[0x6ABA4D7F0840A1E](f115_arg0, "updateSpecialistCustomization" .. CoD.GetLocalClientAdjustedNum(f115_arg0), {
				event_name = "changeOutfit",
				outfit_index = f115_local0,
			})
		end
	end
end
CoD.PlayerRoleUtility.UpdatePersonalizeSpecialistWarPaintOutfit = function(f116_arg0, f116_arg1)
	local f116_local0 = CoD.SafeGetModelValue(f116_arg1:getModel(), "outfitIndex")
	if f116_local0 then
		Engine[0x6ABA4D7F0840A1E](f116_arg0, "updateSpecialistCustomization" .. CoD.GetLocalClientAdjustedNum(f116_arg0), {
			event_name = "changeWarPaintOutfit",
			outfit_index = f116_local0,
		})
	end
end
CoD.PlayerRoleUtility.UpdatePersonalizeSpecialistOutfitItem = function(f117_arg0, f117_arg1)
	local f117_local0 = CoD.SafeGetModelValue(f117_arg1:getModel(), "itemIndex")
	local f117_local1 = CoD.SafeGetModelValue(f117_arg1:getModel(), "itemType")
	local f117_local2 = CoD.SafeGetModelValue(f117_arg1:getModel(), "presets")
	if f117_local2 and f117_local2 ~= "" then
		Engine[0x6ABA4D7F0840A1E](f117_arg0, "updateSpecialistCustomization" .. CoD.GetLocalClientAdjustedNum(f117_arg0), {
			event_name = "loadPreset",
			presets = f117_local2,
		})
	elseif f117_local0 and f117_local1 then
		Engine[0x6ABA4D7F0840A1E](f117_arg0, "updateSpecialistCustomization" .. CoD.GetLocalClientAdjustedNum(f117_arg0), {
			event_name = "changeOutfitItem",
			item_type = f117_local1,
			item_index = f117_local0,
		})
	end
end
CoD.PlayerRoleUtility.ResetCurrentCharacterCustomization = function(f118_arg0)
	Engine[0x6ABA4D7F0840A1E](f118_arg0, "updateSpecialistCustomization" .. CoD.GetLocalClientAdjustedNum(f118_arg0), {
		event_name = "resetCharacter",
	})
end
CoD.PlayerRoleUtility.ResetPersonalizeSpecialistOutfitItemType = function(f119_arg0, f119_arg1)
	local f119_local0 = function()
		if not CoD.GetMouseFocus(f119_arg0) then
			return true
		else
			local f120_local0 = CoD.GetMouseFocus(f119_arg0)
			f120_local0 = f120_local0:getModel()
			if not f120_local0 then
				return true
			elseif not f120_local0.itemIndex then
				return true
			elseif f120_local0.available and not f120_local0.available:get() then
				return true
			elseif f120_local0.equippable and not f120_local0.equippable:get() then
				return true
			else
				return false
			end
		end
	end
end
CoD.PlayerRoleUtility.SaveCharacterCustomizations = function(f121_arg0)
	local f121_local0 = Engine[0x3EAC408F958FF05]()
	Engine[0xE6C09FDF6C8D188](f121_arg0, f121_local0)
	CoDShared[0x562F4B21BD0FAB0](f121_arg0, f121_local0)
end
CoD.PlayerRoleUtility.SetCharacterWarPaintOutfitIndex = function(f122_arg0, f122_arg1, f122_arg2, f122_arg3, f122_arg4)
	Engine[0x449414086A8231D](f122_arg0, f122_arg1, f122_arg2, f122_arg3, f122_arg4)
	Engine[0xDE279ECDDDD966](f122_arg0, 0xCD849658F801A88, {
		[0xAB83A8CC61E6325] = f122_arg4,
		[0xA4F18CFDFE19A20] = "warpaint",
	})
end
CoD.PlayerRoleUtility.SetCharacterOutfitIndex = function(f123_arg0, f123_arg1, f123_arg2, f123_arg3, f123_arg4)
	Engine[0xB02A702F818D9A3](f123_arg0, f123_arg1, f123_arg2, f123_arg3)
	Engine[0xDE279ECDDDD966](f123_arg0, 0xCD849658F801A88, {
		[0xAB83A8CC61E6325] = f123_arg4,
		[0xA4F18CFDFE19A20] = "outfit",
	})
end
CoD.PlayerRoleUtility.EquipOutfit = function(f124_arg0, f124_arg1, f124_arg2)
	local f124_local0 = f124_arg0:getModel()
	f124_local0 = f124_local0.characterIndex:get()
	local f124_local1 = CoD.SafeGetModelValue(f124_arg2:getModel(), "outfitIndex")
	if f124_local1 then
		local f124_local2 = f124_arg2.lootId or 0x0
		local f124_local3 = Engine[0x4C5185056289C6C](Engine[0x3EAC408F958FF05](), f124_local0)
		local f124_local4 = f124_local3.outfits[f124_local1 + 1]
		local f124_local5 = DataSources.MPOutfitCategories.getModel(f124_arg1)
		if f124_local5.selectedCategory:get() == 0xFB8B65946FBF7A2 then
			if f124_local2 == 0x0 then
				local f124_local6 = f124_local4.warPaints[CoD.PlayerRoleUtility.EquippedOutfitItems[f124_arg1][0xBF0EE676636AA4F][f124_local1][Enum[0xFCC6A2D2EB0FDA7][0x8E3A65D78229DC1]] + 1]
				if f124_local6 then
					f124_local2 = f124_local6.lootId
				end
			end
			CoD.PlayerRoleUtility.SetCharacterWarPaintOutfitIndex(f124_arg1, Engine[0x3EAC408F958FF05](), f124_local0, f124_local1, f124_local2)
			CoD.PlayerRoleUtility.EquippedOutfitItems[f124_arg1][0xD9FCEAC8FF24CBD] = f124_local1
		else
			if f124_local2 == 0x0 then
				local f124_local6 = f124_local4.presets[CoD.PlayerRoleUtility.EquippedOutfitItems[f124_arg1][0xBF0EE676636AA4F][f124_local1][Enum[0xFCC6A2D2EB0FDA7][0x922FE5C41D9EE8B]] + 1]
				if f124_local6 then
					f124_local2 = f124_local6.lootId
				end
			end
			CoD.PlayerRoleUtility.SetCharacterOutfitIndex(f124_arg1, Engine[0x3EAC408F958FF05](), f124_local0, f124_local1, f124_local2)
			CoD.PlayerRoleUtility.EquippedOutfitItems[f124_arg1][0xF7F78E9EBEFCE27] = f124_local1
		end
		local f124_local7 = DataSources.MPSpecialistThemes.getModel(f124_arg1)
		f124_local7.update:forceNotifySubscriptions()
	end
end
CoD.PlayerRoleUtility.EquipOutfitItem = function(f125_arg0, f125_arg1, f125_arg2)
	local f125_local0 = f125_arg0:getModel()
	f125_local0 = f125_local0.characterIndex:get()
	local f125_local1 = CoD.SafeGetModelValue(f125_arg2:getModel(), "outfitIndex")
	if f125_local1 then
		local f125_local2 = CoD.SafeGetModelValue(f125_arg2:getModel(), "itemType")
		local f125_local3 = CoD.SafeGetModelValue(f125_arg2:getModel(), "itemIndex")
		local f125_local4 = CoD.SafeGetModelValue(f125_arg2:getModel(), "presets")
		if f125_local4 and f125_local4 ~= "" then
			local f125_local5 = function(f126_arg0, f126_arg1)
				local f126_local0 = CoD.SafeGetModelValue(f125_arg2:getModel(), f126_arg0) or 0
				Engine[0xFD8CC50F67C9E2](f125_arg1, Engine[0x3EAC408F958FF05](), f125_local0, f125_local1, f126_arg1, f126_local0)
				CoD.PlayerRoleUtility.EquippedOutfitItems[f125_arg1][0xBF0EE676636AA4F][f125_local1][f126_arg1] = f126_local0
			end
			f125_local5("arms", Enum[0xFCC6A2D2EB0FDA7][0x41B42F0A58AC50F])
			f125_local5("head", Enum[0xFCC6A2D2EB0FDA7][0x7AD40A4111A72FE])
			f125_local5("headgear", Enum[0xFCC6A2D2EB0FDA7][0xFF8573E011622F4])
			f125_local5("legs", Enum[0xFCC6A2D2EB0FDA7][0x83CBB806B732B11])
			f125_local5("palette", Enum[0xFCC6A2D2EB0FDA7][0x922FE5C41D9EE8B])
			f125_local5("torso", Enum[0xFCC6A2D2EB0FDA7][0x9DDCEC39BA98B97])
			CoD.PlayerRoleUtility.EquipOutfit(f125_arg0, f125_arg1, f125_arg2)
		elseif f125_local2 and f125_local3 then
			Engine[0xFD8CC50F67C9E2](f125_arg1, Engine[0x3EAC408F958FF05](), f125_local0, f125_local1, f125_local2, f125_local3)
			CoD.PlayerRoleUtility.EquippedOutfitItems[f125_arg1][0xBF0EE676636AA4F][f125_local1][f125_local2] = f125_local3
			CoD.PlayerRoleUtility.EquipOutfit(f125_arg0, f125_arg1, f125_arg2)
		end
		local f125_local5 = DataSources.MPSpecialistThemes.getModel(f125_arg1)
		f125_local5.update:forceNotifySubscriptions()
	end
end
CoD.PlayerRoleUtility.CycleOutfitDecalItem = function(f127_arg0, f127_arg1, f127_arg2)
	local f127_local0 = f127_arg2.decals
	if not f127_local0:navigateItemRight() then
		f127_local0:getFirstSelectableItem(true)
	end
	CoD.PlayerRoleUtility.UpdatePersonalizeSpecialistOutfitItem(f127_arg1, f127_local0)
	CoD.PlayerRoleUtility.EquipOutfitItem(f127_arg0, f127_arg1, f127_local0)
end
CoD.PlayerRoleUtility.UnequipOutfitItem = function(f128_arg0, f128_arg1, f128_arg2)
	local f128_local0 = f128_arg0:getModel()
	f128_local0 = f128_local0.characterIndex:get()
	local f128_local1 = CoD.SafeGetModelValue(f128_arg2:getModel(), "outfitIndex")
	local f128_local2 = CoD.SafeGetModelValue(f128_arg2:getModel(), "itemType")
	if f128_local1 and f128_local2 then
		Engine[0xFD8CC50F67C9E2](f128_arg1, Engine[0x3EAC408F958FF05](), f128_local0, f128_local1, f128_local2, 0)
		CoD.PlayerRoleUtility.EquippedOutfitItems[f128_arg1][0xBF0EE676636AA4F][f128_local1][f128_local2] = 0
		local f128_local3 = DataSources.MPSpecialistThemes.getModel(f128_arg1)
		f128_local3.update:forceNotifySubscriptions()
	end
end
CoD.PlayerRoleUtility.IsSelectedOutfitIndex = function(f129_arg0, f129_arg1)
	local f129_local0 = CoD.SafeGetModelValue(f129_arg0:getModel(), "outfitIndex") or -1
	if not CoD.PlayerRoleUtility.EquippedOutfitItems[f129_arg1] then
		return false
	else
		local f129_local1 = DataSources.MPOutfitCategories.getModel(f129_arg1)
		if f129_local1.selectedCategory:get() == 0xFB8B65946FBF7A2 then
			return CoD.PlayerRoleUtility.EquippedOutfitItems[f129_arg1][0xD9FCEAC8FF24CBD] == f129_local0
		else
			return CoD.PlayerRoleUtility.EquippedOutfitItems[f129_arg1][0xF7F78E9EBEFCE27] == f129_local0
		end
	end
end
CoD.PlayerRoleUtility.IsSelectedOutfitItemIndex = function(f130_arg0, f130_arg1)
	local f130_local0 = CoD.SafeGetModelValue(f130_arg0:getModel(), "outfitIndex")
	if f130_local0 then
		local f130_local1 = CoD.SafeGetModelValue(f130_arg0:getModel(), "presets")
		local f130_local2 = CoD.SafeGetModelValue(f130_arg0:getModel(), "itemType")
		local f130_local3 = CoD.SafeGetModelValue(f130_arg0:getModel(), "itemIndex")
		if CoD.SafeGetModelValue(f130_arg0:getModel(), "checkEquippedOutfit") then
			local f130_local4 = CoD.PlayerRoleUtility.EquippedOutfitItems[f130_arg1][0xF7F78E9EBEFCE27]
			if f130_local2 == Enum[0xFCC6A2D2EB0FDA7][0x8E3A65D78229DC1] then
				f130_local4 = CoD.PlayerRoleUtility.EquippedOutfitItems[f130_arg1][0xD9FCEAC8FF24CBD]
			end
			if f130_local0 ~= f130_local4 then
				return false
			end
		end
		if f130_local1 and f130_local1 ~= "" then
			local f130_local4 = true
			local f130_local5 = function(f131_arg0, f131_arg1)
				return CoD.PlayerRoleUtility.EquippedOutfitItems[f130_arg1][0xBF0EE676636AA4F][f130_local0][f131_arg1] == (CoD.SafeGetModelValue(f130_arg0:getModel(), f131_arg0) or 0)
			end
			if f130_local4 then
				f130_local4 = f130_local5("arms", Enum[0xFCC6A2D2EB0FDA7][0x41B42F0A58AC50F])
			end
			if f130_local4 then
				f130_local4 = f130_local5("head", Enum[0xFCC6A2D2EB0FDA7][0x7AD40A4111A72FE])
			end
			if f130_local4 then
				f130_local4 = f130_local5("headgear", Enum[0xFCC6A2D2EB0FDA7][0xFF8573E011622F4])
			end
			if f130_local4 then
				f130_local4 = f130_local5("legs", Enum[0xFCC6A2D2EB0FDA7][0x83CBB806B732B11])
			end
			if f130_local4 then
				f130_local4 = f130_local5("palette", Enum[0xFCC6A2D2EB0FDA7][0x922FE5C41D9EE8B])
			end
			if f130_local4 then
				f130_local4 = f130_local5("torso", Enum[0xFCC6A2D2EB0FDA7][0x9DDCEC39BA98B97])
			end
			return f130_local4
		elseif CoD.PlayerRoleUtility.EquippedOutfitItems[f130_arg1] then
			return CoD.PlayerRoleUtility.EquippedOutfitItems[f130_arg1][0xBF0EE676636AA4F][f130_local0][f130_local2] == f130_local3
		end
	end
	return false
end
CoD.PlayerRoleUtility.IsFirstBonusItem = function(f132_arg0, f132_arg1)
	if not CoD.SafeGetModelValue(f132_arg0:getModel(), "isBonusItem") then
		return false
	end
	local f132_local0 = f132_arg0:isFirstItem()
	if not f132_local0 then
		f132_local0 = CoD.SafeGetModelValue
		local f132_local1 = f132_arg0:getPreviousItem()
		f132_local0 = not f132_local0(f132_local1:getModel(), "isBonusItem")
	end
	return f132_local0
end
CoD.PlayerRoleUtility.OpenBindWheelForTag = function(f133_arg0, f133_arg1, f133_arg2)
	local f133_local0 = OpenOverlay
	local f133_local1 = f133_arg0
	local f133_local2 = "MPSpecialistHUBBindWheel"
	local f133_local3 = f133_arg2
	local f133_local4 = {
		_model = f133_arg1:getModel(),
	}
	local f133_local5 = f133_arg0:getModel()
	f133_local4.characterIndex = f133_local5.characterIndex:get()
	f133_local4._allowsQuickSelect = true
	f133_local0(f133_local1, f133_local2, f133_local3, f133_local4)
end
CoD.PlayerRoleUtility.OpenBindWheelForGesture = function(f134_arg0, f134_arg1, f134_arg2)
	local f134_local0 = OpenOverlay
	local f134_local1 = f134_arg0
	local f134_local2 = "MPSpecialistHUBBindWheel"
	local f134_local3 = f134_arg2
	local f134_local4 = {
		_model = f134_arg1:getModel(),
	}
	local f134_local5 = f134_arg0:getModel()
	f134_local4.characterIndex = f134_local5.characterIndex:get()
	f134_local4._allowsQuickSelect = true
	f134_local0(f134_local1, f134_local2, f134_local3, f134_local4)
end
CoD.PlayerRoleUtility.PreviewGesture = function(f135_arg0, f135_arg1, f135_arg2, f135_arg3)
	local f135_local0 = f135_arg1:getModel()
	Engine[0x6ABA4D7F0840A1E](f135_arg2, "updateSpecialistCustomization" .. CoD.GetLocalClientAdjustedNum(f135_arg2), {
		event_name = "previewGesture",
		gesture_index = f135_local0.index:get() - 1,
		replay_if_already_playing = false,
		ignore_if_already_playing = not f135_arg3,
		wait_until_model_steam_ends = false,
	})
end
CoD.PlayerRoleUtility.PlayDraftGesture_Internal = function(f136_arg0, f136_arg1)
	if f136_arg1 and 0 <= f136_arg1 then
		local f136_local0 = CoD.BreadcrumbUtility.GetSprayGestureTable()
		f136_local0 = f136_local0[f136_arg1 + 1]
		if f136_local0 then
			Engine[0xDE279ECDDDD966](f136_arg0, 0x8492A9F79B4D8E2, {
				[0xB53288C022B73A7] = f136_arg1,
				[0xE3755F8BEC75376] = -1,
				[0x84CFBA3558B4604] = f136_local0[0x14C91FFB3BA4240],
			})
		end
		Engine[0xE7A5E30BF672339](f136_arg0, Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2]), f136_arg1)
	end
end
CoD.PlayerRoleUtility.PlayDraftGesture = function(f137_arg0, f137_arg1)
	local f137_local0 = f137_arg0:getStickModel(f137_arg1)
	f137_local0 = f137_local0.SelectedWedge:get()
	if f137_local0 > -1 then
		local f137_local1 = CoD.SafeGetModelValue(f137_arg0:getModelForIndex(f137_local0 + 1), "item_index")
		if f137_local1 and f137_local1 > -1 then
			CoD.PlayerRoleUtility.PlayDraftGesture_Internal(f137_arg1, f137_local1)
		end
	end
end
CoD.PlayerRoleUtility.PlayQuickDraftGesture = function(f138_arg0)
	local f138_local0 = DataSources.QuickSpray.getModel(f138_arg0)
	CoD.PlayerRoleUtility.PlayDraftGesture_Internal(f138_arg0, f138_local0.index:get())
end
CoD.PlayerRoleUtility.StopDraftGesture = function(f139_arg0, f139_arg1)
	Engine[0xE7A5E30BF672339](f139_arg1, Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2]), -1)
end
CoD.PlayerRoleUtility.StopGesturePreview = function(f140_arg0, f140_arg1)
	Engine[0x6ABA4D7F0840A1E](f140_arg1, "updateSpecialistCustomization" .. CoD.GetLocalClientAdjustedNum(f140_arg1), {
		event_name = "stopGesture",
	})
end
CoD.PlayerRoleUtility.RefreshAnim = function(f141_arg0)
	Engine[0x6ABA4D7F0840A1E](f141_arg0, "updateSpecialistCustomization" .. CoD.GetLocalClientAdjustedNum(f141_arg0), {
		event_name = "refresh_anim",
	})
end
CoD.PlayerRoleUtility.SendClientNotifyGestureMenu = function(f142_arg0, f142_arg1)
	local f142_local0 = CoD.BaseUtility.GetMenuSessionMode(f142_arg0)
	local f142_local1 = nil
	if IsLobbyNetworkModeLive() then
		if f142_local0 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
			f142_local1 = Enum[0xBBD4F9E70101BA8][0x6C886CEB6BF4BCA]
		elseif f142_local0 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
			f142_local1 = Enum[0xBBD4F9E70101BA8][0xDF87425733853AE]
		end
	elseif f142_local0 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
		f142_local1 = Enum[0xBBD4F9E70101BA8][0xF9A4C4451E3499E]
	elseif f142_local0 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		f142_local1 = Enum[0xBBD4F9E70101BA8][0x7036247812689DA]
	end
	if not f142_local1 then
		return
	end
	local f142_local2 = Engine[0x8BF970606552F4C](f142_arg1, f142_local1)
	local f142_local3 = f142_local2[0x766CE60E25569A3][0x8A76647E94009C3][0xDF5E6BB54765F4C]:get()
	if not f142_local3 or f142_local3 == 0 then
		f142_local3 = 1
	end
	SendCustomClientScriptMenuExpressionStateChangeNotify(f142_arg1, "MPSpecialistHUBGestures", true, f142_local3)
end
CoD.PlayerRoleUtility.SubscribeToSelectedWedge = function(f143_arg0, f143_arg1)
	if not f143_arg0.element_wheel then
		return
	end
	local f143_local0 = f143_arg0._model:create("CanSelectWedge")
	f143_local0:set(false)
	local f143_local1 = f143_arg0.element_wheel:getStickModel(f143_arg1)
	f143_local1 = f143_local1.SelectedWedge
	if not f143_arg0.selectedWedgeSubscription then
		f143_arg0.selectedWedgeSubscription = f143_arg0:subscribeToModel(f143_local1, function(model)
			if model:get() >= 0 then
				f143_local0:set(true)
			else
				f143_local0:set(false)
			end
		end)
	end
end
CoD.PlayerRoleUtility.OpenGestureTagMenu = function(f145_arg0, f145_arg1)
	if not f145_arg0.element_wheel then
		return
	else
		local f145_local0 = f145_arg0.element_wheel:getStickModel(f145_arg1)
		f145_local0 = f145_local0.SelectedWedge:get() + 1
		local f145_local1 = Engine[0x3EAC408F958FF05]()
		local f145_local2 = CoD.BreadcrumbUtility.GetStorageLoadoutBufferForPlayer(f145_arg1, f145_local1)
		local f145_local3 = Engine[0x88987BA1B9D616B](f145_arg1, f145_local1)
		local f145_local4 = f145_local3[f145_local0 + 1]
		local f145_local5 = function()
			f145_arg0.element_wheel:updateDataSource()
		end
		local f145_local6 = f145_arg0.element_wheel:getStickModel(f145_arg1)
		f145_arg0._lastSelectedWedge = f145_local6.SelectedWedge:get()
		OpenOverlay(f145_arg0, "MPSpecialistHUBTags", f145_arg1, {
			model = f145_arg0:getModel() or f145_arg0._model,
			properties = {
				_storageLoadoutBuffer = f145_local2,
				_sessionMode = f145_local1,
				_slotIndex = f145_local0,
				_refreshDataSource = f145_local5,
				_selectIndex = f145_local4,
			},
		})
	end
end
CoD.PlayerRoleUtility.OpenQuickSlotGestureTagMenu = function(f147_arg0, f147_arg1)
	local f147_local0 = 0
	local f147_local1 = Engine[0x3EAC408F958FF05]()
	local f147_local2 = CoD.BreadcrumbUtility.GetStorageLoadoutBufferForPlayer(f147_arg1, f147_local1)
	local f147_local3 = Engine[0x88987BA1B9D616B](f147_arg1, f147_local1)
	local f147_local4 = f147_local3[f147_local0 + 1]
	local f147_local5 = function()
		CoD.HUDUtility.SetupQuickSprayModels(f147_arg1, f147_arg0)
	end
	f147_arg0._lastSelectedWedge = nil
	OpenOverlay(f147_arg0, "MPSpecialistHUBTags", f147_arg1, {
		model = f147_arg0:getModel() or f147_arg0._model,
		properties = {
			_storageLoadoutBuffer = f147_local2,
			_sessionMode = f147_local1,
			_slotIndex = f147_local0,
			_refreshDataSource = f147_local5,
			_selectIndex = f147_local4,
		},
	})
end
CoD.PlayerRoleUtility.BindGestureTagToSlot = function(f149_arg0, f149_arg1, f149_arg2)
	local f149_local0 = f149_arg0._slotIndex
	if not f149_local0 then
		return
	end
	local f149_local1 = CoD.SafeGetModelValue(f149_arg1:getModel(), "index")
	if not f149_local1 then
		return
	end
	Engine[0x6994F951ED2C61E](f149_arg2, Engine[0x3EAC408F958FF05](), f149_local0, f149_local1)
	local f149_local2 = CoD.BreadcrumbUtility.GetSprayGestureTable()
	f149_local2 = f149_local2[f149_local1 + 1]
	if f149_local2 then
		Engine[0xDE279ECDDDD966](f149_arg2, 0x383F97940CAD275, {
			[0xB53288C022B73A7] = f149_local1,
			[0x84CFBA3558B4604] = f149_local2[0x14C91FFB3BA4240],
		})
	end
	local f149_local3 = f149_arg0._refreshDataSource
	if f149_local3 then
		f149_local3()
	end
	GoBack(f149_arg0, f149_arg2)
end
CoD.PlayerRoleUtility.GetPlayerRolesListHelper = function(f150_arg0, f150_arg1, f150_arg2, f150_arg3)
	local f150_local0 = {}
	for f150_local8, f150_local9 in ipairs(CoD.PlayerRoleUtility.GetHeroList(f150_arg2)) do
		local f150_local10 = f150_local9.bodyIndex
		local f150_local11 = {
			models = {
				name = f150_local9.displayName,
				icon = f150_local9.positionDraftIcon,
				mode = f150_arg2,
				characterIndex = f150_local10,
				jobTitle = CoD.PlayerRoleUtility.GetCharacterTraitTitle(f150_arg2, f150_local10),
				tooltipArchetype = f150_arg0.tooltipArchetype,
				assetName = f150_local9.assetName,
				hasCustomization = CoD.PlayerRoleUtility.HasCustomization(f150_arg1, CoD.PlayerRoleUtility.GetCachedHeroCustomization(f150_arg2, f150_local10)),
			},
			properties = {
				characterIndex = f150_local10,
				character = f150_local9,
			},
		}
		if not f150_arg3 or f150_arg3 and f150_arg3(f150_arg0, f150_arg1, f150_arg2, f150_local10, f150_local11) then
			local f150_local4 = #f150_local0 + 1
			if f150_arg2 ~= Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
				for f150_local5 = #f150_local0, 1, -1 do
					if Engine[0xF9F1239CFD921FE](f150_local0[f150_local5].models.name) < Engine[0xF9F1239CFD921FE](f150_local11.models.name) then
						break
					end
					f150_local4 = f150_local4 - 1
				end
			end
			table.insert(f150_local0, f150_local4, f150_local11)
		end
	end
	if f150_arg2 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		f150_local1 = function(f151_arg0)
			local f151_local0 = Engine[0xB678B832BC9DC0](f150_arg2, f151_arg0)
			if f151_local0 and f151_local0[0xD909934375BE707] then
				return f151_local0[0xD909934375BE707]
			else
				return 0
			end
		end
		table.sort(f150_local0, function(f152_arg0, f152_arg1)
			if f152_arg0.properties and f152_arg0.properties.characterIndex and f152_arg1.properties and f152_arg1.properties.characterIndex then
				return f150_local1(f152_arg0.properties.characterIndex) < f150_local1(f152_arg1.properties.characterIndex)
			end
			return f152_arg1.properties and f152_arg1.properties.characterIndex
		end)
	end
	if f150_local0 and #f150_local0 > 0 then
		f150_local0[1].properties.selectIndex = true
	end
	return f150_local0
end
CoD.PlayerRoleUtility.GetCharacterTraitTitle = function(f153_arg0, f153_arg1)
	local f153_local0 = Engine[0xB678B832BC9DC0](f153_arg0, f153_arg1)
	if f153_local0 and f153_local0[0xCB0CDA53FD7B57A] then
		return f153_local0[0xCB0CDA53FD7B57A]
	else
		return 0x0
	end
end
CoD.PlayerRoleUtility.GetCharacterTraitSummary = function(f154_arg0, f154_arg1)
	local f154_local0 = Engine[0xB678B832BC9DC0](f154_arg0, f154_arg1)
	if f154_local0 and f154_local0[0xF448362F2806424] then
		return f154_local0[0xF448362F2806424]
	else
		return 0x0
	end
end
CoD.PlayerRoleUtility.IsCharacterRestricted = function(f155_arg0, f155_arg1)
	if f155_arg0 == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		return false
	else
		local f155_local0 = Engine[0x1E32FEF495242B8]()
		return f155_local0.maxUniqueRolesPerTeam[f155_arg1]:get() == 0
	end
end
CoD.PlayerRoleUtility[0x7841254A6DA6220] = function(f156_arg0, f156_arg1)
	local f156_local0 = Engine[0x3ACB99DBAD24D55](Engine[0x7B3B2B73B53EB34]())
	if not f156_local0 or not f156_local0.isSpectreRising then
		return true
	elseif f156_arg0 and f156_arg0.characterIndex then
		local f156_local1 = Engine[0xB678B832BC9DC0](Engine[0x3EAC408F958FF05](), f156_arg0.characterIndex)
		if f156_local1[0x5E9D6D3424C0E7E] == 0x50D7FC2ACA48B7F then
			return false
		end
	end
	return true
end
CoD.PlayerRoleUtility.IsSelfModelSpectreRisingRestricted = function(f157_arg0, f157_arg1)
	local f157_local0 = Engine[0x3ACB99DBAD24D55](Engine[0x7B3B2B73B53EB34]())
	if not f157_local0 or not f157_local0.isSpectreRising then
		return false
	end
	local f157_local1 = f157_arg0:getModel()
	local f157_local2 = f157_local1
	local f157_local3 = f157_local1.selectedCharacterType
	if f157_local3 then
		f157_local3 = f157_local2 and f157_local1.selectedCharacterType:get()
	end
	if f157_local3 == nil then
		return false
	end
	local f157_local4 = Engine[0xB678B832BC9DC0](Engine[0x3EAC408F958FF05](), f157_local3)
	if f157_local4[0x5E9D6D3424C0E7E] == 0x50D7FC2ACA48B7F then
		return true
	end
	return false
end
CoD.PlayerRoleUtility[0x7B96724B9CBB296] = function(f158_arg0, f158_arg1)
	if not CoD.WZUtility[0xE6C072866FEDB9F]() then
		return false
	end
	local f158_local0 = f158_arg0:getModel()
	local f158_local1 = f158_local0
	local f158_local2 = f158_local0.characterIndex
	if f158_local2 then
		f158_local2 = f158_local1 and f158_local0.characterIndex:get()
	end
	if f158_local2 == nil then
		return false
	end
	local f158_local3 = Engine[0x3EAC408F958FF05]()
	local f158_local4 = Engine[0xB678B832BC9DC0](f158_local3, f158_local2)
	if f158_local4[0x5E9D6D3424C0E7E] == 0x50D7FC2ACA48B7F then
		return CoD.PlayerRoleUtility.IsRoleUnlocked(f158_arg1, f158_local3, f158_local2)
	end
	return false
end
CoD.PlayerRoleUtility.IsSelfModelCharacterRestricted = function(f159_arg0)
	local f159_local0 = f159_arg0.characterIndex
	if not f159_local0 then
		local f159_local1 = f159_arg0:getModel()
		f159_local0 = f159_local1.characterIndex and f159_local1 and f159_local1.characterIndex:get()
	end
	if f159_local0 then
		return CoD.PlayerRoleUtility.IsCharacterRestricted(Engine[0x3EAC408F958FF05](), f159_local0)
	else
		return false
	end
end
DataSources.PositionDraftCharacters = DataSourceHelpers.ListSetup("PositionDraftCharacters", function(f160_arg0, f160_arg1)
	local f160_local0 = Engine[0x3EAC408F958FF05]()
	local f160_local1 = CoD.PlayerRoleUtility.GetHeroList(f160_local0)
	local f160_local2 = Engine[0x4DF5CFBC1771947](f160_arg0)
	local f160_local3 = CoD.SafeGetModelValue(f160_local2, "PositionEditLoadout.SelectedCharacterIndex")
	f160_arg1.persistSelectedIndex = true
	return CoD.PlayerRoleUtility.GetPlayerRolesListHelper(f160_arg1, f160_arg0, f160_local0, function(f161_arg0, f161_arg1, f161_arg2, f161_arg3, f161_arg4)
		local f161_local0 = f161_arg4.models.characterIndex
		local f161_local1 = LobbyData.GetCurrentMenuTarget()
		local f161_local2 = false
		if f161_local1[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_TRAINING) or IsSimulateCT() then
			if f161_local0 ~= f160_local3 then
				return false
			end
			f161_local2 = true
		end
		if f161_arg4.properties.character[0x810366D1F05BBBD] and not CoD.BaseUtility.IsDvarEnabled(f161_arg4.properties.character[0x810366D1F05BBBD]) then
			return false
		elseif f161_arg2 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] and LuaUtils.IsArenaMode() and CoDLoadoutsShared.ArenaHiddenPositionRoles[Engine[0x82C5756563934AE](f161_arg2, f161_local0)] then
			return false
		end
		local f161_local3 = CoD.TeamUtility.GetTeam(f161_arg1)
		CoD.CACUtility.GetCustomClassModel(f161_arg1, Engine[0x6C0CB7BD099633F](f161_arg2, f161_local0), f160_local2:create("PositionDraftCharacters." .. f161_arg3 .. ".classModel"), nil, f161_arg2)
		local f161_local4 = CoD.PlayerRoleUtility.GetPositionRoleDefaultInfo(f161_arg2, f161_local0)
		local f161_local5 = CoD.PlayerRoleUtility.IsRoleBMLocked(f161_arg1, f161_arg2, f161_local0)
		local f161_local6 = f161_arg4.models
		local f161_local7
		if not f161_local5 then
			f161_local7 = CoD.PlayerRoleUtility.IsRoleDisabled(f161_arg1, f161_local0)
			if f161_local7 then
			else
				f161_local6.disabled = f161_local7
				f161_arg4.models.isBMLocked = f161_local5 and not f161_local2
				f161_arg4.models.unavailable = CoD.PlayerRoleUtility.IsMaxUniqueRolesPerTeam(f161_arg1, f161_local0) and not f161_local2
				f161_arg4.models.playerName = CoD.PlayerRoleUtility.GetPlayerNameForPositionDraftCharacter(f161_arg1, f161_local0, f161_local3)
				f161_arg4.models.equipment = f161_local4.equipment
				f161_arg4.models.ability = f161_local4.ability
				f161_arg4.properties.action = PositionDraftSelectCharacter
				f161_arg4.properties.selectIndex = f160_local3 == f161_local0
				f161_arg4.properties.isRestricted = CoD.PlayerRoleUtility.IsCharacterRestricted(f161_arg2, f161_local0) and not f161_local2
				return true
			end
		end
		f161_local7 = not f161_local2
	end)
end, nil, nil, nil)
DataSources.PositionDraftCharactersMPPromo = DataSourceHelpers.ListSetup("PositionDraftCharactersMPPromo", function(f162_arg0, f162_arg1)
	local f162_local0 = Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5]
	local f162_local1 = CoD.PlayerRoleUtility.GetHeroList(f162_local0)
	local f162_local2 = CoD.SafeGetModelValue(Engine[0x4DF5CFBC1771947](f162_arg0), "PositionEditLoadout.SelectedCharacterIndex")
	f162_arg1.persistSelectedIndex = true
	return CoD.PlayerRoleUtility.GetPlayerRolesListHelper(f162_arg1, f162_arg0, f162_local0, function(f163_arg0, f163_arg1, f163_arg2, f163_arg3, f163_arg4)
		local f163_local0 = f163_arg4.models.characterIndex
		local f163_local1 = LobbyData.GetCurrentMenuTarget()
		if (f163_local1[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName(LuaEnum.UI.DIRECTOR_ONLINE_MP_TRAINING) or IsSimulateCT()) and f163_local0 ~= f162_local2 then
			return false
		else
			local f163_local2 = CoD.BlackMarketTableUtility[0x21632E84A5AAF71](f163_arg4.models.assetName)
			if not f163_local2 then
				return false
			else
				f163_arg4.models.disabled = false
				f163_arg4.models.unavailable = false
				f163_arg4.models.skuID = f163_local2
				f163_arg4.properties.selectIndex = f163_local0 == 1
				return true
			end
		end
	end)
end, nil, nil, nil)
CoD.PlayerRoleUtility.MAX_SUPPORTED_POSITION_DRAFT_CLIENTS = 5
DataSourceHelpers.PerControllerDataSourceSetup("PositionDraftClients", "PositionDraftClients", function(f164_arg0, f164_arg1)
	local f164_local0 = {}
	for f164_local1 = 1, CoD.PlayerRoleUtility.MAX_SUPPORTED_POSITION_DRAFT_CLIENTS, 1 do
		local f164_local4 = f164_arg0:create(f164_local1)
		f164_local4:create("clientNum")
		f164_local4:create("characterIndex")
		f164_local4:create("clientInfo")
		f164_local4:create("visible")
		f164_local4:create("isLocalClient")
	end
end, false)
CoD.PlayerRoleUtility.MAX_SUPPORTED_LOBBY_CLIENTS = 12
DataSourceHelpers.GlobalDataSourceSetup("LobbyClients", "LobbyClients", function(f165_arg0, f165_arg1)
	local f165_local0 = {}
	local f165_local1 = Engine[0x8DF2E5447F384B9]()
	f165_local1 = f165_local1.LobbyClients:create(Engine[0x5065E759595C457](LuaDefine.INVALID_XUID_X64))
	if not f165_local1.gamertag then
		local f165_local2 = f165_local1:create("gamertag")
		f165_local2:set("")
	end
	if not f165_local1.xuid then
		local f165_local2 = f165_local1:create("xuid")
		f165_local2:set(LuaDefine.INVALID_XUID_X64)
	end
	if not f165_local1.clantag then
		local f165_local2 = f165_local1:create("clantag")
		f165_local2:set("")
	end
	for f165_local2 = 1, CoD.PlayerRoleUtility.MAX_SUPPORTED_LOBBY_CLIENTS, 1 do
		if not f165_arg0[f165_local2] then
			local f165_local5 = f165_arg0:create(f165_local2)
			local f165_local6 = f165_local5:create("info")
			f165_local6:set(f165_local1)
			f165_local6 = f165_local5:create("xuid")
			f165_local6:set(LuaDefine.INVALID_XUID_X64)
			f165_local5:create("available")
			f165_local5:create("visible")
			f165_local6 = f165_local5:create("sprayGestureIndex")
			f165_local6:set(-1)
		end
	end
end, false)
DataSources.PositionDraft = {
	getModel = function(f166_arg0)
		local f166_local0 = Engine[0x8DF2E5447F384B9]()
		f166_local0 = f166_local0.PositionDraft
		if f166_local0 == nil then
			local f166_local1 = Engine[0x8DF2E5447F384B9]()
			f166_local0 = f166_local1:create("PositionDraft")
		end
		if not f166_local0.characterSelected then
			local f166_local1 = f166_local0:create("characterSelected")
			f166_local1:set(false)
		end
		return f166_local0
	end,
}
CoD.PlayerRoleUtility.DraftTimeRemainingClockFraction = function(f167_arg0, f167_arg1, f167_arg2, f167_arg3, f167_arg4, f167_arg5)
	local f167_local0 = 10
	local f167_local1 = Engine[0x1E32FEF495242B8]()
	return 1, 1 - math.ceil(f167_arg2 / f167_local1.draftTime:get() * f167_local0) / f167_local0, 0, 0
end
CoD.PlayerRoleUtility.SetElementModelToPositionEditLoadoutClassModel = function(f168_arg0, f168_arg1)
	local f168_local0 = DataSources.PositionEditLoadout.getModel(f168_arg1)
	f168_local0 = f168_local0.classModel
	if f168_local0 then
		f168_arg0:setModel(f168_local0, f168_arg1)
	end
end
CoD.PlayerRoleUtility.SetPositionDraftSelectedCharacterIndex = function(f169_arg0)
	CoD.BaseUtility.InitControllerModel(f169_arg0, "PositionEditLoadout.SelectedCharacterIndex", Engine[0x40145EEB2E913D2](f169_arg0, Engine[0x761955642304848](f169_arg0)))
end
CoD.PlayerRoleUtility.UpdatePositionDraftClients = function(f170_arg0)
	local f170_local0 = 5
	local f170_local1 = 0
	local f170_local2 = {
		2,
		1,
		3,
		4,
		5,
	}
	local f170_local3 = Engine[0x761955642304848](f170_arg0)
	if InFrontend() then
		local f170_local4 = Engine[0x29B25E8DA873863](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0xA1647599284110])
		local f170_local5 = CoD.LobbyUtility.GetClientList()
		local f170_local6 = {}
		for f170_local10, f170_local11 in
			LUI.IterateTableBySortedKeys(f170_local5, function(f171_arg0, f171_arg1)
				f171_arg0 = f170_local5[f171_arg0]
				f171_arg1 = f170_local5[f171_arg1]
				if f171_arg0.isLocal or f171_arg1.isLocal then
					return f171_arg1.isLocal < f171_arg0.isLocal
				elseif f171_arg0.isMemberLeader or f171_arg1.isMemberLeader then
					return f171_arg1.isMemberLeader < f171_arg0.isMemberLeader
				elseif not (not f171_arg0.isMember or f171_arg1.isMember) or not f171_arg0.isMemberLeader and f171_arg1.isMember then
					return f171_arg1.isMember < f171_arg0.isMember
				else
					return f171_arg1.clientNum < f171_arg0.clientNum
				end
			end, nil)
		do
			if f170_local11.isMember == 1 or f170_local11.isLocal == 1 or IsZombies() then
				table.insert(f170_local6, f170_local11)
			end
		end
		f170_local7 = CoD.DirectorUtility.GetMainModeByLobbyNav()
		for f170_local8 = 1, f170_local0, 1 do
			local f170_local12 = f170_local6[f170_local8]
			local f170_local13 = "PositionDraftClients." .. f170_local8
			local f170_local14
			if f170_local12 then
				f170_local14 = f170_local12.clientNum
				if not f170_local14 then
				else
					local f170_local15
					if f170_local12 then
						f170_local15 = Engine[0x40145EEB2E913D2](f170_arg0, f170_local12.clientNum)
						if not f170_local15 then
						else
							local f170_local16 = Engine[0xE4D2F32833CFA6C](f170_local14)
							local f170_local17 = Engine[0x4DF5CFBC1771947](f170_arg0)
							local f170_local18
							if (f170_local7 ~= Enum[0x89C1455C5032969][0x78C124999125C42] or f170_local14 < 0) and (f170_local7 == Enum[0x89C1455C5032969][0x78C124999125C42] or f170_local8 > f170_local4) then
								f170_local18 = false
							else
								f170_local18 = true
							end
							local f170_local19 = f170_local17:create(f170_local13 .. ".clientNum")
							f170_local19:set(f170_local14)
							f170_local19 = f170_local17:create(f170_local13 .. ".characterIndex")
							f170_local19:set(f170_local15)
							f170_local19 = f170_local17:create(f170_local13 .. ".clientInfo")
							f170_local19:set(f170_local16)
							f170_local19 = f170_local17:create(f170_local13 .. ".visible")
							f170_local19:set(f170_local18)
							f170_local19 = f170_local17:create(f170_local13 .. ".isLocalClient")
							f170_local19:set(f170_local3 == f170_local14)
							f170_local19 = f170_local17:create(f170_local13 .. ".xuid")
							local f170_local20 = f170_local19
							f170_local19 = f170_local19.set
							local f170_local21
							if f170_local12 then
								f170_local21 = f170_local12.xuid
								if not f170_local21 then
								else
									f170_local19(f170_local20, f170_local21)
								end
							end
							f170_local21 = LuaDefine.INVALID_XUID_X64
						end
					end
					f170_local15 = f170_local1
				end
			end
			f170_local14 = -1
		end
		DataSourceHelperRecreate(f170_arg0, "DirectorCharacterButtonZMList")
		return
	else
		local f170_local4 = Engine[0x4FCDE749B09C3D6](f170_arg0)
		local f170_local5 = CoD.LobbyUtility.GetSortedClients(f170_arg0)
		local f170_local6 = CoD.TeamUtility.GetTeam(f170_arg0)
		local f170_local22 = f170_local5[f170_local6]
		if f170_local22 == nil and IsCodCaster(f170_arg0) then
			f170_local22 = f170_local5[CoD.TeamUtility.GetOppositeTeamAxisAllies(f170_local6)]
		end
		if f170_local22 and IsSplitscreenAndInGame(f170_arg0) then
			local f170_local7 = {}
			local f170_local8 = -1
			for f170_local9 = 1, f170_local0, 1 do
				local f170_local13 = f170_local22[f170_local9]
				if f170_local13 and f170_local13.clientNum == f170_local3 then
					f170_local8 = f170_local9
				else
					f170_local7[#f170_local7 + 1] = f170_local9
				end
			end
			if f170_local8 ~= -1 then
				table.insert(f170_local7, 2, f170_local8)
				f170_local2 = f170_local7
			end
		end
		if CoD.isCampaign then
			local f170_local7 = Engine[0x761955642304848](f170_arg0)
			f170_local0 = 4
			f170_local2 = {
				2,
				3,
				1,
				4,
			}
			local f170_local8 = function(f172_arg0, f172_arg1)
				local f172_local0 = f170_local22[f172_arg0]
				local f172_local1 = f170_local22[f172_arg1]
				local f172_local2
				if f172_local0 then
					f172_local2 = f172_local0.clientNum
					if not f172_local2 then
					else
						local f172_local3
						if f172_local1 then
							f172_local3 = f172_local1.clientNum
							if not f172_local3 then
							else
								if f172_local2 == f170_local7 or f172_local3 == f170_local7 then
									return f172_local2 == f170_local7
								elseif not f172_local0.isBot ~= not f172_local1.isBot then
									return not f172_local0.isBot
								elseif f172_local0.companionOwner == -1 ~= f172_local1.companionOwner == -1 then
									return f172_local0.companionOwner == -1
								else
									return f172_local0.companionOwner == f170_local7
								end
							end
						end
						f172_local3 = -1
					end
				end
				f172_local2 = -1
			end
			local f170_local9 = {}
			for f170_local13, f170_local14 in LUI.IterateTableBySortedKeys(f170_local22, f170_local8, nil) do
				table.insert(f170_local9, f170_local14)
			end
			f170_local22 = f170_local9
		end
		if f170_local22 then
			for f170_local7 = 1, f170_local0, 1 do
				local f170_local11 = f170_local22[f170_local7]
				local f170_local12 = "PositionDraftClients." .. f170_local2[f170_local7]
				local f170_local13
				if f170_local11 then
					f170_local13 = f170_local11.clientNum
					if not f170_local13 then
					else
						local f170_local14
						if f170_local11 then
							f170_local14 = Engine[0x40145EEB2E913D2](f170_arg0, f170_local11.clientNum)
							if not f170_local14 then
							else
								local f170_local15 = Engine[0xE4D2F32833CFA6C](f170_local13)
								local f170_local16 = Engine[0x4DF5CFBC1771947](f170_arg0)
								local f170_local17 = f170_local16:create(f170_local12 .. ".clientNum")
								f170_local17:set(f170_local13)
								f170_local17 = f170_local16:create(f170_local12 .. ".characterIndex")
								f170_local17:set(f170_local14)
								f170_local17 = f170_local16:create(f170_local12 .. ".clientInfo")
								f170_local17:set(f170_local15)
								f170_local17 = f170_local16:create(f170_local12 .. ".isLocalClient")
								f170_local17:set(f170_local3 == f170_local13)
							end
						end
						f170_local14 = f170_local1
					end
				end
				f170_local13 = -1
			end
		else
			for f170_local7 = 1, f170_local0, 1 do
				local f170_local11 = "PositionDraftClients." .. f170_local2[f170_local7]
				local f170_local12 = Engine[0x4DF5CFBC1771947](f170_arg0)
				local f170_local13 = f170_local12:create(f170_local11 .. ".clientNum")
				f170_local13:set(-1)
				f170_local13 = f170_local12:create(f170_local11 .. ".characterIndex")
				f170_local13:set(0)
				f170_local13 = f170_local12:create(f170_local11 .. ".clientInfo")
				f170_local13:set(nil)
				f170_local13 = f170_local12:create(f170_local11 .. ".isLocalClient")
				f170_local13:set(false)
			end
		end
	end
end
CoD.PlayerRoleUtility.GetPlayerNameForPositionDraftCharacter = function(f173_arg0, f173_arg1, f173_arg2)
	local f173_local0 = Dvar[0x5A2E5EE8014325D]:get()
	for f173_local1 = 0, f173_local0 - 1, 1 do
		local f173_local4 = Engine[0xE4D2F32833CFA6C](f173_local1)
		if f173_local4.characterIndex:get() == f173_arg1 and f173_local4.team:get() == f173_arg2 then
			return f173_local4.playerName:get()
		end
	end
	return ""
end
CoD.PlayerRoleUtility.UpdatePositionDraftCharacters = function(f174_arg0)
	local f174_local0 = Engine[0x3EAC408F958FF05]()
	if f174_local0 == Enum[0x9C0C2196D8313A0][0xB22E0240605CFFE] then
		return
	end
	local f174_local1 = CoD.PlayerRoleUtility.GetHeroListSorted(f174_local0)
	local f174_local2 = Engine[0x1E32FEF495242B8]()
	f174_local2 = f174_local2.maxUniqueRolesPerTeam
	local f174_local3 = CoD.TeamUtility.GetTeam(f174_arg0)
	local f174_local4 = Dvar[0x5A2E5EE8014325D]:get()
	local f174_local5 = {}
	local f174_local6 = {}
	for f174_local7 = 0, f174_local4 - 1, 1 do
		local f174_local10 = Engine[0xE4D2F32833CFA6C](f174_local7)
		if f174_local10.team:get() == f174_local3 then
			local f174_local11 = f174_local10.characterIndex
			if f174_local11 then
				f174_local11 = f174_local10.characterIndex:get()
			end
			if f174_local11 then
				f174_local5[f174_local11] = f174_local10.playerName:get()
				f174_local6[f174_local11] = (f174_local6[f174_local11] or 0) + 1
			end
		end
	end
	local f174_local7 = 1
	for f174_local10, f174_local11 in ipairs(f174_local1) do
		local f174_local13 = false
		if f174_local0 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] and LuaUtils.IsArenaMode() and CoDLoadoutsShared.ArenaHiddenPositionRoles[Engine[0x82C5756563934AE](f174_local0, f174_local11.bodyIndex)] then
			f174_local13 = true
		end
		if not f174_local13 then
			local f174_local14 = Engine[0x4DF5CFBC1771947](f174_arg0)
			local f174_local15 = f174_local14:create("PositionDraftCharacters." .. f174_local7)
			f174_local7 = f174_local7 + 1
			local f174_local16 = f174_local11.bodyIndex
			local f174_local17 = 0
			if f174_local2[f174_local16] then
				f174_local17 = f174_local2[f174_local16]:get()
			end
			local f174_local18 = f174_local6[f174_local16]
			if not f174_local18 then
				f174_local18 = 0
			end
			local f174_local19 = f174_local17 <= f174_local18
			local f174_local20 = f174_local15:create("unavailable")
			f174_local20:set(f174_local19)
			f174_local20 = f174_local5[f174_local16]
			if not f174_local20 then
				f174_local20 = ""
			end
			local f174_local21 = f174_local15:create("playerName")
			f174_local21:set(f174_local20)
		end
	end
end
CoD.PlayerRoleUtility.UpdateEnemyCountModels = function(f175_arg0)
	local f175_local0 = Engine[0xE4D2F32833CFA6C](Engine[0x761955642304848](f175_arg0))
	f175_local0 = f175_local0:create("team")
	f175_local0 = f175_local0:get()
	local f175_local1 = Engine[0x4DF5CFBC1771947](f175_arg0)
	f175_local1 = f175_local1:create("Clients.clientCount")
	f175_local1 = f175_local1:get()
	local f175_local2 = 0
	local f175_local3 = 0
	for f175_local4 = 0, f175_local1 - 1, 1 do
		local f175_local7 = Engine[0xE4D2F32833CFA6C](f175_local4)
		local f175_local8 = f175_local7:create("team")
		f175_local8 = f175_local8:get()
		if f175_local0 ~= f175_local8 and CoD.TeamUtility.IsValidPlayerTeam(f175_local8) then
			f175_local2 = f175_local2 + 1
			local f175_local9 = f175_local7:create("ready")
			if f175_local9:get() == 1 then
				f175_local3 = f175_local3 + 1
			end
		end
	end
	local f175_local4 = Engine[0x4DF5CFBC1771947](f175_arg0)
	f175_local4 = f175_local4:create("Clients.enemyCount")
	f175_local4:set(f175_local2)
	f175_local4 = Engine[0x4DF5CFBC1771947](f175_arg0)
	f175_local4 = f175_local4:create("Clients.enemiesReady")
	f175_local4:set(f175_local3)
end
CoD.PlayerRoleUtility.UpdatePositionDraftModels = function(f176_arg0)
	if CoD.isFrontend then
		for f176_local0 = 0, Engine[0xB686A0A723E6442]() - 1, 1 do
			CoD.PlayerRoleUtility.UpdatePositionDraftClients(f176_local0)
			CoD.PlayerRoleUtility.UpdatePositionDraftCharacters(f176_local0)
		end
	else
		CoD.PlayerRoleUtility.UpdatePositionDraftClients(f176_arg0)
		CoD.PlayerRoleUtility.UpdatePositionDraftCharacters(f176_arg0)
	end
	Engine[0x6ABA4D7F0840A1E](f176_arg0, "PositionDraft_Update", {
		localClientNum = Engine[0x7192908F4764ED3](f176_arg0),
	})
end
CoD.PlayerRoleUtility.InGameChangeSpecialist = function(f177_arg0, f177_arg1)
	local f177_local0 = f177_arg0:getModel()
	if f177_local0 then
		local f177_local1 = f177_local0 and f177_local0.characterIndex:get()
		if f177_local1 then
			Engine[0xC554A8C36EF7EFF](f177_arg1, "PositionDraft", "change_specialist", f177_local1)
		end
	end
end
CoD.PlayerRoleUtility.IsMaxUniqueRolesPerTeamInternal = function(f178_arg0, f178_arg1, f178_arg2, f178_arg3)
	return f178_arg3[f178_arg1]:get() <= Engine[0x3CC7B57F23F03F1](f178_arg0, f178_arg1, f178_arg2)
end
CoD.PlayerRoleUtility.IsAnyAbilityRestricted = function(f179_arg0)
	local f179_local0 = f179_arg0:getModel()
	if not f179_local0 or not f179_local0.equipment or not f179_local0.ability then
		return false
	else
		return f179_local0.equipment.isRestricted:get() or f179_local0.ability.isRestricted:get()
	end
end
CoD.PlayerRoleUtility.AreBothAbilitiesRestricted = function(f180_arg0)
	local f180_local0 = f180_arg0:getModel()
	if not f180_local0 or not f180_local0.equipment or not f180_local0.ability then
		return false
	else
		return f180_local0.equipment.isRestricted:get() and f180_local0.ability.isRestricted:get()
	end
end
CoD.PlayerRoleUtility.IsMaxUniqueRolesPerTeam = function(f181_arg0, f181_arg1)
	local f181_local0 = Engine[0x1E32FEF495242B8]()
	return CoD.PlayerRoleUtility.IsMaxUniqueRolesPerTeamInternal(f181_arg0, f181_arg1, CoD.TeamUtility.GetTeam(f181_arg0), f181_local0.maxUniqueRolesPerTeam)
end
CoD.PlayerRoleUtility.IsRoleDisabled = function(f182_arg0, f182_arg1)
	local f182_local0 = Engine[0x1E32FEF495242B8]()
	return f182_local0.maxUniqueRolesPerTeam[f182_arg1]:get() <= 0
end
CoD.PlayerRoleUtility.IsRoleUnlocked = function(f183_arg0, f183_arg1, f183_arg2)
	return LuaUtils.IsRoleUnlocked(f183_arg0, f183_arg1, f183_arg2)
end
CoD.PlayerRoleUtility.IsRoleBMLocked = function(f184_arg0, f184_arg1, f184_arg2)
	local f184_local0 = Engine[0xB678B832BC9DC0](f184_arg1, f184_arg2)
	if f184_local0 then
		local f184_local1 = f184_local0[0xA01F4246639318C]
		if f184_local1 and IsIntDvarNonZero(f184_local1) then
			return false
		elseif f184_local0[0x1D6157DBA773DA3] ~= nil and f184_local0[0x1D6157DBA773DA3] ~= 0x0 then
			return not CoDShared.IsNotLootItemOrIsOwnedById(f184_arg0, f184_local0[0x1D6157DBA773DA3])
		end
	end
	return false
end
CoD.PlayerRoleUtility.IsRoleBMUnavailable = function(f185_arg0, f185_arg1, f185_arg2)
	local f185_local0 = Engine[0xB678B832BC9DC0](f185_arg1, f185_arg2)
	if f185_local0 then
		local f185_local1 = f185_local0[0xA01F4246639318C]
		if f185_local1 and IsIntDvarNonZero(f185_local1) then
			return false
		end
		return f185_local2.isLoot and not f185_local2.available
	else
		return false
	end
end
CoD.PlayerRoleUtility.IsSpecialistSelectable = function(f186_arg0, f186_arg1)
	if not CoD.ModelUtility.IsSelfModelValueTrue(f186_arg0, f186_arg1, "disabled") then
		local f186_local0 = CoD.SafeGetModelValue(f186_arg0:getModel(), "characterIndex")
		if f186_local0 then
			if CoD.PlayerRoleUtility.IsMaxUniqueRolesPerTeam(f186_arg1, f186_local0) then
				return false
			elseif CoD.ModelUtility.IsModelValueGreaterThan(f186_arg1, "PositionDraft.cooldown", 0) then
				return false
			else
				return true
			end
		end
	end
	return false
end
CoD.PlayerRoleUtility.IsPositionDraftStage = function(f187_arg0, f187_arg1)
	return CoD.SafeGetModelValue(Engine[0x4DF5CFBC1771947](f187_arg0), "PositionDraft.stage") == f187_arg1
end
CoD.PlayerRoleUtility.IsSelectedShowcaseCharacter = function(f188_arg0, f188_arg1)
	local f188_local0 = f188_arg0:getModel()
	if f188_local0 then
		return Engine[0x1DC6357002DC122](f188_arg1, f188_local0.mode:get()) == f188_local0.characterIndex:get()
	else
		return false
	end
end
CoD.PlayerRoleUtility.SetAsSelectedShowcaseCharacter = function(f189_arg0, f189_arg1)
	local f189_local0 = f189_arg0:getModel()
	f189_local0 = f189_local0.mode:get()
	local f189_local1 = f189_arg0:getModel()
	f189_local1 = f189_local1.characterIndex:get()
	Engine[0x4437F83FC8ACDDF](f189_arg1, f189_local0, f189_local1, Enum[0xCEF757DAEA055BE][0xA5B65E8EFEF0028])
	if CoD.isPC then
		local f189_local2 = Engine[0x8DF2E5447F384B9]()
		f189_local2.currentShowcasedCharacterIndex:set(f189_local1)
	end
	Engine[0x6ABA4D7F0840A1E](f189_arg1, "change_frozen_moment_character", {
		mode = f189_local0,
		character_index = f189_local1,
		change_local = true,
	})
end
CoD.PlayerRoleUtility.PositionDraftCharactersPostLoad = function(f190_arg0, f190_arg1, f190_arg2)
	f190_arg2.filter = function(f191_arg0)
		local f191_local0 = Engine[0xB678B832BC9DC0](Engine[0x3EAC408F958FF05](), Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f191_arg0, "characterIndex")))
		if not f191_local0 or f191_local0[0xD3C54AD4040DDBE] ~= 1 then
			return false
		else
			return true
		end
	end
	f190_arg2:updateDataSource(true)
end
CoD.PlayerRoleUtility.PositionDraftPostLoad = function(f192_arg0, f192_arg1)
	f192_arg0.disableBlur = true
	if CoD.isPC then
		CoD.PCUtility.FlashWindowDefault()
	end
	if IsCodCaster(f192_arg1) and not CoD.TeamUtility.IsValidPlayerTeam(CoD.ShoutcasterProfileVarValue(f192_arg1, "shoutcaster_team")) then
		CoD.SetShoutcasterProfileVarValue(f192_arg1, "shoutcaster_team", Enum[0x13A4717E5AC547][0x2A34B055ADD98AB])
	end
	Engine[0x6ABA4D7F0840A1E](f192_arg1, "PositionDraft_Open", {
		localClientNum = Engine[0x7192908F4764ED3](f192_arg1),
	})
	local f192_local0 = f192_arg0
	local f192_local1 = f192_arg0.subscribeToModel
	local f192_local2 = Engine[0x4DF5CFBC1771947](f192_arg1)
	f192_local1(f192_local0, f192_local2:create("PositionDraft.stage"), function(f193_arg0)
		local f193_local0 = Engine[0x614D394F6F9A18D](f193_arg0)
		if f193_local0 == CoD.PlayerRoleUtility.DraftStage.DRAFT_STAGE_ALL_CLIENTS_READY or f193_local0 == CoD.PlayerRoleUtility.DraftStage.DRAFT_STAGE_ASSIGNMENT or f193_local0 == CoD.PlayerRoleUtility.DraftStage.DRAFT_STAGE_GAME_START then
			if IsMenuInState(f192_arg0, "EditLoadout") then
				SetLoseFocusToElement(f192_arg0, "StartMenuEditLoadout", f192_arg1)
				SaveLoadout(f192_arg0, f192_arg1)
				SendClientScriptNotify(f192_arg1, "PositionDraft_Loadout", "0")
			end
			f192_arg0:processEvent({
				name = "lose_focus",
				controller = f192_arg1,
				ignoreFocusCheck = true,
			})
			DataSourceHelperRecreate(f192_arg1, "PositionEditLoadout")
			if not CoD.isPC then
				CoD.PlayerRoleUtility.GoBackFromOccludingMenu(f192_arg0, f192_arg1)
			end
			if f192_arg0.occludedBy ~= nil then
				CoD.Menu.UpdateAllButtonPrompts(f192_arg0, f192_arg1)
			end
			PositionDraftOnFocusCharacterLost(nil, nil, f192_arg1, true)
			MenuHidesFreeCursor(f192_arg0, f192_arg1)
		elseif f193_local0 == CoD.PlayerRoleUtility.DraftStage.DRAFT_STAGE_FINALIZE then
			Engine[0x6ABA4D7F0840A1E](f192_arg1, "PositionDraft_Close", {
				localClientNum = Engine[0x7192908F4764ED3](f192_arg1),
			})
		elseif f193_local0 == CoD.PlayerRoleUtility.DraftStage.DRAFT_STAGE_NONE then
			Engine[0x20E69E0F0BB745E](false, f192_arg1)
			local f193_local1 = f192_arg0:getOwner() or 0
			Engine[0x1B838140C123BAC](f193_local1, 0)
			Engine[0x10BF7D7C03EECE6](f193_local1, false)
			Engine[0x9B8C02E7F47BDE3](f193_local1, false)
			CoD.PlayerRoleUtility.GoBackFromOccludingMenu(f192_arg0, f192_arg1)
			if f192_arg0.occludedBy ~= nil then
				CoD.Menu.UpdateAllButtonPrompts(f192_arg0, f192_arg1)
			end
			GoBack(f192_arg0, f192_arg1)
		end
	end)
	f192_local0 = f192_arg0
	f192_local1 = f192_arg0.subscribeToModel
	f192_local2 = Engine[0x8DF2E5447F384B9]()
	f192_local1(f192_local0, f192_local2:create("PositionDraft.timeRemaining"), function(f194_arg0)
		local f194_local0 = f194_arg0:get()
		local f194_local1 = Engine[0x4DF5CFBC1771947](f192_arg1)
		f194_local1 = f194_local1:create("PositionDraft.stage")
		f194_local1 = f194_local1:get()
		local f194_local2 = ""
		if f194_local0 <= 10 then
			f194_local2 = "uin_timer_10"
		else
			f194_local2 = ""
		end
		if f194_local1 == CoD.PlayerRoleUtility.DraftStage.DRAFT_STAGE_DRAFT and f194_local0 > 5 and f194_local2 ~= "" then
			Engine[0xC4146BA76D0F982](f194_local2, f192_arg1)
		end
		if f194_local1 == CoD.PlayerRoleUtility.DraftStage.DRAFT_STAGE_GAME_START or f194_local1 == CoD.PlayerRoleUtility.DraftStage.DRAFT_STAGE_DRAFT then
			if f194_local0 == 5 then
				if CoD.isPC then
					CoD.PCUtility.FlashWindowDefault()
				end
				Engine[0xC4146BA76D0F982]("uin_timer_5", f192_arg1)
			elseif f194_local0 == 4 then
				Engine[0xC4146BA76D0F982]("uin_timer_4", f192_arg1)
			elseif f194_local0 == 3 then
				Engine[0xC4146BA76D0F982]("uin_timer_3", f192_arg1)
			elseif f194_local0 == 2 then
				Engine[0xC4146BA76D0F982]("uin_timer_2", f192_arg1)
			elseif f194_local0 == 1 then
				Engine[0xC4146BA76D0F982]("uin_timer_1", f192_arg1)
			end
		end
		if f194_local1 == CoD.PlayerRoleUtility.DraftStage.DRAFT_STAGE_GAME_START and f194_local0 == 1 then
			f192_arg0:playClip("OneSecondRemaining")
		end
	end)
	CoD.PlayerRoleUtility.SubscribeForPostionDraftUpdates(f192_arg0, f192_arg1)
	f192_arg0:subscribeToModel(Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f192_arg1), "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0x198075B069840DC]), function(model)
		if Engine[0xDD333420C49E6D0](f192_arg1, Enum[0x7F032C2EF103A1A][0x198075B069840DC]) then
			f192_arg0:close()
		end
	end)
	LUI.OverrideFunction_CallOriginalSecond(f192_arg0, "close", function(element)
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f192_arg1), "isInPrematchPeriod"), 0)
		Engine[0x6ABA4D7F0840A1E](f192_arg1, "PositionDraft_Close", {
			localClientNum = Engine[0x7192908F4764ED3](f192_arg1),
		})
		local f196_local0 = element.occludedMenu
		if not f196_local0 then
			f196_local0 = element:getParent()
		end
		if f196_local0 ~= nil then
			f196_local0.PositionDraft = nil
			f196_local0.T7HudMenuGameMode:processEvent({
				name = "gain_focus",
				controller = f192_arg1,
			})
		end
	end)
end
CoD.PlayerRoleUtility.GoBackFromOccludingMenu = function(f197_arg0, f197_arg1)
	if f197_arg0.occludedBy ~= nil then
		local f197_local0 = f197_arg0.occludedBy
		while f197_local0 and f197_local0.occludedBy do
			f197_local0 = f197_local0.occludedBy
		end
		if f197_arg0.occludedBy.menuName == "StartMenu_Main" then
			StartMenuGoBack(f197_arg0.occludedBy, f197_arg1)
		end
		GoBackToMenu(f197_local0, f197_arg1, f197_arg0.menuName)
	end
end
CoD.PlayerRoleUtility.SubscribeForPostionDraftUpdates = function(f198_arg0, f198_arg1)
	local f198_local0 = f198_arg0
	local f198_local1 = f198_arg0.subscribeToModel
	local f198_local2 = DataSources.CodCaster.getModel(f198_arg1)
	f198_local1(f198_local0, f198_local2.profileSettingsUpdated, function(f199_arg0)
		CoD.PlayerRoleUtility.UpdatePositionDraftModels(f198_arg1)
	end)
	f198_local0 = f198_arg0
	f198_local1 = f198_arg0.subscribeToModel
	f198_local2 = Engine[0x4DF5CFBC1771947](f198_arg1)
	f198_local1(f198_local0, f198_local2:create("CharacterSelection.clientUpdated"), function(f200_arg0)
		if IsVisibilityBitSet(f198_arg1, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) then
			CoD.PlayerRoleUtility.UpdatePositionDraftModels(f198_arg1)
		end
	end)
	f198_local0 = f198_arg0
	f198_local1 = f198_arg0.subscribeToModel
	f198_local2 = Engine[0x8DF2E5447F384B9]()
	f198_local1(f198_local0, f198_local2:create("lobbyRoot.gameClient.update"), function(f201_arg0)
		CoD.PlayerRoleUtility.UpdatePositionDraftModels(f198_arg1)
	end)
	f198_local0 = f198_arg0
	f198_local1 = f198_arg0.subscribeToModel
	f198_local2 = Engine[0x4DF5CFBC1771947](f198_arg1)
	f198_local1(f198_local0, f198_local2:create("Clients.clientCount"), function(f202_arg0)
		if IsVisibilityBitSet(f198_arg1, Enum[0x7F032C2EF103A1A][0xA69E34E231CE8B6]) then
			CoD.PlayerRoleUtility.UpdatePositionDraftModels(f198_arg1)
		end
		CoD.PlayerRoleUtility.UpdateEnemyCountModels(f198_arg1)
	end)
	f198_local0 = f198_arg0
	f198_local1 = f198_arg0.subscribeToModel
	f198_local2 = Engine[0x4DF5CFBC1771947](f198_arg1)
	f198_local1(f198_local0, f198_local2:create("Clients.clientReadyCount"), function(f203_arg0)
		CoD.PlayerRoleUtility.UpdatePositionDraftModels(f198_arg1)
		CoD.PlayerRoleUtility.UpdateEnemyCountModels(f198_arg1)
	end)
	f198_local0 = f198_arg0
	f198_local1 = f198_arg0.subscribeToModel
	f198_local2 = Engine[0x4DF5CFBC1771947](f198_arg1)
	f198_local1(f198_local0, f198_local2:create("Clients.clientChangedTeam"), function(f204_arg0)
		CoD.PlayerRoleUtility.UpdateEnemyCountModels(f198_arg1)
	end)
end
CoD.PlayerRoleUtility.PositionDraftClientsSizeOverride = function(f205_arg0, f205_arg1)
	local f205_local0, f205_local1 = f205_arg0:getLocalSize()
	local f205_local2 = {}
	if CoD.isCampaign then
		f205_local2 = {
			80,
			10,
			10,
			80,
		}
	else
		f205_local2 = {
			120,
			80,
			10,
			80,
			120,
		}
	end
	f205_arg0.getHeightInList = function(f206_arg0)
		local f206_local0 = f205_local2[f206_arg0.gridInfoTable.gridColIndex]
		if f206_local0 ~= nil then
			return f205_local1 + f206_local0
		else
			return f205_local1
		end
	end
	local f205_local3 = {
		0,
		30,
		210,
		30,
		0,
	}
	f205_arg0.getWidthInList = function(f207_arg0)
		local f207_local0 = f205_local3[f207_arg0.gridInfoTable.gridColIndex]
		if f207_local0 ~= nil then
			return f205_local0 + f207_local0
		else
			return f205_local0
		end
	end
end
CoD.PlayerRoleUtility.SetSelectedSpecialistAsActive = function(f208_arg0, f208_arg1, f208_arg2)
	if CoD.isPC then
		local f208_local0 = CoD.PlayerRoleUtility.GetSelectedCharacterIndex(f208_arg0)
		if f208_local0 ~= nil and f208_local0 > 0 then
			local f208_local1, f208_local2 = f208_arg1:getRowAndColumnForIndex(f208_local0 - 1)
			local f208_local3 = f208_arg1:getItemAtPosition(f208_local1, f208_local2, true)
			if f208_local3 ~= nil then
				f208_arg1:SetNavigationItem(f208_local3, nil, f208_arg2)
				f208_local3:setState(f208_arg0, "SelectedPC")
			end
		end
	end
end
CoD.PlayerRoleUtility.ChooseSpecialistMidMatch = function(f209_arg0, f209_arg1)
	if not f209_arg0.ChooseSpecialistMidMatch and not Engine[0xA55C3ACD0D2BCF0]() and not CoD.HUDUtility.IsGameTypeEqualToString("bounty") then
		local f209_local0 = OpenOverlay(f209_arg0, "ChooseSpecialistMidMatch", f209_arg1)
		f209_arg0.ChooseSpecialistMidMatch = f209_local0
		LUI.OverrideFunction_CallOriginalSecond(f209_arg0, "close", function(element)
			if element.ChooseSpecialistMidMatch then
				element.ChooseSpecialistMidMatch:close()
			end
		end)
		LUI.OverrideFunction_CallOriginalSecond(f209_local0, "close", function()
			if f209_arg0.ChooseSpecialistMidMatch then
				f209_arg0.ChooseSpecialistMidMatch = nil
			end
		end)
	end
end
CoD.PlayerRoleUtility.IsFriendlyTeamStatusSlotHidden = function(f212_arg0, f212_arg1, f212_arg2)
	local f212_local0 = Engine[0x4DF5CFBC1771947](f212_arg1)
	f212_local0 = f212_local0.Clients
	if f212_local0 then
		return f212_local0.clientCount:get() - f212_local0.enemyCount:get() < f212_arg2
	else
		return true
	end
end
CoD.PlayerRoleUtility.IsFriendlyTeamStatusSlotActive = function(f213_arg0, f213_arg1, f213_arg2)
	local f213_local0 = Engine[0x4DF5CFBC1771947](f213_arg1)
	f213_local0 = f213_local0.Clients
	if f213_local0 then
		local f213_local1
		if f213_arg2 > f213_local0.clientCount:get() - f213_local0.enemyCount:get() or f213_arg2 > f213_local0.clientReadyCount:get() - f213_local0.enemiesReady:get() then
			f213_local1 = false
		else
			f213_local1 = true
		end
		return f213_local1
	else
		return false
	end
end
CoD.PlayerRoleUtility.IsEnemyTeamStatusSlotActive = function(f214_arg0, f214_arg1, f214_arg2)
	local f214_local0 = Engine[0x4DF5CFBC1771947](f214_arg1)
	f214_local0 = f214_local0.Clients
	if f214_local0 then
		local f214_local1
		if f214_arg2 > f214_local0.enemyCount:get() or f214_arg2 > f214_local0.enemiesReady:get() then
			f214_local1 = false
		else
			f214_local1 = true
		end
		return f214_local1
	else
		return false
	end
end
CoD.PlayerRoleUtility.IsEnemyTeamStatusSlotHidden = function(f215_arg0, f215_arg1, f215_arg2)
	local f215_local0 = Engine[0x4DF5CFBC1771947](f215_arg1)
	f215_local0 = f215_local0.Clients
	if f215_local0 then
		return f215_local0.enemyCount:get() < f215_arg2
	else
		return true
	end
end
CoD.PlayerRoleUtility.UpdateUsingController = function(f216_arg0)
	SendCustomClientScriptNotifyForAdjustedClient(f216_arg0, CoD.CACUtility.UpdateSpecialistEventNotify, {
		event_name = "update_lcn",
		local_client_num = Engine[0x7192908F4764ED3](f216_arg0),
	})
end
CoD.PlayerRoleUtility.UpdateSpecialist = function(f217_arg0, f217_arg1, f217_arg2)
	local f217_local0 = CoD.BaseUtility.GetMenuSessionMode(f217_arg0)
	local f217_local1 = f217_arg2.characterIndex
	if f217_local1 then
		SendCustomClientScriptMenuStateChangeNotify(f217_arg1, f217_arg0.menuName, true, f217_local1)
		DataSources.CharacterBreadcrumbs.updateAllCurrentSpecialistOutfitItemBreadcrumbs(f217_arg0, f217_arg1, f217_local1, CoD.PlayerRoleUtility.GetCachedHeroCustomization(f217_local0, f217_local1), false)
	end
end
CoD.PlayerRoleUtility.SetWZStartMenuPersonalizationCustomLeftFocus = function(f218_arg0, f218_arg1)
	if f218_arg0.framedWidget and f218_arg0.framedWidget._leftMostElement then
		CoD.BaseUtility.SetCustomNavDirection(CoD.BaseUtility.NavigationDirection.left, f218_arg0.framedWidget._leftMostElement, f218_arg1)
	end
end
