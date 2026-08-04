CoD.LootContractsUtility = {}
CoD.LootContractsUtility.REWARD_TYPE = {
	INVALID = 0,
	CASE = 1,
	PRODUCT = 2,
	CURRENCY = 3,
}
CoD.LootContractsUtility.USER_INFO_INDEX = {
	LOW_POP = 0,
	PC = 1,
}
DataSources.LootContracts = {
	getModel = function(f1_arg0)
		local f1_local0 = Engine.CreateModel(Engine.GetModelForController(f1_arg0), "LootContracts")
		f1_local0:create("forceRefresh")
		f1_local0:create("modeOverride")
		local f1_local1 = f1_local0:create("contract_mode_1")
		f1_local1:create("pinnedContractStatus_1")
		f1_local1:create("pinnedContractStatus_2")
		f1_local1:create("pinnedContractStatus_3")
		return f1_local0
	end,
}
CoD.LootContractsUtility.UpdatePinnedContracts = function(f2_arg0, f2_arg1, f2_arg2, f2_arg3)
	if CoDShared.LootContracts.IsEnabled(f2_arg0) then
		local f2_local0 = DataSources.LootContracts.getModel(f2_arg0)
		if f2_local0 then
			local f2_local1 = f2_local0:create("pinnedContractStatus_" .. f2_arg2)
			f2_local1:set(Enum[@"hash_7DFD9060F3FE5DA8"][@"hash_969C88B07100A11"])
			f2_local1 = f2_arg2 - 1
			if not CoD.BaseUtility.IsDvarEnabled("ui_forcePinContractTimeOut") then
				Engine[0x356A2C9C226F6](f2_arg0, 3, "pin_contract", 1, f2_local1, 2, f2_arg3, 3, f2_arg1)
			end
			local f2_local2 = LobbyData.GetCurrentMenuTarget()
			local f2_local3
			if f2_local2 then
				f2_local3 = f2_local2.id
				if not f2_local3 then
				else
					if not CoD.BaseUtility.IsDvarEnabled("ui_disablePinContractDLog") then
						Engine[0xDE279ECDDDD966](f2_arg0, @"hash_516179386F1005C3", {
							slot = f2_local1,
							contract_id = f2_arg3,
							contract_mode = f2_arg1,
							menu_id = f2_local3,
							sys_ms = Engine[@"hash_6316595FEDC72451"](),
						})
					end
					Engine[@"hash_630BED10F42EC695"](f2_arg0, f2_arg1, f2_local1)
				end
			end
			f2_local3 = -1
		end
	end
end
CoD.LootContractsUtility.GetRefreshContractUserInfo = function(f3_arg0)
	local f3_local0 = 0
	if CoD.DirectorUtility.IsInLowPopRegion(f3_arg0) then
		f3_local0 = f3_local0 | 1 << CoD.LootContractsUtility.USER_INFO_INDEX.LOW_POP
	end
	if IsPC() then
		f3_local0 = f3_local0 | 1 << CoD.LootContractsUtility.USER_INFO_INDEX.PC
	end
	return f3_local0
end
CoD.LootContractsUtility.IsFeatureEnabled = function(f4_arg0)
	return CoDShared.LootContracts.IsEnabled(f4_arg0)
end
CoD.LootContractsUtility.IsUIEnabled = function(f5_arg0)
	return CoD.BaseUtility.IsDvarEnabled("ui_enableContractsAndBounties") and CoD.LootContractsUtility.IsFeatureEnabled(f5_arg0)
end
