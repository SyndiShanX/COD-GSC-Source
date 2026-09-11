
// Params 0
// Size: 0x241
function init()
{
    var0 = scripts\mp\utility\game::getgametype();
    
    if ( !isdefined( var0 ) )
    {
        var0 = getdvar( "NKTMKRMSKR" );
    }
    
    for ( var1 = 0;  ; var1++ )
    {
        var2 = tablelookupbyrow( "mp/score_event_table.csv", var1, 0 );
        
        if ( !isdefined( var2 ) || var2 == "" )
        {
            break;
        }
        
        var3 = tablelookupbyrow( "mp/score_event_table.csv", var1, level.getallselectableattachments.game_type_col[ var0 ] );
        
        if ( !isdefined( var3 ) || var3 == "" )
        {
            var1++;
            continue;
        }
        
        if ( var2 == "win" || var2 == "loss" || var2 == "tie" )
        {
            var3 = float( var3 );
        }
        else
        {
            var3 = int( var3 );
        }
        
        if ( var3 != -1 )
        {
            scripts\mp\rank::registerscoreinfo( var2, "value", var3 );
        }
        
        var4 = tablelookuprownum( "mp/splashTable.csv", 0, var2 );
        scripts\mp\rank::registerscoreinfo( var2, "eventID", var4 );
        var4 = tablelookup( "mp/splashTable.csv", 0, var2, 2 );
        scripts\mp\rank::registerscoreinfo( var2, "text", var4 );
        var4 = int( tablelookup( "mp/splashTable.csv", 0, var2, 13 ) );
        scripts\mp\rank::registerscoreinfo( var2, "priority", var4 );
        var4 = int( tablelookup( "mp/splashTable.csv", 0, var2, 14 ) );
        scripts\mp\rank::registerscoreinfo( var2, "alwaysShowSplash", var4 );
        var5 = tablelookuprownum( "mp/splashTable.csv", 0, var2 );
        
        if ( isdefined( var5 ) && var5 != -1 )
        {
            scripts\mp\rank::registerscoreinfo( var2, "splashID", var5 );
        }
        
        var6 = tablelookupbyrow( "mp/score_event_table.csv", var1, 4 );
        scripts\mp\rank::registerscoreinfo( var2, "group", var6 );
        var7 = tablelookupbyrow( "mp/score_event_table.csv", var1, 3 );
        
        if ( isdefined( var7 ) && tolower( var7 ) == "true" )
        {
            scripts\mp\rank::registerscoreinfo( var2, "allowBonus", 1 );
        }
    }
    
    if ( scripts\mp\gametypes\br_public::shouldusegoldbarassets() )
    {
        level._effect[ "money" ] = loadfx( "vfx/iw8_br/gameplay/vfx_br_gold_backpack_death.vfx" );
    }
    else
    {
        level._effect[ "money" ] = loadfx( "vfx/props/cash_player_drop" );
    }
    
    level.numkills = 0;
    level.prevlastkilltime = 0;
    level.lastkilltime = 0;
    level.carnage_enemydummycleanup = 2097152;
    thread onplayerconnect();
    thread monitorhealed();
    
    if ( !scripts\mp\utility\game::runleanthreadmode() )
    {
        scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback( &onplayerspawn );
        scripts\mp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback( &updatestancetracking );
        scripts\mp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback( &events_monitorslideupdate );
    }
    
    scripts\mp\utility\player_frame_update_aggregator::registerplayerframeupdatecallback( &monitoradstime );
    
    if ( scripts\mp\utility\game::getgametype() != "br" )
    {
        thermite_laststand_effects();
        return;
    }
}

// Params 0
// Size: 0xe
function onplayerspawn()
{
    self.jumpcur = 0;
    self.mantlecur = 0;
}

// Params 0
// Size: 0xf4
function onplayerconnect()
{
    for ( ;; )
    {
        level waittill( "connected", var0 );
        
        if ( !scripts\mp\utility\game::lpcfeaturegated() )
        {
            var0.killedplayers = [];
            var0.killedby = [];
        }
        
        var0.lastkilledby = undefined;
        var0.greatestuniqueplayerkills = 0;
        var0.recentkillcount = 0;
        var0.recentdefendcount = 0;
        var0.ref_12a82 = 0;
        var0.lastkilltime = 0;
        var0.prevlastkilltime = 0;
        var0.lastkilldogtime = 0;
        
        if ( !isdefined( var0.pers[ "lethalEquipmentKillMask" ] ) )
        {
            var0.pers[ "lethalEquipmentKillMask" ] = 0;
        }
        
        if ( scripts\mp\utility\game::getgametype() != "br" )
        {
            if ( !isdefined( var0.pers[ "headshotLongshotMask" ] ) )
            {
                var0.pers[ "headshotLongshotMask" ] = 0;
            }
        }
        
        var0.ref_11f87 = 0;
        var0.damagedplayers = [];
        initslidemonitor( var0 );
        initmonitoradstime( var0 );
        thread monitorreload();
        var0.lastweaponchangetime = 0;
        initstancetracking( var0 );
    }
}

// Params 2
// Size: 0x3b
function damagedplayer( var0, var1 )
{
    if ( var1 < 50 && var1 > 10 )
    {
        level thread scripts\mp\battlechatter_mp::saytoself( self, "plr_damaged_light", undefined, 0.1 );
        return;
    }
    
    level thread scripts\mp\battlechatter_mp::saytoself( self, "plr_damaged_heavy", undefined, 0.1 );
}

// Params 2
// Size: 0xd
function playerworlddeath( var0, var1 )
{
    scripts\mp\potg_events::playerworlddeath( var0, var1 );
}

// Params 4
// Size: 0xf0
function killedplayernotifysys( var0, var1, var2, var3 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self notify( "killedPlayerNotify" );
    self endon( "killedPlayerNotify" );
    
    if ( !isdefined( self.killsinaframecount ) )
    {
        self.killsinaframecount = 0;
    }
    
    self.killsinaframecount++;
    
    if ( weaponclass( var2 ) == "spread" )
    {
        if ( !isdefined( self.shotgunkillsinaframecount ) )
        {
            self.shotgunkillsinaframecount = 1;
        }
        else
        {
            self.shotgunkillsinaframecount++;
            
            if ( self.shotgunkillsinaframecount >= 2 )
            {
                shotguncollateral( self.shotgunkillsinaframecount );
            }
        }
    }
    else if ( var3 == "MOD_PISTOL_BULLET" || var3 == "MOD_RIFLE_BULLET" || var3 == "MOD_HEAD_SHOT" )
    {
        if ( !isdefined( self.bulletkillsinaframecount ) )
        {
            self.bulletkillsinaframecount = 1;
        }
        else
        {
            self.bulletkillsinaframecount++;
            
            if ( self.bulletkillsinaframecount >= 2 )
            {
                collateral( self.bulletkillsinaframecount );
            }
        }
    }
    
    waittillframeend();
    thread notifykilledplayer( var0, var1, var2, var3, self.killsinaframecount );
    self.killsinaframecount = 0;
    self.bulletkillsinaframecount = 0;
    self.shotgunkillsinaframecount = 0;
}

// Params 5
// Size: 0x29
function notifykilledplayer( var0, var1, var2, var3, var4 )
{
    var5 = createheadicon( var2 );
    
    for ( var6 = 0; var6 < var4 ; var6++ )
    {
        self notify( "got_a_kill", var1, var5, var3 );
        waitframe();
    }
}

// Params 4
// Size: 0x40
function celebration_end( var0, var1, var2, var3 )
{
    var4 = 1;
    
    if ( isdefined( var1 ) )
    {
        if ( isdefined( var1.owner ) )
        {
            var4 = var1.owner == var0;
        }
        else if ( cellspawns( var2, var1, var3 ) )
        {
        }
        else
        {
            var4 = var1 == var0;
        }
    }
    
    return var4;
}

// Params 3
// Size: 0x52
function cellspawns( var0, var1, var2 )
{
    var3 = 0;
    
    if ( isdefined( var0 ) && isdefined( var1.classname ) && var1.classname == "worldspawn" && var2 == "MOD_EXPLOSIVE" )
    {
        var4 = scripts\mp\utility\weapon::getweaponrootname( var0 );
        var3 = var4 == "iw8_sn_xmike109" || var4 == "iw8_sn_crossbow";
    }
    
    return var3;
}

// Params 6
// Size: 0x1a08
function cargo_truck_mg_initoccupancy( var0, var1, var2, var3, var4, var5 )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    self.modifiers = [];
    self.modifiers[ "mask" ] = 0;
    self.modifiers[ "mask2" ] = 0;
    self.modifiers[ "mask3" ] = 0;
    var6 = gettime();
    var7 = scripts\mp\utility\weapon::getweapongroup( var2.basename );
    var8 = createheadicon( var2 );
    var9 = var1.guid;
    var10 = scripts\cp\vehicles\vehicle_compass_cp::resetstuckthermite();
    var11 = var1 scripts\cp\vehicles\vehicle_compass_cp::resetstuckthermite();
    
    if ( !scripts\mp\utility\weapon::iskillstreakweapon( var2.basename ) && !scripts\mp\utility\perk::_hasperk( "specialty_explosivebullets" ) )
    {
        var12 = celebration_end( self, var4, var2, var3 );
        
        if ( isdefined( var1.attackerposition ) )
        {
            var13 = var1.attackerposition;
        }
        else
        {
            var13 = self.origin;
        }
        
        var14 = anglestoforward( self getplayerangles() );
        var15 = var2.origin - var13;
        var16 = vectornormalize( var15 );
        var17 = vectordot( var14, var16 );
        var18 = scripts\engine\utility::isbulletdamage( var4 );
        var19 = scripts\mp\supers::getcurrentsuper();
        
        if ( isdefined( var19 ) && scripts\mp\supers::issuperinuse() )
        {
            self.modifiers[ "active_field_upgrade" ] = var19.staticdata.ref;
        }
        
        if ( var4 == "MOD_EXECUTION" )
        {
            self.modifiers[ "execution" ] = 1;
            self.modifiers[ "mask2" ] = self.modifiers[ "mask2" ] | 256;
        }
        
        if ( level.prevlastkilltime == 0 && self.prevlastkilltime == 0 )
        {
            self.modifiers[ "firstblood" ] = 1;
            self.modifiers[ "mask" ] = self.modifiers[ "mask" ] | 33554432;
        }
        
        if ( var3.basename == "none" && var4 != "MOD_EXECUTION" )
        {
            return;
        }
        
        if ( isdefined( var2.attackers ) && var2.attackers.size == 1 && !isdefined( var2.attackers[ var2.guid ] ) )
        {
            if ( var8 != "other" && var8 != "weapon_projectile" && var4 != "MOD_MELEE" && isdefined( var2.attackerdata ) && isdefined( var2.attackerdata[ self.guid ].firsttimedamaged ) && var7 == var2.attackerdata[ self.guid ].firsttimedamaged )
            {
                self.modifiers[ "oneshotkill" ] = 1;
                self.modifiers[ "mask" ] = self.modifiers[ "mask" ] | 1;
                
                if ( !isdefined( self.pers[ "oneshotkills" ] ) )
                {
                    self.pers[ "oneshotkills" ] = 1;
                }
                else
                {
                    self.pers[ "oneshotkills" ]++;
                }
                
                if ( self.pers[ "oneshotkills" ] == 6 )
                {
                    self.modifiers[ "mask3" ] = self.modifiers[ "mask3" ] | 8;
                }
            }
        }
        
        if ( isdefined( self.lastinsmoketime ) && self.lastinsmoketime + 5000 > gettime() || isdefined( var2.lastinsmoketime ) && var2.lastinsmoketime + 5000 > gettime() )
        {
            self.modifiers[ "insmoke" ] = 1;
            self.modifiers[ "mask2" ] = self.modifiers[ "mask2" ] | 512;
        }
        
        if ( scripts\mp\utility\game::runleanthreadmode() )
        {
            if ( isdefined( var2.radarstrength ) && var2.radarstrength > 3 )
            {
                self.modifiers[ "enemyHasUAV" ] = 1;
                self.modifiers[ "mask2" ] = self.modifiers[ "mask2" ] | 1;
            }
        }
        else if ( scripts\cp_mp\utility\killstreak_utility::teamhasuav( var2.team ) )
        {
            self.modifiers[ "enemyHasUAV" ] = 1;
            self.modifiers[ "mask2" ] = self.modifiers[ "mask2" ] | 1;
        }
        
        if ( isdefined( var2.ref_13935 ) && var2.ref_13935 == self )
        {
            self.modifiers[ "grenadestuck" ] = 1;
            self.modifiers[ "mask2" ] = self.modifiers[ "mask2" ] | 8;
        }
        
        if ( scripts\mp\utility\game::turret_outline_watcher( var2 ) )
        {
            self.modifiers[ "assault" ] = 1;
            self.modifiers[ "mask" ] = self.modifiers[ "mask" ] | 1073741824;
            start_puzzle();
        }
        
        if ( scripts\mp\utility\game::isdefending( var2 ) )
        {
            self.modifiers[ "defender" ] = 1;
            self.modifiers[ "mask" ] = self.modifiers[ "mask" ] | 4194304;
            start_puzzle();
        }
        
        if ( var4 == "MOD_MELEE" )
        {
            if ( var8 != "weapon_melee" && var8 != "weapon_melee2" )
            {
                self.modifiers[ "gunbutt" ] = 1;
                self.modifiers[ "mask2" ] = self.modifiers[ "mask2" ] | 128;
            }
        }
        
        if ( ( var8 == "weapon_melee" || var8 == "weapon_melee2" ) && !issubstr( var8, "fists" ) )
        {
            self.modifiers[ "melee" ] = 1;
            self.modifiers[ "mask2" ] = self.modifiers[ "mask2" ] | 1073741824;
        }
        
        var24 = var2 getheldoffhand();
        
        if ( var24.basename == "frag_grenade_mp" || var24.basename == "cluster_grenade_mp" )
        {
            self.modifiers[ "cooking" ] = 1;
            self.modifiers[ "mask" ] = self.modifiers[ "mask" ] | 2;
        }
        
        if ( isdefined( self.assistedsuicide ) && self.assistedsuicide )
        {
            self.modifiers[ "assistedsuicide" ] = 1;
        }
        
        if ( self.pers[ "cur_death_streak" ] > 3 )
        {
            self.modifiers[ "comeback" ] = 1;
            self.modifiers[ "mask" ] = self.modifiers[ "mask" ] | 134217728;
        }
        
        if ( var4 == "MOD_HEAD_SHOT" || vehicle_collision_handlemultievent( var3, var6 ) || turn_on_laser_vfx( var3, var6 ) )
        {
            self.modifiers[ "headshot" ] = 1;
            self.modifiers[ "mask" ] = self.modifiers[ "mask" ] | 1048576;
            
            if ( self.pers[ "headshots" ] == 7 )
            {
                self.modifiers[ "mask3" ] = self.modifiers[ "mask3" ] | 16;
            }
        }
        
        if ( isdefined( self.wasti ) && self.wasti && var7 - self.spawntime <= 5000 )
        {
            self.modifiers[ "jackintheboxkill" ] = 1;
        }
        
        if ( !scripts\mp\utility\player::isreallyalive( self ) && isdefined( self.deathtime ) )
        {
            var25 = gettime() - self.deathtime;
            
            if ( var25 < 1500 && var25 > 0 )
            {
                self.modifiers[ "posthumous" ] = 1;
                self.modifiers[ "mask" ] = self.modifiers[ "mask" ] | 8388608;
            }
        }
        
        if ( level.teambased && isdefined( var2.lastkilltime ) && var7 - var2.lastkilltime < 1500 )
        {
            if ( var2.lastkilledplayer != self )
            {
                self.modifiers[ "avenger" ] = 1;
                self.modifiers[ "mask" ] = self.modifiers[ "mask" ] | 2097152;
            }
        }
        
        if ( isbackkill( self, var2, var4 ) )
        {
            self.modifiers[ "backstab" ] = 1;
            self.modifiers[ "mask" ] = self.modifiers[ "mask" ] | 4;
        }
        
        var26 = isdefined( var5 ) && istrue( var5.isequipment ) && isdefined( var5.equipmentref ) && var5.equipmentref == "equip_throwing_knife";
        var27 = isdefined( var5 ) && isdefined( var5.weapon_object ) && scripts\mp\utility\weapon::validatefuelstability( var5.weapon_object, var5 );
        
        if ( var13 || var26 || var27 )
        {
            var28 = getshotdistancetype( self, var3, var4, var13, var2 );
            
            switch ( var28 )
            {
                case "pointblank":
                    self.modifiers[ "pointblank" ] = 1;
                    self.modifiers[ "mask" ] = self.modifiers[ "mask" ] | 524288;
                    break;
                case "longshot":
                    self.modifiers[ "longshot" ] = 1;
                    self.modifiers[ "mask" ] = self.modifiers[ "mask" ] | 262144;
                    var29 = scripts\engine\math::round_float( distance( var13, var2.origin ) / 39.37, 2 );
                    self setclientomnvar( "ui_longshot_dist", var29 );
                    self setclientomnvar( "ui_longshot_special", update_future_stations_track_timers( var13, var2, var3 ) );
                    break;
                case "very_longshot":
                    self.modifiers[ "longshot" ] = 1;
                    self.modifiers[ "mask" ] = self.modifiers[ "mask" ] | 262144;
                    self.modifiers[ "very_longshot" ] = 1;
                    var29 = scripts\engine\math::round_float( distance( var13, var2.origin ) / 39.37, 2 );
                    self setclientomnvar( "ui_longshot_dist", var29 );
                    self setclientomnvar( "ui_longshot_special", update_future_stations_track_timers( var13, var2, var3 ) );
                    break;
            }
            
            if ( self method_87ba() )
            {
                self.modifiers[ "holdingbreath" ] = 1;
                self.modifiers[ "mask" ] = self.modifiers[ "mask" ] | 268435456;
            }
            
            if ( scripts\mp\class::vehicle_checkpiggybackexploit( var3 ) )
            {
                self.modifiers[ "silencedkill" ] = 1;
                self.modifiers[ "mask2" ] = self.modifiers[ "mask2" ] | 131072;
            }
            
            if ( var2 scripts\mp\weapons::isstunnedorblinded() )
            {
                self.modifiers[ "victimimpairedkill" ] = 1;
                self.modifiers[ "mask2" ] = self.modifiers[ "mask2" ] | 1048576;
                self.modifiers[ "detectedimpairedkill" ] = 1;
                self.modifiers[ "mask2" ] = self.modifiers[ "mask2" ] | 524288;
            }
            
            if ( underbridge_reinforce_enemy_monitor( self, var2 ) )
            {
                self.modifiers[ "detectedimpairedkill" ] = 1;
                self.modifiers[ "detectedkill" ] = 1;
                self.modifiers[ "mask2" ] = self.modifiers[ "mask2" ] | 524288;
            }
            
            if ( isdefined( var2.lastsnapshotgrenadetime ) && var2.lastsnapshotgrenadetime + scripts\mp\equipment\snapshot_grenade::removespawnselections() > gettime() )
            {
                self.modifiers[ "mask2" ] = self.modifiers[ "mask2" ] | 67108864;
            }
            
            if ( isdefined( self.radarstrength ) && self.radarstrength > 3 && !var2 scripts\mp\utility\perk::_hasperk( "specialty_br_ghost" ) )
            {
                self.modifiers[ "uavkill" ] = 1;
                self.modifiers[ "mask2" ] = self.modifiers[ "mask2" ] | 4194304;
            }
            
            if ( isdefined( var6.damageflags ) && var6.damageflags & level.idflags_penetration && !( var6.damageflags & level.ss_respawn ) )
            {
                self.modifiers[ "coverkill" ] = 1;
                self.modifiers[ "mask2" ] = self.modifiers[ "mask2" ] | 262144;
            }
            
            if ( scripts\mp\equipment\gas_grenade::plunder_playerspawnedcallback( self, var2 ) )
            {
                self.modifiers[ "gasimpairedkill" ] = 1;
                self.modifiers[ "mask2" ] = self.modifiers[ "mask2" ] | 16777216;
            }
            
            if ( scripts\mp\gametypes\br_public::updatelootleadersonfixedinterval( var2 ) )
            {
                self.modifiers[ "mostwantedkill" ] = 1;
                self.modifiers[ "mask2" ] = self.modifiers[ "mask2" ] | 33554432;
            }
            
            if ( scripts\mp\weapons::grenadeheldatdeath() )
            {
                self.modifiers[ "clutchkill" ] = 1;
            }
            
            if ( issurvivorkill( self ) )
            {
                self.modifiers[ "low_health_kill" ] = 1;
                self.modifiers[ "mask" ] = self.modifiers[ "mask" ] | 4096;
            }
            
            if ( !self isonground() )
            {
                self.modifiers[ "airborne" ] = 1;
            }
            
            if ( !var2 isonground() )
            {
                self.modifiers[ "victim_airborne" ] = 1;
            }
            
            if ( self playermount() >= 0.5 )
            {
                self.modifiers[ "mounted" ] = 1;
                self.modifiers[ "mask" ] = self.modifiers[ "mask" ] | 32;
            }
            
            if ( istrue( self.ref_138ac ) )
            {
                self.modifiers[ "mask3" ] = self.modifiers[ "mask3" ] | 4;
            }
            
            if ( var18 )
            {
                self.modifiers[ "bullet_damage" ] = 1;
                var30 = self getweaponammoclip( var3 );
                
                if ( var30 <= 0 )
                {
                    self.modifiers[ "last_bullet_kill" ] = 1;
                    self.modifiers[ "mask" ] = self.modifiers[ "mask" ] | 64;
                }
            }
            
            if ( scripts\mp\utility\weapon::iscacprimaryorsecondary( var3 ) && var4 != "MOD_MELEE" )
            {
                if ( scripts\mp\utility\player::isplayerads() )
                {
                    self.modifiers[ "ads" ] = 1;
                    self.modifiers[ "mask" ] = self.modifiers[ "mask" ] | 8;
                }
                else
                {
                    self.modifiers[ "hipfire" ] = 1;
                    self.modifiers[ "mask" ] = self.modifiers[ "mask" ] | 16;
                }
            }
            
            if ( var2 issprinting() )
            {
                self.modifiers[ "victim_sprinting" ] = 1;
                self.modifiers[ "mask" ] = self.modifiers[ "mask" ] | 128;
            }
            
            if ( level.teambased )
            {
                foreach ( var32 in level.players )
                {
                    if ( self.team != var32.team || self == var32 )
                    {
                        continue;
                    }
                    
                    if ( !scripts\mp\utility\player::isreallyalive( var32 ) )
                    {
                        continue;
                    }
                    
                    if ( distancesquared( self.origin, var32.origin ) < 90000 )
                    {
                        self.modifiers[ "buddy_kill" ] = 1;
                        break;
                    }
                }
            }
            
            if ( scripts\mp\weapons::isstunnedorblinded() )
            {
                self.modifiers[ "impaired" ] = 1;
                self.modifiers[ "mask2" ] = self.modifiers[ "mask2" ] | 64;
            }
            
            if ( var2 scripts\mp\weapons::isstunned() )
            {
                self.modifiers[ "victimstunnedkill" ] = 1;
                self.modifiers[ "mask3" ] = self.modifiers[ "mask3" ] | 1;
            }
            
            if ( var2 scripts\mp\weapons::isblinded() )
            {
                self.modifiers[ "victimblindedkill" ] = 1;
                self.modifiers[ "mask2" ] = self.modifiers[ "mask2" ] | 8388608;
            }
            
            if ( isdefined( self.tookweaponfrom[ var9 ] ) && self.tookweaponfrom[ var9 ] == var2 )
            {
                self.modifiers[ "backfire" ] = 1;
                self.modifiers[ "mask" ] = self.modifiers[ "mask" ] | 32768;
            }
        }
        else if ( var8 == "weapon_projectile" )
        {
            if ( isdefined( var5 ) && isdefined( var5.adsfire ) )
            {
                if ( var5.adsfire )
                {
                    self.modifiers[ "ads" ] = 1;
                    self.modifiers[ "mask" ] = self.modifiers[ "mask" ] | 8;
                }
                else
                {
                    self.modifiers[ "hipfire" ] = 1;
                    self.modifiers[ "mask" ] = self.modifiers[ "mask" ] | 16;
                }
            }
        }
        
        if ( !var2 isonground() && !var2 iswallrunning() && !self isonground() && !self iswallrunning() )
        {
            if ( var13 )
            {
                self.modifiers[ "air_to_air_kill" ] = 1;
            }
        }
        else
        {
            if ( var13 )
            {
                if ( self iswallrunning() )
                {
                    self.modifiers[ "wallkill" ] = 1;
                }
                else if ( isdeathfromabove( self, var3, var4, var13, var2 ) )
                {
                    self.modifiers[ "jumpkill" ] = 1;
                }
                else if ( events_issliding() )
                {
                    self.modifiers[ "slidekill" ] = 1;
                    self.modifiers[ "sliding" ] = 1;
                    self.modifiers[ "mask" ] = self.modifiers[ "mask" ] | 256;
                }
                
                var34 = self getstance();
                
                switch ( var34 )
                {
                    case "prone":
                        self.modifiers[ "prone_kill" ] = 1;
                        self.modifiers[ "mask" ] = self.modifiers[ "mask" ] | 512;
                        break;
                    case "crouch":
                        self.modifiers[ "crouch_kill" ] = 1;
                        self.modifiers[ "mask" ] = self.modifiers[ "mask" ] | 1024;
                        break;
                }
            }
            
            if ( var2 iswallrunning() )
            {
                self.modifiers[ "killonwall" ] = 1;
            }
            else if ( isskeetshooter( self, var3, var4, var13, var2 ) )
            {
                self.modifiers[ "killinair" ] = 1;
            }
        }
        
        if ( isdefined( var2.streakdata ) )
        {
            foreach ( var36 in var2.streakdata.streaks )
            {
                var37 = var36.currentcost - var2.streakpoints;
                
                if ( var37 > 0 && var37 <= 1 )
                {
                    self.modifiers[ "buzzkill" ] = var2.pers[ "cur_kill_streak" ];
                    self.modifiers[ "mask" ] = self.modifiers[ "mask" ] | 67108864;
                    break;
                }
            }
        }
        
        if ( !scripts\mp\utility\game::runleanthreadmode() )
        {
            if ( level.teambased )
            {
                var39 = 0;
                var40 = scripts\mp\utility\teams::getenemyplayers( self.team );
                
                foreach ( var42 in var40 )
                {
                    if ( var42.score > 0 )
                    {
                        var39 = 1;
                        break;
                    }
                }
                
                if ( var39 )
                {
                    if ( is_enemy_highest_score( var2, var40 ) )
                    {
                        self.modifiers[ "kingslayer" ] = 1;
                        self.modifiers[ "mask2" ] = self.modifiers[ "mask2" ] | 4;
                    }
                }
            }
            else
            {
                var39 = 0;
                
                foreach ( var42 in level.players )
                {
                    if ( var42.score > 0 )
                    {
                        var39 = 1;
                        break;
                    }
                }
                
                if ( var39 )
                {
                    if ( is_enemy_highest_score( var4, level.players ) )
                    {
                        self.modifiers[ "kingslayer" ] = 1;
                        self.modifiers[ "mask2" ] = self.modifiers[ "mask2" ] | 4;
                    }
                }
            }
        }
        
        if ( isdefined( var7 ) && istrue( var7.isequipment ) && var6 == "MOD_IMPACT" && !scripts\mp\utility\weapon::isthrowingknife( var5.basename ) )
        {
            self.modifiers[ "item_impact" ] = 1;
            self.modifiers[ "mask3" ] = self.modifiers[ "mask3" ] | 32;
        }
        
        if ( scripts\mp\utility\damage::islauncherdirectimpactdamage( var5, var6 ) )
        {
            self.modifiers[ "launcher_impact" ] = 1;
        }
        
        if ( var19 >= 0.6428 )
        {
            self.modifiers[ "victim_in_standard_view" ] = 1;
        }
        
        if ( isdefined( self.lastadsstarttime ) && var9 - self.lastadsstarttime <= 500 && ( var10 == "weapon_sniper" || var10 == "weapon_dmr" ) )
        {
            self.modifiers[ "quickscope" ] = 1;
            self.modifiers[ "mask" ] = self.modifiers[ "mask" ] | 2048;
        }
        
        if ( isdefined( self.lastweaponchangetime ) && var9 - self.lastweaponchangetime <= 2500 )
        {
            self.modifiers[ "weapon_change_kill" ] = 1;
            self.modifiers[ "mask" ] = self.modifiers[ "mask" ] | 8192;
        }
        
        if ( isdefined( self.tookweaponfrom[ var11 ] ) && self.tookweaponfrom[ var11 ].team != self.team || scripts\mp\utility\weapon::ispickedupweapon( var5 ) )
        {
            self.modifiers[ "weapon_pickup_kill" ] = 1;
            self.modifiers[ "mask" ] = self.modifiers[ "mask" ] | 16384;
        }
        
        if ( isdefined( self.lastreloadtime ) && var9 - self.lastreloadtime <= 5000 )
        {
            self.modifiers[ "reload_kill" ] = 1;
            self.modifiers[ "mask" ] = self.modifiers[ "mask" ] | 65536;
        }
        
        var46 = self getvelocity();
        var47 = var46[ 0 ] >= 0.1 || var46[ 0 ] <= -0.1;
        var48 = var46[ 1 ] >= 0.1 || var46[ 1 ] <= -0.1;
        var49 = var46[ 2 ] >= 0.1 || var46[ 2 ] <= -0.1;
        
        if ( var47 || var48 || var49 )
        {
            self.modifiers[ "moving_kill" ] = 1;
            self.modifiers[ "mask3" ] = self.modifiers[ "mask3" ] | 2;
        }
        
        if ( istrue( var4.isdefusing ) )
        {
            self.modifiers[ "killed_defuser" ] = 1;
        }
        
        if ( scripts\mp\utility\weapon::iscacsecondaryweapon( var5 ) || scripts\mp\utility\perk::_hasperk( "specialty_munitions_2" ) && isdefined( self.secondaryweaponobj ) && var5 == self.secondaryweaponobj )
        {
            self.modifiers[ "secondary_weapon" ] = 1;
            self.modifiers[ "mask" ] = self.modifiers[ "mask" ] | 131072;
        }
        
        if ( scripts\mp\utility\player::unset_relic_trex( self ) )
        {
            self.modifiers[ "last_stand" ] = 1;
            self.modifiers[ "mask2" ] = self.modifiers[ "mask2" ] | 1024;
        }
        
        if ( scripts\mp\utility\player::unset_relic_trex( var4 ) || istrue( var8.enemy_monitor_trialending ) )
        {
            self.modifiers[ "victim_last_stand" ] = 1;
            self.modifiers[ "mask2" ] = self.modifiers[ "mask2" ] | 2048;
        }
        
        if ( scripts\cp_mp\utility\player_utility::isinvehicle() )
        {
            self.modifiers[ "in_vehicle" ] = 1;
            self.modifiers[ "mask2" ] = self.modifiers[ "mask2" ] | 4096;
        }
        
        if ( var4 scripts\cp_mp\utility\player_utility::isinvehicle() )
        {
            self.modifiers[ "victim_in_vehicle" ] = 1;
            self.modifiers[ "mask2" ] = self.modifiers[ "mask2" ] | 8192;
        }
        
        if ( isdefined( var7 ) && isdefined( var7.equipmentref ) )
        {
            if ( var7.equipmentref == "equip_c4" || var7.equipmentref == "equip_claymore" )
            {
                var50 = var7 getlinkedparent();
                
                if ( isdefined( var50 ) && isdefined( var50.helperdronetype ) && var50.helperdronetype == "radar_drone_recon" )
                {
                    self.modifiers[ "recon_drone_explosive" ] = 1;
                    self.modifiers[ "mask2" ] = self.modifiers[ "mask2" ] | 32768;
                    
                    if ( level.challengesallowed && isdefined( var50.owner ) )
                    {
                        self.ref_12a9a = var50.owner;
                    }
                }
                else if ( isdefined( var50 ) && var50 scripts\cp_mp\vehicles\vehicle::isvehicle() )
                {
                    self.modifiers[ "vehicle_explosive" ] = 1;
                    self.modifiers[ "mask2" ] = self.modifiers[ "mask2" ] | 65536;
                }
            }
            else if ( var7.equipmentref == "equip_supportBox" )
            {
                self.modifiers[ "mask3" ] = self.modifiers[ "mask3" ] | 2048;
            }
        }
        
        var51 = scripts\cp\vehicles\vehicle_compass_cp::getoperatorfavoriteweapon( var13[ 0 ] );
        
        if ( var51 != "" )
        {
            if ( scripts\mp\utility\weapon::getweaponrootname( var5.basename ) == var51 )
            {
                self.modifiers[ "mask3" ] = self.modifiers[ "mask3" ] | 512;
            }
        }
        
        if ( scripts\mp\utility\perk::_hasperk( "specialty_quieter" ) && scripts\mp\utility\perk::_hasperk( "specialty_no_battle_chatter" ) && scripts\mp\utility\perk::_hasperk( "specialty_lightweight" ) )
        {
            self.modifiers[ "mask3" ] = self.modifiers[ "mask3" ] | 1024;
        }
        
        if ( ( var13[ 0 ] == "s4_palmer" || var13[ 0 ] == "s4_doggett" ) && ( var13[ 0 ] == "s4_palmer" || var13[ 0 ] == "s4_doggett" ) )
        {
            self.modifiers[ "mask3" ] = self.modifiers[ "mask3" ] | 4096;
        }
    }
    
    if ( scripts\mp\utility\weapon::iskillstreakweapon( var5.basename ) || scripts\mp\utility\weapon::unsetreduceregendelayonkills( var7 ) )
    {
        self.modifiers[ "killstreak" ] = 1;
    }
    
    if ( isdefined( self.lastkilledby ) && self.lastkilledby == var4 )
    {
        self.modifiers[ "revenge" ] = 1;
        self.modifiers[ "mask" ] = self.modifiers[ "mask" ] | 16777216;
    }
    
    var52 = 1;
    var53 = 0;
    var54 = 0;
    
    if ( isdefined( var4.damagedplayers ) )
    {
        var55 = scripts\mp\utility\teams::getteamdata( self.team, "players" );
        
        foreach ( var61, var57 in var4.damagedplayers )
        {
            if ( !istrue( var54 ) || !istrue( var53 ) )
            {
                foreach ( var59 in var55 )
                {
                    if ( isdefined( var59 ) && isdefined( var59.guid ) && var59.guid == var61 )
                    {
                        if ( isalive( var59 ) && var59.team == self.team && var9 - var57 < 1750 )
                        {
                            self.modifiers[ "savior" ] = 1;
                            self.modifiers[ "mask3" ] = self.modifiers[ "mask3" ] | 8192;
                            var53 = 1;
                            
                            if ( var10 == "weapon_sniper" )
                            {
                                self.modifiers[ "mask2" ] = self.modifiers[ "mask2" ] | 134217728;
                                var54 = 1;
                            }
                            
                            break;
                        }
                    }
                }
            }
            
            if ( self.guid == var61 )
            {
                var52 = 0;
            }
        }
    }
    
    if ( self.health == self.maxhealth && istrue( var52 ) )
    {
        self.modifiers[ "mask2" ] = self.modifiers[ "mask2" ] | 268435456;
    }
    
    foreach ( var63 in level.decoygrenades )
    {
        if ( isdefined( var63.playersdebuffed ) )
        {
            foreach ( var65 in var63.playersdebuffed )
            {
                if ( var4 == var65 )
                {
                    self.modifiers[ "mask2" ] = self.modifiers[ "mask2" ] | 536870912;
                }
            }
        }
    }
    
    var68 = reset_map_dvars();
    
    if ( var68.size > 0 )
    {
        foreach ( var61 in var68 )
        {
            if ( var12 == var61 )
            {
                self.modifiers[ "killedNemesis" ] = 1;
                self.modifiers[ "mask2" ] = self.modifiers[ "mask2" ] | 16;
                break;
            }
        }
    }
    
    if ( scripts\mp\utility\game::getgametype() != "br" )
    {
        if ( self.modifiers[ "mask" ] & 1048576 && self.modifiers[ "mask" ] & 262144 )
        {
            getjuggdamagescale( var5 );
        }
    }
    
    if ( var10 == "other" )
    {
        getkillstreakairstrikeheightent( var5 );
        return;
    }
}

// Params 5
// Size: 0xd
function registerhints( var0, var1, var2, var3, var4 )
{
    var5 = 0;
    return var5;
}

// Params 5
// Size: 0x9c
function registerleveldataforvehicle( var0, var1, var2, var3, var4 )
{
    var5 = 0;
    
    if ( scripts\mp\class::vehicle_checkpiggybackexploit( var2 ) )
    {
        var5 |= 131072;
    }
    
    if ( scripts\mp\equipment\gas_grenade::plunder_playerspawnedcallback( self, var1 ) )
    {
        var5 |= 16777216;
    }
    
    if ( var1 scripts\mp\weapons::isblinded() )
    {
        var5 |= 8388608;
    }
    
    if ( scripts\mp\utility\player::unset_relic_trex( var1 ) )
    {
        var5 |= 2048;
    }
    
    if ( scripts\cp_mp\utility\killstreak_utility::teamhasuav( var1.team ) )
    {
        var5 |= 1;
    }
    
    if ( scripts\cp_mp\utility\player_utility::isinvehicle() )
    {
        var5 |= 4096;
    }
    
    if ( isdefined( self.radarstrength ) && self.radarstrength > 3 && !var1 scripts\mp\utility\perk::_hasperk( "specialty_br_ghost" ) )
    {
        var5 |= 4194304;
    }
    
    return var5;
}

// Params 6
// Size: 0xe68
function killedplayer( var0, var1, var2, var3, var4, var5 )
{
    var6 = gettime();
    
    if ( isdefined( var2.ref_121d9 ) )
    {
        var2 = var2.ref_121d9;
    }
    
    level.numkills++;
    
    if ( level.lastkilltime != var6 )
    {
        level.prevlastkilltime = level.lastkilltime;
        level.lastkilltime = var6;
    }
    
    cargo_truck_mg_initoccupancy( var0, var1, var2, var3, var4, var5 );
    checkkillstreakkillevents( var2, var3, var4 );
    thread getgulagclosedcircleindex( var1 );
    var7 = var1.guid;
    var8 = self.guid;
    var9 = createheadicon( var2 );
    thread killedplayernotifysys( var0, var1, var2, var3 );
    thread updaterecentkills( var0, var1, var2, var9 );
    thread ref_13fe5( var3, var4, var1 );
    thread updatequadfeedcounter( self, var0 );
    self.prevlastkilltime = self.lastkilltime;
    self.lastkilltime = var6;
    self.lastkilledplayer = var1;
    self.lastkillvictimpos = var1.origin;
    
    if ( self.deaths > 0 )
    {
        var10 = self.kills / self.deaths;
        
        if ( var10 > 3 )
        {
            level thread scripts\mp\battlechatter_mp::saytoself( self, "plr_kd_high", undefined, 0.75 );
        }
    }
    else if ( self.kills > 5 )
    {
        level thread scripts\mp\battlechatter_mp::saytoself( self, "plr_kd_high", undefined, 0.75 );
    }
    
    if ( istrue( self.laststanding ) )
    {
        scripts\mp\utility\stats::incpersstat( "clutch", 1 );
    }
    
    self.damagedplayers[ var7 ] = undefined;
    var11 = scripts\mp\utility\weapon::getweapongroup( var2.basename );
    
    if ( istrue( self.modifiers[ "firstblood" ] ) )
    {
        firstblood( var0 );
    }
    
    if ( istrue( self.modifiers[ "execution" ] ) )
    {
        execution( var0 );
    }
    
    if ( !scripts\mp\utility\weapon::iskillstreakweapon( var2.basename ) && !scripts\mp\utility\perk::_hasperk( "specialty_explosivebullets" ) )
    {
        if ( var2.basename == "none" && var3 != "MOD_EXECUTION" )
        {
            return 0;
        }
        
        var12 = celebration_end( self, var4, var2, var3 );
        
        if ( istrue( self.modifiers[ "oneshotkill" ] ) )
        {
            thread killeventtextpopup( "one_shot_kill", 1 );
            thread scripts\mp\awards::givemidmatchaward( "one_shot_kill" );
            scripts\mp\utility\stats::incpersstat( "oneShotOneKills", 1 );
        }
        
        if ( istrue( self.modifiers[ "gunbutt" ] ) )
        {
            thread killeventtextpopup( "gun_butt", 1 );
            thread scripts\mp\awards::givemidmatchaward( "gun_butt" );
        }
        
        if ( var3 == "MOD_MELEE" )
        {
            if ( var2.basename == "iw8_fists_mp" )
            {
                thread killeventtextpopup( "fist_kill", 1 );
                thread scripts\mp\awards::givemidmatchaward( "fist_kill" );
            }
        }
        
        if ( istrue( self.modifiers[ "assistedsuicide" ] ) )
        {
            assistedsuicide( var0, var2 );
        }
        
        if ( istrue( self.modifiers[ "comeback" ] ) )
        {
            comeback( var0 );
        }
        
        if ( istrue( self.modifiers[ "headshot" ] ) )
        {
            level thread scripts\mp\battlechatter_mp::saytoself( self, "plr_killfirm_headshot", undefined, 0.75 );
            headshot( var0 );
        }
        
        if ( istrue( self.modifiers[ "posthumous" ] ) )
        {
            postdeathkill( var0 );
        }
        
        if ( !scripts\mp\utility\player::isreallyalive( self ) && isdefined( self.deathtime ) )
        {
            var13 = gettime() - self.deathtime;
            
            if ( scripts\mp\utility\game::issimultaneouskillenabled() )
            {
                if ( var13 == 0 && isdefined( self.lastattacker ) && self.lastattacker == var1 )
                {
                    thread killeventtextpopup( "simultaneous_kill", 0 );
                    thread scripts\mp\awards::givemidmatchaward( "simultaneous_kill", undefined, undefined, 1 );
                    thread killeventtextpopup( var1, "simultaneous_kill" );
                    var1 thread scripts\mp\awards::givemidmatchaward( "simultaneous_kill", undefined, undefined, 1 );
                }
            }
        }
        
        if ( istrue( self.modifiers[ "avenger" ] ) )
        {
            avengedplayer( var0, var1.lastkilledplayer );
        }
        
        var14 = undefined;
        
        if ( var1 isinexecutionattack() )
        {
            var15 = scripts\common\utility::playersnear( var1.origin, 300 );
            
            foreach ( var17 in var15 )
            {
                if ( var17.team == self.team && var17 isinexecutionvictim() )
                {
                    var14 = var17.guid;
                    defendedplayer( var0, var17.guid );
                    break;
                }
            }
        }
        
        foreach ( var21, var20 in var1.damagedplayers )
        {
            if ( isdefined( var14 ) && var21 == var14 )
            {
                continue;
            }
            
            if ( level.teambased && var6 - var20 < 1750 )
            {
                defendedplayer( var0, var21 );
            LOC_00000432:
            }
        LOC_00000432:
        }
        
        if ( istrue( self.modifiers[ "pointblank" ] ) )
        {
            thread pointblank( var0 );
        }
        
        if ( istrue( self.modifiers[ "longshot" ] ) )
        {
            thread longshot( var0 );
        }
        
        if ( istrue( self.modifiers[ "very_longshot" ] ) )
        {
            thread very_longshot( var0 );
        }
        
        if ( istrue( self.modifiers[ "backstab" ] ) )
        {
            if ( var2.basename == "iw8_knife_mp" )
            {
                thread killeventtextpopup( "backstab", 1 );
                thread scripts\mp\awards::givemidmatchaward( "backstab" );
            }
        }
        
        if ( var12 )
        {
            switch ( weaponclass( var2.basename ) )
            {
                case "rifle":
                    scripts\mp\utility\stats::incpersstat( "arKills", 1 );
                    var1 scripts\mp\utility\stats::incpersstat( "arDeaths", 1 );
                    
                    if ( var3 == "MOD_HEAD_SHOT" )
                    {
                        scripts\mp\utility\stats::incpersstat( "arHeadshots", 1 );
                    }
                    
                    break;
                case "smg":
                    scripts\mp\utility\stats::incpersstat( "smgKills", 1 );
                    var1 scripts\mp\utility\stats::incpersstat( "smgDeaths", 1 );
                    
                    if ( var3 == "MOD_HEAD_SHOT" )
                    {
                        scripts\mp\utility\stats::incpersstat( "smgHeadshots", 1 );
                    }
                    
                    if ( istrue( self.modifiers[ "ads" ] ) )
                    {
                        if ( !isdefined( self.pers[ "smgADSKills" ] ) )
                        {
                            self.pers[ "smgADSKills" ] = 1;
                        }
                        else
                        {
                            self.pers[ "smgADSKills" ]++;
                        }
                    }
                    
                    break;
                case "spread":
                    scripts\mp\utility\stats::incpersstat( "shotgunKills", 1 );
                    var1 scripts\mp\utility\stats::incpersstat( "shotgunDeaths", 1 );
                    
                    if ( var3 == "MOD_HEAD_SHOT" )
                    {
                        scripts\mp\utility\stats::incpersstat( "shotgunHeadshots", 1 );
                    }
                    
                    break;
                case "mg":
                    scripts\mp\utility\stats::incpersstat( "lmgKills", 1 );
                    var1 scripts\mp\utility\stats::incpersstat( "lmgDeaths", 1 );
                    
                    if ( var3 == "MOD_HEAD_SHOT" )
                    {
                        scripts\mp\utility\stats::incpersstat( "lmgHeadshots", 1 );
                    }
                    
                    break;
                case "sniper":
                    scripts\mp\utility\stats::incpersstat( "sniperKills", 1 );
                    var1 scripts\mp\utility\stats::incpersstat( "sniperDeaths", 1 );
                    
                    if ( var3 == "MOD_HEAD_SHOT" )
                    {
                        scripts\mp\utility\stats::incpersstat( "sniperHeadshots", 1 );
                    }
                    
                    if ( istrue( self.modifiers[ "oneshotkill" ] ) )
                    {
                        if ( !isdefined( self.pers[ "sniperOneShotKills" ] ) )
                        {
                            self.pers[ "sniperOneShotKills" ] = 1;
                        }
                        else
                        {
                            self.pers[ "sniperOneShotKills" ]++;
                        }
                    }
                    
                    break;
                case "rocketlauncher":
                    scripts\mp\utility\stats::incpersstat( "launcherKills", 1 );
                    var1 scripts\mp\utility\stats::incpersstat( "launcherDeaths", 1 );
                    
                    if ( var3 == "MOD_HEAD_SHOT" )
                    {
                        scripts\mp\utility\stats::incpersstat( "launcherHeadshots", 1 );
                    }
                    
                    break;
                case "pistol":
                    scripts\mp\utility\stats::incpersstat( "pistolKills", 1 );
                    var1 scripts\mp\utility\stats::incpersstat( "pistolPeaths", 1 );
                    
                    if ( var3 == "MOD_HEAD_SHOT" )
                    {
                        scripts\mp\utility\stats::incpersstat( "pistolHeadshots", 1 );
                    }
                    
                    break;
            }
            
            if ( var2 hasattachment( "akimbo", 1 ) )
            {
                self.modifiers[ "mask3" ] = self.modifiers[ "mask3" ] | 256;
            }
            
            if ( var3 == "MOD_MELEE" )
            {
                scripts\mp\utility\stats::incpersstat( "meleeKills", 1 );
                var1 scripts\mp\utility\stats::incpersstat( "meleeDeaths", 1 );
            }
            else if ( var3 == "MOD_FIRE" || isdefined( var2 ) && isdefined( var2.basename ) && var2.basename == "molotov_mp" )
            {
                if ( !isdefined( self.pers[ "fireKills" ] ) )
                {
                    self.pers[ "fireKills" ] = 1;
                }
                else
                {
                    self.pers[ "fireKills" ]++;
                }
                
                self.modifiers[ "mask3" ] = self.modifiers[ "mask3" ] | 128;
            }
            
            if ( isdefined( level.supportdrones ) && level.supportdrones.size > 0 )
            {
                foreach ( var23 in level.supportdrones )
                {
                    if ( var23.owner == self && var23.helperdronetype == "radar_drone_overwatch" )
                    {
                        var23.owner scripts\mp\utility\stats::incpersstat( "killstreakPersonalUAVKills", 1 );
                        break;
                    }
                }
            }
            
            if ( istrue( self.modifiers[ "low_health_kill" ] ) )
            {
                thread givekillreward( "low_health_kill", var0, var2, "low_health_kill" );
                level thread scripts\mp\battlechatter_mp::trysaylocalsound( self, "flavor_neardeathkill", undefined, 1 );
            }
            
            if ( istrue( self.modifiers[ "ads" ] ) )
            {
                scripts\mp\utility\stats::incpersstat( "adsKills", 1 );
            }
            else if ( istrue( self.modifiers[ "hipfire" ] ) )
            {
                scripts\mp\utility\stats::incpersstat( "hipfireKills", 1 );
            }
            
            if ( istrue( self.modifiers[ "moving_kill" ] ) )
            {
                if ( !isdefined( self.pers[ "movingKills" ] ) )
                {
                    self.pers[ "movingKills" ] = 1;
                }
                else
                {
                    self.pers[ "movingKills" ]++;
                }
            }
            
            if ( self ismantling() )
            {
                ref_11abe( var0 );
            }
            
            if ( istrue( self.modifiers[ "backfire" ] ) )
            {
                chopper_boss_players_connect_monitor( var0 );
            }
        }
        
        if ( istrue( self.modifiers[ "air_to_air_kill" ] ) )
        {
            thread givekillreward( "air_to_air_kill", var0, var2, "air_to_air_kill" );
        }
        
        if ( istrue( self.modifiers[ "wallkill" ] ) )
        {
            thread givekillreward( "wallkill", var0, var2, "wallrun_kill" );
        }
        
        if ( istrue( self.modifiers[ "jumpkill" ] ) )
        {
            thread givekillreward( "jumpkill", var0, var2, "air_kill" );
        }
        
        if ( istrue( self.modifiers[ "sliding" ] ) )
        {
            thread givekillreward( "slidekill", var0, var2, "slide_kill" );
            thread killeventtextpopup( "slide_kill", 1 );
            
            if ( !isdefined( self.pers[ "slideKills" ] ) )
            {
                self.pers[ "slideKills" ] = 1;
            }
            else
            {
                self.pers[ "slideKills" ]++;
            }
        }
        
        if ( istrue( self.modifiers[ "killonwall" ] ) )
        {
            thread givekillreward( "killonwall", var0, var2, "kill_wallrunner" );
        }
        
        if ( istrue( self.modifiers[ "killinair" ] ) )
        {
            thread givekillreward( "killinair", var0, var2, "kill_jumper" );
        }
        
        if ( istrue( self.modifiers[ "buzzkill" ] ) )
        {
            buzzkill( var0, var1 );
        }
        
        if ( istrue( self.modifiers[ "impaired" ] ) )
        {
            start_conceal_add( var0 );
        }
        
        if ( isdefined( var1.stuckbygrenade ) )
        {
            level thread scripts\mp\battlechatter_mp::saytoself( self, "plr_killfirm_semtex", undefined, 0.75 );
        }
        
        if ( scripts\mp\utility\weapon::isthrowingknife( var2.basename ) || scripts\mp\utility\weapon::isaxeweapon( var2 ) && isdefined( var4.classname ) && var4.classname == "grenade" )
        {
            thread killeventtextpopup( "throwingknife_kill", 1 );
            thread scripts\mp\awards::givemidmatchaward( "throwingknife_kill" );
        }
        
        if ( scripts\mp\gamescore::isdebuffedbyweaponandplayer( self, var1, "decoy_grenade_mp" ) )
        {
            scripts\mp\rank::scoreeventpopup( "baited_kill" );
        }
        
        if ( istrue( self.modifiers[ "kingslayer" ] ) )
        {
            voting( var0 );
            
            if ( scripts\mp\utility\game::getgametype() == "gun" && var3 == "MOD_MELEE" )
            {
                thread killeventtextpopup( "mode_gun_melee_1st_place", 1 );
                thread scripts\mp\awards::givemidmatchaward( "mode_gun_melee_1st_place" );
            }
        }
        
        if ( self.score < var1.score )
        {
            scripts\mp\utility\stats::incpersstat( "higherRankedKills", 1 );
        }
        else
        {
            scripts\mp\utility\stats::incpersstat( "lowerRankedKills", 1 );
        }
        
        var25 = self.pers[ "cur_kill_streak" ] + 1;
        var26 = 5;
        
        if ( level.gametype == "arm" || level.gametype == "brtdm" )
        {
            var26 = 10;
        }
        
        if ( !( var25 % var26 ) )
        {
            if ( !isdefined( self.lastkillsplash ) || var25 != self.lastkillsplash )
            {
                thread scripts\mp\hud_util::teamplayercardsplash( "callout_kill_streaking", self, undefined, var25 );
                self.lastkillsplash = var25;
            }
            
            if ( var25 <= 30 )
            {
                thread killeventtextpopup( "streak_" + var25, 1 );
                thread scripts\mp\awards::givemidmatchaward( "streak_" + var25 );
            }
        }
        
        if ( !( var25 % 5 ) )
        {
            scripts\mp\utility\game::setmlgannouncement( 13, self.team, self getentitynumber(), var25 );
        }
        
        if ( var25 > 30 )
        {
            thread killeventtextpopup( "streak_max", 1 );
            thread scripts\mp\awards::givemidmatchaward( "streak_max" );
        }
        
        if ( istrue( self.modifiers[ "item_impact" ] ) )
        {
            thread scripts\mp\awards::givemidmatchaward( "item_impact" );
        }
        
        if ( istrue( self.modifiers[ "launcher_impact" ] ) )
        {
            linkedsaw( var0 );
        }
        
        if ( scripts\mp\utility\game::getgametypenumlives() >= 1 )
        {
            if ( var1.pers[ "lives" ] == 0 )
            {
                thread scripts\mp\awards::givemidmatchaward( "mode_x_eliminate", undefined, undefined, undefined, undefined, var1 );
            }
            
            var27 = scripts\mp\utility\game::ref_13e13();
            
            if ( isdefined( var27 ) && var27 == self )
            {
                thread scripts\mp\awards::givemidmatchaward( "mode_x_last_alive", undefined, undefined, undefined, undefined, var1 );
            }
        }
        
        if ( scripts\mp\utility\game::getgametype() == "br" && scripts\mp\flags::gameflag( "prematch_done" ) )
        {
            if ( self ispcplayer() )
            {
                self setclientomnvar( "nVidiaHighlights_events", 25 );
            }
            
            if ( var1 ispcplayer() )
            {
                var1 setclientomnvar( "nVidiaHighlights_events", 26 );
            }
        }
        
        checksuperkillevents( var1, var4, var2, var3, var9 );
        checksupershutdownevents( var1, var2, var3 );
    }
    
    if ( istrue( self.modifiers[ "revenge" ] ) )
    {
        self.lastkilledby = undefined;
        revenge( var0, var1 );
    }
    
    if ( !scripts\mp\utility\game::lpcfeaturegated() )
    {
        if ( !isdefined( self.killedplayers[ var7 ] ) )
        {
            self.killedplayers[ var7 ] = 0;
        }
        
        if ( !isdefined( var1.killedby[ var8 ] ) )
        {
            var1.killedby[ var8 ] = 0;
        }
        
        self.killedplayers[ var7 ]++;
        var1.killedby[ var8 ]++;
    }
    
    var1.lastkilledby = self;
    
    if ( !scripts\mp\utility\game::lpcfeaturegated() && !level.multiteambased )
    {
        var28 = 0;
        
        if ( level.teambased )
        {
            var28 = scripts\mp\utility\teams::getenemycount( self.team );
        }
        else
        {
            var28 = level.players.size - 1;
        }
        
        if ( var28 > 3 && self.killedplayers.size == var28 )
        {
            var29 = 0;
            
            if ( isdefined( self.pers[ "killEnemyTeam" ] ) )
            {
                var29 = self.pers[ "killEnemyTeam" ];
            }
            
            var30 = 1;
            
            foreach ( var17, var32 in self.killedplayers )
            {
                if ( var32 <= var29 )
                {
                    var30 = 0;
                    break;
                }
            }
            
            if ( var30 )
            {
                viphud_deletehud( var0 );
            }
        }
    }
    
    if ( !var1 scripts\mp\utility\player::isusingremote() && ( !var1 scripts\mp\utility\perk::_hasperk( "specialty_survivor" ) || istrue( var1.inlaststand ) ) )
    {
        var1 thread scripts\mp\utility\player::setdof_killer();
    }
    
    scripts\mp\utility\script::bufferednotify( "kill_event_buffered", var1, var9, var3, self.modifiers );
    thread scripts\mp\potg_events::onplayerkilled( self, var4, var1, var3, var2, var5.psoffsettime );
}

// Params 3
// Size: 0x3d2
function checkkillstreakkillevents( var0, var1, var2 )
{
    var3 = scripts\mp\utility\weapon::iskillstreakweapon( var0.basename ) || scripts\mp\utility\weapon::unsetreduceregendelayonkills( var2 );
    var4 = scripts\mp\utility\points::unset_relic_doomslayer( var0 );
    
    if ( var3 && !var4 )
    {
        if ( isdefined( var2 ) && isdefined( var2.streakinfo ) )
        {
            var5 = 1;
            
            if ( isdefined( var2.streakinfo.mpstreaksysteminfo ) )
            {
                var6 = var2.streakinfo.mpstreaksysteminfo.streaklifeid;
                var7 = self.lifeid;
                
                if ( !isdefined( var6 ) || var6 != var7 )
                {
                    var5 = 0;
                }
                
                if ( var2.streakinfo.mpstreaksysteminfo.ref_121b0 != self getxuid() )
                {
                    var5 = 0;
                }
            }
            
            if ( isdefined( var2.streakinfo.streakname ) )
            {
                var8 = 0;
                var9 = 0;
                var10 = 0;
                var11 = var2.streakinfo.streakname;
                
                switch ( var11 )
                {
                    case "bradley":
                        scripts\mp\utility\stats::incpersstat( "killstreakTankKills", 1 );
                        var8 = 1;
                        var10 = 1;
                        break;
                    case "chopper_gunner":
                        scripts\mp\utility\stats::incpersstat( "killstreakChopperGunnerKills", 1 );
                        var8 = 1;
                        var9 = 1;
                        break;
                    case "chopper_support":
                        scripts\mp\utility\stats::incpersstat( "killstreakChopperSupportKills", 1 );
                        var8 = 1;
                        var9 = 1;
                        break;
                    case "cruise_predator":
                        scripts\mp\utility\stats::incpersstat( "killstreakCruiseMissileKills", 1 );
                        var8 = 1;
                        var9 = 1;
                        break;
                    case "fuel_airstrike":
                        var8 = 1;
                        break;
                    case "gunship":
                        scripts\mp\utility\stats::incpersstat( "killstreakGunshipKills", 1 );
                        var8 = 1;
                        var9 = 1;
                        break;
                    case "hover_jet":
                        scripts\mp\utility\stats::incpersstat( "killstreakVTOLJetKills", 1 );
                        var8 = 1;
                        var9 = 1;
                        break;
                    case "juggernaut":
                        scripts\mp\utility\stats::incpersstat( "killstreakJuggernautKills", 1 );
                        var8 = 1;
                        var10 = 1;
                        break;
                    case "manual_turret":
                        scripts\mp\utility\stats::incpersstat( "killstreakShieldTurretKills", 1 );
                        var8 = 1;
                        var10 = 1;
                        break;
                    case "multi_airstrike":
                        var8 = 1;
                        break;
                    case "pac_sentry":
                        scripts\mp\utility\stats::incpersstat( "killstreakWheelsonKills", 1 );
                        var8 = 1;
                        var10 = 1;
                        break;
                    case "precision_airstrike":
                        scripts\mp\utility\stats::incpersstat( "killstreakAirstrikeKills", 1 );
                        var8 = 1;
                        var9 = 1;
                        break;
                    case "sentry_gun":
                        scripts\mp\utility\stats::incpersstat( "killstreakSentryGunKills", 1 );
                        var8 = 1;
                        var10 = 1;
                        break;
                    case "toma_strike":
                        scripts\mp\utility\stats::incpersstat( "killstreakCluserStrikeKills", 1 );
                        var8 = 1;
                        var9 = 1;
                        break;
                    case "white_phosphorus":
                        scripts\mp\utility\stats::incpersstat( "killstreakWhitePhosphorousKillsAssists", 1 );
                        var8 = 1;
                        var9 = 1;
                        break;
                    case "assault_drone":
                        scripts\mp\utility\stats::incpersstat( "killstreakAssaultDroneKills", 1 );
                        var8 = 1;
                        var9 = 1;
                        break;
                    default:
                        thread scripts\mp\utility\points::giveunifiedpoints( "killstreak_full_score", var0 );
                        break;
                }
                
                if ( isdefined( var2.streakinfo.kills ) )
                {
                    var2.streakinfo.kills++;
                    
                    if ( !istrue( var2.streakinfo.ref_11e04 ) && var2.streakinfo.kills > 1 )
                    {
                        scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f( "t9_ch_global_scorestreak_kill_two_or_more_s1", 1 );
                        var2.streakinfo.ref_11e04 = 1;
                    }
                }
                
                scripts\mp\utility\stats::incpersstat( "killstreakKills", 1 );
                
                if ( var9 )
                {
                    scripts\mp\utility\stats::incpersstat( "killstreakAirKills", 1 );
                }
                
                if ( var10 )
                {
                    scripts\mp\utility\stats::incpersstat( "killstreakGroundKills", 1 );
                }
                
                if ( var8 )
                {
                    var12 = "ss_kill_" + var11;
                    var13 = undefined;
                    
                    if ( var5 && scripts\mp\utility\perk::_hasperk( "specialty_chain_killstreaks" ) )
                    {
                        var14 = level.awards[ var12 ].xpscoreevent;
                        var13 = scripts\mp\rank::getscoreinfovalue( var14 );
                    }
                    
                    var15 = 1;
                    thread scripts\mp\awards::givemidmatchaward( var12, var13, undefined, undefined, var15, undefined, var5, var2 );
                }
                
                level thread scripts\mp\battlechatter_mp::saytoself( self, "plr_killfirm_killstreak", undefined, 0.75 );
                return;
            }
            
            return;
        }
        
        return;
    }
}

// Params 5
// Size: 0xa4
function checksuperkillevents( var0, var1, var2, var3, var4 )
{
    var5 = scripts\mp\supers::issuperinuse();
    var6 = scripts\mp\supers::getcurrentsuperref();
    var7 = scripts\mp\supers::getcurrentsuper();
    var8 = scripts\mp\utility\weapon::issuperweapon( var2.basename );
    var9 = undefined;
    
    if ( !isdefined( var6 ) )
    {
        return;
    }
    
    if ( var8 )
    {
        thread killedplayerwithsuperweapon( var0, var1, var2, var3, var4 );
        
        if ( var3 != "MOD_MELEE" )
        {
            scripts\mp\utility\script::bufferednotify( "super_kill_buffered" );
        }
    }
    
    var10 = 0;
    
    if ( isdefined( var6 ) )
    {
        switch ( var6 )
        {
            default:
                break;
        }
        
        if ( var10 )
        {
            thread superkill( var6, var3 );
            scripts\mp\supers::combatrecordsuperkill( var6 );
            
            if ( isdefined( var9 ) )
            {
                thread scripts\mp\utility\points::giveunifiedpoints( var9 );
            }
            
            scripts\mp\utility\script::bufferednotify( "super_kill_buffered" );
            return;
        }
        
        return;
    }
}

// Params 3
// Size: 0x47
function checksupershutdownevents( var0, var1, var2 )
{
    var3 = var0 scripts\mp\supers::issuperinuse();
    var4 = var0 scripts\mp\supers::getcurrentsuperref();
    var5 = var0 scripts\mp\supers::getcurrentsuper();
    
    if ( !isdefined( var4 ) )
    {
        return;
    }
    
    switch ( var4 )
    {
        default:
            if ( var3 == 1 )
            {
                thread supershutdown( var0 );
            }
            
            break;
    }
}

// Params 5
// Size: 0x5a
function killedplayerwithsuperweapon( var0, var1, var2, var3, var4 )
{
    var5 = scripts\mp\supers::getsuperrefforsuperweapon( var2 );
    var6 = self.recentkillsperweapon[ var4 ];
    
    if ( isdefined( var6 ) && var6 > 0 && var6 % 2 == 0 )
    {
        superkill( var5, var3 );
    }
    else
    {
        var7 = scripts\mp\supers::getcurrentsuper();
        var7.numkills++;
    }
    
    scripts\cp\vehicles\vehicle_compass_cp::updatesuperweaponkills( var2, var1 );
    scripts\mp\supers::combatrecordsuperkill( var5 );
}

// Params 2
// Size: 0x6e
function superkill( var0, var1 )
{
    var2 = scripts\mp\supers::getrootsuperref( var0 );
    var3 = "super_kill_" + var2;
    
    switch ( var3 )
    {
        case "super_kill_chargemode":
            var3 = "super_kill_bull_charge";
            break;
    }
    
    if ( isdefined( level.awards[ var3 ] ) )
    {
        thread scripts\mp\awards::givemidmatchaward( var3 );
    }
    
    var4 = scripts\mp\supers::getcurrentsuper();
    var4.numkills++;
    scripts\cp\vehicles\vehicle_compass_cp::updatesuperkills( var0, var1, var4.numkills );
    self.modifiers[ "super_kill_medal" ] = var0;
}

// Params 3
// Size: 0x6f
function killedkillstreak( var0, var1, var2 )
{
    var3 = "kill_ss_" + var0;
    
    if ( isdefined( var2 ) && weaponclass( var2 ) != "rocketlauncher" && var2.basename != "iw8_la_kgolf_mp" )
    {
        var2 = undefined;
    }
    
    thread killeventtextpopup( var1, var3 );
    var1 thread scripts\mp\awards::givemidmatchaward( var3, undefined, undefined, undefined, undefined, undefined, undefined, undefined, var2 );
    var1 scripts\mp\utility\stats::incpersstat( "destroyedKillstreaks", 1 );
    level thread scripts\mp\battlechatter_mp::saytoself( var1, "plr_killstreak_destroy", undefined, 0.75 );
}

// Params 1
// Size: 0x43
function ref_128b3( var0 )
{
    var1 = scripts\mp\killstreaks\killstreaks::rocket_internal( var0 );
    
    foreach ( var3 in var1 )
    {
        if ( !isdefined( var3 ) )
        {
            continue;
        }
        
        var3 thread scripts\mp\utility\points::giveunifiedpoints( "scrap_assist" );
    }
}

// Params 2
// Size: 0x3d, Type: bool
function is_enemy_highest_score( var0, var1 )
{
    foreach ( var3 in var1 )
    {
        if ( var3.score > var0.score )
        {
            return false;
        }
    }
    
    return true;
}

// Params 5
// Size: 0x159
function getshotdistancetype( var0, var1, var2, var3, var4 )
{
    if ( isalive( var0 ) && var2 != "MOD_MELEE" && !var0 scripts\mp\utility\player::isusingremote() && ( scripts\mp\utility\weapon::isprimaryweapon( var1 ) || scripts\mp\utility\weapon::iscacsecondaryweapon( var1 ) ) && !scripts\mp\utility\weapon::iskillstreakweapon( var1.basename ) && !istrue( var0.assistedsuicide ) )
    {
        var5 = distancesquared( var3, var4.origin );
        
        if ( var5 < 9216 )
        {
            return "pointblank";
        }
        
        if ( var5 > 4000000 )
        {
            return "very_longshot";
        }
        
        var6 = scripts\mp\utility\weapon::getweapongroup( var1.basename );
        var7 = undefined;
        
        switch ( var6 )
        {
            case "weapon_pistol":
                var7 = 800;
                break;
            case "weapon_beam":
            case "weapon_smg":
                var7 = 1200;
                break;
            case "weapon_lmg":
            case "weapon_dmr":
            case "weapon_assault":
            case "weapon_tactical":
                var7 = 1500;
                break;
            case "weapon_rail":
            case "weapon_sniper":
                var7 = 2000;
                break;
            case "weapon_shotgun":
                var7 = 500;
                break;
            case "weapon_projectile":
                var7 = 1200;
                break;
            case "weapon_melee2":
            case "other":
                var7 = 1969;
                break;
            default:
                var7 = 1536;
                break;
        }
        
        var8 = var7 * var7;
        
        if ( var5 > var8 )
        {
            return "longshot";
        }
    }
    
    return "none";
}

// Params 3
// Size: 0xd2, Type: bool
function update_future_stations_track_timers( var0, var1, var2 )
{
    var3 = distancesquared( var0, var1.origin );
    var4 = scripts\mp\utility\weapon::getweapongroup( var2.basename );
    var5 = undefined;
    
    switch ( var4 )
    {
        case "weapon_pistol":
            var5 = 1500;
            break;
        case "weapon_beam":
        case "weapon_smg":
            var5 = 2000;
            break;
        case "weapon_dmr":
            var5 = 4000;
            break;
        case "weapon_lmg":
        case "weapon_assault":
        case "weapon_tactical":
            var5 = 3000;
            break;
        case "weapon_rail":
        case "weapon_sniper":
            var5 = 8000;
            break;
        case "weapon_shotgun":
            var5 = 1000;
            break;
        case "weapon_projectile":
            var5 = 4000;
            break;
        default:
            var5 = 4000;
            break;
    }
    
    var6 = var5 * var5;
    return var3 > var6;
}

// Params 5
// Size: 0x3e, Type: bool
function isdeathfromabove( var0, var1, var2, var3, var4 )
{
    if ( isalive( var0 ) && var0 isjumping() && scripts\engine\utility::isbulletdamage( var2 ) )
    {
        var5 = var0.origin[ 2 ] - var4.origin[ 2 ];
        return ( var5 > 60 );
    }
    
    return false;
}

// Params 5
// Size: 0x1e, Type: bool
function isskeetshooter( var0, var1, var2, var3, var4 )
{
    return isalive( var0 ) && var4 isjumping() && scripts\engine\utility::isbulletdamage( var2 );
}

// Params 3
// Size: 0x6b, Type: bool
function isbackkill( var0, var1, var2 )
{
    if ( !isplayer( var0 ) || !isplayer( var1 ) )
    {
        return false;
    }
    
    if ( var2 != "MOD_RIFLE_BULLET" && var2 != "MOD_PISTOL_BULLET" && var2 != "MOD_MELEE" && var2 != "MOD_HEAD_SHOT" )
    {
        return false;
    }
    
    var3 = var1 getplayerangles();
    var4 = var0 getplayerangles();
    var5 = angleclamp180( var3[ 1 ] - var4[ 1 ] );
    
    if ( abs( var5 ) < 80 )
    {
        return true;
    }
    
    return false;
}

// Params 1
// Size: 0x26, Type: bool
function issurvivorkill( var0 )
{
    return var0.health > 0 && var0.health < var0.maxhealth * 0.5;
}

// Params 2
// Size: 0x5d, Type: bool
function underbridge_reinforce_enemy_monitor( var0, var1 )
{
    var2 = isdefined( var1.lastsnapshotgrenadetime ) && var1.lastsnapshotgrenadetime + scripts\mp\equipment\snapshot_grenade::removespawnselections() > gettime();
    var3 = isdefined( var0.radarstrength ) && var0.radarstrength > 3 && !var1 scripts\mp\utility\perk::_hasperk( "specialty_br_ghost" );
    var4 = istrue( var1.update_bomb_vest_lua );
    return var2 || var3 || var4;
}

// Params 4
// Size: 0x1d
function givekillreward( var0, var1, var2, var3 )
{
    if ( isdefined( var3 ) )
    {
        thread scripts\mp\awards::givemidmatchaward( var3 );
        return;
    }
    
    thread scripts\mp\utility\points::giveunifiedpoints( var0, var2 );
}

// Params 1
// Size: 0x1d
function proximityassist( var0 )
{
    self.modifiers[ "proximityAssist" ] = 1;
    thread scripts\mp\utility\points::giveunifiedpoints( "proximityassist" );
}

// Params 1
// Size: 0x1d
function proximitykill( var0 )
{
    self.modifiers[ "proximityKill" ] = 1;
    thread scripts\mp\utility\points::giveunifiedpoints( "proximitykill" );
}

// Params 1
// Size: 0x62
function longshot( var0 )
{
    thread scripts\common\utility::ref_13e0a( level.ref_11b26, var0, "longshot" );
    scripts\mp\utility\stats::incpersstat( "longshotKills", 1 );
    thread killeventtextpopup( "longshot", 1 );
    thread scripts\mp\awards::givemidmatchaward( "longshot" );
    
    if ( self.currentweapon hasattachment( "gunperk_acquisition" ) || self.currentweapon hasattachment( "gunperk_acquisition_ch2" ) )
    {
        thread scripts\mp\perks\perkfunctions::ref_13121();
        return;
    }
}

// Params 1
// Size: 0x14
function very_longshot( var0 )
{
    level thread scripts\mp\battlechatter_mp::trysaylocalsound( self, "flavor_headshotlong", undefined, 1 );
}

// Params 1
// Size: 0x3a
function pointblank( var0 )
{
    thread scripts\common\utility::ref_13e0a( level.ref_11b26, var0, "pointblank" );
    thread killeventtextpopup( "pointblank", 1 );
    thread scripts\mp\awards::givemidmatchaward( "pointblank" );
    scripts\mp\utility\stats::incpersstat( "pointBlankKills", 1 );
}

// Params 1
// Size: 0x2d
function headshot( var0 )
{
    thread scripts\common\utility::ref_13e0a( level.ref_11b26, var0, "headshot" );
    thread killeventtextpopup( "headshot", 1 );
    thread scripts\mp\awards::givemidmatchaward( "headshot" );
}

// Params 2
// Size: 0x3b
function avengedplayer( var0, var1 )
{
    thread scripts\common\utility::ref_13e0a( level.ref_11b26, var0, "avenger" );
    scripts\mp\utility\stats::incpersstat( "avengerKills", 1 );
    thread killeventtextpopup( "avenger", 1 );
    thread scripts\mp\awards::givemidmatchaward( "avenger" );
}

// Params 2
// Size: 0x3a
function assistedsuicide( var0, var1 )
{
    thread scripts\mp\utility\points::giveunifiedpoints( "assistedsuicide", var1 );
    thread scripts\common\utility::ref_13e0a( level.ref_11b26, var0, "assistedsuicide" );
    thread killeventtextpopup( "assistedsuicide", 1 );
    thread scripts\mp\awards::givemidmatchaward( "assistedsuicide" );
}

// Params 2
// Size: 0x4a
function defendedplayer( var0, var1 )
{
    thread scripts\common\utility::ref_13e0a( level.ref_11b26, var0, "defender" );
    scripts\mp\utility\stats::incpersstat( "defenderKills", 1 );
    thread killeventtextpopup( "savior", 0 );
    thread scripts\mp\awards::givemidmatchaward( "save_teammate" );
    level thread scripts\mp\battlechatter_mp::trysaylocalsound( self, "flavor_save", undefined, 1 );
}

// Params 1
// Size: 0x2d
function postdeathkill( var0 )
{
    thread scripts\common\utility::ref_13e0a( level.ref_11b26, var0, "posthumous" );
    thread killeventtextpopup( "posthumous", 1 );
    thread scripts\mp\awards::givemidmatchaward( "posthumous" );
}

// Params 2
// Size: 0x6e
function revenge( var0, var1 )
{
    thread scripts\common\utility::ref_13e0a( level.ref_11b26, var0, "revenge" );
    scripts\mp\utility\stats::incpersstat( "revengeKills", 1 );
    thread killeventtextpopup( "revenge", 1 );
    thread scripts\mp\awards::givemidmatchaward( "revenge" );
    level thread scripts\mp\battlechatter_mp::trysaylocalsound( self, "flavor_revenge", undefined, 1 );
    playfx( scripts\engine\utility::getfx( "money" ), var1.origin + ( 0, 0, 64 ) );
}

// Params 4
// Size: 0x17b
function multikill( var0, var1, var2, var3 )
{
    if ( !isdefined( self.inneurotoxintimestamp ) )
    {
        self.inneurotoxintimestamp = var1;
    }
    
    if ( var1 < self.inneurotoxintimestamp )
    {
        return;
    }
    
    self endon( "disconnect" );
    level endon( "game_ended" );
    self notify( "multiKill" );
    self endon( "multiKill" );
    waitframe();
    var4 = undefined;
    var5 = undefined;
    
    switch ( var1 )
    {
        case 2:
            var4 = "double";
            break;
        case 3:
            var4 = "triple";
            var5 = "callout_3xkill";
            break;
        case 4:
            var4 = "four";
            var5 = "callout_4xkill";
            break;
        case 5:
            var4 = "five";
            var5 = "callout_5xkill";
            break;
        case 6:
            var4 = "six";
            var5 = "callout_6xkill";
            break;
        case 7:
            var4 = "seven";
            var5 = "callout_7xkill";
            break;
        case 8:
            var4 = "eight";
            var5 = "callout_8xkill";
            break;
        default:
            var4 = "multi";
            var5 = "callout_9xkill";
            break;
    }
    
    if ( isdefined( self.pers[ "highestMultikill" ] ) && var1 > self.pers[ "highestMultikill" ] )
    {
        self.pers[ "highestMultikill" ] = var1;
    }
    
    thread scripts\common\utility::ref_13e0a( level.ref_11b2b, var0, var1 );
    
    if ( isdefined( var4 ) )
    {
        thread killeventtextpopup( var4, scripts\engine\utility::ter_op( isdefined( var2 ), var2, 1 ), istrue( var3 ) );
        
        if ( !istrue( var3 ) )
        {
            thread scripts\mp\awards::givemidmatchaward( var4 );
        }
    }
    
    if ( isdefined( var5 ) )
    {
        thread scripts\mp\hud_util::teamplayercardsplash( var5, self );
        return;
    }
}

// Params 1
// Size: 0x4a
function firstblood( var0 )
{
    scripts\mp\utility\game::setmlgannouncement( 11, self.team, self getentitynumber() );
    thread scripts\common\utility::ref_13e0a( level.ref_11b26, var0, "firstblood" );
    thread scripts\mp\hud_util::teamplayercardsplash( "callout_firstblood", self );
    thread killeventtextpopup( "firstblood", 1 );
    thread scripts\mp\awards::givemidmatchaward( "firstblood" );
}

// Params 2
// Size: 0x2e
function buzzkill( var0, var1 )
{
    thread scripts\common\utility::ref_13e0a( level.ref_11b26, var0, "buzzkill" );
    thread killeventtextpopup( "buzzkill", 1 );
    thread scripts\mp\awards::givemidmatchaward( "buzzkill" );
}

// Params 1
// Size: 0x1c
function start_conceal_add( var0 )
{
    thread killeventtextpopup( "stunned_kill", 1 );
    thread scripts\mp\awards::givemidmatchaward( "stunned_kill" );
}

// Params 1
// Size: 0x3a
function comeback( var0 )
{
    thread scripts\common\utility::ref_13e0a( level.ref_11b26, var0, "comeback" );
    thread killeventtextpopup( "comeback", 1 );
    thread scripts\mp\awards::givemidmatchaward( "comeback" );
    scripts\mp\utility\stats::incpersstat( "comebackKills", 1 );
}

// Params 1
// Size: 0x74
function supershutdown( var0 )
{
    var1 = scripts\mp\supers::getrootsuperref( var0.super.staticdata.ref );
    self.modifiers[ "superShutdown" ] = var0.super.staticdata.ref;
    var2 = "super_shutdown_" + var1;
    
    switch ( var1 )
    {
        case "chargemode":
            var2 = "super_shutdown_bull_charge";
            break;
    }
    
    if ( isdefined( level.awards[ var2 ] ) )
    {
        thread scripts\mp\awards::givemidmatchaward( var2 );
        return;
    }
}

// Params 1
// Size: 0x87
function collateral( var0 )
{
    if ( var0 == 2 )
    {
        level thread scripts\mp\battlechatter_mp::saytoself( self, "plr_killfirm_twofer", undefined, 0.75 );
        thread killeventtextpopup( "one_shot_two_kills", 1 );
        thread scripts\mp\awards::givemidmatchaward( "one_shot_two_kills" );
    }
    
    if ( var0 == 3 )
    {
        level thread scripts\mp\battlechatter_mp::saytoself( self, "plr_killfirm_threefer", undefined, 0.75 );
    }
    
    if ( var0 > 1 )
    {
        self.modifiers[ "collateral" ] = 1;
        self.modifiers[ "mask3" ] = self.modifiers[ "mask3" ] | 64;
    }
    
    thread scripts\mp\potg_events::collateral( self, var0 );
}

// Params 1
// Size: 0xc
function shotguncollateral( var0 )
{
    thread scripts\mp\potg_events::shotguncollateral( self, var0 );
}

// Params 1
// Size: 0x1c
function ref_11abe( var0 )
{
    thread killeventtextpopup( "mantle_kill", 1 );
    thread scripts\mp\awards::givemidmatchaward( "mantle_kill" );
}

// Params 1
// Size: 0x1c
function chopper_boss_players_connect_monitor( var0 )
{
    thread killeventtextpopup( "backfire", 1 );
    thread scripts\mp\awards::givemidmatchaward( "backfire" );
}

// Params 2
// Size: 0x59
function quadfeed( var0, var1 )
{
    self.modifiers[ "quadfeed" ] = 1;
    self.modifiers[ "mask" ] = self.modifiers[ "mask" ] | 536870912;
    thread killeventtextpopup( "quad_feed", 1 );
    thread scripts\mp\awards::givemidmatchaward( "quad_feed" );
    thread scripts\mp\potg_events::quadfeed( self, var1.starttime, gettime() );
}

// Params 1
// Size: 0x39
function viphud_deletehud( var0 )
{
    self.modifiers[ "killEnemyTeam" ] = 1;
    self.modifiers[ "mask2" ] = self.modifiers[ "mask2" ] | 2;
    scripts\mp\utility\stats::incpersstat( "killEnemyTeam", 1 );
}

// Params 1
// Size: 0x29
function voting( var0 )
{
    thread killeventtextpopup( "first_place_kill", 1 );
    thread scripts\mp\awards::givemidmatchaward( "first_place_kill" );
    scripts\mp\utility\stats::incpersstat( "highestRankedKills", 1 );
}

// Params 1
// Size: 0x1c
function linkedsaw( var0 )
{
    thread killeventtextpopup( "launcher_direct_hit", 1 );
    thread scripts\mp\awards::givemidmatchaward( "launcher_direct_hit" );
}

// Params 1
// Size: 0x2c
function ref_13dd1( var0 )
{
    self.modifiers[ "tripledefenderkill" ] = 1;
    self.modifiers[ "mask2" ] = self.modifiers[ "mask2" ] | 32;
}

// Params 1
// Size: 0x1c
function execution( var0 )
{
    scripts\mp\utility\stats::incpersstat( "executions", 1 );
    thread scripts\mp\utility\points::giveunifiedpoints( "execution" );
}

// Params 0
// Size: 0x69
function disconnected()
{
    var0 = self.guid;
    
    if ( !scripts\mp\utility\game::lpcfeaturegated() )
    {
        for ( var1 = 0; var1 < level.players.size ; var1++ )
        {
            if ( isdefined( level.players[ var1 ].killedplayers[ var0 ] ) )
            {
                level.players[ var1 ].killedplayers[ var0 ] = undefined;
            }
            
            if ( isdefined( level.players[ var1 ].killedby[ var0 ] ) )
            {
                level.players[ var1 ].killedby[ var0 ] = undefined;
            }
        }
        
        return;
    }
}

// Params 0
// Size: 0x24
function monitorhealed()
{
    level endon( "end_game" );
    
    for ( ;; )
    {
        level waittill( "healed", var0 );
        var0 thread scripts\mp\utility\points::giveunifiedpoints( "healed" );
    }
}

// Params 1
// Size: 0x5b
function ref_1400f( var0 )
{
    if ( !isdefined( self.modifiers ) )
    {
        return;
    }
    
    if ( !isdefined( self.ref_12a85 ) )
    {
        self.ref_12a85 = [];
    }
    
    if ( istrue( self.modifiers[ var0 ] ) )
    {
        if ( istrue( self.ref_12a85[ var0 ] ) && self.recentkillcount > 1 )
        {
            self.ref_11e03[ var0 ] = 1;
        }
        
        self.ref_12a85[ var0 ] = 1;
        return;
    }
    
    self.ref_12a85[ var0 ] = undefined;
}

// Params 4
// Size: 0x2cc
function updaterecentkills( var0, var1, var2, var3 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self notify( "updateRecentKills" );
    self endon( "updateRecentKills" );
    var4 = weaponclass( var2.basename );
    self.recentkillcount++;
    ref_1400f( "mounted" );
    
    if ( var4 == "smg" )
    {
        if ( !isdefined( self.ref_12a89 ) )
        {
            self.ref_12a89 = 1;
        }
        else
        {
            self.ref_12a89++;
        }
    }
    
    var5 = scripts\mp\utility\weapon::getweapongroup( var2.basename );
    
    if ( isdefined( self.radarstrength ) && self.radarstrength > 3 && !var1 scripts\mp\utility\perk::_hasperk( "specialty_br_ghost" ) )
    {
        if ( !isdefined( self.ref_12a8b ) )
        {
            self.ref_12a8b = 1;
        }
        else
        {
            self.ref_12a8b++;
        }
    }
    
    if ( scripts\mp\utility\game::isdefending( var1 ) )
    {
        self.recentdefendcount++;
        
        if ( scripts\mp\utility\script::isnumbermultipleof( self.recentdefendcount, 2 ) )
        {
            thread scripts\mp\awards::givemidmatchaward( "mode_x_wipeout" );
        }
    }
    
    if ( scripts\mp\utility\game::turret_outline_watcher( var1 ) )
    {
        self.ref_12a82++;
        
        if ( scripts\mp\utility\script::isnumbermultipleof( self.ref_12a82, 3 ) )
        {
            ref_13dd1( var0 );
        }
    }
    
    if ( !isdefined( self.recentkillsperweapon ) )
    {
        self.recentkillsperweapon = [];
    }
    
    if ( !isdefined( self.ref_12a86 ) )
    {
        self.ref_12a86 = [];
    }
    
    if ( !isdefined( self.recentkillsperweapon[ var3 ] ) )
    {
        self.recentkillsperweapon[ var3 ] = 1;
    }
    else
    {
        self.recentkillsperweapon[ var3 ]++;
    }
    
    if ( !isdefined( self.ref_12a86[ var2.basename ] ) )
    {
        self.ref_12a86[ var2.basename ] = 1;
    }
    else
    {
        self.ref_12a86[ var2.basename ]++;
    }
    
    var6 = scripts\mp\utility\weapon::getequipmenttype( var2.basename );
    
    if ( isdefined( var6 ) && var6 == "lethal" && !scripts\mp\utility\weapon::isthrowingknife( var2 ) )
    {
        level thread scripts\mp\battlechatter_mp::saytoself( self, "plr_killfirm_grenade", undefined, 0.75 );
        level thread scripts\mp\battlechatter_mp::saytoself( self, "plr_killfirm_amf", undefined, 0.75 );
        
        if ( self.recentkillsperweapon[ var3 ] > 0 && self.recentkillsperweapon[ var3 ] % 2 == 0 )
        {
            thread killeventtextpopup( "grenade_double", 1 );
            thread scripts\mp\awards::givemidmatchaward( "grenade_double" );
        }
    }
    
    scripts\mp\utility\script::bufferednotify( "update_rapid_kill_buffered", self.recentkillcount, var3 );
    
    if ( !isdefined( self.recentkillcount ) )
    {
        self.recentkillcount = 0;
    }
    
    if ( self.recentkillcount > 1 )
    {
        thread multikill( var0, self.recentkillcount, 0 );
        scripts\cp\vehicles\vehicle_compass_cp::init_silo_elevator( self, self.ref_11e03, var2, self.recentkillcount );
    }
    
    wait 4;
    
    if ( self.recentkillcount > 1 )
    {
        thread multikill( var0, self.recentkillcount, 1, 1 );
        
        if ( self.recentkillcount > 2 )
        {
            scripts\mp\utility\game::setmlgannouncement( 12, self.team, self getentitynumber(), self.recentkillcount );
        }
    }
    
    scripts\mp\utility\stats::incpersstat( "mostMultikills", 1 );
    self.recentkillcount = 0;
    self.recentdefendcount = 0;
    self.ref_12a89 = 0;
    self.ref_12a8a = undefined;
    self.recentkillsperweapon = undefined;
    self.ref_12a86 = undefined;
    self.ref_11e04 = 0;
    self.ref_12a85 = [];
    self.ref_11e03 = [];
}

// Params 3
// Size: 0x75
function ref_13fe5( var0, var1, var2 )
{
    if ( scripts\mp\utility\game::getgametype() != "br" || !isdefined( level.£ßòN}4±çïõ;VVÏX±∫,:{‰ÃÍ‹ÿ ) )
    {
        return;
    }
    
    var3 = spawnstruct();
    var3.meansofdeath = var0;
    var3.inflictor = var1;
    var3.victim = var2;
    var3.ref_11a6c = 1;
    self [[ level.£ßòN}4±çïõ;VVÏX±∫,:{‰ÃÍ‹ÿ ]]( "br_mastery_travelogue", var3 );
    self [[ level.£ßòN}4±çïõ;VVÏX±∫,:{‰ÃÍ‹ÿ ]]( "br_mastery_c4VehicleMultKill", var3 );
    self [[ level.£ßòN}4±çïõ;VVÏX±∫,:{‰ÃÍ‹ÿ ]]( "br_mastery_ghostRideWhip", var3 );
}

// Params 0
// Size: 0x45
function monitorcratejacking()
{
    level endon( "end_game" );
    self endon( "disconnect" );
    
    for ( ;; )
    {
        self waittill( "hijacker", var0, var1 );
        thread scripts\mp\awards::givemidmatchaward( "ss_use_enemy_dronedrop" );
        var2 = "hijacked_airdrop";
        
        if ( isdefined( var1 ) )
        {
            var1 scripts\mp\hud_message::showsplash( var2, undefined, self );
        }
    }
}

// Params 2
// Size: 0xa2
function updatequadfeedcounter( var0, var1 )
{
    if ( isdefined( level.quadfeedinfo ) && gettime() - level.quadfeedinfo.starttime > 10000 )
    {
        level.quadfeedinfo = undefined;
    }
    
    if ( !isdefined( level.quadfeedinfo ) || level.quadfeedinfo.player != var0 )
    {
        var2 = spawnstruct();
        var2.player = var0;
        var2.starttime = gettime();
        var2.feedcount = 1;
        level.quadfeedinfo = var2;
        return;
    }
    
    var2 = level.quadfeedinfo;
    var2.feedcount++;
    
    if ( var2.feedcount == 4 )
    {
        quadfeed( var2.player, var2, var2 );
        level.quadfeedinfo = undefined;
        return;
    }
}

// Params 0
// Size: 0x11
function initslidemonitor()
{
    self.eventswassliding = self issprintsliding();
    self.eventsslideendtime = undefined;
}

// Params 0
// Size: 0x48
function events_monitorslideupdate()
{
    if ( scripts\mp\utility\player::isreallyalive( self ) )
    {
        var0 = self issprintsliding();
        
        if ( istrue( self.eventswassliding ) && !var0 )
        {
            self.eventsslideendtime = gettime();
            scripts\mp\potg::processevent( "recent_slide" );
        }
        
        self.eventswassliding = var0;
        return;
    }
    
    self.eventswassliding = 0;
    self.eventsslideendtime = undefined;
}

// Params 0
// Size: 0x2e, Type: bool
function events_issliding()
{
    if ( self issprintsliding() )
    {
        return true;
    }
    
    events_monitorslideupdate();
    
    if ( isdefined( self.eventsslideendtime ) )
    {
        if ( gettime() - self.eventsslideendtime <= 150 )
        {
            return true;
        }
    }
    
    return false;
}

// Params 0
// Size: 0x11
function initmonitoradstime()
{
    self.wasads = scripts\mp\utility\player::isplayerads();
    self.lastadsstarttime = 0;
}

// Params 0
// Size: 0x29
function monitoradstime()
{
    if ( scripts\mp\utility\player::isplayerads() )
    {
        if ( !self.wasads )
        {
            self.lastadsstarttime = gettime();
            self.wasads = 1;
            return;
        }
        
        return;
    }
    
    self.wasads = 0;
}

// Params 0
// Size: 0x36
function monitorreload()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self.lastreloadtime = 0;
    
    for ( ;; )
    {
        self waittill( "reload" );
        self.lastreloadtime = gettime();
        scripts\mp\utility\stats::incpersstat( "reloads", 1 );
    }
}

// Params 0
// Size: 0x36
function monitorweaponpickup()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self.lastweaponpickuptime = 0;
    
    for ( ;; )
    {
        self waittill( "weapon_pickup" );
        self.lastweaponpickuptime = gettime();
        scripts\mp\utility\stats::incpersstat( "weaponPickups", 1 );
    }
}

// Params 0
// Size: 0x29
function monitorweaponswitch()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self.lastweaponchangetime = 0;
    
    for ( ;; )
    {
        self waittill( "weapon_change" );
        self.lastweaponchangetime = gettime();
    }
}

// Params 0
// Size: 0xa
function updateweaponchangetime()
{
    self.lastweaponchangetime = gettime();
}

// Params 0
// Size: 0x40
function initstancetracking()
{
    self.laststance = self getstance();
    self.laststancechangetime = gettime();
    self.laststancetimes = [];
    self.laststancetimes[ "prone" ] = 0;
    self.laststancetimes[ "crouch" ] = 0;
    self.laststancetimes[ "stand" ] = 0;
}

// Params 0
// Size: 0x16c
function updatestancetracking()
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    var0 = self.mantlecur;
    self.mantlecur = self ismantling();
    
    if ( !istrue( var0 ) && self.mantlecur )
    {
        scripts\mp\potg::processevent( "recent_mantle" );
    }
    
    var1 = self.jumpcur;
    self.jumpcur = self isjumping();
    
    if ( !istrue( var1 ) && self.jumpcur )
    {
        scripts\mp\potg::processevent( "recent_jump" );
    }
    
    var2 = self getstance();
    
    if ( var2 != self.laststance )
    {
        scripts\mp\potg_events::playerstancechanged( var2 );
        
        if ( self.laststance == "crouch" )
        {
            var3 = self.laststancechangetime;
            var4 = ( gettime() - var3 ) / 1000;
            scripts\mp\utility\stats::incpersstat( "timeCrouched", var4 );
        }
        
        if ( self.laststance == "prone" )
        {
            var3 = self.laststancechangetime;
            var4 = ( gettime() - var3 ) / 1000;
            scripts\mp\utility\stats::incpersstat( "timeProne", var4 );
        }
        
        self.laststancechangetime = gettime();
        
        if ( !isdefined( self.pers[ "stanceTracking" ] ) )
        {
            self.pers[ "stanceTracking" ] = [];
            self.pers[ "stanceTracking" ][ "prone" ] = 0;
            self.pers[ "stanceTracking" ][ "crouch" ] = 0;
            self.pers[ "stanceTracking" ][ "stand" ] = 0;
        }
        
        if ( var2 == "prone" || var2 == "crouch" || var2 == "stand" )
        {
            self.pers[ "stanceTracking" ][ var2 ]++;
        }
    }
    
    self.laststancetimes[ var2 ] = gettime();
    self.laststance = var2;
}

// Params 1
// Size: 0xb
function predatormissileimpact( var0 )
{
    scripts\mp\potg_events::predatormissileimpact( var0 );
}

// Params 1
// Size: 0xb
function largevehicleexplosion( var0 )
{
    scripts\mp\potg_events::largevehicleexplosion( var0 );
}

// Params 1
// Size: 0xb
function vehiclekilled( var0 )
{
    scripts\mp\potg_events::vehiclekilled( var0 );
}

// Params 1
// Size: 0xb
function missilefired( var0 )
{
    thread trackmissile( var0 );
}

// Params 1
// Size: 0x97
function trackmissile( var0 )
{
    level endon( "game_ended" );
    var0 endon( "death" );
    var0 endon( "entitydeleted" );
    var0.whizbyplayers = [];
    
    for ( ;; )
    {
        var1 = scripts\common\utility::playersnear( var0.origin, 220 );
        
        foreach ( var3 in var1 )
        {
            if ( isdefined( var0.owner ) && var3 == var0.owner )
            {
                continue;
            }
            
            missilewhizby( var3, var0 );
            var0.whizbyplayers[ var3.guid ] = 1;
        }
        
        wait 0.1;
    }
}

// Params 2
// Size: 0xc
function missilewhizby( var0, var1 )
{
    scripts\mp\potg_events::missilewhizby( var0 );
}

// Params 1
// Size: 0x1ed
function bombdefused( var0 )
{
    var1 = 0;
    
    if ( scripts\mp\utility\game::getgametypenumlives() >= 1 )
    {
        var2 = scripts\mp\utility\game::getpotentiallivingplayers();
        
        if ( var2.size == 1 && var2[ 0 ] == var0 )
        {
            var1 = 1;
        }
    }
    
    var3 = 0;
    
    if ( !var1 && scripts\mp\utility\game::getgametype() != "dd" )
    {
        var4 = scripts\mp\utility\player::getplayersinradius( var0.origin, 600 );
        
        foreach ( var6 in var4 )
        {
            if ( var6.team != var0.team )
            {
                var3 = 1;
                break;
            }
        }
    }
    
    if ( isdefined( level.bombowner ) && level.bombowner.bombplantedtime + 3000 + level.defusetime * 1000 > gettime() && scripts\mp\utility\player::isreallyalive( level.bombowner ) )
    {
        var0 thread scripts\mp\rank::scoreeventpopup( "ninja_defuse" );
        var0 thread scripts\mp\hud_message::showsplash( "ninja_defuse", scripts\mp\rank::getscoreinfovalue( "defuse" ) );
        
        if ( scripts\mp\utility\game::getgametype() != "dd" )
        {
            var3 = 1;
        }
    }
    else
    {
        var0 thread scripts\mp\hud_message::showsplash( "emp_defuse", scripts\mp\rank::getscoreinfovalue( "defuse" ) );
        var0 thread scripts\mp\rank::scoreeventpopup( "defuse" );
    }
    
    if ( var1 )
    {
        var0 thread scripts\mp\awards::givemidmatchaward( "mode_sd_last_defuse" );
    }
    else
    {
        var0 thread scripts\mp\awards::givemidmatchaward( "mode_sd_defuse" );
    }
    
    var0 scripts\mp\utility\stats::incpersstat( "defuses", 1 );
    var0 scripts\mp\persistence::statsetchild( "round", "defuses", var0.pers[ "defuses" ] );
    
    if ( scripts\mp\utility\game::getgametype() != "sr" )
    {
        var0 scripts\mp\utility\stats::setextrascore1( var0.pers[ "defuses" ] );
    }
    
    if ( isplayer( var0 ) )
    {
        var0 thread scripts\common\utility::ref_13e0a( level.ref_11b29, "defuse", var0.origin );
    }
    
    if ( var1 )
    {
        scripts\mp\utility\game::ref_119ac( var0, undefined, "Bomb Defused", var0.origin, "last_alive" );
    }
    else
    {
        scripts\mp\utility\game::ref_119ac( var0, undefined, "Bomb Defused", var0.origin );
    }
    
    scripts\mp\potg_events::bombdefused( var0, var1, var3 );
}

// Params 2
// Size: 0x6e
function revivedplayer( var0, var1 )
{
    if ( var0 == var1 )
    {
        return;
    }
    
    scripts\mp\potg_events::revivedplayer( var0, var1 );
    var0 scripts\cp\vehicles\vehicle_compass_cp::ref_12c3f( "t9_ch_global_revived_teammate_for_operator_mission", 1 );
    
    if ( scripts\mp\utility\game::getgametype() == "br" && isdefined( level.∫:]˚©˝]oe∞Ñ)°òj√)˚3#»˚í®ó ) )
    {
        self [[ level.∫:]˚©˝]oe∞Ñ)°òj√)˚3#»˚í®ó ]]( var0, var1 );
        
        if ( getdvarint( "OMSQPMNQLS", 0 ) && var0 scripts\mp\utility\game::onlinestatsenabled() )
        {
            var0 setplayerdata( "mp", "use_revive_history", 0, 1 );
            return;
        }
        
        return;
    }
}

// Params 2
// Size: 0x1d
function doorused( var0, var1 )
{
    scripts\mp\potg_events::doorused( var0, var1 );
    
    if ( var1 )
    {
        var0.lastdooropentime = gettime();
        return;
    }
}

// Params 0
// Size: 0x2e
function shothit()
{
    if ( !isdefined( self.pers[ "shotsHit" ] ) )
    {
        scripts\mp\utility\stats::initpersstat( "shotsHit" );
    }
    
    scripts\mp\utility\stats::incpersstat( "shotsHit", 1 );
    scripts\mp\potg_events::shothit();
}

// Params 0
// Size: 0x7
function shotmissed()
{
    scripts\mp\potg_events::shotmissed();
}

// Params 3
// Size: 0x10e
function killeventtextpopup( var0, var1, var2 )
{
    self endon( "death_or_disconnect" );
    
    if ( !scripts\mp\rank::scoreeventhastext( var0 ) )
    {
        return;
    }
    
    if ( !isdefined( self.killeventqueue ) )
    {
        self.killeventqueue = [];
    }
    
    foreach ( var4 in self.killeventqueue )
    {
        if ( var4.scoreeventref == var0 )
        {
            return;
        }
    }
    
    var6 = spawnstruct();
    var6.scoreeventref = var0;
    var6.showassplash = istrue( var1 );
    var6.priority = scripts\mp\rank::getscoreeventpriority( var0 );
    var6.alwaysshowsplash = scripts\mp\rank::scoreeventalwaysshowassplash( var0 );
    var6.ref_128ac = 0;
    var6.ref_128ab = 0;
    var6.matchdata_logplayerlife = istrue( var2 );
    self.killeventqueue[ self.killeventqueue.size ] = var6;
    self notify( "killEventTextPopup" );
    self endon( "killEventTextPopup" );
    waitframe();
    
    if ( !isdefined( self.splashpriorityqueue ) )
    {
        self.splashpriorityqueue = [];
    }
    
    foreach ( var4 in self.killeventqueue )
    {
        insertbypriority( var4 );
    }
    
    self.killeventqueue = undefined;
    thread ref_128b4();
}

// Params 0
// Size: 0x109
function ref_128b4()
{
    self notify( "processSplashPriorityQueue" );
    self endon( "processSplashPriorityQueue" );
    self.ref_12464 = 1;
    
    if ( !isdefined( self.splashpriorityqueue ) )
    {
        self.ref_12464 = 0;
    }
    
    foreach ( var1 in self.splashpriorityqueue )
    {
        if ( var1.ref_128ac )
        {
            continue;
        }
        
        if ( !istrue( level.removekilleventsplash ) && istrue( var1.showassplash ) && ( !self.ref_12464 || var1.alwaysshowsplash ) )
        {
            var2 = 1;
            thread scripts\mp\hud_message::showsplash( var1.scoreeventref );
        }
        
        var1.ref_128ac = 1;
    }
    
    foreach ( var1 in self.splashpriorityqueue )
    {
        if ( var1.ref_128ab || var1.matchdata_logplayerlife )
        {
            continue;
        }
        
        thread scripts\mp\rank::scoreeventpopup( var1.scoreeventref );
        var1.ref_128ab = 1;
        wait getdvarfloat( "scr_splash_kill_buffer", 0.25 );
    }
    
    self.splashpriorityqueue = undefined;
}

// Params 1
// Size: 0xa2
function insertbypriority( var0 )
{
    if ( self.splashpriorityqueue.size == 0 )
    {
        self.splashpriorityqueue[ self.splashpriorityqueue.size ] = var0;
        return;
    }
    
    foreach ( var2 in self.splashpriorityqueue )
    {
        if ( var2.scoreeventref == var0.scoreeventref )
        {
            return;
        }
    }
    
    for ( var4 = 0; var4 < self.splashpriorityqueue.size ; var4++ )
    {
        if ( var0.priority > self.splashpriorityqueue[ var4 ].priority )
        {
            self.splashpriorityqueue = scripts\engine\utility::array_insert( self.splashpriorityqueue, var0, var4 );
            return;
        }
    }
    
    self.splashpriorityqueue[ self.splashpriorityqueue.size ] = var0;
}

// Params 0
// Size: 0x5d
function reset_map_dvars()
{
    var0 = [];
    
    if ( !scripts\mp\utility\game::lpcfeaturegated() && isdefined( self.killedby ) )
    {
        var1 = 0;
        
        foreach ( var3 in self.killedby )
        {
            if ( var3 > var1 )
            {
                var0 = [];
                var0 = var4;
            }
            
            if ( var3 == var1 )
            {
                var0 = var4;
            }
        }
    }
    
    return var0;
}

// Params 2
// Size: 0x51
function vehicle_collision_handlemultievent( var0, var1 )
{
    if ( isdefined( var0 ) && scripts\mp\utility\weapon::getweaponrootname( var0.basename ) == "iw8_sn_xmike109" && isdefined( var1.hitloc ) && ( var1.hitloc == "head" || var1.hitloc == "helmet" ) )
    {
        return 1;
    }
    
    return 0;
}

// Params 2
// Size: 0x51
function turn_on_laser_vfx( var0, var1 )
{
    if ( isdefined( var0 ) && scripts\mp\utility\weapon::getweaponrootname( var0.basename ) == "iw8_sh_aalpha12" && isdefined( var1.hitloc ) && ( var1.hitloc == "head" || var1.hitloc == "helmet" ) )
    {
        return 1;
    }
    
    return 0;
}

// Params 1
// Size: 0xb9
function getkillstreakairstrikeheightent( var0 )
{
    if ( !level.challengesallowed )
    {
        return;
    }
    
    var1 = scripts\mp\equipment::getequipmentreffromweapon( var0 );
    
    if ( !isdefined( var1 ) || !isdefined( level.weapon_xp_iw8_pi_papa320[ var1 ] ) )
    {
        return;
    }
    
    if ( self.pers[ "lethalEquipmentKillMask" ] & level.weapon_xp_iw8_pi_papa320[ var1 ] )
    {
        return;
    }
    else
    {
        self.pers[ "lethalEquipmentKillMask" ] = self.pers[ "lethalEquipmentKillMask" ] | level.weapon_xp_iw8_pi_papa320[ var1 ];
    }
    
    var2 = 0;
    
    foreach ( var4 in level.weapon_xp_iw8_pi_papa320 )
    {
        if ( self.pers[ "lethalEquipmentKillMask" ] & var4 )
        {
            var2++;
            
            if ( var2 >= 6 )
            {
                self reportchallengeuserevent( "collect_item", "lethal_achievement" );
                break;
            }
        }
    }
}

// Params 0
// Size: 0x6f
function thermite_laststand_effects()
{
    level.showquestcircletoall = [];
    var0 = [ "weapon_pistol", "weapon_smg", "weapon_assault", "weapon_dmr", "weapon_sniper", "weapon_shotgun", "weapon_lmg", "weapon_tactical" ];
    var1 = 0;
    
    foreach ( var3 in var0 )
    {
        level.showquestcircletoall[ var3 ] = 1 << var1;
        var1++;
    }
}

// Params 1
// Size: 0xb9
function getjuggdamagescale( var0 )
{
    if ( !level.challengesallowed )
    {
        return;
    }
    
    var1 = scripts\mp\utility\weapon::getweapongroup( var0 );
    
    if ( !isdefined( var1 ) || !isdefined( level.showquestcircletoall[ var1 ] ) )
    {
        return;
    }
    
    if ( self.pers[ "headshotLongshotMask" ] & level.showquestcircletoall[ var1 ] )
    {
        return;
    }
    else
    {
        self.pers[ "headshotLongshotMask" ] = self.pers[ "headshotLongshotMask" ] | level.showquestcircletoall[ var1 ];
    }
    
    var2 = 0;
    
    foreach ( var4 in level.showquestcircletoall )
    {
        if ( self.pers[ "headshotLongshotMask" ] & var4 )
        {
            var2++;
            
            if ( var2 >= 5 )
            {
                self reportchallengeuserevent( "collect_item", "hsls_achievement" );
                break;
            }
        }
    }
}

// Params 0
// Size: 0x6f
function start_puzzle()
{
    if ( !level.challengesallowed )
    {
        return;
    }
    
    if ( self.ref_11f87 == -1 )
    {
        return;
    }
    
    self.ref_11f87++;
    var0 = undefined;
    
    switch ( level.mapname )
    {
        case "mp_m_speed":
        case "mp_shipment":
            var0 = 50;
            break;
        default:
            var0 = 30;
            break;
    }
    
    if ( self.ref_11f87 >= var0 )
    {
        self reportchallengeuserevent( "collect_item", "objective_player_achievement" );
        self.ref_11f87 = -1;
        return;
    }
}

// Params 1
// Size: 0xcb
function getgulagclosedcircleindex( var0 )
{
    self endon( "disconnect" );
    var1 = 0;
    
    if ( !level.challengesallowed || !isdefined( var0 ) )
    {
        self.ref_12a9a = undefined;
        return;
    }
    
    if ( isplayer( var0 ) && isdefined( self.ref_12a9a ) )
    {
        if ( self.modifiers[ "mask2" ] & 32768 )
        {
            var1 = 1;
        }
    }
    
    level scripts\engine\utility::ref_143b9( 1, "game_ended" );
    
    if ( level.gameended )
    {
        if ( var1 )
        {
            self reportchallengeuserevent( "collect_item", "recon_drone_achievement" );
            
            if ( isdefined( self.ref_12a9a ) )
            {
                self.ref_12a9a reportchallengeuserevent( "collect_item", "recon_drone_achievement" );
            }
        }
        
        if ( scripts\mp\utility\game::getgametype() == "br" && isdefined( level.£ßòN}4±çïõ;VVÏX±∫,:{‰ÃÍ‹ÿ ) )
        {
            var2 = spawnstruct();
            var2.player = self;
            self [[ level.£ßòN}4±çïõ;VVÏX±∫,:{‰ÃÍ‹ÿ ]]( "br_mastery_roundKillExecute", var2 );
        }
    }
    
    self.ref_12a9a = undefined;
}

