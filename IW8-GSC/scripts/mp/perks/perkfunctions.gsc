
// Params 0
// Size: 0x2
function setbountyhunter()
{
    
}

// Params 0
// Size: 0x2
function unsetbountyhunter()
{
    
}

// Params 0
// Size: 0x8
function sethealer()
{
    thread radialhealer();
}

// Params 0
// Size: 0x110
function radialhealer()
{
    self endon( "unset_healer" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    
    if ( !level.teambased )
    {
        return;
    }
    
    self.teammateswithhealperk = [];
    
    for ( ;; )
    {
        if ( scripts\cp_mp\utility\player_utility::_isalive() )
        {
            var0 = scripts\mp\utility\player::getplayersinradius( self.origin, 350, self.team, self );
            
            foreach ( var2 in var0 )
            {
                if ( var2 scripts\mp\utility\perk::_hasperk( "specialty_healer" ) )
                {
                    continue;
                }
                
                if ( self.team == var2.team && var2 scripts\cp_mp\utility\player_utility::_isalive() && !isdefined( var2.healer ) )
                {
                    var3 = var2 getentitynumber();
                    
                    if ( self.teammateswithhealperk.size == 0 )
                    {
                        scripts\mp\hud_message::showmiscmessage( "healing_players" );
                    }
                    
                    var2.healer = self;
                    self.teammateswithhealperk[ var3 ] = 1;
                    var2 scripts\mp\utility\perk::giveperk( "specialty_regenfaster" );
                    var2 scripts\mp\utility\perk::giveperk( "specialty_regen_delay_reduced" );
                    var2 scripts\mp\hud_message::showmiscmessage( "in_healing_range" );
                    givehealedoverlay( var2 );
                    thread healerperkteammatewatcher( var2 );
                    thread healerperkteammatedestructor( var2 );
                }
            }
        }
        
        wait 0.3;
    }
}

// Params 1
// Size: 0xe5
function healerperkteammatewatcher( var0 )
{
    level endon( "game_ended" );
    self endon( "unset_healer" );
    self endon( "death_or_disconnect" );
    var0 endon( "death_or_disconnect" );
    
    for ( ;; )
    {
        var1 = 400;
        
        if ( distancesquared( self.origin, var0.origin ) > var1 * var1 || var0.team != self.team )
        {
            var0 notify( "out_of_healing_range" );
            return;
        }
        
        var2 = var0 getentitynumber();
        
        if ( var0.health < var0.maxhealth && var0.healedoverlay.alpha == var0.healedoverlay.lowalpha )
        {
            thread healedoverlayfade( var0, var0.healedoverlay, self );
        }
        else if ( var0.health == var0.maxhealth )
        {
            thread healedoverlayfade( var0, var0.healedoverlay, self );
        }
        
        wait 0.1;
    }
}

// Params 1
// Size: 0x83
function healerperkteammatedestructor( var0 )
{
    level endon( "game_ended" );
    var1 = var0 getentitynumber();
    scripts\engine\utility::waittill_any_ents( self, "unset_healer", self, "death_or_disconnect", var0, "death_or_disconnect", var0, "out_of_healing_range" );
    
    if ( isdefined( var0 ) )
    {
        var0 scripts\mp\utility\perk::removeperk( "specialty_regenfaster" );
        var0 scripts\mp\utility\perk::removeperk( "specialty_regen_delay_reduced" );
        var0.healer = undefined;
        var0 scripts\mp\hud_message::showmiscmessage( "out_of_healing_range" );
    }
    
    if ( isdefined( self ) )
    {
        self.teammateswithhealperk[ var1 ] = undefined;
        
        if ( self.teammateswithhealperk.size == 0 )
        {
            scripts\mp\hud_message::showmiscmessage( "no_healing_players" );
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0xa
function unsethealer()
{
    self notify( "unset_healer" );
}

// Params 1
// Size: 0xa1
function givehealedoverlay( var0 )
{
    var1 = newclienthudelem( var0 );
    var1.x = 0;
    var1.y = 0;
    var1 setshader( "overlay_healer", 640, 480 );
    var1.alignx = "left";
    var1.aligny = "top";
    var1.horzalign = "fullscreen";
    var1.vertalign = "fullscreen";
    var1.alpha = 0;
    var1.lowalpha = 0;
    var1.highalpha = 0.75;
    var0.healedoverlay = var1;
    thread healedoverlayfade( var0, var1, self );
    thread healedoverlaydestructor( var0, var1 );
}

// Params 3
// Size: 0x3c
function healedoverlayfade( var0, var1, var2 )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "out_of_healing_range" );
    var1 endon( "death_or_disconnect" );
    var1 endon( "unset_healer" );
    var0 fadeovertime( 0.5 );
    var0.alpha = var2;
}

// Params 2
// Size: 0x47
function healedoverlaydestructor( var0, var1 )
{
    scripts\engine\utility::waittill_any_ents( level, "game_ended", var1, "unset_healer", var1, "death_or_disconnect", self, "death_or_disconnect", self, "out_of_healing_range" );
    
    if ( isdefined( var0 ) )
    {
        var0 fadeovertime( 1 );
        var0.alpha = 0;
        wait 1;
        var0 destroy();
        return;
    }
}

// Params 0
// Size: 0x2
function settank()
{
    
}

// Params 0
// Size: 0x2
function unsettank()
{
    
}

// Params 0
// Size: 0x2
function setsurvivor()
{
    
}

// Params 0
// Size: 0x2
function unsetsurvivor()
{
    
}

// Params 0
// Size: 0x2
function setstealth()
{
    
}

// Params 0
// Size: 0x2
function unsetstealth()
{
    
}

// Params 0
// Size: 0xb
function setbreacher()
{
    scripts\mp\door::updatealldoorslockvisibilityforplayer( self, 1 );
}

// Params 0
// Size: 0xa
function unsetbreacher()
{
    scripts\mp\door::updatealldoorslockvisibilityforplayer( self, 0 );
}

// Params 0
// Size: 0x2
function setsupport()
{
    
}

// Params 0
// Size: 0x2
function unsetsupport()
{
    
}

// Params 0
// Size: 0x2
function setdemolitions()
{
    
}

// Params 0
// Size: 0x2
function unsetdemolitions()
{
    
}

// Params 0
// Size: 0x2
function setintel()
{
    
}

// Params 0
// Size: 0x2
function unsetintel()
{
    
}

// Params 0
// Size: 0x2
function sethunter()
{
    
}

// Params 0
// Size: 0x2
function unsethunter()
{
    
}

// Params 0
// Size: 0x2
function setspotter()
{
    
}

// Params 0
// Size: 0x2
function unsetspotter()
{
    
}

// Params 0
// Size: 0x2
function setmunitions()
{
    
}

// Params 0
// Size: 0x2
function unsetmunitions()
{
    
}

// Params 0
// Size: 0x8
function setoffhandprovider()
{
    thread offhandproviderthread();
}

// Params 0
// Size: 0x130
function offhandproviderthread()
{
    level endon( "game_ended" );
    self endon( "unset_offhand_provider" );
    self endon( "death_or_disconnect" );
    
    for ( ;; )
    {
        var0 = scripts\mp\utility\player::getplayersinradius( self.origin, 144, self.team, self );
        
        foreach ( var2 in var0 )
        {
            if ( !isdefined( var2.ohpequipmentrefills ) )
            {
                var2.ohpequipmentrefills = [];
            }
            
            if ( equipmentusedbyslot( var2, "primary" ) == 0 && equipmentusedbyslot( var2, "secondary" ) == 0 )
            {
                continue;
            }
            
            if ( !isdefined( var2.ohpequipmentrefills[ self getentitynumber() ] ) && var2 scripts\cp_mp\utility\player_utility::_isalive() )
            {
                var2.ohpequipmentrefills[ self getentitynumber() ] = 1;
                var3 = refillequipment( var2 );
                
                for ( var4 = 0; var4 < var3[ "primary" ] ; var4++ )
                {
                    thread ohpequipmentfillednotification( var2, self.name );
                }
                
                for ( var4 = 0; var4 < var3[ "secondary" ] ; var4++ )
                {
                    thread ohpequipmentfillednotification( var2, self.name );
                }
                
                thread ohpallowuseonplayerdeath( var2 );
                var2 playsoundtoplayer( "scavenger_pack_pickup", var2 );
            }
        }
        
        wait 0.1;
    }
}

// Params 1
// Size: 0x33
function ohpallowuseonplayerdeath( var0 )
{
    level endon( "game_ended" );
    var0 endon( "disconnect" );
    var1 = self getentitynumber();
    scripts\engine\utility::waittill_any_ents_return( self, "disconnect", var0, "death" );
    var0.ohpequipmentrefills[ var1 ] = undefined;
}

// Params 0
// Size: 0xa
function unsetoffhandprovider()
{
    self notify( "unset_offhand_provider" );
}

// Params 0
// Size: 0x2d
function refillequipment()
{
    var0 = [];
    GscBinSkip0( 0x2e, "primary", equipmentusedbyslot( "primary", 1 ) );
    // Unknown operator ( 0x2e, iw8, PC )
}

// Params 2
// Size: 0x3e
function equipmentusedbyslot( var0, var1 )
{
    if ( !isdefined( var1 ) )
    {
        var1 = 0;
    }
    
    var2 = scripts\mp\equipment::getcurrentequipment( var0 );
    var3 = getequipmentstartammo( var0 );
    var4 = scripts\mp\equipment::getequipmentammo( var2 );
    
    if ( var1 && var3 - var4 > 0 )
    {
        scripts\mp\equipment::incrementequipmentammo( var2, var3 - var4 );
    }
    
    return var3 - var4;
}

// Params 1
// Size: 0x35
function getequipmentstartammo( var0 )
{
    var1 = scripts\mp\equipment::getcurrentequipment( var0 );
    var2 = scripts\mp\equipment::getequipmentstartammo( var1 );
    
    if ( var0 == "primary" && scripts\mp\utility\perk::_hasperk( "specialty_extra_deadly" ) )
    {
        var2 = scripts\mp\equipment::getequipmentmaxammo( var1 );
    }
    
    return var2;
}

// Params 2
// Size: 0x16e
function ohpequipmentfillednotification( var0, var1 )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    
    if ( !isdefined( self.munitionsnotifications ) )
    {
        self.munitionsnotifications = [];
    }
    
    var2 = self.munitionsnotifications.size;
    
    for ( var3 = 0; var3 < var2 ; var3++ )
    {
        if ( var3 < 2 )
        {
            thread movenotificationup( self.munitionsnotifications[ var3 ] );
            continue;
        }
        
        var4 = self.munitionsnotifications[ var3 ];
        self.munitionsnotifications[ var3 ] = undefined;
        var4 notify( "delete_icon_elem" );
    }
    
    var5 = 620;
    var6 = 360;
    var7 = 352;
    var8 = 264;
    var9 = newclienthudelem( self );
    var9.x = var7;
    var9.y = var8;
    var9.alignx = "right";
    var9.aligny = "top";
    var9.sort = 2;
    var9.alpha = 0;
    var10 = scripts\mp\equipment::getequipmenttableinfo( var1 );
    var9 setshader( var10.image, 25, 25 );
    var9 fadeovertime( 0.15 );
    var9 moveovertime( 0.35 );
    var9.alpha = 1;
    var9.x = var5;
    var9.y = var6;
    self.munitionsnotifications = scripts\engine\utility::array_insert( self.munitionsnotifications, var9, 0 );
    var9 endon( "delete_icon_elem" );
    thread ohpcleanupnotificationondeath( var9 );
    var9.isanimating = 1;
    wait 0.35;
    var9.isanimating = 0;
    wait 3;
    var9 fadeovertime( 0.5 );
    var9.alpha = 0;
    wait 0.5;
    var9 notify( "delete_icon_elem" );
}

// Params 1
// Size: 0x37
function ohpcleanupnotificationondeath( var0 )
{
    level endon( "game_ended" );
    scripts\engine\utility::waittill_any_ents( self, "death_or_disconnect", var0, "delete_icon_elem" );
    
    if ( isdefined( self ) )
    {
        self.munitionsnotifications = scripts\engine\utility::array_remove( self.munitionsnotifications, var0 );
    }
    
    var0 destroy();
}

// Params 1
// Size: 0x46
function movenotificationup( var0 )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    var0 endon( "delete_icon_elem" );
    
    if ( !istrue( var0.isanimating ) )
    {
        var0 moveovertime( 0.35 );
    }
    
    var0.y -= 25;
    wait 0.35;
}

// Params 0
// Size: 0x45
function ref_131b3()
{
    self endon( "death_or_disconnect" );
    self endon( "quick_unset" );
    self notify( "setquick_start" );
    self endon( "setquick_start" );
    
    for ( ;; )
    {
        var0 = scripts\engine\utility::ref_143af( "sprint_begin", "sprint_end", "weapon_change", "death" );
        thread set_train_stopped( var0 );
    }
}

// Params 0
// Size: 0x11
function ref_13f6a()
{
    self notify( "quick_unset" );
    self setmovespeedscale( 1 );
}

// Params 1
// Size: 0x85
function set_train_stopped( var0 )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    
    if ( var0 == "sprint_begin" )
    {
        if ( self.lastweaponobj hasattachment( "gunperk_quick" ) )
        {
            self setmovespeedscale( 1.04 );
            return;
        }
        
        return;
    }
    
    if ( var0 == "sprint_end" || var0 == "death" )
    {
        self setmovespeedscale( 1 );
        return;
    }
    
    if ( var0 == "weapon_change" )
    {
        waitframe();
        
        if ( !self.lastweaponobj hasattachment( "gunperk_quick" ) )
        {
            self setmovespeedscale( 1 );
            return;
        }
        
        self setmovespeedscale( 1.04 );
        return;
    }
}

// Params 0
// Size: 0x2
function setoverkillpro()
{
    
}

// Params 0
// Size: 0x2
function unsetoverkillpro()
{
    
}

// Params 0
// Size: 0x2
function setempimmune()
{
    
}

// Params 0
// Size: 0x2
function unsetempimmune()
{
    
}

// Params 0
// Size: 0x14
function setautospot()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    autospotadswatcher();
    autospotdeathwatcher();
}

// Params 0
// Size: 0x24
function autospotdeathwatcher()
{
    self waittill( "death" );
    self endon( "disconnect" );
    self endon( "endAutoSpotAdsWatcher" );
    level endon( "game_ended" );
    self autospotoverlayoff();
}

// Params 0
// Size: 0x17
function unsetautospot()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    self notify( "endAutoSpotAdsWatcher" );
    self autospotoverlayoff();
}

// Params 0
// Size: 0x70
function autospotadswatcher()
{
    self endon( "death_or_disconnect" );
    self endon( "endAutoSpotAdsWatcher" );
    level endon( "game_ended" );
    var0 = 0;
    
    for ( ;; )
    {
        waitframe();
        
        if ( self isusingturret() )
        {
            self autospotoverlayoff();
            continue;
        }
        
        var1 = self playerads();
        
        if ( var1 < 1 && var0 )
        {
            var0 = 0;
            self autospotoverlayoff();
        }
        
        if ( var1 < 1 && !var0 )
        {
            continue;
        }
        
        if ( var1 == 1 && !var0 )
        {
            var0 = 1;
            self autospotoverlayon();
        }
    }
}

// Params 0
// Size: 0x2
function setregenfaster()
{
    
}

// Params 0
// Size: 0x2
function unsetregenfaster()
{
    
}

// Params 0
// Size: 0x26
function timeoutregenfaster()
{
    self.hasregenfaster = undefined;
    scripts\mp\utility\perk::removeperk( "specialty_regenfaster" );
    self setclientdvar( "ui_regen_faster_end_milliseconds", 0 );
    self notify( "timeOutRegenFaster" );
}

// Params 0
// Size: 0xc
function sethardshell()
{
    self.shellshockreduction = 0.25;
}

// Params 0
// Size: 0x8
function unsethardshell()
{
    self.shellshockreduction = 0;
}

// Params 0
// Size: 0x8
function setsharpfocus()
{
    thread monitorsharpfocus();
}

// Params 0
// Size: 0x27
function monitorsharpfocus()
{
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    self endon( "stop_monitorSharpFocus" );
    
    for ( ;; )
    {
        updatesharpfocus();
        self waittill( "weapon_change" );
    }
}

// Params 0
// Size: 0x81
function updatesharpfocus()
{
    var0 = self.currentweapon;
    var1 = undefined;
    var2 = scripts\mp\utility\weapon::ref_14584( var0 );
    
    if ( var2 == 5 )
    {
        var1 = 0.7;
    }
    else if ( var2 == 4 )
    {
        var1 = 0.1;
    }
    else if ( var2 == 2 )
    {
        var1 = 0.05;
    }
    else if ( var2 == 3 )
    {
        var1 = 0.05;
    }
    else if ( var2 == 1 )
    {
        var1 = 0.25;
    }
    else
    {
        var1 = 0.05;
    }
    
    scripts\mp\weapons::updateviewkickscale( var1 );
}

// Params 0
// Size: 0x15
function unsetsharpfocus()
{
    self notify( "stop_monitorSharpFocus" );
    scripts\mp\weapons::updateviewkickscale( 1 );
}

// Params 0
// Size: 0xc2
function updatedefaultflinchreduction()
{
    if ( isagent( self ) )
    {
        return;
    }
    
    var0 = undefined;
    var1 = scripts\mp\utility\weapon::ref_14584( self.currentweapon );
    
    if ( var1 == 5 )
    {
        var0 = 0.7;
    }
    else if ( var1 == 4 )
    {
        var0 = 0.1;
    }
    else if ( var1 == 2 )
    {
        if ( scripts\mp\utility\game::getgametype() == "br" )
        {
            var0 = getdvarfloat( "scr_marksman_flinchscalar", 0.05 );
        }
        else
        {
            var0 = 0.05;
        }
    }
    else if ( var1 == 3 )
    {
        var0 = 0.05;
    }
    else if ( var1 == 1 )
    {
        var0 = 0.25;
    }
    else if ( var1 == 6 )
    {
        var0 = getdvarfloat( "scr_marksman_flinchscalar", 0.05 );
    }
    else
    {
        var0 = 0.05;
    }
    
    scripts\mp\weapons::updateviewkickscale( var0 );
}

// Params 0
// Size: 0x2d
function ref_13121()
{
    self endon( "death_or_disconnect" );
    scripts\mp\utility\perk::giveperk( "specialty_increaseaccuracy" );
    wait getdvarfloat( "scr_gunperk_acquisition_duration", 5 );
    scripts\mp\utility\perk::removeperk( "specialty_increaseaccuracy" );
}

// Params 0
// Size: 0x8
function ref_131d0()
{
    thread ref_11cfc();
}

// Params 0
// Size: 0xa1
function ref_11cfc()
{
    self endon( "tight_grip_unset" );
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    self notifyonplayercommand( "tightgrip_fire", "+attack" );
    self notifyonplayercommand( "tightgrip_fire", "+attack_akimbo_accessible" );
    self notifyonplayercommand( "tightgrip_release", "-attack" );
    self notifyonplayercommand( "tightgrip_release", "-attack_akimbo_accessible" );
    
    for ( ;; )
    {
        self waittill( "tightgrip_fire" );
        
        if ( self.currentweapon hasattachment( "gunperk_tightgrip" ) )
        {
            if ( !scripts\mp\utility\perk::_hasperk( "specialty_tightgrip" ) )
            {
                scripts\mp\utility\perk::giveperk( "specialty_tightgrip" );
            }
            else
            {
                self notify( "tightgrip_continue" );
            }
            
            self waittill( "tightgrip_release" );
            thread lobby_patrol_enemy_watcher();
        }
    }
}

// Params 0
// Size: 0x2e
function lobby_patrol_enemy_watcher()
{
    self endon( "death_or_disconnect" );
    self endon( "tightgrip_continue" );
    wait 0.2;
    
    if ( self hasperk( "specialty_tightgrip" ) )
    {
        scripts\mp\utility\perk::removeperk( "specialty_tightgrip" );
        return;
    }
}

// Params 0
// Size: 0x5e
function ref_13f70()
{
    self notify( "tight_grip_unset" );
    self notifyonplayercommandremove( "tightgrip_fire", "+attack" );
    self notifyonplayercommandremove( "tightgrip_fire", "+attack_akimbo_accessible" );
    self notifyonplayercommandremove( "tightgrip_release", "-attack" );
    self notifyonplayercommandremove( "tightgrip_release", "-attack_akimbo_accessible" );
    
    if ( self hasperk( "specialty_tightgrip" ) )
    {
        scripts\mp\utility\perk::removeperk( "specialty_tightgrip" );
        return;
    }
}

// Params 0
// Size: 0x8
function ref_131b4()
{
    thread ref_11d1a();
}

// Params 0
// Size: 0x5a
function ref_11d1a()
{
    self endon( "death_or_disconnect" );
    self endon( "quickscope_unset" );
    
    for ( ;; )
    {
        if ( self.currentweapon hasattachment( "gunperk_quickscope" ) && self playerads() == 1 )
        {
            thread ref_131b5();
            
            while ( self playerads() == 1 )
            {
                waitframe();
            }
            
            if ( scripts\mp\utility\perk::_hasperk( "specialty_increaseaccuracy" ) )
            {
                scripts\mp\utility\perk::removeperk( "specialty_increaseaccuracy" );
            }
        }
        
        waitframe();
    }
}

// Params 0
// Size: 0x56
function ref_131b5()
{
    self endon( "death_or_disconnect" );
    self notify( "quickscope_accuracy_start" );
    self endon( "quickscope_accuracy_start" );
    self endon( "quickscope_unset" );
    
    if ( !scripts\mp\utility\perk::_hasperk( "specialty_increaseaccuracy" ) )
    {
        scripts\mp\utility\perk::giveperk( "specialty_increaseaccuracy" );
    }
    
    wait 1;
    
    if ( scripts\mp\utility\perk::_hasperk( "specialty_increaseaccuracy" ) )
    {
        scripts\mp\utility\perk::removeperk( "specialty_increaseaccuracy" );
        return;
    }
}

// Params 0
// Size: 0x23
function ref_13f6b()
{
    self notify( "quickscope_unset" );
    
    if ( scripts\mp\utility\perk::_hasperk( "specialty_increaseaccuracy" ) )
    {
        scripts\mp\utility\perk::removeperk( "specialty_increaseaccuracy" );
        return;
    }
}

// Params 0
// Size: 0x8
function ref_13159()
{
    thread ref_11d08();
}

// Params 0
// Size: 0x52
function ref_11d08()
{
    self endon( "death_or_disconnect" );
    self endon( "hardscope_unset" );
    
    for ( ;; )
    {
        if ( self playerads() == 1 )
        {
            thread ref_1315a();
            
            while ( self playerads() == 1 )
            {
                waitframe();
            }
            
            self notify( "hardscope_cancel" );
            
            if ( scripts\mp\utility\perk::_hasperk( "specialty_increaseaccuracy" ) )
            {
                scripts\mp\utility\perk::removeperk( "specialty_increaseaccuracy" );
            }
        }
        
        waitframe();
    }
}

// Params 0
// Size: 0x28
function ref_1315a()
{
    self endon( "death_or_disconnect" );
    self endon( "hardscope_cancel" );
    self endon( "hardscope_unset" );
    wait 0.5;
    scripts\mp\utility\perk::giveperk( "specialty_increaseaccuracy" );
}

// Params 0
// Size: 0x23
function ref_13f65()
{
    self notify( "hardscope_unset" );
    
    if ( scripts\mp\utility\perk::_hasperk( "specialty_increaseaccuracy" ) )
    {
        scripts\mp\utility\perk::removeperk( "specialty_increaseaccuracy" );
        return;
    }
}

// Params 0
// Size: 0x8
function ref_13176()
{
    thread ref_11d13();
}

// Params 0
// Size: 0x5c
function ref_11d13()
{
    self endon( "death_or_disconnect" );
    self endon( "nervesofsteel_unset" );
    
    for ( ;; )
    {
        if ( isdefined( self.health ) && isdefined( self.maxhealth ) && self.health < self.maxhealth )
        {
            scripts\mp\utility\perk::giveperk( "specialty_increaseaccuracy" );
            
            while ( self.health < self.maxhealth )
            {
                waitframe();
            }
            
            scripts\mp\utility\perk::removeperk( "specialty_increaseaccuracy" );
        }
        
        waitframe();
    }
}

// Params 0
// Size: 0x23
function ref_13f66()
{
    self notify( "nervesofsteel_unset" );
    
    if ( scripts\mp\utility\perk::_hasperk( "specialty_increaseaccuracy" ) )
    {
        scripts\mp\utility\perk::removeperk( "specialty_increaseaccuracy" );
        return;
    }
}

// Params 0
// Size: 0x8
function ref_13195()
{
    thread ref_11d15();
}

// Params 0
// Size: 0x5e
function ref_11d15()
{
    self endon( "death_or_disconnect" );
    
    if ( self.currentweapon hasattachment( "gunperk_panic" ) )
    {
        thread ref_13196();
    }
    
    for ( ;; )
    {
        self waittill( "weapon_change" );
        waitframe();
        
        if ( self.currentweapon hasattachment( "gunperk_panic" ) )
        {
            thread ref_13196();
            continue;
        }
        
        if ( scripts\mp\utility\perk::_hasperk( "specialty_increaseaccuracy" ) )
        {
            scripts\mp\utility\perk::removeperk( "specialty_increaseaccuracy" );
        }
    }
}

// Params 0
// Size: 0x48
function ref_13196()
{
    self endon( "death_or_disconnect" );
    self notify( "panic_accuracy_set" );
    self endon( "panic_accuracy_set" );
    self endon( "panic_unset" );
    
    if ( !scripts\mp\utility\perk::_hasperk( "specialty_increaseaccuracy" ) )
    {
        scripts\mp\utility\perk::giveperk( "specialty_increaseaccuracy" );
    }
    
    wait 3;
    scripts\mp\utility\perk::removeperk( "specialty_increaseaccuracy" );
}

// Params 0
// Size: 0x23
function ref_13f68()
{
    self notify( "panic_unset" );
    
    if ( scripts\mp\utility\perk::_hasperk( "specialty_increaseaccuracy" ) )
    {
        scripts\mp\utility\perk::removeperk( "specialty_increaseaccuracy" );
        return;
    }
}

// Params 1
// Size: 0x72
function ammodisabling_run( var0 )
{
    var0 endon( "death_or_disconnect" );
    level endon( "game_ended" );
    
    if ( isdefined( var0.disabledspeedmod ) )
    {
        return;
    }
    else
    {
        var0.disabledspeedmod = -0.05;
    }
    
    var0 shellshock( "chargemode_mp", 0.8 );
    var0 scripts\mp\weapons::updatemovespeedscale();
    ammodisabling_impair( var0 );
    scripts\engine\utility::ref_143b9( 0.8, "death" );
    ammodisabling_impairend( var0 );
    var0.disabledspeedmod = undefined;
    var0 scripts\mp\weapons::updatemovespeedscale();
}

// Params 0
// Size: 0x17
function ammodisabling_impair()
{
    scripts\common\utility::allow_sprint( 0 );
    scripts\common\utility::allow_slide( 0 );
    scripts\common\utility::allow_jump( 0 );
}

// Params 0
// Size: 0x1a
function ammodisabling_impairend()
{
    scripts\common\utility::allow_sprint( 1 );
    scripts\common\utility::allow_slide( 1 );
    scripts\common\utility::allow_jump( 1 );
}

// Params 0
// Size: 0x75
function setviewkickoverride()
{
    self.overrideviewkickscale = 0.05;
    self.ref_1218d = 0.05;
    self.ref_1218f = 0.14;
    self.overrideviewkickscalesniper = 0.26;
    self.overrideviewkickscalepistol = 0.05;
    
    if ( scripts\mp\utility\game::getgametype() == "br" )
    {
        self.ref_1218e = getdvarfloat( "scr_marksman_flinchscalar", 0.05 ) * getdvarfloat( "scr_br_focusperk_scalar", 0.7 );
    }
    else
    {
        self.ref_1218e = 0.05;
    }
    
    scripts\mp\weapons::updateviewkickscale();
}

// Params 0
// Size: 0x2b
function unsetviewkickoverride()
{
    self.overrideviewkickscale = undefined;
    self.ref_1218d = undefined;
    self.ref_1218f = undefined;
    self.ref_1218e = undefined;
    self.overrideviewkickscalesniper = undefined;
    self.overrideviewkickscalepistol = undefined;
    scripts\mp\weapons::updateviewkickscale();
}

// Params 0
// Size: 0x11
function setaffinityspeedboost()
{
    self.weaponaffinityspeedboost = 0.08;
    scripts\mp\weapons::updatemovespeedscale();
}

// Params 0
// Size: 0xd
function unsetaffinityspeedboost()
{
    self.weaponaffinityspeedboost = undefined;
    scripts\mp\weapons::updatemovespeedscale();
}

// Params 0
// Size: 0x88
function setaffinityextralauncher()
{
    self.weaponaffinityextralauncher = 1;
    var0 = scripts\mp\class::buildweapon( self.loadoutprimary, self.loadoutprimaryattachments, self.loadoutprimarycamo, self.loadoutprimaryreticle, self.loadoutprimaryvariantid );
    var1 = scripts\mp\class::buildweapon( self.loadoutsecondary, self.loadoutsecondaryattachments, self.loadoutsecondarycamo, self.loadoutsecondaryreticle, self.loadoutsecondaryvariantid );
    
    if ( scripts\mp\utility\weapon::getweapongroup( var0.basename ) == "weapon_projectile" )
    {
        self setweaponammoclip( var0, weaponclipsize( var0 ) );
    }
    
    if ( scripts\mp\utility\weapon::getweapongroup( var1.basename ) == "weapon_projectile" )
    {
        self setweaponammoclip( var1, weaponclipsize( var1 ) );
        return;
    }
}

// Params 0
// Size: 0x8
function unsetaffinityextralauncher()
{
    self.weaponaffinityextralauncher = undefined;
}

// Params 0
// Size: 0xc6
function setdoubleload()
{
    self endon( "death_or_disconnect" );
    self endon( "endDoubleLoad" );
    level endon( "game_ended" );
    
    for ( ;; )
    {
        self waittill( "reload" );
        var0 = self getweaponslist( "primary" );
        
        foreach ( var2 in var0 )
        {
            var3 = self getweaponammoclip( var2 );
            var4 = weaponclipsize( var2 );
            var5 = var4 - var3;
            var6 = self getweaponammostock( var2 );
            
            if ( var3 != var4 && var6 > 0 )
            {
                if ( var3 + var6 >= var4 )
                {
                    self setweaponammoclip( var2, var4 );
                    self setweaponammostock( var2, var6 - var5 );
                    continue;
                }
                
                self setweaponammoclip( var2, var3 + var6 );
                
                if ( var6 - var5 > 0 )
                {
                    self setweaponammostock( var2, var6 - var5 );
                    continue;
                }
                
                self setweaponammostock( var2, 0 );
            }
        }
    }
}

// Params 0
// Size: 0xa
function unsetdoubleload()
{
    self notify( "endDoubleLoad" );
}

// Params 1
// Size: 0x27
function setmarksman( var0 )
{
    
}

// Params 0
// Size: 0x10
function unsetmarksman()
{
    
}

// Params 0
// Size: 0x8
function setfastcrouch()
{
    thread watchfastcrouch();
}

// Params 0
// Size: 0x66
function watchfastcrouch()
{
    self endon( "death_or_disconnect" );
    self endon( "fastcrouch_unset" );
    
    for ( ;; )
    {
        var0 = ( self getstance() == "crouch" || self getstance() == "prone" ) && !self issprintsliding();
        
        if ( !isdefined( self.fastcrouchspeedmod ) )
        {
            if ( var0 )
            {
                self.fastcrouchspeedmod = 0.25;
                scripts\mp\weapons::updatemovespeedscale();
            }
        }
        else if ( !var0 )
        {
            self.fastcrouchspeedmod = undefined;
            scripts\mp\weapons::updatemovespeedscale();
        }
        
        waitframe();
    }
}

// Params 0
// Size: 0x1f
function unsetfastcrouch()
{
    self notify( "fastcrouch_unset" );
    
    if ( isdefined( self.fastcrouchspeedmod ) )
    {
        self.fastcrouchspeedmod = undefined;
        scripts\mp\weapons::updatemovespeedscale();
        return;
    }
}

// Params 0
// Size: 0x1a
function setrshieldradar()
{
    self endon( "unsetRShieldRadar" );
    wait 0.75;
    self makeportableradar();
    thread setrshieldradar_cleanup();
}

// Params 0
// Size: 0x1c
function setrshieldradar_cleanup()
{
    self endon( "unsetRShieldRadar" );
    self waittill( "death_or_disconnect" );
    
    if ( isdefined( self ) )
    {
        unsetrshieldradar();
        return;
    }
}

// Params 0
// Size: 0xf
function unsetrshieldradar()
{
    self clearportableradar();
    self notify( "unsetRShieldRadar" );
}

// Params 0
// Size: 0xd
function setrshieldscrambler()
{
    self makescrambler();
    thread setrshieldscrambler_cleanup();
}

// Params 0
// Size: 0x1c
function setrshieldscrambler_cleanup()
{
    self endon( "unsetRShieldScrambler" );
    self waittill( "death_or_disconnect" );
    
    if ( isdefined( self ) )
    {
        unsetrshieldscrambler();
        return;
    }
}

// Params 0
// Size: 0xf
function unsetrshieldscrambler()
{
    self clearscrambler();
    self notify( "unsetRShieldScrambler" );
}

// Params 1
// Size: 0x40
function setstunresistance( var0 )
{
    if ( !isdefined( var0 ) )
    {
        if ( scripts\mp\utility\game::unset_relic_grounded() )
        {
            var0 = getdvarint( "scr_br_perkstun_resistance_scalar", 2 );
        }
        else
        {
            var0 = 4;
        }
    }
    
    var0 = int( var0 );
    
    if ( var0 == 10 )
    {
        self.ãÆÊ:]s‰ Õ•nËÕçcì = 0;
        return;
    }
    
    self.ãÆÊ:]s‰ Õ•nËÕçcì = var0 / 10;
}

// Params 0
// Size: 0x9
function unsetstunresistance()
{
    self.ãÆÊ:]s‰ Õ•nËÕçcì = 1;
}

// Params 1
// Size: 0x16
function setstunmore( var0 )
{
    self.í„RkÔMX2	ó^Jóª = getdvarfloat( "perk_stun_more_scalar", 1.4 );
}

// Params 0
// Size: 0x9
function unsetstunmore()
{
    self.í„RkÔMX2	ó^Jóª = 1;
}

// Params 1
// Size: 0x47
function getstunscalartype( var0 )
{
    var1 = var0 scripts\mp\utility\perk::_hasperk( "specialty_stun_resistance" );
    var2 = var0 scripts\mp\utility\perk::_hasperk( "penalty_stun_more" );
    
    if ( var1 && !var2 )
    {
        return "stun_less";
    }
    else if ( var2 && !var1 )
    {
        return "stun_more";
    }
    
    return "stun_normal";
}

// Params 3
// Size: 0xf6
function applystunresistence( var0, var1, var2 )
{
    var3 = getstunscalartype( var1 );
    
    if ( var3 == "stun_less" && var0 != var1 )
    {
        if ( isdefined( var1.ãÆÊ:]s‰ Õ•nËÕçcì ) && isdefined( var2 ) )
        {
            var2 *= var1.ãÆÊ:]s‰ Õ•nËÕçcì;
        }
        
        var4 = scripts\engine\utility::ter_op( isdefined( var0.owner ), var0.owner, var0 );
        var5 = scripts\engine\utility::ter_op( isdefined( var1.owner ), var1.owner, var1 );
        
        if ( isplayer( var4 ) && var4 != var1 )
        {
            var0 scripts\mp\damagefeedback::updatedamagefeedback( "hittacresist", undefined, undefined, undefined, 1 );
        }
        
        if ( istrue( scripts\cp_mp\utility\player_utility::playersareenemies( var4, var5 ) ) )
        {
            var1 scripts\cp\vehicles\vehicle_compass_cp::resistedstun( var4 );
        }
    }
    else if ( !istrue( var1 scripts\mp\utility\player::is_allowed_to_be_stunned() ) )
    {
        var2 = 0;
    }
    else if ( var3 == "stun_more" && var0 != var1 )
    {
        if ( isdefined( var1.í„RkÔMX2	ó^Jóª ) && isdefined( var2 ) )
        {
            var2 *= var1.í„RkÔMX2	ó^Jóª;
        }
    }
    
    if ( var1 scripts\mp\utility\game::ismatchstartprotected() )
    {
        var2 *= 0.1;
    }
    
    return var2;
}

// Params 0
// Size: 0x1d
function setweaponlaser()
{
    if ( isagent( self ) )
    {
        return;
    }
    
    self endon( "unsetWeaponLaser" );
    wait 0.5;
    thread setweaponlaser_internal();
}

// Params 0
// Size: 0x2d
function unsetweaponlaser()
{
    self notify( "unsetWeaponLaser" );
    
    if ( isdefined( self.perkweaponlaseron ) && self.perkweaponlaseron )
    {
        scripts\mp\utility\weapon::disableweaponlaser();
    }
    
    self.perkweaponlaseron = undefined;
    self.perkweaponlaseroffforswitchstart = undefined;
}

// Params 1
// Size: 0x3f
function setweaponlaser_waitforlaserweapon( var0 )
{
    for ( var0 = getweaponbasename( var0 );  ; var0 = var1.basename )
    {
        if ( isdefined( var0 ) && ( var0 == "iw6_kac_mp" || var0 == "iw6_arx160_mp" ) )
        {
            break;
        }
        
        self waittill( "weapon_change", var1 );
    }
}

// Params 0
// Size: 0x71
function setweaponlaser_internal()
{
    self endon( "death_or_disconnect" );
    self endon( "unsetWeaponLaser" );
    self.perkweaponlaseron = 0;
    var0 = self getcurrentweapon();
    setweaponlaser_waitforlaserweapon( var0 );
    
    if ( self.perkweaponlaseron == 0 )
    {
        self.perkweaponlaseron = 1;
        scripts\mp\utility\weapon::enableweaponlaser();
    }
    
    GscBinSkip4( 0x35 );
    // Unknown operator ( 0x35, iw8, PC )
}

// Params 1
// Size: 0x1d
function setweaponlaser_monitorweaponswitchstart( var0 )
{
    self endon( "weapon_change" );
    self waittill( "weapon_switch_started" );
    GscBinSkip4( 0x35, var0 );
    // Unknown operator ( 0x35, iw8, PC )
}

// Params 1
// Size: 0x5c
function setweaponlaser_onweaponswitchstart( var0 )
{
    self notify( "setWeaponLaser_onWeaponSwitchStart" );
    self endon( "setWeaponLaser_onWeaponSwitchStart" );
    
    if ( self.perkweaponlaseron == 1 )
    {
        self.perkweaponlaseroffforswitchstart = 1;
        self.perkweaponlaseron = 0;
        scripts\mp\utility\weapon::disableweaponlaser();
    }
    
    wait var0;
    self.perkweaponlaseroffforswitchstart = undefined;
    
    if ( self.perkweaponlaseron == 0 && self playerads() <= 0.6 )
    {
        self.perkweaponlaseron = 1;
        scripts\mp\utility\weapon::enableweaponlaser();
        return;
    }
}

// Params 0
// Size: 0x5f
function setweaponlaser_monitorads()
{
    self endon( "weapon_change" );
    
    for ( ;; )
    {
        if ( !isdefined( self.perkweaponlaseroffforswitchstart ) || self.perkweaponlaseroffforswitchstart == 0 )
        {
            if ( self playerads() > 0.6 )
            {
                if ( self.perkweaponlaseron == 1 )
                {
                    self.perkweaponlaseron = 0;
                    scripts\mp\utility\weapon::disableweaponlaser();
                }
            }
            else if ( self.perkweaponlaseron == 0 )
            {
                self.perkweaponlaseron = 1;
                scripts\mp\utility\weapon::enableweaponlaser();
            }
        }
        
        waitframe();
    }
}

// Params 0
// Size: 0xc
function setsteadyaimpro()
{
    self setaimspreadmovementscale( 0.5 );
}

// Params 0
// Size: 0x14
function unsetsteadyaimpro()
{
    self notify( "end_SteadyAimPro" );
    self setaimspreadmovementscale( 1 );
}

// Params 0
// Size: 0x17
function perkusedeathtracker()
{
    self endon( "disconnect" );
    self waittill( "death" );
    self._useperkenabled = undefined;
}

// Params 0
// Size: 0x5e
function setendgame()
{
    if ( isdefined( self.endgame ) )
    {
        return;
    }
    
    self.maxhealth = scripts\mp\tweakables::gettweakablevalue( "player", "maxhealth" ) * 4;
    self.health = self.maxhealth;
    self.endgame = 1;
    self.attackertable[ 0 ] = "";
    self visionsetnakedforplayer( "end_game", 5 );
    thread endgamedeath( 7 );
    scripts\mp\gamelogic::sethasdonecombat( self, 1 );
}

// Params 0
// Size: 0x38
function unsetendgame()
{
    self notify( "stopEndGame" );
    self.endgame = undefined;
    scripts\mp\utility\player::restorebasevisionset( 1 );
    
    if ( !isdefined( self.endgametimer ) )
    {
        return;
    }
    
    self.endgametimer scripts\mp\hud_util::destroyelem();
    self.endgameicon scripts\mp\hud_util::destroyelem();
}

// Params 1
// Size: 0x2a
function endgamedeath( var0 )
{
    self endon( "death_or_disconnect" );
    self endon( "joined_team" );
    level endon( "game_ended" );
    self endon( "stopEndGame" );
    wait var0 + 1;
    scripts\mp\utility\damage::_suicide();
}

// Params 0
// Size: 0xc
function setsaboteur()
{
    self.objectivescaler = 1.2;
}

// Params 0
// Size: 0x9
function unsetsaboteur()
{
    self.objectivescaler = 1;
}

// Params 0
// Size: 0x7a
function setcombatspeed()
{
    self endon( "death_or_disconnect" );
    self endon( "unsetCombatSpeed" );
    self.incombatspeed = 0;
    unsetcombatspeedscalar();
    
    for ( ;; )
    {
        self waittill( "damage", var0, var1 );
        
        if ( !isdefined( var1.team ) )
        {
            continue;
        }
        
        if ( level.teambased && var1.team == self.team )
        {
            continue;
        }
        
        if ( self.incombatspeed )
        {
            continue;
        }
        
        setcombatspeedscalar();
        self.incombatspeed = 1;
        thread endofspeedwatcher();
    }
}

// Params 0
// Size: 0x2b
function endofspeedwatcher()
{
    self notify( "endOfSpeedWatcher" );
    self endon( "endOfSpeedWatcher" );
    self endon( "death_or_disconnect" );
    self waittill( "healed" );
    unsetcombatspeedscalar();
    self.incombatspeed = 0;
}

// Params 0
// Size: 0x4b
function setcombatspeedscalar()
{
    if ( self.weaponspeed <= 0.8 )
    {
        self.combatspeedscalar = 1.4;
    }
    else if ( self.weaponspeed <= 0.9 )
    {
        self.combatspeedscalar = 1.3;
    }
    else
    {
        self.combatspeedscalar = 1.2;
    }
    
    scripts\mp\weapons::updatemovespeedscale();
}

// Params 0
// Size: 0xe
function unsetcombatspeedscalar()
{
    self.combatspeedscalar = 1;
    scripts\mp\weapons::updatemovespeedscale();
}

// Params 0
// Size: 0xf
function unsetcombatspeed()
{
    unsetcombatspeedscalar();
    self notify( "unsetCombatSpeed" );
}

// Params 0
// Size: 0x1a
function setlightweight()
{
    if ( !isdefined( self.cranked ) )
    {
        self.movespeedscaler = scripts\mp\utility\perk::lightweightscalar();
        scripts\mp\weapons::updatemovespeedscale();
        return;
    }
}

// Params 0
// Size: 0xe
function unsetlightweight()
{
    self.movespeedscaler = 1;
    scripts\mp\weapons::updatemovespeedscale();
}

// Params 0
// Size: 0x2
function setblackbox()
{
    
}

// Params 0
// Size: 0x2
function unsetblackbox()
{
    
}

// Params 0
// Size: 0x18
function setsteelnerves()
{
    scripts\mp\utility\perk::giveperk( "specialty_bulletaccuracy" );
    scripts\mp\utility\perk::giveperk( "specialty_holdbreath" );
}

// Params 0
// Size: 0x18
function unsetsteelnerves()
{
    scripts\mp\utility\perk::removeperk( "specialty_bulletaccuracy" );
    scripts\mp\utility\perk::removeperk( "specialty_holdbreath" );
}

// Params 0
// Size: 0x2
function setdelaymine()
{
    
}

// Params 0
// Size: 0x2
function unsetdelaymine()
{
    
}

// Params 0
// Size: 0xf
function setlocaljammer()
{
    if ( scripts\cp_mp\emp_debuff::is_empd() )
    {
        self makescrambler();
        return;
    }
}

// Params 0
// Size: 0x7
function unsetlocaljammer()
{
    self clearscrambler();
}

// Params 0
// Size: 0x7
function setthermal()
{
    self thermalvisionon();
}

// Params 0
// Size: 0x7
function unsetthermal()
{
    self thermalvisionoff();
}

// Params 0
// Size: 0x8
function setonemanarmy()
{
    thread onemanarmyweaponchangetracker();
}

// Params 0
// Size: 0xa
function unsetonemanarmy()
{
    self notify( "stop_oneManArmyTracker" );
}

// Params 0
// Size: 0x41
function onemanarmyweaponchangetracker()
{
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    self endon( "stop_oneManArmyTracker" );
    
    for ( ;; )
    {
        self waittill( "weapon_change", var0 );
        
        if ( var0.basename != "onemanarmy_mp" )
        {
            continue;
        }
        
        thread selectonemanarmyclass();
    }
}

// Params 1
// Size: 0x49, Type: bool
function isonemanarmymenu( var0 )
{
    if ( var0 == game[ "menu_onemanarmy" ] )
    {
        return true;
    }
    
    if ( isdefined( game[ "menu_onemanarmy_defaults_splitscreen" ] ) && var0 == game[ "menu_onemanarmy_defaults_splitscreen" ] )
    {
        return true;
    }
    
    if ( isdefined( game[ "menu_onemanarmy_custom_splitscreen" ] ) && var0 == game[ "menu_onemanarmy_custom_splitscreen" ] )
    {
        return true;
    }
    
    return false;
}

// Params 0
// Size: 0xcc
function selectonemanarmyclass()
{
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    scripts\common\utility::allow_weapon_switch( 0 );
    scripts\common\utility::allow_offhand_weapons( 0 );
    scripts\common\utility::allow_usability( 0 );
    thread closeomamenuondeath();
    self waittill( "menuresponse", var0, var1 );
    scripts\common\utility::allow_weapon_switch( 1 );
    scripts\common\utility::allow_offhand_weapons( 1 );
    scripts\common\utility::allow_usability( 1 );
    
    if ( var1 == "back" || !isonemanarmymenu( var0 ) || scripts\mp\utility\player::isusingremote() )
    {
        var2 = self getcurrentweapon();
        
        if ( var2.basename == "onemanarmy_mp" )
        {
            scripts\common\utility::allow_weapon_switch( 0 );
            scripts\common\utility::allow_offhand_weapons( 0 );
            scripts\common\utility::allow_usability( 0 );
            scripts\cp_mp\utility\inventory_utility::_switchtoweapon( scripts\mp\utility\inventory::getlastweapon() );
            self waittill( "weapon_change" );
            scripts\common\utility::allow_weapon_switch( 1 );
            scripts\common\utility::allow_offhand_weapons( 1 );
            scripts\common\utility::allow_usability( 1 );
        }
        
        return;
    }
    
    thread giveonemanarmyclass( var2 );
}

// Params 0
// Size: 0x37
function closeomamenuondeath()
{
    self endon( "menuresponse" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self waittill( "death" );
    scripts\common\utility::allow_weapon_switch( 1 );
    scripts\common\utility::allow_offhand_weapons( 1 );
    scripts\common\utility::allow_usability( 1 );
}

// Params 1
// Size: 0xcb
function giveonemanarmyclass( var0 )
{
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    
    if ( scripts\mp\utility\perk::_hasperk( "specialty_omaquickchange" ) )
    {
        var1 = 3;
        scripts\mp\utility\sound::playplayerandnpcsounds( self, "foly_onemanarmy_bag3_plr", "foly_onemanarmy_bag3_npc" );
    }
    else
    {
        var1 = 6;
        scripts\mp\utility\sound::playplayerandnpcsounds( self, "foly_onemanarmy_bag6_plr", "foly_onemanarmy_bag6_npc" );
    }
    
    thread omausebar( var1 );
    scripts\common\utility::allow_weapon( 0 );
    scripts\common\utility::allow_offhand_weapons( 0 );
    scripts\common\utility::allow_usability( 0 );
    wait var1;
    scripts\common\utility::allow_weapon( 1 );
    scripts\common\utility::allow_offhand_weapons( 1 );
    scripts\common\utility::allow_usability( 1 );
    scripts\mp\class::giveloadout( self.pers[ "team" ], var1 );
    
    if ( isdefined( self.carryflag ) )
    {
        self attach( self.carryflag, "J_spine4", 1 );
    }
    
    self notify( "changed_kit" );
    level notify( "changed_kit" );
    scripts\mp\rank::tryresetrankxp();
}

// Params 1
// Size: 0x65
function omausebar( var0 )
{
    self endon( "disconnect" );
    var1 = scripts\mp\hud_util::createprimaryprogressbar();
    var2 = scripts\mp\hud_util::createprimaryprogressbartext();
    var2 settext( &"MPUI_CHANGING_KIT" );
    var1 scripts\mp\hud_util::updatebar( 0, 1 / var0 );
    var3 = 0;
    
    while ( var3 < var0 && isalive( self ) && !level.gameended )
    {
        wait 0.05;
        var3 += 0.05;
    }
    
    var1 scripts\mp\hud_util::destroyelem();
    var2 scripts\mp\hud_util::destroyelem();
}

// Params 0
// Size: 0x2c
function setafterburner()
{
    self energy_setrestorerate( 0, scripts\engine\utility::ter_op( scripts\mp\utility\game::isanymlgmatch(), 600, 1000 ) );
    self energy_setresttimems( 0, scripts\engine\utility::ter_op( scripts\mp\utility\game::isanymlgmatch(), 750, 750 ) );
}

// Params 0
// Size: 0x14
function unsetafterburner()
{
    self energy_setrestorerate( 0, 400 );
    self energy_setresttimems( 0, 900 );
}

// Params 0
// Size: 0x2
function setblastshield()
{
    
}

// Params 0
// Size: 0x2
function unsetblastshield()
{
    
}

// Params 1
// Size: 0x4
function toggleblastshield( var0 )
{
    
}

// Params 2
// Size: 0x40
function blastshieldusetracker( var0, var1 )
{
    self endon( "death_or_disconnect" );
    self endon( "end_perkUseTracker" );
    level endon( "game_ended" );
    
    for ( ;; )
    {
        self waittill( "empty_offhand" );
        
        if ( !scripts\common\utility::is_offhand_weapons_allowed() )
        {
            continue;
        }
        
        self [[ var1 ]]( scripts\mp\utility\perk::_hasperk( "specialty_blastshield" ) );
    }
}

// Params 0
// Size: 0x2
function setfreefall()
{
    
}

// Params 0
// Size: 0x2
function unsetfreefall()
{
    
}

// Params 0
// Size: 0x12
function settacticalinsertion()
{
    scripts\mp\equipment::giveequipment( "equip_tac_insert", "secondary" );
}

// Params 0
// Size: 0x2
function unsettacticalinsertion()
{
    
}

// Params 1
// Size: 0x59
function setpainted( var0 )
{
    if ( isplayer( self ) )
    {
        var1 = 0.5;
        
        if ( !scripts\mp\utility\perk::_hasperk( "specialty_engineer" ) && !scripts\mp\utility\perk::_hasperk( "specialty_noscopeoutline" ) )
        {
            self.painted = 1;
            var2 = scripts\mp\utility\outline::outlineenableforplayer( self, var0, "outline_nodepth_orange", "perk" );
            thread watchpainted( var2, var1 );
            thread watchpaintedagain( var2 );
            return;
        }
        
        return;
    }
}

// Params 2
// Size: 0x44
function watchpainted( var0, var1 )
{
    self notify( "painted_again" );
    self endon( "painted_again" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    scripts\engine\utility::ref_143b9( var1, "death" );
    self.painted = 0;
    scripts\mp\utility\outline::outlinedisable( var0, self );
    self notify( "painted_end" );
}

// Params 1
// Size: 0x2a
function watchpaintedagain( var0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    scripts\engine\utility::ref_143a5( "painted_again", "painted_end" );
    scripts\mp\utility\outline::outlinedisable( var0, self );
}

// Params 0
// Size: 0x12, Type: bool
function ispainted()
{
    return isdefined( self.painted ) && self.painted;
}

// Params 0
// Size: 0x2
function setassists()
{
    
}

// Params 0
// Size: 0x2
function unsetassists()
{
    
}

// Params 0
// Size: 0x29
function setrefillgrenades()
{
    if ( isdefined( self.primarygrenade ) )
    {
        self givemaxammo( self.primarygrenade );
    }
    
    if ( isdefined( self.secondarygrenade ) )
    {
        self givemaxammo( self.secondarygrenade );
        return;
    }
}

// Params 0
// Size: 0x2
function unsetrefillgrenades()
{
    
}

// Params 0
// Size: 0x29
function setrefillammo()
{
    if ( isdefined( self.primaryweapon ) )
    {
        self givemaxammo( self.primaryweapon );
    }
    
    if ( isdefined( self.secondaryweapon ) )
    {
        self givemaxammo( self.secondaryweapon );
        return;
    }
}

// Params 0
// Size: 0x2
function unsetrefillammo()
{
    
}

// Params 0
// Size: 0x2
function setcomexp()
{
    
}

// Params 0
// Size: 0x2
function unsetcomexp()
{
    
}

// Params 0
// Size: 0x8
function settagger()
{
    thread settaggerinternal();
}

// Params 0
// Size: 0xb2
function settaggerinternal()
{
    self endon( "death_or_disconnect" );
    self endon( "unsetTagger" );
    level endon( "game_ended" );
    
    for ( ;; )
    {
        self waittill( "eyesOn" );
        var0 = self getplayerssightingme();
        
        foreach ( var2 in var0 )
        {
            if ( level.teambased && var2.team == self.team )
            {
                continue;
            }
            
            if ( isalive( var2 ) && var2.sessionstate == "playing" )
            {
                if ( !isdefined( var2.perkoutlined ) )
                {
                    var2.perkoutlined = 0;
                }
                
                if ( !var2.perkoutlined )
                {
                    var2.perkoutlined = 1;
                }
                
                thread outlinewatcher( var2 );
            }
        }
    }
}

// Params 1
// Size: 0x74
function outlinewatcher( var0 )
{
    self endon( "death_or_disconnect" );
    self endon( "eyesOff" );
    level endon( "game_ended" );
    
    for ( ;; )
    {
        var1 = 1;
        var2 = var0 getplayerssightingme();
        
        foreach ( var4 in var2 )
        {
            if ( var4 == self )
            {
                var1 = 0;
                break;
            }
        }
        
        if ( var1 )
        {
            self.perkoutlined = 0;
            self notify( "eyesOff" );
        }
        
        wait 0.5;
    }
}

// Params 0
// Size: 0xa
function unsettagger()
{
    self notify( "unsetTagger" );
}

// Params 0
// Size: 0x8
function setpitcher()
{
    thread setpitcherinternal();
}

// Params 0
// Size: 0x78
function setpitcherinternal()
{
    self endon( "death_or_disconnect" );
    self endon( "unsetPitcher" );
    level endon( "game_ended" );
    self setgrenadecookscale( 1.5 );
    
    for ( ;; )
    {
        self setgrenadethrowscale( 1.25 );
        self waittill( "grenade_pullback", var0 );
        var1 = var0.basename;
        
        if ( var1 == "airdrop_marker_mp" || var1 == "deployable_vest_marker_mp" || var1 == "deployable_weapon_crate_marker_mp" )
        {
            self setgrenadethrowscale( 1 );
        }
        
        self waittill( "grenade_fire", var2, var0 );
    }
}

// Params 0
// Size: 0x18
function unsetpitcher()
{
    self setgrenadecookscale( 1 );
    self setgrenadethrowscale( 1 );
    self notify( "unsetPitcher" );
}

// Params 0
// Size: 0x2
function setboom()
{
    
}

// Params 1
// Size: 0x3e
function setboominternal( var0 )
{
    self endon( "death_or_disconnect" );
    self endon( "unsetBoom" );
    level endon( "game_ended" );
    var0 endon( "death_or_disconnect" );
    waitframe();
    triggerportableradarping( self.origin, var0, 800, 1500 );
    boomtrackplayers( var0, self.origin, self );
}

// Params 2
// Size: 0x5b
function boomtrackplayers( var0, var1 )
{
    var2 = scripts\common\utility::playersinsphere( var0, 700 );
    
    foreach ( var4 in var2 )
    {
        if ( var1 == var4 )
        {
            continue;
        }
        
        if ( scripts\mp\utility\player::isenemy( var4 ) && isalive( var4 ) && !var4 scripts\mp\utility\perk::_hasperk( "specialty_gpsjammer" ) )
        {
        }
    }
}

// Params 2
// Size: 0x51
function boomtrackplayerdeath( var0, var1 )
{
    self endon( "disconnect" );
    var0 endon( "removearchetype" );
    var2 = scripts\engine\utility::ref_143b9( 7, "death" );
    
    if ( var2 == "timeout" && isdefined( self.markedbyboomperk[ var1 ] ) )
    {
        self.markedbyboomperk[ var1 ] = undefined;
        return;
    }
    
    self waittill( "spawned_player" );
    self.markedbyboomperk = undefined;
}

// Params 0
// Size: 0xa
function unsetboom()
{
    self notify( "unsetBoom" );
}

// Params 1
// Size: 0xa3
function customjuiced( var0 )
{
    self endon( "death_or_disconnect" );
    self endon( "faux_spawn" );
    self endon( "unset_custom_juiced" );
    level endon( "game_ended" );
    self.isjuiced = 1;
    self.movespeedscaler = 1.1;
    scripts\mp\weapons::updatemovespeedscale();
    scripts\mp\utility\perk::giveperk( "specialty_fastreload" );
    scripts\mp\utility\perk::giveperk( "specialty_quickdraw" );
    scripts\mp\utility\perk::giveperk( "specialty_stalker" );
    scripts\mp\utility\perk::giveperk( "specialty_fastoffhand" );
    scripts\mp\utility\perk::giveperk( "specialty_fastsprintrecovery" );
    scripts\mp\utility\perk::giveperk( "specialty_quickswap" );
    thread unsetcustomjuicedondeath();
    thread unsetcustomjuicedonride();
    thread unsetcustomjuicedonmatchend();
    var1 = var0 * 1000 + gettime();
    
    if ( isai( self ) )
    {
    }
    
    wait var0;
    unsetcustomjuiced();
}

// Params 1
// Size: 0x82
function unsetcustomjuiced( var0 )
{
    if ( !isdefined( var0 ) )
    {
        self.movespeedscaler = 1;
        
        if ( scripts\mp\utility\perk::_hasperk( "specialty_lightweight" ) )
        {
            self.movespeedscaler = scripts\mp\utility\perk::lightweightscalar();
        }
        
        scripts\mp\weapons::updatemovespeedscale();
    }
    
    scripts\mp\utility\perk::removeperk( "specialty_fastreload" );
    scripts\mp\utility\perk::removeperk( "specialty_quickdraw" );
    scripts\mp\utility\perk::removeperk( "specialty_stalker" );
    scripts\mp\utility\perk::removeperk( "specialty_fastoffhand" );
    scripts\mp\utility\perk::removeperk( "specialty_fastsprintrecovery" );
    scripts\mp\utility\perk::removeperk( "specialty_quickswap" );
    self.isjuiced = undefined;
    
    if ( isai( self ) )
    {
    }
    
    self notify( "unset_custom_juiced" );
}

// Params 0
// Size: 0x26
function unsetcustomjuicedonride()
{
    self endon( "disconnect" );
    self endon( "unset_custom_juiced" );
    
    for ( ;; )
    {
        waitframe();
        
        if ( scripts\mp\utility\player::isusingremote() )
        {
            thread unsetcustomjuiced();
            break;
        }
    }
}

// Params 0
// Size: 0x28
function unsetcustomjuicedondeath()
{
    self endon( "disconnect" );
    self endon( "unset_custom_juiced" );
    scripts\engine\utility::ref_143a5( "death", "faux_spawn" );
    thread unsetcustomjuiced( 1 );
}

// Params 0
// Size: 0x27
function unsetcustomjuicedonmatchend()
{
    self endon( "disconnect" );
    self endon( "unset_custom_juiced" );
    level scripts\engine\utility::ref_143a5( "round_end_finished", "game_ended" );
    thread unsetcustomjuiced();
}

// Params 0
// Size: 0x2
function settriggerhappy()
{
    
}

// Params 0
// Size: 0x82
function settriggerhappyinternal()
{
    self endon( "death_or_disconnect" );
    self endon( "unsetTriggerHappy" );
    level endon( "game_ended" );
    var0 = self.lastdroppableweaponobj;
    var1 = self getweaponammostock( var0 );
    var2 = self getweaponammoclip( var0 );
    self givestartammo( var0 );
    var3 = self getweaponammoclip( var0 );
    var4 = var3 - var2;
    var5 = var1 - var4;
    
    if ( var4 > var1 )
    {
        self setweaponammoclip( var0, var2 + var1 );
        var5 = 0;
    }
    
    self setweaponammostock( var0, var5 );
    self playlocalsound( "ammo_crate_use" );
    self setclientomnvar( "ui_trigger_happy", 1 );
    wait 0.2;
    self setclientomnvar( "ui_trigger_happy", 0 );
}

// Params 0
// Size: 0x15
function unsettriggerhappy()
{
    self setclientomnvar( "ui_trigger_happy", 0 );
    self notify( "unsetTriggerHappy" );
}

// Params 0
// Size: 0x2
function setincog()
{
    
}

// Params 0
// Size: 0x2
function unsetincog()
{
    
}

// Params 0
// Size: 0x2
function setblindeye()
{
    
}

// Params 0
// Size: 0x2
function unsetblindeye()
{
    
}

// Params 0
// Size: 0x2
function setquickswap()
{
    
}

// Params 0
// Size: 0x2
function unsetquickswap()
{
    
}

// Params 0
// Size: 0x85
function setextraammo()
{
    self endon( "death_or_disconnect" );
    self endon( "unset_extraammo" );
    level endon( "game_ended" );
    
    if ( self.gettingloadout )
    {
        self waittill( "giveLoadout" );
    }
    
    var0 = scripts\mp\utility\weapon::getvalidextraammoweapons();
    
    foreach ( var2 in var0 )
    {
        if ( isdefined( var2 ) && !nullweapon( var2 ) && var2 hasattachment( "maxammo", 1 ) && !istrue( var2.first_equipped ) )
        {
            self givemaxammo( var2 );
            var2.first_equipped = 1;
        }
    }
}

// Params 0
// Size: 0xa
function unsetextraammo()
{
    self notify( "unset_extraammo" );
}

// Params 0
// Size: 0x65
function setextraequipment()
{
    self endon( "death_or_disconnect" );
    self endon( "unset_extraequipment" );
    level endon( "game_ended" );
    
    if ( self.gettingloadout )
    {
        self waittill( "giveLoadout" );
    }
    
    var0 = self.loadoutperkoffhand;
    
    if ( isdefined( var0 ) && var0 != "specialty_null" )
    {
        if ( var0 != "specialty_tacticalinsertion" && var0 != "smoke_grenade_mp" && var0 != "player_trophy_system_mp" )
        {
            self setweaponammoclip( var0, 2 );
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0xa
function unsetextraequipment()
{
    self notify( "unset_extraequipment" );
}

// Params 0
// Size: 0x4a
function setextradeadly()
{
    self endon( "death_or_disconnect" );
    self endon( "unset_extradeadly" );
    level endon( "game_ended" );
    
    if ( self.gettingloadout )
    {
        self waittill( "giveLoadout" );
    }
    
    var0 = scripts\mp\equipment::getcurrentequipment( "primary" );
    
    if ( isdefined( var0 ) && var0 != "none" )
    {
        scripts\mp\equipment::incrementequipmentammo( var0 );
        return;
    }
}

// Params 0
// Size: 0xa
function unsetextradeadly()
{
    self notify( "unset_extradeadly" );
}

// Params 0
// Size: 0x2
function setbattleslide()
{
    
}

// Params 0
// Size: 0x2
function unsetbattleslide()
{
    
}

// Params 0
// Size: 0x2
function setoverkill()
{
    
}

// Params 0
// Size: 0x2
function unsetoverkill()
{
    
}

// Params 0
// Size: 0x2
function setactivereload()
{
    
}

// Params 0
// Size: 0x2
function unsetactivereload()
{
    
}

// Params 0
// Size: 0x22
function setlifepack()
{
    if ( !isdefined( level._effect[ "life_pack_pickup" ] ) )
    {
        level._effect[ "life_pack_pickup" ] = undefined;
    }
    
    thread watchlifepackkills();
}

// Params 0
// Size: 0x10a
function watchlifepackkills()
{
    self endon( "death_or_disconnect" );
    self notify( "unset_lifepack" );
    self endon( "unset_lifepack" );
    
    for ( ;; )
    {
        self waittill( "got_a_kill", var0, var1, var2 );
        var3 = self.origin;
        var4 = 20;
        var5 = 20;
        var6 = spawn( "script_model", self.origin + ( 0, 0, 10 ) );
        var6 setmodel( "weapon_life_pack" );
        var6.owner = self;
        var6.team = self.team;
        var6 hidefromplayer( self );
        var7 = spawn( "trigger_radius", self.origin, 0, var4, var5 );
        thread watchlifepackuse( var7 );
        thread watchlifepackdeath( var7 );
        thread hoverlifepack();
        var6 rotateyaw( 1000, 30, 0.2, 0.2 );
        thread watchlifepacklifetime( var6, 10 );
        thread watchlifepackowner();
        
        foreach ( var9 in level.players )
        {
            setlifepackvisualforplayer( var6, var9 );
        }
    }
}

// Params 3
// Size: 0x62
function activatelifepackboost( var0, var1, var2 )
{
    self.lifeboostactive = 1;
    
    if ( isdefined( var1 ) && var1 > 0 )
    {
        thread watchlifepackboostlifetime( var1 );
    }
    
    if ( isdefined( var2 ) && var2 )
    {
        thread watchlifepackuserdeath();
    }
    
    scripts\mp\utility\perk::giveperk( "specialty_regenfaster" );
    self setclientomnvar( "ui_life_link", 1 );
    self notify( "enabled_life_pack_boost" );
    self.lifepackowner = var0;
    thread scripts\mp\gamescore::trackbuffassistfortime( var0, self, "medic_lifepack", var1 );
}

// Params 1
// Size: 0x1c
function watchlifepackboostlifetime( var0 )
{
    self endon( "death_or_disconnect" );
    wait var0;
    
    if ( isdefined( self.lifeboostactive ) )
    {
        disablelifepackboost();
        return;
    }
}

// Params 0
// Size: 0x4d
function disablelifepackboost()
{
    if ( isdefined( self ) && isdefined( self.lifeboostactive ) )
    {
        self.lifeboostactive = undefined;
        self setclientomnvar( "ui_life_link", 0 );
        self notify( "disabled_life_pack_boost" );
        scripts\mp\utility\perk::removeperk( "specialty_regenfaster" );
        scripts\mp\gamescore::untrackbuffassist( self.lifepackowner, self, "medic_lifepack" );
        self.lifepackowner = undefined;
        return;
    }
}

// Params 1
// Size: 0x42
function setlifepackvisualforplayer( var0 )
{
    if ( level.teambased && var0.team == self.team && var0 != self.owner )
    {
        setlifepackoutlinestate( var0 );
        self showtoplayer( var0 );
        thread watchlifepackoutlinestate( var0 );
        return;
    }
    
    self hidefromplayer( var0 );
}

// Params 1
// Size: 0xd9
function setlifepackoutlinestate( var0 )
{
    if ( isdefined( var0.lifeboostactive ) )
    {
        if ( isdefined( var0.lifepackoutlines ) && var0.lifepackoutlines.size > 0 )
        {
            foreach ( var3, var2 in var0.lifepackoutlines )
            {
                if ( self == var2.pack )
                {
                    scripts\mp\utility\outline::outlinedisable( var2.id, var2.pack );
                    var0.lifepackoutlines = scripts\engine\utility::array_remove( var0.lifepackoutlines, var2 );
                    var2 = undefined;
                }
            }
            
            return;
        }
        
        return;
    }
    
    if ( !isdefined( var3.lifepackoutlines ) )
    {
        var3.lifepackoutlines = [];
    }
    
    var4 = spawnstruct();
    var4.id = scripts\mp\utility\outline::outlineenableforplayer( self, var3, "outline_depth_cyan", "equipment" );
    var4.pack = self;
    var3.lifepackoutlines = scripts\engine\utility::array_add_safe( var3.lifepackoutlines, var4 );
}

// Params 1
// Size: 0x26
function watchlifepackoutlinestate( var0 )
{
    self endon( "death" );
    
    for ( ;; )
    {
        var0 scripts\engine\utility::ref_143a5( "enabled_life_pack_boost", "disabled_life_pack_boost" );
        setlifepackoutlinestate( var0 );
    }
}

// Params 0
// Size: 0x52
function hoverlifepack()
{
    self endon( "death" );
    self endon( "phase_resource_pickup" );
    var0 = self.origin;
    
    for ( ;; )
    {
        self moveto( var0 + ( 0, 0, 15 ), 1, 0.2, 0.2 );
        wait 1;
        self moveto( var0, 1, 0.2, 0.2 );
        wait 1;
    }
}

// Params 1
// Size: 0xe8
function watchlifepackuse( var0 )
{
    self endon( "death" );
    
    for ( ;; )
    {
        self waittill( "trigger", var1 );
        
        if ( !isplayer( var1 ) )
        {
            continue;
        }
        
        if ( var1.team != var0.team )
        {
            continue;
        }
        
        if ( isdefined( var1.lifeboostactive ) )
        {
            continue;
        }
        
        if ( var1 == var0.owner )
        {
            continue;
        }
        
        activatelifepackboost( var1, var0.owner, 5, 1 );
        var1 playlocalsound( "scavenger_pack_pickup" );
        var2 = spawnfx( scripts\engine\utility::getfx( "life_pack_pickup" ), self.origin );
        triggerfx( var2 );
        var2 thread scripts\mp\utility\script::delayentdelete( 2 );
        
        foreach ( var4 in level.players )
        {
            if ( var4.team == var1.team )
            {
                continue;
            }
            
            var2 hidefromplayer( var4 );
        }
        
        var0 delete();
    }
}

// Params 1
// Size: 0x1e
function watchlifepackdeath( var0 )
{
    self endon( "death" );
    var0 waittill( "death" );
    
    if ( isdefined( self ) )
    {
        self delete();
        return;
    }
}

// Params 2
// Size: 0x18
function watchlifepacklifetime( var0, var1 )
{
    self endon( "death" );
    wait var0;
    var1 delete();
    self delete();
}

// Params 0
// Size: 0x20
function watchlifepackowner()
{
    self endon( "death" );
    self.owner waittill( "disconnect" );
    
    if ( isdefined( self ) )
    {
        self delete();
        return;
    }
}

// Params 0
// Size: 0x16
function watchlifepackuserdeath()
{
    self endon( "disconnect" );
    self waittill( "death" );
    disablelifepackboost();
}

// Params 0
// Size: 0xf
function unsetlifepack()
{
    disablelifepackboost();
    self notify( "unset_lifepack" );
}

// Params 0
// Size: 0x2b
function settoughenup()
{
    if ( !isdefined( level._effect[ "toughen_up_screen" ] ) )
    {
        level._effect[ "toughen_up_screen" ] = loadfx( "vfx/iw7/_requests/mp/vfx_toughen_up_scrn" );
    }
    
    thread watchtoughenup();
}

// Params 0
// Size: 0x1e0
function watchtoughenup()
{
    self endon( "death_or_disconnect" );
    self endon( "unsetToughenUp" );
    level endon( "game_ended" );
    var0 = 0;
    var1 = 15;
    var2 = 7.5;
    var3 = 4;
    var4 = 5;
    var5 = 2;
    var6 = [];
    var6 = scripts\engine\utility::array_add_safe( var6, ( 35, 0, 10 ) );
    var6 = scripts\engine\utility::array_add_safe( var6, ( 0, 35, 10 ) );
    var6 = scripts\engine\utility::array_add_safe( var6, ( -35, 0, 10 ) );
    var6 = scripts\engine\utility::array_add_safe( var6, ( 0, -35, 10 ) );
    self waittill( "spawned_player" );
    
    for ( ;; )
    {
        self waittill( "got_a_kill", var7, var8, var9 );
        
        if ( !isdefined( self.toughenedup ) )
        {
            self.toughenedup = 1;
            var10 = spawnfxforclient( scripts\engine\utility::getfx( "toughen_up_screen" ), self geteye(), self );
            triggerfx( var10 );
            thread attachtoughenuparmor( "j_forehead", level.bulletstormshield[ "section" ].friendlymodel );
            thread attachtoughenuparmor( "tag_reflector_arm_le", level.bulletstormshield[ "section" ].friendlymodel );
            thread attachtoughenuparmor( "tag_reflector_arm_ri", level.bulletstormshield[ "section" ].friendlymodel );
            thread attachtoughenuparmor( "j_spineupper", level.bulletstormshield[ "section" ].friendlymodel );
            thread attachtoughenuparmor( "tag_shield_back", level.bulletstormshield[ "section" ].friendlymodel );
            thread attachtoughenuparmor( "j_hip_le", level.bulletstormshield[ "section" ].friendlymodel );
            thread attachtoughenuparmor( "j_hip_ri", level.bulletstormshield[ "section" ].friendlymodel );
            
            if ( var5 == 1 )
            {
                scripts\mp\utility\damage::sethealthshield( var1 );
                thread watchtoughenuplifetime( var4 );
            }
            else
            {
                scripts\mp\lightarmor::setlightarmorvalue( self, 100 );
                thread watchtoughenuplightarmorend();
            }
            
            thread watchtoughenupplayerend( var10 );
            continue;
        }
        
        if ( var5 == 1 )
        {
            self notify( "toughen_up_reset" );
            thread watchtoughenuplifetime( var4 );
        }
    }
}

// Params 5
// Size: 0x77
function attachtoughenuparmor( var0, var1, var2, var3, var4 )
{
    var5 = self gettagorigin( var0 );
    var6 = spawn( "script_model", var5 );
    var6 setmodel( var1 );
    var7 = ( 0, 0, 0 );
    var8 = ( 0, 0, 0 );
    
    if ( isdefined( var2 ) )
    {
        var7 = var2;
    }
    
    if ( isdefined( var3 ) )
    {
        var8 = var3;
    }
    
    var6.angles = self.angles;
    var6 linkto( self, var0, var7, var8 );
    thread watchtoughenupplayerend( var6 );
    thread watchtoughenupgameend();
    return var6;
}

// Params 4
// Size: 0xad
function settoughenupmodel( var0, var1, var2, var3 )
{
    var4 = spawn( "script_model", self.origin + ( 0, 0, 50 ) );
    var4.team = self.owner.team;
    
    if ( var3 == "friendly" )
    {
        var4 setmodel( level.bulletstormshield[ "section" ].friendlymodel );
    }
    else
    {
        var4 setmodel( level.bulletstormshield[ "section" ].enemymodel );
    }
    
    var4 linkto( self, "tag_origin", var1, ( 0, 90 * ( var2 + 1 ), 0 ) );
    var4 hide();
    thread watchtoughenupplayerend( var4 );
    thread watchtoughenupgameend();
    thread settoughenupvisiblestate( var4, var3 );
}

// Params 0
// Size: 0x11
function watchtoughenuplightarmorend()
{
    self endon( "disconnect" );
    self waittill( "remove_light_armor" );
}

// Params 1
// Size: 0x3f
function watchtoughenupplayerend( var0 )
{
    self endon( "death" );
    var0 scripts\engine\utility::ref_143a5( "death_or_disconnect", "toughen_up_end" );
    var0.toughenedup = undefined;
    
    if ( var0 scripts\mp\lightarmor::haslightarmor( var0 ) )
    {
        unsetlightarmor( var0 );
    }
    
    if ( isdefined( self ) )
    {
        self delete();
        return;
    }
}

// Params 0
// Size: 0x1c
function watchtoughenupgameend()
{
    self endon( "death" );
    level waittill( "game_ended" );
    
    if ( isdefined( self ) )
    {
        self delete();
        return;
    }
}

// Params 1
// Size: 0x2b
function watchtoughenuplifetime( var0 )
{
    self endon( "death" );
    self endon( "toughen_up_reset" );
    
    while ( var0 > 0 )
    {
        var0 -= 1;
        wait 1;
    }
    
    self notify( "toughen_up_end" );
}

// Params 2
// Size: 0x57
function settoughenupvisiblestate( var0, var1 )
{
    foreach ( var3 in level.players )
    {
        if ( !isdefined( var3 ) )
        {
            continue;
        }
        
        if ( var3 == var1 )
        {
            continue;
        }
        
        if ( canshowtoughenupshield( var3, var0 ) )
        {
            self showtoplayer( var3 );
        }
        
        thread watchtoughenupplayerbegin( var3, var0 );
    }
}

// Params 2
// Size: 0x3b
function watchtoughenupplayerbegin( var0, var1 )
{
    var0 endon( "disconnect" );
    level endon( "game_ended" );
    self endon( "death" );
    
    for ( ;; )
    {
        var0 waittill( "spawned_player" );
        self hidefromplayer( var0 );
        
        if ( canshowtoughenupshield( var0, var1 ) )
        {
            self showtoplayer( var0 );
        }
    }
}

// Params 2
// Size: 0x41
function canshowtoughenupshield( var0, var1 )
{
    var2 = 0;
    
    if ( var1 == "friendly" && var0.team == self.team || var1 == "enemy" && var0.team != self.team )
    {
        var2 = 1;
    }
    
    return var2;
}

// Params 0
// Size: 0x14
function unsettoughenup()
{
    scripts\mp\utility\damage::clearhealthshield();
    unsetlightarmor();
    self notify( "unsetToughenUp" );
}

// Params 0
// Size: 0x8
function setscoutping()
{
    thread updatescoutping();
}

// Params 0
// Size: 0xf2
function updatescoutping()
{
    self endon( "death_or_disconnect" );
    self endon( "unsetScoutPing" );
    var0 = 50;
    var1 = 1200;
    var2 = undefined;
    jumpiffalse(scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "squadAsTeamEnabled" )) LOC_00000040;
    var2 = level [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "squadAsTeamEnabled" ) ]]();
    
    for ( ;; )
    {
        var3 = var0;
        var4 = var1;
        
        if ( isdefined( self.scoutpingradius ) )
        {
            var3 = self.scoutpingradius;
        }
        
        if ( isdefined( self.scoutsweeptime ) )
        {
            var4 = self.scoutsweeptime;
        }
        
        var3 = int( var3 );
        var4 = int( var4 );
        
        if ( var3 != var0 )
        {
            if ( istrue( var2 ) && getdvarint( "scr_advanced_scout_ping_squad_only", 0 ) )
            {
                var5 = level.squaddata[ self.team ][ self.squadindex ].players;
                
                foreach ( var7 in var5 )
                {
                    triggerportableradarping( self.origin, self, var3, var4 );
                }
            }
            else
            {
                triggerportableradarpingteam( self.origin, self.team, var3, var4 );
            }
        }
        
        wait var1 / 1200;
    }
}

// Params 1
// Size: 0xc8
function updatescoutpingvalues( var0 )
{
    var1 = 0;
    var2 = 150;
    var3 = 3000;
    
    if ( isdefined( self.scoutpingmod ) )
    {
        var1 = self.scoutpingmod;
    }
    
    if ( isdefined( self.scoutpingpreviousstage ) )
    {
        if ( var0 > self.scoutpingpreviousstage )
        {
            var4 = var0 - self.scoutpingpreviousstage;
            var1 += var4 / 10;
        }
        else if ( var0 < self.scoutpingpreviousstage )
        {
            var4 = self.scoutpingpreviousstage - var0;
            var1 -= var4 / 10;
        }
    }
    
    if ( isdefined( self.scoutpingmod ) )
    {
        if ( var1 > self.scoutpingmod || var1 < self.scoutpingmod )
        {
            var2 += var2 * var1 * 1.5;
            var3 -= var3 * var1 / 1.5;
            self.scoutpingradius = var2;
            self.scoutsweeptime = var3;
        }
    }
    
    if ( var0 == 0 )
    {
        self.scoutpingradius = undefined;
        self.scoutsweeptime = undefined;
    }
    
    self.scoutpingmod = var1;
    self.scoutpingpreviousstage = var0;
}

// Params 0
// Size: 0x22
function unsetscoutping()
{
    self.scoutpingradius = undefined;
    self.scoutsweeptime = undefined;
    self.scoutpingmod = undefined;
    self.scoutpingpreviousstage = undefined;
    self notify( "unsetScoutPing" );
}

// Params 0
// Size: 0xe
function setphasespeed()
{
    thread watchphasespeedshift();
    thread watchphasespeedendshift();
}

// Params 0
// Size: 0x23
function watchphasespeedshift()
{
    self endon( "death_or_disconnect" );
    
    for ( ;; )
    {
        self waittill( "phase_shift_start" );
        self.phasespeedmod = 0.2;
        scripts\mp\weapons::updatemovespeedscale();
    }
}

// Params 0
// Size: 0x1f
function watchphasespeedendshift()
{
    self endon( "death_or_disconnect" );
    
    for ( ;; )
    {
        self waittill( "phase_shift_completed" );
        self.phasespeedmod = undefined;
        scripts\mp\weapons::updatemovespeedscale();
    }
}

// Params 0
// Size: 0x8
function unsetphasespeed()
{
    self.phasespeedmod = undefined;
}

// Params 0
// Size: 0x9
function setdodge()
{
    self allowdodge( 1 );
}

// Params 0
// Size: 0x8
function unsetdodge()
{
    self allowdodge( 0 );
}

// Params 0
// Size: 0x14
function setextradodge()
{
    self energy_setmax( 1, 100 );
    self energy_setenergy( 1, 100 );
}

// Params 0
// Size: 0x14
function unsetextradodge()
{
    self energy_setmax( 1, 50 );
    self energy_setenergy( 1, 50 );
}

// Params 1
// Size: 0x114, Type: bool
function ref_133af( var0 )
{
    if ( !scripts\mp\utility\perk::_hasperk( "specialty_sixth_sense" ) )
    {
        return false;
    }
    
    if ( !scripts\cp_mp\utility\player_utility::_isalive() )
    {
        return false;
    }
    
    if ( !isdefined( var0 ) )
    {
        return false;
    }
    
    if ( !var0 scripts\cp_mp\utility\player_utility::_isalive() )
    {
        return false;
    }
    
    if ( var0.team == self.team )
    {
        return false;
    }
    
    if ( distancesquared( var0.origin, self.origin ) > 16000000 )
    {
        return false;
    }
    
    if ( var0 scripts\mp\utility\perk::_hasperk( "specialty_sixth_sense_immune" ) )
    {
        return false;
    }
    
    var1 = var0 scripts\cp_mp\utility\player_utility::getvehicle();
    
    if ( isdefined( var1 ) && isdefined( var1.vehiclename ) )
    {
        var2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver( var0 );
        
        if ( var2 )
        {
            if ( var1.vehiclename != "light_tank" && var1.vehiclename != "apc_russian" )
            {
                return false;
            }
        }
        else if ( var1.vehiclename == "apc_russian" )
        {
            return false;
        }
    }
    
    if ( var0 scripts\mp\utility\player::isusingremote() )
    {
        var3 = var0 scripts\mp\utility\player::getremotename();
        
        if ( var3 == "gunship" || var3 == "radar_drone_recon" || var3 == "chopper_gunner" || var3 == "cruise_predator" || var3 == "assault_drone" )
        {
            return false;
        }
    }
    
    return true;
}

// Params 4
// Size: 0x55, Type: bool
function ref_133ad( var0, var1, var2, var3 )
{
    var4 = var1 - var2;
    var5 = vectordot( var4, var3 );
    
    if ( var5 <= 0 )
    {
        return false;
    }
    
    var6 = length( var4 );
    var7 = 12;
    var7 += -0.15 * sqrt( var6 );
    var8 = scripts\engine\math::keypad_increase_failnum( var7 );
    var9 = 1 - 0.5 * var8 * var8;
    
    if ( var5 < var9 * var6 )
    {
        return false;
    }
    
    return true;
}

// Params 3
// Size: 0x24, Type: bool
function ref_133ae( var0, var1, var2 )
{
    var3 = var2 - var1;
    var4 = vectordot( var0, vectornormalize( var3 ) );
    
    if ( var4 < 0.382683 )
    {
        return true;
    }
    
    return false;
}

// Params 0
// Size: 0x286
function sixthsense_think_internal()
{
    var0 = scripts\engine\trace::create_default_contents( 1 );
    var1 = 0;
    var2 = getdvarint( "scr_sixth_sense_use_eyes_on" ) == 1;
    var3 = 0;
    var4 = undefined;
    var5 = undefined;
    var6 = getsystemtimeinmicroseconds();
    
    foreach ( var28, var8 in level.sixth_sense_players )
    {
        if ( !isdefined( var8 ) )
        {
            level.sixth_sense_players[ var28 ] = undefined;
            break;
        }
        
        var9 = 0;
        
        if ( var2 && !isbot( var8 ) )
        {
            if ( !var8 scripts\mp\utility\perk::_hasperk( "specialty_sixth_sense" ) )
            {
                continue;
            }
            
            if ( !var8 scripts\cp_mp\utility\player_utility::_isalive() )
            {
                continue;
            }
            
            var10 = var8 scripts\mp\utility\player::getstancecenter();
            var11 = var8 getplayerssightingme();
            
            foreach ( var13 in var11 )
            {
                if ( var3 >= 25 )
                {
                    var3 = 0;
                    waitframe();
                }
                
                if ( !isdefined( var8 ) )
                {
                    level.sixth_sense_players[ var28 ] = undefined;
                    break;
                }
                
                if ( !ref_133af( var8, var13 ) )
                {
                    continue;
                }
                
                var3++;
                var14 = var13 getvieworigin();
                var15 = anglestoforward( var13 getplayerangles() );
                
                if ( !ref_133ad( var8, var13, var10, var14, var15 ) )
                {
                    continue;
                }
                
                var9 |= roof_rpg_covers( var8, var13 );
            }
        }
        else
        {
            var10 = var8 gettagorigin( "j_spinelower" );
            var17 = var8 geteye();
            var18 = anglestoforward( var8 getplayerangles() );
            
            foreach ( var13 in level.players )
            {
                if ( var3 >= 25 )
                {
                    var3 = 0;
                    waitframe();
                }
                
                if ( !isdefined( var8 ) )
                {
                    level.sixth_sense_players[ var28 ] = undefined;
                    break;
                }
                
                if ( !ref_133af( var8, var13 ) )
                {
                    continue;
                }
                
                var3++;
                var14 = var13 getvieworigin();
                var15 = anglestoforward( var13 getplayerangles() );
                
                if ( !ref_133ad( var8, var13, var10, var14, var15 ) )
                {
                    continue;
                }
                
                if ( ref_133ae( var18, var10, var14 ) )
                {
                    var3 += 2;
                    var20 = [ var8 ];
                    var21 = var13 scripts\cp_mp\utility\player_utility::getvehicle();
                    
                    if ( isdefined( var21 ) )
                    {
                        var22 = getchildoutlineents( var21 );
                        
                        foreach ( var24 in var22 )
                        {
                            var20 = var24;
                        }
                    }
                    
                    var26 = var13.currentturret;
                    
                    if ( isdefined( var26 ) )
                    {
                        var20 = var26;
                    }
                    
                    if ( scripts\engine\trace::ray_trace_detail_passed( var14, var17, var20, var0 ) )
                    {
                        var9 = 255;
                        break;
                    }
                }
            }
            
            var28 = undefined;
            var17 = undefined;
        }
        
        if ( scripts\mp\gametypes\br_public::isbrgametypefuncdefinedwrapper( "sixthSenseThink" ) )
        {
            var6 |= scripts\mp\gametypes\br_public::runbrgametypefuncwrapper( "sixthSenseThink", var5 );
        }
        
        updatesixthsensevfx( var5, var6 );
    }
    
    var4 = undefined;
}

// Params 0
// Size: 0x11
function sixthsense_think()
{
    level.sixth_sense_players = [];
    
    for ( ;; )
    {
        waitframe();
        sixthsense_think_internal();
    }
}

// Params 0
// Size: 0x34
function setsixthsense()
{
    if ( getdvarint( "perk_sixthsensedisabled", 0 ) == 1 )
    {
        return;
    }
    
    self.sixthsenselastactivetime = 0;
    self.sixthsensestate = 0;
    updatesixthsensevfx( 0 );
    var0 = self getentitynumber();
    level.sixth_sense_players[ var0 ] = self;
}

// Params 0
// Size: 0x8
function unsetsixthsense()
{
    thread health_reduction();
}

// Params 0
// Size: 0x38
function health_reduction()
{
    self endon( "disconnect" );
    self.sixthsenselastactivetime = undefined;
    self.sixthsensestate = undefined;
    self.sixthsensesource = undefined;
    self notify( "removeSixthSense" );
    var0 = self getentitynumber();
    level.sixth_sense_players[ var0 ] = undefined;
    waitframe();
    updatesixthsensevfx( 0 );
}

// Params 0
// Size: 0x2
function setenhancedsixthsense()
{
    
}

// Params 0
// Size: 0x2
function unsetenhancedsixthsense()
{
    
}

// Params 1
// Size: 0xf
function updatesixthsensevfx( var0 )
{
    self setclientomnvar( "ui_edge_glow", var0 );
}

// Params 1
// Size: 0xd3
function roof_rpg_covers( var0 )
{
    var1 = anglestoforward( self getplayerangles() );
    var2 = ( var1[ 0 ], var1[ 1 ], var1[ 2 ] );
    var2 = vectornormalize( var2 );
    var3 = var0.origin - self.origin;
    var4 = ( var3[ 0 ], var3[ 1 ], var3[ 2 ] );
    var4 = vectornormalize( var4 );
    var5 = vectordot( var2, var4 );
    
    if ( var5 >= 0.92388 )
    {
        return 2;
    }
    
    if ( var5 >= 0.5 )
    {
        return scripts\engine\utility::ter_op( scripts\mp\utility\script::isleft2d( self.origin, var2, var0.origin ), 4, 1 );
    }
    
    if ( var5 >= 0.5 )
    {
        return scripts\engine\utility::ter_op( scripts\mp\utility\script::isleft2d( self.origin, var2, var0.origin ), 128, 64 );
    }
    
    if ( var5 >= -0.707107 )
    {
        return scripts\engine\utility::ter_op( scripts\mp\utility\script::isleft2d( self.origin, var2, var0.origin ), 32, 8 );
    }
    
    return 16;
}

// Params 1
// Size: 0x4a
function markassixthsensesource( var0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self notify( "markAsSixthSenseSource" );
    self endon( "markAsSixthSenseSource" );
    var1 = var0 getentitynumber();
    self.sixthsensesource[ var1 ] = 1;
    var0 scripts\engine\utility::waittill_any_in_array_or_timeout( [ "death" ], 10 );
    self.sixthsensesource[ var1 ] = 0;
}

// Params 0
// Size: 0x12a
function setcamoelite()
{
    self endon( "death_or_disconnect" );
    self endon( "removeArchetype" );
    
    for ( ;; )
    {
        var0 = 0;
        var1 = level.players;
        var2 = 0;
        
        foreach ( var4 in var1 )
        {
            if ( !isdefined( var4 ) || !var4 scripts\cp_mp\utility\player_utility::_isalive() )
            {
                continue;
            }
            
            if ( var4.team == self.team )
            {
                continue;
            }
            
            if ( var4 scripts\mp\utility\perk::_hasperk( "specialty_empimmune" ) )
            {
                continue;
            }
            
            var5 = self.origin - var4.origin;
            var6 = anglestoforward( var4 getplayerangles() );
            var7 = vectordot( var5, var6 );
            
            if ( var7 <= 0 )
            {
                continue;
            }
            
            var8 = vectornormalize( var5 );
            var9 = vectornormalize( var6 );
            var7 = vectordot( var8, var9 );
            
            if ( var7 < 12 )
            {
                continue;
            }
            
            var0++;
            var10 = var4 geteye();
            var11 = self geteye();
            
            if ( scripts\engine\trace::ray_trace_passed( var10, var11, self, scripts\engine\trace::create_default_contents( 1 ) ) )
            {
                var2 = 1;
                break;
            }
            
            if ( var0 >= 10 )
            {
                waitframe();
                var0 = 0;
            }
        }
        
        updatecamoeliteoverlay( var2 );
        waitframe();
    }
}

// Params 1
// Size: 0x4
function updatecamoeliteoverlay( var0 )
{
    
}

// Params 0
// Size: 0x2
function unsetcamoelite()
{
    
}

// Params 0
// Size: 0x10
function setcarepackage()
{
    thread scripts\mp\killstreaks\killstreaks::givekillstreak( "airdrop_assault", 0, 0, self );
}

// Params 0
// Size: 0x2
function unsetcarepackage()
{
    
}

// Params 0
// Size: 0x10
function setuav()
{
    thread scripts\mp\killstreaks\killstreaks::givekillstreak( "uav", 0, 0, self );
}

// Params 0
// Size: 0x2
function unsetuav()
{
    
}

// Params 1
// Size: 0xab
function setjuiced( var0 )
{
    self endon( "death_or_disconnect" );
    self endon( "faux_spawn" );
    self endon( "unset_juiced" );
    level endon( "game_ended" );
    self.isjuiced = 1;
    self.movespeedscaler = 1.25;
    scripts\mp\weapons::updatemovespeedscale();
    scripts\mp\utility\perk::giveperk( "specialty_fastreload" );
    scripts\mp\utility\perk::giveperk( "specialty_quickdraw" );
    scripts\mp\utility\perk::giveperk( "specialty_stalker" );
    scripts\mp\utility\perk::giveperk( "specialty_fastoffhand" );
    scripts\mp\utility\perk::giveperk( "specialty_fastsprintrecovery" );
    scripts\mp\utility\perk::giveperk( "specialty_quickswap" );
    thread unsetjuicedondeath();
    thread unsetjuicedonride();
    thread unsetjuicedonmatchend();
    
    if ( !isdefined( var0 ) )
    {
        var0 = 10;
    }
    
    var1 = var0 * 1000 + gettime();
    
    if ( isai( self ) )
    {
    }
    
    wait var0;
    unsetjuiced();
}

// Params 1
// Size: 0x82
function unsetjuiced( var0 )
{
    if ( !isdefined( var0 ) )
    {
        self.movespeedscaler = 1;
        
        if ( scripts\mp\utility\perk::_hasperk( "specialty_lightweight" ) )
        {
            self.movespeedscaler = scripts\mp\utility\perk::lightweightscalar();
        }
        
        scripts\mp\weapons::updatemovespeedscale();
    }
    
    scripts\mp\utility\perk::removeperk( "specialty_fastreload" );
    scripts\mp\utility\perk::removeperk( "specialty_quickdraw" );
    scripts\mp\utility\perk::removeperk( "specialty_stalker" );
    scripts\mp\utility\perk::removeperk( "specialty_fastoffhand" );
    scripts\mp\utility\perk::removeperk( "specialty_fastsprintrecovery" );
    scripts\mp\utility\perk::removeperk( "specialty_quickswap" );
    self.isjuiced = undefined;
    
    if ( isai( self ) )
    {
    }
    
    self notify( "unset_juiced" );
}

// Params 0
// Size: 0x26
function unsetjuicedonride()
{
    self endon( "disconnect" );
    self endon( "unset_juiced" );
    
    for ( ;; )
    {
        waitframe();
        
        if ( scripts\mp\utility\player::isusingremote() )
        {
            thread unsetjuiced();
            break;
        }
    }
}

// Params 0
// Size: 0x28
function unsetjuicedondeath()
{
    self endon( "disconnect" );
    self endon( "unset_juiced" );
    scripts\engine\utility::ref_143a5( "death", "faux_spawn" );
    thread unsetjuiced( 1 );
}

// Params 0
// Size: 0x27
function unsetjuicedonmatchend()
{
    self endon( "disconnect" );
    self endon( "unset_juiced" );
    level scripts\engine\utility::ref_143a5( "round_end_finished", "game_ended" );
    thread unsetjuiced();
}

// Params 0
// Size: 0x9, Type: bool
function hasjuiced()
{
    return isdefined( self.isjuiced );
}

// Params 0
// Size: 0x29e
function setcombathigh()
{
    self endon( "death_or_disconnect" );
    self endon( "unset_combathigh" );
    level endon( "end_game" );
    self.damageblockedtotal = 0;
    
    if ( level.splitscreen )
    {
        var0 = 56;
        var1 = 21;
    }
    else
    {
        var0 = 112;
        var1 = 32;
    }
    
    if ( isdefined( self.juicedtimer ) )
    {
        self.juicedtimer destroy();
    }
    
    if ( isdefined( self.juicedicon ) )
    {
        self.juicedicon destroy();
    }
    
    self.combathighoverlay = newclienthudelem( self );
    self.combathighoverlay.x = 0;
    self.combathighoverlay.y = 0;
    self.combathighoverlay.alignx = "left";
    self.combathighoverlay.aligny = "top";
    self.combathighoverlay.horzalign = "fullscreen";
    self.combathighoverlay.vertalign = "fullscreen";
    self.combathighoverlay setshader( "combathigh_overlay", 640, 480 );
    self.combathighoverlay.sort = -10;
    self.combathighoverlay.archived = 1;
    self.combathightimer = scripts\mp\hud_util::createtimer( "hudsmall", 1 );
    self.combathightimer scripts\mp\hud_util::setpoint( "CENTER", "CENTER", 0, var0 );
    self.combathightimer settimer( 10 );
    self.combathightimer.color = ( 0.8, 0.8, 0 );
    self.combathightimer.archived = 0;
    self.combathightimer.foreground = 1;
    self.combathighicon = scripts\mp\hud_util::createicon( "specialty_painkiller", var1, var1 );
    self.combathighicon.alpha = 0;
    self.combathighicon scripts\mp\hud_util::setparent( self.combathightimer );
    self.combathighicon scripts\mp\hud_util::setpoint( "BOTTOM", "TOP" );
    self.combathighicon.archived = 1;
    self.combathighicon.sort = 1;
    self.combathighicon.foreground = 1;
    self.combathighoverlay.alpha = 0;
    self.combathighoverlay fadeovertime( 1 );
    self.combathighicon fadeovertime( 1 );
    self.combathighoverlay.alpha = 1;
    self.combathighicon.alpha = 0.85;
    thread unsetcombathighondeath();
    thread unsetcombathighonride();
    wait 8;
    self.combathighicon fadeovertime( 2 );
    self.combathighicon.alpha = 0;
    self.combathighoverlay fadeovertime( 2 );
    self.combathighoverlay.alpha = 0;
    self.combathightimer fadeovertime( 2 );
    self.combathightimer.alpha = 0;
    wait 2;
    self.damageblockedtotal = undefined;
    scripts\mp\utility\perk::removeperk( "specialty_combathigh" );
}

// Params 0
// Size: 0x23
function unsetcombathighondeath()
{
    self endon( "disconnect" );
    self endon( "unset_combathigh" );
    self waittill( "death" );
    thread scripts\mp\utility\perk::removeperk( "specialty_combathigh" );
}

// Params 0
// Size: 0x2b
function unsetcombathighonride()
{
    self endon( "disconnect" );
    self endon( "unset_combathigh" );
    
    for ( ;; )
    {
        waitframe();
        
        if ( scripts\mp\utility\player::isusingremote() )
        {
            thread scripts\mp\utility\perk::removeperk( "specialty_combathigh" );
            break;
        }
    }
}

// Params 0
// Size: 0x25
function unsetcombathigh()
{
    self notify( "unset_combathigh" );
    self.combathighoverlay destroy();
    self.combathighicon destroy();
    self.combathightimer destroy();
}

// Params 0
// Size: 0xb
function setlightarmor()
{
    scripts\mp\lightarmor::setlightarmorvalue( self, 150 );
}

// Params 0
// Size: 0x9
function unsetlightarmor()
{
    scripts\mp\lightarmor::lightarmor_unset( self );
}

// Params 0
// Size: 0xff
function setrevenge()
{
    self notify( "stopRevenge" );
    waitframe();
    
    if ( !isdefined( self.lastkilledby ) )
    {
        return;
    }
    
    if ( level.teambased && self.team == self.lastkilledby.team )
    {
        return;
    }
    
    var0 = spawnstruct();
    var0.showto = self;
    var0.icon = "compassping_revenge";
    var0.offset = ( 0, 0, 64 );
    var0.width = 10;
    var0.height = 10;
    var0.archived = 0;
    var0.delay = 1.5;
    var0.constantsize = 0;
    var0.pintoscreenedge = 1;
    var0.fadeoutpinnedicon = 0;
    var0.is3d = 0;
    self.revengeparams = var0;
    self.lastkilledby thread scripts\cp_mp\entityheadicons::setheadicon_singleimage( var0.showto, var0.icon, var0.offset, undefined, undefined, undefined, var0.delay );
    thread watchrevengedeath();
    thread watchrevengekill();
    thread watchrevengedisconnected();
    thread watchrevengevictimdisconnected();
    thread watchstoprevenge();
}

// Params 0
// Size: 0x58
function watchrevengedeath()
{
    self endon( "stopRevenge" );
    self endon( "disconnect" );
    var0 = self.lastkilledby;
    
    for ( ;; )
    {
        var0 waittill( "spawned_player" );
        var0 thread scripts\cp_mp\entityheadicons::setheadicon_singleimage( self.revengeparams.showto, self.revengeparams.icon, self.revengeparams.offset, undefined, undefined, undefined, self.revengeparams.delay );
    }
}

// Params 0
// Size: 0x19
function watchrevengekill()
{
    self endon( "stopRevenge" );
    self waittill( "killed_enemy" );
    self notify( "stopRevenge" );
}

// Params 0
// Size: 0x1d
function watchrevengedisconnected()
{
    self endon( "stopRevenge" );
    self.lastkilledby waittill( "disconnect" );
    self notify( "stopRevenge" );
}

// Params 0
// Size: 0x4c
function watchstoprevenge()
{
    var0 = self.lastkilledby;
    self waittill( "stopRevenge" );
    
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    foreach ( var2 in var0.entityheadicons )
    {
        if ( !isdefined( var2 ) )
        {
            continue;
        }
        
        var2 destroy();
    }
}

// Params 0
// Size: 0x68
function watchrevengevictimdisconnected()
{
    var0 = self.objidfriendly;
    var1 = self.lastkilledby;
    var1 endon( "disconnect" );
    level endon( "game_ended" );
    self endon( "stopRevenge" );
    self waittill( "disconnect" );
    
    if ( !isdefined( var1 ) )
    {
        return;
    }
    
    foreach ( var3 in var1.entityheadicons )
    {
        if ( !isdefined( var3 ) )
        {
            continue;
        }
        
        var3 destroy();
    }
}

// Params 0
// Size: 0xa
function unsetrevenge()
{
    self notify( "stopRevenge" );
}

// Params 0
// Size: 0x9
function setphaseslide()
{
    self.canphaseslide = 1;
}

// Params 0
// Size: 0x8
function unsetphaseslide()
{
    self.canphaseslide = 0;
}

// Params 0
// Size: 0x9
function setteleslide()
{
    self.canteleslide = 1;
}

// Params 0
// Size: 0x8
function unsetteleslide()
{
    self.canteleslide = 0;
}

// Params 0
// Size: 0x9
function setphaseslashrephase()
{
    self.hasrephase = 1;
}

// Params 0
// Size: 0x8
function unsetphaseslashrephase()
{
    self.hasrephase = 0;
}

// Params 0
// Size: 0x2
function setphasefall()
{
    
}

// Params 0
// Size: 0x2
function unsetphasefall()
{
    
}

// Params 0
// Size: 0x2
function setextenddodge()
{
    
}

// Params 0
// Size: 0x2
function unsetextenddodge()
{
    
}

// Params 0
// Size: 0x7
function setauraquickswap()
{
    scripts\mp\archetypes\archassault::auraquickswap_run();
}

// Params 0
// Size: 0x2
function unsetauraquickswap()
{
    
}

// Params 0
// Size: 0x2
function setauraspeed()
{
    
}

// Params 0
// Size: 0x2
function unsetauraspeed()
{
    
}

// Params 0
// Size: 0x7
function setmarktargets()
{
    scripts\mp\perks\perk_mark_targets::marktarget_init();
}

// Params 0
// Size: 0x2
function unsetmarktargets()
{
    
}

// Params 0
// Size: 0x2
function setbatterypack()
{
    
}

// Params 0
// Size: 0x2
function unsetbatterypack()
{
    
}

// Params 0
// Size: 0x2
function setcamoclone()
{
    
}

// Params 0
// Size: 0x2
function unsetcamoclone()
{
    
}

// Params 0
// Size: 0x11
function setblockhealthregen()
{
    self.healthregendisabled = 1;
    self notify( "force_regeneration" );
}

// Params 0
// Size: 0x10
function unsetblockhealthregen()
{
    self.healthregendisabled = undefined;
    self notify( "force_regeneration" );
}

// Params 0
// Size: 0x2
function setscorestreakpack()
{
    
}

// Params 0
// Size: 0x2
function unsetscorestreakpack()
{
    
}

// Params 0
// Size: 0x2
function setsuperpack()
{
    
}

// Params 0
// Size: 0x2
function unsetsuperpack()
{
    
}

// Params 0
// Size: 0x2
function setspawncloak()
{
    
}

// Params 0
// Size: 0x2
function unsetspawncloak()
{
    
}

// Params 0
// Size: 0x17
function setdodgedefense()
{
    scripts\cp_mp\utility\damage_utility::adddamagemodifier( "dodgeDefense", 0.5, 0, &dodgedefenseignorefunc );
}

// Params 0
// Size: 0xe
function unsetdodgedefense()
{
    scripts\cp_mp\utility\damage_utility::removedamagemodifier( "dodgeDefense", 0 );
}

// Params 7
// Size: 0x33, Type: bool
function dodgedefenseignorefunc( var0, var1, var2, var3, var4, var5, var6 )
{
    if ( !( isdefined( var2.dodging ) && var2.dodging && var2 scripts\mp\utility\perk::_hasperk( "specialty_dodge_defense" ) ) )
    {
        return true;
    }
    
    return false;
}

// Params 0
// Size: 0x2
function setdodgewave()
{
    
}

// Params 0
// Size: 0x2
function unsetdodgewave()
{
    
}

// Params 0
// Size: 0x2
function setgroundpound()
{
    
}

// Params 0
// Size: 0x2
function unsetgroundpound()
{
    
}

// Params 0
// Size: 0xa0
function setmeleekill()
{
    self giveweapon( "iw7_fistsperk_mp" );
    self assignweaponmeleeslot( "iw7_fistsperk_mp" );
    
    if ( self hasweapon( "iw8_fists_mp" ) )
    {
        var0 = self getcurrentweapon();
        scripts\cp_mp\utility\inventory_utility::_takeweapon( "iw8_fists_mp" );
        self giveweapon( "iw7_fistslethal_mp" );
        
        if ( var0.basename == "iw8_fists_mp" )
        {
            scripts\cp_mp\utility\inventory_utility::_switchtoweapon( "iw7_fistslethal_mp" );
            
            if ( isdefined( self.gettingloadout ) && self.gettingloadout && isdefined( self.spawnweaponobj ) && self.spawnweaponobj.basename == "iw8_fists_mp" )
            {
                self.spawnweaponobj = getcompleteweaponname( "iw7_fistslethal_mp" );
                self setspawnweapon( self.spawnweaponobj );
                return;
            }
            
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0x52
function unsetmeleekill()
{
    scripts\cp_mp\utility\inventory_utility::_takeweapon( "iw7_fistsperk_mp" );
    
    if ( self hasweapon( "iw7_fistslethal_mp" ) )
    {
        var0 = self.currentweapon;
        scripts\cp_mp\utility\inventory_utility::_takeweapon( "iw7_fistslethal_mp" );
        self giveweapon( "iw8_fists_mp" );
        
        if ( var0.basename == "iw7_fistslethal_mp" )
        {
            scripts\cp_mp\utility\inventory_utility::_switchtoweapon( "iw8_fists_mp" );
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0x2
function setpowercell()
{
    
}

// Params 0
// Size: 0x2
function unsetpowercell()
{
    
}

// Params 0
// Size: 0x34
function sethardline()
{
    self endon( "death_or_disconnect" );
    self endon( "perk_end_hardline" );
    scripts\mp\killstreaks\killstreaks::updatestreakcosts();
    scripts\mp\killstreaks\killstreaks::checkstreakreward( self.streakpoints, 1 );
    scripts\mp\killstreaks\killstreaks::updatestreakmeterui();
    self.hardlineactive[ "assists" ] = 0;
}

// Params 0
// Size: 0x10
function watchhardlineassists()
{
    self endon( "death_or_disconnect" );
    self endon( "perk_end_hardline" );
}

// Params 0
// Size: 0x10
function unsethardline()
{
    self.hardlineactive = undefined;
    self notify( "perk_end_hardline" );
}

// Params 0
// Size: 0x2
function setoverclock()
{
    
}

// Params 0
// Size: 0x2
function unsetoverclock()
{
    
}

// Params 0
// Size: 0xf
function setovercharge()
{
    thread _calloutmarkerping_handleluinotify_added::ref_1313d( "ui_overcharge", 1 );
}

// Params 0
// Size: 0xe
function unsetovercharge()
{
    thread _calloutmarkerping_handleluinotify_added::ref_1313d( "ui_overcharge", 0 );
}

// Params 0
// Size: 0x8
function setsupersprintenhanced()
{
    thread watchforsupersprintenhancedused();
}

// Params 0
// Size: 0xa
function unsetsupersprintenhanced()
{
    self notify( "unsetSuperSprintEnhanced" );
}

// Params 0
// Size: 0x44
function watchforsupersprintenhancedused()
{
    self endon( "unsetSuperSprintEnhanced" );
    self endon( "disconnect" );
    var0 = 0;
    
    while ( 2000 > var0 )
    {
        waitframe();
        
        if ( isdefined( self ) && istrue( self issupersprinting() ) )
        {
            var1 = level.frameduration;
            var0 += var1;
        }
    }
    
    scripts\mp\gamelogic::sethasdonecombat( self, 1 );
}

// Params 0
// Size: 0x2
function settracker()
{
    
}

// Params 0
// Size: 0x2
function unsettracker()
{
    
}

// Params 0
// Size: 0x2
function setpersonaltrophy()
{
    
}

// Params 0
// Size: 0x2
function unsetpersonaltrophy()
{
    
}

// Params 0
// Size: 0x2
function setdisruptorpunch()
{
    
}

// Params 0
// Size: 0x2
function unsetdisruptorpunch()
{
    
}

// Params 0
// Size: 0x11
function setequipmentping()
{
    if ( !scripts\mp\utility\game::lpcfeaturegated() )
    {
        level.equipmentpingactive = 1;
        return;
    }
}

// Params 0
// Size: 0x2
function unsetequipmentping()
{
    
}

// Params 0
// Size: 0x2
function setruggedeqp()
{
    
}

// Params 0
// Size: 0x2
function unsetruggedeqp()
{
    
}

// Params 4
// Size: 0x7
function feedbackruggedeqp( var0, var1, var2, var3 )
{
    
}

// Params 0
// Size: 0x2
function setmanatarms()
{
    
}

// Params 0
// Size: 0x2
function unsetmanatarms()
{
    
}

// Params 0
// Size: 0x8
function setoutlinekillstreaks()
{
    thread outlinekillstreaks_enablemarksafterprematch();
}

// Params 0
// Size: 0x5e
function outlinekillstreaks_enablemarksafterprematch()
{
    self endon( "unsetOutlineKillstreak" );
    self endon( "disconnect" );
    scripts\mp\flags::gameflagwait( "prematch_done" );
    var0 = 1000000;
    
    if ( level.gametype == "br" )
    {
        var0 = 1000;
    }
    
    if ( isdefined( self ) )
    {
        self enableentitymarks( "killstreak", var0 );
        self enableentitymarks( "air_killstreak", var0 );
        self.perkoutlinekillstreaksset = 1;
        _calloutmarkerping_predicted_timeout::ref_14130( self );
        return;
    }
}

// Params 0
// Size: 0x34
function unsetoutlinekillstreaks()
{
    if ( istrue( self.perkoutlinekillstreaksset ) )
    {
        self disableentitymarks( "killstreak" );
        self disableentitymarks( "air_killstreak" );
        self.perkoutlinekillstreaksset = undefined;
    }
    
    _calloutmarkerping_predicted_timeout::ref_14130( self );
    self notify( "unsetOutlineKillstreak" );
}

// Params 0
// Size: 0x8
function setengineer()
{
    thread engineer_enablemarksafterprematch();
}

// Params 0
// Size: 0x4c
function engineer_enablemarksafterprematch()
{
    self endon( "unsetEngineer" );
    self endon( "disconnect" );
    scripts\mp\flags::gameflagwait( "prematch_done" );
    var0 = 1000000;
    
    if ( level.gametype == "br" )
    {
        var0 = 1000;
    }
    
    if ( isdefined( self ) )
    {
        self enableentitymarks( "equipment", var0 );
        self.perkengineerset = 1;
        return;
    }
}

// Params 0
// Size: 0x23
function unsetengineer()
{
    if ( istrue( self.perkengineerset ) )
    {
        self disableentitymarks( "equipment" );
        self.perkengineerset = undefined;
    }
    
    self notify( "unsetEngineer" );
}

// Params 0
// Size: 0x33
function setnoscopeoutline()
{
    if ( !isdefined( level.noscopeoutlinesetnotifs ) )
    {
        level.noscopeoutlinesetnotifs = [];
        level.noscopeoutlineunsetnotifs = [];
        thread processnoscopeoutlinesetnotifs();
        thread processnoscopeoutlineunsetnotifs();
    }
    
    level.noscopeoutlinesetnotifs[ level.noscopeoutlinesetnotifs.size ] = self;
}

// Params 0
// Size: 0x10
function unsetnoscopeoutline()
{
    level.noscopeoutlineunsetnotifs[ level.noscopeoutlineunsetnotifs.size ] = self;
}

// Params 0
// Size: 0x57
function processnoscopeoutlinesetnotifs()
{
    level endon( "game_ended" );
    
    for ( ;; )
    {
        if ( level.noscopeoutlinesetnotifs.size > 0 )
        {
            var0 = 0;
            
            while ( isdefined( level.noscopeoutlinesetnotifs[ var0 ] ) )
            {
                level notify( "set_noscopeoutline", level.noscopeoutlinesetnotifs[ var0 ] );
                level.noscopeoutlinesetnotifs[ var0 ] notify( "set_noscopeoutline" );
                var0++;
                waitframe();
            }
            
            level.noscopeoutlinesetnotifs = [];
            continue;
        }
        
        waitframe();
    }
}

// Params 0
// Size: 0x57
function processnoscopeoutlineunsetnotifs()
{
    level endon( "game_ended" );
    
    for ( ;; )
    {
        if ( level.noscopeoutlineunsetnotifs.size > 0 )
        {
            var0 = 0;
            
            while ( isdefined( level.noscopeoutlineunsetnotifs[ var0 ] ) )
            {
                level notify( "unset_noscopeoutline", level.noscopeoutlineunsetnotifs[ var0 ] );
                level.noscopeoutlineunsetnotifs[ var0 ] notify( "unset_noscopeoutline" );
                var0++;
                waitframe();
            }
            
            level.noscopeoutlineunsetnotifs = [];
            continue;
        }
        
        waitframe();
    }
}

// Params 0
// Size: 0x2
function setcloak()
{
    
}

// Params 0
// Size: 0x2
function unsetcloak()
{
    
}

// Params 0
// Size: 0x2
function setwalllock()
{
    
}

// Params 0
// Size: 0x2
function unsetwalllock()
{
    
}

// Params 0
// Size: 0x2
function setrush()
{
    
}

// Params 0
// Size: 0x10
function unsetrush()
{
    self notify( "removeCombatHigh" );
    self.speedonkillmod = undefined;
}

// Params 0
// Size: 0x8
function sethover()
{
    thread runhover();
}

// Params 0
// Size: 0x2
function unsethover()
{
    
}

// Params 0
// Size: 0x2c
function setmomentum()
{
    self endon( "death_or_disconnect" );
    self endon( "momentum_unset" );
    self.momentumspeedincrease = 0;
    scripts\mp\weapons::updatemovespeedscale();
    
    for ( ;; )
    {
        self waittill( "killed_enemy" );
        thread ref_11cd0();
    }
}

// Params 0
// Size: 0x15
function unsetmomentum()
{
    self notify( "momentum_unset" );
    self.momentumspeedincrease = undefined;
    scripts\mp\weapons::updatemovespeedscale();
}

// Params 0
// Size: 0x3d
function ref_11cd0()
{
    self endon( "death_or_disconnect" );
    self endon( "momentum_unset" );
    self.momentumspeedincrease += 0.04;
    self.momentumspeedincrease = min( self.momentumspeedincrease, 0.12 );
    scripts\mp\weapons::updatemovespeedscale();
    thread ref_11ccf();
}

// Params 0
// Size: 0x29
function ref_11ccf()
{
    self endon( "death_or_disconnect" );
    self notify( "momentum_reset_speed" );
    self endon( "momentum_reset_speed" );
    wait 5;
    self.momentumspeedincrease = 0;
    scripts\mp\weapons::updatemovespeedscale();
}

// Params 0
// Size: 0x2
function setscavengereqp()
{
    
}

// Params 0
// Size: 0x2
function unsetscavengereqp()
{
    
}

// Params 0
// Size: 0x2
function setspawnview()
{
    
}

// Params 0
// Size: 0x2f
function unsetspawnview()
{
    foreach ( var1 in level.players )
    {
        var1 notify( "end_spawnview" );
    }
}

// Params 1
// Size: 0x4
function setheadgear( var0 )
{
    
}

// Params 0
// Size: 0x2
function unsetheadgear()
{
    
}

// Params 0
// Size: 0x2
function setftlslide()
{
    
}

// Params 0
// Size: 0x2
function unsetftlslide()
{
    
}

// Params 0
// Size: 0x2
function setimprovedprone()
{
    
}

// Params 0
// Size: 0x2
function unsetimprovedprone()
{
    
}

// Params 0
// Size: 0x8
function setghost()
{
    thread startgpsjammer();
}

// Params 0
// Size: 0x8
function unsetghost()
{
    thread removegpsjammer();
}

// Params 0
// Size: 0x5e
function setsupportkillstreaks()
{
    self endon( "disconnect" );
    self waittill( "equipKillstreaksFinished" );
    
    if ( !isdefined( self.streakdata.streaks[ 1 ] ) )
    {
        foreach ( var1 in self.streakdata.streaks[ "killstreaks" ] )
        {
            var1.earned = 0;
        }
        
        return;
    }
}

// Params 0
// Size: 0xa
function unsetsupportkillstreaks()
{
    self notify( "end_support_killstreaks" );
}

// Params 0
// Size: 0x11
function setoverrideweaponspeed()
{
    self.overrideweaponspeed_speedscale = 0.98;
    scripts\mp\weapons::updatemovespeedscale();
}

// Params 0
// Size: 0x8
function unsetoverrideweaponspeed()
{
    self.overrideweaponspeed_speedscale = undefined;
}

// Params 0
// Size: 0x2
function setcloakaerial()
{
    
}

// Params 0
// Size: 0x2
function unsetcloakaerial()
{
    
}

// Params 0
// Size: 0x9
function setspawnradar()
{
    self.hasspawnradar = 1;
}

// Params 0
// Size: 0x9
function unsetspawnradar()
{
    self.hasspawnradar = 1;
}

// Params 0
// Size: 0x2
function setimprovedmelee()
{
    
}

// Params 0
// Size: 0x2
function unsetimprovedmelee()
{
    
}

// Params 0
// Size: 0x2
function setthief()
{
    
}

// Params 0
// Size: 0x2
function unsetthief()
{
    
}

// Params 0
// Size: 0x17
function setadsawareness()
{
    thread runadsawareness();
    self setscriptablepartstate( "heightened_senses", "default" );
}

// Params 0
// Size: 0xbf
function runadsawareness()
{
    self endon( "death_or_disconnect" );
    self endon( "unsetADSAwareness" );
    self.awarenessradius = 256;
    self.awarenessqueryrate = 2;
    thread awarenessmonitorstance();
    
    for ( ;; )
    {
        wait self.awarenessqueryrate;
        var0 = scripts\common\utility::playersinsphere( self.origin, self.awarenessradius );
        
        foreach ( var2 in level.players )
        {
            if ( var2.team == self.team )
            {
                continue;
            }
            
            if ( var2 scripts\mp\utility\perk::_hasperk( "specialty_coldblooded" ) )
            {
                continue;
            }
            
            if ( var2 isonground() && !var2 issprinting() && !var2 iswallrunning() && !var2 issprintsliding() )
            {
                continue;
            }
            
            thread playincomingwarning( var2 );
        }
    }
}

// Params 1
// Size: 0x70
function playincomingwarning( var0 )
{
    self setscriptablepartstate( "heightened_senses", "scrn_pulse" );
    self playrumbleonentity( "damage_heavy" );
    var0 playsoundtoplayer( "ghost_senses_ping", self );
    wait 0.2;
    
    if ( isdefined( self ) )
    {
        self setscriptablepartstate( "heightened_senses", "default" );
        
        if ( scripts\cp_mp\utility\player_utility::_isalive() )
        {
            self playrumbleonentity( "damage_heavy" );
            
            if ( isdefined( var0 ) && var0 scripts\cp_mp\utility\player_utility::_isalive() )
            {
                var0 playsoundtoplayer( "ghost_senses_ping", self );
                return;
            }
            
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0x84
function awarenessmonitorstance()
{
    self endon( "death_or_disconnect" );
    
    for ( ;; )
    {
        var0 = self getstance();
        var1 = self getvelocity();
        
        switch ( var0 )
        {
            case "stand":
                self.awarenessradius = 400;
                self.awarenessqueryrate = 2;
                break;
            case "crouch":
                self.awarenessradius = 650;
                self.awarenessqueryrate = 1;
                break;
            case "prone":
                self.awarenessradius = 700;
                self.awarenessqueryrate = 0.5;
                break;
        }
        
        wait 0.01;
    }
}

// Params 0
// Size: 0x35
function awarenessaudiopulse()
{
    self endon( "death_or_disconnect" );
    self endon( "stop_awareness" );
    
    for ( ;; )
    {
        playsoundatpos( self.origin + ( 0, 0, 5 ), "ghost_senses_ping" );
        wait 2;
    }
}

// Params 0
// Size: 0x19
function unsetadsawareness()
{
    self notify( "unsetADSAwareness" );
    self setscriptablepartstate( "heightened_senses", "default" );
}

// Params 0
// Size: 0x2
function setrearguard()
{
    
}

// Params 0
// Size: 0x8
function unsetrearguard()
{
    self.hasrearguardshield = undefined;
}

// Params 0
// Size: 0x9
function setsolobuddyboost()
{
    self.hassolobuddyboost = 1;
}

// Params 0
// Size: 0x8
function unsetsolobuddyboost()
{
    self.hassolobuddyboost = undefined;
}

// Params 0
// Size: 0x47
function setthrowingknifemelee()
{
    self giveweapon( self.ref_13b5c );
    self assignweaponmeleeslot( self.ref_13b5c );
    thread watchthrowingknifescavenge();
    
    if ( self.ref_13b5c == "iw8_throwingknife_fire_melee_mp" )
    {
        thread ref_144fd();
        return;
    }
    
    if ( self.ref_13b5c == "iw8_throwingknife_electric_melee_mp" )
    {
        thread ref_144fc();
        return;
    }
}

// Params 0
// Size: 0x65
function unsetthrowingknifemelee()
{
    if ( isdefined( self.ref_13b5c ) && self hasweapon( self.ref_13b5c ) )
    {
        self takeweapon( self.ref_13b5c );
    }
    
    self notify( "specialty_equip_throwingKnife_end" );
    
    if ( isdefined( self.ref_13b5c ) && self.ref_13b5c == "iw8_throwingknife_fire_melee_mp" )
    {
        votesys_think();
        return;
    }
    
    if ( isdefined( self.ref_13b5c ) && self.ref_13b5c == "iw8_throwingknife_electric_melee_mp" )
    {
        votesys_new();
        return;
    }
}

// Params 0
// Size: 0x55
function ref_144fd()
{
    self endon( "death_or_disconnect" );
    self endon( "specialty_equip_throwingKnife_end" );
    
    for ( ;; )
    {
        self waittill( "weapon_change", var0 );
        
        if ( var0.basename == "iw8_throwingknife_fire_melee_mp" )
        {
            self setscriptablepartstate( "WeaponVFXViewmodel", "flamingKnife" );
            self waittill( "weapon_change" );
            self setscriptablepartstate( "WeaponVFXViewmodel", "neutral" );
        }
    }
}

// Params 0
// Size: 0x11
function votesys_think()
{
    self setscriptablepartstate( "WeaponVFXViewmodel", "neutral" );
}

// Params 0
// Size: 0x55
function ref_144fc()
{
    self endon( "death_or_disconnect" );
    self endon( "specialty_equip_throwingKnife_end" );
    
    for ( ;; )
    {
        self waittill( "weapon_change", var0 );
        
        if ( var0.basename == "iw8_throwingknife_electric_melee_mp" )
        {
            self setscriptablepartstate( "WeaponVFXViewmodel", "electricKnife" );
            self waittill( "weapon_change" );
            self setscriptablepartstate( "WeaponVFXViewmodel", "neutral" );
        }
    }
}

// Params 0
// Size: 0x11
function votesys_new()
{
    self setscriptablepartstate( "WeaponVFXViewmodel", "neutral" );
}

// Params 0
// Size: 0x7e
function watchthrowingknifescavenge()
{
    self endon( "death_or_disconnect" );
    self endon( "specialty_equip_throwingKnife_end" );
    
    for ( ;; )
    {
        self waittill( "offhand_fired", var0 );
        
        if ( scripts\mp\utility\weapon::isthrowingknife( var0 ) )
        {
            var1 = self getammocount( var0 );
            
            if ( var1 == 0 )
            {
                if ( isdefined( self.ref_13b5c ) && self hasweapon( self.ref_13b5c ) )
                {
                    self takeweapon( self.ref_13b5c );
                }
            }
            
            while ( self getammocount( var0 ) == 0 )
            {
                wait 0.05;
            }
            
            self giveweapon( self.ref_13b5c );
            self assignweaponmeleeslot( self.ref_13b5c );
        }
    }
}

// Params 0
// Size: 0x54
function setbulletoutline()
{
    self.bulletoutline = spawnstruct();
    self.bulletoutline.player = self;
    self.bulletoutline.enemies = [];
    self.bulletoutline.enemyids = [];
    self.bulletoutline.enemyendtimes = [];
    thread watchbulletoutline();
    thread watchbulletoutlinecleanup();
}

// Params 0
// Size: 0x10
function unsetbulletoutline()
{
    self notify( "unsetBulletOutline" );
    self.bulletoutline = undefined;
}

// Params 0
// Size: 0x94
function watchbulletoutline()
{
    self.player endon( "death_or_disconnect" );
    self.player endon( "unsetBulletOutline" );
    
    while ( isdefined( self.player ) )
    {
        var0 = gettime();
        
        foreach ( var3, var2 in self.enemies )
        {
            if ( !isdefined( var2 ) )
            {
                bulletoutlineremoveenemy( undefined, var3 );
                continue;
            }
            
            if ( var2 scripts\mp\utility\perk::_hasperk( "specialty_noscopeoutline" ) )
            {
                bulletoutlineremoveenemy( var2, var3 );
                continue;
            }
            
            if ( var0 >= self.enemyendtimes[ var3 ] )
            {
                bulletoutlineremoveenemy( var2, var3 );
            }
        }
        
        waitframe();
    }
}

// Params 0
// Size: 0x48
function watchbulletoutlinecleanup()
{
    self.player scripts\engine\utility::ref_143a5( "disconnect", "unsetBulletOutline" );
    
    foreach ( var1 in self.enemies )
    {
        if ( isdefined( var1 ) )
        {
            bulletoutlineremoveenemy( var1, var2 );
        }
    }
}

// Params 3
// Size: 0x69
function bulletoutlineaddenemy( var0, var1, var2 )
{
    var3 = var0 getentitynumber();
    var4 = gettime() + var1 * 1000;
    self.enemies[ var3 ] = var0;
    
    if ( !isdefined( self.enemyids[ var3 ] ) )
    {
        self.enemyids[ var3 ] = scripts\mp\utility\outline::outlineenableforplayer( var0, self.player, "outline_depth_red", "perk" );
    }
    
    if ( !isdefined( self.enemyendtimes[ var3 ] ) || !isdefined( var2 ) || var2 )
    {
        self.enemyendtimes[ var3 ] = var4;
        return;
    }
}

// Params 2
// Size: 0x37
function bulletoutlineremoveenemy( var0, var1 )
{
    if ( !isdefined( var1 ) )
    {
        var1 = var0 getentitynumber();
    }
    
    self.enemies[ var1 ] = undefined;
    self.enemyendtimes[ var1 ] = undefined;
    
    if ( isdefined( var0 ) )
    {
        scripts\mp\utility\outline::outlinedisable( self.enemyids[ var1 ], var0 );
    }
    
    self.enemyids[ var1 ] = undefined;
}

// Params 4
// Size: 0xff
function bulletoutlinecheck( var0, var1, var2, var3 )
{
    if ( !( var3 == "MOD_HEAD_SHOT" || var3 == "MOD_RIFLE_BULLET" || var3 == "MOD_PISTOL_BULLET" || var3 == "MOD_EXPLOSIVE_BULLET" ) )
    {
        return;
    }
    
    if ( !isdefined( var0 ) || !isdefined( var1 ) )
    {
        return;
    }
    
    if ( !isplayer( var0 ) || !isplayer( var1 ) )
    {
        return;
    }
    
    var4 = var0;
    
    if ( isdefined( var0.owner ) )
    {
        var4 = var0.owner;
    }
    
    var5 = var1;
    
    if ( isdefined( var1.owner ) )
    {
        var5 = var1.owner;
    }
    
    if ( !istrue( scripts\cp_mp\utility\player_utility::playersareenemies( var4, var5 ) ) )
    {
        return;
    }
    
    if ( isplayer( var0 ) && isplayer( var1 ) && scripts\mp\utility\outline::outlineoccluded( var0 geteye(), var1 geteye() ) )
    {
        return;
    }
    
    if ( isdefined( var0.bulletoutline ) && !var1 scripts\mp\utility\perk::_hasperk( "specialty_noscopeoutline" ) )
    {
        bulletoutlineaddenemy( var0.bulletoutline, var1, 1 );
    }
    
    if ( isdefined( var1.bulletoutline ) && !var0 scripts\mp\utility\perk::_hasperk( "specialty_noscopeoutline" ) )
    {
        bulletoutlineaddenemy( var1.bulletoutline, var0, 2, 0 );
        return;
    }
}

// Params 2
// Size: 0x6a
function markempsignatures( var0, var1 )
{
    if ( !isdefined( var0.empmarked ) )
    {
        var0.empmarked = [];
    }
    
    if ( isdefined( var0.empmarked[ var1 ] ) && var0.empmarked[ var1 ] == "active" )
    {
        return;
    }
    
    var0.empmarked[ var1 ] = "active";
    thread empvfx( var0, var1 );
    var0 scripts\engine\utility::ref_143a5( "death", "cloak_end" );
    var0.empmarked[ var1 ] = undefined;
}

// Params 2
// Size: 0x3b
function empvfx( var0, var1 )
{
    var2 = [ "j_shoulder_ri", "j_shoulder_le", "j_hip_ri", "j_hip_le", "j_spine4", "j_wrist_ri", "j_wrist_le" ];
    var0.empmarked[ var1 ] = undefined;
}

// Params 0
// Size: 0xb2
function startgpsjammer()
{
    self endon( "remove_gpsjammer" );
    self endon( "death_or_disconnect" );
    
    if ( isai( self ) )
    {
        while ( isdefined( self.avoidkillstreakonspawntimer ) && self.avoidkillstreakonspawntimer > 0 )
        {
            waitframe();
        }
    }
    
    if ( level.minspeedsq == 0 )
    {
        return;
    }
    
    if ( level.timeperiod < 0.05 )
    {
        return;
    }
    
    self.timesincelastweaponfire = 0;
    thread ghostadvanceduavwatcher();
    
    if ( scripts\mp\utility\game::unset_relic_grounded() && getdvarint( "perk_ghost_only_while_moving", 1 ) )
    {
        thread ref_11d12();
    }
    else
    {
        self setplayerghost( 1 );
        self.ref_122fe = 1;
    }
    
    self.timesincelastweaponfire = 0;
    
    for ( ;; )
    {
        self waittill( "weapon_fired", var0 );
        
        if ( scripts\mp\class::vehicle_checkpiggybackexploit( var0 ) )
        {
            continue;
        }
        
        doghostweaponfired();
    }
}

// Params 0
// Size: 0x71
function doghostweaponfired()
{
    self endon( "remove_gpsjammer" );
    self endon( "death_or_disconnect" );
    self setplayerghost( 0 );
    self.playbattlechattersound = 1;
    thread checkforghostweaponfire();
    
    while ( self.timesincelastweaponfire < 3 )
    {
        wait level.timeperiod;
        self.timesincelastweaponfire += level.timeperiod;
    }
    
    self notify( "ghost_restored" );
    self.timesincelastweaponfire = 0;
    
    if ( self.ref_122fe )
    {
        self setplayerghost( 1 );
    }
    
    self.playbattlechattersound = undefined;
}

// Params 0
// Size: 0x2c
function checkforghostweaponfire()
{
    self endon( "death_or_disconnect" );
    self endon( "remove_gpsjammer" );
    self endon( "ghost_restored" );
    
    for ( ;; )
    {
        self waittill( "weapon_fired" );
        self.timesincelastweaponfire = 0;
    }
}

// Params 0
// Size: 0x109
function ghostadvanceduavwatcher()
{
    self endon( "death_or_disconnect" );
    self endon( "remove_gpsjammer" );
    var0 = scripts\mp\utility\game::getgametype() == "br";
    
    if ( var0 )
    {
        self setplayeradvanceduavdot( 1 );
        return;
    }
    
    for ( ;; )
    {
        if ( level.teambased )
        {
            var1 = sat_setup_interactions();
            
            if ( var1 )
            {
                self setplayeradvanceduavdot( 1 );
                self setplayerghost( 0 );
                
                while ( var1 )
                {
                    waitframe();
                    var1 = sat_setup_interactions();
                }
                
                self setplayerghost( 1 );
                self setplayeradvanceduavdot( 0 );
            }
        }
        else
        {
            foreach ( var3 in level.players )
            {
                if ( var3 == self )
                {
                    continue;
                }
                
                if ( istrue( level.activeadvanceduavs[ var3.guid ] ) && level.activeadvanceduavs[ var3.guid ] > 0 )
                {
                    self setplayeradvanceduavdot( 1 );
                    self setplayerghost( 0 );
                    
                    while ( istrue( level.activeadvanceduavs[ var3.guid ] ) && level.activeadvanceduavs[ var3.guid ] > 0 )
                    {
                        level waittill( "uav_update" );
                    }
                    
                    self setplayerghost( 1 );
                    self setplayeradvanceduavdot( 0 );
                }
            }
        }
        
        waitframe();
    }
}

// Params 0
// Size: 0xbd
function sat_setup_interactions()
{
    var0 = 0;
    var1 = undefined;
    
    if ( !isdefined( level.audio_heli_end_fade_out ) || !isdefined( level.activeadvanceduavs ) )
    {
        return var0;
    }
    
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "squadAsTeamEnabled" ) )
    {
        var1 = level [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "squadAsTeamEnabled" ) ]]();
    }
    
    if ( istrue( var1 ) && getdvarint( "scr_uav_for_squad_only", 1 ) )
    {
        var2 = 0;
        
        foreach ( var4 in level.squaddata[ self.team ] )
        {
            var2 += level.activeadvanceduavs[ self.team + var5 ];
        }
        
        var0 = level.audio_heli_end_fade_out - var2 > 0;
    }
    else
    {
        var0 = level.audio_heli_end_fade_out - level.activeadvanceduavs[ self.team ] > 0;
    }
    
    return var0;
}

// Params 0
// Size: 0x15b
function ref_11d12()
{
    self endon( "remove_gpsjammer" );
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    var0 = getdvarint( "perk_ghost_speed_threshold", 190 );
    self.ref_122fe = 0;
    var1 = 0;
    
    for ( ;; )
    {
        var2 = self.super;
        var3 = isdefined( var2 ) && isdefined( var2.staticdata.ref ) && isdefined( var2.usepercent );
        
        if ( var3 && var2.staticdata.ref == "super_deadsilence" && var2.usepercent > 0 || isdefined( self.vehicle ) )
        {
            if ( !self.ref_122fe )
            {
                self.ref_122fe = 1;
                var1 = 0;
                self setplayerghost( 1 );
            }
            
            if ( var1 && self.ref_122fe )
            {
                self notify( "enable_ghost" );
                var1 = 0;
            }
            
            waitframe();
            continue;
        }
        
        var4 = self getvelocity();
        var5 = abs( var4[ 0 ] ) + abs( var4[ 1 ] ) + abs( var4[ 2 ] );
        
        if ( var5 >= var0 && !self.ref_122fe && !self isjumping() && !istrue( self.playbattlechattersound ) )
        {
            self.ref_122fe = 1;
            var1 = 0;
            self setplayerghost( 1 );
        }
        else if ( var5 >= var0 && var1 && self.ref_122fe )
        {
            self notify( "enable_ghost" );
            var1 = 0;
        }
        else if ( var5 < var0 && self.ref_122fe && !var1 )
        {
            thread ref_122fd();
            var1 = 1;
        }
        
        waitframe();
    }
}

// Params 0
// Size: 0x37
function ref_122fd()
{
    self endon( "enable_ghost" );
    self endon( "remove_gpsjammer" );
    self endon( "disconnect" );
    wait getdvarfloat( "perk_ghost_falloff_delay", 2 );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.ref_122fe = 0;
    self setplayerghost( 0 );
}

// Params 0
// Size: 0x1c
function removegpsjammer()
{
    self notify( "remove_gpsjammer" );
    self setplayerghost( 0 );
    self.ref_122fe = undefined;
    self setplayeradvanceduavdot( 0 );
}

// Params 0
// Size: 0x16
function setgroundpoundshield()
{
    level._effect[ "groundPoundShield_impact" ] = loadfx( "vfx/iw7/_requests/mp/vfx_debug_warning.vfx" );
}

// Params 0
// Size: 0xa
function unsetgroundpoundshield()
{
    self notify( "groundPoundShield_unset" );
}

// Params 1
// Size: 0xa
function groundpoundshield_onimpact( var0 )
{
    thread groundpoundshield_raiseondelay();
}

// Params 0
// Size: 0x22
function groundpoundshield_raiseondelay()
{
    self endon( "death_or_disconnect" );
    self endon( "groundPound_unset" );
    self endon( "groundPoundLand" );
    wait 0.25;
    groundpoundshield_raise();
}

// Params 0
// Size: 0x19e
function groundpoundshield_raise()
{
    if ( isdefined( self.groundpoundshield ) )
    {
        thread groundpoundshield_lower( self.groundpoundshield );
    }
    
    var0 = self.origin + anglestoforward( self.angles ) * 5;
    var1 = self.angles + ( 0, 90, 0 );
    var2 = spawn( "script_model", var0 );
    var2.angles = var1;
    var2 setmodel( "weapon_shinguard_col_wm" );
    var3 = spawn( "script_model", var0 );
    var3.angles = var1;
    var3 setmodel( "weapon_shinguard_fr_wm" );
    var3.outlineid = scripts\mp\utility\outline::outlineenableforall( var3, "outline_nodepth_cyan", "equipment" );
    var4 = spawn( "script_model", var0 );
    var4.angles = var1;
    var4 setmodel( "weapon_shinguard_en_wm" );
    var4.outlineid = scripts\mp\utility\outline::outlineenableforall( var4, "outline_nodepth_orange", "equipment" );
    var2.visfr = var3;
    var2.visen = var4;
    var2.owner = self;
    var2 setcandamage( 1 );
    var2.health = 9999;
    var2.shieldhealth = 210;
    self.groundpoundshield = var2;
    var5 = level.characters;
    
    foreach ( var7 in var5 )
    {
        if ( !isdefined( var7 ) )
        {
            continue;
        }
        
        if ( level.teambased && var7.team == self.team )
        {
            var4 hidefromplayer( var7 );
            continue;
        }
        
        var3 hidefromplayer( var7 );
    }
    
    thread groundpoundshield_monitorjoinedteam( var2 );
    thread groundpoundshield_loweronleavearea( var2 );
    thread groundpoundshield_lowerontime( var2, 3.25 );
    thread groundpoundshield_loweronjump( var2 );
    thread groundpoundshield_deleteondisconnect( var2 );
    thread groundpoundshield_monitorhealth( var2 );
    thread groundpound_raisefx();
    return var2;
}

// Params 1
// Size: 0x1f
function groundpoundshield_lower( var0 )
{
    self notify( "groundPoundShield_end" );
    
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    thread groundpoundshield_lowerfx();
    thread groundpoundshield_deleteshield( var0 );
}

// Params 1
// Size: 0x1f
function groundpoundshield_break( var0 )
{
    self notify( "groundPoundShield_end" );
    
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    thread groundpoundshield_breakfx();
    thread groundpoundshield_deleteshield( var0 );
}

// Params 1
// Size: 0x12a
function groundpoundshield_monitorhealth( var0 )
{
    self endon( "death_or_disconnect" );
    self endon( "groundPound_unset" );
    self endon( "groundPoundShield_end" );
    self endon( "groundPoundShield_deleteShield" );
    
    for ( ;; )
    {
        var0 waittill( "damage", var1, var2, var3, var4, var5, var6, var7, var8, var9, var10 );
        
        if ( isdefined( var2 ) )
        {
            if ( var2 == self || var2.team != self.team )
            {
                var0.shieldhealth -= var1;
            }
        }
        
        var0.health = 9999;
        thread groundpoundshield_damagedfx( var2, var4, var3 );
        
        if ( var0.shieldhealth <= 0 )
        {
            thread groundpoundshield_break( var0 );
            return;
        }
        
        if ( var0.shieldhealth <= 105 )
        {
            if ( var0.visfr.model != "weapon_shinguard_dam_wm" )
            {
                var0.visfr setmodel( "weapon_shinguard_dam_wm" );
                scripts\mp\utility\outline::outlinerefresh( var0.visfr );
            }
            
            if ( var0.visen.model != "weapon_shinguard_dam_wm" )
            {
                var0.visen setmodel( "weapon_shinguard_dam_wm" );
                scripts\mp\utility\outline::outlinerefresh( var0.visen );
            }
        }
    }
}

// Params 1
// Size: 0x47
function groundpoundshield_loweronjump( var0 )
{
    self endon( "death_or_disconnect" );
    self endon( "groundPound_unset" );
    self endon( "groundPoundShield_end" );
    self endon( "groundPoundShield_deleteShield" );
    var1 = self isjumping();
    var2 = undefined;
    
    for ( ;; )
    {
        var2 = var1;
        var1 = self isjumping();
        
        if ( !var2 && var1 )
        {
            thread groundpoundshield_lower( var0 );
            return;
        }
        
        waitframe();
    }
}

// Params 2
// Size: 0x2a
function groundpoundshield_lowerontime( var0, var1 )
{
    self endon( "death_or_disconnect" );
    self endon( "groundPound_unset" );
    self endon( "groundPoundShield_end" );
    self endon( "groundPoundShield_deleteShield" );
    wait var1;
    thread groundpoundshield_lower( var0 );
}

// Params 1
// Size: 0x48
function groundpoundshield_loweronleavearea( var0 )
{
    self endon( "death_or_disconnect" );
    self endon( "groundPound_unset" );
    self endon( "groundPoundShield_end" );
    self endon( "groundPoundShield_deleteShield" );
    
    while ( isdefined( var0 ) )
    {
        if ( lengthsquared( var0.origin - self.origin ) > 11664 )
        {
            thread groundpoundshield_lower( var0 );
            return;
        }
        
        waitframe();
    }
}

// Params 1
// Size: 0x22
function groundpoundshield_deleteondisconnect( var0 )
{
    self endon( "groundPoundShield_deleteShield" );
    scripts\engine\utility::ref_143a5( "death_or_disconnect", "groundPound_unset" );
    thread groundpoundshield_deleteshield( var0 );
}

// Params 1
// Size: 0x4
function groundpoundshield_monitorjoinedteam( var0 )
{
    
}

// Params 1
// Size: 0x5b
function groundpoundshield_deleteshield( var0 )
{
    self notify( "groundPoundShield_deleteShield" );
    scripts\mp\utility\outline::outlinedisable( var0.visen.outlineid, var0.visen );
    scripts\mp\utility\outline::outlinedisable( var0.visfr.outlineid, var0.visfr );
    var0.visfr delete();
    var0.visen delete();
    var0 delete();
}

// Params 0
// Size: 0x1e
function groundpound_raisefx()
{
    self endon( "disconnect" );
    self endon( "groundPound_unset" );
    self endon( "groundPoundShield_end" );
    self endon( "groundPoundShield_deleteShield" );
}

// Params 0
// Size: 0x1e
function groundpoundshield_lowerfx()
{
    self endon( "disconnect" );
    self endon( "groundPound_unset" );
    self endon( "groundPoundShield_end" );
    self endon( "groundPoundShield_deleteShield" );
}

// Params 3
// Size: 0x4b
function groundpoundshield_damagedfx( var0, var1, var2 )
{
    self endon( "disconnect" );
    self endon( "groundPound_unset" );
    self endon( "groundPoundShield_end" );
    self endon( "groundPoundShield_deleteShield" );
    playfx( scripts\engine\utility::getfx( "groundPoundShield_impact" ), var1, -1 * var2 );
    playsoundatpos( var1, "ds_shield_impact" );
    var0 scripts\mp\damagefeedback::updatedamagefeedback( "hitbulletstorm" );
}

// Params 0
// Size: 0x1e
function groundpoundshield_breakfx()
{
    self endon( "disconnect" );
    self endon( "groundPound_unset" );
    self endon( "groundPoundShield_end" );
    self endon( "groundPoundShield_deleteShield" );
}

// Params 0
// Size: 0x2a
function setgroundpoundshock()
{
    level._effect[ "groundPoundShock_impact_sm" ] = loadfx( "vfx/iw7/_requests/mp/vfx_debug_warning.vfx" );
    level._effect[ "groundPoundShock_impact_lrg" ] = loadfx( "vfx/iw7/_requests/mp/vfx_debug_warning.vfx" );
}

// Params 0
// Size: 0xa
function unsetgroundpoundshock()
{
    self notify( "groundPoundShock_unset" );
}

// Params 1
// Size: 0x120
function groundpoundshock_onimpact( var0 )
{
    self endon( "death_or_disconnect" );
    self endon( "groundPound_unset" );
    self endon( "groundPoundShock_unset" );
    var1 = undefined;
    var2 = undefined;
    
    switch ( var0 )
    {
        case "groundPoundLandTier0":
            var2 = scripts\engine\utility::getfx( "groundPoundShock_impact_sm" );
            var1 = 144;
            break;
        case "groundPoundLandTier1":
            var2 = scripts\engine\utility::getfx( "groundPoundShock_impact_sm" );
            var1 = 180;
            break;
        case "groundPoundLandTier2":
            var2 = scripts\engine\utility::getfx( "groundPoundShock_impact_lrg" );
            var1 = 216;
            break;
    }
    
    thread groundpoundshock_onimpactfx( var1, var2 );
    var3 = undefined;
    
    if ( level.teambased )
    {
        var3 = scripts\mp\utility\teams::getenemyplayers( self.team, 1 );
    }
    else
    {
        var3 = level.characters;
    }
    
    var4 = var1 * var1;
    var5 = scripts\engine\trace::create_contents( 0, 1, 0, 0, 1, 0, 0 );
    
    foreach ( var7 in var3 )
    {
        if ( lengthsquared( var7 geteye() - self geteye() ) > var4 )
        {
            continue;
        }
        
        var8 = physics_raycast( self geteye(), var7 geteye(), var5, undefined, 0, "physicsquery_closest" );
        
        if ( isdefined( var8 ) && var8.size > 0 )
        {
            continue;
        }
        
        thread groundpoundshock_empplayer( var7 );
    }
}

// Params 1
// Size: 0x1a
function groundpoundshock_empplayer( var0 )
{
    var0 endon( "death_or_disconnect" );
    thread scripts\mp\gamescore::trackdebuffassistfortime( self, var0, "groundpound_mp", 3 );
}

// Params 2
// Size: 0x2a
function groundpoundshock_onimpactfx( var0, var1 )
{
    playfx( var1, self.origin + ( 0, 0, 20 ), ( 0, 0, 1 ) );
}

// Params 0
// Size: 0x2
function setgroundpoundboost()
{
    
}

// Params 0
// Size: 0xa
function unsetgroundpoundboost()
{
    self notify( "groundPoundBoost_unset" );
}

// Params 1
// Size: 0xf
function groundpoundboost_onimpact( var0 )
{
    scripts\common\utility::set_doublejumpenergy( self energy_getmax( 0 ) );
}

// Params 0
// Size: 0x1c
function setbattleslideshield()
{
    level._effect[ "battleSlideShield_damage" ] = loadfx( "vfx/iw7/_requests/mp/vfx_debug_warning.vfx" );
    thread battleslideshield_monitor();
}

// Params 0
// Size: 0xa
function unsetbattleslideshield()
{
    self notify( "battleSlideShield_unset" );
}

// Params 0
// Size: 0x30
function battleslideshield_monitor()
{
    self endon( "death_or_disconnect" );
    self endon( "battleSlide_unset" );
    self notify( "battleSlideShield_monitor" );
    self endon( "battleSlideShield_monitor" );
    
    for ( ;; )
    {
        self waittill( "sprint_slide_begin" );
        thread battleslideshield_raise();
    }
}

// Params 1
// Size: 0xc4
function battleslideshield_monitorhealth( var0 )
{
    self endon( "disconnect" );
    self endon( "battleSlide_unset" );
    
    while ( isdefined( var0 ) )
    {
        var0 waittill( "damage", var1, var2, var3, var4, var5, var6, var7, var8, var9, var10 );
        thread battleslideshield_damagedfx( var0, var2, var4, var3 );
        
        if ( var0.health <= 0 )
        {
            thread battleslideshield_break( var0 );
            var0 delete();
            continue;
        }
        
        if ( var0.health <= 125 )
        {
            if ( var0.model != "weapon_shinguard_dam_wm" )
            {
                var0 setmodel( "weapon_shinguard_dam_wm" );
            }
            
            continue;
        }
        
        if ( var0.model != "weapon_shinguard_wm" )
        {
            var0 setmodel( "weapon_shinguard_wm" );
        }
    }
}

// Params 0
// Size: 0x9a
function battleslideshield_raise()
{
    if ( isdefined( self.battleslideshield ) )
    {
        thread battleslideshield_lower( self.battleslideshield );
    }
    
    var0 = scripts\engine\utility::spawn_tag_origin();
    var0 setmodel( "weapon_shinguard_wm" );
    var0 setcandamage( 1 );
    var0.health = 250;
    var0 linkto( self, "tag_origin", ( 30, 0, 0 ), ( 0, 90, 0 ) );
    var0 show();
    self.battleslideshield = var0;
    thread battleslideshield_killonjumpfall( var0 );
    thread battleslideshield_killonsprint( var0 );
    thread battleslideshield_killontime( var0 );
    thread battleslideshield_unlinkonstop( var0 );
    thread battleslideshield_monitorhealth( var0 );
    thread battleslideshield_killondeathdisconnectunset( var0 );
    thread battleslideshield_raisefx( var0 );
    return var0;
}

// Params 1
// Size: 0x1e
function battleslideshield_lower( var0 )
{
    self notify( "battleSlideShield_end" );
    
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    thread battleslideshield_lowerfx( var0 );
    var0 delete();
}

// Params 1
// Size: 0x20
function battleslideshield_killondeathdisconnectunset( var0 )
{
    var0 endon( "death" );
    scripts\engine\utility::ref_143a5( "death_or_disconnect", "battleSlide_unset" );
    var0 delete();
}

// Params 1
// Size: 0x40
function battleslideshield_killonjumpfall( var0 )
{
    self endon( "death_or_disconnect" );
    self endon( "battleSlide_unset" );
    self endon( "battleSlideShield_unlink" );
    self endon( "battleSlideShield_end" );
    var0 endon( "death" );
    
    for ( ;; )
    {
        if ( !self isonground() )
        {
            var0 delete();
            self notify( "battleSlideShield_end" );
            return;
        }
        
        waitframe();
    }
}

// Params 1
// Size: 0x3c
function battleslideshield_killonsprint( var0 )
{
    self endon( "death_or_disconnect" );
    self endon( "battleSlide_unset" );
    self endon( "battleSlideShield_unlink" );
    self endon( "battleSlideShield_end" );
    var0 endon( "death" );
    self waittill( "sprint_begin" );
    var0 delete();
    self notify( "battleSlideShield_end" );
}

// Params 1
// Size: 0x43
function battleslideshield_loweronleavearea( var0 )
{
    self endon( "death_or_disconnect" );
    self endon( "battleSlide_unset" );
    self endon( "battleSlideShield_end" );
    var0 endon( "death" );
    
    for ( ;; )
    {
        if ( lengthsquared( var0.origin - self.origin ) > 11664 )
        {
            thread battleslideshield_lower( var0 );
            return;
        }
        
        waitframe();
    }
}

// Params 1
// Size: 0x2d
function battleslideshield_lowerontime( var0 )
{
    self endon( "death_or_disconnect" );
    self endon( "battleSlide_unset" );
    self endon( "battleSlideShield_end" );
    var0 endon( "death" );
    wait 3.5;
    thread battleslideshield_lower( var0 );
}

// Params 1
// Size: 0x2d
function battleslideshield_unlink( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    var0 unlink();
    self notify( "battleSlideShield_unlink" );
    thread battleslideshield_lowerontime( var0 );
    thread battleslideshield_loweronleavearea( var0 );
    self notify( "battleSlideShield_unlink" );
}

// Params 1
// Size: 0x42
function battleslideshield_killontime( var0 )
{
    self endon( "death_or_disconnect" );
    self endon( "battleSlide_unset" );
    self endon( "battleSlideShield_unlink" );
    self endon( "battleSlideShield_end" );
    var0 endon( "death" );
    self waittill( "sprint_slide_end" );
    wait 0.75;
    var0 delete();
    self notify( "battleSlideShield_end" );
}

// Params 1
// Size: 0x48
function battleslideshield_unlinkonstop( var0 )
{
    self endon( "death_or_disconnect" );
    self endon( "battleSlide_unset" );
    self endon( "battleSlideShield_unlink" );
    self endon( "battleSlideShield_end" );
    var0 endon( "death" );
    self waittill( "sprint_slide_end" );
    
    for ( ;; )
    {
        if ( lengthsquared( self getvelocity() ) < 100 )
        {
            thread battleslideshield_unlink( var0 );
            return;
        }
        
        waitframe();
    }
}

// Params 1
// Size: 0x19
function battleslideshield_break( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    thread battleslideshield_breakfx( var0 );
    self notify( "battleSlideShield_end" );
}

// Params 1
// Size: 0x19
function battleslideshield_raisefx( var0 )
{
    self endon( "disconnect" );
    self endon( "battleSlide_unset" );
    var0 endon( "death" );
}

// Params 1
// Size: 0x19
function battleslideshield_lowerfx( var0 )
{
    self endon( "disconnect" );
    self endon( "battleSlide_unset" );
    var0 endon( "death" );
}

// Params 4
// Size: 0x45
function battleslideshield_damagedfx( var0, var1, var2, var3 )
{
    self endon( "disconnect" );
    self endon( "battleSlide_unset" );
    var0 endon( "death" );
    playfx( scripts\engine\utility::getfx( "battleSlideShield_damage" ), var2, -1 * var3 );
    playsoundatpos( var2, "ds_shield_impact" );
    var1 scripts\mp\damagefeedback::updatedamagefeedback( "hitbulletstorm" );
}

// Params 1
// Size: 0x4
function battleslideshield_breakfx( var0 )
{
    
}

// Params 0
// Size: 0x2
function setbattleslideoffense()
{
    
}

// Params 0
// Size: 0x2
function unsetbattleslideoffense()
{
    
}

// Params 0
// Size: 0x5
function getbattleslideoffensedamage()
{
    return 100;
}

// Params 0
// Size: 0x2f
function setthruster()
{
    level._effect[ "thrusterRadFr" ] = loadfx( "vfx/iw7/core/mp/powers/thrust_blast/vfx_thrust_blast_radius_fr" );
    level._effect[ "thrusterRadEn" ] = loadfx( "vfx/iw7/core/mp/powers/thrust_blast/vfx_thrust_blast_radius_en" );
    thrusterwatchdoublejump();
}

// Params 0
// Size: 0x1c
function unsetthruster()
{
    if ( isdefined( self.thrustfxent ) )
    {
        self.thrustfxent delete();
    }
    
    self notify( "thruster_unset" );
}

// Params 0
// Size: 0x2e
function thrusterwatchdoublejump()
{
    self endon( "death_or_disconnect" );
    self endon( "thruster_unset" );
    level endon( "game_ended" );
    
    for ( ;; )
    {
        self waittill( "doubleJumpBoostBegin" );
        thread thrusterloop();
        thread thrusterdamageloop();
    }
}

// Params 0
// Size: 0xed
function thrusterloop()
{
    self endon( "death_or_disconnect" );
    self endon( "thruster_unset" );
    level endon( "game_ended" );
    self endon( "doubleJumpBoostEnd" );
    thread thrusterstopfx();
    
    if ( !isdefined( self.thrustfxent ) )
    {
        self.thrustfxent = spawn( "script_model", self.origin );
        self.thrustfxent setmodel( "tag_origin" );
    }
    else
    {
        self.thrustfxent.origin = self.origin;
    }
    
    waitframe();
    
    for ( ;; )
    {
        self playrumbleonentity( "damage_light" );
        earthquake( 0.1, 0.3, self.origin, 120 );
        var0 = playerphysicstrace( self.origin + ( 0, 0, 10 ), self.origin - ( 0, 0, 600 ) ) + ( 0, 0, 1 );
        self.thrustfxent.origin = var0;
        self.thrustfxent.angles = ( 90, 0, 0 );
        waitframe();
        wait 0.33;
    }
}

// Params 0
// Size: 0x48
function thrusterdamageloop()
{
    self endon( "death_or_disconnect" );
    self endon( "thruster_unset" );
    level endon( "game_ended" );
    self endon( "doubleJumpBoostEnd" );
    
    for ( ;; )
    {
        scripts\mp\utility\damage::radiusplayerdamage( self.origin, 12, 64, 5, 12, self, undefined, "MOD_IMPACT", "thruster_mp", 1 );
        wait 0.05;
    }
}

// Params 0
// Size: 0x21
function thrusterstopfx()
{
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    scripts\engine\utility::ref_143a5( "doubleJumpBoostEnd", "thruster_unset" );
    waitframe();
}

// Params 0
// Size: 0x56
function runhover()
{
    self endon( "death_or_disconnect" );
    self endon( "removeArchetype" );
    level endon( "game_ended" );
    
    for ( ;; )
    {
        if ( self ishighjumping() && self playerads() > 0.3 && self energy_getenergy( 0 ) > 0 )
        {
            executehover();
            thread watchhoverend();
            self waittill( "hover_ended" );
            endhover();
        }
        
        wait 0.1;
    }
}

// Params 0
// Size: 0x37
function watchhoverend()
{
    self endon( "death_or_disconnect" );
    self endon( "removeArchetype" );
    level endon( "game_ended" );
    self endon( "walllock_ended" );
    
    while ( self playerads() > 0.3 )
    {
        waitframe();
    }
    
    self notify( "hover_ended" );
}

// Params 0
// Size: 0x47
function executehover()
{
    self endon( "death_or_disconnect" );
    self endon( "removeArchetype" );
    level endon( "game_ended" );
    self.ishovering = 1;
    self allowmovement( 0 );
    self allowjump( 0 );
    self playlocalsound( "ghost_wall_attach" );
    var0 = scripts\engine\utility::spawn_tag_origin();
    self playerlinkto( var0 );
    thread managetimeout( var0 );
}

// Params 1
// Size: 0x44
function managetimeout( var0 )
{
    self endon( "death_or_disconnect" );
    self endon( "removeArchetype" );
    level endon( "game_ended" );
    var1 = self energy_getrestorerate( 0 );
    self energy_setrestorerate( 0, 1 );
    wait 2;
    self notify( "hover_ended" );
    self energy_setrestorerate( 0, var1 );
    self energy_setenergy( 0, 0 );
}

// Params 0
// Size: 0x3a
function endhover()
{
    self endon( "death_or_disconnect" );
    self endon( "removeArchetype" );
    level endon( "game_ended" );
    self.ishovering = undefined;
    self allowmovement( 1 );
    self allowjump( 1 );
    self playlocalsound( "ghost_wall_detach" );
    self unlink();
}

// Params 0
// Size: 0x2
function setadsmarktarget()
{
    
}

// Params 0
// Size: 0xd3
function perk_adsmarktarget_think()
{
    self endon( "death_or_disconnect" );
    self endon( "ADSTargetMarkUnset" );
    level endon( "game_ended" );
    
    for ( ;; )
    {
        if ( self playerads() > 0.5 )
        {
            foreach ( var1 in level.players )
            {
                if ( var1 scripts\mp\utility\perk::_hasperk( "specialty_noscopeoutline" ) )
                {
                    continue;
                }
                
                if ( var1.team == self.team )
                {
                    continue;
                }
                
                if ( istrue( var1.isperk_adsmarked ) )
                {
                    continue;
                }
                
                if ( istrue( var1.ischeckingadsmarking ) )
                {
                    continue;
                }
                
                var1.ischeckingadsmarking = 1;
                thread perk_adstargetmark_disconnectcleanupthink( var1 );
                thread perk_adstargetmark_disconnectcleanupthink( var1 );
                
                if ( perk_adsmarktarget_check( var1 ) )
                {
                    thread perk_adsmarktarget_confirmtargetandmark( var1 );
                    continue;
                }
                
                var1.ischeckingadsmarking = 0;
            }
        }
        
        wait 0.2;
    }
}

// Params 1
// Size: 0x10f, Type: bool
function perk_adsmarktarget_check( var0 )
{
    self endon( "death_or_disconnect" );
    self endon( "ADSTargetMarkUnset" );
    level endon( "game_ended" );
    var1 = physics_createcontents( [ "physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle" ] );
    var2 = distance( var0.origin, self.origin );
    var3 = 0;
    
    if ( var2 != 0 )
    {
        var3 = 1000 * 10 / var2;
    }
    
    var4 = var0 geteye();
    
    if ( var0.team != self.team && ( self worldpointinreticle_circle( var0.origin + ( 0, 0, 24 ), 90, var3 ) || self worldpointinreticle_circle( var4, 90, var3 ) ) )
    {
        var5 = self geteye();
        var6 = var4;
        var7 = physics_raycast( var5, var6, var1, undefined, 0, "physicsquery_closest", 1 );
        
        if ( isdefined( var7 ) && var7.size == 0 )
        {
            return true;
        }
        
        waitframe();
        var6 = var0.origin + ( 0, 0, 24 );
        var8 = physics_raycast( var5, var6, var1, undefined, 0, "physicsquery_closest", 1 );
        
        if ( isdefined( var8 ) && var8.size == 0 )
        {
            return true;
        }
    }
    
    return false;
}

// Params 1
// Size: 0xf0
function perk_adsmarktarget_confirmtargetandmark( var0 )
{
    var0 endon( "death_or_disconnect" );
    level endon( "game_ended" );
    self endon( "ADSTargetMarkUnset" );
    var1 = undefined;
    var2 = getdvarfloat( "perk_ads_mark_target_hold_time_req" );
    
    if ( scripts\mp\utility\perk::_hasperk( "specialty_improved_target_mark" ) )
    {
        var2 *= getdvarfloat( "perk_faster_target_mark_rate" );
    }
    
    wait var2;
    
    if ( self playerads() > 0.5 && perk_adsmarktarget_check( var0 ) )
    {
        var3 = spawn( "script_model", var0.origin );
        
        if ( scripts\cp_mp\utility\game_utility::isrealismenabled() )
        {
            var4 = 0;
            var5 = 5000;
            var6 = 100;
        }
        else
        {
            var4 = 1;
            var5 = 5000;
            var6 = 0;
        }
        
        var7 = var6 thread scripts\cp_mp\entityheadicons::setheadicon_singleimage( getlivingplayers_team( self.team ), "icon_navbar_enemy", 35, var4, var5, var6, undefined, 1 );
        var4 = scripts\mp\utility\outline::outlineenableforplayer( var3, self, "outlinefill_nodepth_orange", "equipment" );
        var3 scripts\mp\utility\outline::_hudoutlineviewmodelenable( "outline_nodepth_orange", 0 );
        var3.isperk_adsmarked = 1;
        thread perk_trackadsmarktargetoutline( var7, var6, var4, var3 );
        return;
    }
    
    var3.ischeckingadsmarking = 0;
}

// Params 4
// Size: 0x7d
function perk_trackadsmarktargetoutline( var0, var1, var2, var3 )
{
    level endon( "game_ended" );
    wait 0.6;
    scripts\mp\utility\outline::outlinedisable( var2, var3 );
    
    if ( isdefined( var3 ) )
    {
        var3 scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
    }
    
    var4 = getdvarfloat( "perk_ads_mark_target_highlight_time" );
    
    if ( scripts\mp\utility\perk::_hasperk( "specialty_improved_target_mark" ) )
    {
        var4 *= getdvarfloat( "perk_target_marked_longer_rate" );
    }
    
    wait var4 - 0.6;
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon( var0 );
    var1 delete();
    
    if ( isdefined( var3 ) )
    {
        var3.isperk_adsmarked = 0;
        var3.ischeckingadsmarking = 0;
    }
    
    self notify( "adsmark_ended" );
}

// Params 1
// Size: 0x59
function getlivingplayers_team( var0 )
{
    var1 = [];
    
    foreach ( var3 in level.players )
    {
        if ( !isdefined( var3.team ) )
        {
            continue;
        }
        
        if ( var3 scripts\cp_mp\utility\player_utility::_isalive() && var3.team == var0 )
        {
            var1 = var3;
        }
    }
    
    return var1;
}

// Params 1
// Size: 0x23
function perk_adstargetmark_disconnectcleanupthink( var0 )
{
    scripts\engine\utility::ref_143a5( "ADSTargetMarkUnset", "death_or_disconnect" );
    
    if ( isdefined( var0 ) )
    {
        var0.ischeckingadsmarking = 0;
        return;
    }
}

// Params 0
// Size: 0xa
function unsetadsmarktarget()
{
    self notify( "ADSTargetMarkUnset" );
}

// Params 0
// Size: 0x2
function sethelmet()
{
    
}

// Params 0
// Size: 0x2
function unsethelmet()
{
    
}

// Params 0
// Size: 0x8
function setarmorvest()
{
    self.tookvesthit = 0;
}

// Params 0
// Size: 0x2
function unsetarmorvest()
{
    
}

// Params 0
// Size: 0x2
function setladder()
{
    
}

// Params 0
// Size: 0x2
function unsetladder()
{
    
}

// Params 0
// Size: 0x12
function setdoorbreach()
{
    scripts\mp\destructible::allowplayertobreach( self );
    scripts\mp\door::updatealldoorslockvisibilityforplayer( self, 1 );
}

// Params 0
// Size: 0x9
function unsetdoorbreach()
{
    scripts\mp\destructible::allowplayertobreach( self );
}

// Params 0
// Size: 0x21
function setdoorsense()
{
    if ( !isdefined( level.playerswithdoorsense ) )
    {
        level.playerswithdoorsense = 1;
        return;
    }
    
    level.playerswithdoorsense += 1;
}

// Params 0
// Size: 0xf
function unsetdoorsense()
{
    level.playerswithdoorsense -= 1;
}

// Params 0
// Size: 0x7
function setworsenedgunkick()
{
    updateweaponkick();
}

// Params 0
// Size: 0xa
function unsetworsenedgunkick()
{
    updateweaponkick( 1 );
}

// Params 1
// Size: 0x91
function updateweaponkick( var0 )
{
    if ( !isdefined( self.weaponkickrecoil ) )
    {
        self.weaponkickrecoil = 0;
    }
    
    var1 = -25;
    
    if ( scripts\mp\utility\perk::_hasperk( "specialty_worsenedgunkick" ) && !istrue( var0 ) )
    {
        if ( isdefined( self.currentweapon ) )
        {
            switch ( self.currentweapon.classname )
            {
                case "rifle":
                    var1 = -20;
                    break;
                case "mg":
                    var1 = -20;
                    break;
            }
        }
    }
    else
    {
        var1 = 0;
    }
    
    if ( var1 != self.weaponkickrecoil )
    {
        scripts\mp\utility\weapon::setrecoilscale( -1 * self.weaponkickrecoil );
        scripts\mp\utility\weapon::setrecoilscale( var1 );
        self.weaponkickrecoil = var1;
        return;
    }
}

// Params 0
// Size: 0x78
function setkillstreaktoscorestreak()
{
    var0 = undefined;
    
    if ( isdefined( self.pers[ "killstreakToScorestreak_lifeId" ] ) && self.pers[ "killstreakToScorestreak_lifeId" ] == self.lifeid )
    {
        var0 = self.pers[ "killstreakToScorestreak" ];
        self.pers[ "killstreakToScorestreak" ] = undefined;
        self.pers[ "killstreakToScorestreak_lifeId" ] = undefined;
    }
    else
    {
        var0 = vote_player_reset( self.streakpoints );
    }
    
    scripts\mp\killstreaks\killstreaks::updatestreakcosts();
    scripts\mp\killstreaks\killstreaks::setstreakpoints( var0 );
    scripts\mp\killstreaks\killstreaks::checkstreakreward( self.streakpoints, 1 );
    scripts\mp\killstreaks\killstreaks::updatestreakmeterui();
}

// Params 0
// Size: 0x4e
function unsetkillstreaktoscorestreak()
{
    self.pers[ "killstreakToScorestreak" ] = self.streakpoints;
    self.pers[ "killstreakToScorestreak_lifeId" ] = self.lifeid;
    var0 = vote_player_set( self.streakpoints );
    scripts\mp\killstreaks\killstreaks::updatestreakcosts();
    scripts\mp\killstreaks\killstreaks::setstreakpoints( var0 );
    scripts\mp\killstreaks\killstreaks::checkstreakreward( self.streakpoints, 1 );
    scripts\mp\killstreaks\killstreaks::updatestreakmeterui();
}

// Params 1
// Size: 0x9
function vote_player_reset( var0 )
{
    return var0 * 125;
}

// Params 1
// Size: 0xc
function vote_player_set( var0 )
{
    return int( var0 / 125 );
}

// Params 0
// Size: 0x1b
function ref_13137()
{
    if ( self.streakpoints <= 0 )
    {
        self.pers[ "canKillChain" ] = 1;
        return;
    }
}

// Params 0
// Size: 0x17
function ref_13f64()
{
    if ( !istrue( level.gameended ) )
    {
        self.pers[ "canKillChain" ] = undefined;
        return;
    }
}

// Params 0
// Size: 0x1d
function setscrapweapons()
{
    if ( getdvarint( "perk_graverobber_enabled" ) == 1 )
    {
        self setclientomnvar( "ui_graverobber", 1 );
        return;
    }
}

// Params 0
// Size: 0xd
function unsetscrapweapons()
{
    self setclientomnvar( "ui_graverobber", 0 );
}

// Params 0
// Size: 0x11
function setdooralarm()
{
    self.alarmeddoors = [];
    scripts\mp\door::updatealldoorsalarmvisibilityforplayer( self, 1 );
}

// Params 0
// Size: 0x3d
function unsetdooralarm()
{
    foreach ( var1 in self.alarmeddoors )
    {
        var1 scripts\mp\door::removealarmdoor( 0 );
    }
    
    self.alarmeddoors = undefined;
    scripts\mp\door::updatealldoorsalarmvisibilityforplayer( self, 0 );
}

// Params 0
// Size: 0x8
function setreviveuseweapon()
{
    thread proximityrevivethink();
}

// Params 0
// Size: 0x24e
function proximityrevivethink()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "unset_revive_use_weapon" );
    
    if ( !isdefined( self.proximityrevivefauxtrigger ) )
    {
        var0 = spawnstruct();
        var0.usetime = getdvarfloat( "perk_medicReviveSpeedRatio" ) * scripts\mp\utility\dvars::getwatcheddvar( "lastStandReviveTimer" );
        var0.curprogress = 0;
        var0.owner = undefined;
        var0.id = "laststand_reviver";
        var0.trigger = spawnstruct();
        var0.trigger.id = "laststand_reviver";
        self.proximityrevivefauxtrigger = var0;
    }
    
    var0 = self.proximityrevivefauxtrigger;
    
    if ( !isdefined( self.hiddenreviveents ) )
    {
        self.hiddenreviveents = [];
    }
    
    self.canrevivewithweapon = 1;
    
    if ( isdefined( level.revivetriggers ) )
    {
        foreach ( var3, var2 in level.revivetriggers )
        {
            if ( !isdefined( self.hiddenreviveents[ var3 ] ) )
            {
                var2.trigger disableplayeruse( self );
                self.hiddenreviveents[ var3 ] = var2.trigger;
            }
        }
    }
    
    foreach ( var2 in level.laststandreviveents )
    {
        if ( !isdefined( self.hiddenreviveents[ var3 ] ) )
        {
            var2 disableplayeruse( self );
            self.hiddenreviveents[ var3 ] = var2;
        }
    }
    
    for ( ;; )
    {
        var5 = scripts\mp\utility\player::getplayersinradius( self.origin, 150, self.team, self );
        
        foreach ( var7 in var5 )
        {
            if ( istrue( var7.inlaststand ) && !istrue( var7.stuckinlaststand ) && !istrue( var7.laststandhealisactive ) && !istrue( var7 scripts\mp\utility\player::registerpuzzleinteractions() ) && !isdefined( var0.owner ) )
            {
                thread proximityrevive( var7, var0 );
            }
        }
        
        if ( isdefined( level.revivetriggers ) )
        {
            foreach ( var10 in level.revivetriggers )
            {
                if ( var10.ownerteam == self.team )
                {
                    if ( !istrue( var10.trigger.owner scripts\mp\utility\player::registerpuzzleinteractions() ) && !isdefined( var0.owner ) )
                    {
                        if ( distancesquared( var10.trigger.origin, self.origin ) <= 22500 )
                        {
                            thread proximityrevive( var10.trigger.owner, var0, var10 );
                        }
                    }
                }
            }
        }
        
        wait 0.1;
    }
}

// Params 3
// Size: 0x174
function proximityrevive( var0, var1, var2 )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "unset_revive_use_weapon" );
    var0 endon( "death_or_disconnect" );
    var0 endon( "last_stand_finished" );
    var0 scripts\mp\utility\player::ref_1312b( 1 );
    var1.owner = var0;
    var1.trigger.owner = var0;
    thread watchproximityrevivefail( var0, var1, var2 );
    
    if ( isdefined( var2 ) )
    {
        var2.trigger hide();
        var2.trigger makeunusable();
        var2 scripts\mp\teamrevive::revivetriggerholdonusebegin( self, 1 );
    }
    else if ( isdefined( var0.laststandreviveent ) )
    {
        var0.laststandreviveent hide();
        var0.laststandreviveent makeunusable();
    }
    
    var0 notify( "handle_revive_message" );
    var0 scripts\mp\utility\player::_freezecontrols( 1, undefined, "proximityRevive" );
    
    while ( var1.curprogress < var1.usetime )
    {
        if ( distancesquared( self.origin, var0.origin ) > 90000 )
        {
            self notify( "prox_revive_fail" );
            return;
        }
        
        scripts\mp\gameobjects::updateuiprogress( var1, 1 );
        var1.curprogress += level.framedurationseconds;
        waitframe();
    }
    
    scripts\mp\gameobjects::updateuiprogress( var1, 0 );
    var0 scripts\mp\gameobjects::updateuiprogress( var1, 0 );
    var0 scripts\mp\utility\player::_freezecontrols( 0, undefined, "proximityRevive" );
    var1.curprogress = 0;
    var1.owner = undefined;
    var1.trigger.owner = undefined;
    
    if ( istrue( var0.inlaststand ) )
    {
        var0 notify( "last_stand_revived" );
        return;
    }
    
    var2 scripts\mp\teamrevive::revivetriggerholdonuseend( self.team, self, 1, 1 );
    var2 scripts\mp\teamrevive::revivetriggerholdonuse( self );
}

// Params 3
// Size: 0xe7
function watchproximityrevivefail( var0, var1, var2 )
{
    level endon( "game_ended" );
    var0 endon( "last_stand_revived" );
    var0 endon( "spawned_player" );
    var3 = var0.team;
    scripts\engine\utility::waittill_any_ents_return( self, "death_or_disconnect", self, "unset_revive_use_weapon", self, "prox_revive_fail", var0, "death_or_disconnect", var0, "last_stand_finished" );
    
    if ( isdefined( var2 ) )
    {
        var2.trigger show();
        var2.trigger makeusable();
        var2 scripts\mp\teamrevive::revivetriggerholdonuseend( var3, self, 0, 1 );
    }
    
    if ( isdefined( var0 ) )
    {
        var0 scripts\mp\utility\player::ref_1312b( 0 );
        var0 scripts\mp\gameobjects::updateuiprogress( var1, 0 );
        var0 scripts\mp\utility\player::_freezecontrols( 0, undefined, "proximityRevive" );
        
        if ( isdefined( var0.laststandreviveent ) )
        {
            var0.laststandreviveent show();
            var0.laststandreviveent makeusable();
        }
        
        var0 notify( "handle_revive_message" );
    }
    
    if ( isdefined( self ) )
    {
        var1.owner = undefined;
        var1.trigger.owner = undefined;
        var1.curprogress = 0;
        scripts\mp\gameobjects::updateuiprogress( var1, 0 );
        return;
    }
}

// Params 0
// Size: 0x51
function unsetreviveuseweapon()
{
    self notify( "unset_revive_use_weapon" );
    self.canrevivewithweapon = undefined;
    
    foreach ( var1 in self.hiddenreviveents )
    {
        if ( isdefined( var1 ) && var1.owner != self )
        {
            var1 showtoplayer( self );
            var1 enableplayeruse( self );
        }
    }
}

// Params 0
// Size: 0x2
function setlocationmarking()
{
    
}

// Params 0
// Size: 0x2
function unsetlocationmarking()
{
    
}

// Params 0
// Size: 0x2
function setremotedefuse()
{
    
}

// Params 0
// Size: 0x2
function unsetremotedefuse()
{
    
}

// Params 0
// Size: 0x7
function setalwaysminimap()
{
    scripts\mp\utility\player::showminimap();
}

// Params 0
// Size: 0x7
function unsetalwaysminimap()
{
    scripts\mp\utility\player::hideminimap();
}

// Params 0
// Size: 0x2a
function supersprintkillrefresh_init()
{
    level._effect[ "super_sprint_refresh" ] = loadfx( "vfx/iw8_mp/perk/vfx_hustle.vfx" );
    level._effect[ "super_sprint_refresh_night" ] = loadfx( "vfx/iw8_mp/perk/vfx_hustle_night.vfx" );
}

// Params 0
// Size: 0x7
function supersprintkillrefresh_onkill()
{
    self refreshsprinttime();
}

// Params 0
// Size: 0xf
function setgasgrenaderesist()
{
    if ( scripts\cp_mp\utility\player_utility::_isalive() )
    {
        return;
    }
    
    scripts\mp\equipment\gas_grenade::gas_updateplayereffects();
}

// Params 0
// Size: 0xf
function unsetgasgrenaderesist()
{
    if ( scripts\cp_mp\utility\player_utility::_isalive() )
    {
        return;
    }
    
    scripts\mp\equipment\gas_grenade::gas_updateplayereffects();
}

// Params 0
// Size: 0x2
function setfastreloadlaunchers()
{
    
}

// Params 0
// Size: 0x1d
function unsetfastreloadlaunchers()
{
    if ( istrue( self.fastreloadlaunchers ) )
    {
        scripts\mp\utility\perk::removeperk( "specialty_fastreload" );
        self.fastreloadlaunchers = undefined;
        return;
    }
}

// Params 0
// Size: 0x9
function setreduceregendelay()
{
    self.regendelayspeed = 2;
}

// Params 0
// Size: 0x9
function unsetreduceregendelay()
{
    self.regendelayspeed = 1;
}

// Params 0
// Size: 0x44
function regendelayreduce_onkill()
{
    var0 = scripts\cp_mp\utility\game_utility::isnightmap();
    var1 = self isnightvisionon();
    var2 = var0 && !var1;
    var3 = scripts\engine\utility::ter_op( var2, scripts\engine\utility::getfx( "super_sprint_refresh_night" ), scripts\engine\utility::getfx( "super_sprint_refresh" ) );
    playfxontagforclients( var3, self, "tag_eye", self );
    thread ref_12acf();
}

// Params 0
// Size: 0x3c
function ref_12acf()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self notify( "regenDelayReduce_delayedRegen" );
    self endon( "regenDelayReduce_delayedRegen" );
    var0 = gettime();
    
    while ( var0 + 140 > gettime() )
    {
        scripts\mp\healthoverlay::reducehealthregendelay( 10000 );
        waitframe();
    }
}

// Params 0
// Size: 0x1d
function ref_131b8()
{
    if ( isdefined( self.waittoopenaltbunker ) && self.waittoopenaltbunker == gettime() )
    {
        regendelayreduce_onkill();
        return;
    }
}

// Params 0
// Size: 0x2
function ref_13f6c()
{
    
}

// Params 0
// Size: 0x44
function ref_12ad0()
{
    var0 = scripts\cp_mp\utility\game_utility::isnightmap();
    var1 = self isnightvisionon();
    var2 = var0 && !var1;
    var3 = scripts\engine\utility::ter_op( var2, scripts\engine\utility::getfx( "super_sprint_refresh_night" ), scripts\engine\utility::getfx( "super_sprint_refresh" ) );
    playfxontagforclients( var3, self, "tag_eye", self );
    thread ref_12acf();
}

// Params 0
// Size: 0x1b
function ref_131ba()
{
    if ( isdefined( self.tracking_max_health ) && istrue( self.tracking_max_health ) )
    {
        ref_12ad0();
        return;
    }
}

// Params 0
// Size: 0xd
function setreduceregendelayonobjective()
{
    updatereduceregendelayonobjective();
    thread monitorreduceregendelayonobjective();
}

// Params 0
// Size: 0x12
function unsetreduceregendelayonobjective()
{
    self notify( "unsetReduceRegenDelayOnObjective" );
    updatereduceregendelayonobjective( 1 );
}

// Params 0
// Size: 0x25
function monitorreduceregendelayonobjective()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "unsetReduceRegenDelayOnObjective" );
    
    for ( ;; )
    {
        wait 0.5;
        updatereduceregendelayonobjective();
    }
}

// Params 1
// Size: 0x81
function updatereduceregendelayonobjective( var0 )
{
    var1 = isdefined( self.carryobject );
    var2 = isdefined( self.touchinggameobjects ) && self.touchinggameobjects.size > 0;
    var3 = isdefined( self.usinggameobjects ) && self.usinggameobjects.size > 0;
    var4 = var1 || var2 || var3;
    
    if ( var4 && !istrue( var0 ) )
    {
        if ( !istrue( self.isonobjective ) )
        {
            self.isonobjective = 1;
            scripts\mp\utility\perk::giveperk( "specialty_regen_delay_reduced" );
            return;
        }
        
        return;
    }
    
    if ( istrue( self.isonobjective ) )
    {
        self.isonobjective = 0;
        scripts\mp\utility\perk::removeperk( "specialty_regen_delay_reduced" );
        return;
    }
}

// Params 0
// Size: 0x24
function setrechargeequipment()
{
    if ( !isdefined( level.perkrechargeequipmentplayers ) )
    {
        return;
    }
    
    self notify( "setRechargeEquipment" );
    level.perkrechargeequipmentplayers = scripts\engine\utility::array_add( level.perkrechargeequipmentplayers, self );
}

// Params 0
// Size: 0x23
function unsetrechargeequipment()
{
    if ( !isdefined( level.perkrechargeequipmentplayers ) )
    {
        return;
    }
    
    level.perkrechargeequipmentplayers = scripts\engine\utility::array_remove( level.perkrechargeequipmentplayers, self );
    thread rechargeequipment_clearplayer( self );
}

// Params 0
// Size: 0xac
function rechargeequipmentthink_init()
{
    level.perkrechargeequipmentplayers = [];
    var0 = int( ceil( 0.5 / level.framedurationseconds ) );
    
    for ( ;; )
    {
        var1 = level.perkrechargeequipmentplayers;
        var2 = int( ceil( var1.size / var0 ) );
        
        for ( var3 = 0; var3 < var0 ; var3++ )
        {
            for ( var4 = 0; var4 < var2 ; var4++ )
            {
                var5 = var3 * var2 + var4;
                
                if ( var5 > var1.size )
                {
                    break;
                }
                
                var6 = var1[ var5 ];
                
                if ( !isdefined( var6 ) )
                {
                    continue;
                }
                
                if ( !var6 scripts\cp_mp\utility\player_utility::_isalive() || istrue( var6.inlaststand ) || istrue( self.stuckinlaststand ) )
                {
                    continue;
                }
                
                rechargeequipment_updatestate( var6 );
            }
            
            waitframe();
        }
    }
}

// Params 1
// Size: 0x57
function rechargeequipment_updatestate( var0 )
{
    if ( !isdefined( var0.rechargeequipmentstate ) )
    {
        var0.rechargeequipmentstate = spawnstruct();
        var0.rechargeequipmentstate.progress = [];
        var0.rechargeequipmentstate.recharged = [];
    }
    
    rechargeequipment_updateslot( var0, "primary" );
    rechargeequipment_updateslot( var0, "secondary" );
    rechargeequipment_updateui( var0 );
}

// Params 2
// Size: 0x157
function rechargeequipment_updateslot( var0, var1 )
{
    var2 = var0.rechargeequipmentstate;
    
    if ( !isdefined( var2.progress[ var1 ] ) )
    {
        var2.progress[ var1 ] = 0;
    }
    
    var2.recharged[ var1 ] = undefined;
    var3 = var0 scripts\mp\equipment::getcurrentequipment( var1 );
    
    if ( !isdefined( var3 ) )
    {
        return;
    }
    
    var4 = relic_squadlink_remove_visionset( var3 );
    var5 = var0 scripts\mp\equipment::getequipmentammo( var3 );
    var6 = var0 scripts\mp\equipment::getequipmentmaxammo( var3 );
    var7 = var0 scripts\mp\equipment::getequipmentstartammo( var3 );
    
    if ( isdefined( level.playerzombiewaittillinputreturn ) )
    {
        var8 = level.playerzombiewaittillinputreturn;
    }
    else if ( var5 == "alt" )
    {
        var8 = scripts\engine\utility::ter_op( scripts\mp\utility\game::getgametype() == "br", 0.00833333, 0.02 );
    }
    else
    {
        var8 = scripts\engine\utility::ter_op( scripts\mp\utility\game::getgametype() == "br", 0.0166667, 0.02 );
    }
    
    if ( var3 == "secondary" && var7 < var8 && var8 > 1 )
    {
        var4.progress[ var3 ] += var8 * 2;
    }
    else if ( var7 < var8 )
    {
        var4.progress[ var3 ] += var8;
    }
    else
    {
        var4.progress[ var3 ] = 0;
    }
    
    if ( var4.progress[ var3 ] >= 1 )
    {
        var2 scripts\mp\equipment::incrementequipmentslotammo( var3, 1 );
        var4.progress[ var3 ] = 0;
        var4.recharged[ var3 ] = 1;
        return;
    }
}

// Params 1
// Size: 0x36
function relic_squadlink_remove_visionset( var0 )
{
    var1 = undefined;
    
    switch ( var0 )
    {
        case "equip_adrenaline":
            var1 = "alt";
            break;
        default:
            var1 = "normal";
            break;
    }
    
    return var1;
}

// Params 1
// Size: 0x21
function rechargeequipment_clearplayer( var0 )
{
    var0 endon( "setRechargeEquipment" );
    var0 endon( "disconnect" );
    var0.rechargeequipmentstate = undefined;
    waitframe();
    rechargeequipment_updateui( var0 );
}

// Params 1
// Size: 0x127
function rechargeequipment_updateui( var0 )
{
    var1 = 0;
    var2 = 0;
    var3 = -1;
    
    if ( isdefined( var0 ) && isdefined( var0.rechargeequipmentstate ) )
    {
        var0 scripts\mp\utility\stats::initpersstat( "restockCount" );
        var4 = var0.rechargeequipmentstate;
        
        if ( isdefined( var4.progress[ "primary" ] ) )
        {
            var1 = var4.progress[ "primary" ];
        }
        
        if ( isdefined( var4.progress[ "secondary" ] ) )
        {
            var2 = var4.progress[ "secondary" ];
        }
        
        foreach ( var6 in var4.recharged )
        {
            if ( var7 == "primary" )
            {
                var3 += 1;
                var0 playlocalsound( "ui_restock_lethals" );
                var0 scripts\mp\utility\stats::incpersstat( "restockCount", 1 );
            }
            
            if ( var7 == "secondary" )
            {
                var3 += 2;
                var0 playlocalsound( "ui_restock_tactical" );
                var0 scripts\mp\utility\stats::incpersstat( "restockCount", 1 );
            }
        }
    }
    
    var0 setclientomnvar( "ui_lethal_recharge_progress", var1 );
    var0 setclientomnvar( "ui_tactical_recharge_progress", var2 );
    var0 setclientomnvar( "ui_recharge_notify", var3 );
    var0 clearladderstate( "primary", var1 );
    var0 clearladderstate( "secondary", var2 );
}

// Params 0
// Size: 0xc7
function markequipment_monitorlook()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "mark_equip_ended" );
    scripts\mp\flags::gameflagwait( "prematch_done" );
    jumpiftrue(isdefined( self.markequipmentstate )) LOC_0000007e;
    self.markequipmentstate = spawnstruct();
    self.markequipmentstate.markingtime = 0;
    self.markequipmentstate.markingent = undefined;
    self.markequipmentstate.markedents = [];
    self.markequipmentstate.markedentindex = 0;
    self.markequipmentstate.pastmarkedents = [];
    self.markequipmentstate.pastmarkedentindex = 0;
    
    for ( ;; )
    {
        self waittill( "marks_target_changed", var0 );
        var1 = isdefined( var0 ) && !isdefined( self.markequipmentstate.markingent );
        self.markequipmentstate.markingent = var0;
        self.markequipmentstate.markingtime = 0;
        
        if ( var1 )
        {
            thread markequipment_updatestate();
        }
    }
}

// Params 0
// Size: 0x340
function markequipment_updatestate()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "mark_equip_ended" );
    var0 = gettime();
    var1 = 0;
    
    if ( self entityhasmark( "air_killstreak", self.markequipmentstate.markingent ) )
    {
        var1 = getdvarint( "perk_see_air_killstreak_distance" );
    }
    else if ( self entityhasmark( "killstreak", self.markequipmentstate.markingent ) )
    {
        var1 = getdvarint( "perk_see_killstreak_distance" );
    }
    else if ( self entityhasmark( "equipment", self.markequipmentstate.markingent ) )
    {
        var1 = getdvarint( "perk_see_equipment_distance" );
    }
    
    var2 = var1 * var1;
    
    while ( isdefined( self.markequipmentstate.markingent ) && !istrue( self.ishacking ) )
    {
        if ( self entitymarkfilteredin( self.markequipmentstate.markingent ) )
        {
            break;
        }
        
        if ( isdefined( self.vehicle ) && self.vehicle == self.markequipmentstate.markingent )
        {
            break;
        }
        
        if ( scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver( self ) )
        {
            break;
        }
        
        if ( distancesquared( self.origin, self.markequipmentstate.markingent.origin ) > var2 )
        {
            break;
        }
        
        var3 = gettime();
        var4 = var3 - var0;
        self.markequipmentstate.markingtime += var4;
        
        if ( !scripts\engine\utility::array_contains( self.markequipmentstate.markedents, self.markequipmentstate.markingent ) )
        {
            if ( scripts\mp\utility\player::isplayerads() )
            {
                var5 = self.markequipmentstate.markedentindex;
                var6 = self.markequipmentstate.markedents[ var5 ];
                
                if ( isdefined( var6 ) )
                {
                    var6 filterinplayermarks( undefined );
                    outlinehelper_updateentityoutline( var6 );
                }
                
                if ( level.teambased )
                {
                    self.markequipmentstate.markingent filterinplayermarks( self.team );
                }
                else
                {
                    self.markequipmentstate.markingent filterinplayermarks( self );
                }
                
                outlinehelper_updateentityoutline( self.markequipmentstate.markingent );
                self playlocalsound( "iw8_mp_perk_tactical_recon_marked" );
                
                if ( level.teambased && _calloutmarkerping_predicted_timeout::ref_14126( self.markequipmentstate.markingent ) )
                {
                    self.markequipmentstate.markingent.ref_13ab2 = self.team;
                    var7 = scripts\mp\utility\player::getteamarray( self.markequipmentstate.markingent.ref_13ab2 );
                    
                    foreach ( var9 in var7 )
                    {
                        _calloutmarkerping_predicted_timeout::ref_14132( self.markequipmentstate.markingent, var9 );
                    }
                }
                
                self.markequipmentstate.markedents[ var5 ] = self.markequipmentstate.markingent;
                self.markequipmentstate.markedentindex = ( var5 + 1 ) % 999;
                
                if ( !scripts\engine\utility::array_contains( self.markequipmentstate.pastmarkedents, self.markequipmentstate.markingent ) )
                {
                    scripts\mp\killstreaks\killstreaks::givescoreformarktarget( 1 );
                    self.markequipmentstate.pastmarkedents[ self.markequipmentstate.pastmarkedentindex ] = self.markequipmentstate.markingent;
                    self.markequipmentstate.pastmarkedentindex++;
                }
                else
                {
                    scripts\mp\killstreaks\killstreaks::givescoreformarktarget( 0 );
                }
                
                thread unmarkafterduration( self.markequipmentstate.markingent );
                break;
            }
        }
        
        var0 = var3;
        waitframe();
    }
    
    if ( !istrue( self.ishacking ) )
    {
        self setclientomnvar( "ui_securing", 0 );
        self setclientomnvar( "ui_securing_progress", 0 );
    }
    
    self.markequipmentstate.markingent = undefined;
    self.markequipmentstate.markingtime = 0;
}

// Params 1
// Size: 0x42
function unmarkafterduration( var0 )
{
    level endon( "game_ended" );
    self endon( "mark_equip_ended" );
    self endon( "unmarkEnt_" + self getentitynumber() );
    var0 endon( "death" );
    var1 = getdvarint( "perk_mark_equipment_duration" );
    scripts\engine\utility::ref_143bf( var1, "disconnect" );
    unmarkent( var0 );
}

// Params 1
// Size: 0x97
function unmarkent( var0 )
{
    var0 filterinplayermarks( undefined );
    
    if ( isdefined( var0.ref_13ab2 ) )
    {
        if ( level.teambased && _calloutmarkerping_predicted_timeout::ref_14126( var0 ) )
        {
            var1 = scripts\mp\utility\player::getteamarray( var0.ref_13ab2 );
            
            foreach ( var3 in var1 )
            {
                _calloutmarkerping_predicted_timeout::ref_14132( var0, var3 );
            }
        }
        
        var0.ref_13ab2 = undefined;
    }
    
    if ( isdefined( self ) )
    {
        self.markequipmentstate.markedents = scripts\engine\utility::array_remove( self.markequipmentstate.markedents, var0 );
        var0 notify( "unmarkEnt_" + self getentitynumber() );
        return;
    }
}

// Params 0
// Size: 0x16
function setmarkequipment()
{
    if ( !level.teambased )
    {
        return;
    }
    
    self enabletargetmarks();
    thread markequipment_monitorlook();
}

// Params 0
// Size: 0x60
function unsetmarkequipment()
{
    if ( !level.teambased )
    {
        return;
    }
    
    if ( isdefined( self.markequipmentstate ) )
    {
        foreach ( var1 in self.markequipmentstate.markedents )
        {
            if ( isdefined( var1 ) )
            {
                unmarkent( var1 );
            }
        }
    }
    
    self.markequipmentstate = undefined;
    self disabletargetmarks();
    self notify( "mark_equip_ended" );
}

// Params 1
// Size: 0x22
function getchildoutlineents( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return [];
    }
    
    if ( !isdefined( var0.childoutlineents ) )
    {
        return [ var0 ];
    }
    
    return var0.childoutlineents;
}

// Params 2
// Size: 0xb
function outlinehelper_getallplayers( var0, var1 )
{
    return level.players;
}

// Params 1
// Size: 0x7, Type: bool
function outlinehelper_validplayer( var0 )
{
    return true;
}

// Params 1
// Size: 0x7b
function outlinehelper_verifydata( var0 )
{
    if ( !isdefined( var0.getplayers ) )
    {
        var0.getplayers = &outlinehelper_getallplayers;
    }
    
    if ( !isdefined( var0.validplayer ) )
    {
        var0.validplayer = &outlinehelper_validplayer;
    }
    
    if ( !isdefined( var0.hudoutlineassetname ) )
    {
        var0.hudoutlineassetname = "spotter_notarget";
    }
    
    if ( !isdefined( var0.prioritygroup ) )
    {
        var0.prioritygroup = "perk";
    }
    
    if ( !isdefined( var0.waittime ) )
    {
        var0.waittime = 0.1;
        return;
    }
}

// Params 1
// Size: 0x1e
function outlinehelper_updateentityoutline( var0 )
{
    if ( isdefined( var0 ) )
    {
        var1 = var0 getentitynumber();
        outlinehelper_disableentityoutline( var1 );
        outlinehelper_enableentityoutline( var0 );
        return;
    }
}

// Params 1
// Size: 0x20e
function outlinehelper_enableentityoutline( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    var1 = var0 getentitynumber();
    var2 = self.entityoutlines[ var1 ];
    
    if ( isdefined( var2 ) )
    {
        return;
    }
    
    var3 = undefined;
    
    if ( self entitymarkfilteredin( var0 ) )
    {
        var3 = spawnstruct();
        var3.prioritygroup = "perk_superior";
        var3.hudoutlineassetname = "spotter_target";
        outlinehelper_verifydata( var3 );
    }
    
    var4 = self entitymarkfilteredin( var0 );
    
    if ( self entityhasmark( "air_killstreak", var0 ) )
    {
        if ( !isdefined( var0.model ) )
        {
            return;
        }
        
        var3 = spawnstruct();
        
        if ( var4 )
        {
            var3.prioritygroup = "perk_superior";
            var3.hudoutlineassetname = "spotter_target_killstreak_air";
        }
        else
        {
            var3.prioritygroup = "perk";
            var3.hudoutlineassetname = "spotter_notarget_killstreak_air";
        }
        
        outlinehelper_verifydata( var3 );
    }
    else if ( self entityhasmark( "killstreak", var0 ) )
    {
        if ( !isdefined( var0.model ) )
        {
            return;
        }
        
        var3 = spawnstruct();
        
        if ( var4 )
        {
            var3.prioritygroup = "perk_superior";
            var3.hudoutlineassetname = "spotter_target_killstreak";
        }
        else
        {
            var3.prioritygroup = "perk";
            var3.hudoutlineassetname = "spotter_notarget_killstreak";
        }
        
        outlinehelper_verifydata( var3 );
    }
    else if ( self entityhasmark( "equipment", var0 ) )
    {
        var3 = spawnstruct();
        
        if ( var4 )
        {
            var3.prioritygroup = "perk_superior";
            var3.hudoutlineassetname = "spotter_target_equipment";
        }
        else
        {
            var3.prioritygroup = "perk";
            var3.hudoutlineassetname = "spotter_notarget_equipment";
        }
        
        outlinehelper_verifydata( var3 );
    }
    
    if ( isdefined( var3 ) )
    {
        var2 = spawnstruct();
        self.entityoutlines[ var1 ] = var2;
        var2.list = [];
        var2.ent = var0;
        var5 = getchildoutlineents( var0 );
        
        foreach ( var7 in var5 )
        {
            var8 = scripts\mp\utility\outline::outlineenableforplayer( var7, self, var3.hudoutlineassetname, var3.prioritygroup );
            var9 = spawnstruct();
            var9.ent = var7;
            var9.id = var8;
            var10 = var7 getentitynumber();
            var2.list[ var10 ] = var9;
        }
        
        return;
    }
}

// Params 1
// Size: 0x5b
function outlinehelper_disableentityoutline( var0 )
{
    if ( isdefined( var0 ) )
    {
        var1 = self.entityoutlines[ var0 ];
        
        if ( isdefined( var1 ) )
        {
            foreach ( var3 in var1.list )
            {
                scripts\mp\utility\outline::outlinedisable( var3.id, var3.ent );
            }
            
            self.entityoutlines[ var0 ] = undefined;
            return;
        }
        
        return;
    }
}

// Params 2
// Size: 0x4d
function ref_11b0b( var0, var1 )
{
    var2 = [];
    
    foreach ( var4 in var0 )
    {
        if ( !isdefined( var4 ) )
        {
            continue;
        }
        
        var5 = var4 getentitynumber();
        
        if ( !scripts\engine\utility::array_contains( var1, var5 ) )
        {
            var2 = var4;
        }
    }
    
    return var2;
}

// Params 0
// Size: 0x113
function markedentities_think()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self.entityoutlines = [];
    
    for ( ;; )
    {
        self waittill( "marks_changed", var0, var1, var2 );
        
        if ( isdefined( var0 ) )
        {
            foreach ( var4 in var0 )
            {
                outlinehelper_disableentityoutline( var4 );
            }
            
            if ( isdefined( self.markequipmentstate ) )
            {
                self.markequipmentstate.markedents = ref_11b0b( self.markequipmentstate.markedents, var0 );
                
                if ( self.markequipmentstate.markedentindex > self.markequipmentstate.markedents.size )
                {
                    self.markequipmentstate.markedentindex = self.markequipmentstate.markedents.size;
                }
            }
        }
        
        if ( isdefined( var1 ) )
        {
            foreach ( var7 in var1 )
            {
                outlinehelper_disableentityoutline( var7 );
            }
        }
        
        if ( isdefined( var2 ) )
        {
            foreach ( var10 in var2 )
            {
                outlinehelper_enableentityoutline( var10 );
            }
        }
    }
}

// Params 0
// Size: 0x22
function ref_1312c()
{
    self notify( "cancel_better_mission_rewards_unset" );
    self.should_drop_scavenger_bag = 1;
    ref_14022( self.team );
    thread ks_airdroppercircle();
}

// Params 0
// Size: 0x2
function ref_13f63()
{
    
}

// Params 0
// Size: 0x3a
function ks_airdroppercircle()
{
    var0 = self.team;
    var1 = self.squadindex;
    self endon( "cancel_better_mission_rewards_unset" );
    scripts\engine\utility::ref_143a5( "spawned_player", "disconnect" );
    
    if ( isdefined( self ) )
    {
        self.should_drop_scavenger_bag = undefined;
    }
    
    ref_14022( var0, var1 );
}

// Params 2
// Size: 0x5d
function ref_14022( var0, var1 )
{
    if ( scripts\mp\utility\game::getgametype() != "br" )
    {
        return;
    }
    
    var2 = scripts\mp\gametypes\br_quest_util::rewardangles( var0 );
    
    if ( !isdefined( level.clearlethalonunresolvedcollision ) )
    {
        level.clearlethalonunresolvedcollision = [];
    }
    
    var3 = 0;
    
    if ( isdefined( level.clearlethalonunresolvedcollision[ var0 ] ) )
    {
        var3 = level.clearlethalonunresolvedcollision[ var0 ];
    }
    
    var4 = var2 - var3;
    
    if ( var4 != 0 )
    {
        scripts\mp\gametypes\br_quest_util::battletracksmusicstate( var0, var4, var1 );
    }
    
    level.clearlethalonunresolvedcollision[ var0 ] = var2;
}

// Params 0
// Size: 0x23
function ref_131c2()
{
    self clearvehicleturretstickers( 1 );
    
    if ( scripts\mp\utility\game::getgametype() != "br" )
    {
        self setclientomnvar( "ui_specialist_bonus_active", 1 );
        return;
    }
}

// Params 0
// Size: 0x21
function ref_13f6e()
{
    self clearvehicleturretstickers( 0 );
    
    if ( scripts\mp\utility\game::getgametype() != "br" )
    {
        self setclientomnvar( "ui_specialist_bonus_active", 0 );
        return;
    }
}

// Params 0
// Size: 0x5e
function ref_13199()
{
    self.ref_12369 = spawnstruct();
    self.ref_12369.ref_13a72 = [];
    self.ref_12369.targetids = [];
    self.ref_12369.ref_12367 = [];
    self.ref_12369.instant_revived = 0;
    
    for ( var0 = 0; var0 < 4 ; var0++ )
    {
        self.ref_12369.ref_12367[ var0 ] = -1;
    }
}

// Params 1
// Size: 0x48
function maxmuncurrencycap( var0 )
{
    if ( !isdefined( var0 ) || !scripts\mp\utility\player::isreallyalive( var0 ) )
    {
        return;
    }
    
    if ( var0.team == self.team )
    {
        return;
    }
    
    if ( isdefined( self.ref_12369 ) )
    {
        ref_1236a( var0 );
        ref_1236b( var0 );
        var0.ref_13a70 = 1;
        return;
    }
}

// Params 1
// Size: 0x156
function ref_1236a( var0 )
{
    var1 = "hud_icon_head_marked";
    var2 = 8;
    var3 = 1;
    var4 = 0;
    var5 = 500;
    
    if ( isdefined( var0.ref_13a70 ) )
    {
        return;
    }
    
    var6 = self.ref_12369.ref_13a72[ var0 getentitynumber() ];
    
    if ( !isdefined( var6 ) )
    {
        self.ref_12369.ref_13a72[ var0 getentitynumber() ] = var0;
        var6 = var0;
        var7 = self.ref_12369.instant_revived;
        self.ref_12369.instant_revived = ( self.ref_12369.instant_revived + 1 ) % 4;
        
        if ( isdefined( self.ref_12369.ref_13a72[ self.ref_12369.ref_12367[ var7 ] ] ) )
        {
            var8 = self.ref_12369.ref_13a72[ self.ref_12369.ref_12367[ var7 ] ];
            self.ref_12369.ref_12367[ var7 ] = -1;
            thread ref_1236d( var8, var8 );
            thread ref_12372( var8 );
        }
        
        self.ref_12369.ref_12367[ var7 ] = var0 getentitynumber();
        var9 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic( self.team, self.squadindex );
        var6.headicon = var0 scripts\cp_mp\entityheadicons::setheadicon_singleimage( var9, var1, var2, var3, var4, var5, undefined, 1, 1 );
        self playlocalsound( "br_perk_advanced_scout_marking", self );
        scripts\mp\gametypes\br_public::ref_1276a( "br_perk_advanced_scout_marking", self.team, var0 );
        thread ref_1236f( var0, var0 );
        thread ref_12373( var0 );
        return;
    }
}

// Params 1
// Size: 0x42
function ref_1236b( var0 )
{
    var1 = scripts\mp\utility\outline::outlineenableforplayer( var0, self, "outlinefill_nodepth_orange", "perk" );
    var0 scripts\mp\utility\outline::_hudoutlineviewmodelenable( "snapshotgrenade", 0 );
    
    if ( !isdefined( var0.ref_13a70 ) )
    {
        var0 playlocalsound( "br_perk_advanced_scout_marked_plr" );
    }
    
    thread ref_12371( var0, var1 );
}

// Params 2
// Size: 0x3a
function ref_1236f( var0, var1 )
{
    level endon( "game_ended" );
    var0 endon( "disconnect" );
    var2 = var0 getentitynumber();
    var0 endon( "removeHeadIcon_" + var2 );
    var0 scripts\engine\utility::waittill_notify_or_timeout( "death", 3 );
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon( var1 );
}

// Params 1
// Size: 0xb6
function ref_12373( var0 )
{
    self endon( "disconnect" );
    self endon( "pingOnDamageDeactivate" );
    var1 = var0 getentitynumber();
    self endon( "removeEntNum_" + var1 );
    var0 scripts\engine\utility::waittill_notify_or_timeout( "death", 3 );
    
    if ( isdefined( self.ref_12369 ) && isdefined( self.ref_12369.ref_13a72 ) )
    {
        var2 = self.ref_12369.ref_13a72[ var1 ];
        
        if ( isdefined( var2 ) )
        {
            var0.ref_13a70 = undefined;
            self.ref_12369.ref_13a72[ var1 ] = undefined;
        }
    }
    
    foreach ( var4 in self.ref_12369.ref_12367 )
    {
        if ( var4 == var1 )
        {
            self.ref_12369.ref_12367[ var5 ] = -1;
            return;
        }
    }
}

// Params 2
// Size: 0x2a
function ref_1236d( var0, var1 )
{
    level endon( "game_ended" );
    var0 endon( "disconnect" );
    var2 = var0 getentitynumber();
    var0 notify( "removeHeadIcon_" + var2 );
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon( var1 );
}

// Params 1
// Size: 0x65
function ref_12372( var0 )
{
    self endon( "disconnect" );
    self endon( "pingOnDamageDeactivate" );
    var1 = var0 getentitynumber();
    self notify( "removeEntNum_" + var1 );
    
    if ( isdefined( self.ref_12369 ) && isdefined( self.ref_12369.ref_13a72 ) )
    {
        var2 = self.ref_12369.ref_13a72[ var1 ];
        
        if ( isdefined( var2 ) )
        {
            var0.ref_13a70 = undefined;
            self.ref_12369.ref_13a72[ var1 ] = undefined;
            return;
        }
        
        return;
    }
}

// Params 2
// Size: 0x33
function ref_12371( var0, var1 )
{
    level endon( "game_ended" );
    var1 endon( "disconnect" );
    var1 scripts\engine\utility::waittill_notify_or_timeout( "death", 0.6 );
    scripts\mp\utility\outline::outlinedisable( var0, var1 );
    var1 scripts\mp\utility\outline::_hudoutlineviewmodeldisable();
}

// Params 0
// Size: 0x42
function ref_12374()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    
    if ( isdefined( self.ref_11b14 ) )
    {
        return;
    }
    
    self.ref_11b14 = 1;
    self iprintlnbold( &"KILLSTREAKS_HINTS/RECON_NO_MARK" );
    self playlocalsound( "br_perk_advanced_scout_marking_resist_plr", self );
    wait 1;
    self.ref_11b14 = undefined;
}

// Params 0
// Size: 0x69
function ref_13f69()
{
    if ( isdefined( self.ref_12369.ref_13a72 ) && self.ref_12369.ref_13a72.size > 0 )
    {
        foreach ( var1 in self.ref_12369.ref_13a72 )
        {
            if ( isdefined( var1 ) )
            {
                thread ref_12372( var1 );
            }
        }
    }
    
    self.ref_12369 = undefined;
    self notify( "pingOnDamageDeactivate" );
}

// Params 1
// Size: 0xab
function ref_121b7( var0 )
{
    var1 = scripts\mp\gametypes\br_public::round_at_max( self.team, self.squadindex, "ui_squad_reinforced_perk" );
    
    if ( !isdefined( var1 ) )
    {
        var1 = 0;
    }
    
    var2 = scripts\engine\utility::ter_op( isdefined( self.pers[ "squadMemberIndex" ] ), self.pers[ "squadMemberIndex" ] - 1, 0 );
    var3 = 1 << var2;
    var4 = scripts\engine\utility::ter_op( istrue( var0 ), var1 | var3, var1 ^ var3 );
    scripts\mp\gametypes\br_public::ref_131c3( self.team, self.squadindex, "ui_squad_reinforced_perk", var4 );
    var5 = scripts\mp\gametypes\br_public::round_enemy_stuck_logic( self.team, self.squadindex );
    
    foreach ( var7 in var5 )
    {
        var7 setclientomnvar( "ui_squad_reinforced_perk", var4 );
    }
}

// Params 0
// Size: 0x36
function ref_13928()
{
    self endon( "disconnect" );
    self endon( "death" );
    level endon( "game_ended" );
    
    if ( !self isonground() )
    {
        self waittill( "victim_was_damaged" );
        
        if ( istrue( self.instantclassswapallowed ) )
        {
            scripts\mp\class::disableclassswapallowed();
            return;
        }
        
        return;
    }
}

// Params 0
// Size: 0x26
function ref_131c5()
{
    if ( scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "armor" ) )
    {
        return;
    }
    
    thread ref_13928();
    scripts\mp\gametypes\br_armor::searchcirclesize( 1 );
    ref_121b7( 1 );
}

// Params 0
// Size: 0x27
function ref_13f6f()
{
    if ( scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "armor" ) )
    {
        return;
    }
    
    if ( istrue( self.instantclassswapallowed ) )
    {
        scripts\mp\gametypes\br_armor::searchcirclesize( 0 );
    }
    
    ref_121b7( 0 );
}

// Params 0
// Size: 0x38
function ref_13716()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    
    if ( isdefined( self.ref_11b14 ) )
    {
        return;
    }
    
    self.ref_11b14 = 1;
    self playlocalsound( "br_perk_advanced_scout_marking_resist_plr", self );
    wait 1;
    self.ref_11b14 = undefined;
}

