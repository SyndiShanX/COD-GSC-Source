
// Params 0
// Size: 0x141
function init()
{
    level.ÑáØ”%Çsà).£Ë¨ö = [];
    var0 = scripts\cp_mp\killstreaks\airdrop::getleveldata( "medical_crate" );
    var0.capturestring = &"MP/GENERIC_LOOT_CRATE_CAPTURE";
    var0.dummymodel = "military_carepackage_01_br_medical";
    var0.friendlymodel = undefined;
    var0.enemymodel = undefined;
    var0.mountmantlemodel = undefined;
    var0.supportsownercapture = 0;
    var0.headicon = undefined;
    var0.minimapicon = undefined;
    var0.usepriority = -1;
    var0.usefov = 180;
    var0.timeout = undefined;
    var0.friendlyuseonly = 0;
    var0.ownerusetime = 1.5;
    var0.otherusetime = 1.5;
    var0.activatecallback = &brmedicalcrateactivatecallback;
    var0.capturecallback = &brmedicalcratecapturecallback;
    var0.destroyoncapture = 1;
    level.≤≠≠„¡ì'É´¶n0€4H = spawnstruct();
    level.≤≠≠„¡ì'É´¶n0€4H.∏õ9+Ï-Ï ◊¥£Vkn = [ [ "brloot_self_revive", 1 ], [ "brloot_self_revive", 1 ], [ "brloot_zmb_stim", 4 ] ];
    level.≤≠≠„¡ì'É´¶n0€4H.ñ©G∞±£•±±˙ï.∫“É÷¨π: = [ [ "brloot_health_adrenaline", 2 ] ];
    level.≤≠≠„¡ì'É´¶n0€4H.ç«aÂ‚ Œkàp≤õÜ = [ [ "brloot_perk_point_quick_fix", 1 ], [ "brloot_perk_point_quick_fix", 1 ], [ "brloot_perk_point_cold_blooded", 1 ], [ "brloot_perk_point_cold_blooded", 1 ] ];
}

// Params 1
// Size: 0x3c
function brmedicalcrateactivatecallback( var0 )
{
    if ( istrue( var0 ) )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "airdrop", "registerCrateForCleanup" ) )
        {
            [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "airdrop", "registerCrateForCleanup" ) ]]( self );
        }
    }
    
    level.ÑáØ”%Çsà).£Ë¨ö[ level.ÑáØ”%Çsà).£Ë¨ö.size ] = self;
}

// Params 1
// Size: 0x3f
function brmedicalcratecapturecallback( var0 )
{
    if ( isdefined( self.ref_13428 ) )
    {
        self.ref_13428 setscriptablepartstate( "smoke_signal", "off", 0 );
        self.ref_13428 delete();
    }
    
    level.ÑáØ”%Çsà).£Ë¨ö = scripts\engine\utility::array_remove( level.ÑáØ”%Çsà).£Ë¨ö, self );
    medical_crate_loot_distribution();
}

// Params 0
// Size: 0x14c
function medical_crate_loot_distribution()
{
    var0 = [];
    
    foreach ( var2 in level.≤≠≠„¡ì'É´¶n0€4H.∏õ9+Ï-Ï ◊¥£Vkn )
    {
        var0 = var2;
    }
    
    foreach ( var2 in level.≤≠≠„¡ì'É´¶n0€4H.ñ©G∞±£•±±˙ï.∫“É÷¨π: )
    {
        var0 = var2;
    }
    
    foreach ( var2 in level.≤≠≠„¡ì'É´¶n0€4H.ç«aÂ‚ Œkàp≤õÜ )
    {
        var0 = var2;
    }
    
    var8 = scripts\mp\gametypes\br_pickups::test_ai_anim();
    
    foreach ( var2 in var0 )
    {
        var10 = var2[ 0 ];
        
        if ( var10 == "brloot_zmb_stim" )
        {
            scripts\mp\gametypes\br_gametype_zxp::spawnlootsyringe( self.origin, self.angles, self, 4 );
            continue;
        }
        
        if ( scripts\mp\gametypes\br_lootcache::get_bonus_targets( var10 ) )
        {
            var11 = level.br_pickups.delay_hide_player_clip[ var10 ];
            
            if ( isdefined( var11 ) && var11 == 4 )
            {
                var12 = scripts\mp\gametypes\br_lootcache::ref_11a41( var10, var8, self.origin, self.angles, 0, 1 );
                var13 = 1;
            }
            else
            {
                var12 = scripts\mp\gametypes\br_lootcache::ref_11a41( var14, var9, self.origin, self.angles, 0, 0 );
            }
            
            var12.count = var3[ 1 ];
        }
    }
    
    var10 = undefined;
    var11 = undefined;
}

// Params 0
// Size: 0x51
function medical_crate_cleanup()
{
    playfx( level.conf_fx[ "vanish" ], self.origin );
    
    if ( isdefined( self.ref_13428 ) )
    {
        self.ref_13428 setscriptablepartstate( "smoke_signal", "off", 0 );
        self.ref_13428 delete();
    }
    
    level.ÑáØ”%Çsà).£Ë¨ö = scripts\engine\utility::array_remove( level.ÑáØ”%Çsà).£Ë¨ö, self );
    scripts\cp_mp\killstreaks\airdrop::lastactivateinstruct();
}

// Params 0
// Size: 0x16
function getusetimeoverride()
{
    var0 = scripts\cp_mp\killstreaks\airdrop::getleveldata( "medical_crate" );
    return var0.ownerusetime;
}

