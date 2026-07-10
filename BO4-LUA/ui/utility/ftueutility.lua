CoD.FTUEUtility = {}
require("x64:f3c5259f470592d")
CoD.FTUEUtility.FTUELayouts = LuaEnum.createEnum("Entries1", "Entries2", "Entries3", "WZInventory", "ZMLoadout", "Echelon", "GameIntro", "WarningEntry", "StoreUpsell", "PromoEvent", "HoldButtonEntries1")
CoD.FTUEUtility.SpecialFTUEOverlays = {
	[CoD.FTUEUtility.FTUELayouts.WZInventory] = "FTUEWZInventoryMenu",
	[CoD.FTUEUtility.FTUELayouts.ZMLoadout] = "FTUEZMInventoryMenu",
	[CoD.FTUEUtility.FTUELayouts.Echelon] = "FTUEWZProgressionMenu",
}
CoD.FTUEUtility.FTUESequences = {}
CoD.FTUEUtility.FTUESequences.GameIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.GameIntro,
			overlayTitle = @"hash_59413BCBC84F738A",
			overlayInfoEntries = {
				{
					models = {
						displayTitle = @"menu/multiplayer",
						displayText = @"hash_192855996C8E28F2",
						image = @"ui_menu_ftue_welcome_mp_sm",
					},
				},
				{
					models = {
						displayTitle = @"menu/warzone",
						displayText = @"hash_190653996C713F26",
						image = @"ui_menu_ftue_welcome_wz_sm",
					},
				},
				{
					models = {
						displayTitle = @"menu/zombies",
						displayText = @"hash_18FC6A996C6911B6",
						image = @"ui_menu_ftue_welcome_zm_sm",
						removedInKorea15 = true,
					},
				},
				{
					models = {
						displayTitle = @"menu/specialist_hub",
						displayText = @"hash_6C51E146D5995102",
						image = @"ui_menu_ftue_welcome_hq_sm",
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f1_arg0, f1_arg1)
		CoD.LobbyUtility.CompleteFTUEIntro(f1_arg0, f1_arg1)
	end,
}
CoD.FTUEUtility.FTUESequences.WZIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries3,
			overlayTitle = @"hash_3511100B58E0378C",
			overlayInfoEntries = {
				{
					models = {
						displayTitle = @"hash_ED31E7E5010EC4A",
						displayText = @"hash_582C11675D201653",
						image = @"ui_menu_ftue_how_to_wz_01",
					},
				},
				{
					models = {
						displayTitle = @"hash_ED31D7E5010EA97",
						displayText = @"hash_582C12675D201806",
						image = @"ui_menu_ftue_how_to_wz_02",
						korea15Image = @"ui_menu_ftue_how_to_wz_02_korea_pc",
					},
				},
				{
					models = {
						displayTitle = @"hash_ED31C7E5010E8E4",
						displayText = @"hash_582C13675D2019B9",
						image = @"ui_menu_ftue_how_to_wz_03",
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f2_arg0, f2_arg1)
		GoBack(f2_arg0, f2_arg1)
		Engine[@"storagewrite"](f2_arg1, Enum[@"storagefiletype"][@"storage_wz_stats_online"])
	end,
}
CoD.FTUEUtility.FTUESequences.WZProgressionInfo = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Echelon,
			overlayTitle = @"hash_0",
			overlayInfoEntries = {
				{
					models = {
						displayTitle = @"hash_0",
						displayText = @"hash_0",
						image = nil,
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f3_arg0, f3_arg1)
		GoBack(f3_arg0, f3_arg1)
		Engine[@"storagewrite"](f3_arg1, Enum[@"storagefiletype"][@"storage_wz_stats_online"])
	end,
}
CoD.FTUEUtility.FTUESequences.MPIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = @"hash_3DCDBDBD84A037C2",
			overlayInfoEntries = {
				{
					models = {
						displayTitle = @"hash_0",
						displayText = @"hash_6F6EB618C89C652",
						image = @"ui_menu_ftue_wz_mp",
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f4_arg0, f4_arg1)
		GoBack(f4_arg0, f4_arg1)
		Engine[@"storagewrite"](f4_arg1, Enum[@"storagefiletype"][@"storage_mp_stats_online"])
	end,
}
CoD.FTUEUtility.FTUESequences.ZMIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = @"hash_6E7C9BD874F4A11B",
			overlayInfoEntries = {
				{
					models = {
						displayTitle = @"hash_0",
						displayText = @"hash_43009B862F6F78CD",
						image = @"ui_menu_ftue_zm_welcome",
					},
				},
			},
		},
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries3,
			overlayTitle = @"hash_78DE7ECBB713525",
			overlayInfoEntries = {
				{
					models = {
						displayTitle = @"hash_C3A14F195A42AC9",
						displayText = @"hash_E300F74F4198B83",
						image = @"ui_menu_ftue_zm_tutorial_01",
					},
				},
				{
					models = {
						displayTitle = 0x678399F6FD3847,
						displayText = @"hash_7FAA2C5D4BD4BED9",
						image = @"ui_menu_ftue_zm_custom",
					},
				},
				{
					models = {
						displayTitle = @"hash_2862BE43BBA920BB",
						displayText = @"hash_339944E55FBACAD",
						image = @"ui_menu_ftue_zm_public_02",
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f5_arg0, f5_arg1)
		GoBack(f5_arg0, f5_arg1)
		Engine[@"storagewrite"](f5_arg1, Enum[@"storagefiletype"][@"storage_zm_stats_online"])
	end,
}
CoD.FTUEUtility.FTUESequences.ZMFeaturedPlaylistIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = @"hash_7DC8670AD8269CF1",
			overlayInfoEntries = {
				{
					models = {
						displayTitle = @"hash_0",
						displayText = @"hash_7BC680D6F37FDC4B",
						image = @"ui_menu_ftue_zm_featured_playlist",
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f6_arg0, f6_arg1)
		GoBack(f6_arg0, f6_arg1)
		Engine[@"storagewrite"](f6_arg1, Enum[@"storagefiletype"][@"storage_zm_stats_online"])
	end,
}
CoD.FTUEUtility.FTUESequences.ZMClassicPlaylistIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = @"menu/classic_mode",
			overlayInfoEntries = {
				{
					models = {
						displayTitle = @"hash_0",
						displayText = @"hash_3A9104E2E61DA0CB",
						image = @"ui_menu_ftue_zm_classic_mode",
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f7_arg0, f7_arg1)
		GoBack(f7_arg0, f7_arg1)
		Engine[@"storagewrite"](f7_arg1, Enum[@"storagefiletype"][@"storage_zm_stats_online"])
	end,
}
CoD.FTUEUtility.FTUESequences.ZMZombieRushPlaylistIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = @"hash_680680DEAE7D6042",
			overlayInfoEntries = {
				{
					models = {
						displayTitle = @"hash_0",
						displayText = @"hash_449529904F556FD2",
						image = @"ui_menu_ftue_zm_public",
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f8_arg0, f8_arg1)
		GoBack(f8_arg0, f8_arg1)
		Engine[@"storagewrite"](f8_arg1, Enum[@"storagefiletype"][@"storage_zm_stats_online"])
	end,
}
CoD.FTUEUtility.FTUESequences.ZMTCMPlaylistIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = @"menu/tcm",
			overlayInfoEntries = {
				{
					models = {
						displayTitle = @"hash_0",
						displayText = @"menu/tcm_desc",
						image = @"ui_menu_ftue_zm_treyarch_custom",
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f9_arg0, f9_arg1)
		GoBack(f9_arg0, f9_arg1)
		Engine[@"storagewrite"](f9_arg1, Enum[@"storagefiletype"][@"storage_zm_stats_online"])
	end,
}
CoD.FTUEUtility.FTUESequences.ZMGauntletPlaylistIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = @"menu/gauntlet_mode",
			overlayInfoEntries = {
				{
					models = {
						displayTitle = @"hash_0",
						displayText = @"hash_5DCD6630A166A67",
						image = @"ui_menu_ftue_zm_gauntlet_mode",
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f10_arg0, f10_arg1)
		GoBack(f10_arg0, f10_arg1)
		Engine[@"storagewrite"](f10_arg1, Enum[@"storagefiletype"][@"storage_zm_stats_online"])
	end,
}
CoD.FTUEUtility.FTUESequences.ZMTutorialPlaylistIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = @"menu/tutorial_mode",
			overlayInfoEntries = {
				{
					models = {
						displayTitle = @"hash_0",
						displayText = @"hash_153C9892E9FF4223",
						image = @"ui_menu_ftue_zm_tutorial_mode",
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f11_arg0, f11_arg1)
		GoBack(f11_arg0, f11_arg1)
		Engine[@"storagewrite"](f11_arg1, Enum[@"storagefiletype"][@"storage_zm_stats_online"])
	end,
}
CoD.FTUEUtility.FTUESequences.ZMCustomGameIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = 0xD3DE85892CAF1F,
			overlayInfoEntries = {
				{
					models = {
						displayTitle = @"hash_0",
						displayText = @"hash_46B72E64033999B1",
						image = @"ui_menu_ftue_zm_custom_mutations",
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f12_arg0, f12_arg1)
		GoBack(f12_arg0, f12_arg1)
		Engine[@"storagewrite"](f12_arg1, Enum[@"storagefiletype"][@"storage_zm_stats_online"])
	end,
}
CoD.FTUEUtility.FTUESequences.ZMLoadoutIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.ZMLoadout,
			overlayTitle = @"hash_3AADDF41A08B2C4E",
			overlayInfoEntries = {
				{
					models = {
						displayTitle = @"hash_0",
						displayText = @"hash_0",
						image = @"ui_menu_ftue_zm_armory",
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f13_arg0, f13_arg1)
		GoBack(f13_arg0, f13_arg1)
		Engine[@"storagewrite"](f13_arg1, Enum[@"storagefiletype"][@"storage_zm_stats_online"])
	end,
}
CoD.FTUEUtility.FTUESequences.ZMArmoryIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = @"menu/armory",
			overlayInfoEntries = {
				{
					models = {
						displayTitle = @"hash_0",
						displayText = @"hash_561686A90FF924C3",
						image = @"ui_menu_ftue_zm_armory",
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f14_arg0, f14_arg1)
		GoBack(f14_arg0, f14_arg1)
		Engine[@"storagewrite"](f14_arg1, Enum[@"storagefiletype"][@"storage_zm_stats_online"])
	end,
}
CoD.FTUEUtility.FTUESequences.ZMLaboratoryIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = @"hash_96D9A8F7540D6B6",
			overlayInfoEntries = {
				{
					models = {
						displayTitle = @"hash_0",
						displayText = @"hash_165A3A325CF99AC6",
						image = @"ui_menu_ftue_zm_alchemical_lab",
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f15_arg0, f15_arg1)
		GoBack(f15_arg0, f15_arg1)
		Engine[@"storagewrite"](f15_arg1, Enum[@"storagefiletype"][@"storage_zm_stats_online"])
	end,
}
CoD.FTUEUtility.FTUESequences.BlackMarketIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = @"menu/black_market",
			overlayInfoEntries = {
				{
					models = {
						displayTitle = @"hash_0",
						displayText = @"hash_774DC5569EB9B521",
						image = @"ui_menu_ftue_blackmarket",
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f16_arg0, f16_arg1)
		GoBack(f16_arg0, f16_arg1)
		Engine[@"storagewrite"](f16_arg1, Enum[@"storagefiletype"][@"storage_mp_stats_online"])
	end,
}
CoD.FTUEUtility.FTUESequences.GestureChanges = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = @"hash_51F031657F740298",
			overlayInfoEntries = {
				{
					models = {
						displayTitle = @"hash_0",
						displayText = @"hash_496B7DBBFE1B0C80",
						image = @"ui_menu_ftue_outfitupdates",
					},
				},
			},
		},
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = @"hash_51F034657F7407B1",
			overlayInfoEntries = {
				{
					models = {
						displayTitle = @"hash_0",
						displayText = CoD.isPC and @"hash_6CBA61000157D25" or @"hash_4F6436C07D4A7D0B",
						image = @"ui_menu_ftue_gesture",
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f17_arg0, f17_arg1)
		GoBack(f17_arg0, f17_arg1)
		Engine[@"storagewrite"](f17_arg1, Enum[@"storagefiletype"][@"storage_mp_stats_online"])
	end,
}
CoD.FTUEUtility.FTUESequences.ZMGestureChanges = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = @"hash_2FEEE47792CA83DC",
			overlayInfoEntries = {
				{
					models = {
						displayTitle = @"hash_0",
						displayText = @"hash_186A4B78E7BE9A24",
						image = @"ui_menu_ftue_outfitupdates_zm",
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f18_arg0, f18_arg1)
		GoBack(f18_arg0, f18_arg1)
		Engine[@"storagewrite"](f18_arg1, Enum[@"storagefiletype"][@"storage_zm_stats_online"])
	end,
}
CoD.FTUEUtility.FTUESequences.WeaponPersonalizationChanges = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = @"hash_4C4D7803D4E195FA",
			overlayInfoEntries = {
				{
					models = {
						displayTitle = @"hash_0",
						displayText = CoD.isPC and @"hash_2D8E3FCE949A0E6A" or @"hash_6ADB8634CCDA72CA",
						image = @"ui_menu_ftue_weaponupdates",
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f19_arg0, f19_arg1)
		GoBack(f19_arg0, f19_arg1)
		Engine[@"storagewrite"](f19_arg1, Enum[@"storagefiletype"][@"storage_mp_stats_online"])
	end,
}
CoD.FTUEUtility.FTUESequences.KoreaSpecialEvent = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = @"hash_35BD9225FA6071E5",
			overlayInfoEntries = {
				{
					models = {
						displayTitle = @"hash_0",
						displayText = @"hash_3301910733BE3180",
						image = @"ui_menu_ftue_wz_mp_korea",
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f20_arg0, f20_arg1)
		GoBack(f20_arg0, f20_arg1)
	end,
}
CoD.FTUEUtility.FTUESequences.LeaguePlayIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = @"hash_7022CD1299D402C",
			overlayInfoEntries = {
				{
					models = {
						displayTitle = @"hash_0",
						displayText = @"hash_1EBC18FE024FCDD4",
						image = @"ui_menu_ftue_wl_welcome",
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f21_arg0, f21_arg1)
		GoBack(f21_arg0, f21_arg1)
		CoDLoadoutsShared[@"hash_7243F374ADEF72D"](f21_arg1, Enum[@"storagefiletype"][0x67DF1879D992E], @"mp_arena_default_loadouts")
		CoDLoadoutsShared[@"hash_7243F374ADEF72D"](f21_arg1, Enum[@"storagefiletype"][@"hash_CEBE62E27709AD0"], @"mp_arena_default_loadouts")
		CoDLoadoutsShared[@"hash_7243F374ADEF72D"](f21_arg1, Enum[@"storagefiletype"][@"hash_D062FA7B47FC13A"], @"mp_arena_default_loadouts")
		Engine[@"storagewrite"](f21_arg1, Enum[@"storagefiletype"][@"storage_mp_stats_online"])
	end,
}
CoD.FTUEUtility.FTUESequences.BlackMarketSeasonThreeIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = @"hash_7FB0E22B54FE01",
			overlayInfoEntries = {
				{
					models = {
						displayTitle = @"hash_0",
						displayText = @"hash_225DEE051ED23C88",
						image = @"ui_menu_ftue_contraband",
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f22_arg0, f22_arg1)
		GoBack(f22_arg0, f22_arg1)
		Engine[@"storagewrite"](f22_arg1, Enum[@"storagefiletype"][@"storage_mp_stats_online"])
	end,
}
CoD.FTUEUtility.FTUESequences.BlackjackReservesIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = @"hash_2275A7D7A83013E5",
			overlayInfoEntries = {
				{
					models = {
						displayTitle = @"hash_0",
						displayText = @"hash_1E5136996115F694",
						image = @"ui_menu_ftue_blackjackreserves",
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f23_arg0, f23_arg1)
		local f23_local0 = GoBack(f23_arg0, f23_arg1)
		if not IsBooleanDvarSet(@"hash_1A8E4D68B803874") then
			CoD.BlackMarketUtility.PlayReservesPreviewVideo(f23_arg1, f23_local0, true, true)
		end
		Engine[@"storagewrite"](f23_arg1, Enum[@"storagefiletype"][@"storage_mp_stats_online"])
	end,
}
CoD.FTUEUtility.FTUESequences.BlackjackShopIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = @"hash_3C2C43BD810C5C48",
			overlayInfoEntries = {
				{
					models = {
						displayTitle = @"hash_0",
						displayText = @"hash_3BA06143D9A210F",
						image = @"ui_menu_ftue_itemshop",
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f24_arg0, f24_arg1)
		GoBack(f24_arg0, f24_arg1)
		Engine[@"storagewrite"](f24_arg1, Enum[@"storagefiletype"][@"storage_mp_stats_online"])
	end,
}
CoD.FTUEUtility.FTUESequences.BlackMarketInventoryIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = @"hash_67EFD3D64C509ABB",
			overlayInfoEntries = {
				{
					models = {
						displayTitle = @"hash_0",
						displayText = @"hash_230E72AC1A617CD6",
						image = @"ui_menu_ftue_inventory",
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f25_arg0, f25_arg1)
		GoBack(f25_arg0, f25_arg1)
		Engine[@"storagewrite"](f25_arg1, Enum[@"storagefiletype"][@"storage_mp_stats_online"])
	end,
}
CoD.FTUEUtility.FTUESequences.BlackOpsPassUpsell = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.StoreUpsell,
			overlayTitle = @"hash_3BB8C7DC3C3EB0CB",
			overlayInfoEntries = {
				{
					models = {
						displayTitle = @"hash_0",
						displayText = 0x9A35875D151FC1,
						image = @"ui_menu_ftue_store_blackopspass",
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f26_arg0, f26_arg1)
		GoBack(f26_arg0, f26_arg1)
		local f26_local0 = Engine[@"getmodel"](Engine[@"getmodelforcontroller"](f26_arg1), "Store.FeaturedProductList")
		if f26_local0 then
			local f26_local1 = 1
			while f26_local0[f26_local1] ~= nil do
				local f26_local2 = f26_local0[f26_local1].productNameHash
				if f26_local2 then
					f26_local2 = f26_local0[f26_local1].productNameHash:get()
				end
				if f26_local2 == @"blackopspass" then
					local f26_local3 = f26_local0[f26_local1].productID
					if f26_local3 then
						f26_local3 = f26_local0[f26_local1].productID:get()
					end
					if f26_local3 then
						if IsDurango() then
							Engine[@"hash_1D58E665ABB6A9AE"](f26_arg1, "featured", f26_local3)
						elseif IsOrbis() then
							local f26_local4 = f26_local0[f26_local1].serviceLabel
							if f26_local4 then
								f26_local4 = f26_local0[f26_local1].serviceLabel:get()
							end
							if f26_local4 then
								Engine[@"hash_1D58E665ABB6A9AE"](f26_arg1, "featured", f26_local3, f26_local4)
							end
						end
					end
					return
				end
				f26_local1 = f26_local1 + 1
			end
		end
	end,
}
CoD.FTUEUtility.FTUESequences.PromoEvent = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.PromoEvent,
			overlayTitle = @"hash_1C9B32C16D19F3C0",
			overlayInfoEntries = {
				{
					models = {
						displayTitle = @"hash_0",
						displayText = @"hash_2E59FC3EFBE5237",
						image = @"ui_icon_blackmarket_promos_shamrock_and_awe",
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f27_arg0, f27_arg1)
		local f27_local0 = GoBack(f27_arg0, f27_arg1)
		local f27_local1 = ""
		if CoD.isPC then
			f27_local1 = {
				__onQuit = function()
					Engine[@"lobbyevent"]("OnGoForward", {
						controller = f27_arg1,
						navToMenu = "director",
					})
				end,
			}
		end
		Engine[@"storagewrite"](f27_arg1, Enum[@"storagefiletype"][@"storage_mp_stats_online"])
		OpenQuarterMaster(f27_local0, f27_local0, f27_arg1, f27_local1, f27_local0)
	end,
}
CoD.FTUEUtility.FTUESequences.BlackMarketSunsetIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.HoldButtonEntries1,
			overlayTitle = @"hash_298662FD51593715",
			overlayInfoEntries = {
				{
					models = {
						displayTitle = @"hash_0",
						displayText = @"hash_1692701BEA54FDC4",
						image = @"hash_28E8508A8B137347",
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f29_arg0, f29_arg1)
		GoBack(f29_arg0, f29_arg1)
		Engine[@"storagewrite"](f29_arg1, Enum[@"storagefiletype"][@"storage_mp_stats_online"])
	end,
}
CoD.FTUEUtility.WriteMPStats = function(f30_arg0)
	Engine[@"storagewrite"](f30_arg0, Enum[@"storagefiletype"][@"storage_mp_stats_online"])
end
CoD.FTUEUtility.FTUESequences.ZMFactionCallingsIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = @"hash_5A8A1AE4754B2601",
			overlayInfoEntries = {
				{
					models = {
						displayTitle = @"hash_0",
						displayText = @"hash_247E54D0C1B51F89",
						image = @"ui_menu_ftue_zm_alchemical_lab",
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f31_arg0, f31_arg1)
		GoBack(f31_arg0, f31_arg1)
		Engine[@"storagewrite"](f31_arg1, Enum[@"storagefiletype"][@"storage_zm_stats_online"])
	end,
}
CoD.FTUEUtility.PlaySpecialistHQIntroductionMovie = function(f32_arg0, f32_arg1)
	local f32_local0 = function(f33_arg0, f33_arg1, f33_arg2)
		GoBack(f32_arg0, f33_arg1)
		local f33_local0 = DataSources.SpecialistHeadquarters.getModel(f33_arg1)
		f33_local0.StartFullscreenBlack:set(false)
	end
	local f32_local1 = CoD.CTUtility.GetArchivesBundle()
	CoD.CTUtility.PlaySkippableVideo(f32_arg1, f32_arg0, f32_local1[@"hash_7C873FF231AABAE6"], f32_local1[@"hash_62EDACFCAA4E38C7"] ~= 0, {
		onlySkippable = true,
		on_pre_finished_movie_playback = f32_local0,
	})
	CoD.CTUtility.SetSeenMovie(f32_arg1, @"story_intro")
	Engine[@"storagewrite"](f32_arg1, Enum[@"storagefiletype"][@"hash_77FA8C2EEB2B6F7A"])
end
CoD.FTUEUtility.FTUESequences.SpecialistHQIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.WarningEntry,
			overlayTitle = @"hash_2C03DE6970599340",
			overlayInfoEntries = {
				{
					models = {
						displayTitle = @"hash_0",
						displayText = @"hash_153BB50D4C2574B7",
						image = @"ui_menu_ftue_wz_mp",
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f34_arg0, f34_arg1)
		local f34_local0 = CoD.CTUtility.GetArchivesBundle()
		local f34_local1 = CoD.isPC
		if f34_local1 then
			f34_local1 = CoD.PCKoreaUtility.ShowKorea15Plus()
		end
		if not f34_local1 and f34_local0[@"hash_7C873FF231AABAE6"] ~= nil and f34_local0[@"hash_7C873FF231AABAE6"] ~= "" and CoD.CTUtility.CanPlayVideo(f34_arg1, f34_local0[@"hash_641FF0587D0A3B33"]) then
			local f34_local2 = GoBack(f34_arg0, f34_arg1)
			OpenSystemOverlay(f34_local2, f34_local2, f34_arg1, "SpecialistHQGraphicContentWarning", nil)
		else
			GoBack(f34_arg0, f34_arg1)
			local f34_local2 = DataSources.SpecialistHeadquarters.getModel(f34_arg1)
			f34_local2.StartFullscreenBlack:set(false)
			CoD.CTUtility.SetSeenMovie(f34_arg1, @"story_intro")
			Engine[@"storagewrite"](f34_arg1, Enum[@"storagefiletype"][@"hash_77FA8C2EEB2B6F7A"])
		end
	end,
}
CoD.FTUEUtility.CurrentSequenceIndex = 1
CoD.FTUEUtility.CurrentSequenceReference = ""
CoD.FTUEUtility.CurrentListReference = nil
CoD.FTUEUtility.FTUEGameModeToSequence = {
	[Enum[@"emodes"][@"mode_multiplayer"]] = "MPIntroduction",
	[Enum[@"emodes"][@"mode_warzone"]] = "WZIntroduction",
	[Enum[@"emodes"][@"mode_zombies"]] = "ZMIntroduction",
}
CoD.FTUEUtility.FTUESequenceToSequenceInfo = {
	ZMFeaturedPlaylistIntroduction = {
		gameMode = Enum[@"emodes"][@"mode_zombies"],
		statsVariable = "completedFeaturedPlaylistIntroduction",
		onlyShowForGivenMode = true,
	},
	ZMClassicPlaylistIntroduction = {
		gameMode = Enum[@"emodes"][@"mode_zombies"],
		statsVariable = "completedClassicPlaylistIntroduction",
		onlyShowForGivenMode = true,
	},
	ZMZombieRushPlaylistIntroduction = {
		gameMode = Enum[@"emodes"][@"mode_zombies"],
		statsVariable = "completedZombieRushPlaylistIntroduction",
		onlyShowForGivenMode = true,
	},
	ZMTCMPlaylistIntroduction = {
		gameMode = Enum[@"emodes"][@"mode_zombies"],
		statsVariable = "completedTCMPlaylistIntroduction",
		onlyShowForGivenMode = true,
	},
	ZMGauntletPlaylistIntroduction = {
		gameMode = Enum[@"emodes"][@"mode_zombies"],
		statsVariable = "completedGauntletPlaylistIntroduction",
		onlyShowForGivenMode = true,
	},
	ZMTutorialPlaylistIntroduction = {
		gameMode = Enum[@"emodes"][@"mode_zombies"],
		statsVariable = "completedTutorialPlaylistIntroduction",
		onlyShowForGivenMode = true,
	},
	ZMCustomGameIntroduction = {
		gameMode = Enum[@"emodes"][@"mode_zombies"],
		statsVariable = "completedCustomGameFirstTimeFlow",
		onlyShowForGivenMode = true,
	},
	ZMLoadoutIntroduction = {
		gameMode = Enum[@"emodes"][@"mode_zombies"],
		statsVariable = "completedLoadoutFirstTimeFlow",
		onlyShowForGivenMode = true,
	},
	ZMArmoryIntroduction = {
		gameMode = Enum[@"emodes"][@"mode_zombies"],
		statsVariable = "completedArmoryFirstTimeFlow",
		onlyShowForGivenMode = true,
	},
	ZMLaboratoryIntroduction = {
		gameMode = Enum[@"emodes"][@"mode_zombies"],
		statsVariable = "completedLaboratoryFirstTimeFlow",
		onlyShowForGivenMode = true,
	},
	ZMFactionCallingsIntroduction = {
		gameMode = Enum[@"emodes"][@"mode_zombies"],
		statsVariable = "completedFactionCallingsFirstTimeFlow",
		onlyShowForGivenMode = true,
	},
	ZMGestureChanges = {
		gameMode = Enum[@"emodes"][@"mode_zombies"],
		statsVariable = "completedUpdatedGestureFlow",
		onlyShowForGivenMode = true,
	},
	WZProgressionInfo = {
		gameMode = Enum[@"emodes"][@"mode_warzone"],
		statsVariable = "completedWZProgressionFirstTimeFlow",
		onlyShowForGivenMode = true,
	},
	BlackMarketIntroduction = {
		gameMode = Enum[@"emodes"][@"mode_multiplayer"],
		statsVariable = "completedBlackMarketFirstTimeFlow",
		onlyShowForGivenMode = false,
	},
	GestureChanges = {
		gameMode = Enum[@"emodes"][@"mode_multiplayer"],
		statsVariable = "completedUpdatedGestureFlow",
		onlyShowForGivenMode = false,
	},
	WeaponPersonalizationChanges = {
		gameMode = Enum[@"emodes"][@"mode_multiplayer"],
		statsVariable = "completedUpdatedWeaponPersonalizationFlow",
		onlyShowForGivenMode = false,
	},
	KoreaSpecialEvent = {
		gameMode = Enum[@"emodes"][@"mode_multiplayer"],
		statsVariable = "completedKoreaSpecialEventPopup",
		onlyShowForGivenMode = false,
	},
	LeaguePlayIntroduction = {
		gameMode = Enum[@"emodes"][@"mode_multiplayer"],
		statsVariable = "completedArenaFirstTimeFlow",
		onlyShowForGivenMode = true,
	},
	BlackMarketSeasonThreeIntroduction = {
		gameMode = Enum[@"emodes"][@"mode_multiplayer"],
		statsVariable = "completedBlackMarketSeasonThreeFirstTimeFlow",
		onlyShowForGivenMode = false,
	},
	BlackjackReservesIntroduction = {
		gameMode = Enum[@"emodes"][@"mode_multiplayer"],
		statsVariable = "completedBlackjackReservesFirstTimeFlow",
		onlyShowForGivenMode = false,
	},
	BlackjackShopIntroduction = {
		gameMode = Enum[@"emodes"][@"mode_multiplayer"],
		statsVariable = "completedBlackjackShopFirstTimeFlow",
		onlyShowForGivenMode = false,
	},
	BlackMarketInventoryIntroduction = {
		gameMode = Enum[@"emodes"][@"mode_multiplayer"],
		statsVariable = "completedBlackMarketInventoryFirstTimeFlow",
		onlyShowForGivenMode = false,
	},
	BlackOpsPassUpsell = {
		gameMode = Enum[@"emodes"][@"mode_multiplayer"],
		statsVariable = "unusedVariable",
		onlyShowForGivenMode = false,
	},
	PromoEvent = {
		gameMode = Enum[@"emodes"][@"mode_multiplayer"],
		statsVariable = "completedShamrockPromoPopup",
		onlyShowForGivenMode = false,
	},
	BlackMarketSunsetIntroduction = {
		gameMode = Enum[@"emodes"][@"mode_multiplayer"],
		statsVariable = "completedBlackMarketSunsetFlow",
		onlyShowForGivenMode = false,
	},
}
CoD.FTUEUtility.ZMPlaylistToSequence = {
	"ZMFeaturedPlaylistIntroduction",
	[3] = "ZMClassicPlaylistIntroduction",
	[4] = "ZMZombieRushPlaylistIntroduction",
	[5] = "ZMTCMPlaylistIntroduction",
	[6] = "ZMGauntletPlaylistIntroduction",
	[7] = "ZMTutorialPlaylistIntroduction",
}
local f0_local0 = CoD.OverlayUtility.AddSystemOverlay
local f0_local1 = "SpecialistHQGraphicContentWarning"
local f0_local2 = {
	menuName = "SystemOverlay_FreeCursor",
	title = LocalizeToUpperString(@"menu/graphic_content"),
	description = Engine[@"hash_4F9F1239CFD921FE"](@"hash_259511650450D25"),
	categoryType = CoD.OverlayUtility.OverlayTypes.Alert,
}
if not CoD.isPC then
else
end
f0_local2.listDatasource = function()
	DataSources.SpecialistHQGraphicContentWarning_List = DataSourceHelpers.ListSetup("SpecialistHQGraphicContentWarning_List", function(f36_arg0)
		return {
			{
				models = {
					displayText = Engine[@"hash_4F9F1239CFD921FE"](@"menu/yes"),
				},
				properties = {
					action = function(f37_arg0, f37_arg1, f37_arg2, f37_arg3, f37_arg4)
						CoD.FTUEUtility.PlaySpecialistHQIntroductionMovie(f37_arg4, f37_arg2)
					end,
				},
			},
			{
				models = {
					displayText = Engine[@"hash_4F9F1239CFD921FE"](@"menu/no"),
				},
				properties = {
					action = function(f38_arg0, f38_arg1, f38_arg2, f38_arg3, f38_arg4)
						CoD.FTUEUtility.BackOutCurrentSequence(f38_arg4, f38_arg2)
					end,
				},
			},
		}
	end, true, nil)
	return "SpecialistHQGraphicContentWarning_List"
end
f0_local2[CoD.OverlayUtility.aCrossPromptFn] = function(f39_arg0)
	return function(f40_arg0, f40_arg1)
		CoD.FTUEUtility.PlaySpecialistHQIntroductionMovie(f40_arg0, f40_arg1)
	end
end
f0_local2[CoD.OverlayUtility.aCrossPromptText] = @"menu/yes"
f0_local2[CoD.OverlayUtility.bCirclePromptFn] = function(f41_arg0)
	return function(f42_arg0, f42_arg1)
		CoD.FTUEUtility.BackOutCurrentSequence(f42_arg0, f42_arg1)
	end
end
f0_local2[CoD.OverlayUtility.bCirclePromptText] = @"menu/no"
f0_local0(f0_local1, f0_local2)
CoD.FTUEUtility.ShouldBlockMPFTUE = false
CoD.FTUEUtility.ResetCurrentSequenceData = function()
	CoD.FTUEUtility.CurrentSequenceIndex = 1
	CoD.FTUEUtility.CurrentSequenceReference = ""
	CoD.FTUEUtility.CurrentListReference = nil
end
CoD.FTUEUtility.UpdateFTUEInfo = function(f44_arg0, f44_arg1)
	if CoD.isPC and CoD.PCKoreaUtility.ShowKorea15Plus() then
		for f44_local3, f44_local4 in pairs(f44_arg1.overlayInfoEntries) do
			if f44_local4.models.korea15Image then
				f44_local4.models.image = f44_local4.models.korea15Image
			end
		end
	end
	local f44_local0 = f44_arg1.overlayInfoEntries[1]
	local f44_local1 = DataSources.FTUEInfo.getModel(f44_arg0)
	f44_local1.mainTitle:set(f44_arg1.overlayTitle)
	f44_local1.mainImage:set(f44_local0.models.image)
	f44_local1.mainText:set(f44_local0.models.displayText)
	f44_local1.layout:set(f44_arg1.overlayLayout)
end
CoD.FTUEUtility.SetCurrentSequenceThroughMode = function(f45_arg0, f45_arg1, f45_arg2)
	if not IsOnlineGame() then
		return false
	elseif f45_arg2 == Enum[@"emodes"][@"mode_zombies"] and CoD.PCKoreaUtility.ShowKorea15Plus() then
		return false
	else
		local f45_local0 = CoD.FTUEUtility.FTUEGameModeToSequence[f45_arg2]
		if f45_local0 then
			CoD.FTUEUtility.SetCurrentSequence(f45_arg0, f45_arg1, f45_local0)
			return true
		else
			return false
		end
	end
end
CoD.FTUEUtility.SetCurrentSequence = function(f46_arg0, f46_arg1, f46_arg2)
	CoD.FTUEUtility.CurrentSequenceIndex = 1
	CoD.FTUEUtility.CurrentSequenceReference = f46_arg2
	CoD.FTUEUtility.UpdateFTUEInfo(f46_arg1, CoD.FTUEUtility.FTUESequences[CoD.FTUEUtility.CurrentSequenceReference].sequenceOverlays[CoD.FTUEUtility.CurrentSequenceIndex])
end
CoD.FTUEUtility.OpenSpecialFTUEOverlayIfAvailable = function(f47_arg0, f47_arg1)
	local f47_local0 = CoD.FTUEUtility.SpecialFTUEOverlays[CoD.FTUEUtility.FTUESequences[CoD.FTUEUtility.CurrentSequenceReference].sequenceOverlays[CoD.FTUEUtility.CurrentSequenceIndex].overlayLayout]
	if f47_local0 then
		OpenOverlay(f47_arg0, f47_local0, f47_arg1, nil)
	end
end
CoD.FTUEUtility.AdvanceCurrentSequence = function(f48_arg0, f48_arg1)
	CoD.FTUEUtility.CurrentSequenceIndex = CoD.FTUEUtility.CurrentSequenceIndex + 1
	local f48_local0 = CoD.FTUEUtility.FTUESequences[CoD.FTUEUtility.CurrentSequenceReference]
	if f48_local0 ~= nil and CoD.FTUEUtility.CurrentSequenceIndex <= #f48_local0.sequenceOverlays then
		CoD.FTUEUtility.UpdateFTUEInfo(f48_arg1, f48_local0.sequenceOverlays[CoD.FTUEUtility.CurrentSequenceIndex])
		CoD.FTUEUtility.OpenSpecialFTUEOverlayIfAvailable(f48_arg0, f48_arg1)
		if CoD.FTUEUtility.CurrentListReference then
			CoD.FTUEUtility.CurrentListReference:updateDataSource()
		end
	else
		if f48_local0 ~= nil and f48_local0.sequenceEndFunc ~= nil then
			f48_local0.sequenceEndFunc(f48_arg0, f48_arg1)
			CoD.FTUEUtility.CurrentListReference = nil
		end
		CoD.FTUEUtility.ResetCurrentSequenceData()
	end
end
CoD.FTUEUtility.BackOutCurrentSequence = function(f49_arg0, f49_arg1)
	CoD.FTUEUtility.ResetCurrentSequenceData()
	LobbyGoBack(f49_arg0, f49_arg1)
	GoBack(f49_arg0, f49_arg1)
end
CoD.FTUEUtility.DismissCurrentSequence = function(f50_arg0, f50_arg1)
	GoBack(f50_arg0, f50_arg1)
	CoD.FTUEUtility.CurrentListReference = nil
end
CoD.FTUEUtility.DismissPromoEventPC = function(f51_arg0, f51_arg1)
	if not CoD.isPC then
		return
	else
		GoBack(f51_arg0, f51_arg1)
		Engine[@"lobbyevent"]("OnGoForward", {
			controller = f51_arg1,
			navToMenu = "director",
		})
	end
end
CoD.FTUEUtility.ShowFTUESequence = function(f52_arg0, f52_arg1, f52_arg2)
	if not IsOnlineGame() then
		return false
	elseif CoD.FTUEUtility.CurrentSequenceReference and CoD.FTUEUtility.CurrentSequenceReference ~= "" then
		return false
	end
	CoD.FTUEUtility.SetCurrentSequence(f52_arg0, f52_arg1, f52_arg2)
	local f52_local0 = DataSources.FTUEInfo.getModel(f52_arg1)
	local f52_local1 = f52_local0.layout:get()
	local f52_local2 = "FTUEInfoScreen"
	if CoD.FTUEUtility.SpecialFTUEOverlays[f52_local1] then
		f52_local2 = CoD.FTUEUtility.SpecialFTUEOverlays[f52_local1]
	end
	DelayOpenOverlay(f52_arg0, f52_local2, f52_arg1, nil)
	return true
end
CoD.FTUEUtility.ShowZMModeFTUESequenceIfNotSeen = function(f53_arg0, f53_arg1, f53_arg2)
	if CoD.FTUEUtility.CurrentSequenceReference == "" and CoD.FTUEUtility.ZMPlaylistToSequence[f53_arg2] then
		CoD.FTUEUtility.ShowFTUESequenceIfNotSeen(f53_arg0, f53_arg1, CoD.FTUEUtility.ZMPlaylistToSequence[f53_arg2])
	end
end
CoD.FTUEUtility.ShouldShowFTUESequence = function(f54_arg0, f54_arg1)
	local f54_local0 = Engine[@"currentsessionmode"]()
	local f54_local1 = CoD.FTUEUtility.FTUESequenceToSequenceInfo[f54_arg1]
	if f54_local1.onlyShowForGivenMode and f54_local0 ~= f54_local1.gameMode then
		return false
	elseif Dvar[@"livestats_skipfirsttime"]:get() then
		return false
	else
		local f54_local2 = CoD.BreadcrumbUtility.GetStorageClientBufferForPlayer(f54_arg0, f54_local1.gameMode)
		if f54_local2 and f54_local2[f54_local1.statsVariable] and f54_local2[f54_local1.statsVariable]:get() == 0 then
			return true
		else
			return false
		end
	end
end
CoD.FTUEUtility.ShowFTUESequenceIfNotSeen = function(f55_arg0, f55_arg1, f55_arg2)
	local f55_local0 = CoD.FTUEUtility.FTUESequenceToSequenceInfo[f55_arg2]
	local f55_local1 = CoD.BreadcrumbUtility.GetStorageClientBufferForPlayer(f55_arg1, f55_local0.gameMode)
	if f55_local1 and f55_local1[f55_local0.statsVariable] and CoD.FTUEUtility.ShouldShowFTUESequence(f55_arg1, f55_arg2) and CoD.FTUEUtility.ShowFTUESequence(f55_arg0, f55_arg1, f55_arg2) then
		f55_local1[f55_local0.statsVariable]:set(1)
		return true
	else
		return false
	end
end
CoD.FTUEUtility.PrepareOverlayInfoEntriesData = function(f56_arg0, f56_arg1)
	if not CoD.FTUEUtility.CurrentListReference then
		CoD.FTUEUtility.CurrentListReference = f56_arg1
	end
	local f56_local0 = {}
	if CoD.FTUEUtility.CurrentSequenceReference then
		local f56_local1 = CoD.FTUEUtility.FTUESequences[CoD.FTUEUtility.CurrentSequenceReference]
		local f56_local2 = f56_local1
		local f56_local3 = f56_local1.sequenceOverlays
		if f56_local3 then
			f56_local3 = f56_local2 and f56_local1.sequenceOverlays[CoD.FTUEUtility.CurrentSequenceIndex]
		end
		f56_local0 = f56_local3 and f56_local3.overlayInfoEntries
		if CoD.isPC and CoD.PCKoreaUtility.ShowKorea15Plus() then
			local f56_local4 = {}
			for f56_local8, f56_local9 in pairs(f56_local0) do
				if not f56_local9.models.removedInKorea15 then
					table.insert(f56_local4, f56_local9)
				end
			end
			return f56_local4
		end
	end
	return f56_local0
end
DataSources.FTUEEntries = DataSourceHelpers.ListSetup("FTUEEntries", CoD.FTUEUtility.PrepareOverlayInfoEntriesData, true)
DataSources.FTUEInfo = {
	getModel = function(f57_arg0)
		local f57_local0 = Engine[@"getmodelforcontroller"](f57_arg0)
		f57_local0 = f57_local0:create("FTUEInfo")
		f57_local0:create("mainTitle")
		f57_local0:create("mainImage")
		f57_local0:create("mainText")
		f57_local0:create("layout")
		return f57_local0
	end,
}
