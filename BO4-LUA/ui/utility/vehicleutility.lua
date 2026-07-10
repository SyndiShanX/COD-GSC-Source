
CoD.VehicleUtility = {}
CoD.VehicleUtility.WidgetTypes = LuaEnum.createEnum( "TIME_REMAINING_BAR", "POOLED_HEALTH_BAR", "HORIZONTAL_IMAGE_HEALTH_BAR", "VERTICAL_IMAGE_HEALTH_BAR", "AMMO", "ROCKET_AMMO", "SECONDARY_AMMO", "SPEED", "RPM", "ALTITUDE", "RADAR", "BOOST_METER", "INCOMING_MISSILE", "COLLISION_WARNING", "EXIT_VEHICLE_PROMPT", "SEAT_MAP", "SWITCH_TO_DRIVER_PROMPT" )
CoD.VehicleUtility.MAX_VEHICLE_BUTTON_COOLDOWNS = 3
CoD.VehicleUtility.SUMMON_VEHICLE_PROMPT_HIDDEN = 0
CoD.VehicleUtility.SUMMON_VEHICLE_PROMPT_ACTIVE = 1
CoD.VehicleUtility.SUMMON_VEHICLE_PROMPT_DISABLED = 2
CoD.VehicleUtility.VehicleMalfunction = LuaEnum.createEnum( "VEHICLE_MALFUNCTION_OFF", "VEHICLE_MALFUNCTION_WARNING", "VEHICLE_MALFUNCTION_ACTIVE", "VEHICLE_MALFUNCTION_FATAL" )
CoD.VehicleUtility.SetBindingsTable = {}
CoD.VehicleUtility.SeatMapStates = LuaEnum.createEnum( "NONE", "ATV", "CARGO_TRUCK", "HELICOPTER", "BOAT", "BUGGY", "PATROL", "UH1D", "SUV", "MUSCLE_CAR", "ATTACK_HELICOPTER", "MOTORCYCLE", "TANK" )
CoD.VehicleUtility.SwapStringWhenUsingAlternateControls = function ( f1_arg0, f1_arg1, f1_arg2 )
	if Engine[0xD4D7317F380395F]( f1_arg0, 0x40948D6DAD927CC ) == 1 then
		local f1_local0 = f1_arg2
	end
	return f1_local0 or f1_arg1
end
CoD.VehicleUtility.TranslateBindingForPC = function ( f2_arg0, f2_arg1 )
	if CoD.isPC then
		local f2_local0 = {
			+melee = "+vehiclehorn",
			+smoke = "+handbrake",
			+breath_sprint = "+vehicleboost",
			+gostand = "+vehiclemoveup"
		}
		if IsMouseOrKeyboard( f2_arg0 ) and f2_local0[f2_arg1] then
			return f2_local0[f2_arg1]
		end
	end
	return f2_arg1
end
CoD.VehicleUtility.CreateVehicleButtonInfo = function ( f3_arg0, f3_arg1, f3_arg2, f3_arg3, f3_arg4 )
	local f3_local0 = false
	if f3_arg2 ~= nil then
		f3_local0 = f3_arg2
	end
	return {
		text = f3_arg0,
		bindCommand = f3_arg1,
		screenSide = f3_local0,
		cooldownModelIndex = f3_arg3 or 0,
		cooldownIcon = f3_arg4
	}
end
CoD.VehicleUtility.CreateVehicleTypeMap = function ( f4_arg0, f4_arg1, f4_arg2, f4_arg3, f4_arg4, f4_arg5 )
	local f4_local0 = {
		hudName = f4_arg0,
		bindings = f4_arg1,
		bindingColor = "255 255 255",
		vehicleInfoTable = f4_arg3,
		healthPoolSize = f4_arg4,
		vehicleIcon = f4_arg5
	}
	if f4_arg2 then
		f4_local0.bindingColor = "" .. f4_arg2.red .. " " .. f4_arg2.green .. " " .. f4_arg2.blue
	end
	return f4_local0
end
CoD.VehicleUtility.HUD_VehicleConfig_GetIntParam = function ( f5_arg0, f5_arg1 )
	return f5_arg0.huds[f5_arg1][0xA63348C09D91B8D]
end
CoD.VehicleUtility.HUD_VehicleConfigConditions = {
	IsVehicleOwner = function ( f6_arg0, f6_arg1, f6_arg2 )
		local f6_local0 = Engine[0x4DF5CFBC1771947]( f6_arg0 )
		return f6_local0.vehicle.isVehicleOwner:get()
	end,
	IsAttackMode = function ( f7_arg0, f7_arg1, f7_arg2 )
		local f7_local0 = Engine[0x4DF5CFBC1771947]( f7_arg0 )
		return f7_local0.vehicle.vehicleAttackMode:get() == CoD.VehicleUtility.HUD_VehicleConfig_GetIntParam( f7_arg1, f7_arg2 )
	end
}
local f0_local0 = CoD.VehicleUtility
local f0_local1 = {}
local f0_local2 = {}
local f0_local3 = {}
local f0_local4 = {}
local f0_local5 = CoD.VehicleUtility.CreateVehicleTypeMap
local f0_local6 = "VHUD_Hellstorm"
local f0_local7 = {}
local f0_local8 = CoD.VehicleUtility.CreateVehicleButtonInfo( 0xB1A03F2448A49D9, "+speed_throw", "left" )
local f0_local9 = CoD.VehicleUtility.CreateVehicleButtonInfo( 0x9D336E3DD657B0A, "+breath_sprint", "left" )
local f0_local10 = CoD.VehicleUtility.CreateVehicleButtonInfo( 0xDBA026FFA1D58CD, "+lookstick", "right" )
local f0_local11 = CoD.VehicleUtility.CreateVehicleButtonInfo( 0x1FED314D6AF9450, "+attack", "right" )
f0_local4.hud = f0_local5( f0_local6, f0_local8 )
f0_local5 = {
	hudCondition = function ( f8_arg0 )
		local f8_local0 = Engine[0x4DF5CFBC1771947]( f8_arg0, "vehicle.vehicleAttackMode" )
		return f8_local0 and f8_local0:get() == 1
	end
}
f0_local6 = CoD.VehicleUtility.CreateVehicleTypeMap
f0_local7 = "VHUD_Hellstorm"
f0_local8 = {}
f0_local9 = CoD.VehicleUtility.CreateVehicleButtonInfo( 0xB1A03F2448A49D9, "+speed_throw", "left" )
f0_local10 = CoD.VehicleUtility.CreateVehicleButtonInfo( 0x9D336E3DD657B0A, "+breath_sprint", "left" )
f0_local11 = CoD.VehicleUtility.CreateVehicleButtonInfo( 0x6368EB0A070207A, "+attack", "right" )
local f0_local12 = CoD.VehicleUtility.CreateVehicleButtonInfo( 0xDBA026FFA1D58CD, "+lookstick", "right" )
f0_local5.hud = f0_local6( f0_local7, f0_local9 )
f0_local3[1] = f0_local4
f0_local3[2] = f0_local5
f0_local2.huds = f0_local3
f0_local1[0xFAE6BCEB36818F2] = f0_local2
f0_local2 = CoD.VehicleUtility.CreateVehicleTypeMap
f0_local3 = "VHUD_Hellstorm"
f0_local4 = {}
f0_local5 = CoD.VehicleUtility.CreateVehicleButtonInfo( 0x627DEC5036BC76C, "+attack", "right" )
f0_local6 = CoD.VehicleUtility.CreateVehicleButtonInfo( 0xDBA026FFA1D58CD, "+lookstick", "right" )
f0_local1[0x3A57486124FEAEF] = f0_local2( f0_local3, f0_local5 )
f0_local0.HUD_VehicleTypeMap = f0_local1
CoD.VehicleUtility.GetVehicleHudInfo = function ( f9_arg0, f9_arg1, f9_arg2 )
	local f9_local0 = Engine[0xAAAED943C67398D]( f9_arg2 )
	if f9_local0 and f9_local0.huds and #f9_local0.huds > 0 then
		local f9_local1 = 1
		for f9_local2 = #f9_local0.huds, 2, -1 do
			local f9_local5 = f9_local0.huds[f9_local2][0xEFBBAF16820AC23]
			if CoD.VehicleUtility.HUD_VehicleConfigConditions[f9_local5] and CoD.VehicleUtility.HUD_VehicleConfigConditions[f9_local5]( f9_arg1, f9_local0, f9_local2 ) then
				f9_local1 = f9_local2
				break
			end
		end
		local f9_local2 = {}
		if f9_local0.huds[f9_local1].bindings then
			for f9_local5, f9_local8 in ipairs( f9_local0.huds[f9_local1].bindings ) do
				local f9_local7
				if f9_local8[0x1590175A80BBF59] == 0xDB156193646936F then
					f9_local7 = IsMouseOrKeyboard( f9_arg1 )
					if not f9_local7 then
						if f9_local8[0x1590175A80BBF59] == 0xD15B33F9D01BDA8 then
							f9_local7 = IsGamepad( f9_arg1 )
							if not f9_local7 then
							
							elseif f9_local7 and f9_local8[0xD52C2F1EEC8A568] and f9_local8[0xD52C2F1EEC8A568] ~= 0x0 then
								table.insert( f9_local2, CoD.VehicleUtility.CreateVehicleButtonInfo( f9_local8[0xD52C2F1EEC8A568], CoD.VehicleUtility.TranslateBindingForPC( f9_arg1, f9_local8[0xBD068E64DD33F7B] ), f9_local8[0x45FD7C1D0628D06], f9_local8[0xA6272029170E8A4], f9_local8[0x8354D260366DC39] ) )
							end
						end
						if f9_local8[0x1590175A80BBF59] ~= 0xC0D17BAD169557B then
							f9_local7 = not f9_local8[0x1590175A80BBF59]
						else
							f9_local7 = true
						end
					end
				else
					if f9_local8[0x1590175A80BBF59] == 0xD15B33F9D01BDA8 then
						f9_local7 = IsGamepad( f9_arg1 )
						if not f9_local7 then
						
						elseif f9_local7 and f9_local8[0xD52C2F1EEC8A568] and f9_local8[0xD52C2F1EEC8A568] ~= 0x0 then
							table.insert( f9_local2, CoD.VehicleUtility.CreateVehicleButtonInfo( f9_local8[0xD52C2F1EEC8A568], CoD.VehicleUtility.TranslateBindingForPC( f9_arg1, f9_local8[0xBD068E64DD33F7B] ), f9_local8[0x45FD7C1D0628D06], f9_local8[0xA6272029170E8A4], f9_local8[0x8354D260366DC39] ) )
						end
					end
					if f9_local8[0x1590175A80BBF59] ~= 0xC0D17BAD169557B then
						f9_local7 = not f9_local8[0x1590175A80BBF59]
					else
						f9_local7 = true
					end
				end
				elseif f9_local7 and f9_local8[0xD52C2F1EEC8A568] and f9_local8[0xD52C2F1EEC8A568] ~= 0x0 then
					table.insert( f9_local2, CoD.VehicleUtility.CreateVehicleButtonInfo( f9_local8[0xD52C2F1EEC8A568], CoD.VehicleUtility.TranslateBindingForPC( f9_arg1, f9_local8[0xBD068E64DD33F7B] ), f9_local8[0x45FD7C1D0628D06], f9_local8[0xA6272029170E8A4], f9_local8[0x8354D260366DC39] ) )
			end
		end
		f9_local3 = nil
		if f9_local0.huds[f9_local1][0x94735B5485CCEB3] then
			f9_local4 = LUI.splitString( f9_local0.huds[f9_local1][0x94735B5485CCEB3], " " )
			if #f9_local4 > 3 then
				f9_local3 = {
					red = math.ceil( tonumber( f9_local4[1] * 255 ) ),
					green = math.ceil( tonumber( f9_local4[2] * 255 ) ),
					blue = math.ceil( tonumber( f9_local4[3] * 255 ) )
				}
			end
		end
		return CoD.VehicleUtility.CreateVehicleTypeMap( f9_local0.huds[f9_local1][0xB60C126C21B037C], f9_local2, f9_local3, f9_local0.huds[f9_local1], f9_local0[0xFD8AC40800FEAFC], f9_local0[0x3D264D0CEDFC07E] )
	else
		local f9_local1 = CoD.VehicleUtility.HUD_VehicleTypeMap[f9_arg2]
		if not f9_local1 then
			f9_local1 = {
				hudName = f9_arg2
			}
		end
		if f9_local1.huds then
			local f9_local2 = 1
			for f9_local3 = #f9_local1.huds, 2, -1 do
				local f9_local8 = f9_local1.huds[f9_local3].hudCondition
				if f9_local8 and f9_local8( f9_arg1 ) then
					f9_local2 = f9_local3
					break
				end
			end
			return f9_local1.huds[f9_local2].hud
		else
			if f9_local1 and not f9_local1.hudName then
				local f9_local2 = nil
				for f9_local5, f9_local8 in ipairs( f9_local1 ) do
					if not f9_local8.condition or f9_local8.condition( f9_arg1 ) then
						f9_local2 = f9_local8
						break
					end
				end
				if not f9_local2 or not f9_local2.hud or not f9_local2.hud.hudName then
					return nil
				end
				f9_local1 = f9_local2.hud
			end
			return f9_local1
		end
	end
end
DataSourceHelpers.PerControllerDataSourceSetup( "VehicleInfo", "vehicle", function ( f10_arg0, f10_arg1 )
	f10_arg0:create( "vehicleType" )
	f10_arg0:create( "forceUpdateVehicleBindings" )
	f10_arg0:create( "isVehicleOwner" )
	DataSources.VehicleInfo.resetVehicleModels( f10_arg1 )
end, false, {
	setupVehicleModels = function ( f11_arg0, f11_arg1 )
		DataSources.VehicleInfo.resetVehicleModels( f11_arg0 )
		local f11_local0 = DataSources.VehicleInfo.getModel( f11_arg0 )
		local f11_local1 = f11_local0.bindings
		if f11_arg1.bindingColor then
			f11_local1.color:set( f11_arg1.bindingColor )
		end
		if f11_arg1.vehicleInfoTable and f11_arg1.vehicleInfoTable[0x6B4C5C47FCF7794] == 1 then
			f11_local0.hidePlayerInfo:set( true )
		end
		if f11_arg1.vehicleInfoTable and f11_arg1.vehicleInfoTable[0x6B733BAB2268891] == 1 then
			f11_local0.hideWeaponInfo:set( true )
		end
		local f11_local2 = IsGamepad( f11_arg0 )
		local f11_local3 = {
			left = 0,
			right = 0,
			cooldown = 0
		}
		local f11_local4 = {}
		for f11_local18, f11_local19 in ipairs( f11_arg1.bindings ) do
			if f11_local19.bindCommand and (f11_local19.text ~= 0xB136DBF97F5D00D or 1 == Engine[0x22EAAB59AA27E9B]( 0x5D9CDEECB132532 )) then
				local f11_local8, f11_local9 = Engine[0x78A2D9137CF98ED]( f11_arg0, f11_local19.bindCommand )
				local f11_local10 = string.sub( f11_local19.bindCommand, 1, 1 ) and string.upper( string.sub( f11_local19.bindCommand, 2, -1 ) ) or string.upper( f11_local19.bindCommand )
				if f11_local8 then
					CoD.VehicleUtility.SetBindingsTable[f11_local8] = true
					local f11_local11 = f11_local1:create( f11_local8 .. ".text" )
					f11_local11:set( f11_local19.text )
					f11_local11 = f11_local1:create( f11_local8 .. ".bind" )
					f11_local11:set( Engine[0xDFD7EFA83DD8C75]( f11_arg0, f11_local19.bindCommand ) )
					if CoD.isPC then
						f11_local11 = f11_local1:create( f11_local10 .. ".text" )
						f11_local11:set( f11_local19.text )
						f11_local11 = f11_local1:create( f11_local10 .. ".bind" )
						f11_local11:set( Engine[0xDFD7EFA83DD8C75]( f11_arg0, f11_local19.bindCommand ) )
					end
					if f11_local19.cooldownIcon then
						f11_local11 = f11_local1:create( f11_local8 .. ".cooldownIcon" )
						f11_local11:set( f11_local19.cooldownIcon )
						if CoD.isPC then
							f11_local11 = f11_local1:create( f11_local10 .. ".cooldownIcon" )
							f11_local11:set( f11_local19.cooldownIcon )
						end
					end
					f11_local11 = nil
					if f11_local19.cooldownModelIndex > 0 then
						f11_local11 = f11_local0["bindingCooldown" .. f11_local19.cooldownModelIndex - 1]
						if f11_local4[f11_local19.cooldownModelIndex] then
							error( "Error: Vehicle " .. f11_local0.vehicleType:get() .. " cannot have two button bindings share the same cooldown slot ([" .. f11_local19.bindCommand .. "] and [" .. f11_local4[f11_local19.cooldownModelIndex] .. "])" )
						end
						f11_local4[f11_local19.cooldownModelIndex] = f11_local19.bindCommand
					end
					if f11_local11 then
						local f11_local12 = f11_local1:create( f11_local8 .. ".cooldown" )
						f11_local12:set( f11_local11 )
						if CoD.isPC then
							f11_local12 = f11_local1:create( f11_local10 .. ".cooldownIcon" )
							f11_local12:set( f11_local11 )
						end
					end
					local f11_local12 = f11_local19.screenSide
					if f11_local12 and f11_local3[f11_local12] then
						local f11_local13 = f11_local3[f11_local12]
						f11_local3[f11_local12] = f11_local13 + 1
						local f11_local14 = ToUpper( f11_local12 ) .. "_" .. f11_local13
						CoD.VehicleUtility.SetBindingsTable[f11_local14] = true
						local f11_local15 = f11_local1:create( f11_local14 )
						local f11_local16 = f11_local15:create( "text" )
						f11_local16:set( f11_local19.text )
						f11_local16 = Engine[0xDFD7EFA83DD8C75]( f11_arg0, f11_local19.bindCommand )
						local f11_local17 = f11_local15:create( "bind" )
						f11_local17:set( f11_local16 )
						if f11_local11 then
							f11_local17 = f11_local15:create( "cooldown" )
							f11_local17:set( f11_local11 )
						end
						if f11_local19.cooldownIcon then
							f11_local17 = f11_local15:create( "cooldownIcon" )
							f11_local17:set( f11_local19.cooldownIcon )
						end
					end
				end
			end
		end
		f11_local5 = ipairs
		f11_local6 = f11_arg1.vehicleInfoTable and f11_arg1.vehicleInfoTable.widgets or {}
		for f11_local18, f11_local19 in f11_local5( f11_local6 ) do
			if f11_local19[0x2BF9BFD10656F2D] == CoD.VehicleUtility.WidgetTypes.HORIZONTAL_IMAGE_HEALTH_BAR or f11_local19[0x2BF9BFD10656F2D] == CoD.VehicleUtility.WidgetTypes.VERTICAL_IMAGE_HEALTH_BAR then
				local f11_local8 = function ( f12_arg0 )
					local f12_local0 = f11_local19[f12_arg0]
					if f12_local0 and f12_local0 ~= "" then
						return f12_local0
					else
						return "blacktransparent"
					end
				end
				
				local f11_local9 = f11_local0:create( "damageOverlayImage" )
				f11_local9:set( Engine[0xC53F8D38DF9042B]( f11_local8( 0xD32221D0A6CF3D8 ) ) )
				f11_local9 = f11_local0:create( "damageFillImage" )
				f11_local9:set( Engine[0xC53F8D38DF9042B]( f11_local8( 0x69E7358AF915935 ) ) )
			elseif f11_local19[0x2BF9BFD10656F2D] == CoD.VehicleUtility.WidgetTypes.TIME_REMAINING_BAR then
				local f11_local8 = f11_local0:create( "showTimeRemaining" )
				f11_local8:set( true )
			elseif f11_local19[0x2BF9BFD10656F2D] == CoD.VehicleUtility.WidgetTypes.AMMO then
				local f11_local8 = f11_local0:create( "showAmmo" )
				f11_local8:set( true )
				f11_local8 = f11_local0:create( "ammoIcon" )
				f11_local8:set( f11_local19[0xC1D8B8E6B5C6F4D] or 0x7615068F50B3D66 )
			elseif f11_local19[0x2BF9BFD10656F2D] == CoD.VehicleUtility.WidgetTypes.SECONDARY_AMMO then
				local f11_local8 = f11_local0:create( "secondaryAmmoTitle" )
				f11_local8:set( f11_local19.header )
				f11_local8 = f11_local0:create( "secondaryAmmoSecondaryText" )
				f11_local8:set( f11_local19.secondaryString )
			elseif f11_local19[0x2BF9BFD10656F2D] == CoD.VehicleUtility.WidgetTypes.ROCKET_AMMO then
				local f11_local8 = f11_local0:create( "rocketTitle" )
				f11_local8:set( f11_local19.header )
			elseif f11_local19[0x2BF9BFD10656F2D] == CoD.VehicleUtility.WidgetTypes.POOLED_HEALTH_BAR then
				local f11_local8 = f11_local0:create( "showPooledHealthBar" )
				f11_local8:set( true )
				f11_local8 = f11_local0:create( "pooledHealthAmount" )
				f11_local8:set( f11_arg1.healthPoolSize or 0 )
				f11_local8 = f11_local0:create( "vehicleIcon" )
				f11_local8:set( f11_local19[0xC1D8B8E6B5C6F4D] or 0x7615068F50B3D66 )
			elseif f11_local19[0x2BF9BFD10656F2D] == CoD.VehicleUtility.WidgetTypes.SPEED then
				local f11_local8 = f11_local0:create( "showSpeed" )
				f11_local8:set( true )
			elseif f11_local19[0x2BF9BFD10656F2D] == CoD.VehicleUtility.WidgetTypes.RPM then
				local f11_local8 = f11_local0:create( "showRPM" )
				f11_local8:set( true )
			elseif f11_local19[0x2BF9BFD10656F2D] == CoD.VehicleUtility.WidgetTypes.ALTITUDE then
				local f11_local8 = f11_local0:create( "showAltitude" )
				f11_local8:set( true )
			elseif f11_local19[0x2BF9BFD10656F2D] == CoD.VehicleUtility.WidgetTypes.RADAR then
				local f11_local8 = f11_local0:create( "enableRadar" )
				f11_local8:set( true )
			elseif f11_local19[0x2BF9BFD10656F2D] == CoD.VehicleUtility.WidgetTypes.BOOST_METER then
				local f11_local8 = f11_local0:create( "enableBoostMeter" )
				f11_local8:set( true )
			elseif f11_local19[0x2BF9BFD10656F2D] == CoD.VehicleUtility.WidgetTypes.INCOMING_MISSILE then
				local f11_local8 = f11_local0:create( "showMissileProximity" )
				f11_local8:set( true )
			elseif f11_local19[0x2BF9BFD10656F2D] == CoD.VehicleUtility.WidgetTypes.COLLISION_WARNING then
				local f11_local8 = f11_local0:create( "showCollisionWarning" )
				f11_local8:set( true )
			elseif f11_local19[0x2BF9BFD10656F2D] == CoD.VehicleUtility.WidgetTypes.EXIT_VEHICLE_PROMPT then
				local f11_local8 = f11_local0:create( "enableVehicleExitPrompt" )
				f11_local8:set( true )
				if f11_local19[0xD479F6320D21682] and f11_local19[0xD479F6320D21682] ~= 0x0 then
					f11_local8 = f11_local0:create( "vehicleExitPromptRef" )
					f11_local8:set( f11_local19[0xD479F6320D21682] )
				else
					f11_local8 = f11_local0:create( "vehicleExitPromptRef" )
					f11_local8:set( 0xC7D903A026627FC )
				end
			elseif f11_local19[0x2BF9BFD10656F2D] == CoD.VehicleUtility.WidgetTypes.SEAT_MAP then
				local f11_local8 = f11_local0:create( "showSeatMap" )
				f11_local8:set( true )
				f11_local8 = f11_local0:create( "seatMapState" )
				f11_local8:set( f11_local19[0x3B76D86D727423] )
			elseif f11_local19[0x2BF9BFD10656F2D] == CoD.VehicleUtility.WidgetTypes.SWITCH_TO_DRIVER_PROMPT then
				local f11_local8 = f11_local0:create( "showSwitchToDriverPrompt" )
				f11_local8:set( true )
				if f11_local19[0x14F6FC8E568FD75] and f11_local19[0x14F6FC8E568FD75] ~= 0x0 then
					f11_local8 = f11_local0:create( "vehicleDriverStringOverrideRef" )
					f11_local8:set( f11_local19[0x14F6FC8E568FD75] )
				else
					f11_local8 = f11_local0:create( "vehicleDriverStringOverrideRef" )
					f11_local8:set( 0xCE3EF50B2B067C3 )
				end
			end
		end
	end,
	resetVehicleModels = function ( f13_arg0 )
		local f13_local0 = DataSources.VehicleInfo.getModel( f13_arg0 )
		local f13_local1 = f13_local0.bindings
		for f13_local6, f13_local7 in pairs( CoD.VehicleUtility.SetBindingsTable ) do
			local f13_local5 = f13_local1[f13_local6]
			if f13_local5 then
				f13_local5 = f13_local1[f13_local6].bind
			end
			if f13_local5 then
				f13_local5:set( "" )
			end
		end
		CoD.VehicleUtility.SetBindingsTable = {}
		if f13_local1 then
			Engine[0x8C7A8C4C5FD9892]( f13_local1 )
		end
		f13_local2 = f13_local0:create( "ammoTitle" )
		f13_local2:set( "" )
		f13_local2 = f13_local0:create( "ammoSecondaryText" )
		f13_local2:set( "" )
		f13_local2 = f13_local0:create( "secondaryAmmoTitle" )
		f13_local2:set( "" )
		f13_local2 = f13_local0:create( "secondaryAmmoSecondaryText" )
		f13_local2:set( "" )
		f13_local2 = f13_local0:create( "rocketTitle" )
		f13_local2:set( "" )
		f13_local2 = f13_local0:create( "damageFillImage" )
		f13_local2:set( 0x7615068F50B3D66 )
		f13_local2 = f13_local0:create( "showPooledHealthBar" )
		f13_local2:set( false )
		f13_local0:create( "pooledHealthAmount" )
		f13_local2 = f13_local0:create( "vehicleIcon" )
		f13_local2:set( 0x7615068F50B3D66 )
		f13_local2 = f13_local0:create( "showAmmo" )
		f13_local2:set( false )
		f13_local2 = f13_local0:create( "ammoIcon" )
		f13_local2:set( 0x7615068F50B3D66 )
		f13_local2 = f13_local0:create( "showSpeed" )
		f13_local2:set( false )
		f13_local2 = f13_local0:create( "showRPM" )
		f13_local2:set( false )
		f13_local2 = f13_local0:create( "showAltitude" )
		f13_local2:set( false )
		f13_local2 = f13_local0:create( "showTimeRemaining" )
		f13_local2:set( false )
		f13_local2 = f13_local0:create( "enableRadar" )
		f13_local2:set( false )
		f13_local2 = f13_local0:create( "enableBoostMeter" )
		f13_local2:set( false )
		f13_local2 = f13_local0:create( "showMissileProximity" )
		f13_local2:set( false )
		f13_local2 = f13_local0:create( "incomingMissile" )
		f13_local2:set( 0 )
		f13_local2 = f13_local0:create( "showCollisionWarning" )
		f13_local2:set( false )
		f13_local2 = f13_local0:create( "enableVehicleExitPrompt" )
		f13_local2:set( false )
		f13_local2 = f13_local0:create( "showSeatMap" )
		f13_local2:set( false )
		f13_local2 = f13_local0:create( "seatMapState" )
		f13_local2:set( CoD.VehicleUtility.SeatMapStates.NONE )
		f13_local2 = f13_local0:create( "bindings" )
		f13_local2 = f13_local2:create( "color" )
		f13_local2:set( "255 255 255" )
		f13_local2 = f13_local0:create( "hidePlayerInfo" )
		f13_local2:set( false )
		f13_local2 = f13_local0:create( "hideWeaponInfo" )
		f13_local2:set( false )
		f13_local2 = f13_local0:create( "vehicleExitPromptRef" )
		f13_local2:set( 0xC7D903A026627FC )
		f13_local2 = f13_local0:create( "showSwitchToDriverPrompt" )
		f13_local2:set( false )
		for f13_local2 = 1, CoD.VehicleUtility.MAX_VEHICLE_BUTTON_COOLDOWNS, 1 do
			f13_local7 = f13_local0:create( "bindingCooldown" .. f13_local2 - 1 )
			f13_local7:set( 0 )
		end
	end
} )
CoD.VehicleUtility.RegisterPooledHealthBar = function ( f14_arg0, f14_arg1, f14_arg2, f14_arg3, f14_arg4 )
	local f14_local0 = function ()
		local f15_local0 = DataSources.VehicleInfo.getModel( f14_arg1 )
		local f15_local1 = 1 - (f15_local0.damage:get() or 0)
		local f15_local2 = f15_local0.maxHealth:get() or 1
		local f15_local3 = f15_local2 * f15_local1
		local f15_local4 = f15_local0.pooledHealthAmount:get() or f15_local2
		local f15_local5 = f15_local2 / f15_local4
		local f15_local6 = function ( f16_arg0, f16_arg1 )
			local f16_local0 = f14_arg0[f16_arg0]
			f16_local0:setShaderVector( 2, 1 - f16_arg1, 1, 0, 0 )
			f16_local0:setShaderVector( 4, 1, 0, f15_local5, 0.02 )
		end
		
		f15_local6( f14_arg2, 1 )
		f15_local6( f14_arg3, math.ceil( f15_local3 / f15_local4 ) / f15_local5 )
		f15_local6( f14_arg4, f15_local1 )
	end
	
	f14_arg0:subscribeToGlobalModel( f14_arg1, "VehicleInfo", "damage", f14_local0, true )
	f14_arg0:subscribeToGlobalModel( f14_arg1, "VehicleInfo", "maxHealth", f14_local0, true )
	f14_arg0:subscribeToGlobalModel( f14_arg1, "VehicleInfo", "pooledHealthAmount", f14_local0, true )
end
CoD.VehicleUtility.ScaleWithSpeed = function ( f17_arg0, f17_arg1, f17_arg2, f17_arg3, f17_arg4 )
	return f17_arg2 + LuaUtils.smoothstep( f17_arg0, f17_arg1, f17_arg4 ) * (f17_arg3 - f17_arg2)
end
CoD.VehicleUtility.ScaleClockVectorWithSpeed = function ( f18_arg0, f18_arg1, f18_arg2, f18_arg3, f18_arg4, f18_arg5, f18_arg6, f18_arg7, f18_arg8 )
	return CoD.VehicleUtility.ScaleWithSpeed( f18_arg0, f18_arg1, f18_arg2, f18_arg3, f18_arg5 ), f18_arg6, f18_arg4, f18_arg8
end
CoD.VehicleUtility.UpdateTankWipeValue = function ( f19_arg0 )
	local f19_local0 = f19_arg0:getModel()
	local f19_local1 = f19_local0.damage:get()
	local f19_local2 = f19_local0.maxHealth:get()
	if f19_local2 <= 0 then
		return 
	else
		f19_arg0.FillBars:setShaderVector( 1, CoD.BaseUtility.TruncateFractionToIncrement( f19_local1, Dvar[0xB5B2E9749C2E22B]:get() / f19_local2 ), 1, 0, 1 )
	end
end
CoD.VehicleUtility.SetupTankWipeValue = function ( f20_arg0, f20_arg1 )
	f20_arg0:linkToElementModel( f20_arg0, "damage", true, function ( model )
		CoD.VehicleUtility.UpdateTankWipeValue( f20_arg0 )
	end )
	f20_arg0:linkToElementModel( f20_arg0, "maxHealth", true, function ( model )
		CoD.VehicleUtility.UpdateTankWipeValue( f20_arg0 )
	end )
end
CoD.VehicleUtility.VehicleLowHealth = function ( f23_arg0, f23_arg1 )
	local f23_local0 = f23_arg0:getModel()
	return 1 - f23_local0.damage:get() <= f23_arg1
end
CoD.VehicleUtility.VehicleAmmoToWipeAmountRow1 = function ( f24_arg0, f24_arg1, f24_arg2, f24_arg3, f24_arg4 )
	local f24_local0 = f24_arg1
	local f24_local1 = f24_arg0.ammoClipSize:get() / 2
	if math.floor( f24_local0 / f24_local1 ) > 0 then
		return 1 - (f24_local0 - f24_local1) / f24_local1, f24_arg2, f24_arg3, f24_arg4
	else
		return 1, f24_arg2, f24_arg3, f24_arg4
	end
end
CoD.VehicleUtility.VehicleAmmoToWipeAmountRow2 = function ( f25_arg0, f25_arg1, f25_arg2, f25_arg3, f25_arg4 )
	local f25_local0 = f25_arg1
	local f25_local1 = f25_arg0.ammoClipSize:get() / 2
	if math.floor( f25_local0 / f25_local1 ) < 1 then
		return 1 - f25_local0 / f25_local1, f25_arg2, f25_arg3, f25_arg4
	else
		return 0, f25_arg2, f25_arg3, f25_arg4
	end
end
CoD.VehicleUtility.VehicleAmmoToWipeAmountSingleRow = function ( f26_arg0, f26_arg1, f26_arg2, f26_arg3, f26_arg4 )
	return 1 - f26_arg1 / f26_arg0.ammoClipSize:get(), f26_arg2, f26_arg3, f26_arg4
end
CoD.VehicleUtility.AC130MainCannonAmmoToWipeProgress = function ( f27_arg0, f27_arg1, f27_arg2, f27_arg3, f27_arg4 )
	if f27_arg0.bindingCooldown0.cooldown:get() < 1 then
		return 0, 0, 0, 1
	end
	local f27_local0 = f27_arg0.ac130
	if f27_local0 then
		f27_local0 = f27_arg0.ac130.maincannonClipSize
		if f27_local0 then
			f27_local0 = f27_arg0.ac130.maincannonClipSize:get()
		end
	end
	return 0, f27_arg0.rocketAmmo:get() / f27_local0, 0, 1
end
CoD.VehicleUtility.AC130AutoCannonToWipeProgress = function ( f28_arg0, f28_arg1, f28_arg2, f28_arg3, f28_arg4 )
	if f28_arg0.bindingCooldown1.cooldown:get() < 1 then
		return 0, 0, 0, 1
	end
	local f28_local0 = f28_arg0.ac130
	if f28_local0 then
		f28_local0 = f28_arg0.ac130.autocannonClipSize
		if f28_local0 then
			f28_local0 = f28_arg0.ac130.autocannonClipSize:get()
		end
	end
	return 0, f28_arg0.ammoCount:get() / f28_local0, 0, 1
end
CoD.VehicleUtility.AC130ChaingunAmmoToWipeProgress = function ( f29_arg0, f29_arg1, f29_arg2, f29_arg3, f29_arg4 )
	if f29_arg0.bindingCooldown2.cooldown:get() < 1 then
		return 0, 0, 0, 1
	end
	local f29_local0 = f29_arg0.ac130
	if f29_local0 then
		f29_local0 = f29_arg0.ac130.chaingunClipSize
		if f29_local0 then
			f29_local0 = f29_arg0.ac130.chaingunClipSize:get()
		end
	end
	return 0, f29_arg0.ammo2Count:get() / f29_local0, 0, 1
end
CoD.VehicleUtility.AC130ChaingunAmmoToWipeProgress2 = function ( f30_arg0, f30_arg1, f30_arg2, f30_arg3, f30_arg4 )
	if f30_arg0.bindingCooldown2.cooldown:get() < 1 then
		return 0, 0, 0, 1
	end
	local f30_local0 = f30_arg0.ac130
	if f30_local0 then
		f30_local0 = f30_arg0.ac130.chaingunClipSize
		if f30_local0 then
			f30_local0 = f30_arg0.ac130.chaingunClipSize:get()
		end
	end
	return 0, (f30_arg0.ammo2Count:get() - f30_local0) / f30_local0, 0, 1
end
CoD.VehicleUtility.TankRobotRocketToWipeProgress = function ( f31_arg0, f31_arg1, f31_arg2, f31_arg3, f31_arg4 )
	return 0, f31_arg0.ammoCount:get() / 4, 0, 1
end
