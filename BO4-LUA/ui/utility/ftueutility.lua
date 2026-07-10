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
			overlayTitle = 0x9413BCBC84F738A,
			overlayInfoEntries = {
				{
					models = {
						displayTitle = 0x55D96CC762EABDD,
						displayText = 0x92855996C8E28F2,
						image = 0xC1C84968DF44116,
					},
				},
				{
					models = {
						displayTitle = 0xA2DD20750465431,
						displayText = 0x90653996C713F26,
						image = 0x108A4300846467E,
					},
				},
				{
					models = {
						displayTitle = 0xB06081B8B4567F2,
						displayText = 0x8FC6A996C6911B6,
						image = 0xDE4AFEABEFDCBE2,
						removedInKorea15 = true,
					},
				},
				{
					models = {
						displayTitle = 0xA47F44E3C7592DE,
						displayText = 0xC51E146D5995102,
						image = 0x6B963BF71263EC8,
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
			overlayTitle = 0x511100B58E0378C,
			overlayInfoEntries = {
				{
					models = {
						displayTitle = 0xED31E7E5010EC4A,
						displayText = 0x82C11675D201653,
						image = 0xB0740EFF786BB29,
					},
				},
				{
					models = {
						displayTitle = 0xED31D7E5010EA97,
						displayText = 0x82C12675D201806,
						image = 0xB073DEFF786B610,
						korea15Image = 0x4806CFDC4641073,
					},
				},
				{
					models = {
						displayTitle = 0xED31C7E5010E8E4,
						displayText = 0x82C13675D2019B9,
						image = 0xB073EEFF786B7C3,
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f2_arg0, f2_arg1)
		GoBack(f2_arg0, f2_arg1)
		Engine[0x28A466EF7723621](f2_arg1, Enum[0xBBD4F9E70101BA8][0xD1A0F784B3C95A0])
	end,
}
CoD.FTUEUtility.FTUESequences.WZProgressionInfo = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Echelon,
			overlayTitle = 0x0,
			overlayInfoEntries = {
				{
					models = {
						displayTitle = 0x0,
						displayText = 0x0,
						image = nil,
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f3_arg0, f3_arg1)
		GoBack(f3_arg0, f3_arg1)
		Engine[0x28A466EF7723621](f3_arg1, Enum[0xBBD4F9E70101BA8][0xD1A0F784B3C95A0])
	end,
}
CoD.FTUEUtility.FTUESequences.MPIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = 0xDCDBDBD84A037C2,
			overlayInfoEntries = {
				{
					models = {
						displayTitle = 0x0,
						displayText = 0x6F6EB618C89C652,
						image = 0xD1FFDDEA7B28068,
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f4_arg0, f4_arg1)
		GoBack(f4_arg0, f4_arg1)
		Engine[0x28A466EF7723621](f4_arg1, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C])
	end,
}
CoD.FTUEUtility.FTUESequences.ZMIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = 0xE7C9BD874F4A11B,
			overlayInfoEntries = {
				{
					models = {
						displayTitle = 0x0,
						displayText = 0x3009B862F6F78CD,
						image = 0xA4C07F5B49E0417,
					},
				},
			},
		},
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries3,
			overlayTitle = 0x78DE7ECBB713525,
			overlayInfoEntries = {
				{
					models = {
						displayTitle = 0xC3A14F195A42AC9,
						displayText = 0xE300F74F4198B83,
						image = 0xBDE120331D67BA7,
					},
				},
				{
					models = {
						displayTitle = 0x678399F6FD3847,
						displayText = 0xFAA2C5D4BD4BED9,
						image = 0x9AB768067565C1A,
					},
				},
				{
					models = {
						displayTitle = 0x862BE43BBA920BB,
						displayText = 0x339944E55FBACAD,
						image = 0x4A5BCDF8F80809B,
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f5_arg0, f5_arg1)
		GoBack(f5_arg0, f5_arg1)
		Engine[0x28A466EF7723621](f5_arg1, Enum[0xBBD4F9E70101BA8][0xEC77AD28A19F8E0])
	end,
}
CoD.FTUEUtility.FTUESequences.ZMFeaturedPlaylistIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = 0xDC8670AD8269CF1,
			overlayInfoEntries = {
				{
					models = {
						displayTitle = 0x0,
						displayText = 0xBC680D6F37FDC4B,
						image = 0xF72D5BF816ACDA6,
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f6_arg0, f6_arg1)
		GoBack(f6_arg0, f6_arg1)
		Engine[0x28A466EF7723621](f6_arg1, Enum[0xBBD4F9E70101BA8][0xEC77AD28A19F8E0])
	end,
}
CoD.FTUEUtility.FTUESequences.ZMClassicPlaylistIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = 0x2C192F82B6EAE71,
			overlayInfoEntries = {
				{
					models = {
						displayTitle = 0x0,
						displayText = 0xA9104E2E61DA0CB,
						image = 0x9A565D587CB7693,
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f7_arg0, f7_arg1)
		GoBack(f7_arg0, f7_arg1)
		Engine[0x28A466EF7723621](f7_arg1, Enum[0xBBD4F9E70101BA8][0xEC77AD28A19F8E0])
	end,
}
CoD.FTUEUtility.FTUESequences.ZMZombieRushPlaylistIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = 0x80680DEAE7D6042,
			overlayInfoEntries = {
				{
					models = {
						displayTitle = 0x0,
						displayText = 0x49529904F556FD2,
						image = 0x64C57C756A1EA3C,
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f8_arg0, f8_arg1)
		GoBack(f8_arg0, f8_arg1)
		Engine[0x28A466EF7723621](f8_arg1, Enum[0xBBD4F9E70101BA8][0xEC77AD28A19F8E0])
	end,
}
CoD.FTUEUtility.FTUESequences.ZMTCMPlaylistIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = 0xC21959514E64ED1,
			overlayInfoEntries = {
				{
					models = {
						displayTitle = 0x0,
						displayText = 0x65631F4D4212EB,
						image = 0x9456B1DAE237F21,
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f9_arg0, f9_arg1)
		GoBack(f9_arg0, f9_arg1)
		Engine[0x28A466EF7723621](f9_arg1, Enum[0xBBD4F9E70101BA8][0xEC77AD28A19F8E0])
	end,
}
CoD.FTUEUtility.FTUESequences.ZMGauntletPlaylistIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = 0xB09D4E74D55B35D,
			overlayInfoEntries = {
				{
					models = {
						displayTitle = 0x0,
						displayText = 0x5DCD6630A166A67,
						image = 0xF2BED0FDD3EF8B,
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f10_arg0, f10_arg1)
		GoBack(f10_arg0, f10_arg1)
		Engine[0x28A466EF7723621](f10_arg1, Enum[0xBBD4F9E70101BA8][0xEC77AD28A19F8E0])
	end,
}
CoD.FTUEUtility.FTUESequences.ZMTutorialPlaylistIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = 0xC79DDA4A0395229,
			overlayInfoEntries = {
				{
					models = {
						displayTitle = 0x0,
						displayText = 0x53C9892E9FF4223,
						image = 0x7B9C4F7BC6616F7,
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f11_arg0, f11_arg1)
		GoBack(f11_arg0, f11_arg1)
		Engine[0x28A466EF7723621](f11_arg1, Enum[0xBBD4F9E70101BA8][0xEC77AD28A19F8E0])
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
						displayTitle = 0x0,
						displayText = 0x6B72E64033999B1,
						image = 0x6F01AB67C02345D,
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f12_arg0, f12_arg1)
		GoBack(f12_arg0, f12_arg1)
		Engine[0x28A466EF7723621](f12_arg1, Enum[0xBBD4F9E70101BA8][0xEC77AD28A19F8E0])
	end,
}
CoD.FTUEUtility.FTUESequences.ZMLoadoutIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.ZMLoadout,
			overlayTitle = 0xAADDF41A08B2C4E,
			overlayInfoEntries = {
				{
					models = {
						displayTitle = 0x0,
						displayText = 0x0,
						image = 0x2572A7D49208F63,
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f13_arg0, f13_arg1)
		GoBack(f13_arg0, f13_arg1)
		Engine[0x28A466EF7723621](f13_arg1, Enum[0xBBD4F9E70101BA8][0xEC77AD28A19F8E0])
	end,
}
CoD.FTUEUtility.FTUESequences.ZMArmoryIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = 0xD6BF3A3749C31CD,
			overlayInfoEntries = {
				{
					models = {
						displayTitle = 0x0,
						displayText = 0x61686A90FF924C3,
						image = 0x2572A7D49208F63,
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f14_arg0, f14_arg1)
		GoBack(f14_arg0, f14_arg1)
		Engine[0x28A466EF7723621](f14_arg1, Enum[0xBBD4F9E70101BA8][0xEC77AD28A19F8E0])
	end,
}
CoD.FTUEUtility.FTUESequences.ZMLaboratoryIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = 0x96D9A8F7540D6B6,
			overlayInfoEntries = {
				{
					models = {
						displayTitle = 0x0,
						displayText = 0x65A3A325CF99AC6,
						image = 0xCA6C00CB8EFE760,
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f15_arg0, f15_arg1)
		GoBack(f15_arg0, f15_arg1)
		Engine[0x28A466EF7723621](f15_arg1, Enum[0xBBD4F9E70101BA8][0xEC77AD28A19F8E0])
	end,
}
CoD.FTUEUtility.FTUESequences.BlackMarketIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = 0x29C903C6DF90D6F,
			overlayInfoEntries = {
				{
					models = {
						displayTitle = 0x0,
						displayText = 0x74DC5569EB9B521,
						image = 0xE81C16CFA9CE128,
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f16_arg0, f16_arg1)
		GoBack(f16_arg0, f16_arg1)
		Engine[0x28A466EF7723621](f16_arg1, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C])
	end,
}
CoD.FTUEUtility.FTUESequences.GestureChanges = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = 0x1F031657F740298,
			overlayInfoEntries = {
				{
					models = {
						displayTitle = 0x0,
						displayText = 0x96B7DBBFE1B0C80,
						image = 0x6C6C5B2149933A0,
					},
				},
			},
		},
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = 0x1F034657F7407B1,
			overlayInfoEntries = {
				{
					models = {
						displayTitle = 0x0,
						displayText = CoD.isPC and 0x6CBA61000157D25 or 0xF6436C07D4A7D0B,
						image = 0x172813CF3B30D10,
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f17_arg0, f17_arg1)
		GoBack(f17_arg0, f17_arg1)
		Engine[0x28A466EF7723621](f17_arg1, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C])
	end,
}
CoD.FTUEUtility.FTUESequences.ZMGestureChanges = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = 0xFEEE47792CA83DC,
			overlayInfoEntries = {
				{
					models = {
						displayTitle = 0x0,
						displayText = 0x86A4B78E7BE9A24,
						image = 0x1F71D71AAC599C8,
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f18_arg0, f18_arg1)
		GoBack(f18_arg0, f18_arg1)
		Engine[0x28A466EF7723621](f18_arg1, Enum[0xBBD4F9E70101BA8][0xEC77AD28A19F8E0])
	end,
}
CoD.FTUEUtility.FTUESequences.WeaponPersonalizationChanges = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = 0xC4D7803D4E195FA,
			overlayInfoEntries = {
				{
					models = {
						displayTitle = 0x0,
						displayText = CoD.isPC and 0xD8E3FCE949A0E6A or 0xADB8634CCDA72CA,
						image = 0x5C0688065801D0D,
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f19_arg0, f19_arg1)
		GoBack(f19_arg0, f19_arg1)
		Engine[0x28A466EF7723621](f19_arg1, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C])
	end,
}
CoD.FTUEUtility.FTUESequences.KoreaSpecialEvent = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = 0x5BD9225FA6071E5,
			overlayInfoEntries = {
				{
					models = {
						displayTitle = 0x0,
						displayText = 0x301910733BE3180,
						image = 0xBD70D094E36B085,
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
			overlayTitle = 0x7022CD1299D402C,
			overlayInfoEntries = {
				{
					models = {
						displayTitle = 0x0,
						displayText = 0xEBC18FE024FCDD4,
						image = 0x3C590AC3E812395,
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f21_arg0, f21_arg1)
		GoBack(f21_arg0, f21_arg1)
		CoDLoadoutsShared[0x7243F374ADEF72D](f21_arg1, Enum[0xBBD4F9E70101BA8][0x67DF1879D992E], 0x4FF2B60D157BBB2)
		CoDLoadoutsShared[0x7243F374ADEF72D](f21_arg1, Enum[0xBBD4F9E70101BA8][0xCEBE62E27709AD0], 0x4FF2B60D157BBB2)
		CoDLoadoutsShared[0x7243F374ADEF72D](f21_arg1, Enum[0xBBD4F9E70101BA8][0xD062FA7B47FC13A], 0x4FF2B60D157BBB2)
		Engine[0x28A466EF7723621](f21_arg1, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C])
	end,
}
CoD.FTUEUtility.FTUESequences.BlackMarketSeasonThreeIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = 0x7FB0E22B54FE01,
			overlayInfoEntries = {
				{
					models = {
						displayTitle = 0x0,
						displayText = 0x25DEE051ED23C88,
						image = 0x7A19866F330A927,
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f22_arg0, f22_arg1)
		GoBack(f22_arg0, f22_arg1)
		Engine[0x28A466EF7723621](f22_arg1, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C])
	end,
}
CoD.FTUEUtility.FTUESequences.BlackjackReservesIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = 0x275A7D7A83013E5,
			overlayInfoEntries = {
				{
					models = {
						displayTitle = 0x0,
						displayText = 0xE5136996115F694,
						image = 0x8D45BFD30C0E082,
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f23_arg0, f23_arg1)
		local f23_local0 = GoBack(f23_arg0, f23_arg1)
		if not IsBooleanDvarSet(0x1A8E4D68B803874) then
			CoD.BlackMarketUtility.PlayReservesPreviewVideo(f23_arg1, f23_local0, true, true)
		end
		Engine[0x28A466EF7723621](f23_arg1, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C])
	end,
}
CoD.FTUEUtility.FTUESequences.BlackjackShopIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = 0xC2C43BD810C5C48,
			overlayInfoEntries = {
				{
					models = {
						displayTitle = 0x0,
						displayText = 0x3BA06143D9A210F,
						image = 0xF68A9822F64D456,
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f24_arg0, f24_arg1)
		GoBack(f24_arg0, f24_arg1)
		Engine[0x28A466EF7723621](f24_arg1, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C])
	end,
}
CoD.FTUEUtility.FTUESequences.BlackMarketInventoryIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = 0x7EFD3D64C509ABB,
			overlayInfoEntries = {
				{
					models = {
						displayTitle = 0x0,
						displayText = 0x30E72AC1A617CD6,
						image = 0xE375BCFE89C5E63,
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f25_arg0, f25_arg1)
		GoBack(f25_arg0, f25_arg1)
		Engine[0x28A466EF7723621](f25_arg1, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C])
	end,
}
CoD.FTUEUtility.FTUESequences.BlackOpsPassUpsell = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.StoreUpsell,
			overlayTitle = 0xBB8C7DC3C3EB0CB,
			overlayInfoEntries = {
				{
					models = {
						displayTitle = 0x0,
						displayText = 0x9A35875D151FC1,
						image = 0x845817FCED579E7,
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f26_arg0, f26_arg1)
		GoBack(f26_arg0, f26_arg1)
		local f26_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f26_arg1), "Store.FeaturedProductList")
		if f26_local0 then
			local f26_local1 = 1
			while f26_local0[f26_local1] ~= nil do
				local f26_local2 = f26_local0[f26_local1].productNameHash
				if f26_local2 then
					f26_local2 = f26_local0[f26_local1].productNameHash:get()
				end
				if f26_local2 == 0x617848314938AB9 then
					local f26_local3 = f26_local0[f26_local1].productID
					if f26_local3 then
						f26_local3 = f26_local0[f26_local1].productID:get()
					end
					if f26_local3 then
						if IsDurango() then
							Engine[0xD58E665ABB6A9AE](f26_arg1, "featured", f26_local3)
						elseif IsOrbis() then
							local f26_local4 = f26_local0[f26_local1].serviceLabel
							if f26_local4 then
								f26_local4 = f26_local0[f26_local1].serviceLabel:get()
							end
							if f26_local4 then
								Engine[0xD58E665ABB6A9AE](f26_arg1, "featured", f26_local3, f26_local4)
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
			overlayTitle = 0xC9B32C16D19F3C0,
			overlayInfoEntries = {
				{
					models = {
						displayTitle = 0x0,
						displayText = 0x2E59FC3EFBE5237,
						image = 0x65D95F28D7925F5,
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
					Engine[0x87AE7E64BA5AD61]("OnGoForward", {
						controller = f27_arg1,
						navToMenu = "director",
					})
				end,
			}
		end
		Engine[0x28A466EF7723621](f27_arg1, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C])
		OpenQuarterMaster(f27_local0, f27_local0, f27_arg1, f27_local1, f27_local0)
	end,
}
CoD.FTUEUtility.FTUESequences.BlackMarketSunsetIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.HoldButtonEntries1,
			overlayTitle = 0x98662FD51593715,
			overlayInfoEntries = {
				{
					models = {
						displayTitle = 0x0,
						displayText = 0x692701BEA54FDC4,
						image = 0x8E8508A8B137347,
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f29_arg0, f29_arg1)
		GoBack(f29_arg0, f29_arg1)
		Engine[0x28A466EF7723621](f29_arg1, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C])
	end,
}
CoD.FTUEUtility.WriteMPStats = function(f30_arg0)
	Engine[0x28A466EF7723621](f30_arg0, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C])
end
CoD.FTUEUtility.FTUESequences.ZMFactionCallingsIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.Entries1,
			overlayTitle = 0xA8A1AE4754B2601,
			overlayInfoEntries = {
				{
					models = {
						displayTitle = 0x0,
						displayText = 0x47E54D0C1B51F89,
						image = 0xCA6C00CB8EFE760,
					},
				},
			},
		},
	},
	sequenceEndFunc = function(f31_arg0, f31_arg1)
		GoBack(f31_arg0, f31_arg1)
		Engine[0x28A466EF7723621](f31_arg1, Enum[0xBBD4F9E70101BA8][0xEC77AD28A19F8E0])
	end,
}
CoD.FTUEUtility.PlaySpecialistHQIntroductionMovie = function(f32_arg0, f32_arg1)
	local f32_local0 = function(f33_arg0, f33_arg1, f33_arg2)
		GoBack(f32_arg0, f33_arg1)
		local f33_local0 = DataSources.SpecialistHeadquarters.getModel(f33_arg1)
		f33_local0.StartFullscreenBlack:set(false)
	end
	local f32_local1 = CoD.CTUtility.GetArchivesBundle()
	CoD.CTUtility.PlaySkippableVideo(f32_arg1, f32_arg0, f32_local1[0xC873FF231AABAE6], f32_local1[0x2EDACFCAA4E38C7] ~= 0, {
		onlySkippable = true,
		on_pre_finished_movie_playback = f32_local0,
	})
	CoD.CTUtility.SetSeenMovie(f32_arg1, 0xA8C599171B6CDE3)
	Engine[0x28A466EF7723621](f32_arg1, Enum[0xBBD4F9E70101BA8][0x7FA8C2EEB2B6F7A])
end
CoD.FTUEUtility.FTUESequences.SpecialistHQIntroduction = {
	sequenceOverlays = {
		{
			overlayLayout = CoD.FTUEUtility.FTUELayouts.WarningEntry,
			overlayTitle = 0xC03DE6970599340,
			overlayInfoEntries = {
				{
					models = {
						displayTitle = 0x0,
						displayText = 0x53BB50D4C2574B7,
						image = 0xD1FFDDEA7B28068,
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
		if not f34_local1 and f34_local0[0xC873FF231AABAE6] ~= nil and f34_local0[0xC873FF231AABAE6] ~= "" and CoD.CTUtility.CanPlayVideo(f34_arg1, f34_local0[0x41FF0587D0A3B33]) then
			local f34_local2 = GoBack(f34_arg0, f34_arg1)
			OpenSystemOverlay(f34_local2, f34_local2, f34_arg1, "SpecialistHQGraphicContentWarning", nil)
		else
			GoBack(f34_arg0, f34_arg1)
			local f34_local2 = DataSources.SpecialistHeadquarters.getModel(f34_arg1)
			f34_local2.StartFullscreenBlack:set(false)
			CoD.CTUtility.SetSeenMovie(f34_arg1, 0xA8C599171B6CDE3)
			Engine[0x28A466EF7723621](f34_arg1, Enum[0xBBD4F9E70101BA8][0x7FA8C2EEB2B6F7A])
		end
	end,
}
CoD.FTUEUtility.CurrentSequenceIndex = 1
CoD.FTUEUtility.CurrentSequenceReference = ""
CoD.FTUEUtility.CurrentListReference = nil
CoD.FTUEUtility.FTUEGameModeToSequence = {
	[Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5]] = "MPIntroduction",
	[Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39]] = "WZIntroduction",
	[Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A]] = "ZMIntroduction",
}
CoD.FTUEUtility.FTUESequenceToSequenceInfo = {
	ZMFeaturedPlaylistIntroduction = {
		gameMode = Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A],
		statsVariable = "completedFeaturedPlaylistIntroduction",
		onlyShowForGivenMode = true,
	},
	ZMClassicPlaylistIntroduction = {
		gameMode = Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A],
		statsVariable = "completedClassicPlaylistIntroduction",
		onlyShowForGivenMode = true,
	},
	ZMZombieRushPlaylistIntroduction = {
		gameMode = Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A],
		statsVariable = "completedZombieRushPlaylistIntroduction",
		onlyShowForGivenMode = true,
	},
	ZMTCMPlaylistIntroduction = {
		gameMode = Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A],
		statsVariable = "completedTCMPlaylistIntroduction",
		onlyShowForGivenMode = true,
	},
	ZMGauntletPlaylistIntroduction = {
		gameMode = Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A],
		statsVariable = "completedGauntletPlaylistIntroduction",
		onlyShowForGivenMode = true,
	},
	ZMTutorialPlaylistIntroduction = {
		gameMode = Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A],
		statsVariable = "completedTutorialPlaylistIntroduction",
		onlyShowForGivenMode = true,
	},
	ZMCustomGameIntroduction = {
		gameMode = Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A],
		statsVariable = "completedCustomGameFirstTimeFlow",
		onlyShowForGivenMode = true,
	},
	ZMLoadoutIntroduction = {
		gameMode = Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A],
		statsVariable = "completedLoadoutFirstTimeFlow",
		onlyShowForGivenMode = true,
	},
	ZMArmoryIntroduction = {
		gameMode = Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A],
		statsVariable = "completedArmoryFirstTimeFlow",
		onlyShowForGivenMode = true,
	},
	ZMLaboratoryIntroduction = {
		gameMode = Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A],
		statsVariable = "completedLaboratoryFirstTimeFlow",
		onlyShowForGivenMode = true,
	},
	ZMFactionCallingsIntroduction = {
		gameMode = Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A],
		statsVariable = "completedFactionCallingsFirstTimeFlow",
		onlyShowForGivenMode = true,
	},
	ZMGestureChanges = {
		gameMode = Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A],
		statsVariable = "completedUpdatedGestureFlow",
		onlyShowForGivenMode = true,
	},
	WZProgressionInfo = {
		gameMode = Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39],
		statsVariable = "completedWZProgressionFirstTimeFlow",
		onlyShowForGivenMode = true,
	},
	BlackMarketIntroduction = {
		gameMode = Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5],
		statsVariable = "completedBlackMarketFirstTimeFlow",
		onlyShowForGivenMode = false,
	},
	GestureChanges = {
		gameMode = Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5],
		statsVariable = "completedUpdatedGestureFlow",
		onlyShowForGivenMode = false,
	},
	WeaponPersonalizationChanges = {
		gameMode = Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5],
		statsVariable = "completedUpdatedWeaponPersonalizationFlow",
		onlyShowForGivenMode = false,
	},
	KoreaSpecialEvent = {
		gameMode = Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5],
		statsVariable = "completedKoreaSpecialEventPopup",
		onlyShowForGivenMode = false,
	},
	LeaguePlayIntroduction = {
		gameMode = Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5],
		statsVariable = "completedArenaFirstTimeFlow",
		onlyShowForGivenMode = true,
	},
	BlackMarketSeasonThreeIntroduction = {
		gameMode = Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5],
		statsVariable = "completedBlackMarketSeasonThreeFirstTimeFlow",
		onlyShowForGivenMode = false,
	},
	BlackjackReservesIntroduction = {
		gameMode = Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5],
		statsVariable = "completedBlackjackReservesFirstTimeFlow",
		onlyShowForGivenMode = false,
	},
	BlackjackShopIntroduction = {
		gameMode = Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5],
		statsVariable = "completedBlackjackShopFirstTimeFlow",
		onlyShowForGivenMode = false,
	},
	BlackMarketInventoryIntroduction = {
		gameMode = Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5],
		statsVariable = "completedBlackMarketInventoryFirstTimeFlow",
		onlyShowForGivenMode = false,
	},
	BlackOpsPassUpsell = {
		gameMode = Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5],
		statsVariable = "unusedVariable",
		onlyShowForGivenMode = false,
	},
	PromoEvent = {
		gameMode = Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5],
		statsVariable = "completedShamrockPromoPopup",
		onlyShowForGivenMode = false,
	},
	BlackMarketSunsetIntroduction = {
		gameMode = Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5],
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
	title = LocalizeToUpperString(0x9F837EEDFBB8117),
	description = Engine[0xF9F1239CFD921FE](0x259511650450D25),
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
					displayText = Engine[0xF9F1239CFD921FE](0xDFD294FC69F682),
				},
				properties = {
					action = function(f37_arg0, f37_arg1, f37_arg2, f37_arg3, f37_arg4)
						CoD.FTUEUtility.PlaySpecialistHQIntroductionMovie(f37_arg4, f37_arg2)
					end,
				},
			},
			{
				models = {
					displayText = Engine[0xF9F1239CFD921FE](0x5C16E02B211A4F4),
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
f0_local2[CoD.OverlayUtility.aCrossPromptText] = 0xDFD294FC69F682
f0_local2[CoD.OverlayUtility.bCirclePromptFn] = function(f41_arg0)
	return function(f42_arg0, f42_arg1)
		CoD.FTUEUtility.BackOutCurrentSequence(f42_arg0, f42_arg1)
	end
end
f0_local2[CoD.OverlayUtility.bCirclePromptText] = 0x5C16E02B211A4F4
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
	elseif f45_arg2 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] and CoD.PCKoreaUtility.ShowKorea15Plus() then
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
		Engine[0x87AE7E64BA5AD61]("OnGoForward", {
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
	local f54_local0 = Engine[0x3EAC408F958FF05]()
	local f54_local1 = CoD.FTUEUtility.FTUESequenceToSequenceInfo[f54_arg1]
	if f54_local1.onlyShowForGivenMode and f54_local0 ~= f54_local1.gameMode then
		return false
	elseif Dvar[0x2BE8FB76AD6AEA3]:get() then
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
		local f57_local0 = Engine[0x4DF5CFBC1771947](f57_arg0)
		f57_local0 = f57_local0:create("FTUEInfo")
		f57_local0:create("mainTitle")
		f57_local0:create("mainImage")
		f57_local0:create("mainText")
		f57_local0:create("layout")
		return f57_local0
	end,
}
