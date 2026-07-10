CoD.CoDAccountUtility = {
	month_days = {
		31,
		28,
		31,
		30,
		31,
		30,
		31,
		31,
		30,
		31,
		30,
		31,
	},
	country_list = {
		{
			display_string = 0x221B670A76DC6D4,
			code = "US",
			min_age = 17,
		},
		{
			display_string = 0x1DDA470A733DB72,
			code = "AU",
			min_age = 18,
		},
		{
			display_string = 0x1DDA570A733DD25,
			code = "AT",
			min_age = 18,
		},
		{
			display_string = 0x1E09470A735F619,
			code = "BE",
			min_age = 18,
		},
		{
			display_string = 0x1E0A570A73612FC,
			code = "BR",
			min_age = 18,
		},
		{
			display_string = 0x1E4BC70A73A22E8,
			code = "CA",
			min_age = 17,
		},
		{
			display_string = 0x1E4A770A739FF39,
			code = "CZ",
			min_age = 18,
		},
		{
			display_string = 0x1E79E70A73C25C5,
			code = "DK",
			min_age = 18,
		},
		{
			display_string = 0x1EEB870A74270A1,
			code = "FI",
			min_age = 18,
		},
		{
			display_string = 0x1EE9D70A74242C0,
			code = "FR",
			min_age = 18,
		},
		{
			display_string = 0x1E7A070A73C292B,
			code = "DE",
			min_age = 18,
		},
		{
			display_string = 0x1F19770A7446E65,
			code = "GB",
			min_age = 18,
		},
		{
			display_string = 0x1F1A770A7448995,
			code = "GR",
			min_age = 18,
		},
		{
			display_string = 0x1F5B070A74881B7,
			code = "HU",
			min_age = 18,
		},
		{
			display_string = 0x1F8A470A74AA32A,
			code = "IE",
			min_age = 18,
		},
		{
			display_string = 0x1F8B570A74AC00D,
			code = "IT",
			min_age = 18,
		},
		{
			display_string = 0x1FBB770A74CF94A,
			code = "JP",
			min_age = 18,
		},
		{
			display_string = 0x206B170A756F69D,
			code = "MX",
			min_age = 18,
		},
		{
			display_string = 0x2099B70A7590712,
			code = "NL",
			min_age = 18,
		},
		{
			display_string = 0x209A570A7591810,
			code = "NZ",
			min_age = 18,
		},
		{
			display_string = 0x2099A70A759055F,
			code = "NO",
			min_age = 18,
		},
		{
			display_string = 0x210B770A75F5554,
			code = "PL",
			min_age = 18,
		},
		{
			display_string = 0x2109F70A75F2C8C,
			code = "PT",
			min_age = 18,
		},
		{
			display_string = 0x1EAB670A73E8464,
			code = "ES",
			min_age = 18,
		},
		{
			display_string = 0x21AA070A76782C4,
			code = "SE",
			min_age = 18,
		},
		{
			display_string = 0x1E4B570A73A1703,
			code = "CH",
			min_age = 18,
		},
		{
			display_string = 0x232AD70A77C2ABC,
			code = "ZZ",
			min_age = 18,
		},
	},
	error_codes = {
		[Enum[0x7DEA32672263479][0x949EF8AE1EF744D]] = 0xA1F937DB15A3B0,
		[Enum[0x7DEA32672263479][0x873D7B3BBF26D5F]] = 0x3A921CAC932CB70,
		[Enum[0x7DEA32672263479][0x6105A35930005B5]] = 0x1436D88D3723F92,
		[Enum[0x7DEA32672263479][0xB84C61C4FB6633E]] = 0x48D6F4B4570581,
		[Enum[0x7DEA32672263479][0x2350A1E27733A64]] = 0x9CAD36D58F37A57,
		[Enum[0x7DEA32672263479][0x6BEBB390401FF5D]] = 0xCAA4672E3E3FB28,
		[Enum[0x7DEA32672263479][0x9A4D049CC5D378B]] = 0xD7B1C0C122A3972,
	},
	MINIMUM_DOB_YEAR = 1900,
}
require("x64:f3c5259f470592d")
CoD.CoDAccountUtility.LegalInfo = {}
CoD.CoDAccountUtility.LegalInfo.PrivacyPolicyPages = {
	0xA6E8C6E6E9C365C,
	0xA6E8F6E6E9C3B75,
	0xA6E8E6E6E9C39C2,
	0xA6E896E6E9C3143,
	0xA6E886E6E9C2F90,
	0xA6E8B6E6E9C34A9,
	0xA6E8A6E6E9C32F6,
	0xA6E956E6E9C45A7,
	0xA6E946E6E9C43F4,
	0xA6B076E6E991E86,
	0xA6B086E6E992039,
	0xA6B056E6E991B20,
	0xA6B066E6E991CD3,
	0xA6B0B6E6E992552,
	0xA6B0C6E6E992705,
	0xA6B096E6E9921EC,
	0xA6B0A6E6E99239F,
	0xA6B0F6E6E992C1E,
	0xA6B106E6E992DD1,
	0xA67A16E6E963B5D,
	0xA67A06E6E9639AA,
	0xA679F6E6E9637F7,
	0xA679E6E6E963644,
	0xA679D6E6E963491,
}
CoD.CoDAccountUtility.LegalInfo.TermsOfUsePages = {
	0x3CD5B1D0E23B412,
	0x3CD5A1D0E23B25F,
	0x3CD591D0E23B0AC,
	0x3CD581D0E23AEF9,
	0x3CD571D0E23AD46,
	0x3CD561D0E23AB93,
	0x3CD551D0E23A9E0,
	0x3CD641D0E23C35D,
	0x3CD631D0E23C1AA,
	0x3C9D61D0E209C3C,
	0x3C9D71D0E209DEF,
	0x3C9D81D0E209FA2,
	0x3C9D91D0E20A155,
	0x3C9D21D0E209570,
	0x3C9D31D0E209723,
	0x3C9D41D0E2098D6,
	0x3C9D51D0E209A89,
	0x3C9DE1D0E20A9D4,
	0x3C9DF1D0E20AB87,
	0x3D3E81D0E290F57,
	0x3D3E71D0E290DA4,
	0x69C1487C7EF1E10,
	0x3D3EA1D0E2912BD,
	0x3D3E91D0E29110A,
	0x3D3E41D0E29088B,
	0x3D3E31D0E2906D8,
	0x3D3E61D0E290BF1,
	0x3D3E51D0E290A3E,
	0x3D3E01D0E2901BF,
	0x3D3DF1D0E29000C,
	0x3D0E21D0E26CF4E,
	0x3D0E31D0E26D101,
	0x3D0E01D0E26CBE8,
	0x3D0E11D0E26CD9B,
	0x3D0E61D0E26D61A,
	0x3D0E71D0E26D7CD,
	0x3D0E41D0E26D2B4,
	0x3D0E51D0E26D467,
	0x3D0DA1D0E26C1B6,
	0x3D0DB1D0E26C369,
	0x3BFE41D0E185F81,
}
CoD.CoDAccountUtility.LegalInfo.LegalInfoAdditionalInfo = {
	PrivacyPolicyPages = {
		title = 0x31DD2217B304F92,
	},
	TermsOfUsePages = {
		title = 0x122F19BFE1C1698,
	},
}
CoD.CoDAccountUtility.IsLeapYear = function(f1_arg0)
	local f1_local0
	if f1_arg0 % 400 ~= 0 and (f1_arg0 % 4 ~= 0 or f1_arg0 % 100 <= 0) then
		f1_local0 = false
	else
		f1_local0 = true
	end
	return f1_local0
end
CoD.CoDAccountUtility.GetDaysInMonth = function(f2_arg0, f2_arg1)
	local f2_local0 = CoD.CoDAccountUtility.month_days[f2_arg0]
	if f2_arg0 == 2 and CoD.CoDAccountUtility.IsLeapYear(f2_arg1) then
		f2_local0 = f2_local0 + 1
	end
	return f2_local0
end
CoD.CoDAccountUtility.GetDaysInCurrentMonth = function(f3_arg0)
	local f3_local0 = DataSources.CODAccountRegistrationForm.getModel(f3_arg0)
	local f3_local1 = f3_local0.dobYear:get()
	local f3_local2 = DataSources.CODAccountRegistrationForm.getModel(f3_arg0)
	return CoD.CoDAccountUtility.GetDaysInMonth(f3_local2.dobMonth:get(), f3_local1)
end
CoD.CoDAccountUtility.SetupEditBoxControlRegistration = function(f4_arg0, f4_arg1, f4_arg2, f4_arg3, f4_arg4, f4_arg5)
	local f4_local0 = Engine[0x40E824FE270E174](DataSources.CODAccountRegistrationForm.getModel(f4_arg2), f4_arg4)
	if not f4_local0:get() then
		f4_local0:set("")
	end
	CoD.PCUtility.SetupEditControlWithModel(f4_arg1.CurrentText, f4_arg2, f4_arg3, f4_local0, nil, nil, f4_arg5)
	if f4_arg5 then
		CoD.PCUtility.SetElementEditBoxMaxChar(f4_arg1.CurrentText, 20)
	end
end
CoD.CoDAccountUtility.SetupEditBoxControlSignIn = function(f5_arg0, f5_arg1, f5_arg2, f5_arg3, f5_arg4, f5_arg5)
	local f5_local0 = Engine[0x40E824FE270E174](DataSources.CODAccountSignInForm.getModel(f5_arg2), f5_arg4)
	if not f5_local0:get() then
		f5_local0:set("")
	end
	CoD.PCUtility.SetupEditControlWithModel(f5_arg1.CurrentText, f5_arg2, f5_arg3, f5_local0, nil, nil, f5_arg5)
	if f5_arg5 then
		CoD.PCUtility.SetElementEditBoxMaxChar(f5_arg1.CurrentText, 20)
	end
end
CoD.CoDAccountUtility.IsSignInRequired = function(f6_arg0)
	if f6_arg0 then
		return f6_arg0._signInRequired or false
	else
		return false
	end
end
DataSources.CODAccountSignInForm = {
	getModel = function(f7_arg0)
		local f7_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f7_arg0), "CODAccountSignInForm")
		if f7_local0 == nil then
			f7_local0 = Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f7_arg0), "CODAccountSignInForm")
			Engine[0xA798E4552F5E872](f7_local0, "emailAddress")
			Engine[0xA798E4552F5E872](f7_local0, "password")
			Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f7_local0, "confirmSpam"), false)
			Engine[0xA798E4552F5E872](f7_local0, "hintText")
		end
		return f7_local0
	end,
}
DataSources.CODAccountRegistrationForm = {
	getModel = function(f8_arg0)
		local f8_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f8_arg0), "CODAccountRegistrationForm")
		if f8_local0 == nil then
			f8_local0 = Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f8_arg0), "CODAccountRegistrationForm")
			Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f8_local0, "regionIndex"), 1)
			Engine[0xA798E4552F5E872](f8_local0, "emailAddress")
			Engine[0xA798E4552F5E872](f8_local0, "password")
			Engine[0xA798E4552F5E872](f8_local0, "confPassword")
			local f8_local1 = Engine[0x6BA9980BA648FB3](f8_arg0)
			local f8_local2 = f8_local1.Year or 2000
			local f8_local3 = f8_local1.Month or 1
			local f8_local4 = f8_local1.Day or 1
			Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f8_local0, "dobYear"), f8_local2)
			Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f8_local0, "dobMonth"), f8_local3)
			Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f8_local0, "dobDay"), f8_local4)
			Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f8_local0, "confirmTOU"), false)
			Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f8_local0, "confirmSpam"), false)
			Engine[0xA798E4552F5E872](f8_local0, "hintText")
		end
		return f8_local0
	end,
}
DataSources.UNOAccountInfo = {
	getModel = function(f9_arg0)
		local f9_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f9_arg0), "UNOAccountInfo")
		if f9_local0 == nil then
			f9_local0 = Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f9_arg0), "UNOAccountInfo", true)
			Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f9_local0, "bOptedIn"), false)
			Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f9_local0, "bCheckedSubscriptions"), false)
			Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f9_local0, "bSignedIn"), false)
			Engine[0xA798E4552F5E872](f9_local0, "iBusyStatus")
			Engine[0xA798E4552F5E872](f9_local0, "iTransactionResult")
		end
		return f9_local0
	end,
}
DataSources.CODAccountManagementForm = {
	getModel = function(f10_arg0)
		local f10_local0 = Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f10_arg0), "CODAccountManagementForm")
		if f10_local0 == nil then
			f10_local0 = Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f10_arg0), "CODAccountManagementForm")
			Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](f10_local0, "optInStatus"), Engine[0x655C38BC12A1FCB](f10_arg0))
			Engine[0xA798E4552F5E872](f10_local0, "hintText")
		end
		return f10_local0
	end,
}
DataSources.CODAccountLegalInfo = {
	getModel = function(f11_arg0)
		local f11_local0 = Engine[0x4DF5CFBC1771947](f11_arg0)
		f11_local0 = f11_local0:create("CODAccountLegalInfo")
		f11_local0:create("currentLegalInfoIndex")
		f11_local0:create("currentLegalInfoText")
		f11_local0:create("currentLegalInfoReference")
		f11_local0:create("currentLegalTitle")
		return f11_local0
	end,
}
CoD.CoDAccountUtility.packageOptionsButtonData = function(f12_arg0, f12_arg1, f12_arg2, f12_arg3, f12_arg4, f12_arg5)
	return {
		models = {
			displayText = f12_arg0,
			description = f12_arg1,
			currentText = f12_arg2,
		},
		properties = {
			action = f12_arg3,
			actionParam = f12_arg4,
			disabled = f12_arg5 or false,
		},
	}
end
CoD.CoDAccountUtility.packageNumOptionsButtonData = function(f13_arg0, f13_arg1, f13_arg2, f13_arg3, f13_arg4)
	return {
		models = {
			displayText = f13_arg0,
			description = f13_arg1,
			currentNum = f13_arg2,
		},
		properties = {
			minusFn = f13_arg3,
			plusFn = f13_arg4,
		},
	}
end
DataSources.CODAccountRegisterOptions = ListHelper_SetupDataSource("CODAccountRegisterOptions", function(f14_arg0, f14_arg1)
	local f14_local0 = {}
	local f14_local1 = function(f15_arg0, f15_arg1, f15_arg2, f15_arg3, f15_arg4)
		if CoD.isPC then
			OpenOverlay(f15_arg4, "PC_StartMenu_Options_CoDAccount_SignIn", f15_arg2, {
				_signInRequired = CoD.CoDAccountUtility.IsSignInRequired(f15_arg4),
			})
		else
			OpenOverlay(f15_arg4, "StartMenu_Options_CoDAccount_SignIn", f15_arg2, {
				_signInRequired = CoD.CoDAccountUtility.IsSignInRequired(f15_arg4),
			})
		end
	end
	local f14_local2 = function(f16_arg0, f16_arg1, f16_arg2, f16_arg3, f16_arg4)
		if CoD.isPC then
			OpenOverlay(f16_arg4, "PC_StartMenu_Options_CoDAccount_NewAccount", f16_arg2, {
				_signInRequired = CoD.CoDAccountUtility.IsSignInRequired(f16_arg4),
			})
		else
			OpenOverlay(f16_arg4, "StartMenu_Options_CoDAccount_NewAccount", f16_arg2, {
				_signInRequired = CoD.CoDAccountUtility.IsSignInRequired(f16_arg4),
			})
		end
	end
	local f14_local3 = function(f17_arg0, f17_arg1, f17_arg2, f17_arg3, f17_arg4)
		if CoD.CoDAccountUtility.IsSignInRequired(f17_arg4) then
			OpenSystemOverlay(f17_arg0, f17_arg4, f17_arg2, "CancelTrialSignIn")
		else
			GoBack(f17_arg0, f17_arg2)
		end
	end
	local f14_local4 = table.insert
	local f14_local5 = f14_local0
	local f14_local6 = CoD.CoDAccountUtility.packageOptionsButtonData
	local f14_local7 = 0x34AB4709B1FA9DB
	local f14_local8 = ""
	local f14_local9 = nil
	local f14_local10 = f14_local1
	local f14_local11 = nil
	local f14_local12 = Engine[0x4A9D1DAC0556BB1](f14_arg0)
	if f14_local12 then
		f14_local12 = not CoD.CoDAccountUtility.IsSignInRequired(f14_arg1.menu)
	end
	f14_local4(f14_local5, f14_local6(f14_local7, f14_local8, f14_local9, f14_local10, f14_local11, f14_local12))
	f14_local4 = table.insert
	f14_local5 = f14_local0
	f14_local6 = CoD.CoDAccountUtility.packageOptionsButtonData
	f14_local7 = 0x213ADAB54C482D0
	f14_local8 = ""
	f14_local9 = nil
	f14_local10 = f14_local2
	f14_local11 = nil
	if Engine[0x4A9D1DAC0556BB1](f14_arg0) or not Engine[0x76FF6D4801A4507](f14_arg0) then
		f14_local12 = not CoD.CoDAccountUtility.IsSignInRequired(f14_arg1.menu)
	else
		f14_local12 = false
	end
	f14_local4(f14_local5, f14_local6(f14_local7, f14_local8, f14_local9, f14_local10, f14_local11, f14_local12))
	table.insert(f14_local0, CoD.CoDAccountUtility.packageOptionsButtonData(CoD.CoDAccountUtility.IsSignInRequired(f14_arg1.menu) and 0xFD0A4EC72EF5F3F or 0xC2E92C54C2BE289, "", nil, f14_local3))
	return f14_local0
end, true)
DataSources.CODAccountSignInInfoBasic = ListHelper_SetupDataSource("CODAccountSignInInfoBasic", function(f18_arg0)
	local f18_local0 = {}
	local f18_local1 = function(f19_arg0, f19_arg1, f19_arg2, f19_arg3, f19_arg4)
		ShowKeyboard(f19_arg0, f19_arg1, f19_arg2, "KEYBOARD_TYPE_EMAIL")
	end
	local f18_local2 = function(f20_arg0, f20_arg1, f20_arg2, f20_arg3, f20_arg4)
		ShowKeyboard(f20_arg0, f20_arg1, f20_arg2, "KEYBOARD_TYPE_PASSWORD")
	end
	table.insert(f18_local0, CoD.CoDAccountUtility.packageOptionsButtonData(0x1770F1CA89E2DE5, 0x3C9CB1D8A997FD1, "", f18_local1))
	table.insert(f18_local0, CoD.CoDAccountUtility.packageOptionsButtonData(0xA50C91C923FBBF6, 0x4D3F2D796BAF968, "", f18_local2))
	return f18_local0
end, true)
DataSources.CODAccountRegisterInfoBasic = ListHelper_SetupDataSource("CODAccountRegisterInfoBasic", function(f21_arg0)
	local f21_local0 = {}
	local f21_local1 = function(f22_arg0, f22_arg1, f22_arg2, f22_arg3, f22_arg4)
		ShowKeyboard(f22_arg0, f22_arg1, f22_arg2, "KEYBOARD_TYPE_REGISTER_EMAIL")
	end
	local f21_local2 = function(f23_arg0, f23_arg1, f23_arg2, f23_arg3, f23_arg4)
		ShowKeyboard(f23_arg0, f23_arg1, f23_arg2, "KEYBOARD_TYPE_REGISTER_PASSWORD")
	end
	local f21_local3 = function(f24_arg0, f24_arg1, f24_arg2, f24_arg3, f24_arg4)
		ShowKeyboard(f24_arg0, f24_arg1, f24_arg2, "KEYBOARD_TYPE_CONFIRM_PASSWORD")
	end
	table.insert(f21_local0, CoD.CoDAccountUtility.packageOptionsButtonData(0x1770F1CA89E2DE5, 0x38D108F675E74EF, "", f21_local1))
	table.insert(f21_local0, CoD.CoDAccountUtility.packageOptionsButtonData(0xA50C91C923FBBF6, 0x91EDCCE05D39D06, "", f21_local2))
	table.insert(f21_local0, CoD.CoDAccountUtility.packageOptionsButtonData(0xC77EF01F8EFB323, 0x1086AB2243296F5, "", f21_local3))
	return f21_local0
end, true)
DataSources.CODAccountRegisterInfoDob = ListHelper_SetupDataSource("CODAccountRegisterInfoDob", function(f25_arg0)
	local f25_local0 = {}
	local f25_local1 = function(f26_arg0, f26_arg1)
		local f26_local0 = DataSources.CODAccountRegistrationForm.getModel(f26_arg0)
		local f26_local1 = f26_local0.dobYear:get()
		local f26_local2 = DataSources.CODAccountRegistrationForm.getModel(f26_arg0)
		local f26_local3 = f26_local2.dobMonth:get()
		local f26_local4 = DataSources.CODAccountRegistrationForm.getModel(f26_arg0)
		f26_local4 = f26_local4.dobDay
		local f26_local5 = f26_local4:get()
		local f26_local6 = CoD.CoDAccountUtility.GetDaysInMonth(f26_local3, f26_local1)
		if f26_local6 < f26_local5 then
			f26_local4:set(f26_local6)
			f26_arg1.currentNum:set(f26_local6)
		end
	end
	local f25_local2 = function(f27_arg0, f27_arg1, f27_arg2, f27_arg3)
		local f27_local0 = DataSources.CODAccountRegistrationForm.getModel(f27_arg2)
		f27_local0 = f27_local0.dobYear
		local f27_local1 = f27_local0:get() - 1
		if f27_local1 < CoD.CoDAccountUtility.MINIMUM_DOB_YEAR then
			local f27_local2, f27_local3, f27_local4 = Engine[0x221B0C76B5975CB]()
			f27_local1 = f27_local4
		end
		f27_local0:set(f27_local1)
		local f27_local2 = f27_arg0:getModel(f27_arg2, "currentNum")
		f27_local2:set(f27_local0:get())
		f25_local1(f27_arg2, DataSources.CODAccountRegisterInfoDob.getItem(f27_arg2, f27_arg1, 3))
	end
	local f25_local3 = function(f28_arg0, f28_arg1, f28_arg2, f28_arg3)
		local f28_local0 = DataSources.CODAccountRegistrationForm.getModel(f28_arg2)
		f28_local0 = f28_local0.dobYear
		local f28_local1 = f28_local0:get() + 1
		local f28_local2, f28_local3, f28_local4 = Engine[0x221B0C76B5975CB]()
		if f28_local4 < f28_local1 then
			f28_local1 = CoD.CoDAccountUtility.MINIMUM_DOB_YEAR
		end
		f28_local0:set(f28_local1)
		local f28_local5 = f28_arg0:getModel(f28_arg2, "currentNum")
		f28_local5:set(f28_local0:get())
		f25_local1(f28_arg2, DataSources.CODAccountRegisterInfoDob.getItem(f28_arg2, f28_arg1, 3))
	end
	local f25_local4 = function(f29_arg0, f29_arg1, f29_arg2, f29_arg3)
		local f29_local0 = DataSources.CODAccountRegistrationForm.getModel(f29_arg2)
		f29_local0 = f29_local0.dobMonth
		local f29_local1 = (f29_local0:get() - 1) % 12
		if f29_local1 == 0 then
			f29_local1 = 12 or f29_local1
		end
		f29_local0:set(f29_local1)
		local f29_local2 = f29_arg0:getModel(f29_arg2, "currentNum")
		f29_local2:set(f29_local0:get())
		f25_local1(f29_arg2, DataSources.CODAccountRegisterInfoDob.getItem(f29_arg2, f29_arg1, 3))
	end
	local f25_local5 = function(f30_arg0, f30_arg1, f30_arg2, f30_arg3)
		local f30_local0 = DataSources.CODAccountRegistrationForm.getModel(f30_arg2)
		f30_local0 = f30_local0.dobMonth
		local f30_local1 = (f30_local0:get() + 1) % 12
		if f30_local1 == 0 then
			f30_local1 = 12 or f30_local1
		end
		f30_local0:set(f30_local1)
		local f30_local2 = f30_arg0:getModel(f30_arg2, "currentNum")
		f30_local2:set(f30_local0:get())
		f25_local1(f30_arg2, DataSources.CODAccountRegisterInfoDob.getItem(f30_arg2, f30_arg1, 3))
	end
	local f25_local6 = function(f31_arg0, f31_arg1, f31_arg2, f31_arg3)
		local f31_local0 = DataSources.CODAccountRegistrationForm.getModel(f31_arg2)
		f31_local0 = f31_local0.dobDay
		local f31_local1 = CoD.CoDAccountUtility.GetDaysInCurrentMonth(f31_arg2)
		local f31_local2 = (f31_local0:get() - 1) % f31_local1
		if f31_local2 == 0 then
			f31_local2 = f31_local1 or f31_local2
		end
		f31_local0:set(f31_local2)
		local f31_local3 = f31_arg0:getModel(f31_arg2, "currentNum")
		f31_local3:set(f31_local0:get())
	end
	local f25_local7 = function(f32_arg0, f32_arg1, f32_arg2, f32_arg3)
		local f32_local0 = DataSources.CODAccountRegistrationForm.getModel(f32_arg2)
		f32_local0 = f32_local0.dobDay
		local f32_local1 = CoD.CoDAccountUtility.GetDaysInCurrentMonth(f32_arg2)
		local f32_local2 = (f32_local0:get() + 1) % f32_local1
		if f32_local2 == 0 then
			f32_local2 = f32_local1 or f32_local2
		end
		f32_local0:set(f32_local2)
		local f32_local3 = f32_arg0:getModel(f32_arg2, "currentNum")
		f32_local3:set(f32_local0:get())
	end
	local f25_local8 = table.insert
	local f25_local9 = f25_local0
	local f25_local10 = CoD.CoDAccountUtility.packageNumOptionsButtonData
	local f25_local11 = 0xB47567E1BA0DB3C
	local f25_local12 = 0xBFD846433DF23C4
	local f25_local13 = DataSources.CODAccountRegistrationForm.getModel(f25_arg0)
	f25_local8(f25_local9, f25_local10(f25_local11, f25_local12, f25_local13.dobYear:get(), f25_local2, f25_local3))
	f25_local8 = table.insert
	f25_local9 = f25_local0
	f25_local10 = CoD.CoDAccountUtility.packageNumOptionsButtonData
	f25_local11 = 0xEDDA606BC3D1A85
	f25_local12 = 0xCF3C204406D094F
	f25_local13 = DataSources.CODAccountRegistrationForm.getModel(f25_arg0)
	f25_local8(f25_local9, f25_local10(f25_local11, f25_local12, f25_local13.dobMonth:get(), f25_local4, f25_local5))
	f25_local8 = table.insert
	f25_local9 = f25_local0
	f25_local10 = CoD.CoDAccountUtility.packageNumOptionsButtonData
	f25_local11 = 0xD518580105F7DFD
	f25_local12 = 0xA98FA84F1693047
	f25_local13 = DataSources.CODAccountRegistrationForm.getModel(f25_arg0)
	f25_local8(f25_local9, f25_local10(f25_local11, f25_local12, f25_local13.dobDay:get(), f25_local6, f25_local7))
	return f25_local0
end, true)
DataSources.CODAccountRegisterInfoRegion = ListHelper_SetupDataSource("CODAccountRegisterInfoRegion", function(f33_arg0)
	local f33_local0 = {}
	local f33_local1 = function(f34_arg0, f34_arg1, f34_arg2, f34_arg3)
		local f34_local0 = DataSources.CODAccountRegistrationForm.getModel(f34_arg2)
		f34_local0 = f34_local0.regionIndex
		local f34_local1 = (f34_local0:get() - 1) % #CoD.CoDAccountUtility.country_list
		if f34_local1 == 0 then
			f34_local1 = #CoD.CoDAccountUtility.country_list or f34_local1
		end
		f34_local0:set(f34_local1)
		local f34_local2 = f34_arg0:getModel(f34_arg2, "currentNum")
		f34_local2:set(Engine[0xF9F1239CFD921FE](CoD.CoDAccountUtility.country_list[f34_local1].display_string))
	end
	local f33_local2 = function(f35_arg0, f35_arg1, f35_arg2, f35_arg3)
		local f35_local0 = DataSources.CODAccountRegistrationForm.getModel(f35_arg2)
		f35_local0 = f35_local0.regionIndex
		local f35_local1 = (f35_local0:get() + 1) % #CoD.CoDAccountUtility.country_list
		if f35_local1 == 0 then
			f35_local1 = #CoD.CoDAccountUtility.country_list or f35_local1
		end
		f35_local0:set(f35_local1)
		local f35_local2 = f35_arg0:getModel(f35_arg2, "currentNum")
		f35_local2:set(Engine[0xF9F1239CFD921FE](CoD.CoDAccountUtility.country_list[f35_local1].display_string))
	end
	local f33_local3 = DataSources.CODAccountRegistrationForm.getModel(f33_arg0)
	f33_local3 = f33_local3.regionIndex:get()
	table.insert(f33_local0, CoD.CoDAccountUtility.packageNumOptionsButtonData(0x5E47B2E277CE3DF, 0xC3AF012770E8671, Engine[0xF9F1239CFD921FE](CoD.CoDAccountUtility.country_list[f33_local3.regionIndex:get()].display_string), f33_local1, f33_local2))
	return f33_local0
end, true)
DataSources.CODAccountSignInInfoOptions = ListHelper_SetupDataSource("CODAccountSignInInfoOptions", function(f36_arg0)
	local f36_local0 = {}
	local f36_local1 = function(f37_arg0, f37_arg1, f37_arg2, f37_arg3, f37_arg4)
		return {
			models = {
				displayText = f37_arg0,
				description = f37_arg1,
				currentValue = f37_arg2,
			},
			properties = {
				action = f37_arg3,
				actionParam = f37_arg4,
			},
		}
	end
	local f36_local2 = function(f38_arg0, f38_arg1, f38_arg2, f38_arg3, f38_arg4)
		local f38_local0 = DataSources.CODAccountSignInForm.getModel(f38_arg2)
		f38_local0 = f38_local0.confirmSpam
		local f38_local1 = not f38_local0:get()
		f38_local0:set(f38_local1)
		local f38_local2 = f38_arg1:getModel(f38_arg2, "currentValue")
		f38_local2:set(f38_local1)
	end
	local f36_local3 = table.insert
	local f36_local4 = f36_local0
	local f36_local5 = f36_local1
	local f36_local6 = 0x4386399918B25D7
	local f36_local7 = 0x2C3697D1F18A5C9
	local f36_local8 = DataSources.CODAccountSignInForm.getModel(f36_arg0)
	f36_local3(f36_local4, f36_local5(f36_local6, f36_local7, f36_local8.confirmSpam:get(), f36_local2))
	return f36_local0
end, true)
DataSources.CODAccountRegisterInfoOptions = ListHelper_SetupDataSource("CODAccountRegisterInfoOptions", function(f39_arg0)
	local f39_local0 = {}
	local f39_local1 = function(f40_arg0, f40_arg1, f40_arg2, f40_arg3, f40_arg4)
		return {
			models = {
				displayText = f40_arg0,
				description = f40_arg1,
				currentValue = f40_arg2,
			},
			properties = {
				action = f40_arg3,
				actionParam = f40_arg4,
			},
		}
	end
	local f39_local2 = function(f41_arg0, f41_arg1, f41_arg2, f41_arg3, f41_arg4)
		local f41_local0 = DataSources.CODAccountRegistrationForm.getModel(f41_arg2)
		f41_local0 = f41_local0.confirmTOU
		local f41_local1 = not f41_local0:get()
		f41_local0:set(f41_local1)
		local f41_local2 = f41_arg1:getModel(f41_arg2, "currentValue")
		f41_local2:set(f41_local1)
	end
	local f39_local3 = function(f42_arg0, f42_arg1, f42_arg2, f42_arg3, f42_arg4)
		local f42_local0 = DataSources.CODAccountRegistrationForm.getModel(f42_arg2)
		f42_local0 = f42_local0.confirmSpam
		local f42_local1 = not f42_local0:get()
		f42_local0:set(f42_local1)
		local f42_local2 = f42_arg1:getModel(f42_arg2, "currentValue")
		f42_local2:set(f42_local1)
	end
	local f39_local4 = table.insert
	local f39_local5 = f39_local0
	local f39_local6 = f39_local1
	local f39_local7 = 0xD226F0316784E4D
	local f39_local8 = 0x1E95EF81CEEDBC0
	local f39_local9 = DataSources.CODAccountRegistrationForm.getModel(f39_arg0)
	f39_local4(f39_local5, f39_local6(f39_local7, f39_local8, f39_local9.confirmTOU:get(), f39_local2))
	f39_local4 = table.insert
	f39_local5 = f39_local0
	f39_local6 = f39_local1
	f39_local7 = 0x4386399918B25D7
	f39_local8 = 0x2C3697D1F18A5C9
	f39_local9 = DataSources.CODAccountRegistrationForm.getModel(f39_arg0)
	f39_local4(f39_local5, f39_local6(f39_local7, f39_local8, f39_local9.confirmSpam:get(), f39_local3))
	return f39_local0
end, true)
DataSources.CODAccountManagementOptions = ListHelper_SetupDataSource("CODAccountManagementOptions", function(f43_arg0)
	local f43_local0 = {}
	local f43_local1 = function(f44_arg0, f44_arg1, f44_arg2, f44_arg3, f44_arg4)
		return {
			models = {
				displayText = f44_arg0,
				description = f44_arg1,
				currentValue = f44_arg2,
			},
			properties = {
				action = f44_arg3,
				actionParam = f44_arg4,
			},
		}
	end
	local f43_local2 = function(f45_arg0, f45_arg1, f45_arg2, f45_arg3, f45_arg4)
		local f45_local0 = DataSources.CODAccountManagementForm.getModel(f45_arg2)
		f45_local0 = f45_local0.optInStatus
		local f45_local1 = not f45_local0:get()
		f45_local0:set(f45_local1)
		local f45_local2 = f45_arg1:getModel(f45_arg2, "currentValue")
		f45_local2:set(f45_local1)
	end
	local f43_local3 = table.insert
	local f43_local4 = f43_local0
	local f43_local5 = f43_local1
	local f43_local6 = 0x4386399918B25D7
	local f43_local7 = 0x2C3697D1F18A5C9
	local f43_local8 = DataSources.CODAccountManagementForm.getModel(f43_arg0)
	f43_local3(f43_local4, f43_local5(f43_local6, f43_local7, f43_local8.optInStatus:get(), f43_local2))
	return f43_local0
end, true)
CoD.CoDAccountUtility.IsSignInActive = false
DataSources.CODAccountSignInConfirmation = ListHelper_SetupDataSource("CODAccountSignInConfirmation", function(f46_arg0)
	local f46_local0 = {}
	table.insert(
		f46_local0,
		CoD.CoDAccountUtility.packageOptionsButtonData(0x34AB4709B1FA9DB, 0x5FE2CB1957E1FCD, nil, function(f47_arg0, f47_arg1, f47_arg2, f47_arg3, f47_arg4)
			local f47_local0 = DataSources.CODAccountSignInForm.getModel(f47_arg2)
			local f47_local1 = f47_local0.emailAddress:get()
			local f47_local2 = f47_local0.password:get()
			local f47_local3 = f47_local0.confirmSpam:get()
			if not f47_local1 or string.len(f47_local1) == 0 then
				LuaUtils.UI_ShowErrorMessageDialog(f47_arg2, 0x809D4D95F9054A5, 0x31E422BC40B2429)
				return
			elseif not f47_local2 or string.len(f47_local2) == 0 then
				LuaUtils.UI_ShowErrorMessageDialog(f47_arg2, 0x1F70C8645FEA8BC, 0x31E422BC40B2429)
				return
			end
			f47_local0.emailAddress:set("")
			f47_local0.password:set("")
			f47_local0.confirmSpam:set(false)
			CoD.CoDAccountUtility.IsSignInActive = true
			if Engine[0x28435788F046AB1](f47_arg2, f47_local1, f47_local2, f47_local3) == true then
				Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.spinnerActive"), true)
			else
				GoBack(f47_arg0, f47_arg2)
				LuaUtils.UI_ShowErrorMessageDialog(f47_arg2, 0xA1F937DB15A3B0, 0x127999393F1681)
			end
		end)
	)
	return f46_local0
end, true)
DataSources.CODAccountRegisterConfirmation = ListHelper_SetupDataSource("CODAccountRegisterConfirmation", function(f48_arg0)
	local f48_local0 = {}
	local f48_local1 = function(f49_arg0, f49_arg1, f49_arg2, f49_arg3)
		local f49_local0 = CoD.CoDAccountUtility.country_list[f49_arg3].min_age
		local f49_local1, f49_local2, f49_local3 = Engine[0x221B0C76B5975CB]()
		local f49_local4 = false
		if f49_arg2 + f49_local0 < f49_local3 then
			f49_local4 = true
		elseif f49_arg2 + f49_local0 == f49_local3 then
			if f49_arg1 < f49_local2 then
				f49_local4 = true
			elseif f49_arg1 == f49_local2 and f49_arg0 <= f49_local1 then
				f49_local4 = true
			end
		end
		return f49_local4
	end
	table.insert(
		f48_local0,
		CoD.CoDAccountUtility.packageOptionsButtonData(0x215C30E9D25C305, 0x8166430FAB32CF, nil, function(f50_arg0, f50_arg1, f50_arg2, f50_arg3, f50_arg4)
			local f50_local0 = DataSources.CODAccountRegistrationForm.getModel(f50_arg2)
			local f50_local1 = f50_local0.regionIndex:get()
			local f50_local2 = CoD.CoDAccountUtility.country_list[f50_local1].code
			local f50_local3 = f50_local0.emailAddress:get()
			local f50_local4 = f50_local0.password:get()
			local f50_local5 = f50_local0.confPassword:get()
			local f50_local6 = f50_local0.dobMonth:get()
			local f50_local7 = f50_local0.dobYear:get()
			local f50_local8 = f50_local0.dobDay:get()
			local f50_local9 = f50_local0.confirmTOU:get()
			local f50_local10 = f50_local0.confirmSpam:get()
			if not f50_local3 or string.len(f50_local3) == 0 then
				LuaUtils.UI_ShowErrorMessageDialog(f50_arg2, 0x809D4D95F9054A5, 0x31E422BC40B2429)
				return
			elseif not f50_local4 or f50_local4 == f50_local3 or string.len(f50_local4) < 8 or string.len(f50_local4) > 20 then
				LuaUtils.UI_ShowErrorMessageDialog(f50_arg2, 0x3518D037A98D238, 0x31E422BC40B2429)
				return
			elseif not f50_local5 or f50_local4 ~= f50_local5 then
				LuaUtils.UI_ShowErrorMessageDialog(f50_arg2, 0x112336C91F4212E, 0x31E422BC40B2429)
				return
			elseif not f50_local9 then
				LuaUtils.UI_ShowErrorMessageDialog(f50_arg2, 0xDA059810DB91BA6, 0x31E422BC40B2429)
				return
			elseif not f48_local1(f50_local8, f50_local6, f50_local7, f50_local1) then
				Engine[0xCAF37D90D5016BE](f50_arg2)
				LuaUtils.UI_ShowErrorMessageDialog(f50_arg2, 0x2192A0F74BF5791, 0x31E422BC40B2429)
				GoBack(f50_arg0, f50_arg2)
				return
			end
			CoD.CoDAccountUtility.IsSignInActive = false
			if Engine[0x6E02E86A4595005](f50_arg2, {
				region = f50_local2,
				email = f50_local3,
				password = f50_local4,
				month = f50_local6,
				day = f50_local8,
				year = f50_local7,
				optIn = f50_local10,
			}) == true then
				Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.spinnerActive"), true)
			else
				GoBack(f50_arg0, f50_arg2)
				LuaUtils.UI_ShowErrorMessageDialog(f50_arg2, 0xA1F937DB15A3B0, 0x127999393F1681)
			end
		end)
	)
	return f48_local0
end, true)
DataSources.CODAccountManagementConfirmation = ListHelper_SetupDataSource("CODAccountManagementConfirmation", function(f51_arg0)
	local f51_local0 = {}
	table.insert(
		f51_local0,
		CoD.CoDAccountUtility.packageOptionsButtonData(0x510602E24EC68E6, 0x1E475AB21AD3B16, nil, function(f52_arg0, f52_arg1, f52_arg2, f52_arg3, f52_arg4)
			if Engine[0x516B0477716506E](f52_arg2) then
				return
			end
			local f52_local0 = DataSources.CODAccountManagementForm.getModel(f52_arg2)
			if f52_local0.optInStatus:get() then
				Engine[0x948D573CF7F16EC](f52_arg2)
			else
				Engine[0x53F46726BBD2817](f52_arg2)
			end
			Engine[0x3FA7DA8B2FCE32E](f52_arg2)
			GoBack(f52_arg4, f52_arg2)
		end)
	)
	return f51_local0
end, true)
CoD.CoDAccountUtility.CodAccountHandleKeyboardComplete = function(f53_arg0, f53_arg1, f53_arg2, f53_arg3)
	local f53_local0 = f53_arg2.input
	local f53_local1 = f53_arg3.registrationFormStrings
	local f53_local2 = DataSources.CODAccountRegistrationForm.getModel(f53_arg1)
	if f53_arg2.type == Enum[0x85FCE2AA5391A7C][0x142CB9308BACAD4] then
		if f53_local0 ~= nil then
			f53_local2.emailAddress:set(f53_local0)
			local f53_local3 = DataSources.CODAccountRegisterInfoBasic.getItem(f53_arg1, f53_local1, 1)
			f53_local3.currentText:set(f53_local0)
		end
	elseif f53_arg2.type == Enum[0x85FCE2AA5391A7C][0xE9E4E7BF9EAF58D] then
		if f53_local0 ~= nil then
			local f53_local3 = string.len(f53_local0)
			if f53_local3 >= 8 and f53_local3 <= 20 then
				f53_local2.password:set(f53_local0)
				local f53_local4 = DataSources.CODAccountRegisterInfoBasic.getItem(f53_arg1, f53_local1, 2)
				f53_local4.currentText:set(string.gsub(f53_local0, ".", "*"))
				f53_local2.confPassword:set("")
			else
				LuaUtils.UI_ShowErrorMessageDialog(f53_arg1, 0x3518D037A98D238, 0x31E422BC40B2429)
			end
		end
	elseif f53_arg2.type == Enum[0x85FCE2AA5391A7C][0x8E0838BF6F94776] and f53_local0 ~= nil then
		if f53_local0 == f53_local2.password:get() then
			f53_local2.confPassword:set(f53_local0)
			local f53_local3 = DataSources.CODAccountRegisterInfoBasic.getItem(f53_arg1, f53_local1, 3)
			f53_local3.currentText:set(string.gsub(f53_local0, ".", "*"))
		else
			LuaUtils.UI_ShowErrorMessageDialog(f53_arg1, 0x112336C91F4212E, 0x31E422BC40B2429)
		end
	end
end
CoD.CoDAccountUtility.CodAccountHandleSignInKeyboardComplete = function(f54_arg0, f54_arg1, f54_arg2, f54_arg3)
	local f54_local0 = f54_arg2.input
	local f54_local1 = f54_arg3.registrationFormStrings
	local f54_local2 = DataSources.CODAccountSignInForm.getModel(f54_arg1)
	if f54_arg2.type == Enum[0x85FCE2AA5391A7C][0xA6EF6D020820F1E] then
		if f54_local0 ~= nil then
			f54_local2.emailAddress:set(f54_local0)
			local f54_local3 = DataSources.CODAccountSignInInfoBasic.getItem(f54_arg1, f54_local1, 1)
			f54_local3.currentText:set(f54_local0)
		end
	elseif f54_arg2.type == Enum[0x85FCE2AA5391A7C][0x6AA188359BEC01F] and f54_local0 ~= nil then
		f54_local2.password:set(f54_local0)
		local f54_local3 = DataSources.CODAccountSignInInfoBasic.getItem(f54_arg1, f54_local1, 2)
		f54_local3.currentText:set(string.gsub(f54_local0, ".", "*"))
	end
end
CoD.CoDAccountUtility.CodAccountAddRightStickSingleItemControl = function(f55_arg0, f55_arg1, f55_arg2)
	local f55_local0 = f55_arg1
	f55_arg0:AddButtonCallbackFunction(f55_local0, f55_arg2, Enum[0x3DD78803F918E9D][0x57783F8DA4AAEF], nil, function(element, menu, controller, model)
		local f56_local0 = element:getParent()
		local f56_local1 = f56_local0.minusFn
		if not IsDpadButton(model) then
			local f56_local2 = f56_local1 and f56_local1(f56_local0, f56_local0.gridInfoTable.parentGrid, controller)
			if ScoreboardVisible(controller) then
				BlockGameFromKeyEvent(controller)
			end
		end
	end, AlwaysFalse, false)
	f55_arg0:AddButtonCallbackFunction(f55_local0, f55_arg2, Enum[0x3DD78803F918E9D][0x571F08AD84807E0], nil, function(element, menu, controller, model)
		local f57_local0 = element:getParent()
		local f57_local1 = f57_local0.plusFn
		if not IsDpadButton(model) then
			local f57_local2 = f57_local1 and f57_local1(f57_local0, f57_local0.gridInfoTable.parentGrid, controller)
			if ScoreboardVisible(controller) then
				BlockGameFromKeyEvent(controller)
			end
		end
	end, AlwaysFalse, false)
end
local f0_local0 = function(f58_arg0)
	local f58_local0
	if CoD.CoDAccountUtility.error_codes[f58_arg0] ~= nil and f58_arg0 ~= Enum[0x7DEA32672263479][0x949EF8AE1EF744D] then
		f58_local0 = false
	else
		f58_local0 = true
	end
	return f58_local0
end
CoD.CoDAccountUtility.CodAccountOnTransactionResultUpdated = function(f59_arg0, f59_arg1, f59_arg2)
	local f59_local0 = DataSources.UNOAccountInfo.getModel(f59_arg1)
	local f59_local1 = f59_local0.iBusyStatus:get()
	local f59_local2 = f59_arg2:get()
	local f59_local3 = DataSources.UNOAccountInfo.getModel(f59_arg1)
	local f59_local4 = f59_local3.bSignedIn:get()
	if f59_local2 ~= nil and f59_local1 == Enum[0xBD1E0D9720D416F][0x44F7EE04FC86C81] and Engine[0x614D394F6F9A18D](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.spinnerActive")) == true then
		if f59_local2 == Enum[0x7DEA32672263479][0x9785994B830E5D0] and f59_local4 then
			if CoD.CoDAccountUtility.IsSignInRequired(f59_arg0) then
				CoD.LobbyUtility.OpenFTUEGameIntroductionOverlay(f59_arg1)
			elseif CoD.isPC then
				local f59_local5 = GoBackMultiple(f59_arg0, f59_arg1, 2)
				if f59_local5 then
					f59_local5:sendInitializationEvents(f59_arg1, f59_local5)
				end
			else
				GoBackMultiple(f59_arg0, f59_arg1, 2)
			end
			local f59_local5 = 0x8A1166FB6473E4E
			local f59_local6 = 0xBDDF5BDFAA382D4
			if CoD.CoDAccountUtility.IsSignInActive then
				f59_local5 = 0x6144FDBA2ECB222
				f59_local6 = 0xBC4BCDA21842070
				CoD.CoDAccountUtility.IsSignInActive = false
			end
			LuaUtils.ShowMessageDialog(f59_arg1, Enum[0xEE23F7D18EF525C][0x296CBAC6039D717], f59_local6, f59_local5)
		else
			local f59_local5 = CoD.CoDAccountUtility.error_codes[f59_local2]
			if f59_local5 == nil then
				f59_local5 = 0xA1F937DB15A3B0
			end
			if f0_local0(f59_local2) then
				GoBack(f59_arg0, f59_arg1)
			end
			LuaUtils.UI_ShowErrorMessageDialog(f59_arg1, f59_local5, 0x127999393F1681)
		end
		Engine[0x83C9B5DE1D9371](Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.spinnerActive"), false)
	end
end
CoD.CoDAccountUtility.UpdateOnCTAOccludedChange = function(f60_arg0, f60_arg1, f60_arg2)
	CoD.GridAndListUtility.UpdateDataSource(f60_arg0.accountOptionsList, true, true, true)
	if not f60_arg2.occluded and Engine[0x4A9D1DAC0556BB1](f60_arg1) and not CoD.CoDAccountUtility.IsSignInRequired(f60_arg0) then
		GoBack(f60_arg0, f60_arg1)
	end
end
CoD.CoDAccountUtility.IsTrialAccountFeatureEnabled = function()
	return not IsBooleanDvarSet(0xAD91E8E7D5F920E)
end
CoD.CoDAccountUtility.IsTrialAccountSkipButtonEnabled = function()
	return IsBooleanDvarSet(0xDAD183211B084A8)
end
CoD.CoDAccountUtility.HideSkipButton = function(f63_arg0)
	local f63_local0
	if CoD.CoDAccountUtility.IsTrialAccountSkipButtonEnabled() and Engine[0xCB675CA7856DA25]() then
		f63_local0 = not f63_arg0._signInRequired
	else
		f63_local0 = true
	end
	return f63_local0
end
CoD.CoDAccountUtility.IsAccountFeatureEnabled = function(f64_arg0)
	if CoD.isPC and Engine[0x92CFCA99B311B73]() then
		return false
	elseif not CoD.isPC and CoD.BaseUtility.IsCurrentLanguageRussian() then
		return false
	else
		local f64_local0
		if not IsInGame() then
			if CoD.DirectorUtility.IsOfflineDemo() then
				f64_local0 = Engine[0xCB675CA7856DA25]()
				if f64_local0 then
				else
					return f64_local0
				end
			end
			f64_local0 = CoDShared.IsERegEnabled(f64_arg0)
			if f64_local0 then
				f64_local0 = Engine[0xD7913D0F914DE47](f64_arg0)
			end
		else
			f64_local0 = false
		end
	end
	return f64_local0
end
CoD.CoDAccountUtility.GetElementDescription = function(f65_arg0)
	local f65_local0 = f65_arg0:getModel()
	if f65_local0 then
		local f65_local1 = f65_local0.description
		local f65_local2 = Engine[0xF9F1239CFD921FE](f65_local0.description:get())
	end
	return f65_local1 and f65_local2 or ""
end
CoD.CoDAccountUtility.OnNewAccountItemFocusChange = function(f66_arg0, f66_arg1, f66_arg2)
	local f66_local0 = DataSources.CODAccountRegistrationForm.getModel(f66_arg1)
	f66_local0.hintText:set(CoD.CoDAccountUtility.GetElementDescription(f66_arg2))
end
CoD.CoDAccountUtility.OnNewAccountItemFocusChangeWithHint = function(f67_arg0, f67_arg1)
	local f67_local0 = DataSources.CODAccountRegistrationForm.getModel(f67_arg0)
	f67_local0.hintText:set(Engine[0xF9F1239CFD921FE](f67_arg1))
end
CoD.CoDAccountUtility.OnSignInItemFocusChange = function(f68_arg0, f68_arg1, f68_arg2)
	local f68_local0 = DataSources.CODAccountSignInForm.getModel(f68_arg1)
	f68_local0.hintText:set(CoD.CoDAccountUtility.GetElementDescription(f68_arg2))
end
CoD.CoDAccountUtility.OnSignInItemFocusChangeWithHint = function(f69_arg0, f69_arg1)
	local f69_local0 = DataSources.CODAccountSignInForm.getModel(f69_arg0)
	f69_local0.hintText:set(Engine[0xF9F1239CFD921FE](f69_arg1))
end
CoD.CoDAccountUtility.OnAccountManagementItemFocusChange = function(f70_arg0, f70_arg1, f70_arg2)
	local f70_local0 = DataSources.CODAccountManagementForm.getModel(f70_arg1)
	f70_local0.hintText:set(CoD.CoDAccountUtility.GetElementDescription(f70_arg2))
end
CoD.CoDAccountUtility.ClearRegistrationEmailAndPasswordModels = function(f71_arg0)
	local f71_local0 = DataSources.CODAccountRegistrationForm.getModel(f71_arg0)
	f71_local0.emailAddress:set("")
	f71_local0.password:set("")
	f71_local0.confPassword:set("")
end
CoD.CoDAccountUtility.ClearSignInEmailAndPasswordModels = function(f72_arg0)
	local f72_local0 = DataSources.CODAccountSignInForm.getModel(f72_arg0)
	f72_local0.emailAddress:set("")
	f72_local0.password:set("")
end
CoD.CoDAccountUtility.SetupCurrentLegalInfo = function(f73_arg0, f73_arg1, f73_arg2)
	local f73_local0 = CoD.CoDAccountUtility.LegalInfo[f73_arg2]
	local f73_local1 = DataSources.CODAccountLegalInfo.getModel(f73_arg1)
	f73_local1.currentLegalInfoIndex:set(1)
	if f73_local0 then
		local f73_local2 = CoD.CoDAccountUtility.LegalInfo.LegalInfoAdditionalInfo[f73_arg2]
		f73_local1.currentLegalInfoReference:set(f73_arg2)
		f73_local1.currentLegalTitle:set(f73_local2.title)
		f73_local1.currentLegalInfoText:set(f73_local0[f73_local1.currentLegalInfoIndex:get()])
	end
end
CoD.CoDAccountUtility.SetupTextViewerPages = function(f74_arg0, f74_arg1)
	local f74_local0 = DataSources.CODAccountLegalInfo.getModel(f74_arg1)
	CoD.CoDAccountUtility.SetLegalPagesText(f74_arg0.pageText, f74_arg1, f74_local0.currentLegalInfoIndex:get(), #CoD.CoDAccountUtility.LegalInfo[f74_local0.currentLegalInfoReference:get()])
end
CoD.CoDAccountUtility.NextCurrentLegalInfoEntry = function(f75_arg0, f75_arg1, f75_arg2)
	local f75_local0 = DataSources.CODAccountLegalInfo.getModel(f75_arg2)
	local f75_local1 = CoD.CoDAccountUtility.LegalInfo[f75_local0.currentLegalInfoReference:get()]
	local f75_local2 = f75_local0.currentLegalInfoIndex:get() + 1
	if f75_local1 and f75_local2 <= #f75_local1 then
		f75_local0.currentLegalInfoText:set(f75_local1[f75_local2])
		f75_local0.currentLegalInfoIndex:set(f75_local2)
		if CoD.isPC then
			CoD.CoDAccountUtility.SetLegalPagesText(f75_arg1.pageText, f75_arg2, f75_local2, #f75_local1)
		end
	end
end
CoD.CoDAccountUtility.PreviousCurrentLegalInfoEntry = function(f76_arg0, f76_arg1, f76_arg2)
	local f76_local0 = DataSources.CODAccountLegalInfo.getModel(f76_arg2)
	local f76_local1 = CoD.CoDAccountUtility.LegalInfo[f76_local0.currentLegalInfoReference:get()]
	local f76_local2 = f76_local0.currentLegalInfoIndex:get() - 1
	if f76_local1 and f76_local2 > 0 then
		f76_local0.currentLegalInfoText:set(f76_local1[f76_local2])
		f76_local0.currentLegalInfoIndex:set(f76_local2)
		if CoD.isPC then
			CoD.CoDAccountUtility.SetLegalPagesText(f76_arg1.pageText, f76_arg2, f76_local2, #f76_local1)
		end
	end
end
CoD.CoDAccountUtility.SetLegalPagesText = function(f77_arg0, f77_arg1, f77_arg2, f77_arg3)
	f77_arg0:setText(Engine[0xF9F1239CFD921FE](0xA205700391CF3AD, f77_arg2, f77_arg3))
end
CoD.CoDAccountUtility.IsFirstLegalInfoEntry = function(f78_arg0)
	local f78_local0 = DataSources.CODAccountLegalInfo.getModel(f78_arg0)
	return f78_local0.currentLegalInfoIndex:get() == 1
end
CoD.CoDAccountUtility.IsLastLegalInfoEntry = function(f79_arg0)
	local f79_local0 = DataSources.CODAccountLegalInfo.getModel(f79_arg0)
	return f79_local0.currentLegalInfoIndex:get() == #CoD.CoDAccountUtility.LegalInfo[f79_local0.currentLegalInfoReference:get()]
end
CoD.OverlayUtility.AddAutoDetectOverlay("CancelTrialSignIn", {
	title = 0x4395B2A497A523E,
	description = 0xA8622B2EDEF9DF2,
	categoryType = CoD.OverlayUtility.OverlayTypes.Quit,
	options = function()
		return {
			{
				action = Close,
				text = 0x5BE4A02B20F31F1,
				isCancelOption = true,
			},
			{
				action = function()
					Engine[0x7C75E608EA39B5C](Engine[0xA5B9C0111291A8B](), "quit")
				end,
				text = 0xB2EF56B4AF147B8,
			},
		}
	end,
})
