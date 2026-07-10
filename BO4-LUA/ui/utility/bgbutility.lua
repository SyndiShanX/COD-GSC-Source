CoD.BGBUtility = {}
CoD.BGBUtility.NumBuffsPerPack = 4
CoD.BGBUtility.NumPacks = 10
CoD.BGBUtility.ElixirCarouselMaxCount = 4
CoD.BGBUtility.BGBCarouselStates = LuaEnum.createEnum("AVAILABLE", "ACTIVE", "COOLING_DOWN", "ZERO_LOCKED_DOWN")
CoD.BGBUtility.N_SETTING_CRAWLER_STATE_OFF = 0
CoD.BGBUtility.N_ENUM_MBOX_OFF = 0
CoD.BGBUtility.N_SETTING_PACK_OFF = 0
CoD.BGBUtility.N_SETTING_FIXED_POINTS_ON = 1
CoD.BGBUtility.N_SETTING_LAST_STAND_DURATION_OFF = 0
CoD.BGBUtility.ElixirToEnumGameSettingsHash = {
	[0x612800A12B44CD1] = {
		{
			hash = 0x946034AF4372F2D,
			restrictedValue = CoD.BGBUtility.N_SETTING_CRAWLER_STATE_OFF,
		},
	},
	[0xD4A36921F5E48F0] = {
		{
			hash = 0xE0EC3FE56F08B47,
			restrictedValue = CoD.BGBUtility.N_ENUM_MBOX_OFF,
		},
	},
	[0x3884A663FDDDBE3] = {
		{
			hash = 0x9D48A0D4490B0A2,
			restrictedValue = CoD.BGBUtility.N_SETTING_PACK_OFF,
		},
	},
	[0x65C22731C18755C] = {
		{
			hash = 0x9D48A0D4490B0A2,
			restrictedValue = CoD.BGBUtility.N_SETTING_PACK_OFF,
		},
	},
	[0x6C1AB5011A1A011] = {
		{
			hash = 0x735A88A32111A1B,
			restrictedValue = CoD.BGBUtility.N_SETTING_FIXED_POINTS_ON,
		},
	},
	[0x458181EB9DBDE8B] = {
		{
			hash = 0x735A88A32111A1B,
			restrictedValue = CoD.BGBUtility.N_SETTING_FIXED_POINTS_ON,
		},
	},
	[0x9627DB608C66755] = {
		{
			hash = 0x735A88A32111A1B,
			restrictedValue = CoD.BGBUtility.N_SETTING_FIXED_POINTS_ON,
		},
	},
	[0xEBE3A344FB54080] = {
		{
			hash = 0x517C36D49B4EE0,
			restrictedValue = CoD.BGBUtility.N_SETTING_LAST_STAND_DURATION_OFF,
		},
	},
}
CoD.BGBUtility.ElixirToBooleanGameSettingsHash = {
	[0xFD9EDD393FF4F8E] = {
		0x4006DAC21EA0736,
	},
	[0xD8BD1B24A9B47B] = {
		0x230EF2B089AAD7F,
	},
	[0xC763205EFEC59BD] = {
		0xCE5566DDE9ED686,
		0xB066C34278E6394,
	},
	[0xFE8B03A7EA470C2] = {
		0xA534A2A0F3EEDD3,
	},
	[0x19263062D36917F] = {
		0xEE97A6AB720CC15,
	},
	[0x347CB0CB814CCA8] = {
		0xF82E568F5E2C04F,
	},
	[0xBEB425CD6F858A2] = {
		0xA8EE5887F138E39,
	},
	[0xA5F7D0F1A62B2F7] = {
		0xFECDAEC6642D3BA,
	},
	[0x4793A347BD97CD3] = {
		0xAA214604D696F70,
		0x386CAA315211C88,
	},
	[0x67C8B57DAA18922] = {
		0x1F269AB6574B3BD,
	},
	[0x612800A12B44CD1] = {
		0x9B95E3BA4D2D2F8,
	},
	[0xE494EA245B6BE52] = {
		0x929DD7083C365C5,
		0x16DB8C2D7FCACFB,
	},
	[0x22BD6CA7FF53DEE] = {
		0x14AA3CB07D2C0DB,
		0x98A7F96C03E4B77,
	},
	[0x77EA318753F5418] = {
		0xD490D5A824C0D83,
		0xBF54DA23EF8887B,
		0x98A7F96C03E4B77,
	},
	[0x6C1AB5011A1A011] = {
		0xAFF42262B4EEE32,
	},
	[0xD4F013AD65B6E27] = {
		0xA7BD9C02B9FCE98,
		0x16DB8C2D7FCACFB,
	},
	[0xD5E188BC784884C] = {
		0xCA897D3295F6257,
		0xA6F8EC0657F1F69,
		0x98A7F96C03E4B77,
	},
	[0x5A9D6022E571C6] = {
		0x197061EC31DC27D,
		0x1BEC0AD87D8E7C0,
		0x98A7F96C03E4B77,
		0x386CAA315211C88,
	},
	[0xBBB25554D3F7F6B] = {
		0xDADB18509506169,
	},
	[0x9627DB608C66755] = {
		0x16D4768994B25A5,
		0x1F07A0F9F9155F1,
		0x98A7F96C03E4B77,
	},
	[0xFE59430E1D71B6C] = {
		0x6468DE196046E72,
	},
	[0x458181EB9DBDE8B] = {
		0xDDF4EED89A60B8E,
		0xBF54DA23EF8887B,
		0x98A7F96C03E4B77,
	},
	[0xAB718D345FF910] = {
		0x72581CAB09B5C9F,
		0xD385A15A00AD7F7,
		0x98A7F96C03E4B77,
	},
	[0x2DA92422E3EA7D1] = {
		0xD1FB9161DDDF722,
		0xD18F84F48BD5D1F,
	},
	[0x953696819BF1875] = {
		0xA779251EF8C8568,
	},
	[0xB69B008E289DED4] = {
		0xAE3C77E1EBDC90D,
	},
	[0x9FFE1C3C96379] = {
		0x60C19249D1B9390,
		0xB6F66A1418EE8EC,
		0x98A7F96C03E4B77,
	},
	[0xD4A36921F5E48F0] = {
		0x8A2CAB12F0C5A89,
		0xB357404957E850B,
		0x98A7F96C03E4B77,
	},
	[0xEBE3A344FB54080] = {
		0x3AC6983716EB72B,
	},
	[0xE31B245BDE5C7FC] = {
		0xDD3D19705899DBD,
		0xB066C34278E6394,
		0xB69E8F8CBC6A4FF,
		0x98A7F96C03E4B77,
	},
	[0x4496E1B656C6651] = {
		0xE84A4012DDF8A24,
	},
	[0xD13857AEB37FE53] = {
		0x7FF67C16576E231,
	},
	[0x913B5E2900CDF3F] = {
		0x6DF1564C342C831,
		0xD18F84F48BD5D1F,
	},
	[0x3884A663FDDDBE3] = {
		0x3D900F7B3D14128,
		0x1A2CF319E12D9AE,
	},
	[0xC80DF83E002A4D6] = {
		0xA0DB64BB19E18AF,
	},
	[0x8932D2054C58CD0] = {
		0xA9E56AE10CF58C9,
		0x5A1298089D361F1,
	},
	[0x7822C558A509DE9] = {
		0x792079610DFAC24,
	},
	[0x9376AB9D627E38A] = {
		0xE98C2376CACD382,
	},
	[0xA303F67AFD6F4A8] = {
		0xB83ACFD4B361E44,
	},
	[0x60CA45C0A2DAEF2] = {
		0xEDB895E9D0880F9,
	},
	[0x6D3DF5058C56523] = {
		0xD9DDFA547EC765E,
		0x5A1D440F78A3B2,
	},
	[0xA6B297C85FAFEC1] = {
		0x5118B5F6D97C89A,
		0x1A2CF319E12D9AE,
	},
	[0x6F5A81348E35487] = {
		0xB30109CD344258E,
		0xD18F84F48BD5D1F,
	},
	[0x65C22731C18755C] = {
		0x48716023024B395,
		0x98A7F96C03E4B77,
	},
	[0x242C2A18CEA5E1] = {
		0xEEF480BD7662082,
	},
	[0xFD8F0866DBEDA28] = {
		0x6436F50FAF41689,
	},
	[0x3F12A7EBB3E91AC] = {
		0x65BA2184C27828F,
	},
	[0xFF20DC353CEB63] = {
		0x6700855B131A427,
	},
	[0x9EAEF177AABC815] = {
		0xB74D1759BD25756,
	},
	[0x455490B99D4CBBB] = {
		0x76D5E7BFFCF1E3D,
	},
	[0x2E9E5C5026C2620] = {
		0xBEC3890EA83D709,
	},
	[0xD13857AEB37FE53] = {
		0x7FF67C16576E231,
	},
	[0x98BD245E259C64F] = {
		0xB0BEFCBAC8AEDE6,
		0x98A7F96C03E4B77,
	},
	[0x7FB40C4D855E7AF] = {
		0x5AABD057794561C,
	},
	[0xEBE3A344FB54080] = {
		0x3AC6983716EB72B,
	},
	[0xF8DD5E57E340A94] = {
		0x4E500E1B323DAF7,
		0x98A7F96C03E4B77,
	},
	[0x28619E07BF4DED1] = {
		0x821E81969996ECE,
		0x1A2CF319E12D9AE,
	},
}
DataSources.BGBCarousel = DataSourceHelpers.CustomListSetup(
	"BGBCarousel",
	function(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4)
		local f1_local0 = DataSources.ZMHud.getModel(f1_arg1)
		f1_local0 = f1_local0:create("bgb_carousel")
		local f1_local1 = 1
		for f1_local2 = 0, CoD.BGBUtility.ElixirCarouselMaxCount - 1, 1 do
			local f1_local5 = f1_local0:create(f1_local2)
			local f1_local6 = f1_local5:create("gum_idx")
			local f1_local7 = f1_local5:create("script_idx")
			f1_local7:set(f1_local2)
			f1_local7 = f1_local5:create("selected")
			f1_local7:set(false)
			if f1_local6:get() ~= 0 then
				table.insert(f1_arg3, {
					model = f1_local5,
				})
			end
			if not f1_arg0._carouselSubscription then
				f1_arg0:subscribeToModel(f1_local5:create("gum_idx"), function(model, f2_arg1)
					f2_arg1:updateDataSource()
				end, false)
			end
		end
	end,
	false,
	{
		getModel = function(f3_arg0)
			if not DataSources.BGBCarousel._cachedModels then
				DataSources.BGBCarousel._cachedModels = {}
			end
			if not DataSources.BGBCarousel._cachedModels[f3_arg0] then
				local f3_local0 = DataSources.ZMHud.getModel(f3_arg0)
				DataSources.BGBCarousel._cachedModels[f3_arg0] = f3_local0:create("bgb_carousel")
			end
			return DataSources.BGBCarousel._cachedModels[f3_arg0]
		end,
	}
)
CoD.BGBUtility.CooldownToWideDelta = function(f4_arg0, f4_arg1, f4_arg2, f4_arg3)
	return 1 - f4_arg0, 1, 0, 0
end
CoD.BGBUtility.LimitToRangeWithPlus = function(f5_arg0, f5_arg1, f5_arg2)
	if type(f5_arg2) == "string" then
		f5_arg2 = tonumber(f5_arg2)
	end
	if f5_arg2 < f5_arg0 then
		return f5_arg0
	elseif f5_arg2 <= f5_arg1 then
		return f5_arg2
	else
		return Engine[0xF9F1239CFD921FE](0xA1D8A7F0E7B0EFF, f5_arg1)
	end
end
CoD.BGBUtility.IsBGBConsumableInGame = function(f6_arg0, f6_arg1)
	local f6_local0 = CoD.BaseUtility.GetMenuSessionMode(f6_arg0)
	local f6_local1 = f6_arg1:getModel()
	if f6_local1 and f6_local1.gum_idx then
		local f6_local2 = f6_local1.gum_idx:get()
		if f6_local2 and CoD.CACUtility.EmptyItemIndex < f6_local2 then
			return CoD.CACUtility.IsItemConsumable(f6_local2, Enum[0x6EB546760F890D2][0x48CD0338EE0B3AE], f6_local0)
		end
	end
	return false
end
CoD.BGBUtility.SetupBGBConsumableCounts = function(f7_arg0, f7_arg1, f7_arg2)
	local f7_local0 = f7_arg1:getModel()
	local f7_local1 = f7_local0 and f7_local0.gum_idx
	if not f7_local1 then
		return
	else
		local f7_local2 = CoD.CACUtility.GetConsumableCountFromIndex(f7_arg0, f7_arg2, Enum[0x6EB546760F890D2][0x48CD0338EE0B3AE], f7_local1:get())
		local f7_local3 = f7_local0:create("count")
		f7_local3:set(f7_local2)
	end
end
CoD.BGBUtility.UpdateBGBConsumableCounts = function(f8_arg0, f8_arg1, f8_arg2)
	local f8_local0 = f8_arg2:getModel()
	local f8_local1 = f8_local0 and f8_local0.gum_idx
	if not f8_local1 then
		return
	end
	local f8_local2 = CoD.GetScriptNotifyData(f8_arg1)
	if f8_local2[1] ~= f8_local1:get() then
		return
	end
	local f8_local3 = f8_local0.count
	if f8_local3 then
		f8_local3 = f8_local0.count:get()
	end
	if not f8_local3 then
		return
	end
	f8_local0.count:set(f8_local3 - 1)
end
CoD.BGBUtility.CreateBGBCarouselModels = function(f9_arg0)
	local f9_local0 = Engine[0x4DF5CFBC1771947](f9_arg0)
	for f9_local1 = 0, CoD.BGBUtility.ElixirCarouselMaxCount - 1, 1 do
		f9_local0:create("zmhud.bgb_carousel." .. f9_local1 .. ".count")
	end
end
CoD.BGBUtility.IsBGBDisabled = function(f10_arg0, f10_arg1)
	local f10_local0 = f10_arg1:getModel()
	if f10_local0 and (not (not f10_local0.unavailable or f10_local0.unavailable:get() ~= 1) or f10_local0.state and f10_local0.state:get() == CoD.BGBUtility.BGBCarouselStates.ZERO_LOCKED_DOWN) then
		return true
	else
		return false
	end
end
