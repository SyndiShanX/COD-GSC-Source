
// Params 0
// Size: 0x2c
function slinger_init()
{
    slinger_initanims();
    slinger_initparams();
    scripts\mp\utility\sound::besttime( "equip_skyhook" );
    level.¥=	óHssø=“ = [];
    scripts\engine\scriptable::ref_12f5b( "balloon_use_cache", &slingerscriptableused );
}

#using_animtree( "" );

// Params 0
// Size: 0x74
function slinger_initanims()
{
    level.scr_animtree[ "slinger" ] = #animtree;
    level.scr_anim[ "slinger" ][ "slinger_open" ] = $wm_portable_redeploy_balloon_open;
    level.scr_animname[ "slinger" ][ "slinger_open" ] = "wm_portable_redeploy_balloon_open";
    level.scr_anim[ "slinger" ][ "slinger_open_idle" ] = %wm_portable_redeploy_balloon_idle;
    level.scr_animname[ "slinger" ][ "slinger_open_idle" ] = "wm_portable_redeploy_balloon_idle";
}

// Params 0
// Size: 0x12d
function slinger_initparams()
{
    level.…)¹¥›³¬Nƒ,ÉÚÜ = spawnstruct();
    level.…)¹¥›³¬Nƒ,ÉÚÜ.™Á¦FÇRfƒP‡84 = getdvarint( "scr_slinger_ascent_height", 2500 );
    level.…)¹¥›³¬Nƒ,ÉÚÜ.¬w-ø	SX = getdvarint( "scr_slinger_ascent_time", 2 );
    level.…)¹¥›³¬Nƒ,ÉÚÜ.–z‘{ˆ·’øb›®I"‚y^ = getdvarfloat( "scr_slinger_launch_forward_scalar", 1250 );
    level.…)¹¥›³¬Nƒ,ÉÚÜ.‘…˜ğ[p»êù.ø = getdvarfloat( "scr_slinger_launch_z_scalar", 1500 );
    level.…)¹¥›³¬Nƒ,ÉÚÜ.launchtime = getdvarfloat( "scr_slinger_launch_time", 1 );
    level.…)¹¥›³¬Nƒ,ÉÚÜ.ƒšæKÜvYä†VÂÆè¡ = getdvarint( "scr_slinger_health", 1250 );
    level.…)¹¥›³¬Nƒ,ÉÚÜ.«Øj2óĞƒ.#;­ˆ³øU3 = getdvarint( "scr_slinger_explosives_multiplier", 4 );
    level.…)¹¥›³¬Nƒ,ÉÚÜ.¬Sñ“ ¾K*ûÀ3ëu*DËÃŠ = getdvarint( "scr_slinger_aa_turret_multiplier", 6 );
    level.…)¹¥›³¬Nƒ,ÉÚÜ.A$jİ˜Yû8Ó{ = getdvarint( "scr_slinger_thermite_dps", 100 );
    level.…)¹¥›³¬Nƒ,ÉÚÜ.cantakedamage = loadfx( "vfx/iw8_br/island/equip/barrage_balloon/vfx_barrage_balloon_scrnfx" );
    level.…)¹¥›³¬Nƒ,ÉÚÜ.•“y{y0wPı©ó = loadfx( "vfx/iw8_br/island/equip/barrage_balloon/vfx_barrage_balloon_explosion_port" );
    level.…)¹¥›³¬Nƒ,ÉÚÜ.ref_127e6 = loadfx( "vfx/iw8_br/island/equip/barrage_balloon/vfx_barrage_balloon_timeout_port" );
    level.…)¹¥›³¬Nƒ,ÉÚÜ.ªè€òzAãÁõ¶; = loadfx( "vfx/iw8_br/island/gameplay/vfx_br3_jammer_dmg.vfx" );
}

// Params 0
// Size: 0x5, Type: bool
function slinger_allow_use()
{
    return true;
}

// Params 1
// Size: 0xe0
function slinger_used( var0 )
{
    var1 = self;
    var1 endon( "death_or_disconnect" );
    jumpiffalse(getdvarint( "scr_slinger_use_time_debug", 1 ) > 0 && isdefined( var1.super )) LOC_00000039;
    var1.super.«Y†%ªåÙUã€XÛgru = gettime();
    var0 waittill( "missile_stuck", var2 );
    var3 = undefined;
    
    if ( isdefined( var2 ) || !scripts\mp\outofbounds::unset_relic_rocket_kill_ammo( var0.origin ) )
    {
        var3 = "MP_BR_INGAME_TU_WZ345/SLINGER_CANNOT_PLACE";
    }
    else if ( level.¥=	óHssø=“.size >= 8 || isdefined( var1.¥=	óHssø=“ ) && var1.¥=	óHssø=“.size >= 3 )
    {
        var3 = "MP_BR_INGAME_TU_WZ345/SLINGER_TOO_MANY";
    }
    else if ( !slinger_hasdeployclearance( var1, var0 ) )
    {
        var3 = "MP_BR_INGAME_TU_WZ345/SLINGER_BLOCKED";
    }
    
    if ( isdefined( var3 ) )
    {
        var1 playlocalsound( "br_pickup_deny" );
        var1 scripts\mp\hud_message::showerrormessage( var3 );
        
        if ( isdefined( var1.super ) )
        {
            slinger_refundsuper( var1 );
        }
        
        var0 delete();
        return;
    }
    
    slinger_deploy( var1, var0 );
}

// Params 0
// Size: 0x84
function slinger_refundsuper()
{
    var0 = self;
    var1 = 1;
    var0 setweaponammoclip( var0.super.staticdata.weapon, var1 );
    
    if ( istrue( var0.issuperdisabled ) )
    {
        var0.loadoutextraperksfromgamemode = var1;
    }
    
    var0 notify( "super_use_finished_lb" );
    var0 notify( "super_use_finished" );
    scripts\cp\vehicles\vehicle_compass_cp::ref_12097( var0.super, 1 );
    var2 = var0 scripts\mp\supers::getcurrentsuper();
    var0 scripts\mp\supers::ref_131c7( 0 );
    var0 scripts\mp\supers::ref_131c6( 0 );
    var2.wasrefunded = 1;
    var0 scripts\mp\supers::setsuperbasepoints( var0 scripts\mp\supers::getsuperpointsneeded() );
}

// Params 1
// Size: 0x5d, Type: bool
function slinger_hasdeployclearance( var0 )
{
    var1 = 32;
    var2 = var0.origin + ( 0, 0, var1 + 1 );
    var3 = var0.origin + ( 0, 0, 4500 );
    var4 = scripts\engine\trace::create_contents( 0, 1, 1, 1, 1, 1, 0 );
    var5 = scripts\engine\trace::sphere_trace( var2, var3, var1, var0, var4 );
    return var5[ "fraction" ] == 1;
}

// Params 1
// Size: 0x1da
function slinger_deploy( var0 )
{
    var1 = self;
    
    if ( isdefined( var1.super ) )
    {
        if ( getdvarint( "scr_slinger_use_time_debug", 1 ) > 0 && !isdefined( var1.super.usestarttime ) )
        {
            var2 = "unknown";
            
            if ( isdefined( var1.super.staticdata ) )
            {
                var2 = scripts\engine\utility::ter_op( isdefined( var1.super.staticdata.ref ), var1.super.staticdata.ref, "undefined" );
            }
            
            var3 = scripts\engine\utility::ter_op( isdefined( var1.super.«Y†%ªåÙUã€XÛgru ), var1.super.«Y†%ªåÙUã€XÛgru, "undefined" );
            var4 = scripts\engine\utility::ter_op( isdefined( var1.super.madeavailabletime ), var1.super.madeavailabletime, "undefined" );
            var5 = scripts\engine\utility::ter_op( isdefined( var1.super.usepercent ), var1.super.usepercent, "undefined" );
            var6 = "Portable redeploy balloon undefined useStartTime. ref[" + var2 + "] throwTime[" + var3 + "] madeAvailableTime[" + var4 + "] usePercent[" + var5 + "]";
            scripts\mp\utility\script::laststand_dogtags( var6 );
        }
        
        var1 scripts\mp\supers::superusefinished( undefined, undefined, undefined, 1 );
    }
    
    var7 = var0.origin;
    var8 = var0.angles * ( 0, 1, 0 );
    var0 delete();
    var9 = spawn( "script_model", var7 );
    var9 getuseholdkbmprofile( 1 );
    var9 setmodel( "military_skyhook_depballoon_backpack" );
    var9.angles = var8;
    var9.animname = "slinger";
    var9 scripts\common\anim::setanimtree();
    var9.owner = var1;
    var9.team = var1.team;
    var9.†'!êİ{z@8™PèêCeŠ’ = [];
    var9.´â,›Æ+æ2Ê“ÜØ²¹+›Ş‘YÍ = [];
    var9.—o>ò²ĞïÃhs\‹‘Ëùb = [];
    var9.£²æ§2áX³_ğÛÌêcpÏ¿Áï = [];
    var9.‘náo•7 qò‹[€ = 1;
    thread run_deployed_slinger( var9 );
}

// Params 1
// Size: 0x1fa
function run_deployed_slinger( var0 )
{
    var1 = self;
    var1 endon( "death" );
    
    if ( !isdefined( var0.¥=	óHssø=“ ) )
    {
        var0.¥=	óHssø=“ = [];
    }
    
    var0.¥=	óHssø=“[ var0.¥=	óHssø=“.size ] = var1;
    playsoundatpos( var1.origin, "fulton_bag_drop" );
    playsoundatpos( var1.origin, "skyhook_deploy" );
    playsoundatpos( var1.origin + ( 0, 0, 400 ), "skyhook_rope_deploy_start" );
    thread slinger_collision_watcher();
    thread slinger_damage_watcher();
    thread drop_players_on_break_watcher();
    var2 = scripts\engine\utility::spawn_tag_origin( var1.origin, var1.angles * ( 0, 1, 0 ) );
    var1.scenenode = var2;
    thread slinger_use_activate();
    var2 scripts\common\anim::anim_single_solo( var1, "slinger_open" );
    thread run_slinger_idle_anim( var1 );
    playsoundatpos( var1.origin + ( 0, 0, 4500 ), "skyhook_balloon_inflate" );
    var1.laststandplayers = 1;
    var3 = getdvarfloat( "scr_slinger_deploy_duration", 30 );
    var4 = var1 scripts\engine\utility::ref_143b9( var3, "slinger_destroyed" );
    
    if ( var4 == "timeout" )
    {
        playfx( level.…)¹¥›³¬Nƒ,ÉÚÜ.ref_127e6, var1.origin + ( 0, 0, 4500 ) );
        playsoundatpos( var1.origin + ( 0, 0, 4500 ), "skyhook_pop" );
    }
    else
    {
        playfx( level.…)¹¥›³¬Nƒ,ÉÚÜ.•“y{y0wPı©ó, var1.origin + ( 0, 0, 4500 ) );
        playsoundatpos( var1.origin + ( 0, 0, 4500 ), "skyhook_explode" );
    }
    
    playfx( level.…)¹¥›³¬Nƒ,ÉÚÜ.ªè€òzAãÁõ¶;, var1.origin );
    playsoundatpos( var1.origin, "mp_equip_destroyed" );
    
    if ( isdefined( var0 ) && isdefined( var0.¥=	óHssø=“ ) )
    {
        var0.¥=	óHssø=“ = scripts\engine\utility::array_remove( var0.¥=	óHssø=“, var1 );
    }
    
    var2 delete();
    var1 delete();
}

// Params 0
// Size: 0x37
function slinger_use_activate()
{
    var0 = self;
    var0 endon( "death" );
    level endon( "game_ended" );
    wait 0.5;
    var0 setscriptablepartstate( "balloon_use_cache", "usable" );
    var0 setscriptablepartstate( "balloon_objective", "active" );
}

// Params 0
// Size: 0xa3
function slinger_collision_watcher()
{
    var0 = self;
    level endon( "game_ended" );
    var0 endon( "death" );
    var1 = 0.5;
    var2 = 2500;
    var3 = 0.15;
    var4 = 99999;
    wait var1;
    var0 physics_registerforcollisioncallback();
    var0 method_87de( 1 );
    
    for ( ;; )
    {
        var0 waittill( "collision", var5, var6, var7, var8, var9, var10, var11, var12 );
        
        if ( var9[ 2 ] > var0.origin[ 2 ] + var2 && isdefined( var12 ) && var12 scripts\cp_mp\vehicles\vehicle::isvehicle() )
        {
            var12 scripts\engine\utility::delaycallwatchself( var3, &dodamage, var4, var9 );
            var0 notify( "slinger_destroyed" );
        }
    }
}

// Params 0
// Size: 0x34f
function slinger_damage_watcher()
{
    var0 = self;
    level endon( "game_ended" );
    var0 endon( "death" );
    var0 setcandamage( 1 );
    var0.Š-·c
¿Bc[×úëÍì = level.…)¹¥›³¬Nƒ,ÉÚÜ.ƒšæKÜvYä†VÂÆè¡;
    var0.health = 99999;
    var0.maxhealth = 99999;
    
    for ( ;; )
    {
        var0 waittill( "damage", var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11 );
        var0.health += var1;
        
        if ( isdefined( var10 ) && isdefined( var10.magazine ) )
        {
            switch ( var10.magazine )
            {
                case "calcust1_xmike109":
                    var1 = 300;
                    break;
                case "calcust2_xmike109":
                    thread fake_thermite_damage_duration( var0, 3, var2 );
                    break;
            }
        }
        
        if ( isplayer( var2 ) )
        {
            var2 scripts\mp\damagefeedback::updatehitmarker( "standard", var0.health == 0, 0, 1, "hitequip" );
        }
        else if ( isdefined( var2.owner ) && isplayer( var2.owner ) )
        {
            var2.owner scripts\mp\damagefeedback::updatehitmarker( "standard", var0.health == 0, 0, 1, "hitequip" );
        }
        
        if ( isdefined( var2 ) && isdefined( var2.currentweapon ) && isdefined( var2.currentweapon.basename ) && var2.currentweapon.basename == "manual_turret_flak_mp" )
        {
            var1 *= level.…)¹¥›³¬Nƒ,ÉÚÜ.¬Sñ“ ¾K*ûÀ3ëu*DËÃŠ;
        }
        else if ( isdefined( var5 ) && var5 == "MOD_PROJECTILE" || var5 == "MOD_GRENADE" || var5 == "MOD_EXPLOSIVE" || var5 == "MOD_EXPLOSIVE_BULLET" )
        {
            var1 *= level.…)¹¥›³¬Nƒ,ÉÚÜ.«Øj2óĞƒ.#;­ˆ³øU3;
        }
        
        if ( isdefined( var10 ) && isdefined( var10.basename ) && var10.basename == "toma_proj_mp" )
        {
            var1 = var0.Š-·c
¿Bc[×úëÍì + 1;
        }
        
        var0.Š-·c
¿Bc[×úëÍì -= var1;
        
        if ( var0.Š-·c
¿Bc[×úëÍì <= 0 )
        {
            break;
        }
        
        if ( isdefined( var10 ) && isdefined( var10.magazine ) )
        {
            switch ( var10.magazine )
            {
                case "boltexplo_crossbow":
                    scripts\engine\utility::delaycallwatchself( 2.05, &dodamage, var1, var4, var2, undefined, undefined, undefined, var4 );
                    break;
                case "boltfire_crossbow":
                    scripts\engine\utility::delaycallwatchself( 4, &dodamage, var1, var4, var2, undefined, undefined, undefined, var4 );
                    break;
            }
        LOC_00000291:
        }
    LOC_00000291:
    }
    
    if ( isdefined( var2.model ) && var2.model == "veh_s4_mil_air_dalpha_wz_turret_attach" && isdefined( var2.owner ) && isplayer( var2.owner ) )
    {
        var2.owner thread [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "rank", "giveRankXP" ) ]]( "kill", 500 );
    }
    
    if ( isdefined( var2 ) && isplayer( var2 ) && isdefined( var2.currentweapon ) && isdefined( var2.currentweapon.basename ) && var2.currentweapon.basename == "tur_gun_bt_mp" )
    {
        var2 thread [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "rank", "giveRankXP" ) ]]( "kill", 500 );
    }
    
    var0 notify( "slinger_destroyed" );
}

// Params 3
// Size: 0x61
function fake_thermite_damage_duration( var0, var1, var2 )
{
    var3 = self;
    var3 endon( "death" );
    var4 = 0;
    
    while ( var4 < var0 )
    {
        wait 0.25;
        
        if ( scripts\mp\utility\player::isreallyalive( var1 ) )
        {
            var1 scripts\mp\damagefeedback::updatehitmarker( "standard", 0, 0, 1, "hitequip" );
        }
        
        var4 += 0.25;
    }
    
    var3 dodamage( level.…)¹¥›³¬Nƒ,ÉÚÜ.A$jİ˜Yû8Ó{ * var0, var2, var1, undefined, undefined, undefined, var2 );
}

// Params 0
// Size: 0x64
function drop_players_on_break_watcher()
{
    var0 = self;
    var0 waittill( "death" );
    
    foreach ( var2 in var0.†'!êİ{z@8™PèêCeŠ’ )
    {
        var3 = var2 getentitynumber();
        var4 = var0.´â,›Æ+æ2Ê“ÜØ²¹+›Ş‘YÍ[ var3 ];
        var4 thread scripts\mp\gametypes\br_skyhook::ref_133fc( var2 );
        var4 stoploopsound( "br_auto_ascender_device_lp_npc" );
        slingerfullcleanup( var2, var3, var0 );
    }
}

// Params 1
// Size: 0x25
function run_slinger_idle_anim( var0 )
{
    var1 = self;
    var1 endon( "death" );
    var0 endon( "death" );
    
    for ( ;; )
    {
        var0 scripts\common\anim::anim_single_solo( var1, "slinger_open_idle" );
    }
}

// Params 5
// Size: 0x75
function slingerscriptableused( var0, var1, var2, var3, var4 )
{
    if ( var2 == "usable" )
    {
        if ( !canplayeruseslinger( var0, var3 ) )
        {
            return;
        }
        
        if ( getdvarint( "scr_slinger_carriable_interaction_enabled", 1 ) && isdefined( var3.get_search_turret_target_player ) && scripts\cp_mp\utility\script_utility::issharedfuncdefined( "player", "carriable_useSkyhook" ) )
        {
            var0.ˆõÁ	B«8‡”`?"] = var0.entity;
            var3 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "player", "carriable_useSkyhook" ) ]]( var0 );
            return;
        }
        
        thread useslinger( var3 );
        return;
    }
}

// Params 2
// Size: 0x9f, Type: bool
function canplayeruseslinger( var0, var1 )
{
    if ( istrue( var0.inuse ) )
    {
        return false;
    }
    
    if ( var1 isswitchingweapon() )
    {
        return false;
    }
    
    if ( var1.currentweapon.basename == "iw8_spotter_scope_mp_ch3" )
    {
        return false;
    }
    
    if ( var1 scripts\cp_mp\utility\player_utility::isinvehicle() )
    {
        return false;
    }
    
    if ( istrue( var1.tracking_max_health ) )
    {
        return false;
    }
    
    if ( istrue( var1.inlaststand ) )
    {
        return false;
    }
    
    if ( istrue( var1.isreviving ) )
    {
        return false;
    }
    
    if ( istrue( var1.isjuggernaut ) )
    {
        return false;
    }
    
    if ( var1 isskydiving() )
    {
        return false;
    }
    
    if ( var1 isparachuting() )
    {
        return false;
    }
    
    if ( istrue( var1.iszombie ) )
    {
        return false;
    }
    
    if ( !var1 scripts\common\utility::trial_ui_retry_disabled() )
    {
        return false;
    }
    
    return true;
}

// Params 1
// Size: 0x353
function useslinger( var0 )
{
    var1 = self;
    level endon( "game_ended" );
    var1 endon( "death_or_disconnect" );
    var1 endon( "last_stand_start" );
    var2 = var0.entity;
    var2 endon( "death" );
    var2.†'!êİ{z@8™PèêCeŠ’[ var2.†'!êİ{z@8™PèêCeŠ’.size ] = var1;
    var1.ref_140af = 1;
    var1.shouldskiplaststand = 1;
    
    if ( isdefined( var1.get_search_turret_target_player ) )
    {
        var1.get_search_turret_target_player thread scripts\mp\equipment\binoculars::get_subway_train_hit_damage_multiplier( 0 );
    }
    
    scripts\mp\gametypes\br_skyhook::ref_1246f( var1 );
    var1 scripts\common\utility::allow_usability( 0 );
    var0 thread scripts\mp\gametypes\br_skyhook::ref_13405();
    var1.usingascender = 1;
    var3 = var1 getentitynumber();
    var4 = spawn( "script_model", var0.origin );
    var4 setmodel( "tag_origin" );
    var4 scripts\cp_mp\ent_manager::registerspawncount( 1 );
    var2.´â,›Æ+æ2Ê“ÜØ²¹+›Ş‘YÍ[ var3 ] = var4;
    var4 dontinterpolate();
    var4.origin = var0.origin;
    var4.angles = var1.angles;
    var5 = spawn( "script_model", var0.origin );
    var5 scripts\cp_mp\ent_manager::registerspawncount( 1 );
    var5 setmodel( "misc_vm_ascender_ch3" );
    var5 showonlytoplayer( var1 );
    var2.—o>ò²ĞïÃhs\‹‘Ëùb[ var3 ] = var5;
    var6 = spawn( "script_model", var0.origin );
    var6 scripts\cp_mp\ent_manager::registerspawncount( 1 );
    var6 setmodel( "misc_vm_ascender_ch3" );
    var6 hide();
    var2.£²æ§2áX³_ğÛÌêcpÏ¿Áï[ var3 ] = var6;
    thread slingerascendingdeathlistener( var1, var0 );
    var1.…Ô»ò28ğKZ9W¡Ó/‰	cé = 0;
    var7 = var4 scripts\mp\gametypes\br_skyhook::ref_133fb( var1, var5, var6 );
    
    if ( !var7 )
    {
        slingerfullcleanup( var1, var3, var2 );
        playsoundatpos( var0.origin, "skyhook_repair_denied" );
        return;
    }
    
    var1 childthread scripts\mp\gametypes\br_skyhook::ref_133fe();
    var1 thread scripts\mp\gametypes\br_skyhook::ref_12505();
    var4 thread scripts\mp\gametypes\br_skyhook::ref_133fd( var1, var5, var6 );
    var4 playloopsound( "br_auto_ascender_device_lp_npc" );
    var4 moveto( var4.origin + ( 0, 0, level.…)¹¥›³¬Nƒ,ÉÚÜ.™Á¦FÇRfƒP‡84 ), level.…)¹¥›³¬Nƒ,ÉÚÜ.¬w-ø	SX, level.…)¹¥›³¬Nƒ,ÉÚÜ.¬w-ø	SX );
    playfxontagforclients( level.…)¹¥›³¬Nƒ,ÉÚÜ.cantakedamage, var4, "tag_origin", var1 );
    wait level.…)¹¥›³¬Nƒ,ÉÚÜ.¬w-ø	SX * 0.35;
    var1.…Ô»ò28ğKZ9W¡Ó/‰	cé = 1;
    wait level.…)¹¥›³¬Nƒ,ÉÚÜ.¬w-ø	SX * 0.65;
    stopfxontag( level.…)¹¥›³¬Nƒ,ÉÚÜ.cantakedamage, var4, "tag_origin" );
    var1 notify( "kill_skyhook_ascend_earthquake" );
    var4 thread scripts\mp\gametypes\br_skyhook::ref_133fc( var1, var5, var6 );
    var4 stoploopsound( "br_auto_ascender_device_lp_npc" );
    var1 playlocalsound( "scr_br_infil_jump_stinger", var1 );
    var1 earthquakeforplayer( 0.2, 1.5, var1.origin, 1000 );
    var8 = "enabled";
    
    if ( isdefined( var1.operatorcustomization ) && isdefined( var1.operatorcustomization.disabledebugdialogue ) )
    {
        var8 += var1.operatorcustomization.disabledebugdialogue;
    }
    
    var1 setscriptablepartstate( "skydiveVfx", var8, 0 );
    var1 setisinfilskydive( 1 );
    var1.¾Ok…èµÇåĞq{Ûòè¤Qù¸Ø©ã[ = anglestoforward( var1 getplayerangles( 1 ) ) * level.…)¹¥›³¬Nƒ,ÉÚÜ.–z‘{ˆ·’øb›®I"‚y^;
    var4 movegravity( var1.¾Ok…èµÇåĞq{Ûòè¤Qù¸Ø©ã[ + ( 0, 0, level.…)¹¥›³¬Nƒ,ÉÚÜ.‘…˜ğ[p»êù.ø ), level.…)¹¥›³¬Nƒ,ÉÚÜ.launchtime );
    wait level.…)¹¥›³¬Nƒ,ÉÚÜ.launchtime - 0.1;
    var1 setclientomnvar( "ui_br_altimeter_state", 1 );
    var1 thread scripts\mp\gametypes\br_skyhook::ref_13403();
    slingerfullcleanup( var1, var3, var2 );
    var2.†'!êİ{z@8™PèêCeŠ’ = scripts\engine\utility::array_remove( var2.†'!êİ{z@8™PèêCeŠ’, var1 );
}

// Params 2
// Size: 0x6a
function slingerascendingdeathlistener( var0, var1 )
{
    var2 = self;
    var2 endon( "slinger_complete" );
    scripts\engine\utility::waittill_any_ents( self, "death_or_disconnect", self, "last_stand_start", level, "game_ended" );
    
    if ( isdefined( var2 ) )
    {
        var2 stopanimscriptsceneevent();
    }
    
    var3 = var0.entity;
    var3.´â,›Æ+æ2Ê“ÜØ²¹+›Ş‘YÍ[ var1 ] stoploopsound( "br_auto_ascender_device_lp_npc" );
    var3.†'!êİ{z@8™PèêCeŠ’ = scripts\engine\utility::array_remove( var3.†'!êİ{z@8™PèêCeŠ’, var2 );
    slingerfullcleanup( var2, var1, var3 );
}

// Params 3
// Size: 0x109
function slingerfullcleanup( var0, var1, var2 )
{
    if ( isdefined( var0 ) )
    {
        var0 setscriptablepartstate( "skydiveVfx", "default", 0 );
        var0 setisinfilskydive( 0 );
    }
    
    if ( isdefined( var2.—o>ò²ĞïÃhs\‹‘Ëùb[ var1 ] ) )
    {
        var2.—o>ò²ĞïÃhs\‹‘Ëùb[ var1 ] scripts\cp_mp\ent_manager::deregisterspawn();
        var2.—o>ò²ĞïÃhs\‹‘Ëùb[ var1 ] delete();
    }
    
    if ( isdefined( var2.£²æ§2áX³_ğÛÌêcpÏ¿Áï[ var1 ] ) )
    {
        var2.£²æ§2áX³_ğÛÌêcpÏ¿Áï[ var1 ] scripts\cp_mp\ent_manager::deregisterspawn();
        var2.£²æ§2áX³_ğÛÌêcpÏ¿Áï[ var1 ] delete();
    }
    
    var2 thread scripts\mp\gametypes\br_skyhook::cleanupascenduse( var0 );
    thread scenenodecleanup( var2, var0 );
    
    if ( isdefined( var0 ) )
    {
        if ( !istrue( level.client_activate ) )
        {
            var0 skydive_setbasejumpingstatus( 1 );
        }
        
        var0.player_rig stopanimscripted();
        var0.usingascender = 0;
        var0.ref_140af = 0;
        var0 notify( "kill_skyhook_ascend_earthquake" );
        
        if ( isdefined( var0.¾Ok…èµÇåĞq{Ûòè¤Qù¸Ø©ã[ ) )
        {
            var0 setvelocity( var0.¾Ok…èµÇåĞq{Ûòè¤Qù¸Ø©ã[ );
        }
        
        var0.¾Ok…èµÇåĞq{Ûòè¤Qù¸Ø©ã[ = undefined;
        
        if ( istrue( var0.…Ô»ò28ğKZ9W¡Ó/‰	cé ) && !istrue( level.client_activate ) && !scripts\mp\utility\player::unset_relic_trex( var0 ) )
        {
            var0 skydive_beginfreefall();
        }
        
        var0 notify( "slinger_complete" );
        return;
    }
}

// Params 2
// Size: 0x4e
function scenenodecleanup( var0, var1 )
{
    var2 = self;
    
    if ( isdefined( var0 ) )
    {
        var0 unlink();
        
        if ( !var0 scripts\common\utility::can_be_executed() )
        {
            var0 scripts\common\utility::allow_execution_victim( 1 );
        }
    }
    
    if ( isdefined( var2.´â,›Æ+æ2Ê“ÜØ²¹+›Ş‘YÍ[ var1 ] ) )
    {
        var2.´â,›Æ+æ2Ê“ÜØ²¹+›Ş‘YÍ[ var1 ] scripts\cp_mp\ent_manager::deregisterspawn();
        var2.´â,›Æ+æ2Ê“ÜØ²¹+›Ş‘YÍ[ var1 ] delete();
        return;
    }
}

