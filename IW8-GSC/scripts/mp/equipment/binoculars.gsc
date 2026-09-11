
#using_animtree( "" );

// Params 0
// Size: 0x34e
function teamuseonly()
{
    level.get_station_controller_struct = spawnstruct();
    level.get_station_controller_struct.plundertotal = getdvarint( "scr_br_carriable_gasoline_explosion_radius", 300 );
    level.get_station_controller_struct.plunderstructreplenish = getdvarint( "scr_br_carriable_gasoline_explosion_max_dmg", 250 );
    level.get_station_controller_struct.plundertimer = getdvarint( "scr_br_carriable_gasoline_explosion_min_dmg", 50 );
    setdvarifuninitialized( "scr_br_carriable_respawn_time", 0 );
    setdvarifuninitialized( "scr_br_carriable_inactive_delete_time", 300 );
    setdvarifuninitialized( "scr_br_carriable_spawn_system", 0 );
    setdvarifuninitialized( "scr_br_carriable_max_entity_cariables", 50 );
    setdvarifuninitialized( "scr_br_carriable_spawn_chance", 0 );
    precachestring( &"MP_BR_INGAME/PICKUP_PROPANE" );
    precachestring( &"MP_BR_INGAME/PICKUP_POISON" );
    setdvarifuninitialized( "carriableFuseTime", 5 );
    setdvarifuninitialized( "carriableThrowForce", 2250 );
    level.get_tier_reward_for_total_time = [];
    level.get_tier_reward_for_total_time[ "gasoline" ] = spawnstruct();
    level.get_tier_reward_for_total_time[ "gasoline" ].weaponname = "gasoline_can_mp";
    level.get_tier_reward_for_total_time[ "gasoline" ].modelname = "offhand_wm_jerrycan_thrown";
    level.get_tier_reward_for_total_time[ "gasoline" ].spawn_guys_at_lz = &"MP_BR_INGAME/PICKUP_PROPANE";
    level.get_tier_reward_for_total_time[ "gasoline" ].leader_charge_dialogue = &get_silencedshot_alias;
    level.get_tier_reward_for_total_time[ "gasoline" ].leader_intro_dialogue = "vfx_propane_exp_main";
    level.get_tier_reward_for_total_time[ "gasoline" ].leaderboard_enabled = "vfx_propane_exp_air";
    level.get_tier_reward_for_total_time[ "gasoline" ].playerzombieaddhudelem = "vfx_carriable_fuse";
    level.get_tier_reward_for_total_time[ "gasoline" ].ref_13711 = "vfx_fire_spout";
    level.get_tier_reward_for_total_time[ "gasoline" ].playerzombiecleanuppowers = "canister_warning";
    level.get_tier_reward_for_total_time[ "gasoline" ].ref_1459b = getcompleteweaponname( level.get_tier_reward_for_total_time[ "gasoline" ].weaponname );
    level.get_tier_reward_for_total_time[ "gasoline" ].playerzombiebacktohuman = "ges_carriable_gasoline_ignite";
    level.get_tier_reward_for_total_time[ "gasoline" ].playerzombiecleanup = "iw8_ges_plyr_carriable_gasoline_ignite";
    level.get_tier_reward_for_total_time[ "gasoline" ].playerzombiecleanupkeybindings = "gasolineCanisterIgnite";
    level.get_tier_reward_for_total_time[ "gasoline" ].playerzombieapplyemp = 1.23;
    level._effect[ "vfx_br3_rope_fire" ] = loadfx( "vfx/iw8_br/island/custom/vfx_br3_rope_fire.vfx" );
    level._effect[ "vfx_propane_exp_main" ] = loadfx( "vfx/iw8_br/equipment/vfx_propane_exp_main" );
    level._effect[ "vfx_propane_exp_air" ] = loadfx( "vfx/iw8_br/equipment/vfx_propane_exp_air" );
    level._effect[ "vfx_carriable_fuse" ] = loadfx( "vfx/iw8_br/island/custom/vfx_br3_canister_fuse" );
    level._effect[ "vfx_fire_spout" ] = loadfx( "vfx/iw8_br/equipment/vfx_fire_spout" );
    level.scr_animtree[ "player" ] = #animtree;
    level.scr_anim[ "player" ][ "carriable_ascender_attach" ] = $vm_eq_carriable_gasoline_ascender_attach_plr;
    level.scr_animname[ "player" ][ "carriable_ascender_attach" ] = "vm_eq_carriable_gasoline_ascender_attach_plr";
    level.scr_eventanim[ "player" ][ "carriable_ascender_attach" ] = "carriable_ascender_attach";
    level.scr_animtree[ "device" ] = #animtree;
    level.scr_anim[ "device" ][ "carriable_ascender_device_attach" ] = %wm_eq_carriable_gasoline_ascender_attach_ascender;
    level.scr_animname[ "device" ][ "carriable_ascender_device_attach" ] = "wm_eq_carriable_gasoline_ascender_attach_ascender";
    level.scr_eventanim[ "device" ][ "carriable_ascender_device_attach" ] = "carriable_ascender_device_attach";
    level.ref_1403d = [];
    level.get_target_spotted_alias = [];
    scripts\engine\scriptable::ref_12f5b( "br_carriable_pickup", &ref_12f63 );
    scripts\engine\scriptable::ref_12f5a( &ref_12f61 );
    thread handle_tank_spawning();
}

// Params 3
// Size: 0x106
function ref_13545( var0, var1, var2 )
{
    if ( isdefined( var0 ) )
    {
    }
    
    if ( !isdefined( var1 ) )
    {
        var1 = ( 0, 0, 0 );
    }
    
    if ( !isdefined( var2 ) )
    {
        var2 = ( 0, 0, 0 );
    }
    
    level.ref_1403d = scripts\engine\utility::array_removeundefined( level.ref_1403d );
    var3 = getdvarint( "scr_br_carriable_max_entity_cariables", 50 );
    
    if ( level.ref_1403d.size >= var3 )
    {
        var4 = 999999999;
        var5 = undefined;
        
        foreach ( var7 in level.ref_1403d )
        {
            if ( istrue( var7.playerzombiecleanuphud ) || var7 islinked() )
            {
                continue;
            }
            
            if ( var7.waittillmatchstarts < var4 )
            {
                var4 = var7.waittillmatchstarts;
                var5 = var7;
            }
        }
        
        if ( isdefined( var5 ) )
        {
        }
        
        var5 delete();
    }
    
    var9 = spawn( "script_model", var1 );
    var9 setmodel( var0.modelname );
    var9.angles = var2;
    var9.get_teaminquiry_alias = var0;
    get_station_index_in_active_stations( var9, var0 );
    level.ref_1403d = scripts\engine\utility::array_add( level.ref_1403d, var9 );
    return var9;
}

// Params 0
// Size: 0xa1
function handle_tank_spawning()
{
    foreach ( var1 in level.ref_1403d )
    {
        if ( !isdefined( var1 ) )
        {
            continue;
        }
        
        if ( var1 islinked() )
        {
            get_subway_train_hit_damage_multiplier( var1, 1 );
        }
        
        var1 delete();
    }
    
    level.ref_1403d = [];
    
    switch ( getdvarint( "scr_br_carriable_spawn_system", 0 ) )
    {
        case 0:
            ref_1351f();
            break;
        case 1:
            ref_1351c();
            break;
        case 2:
            ref_1351d();
            break;
        default:
            ref_1351f();
            break;
    }
}

// Params 0
// Size: 0x6d
function ref_1351f()
{
    var0 = getentitylessscriptablearrayinradius( "scriptable_br_carriable_gasoline", "classname" );
    var1 = var0;
    
    if ( var1.size == 0 )
    {
        return;
    }
    
    var2 = getdvarfloat( "scr_br_carriable_spawn_chance", 0 );
    var3 = floor( var2 * var1.size );
    
    for ( var4 = 0; var4 < var1.size ; var4++ )
    {
        if ( var4 < var3 )
        {
            var1[ var4 ] setscriptablepartstate( "br_carriable_pickup", "visible" );
            continue;
        }
        
        var1[ var4 ] setscriptablepartstate( "br_carriable_pickup", "hidden" );
    }
}

// Params 0
// Size: 0x6f
function ref_1351d()
{
    var0 = getdvarfloat( "scr_br_carriable_spawn_chance", 0 );
    var1 = scripts\engine\utility::array_randomize( getentitylessscriptablearrayinradius( "scriptable_br_carriable_gasoline", "classname" ) );
    
    if ( var1.size > 0 )
    {
        var2 = floor( var0 * var1.size );
        
        for ( var3 = 0; var3 < var1.size ; var3++ )
        {
            if ( var3 < var2 )
            {
                var1[ var3 ] setscriptablepartstate( "br_carriable_pickup", "visible" );
                continue;
            }
            
            var1[ var3 ] setscriptablepartstate( "br_carriable_pickup", "hidden" );
        }
        
        return;
    }
}

// Params 0
// Size: 0x2db
function ref_1351c()
{
    var0 = scripts\engine\utility::array_randomize( getentitylessscriptablearrayinradius( "scriptable_br_carriable_gasoline", "classname" ) );
    
    if ( var0.size == 0 )
    {
        return;
    }
    
    var1 = [];
    GscBinSkip0( 0x2e, "agricultural_center", ( 11086, -12336, 0 ) );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 0
// Size: 0x11
function mortar_start()
{
    self setscriptablepartstate( "br_carriable_pickup", "visible" );
}

// Params 5
// Size: 0xe2
function ref_12f63( var0, var1, var2, var3, var4 )
{
    if ( istrue( level.gameended ) )
    {
        return;
    }
    
    if ( !var3 scripts\cp_mp\utility\player_utility::_isalive() || istrue( var3.inlaststand ) )
    {
        return;
    }
    
    if ( var3 scripts\cp_mp\utility\player_utility::isinvehicle() )
    {
        if ( isdefined( level.showuseresultsfeedback ) )
        {
            var3 [[ level.showuseresultsfeedback ]]( 17 );
            return;
        }
    }
    
    if ( !get_sight_dist_for_taccover_check( var0, var3 ) )
    {
        return;
    }
    
    if ( var2 == "visible" )
    {
        var5 = level.get_tier_reward_for_total_time[ "gasoline" ];
        
        if ( var0.type == "br_carriable_propane" )
        {
            var5 = level.get_tier_reward_for_total_time[ "propane" ];
        }
        
        if ( var0.type == "br_carriable_neurotoxin" )
        {
            var5 = level.get_tier_reward_for_total_time[ "neurotoxin" ];
        }
        
        var0 setscriptablepartstate( "br_carriable_pickup", "hidden" );
        level notify( "carriable_kill_callout_" + var0.origin );
        var6 = ref_13545( var5, var3.origin );
        thread get_stay_at_station_time( var6 );
        thread ref_12c90( level, var0 );
        return;
    }
}

// Params 1
// Size: 0x32, Type: bool
function tv_station_fastrope_two_infil_start_targetname_array_index( var0 )
{
    return var0.type == "br_carriable_gasoline" || var0.type == "br_carriable_neurotoxin" || var0.type == "br_carriable_propane";
}

// Params 11
// Size: 0x38
function ref_12f61( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10 )
{
    if ( !isdefined( var2 ) || !tv_station_fastrope_two_infil_start_targetname_array_index( var2 ) )
    {
        return;
    }
    
    thread ref_12f62( level, var0, var1, var2, var3, var4, var5, var6, var7, var8, var9 );
}

// Params 11
// Size: 0x13d
function ref_12f62( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10 )
{
    waittillframeend();
    var11 = level.get_tier_reward_for_total_time[ "gasoline" ];
    
    if ( var2.type == "br_carriable_propane" )
    {
        var11 = level.get_tier_reward_for_total_time[ "propane" ];
    }
    
    if ( var2.type == "br_carriable_neurotoxin" )
    {
        var11 = level.get_tier_reward_for_total_time[ "neurotoxin" ];
    }
    
    level notify( "carriable_kill_callout_" + var2.origin );
    var12 = ref_13545( var11, var2.origin, var2.angles );
    var12.owner = var1;
    var12.team = var1.team;
    var12 thread [[ var11.leader_charge_dialogue ]]();
    var12 makeunusable();
    var12 hide();
    
    if ( isdefined( level.ref_12074 ) && isplayer( var1 ) && istrue( var1.should_take_damage ) && isdefined( var6 ) )
    {
        var13 = 0;
        
        if ( isdefined( var1.showassassinationtargethud ) )
        {
            var14 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt( var6 );
            
            if ( scripts\engine\utility::array_contains_key( var1.showassassinationtargethud, var14 ) )
            {
                var13 = 1;
            }
        }
        
        if ( var13 )
        {
            var12.updateteamplunderscore = 1;
            var12 thread _luidecision::playericonfilter( var1, var12.origin, "nospawn", level.getserverroomspawnpoint.get_ai_within_range );
            thread ref_13580();
        }
    }
    
    wait 5;
    
    if ( isdefined( var12 ) )
    {
        var12 delete();
        return;
    }
}

// Params 2
// Size: 0x28
function ref_12c90( var0, var1 )
{
    var2 = getdvarfloat( "scr_br_carriable_respawn_time", 0 );
    
    if ( var2 == 0 )
    {
        return;
    }
    
    wait var2;
    var0 setscriptablepartstate( "br_carriable_pickup", "visible" );
}

// Params 1
// Size: 0x4f
function ref_13518( var0 )
{
    var1 = "gasoline";
    
    if ( var0.script_noteworthy == "carriable_propane" )
    {
        var1 = "propane";
    }
    
    if ( var0.script_noteworthy == "carriable_neurotoxin" )
    {
        var1 = "neurotoxin";
    }
    
    var2 = level.get_tier_reward_for_total_time[ var1 ];
    var3 = ref_13545( var2, var0.origin );
}

// Params 1
// Size: 0x5c
function get_station_index_in_active_stations( var0 )
{
    self.start_origin = self.origin;
    self.get_teaminquiry_alias = var0;
    
    if ( !isdefined( self.script_health ) )
    {
        self.script_health = 16;
    }
    
    self sethintstring( self.get_teaminquiry_alias.spawn_guys_at_lz );
    self sethintdisplayfov( 20 );
    self setuseholdduration( "duration_short" );
    self sethintrequiresholding( 0 );
    self setusefov( 20 );
    self disablemissilestick();
    get_subway_car_available_to_deploy();
}

// Params 0
// Size: 0x16
function get_subway_train_hit_damage()
{
    self.origin = self.start_origin;
    self show();
    get_subway_car_available_to_deploy();
}

// Params 0
// Size: 0x7e
function get_subway_car_available_to_deploy()
{
    self method_87cd( 0 );
    self physics_takecontrol( 1 );
    self physics_registerforcollisioncallback();
    thread get_tag_to_target();
    thread get_swivel_spawnpoint();
    self.waittillmatchstarts = gettime();
    self.team = undefined;
    
    if ( !isdefined( self.playerzombiecleanuphud ) )
    {
        self.playerzombiecleanuphud = 0;
    }
    
    if ( !self.playerzombiecleanuphud )
    {
        self makeusable();
        thread get_stealth_alert_music_alias();
        thread get_starting_ai_per_site();
    }
    
    if ( self.script_health > 0 )
    {
        self setcandamage( 1 );
        self.is_first_time_high_tier = 0;
        self.health = 99999999;
        thread get_sight_dist_for_vehicle_check();
        return;
    }
}

// Params 0
// Size: 0x1ac
function get_sight_dist_for_vehicle_check()
{
    self notify( "carriable_damage_wait" );
    self endon( "death" );
    self endon( "explode" );
    self endon( "carriable_damage_wait" );
    
    for ( ;; )
    {
        self waittill( "damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9 );
        self.health = 99999999;
        
        if ( var0 < 14 )
        {
            continue;
        }
        
        if ( isdefined( var1.owner ) && isdefined( var1.owner.vehicle ) )
        {
            var10 = var1.owner.vehicle vehicle_getvelocity();
            var11 = sqrt( vectordot( var10, var10 ) );
            
            if ( var11 > 400 )
            {
                self.owner = undefined;
                self.team = undefined;
                thread get_smoke_grenade_start_pos();
                return;
            }
            
            continue;
        }
        
        switch ( var4 )
        {
            case "MOD_CRUSH":
            case "MOD_IMPACT":
            case "melee":
            case "MOD_MELEE":
                break;
            default:
                var12 = isdefined( var1 ) && scripts\mp\utility\damage::attackerishittingteam( self, var1 );
                
                if ( !var12 )
                {
                    if ( isdefined( var1 ) )
                    {
                        self.owner = var1;
                        self.team = var1.team;
                    }
                    
                    if ( isdefined( level.ref_12074 ) && isplayer( var1 ) && istrue( var1.should_take_damage ) && isdefined( var9 ) )
                    {
                        var13 = 0;
                        
                        if ( isdefined( var1.showassassinationtargethud ) )
                        {
                            var14 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt( var9 );
                            
                            if ( scripts\engine\utility::array_contains_key( var1.showassassinationtargethud, var14 ) )
                            {
                                var13 = 1;
                            }
                        }
                        
                        if ( var13 )
                        {
                            self.updateteamplunderscore = 1;
                            thread _luidecision::playericonfilter( var1, self.origin, "nospawn", level.getserverroomspawnpoint.get_ai_within_range );
                            thread ref_13580();
                        }
                    }
                    
                    thread get_smoke_grenade_start_pos();
                    return;
                }
                
                break;
        }
    }
}

// Params 0
// Size: 0x5d
function ref_13580()
{
    level endon( "game_ended" );
    var0 = spawn( "script_model", self.origin );
    var0 setmodel( "tag_origin" );
    waitframe();
    var0.ref_14293 = playfxontag( scripts\engine\utility::getfx( "vfx_br3_canister_exp_large_chem" ), var0, "tag_origin" );
    wait 8;
    stopfxontag( scripts\engine\utility::getfx( "vfx_br3_canister_exp_large_chem" ), var0, "tag_origin" );
    var0 delete();
}

// Params 2
// Size: 0xa7
function get_spaced_out_station_names_on_track( var0, var1 )
{
    if ( isdefined( var0 ) )
    {
        var0 endon( "death_or_disconnect" );
        var0 endon( "drop_object" );
    }
    
    self endon( "death" );
    self endon( "explode" );
    
    if ( isdefined( var1 ) )
    {
        wait var1;
    }
    
    self.playerzombiecleanuphud = 1;
    self setscriptablepartstate( "fuse", "fuse_sfx" );
    playfxontag( level._effect[ self.get_teaminquiry_alias.playerzombieaddhudelem ], self, "tag_fx" );
    
    if ( isdefined( var0 ) && isdefined( self.get_teaminquiry_alias.playerzombiecleanupkeybindings ) )
    {
        var0 setscriptablepartstate( "weaponVFXViewmodel", self.get_teaminquiry_alias.playerzombiecleanupkeybindings, 0 );
        var0 setscriptablepartstate( "weaponVFXWorldmodel", self.get_teaminquiry_alias.playerzombiecleanupkeybindings, 0 );
        thread kill_lighter_fx();
        return;
    }
}

// Params 0
// Size: 0x2b
function kill_lighter_fx()
{
    wait 2;
    
    if ( isdefined( self ) )
    {
        self setscriptablepartstate( "weaponVFXViewmodel", "neutral", 0 );
        self setscriptablepartstate( "weaponVFXWorldmodel", "neutral", 0 );
        return;
    }
}

// Params 2
// Size: 0x83
function get_spotlight_goal_node( var0, var1 )
{
    self endon( "death" );
    self endon( "explode" );
    self endon( "pickup" );
    self endon( "cancel_fuse" );
    
    if ( false )
    {
        thread get_start_ang( var0 );
    }
    
    if ( !istrue( var0.usingascender ) && !istrue( var0.ref_140af ) )
    {
        var0 setclientomnvar( "ui_br_gas_can_status", 2 );
    }
    
    var2 = getdvarfloat( "carriableFuseTime", 5 );
    
    if ( istrue( var1 ) )
    {
        var2 += 2.1;
    }
    
    wait var2;
    self.owner = var0;
    self.team = var0.team;
    thread get_smoke_grenade_start_pos();
}

// Params 1
// Size: 0x63
function get_start_ang( var0 )
{
    var1 = var0 scripts\mp\hud_util::createprimaryprogressbar();
    var2 = var0 scripts\mp\hud_util::createprimaryprogressbartext();
    var2 settext( "FUSE LIT" );
    var3 = getdvarfloat( "carriableFuseTime", 5 );
    
    if ( var3 <= 0 )
    {
        var3 = 1;
    }
    
    var1 scripts\mp\hud_util::updatebar( 0, 1 / var3 );
    var0 scripts\engine\utility::ref_143a6( "death", "weapon_fired", "drop_object" );
    var1 scripts\mp\hud_util::destroyelem();
    var2 scripts\mp\hud_util::destroyelem();
}

// Params 0
// Size: 0x23
function get_spawncount_from_groupnames()
{
    self endon( "death" );
    self endon( "explode" );
    
    if ( istrue( self.playerzombiecleanuphud ) )
    {
        waitframe();
        get_spaced_out_station_names_on_track( undefined, undefined );
        return;
    }
}

// Params 2
// Size: 0x42
function get_stealth_breaking_guilty_player_name( var0, var1 )
{
    self endon( "death_or_disconnect" );
    var2 = getcompleteweaponname( var0 );
    self giveandfireoffhand( var2 );
    scripts\common\utility::allow_fire( 0, "carriableGesture" );
    wait var1;
    scripts\common\utility::allow_fire( 1, "carriableGesture" );
    
    if ( self hasweapon( var2 ) )
    {
        self takeweapon( var2 );
        return;
    }
}

// Params 1
// Size: 0x77
function get_spawn_delay( var0 )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "drop_object" );
    var1 = self getgestureanimlength( var0.get_teaminquiry_alias.playerzombiebacktohuman );
    thread get_stealth_breaking_guilty_player_name( var0.get_teaminquiry_alias.playerzombiecleanup, var1 );
    
    if ( isdefined( var0.get_teaminquiry_alias.playerzombieapplyemp ) )
    {
        var2 = var0.get_teaminquiry_alias.playerzombieapplyemp;
    }
    else
    {
        var2 = var2;
    }
    
    thread get_spaced_out_station_names_on_track( var1, self );
    wait 1.75;
}

// Params 1
// Size: 0x75
function get_specific_truck( var0 )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "drop_object" );
    self endon( "weapon_switch_started" );
    self endon( "carriable_ascend" );
    
    for ( ;; )
    {
        self waittill( "fuse_attempt_carriable" );
        
        if ( self getcurrentweapon() == var0.get_teaminquiry_alias.ref_1459b && !self attackbuttonpressed() )
        {
            self disableweaponswitch();
            self enableoffhandweapons();
            thread get_spotlight_goal_node( var0, self );
            get_spawn_delay( var0 );
            self disableoffhandweapons();
            self enableweaponswitch();
            return;
        }
    }
}

// Params 1
// Size: 0xc0
function get_smoke_grenade_start_pos( var0 )
{
    if ( istrue( self.exploded ) )
    {
        return;
    }
    
    self.exploded = 1;
    level endon( "game_ended" );
    self notify( "explode" );
    level notify( "carriable_kill_callout_" + self.origin );
    
    if ( istrue( self.playerzombiecleanuphud ) )
    {
        stopfxontag( level._effect[ self.get_teaminquiry_alias.playerzombieaddhudelem ], self, "tag_fx" );
    }
    
    if ( isdefined( self.carrier ) )
    {
        thread get_station_track_available_time_stamp( ( 0, 0, -90 ), self.carrier );
        wait 0.1;
    }
    
    if ( !istrue( self.updateteamplunderscore ) )
    {
        self [[ self.get_teaminquiry_alias.leader_charge_dialogue ]]( var0 );
    }
    
    self makeunusable();
    self hide();
    self.origin += ( 0, 0, 10000 );
    wait 5;
    self delete();
}

// Params 0
// Size: 0x44
function get_stealth_alert_music_alias()
{
    self endon( "death" );
    self endon( "explode" );
    self endon( "pickup" );
    
    for ( ;; )
    {
        self waittill( "trigger", var0 );
        
        if ( isdefined( var0 ) && isalive( var0 ) && get_sight_dist_for_taccover_check( var0 ) )
        {
            thread get_stay_at_station_time( var0 );
            return;
        }
    }
}

// Params 1
// Size: 0x300
function get_stay_at_station_time( var0 )
{
    self notify( "pickup" );
    level notify( "carriable_kill_callout_" + self.origin );
    var1 = self getlinkedparent();
    
    if ( isdefined( var1 ) )
    {
        self unlink();
    }
    
    self physicslaunchserver( self.origin, ( 0, 0, 0 ) );
    self physicsstopserver();
    self show();
    self hide();
    self linkto( var0, "tag_accessory_right", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    
    if ( isdefined( self.projectile ) )
    {
        self.projectile delete();
    }
    
    self setotherent( var0 );
    self makeunusable();
    self.carrier = var0;
    self.owner = var0;
    self.team = var0.team;
    var0 scripts\mp\equipment::allow_equipment( 0, "carriable" );
    var0.iscarrying = 1;
    var0.ref_1286c = var0 getcurrentweapon();
    var0 giveweapon( self.get_teaminquiry_alias.ref_1459b );
    var0 setweaponammoclip( self.get_teaminquiry_alias.ref_1459b, 1 );
    var0 switchtoweapon( self.get_teaminquiry_alias.ref_1459b );
    thread little_bird_mg_initfx();
    thread carriable_pickup_ladder_drop_check();
    var0 scripts\engine\utility::ref_143a9( "weapon_change", "weapon_taken", "weapon_switch_invalid", "death_or_disconnect", "on_ladder", "super_use_started" );
    
    if ( !isalive( var0 ) || var0 getcurrentweapon() != self.get_teaminquiry_alias.ref_1459b )
    {
        if ( isdefined( var0 ) )
        {
            var0 enableoffhandweapons();
            var0 scripts\mp\equipment::allow_equipment( 1, "carriable" );
            var0.iscarrying = 0;
            var0 takeweapon( self.get_teaminquiry_alias.ref_1459b );
            var0.ref_1286c = undefined;
            var0 notify( "drop_object" );
        }
        
        self.owner = undefined;
        self.carrier = undefined;
        self.team = undefined;
        self setotherent( undefined );
        self unlink();
        self show();
        var2 = anglestoforward( self.angles ) * 40;
        get_station_names_on_track( var2 );
        get_subway_car_available_to_deploy();
        return;
    }
    
    self method_87cd( 1 );
    self method_87c8( 1 );
    var1.get_search_turret_target_player = self;
    
    if ( !isai( var1 ) )
    {
        var1 notifyonplayercommand( "lethal_attempt_carriable", "+frag" );
        var1 notifyonplayercommand( "lethal_attempt_carriable", "+smoke" );
        var1 notifyonplayercommand( "fuse_attempt_carriable", "+speed_throw" );
        
        if ( !var1 isconsoleplayer() )
        {
            var1 notifyonplayercommand( "fuse_attempt_carriable", "+toggleads_throw" );
        }
    }
    
    var1 disableoffhandweapons();
    var3 = var1 scripts\mp\supers::getcurrentsuper();
    
    if ( isdefined( var3 ) )
    {
        if ( var3.staticdata.ref != "super_deadsilence" )
        {
            var4 = var3.staticdata.weapon;
            var5 = var1 getweaponammoclip( var4 );
            var1 scripts\common\utility::allow_supers( 0, "carriable" );
            var1 setweaponammoclip( var4, var5 );
        }
    }
    else
    {
        var1 scripts\common\utility::allow_supers( 0, "carriable" );
    }
    
    var1 allowmelee( 0 );
    var1 allowsupersprint( 0 );
    var1 scripts\common\utility::allow_prone( 0, "carriable" );
    var1.•wrÓÁN=‘AΩi1A{áKhÚ≤Á8(BÖ = 1;
    thread get_successful_vehicle_spawns_from_module( var1 );
    thread get_specific_truck( var1 );
    thread get_target_located( var1, self );
    thread get_target_located( var1, self );
    thread get_stealth_broken_music_alias( var1 );
    thread get_strafe_target_loc( var1 );
    thread get_smallest_cumulative_damage();
    var1 setclientomnvar( "ui_br_gas_can_status", 1 );
}

// Params 1
// Size: 0xbf, Type: bool
function ref_140c1( var0 )
{
    var1 = undefined;
    
    if ( issameweapon( var0 ) )
    {
        if ( nullweapon( var0 ) )
        {
            return false;
        }
        
        foreach ( var3 in level.get_tier_reward_for_total_time )
        {
            if ( var3.ref_1459b == var0 )
            {
                return false;
            }
        }
        
        var1 = var0.basename;
    }
    
    if ( isstring( var0 ) )
    {
        if ( var0 == "none" )
        {
            return false;
        }
        
        foreach ( var3 in level.get_tier_reward_for_total_time )
        {
            if ( var3.ref_1459b.basename == var0 )
            {
                return false;
            }
        }
        
        var1 = var0;
    }
    
    if ( scripts\mp\utility\killstreak::isremotekillstreakweapon( var1 ) )
    {
        return false;
    }
    
    if ( scripts\mp\utility\weapon::iskillstreakweapon( var0 ) )
    {
        return false;
    }
    
    return true;
}

// Params 1
// Size: 0x165, Type: bool
function get_sight_dist_for_taccover_check( var0 )
{
    if ( !isplayer( var0 ) )
    {
        return false;
    }
    
    if ( var0 isonladder() )
    {
        return false;
    }
    
    if ( !var0 scripts\common\utility::is_weapon_allowed() )
    {
        return false;
    }
    
    if ( var0 scripts\mp\supers::issuperinuse() )
    {
        var1 = var0 scripts\mp\supers::getcurrentsuper();
        
        if ( var1.staticdata.ref != "super_deadsilence" )
        {
            return false;
        }
    }
    
    if ( var0 scripts\cp_mp\utility\player_utility::isinvehicle() )
    {
        return false;
    }
    
    if ( istrue( var0.inlaststand ) )
    {
        return false;
    }
    
    if ( istrue( var0.isreviving ) )
    {
        return false;
    }
    
    if ( var0 isskydiving() )
    {
        return false;
    }
    
    if ( istrue( var0.iszombie ) )
    {
        return false;
    }
    
    if ( istrue( var0.isjuggernaut ) )
    {
        if ( isdefined( level.showuseresultsfeedback ) )
        {
            var0 [[ level.showuseresultsfeedback ]]( 16 );
            return false;
        }
    }
    
    if ( isdefined( var0.manuallyjoiningkillstreak ) && var0.manuallyjoiningkillstreak )
    {
        return false;
    }
    
    if ( istrue( var0.iscarrying ) )
    {
        if ( isdefined( level.showuseresultsfeedback ) )
        {
            var0 [[ level.showuseresultsfeedback ]]( 3 );
            return false;
        }
    }
    
    var2 = var0 getcurrentweapon();
    
    if ( isdefined( var2 ) )
    {
        if ( !ref_140c1( var2 ) )
        {
            var0 scripts\mp\hud_message::showerrormessage( "MP/FIELD_UPGRADE_CANNOT_USE" );
            return false;
        }
    }
    
    var3 = var0.changingweapon;
    
    if ( isdefined( var3 ) && var0 isswitchingweapon() )
    {
        if ( !ref_140c1( var3 ) )
        {
            return false;
        }
    }
    
    if ( var0 scripts\cp_mp\utility\inventory_utility::isanymonitoredweaponswitchinprogress() )
    {
        var3 = var0 scripts\cp_mp\utility\inventory_utility::getcurrentmonitoredweaponswitchweapon();
        
        if ( !ref_140c1( var3 ) )
        {
            return false;
        }
    }
    
    if ( var0 scripts\mp\utility\player::isusingremote() )
    {
        return false;
    }
    
    if ( istrue( self.playerzombiecleanuphud ) )
    {
        return false;
    }
    
    if ( istrue( var0.tracking_max_health ) )
    {
        return false;
    }
    
    return true;
}

// Params 1
// Size: 0xbb
function get_successful_vehicle_spawns_from_module( var0 )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "drop_object" );
    var1 = 0;
    var2 = getdvarfloat( "carriableThrowForce", 2250 );
    
    for ( ;; )
    {
        self waittill( "grenade_fire", var3, var4 );
        
        if ( var4 != var0.get_teaminquiry_alias.ref_1459b )
        {
            continue;
        }
        
        if ( isdefined( var3 ) )
        {
            laser_vfx_start_pos( var3 );
        }
        
        self setweaponammoclip( var0.get_teaminquiry_alias.ref_1459b, 0 );
        break;
    }
    
    if ( self issprintsliding() )
    {
        var1 = -12;
        var2 += 200;
    }
    
    var5 = self getplayerangles();
    var5 += ( var1, 0, 0 );
    var5 = ( clamp( var5[ 0 ], -85, 85 ), var5[ 1 ], var5[ 2 ] );
    var6 = anglestoforward( var5 );
    thread get_station_track_available_time_stamp( var0, var6 * var2 );
}

// Params 0
// Size: 0xf
function laser_vfx_start_pos()
{
    self endon( "death" );
    waitframe();
    self delete();
}

// Params 0
// Size: 0x3c
function little_bird_mg_initfx()
{
    self endon( "disconnect" );
    self disableweaponswitch();
    scripts\engine\utility::ref_143a6( "weapon_change", "death", "drop_object" );
    
    if ( istrue( self.usingascender ) || istrue( self.ref_140af ) )
    {
        return;
    }
    
    self enableweaponswitch();
}

// Params 0
// Size: 0x22
function carriable_pickup_ladder_drop_check()
{
    for ( var0 = 0; var0 < 20 ; var0++ )
    {
        if ( self isonladder() )
        {
            self notify( "on_ladder" );
        }
        
        waitframe();
    }
}

// Params 2
// Size: 0x63
function get_target_located( var0, var1 )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "drop_object" );
    thread little_bird_mg_initfx();
    
    for ( ;; )
    {
        self waittill( var1, var2 );
        
        if ( istrue( self.usingascender ) )
        {
            continue;
        }
        
        if ( var2 != var0.get_teaminquiry_alias.ref_1459b )
        {
            wait 0.34;
            break;
        }
    }
    
    thread get_subway_train_hit_damage_multiplier( var0, 0 );
}

// Params 0
// Size: 0x2d
function get_smallest_cumulative_damage()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "drop_object" );
    
    for ( ;; )
    {
        self waittill( "lethal_attempt_carriable" );
        scripts\mp\hud_message::showerrormessage( "MP/FIELD_UPGRADE_CANNOT_USE" );
    }
}

// Params 1
// Size: 0x80
function get_strafe_target_loc()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "drop_object" );
    
    for ( ;; )
    {
        if ( self isskydiving() )
        {
            break;
        }
        
        if ( scripts\mp\supers::issuperinuse() )
        {
            var1 = scripts\mp\supers::getcurrentsuper();
            
            if ( var1.staticdata.ref != "super_deadsilence" )
            {
                break;
            }
        }
        
        if ( scripts\cp_mp\utility\player_utility::isinvehicle( 1 ) )
        {
            break;
        }
        
        if ( self isinexecutionattack() || self isinexecutionvictim() )
        {
            break;
        }
        
        waitframe();
    }
    
    thread get_subway_train_hit_damage_multiplier( <error> );
}

// Params 1
// Size: 0x4b
function get_stealth_broken_music_alias( var0 )
{
    level endon( "game_ended" );
    self endon( "drop_object" );
    self waittill( "death_or_disconnect" );
    var1 = self getplayerangles();
    var1 = ( clamp( var1[ 0 ], -85, 85 ), scripts\engine\utility::absangleclamp180( var1[ 1 ] ), 0 );
    var2 = anglestoforward( var1 );
    var3 = 90;
    thread get_station_track_available_time_stamp( var0, var2 * var3 );
}

// Params 3
// Size: 0x8e
function get_station_names_on_track( var0, var1, var2 )
{
    self.origin_prev = undefined;
    var3 = self;
    
    if ( isdefined( var1 ) && !var1 isonladder() )
    {
        self.origin = var1 gettagorigin( "j_gun" );
        self.angles = var1 gettagangles( "j_gun" );
    }
    
    self dontinterpolate();
    
    if ( istrue( var2 ) )
    {
        self physicslaunchserver( self.origin, var0 * 1.2 );
    }
    else
    {
        self physicslaunchserver( self.origin + 10 * anglestoup( self.angles ), var0 );
    }
    
    function_0441( self.origin, self.origin + vectornormalize( var0 ) * 30, 1000 );
    thread get_target_group();
}

// Params 0
// Size: 0x63
function get_target_group()
{
    self endon( "death" );
    self endon( "pickup" );
    self endon( "explode" );
    var0 = self.origin;
    
    for ( ;; )
    {
        var1 = self.origin - var0;
        var2 = lengthsquared( var1 );
        
        if ( var2 > 225 )
        {
            var1 = vectornormalize( var1 ) * ( sqrt( var2 ) + 6 );
            function_0441( self.origin, self.origin + var1, 1000 );
        }
        
        var0 = self.origin;
        waitframe();
    }
}

// Params 0
// Size: 0x25, Type: bool
function nuke_vault_suicidebomber_internal()
{
    return isalive( self ) && ( scripts\common\vehicle::isvehicle() || isdefined( self.classname ) && self.classname == "script_vehicle" );
}

// Params 1
// Size: 0x24, Type: bool
function get_sight_dist_for_laststand_check( var0 )
{
    if ( isdefined( var0.equipmentref ) && var0.equipmentref == "equip_tac_cover" )
    {
        return false;
    }
    
    return true;
}

// Params 2
// Size: 0xb8
function get_sight_alias( var0, var1 )
{
    self endon( "death" );
    self endon( "explode" );
    self endon( "pickup" );
    self endon( "collision" );
    
    if ( var1 > 1 || var0[ 2 ] < 0.5 )
    {
        wait 2;
    }
    else
    {
        wait 0.5;
    }
    
    if ( !self islinked() )
    {
        var2 = scripts\engine\trace::ray_trace( self.origin, ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] - 10 ), [ self ] );
        var3 = var2[ "entity" ];
        
        if ( isdefined( var3 ) && var3 != self && ( nuke_vault_suicidebomber_internal( var3 ) || var3 method_87c7() ) && get_sight_dist_for_laststand_check( var3 ) )
        {
            self linkto( var3 );
            self method_87c9( 1 );
            self method_87c8( 1 );
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0x51
function get_tag_to_target()
{
    self endon( "death" );
    self endon( "explode" );
    self endon( "pickup" );
    
    for ( ;; )
    {
        self waittill( "collision", var0, var1, var2, var3, var4, var5, var6, var7 );
        
        if ( !self islinked() )
        {
            thread get_sight_alias( var5, var6 );
        }
    }
}

// Params 2
// Size: 0x23
function get_station_track_available_time_stamp( var0, var1 )
{
    self.moverdoesnotkill = 1;
    get_subway_train_hit_damage_multiplier( 1 );
    get_station_names_on_track( var0, var1, 1 );
    get_subway_car_available_to_deploy();
}

// Params 0
// Size: 0xdd
function get_swivel_spawnpoint()
{
    self endon( "death" );
    self endon( "pickup" );
    var0 = [ [ "bounce_large_sfx", 20 ], [ "bounce_medium_sfx", 5 ], [ "bounce_small_sfx", 1 ] ];
    
    while ( isdefined( self ) )
    {
        self waittill( "collision", var1, var2, var3, var4, var5, var6, var7, var8 );
        
        if ( self islinked() )
        {
            continue;
        }
        
        foreach ( var10 in var0 )
        {
            if ( var7 > var10[ 1 ] )
            {
                if ( self getscriptableparthasstate( "sfx", var10[ 0 ] ) )
                {
                    self setscriptablepartstate( "sfx", var10[ 0 ] );
                }
                
                break;
            }
        }
        
        wait 0.125;
        self setscriptablepartstate( "sfx", "disabled" );
    }
}

// Params 2
// Size: 0x119, Type: bool
function get_subway_train_hit_damage_multiplier( var0, var1 )
{
    var2 = 40;
    var3 = 11;
    var4 = 7.1;
    
    if ( !isdefined( var0 ) )
    {
        var0 = 0;
    }
    
    self.droptime = gettime();
    self notify( "dropped" );
    var5 = ( 0, 0, 0 );
    var6 = self.carrier;
    
    if ( isdefined( var6 ) && var6.team != "spectator" )
    {
        var7 = var6.origin;
        var5 = var6.angles;
        var6 notify( "drop_object" );
        var6 setclientomnvar( "ui_br_gas_can_status", 0 );
        
        if ( var6 isonladder() )
        {
            var7 += anglestoforward( ( 0, var5[ 1 ], 0 ) ) * -5;
        }
    }
    else
    {
        var7 = self.start_origin;
    }
    
    var8 = ( 0, var6[ 1 ], 0 );
    var9 = anglestoforward( var8 );
    var7 += ( 0, 0, var4 ) + var5 * var9;
    self.origin = var7;
    self.angles = var6;
    self show();
    var10 = self getlinkedparent();
    
    if ( isdefined( var10 ) )
    {
        self unlink();
    }
    
    get_too_far_dist_sq( var2 );
    self dontinterpolate();
    self.ownerteam = "any";
    
    if ( !var1 )
    {
        var11 = var9 * var3;
        get_station_names_on_track( var11, var7 );
        get_subway_car_available_to_deploy();
    }
    
    thread get_spawncount_from_groupnames();
    return true;
}

// Params 1
// Size: 0x155
function get_too_far_dist_sq( var0 )
{
    if ( isdefined( self.carrier ) )
    {
        self.carrier.iscarrying = undefined;
        self.carrier.get_search_turret_target_player = undefined;
        self setotherent( undefined );
        thread get_total_from_call_count( self.carrier );
        self.carrier scripts\mp\equipment::allow_equipment( 1, "carriable" );
        
        if ( !isai( self.carrier ) )
        {
            self.carrier notifyonplayercommandremove( "lethal_attempt_carriable", "+frag" );
            self.carrier notifyonplayercommandremove( "lethal_attempt_carriable", "+smoke" );
            self.carrier notifyonplayercommandremove( "fuse_attempt_carriable", "+speed_throw" );
            
            if ( !self.carrier isconsoleplayer() )
            {
                self.carrier notifyonplayercommandremove( "fuse_attempt_carriable", "+toggleads_throw" );
            }
        }
        
        self.carrier enableoffhandweapons();
        
        if ( self.carrier scripts\mp\supers::issuperinuse() )
        {
            var1 = self.carrier scripts\mp\supers::getcurrentsuper();
            
            if ( var1.staticdata.ref != "super_deadsilence" )
            {
                self.carrier scripts\common\utility::allow_supers( 1, "carriable" );
            }
        }
        else
        {
            self.carrier scripts\common\utility::allow_supers( 1, "carriable" );
        }
        
        self.carrier allowmelee( 1 );
        self.carrier allowsupersprint( 1 );
        
        if ( istrue( self.carrier.•wrÓÁN=‘AΩi1A{áKhÚ≤Á8(BÖ ) )
        {
            self.carrier scripts\common\utility::allow_prone( 1, "carriable" );
            self.carrier.•wrÓÁN=‘AΩi1A{áKhÚ≤Á8(BÖ = undefined;
        }
        
        self.carrier = undefined;
        return;
    }
}

// Params 1
// Size: 0xc6
function get_total_from_call_count( var0 )
{
    self endon( "death_or_disconnect" );
    
    foreach ( var2 in level.get_tier_reward_for_total_time )
    {
        if ( self getcurrentweapon() == var2.ref_1459b )
        {
            if ( self getweaponammoclip( var2.ref_1459b ) == 0 )
            {
                wait 0.6;
                
                if ( isdefined( self.ref_1286c ) )
                {
                    self switchtoweaponimmediate( self.ref_1286c );
                }
            }
            else
            {
                if ( isdefined( var0 ) )
                {
                    wait var0;
                }
                
                if ( isdefined( self.ref_1286c ) && !istrue( self.ref_140af ) )
                {
                    self switchtoweaponimmediate( self.ref_1286c );
                }
            }
            
            self takeweapon( var2.ref_1459b );
            break;
        }
        
        if ( self hasweapon( var2.ref_1459b ) )
        {
            self takeweapon( var2.ref_1459b );
            break;
        }
    }
}

// Params 2
// Size: 0x69
function isbossheli( var0, var1 )
{
    if ( !isdefined( level.ref_1403d ) )
    {
        return;
    }
    
    var2 = var1 * var1;
    
    foreach ( var4 in level.ref_1403d )
    {
        if ( isdefined( var4 ) && !istrue( var4.õ©âı3]Õ Øç6¨‹WÉ ) && !var4 islinked() && distance2dsquared( var4.origin, var0 ) > var2 )
        {
            thread carriable_fuse_cleanup();
        }
    }
}

// Params 0
// Size: 0x3f
function carriable_fuse_cleanup()
{
    self.õ©âı3]Õ Øç6¨‹WÉ = 1;
    self endon( "death" );
    self endon( "explode" );
    self endon( "pickup" );
    self endon( "cancel_fuse" );
    thread get_spaced_out_station_names_on_track();
    var0 = getdvarfloat( "carriableFuseTime", 5 );
    wait var0;
    thread get_smoke_grenade_start_pos();
}

// Params 0
// Size: 0x33
function get_starting_ai_per_site()
{
    self endon( "death" );
    self endon( "explode" );
    self endon( "pickup" );
    var0 = getdvarfloat( "scr_br_carriable_inactive_delete_time", 300 );
    
    if ( var0 == 0 )
    {
        return;
    }
    
    wait var0;
    thread carriable_fuse_cleanup();
}

// Params 1
// Size: 0x9e
function get_silencedshot_alias( var0 )
{
    var1 = self.origin + ( 0, 0, -96 );
    var2 = physicstrace( self.origin, var1 );
    var3 = var2 == var1;
    var4 = "detonateGround";
    
    if ( var3 )
    {
        var4 = "detonateAir";
    }
    
    waitframe();
    var5 = easepower( "br_carriable_explosion_gasoline", var2, ( 0, 0, 0 ) );
    var5 setscriptablepartstate( "carrible_explode_base", var4 );
    thread hanging_crate_think( var5 );
    self radiusdamage( self.origin, level.get_station_controller_struct.plundertotal, level.get_station_controller_struct.plunderstructreplenish, level.get_station_controller_struct.plundertimer, self, "MOD_EXPLOSIVE", "gasoline_can_mp" );
}

// Params 0
// Size: 0x205
function get_silo_thrust_spawnpoint()
{
    var0 = 2;
    var1 = self.origin + ( 0, 0, -96 );
    var2 = physicstrace( self.origin, var1 );
    var3 = var2 == var1;
    var4 = "detonateGround";
    
    if ( var3 )
    {
        var4 = "detonateAir";
    }
    
    var5 = easepower( "br_carriable_explosion_propane", self.origin, self.angles );
    var5 setscriptablepartstate( "carrible_explode_base", var4 );
    thread hanging_crate_think( var5 );
    var6 = spawn( "script_origin", self.origin );
    var6.angles = self.angles;
    var6.owner = self.owner;
    var6.team = self.team;
    var6.script_noteworthy = "fake_molotov";
    var6.weapon_name = "gas_can_mp";
    
    if ( isplayer( self.owner ) )
    {
        self radiusdamage( var6.origin, 250, 400, 1, self.owner, "MOD_EXPLOSIVE", "c4_mp_p" );
    }
    else
    {
        self radiusdamage( var6.origin, 250, 400, 1, undefined, "MOD_EXPLOSIVE", "c4_mp_p" );
    }
    
    var7 = "gas_can_fire_spout";
    var8 = 3;
    level.get_target_spotted_alias = scripts\engine\utility::array_removedead( level.get_target_spotted_alias );
    var9 = 0;
    var10 = relic_steelballs_slide( var8 );
    
    while ( var9 < var8 )
    {
        var11 = magicgrenademanual( var7, self.origin + var10[ var9 ] * 0.02, var10[ var9 ], 5 );
        level.get_target_spotted_alias = scripts\engine\utility::array_add( level.get_target_spotted_alias, var11 );
        thread played_fulton_crate_anim( var11 );
        var9++;
    }
    
LOC_0000017b:
    if ( var2 != var1 )
    {
        var6 scripts\mp\equipment\molotov::molotov_simulate_impact( var6, var2, ( 0, 0, 0 ), undefined, ( 0, 0, 0 ), gettime() );
    }
    else if ( level.get_target_spotted_alias.size < 12 )
    {
        var11 = magicgrenademanual( var7, self.origin + ( 0, 0, -30 ), ( 0, 0, -200 ), 5 );
        level.get_target_spotted_alias = scripts\engine\utility::array_add( level.get_target_spotted_alias, var11 );
        thread played_fulton_crate_anim( var11 );
    }
    
    thread hanging_crate_think( var6 );
}

// Params 1
// Size: 0x92
function relic_steelballs_slide( var0 )
{
    var1 = [];
    
    if ( var0 <= 0 )
    {
        return var1;
    }
    
    var2 = 360 / var0;
    var3 = randomfloatrange( -1 * var2, var2 );
    
    for ( var4 = 0; var4 < var0 ; var4++ )
    {
        var5 = randomfloatrange( -0.5 * var2, 0.5 * var2 );
        var6 = var4 * var2 + var5 + var3;
        var7 = vectornormalize( rotatepointaroundvector( ( 0, 0, 1 ), ( 0, 0.7, 0.7 ), var6 ) );
        var8 = randomfloatrange( 250, 400 );
        var1 = var7 * var8;
    }
    
    return var1;
}

// Params 1
// Size: 0x58
function played_fulton_crate_anim( var0 )
{
    self endon( "death" );
    self endon( "missile_dest_failed" );
    self waittill( "missile_stuck", var1 );
    var0 scripts\mp\equipment\molotov::molotov_simulate_impact( var0, self.origin, var0.angles, undefined, ( 0, 0, 0 ), gettime() );
    level.get_target_spotted_alias = scripts\engine\utility::array_remove( level.get_target_spotted_alias, self );
    self delete();
}

// Params 1
// Size: 0x2e
function hanging_crate_think( var0 )
{
    self endon( "death" );
    
    if ( !isdefined( var0 ) )
    {
        var0 = 5;
    }
    
    wait var0;
    
    if ( isdefined( self ) )
    {
        if ( isent( self ) )
        {
            self delete();
            return;
        }
        
        self freescriptable();
        return;
    }
}

// Params 3
// Size: 0x81
function lootleadermarkstrongsize( var0, var1, var2 )
{
    if ( scripts\cp_mp\gasmask::hasgasmask( var0 ) )
    {
        thread ref_11e4e();
        
        if ( isdefined( level.plunderrepositoryrestricted ) )
        {
            var0 [[ level.plunderrepositoryrestricted ]]( "carriable_neurotoxin" );
        }
        else if ( !istrue( var0.gasmaskequipped ) )
        {
            var0 notify( "toggle_gasmask" );
        }
        
        var0 scripts\cp_mp\gasmask::processdamage( var2 );
        return;
    }
    
    var0 dodamage( var2, var0.origin, var1, undefined, "MOD_TRIGGER_HURT", "danger_circle_br" );
    
    if ( var0 scripts\mp\gametypes\br_public::hasarmor() )
    {
        var0 scripts\mp\gametypes\br_public::damagearmor( var2 );
    }
    
    var0 scripts\mp\gametypes\br_circle::ref_13e18();
}

// Params 0
// Size: 0x87
function ref_11e4e()
{
    var0 = self;
    var1 = 1100;
    
    if ( !isdefined( var0.trackchallengetimers ) )
    {
        var0.trackchallengetimers = gettime();
        
        while ( !istrue( var0.gasmaskequipped ) || gettime() < var0.trackchallengetimers + var1 )
        {
            wait 0.5;
        }
        
        var0.trackchallengetimers = undefined;
        
        if ( isdefined( level.plunderrepositories ) )
        {
            var0 [[ level.plunderrepositories ]]( "carriable_neurotoxin" );
            return;
        }
        
        if ( istrue( var0.gasmaskequipped ) )
        {
            var0 notify( "toggle_gasmask" );
        }
        
        return;
    }
    
    var0.trackchallengetimers = gettime();
}

// Params 1
// Size: 0x309, Type: bool
function get_surface_point( var0 )
{
    self endon( "death_or_disconnect" );
    self endon( "ascender_solo_cancel" );
    self endon( "last_stand_start" );
    
    if ( level.ascendstructs[ var0.target ].dir == 0 )
    {
        get_subway_train_hit_damage_multiplier( self.get_search_turret_target_player, 0 );
        scripts\engine\utility::waittill_notify_or_timeout( "weapon_change", 1 );
        return false;
    }
    
    thread scripts\mp\utility\infilexfil::infil_player_rig_updated( "player", self.origin, self.angles );
    self.player_rig hide();
    var1 = spawnstruct();
    var1.molotov_cleanup_pool = self.get_search_turret_target_player;
    var1.player = self;
    var1.tracknonoobplayerlocation = var0;
    var1.car_collision = level.ascendstructs[ var0.target ];
    self.shouldskiplaststand = 1;
    var1.car_collision.waittill_player_opens_tac_map = gettime();
    var2 = scripts\engine\utility::drop_to_ground( var1.car_collision.origin, 100, -250 );
    var1.canseedangercircleui = spawn( "script_model", var2 );
    var1.canseedangercircleui setmodel( "tag_origin" );
    level.initpostmain++;
    
    if ( self getstance() != "stand" )
    {
        self setstance( "stand" );
    }
    
    scripts\common\utility::allow_execution_victim( 0 );
    scripts\common\utility::allow_usability( 0 );
    scripts\common\utility::allow_melee( 0 );
    scripts\common\utility::allow_ads( 0 );
    scripts\common\utility::allow_fire( 0 );
    
    if ( istrue( self.isjuggernaut ) )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "juggernaut", "canUseWeaponPickups" ) )
        {
            var3 = self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "juggernaut", "canUseWeaponPickups" ) ]]();
            
            if ( istrue( var3 ) )
            {
                self disableweaponswitch();
            }
        }
    }
    else
    {
        scripts\common\utility::allow_killstreaks( 0 );
        self disableweaponswitch();
    }
    
    var1.canseedangercircleui scripts\cp_mp\ent_manager::registerspawncount( 2 );
    var1.car_collision.inuse = 1;
    self.usingascender = 1;
    var4 = anglestoforward( var1.car_collision.angles );
    var5 = anglestoforward( self.angles );
    var6 = vectordot( var5, var4 );
    var7 = 0;
    
    if ( var6 < 0.5 )
    {
        var8 = vectorcross( var5, var4 );
        
        if ( var8[ 2 ] < 0 )
        {
            var7 = 120;
        }
        else
        {
            var7 = 240;
        }
    }
    
    var9 = ( 0, var7, 0 );
    var1.canseedangercircleui dontinterpolate();
    var1.canseedangercircleui.origin = var2;
    var1.canseedangercircleui.angles = var1.car_collision.angles + var9;
    var1.cansnapcamera = spawn( "script_model", var1.car_collision.origin );
    var1.cansnapcamera setmodel( "misc_wm_ascender_ch3" );
    var1.cansnapcamera hide();
    var1.cansolospawn = spawn( "script_model", var1.car_collision.origin );
    var1.cansolospawn setmodel( "misc_wm_ascender_ch3" );
    var1.cansolospawn hide();
    self setclientomnvar( "ui_br_gas_can_status", 0 );
    thread ref_1250b();
    thread get_target_retreat_struct();
    self notify( "carriable_ascend" );
    ref_123d4( var1 );
    var1.ref_142d4 = var1.player.player_rig gettagorigin( "tag_weapon" );
    thread cleanupascenduse();
    
    if ( isdefined( var1.molotov_cleanup_pool ) )
    {
        thread get_shootable_scriptables();
    }
    
    return true;
}

// Params 0
// Size: 0xe1
function get_shootable_scriptables()
{
    if ( isdefined( self.player ) )
    {
        self.cansolospawn showtoplayer( self.player );
    }
    
    carriable_physics_launch_drop();
    var0 = distance( self.car_collision.ascendstructend.origin, self.car_collision.origin );
    var1 = var0 / 200;
    var2 = scripts\cp_mp\auto_ascender::registered_checkpoint_funcs() * var1;
    var3 = scripts\cp_mp\auto_ascender::registereventcallback() * var1;
    self.canseedangercircleui moveto( self.car_collision.ascendstructend.origin, var1, var2, var3 );
    GscBinSkip4( 0x35 );
    // Unknown operator ( 0x35, iw8, PC )
}

// Params 0
// Size: 0xa7
function get_showing_bomb_wire_pair_to_player()
{
    playfx( scripts\engine\utility::getfx( "vfx_br3_rope_fire" ), self.canseedangercircleui.origin + ( 0, 0, 0 ), anglestoup( self.canseedangercircleui.angles ), anglestoforward( self.canseedangercircleui.angles ) );
    wait 1;
    
    for ( ;; )
    {
        wait randomfloatrange( 0.05, 1 );
        
        if ( isdefined( self ) && isdefined( self.canseedangercircleui ) )
        {
            playfx( scripts\engine\utility::getfx( "vfx_br3_rope_fire" ), self.canseedangercircleui.origin + ( 0, 0, randomfloatrange( -70, 0 ) ), anglestoup( self.canseedangercircleui.angles ), anglestoforward( self.canseedangercircleui.angles ) );
        }
    }
}

// Params 0
// Size: 0xf2
function carriable_physics_launch_drop()
{
    self.molotov_crate_player_at_max_ammo = spawn( "script_model", self.ref_142d4 );
    self.molotov_crate_player_at_max_ammo.angles = ( 0, self.molotov_cleanup_pool.angles[ 1 ], 0 );
    self.molotov_crate_player_at_max_ammo setmodel( self.molotov_cleanup_pool.get_teaminquiry_alias.modelname );
    self.molotov_crate_player_at_max_ammo setcandamage( 1 );
    self.molotov_crate_player_at_max_ammo.health = 999999;
    self.molotov_crate_player_at_max_ammo.ownerteam = "any";
    self.molotov_crate_player_at_max_ammo.get_teaminquiry_alias = self.molotov_cleanup_pool.get_teaminquiry_alias;
    self.molotov_crate_player_at_max_ammo.owner = self.molotov_cleanup_pool.owner;
    self.molotov_crate_player_at_max_ammo.playerzombiecleanuphud = 1;
    thread get_sight_dist_for_vehicle_check();
    thread get_spawncount_from_groupnames();
    self.molotov_crate_player_at_max_ammo linkto( self.canseedangercircleui );
    get_too_far_dist_sq( self.molotov_cleanup_pool );
    self.molotov_cleanup_pool delete();
    thread capsule_contents();
}

// Params 0
// Size: 0x4dd
function ref_123d4()
{
    self.player endon( "death_or_disconnect" );
    self.player endon( "ascender_solo_cancel" );
    self.player endon( "last_stand_start" );
    self.cansnapcamera.animname = "device";
    self.cansnapcamera scripts\common\anim::setanimtree();
    self.cansolospawn.animname = "device";
    self.cansolospawn scripts\common\anim::setanimtree();
    var0 = rotatevector( ( -32.415, 0, 0 ), self.canseedangercircleui.angles );
    var1 = 0.4;
    self.Çf¿Cá–‹{ ±É53Cá® = self.player.origin;
    self.player.player_rig moveto( scripts\engine\utility::drop_to_ground( self.canseedangercircleui.origin + var0, 100, -250 ), var1, 0.1, 0.1 );
    var2 = vectornormalize( var0 * -1 );
    self.ì®¡N ,7∆≤7åÉ∆,º¨NÖπ;cYn = self.player.angles;
    var3 = scripts\cp_mp\auto_ascender::vectortoanglessafe( var2, ( 0, 0, 1 ) );
    self.player.player_rig rotateto( var3, var1, 0.1, 0.1 );
    
    if ( istrue( self.molotov_cleanup_pool.playerzombiecleanuphud ) )
    {
        self.molotov_cleanup_pool notify( "cancel_fuse" );
        wait var1;
    }
    else
    {
        self.player enableoffhandweapons();
        get_spawn_delay( self.player, self.molotov_cleanup_pool );
        self.molotov_cleanup_pool.playerzombiecleanuphud = 1;
        self.player disableoffhandweapons();
        
        if ( isdefined( self.molotov_cleanup_pool ) )
        {
            thread get_spotlight_goal_node( self.molotov_cleanup_pool, self.player );
            
            if ( isdefined( self.car_collision.chopperexfil_sfx_before_sh070 ) )
            {
                if ( self.car_collision.chopperexfil_sfx_before_sh070.health <= 0 )
                {
                    return 1;
                }
            }
            else if ( isdefined( self.car_collision.type ) && self.car_collision.type == "scriptable_skyhook_placed" )
            {
                if ( self.car_collision getscriptablepartstate( "skyhook" ) == "broken" )
                {
                    return 1;
                }
            }
        }
    }
    
    if ( !istrue( self.isjuggernaut ) )
    {
        self.player disableoffhandweapons();
    }
    
    scripted_laser_func( self.player );
    self.cansolospawn show();
    self.cansolospawn hidefromplayer( self.player );
    self.cansnapcamera show();
    self.cansnapcamera showonlytoplayer( self.player );
    self.cansnapcamera linkto( self.player.player_rig, "tag_accessory_right", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    self.cansolospawn linkto( self.canseedangercircleui, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    self.player.player_rig linkto( self.canseedangercircleui, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    self.player.player_rig showonlytoplayer( self.player );
    var4 = self.player.player_rig gettagorigin( "tag_weapon" );
    var5 = self.player.player_rig gettagangles( "tag_weapon" );
    self.molotov_clear_fx = spawn( "script_model", var4 );
    self.molotov_clear_fx.angles = var5;
    self.molotov_clear_fx setmodel( self.molotov_cleanup_pool.get_teaminquiry_alias.modelname );
    self.molotov_clear_fx showonlytoplayer( self.player );
    self.molotov_clear_fx.get_teaminquiry_alias = self.molotov_cleanup_pool.get_teaminquiry_alias;
    self.molotov_clear_fx.owner = self.molotov_cleanup_pool.owner;
    self.molotov_clear_fx.playerzombiecleanuphud = 1;
    self.molotov_clear_fx linkto( self.player.player_rig, "tag_weapon" );
    thread get_spawncount_from_groupnames();
    self.canseedangercircleui scripts\common\anim::anim_first_frame_solo( self.player.player_rig, "carriable_ascender_attach" );
    self.canseedangercircleui thread scripts\mp\anim::anim_player_solo( self.player, self.player.player_rig, "carriable_ascender_attach" );
    self.canseedangercircleui thread scripts\common\anim::anim_single_solo( self.cansolospawn, "carriable_ascender_device_attach" );
    var6 = getanimlength( level.scr_anim[ "player" ][ "carriable_ascender_attach" ] );
    wait var6;
    
    if ( isdefined( self.molotov_cleanup_pool ) )
    {
        if ( isdefined( self.car_collision.chopperexfil_sfx_before_sh070 ) )
        {
            if ( self.car_collision.chopperexfil_sfx_before_sh070.health <= 0 )
            {
                return;
            }
        }
        else if ( isdefined( self.car_collision.àı¡	B´8áî`?"] ) )
        {
            if ( self.car_collision.àı¡	B´8áî`?"].ä-∑c
øBc[◊˙ÎÕÏ <= 0 )
            {
                return;
            }
        }
        else if ( isdefined( self.car_collision.type ) && self.car_collision.type == "scriptable_skyhook_placed" )
        {
            if ( self.car_collision getscriptablepartstate( "skyhook" ) == "broken" )
            {
                return;
            }
        }
    }
    
    self.player takeweapon( self.player.currentweapon );
    self.player switchtoweaponimmediate( self.player.ref_1286c );
    self.player notify( "ascend_solo_complete" );
    self.player notify( "drop_object" );
}

// Params 0
// Size: 0xa7
function ref_1250b()
{
    level endon( "game_ended" );
    self.player endon( "ascend_complete" );
    self.player endon( "ascend_solo_complete" );
    self.player endon( "ascender_cancel" );
    self.player scripts\engine\utility::ref_143a5( "death_or_disconnect", "last_stand_start" );
    
    if ( isdefined( self.player ) )
    {
        self.player stopanimscriptsceneevent();
    }
    
    thread cleanupascenduse();
    thread handleteamvisibility();
    
    if ( isdefined( self.molotov_cleanup_pool ) )
    {
        thread get_subway_train_hit_damage_multiplier( self.molotov_cleanup_pool );
        
        if ( istrue( self.molotov_cleanup_pool.playerzombiecleanuphud ) )
        {
            thread get_spotlight_goal_node( self.molotov_cleanup_pool );
        }
    }
    
    if ( isdefined( self.player ) )
    {
        self.player notify( "ascender_cancel" );
        return;
    }
}

// Params 0
// Size: 0x68
function get_target_retreat_struct()
{
    level endon( "game_ended" );
    self.player endon( "ascend_complete" );
    self.player endon( "ascend_solo_complete" );
    self.player endon( "ascender_cancel" );
    self.molotov_cleanup_pool waittill( "explode" );
    
    if ( isdefined( self.player ) )
    {
        self.player stopanimscriptsceneevent();
    }
    
    cleanupascenduse();
    handleteamvisibility();
    
    if ( isdefined( self.player ) )
    {
        self.player notify( "ascender_cancel" );
        return;
    }
}

// Params 0
// Size: 0x5f
function capsule_contents()
{
    level endon( "game_ended" );
    self.molotov_crate_player_at_max_ammo waittill( "explode" );
    self.car_collision.inuse = 0;
    
    if ( isdefined( self.car_collision.ref_134cb ) && istrue( self.car_collision.ref_134cb.inuse ) )
    {
        self.car_collision.ref_134cb.inuse = 0;
    }
    
    handleteamvisibility();
}

// Params 0
// Size: 0x23e
function cleanupascenduse()
{
    self.car_collision.inuse = 0;
    
    if ( isdefined( self.car_collision.ref_134cb ) && istrue( self.car_collision.ref_134cb.inuse ) )
    {
        self.car_collision.ref_134cb.inuse = 0;
    }
    
    if ( isdefined( self.player ) && istrue( self.player.usingascender ) )
    {
        self.player.usingascender = 0;
        self.player.waittill_player_opens_scavenger_cache = gettime();
        self.player scripts\common\utility::allow_usability( 1 );
        self.player.shouldskiplaststand = undefined;
        self.player scripts\common\utility::allow_execution_victim( 1 );
        self.player scripts\common\utility::allow_melee( 1 );
        self.player scripts\common\utility::allow_ads( 1 );
        self.player scripts\common\utility::allow_fire( 1 );
        
        if ( istrue( self.player.isjuggernaut ) )
        {
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "juggernaut", "canUseWeaponPickups" ) )
            {
                var0 = self.player [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "juggernaut", "canUseWeaponPickups" ) ]]();
                
                if ( istrue( var0 ) )
                {
                    self.player enableweaponswitch();
                }
            }
        }
        else if ( !istrue( self.player.inlaststand ) )
        {
            self.player enableoffhandweapons();
            self.player enableweaponswitch();
            self.player scripts\common\utility::allow_killstreaks( 1 );
        }
        else
        {
            self.player thread scripts\cp_mp\auto_ascender::watch_for_ashes_achievement();
        }
        
        self.player.player_rig unlink();
        self.player.get_search_turret_target_player = undefined;
    }
    
    if ( isdefined( self.cansnapcamera ) )
    {
        self.cansnapcamera unlink();
        self.cansnapcamera delete();
        self.cansnapcamera = undefined;
    }
    
    if ( isdefined( self.molotov_clear_fx ) )
    {
        self.molotov_clear_fx delete();
        self.molotov_clear_fx = undefined;
    }
    
    wait 0.2;
    
    if ( isdefined( self.player ) )
    {
        var1 = 0.4;
        self.player.player_rig moveto( self.Çf¿Cá–‹{ ±É53Cá® + ( 0, 0, 75 ), var1, 0.1, 0.1 );
        self.player.player_rig rotateto( self.ì®¡N ,7∆≤7åÉ∆,º¨NÖπ;cYn, var1, 0.1, 0.1 );
        wait var1;
        
        if ( !self.player hasweapon( "iw8_gunless_infil" ) )
        {
            self.player.gunnlessweapon = undefined;
        }
        
        self.player thread scripts\mp\utility\infilexfil::takegunless();
        self.player notify( "remove_rig" );
        return;
    }
}

// Params 0
// Size: 0x42
function handleteamvisibility()
{
    if ( isdefined( self.cansolospawn ) )
    {
        self.cansolospawn unlink();
        self.cansolospawn delete();
    }
    
    if ( isdefined( self.canseedangercircleui ) )
    {
        self.canseedangercircleui scripts\cp_mp\ent_manager::deregisterspawn();
        self.canseedangercircleui delete();
        level.initpostmain--;
        return;
    }
}

// Params 0
// Size: 0x6c
function ref_119e2()
{
    self.canseedangercircleui endon( "death" );
    self.canseedangercircleui endon( "ascender_solo_loop_done" );
    var0 = "ascender_ext_up_loop";
    var1 = getanimlength( level.scr_anim[ "player" ][ var0 ] );
    
    for ( ;; )
    {
        if ( !isdefined( self.canseedangercircleui ) )
        {
            break;
        }
        
        self.canseedangercircleui scripts\common\anim::anim_single_solo( self.cansolospawn, var0 + "_wm" );
        
        if ( !isdefined( var1 ) || var1 == 0 )
        {
            break;
        }
        
        wait var1;
    }
}

// Params 0
// Size: 0x5a
function scripted_laser_func()
{
    self endon( "death_or_disconnect" );
    
    if ( isdefined( self.gunnlessweapon ) )
    {
        return;
    }
    
    var0 = getcompleteweaponname( "iw8_gunless_infil" );
    scripts\cp_mp\utility\inventory_utility::_giveweapon( var0, undefined, undefined, 1 );
    
    if ( !scripts\common\utility::is_script_weapon_switch_allowed() )
    {
        scripts\common\utility::allow_script_weapon_switch( 1 );
    }
    
    if ( scripts\cp_mp\utility\inventory_utility::isanymonitoredweaponswitchinprogress() )
    {
        self clearhighpriorityweapon( scripts\cp_mp\utility\inventory_utility::getcurrentmonitoredweaponswitchweapon() );
    }
    
    self switchtoweaponimmediate( var0 );
    self.gunnlessweapon = var0;
    scripts\common\utility::allow_script_weapon_switch( 0 );
}

// Params 1
// Size: 0x351, Type: bool
function carriable_useskyhook( var0 )
{
    self endon( "death_or_disconnect" );
    self endon( "ascender_solo_cancel" );
    self endon( "last_stand_start" );
    thread scripts\mp\utility\infilexfil::infil_player_rig_updated( "player", self.origin, self.angles );
    self.player_rig hide();
    var1 = spawnstruct();
    var1.molotov_cleanup_pool = self.get_search_turret_target_player;
    var1.player = self;
    var1.tracknonoobplayerlocation = var0;
    var1.car_collision = var0;
    self.shouldskiplaststand = 1;
    var1.car_collision.waittill_player_opens_tac_map = gettime();
    var2 = scripts\engine\utility::drop_to_ground( var1.car_collision.origin, 100, -250 );
    var1.canseedangercircleui = spawn( "script_model", var2 );
    var1.canseedangercircleui setmodel( "tag_origin" );
    level.initpostmain++;
    
    if ( self getstance() != "stand" )
    {
        self setstance( "stand" );
    }
    
    scripts\common\utility::allow_execution_victim( 0 );
    scripts\common\utility::allow_usability( 0 );
    scripts\common\utility::allow_melee( 0 );
    scripts\common\utility::allow_ads( 0 );
    scripts\common\utility::allow_fire( 0 );
    
    if ( istrue( self.isjuggernaut ) )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "juggernaut", "canUseWeaponPickups" ) )
        {
            var3 = self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "juggernaut", "canUseWeaponPickups" ) ]]();
            
            if ( istrue( var3 ) )
            {
                self disableweaponswitch();
            }
        }
    }
    else
    {
        scripts\common\utility::allow_killstreaks( 0 );
        self disableweaponswitch();
    }
    
    var1.canseedangercircleui scripts\cp_mp\ent_manager::registerspawncount( 2 );
    var1.car_collision.inuse = 1;
    self.usingascender = 1;
    var4 = anglestoforward( var1.car_collision.angles );
    var5 = anglestoforward( self.angles );
    var6 = vectordot( var5, var4 );
    var7 = 0;
    
    if ( var6 < 0.5 )
    {
        var8 = vectorcross( var5, var4 );
        
        if ( var8[ 2 ] < 0 )
        {
            var7 = 120;
        }
        else
        {
            var7 = 240;
        }
    }
    
    var9 = ( 0, var7, 0 );
    var1.canseedangercircleui dontinterpolate();
    var1.canseedangercircleui.origin = var2;
    var1.canseedangercircleui.angles = var1.car_collision.angles + var9;
    var1.cansnapcamera = spawn( "script_model", var1.car_collision.origin );
    var1.cansnapcamera setmodel( "misc_wm_ascender_ch3" );
    var1.cansnapcamera hide();
    var1.cansolospawn = spawn( "script_model", var1.car_collision.origin );
    var1.cansolospawn setmodel( "misc_wm_ascender_ch3" );
    var1.cansolospawn hide();
    self setclientomnvar( "ui_br_gas_can_status", 0 );
    thread playerascendskyhookplacedeathlistener();
    thread carriableascendskyhookplacedeathlistener();
    self notify( "carriable_ascend" );
    var10 = anglestoforward( self getplayerangles() );
    ref_123d4( var1 );
    var1.ref_142d4 = var1.player.player_rig gettagorigin( "tag_weapon" );
    thread cleanupascendskyhookuse();
    
    if ( isdefined( var1.molotov_cleanup_pool ) )
    {
        if ( isdefined( var1.car_collision.chopperexfil_sfx_before_sh070 ) )
        {
            if ( var1.car_collision.chopperexfil_sfx_before_sh070.health <= 0 )
            {
                return true;
            }
        }
        else if ( isdefined( var1.car_collision.àı¡	B´8áî`?"] ) )
        {
            if ( var1.car_collision.àı¡	B´8áî`?"].ä-∑c
øBc[◊˙ÎÕÏ <= 0 )
            {
                return true;
            }
        }
        else if ( var1.car_collision getscriptablepartstate( "skyhook" ) == "broken" )
        {
            return true;
        }
    }
    
    thread carriable_ascend_skyhook( var1 );
    return true;
}

// Params 1
// Size: 0x15c
function carriable_ascend_skyhook( var0 )
{
    if ( isdefined( self.car_collision.àı¡	B´8áî`?"] ) )
    {
        self.car_collision.àı¡	B´8áî`?"] endon( "death" );
    }
    else
    {
        self.car_collision endon( "balloon_destroyed" );
    }
    
    thread balloon_death_watcher();
    
    if ( isdefined( self.player ) )
    {
        self.cansolospawn showtoplayer( self.player );
    }
    
    self.car_collision.inuse = 1;
    self.player.ref_140af = 1;
    attach_carriable_to_ascender_skyhook();
    self.player.ref_140af = undefined;
    var1 = 2.33333;
    self.canseedangercircleui moveto( self.car_collision.origin + ( 0, 0, 3500 ), var1, 0.5, 0 );
    thread fake_fuse_watcher();
    wait var1;
    self.car_collision notify( "balloon_destroyed_by_carriable" );
    
    if ( isdefined( self.molotov_crate_player_at_max_ammo ) )
    {
        thread get_smoke_grenade_start_pos( self.molotov_crate_player_at_max_ammo );
        
        if ( isdefined( self.car_collision.chopperexfil_sfx_before_sh070 ) )
        {
            self.car_collision.chopperexfil_sfx_before_sh070 dodamage( 999999, self.molotov_crate_player_at_max_ammo.origin );
        }
        else if ( isdefined( self.car_collision.àı¡	B´8áî`?"] ) )
        {
            self.car_collision.àı¡	B´8áî`?"] dodamage( self.car_collision.àı¡	B´8áî`?"].ä-∑c
øBc[◊˙ÎÕÏ + 1, self.molotov_crate_player_at_max_ammo.origin );
        }
        else
        {
            self.car_collision scripts\mp\gametypes\br_skyhook::balloon_placed_destroyed();
        }
    }
    
    handleteamvisibility();
}

// Params 0
// Size: 0xba
function balloon_death_watcher()
{
    self.car_collision endon( "balloon_destroyed_by_carriable" );
    
    if ( isdefined( self.car_collision.àı¡	B´8áî`?"] ) )
    {
        self.car_collision.àı¡	B´8áî`?"] waittill( "death" );
    }
    else
    {
        self.car_collision waittill( "balloon_destroyed" );
    }
    
    self.molotov_crate_player_at_max_ammo setscriptablepartstate( "fuse", "fuse_sfx" );
    
    if ( isdefined( self.molotov_crate_player_at_max_ammo ) )
    {
        self.molotov_crate_player_at_max_ammo unlink();
        var0 = ( randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ) );
        var1 = ( randomfloatrange( -100, 100 ), randomfloatrange( -100, 100 ), randomfloatrange( -100, 100 ) );
        self.molotov_crate_player_at_max_ammo physics_takecontrol( 1, self.molotov_crate_player_at_max_ammo.origin + var0, var1 );
        thread explode_fake_carriable_delayed();
    }
    
    handleteamvisibility();
}

// Params 0
// Size: 0x5a
function explode_fake_carriable_delayed()
{
    thread fake_fuse_vfx_refresher();
    
    while ( self.molotov_crate_player_at_max_ammo.ñ…õß<-˜Q©‰*U_ > 0 )
    {
        self.molotov_crate_player_at_max_ammo.ñ…õß<-˜Q©‰*U_ -= 0.05;
        wait 0.05;
    }
    
    if ( isdefined( self.molotov_crate_player_at_max_ammo ) )
    {
        thread get_smoke_grenade_start_pos( self.molotov_crate_player_at_max_ammo );
        return;
    }
}

// Params 0
// Size: 0x66
function fake_fuse_watcher()
{
    if ( isdefined( self.car_collision.àı¡	B´8áî`?"] ) )
    {
        self.car_collision.àı¡	B´8áî`?"] endon( "death" );
    }
    else
    {
        self.car_collision endon( "balloon_destroyed" );
    }
    
    self.molotov_crate_player_at_max_ammo.ñ…õß<-˜Q©‰*U_ = 5;
    
    for ( ;; )
    {
        self.molotov_crate_player_at_max_ammo.ñ…õß<-˜Q©‰*U_ -= 0.05;
        wait 0.05;
    }
}

// Params 0
// Size: 0x22
function fake_fuse_vfx_refresher()
{
    while ( isdefined( self ) )
    {
        playfxontag( level._effect[ "vfx_carriable_fuse" ], self, "tag_fx" );
        wait 1;
    }
}

// Params 0
// Size: 0xf2
function attach_carriable_to_ascender_skyhook()
{
    self.molotov_crate_player_at_max_ammo = spawn( "script_model", self.ref_142d4 );
    self.molotov_crate_player_at_max_ammo.angles = ( 0, self.molotov_cleanup_pool.angles[ 1 ], 0 );
    self.molotov_crate_player_at_max_ammo setmodel( self.molotov_cleanup_pool.get_teaminquiry_alias.modelname );
    self.molotov_crate_player_at_max_ammo setcandamage( 1 );
    self.molotov_crate_player_at_max_ammo.health = 999999;
    self.molotov_crate_player_at_max_ammo.ownerteam = "any";
    self.molotov_crate_player_at_max_ammo.get_teaminquiry_alias = self.molotov_cleanup_pool.get_teaminquiry_alias;
    self.molotov_crate_player_at_max_ammo.owner = self.molotov_cleanup_pool.owner;
    self.molotov_crate_player_at_max_ammo.playerzombiecleanuphud = 1;
    thread get_sight_dist_for_vehicle_check();
    thread get_spawncount_from_groupnames();
    self.molotov_crate_player_at_max_ammo linkto( self.canseedangercircleui );
    get_too_far_dist_sq( self.molotov_cleanup_pool );
    self.molotov_cleanup_pool delete();
    thread ascendingskyhookdeathlistener();
}

// Params 0
// Size: 0x385
function play_carriable_ascender_skyhook_anim()
{
    self.player endon( "death_or_disconnect" );
    self.player endon( "ascender_solo_cancel" );
    self.player endon( "last_stand_start" );
    self.cansnapcamera.animname = "device";
    self.cansnapcamera scripts\common\anim::setanimtree();
    self.cansolospawn.animname = "device";
    self.cansolospawn scripts\common\anim::setanimtree();
    var0 = rotatevector( ( -32.415, 0, 0 ), self.canseedangercircleui.angles );
    var1 = 0.4;
    self.player.player_rig moveto( self.canseedangercircleui.origin + var0, var1, 0.1, 0.1 );
    var2 = vectornormalize( var0 * -1 );
    var3 = scripts\cp_mp\auto_ascender::vectortoanglessafe( var2, ( 0, 0, 1 ) );
    self.player.player_rig rotateto( var3, var1, 0.1, 0.1 );
    
    if ( istrue( self.molotov_cleanup_pool.playerzombiecleanuphud ) )
    {
        self.molotov_cleanup_pool endon( "cancel_fuse" );
        wait var1;
    }
    else
    {
        get_spawn_delay( self.player, self.molotov_cleanup_pool );
        self.molotov_cleanup_pool.playerzombiecleanuphud = 1;
    }
    
    if ( !istrue( self.isjuggernaut ) )
    {
        self.player disableoffhandweapons();
    }
    
    scripted_laser_func( self.player );
    self.cansolospawn show();
    self.cansolospawn hidefromplayer( self.player );
    self.cansnapcamera show();
    self.cansnapcamera showonlytoplayer( self.player );
    self.cansnapcamera linkto( self.player.player_rig, "tag_accessory_right", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    self.cansolospawn linkto( self.canseedangercircleui, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    self.player.player_rig linkto( self.canseedangercircleui, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    self.player.player_rig showonlytoplayer( self.player );
    var4 = self.player.player_rig gettagorigin( "tag_weapon" );
    var5 = self.player.player_rig gettagangles( "tag_weapon" );
    self.molotov_clear_fx = spawn( "script_model", var4 );
    self.molotov_clear_fx.angles = var5;
    self.molotov_clear_fx setmodel( self.molotov_cleanup_pool.get_teaminquiry_alias.modelname );
    self.molotov_clear_fx showonlytoplayer( self.player );
    self.molotov_clear_fx.get_teaminquiry_alias = self.molotov_cleanup_pool.get_teaminquiry_alias;
    self.molotov_clear_fx.owner = self.molotov_cleanup_pool.owner;
    self.molotov_clear_fx.playerzombiecleanuphud = 1;
    self.molotov_clear_fx linkto( self.player.player_rig, "tag_weapon" );
    thread get_spawncount_from_groupnames();
    self.canseedangercircleui scripts\common\anim::anim_first_frame_solo( self.player.player_rig, "carriable_ascender_attach" );
    self.canseedangercircleui thread scripts\mp\anim::anim_player_solo( self.player, self.player.player_rig, "carriable_ascender_attach" );
    self.canseedangercircleui thread scripts\common\anim::anim_single_solo( self.cansolospawn, "carriable_ascender_device_attach" );
    var6 = getanimlength( level.scr_anim[ "player" ][ "carriable_ascender_attach" ] );
    wait var6;
    self.player takeweapon( self.player.currentweapon );
    self.player switchtoweaponimmediate( self.player.ref_1286c );
    self.player notify( "ascend_solo_complete" );
    self.player notify( "drop_object" );
}

// Params 0
// Size: 0xa7
function playerascendskyhookplacedeathlistener()
{
    level endon( "game_ended" );
    self.player endon( "ascend_complete" );
    self.player endon( "ascend_solo_complete" );
    self.player endon( "ascender_cancel" );
    self.player scripts\engine\utility::ref_143a5( "death_or_disconnect", "last_stand_start" );
    
    if ( isdefined( self.player ) )
    {
        self.player stopanimscriptsceneevent();
    }
    
    thread cleanupascenduse();
    thread handleteamvisibility();
    
    if ( isdefined( self.molotov_cleanup_pool ) )
    {
        thread get_subway_train_hit_damage_multiplier( self.molotov_cleanup_pool );
        
        if ( istrue( self.molotov_cleanup_pool.playerzombiecleanuphud ) )
        {
            thread get_spotlight_goal_node( self.molotov_cleanup_pool );
        }
    }
    
    if ( isdefined( self.player ) )
    {
        self.player notify( "ascender_cancel" );
        return;
    }
}

// Params 0
// Size: 0x68
function carriableascendskyhookplacedeathlistener()
{
    level endon( "game_ended" );
    self.player endon( "ascend_complete" );
    self.player endon( "ascend_solo_complete" );
    self.player endon( "ascender_cancel" );
    self.molotov_cleanup_pool waittill( "explode" );
    
    if ( isdefined( self.player ) )
    {
        self.player stopanimscriptsceneevent();
    }
    
    cleanupascenduse();
    handleteamvisibility();
    
    if ( isdefined( self.player ) )
    {
        self.player notify( "ascender_cancel" );
        return;
    }
}

// Params 0
// Size: 0x5f
function ascendingskyhookdeathlistener()
{
    level endon( "game_ended" );
    self.molotov_crate_player_at_max_ammo waittill( "explode" );
    self.car_collision.inuse = 0;
    
    if ( isdefined( self.car_collision.ref_134cb ) && istrue( self.car_collision.ref_134cb.inuse ) )
    {
        self.car_collision.ref_134cb.inuse = 0;
    }
    
    handleteamvisibility();
}

// Params 0
// Size: 0x1aa
function cleanupascendskyhookuse()
{
    self.car_collision.inuse = undefined;
    
    if ( isdefined( self.player ) && istrue( self.player.usingascender ) )
    {
        self.player.usingascender = 0;
        self.player.waittill_player_opens_scavenger_cache = gettime();
        self.player scripts\common\utility::allow_usability( 1 );
        self.player.shouldskiplaststand = undefined;
        self.player scripts\common\utility::allow_execution_victim( 1 );
        self.player scripts\common\utility::allow_melee( 1 );
        self.player scripts\common\utility::allow_ads( 1 );
        self.player scripts\common\utility::allow_fire( 1 );
        
        if ( istrue( self.player.isjuggernaut ) )
        {
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "juggernaut", "canUseWeaponPickups" ) )
            {
                var0 = self.player [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "juggernaut", "canUseWeaponPickups" ) ]]();
                
                if ( istrue( var0 ) )
                {
                    self.player enableweaponswitch();
                }
            }
        }
        else if ( !istrue( self.player.inlaststand ) )
        {
            self.player enableoffhandweapons();
            self.player enableweaponswitch();
            self.player scripts\common\utility::allow_killstreaks( 1 );
        }
        else
        {
            self.player thread scripts\cp_mp\auto_ascender::watch_for_ashes_achievement();
        }
        
        self.player.player_rig unlink();
        self.player.get_search_turret_target_player = undefined;
    }
    
    if ( isdefined( self.cansnapcamera ) )
    {
        self.cansnapcamera unlink();
        self.cansnapcamera delete();
        self.cansnapcamera = undefined;
    }
    
    if ( isdefined( self.molotov_clear_fx ) )
    {
        self.molotov_clear_fx delete();
        self.molotov_clear_fx = undefined;
    }
    
    waitframe();
    
    if ( isdefined( self.player ) )
    {
        if ( !self.player hasweapon( "iw8_gunless_infil" ) )
        {
            self.player.gunnlessweapon = undefined;
        }
        
        self.player thread scripts\mp\utility\infilexfil::takegunless();
        self.player notify( "remove_rig" );
        return;
    }
}

// Params 0
// Size: 0x27
function cleanupascenderskyhookdevicecarriable()
{
    if ( isdefined( self.canseedangercircleui ) )
    {
        self.canseedangercircleui scripts\cp_mp\ent_manager::deregisterspawn();
        self.canseedangercircleui delete();
        level.initpostmain--;
        return;
    }
}

