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
		local f1_local0 = Engine[0xA798E4552F5E872](Engine[0x4DF5CFBC1771947](f1_arg0), "LootContracts")
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
			f2_local1:set(Enum[0xDFD9060F3FE5DA8][0x969C88B07100A11])
			f2_local1 = f2_arg2 - 1
			if not CoD.BaseUtility.IsDvarEnabled("ui_forcePinContractTimeOut") then
				Engine[0x356A2C9C226F6](f2_arg0, 3, 0xCF6C99AECF79C4F, 1, f2_local1, 2, f2_arg3, 3, f2_arg1)
			end
			local f2_local2 = LobbyData.GetCurrentMenuTarget()
			local f2_local3
			if f2_local2 then
				f2_local3 = f2_local2[0x8B72E07B55C3AC0]
				if not f2_local3 then
				else
					if not CoD.BaseUtility.IsDvarEnabled("ui_disablePinContractDLog") then
						Engine[0xDE279ECDDDD966](f2_arg0, 0x16179386F1005C3, {
							[0xA771618F6FE31D1] = f2_local1,
							[0xB9C77D208D5A439] = f2_arg3,
							[0x225E201820AC337] = f2_arg1,
							[0xF90D702FFE79972] = f2_local3,
							[0x7223EC6A1AA41D3] = Engine[0x316595FEDC72451](),
						})
					end
					Engine[0x30BED10F42EC695](f2_arg0, f2_arg1, f2_local1)
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
