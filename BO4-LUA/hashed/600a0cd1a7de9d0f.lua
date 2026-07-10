require("x64:b370b3af9224bd0")
require("x64:c6e3b538b3d95e3")
require("x64:d2aca1e5dd29f34")
function TestModifyFunction(f1_arg0)
	return f1_arg0
end
function FractionToPercentageRounded(f2_arg0)
	if f2_arg0 and f2_arg0 ~= 0x0 and f2_arg0 ~= "" then
		return Engine[0xF9F1239CFD921FE](0x16A7A1F8ECC8C64, math.floor(f2_arg0 * 100 + 0.5))
	else
		return 0x0
	end
end
function NumberAsTime(f3_arg0)
	local f3_local0 = math.floor(f3_arg0 / 60000)
	local f3_local1 = math.floor((f3_arg0 - f3_local0 * 60000) / 1000)
	local f3_local2 = f3_arg0 % 1000
	if f3_local1 < 10 then
		f3_local1 = "0" .. f3_local1
	end
	if f3_local2 < 10 then
		f3_local2 = "00" .. f3_local2
	elseif f3_local2 < 100 then
		f3_local2 = "0" .. f3_local2
	end
	return f3_local0 .. ":" .. f3_local1 .. "." .. f3_local2
end
function MillisecondsAsMinAndSeconds(f4_arg0)
	local f4_local0 = math.floor(f4_arg0 / 60000)
	local f4_local1 = math.floor((f4_arg0 - f4_local0 * 60000) / 1000)
	if f4_local1 < 10 then
		f4_local1 = "0" .. f4_local1
	end
	return f4_local0 .. ":" .. f4_local1
end
function MillisecondsAsSeconds(f5_arg0)
	local f5_local0 = math.floor((f5_arg0 - math.floor(f5_arg0 / 60000) * 60000) / 1000)
	if f5_local0 < 10 then
		f5_local0 = "0" .. f5_local0
	end
	return f5_local0
end
function MillisecondsAsTime(f6_arg0)
	return string.format("%02d:%02d", math.floor(f6_arg0 / 1000), math.floor(f6_arg0 % 1000 / 10))
end
function SecondsAsTime(f7_arg0)
	local f7_local0 = tonumber(f7_arg0)
	local f7_local1 = math.floor(f7_local0 / 60)
	return string.format("%d:%02d", f7_local1, f7_local0 - f7_local1 * 60)
end
function SecondsAsTimeDashedZero(f8_arg0)
	local f8_local0 = tonumber(f8_arg0)
	if not f8_local0 or f8_local0 <= 0 then
		return "-:--"
	else
		local f8_local1 = math.floor(f8_local0 / 60)
		return string.format("%d:%02d", f8_local1, f8_local0 - f8_local1 * 60)
	end
end
function SecondsAsTimePlayedString(f9_arg0)
	if f9_arg0 and f9_arg0 ~= 0x0 and f9_arg0 ~= "" then
		local f9_local0 = math.floor(f9_arg0 / 86400)
		f9_arg0 = f9_arg0 - f9_local0 * 86400
		local f9_local1 = math.floor(f9_arg0 / 3600)
		f9_arg0 = f9_arg0 - f9_local1 * 3600
		local f9_local2 = math.floor(f9_arg0 / 60)
		return Engine[0xF9F1239CFD921FE](0xFEBB5BF51FE663, f9_local0, f9_local1, f9_local2, f9_arg0 - f9_local2 * 60)
	else
		return Engine[0xF9F1239CFD921FE](0xFEBB5BF51FE663, 0, 0, 0, 0)
	end
end
function UTCAsDate(f10_arg0)
	if tonumber(f10_arg0) > 0 then
		return Engine[0x952C108C4897E9A](f10_arg0)
	else
		return ""
	end
end
function UTCStringAsDate(f11_arg0)
	return Engine[0x72B3321101CFE15](f11_arg0, false, false)
end
function UTCStringAsShortDate(f12_arg0)
	return Engine[0x72B3321101CFE15](f12_arg0, false, true)
end
function DistanceInMetricString(f13_arg0)
	local f13_local0 = math.floor(f13_arg0 / 1000)
	return Engine[0xF9F1239CFD921FE](0x7453D11DFE4B5A9, f13_local0, f13_arg0 - f13_local0 * 1000)
end
function GetRightAlignedCharacter(f14_arg0, f14_arg1, f14_arg2)
	local f14_local0 = f14_arg2:len() - f14_arg1 - f14_arg0
	if f14_local0 > 0 and f14_local0 <= f14_arg2:len() then
		return f14_arg2:sub(f14_local0, f14_local0)
	else
		return ""
	end
end
function SetValueIfEmptyString(f15_arg0, f15_arg1)
	if f15_arg1 == "" then
		return f15_arg0
	else
		return f15_arg1
	end
end
function SetValueIfNumberEqualTo(f16_arg0, f16_arg1, f16_arg2)
	if f16_arg2 == f16_arg0 then
		return f16_arg1
	else
		return f16_arg2
	end
end
function ImageIsEverywhereButDurango(f17_arg0)
	return CoD.isDurango and "$white" or f17_arg0
end
function ImageIsOnlyOnOrbis(f18_arg0)
	if CoD.isPS4 then
		local f18_local0 = f18_arg0
	end
	return f18_local0 or "$white"
end
function ImageIsOnlyOnDurangoOrPc(f19_arg0)
	if CoD.isDurango or CoD.isPC then
		local f19_local0 = f19_arg0
	end
	return f19_local0 or "$white"
end
function AppendCurrentSessionMode(f20_arg0)
	return f20_arg0 .. "_" .. string.lower(Engine[0x5AA137994DA7513]())
end
function AppendCurrentSessionModeOrTheater(f21_arg0)
	if Engine[0xA55C3ACD0D2BCF0]() then
		return f21_arg0 .. "_theater"
	else
		return f21_arg0 .. "_" .. string.lower(Engine[0x5AA137994DA7513]())
	end
end
function NumberAsPercentRounded(f22_arg0)
	local f22_local0 = math.floor(f22_arg0 * 100 + 0.5)
	if f22_arg0 < 1 and f22_local0 == 100 then
		f22_local0 = 99
	elseif f22_arg0 > 0 and f22_local0 == 0 then
		f22_local0 = 1
	end
	return Engine[0xF9F1239CFD921FE](0x16A7A1F8ECC8C64, tostring(f22_local0))
end
function NumberAsPercent(f23_arg0)
	return Engine[0xF9F1239CFD921FE](0x16A7A1F8ECC8C64, tostring(f23_arg0))
end
function LocalizeString(f24_arg0)
	return Engine[0xED84C33EC5F01EA](f24_arg0)
end
function LocalizeHash(f25_arg0)
	return Engine[0xF9F1239CFD921FE](f25_arg0)
end
function LocalizeIntoString(f26_arg0, f26_arg1)
	return Engine[0xF9F1239CFD921FE](f26_arg0, f26_arg1)
end
function LocalizeIntoStringIfNotEmpty(f27_arg0, f27_arg1)
	local f27_local0
	if f27_arg1 == "" then
		f27_local0 = ""
		if not f27_local0 then
		else
			return f27_local0
		end
	end
	f27_local0 = Engine[0xF9F1239CFD921FE](f27_arg0, f27_arg1)
end
function LocalizeToUpperString(f28_arg0)
	return Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](f28_arg0))
end
function ConvertToUpperString(f29_arg0)
	return Engine[0xB03220D3A4F3E38](f29_arg0)
end
function ToUpper(f30_arg0)
	return Engine[0xB03220D3A4F3E38](f30_arg0)
end
function AppendString(f31_arg0, f31_arg1)
	return f31_arg1 .. f31_arg0
end
function AppendStringIfSourceNotEmpty(f32_arg0, f32_arg1)
	if string.len(f32_arg1) >= 1 then
		return f32_arg1 .. f32_arg0
	else
		return ""
	end
end
function LanguageOverrideNumber(f33_arg0, f33_arg1, f33_arg2)
	if IsCurrentLanguageTextEqualTo(f33_arg0) then
		local f33_local0 = f33_arg1
	end
	return f33_local0 or f33_arg2
end
function LanguageOverrideNumberForScale(f34_arg0, f34_arg1, f34_arg2, f34_arg3)
	if IsCurrentLanguageTextEqualTo(f34_arg0) then
		return f34_arg1, f34_arg1
	else
		return f34_arg2, f34_arg3
	end
end
function SessionModeOverrideNumber(f35_arg0, f35_arg1, f35_arg2)
	if Engine[0x3EAC408F958FF05]() == f35_arg0 then
		local f35_local0 = f35_arg1
	end
	return f35_local0 or f35_arg2
end
function AppendLocalizeString(f36_arg0, f36_arg1)
	return f36_arg1 .. Engine[0xED84C33EC5F01EA](f36_arg0)
end
function PrependString(f37_arg0, f37_arg1)
	return f37_arg0 .. f37_arg1
end
function PrependLocalizeString(f38_arg0, f38_arg1)
	return Engine[0xF9F1239CFD921FE](f38_arg0) .. f38_arg1
end
function PrependToLocalizeStringIfNotEmpty(f39_arg0, f39_arg1)
	local f39_local0
	if f39_arg1 ~= "" and f39_arg1 ~= 0x0 then
		f39_local0 = f39_arg0 .. Engine[0xF9F1239CFD921FE](f39_arg1)
		if not f39_local0 then
		else
			return f39_local0
		end
	end
	f39_local0 = ""
end
function PrependLocalizedStringWithSeparator(f40_arg0, f40_arg1, f40_arg2)
	return Engine[0xF9F1239CFD921FE](f40_arg0) .. f40_arg1 .. f40_arg2
end
function PrependLevelTypeStringWithSeparator(f41_arg0, f41_arg1)
	local f41_local0 = 0x99A97D1A6F94031
	if Engine[0x3EAC408F958FF05]() == Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39] then
		f41_local0 = 0xE15E03CF165A930
	elseif LuaUtils.IsArenaMode() then
		f41_local0 = 0x3370355189B42A7
	end
	return Engine[0xF9F1239CFD921FE](f41_local0) .. f41_arg0 .. f41_arg1
end
function SplitString(f42_arg0, f42_arg1)
	return unpack(LUI.splitString(f42_arg1, f42_arg0))
end
function StringAsClanTag(f43_arg0)
	if not f43_arg0 or f43_arg0 == "" then
		return ""
	else
		return "[" .. f43_arg0 .. "]"
	end
end
function PrependClanTagToHostname(f44_arg0, f44_arg1)
	return StringAsClanTag(Engine[0x614D394F6F9A18D](Engine[0x40E824FE270E174](f44_arg0, "clantag"))) .. f44_arg1
end
function InlineStringAsClanTag(f45_arg0)
	if not f45_arg0 or f45_arg0 == "" then
		return ""
	else
		return Engine[0xF9F1239CFD921FE](0x7A487C443E58143, f45_arg0)
	end
end
function GetFirstSignedInController(f46_arg0)
	return Engine[0xF9F1239CFD921FE](0xFAACA5179AA8A57, Engine[0x54689B3A7B3899E](0))
end
function Negate(f47_arg0)
	return 1 - f47_arg0
end
function Add(f48_arg0, f48_arg1)
	return f48_arg1 + f48_arg0
end
function AddWithoutPreview(f49_arg0, f49_arg1)
	return Add(f49_arg0, f49_arg1)
end
function Multiple(f50_arg0, f50_arg1)
	return f50_arg1 * f50_arg0
end
function Value1IfTrueElseValue2(f51_arg0, f51_arg1, f51_arg2)
	if f51_arg2 then
		return f51_arg0
	else
		return f51_arg1
	end
end
function ZeroIfEqualElseArg(f52_arg0, f52_arg1, f52_arg2)
	local f52_local0
	if f52_arg2 == f52_arg0 then
		f52_local0 = 0
		if not f52_local0 then
		else
			return f52_local0
		end
	end
	f52_local0 = f52_arg1
end
function InverseZeroAndOne(f53_arg0)
	local f53_local0
	if f53_arg0 == 0 then
		f53_local0 = 1
		if not f53_local0 then
		else
			return f53_local0
		end
	end
	f53_local0 = 0
end
function StringAdd(f54_arg0, f54_arg1)
	return tostring((tonumber(f54_arg1) or 0) + f54_arg0)
end
function StringMultiply(f55_arg0, f55_arg1)
	return tostring((tonumber(f55_arg1) or 0) * f55_arg0)
end
function FormatNumberAsString(f56_arg0, f56_arg1)
	return string.format("%." .. f56_arg0 .. "f", f56_arg1)
end
function RandomAddPercent(f57_arg0, f57_arg1)
	return f57_arg1 + math.random() * f57_arg0 * 0.01
end
function HideIfNotEmptyString(f58_arg0)
	if f58_arg0 ~= nil and f58_arg0 ~= "" then
		return 0
	else
		return 1
	end
end
function HideIfEmptyString(f59_arg0)
	if f59_arg0 ~= nil and f59_arg0 ~= "" then
		return 1
	else
		return 0
	end
end
function HideIfNumEqualTo(f60_arg0, f60_arg1)
	if f60_arg0 == f60_arg1 then
		return 0
	else
		return 1
	end
end
function ShowIfNumEqualTo(f61_arg0, f61_arg1)
	if f61_arg0 == f61_arg1 then
		return 1
	else
		return 0
	end
end
function BlackTransparentIfNilOrEmpty(f62_arg0)
	if f62_arg0 == nil or f62_arg0 == "" then
		return "blacktransparent"
	else
		return f62_arg0
	end
end
function ConsoleColorFromIndex(f63_arg0, f63_arg1)
	local f63_local0 = {
		r = 1,
		g = 1,
		b = 1,
	}
	if f63_arg1 == Enum[0x97A8DF5F2FA8BD5][0xF51088437AB5AF5] then
		f63_local0 = CoD.TeamUtility.GetColorSetEnemyOrShoutCasterColor(f63_arg0)
	elseif f63_arg1 == Enum[0x97A8DF5F2FA8BD5][0x4D3BDE8AD3D7704] then
		f63_local0 = CoD.TeamUtility.GetColorSetFriendlyOrShoutCasterColor(f63_arg0)
	elseif f63_arg1 ~= Enum[0x97A8DF5F2FA8BD5][0x4A8B270BE295E3E] then
		local f63_local1, f63_local2, f63_local3 = Engine[0xF8C039759157EA2](f63_arg0, f63_arg1)
		f63_local0 = {
			r = f63_local1,
			g = f63_local2,
			b = f63_local3,
		}
	end
	return f63_local0.r, f63_local0.g, f63_local0.b
end
function RedForHighGPUTemperature(f64_arg0, f64_arg1, f64_arg2, f64_arg3, f64_arg4)
	local f64_local0 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "PCTelemetry.GPUTemperature")
	f64_local0 = f64_local0:get()
	local f64_local1 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "PCTelemetry.showGPUTemp")
	if f64_local0 >= 85 then
		f64_local1:set(1)
		f64_arg2 = 1
		f64_arg3 = 0
		f64_arg4 = 0
		f64_arg0.LabelIsRed = true
	elseif f64_arg0.LabelIsRed then
		Engine[0x83C9B5DE1D9371](f64_local1, Engine[0xD4D7317F380395F](f64_arg1, 0x866C1C9ACD412B6) or 0)
		f64_arg0.LabelIsRed = nil
	end
	return f64_arg2, f64_arg3, f64_arg4
end
function CodPointsColor(f65_arg0, f65_arg1, f65_arg2, f65_arg3, f65_arg4)
	local f65_local0 = CoD.SafeGetModelValue(Engine[0x4DF5CFBC1771947](f65_arg1), f65_arg0)
	if f65_local0 and f65_local0 < 0 then
		return 1, 0, 0
	else
		return f65_arg2, f65_arg3, f65_arg4
	end
end
function GetColorBlindSafeColorFromBase(f66_arg0, f66_arg1, f66_arg2)
	local f66_local0 = CoD.ColorUtility.GetColorBlindColorForPlayer(f66_arg1, f66_arg0)
	if f66_local0 then
		return CoD.ColorUtility.ExplodeColor(f66_local0)
	else
		return 0, 0, 0
	end
end
function ColorMultiply(f67_arg0, f67_arg1, f67_arg2, f67_arg3)
	if type(f67_arg1) == "string" then
		local f67_local0, f67_local1, f67_local2 = SplitString(" ", f67_arg1)
		f67_arg1 = f67_local0 / 255
		f67_arg2 = f67_local1 / 255
		f67_arg3 = f67_local2 / 255
	end
	f67_arg0 = math.max(math.min(f67_arg0, 1), 0)
	return f67_arg1 * f67_arg0, f67_arg2 * f67_arg0, f67_arg3 * f67_arg0
end
function SplitRgbaStringToColor(f68_arg0)
	local f68_local0, f68_local1, f68_local2, f68_local3 = SplitString(" ", f68_arg0)
	return f68_local0, f68_local1, f68_local2
end
function AddToVector(f69_arg0, f69_arg1, f69_arg2, f69_arg3, f69_arg4, f69_arg5, f69_arg6, f69_arg7)
	return f69_arg4 + f69_arg0, f69_arg5 + f69_arg1, f69_arg6 + f69_arg2, f69_arg7 + f69_arg3
end
function SubtractVectorComponentFrom(f70_arg0, f70_arg1, f70_arg2, f70_arg3, f70_arg4, f70_arg5)
	if f70_arg0 == 1 then
		f70_arg2 = f70_arg1 - f70_arg2
	elseif f70_arg0 == 2 then
		f70_arg3 = f70_arg1 - f70_arg3
	elseif f70_arg0 == 3 then
		f70_arg4 = f70_arg1 - f70_arg4
	elseif f70_arg0 == 4 then
		f70_arg5 = f70_arg1 - f70_arg5
	end
	return f70_arg2, f70_arg3, f70_arg4, f70_arg5
end
function AdjustStartEnd(f71_arg0, f71_arg1, f71_arg2, f71_arg3, f71_arg4, f71_arg5)
	return f71_arg2 * (f71_arg1 - f71_arg0) + f71_arg0, f71_arg3, f71_arg4, f71_arg5
end
function ScaleVector(f72_arg0, f72_arg1, f72_arg2, f72_arg3, f72_arg4)
	return f72_arg1 * f72_arg0, f72_arg2 * f72_arg0, f72_arg3 * f72_arg0, f72_arg4 * f72_arg0
end
function ScaleVectorComponents(f73_arg0, f73_arg1, f73_arg2, f73_arg3, f73_arg4, f73_arg5, f73_arg6, f73_arg7)
	return f73_arg4 * f73_arg0, f73_arg5 * f73_arg1, f73_arg6 * f73_arg2, f73_arg7 * f73_arg3
end
function SetVectorComponent(f74_arg0, f74_arg1, f74_arg2, f74_arg3, f74_arg4, f74_arg5)
	if f74_arg0 == 1 then
		f74_arg2 = f74_arg1
	elseif f74_arg0 == 2 then
		f74_arg3 = f74_arg1
	elseif f74_arg0 == 3 then
		f74_arg4 = f74_arg1
	elseif f74_arg0 == 4 then
		f74_arg5 = f74_arg1
	end
	return f74_arg2, f74_arg3, f74_arg4, f74_arg5
end
function CreateVectorFromNum(f75_arg0, f75_arg1, f75_arg2, f75_arg3)
	return f75_arg0, f75_arg0, f75_arg0, f75_arg0
end
function IgnoreLastVectorComponents(f76_arg0, f76_arg1, f76_arg2, f76_arg3, f76_arg4)
	if f76_arg0 == 0 then
		return f76_arg1, f76_arg2, f76_arg3, f76_arg4
	elseif f76_arg0 == 1 then
		return f76_arg1, f76_arg2, f76_arg3
	elseif f76_arg0 == 2 then
		return f76_arg1, f76_arg2
	elseif f76_arg0 == 3 then
		return f76_arg1
	else
		return nil
	end
end
function SwapVectorComponents(f77_arg0, f77_arg1, f77_arg2, f77_arg3, f77_arg4, f77_arg5)
	local f77_local0 = {
		f77_arg2,
		f77_arg3,
		f77_arg4,
		f77_arg5,
	}
	local f77_local1 = f77_local0[f77_arg0]
	f77_local0[f77_arg0] = f77_local0[f77_arg1]
	f77_local0[f77_arg1] = f77_local1
	return unpack(f77_local0)
end
function UnitsToMeters(f78_arg0)
	if type(f78_arg0) ~= "number" then
		return ""
	else
		return string.format("%.0f", f78_arg0 * 0.03)
	end
end
function LocalizeStringWithDatasource(f79_arg0, f79_arg1, f79_arg2)
	return Engine[0xF9F1239CFD921FE](f79_arg2, CoD.SafeGetModelValue(Engine[0x4DF5CFBC1771947](f79_arg1), f79_arg0))
end
function LocalizeStringWithParameter(f80_arg0, f80_arg1)
	return Engine[0xF9F1239CFD921FE](f80_arg0, f80_arg1)
end
function LocalizeStringWithParameterAndStripBattletag(f81_arg0, f81_arg1)
	return Engine[0xF9F1239CFD921FE](f81_arg0, CoD.SocialUtility.CleanGamerTag(f81_arg1))
end
function NumAbs(f82_arg0)
	return tostring(math.abs(tonumber(f82_arg0)))
end
function GetBubbleGumPackNameFromPackIndex(f83_arg0, f83_arg1)
	return Engine[0x8E3CB087BD6EF56](f83_arg0, f83_arg1)
end
function GetClientName(f84_arg0, f84_arg1)
	if type(f84_arg1) ~= "number" then
		return ""
	else
		return CoD.SocialUtility.CleanGamerTag(Engine[0x7DC6B423FDDBCAD](f84_arg0, f84_arg1))
	end
end
function GetClientClantag(f85_arg0, f85_arg1)
	if type(f85_arg1) ~= "number" then
		return ""
	else
		return Engine[0xF152471A3D15A55](f85_arg0, f85_arg1)
	end
end
function GetClientNameAndClanTag(f86_arg0, f86_arg1)
	return GetClientClantag(f86_arg0, f86_arg1) .. GetClientName(f86_arg0, f86_arg1)
end
function GetLocalClientXuid(f87_arg0, f87_arg1)
	return Engine[0x93B19E01B1FD1C7](f87_arg0)
end
function StorageLookup(f88_arg0, f88_arg1, f88_arg2)
	local f88_local0 = Engine[0x8BF970606552F4C](f88_arg0, f88_arg2)
	if f88_local0 == nil then
		return
	end
	for f88_local4 in string.gmatch(f88_arg1, "[%w_]+") do
		f88_local0 = f88_local0[f88_local4]
	end
	return f88_local0:get()
end
function StorageLookupTwoStatRatio(f89_arg0, f89_arg1, f89_arg2, f89_arg3)
	return CoD.GetDisplayRatioFromTwoStats(StorageLookup(f89_arg0, f89_arg1, f89_arg3), StorageLookup(f89_arg0, f89_arg2, f89_arg3))
end
function StorageLookupSPM(f90_arg0, f90_arg1, f90_arg2, f90_arg3)
	return math.floor(StorageLookup(f90_arg0, f90_arg1, f90_arg3) / math.max(1, StorageLookup(f90_arg0, f90_arg2, f90_arg3) / 60) + 0.5)
end
function CombatRecordGetItemStatForItemIndex(f91_arg0, f91_arg1, f91_arg2)
	local f91_local0 = CoD.GetCombatRecordStatForPath(CoD.GetCombatRecordStats(f91_arg0), "ItemStats." .. f91_arg2 .. ".stats." .. f91_arg1)
	if f91_local0 then
		return f91_local0
	else
		return ""
	end
end
function CombatRecordGetComparisonItemStatForItemIndex(f92_arg0, f92_arg1, f92_arg2)
	local f92_local0 = nil
	local f92_local1 = CoD.GetCombatRecordComparisonStats(f92_arg0)
	if f92_local1 then
		f92_local0 = CoD.GetCombatRecordStatForPath(f92_local1, "ItemStats." .. f92_arg2 .. ".stats." .. f92_arg1)
	end
	if f92_local0 then
		return f92_local0
	else
		return ""
	end
end
function CombatRecordGetTwoStatRatioForItemIndex(f93_arg0, f93_arg1, f93_arg2, f93_arg3)
	local f93_local0 = CoD.GetCombatRecordStats(f93_arg0)
	return CoD.GetDisplayRatioFromTwoStats(CoD.GetCombatRecordStatForPath(f93_local0, "ItemStats." .. f93_arg3 .. ".stats." .. f93_arg1), CoD.GetCombatRecordStatForPath(f93_local0, "ItemStats." .. f93_arg3 .. ".stats." .. f93_arg2))
end
function CombatRecordGetComparisonTwoStatRatioForItemIndex(f94_arg0, f94_arg1, f94_arg2, f94_arg3)
	local f94_local0, f94_local1 = nil
	local f94_local2 = CoD.GetCombatRecordComparisonStats(f94_arg0)
	if f94_local2 then
		f94_local0 = CoD.GetCombatRecordStatForPath(f94_local2, "ItemStats." .. f94_arg3 .. ".stats." .. f94_arg1)
		f94_local1 = CoD.GetCombatRecordStatForPath(f94_local2, "ItemStats." .. f94_arg3 .. ".stats." .. f94_arg2)
	end
	return CoD.GetDisplayRatioFromTwoStats(f94_local0, f94_local1)
end
function CombatRecordGetItemKillsOrAssistsForItemIndex(f95_arg0, f95_arg1)
	local f95_local0 = "kills"
	if Engine[0x3D0E017B2C4C7E3](f95_arg1, CoD.GetCombatRecordMode()) then
		f95_local0 = "assists"
	end
	local f95_local1 = CoD.GetCombatRecordStatForPath(CoD.GetCombatRecordStats(f95_arg0), "ItemStats." .. f95_arg1 .. ".stats." .. f95_local0)
	if f95_local1 then
		return f95_local1
	else
		return ""
	end
end
function CombatRecordGetComparisonItemKillsOrAssistsForItemIndex(f96_arg0, f96_arg1)
	local f96_local0 = "kills"
	if Engine[0x3D0E017B2C4C7E3](f96_arg1, CoD.GetCombatRecordMode()) then
		f96_local0 = "assists"
	end
	local f96_local1 = nil
	local f96_local2 = CoD.GetCombatRecordComparisonStats(f96_arg0)
	if f96_local2 then
		f96_local1 = CoD.GetCombatRecordStatForPath(f96_local2, "ItemStats." .. f96_arg1 .. ".stats." .. f96_local0)
	end
	if f96_local1 then
		return f96_local1
	else
		return ""
	end
end
function CombatRecordGetKillsOrAssistsRatioForItemIndex(f97_arg0, f97_arg1, f97_arg2)
	local f97_local0 = "kills"
	if Engine[0x3D0E017B2C4C7E3](f97_arg2, CoD.GetCombatRecordMode()) then
		f97_local0 = "assists"
	end
	local f97_local1 = CoD.GetCombatRecordStats(f97_arg0)
	return CoD.GetDisplayRatioFromTwoStats(CoD.GetCombatRecordStatForPath(f97_local1, "ItemStats." .. f97_arg2 .. ".stats." .. f97_local0), CoD.GetCombatRecordStatForPath(f97_local1, "ItemStats." .. f97_arg2 .. ".stats." .. f97_arg1))
end
function CombatRecordGetComparisonKillsOrAssistsRatioForItemIndex(f98_arg0, f98_arg1, f98_arg2)
	local f98_local0 = "kills"
	if Engine[0x3D0E017B2C4C7E3](f98_arg2, CoD.GetCombatRecordMode()) then
		f98_local0 = "assists"
	end
	local f98_local1, f98_local2 = nil
	local f98_local3 = CoD.GetCombatRecordComparisonStats(f98_arg0)
	if f98_local3 then
		f98_local1 = CoD.GetCombatRecordStatForPath(f98_local3, "ItemStats." .. f98_arg2 .. ".stats." .. f98_local0)
		f98_local2 = CoD.GetCombatRecordStatForPath(f98_local3, "ItemStats." .. f98_arg2 .. ".stats." .. f98_arg1)
	end
	return CoD.GetDisplayRatioFromTwoStats(f98_local1, f98_local2)
end
function RankToLevelNumber(f99_arg0, f99_arg1)
	return Engine[0xE1DE4A6CE92B4FD](f99_arg1, CoD.ModeStringToMode(f99_arg0))
end
function LevelStringFromStorage(f100_arg0, f100_arg1, f100_arg2)
	local f100_local0 = CoD.ModeStringToMode(f100_arg1)
	if LuaUtils.GameModeAvailable(f100_local0) then
		if IsGameModeParagonCapable(f100_local0) and CoD.PrestigeUtility.GetPrestigeCap(f100_local0) <= StorageLookup(f100_arg0, "playerstatslist.plevel.statvalue", f100_arg2) then
			return Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0x21235EA457AB637, Engine[0x801A572E417CC01](StorageLookup(f100_arg0, "playerstatslist.paragon_rank.statvalue", f100_arg2), f100_local0)))
		else
			return Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0x21235EA457AB637, Engine[0xE1DE4A6CE92B4FD](StorageLookup(f100_arg0, "playerstatslist.rank.statvalue", f100_arg2), f100_local0)))
		end
	else
		return Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](0x21235EA457AB637, 0))
	end
end
function RankTitleFromStorage(f101_arg0, f101_arg1, f101_arg2)
	return CoD.GetRankName(StorageLookup(f101_arg0, "playerstatslist.rank.statvalue", f101_arg2), StorageLookup(f101_arg0, "playerstatslist.plevel.statvalue", f101_arg2), CoD.ModeStringToMode(f101_arg1))
end
function GetRankOrParagonIcon(f102_arg0, f102_arg1, f102_arg2, f102_arg3, f102_arg4, f102_arg5)
	local f102_local0 = CoD.ModeStringToMode(f102_arg4)
	local f102_local1 = StorageLookup(f102_arg0, f102_arg1, f102_arg5)
	local f102_local2 = StorageLookup(f102_arg0, f102_arg2, f102_arg5)
	if IsGameModeParagonCapable(f102_local0) and f102_local2 == CoD.PrestigeUtility.GetPrestigeCap(f102_local0) then
		local f102_local3 = StorageLookup(f102_arg0, f102_arg3, f102_arg5)
		if f102_local3 ~= CoD.PrestigeUtility.INVALID_PARAGON_ICON_ID then
			return Engine[0x142BF2BEA87722E](f102_local3, f102_local0)
		end
	end
	return Engine[0x9C6922557618920](f102_local1, f102_local2, f102_local0)
end
function GetRankIconLarge(f103_arg0)
	if not f103_arg0 or f103_arg0 == "" or f103_arg0 == 0x0 or f103_arg0 == 0x7615068F50B3D66 or f103_arg0 == 0x214ECBA8C04D44C then
		return 0x214ECBA8C04D44C
	else
		return f103_arg0 .. "_large"
	end
end
function LocalServerStatusToString(f104_arg0)
	if f104_arg0 == 0 then
		return 0xDA680012C01968D
	else
		return 0xEF105DFE1446B3B
	end
end
function PresenceToModeString(f105_arg0)
	local f105_local0 = tonumber(f105_arg0)
	if f105_local0 == Enum[0x4BBA402DE649132][0x1CF21FD793411B9] then
		return 0x72BB745FED1CD7E
	elseif f105_local0 == Enum[0x4BBA402DE649132][0xA2184EBB293AF2D] or f105_local0 == Enum[0x4BBA402DE649132][0xC14960E60DA36B7] then
		return 0x8E783C525F2FA8
	elseif f105_local0 >= Enum[0x4BBA402DE649132][0x69F9F19327AE3B3] and f105_local0 <= Enum[0x4BBA402DE649132][0x59DAD56E9325476] then
		return 0xC00E43A2AA46CC4
	elseif f105_local0 >= Enum[0x4BBA402DE649132][0x1DB40BC5D7A26F2] and f105_local0 <= Enum[0x4BBA402DE649132][0xDD9D1D4A601036C] then
		return LuaUtils.GetDisplayNameForEMode(Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A])
	elseif f105_local0 >= Enum[0x4BBA402DE649132][0x1632587246C118A] and f105_local0 <= Enum[0x4BBA402DE649132][0xEDDB0D016B3F54] then
		return LuaUtils.GetDisplayNameForEMode(Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5])
	elseif f105_local0 >= Enum[0x4BBA402DE649132][0x61619C03C7E6934] and f105_local0 <= Enum[0x4BBA402DE649132][0x886E7F57ED1ED3A] then
		return 0x62CDF997F090DB1
	elseif f105_local0 >= Enum[0x4BBA402DE649132][0x79F90DEF3681532] and f105_local0 <= Enum[0x4BBA402DE649132][0x35923F6DC7C09AC] then
		return LuaUtils.GetDisplayNameForEMode(Enum[0x9C0C2196D8313A0][0xBF1DCC8138A9D39])
	elseif f105_local0 >= Enum[0x4BBA402DE649132][0x5EEADE3AFEF0F50] and f105_local0 <= Enum[0x4BBA402DE649132][0xAE1F1FC5A87498E] then
		return 0x7D527CD96A3419
	else
		return 0x2C79EA24AB1A2BA
	end
end
function StickyPartyStatusToString(f106_arg0)
	local f106_local0 = CoD.LobbyUtility.Presence.StickyLobbyStrings[f106_arg0]
	if f106_local0 ~= nil then
		return f106_local0
	else
		return 0x2C79EA24AB1A2BA
	end
end
function LobbyJoinableToString(f107_arg0)
	local f107_local0 = CoD.LobbyUtility.Presence.LobbyJoinableStrings[tonumber(f107_arg0)]
	if f107_local0 ~= nil then
		return f107_local0
	else
		return 0x34F5097A432DED7
	end
end
function PlatformPresenceToLocalizedString(f108_arg0)
	local f108_local0 = f108_arg0
	if f108_arg0 == "" or CoD.isDurango and (f108_arg0 == "???" or f108_arg0 == "Default Title") then
		return ""
	else
		return f108_arg0
	end
end
function SocialShowPartyHeader(f109_arg0)
	if 0 < f109_arg0 then
		return 1
	else
		return 0
	end
end
function ShowPlatformPresence(f110_arg0)
	local f110_local0 = tonumber(f110_arg0)
	if enumValue == 0 then
		return 1
	else
		return 0
	end
end
function LocalizeWithNatType(f111_arg0)
	local f111_local0 = tonumber(f111_arg0)
	if f111_local0 == 1 then
		return Engine[0xF9F1239CFD921FE](0xBE02352B7C7ADA9, Engine[0xF9F1239CFD921FE](0x6ED205D2902BCCD))
	elseif f111_local0 == 2 then
		return Engine[0xF9F1239CFD921FE](0xBE02352B7C7ADA9, Engine[0xF9F1239CFD921FE](0x6382C5E67F9468C))
	elseif f111_local0 == 3 then
		return Engine[0xF9F1239CFD921FE](0xBE02352B7C7ADA9, Engine[0xF9F1239CFD921FE](0x9AA44209F0D1934))
	else
		return Engine[0xF9F1239CFD921FE](0xBE02352B7C7ADA9, Engine[0xF9F1239CFD921FE](0xBB00DBB82414EFB))
	end
end
function PartyPrivacy(f112_arg0)
	return LobbyData.PartyPrivacyToString(tonumber(f112_arg0))
end
function DivideByScoreLimit(f113_arg0, f113_arg1, f113_arg2, f113_arg3, f113_arg4)
	local f113_local0 = nil
	if Dvar[0xFF54369D6573B91]:get() == "dom" or Dvar[0xFF54369D6573B91]:get() == "ball" or Dvar[0xFF54369D6573B91]:get() == "dom_dm" then
		local f113_local1 = Engine[0xDBC2AD5002B261B](0x1BE65BD13DB0766) or 0
		local f113_local2 = Engine[0xDBC2AD5002B261B](0x521DCAB34B80E72) or 0
		if f113_local1 > 2 then
			f113_local0 = (Engine[0x9672E391E0BF3DD](f113_arg0) + 1) * f113_local2
		else
			f113_local0 = f113_local1 * f113_local2
		end
	else
		f113_local0 = CoD.SafeGetModelValue(Engine[0x4DF5CFBC1771947](f113_arg0), "gameScore.scoreLimit")
	end
	if f113_local0 then
		return f113_arg1 / f113_local0, f113_arg2 / f113_local0, f113_arg3 / f113_local0, f113_arg4 / f113_local0
	else
		return f113_arg1, f113_arg2, f113_arg3, f113_arg4
	end
end
function SessionModeToLocalizedSessionMode(f114_arg0)
	local f114_local0 = 0x55D96CC762EABDD
	if f114_arg0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		f114_local0 = 0xB06081B8B4567F2
	elseif f114_arg0 == Enum[0x9C0C2196D8313A0][0x60063C67132EB69] then
		f114_local0 = 0x62CDF997F090DB1
	end
	return Engine[0xF9F1239CFD921FE](f114_local0)
end
function SessionModeToUnlocalizedSessionModeCaps(f115_arg0)
	local f115_local0 = 0x55D96CC762EABDD
	if f115_arg0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
		f115_local0 = 0xB06081B8B4567F2
	elseif f115_arg0 == Enum[0x9C0C2196D8313A0][0x60063C67132EB69] then
		f115_local0 = 0x62CDF997F090DB1
	end
	return f115_local0
end
function MapNameToLocalizedMapName(f116_arg0)
	return Engine[0xB03220D3A4F3E38](CoD.MapUtility.GetLocalizedMapValue(f116_arg0, "mapName", ""))
end
function MapNameToLocalizedMapDetailedName(f117_arg0, f117_arg1, f117_arg2)
	local f117_local0 = Engine[0xB03220D3A4F3E38](CoD.MapUtility.GetLocalizedMapValue(f117_arg2, f117_arg1, ""))
	if f117_local0 and f117_local0 ~= 0x0 then
		return CoD.StoreUtility.PrependPurchaseIconIfNeeded(f117_arg0, f117_arg2, f117_local0)
	else
		return 0x0
	end
end
function MapNameToLocalizedMapDetailedNameIfPurchasable(f118_arg0, f118_arg1, f118_arg2, f118_arg3)
	local f118_local0 = Engine[0xB03220D3A4F3E38](CoD.MapUtility.GetLocalizedMapValue(f118_arg3, f118_arg2, ""))
	if f118_local0 and f118_local0 ~= 0x0 then
		return f118_local0
	else
		return 0x0
	end
end
function MapNameToLocalizedMapDescription(f119_arg0)
	return CoD.MapUtility.GetLocalizedMapValue(f119_arg0, "mapDescription", "")
end
function MapNameToLocalizedMapDetailedDescription(f120_arg0, f120_arg1)
	local f120_local0 = CoD.MapUtility.GetLocalizedMapValue(f120_arg1, "mapDescription", "")
	if f120_local0 and f120_local0 ~= "" then
		return CoD.StoreUtility.AddUpsellToDescriptionIfNeeded(f120_arg0, f120_arg1, Engine[0xF9F1239CFD921FE](f120_local0))
	else
		return ""
	end
end
function MapNameToMapImage(f121_arg0)
	return CoD.BaseUtility.GetMapValue(f121_arg0, "previewImage", "$black")
end
function MapNameToMapLoadingImage(f122_arg0, f122_arg1)
	return CoD.BaseUtility.GetMapValue(f122_arg1, CoD.isWarzone and "$black" or "loadingImage", "$black")
end
function GameTypeToLocalizedGameType(f123_arg0)
	if f123_arg0 == nil or f123_arg0 == "" or f123_arg0 == 0x0 then
		return ""
	else
		local f123_local0 = Engine[0xEA74FA7EE46E195](f123_arg0)
		if f123_local0.nameRefCaps == nil then
			return ""
		else
			return Engine[0xF9F1239CFD921FE](f123_local0.nameRefCaps)
		end
	end
end
function GameTypeToLocalizedGameTypeDescription(f124_arg0)
	if f124_arg0 == nil or f124_arg0 == "" or f124_arg0 == 0x0 then
		return ""
	else
		local f124_local0 = Engine[0xEA74FA7EE46E195](f124_arg0)
		if f124_local0.descriptionRef == nil then
			return ""
		else
			return Engine[0xF9F1239CFD921FE](f124_local0.descriptionRef)
		end
	end
end
function GameTypeToImage(f125_arg0)
	if f125_arg0 == nil or f125_arg0 == "" then
		return ""
	else
		local f125_local0 = Engine[0xEA74FA7EE46E195](f125_arg0)
		return f125_local0.image
	end
end
function GetGametypeImage(f126_arg0)
	return GameTypeToImage(Engine[0x69811927938FCD7]())
end
function LocalizedGameType(f127_arg0)
	local f127_local0 = Engine[0xEA74FA7EE46E195](Engine[0x69811927938FCD7]())
	return f127_local0.nameRefCaps and Engine[0xF9F1239CFD921FE](f127_local0.nameRefCaps) or ""
end
function GetGameModeOnMapName(f128_arg0)
	return CoD.BaseUtility.GetGameModeOnMapNameString(Engine[0x69811927938FCD7](), Engine[0xE67E7253CC272C9]())
end
function GetGameMode(f129_arg0)
	local f129_local0 = Engine[0xEA74FA7EE46E195](Engine[0x69811927938FCD7]())
	local f129_local1
	if f129_local0 then
		f129_local1 = Engine[0xF9F1239CFD921FE](f129_local0.nameRef)
		if not f129_local1 then
		else
			return f129_local1
		end
	end
	f129_local1 = ""
end
function GetMapName(f130_arg0)
	local f130_local0 = Engine[0xE67E7253CC272C9]()
	return CoD.MapUtility.GetLocalizedMapValue(f130_local0, "mapName", f130_local0)
end
function GetHeroIndexForClientNum(f131_arg0, f131_arg1)
	local f131_local0 = f131_arg1
	if f131_local0 == -1 then
		return 0
	else
		local f131_local1 = Engine[0xEE799A4C64E4559](f131_arg0, f131_local0)
		if f131_local1 ~= nil then
			return f131_local1
		else
			return 0
		end
	end
end
function GetCharacterDisplayNameByIndex(f132_arg0)
	return CoD.PlayerRoleUtility.GetCharacterDisplayNameByIndex(f132_arg0, Engine[0x3EAC408F958FF05]())
end
function GetPositionDraftStatePortraitByIndex(f133_arg0, f133_arg1)
	local f133_local0 = f133_arg1
	local f133_local1 = f133_arg0
	local f133_local2 = CoD.PlayerRoleUtility.GetCachedHeroInfo(Engine[0x3EAC408F958FF05](), f133_local0)
	local f133_local3 = nil
	if f133_local2 and f133_local2.positionDraftPortrait then
		f133_local3 = f133_local2.positionDraftPortrait
		if f133_local1 == CoD.HUDUtility.CharacterPortraitStates.CHARACTER_PORTRAIT_CRITICAL then
			f133_local3 = f133_local2.positionDraftPortraitCritical or f133_local3
		elseif f133_local1 == CoD.HUDUtility.CharacterPortraitStates.CHARACTER_PORTRAIT_WOUNDED then
			f133_local3 = f133_local2.positionDraftPortraitWounded or f133_local3
		elseif f133_local1 == CoD.HUDUtility.CharacterPortraitStates.CHARACTER_PORTRAIT_BUFFED then
			f133_local3 = f133_local2.positionDraftPortraitBuffed or f133_local3
		elseif f133_local1 == CoD.HUDUtility.CharacterPortraitStates.CHARACTER_PORTRAIT_HEALING then
			f133_local3 = f133_local2.positionDraftPortraitHealing or f133_local3
		end
	end
	return f133_local3 or "$blacktransparent"
end
function GetPositionDraftIconByIndex(f134_arg0)
	local f134_local0 = CoD.PlayerRoleUtility.GetCachedHeroInfo(Engine[0x3EAC408F958FF05](), f134_arg0)
	if f134_local0 == nil or f134_local0.positionDraftIcon == nil then
		return "$blacktransparent"
	else
		return f134_local0.positionDraftIcon
	end
end
function GetStoryMomentHintForFocusedCharacter(f135_arg0, f135_arg1)
	local f135_local0 = Engine[0x4DF5CFBC1771947](f135_arg0)
	f135_local0 = f135_local0:create("PositionDraft.focusedCharacterIndex")
	f135_local0 = f135_local0:get()
	if f135_local0 == nil or f135_local0 <= 0 then
		return ""
	end
	for f135_local4, f135_local5 in ipairs(CoD.PlayerRoleUtility.GetHeroList(Engine[0x3EAC408F958FF05]())) do
		if f135_local5.bodyIndex == f135_local0 then
			return Engine[0xF9F1239CFD921FE](0x2B2F5CD924F5F0D, Engine[0xF9F1239CFD921FE](f135_local5.displayName))
		end
	end
	return ""
end
function GetPrestigeTitleForPLevelAndMode(f136_arg0, f136_arg1)
	if f136_arg1 == CoD.PrestigeUtility.GetPrestigeCap(CoD.ModeStringToMode(f136_arg0)) then
		return Engine[0xF9F1239CFD921FE](0xD87A39C0FE06CA1)
	elseif f136_arg1 > 0 then
		return Engine[0xF9F1239CFD921FE](0x910399F02006FB7, f136_arg1)
	else
		return ""
	end
end
function GetPrestigeTitleText(f137_arg0, f137_arg1)
	if IsMaxPrestigeLevel(f137_arg0) then
		return Engine[0xF9F1239CFD921FE](0x754A8D073F00C06)
	else
		local f137_local0 = CoD.PrestigeUtility.GetCurrentPLevel(f137_arg0) + 1
		if IsAtXPCap(f137_arg0) and f137_local0 ~= CoD.PrestigeUtility.GetPrestigeCap(CoD.PrestigeUtility.GetPrestigeGameMode()) then
			return Engine[0xF9F1239CFD921FE](0xE574BBAD7F9CEAE, f137_local0)
		elseif f137_local0 == CoD.PrestigeUtility.GetPrestigeCap(CoD.PrestigeUtility.GetPrestigeGameMode()) then
			return Engine[0xF9F1239CFD921FE](0xD87A39C0FE06CA1)
		else
			return Engine[0xF9F1239CFD921FE](0x910399F02006FB7, f137_local0)
		end
	end
end
function HideIfPrestigeMaster(f138_arg0, f138_arg1)
	if IsMaxPrestigeLevel(f138_arg0) then
		return 0
	else
		return f138_arg1
	end
end
function SetToDisabledIfNotAtXPCap(f139_arg0, f139_arg1)
	if not IsMaxPrestigeLevel(f139_arg0) and not IsAtXPCap(f139_arg0) then
		f139_arg1 = f139_arg1 .. "_disabled"
	end
	return f139_arg1
end
function GetPermanentUnlockTokenText(f140_arg0, f140_arg1)
	local f140_local0 = 0xF57ABF99A89DCDD
	if f140_arg1 == 1 then
		f140_local0 = 0x2DCDC8722C33D24
	end
	return Engine[0xF9F1239CFD921FE](f140_local0, f140_arg1)
end
function SetToParagonColorIfPrestigeMasterByRank(f141_arg0, f141_arg1, f141_arg2, f141_arg3)
	if IsInParagonCapableGameMode() then
		local f141_local0 = tonumber(f141_arg3)
		if f141_local0 and f141_local0 > CoD.RankUtility.GetRankCap() + 1 then
			f141_arg0 = ColorSet.ParagonRank.r * 255
			f141_arg1 = ColorSet.ParagonRank.g * 255
			f141_arg2 = ColorSet.ParagonRank.b * 255
		end
	end
	return f141_arg0 / 255, f141_arg1 / 255, f141_arg2 / 255
end
function SetToParagonColorIfPrestigeMasterForScoreboard(f142_arg0, f142_arg1, f142_arg2, f142_arg3, f142_arg4)
	return SetToParagonColorIfPrestigeMasterByRank(f142_arg1, f142_arg2, f142_arg3, GetScoreboardPlayerRank(f142_arg0, f142_arg4))
end
function SetToParagonColorIfPrestigeMasterForLeaderboard(f143_arg0, f143_arg1, f143_arg2, f143_arg3)
	local f143_local0 = CoD.GetCombatRecordMode()
	if IsGameModeParagonCapable(f143_local0) and f143_arg3 == CoD.PrestigeUtility.GetPrestigeCap(f143_local0) then
		f143_arg0 = ColorSet.ParagonRank.r * 255
		f143_arg1 = ColorSet.ParagonRank.g * 255
		f143_arg2 = ColorSet.ParagonRank.b * 255
	end
	return f143_arg0 / 255, f143_arg1 / 255, f143_arg2 / 255
end
function SetToParagonColorIfPrestigeMasterFromStorage(f144_arg0, f144_arg1, f144_arg2, f144_arg3, f144_arg4, f144_arg5)
	local f144_local0 = CoD.ModeStringToMode(f144_arg1)
	if IsGameModeParagonCapable(f144_local0) and StorageLookup(f144_arg0, "playerstatslist.plevel.statvalue", f144_arg5) == CoD.PrestigeUtility.GetPrestigeCap(f144_local0) then
		f144_arg2 = ColorSet.ParagonRank.r * 255
		f144_arg3 = ColorSet.ParagonRank.g * 255
		f144_arg4 = ColorSet.ParagonRank.b * 255
	end
	return f144_arg2 / 255, f144_arg3 / 255, f144_arg4 / 255
end
function GetPrestigeMasterTierCountByRank(f145_arg0)
	local f145_local0 = 0
	if IsInParagonCapableGameMode() then
		local f145_local1 = tonumber(f145_arg0)
		if f145_local1 and f145_local1 > CoD.RankUtility.GetRankCap() + 1 then
			f145_local0 = math.floor(f145_local1 / 100)
		end
	end
	return f145_local0
end
function GetPrestigeMasterTierCountFromStorage(f146_arg0, f146_arg1, f146_arg2)
	local f146_local0 = 0
	local f146_local1 = CoD.ModeStringToMode(f146_arg1)
	if IsGameModeParagonCapable(f146_local1) and CoD.PrestigeUtility.GetCurrentPLevel(f146_arg0, f146_local1) == CoD.PrestigeUtility.GetPrestigeCap(f146_local1) then
		local f146_local2 = CoD.GetPlayerStats(f146_arg0)
		f146_local0 = math.floor((f146_local2.PlayerStatsList.PARAGON_RANK.statValue:get() + 1) / 100)
	end
	return f146_local0
end
function FileshareGetDownloadProgress(f147_arg0)
	if not IsInTheaterMode() then
		return ""
	end
	local f147_local0 = Engine[0xA798E4552F5E872](Engine[0x8DF2E5447F384B9](), "lobbyRoot.theaterDownloadPercent")
	if f147_local0 then
		local f147_local1 = Engine[0x614D394F6F9A18D](f147_local0)
		if f147_local1 ~= nil then
			return Engine[0xF9F1239CFD921FE](0x658F66BBA1E1ADF, f147_local1)
		end
	end
	return ""
end
function GetImageViewerParams(f148_arg0, f148_arg1)
	return Enum[0xBC604DA292437E4][Engine[0xC53F8D38DF9042B](f148_arg0)], f148_arg1
end
function GetObjectiveProperty(f149_arg0, f149_arg1)
	local f149_local0 = f149_arg1 and CoD.HUDUtility.GetCachedObjective(f149_arg1)
	local f149_local1
	if f149_local0 then
		f149_local1 = f149_local0[Engine[0xC53F8D38DF9042B](f149_arg0)]
		if not f149_local1 then
		else
			return f149_local1
		end
	end
	f149_local1 = 0x0
end
function GetObjectiveXHashProperty(f150_arg0, f150_arg1)
	local f150_local0 = f150_arg1 and CoD.HUDUtility.GetCachedObjective(f150_arg1)
	local f150_local1
	if f150_local0 then
		f150_local1 = f150_local0[f150_arg0]
		if not f150_local1 then
		else
			return f150_local1
		end
	end
	f150_local1 = 0x0
end
function LocalizeWithKeyBinding(f151_arg0, f151_arg1, f151_arg2)
	local f151_local0 = Engine[0xDFD7EFA83DD8C75](f151_arg0, f151_arg1)
	if f151_local0 then
		return Engine[0xF9F1239CFD921FE](f151_arg2, f151_local0)
	else
		return Engine[0xF9F1239CFD921FE](f151_arg2)
	end
end
function GetCurrentCPObjectiveText(f152_arg0, f152_arg1)
	local f152_local0 = DataSources.CPObjectiveUIData.getModel(f152_arg0)
	if not f152_local0 then
		return ""
	else
		local f152_local1 = f152_local0.currentZone:get()
		if f152_local0["zone" .. f152_local1 .. ".teamObjective"] then
			return f152_local0["zone" .. f152_local1 .. ".teamObjective"]:get()
		else
			return ""
		end
	end
end
function GetCPInstructionText(f153_arg0, f153_arg1)
	local f153_local0 = Engine[0x4DF5CFBC1771947](f153_arg0)
	return Engine[0xEFE2F6436680CF3](f153_local0.hudItems.cpInstructionText:get(), "CS_LOCALIZED_STRINGS")
end
function ZombieClientScoreboardColor(f154_arg0)
	local f154_local0, f154_local1, f154_local2, f154_local3 = Dvar["cg_ScoresColor_Gamertag_" .. f154_arg0].get(f154_local0["cg_ScoresColor_Gamertag_" .. f154_arg0])
	return f154_local0, f154_local1, f154_local2
end
function ZombieClientScoreboardGlowColor(f155_arg0)
	local f155_local0, f155_local1, f155_local2, f155_local3 = Dvar["cg_ScoresColor_Gamertag_" .. f155_arg0].get(f155_local0["cg_ScoresColor_Gamertag_" .. f155_arg0])
	return f155_local0 * 0.75, f155_local1 * 0.75, f155_local2 * 0.75
end
function GetEmblemIndexParams(f156_arg0, f156_arg1)
	return f156_arg0, f156_arg1, CoD.perController[f156_arg0].selectedEmblemTabStorageType
end
function GetEmblemRenderInfo(f157_arg0, f157_arg1)
	local f157_local0 = LUI.splitString(f157_arg1, ",")
	return f157_arg0, f157_local0[1], f157_local0[2]
end
function GetDecalGroupIndexParams(f158_arg0, f158_arg1)
	return f158_arg0, f158_arg1, CoD.CraftUtility.Groups.GetSelectedStorageFileType(f158_arg0)
end
function GetEmblemLayerAndGroupIndex(f159_arg0, f159_arg1)
	local f159_local0 = {}
	for f159_local4 in string.gmatch(f159_arg1, "%S+") do
		f159_local0[#f159_local0 + 1] = f159_local4
	end
	return f159_local0[1], f159_local0[2], CoD.GetCustomization(f159_arg0, "type")
end
function GetEmblemDecalDesc(f160_arg0)
	local f160_local0 = Engine[0xEE3271E477915B1](f160_arg0)
	if f160_local0 ~= nil then
		return f160_local0
	else
		return 0x0
	end
end
function GetPaintjobName(f161_arg0)
	if f161_arg0 == "" then
		return Engine[0xF9F1239CFD921FE](0xDFFD9B8A1D5E6D4)
	else
		return f161_arg0
	end
end
function GetPaintjobIndexParams(f162_arg0, f162_arg1)
	return f162_arg0, f162_arg1, Enum[0xBBD4F9E70101BA8][0x743B8404C246F61]
end
function GetPaintshopExtraCamParameters(f163_arg0, f163_arg1)
	local f163_local0 = f163_arg1
	local f163_local1 = CoD.CraftUtility.Paintjobs.GetPaintjobWeaponIndex(f163_arg0, f163_local0)
	if f163_local1 == 0 then
		f163_local1 = CoD.GetCustomization(f163_arg0, "weapon_index") or 0
	end
	local f163_local2 = Engine[0xB98952F69D937F9](f163_local1, Enum[0x6EB546760F890D2][0x569E84652131CD7], Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5])
	local f163_local3 = CoD.CraftUtility.GetLoadoutSlot(f163_arg0)
	local f163_local4 = "left"
	return f163_local3, f163_local2, CoD.WeaponOptionsUtility.GetWeaponOptionsString(0, 0, 1), f163_local1, f163_local0, f163_arg0
end
function LocalizeLayerMOfN(f164_arg0, f164_arg1, f164_arg2)
	return Engine[0xF9F1239CFD921FE](f164_arg0, f164_arg2, Engine[0xB3DF0B6F944FF42](f164_arg1, CoD.GetCustomization(f164_arg1, "type"), CoD.perController[f164_arg1].totalLayers))
end
function GunsmithAccuracyPercentage(f165_arg0)
	return string.format("%2.2f", f165_arg0 * 100) .. "%"
end
function GetLocalizedWeaponName(f166_arg0)
	local f166_local0 = Engine[0x6B7AC889104DED3](tonumber(f166_arg0))
	if f166_local0 then
		return Engine[0xF9F1239CFD921FE](f166_local0)
	else
		return ""
	end
end
function LocalizeWeaponNameIntoString(f167_arg0, f167_arg1, f167_arg2)
	local f167_local0 = Engine[0x6B7AC889104DED3](tonumber(f167_arg2))
	if f167_local0 then
		return LocalizeIntoString(f167_arg0, Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](f167_local0)))
	else
		return ""
	end
end
function GetItemNameFromIndex(f168_arg0, f168_arg1)
	return GetItemNameForIndex(f168_arg1, f168_arg0)
end
function GetItemDescFromIndex(f169_arg0, f169_arg1)
	return GetItemDescForIndex(f169_arg1, f169_arg0)
end
function GetItemNameFromRef(f170_arg0, f170_arg1)
	if not f170_arg0 then
		f170_arg0 = Engine[0x3EAC408F958FF05]()
	end
	if not f170_arg1 or f170_arg1 == "" then
		return 0x0
	end
	local f170_local0 = f170_arg1
	if type(f170_local0) ~= "xhash" then
		f170_local0 = Engine[0xC53F8D38DF9042B](f170_local0)
	end
	local f170_local1 = Engine[0xCA0179D394E63CE](Engine[0x8FF94BB44442412](f170_local0, f170_arg0), f170_arg0)
	return f170_local1.name
end
function GetItemImageFromIndex(f171_arg0, f171_arg1)
	return GetItemImageForIndex(f171_arg1, f171_arg0)
end
function GetHudImageFromItemIndex(f172_arg0)
	return Engine[0xD97858119DEE164](Engine[0xB98952F69D937F9](f172_arg0) .. "_" .. string.lower(CoD.gameMode), Engine[0x3EAC408F958FF05]()) or "blacktransparent"
end
function GetHudImageFromItemRefHash(f173_arg0, f173_arg1)
	local f173_local0 = CoD.SafeGetModelValue(f173_arg0, "weapon")
	if f173_local0 and f173_local0 > 0 then
		return GetHudImageFromItemIndex(f173_local0)
	else
		return Engine[0xD97858119DEE164](f173_arg1, Engine[0x3EAC408F958FF05]()) or "blacktransparent"
	end
end
function GetHudDisplayNameFromItemIndex(f174_arg0)
	return Engine[0xB680D2B7BFC8098](Engine[0xB98952F69D937F9](f174_arg0) .. "_" .. string.lower(CoD.gameMode), Engine[0x3EAC408F958FF05]()) or 0x2C79EA24AB1A2BA
end
function GetItemImageByIndexAndMode(f175_arg0, f175_arg1)
	return GetItemNameForIndex(f175_arg1, nil, CoD.ModeStringToMode(f175_arg0))
end
function GetWeaponGadgetIconAvailable(f176_arg0)
	local f176_local0 = BlackTransparentIfNilOrEmpty(Engine[0xCAC5353CDB6246D](f176_arg0))
	if type(f176_local0) == "userdata" then
		return f176_local0
	else
		return RegisterImage(f176_local0)
	end
end
function GetWeaponGadgetIconUnavailable(f177_arg0)
	return Engine[0xA9DABDB8742AE8](f177_arg0)
end
function GetConsumableCountFromIndex(f178_arg0, f178_arg1)
	local f178_local0 = f178_arg0
	if Engine[0x8EF5BEFA0AE50FE]() and not IsLobbyNetworkModeLAN() then
		local f178_local1 = Engine[0x475AAFCBC9AF822](f178_local0, Engine[0xC53F8D38DF9042B](Engine[0xD5D69BA555E016D](f178_arg1)))
		if not f178_local1 then
			return 0
		else
			return math.min(999, math.max(f178_local1, 0))
		end
	else
		return 0
	end
end
function GetWeaponItemImageFromIndex(f179_arg0)
	return Engine[0x8518E07C1C5BC6D](f179_arg0)
end
function GetMaxAllocationAmount(f180_arg0, f180_arg1)
	return CoD.CACUtility.GetMaxAllocation(f180_arg0)
end
function ZeroIfNoSelection(f181_arg0, f181_arg1)
	if not CoD.ModelUtility.IsModelValueTrue(f181_arg0, "CACHasSelection") then
		f181_arg1 = 0
	end
	return f181_arg1
end
function GetWeaponAttributes(f182_arg0, f182_arg1, f182_arg2, f182_arg3, f182_arg4)
	local f182_local0, f182_local1 = nil
	if f182_arg0 then
		f182_local0 = CoD.BaseUtility.GetMenuLoadoutSlot(f182_arg0)
		f182_local1 = CoD.BaseUtility.GetMenuLoadoutListItemSlot(f182_arg0)
	end
	if f182_local1 and (LUI.startswith(f182_local1, "primary.attachment") or LUI.startswith(f182_local1, "secondary.attachment")) then
		local f182_local2 = f182_arg1
		if f182_arg2 < f182_arg1 then
			f182_local2 = f182_arg2
		end
		return f182_local2 / 100, f182_arg2, f182_arg3, f182_arg4
	else
		return f182_arg1 / 100, f182_arg2, f182_arg3, f182_arg4
	end
end
function GetWeaponAttributesForAttachment(f183_arg0, f183_arg1, f183_arg2, f183_arg3, f183_arg4)
	local f183_local0, f183_local1 = nil
	if f183_arg0 then
		f183_local0 = CoD.BaseUtility.GetMenuLoadoutSlot(f183_arg0)
		f183_local1 = CoD.BaseUtility.GetMenuAttachmentFilter(f183_arg0)
	end
	if not (f183_local1 ~= nil or Engine[0x3EAC408F958FF05]() ~= Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] or f183_local0 ~= "primary" and f183_local0 ~= "secondary") or not (Engine[0x3EAC408F958FF05]() ~= Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] or f183_local0 ~= "zmStartWeapon" and f183_local0 ~= "armory") or IsInGame() and CoD.BountyHunterUtility.GameTypeIsBounty(nil) then
		return 0, 0, 0, 0
	else
		return f183_arg1 / 100, f183_arg2 / 100, f183_arg3, f183_arg4
	end
end
function GetWeaponAttributeBaseValueForAttachment(f184_arg0, f184_arg1)
	local f184_local0, f184_local1 = nil
	if f184_arg0 then
		f184_local0 = CoD.BaseUtility.GetMenuLoadoutSlot(f184_arg0)
		f184_local1 = CoD.BaseUtility.GetMenuAttachmentFilter(f184_arg0)
	end
	if not (f184_local1 ~= nil or Engine[0x3EAC408F958FF05]() ~= Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] or f184_local0 ~= "primary" and f184_local0 ~= "secondary") or Engine[0x3EAC408F958FF05]() == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] and f184_local0 == "zmStartWeapon" then
		return ""
	else
		local f184_local2 = LUI.splitString(f184_arg1, ",")
		if f184_local2[1] then
			return f184_local2[1]
		else
			return ""
		end
	end
end
function GetWeaponAttributeAddedValueForAttachment(f185_arg0, f185_arg1)
	local f185_local0, f185_local1 = nil
	if f185_arg0 then
		f185_local0 = CoD.BaseUtility.GetMenuLoadoutSlot(f185_arg0)
		f185_local1 = CoD.BaseUtility.GetMenuAttachmentFilter(f185_arg0)
	end
	if not (f185_local1 ~= nil or Engine[0x3EAC408F958FF05]() ~= Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] or f185_local0 ~= "primary" and f185_local0 ~= "secondary") or Engine[0x3EAC408F958FF05]() == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] and f185_local0 == "zmStartWeapon" then
		return ""
	end
	local f185_local2 = LUI.splitString(f185_arg1, ",")
	if f185_local2[2] then
		if tonumber(f185_local2[2]) > 0 then
			return "+" .. f185_local2[2]
		elseif tonumber(f185_local2[2]) < 0 then
			return "" .. f185_local2[2]
		end
	end
	return ""
end
function GetClientGameLobbyXUIDForClientNum(f186_arg0)
	local f186_local0 = f186_arg0
	if f186_local0 == LuaDefine.INVALID_CLIENT_INDEX or LuaDefine.MAX_CLIENTS <= f186_local0 then
		return Engine[0x8506F73B393062F](LuaDefine.INVALID_XUID)
	else
		return Engine[0xDB23F7EB606D71B](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Engine[0xC3DF042E7492B66](Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2]), f186_arg0)
	end
end
function GetClientGameLobbyXUIDForClientNumString(f187_arg0)
	return GetClientGameLobbyXUIDForClientNum(tonumber(f187_arg0))
end
function GetScoreboardPlayerName(f188_arg0, f188_arg1)
	if f188_arg1 and f188_arg1 ~= "" then
		return Engine[0xA457DFCEF7A7C9D](f188_arg0, f188_arg1) or ""
	else
		return ""
	end
end
function GetScoreboardPlayerRank(f189_arg0, f189_arg1)
	if f189_arg1 and f189_arg1 ~= "" then
		return Engine[0x331433774E33ED8](f189_arg0, f189_arg1) or ""
	else
		return ""
	end
end
function GetScoreboardPlayerRankIcon(f190_arg0, f190_arg1)
	if f190_arg1 and f190_arg1 ~= "" then
		return Engine[0x8BCE6459C40220](f190_arg0, f190_arg1) or "blacktransparent"
	else
		return ""
	end
end
function GetScoreboardPlayerScoreColumn(f191_arg0, f191_arg1, f191_arg2)
	return Engine[0x4115AA5FA07976D](f191_arg2, f191_arg1)
end
function GetScoreboardCurrentStreak(f192_arg0, f192_arg1)
	local f192_local0 = tonumber(f192_arg1)
	if f192_local0 == -1 then
		return ""
	else
		return f192_local0
	end
end
function GetCodcasterPlayerListKD(f193_arg0, f193_arg1)
	local f193_local0 = f193_arg1
	local f193_local1 = Engine[0xE4D2F32833CFA6C](f193_local0)
	f193_local1 = f193_local1:create("kills")
	local f193_local2 = Engine[0xE4D2F32833CFA6C](f193_local0)
	f193_local2 = f193_local2:create("deaths")
	local f193_local3 = f193_local1:get()
	local f193_local4 = f193_local2:get()
	if f193_local3 == "" and f193_local4 == "" then
		return ""
	elseif f193_local3 == "" or f193_local3 == nil then
		f193_local3 = "0"
	end
	if f193_local4 == "" or f193_local4 == nil then
		f193_local4 = "0"
	end
	return f193_local3 .. " / " .. f193_local4
end
function GetScoreboardColumnHeader(f194_arg0, f194_arg1, f194_arg2)
	local f194_local0 = Engine[0x4E9119DFEF0C60A](f194_arg0, f194_arg1) or ""
	if CoD.BountyHunterUtility.GameTypeIsBounty(f194_arg0) and string.lower(f194_local0) == "objective score" then
		f194_local0 = Engine[0xF9F1239CFD921FE](0xF637558C9E3D6CD)
	end
	if CoD.HUDUtility.IsGameTypeEqualToString("warzone_deposit") and string.lower(f194_local0) == "score" then
		f194_local0 = Engine[0xF9F1239CFD921FE](0x899455D1DF9CE06)
	end
	return f194_local0
end
function GetScoreboardPlayerPingBarImage(f195_arg0)
	local f195_local0 = Engine[0x5F8EA8E2974BDCF]()
	if Dvar[0xDDC61194A7E2C0C]:get() == false then
		if Dvar[0x3F506D23F310141]:get() > 1 and f195_arg0 > 0 then
			return "ping_bar_0" .. f195_arg0
		end
	elseif Dvar[0xDDC61194A7E2C0C]:get() > 1 and f195_arg0 > 0 then
		return "ping_bar_0" .. f195_arg0
	end
	return "blacktransparent"
end
function GetScoreboardPlayerPingRange(f196_arg0)
	local f196_local0 = Engine[0x5F8EA8E2974BDCF] and Engine[0x5F8EA8E2974BDCF]() or 4
	local f196_local1 = Engine[0xC90DF4302B30DFD] and Engine[0xC90DF4302B30DFD]() or 100
	local f196_local2 = f196_local0 + 1 - f196_arg0
	if f196_local2 == f196_local0 then
		return Engine[0xF9F1239CFD921FE](0xA5DFC2E3D7DF772, f196_local1 * (f196_local2 - 1))
	elseif f196_local2 < f196_local0 then
		return Engine[0xF9F1239CFD921FE](0x2F670BEF7CB789, f196_local1 * (f196_local2 - 1), f196_local1 * f196_local2 - 1)
	else
		return ""
	end
end
function GetScoreboardTeamBackgroundColor(f197_arg0, f197_arg1)
	if CoD.IsShoutcaster(f197_arg0) and CoD.ShoutcasterProfileVarBool(f197_arg0, "shoutcaster_ds_flip_scorepanel") then
		if f197_arg1 == Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] then
			f197_arg1 = Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68]
		elseif f197_arg1 == Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] then
			f197_arg1 = Enum[0x13A4717E5AC547][0x2A34B055ADD98AB]
		end
	end
	return CoD.TeamUtility.GetTeamFactionColor(f197_arg1)
end
function GetScoreboardPingBarAlpha(f198_arg0)
	if Engine[0x7B48C1ABFF0F764]() and IsScoreboardPingAsBars() and IsLive() then
		return 1
	else
		return 0
	end
end
function GetScoreboardPingValueAlpha(f199_arg0)
	if Engine[0x7B48C1ABFF0F764]() and not IsScoreboardPingAsBars() and IsLive() then
		return f199_arg0
	else
		return 0
	end
end
function KillCamAllowRespawnToString(f200_arg0, f200_arg1)
	if CoD.isPC then
		if IsGamepad(f200_arg0) then
			local f200_local0
			if f200_arg1 == 1 then
				f200_local0 = 0x210A2FFB2104D9F
				if not f200_local0 then
				else
					return f200_local0
				end
			end
			f200_local0 = 0x847731E84CD3C18
		else
			local f200_local0
			if f200_arg1 == 1 then
				f200_local0 = 0x81D69DF6BE38220
				if not f200_local0 then
				else
					return f200_local0
				end
			end
			f200_local0 = 0x669667599F67B3F
		end
	else
		local f200_local0
		if f200_arg1 == 1 then
			f200_local0 = 0x874E6C47442AD9
			if not f200_local0 then
			else
				return f200_local0
			end
		end
		f200_local0 = 0x34A052BB0658AF8
	end
end
function TeamStringFromPlayerIndex(f201_arg0, f201_arg1)
	local f201_local0 = f201_arg1
	if f201_local0 == -1 then
		return ""
	else
		local f201_local1 = Engine[0x2C6B07FD023877B](f201_arg0, f201_local0)
		if CoD.IsShoutcaster(f201_arg0) and not CoDShared.IsGametypeTeamBased() and f201_local1 ~= Enum[0x13A4717E5AC547][0xE4DDAC9C5C45556] then
			return ""
		else
			local f201_local2 = CoD.TeamUtility.GetTeamNameCaps(f201_local1)
			if CoD.IsShoutcaster(f201_arg0) and CoD.TeamUtility.ShouldUseCustomTeamIdentity(f201_arg0) then
				return f201_local2
			else
				return Engine[0xED84C33EC5F01EA](f201_local2)
			end
		end
	end
end
function TeamColorFromPlayerIndex(f202_arg0, f202_arg1)
	local f202_local0 = f202_arg1
	if f202_local0 == -1 then
		return CoD.TeamUtility.GetTeamFactionColor(Enum[0x13A4717E5AC547][0x97263B3C1ABADF7])
	end
	local f202_local1 = Engine[0x2C6B07FD023877B](f202_arg0, f202_local0)
	if CoD.IsShoutcaster(f202_arg0) and not CoDShared.IsGametypeTeamBased() and f202_local1 ~= Enum[0x13A4717E5AC547][0xE4DDAC9C5C45556] then
		return CoD.TeamUtility.GetTeamFactionColor(Enum[0x13A4717E5AC547][0x97263B3C1ABADF7])
	elseif CoD.IsShoutcaster(f202_arg0) and CoD.ShoutcasterProfileVarBool(f202_arg0, "shoutcaster_ds_flip_scorepanel") then
		if f202_arg1 == Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] then
			f202_arg1 = Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68]
		elseif f202_arg1 == Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] then
			f202_arg1 = Enum[0x13A4717E5AC547][0x2A34B055ADD98AB]
		end
	end
	return CoD.TeamUtility.GetTeamFactionColor(f202_local1)
end
function ClientGamertagColor(f203_arg0, f203_arg1)
	local f203_local0 = f203_arg1
	if f203_local0 < 0 then
		return ColorSet.White.r, ColorSet.White.g, ColorSet.White.b
	elseif Engine[0x761955642304848](f203_arg0) == f203_local0 then
		return ColorSet.Client_Self.r, ColorSet.Client_Self.g, ColorSet.Client_Self.b
	else
		local f203_local1 = CoD.LobbyUtility.GetClient(f203_local0)
		if f203_local1 ~= nil then
			if f203_local1.team == CoD.TeamUtility.GetTeamID(f203_arg0) then
				if f203_local1.isMember == 1 then
					return ColorSet.Client_PartyMember.r, ColorSet.Client_PartyMember.g, ColorSet.Client_PartyMember.b
				else
					return ColorSet.Client.r, ColorSet.Client.g, ColorSet.Client.b
				end
			else
				return ColorSet.Client_Enemy.r, ColorSet.Client_Enemy.g, ColorSet.Client_Enemy.b
			end
		else
			return ColorSet.White.r, ColorSet.White.g, ColorSet.White.b
		end
	end
end
function ClientBackgroundColor(f204_arg0, f204_arg1)
	local f204_local0 = CoD.LobbyUtility.GetClient(f204_arg1)
	if f204_local0 ~= nil and f204_local0.isMember == 1 then
		return ColorSet.Client_PartyMember.r, ColorSet.Client_PartyMember.g, ColorSet.Client_PartyMember.b
	else
		return CoD.TeamUtility.GetTeamFactionColor(Enum[0x13A4717E5AC547][0x2A34B055ADD98AB])
	end
end
function BlackhatHackingPercentage(f205_arg0)
	return string.format("%d", f205_arg0 * 100) .. "%"
end
function BlackhatHackingPercentageShaderValue(f206_arg0, f206_arg1, f206_arg2, f206_arg3, f206_arg4)
	return f206_arg1, 0, 0, 0
end
function GetCategoryIconForOverlayType(f207_arg0)
	if f207_arg0 == CoD.OverlayUtility.OverlayTypes.Connection then
		return "t7_icon_connect_overlays"
	elseif f207_arg0 == CoD.OverlayUtility.OverlayTypes.Settings then
		return "t7_icon_options_overlays"
	elseif f207_arg0 == CoD.OverlayUtility.OverlayTypes.Unlock then
		return "t7_icon_unlock_overlays"
	elseif f207_arg0 == CoD.OverlayUtility.OverlayTypes.Save then
		return "t7_icon_save_overlays"
	elseif f207_arg0 == CoD.OverlayUtility.OverlayTypes.Quit then
		return "t7_icon_quit_overlays"
	elseif f207_arg0 == CoD.OverlayUtility.OverlayTypes.Alert then
		return "t7_icon_error_overlays"
	elseif f207_arg0 == CoD.OverlayUtility.OverlayTypes.Error then
		return "t7_icon_error_overlays"
	elseif f207_arg0 == CoD.OverlayUtility.OverlayTypes.CustomGames then
		return "ui_icon_customgames"
	else
		return "blacktransparent"
	end
end
function GetAARMedalName(f208_arg0)
	return Engine[0xED84C33EC5F01EA](Engine[0xC6F8EC444864600](CoD.scoreInfoTable, f208_arg0, CoD.AARUtility.medalStringCol))
end
function GetAARMedalDesc(f209_arg0)
	return Engine[0xED84C33EC5F01EA](Engine[0xC6F8EC444864600](CoD.scoreInfoTable, f209_arg0, CoD.AARUtility.medalStringCol) .. "_DESC")
end
function GetAARMedalHitCount(f210_arg0)
	if f210_arg0 and tonumber(f210_arg0) > 1 then
		return "x" .. f210_arg0
	else
		return ""
	end
end
function GetAARMedalImageSmall(f211_arg0)
	local f211_local0 = GetMedalInfo(f211_arg0)
	if f211_local0 then
		return f211_local0.iconSmall
	else
		return ""
	end
end
function GetAARMedalImageBackingSmall(f212_arg0)
	local f212_local0 = GetMedalInfo(f212_arg0)
	if f212_local0 then
		return f212_local0.backingSmall
	else
		return ""
	end
end
function GetAARMedalImageLarge(f213_arg0)
	local f213_local0 = GetMedalInfo(f213_arg0)
	if f213_local0 then
		return f213_local0.iconLarge
	else
		return ""
	end
end
function GetAARMedalImageBackingLarge(f214_arg0)
	local f214_local0 = GetMedalInfo(f214_arg0)
	if f214_local0 then
		return f214_local0.backingLarge
	else
		return ""
	end
end
function DifficultyIconFromNumber(f215_arg0)
	local f215_local0 = tonumber(f215_arg0 or -1)
	local f215_local1 = {
		"playlist_sp_recr",
		"playlist_sp_reg",
		"playlist_sp_hard",
		"playlist_sp_vet",
		"playlist_sp_real",
	}
	return f215_local1[tonumber(f215_arg0) + 1] or "blacktransparent"
end
function PrependArenaToPlaylist(f216_arg0)
	if IsArenaMode() then
		return Engine[0xF9F1239CFD921FE](0x4B08B09636ECD9E) .. " " .. Engine[0xF9F1239CFD921FE](f216_arg0)
	else
		return Engine[0xF9F1239CFD921FE](f216_arg0)
	end
end
function GetArenaRank(f217_arg0)
	return CoD.ArenaRankedPlayUtility.GetDisplayRankString(f217_arg0)
end
function GetArenaRankIconLG(f218_arg0)
	return CoD.ArenaRankedPlayUtility.GetArenaRankIconLarge(f218_arg0)
end
function GetCurrentMinimapImageName(f219_arg0)
	local f219_local0, f219_local1, f219_local2 = Engine[0x5EA79AB5A744D06]()
	return f219_local1
end
function GetQuestItemHolderImageFromEnum(f220_arg0)
	local f220_local0 = f220_arg0
	if f220_local0 == CoD.ZombieUtility.ZOD_CRAFTABLE_RITUAL_BOXER_ENUM then
		return "uie_t7_zm_hud_score_char8"
	elseif f220_local0 == CoD.ZombieUtility.ZOD_CRAFTABLE_RITUAL_DETECTIVE_ENUM then
		return "uie_t7_zm_hud_score_char6"
	elseif f220_local0 == CoD.ZombieUtility.ZOD_CRAFTABLE_RITUAL_FEMME_ENUM then
		return "uie_t7_zm_hud_score_char5"
	elseif f220_local0 == CoD.ZombieUtility.ZOD_CRAFTABLE_RITUAL_MAGICIAN_ENUM then
		return "uie_t7_zm_hud_score_char7"
	else
		return ""
	end
end
function GetPlayerListObjective(f221_arg0, f221_arg1)
	local f221_local0 = tonumber(f221_arg1)
	if f221_local0 >= 0 and f221_local0 < LuaDefine.MAX_CLIENTS then
		local f221_local1 = Engine[0xC11C46262D07E5E](f221_arg0, f221_local0)
		if f221_local1 then
			for f221_local5, f221_local6 in pairs(f221_local1) do
				if ShouldShowObjectiveForPlayer(f221_arg0, f221_local0, f221_local6) then
					return f221_local6
				end
			end
		end
	end
end
function GetPlayerListObjectiveImage(f222_arg0, f222_arg1)
	local f222_local0 = GetPlayerListObjective(f222_arg0, f222_arg1)
	if f222_local0 and f222_local0.name then
		local f222_local1 = CoD.HUDUtility.GetCachedObjective(f222_local0.name)
		if f222_local1.waypoint_image_neutral then
			return f222_local1.waypoint_image_neutral
		else
			return f222_local1.waypoint_image or 0x214ECBA8C04D44C
		end
	else
		return 0x214ECBA8C04D44C
	end
end
function GetPlayerListObjectiveMinimapImage(f223_arg0, f223_arg1)
	local f223_local0 = GetPlayerListObjective(f223_arg0, f223_arg1)
	if f223_local0 and f223_local0.name then
		local f223_local1 = CoD.HUDUtility.GetCachedObjective(f223_local0.name)
		return f223_local1[0xAA8267261655DF1] or 0x214ECBA8C04D44C
	else
		return 0x214ECBA8C04D44C
	end
end
function GetPlayerListObjectiveColor(f224_arg0, f224_arg1)
	local f224_local0 = f224_arg1
	local f224_local1 = GetPlayerListObjective(f224_arg0, f224_local0)
	if f224_local1 and f224_local1.id and ShouldShowColorForObjective(f224_arg0, f224_local0, f224_local1) then
		local f224_local2 = Engine[0x7A01BC612811EFE](f224_arg0, f224_local1.id)
		local f224_local3 = Engine[0x4C77EAF5F088DC3](f224_arg0, f224_local1.id)
		if f224_local3 == Enum[0x13A4717E5AC547][0x97263B3C1ABADF7] or f224_local3 == Enum[0x13A4717E5AC547][0xE4DDAC9C5C45556] or f224_local3 == Enum[0x13A4717E5AC547][0xBD65CBD25CCBEDC] or f224_local2 ~= 1 then
			return ColorSet.White.r, ColorSet.White.g, ColorSet.White.b
		else
			return CoD.TeamUtility.GetTeamFactionColor(Engine[0x4C77EAF5F088DC3](f224_arg0, f224_local1.id))
		end
	else
		return ColorSet.White.r, ColorSet.White.g, ColorSet.White.b
	end
end
function DemoGetTimeScaleString(f225_arg0)
	return CoD.DemoUtility.GetRoundedTimeScaleString()
end
function DemoGetCurrentDollyCameraTimeScaleString(f226_arg0)
	if not CoD.DemoUtility.GetEditingDollyCameraMarker() then
		return f226_arg0
	else
		return CoD.DemoUtility.GetRoundedTimeScaleString(f226_arg0)
	end
end
function GetRandomStringCharacter(f227_arg0)
	return string.char(math.random(33, 126))
end
function FormatAutoReviveCountdown(f228_arg0)
	return Engine[0xF9F1239CFD921FE](0x391AB6BB6AB12D, f228_arg0)
end
function UpdateCoDPointPurchaseDesc(f229_arg0, f229_arg1, f229_arg2, f229_arg3)
	local f229_local0 = CoD.SafeGetModelValue(f229_arg1, "price")
	if f229_local0 then
		local f229_local1 = f229_local0 - Engine[0xF40679B550DCCA2](f229_arg2, CoD.Currencies.COD_POINTS)
		if f229_local1 < 0 then
			f229_local1 = 0
			GoBack(f229_arg0, f229_arg2)
		end
		return Engine[0xF9F1239CFD921FE](0xC9037730DD8568, f229_local1)
	else
		return Engine[0xF9F1239CFD921FE](f229_arg3)
	end
end
function CheckForKeyboardMouseDescriptionInList(f230_arg0, f230_arg1, f230_arg2)
	local f230_local0 = f230_arg0:getModel()
	if IsMouseOrKeyboard(f230_arg1) and f230_local0 and f230_local0.descKBM then
		f230_arg2 = f230_local0.descKBM:get() or f230_arg2
	end
	return f230_arg2
end
function SetCustomScaleDependingOnPlatform(f231_arg0, f231_arg1, f231_arg2, f231_arg3, f231_arg4)
	if CoD.isPC then
		f231_arg3 = f231_arg1
		f231_arg4 = f231_arg2
	end
	return f231_arg3, f231_arg4
end
function SetStringRefPlatformDependant(f232_arg0, f232_arg1)
	if CoD.isPC then
		f232_arg1 = f232_arg0
	end
	return f232_arg1
end
function UpdateKeyShortcutsButtonPrompts(f233_arg0, f233_arg1, f233_arg2)
	if not CoD.isPC then
		return f233_arg2
	end
	local f233_local0 = f233_arg0:getModel()
	local f233_local1 = Engine[0xF9F1239CFD921FE](0x0)
	if f233_local0 and f233_local0.KeyShortcut then
		f233_local1 = Engine[0x614D394F6F9A18D](f233_local0.KeyShortcut)
		if f233_local1 then
			if not Engine[0x40E824FE270E174](Engine[0x4DF5CFBC1771947](f233_arg1), "KeyPressBits." .. f233_local1) then
				local f233_local2 = nil
				f233_local1, f233_local2 = Engine[0x7C4C4DBF61B869E](f233_arg1, f233_local1, 0)
			elseif #f233_local1 > 1 then
				f233_local1 = Engine[0xF9F1239CFD921FE](0x819ABD75CBD7B59 .. f233_local1)
			end
		end
	end
	return f233_local1
end
function AddLocalizeGameModeToString(f234_arg0)
	local f234_local0 = Engine[0xEA74FA7EE46E195](Dvar[0xFF54369D6573B91]:get())
	return Engine[0xB03220D3A4F3E38](Engine[0xF9F1239CFD921FE](f234_arg0, f234_local0.nameRef))
end
function SetProgressTarget(f235_arg0)
	return Engine[0xF9F1239CFD921FE](0xB5E5844327FB1A0, f235_arg0)
end
