
require( "x64:5814753ce54450b" )
if not DataSourceHelpers then
	DataSourceHelpers = {}
end
if not DataSources then
	DataSources = {}
end
function ListHelper_GetListHelperModel( f1_arg0, f1_arg1 )
	if f1_arg1 then
		return Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f1_arg0.dataSourceController ), f1_arg0.customDataSourceHelper )
	else
		return Engine[0x40E824FE270E174]( Engine[0x4DF5CFBC1771947]( f1_arg0.dataSourceController ), f1_arg0.customDataSourceHelper )
	end
end
function ListHelper_Prepare( f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4, f2_arg5 )
	f2_arg0[f2_arg2] = {}
	f2_arg0.customDataSourceHelper = f2_arg2
	f2_arg0.dataSourceController = f2_arg1
	local f2_local0 = ListHelper_GetListHelperModel( f2_arg0, true )
	for f2_local4, f2_local5 in ipairs( f2_arg3( f2_arg1, f2_arg0 ) or {} ) do
		local f2_local6 = Engine[0xA798E4552F5E872]( f2_local0, f2_local4 )
		if f2_local5.models then
			LuaUtils.CreateModelsFromTable( f2_local6, f2_local5.models )
		end
		if f2_local5.properties and f2_local5.properties.loopEdges ~= nil then
			f2_arg0.loopEdges = f2_local5.properties.loopEdges
		end
		if not f2_arg4 or f2_arg4( f2_local6 ) then
			table.insert( f2_arg0[f2_arg2], {
				model = f2_local6,
				properties = f2_local5.properties
			} )
		end
	end
	if f2_arg5 then
		f2_arg5( f2_arg1, f2_arg0, f2_local0 )
	end
end
function ListHelper_GetCount( f3_arg0 )
	if f3_arg0.customDataSourceHelper and f3_arg0[f3_arg0.customDataSourceHelper] then
		return #f3_arg0[f3_arg0.customDataSourceHelper]
	else
		return 0
	end
end
function ListHelper_GetItem( f4_arg0, f4_arg1, f4_arg2 )
	if f4_arg1.customDataSourceHelper and f4_arg1[f4_arg1.customDataSourceHelper] then
		return f4_arg1[f4_arg1.customDataSourceHelper][f4_arg2].model
	else
		return nil
	end
end
function ListHelper_GetCustomPropertiesForItem( f5_arg0, f5_arg1 )
	if f5_arg0.customDataSourceHelper and f5_arg0[f5_arg0.customDataSourceHelper] then
		return f5_arg0[f5_arg0.customDataSourceHelper][f5_arg1].properties
	else
		return nil
	end
end
function ListHelper_Cleanup( f6_arg0, f6_arg1 )
	if f6_arg0.prepared then
		local f6_local0 = ListHelper_GetListHelperModel( f6_arg0, false )
		if f6_local0 then
			Engine[0x8C7A8C4C5FD9892]( f6_local0 )
		end
	end
end
function ListHelper_SetupDataSource( f7_arg0, f7_arg1, f7_arg2, f7_arg3, f7_arg4, f7_arg5 )
	local f7_local0 = {
		getCount = ListHelper_GetCount,
		getItem = ListHelper_GetItem,
		getCustomPropertiesForItem = ListHelper_GetCustomPropertiesForItem,
		getSpacerAfterRow = f7_arg5
	}
	if f7_arg2 then
		f7_local0.cleanup = ListHelper_Cleanup
	end
	if f7_arg3 then
		for f7_local4, f7_local5 in pairs( f7_arg3 ) do
			f7_local0[f7_local4] = f7_local5
		end
	end
	f7_local0.prepare = function ( f8_arg0, f8_arg1, f8_arg2 )
		ListHelper_Prepare( f8_arg1, f8_arg0, f7_arg0, f7_arg1, f8_arg2, f7_arg4 )
	end
	
	if LUI.DEV then
		f7_local0.infoTableFn = f7_arg1
	end
	return f7_local0
end
DataSourceHelpers.ListSetup = ListHelper_SetupDataSource
function ListHelper_SetupDropdownList( f9_arg0, f9_arg1 )
	local f9_local0 = {}
	return DataSourceHelpers.ListSetup( f9_arg0, function ( f10_arg0 )
		local f10_local0 = {}
		for f10_local4, f10_local5 in pairs( f9_arg1 ) do
			table.insert( f10_local0, {
				models = f10_local5
			} )
		end
		return f10_local0
	end
	, true )
end
DataSourceHelpers.DropdownListSetup = ListHelper_SetupDropdownList
function ListHelper_SetupDataSource_CustomPrepare( f11_arg0, f11_arg1, f11_arg2, f11_arg3 )
	local f11_local0 = {
		getCount = ListHelper_GetCount,
		getItem = ListHelper_GetItem,
		getCustomPropertiesForItem = ListHelper_GetCustomPropertiesForItem
	}
	if f11_arg2 then
		f11_local0.cleanup = ListHelper_Cleanup
	end
	if f11_arg3 then
		for f11_local4, f11_local5 in pairs( f11_arg3 ) do
			f11_local0[f11_local4] = f11_local5
		end
	end
	f11_local0.prepare = function ( f12_arg0, f12_arg1, f12_arg2 )
		f12_arg1[f11_arg0] = {}
		f12_arg1.customDataSourceHelper = f11_arg0
		f12_arg1.dataSourceController = f12_arg0
		local f12_local0 = f11_arg1
		local f12_local1 = f12_arg1
		local f12_local2 = f12_arg0
		local f12_local3 = Engine[0x4DF5CFBC1771947]( f12_arg0 )
		f12_local0( f12_local1, f12_local2, f12_local3:create( f11_arg0 ), f12_arg1[f11_arg0], f12_arg2 )
	end
	
	return f11_local0
end
DataSourceHelpers.CustomListSetup = ListHelper_SetupDataSource_CustomPrepare
DataSourceHelpers.GlobalDataSourceSetup = function ( f13_arg0, f13_arg1, f13_arg2, f13_arg3, f13_arg4 )
	DataSources[f13_arg0] = LuaUtils.OverrideTable( f13_arg4, {
		_cachedModel = nil,
		getModel = function ( f14_arg0 )
			if not DataSources[f13_arg0]._cachedModel then
				local f14_local0 = DataSources.GlobalModel.getModel( f14_arg0 )
				DataSources[f13_arg0]._cachedModel = f14_local0:create( f13_arg1 )
				if f13_arg2 then
					f13_arg2( DataSources[f13_arg0]._cachedModel, f14_arg0 )
				end
			end
			return DataSources[f13_arg0]._cachedModel
		end,
		invalidate = function ( f15_arg0 )
			if not ignoreFreeOnInvalidate and f13_arg3 and DataSources[f13_arg0]._cachedModel then
				if LUI.DEV then
					local f15_local0 = LUI.DEV.ErrorIfModelsDoNotMatch
					local f15_local1 = DataSources[f13_arg0]._cachedModel
					local f15_local2 = DataSources.GlobalModel.getModel( f15_arg0 )
					f15_local0 = f15_local0( f15_local1, f15_local2[f13_arg1] )
				end
				Engine[0x8C7A8C4C5FD9892]( DataSources[f13_arg0]._cachedModel )
			end
			DataSources[f13_arg0]._cachedModel = nil
		end,
		recreate = function ( f16_arg0 )
			if not DataSources[f13_arg0]._cachedModel then
				return DataSources[f13_arg0].getModel( f16_arg0 )
			elseif f13_arg2 then
				f13_arg2( DataSources[f13_arg0]._cachedModel, f16_arg0 )
			end
			return DataSources[f13_arg0]._cachedModel
		end
	} )
	if LUI.DEV then
		DataSources[f13_arg0].prepareFn = f13_arg2
	end
end
DataSourceHelpers.PerControllerDataSourceSetup = function ( f17_arg0, f17_arg1, f17_arg2, f17_arg3, f17_arg4 )
	DataSources[f17_arg0] = LuaUtils.OverrideTable( f17_arg4, {
		_cachedModels = {},
		getModel = function ( f18_arg0 )
			if not DataSources[f17_arg0]._cachedModels[f18_arg0] then
				local f18_local0 = DataSources.PerController.getModel( f18_arg0 )
				DataSources[f17_arg0]._cachedModels[f18_arg0] = f18_local0:create( f17_arg1 )
				if f17_arg2 then
					f17_arg2( DataSources[f17_arg0]._cachedModels[f18_arg0], f18_arg0 )
				end
			end
			return DataSources[f17_arg0]._cachedModels[f18_arg0]
		end,
		invalidate = function ( f19_arg0 )
			if f17_arg3 and DataSources[f17_arg0]._cachedModels[f19_arg0] then
				if LUI.DEV then
					local f19_local0 = LUI.DEV.ErrorIfModelsDoNotMatch
					local f19_local1 = DataSources[f17_arg0]._cachedModels[f19_arg0]
					local f19_local2 = DataSources.PerController.getModel( f19_arg0 )
					f19_local0 = f19_local0( f19_local1, f19_local2[f17_arg1] )
				end
				Engine[0x8C7A8C4C5FD9892]( DataSources[f17_arg0]._cachedModels[f19_arg0] )
			end
			DataSources[f17_arg0]._cachedModels[f19_arg0] = nil
		end,
		recreate = function ( f20_arg0 )
			if not DataSources[f17_arg0]._cachedModels[f20_arg0] then
				return DataSources[f17_arg0].getModel( f20_arg0 )
			elseif f17_arg2 then
				f17_arg2( DataSources[f17_arg0]._cachedModels[f20_arg0], f20_arg0 )
			end
			return DataSources[f17_arg0]._cachedModels[f20_arg0]
		end
	} )
	if LUI.DEV then
		DataSources[f17_arg0].prepareFn = f17_arg2
	end
end
DataSourceHelpers.UpdateDataSource = function ( f21_arg0, f21_arg1 )
	f21_arg1:updateDataSource()
end
DataSourceHelpers.SubscribeOnceToUpdateDataSource = function ( f22_arg0, f22_arg1, f22_arg2, f22_arg3 )
	if not f22_arg0[f22_arg2] then
		f22_arg0[f22_arg2] = true
		f22_arg0:subscribeToModel( f22_arg1, DataSourceHelpers.UpdateDataSource, f22_arg3 )
	end
end
DataSourceHelpers.UpdateDataSourceIgnoreFocusRestore = function ( f23_arg0, f23_arg1 )
	f23_arg1:updateDataSource( true )
end
DataSourceHelpers.SubscribeOnceToUpdateDataSourceSkipFocus = function ( f24_arg0, f24_arg1, f24_arg2, f24_arg3 )
	if not f24_arg0[f24_arg2] then
		f24_arg0[f24_arg2] = true
		local f24_local0 = f24_arg0
		local f24_local1 = f24_arg0.subscribeToModel
		local f24_local2 = f24_arg1
		local f24_local3 = function ( f25_arg0 )
			f24_arg0:updateDataSource( true )
		end
		
		local f24_local4
		if f24_arg3 == nil then
			f24_local4 = true
		else
			f24_local4 = f24_arg3
		end
		f24_local1( f24_local0, f24_local2, f24_local3, f24_local4 )
	end
end
function RefreshListFindSelectedXuid( f26_arg0, f26_arg1 )
	if f26_arg1 == nil then
		return 
	end
	local f26_local0 = nil
	if f26_arg1.activeWidget ~= nil then
		local f26_local1 = f26_arg1.activeWidget:getModel( f26_arg0, "xuid" )
		if f26_local1 ~= nil then
			f26_local0 = Engine[0x614D394F6F9A18D]( f26_local1 )
		end
	end
	f26_arg1:updateDataSource( true, true )
	local f26_local1 = nil
	if f26_local0 ~= nil then
		f26_local1 = f26_arg1:findVisibleItem( {
			xuid = f26_local0
		}, nil )
		if not f26_local1 then
			f26_local1 = f26_arg1:findItem( {
				xuid = f26_local0
			}, nil, true )
		elseif f26_local1 ~= f26_arg1.activeWidget then
			f26_arg1:setActiveItem( f26_local1 )
		end
	end
	if not f26_local1 then
		f26_arg1:processEvent( {
			name = "gain_focus",
			controller = f26_arg0
		} )
	end
end
DataSources.CreateFetchedListSource = function ( f27_arg0, f27_arg1 )
	DataSources[f27_arg0] = LuaUtils.OverrideTable( {
		getModel = function ( f28_arg0 )
			return f27_arg1.model
		end,
		prepare = function ( f29_arg0, f29_arg1, f29_arg2 )
			DataSources[f27_arg0].activeLists[f29_arg1] = true
			f29_arg1.customProperties = {}
			if not f29_arg1.statusSubscription then
				f29_arg1.statusSubscription = f29_arg1:subscribeToModel( f27_arg1.statusModel, function ( model )
					if model:get() == Enum[0xA771A22127652AC][0x7D06EBE410685D0] then
						f29_arg1.customProperties = {}
						f29_arg1:updateDataSource( false, true, true )
					end
				end, false )
			end
			if #f27_arg1.fetchingPages == 0 and #f27_arg1.fetchedPages == 0 then
				DataSources[f27_arg0].getItem( f29_arg0, f29_arg1, 1 )
			end
		end,
		getCount = function ( f31_arg0 )
			return f27_arg1.totalCount
		end,
		getItem = function ( f32_arg0, f32_arg1, f32_arg2 )
			local f32_local0 = f32_arg2 - 1
			local f32_local1, f32_local2 = DataSources[f27_arg0].getArguments( f32_arg0, f32_arg1, f32_arg2 )
			if not f32_local1 then
				f32_local1 = {}
			end
			if not f32_local2 then
				f32_local2 = 0
			end
			local f32_local3, f32_local4 = f27_arg1:getItem( f32_arg0, f32_local0, f32_local1, f32_local2 )
			if not f32_local3 then
				return nil
			elseif f32_arg1.prepared and DataSources[f27_arg0].prefetchOffset > 0 and 1 < f27_arg1.pageCount then
				local f32_local5 = nil
				if f32_arg1.lastDirection == "left" or f32_arg1.lastDirection == "up" then
					f32_local5 = math.max( 1, f32_arg2 + DataSources[f27_arg0].prefetchOffset - f27_arg1.pageSize * 2 )
				else
					f32_local5 = f32_arg2 + DataSources[f27_arg0].prefetchOffset
				end
				if not f27_arg1:isPageFetching( f32_arg0, f32_local5 ) and not f27_arg1:isPageFetched( f32_arg0, f32_local5 ) then
					local f32_local6, f32_local7 = DataSources[f27_arg0].getArguments( f32_arg0, f32_arg1, f32_local5 )
					if not f32_local6 then
						f32_local6 = {}
					end
					if not f32_local7 then
						f32_local7 = 0
					end
					f27_arg1:getItem( f32_arg0, f32_local5 - 1, f32_local6, f32_local7 )
				end
			end
			local f32_local5 = DataSources[f27_arg0].setupItem( f32_local3, f32_local4 or {}, f32_arg0, f32_arg1, f32_arg2 )
			if f32_local5.models then
				LuaUtils.CreateModelsFromTable( f32_local3, f32_local5.models )
			end
			f32_arg1.customProperties[f32_arg2] = f32_local5.properties
			return f32_local3
		end,
		cleanup = function ( f33_arg0, f33_arg1 )
			DataSources[f27_arg0].activeLists[f33_arg0] = nil
			if LuaUtils.IsHashTableEmpty( DataSources[f27_arg0].activeLists ) then
				f27_arg1:cancelAllPages( f33_arg1 )
			end
		end,
		getCustomPropertiesForItem = function ( f34_arg0, f34_arg1 )
			return f34_arg0.customProperties[f34_arg1]
		end,
		refresh = function ( f35_arg0 )
			for f35_local3, f35_local4 in pairs( DataSources[f27_arg0].activeLists ) do
				f35_local3:clearLayout()
			end
			f27_arg1:cancelAllPages( f35_arg0 )
			for f35_local3, f35_local4 in pairs( DataSources[f27_arg0].activeLists ) do
				f35_local3:updateDataSource()
			end
		end,
		activeLists = {},
		prefetchOffset = 0,
		getArguments = function ( f36_arg0, f36_arg1, f36_arg2 )
			return {}, 0
		end,
		setupItem = function ( f37_arg0, f37_arg1, f37_arg2, f37_arg3, f37_arg4 )
			return {
				models = f37_arg1
			}
		end
	}, DataSources[f27_arg0] )
end
DataSources.GlobalSources = {
	getModel = function ( f38_arg0 )
		return DataSources.GlobalSources.Model
	end
}
DataSources.GlobalModel = {
	getModel = function ()
		return Engine[0x8DF2E5447F384B9]()
	end
}
DataSources.Controller = {
	getModel = function ()
		return DataSources.Controller.Model
	end
}
DataSources.VehicleController = {
	getModel = function ()
		return DataSources.VehicleController.Model
	end
}
DataSources.PerController = {
	getModel = function ( f42_arg0 )
		local f42_local0 = Engine[0x4DF5CFBC1771947]( f42_arg0 )
		local f42_local1 = Engine[0xA798E4552F5E872]( f42_local0, "identityBadge" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f42_local1, "xuid" ), Engine[0x93B19E01B1FD1C7]( f42_arg0 ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f42_local1, "gamertag" ), Engine[0x7015AC6BE5CE5F1]( f42_arg0 ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f42_local1, "clantag" ), Engine[0x290CFCDAE13C54]( f42_arg0 ) )
		Engine[0xA798E4552F5E872]( f42_local0, "forceUpdateVehicleBindings" )
		return f42_local0
	end,
	setHintText = function ( f43_arg0, f43_arg1 )
		local f43_local0 = Engine[0x40E824FE270E174]( Engine[0x4DF5CFBC1771947]( f43_arg0 ), "hintText" )
		if not f43_arg1 then
			f43_arg1 = ""
		end
		if f43_local0 then
			Engine[0x83C9B5DE1D9371]( f43_local0, f43_arg1 )
		end
	end,
	clearHintText = function ( f44_arg0, f44_arg1 )
		DataSources.PerController.setHintText( f44_arg0, "" )
	end,
	hasHintText = function ( f45_arg0 )
		local f45_local0 = Engine[0x40E824FE270E174]( Engine[0x4DF5CFBC1771947]( f45_arg0 ), "hintText" )
		if f45_local0 and Engine[0x614D394F6F9A18D]( f45_local0 ) ~= "" then
			return true
		else
			return false
		end
	end
}
DataSources.PerClient = {
	getModel = function ( f46_arg0 )
		local f46_local0 = Engine[0x761955642304848]( f46_arg0 )
		local f46_local1 = Engine[0xE4D2F32833CFA6C]( f46_local0 )
		local f46_local2 = f46_local1:create( "clientNum" )
		f46_local2:set( f46_local0 )
		return f46_local1
	end
}
function FFALeaderSetupModels( f47_arg0 )
	local f47_local0 = Engine[0x8DF2E5447F384B9]()
	f47_local0 = f47_local0:create( f47_arg0 )
	f47_local0:create( "name" )
	f47_local0:create( "clientNum" )
	f47_local0:create( "points" )
	f47_local0:create( "characterIndex" )
	f47_local0:create( "isLocalPlayer" )
	f47_local0:create( "hidden" )
	return f47_local0
end
function FFALeaderSetModels( f48_arg0, f48_arg1, f48_arg2, f48_arg3, f48_arg4, f48_arg5 )
	local f48_local0 = Engine[0x8DF2E5447F384B9]()
	f48_local0 = f48_local0:create( f48_arg0 )
	local f48_local1 = f48_local0:create( "name" )
	f48_local1:set( f48_arg1 )
	f48_local1 = f48_local0:create( "clientNum" )
	f48_local1:set( f48_arg2 )
	f48_local1 = f48_local0:create( "points" )
	f48_local1:set( f48_arg3 )
	f48_local1 = f48_local0:create( "characterIndex" )
	f48_local1:set( f48_arg4 )
	f48_local1 = f48_local0:create( "isLocalPlayer" )
	f48_local1:set( f48_arg5 )
	f48_local1 = f48_local0:create( "hidden" )
	f48_local1:set( false )
	return f48_local0
end
DataSources.FFALeader = {
	getModel = function ( f49_arg0 )
		return FFALeaderSetupModels( "FFALeader" )
	end,
	setModelValues = function ( f50_arg0, f50_arg1, f50_arg2, f50_arg3, f50_arg4 )
		FFALeaderSetModels( "FFALeader", f50_arg0, f50_arg1, f50_arg2, f50_arg3, f50_arg4 )
	end,
	setHidden = function ()
		local f51_local0 = Engine[0x8DF2E5447F384B9]()
		f51_local0 = f51_local0:create( "FFALeader" )
		local f51_local1 = f51_local0:create( "hidden" )
		f51_local1:set( true )
	end
}
DataSources.FFASecondBest = {
	getModel = function ( f52_arg0 )
		return FFALeaderSetupModels( "FFASecondBest" )
	end,
	setModelValues = function ( f53_arg0, f53_arg1, f53_arg2, f53_arg3, f53_arg4 )
		return FFALeaderSetModels( "FFASecondBest", f53_arg0, f53_arg1, f53_arg2, f53_arg3, f53_arg4 )
	end,
	setHidden = function ()
		local f54_local0 = Engine[0x8DF2E5447F384B9]()
		f54_local0 = f54_local0:create( "FFASecondBest" )
		local f54_local1 = f54_local0:create( "hidden" )
		f54_local1:set( true )
	end
}
DataSources.FFAThirdBest = {
	getModel = function ( f55_arg0 )
		return FFALeaderSetupModels( "FFAThirdBest" )
	end,
	setModelValues = function ( f56_arg0, f56_arg1, f56_arg2, f56_arg3, f56_arg4 )
		return FFALeaderSetModels( "FFAThirdBest", f56_arg0, f56_arg1, f56_arg2, f56_arg3, f56_arg4 )
	end,
	setHidden = function ()
		local f57_local0 = Engine[0x8DF2E5447F384B9]()
		f57_local0 = f57_local0:create( "FFAThirdBest" )
		local f57_local1 = f57_local0:create( "hidden" )
		f57_local1:set( true )
	end
}
function SetFFAValues( f58_arg0, f58_arg1, f58_arg2, f58_arg3, f58_arg4 )
	if #f58_arg3.clients < f58_arg4 then
		if IsCodCaster( f58_arg0 ) then
			f58_arg2.setModelValues( "", 0, "", 0, false )
		end
		f58_arg2.setHidden()
	else
		local f58_local0 = Engine[0xE4D2F32833CFA6C]( f58_arg3.clients[f58_arg4] )
		local f58_local1 = f58_local0.clientNum:get()
		f58_arg2.setModelValues( f58_local0.scoreboard.playerName:get(), f58_local1, f58_local0.scoreboard.col1:get(), f58_local0.characterIndex:get(), f58_local1 == f58_arg1 )
	end
end
DataSources.Clients = {
	prepare = function ( f59_arg0, f59_arg1, f59_arg2 )
		local f59_local0 = CoD.AARUtility.GetInGameClientNum( f59_arg0 )
		local f59_local1 = Engine[0xE4D2F32833CFA6C]( f59_local0 )
		f59_local1 = f59_local1:create( "team" )
		f59_local1 = f59_local1:get()
		if f59_local1 == Enum[0x13A4717E5AC547][0xE4DDAC9C5C45556] then
			if CoD.ShoutcasterProfileVarBool( f59_arg0, "shoutcaster_ds_flip_scorepanel" ) then
				f59_local1 = Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68]
			else
				f59_local1 = Enum[0x13A4717E5AC547][0x2A34B055ADD98AB]
			end
		end
		f59_arg1.clients = {}
		local f59_local2 = function ( f60_arg0 )
			if LUI.DEV then
				return true
			else
				local f60_local0 = Engine[0xE4D2F32833CFA6C]( f60_arg0 )
				local f60_local1 = f60_local0:create( "xuid" )
				if not f60_local1:get() or f60_local1:get() == LuaDefine.INVALID_XUID_X64 then
					return false
				else
					local f60_local2 = f60_local0:create( "scoreboard" )
					f60_local2 = f60_local2:create( "playerName" )
					if not f60_local2:get() or f60_local2:get() == "" then
						return false
					else
						return true
					end
				end
			end
		end
		
		local f59_local3 = function ( f61_arg0, f61_arg1 )
			return true
		end
		
		if f59_arg1.friendlyTeam then
			f59_local3 = function ( f62_arg0, f62_arg1 )
				return f62_arg0 == f59_local1
			end
			
		elseif f59_arg1.enemyTeam then
			f59_local3 = function ( f63_arg0, f63_arg1 )
				return CoD.TeamUtility.IsValidPlayerTeam( f63_arg0, f63_arg1 ) and f63_arg0 ~= f59_local1
			end
			
		elseif f59_arg1.ffaTeam then
			f59_local3 = function ( f64_arg0, f64_arg1 )
				return CoD.TeamUtility.IsValidPlayerTeam( f64_arg0, f64_arg1 )
			end
			
		end
		local f59_local4 = function ( f65_arg0 )
			if not f59_arg1._updateDataSourcePending then
				f59_arg1._updateDataSourcePending = true
				f59_arg1:addElement( LUI.UITimer.newElementTimer( f65_arg0, true, function ()
					f59_arg1._updateDataSourcePending = nil
					f59_arg1:updateDataSource( false, true )
				end ) )
			end
		end
		
		if not f59_arg1._hasUpdateTimer then
			f59_arg1._hasUpdateTimer = true
			f59_arg1:addElement( LUI.UITimer.newElementTimer( 500, false, function ()
				f59_arg1:updateDataSource( true, true )
			end ) )
		end
		local f59_local5 = nil
		local f59_local6 = Dvar[0x5A2E5EE8014325D]:get()
		local f59_local7 = f59_local6
		if not Engine[0x7B48C1ABFF0F764]() then
			f59_local6 = Engine[0xC4069342DB8D888]()
			f59_local7 = Engine[0x412F5A7061AC076]() or f59_local7
			f59_local5 = CoD.AARUtility.GetCurrentGametype( f59_arg0 )
		end
		if (f59_arg1.friendlyTeam or f59_arg1.enemyTeam) and not f59_arg1._teamSubscriptions then
			f59_arg1._teamSubscriptions = {}
			for f59_local8 = 0, f59_local7 - 1, 1 do
				local f59_local11 = Engine[0xE4D2F32833CFA6C]( f59_local8 )
				table.insert( f59_arg1._teamSubscriptions, f59_arg1:subscribeToModel( f59_local11:create( "team" ), function ()
					f59_local4( f59_arg1.enemyTeam and 50 or 0 )
				end, false ) )
			end
		end
		local f59_local8 = 0
		for f59_local9 = 0, f59_local7 - 1, 1 do
			local f59_local13 = Engine[0xE4D2F32833CFA6C]( f59_local9 )
			f59_local13 = f59_local13:create( "team" )
			if f59_local2( f59_local9 ) and f59_local3( f59_local13:get(), f59_local5 ) then
				table.insert( f59_arg1.clients, f59_local9 )
				if f59_local6 <= f59_local8 + 1 then
					break
				end
			end
		end
		local f59_local9 = function ( f69_arg0, f69_arg1, f69_arg2 )
			if not f69_arg2 then
				return nil
			end
			local f69_local0 = CoD.GridAndListUtility.GetListSortModelValues( f69_arg0, f69_arg1, f69_arg2 )
			local f69_local1 = {}
			for f69_local5, f69_local6 in ipairs( f69_local0 ) do
				f69_local1[f69_arg1.clients[f69_local5]] = f69_local6
			end
			return f69_local1
		end
		
		if f59_arg1._sortByModelPrimary then
			local f59_local10 = f59_local9( f59_arg0, f59_arg1, "Primary" )
			local f59_local12 = f59_local9( f59_arg0, f59_arg1, "Secondary" )
			local f59_local11 = f59_local9( f59_arg0, f59_arg1, "Tertiary" )
			table.sort( f59_arg1.clients, function ( f70_arg0, f70_arg1 )
				local f70_local0 = f59_local10[f70_arg1] < f59_local10[f70_arg0]
				local f70_local1 = f59_local12[f70_arg1] < f59_local12[f70_arg0]
				if f59_local10[f70_arg0] == f59_local10[f70_arg1] and f59_local12 then
					if f59_local12[f70_arg0] == f59_local12[f70_arg1] and f59_local11 then
						return f59_local11[f70_arg1] < f59_local11[f70_arg0]
					else
						return f70_local1
					end
				else
					return f70_local0
				end
			end )
			if not f59_arg1._sortBySubscriptionModels then
				f59_arg1._sortBySubscriptionModels = {}
			end
			if not f59_arg1._sortBySubscriptions then
				f59_arg1._sortBySubscriptions = {}
			end
			local f59_local13 = function ( f71_arg0, f71_arg1, f71_arg2 )
				if f71_arg0._sortBySubscriptionModels[f71_arg1] then
					for f71_local3, f71_local4 in ipairs( f71_arg0._sortBySubscriptions[f71_arg1] ) do
						f71_arg0:removeSubscription( f71_local4 )
					end
				end
				f71_arg0._sortBySubscriptionModels[f71_arg1] = f71_arg2
				f71_arg0._sortBySubscriptions[f71_arg1] = {}
				for f71_local3, f71_local4 in ipairs( f71_arg0.clients ) do
					local f71_local5 = Engine[0xE4D2F32833CFA6C]( f71_local4 )
					f71_local5 = f71_local5[f71_arg2]
					if f71_local5 then
						table.insert( f71_arg0._sortBySubscriptions[f71_arg1], f71_arg0:subscribeToModel( f71_local5, function ()
							if not f71_arg0._updateDataSourcePending and CoD.GridAndListUtility.DataSourceSortOrderChanged( f59_arg0, f71_arg0, f71_arg1 ) then
								f59_local4( f71_arg0.enemyTeam and 50 or 0 )
							end
						end, false ) )
					end
				end
			end
			
			if not f59_arg1._sortBySubscriptionModels then
				f59_arg1._sortBySubscriptionModels = {}
			end
			f59_local13( f59_arg1, "Primary", f59_arg1._sortByModelPrimary )
			f59_local13( f59_arg1, "Secondary", f59_arg1._sortByModelSecondary )
			f59_local13( f59_arg1, "Tertiary", f59_arg1._sortByModelTertiary )
			if f59_arg1.selectIndexTrue == nil then
				f59_arg1.selectIndexTrue = {
					selectIndex = true
				}
				local f59_local14 = f59_arg1
				local f59_local15 = f59_arg1.subscribeToModel
				local f59_local16 = Engine[0x4DF5CFBC1771947]( f59_arg0 )
				f59_local15( f59_local14, f59_local16["UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04]], function ( f73_arg0 )
					if f73_arg0:get() == 0 then
						f59_arg1.selectIndexTrue.selectIndex = true
					end
				end )
			end
			if #f59_arg1.clients > 0 and not CoDShared.IsGametypeTeamBased( f59_local5 ) then
				SetFFAValues( f59_arg0, f59_local0, DataSources.FFALeader, f59_arg1, 1 )
				SetFFAValues( f59_arg0, f59_local0, DataSources.FFASecondBest, f59_arg1, 2 )
				SetFFAValues( f59_arg0, f59_local0, DataSources.FFAThirdBest, f59_arg1, 3 )
			end
		end
	end,
	getCount = function ( f74_arg0 )
		if f74_arg0.minVisibleClients ~= nil then
			return math.max( #f74_arg0.clients, f74_arg0.minVisibleClients )
		else
			return #f74_arg0.clients
		end
	end,
	getItem = function ( f75_arg0, f75_arg1, f75_arg2 )
		if f75_arg1.clients[f75_arg2] ~= nil then
			return Engine[0xE4D2F32833CFA6C]( f75_arg1.clients[f75_arg2] )
		else
			return Engine[0xE4D2F32833CFA6C]( -1 )
		end
	end,
	getCustomPropertiesForItem = function ( f76_arg0, f76_arg1 )
		if Engine[0x761955642304848]( f76_arg0.controller ) == f76_arg0.clients[f76_arg1] then
			return f76_arg0.selectIndexTrue
		else
			return {}
		end
	end
}
DataSources.WorldSpaceIndicators = {
	getModel = function ( f77_arg0 )
		return Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f77_arg0 ), "WorldSpaceIndicators" )
	end
}
DataSources.MessageDialog = {
	getModel = function ( f78_arg0 )
		return Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "messageDialog" )
	end
}
DataSources.AccountLinkLogin = {
	getModel = function ( f79_arg0 )
		local f79_local0 = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "AccountLinkLogin" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f79_local0, "email" ), Engine[0xF9F1239CFD921FE]( 0x2DDFC55C7F5D372 ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f79_local0, "password" ), Engine[0xF9F1239CFD921FE]( 0x81703FE58609B3B ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f79_local0, "stars" ), Engine[0xF9F1239CFD921FE]( 0x81703FE58609B3B ) )
		return f79_local0
	end
}
DataSources.AccountLinkRegister = {
	getModel = function ( f80_arg0 )
		local f80_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f80_arg0 ), "AccountLinkRegister" )
		Engine[0xA798E4552F5E872]( f80_local0, "firstName" )
		Engine[0xA798E4552F5E872]( f80_local0, "lastName" )
		Engine[0xA798E4552F5E872]( f80_local0, "zipCode" )
		Engine[0xA798E4552F5E872]( f80_local0, "region" )
		Engine[0xA798E4552F5E872]( f80_local0, "username" )
		Engine[0xA798E4552F5E872]( f80_local0, "email" )
		Engine[0xA798E4552F5E872]( f80_local0, "password" )
		Engine[0xA798E4552F5E872]( f80_local0, "stars" )
		Engine[0xA798E4552F5E872]( f80_local0, "confirmPass" )
		Engine[0xA798E4552F5E872]( f80_local0, "confirmStars" )
		Engine[0xA798E4552F5E872]( f80_local0, "gender" )
		Engine[0xA798E4552F5E872]( f80_local0, "month" )
		Engine[0xA798E4552F5E872]( f80_local0, "monthIndex" )
		Engine[0xA798E4552F5E872]( f80_local0, "day" )
		Engine[0xA798E4552F5E872]( f80_local0, "year" )
		return f80_local0
	end
}
DataSources.TermsOfService = {
	getModel = function ( f81_arg0 )
		local f81_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f81_arg0 ), "TermsOfService" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f81_local0, "message" ), Engine[0x86AC3F5A9752BEE]( f81_arg0 ) )
		return f81_local0
	end
}
DataSources.Gender = {
	prepare = function ( f82_arg0, f82_arg1, f82_arg2 )
		local f82_local0 = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "GenderModel" )
		local f82_local1 = Engine[0xA798E4552F5E872]( f82_local0, "Male" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f82_local1, "gender" ), Engine[0xF9F1239CFD921FE]( 0x51560C7A6F66005 ) )
		local f82_local2 = Engine[0xA798E4552F5E872]( f82_local0, "Female" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f82_local2, "gender" ), Engine[0xF9F1239CFD921FE]( 0x3163251491F0188 ) )
		f82_arg1.genders = {
			f82_local1,
			f82_local2
		}
	end,
	getCount = function ( f83_arg0 )
		return #f83_arg0.genders
	end,
	getItem = function ( f84_arg0, f84_arg1, f84_arg2 )
		return f84_arg1.genders[f84_arg2]
	end
}
DataSources.Month = {
	prepare = function ( f85_arg0, f85_arg1, f85_arg2 )
		local f85_local0 = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "monthModel" )
		local f85_local1 = Engine[0xA798E4552F5E872]( f85_local0, "january" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f85_local1, "month" ), Engine[0xF9F1239CFD921FE]( 0xB34151E185EE1CE ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f85_local1, "monthIndex" ), 1 )
		local f85_local2 = Engine[0xA798E4552F5E872]( f85_local0, "february" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f85_local2, "month" ), Engine[0xF9F1239CFD921FE]( 0x5DC251DDFB469A2 ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f85_local2, "monthIndex" ), 2 )
		local f85_local3 = Engine[0xA798E4552F5E872]( f85_local0, "march" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f85_local3, "month" ), Engine[0xF9F1239CFD921FE]( 0x124EC1DF836E76B ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f85_local3, "monthIndex" ), 3 )
		local f85_local4 = Engine[0xA798E4552F5E872]( f85_local0, "april" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f85_local4, "month" ), Engine[0xF9F1239CFD921FE]( 0xCFE3E1DE34F6832 ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f85_local4, "monthIndex" ), 4 )
		local f85_local5 = Engine[0xA798E4552F5E872]( f85_local0, "may" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f85_local5, "month" ), Engine[0xF9F1239CFD921FE]( 0x124E51DF836DB86 ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f85_local5, "monthIndex" ), 5 )
		local f85_local6 = Engine[0xA798E4552F5E872]( f85_local0, "june" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f85_local6, "month" ), Engine[0xF9F1239CFD921FE]( 0xAF0151E18251502 ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f85_local6, "monthIndex" ), 6 )
		local f85_local7 = Engine[0xA798E4552F5E872]( f85_local0, "july" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f85_local7, "month" ), Engine[0xF9F1239CFD921FE]( 0xAF0131E1825119C ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f85_local7, "monthIndex" ), 7 )
		local f85_local8 = Engine[0xA798E4552F5E872]( f85_local0, "august" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f85_local8, "month" ), Engine[0xF9F1239CFD921FE]( 0xCF45B1DE34744F4 ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f85_local8, "monthIndex" ), 8 )
		local f85_local9 = Engine[0xA798E4552F5E872]( f85_local0, "september" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f85_local9, "month" ), Engine[0xF9F1239CFD921FE]( 0x7EA201E3AC6F62F ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f85_local9, "monthIndex" ), 9 )
		local f85_local10 = Engine[0xA798E4552F5E872]( f85_local0, "october" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f85_local10, "month" ), Engine[0xF9F1239CFD921FE]( 0xFE4341DFFD61929 ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f85_local10, "monthIndex" ), 10 )
		local f85_local11 = Engine[0xA798E4552F5E872]( f85_local0, "november" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f85_local11, "month" ), Engine[0xF9F1239CFD921FE]( 0xA70691E06585924 ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f85_local11, "monthIndex" ), 11 )
		local f85_local12 = Engine[0xA798E4552F5E872]( f85_local0, "december" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f85_local12, "month" ), Engine[0xF9F1239CFD921FE]( 0x3AFAC1DD52B9CF3 ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f85_local12, "monthIndex" ), 12 )
		f85_arg1.months = {
			f85_local1,
			f85_local2,
			f85_local3,
			f85_local4,
			f85_local5,
			f85_local6,
			f85_local7,
			f85_local8,
			f85_local9,
			f85_local10,
			f85_local11,
			f85_local12
		}
	end,
	getCount = function ( f86_arg0 )
		return #f86_arg0.months
	end,
	getItem = function ( f87_arg0, f87_arg1, f87_arg2 )
		return f87_arg1.months[f87_arg2]
	end
}
DataSources.Day = {
	prepare = function ( f88_arg0, f88_arg1, f88_arg2 )
		f88_arg1.days = {}
		local f88_local0 = 31
		local f88_local1 = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "dayModel" )
		for f88_local2 = 1, f88_local0, 1 do
			local f88_local5 = Engine[0xA798E4552F5E872]( f88_local1, "Day " .. f88_local2 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f88_local5, "day" ), f88_local2 )
			f88_arg1.days[#f88_arg1.days + 1] = f88_local5
		end
	end,
	getCount = function ( f89_arg0 )
		return #f89_arg0.days
	end,
	getItem = function ( f90_arg0, f90_arg1, f90_arg2 )
		return f90_arg1.days[f90_arg2]
	end
}
DataSources.Year = {
	prepare = function ( f91_arg0, f91_arg1, f91_arg2 )
		f91_arg1.years = {}
		local f91_local0 = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "yearModel" )
		for f91_local1 = 2015, 1900, -1 do
			local f91_local4 = Engine[0xA798E4552F5E872]( f91_local0, "Year " .. f91_local1 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f91_local4, "year" ), f91_local1 )
			f91_arg1.years[#f91_arg1.years + 1] = f91_local4
		end
	end,
	getCount = function ( f92_arg0 )
		return #f92_arg0.years
	end,
	getItem = function ( f93_arg0, f93_arg1, f93_arg2 )
		return f93_arg1.years[f93_arg2]
	end
}
DataSources.CACRestrictionSettingsTabs = ListHelper_SetupDataSource( "CACRestrictionSettingsTabs", function ( f94_arg0 )
	local f94_local0 = {}
	table.insert( f94_local0, {
		models = {
			tabName = 0xE8E97B711AC8F24,
			tabWidget = "CoD.GameSettings_WeaponRestriction",
			tabIcon = ""
		},
		properties = {
			tabId = "weapon_restriction",
			optionCategoriesTable = CoD.OptionsUtility.CustomGameOptions.WeaponRestrictionOptionCategories,
			showLargePreview = true
		}
	} )
	table.insert( f94_local0, {
		models = {
			tabName = 0x56E6F15BA89EEED,
			tabWidget = "CoD.GameSettings_AttachmentRestriction",
			tabIcon = ""
		},
		properties = {
			tabId = "attachment_restriction",
			optionCategoriesTable = CoD.OptionsUtility.CustomGameOptions.AttachmentRestrictionOptionCategories,
			showSmallPreview = true
		}
	} )
	table.insert( f94_local0, {
		models = {
			tabName = 0x4AEF303ED69E004,
			tabWidget = "CoD.GameSettings_GearRestriction",
			tabIcon = ""
		},
		properties = {
			tabId = "gear_restriction",
			optionCategoriesTable = CoD.OptionsUtility.CustomGameOptions.GearRestrictionOptionCategories,
			showLargePreview = true
		}
	} )
	table.insert( f94_local0, {
		models = {
			tabName = 0x5C60F77B9332E5B,
			tabWidget = "CoD.GameSettings_EquipmentRestriction",
			tabIcon = ""
		},
		properties = {
			tabId = "equipment_restriction",
			optionCategoriesTable = CoD.OptionsUtility.CustomGameOptions.EquipmentRestrictionOptionCategories,
			showLargePreview = true
		}
	} )
	table.insert( f94_local0, {
		models = {
			tabName = 0xE2669E63163D964,
			tabWidget = "CoD.GameSettings_PerkRestriction",
			tabIcon = ""
		},
		properties = {
			tabId = "perk_restriction",
			optionCategoriesTable = CoD.OptionsUtility.CustomGameOptions.PerkRestrictionOptionCategories,
			showLargePreview = true
		}
	} )
	table.insert( f94_local0, {
		models = {
			tabName = 0x454D80797ED0C36,
			tabWidget = "CoD.GameSettings_WildcardRestriction",
			tabIcon = ""
		},
		properties = {
			tabId = "wildcard_restriction",
			optionCategoriesTable = CoD.OptionsUtility.CustomGameOptions.WildcardRestrictionOptionCategories,
			showLargePreview = true
		}
	} )
	return f94_local0
end, true )
DataSources.GameSettingsTabs = ListHelper_SetupDataSource( "GameSettingsTabs", function ( f95_arg0 )
	local f95_local0 = {}
	local f95_local1 = Engine[0xEA74FA7EE46E195]( Engine[0x69811927938FCD7]() )
	local f95_local2 = f95_local1.nameRefCaps
	local f95_local3 = LobbyData.GetCurrentMenuTarget()
	local f95_local4 = f95_local3[0xEB7DDC7F079D51B]
	if f95_local4 == Enum[0x89C1455C5032969][0x7E41449995CD57E] or f95_local4 == Enum[0x89C1455C5032969][0x78C124999125C42] then
		table.insert( f95_local0, {
			models = {
				tabName = f95_local2,
				tabWidget = "CoD.GameSettings_GameModeRules",
				tabIcon = ""
			},
			properties = {
				tabId = "game_mode_rules",
				optionCategoriesTable = CoD.OptionsUtility.CustomGameOptions.GametypeOptionCategories
			}
		} )
		table.insert( f95_local0, {
			models = {
				tabName = 0xDF0A478ED18324A,
				tabWidget = "CoD.GameSettings_Characters",
				tabIcon = ""
			},
			properties = {
				tabId = "global_settings",
				optionCategoriesTable = CoD.OptionsUtility.CustomGameOptions.SpecialistOptionCategories
			}
		} )
		if IsBooleanDvarSet( "ui_enableRestrictionsCustomGameSettings" ) then
			table.insert( f95_local0, {
				models = {
					tabName = 0x8B13CD4A57F560,
					tabWidget = "CoD.GameSettings_Restriction",
					tabIcon = ""
				},
				properties = {
					tabId = "restriction_settings",
					optionCategoriesTable = CoD.OptionsUtility.CustomGameOptions.RestrictionOptionCategories,
					showLargePreview = true
				}
			} )
		end
	elseif f95_local4 == Enum[0x89C1455C5032969][0x7B50049993542C0] then
		table.insert( f95_local0, {
			models = {
				tabName = f95_local2,
				tabWidget = "CoD.GameSettings_GameModeRules",
				tabIcon = ""
			},
			properties = {
				tabId = "game_mode_rules"
			}
		} )
	elseif f95_local4 == Enum[0x89C1455C5032969][0x79D01499920B292] then
		table.insert( f95_local0, {
			models = {
				tabName = 0xEDC7C8B1FD8453F,
				tabWidget = "CoD.GameSettings_ZMGeneral",
				tabIcon = ""
			},
			properties = {
				tabId = "zm_general_settings"
			}
		} )
		table.insert( f95_local0, {
			models = {
				tabName = 0xD1BDFA5F7482249,
				tabWidget = "CoD.GameSettings_ZMSystems",
				tabIcon = ""
			},
			properties = {
				tabId = "zm_systems_settings"
			}
		} )
		table.insert( f95_local0, {
			models = {
				tabName = 0x5F975C212125124,
				tabWidget = "CoD.GameSettings_ZMWeapons",
				tabIcon = ""
			},
			properties = {
				tabId = "zm_weapons_settings"
			}
		} )
		table.insert( f95_local0, {
			models = {
				tabName = 0xA4C0D40C8DBA6EB,
				tabWidget = "CoD.GameSettings_ZMEnemies",
				tabIcon = ""
			},
			properties = {
				tabId = "zm_enemies_settings"
			}
		} )
		table.insert( f95_local0, {
			models = {
				tabName = 0x89CF1420A8398FE,
				tabWidget = "CoD.GameSettings_ZMPlayer",
				tabIcon = ""
			},
			properties = {
				tabId = "zm_player_settings"
			}
		} )
	end
	return f95_local0
end, true )
DataSources.CPGamePlayBundleData = {
	getModel = function ( f96_arg0 )
		local f96_local0 = Engine[0x4DF5CFBC1771947]( f96_arg0 )
		f96_local0 = f96_local0.GamePlayBundle
		if not f96_local0 then
			local f96_local1 = Engine[0x4DF5CFBC1771947]( f96_arg0 )
			f96_local0 = f96_local1:create( "GamePlayBundle" )
			f96_local1 = f96_local0:create( "briefcaseClient" )
			f96_local1:set( -1 )
			f96_local1 = f96_local0:create( "hackPercentage" )
			f96_local1:set( -1 )
		end
		return f96_local0
	end
}
DataSources.GameSettingsOptions = ListHelper_SetupDataSource( "GameSettingsOptions", function ( f97_arg0 )
	local f97_local0 = {}
	if IsLive() then
		
	else
		
	end
	table.insert( f97_local0, {
		models = {
			displayText = 0xF3961A88C5D989F,
			description = 0x6E3D19E4771D96A,
			action = ResetGameSettings,
			icon = "t7_icon_menu_simple_revertchanges",
			disabled = false
		}
	} )
	local f97_local1 = Engine[0x614D394F6F9A18D]( Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "GametypeSettings.selectedSetting" ) )
	local f97_local2 = CoD.perController[f97_arg0].selectedGameSettingElement
	if f97_local2 and f97_local2.revert then
		table.insert( f97_local0, {
			models = {
				displayText = 0x6BD8B5A9F92940E,
				description = 0xC0AB819D989C0C2,
				action = ResetSelectedGameSetting,
				icon = "t7_icon_menu_simple_revertsetting",
				disabled = false
			}
		} )
	end
	return f97_local0
end, true )
DataSources.CodCasterQuickSettingsButtonList = ListHelper_SetupDataSource( "CodCasterQuickSettingsButtonList", function ( f98_arg0 )
	local f98_local0 = {}
	for f98_local4, f98_local5 in ipairs( {
		{
			displayText = 0x299F95A39AB2D77,
			hintText = 0x9C1E2D268DAB861,
			profileVar = "shoutcaster_qs_xray"
		},
		{
			displayText = 0xFD52C74A290B6E6,
			hintText = 0x28B895879F50DBA,
			profileVar = "shoutcaster_qs_listen_in"
		},
		{
			displayText = 0x158B41E46D3C8B3,
			hintText = 0x3ECA69C5B4AC7BD,
			profileVar = "shoutcaster_qs_playerlist"
		},
		{
			displayText = 0xCE2FDD4BE0ACF61,
			hintText = 0x589105A0F2208F7,
			profileVar = "shoutcaster_qs_loadout"
		},
		{
			displayText = 0x1A4D8254476D8DD,
			hintText = 0x6BA589C96CE7BD3,
			profileVar = "shoutcaster_qs_playercard"
		},
		{
			displayText = 0xDC6694F70008580,
			hintText = 0x6834D0B07E2DB0,
			profileVar = "shoutcaster_qs_playerhud"
		}
	} ) do
		table.insert( f98_local0, {
			models = {
				displayText = Engine[0xF9F1239CFD921FE]( f98_local5.displayText ),
				hintText = Engine[0xF9F1239CFD921FE]( f98_local5.hintText ),
				profileVarValue = CoD.ShoutcasterProfileVarBool( f98_arg0, f98_local5.profileVar )
			},
			properties = {
				profileVar = f98_local5.profileVar
			}
		} )
	end
	return f98_local0
end )
DataSources.CodCasterDisplaySettingsButtonList = ListHelper_SetupDataSource( "CodCasterDisplaySettingsButtonList", function ( f99_arg0 )
	local f99_local0 = {}
	local f99_local1 = function ( f100_arg0, f100_arg1, f100_arg2, f100_arg3 )
		if not Engine[0x7B48C1ABFF0F764]() then
			return 
		else
			ToggleControllerModelValueNumber( f100_arg1, "CodCaster.profileSettingsUpdated" )
		end
	end
	
	local f99_local2 = {}
	table.insert( f99_local2, {
		name = 0x17857948FC2CCFC,
		value = 0
	} )
	table.insert( f99_local2, {
		name = 0x5BE4D02B20F370A,
		value = 1
	} )
	local f99_local3 = {}
	table.insert( f99_local3, {
		name = 0x17857948FC2CCFC,
		value = Enum[0xF1A952FE3D3FB8A][0xD97E008D0EFDDDB]
	} )
	table.insert( f99_local3, {
		name = 0x115218EA657D7E7,
		value = Enum[0xF1A952FE3D3FB8A][0x33611F64275EE4F]
	} )
	table.insert( f99_local3, {
		name = 0x4933938EE8FA2C1,
		value = Enum[0xF1A952FE3D3FB8A][0x9920736FBD406A7]
	} )
	for f99_local7, f99_local8 in ipairs( {
		{
			name = "TeamIdentity",
			displayText = 0x4E051F15AE3B3B8,
			hintText = 0x7162EF92AABD1E0,
			profileVar = "shoutcaster_ds_team_identity",
			options = f99_local2
		},
		{
			name = "Toolbar",
			displayText = 0xE833ED6D22943CB,
			hintText = 0x4A677D947DAA8DD,
			profileVar = "shoutcaster_ds_toolbar",
			options = f99_local2
		},
		{
			name = "Minimap",
			displayText = 0x1EB38EB608607DF,
			hintText = 0xE10A2436A7F7271,
			profileVar = "shoutcaster_ds_minimap",
			options = f99_local3
		},
		{
			name = "TeamScore",
			displayText = 0xBC59621C600E8A8,
			hintText = 0x35F8D848A5BBAF0,
			profileVar = "shoutcaster_ds_teamscore",
			options = f99_local2
		},
		{
			name = "Inventory",
			displayText = 0xF0A38E8FD4AE594,
			hintText = 0x81BE89B8915175C,
			profileVar = "shoutcaster_ds_inventory",
			options = f99_local2
		},
		{
			name = "Scorestreaks",
			displayText = 0x719AD669D6F0AA1,
			hintText = 0x2750070E33A06DB,
			profileVar = "shoutcaster_ds_scorestreaks",
			options = f99_local2
		},
		{
			name = "ScorestreakNotifications",
			displayText = 0x3B3DF2EDB5CD01F,
			hintText = 0xC27D2DDE8805CB1,
			profileVar = "shoutcaster_ds_scorestreaks_notification",
			options = f99_local2
		},
		{
			name = "SpecialistNotifications",
			displayText = 0x66056F46351AD2E,
			hintText = 0xF03A054594EF21E,
			profileVar = "shoutcaster_ds_specialist_notification",
			options = f99_local2
		},
		{
			name = "ObjectiveStatus",
			displayText = 0x37D1364A3C611DE,
			hintText = 0x4FA4BBC279DC2EE,
			profileVar = "shoutcaster_ds_objective_status",
			options = f99_local2
		},
		{
			name = "WaypointMarkers",
			displayText = 0xA6ED171ECA1CA83,
			hintText = 0x497F3F256360615,
			profileVar = "shoutcaster_ds_waypoint_markers",
			options = f99_local2
		},
		{
			name = "KillFeed",
			displayText = 0x317E0D8392484C,
			hintText = 0x4568A3C9BC35BB4,
			profileVar = "shoutcaster_ds_killfeed",
			options = f99_local2
		},
		{
			name = "CalloutCards",
			displayText = 0x839353C3F7C0920,
			hintText = 0x73E132A6781ABE8,
			profileVar = "shoutcaster_ds_calloutcards",
			options = f99_local2
		},
		{
			name = "PlayerNotifications",
			displayText = 0x2DBB62222E4A02,
			hintText = 0xAA680F464E9B692,
			profileVar = "shoutcaster_ds_playernotifications",
			options = f99_local2
		},
		{
			name = "VoipDock",
			displayText = 0x8E58ED90B20C3E4,
			hintText = 0xCEDB7FD7243874C,
			profileVar = "shoutcaster_ds_voip_dock",
			options = f99_local2
		},
		{
			name = "ShowEquipment",
			displayText = 0x8C3502B2B8BBB92,
			hintText = 0x2B1F5024CCBDBC2,
			profileVar = "shoutcaster_ds_show_equipment",
			options = f99_local2
		}
	} ) do
		table.insert( f99_local0, {
			models = {
				displayText = f99_local8.displayText,
				hintText = f99_local8.hintText,
				buttonOnly = false,
				disabled = false,
				optionsDatasource = CoD.OptionsUtility.CreateCustomOptionDataSource( f99_arg0, "CoDCasterDisplaySettings_" .. f99_local8.name, f99_local8.options, f99_local8.profileVar, f99_local1, CoD.CodCasterUtility.Options_ItemSelected, CoD.CodCasterUtility.Options_RevertItemSelected ),
				currentSelection = CoD.CodCasterUtility.Options_GetProfileSelection( f99_arg0, f99_local8.options, f99_local8.profileVar ),
				selected = false
			},
			properties = {
				hideArrows = false,
				disabled = false
			}
		} )
	end
	return f99_local0
end )
DataSources.CodCasterLoadoutSettingsButtonList = ListHelper_SetupDataSource( "CodCasterLoadoutSettingsButtonList", function ( f101_arg0 )
	local f101_local0 = {}
	local f101_local1 = function ( f102_arg0, f102_arg1, f102_arg2, f102_arg3 )
		if not Engine[0x7B48C1ABFF0F764]() then
			return 
		else
			ToggleControllerModelValueNumber( f102_arg1, "CodCaster.profileSettingsUpdated" )
		end
	end
	
	local f101_local2 = {}
	table.insert( f101_local2, {
		name = 0x17857948FC2CCFC,
		value = 0
	} )
	table.insert( f101_local2, {
		name = 0x5BE4D02B20F370A,
		value = 1
	} )
	for f101_local6, f101_local7 in ipairs( {
		{
			name = "Equipment",
			displayText = 0xC2DCD41998F5070,
			hintText = 0xA6232DDBCBCD0D8,
			profileVar = "shoutcaster_ls_equipment"
		},
		{
			name = "Perks",
			displayText = 0x45620053431E9CD,
			hintText = 0x8F97306C2EF71F7,
			profileVar = "shoutcaster_ls_perks"
		}
	} ) do
		table.insert( f101_local0, {
			models = {
				displayText = f101_local7.displayText,
				hintText = f101_local7.hintText,
				buttonOnly = false,
				disabled = false,
				optionsDatasource = CoD.OptionsUtility.CreateCustomOptionDataSource( f101_arg0, "CoDCasterLoadoutSettings_" .. f101_local7.name, f101_local2, f101_local7.profileVar, f101_local1, CoD.CodCasterUtility.Options_ItemSelected, CoD.CodCasterUtility.Options_RevertItemSelected ),
				currentSelection = CoD.CodCasterUtility.Options_GetProfileSelection( f101_arg0, f101_local2, f101_local7.profileVar ),
				selected = false
			},
			properties = {
				hideArrows = false,
				disabled = false
			}
		} )
	end
	return f101_local0
end )
DataSources.TeamIdentity = {
	getModel = function ( f103_arg0 )
		if not f103_arg0 then
			f103_arg0 = Engine[0xA5B9C0111291A8B]()
		end
		return Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f103_arg0 ), "TeamIdentity" )
	end
}
DataSources.TeamIdentityInformation = {
	getModel = function ( f104_arg0, f104_arg1 )
		if not f104_arg0 then
			f104_arg0 = Engine[0xA5B9C0111291A8B]()
		end
		local f104_local0 = Engine[0x40E824FE270E174]( Engine[0x4DF5CFBC1771947]( f104_arg0 ), "TeamIdentity" )
		if not f104_arg1 then
			f104_arg1 = Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f104_local0, "team" ) )
		end
		return Engine[0xA798E4552F5E872]( f104_local0, f104_arg1 )
	end
}
DataSources.TeamIdentityColorList = ListHelper_SetupDataSource( "TeamIdentityColorList", function ( f105_arg0 )
	local f105_local0 = {}
	if not CoD.CodCaster_TeamIdentity then
		CoD.CodCaster_TeamIdentity = {}
	end
	if not CoD.CodCaster_TeamIdentity.ColorList then
		CoD.CodCaster_TeamIdentity.ColorList = CoD.CodCasterUtility.GetCodCasterTeamColorList( f105_arg0 )
	end
	local f105_local1 = CoD.CodCaster_TeamIdentity.ColorList
	local f105_local2 = Engine[0x40E824FE270E174]( Engine[0x4DF5CFBC1771947]( f105_arg0 ), "TeamIdentity" )
	if f105_local2 then
		local f105_local3 = Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f105_local2, "team" ) )
		local f105_local4 = CoD.ShoutcasterProfileVarValue( f105_arg0, "shoutcaster_fe_" .. f105_local3 .. "_color" )
		local f105_local5 = -1
		if f105_local3 == "team1" then
			f105_local5 = CoD.ShoutcasterProfileVarValue( f105_arg0, "shoutcaster_fe_team2_color" )
		elseif f105_local3 == "team2" then
			f105_local5 = CoD.ShoutcasterProfileVarValue( f105_arg0, "shoutcaster_fe_team1_color" )
		end
		for f105_local6 = 1, #f105_local1, 1 do
			local f105_local9 = f105_local1[f105_local6]
			local f105_local10 = false
			local f105_local11 = false
			local f105_local12 = false
			if f105_local4 == f105_local6 - 1 then
				f105_local10 = true
				f105_local12 = true
			end
			if f105_local5 >= 0 and f105_local5 == f105_local6 - 1 then
				f105_local11 = true
			end
			if f105_local11 == false then
				table.insert( f105_local0, {
					models = {
						id = Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f105_local9, "id" ) ),
						color = Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f105_local9, "color" ) ),
						disabled = f105_local11,
						selected = f105_local12
					},
					properties = {
						selectIndex = f105_local10,
						disabled = f105_local11
					}
				} )
			end
		end
	end
	return f105_local0
end )
DataSources.TeamIdentityLogoList = ListHelper_SetupDataSource( "TeamIdentityLogoList", function ( f106_arg0 )
	local f106_local0 = {}
	if not CoD.CodCaster_TeamIdentity.LogoList then
		CoD.CodCaster_TeamIdentity.LogoList = CoD.CodCasterUtility.GetCodCasterTeamLogoList( f106_arg0 )
	end
	local f106_local1 = CoD.CodCaster_TeamIdentity.LogoList
	local f106_local2 = Engine[0x40E824FE270E174]( Engine[0x4DF5CFBC1771947]( f106_arg0 ), "TeamIdentity" )
	if f106_local2 then
		local f106_local3 = Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f106_local2, "team" ) )
		local f106_local4 = CoD.ShoutcasterProfileVarValue( f106_arg0, "shoutcaster_fe_" .. f106_local3 .. "_icon" )
		local f106_local5 = -1
		if f106_local3 == "team1" then
			f106_local5 = CoD.ShoutcasterProfileVarValue( f106_arg0, "shoutcaster_fe_team2_icon" )
		elseif f106_local3 == "team2" then
			f106_local5 = CoD.ShoutcasterProfileVarValue( f106_arg0, "shoutcaster_fe_team1_icon" )
		end
		for f106_local6 = 1, #f106_local1, 1 do
			local f106_local9 = f106_local1[f106_local6]
			local f106_local10 = false
			local f106_local11 = false
			if f106_local4 == f106_local6 - 1 then
				f106_local10 = true
			end
			if f106_local5 >= 0 and f106_local5 == f106_local6 - 1 then
				f106_local11 = true
			end
			table.insert( f106_local0, {
				models = {
					id = Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f106_local9, "id" ) ),
					name = Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f106_local9, "name" ) ),
					ref = Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f106_local9, "ref" ) ),
					disabled = f106_local11
				},
				properties = {
					selectIndex = f106_local10,
					disabled = f106_local11
				}
			} )
		end
	end
	return f106_local0
end )
DataSources.MyShowcaseTabs = ListHelper_SetupDataSource( "MyShowcaseTabs", function ( f107_arg0 )
	local f107_local0 = {}
	table.insert( f107_local0, {
		models = {
			tabIcon = CoD.buttonStrings.shoulderl
		},
		properties = {
			m_mouseDisabled = true
		}
	} )
	table.insert( f107_local0, {
		models = {
			tabName = Engine[0xF9F1239CFD921FE]( 0x16B11F770C43455 ),
			tabWidget = "CoD.MyShowcase_CategorySelector",
			tabIcon = ""
		},
		properties = {
			tabId = "categories",
			selectIndex = true
		}
	} )
	table.insert( f107_local0, {
		models = {
			tabIcon = CoD.buttonStrings.shoulderr
		},
		properties = {
			m_mouseDisabled = true
		}
	} )
	return f107_local0
end )
DataSources.MyShowcasePaintjobsTabs = ListHelper_SetupDataSource( "MyShowcasePaintjobsTabs", function ( f108_arg0 )
	return {}
end )
DataSources.GametypeSettings = {
	getModel = function ( f109_arg0 )
		local f109_local0 = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "GametypeSettings" )
		Engine[0xA798E4552F5E872]( f109_local0, "title" )
		Engine[0xA798E4552F5E872]( f109_local0, "description" )
		Engine[0xA798E4552F5E872]( f109_local0, "image" )
		Engine[0xA798E4552F5E872]( f109_local0, "tabId" )
		Engine[0xA798E4552F5E872]( f109_local0, "settingsSubCategory" )
		local f109_local1 = Engine[0xA798E4552F5E872]( f109_local0, "gametype" )
		local f109_local2 = Engine[0xEA74FA7EE46E195]( Engine[0x69811927938FCD7]() )
		local f109_local3 = f109_local2.nameRefCaps
		local f109_local4 = Engine[0x83C9B5DE1D9371]
		local f109_local5 = f109_local1
		local f109_local6
		if f109_local3 then
			f109_local6 = Engine[0xF9F1239CFD921FE]( f109_local3 )
			if not f109_local6 then
			
			else
				f109_local4( f109_local5, f109_local6 )
				return f109_local0
			end
		end
		f109_local6 = ""
	end
}
DataSources.GunsmithSnapshot = {
	getModel = function ( f110_arg0 )
		local f110_local0 = Engine[0x3EAC408F958FF05]()
		if f110_local0 ~= Enum[0x9C0C2196D8313A0][0x60063C67132EB69] then
			f110_local0 = Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5]
		end
		local f110_local1 = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "GunsmithSnapshot" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f110_local1, "Stats" ), 1 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f110_local1, "WeaponLevel" ), 1 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f110_local1, "PlayerID" ), 1 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f110_local1, "WeaponName" ), 1 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f110_local1, "AttachmentIcons" ), 1 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f110_local1, "BO3Logo" ), 1 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f110_local1, "ShowControls" ), 1 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f110_local1, "SessionMode" ), f110_local0 )
		return f110_local1
	end
}
DataSources.GunsmithSnapshotStatsList = ListHelper_SetupDataSource( "GunsmithSnapshotStatsList", function ( f111_arg0 )
	local f111_local0 = CoD.perController[f111_arg0].gunsmithVariantModel
	local f111_local1 = Engine[0x40E824FE270E174]( f111_local0, "variantIndex" )
	local f111_local2 = nil
	if f111_local1 then
		f111_local2 = Engine[0x614D394F6F9A18D]( f111_local1 )
	end
	local f111_local3 = Engine[0x40E824FE270E174]( f111_local0, "weaponIndex" )
	local f111_local4 = nil
	if f111_local3 then
		f111_local4 = Engine[0x614D394F6F9A18D]( f111_local3 )
	end
	local f111_local5 = {
		"statName",
		"variantStatValue",
		"weaponStatValue"
	}
	local f111_local6 = CoD.CraftUtility.Gunsmith.GetSnapshotSessionMode()
	local f111_local7 = CoD.CraftUtility.Gunsmith.GetWeaponStatList( f111_arg0, f111_local4, f111_local6 )
	local f111_local8 = false
	local f111_local9 = 0
	if Gunsmith_IsCurrentVariantChanged( f111_arg0 ) then
		f111_local8 = true
	end
	local f111_local10 = function ( f112_arg0, f112_arg1, f112_arg2 )
		local f112_local0 = "GunsmithStats_Column_" .. tostring( f112_arg1 )
		DataSources[f112_local0] = DataSourceHelpers.ListSetup( f112_local0, function ( f113_arg0 )
			local f113_local0 = {}
			for f113_local4, f113_local5 in ipairs( f111_local5 ) do
				if not f111_local8 then
					f111_local9 = CoD.CraftUtility.Gunsmith.GetVariantStats( f113_arg0, f112_arg2, f111_local2 + 1, f111_local6 )
				end
				table.insert( f113_local0, {
					models = {
						statName = CoD.CraftUtility.Gunsmith.GetWeaponStatHeader( f112_arg2 ),
						variantStatValue = f111_local9,
						weaponStatValue = CoD.CraftUtility.Gunsmith.GetWeaponStats( f113_arg0, f112_arg2, f111_local4, f111_local6 ),
						type = f113_local5
					}
				} )
			end
			return f113_local0
		end )
		return f112_local0
	end
	
	local f111_local11 = {}
	for f111_local15, f111_local16 in ipairs( f111_local7 ) do
		table.insert( f111_local11, {
			models = {
				SnapshotStatsColumn = f111_local10( f111_arg0, f111_local15, f111_local16 )
			}
		} )
	end
	return f111_local11
end )
DataSources.CreateAClassEditSettingsName = {
	getModel = function ( f114_arg0 )
		local f114_local0 = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "CreateAClassEditSettingsName" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f114_local0, "name" ), 0x6F75B5A55737FFC )
		return f114_local0
	end
}
DataSources.StartMenuGameOptions = ListHelper_SetupDataSource( "StartMenuGameOptions", function ( f115_arg0, f115_arg1 )
	local f115_local0 = {}
	local f115_local1 = LobbyData.GetCurrentMenuTarget()
	if Engine[0xA55C3ACD0D2BCF0]() then
		local f115_local2 = Engine[0x79618C46565F5A4]()
		local f115_local3 = Engine[0x7FF6BC9358B7BA5]()
		local f115_local4 = Engine[0x4A884DF5CCCEB2E]()
		if not IsDemoRestrictedBasicMode() then
			table.insert( f115_local0, {
				models = {
					displayText = Engine[0xB03220D3A4F3E38]( Engine[0xF9F1239CFD921FE]( 0x56DAF6201E11DB1, f115_local2 ) ),
					action = CoD.DemoUtility.StartMenuUploadClip,
					disabledFunction = IsUploadClipButtonDisabled
				},
				locked = CoD.isPC,
				properties = {
					hideHelpItemLabel = true
				}
			} )
		end
		if f115_local3 then
			table.insert( f115_local0, {
				models = {
					displayText = Engine[0xB03220D3A4F3E38]( Engine[0xF9F1239CFD921FE]( 0x7AA390A01EFA66C ) ),
					action = CoD.DemoUtility.StartMenuOpenCustomizeHighlightReel,
					disabledFunction = IsCustomizeHighlightReelButtonDisabled
				}
			} )
		end
		table.insert( f115_local0, {
			models = {
				displayText = Engine[0xB03220D3A4F3E38]( Engine[0xB03220D3A4F3E38]( Engine[0xF9F1239CFD921FE]( 0xF890A9A81B1DE ) ) ),
				action = CoD.DemoUtility.StartMenuJumpToStart,
				disabledFunction = IsJumpToStartButtonDisabled
			}
		} )
		local f115_local5 = nil
		if f115_local4 then
			f115_local5 = Engine[0xB03220D3A4F3E38]( Engine[0xF9F1239CFD921FE]( 0x256812AA6ADD1F7 ) )
		else
			f115_local5 = Engine[0xB03220D3A4F3E38]( Engine[0xF9F1239CFD921FE]( 0xCCA8D5464EED5F7 ) )
		end
		table.insert( f115_local0, {
			models = {
				displayText = Engine[0xB03220D3A4F3E38]( f115_local5 ),
				action = CoD.DemoUtility.StartMenuEndDemo
			}
		} )
		local f115_local6 = function ()
			f115_arg1:updateDataSource()
		end
		
		if not f115_arg1.subscribedToModels then
			local f115_local7 = f115_arg1
			local f115_local8 = f115_arg1.subscribeToModel
			local f115_local9 = Engine[0x8DF2E5447F384B9]()
			f115_local8( f115_local7, f115_local9.demo.segmentCount, f115_local6, false )
			f115_local7 = f115_arg1
			f115_local8 = f115_arg1.subscribeToModel
			f115_local9 = Engine[0x8DF2E5447F384B9]()
			f115_local8( f115_local7, f115_local9.demo.keyframeForJumpBack, f115_local6, false )
			f115_arg1.subscribedToModels = true
		end
	elseif CoD.isCampaign then
		table.insert( f115_local0, {
			models = {
				displayText = 0x21A0365016C8C6E,
				action = StartMenuGoBack_ListElement
			}
		} )
		local f115_local2 = CoD.SafeGetModelValue( Engine[0x4DF5CFBC1771947]( f115_arg0 ), "safehouse.inTrainingSim" ) or 0
		if f115_arg0 == Engine[0xA5B9C0111291A8B]() then
			table.insert( f115_local0, {
				models = {
					displayText = 0xD06CC23B526BABD,
					action = RestartMission
				},
				properties = {
					disabled = not Engine[0xEA2BE00F49480D]( f115_local1[0xBF54BE1BB3D618B] )
				}
			} )
		end
		if Engine[0xEA2BE00F49480D]( f115_local1[0xBF54BE1BB3D618B] ) then
			if f115_arg0 == Engine[0xA5B9C0111291A8B]() then
				if Engine[0x9E5BE3B4BBA4E0E]( "ui_blocksaves" ) then
					table.insert( f115_local0, {
						models = {
							displayText = 0x88CEB3B9AE00AD1,
							action = SaveAndQuitGame
						}
					} )
				else
					table.insert( f115_local0, {
						models = {
							displayText = 0xB2EF56B4AF147B8,
							action = SaveAndQuitGame
						}
					} )
				end
			end
		else
			table.insert( f115_local0, {
				models = {
					displayText = 0xFB403BB3121C53C,
					action = QuitGame
				}
			} )
		end
		if true == Dvar[0xA94323F2C9E094C]:get() then
			table.insert( f115_local0, {
				models = {
					displayText = "MENU_AUTO_CONTROL_PLAYER",
					action = function ( f117_arg0, f117_arg1, f117_arg2, f117_arg3, f117_arg4 )
						StartMenuGoBack( f117_arg4, f117_arg2 )
						SendMenuResponse( f117_arg0, f117_arg4.menuName, "autocontrol", f117_arg2 )
					end
				}
			} )
		end
	elseif CoD.isMultiplayer then
		if Engine[0xA23D9EF19AFC32C]( f115_arg0, "name" ) ~= "TEAM_SPECTATOR" and Engine[0xDBC2AD5002B261B]( 0xC78F5F54144DEA5 ) ~= 1 and (not IsIntDvarNonZero( "mp_prototype" ) or IsIntDvarNonZero( "mp_prototype_debug" )) then
			table.insert( f115_local0, {
				models = {
					displayText = 0xC9A66F495BF3652,
					action = ChooseClass
				}
			} )
		end
		local f115_local3 = 0x9F0C639D44F009
		if Engine[0xEA2BE00F49480D]( f115_local1.lobbyType ) and not CoD.isOnlineGame() then
			f115_local3 = 0x1915D1BD9B1F8E5
		end
		table.insert( f115_local0, {
			models = {
				displayText = f115_local3,
				action = QuitGame_MP
			}
		} )
	elseif CoD.isZombie and not CoD.isPC then
		table.insert( f115_local0, {
			models = {
				displayText = 0x21A0365016C8C6E,
				action = StartMenuGoBack_ListElement
			}
		} )
		local f115_local2 = f115_local1[0x8B72E07B55C3AC0] == LobbyData.GetLobbyMenuIDByName( LuaEnum.UI.DIRECTOR_ONLINE_ZM_PUBLIC )
		local f115_local3 = f115_local1[0xBF54BE1BB3D618B]
		if not Engine[0x573048F8D3B4E25]() then
			f115_local3 = Engine[0xC3DF042E7492B66]( Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2] )
		end
		local f115_local4 = 0x9F0C639D44F009
		if f115_local2 then
			f115_local4 = 0x41B605F57D89FA6
		elseif Engine[0xEA2BE00F49480D]( f115_local3 ) then
			f115_local4 = 0x1915D1BD9B1F8E5
		end
		table.insert( f115_local0, {
			models = {
				displayText = f115_local4,
				action = QuitGame_MP
			}
		} )
	end
	return f115_local0
end, true )
DataSources.PlatformControllerImage = {
	getModel = function ( f118_arg0 )
		local f118_local0 = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "PlatformControllerImage" )
		local f118_local1 = Engine[0xA798E4552F5E872]( f118_local0, "image" )
		if CoD.isPC then
			Engine[0x83C9B5DE1D9371]( f118_local1, "t7_menu_startmenu_option_pc" )
		elseif CoD.isDurango then
			Engine[0x83C9B5DE1D9371]( f118_local1, "ui_icon_startmenu_option_icon_xbone" )
		else
			Engine[0x83C9B5DE1D9371]( f118_local1, "ui_icon_startmenu_option_icon_ps4" )
		end
		return f118_local0
	end
}
DataSources.MissionObjectives = ListHelper_SetupDataSource( "MissionObjectives", function ( f119_arg0 )
	local f119_local0 = {}
	local f119_local1 = 20
	local f119_local2 = Engine[0x29AE3078991963E]( f119_arg0 )
	if f119_local2 == nil then
		return 
	end
	local f119_local3 = {}
	local f119_local4 = 1
	for f119_local10, f119_local11 in CoD.BaseUtility.PairsByKeys( f119_local2 ) do
		if f119_local11.status ~= "invisible" and f119_local11.objective_desc ~= nil and f119_local11.objective_desc ~= "" and IsObjectiveVisibleForMyTeam( f119_arg0, f119_local10 - 1 ) then
			if not f119_local3[f119_local11.objective_desc] then
				f119_local3[f119_local11.objective_desc] = {
					index = f119_local4,
					desc = f119_local11.objective_desc,
					complete = f119_local11.status == "done"
				}
				f119_local4 = f119_local4 + 1
			end
			local f119_local8 = f119_local3[f119_local11.objective_desc]
			local f119_local9 = f119_local3[f119_local11.objective_desc].complete
			if f119_local9 then
				f119_local9 = f119_local11.status == "done"
			end
			f119_local8.complete = f119_local9
			if f119_local11.subobjective_desc and f119_local11.status ~= "done" then
				f119_local8 = nil
				if f119_local11.subobjective_image and f119_local11.subobjective_image ~= "" then
					f119_local8 = f119_local11.subobjective_image
				end
				if not f119_local3[f119_local11.objective_desc].sub_objectives then
					f119_local3[f119_local11.objective_desc].sub_objectives = {}
				end
				table.insert( f119_local3[f119_local11.objective_desc].sub_objectives, {
					desc = f119_local11.subobjective_desc,
					complete = f119_local11.status == "done",
					subobjective_image = f119_local8
				} )
			end
		end
	end
	f119_local5 = function ( f120_arg0, f120_arg1 )
		if not f119_local3[f120_arg1].complete then
			return false
		elseif not f119_local3[f120_arg0].complete then
			return true
		else
			return f119_local3[f120_arg0].index < f119_local3[f120_arg1].index
		end
	end
	
	f119_local6 = function ( f121_arg0, f121_arg1, f121_arg2, f121_arg3 )
		return {
			models = {
				objective = f121_arg0.desc,
				subobjective_image = f121_arg0.subobjective_image or "blacktransparent"
			},
			properties = {
				completed = f121_arg0.complete,
				subobjective = f121_arg1,
				awaitingOrders = f121_arg2,
				spacer = f121_arg3
			}
		}
	end
	
	f119_local7 = function ( f122_arg0 )
		return f119_local6( {
			desc = 0xBFA2EE8686D672D
		}, f122_arg0, true, f119_local1 )
	end
	
	f119_local10 = false
	for f119_local17, f119_local18 in LUI.IterateTableBySortedKeys( f119_local3, f119_local5 ) do
		table.insert( f119_local0, f119_local6( f119_local18 ) )
		if not f119_local18.complete then
			f119_local10 = true
			if f119_local18.sub_objectives then
				for f119_local15, f119_local16 in ipairs( f119_local18.sub_objectives ) do
					table.insert( f119_local0, f119_local6( f119_local16, true, nil, f119_local1 ) )
				end
			end
			table.insert( f119_local0, f119_local7( true ) )
		end
	end
	if not f119_local10 then
		table.insert( f119_local0, 1, f119_local7( false ) )
	end
	return f119_local0
end, true, nil, nil, function ( f123_arg0, f123_arg1, f123_arg2 )
	if f123_arg0[f123_arg0.customDataSourceHelper] then
		return f123_arg0[f123_arg0.customDataSourceHelper][f123_arg1].properties.spacer
	else
		
	end
end )
DataSources.PartyLobbyMembers = {
	prepare = function ( f124_arg0, f124_arg1, f124_arg2 )
		f124_arg1.partyLobbyModel = f124_arg1:getModel( Engine[0xA5B9C0111291A8B](), "partyLobby" )
		f124_arg1.partyLobbyMemberCountModel = Engine[0x40E824FE270E174]( f124_arg1.partyLobbyModel, "memberCount" )
		f124_arg1:unsubscribeFromAllModels()
		f124_arg1:subscribeToModel( f124_arg1.partyLobbyMemberCountModel, function ()
			f124_arg1:updateDataSource()
		end )
	end,
	getCount = function ( f126_arg0 )
		return Engine[0x614D394F6F9A18D]( f126_arg0.partyLobbyMemberCountModel )
	end,
	getItem = function ( f127_arg0, f127_arg1, f127_arg2 )
		return Engine[0x40E824FE270E174]( f127_arg1.partyLobbyModel, "member" .. f127_arg2 - 1 )
	end
}
DataSources.StorageGlobal = {
	getModel = function ( f128_arg0 )
		return Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "storageGlobalRoot" )
	end
}
DataSourceHelpers.GlobalDataSourceSetup( "LobbyRoot", "lobbyRoot", function ( f129_arg0 )
	local f129_local0 = f129_arg0:create( "isMatchmaking" )
	f129_local0:set( false )
	f129_local0 = f129_arg0:create( "showSelect" )
	f129_local0:set( true )
	f129_arg0:create( "leaderActivity" )
	f129_local0 = f129_arg0:create( "lobbyStatusString1" )
	f129_local0:set( 0x0 )
	f129_local0 = f129_arg0:create( "lobbyStatusString2" )
	f129_local0:set( 0x0 )
	f129_local0 = f129_arg0:create( "lobbyStatusString3" )
	f129_local0:set( 0x0 )
	f129_local0 = f129_arg0:create( "selectedXuid" )
	f129_local0:set( LuaDefine.INVALID_XUID_X64 )
	f129_local0 = f129_arg0:create( "selectedXuidTeam" )
	f129_local0:set( Enum[0x13A4717E5AC547][0x97263B3C1ABADF7] )
	f129_local0 = f129_arg0:create( "hostGamertag" )
	f129_local0:set( "" )
	f129_arg0:create( "lobbyButtonUpdate" )
	f129_arg0:create( "theaterDataDownloaded" )
	f129_arg0:create( "theaterDownloadPercent" )
	f129_arg0:create( "localClientTeam" )
	f129_arg0:create( "gameClientDataUpdate" )
	f129_local0 = f129_arg0:create( "percentInstalled" )
	f129_local0:set( 100 )
	f129_arg0:create( "partySettingsUpdate" )
	f129_local0 = f129_arg0:create( "selectScreenDescription" )
	f129_local0:set( 0x0 )
end, false )
DataSources.LobbyPromptTitle = {
	getModel = function ( f130_arg0 )
		local f130_local0 = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "lobbyPromptModel" )
		local f130_local1 = Engine[0xA798E4552F5E872]( f130_local0, "lobbyPromptTitle" )
		local f130_local2 = Engine[0xA798E4552F5E872]( f130_local0, "lobbyPromptDescription" )
		Engine[0x83C9B5DE1D9371]( f130_local1, CoD.LobbyUtility.Prompt.Title )
		Engine[0x83C9B5DE1D9371]( f130_local2, CoD.LobbyUtility.Prompt.Description )
		return f130_local0
	end
}
DataSources.LobbyPlaylistName = {
	getModel = function ( f131_arg0 )
		local f131_local0 = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "lobbyPlaylist" )
		local f131_local1 = Engine[0xA798E4552F5E872]( f131_local0, "name" )
		local f131_local2 = Engine[0xA798E4552F5E872]( f131_local0, "kickerText" )
		return f131_local0
	end
}
DataSources.LobbyPromptSelectionList = {
	prepare = function ( f132_arg0, f132_arg1, f132_arg2 )
		f132_arg1.options = {}
		local f132_local0 = CoD.LobbyUtility.Prompt.Options
		local f132_local1 = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "LobbyPromptSelectionListModel" )
		for f132_local5, f132_local6 in ipairs( f132_local0 ) do
			local f132_local7 = Engine[0xA798E4552F5E872]( f132_local1, "buttonModel_" .. f132_local5 )
			f132_arg1.options[f132_local5] = f132_local7
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f132_local7, "displayText" ), Engine[0xED84C33EC5F01EA]( f132_local6.optionDisplay ) )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f132_local7, "action" ), f132_local6.action )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f132_local7, "param" ), f132_local6.param )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f132_local7, "customId" ), f132_local6.customId )
		end
	end,
	getCount = function ( f133_arg0 )
		return #f133_arg0.options
	end,
	getItem = function ( f134_arg0, f134_arg1, f134_arg2 )
		return f134_arg1.options[f134_arg2]
	end
}
DataSources.PrototypeLobbyTabs = ListHelper_SetupDataSource( "PrototypeLobbyTabs", function ( f135_arg0 )
	local f135_local0 = {}
	table.insert( f135_local0, {
		models = {
			lobbyNav = LobbyData.GetLobbyMenuIDByName( LuaEnum.UI.DIRECTOR_LAN_CP ),
			tabName = 0x7B974030A04AD93
		},
		properties = {
			m_mouseDisabled = true
		}
	} )
	table.insert( f135_local0, {
		models = {
			lobbyNav = LobbyData.GetLobbyMenuIDByName( LuaEnum.UI.DIRECTOR_LAN_MP ),
			tabName = 0x55D96CC762EABDD
		},
		properties = {
			m_mouseDisabled = true
		}
	} )
	return f135_local0
end )
DataSources.PartyPrivacy = {
	getModel = function ( f136_arg0 )
		Dvar[0xE52CB4B7B32961A]:set( true )
		local f136_local0 = Engine[0xB4EEE57E45369DB]()
		local f136_local1 = Engine[0x29B25E8DA873863]( Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Engine[0xC3DF042E7492B66]( Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2] ) )
		local f136_local2 = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "PartyPrivacy" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f136_local2, "privacy" ), f136_local0 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f136_local2, "privacyStatus" ), PartyPrivacy( f136_local0 ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f136_local2, "maxPlayers" ), f136_local1 )
		return f136_local2
	end
}
DataSources.MapVote = {
	getModel = function ( f137_arg0 )
		return Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "MapVote" )
	end
}
DataSources.PregameGlobal = {
	getModel = function ( f138_arg0 )
		local f138_local0 = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "lobbyRoot.Pregame" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f138_local0, "timeleft" ), "" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f138_local0, "status" ), "" )
		return f138_local0
	end
}
DataSources.FeaturedCardsRoot = {
	getModel = function ( f139_arg0 )
		return Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "FeaturedCardsRoot" )
	end
}
DataSources.NetworkImage = {
	getModel = function ( f140_arg0 )
		return Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "NetworkImage" )
	end
}
DataSources.MarketingRoot = {
	getModel = function ( f141_arg0 )
		return Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "MarketingRoot" )
	end
}
DataSources.NetworkInfo = {
	getModel = function ( f142_arg0 )
		local f142_local0 = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "NetworkInfo" )
		local f142_local1 = Engine[0xA798E4552F5E872]( f142_local0, "natType" )
		local f142_local2 = Engine[0xA798E4552F5E872]( f142_local0, "bandwidth" )
		local f142_local3 = Engine[0xA798E4552F5E872]( f142_local0, "connectionType" )
		local f142_local4 = Engine[0xA798E4552F5E872]( f142_local0, "externalIP" )
		local f142_local5 = Engine[0xA798E4552F5E872]( f142_local0, "internalIP" )
		local f142_local6 = Engine[0xA798E4552F5E872]( f142_local0, "region" )
		local f142_local7 = Engine[0xA798E4552F5E872]( f142_local0, "version" )
		local f142_local8 = Engine[0xA798E4552F5E872]( f142_local0, "connectivityInfo" )
		local f142_local9 = Engine[0xA798E4552F5E872]( f142_local0, "supportURL" )
		local f142_local10 = function ( f143_arg0, f143_arg1 )
			local f143_local0, f143_local1 = Engine[0x50D07ABC7D13586]( f142_arg0, f143_arg1 )
			Engine[0x83C9B5DE1D9371]( f143_arg0, f143_local0 )
		end
		
		f142_local10( f142_local1, CoD.SYSINFO_NAT_TYPE )
		f142_local10( f142_local2, CoD.SYSINFO_BANDWIDTH )
		f142_local10( f142_local3, CoD.SYSINFO_CONNECTION_TYPE )
		f142_local10( f142_local4, CoD.SYSINFO_EXTERNAL_IP_ADDRESS )
		f142_local10( f142_local5, CoD.SYSINFO_INTERNAL_IP_ADDRESS )
		f142_local10( f142_local6, CoD.SYSINFO_GEOGRAPHICAL_REGION )
		f142_local10( f142_local7, CoD.SYSINFO_VERSION_NUMBER )
		f142_local10( f142_local8, CoD.SYSINFO_CONNECTIVITY_INFO )
		Engine[0x83C9B5DE1D9371]( f142_local9, Engine[0xF9F1239CFD921FE]( 0xEC643DC2290F6B8 ) )
		return f142_local0
	end
}
DataSources.PlayGoDownloadProgress = {
	getModel = function ( f144_arg0 )
		local f144_local0 = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "PlayGoDownloadProgress" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f144_local0, "progress" ), 0 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f144_local0, "chunk" ), "" )
		return f144_local0
	end
}
DataSources.NetStatsInfo = {
	getModel = function ( f145_arg0 )
		if not DataSources.NetStatsInfo._cachedModel then
			local f145_local0 = DataSources.GlobalModel.getModel( f145_arg0 )
			DataSources.NetStatsInfo._cachedModel = f145_local0:create( "NetStatsInfo", true )
			DataSources.NetStatsInfo._cachedModel:create( "NETSTATS_LATENCY", true )
			DataSources.NetStatsInfo._cachedModel:create( "NETSTATS_PACKETLOSS", true )
		end
		return DataSources.NetStatsInfo._cachedModel
	end
}
DataSources.PCTelemetry = {
	getModel = function ( f146_arg0 )
		local f146_local0 = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "PCTelemetry" )
		local f146_local1 = Engine[0xD4D7317F380395F]( f146_arg0, 0x11C116BF84FD672 ) or 0
		local f146_local2 = Engine[0xD4D7317F380395F]( f146_arg0, 0x52971DD0528944F ) or 0
		local f146_local3 = Engine[0xD4D7317F380395F]( f146_arg0, 0x866C1C9ACD412B6 ) or 0
		local f146_local4 = Engine[0xD4D7317F380395F]( f146_arg0, 0xEA583C5CDEBB94D ) or 0
		local f146_local5 = Engine[0xD4D7317F380395F]( f146_arg0, 0xDE6AC57F5398D81 ) or 0
		local f146_local6 = Engine[0xD4D7317F380395F]( f146_arg0, 0x14AFC9FA4C320F4 ) or 0
		local f146_local7 = Engine[0xD4D7317F380395F]( f146_arg0, 0x6F366EE70EDD8F5 ) or 0
		local f146_local8 = Engine[0xD4D7317F380395F]( f146_arg0, 0xB1EEA04EBAC7D32 ) or 0
		local f146_local9 = 0
		if Dvar[0x8C156AE83C76D5E]:get() then
			f146_local9 = 1
		end
		local f146_local10 = f146_local0:create( "showFPS", true )
		f146_local10:set( f146_local1 )
		f146_local10 = f146_local0:create( "showPing", true )
		f146_local10:set( f146_local2 )
		f146_local10 = f146_local0:create( "showGPUTemp", true )
		f146_local10:set( f146_local3 )
		f146_local10 = f146_local0:create( "showGPUTime", true )
		f146_local10:set( f146_local4 )
		f146_local10 = f146_local0:create( "showCPUClientTime", true )
		f146_local10:set( f146_local5 )
		f146_local10 = f146_local0:create( "showCPURenderTime", true )
		f146_local10:set( f146_local6 )
		f146_local10 = f146_local0:create( "showVRAM", true )
		f146_local10:set( f146_local7 )
		f146_local10 = f146_local0:create( "showSoundMuted", true )
		f146_local10:set( f146_local8 )
		f146_local10 = f146_local0:create( "showVoiceSuspended", true )
		f146_local10:set( f146_local9 )
		return f146_local0
	end
}
DataSources.GameplayFeedbackSettings = {
	getModel = function ( f147_arg0 )
		local f147_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f147_arg0 ), "GameplayFeedbackSettings" )
		local f147_local1 = tonumber( Engine[0xB72F603CAC75B3A]( f147_arg0, "healthbar_show_enemy" ) ) or 0
		local f147_local2 = tonumber( Engine[0xB72F603CAC75B3A]( f147_arg0, "healthbar_show_ally" ) ) or 0
		local f147_local3 = f147_local0:create( "healthBarEnemyAlpha" )
		f147_local3:set( f147_local1 )
		f147_local3 = f147_local0:create( "healthBarAllyAlpha" )
		f147_local3:set( f147_local2 )
		f147_local3 = Engine[0xB72F603CAC75B3A]( f147_arg0, "radiation_toggle" ) == 1
		local f147_local4 = f147_local0:create( "hideRadiationHold" )
		f147_local4:set( f147_local3 )
		return f147_local0
	end
}
DataSources.MOTD = {
	getModel = function ( f148_arg0 )
		local f148_local0 = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "motd" )
		local f148_local1 = Engine[0xA798E4552F5E872]( f148_local0, "isValid" )
		local f148_local2 = Engine[0xA798E4552F5E872]( f148_local0, "singleView" )
		local f148_local3 = Engine[0xA798E4552F5E872]( f148_local0, "motdVersion" )
		local f148_local4 = Engine[0xA798E4552F5E872]( f148_local0, "title" )
		local f148_local5 = Engine[0xA798E4552F5E872]( f148_local0, "message" )
		local f148_local6 = Engine[0xA798E4552F5E872]( f148_local0, "image" )
		local f148_local7 = Engine[0xA798E4552F5E872]( f148_local0, "action" )
		local f148_local8 = Engine[0xA798E4552F5E872]( f148_local0, "actionContext" )
		local f148_local9 = Engine[0xA798E4552F5E872]( f148_local0, "actionString" )
		local f148_local10 = Engine[0xA798E4552F5E872]( f148_local0, "bannerTitle" )
		local f148_local11 = Engine[0xA798E4552F5E872]( f148_local0, "bannerMessage" )
		local f148_local12 = Engine[0xA798E4552F5E872]( f148_local0, "bannerImage" )
		local f148_local13 = Engine[0xA798E4552F5E872]( f148_local0, "bannerAction" )
		local f148_local14 = Engine[0xA798E4552F5E872]( f148_local0, "bannerActionContext" )
		local f148_local15 = Engine[0xA798E4552F5E872]( f148_local0, "bannerActionString" )
		local f148_local16 = Engine[0x5F19D3070BD5FB3]()
		Engine[0x83C9B5DE1D9371]( f148_local1, f148_local16.isValid )
		if f148_local16.isValid then
			Engine[0x83C9B5DE1D9371]( f148_local2, f148_local16.singleView )
			Engine[0x83C9B5DE1D9371]( f148_local3, f148_local16.motdVersion )
			Engine[0x83C9B5DE1D9371]( f148_local4, f148_local16.title )
			Engine[0x83C9B5DE1D9371]( f148_local5, f148_local16.message )
			Engine[0x83C9B5DE1D9371]( f148_local6, f148_local16.image )
			Engine[0x83C9B5DE1D9371]( f148_local7, f148_local16.action )
			Engine[0x83C9B5DE1D9371]( f148_local8, f148_local16.actionContext )
			Engine[0x83C9B5DE1D9371]( f148_local9, f148_local16.actionString )
			Engine[0x83C9B5DE1D9371]( f148_local10, f148_local16.bannerTitle )
			Engine[0x83C9B5DE1D9371]( f148_local11, f148_local16.bannerMessage )
			Engine[0x83C9B5DE1D9371]( f148_local12, f148_local16.bannerImage )
			Engine[0x83C9B5DE1D9371]( f148_local13, f148_local16.bannerAction )
			Engine[0x83C9B5DE1D9371]( f148_local14, f148_local16.bannerActionContext )
			Engine[0x83C9B5DE1D9371]( f148_local15, f148_local16.bannerActionString )
		end
		return f148_local0
	end
}
DataSources.MtxCommsMOTD = {
	getModel = function ( f149_arg0 )
		local f149_local0 = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "mtxCommsMOTD" )
		local f149_local1 = CoD.MOTDUtility.MOTD_GetFirstMOTDTab( f149_arg0 )
		if f149_local1 ~= nil then
			for f149_local5, f149_local6 in next, f149_local1, nil do
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f149_local0, f149_local5 ), f149_local6 )
			end
			if not f149_local1.messageID then
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f149_local0, "messageID" ), 0 )
			end
			Engine[0xB81A5136C5503E4]( f149_arg0, "setupThumbnailForMarketing mtxcommsmotd " .. tostring( f149_local1.locationID ) )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f149_local0, "imageFileID" ), f149_local1.locationID )
		end
		if not f149_local1 or not f149_local1.type then
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f149_local0, "type" ), "" )
		end
		return f149_local0
	end
}
DataSources.MtxCommsRegistration = {
	getModel = function ( f150_arg0 )
		local f150_local0 = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "mtxCommsRegistration" )
		local f150_local1 = Engine[0xE205100C694EF74]( f150_arg0, "registration" )
		if f150_local1 ~= nil and not f150_local1.messageViewReported then
			for f150_local5, f150_local6 in next, f150_local1, nil do
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f150_local0, f150_local5 ), f150_local6 )
			end
			if f150_local1.action ~= "opt-in" and f150_local1.action ~= "registration" and f150_local1.content_long ~= "" then
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f150_local0, "action_title" ), Engine[0xF9F1239CFD921FE]( 0xBE1BF50C45C10B0 ) )
			end
		else
			local f150_local2 = Engine[0x5451F941503DA5A]( f150_arg0, CoD.MOTDUtility.MOTD_GetMOTDChannel() )
			if f150_local2 ~= nil and f150_local2.hasBanner then
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f150_local0, "content_short" ), f150_local2.bannerTitle )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f150_local0, "action_title" ), Engine[0xED84C33EC5F01EA]( f150_local2.bannerActionString ) )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f150_local0, "action" ), f150_local2.bannerAction )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f150_local0, "image" ), f150_local2.bannerImage )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f150_local0, "locationID" ), 1 )
			end
		end
		return f150_local0
	end
}
DataSources.CRMPopup = {
	getModel = function ( f151_arg0 )
		local f151_local0 = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "CRMPopup" )
		local f151_local1 = Engine[0x40E824FE270E174]( f151_local0, "location" )
		local f151_local2 = nil
		if f151_local1 ~= nil then
			local f151_local3 = Engine[0x614D394F6F9A18D]( f151_local1 )
			if f151_local3 == "crm_featured" then
				f151_local2 = Engine[0xE205100C694EF74]( f151_arg0, f151_local3, Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( Engine[0x40E824FE270E174]( Engine[0x40E824FE270E174]( Engine[0x4DF5CFBC1771947]( f151_arg0 ), "FeaturedCards" ), Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "FeaturedCardsRoot" ), "CardSequence" ) ) + 1 ), "index" ) ) )
			else
				f151_local2 = Engine[0xE205100C694EF74]( f151_arg0, f151_local3 )
			end
		else
			f151_local2 = Engine[0xE205100C694EF74]( f151_arg0, "crm_featured" )
		end
		if f151_local2 ~= nil then
			for f151_local6, f151_local7 in pairs( f151_local2 ) do
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f151_local0, f151_local6 ), f151_local7 )
			end
		end
		if not f151_local2 or not f151_local2.action then
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f151_local0, "action" ), "" )
		end
		return f151_local0
	end
}
DataSources.WeaponBuildKitCategories = ListHelper_SetupDataSource( "WeaponBuildKitCategories", function ( f152_arg0 )
	local f152_local0 = {}
	local f152_local1 = CoD.CraftUtility.WeaponGroupNames
	for f152_local2 = 1, #f152_local1, 1 do
		local f152_local5 = f152_local1[f152_local2]
		table.insert( f152_local0, {
			models = {
				breadcrumbCount = 0,
				categoryRef = f152_local5.weapon_category,
				categoryName = f152_local5.lowercaseName,
				categoryImage = f152_local5.weapon_image
			},
			properties = {}
		} )
	end
	return f152_local0
end, true )
DataSources.WeaponGroups = ListHelper_SetupDataSource( "WeaponGroups", function ( f153_arg0, f153_arg1 )
	local f153_local0 = {}
	local f153_local1 = CoD.BaseUtility.GetMenuLoadoutSlot( f153_arg1.menu )
	if CoD.ZMLoadoutUtility and f153_local1 == CoD.ZMLoadoutUtility.StartWeaponLoadoutSlotName then
		return f153_local0
	end
	local f153_local2 = CoD.BaseUtility.GetMenuModel( f153_arg1.menu )
	local f153_local3 = CoD.BaseUtility.GetMenuSessionMode( f153_arg1.menu )
	local f153_local4 = Engine[0x86DC0510B2E2933]( CoD.CACUtility.GetItemIndexEquippedInSlot( f153_local1, f153_arg0, f153_local2 ), Enum[0x6EB546760F890D2][0x569E84652131CD7], f153_local3 )
	local f153_local5 = DataSources.LoadoutBreadcrumbs.getModel( f153_arg0 )
	local f153_local6 = function ( f154_arg0, f154_arg1 )
		for f154_local4, f154_local5 in ipairs( f154_arg0 ) do
			local f154_local6 = CoD.CACUtility.GetUnlockableItemsForItemGroup( f153_arg0, f153_local3, f154_local5.weapon_category, true )
			if #f154_local6 > 0 and not CoD.CACUtility.AllUnlockableItemsBanned( f154_local6 ) then
				local f154_local3 = nil
				if CoD.CACUtility.IsProgressionEnabled( f153_local3 ) and f153_local5 then
					f154_local3 = f153_local5[f154_local5.weapon_category]
				end
				table.insert( f153_local0, {
					models = {
						name = f154_local5.name,
						breadcrumb = f154_local3,
						available = true,
						tabHasRestrictions = CoD.CACUtility.AnyUnlockableItemBanned( f154_local6 )
					},
					properties = {
						loadoutType = f154_arg1,
						category = f154_local5.weapon_category,
						itemGroup = f154_local5.itemGroup,
						selectIndex = f153_local4 == f154_local5.weapon_category
					}
				} )
			end
		end
	end
	
	local f153_local7 = CoD.BaseUtility.GetMenuLoadoutSlot( f153_arg1.menu )
	local f153_local8 = CoD.BonuscardUtility.IsBonuscardEquipped( f153_local2, 0x1F0C17573BB2E79, f153_local3 )
	local f153_local9 = CoD.BonuscardUtility.IsBonuscardEquipped( f153_local2, 0x439C6CFA8A0CFEB, f153_local3 )
	if not (f153_local7 ~= "primary" or f153_local9) or f153_local8 then
		f153_local6( CoD.CACUtility.GetWeaponGroupsNames( "primary" ), f153_local7 )
	elseif not (f153_local7 ~= "secondary" or f153_local8) or f153_local9 then
		f153_local6( CoD.CACUtility.GetWeaponGroupsNames( "secondary" ), f153_local7 )
	end
	return f153_local0
end, true )
DataSources.PaintshopWeaponGroups = ListHelper_SetupDataSource( "PaintshopWeaponGroups", function ( f155_arg0, f155_arg1 )
	local f155_local0 = {}
	local f155_local1 = Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5]
	local f155_local2 = function ( f156_arg0, f156_arg1, f156_arg2 )
		for f156_local3, f156_local4 in ipairs( f156_arg0 ) do
			if #CoD.CACUtility.GetUnlockableItemsForItemGroup( f155_arg0, f155_local1, f156_local4.weapon_category, true ) > 0 then
				table.insert( f155_local0, {
					models = {
						name = f156_local4.name,
						available = true
					},
					properties = {
						loadoutType = f156_arg1,
						category = f156_local4.weapon_category,
						itemGroup = f156_local4.itemGroup,
						selectIndex = f156_arg2
					}
				} )
				f156_arg2 = false
			end
		end
	end
	
	f155_local2( CoD.CACUtility.GetWeaponGroupsNames( "primary" ), "primary", true )
	f155_local2( CoD.CACUtility.GetWeaponGroupsNames( "secondary" ), "secondary", false )
	return f155_local0
end, true )
DataSources.PaintshopWeaponList = ListHelper_SetupDataSource( "PaintshopWeaponList", function ( f157_arg0, f157_arg1 )
	local f157_local0 = {}
	local f157_local1 = f157_arg1.menu.__itemGroup
	if f157_local1 then
		for f157_local6, f157_local7 in ipairs( CoD.CACUtility.GetUnlockableItemsForItemGroup( f157_arg0, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5], f157_local1 ) ) do
			if f157_local7.allocation ~= -1 then
				local f157_local5 = CoD.CACUtility.BuildItemModelDataFromUnlockableItem( f157_arg1.menu, f157_arg0, f157_local7, nil, nil, nil, nil )
				f157_local5.properties._forPaintshop = true
				f157_local5.models.hintText = ""
				table.insert( f157_local0, f157_local5 )
			end
		end
	end
	return f157_local0
end, true, {
	getSpacerAfterColumn = function ( f158_arg0, f158_arg1, f158_arg2 )
		local f158_local0 = f158_arg0[f158_arg0.dataSourceName]
		if f158_local0[f158_arg1] then
			return f158_local0[f158_arg1].properties.vSpacing or 0
		else
			return 0
		end
	end,
	getSpacerAfterRow = function ( f159_arg0, f159_arg1, f159_arg2 )
		local f159_local0 = f159_arg0[f159_arg0.dataSourceName]
		if f159_local0[f159_arg1] then
			return f159_local0[f159_arg1].properties.hSpacing or 0
		else
			return 0
		end
	end
} )
DataSources.EquippedBubbleGumPack = {
	getModel = function ( f160_arg0 )
		local f160_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f160_arg0 ), "EquippedBubbleGumPack" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f160_local0, "bgbPackIndex" ), Engine[0x68C87A9FEAC28F6]( f160_arg0 ) )
		return f160_local0
	end
}
DataSources.BubbleGumBuffs = {
	prepare = function ( f161_arg0, f161_arg1, f161_arg2 )
		DataSources.BubbleGumBuffs.setupBubbleGumBuffsModel( f161_arg0, Engine[0x4DF5CFBC1771947]( f161_arg0 ), Engine[0x68C87A9FEAC28F6]( f161_arg0 ) )
	end,
	getCount = function ( f162_arg0 )
		return CoD.BGBUtility.NumBuffsPerPack
	end,
	getItem = function ( f163_arg0, f163_arg1, f163_arg2 )
		if f163_arg1:getParent() then
			local f163_local0 = f163_arg1:getParent()
			return f163_local0:getModel( f163_arg0, "BubbleGumBuffs." .. f163_arg2 )
		else
			return Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f163_arg0 ), "BubbleGumBuffs." .. f163_arg2 )
		end
	end,
	setupBubbleGumBuffsModel = function ( f164_arg0, f164_arg1, f164_arg2 )
		local f164_local0 = Engine[0xA798E4552F5E872]( f164_arg1, "BubbleGumBuffs" )
		for f164_local1 = 0, CoD.BGBUtility.NumBuffsPerPack - 1, 1 do
			local f164_local4 = Engine[0xA798E4552F5E872]( f164_local0, f164_local1 + 1 )
			local f164_local5 = Engine[0x2321ACE1C24455D]( f164_arg0, f164_arg2, f164_local1 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f164_local4, "bgbIndex" ), f164_local1 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f164_local4, "itemIndex" ), f164_local5 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f164_local4, "name" ), Engine[0x6B7AC889104DED3]( f164_local5, Enum[0x6EB546760F890D2][0x48CD0338EE0B3AE] ) )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f164_local4, "image" ), Engine[0x8518E07C1C5BC6D]( f164_local5, Enum[0x6EB546760F890D2][0x48CD0338EE0B3AE] ) )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f164_local4, "desc" ), Engine[0x3E0DA351EF48521]( f164_local5, Enum[0x6EB546760F890D2][0x48CD0338EE0B3AE] ) )
		end
	end
}
DataSources.BubbleGumPacks = {
	prepare = function ( f165_arg0, f165_arg1, f165_arg2 )
		f165_arg1.bubbleGumPacks = {}
		local f165_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f165_arg0 ), "BubbleGumPacks" )
		for f165_local1 = 0, CoD.BGBUtility.NumPacks - 1, 1 do
			local f165_local4 = Engine[0xA798E4552F5E872]( f165_local0, f165_local1 )
			local f165_local5 = Engine[0x8E3CB087BD6EF56]( f165_arg0, f165_local1 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f165_local4, "bgbPackIndex" ), f165_local1 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f165_local4, "bubbleGumPackName" ), f165_local5 )
			DataSources.BubbleGumBuffs.setupBubbleGumBuffsModel( f165_arg0, f165_local4, f165_local1 )
			local f165_local6 = Engine[0x614D394F6F9A18D]( Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f165_arg0 ), "EquippedBubbleGumPack.bgbPackIndex" ) )
			if f165_local6 and f165_local6 + 1 == f165_local1 then
				f165_arg1.selectIndex = f165_local1
			end
			table.insert( f165_arg1.bubbleGumPacks, f165_local4 )
		end
	end,
	getCount = function ( f166_arg0 )
		return #f166_arg0.bubbleGumPacks
	end,
	getItem = function ( f167_arg0, f167_arg1, f167_arg2 )
		return f167_arg1.bubbleGumPacks[f167_arg2]
	end,
	getCustomPropertiesForItem = function ( f168_arg0, f168_arg1 )
		if f168_arg0.selectIndex == f168_arg1 then
			return {
				selectIndex = true
			}
		else
			
		end
	end
}
DataSourceHelpers.PerControllerDataSourceSetup( "MegaChewTokens", "MegaChewTokens", function ( f169_arg0, f169_arg1 )
	f169_arg0:create( "remainingTokens" )
end, false )
DataSources.MegaChewMachines = {
	getModel = function ( f170_arg0 )
		local f170_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f170_arg0 ), "MegaChewMachines" )
		for f170_local1 = 0, 2, 1 do
			local f170_local4 = Engine[0xA798E4552F5E872]( f170_local0, "machine" .. f170_local1 )
			local f170_local5 = f170_local1
			local f170_local6 = f170_local1 + 1
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f170_local4, "index" ), f170_local5 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f170_local4, "price" ), f170_local6 )
		end
		return f170_local0
	end
}
DataSources.Demo = {
	getModel = function ( f171_arg0 )
		if not f171_arg0 then
			f171_arg0 = Engine[0xA5B9C0111291A8B]()
		end
		return Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "demo" )
	end
}
DataSources.DemoControlsButtons = {
	prepare = function ( f172_arg0, f172_arg1, f172_arg2 )
		f172_arg1.buttons = {}
		local f172_local0 = {}
		local f172_local1 = Engine[0x8DF2E5447F384B9]()
		f172_local1 = f172_local1.demo
		local f172_local2 = f172_local1.isPaused
		local f172_local3 = f172_local2:get()
		local f172_local4 = f172_local1.contextMode
		local f172_local5 = f172_local1.clipState
		local f172_local6 = f172_local1.timeScale
		local f172_local7 = f172_local1.cameraMode
		local f172_local8 = f172_local1.freeCameraMode
		local f172_local9 = f172_local1.keyframeForJumpBack
		local f172_local10 = f172_local1.keyframeForJumpForward
		local f172_local11 = f172_local1.dollyCamMarkerForJumpBack
		local f172_local12 = f172_local1.dollyCamMarkerForJumpForward
		local f172_local13 = f172_local1.dollyCamMarkerCount
		local f172_local14 = f172_local1.highlightedDollyCamMarker
		local f172_local15 = f172_local1.isRecordingDollyCameraPath
		local f172_local16 = f172_local1.editingDollyCameraMarker
		local f172_local17 = f172_local16:get()
		local f172_local18 = f172_local1.currentDollyCamMarkerTimeScaleMode
		local f172_local19 = f172_local18:get()
		local f172_local20 = f172_local1.currentDollyCamMarkerTimeScaleValue
		local f172_local21 = f172_local20:get()
		local f172_local22 = f172_local1.isRepositioningDollyCamMarker
		local f172_local23 = f172_local22:get()
		local f172_local24 = f172_local1.lightmanMarkerCount
		local f172_local25 = f172_local1.highlightedLightmanMarker
		local f172_local26 = f172_local1.editingLightmanMarker
		local f172_local27 = f172_local26:get()
		local f172_local28 = f172_local1.currentLightmanMarkerLightMode
		local f172_local29 = f172_local28:get()
		local f172_local30 = f172_local1.isRepositioningLightmanMarker
		local f172_local31 = f172_local30:get()
		local f172_local32 = f172_local1.currentLightmanMarkerLightIntensity
		local f172_local33 = f172_local1.currentLightmanMarkerLightRange
		local f172_local34 = f172_local1.isCreatingHighlightReel
		local f172_local35 = f172_local34:get()
		local f172_local36 = f172_local1.isFreeCameraLockedOnEntity
		local f172_local37 = f172_local1.highlightedFreeCameraLockOnEntity
		local f172_local38 = f172_local1.isFreeCameraLockedOnEntityActive
		local f172_local39 = f172_local1.isCameraCyclingDisabled
		local f172_local40 = CoD.DemoUtility.IsCameraCyclingDisabled()
		local f172_local41 = f172_local1.isFastForwardingDisabled
		local f172_local42 = CoD.DemoUtility.IsFastForwardingDisabled()
		local f172_local43 = function ( f173_arg0 )
			if f173_arg0 <= 0.33 then
				return 0xB358FDF5F60AE90
			elseif f173_arg0 <= 0.66 then
				return 0xB3590DF5F60B043
			elseif f173_arg0 <= 0.99 then
				return 0xB3591DF5F60B1F6
			else
				return 0x19A58B96271D52E
			end
		end
		
		local f172_local44 = function ( f174_arg0 )
			if 6 <= f174_arg0 then
				return 0xFE42F0480DE7880
			elseif f174_arg0 >= 4 then
				return 0xFE4300480DE7A33
			elseif f174_arg0 >= 2 then
				return 0xFE4310480DE7BE6
			else
				return 0xFA8195959460C5E
			end
		end
		
		local f172_local45 = function ( f175_arg0 )
			if f175_arg0 == Enum[0x253C21AFC0AAE25][0x6F50CE93BF28DA9] then
				return 0x8836A8306560A2A
			elseif f175_arg0 == Enum[0x253C21AFC0AAE25][0xB5BFD14EC391330] then
				return 0x6008960BCA65979
			else
				return 0x67235575E0A08AE
			end
		end
		
		local f172_local46 = function ( f176_arg0 )
			if f176_arg0 == Enum[0x253C21AFC0AAE25][0x6F50CE93BF28DA9] then
				return 0xE6D3A97D9422664
			elseif f176_arg0 == Enum[0x253C21AFC0AAE25][0xB5BFD14EC391330] then
				return 0x29DDC8D528DC4D5
			else
				return 0x8F6F3A49A1E1E4C
			end
		end
		
		local f172_local47 = function ( f177_arg0 )
			if f177_arg0 == Enum[0x18F5DBF6846E161][0x9B555BF182ED7E2] then
				return 0xD53E0099155FE86
			else
				return 0xCD69BEABBCE5047
			end
		end
		
		local f172_local48 = function ( f178_arg0 )
			if f178_arg0 == Enum[0x18F5DBF6846E161][0x9B555BF182ED7E2] then
				return 0xC0D07B68C6F1C16
			else
				return 0x6C95E5751A62195
			end
		end
		
		local f172_local49 = function ()
			if Engine[0xFCF13BF1C420FCE]() then
				return 0x395B5E247A74E06
			else
				return 0x7F409186CCF9EAE
			end
		end
		
		if IsDemoClipPreviewRunning() or f172_local35 then
			table.insert( f172_local0, {
				btnId = "dummy",
				icon = 0x77DC565FE0848BE,
				hintText = 0x0,
				disabled = true
			} )
		elseif f172_local17 then
			if f172_local23 == true then
				table.insert( f172_local0, {
					btnId = "dollycammovecancel",
					icon = 0xD61F8B4F69737B8,
					hintText = 0xC1DB4098ABE577F,
					buttonPromptImageModel = DataSources.Controller.Model.secondary_button_image,
					action = CoD.DemoUtility.DemoCancelPlaceDollyCameraMarker
				} )
			else
				table.insert( f172_local0, {
					btnId = "movedollycameramarker",
					icon = 0xA294B63BC865A91,
					hintText = 0xC1DB4098ABE577F,
					buttonPromptImageModel = DataSources.Controller.Model.alt2_button_image,
					action = CoD.DemoUtility.RepositionDollyCamMarker,
					param = tostring( Engine[0x5BF9DEAE9B81079]() )
				} )
			end
			table.insert( f172_local0, {
				btnId = "dollycameraspeedmode",
				icon = f172_local45( f172_local19 ),
				hintText = f172_local46( f172_local19 ),
				buttonPromptImageModel = DataSources.Controller.Model.alt1_button_image,
				disabled = f172_local23 == true,
				action = CoD.DemoUtility.UpdateDollyCameraTimeScaleMode,
				param = "cycle"
			} )
			if IsMouseOrKeyboard( f172_arg0 ) then
				local f172_local50 = table.insert
				local f172_local51 = f172_local0
				local f172_local52 = {
					btnId = "dollycameratimescale",
					icon = 0x1DCA9DCD4D6F634,
					hintText = 0x52E206754A20807,
					buttonPromptImageModel = DataSources.Controller.Model.dpad_down_button_image,
					showTimescale = f172_local21 < 1
				}
				local f172_local53
				if f172_local19 ~= Enum[0x253C21AFC0AAE25][0xB995D2A247B7393] and f172_local23 ~= true then
					f172_local53 = false
				else
					f172_local53 = true
				end
				f172_local52.disabled = f172_local53
				f172_local52.action = CoD.DemoUtility.UpdateDollyCameraTimeScale
				f172_local52.param = "-0.1"
				f172_local50( f172_local51, f172_local52 )
				f172_local50 = table.insert
				f172_local51 = f172_local0
				f172_local52 = {
					btnId = "dollycameratimescale",
					icon = 0x868395925CB26A7,
					hintText = 0x52E206754A20807,
					buttonPromptImageModel = DataSources.Controller.Model.dpad_up_button_image,
					showTimescale = f172_local21 > 1
				}
				if f172_local19 ~= Enum[0x253C21AFC0AAE25][0xB995D2A247B7393] and f172_local23 ~= true then
					f172_local53 = false
				else
					f172_local53 = true
				end
				f172_local52.disabled = f172_local53
				f172_local52.action = CoD.DemoUtility.UpdateDollyCameraTimeScale
				f172_local52.param = "0.1"
				f172_local50( f172_local51, f172_local52 )
			else
				local f172_local50 = table.insert
				local f172_local51 = f172_local0
				local f172_local52 = {
					btnId = "dollycameratimescale",
					icon = 0x8FA91637A4E25F4,
					hintText = 0x52E206754A20807,
					buttonPromptImageModel = DataSources.Controller.Model.dpad_ud_button_image,
					showTimescale = true
				}
				local f172_local53
				if f172_local19 ~= Enum[0x253C21AFC0AAE25][0xB995D2A247B7393] and f172_local23 ~= true then
					f172_local53 = false
				else
					f172_local53 = true
				end
				f172_local52.disabled = f172_local53
				f172_local50( f172_local51, f172_local52 )
			end
			table.insert( f172_local0, {
				btnId = "deletedollycameramarker",
				icon = 0x4BD1D0C96ED384F,
				hintText = 0x589B138C057101F,
				buttonPromptImageModel = DataSources.Controller.Model.primary_button_image,
				disabled = f172_local23 == true,
				action = CoD.DemoUtility.RemoveCurrentDollyCamMarker
			} )
			table.insert( f172_local0, {
				btnId = "deletealldollycameramarkers",
				icon = 0x5E49A6A4F3F8223,
				hintText = 0x46A2800EE9206CF,
				buttonPromptImageModel = DataSources.Controller.Model.primary_button_image,
				buttonPromptStateModel = f172_arg1.menu.buttonModel[Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F]],
				disabled = f172_local23 == true,
				spacerWidth = 10,
				action = CoD.DemoUtility.OpenDemoOverlay,
				param = "DemoDeleteAllDollyCameraMarkers"
			} )
			if f172_local23 == true then
				table.insert( f172_local0, {
					btnId = "dollycammoveexit",
					icon = 0xCD6F4F47F250135,
					hintText = 0x0,
					buttonPromptImageModel = DataSources.Controller.Model.right_stick_button_image,
					action = CoD.DemoUtility.DemoPlaceDollyCameraMarker
				} )
			else
				table.insert( f172_local0, {
					btnId = "dollycameditexit",
					icon = 0x1C22491FE84A86D,
					hintText = 0x0,
					buttonPromptImageModel = DataSources.Controller.Model.right_stick_button_image,
					action = CoD.DemoUtility.DemoExitEditDollyCameraMarker
				} )
			end
		elseif f172_local27 then
			if f172_local31 == true then
				table.insert( f172_local0, {
					btnId = "lightmanmovecancel",
					icon = 0xFC7E24A95DA300D,
					hintText = 0xFA6D7A0AAC00197,
					buttonPromptImageModel = DataSources.Controller.Model.secondary_button_image,
					action = CoD.DemoUtility.DemoCancelPlaceLightmanMarker
				} )
			else
				table.insert( f172_local0, {
					btnId = "movelightmanmarker",
					icon = 0xD24E1B46822A76,
					hintText = 0xFA6D7A0AAC00197,
					buttonPromptImageModel = DataSources.Controller.Model.alt2_button_image,
					action = CoD.DemoUtility.RepositionLightmanMarker,
					param = tostring( Engine[0x5BF9DEAE9B81079]() )
				} )
			end
			table.insert( f172_local0, {
				btnId = "lightmanlightmode",
				icon = f172_local47( f172_local29 ),
				hintText = f172_local48( f172_local29 ),
				buttonPromptImageModel = DataSources.Controller.Model.alt1_button_image,
				disabled = f172_local31 == true,
				action = CoD.DemoUtility.UpdateLightmanLightMode,
				param = "cycle"
			} )
			if IsMouseOrKeyboard( f172_arg0 ) then
				local f172_local50 = math.floor( 10 * f172_local32:get() + 0.5 ) / 10
				table.insert( f172_local0, {
					btnId = "lightmanlightintensityminus",
					icon = 0xE685DB08682E616,
					text = CoD.DemoUtility.GetRoundedLightFloatParam( f172_local50 ),
					hintText = 0x42C6CF278B1F1D9,
					buttonPromptImageModel = DataSources.Controller.Model.dpad_left_button_image,
					disabled = f172_local31 == true,
					showTimescale = f172_local50 < 5,
					action = CoD.DemoUtility.UpdateLightmanIntensity,
					param = "-0.5"
				} )
				table.insert( f172_local0, {
					btnId = "lightmanlightintensityplus",
					icon = 0x3A71BD6F73F4AB,
					text = CoD.DemoUtility.GetRoundedLightFloatParam( f172_local50 ),
					hintText = 0x42C6CF278B1F1D9,
					buttonPromptImageModel = DataSources.Controller.Model.dpad_right_button_image,
					disabled = f172_local31 == true,
					showTimescale = f172_local50 > 5,
					action = CoD.DemoUtility.UpdateLightmanIntensity,
					param = "0.5"
				} )
				local f172_local51 = math.floor( 10 * f172_local33:get() + 0.5 ) / 10
				table.insert( f172_local0, {
					btnId = "lightmanlightrangeminus",
					icon = 0x1DCA9DCD4D6F634,
					text = CoD.DemoUtility.GetRoundedLightFloatParam( f172_local51 ),
					hintText = 0x8A89BB505765B35,
					buttonPromptImageModel = DataSources.Controller.Model.dpad_down_button_image,
					disabled = f172_local31 == true,
					showTimescale = f172_local51 < 5,
					action = CoD.DemoUtility.UpdateLightmanRange,
					param = "-0.5"
				} )
				table.insert( f172_local0, {
					btnId = "lightmanlightrangeplus",
					icon = 0x868395925CB26A7,
					text = CoD.DemoUtility.GetRoundedLightFloatParam( f172_local51 ),
					hintText = 0x8A89BB505765B35,
					buttonPromptImageModel = DataSources.Controller.Model.dpad_up_button_image,
					disabled = f172_local31 == true,
					showTimescale = f172_local51 > 5,
					action = CoD.DemoUtility.UpdateLightmanRange,
					param = "0.5"
				} )
			else
				table.insert( f172_local0, {
					btnId = "lightmanlightintensity",
					icon = 0x4229B8898CA8E1C,
					text = CoD.DemoUtility.GetRoundedLightFloatParam( f172_local32:get() ),
					hintText = 0x42C6CF278B1F1D9,
					buttonPromptImageModel = DataSources.Controller.Model.dpad_lr_button_image,
					disabled = f172_local31 == true,
					showTimescale = true
				} )
				table.insert( f172_local0, {
					btnId = "lightmanlightrange",
					icon = 0x8FA91637A4E25F4,
					text = CoD.DemoUtility.GetRoundedLightFloatParam( f172_local33:get() ),
					hintText = 0x8A89BB505765B35,
					buttonPromptImageModel = DataSources.Controller.Model.dpad_ud_button_image,
					disabled = f172_local31 == true,
					showTimescale = true
				} )
			end
			table.insert( f172_local0, {
				btnId = "lightmanlightcolor",
				icon = 0x78FD2238CC0C5EE,
				hintText = 0xBA83F8B4DDEC747,
				buttonPromptImageModel = DataSources.Controller.Model.secondary_button_image,
				disabled = f172_local31 == true,
				action = CoD.DemoUtility.UpdateLightmanLightColor
			} )
			table.insert( f172_local0, {
				btnId = "deletelightmanmarker",
				icon = 0x1746039F43DB75C,
				hintText = 0x123840A03175D5F,
				buttonPromptImageModel = DataSources.Controller.Model.primary_button_image,
				disabled = f172_local31 == true,
				action = CoD.DemoUtility.RemoveCurrentLightmanMarker
			} )
			table.insert( f172_local0, {
				btnId = "deletealllightmanmarkers",
				icon = 0x203B98C5FF05760,
				hintText = 0x8C841FB514E5B0F,
				buttonPromptImageModel = DataSources.Controller.Model.primary_button_image,
				buttonPromptStateModel = f172_arg1.menu.buttonModel[Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F]],
				disabled = f172_local31 == true,
				action = CoD.DemoUtility.OpenDemoOverlay,
				param = "DemoDeleteAllLightmanMarkers"
			} )
			if f172_local23 == true then
				table.insert( f172_local0, {
					btnId = "lightmanmoveexit",
					icon = 0xEB22994B30A0082,
					hintText = 0x0,
					buttonPromptImageModel = DataSources.Controller.Model.right_stick_button_image,
					action = CoD.DemoUtility.DemoPlaceLightmanMarker
				} )
			else
				table.insert( f172_local0, {
					btnId = "lightmaneditexit",
					icon = 0xC9C0D644E269514,
					hintText = 0x0,
					buttonPromptImageModel = DataSources.Controller.Model.right_stick_button_image,
					action = CoD.DemoUtility.DemoExitEditLightmanMarker
				} )
			end
		else
			if CoD.isPC and IsMouseOrKeyboard( f172_arg0 ) and not f172_local40 then
				table.insert( f172_local0, {
					btnId = "changeMode",
					icon = 0xD9BE213694843A,
					hintText = 0x66D4735F4198419,
					buttonPromptImageModel = DataSources.Controller.Model.secondary_button_image,
					action = CoD.DemoUtility.OpenChooseModeSidebar,
					spacerWidth = 16
				} )
			end
			if not IsDemoRestrictedBasicMode() then
				table.insert( f172_local0, {
					btnId = "screenshot",
					icon = 0x4A75BA93E5118AB,
					hintText = 0x10358F774E52931,
					buttonPromptImageModel = DataSources.Controller.Model.alt1_button_image,
					buttonPromptStateModel = f172_arg1.menu.buttonModel[Enum[0x3DD78803F918E9D][0xC083113BC81F23F]],
					action = CoD.DemoUtility.TakeScreenshot
				} )
				table.insert( f172_local0, {
					btnId = "record",
					icon = 0xEDEE3F871693E6E,
					hintText = f172_local49(),
					buttonPromptImageModel = DataSources.Controller.Model.alt1_button_image,
					spacerWidth = 10,
					action = CoD.DemoUtility.StartStopRecordClip
				} )
			end
			table.insert( f172_local0, {
				btnId = "jumpback",
				icon = 0xF49153C89A3CA30,
				hintText = 0x3D18552D1136C4D,
				buttonPromptImageModel = DataSources.Controller.Model.dpad_left_button_image,
				disabled = f172_local9:get() == -1,
				action = CoD.DemoUtility.DemoTimeJump,
				param = "back"
			} )
			if IsDemoContextDirectorMode() then
				local f172_local50 = table.insert
				local f172_local51 = f172_local0
				local f172_local52 = {
					btnId = "jumpbackdollycamera",
					icon = 0x72AEB4C18D4662F,
					hintText = 0xB7C6C19EC2F2396,
					buttonPromptImageModel = DataSources.Controller.Model.dpad_down_button_image
				}
				local f172_local53
				if f172_local11:get() - 1 >= 0 and Engine[0x82C36BC3D9A8635]() ~= true then
					f172_local53 = false
				else
					f172_local53 = true
				end
				f172_local52.disabled = f172_local53
				f172_local52.action = CoD.DemoUtility.DemoTimeJumpDollyCameraMarker
				f172_local52.param = "back"
				f172_local50( f172_local51, f172_local52 )
			end
			if not IsDemoContextPlaybackMode() then
				table.insert( f172_local0, {
					btnId = "slowtimescale",
					icon = f172_local43( CoD.DemoUtility.GetRoundedTimeScale() ),
					hintText = 0x22683AE3994BD68,
					buttonPromptImageModel = DataSources.Controller.Model.left_trigger_button_image,
					showTimescale = CoD.DemoUtility.GetRoundedTimeScale() < 1,
					action = CoD.DemoUtility.UpdateDemoTimeScaleDelta,
					param = "-0.2"
				} )
			end
			if f172_local3 == true then
				table.insert( f172_local0, {
					btnId = "play",
					icon = 0xBE1A8D6621CF375,
					hintText = 0xD58F6699EB87467,
					buttonPromptImageModel = DataSources.Controller.Model.primary_button_image,
					action = CoD.DemoUtility.RunPauseCommand
				} )
			else
				table.insert( f172_local0, {
					btnId = "pause",
					icon = 0xC9541EAF27AD77,
					hintText = 0x6A3016015F825DD,
					buttonPromptImageModel = DataSources.Controller.Model.primary_button_image,
					action = CoD.DemoUtility.RunPauseCommand
				} )
			end
			if IsDemoContextDirectorMode() then
				if Engine[0x82C36BC3D9A8635]() then
					table.insert( f172_local0, {
						btnId = "pausedollycamera",
						icon = 0x2A8E2789613E50E,
						hintText = 0xEA9847364C31F46,
						buttonPromptImageModel = DataSources.Controller.Model.primary_button_image,
						buttonPromptStateModel = f172_arg1.menu.buttonModel[Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F]],
						action = CoD.DemoUtility.ToggleDollyCameraMode
					} )
				else
					local f172_local50 = 0xDAFE26EF8CF7BF8
					local f172_local51 = false
					if f172_local13:get() <= 0 then
						f172_local50 = 0x241E0906C51DEFF
						f172_local51 = true
					end
					table.insert( f172_local0, {
						btnId = "playdollycamera",
						icon = 0x414F4BE1E294D4E,
						hintText = f172_local50,
						buttonPromptImageModel = DataSources.Controller.Model.primary_button_image,
						buttonPromptStateModel = f172_arg1.menu.buttonModel[Enum[0x3DD78803F918E9D][0x755DA1E2E7C263F]],
						disabled = f172_local51,
						action = CoD.DemoUtility.ToggleDollyCameraMode
					} )
				end
			end
			if not IsDemoContextPlaybackMode() then
				table.insert( f172_local0, {
					btnId = "fasttimescale",
					icon = f172_local44( CoD.DemoUtility.GetRoundedTimeScale() ),
					hintText = 0x22683AE3994BD68,
					buttonPromptImageModel = DataSources.Controller.Model.right_trigger_button_image,
					disabled = f172_local42,
					showTimescale = CoD.DemoUtility.GetRoundedTimeScale() > 1,
					action = CoD.DemoUtility.UpdateDemoTimeScaleDelta,
					param = "1.0"
				} )
			end
			if IsDemoContextDirectorMode() then
				local f172_local50 = table.insert
				local f172_local51 = f172_local0
				local f172_local52 = {
					btnId = "jumpforwarddollycamera",
					icon = 0xBD020DE9BC680A9,
					hintText = 0x72EC50E30114004,
					buttonPromptImageModel = DataSources.Controller.Model.dpad_up_button_image
				}
				local f172_local53
				if f172_local12:get() ~= -1 and Engine[0x82C36BC3D9A8635]() ~= true then
					f172_local53 = false
				else
					f172_local53 = true
				end
				f172_local52.disabled = f172_local53
				f172_local52.action = CoD.DemoUtility.DemoTimeJumpDollyCameraMarker
				f172_local52.param = "forward"
				f172_local50( f172_local51, f172_local52 )
			end
			local f172_local50 = table.insert
			local f172_local51 = f172_local0
			local f172_local52 = {
				btnId = "jumpforward",
				icon = 0xF17F3E8670657D4,
				hintText = 0x602A86786DE61CB,
				buttonPromptImageModel = DataSources.Controller.Model.dpad_right_button_image
			}
			local f172_local53
			if f172_local10:get() ~= -1 then
				f172_local53 = f172_local42
			else
				f172_local53 = true
			end
			f172_local52.disabled = f172_local53
			f172_local52.action = CoD.DemoUtility.DemoTimeJump
			f172_local52.param = "forward"
			f172_local50( f172_local51, f172_local52 )
			if not IsDemoContextPlaybackMode() then
				if IsDemoContextObjectLinkMode() then
					if IsFreeCameraLockedOnEntity( f172_arg0 ) then
						table.insert( f172_local0, {
							btnId = "objectunlink",
							icon = 0x2F208A3564C581A,
							hintText = 0x0,
							buttonPromptImageModel = DataSources.Controller.Model.right_stick_button_image,
							disabled = false,
							action = CoD.DemoUtility.DemoFreeCameraUnlockObject
						} )
					else
						table.insert( f172_local0, {
							btnId = "objectlink",
							icon = 0x205A060A28CF17B,
							hintText = 0x0,
							buttonPromptImageModel = DataSources.Controller.Model.right_stick_button_image,
							disabled = CanFreeCameraLockOnEntity( f172_arg0 ) == false,
							action = CoD.DemoUtility.DemoFreeCameraLockOnObject
						} )
					end
				elseif IsDemoContextDirectorMode() then
					if Engine[0x3B799DC771E1BC2]( f172_arg0, 0x40A39D4129C3E15 ) then
						if CoD.DemoUtility.ShouldStartAutoDollyCamera( f172_arg0 ) then
							table.insert( f172_local0, {
								btnId = "autodollycamstart",
								icon = 0x7828B8384381EB8,
								hintText = 0x0,
								buttonPromptImageModel = DataSources.Controller.Model.right_stick_button_image,
								action = CoD.DemoUtility.DemoStartAutoDollyCamera
							} )
						elseif CoD.DemoUtility.ShouldStopAutoDollyCamera( f172_arg0 ) then
							table.insert( f172_local0, {
								btnId = "autodollycamstop",
								icon = 0x74DED9A7DC4BD1C,
								hintText = 0x0,
								buttonPromptImageModel = DataSources.Controller.Model.right_stick_button_image,
								action = CoD.DemoUtility.DemoStopAutoDollyCamera
							} )
						elseif ShouldEditDollyCameraMarker( f172_arg0 ) then
							table.insert( f172_local0, {
								btnId = "dollycamedit",
								icon = 0x30999227A02F4E0,
								hintText = 0x0,
								buttonPromptImageModel = DataSources.Controller.Model.right_stick_button_image,
								action = CoD.DemoUtility.DemoEditDollyCameraMarker
							} )
						end
					elseif ShouldAddDollyCameraMarker( f172_arg0 ) then
						table.insert( f172_local0, {
							btnId = "dollycamadd",
							icon = 0x3E599F0D948E2DF,
							hintText = 0x0,
							buttonPromptImageModel = DataSources.Controller.Model.right_stick_button_image,
							action = CoD.DemoUtility.DemoAddDollyCameraMarker
						} )
					elseif ShouldEditDollyCameraMarker( f172_arg0 ) then
						table.insert( f172_local0, {
							btnId = "dollycamedit",
							icon = 0x30999227A02F4E0,
							hintText = 0x0,
							buttonPromptImageModel = DataSources.Controller.Model.right_stick_button_image,
							action = CoD.DemoUtility.DemoEditDollyCameraMarker
						} )
					end
				elseif IsDemoContextLighterMode() then
					if ShouldAddLightmanMarker( f172_arg0 ) then
						table.insert( f172_local0, {
							btnId = "lighteradd",
							icon = 0x15E6D5A56413D9A,
							hintText = 0x0,
							buttonPromptImageModel = DataSources.Controller.Model.right_stick_button_image,
							action = CoD.DemoUtility.DemoAddLightmanMarker
						} )
					elseif ShouldEditLightmanMarker( f172_arg0 ) then
						table.insert( f172_local0, {
							btnId = "lighteredit",
							icon = 0x8E48C5C9B335333,
							hintText = 0x0,
							buttonPromptImageModel = DataSources.Controller.Model.right_stick_button_image,
							action = CoD.DemoUtility.DemoEditLightmanMarker
						} )
					end
				end
				if IsDemoContextBasicOrHighlightReelMode() and not f172_local40 then
					table.insert( f172_local0, {
						btnId = "cameramode",
						icon = 0x5B508D5EB68DD40,
						hintText = 0xEC09E1538A6D569,
						buttonPromptImageModel = DataSources.Controller.Model.alt2_button_image,
						action = CoD.DemoUtility.UpdateDemoCameraMode,
						param = "cycle"
					} )
				end
			end
		end
		for f172_local53, f172_local54 in ipairs( f172_local0 ) do
			local f172_local55 = {
				btnId = f172_local54.btnId,
				spacerWidth = f172_local54.spacerWidth
			}
			local f172_local56 = Engine[0xA798E4552F5E872]( Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "DemoControls" ), "buttonModel_" .. f172_local53 )
			table.insert( f172_arg1.buttons, {
				model = f172_local56,
				properties = f172_local55
			} )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f172_local56, "btnId" ), f172_local54.btnId )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f172_local56, "icon" ), f172_local54.icon )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f172_local56, "text" ), f172_local54.text or "" )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f172_local56, "hintText" ), Engine[0xF9F1239CFD921FE]( f172_local54.hintText ) )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f172_local56, "disabled" ), f172_local54.disabled or false )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f172_local56, "action" ), f172_local54.action )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f172_local56, "param" ), f172_local54.param )
			if f172_local54.buttonPromptImageModel ~= nil then
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f172_local56, "buttonPromptImage" ), f172_local54.buttonPromptImageModel:get() )
			else
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f172_local56, "buttonPromptImage" ), "$white" )
			end
			if f172_local54.buttonPromptStateModel ~= nil then
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f172_local56, "buttonPromptState" ), f172_local54.buttonPromptImageModel )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f172_local56, "showProgressRing" ), true )
			else
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f172_local56, "showProgressRing" ), false )
			end
			if f172_local54.showTimescale ~= nil then
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f172_local56, "showTimescale" ), f172_local54.showTimescale )
			end
		end
		f172_local50 = function ()
			f172_arg1:updateDataSource()
		end
		
		if not f172_arg1.subscribedToModels then
			f172_arg1:subscribeToModel( f172_local2, f172_local50, false )
			f172_arg1:subscribeToModel( f172_local7, f172_local50, false )
			f172_arg1:subscribeToModel( f172_local8, f172_local50, false )
			f172_arg1:subscribeToModel( f172_local9, f172_local50, false )
			f172_arg1:subscribeToModel( f172_local10, f172_local50, false )
			f172_arg1:subscribeToModel( f172_local4, f172_local50, false )
			f172_arg1:subscribeToModel( f172_local5, f172_local50, false )
			f172_arg1:subscribeToModel( f172_local6, f172_local50, false )
			f172_arg1:subscribeToModel( f172_local11, f172_local50, false )
			f172_arg1:subscribeToModel( f172_local12, f172_local50, false )
			f172_arg1:subscribeToModel( f172_local13, f172_local50, false )
			f172_arg1:subscribeToModel( f172_local14, f172_local50, false )
			f172_arg1:subscribeToModel( f172_local15, f172_local50, false )
			f172_arg1:subscribeToModel( f172_local16, f172_local50, false )
			f172_arg1:subscribeToModel( f172_local18, f172_local50, false )
			f172_arg1:subscribeToModel( f172_local20, f172_local50, false )
			f172_arg1:subscribeToModel( f172_local22, f172_local50, false )
			f172_arg1:subscribeToModel( f172_local24, f172_local50, false )
			f172_arg1:subscribeToModel( f172_local25, f172_local50, false )
			f172_arg1:subscribeToModel( f172_local26, f172_local50, false )
			f172_arg1:subscribeToModel( f172_local28, f172_local50, false )
			f172_arg1:subscribeToModel( f172_local32, f172_local50, false )
			f172_arg1:subscribeToModel( f172_local33, f172_local50, false )
			f172_arg1:subscribeToModel( f172_local30, f172_local50, false )
			f172_arg1:subscribeToModel( f172_local34, f172_local50, false )
			f172_arg1:subscribeToModel( f172_local36, f172_local50, false )
			f172_arg1:subscribeToModel( f172_local37, f172_local50, false )
			f172_arg1:subscribeToModel( f172_local38, f172_local50, false )
			if f172_local39 then
				f172_arg1:subscribeToModel( f172_local39, f172_local50, false )
			end
			if f172_local41 then
				f172_arg1:subscribeToModel( f172_local41, f172_local50, false )
			end
			if CoD.isPC then
				f172_local53 = "subscribeToModel"
				f172_local52 = f172_arg1
				f172_local51 = f172_arg1[f172_local53]
				f172_local53 = Engine[0x4DF5CFBC1771947]( f172_arg0 )
				f172_local51( f172_local52, f172_local53.LastInput, f172_local50, false )
			end
			f172_arg1.subscribedToModels = true
		end
	end,
	getCount = function ( f181_arg0 )
		return #f181_arg0.buttons
	end,
	getItem = function ( f182_arg0, f182_arg1, f182_arg2 )
		return f182_arg1.buttons[f182_arg2].model
	end,
	getCustomPropertiesForItem = function ( f183_arg0, f183_arg1 )
		return f183_arg0.buttons[f183_arg1].properties
	end,
	getSpacerAfterColumn = function ( f184_arg0, f184_arg1, f184_arg2 )
		if f184_arg0.buttons[f184_arg1].properties.spacerWidth then
			return f184_arg0.buttons[f184_arg1].properties.spacerWidth
		else
			return 0
		end
	end,
	getWidgetTypeForItem = function ( f185_arg0, f185_arg1, f185_arg2 )
		local f185_local0 = f185_arg0.buttons[f185_arg2].properties.btnId
		if f185_local0 == "slowtimescale" then
			return CoD.DemoControlsButtonTimeScale
		elseif f185_local0 == "fasttimescale" then
			return CoD.DemoControlsButtonTimeScale
		elseif f185_local0 == "record" then
			return CoD.DemoControlsButtonRecord
		elseif f185_local0 == "dollycameratimescale" then
			return CoD.DemoControlsButtonDollyCameraTimeScale
		elseif f185_local0 == "cameramode" then
			return CoD.DemoControlsButtonCameraMode
		elseif f185_local0 == "lightmanlightintensity" or f185_local0 == "lightmanlightrange" or f185_local0 == "lightmanlightintensityminus" or f185_local0 == "lightmanlightintensityplus" or f185_local0 == "lightmanlightrangeminus" or f185_local0 == "lightmanlightrangeplus" then
			return CoD.DemoControlsButtonLightmanParameters
		else
			return CoD.DemoControlsButton
		end
	end
}
DataSources.DemoChooseModeButtonList = ListHelper_SetupDataSource( "DemoChooseModeButtonList", function ( f186_arg0 )
	local f186_local0 = {}
	local f186_local1 = function ( f187_arg0, f187_arg1, f187_arg2, f187_arg3, f187_arg4 )
		local f187_local0 = f187_arg1.btnId
		local f187_local1 = CoD.DemoUtility.GetDemoContextMode()
		local f187_local2 = CoD.DemoUtility.CloseChooseModeSidebar( f187_arg4, f187_arg2 )
		if f187_local1 == Enum[0xAAAF4C9531ECF5E][0x432E29CBD83BEB5] then
			CoD.perController[f187_arg2].prevDemoCameraMode = Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "demo.cameraMode" ) )
		end
		if f187_local0 == "basic" then
			if CoD.perController[f187_arg2].prevDemoCameraMode then
				Engine[0xCCDD5DEE6A7B3CE]( CoD.perController[f187_arg2].prevDemoCameraMode )
			else
				Engine[0xCCDD5DEE6A7B3CE]( Enum[0xF432DF404208022][0x448CED16817146D] )
			end
			Engine[0x18E18660B901CA0]( Enum[0x66BE675172715C][0x57E8B3FC08F3990] )
			CoD.DemoUtility.SetDemoContextMode( Enum[0xAAAF4C9531ECF5E][0x432E29CBD83BEB5] )
		elseif f187_local0 == "director" then
			Engine[0xCCDD5DEE6A7B3CE]( Enum[0xF432DF404208022][0x3B1995A6E46FA28] )
			Engine[0x18E18660B901CA0]( Enum[0x66BE675172715C][0xFA038EBA43002CB] )
			CoD.DemoUtility.SetDemoContextMode( Enum[0xAAAF4C9531ECF5E][0xD6C645A6FE86C79] )
		elseif f187_local0 == "objectlink" then
			Engine[0xCCDD5DEE6A7B3CE]( Enum[0xF432DF404208022][0x3B1995A6E46FA28] )
			Engine[0x18E18660B901CA0]( Enum[0x66BE675172715C][0x849666C4C6079C8] )
			CoD.DemoUtility.SetDemoContextMode( Enum[0xAAAF4C9531ECF5E][0x9F3A6331D6505AB] )
		elseif f187_local0 == "lighter" then
			Engine[0xCCDD5DEE6A7B3CE]( Enum[0xF432DF404208022][0x3B1995A6E46FA28] )
			Engine[0x18E18660B901CA0]( Enum[0x66BE675172715C][0xFCC4AB128D836C3] )
			CoD.DemoUtility.SetDemoContextMode( Enum[0xAAAF4C9531ECF5E][0x6D2AFAEC0E25E5C] )
		elseif f187_local0 == "timeline" then
			CoD.DemoUtility.OpenManageSegments( f187_local2, {
				controller = f187_arg2
			} )
		end
	end
	
	local f186_local2 = {}
	if not IsDemoContextHighlightReelMode() then
		table.insert( f186_local2, {
			btnId = "basic",
			displayText = 0x2130485C18F0F01,
			hintText = 0x16B02B95FDC1B57,
			icon = "theater_play"
		} )
		if not CoD.DemoUtility.IsCameraCyclingDisabled() then
			table.insert( f186_local2, {
				btnId = "director",
				displayText = 0xA92002FAFF0222D,
				hintText = 0x88DDE38B76BFC03,
				icon = "theater_video"
			} )
			table.insert( f186_local2, {
				btnId = "objectlink",
				displayText = 0x89B6C9C8BA8A257,
				hintText = 0xCCC4DB2EEF9E901,
				icon = "theater_link"
			} )
			table.insert( f186_local2, {
				btnId = "lighter",
				displayText = 0x3815E64F7B24A08,
				hintText = 0x408496BB3E531C8,
				icon = "theater_bulb"
			} )
		end
	end
	if not IsDemoRestrictedBasicMode() then
		table.insert( f186_local2, {
			btnId = "timeline",
			displayText = 0x220393E7394569A,
			hintText = 0xDCD7140AF745D6E,
			icon = "theater_timeline"
		} )
	end
	for f186_local6, f186_local7 in ipairs( f186_local2 ) do
		table.insert( f186_local0, {
			models = {
				displayText = Engine[0xF9F1239CFD921FE]( f186_local7.displayText ),
				hintText = Engine[0xF9F1239CFD921FE]( f186_local7.hintText ),
				icon = f186_local7.icon,
				action = f186_local1,
				locked = f186_local7.locked or false
			},
			properties = {
				btnId = f186_local7.btnId
			}
		} )
	end
	return f186_local0
end )
DataSources.DemoFilmOptionsButtonList = ListHelper_SetupDataSource( "DemoFilmOptionsButtonList", function ( f188_arg0 )
	local f188_local0 = {}
	local f188_local1 = {}
	local f188_local2 = CoD.DemoUtility.Timeline_GetHighlightedSegmentModel()
	local f188_local3 = function ( f189_arg0, f189_arg1, f189_arg2, f189_arg3, f189_arg4 )
		local f189_local0 = f189_arg1.btnId
		local f189_local1, f189_local2 = nil
		if f188_local2 then
			f189_local2 = Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f188_local2, "segmentNumber" ) ) - 1
		end
		if f189_local0 == "preview" then
			Engine[0x7C75E608EA39B5C]( f189_arg2, "demo_previewsegment " .. f189_local2 )
			GoBack( f189_arg0.occludedMenu, f189_arg2 )
		elseif f189_local0 == "delete" then
			CoD.OverlayUtility.CreateOverlay( f189_arg2, f189_arg0, "DemoDeleteSegment" )
		elseif f189_local0 == "rename" then
			CoD.DemoUtility.OpenDemoKeyboard( f189_arg0, f189_arg1, f189_arg2, "segmentName", f189_local2 )
		elseif f189_local0 == "saveclip" then
			CoD.DemoUtility.StartMenuUploadClip( f189_arg0, f189_arg1, f189_arg2, f189_arg3, f189_arg4 )
		elseif f189_local0 == "mergeall" then
			CoD.OverlayUtility.CreateOverlay( f189_arg2, f189_arg0, "DemoMergeAllSegments" )
		elseif f189_local0 == "deleteall" then
			CoD.OverlayUtility.CreateOverlay( f189_arg2, f189_arg0, "DemoDeleteAllSegments" )
		end
	end
	
	if f188_local2 ~= nil and Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f188_local2, "disabled" ) ) == false then
		table.insert( f188_local1, {
			btnId = "preview",
			displayText = 0x5FFB101883954E3,
			hintText = 0x594890CBCE4C18D,
			icon = "theater_view"
		} )
		table.insert( f188_local1, {
			btnId = "delete",
			displayText = 0x29CBBF38B0CE85,
			hintText = 0x7BC395E2D24568B,
			icon = "theater_delete"
		} )
		table.insert( f188_local1, {
			btnId = "rename",
			displayText = 0x38707720D700672,
			hintText = 0x5B377C6451C1C36,
			icon = "theater_rename",
			spacerHeight = 16
		} )
	end
	table.insert( f188_local1, {
		btnId = "saveclip",
		displayText = 0x1A66DD5B77CEF0D,
		hintText = 0xFE7D3B3C0ABF0A3,
		icon = "theater_save"
	} )
	if Engine[0x79618C46565F5A4]() > 1 then
		table.insert( f188_local1, {
			btnId = "mergeall",
			displayText = 0xE8110C70E0A4C2B,
			hintText = 0x2F29234440BB185,
			icon = "theater_merge"
		} )
	end
	table.insert( f188_local1, {
		btnId = "deleteall",
		displayText = 0xA442ED9FD41A966,
		hintText = 0x8161A1B264BD53A,
		icon = "theater_delete_all"
	} )
	for f188_local7, f188_local8 in ipairs( f188_local1 ) do
		table.insert( f188_local0, {
			models = {
				displayText = Engine[0xF9F1239CFD921FE]( f188_local8.displayText ),
				hintText = Engine[0xF9F1239CFD921FE]( f188_local8.hintText ),
				icon = f188_local8.icon,
				action = f188_local3
			},
			properties = {
				btnId = f188_local8.btnId,
				spacerHeight = f188_local8.spacerHeight
			}
		} )
	end
	return f188_local0
end, nil, nil, nil, function ( f190_arg0, f190_arg1, f190_arg2 )
	local f190_local0 = f190_arg0.DemoFilmOptionsButtonList[f190_arg1].properties.spacerHeight
	if f190_local0 then
		return f190_local0
	else
		return f190_arg0.spacing
	end
end )
DataSources.DemoSegments = {
	prepare = function ( f191_arg0, f191_arg1, f191_arg2 )
		f191_arg1.segments = {}
		local f191_local0 = 20
		local f191_local1 = Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "DemoSegments.refresh" )
		for f191_local2 = 1, f191_local0, 1 do
			table.insert( f191_arg1.segments, {
				model = CoD.DemoUtility.SetupDemoSegmentModel( f191_local2 - 1 )
			} )
		end
	end,
	getCount = function ( f192_arg0 )
		return #f192_arg0.segments
	end,
	getItem = function ( f193_arg0, f193_arg1, f193_arg2 )
		return f193_arg1.segments[f193_arg2].model
	end,
	getCustomPropertiesForItem = function ( f194_arg0, f194_arg1 )
		return f194_arg0.segments[f194_arg1]
	end
}
DataSources.DemoHighlightReelSettingsButtonList = ListHelper_SetupDataSource( "DemoHighlightReelSettingsButtonList", function ( f195_arg0 )
	local f195_local0 = {}
	local f195_local1 = Engine[0x3EAC408F958FF05]() == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A]
	local f195_local2 = function ( f196_arg0, f196_arg1, f196_arg2, f196_arg3 )
		CoD.DemoUtility.RebuildHighlightReelTimeline( f196_arg1 )
	end
	
	local f195_local3 = {}
	table.insert( f195_local3, {
		name = 0x119205E2C0A080A,
		value = Enum[0x807BB39CE2869B1][0x518F5AD837A5C5B]
	} )
	table.insert( f195_local3, {
		name = 0x59876AF69411576,
		value = Enum[0x807BB39CE2869B1][0x97A2C2D28A3E9CF]
	} )
	table.insert( f195_local3, {
		name = 0x7C0C34E60B91DFB,
		value = Enum[0x807BB39CE2869B1][0x40F7FE603F4C36C]
	} )
	table.insert( f195_local3, {
		name = 0xB9859B2937B216E,
		value = Enum[0x807BB39CE2869B1][0x29E7F847D76F12E]
	} )
	table.insert( f195_local3, {
		name = 0xCC98269FD3ECAC1,
		value = Enum[0x807BB39CE2869B1][0x9E9FE02560E4181]
	} )
	table.insert( f195_local3, {
		name = 0x2FA566B15738C2C,
		value = Enum[0x807BB39CE2869B1][0xC12E4D115E87D53]
	} )
	local f195_local4 = {}
	table.insert( f195_local4, {
		name = 0x585D6B8777361CF,
		value = Enum[0x7FD132DE664DDA2][0x855C08F30F5B7F5]
	} )
	if f195_local1 then
		table.insert( f195_local4, {
			name = 0xA55380E6DB02240,
			value = Enum[0x7FD132DE664DDA2][0x5B4B56A0AE45D76]
		} )
		table.insert( f195_local4, {
			name = 0x7A4A378AFF8A0AD,
			value = Enum[0x7FD132DE664DDA2][0xF15F01593CD8FC7]
		} )
		table.insert( f195_local4, {
			name = 0x1E8BD1FC273F5AE,
			value = Enum[0x7FD132DE664DDA2][0xD673595A58AAC0C]
		} )
		table.insert( f195_local4, {
			name = 0xBED05907094C433,
			value = Enum[0x7FD132DE664DDA2][0xFCF8230D5434DF1]
		} )
		table.insert( f195_local4, {
			name = 0x1A242272D58A3AB,
			value = Enum[0x7FD132DE664DDA2][0xB5232A6298EF22D]
		} )
	else
		table.insert( f195_local4, {
			name = 0x240607484142C6E,
			value = Enum[0x7FD132DE664DDA2][0x1F8C2C0ED40E0C2]
		} )
		table.insert( f195_local4, {
			name = 0x676CDC2A4001E5D,
			value = Enum[0x7FD132DE664DDA2][0x990E193029FBF59]
		} )
		table.insert( f195_local4, {
			name = 0xEDC1F6E5FFF52C8,
			value = Enum[0x7FD132DE664DDA2][0xDAF25539D1336BE]
		} )
		table.insert( f195_local4, {
			name = 0xE66F8F3FDE2DA5A,
			value = Enum[0x7FD132DE664DDA2][0x9783E19121C6A2B]
		} )
	end
	local f195_local5 = {}
	table.insert( f195_local5, {
		name = "5",
		value = 5
	} )
	table.insert( f195_local5, {
		name = "10",
		value = 10
	} )
	table.insert( f195_local5, {
		name = "20",
		value = 20
	} )
	local f195_local6 = {}
	table.insert( f195_local6, {
		name = 0xE8EA9A816217BFD,
		value = 1
	} )
	table.insert( f195_local6, {
		name = 0x5F9F2A898833997,
		value = 2
	} )
	table.insert( f195_local6, {
		name = 0x67982D823EC480D,
		value = 3
	} )
	table.insert( f195_local6, {
		name = 0x4DFF8E5C94ADC0B,
		value = 4
	} )
	table.insert( f195_local6, {
		name = 0x2A9A7E5BEB9FECF,
		value = 5
	} )
	local f195_local7 = {}
	table.insert( f195_local7, {
		name = 0x779F68ADAFA62B9,
		value = Enum[0xCDBC91D14ED7E67][0x85476BB87B4E2BE]
	} )
	table.insert( f195_local7, {
		name = 0x2EA061BF5AD8DD5,
		value = Enum[0xCDBC91D14ED7E67][0x886B501DFC2699A]
	} )
	table.insert( f195_local7, {
		name = 0xA0C72A43293DDE0,
		value = Enum[0xCDBC91D14ED7E67][0x7FF458C9DED0BB3]
	} )
	local f195_local8 = {
		{
			name = "PlayerFilter",
			displayText = 0xA5A2F2B49E3A85C,
			hintText = 0xF30DD5DE314B7A4,
			dvarName = "demo_highlightReelPlayerFilter",
			options = f195_local3
		},
		{
			name = "StylesFilter",
			displayText = 0x7188671D544C852,
			hintText = 0xF6BB65B3B9C5082,
			dvarName = "demo_highlightReelStylesFilter",
			options = f195_local4
		},
		{
			name = "NumberOfSegmentsFilter",
			displayText = 0x7CDCF7F83A1A77B,
			hintText = 0x877D920E8BF786D,
			dvarName = "demo_highlightReelNumberOfSegments",
			options = f195_local5
		},
		{
			name = "StarsFilter",
			displayText = 0x609B36D23311B0A,
			hintText = 0x57A95F7E07B00BA,
			dvarName = "demo_highlightReelMinimumStarsFilter",
			options = f195_local6
		},
		{
			name = "TransitionFilter",
			displayText = 0x7BB8BE89004ECE,
			hintText = 0xE153A73DD9987E,
			dvarName = "demo_highlightReelTransitionFilter",
			options = f195_local7
		}
	}
	if f195_local1 == false then
		local f195_local9 = {}
		table.insert( f195_local9, {
			name = 0x5C16E02B211A4F4,
			value = Enum[0x867645ED00F380F][0x4C83F1397F960C8]
		} )
		table.insert( f195_local9, {
			name = 0x3111505861D2052,
			value = Enum[0x867645ED00F380F][0xFD0BD9870A17B13]
		} )
		table.insert( f195_local9, {
			name = 0x66DFFF51A90A7D2,
			value = Enum[0x867645ED00F380F][0x94BFBCFF81344BD]
		} )
		table.insert( f195_local9, {
			name = 0x90752610A96D2F5,
			value = Enum[0x867645ED00F380F][0x29383D95BEA097B]
		} )
		table.insert( f195_local8, {
			name = "GameResultFilter",
			displayText = 0xC6314219984FA23,
			hintText = 0x4F4F626F6530BF5,
			dvarName = "demo_highlightReelGameResultFilter",
			options = f195_local9
		} )
	end
	for f195_local12, f195_local13 in ipairs( f195_local8 ) do
		table.insert( f195_local0, {
			models = {
				displayText = f195_local13.displayText,
				hintText = f195_local13.hintText,
				buttonOnly = false,
				disabled = false,
				optionsDatasource = CoD.OptionsUtility.CreateCustomOptionDataSource( f195_arg0, "DemoHighlightReelSettingsButtonList_" .. f195_local13.name, f195_local13.options, f195_local13.dvarName, f195_local2, CoD.DemoUtility.Options_ItemSelected, CoD.DemoUtility.Options_RevertItemSelected ),
				currentSelection = CoD.DemoUtility.Options_GetProfileSelection( f195_arg0, f195_local13.options, f195_local13.dvarName ),
				selected = false
			},
			properties = {
				hideArrows = false,
				disabled = false
			}
		} )
	end
	return f195_local0
end )
local f0_local0 = function ( f197_arg0, f197_arg1 )
	local f197_local0 = f197_arg0:create( "weapon" )
	f197_local0:set( 0 )
	f197_local0 = f197_arg0:create( "dwGrappleWeapon" )
	f197_local0:set( 0 )
	if not f197_arg0.weaponReloadState then
		f197_arg0:create( "weaponReloadState" )
	end
end
DataSourceHelpers.PerControllerDataSourceSetup( "HeldWeapons", "heldWeapons", f0_local0, false )
DataSourceHelpers.PerControllerDataSourceSetup( "CurrentWeapon", "heldWeapons.0", f0_local0, false )
DataSourceHelpers.PerControllerDataSourceSetup( "StowedWeapon", "heldWeapons.1", f0_local0, false )
DataSourceHelpers.PerControllerDataSourceSetup( "StowedWeapon2", "heldWeapons.2", f0_local0, false )
DataSourceHelpers.PerControllerDataSourceSetup( "LethalOffhands", "lethalOffhands", nil, false )
DataSourceHelpers.PerControllerDataSourceSetup( "CurrentPrimaryOffhand", "lethalOffhands.0", nil, false )
DataSourceHelpers.PerControllerDataSourceSetup( "CurrentSecondaryOffhand", "currentSecondaryOffhand", nil, false )
DataSourceHelpers.PerControllerDataSourceSetup( "CurrentSpecialOffhand", "currentSpecialOffhand", nil, false )
DataSourceHelpers.PerControllerDataSourceSetup( "SecondaryOffhandGadget", "playerAbilities.playerGadget1", nil, false )
DataSourceHelpers.PerControllerDataSourceSetup( "SpecialOffhandGadget", "playerAbilities.playerGadget2", nil, false )
DataSourceHelpers.PerControllerDataSourceSetup( "HeroWeapon", "playerAbilities.playerGadget3", nil, false )
DataSourceHelpers.PerControllerDataSourceSetup( "HUDItems", "hudItems", function ( f198_arg0, f198_arg1 )
	f198_arg0:create( "proneBlocked" )
	f198_arg0:create( "hackedRebootProgress" )
	local f198_local0 = f198_arg0:create( "heldObjectiveId" )
	f198_local0:set( -1 )
	f198_arg0:create( "localHealActive" )
	f198_arg0:create( "hotStreak.level" )
	f198_arg0:create( "goldenBullet" )
	f198_arg0:create( "pickupHintWeaponIndex" )
	f198_local0 = f198_arg0:create( "streamerLoadFraction" )
	f198_local0:set( f198_arg0.streamerLoadFraction:get() or 0 )
	f198_local0 = f198_arg0:create( "wzLoadFinished" )
	f198_local0:set( f198_arg0.wzLoadFinished:get() or 0 )
	f198_local0 = f198_arg0:create( "bleedingOverTime" )
	f198_local0:set( f198_arg0.bleedingOverTime:get() or 0 )
	f198_arg0:create( "safeAreaUpdated" )
	if not f198_arg0.medicCleanseCount then
		f198_local0 = f198_arg0:create( "medicCleanseCount" )
		f198_local0:set( 0 )
	end
	f198_local0 = f198_arg0:create( "subtitles" )
	for f198_local1 = 0, CoD.SubtitleUtility.NumLines - 1, 1 do
		local f198_local4 = f198_local0:create( "line" .. f198_local1 )
		local f198_local5 = f198_local4:create( "text" )
		f198_local5:set( "" )
		f198_local5 = f198_local4:create( "duration" )
		f198_local5:set( 0 )
	end
	local f198_local1 = f198_local0:create( "currentIndex" )
	f198_local1:set( 0 )
	f198_arg0:create( "hacked" )
	f198_arg0:create( "jammedStrength" )
end, false )
DataSourceHelpers.PerControllerDataSourceSetup( "InGameNotifications", "inGameNotifications", nil, false )
DataSourceHelpers.PerControllerDataSourceSetup( "KillstreakReward", "killstreakRewards", nil, false )
DataSourceHelpers.PerControllerDataSourceSetup( "PlayerCallout", "playerCallout", nil, false )
DataSourceHelpers.PerControllerDataSourceSetup( "AbilityCallout", "abilityCallout", nil, false )
DataSourceHelpers.PerControllerDataSourceSetup( "PlayerObituary", "playerObituary", nil, false )
DataSourceHelpers.PerControllerDataSourceSetup( "PlayerAbilities", "playerAbilities", nil, false )
DataSourceHelpers.PerControllerDataSourceSetup( "Perks", "perks", nil, false )
DataSourceHelpers.PerControllerDataSourceSetup( "Specialties", "specialties", nil, false )
DataSourceHelpers.PerControllerDataSourceSetup( "CTF", "CTF", function ( f199_arg0, f199_arg1 )
	f199_arg0:create( "friendlyFlagCarrier" )
	f199_arg0:create( "enemyFlagCarrier" )
end, false )
DataSourceHelpers.PerControllerDataSourceSetup( "Ball", "ballGametype", nil, false )
DataSourceHelpers.PerControllerDataSourceSetup( "Escort", "escortGametype", nil, false )
DataSources.NetStats = {
	getModel = function ( f200_arg0 )
		return Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "netstats" )
	end
}
DataSources.Groups = {
	getModel = function ( f201_arg0 )
		if not f201_arg0 then
			f201_arg0 = Engine[0xA5B9C0111291A8B]()
		end
		return Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f201_arg0 ), "groups" )
	end
}
DataSources.GroupsMainTabList = ListHelper_SetupDataSource( "GroupsMainTabModel", function ( f202_arg0 )
	local f202_local0 = {}
	table.insert( f202_local0, {
		models = {
			tabIcon = CoD.buttonStrings.shoulderl
		},
		properties = {
			m_mouseDisabled = true
		}
	} )
	table.insert( f202_local0, {
		models = {
			tabName = Engine[0xF9F1239CFD921FE]( 0xA751297B3A09FA7 ),
			tabWidget = "CoD.MyGroupsTab"
		},
		properties = {
			tabId = "mygroups"
		}
	} )
	table.insert( f202_local0, {
		models = {
			tabName = Engine[0xF9F1239CFD921FE]( 0x442807A62F1FB7A ),
			tabWidget = "CoD.FindGroupsTab"
		},
		properties = {
			tabId = "findgroups"
		}
	} )
	table.insert( f202_local0, {
		models = {
			tabIcon = CoD.buttonStrings.shoulderr
		},
		properties = {
			m_mouseDisabled = true
		}
	} )
	return f202_local0
end, true )
DataSources.GroupsEmblemTabList = ListHelper_SetupDataSource( "GroupsEmblemTabModel", function ( f203_arg0 )
	local f203_local0 = {}
	table.insert( f203_local0, {
		models = {
			tabIcon = CoD.buttonStrings.shoulderl
		},
		properties = {
			m_mouseDisabled = true
		}
	} )
	table.insert( f203_local0, {
		models = {
			tabName = Engine[0xF9F1239CFD921FE]( 0x319A6E3D5B95C87 ),
			tabWidget = "CoD.GroupEmblemsTab"
		},
		properties = {
			tabId = "groupemblems"
		}
	} )
	table.insert( f203_local0, {
		models = {
			tabName = Engine[0xF9F1239CFD921FE]( 0x9B1D22AA3C44258 ),
			tabWidget = "CoD.GroupMyEmblemsTab"
		},
		properties = {
			tabId = "groupmyemblems"
		}
	} )
	table.insert( f203_local0, {
		models = {
			tabIcon = CoD.buttonStrings.shoulderr
		},
		properties = {
			m_mouseDisabled = true
		}
	} )
	return f203_local0
end, true )
DataSources.GroupsInvitesList = {
	prepare = function ( f204_arg0, f204_arg1, f204_arg2 )
		local f204_local0 = Engine[0x4231C16EAAD044C]( f204_arg0 )
		local f204_local1 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f204_arg0 ), "groups" )
		local f204_local2 = Engine[0xA798E4552F5E872]( f204_local1, "eventUpdate" )
		local f204_local3 = Engine[0xA798E4552F5E872]( f204_local1, "invites" )
		f204_arg1.inviteModels = {}
		if f204_arg1.refreshSubscription then
			f204_arg1:removeSubscription( f204_arg1.refreshSubscription )
		end
		f204_arg1.refreshSubscription = f204_arg1:subscribeToModel( f204_local2, function ()
			if Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( Engine[0x4DF5CFBC1771947]( f204_arg0 ), "groups.eventName" ) ) == "refreshInvites" then
				f204_arg1:updateDataSource()
			end
		end, false )
		for f204_local10, f204_local11 in ipairs( f204_local0 ) do
			local f204_local12 = Engine[0xA798E4552F5E872]( f204_local3, "invite_" .. f204_local10 )
			table.insert( f204_arg1.inviteModels, f204_local12 )
			for f204_local7, f204_local8 in pairs( f204_local11 ) do
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f204_local12, f204_local7 ), f204_local8 )
			end
		end
	end,
	getCount = function ( f206_arg0 )
		return #f206_arg0.inviteModels
	end,
	getItem = function ( f207_arg0, f207_arg1, f207_arg2 )
		return f207_arg1.inviteModels[f207_arg2]
	end
}
DataSources.GroupsMemberDetailsButtons = ListHelper_SetupDataSource( "GroupsMemberDetailsButtons", function ( f208_arg0 )
	local f208_local0 = {}
	local f208_local1 = Engine[0x4DF5CFBC1771947]( f208_arg0 )
	local f208_local2 = Engine[0x614D394F6F9A18D]( Engine[0xA798E4552F5E872]( f208_local1, "Social.selectedFriendXUID" ) )
	local f208_local3 = Engine[0x614D394F6F9A18D]( Engine[0xA798E4552F5E872]( f208_local1, "Social.selectedFriendGamertag" ) )
	local f208_local4 = f208_local2 == Engine[0x93B19E01B1FD1C7]( f208_arg0 )
	local f208_local5 = Engine[0x614D394F6F9A18D]( Engine[0xA798E4552F5E872]( f208_local1, "Social.selectedFriendInTitle" ) )
	if f208_local2 == nil then
		return f208_local0
	end
	local f208_local6 = false
	local f208_local7 = Engine[0xDC3B811A6]( f208_arg0, f208_local2 )
	if f208_local4 ~= false then
		
	else
		
	end
	local f208_local8 = Engine[0x86E64DD1C270046]( Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0xA1647599284110], f208_local2 )
	local f208_local9 = Engine[0x86E64DD1C270046]( Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43], f208_local2 )
	local f208_local10 = Engine[0xC6A35140B35CF47]( f208_arg0, Enum[0xBF54BE1BB3D618B][0xA1647599284110], f208_local2 )
	table.insert( f208_local0, {
		text = 0x3F235AEEBA38F96,
		id = "combatRecord",
		disabled = false,
		action = PromoteToLeader,
		params = {
			controller = f208_arg0,
			xuid = f208_local2
		},
		lastInGroup = false
	} )
	table.insert( f208_local0, {
		text = 0x34C68CFCC7F9EF7,
		id = "platformProfile",
		disabled = false,
		action = OpenPlatformProfile,
		params = {
			controller = f208_arg0,
			gamertag = f208_local3,
			xuid = f208_local2
		},
		lastInGroup = true
	} )
	if not Engine[0x3176B986956D1B3]( f208_arg0, f208_local2 ) then
		table.insert( f208_local0, {
			text = 0x2D0220686D5B099,
			id = "sendFriendRequest",
			disabled = false,
			action = OpenPlatformProfile,
			params = {
				controller = f208_arg0,
				gamertag = f208_local3,
				xuid = f208_local2
			},
			lastInGroup = true
		} )
	end
	table.insert( f208_local0, {
		text = 0x264FD33E725F4BC,
		id = "reportPlayer",
		disabled = false,
		action = nil,
		params = nil,
		lastInGroup = false
	} )
	if f208_local8 or f208_local9 then
		if f208_local10 then
			table.insert( f208_local0, {
				text = 0xC56E10272191AAC,
				id = "unmutePlayer",
				disabled = false,
				action = UnMutePlayer,
				params = {
					controller = f208_arg0,
					xuid = f208_local2
				},
				lastInGroup = true
			} )
		else
			table.insert( f208_local0, {
				text = 0x16BFC45CADF9567,
				id = "mutePlayer",
				disabled = false,
				action = MutePlayer,
				params = {
					controller = f208_arg0,
					xuid = f208_local2
				},
				lastInGroup = true
			} )
		end
	end
	f208_local8 = {}
	for f208_local12, f208_local13 in ipairs( f208_local0 ) do
		table.insert( f208_local8, {
			models = {
				displayText = Engine[0xF9F1239CFD921FE]( f208_local13.text ),
				customId = f208_local13.customId
			},
			properties = {
				disabled = f208_local13.disabled,
				action = f208_local13.action,
				actionParam = f208_local13.params,
				isLastButtonInGroup = f208_local13.lastInGroup
			}
		} )
	end
	return f208_local8
end, nil, nil, function ( f209_arg0, f209_arg1, f209_arg2 )
	
end, function ( f210_arg0, f210_arg1, f210_arg2 )
	if f210_arg0.GroupsMemberDetailsButtons[f210_arg1].properties.isLastButtonInGroup then
		return 9
	else
		
	end
end )
DataSources.GroupsShowcaseButtons = ListHelper_SetupDataSource( "GroupsShowcaseButtons", function ( f211_arg0 )
	local f211_local0 = {}
	table.insert( f211_local0, {
		text = 0x984C3C46DADAA7B,
		displayImage = "t7_mp_icon_group_action_favorite",
		hintText = 0x2EF935E2DD3C9BA,
		id = "favorites",
		tabWidget = "CoD.FileshareCategoryContentList",
		disabled = false,
		action = nil,
		params = {
			controller = f211_arg0
		},
		lastInGroup = false
	} )
	table.insert( f211_local0, {
		text = 0x3C3BC29534539D,
		displayImage = "uie_t7_icon_menu_simple_media_recent",
		hintText = 0x6CFFBB0564F9E87,
		id = "recent",
		tabWidget = "CoD.FileshareCategoryContentList",
		disabled = false,
		action = nil,
		params = {
			controller = f211_arg0
		},
		lastInGroup = true
	} )
	table.insert( f211_local0, {
		text = 0x4C36E7D6C85B39F,
		displayImage = "uie_t7_mp_icon_header_paintshop",
		hintText = 0x55080F3675C136A,
		id = "paintjob",
		tabWidget = "CoD.FileshareCategoryContentList",
		disabled = false,
		action = nil,
		params = {
			controller = f211_arg0
		},
		lastInGroup = false
	} )
	table.insert( f211_local0, {
		text = 0x19BBA66C65BA511,
		displayImage = "uie_t7_mp_icon_header_emblem",
		hintText = 0xFFBC446FFA6FD8B,
		id = "emblem",
		tabWidget = "CoD.FileshareCategoryContentList",
		disabled = false,
		action = nil,
		params = {
			controller = f211_arg0
		},
		lastInGroup = false
	} )
	table.insert( f211_local0, {
		text = 0x7C109083D5EFF73,
		displayImage = "uie_t7_mp_icon_header_screenshot",
		hintText = 0xA91D22F65B9D745,
		id = "screenshot",
		tabWidget = "CoD.FileshareScreenshotsContentList",
		disabled = false,
		action = nil,
		params = {
			controller = f211_arg0
		},
		lastInGroup = false
	} )
	table.insert( f211_local0, {
		text = 0x1276C54A7FBE679,
		displayImage = "t7_icon_menu_simple_clips",
		hintText = 0x437321E6A4E7033,
		id = "clip",
		tabWidget = "CoD.FileshareCategoryContentList",
		disabled = false,
		action = nil,
		params = {
			controller = f211_arg0
		},
		lastInGroup = false
	} )
	table.insert( f211_local0, {
		text = 0x1BE757701ED026D,
		displayImage = "uie_t7_mp_icon_header_customgames",
		hintText = 0x83220FC71548C1C,
		id = "customgame",
		tabWidget = "CoD.FileshareCategoryContentList",
		disabled = false,
		action = nil,
		params = {
			controller = f211_arg0
		},
		lastInGroup = true
	} )
	local f211_local1 = {}
	for f211_local5, f211_local6 in ipairs( f211_local0 ) do
		table.insert( f211_local1, {
			models = {
				displayText = Engine[0xF9F1239CFD921FE]( f211_local6.text ),
				displayImage = f211_local6.displayImage,
				hintText = f211_local6.hintText,
				customId = f211_local6.customId,
				category = f211_local6.id,
				tabWidget = f211_local6.tabWidget
			},
			properties = {
				disabled = f211_local6.disabled,
				action = f211_local6.action,
				actionParam = f211_local6.params,
				isLastButtonInGroup = f211_local6.lastInGroup
			}
		} )
	end
	return f211_local1
end, nil, nil, function ( f212_arg0, f212_arg1, f212_arg2 )
	
end, function ( f213_arg0, f213_arg1, f213_arg2 )
	if f213_arg0.GroupsShowcaseButtons[f213_arg1].properties.isLastButtonInGroup then
		return 9
	else
		
	end
end )
DataSources.GroupsInviteButtonList = {
	prepare = function ( f214_arg0, f214_arg1, f214_arg2 )
		f214_arg1.buttons = {}
		local f214_local0 = {}
		f214_arg1.groups = Engine[0xC5AD04FDF32924A]( f214_arg0, Enum[0x5E0DA0F6EB19636][0xE2856B6DCC15907], Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( Engine[0x4DF5CFBC1771947]( f214_arg0 ), "Social.selectedFriendXUID" ) ) )
		for f214_local1 = 1, #f214_arg1.groups, 1 do
			local f214_local4 = f214_arg1.groups[f214_local1]
			table.insert( f214_local0, {
				displayText = f214_local4.name,
				action = InviteToGroup,
				btnType = "group",
				disabled = true,
				groupId = f214_local4.groupId,
				groupBufferType = f214_local4.bufferType,
				name = f214_local4.name,
				clanTag = f214_local4.clanTag,
				description = f214_local4.description,
				message = f214_local4.message,
				privacy = f214_local4.privacy,
				creationTimestamp = f214_local4.creationTimestamp,
				owner = f214_local4.owner,
				ownerXuid = f214_local4.ownerXuid,
				memberStatus = f214_local4.memberStatus,
				memberStatusText = f214_local4.memberStatusText,
				memberCount = f214_local4.memberCount,
				onlineCount = f214_local4.onlineCount,
				inTitleCount = f214_local4.inTitleCount,
				lbIndex = f214_local4.lbIndex,
				lbSortColumn = f214_local4.lbSortColumn,
				lbTimeFrame = f214_local4.lbTimeFrame,
				lbHardcore = f214_local4.lbHardcore,
				lbInitialized = f214_local4.lbInitialized
			} )
		end
		local f214_local3 = Engine[0xA798E4552F5E872]( Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f214_arg0 ), "groups" ), "mainButtons" )
		for f214_local8, f214_local9 in ipairs( f214_local0 ) do
			local f214_local10 = Engine[0xA798E4552F5E872]( f214_local3, "buttonModel_" .. f214_local8 )
			table.insert( f214_arg1.buttons, {
				model = f214_local10,
				type = f214_local9.btnType,
				groupId = f214_local9.groupId,
				groupBufferType = f214_local9.groupBufferType
			} )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f214_local10, "displayText" ), Engine[0xED84C33EC5F01EA]( f214_local9.displayText ) )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f214_local10, "action" ), f214_local9.action )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f214_local10, "type" ), f214_local9.btnType )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f214_local10, "groupId" ), f214_local9.groupId )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f214_local10, "groupBufferType" ), f214_local9.groupBufferType )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f214_local10, "name" ), f214_local9.name )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f214_local10, "clanTag" ), f214_local9.clanTag )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f214_local10, "description" ), f214_local9.description )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f214_local10, "message" ), f214_local9.message )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f214_local10, "privacy" ), f214_local9.privacy )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f214_local10, "creationTimestamp" ), f214_local9.creationTimestamp )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f214_local10, "owner" ), f214_local9.owner )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f214_local10, "ownerXuid" ), f214_local9.ownerXuid )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f214_local10, "memberStatus" ), f214_local9.memberStatus )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f214_local10, "memberStatusText" ), f214_local9.memberStatusText )
			local f214_local11 = Engine[0x40E824FE270E174]( Engine[0x4DF5CFBC1771947]( f214_arg0 ), "Social.selectedFriendXUID" )
			local f214_local7 = false
			if f214_local11 then
				f214_local7 = Engine[0x2F62696CFFD0ACB]( f214_arg0, f214_local9.groupId, Engine[0x614D394F6F9A18D]( f214_local11 ) )
			end
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f214_local10, "inviteSent" ), f214_local7 )
			f214_local9.inviteSent = f214_local7
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f214_local10, "memberCount" ), f214_local9.memberCount )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f214_local10, "onlineCount" ), f214_local9.onlineCount )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f214_local10, "inTitleCount" ), f214_local9.inTitleCount )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f214_local10, "lbIndex" ), f214_local9.lbIndex )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f214_local10, "lbSortColumn" ), f214_local9.lbSortColumn )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f214_local10, "lbTimeFrame" ), f214_local9.lbTimeFrame )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f214_local10, "lbHardcore" ), f214_local9.lbHardcore )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f214_local10, "lbInitialized" ), f214_local9.lbInitialized )
		end
		f214_arg1:subscribeToModel( Engine[0x40E824FE270E174]( Engine[0x4DF5CFBC1771947]( f214_arg0 ), "groups.eventUpdate" ), function ()
			if Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( Engine[0x4DF5CFBC1771947]( f214_arg0 ), "groups.eventName" ) ) == "refreshOutgoingInvites" then
				f214_arg1:updateDataSource()
			end
		end, false )
	end,
	getCustomPropertiesForItem = function ( f216_arg0, f216_arg1 )
		return f216_arg0.buttons[f216_arg1]
	end,
	getCount = function ( f217_arg0 )
		return #f217_arg0.buttons
	end,
	getItem = function ( f218_arg0, f218_arg1, f218_arg2 )
		return f218_arg1.buttons[f218_arg2].model
	end
}
DataSources.GroupsMainButtonList = {
	prepare = function ( f219_arg0, f219_arg1, f219_arg2 )
		f219_arg1.buttons = {}
		local f219_local0 = {}
		f219_arg1.groups = Engine[0xC5AD04FDF32924A]( f219_arg0, Enum[0x5E0DA0F6EB19636][0xE2856B6DCC15907] )
		for f219_local1 = 1, #f219_arg1.groups, 1 do
			local f219_local4 = f219_arg1.groups[f219_local1]
			table.insert( f219_local0, {
				displayText = f219_local4.name,
				btnType = "group",
				groupId = f219_local4.groupId,
				groupBufferType = f219_local4.bufferType,
				name = f219_local4.name,
				clanTag = f219_local4.clanTag,
				description = f219_local4.description,
				message = f219_local4.message,
				privacy = f219_local4.privacy,
				creationTimestamp = f219_local4.creationTimestamp,
				joinApprovalType = f219_local4.joinApprovalType,
				owner = f219_local4.owner,
				ownerXuid = f219_local4.ownerXuid,
				memberStatus = f219_local4.memberStatus,
				memberStatusText = f219_local4.memberStatusText,
				memberCount = f219_local4.memberCount,
				onlineCount = f219_local4.onlineCount,
				inTitleCount = f219_local4.inTitleCount,
				lbIndex = f219_local4.lbIndex,
				lbSortColumn = f219_local4.lbSortColumn,
				lbTimeFrame = f219_local4.lbTimeFrame,
				lbHardcore = f219_local4.lbHardcore,
				lbInitialized = f219_local4.lbInitialized
			} )
		end
		local f219_local2 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f219_arg0 ), "groups" )
		f219_arg1.groupCountModel = Engine[0xA798E4552F5E872]( f219_local2, "groupCount_self" )
		local f219_local3 = Engine[0xA798E4552F5E872]( f219_local2, "mainButtons" )
		for f219_local8, f219_local9 in ipairs( f219_local0 ) do
			local f219_local10 = Engine[0xA798E4552F5E872]( f219_local3, "buttonModel_" .. f219_local8 )
			table.insert( f219_arg1.buttons, {
				model = f219_local10,
				type = f219_local9.btnType,
				groupId = f219_local9.groupId,
				groupBufferType = f219_local9.groupBufferType
			} )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f219_local10, "displayText" ), Engine[0xED84C33EC5F01EA]( f219_local9.displayText ) )
			local f219_local7 = OpenGroupHeadquarters
			if Engine[0x614D394F6F9A18D]( Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f219_arg0 ), "groups.frameType" ) ) == "main" then
				f219_local7 = SetGroupSocialMenuFrameToMembers
			end
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f219_local10, "action" ), f219_local7 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f219_local10, "type" ), f219_local9.btnType )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f219_local10, "groupId" ), f219_local9.groupId )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f219_local10, "groupBufferType" ), f219_local9.groupBufferType )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f219_local10, "name" ), f219_local9.name )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f219_local10, "clanTag" ), f219_local9.clanTag )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f219_local10, "description" ), f219_local9.description )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f219_local10, "message" ), f219_local9.message )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f219_local10, "privacy" ), f219_local9.privacy )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f219_local10, "creationTimestamp" ), f219_local9.creationTimestamp )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f219_local10, "owner" ), f219_local9.owner )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f219_local10, "ownerXuid" ), f219_local9.ownerXuid )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f219_local10, "memberStatus" ), f219_local9.memberStatus )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f219_local10, "memberStatusText" ), f219_local9.memberStatusText )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f219_local10, "joinApprovalType" ), f219_local9.joinApprovalType )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f219_local10, "memberCount" ), f219_local9.memberCount )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f219_local10, "onlineCount" ), f219_local9.onlineCount )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f219_local10, "inTitleCount" ), f219_local9.inTitleCount )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f219_local10, "lbIndex" ), f219_local9.lbIndex )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f219_local10, "lbSortColumn" ), f219_local9.lbSortColumn )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f219_local10, "lbTimeFrame" ), f219_local9.lbTimeFrame )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f219_local10, "lbHardcore" ), f219_local9.lbHardcore )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f219_local10, "lbInitialized" ), f219_local9.lbInitialized )
		end
		f219_arg1:subscribeToModel( f219_arg1.groupCountModel, function ()
			f219_arg1:updateDataSource()
		end, false )
	end,
	getCustomPropertiesForItem = function ( f221_arg0, f221_arg1 )
		return f221_arg0.buttons[f221_arg1]
	end,
	getCount = function ( f222_arg0 )
		return #f222_arg0.buttons
	end,
	getItem = function ( f223_arg0, f223_arg1, f223_arg2 )
		return f223_arg1.buttons[f223_arg2].model
	end
}
DataSources.FindGroupsCategoryList = ListHelper_SetupDataSource( "FindGroupsCategoryList", function ( f224_arg0 )
	local f224_local0 = {}
	table.insert( f224_local0, {
		models = {
			image = "t7_mp_icon_groups_friends",
			displayText = 0x9DC8A50F97C2EEC
		},
		properties = {
			category = "friends"
		}
	} )
	table.insert( f224_local0, {
		models = {
			image = "t7_mp_icon_groups_popular",
			displayText = 0xEF452C0A92D1368
		},
		properties = {
			category = "popular"
		}
	} )
	return f224_local0
end, true )
DataSources.FindGroupsButtonList = {
	prepare = function ( f225_arg0, f225_arg1, f225_arg2 )
		f225_arg1.buttons = {}
		local f225_local0 = {}
		local f225_local1 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f225_arg0 ), "groups.findGroupsCategory" )
		local f225_local2 = Engine[0x614D394F6F9A18D]( f225_local1 )
		local f225_local3 = Enum[0x5E0DA0F6EB19636][0xB376A6D12750A6A]
		if f225_local2 == "popular" then
			f225_local3 = Enum[0x5E0DA0F6EB19636][0x3FCFEF6BA079D2E]
		end
		local f225_local4 = Engine[0xC5AD04FDF32924A]( f225_arg0, f225_local3 )
		local f225_local5 = Engine[0xC5AD04FDF32924A]( f225_arg0, Enum[0x5E0DA0F6EB19636][0xE2856B6DCC15907] )
		for f225_local6 = 1, #f225_local4, 1 do
			local f225_local9 = false
			for f225_local10 = 1, #f225_local5, 1 do
				if f225_local4[f225_local6].groupId == f225_local5[f225_local10].groupId then
					f225_local9 = true
					break
				end
			end
			if not f225_local9 then
				local f225_local10 = f225_local4[f225_local6]
				table.insert( f225_local0, {
					displayText = f225_local10.name,
					action = OpenGroupHeadquarters,
					btnType = "group",
					groupId = f225_local10.groupId,
					groupBufferType = f225_local10.bufferType,
					name = f225_local10.name,
					clanTag = f225_local10.clanTag,
					description = f225_local10.description,
					message = f225_local10.message,
					privacy = f225_local10.privacy,
					creationTimestamp = f225_local10.creationTimestamp,
					owner = f225_local10.owner,
					ownerXuid = f225_local10.ownerXuid,
					memberStatus = f225_local10.memberStatus,
					memberStatusText = f225_local10.memberStatusText,
					memberCount = f225_local10.memberCount,
					onlineCount = f225_local10.onlineCount,
					inTitleCount = f225_local10.inTitleCount,
					lbIndex = f225_local10.lbIndex,
					lbSortColumn = f225_local10.lbSortColumn,
					lbTimeFrame = f225_local10.lbTimeFrame,
					lbHardcore = f225_local10.lbHardcore,
					lbInitialized = f225_local10.lbInitialized
				} )
			end
		end
		local f225_local8 = Engine[0xA798E4552F5E872]( Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f225_arg0 ), "groups" ), "findGroupsButtons" )
		for f225_local11, f225_local12 in ipairs( f225_local0 ) do
			local f225_local14 = Engine[0xA798E4552F5E872]( f225_local8, "buttonModel_" .. f225_local11 )
			table.insert( f225_arg1.buttons, {
				model = f225_local14,
				type = f225_local12.btnType,
				groupId = f225_local12.groupId,
				groupBufferType = f225_local12.groupBufferType
			} )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f225_local14, "displayText" ), Engine[0xED84C33EC5F01EA]( f225_local12.displayText ) )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f225_local14, "action" ), f225_local12.action )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f225_local14, "type" ), f225_local12.btnType )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f225_local14, "groupId" ), f225_local12.groupId )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f225_local14, "groupBufferType" ), f225_local12.groupBufferType )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f225_local14, "name" ), f225_local12.name )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f225_local14, "clanTag" ), f225_local12.clanTag )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f225_local14, "description" ), f225_local12.description )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f225_local14, "message" ), f225_local12.message )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f225_local14, "privacy" ), f225_local12.privacy )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f225_local14, "creationTimestamp" ), f225_local12.creationTimestamp )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f225_local14, "owner" ), f225_local12.owner )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f225_local14, "ownerXuid" ), f225_local12.ownerXuid )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f225_local14, "memberStatus" ), f225_local12.memberStatus )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f225_local14, "memberStatusText" ), f225_local12.memberStatusText )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f225_local14, "memberCount" ), f225_local12.memberCount )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f225_local14, "onlineCount" ), f225_local12.onlineCount )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f225_local14, "inTitleCount" ), f225_local12.inTitleCount )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f225_local14, "lbIndex" ), f225_local12.lbIndex )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f225_local14, "lbSortColumn" ), f225_local12.lbSortColumn )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f225_local14, "lbTimeFrame" ), f225_local12.lbTimeFrame )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f225_local14, "lbHardcore" ), f225_local12.lbHardcore )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f225_local14, "lbInitialized" ), f225_local12.lbInitialized )
		end
		f225_arg1:subscribeToModel( f225_local1, function ()
			f225_arg1:updateDataSource()
		end, false )
	end,
	getCustomPropertiesForItem = function ( f227_arg0, f227_arg1 )
		return f227_arg0.buttons[f227_arg1]
	end,
	getCount = function ( f228_arg0 )
		return #f228_arg0.buttons
	end,
	getItem = function ( f229_arg0, f229_arg1, f229_arg2 )
		return f229_arg1.buttons[f229_arg2].model
	end
}
DataSources.GroupsHeadquartersTabList = ListHelper_SetupDataSource( "GroupsHeadquartersTabModel", function ( f230_arg0 )
	local f230_local0 = {}
	local f230_local1 = DoesHaveAdminRightsForGroup( nil, f230_arg0 )
	table.insert( f230_local0, {
		models = {
			tabIcon = CoD.buttonStrings.shoulderl
		},
		properties = {
			m_mouseDisabled = true
		}
	} )
	table.insert( f230_local0, {
		models = {
			tabName = Engine[0xF9F1239CFD921FE]( 0x9C4FE49610ED89F ),
			tabWidget = "CoD.OverviewTab"
		},
		properties = {
			tabId = "overview"
		}
	} )
	table.insert( f230_local0, {
		models = {
			tabName = Engine[0xF9F1239CFD921FE]( 0xCE0853CC48F0523 ),
			tabWidget = "CoD.RosterTab"
		},
		properties = {
			tabId = "roster"
		}
	} )
	table.insert( f230_local0, {
		models = {
			tabName = Engine[0xF9F1239CFD921FE]( 0x3D51AC46B98BE49 ),
			tabWidget = "CoD.ShowcaseTab"
		},
		properties = {
			tabId = "showcase"
		}
	} )
	if f230_local1 then
		table.insert( f230_local0, {
			models = {
				tabName = Engine[0xF9F1239CFD921FE]( 0x8F7AFB1CDB2451F ),
				tabWidget = "CoD.AdminTab"
			},
			properties = {
				tabId = "admin"
			}
		} )
	end
	table.insert( f230_local0, {
		models = {
			tabIcon = CoD.buttonStrings.shoulderr
		},
		properties = {
			m_mouseDisabled = true
		}
	} )
	return f230_local0
end, true )
DataSources.GroupHeadquartersOverviewButtonList = ListHelper_SetupDataSource( "GroupHeadquartersOverviewButtonListModel", function ( f231_arg0 )
	local f231_local0 = {}
	local f231_local1 = IsGroupMember( nil, f231_arg0 )
	local f231_local2 = IsGroupOwner( nil, f231_arg0 )
	local f231_local3 = function ( f232_arg0, f232_arg1, f232_arg2 )
		ProcessLeaveSelectedGroup( GoBack( f232_arg0, f232_arg2 ), f232_arg1, f232_arg2 )
	end
	
	if f231_local1 then
		table.insert( f231_local0, {
			models = {
				displayText = Engine[0xF9F1239CFD921FE]( 0xAE015724042F9A ),
				icon = "t7_mp_icon_groups_primary",
				action = CoD.NullFunction,
				hintText = Engine[0xF9F1239CFD921FE]( 0x2F42D4B29A7FE6A )
			}
		} )
		table.insert( f231_local0, {
			models = {
				displayText = Engine[0xF9F1239CFD921FE]( 0x37FA10499613CB ),
				icon = "t7_mp_icon_groups_remove",
				action = f231_local3,
				hintText = Engine[0xF9F1239CFD921FE]( 0x419AE3A1615B8FB )
			}
		} )
	end
	if not f231_local2 then
		table.insert( f231_local0, {
			models = {
				displayText = Engine[0xF9F1239CFD921FE]( 0x33D2A7CE329D718 ),
				icon = "t7_mp_icon_groups_ban",
				action = CoD.NullFunction,
				hintText = Engine[0xF9F1239CFD921FE]( 0x3F50B7CCBB0990 )
			}
		} )
	end
	return f231_local0
end )
DataSources.GroupHeadquartersAdminOptionsList = ListHelper_SetupDataSource( "GroupHeadquartersAdminOptionsListModel", function ( f233_arg0 )
	local f233_local0 = {}
	local f233_local1 = Engine[0x4DF5CFBC1771947]( f233_arg0 )
	local f233_local2 = Engine[0x614D394F6F9A18D]( Engine[0xA798E4552F5E872]( f233_local1, "Social.selectedFriendXUID" ) )
	local f233_local3 = Engine[0x614D394F6F9A18D]( Engine[0xA798E4552F5E872]( f233_local1, "Social.selectedFriendGamertag" ) )
	local f233_local4 = f233_local2 == Engine[0x93B19E01B1FD1C7]( f233_arg0 )
	local f233_local5 = Engine[0x614D394F6F9A18D]( Engine[0xA798E4552F5E872]( f233_local1, "Social.selectedFriendInTitle" ) )
	if f233_local2 == nil then
		return f233_local0
	end
	local f233_local6 = IsGroupMember( nil, f233_arg0 )
	local f233_local7 = IsGroupOwner( nil, f233_arg0 )
	if not isAdmin then
		
	else
		
	end
	table.insert( f233_local0, {
		models = {
			displayText = 0xEC8E9600BE52661,
			icon = "t7_mp_icon_groups_remove",
			hintText = Engine[0xF9F1239CFD921FE]( 0x6F65D65E2D21071 )
		},
		properties = {
			action = RemoveFromGroup,
			params = {
				controller = f233_arg0,
				gamertag = f233_local3,
				xuid = f233_local2
			}
		}
	} )
	table.insert( f233_local0, {
		models = {
			displayText = 0x4DDB2195F163F68,
			icon = "t7_mp_icon_groups_ban",
			hintText = Engine[0xF9F1239CFD921FE]( 0x56E55EFB91DC550 )
		},
		properties = {
			action = BanFromGroup,
			params = {
				controller = f233_arg0,
				gamertag = f233_local3,
				xuid = f233_local2
			}
		}
	} )
	return f233_local0
end )
DataSources.GroupHeadquartersAdminButtonList = ListHelper_SetupDataSource( "GroupHeadquartersAdminButtonListModel", function ( f234_arg0 )
	local f234_local0 = {}
	table.insert( f234_local0, {
		models = {
			displayText = Engine[0xF9F1239CFD921FE]( 0x583C1F10CF384A1 ),
			action = CoD.NullFunction,
			frameWidget = "CoD.AdminTabGroupApplicationsFrame"
		}
	} )
	table.insert( f234_local0, {
		models = {
			displayText = Engine[0xF9F1239CFD921FE]( 0x8E3F3AE7D2D30D4 ),
			action = CoD.NullFunction,
			frameWidget = "CoD.AdminTabGroupOverviewFrame"
		}
	} )
	table.insert( f234_local0, {
		models = {
			displayText = Engine[0xF9F1239CFD921FE]( 0xBA1B2E49E0699EB ),
			action = CoD.NullFunction,
			frameWidget = "CoD.AdminTabGroupPrivacyFrame"
		}
	} )
	table.insert( f234_local0, {
		models = {
			displayText = Engine[0xF9F1239CFD921FE]( 0x9F65536D8B2DC00 ),
			action = EditSelectedGroupName,
			frameWidget = "CoD.AdminTabGroupNameFrame"
		}
	} )
	table.insert( f234_local0, {
		models = {
			displayText = Engine[0xF9F1239CFD921FE]( 0x92167833B1A118D ),
			action = ProcessLeaveSelectedGroup,
			frameWidget = "CoD.AdminTabGroupDeleteFrame"
		}
	} )
	return f234_local0
end )
DataSources.SelectedGroup = {
	getModel = function ( f235_arg0 )
		if not f235_arg0 then
			f235_arg0 = Engine[0xA5B9C0111291A8B]()
		end
		return CoD.perController[f235_arg0].selectedGroup
	end
}
DataSources.CreateGroup = {
	getModel = function ( f236_arg0 )
		if not f236_arg0 then
			f236_arg0 = Engine[0xA5B9C0111291A8B]()
		end
		return Engine[0xA798E4552F5E872]( Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f236_arg0 ), "groups" ), "createGroup" )
	end
}
DataSources.GroupPrivacyModes = ListHelper_SetupDataSource( "GroupPrivacyModes", function ( f237_arg0 )
	local f237_local0 = {
		{
			name = 0xE31EFBC4D080D9E,
			value = Enum[0xE9D1DC67224A5DC][0xBBE7E58A48F8F6D]
		},
		{
			name = 0xF8E5B415DFE61DE,
			value = Enum[0xE9D1DC67224A5DC][0x843A0C3F2710247]
		}
	}
	local f237_local1 = {}
	local f237_local2 = Enum[0xE9D1DC67224A5DC][0xBBE7E58A48F8F6D]
	if CoD.perController[f237_arg0].selectedGroup and Engine[0x40E824FE270E174]( CoD.perController[f237_arg0].selectedGroup, "privacy" ) then
		f237_local2 = Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( CoD.perController[f237_arg0].selectedGroup, "privacy" ) )
	end
	for f237_local6, f237_local7 in ipairs( f237_local0 ) do
		table.insert( f237_local1, {
			models = {
				text = f237_local0[f237_local6].name,
				value = f237_local0[f237_local6].value
			},
			properties = {
				title = f237_local0[f237_local6].name,
				value = f237_local0[f237_local6].value,
				selectIndex = f237_local2 == f237_local0[f237_local6].value
			}
		} )
	end
	f237_local1[1].properties.first = true
	f237_local1[#f237_local0].properties.last = true
	return f237_local1
end, nil, nil, nil )
DataSources.GroupJoinApprovalTypes = ListHelper_SetupDataSource( "GroupJoinApprovalTypes", function ( f238_arg0 )
	local f238_local0 = {
		{
			name = 0x54CC86CF19F10B6,
			value = Enum[0x26A3827DB7CA69F][0x4B3F443644212F3]
		},
		{
			name = 0xF53261A250AE77C,
			value = Enum[0x26A3827DB7CA69F][0x6AF70C2F3487C0F]
		}
	}
	local f238_local1 = {}
	for f238_local5, f238_local6 in ipairs( f238_local0 ) do
		table.insert( f238_local1, {
			models = {
				text = f238_local0[f238_local5].name,
				value = f238_local0[f238_local5].value,
				selectIndex = 1
			},
			properties = {
				title = f238_local0[f238_local5].name,
				value = f238_local0[f238_local5].value,
				selectIndex = 1
			}
		} )
	end
	f238_local1[1].properties.first = true
	f238_local1[#f238_local0].properties.last = true
	return f238_local1
end, nil, nil, nil )
DataSources.TeamOperationSystem = {
	getModel = function ( f239_arg0 )
		if not f239_arg0 then
			f239_arg0 = Engine[0xA5B9C0111291A8B]()
		end
		return Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f239_arg0 ), "teamOperationSystem" )
	end
}
DataSources.Friends = {
	getCount = function ( f240_arg0 )
		return 10
	end,
	getItem = function ( f241_arg0, f241_arg1, f241_arg2 )
		local f241_local0 = {
			name = "Caezar",
			status = "Online",
			rank = "14",
			emblem = "menu_div_gold",
			rankIcon = "rank_com"
		}
		if f241_arg2 % 2 == 0 then
			f241_local0.name = "Bat35" .. f241_arg2
			f241_local0.emblem = "menu_div_bronze"
		end
		if f241_arg2 % 3 == 0 then
			f241_local0.name = "FakeForAll" .. f241_arg2
			f241_local0.emblem = "menu_div_silver"
			f241_local0.rankIcon = "rank_cpt"
			f241_local0.rank = 19
		end
		if f241_arg2 % 5 == 0 then
			f241_local0.name = "SuperGoat" .. f241_arg2
			f241_local0.emblem = "menu_div_bronze"
			f241_local0.rankIcon = "rank_sgt"
			f241_local0.rank = 34
		end
		if f241_arg2 % 7 == 0 then
			f241_local0.name = "SuperGoat" .. f241_arg2
			f241_local0.emblem = "menu_div_platinum"
			f241_local0.rankIcon = "rank_prestige02"
			f241_local0.rank = 50
		end
		local f241_local1 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f241_arg0 ), "Friendz." .. f241_arg2 )
		for f241_local5, f241_local6 in pairs( f241_local0 ) do
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f241_local1, f241_local5 ), f241_local6 )
		end
		return f241_local1
	end
}
DataSources.LobbyFriends = {
	prepare = function ( f242_arg0, f242_arg1, f242_arg2 )
		local f242_local0 = Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( Engine[0x40E824FE270E174]( Engine[0x4DF5CFBC1771947]( f242_arg0 ), "friends" ), "tab" ) )
		local f242_local1 = nil
		if f242_local0 == "friends" then
			f242_local1 = "unifiedListRoot"
		elseif f242_local0 == "recent" then
			f242_local1 = "rmpListRoot"
		elseif f242_local0 == "inbox" then
			f242_local1 = "inboxListRoot"
		elseif f242_local0 == "roster" then
			f242_local1 = "sgmListRoot"
		elseif f242_local0 == "grpmembers" then
			f242_local1 = "unifiedGroupMembersListRoot"
		else
			f242_local1 = "unifiedListRoot"
		end
		f242_arg1.unifiedFriendModel = Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), f242_local1 )
		f242_arg1.unifiedFriendCount = Engine[0x40E824FE270E174]( f242_arg1.unifiedFriendModel, "count" )
		f242_arg1:unsubscribeFromAllModels()
		f242_arg1.countSubscription = f242_arg1:subscribeToModel( f242_arg1.unifiedFriendCount, function ( model )
			f242_arg1:updateDataSource()
		end, false )
	end,
	getCount = function ( f244_arg0 )
		return Engine[0x614D394F6F9A18D]( f244_arg0.unifiedFriendCount )
	end,
	getItem = function ( f245_arg0, f245_arg1, f245_arg2 )
		return Engine[0x40E824FE270E174]( f245_arg1.unifiedFriendModel, "member" .. f245_arg2 - 1 )
	end
}
DataSources.GameScore = {
	getModel = function ( f246_arg0 )
		if not f246_arg0 then
			f246_arg0 = Engine[0xA5B9C0111291A8B]()
		end
		local f246_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f246_arg0 ), "gameScore" )
		if not Engine[0x7B48C1ABFF0F764]() then
			local f246_local1 = Engine[0x9591BD06D3B1B1]( f246_arg0 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f246_local0, "alliesScore" ), f246_local1.scores.TEAM_ALLIES )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f246_local0, "axisScore" ), f246_local1.scores.TEAM_AXIS )
		end
		return f246_local0
	end
}
DataSources.Equipment = {
	getModel = function ( f247_arg0 )
		if not f247_arg0 then
			f247_arg0 = Engine[0xA5B9C0111291A8B]()
		end
		return Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f247_arg0 ), "Equipment" )
	end
}
DataSources.ClientscriptDebugMenu = {
	prepare = function ( f248_arg0, f248_arg1, f248_arg2 )
		f248_arg1.cscDebugMenuModel = f248_arg1:getModel( Engine[0xA5B9C0111291A8B](), "cscDebugMenu" )
		f248_arg1.cscDebugMenuCountModel = Engine[0x40E824FE270E174]( f248_arg1.cscDebugMenuModel, "cscDebugMenuCount" )
		f248_arg1:unsubscribeFromAllModels()
		f248_arg1:subscribeToModel( f248_arg1.cscDebugMenuCountModel, function ()
			f248_arg1:updateDataSource()
		end, false )
	end,
	getCount = function ( f250_arg0 )
		return Engine[0x614D394F6F9A18D]( f250_arg0.cscDebugMenuCountModel )
	end,
	getItem = function ( f251_arg0, f251_arg1, f251_arg2 )
		return Engine[0x40E824FE270E174]( f251_arg1.cscDebugMenuModel, "listItem" .. f251_arg2 - 1 )
	end
}
function ClientHasCollectible( f252_arg0, f252_arg1, f252_arg2, f252_arg3 )
	if f252_arg3 or CoD.SafeGetModelValue( Engine[0x8DF2E5447F384B9](), "inBarracks" ) == true then
		local f252_local0 = Engine[0x8BF970606552F4C]( f252_arg0, Enum[0xBBD4F9E70101BA8][0xA5B261DA142B9F6] )
		return f252_local0.PlayerStatsByMap[f252_arg1].collectibles[f252_arg2]:get() == 1
	else
		return Engine[0x19A771A77F5D790]( f252_arg0, f252_arg1, f252_arg2, Enum[0x9C0C2196D8313A0][0x60063C67132EB69] )
	end
end
function GetCollectiblesXOfY( f253_arg0, f253_arg1, f253_arg2 )
	local f253_local0 = CoD.MapUtility.MapsTable[f253_arg1]
	local f253_local1 = 0
	local f253_local2 = 0
	if f253_local0 and f253_local0.collectibles then
		local f253_local3 = Engine[0xA7E3CD65E63086F]( Engine[0xC53F8D38DF9042B]( f253_local0.collectibles ) )
		if f253_local3 ~= nil then
			f253_local1 = #f253_local3
			for f253_local4 = 0, f253_local1 - 1, 1 do
				if ClientHasCollectible( f253_arg0, f253_arg1, f253_local4, f253_arg2 ) then
					f253_local2 = f253_local2 + 1
				end
			end
		end
	end
	return f253_local2, f253_local1
end
function GetAccoladesXOfY( f254_arg0, f254_arg1, f254_arg2 )
	local f254_local0 = CoD.MapUtility.MapsTable[f254_arg1]
	local f254_local1 = 0
	local f254_local2 = 0
	if f254_local0 and f254_local0.accoladelist then
		local f254_local3 = Engine[0xA7E3CD65E63086F]( Engine[0xC53F8D38DF9042B]( f254_local0.accoladelist ) )
		if f254_local3 ~= nil then
			f254_local2 = #f254_local3
			local f254_local4 = Engine[0xA6C26EBACD7322D]( f254_arg0, CoD.STATS_LOCATION_NORMAL, Enum[0x9C0C2196D8313A0][0x60063C67132EB69] )
			if f254_arg2 or CoD.SafeGetModelValue( Engine[0x8DF2E5447F384B9](), "inBarracks" ) == true then
				f254_local4 = Engine[0x8BF970606552F4C]( f254_arg0, Enum[0xBBD4F9E70101BA8][0xA5B261DA142B9F6] )
			end
			for f254_local5 = 0, 18, 1 do
				if f254_local4.PlayerStatsByMap[f254_local0.rootMapName].accolades[f254_local5].state:get() ~= 0 then
					f254_local1 = f254_local1 + 1
				end
			end
		end
	end
	return f254_local1, f254_local2
end
function FindPlaylistCategory( f255_arg0, f255_arg1 )
	for f255_local6, f255_local7 in ipairs( f255_arg0 ) do
		for f255_local3, f255_local4 in ipairs( f255_local7.playlists ) do
			if f255_local4.index == f255_arg1 then
				return f255_local7
			end
		end
	end
	return nil
end
DataSources.ZMMapsList = ListHelper_SetupDataSource( "ZMMapsList", function ( f256_arg0, f256_arg1 )
	local f256_local0 = {}
	if CoD.perController[f256_arg0].choosingZMPlaylist then
		local f256_local1 = nil
		local f256_local2 = CoD.PlaylistCategoryFilter or ""
		local f256_local3 = Engine[0xD4D7317F380395F]( f256_arg0, "playlist_" .. f256_local2 )
		local f256_local4 = FindPlaylistCategory( f256_local1, f256_local3 )
		local f256_local5 = 0
		for f256_local9, f256_local10 in ipairs( f256_local1 ) do
			if f256_local10.filter == f256_local2 then
				f256_local5 = f256_local5 + f256_local10.playerCount
			end
		end
		f256_local6 = function ( f257_arg0 )
			local f257_local0 = {}
			for f257_local5, f257_local6 in ipairs( f257_arg0.playlists ) do
				local f257_local4 = ""
				if Dvar[0xADD80F31337B482]:get() == true then
					f257_local4 = Engine[0xF9F1239CFD921FE]( 0xE0DD690CF0466BD, CoD.separateNumberWithCommas( f257_local6.playerCount ), CoD.separateNumberWithCommas( f256_local5 ) )
				else
					if f256_local5 <= 0 then
						f256_local5 = 1
					end
					f257_local4 = Engine[0xF9F1239CFD921FE]( 0x28C8DE8C3BB8977, math.floor( f257_local6.playerCount / f256_local5 * 100 + 0.5 ) )
				end
				table.insert( f256_local0, {
					models = {
						displayText = f257_local6.name or "",
						mapName = f257_local6.name or "",
						Image = f257_local6.icon or "blacktransparent",
						buttonText = f257_local6.name or "",
						mapDescription = f257_local6.description or "",
						playingCount = f257_local4
					},
					properties = {
						id = tostring( f257_local6.index ),
						category = f257_arg0,
						playlist = f257_local6,
						selectIndex = f257_local6.index == f256_local3,
						disabled = Engine[0x48A9F0577411885]( f256_arg0, f257_local6.index )
					}
				} )
			end
		end
		
		for f256_local10, f256_local11 in ipairs( f256_local1 ) do
			if f256_local11.filter == f256_local2 then
				f256_local6( f256_local11 )
			end
		end
	else
		for f256_local5, f256_local6 in LUI.IterateTableBySortedKeys( CoD.MapUtility.MapsTable, function ( f258_arg0, f258_arg1 )
			return CoD.MapUtility.MapsTable[f258_arg0].uniqueID < CoD.MapUtility.MapsTable[f258_arg1].uniqueID
		end, nil ) do
			if f256_local6.session_mode == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] and f256_local6.dlc_pack ~= -1 and (ShowPurchasableMap( f256_arg0, f256_local5 ) or Engine[0xC3C68A8BA45A52D]( f256_local5 ) and f256_local6.mapName ~= nil) then
				local f256_local7 = ""
				table.insert( f256_local0, {
					models = {
						displayText = CoD.StoreUtility.PrependPurchaseIconIfNeeded( f256_arg0, f256_local5, LocalizeToUpperString( f256_local6.mapName ) ),
						Image = f256_local6.previewImage,
						mapName = f256_local6.mapName,
						mapLocation = f256_local6.mapLocation,
						mapDescription = CoD.StoreUtility.AddUpsellToDescriptionIfNeeded( f256_arg0, f256_local5, f256_local6.mapDescription ),
						playingCount = Engine[0xF9F1239CFD921FE]( 0x44F626397695677, CoD.separateNumberWithCommas( 0 ), CoD.separateNumberWithCommas( 0 ) )
					},
					properties = {
						mapId = f256_local5,
						purchasable = not Engine[0xC3C68A8BA45A52D]( f256_local5 )
					}
				} )
			end
		end
	end
	CoD.StoreUtility.AddListDLCListener( f256_arg1 )
	return f256_local0
end )
DataSources.CPVideoPlayerList = ListHelper_SetupDataSource( "CPVideoPlayerList", function ( f259_arg0 )
	local f259_local0 = {}
	for f259_local5, f259_local6 in LUI.IterateTableBySortedKeys( CoD.MapUtility.MapsTable, function ( f260_arg0, f260_arg1 )
		return CoD.MapUtility.MapsTable[f260_arg0].uniqueID < CoD.MapUtility.MapsTable[f260_arg1].uniqueID
	end, nil ) do
		if f259_local6.session_mode == Enum[0x9C0C2196D8313A0][0x60063C67132EB69] and f259_local6.isSafeHouse == false and f259_local6.dlc_pack ~= -1 and f259_local6.campaign_mode == Enum[0x4317C8C4998D8DC][0xBC3515387CDAB7] then
			local f259_local4 = Engine[0xA6C26EBACD7322D]( f259_arg0 )
			if f259_local4 ~= nil and (f259_local4.PlayerStatsByMap[f259_local5].hasBeenCompleted == 1 or false ~= Dvar[0x1D589BB75561DCA]:get()) then
				table.insert( f259_local0, {
					models = {
						displayText = LocalizeToUpperString( f259_local6.mapName ),
						video = f259_local6.introMovie
					},
					properties = {}
				} )
			end
		end
	end
	table.insert( f259_local0, {
		models = {
			displayText = Engine[0xF9F1239CFD921FE]( 0x664B00CAD4E64E4 ),
			video = "zm_zod_load_zodloadingmovie"
		},
		properties = {}
	} )
	return f259_local0
end )
DataSources.CampaignSettings = {
	getModel = function ( f261_arg0 )
		local f261_local0 = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "CampaignSettings" )
		local f261_local1 = 1
		if Engine[0xEA2BE00F49480D]( Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43] ) and f261_arg0 == Engine[0xA5B9C0111291A8B]() then
			f261_local1 = Engine[0xB72F603CAC75B3A]( f261_arg0, "g_gameskill" )
		else
			local f261_local2 = Engine[0x40E824FE270E174]( Engine[0x4DF5CFBC1771947]( f261_arg0 ), "serverDifficulty" )
			f261_local1 = f261_local2 and Engine[0x614D394F6F9A18D]( f261_local2 )
		end
		if f261_local1 == nil then
			f261_local1 = 1
		end
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f261_local0, "difficulty" ), Engine[0xF9F1239CFD921FE]( CoD.CPUtility.DIFFICULTY[f261_local1] ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f261_local0, "difficultyIcon" ), CoD.CPUtility.DIFFICULTY_ICON[f261_local1] )
		if Engine[0x614D394F6F9A18D]( Engine[0xA798E4552F5E872]( f261_local0, "selectedMap" ) ) == nil then
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f261_local0, "selectedMap" ), Engine[0xE67E7253CC272C9]() )
		end
		return f261_local0
	end
}
DataSources.ZMSettings = {
	getModel = function ( f262_arg0 )
		return Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "ZMSettings" )
	end
}
DataSources.CampaignMissionList = {
	prepare = function ( f263_arg0, f263_arg1, f263_arg2 )
		f263_arg1.missionList = {}
		local f263_local0 = Engine[0x2DCF0973239E909]( CoD.protoMapsTable, 1, 0, "mapCount" )
		local f263_local1 = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "MissionLevels" )
		for f263_local2 = 1, f263_local0, 1 do
			local f263_local5 = f263_local2 - 1 .. ""
			local f263_local6 = Engine[0x2DCF0973239E909]( CoD.protoMapsTable, 0, 3, f263_local5 )
			local f263_local7 = Engine[0x2DCF0973239E909]( CoD.protoMapsTable, 1, 3, f263_local5 )
			local f263_local8 = Engine[0x2DCF0973239E909]( CoD.protoMapsTable, 2, 3, f263_local5 )
			local f263_local9 = Engine[0x2DCF0973239E909]( CoD.protoMapsTable, 4, 3, f263_local5 )
			local f263_local10 = Engine[0xA798E4552F5E872]( f263_local1, f263_local5 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f263_local10, "devName" ), f263_local6 .. "" )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f263_local10, "locName" ), f263_local7 .. "" )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f263_local10, "imagename" ), f263_local8 .. "" )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f263_local10, "desc" ), f263_local9 .. "" )
			table.insert( f263_arg1.missionList, f263_local10 )
		end
	end,
	getCount = function ( f264_arg0 )
		return #f264_arg0.missionList
	end,
	getItem = function ( f265_arg0, f265_arg1, f265_arg2 )
		return f265_arg1.missionList[f265_arg2]
	end
}
DataSources.LocalServer = {
	prepare = function ( f266_arg0, f266_arg1, f266_arg2 )
		f266_arg1.baseModel = Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "serverListRoot" )
		f266_arg1.countModel = Engine[0x40E824FE270E174]( f266_arg1.baseModel, "count" )
		if f266_arg1.countSubscription then
			f266_arg1:removeSubscription( f266_arg1.countSubscription )
		end
		f266_arg1.countSubscription = f266_arg1:subscribeToModel( f266_arg1.countModel, function ()
			if f266_arg1._onDataSourceListCountChanged then
				f266_arg1:_onDataSourceListCountChanged()
			end
			RefreshListFindSelectedXuid( f266_arg0, f266_arg1 )
		end, false )
	end,
	getCount = function ( f268_arg0 )
		return Engine[0x614D394F6F9A18D]( f268_arg0.countModel )
	end,
	getItem = function ( f269_arg0, f269_arg1, f269_arg2 )
		return Engine[0x40E824FE270E174]( f269_arg1.baseModel, "server" .. f269_arg2 - 1 )
	end,
	cleanup = function ( f270_arg0, f270_arg1 )
		Engine[0x543B6829DCA88EE]()
	end
}
DataSources.LocalServerPlayer = {
	prepare = function ( f271_arg0, f271_arg1, f271_arg2 )
		f271_arg1.playerList = {}
		local f271_local0 = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "serverPlayerListRoot" )
		f271_arg1.selectedServerModel = Engine[0xA798E4552F5E872]( f271_local0, "selectedServer" )
		local f271_local1 = Engine[0x614D394F6F9A18D]( f271_arg1.selectedServerModel )
		if f271_local1 ~= nil then
			f271_arg1.playerList = Engine[0xBE925D0FEC4D53B]( f271_local1 )
			if f271_arg1.playerList ~= nil then
				for f271_local5, f271_local6 in pairs( f271_arg1.playerList ) do
					local f271_local7 = Engine[0xA798E4552F5E872]( f271_local0, "playerModel_" .. f271_local5 )
					f271_arg1.playerList[f271_local5].model = f271_local7
					Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f271_local7, "xuid" ), f271_local6.xuid )
					Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f271_local7, "gamertag" ), f271_local6.gamertag )
					Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f271_local7, "isLeader" ), f271_local6.isLeader )
				end
			else
				f271_arg1.playerList = {}
			end
		end
	end,
	getCustomPropertiesForItem = function ( f272_arg0, f272_arg1 )
		return f272_arg0.playerList[f272_arg1]
	end,
	getCount = function ( f273_arg0 )
		return #f273_arg0.playerList
	end,
	getItem = function ( f274_arg0, f274_arg1, f274_arg2 )
		return f274_arg1.playerList[f274_arg2].model
	end
}
DataSources.XPProgressionBar = {
	getModel = function ( f275_arg0 )
		if not f275_arg0 then
			f275_arg0 = Engine[0xA5B9C0111291A8B]()
		end
		local f275_local0 = false
		local f275_local1 = 0
		local f275_local2 = 2
		local f275_local3 = 7
		local f275_local4 = 14
		local f275_local5 = {
			displayLevelForCurrRank = 0,
			currRankIconMaterialName = "",
			displayLevelForNextRank = 0,
			nextRank = 0,
			nextRankIconMaterialName = "",
			currRankXP = 0,
			xpToNextRank = 0,
			progressPct = 0
		}
		if not IsLobbyNetworkModeLAN() then
			f275_local5.currentStats = CoD.GetPlayerStats( f275_arg0 )
			f275_local5.currPrestige = IsInParagonCapableGameMode() and f275_local5.currentStats.PlayerStatsList.PLEVEL.StatValue:get() or nil
			local f275_local6 = Engine[0x3EAC408F958FF05]()
			f275_local0 = IsInParagonCapableGameMode() and f275_local5.currPrestige == CoD.PrestigeUtility.GetPrestigeCap()
			if f275_local0 then
				f275_local5.currentRank = f275_local5.currentStats.PlayerStatsList.PARAGON_RANK.StatValue:get()
				f275_local5.displayLevelForCurrRank = Engine[0x801A572E417CC01]( f275_local5.currentRank )
				f275_local5.currRankIconMaterialName = Engine[0xB1AE00E1863FFE1]( f275_local5.currentRank )
				f275_local5.nextRank = f275_local5.currentRank + 1
				f275_local5.displayLevelForNextRank = tonumber( f275_local5.displayLevelForCurrRank ) + 1
				f275_local5.nextRankIconMaterialName = Engine[0xB1AE00E1863FFE1]( f275_local5.nextRank )
				f275_local5.paragonIconId = f275_local5.currentStats.PlayerStatsList.PARAGON_ICON_ID.StatValue:get()
				if f275_local5.paragonIconId ~= CoD.PrestigeUtility.INVALID_PARAGON_ICON_ID and IsGameModeParagonCapable() then
					f275_local5.currRankIconMaterialName = Engine[0x142BF2BEA87722E]( f275_local5.paragonIconId )
					f275_local5.nextRankIconMaterialName = f275_local5.currRankIconMaterialName
				end
				f275_local5.currRankXP = f275_local5.currentStats.PlayerStatsList.RANKXP and f275_local5.currentStats.PlayerStatsList.RANKXP.StatValue:get() or 0
				f275_local5.currRankXP = CoD.PlayerStatsUtility.GetPrestigeMasterAbsoluteXP( f275_local6, f275_local5.currentStats.PlayerStatsList.PARAGON_RANKXP and f275_local5.currentStats.PlayerStatsList.PARAGON_RANKXP.StatValue:get() or 0 )
				f275_local5.minXPForCurrRank = Engine[0x109F8F1C5A3513B]( tonumber( f275_local5.currentRank ), f275_local6 )
				f275_local5.maxXPForCurrRank = Engine[0xE7C7AB06A7E4905]( tonumber( f275_local5.currentRank ), f275_local6 )
			else
				f275_local5.currentRank = f275_local5.currentStats.PlayerStatsList.RANK and f275_local5.currentStats.PlayerStatsList.RANK.StatValue:get() or 0
				f275_local5.displayLevelForCurrRank = Engine[0xE1DE4A6CE92B4FD]( f275_local5.currentRank )
				f275_local5.currRankIconMaterialName = f275_local5.currPrestige and Engine[0x9C6922557618920]( f275_local5.currentRank, f275_local5.currPrestige, f275_local6 ) or Engine[0xD4A9B159BE44163]( f275_local5.currentRank )
				f275_local5.nextRank = f275_local5.currentRank + 1
				f275_local5.displayLevelForNextRank = Engine[0xE1DE4A6CE92B4FD]( f275_local5.nextRank )
				f275_local5.nextRankIconMaterialName = f275_local5.currPrestige and Engine[0x9C6922557618920]( f275_local5.nextRank, f275_local5.currPrestige, f275_local6 ) or Engine[0xD4A9B159BE44163]( f275_local5.nextRank )
				f275_local5.currRankXP = f275_local5.currentStats.PlayerStatsList.RANKXP and f275_local5.currentStats.PlayerStatsList.RANKXP.StatValue:get() or 0
				f275_local5.minXPForCurrRank = Engine[0x446674C5F7BF2A7]( tonumber( f275_local5.currentRank ) )
				f275_local5.maxXPForCurrRank = Engine[0x75A718DCC739F09]( tonumber( f275_local5.currentRank ) )
			end
			f275_local5.prestigeNext = CoD.PrestigeNext( f275_arg0 )
			f275_local5.xpToNextRank = f275_local5.maxXPForCurrRank - f275_local5.currRankXP
			f275_local5.relativeRankXP = f275_local5.currRankXP - f275_local5.minXPForCurrRank
			f275_local5.progressPct = f275_local5.relativeRankXP / (f275_local5.maxXPForCurrRank - f275_local5.minXPForCurrRank)
		end
		local f275_local7 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f275_arg0 ), "XPProgressionBar" )
		local f275_local8 = ""
		if not (f275_local0 or f275_local5.nextRank <= CoD.RankUtility.GetRankCap()) or f275_local0 and f275_local5.nextRank >= CoD.RankUtility.GetParagonRankCap() then
			f275_local8 = Engine[0xF9F1239CFD921FE]( 0x648FC67DF4BF35E )
			f275_local5.nextRankIconMaterialName = 0x7615068F50B3D66
		elseif f275_local5.displayLevelForNextRank > 0 then
			f275_local8 = Engine[0xF9F1239CFD921FE]( 0xBC1D826D76D607F, f275_local5.displayLevelForNextRank )
		end
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f275_local7, "currentRank" ), f275_local5.displayLevelForCurrRank )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f275_local7, "currentRankIcon" ), f275_local5.currRankIconMaterialName )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f275_local7, "rankLabel" ), Engine[0xF9F1239CFD921FE]( 0xBC1D826D76D607F, f275_local5.displayLevelForCurrRank ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f275_local7, "rankIcon" ), f275_local5.currRankIconMaterialName )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f275_local7, "nextRank" ), f275_local5.displayLevelForNextRank )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f275_local7, "nextRankLabel" ), f275_local8 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f275_local7, "nextRankIcon" ), f275_local5.nextRankIconMaterialName )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f275_local7, "currentXP" ), f275_local5.currRankXP )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f275_local7, "xpToNextRank" ), f275_local5.xpToNextRank )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f275_local7, "progress" ), f275_local5.progressPct )
		return f275_local7
	end
}
DataSources.GadgetModList = {
	prepare = function ( f276_arg0, f276_arg1, f276_arg2 )
		
	end,
	getCount = function ( f277_arg0 )
		if f277_arg0.baseModel then
			local f277_local0 = Engine[0x40E824FE270E174]( f277_arg0.baseModel, "gadgetAttachments.count" )
			if f277_local0 then
				return Engine[0x614D394F6F9A18D]( f277_local0 )
			end
		end
		return 0
	end,
	getItem = function ( f278_arg0, f278_arg1, f278_arg2 )
		if f278_arg1.baseModel then
			local f278_local0 = Engine[0x40E824FE270E174]( f278_arg1.baseModel, "gadgetAttachments." .. f278_arg2 )
			if f278_local0 then
				return f278_local0
			end
		end
		return nil
	end
}
DataSources.AARStats = {
	prepare = function ( f279_arg0, f279_arg1, f279_arg2 )
		f279_arg1.AARStatsList = {}
		local f279_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f279_arg0 ), "AARStats" )
		local f279_local1 = CoD.GetPlayerStats( f279_arg0 )
		f279_local1 = f279_local1.AfterActionReportStats
		local f279_local2 = {}
		for f279_local3 = 0, Dvar[0x5A2E5EE8014325D]:get() - 1, 1 do
			if f279_local1.playerStats[f279_local3].isActive:get() == 1 then
				f279_local2[f279_local3] = {}
				f279_local2[f279_local3].name = f279_local1.playerStats[f279_local3].name:get()
				f279_local2[f279_local3].rank = f279_local1.playerStats[f279_local3].curRank:get() + 1
				f279_local2[f279_local3].rankIcon = Engine[0x9C6922557618920]( f279_local1.playerStats[f279_local3].curRank:get() )
				f279_local2[f279_local3].kills = f279_local1.playerStats[f279_local3].kills:get()
				f279_local2[f279_local3].assists = f279_local1.playerStats[f279_local3].assists:get()
				f279_local2[f279_local3].medalName1 = ""
				f279_local2[f279_local3].medalImage1 = ""
				f279_local2[f279_local3].medalName2 = ""
				f279_local2[f279_local3].medalImage2 = ""
				f279_local2[f279_local3].medalName3 = ""
				f279_local2[f279_local3].medalImage3 = ""
				if f279_local1.playerStats[f279_local3].medals[0]:get() == f279_local3 then
					f279_local2[f279_local3].medalName1 = "Kill Master"
					f279_local2[f279_local3].medalImage1 = "hud_medals_default"
				end
				if f279_local1.playerStats[f279_local3].medals[1]:get() == f279_local3 then
					f279_local2[f279_local3].medalName2 = "Assist Master"
					f279_local2[f279_local3].medalImage2 = "hud_medals_revenge"
				end
				if f279_local1.playerStats[f279_local3].medals[2]:get() == f279_local3 then
					f279_local2[f279_local3].medalName3 = "Revive Master"
					f279_local2[f279_local3].medalImage3 = "hud_medals_afterlife"
				end
			end
		end
		for f279_local6, f279_local7 in pairs( f279_local2 ) do
			local f279_local8 = f279_local7.name .. ""
			local f279_local9 = f279_local7.rank .. ""
			local f279_local10 = f279_local7.rankIcon .. ""
			local f279_local11 = f279_local7.kills .. ""
			local f279_local12 = f279_local7.assists .. ""
			local f279_local13 = f279_local7.medalName1 .. ""
			local f279_local14 = f279_local7.medalImage1 .. ""
			local f279_local15 = f279_local7.medalName2 .. ""
			local f279_local16 = f279_local7.medalImage2 .. ""
			local f279_local17 = f279_local7.medalName3 .. ""
			local f279_local18 = f279_local7.medalImage3 .. ""
			local f279_local19 = Engine[0xA798E4552F5E872]( f279_local0, f279_local6 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f279_local19, "playerName" ), f279_local8 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f279_local19, "playerRank" ), f279_local9 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f279_local19, "playerRankIcon" ), f279_local10 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f279_local19, "playerKills" ), f279_local11 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f279_local19, "playerAssists" ), f279_local12 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f279_local19, "medalName1" ), f279_local13 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f279_local19, "medalImage1" ), f279_local14 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f279_local19, "medalName2" ), f279_local15 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f279_local19, "medalImage2" ), f279_local16 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f279_local19, "medalName3" ), f279_local17 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f279_local19, "medalImage3" ), f279_local18 )
			table.insert( f279_arg1.AARStatsList, f279_local19 )
		end
	end,
	getCount = function ( f280_arg0 )
		return #f280_arg0.AARStatsList
	end,
	getItem = function ( f281_arg0, f281_arg1, f281_arg2 )
		return f281_arg1.AARStatsList[f281_arg2]
	end
}
DataSources.CombatRecordBestScoreMap = {
	getModel = function ( f282_arg0 )
		local f282_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f282_arg0 ), "CombatRecordBestScoreMap" )
		local f282_local1 = CoD.GetCombatRecordStats( f282_arg0 )
		local f282_local2 = 0
		local f282_local3 = ""
		for f282_local8, f282_local9 in pairs( CoD.MapUtility.MapsTable ) do
			if f282_local9.session_mode == Enum[0x9C0C2196D8313A0][0x60063C67132EB69] and f282_local9.campaign_mode == Enum[0x4317C8C4998D8DC][0xBC3515387CDAB7] and f282_local9.dlc_pack ~= -1 and f282_local9.isSubLevel == false then
				local f282_local7 = f282_local1.PlayerStatsByMap[f282_local8].highestStats.SCORE:get()
				if f282_local2 < f282_local7 then
					f282_local2 = f282_local7
					f282_local3 = f282_local8
				end
			end
		end
		if f282_local2 == 0 then
			f282_local2 = "--"
			f282_local3 = Engine[0xF9F1239CFD921FE]( 0x1EFDF7772FC1BF1 )
		end
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f282_local0, "highestScore" ), f282_local2 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f282_local0, "mapName" ), f282_local3 )
		return f282_local0
	end
}
DataSources.CombatRecordDeadliestEquipment = {
	getModel = function ( f283_arg0 )
		local f283_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f283_arg0 ), "CombatRecordDeadliestEquipment" )
		local f283_local1 = CoD.GetCombatRecordStats( f283_arg0 )
		local f283_local2 = 0
		local f283_local3 = 0
		local f283_local4 = 0x1EFDF7772FC1BF1
		for f283_local5 = 0, 255, 1 do
			if Engine[0x981A63C8A70462F]( f283_local5, CoD.GetCombatRecordMode() ) >= 0 then
				local f283_local8 = nil
				local f283_local9 = Engine[0xB8891E0F105C51F]( f283_local5, CoD.GetCombatRecordMode() )
				if f283_local8 and f283_local2 < f283_local8 then
					f283_local2 = f283_local8
					f283_local3 = f283_local5
					f283_local4 = Engine[0x6B7AC889104DED3]( f283_local5, Enum[0x6EB546760F890D2][0x569E84652131CD7], CoD.GetCombatRecordMode() )
				end
			end
		end
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f283_local0, "itemIndex" ), f283_local3 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f283_local0, "numKills" ), f283_local2 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f283_local0, "itemName" ), f283_local4 )
		return f283_local0
	end
}
DataSources.CombatRecordDeadliestScorestreak = {
	getModel = function ( f284_arg0 )
		local f284_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f284_arg0 ), "CombatRecordDeadliestScorestreak" )
		local f284_local1 = CoD.GetCombatRecordStats( f284_arg0 )
		local f284_local2 = 0
		local f284_local3 = 0
		local f284_local4 = 0x1EFDF7772FC1BF1
		for f284_local5 = 0, 255, 1 do
			if Engine[0x981A63C8A70462F]( f284_local5, CoD.GetCombatRecordMode() ) >= 0 and Engine[0x86DC0510B2E2933]( f284_local5, Enum[0x6EB546760F890D2][0x3057ABF96AF8289], CoD.GetCombatRecordMode() ) == "killstreak" then
				local f284_local8 = CoD.GetCombatRecordStatForPath( f284_local1, "ItemStats." .. f284_local5 .. ".stats.kills" )
				if f284_local2 < f284_local8 then
					f284_local2 = f284_local8
					f284_local3 = f284_local5
					f284_local4 = Engine[0x6B7AC889104DED3]( f284_local5, Enum[0x6EB546760F890D2][0x3057ABF96AF8289], CoD.GetCombatRecordMode() )
				end
			end
		end
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f284_local0, "itemIndex" ), f284_local3 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f284_local0, "numKills" ), f284_local2 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f284_local0, "itemName" ), f284_local4 )
		return f284_local0
	end
}
DataSources.CombatRecordDeadliestWeapon = {
	getModel = function ( f285_arg0 )
		local f285_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f285_arg0 ), "CombatRecordDeadliestWeapon" )
		local f285_local1 = CoD.GetCombatRecordStats( f285_arg0 )
		local f285_local2 = 0
		local f285_local3 = 0
		local f285_local4 = 0x1EFDF7772FC1BF1
		for f285_local5 = 0, 255, 1 do
			local f285_local8 = Engine[0x981A63C8A70462F]( f285_local5, CoD.GetCombatRecordMode() )
			if f285_local8 < -1 or f285_local8 >= 0 then
				local f285_local9 = Engine[0xB8891E0F105C51F]( f285_local5, CoD.GetCombatRecordMode() )
				if f285_local9 == "primary" or f285_local9 == "secondary" then
					local f285_local10 = CoD.GetCombatRecordStatForPath( f285_local1, "ItemStats." .. f285_local5 .. ".stats.kills" )
					if f285_local2 < f285_local10 then
						f285_local2 = f285_local10
						f285_local3 = f285_local5
						f285_local4 = Engine[0x6B7AC889104DED3]( f285_local5, Enum[0x6EB546760F890D2][0x569E84652131CD7], CoD.GetCombatRecordMode() )
					end
				end
			end
		end
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f285_local0, "itemIndex" ), f285_local3 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f285_local0, "numKills" ), f285_local2 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f285_local0, "itemName" ), f285_local4 )
		return f285_local0
	end
}
DataSources.CombatRecordMostUsedBubblegumBuff = {
	getModel = function ( f286_arg0 )
		local f286_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f286_arg0 ), "CombatRecordMostUsedBubblegumBuff" )
		local f286_local1 = CoD.GetCombatRecordStats( f286_arg0 )
		local f286_local2 = 0
		local f286_local3 = 0
		local f286_local4 = 0x1EFDF7772FC1BF1
		for f286_local5 = 0, 255, 1 do
			if Engine[0xB8891E0F105C51F]( f286_local5, CoD.GetCombatRecordMode() ) == "equippedbubblegumpack" then
				local f286_local8 = CoD.GetCombatRecordStatForPath( f286_local1, "ItemStats." .. f286_local5 .. ".stats.used" )
				if f286_local2 < f286_local8 then
					f286_local2 = f286_local8
					f286_local3 = f286_local5
					f286_local4 = Engine[0x6B7AC889104DED3]( f286_local5, Enum[0x6EB546760F890D2][0x48CD0338EE0B3AE], CoD.GetCombatRecordMode() )
				end
			end
		end
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f286_local0, "itemIndex" ), f286_local3 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f286_local0, "itemName" ), f286_local4 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f286_local0, "numUsed" ), f286_local2 )
		return f286_local0
	end
}
DataSources.CombatRecordZMHighestRound = {
	getModel = function ( f287_arg0 )
		local f287_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f287_arg0 ), "CombatRecordZMHighestRound" )
		local f287_local1 = CoD.GetCombatRecordStats( f287_arg0 )
		local f287_local2 = 0
		local f287_local3 = Engine[0xF9F1239CFD921FE]( 0x1EFDF7772FC1BF1 )
		for f287_local8, f287_local9 in pairs( CoD.MapUtility.MapsTable ) do
			if f287_local9.session_mode == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] and f287_local1.PlayerStatsByMap and f287_local1.PlayerStatsByMap[f287_local8] then
				local f287_local7 = f287_local1.PlayerStatsByMap[f287_local8].stats.HIGHEST_ROUND_REACHED.statValue:get()
				if f287_local2 < f287_local7 then
					f287_local2 = f287_local7
					f287_local3 = f287_local8
				end
			end
		end
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f287_local0, "highestRound" ), f287_local2 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f287_local0, "mapName" ), f287_local3 )
		return f287_local0
	end
}
DataSources.CombatRecordTotalAccoladesCompleted = {
	getModel = function ( f288_arg0 )
		local f288_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f288_arg0 ), "CombatRecordTotalAccoladesCompleted" )
		local f288_local1 = CoD.GetCombatRecordStats( f288_arg0 )
		local f288_local2 = 0
		for f288_local8, f288_local9 in LUI.IterateTableBySortedKeys( CoD.MapUtility.MapsTable, function ( f289_arg0, f289_arg1 )
			return CoD.MapUtility.MapsTable[f289_arg0].uniqueID < CoD.MapUtility.MapsTable[f289_arg1].uniqueID
		end, nil ) do
			if f288_local9.session_mode == Enum[0x9C0C2196D8313A0][0x60063C67132EB69] and f288_local9.campaign_mode == Enum[0x4317C8C4998D8DC][0xBC3515387CDAB7] and f288_local9.dlc_pack ~= -1 and f288_local9.isSubLevel == false then
				local f288_local6, f288_local7 = GetAccoladesXOfY( f288_arg0, f288_local8, true )
				f288_local2 = f288_local2 + f288_local6
			end
		end
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f288_local0, "accoladesCompleted" ), f288_local2 )
		return f288_local0
	end
}
DataSources.CombatRecordTotalCollectiblesFound = {
	getModel = function ( f290_arg0 )
		local f290_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f290_arg0 ), "CombatRecordTotalCollectiblesFound" )
		local f290_local1 = CoD.GetCombatRecordStats( f290_arg0 )
		local f290_local2 = 0
		for f290_local8, f290_local9 in LUI.IterateTableBySortedKeys( CoD.MapUtility.MapsTable, function ( f291_arg0, f291_arg1 )
			return CoD.MapUtility.MapsTable[f291_arg0].uniqueID < CoD.MapUtility.MapsTable[f291_arg1].uniqueID
		end, nil ) do
			if f290_local9.session_mode == Enum[0x9C0C2196D8313A0][0x60063C67132EB69] and f290_local9.campaign_mode == Enum[0x4317C8C4998D8DC][0xBC3515387CDAB7] and f290_local9.dlc_pack ~= -1 and f290_local9.isSubLevel == false then
				local f290_local6, f290_local7 = GetCollectiblesXOfY( f290_arg0, f290_local8, true )
				f290_local2 = f290_local2 + f290_local6
			end
		end
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f290_local0, "collectiblesFound" ), f290_local2 )
		return f290_local0
	end
}
DataSources.CombatRecordCollectiblesList = {
	prepare = function ( f292_arg0, f292_arg1, f292_arg2 )
		f292_arg1.items = {}
		local f292_local0 = 0
		local f292_local1 = 0
		local f292_local2 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f292_arg0 ), "CombatRecordCollectiblesList" )
		for f292_local10, f292_local11 in LUI.IterateTableBySortedKeys( CoD.MapUtility.MapsTable, function ( f293_arg0, f293_arg1 )
			return CoD.MapUtility.MapsTable[f293_arg0].uniqueID < CoD.MapUtility.MapsTable[f293_arg1].uniqueID
		end, nil ) do
			if f292_local11.session_mode == Enum[0x9C0C2196D8313A0][0x60063C67132EB69] and f292_local11.campaign_mode == Enum[0x4317C8C4998D8DC][0xBC3515387CDAB7] and f292_local11.dlc_pack ~= -1 and f292_local11.isSubLevel == false then
				f292_local0 = f292_local0 + 1
				local f292_local6, f292_local7 = GetCollectiblesXOfY( f292_arg0, f292_local10, true )
				local f292_local8 = Engine[0xA798E4552F5E872]( f292_local2, f292_local0 )
				local f292_local9 = CoD.GetCombatRecordStats( f292_arg0 )
				if f292_local9.PlayerStatsByMap[f292_local10].hasBeenCompleted:get() == 1 or f292_local6 > 0 then
					f292_local1 = f292_local1 + f292_local6
					Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f292_local8, "name" ), f292_local11.mapName )
					Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f292_local8, "stat" ), Engine[0xF9F1239CFD921FE]( 0x5D04C10230CB059, f292_local6, f292_local7 ) )
					Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f292_local8, "id" ), f292_local10 )
				else
					Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f292_local8, "name" ), f292_local11.mapName )
					Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f292_local8, "stat" ), "--" )
				end
				table.insert( f292_arg1.items, f292_local8 )
			end
		end
	end,
	getCount = function ( f294_arg0 )
		return #f294_arg0.items
	end,
	getItem = function ( f295_arg0, f295_arg1, f295_arg2 )
		return f295_arg1.items[f295_arg2]
	end
}
DataSources.CombatRecordEquipmentList = {
	prepare = function ( f296_arg0, f296_arg1, f296_arg2 )
		f296_arg1.items = {}
		local f296_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f296_arg0 ), "CombatRecordEquipmentList" )
		local f296_local1 = CoD.GetCombatRecordStats( f296_arg0 )
		local f296_local2 = CoD.GetCombatRecordComparisonStats( f296_arg0 )
		table.sort( f296_arg1.items, function ( f297_arg0, f297_arg1 )
			local f297_local0 = Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f297_arg0, "stat" ) )
			local f297_local1 = Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f297_arg1, "stat" ) )
			if f297_local0 == f297_local1 then
				return Engine[0xED84C33EC5F01EA]( Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f297_arg0, "name" ) ) ) < Engine[0xED84C33EC5F01EA]( Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f297_arg1, "name" ) ) )
			else
				return f297_local1 < f297_local0
			end
		end )
	end,
	getCount = function ( f298_arg0 )
		return #f298_arg0.items
	end,
	getItem = function ( f299_arg0, f299_arg1, f299_arg2 )
		return f299_arg1.items[f299_arg2]
	end
}
DataSources.CombatRecordGameModeList = {
	prepare = function ( f300_arg0, f300_arg1, f300_arg2 )
		f300_arg1.items = {}
		local f300_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f300_arg0 ), "CombatRecordGameModeList" )
		local f300_local1 = CoD.GetCombatRecordStats( f300_arg0 )
		local f300_local2 = CoD.GetCombatRecordComparisonStats( f300_arg0 )
		for f300_local33, f300_local34 in pairs( Engine[0xA195D59C70219EF]( CoD.GetCombatRecordMode() ) ) do
			if f300_local34.category == "standard" then
				local f300_local6 = Engine[0xA798E4552F5E872]( f300_local0, f300_local33 )
				local f300_local7 = Engine[0xEA74FA7EE46E195]( f300_local34.gametype )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f300_local6, "name" ), f300_local7.nameRef )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f300_local6, "image" ), f300_local7.image )
				local f300_local8 = "PlayerStatsByGameType." .. f300_local34.gametype .. ".LOSSES"
				local f300_local9 = CoD.GetCombatRecordStatForPathOrZero( f300_local1, f300_local8 )
				local f300_local10 = 0
				if f300_local2 then
					f300_local10 = CoD.GetCombatRecordStatForPathOrZero( f300_local2, f300_local8 )
				end
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f300_local6, "losses" ), f300_local9 )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f300_local6, "lossesComparison" ), f300_local10 )
				local f300_local11 = "PlayerStatsByGameType." .. f300_local34.gametype .. ".WINS"
				local f300_local12 = CoD.GetCombatRecordStatForPathOrZero( f300_local1, f300_local11 )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f300_local6, "stat" ), f300_local12 )
				local f300_local13 = 0
				if f300_local2 then
					f300_local13 = CoD.GetCombatRecordStatForPathOrZero( f300_local2, f300_local11 )
				end
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f300_local6, "statComparison" ), f300_local13 )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f300_local6, "wlRatio" ), CoD.GetDisplayRatioFromTwoStats( f300_local12, f300_local9 ) )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f300_local6, "wlRatioComparison" ), CoD.GetDisplayRatioFromTwoStats( f300_local13, f300_local10 ) )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f300_local6, "lossRingFrac" ), f300_local9 / math.max( 1, f300_local9 + f300_local12 ) )
				local f300_local14 = "PlayerStatsByGameType." .. f300_local34.gametype .. ".WIN_STREAK"
				local f300_local15 = CoD.GetCombatRecordStatForPathOrZero( f300_local1, f300_local14 )
				local f300_local16 = 0
				if f300_local2 then
					f300_local16 = CoD.GetCombatRecordStatForPathOrZero( f300_local2, f300_local14 )
				end
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f300_local6, "streak" ), f300_local15 )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f300_local6, "streakComparison" ), f300_local16 )
				local f300_local17 = "PlayerStatsByGameType." .. f300_local34.gametype .. ".KILLS"
				local f300_local18 = CoD.GetCombatRecordStatForPathOrZero( f300_local1, f300_local17 )
				local f300_local19 = 0
				if f300_local2 then
					f300_local19 = CoD.GetCombatRecordStatForPathOrZero( f300_local2, f300_local17 )
				end
				local f300_local20 = "PlayerStatsByGameType." .. f300_local34.gametype .. ".DEATHS"
				local f300_local21 = CoD.GetCombatRecordStatForPathOrZero( f300_local1, f300_local20 )
				local f300_local22 = 0
				if f300_local2 then
					f300_local22 = CoD.GetCombatRecordStatForPathOrZero( f300_local2, f300_local20 )
				end
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f300_local6, "kdRatio" ), CoD.GetDisplayRatioFromTwoStats( f300_local18, f300_local21 ) )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f300_local6, "kdRatioComparison" ), CoD.GetDisplayRatioFromTwoStats( f300_local19, f300_local22 ) )
				local f300_local23 = "PlayerStatsByGameType." .. f300_local34.gametype .. ".SCORE"
				local f300_local24 = CoD.GetCombatRecordStatForPathOrZero( f300_local1, f300_local23 )
				local f300_local25 = 0
				if f300_local2 then
					f300_local25 = CoD.GetCombatRecordStatForPathOrZero( f300_local2, f300_local23 )
				end
				local f300_local26 = "PlayerStatsByGameType." .. f300_local34.gametype .. ".TIME_PLAYED_TOTAL"
				local f300_local27 = CoD.GetCombatRecordStatForPathOrZero( f300_local1, f300_local26 )
				local f300_local28 = 0
				if f300_local2 then
					f300_local28 = CoD.GetCombatRecordStatForPathOrZero( f300_local2, f300_local26 )
				end
				local f300_local29 = math.max( 1, f300_local27 / 60 )
				local f300_local30 = math.max( 1, f300_local28 / 60 )
				local f300_local31 = math.floor( f300_local24 / f300_local29 + 0.5 )
				local f300_local32 = math.floor( f300_local25 / f300_local30 + 0.5 )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f300_local6, "spm" ), f300_local31 )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f300_local6, "spmComparison" ), f300_local32 )
				table.insert( f300_arg1.items, f300_local6 )
			end
		end
		table.sort( f300_arg1.items, function ( f301_arg0, f301_arg1 )
			local f301_local0 = Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f301_arg0, "stat" ) )
			local f301_local1 = Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f301_arg1, "stat" ) )
			if f301_local0 == f301_local1 then
				return Engine[0xED84C33EC5F01EA]( Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f301_arg0, "name" ) ) ) < Engine[0xED84C33EC5F01EA]( Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f301_arg1, "name" ) ) )
			else
				return f301_local1 < f301_local0
			end
		end )
	end,
	getCount = function ( f302_arg0 )
		return #f302_arg0.items
	end,
	getItem = function ( f303_arg0, f303_arg1, f303_arg2 )
		return f303_arg1.items[f303_arg2]
	end
}
DataSources.CombatRecordMostWonGameMode = {
	getModel = function ( f304_arg0 )
		local f304_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f304_arg0 ), "CombatRecordMostWonGameMode" )
		local f304_local1, f304_local2, f304_local3 = nil
		local f304_local4 = CoD.GetCombatRecordStats( f304_arg0 )
		for f304_local10, f304_local11 in pairs( Engine[0xA195D59C70219EF]( CoD.GetCombatRecordMode() ) ) do
			if f304_local11.category == "standard" then
				local f304_local8 = CoD.GetCombatRecordStatForPath( f304_local4, "PlayerStatsByGameType." .. f304_local11.gametype .. ".WINS" )
				if not f304_local1 or f304_local1 < f304_local8 then
					f304_local1 = f304_local8
					local f304_local9 = Engine[0xEA74FA7EE46E195]( f304_local11.gametype )
					f304_local2 = f304_local9.image
					f304_local3 = f304_local9.nameRef
				end
			end
		end
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f304_local0, "image" ), f304_local2 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f304_local0, "name" ), f304_local3 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f304_local0, "wins" ), f304_local1 )
		return f304_local0
	end
}
DataSources.CombatRecordMPMedal1 = {
	getModel = function ( f305_arg0 )
		local f305_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f305_arg0 ), "CombatRecordMedal1" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f305_local0, "medalRef" ), 0x591DD5D6CABBD37 )
		local f305_local1 = Engine[0x8BF970606552F4C]( f305_arg0, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C] )
		local f305_local2 = f305_local1.playerstatslist.medal_headshot.statvalue:get()
		if f305_local2 > 0 then
			local f305_local3 = Engine[0xE00B2F29271C60B]( Engine[0x2DCF0973239E909]( CoD.scoreInfoTableMP, 3, 2, 0x591DD5D6CABBD37 ) )
			if f305_local3 then
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f305_local0, "backingLarge" ), f305_local3.backingLarge )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f305_local0, "iconLarge" ), f305_local3.iconLarge )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f305_local0, "value" ), f305_local2 )
			end
		else
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f305_local0, "backingLarge" ), "t7_hud_medal_backing_badassery_outline" )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f305_local0, "iconLarge" ), "$blank" )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f305_local0, "value" ), "--" )
		end
		return f305_local0
	end
}
DataSources.CombatRecordMPMedal2 = {
	getModel = function ( f306_arg0 )
		local f306_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f306_arg0 ), "CombatRecordMedal2" )
		local f306_local1 = {
			0x239595BA030E555,
			0x7A87301EB8EB5D7,
			0x7A57201EB8C7E4D,
			0x7A56D01EB8C75CE,
			0x7A1E201EB8953C6,
			0x7A1E701EB895C45,
			0x10B3F87F301774B
		}
		local f306_local2 = Engine[0x8BF970606552F4C]( f306_arg0, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C] )
		local f306_local3, f306_local4, f306_local5, f306_local6 = nil
		for f306_local10, f306_local11 in ipairs( f306_local1 ) do
			local f306_local12 = f306_local2.playerstatslist[f306_local11].statvalue:get()
			if f306_local12 and f306_local12 > 0 then
				f306_local3 = f306_local11
				f306_local4 = f306_local12
				break
			end
		end
		if f306_local3 then
			f306_local8 = Engine[0xE00B2F29271C60B]( Engine[0x2DCF0973239E909]( CoD.scoreInfoTableMP, 3, 2, f306_local3 ) )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f306_local0, "medalRef" ), f306_local3 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f306_local0, "value" ), f306_local4 )
			if f306_local8 then
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f306_local0, "backingLarge" ), f306_local8.backingLarge )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f306_local0, "iconLarge" ), f306_local8.iconLarge )
			end
		else
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f306_local0, "medalRef" ), 0x3903A8AAF5DBA53 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f306_local0, "value" ), "--" )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f306_local0, "backingLarge" ), "uie_t7_hud_medal_backing_killstreak_outline" )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f306_local0, "iconLarge" ), "$blank" )
		end
		return f306_local0
	end
}
DataSources.CombatRecordMPMedal3 = {
	getModel = function ( f307_arg0 )
		local f307_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f307_arg0 ), "CombatRecordMedal3" )
		local f307_local1 = {
			0x69C9B1E2C17AF47,
			0xA099193BA2C714D,
			0xA098293BA2C57D0,
			0xA098393BA2C5983,
			0xA098493BA2C5B36,
			0xA098593BA2C5CE9,
			0xA098693BA2C5E9C,
			0xA098793BA2C604F
		}
		local f307_local2 = Engine[0x8BF970606552F4C]( f307_arg0, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C] )
		local f307_local3, f307_local4, f307_local5, f307_local6 = nil
		for f307_local10, f307_local11 in ipairs( f307_local1 ) do
			local f307_local12 = f307_local2.playerstatslist[f307_local11].statvalue:get()
			if f307_local12 and f307_local12 > 0 then
				f307_local3 = f307_local11
				f307_local4 = f307_local12
				break
			end
		end
		if f307_local3 then
			f307_local8 = Engine[0xE00B2F29271C60B]( Engine[0x2DCF0973239E909]( CoD.scoreInfoTableMP, 3, 2, f307_local3 ) )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f307_local0, "medalRef" ), f307_local3 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f307_local0, "value" ), f307_local4 )
			if f307_local8 then
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f307_local0, "backingLarge" ), f307_local8.backingLarge )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f307_local0, "iconLarge" ), f307_local8.iconLarge )
			end
		else
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f307_local0, "medalRef" ), 0x76CDFC356494B4E )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f307_local0, "value" ), "--" )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f307_local0, "backingLarge" ), "uie_t7_hud_medal_backing_multikill_outline" )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f307_local0, "iconLarge" ), "$blank" )
		end
		return f307_local0
	end
}
DataSources.CombatRecordMPMedal4 = {
	getModel = function ( f308_arg0 )
		local f308_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f308_arg0 ), "CombatRecordMedal4" )
		local f308_local1 = {
			0xD59FE23D6E96AFA,
			0x947050E1A845310,
			0xD98B33575011259,
			0x738A6BCB924C165,
			0x38BA6835F80D489,
			0x98E95D5B879B8C4,
			0x8F9898F2C7D8D8B,
			0x434F3CC6EC87FA2,
			0xF6C6B0815D2CD9F
		}
		local f308_local2 = Engine[0x8BF970606552F4C]( f308_arg0, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C] )
		local f308_local3 = nil
		local f308_local4 = 0
		local f308_local5, f308_local6 = nil
		for f308_local10, f308_local11 in ipairs( f308_local1 ) do
			local f308_local12 = f308_local2.playerstatslist[f308_local11].statvalue:get()
			if f308_local12 and f308_local4 < f308_local12 then
				f308_local3 = f308_local11
				f308_local4 = f308_local12
			end
		end
		if f308_local3 then
			f308_local8 = Engine[0xE00B2F29271C60B]( Engine[0x2DCF0973239E909]( CoD.scoreInfoTableMP, 3, 2, f308_local3 ) )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f308_local0, "medalRef" ), f308_local3 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f308_local0, "value" ), f308_local4 )
			if f308_local8 then
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f308_local0, "backingLarge" ), f308_local8.backingLarge )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f308_local0, "iconLarge" ), f308_local8.iconLarge )
			end
		else
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f308_local0, "medalRef" ), 0x9381BFDADA76E77 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f308_local0, "value" ), "--" )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f308_local0, "backingLarge" ), "uie_t7_hud_medal_backing_specialist_outline" )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f308_local0, "iconLarge" ), "$blank" )
		end
		return f308_local0
	end
}
DataSources.CombatRecordMPMedal5 = {
	getModel = function ( f309_arg0 )
		local f309_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f309_arg0 ), "CombatRecordMedal5" )
		local f309_local1 = {
			0x9C37154A6593727,
			0x9B8CB21838CA370,
			0x9E7BD82D6C0D95D,
			0xB38CF0C4CD611B3,
			0x7E3DB533331A9A5,
			0x687A5EC84083FAB,
			0x825EF109D54B85E,
			0xE463A2AE1F8B84C,
			0x77C5EA085D8A5A7,
			0xE61853AFD407D62,
			0xB7E7BB92BBD6DB0
		}
		local f309_local2 = Engine[0x8BF970606552F4C]( f309_arg0, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C] )
		local f309_local3 = nil
		local f309_local4 = 0
		local f309_local5, f309_local6 = nil
		for f309_local10, f309_local11 in ipairs( f309_local1 ) do
			local f309_local12 = f309_local2.playerstatslist[f309_local11].statvalue:get()
			if f309_local12 and f309_local4 < f309_local12 then
				f309_local3 = f309_local11
				f309_local4 = f309_local12
			end
		end
		if f309_local3 then
			f309_local8 = Engine[0xE00B2F29271C60B]( Engine[0x2DCF0973239E909]( CoD.scoreInfoTableMP, 3, 2, f309_local3 ) )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f309_local0, "medalRef" ), f309_local3 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f309_local0, "value" ), f309_local4 )
			if f309_local8 then
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f309_local0, "backingLarge" ), f309_local8.backingLarge )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f309_local0, "iconLarge" ), f309_local8.iconLarge )
			end
		else
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f309_local0, "medalRef" ), 0xA15276C30758A4B )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f309_local0, "value" ), "--" )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f309_local0, "backingLarge" ), "uie_t7_hud_medal_backing_specialist_outline" )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f309_local0, "iconLarge" ), "$blank" )
		end
		return f309_local0
	end
}
DataSources.CombatRecordMPMedals = {
	prepare = function ( f310_arg0, f310_arg1, f310_arg2 )
		f310_arg1.items = {}
		local f310_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f310_arg0 ), "CombatRecordMPMedals" )
		local f310_local1 = Engine[0x8BF970606552F4C]( f310_arg0, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C] )
		f310_local1 = f310_local1.PlayerStatsList
		local f310_local2 = Engine[0x63FBABD1982143E]( CoD.scoreInfoTableMP )
		local f310_local3 = 2
		local f310_local4 = 3
		local f310_local5 = 12
		local f310_local6 = 13
		local f310_local7 = {}
		for f310_local8 = 1, f310_local2, 1 do
			if Engine[0xC6F8EC444864600]( CoD.scoreInfoTableMP, f310_local8 - 1, f310_local5 ) == CoD.CombatRecordMedalCategory then
				local f310_local11 = Engine[0xC6F8EC444864600]( CoD.scoreInfoTableMP, f310_local8 - 1, f310_local3 )
				local f310_local12 = Engine[0xC6F8EC444864600]( CoD.scoreInfoTableMP, f310_local8 - 1, f310_local4 )
				local f310_local13 = Engine[0xC6F8EC444864600]( CoD.scoreInfoTableMP, f310_local8 - 1, f310_local6 )
				if f310_local11 ~= "" then
					if LuaUtils.IsArenaMode() then
						local f310_local14 = f310_local1[f310_local11].arenaValue:get()
					else
						local f310_local14 = f310_local1[f310_local11].statValue:get()
					end
					local f310_local14 = Engine[0xE00B2F29271C60B]( f310_local12 )
					if timesEarned > 0 then
						local f310_local15 = Engine[0xA798E4552F5E872]( f310_local0, f310_local8 )
						if not f310_local7[f310_local11] then
							f310_local7[f310_local11] = f310_local8
							Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f310_local15, "name" ), f310_local11 )
							Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f310_local15, "timesEarned" ), timesEarned )
							Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f310_local15, "iconLarge" ), f310_local14.iconLarge )
							Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f310_local15, "backingLarge" ), f310_local14.backingLarge )
							Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f310_local15, "sortKey" ), f310_local13 )
							table.insert( f310_arg1.items, f310_local15 )
						else
							local f310_local16 = Engine[0x40E824FE270E174]( Engine[0x40E824FE270E174]( f310_local0, f310_local7[f310_local11] ), "timesEarned" )
							Engine[0x83C9B5DE1D9371]( f310_local16, Engine[0x614D394F6F9A18D]( f310_local16 ) + timesEarned )
						end
					end
				end
			end
		end
		table.sort( f310_arg1.items, function ( f311_arg0, f311_arg1 )
			return Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f311_arg0, "sortKey" ) ) < Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f311_arg1, "sortKey" ) )
		end )
		return f310_local0
	end,
	getCount = function ( f312_arg0 )
		return #f312_arg0.items
	end,
	getItem = function ( f313_arg0, f313_arg1, f313_arg2 )
		return f313_arg1.items[f313_arg2]
	end
}
DataSources.CombatRecordMPMedalTabs = ListHelper_SetupDataSource( "CombatRecordMPMedalTabs", function ( f314_arg0 )
	local f314_local0 = {}
	table.insert( f314_local0, {
		models = {
			tabIcon = CoD.buttonStrings.shoulderl
		},
		properties = {
			m_mouseDisabled = true
		}
	} )
	table.insert( f314_local0, {
		models = {
			tabName = 0x11443FB63782639,
			tabIcon = ""
		},
		properties = {
			tabId = "combat"
		}
	} )
	table.insert( f314_local0, {
		models = {
			tabName = 0x8B0D8B4A861BBC5,
			tabIcon = ""
		},
		properties = {
			tabId = "specialist"
		}
	} )
	table.insert( f314_local0, {
		models = {
			tabName = 0xEB1D30BFD69C119,
			tabIcon = ""
		},
		properties = {
			tabId = "antispecialist"
		}
	} )
	table.insert( f314_local0, {
		models = {
			tabName = 0xD17CC7D16033AEA,
			tabIcon = ""
		},
		properties = {
			tabId = "scorestreak"
		}
	} )
	table.insert( f314_local0, {
		models = {
			tabName = 0x79C859C8600D9E,
			tabIcon = ""
		},
		properties = {
			tabId = "antiscorestreak"
		}
	} )
	table.insert( f314_local0, {
		models = {
			tabName = 0xED2FACC41C9E672,
			tabIcon = ""
		},
		properties = {
			tabId = "gamemode"
		}
	} )
	table.insert( f314_local0, {
		models = {
			tabIcon = CoD.buttonStrings.shoulderr
		},
		properties = {
			m_mouseDisabled = true
		}
	} )
	return f314_local0
end )
DataSources.CombatRecordMPTabs = ListHelper_SetupDataSource( "CombatRecordMPTabs", function ( f315_arg0 )
	local f315_local0 = {}
	table.insert( f315_local0, {
		models = {
			tabIcon = CoD.buttonStrings.shoulderl
		},
		properties = {
			m_mouseDisabled = true
		}
	} )
	table.insert( f315_local0, {
		models = {
			tabName = 0x7BAA05710CE37D3,
			tabWidget = "CoD.CombatRecordSummaryPanel",
			tabIcon = ""
		},
		properties = {
			tabId = "summary"
		}
	} )
	table.insert( f315_local0, {
		models = {
			tabName = 0x8159ECA1876AE99,
			tabWidget = "CoD.CombatRecordPublicMatchPanel",
			tabIcon = ""
		},
		properties = {
			tabId = "public"
		}
	} )
	table.insert( f315_local0, {
		models = {
			tabName = 0x4B08B09636ECD9E,
			tabWidget = "CoD.CombatRecordArenaPanel",
			tabIcon = ""
		},
		properties = {
			tabId = "arena"
		}
	} )
	table.insert( f315_local0, {
		models = {
			tabIcon = CoD.buttonStrings.shoulderr
		},
		properties = {
			m_mouseDisabled = true
		}
	} )
	return f315_local0
end )
DataSources.CombatRecordScorestreakList = {
	prepare = function ( f316_arg0, f316_arg1, f316_arg2 )
		f316_arg1.items = {}
		local f316_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f316_arg0 ), "CombatRecordScorestreakList" )
		local f316_local1 = CoD.GetCombatRecordStats( f316_arg0 )
		local f316_local2 = CoD.GetCombatRecordComparisonStats( f316_arg0 )
		for f316_local3 = 0, 255, 1 do
			if Engine[0x981A63C8A70462F]( f316_local3, CoD.GetCombatRecordMode() ) >= 0 and Engine[0x86DC0510B2E2933]( f316_local3, Enum[0x6EB546760F890D2][0x3057ABF96AF8289], CoD.GetCombatRecordMode() ) == "killstreak" then
				local f316_local6 = Engine[0xA798E4552F5E872]( f316_local0, f316_local3 )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f316_local6, "name" ), Engine[0x6B7AC889104DED3]( f316_local3, Enum[0x6EB546760F890D2][0x3057ABF96AF8289], CoD.GetCombatRecordMode() ) )
				local f316_local7 = "kills"
				if Engine[0x3D0E017B2C4C7E3]( f316_local3, CoD.GetCombatRecordMode() ) then
					f316_local7 = "assists"
				end
				local f316_local8 = "ItemStats." .. f316_local3 .. ".stats." .. f316_local7
				local f316_local9 = CoD.GetCombatRecordStatForPath( f316_local1, f316_local8 )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f316_local6, "itemIndex" ), f316_local3 )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f316_local6, "stat" ), f316_local9 )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f316_local6, "statName" ), Engine[0xF9F1239CFD921FE]( 0x93E7CC7D7789D8F .. f316_local7 .. "_CAPS" ) )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f316_local6, "statPerUseString" ), Engine[0xF9F1239CFD921FE]( 0x93E7CC7D7789D8F .. f316_local7 .. "_PER_USE_CAPS" ) )
				local f316_local10 = 0
				if f316_local2 then
					f316_local10 = CoD.GetCombatRecordStatForPath( f316_local2, f316_local8 )
				end
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f316_local6, "statComparison" ), f316_local10 )
				table.insert( f316_arg1.items, f316_local6 )
			end
		end
		table.sort( f316_arg1.items, function ( f317_arg0, f317_arg1 )
			local f317_local0 = Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f317_arg0, "stat" ) )
			local f317_local1 = Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f317_arg1, "stat" ) )
			if f317_local0 == f317_local1 then
				return Engine[0xED84C33EC5F01EA]( Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f317_arg0, "name" ) ) ) < Engine[0xED84C33EC5F01EA]( Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f317_arg1, "name" ) ) )
			else
				return f317_local1 < f317_local0
			end
		end )
	end,
	getCount = function ( f318_arg0 )
		return #f318_arg0.items
	end,
	getItem = function ( f319_arg0, f319_arg1, f319_arg2 )
		return f319_arg1.items[f319_arg2]
	end
}
DataSources.CombatRecordSpecialistList = {
	prepare = function ( f320_arg0, f320_arg1, f320_arg2 )
		f320_arg1.items = {}
	end,
	getCount = function ( f321_arg0 )
		return #f321_arg0.items
	end,
	getItem = function ( f322_arg0, f322_arg1, f322_arg2 )
		return f322_arg1.items[f322_arg2]
	end
}
DataSources.CombatRecordWeaponsList = {
	prepare = function ( f323_arg0, f323_arg1, f323_arg2 )
		f323_arg1.weapons = {}
		local f323_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f323_arg0 ), "CombatRecordWeaponsList" )
		local f323_local1 = CoD.GetCombatRecordStats( f323_arg0 )
		local f323_local2 = CoD.GetCombatRecordComparisonStats( f323_arg0 )
		for f323_local3 = 0, 255, 1 do
			local f323_local6 = Engine[0x981A63C8A70462F]( f323_local3, CoD.GetCombatRecordMode() )
			if f323_local6 < -1 or f323_local6 >= 0 then
				local f323_local7 = Engine[0xB8891E0F105C51F]( f323_local3, CoD.GetCombatRecordMode() )
				if f323_local7 == "primary" or f323_local7 == "secondary" then
					local f323_local8 = Engine[0xA798E4552F5E872]( f323_local0, f323_local3 )
					local f323_local9 = "ItemStats." .. f323_local3 .. ".stats.kills"
					local f323_local10 = "ItemStats." .. f323_local3 .. ".stats.destroyed"
					local f323_local11 = CoD.GetCombatRecordStatForPath( f323_local1, f323_local9 )
					local f323_local12 = CoD.GetCombatRecordStatForPath( f323_local1, f323_local10 )
					local f323_local13 = "kills"
					local f323_local14 = f323_local11
					if Engine[0x86DC0510B2E2933]( f323_local3, Enum[0x6EB546760F890D2][0x569E84652131CD7], CoD.GetCombatRecordMode() ) == "weapon_launcher" then
						f323_local13 = "kills_destroys"
						f323_local14 = f323_local11 + f323_local12
					end
					Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f323_local8, "itemIndex" ), f323_local3 )
					Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f323_local8, "stat" ), f323_local14 )
					Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f323_local8, "statName" ), Engine[0xF9F1239CFD921FE]( 0x93E7CC7D7789D8F .. f323_local13 .. "_CAPS" ) )
					local f323_local15 = false
					local f323_local16 = Engine[0x6B7AC889104DED3]( f323_local3, Enum[0x6EB546760F890D2][0x569E84652131CD7], CoD.GetCombatRecordMode() )
					local f323_local17 = Engine[0xD5D69BA555E016D]( f323_local3, Enum[0x6EB546760F890D2][0x569E84652131CD7], CoD.GetCombatRecordMode() )
					local f323_local18 = 1
					if CoD.BlackMarketUtility.IsBlackMarketItem( f323_local17 ) and CoD.BlackMarketUtility.IsItemLocked( f323_arg0, f323_local17 ) then
						f323_local16 = CoD.BlackMarketUtility.ClassifiedName( false )
						f323_local15 = true
						f323_local18 = 0
					end
					Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f323_local8, "name" ), f323_local16 )
					Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f323_local8, "isBMClassified" ), f323_local15 )
					Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f323_local8, "statsAlpha" ), f323_local18 )
					local f323_local19 = 0
					if f323_local2 then
						f323_local19 = CoD.GetCombatRecordStatForPath( f323_local2, f323_local9 )
					end
					Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f323_local8, "statComparison" ), f323_local19 )
					if not CoD.BlackMarketUtility.IsUnreleasedBlackMarketItem( f323_local17 ) then
						table.insert( f323_arg1.weapons, f323_local8 )
					end
				end
			end
		end
		table.sort( f323_arg1.weapons, function ( f324_arg0, f324_arg1 )
			local f324_local0 = CoD.SafeGetModelValue( f324_arg0, "isBMClassified" )
			local f324_local1 = CoD.SafeGetModelValue( f324_arg1, "isBMClassified" )
			if f324_local0 and not f324_local1 then
				return false
			elseif not f324_local0 and f324_local1 then
				return true
			else
				local f324_local2 = Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f324_arg0, "stat" ) )
				local f324_local3 = Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f324_arg1, "stat" ) )
				if f324_local2 == f324_local3 then
					return Engine[0xED84C33EC5F01EA]( Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f324_arg0, "name" ) ) ) < Engine[0xED84C33EC5F01EA]( Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f324_arg1, "name" ) ) )
				else
					return f324_local3 < f324_local2
				end
			end
		end )
	end,
	getCount = function ( f325_arg0 )
		return #f325_arg0.weapons
	end,
	getItem = function ( f326_arg0, f326_arg1, f326_arg2 )
		return f326_arg1.weapons[f326_arg2]
	end
}
DataSources.CombatRecordBGBList = {
	prepare = function ( f327_arg0, f327_arg1, f327_arg2 )
		f327_arg1.bubbleGumBuffs = {}
		local f327_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f327_arg0 ), "combatRecordBGBListModel" )
		local f327_local1 = CoD.GetCombatRecordStats( f327_arg0 )
		local f327_local2 = CoD.GetCombatRecordComparisonStats( f327_arg0 )
		for f327_local3 = 0, 255, 1 do
			if Engine[0xB8891E0F105C51F]( f327_local3, CoD.GetCombatRecordMode() ) == "equippedbubblegumpack" and not CoD.BaseUtility.IsHiddenDLC( CoD.ProductBitFromId[Engine[0x708EB21A8740A71]( f327_local3, Enum[0x6EB546760F890D2][0x48CD0338EE0B3AE], Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] )] ) then
				local f327_local6 = Engine[0xA798E4552F5E872]( f327_local0, f327_local3 )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f327_local6, "name" ), Engine[0x6B7AC889104DED3]( f327_local3, Enum[0x6EB546760F890D2][0x48CD0338EE0B3AE], CoD.GetCombatRecordMode() ) )
				local f327_local7 = CoD.GetCombatRecordStatForPath( f327_local1, "ItemStats." .. f327_local3 .. ".stats.used" )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f327_local6, "itemIndex" ), f327_local3 )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f327_local6, "stat" ), f327_local7 )
				local f327_local8 = 0
				if f327_local2 then
					f327_local8 = CoD.GetCombatRecordStatForPath( f327_local2, "ItemStats." .. f327_local3 .. ".stats.used" )
				end
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f327_local6, "statComparison" ), f327_local8 )
				table.insert( f327_arg1.bubbleGumBuffs, f327_local6 )
			end
		end
		table.sort( f327_arg1.bubbleGumBuffs, function ( f328_arg0, f328_arg1 )
			local f328_local0 = Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f328_arg0, "stat" ) )
			local f328_local1 = Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f328_arg1, "stat" ) )
			if f328_local0 == f328_local1 then
				return Engine[0xED84C33EC5F01EA]( Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f328_arg0, "name" ) ) ) < Engine[0xED84C33EC5F01EA]( Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f328_arg1, "name" ) ) )
			else
				return f328_local1 < f328_local0
			end
		end )
	end,
	getCount = function ( f329_arg0 )
		return #f329_arg0.bubbleGumBuffs
	end,
	getItem = function ( f330_arg0, f330_arg1, f330_arg2 )
		return f330_arg1.bubbleGumBuffs[f330_arg2]
	end
}
DataSources.CombatRecordZMMapsList = {
	prepare = function ( f331_arg0, f331_arg1, f331_arg2 )
		f331_arg1.maps = {}
		local f331_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f331_arg0 ), "CombatRecordZMMapsList" )
		local f331_local1 = CoD.GetCombatRecordStats( f331_arg0 )
		for f331_local11, f331_local12 in pairs( CoD.MapUtility.MapsTable ) do
			if f331_local12.session_mode == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] and not CoD.BaseUtility.IsHiddenDLC( Engine[0x943893A16399DCF]( f331_local11 ) ) and f331_local1.PlayerStatsByMap and f331_local1.PlayerStatsByMap[f331_local11] then
				local f331_local5 = f331_local1.PlayerStatsByMap[f331_local11]
				local f331_local6 = Engine[0xA798E4552F5E872]( f331_local0, f331_local11 )
				local f331_local7 = 0
				local f331_local8 = 0
				local f331_local9 = 0
				local f331_local10 = 0
				f331_local7 = f331_local5.stats.HIGHEST_ROUND_REACHED.statValue:get()
				f331_local8 = f331_local5.stats.TOTAL_ROUNDS_SURVIVED.statValue:get()
				f331_local9 = f331_local5.stats.TOTAL_GAMES_PLAYED.statValue:get()
				f331_local10 = f331_local5.stats.TOTAL_DOWNS.statValue:get()
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f331_local6, "name" ), MapNameToLocalizedMapName( f331_local11 ) )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f331_local6, "highestRound" ), f331_local7 )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f331_local6, "avgDowns" ), math.floor( f331_local10 / math.max( 1, f331_local9 ) + 0.5 ) )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f331_local6, "avgRounds" ), math.floor( f331_local8 / math.max( 1, f331_local9 ) + 0.5 ) )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f331_local6, "stat" ), f331_local7 )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f331_local6, "previewImage" ), f331_local12.previewImage )
				table.insert( f331_arg1.maps, f331_local6 )
			end
		end
		table.sort( f331_arg1.maps, function ( f332_arg0, f332_arg1 )
			return Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f332_arg1, "stat" ) ) < Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f332_arg0, "stat" ) )
		end )
	end,
	getCount = function ( f333_arg0 )
		return #f333_arg0.maps
	end,
	getItem = function ( f334_arg0, f334_arg1, f334_arg2 )
		return f334_arg1.maps[f334_arg2]
	end
}
DataSources.CombatRecordCPPercentComplete = {
	getModel = function ( f335_arg0 )
		return nil
	end
}
DataSources.CombatRecordTotalWeaponAccuracy = {
	getModel = function ( f336_arg0 )
		local f336_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f336_arg0 ), "CombatRecordTotalWeaponAccuracy" )
		local f336_local1 = 0
		local f336_local2 = 0
		local f336_local3 = CoD.GetCombatRecordStats( f336_arg0 )
		for f336_local4 = 0, 255, 1 do
			if Engine[0x981A63C8A70462F]( f336_local4, CoD.GetCombatRecordMode() ) >= 0 then
				local f336_local7 = Engine[0xB8891E0F105C51F]( f336_local4, CoD.GetCombatRecordMode() )
				if f336_local7 == "primary" or f336_local7 == "secondary" or f336_local7 == "heroweapon" then
					f336_local1 = f336_local1 + CoD.GetCombatRecordStatForPath( f336_local3, "ItemStats." .. f336_local4 .. ".stats.shots" )
					f336_local2 = f336_local2 + CoD.GetCombatRecordStatForPath( f336_local3, "ItemStats." .. f336_local4 .. ".stats.hits" ) + 0.5 * CoD.GetCombatRecordStatForPath( f336_local3, "ItemStats." .. f336_local4 .. ".stats.headshots" )
				end
			end
		end
		local f336_local4 = 0
		if f336_local2 > 0 then
			f336_local4 = 100
		end
		if f336_local1 > 0 then
			f336_local4 = LUI.clamp( f336_local2 / f336_local1 * 100, 0, 100 )
		end
		if f336_local4 ~= f336_local4 then
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f336_local0, "percent" ), "-" )
		else
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f336_local0, "percent" ), string.format( "%.1f%%", f336_local4 ) )
		end
		return f336_local0
	end
}
DataSources.FavoriteSpecialist = {
	getModel = function ( f337_arg0 )
		local f337_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f337_arg0 ), "FavoriteSpecialist" )
		local f337_local1 = CoD.GetCombatRecordStats( f337_arg0 )
		local f337_local2 = CoD.PlayerRoleUtility.GetHeroList( Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] )
		local f337_local3 = 1
		local f337_local4 = 0
		local f337_local5 = 0x727CC00961724C1
		local f337_local6 = 0x0
		local f337_local7 = 0
		local f337_local8 = 0
		for f337_local12, f337_local13 in ipairs( f337_local2 ) do
			goto basicblock_2:
		end
		f337_local9 = nil
		if f337_local8 == 0 then
			f337_local9 = string.format( "%.2f", 0 )
		else
			f337_local9 = string.format( "%.2f", math.floor( f337_local7 / f337_local8 * 100 + 0.5 ) / 100 )
		end
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f337_local0, "displayString" ), Engine[0xF9F1239CFD921FE]( 0x1DD58AA20274399, Engine[0xED84C33EC5F01EA]( f337_local6 ), Engine[0xF9F1239CFD921FE]( Engine[0x6B7AC889104DED3]( f337_local4 ) ) ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f337_local0, "heroIndex" ), f337_local3 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f337_local0, "heroImage" ), f337_local5 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f337_local0, "heroName" ), Engine[0xF9F1239CFD921FE]( f337_local6 ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f337_local0, "itemIndex" ), f337_local4 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f337_local0, "killsPerUse" ), f337_local9 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f337_local0, "numKills" ), f337_local7 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f337_local0, "numUses" ), f337_local8 )
		return f337_local0
	end
}
DataSources.DeadOpsArcadeGlobal = {
	getModel = function ( f338_arg0 )
		local f338_local0 = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "DeadOpsArcadeGlobal" )
		Engine[0xA798E4552F5E872]( f338_local0, "redins" )
		Engine[0xA798E4552F5E872]( f338_local0, "countdown" )
		Engine[0xA798E4552F5E872]( f338_local0, "gbanner" )
		Engine[0xA798E4552F5E872]( f338_local0, "grgb1" )
		Engine[0xA798E4552F5E872]( f338_local0, "grgb2" )
		Engine[0xA798E4552F5E872]( f338_local0, "grgb3" )
		Engine[0xA798E4552F5E872]( f338_local0, "gtxt0" )
		Engine[0xA798E4552F5E872]( f338_local0, "gpr0" )
		Engine[0xA798E4552F5E872]( f338_local0, "gpr1" )
		Engine[0xA798E4552F5E872]( f338_local0, "gpr2" )
		Engine[0xA798E4552F5E872]( f338_local0, "gpr3" )
		Engine[0xA798E4552F5E872]( f338_local0, "level" )
		return f338_local0
	end
}
DataSources.DeadOpsArcadePlayers = {
	updateModelsForClient = function ( f339_arg0, f339_arg1 )
		local f339_local0 = Engine[0x40E824FE270E174]( Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "DeadOpsArcadePlayers" ), "player" .. f339_arg1 + 1 )
		if f339_local0 ~= nil then
			local f339_local1 = Engine[0xCBB96BC2E287F92]( f339_arg0, f339_arg1 )
			if f339_local1.playerName ~= nil and f339_local1.playerConnected then
				Engine[0x83C9B5DE1D9371]( Engine[0x40E824FE270E174]( f339_local0, "name" ), f339_local1.playerName )
			else
				Engine[0x83C9B5DE1D9371]( Engine[0x40E824FE270E174]( f339_local0, "name" ), "" )
			end
		end
	end,
	getModel = function ( f340_arg0 )
		local f340_local0 = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "DeadOpsArcadePlayers" )
		for f340_local1 = 1, 4, 1 do
			if Engine[0x40E824FE270E174]( f340_local0, "player" .. f340_local1 ) == nil then
				local f340_local4 = Engine[0xA798E4552F5E872]( f340_local0, "player" .. f340_local1 )
				Engine[0xA798E4552F5E872]( f340_local4, "name" )
				Engine[0xA798E4552F5E872]( f340_local4, "lives" )
				Engine[0xA798E4552F5E872]( f340_local4, "bombs" )
				Engine[0xA798E4552F5E872]( f340_local4, "boosts" )
				Engine[0xA798E4552F5E872]( f340_local4, "score" )
				Engine[0xA798E4552F5E872]( f340_local4, "multiplier" )
				Engine[0xA798E4552F5E872]( f340_local4, "xbar" )
				Engine[0xA798E4552F5E872]( f340_local4, "bulletbar" )
				Engine[0xA798E4552F5E872]( f340_local4, "bulletbar_rgb" )
				Engine[0xA798E4552F5E872]( f340_local4, "ribbon" )
				Engine[0xA798E4552F5E872]( f340_local4, "gpr_rgb" )
				Engine[0xA798E4552F5E872]( f340_local4, "generic_txt" )
				Engine[0xA798E4552F5E872]( f340_local4, "gpr" )
				Engine[0xA798E4552F5E872]( f340_local4, "gpr2" )
				Engine[0xA798E4552F5E872]( f340_local4, "weaplevel1" )
				Engine[0xA798E4552F5E872]( f340_local4, "weaplevel2" )
				Engine[0xA798E4552F5E872]( f340_local4, "respawn" )
				DataSources.DeadOpsArcadePlayers.updateModelsForClient( f340_arg0, f340_local1 - 1 )
			end
		end
		return f340_local0
	end
}
DataSources.PlayerList = {
	modelLinks = {
		playerName = "playerName",
		score = "playerScore",
		rankIcon = "playerRankIcon",
		rankNum = "rankNum",
		clanAbbrev = "clanAbbrev",
		clientNum = "clientNum",
		playerConnected = "playerConnected",
		team = "team",
		isBot = "isBot"
	},
	prepare = function ( f341_arg0, f341_arg1, f341_arg2 )
		f341_arg1.playerListInfoList = {}
		f341_arg1.playerListInfoOrder = {}
		local f341_local0 = Engine[0x4DF5CFBC1771947]( f341_arg0 )
		local f341_local1 = Engine[0xA798E4552F5E872]( f341_local0, "PlayerList" )
		local f341_local2 = 2
		local f341_local3 = Engine[0x761955642304848]( f341_arg0 )
		local f341_local4 = CoD.TeamUtility.GetTeamID( f341_arg0 )
		local f341_local5 = 0
		for f341_local6 = 0, Dvar[0x5A2E5EE8014325D]:get() - 1, 1 do
			local f341_local9 = Engine[0xCBB96BC2E287F92]( f341_arg0, f341_local6 )
			if not f341_local9.isBot then
				f341_local5 = f341_local5 + 1
			end
			local f341_local10 = Engine[0xA798E4552F5E872]( f341_local1, f341_local6 )
			for f341_local14, f341_local15 in pairs( DataSources.PlayerList.modelLinks ) do
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f341_local10, f341_local15 ), f341_local9[f341_local14] )
			end
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f341_local10, "objectiveIcon" ), "" )
			f341_arg1.playerListInfoList[f341_local6 + 1] = f341_local10
			if f341_local6 == Engine[0x761955642304848]( f341_arg0 ) then
				f341_arg1.playerListInfoOrder[1] = f341_local6 + 1
			else
				f341_arg1.playerListInfoOrder[f341_local2] = f341_local6 + 1
				f341_local2 = f341_local2 + 1
			end
		end
		if f341_local5 == 1 then
			f341_arg1.soloPlay = true
		else
			f341_arg1.soloPlay = nil
		end
		if f341_local4 then
			f341_arg1.ourTeam = f341_local4
		end
		local f341_local6 = function ( f342_arg0, f342_arg1 )
			DataSources.PlayerList.updateModelsForClient( f342_arg0, f341_arg1, f342_arg1 )
		end
		
		if not f341_arg1.playerConnectedSubscription then
			f341_arg1.playerConnectedSubscription = f341_arg1:subscribeToModel( Engine[0x40E824FE270E174]( f341_local0, "playerConnected" ), function ( model )
				local f343_local0 = Engine[0x614D394F6F9A18D]( model )
				if f343_local0 ~= nil then
					f341_local6( f341_arg0, f343_local0 )
				end
			end, false )
		end
		if not f341_arg1.playerDisconnectedSubscription then
			f341_arg1.playerDisconnectedSubscription = f341_arg1:subscribeToModel( Engine[0x40E824FE270E174]( f341_local0, "playerDisconnected" ), function ( model )
				local f344_local0 = Engine[0x614D394F6F9A18D]( model )
				if f344_local0 ~= nil then
					f341_local6( f341_arg0, f344_local0 )
				end
			end, false )
		end
		if not f341_arg1.hasScoreboardSubscriptions then
			f341_arg1.hasScoreboardSubscriptions = true
			for f341_local7 = 0, Dvar[0x5A2E5EE8014325D]:get() - 1, 1 do
				f341_arg1:subscribeToModel( Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "scoreboard.team1." .. f341_local7 .. ".clientNum" ), function ( model )
					local f345_local0 = Engine[0x614D394F6F9A18D]( model )
					if f345_local0 ~= nil then
						f341_local6( f341_arg0, f345_local0 )
					end
				end, false )
			end
		end
		if not f341_arg1.hasBotStatusSubscription then
			f341_arg1.hasBotStatusSubscription = f341_arg1:subscribeToModel( Engine[0x40E824FE270E174]( f341_local0, "playerBotStatusChanged" ), function ( model )
				local f346_local0 = Engine[0x614D394F6F9A18D]( model )
				if f346_local0 ~= nil then
					f341_local6( f341_arg0, f346_local0 )
				end
			end, false )
		end
	end,
	updateModelsForClient = function ( f347_arg0, f347_arg1, f347_arg2 )
		local f347_local0 = DataSources.PlayerList.getModelForPlayer( f347_arg0, f347_arg1, f347_arg2 )
		if f347_local0 ~= nil then
			local f347_local1 = Engine[0xCBB96BC2E287F92]( f347_arg0, f347_arg2 )
			for f347_local5, f347_local6 in pairs( DataSources.PlayerList.modelLinks ) do
				local f347_local7 = Engine[0x40E824FE270E174]( f347_local0, f347_local6 )
				if f347_local7 then
					Engine[0x83C9B5DE1D9371]( f347_local7, f347_local1[f347_local5] )
				end
			end
			f347_arg1:updateDataSource()
		end
	end,
	getCount = function ( f348_arg0 )
		local f348_local0 = 0
		if f348_arg0.soloPlay then
			return f348_local0
		end
		for f348_local6, f348_local7 in pairs( f348_arg0.playerListInfoList ) do
			local f348_local8 = Engine[0x40E824FE270E174]( f348_local7, "playerConnected" )
			if f348_local8 and Engine[0x614D394F6F9A18D]( f348_local8 ) ~= 0 then
				if CoD.isCampaign then
					local f348_local4 = Engine[0x40E824FE270E174]( f348_local7, "isBot" )
					local f348_local5 = Engine[0x40E824FE270E174]( f348_local7, "team" )
					if f348_local4 and f348_local5 and Engine[0x614D394F6F9A18D]( f348_local4 ) == false and Engine[0x614D394F6F9A18D]( f348_local5 ) == f348_arg0.ourTeam then
						f348_local0 = f348_local0 + 1
					end
				end
				f348_local0 = f348_local0 + 1
			end
		end
		if f348_local0 > 1 then
			return f348_local0
		end
		return 0
	end,
	getItem = function ( f349_arg0, f349_arg1, f349_arg2 )
		local f349_local0 = 0
		for f349_local1 = 1, Dvar[0x5A2E5EE8014325D]:get(), 1 do
			local f349_local4 = f349_arg1.playerListInfoList[f349_arg1.playerListInfoOrder[f349_local1]]
			local f349_local5 = Engine[0x40E824FE270E174]( f349_local4, "playerConnected" )
			if f349_local5 and Engine[0x614D394F6F9A18D]( f349_local5 ) ~= 0 then
				if CoD.isCampaign then
					local f349_local6 = Engine[0x40E824FE270E174]( f349_local4, "isBot" )
					local f349_local7 = Engine[0x40E824FE270E174]( f349_local4, "team" )
					if f349_local6 and f349_local7 and Engine[0x614D394F6F9A18D]( f349_local6 ) == false and Engine[0x614D394F6F9A18D]( f349_local7 ) == f349_arg1.ourTeam then
						f349_local0 = f349_local0 + 1
					end
				else
					f349_local0 = f349_local0 + 1
				end
				if f349_local0 == f349_arg2 then
					return f349_local4
				end
			end
		end
		DebugPrint( "WARNING: returning invalid playerListInfoList row" )
		return f349_arg1.playerListInfoList[f349_arg1.playerListInfoOrder[0]]
	end,
	getModelForPlayer = function ( f350_arg0, f350_arg1, f350_arg2 )
		return f350_arg1.playerListInfoList[f350_arg2 + 1]
	end
}
DataSources.PlayerListZM = {
	preparedForController = {},
	subscriptions = {},
	modelLinks = {
		playerName = "playerName",
		score = "playerScore",
		scoreVisible = "playerScoreVisible",
		rankIcon = "playerRankIcon",
		rankNum = "rankNum",
		clanAbbrev = "clanAbbrev",
		clientNum = "clientNum",
		playerConnected = "playerConnected",
		playerIsDowned = "playerIsDowned",
		zombiePlayerIcon = "zombiePlayerIcon",
		zombieInventoryIcon = "zombieInventoryIcon",
		playerScoreShown = "playerScoreShown",
		clientModel = "clientModel"
	},
	clientNumToArrayIndex = function ( f351_arg0, f351_arg1 )
		if f351_arg0 == f351_arg1 then
			return 0
		elseif f351_arg0 < f351_arg1 then
			return 1 + f351_arg0
		else
			return f351_arg0
		end
	end,
	prepare = function ( f352_arg0 )
		if not DataSources.PlayerListZM.preparedForController then
			DataSources.PlayerListZM.preparedForController = {}
		end
		if not DataSources.PlayerListZM.subscriptions[f352_arg0] then
			DataSources.PlayerListZM.subscriptions[f352_arg0] = LUI.UIElement.new()
		end
		DataSources.PlayerListZM.subscriptions[f352_arg0]:unsubscribeFromAllModels()
		DataSources.PlayerListZM.preparedForController[f352_arg0] = true
		local f352_local0 = Engine[0x4DF5CFBC1771947]( f352_arg0 )
		local f352_local1 = Engine[0xA798E4552F5E872]( f352_local0, "PlayerList" )
		local f352_local2 = Engine[0x761955642304848]( f352_arg0 )
		for f352_local3 = 0, Dvar[0x5A2E5EE8014325D]:get() - 1, 1 do
			local f352_local6 = DataSources.PlayerListZM.clientNumToArrayIndex( f352_local3, f352_local2 )
			local f352_local7 = Engine[0xCBB96BC2E287F92]( f352_arg0, f352_local3 )
			local f352_local8 = f352_local1:create( f352_local6 )
			for f352_local12, f352_local13 in pairs( DataSources.PlayerListZM.modelLinks ) do
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f352_local8, f352_local13 ), f352_local7[f352_local12] )
			end
			if CoD.ZombieUtility.InventoryIcon ~= nil then
				DataSources.PlayerListZM.subscriptions[f352_arg0]:subscribeToModel( f352_local0["zmInventory.player" .. f352_local3 .. "hasItem"], function ( model )
					if Engine[0x614D394F6F9A18D]( model ) == 1 then
						Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f352_local8, "zombieInventoryIcon" ), CoD.ZombieUtility.InventoryIcon )
					else
						Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f352_local8, "zombieInventoryIcon" ), "blacktransparent" )
					end
				end )
			else
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f352_local8, "zombieInventoryIcon" ), "blacktransparent" )
			end
			DataSources.PlayerListZM.subscriptions[f352_arg0]:subscribeToModel( Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "Clients." .. f352_local3 .. ".playerName" ), function ( model )
				local f354_local0 = Engine[0x614D394F6F9A18D]( model )
				if f354_local0 ~= nil then
					Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f352_local8, "playerName" ), f354_local0 )
				else
					Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f352_local8, "playerName" ), "" )
				end
			end )
			f352_local9 = Engine[0xA798E4552F5E872]( f352_local8, "clientModel" )
			f352_local9:set( Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "Clients." .. f352_local3 ) )
		end
		local f352_local3 = function ( f355_arg0, f355_arg1 )
			DataSources.PlayerListZM.updateModelsForClient( f355_arg0, f355_arg1 )
		end
		
		DataSources.PlayerListZM.subscriptions[f352_arg0]:subscribeToModel( f352_local0.playerConnected, function ( model )
			local f356_local0 = Engine[0x614D394F6F9A18D]( model )
			if f356_local0 ~= nil then
				f352_local3( f352_arg0, f356_local0 )
			end
		end, false )
		DataSources.PlayerListZM.subscriptions[f352_arg0]:subscribeToModel( f352_local0.playerDisconnected, function ( model )
			local f357_local0 = Engine[0x614D394F6F9A18D]( model )
			if f357_local0 ~= nil then
				f352_local3( f352_arg0, f357_local0 )
			end
		end, false )
	end,
	updateModelsForClient = function ( f358_arg0, f358_arg1 )
		local f358_local0 = DataSources.PlayerListZM.getModelForPlayer( f358_arg0, f358_arg1 )
		if f358_local0 ~= nil then
			local f358_local1 = Engine[0xCBB96BC2E287F92]( f358_arg0, f358_arg1 )
			for f358_local5, f358_local6 in pairs( DataSources.PlayerListZM.modelLinks ) do
				local f358_local7 = Engine[0x40E824FE270E174]( f358_local0, f358_local6 )
				if f358_local7 then
					Engine[0x83C9B5DE1D9371]( f358_local7, f358_local1[f358_local5] )
				end
			end
		end
	end,
	getModelForPlayer = function ( f359_arg0, f359_arg1 )
		local f359_local0 = Engine[0x761955642304848]( f359_arg0 )
		if f359_arg1 == f359_local0 then
			local f359_local1 = Engine[0x4DF5CFBC1771947]( f359_arg0 )
			return f359_local1.PlayerList.playerSelf
		else
			local f359_local1 = DataSources.PlayerListZM.clientNumToArrayIndex( f359_arg1, f359_local0 )
			local f359_local2 = Engine[0x4DF5CFBC1771947]( f359_arg0 )
			return f359_local2.PlayerList["player" .. f359_local1]
		end
	end,
	getModel = function ( f360_arg0 )
		if not DataSources.PlayerListZM.preparedForController or not DataSources.PlayerListZM.preparedForController[f360_arg0] then
			DataSources.PlayerListZM.prepare( f360_arg0 )
		end
		local f360_local0 = Engine[0x4DF5CFBC1771947]( f360_arg0 )
		return f360_local0:create( "PlayerList" )
	end
}
DataSources.EmblemLayerList = {
	createGroup = function ( f361_arg0, f361_arg1, f361_arg2, f361_arg3, f361_arg4 )
		local f361_local0 = f361_arg1
		local f361_local1 = f361_arg1
		if CoD.isPC then
			for f361_local2 = f361_arg1, 0, -1 do
				local f361_local5 = Engine[0xC6574A1949335C3]( f361_arg0, f361_local2, f361_arg4 )
				if f361_local5.groupIndex == f361_arg2 then
					f361_local0 = f361_local2
				end
			end
		else
			for f361_local2 = f361_arg1, f361_arg3 - 1, 1 do
				local f361_local5 = Engine[0xC6574A1949335C3]( f361_arg0, f361_local2, f361_arg4 )
				if f361_local5.groupIndex == f361_arg2 then
					f361_local1 = f361_local2
				end
			end
		end
		return {
			groupStartLayer = f361_local0,
			groupEndLayer = f361_local1,
			isGrouped = true
		}
	end,
	createLayer = function ( f362_arg0 )
		return {
			groupStartLayer = f362_arg0,
			groupEndLayer = f362_arg0,
			isGrouped = false
		}
	end,
	prepare = function ( f363_arg0, f363_arg1, f363_arg2 )
		if CoD.isPC then
			CoD.CraftUtility.EmblemEditor_PrepareEmblemListPC( f363_arg0, f363_arg1, f363_arg2 )
		else
			f363_arg1.emblemLayerListModel = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f363_arg0 ), "Emblem.EmblemLayerList" )
			local f363_local0 = CoD.GetCustomization( f363_arg0, "type" )
			f363_arg1.totalLayers = math.min( Engine[0xB3DF0B6F944FF42]( f363_arg0, f363_local0, CoD.perController[f363_arg0].totalLayers ) + 1, CoD.perController[f363_arg0].totalLayers )
			f363_arg1.itemInfo = {}
			f363_arg1.selectIndex = 1
			if CoD.perController[f363_arg0].selectedLayerIndex == nil then
				CoD.perController[f363_arg0].selectedLayerIndex = 0
			end
			local f363_local1 = 1
			local f363_local2 = 0
			while f363_local2 < f363_arg1.totalLayers do
				local f363_local3 = Engine[0xC6574A1949335C3]( f363_arg0, f363_local2, f363_local0 )
				if f363_local3.isGrouped == true then
					local f363_local4 = DataSources.EmblemLayerList.createGroup( f363_arg0, f363_local2, f363_local3.groupIndex, f363_arg1.totalLayers, f363_local0 )
					table.insert( f363_arg1.itemInfo, f363_local4 )
					if not CoD.perController[f363_arg0].selectEmblemGroupIndex and CoD.perController[f363_arg0].selectedLayerIndex <= f363_local4.groupEndLayer and f363_local2 <= CoD.perController[f363_arg0].selectedLayerIndex then
						f363_arg1.selectIndex = f363_local1
					end
					f363_local2 = f363_local4.groupEndLayer + 1
				else
					if not CoD.perController[f363_arg0].selectEmblemGroupIndex and CoD.perController[f363_arg0].selectedLayerIndex == f363_local2 then
						f363_arg1.selectIndex = f363_local1
					end
					table.insert( f363_arg1.itemInfo, DataSources.EmblemLayerList.createLayer( f363_local2 ) )
					f363_local2 = f363_local2 + 1
				end
				if f363_local3.groupIndex == CoD.perController[f363_arg0].selectEmblemGroupIndex then
					f363_arg1.selectIndex = #f363_arg1.itemInfo
				end
				f363_local1 = f363_local1 + 1
			end
		end
		CoD.perController[f363_arg0].selectEmblemGroupIndex = nil
	end,
	getCount = function ( f364_arg0 )
		return #f364_arg0.itemInfo
	end,
	getItem = function ( f365_arg0, f365_arg1, f365_arg2 )
		local f365_local0 = nil
		local f365_local1 = f365_arg1.itemInfo[f365_arg2].groupStartLayer
		local f365_local2 = f365_arg1.itemInfo[f365_arg2].groupEndLayer - f365_arg1.itemInfo[f365_arg2].groupStartLayer + 1
		if f365_arg1.itemInfo[f365_arg2].isGrouped then
			f365_local0 = tostring( f365_arg1.itemInfo[f365_arg2].groupStartLayer + 1 ) .. "-" .. tostring( f365_arg1.itemInfo[f365_arg2].groupEndLayer + 1 )
		else
			f365_local0 = tostring( f365_local1 + 1 )
		end
		local f365_local3 = Engine[0xA798E4552F5E872]( f365_arg1.emblemLayerListModel, "layer_" .. f365_local1 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f365_local3, "layerIndex" ), f365_local1 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f365_local3, "layerNumberString" ), f365_local0 )
		local f365_local4 = Engine[0xC6574A1949335C3]( f365_arg0, f365_local1, CoD.GetCustomization( f365_arg0, "type" ) )
		if f365_local4.iconID == CoD.CraftUtility.EMBLEM_INVALID_ID then
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f365_local3, "layerName" ), Engine[0xF9F1239CFD921FE]( 0x584A78FB1E14B17 ) )
		else
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f365_local3, "layerName" ), Engine[0xF9F1239CFD921FE]( 0xFFF4AB78EF36559, f365_local1 + 1 ) )
		end
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f365_local3, "iconID" ), f365_local4.iconID )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f365_local3, "isLinked" ), f365_local4.isLinked )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f365_local3, "isGrouped" ), f365_local4.isGrouped )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f365_local3, "groupIndex" ), f365_local4.groupIndex )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f365_local3, "layerAndGroupIndex" ), f365_local1 .. " " .. f365_local4.groupIndex )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f365_local3, "groupLayerCount" ), f365_local2 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f365_local3, "topBottomText" ), "" )
		local f365_local5 = function ( f366_arg0, f366_arg1 )
			return CoD.isPC and f366_arg0 == #f366_arg1.itemInfo
		end
		
		local f365_local6 = function ( f367_arg0, f367_arg1 )
			local f367_local0
			if not CoD.isPC or f367_arg0 ~= 2 or f367_arg1 == CoD.perController[f365_arg0].totalLayers then
				f367_local0 = CoD.isPC
				if f367_local0 then
					if f367_arg0 ~= 1 or f367_arg1 ~= CoD.perController[f365_arg0].totalLayers then
						f367_local0 = false
					else
						f367_local0 = true
					end
				end
			else
				f367_local0 = true
			end
			return f367_local0
		end
		
		local f365_local7 = CoD.CraftUtility.GetEmblemEditorProperties( f365_arg0, "layersUsed" )
		if f365_local5( f365_arg2, f365_arg1 ) or not CoD.isPC and f365_arg2 == 1 then
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f365_local3, "topBottomText" ), Engine[0xF9F1239CFD921FE]( 0x266714F64BE6ADB ) )
		elseif f365_local6( f365_arg2, f365_local7 ) or not CoD.isPC and f365_arg2 == #f365_arg1.itemInfo and f365_local7 == CoD.perController[f365_arg0].totalLayers then
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f365_local3, "topBottomText" ), Engine[0xF9F1239CFD921FE]( 0x91B0972BC971363 ) )
		elseif f365_local6( f365_arg2, f365_local7 ) or not CoD.isPC and f365_arg2 == #f365_arg1.itemInfo - 1 and f365_local7 ~= CoD.perController[f365_arg0].totalLayers then
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f365_local3, "topBottomText" ), Engine[0xF9F1239CFD921FE]( 0x91B0972BC971363 ) )
		else
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f365_local3, "topBottomText" ), "" )
		end
		return f365_local3
	end,
	getCustomPropertiesForItem = function ( f368_arg0, f368_arg1 )
		if f368_arg0.selectIndex == f368_arg1 then
			return {
				selectIndex = true
			}
		else
			
		end
	end,
	swapItemInfo = function ( f369_arg0, f369_arg1, f369_arg2, f369_arg3 )
		if f369_arg2 and f369_arg3 and f369_arg1 then
			f369_arg2:setModel( nil, f369_arg0 )
			f369_arg3:setModel( nil, f369_arg0 )
			local f369_local0 = f369_arg2.gridInfoTable.zeroBasedIndex + 1
			local f369_local1 = f369_arg3.gridInfoTable.zeroBasedIndex + 1
			local f369_local2 = f369_arg1.itemInfo[f369_local0]
			local f369_local3 = f369_arg1.itemInfo[f369_local1]
			local f369_local4 = f369_local2.groupEndLayer - f369_local2.groupStartLayer
			f369_local2.groupEndLayer = f369_local2.groupStartLayer + f369_local3.groupEndLayer - f369_local3.groupStartLayer
			f369_local3.groupStartLayer = f369_local2.groupEndLayer + 1
			f369_local3.groupEndLayer = f369_local3.groupStartLayer + f369_local4
			local f369_local5 = f369_local2.isGrouped
			f369_local2.isGrouped = f369_local3.isGrouped
			f369_local3.isGrouped = f369_local5
			f369_arg2:setModel( DataSources.EmblemLayerList.getItem( f369_arg0, f369_arg1, f369_local0 ), f369_arg0 )
			f369_arg3:setModel( DataSources.EmblemLayerList.getItem( f369_arg0, f369_arg1, f369_local1 ), f369_arg0 )
		end
	end
}
DataSources.EmblemMaterialList = {
	prepare = function ( f370_arg0, f370_arg1, f370_arg2 )
		f370_arg1.emblemMaterialList = {}
		local f370_local0 = 0
		for f370_local1 = 1, #CoD.CraftUtility.EmblemMaterialCategory, 1 do
			local f370_local4 = CoD.CraftUtility.EmblemMaterialCategory[f370_local1]
			local f370_local5 = f370_local4.category
			if f370_local4.type ~= "camo" or Dvar[0x8B4EC18019A2C9A]:get() then
				local f370_local6 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f370_arg0 ), "Emblem.EmblemMaterialList" )
				local f370_local7 = Engine[0x566AF071BD06635]( f370_arg0, f370_local5 )
				for f370_local8 = 0, f370_local7 - 1, 1 do
					local f370_local11 = Engine[0xA798E4552F5E872]( f370_local6, "emblemMaterial_" .. f370_local0 )
					local f370_local12 = Engine[0xF82B3E76E65EF74]( f370_arg0, f370_local5, f370_local8 )
					Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f370_local11, "materialID" ), f370_local12 )
					local f370_local13 = Engine[0xF13E0433809ECDF]( f370_local12 )
					Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f370_local11, "materialName" ), f370_local13 )
					local f370_local14 = false
					if f370_local5 == CoD.CraftUtility.EmblemBlackMarketEmblemCategory then
						f370_local14 = CoD.BlackMarketUtility.IsItemLocked( f370_arg0, f370_local13 )
					end
					Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f370_local11, "isBMClassified" ), f370_local14 )
					if not f370_local14 then
						table.insert( f370_arg1.emblemMaterialList, f370_local11 )
						f370_local0 = f370_local0 + 1
					end
				end
			end
		end
	end,
	getCount = function ( f371_arg0 )
		return #f371_arg0.emblemMaterialList
	end,
	getItem = function ( f372_arg0, f372_arg1, f372_arg2 )
		return f372_arg1.emblemMaterialList[f372_arg2]
	end
}
DataSources.EmblemColorList = {
	prepare = function ( f373_arg0, f373_arg1, f373_arg2 )
		f373_arg1.emblemColorList = {}
		if not CoD.CraftUtility.EmblemColorList then
			CoD.CraftUtility.EmblemColorList = CoD.CACUtility.GetEmblemColorList( f373_arg0 )
		end
		f373_arg1.emblemColorList = CoD.CraftUtility.EmblemColorList
	end,
	getCount = function ( f374_arg0 )
		return #f374_arg0.emblemColorList
	end,
	getItem = function ( f375_arg0, f375_arg1, f375_arg2 )
		return f375_arg1.emblemColorList[f375_arg2]
	end
}
DataSources.EmblemSelectedLayerColor = {
	getModel = function ( f376_arg0 )
		local f376_local0 = Engine[0xE14A34F1BA3A3FA]( f376_arg0 )
		local f376_local1 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f376_arg0 ), "Emblem.EmblemSelectedLayerColor" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f376_local1, "color" ), CoD.ColorUtility.ConvertColor( f376_local0.red, f376_local0.green, f376_local0.blue ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f376_local1, "red" ), f376_local0.red * CoD.CraftUtility.EMBLEM_MAX_COLOR_COMPONENT_VALUE )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f376_local1, "green" ), f376_local0.green * CoD.CraftUtility.EMBLEM_MAX_COLOR_COMPONENT_VALUE )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f376_local1, "blue" ), f376_local0.blue * CoD.CraftUtility.EMBLEM_MAX_COLOR_COMPONENT_VALUE )
		return f376_local1
	end
}
DataSources.EmblemSelectedLayerColor1 = {
	getModel = function ( f377_arg0 )
		local f377_local0 = Engine[0xB54A6BF70F51F1]( f377_arg0 )
		local f377_local1 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f377_arg0 ), "Emblem.EmblemSelectedLayerColor1" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f377_local1, "color" ), CoD.ColorUtility.ConvertColor( f377_local0.red, f377_local0.green, f377_local0.blue ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f377_local1, "red" ), f377_local0.red * CoD.CraftUtility.EMBLEM_MAX_COLOR_COMPONENT_VALUE )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f377_local1, "green" ), f377_local0.green * CoD.CraftUtility.EMBLEM_MAX_COLOR_COMPONENT_VALUE )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f377_local1, "blue" ), f377_local0.blue * CoD.CraftUtility.EMBLEM_MAX_COLOR_COMPONENT_VALUE )
		return f377_local1
	end
}
DataSources.EmblemSelectedLayerEdittingColor = {
	getModel = function ( f378_arg0 )
		local f378_local0 = CoD.CraftUtility.GetEmblemEditorProperties( f378_arg0, "isGradientMode" )
		local f378_local1 = CoD.CraftUtility.GetEmblemEditorProperties( f378_arg0, "colorNum" )
		if f378_local0 ~= nil and f378_local1 ~= nil and f378_local0 == 1 and f378_local1 == Enum[0x5B86390D74F3997][0x2EFDC03AB2AE37A] then
			return DataSources.EmblemSelectedLayerColor1.getModel( f378_arg0 )
		else
			return DataSources.EmblemSelectedLayerColor.getModel( f378_arg0 )
		end
	end
}
DataSources.EmblemSelectedLayerNoColor = {
	getModel = function ( f379_arg0 )
		local f379_local0 = CoD.CraftUtility.GetEmblemEditorProperties( f379_arg0, "isGradientMode" )
		local f379_local1 = CoD.CraftUtility.GetEmblemEditorProperties( f379_arg0, "colorNum" )
		if f379_local0 ~= nil and f379_local1 ~= nil and f379_local0 == 1 and f379_local1 == Enum[0x5B86390D74F3997][0x2EFDC03AB2AE37A] then
			return DataSources.EmblemSelectedLayerColor.getModel( f379_arg0 )
		else
			return DataSources.EmblemSelectedLayerColor1.getModel( f379_arg0 )
		end
	end
}
DataSources.EmblemSelectedLayerProperties = {
	getModel = function ( f380_arg0 )
		local f380_local0 = Engine[0xB6B1F4C83291D74]()
		local f380_local1 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f380_arg0 ), "Emblem.EmblemSelectedLayerProperties" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f380_local1, "xposition" ), f380_local0.xposition )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f380_local1, "yposition" ), f380_local0.yposition )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f380_local1, "xscale" ), f380_local0.xscale )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f380_local1, "yscale" ), f380_local0.yscale )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f380_local1, "rotation" ), f380_local0.rotation )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f380_local1, "opacity0" ), f380_local0.opacity0 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f380_local1, "opacity1" ), f380_local0.opacity1 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f380_local1, "gradient_angle" ), f380_local0.gradient_angle )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f380_local1, "gradient_type" ), f380_local0.gradient_type )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f380_local1, "gradient_fill" ), f380_local0.gradient_fill )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f380_local1, "gradient_thickness" ), f380_local0.gradient_thickness )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f380_local1, "material_angle" ), f380_local0.material_angle )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f380_local1, "material_xscale" ), f380_local0.material_xscale )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f380_local1, "material_yscale" ), f380_local0.material_yscale )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f380_local1, "max_opacity" ), math.max( f380_local0.opacity0, f380_local0.opacity1 ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f380_local1, "blend" ), f380_local0.blend )
		return f380_local1
	end
}
DataSources.EmblemProperties = {
	getModel = function ( f381_arg0 )
		local f381_local0 = Enum[0xC594B064FEDD0D6][0x8F7F4A0A6A3678B]
		local f381_local1 = Enum[0x3ED85BA45B1D650][0x965B8C6712E976F]
		local f381_local2 = Engine[0x45EDC308108CECA]( f381_arg0 )
		local f381_local3 = Engine[0xC1E25063F05BF02]( f381_arg0 )
		local f381_local4 = CoD.perController[f381_arg0].totalLayers or 0
		local f381_local5 = CoD.GetCustomization( f381_arg0, "type" )
		local f381_local6 = Engine[0xB3DF0B6F944FF42]( f381_arg0, f381_local5, f381_local4 )
		local f381_local7 = Engine[0xF9F1239CFD921FE]( 0x8AD837A6ECA017, f381_local6, f381_local4 )
		local f381_local8 = Engine[0x1D315C7C5787B3E]( f381_arg0, f381_local5 )
		local f381_local9 = CoD.perController[f381_arg0].totalGroups or 0
		local f381_local10 = Engine[0xEFC9BADA5A97B38]( f381_arg0, f381_local5 )
		local f381_local11 = Engine[0xF9F1239CFD921FE]( 0x8AD837A6ECA017, f381_local10, f381_local9 )
		local f381_local12 = Engine[0x40E824FE270E174]( Engine[0x4DF5CFBC1771947]( f381_arg0 ), "Emblem.EmblemProperties" )
		if not f381_local12 then
			f381_local12 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f381_arg0 ), "Emblem.EmblemProperties" )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f381_local12, "layersUsed" ), f381_local6 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f381_local12, "layersAvailable" ), f381_local4 - f381_local6 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f381_local12, "totalLayers" ), f381_local4 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f381_local12, "colorMode" ), f381_local0 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f381_local12, "editorMode" ), f381_local1 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f381_local12, "scaleMode" ), f381_local2 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f381_local12, "materialScaleMode" ), f381_local3 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f381_local12, "layersUsedFraction" ), f381_local7 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f381_local12, "groupsUsed" ), f381_local10 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f381_local12, "groupsAvailable" ), f381_local9 - f381_local10 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f381_local12, "totalGroups" ), f381_local9 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f381_local12, "groupsUsedFraction" ), f381_local11 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f381_local12, "isClipboardEmpty" ), CoD.CraftUtility.EMBLEM_CLIPBOARDSTATE.EMPTY )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f381_local12, "addDecalMode" ), CoD.CraftUtility.EMBLEM_ADDDECAL.REPLACE )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f381_local12, "isGradientMode" ), 0 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f381_local12, "colorNum" ), Enum[0x5B86390D74F3997][0xE5C90AB2E168111] )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f381_local12, "isColor0NoColor" ), 0 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f381_local12, "isColor1NoColor" ), 0 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f381_local12, "linkedLayerCount" ), f381_local8 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f381_local12, "selectedDecalID" ), 0 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f381_local12, "colorContainerState" ), CoD.CraftUtility.COLOR_CONTAINER_STATE.COLOR_SWATCH )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f381_local12, "selectedLayerIndex" ), 0 )
		end
		return f381_local12
	end
}
DataSources.SlotCustomization = {
	getModel = function ( f382_arg0 )
		local f382_local0 = Engine[0x40E824FE270E174]( Engine[0x4DF5CFBC1771947]( f382_arg0 ), "SlotCustomization" )
		if not f382_local0 then
			f382_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f382_arg0 ), "SlotCustomization" )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f382_local0, "type" ), Enum[0x63E5ADF9D95FC86][0x979B4C08E9D67B2] )
		end
		return f382_local0
	end
}
DataSources.Customization = {
	getModel = function ( f383_arg0 )
		local f383_local0 = Engine[0x40E824FE270E174]( Engine[0x4DF5CFBC1771947]( f383_arg0 ), "Customization" )
		if not f383_local0 then
			f383_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f383_arg0 ), "Customization" )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f383_local0, "weapon_index" ), 20 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f383_local0, "type" ), Enum[0x63E5ADF9D95FC86][0x979B4C08E9D67B2] )
		end
		return f383_local0
	end
}
DataSources.StoreCategoryList = ListHelper_SetupDataSource( "Store.CategoryList", function ( f384_arg0 )
	local f384_local0 = {}
	local f384_local1 = Engine[0xE4D00AFB9B9073C]()
	if IsCommerceEnabledOnPC() then
		local f384_local2 = Engine[0xE78C83C300F9368]()
		for f384_local3 = 1, #f384_local1, 1 do
			local f384_local6 = f384_local1[f384_local3]
			local f384_local7 = "CoD.Store_NonFeaturedFrame"
			if f384_local6.category == "featured" then
				f384_local7 = "CoD.Store_FeaturedFrame"
			end
			local f384_local8 = true
			if CoD.isPC then
				if f384_local2 and f384_local6.category == "cross_title" then
					f384_local8 = false
				else
					f384_local8 = true
				end
			end
			if f384_local8 then
				table.insert( f384_local0, {
					models = {
						category = f384_local6.category,
						categoryNameRefXhash = f384_local6.categoryNameRefHash,
						frameWidget = f384_local7,
						imageName = f384_local6.imageName
					}
				} )
			end
		end
	end
	return f384_local0
end )
DataSources.StoreProductList = ListHelper_SetupDataSource( "Store.ProductList", function ( f385_arg0, f385_arg1 )
	local f385_local0 = {}
	local f385_local1 = CoD.perController[f385_arg0].selectedStoreCategory
	if f385_local1 then
		local f385_local2 = Engine[0x3CE7A3C8E5BE0AD]( f385_arg0, f385_local1 )
		local f385_local3 = 6
		if f385_local3 < #f385_local2 and #f385_local2 ~= 0 then
			f385_local3 = #f385_local2
		end
		local f385_local4 = f385_arg1.menu._focusProduct
		local f385_local5 = 0
		local f385_local6 = 1
		while f385_local5 < f385_local3 do
			local f385_local7 = f385_local2[f385_local6]
			if not f385_local7 then
				f385_local7 = {
					name = "",
					price = "",
					desc = "",
					onOverDesc = "",
					productID = "",
					skuID = "",
					previewImage = 0x0,
					productImage = 0x0,
					purchasestatus = 0,
					availability = Enum[0xE8E23A7B8B67FF6][0x1D42433730A860E],
					serviceLabel = 0
				}
			end
			f385_local6 = f385_local6 + 1
			local f385_local8 = true
			if f385_local7.productNameHash == 0xA93E67FF169D892 and IsDurango() and (not Engine[0x824BB47C395DF15]( Enum[0xAA0EE37DF15F5A8][0xDC77F190F9D7964] ) or not Engine[0x824BB47C395DF15]( Enum[0xAA0EE37DF15F5A8][0xFDE0E0CF4EA7FAC] )) then
				f385_local8 = false
			end
			if f385_local7.productNameHash == 0x617848314938AB9 and f385_local7.purchasestatus == Enum[0x916B410FF0AAEC][0xC3D2ED4AABEAE6C] then
				f385_local8 = false
			end
			if f385_local8 and f385_local7.blackMarketName ~= 0xC78328FF7303B63 then
				if f385_local7.productID == "46750" then
					f385_local7.onOverDesc = Engine[0xF9F1239CFD921FE]( 0x5E93E5F33B86666 )
				end
				f385_local5 = f385_local5 + 1
				table.insert( f385_local0, {
					models = {
						name = f385_local7.name,
						price = f385_local7.price,
						desc = f385_local7.desc,
						onOverDesc = f385_local7.onOverDesc,
						productID = f385_local7.productID,
						skuID = f385_local7.skuID,
						previewImage = f385_local7.previewImage,
						productImage = f385_local7.productImage,
						purchasestatus = f385_local7.purchasestatus,
						availability = f385_local7.availability,
						serviceLabel = f385_local7.serviceLabel,
						large = false,
						productNameHash = f385_local7.productNameHash
					},
					properties = {
						rowSpan = 1,
						columnSpan = 1,
						selectIndex = f385_local4 and f385_local4 == f385_local7.metadata
					}
				} )
			end
		end
	end
	return f385_local0
end )
DataSources.CoDPointStoreList = ListHelper_SetupDataSource( "CoDPointStoreList", function ( f386_arg0 )
	local f386_local0 = {}
	local f386_local1 = Engine[0x3CE7A3C8E5BE0AD]( f386_arg0, "codpoints" )
	if #f386_local1 == 0 then
		return f386_local0
	end
	for f386_local2 = 1, #f386_local1, 1 do
		local f386_local5 = f386_local1[f386_local2]
		local f386_local6 = f386_local5.blackMarketName or 0x0
		local f386_local7 = true
		local f386_local8 = CoD.StoreUtility.GetExperimentModifier( f386_arg0, "bmCPSKUAvailability" )
		if f386_local8 == "1" and f386_local5.productNameHash == 0xD0E7EAD3C0B85BC then
			f386_local7 = false
		elseif f386_local8 == "2" and (f386_local5.productNameHash == 0xD0E7EAD3C0B85BC or f386_local5.productNameHash == 0x5AB63AD3838ECD1) then
			f386_local7 = false
		end
		if f386_local5.productNameHash == 0x5A5C9B94113E3C8 then
			f386_local7 = false
		end
		if f386_local7 then
			table.insert( f386_local0, {
				models = {
					name = f386_local6,
					fullName = f386_local5.name,
					price = f386_local5.price,
					desc = f386_local5.blackMarketDesc,
					onOverDesc = "",
					productID = f386_local5.productID,
					skuID = f386_local5.skuID,
					previewImage = f386_local5.blackMarketImage,
					productImage = f386_local5.productImage,
					purchasestatus = f386_local5.purchasestatus,
					availability = f386_local5.availability,
					serviceLabel = f386_local5.serviceLabel
				}
			} )
		end
	end
	return f386_local0
end )
DataSources.StoreFeaturedProductList = ListHelper_SetupDataSource( "Store.FeaturedProductList", function ( f387_arg0, f387_arg1 )
	local f387_local0 = {}
	local f387_local1 = CoD.perController[f387_arg0].selectedStoreCategory
	if f387_local1 then
		local f387_local2 = Engine[0x3CE7A3C8E5BE0AD]( f387_arg0, f387_local1 )
		if CoD.isPC then
			if Engine[0x5405A6484A88367]() then
				local f387_local3 = 3
				local f387_local4 = "47010"
				local f387_local5 = {}
				for f387_local9, f387_local10 in pairs( f387_local2 ) do
					if f387_local10.productID == f387_local4 and f387_local10.availability == Enum[0xE8E23A7B8B67FF6][0x1D42433730A860E] then
						table.insert( f387_local5, 1, f387_local10 )
						break
					end
				end
				if #f387_local5 < f387_local3 then
					for f387_local9, f387_local10 in pairs( f387_local2 ) do
						if f387_local10.availability == Enum[0xE8E23A7B8B67FF6][0x1D42433730A860E] then
							table.insert( f387_local5, f387_local10 )
						end
						if #f387_local5 == f387_local3 then
							break
						end
					end
				end
				f387_local2 = f387_local5
			else
				table.sort( f387_local2, function ( f388_arg0, f388_arg1 )
					return f388_arg1.availability < f388_arg0.availability
				end )
			end
		end
		local f387_local3 = 3
		local f387_local4 = f387_local3
		if f387_local4 < #f387_local2 and #f387_local2 ~= 0 then
			f387_local4 = #f387_local2
		end
		local f387_local5 = f387_arg1.menu._focusProduct
		local f387_local6 = false
		local f387_local7 = 0
		for f387_local8 = 1, f387_local4, 1 do
			local f387_local11 = f387_local2[f387_local8]
			if not f387_local11 then
				f387_local11 = {
					name = "",
					price = "",
					desc = "",
					onOverDesc = "",
					productID = "",
					skuID = "",
					previewImage = 0x0,
					productImage = 0x0,
					purchasestatus = 0,
					availability = Enum[0xE8E23A7B8B67FF6][0x1D42433730A860E],
					serviceLabel = 0
				}
			end
			local f387_local12 = true
			if f387_local11.productNameHash == 0xA93E67FF169D892 and IsDurango() and (not Engine[0x824BB47C395DF15]( Enum[0xAA0EE37DF15F5A8][0xDC77F190F9D7964] ) or not Engine[0x824BB47C395DF15]( Enum[0xAA0EE37DF15F5A8][0xFDE0E0CF4EA7FAC] )) then
				f387_local12 = false
			end
			if f387_local11.productNameHash == 0x617848314938AB9 and f387_local11.purchasestatus == Enum[0x916B410FF0AAEC][0xC3D2ED4AABEAE6C] then
				f387_local12 = false
			end
			if f387_local11.availability == Enum[0xE8E23A7B8B67FF6][0x486D7E458864E50] then
				f387_local12 = false
			end
			local f387_local13 = false
			if f387_local12 == true and f387_local6 == false then
				f387_local13 = true
				f387_local6 = true
			end
			if f387_local12 and f387_local11.blackMarketName ~= 0xC78328FF7303B63 then
				if f387_local11.productID == "46750" then
					f387_local11.onOverDesc = Engine[0xF9F1239CFD921FE]( 0x5E93E5F33B86666 )
				end
				if f387_local7 ~= f387_local3 then
					f387_local7 = f387_local7 + 1
					local f387_local14 = table.insert
					local f387_local15 = f387_local0
					local f387_local16 = {
						models = {
							name = f387_local11.name,
							price = f387_local11.price,
							desc = f387_local11.desc,
							onOverDesc = f387_local11.onOverDesc,
							productID = f387_local11.productID,
							skuID = f387_local11.skuID,
							previewImage = f387_local11.previewImage,
							productImage = f387_local11.productImage,
							purchasestatus = f387_local11.purchasestatus,
							availability = f387_local11.availability,
							serviceLabel = f387_local11.serviceLabel,
							large = f387_local13,
							productNameHash = f387_local11.productNameHash
						}
					}
					local f387_local17 = {}
					local f387_local18
					if f387_local13 then
						f387_local18 = 2
						if not f387_local18 then
						
						else
							f387_local17.rowSpan = f387_local18
							if f387_local13 then
								f387_local18 = 2
								if not f387_local18 then
								
								else
									f387_local17.columnSpan = f387_local18
									f387_local17.selectIndex = f387_local5 and f387_local5 == f387_local11.metadata
									f387_local16.properties = f387_local17
									f387_local14( f387_local15, f387_local16 )
								end
							end
							f387_local18 = 1
						end
					end
					f387_local18 = 1
				end
			end
		end
	end
	return f387_local0
end )
DataSourceHelpers.PerControllerDataSourceSetup( "StoreRoot", "StoreRoot", function ( f389_arg0, f389_arg1 )
	if not f389_arg0.ready then
		local f389_local0 = f389_arg0:create( "ready" )
		f389_local0:set( false )
	end
	f389_arg0:create( "storeSource" )
	f389_arg0:create( "actionSource" )
	f389_arg0:create( "isCategoryListInFocus" )
end, false )
DataSources.ChooseClassClients = ListHelper_SetupDataSource( "ChooseClassClients", function ( f390_arg0 )
	local f390_local0 = {}
	local f390_local1 = 1
	local f390_local2 = Engine[0x40E824FE270E174]( Engine[0x4DF5CFBC1771947]( f390_arg0 ), "ChooseClassCPClientMenu" )
	if f390_local2 then
		local f390_local3 = Engine[0x40E824FE270E174]( f390_local2, "numActiveClients" )
		if f390_local3 then
			f390_local1 = Engine[0x614D394F6F9A18D]( f390_local3 )
		end
	end
	for f390_local3 = 1, f390_local1, 1 do
		table.insert( f390_local0, {
			models = {
				clientIndex = f390_local3
			}
		} )
	end
	return f390_local0
end )
DataSources.ChooseClassList = {
	prepare = function ( f391_arg0, f391_arg1, f391_arg2 )
		f391_arg1.customClassList = {}
		local f391_local0 = CoD.CACUtility.GetCustomClassCount( f391_arg0 )
		local f391_local1 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f391_arg0 ), "CustomClassList" )
		f391_local1:create( "equippedItemsChanged" )
		local f391_local2 = f391_local1:create( "weaponPersonalizationUpdated" )
		f391_local2:set( false )
		f391_local2 = Engine[0x3EAC408F958FF05]()
		if f391_arg1.menu and CoD.BaseUtility.GetMenuSessionMode( f391_arg1.menu ) then
			f391_local2 = CoD.BaseUtility.GetMenuSessionMode( f391_arg1.menu )
		end
		local f391_local3 = CoD.CACUtility.GetSelectedCustomClass( f391_arg0, f391_local2 )
		local f391_local4 = function ( f392_arg0, f392_arg1 )
			local f392_local0 = {
				models = f391_local1:create( "class" .. f392_arg0 )
			}
			CoD.CACUtility.GetCustomClassModel( f391_arg0, f392_arg1, f392_local0.models, nil, f391_local2 )
			f392_local0.properties = {
				classNum = f392_arg1,
				selectIndex = f391_local3 == f392_arg1
			}
			return f392_local0
		end
		
		for f391_local5 = 1, f391_local0, 1 do
			local f391_local8 = f391_local5 - 1
			local f391_local9 = CoD.CACUtility.GetClassesUnlockableItemUnlockInfo( f391_local8, "featureItemIndex" )
			if not f391_arg1.menu._excludeLockedClasses or not f391_local9 or not CoD.CACUtility.IsProgressionEnabled( f391_local2 ) or not Engine[0x191C1637A229078]( f391_arg0, f391_local9, f391_local2 ) then
				table.insert( f391_arg1.customClassList, f391_local4( f391_local5, f391_local8 ) )
			end
		end
	end,
	getCount = function ( f393_arg0 )
		return #f393_arg0.customClassList
	end,
	getItem = function ( f394_arg0, f394_arg1, f394_arg2 )
		return f394_arg1.customClassList[f394_arg2].models
	end,
	getCustomPropertiesForItem = function ( f395_arg0, f395_arg1 )
		return f395_arg0.customClassList[f395_arg1].properties
	end
}
DataSources.ChooseClass_TinyLoadout = {
	prepareModelForIndex = function ( f396_arg0, f396_arg1, f396_arg2, f396_arg3, f396_arg4 )
		local f396_local0 = nil
		if CanUseSharedLoadouts( f396_arg3 ) then
			local f396_local1 = Engine[0x40E824FE270E174]( Engine[0x4DF5CFBC1771947]( f396_arg3 ), "ChooseClassCPClientMenu" )
			if f396_local1 then
				local f396_local2 = Engine[0x40E824FE270E174]( f396_local1, "selectedClientIndex" )
				if f396_local2 then
					local f396_local3 = Engine[0x40E824FE270E174]( f396_local1, "client" .. Engine[0x614D394F6F9A18D]( f396_local2 ) )
					if f396_local3 then
						f396_local0 = Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f396_local3, "xuid" ) )
					end
				end
			end
		end
		local f396_local1 = f396_arg0:create( "class" .. f396_arg1 )
		CoD.CACUtility.GetCustomClassModel( f396_arg3, f396_arg2, f396_local1, f396_local0, f396_arg4 )
		local f396_local2 = f396_local1:create( "classNumber" )
		f396_local2:set( f396_arg2 )
		return f396_local1
	end,
	prepare = function ( f397_arg0, f397_arg1, f397_arg2 )
		local f397_local0 = Engine[0x3EAC408F958FF05]()
		if f397_arg1.menu and CoD.BaseUtility.GetMenuSessionMode( f397_arg1.menu ) then
			f397_local0 = CoD.BaseUtility.GetMenuSessionMode( f397_arg1.menu )
		end
		local f397_local1 = CoD.TeamUtility.GetTeamID( f397_arg0 )
		local f397_local2 = Engine[0x4DF5CFBC1771947]( f397_arg0 )
		local f397_local3 = f397_local2:create( "CustomClassListTinyLoadout" )
		f397_local3:create( "equippedItemsChanged" )
		local f397_local4 = f397_local3.prepared
		if not f397_local4 then
			f397_local4 = f397_local3:create( "prepared" )
			f397_local4:set( -1 )
		end
		local f397_local5 = false
		local f397_local6 = -1
		local f397_local7 = f397_local2.classSetValue
		if f397_local7 then
			f397_local6 = f397_local7:get()
			if f397_local6 ~= CoD.PrestigeUtility.ChooseClassSets.Default and f397_local6 ~= CoD.PrestigeUtility.ChooseClassSets.Custom then
				f397_local5 = false
			else
				f397_local5 = true
			end
		end
		f397_arg1.customClassCount = CoD.CACUtility.GetCustomClassCount( f397_arg0 )
		local f397_local8
		if Engine[0x3091707D0144833]() then
			f397_local8 = Enum[0x33AC0FF9A1537DE][0x7B81763817DC1AD]
			if not f397_local8 then
			
			else
				local f397_local9 = math.min( math.max( Enum[0x33AC0FF9A1537DE][0x3618B16E81F1FBD] - f397_arg1.customClassCount, 0 ), f397_local8 )
				local f397_local10 = CoD.CACUtility.GetFeatureCACItemIndex()
				local f397_local11 = f397_local10 and Engine[0x191C1637A229078]( f397_arg0, f397_local10, f397_local0 )
				if f397_local4:get() ~= f397_local1 or f397_local5 then
					Engine[0x83C9B5DE1D9371]( f397_local4, f397_local1 )
					if not CoD.CACUtility.tinyClassModels then
						CoD.CACUtility.tinyClassModels = {}
					end
					CoD.CACUtility.tinyClassModels[f397_arg0] = {}
					local f397_local12 = f397_local2:create( "CustomClassList" )
					f397_arg1.classModels = {}
					if CustomClassesEnabled() and (not f397_local5 or f397_local5 and f397_local6 == CoD.PrestigeUtility.ChooseClassSets.Custom) then
						local f397_local13 = nil
						if IsCampaign() then
							f397_local13 = CoD.CACUtility.GetSelectedCustomClass( f397_arg0, Enum[0x9C0C2196D8313A0][0x60063C67132EB69] )
						end
						if not CoD.CACUtility.IsProgressionEnabled( f397_local0 ) or not f397_local11 then
							for f397_local14 = 1, f397_arg1.customClassCount, 1 do
								table.insert( f397_arg1.classModels, {
									models = DataSources.ChooseClass_InGame.prepareModelForIndex( f397_local12, f397_local14, f397_local14 - 1, f397_arg0, f397_local0 ),
									properties = {
										classNum = f397_local14 - 1
									}
								} )
							end
						end
					end
					CoD.CACUtility.tinyClassModels[f397_arg0] = f397_arg1.classModels
				elseif CoD.CACUtility.tinyClassModels[f397_arg0] then
					f397_arg1.classModels = CoD.CACUtility.tinyClassModels[f397_arg0]
				end
			end
		end
		f397_local8 = 0
	end,
	getCount = function ( f398_arg0 )
		if f398_arg0.classModels then
			return #f398_arg0.classModels
		else
			return 0
		end
	end,
	getItem = function ( f399_arg0, f399_arg1, f399_arg2 )
		if f399_arg1.classModels then
			return f399_arg1.classModels[f399_arg2].models
		else
			
		end
	end,
	getCustomPropertiesForItem = function ( f400_arg0, f400_arg1 )
		return f400_arg0.classModels[f400_arg1].properties
	end,
	getSpacerAfterRow = function ( f401_arg0, f401_arg1, f401_arg2 )
		if f401_arg1 == f401_arg0.customClassCount then
			return 20
		else
			return 0
		end
	end
}
DataSources.ChooseClass_InGame = {
	prepareModelForIndex = function ( f402_arg0, f402_arg1, f402_arg2, f402_arg3, f402_arg4 )
		local f402_local0 = nil
		if CanUseSharedLoadouts( f402_arg3 ) then
			local f402_local1 = Engine[0x40E824FE270E174]( Engine[0x4DF5CFBC1771947]( f402_arg3 ), "ChooseClassCPClientMenu" )
			if f402_local1 then
				local f402_local2 = Engine[0x40E824FE270E174]( f402_local1, "selectedClientIndex" )
				if f402_local2 then
					local f402_local3 = Engine[0x40E824FE270E174]( f402_local1, "client" .. Engine[0x614D394F6F9A18D]( f402_local2 ) )
					if f402_local3 then
						f402_local0 = Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f402_local3, "xuid" ) )
					end
				end
			end
		end
		local f402_local1 = f402_arg0:create( "class" .. f402_arg1 )
		CoD.CACUtility.GetCustomClassModel( f402_arg3, f402_arg2, f402_local1, f402_local0, f402_arg4 )
		local f402_local2 = f402_local1:create( "classNumber" )
		f402_local2:set( f402_arg2 )
		if CoD.isPC and f402_arg2 < 12 then
			local f402_local4 = f402_local1:create( "keybindKBM" )
			f402_local4:set( "[{chooseclass_" .. f402_arg2 + 1 .. "}]" )
		end
		return f402_local1
	end,
	prepare = function ( f403_arg0, f403_arg1, f403_arg2 )
		local f403_local0 = Engine[0x3EAC408F958FF05]()
		if f403_arg1.menu and CoD.BaseUtility.GetMenuSessionMode( f403_arg1.menu ) then
			f403_local0 = CoD.BaseUtility.GetMenuSessionMode( f403_arg1.menu )
		end
		local f403_local1 = CoD.TeamUtility.GetTeamID( f403_arg0 )
		local f403_local2 = Engine[0x4DF5CFBC1771947]( f403_arg0 )
		local f403_local3 = f403_local2:create( "CustomClassList" )
		f403_local3:create( "equippedItemsChanged" )
		local f403_local4 = f403_local3.prepared
		if not f403_local4 then
			f403_local4 = f403_local3:create( "prepared" )
			f403_local4:set( -1 )
		end
		local f403_local5 = false
		local f403_local6 = -1
		local f403_local7 = f403_local2.classSetValue
		if f403_local7 then
			f403_local6 = f403_local7:get()
			if f403_local6 ~= CoD.PrestigeUtility.ChooseClassSets.Default and f403_local6 ~= CoD.PrestigeUtility.ChooseClassSets.Custom then
				f403_local5 = false
			else
				f403_local5 = true
			end
		end
		f403_arg1.customClassCount = CoD.CACUtility.GetCustomClassCount( f403_arg0 )
		local f403_local8 = Engine[0x3091707D0144833]()
		local f403_local9
		if f403_local8 then
			f403_local9 = Enum[0x33AC0FF9A1537DE][0x7B81763817DC1AD]
			if not f403_local9 then
			
			else
				local f403_local10 = f403_local9
				local f403_local11 = CoD.CACUtility.GetFeatureCACItemIndex()
				local f403_local12 = f403_local11 and Engine[0x191C1637A229078]( f403_arg0, f403_local11, f403_local0 )
				if f403_local4:get() ~= f403_local1 or f403_local5 then
					Engine[0x83C9B5DE1D9371]( f403_local4, f403_local1 )
					CoD.CACUtility.classModels[f403_arg0] = {}
					local f403_local13 = f403_local2:create( "CustomClassList" )
					f403_arg1.classModels = {}
					if CustomClassesEnabled() and (not f403_local5 or f403_local5 and f403_local6 == CoD.PrestigeUtility.ChooseClassSets.Custom) then
						local f403_local14 = nil
						if IsCampaign() then
							f403_local14 = CoD.CACUtility.GetSelectedCustomClass( f403_arg0, Enum[0x9C0C2196D8313A0][0x60063C67132EB69] )
						end
						if not CoD.CACUtility.IsProgressionEnabled( f403_local0 ) or not f403_local12 then
							for f403_local15 = 1, f403_arg1.customClassCount, 1 do
								table.insert( f403_arg1.classModels, {
									models = DataSources.ChooseClass_InGame.prepareModelForIndex( f403_local13, f403_local15, f403_local15 - 1, f403_arg0, f403_local0 ),
									properties = {
										classNum = f403_local15 - 1
									}
								} )
							end
						end
					end
					if f403_local8 and f403_local0 == Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] then
						local f403_local14 = Enum[0x33AC0FF9A1537DE][0xFEA2C4AFF9A65EC] + 1
						if not f403_local5 then
							for f403_local15 = f403_local14, f403_local14 + f403_local10 - 1, 1 do
								table.insert( f403_arg1.classModels, {
									models = DataSources.ChooseClass_InGame.prepareModelForIndex( f403_local13, f403_local15, f403_local15 - 1, f403_arg0, f403_local0 ),
									properties = {
										classNum = f403_local15 - 1
									}
								} )
							end
						elseif f403_local5 and f403_local6 == CoD.PrestigeUtility.ChooseClassSets.Default then
							for f403_local15 = f403_local14, f403_local14 + f403_local10 - 1, 1 do
								table.insert( f403_arg1.classModels, {
									models = DataSources.ChooseClass_InGame.prepareModelForIndex( f403_local13, f403_local15, f403_local15 - 1, f403_arg0, f403_local0 ),
									properties = {
										classNum = f403_local15 - 1
									}
								} )
							end
						end
					end
					CoD.CACUtility.classModels[f403_arg0] = f403_arg1.classModels
				elseif CoD.CACUtility.classModels[f403_arg0] then
					f403_arg1.classModels = CoD.CACUtility.classModels[f403_arg0]
				end
				CoD.CACUtility.ForceStreamCACImagesInGame( f403_arg0, CoD.CACUtility.classModels[f403_arg0] )
				local f403_local13 = CoD.perController[f403_arg0].initSetClass
				if f403_local13 == nil or not f403_local13 then
					CoD.perController[f403_arg0].initSetClass = true
					if f403_local0 ~= Enum[0x9C0C2196D8313A0][0xB22E0240605CFFE] then
						local f403_local14 = CoD.CACUtility.GetSelectedCustomClass( f403_arg0, f403_local0 )
						if CoD.CACUtility.IsProgressionEnabled( f403_local0 ) then
							local f403_local15 = CoD.CACUtility.GetClassesUnlockableItemUnlockInfo( f403_local14, "featureItemIndex" )
							local f403_local16 = f403_local15 and Engine[0x191C1637A229078]( f403_arg0, f403_local15, f403_local0 )
							if f403_local12 and not f403_local16 and (f403_local14 < Enum[0x33AC0FF9A1537DE][0xFEA2C4AFF9A65EC] or f403_local14 > Enum[0x33AC0FF9A1537DE][0xC3116E77D015099]) then
								f403_local14 = Enum[0x33AC0FF9A1537DE][0xFEA2C4AFF9A65EC]
								CoD.CACUtility.SetSelectedCustomClass( f403_arg0, f403_local0, f403_local14 )
							elseif not f403_local12 and f403_local16 then
								f403_local14 = Enum[0x33AC0FF9A1537DE][0xB269FFE65DEF21C]
								CoD.CACUtility.SetSelectedCustomClass( f403_arg0, f403_local0, f403_local14 )
							end
						end
						local f403_local15 = f403_local3["class" .. f403_local14 + 1]
						local f403_local18 = f403_local15
						local f403_local16 = f403_local15.defaultClassName
						if f403_local16 then
							f403_local16 = f403_local18 and f403_local15.defaultClassName:get()
						end
						CoD.CACUtility.ChangeClass( f403_arg0, f403_local14, f403_local16 )
					end
				end
			end
		end
		f403_local9 = 0
	end,
	getCount = function ( f404_arg0 )
		if f404_arg0.classModels then
			return #f404_arg0.classModels
		else
			return 0
		end
	end,
	getItem = function ( f405_arg0, f405_arg1, f405_arg2 )
		if f405_arg1.classModels then
			return f405_arg1.classModels[f405_arg2].models
		else
			
		end
	end,
	getCustomPropertiesForItem = function ( f406_arg0, f406_arg1 )
		return f406_arg0.classModels[f406_arg1].properties
	end,
	getSpacerAfterRow = function ( f407_arg0, f407_arg1, f407_arg2 )
		if f407_arg1 == f407_arg0.customClassCount then
			return 20
		else
			return 0
		end
	end
}
DataSourceHelpers.PerControllerDataSourceSetup( "CustomClassMenu", "CustomClassMenu", function ( f408_arg0, f408_arg1 )
	f408_arg0:create( "currentClassName" )
	f408_arg0:create( "currentClassSetName" )
end, false )
DataSources.ResetDefaultClass = {
	prepare = function ( f409_arg0, f409_arg1, f409_arg2 )
		f409_arg1.resetDefaultClassList = {}
		local f409_local0 = CoD.CACUtility.GetCustomClassCount( f409_arg0 )
		local f409_local1 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f409_arg0 ), "ResetDefaultClassList" )
		local f409_local2 = Engine[0x3EAC408F958FF05]()
		if f409_arg1.menu and CoD.BaseUtility.GetMenuSessionMode( f409_arg1.menu ) then
			f409_local2 = CoD.BaseUtility.GetMenuSessionMode( f409_arg1.menu )
		end
		local f409_local3 = function ( f410_arg0, f410_arg1 )
			local f410_local0 = {
				models = f409_local1:create( "DefaultClass" .. f410_arg0 )
			}
			local f410_local1 = CoD.CACUtility.GetDefaultCustomClassName( f410_arg0, f409_local2 )
			local f410_local2 = f410_local0.models:create( "customClassName" )
			f410_local2:set( Engine[0xF9F1239CFD921FE]( f410_local1 ) )
			f410_local2 = f410_local0.models:create( "index" )
			f410_local2:set( f410_arg0 )
			return f410_local0
		end
		
		for f409_local4 = 1, Enum[0x33AC0FF9A1537DE][0x496B3CCA108698A], 1 do
			local f409_local7 = CoD.CACUtility.GetClassesUnlockableItemUnlockInfo( f409_local4 - 1, "featureItemIndex" )
			if not f409_local7 or not CoD.CACUtility.IsProgressionEnabled( f409_local2 ) or not Engine[0x191C1637A229078]( f409_arg0, f409_local7, f409_local2 ) then
				table.insert( f409_arg1.resetDefaultClassList, f409_local3( f409_local4 ) )
			end
		end
	end,
	getCount = function ( f411_arg0 )
		return #f411_arg0.resetDefaultClassList
	end,
	getItem = function ( f412_arg0, f412_arg1, f412_arg2 )
		return f412_arg1.resetDefaultClassList[f412_arg2].models
	end
}
DataSources.PaintshopWeaponTabType = ListHelper_SetupDataSource( "Paintshop.PaintshopWeaponTabType", function ( f413_arg0 )
	local f413_local0 = {}
	table.insert( f413_local0, {
		models = {
			tabIcon = CoD.buttonStrings.shoulderl
		},
		properties = {
			m_mouseDisabled = true
		}
	} )
	for f413_local4, f413_local5 in ipairs( CoD.CraftUtility.WeaponGroupNames ) do
		table.insert( f413_local0, {
			models = {
				tabName = Engine[0xED84C33EC5F01EA]( f413_local5.name )
			},
			properties = {
				filter = f413_local5.weapon_category
			}
		} )
	end
	table.insert( f413_local0, {
		models = {
			tabIcon = CoD.buttonStrings.shoulderr
		},
		properties = {
			m_mouseDisabled = true
		}
	} )
	return f413_local0
end )
DataSources.EmblemMaterialTabType = ListHelper_SetupDataSource( "Emblem.EmblemMaterialTabType", function ( f414_arg0 )
	local f414_local0 = {}
	local f414_local1 = function ( f415_arg0 )
		if f415_arg0 ~= CoD.CraftUtility.EMBLEM_INVALID_ID then
			for f415_local3, f415_local4 in ipairs( CoD.CraftUtility.EmblemMaterialCategory ) do
				if Engine[0x2C4A412AD770876]( f414_arg0, f415_local4.category, f415_arg0 ) ~= CoD.CraftUtility.EMBLEM_INVALID_ID then
					return f415_local4.category
				end
			end
			
		else
			return CoD.CraftUtility.EmblemMaterialCategory[1].category
		end
	end
	
	local f414_local2 = CoD.perController[f414_arg0].selectedLayerMaterialID
	if f414_local2 ~= CoD.CraftUtility.EMBLEM_INVALID_ID then
		CoD.perController[f414_arg0].selectedMaterialCategory = f414_local1( f414_local2 )
	end
	for f414_local13, f414_local14 in ipairs( CoD.CraftUtility.EmblemMaterialCategory ) do
		if f414_local14.type ~= "camo" or IsBooleanDvarSet( "enable_camo_materials_tab" ) then
			local f414_local6 = 0
			local f414_local7 = Engine[0x566AF071BD06635]( f414_arg0, f414_local14.category )
			for f414_local8 = 0, f414_local7 - 1, 1 do
				local f414_local11 = Engine[0xF82B3E76E65EF74]( f414_arg0, f414_local14.category, f414_local8 )
				local f414_local12 = false
				if f414_local14.category == CoD.CraftUtility.EmblemBlackMarketEmblemCategory then
					f414_local12 = CoD.BlackMarketUtility.IsItemLocked( f414_arg0, Engine[0xF13E0433809ECDF]( f414_local11 ) )
				end
				if not f414_local12 and CoD.CraftUtility.Emblems.IsMaterialNew( f414_arg0, f414_local11 ) then
					f414_local6 = f414_local6 + 1
				end
			end
			if f414_local14.type == "general" then
				f414_local6 = 0
			end
			table.insert( f414_local0, {
				models = {
					tabName = Engine[0xED84C33EC5F01EA]( f414_local14.name ),
					breadcrumbCount = f414_local6
				},
				properties = {
					filter = f414_local14.category,
					selectIndex = f414_local14.category == CoD.perController[f414_arg0].selectedMaterialCategory
				}
			} )
		end
	end
	return f414_local0
end )
DataSources.CACCustomizationTabs = DataSourceHelpers.ListSetup( "CACCustomizationTabs", function ( f416_arg0 )
	local f416_local0 = {}
	local f416_local1 = CoD.perController[f416_arg0].gunsmithCamoIndexModel
	if f416_local1 then
		f416_local1 = not CoD.perController[f416_arg0].editingWeaponBuildKits
	end
	local f416_local2 = Engine[0x3EAC408F958FF05]()
	local f416_local3 = CoD.CACUtility.EmptyItemIndex
	if CoD.perController[f416_arg0].gunsmithCamoIndexModel or CoD.perController[f416_arg0].gunsmithReticleIndexModel or CoD.perController[f416_arg0].editingWeaponBuildKits then
		f416_local3 = CoD.GetCustomization( f416_arg0, "weapon_index" )
	else
		f416_local3 = CoD.CACUtility.GetItemEquippedInSlot( CoD.perController[f416_arg0].weaponCategory, f416_arg0, CoD.perController[f416_arg0].classModel )
	end
	local f416_local4 = ""
	if f416_local2 < Enum[0x9C0C2196D8313A0][0x96642BDE9B5962E] then
		f416_local4 = Engine[0xD5D69BA555E016D]( f416_local3, Enum[0x6EB546760F890D2][0x569E84652131CD7], f416_local2 )
	else
		f416_local4 = Engine[0xD5D69BA555E016D]( f416_local3, Enum[0x6EB546760F890D2][0x569E84652131CD7], Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] )
	end
	local f416_local5 = function ( f417_arg0, f417_arg1 )
		local f417_local0 = false
		if f417_arg1 < Enum[0x35EF5EB24C7CAA2][0x9DA810F3269DE6B] then
			if f417_arg1 == f416_local2 then
				f417_local0 = not f416_local1
			else
				f417_local0 = false
			end
		end
		table.insert( f416_local0, {
			models = {
				tabName = f417_arg0,
				tabIcon = "",
				breadcrumbCount = 0
			},
			properties = {
				filterEnum = f417_arg1,
				filterString = CoD.WeaponOptionFilterToString( f417_arg1 ),
				selectIndex = f417_local0
			}
		} )
	end
	
	table.insert( f416_local0, {
		models = {
			tabIcon = CoD.buttonStrings.shoulderl
		},
		properties = {
			m_mouseDisabled = true
		}
	} )
	if CoD.perController[f416_arg0].customizationType == Enum[0x3CBA8D054211104][0x6C9BD564F3BA48B] then
		f416_local5( 0x55D96CC762EABDD, Enum[0x35EF5EB24C7CAA2][0xA77C317111C4F95] )
		f416_local5( 0xB06081B8B4567F2, Enum[0x35EF5EB24C7CAA2][0xA37D61710E68BE9] )
		if IsLive() then
			f416_local5( 0x29C903C6DF90D6F, Enum[0x35EF5EB24C7CAA2][0xA52D61710FD53A1] )
		end
	else
		if not IsLive() or CoD.CACUtility.WeaponsWithNoMPCamos[f416_local4] == nil then
			f416_local5( 0x55D96CC762EABDD, Enum[0x35EF5EB24C7CAA2][0xA77C317111C4F95] )
		end
		if not IsLive() or CoD.CACUtility.WeaponsWithNoZMCamos[f416_local4] == nil then
			f416_local5( 0xB06081B8B4567F2, Enum[0x35EF5EB24C7CAA2][0xA37D61710E68BE9] )
		end
		if IsLive() and CoD.BlackMarketUtility.WeaponsWithNoBMCamos[f416_local4] == nil then
			f416_local5( 0x29C903C6DF90D6F, Enum[0x35EF5EB24C7CAA2][0xA52D61710FD53A1] )
		end
	end
	f416_local5( 0x843D640BA217F60, Enum[0x35EF5EB24C7CAA2][0x17115CF3063829F] )
	table.insert( f416_local0, {
		models = {
			tabIcon = CoD.buttonStrings.shoulderr
		},
		properties = {
			m_mouseDisabled = true
		}
	} )
	return f416_local0
end, false )
DataSources.FileshareRoot = {
	getModel = function ( f418_arg0 )
		return Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "fileshareRoot" )
	end
}
DataSources.FileshareSelectedItem = {
	getModel = function ( f419_arg0 )
		return CoD.FileshareUtility.GetSelectedItem()
	end
}
DataSources.FileshareShowcaseManagerTabs = ListHelper_SetupDataSource( "FileshareShowcaseManagerTabs", function ( f420_arg0 )
	local f420_local0 = {}
	table.insert( f420_local0, {
		models = {
			tabIcon = CoD.buttonStrings.shoulderl
		},
		properties = {
			m_mouseDisabled = true
		}
	} )
	local f420_local1 = CoD.FileshareUtility.GetCurrentCategory()
	for f420_local7, f420_local8 in ipairs( CoD.FileshareUtility.ShowcaseManagerTabs ) do
		local f420_local5 = f420_local8.selectIndex
		local f420_local6 = f420_local8.disabled
		if f420_local8.fileshareCategory == f420_local1 then
			f420_local5 = true
			f420_local6 = false
		else
			f420_local5 = false
		end
		table.insert( f420_local0, {
			models = {
				tabName = Engine[0xF9F1239CFD921FE]( CoD.FileshareUtility.CategoryLocStrings[f420_local8.fileshareCategory].locStringCaps or 0x0 )
			},
			properties = {
				disabled = f420_local6,
				fileshareCategory = f420_local8.fileshareCategory,
				fileshareKey = f420_local8.fileshareKey,
				fileshareVal = f420_local8.fileshareVal,
				selectIndex = f420_local5
			}
		} )
	end
	table.insert( f420_local0, {
		models = {
			tabIcon = CoD.buttonStrings.shoulderr
		},
		properties = {
			m_mouseDisabled = true
		}
	} )
	return f420_local0
end )
DataSources.FilesharePublishedPaintjobTabs = ListHelper_SetupDataSource( "FilesharePublishedPaintjobTabs", function ( f421_arg0 )
	local f421_local0 = {}
	table.insert( f421_local0, {
		models = {
			tabIcon = CoD.buttonStrings.shoulderl
		},
		properties = {
			m_mouseDisabled = true
		}
	} )
	for f421_local4, f421_local5 in ipairs( CoD.FileshareUtility.PublishedPaintjobsTabs ) do
		table.insert( f421_local0, {
			models = {
				tabName = Engine[0xED84C33EC5F01EA]( f421_local5.name )
			},
			properties = {
				filter = f421_local5.weapon_category,
				loadoutType = f421_local5.loadout_type,
				disabled = f421_local5.disabled,
				fileshareGroup = f421_local5.fileshareGroup,
				fileshareCategory = f421_local5.fileshareCategory,
				fileshareKey = f421_local5.fileshareKey,
				fileshareVal = f421_local5.fileshareVal
			}
		} )
	end
	table.insert( f421_local0, {
		models = {
			tabIcon = CoD.buttonStrings.shoulderr
		},
		properties = {
			m_mouseDisabled = true
		}
	} )
	return f421_local0
end )
DataSources.EmblemIconList = {
	prepare = function ( f422_arg0, f422_arg1, f422_arg2 )
		f422_arg1.emblemIconList = {}
		local f422_local0 = CoD.perController[f422_arg0].selectedDecalCategory
		local f422_local1 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f422_arg0 ), "Emblems.DecalList" )
		if f422_local0 == CoD.CraftUtility.EmblemStickerCategory then
			CoD.CraftUtility.Emblems.AddStickersToDecalList( f422_arg0, f422_local1, f422_arg1.emblemIconList, CoD.CraftUtility.EmblemDefaultStickerCategory, false )
			CoD.CraftUtility.Emblems.AddStickersToDecalList( f422_arg0, f422_local1, f422_arg1.emblemIconList, f422_local0, true )
		else
			CoD.CraftUtility.Emblems.AddStickersToDecalList( f422_arg0, f422_local1, f422_arg1.emblemIconList, f422_local0, false )
		end
		f422_arg1.selectIndex = 1
		table.sort( f422_arg1.emblemIconList, CoD.BlackMarketUtility.SortUnlocksModelEmblemIconID )
	end,
	getCount = function ( f423_arg0 )
		return #f423_arg0.emblemIconList
	end,
	getItem = function ( f424_arg0, f424_arg1, f424_arg2 )
		return f424_arg1.emblemIconList[f424_arg2]
	end,
	getCustomPropertiesForItem = function ( f425_arg0, f425_arg1 )
		if f425_arg0.selectIndex == f425_arg1 then
			return {
				selectIndex = true
			}
		else
			
		end
	end
}
DataSources.EmblemDecalTabs = ListHelper_SetupDataSource( "EmblemDecalTabs", function ( f426_arg0, f426_arg1 )
	local f426_local0 = {}
	local f426_local1 = CoD.perController[f426_arg0].selectedLayerIconID
	local f426_local2 = nil
	if f426_local1 ~= CoD.CraftUtility.EMBLEM_INVALID_ID and CoD.perController[f426_arg0].selectedDecalCategory == CoD.CraftUtility.EmblemCategoryInvalid then
		f426_local2 = CoD.CraftUtility.GetSelectedDecalCategory( f426_arg0 )
		CoD.perController[f426_arg0].selectedDecalCategory = f426_local2
	end
	local f426_local3 = CoD.CraftUtility.Groups.GetTotalUsed( f426_arg0 )
	local f426_local4 = DataSources.EmblemCallingCardBreadcrumbs.getModel( f426_arg0 )
	for f426_local12, f426_local13 in ipairs( CoD.CraftUtility.EMBLEM_DECALTABS ) do
		local f426_local14 = Engine[0xC1EF938E568714]( f426_arg0, 0, f426_local13.category )
		for f426_local10 = 0, f426_local14 - 1, 1 do
			local f426_local8 = Engine[0x8C223AA63A664D]( f426_arg0, 0, f426_local13.category, f426_local10 )
			local f426_local9 = false
			if f426_local13.type == "BLACKMARKET" then
				f426_local9 = CoD.BlackMarketUtility.IsItemLocked( f426_arg0, CoD.BlackMarketUtility.GetLootDecalName( f426_arg0, f426_local8 ) )
			end
		end
		local f426_local10 = CoD.CraftUtility.Emblems.GetDecalFrameWidget( f426_local13.category )
		if IsPaintshop( f426_arg0 ) then
			f426_local10 = f426_local10 .. "Paintshop"
		end
		if not (f426_local13.category == CoD.CraftUtility.EmblemDecalGroupCategory and (f426_local3 <= 0 or f426_local13.category == CoD.CraftUtility.EmblemStickerSetCategory)) or CoD.CraftUtility.Emblems.ShouldShowStickerSets( f426_arg0 ) then
			local f426_local11 = nil
			if f426_local4 and f426_local4[f426_local13.type] then
				f426_local11 = f426_local4[f426_local13.type]
			else
				f426_local11 = {
					breadcrumbCount = 0
				}
			end
			table.insert( f426_local0, {
				models = {
					tabName = Engine[0xED84C33EC5F01EA]( f426_local13.displayName ),
					breadcrumb = f426_local11,
					frameWidget = f426_local10
				},
				properties = {
					tabCategory = f426_local13.category,
					selectIndex = f426_local2 == f426_local13.category
				}
			} )
		end
	end
	return f426_local0
end, true )
DataSources.GroupDecalButtons = ListHelper_SetupDataSource( "GroupDecalButtons", function ( f427_arg0 )
	local f427_local0 = {}
	local f427_local1 = CoD.perController[f427_arg0].selectedLayerIconID
	local f427_local2 = nil
	if f427_local1 ~= CoD.CraftUtility.EMBLEM_INVALID_ID and CoD.perController[f427_arg0].selectedDecalCategory == CoD.CraftUtility.EmblemCategoryInvalid then
		f427_local2 = CoD.CraftUtility.GetSelectedDecalCategory( f427_arg0 )
		CoD.perController[f427_arg0].selectedDecalCategory = f427_local2
	end
	for f427_local6, f427_local7 in ipairs( CoD.CraftUtility.DECAL_GROUPSBUTTONS ) do
		local f427_local8 = 0
		if f427_local7.category ~= CoD.CraftUtility.EmblemDefaultGroupCategory or Dvar[0xD1C33F52B905121]:get() then
			table.insert( f427_local0, {
				models = {
					name = f427_local7.displayName,
					category = f427_local7.category,
					breadcrumbCount = f427_local8
				},
				properties = {
					category = f427_local7.category,
					selectIndex = f427_local2 == f427_local7.category
				}
			} )
		end
	end
	return f427_local0
end )
DataSources.ToolDecalButtons = ListHelper_SetupDataSource( "ToolDecalButtons", function ( f428_arg0 )
	local f428_local0 = {}
	local f428_local1 = CoD.perController[f428_arg0].selectedLayerIconID
	local f428_local2 = nil
	if f428_local1 ~= CoD.CraftUtility.EMBLEM_INVALID_ID and CoD.perController[f428_arg0].selectedDecalCategory == CoD.CraftUtility.EmblemCategoryInvalid then
		f428_local2 = CoD.CraftUtility.GetSelectedDecalCategory( f428_arg0 )
		local f428_local3 = false
		for f428_local7, f428_local8 in ipairs( CoD.CraftUtility.DECAL_TOOLBUTTONS ) do
			if f428_local2 == f428_local8 then
				f428_local3 = true
				break
			end
		end
		if f428_local3 then
			CoD.perController[f428_arg0].selectedDecalCategory = f428_local2
		end
	end
	for f428_local6, f428_local7 in ipairs( CoD.CraftUtility.DECAL_TOOLBUTTONS ) do
		table.insert( f428_local0, {
			models = {
				name = f428_local7.displayName,
				category = f428_local7.category,
				breadcrumbCount = 0
			},
			properties = {
				category = f428_local7.category,
				selectIndex = f428_local2 == f428_local7.category
			}
		} )
	end
	return f428_local0
end )
DataSources.EmblemCategoryTabs = ListHelper_SetupDataSource( "EmblemCategoryTabs", function ( f429_arg0, f429_arg1 )
	local f429_local0 = {}
	local f429_local1 = CoD.CraftUtility.Emblems.EDITOR_TABS
	if not CoD.CraftUtility.Emblems.IsEditor( f429_arg1.menu ) then
		f429_local1 = CoD.CraftUtility.Emblems.SELECT_TABS
	end
	local f429_local2 = DataSources.EmblemCallingCardBreadcrumbs.getModel( f429_arg0 )
	for f429_local12, f429_local13 in ipairs( f429_local1 ) do
		local f429_local14 = CoD.CraftUtility.Emblems.GetTotalUsedEmblems( f429_arg0, f429_local13.storageType, f429_local13.stickerCategory )
		for f429_local7 = 0, f429_local14 - 1, 1 do
			local f429_local6 = false
			if f429_local13.storageType == Enum[0xBBD4F9E70101BA8][0xBCE8CBF08D7751] then
				f429_local6 = CoD.BlackMarketUtility.IsItemLocked( f429_arg0, CoD.BlackMarketUtility.GetLootEmblemIDName( f429_local7 ) )
			end
		end
		if (IsLive() or not f429_local13.requiresLive) and (not IsUserContentRestricted( f429_arg0 ) or not f429_local13.requiresUGC) and (not f429_local13.disableForTrial or not Engine[0xCB675CA7856DA25]()) then
			if CoD.perController[f429_arg0].selectedEmblemTabStorageType == nil then
				CoD.perController[f429_arg0].selectedEmblemTabStorageType = f429_local13.storageType
				CoD.perController[f429_arg0].selectedEmblemTabStickerCategory = f429_local13.stickerCategory
				CoD.CraftUtility.SetSelectedStorageFileType( f429_arg0, f429_local13.storageType )
				CoD.CraftUtility.Emblems.ParseDDL( f429_arg0, CoD.perController[f429_arg0].selectedEmblemTabStorageType, CoD.perController[f429_arg0].selectedEmblemTabStickerCategory )
			end
			if f429_local13.stickerCategory ~= CoD.CraftUtility.EmblemStickerSetCategory or CoD.CraftUtility.Emblems.ShouldShowStickerSets( f429_arg0 ) then
				local f429_local7 = nil
				if f429_local2 and f429_local2[f429_local13.type] then
					f429_local7 = f429_local2[f429_local13.type]
				else
					f429_local7 = {
						breadcrumbCount = 0
					}
				end
				local f429_local8 = table.insert
				local f429_local9 = f429_local0
				local f429_local10 = {
					models = {
						tabName = f429_local13.displayName,
						breadcrumb = f429_local7,
						frameWidget = f429_local13.frameWidget
					}
				}
				local f429_local6 = {
					tabCategory = f429_local13.category,
					tabType = f429_local13.type,
					storageType = f429_local13.storageType,
					stickerCategory = f429_local13.stickerCategory
				}
				local f429_local11
				if f429_local13.storageType ~= CoD.perController[f429_arg0].selectedEmblemTabStorageType or f429_local13.stickerCategory ~= CoD.perController[f429_arg0].selectedEmblemTabStickerCategory then
					f429_local11 = false
				else
					f429_local11 = true
				end
				f429_local6.selectIndex = f429_local11
				f429_local10.properties = f429_local6
				f429_local8( f429_local9, f429_local10 )
			end
		end
	end
	return f429_local0
end, true )
DataSources.CustomGamesOptionsButtonList = ListHelper_SetupDataSource( "CustomGamesOptionsButtonList", function ( f430_arg0 )
	local f430_local0 = {}
	table.insert( f430_local0, {
		displayText = 0x110D5B19A4FEA36,
		displayImage = "t7_icon_menu_simple_publish",
		displayDesc = 0xD5297656D74DCDD,
		action = OpenCustomGamePublishPrompt,
		disabled = false
	} )
	table.insert( f430_local0, {
		displayText = 0x8ADA48E694BFE2C,
		displayImage = "t7_icon_menu_simple_delete",
		displayDesc = 0x3ECA7AE1E1EFD4D,
		action = DeleteCustomGame,
		disabled = false
	} )
	local f430_local1 = {}
	for f430_local5, f430_local6 in ipairs( f430_local0 ) do
		table.insert( f430_local1, {
			models = {
				displayText = Engine[0xED84C33EC5F01EA]( f430_local6.displayText ),
				icon = f430_local6.displayImage,
				hintText = f430_local6.displayDesc
			},
			properties = {
				action = f430_local6.action,
				actionParam = f430_local6.params
			}
		} )
	end
	return f430_local1
end )
DataSources.ScreenshotsOptionsButtonList = ListHelper_SetupDataSource( "ScreenshotsOptionsButtonList", function ( f431_arg0 )
	local f431_local0 = {}
	if FileshareCanPublish( f431_arg0 ) then
		table.insert( f431_local0, {
			displayText = 0x110D5B19A4FEA36,
			displayImage = "t7_icon_menu_simple_publish",
			displayDesc = 0xA415DD31B407628,
			action = OpenLocalScreenshotsPublishPrompt,
			disabled = false
		} )
	end
	if FileshareCanDeleteItem( f431_arg0 ) then
		local f431_local1 = 0xE0F1CAE8E5DDA06
		if FileshareIsLocalCategory( f431_arg0 ) then
			f431_local1 = 0xD46527DE8E0E0EA
		end
		table.insert( f431_local0, {
			displayText = 0x8ADA48E694BFE2C,
			displayImage = "t7_icon_menu_simple_delete",
			displayDesc = f431_local1,
			action = CoD.FileshareUtility.Delete
		} )
	end
	local f431_local1 = {}
	for f431_local5, f431_local6 in ipairs( f431_local0 ) do
		table.insert( f431_local1, {
			models = {
				displayText = Engine[0xED84C33EC5F01EA]( f431_local6.displayText ),
				icon = f431_local6.displayImage,
				hintText = f431_local6.displayDesc
			},
			properties = {
				action = f431_local6.action,
				actionParam = f431_local6.params
			}
		} )
	end
	return f431_local1
end )
DataSources.CustomGamesOptionsDeleteButtonList = {
	prepare = function ( f432_arg0, f432_arg1, f432_arg2 )
		local f432_local0 = {
			{
				displayText = 0x8ADA48E694BFE2C,
				displayImage = "",
				displayDesc = 0x3ECA7AE1E1EFD4D,
				action = DeleteCustomGameYes
			},
			{
				displayText = 0xC2E92C54C2BE289,
				displayImage = "",
				displayDesc = "MENU_CUSTOMGAMES_CANCEL_DESC",
				action = DeleteCustomGameNo
			}
		}
		local f432_local1 = Engine[0xA798E4552F5E872]( Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "CustomGamesOptionsDeleteButtonList" ), "list" )
		f432_arg1.optionModels = {}
		for f432_local5, f432_local6 in ipairs( f432_local0 ) do
			f432_arg1.optionModels[f432_local5] = Engine[0xA798E4552F5E872]( f432_local1, "buttonModel_" .. f432_local5 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f432_arg1.optionModels[f432_local5], "displayText" ), Engine[0xED84C33EC5F01EA]( f432_local6.displayText ) )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f432_arg1.optionModels[f432_local5], "displayImage" ), f432_local6.displayImage )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f432_arg1.optionModels[f432_local5], "hintText" ), Engine[0xED84C33EC5F01EA]( f432_local6.displayDesc ) )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f432_arg1.optionModels[f432_local5], "action" ), f432_local6.action )
		end
	end,
	getCount = function ( f433_arg0 )
		return #f433_arg0.optionModels
	end,
	getItem = function ( f434_arg0, f434_arg1, f434_arg2 )
		return f434_arg1.optionModels[f434_arg2]
	end
}
DataSources.CustomGamesLoadOptionsButtonList = {
	prepare = function ( f435_arg0, f435_arg1, f435_arg2 )
		f435_arg1.optionModels = {}
		local f435_local0 = {
			{
				displayText = 0xDFD294FC69F682,
				displayImage = "",
				displayDesc = 0x0,
				action = LoadFileshareCustomGame
			},
			{
				displayText = 0x5C16E02B211A4F4,
				displayImage = "",
				displayDesc = 0x0,
				action = GoBack
			}
		}
		local f435_local1 = Engine[0xA798E4552F5E872]( Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "CustomGamesLoadOptionsButtonList" ), "list" )
		for f435_local5, f435_local6 in ipairs( f435_local0 ) do
			f435_arg1.optionModels[f435_local5] = Engine[0xA798E4552F5E872]( f435_local1, "buttonModel_" .. f435_local5 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f435_arg1.optionModels[f435_local5], "displayText" ), Engine[0xED84C33EC5F01EA]( f435_local6.displayText ) )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f435_arg1.optionModels[f435_local5], "displayImage" ), f435_local6.displayImage )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f435_arg1.optionModels[f435_local5], "hintText" ), Engine[0xED84C33EC5F01EA]( f435_local6.displayDesc ) )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f435_arg1.optionModels[f435_local5], "action" ), f435_local6.action )
		end
	end,
	getCount = function ( f436_arg0 )
		return #f436_arg0.optionModels
	end,
	getItem = function ( f437_arg0, f437_arg1, f437_arg2 )
		return f437_arg1.optionModels[f437_arg2]
	end
}
DataSources.CustomGamesRoot = {
	getModel = function ( f438_arg0 )
		return Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "CustomGamesRoot" )
	end
}
DataSourceHelpers.GlobalDataSourceSetup( "DirectTelemetry", "CustomGamesRoot.dtel", function ( f439_arg0 )
	f439_arg0:create( "connected" )
end, false )
DataSources.ChangeGameModeNav = {
	prepare = function ( f440_arg0, f440_arg1, f440_arg2 )
		local f440_local0 = {
			{
				text = 0x2D456C4A11A18,
				image = "uie_t7_mp_icon_header_customgames_large",
				description = 0x8B650C1DBC3BABD,
				community = true
			},
			{
				text = 0xAB87A6DD9E3E9EE,
				image = "uie_t7_mp_icon_header_customgames_large",
				description = 0x8B650C1DBC3BABD,
				community = false
			}
		}
		local f440_local1 = Engine[0xA798E4552F5E872]( Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "ChangeGameModeNav" ), "list" )
		f440_arg1.buttonModels = {}
		for f440_local5, f440_local6 in ipairs( f440_local0 ) do
			f440_arg1.buttonModels[f440_local5] = Engine[0xA798E4552F5E872]( f440_local1, "ChangeGameModeNavButton_" .. f440_local5 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f440_arg1.buttonModels[f440_local5], "text" ), Engine[0xED84C33EC5F01EA]( f440_local6.text ) )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f440_arg1.buttonModels[f440_local5], "image" ), f440_local6.image )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f440_arg1.buttonModels[f440_local5], "description" ), Engine[0xED84C33EC5F01EA]( f440_local6.description ) )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f440_arg1.buttonModels[f440_local5], "community" ), f440_local6.community )
		end
	end,
	getCount = function ( f441_arg0 )
		return #f441_arg0.buttonModels
	end,
	getItem = function ( f442_arg0, f442_arg1, f442_arg2 )
		return f442_arg1.buttonModels[f442_arg2]
	end
}
DataSources.ChangeGameModeNavSecondary = {
	prepare = function ( f443_arg0, f443_arg1, f443_arg2 )
		local f443_local0 = {
			{
				text = 0xA290900E89E0154,
				image = "uie_t7_menu_startmenu_media_recent",
				description = 0x0,
				action = nil
			},
			{
				text = 0x705BD8CAF36BAE2,
				image = "uie_t7_menu_startmenu_media_popular",
				description = 0x0,
				action = nil
			},
			{
				text = 0x5F155722E34DA5C,
				image = "uie_t7_menu_startmenu_media_trending",
				description = 0x0,
				action = nil
			}
		}
		local f443_local1 = Engine[0xA798E4552F5E872]( Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "ChangeGameModeNavSecondary" ), "list" )
		f443_arg1.buttonModels = {}
		for f443_local5, f443_local6 in ipairs( f443_local0 ) do
			f443_arg1.buttonModels[f443_local5] = Engine[0xA798E4552F5E872]( f443_local1, "ChangeGameModeNavSecondaryButton_" .. f443_local5 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f443_arg1.buttonModels[f443_local5], "text" ), Engine[0xED84C33EC5F01EA]( f443_local6.text ) )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f443_arg1.buttonModels[f443_local5], "image" ), f443_local6.image )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f443_arg1.buttonModels[f443_local5], "description" ), Engine[0xED84C33EC5F01EA]( f443_local6.description ) )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f443_arg1.buttonModels[f443_local5], "action" ), f443_local6.action )
		end
	end,
	getCount = function ( f444_arg0 )
		return #f444_arg0.buttonModels
	end,
	getItem = function ( f445_arg0, f445_arg1, f445_arg2 )
		return f445_arg1.buttonModels[f445_arg2]
	end
}
DataSources.CustomGamesList = {
	prepare = function ( f446_arg0, f446_arg1, f446_arg2 )
		f446_arg1.showDefault = true
		f446_arg1.controller = f446_arg0
		f446_arg1.rootModel = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "CustomGamesRoot" )
		f446_arg1.communityOptions = {
			{
				text = Engine[0xF9F1239CFD921FE]( 0xA290900E89E0154 ),
				image = "img_t7_menu_startmenu_media_recent",
				description = Engine[0xF9F1239CFD921FE]( 0x8B650C1DBC3BABD ),
				action = OpenPopularCustomGames
			},
			{
				text = Engine[0xF9F1239CFD921FE]( 0x705BD8CAF36BAE2 ),
				image = "img_t7_menu_startmenu_media_popular",
				description = Engine[0xF9F1239CFD921FE]( 0x8B650C1DBC3BABD ),
				action = OpenTrendingCustomGames
			},
			{
				text = Engine[0xF9F1239CFD921FE]( 0x5F155722E34DA5C ),
				image = "img_t7_menu_startmenu_media_trending",
				description = Engine[0xF9F1239CFD921FE]( 0x8B650C1DBC3BABD ),
				action = OpenrRecentCustomGames
			}
		}
		local f446_local0 = GetCurrentUIGameType( f446_arg0 )
		if f446_local0 == "" then
			local f446_local1 = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "CustomGamesRoot" )
			local f446_local2 = Engine[0x614D394F6F9A18D]( Engine[0xA798E4552F5E872]( f446_local1, "communityOption" ) )
			local f446_local3 = Engine[0x614D394F6F9A18D]( Engine[0xA798E4552F5E872]( f446_local1, "showcaseOption" ) )
			if f446_local2 then
				f446_arg1.numFiles = 3
				f446_arg1.communityOption = true
			elseif f446_local3 then
				f446_arg1.numFiles = 0
			end
		else
			f446_arg1.officialGameCount = Engine[0x48A53BF4243EDFE]( f446_arg0, Enum[0xBBD4F9E70101BA8][0x1480AB38C78061C], f446_local0 )
			f446_arg1.customGameCount = Engine[0x48A53BF4243EDFE]( f446_arg0, Engine[0xFFDD58B353B5C0B](), f446_local0 )
			f446_arg1.communityOption = false
			f446_arg1.numFiles = f446_arg1.officialGameCount + f446_arg1.customGameCount
			if f446_arg1.showDefault == true then
				f446_arg1.numFiles = f446_arg1.numFiles + 1
			end
		end
	end,
	getCount = function ( f447_arg0 )
		return f447_arg0.numFiles
	end,
	getItem = function ( f448_arg0, f448_arg1, f448_arg2 )
		local f448_local0 = Engine[0xA798E4552F5E872]( f448_arg1.rootModel, "CustomGames_" .. f448_arg2 )
		local f448_local1 = GetCurrentUIGameType( f448_arg0 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f448_local0, "uiIndex" ), f448_arg2 )
		if f448_arg1.communityOption == true then
			local f448_local2 = f448_arg1.communityOptions[f448_arg2]
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f448_local0, "text" ), f448_local2.text )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f448_local0, "buttonText" ), f448_local2.text )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f448_local0, "image" ), f448_local2.image )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f448_local0, "description" ), f448_local2.description )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f448_local0, "action" ), f448_local2.action )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f448_local0, "isOfficial" ), false )
			return f448_local0
		elseif f448_arg1.showDefault == true and f448_arg2 == 1 then
			local f448_local2 = Engine[0xA195D59C70219EF]()
			local f448_local3 = GetCurrentUIGameType( f448_arg0 )
			local f448_local4 = ""
			for f448_local8, f448_local9 in pairs( f448_local2 ) do
				if f448_local9.category == "standard" and f448_local9.gametype == f448_local3 then
					f448_local4 = "^BBUTTON_CUSTOMGAME_ICON^ " .. Engine[0xED84C33EC5F01EA]( f448_local9.name )
					break
				end
			end
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f448_local0, "text" ), f448_local4 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f448_local0, "buttonText" ), f448_local4 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f448_local0, "inUse" ), true )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f448_local0, "isOfficial" ), true )
			if f448_local1 then
				f448_local5 = Engine[0xEA74FA7EE46E195]( f448_local1 )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f448_local0, "description" ), Engine[0xF9F1239CFD921FE]( f448_local5.descriptionRef ) )
			end
		else
			local f448_local2 = 1
			if f448_arg1.showDefault == true then
				f448_local2 = 2
			end
			local f448_local3 = f448_arg2 - f448_local2
			local f448_local4 = false
			if f448_local3 < f448_arg1.officialGameCount then
				f448_local4 = true
			else
				f448_local3 = f448_local3 - f448_arg1.officialGameCount
			end
			local f448_local5 = nil
			local f448_local6 = 0
			if f448_local4 == true then
				local f448_local7 = Engine[0x41979A67CD7F2C2]( Enum[0xBBD4F9E70101BA8][0x1480AB38C78061C] )
				f448_local7 = f448_local7.slots
				local f448_local8 = 0
				for f448_local9 = 0, f448_local7 - 1, 1 do
					f448_local5 = Engine[0xAD93F86C182478E]( f448_arg0, Enum[0xBBD4F9E70101BA8][0x1480AB38C78061C], f448_local9, f448_local1 )
					if f448_local5.gameType:get() == f448_local1 then
						if f448_local8 == f448_local3 then
							f448_local6 = f448_local9
						end
						f448_local8 = f448_local8 + 1
					end
				end
			else
				local f448_local7 = Engine[0xFFDD58B353B5C0B]()
				local f448_local8 = Engine[0x41979A67CD7F2C2]( f448_local7 )
				f448_local8 = f448_local8.slots
				local f448_local9 = 0
				for f448_local10 = 0, f448_local8 - 1, 1 do
					f448_local5 = Engine[0xAD93F86C182478E]( f448_arg0, f448_local7, f448_local10, f448_local1 )
					if f448_local5.gameType:get() == f448_local1 then
						if f448_local9 == f448_local3 then
							f448_local6 = f448_local10
							break
						end
						f448_local9 = f448_local9 + 1
					end
				end
			end
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f448_local0, "slot" ), f448_local6 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f448_local0, "index" ), f448_local6 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f448_local0, "gameName" ), f448_local5.gameName:get() )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f448_local0, "inUse" ), f448_local5.inUse:get() )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f448_local0, "isOfficial" ), f448_local4 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f448_local0, "createTime" ), f448_local5.createTime:get() )
			if f448_local4 == true then
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f448_local0, "text" ), "^BBUTTON_CUSTOMGAME_ICON^ " .. Engine[0xF9F1239CFD921FE]( 0x42CD91611263B8F .. f448_local5.gameName:get() .. "_CAPS" ) )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f448_local0, "buttonText" ), "^BBUTTON_CUSTOMGAME_ICON^ " .. Engine[0xF9F1239CFD921FE]( 0x42CD91611263B8F .. f448_local5.gameName:get() .. "_CAPS" ) )
			else
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f448_local0, "text" ), f448_local5.gameName:get() )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f448_local0, "buttonText" ), f448_local5.gameName:get() )
			end
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f448_local0, "gameTypeString" ), f448_local5.gameType:get() )
			if f448_local1 then
				if f448_local4 == true then
					Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f448_local0, "description" ), Engine[0xF9F1239CFD921FE]( 0x42CD91611263B8F .. f448_local5.gameDescription:get() .. "_DESC" ) )
					Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f448_local0, "gameDescription" ), Engine[0xF9F1239CFD921FE]( 0x42CD91611263B8F .. f448_local5.gameDescription:get() .. "_DESC" ) )
				else
					Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f448_local0, "description" ), f448_local5.gameDescription:get() )
					Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f448_local0, "gameDescription" ), f448_local5.gameDescription:get() )
				end
			end
		end
		if f448_local1 then
			local f448_local2 = Engine[0xEA74FA7EE46E195]( f448_local1 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f448_local0, "gametype" ), f448_local1 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f448_local0, "image" ), f448_local2.image )
		end
		return f448_local0
	end
}
DataSources.MediaManagerQuotaList = {
	prepare = function ( f449_arg0, f449_arg1, f449_arg2 )
		f449_arg1.controller = f449_arg0
		f449_arg1.rootModel = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f449_arg0 ), "MediaManagerQuota" )
		f449_arg1.numFileshareCategories = GetMediaManagerCategoryCount()
	end,
	getCount = function ( f450_arg0 )
		return f450_arg0.numFileshareCategories
	end,
	getItem = function ( f451_arg0, f451_arg1, f451_arg2 )
		local f451_local0 = Engine[0xA798E4552F5E872]( f451_arg1.rootModel, "fileshareCategory_" .. f451_arg2 )
		local f451_local1 = Engine[0xC6F8EC444864600]( CoD.fileShareTable, f451_arg2 - 1, 1 )
		local f451_local2 = Engine[0xBD4558D421599D6]( f451_arg1.controller, f451_local1 )
		local f451_local3 = 0
		local f451_local4 = 0
		if f451_local2.categoryQuota > 0 then
			f451_local3 = f451_local2.categorySlotsUsed / f451_local2.categoryQuota
		end
		if f451_local3 > 1 then
			f451_local3 = 1
		elseif f451_local3 < 0 then
			f451_local3 = 0
		end
		if f451_local3 == 1 then
			f451_local4 = 1
		end
		local f451_local5 = CoD.FileshareUtility.CategoryLocStrings[f451_local1].locString or 0x0
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f451_local0, "category" ), f451_local2.category )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f451_local0, "locName" ), f451_local5 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f451_local0, "quota" ), f451_local2.categoryQuota )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f451_local0, "slotsUsed" ), f451_local2.categorySlotsUsed )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f451_local0, "fraction" ), f451_local3 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f451_local0, "image" ), CoD.FileshareUtility.GetCategoryImage( f451_local1 ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f451_local0, "barColor" ), CoD.FileshareUtility.GetCategoryColor( f451_local1 ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f451_local0, "slotsFull" ), f451_local4 )
		if f451_local2.category == CoD.FileshareUtility.GetCurrentCategory() then
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f451_local0, "isDim" ), false )
		else
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f451_local0, "isDim" ), true )
		end
		return f451_local0
	end
}
DataSources.FileshareQuotaList = {
	prepare = function ( f452_arg0, f452_arg1, f452_arg2 )
		f452_arg1.controller = f452_arg0
		f452_arg1.rootModel = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f452_arg0 ), "FileshareQuota" )
		f452_arg1.numFileshareCategories = GetMediaManagerCategoryCount()
	end,
	getCount = function ( f453_arg0 )
		return f453_arg0.numFileshareCategories
	end,
	getItem = function ( f454_arg0, f454_arg1, f454_arg2 )
		local f454_local0 = Engine[0xA798E4552F5E872]( f454_arg1.rootModel, "fileshareCategory_" .. f454_arg2 )
		local f454_local1 = Engine[0xC6F8EC444864600]( CoD.fileShareTable, f454_arg2 - 1, 1 )
		local f454_local2 = Engine[0x1C86C89864CAB6E]( f454_arg1.controller, f454_local1 )
		local f454_local3 = 0
		local f454_local4 = 0
		if f454_local2.categoryQuota > 0 then
			f454_local3 = f454_local2.categorySlotsUsed / f454_local2.categoryQuota
		end
		if f454_local3 > 1 then
			f454_local3 = 1
		elseif f454_local3 < 0 then
			f454_local3 = 0
		end
		if f454_local3 == 1 then
			f454_local4 = 1
		end
		local f454_local5 = CoD.FileshareUtility.CategoryLocStrings[f454_local1].locString or 0x0
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f454_local0, "category" ), f454_local2.category )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f454_local0, "locName" ), f454_local5 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f454_local0, "quota" ), f454_local2.categoryQuota )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f454_local0, "slotsUsed" ), f454_local2.categorySlotsUsed )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f454_local0, "fraction" ), f454_local3 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f454_local0, "image" ), CoD.FileshareUtility.GetCategoryImage( f454_local1 ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f454_local0, "barColor" ), CoD.FileshareUtility.GetCategoryColor( f454_local1 ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f454_local0, "slotsFull" ), f454_local4 )
		if f454_local2.category == CoD.FileshareUtility.GetCurrentCategory() then
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f454_local0, "isDim" ), false )
		else
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f454_local0, "isDim" ), true )
		end
		return f454_local0
	end
}
DataSources.FilesharePublishedList = {
	prepare = function ( f455_arg0, f455_arg1, f455_arg2 )
		f455_arg1.controller = f455_arg0
		f455_arg1.numElements = f455_arg1.vCount * f455_arg1.hCount
		f455_arg1.hasCreateButton = CoD.FileshareUtility.GetShowCreateButton()
		f455_arg1.fileshareRootModel = Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "fileshareRoot" )
		local f455_local0 = "fileshareData_"
		if f455_arg1.filterKey ~= nil and f455_arg1.filterVal ~= nil then
			f455_local0 = "filtered" .. f455_local0
		end
		f455_arg1.fileshareData = {}
		for f455_local1 = 1, f455_arg1.numElements, 1 do
			f455_arg1.fileshareData[f455_local1] = {}
			f455_arg1.fileshareData[f455_local1].elementModel = Engine[0xA798E4552F5E872]( f455_arg1.fileshareRootModel, f455_local0 .. f455_local1 )
			for f455_local7, f455_local8 in ipairs( CoD.FileshareUtility.FileProperties ) do
				Engine[0xA798E4552F5E872]( f455_arg1.fileshareData[f455_local1].elementModel, f455_local8 )
			end
			CoD.FileshareUtility.ResetFileshareSummary( f455_arg1.fileshareData[f455_local1].elementModel )
		end
		Engine[0xA96543D6A13357F]( f455_arg1.controller )
		CoD.FileshareUtility.SetShowFileDetails( false )
	end,
	getCount = function ( f456_arg0 )
		f456_arg0.itemsCount = 0
		if f456_arg0.numElements == nil then
			CoD.FileshareUtility.SetItemsCount( f456_arg0.controller, 0 )
			return 0
		end
		local f456_local0 = true
		local f456_local1 = CoD.FileshareUtility.GetCurrentCategory()
		if f456_local1 == "film" or f456_local1 == "recentgames" then
			local f456_local2 = Engine[0xF3230EBDE32BFB2]()
			if f456_local2 > 0 and f456_local2 < 100 then
				f456_local0 = false
			end
		end
		if f456_local0 and not Engine[0x89C07C2E84B7CAD]( f456_arg0.controller ) then
			if not f456_arg0.refreshElement then
				f456_arg0.refreshElement = LUI.UITimer.newElementTimer( 500, false, function ()
					if Engine[0x89C07C2E84B7CAD]( f456_arg0.controller ) then
						f456_arg0:updateDataSource()
						f456_arg0.refreshElement:close()
						f456_arg0.refreshElement = nil
					end
				end )
				f456_arg0:addElement( f456_arg0.refreshElement )
			end
			CoD.FileshareUtility.SetItemsCount( f456_arg0.controller, 0 )
			return 0
		end
		local f456_local2 = CoD.FileshareUtility.GetCurrentCategory()
		local f456_local3 = CoD.FileshareUtility.GetIsCommunityMode( f456_arg0.controller )
		local f456_local4, f456_local5 = CoD.FileshareUtility.GetCurrentFilter()
		if f456_arg0.filterKey ~= nil and f456_arg0.filterVal ~= nil then
			f456_local4 = f456_arg0.filterKey
			f456_local5 = f456_arg0.filterVal
		end
		if f456_local2 == nil then
			CoD.FileshareUtility.SetItemsCount( f456_arg0.controller, 0 )
			return 0
		end
		local f456_local6 = 0
		if f456_local3 or CoD.FileshareUtility.GetIsGroupsMode( f456_arg0.controller ) or f456_local2 == "film" then
			if f456_local2 == "film" then
				f456_local6 = Engine[0xDCA867889D3BDD9]( f456_arg0.controller, "film", f456_local4, f456_local5 )
			else
				f456_local6 = Engine[0xDCA867889D3BDD9]( f456_arg0.controller, f456_local2, f456_local4, f456_local5 )
			end
		else
			f456_local6 = Engine[0x4EC466F471DFBD9]( f456_arg0.controller, f456_local2, f456_local4, f456_local5 )
		end
		CoD.FileshareUtility.SetItemsCount( f456_arg0.controller, f456_local6 )
		if f456_arg0.hasCreateButton == true then
			return f456_local6 + 1
		end
		f456_arg0.itemsCount = f456_local6
		return f456_local6
	end,
	getItem = function ( f458_arg0, f458_arg1, f458_arg2 )
		local f458_local0 = f458_arg2 - 1
		local f458_local1 = f458_local0 % f458_arg1.numElements + 1
		local f458_local2 = f458_arg2 % f458_arg1.numElements
		if f458_arg1.hasCreateButton == true then
			f458_local0 = f458_local0 - 1
		end
		local f458_local3 = Engine[0x40E824FE270E174]( f458_arg1.fileshareData[f458_local1].elementModel, "isPublishNew" )
		local f458_local4 = Engine[0x40E824FE270E174]( f458_arg1.fileshareData[f458_local1].elementModel, "showPlusImage" )
		local f458_local5 = Engine[0x40E824FE270E174]( f458_arg1.fileshareData[f458_local1].elementModel, "showFileImage" )
		local f458_local6 = Engine[0x40E824FE270E174]( f458_arg1.fileshareData[f458_local1].elementModel, "plusImageSrc" )
		local f458_local7 = Engine[0x40E824FE270E174]( f458_arg1.fileshareData[f458_local1].elementModel, "fileImage" )
		local f458_local8 = Engine[0x40E824FE270E174]( f458_arg1.fileshareData[f458_local1].elementModel, "fileId" )
		local f458_local9 = Engine[0x40E824FE270E174]( f458_arg1.fileshareData[f458_local1].elementModel, "renderFileId" )
		local f458_local10 = Engine[0x40E824FE270E174]( f458_arg1.fileshareData[f458_local1].elementModel, "gameType" )
		local f458_local11 = Engine[0x40E824FE270E174]( f458_arg1.fileshareData[f458_local1].elementModel, "gameTypeImage" )
		local f458_local12 = Engine[0x40E824FE270E174]( f458_arg1.fileshareData[f458_local1].elementModel, "showGameTypeImage" )
		local f458_local13 = Engine[0x40E824FE270E174]( f458_arg1.fileshareData[f458_local1].elementModel, "slot" )
		local f458_local14 = Engine[0x40E824FE270E174]( f458_arg1.fileshareData[f458_local1].elementModel, "index" )
		local f458_local15 = Engine[0x40E824FE270E174]( f458_arg1.fileshareData[f458_local1].elementModel, "mapName" )
		local f458_local16 = Engine[0x40E824FE270E174]( f458_arg1.fileshareData[f458_local1].elementModel, "duration" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f458_arg1.fileshareData[f458_local1].elementModel, "uiModelIndex" ), f458_local1 )
		Engine[0x83C9B5DE1D9371]( Engine[0x40E824FE270E174]( f458_arg1.fileshareData[f458_local1].elementModel, "codeIndex" ), f458_local0 )
		Engine[0x83C9B5DE1D9371]( Engine[0x40E824FE270E174]( f458_arg1.fileshareData[f458_local1].elementModel, "totalItems" ), f458_arg1.itemsCount )
		Engine[0x83C9B5DE1D9371]( Engine[0x40E824FE270E174]( f458_arg1.fileshareData[f458_local1].elementModel, "showDetailsViewSpinner" ), 0 )
		Engine[0x83C9B5DE1D9371]( f458_local8, nil )
		if f458_arg1.hasCreateButton == true and f458_arg2 == 1 then
			Engine[0x83C9B5DE1D9371]( f458_local3, true )
			Engine[0x83C9B5DE1D9371]( f458_local4, 1 )
			Engine[0x83C9B5DE1D9371]( f458_local7, "" )
			Engine[0x83C9B5DE1D9371]( f458_local5, 0 )
			Engine[0x83C9B5DE1D9371]( f458_local9, 0 )
			Engine[0x83C9B5DE1D9371]( f458_local6, "uie_t7_icon_codpoints" )
			Engine[0x83C9B5DE1D9371]( f458_local16, 0 )
			Engine[0x83C9B5DE1D9371]( f458_local15, "" )
			Engine[0x83C9B5DE1D9371]( f458_local12, 0 )
			Engine[0x83C9B5DE1D9371]( f458_local11, "" )
			local f458_local17 = CoD.FileshareUtility.GetInShowcaseManager( f458_arg0 )
			local f458_local18 = Engine[0x40E824FE270E174]( f458_arg1.fileshareData[f458_local1].elementModel, "fileName" )
			if f458_local17 and f458_local17 == true then
				Engine[0x83C9B5DE1D9371]( f458_local18, 0xE16CE893CADAD65 )
			else
				Engine[0x83C9B5DE1D9371]( f458_local18, Engine[0xF9F1239CFD921FE]( 0x268D49B69383695 ) )
			end
		else
			Engine[0x83C9B5DE1D9371]( f458_local3, false )
			Engine[0x83C9B5DE1D9371]( f458_local7, "" )
			Engine[0x83C9B5DE1D9371]( f458_local4, 0 )
			local f458_local17 = CoD.FileshareUtility.GetCurrentCategory()
			local f458_local18 = CoD.FileshareUtility.GetIsCommunityMode( f458_arg1.controller )
			local f458_local19, f458_local20 = CoD.FileshareUtility.GetCurrentFilter()
			if f458_arg1.filterKey ~= nil and f458_arg1.filterVal ~= nil then
				f458_local19 = f458_arg1.filterKey
				f458_local20 = f458_arg1.filterVal
			end
			if f458_local17 == "recentgames" or f458_local17 == "film" or f458_local17 == "customgame" then
				Engine[0x83C9B5DE1D9371]( f458_local12, 1 )
			else
				Engine[0x83C9B5DE1D9371]( f458_local12, 0 )
			end
			if f458_local17 == "clip" or f458_local17 == "clip_private" or f458_local17 == "recentgames" or f458_local17 == "film" or f458_local17 == "customgame" then
				Engine[0x83C9B5DE1D9371]( f458_local5, 0 )
			else
				Engine[0x83C9B5DE1D9371]( f458_local5, 1 )
			end
			local f458_local21 = nil
			if f458_local18 or CoD.FileshareUtility.GetIsGroupsMode( f458_arg1.controller ) or f458_local17 == "recentgames" or f458_local17 == "film" then
				if f458_local17 == "recentgames" or f458_local17 == "film" then
					f458_local21 = Engine[0x2F2078BB6D9DA7]( f458_arg1.controller, "film", f458_local19, f458_local20, f458_local0 )
				else
					f458_local21 = Engine[0x2F2078BB6D9DA7]( f458_arg1.controller, f458_local17, f458_local19, f458_local20, f458_local0 )
				end
			else
				f458_local21 = Engine[0x5855BBD7F4E2242]( f458_arg1.controller, f458_local17, f458_local19, f458_local20, f458_local0 )
			end
			for f458_local25, f458_local26 in ipairs( CoD.FileshareUtility.FileProperties ) do
				if f458_local21[f458_local26] ~= nil then
					Engine[0x83C9B5DE1D9371]( Engine[0x40E824FE270E174]( f458_arg1.fileshareData[f458_local1].elementModel, f458_local26 ), f458_local21[f458_local26] )
				end
			end
			f458_local22 = Engine[0x9E49617B35BC1CC]( f458_arg0, f458_local21.fileId )
			f458_local23 = ""
			if f458_local21.weaponIndex ~= nil and f458_local21.weaponIndex ~= 0 then
				Engine[0x83C9B5DE1D9371]( Engine[0x40E824FE270E174]( f458_arg1.fileshareData[f458_local1].elementModel, "weaponName" ), Engine[0xB03220D3A4F3E38]( Engine[0xF9F1239CFD921FE]( Engine[0x6B7AC889104DED3]( f458_local21.weaponIndex ) ) ) )
			end
			CoD.FileshareUtility.SetupDefaultNameAndDescription( f458_arg1.fileshareData[f458_local1].elementModel )
			CoD.FileshareUtility.SetCategoryCurrentPage( f458_arg0, f458_local17, f458_local0 )
			if f458_local17 == "screenshot_private" or f458_local17 == "screenshot" or f458_local17 == "clip_private" or f458_local17 == "clip" then
				Engine[0x6E7D8812705E6A0]( f458_arg0, Enum[0xBC604DA292437E4][0x32D90B2AD4019FE], f458_local21.fileId, f458_local21.fileSummarySize )
			end
			if f458_local21.isValid == false then
				Engine[0x83C9B5DE1D9371]( f458_local12, 0 )
			end
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f458_arg1.fileshareData[f458_local1].elementModel, "action" ), function ( f459_arg0, f459_arg1, f459_arg2, f459_arg3, f459_arg4 )
				if Engine[0xA55C3ACD0D2BCF0]() then
					CoD.FileshareUtility.Delete( f459_arg0, f459_arg1, f459_arg2, f459_arg3, f459_arg4 )
				elseif CoD.FileshareUtility.IsCategoryFilm( f459_arg2, f459_arg1 ) or CoD.FileshareUtility.IsCategoryClip( f459_arg2, f459_arg1 ) then
					if not IsInTheaterMode() then
						LuaUtils.UI_ShowErrorMessageDialog( f459_arg2, 0x5BF9B60809C0BC6 )
						Engine[0x6ABA4D7F0840A1E]( f459_arg2, "menu_change" .. Engine[0x7192908F4764ED3]( f459_arg2 ), {
							menu = "Main",
							status = "closeToMenu"
						} )
					else
						CoD.FileshareUtility.LoadTheaterFile( f459_arg0, f459_arg1, f459_arg2, f459_arg3, f459_arg4 )
						CoD.OverlayUtility.CreateOverlay( f459_arg2, f459_arg0, "DownloadingDemoFile" )
					end
				elseif CoD.FileshareUtility.GetCurrentCategory() == "customgame" then
					if IsCustomMPLobby() then
						OpenOverlay( f459_arg0, "CustomGamesLoadFileshareItem", f459_arg2 )
					else
						LuaUtils.UI_ShowErrorMessageDialog( f459_arg2, 0x8284F190C0BE1BB )
					end
				else
					FileshareSetSelectedItem( f459_arg0, f459_arg1, f459_arg2, "true" )
					if FileshareCanOpenDetailsView( f459_arg1, f459_arg2 ) == true then
						FileshareOpenFullscreenView( f459_arg0, f459_arg1, f459_arg2, f459_arg4 )
					end
				end
			end )
		end
		return f458_arg1.fileshareData[f458_local1].elementModel
	end
}
DataSources.FileshareCommunityList = {
	prepare = function ( f460_arg0, f460_arg1, f460_arg2 )
		f460_arg1.controller = f460_arg0
		f460_arg1.hasCreateButton = false
		f460_arg1.numElements = f460_arg1.vCount * f460_arg1.hCount
		f460_arg1.fileshareRootModel = Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "fileshareRoot" )
		f460_arg1.fileshareData = {}
		for f460_local0 = 1, f460_arg1.numElements, 1 do
			f460_arg1.fileshareData[f460_local0] = {}
			f460_arg1.fileshareData[f460_local0].elementModel = Engine[0xA798E4552F5E872]( f460_arg1.fileshareRootModel, "fileshareData_community_" .. f460_local0 )
			for f460_local6, f460_local7 in ipairs( CoD.FileshareUtility.FileProperties ) do
				Engine[0xA798E4552F5E872]( f460_arg1.fileshareData[f460_local0].elementModel, f460_local7 )
			end
			CoD.FileshareUtility.ResetFileshareSummary( f460_arg1.fileshareData[f460_local0].elementModel )
		end
		CoD.FileshareUtility.SetItemsCount( f460_arg1.controller, f460_arg1.numElements )
		Engine[0xA96543D6A13357F]( f460_arg1.controller )
		CoD.FileshareUtility.SetShowFileDetails( false )
		CoD.FileshareUtility.SetShowPublishNewDetails( false )
	end,
	getCount = function ( f461_arg0 )
		local f461_local0 = true
		local f461_local1 = CoD.FileshareUtility.GetCurrentCategory()
		f461_arg0.itemsCount = 0
		if f461_local1 == "film" or f461_local1 == "recentgames" then
			local f461_local2 = Engine[0xF3230EBDE32BFB2]()
			if f461_local2 > 0 and f461_local2 < 100 then
				f461_local0 = false
			end
		end
		if f461_local0 and not Engine[0x89C07C2E84B7CAD]( f461_arg0.controller ) then
			CoD.FileshareUtility.SetItemsCount( f461_arg0.controller, 0 )
			return 0
		else
			local f461_local2, f461_local3 = CoD.FileshareUtility.GetCurrentFilter()
			if f461_local1 == nil then
				CoD.FileshareUtility.SetItemsCount( f461_arg0.controller, 0 )
				return 0
			else
				local f461_local4 = Engine[0xDCA867889D3BDD9]( f461_arg0.controller, f461_local1, f461_local2, f461_local3 )
				CoD.FileshareUtility.SetItemsCount( f461_arg0.controller, f461_local4 )
				f461_arg0.itemsCount = f461_local4
				return f461_local4
			end
		end
	end,
	getItem = function ( f462_arg0, f462_arg1, f462_arg2 )
		local f462_local0 = f462_arg2 - 1
		local f462_local1 = f462_local0 % f462_arg1.numElements + 1
		local f462_local2 = f462_arg2 % f462_arg1.numElements
		local f462_local3 = Engine[0x40E824FE270E174]( f462_arg1.fileshareData[f462_local1].elementModel, "isPublishNew" )
		local f462_local4 = Engine[0x40E824FE270E174]( f462_arg1.fileshareData[f462_local1].elementModel, "showPlusImage" )
		local f462_local5 = Engine[0x40E824FE270E174]( f462_arg1.fileshareData[f462_local1].elementModel, "showFileImage" )
		local f462_local6 = Engine[0x40E824FE270E174]( f462_arg1.fileshareData[f462_local1].elementModel, "fileImage" )
		local f462_local7 = Engine[0x40E824FE270E174]( f462_arg1.fileshareData[f462_local1].elementModel, "fileId" )
		local f462_local8 = Engine[0x40E824FE270E174]( f462_arg1.fileshareData[f462_local1].elementModel, "renderFileId" )
		local f462_local9 = Engine[0x40E824FE270E174]( f462_arg1.fileshareData[f462_local1].elementModel, "showGameTypeImage" )
		Engine[0x83C9B5DE1D9371]( Engine[0x40E824FE270E174]( f462_arg1.fileshareData[f462_local1].elementModel, "codeIndex" ), f462_local0 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f462_arg1.fileshareData[f462_local1].elementModel, "uiModelIndex" ), f462_local1 )
		Engine[0x83C9B5DE1D9371]( Engine[0x40E824FE270E174]( f462_arg1.fileshareData[f462_local1].elementModel, "totalItems" ), f462_arg1.itemsCount )
		Engine[0x83C9B5DE1D9371]( Engine[0x40E824FE270E174]( f462_arg1.fileshareData[f462_local1].elementModel, "showDetailsViewSpinner" ), 0 )
		Engine[0x83C9B5DE1D9371]( f462_local3, false )
		Engine[0x83C9B5DE1D9371]( f462_local6, "" )
		Engine[0x83C9B5DE1D9371]( f462_local4, 0 )
		Engine[0x83C9B5DE1D9371]( f462_local8, 0 )
		local f462_local10 = CoD.FileshareUtility.GetCurrentCategory()
		local f462_local11, f462_local12 = CoD.FileshareUtility.GetCurrentFilter()
		if f462_local10 == "clip" or f462_local10 == "clip_private" or f462_local10 == "recentgames" or f462_local10 == "film" or f462_local10 == "customgame" then
			Engine[0x83C9B5DE1D9371]( f462_local5, 0 )
		else
			Engine[0x83C9B5DE1D9371]( f462_local5, 1 )
		end
		local f462_local13 = Engine[0x2F2078BB6D9DA7]( f462_arg1.controller, f462_local10, f462_local11, f462_local12, f462_local0 )
		for f462_local17, f462_local18 in ipairs( CoD.FileshareUtility.FileProperties ) do
			if f462_local13[f462_local18] ~= nil then
				Engine[0x83C9B5DE1D9371]( Engine[0x40E824FE270E174]( f462_arg1.fileshareData[f462_local1].elementModel, f462_local18 ), f462_local13[f462_local18] )
			end
		end
		if f462_local10 == "customgame" then
			Engine[0x83C9B5DE1D9371]( f462_local9, 1 )
		else
			Engine[0x83C9B5DE1D9371]( f462_local9, 0 )
		end
		f462_local14 = ""
		if f462_local13.weaponIndex ~= nil and f462_local13.weaponIndex ~= 0 then
			Engine[0x83C9B5DE1D9371]( Engine[0x40E824FE270E174]( f462_arg1.fileshareData[f462_local1].elementModel, "weaponName" ), Engine[0xB03220D3A4F3E38]( Engine[0xF9F1239CFD921FE]( Engine[0x6B7AC889104DED3]( f462_local13.weaponIndex ) ) ) )
		end
		CoD.FileshareUtility.SetupDefaultNameAndDescription( f462_arg1.fileshareData[f462_local1].elementModel )
		CoD.FileshareUtility.SetCategoryCurrentPage( f462_arg0, f462_local10, f462_local0 )
		f462_local15 = function ( f463_arg0, f463_arg1, f463_arg2, f463_arg3, f463_arg4 )
			if CoD.FileshareUtility.IsCategoryFilm( f463_arg2, f463_arg1 ) or CoD.FileshareUtility.IsCategoryClip( f463_arg2, f463_arg1 ) then
				if not IsInTheaterMode() then
					LuaUtils.UI_ShowErrorMessageDialog( f463_arg2, 0x5BF9B60809C0BC6 )
				else
					local f463_local0 = Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f463_arg1:getModel(), "mainMode" ) )
					if f463_local0 ~= Engine[0x3EAC408F958FF05]() then
						local f463_local1 = ""
						if f463_local0 == Enum[0x9C0C2196D8313A0][0x3723205FAE52C4A] then
							f463_local1 = Engine[0xF9F1239CFD921FE]( 0x58DA4C1486566B5, 0x6282749A064CB35 )
						else
							f463_local1 = Engine[0xF9F1239CFD921FE]( 0x58DA4C1486566B5, 0x55D96CC762EABDD )
						end
						LuaUtils.UI_ShowErrorMessageDialog( f463_arg2, f463_local1 )
					else
						CoD.FileshareUtility.LoadTheaterFile( f463_arg0, f463_arg1, f463_arg2, f463_arg3, f463_arg4 )
						GoBack( f463_arg0, f463_arg2 )
					end
				end
			elseif CoD.FileshareUtility.GetCurrentCategory() == "customgame" then
				if IsCustomMPLobby() then
					OpenOverlay( f463_arg0, "CustomGamesLoadFileshareItem", f463_arg2 )
				else
					LuaUtils.UI_ShowErrorMessageDialog( f463_arg2, 0x8284F190C0BE1BB )
				end
			else
				FileshareSetSelectedItem( f463_arg0, f463_arg1, f463_arg2, "true" )
				if FileshareCanOpenDetailsView( f463_arg1, f463_arg2 ) == true then
					FileshareOpenFullscreenView( f463_arg0, f463_arg1, f463_arg2, f463_arg4 )
				end
			end
		end
		
		if f462_local10 == "screenshot_private" or f462_local10 == "screenshot" or f462_local10 == "clip_private" or f462_local10 == "clip" then
			Engine[0x6E7D8812705E6A0]( f462_arg0, Enum[0xBC604DA292437E4][0x32D90B2AD4019FE], f462_local13.fileId, f462_local13.fileSummarySize )
		end
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f462_arg1.fileshareData[f462_local1].elementModel, "action" ), f462_local15 )
		return f462_arg1.fileshareData[f462_local1].elementModel
	end
}
DataSources.ShowcasePaintjobList = {
	prepare = function ( f464_arg0, f464_arg1, f464_arg2 )
		f464_arg1.controller = f464_arg0
		local f464_local0 = CoD.FileshareUtility.GetCurrentCategory()
		local f464_local1, f464_local2 = CoD.FileshareUtility.GetCurrentFilter()
		CoD.CraftUtility.Paintjobs.ParseDDL( f464_arg0, Enum[0xBBD4F9E70101BA8][0x743B8404C246F61] )
		f464_arg1.paintjobListModel = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f464_arg0 ), "Paintshop.PaintjobList" )
		local f464_local3 = CoD.CraftUtility.Paintjobs.GetTotalUsedPaintjobs()
		if f464_local2 ~= "" then
			f464_local3 = CoD.CraftUtility.Paintjobs.GetTotalWeaponPaintjobsByWeaponGroup( f464_local2 )
		end
		f464_arg1.totalPaintjobs = f464_local3
		f464_arg1.paintjobList = {}
		f464_arg1.paintjobList = CoD.CraftUtility.Paintjobs.GetSortedWeaponPaintjobList( nil, f464_local2 )
	end,
	getCount = function ( f465_arg0 )
		return f465_arg0.totalPaintjobs
	end,
	getItem = function ( f466_arg0, f466_arg1, f466_arg2 )
		local f466_local0 = Engine[0xA798E4552F5E872]( f466_arg1.paintjobListModel, "paintjob_" .. f466_arg2 )
		local f466_local1 = f466_arg1.paintjobList[f466_arg2]
		if f466_local1 then
			if CoD.CraftUtility.Paintjobs.IsPaintjobIndexOccupied( f466_local1.paintjobSlot ) then
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f466_local0, "paintjobName" ), f466_local1.paintjobName )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f466_local0, "paintjobTextEntry" ), f466_local1.paintjobName )
			else
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f466_local0, "paintjobTextEntry" ), Engine[0xF9F1239CFD921FE]( "MENU/PAINTJOB" ) )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f466_local0, "paintjobName" ), "" )
			end
			if f466_local1.readOnly ~= nil then
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f466_local0, "readOnly" ), f466_local1.readOnly )
			end
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f466_local0, "sortIndex" ), f466_local1.sortIndex )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f466_local0, "paintjobSlot" ), f466_local1.paintjobSlot )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f466_local0, "weaponIndex" ), f466_local1.weaponIndex )
			return f466_local0
		else
			
		end
	end
}
DataSources.FileshareCategoriesList = {
	prepare = function ( f467_arg0, f467_arg1, f467_arg2 )
		local f467_local0 = {
			{
				displayText = 0x4335B0D906D9B56,
				displayImage = "uie_t7_mp_icon_header_emblem",
				hintText = 0xD19B1C150547BBC,
				category = "emblem",
				communityDataType = Enum[0x8CAE469B871008F][0xA3B601E34701E8D],
				disabled = false,
				tabWidget = "CoD.FileshareCategoryContentList"
			}
		}
		local f467_local1 = Engine[0xA798E4552F5E872]( Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "FileshareCategoriesList" ), "list" )
		f467_arg1.optionModels = {}
		for f467_local5, f467_local6 in ipairs( f467_local0 ) do
			f467_arg1.optionModels[f467_local5] = Engine[0xA798E4552F5E872]( f467_local1, "buttonModel_" .. f467_local5 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f467_arg1.optionModels[f467_local5], "displayText" ), Engine[0xED84C33EC5F01EA]( f467_local6.displayText ) )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f467_arg1.optionModels[f467_local5], "displayImage" ), f467_local6.displayImage )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f467_arg1.optionModels[f467_local5], "hintText" ), Engine[0xED84C33EC5F01EA]( f467_local6.hintText ) )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f467_arg1.optionModels[f467_local5], "category" ), f467_local6.category )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f467_arg1.optionModels[f467_local5], "disabled" ), f467_local6.disabled )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f467_arg1.optionModels[f467_local5], "tabWidget" ), f467_local6.tabWidget )
			if f467_local6.communityDataType then
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f467_arg1.optionModels[f467_local5], "communityDataType" ), f467_local6.communityDataType )
			end
		end
	end,
	getCount = function ( f468_arg0 )
		return #f468_arg0.optionModels
	end,
	getItem = function ( f469_arg0, f469_arg1, f469_arg2 )
		return f469_arg1.optionModels[f469_arg2]
	end
}
DataSources.FileshareCommunityCategoriesList = {
	prepare = function ( f470_arg0, f470_arg1, f470_arg2 )
		local f470_local0 = {}
		table.insert( f470_local0, {
			displayText = 0x7903AA4008142BA,
			displayImage = "uie_t7_mp_icon_header_paintshop",
			hintText = 0x6694DFB46379867,
			category = "paintjob",
			disabled = false,
			tabWidget = "CoD.FileshareCategoryContentList"
		} )
		table.insert( f470_local0, {
			displayText = 0x4335B0D906D9B56,
			displayImage = "uie_t7_mp_icon_header_emblem",
			hintText = 0x9F304C059B0C2E,
			category = "emblem",
			disabled = false,
			tabWidget = "CoD.FileshareCategoryContentList"
		} )
		table.insert( f470_local0, {
			displayText = 0x27307830087A401,
			displayImage = "uie_t7_mp_icon_header_customgames",
			hintText = 0xC3782510A36AEC9,
			category = "customgame",
			disabled = false,
			tabWidget = "CoD.FileshareCategoryContentList"
		} )
		table.insert( f470_local0, {
			displayText = 0xE501541C48F6BD0,
			displayImage = "uie_t7_mp_icon_header_screenshot",
			hintText = 0x23B8169836845F0,
			category = "screenshot",
			disabled = false,
			tabWidget = "CoD.FileshareScreenshotsContentList"
		} )
		table.insert( f470_local0, {
			displayText = 0xCE48A1B4F61DEB4,
			displayImage = "t7_icon_menu_simple_clips",
			hintText = 0xF365EE6FA4B6666,
			category = "clip",
			disabled = false,
			tabWidget = "CoD.FileshareCategoryContentList"
		} )
		local f470_local1 = Engine[0xA798E4552F5E872]( Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "FileshareCategoriesList" ), "list" )
		f470_arg1.optionModels = {}
		for f470_local5, f470_local6 in ipairs( f470_local0 ) do
			f470_arg1.optionModels[f470_local5] = Engine[0xA798E4552F5E872]( f470_local1, "community_buttonModel_" .. f470_local5 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f470_arg1.optionModels[f470_local5], "displayText" ), Engine[0xED84C33EC5F01EA]( f470_local6.displayText ) )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f470_arg1.optionModels[f470_local5], "displayImage" ), f470_local6.displayImage )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f470_arg1.optionModels[f470_local5], "hintText" ), Engine[0xED84C33EC5F01EA]( f470_local6.hintText ) )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f470_arg1.optionModels[f470_local5], "category" ), f470_local6.category )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f470_arg1.optionModels[f470_local5], "disabled" ), f470_local6.disabled )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f470_arg1.optionModels[f470_local5], "tabWidget" ), f470_local6.tabWidget )
		end
	end,
	getCount = function ( f471_arg0 )
		return #f471_arg0.optionModels
	end,
	getItem = function ( f472_arg0, f472_arg1, f472_arg2 )
		return f472_arg1.optionModels[f472_arg2]
	end
}
DataSources.FileshareMyTheaterCategoriesList = ListHelper_SetupDataSource( "FileshareMyTheaterCategoriesList", function ( f473_arg0 )
	local f473_local0 = {}
	if not IsDemoRestrictedBasicMode() then
		table.insert( f473_local0, {
			models = {
				name = 0xE501541C48F6BD0,
				displayImage = "uie_t7_mp_icon_header_screenshot",
				hintText = 0xA8A763436006C4C,
				category = "screenshot_private",
				communityDataType = Enum[0x8CAE469B871008F][0xA3B601E34701E8D],
				tabWidget = "CoD.FileshareCategoryContentList"
			},
			properties = {
				tabId = "screenshots",
				selectIndex = false
			}
		} )
	end
	table.insert( f473_local0, {
		models = {
			name = 0x36B228B7F38867B,
			displayImage = "uie_t7_icon_menu_simple_media_recent",
			hintText = 0x74CB6B54BB7F54B,
			category = "recentgames",
			communityDataType = Enum[0x8CAE469B871008F][0x2F29D56230C4695],
			tabWidget = "CoD.FileshareCategoryContentList"
		},
		properties = {
			tabId = "recentgames",
			selectIndex = true
		}
	} )
	if not IsDemoRestrictedBasicMode() then
		table.insert( f473_local0, {
			models = {
				name = 0xCE48A1B4F61DEB4,
				displayImage = "t7_icon_menu_simple_clips",
				hintText = 0xA8A763436006C4C,
				category = "clip_private",
				communityDataType = Enum[0x8CAE469B871008F][0xA3B601E34701E8D],
				tabWidget = "CoD.FileshareCategoryContentList"
			},
			properties = {
				tabId = "clips",
				selectIndex = false
			}
		} )
	end
	table.insert( f473_local0, {
		models = {
			name = 0x770599226B0553A,
			displayImage = "uie_t7_icon_menu_simple_media_recent",
			hintText = 0x74CB6B54BB7F54B,
			category = "recentgames",
			communityDataType = Enum[0x8CAE469B871008F][0x2F29D56230C4695],
			tabWidget = "CoD.FileshareCategoryContentList"
		},
		properties = {
			tabId = "bookmarkedgames",
			selectIndex = false
		}
	} )
	return f473_local0
end )
DataSources.FileshareOptionsButtonList = ListHelper_SetupDataSource( "FileshareOptionsButtonList", function ( f474_arg0 )
	local f474_local0 = {}
	local f474_local1 = FileshareIsLocalCategory( f474_arg0 )
	if not f474_local1 and FilesshareCanShowVoteOptions( f474_arg0 ) then
		table.insert( f474_local0, {
			displayText = 0xF9AB13BCE2EDB32,
			displayImage = "uie_t7_icon_menu_options_like",
			displayDesc = 0x62ACAE767815CA2,
			action = CoD.FileshareUtility.ReportLike
		} )
		table.insert( f474_local0, {
			displayText = 0x445C36EB6A8A7B0,
			displayImage = "uie_t7_icon_menu_options_dislike",
			displayDesc = 0xDF418B4E06D9918,
			action = CoD.FileshareUtility.ReportDislike
		} )
	end
	if not f474_local1 and FileshareCanDownloadItem( f474_arg0 ) then
		table.insert( f474_local0, {
			displayText = 0x28A5D834251418D,
			displayImage = "t7_icon_menu_options_download",
			displayDesc = 0x38E4CB51F0AB9B7,
			action = CoD.FileshareUtility.DownloadAction
		} )
	end
	if FileshareCanDeleteItem( f474_arg0 ) then
		local f474_local2 = 0xE0F1CAE8E5DDA06
		if f474_local1 then
			f474_local2 = 0xD46527DE8E0E0EA
		end
		table.insert( f474_local0, {
			displayText = 0x8ADA48E694BFE2C,
			displayImage = "t7_icon_menu_simple_delete",
			displayDesc = f474_local2,
			action = CoD.FileshareUtility.Delete
		} )
	end
	if not f474_local1 and FileshareCanShowPlayerDetails( f474_arg0 ) then
		table.insert( f474_local0, {
			displayText = 0xE0254269ED8FFD3,
			displayImage = "t7_icon_menu_simple_media_manager",
			displayDesc = 0xD6D626F56CEC68B,
			action = ShowcaseOpenPlayerDetails
		} )
	end
	local f474_local2 = CoD.FileshareUtility.GetSelectedItemProperty( "fileAuthorName" )
	local f474_local3 = CoD.FileshareUtility.GetSelectedItemProperty( "fileAuthorXuid" )
	if not f474_local1 and f474_local3 ~= Engine[0x93B19E01B1FD1C7]( f474_arg0 ) then
		local f474_local4 = Engine[0xDC3B811A6]( f474_arg0, f474_local3 )
		table.insert( f474_local0, {
			displayText = 0x74834ABE9827A3,
			displayImage = "uie_t7_icon_error_overlays",
			displayDesc = 0x804C18CC814A475,
			action = ShowReportPlayerDialog,
			params = {
				controller = f474_arg0,
				gamertag = f474_local2,
				xuid = f474_local3
			},
			lastInGroup = false
		} )
	end
	if f474_local1 then
		
	elseif FileshareCanShowShowcaseManager( f474_arg0 ) then
		table.insert( f474_local0, {
			displayText = 0x3DD2FCA578D3DC0,
			displayImage = "t7_icon_menu_simple_media_manager",
			displayDesc = 0x54FAB5C62153CE1,
			action = CoD.FileshareUtility.OpenShowcaseManager
		} )
	end
	local f474_local4 = {}
	for f474_local8, f474_local9 in ipairs( f474_local0 ) do
		table.insert( f474_local4, {
			models = {
				displayText = Engine[0xED84C33EC5F01EA]( f474_local9.displayText ),
				icon = f474_local9.displayImage,
				hintText = f474_local9.displayDesc
			},
			properties = {
				action = f474_local9.action,
				actionParam = f474_local9.params
			}
		} )
	end
	return f474_local4
end )
DataSources.FileshareOptionsDeleteButtonList = {
	prepare = function ( f475_arg0, f475_arg1, f475_arg2 )
		local f475_local0 = {
			{
				displayText = 0x8ADA48E694BFE2C,
				displayImage = "",
				displayDesc = 0x27D9AE8D6AE0E23,
				action = CoD.FileshareUtility.DeleteYes
			},
			{
				displayText = 0xC2E92C54C2BE289,
				displayImage = "",
				displayDesc = 0x38E4CB51F0AB9B7,
				action = CoD.FileshareUtility.DeleteNo
			}
		}
		local f475_local1 = Engine[0xA798E4552F5E872]( Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "FileshareOptionsDeleteButtonList" ), "list" )
		f475_arg1.optionModels = {}
		for f475_local5, f475_local6 in ipairs( f475_local0 ) do
			f475_arg1.optionModels[f475_local5] = Engine[0xA798E4552F5E872]( f475_local1, "buttonModel_" .. f475_local5 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f475_arg1.optionModels[f475_local5], "displayText" ), Engine[0xED84C33EC5F01EA]( f475_local6.displayText ) )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f475_arg1.optionModels[f475_local5], "displayImage" ), f475_local6.displayImage )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f475_arg1.optionModels[f475_local5], "hintText" ), Engine[0xED84C33EC5F01EA]( f475_local6.displayDesc ) )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f475_arg1.optionModels[f475_local5], "action" ), f475_local6.action )
		end
	end,
	getCount = function ( f476_arg0 )
		return #f476_arg0.optionModels
	end,
	getItem = function ( f477_arg0, f477_arg1, f477_arg2 )
		return f477_arg1.optionModels[f477_arg2]
	end
}
DataSources.FileshareSlotsFullButtonList = {
	prepare = function ( f478_arg0, f478_arg1, f478_arg2 )
		local f478_local0 = {}
		if FileshareShowcaseSlotsAvailable( f478_arg0 ) == false then
			if Engine[0xA55C3ACD0D2BCF0]() then
				
			else
				table.insert( f478_local0, {
					displayText = 0x84B4D57F67E6320,
					displayImage = "",
					displayDesc = 0x27D9AE8D6AE0E23,
					action = CoD.FileshareUtility.OpenShowcaseManager
				} )
			end
			if FileshareCanBuyMoreSlots( f478_arg0 ) == true then
				table.insert( f478_local0, {
					displayText = 0xE16CE893CADAD65,
					displayImage = "",
					displayDesc = 0x38E4CB51F0AB9B7,
					action = CoD.FileshareUtility.OpenBuySlots
				} )
			end
		end
		local f478_local1 = Engine[0xA798E4552F5E872]( Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "FileshareSlotsFullButtonList" ), "list" )
		f478_arg1.optionModels = {}
		for f478_local5, f478_local6 in ipairs( f478_local0 ) do
			f478_arg1.optionModels[f478_local5] = Engine[0xA798E4552F5E872]( f478_local1, "buttonModel_" .. f478_local5 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f478_arg1.optionModels[f478_local5], "displayText" ), Engine[0xED84C33EC5F01EA]( f478_local6.displayText ) )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f478_arg1.optionModels[f478_local5], "displayImage" ), f478_local6.displayImage )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f478_arg1.optionModels[f478_local5], "hintText" ), Engine[0xED84C33EC5F01EA]( f478_local6.displayDesc ) )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f478_arg1.optionModels[f478_local5], "action" ), f478_local6.action )
		end
	end,
	getCount = function ( f479_arg0 )
		return #f479_arg0.optionModels
	end,
	getItem = function ( f480_arg0, f480_arg1, f480_arg2 )
		return f480_arg1.optionModels[f480_arg2]
	end
}
DataSources.SelectedStorageFileType = {
	getModel = function ( f481_arg0 )
		local f481_local0 = Engine[0x40E824FE270E174]( Engine[0x4DF5CFBC1771947]( f481_arg0 ), "Craft.SelectedStorageFileType" )
		if not f481_local0 then
			f481_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f481_arg0 ), "Craft.SelectedStorageFileType" )
			local f481_local1 = f481_local0:create( "storageFileType" )
			f481_local1:set( CoD.perController[f481_arg0].selectedEmblemTabStorageType )
		end
		return f481_local0
	end
}
DataSources.CraftSlots = {
	getModel = function ( f482_arg0 )
		local f482_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f482_arg0 ), "Craft.CraftSlots" )
		local f482_local1 = DataSources.SlotCustomization.getModel( f482_arg0 )
		local f482_local2 = CoD.CraftUtility.GetStorageFileTypeFromCustomiztionType( f482_arg0, f482_local1.type:get() )
		local f482_local3 = CoD.CraftUtility.GetUsedSlotsByFileType( f482_arg0, f482_local2 )
		local f482_local4 = CoD.CraftUtility.GetTotalAllowedSlotsByFileType( f482_arg0, f482_local2 )
		local f482_local5 = f482_local0:create( "usedSlots" )
		f482_local5:set( f482_local3 )
		f482_local5 = f482_local0:create( "totalSlots" )
		f482_local5:set( f482_local4 )
		f482_local5 = f482_local0:create( "percent" )
		f482_local5:set( f482_local3 / math.max( f482_local4, 1 ) )
		return f482_local0
	end
}
DataSources.EmblemEditing = {
	getModel = function ( f483_arg0 )
		return CoD.perController[f483_arg0].selectedEmblemModel
	end
}
DataSources.CraftClipboard = {
	getModel = function ( f484_arg0 )
		local f484_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f484_arg0 ), "Craft.Clipboard" )
		local f484_local1 = Engine[0xB3DF0B6F944FF42]( f484_arg0, Enum[0x63E5ADF9D95FC86].CUSTOMIZATION_TYPE_CLIPBOARD, CoD.perController[f484_arg0].totalLayers )
		local f484_local2 = f484_local0:create( "layerCount" )
		f484_local2:set( f484_local1 )
		return f484_local0
	end
}
DataSources.EmblemEditorOptionsList = ListHelper_SetupDataSource( "EmblemEditorOptionsList", function ( f485_arg0 )
	local f485_local0 = {}
	local f485_local1 = CraftSlotsFullByStorageType( f485_arg0, Enum[0xBBD4F9E70101BA8][0x791C91FD2327632] )
	local f485_local2 = CoD.perController[f485_arg0].selectedEmblemModel
	local f485_local3 = Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f485_local2, "isUsed" ) ) == 1
	if not IsPreBuiltEmblemTab( f485_arg0 ) then
		local f485_local4 = 0x5C0A6F0BCEAC8DF
		local f485_local5 = 0x5C0A6F0BCEAC8DF
		if not f485_local3 then
			f485_local4 = 0xE738001B1CB1269
			f485_local5 = 0xE738001B1CB1269
		end
		table.insert( f485_local0, {
			displayText = f485_local4,
			displayDesc = f485_local5,
			action = function ( f486_arg0, f486_arg1, f486_arg2, f486_arg3, f486_arg4 )
				if f485_local3 then
					CoD.CraftUtility.EmblemEditor_SaveEmblemAndEdit( f486_arg4, f486_arg1, f486_arg2, f485_local2, false )
					CoD.CraftUtility.CraftSaveToast( f486_arg0, Engine[0xF9F1239CFD921FE]( 0x28FF18BE5246100 ) )
					GoBack( f486_arg0 )
				else
					CoD.CraftUtility.EmblemEditor_OpenSavePopup( GoBack( f486_arg0, f486_arg2 ), f486_arg1, f486_arg2, f486_arg4, false )
				end
			end,
			disabled = not CoD.CraftUtility.Emblems_HasChanges( nil, f485_arg0 )
		} )
	end
	if f485_local3 then
		table.insert( f485_local0, {
			displayText = 0xCDD21EE3622D1D1,
			displayDesc = 0xCDD21EE3622D1D1,
			action = function ( f487_arg0, f487_arg1, f487_arg2, f487_arg3, f487_arg4 )
				local f487_local0 = IsPreBuiltEmblemTab( f487_arg2 ) or f485_local3
				CoD.CraftUtility.EmblemEditor_SaveEmblemAndEdit( f487_arg4, f487_arg1, f487_arg2, f485_local2, f487_local0 )
				if f487_local0 then
					ForceNotifyModel( f487_arg2, "Emblem.UpdateDataSource" )
				end
				CoD.CraftUtility.CraftSaveToast( f487_arg0, Engine[0xF9F1239CFD921FE]( 0x28FF18BE5246100 ) )
				GoBack( f487_arg0 )
			end,
			disabled = f485_local1
		} )
		if not IsPreBuiltEmblemTab( f485_arg0 ) then
			table.insert( f485_local0, {
				displayText = 0x30BBCC54CF2C2AE,
				displayDesc = 0x30BBCC54CF2C2AE,
				action = function ( f488_arg0, f488_arg1, f488_arg2, f488_arg3, f488_arg4 )
					ShowKeyboard( f488_arg0, f488_arg1, f488_arg2, "KEYBOARD_TYPE_EMBLEMS" )
				end,
				disabled = false
			} )
		end
	end
	table.insert( f485_local0, {
		displayText = 0x5F3FC891FEA13A7,
		displayDesc = 0x5F3FC891FEA13A7,
		action = function ( f489_arg0, f489_arg1, f489_arg2, f489_arg3, f489_arg4 )
			if CoD.CraftUtility.Emblems_HasChanges( f489_arg0, f489_arg2 ) then
				CoD.CraftUtility.EmblemEditor_OpenSavePopup( GoBack( f489_arg0, f489_arg2 ), f489_arg1, f489_arg2, f489_arg4, true )
			else
				CoD.CraftUtility.EmblemEditor_ReturnToSelect( f489_arg0, f489_arg1, f489_arg2 )
				ForceNotifyModel( f489_arg2, "Emblem.UpdateDataSource" )
			end
		end,
		disabled = false
	} )
	local f485_local4 = {}
	for f485_local8, f485_local9 in ipairs( f485_local0 ) do
		table.insert( f485_local4, {
			models = {
				displayText = f485_local9.displayText,
				description = f485_local9.displayDesc,
				action = f485_local9.action,
				param = f485_local9.param
			},
			properties = {
				disabled = f485_local9.disabled
			}
		} )
	end
	return f485_local4
end )
DataSources.EmblemOptionsButtonList = ListHelper_SetupDataSource( "EmblemOptionsButtonList", function ( f490_arg0 )
	local f490_local0 = {}
	local f490_local1 = false
	local f490_local2 = false
	local f490_local3 = false
	local f490_local4 = CraftSlotsFullByStorageType( f490_arg0, Enum[0xBBD4F9E70101BA8][0x791C91FD2327632] )
	local f490_local5 = CoD.perController[f490_arg0].selectedEmblemModel
	if f490_local5 then
		local f490_local6 = Engine[0x40E824FE270E174]( f490_local5, "readOnly" )
		if f490_local6 then
			local f490_local7 = Engine[0x614D394F6F9A18D]( f490_local6 )
			if f490_local7 and f490_local7 == 1 then
				f490_local3 = true
			end
		end
	end
	if f490_local4 == true or f490_local3 == true then
		f490_local1 = true
	end
	local f490_local6 = 0x19523BBDFAA26A
	if f490_local3 == true then
		f490_local2 = true
		f490_local6 = 0xDF51E7C509B4814
	else
		
	end
	table.insert( f490_local0, {
		displayText = 0x8ADA48E694BFE2C,
		displayImage = "t7_icon_menu_simple_delete",
		displayDesc = 0x9BE1658124CBFFF,
		action = function ( f491_arg0, f491_arg1, f491_arg2, f491_arg3, f491_arg4 )
			CoD.CraftUtility.EmblemClear( f491_arg0, f491_arg1, f491_arg2, f491_arg3, f491_arg4 )
			GoBack( f491_arg0, f491_arg2 )
		end,
		disabled = false
	} )
	table.insert( f490_local0, {
		displayText = 0x5AEC3D591F4359E,
		displayImage = "t7_icon_menu_simple_copy",
		displayDesc = 0xB71D881428A80C9,
		action = function ( f492_arg0, f492_arg1, f492_arg2, f492_arg3, f492_arg4 )
			CoD.CraftUtility.EmblemSelect_CopyEmblem( f492_arg0, f492_arg1, f492_arg2, f492_arg4 )
			GoBack( f492_arg0, f492_arg2 )
		end,
		disabled = f490_local1
	} )
	if not CoD.isPC then
		table.insert( f490_local0, {
			displayText = 0x9EF028EFD188F05,
			displayImage = "t7_icon_menu_simple_rename",
			displayDesc = 0x60F60FD8E452A1C,
			action = CoD.CraftUtility.EmblemRename,
			disabled = false
		} )
	end
	if CanShowMediaManager() then
		table.insert( f490_local0, {
			displayText = 0x4C3EEA8A4B1E631,
			displayImage = "t7_icon_menu_simple_media_manager",
			displayDesc = 0x9BEC0DFABD8888B,
			action = GoBackAndOpenMediaManagerOnParent,
			param = "emblem",
			disabled = false
		} )
	end
	local f490_local7 = {}
	for f490_local11, f490_local12 in ipairs( f490_local0 ) do
		table.insert( f490_local7, {
			models = {
				displayText = f490_local12.displayText,
				icon = f490_local12.displayImage,
				description = f490_local12.displayDesc,
				action = f490_local12.action,
				param = f490_local12.param
			},
			properties = {
				disabled = f490_local12.disabled
			}
		} )
	end
	return f490_local7
end )
DataSources.SelectedDecalGroup = {
	getModel = function ( f493_arg0 )
		return CoD.perController[f493_arg0].selectedDecalGroupModel
	end
}
DataSources.DecalGroupOptionsList = ListHelper_SetupDataSource( "DecalGroupOptionsList", function ( f494_arg0 )
	local f494_local0 = {}
	table.insert( f494_local0, {
		displayText = 0x8ADA48E694BFE2C,
		displayDesc = 0x8ADA48E694BFE2C,
		action = function ( f495_arg0, f495_arg1, f495_arg2, f495_arg3, f495_arg4 )
			CoD.CraftUtility.EmblemChooseIcon_ClearDecalGroup( f495_arg0, f495_arg1, f495_arg2 )
			GoBack( f495_arg0, f495_arg2 )
			ForceNotifyModel( f495_arg2, "DecalGroups.UpdateDataSource" )
		end
	} )
	if not CoD.isPC then
		table.insert( f494_local0, {
			displayText = 0x9EF028EFD188F05,
			displayDesc = 0x9EF028EFD188F05,
			action = function ( f496_arg0, f496_arg1, f496_arg2, f496_arg3, f496_arg4 )
				ShowKeyboard( f496_arg4, f496_arg1, f496_arg2, "KEYBOARD_TYPE_DECAL_GROUPS" )
			end
		} )
	end
	local f494_local1 = {}
	for f494_local5, f494_local6 in ipairs( f494_local0 ) do
		table.insert( f494_local1, {
			models = {
				displayText = f494_local6.displayText,
				description = f494_local6.displayDesc,
				action = f494_local6.action,
				param = f494_local6.param
			},
			properties = {
				disabled = f494_local6.disabled
			}
		} )
	end
	return f494_local1
end )
DataSources.SelectedPaintjob = {
	getModel = function ( f497_arg0 )
		return CoD.perController[f497_arg0].selectedPaintjobModel
	end
}
DataSources.PaintjobOptionsButtonList = ListHelper_SetupDataSource( "PaintjobOptionsButtonList", function ( f498_arg0 )
	local f498_local0 = {}
	local f498_local1 = false
	local f498_local2 = false
	local f498_local3 = false
	local f498_local4 = CraftSlotsFullByStorageType( f498_arg0, Enum[0xBBD4F9E70101BA8][0x743B8404C246F61] )
	local f498_local5 = CoD.perController[f498_arg0].selectedPaintjobModel
	if f498_local5 then
		local f498_local6 = Engine[0x40E824FE270E174]( f498_local5, "readOnly" )
		if f498_local6 then
			local f498_local7 = Engine[0x614D394F6F9A18D]( f498_local6 )
			if f498_local7 and f498_local7 == 1 then
				f498_local3 = true
			end
		end
	end
	if f498_local4 == true or f498_local3 == true then
		f498_local1 = true
	end
	local f498_local6 = 0xDD563C0A8BF1694
	if f498_local3 == true then
		f498_local2 = true
		f498_local6 = 0xDF51E7C509B4814
	end
	table.insert( f498_local0, {
		displayText = 0x8ADA48E694BFE2C,
		displayImage = "t7_icon_menu_simple_delete",
		displayDesc = 0x499B64FA62DD766,
		action = function ( f499_arg0, f499_arg1, f499_arg2, f499_arg3, f499_arg4 )
			CoD.CraftUtility.PaintjobClear( f499_arg0, f499_arg1, f499_arg2, f499_arg3, f499_arg4 )
			GoBack( f499_arg0, f499_arg2 )
		end,
		disabled = false
	} )
	table.insert( f498_local0, {
		displayText = 0x5AEC3D591F4359E,
		displayImage = "t7_icon_menu_simple_copy",
		displayDesc = 0x25139323E2D80F0,
		action = function ( f500_arg0, f500_arg1, f500_arg2, f500_arg3, f500_arg4 )
			PaintjobSelector_CopyPaintjob( f500_arg0, f500_arg1, f500_arg2, f500_arg3, f500_arg4 )
			GoBack( f500_arg0, f500_arg2 )
		end,
		disabled = f498_local1
	} )
	if not CoD.isPC then
		table.insert( f498_local0, {
			displayText = 0x9EF028EFD188F05,
			displayImage = "t7_icon_menu_simple_rename",
			displayDesc = 0x89183EFAA3E7211,
			action = CoD.CraftUtility.PaintjobRename,
			disabled = false
		} )
	end
	if CanShowMediaManager() then
		table.insert( f498_local0, {
			displayText = 0x4C3EEA8A4B1E631,
			displayImage = "t7_icon_menu_simple_media_manager",
			displayDesc = 0x9BEC0DFABD8888B,
			action = GoBackAndOpenMediaManagerOnParent,
			param = "paintjob",
			disabled = false
		} )
	end
	if Engine[0x3F3A2DF4C779A8F]() then
		table.insert( f498_local0, {
			displayText = "PLATFORM_STEAM_PUBLISH",
			displayImage = "",
			displayDesc = "PLATFORM_STEAM_PUBLISH_DESC",
			action = CoD.CraftUtility.OpenSteamPublishPromptPaintjob
		} )
	end
	local f498_local7 = {}
	for f498_local11, f498_local12 in ipairs( f498_local0 ) do
		table.insert( f498_local7, {
			models = {
				displayText = f498_local12.displayText,
				icon = f498_local12.displayImage,
				description = f498_local12.displayDesc,
				action = f498_local12.action,
				param = f498_local12.param
			},
			properties = {
				disabled = f498_local12.disabled
			}
		} )
	end
	return f498_local7
end )
DataSources.PaintjobEditorOptionsList = ListHelper_SetupDataSource( "PaintjobEditorOptionsList", function ( f501_arg0 )
	local f501_local0 = {}
	local f501_local1 = CoD.perController[f501_arg0].selectedPaintjobModel
	local f501_local2 = CraftSlotsFullByStorageType( f501_arg0, Enum[0xBBD4F9E70101BA8][0x743B8404C246F61] )
	local f501_local3 = Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f501_local1, "weaponIndex" ) ) ~= CoD.CraftUtility.Paintjobs.EMPTY_PAINTJOB_SLOT_WEAPON_INDEX
	local f501_local4 = 0x5C0A6F0BCEAC8DF
	local f501_local5 = 0x5C0A6F0BCEAC8DF
	if not f501_local3 then
		f501_local4 = 0xE738001B1CB1269
		f501_local5 = 0xE738001B1CB1269
	end
	table.insert( f501_local0, {
		displayText = f501_local4,
		displayDesc = f501_local5,
		action = function ( f502_arg0, f502_arg1, f502_arg2, f502_arg3, f502_arg4 )
			if f501_local3 then
				CoD.CraftUtility.PaintjobEditor_SavePaintjobAndEdit( f502_arg4, f502_arg1, f502_arg2, f501_local1, false )
				CoD.CraftUtility.CraftSaveToast( f502_arg0, Engine[0xF9F1239CFD921FE]( 0x28FF18BE5246100 ) )
				GoBack( f502_arg0 )
			else
				CoD.CraftUtility.EmblemEditor_OpenSavePopup( GoBack( f502_arg0, f502_arg2 ), f502_arg1, f502_arg2, f502_arg4, false )
			end
		end,
		disabled = not CoD.CraftUtility.Emblems_HasChanges( nil, f501_arg0 )
	} )
	if f501_local3 then
		table.insert( f501_local0, {
			displayText = 0xCDD21EE3622D1D1,
			displayDesc = 0xCDD21EE3622D1D1,
			action = function ( f503_arg0, f503_arg1, f503_arg2, f503_arg3, f503_arg4 )
				local f503_local0 = f501_local3
				CoD.CraftUtility.PaintjobEditor_SavePaintjobAndEdit( f503_arg4, f503_arg1, f503_arg2, f501_local1, f503_local0 )
				if f503_local0 then
					ForceNotifyModel( f503_arg2, "Paintshop.UpdateDataSource" )
				end
				CoD.CraftUtility.CraftSaveToast( f503_arg0, Engine[0xF9F1239CFD921FE]( 0x28FF18BE5246100 ) )
				GoBack( f503_arg0 )
			end,
			disabled = f501_local2
		} )
		table.insert( f501_local0, {
			displayText = 0x30BBCC54CF2C2AE,
			displayDesc = 0x30BBCC54CF2C2AE,
			action = function ( f504_arg0, f504_arg1, f504_arg2, f504_arg3, f504_arg4 )
				ShowKeyboard( f504_arg0, f504_arg1, f504_arg2, "KEYBOARD_TYPE_PAINTJOB" )
			end,
			disabled = false
		} )
	end
	table.insert( f501_local0, {
		displayText = 0x5F3FC891FEA13A7,
		displayDesc = 0x5F3FC891FEA13A7,
		action = function ( f505_arg0, f505_arg1, f505_arg2, f505_arg3, f505_arg4 )
			if CoD.CraftUtility.Emblems_HasChanges( f505_arg0, f505_arg2 ) then
				CoD.CraftUtility.EmblemEditor_OpenSavePopup( GoBack( f505_arg0, f505_arg2 ), f505_arg1, f505_arg2, f505_arg4, true )
			else
				CoD.CraftUtility.PaintjobEditor_ReturnToSelect( f505_arg0, f505_arg1, f505_arg2 )
				ForceNotifyModel( f505_arg2, "Paintshop.UpdateDataSource" )
			end
		end,
		disabled = false
	} )
	local f501_local6 = {}
	for f501_local10, f501_local11 in ipairs( f501_local0 ) do
		table.insert( f501_local6, {
			models = {
				displayText = f501_local11.displayText,
				description = f501_local11.displayDesc,
				action = f501_local11.action,
				param = f501_local11.param
			},
			properties = {
				disabled = f501_local11.disabled
			}
		} )
	end
	return f501_local6
end )
DataSources.PaintjobLayerOptionsButtonList = ListHelper_SetupDataSource( "PaintjobLayerOptionsButtonList", function ( f506_arg0 )
	local f506_local0 = IsGridOn( f506_arg0, CoD.CraftUtility.GetGridTypeName( f506_arg0 ) )
	local f506_local1 = 0x1B1EADD23B558DA
	local f506_local2 = 0x63AD3EE1BC352AE
	if f506_local0 then
		f506_local1 = 0x68FA1C3AD0EAE2C
		f506_local2 = 0xB323885B5AC6F1C
	end
	local f506_local3 = {
		{
			displayText = f506_local1,
			displayImage = "",
			displayDesc = f506_local2,
			action = PaintjobEditor_ToggleGrid,
			disabled = false
		}
	}
	local f506_local4 = {}
	for f506_local8, f506_local9 in ipairs( f506_local3 ) do
		table.insert( f506_local4, {
			models = {
				displayText = f506_local9.displayText,
				icon = f506_local9.displayImage,
				description = f506_local9.displayDesc,
				action = f506_local9.action
			},
			properties = {
				disabled = f506_local9.disabled
			}
		} )
	end
	return f506_local4
end )
DataSources.GunsmithSnapshotModeButtonList = ListHelper_SetupDataSource( "GunsmithSnapshotModeButtonList", function ( f507_arg0 )
	local f507_local0 = {}
	table.insert( f507_local0, {
		displayText = 0x0,
		displayImage = "t7_menu_gunsmith_statssingle",
		displayDesc = 0x82A1B6744C1A6DF,
		action = Gunsmith_SnapshotToggleDisplayProperty,
		visibilityModelName = "GunsmithSnapshot.Stats"
	} )
	table.insert( f507_local0, {
		displayText = 0x0,
		displayImage = "t7_menu_gunsmith_weaponlevel",
		displayDesc = 0x79B38B37C4A31D,
		action = Gunsmith_SnapshotToggleDisplayProperty,
		visibilityModelName = "GunsmithSnapshot.WeaponLevel"
	} )
	table.insert( f507_local0, {
		displayText = 0x0,
		displayImage = "t7_menu_gunsmith_player",
		displayDesc = 0xB27BE165F75034C,
		action = Gunsmith_SnapshotToggleDisplayProperty,
		visibilityModelName = "GunsmithSnapshot.PlayerID"
	} )
	table.insert( f507_local0, {
		displayText = 0x0,
		displayImage = "t7_menu_gunsmith_weaponname",
		displayDesc = 0x27FF8B6BB77DF06,
		action = Gunsmith_SnapshotToggleDisplayProperty,
		visibilityModelName = "GunsmithSnapshot.WeaponName"
	} )
	table.insert( f507_local0, {
		displayText = 0x0,
		displayImage = "t7_menu_gunsmith_opticattach",
		displayDesc = 0xB5AFE0311749176,
		action = Gunsmith_SnapshotToggleDisplayProperty,
		visibilityModelName = "GunsmithSnapshot.AttachmentIcons"
	} )
	table.insert( f507_local0, {
		displayText = 0x0,
		displayImage = "t7_menu_gunsmith_bo3logo",
		displayDesc = 0x638D4FFF7BEFE93,
		action = Gunsmith_SnapshotToggleDisplayProperty,
		visibilityModelName = "GunsmithSnapshot.BO3Logo"
	} )
	local f507_local1 = {}
	for f507_local5, f507_local6 in ipairs( f507_local0 ) do
		table.insert( f507_local1, {
			models = {
				displayText = f507_local6.displayText,
				icon = f507_local6.displayImage,
				description = f507_local6.displayDesc,
				action = f507_local6.action,
				param = f507_local6.visibilityModelName
			},
			properties = {
				disabled = f507_local6.disabled
			}
		} )
	end
	return f507_local1
end )
DataSources.MediaManagerPaintjobList = {
	prepare = function ( f508_arg0, f508_arg1, f508_arg2 )
		f508_arg1.controller = f508_arg0
		f508_arg1.paintjobListModel = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f508_arg0 ), "MediaManager.PaintjobList" )
		f508_arg1.totalPaintjobs = 0
		f508_arg1.paintjobList = {}
		local f508_local0 = {
			isBuyMore = true,
			sortIndex = 0,
			weaponIndex = 0,
			paintjobSlot = 0
		}
		if FileshareCanBuyMoreSlots( f508_arg0 ) == true then
			table.insert( f508_arg1.paintjobList, f508_local0 )
			f508_arg1.totalPaintjobs = f508_arg1.totalPaintjobs + 1
		end
		for f508_local4, f508_local5 in pairs( CoD.CraftUtility.Paintjobs.GetSortedWeaponPaintjobList() ) do
			if f508_local5.weaponIndex ~= 0 then
				table.insert( f508_arg1.paintjobList, f508_local5 )
				f508_arg1.totalPaintjobs = f508_arg1.totalPaintjobs + 1
			end
		end
	end,
	getCount = function ( f509_arg0 )
		return f509_arg0.totalPaintjobs
	end,
	getItem = function ( f510_arg0, f510_arg1, f510_arg2 )
		local f510_local0 = Engine[0xA798E4552F5E872]( f510_arg1.paintjobListModel, "mm_paintjob_" .. f510_arg2 )
		local f510_local1 = f510_arg1.paintjobList[f510_arg2]
		if f510_local1 then
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f510_local0, "showBuyImage" ), 0 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f510_local0, "isBuyMore" ), false )
			if f510_local1.isBuyMore ~= nil and f510_local1.isBuyMore == true then
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f510_local0, "isBuyMore" ), true )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f510_local0, "showBuyImage" ), 1 )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f510_local0, "sortIndex" ), 1 )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f510_local0, "paintjobName" ), Engine[0xF9F1239CFD921FE]( 0xE16CE893CADAD65 ) )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f510_local0, "plusImageSrc" ), "uie_t7_icon_codpoints" )
			end
			if CoD.CraftUtility.Paintjobs.IsPaintjobIndexOccupied( f510_local1.paintjobSlot ) then
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f510_local0, "paintjobName" ), f510_local1.paintjobName )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f510_local0, "paintjobTextEntry" ), f510_local1.paintjobName )
			end
			CoD.SetCustomization( f510_arg0, f510_local1.weaponIndex, "weapon_index" )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f510_local0, "sortIndex" ), f510_local1.sortIndex )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f510_local0, "weaponIndex" ), f510_local1.weaponIndex )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f510_local0, "paintjobSlot" ), f510_local1.paintjobSlot )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f510_local0, "authorName" ), Engine[0x7015AC6BE5CE5F1]( f510_arg0 ) )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f510_local0, "createTime" ), f510_local1.createTime )
			local f510_local2 = ""
			if f510_local1.weaponIndex ~= nil then
				f510_local2 = Engine[0xB03220D3A4F3E38]( Engine[0xF9F1239CFD921FE]( Engine[0x6B7AC889104DED3]( f510_local1.weaponIndex ) ) )
			end
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f510_local0, "weaponName" ), f510_local2 )
			return f510_local0
		else
			
		end
	end
}
DataSources.ShowcaseEmblemList = {
	prepare = function ( f511_arg0, f511_arg1, f511_arg2 )
		f511_arg1.controller = f511_arg0
		f511_arg1.emblemListModel = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f511_arg0 ), "MediaManager.ShowcaseEmblemList" )
		f511_arg1.totalEmblems = 0
		f511_arg1.emblemList = {}
		for f511_local3, f511_local4 in pairs( CoD.CraftUtility.Emblems.GetSortedEmblemsList( f511_arg0, CoD.perController[f511_arg0].selectedEmblemTabStorageType, false ) ) do
			if f511_local4.isUsed ~= 0 then
				table.insert( f511_arg1.emblemList, f511_local4 )
				f511_arg1.totalEmblems = f511_arg1.totalEmblems + 1
			end
		end
	end,
	getCount = function ( f512_arg0 )
		return f512_arg0.totalEmblems
	end,
	getItem = function ( f513_arg0, f513_arg1, f513_arg2 )
		local f513_local0 = Engine[0xA798E4552F5E872]( f513_arg1.emblemListModel, "mm_emblem_" .. f513_arg2 )
		local f513_local1 = f513_arg1.emblemList[f513_arg2]
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f513_local0, "isBuyMore" ), false )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f513_local0, "showBuyImage" ), 0 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f513_local0, "emblemTitle" ), f513_local1.emblemTitle )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f513_local0, "name" ), f513_local1.emblemName )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f513_local0, "emblemIndex" ), f513_local1.emblemIndex )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f513_local0, "emblemTextEntry" ), f513_local1.emblemTextEntry )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f513_local0, "subTitle" ), f513_local1.subTitle )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f513_local0, "storageFileType" ), CoD.perController[f513_arg0].selectedEmblemTabStorageType )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f513_local0, "isUsed" ), f513_local1.isUsed )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f513_local0, "showBuyImage" ), 0 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f513_local0, "readOnly" ), f513_local1.readOnly )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f513_local0, "isBMClassified" ), false )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f513_local0, "sortIndex" ), f513_local1.sortIndex )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f513_local0, "hintText" ), Engine[0xF9F1239CFD921FE]( 0x6D0E4674E87A8C9 ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f513_local0, "authorName" ), Engine[0x7015AC6BE5CE5F1]( f513_arg0 ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f513_local0, "createTime" ), f513_local1.createTime )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f513_local0, "plusImageSrc" ), "uie_t7_icon_codpoints" )
		return f513_local0
	end
}
DataSources.MediaManagerEmblemList = {
	prepare = function ( f514_arg0, f514_arg1, f514_arg2 )
		f514_arg1.controller = f514_arg0
		f514_arg1.emblemListModel = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f514_arg0 ), "MediaManager.EmblemList" )
		f514_arg1.totalEmblems = 0
		f514_arg1.emblemList = {}
		local f514_local0 = {
			isBuyMore = true,
			sortIndex = 0,
			emblemIndex = 0,
			isUsed = 1
		}
		if FileshareCanBuyMoreSlots( f514_arg0 ) == true then
			table.insert( f514_arg1.emblemList, f514_local0 )
			f514_arg1.totalEmblems = f514_arg1.totalEmblems + 1
		end
		for f514_local4, f514_local5 in pairs( CoD.CraftUtility.Emblems.GetSortedEmblemsList( f514_arg0, CoD.perController[f514_arg0].selectedEmblemTabStorageType, false ) ) do
			if f514_local5.isUsed ~= 0 then
				table.insert( f514_arg1.emblemList, f514_local5 )
				f514_arg1.totalEmblems = f514_arg1.totalEmblems + 1
			end
		end
	end,
	getCount = function ( f515_arg0 )
		return f515_arg0.totalEmblems
	end,
	getItem = function ( f516_arg0, f516_arg1, f516_arg2 )
		local f516_local0 = Engine[0xA798E4552F5E872]( f516_arg1.emblemListModel, "mm_emblem_" .. f516_arg2 )
		local f516_local1 = f516_arg1.emblemList[f516_arg2]
		if f516_local1.isBuyMore and f516_local1.isBuyMore == true then
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f516_local0, "isBuyMore" ), true )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f516_local0, "showBuyImage" ), 1 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f516_local0, "sortIndex" ), 1 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f516_local0, "name" ), Engine[0xF9F1239CFD921FE]( 0xE16CE893CADAD65 ) )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f516_local0, "emblemTitle" ), Engine[0xF9F1239CFD921FE]( 0xE16CE893CADAD65 ) )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f516_local0, "isUsed" ), false )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f516_local0, "plusImageSrc" ), "uie_t7_icon_codpoints" )
		else
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f516_local0, "isBuyMore" ), false )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f516_local0, "showBuyImage" ), 0 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f516_local0, "emblemTitle" ), f516_local1.emblemTitle )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f516_local0, "name" ), f516_local1.emblemName )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f516_local0, "emblemIndex" ), f516_local1.emblemIndex )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f516_local0, "emblemTextEntry" ), f516_local1.emblemTextEntry )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f516_local0, "subTitle" ), f516_local1.subTitle )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f516_local0, "storageFileType" ), CoD.perController[f516_arg0].selectedEmblemTabStorageType )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f516_local0, "isUsed" ), f516_local1.isUsed )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f516_local0, "showBuyImage" ), 0 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f516_local0, "readOnly" ), f516_local1.readOnly )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f516_local0, "isBMClassified" ), false )
		end
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f516_local0, "sortIndex" ), f516_local1.sortIndex )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f516_local0, "hintText" ), Engine[0xF9F1239CFD921FE]( 0x6D0E4674E87A8C9 ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f516_local0, "authorName" ), Engine[0x7015AC6BE5CE5F1]( f516_arg0 ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f516_local0, "createTime" ), f516_local1.createTime )
		return f516_local0
	end
}
DataSources.MediaManagerCustomGamesList = {
	prepare = function ( f517_arg0, f517_arg1, f517_arg2 )
		f517_arg1.showDefault = false
		f517_arg1.controller = f517_arg0
		f517_arg1.rootModel = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "CustomGamesRoot" )
		f517_arg1.numFiles = Engine[0x48A53BF4243EDFE]( f517_arg0, Engine[0xFFDD58B353B5C0B](), "" )
		f517_arg1.communityOption = false
		if f517_arg1.showDefault == true then
			f517_arg1.numFiles = f517_arg1.numFiles + 1
		end
	end,
	getCount = function ( f518_arg0 )
		CoD.FileshareUtility.SetItemsCount( f518_arg0.controller, f518_arg0.numFiles )
		return f518_arg0.numFiles
	end,
	getItem = function ( f519_arg0, f519_arg1, f519_arg2 )
		local f519_local0 = Engine[0xA798E4552F5E872]( f519_arg1.rootModel, "mm_customgames_" .. f519_arg2 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f519_local0, "uiIndex" ), f519_arg2 )
		if f519_arg1.showDefault == true and f519_arg2 == 1 then
			local f519_local1 = Engine[0xA195D59C70219EF]()
			local f519_local2 = GetCurrentUIGameType( f519_arg0 )
			local f519_local3 = ""
			for f519_local7, f519_local8 in pairs( f519_local1 ) do
				if f519_local8.category == "standard" and f519_local8.gametype == f519_local2 then
					f519_local3 = Engine[0xED84C33EC5F01EA]( f519_local8.name )
					break
				end
			end
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f519_local0, "text" ), f519_local3 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f519_local0, "inUse" ), true )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f519_local0, "isOfficial" ), true )
		else
			local f519_local1 = 1
			if f519_arg1.showDefault == true then
				f519_local1 = 2
			end
			local f519_local2 = f519_arg2 - f519_local1
			local f519_local3 = Engine[0xAD93F86C182478E]( f519_arg0, Engine[0xFFDD58B353B5C0B](), f519_local2 )
			local f519_local4 = Engine[0xEA74FA7EE46E195]( f519_local3.gameType:get() )
			local f519_local5 = f519_local3.gameName:get()
			local f519_local6 = f519_local3.gameDescription:get()
			if Engine[0x614D394F6F9A18D]( f519_local0, "isOfficial" ) then
				f519_local5 = Engine[0xF9F1239CFD921FE]( 0x42CD91611263B8F .. f519_local3.gameName .. "_CAPS" )
				f519_local6 = Engine[0xF9F1239CFD921FE]( 0x42CD91611263B8F .. f519_local3.gameName .. "_DESC" )
			end
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f519_local0, "name" ), f519_local5 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f519_local0, "gameName" ), f519_local5 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f519_local0, "text" ), f519_local5 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f519_local0, "gameDescription" ), f519_local6 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f519_local0, "slot" ), f519_local2 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f519_local0, "inUse" ), f519_local3.inUse )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f519_local0, "isOfficial" ), f519_local3.isOfficial )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f519_local0, "createTime" ), f519_local3.createTime )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f519_local0, "gameType" ), f519_local3.gameType )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f519_local0, "gameTypeString" ), f519_local3.gameTypeString )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f519_local0, "image" ), f519_local4.image )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f519_local0, "description" ), f519_local4.descriptionRef )
		end
		return f519_local0
	end
}
DataSources.MediaManager = {
	getModel = function ( f520_arg0 )
		return Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "MediaManager" )
	end
}
DataSources.MediaManagerSelectedPaintjob = {
	getModel = function ( f521_arg0 )
		return Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f521_arg0 ), "MediaManagerSelectedPaintjob" )
	end
}
DataSources.MediaManagerSelectedVariant = {
	getModel = function ( f522_arg0 )
		return Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f522_arg0 ), "MediaManagerSelectedVariant" )
	end
}
DataSources.MediaManagerSelectedEmblem = {
	getModel = function ( f523_arg0 )
		return Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f523_arg0 ), "MediaManagerSelectedEmblem" )
	end
}
DataSources.MediaManagerSlotsFullButtonList = {
	prepare = function ( f524_arg0, f524_arg1, f524_arg2 )
		local f524_local0 = {}
		if MediaManagerSlotsAvailable( f524_arg0, CoD.FileshareUtility.GetCurrentCategory() ) == false then
			if CanShowMediaManager() then
				table.insert( f524_local0, {
					displayText = 0x4C3EEA8A4B1E631,
					displayImage = "",
					displayDesc = 0x27D9AE8D6AE0E23,
					action = GoBackAndOpenMediaManagerOnParent
				} )
			end
			if FileshareCanBuyMoreSlots( f524_arg0 ) == true then
				table.insert( f524_local0, {
					displayText = 0xE16CE893CADAD65,
					displayImage = "",
					displayDesc = "MENU_FILESHARE_DOWNLOAD_DESC",
					action = OpenBuyExtraSlotsPackDialog,
					param = "MediaManager"
				} )
			end
		end
		local f524_local1 = Engine[0xA798E4552F5E872]( Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "FileshareSlotsFullButtonList" ), "list" )
		f524_arg1.optionModels = {}
		for f524_local5, f524_local6 in ipairs( f524_local0 ) do
			f524_arg1.optionModels[f524_local5] = Engine[0xA798E4552F5E872]( f524_local1, "mm_buttonModel_" .. f524_local5 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f524_arg1.optionModels[f524_local5], "displayText" ), Engine[0xB03220D3A4F3E38]( Engine[0xED84C33EC5F01EA]( f524_local6.displayText ) ) )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f524_arg1.optionModels[f524_local5], "displayImage" ), f524_local6.displayImage )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f524_arg1.optionModels[f524_local5], "hintText" ), Engine[0xED84C33EC5F01EA]( f524_local6.displayDesc ) )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f524_arg1.optionModels[f524_local5], "action" ), f524_local6.action )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f524_arg1.optionModels[f524_local5], "param" ), f524_local6.param )
		end
	end,
	getCount = function ( f525_arg0 )
		return #f525_arg0.optionModels
	end,
	getItem = function ( f526_arg0, f526_arg1, f526_arg2 )
		return f526_arg1.optionModels[f526_arg2]
	end
}
DataSources.PaintjobList = {
	prepare = function ( f527_arg0, f527_arg1, f527_arg2 )
		f527_arg1.controller = f527_arg0
		f527_arg1.paintjobListModel = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f527_arg0 ), "Paintshop.PaintjobList" )
		local f527_local0 = CoD.CraftUtility.Paintjobs.GetTotalUsedPaintjobs()
		local f527_local1 = CoD.CraftUtility.Paintjobs.GetTotalAllowedPaintjobs( f527_arg0 )
		f527_arg1.paintjobList = {}
		f527_arg1.paintjobList = CoD.CraftUtility.Paintjobs.SortPaintjobList( f527_arg0, f527_local0 == f527_local1 )
		f527_arg1.totalPaintjobs = #f527_arg1.paintjobList
	end,
	getCount = function ( f528_arg0 )
		return f528_arg0.totalPaintjobs
	end,
	getItem = function ( f529_arg0, f529_arg1, f529_arg2 )
		local f529_local0 = Engine[0xA798E4552F5E872]( f529_arg1.paintjobListModel, "paintjob_" .. f529_arg2 )
		local f529_local1 = f529_arg1.paintjobList[f529_arg2]
		if f529_local1 then
			if CoD.CraftUtility.Paintjobs.IsPaintjobIndexOccupied( f529_local1.paintjobSlot ) then
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f529_local0, "paintjobName" ), f529_local1.paintjobName )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f529_local0, "paintjobTextEntry" ), f529_local1.paintjobName )
			else
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f529_local0, "paintjobTextEntry" ), Engine[0xF9F1239CFD921FE]( 0xF833A565D9677C9, CoD.CraftUtility.Paintjobs.GetTotalUsedPaintjobs() + 1 ) )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f529_local0, "paintjobName" ), "" )
			end
			if f529_local1.readOnly ~= nil then
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f529_local0, "readOnly" ), f529_local1.readOnly )
			end
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f529_local0, "sortIndex" ), f529_local1.sortIndex )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f529_local0, "paintjobSlot" ), f529_local1.paintjobSlot )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f529_local0, "weaponIndex" ), f529_local1.weaponIndex )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f529_local0, "createTime" ), f529_local1.createTime )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f529_local0, "xuid" ), f529_local1.xuid )
			return f529_local0
		else
			
		end
	end
}
DataSources.DecalGroupsList = {
	prepare = function ( f530_arg0, f530_arg1, f530_arg2 )
		f530_arg1.controller = f530_arg0
		f530_arg1.decalGroupsList = {}
		f530_arg1.decalGroupListModel = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f530_arg0 ), "Emblems.DecalGroupsList" )
		local f530_local0 = CoD.CraftUtility.Groups.GetTotalUsed( f530_arg0 )
		local f530_local1 = CoD.CraftUtility.Groups.GetTotalAllowed( f530_arg0 )
		f530_arg1.totalCraftGroups = f530_local0
		f530_arg1.decalGroupsList = CoD.CraftUtility.Groups.GetSortedList( f530_arg0 )
		if #f530_arg1.decalGroupsList < f530_arg1.totalCraftGroups then
			f530_arg1.totalCraftGroups = #f530_arg1.decalGroupsList
		end
	end,
	getCount = function ( f531_arg0 )
		return f531_arg0.totalCraftGroups
	end,
	getItem = function ( f532_arg0, f532_arg1, f532_arg2 )
		local f532_local0 = Engine[0xA798E4552F5E872]( f532_arg1.decalGroupListModel, "decalGroup_" .. f532_arg2 )
		local f532_local1 = function ( f533_arg0 )
			f533_arg0.emblemTextEntry = f533_arg0.emblemName
			f533_arg0.emblemTitle = f533_arg0.emblemName
			f533_arg0.subTitle = nil
		end
		
		local f532_local2 = f532_arg1.decalGroupsList[f532_arg2]
		f532_local1( f532_local2 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f532_local0, "isNonClickableEmblem" ), 0 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f532_local0, "emblemTitle" ), f532_local2.emblemTitle )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f532_local0, "name" ), f532_local2.emblemName )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f532_local0, "emblemTextEntry" ), f532_local2.emblemTextEntry )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f532_local0, "subTitle" ), f532_local2.subTitle )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f532_local0, "sortIndex" ), f532_local2.sortIndex )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f532_local0, "emblemIndex" ), f532_local2.emblemIndex )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f532_local0, "isUsed" ), f532_local2.isUsed )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f532_local0, "hintText" ), Engine[0xF9F1239CFD921FE]( 0x6D0E4674E87A8C9 ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f532_local0, "storageFileType" ), CoD.CraftUtility.Groups.GetSelectedStorageFileType( f532_arg0 ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f532_local0, "layerCount" ), f532_local2.layerCount )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f532_local0, "xuid" ), f532_local2.xuid )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f532_local0, "indexAndFileType" ), tostring( f532_local2.emblemIndex ) .. " " .. tostring( CoD.CraftUtility.Groups.GetSelectedStorageFileType( f532_arg0 ) ) )
		if f532_local2.readOnly ~= nil then
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f532_local0, "readOnly" ), f532_local2.readOnly )
		end
		return f532_local0
	end
}
DataSources.StickersList = {
	prepare = function ( f534_arg0, f534_arg1, f534_arg2 )
		f534_arg1.controller = f534_arg0
		local f534_local0 = f534_arg1.totalStickers or 0
		f534_arg1.stickerList = {}
		f534_arg1.stickerListModel = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f534_arg0 ), "Stickers.StickersList" )
		f534_arg1.totalStickers = 0
		if f534_local0 ~= f534_arg1.totalEmblems and f534_arg1._onDataSourceListCountChanged then
			f534_arg1:_onDataSourceListCountChanged()
		end
	end,
	getCount = function ( f535_arg0 )
		return f535_arg0.totalStickers
	end,
	getItem = function ( f536_arg0, f536_arg1, f536_arg2 )
		return Engine[0xA798E4552F5E872]( f536_arg1.emblemListModel, "sticker_" .. f536_arg2 )
	end,
	getCustomPropertiesForItem = function ( f537_arg0, f537_arg1 )
		
	end
}
DataSources.StickerSetList = {
	prepare = function ( f538_arg0, f538_arg1, f538_arg2 )
		f538_arg1.controller = f538_arg0
		local f538_local0 = f538_arg1.totalEmblems or 0
		f538_arg1.emblemList = {}
		f538_arg1.emblemListModel = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f538_arg0 ), "Emblem.StickerSetList" )
		f538_arg1.emblemList = CoD.CraftUtility.Emblems.GetSortedStickersList( f538_arg0, Enum[0xBBD4F9E70101BA8][0x6A0A3D1062F156F], CoD.CraftUtility.Emblems.IsEditor( f538_arg1.menu ) )
		f538_arg1.totalEmblems = #f538_arg1.emblemList
		if f538_local0 ~= f538_arg1.totalEmblems and f538_arg1._onDataSourceListCountChanged then
			f538_arg1:_onDataSourceListCountChanged()
		end
	end,
	getCount = function ( f539_arg0 )
		return f539_arg0.totalEmblems
	end,
	getItem = function ( f540_arg0, f540_arg1, f540_arg2 )
		local f540_local0 = Engine[0xA798E4552F5E872]( f540_arg1.emblemListModel, "emblem_" .. f540_arg2 )
		local f540_local1 = function ( f541_arg0 )
			f541_arg0.emblemTextEntry = f541_arg0.emblemName
			f541_arg0.emblemTitle = f541_arg0.emblemName
			f541_arg0.subTitle = ""
		end
		
		local f540_local2 = f540_arg1.emblemList[f540_arg2]
		f540_local1( f540_local2 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f540_local0, "isNonClickableEmblem" ), 0 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f540_local0, "emblemTitle" ), f540_local2.emblemTitle )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f540_local0, "displayName" ), f540_local2.emblemName )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f540_local0, "emblemTextEntry" ), f540_local2.emblemTextEntry )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f540_local0, "subTitle" ), f540_local2.subTitle )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f540_local0, "createTime" ), f540_local2.createTime )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f540_local0, "sortIndex" ), f540_local2.sortIndex )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f540_local0, "emblemIndex" ), f540_local2.emblemIndex )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f540_local0, "isUsed" ), f540_local2.isUsed )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f540_local0, "xuid" ), f540_local2.xuid )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f540_local0, "storageFileType" ), Enum[0xBBD4F9E70101BA8][0x6A0A3D1062F156F] )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f540_local0, "isSetNameItem" ), f540_local2.isSetNameItem )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f540_local0, "isBonusItem" ), f540_local2.isBonusItem )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f540_local0, "setName" ), f540_local2.setName )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f540_local0, "setPieceIndex" ), f540_local2.setPieceIndex )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f540_local0, "iconID" ), f540_local2.emblemIndex )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f540_local0, "sortKey" ), f540_local2.sortIndex )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f540_local0, "category" ), 0x84446BBFA84177E )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f540_local0, "setInfo" ), f540_local2.setInfo or "" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f540_local0, "trialLocked" ), f540_local2.isTrialLocked or false )
		if f540_local2.readOnly ~= nil then
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f540_local0, "readOnly" ), f540_local2.readOnly )
		end
		CoD.CraftUtility.Emblems.CopyLootModels( f540_local0, f540_local2.lootInfo )
		return f540_local0
	end,
	getCustomPropertiesForItem = function ( f542_arg0, f542_arg1 )
		if f542_arg0.emblemList[f542_arg1].isBonusItem then
			if IsJapaneseSku() then
				return {
					customWidgetOverride = CoD.StickerSetEmptyItem,
					selectIndex = not f542_arg0.emblemList[f542_arg1].isSetNameItem
				}
			elseif CoD.CraftUtility.Emblems.IsEditor( f542_arg0.menu ) then
				return {
					customWidgetOverride = CoD.StickerSetBonusDecal,
					selectIndex = not f542_arg0.emblemList[f542_arg1].isSetNameItem
				}
			else
				return {
					customWidgetOverride = CoD.StickerSetBonusItem,
					selectIndex = not f542_arg0.emblemList[f542_arg1].isSetNameItem
				}
			end
		else
			return {
				selectIndex = not f542_arg0.emblemList[f542_arg1].isSetNameItem
			}
		end
	end
}
DataSources.EmblemsList = {
	prepare = function ( f543_arg0, f543_arg1, f543_arg2 )
		f543_arg1.controller = f543_arg0
		local f543_local0 = f543_arg1.totalEmblems or 0
		f543_arg1.emblemList = {}
		local f543_local1 = CoD.perController[f543_arg0].selectedEmblemTabStorageType
		local f543_local2 = CoD.perController[f543_arg0].selectedEmblemTabStickerCategory
		f543_arg1.emblemListModel = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f543_arg0 ), "Emblem.EmblemList" )
		local f543_local3 = CoD.CraftUtility.Emblems.GetTotalUsedEmblems( f543_arg0, f543_local1, f543_local2 )
		local f543_local4 = CoD.CraftUtility.Emblems.GetTotalAllowedEmblems( f543_arg0, f543_local1, f543_local2 )
		if not f543_local1 or f543_local1 == Enum[0xBBD4F9E70101BA8][0xB909AC87BFB6D6C] or f543_local1 == Enum[0xBBD4F9E70101BA8][0xBCE8CBF08D7751] or SelectingGroupEmblem( f543_arg0 ) then
			f543_arg1.totalEmblems = f543_local3
		else
			f543_arg1.totalEmblems = f543_local3 + 1
		end
		f543_arg1.emblemList = CoD.CraftUtility.Emblems.GetSortedEmblemsList( f543_arg0, CoD.perController[f543_arg0].selectedEmblemTabStorageType, CoD.CraftUtility.Emblems.IsEditor( f543_arg1.menu ) )
		f543_arg1.totalEmblems = #f543_arg1.emblemList
		if f543_local0 ~= f543_arg1.totalEmblems and f543_arg1._onDataSourceListCountChanged then
			f543_arg1:_onDataSourceListCountChanged()
		end
	end,
	getCount = function ( f544_arg0 )
		return f544_arg0.totalEmblems
	end,
	getItem = function ( f545_arg0, f545_arg1, f545_arg2 )
		local f545_local0 = Engine[0xA798E4552F5E872]( f545_arg1.emblemListModel, "emblem_" .. f545_arg2 )
		if CoD.perController[f545_arg0].selectedEmblemModel == f545_local0 then
			f545_arg1.selectIndex = f545_arg2
		end
		local f545_local1 = CoD.CraftUtility.Emblems.GetTotalAllowedEmblems( f545_arg0, CoD.perController[f545_arg0].selectedEmblemTabStorageType, CoD.perController[f545_arg0].selectedEmblemTabStickerCategory )
		local f545_local2 = function ( f546_arg0 )
			if CoD.CraftUtility.Emblems.IsEmblemIndexOccupied( f546_arg0.emblemIndex, f546_arg0.fileType ) then
				f546_arg0.emblemTextEntry = f546_arg0.emblemName
				if CoD.perController[f545_arg0].selectedEmblemTabStorageType ~= Enum[0xBBD4F9E70101BA8][0x791C91FD2327632] then
					f546_arg0.emblemTextEntry = Engine[0xF9F1239CFD921FE]( 0x5D39DC4A7060698, CoD.CraftUtility.Emblems.GetTotalUsedEmblems( f545_arg0, Enum[0xBBD4F9E70101BA8][0x791C91FD2327632], nil ) + 1 )
				end
				f546_arg0.emblemTitle = f546_arg0.emblemName
				f546_arg0.subTitle = ""
			else
				f546_arg0.emblemName = Engine[0xF9F1239CFD921FE]( 0xC4863A6FBA65F63 )
				f546_arg0.emblemTitle = Engine[0xF9F1239CFD921FE]( 0x93E719493E9E18F )
				f546_arg0.emblemTextEntry = Engine[0xF9F1239CFD921FE]( 0x5D39DC4A7060698, CoD.CraftUtility.Emblems.GetTotalUsedEmblems( f545_arg0, Enum[0xBBD4F9E70101BA8][0x791C91FD2327632], nil ) + 1 )
				f546_arg0.subTitle = Engine[0xF9F1239CFD921FE]( 0x9073B1D7922BADD )
			end
		end
		
		local f545_local3 = f545_arg1.emblemList[f545_arg2]
		f545_local2( f545_local3 )
		local f545_local4 = f545_local0:create( "isNonClickableEmblem" )
		f545_local4:set( 0 )
		if CoD.CraftUtility.Emblems.IsEditor( f545_arg1.menu ) and #f545_arg1.emblemList == f545_local1 + 1 and f545_arg2 == 1 then
			f545_local4 = f545_local0:create( "isNonClickableEmblem" )
			f545_local4:set( 1 )
			f545_local3.emblemTitle = Engine[0xF9F1239CFD921FE]( 0x93E719493E9E18F )
			f545_local3.emblemName = Engine[0xF9F1239CFD921FE]( 0xC4863A6FBA65F63 )
			f545_local3.emblemTextEntry = "Emblem"
			f545_local3.subTitle = Engine[0xF9F1239CFD921FE]( 0x1B943DE5127FAE0 )
		end
		if CoD.perController[f545_arg0].selectedEmblemTabStorageType == Enum[0xBBD4F9E70101BA8][0xBCE8CBF08D7751] then
			local f545_local5 = CoD.BlackMarketUtility.IsItemLocked( f545_arg0, CoD.BlackMarketUtility.GetLootEmblemIDName( f545_local3.emblemIndex ) )
			local f545_local6 = f545_local0:create( "isBMClassified" )
			f545_local6:set( f545_local5 )
			if f545_local5 then
				f545_local3.subTitle = Engine[0xF9F1239CFD921FE]( 0x46AFD686962D8D2, 0x6C028A55BD26B51 )
				f545_local3.emblemName = CoD.BlackMarketUtility.ClassifiedName( true )
				f545_local3.emblemTitle = CoD.BlackMarketUtility.ClassifiedName( true )
			end
		elseif CoD.perController[f545_arg0].selectedEmblemTabStorageType == Enum[0xBBD4F9E70101BA8][0x6A0A3D1062F156F] then
			if f545_local3.unlocked ~= nil then
				f545_local4 = f545_local0:create( "isBMClassified" )
				f545_local4:set( not f545_local3.unlocked )
				if not f545_local3.unlocked then
					f545_local3.subTitle = Engine[0xF9F1239CFD921FE]( 0x46AFD686962D8D2, 0x9F480787C9809F5 )
					f545_local3.emblemName = CoD.BlackMarketUtility.ClassifiedName( true )
					f545_local3.emblemTitle = CoD.BlackMarketUtility.ClassifiedName( true )
				end
			end
		else
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f545_local0, "isBMClassified" ), false )
		end
		f545_local4 = 0x84446BBFA84177E
		local f545_local5 = false
		if f545_local3.fileType == Enum[0xBBD4F9E70101BA8][0xB909AC87BFB6D6C] or f545_local3.fileType == Enum[0xBBD4F9E70101BA8][0x791C91FD2327632] or f545_local3.fileType == Enum[0xBBD4F9E70101BA8][0xBCE8CBF08D7751] then
			f545_local4 = 0x6C028A55BD26B51
			f545_local5 = true
		end
		local f545_local6 = f545_local0:create( "emblemTitle" )
		f545_local6:set( f545_local3.emblemTitle )
		f545_local6 = f545_local0:create( "displayName" )
		f545_local6:set( f545_local3.emblemTitle )
		f545_local6 = f545_local0:create( "emblemTextEntry" )
		f545_local6:set( f545_local3.emblemTextEntry )
		f545_local6 = f545_local0:create( "subTitle" )
		f545_local6:set( f545_local3.subTitle )
		f545_local6 = f545_local0:create( "createTime" )
		f545_local6:set( f545_local3.createTime )
		f545_local6 = f545_local0:create( "sortIndex" )
		f545_local6:set( f545_local3.sortIndex )
		f545_local6 = f545_local0:create( "emblemIndex" )
		f545_local6:set( f545_local3.emblemIndex )
		f545_local6 = f545_local0:create( "isUsed" )
		f545_local6:set( f545_local3.isUsed )
		f545_local6 = f545_local0:create( "xuid" )
		f545_local6:set( f545_local3.xuid )
		f545_local6 = f545_local0:create( "hintText" )
		f545_local6:set( Engine[0xF9F1239CFD921FE]( 0x6D0E4674E87A8C9 ) )
		f545_local6 = f545_local0:create( "category" )
		f545_local6:set( f545_local4 )
		f545_local6 = f545_local0:create( "storageFileType" )
		f545_local6:set( f545_local3.fileType )
		f545_local6 = f545_local0:create( "skipDefaultTitle" )
		f545_local6:set( f545_local5 )
		f545_local6 = f545_local0:create( "hideRarity" )
		f545_local6:set( f545_local3.isEntitlement )
		f545_local6 = f545_local0:create( "trialLocked" )
		local f545_local7 = f545_local6
		f545_local6 = f545_local6.set
		local f545_local8 = f545_local3.isTrialLocked
		if not f545_local8 then
			f545_local8 = false
		end
		f545_local6( f545_local7, f545_local8 )
		if f545_local3.readOnly ~= nil then
			f545_local6 = f545_local0:create( "readOnly" )
			f545_local6:set( f545_local3.readOnly )
		end
		f545_local6 = f545_local0:create( "renderInfo" )
		f545_local6:set( tostring( f545_local3.emblemIndex ) .. "," .. tostring( f545_local3.fileType ) )
		CoD.CraftUtility.Emblems.CopyLootModels( f545_local0, f545_local3.lootInfo )
		return f545_local0
	end,
	getCustomPropertiesForItem = function ( f547_arg0, f547_arg1 )
		if f547_arg0.selectIndex then
			return {
				selectIndex = f547_arg1 == f547_arg0.selectIndex
			}
		else
			return {
				selectIndex = f547_arg1 == 1
			}
		end
	end
}
DataSources.SpecialContractsList = DataSourceHelpers.ListSetup( "SpecialContractsList", function ( f548_arg0 )
	local f548_local0 = {}
	table.insert( f548_local0, {
		models = {
			index = 0,
			name = Engine[0xF9F1239CFD921FE]( 0x679AF4EE863D159 ),
			description = Engine[0xF9F1239CFD921FE]( 0x44FF6A347AC380F, Dvar[0x9D4B13D578204EA]:get() ),
			cost = 0,
			targetValue = Dvar[0x9D4B13D578204EA]:get(),
			isComplete = HasEarnedWeaponContract( f548_arg0 ),
			category = "default",
			rewardDescription1 = rewardDescription1,
			rewardDescription2 = rewardDescription2,
			rewardDescription3 = rewardDescription3,
			backgroundId = 0
		},
		properties = {}
	} )
	local f548_local1 = 0
	local f548_local2 = 2
	local f548_local3 = 3
	local f548_local4 = 4
	local f548_local5 = 5
	local f548_local6 = 6
	local f548_local7 = 7
	local f548_local8 = 8
	local f548_local9 = CoD.getStatsMilestoneTable( 6, Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] )
	local f548_local10 = Engine[0x910CBCCD3C164C9]( CoD.contractTable_mp, f548_local5, 0x79CCDC196FCDA9B )
	if f548_local10 then
		for f548_local22, f548_local23 in ipairs( f548_local10 ) do
			local f548_local24 = Engine[0xC6F8EC444864600]( CoD.contractTable_mp, f548_local23, f548_local1 )
			local f548_local25 = Engine[0xC6F8EC444864600]( CoD.contractTable_mp, f548_local23, f548_local2 )
			local f548_local26 = Engine[0xC6F8EC444864600]( CoD.contractTable_mp, f548_local23, f548_local3 )
			local f548_local27 = Engine[0xC6F8EC444864600]( CoD.contractTable_mp, f548_local23, f548_local4 )
			local f548_local15 = Engine[0xC6F8EC444864600]( CoD.contractTable_mp, f548_local23, f548_local6 )
			local f548_local28 = Engine[0xC6F8EC444864600]( CoD.contractTable_mp, f548_local23, f548_local7 )
			local f548_local29 = Engine[0xC6F8EC444864600]( CoD.contractTable_mp, f548_local23, f548_local8 )
			local f548_local14 = "CONTRACT_" .. f548_local26
			if f548_local27 and f548_local27 ~= "" then
				f548_local14 = "CONTRACT_" .. f548_local27
			end
			if not f548_local15 or f548_local15 == "" then
				f548_local15 = 0
			end
			local f548_local16 = ""
			local f548_local17 = ""
			local f548_local18 = ""
			local f548_local19 = ""
			local f548_local20 = ""
			local f548_local21 = 0
			if f548_local28 ~= "" then
				f548_local16 = "calling_card"
				f548_local18 = Engine[0x2DCF0973239E909]( nil, f548_local9, 4, f548_local28, 12 )
				f548_local21 = tonumber( Engine[0x2DCF0973239E909]( nil, CoD.backgroundsTable, 4, f548_local18, 1 ) )
			elseif f548_local29 ~= "" then
				f548_local16 = "camo"
				f548_local18 = "MPUI_" .. Engine[0x2DCF0973239E909]( nil, f548_local9, 4, f548_local28, 9 )
			end
			table.insert( f548_local0, {
				models = {
					index = f548_local24,
					name = Engine[0xED84C33EC5F01EA]( f548_local14 ),
					description = Engine[0xF9F1239CFD921FE]( 0xE2A2D7D57E5F3E4 .. f548_local26 .. "_DESC", f548_local25 ),
					cost = tonumber( f548_local15 ),
					targetValue = f548_local25,
					isComplete = false,
					category = f548_local16,
					rewardDescription1 = f548_local18,
					rewardDescription2 = f548_local19,
					rewardDescription3 = f548_local20,
					backgroundId = f548_local21
				},
				properties = {}
			} )
		end
	end
	return f548_local0
end, true )
DataSources.CurrentSpecialContract = {
	getModel = function ( f549_arg0 )
		local f549_local0 = Engine[0x8BF970606552F4C]( f549_arg0, Enum[0xBBD4F9E70101BA8][0xFDE358A242AFA2C] )
		local f549_local1 = f549_local0.contracts[LuaUtils.BMContracts.specialContractIndex]
		local f549_local2 = 2
		local f549_local3 = 3
		local f549_local4 = 4
		local f549_local5 = 6
		local f549_local6 = 0x0
		local f549_local7 = 0x0
		local f549_local8 = 0
		local f549_local9 = 0
		local f549_local10 = 0
		local f549_local11 = false
		local f549_local12 = ""
		local f549_local13 = f549_local1.index:get()
		if f549_local13 == 0 then
			f549_local6 = 0x679AF4EE863D159
			f549_local7 = 0x44FF6A347AC380F
			f549_local9 = f549_local0.weaponContractData.currentValue:get()
			f549_local10 = Dvar[0x9D4B13D578204EA]:get()
			f549_local11 = HasEarnedWeaponContract( f549_arg0 )
		else
			f549_local9 = f549_local1.progress:get()
			f549_local10 = tonumber( Engine[0x2DCF0973239E909]( nil, CoD.contractTable_mp, 0, f549_local13, f549_local2 ) )
			local f549_local14 = Engine[0x2DCF0973239E909]( nil, CoD.contractTable_mp, 0, f549_local13, f549_local3 )
			local f549_local15 = Engine[0x2DCF0973239E909]( nil, CoD.contractTable_mp, 0, f549_local13, f549_local4 )
			f549_local8 = Engine[0x2DCF0973239E909]( nil, CoD.contractTable_mp, 0, f549_local13, f549_local5 )
			f549_local11 = f549_local10 <= f549_local9
			f549_local7 = "CONTRACT_" .. f549_local14 .. "_DESC"
			f549_local6 = "CONTRACT_" .. f549_local14
			if f549_local15 and f549_local15 ~= "" then
				f549_local6 = "CONTRACT_" .. f549_local15
			end
		end
		if not f549_local8 or f549_local8 == "" then
			f549_local8 = 0
		end
		local f549_local14 = 0
		if f549_local10 > 0 then
			f549_local14 = f549_local9 / f549_local10
		end
		local f549_local15 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f549_arg0 ), "CurrentSpecialContract" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f549_local15, "index" ), f549_local13 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f549_local15, "name" ), Engine[0xED84C33EC5F01EA]( f549_local6 ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f549_local15, "description" ), Engine[0xED84C33EC5F01EA]( f549_local7, f549_local10 ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f549_local15, "percentComplete" ), f549_local14 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f549_local15, "fractionText" ), Engine[0xF9F1239CFD921FE]( 0x31CF0F51CCA3A27, f549_local9, f549_local10 ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f549_local15, "cost" ), tonumber( f549_local8 ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f549_local15, "isComplete" ), f549_local11 )
		return f549_local15
	end
}
DataSources.PrestigeStats = {
	getModel = function ( f550_arg0 )
		local f550_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f550_arg0 ), "PrestigeStats" )
		local f550_local1 = CoD.PrestigeUtility.GetPrestigeGameMode()
		local f550_local2 = CoD.PrestigeUtility.GetCurrentPLevel( f550_arg0 )
		local f550_local3 = ""
		local f550_local4 = 0
		if IsMaxPrestigeLevel( f550_arg0 ) and IsGameModeParagonCapable( f550_local1 ) then
			local f550_local5 = Engine[0xA6C26EBACD7322D]( f550_arg0, CoD.STATS_LOCATION_NORMAL, f550_local1 )
			f550_local4 = f550_local5.PlayerStatsList.PARAGON_ICON_ID.StatValue:get()
		end
		if f550_local4 == 0 then
			f550_local3 = Engine[0x9C6922557618920]( 0, f550_local2, f550_local1 )
		else
			f550_local3 = Engine[0x142BF2BEA87722E]( f550_local4, f550_local1 )
		end
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f550_local0, "icon" ), f550_local3 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f550_local0, "backgroundId" ), CoD.PrestigeUtility.GetBackgroundIdByPLevel( f550_arg0, f550_local2 ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f550_local0, "plevel" ), f550_local2 )
		return f550_local0
	end
}
DataSources.PrestigeButtonInfopane = {
	getModel = function ( f551_arg0 )
		local f551_local0 = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "PrestigeButtonInfopane" )
		Engine[0xA798E4552F5E872]( f551_local0, "title" )
		Engine[0xA798E4552F5E872]( f551_local0, "description" )
		return f551_local0
	end
}
DataSources.BookmarksList = ListHelper_SetupDataSource( "BookmarksList", function ( f552_arg0 )
	local f552_local0 = {}
	if Dvar[0x7902CF694444B1F]:get() then
		table.insert( f552_local0, {
			models = {
				bookmarkURL = "index.htm",
				bookmarkDesc = "INDEX"
			},
			propteries = {}
		} )
	end
	table.insert( f552_local0, {
		models = {
			bookmarkURL = "CIA-HomePage.htm",
			bookmarkDesc = Engine[0xF9F1239CFD921FE]( 0xE97BD750D2D8AC )
		},
		propteries = {}
	} )
	table.insert( f552_local0, {
		models = {
			bookmarkURL = "WinslowAccord-MainMenu.htm",
			bookmarkDesc = Engine[0xF9F1239CFD921FE]( 0x6815B2347867C62 )
		},
		propteries = {}
	} )
	table.insert( f552_local0, {
		models = {
			bookmarkURL = "Omnipedia-WinslowAccord.htm",
			bookmarkDesc = Engine[0xF9F1239CFD921FE]( 0x8C7AE39F51871DC )
		},
		propteries = {}
	} )
	table.insert( f552_local0, {
		models = {
			bookmarkURL = "Omnipedia-CDP.htm",
			bookmarkDesc = Engine[0xF9F1239CFD921FE]( 0x39F0115E53252CE )
		},
		propteries = {}
	} )
	table.insert( f552_local0, {
		models = {
			bookmarkURL = "Omnipedia-CIA.htm",
			bookmarkDesc = Engine[0xF9F1239CFD921FE]( 0x3790E15E51199A8 )
		},
		propteries = {}
	} )
	if HighestMapReachedGreaterThan( f552_arg0, 15 ) then
		table.insert( f552_local0, {
			models = {
				bookmarkURL = "CEA-EgyptianForcesMoveAgainstNRC.htm",
				bookmarkDesc = Engine[0xF9F1239CFD921FE]( 0xB72557F7FA2503E )
			},
			propteries = {}
		} )
	end
	if HighestMapReachedGreaterThan( f552_arg0, 6 ) then
		table.insert( f552_local0, {
			models = {
				bookmarkURL = "CEA-GangViolenceSpillsIntoSingapore.htm",
				bookmarkDesc = Engine[0xF9F1239CFD921FE]( 0x1E24E5F589DF0FC )
			},
			propteries = {}
		} )
	end
	if HighestMapReachedGreaterThan( f552_arg0, 8 ) then
		table.insert( f552_local0, {
			models = {
				bookmarkURL = "CEA-VictoryisWithinOurGrasp.htm",
				bookmarkDesc = Engine[0xF9F1239CFD921FE]( 0x6161D775AC11E2F )
			},
			propteries = {}
		} )
	end
	if HighestMapReachedGreaterThan( f552_arg0, 5 ) then
		table.insert( f552_local0, {
			models = {
				bookmarkURL = "CIA-Krueger-FileEntryPoint.htm",
				bookmarkDesc = Engine[0xF9F1239CFD921FE]( 0x9788DD4D2B56A66 )
			},
			propteries = {}
		} )
		table.insert( f552_local0, {
			models = {
				bookmarkURL = "CIA-COALESCENCE-AudioLandingPage.htm",
				bookmarkDesc = Engine[0xF9F1239CFD921FE]( 0x840CD0131A34186 )
			},
			propteries = {}
		} )
	end
	if HighestMapReachedGreaterThan( f552_arg0, 11 ) then
		table.insert( f552_local0, {
			models = {
				bookmarkURL = "CIA-Infection-AudioLandingPage.htm",
				bookmarkDesc = Engine[0xF9F1239CFD921FE]( 0x4131B1A3CEE17F8 )
			},
			propteries = {}
		} )
	end
	if HighestMapReachedGreaterThan( f552_arg0, 16 ) then
		table.insert( f552_local0, {
			models = {
				bookmarkURL = "CIA-Zurich-AudioLandingPage.htm",
				bookmarkDesc = Engine[0xF9F1239CFD921FE]( 0x3B62C33C7BB2BD4 )
			},
			propteries = {}
		} )
		table.insert( f552_local0, {
			models = {
				bookmarkURL = "WinslowAccord-TeamPhiAutopsy.htm",
				bookmarkDesc = Engine[0xF9F1239CFD921FE]( 0xF76352E93A0FB71 )
			},
			propteries = {}
		} )
	end
	for f552_local9, f552_local10 in pairs( CoD.MapUtility.MapsTable ) do
		if f552_local10.collectibles and f552_local10.collectibles ~= "" and (not CoD.perController[f552_arg0].inspectingMap or CoD.perController[f552_arg0].inspectingMap == f552_local9) then
			for f552_local7, f552_local8 in ipairs( Engine[0xA7E3CD65E63086F]( Engine[0xC53F8D38DF9042B]( f552_local10.collectibles ) ) ) do
				if Engine[0x19A771A77F5D790]( f552_arg0, f552_local9, f552_local7 - 1 ) then
					table.insert( f552_local0, {
						models = {
							bookmarkURL = f552_local8[0x1D4BFB62442D31D],
							bookmarkDesc = Engine[0xED84C33EC5F01EA]( f552_local8[0x51ADD75F1CE9118] )
						},
						properties = {}
					} )
				end
			end
		end
	end
	return f552_local0
end )
DataSources.StartMenuCollectables = ListHelper_SetupDataSource( "StartMenuCollectables", function ( f553_arg0 )
	local f553_local0 = {}
	local f553_local1 = Engine[0xE67E7253CC272C9]()
	if LUI.endswith( f553_local1, "2" ) or LUI.endswith( f553_local1, "3" ) then
		f553_local1 = string.sub( f553_local1, 0, string.len( f553_local1 ) - 1 )
	end
	for f553_local10, f553_local11 in pairs( CoD.MapUtility.MapsTable ) do
		if f553_local10 == f553_local1 and f553_local11.collectibles ~= nil and f553_local11.collectibles ~= "" then
			for f553_local8, f553_local9 in ipairs( Engine[0xA7E3CD65E63086F]( Engine[0xC53F8D38DF9042B]( f553_local11.collectibles ) ) ) do
				table.insert( f553_local0, {
					models = {
						image = f553_local9[0x3ABE740EFF79222]
					},
					properties = {
						unlocked = Engine[0x19A771A77F5D790]( f553_arg0, f553_local1, f553_local8 - 1 )
					}
				} )
			end
		end
	end
	return f553_local0
end )
DataSources.StartMenu = {
	getModel = function ( f554_arg0 )
		local f554_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f554_arg0 ), "StartMenu" )
		local f554_local1 = Engine[0xA798E4552F5E872]( f554_local0, "score" )
		local f554_local2 = Engine[0xCBB96BC2E287F92]( f554_arg0, Engine[0x761955642304848]( f554_arg0 ) )
		local f554_local3 = 0
		if f554_local2.score ~= nil then
			f554_local3 = f554_local2.score
		end
		Engine[0x83C9B5DE1D9371]( f554_local1, f554_local3 )
		return f554_local0
	end
}
DataSources.CollectiblesLayout = {
	getModel = function ( f555_arg0 )
		local f555_local0 = {
			"BUNK_COLLECTIBLE_SMALL_1",
			"BUNK_COLLECTIBLE_SMALL_2",
			"BUNK_COLLECTIBLE_SMALL_3",
			"BUNK_COLLECTIBLE_SMALL_4",
			"BUNK_COLLECTIBLE_SMALL_5",
			"BUNK_COLLECTIBLE_SMALL_6",
			"BUNK_COLLECTIBLE_MEDIUM_1",
			"BUNK_COLLECTIBLE_MEDIUM_2",
			"BUNK_COLLECTIBLE_LARGE_1"
		}
		local f555_local1 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f555_arg0 ), "collectiblesLayout" )
		local f555_local2 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f555_arg0 ), "safehouse.inClientBunk" )
		if f555_local2 then
			local f555_local3 = Engine[0x5B379E35974FD8D]( Engine[0x614D394F6F9A18D]( f555_local2 ) )
			for f555_local16, f555_local17 in ipairs( f555_local0 ) do
				local f555_local18 = Engine[0xA798E4552F5E872]( f555_local1, f555_local17 )
				local f555_local19 = Enum[0x388A43B4B2ED2C][Engine[0xC53F8D38DF9042B]( f555_local17 )]
				local f555_local9, f555_local10, f555_local11, f555_local13 = nil
				local f555_local15 = false
				local f555_local12, f555_local14 = nil
				local f555_local20 = f555_local3[f555_local19]
				if f555_local20 and f555_local20.isSet and f555_local18 then
					local f555_local7 = CoD.MapUtility.MapsTable[f555_local20.mapName]
					if f555_local7 and f555_local7.collectibles and f555_local7.collectibles ~= "" then
						local f555_local8 = Engine[0x74A86FE852AEC0]( Engine[0xC53F8D38DF9042B]( f555_local7.collectibles ), f555_local20.collectibleIndex )
						if f555_local8 then
							f555_local9 = f555_local8[0x3ABE740EFF79222]
							f555_local10 = f555_local8[0x81FE4435309362D]
							f555_local11 = f555_local8[0x31DF8734A490BE0]
							f555_local12 = f555_local8[0x8C50405421CA2A5] or ""
							f555_local13 = f555_local8[0x1BAD87B4A174618]
							f555_local14 = f555_local7.mapName
							f555_local15 = true
						end
					end
				end
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f555_local18, "image" ), f555_local9 or "" )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f555_local18, "imageLarge" ), f555_local10 or "" )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f555_local18, "name" ), f555_local11 or "" )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f555_local18, "model" ), f555_local13 or "tag_origin" )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f555_local18, "audioLog" ), f555_local12 or "" )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f555_local18, "collectibleSlot" ), f555_local19 )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f555_local18, "mapInfo" ), f555_local14 or "" )
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f555_local18, "isSet" ), f555_local15 )
			end
		end
		return f555_local1
	end
}
DataSources.GunsmithWeaponOptions = {
	prepare = function ( f556_arg0, f556_arg1, f556_arg2 )
		if not CoD.CACUtility.GunsmithWeaponOptionsTable then
			CoD.CACUtility.GunsmithWeaponOptionsTable = CoD.CACUtility.GetGunsmithWeaponOptionsTable( f556_arg0, f556_arg1, f556_arg2 )
		end
		f556_arg1.gunsmithWeaponOptions = CoD.CACUtility.GunsmithWeaponOptionsTable
	end,
	getCount = function ( f557_arg0 )
		local f557_local0 = DataSources.GunsmithWeaponOptions.currentFilter
		if not f557_local0 and f557_arg0.gunsmithWeaponOptions.filterList then
			return #f557_arg0.gunsmithWeaponOptions.filterList
		elseif f557_arg0.gunsmithWeaponOptions[f557_local0] then
			return #f557_arg0.gunsmithWeaponOptions[f557_local0]
		else
			return 0
		end
	end,
	getItem = function ( f558_arg0, f558_arg1, f558_arg2 )
		local f558_local0 = DataSources.GunsmithWeaponOptions.currentFilter
		if not f558_local0 and f558_arg1.gunsmithWeaponOptions.filterList then
			return f558_arg1.gunsmithWeaponOptions.filterList[f558_arg2]
		elseif f558_arg1.gunsmithWeaponOptions[f558_local0] then
			return f558_arg1.gunsmithWeaponOptions[f558_local0][f558_arg2]
		else
			
		end
	end,
	setCurrentFilterItem = function ( f559_arg0 )
		DataSources.GunsmithWeaponOptions.currentFilter = f559_arg0
	end,
	getCurrentFilterItem = function ()
		return DataSources.GunsmithWeaponOptions.currentFilter
	end,
	currentFilter = nil,
	setCurrentFilterItemNoMode = function ( f561_arg0 )
		DataSources.GunsmithWeaponOptions.currentFilterNoMode = f561_arg0
	end,
	getCurrentFilterItemNoMode = function ()
		return DataSources.GunsmithWeaponOptions.currentFilterNoMode
	end,
	currentFilterNoMode = nil
}
DataSources.ArenaRank = {
	getModel = function ( f563_arg0 )
		return Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f563_arg0 ), "ArenaRank" )
	end
}
DataSources.ArenaInspectionStars = ListHelper_SetupDataSource( "ArenaInspectionStars", function ( f564_arg0 )
	local f564_local0 = Engine[0x614D394F6F9A18D]( Engine[0xA798E4552F5E872]( DataSources.Arena.getModel(), "selectedPlayerPoints" ) )
	local f564_local1 = CoD.ArenaRankedPlayUtility.GetRankVisibleStars( f564_local0 )
	local f564_local2 = CoD.ArenaRankedPlayUtility.GetStarCount( f564_local0 )
	local f564_local3 = {}
	for f564_local4 = 0, f564_local1 - 1, 1 do
		table.insert( f564_local3, {
			models = {
				earned = f564_local4 < f564_local2
			}
		} )
	end
	return f564_local3
end, nil, nil, function ( f565_arg0, f565_arg1, f565_arg2 )
	local f565_local0 = Engine[0xA798E4552F5E872]( DataSources.Arena.getModel(), "selectedPlayerPoints" )
	if f565_arg1.updateSubscription then
		f565_arg1:removeSubscription( f565_arg1.updateSubscription )
	end
	f565_arg1.updateSubscription = f565_arg1:subscribeToModel( f565_local0, function ()
		f565_arg1:updateDataSource()
	end, false )
end )
DataSources.ArenaActiveRules = ListHelper_SetupDataSource( "ArenaActiveRules", function ( f567_arg0 )
	local f567_local0 = {}
	if not IsArenaMode() then
		return f567_local0
	elseif PregameItemVoteEnabled() then
		table.insert( f567_local0, {
			models = {
				text = Engine[0xF9F1239CFD921FE]( 0xF1144ACD7D633B9 )
			}
		} )
	end
	if CharacterDraftEnabled() then
		table.insert( f567_local0, {
			models = {
				text = Engine[0xF9F1239CFD921FE]( 0xE14111F51E8144B )
			}
		} )
	end
	return f567_local0
end, nil, nil, function ( f568_arg0, f568_arg1, f568_arg2 )
	local f568_local0 = Engine[0x40E824FE270E174]( Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "lobbyRoot" ), "lobbyNav" )
	if f568_arg1.lobbyNavSubscription then
		f568_arg1:removeSubscription( f568_arg1.lobbyNavSubscription )
	end
	f568_arg1.lobbyNavSubscription = f568_arg1:subscribeToModel( f568_local0, function ()
		f568_arg1:updateDataSource( true, false )
	end, false )
end )
DataSources.FrontendVoip = {
	prepare = function ( f570_arg0, f570_arg1, f570_arg2 )
		
	end,
	getCount = function ( f571_arg0 )
		return LuaDefine.MAX_CLIENTS
	end,
	getItem = function ( f572_arg0, f572_arg1, f572_arg2 )
		local f572_local0 = Engine[0x40E824FE270E174]( Engine[0x4DF5CFBC1771947]( f572_arg0 ), "hudItems.voipInfo" )
		if f572_local0 then
			return Engine[0x40E824FE270E174]( f572_local0, "voip" .. tostring( f572_arg2 ) )
		else
			
		end
	end
}
DataSources.ContextualMenu = {
	getModel = function ( f573_arg0 )
		local f573_local0 = Engine[0x4DF5CFBC1771947]( f573_arg0 )
		local f573_local1 = f573_local0.ContextualMenuModel
		if not f573_local1 then
			f573_local1 = f573_local0:create( "ContextualMenu" )
			local f573_local2 = CoD.PCWidgetUtility.ContextualMenuTitleModel
			if f573_local2 then
				f573_local2 = CoD.PCWidgetUtility.ContextualMenuTitleModel:get()
			end
			local f573_local3 = CoD.PCWidgetUtility.ContextualMenuSecondLineModel
			if f573_local3 then
				f573_local3 = CoD.PCWidgetUtility.ContextualMenuSecondLineModel:get()
			end
			local f573_local4 = f573_local1:create( "title" )
			local f573_local5 = f573_local4
			f573_local4 = f573_local4.set
			if type( f573_local2 ) == "xhash" then
				local f573_local6 = f573_local2
			end
			f573_local4( f573_local5, f573_local6 or 0x0 )
			f573_local4 = f573_local1:create( "secondLineTitle" )
			f573_local4:set( f573_local3 or "" )
			if type( f573_local2 ) == "string" then
				f573_local4 = CoD.PCWidgetUtility.ContextualMenuXuidModel
				if f573_local4 then
					f573_local4 = CoD.PCWidgetUtility.ContextualMenuXuidModel:get()
				end
				if f573_local4 and Engine[0xB72F603CAC75B3A]( f573_arg0, 0xCA67B57C1673886 ) ~= 0 and (Engine[0x93B19E01B1FD1C7]( f573_arg0 ) == f573_local4 or Engine[0x3176B986956D1B3]( f573_arg0, f573_local4 )) then
					f573_local5 = f573_local1:create( "titleNonLocalized" )
					f573_local5:set( f573_local2 )
				else
					f573_local5 = f573_local1:create( "titleNonLocalized" )
					f573_local5:set( CoD.SocialUtility.CleanGamerTag( f573_local2 ) )
				end
			else
				f573_local4 = f573_local1:create( "titleNonLocalized" )
				f573_local4:set( "" )
			end
		end
		return f573_local1
	end
}
DataSources.ContextualMenuActionsList = DataSourceHelpers.ListSetup( "ContextualMenuActionsList", function ( f574_arg0 )
	local f574_local0 = {}
	for f574_local4, f574_local5 in pairs( CoD.PCWidgetUtility.ContextualMenuActions ) do
		table.insert( f574_local0, {
			models = f574_local5
		} )
	end
	return f574_local0
end, true )
DataSources.ClanTagPromptList = DataSourceHelpers.ListSetup( "ClanTagPromptList", function ( f575_arg0 )
	return {
		{
			models = {
				displayText = Engine[0xB03220D3A4F3E38]( Engine[0xF9F1239CFD921FE]( 0x5BE4A02B20F31F1 ) )
			},
			properties = {
				action = function ( f576_arg0, f576_arg1, f576_arg2, f576_arg3, f576_arg4 )
					EngineExec( f576_arg2, "ui_keyboard_complete" )
					GoBack( f576_arg4, f576_arg2 )
				end
				
			}
		},
		{
			models = {
				displayText = Engine[0xB03220D3A4F3E38]( Engine[0xF9F1239CFD921FE]( 0xC2E92C54C2BE289 ) )
			},
			properties = {
				action = function ( f577_arg0, f577_arg1, f577_arg2, f577_arg3, f577_arg4 )
					EngineExec( f577_arg2, "ui_keyboard_cancel" )
					GoBack( f577_arg4, f577_arg2 )
				end
				
			}
		}
	}
end, true, nil )
DataSources.PlayerContextualMenuOptions = {
	getModel = function ( f578_arg0 )
		local f578_local0 = Engine[0x4DF5CFBC1771947]( f578_arg0 )
		local f578_local1 = f578_local0.ContextualOptionsModel
		if not f578_local1 then
			f578_local1 = f578_local0:create( "ContextualOptionsModel" )
			local f578_local2 = f578_local1:create( "xuid" )
			f578_local2:set( "" )
		end
		return f578_local1
	end
}
DataSources.PlayerContextualMenuOptionsList = DataSourceHelpers.ListSetup( "PC.PlayerContextualMenuOptionsList", function ( f579_arg0 )
	local f579_local0 = {}
	for f579_local4, f579_local5 in pairs( CoD.PCWidgetUtility.PlayerContextualMenuOptions ) do
		table.insert( f579_local0, {
			models = f579_local5
		} )
	end
	return f579_local0
end, true )
DataSources.ChatClientFiltersOptionsList = DataSourceHelpers.ListSetup( "PC.ChatClientFiltersOptionsList", function ( f580_arg0 )
	local f580_local0 = {}
	for f580_local9, f580_local10 in pairs( Engine[0xE40639D3AA297FB]() ) do
		if f580_local10.type ~= Enum[0xF6296F5D7A38AD2][0x5E57997D82BCBD1] and f580_local10.type ~= Enum[0xF6296F5D7A38AD2][0x59073B959F68608] then
			local f580_local4 = table.insert
			local f580_local5 = f580_local0
			local f580_local6 = {}
			local f580_local7 = {
				name = f580_local10.name,
				channelId = f580_local10.chatid
			}
			local f580_local8
			if not f580_local10.filteredOut then
				f580_local8 = 1
				if not f580_local8 then
				
				else
					f580_local7.active = f580_local8
					f580_local6.models = f580_local7
					f580_local4( f580_local5, f580_local6 )
				end
			end
			f580_local8 = 0
		end
	end
	return f580_local0
end, true )
DataSources.LoadingScreenPlayerListTeam1 = {
	prepare = function ( f581_arg0, f581_arg1, f581_arg2 )
		local f581_local0 = Engine[0x8DF2E5447F384B9]()
		f581_local0 = f581_local0:create( "lobbyRoot", true )
		f581_local0 = f581_local0:create( "gameClient", true )
		f581_local0 = f581_local0:create( "update", true )
		if f581_arg1.teamCountSubscription then
			f581_arg1:removeSubscription( f581_arg1.teamCountSubscription )
		end
		f581_arg1.teamCountSubscription = f581_arg1:subscribeToModel( f581_local0, function ()
			f581_arg1:updateDataSource()
		end, false )
		local f581_local1 = Engine[0xE8F4C54B8961311]( Enum[0x7CA2DE5266A94BF][0xC46B73E8E18BA2], Enum[0xBF54BE1BB3D618B][0x92676CF5B6FCD43] )
		local f581_local2 = {
			teamInfo = {}
		}
		f581_local2.teamInfo[1] = {}
		f581_local2.teamInfo[2] = {}
		local f581_local3 = 0
		local f581_local4 = 2
		local f581_local5 = 12
		f581_arg1.maxMembersToShowOnEachTeam = f581_local5
		if f581_local1 and f581_local1.sessionClients then
			f581_local3 = #f581_local1.sessionClients
			local f581_local6 = nil
			for f581_local7 = 1, f581_local3, 1 do
				local f581_local10 = f581_local1.sessionClients[f581_local7]
				local f581_local11 = f581_local10.team
				local f581_local12 = f581_local10.xuid
				table.insert( f581_local2.teamInfo[1], {
					name = f581_local10.gamertag,
					clantag = f581_local10.clantag,
					xuid = f581_local12,
					team = f581_local11
				} )
				if Engine[0x93B19E01B1FD1C7]( f581_arg0 ) == f581_local12 then
					f581_local6 = f581_local11
				end
			end
			local f581_local9 = Engine[0xA798E4552F5E872]( Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "LoadingScreenInfo" ), "LoadingScreenPlayerList" )
			local f581_local13 = Engine[0xA798E4552F5E872]( f581_local9, "team1" )
			local f581_local10 = Engine[0xA798E4552F5E872]( f581_local13, "count" )
			local f581_local11 = Engine[0xA798E4552F5E872]( f581_local9, "team2" )
			local f581_local12 = Engine[0xA798E4552F5E872]( f581_local11, "count" )
			f581_arg1.team1CountModel = f581_local10
			f581_arg1.team1BaseModel = f581_local13
			f581_arg1.team2CountModel = f581_local12
			f581_arg1.team2BaseModel = f581_local11
			f581_local2.teamInfo[1].teamModel = f581_local13
			f581_local2.teamInfo[2].teamModel = f581_local11
			Engine[0x83C9B5DE1D9371]( f581_local10, #f581_local2.teamInfo[1] )
			Engine[0x83C9B5DE1D9371]( f581_local12, #f581_local2.teamInfo[2] )
			for f581_local14 = 1, f581_local4, 1 do
				for f581_local17 = 1, f581_local5, 1 do
					local f581_local20 = Engine[0xA798E4552F5E872]( f581_local2.teamInfo[f581_local14].teamModel, "member" .. f581_local17 )
					if f581_local2.teamInfo[f581_local14][f581_local17] then
						Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f581_local20, "playerxuid" ), f581_local2.teamInfo[f581_local14][f581_local17].xuid )
						Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f581_local20, "playerName" ), f581_local2.teamInfo[f581_local14][f581_local17].name )
						local f581_local21 = Engine[0xA798E4552F5E872]( f581_local20, "isSelfPlayerName" )
						local f581_local22 = false
						for f581_local23 = 0, Engine[0xB686A0A723E6442]() - 1, 1 do
							f581_local22 = Engine[0x93B19E01B1FD1C7]( f581_local23 ) == f581_local2.teamInfo[f581_local14][f581_local17].xuid
							if f581_local22 then
								break
							end
						end
						Engine[0x83C9B5DE1D9371]( f581_local21, f581_local22 )
						Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f581_local20, "team" ), f581_local2.teamInfo[f581_local14][f581_local17].team )
					end
				end
			end
		else
			return 
		end
	end,
	getCount = function ( f583_arg0 )
		return Engine[0x614D394F6F9A18D]( f583_arg0.team1CountModel )
	end,
	getItem = function ( f584_arg0, f584_arg1, f584_arg2 )
		return Engine[0x40E824FE270E174]( f584_arg1.team1BaseModel, "member" .. f584_arg2 )
	end
}
DataSources.LoadingScreenPlayerListTeam2 = {
	prepare = function ( f585_arg0, f585_arg1, f585_arg2 )
		DataSources.LoadingScreenPlayerListTeam1.prepare( f585_arg0, f585_arg1, f585_arg2 )
	end,
	getCount = function ( f586_arg0 )
		local f586_local0 = Engine[0x614D394F6F9A18D]( f586_arg0.team1CountModel )
		local f586_local1 = Engine[0x614D394F6F9A18D]( f586_arg0.team2CountModel )
		local f586_local2 = f586_arg0.maxMembersToShowOnEachTeam
		if f586_local0 <= f586_local2 and f586_local1 <= f586_local2 then
			return f586_local1
		else
			return 0
		end
	end,
	getItem = function ( f587_arg0, f587_arg1, f587_arg2 )
		return Engine[0x40E824FE270E174]( f587_arg1.team2BaseModel, "member" .. f587_arg2 )
	end
}
DataSources.MapInfo = {
	getModel = function ( f588_arg0 )
		local f588_local0 = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "MapInfo" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f588_local0, "gameTypeIcon" ), CoD.GetLoadingScreenGameTypeIconName() )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f588_local0, "gameType" ), Engine[0x4897DBBB7EB601]( f588_arg0 ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f588_local0, "mapName" ), MapNameToLocalizedMapName( Engine[0xB87231BF773995E]() ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f588_local0, "mapImage" ), MapNameToMapLoadingImage( f588_arg0, Engine[0xE67E7253CC272C9]() ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f588_local0, "dateTime" ), CoD.BaseUtility.GetMapValue( Engine[0x84A6876C104DA7D](), "mapDateTime", 0x0 ) )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f588_local0, "location" ), CoD.BaseUtility.GetMapValue( Engine[0x84A6876C104DA7D](), "mapLocation", 0x0 ) )
		return f588_local0
	end
}
DataSources.LoadingScreenTeamInfo = {
	getModel = function ( f589_arg0 )
		local f589_local0 = Engine[0xA798E4552F5E872]( Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f589_arg0 ), "LoadingScreenInfo" ), "LoadingScreenTeamInfo" )
		local f589_local1 = Engine[0xA798E4552F5E872]( f589_local0, "team1FactionName" )
		local f589_local2 = Engine[0xA798E4552F5E872]( f589_local0, "team2FactionName" )
		local f589_local3 = Engine[0xA798E4552F5E872]( f589_local0, "team1FactionIcon" )
		local f589_local4 = Engine[0xA798E4552F5E872]( f589_local0, "team2FactionIcon" )
		local f589_local5 = Engine[0xA798E4552F5E872]( f589_local0, "team1FactionColor" )
		local f589_local6 = Engine[0xA798E4552F5E872]( f589_local0, "team2FactionColor" )
		local f589_local7 = Engine[0xA798E4552F5E872]( f589_local0, "gameTypeIcon" )
		local f589_local8 = Engine[0xA798E4552F5E872]( f589_local0, "gameType" )
		local f589_local9 = Engine[0xA798E4552F5E872]( f589_local0, "mapName" )
		local f589_local10 = Engine[0xA798E4552F5E872]( f589_local0, "location" )
		local f589_local11 = Engine[0xA798E4552F5E872]( f589_local0, "tip" )
		local f589_local12 = Engine[0xA798E4552F5E872]( f589_local0, "statusText" )
		local f589_local13 = f589_local0:create( "loadedFraction" )
		f589_local13:set( f589_local0.loadedFraction:get() or 0 )
		f589_local13 = f589_local0:create( "wzLoadedFraction" )
		f589_local13:set( f589_local0.wzLoadedFraction:get() or 0 )
		f589_local13 = Engine[0xA798E4552F5E872]( f589_local0, "statsValid" )
		local f589_local14 = Engine[0xA798E4552F5E872]( f589_local0, "stat1" )
		local f589_local15 = Engine[0xA798E4552F5E872]( f589_local0, "stat2" )
		local f589_local16 = Engine[0xA798E4552F5E872]( f589_local0, "stat3" )
		local f589_local17 = Engine[0xA798E4552F5E872]( f589_local0, "stat1Label" )
		local f589_local18 = Engine[0xA798E4552F5E872]( f589_local0, "stat2Label" )
		local f589_local19 = Engine[0xA798E4552F5E872]( f589_local0, "stat3Label" )
		local f589_local20, f589_local21 = nil
		local f589_local22 = CoD.TeamUtility.GetTeamID( f589_arg0 )
		local f589_local23 = {
			name = CoD.TeamUtility.GetTeamNameCaps( Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] ),
			icon = CoD.TeamUtility.GetTeamFactionIcon( Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] ),
			color = CoD.TeamUtility.GetTeamFactionColor( Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] )
		}
		local f589_local24 = {
			name = CoD.TeamUtility.GetTeamNameCaps( Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] ),
			icon = CoD.TeamUtility.GetTeamFactionIcon( Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] ),
			color = CoD.TeamUtility.GetTeamFactionColor( Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] )
		}
		if f589_local22 == Enum[0x13A4717E5AC547][0xE4DDAC9C5C45556] then
			if CoD.ShoutcasterProfileVarBool( f589_arg0, "shoutcaster_ds_flip_scorepanel" ) then
				f589_local20 = f589_local24
				f589_local21 = f589_local23
			else
				f589_local20 = f589_local23
				f589_local21 = f589_local24
			end
		elseif f589_local22 == Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] then
			f589_local20 = f589_local23
			f589_local21 = f589_local24
		else
			f589_local20 = f589_local24
			f589_local21 = f589_local23
		end
		local f589_local25 = CoD.GetCurrentPlayerStats( f589_arg0 )
		local f589_local26 = false
		if f589_local25 and CoD.BaseUtility.IsCurrentSessionModeEqualTo( Enum[0x9C0C2196D8313A0][0x83EBA96F36BC4E5] ) and CoDShared.IsRankedGame() then
			local f589_local27 = Engine[0xB87231BF773995E]()
			local f589_local28 = IsArenaMode() and f589_local25.mapStatsArena[f589_local27] or f589_local25.mapStats[f589_local27]
			if f589_local28 ~= nil then
				local f589_local29 = Engine[0x69811927938FCD7]()
				if f589_local29 == "" then
					f589_local29 = Dvar[0xFF54369D6573B91]:get()
				end
				local f589_local30 = Engine[0xC53F8D38DF9042B]( f589_local29 )
				local f589_local31 = f589_local28.perMode[Engine[0xD492E0385F6D3E4]( f589_local30 )]
				if f589_local31 ~= nil then
					local f589_local32 = f589_local31.gamesPlayed:get()
					local f589_local33, f589_local34, f589_local35, f589_local36 = nil
					local f589_local37 = false
					local f589_local38 = function ( f590_arg0, f590_arg1, f590_arg2 )
						if f590_arg0 <= 0 then
							return "--"
						elseif f590_arg2 then
							return math.floor( f590_arg0 / math.max( 1, f590_arg1 ) )
						else
							return string.format( "%.2f", f590_arg0 / math.max( 1, f590_arg1 ) )
						end
					end
					
					local f589_local39 = function ( f591_arg0, f591_arg1 )
						for f591_local3, f591_local4 in ipairs( f591_arg1 ) do
							if f591_arg0 == f591_local4 then
								return true
							end
						end
					end
					
					local f589_local40 = {
						0x84E1CB596B7E53E,
						0xACC245BA0ADF546,
						0x9202CB1D2F5336B,
						0xAAF4118F474831B,
						0xB1E0466676A9E7D,
						0xB3FFB6667877598,
						0xAF7B31F15B60DC,
						0xB60DB445FBF5155,
						0x8D93207B57927F2,
						0xA9CE625ED68488A,
						0xFAB537230960E87,
						0x32C064CAF1E3CA6,
						0x531EC9544A8FC3E,
						0x572880E35379C18,
						0x5B707190CBF683C
					}
					local f589_local41 = {
						0x18BECD72BBC155B,
						0x573521D07EF71F6
					}
					local f589_local42 = {
						0x6E8B11944572258,
						0xAD10ED6E94A349C,
						0xABBEFD6E937A3E5,
						0xCB10CB6A270C743,
						0xBC9FA91195D6ED7,
						0xE7FA1F82C9A9A9,
						0xA20B01921DEF8C2,
						0xF7992E5B48CDED8,
						0x22D94195CD5E6DE,
						0x26793195D075D72
					}
					if f589_local39( f589_local30, f589_local40 ) then
						local f589_local43 = f589_local31.stat1:get()
						local f589_local44 = f589_local31.stat2:get()
						f589_local33 = f589_local38( f589_local43, f589_local32, false )
						f589_local34 = f589_local38( f589_local44, f589_local32, false )
						f589_local35 = 0xB797A5EED06866E
						f589_local36 = 0xAE9B3817AE97887
						f589_local37 = true
					elseif f589_local39( f589_local30, f589_local41 ) then
						local f589_local43 = f589_local31.stat1:get()
						local f589_local44 = f589_local31.stat2:get()
						f589_local33 = f589_local38( f589_local43, f589_local32, true )
						f589_local34 = f589_local38( f589_local44, f589_local32, false )
						if f589_local43 > 0 then
							f589_local33 = SecondsAsTime( f589_local33 )
						end
						f589_local35 = 0x5B63A07F52D161A
						f589_local36 = 0xAE9B3817AE97887
						f589_local37 = true
					elseif f589_local39( f589_local30, f589_local42 ) then
						local f589_local43 = f589_local31.stat1:get()
						local f589_local44 = f589_local31.stat2:get()
						f589_local33 = f589_local38( f589_local43, f589_local32, false )
						f589_local34 = f589_local38( f589_local43, f589_local44, false )
						f589_local35 = 0xAE9B3817AE97887
						f589_local36 = 0x14AF98CA73C8C84
						f589_local37 = true
					else
						f589_local33 = "0"
						f589_local34 = "0"
						f589_local35 = 0x0
						f589_local36 = 0x0
					end
					local f589_local45 = f589_local38( f589_local31.win:get(), f589_local31.loss:get() )
					Engine[0x83C9B5DE1D9371]( f589_local13, f589_local37 )
					Engine[0x83C9B5DE1D9371]( f589_local14, f589_local33 )
					Engine[0x83C9B5DE1D9371]( f589_local15, f589_local34 )
					Engine[0x83C9B5DE1D9371]( f589_local16, f589_local45 )
					Engine[0x83C9B5DE1D9371]( f589_local17, f589_local35 )
					Engine[0x83C9B5DE1D9371]( f589_local18, f589_local36 )
					Engine[0x83C9B5DE1D9371]( f589_local19, 0x9F34F3A8BD173F7 )
					f589_local26 = true
				end
			end
		end
		if f589_local26 == false then
			Engine[0x83C9B5DE1D9371]( f589_local13, false )
			Engine[0x83C9B5DE1D9371]( f589_local14, 0 )
			Engine[0x83C9B5DE1D9371]( f589_local15, 0 )
			Engine[0x83C9B5DE1D9371]( f589_local16, 0 )
			Engine[0x83C9B5DE1D9371]( f589_local17, 0x0 )
			Engine[0x83C9B5DE1D9371]( f589_local18, 0x0 )
			Engine[0x83C9B5DE1D9371]( f589_local19, 0x0 )
		end
		Engine[0x83C9B5DE1D9371]( f589_local1, f589_local20.name )
		Engine[0x83C9B5DE1D9371]( f589_local3, f589_local20.icon )
		Engine[0x83C9B5DE1D9371]( f589_local5, f589_local20.color )
		Engine[0x83C9B5DE1D9371]( f589_local2, f589_local21.name )
		Engine[0x83C9B5DE1D9371]( f589_local4, f589_local21.icon )
		Engine[0x83C9B5DE1D9371]( f589_local6, f589_local21.color )
		Engine[0x83C9B5DE1D9371]( f589_local7, CoD.GetLoadingScreenGameTypeIconName() )
		local f589_local27 = Engine[0x69811927938FCD7]()
		if f589_local27 == "" then
			f589_local27 = Dvar[0xFF54369D6573B91]:get()
		end
		if Engine[0xC53F8D38DF9042B]( f589_local27 ) == 0x8F6A072F8CF2F88 then
			Engine[0x83C9B5DE1D9371]( f589_local9, CoD.MapUtility.GetLocalizedMapValue( CoD.MapUtility.ConvertMapNameToXHash( Engine[0xB87231BF773995E]() ), CoD.ZombieUtility.GetTrialMapNameFieldName( Engine[0xDBC2AD5002B261B]( 0x2D73FC2D365631E ) ), "" ) )
		else
			Engine[0x83C9B5DE1D9371]( f589_local9, CoD.MapUtility.MapNameToLocalizedName( CoD.MapUtility.ConvertMapNameToXHash( Engine[0xB87231BF773995E]() ) ) )
		end
		Engine[0x83C9B5DE1D9371]( f589_local8, CoD.GameTypeUtility.GetLocalizedGameTypeValue( f589_local27, "nameRef", "" ) )
		Engine[0x83C9B5DE1D9371]( f589_local10, 0x0 )
		Engine[0x83C9B5DE1D9371]( f589_local11, CoD.HUDUtility.GetDidYouKnowString( f589_arg0 ) )
		Engine[0x83C9B5DE1D9371]( f589_local12, "" )
		return f589_local0
	end
}
DataSources.SwitchCameraWheel = {
	getModel = function ( f592_arg0 )
		local f592_local0 = {
			{
				disabled = false,
				cameraMode = Enum[0xF432DF404208022][0x448CED16817146D],
				image = "t7_hud_ks_drone_hunter_drop",
				displayName = 0x2B9D4957E0190CA
			},
			{
				disabled = false,
				cameraMode = Enum[0xF432DF404208022][0xFCA80C27FBE8269],
				image = "t7_hud_ks_drone_amws_drop",
				displayName = 0x9DB4CA58C2742FB
			},
			{
				disabled = false,
				cameraMode = Enum[0xF432DF404208022][0x3B1995A6E46FA28],
				freeCameraMode = Enum[0x66BE675172715C][0x57E8B3FC08F3990],
				image = "t7_hud_ks_auto_sentry_drop",
				displayName = 0xD2F1FA0F042A708
			},
			{
				disabled = false,
				cameraMode = Enum[0xF432DF404208022][0x3B1995A6E46FA28],
				freeCameraMode = Enum[0x66BE675172715C][0xFCC4AB128D836C3],
				image = "t7_hud_ks_drone_attack_drop",
				displayName = 0xA671C5A2ED556D4
			},
			{
				disabled = false,
				cameraMode = Enum[0xF432DF404208022][0x3B1995A6E46FA28],
				freeCameraMode = Enum[0x66BE675172715C][0x849666C4C6079C8],
				image = "t7_hud_ks_drone_dart_drop",
				displayName = 0x795B409EEE5D1A5
			},
			{
				disabled = Engine[0x5EC757FC8E459CB](),
				cameraMode = Enum[0xF432DF404208022][0x3B1995A6E46FA28],
				freeCameraMode = Enum[0x66BE675172715C][0xFA038EBA43002CB],
				image = "t7_hud_ks_drone_cuav_drop",
				displayName = 0xD1DF32EE56FD27F
			},
			{
				disabled = false,
				cameraMode = Enum[0xF432DF404208022][0x3B1995A6E46FA28],
				freeCameraMode = Enum[0x66BE675172715C][0xF3D42DF364CABF1],
				image = "t7_hud_ks_emp_core_drop",
				displayName = 0x9AF38899054A0AA
			}
		}
		local f592_local1 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f592_arg0 ), "SwitchCameraWheel" )
		Engine[0xA798E4552F5E872]( f592_local1, "selectedCameraDisplayName" )
		Engine[0xA798E4552F5E872]( f592_local1, "selectedCameraDisplayDesc" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f592_local1, "name" ), Engine[0xB03220D3A4F3E38]( Engine[0xF9F1239CFD921FE]( 0x78D5687ECA65F0E ) ) )
		for f592_local2 = 1, #f592_local0, 1 do
			local f592_local5 = f592_local0[f592_local2]
			local f592_local6 = Engine[0xA798E4552F5E872]( f592_local1, "Camera" .. f592_local2 )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f592_local6, "displayName" ), Engine[0xED84C33EC5F01EA]( f592_local5.displayName ) )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f592_local6, "description" ), Engine[0xED84C33EC5F01EA]( f592_local5.displayName .. "_DESC" ) )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f592_local6, "image" ), f592_local5.image )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f592_local6, "disabled" ), f592_local5.disabled )
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f592_local6, "cameraMode" ), f592_local5.cameraMode )
			if f592_local5.freeCameraMode ~= nil then
				Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f592_local6, "freeCameraMode" ), f592_local5.freeCameraMode )
			end
		end
		return f592_local1
	end
}
DataSources.CommsMessages = ListHelper_SetupDataSource( "CommsMessages", function ( f593_arg0 )
	local f593_local0 = {}
	for f593_local1 = 1, 5, 1 do
		table.insert( f593_local0, {
			models = {
				icon = "",
				messageText = 0x0
			},
			properties = {
				messageIndex = f593_local1
			}
		} )
	end
	return f593_local0
end )
DataSourceHelpers.PerControllerDataSourceSetup( "CommsWidget", "CommsWidget", function ( f594_arg0, f594_arg1 )
	local f594_local0 = f594_arg0:create( "character.name" )
	f594_local0:set( 0x0 )
	f594_local0 = f594_arg0:create( "character.image" )
	f594_local0:set( "blacktransparent" )
	f594_local0 = f594_arg0:create( "specialist.name" )
	f594_local0:set( 0x0 )
	f594_local0 = f594_arg0:create( "specialist.image" )
	f594_local0:set( "blacktransparent" )
end, false )
DataSources.Attacker = {
	getModel = function ( f595_arg0 )
		local f595_local0 = Engine[0x40E824FE270E174]( Engine[0x4DF5CFBC1771947]( f595_arg0 ), "Attacker" )
		local f595_local1 = Engine[0xE4D2F32833CFA6C]( f595_local0.clientNum:get() )
		local f595_local2 = f595_local0:create( "clientModel" )
		f595_local2:set( f595_local1 )
		return f595_local0
	end
}
DataSources.Victim = {
	getModel = function ( f596_arg0 )
		local f596_local0 = Engine[0x40E824FE270E174]( Engine[0x4DF5CFBC1771947]( f596_arg0 ), "Victim" )
		local f596_local1 = Engine[0xE4D2F32833CFA6C]( f596_local0.clientNum:get() )
		local f596_local2 = f596_local0:create( "clientModel" )
		f596_local2:set( f596_local1 )
		return f596_local0
	end
}
DataSources.Player = {
	getModel = function ( f597_arg0 )
		local f597_local0 = Engine[0x4DF5CFBC1771947]( f597_arg0 )
		local f597_local1 = f597_local0:get( "Player" )
		if f597_local1 == nil then
			f597_local1 = f597_local0:create( "Player" )
			local f597_local2 = f597_local1:create( "clientNum" )
			f597_local2:set( Engine[0x761955642304848]( f597_arg0 ) )
		end
		return f597_local1
	end
}
DataSources.TopScorerMenuData = {
	getModel = function ( f598_arg0 )
		return Engine[0x40E824FE270E174]( Engine[0x4DF5CFBC1771947]( f598_arg0 ), "topPlayerInfo" )
	end
}
DataSources.TopPlayerInfoData1 = {
	getModel = function ( f599_arg0 )
		return Engine[0x40E824FE270E174]( DataSources.TopScorerMenuData.getModel( f599_arg0 ), "1" )
	end
}
DataSources.TopPlayerInfoData2 = {
	getModel = function ( f600_arg0 )
		return Engine[0x40E824FE270E174]( DataSources.TopScorerMenuData.getModel( f600_arg0 ), "2" )
	end
}
DataSources.TopPlayerInfoData3 = {
	getModel = function ( f601_arg0 )
		return Engine[0x40E824FE270E174]( DataSources.TopScorerMenuData.getModel( f601_arg0 ), "3" )
	end
}
DataSources.SelfPlayerInfoData = {
	getModel = function ( f602_arg0 )
		return Engine[0x40E824FE270E174]( Engine[0x4DF5CFBC1771947]( f602_arg0 ), "selfPlayerInfo" )
	end
}
DataSources.AARPerformanceTabStats = {
	getModel = function ( f603_arg0 )
		return Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f603_arg0 ), "aarStats.performanceTabStats" )
	end
}
DataSources.AARSPMGraph = {
	getModel = function ( f604_arg0 )
		return Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f604_arg0 ), "aarStats.performanceTabStats.spmGraph" )
	end
}
DataSources.AARKDRGraph = {
	getModel = function ( f605_arg0 )
		return Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f605_arg0 ), "aarStats.performanceTabStats.kdrGraph" )
	end
}
DataSources.Scoreboard = {
	getModel = function ( f606_arg0 )
		return Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f606_arg0 ), "scoreboardInfo" )
	end
}
DataSources.ScoreboardTeam1ListCP = ListHelper_SetupDataSource( "scoreboardTeam1ListCP", function ( f607_arg0 )
	return CoD.AARUtilityCP.GetScoreboardTeamTable( f607_arg0, 1 )
end )
DataSources.ScoreboardTeam1List = {
	prepare = function ( f608_arg0, f608_arg1, f608_arg2 )
		local f608_local0 = Engine[0xA798E4552F5E872]( Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f608_arg0 ), "CodCaster" ), "showCodCasterScoreboard" )
		if Engine[0x614D394F6F9A18D]( f608_local0 ) == true then
			f608_arg1.scoreboardInfoModel = Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "scoreboard.team3" )
		else
			f608_arg1.scoreboardInfoModel = Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "scoreboard.team1" )
		end
		if f608_arg1.teamCountSubscription then
			f608_arg1:removeSubscription( f608_arg1.teamCountSubscription )
		end
		f608_arg1.teamCountSubscription = f608_arg1:subscribeToModel( Engine[0x40E824FE270E174]( f608_arg1.scoreboardInfoModel, "count" ), function ()
			f608_arg1:updateDataSource( nil, true, true )
			Engine[0x6A489878620F3BC]( Engine[0x40E824FE270E174]( Engine[0x4DF5CFBC1771947]( f608_arg0 ), "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04] ) )
		end, false )
		if f608_arg1.showCasterScoreboardSubscription then
			f608_arg1:removeSubscription( f608_arg1.showCasterScoreboardSubscription )
		end
		f608_arg1.showCasterScoreboardSubscription = f608_arg1:subscribeToModel( f608_local0, function ()
			f608_arg1:updateDataSource( nil, true, false )
			Engine[0x6A489878620F3BC]( Engine[0x40E824FE270E174]( Engine[0x4DF5CFBC1771947]( f608_arg0 ), "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04] ) )
		end, false )
	end,
	getCount = function ( f611_arg0 )
		local f611_local0 = CoD.ScoreboardUtility.MinRowsToShowOnEachTeam
		if Engine[0xA9423CFB94266E8]() < 2 and not Engine[0x8EF5BEFA0AE50FE]() and not Engine[0x293941FE17453F1]() then
			f611_local0 = CoD.ScoreboardUtility.MinRowsToShowOnEachTeamForFFA
		end
		return math.max( Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f611_arg0.scoreboardInfoModel, "count" ) ), f611_local0 )
	end,
	getItem = function ( f612_arg0, f612_arg1, f612_arg2 )
		return Engine[0x40E824FE270E174]( f612_arg1.scoreboardInfoModel, f612_arg2 - 1 )
	end
}
DataSources.ScoreboardTeam2List = {
	prepare = function ( f613_arg0, f613_arg1, f613_arg2 )
		f613_arg1.activeController = f613_arg0
		f613_arg1.scoreboardInfoModel = Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "scoreboard.team2" )
		if f613_arg1.teamCountSubscription then
			f613_arg1:removeSubscription( f613_arg1.teamCountSubscription )
		end
		f613_arg1.teamCountSubscription = f613_arg1:subscribeToModel( Engine[0x40E824FE270E174]( f613_arg1.scoreboardInfoModel, "count" ), function ()
			f613_arg1:updateDataSource( nil, true, true )
			Engine[0x6A489878620F3BC]( Engine[0x40E824FE270E174]( Engine[0x4DF5CFBC1771947]( f613_arg0 ), "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04] ) )
		end, false )
		if f613_arg1.showCasterScoreboardSubscription then
			f613_arg1:removeSubscription( f613_arg1.showCasterScoreboardSubscription )
		end
		f613_arg1.showCasterScoreboardSubscription = f613_arg1:subscribeToModel( Engine[0xA798E4552F5E872]( Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f613_arg0 ), "CodCaster" ), "showCodCasterScoreboard" ), function ()
			f613_arg1:updateDataSource( nil, true, true )
			Engine[0x6A489878620F3BC]( Engine[0x40E824FE270E174]( Engine[0x4DF5CFBC1771947]( f613_arg0 ), "UIVisibilityBit." .. Enum[0x7F032C2EF103A1A][0xF4EDA8B636F3F04] ) )
		end, false )
	end,
	getCount = function ( f616_arg0 )
		local f616_local0 = false
		if Engine[0x7B48C1ABFF0F764]() then
			f616_local0 = Engine[0x614D394F6F9A18D]( Engine[0xA798E4552F5E872]( Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f616_arg0.activeController ), "CodCaster" ), "showCodCasterScoreboard" ) )
		end
		if IsGameTypeDOA() then
			return 0
		elseif f616_local0 == true then
			return 0
		else
			return math.max( Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f616_arg0.scoreboardInfoModel, "count" ) ), CoD.ScoreboardUtility.MinRowsToShowOnEachTeam )
		end
	end,
	getItem = function ( f617_arg0, f617_arg1, f617_arg2 )
		return Engine[0x40E824FE270E174]( f617_arg1.scoreboardInfoModel, f617_arg2 - 1 )
	end
}
DataSources.CodCasterScoreboardTeam1List = {
	prepare = function ( f618_arg0, f618_arg1, f618_arg2 )
		f618_arg1.scoreboardInfoModel = Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "scoreboard.team1" )
		if f618_arg1.teamCountSubscription then
			f618_arg1:removeSubscription( f618_arg1.teamCountSubscription )
		end
		f618_arg1.teamCountSubscription = f618_arg1:subscribeToModel( Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f618_arg0 ), "updateScoreboard" ), function ()
			f618_arg1:updateDataSource()
		end, false )
	end,
	getCount = function ( f620_arg0 )
		return CoD.CodCasterUtility.GetTeamPlayerCount( f620_arg0.controller, Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] )
	end,
	getItem = function ( f621_arg0, f621_arg1, f621_arg2 )
		return Engine[0x40E824FE270E174]( f621_arg1.scoreboardInfoModel, f621_arg2 - 1 )
	end
}
DataSources.CodCasterScoreboardTeam2List = {
	prepare = function ( f622_arg0, f622_arg1, f622_arg2 )
		f622_arg1.scoreboardInfoModel = Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "scoreboard.team2" )
		if f622_arg1.teamCountSubscription then
			f622_arg1:removeSubscription( f622_arg1.teamCountSubscription )
		end
		f622_arg1.teamCountSubscription = f622_arg1:subscribeToModel( Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f622_arg0 ), "updateScoreboard" ), function ()
			f622_arg1:updateDataSource()
		end, false )
	end,
	getCount = function ( f624_arg0 )
		return CoD.CodCasterUtility.GetTeamPlayerCount( f624_arg0.controller, Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] )
	end,
	getItem = function ( f625_arg0, f625_arg1, f625_arg2 )
		return Engine[0x40E824FE270E174]( f625_arg1.scoreboardInfoModel, f625_arg2 - 1 )
	end
}
DataSources.DropdownListTest = {
	prepare = function ( f626_arg0, f626_arg1, f626_arg2 )
		local f626_local0 = 25
		for f626_local1 = 1, f626_local0, 1 do
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f626_arg0 ), "DropdownTest.dropdownListTestModel" .. f626_local1 ), "itemName" ), "Random Value " .. f626_local1 )
		end
	end,
	getCount = function ( f627_arg0 )
		return 25
	end,
	getItem = function ( f628_arg0, f628_arg1, f628_arg2 )
		return Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f628_arg0 ), "DropdownTest.dropdownListTestModel" .. f628_arg2 )
	end
}
DataSourceHelpers.PerControllerDataSourceSetup( "DeadSpectate", "deadSpectator", function ( f629_arg0, f629_arg1 )
	local f629_local0 = f629_arg0:create( "followingObjective" )
	f629_local0:set( false )
end )
DataSources.DebugSessionSearchQoSJoin = ListHelper_SetupDataSource( "DebugSessionSearchQoSJoin", function ( f630_arg0 )
	if not Dvar[0x102D263505BECD9]:exists() or Dvar[0x102D263505BECD9]:get() == false then
		return {}
	end
	local f630_local0 = function ( f631_arg0, f631_arg1 )
		return Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f631_arg0, f631_arg1 ) )
	end
	
	local f630_local1 = function ( f632_arg0 )
		local f632_local0 = math.mod( f632_arg0, 3 )
		local f632_local1 = ColorSet.SelectedGreen
		if f632_local0 == 0 then
			f632_local1 = ColorSet.CoreMartial
		elseif f632_local0 == 1 then
			f632_local1 = ColorSet.ResistanceHigh
		end
		return string.format( "%d %d %d", f632_local1.r * 255, f632_local1.g * 255, f632_local1.b * 255 )
	end
	
	local f630_local2 = {}
	Engine[0x87AE7E64BA5AD61]( "OnSessionSQJRefreshInfo", {
		controller = f630_arg0
	} )
	local f630_local3 = Engine[0x40E824FE270E174]( Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "debug" ), "sessionSQJ" )
	local f630_local4 = f630_local0( f630_local3, "searchStage" )
	local f630_local5 = Engine[0x40E824FE270E174]( f630_local3, "results" )
	if Dvar[0x4BADE8473F0165F]:exists() and Dvar[0x4BADE8473F0165F]:get() then
		local f630_local6 = f630_local1( 0 )
		local f630_local7 = Engine[0x40E824FE270E174]( f630_local5, "1" )
		local f630_local8 = f630_local0( f630_local7, "numResults" )
		local f630_local9 = Engine[0x40E824FE270E174]( f630_local7, "data" )
		if f630_local8 == nil then
			return {}
		end
		for f630_local10 = 1, f630_local8, 1 do
			table.insert( f630_local2, {
				models = {
					asyncMatchmakingString = f630_local0( Engine[0x40E824FE270E174]( f630_local9, tostring( f630_local10 ) ), "asyncMatchmakingString" ),
					noResults = "",
					xuid = "",
					gamertag = "",
					publicIPAddress = "",
					privateIPAddress = "",
					natType = "",
					qosPing = "",
					status = "",
					searchStageColor = f630_local6
				},
				properties = {
					disabled = false
				}
			} )
		end
	else
		for f630_local6 = 1, f630_local4, 1 do
			local f630_local10 = f630_local1( f630_local6 )
			local f630_local11 = Engine[0x40E824FE270E174]( f630_local5, tostring( f630_local6 ) )
			local f630_local12 = f630_local0( f630_local11, "numResults" )
			if f630_local12 == 0 then
				table.insert( f630_local2, {
					models = {
						asyncMatchmakingString = "",
						noResults = "NO RESULTS - NO RESULTS - NO RESULTS - NO RESULTS - NO RESULTS - NO RESULTS - NO RESULTS - NO RESULTS - NO RESULTS - NO RESULTS - NO RESULTS - NO RESULTS",
						xuid = "",
						gamertag = "",
						publicIPAddress = "",
						privateIPAddress = "",
						natType = "",
						qosPing = "",
						status = "",
						searchStageColor = f630_local10
					},
					properties = {
						disabled = false
					}
				} )
			end
			local f630_local13 = Engine[0x40E824FE270E174]( f630_local11, "data" )
			for f630_local14 = 1, f630_local12, 1 do
				local f630_local17 = Engine[0x40E824FE270E174]( f630_local13, tostring( f630_local14 ) )
				local f630_local18 = f630_local0( f630_local17, "xuidstr" ) or "0"
				local f630_local19 = f630_local0( f630_local17, "gamertag" ) or ""
				local f630_local20 = f630_local0( f630_local17, "publicIPAddress" )
				if f630_local20 == nil then
					f630_local20 = "0.0.0.0"
				end
				local f630_local21 = f630_local0( f630_local17, "privateIPAddress" )
				if f630_local21 == nil then
					f630_local21 = "0.0.0.0"
				end
				local f630_local22 = f630_local0( f630_local17, "natType" )
				if f630_local22 == nil then
					f630_local22 = "UNKNOWN"
				end
				local f630_local23 = f630_local0( f630_local17, "ping" )
				if not f630_local23 then
					f630_local23 = "??? ms"
				end
				local f630_local24 = f630_local0( f630_local17, "status" )
				if not f630_local24 then
					f630_local24 = " -----
				end
				table.insert( f630_local2, {
					models = {
						asyncMatchmakingString = "",
						noResults = "",
						xuid = f630_local18,
						gamertag = f630_local19,
						publicIPAddress = f630_local20,
						privateIPAddress = f630_local21,
						natType = f630_local22,
						qosPing = f630_local23,
						status = f630_local24,
						searchStageColor = f630_local10
					},
					properties = {
						disabled = false
					}
				} )
			end
		end
	end
	return f630_local2
end, nil, nil, function ( f633_arg0, f633_arg1, f633_arg2 )
	f633_arg1.updateModel = Engine[0xA798E4552F5E872]( Engine[0xA798E4552F5E872]( Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "debug" ), "sessionSQJ" ), "update" )
	Engine[0x83C9B5DE1D9371]( f633_arg1.updateModel, 0 )
	if f633_arg1.updateSubscription then
		f633_arg1:removeSubscription( f633_arg1.updateSubscription )
	end
	f633_arg1.updateSubscription = f633_arg1:subscribeToModel( f633_arg1.updateModel, function ()
		f633_arg1:updateDataSource()
	end, false )
end )
DataSources.LobbyProcessQueueInfo = ListHelper_SetupDataSource( "LobbyProcessQueueInfo", function ( f635_arg0 )
	local f635_local0 = {}
	local f635_local1 = Engine[0xA798E4552F5E872]( Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "lobbyDebug" ), "processQueue" )
	local f635_local2 = Engine[0xA798E4552F5E872]( f635_local1, "data" )
	local f635_local3 = Engine[0x614D394F6F9A18D]( Engine[0xA798E4552F5E872]( f635_local1, "count" ) )
	if f635_local3 then
		for f635_local4 = 1, f635_local3, 1 do
			local f635_local7 = Engine[0x40E824FE270E174]( f635_local2, tostring( f635_local4 ) )
			if f635_local7 then
				table.insert( f635_local0, {
					models = {
						processName = Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f635_local7, "processName" ) ),
						processCancellable = Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f635_local7, "processCancellable" ) ),
						type = Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f635_local7, "type" ) )
					}
				} )
				local f635_local8 = Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f635_local7, "actionCount" ) )
				if f635_local8 > 0 then
					local f635_local9 = Engine[0x40E824FE270E174]( f635_local7, "actions" )
					for f635_local10 = 1, f635_local8, 1 do
						local f635_local13 = Engine[0x40E824FE270E174]( f635_local9, tostring( f635_local10 ) )
						table.insert( f635_local0, {
							models = {
								processName = Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f635_local13, "processName" ) ),
								processState = Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f635_local13, "processState" ) ),
								type = Engine[0x614D394F6F9A18D]( Engine[0x40E824FE270E174]( f635_local13, "type" ) )
							}
						} )
					end
				end
			end
		end
	end
	return f635_local0
end, nil, nil, function ( f636_arg0, f636_arg1, f636_arg2 )
	local f636_local0 = Engine[0xA798E4552F5E872]( Engine[0xA798E4552F5E872]( Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "lobbyDebug" ), "processQueue" ), "update" )
	if f636_arg1.updateSubscription then
		f636_arg1:removeSubscription( f636_arg1.updateSubscription )
	end
	f636_arg1.updateSubscription = f636_arg1:subscribeToModel( f636_local0, function ()
		f636_arg1:updateDataSource()
	end, false )
end )
DataSources.LeaveLobbyPopup = {
	getModel = function ( f638_arg0 )
		local f638_local0 = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "LeaveLobbyPopup" )
		Engine[0xA798E4552F5E872]( f638_local0, "popupType" )
		Engine[0xA798E4552F5E872]( f638_local0, "title" )
		Engine[0xA798E4552F5E872]( f638_local0, "hint" )
		return f638_local0
	end
}
DataSources.Blackhat = {
	getModel = function ( f639_arg0 )
		return Engine[0x40E824FE270E174]( Engine[0x4DF5CFBC1771947]( f639_arg0 ), "hudItems.blackhat" )
	end
}
local f0_local1 = function ( f640_arg0 )
	local f640_local0 = {}
	local f640_local1 = 8
	local f640_local2 = 29
	local f640_local3 = Engine[0xB75B48400B76AA4]( f640_arg0, "r_sceneBrightness" )
	local f640_local4 = 1 / f640_local1 * 2
	for f640_local5 = 1, 2 * f640_local1 + 1, 1 do
		local f640_local8 = math.min( 1, math.max( -1, (f640_local5 - f640_local1 + 1) / f640_local1 ) )
		table.insert( f640_local0, {
			name = tostring( f640_local8 ),
			value = f640_local8
		} )
	end
	local f640_local5 = Engine[0x4DF5CFBC1771947]( f640_arg0 )
	f640_local5 = f640_local5:create( "profile.brightnessPreviewColor" )
	f640_local5:set( "0 0 0" )
	return {
		models = {
			name = 0x4ADE150FFB574D4,
			optionsDatasource = CoD.OptionsUtility.CreateCustomOptionDataSource( f640_arg0, "BrightnessOptions_Brightness", f640_local0, "r_sceneBrightness", function ( f641_arg0 )
				local f641_local0 = 2 * f641_arg0 * f640_local1 + f640_local2
				f640_local5:set( f641_local0 .. " " .. f641_local0 .. " " .. f641_local0 )
			end
			, nil, nil ),
			currentSelection = CoD.OptionsUtility.GetProfileSelection( f640_arg0, f640_local0, "r_sceneBrightness" ),
			color = f640_local2 .. " " .. f640_local2 .. " " .. f640_local2
		},
		properties = {}
	}
end
DataSources.BrightnessSelector = DataSourceHelpers.ListSetup( "BrightnessSelector", function ( f642_arg0 )
	local f642_local0 = {}
	table.insert( f642_local0, f0_local1( f642_arg0 ) )
	return f642_local0
end, true )
DataSources.BattlenetGlobal = {
	prepare = function ( f643_arg0 )
		local f643_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f643_arg0 ), "PC.BattlenetGlobal" )
		local f643_local1 = Engine[0xA798E4552F5E872]( f643_local0, "BattlenetMenuVisibility" )
		f643_local1:set( false )
		f643_local1 = Engine[0xA798E4552F5E872]( f643_local0, "BattlenetAddFriendMenuVisibility" )
		f643_local1:set( false )
		f643_local1 = Engine[0xA798E4552F5E872]( f643_local0, "BattlenetButtonInFooterVisibility" )
		f643_local1:set( false )
		Engine[0xA798E4552F5E872]( f643_local0, "PresenceStatus" )
		f643_local1 = Engine[0xA798E4552F5E872]( f643_local0, "AFK" )
		f643_local1:set( false )
		Engine[0xA798E4552F5E872]( f643_local0, "FriendUpdateEvent" )
		Engine[0xA798E4552F5E872]( f643_local0, "CurrentSort" )
		return f643_local0
	end,
	getModel = function ( f644_arg0 )
		local f644_local0 = Engine[0x40E824FE270E174]( Engine[0x4DF5CFBC1771947]( f644_arg0 ), "PC.BattlenetGlobal" )
		if f644_local0 == nil then
			return DataSources.BattlenetGlobal.prepare( f644_arg0 )
		else
			return f644_local0
		end
	end
}
DataSources.PCConnectionQueue = {
	prepare = function ( f645_arg0 )
		local f645_local0 = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f645_arg0 ), "PCConnectionQueue" )
		local f645_local1 = Engine[0xA798E4552F5E872]( f645_local0, "IsInConnectionQueue" )
		f645_local1:set( false )
		f645_local1 = Engine[0xA798E4552F5E872]( f645_local0, "ConnectionQueuePosition" )
		f645_local1:set( 0 )
		f645_local1 = Engine[0xA798E4552F5E872]( f645_local0, "ConnectionQueueRemainingtime" )
		f645_local1:set( 0 )
		return f645_local0
	end,
	getModel = function ( f646_arg0 )
		local f646_local0 = Engine[0x40E824FE270E174]( Engine[0x4DF5CFBC1771947]( f646_arg0 ), "PCConnectionQueue" )
		if f646_local0 == nil or f646_local0.IsInConnectionQueue == nil then
			return DataSources.PCConnectionQueue.prepare( f646_arg0 )
		else
			return f646_local0
		end
	end
}
DataSources.ChatGlobal = {
	getModel = function ( f647_arg0 )
		local f647_local0 = CoD.ChatClientUtility.GetChatGlobalModel( f647_arg0 )
		CoD.ChatClientUtility.ResetAllModels( f647_arg0 )
		return f647_local0
	end
}
DataSources.ChatClientEntriesList = {
	prepare = function ( f648_arg0, f648_arg1, f648_arg2 )
		f648_arg1.controller = f648_arg0
		local f648_local0 = Engine[0x93B19E01B1FD1C7]( f648_arg0 )
		local f648_local1 = CoD.ChatClientUtility.GetChatEntriesListModel( f648_arg0 )
		f648_arg1.chatClientEntriesModel = f648_local1
		f648_arg1.GetList = Engine[0x244BA82C570F260]
		f648_arg1.CountEntries = math.min( Engine[0x89CD24046934B2]( true ), 50 )
		if not f648_arg1.lastTimeStamp then
			f648_arg1.lastTimeStamp = 0
		end
		local f648_local2 = {
			xuid = 0,
			fullname = "",
			realName = "",
			text = "",
			timestamp = "",
			timeMs = 0,
			chId = "0-0-0",
			chText = "",
			chColor = "255 255 255",
			displayName = "",
			fullLineOfText = "",
			isNew = false
		}
		f648_arg1.chatEntries = {}
		for f648_local3 = 1, f648_arg1.CountEntries, 1 do
			f648_arg1.chatEntries[f648_local3] = {}
			f648_arg1.chatEntries[f648_local3].root = Engine[0xA798E4552F5E872]( f648_local1, "entry_" .. f648_local3 )
			f648_arg1.chatEntries[f648_local3].model = Engine[0xA798E4552F5E872]( f648_arg1.chatEntries[f648_local3].root, "model" )
			f648_arg1.chatEntries[f648_local3].properties = {}
			for f648_local9, f648_local10 in pairs( f648_local2 ) do
				local f648_local11 = Engine[0xA798E4552F5E872]( f648_arg1.chatEntries[f648_local3].model, f648_local9 )
			end
		end
		local f648_local3 = {}
		f648_local3 = f648_arg1.GetList( true, 0, 50 )
		if f648_local3 then
			for f648_local4 = 1, #f648_local3, 1 do
				local f648_local7 = f648_local3[f648_local4]
				local f648_local8 = f648_local4
				for f648_local14, f648_local15 in pairs( f648_local7 ) do
					if f648_local14 ~= "isNew" then
						local f648_local13 = Engine[0x40E824FE270E174]( f648_arg1.chatEntries[f648_local8].model, f648_local14 )
						if f648_local13 ~= nil then
							f648_local13:set( f648_local15 )
						end
						f648_arg1.chatEntries[f648_local8].properties[f648_local14] = f648_local15
					end
				end
				f648_local9 = f648_arg1.chatEntries[f648_local8].properties.channeltype
				if f648_local9 ~= nil then
					f648_local10 = nil
					if f648_local9 == Enum[0xF6296F5D7A38AD2][0x59073B959F68608] then
						f648_local11 = f648_arg1.chatEntries[f648_local8].properties.text
						f648_local14, f648_local15 = string.match( f648_local11, "^^(%d)(.*)" )
						if f648_local14 then
							f648_local10 = CoD.ChatClientUtility.ColorToString( CoD.ChatClientUtility.GetColorForGameEventType( tonumber( f648_local14 ) ) )
						end
						if f648_local15 == nil then
							f648_local15 = f648_local11
						end
						f648_arg1.chatEntries[f648_local8].properties.text = string.gsub( f648_local15, "%^.", "" )
					end
					if f648_local10 == nil then
						f648_local10 = CoD.ChatClientUtility.ColorToString( CoD.ChatClientUtility.GetColorForChannelType( f648_local9 ) )
					end
					f648_local11 = Engine[0x40E824FE270E174]( f648_arg1.chatEntries[f648_local8].model, "chColor" )
					if f648_local11 ~= nil then
						f648_local11:set( f648_local10 )
					end
					f648_arg1.chatEntries[f648_local8].properties.chColor = f648_local10
				end
				f648_local10 = CoD.PCBattlenetUtility.StripBattleTagNumber( f648_arg1.chatEntries[f648_local8].properties.fullname )
				f648_local11 = f648_local10
				if f648_local10 ~= "" and Engine[0xB72F603CAC75B3A]( f648_arg0, 0xCA67B57C1673886 ) ~= 0 and (f648_local0 ~= f648_arg1.chatEntries[f648_local8].properties.xuid or f648_local9 == Enum[0xF6296F5D7A38AD2][0x5E57997D82BCBD1]) then
					f648_local15 = f648_arg1.chatEntries[f648_local8].properties.realname
					if f648_local15 and f648_local15 ~= "" then
						f648_local10 = Engine[0xF9F1239CFD921FE]( 0x2482C16CD79B0E8, f648_local10, f648_local15 )
					end
				end
				f648_local15 = f648_arg1.chatEntries[f648_local8].model.fullName
				if f648_local15 ~= nil then
					f648_local15:set( f648_local10 )
				end
				if f648_local9 ~= Enum[0xF6296F5D7A38AD2][0x59073B959F68608] then
					local f648_local13, f648_local16 = string.match( f648_local10, "%[(.*)%](.+)" )
					if f648_local13 then
						f648_local10 = "[" .. f648_local13 .. "][" .. f648_local16 .. "]"
					else
						f648_local10 = "[" .. f648_local10 .. "]"
					end
				end
				if f648_local9 == Enum[0xF6296F5D7A38AD2][0x5E57997D82BCBD1] and f648_local0 == f648_arg1.chatEntries[f648_local8].properties.xuid then
					f648_local10 = Engine[0xF9F1239CFD921FE]( 0x434C934E77B37E9, f648_local10 )
					f648_arg1.chatEntries[f648_local8].model.xuid:set( f648_local7.whisperTargetxuid )
				end
				local f648_local13 = Engine[0x40E824FE270E174]( f648_arg1.chatEntries[f648_local8].model, "displayName" )
				if f648_local13 ~= nil then
					Engine[0x83C9B5DE1D9371]( f648_local13, f648_local11 )
				end
				local f648_local16 = Engine[0x40E824FE270E174]( f648_arg1.chatEntries[f648_local8].model, "fullLineOfText" )
				if f648_local10 and f648_local10 ~= "" then
					f648_local16:set( f648_local10 .. ": " .. f648_arg1.chatEntries[f648_local8].properties.text )
				else
					f648_local16:set( f648_arg1.chatEntries[f648_local8].properties.text )
				end
				local f648_local17 = Engine[0x40E824FE270E174]( f648_arg1.chatEntries[f648_local8].model, "timeMs" )
				if f648_arg1.lastTimeStamp < f648_local17:get() then
					local f648_local18 = Engine[0x40E824FE270E174]( f648_arg1.chatEntries[f648_local8].model, "isNew" )
					f648_local18:set( true )
				end
			end
			for f648_local4 = #f648_local3 + 1, 50, 1 do
				local f648_local7 = f648_local4
				if f648_arg1.chatEntries[f648_local7] then
					for f648_local11, f648_local14 in pairs( f648_local2 ) do
						if f648_local11 == "xuid" then
							f648_local14 = LuaDefine.INVALID_XUID_X64
						end
						if f648_local11 ~= "isNew" then
							local f648_local15 = Engine[0x40E824FE270E174]( f648_arg1.chatEntries[f648_local7].model, f648_local11 )
							if f648_local15 ~= nil then
								f648_local15:set( f648_local14 )
							end
							f648_arg1.chatEntries[f648_local7].properties[f648_local11] = f648_local14
						end
					end
				end
			end
		end
		if f648_arg1.updateSubscription then
			f648_arg1:removeSubscription( f648_arg1.updateSubscription )
		end
		f648_arg1.updateSubscription = f648_arg1:subscribeToModel( CoD.ChatClientUtility.GetEventModel( f648_arg0 ), function ( model )
			f648_arg1:updateDataSource()
		end, false )
		f648_arg1.lastTimeStamp = Engine[0x9D33D652B9B0F3B]()
	end,
	getCount = function ( f650_arg0 )
		return f650_arg0.CountEntries
	end,
	getItem = function ( f651_arg0, f651_arg1, f651_arg2 )
		return f651_arg1.chatEntries[f651_arg1.CountEntries - f651_arg2 + 1].model
	end
}
DataSources.FirstTimeLanguageSelection = ListHelper_SetupDataSource( "FirstTimeLanguageSelection", function ( f652_arg0 )
	local f652_local0 = {}
	if IsArabicSku() then
		table.insert( f652_local0, {
			models = {
				image = "uie_language_english",
				action = ChangeLanguage,
				param = "englisharabic"
			}
		} )
		table.insert( f652_local0, {
			models = {
				image = "uie_language_arabic",
				action = ChangeLanguage,
				param = "arabic"
			}
		} )
	elseif IsJapaneseSku() then
		table.insert( f652_local0, {
			models = {
				image = "uie_language_japanese",
				action = ChangeLanguage,
				param = "fulljapanese"
			}
		} )
		table.insert( f652_local0, {
			models = {
				image = "uie_language_english_with_japanese_subtitles",
				action = ChangeLanguage,
				param = "japanese"
			}
		} )
	elseif IsChineseSku() then
		table.insert( f652_local0, {
			models = {
				image = "uie_language_english",
				action = ChangeLanguage,
				param = "english"
			}
		} )
		table.insert( f652_local0, {
			models = {
				image = "uie_language_simplified_chinese",
				action = ChangeLanguage,
				param = "simplifiedchinese"
			}
		} )
		table.insert( f652_local0, {
			models = {
				image = "uie_language_traditional_chinese",
				action = ChangeLanguage,
				param = "traditionalchinese"
			}
		} )
	end
	return f652_local0
end )
DataSources.ZMQuestItemHolders = {
	getModel = function ( f653_arg0 )
		return Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f653_arg0 ), "zmInventory" )
	end
}
DataSources.ReticleBindings = {
	getModel = function ( f654_arg0 )
		return Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f654_arg0 ), "reticleBindings" )
	end,
	createModelsForActions = function ( f655_arg0, f655_arg1 )
		Engine[0x8C7A8C4C5FD9892]( DataSources.ReticleBindings.getModel( f655_arg0 ) )
		local f655_local0 = DataSources.ReticleBindings.getModel( f655_arg0 )
		for f655_local6, f655_local7 in ipairs( f655_arg1 ) do
			local f655_local8 = Engine[0xA798E4552F5E872]( f655_local0, f655_local7 )
			local f655_local9, f655_local10 = Engine[0x78A2D9137CF98ED]( f655_arg0, "+" .. f655_local7 )
			if f655_local9 then
				local f655_local4 = CoD.ButtonMappings[f655_local9]
				if f655_local4 then
					local f655_local5 = Engine[0x40E824FE270E174]( DataSources.Controller.Model, f655_local4 )
					if f655_local5 then
						Engine[0x83C9B5DE1D9371]( f655_local8, Engine[0x614D394F6F9A18D]( f655_local5 ) )
					end
				end
			end
		end
	end
}
DataSources.OtherPlayerStats = {
	getModel = function ( f656_arg0 )
		return Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "OtherPlayerStats" )
	end
}
DataSources.GlobalSources.Model = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "DataSources.GlobalSources" )
DataSources.Controller.Model = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "DataSources.Controller" )
DataSources.VehicleController.Model = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "DataSources.VehicleController" )
DataSources.WarHeadings = {
	prepare = function ( f657_arg0, f657_arg1, f657_arg2 )
		f657_arg1.model = Engine[0xA798E4552F5E872]( Engine[0x4DF5CFBC1771947]( f657_arg0 ), "DataSources.WarHeadings" )
		local f657_local0 = Engine[0xE00B2F29271C60B]( 0x3B8FE87B3F2F84E )
		local f657_local1 = 0
		f657_arg1.models = {}
		while f657_local0[0xBDAF86117F49DE7 .. f657_local1 + 1 .. "TimeLimit1"] ~= nil do
			f657_local1 = f657_local1 + 1
			f657_arg1.models[f657_local1] = f657_arg1.model:create( f657_local1 )
			local f657_local2 = f657_arg1.models[f657_local1]:create( "displayText" )
			f657_local2:set( Engine[0xF9F1239CFD921FE]( 0xB0B604AE8F43D6E, f657_local1 ) )
		end
		f657_local1 = f657_local1 + 1
		f657_arg1.models[f657_local1] = f657_arg1.model:create( f657_local1 )
		local f657_local2 = f657_arg1.models[f657_local1]:create( "displayText" )
		f657_local2:set( 0x5576D95D372DA17 )
	end,
	getModel = function ( f658_arg0, f658_arg1 )
		return f658_arg1.model
	end,
	getCount = function ( f659_arg0 )
		return #f659_arg0.models
	end,
	getItem = function ( f660_arg0, f660_arg1, f660_arg2 )
		return f660_arg1.models[f660_arg2]
	end,
	getSpacerAfterColumn = function ( f661_arg0, f661_arg1, f661_arg2 )
		if f661_arg1 == #f661_arg0.models - 1 or f661_arg1 == #f661_arg0.models - 2 then
			return 20
		else
			return 0
		end
	end
}
DataSources.CPObjectiveUIData = {
	Initialize = function ( f662_arg0 )
		if not DataSources.CPObjectiveUIData.subscriptionElement then
			DataSources.CPObjectiveUIData.subscriptionElement = {}
		end
		if not DataSources.CPObjectiveUIData.subscriptionElement[f662_arg0] then
			DataSources.CPObjectiveUIData.subscriptionElement[f662_arg0] = LUI.UIElement.new()
		end
		local f662_local0 = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "hudItems.cpObjectiveUiData" )
		for f662_local5, f662_local6 in pairs( {
			currentZone = 1,
			enemyObjectiveCount = 0,
			enemyObjectiveComplete1 = false,
			enemyObjectiveComplete2 = false,
			enemyObjectiveComplete3 = false
		} ) do
			if not f662_local0[f662_local5] then
				local f662_local4 = f662_local0:create( f662_local5 )
				f662_local4:set( f662_local6 )
			end
		end
		f662_local1 = CoD.TeamUtility.GetTeamID( f662_arg0 )
		if f662_local1 == Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] or f662_local1 == Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] then
			f662_local2 = Engine[0x8298F5742F57615]( f662_local1 )
			f662_local3 = Engine[0x1892558CD0D2E26]()
			f662_local5 = CoD.BaseUtility.GetMapValue( f662_local3, 0x0 .. f662_local2 .. "NumObjZones", 0 )
			f662_local6 = CoD.BaseUtility.GetMapValue( f662_local3, 0x0 .. f662_local2 .. "NumEnemyObj", 0 )
			f662_local0:create( "notificationWidget" )
			f662_local0.enemyObjectiveCount:set( f662_local6 )
			if f662_local5 == 1 then
				f662_local0.notificationWidget:set( "CoD.CP_Notifications_OneStage" )
			elseif f662_local5 == 2 then
				f662_local0.notificationWidget:set( "CoD.CP_Notifications_TwoStage" )
			end
			DataSources.EmenyObjectiveDatasource = ListHelper_SetupDataSource( "EmenyObjectiveDatasource", function ( f663_arg0 )
				local f663_local0 = {}
				for f663_local1 = 1, f662_local6, 1 do
					local f663_local4 = f663_local1
					table.insert( f663_local0, {
						models = {},
						properties = {}
					} )
				end
				return f663_local0
			end, true )
			f662_local0:create( "enemyObjectiveDatasource" )
			f662_local0.enemyObjectiveDatasource:set( "EmenyObjectiveDatasource" )
			for f662_local4 = 1, f662_local5, 1 do
				local f662_local9 = f662_local0:create( "zone" .. f662_local4 )
				f662_local9:create( "teamObjective" )
				f662_local9:create( "progressWidget" )
				f662_local9:create( "objectiveIcon" )
				local f662_local10 = CoD.BaseUtility.GetMapValue( f662_local3, 0x74DC311808F1FA5 .. f662_local2 .. "_" .. f662_local4, nil )
				if f662_local10 and f662_local10 ~= "None" then
					f662_local9.progressWidget:set( "CoD." .. f662_local10 )
				end
				f662_local9.teamObjective:set( CoD.BaseUtility.GetMapValue( f662_local3, 0xDFFF6C0667B360E .. f662_local2 .. "_" .. f662_local4, nil ) )
				f662_local9.objectiveIcon:set( CoD.BaseUtility.GetMapValue( f662_local3, 0xA736FA6439005AE .. f662_local2 .. "_" .. f662_local4, nil ) )
			end
		end
		return f662_local0
	end,
	getModel = function ( f664_arg0 )
		local f664_local0 = Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "hudItems.cpObjectiveUiData" )
		if not f664_local0 then
			f664_local0 = DataSources.CPObjectiveUIData.Initialize( f664_arg0 )
		end
		return f664_local0
	end
}
DataSources.ConvoyAirAssaultData = {
	Initialize = function ( f665_arg0 )
		if not DataSources.ConvoyAirAssaultData.subscriptionElement then
			DataSources.ConvoyAirAssaultData.subscriptionElement = {}
		end
		if not DataSources.ConvoyAirAssaultData.subscriptionElement[f665_arg0] then
			DataSources.ConvoyAirAssaultData.subscriptionElement[f665_arg0] = LUI.UIElement.new()
		end
		local f665_local0 = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "hudItems.convoyAirAssaultData" )
		for f665_local5, f665_local6 in pairs( {
			closestTruckProgress = 0,
			truckDestroyed1 = 0,
			truckDestroyed2 = 0,
			truckDestroyed3 = 0,
			truckDestroyed4 = 0,
			truckDestroyed5 = 0
		} ) do
			if not f665_local0[f665_local5] then
				local f665_local4 = f665_local0:create( f665_local5 )
				f665_local4:set( f665_local6 )
			end
		end
	end,
	getModel = function ( f666_arg0 )
		DataSources.ConvoyAirAssaultData.Initialize( f666_arg0 )
		return Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "hudItems.convoyAirAssaultData" )
	end
}
DataSources.DataControlData = {
	Initialize = function ( f667_arg0 )
		local f667_local0 = true
		if not DataSources.DataControlData.subscriptionElement then
			DataSources.DataControlData.subscriptionElement = {}
		end
		if not DataSources.DataControlData.subscriptionElement[f667_arg0] then
			DataSources.DataControlData.subscriptionElement[f667_arg0] = LUI.UIElement.new()
			f667_local0 = false
		end
		if f667_local0 then
			return 
		end
		local f667_local1 = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "hudItems.dataControlData" )
		for f667_local6, f667_local7 in pairs( {
			chargeState1 = 0,
			chargeState2 = 0,
			chargeState3 = 0,
			terminalStateA = 0,
			terminalStateB = 0,
			downloadProgress = 0
		} ) do
			if not f667_local1[f667_local6] then
				local f667_local5 = f667_local1:create( f667_local6 )
				f667_local5:set( f667_local7 )
			end
		end
		f667_local2 = Engine[0x8DF2E5447F384B9]()
		f667_local2 = f667_local2.hudItems:create( "cpObjectiveUiData" )
		f667_local3 = 0
		f667_local4 = CoD.TeamUtility.GetTeamID( f667_arg0 )
		if f667_local4 == Enum[0x13A4717E5AC547][0x2A34B055ADD98AB] then
			f667_local3 = CoD.BaseUtility.GetMapValue( Engine[0xB87231BF773995E](), 0x7D09B4506A0228, nil )
		elseif f667_local4 == Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68] then
			f667_local3 = CoD.BaseUtility.GetMapValue( Engine[0xB87231BF773995E](), 0x8000C12D08DE02D, nil )
		end
		f667_local6 = f667_local3 == 2
		f667_local7 = function ()
			local f668_local0
			if f667_local1.terminalStateA:get() ~= 1 and f667_local1.terminalStateB:get() ~= 1 then
				f668_local0 = false
			else
				f668_local0 = true
			end
			if f667_local6 then
				f667_local2.enemyObjectiveComplete1:set( f668_local0 )
			else
				local f668_local1 = 1
				if f668_local0 then
					f668_local1 = 2
				end
				f667_local2.currentZone:set( f668_local1 )
			end
		end
		
		local f667_local5 = function ()
			f667_local2.enemyObjectiveComplete2:set( f667_local1.downloadProgress:get() >= 1 )
		end
		
		local f667_local8 = function ()
			f667_local2.enemyObjectiveComplete1:set( f667_local1.chargeState1:get() == 1 )
		end
		
		local f667_local9 = function ()
			f667_local2.enemyObjectiveComplete2:set( f667_local1.chargeState2:get() == 1 )
		end
		
		local f667_local10 = function ()
			f667_local2.enemyObjectiveComplete3:set( f667_local1.chargeState3:get() == 1 )
		end
		
		if not DataSources.DataControlData.subscriptionElement[f667_arg0].hasEscapeSubscriptions then
			DataSources.DataControlData.subscriptionElement[f667_arg0]:subscribeToModel( f667_local1.terminalStateA, f667_local7 )
			DataSources.DataControlData.subscriptionElement[f667_arg0]:subscribeToModel( f667_local1.terminalStateB, f667_local7 )
			if f667_local6 then
				DataSources.DataControlData.subscriptionElement[f667_arg0]:subscribeToModel( f667_local1.downloadProgress, f667_local5 )
			else
				DataSources.DataControlData.subscriptionElement[f667_arg0]:subscribeToModel( f667_local1.chargeState1, f667_local8 )
				DataSources.DataControlData.subscriptionElement[f667_arg0]:subscribeToModel( f667_local1.chargeState2, f667_local9 )
				DataSources.DataControlData.subscriptionElement[f667_arg0]:subscribeToModel( f667_local1.chargeState3, f667_local10 )
			end
			DataSources.DataControlData.subscriptionElement[f667_arg0].hasEscapeSubscriptions = true
		end
	end,
	getModel = function ( f673_arg0 )
		DataSources.DataControlData.Initialize( f673_arg0 )
		return Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "hudItems.dataControlData" )
	end
}
DataSources.StageResults = {
	Initialize = function ()
		local f674_local0 = Engine[0x8DF2E5447F384B9]()
		f674_local0 = f674_local0:create( "StageResults" )
		f674_local0:create( "potmClient" )
	end,
	getModel = function ( f675_arg0 )
		if not DataSources.StageResults.IsInitialized then
			DataSources.StageResults.Initialize()
		end
		local f675_local0 = Engine[0x8DF2E5447F384B9]()
		return f675_local0.StageResults
	end
}
DataSources.DataEscapeData = {
	Initialize = function ( f676_arg0 )
		if not DataSources.DataEscapeData.subscriptionElement then
			DataSources.DataEscapeData.subscriptionElement = {}
		end
		if not DataSources.DataEscapeData.subscriptionElement[f676_arg0] then
			DataSources.DataEscapeData.subscriptionElement[f676_arg0] = LUI.UIElement.new()
		end
		local f676_local0 = Engine[0xA798E4552F5E872]( Engine[0x8DF2E5447F384B9](), "hudItems.dataEscapeData" )
		for f676_local5, f676_local6 in pairs( {
			escapeTeamProgress = 0,
			escapeTeamDistance = 0,
			escapeTeamAtExtraction = 0,
			escapeTeamVictory = 0,
			chaseTeamProgress = 0,
			chaseTeamDistance = 0,
			chaseTeamAtExtraction = 0,
			chaseTeamVictory = 0,
			vtolHealth = 0
		} ) do
			if not f676_local0[f676_local5] then
				local f676_local4 = f676_local0:create( f676_local5 )
				f676_local4:set( f676_local6 )
			end
		end
		f676_local1 = Engine[0x8DF2E5447F384B9]()
		f676_local1 = f676_local1.hudItems:create( "cpObjectiveUiData" )
		f676_local2 = CoD.BaseUtility.GetMapValue( Engine[0xB87231BF773995E](), 0x42C3FC210098CD1, nil )
		if (f676_local2 ~= "de" or CoD.TeamUtility.GetTeamID( f676_arg0 ) ~= Enum[0x13A4717E5AC547][0x3F83D7CE4BD7B68]) and (f676_local2 ~= "sng" or CoD.TeamUtility.GetTeamID( f676_arg0 ) ~= Enum[0x13A4717E5AC547][0x2A34B055ADD98AB]) then
			f676_local3 = false
		else
			f676_local3 = true
		end
		f676_local5 = function ()
			if f676_local0.escapeTeamAtExtraction:get() == 1 then
				if f676_local3 then
					f676_local1.currentZone:set( 2 )
				else
					f676_local1.enemyObjectiveComplete1:set( true )
				end
			end
		end
		
		f676_local6 = function ()
			if f676_local0.chaseTeamAtExtraction:get() == 1 then
				if f676_local3 then
					f676_local1.enemyObjectiveComplete1:set( true )
				else
					f676_local1.currentZone:set( 2 )
				end
			end
		end
		
		local f676_local4 = function ()
			f676_local1.enemyObjectiveComplete2:set( f676_local0.escapeTeamVictory:get() == 1 )
		end
		
		local f676_local7 = function ()
			f676_local1.enemyObjectiveComplete2:set( f676_local0.chaseTeamVictory:get() == 1 )
		end
		
		if not DataSources.DataEscapeData.subscriptionElement[f676_arg0].hasEscapeSubscriptions then
			DataSources.DataEscapeData.subscriptionElement[f676_arg0]:subscribeToModel( f676_local0.escapeTeamAtExtraction, f676_local5 )
			DataSources.DataEscapeData.subscriptionElement[f676_arg0]:subscribeToModel( f676_local0.chaseTeamAtExtraction, f676_local6 )
			if f676_local3 then
				DataSources.DataEscapeData.subscriptionElement[f676_arg0]:subscribeToModel( f676_local0.chaseTeamVictory, f676_local7 )
			else
				DataSources.DataEscapeData.subscriptionElement[f676_arg0]:subscribeToModel( f676_local0.escapeTeamVictory, f676_local4 )
			end
			DataSources.DataEscapeData.subscriptionElement[f676_arg0].hasEscapeSubscriptions = true
		end
	end,
	getModel = function ( f681_arg0 )
		DataSources.DataEscapeData.Initialize( f681_arg0 )
		return Engine[0x40E824FE270E174]( Engine[0x8DF2E5447F384B9](), "hudItems.dataEscapeData" )
	end
}
DataSourceHelpers.PerControllerDataSourceSetup( "LeftStick", "LeftStick", function ( f682_arg0 )
	f682_arg0:create( "Degrees" )
	f682_arg0:create( "Length" )
	local f682_local0 = f682_arg0:create( "SelectedWedge" )
	f682_local0:set( -1 )
	f682_local0 = f682_arg0:create( "WheelSelectionEnabled" )
	f682_local0:set( false )
end )
DataSourceHelpers.PerControllerDataSourceSetup( "RightStick", "RightStick", function ( f683_arg0 )
	f683_arg0:create( "Degrees" )
	f683_arg0:create( "Length" )
	local f683_local0 = f683_arg0:create( "SelectedWedge" )
	f683_local0:set( -1 )
	f683_local0 = f683_arg0:create( "WheelSelectionEnabled" )
	f683_local0:set( false )
end )
function createControllerBindings( f684_arg0, f684_arg1, f684_arg2, f684_arg3, f684_arg4 )
	Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( DataSources.Controller.Model, f684_arg2 ), f684_arg3 )
	Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( DataSources.VehicleController.Model, f684_arg2 ), f684_arg4 or f684_arg3 )
	if f684_arg1 then
		CoD.ButtonMappings[f684_arg1] = f684_arg2
	end
end
function UpdateControllerBindings( f685_arg0, f685_arg1 )
	if f685_arg0 ~= 0 then
		return 
	elseif f685_arg1 == Enum[0x7339BD8F945E098][0xA6F6CFA25C35148] then
		createControllerBindings( f685_arg0, "BUTTON_A", "primary_button_image", "xenonbutton_a" )
		createControllerBindings( f685_arg0, "BUTTON_B", "secondary_button_image", "xenonbutton_b" )
		createControllerBindings( f685_arg0, "BUTTON_X", "alt1_button_image", "xenonbutton_x" )
		createControllerBindings( f685_arg0, "BUTTON_Y", "alt2_button_image", "xenonbutton_y" )
		createControllerBindings( f685_arg0, "BUTTON_BACK", "back_button_image", "xenonbutton_back" )
		createControllerBindings( f685_arg0, "BUTTON_START", "start_button_image", "xenonbutton_start" )
		local f685_local0 = createControllerBindings
		local f685_local1 = f685_arg0
		local f685_local2 = "BUTTON_LSHLDR"
		local f685_local3 = "left_shoulder_button_image"
		local f685_local4 = "xenonbutton_lb"
		local f685_local5
		if not CoD.isPC then
			f685_local5 = "t7_icons_controller_lbwhite"
			if not f685_local5 then
			
			else
				f685_local0( f685_local1, f685_local2, f685_local3, f685_local4, f685_local5 )
				createControllerBindings( f685_arg0, nil, "left_shoulder_button_image_glow", "uie_t7_icons_controller_durango_lb_glow" )
				f685_local0 = createControllerBindings
				f685_local1 = f685_arg0
				f685_local2 = "BUTTON_RSHLDR"
				f685_local3 = "right_shoulder_button_image"
				f685_local4 = "xenonbutton_rb"
				if not CoD.isPC then
					f685_local5 = "t7_icons_controller_rbwhite"
					if not f685_local5 then
					
					else
						f685_local0( f685_local1, f685_local2, f685_local3, f685_local4, f685_local5 )
						createControllerBindings( f685_arg0, nil, "right_shoulder_button_image_glow", "uie_t7_icons_controller_durango_rb_glow" )
						createControllerBindings( f685_arg0, "BUTTON_LSTICK", "left_stick_button_image", "ui_button_xenon_stick_ani_32_Ldown" )
						createControllerBindings( f685_arg0, "BUTTON_RSTICK", "right_stick_button_image", "ui_button_xenon_stick_ani_32_Rdown" )
						createControllerBindings( f685_arg0, nil, "move_left_stick_button_image", "t7_icons_controller_ls" )
						createControllerBindings( f685_arg0, nil, "move_right_stick_button_image", "t7_icons_controller_rs" )
						f685_local0 = createControllerBindings
						f685_local1 = f685_arg0
						f685_local2 = "BUTTON_LTRIG"
						f685_local3 = "left_trigger_button_image"
						f685_local4 = "xenonbutton_lt"
						if not CoD.isPC then
							f685_local5 = "t7_icons_controller_ltwhite"
							if not f685_local5 then
							
							else
								f685_local0( f685_local1, f685_local2, f685_local3, f685_local4, f685_local5 )
								f685_local0 = createControllerBindings
								f685_local1 = f685_arg0
								f685_local2 = "BUTTON_RTRIG"
								f685_local3 = "right_trigger_button_image"
								f685_local4 = "xenonbutton_rt"
								if not CoD.isPC then
									f685_local5 = "t7_icons_controller_rtwhite"
									if not f685_local5 then
									
									else
										f685_local0( f685_local1, f685_local2, f685_local3, f685_local4, f685_local5 )
										createControllerBindings( f685_arg0, nil, "dpad_all_button_image", "xenonbutton_dpad_all" )
										createControllerBindings( f685_arg0, nil, "dpad_lr_button_image", "xenonbutton_dpad_rl" )
										createControllerBindings( f685_arg0, nil, "dpad_ud_button_image", "xenonbutton_dpad_ud" )
										createControllerBindings( f685_arg0, "DPAD_UP", "dpad_up_button_image", "xenonbutton_dpad_up" )
										createControllerBindings( f685_arg0, "DPAD_DOWN", "dpad_down_button_image", "xenonbutton_dpad_down" )
										createControllerBindings( f685_arg0, "DPAD_LEFT", "dpad_left_button_image", "xenonbutton_dpad_left" )
										createControllerBindings( f685_arg0, "DPAD_RIGHT", "dpad_right_button_image", "xenonbutton_dpad_right" )
										createControllerBindings( f685_arg0, nil, "left_stick_move_image", "t7_icons_controller_ls" )
										createControllerBindings( f685_arg0, nil, "right_stick_move_image", "t7_icons_controller_rs" )
									end
								end
								f685_local5 = "xenonbutton_rt"
							end
						end
						f685_local5 = "xenonbutton_lt"
					end
				end
				f685_local5 = "xenonbutton_rb"
			end
		end
		f685_local5 = "xenonbutton_lb"
	elseif f685_arg1 == Enum[0x7339BD8F945E098][0x605C7602BE486FF] then
		createControllerBindings( f685_arg0, "BUTTON_A", Engine[0xA53B22CB5CEDB1E]() and "secondary_button_image" or "primary_button_image", "ps3button_x", Engine[0xA53B22CB5CEDB1E]() and "ps3button_circle" or "ps3button_x" )
		createControllerBindings( f685_arg0, "BUTTON_B", Engine[0xA53B22CB5CEDB1E]() and "primary_button_image" or "secondary_button_image", "ps3button_circle", Engine[0xA53B22CB5CEDB1E]() and "ps3button_x" or "ps3button_circle" )
		createControllerBindings( f685_arg0, "BUTTON_X", "alt1_button_image", "ps3button_square" )
		createControllerBindings( f685_arg0, "BUTTON_Y", "alt2_button_image", "ps3button_triangle" )
		createControllerBindings( f685_arg0, "BUTTON_BACK", "back_button_image", "ps3button_select" )
		createControllerBindings( f685_arg0, "BUTTON_START", "start_button_image", "ps3button_start" )
		local f685_local0 = createControllerBindings
		local f685_local1 = f685_arg0
		local f685_local2 = "BUTTON_LSHLDR"
		local f685_local3 = "left_shoulder_button_image"
		local f685_local4 = "ps3button_l1"
		local f685_local5
		if not CoD.isPC then
			f685_local5 = "t7_icons_controller_lbwhite"
			if not f685_local5 then
			
			else
				f685_local0( f685_local1, f685_local2, f685_local3, f685_local4, f685_local5 )
				createControllerBindings( f685_arg0, nil, "left_shoulder_button_image_glow", "uie_t7_icons_controller_orbis_l1_glow" )
				f685_local0 = createControllerBindings
				f685_local1 = f685_arg0
				f685_local2 = "BUTTON_RSHLDR"
				f685_local3 = "right_shoulder_button_image"
				f685_local4 = "ps3button_r1"
				if not CoD.isPC then
					f685_local5 = "t7_icons_controller_rbwhite"
					if not f685_local5 then
					
					else
						f685_local0( f685_local1, f685_local2, f685_local3, f685_local4, f685_local5 )
						createControllerBindings( f685_arg0, nil, "right_shoulder_button_image_glow", "uie_t7_icons_controller_orbis_r1_glow" )
						createControllerBindings( f685_arg0, "BUTTON_LSTICK", "left_stick_button_image", "ps3button_l3" )
						createControllerBindings( f685_arg0, "BUTTON_RSTICK", "right_stick_button_image", "ps3button_r3" )
						createControllerBindings( f685_arg0, nil, "move_left_stick_button_image", "t7_icons_controller_ls" )
						createControllerBindings( f685_arg0, nil, "move_right_stick_button_image", "t7_icons_controller_rs" )
						f685_local0 = createControllerBindings
						f685_local1 = f685_arg0
						f685_local2 = "BUTTON_LTRIG"
						f685_local3 = "left_trigger_button_image"
						f685_local4 = "ps3button_l2"
						if not CoD.isPC then
							f685_local5 = "t7_icons_controller_ltwhite"
							if not f685_local5 then
							
							else
								f685_local0( f685_local1, f685_local2, f685_local3, f685_local4, f685_local5 )
								f685_local0 = createControllerBindings
								f685_local1 = f685_arg0
								f685_local2 = "BUTTON_RTRIG"
								f685_local3 = "right_trigger_button_image"
								f685_local4 = "ps3button_r2"
								if not CoD.isPC then
									f685_local5 = "t7_icons_controller_rtwhite"
									if not f685_local5 then
									
									else
										f685_local0( f685_local1, f685_local2, f685_local3, f685_local4, f685_local5 )
										createControllerBindings( f685_arg0, nil, "dpad_all_button_image", "ps3button_dpad_all" )
										createControllerBindings( f685_arg0, nil, "dpad_lr_button_image", "ps3button_dpad_rl" )
										createControllerBindings( f685_arg0, nil, "dpad_ud_button_image", "ps3button_dpad_ud" )
										createControllerBindings( f685_arg0, "DPAD_UP", "dpad_up_button_image", "ps3button_dpad_up" )
										createControllerBindings( f685_arg0, "DPAD_DOWN", "dpad_down_button_image", "ps3button_dpad_down" )
										createControllerBindings( f685_arg0, "DPAD_LEFT", "dpad_left_button_image", "ps3button_dpad_left" )
										createControllerBindings( f685_arg0, "DPAD_RIGHT", "dpad_right_button_image", "ps3button_dpad_right" )
										createControllerBindings( f685_arg0, nil, "left_stick_move_image", "t7_icons_controller_ls" )
										createControllerBindings( f685_arg0, nil, "right_stick_move_image", "t7_icons_controller_rs" )
									end
								end
								f685_local5 = "ps3button_r2"
							end
						end
						f685_local5 = "ps3button_l2"
					end
				end
				f685_local5 = "ps3button_r1"
			end
		end
		f685_local5 = "ps3button_l1"
	else
		createControllerBindings( f685_arg0, "BUTTON_A", "primary_button_image", "ps3button_x" )
		createControllerBindings( f685_arg0, "BUTTON_B", "secondary_button_image", "ps3button_circle" )
		createControllerBindings( f685_arg0, "BUTTON_X", "alt1_button_image", "ps3button_square" )
		createControllerBindings( f685_arg0, "BUTTON_Y", "alt2_button_image", "ps3button_triangle" )
		createControllerBindings( f685_arg0, "BUTTON_BACK", "back_button_image", "ps3button_select" )
		createControllerBindings( f685_arg0, "BUTTON_START", "start_button_image", "ps3button_start" )
		local f685_local0 = createControllerBindings
		local f685_local1 = f685_arg0
		local f685_local2 = "BUTTON_LSHLDR"
		local f685_local3 = "left_shoulder_button_image"
		local f685_local4 = "ps3button_l1"
		local f685_local5
		if not CoD.isPC then
			f685_local5 = "t7_icons_controller_lbwhite"
			if not f685_local5 then
			
			else
				f685_local0( f685_local1, f685_local2, f685_local3, f685_local4, f685_local5 )
				createControllerBindings( f685_arg0, nil, "left_shoulder_button_image_glow", "uie_t7_icons_controller_orbis_l1_glow" )
				f685_local0 = createControllerBindings
				f685_local1 = f685_arg0
				f685_local2 = "BUTTON_RSHLDR"
				f685_local3 = "right_shoulder_button_image"
				f685_local4 = "ps3button_r1"
				if not CoD.isPC then
					f685_local5 = "t7_icons_controller_rbwhite"
					if not f685_local5 then
					
					else
						f685_local0( f685_local1, f685_local2, f685_local3, f685_local4, f685_local5 )
						createControllerBindings( f685_arg0, nil, "right_shoulder_button_image_glow", "uie_t7_icons_controller_orbis_r1_glow" )
						createControllerBindings( f685_arg0, "BUTTON_LSTICK", "left_stick_button_image", "ps3button_l3" )
						createControllerBindings( f685_arg0, "BUTTON_RSTICK", "right_stick_button_image", "ps3button_r3" )
						createControllerBindings( f685_arg0, nil, "move_left_stick_button_image", "ui_button_ps3_stick_ls_32" )
						createControllerBindings( f685_arg0, nil, "move_right_stick_button_image", "ui_button_ps3_stick_rs_32" )
						f685_local0 = createControllerBindings
						f685_local1 = f685_arg0
						f685_local2 = "BUTTON_LTRIG"
						f685_local3 = "left_trigger_button_image"
						f685_local4 = "ps3button_l2"
						if not CoD.isPC then
							f685_local5 = "t7_icons_controller_ltwhite"
							if not f685_local5 then
							
							else
								f685_local0( f685_local1, f685_local2, f685_local3, f685_local4, f685_local5 )
								f685_local0 = createControllerBindings
								f685_local1 = f685_arg0
								f685_local2 = "BUTTON_RTRIG"
								f685_local3 = "right_trigger_button_image"
								f685_local4 = "ps3button_r2"
								if not CoD.isPC then
									f685_local5 = "t7_icons_controller_rtwhite"
									if not f685_local5 then
									
									else
										f685_local0( f685_local1, f685_local2, f685_local3, f685_local4, f685_local5 )
										createControllerBindings( f685_arg0, nil, "dpad_all_button_image", "ps3button_dpad_all" )
										createControllerBindings( f685_arg0, nil, "dpad_lr_button_image", "ps3button_dpad_rl" )
										createControllerBindings( f685_arg0, nil, "dpad_ud_button_image", "ps3button_dpad_ud" )
										createControllerBindings( f685_arg0, "DPAD_UP", "dpad_up_button_image", "ps3button_dpad_up" )
										createControllerBindings( f685_arg0, "DPAD_DOWN", "dpad_down_button_image", "ps3button_dpad_down" )
										createControllerBindings( f685_arg0, "DPAD_LEFT", "dpad_left_button_image", "ps3button_dpad_left" )
										createControllerBindings( f685_arg0, "DPAD_RIGHT", "dpad_right_button_image", "ps3button_dpad_right" )
										createControllerBindings( f685_arg0, nil, "left_stick_move_image", "t7_icons_controller_ls" )
										createControllerBindings( f685_arg0, nil, "right_stick_move_image", "t7_icons_controller_rs" )
									end
								end
								f685_local5 = "ps3button_r2"
							end
						end
						f685_local5 = "ps3button_l2"
					end
				end
				f685_local5 = "ps3button_r1"
			end
		end
		f685_local5 = "ps3button_l1"
	end
	if CoD.isPC then
		createControllerBindings( f685_arg0, 0x179662091387B23, "mouse_left_button_image", "mousebuttonleft" )
		createControllerBindings( f685_arg0, 0x179672091387CD6, "mouse_right_button_image", "mousebuttonright" )
		createControllerBindings( f685_arg0, 0x179682091387E89, "mouse_middle_button_image", "mousebuttonmiddle" )
		createControllerBindings( f685_arg0, "MWHEELUP", "mouse_wheelup_button_image", "mouseWheelUp" )
		createControllerBindings( f685_arg0, "MWHEELDOWN", "mouse_wheeldown_button_image", "mouseWheelDown" )
		createControllerBindings( f685_arg0, nil, "mouse_button_image", "mouse" )
	end
end
DataSources.InitControllerModelsAndSubscriptions = function ()
	UpdateControllerBindings( 0, Engine[0xFE5258AB5A4000]( 0 ) )
	for f686_local0 = 0, Engine[0xB686A0A723E6442]() - 1, 1 do
		local f686_local3 = f686_local0
		local f686_local4 = Engine[0x4DF5CFBC1771947]( f686_local3 )
		local f686_local5 = f686_local4:create( "hintText" )
		f686_local5:set( "" )
		f686_local5 = f686_local4:create( "MPHintText" )
		f686_local5:set( "" )
		f686_local4:create( "activeKeys", true )
		if Engine[0x8EF5BEFA0AE50FE]() then
			f686_local5 = f686_local4:create( "ZMHintText" )
			f686_local5:set( "" )
		end
		f686_local5 = f686_local4:create( "locationText" )
		f686_local5:set( "" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f686_local4, "clanTag" ), "" )
		if CoD.isPC and CoD.useController then
			if DataSourceHelpers.ControllerTypeSubscription == nil then
				DataSourceHelpers.ControllerTypeSubscription = {}
			end
			if DataSourceHelpers.ControllerTypeSubscription[f686_local3] == nil then
				DataSourceHelpers.ControllerTypeSubscription[f686_local3] = LUI.UIElement.new()
			end
			DataSourceHelpers.ControllerTypeSubscription[f686_local3]:unsubscribeFromAllModels()
			DataSourceHelpers.ControllerTypeSubscription[f686_local3]:subscribeToModel( Engine[0xA798E4552F5E872]( f686_local4, "ControllerType" ), function ( model )
				UpdateControllerBindings( f686_local3, Engine[0xFE5258AB5A4000]( f686_local3 ) )
			end, false )
		end
		Engine[0xA798E4552F5E872]( f686_local4, "WorldSpaceIndicators" )
		Engine[0xA798E4552F5E872]( f686_local4, "engineLoadoutSelect" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( Engine[0xA798E4552F5E872]( f686_local4, "scriptNotify" ), "numArgs" ), 0 )
		Engine[0xA798E4552F5E872]( f686_local4, "playerConnected" )
		Engine[0xA798E4552F5E872]( f686_local4, "playerDisconnected" )
		local f686_local6 = f686_local4:create( "predictedClientModel" )
		f686_local6:set( Engine[0xE4D2F32833CFA6C]( Engine[0x869E84B826141D2]( f686_local3 ) ) )
		f686_local6 = f686_local4:create( "clientModel" )
		f686_local6:set( Engine[0xE4D2F32833CFA6C]( Engine[0x761955642304848]( f686_local3 ) ) )
		f686_local6 = Engine[0xA798E4552F5E872]( f686_local4, "hudItems" )
		Engine[0xA798E4552F5E872]( f686_local6, "playerSpawned" )
		local f686_local7 = f686_local6:create( "deathZones" )
		local f686_local8 = f686_local7:create( "towerIndex" )
		f686_local8:set( 0 )
		f686_local8 = f686_local7:create( "floorIndex" )
		f686_local8:set( 0 )
		if nil == DataSources.PerController.PredictedClientNumSubscription then
			DataSources.PerController.PredictedClientNumSubscription = {}
		end
		if DataSources.PerController.PredictedClientNumSubscription[f686_local3] == nil then
			DataSources.PerController.PredictedClientNumSubscription[f686_local3] = LUI.UIElement.new()
			f686_local8 = function ( f688_arg0 )
				local f688_local0 = f688_arg0:get()
				if f688_local0 == -1 then
					f688_local0 = Engine[0x869E84B826141D2]( f686_local3 )
				end
				f686_local4.predictedClientModel:set( Engine[0xE4D2F32833CFA6C]( f688_local0 ) )
			end
			
			local f686_local9 = f686_local4:create( "deadSpectator" )
			f686_local9 = f686_local9:create( "playerIndex" )
			DataSources.PerController.PredictedClientNumSubscription[f686_local3]:subscribeToModel( f686_local6.playerSpawned, function ( model )
				if f686_local9:get() ~= nil then
					f686_local8( f686_local9 )
				end
			end, false )
			DataSources.PerController.PredictedClientNumSubscription[f686_local3]:subscribeToModel( f686_local9, f686_local8, false )
		end
		f686_local6:create( "stickyImage" )
		f686_local6:create( "showCursorHint" )
		f686_local6:create( "cursorHintImage" )
		f686_local6:create( "cursorHintText" )
		f686_local6:create( "cursorHintTextLine2" )
		f686_local6:create( "weapon3dHintState" )
		f686_local6:create( "weapon3dForcedHintItem" )
		f686_local6:create( "zmFeatureDescription" )
		f686_local6:create( "cursorHintIconFlip" )
		f686_local8 = f686_local6:create( "showPickupHint" )
		f686_local8:set( false )
		f686_local6:create( "pickupHintGold" )
		f686_local6:create( "pickupHintImage" )
		f686_local6:create( "pickupHintText" )
		f686_local6:create( "pickupHintTextOverride" )
		f686_local6:create( "pickupHintTextLine2" )
		f686_local6:create( "awareness" )
		f686_local6:create( "awareness.seg0.segmentValue" )
		f686_local6:create( "awareness.seg1.segmentValue" )
		f686_local6:create( "awareness.seg2.segmentValue" )
		f686_local6:create( "awareness.seg3.segmentValue" )
		f686_local6:create( "awareness.seg4.segmentValue" )
		f686_local6:create( "awareness.seg5.segmentValue" )
		f686_local6:create( "outOfBoundsEndTime" )
		f686_local6:create( "pulseNoAmmo" )
		f686_local6:create( "pulseNoLethal" )
		f686_local6:create( "pulseNoTactical" )
		f686_local6:create( "armorOverlay" )
		f686_local6:create( "armorPercent" )
		f686_local6:create( "health" )
		f686_local6:create( "health.healthValue" )
		f686_local6:create( "health.maxHealthRegen" )
		f686_local6:create( "health.inLastStand" )
		f686_local6:create( "health.beingRevived" )
		for f686_local8 = 0, CoD.HUDUtility.MAX_WOUNDS - 1, 1 do
			local f686_local11 = Engine[0xA798E4552F5E872]( f686_local6, "health.wound" .. f686_local8 )
			Engine[0xA798E4552F5E872]( f686_local11, "isActive" )
			Engine[0xA798E4552F5E872]( f686_local11, "endTime" )
			Engine[0xA798E4552F5E872]( f686_local11, "decayProgress" )
			Engine[0xA798E4552F5E872]( f686_local11, "icon" )
		end
		f686_local6:create( "infiltrationVehicle" )
		f686_local6:create( "insertionVehicleProgress" )
		f686_local6:create( "playerIsShocked" )
		f686_local6:create( "regenDelayProgress" )
		f686_local6:create( "showDamageWidget" )
		f686_local6:create( "cybercomActiveType" )
		f686_local6:create( "cybercomRequestedType" )
		f686_local6:create( "ammoPickedUp" )
		f686_local6:create( "enhancedVisionActivated" )
		f686_local6:create( "artilleryCamVisible" )
		f686_local8 = f686_local6:create( "heroHoldProgress" )
		f686_local8:set( 0 )
		f686_local8 = f686_local6:create( "useHoldProgress" )
		f686_local8:set( 0 )
		f686_local8 = f686_local6:create( "useTimerProgress" )
		f686_local8:set( 0 )
		f686_local8 = f686_local6:create( "voipInfo", true )
		for f686_local9 = 1, Enum[0x49C8C25C0F36961][0xACE86DAA4EC7F89], 1 do
			local f686_local13 = f686_local8:create( "voip" .. f686_local9, true )
			local f686_local14 = f686_local13:create( "status", true )
			f686_local14:set( 0 )
			f686_local14 = f686_local13:create( "name", true )
			f686_local14:set( "" )
		end
		f686_local6:create( "minimapTopLeftUV" )
		f686_local6:create( "minimapBottomRightUV" )
		f686_local6:create( "spawnSelectEndTime" )
		f686_local6:create( "playerRoleUpdated" )
		f686_local6:create( "inventory.open" )
		f686_local6:create( "inventory.filledSlots" )
		local f686_local9 = f686_local6:create( "PCWheels.calloutWheelKeyPressed" )
		f686_local9:set( 0 )
		f686_local9 = f686_local6:create( "PCWheels.sprayGestureWheelKeyPressed" )
		f686_local9:set( 0 )
		f686_local9 = f686_local6:create( "wheelPointerDegrees" )
		f686_local9:set( 0 )
		f686_local9 = Engine[0xA798E4552F5E872]( f686_local4, "CTF" )
		Engine[0xA798E4552F5E872]( f686_local9, "friendlyFlagCarrier" )
		Engine[0xA798E4552F5E872]( f686_local9, "friendlyFlagAway" )
		Engine[0xA798E4552F5E872]( f686_local9, "enemyFlagCarrier" )
		Engine[0xA798E4552F5E872]( f686_local9, "enemyFlagAway" )
		local f686_local10 = 7
		local f686_local12 = Engine[0xA798E4552F5E872]( f686_local6, "console" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f686_local12, "currentIndex" ), 0 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f686_local12, "numEntries" ), f686_local10 )
		for f686_local11 = 0, f686_local10 - 1, 1 do
			local f686_local15 = Engine[0xA798E4552F5E872]( f686_local12, "line" .. f686_local11 )
			Engine[0xA798E4552F5E872]( f686_local15, "text0" )
			Engine[0xA798E4552F5E872]( f686_local15, "text0color" )
			Engine[0xA798E4552F5E872]( f686_local15, "icon0" )
			Engine[0xA798E4552F5E872]( f686_local15, "text1" )
			Engine[0xA798E4552F5E872]( f686_local15, "text1color" )
			Engine[0xA798E4552F5E872]( f686_local15, "icon1" )
			Engine[0xA798E4552F5E872]( f686_local15, "text2" )
			Engine[0xA798E4552F5E872]( f686_local15, "text2color" )
			Engine[0xA798E4552F5E872]( f686_local15, "iconWidth" )
		end
		f686_local12 = Engine[0xA798E4552F5E872]( f686_local6, "centerConsole" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f686_local12, "currentIndex" ), 0 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f686_local12, "numEntries" ), f686_local10 )
		for f686_local11 = 0, f686_local10 - 1, 1 do
			local f686_local15 = Engine[0xA798E4552F5E872]( f686_local12, "line" .. f686_local11 )
			Engine[0xA798E4552F5E872]( f686_local15, "text0" )
			Engine[0xA798E4552F5E872]( f686_local15, "text0color" )
			Engine[0xA798E4552F5E872]( f686_local15, "icon0" )
			Engine[0xA798E4552F5E872]( f686_local15, "text1" )
			Engine[0xA798E4552F5E872]( f686_local15, "text1color" )
			Engine[0xA798E4552F5E872]( f686_local15, "icon1" )
			Engine[0xA798E4552F5E872]( f686_local15, "iconWidth" )
		end
		local f686_local11 = Engine[0xA798E4552F5E872]( f686_local6, "obituary" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f686_local11, "currentIndex" ), 0 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f686_local11, "numEntries" ), f686_local10 )
		for f686_local13 = 0, f686_local10 - 1, 1 do
			local f686_local17 = Engine[0xA798E4552F5E872]( f686_local11, "line" .. f686_local13 )
			Engine[0xA798E4552F5E872]( f686_local17, "attacker" )
			Engine[0xA798E4552F5E872]( f686_local17, "attackerColor" )
			Engine[0xA798E4552F5E872]( f686_local17, "attackerClientNum" )
			Engine[0xA798E4552F5E872]( f686_local17, "icon" )
			Engine[0xA798E4552F5E872]( f686_local17, "victim" )
			Engine[0xA798E4552F5E872]( f686_local17, "victimColor" )
			Engine[0xA798E4552F5E872]( f686_local17, "victimClientNum" )
		end
		local f686_local13 = Engine[0xA798E4552F5E872]( f686_local4, "obituaryCallout" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f686_local13, "clientNum" ), 0 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f686_local13, "mod" ), 0 )
		local f686_local14 = Engine[0xA798E4552F5E872]( f686_local6, "killcamWeapon" )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f686_local14, "weaponName" ), 0x0 )
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f686_local14, "weaponIcon" ), "" )
		Engine[0x83C9B5DE1D9371]( f686_local14, 0 )
		for f686_local16 = 0, 6, 1 do
			Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f686_local14, "attachment" .. f686_local16 ), 0x0 )
		end
		Engine[0xA798E4552F5E872]( f686_local14, "killfeedicon" )
		Engine[0xA798E4552F5E872]( f686_local14, "flip" )
		if CoD.isPC then
			CoD.PCUtility.ResetLockUIShortcutModelForController( f686_local3 )
		end
		if Engine[0xAB2090771654DF5]( f686_local3 ) then
			local f686_local16 = Engine[0xA798E4552F5E872]( f686_local4, "profile" )
			if f686_local16 then
				local f686_local15 = function ( f690_arg0 )
					local f690_local0 = Engine[0xA798E4552F5E872]( f686_local16, f690_arg0 )
					if f690_local0 then
						Engine[0x83C9B5DE1D9371]( f690_local0, CoD.ExeProfileVarBool( f686_local3, f690_arg0 ) )
					end
				end
				
				f686_local16:create( "brightnessPreviewColor" )
				local f686_local17 = function ( f691_arg0 )
					local f691_local0 = Engine[0xA798E4552F5E872]( f686_local16, f691_arg0 )
					if f691_local0 then
						local f691_local1 = 0
						local f691_local2 = Engine[0x3745B56C88F5316]( f686_local3 )
						if f691_local2 ~= nil and f691_local2[profileVarName] ~= nil then
							f691_local1 = f691_local2[profileVarName]:get()
						end
						Engine[0x83C9B5DE1D9371]( f691_local0, f691_local1 )
					end
				end
				
				f686_local15( "colorblindMode" )
			end
		end
		f686_local4:create( "selectedCustomClass" )
		Engine[0xA798E4552F5E872]( Engine[0xA798E4552F5E872]( f686_local4, "CACMenu" ), "numItemsToRemove" )
		Engine[0xA798E4552F5E872]( f686_local4, "unlockTokensCount" )
		Engine[0xA798E4552F5E872]( f686_local4, "permanentUnlockTokensCount" )
		Engine[0xA798E4552F5E872]( Engine[0xA798E4552F5E872]( f686_local4, "factions" ), "isCoDCaster" )
		f686_local4:create( "MenuMusic" )
		f686_local17 = f686_local4.MenuMusic:create( "musicStateName" )
		f686_local17:set( "" )
		f686_local17 = f686_local4.MenuMusic:create( "delayInMS" )
		f686_local17:set( 0 )
		f686_local4:create( "LootStreamProgress.codPoints", true )
	end
	DataSources.PartyPrivacy.getModel()
	local f686_local0 = Engine[0x8DF2E5447F384B9]()
	Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f686_local0, "ButtonStates.ReevaluateDisabledStates" ), false )
	Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f686_local0, "lobbyRoot.spinnerActive", true ), false )
	Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f686_local0, "lobbyRoot.hideMenusForGameStart" ), 0 )
	if not Engine[0x40E824FE270E174]( f686_local0, "hideWorldForStreamer" ) then
		Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f686_local0, "hideWorldForStreamer" ), 0 )
	end
	Engine[0xA798E4552F5E872]( f686_local0, "hudItems.missions.captureMultiplierStatus" )
	local f686_local1 = Engine[0xA798E4552F5E872]( f686_local0, "hudItems.war" )
	Engine[0xA798E4552F5E872]( f686_local1, "attackingTeam" )
	Engine[0xA798E4552F5E872]( f686_local1, "batteryState1" )
	Engine[0xA798E4552F5E872]( f686_local1, "batteryState2" )
	Engine[0xA798E4552F5E872]( f686_local0, "lobbyRoot.Pregame.Update" )
	Engine[0xA798E4552F5E872]( f686_local0, "lobbyRoot.Pregame.state" )
	Engine[0xA798E4552F5E872]( f686_local0, "pubstorageFilesChanged", true )
	Engine[0xA798E4552F5E872]( f686_local0, "lobbyRoot.platformUpdate" )
	Engine[0xA798E4552F5E872]( f686_local0, "lobbyRoot.beginPlay" )
	Engine[0xA798E4552F5E872]( f686_local0, "lobbyRoot.failedDemonwareConnection" )
	Engine[0x83C9B5DE1D9371]( Engine[0xA798E4552F5E872]( f686_local0, "lobbyRoot.lobbyLockedIn" ), false )
	if CoD.isZombie == true then
		local f686_local2 = Engine[0xA798E4552F5E872]( f686_local0, "hudItems.ztut" )
		Engine[0xA798E4552F5E872]( f686_local2, "showLocation", false )
		Engine[0xA798E4552F5E872]( f686_local2, "showPerks", false )
		Engine[0xA798E4552F5E872]( f686_local2, "showEquipment", false )
		Engine[0xA798E4552F5E872]( f686_local2, "showShield", false )
		Engine[0xA798E4552F5E872]( f686_local2, "showSpecial", false )
		Engine[0xA798E4552F5E872]( f686_local2, "showElixirs", false )
	end
end
