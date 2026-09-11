
// Params 0
// Size: 0x7
function ref_140f9()
{
    ref_140fa();
}

// Params 0
// Size: 0xe3
function ref_140fa()
{
    var0 = scripts\mp\gametypes\br_plunder::ref_1278c( "br_plunder_extraction_vault", 1 );
    var0.type = 1;
    var0.usetime = 0.75;
    var0.¾Å
x<7îìóBJU = 1.5;
    var0.ref_14077 = 7;
    var0.ref_14075 = 100000;
    var0.ref_13acc = 0;
    var0.ref_12f7d = "brloot_plunder_extraction_vault";
    var0.ref_12f7e = "usable";
    var0.ref_12f77 = "unusable";
    var0.ÖªHŠ¹ˆAÙà`#7 = "BR_RAT_RACE/BR_NOTHING_TO_STEAL";
    var0.overrideviewkickscaledmr = 10800;
    var0.origin_delta = 0;
    var0.get_closest_enemy_near_turret = 0;
    var0.outline_enemy_ai_for_duration = "rat_race";
    var0.brking_ispointinmovingcircle = getdvarint( "scr_br_plunder_extraction_vault_allow_stealing", 1 ) != 0;
    var0.§>_y=šäˆÐ­3¨ø = getdvarint( "scr_br_plunder_extraction_vault_steal_amount", 2500 );
    var0.š>#{‹RÅÀ«…Ë@ Kè•ë§ç5Ëœ¨1:U{h/¾_/Q = 50;
}

// Params 3
// Size: 0x92
function ref_140f5( var0, var1, var2 )
{
    var3 = spawn( "script_model", var0 );
    var3 setmodel( "br_plunder_extraction_vault" );
    var3.team = var2;
    var3.angles = var1;
    scripts\mp\gametypes\br_plunder::ref_12796( var3, "br_plunder_extraction_vault" );
    var4 = scripts\mp\utility\teams::getfriendlyplayers( var3.team );
    thread scripts\mp\gametypes\br_plunder::ref_127a4( var3, var4 );
    scripts\mp\gametypes\br_plunder::ref_127aa( var3, var4 );
    
    foreach ( var6 in var4 )
    {
        if ( isdefined( var6 ) && isplayer( var6 ) )
        {
            var3 setotherent( var6 );
            break;
        }
    }
    
    return var3;
}

// Params 0
// Size: 0x3f
function ref_140fb()
{
    var0 = scripts\mp\gametypes\br_plunder::ref_1278c( "br_plunder_extraction_vault" );
    
    if ( var0.brking_ispointinmovingcircle )
    {
        var1 = "hitequip";
        var2 = undefined;
        var3 = undefined;
        var4 = 1;
        thread scripts\mp\damage::monitordamage( 500, var1, &ref_140f8, &ref_140f7, var2, var3, var4 );
        return;
    }
}

// Params 1
// Size: 0x8f
function ref_140f7( var0 )
{
    if ( self.plunder.size <= 0 )
    {
        return 0;
    }
    
    if ( !istrue( scripts\cp_mp\utility\player_utility::playersareenemies( var0.attacker, self ) ) )
    {
        return 0;
    }
    
    var1 = scripts\mp\damage::handleshotgundamage( var0.objweapon, var0.meansofdeath, var0.damage );
    
    if ( var0.meansofdeath == "MOD_MELEE" )
    {
        var1 = int( ceil( self.maxhealth / 6 ) );
    }
    else if ( isexplosivedamagemod( var0.meansofdeath ) )
    {
        if ( var0.damage >= 50 )
        {
            var1 = int( ceil( self.maxhealth / 2 ) );
        }
    }
    
    return var1;
}

// Params 1
// Size: 0x4d
function ref_140f8( var0 )
{
    thread scripts\mp\gametypes\br::ref_13ac7( "br_gametype_rat_race_your_team_stole_from_enemy_base", undefined, var0.attacker.team );
    thread scripts\mp\gametypes\br::ref_13ac7( "br_gametype_rat_race_enemy_stole_from_your_base", undefined, self.team );
    var1 = 1;
    var2 = scripts\mp\gametypes\br_gametype_rat_race::replace_access_card_on_deathordisconnect();
    scripts\mp\gametypes\br_plunder::num_rocket_per_attack( var1, var2 );
    scripts\mp\damage::monitordamageend();
    wait 1;
    ref_140fb();
}

