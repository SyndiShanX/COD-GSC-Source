LUI = {
	UIWidth = 960,
	UIHeight = 720,
	roots = {},
	createMenu = {},
	hudMenuType = {},
	Alignment = {
		None = 0,
		Left = 1,
		Center = 2,
		Right = 3,
		Top = 4,
		Middle = 5,
		Bottom = 6,
	},
	savedMenuStates = {},
	currentMouseFocus = {
		false,
		false,
		false,
		false,
	},
}
if Enum[0x7A5123B654282D2] then
	LUI.Alignment = {
		None = Enum[0x7A5123B654282D2][0x1539396E54B179A],
		Left = Enum[0x7A5123B654282D2][0x58C8A85F2048829],
		Center = Enum[0x7A5123B654282D2][0xFEEB12BCB0D7041],
		Right = Enum[0x7A5123B654282D2][0x830CFD395E6AA0A],
		Top = Enum[0x7A5123B654282D2][0xF41D595A2B0EDF3],
		Middle = Enum[0x7A5123B654282D2][0x6ED4298C93DC5ED],
		Bottom = Enum[0x7A5123B654282D2][0x70510683C22104B],
	}
end
if hpairs ~= nil then
	pairs = hpairs
end
function InheritFrom(f1_arg0)
	if not f1_arg0 then
		error("LUI Error: Did not specify base class in InheritFrom!")
	end
	local f1_local0 = {
		super = f1_arg0,
	}
	setmetatable(f1_local0, {
		__index = f1_arg0,
	})
	f1_local0.m_eventHandlers = {}
	setmetatable(f1_local0.m_eventHandlers, {
		__index = f1_arg0.m_eventHandlers,
	})
	return f1_local0
end
LUI.ShallowCopy = function(f2_arg0)
	local f2_local0 = {}
	for f2_local4, f2_local5 in pairs(f2_arg0) do
		f2_local0[f2_local4] = f2_local5
	end
	return f2_local0
end
LUI.DeepCopy = function(f3_arg0)
	local f3_local0 = {}
	for f3_local4, f3_local5 in pairs(f3_arg0) do
		if type(f3_local4) == "table" then
			f3_local4 = LUI.DeepCopy(f3_local4)
		end
		if type(f3_local5) == "table" then
			f3_local5 = LUI.DeepCopy(f3_local5)
		end
		f3_local0[f3_local4] = f3_local5
	end
	return f3_local0
end
LUI.ConcatenateToTable = function(f4_arg0, f4_arg1)
	if f4_arg1 == nil then
		return
	end
	for f4_local3, f4_local4 in pairs(f4_arg1) do
		table.insert(f4_arg0, f4_local4)
	end
end
LUI.clamp = function(f5_arg0, f5_arg1, f5_arg2)
	if f5_arg0 <= f5_arg1 then
		return f5_arg1
	elseif f5_arg2 <= f5_arg0 then
		return f5_arg2
	else
		return f5_arg0
	end
end
LUI.CountFields = function(f6_arg0)
	local f6_local0 = 0
	for f6_local4, f6_local5 in pairs(f6_arg0) do
		f6_local0 = f6_local0 + 1
	end
	return f6_local0
end
LUI.startswith = function(f7_arg0, f7_arg1)
	return string.sub(f7_arg0, 1, string.len(f7_arg1)) == f7_arg1
end
LUI.endswith = function(f8_arg0, f8_arg1)
	return string.sub(f8_arg0, -string.len(f8_arg1)) == f8_arg1
end
LUI.splitString = function(f9_arg0, f9_arg1)
	local f9_local0 = {}
	string.gsub(f9_arg0, "([^" .. f9_arg1 .. "]+)", function(f10_arg0)
		table.insert(f9_local0, f10_arg0)
	end)
	return f9_local0
end
LUI.appendStringWithDelimiter = function(f11_arg0, f11_arg1, f11_arg2)
	if f11_arg0 ~= "" then
		f11_arg0 = f11_arg0 .. f11_arg2
	end
	return f11_arg0 .. f11_arg1
end
LUI.getTableFromPath = function(f12_arg0, f12_arg1)
	local f12_local0 = f12_arg1 or _G
	for f12_local4 in string.gmatch(f12_arg0, "[^.]+") do
		f12_local0 = f12_local0[f12_local4]
		if f12_local0 == nil then
			return nil
		end
	end
	return f12_local0
end
LUI.getTableFromFieldList = function(f13_arg0, f13_arg1)
	local f13_local0 = f13_arg1 or _G
	for f13_local4, f13_local5 in ipairs(f13_arg0) do
		f13_local0 = f13_local0[f13_local5]
		if f13_local0 == nil then
			return nil
		end
	end
	return f13_local0
end
LUI.IterateTableBySortedKeys = function(f14_arg0, f14_arg1, f14_arg2)
	local f14_local0 = {}
	for f14_local4, f14_local5 in pairs(f14_arg0) do
		if f14_arg2 == nil or f14_arg2(f14_local4, f14_local5) then
			table.insert(f14_local0, f14_local4)
		end
	end
	table.sort(f14_local0, f14_arg1)
	f14_local1 = 0
	return function()
		f14_local1 = f14_local1 + 1
		if f14_local0[f14_local1] == nil then
			return nil
		else
			return f14_local0[f14_local1], f14_arg0[f14_local0[f14_local1]]
		end
	end
end
LUI.CreateModelsAndInitialize = function(f16_arg0, f16_arg1)
	if f16_arg0 then
		for f16_local3, f16_local4 in pairs(f16_arg1) do
			LUI.CreateModelAndInitialize(f16_arg0, f16_local3, f16_local4)
		end
	end
end
LUI.CreateModelAndInitialize = function(f17_arg0, f17_arg1, f17_arg2)
	local f17_local0 = Engine[0xA798E4552F5E872](f17_arg0, f17_arg1)
	if f17_local0 and f17_arg2 ~= nil then
		Engine[0x83C9B5DE1D9371](f17_local0, f17_arg2)
	end
	return f17_local0
end
LUI.OverrideFunction_GetFunctionTable = function(f18_arg0, f18_arg1)
	local f18_local0 = "__override_" .. f18_arg1 .. "_table"
	if not f18_arg0[f18_local0] then
		f18_arg0[f18_local0] = {
			f18_arg0[f18_arg1],
		}
		f18_arg0[f18_arg1] = function(...)
			for f19_local3, f19_local4 in ipairs(f18_arg0[f18_local0]) do
				f19_local4(...)
			end
		end
	end
	return f18_arg0[f18_local0]
end
LUI.OverrideFunction_CallOriginalFirst = function(f20_arg0, f20_arg1, f20_arg2)
	table.insert(LUI.OverrideFunction_GetFunctionTable(f20_arg0, f20_arg1), f20_arg2)
end
LUI.OverrideFunction_CallOriginalSecond = function(f21_arg0, f21_arg1, f21_arg2)
	table.insert(LUI.OverrideFunction_GetFunctionTable(f21_arg0, f21_arg1), 1, f21_arg2)
end
LUI.OverrideFunction_Remove = function(f22_arg0, f22_arg1, f22_arg2)
	local f22_local0 = LUI.OverrideFunction_GetFunctionTable(f22_arg0, f22_arg1)
	table.remove(f22_local0, LuaUtils.FindItemInArray(f22_local0, f22_arg2))
end
require("x64:7d42cfae6e90891")
require("x64:4c3a3ee87cd66f3")
require("x64:b279b6d2fe04364")
require("x64:1a55ff918c73cd4")
require("x64:b7dd1806fb18b7")
require("x64:2cf17e1911faf98")
require("x64:4083528baeb2f3d")
require("x64:c3156467692bf47")
require("x64:8e9b767aaa6fd74")
require("x64:fc4b916e71c9ca9")
require("x64:1845c3416695820")
require("x64:280ec61da7bd5a7")
if not debug then
	debug = {}
end
debug.postdeploymentfunction = function()
	for f23_local3, f23_local4 in pairs(LUI.roots) do
		f23_local4.debugReload = true
	end
end
LargestElements = {}
LargestElementsSize = {}
LargestElementsCount = {}
function CountFieldsHelper(f24_arg0, f24_arg1)
	if f24_arg1[f24_arg0] then
		return
	end
	f24_arg1[f24_arg0] = true
	local f24_local0 = 0
	for f24_local4, f24_local5 in pairs(f24_arg0) do
		if type(f24_local4) == "table" then
			f24_local0 = f24_local0 + CountFieldsHelper(f24_local4, f24_arg1)
		end
		f24_local0 = f24_local0 + 1
	end
	return f24_local0
end
function CountFields(f25_arg0)
	return CountFieldsHelper(f25_arg0, {})
end
function CountReferencesHelper(f26_arg0, f26_arg1)
	if f26_arg1[f26_arg0] then
		return
	end
	f26_arg1[f26_arg0] = true
	if type(f26_arg0) == "userdata" then
		local f26_local0 = getmetatable(f26_arg0)
		if not f26_local0 then
			return
		end
		f26_arg0 = f26_local0.__index
		if not f26_arg0 then
			return
		elseif type(f26_arg0) == "table" and f26_arg0.id then
			local f26_local1 = CountFields(f26_arg0)
			if not LargestElementsSize[f26_arg0.id] or LargestElementsSize[f26_arg0.id] < f26_local1 then
				LargestElements[f26_arg0.id] = f26_arg0
				LargestElementsSize[f26_arg0.id] = f26_local1
			end
			if not LargestElementsCount[f26_arg0.id] then
				LargestElementsCount[f26_arg0.id] = 0
			end
			LargestElementsCount[f26_arg0.id] = LargestElementsCount[f26_arg0.id] + 1
		end
	end
	if type(f26_arg0) ~= "table" then
		return
	end
	for f26_local3, f26_local4 in pairs(f26_arg0) do
		CountReferencesHelper(f26_local4, f26_arg1)
	end
end
function CountReferences(f27_arg0)
	local f27_local0 = {
		[f27_arg0] = true,
	}
	if type(f27_arg0) == "userdata" then
		local f27_local1 = getmetatable(f27_arg0)
		if not f27_local1 then
			return 0
		end
		f27_arg0 = f27_local1.__index
		if not f27_arg0 then
			return 0
		end
	end
	if type(f27_arg0) ~= "table" then
		return 0
	end
	for f27_local4, f27_local5 in pairs(f27_arg0) do
		CountReferencesHelper(f27_local5, f27_local0)
	end
	f27_local1 = 0
	for f27_local5, f27_local6 in pairs(f27_local0) do
		f27_local1 = f27_local1 + 1
	end
	return f27_local1
end
function DisableGlobals()
	local f28_local0 = getmetatable(_G)
	if not f28_local0 then
		f28_local0 = {}
		setmetatable(_G, f28_local0)
	end
	f28_local0.__newindex = function(f29_arg0, f29_arg1, f29_arg2)
		error("LUI Error: Tried to create global variable " .. f29_arg1, 2)
	end
	if Engine[0x2DA54CF5D6B7F02]() then
		f28_local0.__index = function(f30_arg0, f30_arg1)
			if f30_arg1 == "PreLoadFunc" or f30_arg1 == "PostLoadFunc" or f30_arg1 == "LobbyVM" then
				return nil
			end
			local f30_local0 = ""
			if debug and debug.traceback then
				f30_local0 = debug.traceback()
			end
			if string.find(f30_local0, "debuggerIndexMeta") == nil then
				if nil ~= Dvar[0x96B7991ACA20308] and Dvar[0x96B7991ACA20308]:get() then
					error("LUI Error: Tried to use undefined variable " .. f30_arg1, 2)
				else
					DebugPrint("WARNING: Tried to use undefined variable " .. f30_arg1 .. "\n" .. f30_local0)
				end
			end
		end
	end
end
function EnableGlobals()
	local f31_local0 = getmetatable(_G)
	if not f31_local0 then
		f31_local0 = {}
		setmetatable(_G, f31_local0)
	end
	f31_local0.__newindex = nil
	if Engine[0x2DA54CF5D6B7F02]() then
		f31_local0.__index = nil
	end
end
