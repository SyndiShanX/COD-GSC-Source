
// Params 0
// Size: 0x87
function teamplunderexfiltimer()
{
    if ( isdefined( level.deposit_from_compromised_convoy_delayed ) )
    {
        return;
    }
    
    level.disable_oob_immunity_on_riders = 1;
    level.deposit_from_compromised_convoy_delayed = spawnstruct();
    level.deposit_from_compromised_convoy_delayed.ref_12010 = undefined;
    level.deposit_from_compromised_convoy_delayed.ref_12011 = undefined;
    level.deposit_from_compromised_convoy_delayed.ref_1201e = undefined;
    level.deposit_from_compromised_convoy_delayed.ref_1363d = [];
    level.deposit_from_compromised_convoy_delayed.bisdeaf = [ "actor_enemy_lw_br", "actor_enemy_lw_br_german_african", "zombie" ];
    ambush_lmg_guy( level.deposit_from_compromised_convoy_delayed );
    allammoboxes();
    allassassin_getsortedteams();
    all_players_within_distance2d_and_below_height();
    scripts\cp_mp\vehicles\cargo_truck_mg::init_battlechatter();
}

// Params 0
// Size: 0x4e
function ambush_lmg_guy()
{
    foreach ( var1 in level.deposit_from_compromised_convoy_delayed.bisdeaf )
    {
        ref_12b0b( var1, &binoculars_watchracelaststand );
        ref_12b0c( var1, &binoculars_watchracetake );
        ref_12b0d( var1, &binocularsinited );
    }
}

// Params 0
// Size: 0x15
function all_players_within_distance2d_and_below_height()
{
    anim.grenadetimers[ "AI_gas_grenade_mp" ] = randomintrange( 0, 20000 );
}

// Params 0
// Size: 0xc6
function allammoboxes()
{
    var0 = [ [ "molotov_explosion", "vfx/iw8/core/molotov/vfx_molotov_explosion.vfx" ], [ "molotov_explosion_child", "vfx/iw8/core/molotov/vfx_molotov_explosion_child.vfx" ], [ "vfx_burn_sml_low", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_sml_low.vfx" ], [ "vfx_burn_sml_high", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_sml_high.vfx" ], [ "vfx_burn_sml_head_low", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_head_low.vfx" ], [ "vfx_burn_med_low", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_med_low.vfx" ], [ "vfx_burn_med_high", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_med_high.vfx" ], [ "vfx_burn_lrg_low", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_lrg_low.vfx" ], [ "vfx_burn_lrg_high", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_lrg_high.vfx" ] ];
    
    if ( !isdefined( level.g_effect ) )
    {
        level.g_effect = [];
    }
    
    for ( var1 = 0; var1 < var0.size ; var1++ )
    {
        if ( !isdefined( level.g_effect[ var0[ var1 ][ 0 ] ] ) )
        {
            level.g_effect[ var0[ var1 ][ 0 ] ] = loadfx( var0[ var1 ][ 1 ] );
        }
    }
}

// Params 0
// Size: 0x1b
function allassassin_getsortedteams()
{
    if ( !scripts\engine\utility::flag_exist( "scriptables_ready" ) )
    {
        scripts\engine\utility::flag_init( "scriptables_ready" );
        return;
    }
}

// Params 5
// Size: 0xac
function spawnnewagent( var0, var1, var2, var3, var4 )
{
    if ( !isdefined( var1 ) )
    {
        var1 = ( 0, 0, 0 );
    }
    
    if ( !isdefined( var3 ) )
    {
        var3 = "actor_enemy_lw_br";
    }
    
    if ( !isdefined( var2 ) )
    {
        var2 = 0;
    }
    
    if ( !isdefined( var4 ) )
    {
        var4 = "team_two_hundred";
    }
    
    var5 = scripts\mp\mp_agent::spawnnewagent( var3, var4, var0, var1 );
    
    if ( !isdefined( var5 ) )
    {
        return;
    }
    
    var5.guid = var5 getguid();
    ammobox_getbufferedattachmentsourceweapon( var5 );
    thread alwaysdoskyspawnontacinsert();
    thread activeparachutersfactionvo();
    scriptablecount( var5, "s4_ar_voscar" );
    thread activestate();
    
    if ( var2 )
    {
        scriptable_token_scriptable_touched_callback( var5, 250 );
    }
    
    level.deposit_from_compromised_convoy_delayed.ref_1363d = scripts\engine\utility::array_add( level.deposit_from_compromised_convoy_delayed.ref_1363d, var5 );
    return var5;
}

// Params 6
// Size: 0x97
function spawnnewzombieagent( var0, var1, var2, var3, var4, var5 )
{
    if ( !isdefined( var1 ) )
    {
        var1 = ( 0, 0, 0 );
    }
    
    if ( !isdefined( var3 ) )
    {
        var3 = "enemy_lw_zombie_default";
    }
    
    if ( !isdefined( var2 ) )
    {
        var2 = 0;
    }
    
    if ( !isdefined( var5 ) )
    {
        var5 = "team_two_hundred";
    }
    
    var6 = access_card::ref_146fa( var3, var0, var1, undefined, var4 );
    
    if ( !isdefined( var6 ) )
    {
        return;
    }
    
    var6.guid = var6 getguid();
    thread activeparachutersfactionvo();
    var6.„jïiÏ[_iïñzÐ·[–¸þ7Xá@ÉëÎcÇr = 1;
    
    if ( var2 )
    {
        scriptable_token_scriptable_touched_callback( var6, 250 );
    }
    
    level.deposit_from_compromised_convoy_delayed.ref_1363d = scripts\engine\utility::array_add( level.deposit_from_compromised_convoy_delayed.ref_1363d, var6 );
    return var6;
}

// Params 5
// Size: 0x58
function spawnnewparachuteagent( var0, var1, var2, var3, var4 )
{
    if ( !isdefined( var1 ) )
    {
        var1 = ( 0, 0, 0 );
    }
    
    if ( !isdefined( var3 ) )
    {
        var3 = "actor_enemy_lw_br";
    }
    
    if ( !isdefined( var2 ) )
    {
        var2 = 0;
    }
    
    if ( !isdefined( var4 ) )
    {
        var4 = "team_two_hundred";
    }
    
    var5 = spawnnewagent( var0, var1, var2, var3, var4 );
    var5 hide();
    var5 [[ level.£'¡Šã^ø…4™›%ª¨¯Û™èƒ›š· ]]( var0 );
    return var5;
}

// Params 0
// Size: 0xdf
function ammobox_getbufferedattachmentsourceweapon()
{
    self.recentkillcount = 0;
    self.recentdefendcount = 0;
    self.kills = 0;
    self.deaths = 0;
    self.pers[ "cur_kill_streak" ] = 0;
    self.pers[ "cur_death_streak" ] = 0;
    self.pers[ "cur_kill_streak_for_nuke" ] = 0;
    self.tookweaponfrom = [];
    self.killedplayers = [];
    self.ref_1407d = 0;
    self.name = "agent_" + self.entity_number;
    self.scripted_long_deaths = 0;
    self.agentdamagefeedback = 1;
    self.maxhealth = 100;
    self.health = 100;
    self.health_remaining = 100;
    self.showseasonalcontent = 100;
    self.showsplashtoall = 100;
    self.meleedamageoverride = 25;
    self.baseaccuracy = 0.35;
    self.circleclosestarttime = spawnstruct();
    self.circleclosestarttime.maxhealth = self.maxhealth;
    self.circleclosestarttime.meleedamageoverride = self.meleedamageoverride;
    self.circleclosestarttime.baseaccuracy = self.baseaccuracy;
}

// Params 0
// Size: 0xa8
function activestate()
{
    self endon( "death" );
    
    for ( ;; )
    {
        self waittill( "grenade_fire", var0, var1, var2, var3 );
        
        if ( !scripts\mp\utility\weapon::grenadethrown( var0 ) )
        {
            continue;
        }
        
        scripts\mp\weapons::grenadeinitialize( var0, var1, var2, var3 );
        self notify( "grenade_throw" );
        
        if ( !isdefined( var0 ) )
        {
            return;
        }
        
        if ( !isdefined( var0.weapon_name ) )
        {
            return;
        }
        
        var0.spawnpos = var0.origin;
        
        switch ( var0.weapon_name )
        {
            case "molotov_mp":
                thread scripts\mp\equipment\molotov::molotov_used( var0 );
                break;
            case "gas_grenade_mp":
                thread scripts\mp\equipment\gas_grenade::gas_used( var0 );
                wait 0.1;
                var0 notify( "missile_stuck" );
                break;
        }
    }
}

// Params 1
// Size: 0x23
function scriptable_token_scriptable_touched_callback( var0 )
{
    if ( scripts\mp\utility\game::getgametype() == "br" )
    {
        scripts\mp\gametypes\br_armor::teamfriendlyto();
        scripts\mp\gametypes\br_armor::searchcirclesize();
        ammobox_canweaponuserandomattachments( var0 );
        return;
    }
}

// Params 2
// Size: 0x89
function scriptablecount( var0, var1 )
{
    self.weapon = scripts\mp\class::buildweapon( var0, [ "none", "none", "none", "none", "none", "none" ], "none", "none", var1 );
    self giveweapon( self.weapon );
    self.bulletsinclip = weaponclipsize( self.weapon );
    self.primaryweapon = self.weapon;
    
    if ( !scripts\common\utility::isweaponinitialized( self.primaryweapon ) )
    {
        scripts\common\utility::initweapon( self.primaryweapon );
    }
    
    scripts\anim\shared::attachweapon( self.primaryweapon, "right" );
}

// Params 2
// Size: 0x2e
function scriptable_used_by_part_funcs( var0, var1 )
{
    if ( !isdefined( self.grenadeweapon ) || self.grenadeweapon.basename != var0 )
    {
        self.grenadeweapon = getcompleteweaponname( var0 );
    }
    
    self.grenadeammo = var1;
}

// Params 0
// Size: 0x3a
function alwaysdoskyspawnontacinsert()
{
    self endon( "death" );
    level endon( "game_ended" );
    wait randomfloatrange( 1.25, 2.75 );
    scripts\cp_mp\vehicles\cargo_truck_mg::autoassignquest( self );
    scripts\cp_mp\vehicles\cargo_truck_mg::playorderevent( "move", "movecombat", anim.player );
}

// Params 1
// Size: 0x48
function ammobox_canweaponuserandomattachments( var0 )
{
    if ( !isdefined( var0 ) || var0 < 0 )
    {
        return;
    }
    
    self.br_maxarmorhealth = var0;
    self.br_armorhealth = var0;
    var1 = self.br_armorhealth / self.br_maxarmorhealth;
    
    if ( isplayer( self ) )
    {
        self setclientomnvar( "ui_br_armor_damage", var1 );
        scripts\mp\equipment\armor_plate::debug_state( self.br_armorhealth );
        return;
    }
}

// Params 1
// Size: 0x10
function setagentmaxhealth( var0 )
{
    self.maxhealth = var0;
    self.health = var0;
}

// Params 1
// Size: 0xa
function ref_13122( var0 )
{
    self.baseaccuracy = var0;
}

// Params 1
// Size: 0xa
function ref_13123( var0 )
{
    self.meleedamageoverride = var0;
}

// Params 0
// Size: 0x8
function relic_mythic_next_pain_time()
{
    return self.enemy;
}

// Params 0
// Size: 0x2e
function activeparachutersfactionvo()
{
    level endon( "game_ended" );
    self waittill( "death" );
    level.deposit_from_compromised_convoy_delayed.ref_1363d = scripts\engine\utility::array_remove( level.deposit_from_compromised_convoy_delayed.ref_1363d, self );
}

// Params 2
// Size: 0x38
function ref_12b0b( var0, var1 )
{
    if ( !isdefined( var0 ) || !isdefined( var1 ) )
    {
        return;
    }
    
    if ( !isdefined( level.agent_funcs ) )
    {
        return;
    }
    
    level.deposit_from_compromised_convoy_delayed.ref_12010 = var1;
    level.agent_funcs[ var0 ][ "on_damaged" ] = var1;
}

// Params 2
// Size: 0x38
function ref_12b0c( var0, var1 )
{
    if ( !isdefined( var0 ) || !isdefined( var1 ) )
    {
        return;
    }
    
    if ( !isdefined( level.agent_funcs ) )
    {
        return;
    }
    
    level.deposit_from_compromised_convoy_delayed.ref_12011 = var1;
    level.agent_funcs[ var0 ][ "gametype_on_damage_finished" ] = var1;
}

// Params 2
// Size: 0x2e
function ref_12b0d( var0, var1 )
{
    if ( !isdefined( var0 ) || !isdefined( var1 ) )
    {
        return;
    }
    
    level.deposit_from_compromised_convoy_delayed.ref_1201e = var1;
    level.agent_funcs[ var0 ][ "gametype_on_killed" ] = var1;
}

// Params 13
// Size: 0x3a
function binoculars_watchracelaststand( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12 )
{
    var13 = var2;
    
    if ( !istrue( self.ref_14693 ) )
    {
        scripts\mp\subway_fast_travel\subway_station::callbacksoldieragentdamaged( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13 );
        return;
    }
}

// Params 15
// Size: 0x93
function binoculars_watchracetake( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14 )
{
    if ( isdefined( level.ref_1203f ) )
    {
        if ( scripts\engine\utility::isbulletdamage( var4 ) )
        {
            if ( isplayer( var1 ) || isbot( var1 ) || isagent( var1 ) )
            {
                self [[ level.ref_1203f ]]( var1, var6, self );
            }
        }
    }
    
    if ( !istrue( self.ref_14693 ) )
    {
        scripts\mp\subway_fast_travel\subway_station::callbacksoldieragentgametypedamagefinished( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14 );
        return;
    }
    
    _zombieagentondamagefinishedcallback( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14 );
}

// Params 9
// Size: 0x1e
function binocularsinited( var0, var1, var2, var3, var4, var5, var6, var7, var8 )
{
    scripts\mp\subway_fast_travel\subway_station::callbacksoldieragentgametypekilled( var0, var1, var2, var3, var4, var5, var6, var7, var8 );
}

// Params 15
// Size: 0xb4
function _zombieagentondamagefinishedcallback( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14 )
{
    if ( isdefined( self.‘–#‡½ðkO!¡éz–VëÏ¿>é§·ú9QÛ lk)Ü ) )
    {
        if ( istrue( self.‚¶c¹ÐçÛ@ç÷ûAöË¸!ë§õé‡"ÑÏö?a ) )
        {
            var2 = int( var2 * 0.5 );
        }
        
        self [[ self.‘–#‡½ðkO!¡éz–VëÏ¿>é§·ú9QÛ lk)Ü ]]( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, undefined, var11, var12 );
        _zombieprocessarmordamage( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14 );
        
        if ( isdefined( self.¥9)ëÆËÐ>ÄyP´AE÷ë«áRW0îwŒpèûêýùo™J
Hq, ) )
        {
            [[ self.¥9)ëÆËÐ>ÄyP´AE÷ë«áRW0îwŒpèûêýùo™J
Hq, ]]( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14 );
        }
        
        scripts\mp\subway_fast_travel\subway_station::process_damage_feedback( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, self, var13, var14 );
        return;
    }
}

// Params 15
// Size: 0x10e
function _zombieprocessarmordamage( var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14 )
{
    if ( scripts\mp\gametypes\br_public::hasarmor() )
    {
        var15 = var2;
        
        if ( istrue( self.hashelmet ) && ( var8 == "head" || var8 == "helmet" ) )
        {
            var2 = int( var2 * 0.07 );
        }
        
        if ( isdefined( var1 ) && isplayer( var1 ) )
        {
            var1 playsoundtoplayer( "hit_marker_3d_armor", var1 );
        }
        
        scripts\mp\damage::armorvest_sethit( var1 );
        var16 = self.br_armorhealth - var2;
        self.health += var15;
        self.br_armorhealth -= var2;
        
        if ( scripts\engine\utility::sign( var16 ) == -1 )
        {
            var2 = int( abs( var16 ) );
            self.health -= var2;
        }
        
        if ( self.br_armorhealth <= 0 )
        {
            self.br_armorhealth = 0;
            scripts\mp\damage::armorvest_setbroke( var1 );
            
            if ( isdefined( self.•$æÛSxƒ b‚÷Û¯»ŸD ) )
            {
                access_card::detachhelmetfromzombie( self.•$æÛSxƒ b‚÷Û¯»ŸD.model, self.•$æÛSxƒ b‚÷Û¯»ŸD.tag );
            }
            
            if ( isdefined( var1 ) && isplayer( var1 ) )
            {
                var1 playsoundtoplayer( "hit_marker_3d_armor_break", var1 );
                return;
            }
            
            return;
        }
        
        return;
    }
}

