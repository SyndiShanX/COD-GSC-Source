
// Params 2
// Size: 0x48
function spawnmalfunctioningscreamerdevice( var0, var1 )
{
    var2 = _dropscreamercrate( var1 + ( 0, 0, 2500 ), var1 );
    var3 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject( var2 );
    var3.ref_140a0 = 4;
    level.ref_11e18.«¥Ü6“ÊÂ¶+ä6'X£Ê = var2;
    level.ref_11e18.„Dç#µ}OS	²]Hø{Ï·[# = var0;
}

// Params 0
// Size: 0x4e
function endevent_malfunctioningscreamerdevice()
{
    if ( isdefined( level.ref_11e18.ref_12f3f ) && isdefined( level.ref_11e18.ref_12f3f.owner ) )
    {
        level.ref_11e18.ref_12f3f.owner scripts\mp\killstreaks\killstreaks::awardkillstreak( "greenbay_strike", "other", undefined, undefined, undefined, 1 );
        return;
    }
}

// Params 0
// Size: 0x11b
function destroyscreamer()
{
    level.ref_11e18 notify( "screamer_dropped" );
    level.ref_11e18 notify( "screamer_destroyed" );
    
    if ( isdefined( level.ref_11e18.«¥Ü6“ÊÂ¶+ä6'X£Ê ) )
    {
        level.ref_11e18.«¥Ü6“ÊÂ¶+ä6'X£Ê thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
        level.ref_11e18.«¥Ü6“ÊÂ¶+ä6'X£Ê = undefined;
    }
    
    level.ref_11e18.„Dç#µ}OS	²]Hø{Ï·[# = undefined;
    
    if ( isdefined( level.ref_11e18.ref_12f3f ) )
    {
        _worldiconhide( level.ref_11e18.ref_12f3f );
        
        if ( isdefined( level.ref_11e18.ref_12f3f.owner ) )
        {
            var0 = scripts\mp\gametypes\br_pickups::test_ai_anim();
            _dropscreamerinternal( level.ref_11e18.ref_12f3f.owner, var0 );
            level.ref_11e18.ref_12f3f setscriptablepartstate( "brloot_mendota_screamer", "disabled" );
            wait 1.6;
        }
        
        thread _explodescreamer( level.ref_11e18.ref_12f3f.origin );
        
        if ( isent( level.ref_11e18.ref_12f3f ) )
        {
            level.ref_11e18.ref_12f3f delete();
        }
        else
        {
            level.ref_11e18.ref_12f3f freescriptable();
        }
        
        level.ref_11e18.ref_12f3f = undefined;
        return;
    }
}

// Params 1
// Size: 0xd4
function initcratedata( var0 )
{
    var1 = scripts\cp_mp\killstreaks\airdrop::getleveldata( "fresno_screamer" );
    var1.capturestring = &"MP/GENERIC_LOOT_CRATE_CAPTURE";
    var1.dummymodel = "military_carepackage_02_br";
    var1.friendlymodel = undefined;
    var1.enemymodel = undefined;
    var1.mountmantlemodel = undefined;
    var1.supportsownercapture = 0;
    var1.headicon = undefined;
    var1.usepriority = -1;
    var1.usefov = 180;
    var1.timeout = undefined;
    var1.friendlyuseonly = 1;
    var1.ownerusetime = 0.5;
    var1.otherusetime = 0.5;
    var1.capturecallback = &_cratecapturecallback;
    var1.destroycallback = &_cratedestroycallback;
    var1.activatecallback = &_crateactivatecallback;
    var1.ingame = &_cratephysicsoncallback;
    var1.ref_127fd = &_cratepostcreatecallback;
    var1.destroyoncapture = 1;
}

// Params 1
// Size: 0xa6
function pickupscreamer( var0 )
{
    var1 = self.tracknonoobplayerlocation;
    level endon( "game_ended" );
    var1 endon( "death" );
    
    foreach ( var3 in level.players )
    {
        if ( var3.team == var0.team )
        {
            if ( var3 == var0 )
            {
                var3 scripts\mp\hud_message::showsplash( "br_pe_fresno_screamer_stay_close" );
            }
        }
    }
    
    _worldiconhide( var1 );
    _worldiconshow( var1, "picked_up", var0 );
    _hidescreamer( var1 );
    var1.owner = var0;
    var0.‘–;›>èæCàÊ×á««" = 1;
    thread _carryscreamergesture( var0 );
}

// Params 2
// Size: 0x51
function dropscreamer( var0, var1 )
{
    level.ref_11e18 notify( "screamer_dropped" );
    _dropscreamerinternal( var0, var1 );
    _worldiconshow( level.ref_11e18.ref_12f3f, "on_ground" );
    scripts\mp\gametypes\br_publicevents::ref_13371( "br_pe_fresno_screamer_recover" );
    
    if ( istrue( var1 ) )
    {
        thread _trackscreameroob();
        return;
    }
}

// Params 0
// Size: 0x85
function choosescreamertitan()
{
    var0 = isdefined( level.ref_11e18.setincomingremovedcallback.ref_12930 );
    var1 = isdefined( level.ref_11e18.wait_for_next_hack_complete.ref_12930 );
    level.ref_11e18.÷sÇ_¹¹;RÁ = undefined;
    level.ref_11e18.«÷n“²ÂkVÉ­[ = undefined;
    
    if ( var0 )
    {
        if ( !var1 || randomintrange( 0, 2 ) == 0 )
        {
            level.ref_11e18.÷sÇ_¹¹;RÁ = 1;
        }
    }
    
    if ( var1 && !isdefined( level.ref_11e18.÷sÇ_¹¹;RÁ ) )
    {
        level.ref_11e18.«÷n“²ÂkVÉ­[ = 1;
        return;
    }
}

// Params 2
// Size: 0x108
function _dropscreamerinternal( var0, var1 )
{
    if ( isdefined( level.ref_11e18.ref_12f3f ) )
    {
        var2 = scripts\engine\utility::ter_op( isplayer( self ), self, level.ref_11e18.ref_12f3f.owner );
        
        if ( isdefined( var2 ) )
        {
            var2.‘–;›>èæCàÊ×á««" = 0;
        }
        
        if ( isent( level.ref_11e18.ref_12f3f ) == 0 )
        {
            _worldiconhide( level.ref_11e18.ref_12f3f );
            level.ref_11e18.ref_12f3f freescriptable();
            level.ref_11e18.ref_12f3f = undefined;
        }
    }
    
    if ( isdefined( level.ref_11e18.ref_12f3f ) == 0 )
    {
        if ( istrue( var1 ) )
        {
            var3 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles( var0, self.origin, self.angles, self, 0, 0, 10, 1 );
        }
        else
        {
            var3 = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles( var1, self.origin, self.angles, self );
        }
        
        level.ref_11e18.ref_12f3f = scripts\mp\gametypes\br_pickups::spawnpickup( "brloot_mendota_screamer", var3, 0, 1 );
        level.ref_11e18.ref_12f3f.keepinmap = 1;
        level.ref_11e18.ref_12f3f.hidden = 0;
        return;
    }
}

// Params 1
// Size: 0x5f
function _explodescreamer( var0 )
{
    var1 = var0 + ( 0, 0, -96 );
    var2 = physicstrace( var0, var1 );
    var3 = var2 == var1;
    var4 = "detonateGround";
    
    if ( var3 )
    {
        var4 = "detonateAir";
    }
    
    waitframe();
    var5 = easepower( "br_carriable_explosion_base", var2, ( 0, 0, 0 ) );
    var5 setscriptablepartstate( "carrible_explode_base", var4 );
    var5 thread scripts\mp\equipment\binoculars::hanging_crate_think( 5 );
}

// Params 0
// Size: 0x15e
function _trackscreameroob()
{
    var0 = self;
    level.ref_11e18 endon( "screamer_destroyed" );
    level endon( "game_ended" );
    var0 endon( "death" );
    var1 = 10;
    var2 = 0.1;
    var3 = -1;
    var4 = float( level.ref_11e18.playerredeploy * level.ref_11e18.playerredeploy );
    
    for ( ;; )
    {
        wait var2;
        
        if ( isdefined( level.ref_11e18.ref_12f3f ) && isdefined( level.ref_11e18.„Dç#µ}OS	²]Hø{Ï·[# ) )
        {
            var5 = level.ref_11e18.ref_12f3f.origin;
            
            if ( isdefined( level.ref_11e18.ref_12f3f.owner ) && isdefined( level.ref_11e18.ref_12f3f.owner.origin ) )
            {
                var5 = level.ref_11e18.ref_12f3f.owner.origin;
            }
            
            var6 = distance2dsquared( var5, level.ref_11e18.„Dç#µ}OS	²]Hø{Ï·[# );
            
            if ( var6 <= var4 )
            {
                if ( var3 >= 0 )
                {
                    level.ref_11e18.ref_12f3f notify( "screamer_in_bounds" );
                    var3 = -1;
                }
            }
            else if ( var3 <= -1 )
            {
                var3 = var1;
                thread _playscreameroobalarm( level.ref_11e18.ref_12f3f );
            }
            else if ( var3 >= 0 )
            {
                var7 = int( var3 );
                var3 -= var2;
                
                if ( var3 <= 0 )
                {
                    thread destroyscreamer();
                    break;
                }
            }
            
            continue;
        }
        
        break;
    }
}

// Params 1
// Size: 0x38
function _waitscreameroobalarm( var0 )
{
    var1 = self;
    level endon( "game_ended" );
    level.ref_11e18 endon( "screamer_destroyed" );
    level.ref_11e18 endon( "screamer_dropped" );
    var1 endon( "death" );
    var1 scripts\engine\utility::waittill_notify_or_timeout( "screamer_in_bounds", var0 );
}

// Params 1
// Size: 0x64
function _playscreameroobalarm( var0 )
{
    var1 = self;
    var1 notify( "screamer_in_bounds" );
    
    if ( isdefined( var1.owner ) )
    {
        var2 = var1.owner;
        var2 setclientomnvar( "ui_out_of_bounds_type", 4 );
        var2 setclientomnvar( "ui_out_of_bounds_countdown", int( gettime() + var0 * 1000 ) );
        _waitscreameroobalarm( var1, var0 );
        var2 setclientomnvar( "ui_out_of_bounds_type", 0 );
        var2 setclientomnvar( "ui_out_of_bounds_countdown", 0 );
        return;
    }
}

// Params 0
// Size: 0x1e
function _hidescreamer()
{
    var0 = self;
    var0.hidden = 1;
    var0 setscriptablepartstate( "brloot_mendota_screamer", "hidden" );
}

// Params 2
// Size: 0xbd
function _worldiconshow( var0, var1 )
{
    var2 = self;
    
    if ( var0 == "picked_up" )
    {
        _setscreamericonspickedup( var2, var1, "ui_mp_br_mapmenu_icon_orca_objective_friendly", "ui_mp_br_mapmenu_icon_orca_objective_enemy" );
        return;
    }
    
    if ( var0 == "on_ground" )
    {
        var3 = scripts\mp\objidpoolmanager::requestobjectiveid( 1 );
        
        if ( var3 != -1 )
        {
            scripts\mp\objidpoolmanager::objective_add_objective( var3, "current", var2.origin + ( 0, 0, 50 ), "ui_mp_br_mapmenu_icon_orca_objective_dropped" );
            scripts\mp\objidpoolmanager::update_objective_setbackground( var3, 1 );
            
            foreach ( var5 in level.players )
            {
                if ( !var5 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal() )
                {
                    objective_addclienttomask( var3, var5 );
                }
            }
            
            objective_showtoplayersinmask( var3 );
            var2.icon = var3;
            thread _screamerupdateiconposition();
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0x6b
function _worldiconhide()
{
    var0 = self;
    var0 notify( "screamer_icon_hide" );
    
    if ( isdefined( var0.icon ) )
    {
        scripts\mp\objidpoolmanager::returnobjectiveid( var0.icon );
        var0.icon = undefined;
    }
    
    if ( isdefined( var0.playersetattractionstateindex ) )
    {
        scripts\mp\objidpoolmanager::returnobjectiveid( var0.playersetattractionstateindex );
        var0.playersetattractionstateindex = undefined;
    }
    
    if ( isdefined( var0.nuke_cancel ) )
    {
        scripts\mp\objidpoolmanager::returnobjectiveid( var0.nuke_cancel );
        var0.nuke_cancel = undefined;
        return;
    }
}

// Params 3
// Size: 0x138
function _setscreamericonspickedup( var0, var1, var2 )
{
    var3 = self;
    var4 = scripts\mp\objidpoolmanager::requestobjectiveid( 1 );
    
    if ( var4 != -1 )
    {
        scripts\mp\objidpoolmanager::objective_add_objective( var4, "current", var3.origin, var1 );
        scripts\mp\objidpoolmanager::update_objective_setbackground( var4, 1 );
        var5 = 0;
        thread _updatescreamericon( var3, var0, var4 );
        objective_removeallfrommask( var4 );
        var6 = scripts\mp\utility\teams::getteamdata( var0.team, "players" );
        
        foreach ( var8 in var6 )
        {
            if ( !var8 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal() )
            {
                objective_addclienttomask( var4, var8 );
            }
        }
        
        objective_showtoplayersinmask( var4 );
        var3.playersetattractionstateindex = var4;
    }
    
    var10 = scripts\mp\objidpoolmanager::requestobjectiveid( 1 );
    
    if ( var10 != -1 )
    {
        scripts\mp\objidpoolmanager::objective_add_objective( var10, "current", var3.origin, var2 );
        scripts\mp\objidpoolmanager::update_objective_setbackground( var10, 1 );
        var5 = 0;
        thread _updatescreamericon( var3, var0, var10 );
        objective_removeallfrommask( var10 );
        
        foreach ( var8 in level.players )
        {
            if ( var8 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal() || var8.team == var0.team )
            {
                objective_addclienttomask( var10, var8 );
            }
        }
        
        objective_hidefromplayersinmask( var10 );
        var3.nuke_cancel = var10;
        return;
    }
}

// Params 3
// Size: 0x76
function _updatescreamericon( var0, var1, var2 )
{
    var3 = self;
    level.ref_11e18 endon( "screamer_dropped" );
    level.ref_11e18 endon( "screamer_destroyed" );
    
    if ( var2 <= 0 )
    {
        scripts\mp\objidpoolmanager::update_objective_setzoffset( var1, 50 );
        scripts\mp\objidpoolmanager::update_objective_onentity( var1, var0 );
        return;
    }
    
    for ( ;; )
    {
        if ( isdefined( var0 ) )
        {
            scripts\mp\objidpoolmanager::update_objective_position( var1, var0.origin + ( 0, 0, 50 ) );
            
            if ( var0 scripts\cp_mp\utility\player_utility::isinvehicle() )
            {
                wait 0.1;
                continue;
            }
            
            wait var2;
        }
    }
}

// Params 0
// Size: 0x41
function _screamerupdateiconposition()
{
    self notify( "_screamerUpdateIconPosition" );
    self endon( "_screamerUpdateIconPosition" );
    self endon( "screamer_icon_hide" );
    self endon( "death" );
    
    for ( ;; )
    {
        scripts\mp\objidpoolmanager::update_objective_position( self.icon, self.origin + ( 0, 0, 50 ) );
        waitframe();
    }
}

// Params 1
// Size: 0xe5
function _carryscreamergesture( var0 )
{
    var1 = self;
    level endon( "game_ended" );
    var1 endon( "death_or_disconnect" );
    var1 giveweapon( var0 );
    var1 setweaponammostock( var0, 0 );
    var1 setweaponammoclip( var0, 0 );
    var1 scripts\mp\supers::allowsuperweaponstow();
    var2 = var1 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch( var0, 0, 1 );
    
    if ( !istrue( var2 ) )
    {
        var1 scripts\mp\supers::unstowsuperweapon();
        
        if ( var1 scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring( var0 ) )
        {
            var1 scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch( var0 );
        }
        else
        {
            var1 takeweapon( var0 );
        }
    }
    
    var1 scripts\common\utility::allow_killstreaks( 0 );
    var1 scripts\common\utility::allow_supers( 0 );
    
    while ( istrue( var1.‘–;›>èæCàÊ×á««" ) )
    {
        waitframe();
        
        if ( !var1 scripts\cp_mp\utility\inventory_utility::iscurrentweapon( var0 ) || _playercanholdscreamer( var1 ) == 0 )
        {
            if ( !istrue( var1.‘–;›>èæCàÊ×á««" ) )
            {
                var1 thread scripts\mp\utility\inventory::switchtolastweapon();
                wait 0.5;
            }
            
            var1 takeweapon( var0 );
            
            if ( istrue( var1.‘–;›>èæCàÊ×á««" ) )
            {
                var3 = scripts\mp\gametypes\br_pickups::test_ai_anim();
                dropscreamer( var1, var3 );
            }
        }
    }
    
    var1 scripts\common\utility::allow_killstreaks( 1 );
    var1 scripts\common\utility::allow_supers( 1 );
}

// Params 1
// Size: 0x5a, Type: bool
function _playercanholdscreamer( var0 )
{
    if ( istrue( var0.‘–;›>èæCàÊ×á««" ) == 0 )
    {
        return false;
    }
    
    if ( var0 isinexecutionvictim() )
    {
        return false;
    }
    
    if ( istrue( var0.inlaststand ) )
    {
        return false;
    }
    
    if ( var0 scripts\cp_mp\utility\player_utility::isinvehicle() )
    {
        return false;
    }
    
    if ( istrue( var0.isreviving ) )
    {
        return false;
    }
    
    if ( istrue( var0.isjuggernaut ) )
    {
        return false;
    }
    
    if ( var0 ismantling() )
    {
        return false;
    }
    
    return true;
}

// Params 2
// Size: 0x75
function _dropscreamercrate( var0, var1 )
{
    var2 = scripts\cp_mp\killstreaks\airdrop::dropcrate( undefined, undefined, "fresno_screamer", var0, ( 0, randomfloat( 360 ), 0 ), var1 );
    
    if ( isdefined( var2 ) )
    {
        var2.skipminimapicon = 0;
        var2 setscriptablepartstate( "objective_map", "pe_chopper_crate", 0 );
        var2.ref_13428 = spawn( "script_model", var1 );
        var2.ref_13428 setmodel( "ks_airdrop_crate_br" );
        var2.ref_13428 setscriptablepartstate( "smoke_signal", "pe_chopper_on", 0 );
    }
    
    return var2;
}

// Params 1
// Size: 0x4
function _crateactivatecallback( var0 )
{
    
}

// Params 1
// Size: 0x44
function _cratecapturecallback( var0 )
{
    if ( isdefined( self.ref_13428 ) )
    {
        self.ref_13428 setscriptablepartstate( "smoke_signal", "off", 0 );
        self.ref_13428 delete();
    }
    
    level.ref_11e18.«¥Ü6“ÊÂ¶+ä6'X£Ê = undefined;
    var1 = scripts\mp\gametypes\br_pickups::test_ai_anim();
    dropscreamer( var1, 1 );
}

// Params 1
// Size: 0x45
function _cratedestroycallback( var0 )
{
    self setscriptablepartstate( "objective_map", "inactive", 0 );
    
    if ( isdefined( self.ref_13428 ) )
    {
        self.ref_13428 setscriptablepartstate( "smoke_signal", "off", 0 );
        self.ref_13428 delete();
    }
    
    level.ref_11e18.«¥Ü6“ÊÂ¶+ä6'X£Ê = undefined;
}

// Params 2
// Size: 0x15
function _cratephysicsoncallback( var0, var1 )
{
    self setscriptablepartstate( "crate_audio", "detach", 0 );
}

// Params 0
// Size: 0x12
function _cratepostcreatecallback()
{
    self setscriptablepartstate( "model", "friendly", 0 );
}

