CoD.BlackMarketTableUtility = {}
CoD.BlackMarketTableUtility[@"hash_1C73F5908A5FD309"] = function(f1_arg0)
	if not CoD.BlackMarketTableUtility[@"loot_lookup"] then
		CoD.BlackMarketTableUtility[@"loot_lookup"] = Engine[@"hash_2E00B2F29271C60B"](@"loot_lookup")
	end
	if CoD.BlackMarketTableUtility[@"loot_lookup"] then
		return {
			title = CoD.BlackMarketTableUtility[@"loot_lookup"][f1_arg0 .. "_title"],
		}
	else
		return {
			title = @"hash_0",
		}
	end
end
CoD.BlackMarketTableUtility.DEFAULT_RNG_CP_PRICE = 100
CoD.BlackMarketTableUtility.DEFAULT_RNG_CASE_PRICE = 2
CoD.BlackMarketTableUtility.MasterContractTable = {}
CoD.BlackMarketTableUtility.MasterContractTable.name = @"hash_69FA37692BF3254F"
CoD.BlackMarketTableUtility.MasterContractTable.COL_ID = 0
CoD.BlackMarketTableUtility.MasterContractTable.COL_NAMEHASH = 1
CoD.BlackMarketTableUtility.MasterContractTable.COL_RARITY = 2
CoD.BlackMarketTableUtility.MasterContractTable.COL_DROPNUMBER = 3
CoD.BlackMarketTableUtility.MasterContractTable.COL_TYPE = 4
CoD.BlackMarketTableUtility.MasterContractTable.COL_PRICE = 5
CoD.BlackMarketTableUtility.MasterContractTable.COL_DISCOUNT_SKU = 6
CoD.BlackMarketTableUtility.MasterContractTable.COL_DISCOUNT_PRICE = 7
CoD.BlackMarketTableUtility.ContractsTable = {}
CoD.BlackMarketTableUtility.ContractsTable.COL_TIER = 0
CoD.BlackMarketTableUtility.ContractsTable.COL_ID = 1
CoD.BlackMarketTableUtility.ContractsTable.COL_NAMEHASH = 2
CoD.BlackMarketTableUtility.ContractsTable.COL_TYPE = 3
CoD.BlackMarketTableUtility.ContractsTable.COL_RARITY = 4
CoD.BlackMarketTableUtility.ContractsTable.COL_BUNDLE = 5
CoD.BlackMarketTableUtility.ContractsTable.COL_SET = 6
CoD.BlackMarketTableUtility.ContractsTable.COL_REFOPTIC = 7
CoD.BlackMarketTableUtility.ContractsTable.COL_REFWEAPON = 8
CoD.BlackMarketTableUtility.ContractsTable.COL_PROMOVIDEO = 9
CoD.BlackMarketTableUtility.ContractsTable.COL_MPPRT = 10
CoD.BlackMarketTableUtility.ContractsTable.COL_WZPRT = 11
CoD.BlackMarketTableUtility.ContractsTable.COL_OUTFIT = 12
CoD.BlackMarketTableUtility.ContractsTable.names = {
	[@"loot_contract_nomad_muertos"] = @"hash_7AF012FA447E54A0",
	[@"loot_contract_ruin_muertos"] = 0x14D835E744D0CB,
	[@"loot_contract_recon_muertos"] = @"hash_5A5316D31DE70234",
	[@"loot_contract_prophet_muertos"] = @"hash_4DB3F62E91D6D4AD",
	[@"loot_contract_crash_muertos"] = @"hash_6336BD62B45CB0D0",
	[@"loot_contract_ajax_roman_warrior"] = @"hash_6C64CBCB4009D532",
	[@"loot_contract_battery_muertos"] = @"hash_16E3947D0C285856",
	[@"loot_contract_recon_samurai"] = @"hash_6A197B26A979BA03",
	[@"loot_contract_ruin_modern_viking"] = @"hash_6B792A1E77329130",
	[@"loot_contract_torque_muertos"] = @"hash_6DFF687B4909D53F",
	[@"loot_contract_seraph_muertos"] = @"hash_73AD22FE59BB6FCC",
	[@"loot_contract_seraph_crimson_lotus"] = @"hash_2B1CFFC7C5038848",
	[@"loot_contract_ajax_muertos"] = @"hash_5E7BDCB5AC08E9F",
	[@"loot_contract_halloween"] = @"hash_1B98D930AAAF7316",
	[@"loot_contract_firebreak_muertos"] = @"hash_613CEC2364DF5AFC",
	[@"loot_contract_torque_highlander"] = @"hash_695E85714371B8FC",
	[@"loot_contract_seraph_splinter"] = @"hash_4145AE564FD82FBE",
	[@"loot_contract_patriot"] = @"hash_42198DABA1541BB6",
	[@"loot_contract_carbon_cobra"] = 0xA6F0C62E947A34,
	[@"loot_contract_nomad_splinter"] = @"hash_3827A99C57C1B6C2",
	[@"loot_contract_zero_cyberpunk"] = @"hash_13DAB37E1DEF60D3",
	[@"loot_contract_battery_snakeskin"] = @"hash_231C625E585AA402",
	[@"loot_contract_richtofen"] = @"hash_18FC5C29700A10C9",
	[@"loot_contract_crash_snakeskin"] = @"hash_5B4AC0940ECC3F38",
	[@"loot_contract_valkyrie"] = @"hash_225A0D37D7ABC4BA",
	[@"loot_contract_winter"] = @"hash_26775083C09AC62",
	[@"loot_contract_firebreak_snakeskin"] = @"hash_6564E6A117034834",
	[@"loot_contract_season_2_bonus_stream"] = @"hash_394BD1A0F5BF3C10",
	[@"loot_contract_party_rock"] = @"hash_3C83D1A0A6BA0F7B",
	[@"loot_contract_misty"] = @"hash_7A5195F46F22BC31",
	[@"loot_contract_nomad_heist"] = @"hash_7DDDFFB3C508A690",
	[@"loot_contract_space_shuttle"] = @"hash_6EDA0608CF97548D",
	[@"loot_contract_seraph_cop"] = @"hash_6BF4180C336F0D0B",
	[@"loot_contract_crash_cop"] = @"hash_780C722259A9950F",
	[@"loot_contract_deep_voyage"] = @"hash_525C3644FDCCCFAF",
	[@"loot_contract_sergei"] = @"hash_1DE297F3D53BD86E",
	[@"loot_contract_ahabs_revenge"] = 0x6586E2580AADDB,
	[@"loot_contract_fourth_of_july_event_stream"] = @"hash_18D926D4195CCFC8",
	[@"loot_contract_russman"] = @"hash_7DB01E2D49663E38",
	[@"loot_contract_replacer_vacation"] = @"hash_3C2657C533E45C45",
	[@"loot_contract_koshka_mastercraft"] = @"hash_35664BCA02258FE5",
	[@"loot_contract_icr7_mastercraft"] = @"hash_46B7E027B542D407",
	[@"loot_contract_afterglow"] = @"hash_34D842D45F57F3A6",
	[@"loot_contract_rampart_mastercraft"] = @"hash_68C66D2BE918A3F",
	[@"loot_contract_tedd"] = @"hash_4D55311398568128",
	[@"loot_contract_labor_day_event_stream"] = @"hash_69965A9AE971DADE",
	[@"loot_contract_gks_mastercraft"] = @"hash_776D9062C3C37CB5",
	[@"loot_contract_stuhlinger"] = @"hash_6F2AFDC5580487CA",
	[@"loot_contract_kn57_mastercraft"] = @"hash_2986664E382AA135",
	[@"loot_contract_grigori_weaver"] = @"hash_2ECD1931CDCEB2FB",
}
CoD.BlackMarketTableUtility.StatBasedOutfitUnlocks = {
	[@"zm_halloween_2018_reward_1"] = {
		storageFile = Enum[@"storagefiletype"][@"hash_A57D6164B91A8FC"],
		path = {
			@"hash_3B52E51401F0229C",
			@"zm_halloween_2018",
			@"reward_1",
		},
		lockedStringRef = @"hash_3369ABF4C17436E3",
		unlockedStringRef = @"hash_D655AC8E9A3ACCC",
		itemUnlockable = function()
			local f2_local0 = CoD.SpecialEventUtility.GetCurrentSpecialEventInfo()
			return f2_local0 and f2_local0.statHash == @"zm_halloween_2018"
		end,
		lootIds = {
			@"hash_7A17204F81E27EA0",
			@"hash_ECF5FBAF72A8266",
			@"hash_2FA20ED6A3D4C9C9",
			@"hash_66027FA276DDAF2A",
			@"hash_58F4EF3BB49CD532",
			@"hash_668C39B7E8DC8E3B",
			@"hash_354973BF4EA4A7E6",
			@"hash_81B96DA7D8EF325",
			@"hash_338971C42E58CA12",
			@"hash_58BAFE68E460EDBD",
			@"hash_632C0AA1AA75A9A9",
			@"hash_61D67618C47E9EB1",
			@"hash_2FD7F8F24F966C11",
			@"hash_263E0357D38ABA00",
			@"hash_7CF607F1D163832B",
			@"hash_46F5563E01DD61D3",
			0xDDD73F5C52C2F3,
			@"hash_1D2923A5991E6ADC",
			@"hash_8CB387D2CA8151C",
			@"hash_34086751A51E3DBE",
			@"hash_49867BCBDFC01445",
			@"hash_13716D88CBAEEB95",
		},
	},
	[@"zm_halloween_2018_reward_2"] = {
		storageFile = Enum[@"storagefiletype"][@"hash_A57D6164B91A8FC"],
		path = {
			@"hash_3B52E51401F0229C",
			@"zm_halloween_2018",
			@"reward_2",
		},
		lockedStringRef = @"hash_3369ABF4C17436E3",
		unlockedStringRef = @"hash_D655AC8E9A3ACCC",
		itemUnlockable = function()
			local f3_local0 = CoD.SpecialEventUtility.GetCurrentSpecialEventInfo()
			return f3_local0 and f3_local0.statHash == @"zm_halloween_2018"
		end,
		lootIds = {
			@"hash_7ECB296F71F5F325",
			@"hash_27404D60993E1B7B",
			@"hash_657AAEA92F86ABF6",
			@"hash_287403003B10BD2B",
			@"hash_56ED5D4F6BBBED1B",
			@"hash_1689381B5A8EE9E2",
			@"hash_173E62DE048F469F",
			@"hash_5AB12B50D2DAD792",
			@"hash_46ACDD8B899D0DC1",
			@"hash_9EEBCCE0D83EC3A",
			@"hash_DB32E94F73FA58",
			@"hash_488AA72933B23614",
			@"hash_7BBC8C68B14521CA",
			@"hash_6E288CF3988DBA21",
			@"hash_23449F3BDBDA8114",
			@"hash_4FDF737882948C10",
			@"hash_1A4C0CB8A233FC7E",
			@"hash_76175EE0C666F9E3",
			@"hash_1DBC9D2942DAB70D",
			@"hash_7CE24023DB278157",
			@"hash_5503FBF6216AEBA0",
			@"hash_488070541D135C3C",
		},
	},
	[@"zm_halloween_2018_reward_3"] = {
		storageFile = Enum[@"storagefiletype"][@"hash_A57D6164B91A8FC"],
		path = {
			@"hash_3B52E51401F0229C",
			@"zm_halloween_2018",
			@"reward_3",
		},
		lockedStringRef = @"hash_3369ABF4C17436E3",
		unlockedStringRef = @"hash_D655AC8E9A3ACCC",
		itemUnlockable = function()
			local f4_local0 = CoD.SpecialEventUtility.GetCurrentSpecialEventInfo()
			return f4_local0 and f4_local0.statHash == @"zm_halloween_2018"
		end,
		lootIds = {
			0xA3922047F487AC,
			@"hash_773ECE5D1D42BCA",
			@"hash_2ED0A49986A674D5",
			@"hash_5E6C82EDE0FBA126",
			@"hash_1571D4F32BDB5BC6",
			@"hash_7282FC78A9DD7E07",
			@"hash_3FA89B4B3E13AD2",
			@"hash_BB3686483BD961",
			@"hash_3B8DF4D44567476",
			@"hash_9822E1485A35719",
			@"hash_158B3022974E80E5",
			@"hash_1291BAF96B719225",
			@"hash_68B39DD1723B065D",
			@"hash_748CC5B272061D3C",
			@"hash_7B21871406004D67",
			@"hash_2EFF22FA87D73AA7",
			@"hash_36640D985035007F",
			@"hash_22C36A4E4BD49318",
			@"hash_450C0209F5975150",
			@"hash_16920193513EF22A",
			@"hash_7BF9C85723769341",
			@"hash_72CCDA68FB9F2501",
		},
	},
	[@"zm_halloween_2018_reward_4"] = {
		storageFile = Enum[@"storagefiletype"][@"hash_A57D6164B91A8FC"],
		path = {
			@"hash_3B52E51401F0229C",
			@"zm_halloween_2018",
			@"reward_4",
		},
		lockedStringRef = @"hash_3369ABF4C17436E3",
		unlockedStringRef = @"hash_D655AC8E9A3ACCC",
		itemUnlockable = function()
			local f5_local0 = CoD.SpecialEventUtility.GetCurrentSpecialEventInfo()
			return f5_local0 and f5_local0.statHash == @"zm_halloween_2018"
		end,
		lootIds = {
			@"hash_575912091D384F94",
			@"hash_583EE58E84ECCB72",
			@"hash_716182C9F665AE2D",
			@"hash_41E8D19D1152E4FE",
			@"hash_25825D8F4A5D77CE",
			@"hash_5E7A96A6F2EFDA1F",
			@"hash_2AA682587E6F1B2A",
			@"hash_49480B6ECE2DA29",
			@"hash_29C49492C21B494E",
			@"hash_2CEC2846159BE561",
			@"hash_65B328CB49DCBF3D",
			@"hash_3914D4264841A55D",
			@"hash_76D8F24244865AB5",
			@"hash_5A4BAB60B64F924",
			@"hash_26C8404196F4B89F",
			@"hash_5A85BF135163357F",
			@"hash_297C7CE8C61A0857",
			@"hash_182A5DEAD7212240",
			@"hash_28DD691FCA35C848",
			0x89BD30F3EF5082,
			@"hash_67E82CDB96D7C099",
			@"hash_4F754311FE4C0539",
		},
	},
	[@"zm_winter_2018_reward_1"] = {
		storageFile = Enum[@"storagefiletype"][@"hash_A57D6164B91A8FC"],
		path = {
			@"hash_3B52E51401F0229C",
			@"zm_winter_2018",
			@"reward_1",
		},
		lockedStringRef = @"hash_559A4FBDA30BC349",
		unlockedStringRef = @"hash_2780F5BDCFEFA0A6",
		itemUnlockable = function()
			local f6_local0 = CoD.SpecialEventUtility.GetCurrentSpecialEventInfo()
			return f6_local0 and f6_local0.statHash == @"zm_winter_2018"
		end,
		lootIds = {
			@"hash_3AD487C35DCF6FC3",
			@"hash_5FA364A8C4CDBB9D",
			@"hash_5893033D3717A410",
			@"hash_25DD1B44DDC74A45",
			@"hash_1DD2F4182E5ABF99",
			@"hash_71DF9D3DCD44BBD8",
			@"hash_6C6317DEB9328065",
			@"hash_339E376D1937480C",
			@"hash_7357FFB28AE5B57B",
			@"hash_5EDE6001BC6CAE48",
			@"hash_7FBD5C20EB662A6",
			@"hash_210978D1E6630D52",
			@"hash_7F4EB2BBE90844E8",
			@"hash_E26CA602B106747",
			@"hash_5EBAD857FDB1860A",
			@"hash_626CF76027017D86",
			@"hash_62C00B43B8D41484",
			@"hash_3E040C607076A751",
			@"hash_551D3A0C174FA287",
			@"hash_7C98A5A5874FF429",
			@"hash_46F5007343A7F66A",
			@"hash_1C99B7FD33781BEA",
			@"hash_555A382B548E2098",
		},
	},
	[@"zm_winter_2018_reward_2"] = {
		storageFile = Enum[@"storagefiletype"][@"hash_A57D6164B91A8FC"],
		path = {
			@"hash_3B52E51401F0229C",
			@"zm_winter_2018",
			@"reward_2",
		},
		lockedStringRef = @"hash_559A4FBDA30BC349",
		unlockedStringRef = @"hash_2780F5BDCFEFA0A6",
		itemUnlockable = function()
			local f7_local0 = CoD.SpecialEventUtility.GetCurrentSpecialEventInfo()
			return f7_local0 and f7_local0.statHash == @"zm_winter_2018"
		end,
		lootIds = {
			@"hash_4FAE28D345693152",
			@"hash_3B42307C6E8D724",
			@"hash_725EEF484D7CCB27",
			@"hash_4D85BECEFF5C3AF0",
			@"hash_5651D247D3DB5554",
			@"hash_46E558D11DEE3F55",
			@"hash_3787B58A7036E108",
			@"hash_5DDF901CDEB0BC33",
			@"hash_761A01269DF5DFA0",
			@"hash_79C1FE7CC2B30937",
			@"hash_454059297881EB03",
			@"hash_43E7CE40F72EF203",
			@"hash_37A3E113C9105653",
			@"hash_7890D8E382B83C02",
			0x43BB2D360F74ED,
			@"hash_67D743CBD19521ED",
			@"hash_31E41ACB5722C49D",
			@"hash_4B0BD1DB0A086816",
			@"hash_5667A84C2F9E34E2",
			@"hash_51C54EB591B9511C",
			@"hash_4A3EDDD1E8B60703",
			@"hash_1C0A86D13DC4EC0F",
			@"hash_7F008EDB198501B7",
		},
	},
	[@"zm_winter_2018_reward_3"] = {
		storageFile = Enum[@"storagefiletype"][@"hash_A57D6164B91A8FC"],
		path = {
			@"hash_3B52E51401F0229C",
			@"zm_winter_2018",
			@"reward_3",
		},
		lockedStringRef = @"hash_559A4FBDA30BC349",
		unlockedStringRef = @"hash_2780F5BDCFEFA0A6",
		itemUnlockable = function()
			local f8_local0 = CoD.SpecialEventUtility.GetCurrentSpecialEventInfo()
			return f8_local0 and f8_local0.statHash == @"zm_winter_2018"
		end,
		lootIds = {
			@"hash_139531747A150EC2",
			@"hash_5BFB246FD4659754",
			@"hash_1C23165DCE84DCF7",
			@"hash_7E095576D37CD920",
			@"hash_2A1B54BAA4CFACC4",
			@"hash_893E6AD58C60705",
			@"hash_76C9909809CE5B18",
			@"hash_3C97797A7457FE03",
			@"hash_9D5483B814551D0",
			@"hash_6CFDA8E5BC0FC927",
			@"hash_484FA90E5BEDAF3",
			@"hash_6F764EA0B02435B3",
			@"hash_23E06B3B01EAFBE3",
			@"hash_269365B45A905692",
			0x137F5ED4639F7D,
			@"hash_2BE2C79DEED3813D",
			@"hash_447A354983636E0D",
			@"hash_293A2BED3B3BD2C6",
			@"hash_3EC5B1DC89DD25B2",
			@"hash_799A50FF4062938C",
			@"hash_1F872283D54B1933",
			@"hash_5C1C21E286CDD45F",
			0xC698394A5B92C7,
		},
	},
	[@"zm_winter_2018_reward_4"] = {
		storageFile = Enum[@"storagefiletype"][@"hash_A57D6164B91A8FC"],
		path = {
			@"hash_3B52E51401F0229C",
			@"zm_winter_2018",
			@"reward_4",
		},
		lockedStringRef = @"hash_559A4FBDA30BC349",
		unlockedStringRef = @"hash_2780F5BDCFEFA0A6",
		itemUnlockable = function()
			local f9_local0 = CoD.SpecialEventUtility.GetCurrentSpecialEventInfo()
			return f9_local0 and f9_local0.statHash == @"zm_winter_2018"
		end,
		lootIds = {
			@"hash_31FB2969AB22B2A",
			@"hash_1E59AE0BE10EE15C",
			@"hash_68DED5070E103EEF",
			@"hash_135CEE9D1F842EF8",
			@"hash_47064E6795C0828C",
			@"hash_7A898D05EFE72FFD",
			0x72E199502D8090,
			@"hash_517908E049E903AB",
			@"hash_143E11F63147B1A8",
			@"hash_7B17C7442DD6B60F",
			@"hash_59446D8E8E91B70B",
			@"hash_676B9CBACE1D34B",
			@"hash_6EEC23CC248B111B",
			@"hash_4701DA779F33271A",
			@"hash_452386078C4E6695",
			@"hash_6A6371A65028B4D5",
			@"hash_3966056009637405",
			@"hash_6E269AA19BA778EE",
			@"hash_41EC73BCF2899B8A",
			@"hash_11AD09F12C51D044",
			@"hash_37BD4DC98C2887CB",
			@"hash_555602E4B87E50F7",
			@"hash_1D50082173EA0D8F",
		},
	},
}
CoD.BlackMarketTableUtility[@"hash_733358695872A441"] = {
	[@"hash_AAEF8C1B2CB1C79"] = @"hash_7F410B145DCE17BD",
	[@"hash_71205A986B4A89A7"] = @"hash_7A9842F6BEC0E568",
	[@"hash_5814FA48F1A5AE2A"] = @"hash_6999516E5E35A515",
	[@"hash_33AEA5A87AEA226F"] = @"hash_8596BC069593313",
	[@"hash_2ADFBB57B3F4939E"] = 0x3D7717027A0F92,
	[@"hash_1D1E23073FFE5E47"] = @"hash_4B77F84C47802222",
	[@"hash_32802518C8458986"] = @"hash_62361C68E083D401",
	[@"hash_32031E9BA4DA5393"] = @"hash_78C357C8A5680D67",
	[@"hash_32C6BA9E60BDB826"] = @"hash_63B894FA4D634238",
	[@"hash_682F9EF36F4D4AD"] = @"hash_17C02481305F0E24",
	[@"hash_4EE280A4B988F4FB"] = @"hash_69BBE1EC48F79DF5",
	[@"hash_1DE4E977B12948"] = @"hash_1DC888EECACF65D4",
	[@"hash_6FE24B15C9DE2184"] = @"hash_1EE2659E8DFF07D8",
	[0xE89B11A63B156A] = @"hash_76CCE42BFC9866CD",
}
CoD.BlackMarketTableUtility[@"hash_6986E4198CE10DF3"] = @"hash_29A9BD2389B3C356"
CoD.BlackMarketTableUtility[@"hash_33C671F618E1D758"] = {
	linkedLootIdTable = CoD.BlackMarketTableUtility[@"hash_733358695872A441"],
	lockedStringRef = @"hash_36F8A6FDE43A4789",
	unlockedStringRef = @"hash_176D201B1691A3E6",
}
CoD.BlackMarketTableUtility[@"hash_548F022EAF4F53A3"] = {
	[@"ui_icon_stickers_gauntlet_unsinkable"] = {
		storageFile = Enum[@"storagefiletype"][@"hash_A57D6164B91A8FC"],
		path = {
			@"playerstatslist",
			@"hash_2C88C6128E0BE61",
			@"statvalue",
		},
		lockedStringRef = 0xC6DC1A7FAC1E48,
		unlockedStringRef = @"hash_2FBC87DDBF94F262",
		itemUnlockable = function()
			return false
		end,
	},
	[@"ui_icon_stickers_gauntlet_vinividizombie"] = {
		storageFile = Enum[@"storagefiletype"][@"hash_A57D6164B91A8FC"],
		path = {
			@"playerstatslist",
			0xD31F5C1693D096,
			@"statvalue",
		},
		lockedStringRef = @"hash_3DEADD371D74E38C",
		unlockedStringRef = @"hash_574B2C581B1EE696",
		itemUnlockable = function()
			return false
		end,
	},
	[@"ui_icon_stickers_gauntlet_deathconfive"] = {
		storageFile = Enum[@"storagefiletype"][@"hash_A57D6164B91A8FC"],
		path = {
			@"playerstatslist",
			0xFEEBDA8BD7FDC,
			@"statvalue",
		},
		lockedStringRef = @"hash_7D04C533DC2235E6",
		unlockedStringRef = @"hash_157F0E5854DC9308",
		itemUnlockable = function()
			return false
		end,
	},
	[@"ui_icon_stickers_gauntlet_hellcatraz"] = {
		storageFile = Enum[@"storagefiletype"][@"hash_A57D6164B91A8FC"],
		path = {
			@"playerstatslist",
			@"hash_4402D97CCDAE530F",
			@"statvalue",
		},
		lockedStringRef = @"hash_1F075735A3BB5BB6",
		unlockedStringRef = @"hash_69ADB853E213968F",
		itemUnlockable = function()
			return false
		end,
	},
	[@"loot_ui_icon_stickers_zm_wolf_moon"] = {
		storageFile = Enum[@"storagefiletype"][@"hash_A57D6164B91A8FC"],
		path = {
			@"playerstatslist",
			@"hash_23D2D5674D304C2D",
			@"statvalue",
		},
		lockedStringRef = @"hash_316859B1C782F9F2",
		unlockedStringRef = @"hash_1E70F147F622CC72",
		itemUnlockable = function()
			return false
		end,
	},
	[@"loot_ui_icon_stickers_zm_delphi"] = {
		storageFile = Enum[@"storagefiletype"][@"hash_A57D6164B91A8FC"],
		path = {
			@"playerstatslist",
			@"hash_112C92D966D3F90B",
			@"statvalue",
		},
		lockedStringRef = @"hash_757782883FEE8976",
		unlockedStringRef = @"hash_19BD658EB1AA6206",
		itemUnlockable = function()
			return false
		end,
	},
	[@"ui_icon_stickers_gauntlet_unsinkable_variant_1"] = {
		storageFile = Enum[@"storagefiletype"][@"hash_A57D6164B91A8FC"],
		path = {
			@"playerstatslist",
			@"hash_65A6063DD5DC5425",
			@"statvalue",
		},
		lockedStringRef = @"hash_656A30ED7D329F5C",
		unlockedStringRef = @"hash_71C2ECA0D6772E3A",
		itemUnlockable = function()
			return false
		end,
	},
	[@"hash_52EB1680B294E084"] = {
		storageFile = Enum[@"storagefiletype"][@"hash_A57D6164B91A8FC"],
		path = {
			@"playerstatslist",
			@"hash_35018EB03FB43999",
			@"statvalue",
		},
		lockedStringRef = @"hash_4EAA7F3D6F2BA4CC",
		unlockedStringRef = @"hash_36DB81F2D0441E41",
		itemUnlockable = function()
			return false
		end,
	},
	[@"hash_1A15336CFB3AE9CE"] = {
		storageFile = Enum[@"storagefiletype"][@"hash_A57D6164B91A8FC"],
		path = {
			@"playerstatslist",
			@"hash_5FB724D439B8956",
			@"statvalue",
		},
		lockedStringRef = @"hash_65B5BA355D71196A",
		unlockedStringRef = @"hash_46A5E16D5603427",
		itemUnlockable = function()
			return false
		end,
	},
}
CoD.BlackMarketTableUtility.GetStatsBasedUnlockId = function()
	if CoD.BlackMarketTableUtility.StatsBasedUnlockId == nil then
		CoD.BlackMarketTableUtility.StatsBasedUnlockId = {}
		for f19_local8, f19_local9 in pairs(CoD.BlackMarketTableUtility.StatBasedOutfitUnlocks) do
			if f19_local9.lootIds then
				for f19_local6, f19_local7 in ipairs(f19_local9.lootIds) do
					CoD.BlackMarketTableUtility.StatsBasedUnlockId[f19_local7] = f19_local9
				end
			end
		end
		for f19_local8, f19_local9 in pairs(CoD.BlackMarketTableUtility[@"hash_548F022EAF4F53A3"]) do
			CoD.BlackMarketTableUtility.StatsBasedUnlockId[f19_local8] = f19_local9
		end
		CoD.BlackMarketTableUtility.StatsBasedUnlockId[CoD.BlackMarketTableUtility[@"hash_6986E4198CE10DF3"]] = {
			lockedStringRef = CoD.BlackMarketTableUtility[@"hash_33C671F618E1D758"].lockedStringRef,
			unlockedStringRef = CoD.BlackMarketTableUtility[@"hash_33C671F618E1D758"].unlockedStringRef,
			linkedLootIds = {},
		}
		if CoD.BlackMarketTableUtility[@"hash_33C671F618E1D758"].linkedLootIdTable then
			for f19_local8, f19_local9 in pairs(CoD.BlackMarketTableUtility[@"hash_33C671F618E1D758"].linkedLootIdTable) do
				table.insert(CoD.BlackMarketTableUtility.StatsBasedUnlockId[CoD.BlackMarketTableUtility[@"hash_6986E4198CE10DF3"]].linkedLootIds, f19_local8)
			end
		end
		for f19_local8, f19_local9 in pairs(CoD.BlackMarketTableUtility[@"hash_733358695872A441"]) do
			local f19_local3 = Enum[@"emodes"][@"mode_warzone"]
			CoD.BlackMarketTableUtility.StatsBasedUnlockId[f19_local8] = {
				storageFile = Enum[@"storagefiletype"][@"hash_1AB0E693244221BC"],
				path = {
					@"characters",
					f19_local9,
					@"unlocked",
				},
				lockedStringLookup = function()
					local f20_local0 = Engine[@"hash_284E3CB0C7D8BA11"](f19_local3, f19_local9)
					if f20_local0 then
						local f20_local1 = Engine[@"getpositionrolebundleinfo"](f19_local3, f20_local0)
						if f20_local1[0xCD61284E7266D8] then
							return Engine[@"hash_4F9F1239CFD921FE"](f20_local1[0xCD61284E7266D8])
						end
					end
					return ""
				end,
				unlockedStringLookup = function()
					local f21_local0 = Engine[@"hash_284E3CB0C7D8BA11"](f19_local3, f19_local9)
					if f21_local0 then
						local f21_local1 = Engine[@"getpositionrolebundleinfo"](f19_local3, f21_local0)
						if f21_local1[0x15DD85F0F9E0AD] then
							return Engine[@"hash_4F9F1239CFD921FE"](f21_local1[0x15DD85F0F9E0AD])
						end
					end
					return ""
				end,
				itemUnlockable = function()
					local f22_local0 = Engine[@"hash_284E3CB0C7D8BA11"](f19_local3, f19_local9)
					if f22_local0 then
						local f22_local1 = Engine[@"getpositionrolebundleinfo"](f19_local3, f22_local0)
						if f22_local1[@"hash_35B085B6F0EF35E2"] and f22_local1[@"hash_35B085B6F0EF35E2"] ~= 0x0 and not IsBooleanDvarSet(f22_local1[@"hash_35B085B6F0EF35E2"]) then
							return false
						end
					end
					return IsBooleanDvarSet(@"hash_4A5FD7D94CFC9DFD")
				end,
				notOwnedWhenUnavilable = true,
			}
		end
		for f19_local8, f19_local9 in ipairs({
			@"hash_3C068BC5135B7DF0",
			@"hash_2B8F5BADEA243DDA",
			@"hash_78AE86C11D64760A",
			@"hash_78AE81C11D646D8B",
			@"hash_1C057428D4E91AE8",
			@"hash_1A942F2AEECCB69",
		}) do
			CoD.BlackMarketTableUtility.StatsBasedUnlockId[f19_local9] = {
				storageFile = Enum[@"storagefiletype"][@"hash_1AB0E693244221BC"],
				path = {
					@"unlockedtags",
					f19_local9,
				},
				unlockedStringRef = @"hash_574BDFDE54AFF033",
				itemUnlockable = function()
					return false
				end,
			}
		end
		if CoD.ZombiesCallingsUtility and IsBooleanDvarSet(@"hash_11DA02CA40639DE5") then
			CoD.ZombiesCallingsUtility.AddFactionCallingStatUnlocks(CoD.BlackMarketTableUtility.StatsBasedUnlockId)
		end
	end
	return CoD.BlackMarketTableUtility.StatsBasedUnlockId
end
CoD.BlackMarketTableUtility[@"hash_3B789987DAEDF129"] = {
	[@"loot_pistol_standard_sig_01"] = "346173322",
	[@"loot_ar_fastfire_sig_01"] = "345570600",
}
CoD.BlackMarketTableUtility[@"hash_7ACB591F93627122"] = {
	[@"loot_smg_standard_sig_01"] = {
		entitlement = @"hash_6C94ED95E25D8246",
		deluxe_pack_id = "500016",
		itemID = "377952817",
	},
}
CoD.BlackMarketTableUtility[@"hash_25DDB72D0172A035"] = function(f24_arg0, f24_arg1)
	local f24_local0 = CoD.BlackMarketTableUtility[@"hash_3B789987DAEDF129"][f24_arg1]
	if f24_local0 then
		return true, f24_local0 and Engine[@"hash_5352DC095BBB2A45"](f24_arg0, f24_local0) > 0
	elseif CoD.BlackMarketTableUtility[@"hash_7ACB591F93627122"][f24_arg1] then
		local f24_local1 = CoD.BlackMarketTableUtility[@"hash_7ACB591F93627122"][f24_arg1].entitlement
		local f24_local2 = Engine[@"hash_5352DC095BBB2A45"](f24_arg0, CoD.BlackMarketTableUtility[@"hash_7ACB591F93627122"][f24_arg1].itemID)
		local f24_local3 = Engine[@"hash_5352DC095BBB2A45"](f24_arg0, CoD.BlackMarketTableUtility[@"hash_7ACB591F93627122"][f24_arg1].deluxe_pack_id)
		if f24_local3 > 0 and not Engine[@"hasentitlement"](f24_arg0, f24_local1) and not IsBooleanDvarSet(@"loot_fakeall") then
			f24_local2 = f24_local2 - f24_local3
		end
		return f24_local1 ~= nil, f24_local2 > 0
	else
		return false, false
	end
end
CoD.BlackMarketTableUtility[@"hash_2152E2ED863A7D7A"] = {
	[@"c_t8_bo_jumpkit_game_cartridge"] = {
		entitlement = 0x15BE56C5EA0253,
		_id = "500036",
		itemID = "445584988",
	},
	[@"hash_468A29BD720AEEFB"] = {
		entitlement = 0x15BE56C5EA0253,
		_id = "500036",
		itemID = "437925560",
	},
	[@"hash_73617BA9FBFD5096"] = {
		entitlement = @"hash_377B58D9F38DE25F",
		_id = "500037",
		itemID = "423973420",
	},
	[@"jumppack_hide"] = {
		entitlement = @"hash_377B58D9F38DE25F",
		_id = "500037",
		itemID = "476947721",
	},
	[@"hash_652641DAB6CBB097"] = {
		entitlement = @"hash_377B58D9F38DE25F",
		_id = "500037",
		itemID = "404926528",
	},
}
CoD.BlackMarketTableUtility[@"hash_1214319EDB448F3B"] = function(f25_arg0, f25_arg1)
	if CoD.BlackMarketTableUtility[@"hash_2152E2ED863A7D7A"][f25_arg1] then
		local f25_local0 = CoD.BlackMarketTableUtility[@"hash_2152E2ED863A7D7A"][f25_arg1].entitlement
		local f25_local1 = Engine[@"hash_5352DC095BBB2A45"](f25_arg0, CoD.BlackMarketTableUtility[@"hash_2152E2ED863A7D7A"][f25_arg1].itemID)
		local f25_local2 = Engine[@"hash_5352DC095BBB2A45"](f25_arg0, CoD.BlackMarketTableUtility[@"hash_2152E2ED863A7D7A"][f25_arg1]._id)
		if f25_local2 > 0 and not Engine[@"hasentitlement"](f25_arg0, f25_local0) and not IsBooleanDvarSet(@"loot_fakeall") then
			f25_local1 = f25_local1 - f25_local2
		end
		return f25_local0 ~= nil, f25_local1 > 0
	else
		return false, false
	end
end
CoD.BlackMarketTableUtility[@"hash_2AFA534398B6DC13"] = {
	[@"hash_84D8BFDB82B4817"] = {
		entitlement = @"hash_6C94ED95E25D8246",
		deluxe_pack_id = "500016",
		itemID = "421505015",
	},
	[0x662201FF1176B2] = {
		entitlement = @"hash_6C94ED95E25D8246",
		deluxe_pack_id = "500016",
		itemID = "423463536",
	},
	[@"hash_367AB528E51F4384"] = {
		entitlement = @"hash_6C94ED95E25D8246",
		deluxe_pack_id = "500016",
		itemID = "478843040",
	},
	[@"hash_77B56714629EDC50"] = {
		entitlement = @"hash_6C94ED95E25D8246",
		deluxe_pack_id = "500016",
		itemID = "414111952",
	},
	[@"hash_5B26468EF2E98B4"] = {
		entitlement = @"hash_6C94ED95E25D8246",
		deluxe_pack_id = "500016",
		itemID = "477922231",
	},
	[@"hash_3D522FD3D8CEE3B5"] = {
		entitlement = @"hash_6C94ED95E25D8246",
		deluxe_pack_id = "500016",
		itemID = "477393635",
	},
	[@"hash_3D6D47A6A38B7968"] = {
		entitlement = @"hash_6C94ED95E25D8246",
		deluxe_pack_id = "500016",
		itemID = "416135420",
	},
	[@"hash_6C6C1D9DD42AAE13"] = {
		entitlement = @"hash_6C94ED95E25D8246",
		deluxe_pack_id = "500016",
		itemID = "484816462",
	},
	[@"hash_73EFEF6CF46EC080"] = {
		entitlement = @"hash_6C94ED95E25D8246",
		deluxe_pack_id = "500016",
		itemID = "414861863",
	},
	[@"hash_4152B311548CFC07"] = {
		entitlement = @"hash_6C94ED95E25D8246",
		deluxe_pack_id = "500016",
		itemID = "484699561",
	},
}
CoD.BlackMarketTableUtility[@"hash_762B0EE548400BF2"] = function(f26_arg0, f26_arg1)
	local f26_local0 = Engine[@"trytablelookup"](CoD.BlackMarketTableUtility.BundleTable.name, CoD.BlackMarketTableUtility.BundleTable.COL_BUNDLE, CoD.BlackMarketTableUtility.BundleTable.COL_NAMEHASH, f26_arg1)
	if CoD.BlackMarketTableUtility[@"hash_2AFA534398B6DC13"][f26_local0] then
		local f26_local1 = CoD.BlackMarketTableUtility[@"hash_2AFA534398B6DC13"][f26_local0].entitlement
		local f26_local2 = Engine[@"hash_5352DC095BBB2A45"](f26_arg0, CoD.BlackMarketTableUtility[@"hash_2AFA534398B6DC13"][f26_local0].deluxe_pack_id) > 0
		local f26_local3 = Engine[@"hash_5352DC095BBB2A45"](f26_arg0, CoD.BlackMarketTableUtility[@"hash_2AFA534398B6DC13"][f26_local0].itemID)
		if f26_local2 and not Engine[@"hasentitlement"](f26_arg0, f26_local1) and not IsBooleanDvarSet(@"loot_fakeall") then
			f26_local3 = f26_local3 - 1
		end
		return f26_local1 ~= nil, f26_local3 > 0
	else
		return false, false
	end
end
CoD.BlackMarketTableUtility[@"hash_714DE8345BDDBCA8"] = {
	[@"hash_641D42086962443D"] = 500201,
	[@"hash_25D901B2845AFFB5"] = 500202,
	[@"hash_271546989F2B39C0"] = 500203,
	[@"hash_17C8471AD085983B"] = 500204,
	[@"hash_BAC19A8A93F750A"] = 500205,
	[@"hash_74A7B1F09EB77129"] = 500206,
	[@"hash_265A8BFE9E6A3A8F"] = 500207,
	[@"hash_215EFCE6AF8D9A10"] = 500208,
	[@"hash_35ABB557417D97BC"] = 500209,
	[@"hash_34C5E1C04823489D"] = 500210,
}
CoD.BlackMarketTableUtility[@"hash_521632E84A5AAF71"] = function(f27_arg0)
	return CoD.BlackMarketTableUtility[@"hash_714DE8345BDDBCA8"][f27_arg0]
end
CoD.BlackMarketTableUtility.GetInfoIfOnlyOwnedNonBaseWeapon = function(f28_arg0, f28_arg1, f28_arg2, f28_arg3, f28_arg4)
	if not f28_arg2 or not f28_arg3 then
		local f28_local0 = Engine[@"hash_79F0BB7D52A7A978"](f28_arg1)
		if f28_local0 and #f28_local0 > 0 then
			for f28_local6, f28_local7 in ipairs(f28_local0) do
				if f28_local7 then
					local f28_local4 = f28_local7[@"lootid"]
					local f28_local5 = CoD.BlackMarketTableUtility.GetContrabandInfoForPlayer(f28_arg0, f28_local4, f28_arg4)
					if f28_local5 and f28_local5.owned and not CoD.CACUtility.DvarHideUnlockableItem(f28_local4, Engine[@"currentsessionmode"]()) then
						f28_local5.useVariantSlot = f28_local7[@"index"]
						return f28_local5
					end
				end
			end
		end
	end
end
CoD.BlackMarketTableUtility.FindCorrectRow = function(f29_arg0, f29_arg1, f29_arg2, f29_arg3)
	if not f29_arg2 then
		return f29_arg0[1]
	end
	for f29_local4, f29_local5 in ipairs(f29_arg0) do
		if f29_arg2.weaponRef then
			local f29_local3 = Engine[@"hash_4C6F8EC444864600"](f29_arg1, f29_local5, f29_arg3)
			if not f29_local3 or f29_local3 == 0x0 or f29_local3 == f29_arg2.weaponRef then
				return f29_local5
			end
		end
	end
	return nil
end
CoD.BlackMarketTableUtility.GetContractId = function(f30_arg0)
	local f30_local0 = Engine[@"trytablelookup"](CoD.BlackMarketTableUtility.MasterContractTable.name, CoD.BlackMarketTableUtility.MasterContractTable.COL_ID, CoD.BlackMarketTableUtility.MasterContractTable.COL_NAMEHASH, f30_arg0)
	if f30_local0 == nil then
		return "0"
	else
		return f30_local0
	end
end
CoD.BlackMarketTableUtility.GetContractInfo = function(f31_arg0)
	local f31_local0 = {
		id = f31_arg0,
		namehash = Engine[@"trytablelookup"](CoD.BlackMarketTableUtility.MasterContractTable.name, CoD.BlackMarketTableUtility.MasterContractTable.COL_NAMEHASH, CoD.BlackMarketTableUtility.MasterContractTable.COL_ID, f31_arg0),
		rarity = Engine[@"trytablelookup"](CoD.BlackMarketTableUtility.MasterContractTable.name, CoD.BlackMarketTableUtility.MasterContractTable.COL_RARITY, CoD.BlackMarketTableUtility.MasterContractTable.COL_ID, f31_arg0),
		dropnumber = Engine[@"trytablelookup"](CoD.BlackMarketTableUtility.MasterContractTable.name, CoD.BlackMarketTableUtility.MasterContractTable.COL_DROPNUMBER, CoD.BlackMarketTableUtility.MasterContractTable.COL_ID, f31_arg0),
		type = Engine[@"trytablelookup"](CoD.BlackMarketTableUtility.MasterContractTable.name, CoD.BlackMarketTableUtility.MasterContractTable.COL_TYPE, CoD.BlackMarketTableUtility.MasterContractTable.COL_ID, f31_arg0),
		price = Engine[@"trytablelookup"](CoD.BlackMarketTableUtility.MasterContractTable.name, CoD.BlackMarketTableUtility.MasterContractTable.COL_PRICE, CoD.BlackMarketTableUtility.MasterContractTable.COL_ID, f31_arg0),
		discountSku = Engine[@"trytablelookup"](CoD.BlackMarketTableUtility.MasterContractTable.name, CoD.BlackMarketTableUtility.MasterContractTable.COL_DISCOUNT_SKU, CoD.BlackMarketTableUtility.MasterContractTable.COL_ID, f31_arg0),
		discountPrice = Engine[@"trytablelookup"](CoD.BlackMarketTableUtility.MasterContractTable.name, CoD.BlackMarketTableUtility.MasterContractTable.COL_DISCOUNT_PRICE, CoD.BlackMarketTableUtility.MasterContractTable.COL_ID, f31_arg0),
	}
	if f31_local0.namehash == nil or f31_local0.rarity == nil or f31_local0.dropnumber == nil then
		return nil
	else
		return f31_local0
	end
end
CoD.BlackMarketTableUtility.GetContractTierCount = function(f32_arg0)
	local f32_local0 = CoD.BlackMarketTableUtility.GetContractInfo(f32_arg0)
	if f32_local0 and CoD.BlackMarketTableUtility.ContractsTable.names[f32_local0.namehash] then
		return Engine[@"gettablerowcount"](CoD.BlackMarketTableUtility.ContractsTable.names[f32_local0.namehash])
	else
		return 0
	end
end
CoD.BlackMarketTableUtility.GetContractItemsByTier = function(f33_arg0, f33_arg1, f33_arg2, f33_arg3)
	local f33_local0 = {}
	local f33_local1 = CoD.BlackMarketTableUtility.GetContractInfo(f33_arg1)
	if f33_local1 == nil then
		return f33_local0
	elseif CoD.BlackMarketTableUtility.ContractsTable.names[f33_local1.namehash] ~= nil then
		local f33_local2 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.ContractsTable.names[f33_local1.namehash], CoD.BlackMarketTableUtility.ContractsTable.COL_TIER, f33_arg2)
		if not IsBooleanDvarSet(@"hash_DDC9E66934FFDAB") and f33_arg3 ~= nil and f33_arg3 == true then
			local f33_local3 = Engine[@"hash_72D18261CB3AF850"](f33_arg0, f33_local1.namehash, f33_arg2)
			if f33_local3 ~= nil then
				for f33_local4 = 1, #f33_local3, 1 do
					if f33_local3[f33_local4].flags >= LuaEnum.LOOT_FLAGS.VALID then
						local f33_local7 = CoD.BlackMarketTableUtility.GetContractItemInfo(f33_arg0, f33_arg1, tostring(f33_local3[f33_local4].name))
						if f33_local7 == nil or f33_local7.name == 0x0 then
							f33_local7 = CoD.BlackMarketTableUtility.GetContrabandItemInfo(f33_arg0, tostring(f33_local3[f33_local4].name), f33_arg2)
						end
						if f33_local7 ~= nil then
							if f33_local3[f33_local4].flags == LuaEnum.LOOT_FLAGS.DUPE then
								f33_local7.dupe = true
							elseif f33_local3[f33_local4].flags == LuaEnum.LOOT_FLAGS.REROLL then
								f33_local7.reroll = true
							end
							table.insert(f33_local0, f33_local7)
						end
					end
					table.insert(f33_local0, {
						name = @"hash_0",
						gap = true,
					})
				end
			end
			return f33_local0
		elseif f33_local2 ~= nil then
			for f33_local3 = 1, #f33_local2, 1 do
				local f33_local8 = CoD.BlackMarketTableUtility.GetContractItemInfo(f33_arg0, f33_arg1, Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContractsTable.names[f33_local1.namehash], f33_local2[f33_local3], CoD.BlackMarketTableUtility.ContractsTable.COL_ID))
				if f33_local8 then
					f33_local8.gap = true
					table.insert(f33_local0, f33_local8)
				end
			end
		end
	end
	return f33_local0
end
CoD.BlackMarketTableUtility.GetContractCompletionTier = function(f34_arg0, f34_arg1)
	local f34_local0 = Engine[@"storagegetbuffer"](f34_arg0, Enum[@"storagefiletype"][@"storage_mp_stats_online"])
	if f34_local0 ~= nil then
		for f34_local5, f34_local6 in pairs(CoDShared.Loot.ContractSlots) do
			if f34_local6 ~= nil then
				local f34_local4 = f34_local0[@"loot_contracts"][f34_local6]
				if f34_local4 ~= nil and f34_arg1 == f34_local4[@"contractid"]:get() then
					return f34_local4[@"completiontier"]:get()
				end
			end
		end
	end
	return 0
end
CoD.BlackMarketTableUtility.GetContractItemsByRelativeTier = function(f35_arg0, f35_arg1, f35_arg2)
	local f35_local0 = CoD.BlackMarketTableUtility.GetContractInfo(f35_arg1)
	if f35_local0 == nil then
		return {}
	end
	local f35_local1 = CoD.BlackMarketUtility.GetContractProgress(f35_arg0, f35_local0.namehash)
	local f35_local2 = CoD.BlackMarketUtility.GetCurrentSeasonTier(f35_arg0)
	local f35_local3 = f35_arg2 - f35_local2 + f35_local1
	local f35_local4 = 0
	if CoD.BlackMarketUtility.IsContractCompleted(f35_arg0, f35_local0.id) then
		local f35_local5 = nil
		local f35_local6 = CoDShared.Loot.GetCurrentEventContract()
		if f35_local6 ~= nil and f35_local6 ~= 0x0 then
			local f35_local7 = CoDShared.Loot.GetContractInfo(f35_arg0, f35_local6)
			if f35_local7 ~= nil then
				f35_local5 = f35_local7.id
			end
		end
		if f35_local5 ~= nil and f35_local5 == f35_local0.id then
			local f35_local7 = Engine[@"storagegetbuffer"](f35_arg0, Enum[@"storagefiletype"][@"storage_mp_stats_online"])
			if f35_local7 ~= nil then
				local f35_local8 = f35_local7.loot_contracts.SLOT_EVENT.contractId
				local f35_local9 = f35_local7.loot_contracts.SLOT_EVENT.completionTier
				if f35_local8 and f35_local9 then
					local f35_local10 = f35_local8:get()
					local f35_local11 = f35_local9:get()
					if f35_local10 == tonumber(f35_local5) then
						f35_local4 = f35_local11
					else
						f35_local8:set(f35_local5)
						f35_local9:set(f35_local2)
						Engine[@"storagewrite"](f35_arg0, Enum[@"storagefiletype"][@"storage_mp_stats_online"])
						f35_local4 = f35_local2
					end
				end
			end
		else
			f35_local4 = CoD.BlackMarketTableUtility.GetContractCompletionTier(f35_arg0, f35_local0.id)
		end
	end
	if f35_local4 > 0 then
		f35_local3 = f35_local3 + f35_local2 - f35_local4
	end
	local f35_local5 = f35_arg2 <= f35_local2
	if CoD.BlackMarketTableUtility.GetContractTierCount(f35_local0.id) < f35_local3 then
		return {}
	elseif f35_local3 > 0 then
		return CoD.BlackMarketTableUtility.GetContractItemsByTier(f35_arg0, f35_arg1, f35_local3, f35_local5)
	end
	return {}
end
CoD.BlackMarketTableUtility.GetContractItemInfoFromId = function(f36_arg0, f36_arg1)
	for f36_local3, f36_local4 in pairs(CoD.BlackMarketTableUtility.ContractsTable.names) do
		local f36_local5 = CoD.BlackMarketTableUtility.GetContractItemInfo(f36_arg0, CoD.BlackMarketTableUtility.GetContractId(f36_local3), f36_arg1)
		if f36_local5 then
			return f36_local5
		end
	end
	return nil
end
CoD.BlackMarketTableUtility.GetContractItemInfo = function(f37_arg0, f37_arg1, f37_arg2)
	local f37_local0 = nil
	local f37_local1 = CoD.BlackMarketTableUtility.GetContractInfo(f37_arg1)
	if f37_local1 == nil then
		return f37_local0
	elseif CoD.BlackMarketTableUtility.ContractsTable.names[f37_local1.namehash] ~= nil then
		local f37_local2 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.ContractsTable.names[f37_local1.namehash], CoD.BlackMarketTableUtility.ContractsTable.COL_NAMEHASH, Engine[@"hash_DE65B393F703EB1"](CoD.BlackMarketTableUtility.ContractsTable.names[f37_local1.namehash], CoD.BlackMarketTableUtility.ContractsTable.COL_ID, f37_arg2, CoD.BlackMarketTableUtility.ContractsTable.COL_NAMEHASH))
		if f37_local2 ~= nil and #f37_local2 > 0 then
			local f37_local3 = f37_local2[1]
			f37_local0 = {
				itemId = f37_arg2,
				tier = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContractsTable.names[f37_local1.namehash], f37_local3, CoD.BlackMarketTableUtility.ContractsTable.COL_TIER),
				name = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContractsTable.names[f37_local1.namehash], f37_local3, CoD.BlackMarketTableUtility.ContractsTable.COL_NAMEHASH),
				rarity = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContractsTable.names[f37_local1.namehash], f37_local3, CoD.BlackMarketTableUtility.ContractsTable.COL_RARITY),
				owned = Engine[@"hash_5352DC095BBB2A45"](f37_arg0, f37_arg2),
				inSet = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContractsTable.names[f37_local1.namehash], f37_local3, CoD.BlackMarketTableUtility.ContractsTable.COL_SET),
				category = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContractsTable.names[f37_local1.namehash], f37_local3, CoD.BlackMarketTableUtility.ContractsTable.COL_TYPE),
				movieName = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContractsTable.names[f37_local1.namehash], f37_local3, CoD.BlackMarketTableUtility.ContractsTable.COL_PROMOVIDEO),
				lootType = LuaEnum.LOOT_TYPE.CONTRACT,
				refOptic = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContractsTable.names[f37_local1.namehash], f37_local3, CoD.BlackMarketTableUtility.ContractsTable.COL_REFOPTIC),
			}
		end
	end
	return f37_local0
end
CoD.BlackMarketTableUtility.GetContractPalette = function(f38_arg0, f38_arg1)
	local f38_local0 = CoD.BlackMarketTableUtility.GetContractInfo(f38_arg1)
	if f38_local0 and CoD.BlackMarketTableUtility.ContractsTable.names[f38_local0.namehash] then
		local f38_local1 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.ContractsTable.names[f38_local0.namehash], CoD.BlackMarketTableUtility.ContractsTable.COL_TYPE, @"palette")
		if f38_local1 == nil then
			return 0x0
		else
			return Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContractsTable.names[f38_local0.namehash], f38_local1[1], CoD.BlackMarketTableUtility.ContractsTable.COL_NAMEHASH)
		end
	else
	end
end
CoD.BlackMarketTableUtility.GetContractSignatureWeapon = function(f39_arg0, f39_arg1)
	local f39_local0 = CoD.BlackMarketTableUtility.GetContractInfo(f39_arg1)
	if f39_local0 and CoD.BlackMarketTableUtility.ContractsTable.names[f39_local0.namehash] then
		local f39_local1 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.ContractsTable.names[f39_local0.namehash], CoD.BlackMarketTableUtility.ContractsTable.COL_TYPE, @"signature_weapon")
		if f39_local1 == nil then
			return 0x0
		else
			return Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContractsTable.names[f39_local0.namehash], f39_local1[#f39_local1], CoD.BlackMarketTableUtility.ContractsTable.COL_NAMEHASH)
		end
	else
	end
end
CoD.BlackMarketTableUtility.GetContractReactiveCamoRef = function(f40_arg0, f40_arg1)
	local f40_local0 = CoD.BlackMarketTableUtility.GetContractInfo(f40_arg1)
	if f40_local0 and CoD.BlackMarketTableUtility.ContractsTable.names[f40_local0.namehash] then
		local f40_local1 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.ContractsTable.names[f40_local0.namehash], CoD.BlackMarketTableUtility.ContractsTable.COL_TYPE, @"reactive_camo")
		if f40_local1 == nil then
			return 0x0
		else
			return Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContractsTable.names[f40_local0.namehash], f40_local1[#f40_local1], CoD.BlackMarketTableUtility.ContractsTable.COL_NAMEHASH), Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContractsTable.names[f40_local0.namehash], f40_local1[#f40_local1], CoD.BlackMarketTableUtility.ContractsTable.COL_REFWEAPON)
		end
	else
	end
end
CoD.BlackMarketTableUtility.GetContractMastercraft = function(f41_arg0, f41_arg1)
	local f41_local0 = CoD.BlackMarketTableUtility.GetContractInfo(f41_arg1)
	if f41_local0 and CoD.BlackMarketTableUtility.ContractsTable.names[f41_local0.namehash] then
		local f41_local1 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.ContractsTable.names[f41_local0.namehash], CoD.BlackMarketTableUtility.ContractsTable.COL_TYPE, @"mastercraft")
		if f41_local1 == nil then
			return 0x0
		else
			return Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContractsTable.names[f41_local0.namehash], f41_local1[#f41_local1], CoD.BlackMarketTableUtility.ContractsTable.COL_NAMEHASH)
		end
	else
	end
end
CoD.BlackMarketTableUtility.GetContractWeaponRefName = function(f42_arg0, f42_arg1, f42_arg2)
	local f42_local0 = CoD.BlackMarketTableUtility.GetContractInfo(f42_arg2)
	if f42_local0 and CoD.BlackMarketTableUtility.ContractsTable.names[f42_local0.namehash] then
		local f42_local1 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.ContractsTable.names[f42_local0.namehash], CoD.BlackMarketTableUtility.ContractsTable.COL_NAMEHASH, f42_arg1)
		if f42_local1 == nil then
			return 0x0
		else
			return Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContractsTable.names[f42_local0.namehash], f42_local1[#f42_local1], CoD.BlackMarketTableUtility.ContractsTable.COL_REFWEAPON)
		end
	else
	end
end
CoD.BlackMarketTableUtility.GetContractChaseOutfit = function(f43_arg0, f43_arg1)
	local f43_local0 = CoD.BlackMarketTableUtility.GetContractInfo(f43_arg1)
	if f43_local0 and CoD.BlackMarketTableUtility.ContractsTable.names[f43_local0.namehash] then
		local f43_local1 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.ContractsTable.names[f43_local0.namehash], CoD.BlackMarketTableUtility.ContractsTable.COL_TYPE, @"palette")
		if f43_local1 == nil then
			return nil
		end
		local f43_local2 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContractsTable.names[f43_local0.namehash], f43_local1[#f43_local1], CoD.BlackMarketTableUtility.ContractsTable.COL_NAMEHASH)
		if f43_local2 then
			return CoD.BlackMarketTableUtility.GetContractOutfitInfo(f43_arg0, f43_arg1, f43_local2)
		end
	end
	return nil
end
CoD.BlackMarketTableUtility.GetContractOutfitInfo = function(f44_arg0, f44_arg1, f44_arg2)
	local f44_local0 = CoD.BlackMarketTableUtility.GetContractInfo(f44_arg1)
	if f44_local0 and CoD.BlackMarketTableUtility.ContractsTable.names[f44_local0.namehash] then
		local f44_local1 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.ContractsTable.names[f44_local0.namehash], CoD.BlackMarketTableUtility.ContractsTable.COL_NAMEHASH, f44_arg2)
		if f44_local1 == nil then
			return nil
		end
		local f44_local2 = Enum[@"emodes"][@"mode_multiplayer"]
		local f44_local3 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContractsTable.names[f44_local0.namehash], f44_local1[#f44_local1], CoD.BlackMarketTableUtility.ContractsTable.COL_MPPRT)
		if f44_local3 == 0x0 then
			f44_local3 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContractsTable.names[f44_local0.namehash], f44_local1[#f44_local1], CoD.BlackMarketTableUtility.ContractsTable.COL_WZPRT)
			f44_local2 = Enum[@"emodes"][@"mode_warzone"]
		end
		local f44_local4 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContractsTable.names[f44_local0.namehash], f44_local1[#f44_local1], CoD.BlackMarketTableUtility.ContractsTable.COL_OUTFIT)
		if f44_local4 == nil then
			f44_local4 = 0x0
		end
		return {
			mode = f44_local2,
			outfit = f44_local4,
			prt = f44_local3,
		}
	else
		return nil
	end
end
CoD.BlackMarketTableUtility.GetContractCharacter = function(f45_arg0, f45_arg1)
	local f45_local0 = CoD.BlackMarketTableUtility.GetContractInfo(f45_arg1)
	if f45_local0 and CoD.BlackMarketTableUtility.ContractsTable.names[f45_local0.namehash] then
		local f45_local1 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.ContractsTable.names[f45_local0.namehash], CoD.BlackMarketTableUtility.ContractsTable.COL_TYPE, @"character")
		if f45_local1 == nil then
			return 0x0
		else
			return Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContractsTable.names[f45_local0.namehash], f45_local1[#f45_local1], CoD.BlackMarketTableUtility.ContractsTable.COL_NAMEHASH)
		end
	else
	end
end
CoD.BlackMarketTableUtility.GetContractOutfitInformation = function(f46_arg0, f46_arg1, f46_arg2)
	local f46_local0 = 0x0
	local f46_local1 = 0x0
	local f46_local2 = 0x0
	local f46_local3 = CoD.BlackMarketTableUtility.GetContractInfo(f46_arg2)
	if f46_local3 and CoD.BlackMarketTableUtility.ContractsTable.names[f46_local3.namehash] then
		local f46_local4 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.ContractsTable.names[f46_local3.namehash], CoD.BlackMarketTableUtility.ContractsTable.COL_NAMEHASH, f46_arg1)
		if f46_local4 == nil then
			return {}
		end
		local f46_local5 = CoD.BlackMarketTableUtility.GetContractOutfitInfo(f46_arg0, f46_arg2, f46_arg1)
		if f46_local5 then
			local f46_local6 = f46_local5.prt
			local f46_local7 = f46_local5.mode
			local f46_local8 = f46_local5.outfit
			if f46_local6 == 0x0 then
				f46_local6 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContractsTable.names[f46_local3.namehash], f46_local4[1], CoD.BlackMarketTableUtility.ContractsTable.COL_WZPRT)
			end
			if f46_local8 == 0x0 then
				f46_local8 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContractsTable.names[f46_local3.namehash], f46_local4[1], CoD.BlackMarketTableUtility.ContractsTable.COL_OUTFIT)
			end
			f46_local1 = CoD.BlackMarketTableUtility.GetContractPalette(f46_arg0, f46_arg2)
			local f46_local9 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContractsTable.names[f46_local3.namehash], f46_local4[1], CoD.BlackMarketTableUtility.ContractsTable.COL_TYPE)
			local f46_local10 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContractsTable.names[f46_local3.namehash], f46_local4[1], CoD.BlackMarketTableUtility.ContractsTable.COL_NAMEHASH)
			local f46_local11 = Engine[0x422A503291AC81](f46_local9)
			if f46_local11 == Enum[@"characteritemtype"][@"hash_57852FCB3BFCC8D1"] then
				f46_local0 = f46_local10
			elseif f46_local11 == Enum[@"characteritemtype"][@"hash_4922FE5C41D9EE8B"] then
				f46_local1 = f46_local10
			elseif f46_local11 == Enum[@"characteritemtype"][@"hash_48E3A65D78229DC1"] then
				f46_local2 = f46_local10
			end
			return {
				prt = f46_local6,
				mode = f46_local7,
				outfit = f46_local8,
				decal = f46_local0,
				preset = f46_local1,
				war_paint = f46_local2,
			}
		end
	end
	return {}
end
CoD.BlackMarketTableUtility.GetFullContractItemInfo = function(f47_arg0, f47_arg1)
	local f47_local0 = nil
	if CoD.BlackMarketTableUtility.GetContractInfo(CoD.BlackMarketTableUtility.GetContractId(f47_arg1)) == nil then
		return f47_local0
	end
	local f47_local1 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.MasterContractTable.name, CoD.BlackMarketTableUtility.MasterContractTable.COL_NAMEHASH, f47_arg1)
	if f47_local1 ~= nil and #f47_local1 > 0 then
		f47_local0 = {
			name = f47_arg1,
			rarity = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.MasterContractTable.name, f47_local1[1], CoD.BlackMarketTableUtility.MasterContractTable.COL_RARITY),
			category = @"special_order",
		}
	end
	return f47_local0
end
CoD.BlackMarketTableUtility.GetFullContractOutfitInfo = function(f48_arg0, f48_arg1)
	local f48_local0 = CoD.BlackMarketTableUtility.ContractsTable.names[f48_arg1]
	local f48_local1 = CoD.BlackMarketTableUtility.GetContractChaseOutfit(f48_arg0, CoD.BlackMarketTableUtility.GetContractId(f48_arg1))
	if f48_local1 and f48_local0 then
		local f48_local2 = f48_local1.prt
		local f48_local3 = f48_local1.mode
		local f48_local4 = f48_local1.outfit
		local f48_local5 = 0x0
		local f48_local6 = 0x0
		local f48_local7 = 0x0
		local f48_local8 = Engine[@"gettablerowcount"](f48_local0)
		for f48_local9 = 1, f48_local8, 1 do
			local f48_local12 = Engine[@"hash_4C6F8EC444864600"](f48_local0, f48_local9 - 1, CoD.BlackMarketTableUtility.ContractsTable.COL_TYPE)
			if f48_local12 then
				local f48_local13 = Engine[@"hash_4C6F8EC444864600"](f48_local0, f48_local9 - 1, CoD.BlackMarketTableUtility.ContractsTable.COL_NAMEHASH)
				local f48_local14 = Engine[0x422A503291AC81](f48_local12)
				if f48_local14 == Enum[@"characteritemtype"][@"hash_57852FCB3BFCC8D1"] then
					f48_local5 = f48_local13
				end
				if f48_local14 == Enum[@"characteritemtype"][@"hash_4922FE5C41D9EE8B"] then
					f48_local6 = f48_local13
				end
				if f48_local14 == Enum[@"characteritemtype"][@"hash_48E3A65D78229DC1"] then
					f48_local7 = f48_local13
				end
			end
		end
		return {
			prt = f48_local2,
			mode = f48_local3,
			outfit = f48_local4,
			decal = f48_local5,
			preset = f48_local6,
			war_paint = f48_local7,
		}
	else
		return nil
	end
end
CoD.BlackMarketTableUtility.GetContractInfoForPlayer = function(f49_arg0, f49_arg1, f49_arg2)
	for f49_local19, f49_local20 in pairs(CoD.BlackMarketTableUtility.ContractsTable.names) do
		local f49_local21 = Engine[@"tablefindrows"](f49_local20, CoD.BlackMarketTableUtility.ContractsTable.COL_NAMEHASH, f49_arg1)
		if f49_local21 ~= nil and #f49_local21 > 0 then
			local f49_local3 = f49_local21[1]
			local f49_local4 = Engine[@"hash_4C6F8EC444864600"](f49_local20, f49_local3, CoD.BlackMarketTableUtility.ContractsTable.COL_RARITY)
			local f49_local5 = true
			local f49_local6 = Engine[@"hash_4C6F8EC444864600"](f49_local20, f49_local3, CoD.BlackMarketTableUtility.ContractsTable.COL_ID)
			local f49_local7 = CoDShared.IsLootItemOwned(f49_arg0, f49_local6, f49_arg2)
			local f49_local8 = false
			if not f49_local7 then
				f49_local8 = CoD.BlackMarketTableUtility.IsContractOwned(f49_arg0, f49_local19)
			end
			local f49_local9 = f49_local7 or f49_local8
			local f49_local10 = CoD.BlackMarketTableUtility.IsEventContract(f49_local19)
			local f49_local11 = false
			local f49_local12 = CoD.ContractUtility.GetPurchasableContractHashes()
			if f49_local12 and #f49_local12 > 0 then
				for f49_local13 = 1, #f49_local12, 1 do
					if f49_arg1 == f49_local12[f49_local13] then
						f49_local11 = true
						break
					end
				end
			end
			local f49_local13 = CoD.BlackMarketTableUtility.GetInfoIfOnlyOwnedNonBaseWeapon(f49_arg0, f49_arg1, f49_local7, f49_local9, f49_arg2)
			if f49_local13 then
				return f49_local13
			end
			local f49_local14 = Engine[@"hash_4C6F8EC444864600"](f49_local20, f49_local3, CoD.BlackMarketTableUtility.ContractsTable.COL_SET)
			if f49_local14 == 0x0 then
				f49_local14 = nil
			end
			local f49_local15 = false
			local f49_local16 = LuaEnum.LOOT_TYPE.CONTRACT
			local f49_local17 = Engine[@"hash_4F9F1239CFD921FE"](CoD.ContractUtility.GetContractDisplayNameRef(f49_local19))
			local f49_local18 = ""
			if f49_local10 then
				if f49_local7 then
					f49_local18 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_5A936337A982BDDC", f49_local17)
				elseif f49_local9 then
					f49_local18 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_6E97EAE49F69F313", f49_local17)
				end
			elseif f49_local7 then
				f49_local18 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_35EC08751D141C3E", f49_local17)
			elseif f49_local9 then
				f49_local18 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_6E134BF93C2DE9B1", f49_local17)
			elseif f49_local14 then
				f49_local18 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_11CBBE54D06649B3", f49_local17)
			end
			return {
				rarity = f49_local4,
				isLoot = f49_local5,
				owned = f49_local7,
				available = f49_local9,
				inSet = f49_local14,
				setMaster = f49_local15,
				lootType = f49_local16,
				contractName = f49_local19,
				unlockInfo = f49_local18,
				forSale = f49_local11,
				itemId = f49_local6,
			}
		end
	end
	return nil
end
CoD.BlackMarketTableUtility.MasterSeasonTable = {}
CoD.BlackMarketTableUtility.MasterSeasonTable.name = 0xFE613834D811EC6
CoD.BlackMarketTableUtility.MasterSeasonTable.COL_ID = 0
CoD.BlackMarketTableUtility.MasterSeasonTable.COL_NAMEHASH = 1
CoD.BlackMarketTableUtility.SeasonsTable = {}
CoD.BlackMarketTableUtility.SeasonsTable.COL_TIER = 0
CoD.BlackMarketTableUtility.SeasonsTable.COL_ID = 1
CoD.BlackMarketTableUtility.SeasonsTable.COL_NAMEHASH = 2
CoD.BlackMarketTableUtility.SeasonsTable.COL_TYPE = 3
CoD.BlackMarketTableUtility.SeasonsTable.COL_RARITY = 4
CoD.BlackMarketTableUtility.SeasonsTable.COL_BUNDLE = 5
CoD.BlackMarketTableUtility.SeasonsTable.COL_SET = 6
CoD.BlackMarketTableUtility.SeasonsTable.COL_PROMOVIDEO = 7
CoD.BlackMarketTableUtility.SeasonsTable.COL_REFOPTIC = 8
CoD.BlackMarketTableUtility.SeasonsTable.COL_REFWEAPON = 9
CoD.BlackMarketTableUtility.SeasonsTable.COL_MPPRT = 10
CoD.BlackMarketTableUtility.SeasonsTable.COL_WZPRT = 11
CoD.BlackMarketTableUtility.SeasonsTable.COL_OUTFIT = 12
CoD.BlackMarketTableUtility.GetSeasonId = function(f50_arg0)
	local f50_local0 = Engine[@"trytablelookup"](CoD.BlackMarketTableUtility.MasterSeasonTable.name, CoD.BlackMarketTableUtility.MasterSeasonTable.COL_ID, CoD.BlackMarketTableUtility.MasterSeasonTable.COL_NAMEHASH, f50_arg0)
	if f50_local0 == nil then
		return "0"
	else
		return f50_local0
	end
end
CoD.BlackMarketTableUtility.GetSeasonInfo = function(f51_arg0)
	local f51_local0 = {
		id = f51_arg0,
		namehash = Engine[@"trytablelookup"](CoD.BlackMarketTableUtility.MasterSeasonTable.name, CoD.BlackMarketTableUtility.MasterSeasonTable.COL_NAMEHASH, CoD.BlackMarketTableUtility.MasterSeasonTable.COL_ID, f51_arg0),
	}
	if f51_local0.namehash == nil then
		return nil
	else
		return f51_local0
	end
end
CoD.BlackMarketTableUtility.GetSeasonItemsByTier = function(f52_arg0, f52_arg1, f52_arg2)
	local f52_local0 = {}
	local f52_local1 = CoD.BlackMarketTableUtility.GetSeasonInfo(f52_arg1)
	if f52_local1 == nil then
		return f52_local0
	elseif Engine[@"isdevelopmentbuild"]() then
		if CoD.BlackMarketUtility.FillContrabandDropNumber() > 0 then
			local f52_local2 = CoD.BlackMarketTableUtility.GetContrabandItemInfoByRowAndDropNumber(f52_arg0, f52_arg2, CoD.BlackMarketUtility.FillContrabandDropNumber())
			if f52_local2 ~= nil then
				table.insert(f52_local0, f52_local2)
			end
			return f52_local0
		elseif CoD.BlackMarketUtility.FillBackfill() then
			local f52_local2 = CoD.BlackMarketTableUtility.GetBackfillItemInfoByRow(f52_arg0, f52_arg2)
			if f52_local2 ~= nil then
				table.insert(f52_local0, f52_local2)
			end
			return f52_local0
		end
	end
	local f52_local2 = CoDShared.Loot.GetSeasonInfoParam(f52_local1.namehash, CoDShared.Loot.SEASON_INFO_TABLENAME)
	if f52_local2 ~= nil then
		local f52_local3 = Engine[@"tablefindrows"](f52_local2, CoD.BlackMarketTableUtility.SeasonsTable.COL_TIER, f52_arg2)
		if not IsBooleanDvarSet(@"hash_DDC9E66934FFDAB") and f52_arg2 <= (Engine[@"hash_6159D7050715A2C3"](f52_arg0, f52_local1.namehash) or 0) then
			local f52_local4 = Engine[@"hash_72D18261CB3AF850"](f52_arg0, f52_local1.namehash, f52_arg2)
			if f52_local4 ~= nil then
				for f52_local5 = 1, #f52_local4, 1 do
					if f52_local4[f52_local5].flags >= LuaEnum.LOOT_FLAGS.VALID then
						local f52_local8 = CoD.BlackMarketTableUtility.GetSeasonItemInfo(f52_arg0, f52_arg1, tostring(f52_local4[f52_local5].name))
						if f52_local8 == nil or f52_local8.name == 0x0 then
							if CoDShared.Loot.GetSeasonInfoParam(f52_local1.namehash, CoDShared.Loot.SEASON_INFO_NUMBER) >= 3 then
								f52_local8 = CoD.BlackMarketTableUtility.GetCaseItemInfo(f52_arg2, true)
							else
								f52_local8 = CoD.BlackMarketTableUtility.GetContrabandItemInfo(f52_arg0, tostring(f52_local4[f52_local5].name), f52_arg2)
							end
						end
						if f52_local8 ~= nil then
							if f52_local4[f52_local5].flags == LuaEnum.LOOT_FLAGS.DUPE then
								f52_local8.dupe = true
							elseif f52_local4[f52_local5].flags == LuaEnum.LOOT_FLAGS.REROLL then
								f52_local8.reroll = true
							end
							table.insert(f52_local0, f52_local8)
						end
					end
				end
			end
			return f52_local0
		elseif f52_local3 ~= nil then
			for f52_local9 = 1, #f52_local3, 1 do
				table.insert(f52_local0, CoD.BlackMarketTableUtility.GetSeasonItemInfo(f52_arg0, f52_arg1, Engine[@"hash_4C6F8EC444864600"](f52_local2, f52_local3[f52_local9], CoD.BlackMarketTableUtility.SeasonsTable.COL_ID)))
			end
		elseif CoDShared.Loot.GetSeasonInfoParam(f52_local1.namehash, CoDShared.Loot.SEASON_INFO_NUMBER) >= 3 then
			table.insert(f52_local0, CoD.BlackMarketTableUtility.GetCaseItemInfo(f52_arg2, true))
		else
			table.insert(f52_local0, CoD.BlackMarketTableUtility.GetEmptyContrabandItemInfo(f52_arg2, true))
		end
	end
	return f52_local0
end
CoD.BlackMarketTableUtility.GetEmptyContrabandItemInfo = function(f53_arg0, f53_arg1)
	local f53_local0 = ""
	if f53_arg1 and CoD.BlackMarketUtility.CanShowReservesPreview() then
		local f53_local1 = Engine[@"hash_2E00B2F29271C60B"](CoDShared.Loot.GetCurrentSeason())
		if not CoD.isPC or CoD.PCKoreaUtility.IsSeasonPromoVideoSafe() then
			local f53_local2 = f53_local1[0xC7AB2B58774379]
		end
		f53_local0 = f53_local2 or ""
	end
	return {
		itemId = "0",
		tier = f53_arg0,
		category = @"hash_0",
		rarity = @"hash_0",
		name = @"contraband",
		lootType = LuaEnum.LOOT_TYPE.EMPTY,
		movieName = f53_local0,
	}
end
CoD.BlackMarketTableUtility.GetCaseItemInfo = function(f54_arg0, f54_arg1)
	local f54_local0 = ""
	if f54_arg1 and CoD.BlackMarketUtility.CanShowReservesPreview() then
		local f54_local1 = Engine[@"hash_2E00B2F29271C60B"](CoDShared.Loot.GetCurrentSeason())
		if not CoD.isPC or CoD.PCKoreaUtility.IsSeasonPromoVideoSafe() then
			local f54_local2 = f54_local1[0xC7AB2B58774379]
		end
		f54_local0 = f54_local2 or ""
	end
	return {
		itemId = "0",
		tier = f54_arg0,
		category = @"hash_0",
		rarity = @"hash_0",
		name = @"case",
		lootType = LuaEnum.LOOT_TYPE.EMPTY,
		movieName = f54_local0,
	}
end
CoD.BlackMarketTableUtility.GetSeasonTableAndRowsForItemRef = function(f55_arg0, f55_arg1)
	for f55_local3, f55_local4 in pairs(CoDShared.Loot.SeasonParams) do
		local f55_local5 = CoDShared.Loot.GetSeasonInfoParam(f55_local3, CoDShared.Loot.SEASON_INFO_TABLENAME)
		local f55_local6 = Engine[@"tablefindrows"](f55_local5, CoD.BlackMarketTableUtility.SeasonsTable.COL_NAMEHASH, f55_arg1)
		if f55_local6 ~= nil and #f55_local6 > 0 then
			return f55_local5, f55_local6
		end
	end
	return nil, nil
end
CoD.BlackMarketTableUtility.GetSeasonWeaponRefName = function(f56_arg0, f56_arg1)
	local f56_local0, f56_local1 = CoD.BlackMarketTableUtility.GetSeasonTableAndRowsForItemRef(f56_arg0, f56_arg1)
	if f56_local0 ~= nil and f56_local1 ~= nil then
		return Engine[@"hash_4C6F8EC444864600"](f56_local0, f56_local1[1], CoD.BlackMarketTableUtility.SeasonsTable.COL_REFWEAPON)
	else
		return nil
	end
end
CoD.BlackMarketTableUtility.GetSeasonItemInfo = function(f57_arg0, f57_arg1, f57_arg2)
	local f57_local0 = nil
	local f57_local1 = CoD.BlackMarketTableUtility.GetSeasonInfo(f57_arg1)
	if f57_local1 == nil then
		return itemTable
	end
	local f57_local2 = CoDShared.Loot.GetSeasonInfoParam(f57_local1.namehash, CoDShared.Loot.SEASON_INFO_TABLENAME)
	if f57_local2 ~= nil then
		local f57_local3 = Engine[@"tablefindrows"](f57_local2, CoD.BlackMarketTableUtility.SeasonsTable.COL_NAMEHASH, Engine[@"hash_DE65B393F703EB1"](f57_local2, CoD.BlackMarketTableUtility.SeasonsTable.COL_ID, f57_arg2, CoD.BlackMarketTableUtility.SeasonsTable.COL_NAMEHASH))
		if f57_local3 ~= nil and #f57_local3 > 0 then
			local f57_local4 = f57_local3[1]
			f57_local0 = {
				itemId = f57_arg2,
				tier = Engine[@"hash_4C6F8EC444864600"](f57_local2, f57_local4, CoD.BlackMarketTableUtility.SeasonsTable.COL_TIER),
				name = Engine[@"hash_4C6F8EC444864600"](f57_local2, f57_local4, CoD.BlackMarketTableUtility.SeasonsTable.COL_NAMEHASH),
				rarity = Engine[@"hash_4C6F8EC444864600"](f57_local2, f57_local4, CoD.BlackMarketTableUtility.SeasonsTable.COL_RARITY),
				owned = Engine[@"hash_5352DC095BBB2A45"](f57_arg0, f57_arg2),
				inSet = Engine[@"hash_4C6F8EC444864600"](f57_local2, f57_local4, CoD.BlackMarketTableUtility.SeasonsTable.COL_SET),
				category = Engine[@"hash_4C6F8EC444864600"](f57_local2, f57_local4, CoD.BlackMarketTableUtility.SeasonsTable.COL_TYPE),
				movieName = Engine[@"hash_4C6F8EC444864600"](f57_local2, f57_local4, CoD.BlackMarketTableUtility.SeasonsTable.COL_PROMOVIDEO),
				lootType = LuaEnum.LOOT_TYPE.SEASON,
				refOptic = Engine[@"hash_4C6F8EC444864600"](f57_local2, f57_local4, CoD.BlackMarketTableUtility.SeasonsTable.COL_REFOPTIC),
				seasonId = f57_arg1,
			}
		end
	end
	return f57_local0
end
CoD.BlackMarketTableUtility.GetSeasonOutfitInformation = function(f58_arg0, f58_arg1)
	local f58_local0 = 0x0
	local f58_local1 = 0x0
	local f58_local2 = 0x0
	local f58_local3, f58_local4 = CoD.BlackMarketTableUtility.GetSeasonTableAndRowsForItemRef(f58_arg0, f58_arg1)
	if f58_local3 == nil or f58_local4 == nil then
		return {}
	end
	local f58_local5 = Engine[@"hash_4C6F8EC444864600"](f58_local3, f58_local4[1], CoD.BlackMarketTableUtility.SeasonsTable.COL_MPPRT)
	local f58_local6 = Enum[@"emodes"][@"mode_multiplayer"]
	if f58_local5 == 0x0 then
		f58_local5 = Engine[@"hash_4C6F8EC444864600"](f58_local3, f58_local4[1], CoD.BlackMarketTableUtility.SeasonsTable.COL_WZPRT)
		f58_local6 = Enum[@"emodes"][@"mode_warzone"]
		if f58_local5 == 0x0 then
			return {}
		end
	end
	local f58_local7 = Engine[@"hash_4C6F8EC444864600"](f58_local3, f58_local4[1], CoD.BlackMarketTableUtility.SeasonsTable.COL_OUTFIT)
	if f58_local7 == 0x0 then
		return {}
	end
	local f58_local8 = Engine[@"hash_4C6F8EC444864600"](f58_local3, f58_local4[1], CoD.BlackMarketTableUtility.SeasonsTable.COL_TYPE)
	local f58_local9 = Engine[@"hash_4C6F8EC444864600"](f58_local3, f58_local4[1], CoD.BlackMarketTableUtility.SeasonsTable.COL_NAMEHASH)
	local f58_local10 = Engine[0x422A503291AC81](f58_local8)
	if f58_local10 == Enum[@"characteritemtype"][@"hash_57852FCB3BFCC8D1"] then
		f58_local0 = f58_local9
	elseif f58_local10 == Enum[@"characteritemtype"][@"hash_4922FE5C41D9EE8B"] then
		f58_local1 = f58_local9
	elseif f58_local10 == Enum[@"characteritemtype"][@"hash_48E3A65D78229DC1"] then
		f58_local2 = f58_local9
	end
	return {
		prt = f58_local5,
		mode = f58_local6,
		outfit = f58_local7,
		decal = f58_local0,
		preset = f58_local1,
		war_paint = f58_local2,
	}
end
CoD.BlackMarketTableUtility.GetMyShopSeasonItemInfo = function(f59_arg0, f59_arg1)
	local f59_local0 = 1
	for f59_local4, f59_local5 in pairs(CoDShared.Loot.SeasonParams) do
		local f59_local6 = Engine[@"hash_DE65B393F703EB1"](CoDShared.Loot.GetSeasonInfoParam(f59_local4, CoDShared.Loot.SEASON_INFO_TABLENAME), CoD.BlackMarketTableUtility.SeasonsTable.COL_ID, f59_arg1, CoD.BlackMarketTableUtility.SeasonsTable.COL_NAMEHASH)
		if f59_local6 ~= nil and f59_local6 ~= 0x0 then
			return CoD.BlackMarketTableUtility.GetSeasonItemInfo(f59_arg0, CoD.BlackMarketTableUtility.GetSeasonId(f59_local4), f59_arg1)
		end
	end
	return nil
end
CoD.BlackMarketTableUtility.GetSeasonItemId = function(f60_arg0, f60_arg1)
	local f60_local0 = 1
	for f60_local6, f60_local7 in pairs(CoDShared.Loot.SeasonParams) do
		local f60_local8 = CoDShared.Loot.GetSeasonInfoParam(f60_local6, CoDShared.Loot.SEASON_INFO_TABLENAME)
		local f60_local9 = Engine[@"tablefindrows"](f60_local8, CoD.BlackMarketTableUtility.SeasonsTable.COL_NAMEHASH, f60_arg1)
		if f60_local9 ~= nil and #f60_local9 > 0 then
			local f60_local4 = f60_local9[1]
			local f60_local5 = CoD.BlackMarketTableUtility.GetSeasonId(f60_local6)
			return Engine[@"hash_4C6F8EC444864600"](f60_local8, f60_local4, CoD.BlackMarketTableUtility.SeasonsTable.COL_ID)
		end
	end
end
CoD.BlackMarketTableUtility.GetSeasonInfoForPlayer = function(f61_arg0, f61_arg1, f61_arg2, f61_arg3)
	local f61_local0 = CoDShared.Loot.GetCurrentSeason()
	for f61_local19, f61_local20 in pairs(CoDShared.Loot.SeasonParams) do
		if CoDShared.Loot.GetSeasonInfoParam(f61_local19, CoDShared.Loot.SEASON_INFO_NUMBER) == f61_arg2 then
			local f61_local4 = CoDShared.Loot.GetSeasonInfoParam(f61_local19, CoDShared.Loot.SEASON_INFO_TABLENAME)
			local f61_local5 = Engine[@"tablefindrows"](f61_local4, CoD.BlackMarketTableUtility.SeasonsTable.COL_NAMEHASH, f61_arg1)
			if f61_local5 ~= nil and #f61_local5 > 0 then
				local f61_local6 = f61_local5[1]
				local f61_local7 = Engine[@"hash_4C6F8EC444864600"](f61_local4, f61_local6, CoD.BlackMarketTableUtility.SeasonsTable.COL_RARITY)
				local f61_local8 = true
				local f61_local9 = Engine[@"hash_4C6F8EC444864600"](f61_local4, f61_local6, CoD.BlackMarketTableUtility.SeasonsTable.COL_ID)
				local f61_local10 = CoDShared.IsLootItemOwned(f61_arg0, f61_local9, f61_arg3)
				local f61_local11 = f61_local10 or f61_local19 == f61_local0
				local f61_local12 = CoD.BlackMarketTableUtility.GetInfoIfOnlyOwnedNonBaseWeapon(f61_arg0, f61_arg1, f61_local10, f61_local11, f61_arg3)
				if f61_local12 then
					return f61_local12
				end
				local f61_local13 = Engine[@"hash_4C6F8EC444864600"](f61_local4, f61_local6, CoD.BlackMarketTableUtility.SeasonsTable.COL_SET)
				if f61_local13 == 0x0 then
					f61_local13 = nil
				end
				local f61_local14 = false
				local f61_local15 = LuaEnum.LOOT_TYPE.SEASON
				local f61_local16 = Engine[@"hash_4C6F8EC444864600"](f61_local4, f61_local6, CoD.BlackMarketTableUtility.SeasonsTable.COL_TIER)
				local f61_local17 = Engine[@"hash_4F9F1239CFD921FE"](CoD.ContractUtility.GetContractDisplayNameRef(f61_local19))
				local f61_local18 = ""
				if f61_local10 then
					f61_local18 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_B6CD0A52CFF932D", f61_local17)
				elseif f61_local11 then
					f61_local18 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_5C67F56B74FB8566", f61_local16, f61_local17)
				elseif f61_local13 then
					f61_local18 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_1343848AFAEA372A", f61_local17)
				end
				return {
					rarity = f61_local7,
					isLoot = f61_local8,
					owned = f61_local10,
					available = f61_local11,
					inSet = f61_local13,
					setMaster = f61_local14,
					lootType = f61_local15,
					unlockTier = f61_local16,
					seasonIndex = f61_arg2,
					unlockInfo = f61_local18,
					itemId = f61_local9,
				}
			end
		end
	end
	return nil
end
CoD.BlackMarketTableUtility.GetStreamItemsByTier = function(f62_arg0, f62_arg1, f62_arg2)
	local f62_local0 = {}
	if CoD.BlackMarketTableUtility.GetSeasonInfo(f62_arg1) ~= nil then
		return CoD.BlackMarketTableUtility.GetSeasonItemsByTier(f62_arg0, f62_arg1, f62_arg2)
	elseif CoD.BlackMarketTableUtility.GetContractInfo(f62_arg1) ~= nil then
		return CoD.BlackMarketTableUtility.GetContractItemsByRelativeTier(f62_arg0, f62_arg1, f62_arg2)
	else
		return f62_local0
	end
end
CoD.BlackMarketTableUtility.ContrabandTable = {}
CoD.BlackMarketTableUtility.ContrabandTable.name = 0x42660E60408E67A
CoD.BlackMarketTableUtility.ContrabandTable.COL_ID = 0
CoD.BlackMarketTableUtility.ContrabandTable.COL_NAMEHASH = 1
CoD.BlackMarketTableUtility.ContrabandTable.COL_TYPE = 2
CoD.BlackMarketTableUtility.ContrabandTable.COL_RARITY = 3
CoD.BlackMarketTableUtility.ContrabandTable.COL_SET = 4
CoD.BlackMarketTableUtility.ContrabandTable.COL_MPPRT = 5
CoD.BlackMarketTableUtility.ContrabandTable.COL_WZPRT = 6
CoD.BlackMarketTableUtility.ContrabandTable.COL_OUTFIT = 7
CoD.BlackMarketTableUtility.ContrabandTable.COL_REFWEAPON = 8
CoD.BlackMarketTableUtility.ContrabandTable.COL_DROP = 9
CoD.BlackMarketTableUtility.ContrabandTable.COL_REFOPTIC = 10
CoD.BlackMarketTableUtility.ContrabandTable.COL_OPTIONALDATA = 11
CoD.BlackMarketTableUtility.ContrabandTable.COL_CP_SKU = 12
CoD.BlackMarketTableUtility.ContrabandTable.COL_CASE_RULE = 13
CoD.BlackMarketTableUtility.ContrabandTable.COL_NUMERATOR = 14
CoD.BlackMarketTableUtility.ContrabandTable.allContrabandItemsTable = nil
CoD.BlackMarketTableUtility.GetContrabandItemInfoByRowAndDropNumber = function(f63_arg0, f63_arg1, f63_arg2)
	local f63_local0 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.ContrabandTable.name, CoD.BlackMarketTableUtility.ContrabandTable.COL_DROP, f63_arg2)
	if f63_local0 ~= nil and #f63_local0 > 0 and f63_arg1 <= #f63_local0 then
		return CoD.BlackMarketTableUtility.GetContrabandItemInfo(f63_arg0, Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContrabandTable.name, f63_local0[f63_arg1], CoD.BlackMarketTableUtility.ContrabandTable.COL_ID), f63_arg1)
	else
		return {}
	end
end
CoD.BlackMarketTableUtility.GetContrabandWeaponRefName = function(f64_arg0, f64_arg1)
	return Engine[0x6ED59F41A5B1CC](CoD.BlackMarketTableUtility.ContrabandTable.name, CoD.BlackMarketTableUtility.ContrabandTable.COL_REFWEAPON, CoD.BlackMarketTableUtility.ContrabandTable.COL_ID, f64_arg1)
end
CoD.BlackMarketTableUtility.GetContrabandSingleCamoImageName = function(f65_arg0, f65_arg1)
	return Engine[0x6ED59F41A5B1CC](CoD.BlackMarketTableUtility.ContrabandTable.name, CoD.BlackMarketTableUtility.ContrabandTable.COL_OPTIONALDATA, CoD.BlackMarketTableUtility.ContrabandTable.COL_ID, f65_arg1)
end
CoD.BlackMarketTableUtility.GetContrabandXHashFromItemID = function(f66_arg0, f66_arg1)
	return Engine[@"hash_DE65B393F703EB1"](CoD.BlackMarketTableUtility.ContrabandTable.name, CoD.BlackMarketTableUtility.ContrabandTable.COL_ID, f66_arg1, CoD.BlackMarketTableUtility.ContrabandTable.COL_NAMEHASH)
end
CoD.BlackMarketTableUtility.GetContrabandItemInfo = function(f67_arg0, f67_arg1, f67_arg2)
	if f67_arg1 == nil then
		return {}
	end
	local f67_local0 = Engine[@"getdvarint"](@"hash_E137E1AD55735AC")
	if f67_local0 <= 0 then
		f67_local0 = CoD.BlackMarketTableUtility.DEFAULT_RNG_CP_PRICE
	end
	local f67_local1 = Engine[@"getdvarint"](@"hash_5300CE44B7FC7FF3")
	if f67_local1 <= 0 then
		f67_local1 = CoD.BlackMarketTableUtility.DEFAULT_RNG_CASE_PRICE
	end
	local f67_local2 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.ContrabandTable.name, CoD.BlackMarketTableUtility.ContrabandTable.COL_NAMEHASH, Engine[@"hash_DE65B393F703EB1"](CoD.BlackMarketTableUtility.ContrabandTable.name, CoD.BlackMarketTableUtility.ContrabandTable.COL_ID, f67_arg1, CoD.BlackMarketTableUtility.ContrabandTable.COL_NAMEHASH))
	local f67_local3 = nil
	if f67_local2 ~= nil then
		for f67_local7, f67_local8 in ipairs(f67_local2) do
			if Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContrabandTable.name, f67_local8, CoD.BlackMarketTableUtility.ContrabandTable.COL_ID) == f67_arg1 then
				return {
					itemId = f67_arg1,
					tier = f67_arg2,
					name = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContrabandTable.name, f67_local8, CoD.BlackMarketTableUtility.ContrabandTable.COL_NAMEHASH),
					rarity = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContrabandTable.name, f67_local8, CoD.BlackMarketTableUtility.ContrabandTable.COL_RARITY),
					owned = Engine[@"hash_5352DC095BBB2A45"](f67_arg0, f67_arg1),
					inSet = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContrabandTable.name, f67_local8, CoD.BlackMarketTableUtility.ContrabandTable.COL_SET),
					category = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContrabandTable.name, f67_local8, CoD.BlackMarketTableUtility.ContrabandTable.COL_TYPE),
					lootType = LuaEnum.LOOT_TYPE.CONTRABAND,
					refOptic = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContrabandTable.name, f67_local8, CoD.BlackMarketTableUtility.ContrabandTable.COL_REFOPTIC),
					optData = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContrabandTable.name, f67_local8, CoD.BlackMarketTableUtility.ContrabandTable.COL_OPTIONALDATA),
					cpPrice = f67_local0,
					cpSku = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContrabandTable.name, f67_local8, CoD.BlackMarketTableUtility.ContrabandTable.COL_CP_SKU),
					casePrice = f67_local1,
					caseRule = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContrabandTable.name, f67_local8, CoD.BlackMarketTableUtility.ContrabandTable.COL_CASE_RULE),
				}
			end
		end
	end
	return f67_local3
end
CoD.BlackMarketTableUtility.GetContrabandOutfitInformation = function(f68_arg0, f68_arg1)
	local f68_local0 = 0x0
	local f68_local1 = 0x0
	local f68_local2 = 0x0
	local f68_local3 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.ContrabandTable.name, CoD.BlackMarketTableUtility.ContrabandTable.COL_NAMEHASH, f68_arg1)
	if f68_local3 == nil then
		return {}
	end
	local f68_local4 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContrabandTable.name, f68_local3[1], CoD.BlackMarketTableUtility.ContrabandTable.COL_MPPRT)
	local f68_local5 = Enum[@"emodes"][@"mode_multiplayer"]
	if f68_local4 == 0x0 then
		f68_local4 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContrabandTable.name, f68_local3[1], CoD.BlackMarketTableUtility.ContrabandTable.COL_WZPRT)
		f68_local5 = Enum[@"emodes"][@"mode_warzone"]
		if f68_local4 == 0x0 then
			return {}
		end
	end
	local f68_local6 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContrabandTable.name, f68_local3[1], CoD.BlackMarketTableUtility.ContrabandTable.COL_OUTFIT)
	if f68_local6 == 0x0 then
		return {}
	end
	local f68_local7 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContrabandTable.name, f68_local3[1], CoD.BlackMarketTableUtility.ContrabandTable.COL_TYPE)
	local f68_local8 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContrabandTable.name, f68_local3[1], CoD.BlackMarketTableUtility.ContrabandTable.COL_NAMEHASH)
	local f68_local9 = Engine[0x422A503291AC81](f68_local7)
	if f68_local9 == Enum[@"characteritemtype"][@"hash_57852FCB3BFCC8D1"] then
		f68_local0 = f68_local8
	elseif f68_local9 == Enum[@"characteritemtype"][@"hash_4922FE5C41D9EE8B"] then
		f68_local1 = f68_local8
	elseif f68_local9 == Enum[@"characteritemtype"][@"hash_48E3A65D78229DC1"] then
		f68_local2 = f68_local8
	end
	return {
		prt = f68_local4,
		mode = f68_local5,
		outfit = f68_local6,
		decal = f68_local0,
		preset = f68_local1,
		war_paint = f68_local2,
	}
end
CoD.BlackMarketTableUtility.IsAllContrabandOwnedTest = function()
	return CoD.BlackMarketTableUtility.IsAllContrabandOwned(0)
end
CoD.BlackMarketTableUtility.IsAllContrabandOwned = function(f70_arg0)
	return CoDShared.Loot.RNGPercentUnlocked(f70_arg0, CoDShared.Loot.GetCurrentSeason(), true) == 1
end
CoD.BlackMarketTableUtility.GetContrabandInfoForPlayer = function(f71_arg0, f71_arg1, f71_arg2, f71_arg3)
	local f71_local0 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.ContrabandTable.name, CoD.BlackMarketTableUtility.ContrabandTable.COL_NAMEHASH, f71_arg1)
	if f71_local0 ~= nil then
		local f71_local1 = CoD.BlackMarketTableUtility.FindCorrectRow(f71_local0, CoD.BlackMarketTableUtility.ContrabandTable.name, f71_arg3, CoD.BlackMarketTableUtility.ContrabandTable.COL_REFWEAPON)
		if f71_local1 then
			local f71_local2 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContrabandTable.name, f71_local1, CoD.BlackMarketTableUtility.ContrabandTable.COL_RARITY)
			local f71_local3 = true
			local f71_local4 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContrabandTable.name, f71_local1, CoD.BlackMarketTableUtility.ContrabandTable.COL_ID)
			local f71_local5 = CoDShared.IsLootItemOwned(f71_arg0, f71_local4, f71_arg2)
			local f71_local6 = f71_local5
			local f71_local7 = CoD.BlackMarketTableUtility.GetInfoIfOnlyOwnedNonBaseWeapon(f71_arg0, f71_arg1, f71_local5, f71_local6, f71_arg2)
			if f71_local7 then
				return f71_local7
			end
			local f71_local8 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContrabandTable.name, f71_local1, CoD.BlackMarketTableUtility.ContrabandTable.COL_SET)
			if f71_local8 == 0x0 then
				f71_local8 = nil
			end
			local f71_local9 = false
			local f71_local10 = LuaEnum.LOOT_TYPE.CONTRABAND
			local f71_local11 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_444870138E328735")
			if not f71_local6 then
				f71_local11 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_282246B89B2146A0")
			end
			return {
				rarity = f71_local2,
				isLoot = f71_local3,
				owned = f71_local5,
				available = f71_local6,
				inSet = f71_local8,
				setMaster = f71_local9,
				lootType = f71_local10,
				unlockInfo = f71_local11,
				itemId = f71_local4,
			}
		end
	end
	return nil
end
CoD.BlackMarketTableUtility.GetAllContrabandItem = function(f72_arg0, f72_arg1)
	if not f72_arg1 and CoD.BlackMarketTableUtility.ContrabandTable.allContrabandItemsTable then
		return CoD.BlackMarketTableUtility.ContrabandTable.allContrabandItemsTable
	end
	local f72_local0 = {}
	local f72_local1 = Engine[@"gettablerowcount"](CoD.BlackMarketTableUtility.ContrabandTable.name)
	for f72_local2 = 1, f72_local1, 1 do
		local f72_local5 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContrabandTable.name, f72_local2, CoD.BlackMarketTableUtility.ContrabandTable.COL_ID)
		local f72_local6 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContrabandTable.name, f72_local2, CoD.BlackMarketTableUtility.ContrabandTable.COL_NAMEHASH)
		if f72_local5 and f72_local6 then
			table.insert(f72_local0, {
				itemId = f72_local5,
				name = f72_local6,
				weight = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContrabandTable.name, f72_local2, CoD.BlackMarketTableUtility.ContrabandTable.COL_NUMERATOR),
			})
		end
	end
	CoD.BlackMarketTableUtility.ContrabandTable.allContrabandItemsTable = f72_local0
	return f72_local0
end
CoD.BlackMarketTableUtility.BundleTable = {}
CoD.BlackMarketTableUtility.BundleTable.name = @"hash_233FC487684E8C69"
CoD.BlackMarketTableUtility.BundleTable.COL_BUNDLE = 0
CoD.BlackMarketTableUtility.BundleTable.COL_NAMEHASH = 1
CoD.BlackMarketTableUtility.BundleTable.COL_TYPE = 2
CoD.BlackMarketTableUtility.BundleTable.COL_CHARACTER = 3
CoD.BlackMarketTableUtility.BundleTable.COL_MPPRT = 4
CoD.BlackMarketTableUtility.BundleTable.COL_WZPRT = 5
CoD.BlackMarketTableUtility.BundleTable.COL_OUTFIT = 6
CoD.BlackMarketTableUtility.BundleTable.COL_SET = 7
CoD.BlackMarketTableUtility.BundleTable.COL_RARITY = 8
CoD.BlackMarketTableUtility.BundleTable.COL_REFOPTIC = 9
CoD.BlackMarketTableUtility.BundleTable.COL_REFWEAPON = 10
CoD.BlackMarketTableUtility.BundleTable.COL_KEYITEM = 11
CoD.BlackMarketTableUtility.IsItemLootBundle = function(f73_arg0, f73_arg1)
	local f73_local0 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.BundleTable.name, CoD.BlackMarketTableUtility.BundleTable.COL_BUNDLE, f73_arg1)
	if f73_local0 and #f73_local0 > 0 then
		return true
	else
		return false
	end
end
CoD.BlackMarketTableUtility.AreAllBundleKeyItemsOwned = function(f74_arg0, f74_arg1)
	local f74_local0 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.BundleTable.name, CoD.BlackMarketTableUtility.BundleTable.COL_BUNDLE, f74_arg1)
	if f74_local0 == nil then
		return false
	end
	local f74_local1 = 0
	local f74_local2 = 0
	for f74_local3 = 1, #f74_local0, 1 do
		local f74_local6 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BundleTable.name, f74_local0[f74_local3], CoD.BlackMarketTableUtility.BundleTable.COL_NAMEHASH)
		if f74_local6 and Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BundleTable.name, f74_local0[f74_local3], CoD.BlackMarketTableUtility.BundleTable.COL_KEYITEM) then
			f74_local1 = f74_local1 + 1
			if CoDShared.IsLootItemOwnedByName(f74_arg0, f74_local6) then
				f74_local2 = f74_local2 + 1
			end
		end
	end
	if f74_local1 <= 0 or f74_local1 ~= f74_local2 then
		f74_local3 = false
	else
		local f74_local3 = true
	end
	return f74_local3
end
CoD.BlackMarketTableUtility.GetBundleWeaponRefName = function(f75_arg0, f75_arg1)
	return Engine[0x6ED59F41A5B1CC](CoD.BlackMarketTableUtility.BundleTable.name, CoD.BlackMarketTableUtility.BundleTable.COL_REFWEAPON, CoD.BlackMarketTableUtility.BundleTable.COL_NAMEHASH, f75_arg1)
end
CoD.BlackMarketTableUtility.GetBundleItemInformation = function(f76_arg0, f76_arg1, f76_arg2)
	if f76_arg1 == nil then
		return {}
	end
	local f76_local0 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.BundleTable.name, CoD.BlackMarketTableUtility.BundleTable.COL_NAMEHASH, f76_arg1)
	local f76_local1 = nil
	if f76_local0 ~= nil then
		for f76_local6, f76_local7 in ipairs(f76_local0) do
			local f76_local8 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BundleTable.name, f76_local7, CoD.BlackMarketTableUtility.BundleTable.COL_TYPE)
			if f76_local8 == f76_arg2 then
				local f76_local5 = f76_local0[1]
				return {
					name = f76_arg1,
					rarity = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BundleTable.name, f76_local5, CoD.BlackMarketTableUtility.BundleTable.COL_RARITY),
					inSet = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BundleTable.name, f76_local5, CoD.BlackMarketTableUtility.BundleTable.COL_SET),
					category = f76_local8,
					lootType = LuaEnum.LOOT_TYPE.BUNDLE,
					refOptic = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BundleTable.name, f76_local5, CoD.BlackMarketTableUtility.BundleTable.COL_REFOPTIC),
				}
			end
		end
	end
	return f76_local1
end
CoD.BlackMarketTableUtility.GetBundlePiecesInformation = function(f77_arg0, f77_arg1)
	local f77_local0 = {}
	local f77_local1 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.BundleTable.name, CoD.BlackMarketTableUtility.BundleTable.COL_BUNDLE, f77_arg1)
	if f77_local1 == nil then
		return f77_local0
	end
	table.sort(f77_local1)
	for f77_local2 = 1, #f77_local1, 1 do
		local f77_local5 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BundleTable.name, f77_local1[f77_local2], CoD.BlackMarketTableUtility.BundleTable.COL_NAMEHASH)
		local f77_local6 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BundleTable.name, f77_local1[f77_local2], CoD.BlackMarketTableUtility.BundleTable.COL_TYPE)
		if f77_local5 ~= 0x0 and f77_local6 ~= 0x0 then
			table.insert(f77_local0, CoD.BlackMarketTableUtility.GetBundleItemInformation(f77_arg0, f77_local5, f77_local6))
		end
	end
	return f77_local0
end
CoD.BlackMarketTableUtility.GetBundleOutfitInformation = function(f78_arg0, f78_arg1)
	local f78_local0 = 0x0
	local f78_local1 = 0x0
	local f78_local2 = 0x0
	local f78_local3 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.BundleTable.name, CoD.BlackMarketTableUtility.BundleTable.COL_NAMEHASH, f78_arg1)
	if f78_local3 == nil then
		return {}
	end
	local f78_local4 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BundleTable.name, f78_local3[1], CoD.BlackMarketTableUtility.BundleTable.COL_MPPRT)
	local f78_local5 = Enum[@"emodes"][@"mode_multiplayer"]
	if f78_local4 == 0x0 then
		f78_local4 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BundleTable.name, f78_local3[1], CoD.BlackMarketTableUtility.BundleTable.COL_WZPRT)
		f78_local5 = Enum[@"emodes"][@"mode_warzone"]
		if f78_local4 == 0x0 then
			return {}
		end
	end
	local f78_local6 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BundleTable.name, f78_local3[1], CoD.BlackMarketTableUtility.BundleTable.COL_OUTFIT)
	if f78_local6 == 0x0 then
		return {}
	end
	local f78_local7 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BundleTable.name, f78_local3[1], CoD.BlackMarketTableUtility.BundleTable.COL_TYPE)
	local f78_local8 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BundleTable.name, f78_local3[1], CoD.BlackMarketTableUtility.BundleTable.COL_NAMEHASH)
	local f78_local9 = Engine[0x422A503291AC81](f78_local7)
	if f78_local9 == Enum[@"characteritemtype"][@"hash_57852FCB3BFCC8D1"] then
		f78_local0 = f78_local8
	elseif f78_local9 == Enum[@"characteritemtype"][@"hash_4922FE5C41D9EE8B"] then
		f78_local1 = f78_local8
	elseif f78_local9 == Enum[@"characteritemtype"][@"hash_48E3A65D78229DC1"] then
		f78_local2 = f78_local8
	end
	return {
		prt = f78_local4,
		mode = f78_local5,
		outfit = f78_local6,
		decal = f78_local0,
		preset = f78_local1,
		war_paint = f78_local2,
	}
end
CoD.BlackMarketTableUtility.GetOutfitBundleInformation = function(f79_arg0, f79_arg1)
	local f79_local0 = {}
	local f79_local1 = 0x0
	local f79_local2 = 0x0
	local f79_local3 = 0x0
	local f79_local4 = 0x0
	local f79_local5 = 0x0
	local f79_local6 = CoD.BlackMarketUtility.GetBundleKeyItemRef(f79_arg0, f79_arg1, @"palette")
	if not f79_local6 then
		return f79_local0
	end
	local f79_local7 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.BundleTable.name, CoD.BlackMarketTableUtility.BundleTable.COL_BUNDLE, f79_arg1)
	local f79_local8 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.BundleTable.name, CoD.BlackMarketTableUtility.BundleTable.COL_NAMEHASH, f79_local6.name)
	if f79_local7 == nil or f79_local8 == nil then
		return f79_local0
	end
	local f79_local9 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BundleTable.name, f79_local8[1], CoD.BlackMarketTableUtility.BundleTable.COL_MPPRT)
	local f79_local10 = Enum[@"emodes"][@"mode_multiplayer"]
	if f79_local9 == "" then
		f79_local9 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BundleTable.name, f79_local8[1], CoD.BlackMarketTableUtility.BundleTable.COL_WZPRT)
		f79_local10 = Enum[@"emodes"][@"mode_warzone"]
		if f79_local9 == "" then
			return f79_local0
		end
	end
	local f79_local11 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BundleTable.name, f79_local8[1], CoD.BlackMarketTableUtility.BundleTable.COL_OUTFIT)
	if f79_local11 == "" then
		return f79_local0
	end
	for f79_local12 = 1, #f79_local7, 1 do
		local f79_local15 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BundleTable.name, f79_local7[f79_local12], CoD.BlackMarketTableUtility.BundleTable.COL_TYPE)
		local f79_local16 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BundleTable.name, f79_local7[f79_local12], CoD.BlackMarketTableUtility.BundleTable.COL_NAMEHASH)
		local f79_local17 = Engine[0x422A503291AC81](f79_local15)
		if f79_local17 == Enum[@"characteritemtype"][@"hash_57852FCB3BFCC8D1"] then
			f79_local3 = f79_local16
		end
		if f79_local17 == Enum[@"characteritemtype"][@"hash_4922FE5C41D9EE8B"] then
			f79_local4 = f79_local16
		end
		if f79_local17 == Enum[@"characteritemtype"][@"hash_48E3A65D78229DC1"] then
			f79_local5 = f79_local16
		end
	end
	f79_local0.prt = f79_local9
	f79_local0.mode = f79_local10
	f79_local0.outfit = f79_local11
	f79_local0.decal = f79_local3
	f79_local0.preset = f79_local4
	f79_local0.war_paint = f79_local5
	return f79_local0
end
CoD.BlackMarketTableUtility.GetOutfitItemBundleInformation = function(f80_arg0, f80_arg1)
	local f80_local0 = {}
	local f80_local1 = 0x0
	local f80_local2 = 0x0
	local f80_local3 = 0x0
	local f80_local4 = 0x0
	local f80_local5 = 0x0
	local f80_local6 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.BundleTable.name, CoD.BlackMarketTableUtility.BundleTable.COL_BUNDLE, f80_arg1)
	if f80_local6 == nil then
		return f80_local0
	end
	local f80_local7 = 1
	for f80_local8 = 1, #f80_local6, 1 do
		if Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BundleTable.name, f80_local6[f80_local8], CoD.BlackMarketTableUtility.BundleTable.COL_CHARACTER) == @"ruin" then
			f80_local7 = f80_local8
			break
		end
	end
	f80_local1 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BundleTable.name, f80_local6[f80_local7], CoD.BlackMarketTableUtility.BundleTable.COL_MPPRT)
	local f80_local8 = Enum[@"emodes"][@"mode_multiplayer"]
	if f80_local1 == 0x0 then
		f80_local1 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BundleTable.name, f80_local6[f80_local7], CoD.BlackMarketTableUtility.BundleTable.COL_WZPRT)
		f80_local8 = Enum[@"emodes"][@"mode_warzone"]
		if f80_local1 == 0x0 then
			return f80_local0
		end
	end
	f80_local2 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BundleTable.name, f80_local6[f80_local7], CoD.BlackMarketTableUtility.BundleTable.COL_OUTFIT)
	if f80_local2 == 0x0 then
		return f80_local0
	end
	local f80_local9 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BundleTable.name, f80_local6[f80_local7], CoD.BlackMarketTableUtility.BundleTable.COL_TYPE)
	local f80_local10 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BundleTable.name, f80_local6[f80_local7], CoD.BlackMarketTableUtility.BundleTable.COL_NAMEHASH)
	local f80_local11 = Engine[0x422A503291AC81](f80_local9)
	if f80_local11 == Enum[@"characteritemtype"][@"hash_57852FCB3BFCC8D1"] then
		f80_local3 = f80_local10
	elseif f80_local11 == Enum[@"characteritemtype"][@"hash_4922FE5C41D9EE8B"] then
		f80_local4 = f80_local10
	elseif f80_local11 == Enum[@"characteritemtype"][@"hash_48E3A65D78229DC1"] then
		f80_local5 = f80_local10
	end
	f80_local0.prt = f80_local1
	f80_local0.mode = f80_local8
	f80_local0.outfit = f80_local2
	f80_local0.decal = f80_local3
	f80_local0.preset = f80_local4
	f80_local0.war_paint = f80_local5
	return f80_local0
end
CoD.BlackMarketTableUtility.BundleIncludesTiers = function(f81_arg0, f81_arg1)
	local f81_local0 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.BundleTable.name, CoD.BlackMarketTableUtility.BundleTable.COL_BUNDLE, f81_arg1)
	if f81_local0 and #f81_local0 > 0 then
		for f81_local1 = 1, #f81_local0, 1 do
			if Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BundleTable.name, f81_local0[f81_local1], CoD.BlackMarketTableUtility.BundleTable.COL_TYPE) == @"tiers" then
				return true
			end
		end
	end
	return false
end
CoD.BlackMarketTableUtility.GetBundleItemInfoForPlayer = function(f82_arg0, f82_arg1)
	local f82_local0 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.BundleTable.name, CoD.BlackMarketTableUtility.BundleTable.COL_NAMEHASH, f82_arg1)
	local f82_local1 = nil
	if f82_local0 ~= nil and #f82_local0 > 0 then
		for f82_local5, f82_local6 in ipairs(f82_local0) do
			local f82_local7 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BundleTable.name, f82_local6, CoD.BlackMarketTableUtility.BundleTable.COL_BUNDLE)
			if f82_local7 then
				f82_local1 = CoD.BlackMarketTableUtility.LootInfoLookup(f82_arg0, f82_local7)
				if f82_arg1 ~= f82_local7 then
					f82_local1.rarity = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BundleTable.name, f82_local6, CoD.BlackMarketTableUtility.BundleTable.COL_RARITY)
				end
				if f82_local1 and f82_local1.owned == true then
					return f82_local1
				end
			end
		end
	end
	return f82_local1
end
CoD.BlackMarketTableUtility.ItemShopTable = {}
CoD.BlackMarketTableUtility.ItemShopTable.name = @"hash_32F6538EA0AF7458"
CoD.BlackMarketTableUtility.ItemShopTable.COL_ID = 0
CoD.BlackMarketTableUtility.ItemShopTable.COL_NAMEHASH = 1
CoD.BlackMarketTableUtility.ItemShopTable.COL_TYPE = 2
CoD.BlackMarketTableUtility.ItemShopTable.COL_RARITY = 3
CoD.BlackMarketTableUtility.ItemShopTable.COL_SET = 4
CoD.BlackMarketTableUtility.ItemShopTable.COL_MPPRT = 5
CoD.BlackMarketTableUtility.ItemShopTable.COL_WZPRT = 6
CoD.BlackMarketTableUtility.ItemShopTable.COL_OUTFIT = 7
CoD.BlackMarketTableUtility.ItemShopTable.COL_REFWEAPON = 8
CoD.BlackMarketTableUtility.ItemShopTable.COL_DROP = 9
CoD.BlackMarketTableUtility.ItemShopTable.COL_PRICE = 10
CoD.BlackMarketTableUtility.ItemShopTable.COL_KOREAEXCLUDED = 11
CoD.BlackMarketTableUtility.ItemShopTable.COL_REFOPTIC = 12
CoD.BlackMarketTableUtility.ItemShopTable.COL_DISCOUNTSKUID = 13
CoD.BlackMarketTableUtility.ItemShopTable.COL_DISCOUNTPRICE = 14
CoD.BlackMarketTableUtility.ItemShopTable.COL_PROMOVIDEO = 15
CoD.BlackMarketTableUtility.GetItemShopWeaponRefName = function(f83_arg0, f83_arg1)
	local f83_local0 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.ItemShopTable.name, CoD.BlackMarketTableUtility.ItemShopTable.COL_NAMEHASH, f83_arg1)
	if f83_local0 ~= nil then
		return Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ItemShopTable.name, f83_local0[1], CoD.BlackMarketTableUtility.ItemShopTable.COL_REFWEAPON)
	else
		return nil
	end
end
CoD.BlackMarketTableUtility.GetItemShopOutfitInformation = function(f84_arg0, f84_arg1)
	local f84_local0 = 0x0
	local f84_local1 = 0x0
	local f84_local2 = 0x0
	local f84_local3 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.ItemShopTable.name, CoD.BlackMarketTableUtility.ItemShopTable.COL_NAMEHASH, f84_arg1)
	if f84_local3 == nil then
		return {}
	end
	local f84_local4 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ItemShopTable.name, f84_local3[1], CoD.BlackMarketTableUtility.ItemShopTable.COL_MPPRT)
	local f84_local5 = Enum[@"emodes"][@"mode_multiplayer"]
	if f84_local4 == 0x0 then
		f84_local4 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ItemShopTable.name, f84_local3[1], CoD.BlackMarketTableUtility.ItemShopTable.COL_WZPRT)
		f84_local5 = Enum[@"emodes"][@"mode_warzone"]
		if f84_local4 == 0x0 then
			return {}
		end
	end
	local f84_local6 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ItemShopTable.name, f84_local3[1], CoD.BlackMarketTableUtility.ItemShopTable.COL_OUTFIT)
	if f84_local6 == 0x0 then
		return {}
	end
	local f84_local7 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ItemShopTable.name, f84_local3[1], CoD.BlackMarketTableUtility.ItemShopTable.COL_TYPE)
	local f84_local8 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ItemShopTable.name, f84_local3[1], CoD.BlackMarketTableUtility.ItemShopTable.COL_NAMEHASH)
	local f84_local9 = Engine[0x422A503291AC81](f84_local7)
	if f84_local9 == Enum[@"characteritemtype"][@"hash_57852FCB3BFCC8D1"] then
		f84_local0 = f84_local8
	elseif f84_local9 == Enum[@"characteritemtype"][@"hash_4922FE5C41D9EE8B"] then
		f84_local1 = f84_local8
	elseif f84_local9 == Enum[@"characteritemtype"][@"hash_48E3A65D78229DC1"] then
		f84_local2 = f84_local8
	end
	return {
		prt = f84_local4,
		mode = f84_local5,
		outfit = f84_local6,
		decal = f84_local0,
		preset = f84_local1,
		war_paint = f84_local2,
	}
end
CoD.BlackMarketTableUtility.GetItemShopEntryName = function(f85_arg0, f85_arg1)
	return Engine[@"hash_DE65B393F703EB1"](CoD.BlackMarketTableUtility.ItemShopTable.name, CoD.BlackMarketTableUtility.ItemShopTable.COL_ID, f85_arg1, CoD.BlackMarketTableUtility.ItemShopTable.COL_NAMEHASH)
end
CoD.BlackMarketTableUtility.GetItemShopEntryId = function(f86_arg0, f86_arg1)
	local f86_local0 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.ItemShopTable.name, CoD.BlackMarketTableUtility.ItemShopTable.COL_NAMEHASH, f86_arg1)
	if f86_local0 == nil then
		return nil
	elseif #f86_local0 > 0 then
		return Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ItemShopTable.name, f86_local0[1], CoD.BlackMarketTableUtility.ItemShopTable.COL_ID)
	else
		return nil
	end
end
CoD.BlackMarketTableUtility.GetItemShopInfoById = function(f87_arg0, f87_arg1)
	local f87_local0 = CoD.BlackMarketTableUtility.GetItemShopEntryName(f87_arg0, f87_arg1)
	if f87_local0 then
		return CoD.BlackMarketTableUtility.GetItemShopInformation(f87_arg0, f87_local0)
	else
		return nil
	end
end
CoD.BlackMarketTableUtility.GetItemShopInformation = function(f88_arg0, f88_arg1)
	local f88_local0 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.ItemShopTable.name, CoD.BlackMarketTableUtility.ItemShopTable.COL_NAMEHASH, f88_arg1)
	if f88_local0 == nil then
		return nil
	end
	local f88_local1 = nil
	if #f88_local0 > 0 then
		local f88_local2 = f88_local0[1]
		f88_local1 = {
			itemId = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ItemShopTable.name, f88_local2, CoD.BlackMarketTableUtility.ItemShopTable.COL_ID),
			name = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ItemShopTable.name, f88_local2, CoD.BlackMarketTableUtility.ItemShopTable.COL_NAMEHASH),
			rarity = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ItemShopTable.name, f88_local2, CoD.BlackMarketTableUtility.ItemShopTable.COL_RARITY),
			owned = Engine[@"hash_5352DC095BBB2A45"](f88_arg0, f88_local1.itemId),
			inSet = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ItemShopTable.name, f88_local2, CoD.BlackMarketTableUtility.ItemShopTable.COL_SET),
			category = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ItemShopTable.name, f88_local2, CoD.BlackMarketTableUtility.ItemShopTable.COL_TYPE),
			lootType = LuaEnum.LOOT_TYPE.ITEMSHOP,
			price = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ItemShopTable.name, f88_local2, CoD.BlackMarketTableUtility.ItemShopTable.COL_PRICE),
			koreaExcluded = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ItemShopTable.name, f88_local2, CoD.BlackMarketTableUtility.ItemShopTable.COL_KOREAEXCLUDED),
			refOptic = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ItemShopTable.name, f88_local2, CoD.BlackMarketTableUtility.ItemShopTable.COL_REFOPTIC),
			discountSkuId = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ItemShopTable.name, f88_local2, CoD.BlackMarketTableUtility.ItemShopTable.COL_DISCOUNTSKUID),
			discountPrice = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ItemShopTable.name, f88_local2, CoD.BlackMarketTableUtility.ItemShopTable.COL_DISCOUNTPRICE),
			movieName = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ItemShopTable.name, f88_local2, CoD.BlackMarketTableUtility.ItemShopTable.COL_PROMOVIDEO),
		}
	end
	return f88_local1
end
CoD.BlackMarketTableUtility.GetItemShopInfoForPlayer = function(f89_arg0, f89_arg1, f89_arg2)
	local f89_local0 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.ItemShopTable.name, CoD.BlackMarketTableUtility.ItemShopTable.COL_NAMEHASH, f89_arg1)
	if f89_local0 ~= nil and #f89_local0 > 0 then
		local f89_local1 = f89_local0[1]
		local f89_local2 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ItemShopTable.name, f89_local1, CoD.BlackMarketTableUtility.ItemShopTable.COL_RARITY)
		local f89_local3 = true
		local f89_local4 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ItemShopTable.name, f89_local1, CoD.BlackMarketTableUtility.ItemShopTable.COL_ID)
		local f89_local5 = CoDShared.IsLootItemOwned(f89_arg0, f89_local4, f89_arg2)
		local f89_local6 = f89_local5
		local f89_local7 = false
		for f89_local8 = 1, CoD.BlackMarketUtility.ItemShopSlots, 1 do
			if Engine[@"converttoxhash"](Engine[@"getdvarstring"]("loot_itemshop_slot" .. f89_local8 .. "_item")) == f89_arg1 then
				f89_local7 = true
				break
			end
		end
		local f89_local8 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ItemShopTable.name, f89_local1, CoD.BlackMarketTableUtility.ItemShopTable.COL_SET)
		if f89_local8 == 0x0 then
			f89_local8 = nil
		end
		local f89_local9 = false
		local f89_local10 = LuaEnum.LOOT_TYPE.ITEMSHOP
		local f89_local11 = ""
		if f89_local5 then
			f89_local11 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_270635062A0697A0")
		elseif f89_local8 then
			f89_local11 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_570B5D696F9C3EC5")
		end
		return {
			rarity = f89_local2,
			isLoot = f89_local3,
			owned = f89_local5,
			available = f89_local6,
			inSet = f89_local8,
			setMaster = f89_local9,
			lootType = f89_local10,
			unlockInfo = f89_local11,
			forSale = f89_local7,
			itemId = f89_local4,
		}
	else
		return nil
	end
end
CoD.BlackMarketTableUtility.LootBonusTable = {}
CoD.BlackMarketTableUtility.LootBonusTable.name = 0x30CAA8686798E2B
CoD.BlackMarketTableUtility.LootBonusTable.COL_NAMEHASH = 0
CoD.BlackMarketTableUtility.LootBonusTable.COL_TYPE = 1
CoD.BlackMarketTableUtility.LootBonusTable.COL_SET = 2
CoD.BlackMarketTableUtility.LootBonusTable.COL_MINIMUMTARGET = 3
CoD.BlackMarketTableUtility.LootBonusTable.COL_TOTAL = 4
CoD.BlackMarketTableUtility.LootBonusTable.COL_STRINGREF = 5
CoD.BlackMarketTableUtility.LootBonusTable.COL_RARITY = 6
CoD.BlackMarketTableUtility.IsLootBonusMasterUnlocked = function(f90_arg0, f90_arg1)
	local f90_local0 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.LootBonusTable.name, CoD.BlackMarketTableUtility.LootBonusTable.COL_NAMEHASH, f90_arg1)
	if f90_local0 ~= nil and #f90_local0 > 0 then
		return CoD.BlackMarketTableUtility.IsBonusSetUnlocked(f90_arg0, Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.LootBonusTable.name, f90_local0[1], CoD.BlackMarketTableUtility.LootBonusTable.COL_SET))
	else
		return false
	end
end
CoD.BlackMarketTableUtility.GetBonusItemInfoForPlayer = function(f91_arg0, f91_arg1)
	local f91_local0 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.LootBonusTable.name, CoD.BlackMarketTableUtility.LootBonusTable.COL_NAMEHASH, f91_arg1)
	if f91_local0 ~= nil and #f91_local0 > 0 then
		local f91_local1 = f91_local0[1]
		local f91_local2 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.LootBonusTable.name, f91_local1, CoD.BlackMarketTableUtility.LootBonusTable.COL_RARITY)
		local f91_local3 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.LootBonusTable.name, f91_local1, CoD.BlackMarketTableUtility.LootBonusTable.COL_TYPE)
		local f91_local4 = true
		local f91_local5 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.LootBonusTable.name, f91_local1, CoD.BlackMarketTableUtility.LootBonusTable.COL_SET)
		if f91_local5 == 0x0 then
			f91_local5 = nil
		end
		local f91_local6, f91_local7 = CoD.BlackMarketTableUtility.GetBonusSetUnlockedAvailableStates(f91_arg0, f91_local5)
		return {
			rarity = f91_local2,
			isLoot = f91_local4,
			owned = f91_local6,
			available = f91_local7,
			inSet = f91_local5,
			setMaster = true,
			lootType = LuaEnum.LOOT_TYPE.SETBONUS,
			unlockInfo = "",
		}
	else
		return nil
	end
end
CoD.BlackMarketTableUtility.IsContractOwned = function(f92_arg0, f92_arg1)
	if CoD.BlackMarketUtility.IsEventActive() and CoD.BlackMarketUtility.GetEventName() == f92_arg1 then
		return true
	end
	local f92_local0 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.MasterContractTable.name, CoD.BlackMarketTableUtility.MasterContractTable.COL_NAMEHASH, f92_arg1)
	if f92_local0 ~= nil and #f92_local0 > 0 then
		local f92_local1 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.MasterContractTable.name, f92_local0[1], CoD.BlackMarketTableUtility.MasterContractTable.COL_ID)
		if f92_local1 ~= nil and f92_local1 ~= "" then
			return Engine[@"hash_34509DFCBC7BC5CE"](f92_arg0, f92_local1) > 0
		end
	end
	return false
end
CoD.BlackMarketTableUtility.IsEventContract = function(f93_arg0)
	if Engine[@"trytablelookup"](CoD.BlackMarketTableUtility.MasterContractTable.name, CoD.BlackMarketTableUtility.MasterContractTable.COL_TYPE, CoD.BlackMarketTableUtility.MasterContractTable.COL_NAMEHASH, f93_arg0) == @"event" then
		return true
	else
		return false
	end
end
CoD.BlackMarketTableUtility.GetBonusSetMasterNameHash = function(f94_arg0)
	local f94_local0 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.LootBonusTable.name, CoD.BlackMarketTableUtility.LootBonusTable.COL_SET, f94_arg0)
	if f94_local0 ~= nil and #f94_local0 > 0 then
		return Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.LootBonusTable.name, f94_local0[1], CoD.BlackMarketTableUtility.LootBonusTable.COL_NAMEHASH)
	else
		return nil
	end
end
CoD.BlackMarketTableUtility.GetBonusSetTotal = function(f95_arg0)
	local f95_local0 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.LootBonusTable.name, CoD.BlackMarketTableUtility.LootBonusTable.COL_SET, f95_arg0)
	if f95_local0 ~= nil and #f95_local0 > 0 then
		return Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.LootBonusTable.name, f95_local0[1], CoD.BlackMarketTableUtility.LootBonusTable.COL_TOTAL)
	else
		return nil
	end
end
CoD.BlackMarketTableUtility.GetBonusSetMinimumTarget = function(f96_arg0)
	local f96_local0 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.LootBonusTable.name, CoD.BlackMarketTableUtility.LootBonusTable.COL_SET, f96_arg0)
	if f96_local0 ~= nil and #f96_local0 > 0 then
		return Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.LootBonusTable.name, f96_local0[1], CoD.BlackMarketTableUtility.LootBonusTable.COL_MINIMUMTARGET)
	else
		return 0
	end
end
CoD.BlackMarketTableUtility.GetNumberOwnedAndAvailableOfSet = function(f97_arg0, f97_arg1)
	local f97_local0 = 0
	local f97_local1 = 0
	local f97_local2 = false
	local f97_local3 = false
	local f97_local4 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.ContrabandTable.name, CoD.BlackMarketTableUtility.ContrabandTable.COL_SET, f97_arg1)
	if f97_local4 ~= nil then
		for f97_local5 = 1, #f97_local4, 1 do
			if 0 < Engine[@"hash_34509DFCBC7BC5CE"](f97_arg0, Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContrabandTable.name, f97_local4[f97_local5], CoD.BlackMarketTableUtility.ContrabandTable.COL_ID)) then
				f97_local0 = f97_local0 + 1
				f97_local1 = f97_local1 + 1
			end
		end
	end
	local f97_local5 = CoDShared.Loot.GetCurrentSeason()
	for f97_local13, f97_local14 in pairs(CoDShared.Loot.SeasonParams) do
		local f97_local15 = CoDShared.Loot.GetSeasonInfoParam(f97_local13, CoDShared.Loot.SEASON_INFO_TABLENAME)
		local f97_local16 = Engine[@"tablefindrows"](f97_local15, CoD.BlackMarketTableUtility.SeasonsTable.COL_SET, f97_arg1)
		if f97_local16 ~= nil then
			local f97_local9 = f97_local13 == f97_local5
			for f97_local10 = 1, #f97_local16, 1 do
				if 0 < Engine[@"hash_34509DFCBC7BC5CE"](f97_arg0, Engine[@"hash_4C6F8EC444864600"](f97_local15, f97_local16[f97_local10], CoD.BlackMarketTableUtility.SeasonsTable.COL_ID)) then
					f97_local0 = f97_local0 + 1
					f97_local1 = f97_local1 + 1
				end
				if f97_local9 then
					f97_local1 = f97_local1 + 1
				end
			end
		end
	end
	for f97_local13, f97_local14 in pairs(CoD.BlackMarketTableUtility.ContractsTable.names) do
		local f97_local15 = Engine[@"tablefindrows"](f97_local14, CoD.BlackMarketTableUtility.ContractsTable.COL_SET, f97_arg1)
		if f97_local15 ~= nil then
			if CoD.BlackMarketTableUtility.IsContractOwned(f97_arg0, f97_local13) then
				f97_local1 = f97_local1 + #f97_local15
			end
			for f97_local16 = 1, #f97_local15, 1 do
				if 0 < Engine[@"hash_34509DFCBC7BC5CE"](f97_arg0, Engine[@"hash_4C6F8EC444864600"](f97_local14, f97_local15[f97_local16], CoD.BlackMarketTableUtility.ContractsTable.COL_ID)) then
					f97_local0 = f97_local0 + 1
				end
			end
		end
	end
	f97_local6 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.ItemShopTable.name, CoD.BlackMarketTableUtility.ItemShopTable.COL_SET, f97_arg1)
	if f97_local6 ~= nil then
		for f97_local7 = 1, #f97_local6, 1 do
			local f97_local15 = f97_local6[f97_local7]
			local f97_local16 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ItemShopTable.name, f97_local15, CoD.BlackMarketTableUtility.ItemShopTable.COL_TYPE)
			local f97_local10 = 0 < Engine[@"hash_34509DFCBC7BC5CE"](f97_arg0, Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ItemShopTable.name, f97_local15, CoD.BlackMarketTableUtility.ItemShopTable.COL_ID))
			if f97_local16 == @"tag_bundle" or f97_local16 == @"outfit_bundle" then
				f97_local2 = true
				f97_local3 = f97_local10
			end
			if f97_local10 then
				f97_local0 = f97_local0 + 1
				f97_local1 = f97_local1 + 1
			end
		end
	end
	if f97_local2 then
		f97_local7 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.BundleTable.name, CoD.BlackMarketTableUtility.BundleTable.COL_SET, f97_arg1)
		if f97_local7 ~= nil then
			f97_local1 = #f97_local7
			if f97_local3 then
				f97_local0 = #f97_local7
			end
		end
	end
	return f97_local0, f97_local1
end
CoD.BlackMarketTableUtility.IsBonusSetUnlocked = function(f98_arg0, f98_arg1)
	local f98_local0 = CoD.BlackMarketTableUtility.GetBonusSetMinimumTarget(f98_arg1)
	local f98_local1, f98_local2 = CoD.BlackMarketTableUtility.GetNumberOwnedAndAvailableOfSet(f98_arg0, f98_arg1)
	return f98_local0 <= f98_local1
end
CoD.BlackMarketTableUtility.GetBonusSetUnlockedAvailableStates = function(f99_arg0, f99_arg1)
	local f99_local0 = CoD.BlackMarketTableUtility.GetBonusSetMinimumTarget(f99_arg1)
	local f99_local1, f99_local2 = CoD.BlackMarketTableUtility.GetNumberOwnedAndAvailableOfSet(f99_arg0, f99_arg1)
	return f99_local0 <= f99_local1, f99_local0 <= f99_local2
end
CoD.BlackMarketTableUtility.GetLootBonusStringRef = function(f100_arg0, f100_arg1)
	local f100_local0 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.LootBonusTable.name, CoD.BlackMarketTableUtility.LootBonusTable.COL_SET, f100_arg1)
	if f100_local0 ~= nil and #f100_local0 > 0 then
		return Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.LootBonusTable.name, f100_local0[1], CoD.BlackMarketTableUtility.LootBonusTable.COL_STRINGREF)
	else
		return 0x0
	end
end
CoD.BlackMarketTableUtility.BackfillTable = {}
CoD.BlackMarketTableUtility.BackfillTable.name = @"hash_12C85CA9A2CE0E06"
CoD.BlackMarketTableUtility.BackfillTable.COL_NAMEHASH = 0
CoD.BlackMarketTableUtility.BackfillTable.COL_TYPE = 1
CoD.BlackMarketTableUtility.BackfillTable.COL_RARITY = 2
CoD.BlackMarketTableUtility.BackfillTable.COL_SET = 3
CoD.BlackMarketTableUtility.BackfillTable.COL_MPPRT = 4
CoD.BlackMarketTableUtility.BackfillTable.COL_WZPRT = 5
CoD.BlackMarketTableUtility.BackfillTable.COL_OUTFIT = 6
CoD.BlackMarketTableUtility.BackfillTable.COL_REFWEAPON = 7
CoD.BlackMarketTableUtility.BackfillTable.COL_REFOPTIC = 8
CoD.BlackMarketTableUtility.BackfillTable.COL_ID = 9
CoD.BlackMarketTableUtility.GetBackfillItemInfoByRow = function(f101_arg0, f101_arg1)
	return CoD.BlackMarketTableUtility.GetBackfillItemInfo(f101_arg0, Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BackfillTable.name, f101_arg1, CoD.BlackMarketTableUtility.BackfillTable.COL_ID), f101_arg1)
end
CoD.BlackMarketTableUtility.GetBackfillItemInfo = function(f102_arg0, f102_arg1, f102_arg2)
	if f102_arg1 == nil then
		return {}
	end
	local f102_local0 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.BackfillTable.name, CoD.BlackMarketTableUtility.BackfillTable.COL_NAMEHASH, Engine[@"hash_DE65B393F703EB1"](CoD.BlackMarketTableUtility.BackfillTable.name, CoD.BlackMarketTableUtility.BackfillTable.COL_ID, f102_arg1, CoD.BlackMarketTableUtility.BackfillTable.COL_NAMEHASH))
	local f102_local1 = nil
	if f102_local0 ~= nil and #f102_local0 > 0 then
		local f102_local2 = f102_local0[1]
		f102_local1 = {
			itemId = f102_arg1,
			tier = f102_arg2,
			name = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BackfillTable.name, f102_local2, CoD.BlackMarketTableUtility.BackfillTable.COL_NAMEHASH),
			rarity = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BackfillTable.name, f102_local2, CoD.BlackMarketTableUtility.BackfillTable.COL_RARITY),
			owned = Engine[@"hash_5352DC095BBB2A45"](f102_arg0, f102_arg1),
			inSet = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BackfillTable.name, f102_local2, CoD.BlackMarketTableUtility.BackfillTable.COL_SET),
			category = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BackfillTable.name, f102_local2, CoD.BlackMarketTableUtility.BackfillTable.COL_TYPE),
			lootType = LuaEnum.LOOT_TYPE.CONTRABAND,
			refOptic = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BackfillTable.name, f102_local2, CoD.BlackMarketTableUtility.BackfillTable.COL_REFOPTIC),
		}
	end
	return f102_local1
end
CoD.BlackMarketTableUtility.GetBackfillOutfitInformation = function(f103_arg0, f103_arg1)
	local f103_local0 = 0x0
	local f103_local1 = 0x0
	local f103_local2 = 0x0
	local f103_local3 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.BackfillTable.name, CoD.BlackMarketTableUtility.BackfillTable.COL_NAMEHASH, f103_arg1)
	if f103_local3 == nil then
		return {}
	end
	local f103_local4 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BackfillTable.name, f103_local3[1], CoD.BlackMarketTableUtility.BackfillTable.COL_MPPRT)
	local f103_local5 = Enum[@"emodes"][@"mode_multiplayer"]
	if f103_local4 == 0x0 then
		f103_local4 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BackfillTable.name, f103_local3[1], CoD.BlackMarketTableUtility.BackfillTable.COL_WZPRT)
		f103_local5 = Enum[@"emodes"][@"mode_warzone"]
		if f103_local4 == 0x0 then
			return {}
		end
	end
	local f103_local6 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BackfillTable.name, f103_local3[1], CoD.BlackMarketTableUtility.BackfillTable.COL_OUTFIT)
	if f103_local6 == 0x0 then
		return {}
	end
	local f103_local7 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BackfillTable.name, f103_local3[1], CoD.BlackMarketTableUtility.BackfillTable.COL_TYPE)
	local f103_local8 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BackfillTable.name, f103_local3[1], CoD.BlackMarketTableUtility.BackfillTable.COL_NAMEHASH)
	local f103_local9 = Engine[0x422A503291AC81](f103_local7)
	if f103_local9 == Enum[@"characteritemtype"][@"hash_57852FCB3BFCC8D1"] then
		f103_local0 = f103_local8
	elseif f103_local9 == Enum[@"characteritemtype"][@"hash_4922FE5C41D9EE8B"] then
		f103_local1 = f103_local8
	elseif f103_local9 == Enum[@"characteritemtype"][@"hash_48E3A65D78229DC1"] then
		f103_local2 = f103_local8
	end
	return {
		prt = f103_local4,
		mode = f103_local5,
		outfit = f103_local6,
		decal = f103_local0,
		preset = f103_local1,
		war_paint = f103_local2,
	}
end
CoD.BlackMarketTableUtility[0xC3056CABEF9D99] = function(f104_arg0)
	local f104_local0 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.BackfillTable.name, CoD.BlackMarketTableUtility.BackfillTable.COL_NAMEHASH, f104_arg0)
	if f104_local0 ~= nil and #f104_local0 > 0 then
		return {
			rarity = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BackfillTable.name, f104_local0[1], CoD.BlackMarketTableUtility.BackfillTable.COL_RARITY),
			isLoot = true,
			owned = IsBooleanDvarSet(@"hash_3B843C9AB4802F53"),
			available = IsBooleanDvarSet(@"hash_3B843C9AB4802F53"),
			lootType = LuaEnum.LOOT_TYPE.EMPTY,
		}
	else
	end
end
CoD.BlackMarketTableUtility.MyShopTable = {}
CoD.BlackMarketTableUtility.MyShopTable.name = 0x759B6A8C66F0CFA
CoD.BlackMarketTableUtility.MyShopTable.COL_NAMEHASH = 0
CoD.BlackMarketTableUtility.MyShopTable.COL_LOOT_TYPE = 1
CoD.BlackMarketTableUtility.MyShopTable.COL_SKU = 2
CoD.BlackMarketTableUtility.MyShopTable.COL_PRICE = 3
CoD.BlackMarketTableUtility.MyShopTable.COL_NUMERATOR = 4
CoD.BlackMarketTableUtility.MyShopTable.COL_PRICEPOINT = 5
CoD.BlackMarketTableUtility.MyShopTable.NumberOfPricePoints = 3
CoD.BlackMarketTableUtility.GetMyShopItemCategory = function(f105_arg0, f105_arg1)
	local f105_local0 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.MyShopTable.name, CoD.BlackMarketTableUtility.MyShopTable.COL_NAMEHASH, f105_arg1)
	if f105_local0 == nil then
		return nil
	else
		return Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.MyShopTable.name, f105_local0[1], CoD.BlackMarketTableUtility.MyShopTable.COL_LOOT_TYPE)
	end
end
CoD.BlackMarketTableUtility.GetMyShopItemId = function(f106_arg0, f106_arg1)
	local f106_local0 = CoD.BlackMarketTableUtility.GetMyShopItemCategory(f106_arg0, f106_arg1)
	if f106_local0 == @"special_order" then
		for f106_local4, f106_local5 in pairs(CoD.BlackMarketTableUtility.ContractsTable.names) do
			if f106_local4 == f106_arg1 then
				return CoD.BlackMarketTableUtility.GetContractId(f106_local4)
			end
		end
	elseif f106_local0 == @"hash_731315EF3FB1AE07" then
		return CoD.BlackMarketTableUtility.GetItemShopEntryId(f106_arg0, f106_arg1)
	elseif f106_local0 == @"loot_stream" then
		return CoD.BlackMarketTableUtility.GetSeasonItemId(f106_arg0, f106_arg1)
	end
	return nil
end
CoD.BlackMarketTableUtility.GetMyShopSkuAndPrice = function(f107_arg0, f107_arg1, f107_arg2)
	local f107_local0 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.MyShopTable.name, CoD.BlackMarketTableUtility.MyShopTable.COL_NAMEHASH, f107_arg1)
	if f107_local0 == nil then
		return nil
	end
	for f107_local6, f107_local7 in ipairs(f107_local0) do
		if Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.MyShopTable.name, f107_local7, CoD.BlackMarketTableUtility.MyShopTable.COL_PRICEPOINT) == f107_arg2 then
			local f107_local4 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.MyShopTable.name, f107_local7, CoD.BlackMarketTableUtility.MyShopTable.COL_PRICE)
			local f107_local5 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.MyShopTable.name, f107_local7, CoD.BlackMarketTableUtility.MyShopTable.COL_SKU)
			if f107_local4 and f107_local5 then
				return {
					price = f107_local4,
					sku = f107_local5,
				}
			end
		end
	end
	return nil
end
CoD.BlackMarketTableUtility.GetAllMyShopItems = function(f108_arg0, f108_arg1)
	local f108_local0 = {}
	local f108_local1 = Engine[@"gettablerowcount"](CoD.BlackMarketTableUtility.MyShopTable.name)
	for f108_local2 = 1, f108_local1, 1 do
		local f108_local5 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.MyShopTable.name, f108_local2, CoD.BlackMarketTableUtility.MyShopTable.COL_NAMEHASH)
		if f108_local5 then
			local f108_local6 = CoD.BlackMarketTableUtility.GetMyShopItemCategory(f108_arg0, f108_local5)
			local f108_local7 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.MyShopTable.name, f108_local2, CoD.BlackMarketTableUtility.MyShopTable.COL_NUMERATOR)
			local f108_local8 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.MyShopTable.name, f108_local2, CoD.BlackMarketTableUtility.MyShopTable.COL_PRICEPOINT)
			if not f108_arg1 or f108_arg1 == f108_local6 then
				table.insert(f108_local0, {
					name = f108_local5,
					weight = f108_local7,
					pricePoint = f108_local8,
				})
			end
		end
	end
	return f108_local0
end
CoD.BlackMarketTableUtility.GetMyShopItemNameFromId = function(f109_arg0, f109_arg1)
	local f109_local0 = CoD.BlackMarketTableUtility.GetContractInfo(f109_arg1)
	if f109_local0 ~= nil then
		return f109_local0.namehash
	else
		f109_local0 = CoD.BlackMarketTableUtility.GetItemShopEntryName(f109_arg0, f109_arg1)
		if f109_local0 ~= nil and f109_local0 ~= 0x0 then
			return f109_local0
		else
			f109_local0 = CoD.BlackMarketTableUtility.GetMyShopSeasonItemInfo(f109_arg0, f109_arg1)
			if f109_local0 ~= nil then
				return f109_local0.name
			else
				return nil
			end
		end
	end
end
CoD.BlackMarketTableUtility.DetItemsTable = {}
CoD.BlackMarketTableUtility.DetItemsTable.name = @"hash_5C6DC30FFB97EE8B"
CoD.BlackMarketTableUtility.DetItemsTable.COL_NAMEHASH = 0
CoD.BlackMarketTableUtility.DetItemsTable.COL_LOOT_TYPE = 1
CoD.BlackMarketTableUtility.DetItemsTable.COL_CP_SKU = 2
CoD.BlackMarketTableUtility.DetItemsTable.COL_CP_PRICE = 3
CoD.BlackMarketTableUtility.DetItemsTable.COL_CASE_RULE = 4
CoD.BlackMarketTableUtility.DetItemsTable.COL_CASE_PRICE = 5
CoD.BlackMarketTableUtility.DetItemsTable.COL_NUMERATOR = 6
CoD.BlackMarketTableUtility.DetItemsTable.COL_NUMERATOR_1 = 7
CoD.BlackMarketTableUtility.DetItemsTable.COL_PRICEPOINT = 8
CoD.BlackMarketTableUtility.DetItemsTable.allDeterministicItemsTable = nil
CoD.BlackMarketTableUtility.GetDeterministicItemCategory = function(f110_arg0, f110_arg1)
	local f110_local0 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.DetItemsTable.name, CoD.BlackMarketTableUtility.DetItemsTable.COL_NAMEHASH, f110_arg1)
	if f110_local0 == nil then
		return nil
	else
		return Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.DetItemsTable.name, f110_local0[1], CoD.BlackMarketTableUtility.DetItemsTable.COL_LOOT_TYPE)
	end
end
CoD.BlackMarketTableUtility.GetDeterministicItemId = function(f111_arg0, f111_arg1)
	local f111_local0 = CoD.BlackMarketTableUtility.GetDeterministicItemCategory(f111_arg0, f111_arg1)
	if f111_local0 == @"special_order" then
		for f111_local4, f111_local5 in pairs(CoD.BlackMarketTableUtility.ContractsTable.names) do
			if f111_local4 == f111_arg1 then
				return CoD.BlackMarketTableUtility.GetContractId(f111_local4)
			end
		end
	elseif f111_local0 == @"hash_731315EF3FB1AE07" then
		return CoD.BlackMarketTableUtility.GetItemShopEntryId(f111_arg0, f111_arg1)
	elseif f111_local0 == @"loot_stream" then
		return CoD.BlackMarketTableUtility.GetSeasonItemId(f111_arg0, f111_arg1)
	end
	return nil
end
CoD.BlackMarketTableUtility.GetDeterministicItemSkusAndPrices = function(f112_arg0, f112_arg1, f112_arg2)
	local f112_local0 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.DetItemsTable.name, CoD.BlackMarketTableUtility.DetItemsTable.COL_NAMEHASH, f112_arg1)
	if f112_local0 == nil then
		return nil
	end
	for f112_local8, f112_local9 in ipairs(f112_local0) do
		if Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.DetItemsTable.name, f112_local9, CoD.BlackMarketTableUtility.DetItemsTable.COL_PRICEPOINT) == f112_arg2 then
			local f112_local4 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.DetItemsTable.name, f112_local9, CoD.BlackMarketTableUtility.DetItemsTable.COL_CP_PRICE)
			local f112_local5 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.DetItemsTable.name, f112_local9, CoD.BlackMarketTableUtility.DetItemsTable.COL_CP_SKU)
			local f112_local6 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.DetItemsTable.name, f112_local9, CoD.BlackMarketTableUtility.DetItemsTable.COL_CASE_PRICE)
			local f112_local7 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.DetItemsTable.name, f112_local9, CoD.BlackMarketTableUtility.DetItemsTable.COL_CASE_RULE)
			if f112_local4 and f112_local5 and f112_local6 and f112_local7 then
				return {
					cpPrice = f112_local4,
					cpSku = f112_local5,
					casePrice = f112_local6,
					caseRule = f112_local7,
				}
			end
		end
	end
	return nil
end
CoD.BlackMarketTableUtility.GetAllDeterministicItem = function(f113_arg0, f113_arg1, f113_arg2)
	if not f113_arg1 and CoD.BlackMarketTableUtility.DetItemsTable.allDeterministicItemsTable then
		if not f113_arg2 then
			return CoD.BlackMarketTableUtility.DetItemsTable.allDeterministicItemsTable
		end
		local f113_local0 = {}
		for f113_local4, f113_local5 in ipairs(CoD.BlackMarketTableUtility.DetItemsTable.allDeterministicItemsTable) do
			if f113_local5.category == f113_arg2 then
				table.insert(f113_local0, f113_local5)
			end
		end
		return f113_local0
	else
		local f113_local0 = {}
		local f113_local1 = Engine[@"gettablerowcount"](CoD.BlackMarketTableUtility.DetItemsTable.name)
		for f113_local2 = 1, f113_local1, 1 do
			local f113_local6 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.DetItemsTable.name, f113_local2, CoD.BlackMarketTableUtility.DetItemsTable.COL_NAMEHASH)
			if f113_local6 then
				local f113_local7 = CoD.BlackMarketTableUtility.GetDeterministicItemCategory(f113_arg0, f113_local6)
				local f113_local8 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.DetItemsTable.name, f113_local2, CoD.BlackMarketTableUtility.DetItemsTable.COL_NUMERATOR)
				local f113_local9 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.DetItemsTable.name, f113_local2, CoD.BlackMarketTableUtility.DetItemsTable.COL_NUMERATOR_1)
				local f113_local10 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.DetItemsTable.name, f113_local2, CoD.BlackMarketTableUtility.DetItemsTable.COL_PRICEPOINT)
				if not f113_arg2 or f113_arg2 == f113_local7 then
					table.insert(f113_local0, {
						name = f113_local6,
						weight1 = f113_local8,
						weight2 = f113_local9,
						pricePoint = f113_local10,
						category = f113_local7,
					})
				end
			end
		end
		if not f113_arg2 then
			CoD.BlackMarketTableUtility.DetItemsTable.allDeterministicItemsTable = f113_local0
		end
		return f113_local0
	end
end
CoD.BlackMarketTableUtility.GetDeterministicItemNameFromId = function(f114_arg0, f114_arg1)
	local f114_local0 = CoD.BlackMarketTableUtility.GetContractInfo(f114_arg1)
	if f114_local0 ~= nil then
		return f114_local0.namehash
	else
		f114_local0 = CoD.BlackMarketTableUtility.GetItemShopEntryName(f114_arg0, f114_arg1)
		if f114_local0 ~= nil and f114_local0 ~= 0x0 then
			return f114_local0
		else
			f114_local0 = CoD.BlackMarketTableUtility.GetMyShopSeasonItemInfo(f114_arg0, f114_arg1)
			if f114_local0 ~= nil then
				return f114_local0.name
			else
				return nil
			end
		end
	end
end
CoD.BlackMarketTableUtility.BribeTable = {}
CoD.BlackMarketTableUtility.BribeTable.name = 0x17CBA1D3ECCF8E7
CoD.BlackMarketTableUtility.BribeTable.COL_NAMEHASH = 0
CoD.BlackMarketTableUtility.BribeTable.COL_LOOT_RULE = 1
CoD.BlackMarketTableUtility.BribeTable.COL_ID = 2
CoD.BlackMarketTableUtility.BribeTable.COL_CURRENCY = 3
CoD.BlackMarketTableUtility.BribeTable.COL_COST = 4
CoD.BlackMarketTableUtility.BribeTable.COL_ONE_TIME = 5
CoD.BlackMarketTableUtility.BribeTable.COL_INCLUDED_BUNDLE = 6
CoD.BlackMarketTableUtility.BribeTable.COL_CURRENCY_OPTIONAL = 7
CoD.BlackMarketTableUtility.BribeTable.COL_COST_OPTIONAL = 8
CoD.BlackMarketTableUtility.BribeTable.COL_ITEM_EXCHANGE = 9
CoD.BlackMarketTableUtility.BribeTable.COL_SINGLE_ITEM = 10
CoD.BlackMarketTableUtility.BribeTable.COL_ADDITIONAL_DROP = 11
CoD.BlackMarketTableUtility.BribeTable.COL_STRING_NAME = 12
CoD.BlackMarketTableUtility.BribeTable.COL_KEY_ITEM = 13
CoD.BlackMarketTableUtility.BribeTable.COL_BRIBE_MENU = 14
CoD.BlackMarketTableUtility.BribeTable.COL_SORT_ORDER = 15
CoD.BlackMarketTableUtility.GetBribeStackInfo = function(f115_arg0)
	local f115_local0 = {}
	local f115_local1 = Engine[@"gettablerowcount"](CoD.BlackMarketTableUtility.BribeTable.name)
	for f115_local2 = 1, f115_local1, 1 do
		local f115_local5 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f115_local2, CoD.BlackMarketTableUtility.BribeTable.COL_NAMEHASH)
		if f115_local5 and IsBooleanDvarSet(f115_local5) then
			table.insert(f115_local0, {
				bribeName = f115_local5,
				lootRule = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f115_local2, CoD.BlackMarketTableUtility.BribeTable.COL_LOOT_RULE),
				stringName = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f115_local2, CoD.BlackMarketTableUtility.BribeTable.COL_STRING_NAME),
			})
		end
	end
	return f115_local0
end
CoD.BlackMarketTableUtility.GetBribeCPAndCasePrice = function(f116_arg0, f116_arg1)
	local f116_local0 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.BribeTable.name, CoD.BlackMarketTableUtility.BribeTable.COL_NAMEHASH, f116_arg1)
	if f116_local0 ~= nil then
		local f116_local1 = f116_local0[1]
		local f116_local2 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f116_local1, CoD.BlackMarketTableUtility.BribeTable.COL_CURRENCY)
		local f116_local3 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f116_local1, CoD.BlackMarketTableUtility.BribeTable.COL_COST)
		local f116_local4 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f116_local1, CoD.BlackMarketTableUtility.BribeTable.COL_CURRENCY_OPTIONAL)
		local f116_local5 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f116_local1, CoD.BlackMarketTableUtility.BribeTable.COL_COST_OPTIONAL)
		local f116_local6, f116_local7 = nil
		if f116_local2 == tostring(CoD.BlackMarketUtility.COD_POINTS_CURRENCY_ID) then
			f116_local6 = f116_local3
		end
		if f116_local4 == tostring(CoD.BlackMarketUtility.RESERVE_CRATE_CURRENCY_ID) then
			f116_local7 = f116_local5
		end
		return {
			price = f116_local6,
			casePrice = f116_local7,
		}
	else
		return nil
	end
end
CoD.BlackMarketTableUtility.GetAdditionalDrop = function(f117_arg0, f117_arg1)
	local f117_local0 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.BribeTable.name, CoD.BlackMarketTableUtility.BribeTable.COL_LOOT_RULE, f117_arg1)
	if f117_local0 ~= nil then
		return Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f117_local0[1], CoD.BlackMarketTableUtility.BribeTable.COL_ADDITIONAL_DROP)
	else
		return nil
	end
end
CoD.BlackMarketTableUtility.CanPurchaseBribe = function(f118_arg0, f118_arg1, f118_arg2, f118_arg3, f118_arg4, f118_arg5, f118_arg6, f118_arg7)
	local f118_local0 = false
	local f118_local1 = 0
	local f118_local2 = 0
	local f118_local3 = Engine[@"hash_2F40679B550DCCA2"](f118_arg0, CoD.Currencies.COD_POINTS)
	if f118_arg1 and f118_arg1 ~= "" and f118_arg2 and f118_arg2 ~= 0 then
		if f118_arg1 == tostring(CoD.BlackMarketUtility.COD_POINTS_CURRENCY_ID) then
			if f118_arg2 <= f118_local3 then
				f118_local0 = true
				f118_local1 = math.floor(f118_local3 / f118_arg2)
			end
		elseif f118_arg1 ~= tostring(CoD.BlackMarketUtility.RESERVE_CRATE_CURRENCY_ID) or f118_arg6 == CoD.BlackMarketUtility.RESERVER_CASE_BRIBE_ID then
			local f118_local4 = Engine[@"hash_5352DC095BBB2A45"](f118_arg0, f118_arg1)
			if f118_arg2 <= f118_local4 then
				f118_local0 = true
				f118_local1 = math.floor(f118_local4 / f118_arg2)
				f118_local2 = math.floor(f118_local4 / f118_arg2)
			end
		end
	end
	if f118_arg3 and f118_arg4 ~= "" and f118_arg3 and f118_arg4 ~= 0 then
		if f118_arg5 and f118_local0 then
			if Engine[@"hash_5352DC095BBB2A45"](f118_arg0, f118_arg3) < f118_arg4 then
				f118_local0 = false
				f118_local1 = 0
			end
		elseif f118_arg3 == tostring(CoD.BlackMarketUtility.COD_POINTS_CURRENCY_ID) then
			if f118_arg4 <= f118_local3 then
				f118_local0 = true
				f118_local1 = f118_local1 + math.floor(f118_local3 / f118_arg4)
			end
		elseif f118_arg3 ~= tostring(CoD.BlackMarketUtility.RESERVE_CRATE_CURRENCY_ID) or f118_arg6 == CoD.BlackMarketUtility.RESERVER_CASE_BRIBE_ID then
			local f118_local4 = Engine[@"hash_5352DC095BBB2A45"](f118_arg0, f118_arg3)
			if f118_arg4 <= f118_local4 then
				f118_local0 = true
				f118_local1 = f118_local1 + math.floor(f118_local4 / f118_arg4)
				f118_local2 = f118_local2 + math.floor(f118_local4 / f118_arg4)
			end
		end
	end
	if f118_arg7 and f118_arg6 then
		if 0 < Engine[@"hash_5352DC095BBB2A45"](f118_arg0, f118_arg6) then
			f118_local0 = false
			f118_local1 = 0
		else
			f118_local1 = 1
		end
	end
	return f118_local0, f118_local1, f118_local2
end
CoD.BlackMarketTableUtility.GetBribeInformation = function(f119_arg0, f119_arg1)
	local f119_local0 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.BribeTable.name, CoD.BlackMarketTableUtility.BribeTable.COL_NAMEHASH, f119_arg1)
	if f119_local0 ~= nil then
		local f119_local1 = f119_local0[1]
		local f119_local2 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f119_local1, CoD.BlackMarketTableUtility.BribeTable.COL_CURRENCY)
		local f119_local3 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f119_local1, CoD.BlackMarketTableUtility.BribeTable.COL_COST)
		local f119_local4 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f119_local1, CoD.BlackMarketTableUtility.BribeTable.COL_CURRENCY_OPTIONAL)
		local f119_local5 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f119_local1, CoD.BlackMarketTableUtility.BribeTable.COL_COST_OPTIONAL)
		local f119_local6 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f119_local1, CoD.BlackMarketTableUtility.BribeTable.COL_ITEM_EXCHANGE)
		local f119_local7 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f119_local1, CoD.BlackMarketTableUtility.BribeTable.COL_ID)
		local f119_local8, f119_local9, f119_local10 = CoD.BlackMarketTableUtility.CanPurchaseBribe(f119_arg0, f119_local2, f119_local3, f119_local4, f119_local5, f119_local6, f119_local7, Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f119_local1, CoD.BlackMarketTableUtility.BribeTable.COL_ONE_TIME))
		return {
			name = f119_arg1,
			lootRule = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f119_local1, CoD.BlackMarketTableUtility.BribeTable.COL_LOOT_RULE),
			bribeId = f119_local7,
			currency = f119_local2,
			price = f119_local3,
			canPurchase = f119_local8,
			quantity = f119_local9,
			nonCpQuantity = f119_local10,
			isSingleItem = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f119_local1, CoD.BlackMarketTableUtility.BribeTable.COL_SINGLE_ITEM),
			optionalCost = f119_local5,
			optionalCurrency = f119_local4,
			stringName = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f119_local1, CoD.BlackMarketTableUtility.BribeTable.COL_STRING_NAME),
			keyItem = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f119_local1, CoD.BlackMarketTableUtility.BribeTable.COL_KEY_ITEM),
			bribeMenu = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f119_local1, CoD.BlackMarketTableUtility.BribeTable.COL_BRIBE_MENU),
			sortIndex = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f119_local1, CoD.BlackMarketTableUtility.BribeTable.COL_SORT_ORDER),
		}
	else
		return nil
	end
end
CoD.BlackMarketTableUtility.GetAllBribes = function(f120_arg0)
	local f120_local0 = {}
	local f120_local1 = Engine[@"gettablerowcount"](CoD.BlackMarketTableUtility.BribeTable.name)
	for f120_local2 = 1, f120_local1, 1 do
		table.insert(f120_local0, Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f120_local2 - 1, CoD.BlackMarketTableUtility.BribeTable.COL_NAMEHASH))
	end
	return f120_local0
end
CoD.BlackMarketTableUtility.GetRedeemableCPBribes = function(f121_arg0)
	local f121_local0 = {}
	for f121_local1 = Engine[@"gettablerowcount"](CoD.BlackMarketTableUtility.BribeTable.name), 1, -1 do
		local f121_local4 = f121_local1 - 1
		local f121_local5 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f121_local4, CoD.BlackMarketTableUtility.BribeTable.COL_NAMEHASH)
		local f121_local6 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f121_local4, CoD.BlackMarketTableUtility.BribeTable.COL_CURRENCY)
		local f121_local7 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f121_local4, CoD.BlackMarketTableUtility.BribeTable.COL_COST)
		local f121_local8 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f121_local4, CoD.BlackMarketTableUtility.BribeTable.COL_CURRENCY_OPTIONAL)
		local f121_local9 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f121_local4, CoD.BlackMarketTableUtility.BribeTable.COL_COST_OPTIONAL)
		local f121_local10 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f121_local4, CoD.BlackMarketTableUtility.BribeTable.COL_ITEM_EXCHANGE)
		local f121_local11 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f121_local4, CoD.BlackMarketTableUtility.BribeTable.COL_ID)
		local f121_local12, f121_local13, f121_local14 = CoD.BlackMarketTableUtility.CanPurchaseBribe(f121_arg0, f121_local6, f121_local7, f121_local8, f121_local9, f121_local10, f121_local11, Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f121_local4, CoD.BlackMarketTableUtility.BribeTable.COL_ONE_TIME))
		local f121_local15 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f121_local4, CoD.BlackMarketTableUtility.BribeTable.COL_SINGLE_ITEM)
		local f121_local16 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f121_local4, CoD.BlackMarketTableUtility.BribeTable.COL_KEY_ITEM)
		local f121_local17 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f121_local4, CoD.BlackMarketTableUtility.BribeTable.COL_BRIBE_MENU)
		local f121_local18 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f121_local4, CoD.BlackMarketTableUtility.BribeTable.COL_SORT_ORDER)
		if (f121_local6 == tostring(CoD.BlackMarketUtility.COD_POINTS_CURRENCY_ID) or f121_local8 == tostring(CoD.BlackMarketUtility.COD_POINTS_CURRENCY_ID) and not f121_local10) and f121_local12 and f121_local13 > 0 then
			table.insert(f121_local0, {
				name = f121_local5,
				lootRule = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f121_local4, CoD.BlackMarketTableUtility.BribeTable.COL_LOOT_RULE),
				bribeId = f121_local11,
				currency = f121_local6,
				price = f121_local7,
				optionalCurrency = f121_local8,
				optionalCost = f121_local9,
				itemExchange = f121_local10,
				canPurchase = f121_local12,
				quantity = f121_local13,
				nonCpQuantity = f121_local14,
				isSingleItem = f121_local15,
				keyItem = f121_local16,
				bribeMenu = f121_local17,
				sortIndex = f121_local18,
			})
		end
	end
	return f121_local0
end
CoD.BlackMarketTableUtility.GetRedeemableNonCPBribes = function(f122_arg0)
	local f122_local0 = {}
	for f122_local1 = Engine[@"gettablerowcount"](CoD.BlackMarketTableUtility.BribeTable.name), 1, -1 do
		local f122_local4 = f122_local1 - 1
		local f122_local5 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f122_local4, CoD.BlackMarketTableUtility.BribeTable.COL_NAMEHASH)
		local f122_local6 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f122_local4, CoD.BlackMarketTableUtility.BribeTable.COL_CURRENCY)
		local f122_local7 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f122_local4, CoD.BlackMarketTableUtility.BribeTable.COL_COST)
		local f122_local8 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f122_local4, CoD.BlackMarketTableUtility.BribeTable.COL_CURRENCY_OPTIONAL)
		local f122_local9 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f122_local4, CoD.BlackMarketTableUtility.BribeTable.COL_COST_OPTIONAL)
		local f122_local10 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f122_local4, CoD.BlackMarketTableUtility.BribeTable.COL_ITEM_EXCHANGE)
		local f122_local11 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f122_local4, CoD.BlackMarketTableUtility.BribeTable.COL_ID)
		local f122_local12, f122_local13, f122_local14 = CoD.BlackMarketTableUtility.CanPurchaseBribe(f122_arg0, f122_local6, f122_local7, f122_local8, f122_local9, f122_local10, f122_local11, Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f122_local4, CoD.BlackMarketTableUtility.BribeTable.COL_ONE_TIME))
		local f122_local15 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f122_local4, CoD.BlackMarketTableUtility.BribeTable.COL_SINGLE_ITEM)
		local f122_local16 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f122_local4, CoD.BlackMarketTableUtility.BribeTable.COL_KEY_ITEM)
		local f122_local17 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f122_local4, CoD.BlackMarketTableUtility.BribeTable.COL_BRIBE_MENU)
		local f122_local18 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f122_local4, CoD.BlackMarketTableUtility.BribeTable.COL_SORT_ORDER)
		if (f122_local6 ~= tostring(CoD.BlackMarketUtility.COD_POINTS_CURRENCY_ID) or f122_local8 ~= tostring(CoD.BlackMarketUtility.COD_POINTS_CURRENCY_ID) and not f122_local10) and f122_local12 and f122_local13 > 0 then
			table.insert(f122_local0, {
				name = f122_local5,
				lootRule = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f122_local4, CoD.BlackMarketTableUtility.BribeTable.COL_LOOT_RULE),
				bribeId = f122_local11,
				currency = f122_local6,
				price = f122_local7,
				optionalCurrency = f122_local8,
				optionalCost = f122_local9,
				itemExchange = f122_local10,
				canPurchase = f122_local12,
				quantity = f122_local13,
				nonCpQuantity = f122_local14,
				isSingleItem = f122_local15,
				keyItem = f122_local16,
				bribeMenu = f122_local17,
				sortIndex = f122_local18,
			})
		end
	end
	return f122_local0
end
CoD.BlackMarketTableUtility.IsBribeMenu = function(f123_arg0, f123_arg1)
	local f123_local0 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.BribeTable.name, CoD.BlackMarketTableUtility.BribeTable.COL_STRING_NAME, f123_arg1)
	if f123_local0 ~= nil then
		return Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f123_local0[1], CoD.BlackMarketTableUtility.BribeTable.COL_BRIBE_MENU)
	else
		return false
	end
end
CoD.BlackMarketTableUtility.GetWeaponBribeSelectionBribes = function(f124_arg0)
	local f124_local0 = {}
	for f124_local1 = Engine[@"gettablerowcount"](CoD.BlackMarketTableUtility.BribeTable.name), 1, -1 do
		local f124_local4 = f124_local1 - 1
		local f124_local5 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f124_local4, CoD.BlackMarketTableUtility.BribeTable.COL_BRIBE_MENU)
		if f124_local5 then
			local f124_local6 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f124_local4, CoD.BlackMarketTableUtility.BribeTable.COL_NAMEHASH)
			local f124_local7 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f124_local4, CoD.BlackMarketTableUtility.BribeTable.COL_CURRENCY)
			local f124_local8 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f124_local4, CoD.BlackMarketTableUtility.BribeTable.COL_COST)
			local f124_local9 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f124_local4, CoD.BlackMarketTableUtility.BribeTable.COL_CURRENCY_OPTIONAL)
			local f124_local10 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f124_local4, CoD.BlackMarketTableUtility.BribeTable.COL_COST_OPTIONAL)
			local f124_local11 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f124_local4, CoD.BlackMarketTableUtility.BribeTable.COL_ITEM_EXCHANGE)
			local f124_local12 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f124_local4, CoD.BlackMarketTableUtility.BribeTable.COL_ID)
			local f124_local13, f124_local14, f124_local15 = CoD.BlackMarketTableUtility.CanPurchaseBribe(f124_arg0, f124_local7, f124_local8, f124_local9, f124_local10, f124_local11, f124_local12, Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f124_local4, CoD.BlackMarketTableUtility.BribeTable.COL_ONE_TIME))
			table.insert(f124_local0, {
				name = f124_local6,
				lootRule = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f124_local4, CoD.BlackMarketTableUtility.BribeTable.COL_LOOT_RULE),
				bribeId = f124_local12,
				currency = f124_local7,
				price = f124_local8,
				optionalCurrency = f124_local9,
				optionalCost = f124_local10,
				itemExchange = f124_local11,
				canPurchase = f124_local13,
				quantity = f124_local14,
				nonCpQuantity = f124_local15,
				isSingleItem = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f124_local4, CoD.BlackMarketTableUtility.BribeTable.COL_SINGLE_ITEM),
				keyItem = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f124_local4, CoD.BlackMarketTableUtility.BribeTable.COL_KEY_ITEM),
				bribeMenu = f124_local5,
				sortIndex = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f124_local4, CoD.BlackMarketTableUtility.BribeTable.COL_SORT_ORDER),
				stringName = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BribeTable.name, f124_local4, CoD.BlackMarketTableUtility.BribeTable.COL_STRING_NAME),
			})
		end
	end
	return f124_local0
end
CoD.BlackMarketTableUtility.GetLootInfoForCamo = function(f125_arg0, f125_arg1, f125_arg2, f125_arg3)
	if f125_arg3 and f125_arg3 ~= 0x0 then
		return {
			isLoot = false,
			isEntitlement = true,
			owned = Engine[@"hasentitlement"](f125_arg0, f125_arg3),
			unlockInfo = Engine[@"hash_4F9F1239CFD921FE"](Engine[@"hash_2F9DAA00F0637292"](f125_arg3)),
		}
	end
	local f125_local0 = CoD.BlackMarketTableUtility.PerWeaponCamoLookup(f125_arg0, f125_arg1, f125_arg2)
	if f125_local0.isLoot == false then
		f125_local0 = CoD.BlackMarketTableUtility.LootInfoLookup(f125_arg0, f125_arg1)
	end
	return f125_local0
end
CoD.BlackMarketTableUtility.DefaultWeaponCamoLookupResult = {
	isLoot = false,
	available = false,
	owned = false,
	rarity = @"invalid",
}
CoD.BlackMarketTableUtility.PerWeaponCamoLookup = function(f126_arg0, f126_arg1, f126_arg2)
	if not f126_arg1 or f126_arg1 == 0x0 then
		return CoD.BlackMarketTableUtility.DefaultWeaponCamoLookupResult
	end
	local f126_local0 = true
	if not IsBooleanDvarSet(@"loot_enableblackmarket") then
		f126_local0 = false
	end
	local f126_local1 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.ContrabandTable.name, CoD.BlackMarketTableUtility.ContrabandTable.COL_NAMEHASH, f126_arg1)
	if f126_local1 ~= nil then
		for f126_local2 = 1, #f126_local1, 1 do
			local f126_local5 = f126_local1[f126_local2]
			if f126_arg2 == Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContrabandTable.name, f126_local5, CoD.BlackMarketTableUtility.ContrabandTable.COL_REFWEAPON) then
				local f126_local6 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContrabandTable.name, f126_local5, CoD.BlackMarketTableUtility.ContrabandTable.COL_RARITY)
				local f126_local7 = true
				local f126_local8 = Engine[@"hash_34509DFCBC7BC5CE"](f126_arg0, Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContrabandTable.name, f126_local5, CoD.BlackMarketTableUtility.ContrabandTable.COL_ID)) > 0
				local f126_local9 = f126_local8
				local f126_local10 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContrabandTable.name, f126_local5, CoD.BlackMarketTableUtility.ContrabandTable.COL_SET)
				if f126_local10 == 0x0 then
					f126_local10 = nil
				end
				local f126_local11 = false
				local f126_local12 = LuaEnum.LOOT_TYPE.CONTRABAND
				local f126_local13 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_444870138E328735")
				if not f126_local9 then
					f126_local13 = Engine[@"hash_4F9F1239CFD921FE"](@"hash_282246B89B2146A0")
				end
				return {
					rarity = f126_local6,
					isLoot = f126_local7,
					owned = f126_local8,
					available = f126_local9,
					inSet = f126_local10,
					setMaster = f126_local11,
					lootType = f126_local12,
					unlockInfo = f126_local13,
				}
			end
		end
	end
	return CoD.BlackMarketTableUtility.DefaultWeaponCamoLookupResult
end
CoD.BlackMarketTableUtility.SimpleLootLookupTypes = LuaEnum.createEnum(@"none", @"loot", @"entitlement", @"stat")
CoD.BlackMarketTableUtility.SimpleLootLookup = function(f127_arg0, f127_arg1, f127_arg2)
	if not f127_arg1 or f127_arg1 == 0x0 then
		return CoD.BlackMarketTableUtility.SimpleLootLookupTypes[@"none"], false
	elseif CoD.isPC and CoD.PCKoreaUtility.ShowKorea15Plus() then
		local f127_local0 = Engine[@"tablelookup"](CoD.BlackMarketUtility.lootEmblemTableName, 3, 13, f127_arg1)
		if f127_local0 and f127_local0 ~= 0x0 then
			f127_arg1 = f127_local0
		else
			f127_local0 = Engine[@"tablelookup"](CoD.BlackMarketUtility.backgroundsTable, 3, 19, f127_arg1)
			if f127_local0 and f127_local0 ~= 0x0 then
				f127_arg1 = f127_local0
			end
		end
	end
	local f127_local0, f127_local1 = CoD.BlackMarketTableUtility[@"hash_762B0EE548400BF2"](f127_arg0, f127_arg1)
	if f127_local0 and not f127_local1 then
		return CoD.BlackMarketTableUtility.SimpleLootLookupTypes[@"loot"], false
	end
	local f127_local2, f127_local3 = CoD.BlackMarketTableUtility[@"hash_25DDB72D0172A035"](f127_arg0, f127_arg1)
	if f127_local2 and not f127_local3 then
		return CoD.BlackMarketTableUtility.SimpleLootLookupTypes[@"loot"], false
	end
	local f127_local4, f127_local5 = CoD.BlackMarketTableUtility[@"hash_1214319EDB448F3B"](f127_arg0, f127_arg1)
	if f127_local4 and not f127_local5 then
		return CoD.BlackMarketTableUtility.SimpleLootLookupTypes[@"loot"], false
	end
	local f127_local6, f127_local7 = CoDShared.IsLootItemOwnedByNameSimple(f127_arg0, f127_arg1)
	if f127_local6 then
		return CoD.BlackMarketTableUtility.SimpleLootLookupTypes[@"loot"], f127_local7
	end
	local f127_local8 = CoD.BlackMarketTableUtility.GetStatsBasedUnlockId()
	local f127_local9 = f127_local8 and f127_local8[f127_arg1]
	if f127_local9 then
		local f127_local10 = function(f128_arg0)
			local f128_local0 = false
			if f128_arg0.storageFile and f128_arg0.path and #f128_arg0.path > 0 then
				local f128_local1 = Engine[@"storagegetbuffer"](f127_arg0, f128_arg0.storageFile)
				if f128_local1 then
					f128_local1 = LUI.getTableFromFieldList(f128_arg0.path, f128_local1)
				end
				if not f128_local1 or f128_local1:get() == 0 then
					f128_local0 = false
				else
					f128_local0 = true
				end
			elseif f128_arg0.itemOwned then
				f128_local0 = f128_arg0.itemOwned(f127_arg0)
			end
			local f128_local1 = true
			if f128_arg0.itemUnlockable then
				f128_local1 = f128_arg0.itemUnlockable()
			end
			if f128_local0 then
				if f128_arg0.notOwnedWhenUnavilable then
					f128_local0 = f128_local1
				else
					f128_local0 = true
				end
			end
			return f128_local0
		end
		local f127_local11 = false
		if f127_local9.linkedLootIds and #f127_local9.linkedLootIds > 0 then
			for f127_local15, f127_local16 in ipairs(f127_local9.linkedLootIds) do
				if f127_local10(f127_local8[f127_local16]) then
					f127_local11 = true
				end
			end
		else
			f127_local11 = f127_local10(f127_local9)
		end
		return CoD.BlackMarketTableUtility.SimpleLootLookupTypes[@"stat"], f127_local11
	elseif f127_arg2 and f127_arg2 ~= 0x0 then
		return CoD.BlackMarketTableUtility.SimpleLootLookupTypes[@"entitlement"], Engine[@"hasentitlement"](f127_arg0, f127_arg2)
	end
	return CoD.BlackMarketTableUtility.SimpleLootLookupTypes[@"none"], false
end
local f0_local0 = {
	isLoot = false,
	available = false,
	owned = false,
	rarity = @"invalid",
}
CoD.BlackMarketTableUtility.LootInfoLookup = function(f129_arg0, f129_arg1, f129_arg2, f129_arg3)
	if not f129_arg1 or f129_arg1 == 0x0 then
		return f0_local0
	end
	local f129_local0 = true
	if not IsBooleanDvarSet(@"loot_enableblackmarket") then
		f129_local0 = false
	end
	if CoD.isPC and CoD.PCKoreaUtility.ShowKorea15Plus() then
		local f129_local1 = Engine[@"tablelookup"](CoD.BlackMarketUtility.lootEmblemTableName, 3, 13, f129_arg1)
		if f129_local1 and f129_local1 ~= 0x0 then
			f129_arg1 = f129_local1
		else
			f129_local1 = Engine[@"tablelookup"](CoD.BlackMarketUtility.backgroundsTable, 3, 19, f129_arg1)
			if f129_local1 and f129_local1 ~= 0x0 then
				f129_arg1 = f129_local1
			end
		end
	end
	local f129_local1, f129_local2 = CoD.BlackMarketTableUtility[@"hash_762B0EE548400BF2"](f129_arg0, f129_arg1)
	if f129_local1 and not f129_local2 then
		return {
			isLoot = true,
			available = false,
			owned = false,
			rarity = @"invalid",
		}
	end
	local f129_local3, f129_local4 = CoD.BlackMarketTableUtility[@"hash_25DDB72D0172A035"](f129_arg0, f129_arg1)
	if f129_local3 and not f129_local4 then
		return {
			isLoot = true,
			available = false,
			owned = false,
			rarity = @"invalid",
		}
	end
	local f129_local5, f129_local6 = CoD.BlackMarketTableUtility[@"hash_1214319EDB448F3B"](f129_arg0, f129_arg1)
	if f129_local5 and not f129_local6 then
		return {
			isLoot = true,
			available = false,
			owned = false,
			rarity = @"invalid",
		}
	end
	local f129_local7 = CoDShared.LootIndexInfoLookup(f129_arg1, f129_arg3)
	if f129_local7 then
		local f129_local8 = {}
		local f129_local9 = f129_local7.table
		if f129_local9 == @"season" then
			local f129_local10 = CoD.BlackMarketTableUtility.GetSeasonInfoForPlayer(f129_arg0, f129_arg1, f129_local7.season, f129_local7.bundles, f129_arg3)
			if not f129_local10 then
				f129_local10 = f0_local0
			end
			return f129_local10
		elseif f129_local9 == @"contraband" then
			local f129_local10 = CoD.BlackMarketTableUtility.GetContrabandInfoForPlayer(f129_arg0, f129_arg1, f129_local7.bundles, f129_arg3)
			if not f129_local10 then
				f129_local10 = f0_local0
			end
			return f129_local10
		elseif f129_local9 == @"contract" then
			local f129_local10 = CoD.BlackMarketTableUtility.GetContractInfoForPlayer(f129_arg0, f129_arg1, f129_local7.bundles, f129_arg3)
			if not f129_local10 then
				f129_local10 = f0_local0
			end
			return f129_local10
		elseif f129_local9 == @"bonus" then
			local f129_local10 = CoD.BlackMarketTableUtility.GetBonusItemInfoForPlayer(f129_arg0, f129_arg1, f129_arg3)
			if not f129_local10 then
				f129_local10 = f0_local0
			end
			return f129_local10
		elseif f129_local9 == @"hash_731315EF3FB1AE07" then
			local f129_local10 = CoD.BlackMarketTableUtility.GetItemShopInfoForPlayer(f129_arg0, f129_arg1, f129_local7.bundles, f129_arg3)
			if f129_local10 then
				return f129_local10
			end
			local f129_local11 = CoD.BlackMarketTableUtility.GetBundleItemInfoForPlayer(f129_arg0, f129_arg1, f129_arg3)
			if not f129_local11 then
				f129_local11 = f0_local0
			end
			return f129_local11
		elseif f129_local9 == @"bundles" then
			local f129_local10 = CoD.BlackMarketTableUtility.GetBundleItemInfoForPlayer(f129_arg0, f129_arg1, f129_arg3)
			if not f129_local10 then
				f129_local10 = f0_local0
			end
			return f129_local10
		elseif f129_local9 == @"backfill" then
			local f129_local10 = CoD.BlackMarketTableUtility[0xC3056CABEF9D99](f129_arg1, f129_arg3)
			if not f129_local10 then
				f129_local10 = f0_local0
			end
			return f129_local10
		end
	end
	local f129_local8 = CoD.BlackMarketTableUtility.GetStatsBasedUnlockId()
	local f129_local9 = f129_local8 and f129_local8[f129_arg1]
	if f129_local9 then
		local f129_local10 = function(f130_arg0)
			local f130_local0 = false
			if f130_arg0.storageFile and f130_arg0.path and #f130_arg0.path > 0 then
				local f130_local1 = Engine[@"storagegetbuffer"](f129_arg0, f130_arg0.storageFile)
				if f130_local1 then
					f130_local1 = LUI.getTableFromFieldList(f130_arg0.path, f130_local1)
				end
				if not f130_local1 or f130_local1:get() == 0 then
					f130_local0 = false
				else
					f130_local0 = true
				end
			elseif f130_arg0.itemOwned then
				f130_local0 = f130_arg0.itemOwned(f129_arg0)
			end
			local f130_local1 = true
			if f130_arg0.itemUnlockable then
				f130_local1 = f130_arg0.itemUnlockable()
			end
			if f130_local0 then
				if f130_arg0.notOwnedWhenUnavilable then
					f130_local0 = f130_local1
				else
					f130_local0 = true
				end
			end
			local f130_local2 = ""
			if f130_local0 then
				if f130_arg0.unlockedStringRef then
					f130_local2 = Engine[@"hash_4F9F1239CFD921FE"](f130_arg0.unlockedStringRef)
				elseif f130_arg0.unlockedStringLookup then
					f130_local2 = f130_arg0.unlockedStringLookup()
				end
			elseif f130_local1 then
				if f130_arg0.lockedStringRef then
					f130_local2 = Engine[@"hash_4F9F1239CFD921FE"](f130_arg0.lockedStringRef)
				elseif f130_arg0.lockedStringLookup then
					f130_local2 = f130_arg0.lockedStringLookup()
				end
			end
			return {
				isLoot = true,
				available = f130_local0 or f130_local1,
				owned = f130_local0,
				rarity = @"invalid",
				unlockInfo = f130_local2,
				hideRarity = true,
				isStatsBasedUnlock = true,
				disableWhenAvailable = true,
			}
		end
		if f129_local9.linkedLootIds and #f129_local9.linkedLootIds > 0 then
			local f129_local11 = {
				isLoot = true,
				available = false,
				owned = false,
				rarity = @"invalid",
				unlockInfo = "",
				hideRarity = true,
				isStatsBasedUnlock = true,
				disableWhenAvailable = true,
			}
			for f129_local16, f129_local17 in ipairs(f129_local9.linkedLootIds) do
				local f129_local18 = f129_local10(f129_local8[f129_local17])
				local f129_local15 = f129_local11.available
				if not f129_local15 then
					f129_local15 = f129_local18.available
				end
				f129_local11.available = f129_local15
				f129_local15 = f129_local11.owned
				if not f129_local15 then
					f129_local15 = f129_local18.owned
				end
				f129_local11.owned = f129_local15
			end
			if f129_local11.owned then
				if f129_local9.unlockedStringRef then
					f129_local11.unlockInfo = Engine[@"hash_4F9F1239CFD921FE"](f129_local9.unlockedStringRef)
				elseif f129_local9.unlockedStringLookup then
					f129_local11.unlockInfo = f129_local9.unlockedStringLookup()
				end
			elseif f129_local11.available then
				if f129_local9.lockedStringRef then
					f129_local11.unlockInfo = Engine[@"hash_4F9F1239CFD921FE"](f129_local9.lockedStringRef)
				elseif f129_local9.lockedStringLookup then
					f129_local11.unlockInfo = f129_local9.lockedStringLookup()
				end
			end
			return f129_local11
		end
		return f129_local10(f129_local9)
	elseif f129_arg2 and f129_arg2 ~= 0x0 then
		return {
			isLoot = false,
			isEntitlement = true,
			owned = Engine[@"hasentitlement"](f129_arg0, f129_arg2),
			unlockInfo = Engine[@"hash_4F9F1239CFD921FE"](Engine[@"hash_2F9DAA00F0637292"](f129_arg2)),
		}
	end
	return {
		isLoot = false,
	}
end
CoD.BlackMarketTableUtility.TestLookupOfType = function()
	CoD.BlackMarketTableUtility.GetItemsOfType(0, @"calling_card")
end
CoD.BlackMarketTableUtility.GetItemsOfType = function(f132_arg0, f132_arg1)
	local f132_local0 = {}
	local f132_local1 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.ContrabandTable.name, CoD.BlackMarketTableUtility.ContrabandTable.COL_TYPE, f132_arg1)
	if f132_local1 ~= nil then
		for f132_local2 = 1, #f132_local1, 1 do
			local f132_local5 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ContrabandTable.name, f132_local1[f132_local2], CoD.BlackMarketTableUtility.ContrabandTable.COL_NAMEHASH)
			if f132_local5 ~= nil and f132_local5 ~= 0x0 then
				table.insert(f132_local0, f132_local5)
			end
		end
	end
	for f132_local10, f132_local11 in pairs(CoDShared.Loot.SeasonParams) do
		local f132_local5 = CoDShared.Loot.GetSeasonInfoParam(f132_local10, CoDShared.Loot.SEASON_INFO_TABLENAME)
		local f132_local12 = Engine[@"tablefindrows"](f132_local5, CoD.BlackMarketTableUtility.SeasonsTable.COL_TYPE, f132_arg1)
		if f132_local12 ~= nil then
			for f132_local6 = 1, #f132_local12, 1 do
				local f132_local9 = Engine[@"hash_4C6F8EC444864600"](f132_local5, f132_local12[f132_local6], CoD.BlackMarketTableUtility.SeasonsTable.COL_NAMEHASH)
				if f132_local9 ~= nil and f132_local9 ~= 0x0 then
					table.insert(f132_local0, f132_local9)
				end
			end
		end
	end
	for f132_local10, f132_local11 in pairs(CoD.BlackMarketTableUtility.ContractsTable.names) do
		local f132_local5 = Engine[@"tablefindrows"](f132_local11, CoD.BlackMarketTableUtility.ContractsTable.COL_TYPE, f132_arg1)
		if f132_local5 ~= nil then
			for f132_local12 = 1, #f132_local5, 1 do
				local f132_local13 = Engine[@"hash_4C6F8EC444864600"](f132_local11, f132_local5[f132_local12], CoD.BlackMarketTableUtility.ContractsTable.COL_NAMEHASH)
				if f132_local13 ~= nil and f132_local13 ~= 0x0 then
					table.insert(f132_local0, f132_local13)
				end
			end
		end
	end
	f132_local2 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.ItemShopTable.name, CoD.BlackMarketTableUtility.ItemShopTable.COL_TYPE, f132_arg1)
	if f132_local2 ~= nil then
		for f132_local3 = 1, #f132_local2, 1 do
			local f132_local12 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.ItemShopTable.name, f132_local2[f132_local3], CoD.BlackMarketTableUtility.ItemShopTable.COL_NAMEHASH)
			if f132_local12 ~= nil and f132_local12 ~= 0x0 then
				table.insert(f132_local0, f132_local12)
			end
		end
	end
	f132_local3 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.LootBonusTable.name, CoD.BlackMarketTableUtility.LootBonusTable.COL_TYPE, f132_arg1)
	if f132_local3 ~= nil then
		for f132_local4 = 1, #f132_local3, 1 do
			local f132_local6 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.LootBonusTable.name, f132_local3[f132_local4], CoD.BlackMarketTableUtility.LootBonusTable.COL_NAMEHASH)
			if f132_local6 ~= nil and f132_local6 ~= 0x0 then
				table.insert(f132_local0, f132_local6)
			end
		end
	end
	f132_local4 = Engine[@"tablefindrows"](CoD.BlackMarketTableUtility.BundleTable.name, CoD.BlackMarketTableUtility.BundleTable.COL_TYPE, f132_arg1)
	if f132_local4 ~= nil then
		for f132_local10 = 1, #f132_local4, 1 do
			local f132_local7 = Engine[@"hash_4C6F8EC444864600"](CoD.BlackMarketTableUtility.BundleTable.name, f132_local4[f132_local10], CoD.BlackMarketTableUtility.BundleTable.COL_NAMEHASH)
			if f132_local7 ~= nil and f132_local7 ~= 0x0 then
				table.insert(f132_local0, f132_local7)
			end
		end
	end
	return f132_local0
end
