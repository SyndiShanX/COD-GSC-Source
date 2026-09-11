
// Params 0
// Size: 0x45a
function init()
{
    if ( !getdvarint( "scr_br_alt_mode_zxp", 0 ) )
    {
        return;
    }
    
    level.disable_super_in_turret.brmayconsiderplayerdead = 1;
    level.disable_super_in_turret.ref_146e7 = 1;
    level.disable_super_in_turret.ref_146c9 = init_warning_levels();
    level.disable_super_in_turret.ref_146bd = getdvarint( "scr_br_zxp_health", 300 );
    level.disable_super_in_turret.ref_146f1 = getdvarint( "scr_br_zxp_zombiesDamageZombies", 0 );
    level.disable_super_in_turret.ref_146f2 = getdvarint( "scr_br_zxp_zombiesDamageZombiesDamage", 80 );
    level.disable_super_in_turret.ref_146f8 = getdvarint( "scr_br_zxp_zombieIgnoreVehicleExplosions", 1 );
    level.disable_super_in_turret.brking_movenextcirclecenter = getdvarint( "scr_br_zxp_allow_zombie_uav", 1 );
    level.disable_super_in_turret.ref_146d5 = getdvarfloat( "scr_br_zxp_ping_rate", -1 );
    level.disable_super_in_turret.ref_146d6 = getdvarfloat( "scr_br_zxp_ping_time", 0.5 );
    level.disable_super_in_turret.ref_146d2 = getdvarint( "scr_br_zxp_num_consume", 4 );
    level.disable_super_in_turret.ref_146e5 = getdvarfloat( "scr_br_zxp_regen_rate_scale_in_gas", 1 );
    level.disable_super_in_turret.ref_146e6 = getdvarfloat( "scr_br_zxp_regen_rate_scale_out_gas", 0.5 );
    level.disable_super_in_turret.ref_146e3 = getdvarfloat( "scr_br_zxp_regen_delay_scale_in_gas", 1 );
    level.disable_super_in_turret.ref_146e4 = getdvarfloat( "scr_br_zxp_regen_delay_scale_out_gas", 1.5 );
    level.disable_super_in_turret.ref_146e2 = getdvarint( "scr_br_zxp_powers", 1 );
    level.disable_super_in_turret.ref_12820 = getdvarint( "scr_br_zxp_powers_cooldown", 1 );
    level.disable_super_in_turret.ref_146cf = getdvarfloat( "scr_br_zxp_numHits", 3 );
    level.disable_super_in_turret.ref_146d0 = getdvarfloat( "scr_br_zxp_numHitsJugg", 20 );
    level.disable_super_in_turret.ref_146bf = getdvarint( "scr_br_zxp_ignoreArmor", 1 );
    level.disable_super_in_turret.ref_146e8 = getdvarint( "scr_br_zxp_respawn_shutdown_jugg", 1 );
    level.disable_super_in_turret.ref_146ce = getdvarfloat( "scr_br_zxp_numHitsHeli", 2 );
    level.disable_super_in_turret.ref_146cc = getdvarfloat( "scr_br_zxp_numHitsAtv", 2 );
    level.disable_super_in_turret.ref_146cd = getdvarfloat( "scr_br_zxp_numHitsCar", 3 );
    level.disable_super_in_turret.ref_146d1 = getdvarfloat( "scr_br_zxp_numHitsTruck", 4 );
    level.disable_super_in_turret.ref_146fc = getdvarint( "scr_br_zxp_spawn_air", 1 );
    level.disable_super_in_turret.ref_1470a = getdvarint( "scr_br_zxp_vehicle_laststand", 0 );
    level.disable_super_in_turret.ref_146fb = getdvarint( "scr_br_zxp_zombie_spawn_above", 0 );
    level.disable_super_in_turret.spawndragonsbreathstruct = getdvarint( "scr_br_zxp_human_spawn_air", 1 );
    level.disable_super_in_turret.fluctuatevalues = getdvarint( "scr_br_zxp_buyback_human", 1 );
    level.disable_super_in_turret.vehicle_occupancy_friendlystatuschangedcallback = getdvarint( "scr_br_zxp_jugg_num_players", 3 );
    level.disable_super_in_turret.vehicle_occupancy_getreserving = getdvarint( "scr_br_zxp_jugg_health_icon", 0 );
    level.disable_super_in_turret.spawndistancemax = getdvarint( "scr_br_zxp_server_hud", 0 );
    level.disable_super_in_turret.vehicle_occupancy_monitorturretcontrols = getdvarint( "scr_br_zxp_jump_trace_up1_offset", 20 );
    level.disable_super_in_turret.vehicle_occupancy_mp_changedseats = getdvarint( "scr_br_zxp_jump_trace_up2_offset", 30 );
    level.disable_super_in_turret.ref_1470c = getdvarint( "scr_br_zxp_zombie_vision", 1 );
    level.disable_super_in_turret.ref_1470d = getdvarint( "scr_br_zxp_zombie_vision_overlay", 1 );
    level.disable_super_in_turret.ref_14061 = getdvarint( "scr_br_zxp_use_armor_headshot_scale", 0 );
    level.disable_super_in_turret.ref_146bc = getdvarfloat( "scr_br_zxp_zombie_headshot_scalar", 0.65 );
    level.disable_super_in_turret.¢~{Ë8˙
kˆ-ÇÅ ÿ∑€+<íßµ = getdvarint( "scr_br_zxp_zombie_can_see_and_open_loot", 1 );
    level.disable_super_in_turret.∫}rïöçh%Û∞„y„›}e˚Ôí{Û = getdvarint( "scr_br_zxp_zombie_respawn_on_execute", 1 );
    level.disable_super_in_turret.Ç X_µæpÕ•Àˇ!w◊∞@Ê§bF|(î!Ä—pÿäÁÕ„H = getdvarint( "scr_br_zxp_zombie_respawn_on_laststand_execute", 0 );
    level.disable_super_in_turret.Å"-iK+≈ÿâ±Jsì2)3qËòC = getdvarint( "scr_br_zombie_enable_execution", 1 );
    level.disable_super_in_turret.vehicle_occupancy_getplayerfriendlyto = 0;
    level.ref_13364 = 1;
    game[ "dialog" ][ "zmb_player_into_zombie" ] = "zombie_player_into_zombie";
    game[ "dialog" ][ "zmb_teammate_into_zombie" ] = "zombie_teammate_into_zombie";
    game[ "dialog" ][ "zmb_need_someone_alive" ] = "zombie_near_end";
    level._effect[ "zombie_trans" ] = loadfx( "vfx/iw8_br/gameplay/zombie/vfx_zmb_transition_to_human.vfx" );
    level._effect[ "zombie_splat" ] = loadfx( "vfx/iw8_br/gameplay/zombie/vfx_zmb_freefall_splat.vfx" );
    level.disable_super_in_turret.empvfx = loadfx( "vfx/iw8_br/gameplay/zombie/vfx_zmb_zombie_emp_blast.vfx" );
    level.disable_super_in_turret.start_coop_defuse_infiltrate = loadfx( "vfx/iw8_br/gameplay/zombie/vfx_zmb_human_push_blast" );
    thread toggleusbstickinhand();
}

// Params 0
// Size: 0x34
function toggleusbstickinhand()
{
    waittillframeend();
    
    if ( level.disable_super_in_turret.vehicle_occupancy_friendlystatuschangedcallback > 0 && level.disable_super_in_turret.vehicle_occupancy_getreserving )
    {
        level.vehicle_occupancy_forceweaponswitchallowed = undefined;
    }
    
    thread ref_13283();
    thread ref_1472d();
}

// Params 0
// Size: 0x2f
function ref_126a4()
{
    var0 = self;
    
    if ( !isdefined( var0.spawndomplateflag ) )
    {
        ref_12725( var0 );
    }
    
    wait 0.5;
    ref_125fc( var0 );
    wait 2;
    ref_12723( var0, 0 );
}

// Params 1
// Size: 0x4e2
function modifyplayerdamage( var0 )
{
    var1 = var0.damage;
    var2 = isplayer( var0.attacker ) && var0.attacker scripts\mp\gametypes\br_public::ref_125f3();
    var3 = isdefined( var0.attacker ) && nukefridgewatcher( var0.attacker );
    var4 = isplayer( var0.victim ) && var0.victim scripts\mp\gametypes\br_public::ref_125f3();
    var5 = scripts\mp\utility\weapon::getweaponbasenamescript( var0.objweapon );
    
    if ( var2 && var4 && var0.meansofdeath == "MOD_MELEE" )
    {
        if ( !level.disable_super_in_turret.ref_146f1 )
        {
            var1 = 0;
        }
        else
        {
            var1 = level.disable_super_in_turret.ref_146f2;
        }
    }
    else if ( var2 && !var4 && !var0.attacker isinexecutionattack() && var0.victim isinexecutionvictim() )
    {
        var1 = 0;
    }
    else if ( isdefined( var0.attacker ) && istrue( var0.attacker.isjuggernaut ) && var4 && var0.meansofdeath == "MOD_MELEE" )
    {
        var1 = var0.victim.maxhealth / 3;
    }
    else if ( var4 && var0.meansofdeath == "MOD_FALLING" )
    {
        var1 = 0;
    }
    else if ( var4 && isdefined( var0.inflictor ) && isdefined( var0.inflictor.streakinfo ) && ( var0.inflictor.streakinfo.streakname == "toma_strike" || var0.inflictor.streakinfo.streakname == "precision_airstrike" || var0.inflictor.streakinfo.streakname == "manual_turret" ) )
    {
        var6 = var0.victim.maxhealth;
        var7 = var0.attacker.maxhealth;
        var1 = var0.damage * int( floor( var6 / var7 ) );
    }
    else if ( level.disable_super_in_turret.ref_146f8 && var4 && isexplosivedamagemod( var0.meansofdeath ) && isdefined( var0.inflictor ) && var0.inflictor scripts\cp_mp\vehicles\vehicle::isvehicle() )
    {
        var1 = 0;
    }
    else if ( var4 && ( var0.meansofdeath == "MOD_GRENADE_SPLASH" || var0.meansofdeath == "MOD_EXPLOSIVE" ) )
    {
        var1 = var0.damage * getdvarfloat( "scr_br_zxp_explosive_dmg_multiplier", 3 );
    }
    else if ( var2 && !var4 && var0.meansofdeath == "MOD_MELEE" )
    {
        var8 = var0.victim.maxhealth;
        var9 = level.disable_super_in_turret.ref_146cf;
        
        if ( istrue( var0.victim.isjuggernaut ) )
        {
            var9 = level.disable_super_in_turret.ref_146d0;
        }
        
        if ( !level.disable_super_in_turret.ref_146bf )
        {
            var8 += var0.victim.br_maxarmorhealth;
        }
        
        var1 = int( ceil( var8 / var9 ) );
    }
    else if ( var4 && var3 && istrue( var0.victim.ref_1423b ) )
    {
        var1 = 0;
    }
    else if ( var2 && !var4 && var0.meansofdeath == "MOD_IMPACT" && var5 == "rock_mp" )
    {
        var10 = spawnstruct();
        var10.origin = var0.point;
        var0.victim thread scripts\mp\equipment\concussion_grenade::applyconcussion( var10, var0.attacker );
    }
    else if ( var4 )
    {
        var11 = 0.7;
        var12 = scripts\mp\utility\weapon::getweaponrootname( var0.objweapon );
        var13 = weaponclass( var5 );
        var14 = scripts\mp\gametypes\br::tutzonetriggerlogic( var0.idflags );
        
        if ( !var14 )
        {
            switch ( var13 )
            {
                case "sniper":
                    if ( var0.shitloc == "head" || var0.shitloc == "helmet" )
                    {
                        if ( scripts\mp\gametypes\br::usefailvehiclemsg( var12 ) )
                        {
                            var1 = int( ceil( level.disable_super_in_turret.ref_146bd * var11 ) );
                        }
                        else
                        {
                            var1 = level.disable_super_in_turret.ref_146bd;
                        }
                    }
                    
                    break;
                default:
                    if ( var0.shitloc == "head" || var0.shitloc == "helmet" )
                    {
                        var15 = getdvarfloat( "scr_player_maxhealth", 100 );
                        var16 = var15;
                        
                        if ( level.disable_super_in_turret.ref_14061 )
                        {
                            var16 += scripts\mp\gametypes\br_armor::getdefaultmaxarmorhealth();
                        }
                        
                        var1 = int( ceil( var1 / var16 * level.disable_super_in_turret.ref_146bd * level.disable_super_in_turret.ref_146bc ) );
                    }
                    
                    break;
            }
        }
        
        var17 = "scr_br_zxp_scale_" + var13;
        var18 = 0;
        
        if ( var13 == "spread" )
        {
            var18 = 0.7;
        }
        
        var19 = getdvarfloat( var17, var18 );
        
        if ( var19 != 0 )
        {
            var1 = int( ceil( var1 * var19 ) );
        }
        
        var20 = "scr_br_zxp_scale_" + var12;
        var18 = 0;
        
        if ( var12 == "iw8_sh_charlie725" )
        {
            var18 = 1.43;
        }
        
        var21 = getdvarfloat( var20, var18 );
        
        if ( var21 != 0 )
        {
            var1 = int( ceil( var1 * var21 ) );
        }
    }
    
    return var1;
}

// Params 0
// Size: 0x1e, Type: bool
function nukefridgewatcher()
{
    return scripts\common\vehicle::isvehicle() || isdefined( self.classname ) && self.classname == "script_vehicle";
}

// Params 1
// Size: 0x108
function ref_11ca1( var0 )
{
    var1 = var0.damage;
    var2 = var0.victim;
    var3 = isplayer( var0.attacker ) && var0.attacker scripts\mp\gametypes\br_public::ref_125f3();
    var4 = var2.vehiclename;
    
    if ( var3 && var0.meansofdeath == "MOD_MELEE" )
    {
        switch ( var4 )
        {
            case "atv":
                var1 = var2.maxhealth / level.disable_super_in_turret.ref_146cc;
                break;
            case "tac_rover":
            case "jeep":
                var1 = var2.maxhealth / level.disable_super_in_turret.ref_146cd;
                break;
            case "cargo_truck_mg":
            case "cargo_truck":
                var1 = var2.maxhealth / level.disable_super_in_turret.ref_146d1;
                break;
            case "little_bird_mg":
            case "little_bird":
                var1 = var2.maxhealth / level.disable_super_in_turret.ref_146ce;
                break;
            default:
                break;
        }
        
        var1 = int( ceil( var1 ) );
    }
    
    return var1;
}

// Params 2
// Size: 0x41, Type: bool
function ref_11b80( var0, var1 )
{
    if ( !scripts\mp\flags::gameflag( "prematch_done" ) )
    {
        return true;
    }
    
    var2 = playershouldzombiespawn( var0, var1 );
    
    if ( var2 )
    {
        var0.respawningfromtoken = 1;
    }
    else if ( scripts\mp\gametypes\br_public::ref_125f3() )
    {
        thread ref_12538();
    }
    
    return !var2;
}

// Params 1
// Size: 0x32, Type: bool
function ref_1365d( var0 )
{
    if ( istrue( var0.br_infilstarted ) && scripts\mp\flags::gameflag( "prematch_done" ) && var0 scripts\mp\gametypes\br_public::ref_125f3() )
    {
        ref_12645( var0 );
        return true;
    }
    
    return false;
}

// Params 0
// Size: 0x19, Type: bool
function ref_11b16()
{
    if ( !scripts\mp\flags::gameflag( "prematch_done" ) )
    {
        return false;
    }
    
    return !istrue( self.respawningfromtoken );
}

// Params 1
// Size: 0x46, Type: bool
function playershouldzombiespawn( var0 )
{
    if ( !istrue( var0 ) )
    {
        if ( scripts\mp\gametypes\br_public::ref_125f3() )
        {
            return false;
        }
    }
    
    if ( !istrue( self.br_infilstarted ) || !scripts\mp\flags::gameflag( "prematch_done" ) || level.gameended || !level.disable_super_in_turret.ref_146e7 )
    {
        return false;
    }
    
    return true;
}

// Params 1
// Size: 0x53, Type: bool
function ref_126d2( var0 )
{
    if ( !istrue( var0 ) )
    {
        if ( scripts\mp\gametypes\br_public::ref_125f3() )
        {
            thread ref_12538();
            return false;
        }
    }
    
    if ( !istrue( self.br_infilstarted ) || !scripts\mp\flags::gameflag( "prematch_done" ) || level.gameended || !level.disable_super_in_turret.ref_146e7 )
    {
        return false;
    }
    
    thread ref_12723( 0 );
    return true;
}

// Params 2
// Size: 0x74, Type: bool
function ref_125f7( var0, var1 )
{
    if ( !istrue( self.br_infilstarted ) || !scripts\mp\flags::gameflag( "prematch_done" ) )
    {
        return false;
    }
    
    if ( level.gameended )
    {
        return true;
    }
    
    if ( istrue( self.ref_12ca8 ) )
    {
        return true;
    }
    
    if ( istrue( self.respawningfromtoken ) && !scripts\mp\gametypes\br_public::ref_125f3() )
    {
        self.respawningfromtoken = undefined;
        thread ref_12723( 0 );
    }
    else if ( !scripts\mp\utility\damage::playershoulddofauxdeath( 0 ) )
    {
        var0.victim thread scripts\mp\gametypes\br_spectate::spawnspectator( var0, var1 );
    }
    
    return true;
}

// Params 0
// Size: 0x7f
function ref_12538()
{
    self endon( "disconnect" );
    self setscriptablepartstate( "zombie", "off" );
    self setscriptablepartstate( "compassicon", "defaulticon" );
    self setscriptablepartstate( "skydiveVfx", "default", 0 );
    
    if ( level.disable_super_in_turret.ref_1470c )
    {
        ref_125da();
        
        if ( !level.disable_super_in_turret.ref_1470d )
        {
            self setscriptablepartstate( "headVFX", "neutral" );
        }
        
        scripts\mp\utility\player::restorebasevisionset( 0 );
    }
    
    waittillframeend();
    ref_12681( 0, 1 );
    ref_1262b( 0 );
}

// Params 0
// Size: 0x36
function ref_125da()
{
    foreach ( var1 in level.players )
    {
        if ( !var1 scripts\mp\gametypes\br_public::ref_125f3() )
        {
            var1 hudoutlinedisableforclient( self );
        }
    }
}

// Params 2
// Size: 0x133
function ref_12681( var0, var1 )
{
    self.iszombie = var0;
    ref_12682( var0 );
    
    if ( isdefined( level.disable_super_in_turret.ref_11b5b ) )
    {
        scripts\mp\gametypes\br_gametype_zxp::ref_126e6( var0 );
    }
    
    if ( var0 )
    {
        self notify( "zombie_set" );
        
        if ( level.disable_super_in_turret.spawndistancemax )
        {
            ref_12725();
        }
        
        self.ref_11f39 = 0;
        self.bcdisabled = 1;
        self.plunderlimit = 1;
        ref_1267d( 0 );
        scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout( 7 );
        scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout( 9 );
        scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout( 10 );
        scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout( 11 );
        ref_14033( "numVaccine", self.ref_11f39 );
    }
    else
    {
        self notify( "zombie_unset" );
        self.ref_11f39 = undefined;
        self.bcdisabled = undefined;
        self.plunderlimit = undefined;
        scripts\cp\vehicles\little_bird_mg_cp::calloutmarkerping_removecallout( 7 );
        
        if ( isdefined( level.disable_super_in_turret.ref_11b5b ) && !istrue( level.disable_super_in_turret.ö‹°ˆw»Ì≥:Œπ{C∫÷õ7 ) )
        {
            scripts\mp\gametypes\br_gametype_zxp::ref_125ce();
        }
    }
    
    level notify( "players_remaining_changed" );
    scripts\cp_mp\utility\train_utility::br_ammorestock_playerupdatestructures();
    scripts\mp\gametypes\br_comms_tower::ref_126e0();
    
    if ( isdefined( level.ìÕ˘tNÿΩ√SÛy˙3eÿe—IqÚµ0„+…C27 ) )
    {
        self [[ level.ìÕ˘tNÿΩ√SÛy˙3eÿe—IqÚµ0„+…C27 ]]( self.iszombie );
    }
    
    self notify( "stop_battlechatter" );
    
    if ( istrue( var1 ) )
    {
        self lerpfovbypreset( "default" );
        
        if ( level.disable_super_in_turret.ref_1470d )
        {
            thread scripts\mp\supers\super_deadsilence::superdeadsilence_endhudsequence();
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0x111
function init_warning_levels()
{
    var0 = [];
    GscBinSkip0( 0x2e, "loadoutArchetype", "archetype_assault" );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 1
// Size: 0x99
function spawnangle( var0 )
{
    var1 = getarraykeys( level.teamdata );
    
    foreach ( var3 in var1 )
    {
        var4 = level.teamdata[ var3 ][ "players" ];
        
        foreach ( var6 in var4 )
        {
            if ( var6 scripts\mp\gametypes\br_public::ref_125f3() )
            {
                if ( level.disable_super_in_turret.spawndistancemax )
                {
                    ref_12700( var6 );
                }
                
                ref_12631( var6 );
                continue;
            }
            
            ref_12631( var6 );
        }
    }
}

// Params 1
// Size: 0x3f, Type: bool
function vandalize_target_think( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return false;
    }
    
    if ( !isalive( var0 ) && !istrue( var0.respawningfromtoken ) && !var0 scripts\mp\gametypes\br_public::ref_125f3() )
    {
        return false;
    }
    
    return !istrue( var0.delay_enter_combat_after_investigating_grenade ) || var0 scripts\mp\gametypes\br_public::ref_125f3();
}

// Params 1
// Size: 0x30
function get_chopper_minigun_start_node( var0 )
{
    if ( var0.scriptablename == "brloot_zmb_stim" )
    {
        if ( self.ref_11f39 >= level.disable_super_in_turret.ref_146d2 )
        {
            return 12;
        }
        
        return 1;
    }
    
    return undefined;
}

// Params 0
// Size: 0x89
function ref_12725()
{
    var0 = -60;
    var1 = 120;
    var2 = 180;
    self.spawnboardroom_juggdrop = ref_12530( var0, var1, "right", "middle", "center", "middle", &"MP_ZXP/NUM_CONSUMED", 0 );
    self.spawnboardroom_loadoutdrop = ref_12530( var0, var1, "left", "middle", "center", "middle", &"MP_ZXP/NUM_TO_CONSUME", level.disable_super_in_turret.ref_146d2 );
    self.spawndomplateflag = ref_12530( 0, var2, "center", "middle", "center", "middle", &"MP_ZXP/ZOMBIE" );
}

// Params 8
// Size: 0x95
function ref_12530( var0, var1, var2, var3, var4, var5, var6, var7 )
{
    var8 = scripts\mp\hud_util::createfontstring( "default", 1.5 );
    var8.x = var0;
    var8.y = var1;
    var8.alignx = var2;
    var8.aligny = var3;
    var8.horzalign = var4;
    var8.vertalign = var5;
    var8.alpha = 0;
    var8.glowalpha = 0;
    var8.hidewheninmenu = 1;
    var8.archived = 0;
    
    if ( isdefined( var6 ) )
    {
        var8.label = var6;
    }
    
    if ( isdefined( var7 ) )
    {
        var8 setvalue( var7 );
    }
    
    return var8;
}

// Params 1
// Size: 0x28
function ref_12682( var0 )
{
    if ( istrue( var0 ) )
    {
        self.game_extrainfo |= 4096;
        return;
    }
    
    self.game_extrainfo &= ~4096;
}

// Params 2
// Size: 0x3ec
function ref_12723( var0, var1 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "zombie_unset" );
    
    if ( level.gameended )
    {
        return;
    }
    
    if ( !isdefined( level.teamdata[ self.team ][ "lastZombieTime" ] ) && !isdefined( level.ref_12d05 ) )
    {
        scripts\mp\gametypes\br_public::dmztut_luicallback( "zmb_need_someone_alive", self.team );
    }
    
    ref_131cd( self.team );
    ref_1267d( 1 );
    ref_12727( 1 );
    waittillframeend();
    ref_12681( 1 );
    
    if ( istrue( var1 ) )
    {
        scripts\mp\gametypes\br::ref_13f21( self, "outbreak" );
    }
    else
    {
        self.ref_12ca8 = 1;
    }
    
    if ( isdefined( level.ref_12d05 ) )
    {
        ref_12645();
    }
    else if ( var0 )
    {
        ref_126ee();
    }
    else
    {
        ref_12645();
    }
    
    jumpiffalse(scripts\mp\gametypes\br_gametypes::tutorial_showtext( "playerGetZombieSpawnLocation" )) LOC_000000e9;
    var2 = scripts\mp\gametypes\br_gametypes::ref_12e05( "playerGetZombieSpawnLocation" );
    var3 = var2[ 0 ];
    var4 = var2[ 1 ];
    var2 = undefined;
    goto LOC_00000101;
}

// Params 1
// Size: 0x3d
function ref_1264b( var0 )
{
    if ( scripts\mp\gametypes\br_public::ref_125f3() )
    {
        if ( istrue( self.ref_146c0 ) )
        {
            return int( level.disable_super_in_turret.ref_146e5 * var0 );
        }
        else
        {
            return int( level.disable_super_in_turret.ref_146e6 * var0 );
        }
    }
    
    return undefined;
}

// Params 1
// Size: 0x67
function ref_1262b( var0 )
{
    if ( !istrue( level.disable_super_in_turret.¢~{Ë8˙
kˆ-ÇÅ ÿ∑€+<íßµ ) )
    {
        scripts\mp\gametypes\br_public::ref_125cf( var0 );
    }
    
    if ( var0 )
    {
        if ( level.disable_super_in_turret.spawndistancemax )
        {
            self.spawnboardroom_juggdrop.alpha = 1;
            self.spawnboardroom_loadoutdrop.alpha = 1;
            self.spawndomplateflag.alpha = 1;
        }
        
        self disableweaponpickup();
        return;
    }
    
    ref_12700();
    self enableweaponpickup();
}

// Params 1
// Size: 0x15
function ref_131cd( var0 )
{
    level.teamdata[ var0 ][ "lastZombieTime" ] = gettime();
}

// Params 1
// Size: 0xa
function ref_1267d( var0 )
{
    self.tut_popup_listener = var0;
}

// Params 1
// Size: 0x2b
function ref_12727( var0 )
{
    var1 = self.team;
    scripts\mp\utility\teams::ref_140c9( "mode", var1, self );
    ref_126d8();
    
    if ( istrue( var0 ) )
    {
        [[ level.updategameevents ]]();
        return;
    }
}

// Params 0
// Size: 0x58
function ref_12700()
{
    if ( isdefined( self.spawnboardroom_juggdrop ) )
    {
        thread kioskfiresaledoneforplayer( self.spawnboardroom_juggdrop, 1.5 );
    }
    
    if ( isdefined( self.spawnboardroom_loadoutdrop ) )
    {
        thread kioskfiresaledoneforplayer( self.spawnboardroom_loadoutdrop, 1.5 );
    }
    
    if ( isdefined( self.spawndomplateflag ) )
    {
        self.spawndomplateflag destroy();
    }
    
    self.spawnboardroom_juggdrop = undefined;
    self.spawnboardroom_loadoutdrop = undefined;
    self.spawndomplateflag = undefined;
}

// Params 2
// Size: 0x12
function kioskfiresaledoneforplayer( var0, var1 )
{
    wait var1;
    
    if ( isdefined( var0 ) )
    {
        var0 destroy();
        return;
    }
}

// Params 0
// Size: 0x9, Type: bool
function ref_125fa()
{
    return isdefined( self.ref_1472f );
}

// Params 1
// Size: 0x3d
function ref_1264a( var0 )
{
    if ( scripts\mp\gametypes\br_public::ref_125f3() )
    {
        if ( istrue( self.ref_146c0 ) )
        {
            return ( 1 / level.disable_super_in_turret.ref_146e3 * var0 );
        }
        else
        {
            return ( 1 / level.disable_super_in_turret.ref_146e4 * var0 );
        }
    }
    
    return undefined;
}

// Params 1
// Size: 0xb
function onuse( var0 )
{
    thread ref_120a7( var0 );
}

// Params 1
// Size: 0xa3
function ref_120a7( var0 )
{
    if ( !isdefined( var0 ) )
    {
        thread scripts\mp\gametypes\br_gametype_zxp::removelootsyringe( self );
        return;
    }
    
    if ( !playercanusetags( var0 ) )
    {
        return;
    }
    
    if ( istrue( level.gameended ) )
    {
        return;
    }
    
    thread scripts\mp\gametypes\br_gametype_zxp::removelootsyringe( self, undefined, var0 );
    
    if ( var0.ref_11f39 >= level.disable_super_in_turret.ref_146d2 )
    {
        return;
    }
    
    var0.ref_11f39++;
    
    if ( level.disable_super_in_turret.spawndistancemax )
    {
        ref_125d4( var0 );
    }
    
    ref_14033( var0, "numVaccine", var0.ref_11f39 );
    
    if ( isdefined( level.disable_super_in_turret.ref_11b5b ) && var0.ref_11f39 >= level.disable_super_in_turret.ref_146d2 )
    {
        var0 thread scripts\mp\gametypes\br_gametype_zxp::ref_126fa();
        return;
    }
}

// Params 1
// Size: 0xb
function playercanusetags( var0 )
{
    return var0 scripts\mp\gametypes\br_public::ref_125f3();
}

// Params 0
// Size: 0x37
function ref_125d4()
{
    var0 = ( 0, 1, 0 );
    self.spawnboardroom_juggdrop setvalue( self.ref_11f39 );
    thread spawn_vindia_assault3( self.spawnboardroom_juggdrop );
    thread spawn_vindia_assault3( self.spawnboardroom_loadoutdrop );
}

// Params 1
// Size: 0x68
function spawn_vindia_assault3( var0 )
{
    self endon( "death" );
    
    if ( istrue( self.ref_1293b ) )
    {
        return;
    }
    
    var1 = 0.5;
    var2 = 4;
    self.ref_1293b = 1;
    var3 = self.fontscale;
    var4 = self.color;
    
    if ( isdefined( var0 ) )
    {
        self.color = var0;
    }
    
    self changefontscaleovertime( var1 );
    self.fontscale = var2;
    wait var1;
    self changefontscaleovertime( var1 );
    self.fontscale = var3;
    wait var1;
    self.color = var4;
    self.ref_1293b = undefined;
}

// Params 0
// Size: 0x20d
function ref_125fc()
{
    var0 = spawnstruct();
    var0.current = self getcurrentprimaryweapon();
    var0.ref_12889 = [];
    var0.brtdm_config = [];
    var0.brtruck_cleanupents = [];
    var0.brtruck_ontimelimit = [];
    var0.offhands = [];
    var0.nvidiaansel_overridecollisionradius = [];
    var1 = [];
    var2 = self getweaponslistprimaries();
    
    foreach ( var4 in var2 )
    {
        if ( !scripts\mp\utility\weapon::update_health_bar_to_player( var4 ) && !issubstr( var4.basename, "iw8_fists_mp" ) && !scripts\mp\utility\weapon::unset_relic_mythic( var4.basename ) )
        {
            var1 = var4;
        }
    }
    
    foreach ( var7 in var1 )
    {
        var8 = createheadicon( var7 );
        var0.brtdm_config[ var8 ] = weaponclipsize( var7 );
        var0.brtruck_ontimelimit[ var8 ] = self getweaponammostock( var7 );
        
        if ( scripts\mp\utility\weapon::turnexfiltoside( var7 ) )
        {
            var0.brtruck_cleanupents[ var8 ] = self getweaponammoclip( var7, "left" );
        }
        
        if ( getsubstr( var8, 0, 4 ) == "alt_" )
        {
            continue;
        }
        
        var0.ref_12889[ var0.ref_12889.size ] = var7;
    }
    
    var10 = self getweaponslistoffhands();
    
    foreach ( var12 in var10 )
    {
        if ( var12.basename == "bandage_br" )
        {
            continue;
        }
        
        var13 = self getweaponammoclip( var12 );
        
        if ( var13 <= 0 )
        {
            continue;
        }
        
        var0.offhands[ var0.offhands.size ] = var12;
        var14 = createheadicon( var12 );
        var0.brtdm_config[ var14 ] = var13;
    }
    
    foreach ( var17 in self.equipment )
    {
        var0.nvidiaansel_overridecollisionradius[ var17 ] = var18;
    }
    
    var0.super = undefined;
    
    if ( isdefined( self.super ) && !self.super.usepercent )
    {
        var0.super = self.equipment[ "super" ];
    }
    
    self.ref_1472f = var0;
}

// Params 0
// Size: 0x12
function ref_126ee()
{
    if ( scripts\mp\gametypes\br_public::ref_125f3() )
    {
        self waittill( "spawnZombie" );
        return;
    }
}

// Params 0
// Size: 0x25
function ref_12645()
{
    self notify( "spawnZombie" );
    self method_87aa( "zombie" );
    self setclothtype( "cloth" );
    scripts\mp\deathicons::spawn_carriables_from_prefabs_all( self );
}

// Params 3
// Size: 0x2f
function run_track_enemy_patrollers( var0, var1, var2 )
{
    var3 = var0 + var1 * var2;
    
    if ( scripts\mp\gametypes\br_c130::ispointinbounds( var3, 1 ) )
    {
        var4 = vectortoangles( var1 * -1 );
        return [ var3, var4 ];
    }
    
    return [ undefined, undefined ];
}

// Params 0
// Size: 0x6c
function ref_1270e()
{
    var0 = undefined;
    var1 = undefined;
    var2 = getdvarfloat( "scr_br_zxp_respawnTeamOffset", 10000 );
    
    if ( var2 >= 0 )
    {
        var3 = scripts\mp\gametypes\br_gulag::ref_12568( 0 );
        
        if ( isdefined( var3 ) )
        {
            var0 = rocket_fuel_stability( var3.origin, var2 );
            
            if ( istrue( level.∫eÌ.9+÷eË*C(≠çÉròMrKAüWí  ) && isscriptabledefined() )
            {
                var0 = getclosestpointonnavmesh( var0 );
            }
            
            var0 = scripts\mp\gametypes\br_public::modifyplayer_damage( var0 );
            var1 = scripts\mp\gametypes\br_gulag::registercarryobjectpickupcheck( var0, var3.origin );
        }
    }
    
    return [ var0, var1 ];
}

// Params 2
// Size: 0xf3
function rocket_fuel_stability( var0, var1 )
{
    var2 = 3.14159;
    var3 = scripts\mp\gametypes\br_circle::getsafecircleorigin();
    var4 = vectornormalize( var0 - var3 );
    var5 = vectortoangles( var4 );
    var6 = randomfloatrange( getdvarfloat( "scr_br_respawn_rand_ang_min", 10 ), getdvarfloat( "scr_br_respawn_rand_ang_max", 60 ) );
    var7 = var4;
    var8 = var0 + var7 * var1;
    
    if ( scripts\mp\gametypes\br_c130::ispointinbounds( var8, 0 ) )
    {
        return var8;
    }
    
    var7 *= -1;
    var8 = var0 + var7 * var1;
    
    if ( scripts\mp\gametypes\br_c130::ispointinbounds( var8, 0 ) )
    {
        return var8;
    }
    
    var7 = vectornormalize( var3 - var0 );
    var8 = var0 + var7 * var1;
    
    if ( scripts\mp\gametypes\br_c130::ispointinbounds( var8, 0 ) )
    {
        return var8;
    }
    
    var9 = var1;
    var10 = distance2d( var0, var3 );
    var11 = var9 / var10;
    
    if ( var11 > var2 )
    {
        var11 = var2;
    }
    
    var12 = var11 * 180 / var2;
    var8 = rotatepointaroundvector( ( 0, 0, 1 ), var0 - var3, var12 ) + var3;
    
    if ( scripts\mp\gametypes\br_c130::ispointinbounds( var8, 0 ) )
    {
        return var8;
    }
    
    var8 = scripts\mp\gametypes\br_circle::getrandompointincircle( var0, var1 );
    
    if ( scripts\mp\gametypes\br_c130::ispointinbounds( var8, 0 ) )
    {
        return var8;
    }
    
    return undefined;
}

// Params 0
// Size: 0x1ac
function ref_12582()
{
    var0 = 50;
    var1 = 10000;
    var2 = ref_1270e();
    var3 = var2[ 0 ];
    var4 = var2[ 1 ];
    var2 = undefined;
    
    if ( isdefined( var3 ) )
    {
        var3 = checkspawnwithinmapradius( var3 );
        return [ var3, var4 ];
    }
    
    if ( !isdefined( level.br_circle ) || !isdefined( level.br_circle.dangercircleent ) || istrue( level.disable_super_in_turret.ref_146fb ) )
    {
        return [ self.origin, self getplayerangles() ];
    }
    
    var5 = scripts\mp\gametypes\br_circle::getdangercircleradius();
    var6 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
    var7 = var5 + var0;
    var8 = ( self.origin[ 0 ], self.origin[ 1 ], 0 );
    var9 = vectornormalize( var8 - var6 );
    var10 = run_track_enemy_patrollers( var6, var9, var7 );
    var11 = var10[ 0 ];
    var4 = var10[ 1 ];
    var10 = undefined;
    
    if ( !isdefined( var11 ) )
    {
        var9 *= -1;
        var12 = run_track_enemy_patrollers( var6, var9, var7 );
        var11 = var12[ 0 ];
        var4 = var12[ 1 ];
        var12 = undefined;
    }
    
    if ( !isdefined( var11 ) )
    {
        var9 = ( 1, 0, 0 );
        var13 = run_track_enemy_patrollers( var6, var9, var7 );
        var11 = var13[ 0 ];
        var4 = var13[ 1 ];
        var13 = undefined;
    }
    
    if ( !isdefined( var11 ) )
    {
        var9 = ( -1, 0, 0 );
        var14 = run_track_enemy_patrollers( var6, var9, var7 );
        var11 = var14[ 0 ];
        var4 = var14[ 1 ];
        var14 = undefined;
    }
    
    if ( !isdefined( var11 ) )
    {
        var9 = ( 0, 1, 0 );
        var15 = run_track_enemy_patrollers( var6, var9, var7 );
        var11 = var15[ 0 ];
        var4 = var15[ 1 ];
        var15 = undefined;
    }
    
    if ( !isdefined( var11 ) )
    {
        var9 = ( 0, -1, 0 );
        var16 = run_track_enemy_patrollers( var6, var9, var7 );
        var11 = var16[ 0 ];
        var4 = var16[ 1 ];
        var16 = undefined;
    }
    
    if ( !isdefined( var11 ) )
    {
        var11 = self.origin;
        var4 = self.angles;
    }
    
    var3 = scripts\mp\gametypes\br_public::modifyplayer_damage( var11, var1 );
    var3 = checkspawnwithinmapradius( var3 );
    return [ var3, var4 ];
}

// Params 2
// Size: 0x78
function ref_12722( var0, var1 )
{
    var2 = var0;
    
    if ( level.disable_super_in_turret.ref_146fc )
    {
        var3 = getdvarint( "scr_br_zxp_respawnZombieHeight", 10000 );
        var4 = ( 0, 0, var3 );
        var0 = scripts\mp\gametypes\br::getoffsetspawnorigin( var0, var4 );
        var5 = spawnstruct();
        var5.origin = var0;
        var5.angles = var1;
        var5.height = var3;
        var2 = scripts\mp\gametypes\br_gulag::ref_1263e( var5 );
    }
    else
    {
        self calloutmarkerping_getinventoryslot( 0 );
        scripts\mp\gametypes\br_public::ref_126b9( var2 );
    }
    
    return [ var0, var2 ];
}

// Params 3
// Size: 0xdd
function ref_126bd( var0, var1, var2 )
{
    scripts\mp\gametypes\br_gulag::ref_126c3( var2, var1 );
    var3 = spawn( "script_model", var2 );
    var3 setmodel( "tag_origin" );
    var3.angles = var1;
    var3 hide();
    var3 showtoplayer( self );
    self playerlinktoabsolute( var3, "tag_origin" );
    self playerhide();
    thread scripts\mp\gametypes\br_gulag::ref_12524( var3 );
    waitframe();
    scripts\mp\gametypes\br_public::ref_126ed();
    scripts\mp\gametypes\br_public::ref_1252b();
    var3.origin = var0;
    waitframe();
    self unlink();
    self clearsoundsubmix( "deaths_door_mp" );
    self clearsoundsubmix( "fade_to_black_all_except_music_and_scripted5", 2 );
    self clearclienttriggeraudiozone( 1 );
    self playershow();
    var4 = 0;
    
    if ( isdefined( level.ref_121cc ) )
    {
        var4 = level.ref_121cc;
    }
    
    thread scripts\cp_mp\parachute::startfreefall( var4, 0, undefined, undefined, 1 );
    self setclientomnvar( "ui_br_transition_type", 0 );
    self setclientomnvar( "ui_show_spectateHud", -1 );
    scripts\mp\gametypes\br_gulag::ref_12c7a();
    wait 0.5;
    scripts\mp\gametypes\br_gulag::gulagfadefromblack();
    waitframe();
    var3 delete();
    self notify( "can_show_splashes" );
}

// Params 0
// Size: 0x9b
function ref_126ff()
{
    self endon( "death_or_disconnect" );
    self endon( "zombie_unset" );
    
    if ( level.disable_super_in_turret.ref_1470c )
    {
        self hudoutlinedisable();
        
        if ( !level.disable_super_in_turret.ref_1470d )
        {
            self setscriptablepartstate( "headVFX", "zombieVision" );
        }
        
        if ( scripts\cp_mp\utility\game_utility::turretdisabled() )
        {
            self visionsetnakedforplayer( "mp_escape4_wz_zmb", 0 );
            thread playerzombieambienceoverride();
        }
        else
        {
            self visionsetnakedforplayer( "mp_don3_wz_zmb", 0 );
        }
        
        ref_12713();
    }
    
    waitframe();
    
    if ( getdvarint( "scr_br_zxp_loop_zombie_fx", 1 ) )
    {
        self setscriptablepartstate( "zombie", "on_loop" );
        return;
    }
    
    self setscriptablepartstate( "zombie", "on" );
}

// Params 0
// Size: 0x2f
function playerzombieambienceoverride()
{
    self endon( "disconnect" );
    self setclienttriggeraudiozonepartial( "player_is_zombie", "ambient" );
    scripts\engine\utility::ref_143a5( "zombie_unset", "death" );
    self clearclienttriggeraudiozone( 1 );
}

// Params 0
// Size: 0x8b
function ref_12713()
{
    var0 = scripts\mp\utility\teams::getfriendlyplayers( self.team, 1 );
    var1 = scripts\mp\utility\teams::getenemyplayers( self.team, 1 );
    
    foreach ( var3 in var0 )
    {
        scripts\mp\utility\outline::outlineenableforplayer( var3, self, "outline_depth_zombievision_friendly", "top" );
    }
    
    foreach ( var3 in var1 )
    {
        if ( !var3 scripts\mp\gametypes\br_public::ref_125f3() )
        {
            scripts\mp\utility\outline::outlineenableforplayer( var3, self, "outline_depth_zombievision_enemy", "top" );
        }
    }
}

// Params 0
// Size: 0xa0
function playerhumanhudoutlineenable()
{
    var0 = scripts\mp\utility\teams::getfriendlyplayers( self.team, 1 );
    var1 = scripts\mp\utility\teams::getenemyplayers( self.team, 1 );
    
    foreach ( var3 in var0 )
    {
        if ( isdefined( var3 ) && var3 scripts\mp\gametypes\br_public::ref_125f3() )
        {
            scripts\mp\utility\outline::outlineenableforplayer( self, var3, "outline_depth_zombievision_friendly", "top" );
        }
    }
    
    foreach ( var3 in var1 )
    {
        if ( isdefined( var3 ) && var3 scripts\mp\gametypes\br_public::ref_125f3() )
        {
            scripts\mp\utility\outline::outlineenableforplayer( self, var3, "outline_depth_zombievision_enemy", "top" );
        }
    }
}

// Params 0
// Size: 0x6a
function ref_1270d()
{
    level endon( "game_ended" );
    self endon( "zombie_unset" );
    self endon( "disconnect" );
    self.ref_146c0 = undefined;
    
    for ( ;; )
    {
        if ( ref_12714() )
        {
            if ( !isdefined( self.ref_146c0 ) || !self.ref_146c0 )
            {
                self.ref_146c0 = 1;
                ref_12705();
            }
        }
        else if ( !isdefined( self.ref_146c0 ) || self.ref_146c0 )
        {
            self.ref_146c0 = 0;
            ref_12706();
        }
        
        waitframe();
    }
}

// Params 0
// Size: 0x16
function ref_12705()
{
    self notify( "zombie_enter_gas" );
    self unsetperk( "specialty_radarblip", 1 );
}

// Params 0
// Size: 0x3f
function ref_12706()
{
    self notify( "zombie_exit_gas" );
    
    if ( level.disable_super_in_turret.ref_146d5 >= 0 )
    {
        if ( level.disable_super_in_turret.ref_146d5 == 0 )
        {
            self setperk( "specialty_radarblip", 1 );
            return;
        }
        
        thread ref_1271f();
        return;
    }
}

// Params 0
// Size: 0x62
function ref_1271f()
{
    if ( level.disable_super_in_turret.ref_146d5 <= 0 )
    {
        return;
    }
    
    self endon( "zombie_unset" );
    self endon( "zombie_enter_gas" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    
    for ( ;; )
    {
        self setperk( "specialty_radarblip", 1 );
        wait level.disable_super_in_turret.ref_146d6;
        self unsetperk( "specialty_radarblip", 1 );
        wait level.disable_super_in_turret.ref_146d5;
    }
}

// Params 0
// Size: 0x38, Type: bool
function ref_12714()
{
    if ( !isdefined( level.br_circle ) || !isdefined( level.br_circle.dangercircleent ) )
    {
        return false;
    }
    
    var0 = scripts\mp\gametypes\br_circle::getdangercircleorigin();
    var1 = scripts\mp\gametypes\br_circle::getdangercircleradius();
    return distance2dsquared( var0, self.origin ) > var1 * var1;
}

// Params 0
// Size: 0x35
function ref_12724()
{
    self endon( "disconnect" );
    self.ref_133e9 = 1;
    self.radarmode = "normal_radar";
    self.hasradar = 1;
    self waittill( "zombie_unset" );
    self.ref_133e9 = undefined;
    self.hasradar = 0;
}

// Params 0
// Size: 0x27
function ref_1272a()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "zombie_unset" );
    
    for ( ;; )
    {
        if ( self issupersprinting() )
        {
            self refreshsprinttime();
        }
        
        waitframe();
    }
}

// Params 2
// Size: 0x1fa
function ref_12710( var0, var1 )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "zombie_unset" );
    
    if ( istrue( self.óe≥øÄÁ1)7 ∏y*?Õ”zè ) )
    {
        self setscriptablepartstate( "skydiveVfx", "enabled_zombie", 0 );
    }
    
    wait 1;
    
    while ( !self isonground() )
    {
        ref_125b8( var0 );
        waitframe();
    }
    
    self setclientomnvar( "ui_br_altimeter_state", 0 );
    self skydive_interrupt();
    playfx( level._effect[ "zombie_splat" ], self.origin );
    self playsoundtoplayer( "zxp_spawn_splat_plr", self, self );
    self playsound( "zxp_spawn_splat_npc", self, self );
    self freezecontrols( 1 );
    var2 = gettime() + 2000;
    
    while ( self getcurrentprimaryweapon().classname == "none" && gettime() < var2 )
    {
        ref_125b8( var0 );
        waitframe();
    }
    
    var3 = propwaitminigameinit( self, 0 );
    
    if ( !isdefined( var3 ) )
    {
        var3 = ( 0, 0, 1 );
    }
    
    var4 = anglestoforward( self.angles );
    var5 = vectortoangles( var3 );
    var6 = angleclamp180( var5[ 0 ] + 90 );
    var5 = ( 0, var5[ 1 ], 0 );
    var7 = anglestoforward( var5 );
    var8 = vectordot( var7, var4 );
    var9 = var8 * var6;
    var10 = getdvarint( "scr_br_zxp_zombie_splat_down_clamp", 20 );
    var11 = getdvarint( "scr_br_zxp_zombie_splat_up_clamp", -70 );
    
    if ( var9 > 0 )
    {
        var9 = min( var10, var9 );
    }
    else
    {
        var9 = max( var11, var9 );
    }
    
    self setplayerangles( ( var9, self.angles[ 1 ], 0 ) );
    
    if ( self getcurrentprimaryweapon().classname != "none" )
    {
        self forceplaygestureviewmodel( "ges_zombie_splat" );
    }
    
    wait 1;
    self skydive_setbasejumpingstatus( 0 );
    self skydive_setdeploymentstatus( 0 );
    wait 0.5;
    self freezecontrols( 0 );
    self freezelookcontrols( 1 );
    self allowsprint( 0 );
    thread ref_12720();
    ref_125b8( var0 );
    
    if ( istrue( self.óe≥øÄÁ1)7 ∏y*?Õ”zè ) )
    {
        self.óe≥øÄÁ1)7 ∏y*?Õ”zè = undefined;
        self setscriptablepartstate( "skydiveVfx", "default", 0 );
    }
    
    if ( istrue( var1 ) )
    {
        wait 0.5;
    }
    else
    {
        wait 1;
    }
    
    self freezelookcontrols( 0 );
    
    if ( istrue( var1 ) )
    {
        wait 0.5;
    }
    else
    {
        wait 1;
    }
    
    self allowsprint( 1 );
}

// Params 1
// Size: 0x32
function ref_125b8( var0 )
{
    if ( !self hasweapon( var0 ) )
    {
        scripts\cp_mp\utility\inventory_utility::_giveweapon( var0, undefined, undefined, 1 );
    }
    
    if ( self getcurrentprimaryweapon().classname == "none" )
    {
        thread scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate( var0 );
        return;
    }
}

// Params 1
// Size: 0x62
function ref_11ecd( var0 )
{
    foreach ( var2 in level.players )
    {
        if ( !isalive( var2 ) )
        {
            continue;
        }
        
        if ( scripts\engine\utility::array_contains( var0, var2.team ) )
        {
            var2 scripts\mp\hud_message::showsplash( "br_gametype_zxp_jugg_team" );
            continue;
        }
        
        var2 scripts\mp\hud_message::showsplash( "br_gametype_zxp_jugg_other" );
    }
}

// Params 1
// Size: 0x92
function clear_tier_lights_all( var0 )
{
    ref_11ecd( var0 );
    
    foreach ( var2 in var0 )
    {
        var3 = level.teamdata[ var2 ][ "alivePlayers" ];
        
        foreach ( var5 in var3 )
        {
            if ( isalive( var5 ) && !var5 scripts\mp\gametypes\br_public::ref_125f3() )
            {
                if ( level.disable_super_in_turret.spawndomplateflagtestmap )
                {
                    ref_125fc( var5 );
                }
                
                ref_1250e( var5 );
            }
        }
    }
}

// Params 0
// Size: 0xd3
function ref_1250e()
{
    if ( istrue( self.inlaststand ) )
    {
        scripts\mp\laststand::playanim_aibegindismountturret( "self_revive_success", self );
    }
    
    scripts\cp_mp\killstreaks\juggernaut::tryusejuggernaut( 1 );
    
    if ( level.disable_super_in_turret.vehicle_occupancy_friendlystatuschangedcallback > 0 && level.disable_super_in_turret.vehicle_occupancy_getreserving )
    {
        objective_icon( self.juggcontext.juggobjid, "icon_waypoint_jugg" );
        objective_state( self.juggcontext.juggobjid, "current" );
        objective_setzoffset( self.juggcontext.juggobjid, 70 );
        objective_setprogress( self.juggcontext.juggobjid, 0.99 );
        objective_setshowprogress( self.juggcontext.juggobjid, 1 );
        objective_setprogressteam( self.juggcontext.juggobjid, self.team );
        objective_setbackground( self.juggcontext.juggobjid, 1 );
        function_0421( self.juggcontext.juggobjid, 1 );
        return;
    }
}

// Params 1
// Size: 0x14e
function onplayerdamaged( var0 )
{
    if ( level.disable_super_in_turret.vehicle_occupancy_friendlystatuschangedcallback > 0 && level.disable_super_in_turret.vehicle_occupancy_getreserving && istrue( var0.victim.isjuggernaut ) )
    {
        var1 = var0.victim.health / var0.victim.maxhealth;
        objective_setprogress( var0.victim.juggcontext.juggobjid, var1 );
        
        if ( isdefined( var0.attacker ) )
        {
            thread ref_12612( var0.attacker, var0.victim.juggcontext.juggobjid );
        }
    }
    
    var2 = isdefined( var0.attacker ) && isdefined( var0.attacker.ref_12369 );
    var3 = var0.victim getentitynumber();
    var4 = var2 && isdefined( var0.attacker.ref_12369.ref_13a72 ) && isdefined( var0.attacker.ref_12369.ref_13a72[ var3 ] ) && var0.attacker.ref_12369.ref_13a72[ var3 ] == var0.victim;
    
    if ( var0.victim scripts\mp\gametypes\br_public::ref_125f3() && var4 )
    {
        thread removepingondamageheadicon( var0.attacker, var0.victim );
        return;
    }
}

// Params 2
// Size: 0x41
function removepingondamageheadicon( var0, var1 )
{
    level endon( "game_ended" );
    var0 endon( "disconnect" );
    var2 = var0 getentitynumber();
    var0 endon( "removeHeadIcon_" + var2 );
    var3 = "removePingOnDamageHeadIcon_" + var2;
    self notify( var3 );
    self endon( var3 );
    var0 waittill( "zombie_unset" );
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon( var1 );
}

// Params 2
// Size: 0x35
function ref_12612( var0, var1 )
{
    self endon( "disconnect" );
    self notify( "playerPinObjective" );
    self endon( "playerPinObjective" );
    objective_pinforclient( var0, self );
    var1 scripts\engine\utility::waittill_notify_or_timeout( "death", 1 );
    objective_unpinforclient( var0, self );
}

// Params 0
// Size: 0x14f
function ref_13283()
{
    if ( !level.disable_super_in_turret.ref_146e2 )
    {
        return;
    }
    
    level.disable_super_in_turret.ref_14693 = spawnstruct();
    level.disable_super_in_turret.ref_14693.powers = [];
    battlepassxpmultipliers( level.disable_super_in_turret.ref_14693, "jump", [ "+speed_throw", "+toggleads_throw", "+ads_akimbo_accessible" ], &ref_12716, 0, undefined, &ref_12718, undefined, &"MP_ZXP/CHARGED_JUMP", undefined, 6, "jumpStatus", "jumpProgress" );
    battlepassxpmultipliers( level.disable_super_in_turret.ref_14693, "jumpStop", [ "-speed_throw", "-toggleads_throw", "-ads_akimbo_accessible" ], &ref_1271b, 0 );
    battlepassxpmultipliers( level.disable_super_in_turret.ref_14693, "gas", "+smoke", &ref_12707, 0, &ref_1270a, &ref_12708, &ref_12709, &"MP_ZXP/GAS_GRENADE", undefined, 15, "gasGrenadeStatus", "gasGrenadeProgress" );
    battlepassxpmultipliers( level.disable_super_in_turret.ref_14693, "emp", "+frag", &ref_12703, 0, undefined, undefined, undefined, &"MP_ZXP/EMP", undefined, 15, "empStatus", "empProgress" );
    
    if ( getdvarint( "scr_br_zxp_bumper_ping_support", 1 ) )
    {
        battlepassxpmultipliers( level.disable_super_in_turret.ref_14693, "gas_or_emp", [ "+equip_toggle_throw" ], &ref_1270b, 0, undefined, &ref_1270c );
        return;
    }
}

// Params 13
// Size: 0x10e
function battlepassxpmultipliers( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12 )
{
    var13 = "scr_br_zxp_power_" + var1;
    
    if ( getdvarint( var13, 1 ) == 0 )
    {
        return;
    }
    
    if ( isstring( var2 ) )
    {
        var2 = [ var2 ];
    }
    
    var0.powers[ var1 ] = spawnstruct();
    var0.powers[ var1 ].clients_hacked = var2;
    var0.powers[ var1 ].func = var3;
    var0.powers[ var1 ].ref_1387b = var5;
    var0.powers[ var1 ].has_ammo_drain_passive = var6;
    var0.powers[ var1 ].ref_127fc = var7;
    var0.powers[ var1 ].label = var8;
    var0.powers[ var1 ].waitforstreamsynccomplete = var9;
    var0.powers[ var1 ].idmask = var10;
    var0.powers[ var1 ].ref_1388f = var11;
    var0.powers[ var1 ].ref_128be = var12;
    var0.powers[ var1 ].ref_13060 = var4;
}

// Params 2
// Size: 0x6c
function ref_1270b( var0, var1 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self notify( "playerZombieGasOrEMP" );
    self endon( "playerZombieGasOrEMP" );
    var2 = gettime() + getdvarint( "scr_br_zxp_gas_or_emp_timeout_ms", 500 );
    
    while ( var2 > gettime() )
    {
        if ( self secondaryoffhandbuttonpressed() )
        {
            self notify( "gas" );
            break;
        }
        else if ( self fragbuttonpressed() )
        {
            self notify( "emp" );
            break;
        }
        
        waitframe();
    }
}

// Params 2
// Size: 0x238
function ref_12703( var0, var1 )
{
    var2 = 60;
    var3 = 1;
    var4 = 64;
    var5 = var4 * var4;
    var6 = 768;
    var7 = var6 * var6;
    var8 = "zxp_emp_fire_plr";
    var9 = self;
    var9 enableplayerbreathsystem( 0 );
    var9 playsoundonmovingent( var8 );
    var9 playsoundtoplayer( "zmb_effort_empblast", self, self );
    var9 playsound( "zmb_npc_effort_empblast", var9, var9 );
    thread ref_14697( var9 );
    var10 = anglestoforward( var9.angles );
    playfx( level.disable_super_in_turret.empvfx, var9.origin, var10 );
    var11 = getcompleteweaponname( "emp_drone_non_player_mp" );
    var12 = getcompleteweaponname( "emp_drone_non_player_direct_mp" );
    var13 = scripts\cp_mp\emp_debuff::get_emp_ents();
    
    foreach ( var15 in var13 )
    {
        var16 = var15.owner;
        jumpiffalse(isdefined( var16 )) LOC_000000d6;
        var17 = distancesquared( var9.origin, var15.origin );
        
        if ( var17 > var7 )
        {
            continue;
        }
        
        var18 = scripts\engine\utility::ter_op( var17 > var5, var11, var12 );
        var15 dodamage( 1, var9.origin, var9, var9, "MOD_EXPLOSIVE", var18 );
        var15 playsoundonmovingent( "zxp_emp_impact_ent" );
        var19 = scripts\cp_mp\utility\damage_utility::packdamagedata( var9, var15, 1, var18, "MOD_EXPLOSIVE", var9, var9.origin );
        thread ref_126f9( var19 );
    LOC_00000149:
    }
    
    var21 = getcompleteweaponname( "emp_drone_player_mp" );
    var22 = undefined;
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "player", "getPlayersInRadius" ) )
    {
        var22 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "player", "getPlayersInRadius" ) ]]( var9.origin, var6 );
    }
    
    foreach ( var24 in var22 )
    {
        if ( var24 scripts\mp\gametypes\br_public::ref_125f3() )
        {
            continue;
        }
        
        if ( !var24 scripts\cp_mp\emp_debuff::can_emp_player() )
        {
            continue;
        }
        
        if ( var24 != var9 && !scripts\cp_mp\utility\player_utility::playersareenemies( var9, var24 ) )
        {
            continue;
        }
        
        var24 dodamage( 1, var9.origin, var9, var9, "MOD_EXPLOSIVE", var21 );
        var19 = scripts\cp_mp\utility\damage_utility::packdamagedata( var9, var24, 1, var21, "MOD_EXPLOSIVE", var9, var9.origin );
        thread ref_126f9( var19 );
    LOC_00000221:
    }
    
    thread ref_1262c( var0, var1 );
}

// Params 1
// Size: 0x12
function ref_14697( var0 )
{
    if ( isdefined( var0 ) )
    {
        wait var0;
    }
    
    self enableplayerbreathsystem( 1 );
}

// Params 2
// Size: 0x4c
function ref_1262c( var0, var1 )
{
    if ( level.disable_super_in_turret.spawndistancemax )
    {
        self.ref_12821[ var1 ].choppergunner_refillmissiles scripts\mp\hud_util::updatebar( 1, 0 );
    }
    else
    {
        self.ref_12821[ var1 ].frac = 1;
    }
    
    thread ref_12639( var0, var1 );
}

// Params 2
// Size: 0xd
function ref_1270c( var0, var1 )
{
    self notify( "playerZombieGasOrEMP" );
}

// Params 0
// Size: 0x22
function ref_12720()
{
    if ( !level.disable_super_in_turret.ref_146e2 )
    {
        return;
    }
    
    thread ref_126b4( level.disable_super_in_turret.ref_14693 );
}

// Params 1
// Size: 0x8c
function ref_126b4( var0 )
{
    thread ref_12637( var0 );
    thread ref_12634( var0 );
    thread ref_12635( var0 );
    
    if ( level.disable_super_in_turret.spawndistancemax )
    {
        thread ref_1263a( var0 );
    }
    
    thread ref_12638( var0 );
    thread ref_12630( var0 );
    
    foreach ( var2 in var0.powers )
    {
        if ( isdefined( var0.powers[ var3 ].ref_1388f ) )
        {
            ref_14033( var0.powers[ var3 ].ref_1388f, 2 );
        }
    }
}

// Params 1
// Size: 0xdc
function ref_126f9( var0 )
{
    var1 = 5;
    var2 = 2;
    scripts\cp_mp\emp_debuff::apply_emp_struct( var0 );
    var3 = var1;
    
    if ( isplayer( var0.victim ) )
    {
        var0.victim.unmark_on_death = 1;
        var0.victim playsound( "zxp_emp_impact_plr" );
        
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "perk", "hasPerk" ) )
        {
            if ( var0.victim != self && var0.victim [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "perk", "hasPerk" ) ]]( "specialty_emp_resist" ) )
            {
                var3 = var2;
                
                if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "damage", "updateDamageFeedback" ) )
                {
                    self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "damage", "updateDamageFeedback" ) ]]( "hittacresist" );
                }
            }
        }
    }
    
    moraleslaptopthink( var0, var3 );
    
    if ( isdefined( var0.victim ) )
    {
        var0.victim.unmark_on_death = undefined;
        var0.victim scripts\cp_mp\emp_debuff::remove_emp();
        return;
    }
}

// Params 2
// Size: 0x22
function ref_1270a( var0, var1 )
{
    scripts\mp\equipment::giveequipment( "equip_gas_grenade", "secondary" );
    scripts\mp\equipment::setequipmentslotammo( "secondary", 1 );
}

// Params 2
// Size: 0x57
function ref_12707( var0, var1 )
{
    level endon( "game_ended" );
    self endon( "offhand_end" );
    self endon( "zombie_unset" );
    self endon( "death_or_disconnect" );
    self waittill( "grenade_fire", var2, var3, var4, var5 );
    
    if ( !scripts\mp\utility\weapon::grenadethrown( var2 ) )
    {
        return;
    }
    
    self playsound( "zxp_grenade_vo_npc", self, self );
    thread ref_1262c( var0, var1 );
}

// Params 2
// Size: 0x12
function ref_12709( var0, var1 )
{
    scripts\mp\equipment::setequipmentslotammo( "secondary", 1 );
}

// Params 2
// Size: 0x10
function ref_12708( var0, var1 )
{
    scripts\mp\equipment::takeequipment( "secondary" );
}

// Params 2
// Size: 0x3b
function moraleslaptopthink( var0, var1 )
{
    var0.victim endon( "death_or_disconnect" );
    level endon( "game_ended" );
    var2 = scripts\engine\utility::waittill_notify_or_timeout_return( "emp_cleared", var1 );
    
    if ( var2 != "emp_cleared" )
    {
        var0.empremoved = 1;
        return;
    }
}

// Params 1
// Size: 0x43
function ref_12630( var0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    scripts\engine\utility::ref_143a6( "death", "zombie_unset", "zombie_set" );
    thread ref_1262d( var0 );
    thread ref_12632( var0 );
    thread ref_12633( var0 );
    thread ref_12631( var0 );
}

// Params 1
// Size: 0x66
function ref_12637( var0 )
{
    if ( isbot( self ) )
    {
        return;
    }
    
    foreach ( var2 in var0.powers )
    {
        foreach ( var4 in var2.clients_hacked )
        {
            self notifyonplayercommand( var6, var4 );
        }
    }
}

// Params 1
// Size: 0x6b
function ref_12631( var0 )
{
    if ( !isdefined( self.ref_12821 ) )
    {
        return;
    }
    
    if ( level.disable_super_in_turret.spawndistancemax )
    {
        foreach ( var2 in self.ref_12821 )
        {
            if ( isdefined( var2 ) )
            {
                if ( isdefined( var2.choppergunner_refillmissiles ) )
                {
                    var2.choppergunner_refillmissiles scripts\mp\hud_util::destroyelem();
                }
                
                var2 destroy();
            }
        }
    }
    
    self.ref_12821 = undefined;
}

// Params 1
// Size: 0xaa
function ref_12634( var0 )
{
    var1 = 200;
    var2 = 18;
    var3 = var1;
    self.ref_12821 = [];
    
    foreach ( var6, var5 in var0.powers )
    {
        if ( isdefined( var5.label ) )
        {
            if ( level.disable_super_in_turret.spawndistancemax )
            {
                self.ref_12821[ var6 ] = ref_1262f( var5.label, var5.waitforstreamsynccomplete, var3, var5.ref_13060 );
            }
            else
            {
                self.ref_12821[ var6 ] = spawnstruct();
                self.ref_12821[ var6 ].frac = 0;
            }
            
            self.ref_12821[ var6 ].incooldown = 0;
            var3 += var2;
        }
    }
}

// Params 4
// Size: 0x168
function ref_1262f( var0, var1, var2, var3 )
{
    var4 = scripts\mp\hud_util::createfontstring( "default", 1.5 );
    var4.x = 15;
    var4.y = var2;
    var4.alignx = "left";
    var4.aligny = "top";
    var4.horzalign = "left_adjustable";
    var4.vertalign = "top_adjustable";
    var4.alpha = var3;
    var4.glowalpha = 0;
    var4.hidewheninmenu = 1;
    var4.archived = 0;
    
    if ( isdefined( var1 ) && !scripts\engine\utility::is_player_gamepad_enabled() )
    {
        var4.label = var1;
    }
    else if ( isdefined( var0 ) )
    {
        var4.label = var0;
    }
    
    var5 = scripts\mp\hud_util::createbar( ( 1, 1, 1 ), 160, 14 );
    var5.x = 13;
    var5.y = var2;
    var5.alignx = "left";
    var5.aligny = "top";
    var5.horzalign = "left_adjustable";
    var5.vertalign = "top_adjustable";
    var5.alpha = var3;
    ref_132a8( var5 );
    var5.archived = 0;
    var5.hidewheninmenu = 1;
    var5.bar.archived = 0;
    var5.bar.hidewheninmenu = 1;
    var5.bar.alpha = var3;
    var4.choppergunner_refillmissiles = var5;
    return var4;
}

// Params 4
// Size: 0x84
function ref_132a8( var0, var1, var2, var3 )
{
    self.bar.horzalign = self.horzalign;
    self.bar.vertalign = self.vertalign;
    self.bar.alignx = "left";
    self.bar.aligny = self.aligny;
    self.bar.y = self.y + 2;
    self.bar.x = self.x + 2;
    scripts\mp\hud_util::updatebar( self.bar.frac );
}

// Params 1
// Size: 0x66
function ref_12632( var0 )
{
    if ( isbot( self ) )
    {
        return;
    }
    
    foreach ( var2 in var0.powers )
    {
        foreach ( var4 in var2.clients_hacked )
        {
            self notifyonplayercommandremove( var6, var4 );
        }
    }
}

// Params 1
// Size: 0x42
function ref_12633( var0 )
{
    foreach ( var2 in var0.powers )
    {
        if ( isdefined( var2.has_ammo_drain_passive ) )
        {
            self thread [[ var2.has_ammo_drain_passive ]]( var0, var3 );
        }
    }
}

// Params 1
// Size: 0xad
function ref_1262d( var0 )
{
    if ( !isdefined( var0 ) || !isdefined( self.ref_12821 ) )
    {
        return;
    }
    
    self notify( "disableCooldown" );
    
    foreach ( var3, var2 in var0.powers )
    {
        if ( !isdefined( self.ref_12821[ var3 ] ) )
        {
            continue;
        }
        
        self.ref_12821[ var3 ].incooldown = 0;
        
        if ( level.disable_super_in_turret.spawndistancemax )
        {
            self.ref_12821[ var3 ].choppergunner_refillmissiles scripts\mp\hud_util::updatebar( 0, 0 );
        }
        else
        {
            self.ref_12821[ var3 ].frac = 0;
        }
        
        thread ref_12639( var0, var3 );
    }
    
    self.laststandattackermodifiers = undefined;
    self.vehicle_occupancy_mp_hidecashbag = undefined;
}

// Params 1
// Size: 0x33
function ref_12bba( var0 )
{
    if ( !isdefined( level.teamdata[ var0 ][ "aliveCountHuman" ] ) )
    {
        return level.teamdata[ var0 ][ "aliveCount" ];
    }
    
    return level.teamdata[ var0 ][ "aliveCountHuman" ];
}

// Params 2
// Size: 0x11e
function wait_for_chopper_boss_finish_turning( var0, var1 )
{
    var2 = self;
    level endon( "game_ended" );
    var2 endon( "disconnect" );
    var2 notify( "gulag_auto_win" );
    var2 notify( "zombie_set" );
    var2 notify( "zombie_unset" );
    
    if ( istrue( var2.respawningfromtoken ) )
    {
        return;
    }
    
    var3 = var0;
    var4 = "token_sponsored";
    
    if ( !isalive( var2 ) && istrue( var2.delay_enter_combat_after_investigating_grenade ) )
    {
        if ( !level.disable_super_in_turret.fluctuatevalues )
        {
            ref_1267d( var2, 1 );
        }
        
        var5 = scripts\mp\gametypes\br_gulag::ref_125c7( var0, var1, 0, 1, "zombiesRevive" );
        var3 = var5[ 0 ];
        var4 = var5[ 1 ];
        var5 = undefined;
    }
    else if ( istrue( var3.hasrespawntoken ) )
    {
        var3 scripts\mp\gametypes\br_pickups::removerespawntoken();
    }
    
    var2.respawningfromtoken = 1;
    var6 = var2 scripts\mp\gametypes\br_gulag::ref_126e8();
    
    if ( var6 )
    {
        var2 scripts\mp\utility\lower_message::setlowermessageomnvar( 0 );
    }
    
    var2 scripts\mp\hud_message::heartbeat_sensor_pick_up_monitor();
    
    if ( level.disable_super_in_turret.fluctuatevalues )
    {
        var2 scripts\mp\gametypes\br_gametype_zxp::ref_126fa( 1 );
    }
    else
    {
        ref_12723( var2, 0 );
    }
    
    var2 freezecontrols( 0 );
    var2 freezelookcontrols( 0 );
    var2 allowsprint( 1 );
    var7 = "br_gulag_kiosk_redeploy";
    var8 = var0;
    var2 thread scripts\mp\hud_message::showsplash( var7, undefined, var0 );
    var2.respawningfromtoken = undefined;
}

// Params 1
// Size: 0x42
function ref_12638( var0 )
{
    foreach ( var2 in var0.powers )
    {
        if ( isdefined( var2.ref_1387b ) )
        {
            self thread [[ var2.ref_1387b ]]( var0, var3 );
        }
    }
}

// Params 1
// Size: 0x3a
function ref_12635( var0 )
{
    if ( isbot( self ) )
    {
        return;
    }
    
    foreach ( var2 in var0.powers )
    {
        thread ref_12636( var0, var3 );
    }
}

// Params 2
// Size: 0x64
function ref_12636( var0, var1 )
{
    self endon( "death_or_disconnect" );
    self endon( "zombie_unset" );
    self endon( "zombie_set" );
    level endon( "game_ended" );
    
    for ( ;; )
    {
        self waittill( var1 );
        waittillframeend();
        
        if ( isdefined( self.ref_12821[ var1 ] ) && self.ref_12821[ var1 ].incooldown )
        {
            ref_12614();
            continue;
        }
        
        self thread [[ var0.powers[ var1 ].func ]]( var0, var1 );
    }
}

// Params 0
// Size: 0x2f
function ref_12614()
{
    if ( !isdefined( self.laststandattackermodifiers ) || gettime() > self.laststandattackermodifiers )
    {
        self playlocalsound( "br_pickup_deny" );
        self.laststandattackermodifiers = gettime() + 1000;
        return;
    }
}

// Params 1
// Size: 0xe2
function ref_1263a( var0 )
{
    level endon( "game_ended" );
    self endon( "zombie_unset" );
    self endon( "zombie_set" );
    self endon( "death_or_disconnect" );
    
    if ( isbot( self ) )
    {
        return;
    }
    
    waittillframeend();
    var1 = scripts\engine\utility::is_player_gamepad_enabled();
    
    for ( ;; )
    {
        var2 = scripts\engine\utility::is_player_gamepad_enabled();
        
        if ( var2 != var1 )
        {
            var1 = var2;
            jumpiffalse(var2) LOC_00000091;
            
            foreach ( var5, var4 in var0.powers )
            {
                if ( isdefined( var4.waitforstreamsynccomplete ) )
                {
                    self.ref_12821[ var5 ].label = var4.label;
                }
            }
            
            goto LOC_000000db;
        }
        
        waitframe();
    }
}

// Params 2
// Size: 0x1cc
function ref_12639( var0, var1 )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "zombie_unset" );
    self endon( "zombie_set" );
    self endon( "disableCooldown" );
    
    if ( !isdefined( self.ref_12821[ var1 ] ) || istrue( self.ref_12821[ var1 ].incooldown ) )
    {
        return;
    }
    
    var2 = self.ref_12821[ var1 ];
    
    if ( level.disable_super_in_turret.ref_12820 && var2.frac > 0 )
    {
        self.ref_12821[ var1 ].incooldown = 1;
        var3 = var0.powers[ var1 ].idmask;
        var4 = "scr_br_zxp_power_cooldown_" + var1;
        
        if ( getdvarint( var4, 0 ) != 0 )
        {
            var3 = getdvarint( var4, 0 );
        }
        
        thread ref_126de( var0, var1, var3, int( var2.frac * 100 ) );
        var5 = var2.frac;
        var3 *= var5;
        
        if ( level.disable_super_in_turret.spawndistancemax )
        {
            var2.choppergunner_refillmissiles.bar.color = ( 1, 0.6, 0 );
            var2.choppergunner_refillmissiles.bar scaleovertime( var3, 0, var2.choppergunner_refillmissiles.height );
        }
        
        wait var3;
        var6 = "ui_zxp_restock_" + var1;
        self playlocalsound( var6 );
        self.ref_12821[ var1 ].incooldown = 0;
    }
    else
    {
        if ( level.disable_super_in_turret.spawndistancemax )
        {
            var2.choppergunner_refillmissiles scripts\mp\hud_util::updatebar( 0, 0 );
        }
        else
        {
            var2.frac = 0;
        }
        
        thread ref_126de( var0, var1, 0, 0 );
    }
    
    if ( level.disable_super_in_turret.spawndistancemax )
    {
        var2.choppergunner_refillmissiles.bar.color = ( 1, 1, 1 );
    }
    
    if ( isdefined( var0.powers[ var1 ].ref_127fc ) )
    {
        self [[ var0.powers[ var1 ].ref_127fc ]]( var0, var1 );
        return;
    }
}

// Params 4
// Size: 0xee
function ref_126de( var0, var1, var2, var3 )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "zombie_unset" );
    self endon( "zombie_set" );
    self endon( "disableCooldown" );
    
    if ( !isdefined( var0.powers[ var1 ].ref_1388f ) || !isdefined( var0.powers[ var1 ].ref_128be ) )
    {
        return;
    }
    
    ref_14033( var0.powers[ var1 ].ref_1388f, 1 );
    var4 = var2 * 1000 * var3 / 100;
    var5 = gettime();
    var6 = var5 + var4;
    
    while ( gettime() < var6 )
    {
        var7 = gettime();
        var8 = ( var6 - gettime() ) / var4;
        var9 = var8 * var3;
        ref_14033( var0.powers[ var1 ].ref_128be, int( var9 ) );
        waitframe();
    }
    
    ref_14033( var0.powers[ var1 ].ref_128be, 0 );
    ref_14033( var0.powers[ var1 ].ref_1388f, 2 );
}

// Params 2
// Size: 0x124
function ref_14033( var0, var1 )
{
    var2 = 0;
    var3 = 0;
    
    switch ( var0 )
    {
        case "jumpStatus":
            var2 = 0;
            var3 = 2;
            break;
        case "jumpProgress":
            var2 = 2;
            var3 = 7;
            break;
        case "empStatus":
            var2 = 9;
            var3 = 2;
            break;
        case "empProgress":
            var2 = 11;
            var3 = 7;
            break;
        case "gasGrenadeStatus":
            var2 = 18;
            var3 = 2;
            break;
        case "gasGrenadeProgress":
            var2 = 20;
            var3 = 7;
            break;
        case "numVaccine":
            var2 = 27;
            var3 = 2;
            break;
        default:
            break;
    }
    
    if ( !isdefined( level.ref_146e0 ) )
    {
        level.ref_146e0 = [];
    }
    
    if ( !isdefined( level.ref_146e0[ "ui_br_zombie_powers" ] ) )
    {
        level.ref_146e0[ "ui_br_zombie_powers" ] = 0;
    }
    
    var4 = int( pow( 2, var3 ) ) - 1;
    var5 = ( int( var1 ) & var4 ) << var2;
    var6 = ~( var4 << var2 );
    var7 = self calloutmarkerping_entityzoffset( "ui_br_zombie_powers" );
    var8 = var7 & var6;
    var9 = var8 + var5;
    level.ref_146e0[ "ui_br_zombie_powers" ] = var9;
    self setclientomnvar( "ui_br_zombie_powers", level.ref_146e0[ "ui_br_zombie_powers" ] );
}

// Params 2
// Size: 0x25a
function ref_12716( var0, var1 )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "zombie_unset" );
    self endon( "playerZombieJumpStop" );
    var2 = -1;
    
    if ( ref_12717() )
    {
        ref_12614();
        return;
    }
    
    var3 = getdvarfloat( "scr_br_zxp_powers_jump_charge_rate", 1 );
    var4 = getdvarfloat( "scr_br_zxp_powers_jump_min_frac", 0.25 );
    var5 = getdvarint( "scr_br_zxp_powers_jump_max_hold_time", var2 );
    var6 = var3 * level.framedurationseconds;
    self.vehicle_occupancy_monitormovementcontrols = 0;
    self allowmelee( 0 );
    self disableoffhandweapons();
    
    while ( self ismantling() || self isthrowinggrenade() || self ismeleeing() || scripts\mp\utility\weapon::grenadeinpullback() )
    {
        waitframe();
    }
    
    thread ref_1270f();
    thread ref_13982();
    var7 = undefined;
    var8 = 0;
    
    if ( !isdefined( self.vehicle_occupancy_mp_hidecashbag ) || gettime() > self.vehicle_occupancy_mp_hidecashbag )
    {
        self playlocalsound( "ui_zxp_charge_jump_start" );
        self.vehicle_occupancy_mp_hidecashbag = gettime() + 500;
    }
    
    jumpiffalse(isdefined( var0.powers[ var1 ].ref_1388f )) LOC_00000102;
    ref_14033( var0.powers[ var1 ].ref_1388f, 0 );
    
    while ( !ref_12717() )
    {
        if ( level.disable_super_in_turret.spawndistancemax )
        {
            self.ref_12821[ var1 ].choppergunner_refillmissiles scripts\mp\hud_util::updatebar( self.vehicle_occupancy_monitormovementcontrols, 0 );
        }
        else
        {
            self.ref_12821[ var1 ].frac = self.vehicle_occupancy_monitormovementcontrols;
        }
        
        var9 = self.vehicle_occupancy_monitormovementcontrols;
        self.vehicle_occupancy_monitormovementcontrols += var6;
        
        if ( self.vehicle_occupancy_monitormovementcontrols >= 1 )
        {
            self.vehicle_occupancy_monitormovementcontrols = 1;
            
            if ( var5 >= 0 )
            {
                if ( !isdefined( var7 ) )
                {
                    var7 = gettime() + var5 * 1000;
                    
                    if ( level.disable_super_in_turret.spawndistancemax )
                    {
                        thread ref_1271a( var1, var5 );
                    }
                }
                
                if ( gettime() >= var7 )
                {
                    break;
                }
            }
        }
        
        if ( level.disable_super_in_turret.spawndistancemax && var9 < var4 && self.vehicle_occupancy_monitormovementcontrols >= var4 )
        {
            self.ref_12821[ var1 ].choppergunner_refillmissiles.bar.color = ( 0, 1, 0 );
        }
        
        if ( var9 < 1 && self.vehicle_occupancy_monitormovementcontrols >= 1 )
        {
            self playlocalsound( "ui_zxp_charge_jump_full" );
        }
        
        if ( isdefined( var0.powers[ var1 ].ref_128be ) )
        {
            var8 = max( int( self.vehicle_occupancy_monitormovementcontrols * 100 ), 0 );
            ref_14033( var0.powers[ var1 ].ref_128be, var8 );
        }
        
        waitframe();
    }
    
    thread ref_12719( var0, var1 );
}

// Params 0
// Size: 0x17, Type: bool
function ref_12717()
{
    return self getstance() == "prone" || istrue( self.usingascender );
}

// Params 0
// Size: 0xac, Type: bool
function ref_1271c()
{
    if ( level.disable_super_in_turret.vehicle_occupancy_monitorturretcontrols != 0 )
    {
        var0 = self.origin + ( 0, 0, level.disable_super_in_turret.vehicle_occupancy_monitorturretcontrols );
        var1 = playerphysicstrace( self.origin, var0 );
        
        if ( var1 != var0 )
        {
            return false;
        }
    }
    
    if ( level.disable_super_in_turret.vehicle_occupancy_mp_changedseats != 0 )
    {
        var2 = self geteye();
        var0 = var2 + ( 0, 0, level.disable_super_in_turret.vehicle_occupancy_mp_changedseats );
        var3 = 10;
        var4 = 20;
        var5 = scripts\engine\trace::create_contents( 0, 1, 0, 1, 0, 0, 1 );
        var1 = scripts\engine\trace::capsule_trace( var2, var0, var3, var4, ( 0, 0, 0 ), self, var5 );
        
        if ( var1[ "fraction" ] != 1 )
        {
            return false;
        }
    }
    
    return true;
}

// Params 2
// Size: 0x13c
function ref_12719( var0, var1 )
{
    self stopgestureviewmodel( "ges_zombie_superjumpcharge" );
    self notify( "playerZombieJumpChargeEnd" );
    self notify( "playerZombieJumpStop" );
    var2 = getdvarfloat( "scr_br_zxp_powers_jump_min_frac", 0.25 );
    var3 = getdvarint( "scr_br_zxp_powers_jump_min_frac_refund", 1 );
    
    if ( self.vehicle_occupancy_monitormovementcontrols >= var2 && !ref_12717() && ref_1271c() && !self ismantling() )
    {
        self playsoundtoplayer( "zxp_superjump_vo", self, self );
        self playsound( "zxp_superjump_sfx_npc", self, self );
        var4 = getdvarfloat( "scr_br_zxp_powers_jump_velocity", 1300 );
        var5 = self getplayerangles();
        thread ref_12711();
        ref_1250a( var5, var4, self.vehicle_occupancy_monitormovementcontrols );
        thread ref_126d7();
        thread ref_12528();
        self.laststandattackermodifiers = undefined;
        self.vehicle_occupancy_mp_hidecashbag = undefined;
    }
    else if ( var3 )
    {
        if ( level.disable_super_in_turret.spawndistancemax )
        {
            self.ref_12821[ var1 ].choppergunner_refillmissiles.bar.frac = 0;
        }
        else
        {
            self.ref_12821[ var1 ].frac = 0;
        }
        
        ref_14033( var0.powers[ var1 ].ref_128be, 0 );
        self enableoffhandweapons();
        self allowmelee( 1 );
        self notify( "endSuperJumpFov" );
        ref_12614();
    }
    else
    {
        ref_12614();
    }
    
    ref_12718( var0, var1, 1 );
}

// Params 0
// Size: 0x7c
function ref_1270f()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "zombie_unset" );
    self endon( "playerZombieJumpStop" );
    
    if ( self isgestureplaying( "ges_zombie_superjumpcharge" ) )
    {
        return;
    }
    
    while ( self ismantling() || self isthrowinggrenade() || self ismeleeing() || scripts\mp\utility\weapon::grenadeinpullback() )
    {
        waitframe();
    }
    
    self forceplaygestureviewmodel( "ges_zombie_superjumpcharge" );
    
    while ( self isgestureplaying( "ges_zombie_superjumpcharge" ) )
    {
        if ( self isonladder() )
        {
            self stopgestureviewmodel( "ges_zombie_superjumpcharge" );
            break;
        }
        
        waitframe();
    }
}

// Params 0
// Size: 0x9b
function ref_12711()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self setscriptablepartstate( "skydiveVfx", "enabled_zombie", 0 );
    wait 0.2;
    self notify( "endSuperJumpFov" );
    self forceplaygestureviewmodel( "ges_zombie_superjump" );
    
    while ( !ref_12715() )
    {
        waitframe();
    }
    
    self notify( "zombie_jump_complete" );
    self stopgestureviewmodel( "ges_zombie_superjump" );
    self setscriptablepartstate( "skydiveVfx", "default", 0 );
    self playsoundtoplayer( "zxp_splat_plr", self, self );
    self playsound( "zmb_npc_breath_land_hi", self, self );
    self playsound( "zxp_splat_npc", self, self );
    wait 0.2;
    self enableoffhandweapons();
    self allowmelee( 1 );
}

// Params 0
// Size: 0x16, Type: bool
function ref_12715()
{
    return self isonground() || self isonladder() || self ismantling();
}

// Params 4
// Size: 0x17b
function ref_1250a( var0, var1, var2, var3 )
{
    var4 = 1;
    var5 = ( 0, 0, 20 );
    
    if ( !isdefined( var3 ) )
    {
        var3 = var5;
    }
    
    var6 = var0;
    var7 = ( 0, 0, 1 );
    var8 = ( 1, 0, 0 );
    
    if ( getdvarint( "scr_br_zxp_powers_jump_pitch_correction", var4 ) )
    {
        var7 = propwaitminigameinit();
        
        if ( !isdefined( var7 ) )
        {
            var7 = ( 0, 0, 1 );
        }
        
        var9 = ( 0, var6[ 1 ], 0 );
        var10 = anglestoright( var9 );
        var8 = vectorcross( var7, var10 );
        var11 = vectortoangles( var8 );
        var12 = angleclamp180( var11[ 0 ] );
        var13 = -85;
        var14 = var12;
        var15 = var6[ 0 ];
        
        if ( var15 > var12 )
        {
            var15 = var12;
        }
        
        var16 = getdvarfloat( "scr_br_zxp_powers_jump_pitch_correction_at_max", -45 );
        var17 = getdvarfloat( "scr_br_zxp_powers_jump_pitch_correction_at_min", 0 );
        var18 = ( var15 - var13 ) / ( var14 - var13 );
        var19 = var17 + var18 * ( var16 - var17 );
        var6 = ( var15 + var19, var6[ 1 ], var6[ 2 ] );
    }
    
    var20 = getdvarfloat( "scr_br_zxp_powers_jump_pitch_add", 0 );
    
    if ( var20 != 0 )
    {
        var6 = ( var6[ 0 ] + var20, var6[ 1 ], var6[ 2 ] );
    }
    
    var21 = anglestoforward( var6 );
    var22 = var21 * var2 * var1;
    var23 = self.origin + var3;
    self setorigin( var23 );
    self setvelocity( var22 );
    glassradiusdamage( self.origin + ( 0, 0, 30 ), 30, 50, 51 );
    var24 = anglestoforward( self.angles );
    var25 = self.origin + ( 0, 0, 30 ) + var24 * 15;
    radiusdamage( var25, 100, 1, 1 );
}

// Params 0
// Size: 0xc6
function ref_126d7()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "zombie_unset" );
    var0 = getdvarfloat( "scr_br_zxp_air_control", 400 );
    
    if ( var0 <= 0 )
    {
        return;
    }
    
    var1 = getdvarfloat( "scr_br_zxp_air_control_max_speed", 1400 );
    wait 0.2;
    
    while ( !ref_12715() )
    {
        var2 = self getnormalizedmovement();
        
        if ( length( var2 ) > 0 )
        {
            var3 = rotatevector( ( var2[ 0 ], -1 * var2[ 1 ], 0 ), self.angles );
            var4 = self getvelocity();
            var5 = length( var4 );
            var6 = var3 * var0 * level.framedurationseconds;
            var7 = var4 + var6;
            var8 = length( var7 );
            
            if ( var8 <= var1 )
            {
                self setvelocity( var7 );
            }
            else if ( var5 < var1 )
            {
                var7 = vectornormalize( var7 ) * var1;
                self setvelocity( var7 );
            }
        }
        
        waitframe();
    }
}

// Params 0
// Size: 0x41
function ref_12528()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "zombie_unset" );
    self endon( "zombie_jump_complete" );
    var0 = getdvarfloat( "scr_br_zxp_clear_moving_platfrom_time", 0.3 );
    
    if ( var0 < 0 )
    {
        return;
    }
    
    if ( var0 > 0 )
    {
        wait var0;
    }
    
    self method_87b1();
}

// Params 5
// Size: 0x30
function isvalidpointinbounds( var0, var1, var2, var3, var4 )
{
    level notify( "hitVelocity" );
    level endon( "hitVelocity" );
    var5 = var0 + var1;
    var6 = var2 + var3 * 20;
    var7 = var2 + var4 * 20;
    
    for ( ;; )
    {
        waitframe();
    }
}

// Params 2
// Size: 0x24
function ref_1271b( var0, var1 )
{
    if ( isdefined( self.vehicle_occupancy_monitormovementcontrols ) )
    {
        ref_12719( var0, "jump" );
        return;
    }
    
    self notify( "playerZombieJumpStop" );
}

// Params 2
// Size: 0x12e
function propwaitminigameinit( var0, var1 )
{
    if ( !isdefined( var0 ) )
    {
        var2 = self;
    }
    else
    {
        var2 = var1;
    }
    
    if ( !isdefined( var2 ) )
    {
        var2 = 0;
    }
    
    var3 = [ var2 ];
    var4 = [ self.origin ];
    var5 = -1;
    
    while ( var5 <= 1 )
    {
        var6 = -1;
        
        while ( var6 <= 1 )
        {
            var7 = var2 getpointinbounds( var5, var6, 0 );
            var7 = ( var7[ 0 ], var7[ 1 ], self.origin[ 2 ] );
            var4 = var7;
            var6 += 2;
        }
        
        var5 += 2;
    }
    
    var8 = ( 0, 0, 0 );
    var9 = 0;
    
    foreach ( var11 in var4 )
    {
        var12 = scripts\engine\trace::_bullet_trace( var11 + ( 0, 0, 4 ), var11 + ( 0, 0, -16 ), 0, var3 );
        var13 = var12[ "fraction" ] > 0 && var12[ "fraction" ] < 1;
        
        if ( var13 )
        {
            var8 += var12[ "normal" ];
            var9++;
        }
    }
    
    if ( var9 > 0 )
    {
        var8 /= var9;
        return var8;
    }
    
    return undefined;
}

// Params 3
// Size: 0x19
function ref_12718( var0, var1, var2 )
{
    if ( istrue( var2 ) )
    {
        thread ref_12639( var0, var1 );
    }
    
    self.vehicle_occupancy_monitormovementcontrols = undefined;
}

// Params 2
// Size: 0xb3
function ref_1271a( var0, var1 )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "zombie_unset" );
    self endon( "playerZombieJumpStop" );
    self endon( "playerZombieJumpChargeEnd" );
    
    if ( var1 <= 0 )
    {
        return;
    }
    
    var2 = scripts\mp\gametypes\br_circle::can_killstreak_be_detected( var1, int( var1 * 5 ), 1 );
    var3 = 1;
    
    for ( var4 = 0; var4 < var2.size ; var4++ )
    {
        if ( var3 )
        {
            self.ref_12821[ var0 ].choppergunner_refillmissiles.bar.color = ( 1, 0, 0 );
        }
        else
        {
            self.ref_12821[ var0 ].choppergunner_refillmissiles.bar.color = ( 0, 1, 0 );
        }
        
        wait var2[ var4 ];
        var3 = !var3;
    }
}

// Params 2
// Size: 0x73
function ref_125d7( var0, var1 )
{
    var2 = 1800;
    var3 = spawnstruct();
    var3.origin = self.origin;
    var0 thread scripts\mp\equipment\concussion_grenade::applyconcussion( var3, self );
    thread ref_1262e( var0 );
    var4 = var0.origin - self.origin;
    var5 = vectortoangles( var4 );
    var6 = distance( var0.origin, self.origin );
    var7 = 1 - var6 / var1;
    ref_1250a( var0, var5, var2, var7 );
}

// Params 1
// Size: 0x63
function checkspawnwithinmapradius( var0 )
{
    if ( istrue( level.∫eÌ.9+÷eË*C(≠çÉròMrKAüWí  ) && isscriptabledefined() )
    {
        if ( isdefined( level.ref_12ca9 ) && level.ref_12ca9 >= 0 )
        {
            var1 = getclosestpointonnavmesh( var0 );
            var2 = var1 - var0;
            
            if ( length2d( var2 ) > level.ref_12ca9 )
            {
                var2 = vectornormalize( var2 );
                var2 = ( var2[ 0 ] * level.ref_12ca9, var2[ 1 ] * level.ref_12ca9, 0 );
                var0 = var1 + var2;
            }
        }
    }
    
    return var0;
}

// Params 1
// Size: 0x5a
function standard_health( var0 )
{
    if ( isexplosivedamagemod( var0.meansofdeath ) && var0.objweapon.basename == "emp_drone_non_player_direct_mp" || var0.objweapon.basename == "emp_drone_non_player_mp" || var0.objweapon.basename == "emp_drone_player_mp" )
    {
        return 1;
    }
    
    return 0;
}

// Params 1
// Size: 0x5f
function ref_1262e( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    self notify( "disableCooldown" );
    
    foreach ( var3, var2 in var0.powers )
    {
        if ( !isdefined( self.ref_12821[ var3 ] ) )
        {
            continue;
        }
        
        self.ref_12821[ var3 ].incooldown = 0;
        thread ref_1262c( var0, var3 );
    }
}

// Params 0
// Size: 0x37
function ref_13982()
{
    var0 = self;
    var0 endon( "death_or_disconnect" );
    var0 notify( "applyFOVPresentation" );
    var0 endon( "applyFOVPresentation" );
    var0 lerpfovbypreset( "zombiearcade" );
    var0 waittill( "endSuperJumpFov" );
    var0 lerpfovbypreset( "zombiedefault" );
}

// Params 2
// Size: 0xc
function addtoteamlives( var0, var1 )
{
    ref_126d8( var0 );
}

// Params 2
// Size: 0xc
function removefromteamlives( var0, var1 )
{
    ref_126d8( var0 );
}

// Params 0
// Size: 0x9, Type: bool
function ref_125e9()
{
    return istrue( self.tut_popup_listener );
}

// Params 1
// Size: 0x64, Type: bool
function watch_flight_collision( var0 )
{
    if ( scripts\mp\gametypes\br_public::ref_125f3() )
    {
        var1 = isdefined( var0.attacker ) && nukefridgewatcher( var0.attacker );
        
        if ( !var1 || !level.disable_super_in_turret.ref_1470a )
        {
            return false;
        }
        
        thread ref_1262e( level.disable_super_in_turret.ref_14693 );
        thread ref_1271d();
        thread ref_12731( var0 );
        thread ref_12701();
    }
    
    return true;
}

// Params 1
// Size: 0x69
function ref_12731( var0 )
{
    var1 = 500;
    var2 = 90;
    var3 = 60;
    var4 = 30;
    var5 = var0.direction_vec;
    var6 = vectortoyaw( var5 );
    var7 = var2;
    var8 = var3;
    
    if ( scripts\engine\utility::cointoss() )
    {
        var8 *= -1;
    }
    
    var8 += var6;
    var9 = ( var7, var8, 0 );
    var10 = vectornormalize( ( var5[ 0 ], var5[ 1 ], 0 ) );
    var11 = var10 * var4 + ( 0, 0, var4 );
    ref_1250a( var9, var1, 1, var11 );
}

// Params 0
// Size: 0x27
function ref_12701()
{
    self endon( "disconnect" );
    self.ref_1423b = 1;
    var0 = getdvarfloat( "scr_br_zxp_vehicle_immunity", 1.5 );
    wait var0;
    self.ref_1423b = undefined;
}

// Params 0
// Size: 0x12f
function ref_1271d()
{
    level endon( "game_ended" );
    self endon( "last_stand_finished" );
    self endon( "death_or_disconnect" );
    self waittill( "last_stand_transition_done" );
    waittillframeend();
    self setlaststandenabled( 1 );
    self.usedprops = 1;
    self.laststandreviveent makeunusable();
    var0 = self.laststandreviveent;
    var0.usetime = getdvarfloat( "scr_br_zxp_vehicle_getup", 3 ) * 1000;
    
    if ( !isdefined( var0.curprogress ) )
    {
        var0.curprogress = 0;
    }
    
    while ( scripts\mp\utility\player::isreallyalive( self ) && var0.curprogress < var0.usetime )
    {
        if ( self isinexecutionvictim() )
        {
            waitframe();
            continue;
        }
        
        if ( !isdefined( var0.userate ) )
        {
            var0.userate = 0;
        }
        
        var0.curprogress += level.frameduration * var0.userate;
        var0.userate = 1;
        scripts\mp\gameobjects::updateuiprogress( var0, 1 );
        
        if ( var0.curprogress >= var0.usetime )
        {
            break;
        }
        
        waitframe();
    }
    
    var0.usetime = undefined;
    var0.curprogress = undefined;
    var0.userate = undefined;
    scripts\mp\laststand::playanim_aibegindismountturret( "self_revive_success", self );
    self playsoundtoplayer( "zmb_breath_land_dropin", self, self );
    self playsound( "zmb_npc_breath_land_dropin" );
    self setlaststandenabled( 0 );
}

// Params 0
// Size: 0x16a
function ref_12810()
{
    if ( istrue( level.br_debugsolotest ) || level.gameended )
    {
        return;
    }
    
    var0 = 0;
    var1 = [];
    var2 = [];
    
    foreach ( var4 in level.teamnamelist )
    {
        var5 = level.teamdata[ var4 ][ "teamCount" ];
        
        if ( var5 > 0 )
        {
            if ( level.teamdata[ var4 ][ "aliveCountHuman" ] > 0 )
            {
                if ( ( level.disable_super_in_turret.vehicle_occupancy_getplayerfriendlyto || level.disable_super_in_turret.vehicle_occupancy_friendlystatuschangedcallback == 0 ) && var2.size > 0 )
                {
                    return;
                }
                
                var2 = var4;
                var0 += level.teamdata[ var4 ][ "aliveCountHuman" ];
                continue;
            }
            
            if ( level.teamdata[ var4 ][ "aliveCount" ] > 0 )
            {
                var1 = var4;
            }
        }
    }
    
    if ( !level.disable_super_in_turret.vehicle_occupancy_getplayerfriendlyto && var0 <= level.disable_super_in_turret.vehicle_occupancy_friendlystatuschangedcallback )
    {
        level.disable_super_in_turret.vehicle_occupancy_getplayerfriendlyto = 1;
        thread clear_tier_lights_all( var2 );
        
        if ( level.disable_super_in_turret.ref_146e8 )
        {
            level.disable_super_in_turret.ref_146e7 = 0;
        }
    }
    
    if ( var2.size > 1 )
    {
        return;
    }
    
    var7 = scripts\mp\utility\script::quicksort( var1, &ref_134d6 );
    
    for ( var8 = 0; var8 < var7.size ; var8++ )
    {
        var4 = var7[ var8 ];
        var9 = var8 + 2;
        thread scripts\mp\gametypes\br::ref_1209b( var4, var9, 0, 1 );
    }
    
    thread scripts\mp\gamelogic::endgame( var2[ 0 ], game[ "end_reason" ][ "enemies_eliminated" ] );
}

// Params 2
// Size: 0x27, Type: bool
function ref_134d6( var0, var1 )
{
    var2 = level.teamdata[ var0 ][ "lastZombieTime" ];
    var3 = level.teamdata[ var1 ][ "lastZombieTime" ];
    return var2 >= var3;
}

// Params 0
// Size: 0x13
function ref_1472d()
{
    wait 5;
    scripts\mp\utility\sound::besttime( "br_zxp" );
}

// Params 0
// Size: 0x68
function ref_126d8()
{
    var0 = self.team;
    level.teamdata[ var0 ][ "aliveCountHuman" ] = 0;
    
    foreach ( var2 in level.teamdata[ var0 ][ "alivePlayers" ] )
    {
        if ( !var2 scripts\mp\gametypes\br_public::ref_125f3() && !ref_125e9( var2 ) )
        {
            level.teamdata[ var0 ][ "aliveCountHuman" ]++;
        }
    }
}

