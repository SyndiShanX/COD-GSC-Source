
// Params 1
// Size: 0x1e2
function ref_134a3( var0 )
{
    self.spec = "soldier_" + getsubstr( self.agent_type, 12 );
    self allowedstances( "stand", "crouch" );
    self.dontmeleeme = 1;
    self.aggressivemode = 1;
    self.ignoresuppression = 1;
    self.disablepistol = 1;
    self.meleetryhard = 0;
    self.meleeignorefinalzdiff = 0;
    self.meleeignoreplayerstance = 1;
    self.dontsyncmelee = 1;
    self.disablebulletwhizbyreaction = 1;
    self.neversprintforvariation = 1;
    self.disabledodge = 1;
    self.disablelmgmount = 1;
    self.brking_getcirclepercentmoved = 1;
    self.combat_func_active = 1;
    self.clear_kill_off_flags_after_unload = 1;
    self.minpaindamage = 200;
    self.meleechargedistvsplayer = 120;
    self.meleechargedist = 120;
    self.meleemaxzdiff = 500;
    self.meleetargetallowedoffmeshdistsq = squared( 50 );
    self.ref_11bbf = 0.5;
    self.pathenemyfightdist = 192;
    self.runngun = 0;
    self.eliminate_drone_minigun_speed = 2000;
    self.eliminate_drone_internal = 100;
    self.ref_11e7e = 0;
    self.ref_1216e = squared( 730 );
    self.meleebashmaxdistsq = squared( 90 );
    self.inside_bush = 0;
    
    if ( getdvarint( "scr_ai_lw_br_cover_enabled", 0 ) == 1 )
    {
        self.combatmode = "cover";
    }
    else
    {
        self.combatmode = "no_cover";
    }
    
    if ( self.spec == "soldier_lw_br_rpg" )
    {
        self.disable_bomb_detonator_interactivity = 1;
        self.combatmode = "no_cover";
        self.ref_11ebe = 1;
        self allowedstances( "stand" );
        self.dontmelee = 1;
    }
    
    self.fnshouldplaypainanim = &ref_134ba;
    self.playerenemypool = &ref_13497;
    
    if ( isdefined( self.a ) )
    {
        self.a.disablelongdeath = 0;
    }
    
    scripts\engine\utility::set_movement_speed( 120 );
    ref_1328a();
    
    if ( !threatbiasgroupexists( "soldier_lw_br" ) )
    {
        createthreatbiasgroup( "soldier_lw_br" );
        setignoremegroup( "Lethal_Static", "soldier_lw_br" );
    }
    
    self setthreatbiasgroup( "soldier_lw_br" );
    self disableexecutionvictim();
    self method_87bc( gettime() + randomintrange( 1000, 2000 ) );
    
    if ( self isscriptable() )
    {
        thread initscriptable();
        return;
    }
}

// Params 0
// Size: 0x69
function ref_1328a()
{
    var0 = "iw8_ar_akilo47";
    
    if ( self.spec == "soldier_lw_br" )
    {
        if ( false )
        {
            var0 = "iw8_sn_kilo98";
        }
    }
    else if ( self.spec == "soldier_lw_br_rpg" )
    {
        var0 = "iw8_la_rpapa7";
    }
    
    var1 = scripts\mp\class::buildweapon( var0 );
    self.weapon = var1;
    self giveweapon( self.weapon );
    self setspawnweapon( self.weapon );
    self.bulletsinclip = weaponclipsize( self.weapon );
}

// Params 1
// Size: 0x7e
function ref_134b4( var0 )
{
    level notify( "an_enemy_shot", self );
    self.a.lastshoottime = gettime();
    ref_134af();
    self notify( "shooting" );
    
    if ( scripts\anim\utility_common::isasniper() && istrue( self._blackboard.shootparams_valid ) && isdefined( self._blackboard.shootparams_pos ) )
    {
        self shoot( 1, self._blackboard.shootparams_pos, 1, 0, 1 );
        return;
    }
    
    if ( isagent( self ) )
    {
        var0 = 1;
    }
    
    self shoot( 1, undefined, var0 );
}

// Params 0
// Size: 0x10f
function ref_134af()
{
    if ( scripts\anim\utility_common::isasniper() && isalive( self.enemy ) )
    {
        ref_134b2();
        return;
    }
    
    if ( isplayer( self.enemy ) )
    {
        scripts\common\gameskill::resetmissdebouncetime();
        
        if ( self.a.misstime > gettime() )
        {
            self.accuracy = 0;
            return;
        }
    }
    
    if ( isdefined( self.script ) && self.script == "move" )
    {
        if ( scripts\engine\utility::actor_is3d() && isdefined( self._blackboard.lastusednode ) && ( self._blackboard.lastusednode.type == "Exposed 3D" || self._blackboard.lastusednode.type == "Path 3D" ) )
        {
            self.accuracy = self.baseaccuracy;
            return;
        }
        
        if ( scripts\anim\utility::iscqbwalkingorfacingenemy() )
        {
            self.accuracy = anim.walk_accuracy * self.baseaccuracy;
            return;
        }
        
        self.accuracy = anim.run_accuracy * self.baseaccuracy;
        return;
    }
    
    self.accuracy = self.baseaccuracy;
    
    if ( isdefined( self.isrambo ) && isdefined( self.ramboaccuracymult ) )
    {
        self.accuracy *= self.ramboaccuracymult;
        return;
    }
}

// Params 0
// Size: 0xc2
function ref_134b2()
{
    if ( !isdefined( self.snipershotcount ) )
    {
        self.snipershotcount = 0;
        self.sniperhitcount = 0;
    }
    
    var0 = level.gameskill;
    
    if ( !isdefined( self.sniperaccuracyset ) )
    {
        self.sniperaccuracyset = 1;
        var1 = level.difficultysettings[ "sniperAccuDiffScale" ][ level.difficultytype[ var0 ] ];
        self.baseaccuracy = self.accuracy * var1;
    }
    
    self.snipershotcount++;
    
    if ( scripts\common\gameskill::shouldforcesnipermissshot() )
    {
        self.accuracy = 0;
        
        if ( var0 > 0 || self.snipershotcount > 1 )
        {
            self.lastmissedenemy = self.enemy;
        }
        
        return;
    }
    
    if ( self.accuracy <= 10 )
    {
        self.accuracy = ( 1 + 1 * self.sniperhitcount ) * self.baseaccuracy;
    }
    
    self.sniperhitcount++;
    
    if ( var0 < 1 && self.sniperhitcount == 1 )
    {
        self.lastmissedenemy = undefined;
        return;
    }
}

// Params 0
// Size: 0x12
function initscriptable()
{
    self setscriptablepartstate( "notetrack_handler", "active", 0 );
}

// Params 1
// Size: 0x22
function ref_134a5( var0 )
{
    scripts\aitypes\combat_mp::initcombatfunctions_mp( var0 );
    self.minexposedgrenadedist = 450;
    anim.shootenemywrapper_func = &ref_134b4;
    return anim.success;
}

// Params 2
// Size: 0x2e
function ref_1349f( var0, var1 )
{
    if ( !isdefined( self.grenadeweapon ) || self.grenadeweapon.basename != var0 )
    {
        self.grenadeweapon = getcompleteweaponname( var0 );
    }
    
    self.grenadeammo = var1;
}

// Params 0
// Size: 0x59
function ref_1349a()
{
    if ( self.ignoreall )
    {
        return undefined;
    }
    
    if ( isdefined( self.favoriteenemy ) && isalive( self.favoriteenemy ) && self.favoriteenemy.notarget != 1 )
    {
        return self.favoriteenemy;
    }
    
    if ( isdefined( self.enemy ) && self.enemy.notarget != 1 )
    {
        return self.enemy;
    }
    
    return undefined;
}

// Params 0
// Size: 0x17
function ref_1349e()
{
    if ( scripts\mp\trials\mp_t_reflex_create_script_quadrace::soldier_br_isalert() )
    {
        return "fast";
    }
    
    return "walk";
}

// Params 1
// Size: 0x10
function ref_134b1( var0 )
{
    if ( !isdefined( var0 ) )
    {
        return;
    }
    
    self.set_disable_leave_truck = var0;
}

// Params 2
// Size: 0x13
function ref_13496( var0, var1 )
{
    self.ref_11e7e = gettime() + randomintrange( var0, var1 );
}

// Params 1
// Size: 0x4d
function soldier_br_getnextpathnode( var0 )
{
    if ( var0.select_mid_roof_spawners == 4 )
    {
        self.inside_bush += 1;
        
        if ( self.ƒóóG@NxŸrà!w.size <= self.inside_bush )
        {
            self.inside_bush = 0;
        }
        
        return self.ƒóóG@NxŸrà!w[ self.inside_bush ];
    }
    
    return self.ƒóóG@NxŸrà!w[ self.inside_bush ];
}

// Params 1
// Size: 0xdf
function ref_1349c( var0 )
{
    var1 = self.goalradius * 0.66;
    var2 = [ var0.origin + ( 0.5, 0.5, 0 ) * var1, var0.origin + ( 0.5, -0.5, 0 ) * var1, var0.origin + ( -0.5, 0.5, 0 ) * var1, var0.origin + ( -0.5, -0.5, 0 ) * var1 ];
    var3 = [];
    
    foreach ( var5 in var2 )
    {
        var6 = getrandomnavpoint( var5, var1 * 0.5, self );
        
        if ( isdefined( var6 ) )
        {
            var3 = var6;
        }
    }
    
    if ( var3.size > 0 )
    {
        return var3[ randomint( var3.size ) ];
    }
    
    var6 = var0 getpointinbounds( randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ), 0 );
    return self getclosestreachablepointonnavmesh( var6 );
}

// Params 1
// Size: 0x1a4
function ref_1349b( var0 )
{
    if ( getdvarint( "scr_ai_lw_br_cover_enabled", 0 ) == 1 )
    {
        if ( isdefined( self.move_closest_chopper_boss_vandalize_node_down ) && self.move_closest_chopper_boss_vandalize_node_down )
        {
            self clearbtgoal( 0 );
            self forceupdategoalpos();
            self.keepclaimednode = 0;
            self.keepclaimednodeifvalid = 0;
            var1 = self findbestcoverlist();
            
            foreach ( var3 in var1 )
            {
                if ( self usecovernode( var3 ) )
                {
                    var0.select_mid_roof_spawners = 4;
                    return var3;
                }
            }
        }
    }
    
    var5 = var0.enemy;
    
    if ( !isdefined( var5 ) )
    {
        if ( isdefined( var0.select_mountain_three_spawners ) )
        {
            var0.select_mid_roof_spawners = 1;
            return ref_1349c( var0.select_mountain_three_spawners );
        }
        
        var0.select_mid_roof_spawners = 0;
        return self.origin;
    }
    
    if ( isdefined( var0.select_mountain_three_spawners ) && !self iswithinscriptgoalradius() )
    {
        var0.select_mid_roof_spawners = 1;
        return ref_1349c( var0.select_mountain_three_spawners );
    }
    
    var6 = var5.origin - self.origin;
    var7 = length2d( var6 );
    var8 = scripts\engine\utility::ter_op( var7 > 400, ( var7 - 400 ) / 330, 0 );
    var8 = clamp( var8, 0, 0.85 );
    
    if ( randomfloat( 1 ) < var8 )
    {
        var0.select_mid_roof_spawners = 3;
        return var5.origin;
    }
    
    if ( randomfloat( 1 ) < 0.66 )
    {
        var9 = vectortoangles( var6 );
        var10 = scripts\engine\utility::ter_op( randomfloat( 1 ) > 0.5, 1, -1 );
        var11 = self.origin + anglestoright( var9 ) * 150 * var10;
        var12 = getclosestpointonnavmesh( var11, self );
        var0.select_mid_roof_spawners = 2;
        return var12;
    }
    
    var8.select_mid_roof_spawners = 0;
    return self.origin;
}

// Params 1
// Size: 0x9
function ref_134a6( var0 )
{
    scripts\aitypes\cover::inithidetimers();
}

// Params 0
// Size: 0x4f, Type: bool
function ref_134ba()
{
    if ( !isdefined( self.a.paintime ) || !isdefined( self.eliminate_drone_internal ) || !isdefined( self.eliminate_drone_minigun_speed ) )
    {
        return true;
    }
    
    if ( gettime() - self.a.paintime < self.eliminate_drone_minigun_speed )
    {
        return false;
    }
    
    return randomfloat( 100 ) < self.eliminate_drone_internal;
}

// Params 1
// Size: 0x1a
function ref_134b5( var0 )
{
    if ( !isdefined( self.enemy ) )
    {
        return anim.success;
    }
    
    return scripts\aitypes\combat::shoot_update( var0 );
}

// Params 1
// Size: 0x8a
function ref_134a7( var0 )
{
    if ( !isdefined( self.weapon ) )
    {
        return anim.failure;
    }
    
    var1 = scripts\aitypes\combat::shouldshoot();
    
    if ( var1 )
    {
        var2 = isdefined( self.enemy ) && isdefined( self.enemy.vehicle ) && isdefined( self.enemy.vehicle.vehiclename );
        
        if ( var2 && istrue( self.dontgiveuponsuppression ) && isdefined( self.goodshootpos ) )
        {
            return anim.success;
        }
        
        var1 = scripts\aitypes\combat::calcgoodshootpos();
    }
    else
    {
        self.goodshootpos = undefined;
    }
    
    if ( !var1 )
    {
        return anim.failure;
    }
    
    return anim.success;
}

// Params 1
// Size: 0x5c, Type: bool
function ref_134b7( var0 )
{
    if ( istrue( self.disable_bomb_detonator_interactivity ) )
    {
        return false;
    }
    
    var1 = ref_1349a();
    
    if ( isdefined( var1 ) )
    {
        if ( !issentient( var1 ) )
        {
            return false;
        }
        
        if ( self lastknowntime( var1 ) <= 0 )
        {
            return false;
        }
    }
    
    if ( gettime() < self.ref_11e7e )
    {
        return false;
    }
    
    if ( isdefined( self.melee ) )
    {
        self.dmztut_endgame = gettime();
        return false;
    }
    
    if ( scripts\asm\asm_bb::bb_throwgrenaderequested() )
    {
        return false;
    }
    
    return true;
}

// Params 1
// Size: 0x7d
function ref_13492( var0 )
{
    var1 = ref_1349a();
    var2 = spawnstruct();
    var2.enemy = var1;
    var2.ref_11e71 = 0;
    var2.select_mountain_three_spawners = self getgoalvolume();
    var2.select_mid_roof_spawners = 0;
    
    if ( isdefined( self.ref_12eaf ) )
    {
        var2.goalpos = self.ref_12eaf;
        self setbtgoalpos( 0, var2.goalpos );
        self.ref_12eaf = undefined;
    }
    
    self aisettargetspeed( 120 );
    scripts\engine\utility::set_movement_speed( 120 );
    self.bt.instancedata[ var0 ] = var2;
}

// Params 1
// Size: 0x2ae
function ref_13491( var0 )
{
    var1 = self.bt.instancedata[ var0 ];
    var1.select_mountain_three_spawners = self getgoalvolume();
    var2 = ref_1349a();
    var3 = isdefined( self.dmztut_endgame ) && gettime() - self.dmztut_endgame < 1000;
    self clearbtgoal( 2 );
    
    if ( var3 || !isdefined( var2 ) )
    {
        self setbtgoalpos( 0, self.origin );
        self setbtgoalradius( 0, 35 );
        var1.select_mid_roof_spawners = 0;
        return anim.running;
    }
    
    var4 = gettime();
    
    if ( var4 >= var1.ref_11e71 )
    {
        var5 = !( isdefined( var2 ) && isdefined( var1.enemy ) && var2 == var1.enemy );
        var1.enemy = var2;
        
        if ( ( var5 || !self aipointinfov( var2.origin ) ) && var1.select_mid_roof_spawners != 4 )
        {
            ref_13496( 2000, 3000 );
            self setbtgoalpos( 0, self.origin );
            var1.select_mid_roof_spawners = 0;
            return anim.running;
        }
        
        var6 = self pathdisttogoal();
        var7 = ( var1.select_mid_roof_spawners == 2 || var1.select_mid_roof_spawners == 4 ) && var6 < 35;
        var8 = var1.select_mid_roof_spawners == 1 && var6 < 35;
        
        if ( var7 || var8 )
        {
            var1.select_mid_roof_spawners = 0;
            var1.goalpos = self.origin;
            ref_13496( 4000, 10000 );
        }
        
        var9 = var1.select_mid_roof_spawners == 3 && var6 <= 400;
        var10 = var1.select_mid_roof_spawners == 0 && var4 >= self.ref_11e7e;
        
        if ( var9 || var10 )
        {
            var1.goalpos = ref_1349b( var1 );
        }
        
        var1.ref_11e71 = var4 + 500;
    }
    
    var11 = isdefined( var2 ) && self cansee( var2 ) && self canshootenemy( 249, 1, 1 );
    
    if ( var11 )
    {
        self getenemyinfo( var2 );
    }
    
    var12 = isdefined( var2 ) && isdefined( var2.vehicle ) && isdefined( var2.vehicle.vehiclename );
    
    if ( var12 )
    {
        self.dontgiveuponsuppression = 1;
        self.goodshootpos = var2 getshootatpos();
    }
    else
    {
        self.dontgiveuponsuppression = 0;
    }
    
    if ( !isdefined( var1.goalpos ) )
    {
        var1.goalpos = self.origin;
        var1.select_mid_roof_spawners = 0;
    }
    
    if ( var1.select_mid_roof_spawners != 4 )
    {
        if ( !self iswithinscriptgoalradius( var1.goalpos ) )
        {
            var1.goalpos = self getplayerip( var1.goalpos );
            var1.goalpos = self getclosestreachablepointonnavmesh( var1.goalpos );
        }
        
        self setbtgoalpos( 0, var1.goalpos );
    }
    else
    {
        self.ref_11ebe = 1;
        self.keepclaimednode = 0;
        self.keepclaimednodeifvalid = 0;
        self usecovernode( var1.goalpos, 0 );
    }
    
    self aisettargetspeed( 120 );
    scripts\engine\utility::set_movement_speed( 120 );
    return anim.running;
}

// Params 1
// Size: 0x44
function ref_13493( var0 )
{
    self.bt.instancedata[ var0 ] = undefined;
    
    if ( scripts\asm\asm_bb::bb_throwgrenaderequested() )
    {
        self.ref_12eaf = self.goalpos;
        self setbtgoalpos( 0, self.origin );
    }
    
    self clearpath();
    scripts\common\utility::demeanor_override( "combat" );
    self.moveplaybackrate = 1;
}

// Params 1
// Size: 0x4
function ref_13494( var0 )
{
    
}

// Params 0
// Size: 0x75
function soldier_br_patrolstartlelistener()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "soldier_br_patrolend" );
    self waittill( "ai_events", var0 );
    
    for ( var1 = 0; var1 < var0.size ; var1++ )
    {
        var2 = var0[ var1 ];
        
        switch ( var2.type )
        {
            case "gunshot":
            case "grenade danger":
            case "bulletwhizby":
            case "explode":
                self asmsetstate( self.asmname, "patrol_startled" );
                return;
        }
    }
}

// Params 1
// Size: 0x1c, Type: bool
function ref_134b9( var0 )
{
    if ( istrue( self.disable_bomb_detonator_interactivity ) )
    {
        return false;
    }
    
    if ( !isdefined( self getgoalvolume() ) )
    {
        return false;
    }
    
    return true;
}

// Params 1
// Size: 0x8a
function ref_134aa( var0 )
{
    var1 = spawnstruct();
    var1.select_mountain_three_spawners = self getgoalvolume();
    var1.goalpos = self.origin;
    var1.select_mid_roof_spawners = 0;
    
    if ( !ispointinvolume( self getapproxeyepos(), var1.select_mountain_three_spawners ) )
    {
        var1.goalpos = self getclosestreachablepointonnavmesh( var1.select_mountain_three_spawners.origin );
        var1.ref_11e7c = var1.goalpos;
        var1.select_mid_roof_spawners = 1;
    }
    
    if ( !scripts\mp\trials\mp_t_reflex_create_script_quadrace::soldier_br_isalert() )
    {
        thread soldier_br_patrolstartlelistener();
    }
    
    self.bt.instancedata[ var0 ] = var1;
}

// Params 1
// Size: 0x6f
function soldier_br_findnextpatrolgoalpos( var0 )
{
    if ( isdefined( self.ƒóóG@NxŸrà!w ) )
    {
        var0.ref_11e7c = soldier_br_getnextpathnode( var0 );
        var0.ŠWÈRãÅÀ-‘1¬–`g = 4;
        
        if ( !isdefined( var0.ref_11e7c ) )
        {
            var0.ref_11e7c = ref_1349c( var0.select_mountain_three_spawners );
            var0.ŠWÈRãÅÀ-‘1¬–`g = 2;
            return;
        }
        
        return;
    }
    
    var0.ref_11e7c = ref_1349c( var0.select_mountain_three_spawners );
    var0.ŠWÈRãÅÀ-‘1¬–`g = 2;
}

// Params 1
// Size: 0x1ba
function ref_134a9( var0 )
{
    var1 = self.bt.instancedata[ var0 ];
    var2 = var1.select_mid_roof_spawners;
    var3 = ref_1349a();
    
    if ( isdefined( var3 ) )
    {
        ref_13496( 2000, 3000 );
        self setbtgoalpos( 0, self.origin );
        self getenemyinfo( var3 );
        return anim.success;
    }
    
    var4 = self pathdisttogoal();
    var5 = var2 == 1 && var4 < 35;
    var6 = ( var2 == 2 || var1.select_mid_roof_spawners == 4 ) && var4 <= 35;
    
    if ( var5 || var6 )
    {
        soldier_br_findnextpatrolgoalpos( var1 );
        
        if ( var2 == 2 || var2 == 4 )
        {
            ref_13496( 4500, 10000 );
            var1.select_mid_roof_spawners = 0;
        }
    }
    
    if ( isdefined( var1.ref_11e7c ) )
    {
        self.smartfacingpos = var1.ref_11e7c;
    }
    
    var7 = var1.select_mid_roof_spawners == 0 && gettime() > self.ref_11e7e;
    
    if ( ( var5 || var7 ) && isdefined( var1.ref_11e7c ) )
    {
        var1.goalpos = var1.ref_11e7c;
        var1.select_mid_roof_spawners = var1.ŠWÈRãÅÀ-‘1¬–`g;
        var1.ref_11e7c = undefined;
        var1.ŠWÈRãÅÀ-‘1¬–`g = undefined;
    }
    else if ( var7 && !isdefined( var1.ref_11e7c ) )
    {
        soldier_br_findnextpatrolgoalpos( var1 );
        var1.goalpos = var1.ref_11e7c;
        var1.select_mid_roof_spawners = var1.ŠWÈRãÅÀ-‘1¬–`g;
        var1.ref_11e7c = undefined;
        var1.ŠWÈRãÅÀ-‘1¬–`g = undefined;
    }
    
    if ( var1.select_mid_roof_spawners == 1 || var1.select_mid_roof_spawners == 2 || var1.select_mid_roof_spawners == 4 )
    {
        self setbtgoalpos( 0, var1.goalpos );
    }
    else
    {
        self setbtgoalpos( 0, self.origin );
    }
    
    self aisettargetspeed( 120 );
    scripts\engine\utility::set_movement_speed( 120 );
    return anim.running;
}

// Params 1
// Size: 0x48
function ref_134ab( var0 )
{
    var1 = self.bt.instancedata[ var0 ];
    self notify( "soldier_br_patrolend" );
    
    if ( isdefined( ref_1349a() ) )
    {
        if ( scripts\asm\asm_bb::bb_throwgrenaderequested() )
        {
            self setbtgoalpos( 0, self.origin );
        }
        
        self.ref_11e7e = 0;
    }
    
    self.bt.instancedata[ var0 ] = undefined;
}

// Params 1
// Size: 0x4
function ref_13495( var0 )
{
    
}

// Params 0
// Size: 0x1b
function ref_134b0()
{
    self.bt.getbunkernamefromkeypadscriptableinstance = gettime() + randomintrange( 2000, 10000 );
}

// Params 1
// Size: 0x8d
function ref_134b6( var0 )
{
    if ( !isdefined( self.bt.getbunkernamefromkeypadscriptableinstance ) )
    {
        ref_134b0();
    }
    
    if ( isdefined( self.ref_11ebe ) )
    {
        if ( self.currentpose != "stand" )
        {
            return anim.success;
        }
        else
        {
            return anim.failure;
        }
    }
    
    if ( self.currentpose != "stand" && scripts\asm\asm_bb::bb_meleerequested() )
    {
        return anim.success;
    }
    
    if ( self pathdisttogoal() > self.goalradius )
    {
        return anim.failure;
    }
    
    if ( gettime() < self.bt.getbunkernamefromkeypadscriptableinstance )
    {
        return anim.failure;
    }
    
    return anim.success;
}

// Params 1
// Size: 0x49
function ref_134a4( var0 )
{
    var1 = undefined;
    
    if ( self.currentpose != "crouch" || scripts\asm\asm_bb::bb_getrequestedstance() != "crouch" )
    {
        var1 = "crouch";
    }
    else
    {
        var1 = "stand";
    }
    
    if ( isdefined( self.ref_11ebe ) )
    {
        var1 = "stand";
    }
    
    scripts\asm\asm_bb::bb_requeststance( var1 );
}

// Params 1
// Size: 0x54
function ref_13486( var0 )
{
    if ( scripts\asm\asm::asm_ephemeraleventfired( "cover_stance_trans", "end" ) )
    {
        return anim.success;
    }
    
    var1 = 5000;
    
    if ( gettime() - self.bt.getbunkernamefromkeypadscriptableinstance > var1 )
    {
        return anim.success;
    }
    
    if ( self.currentpose == scripts\asm\asm_bb::bb_getrequestedstance() )
    {
        return anim.success;
    }
    
    return anim.running;
}

// Params 1
// Size: 0x14
function ref_134be( var0 )
{
    scripts\asm\asm_bb::bb_requeststance( self.currentpose );
    ref_134b0();
}

// Params 1
// Size: 0x3d
function ref_134c0( var0 )
{
    scripts\asm\asm_bb::bb_requestthrowgrenade( 1, self.enemy );
    self.bt.instancedata[ var0 ] = spawnstruct();
    self.bt.instancedata[ var0 ].timeout = gettime() + 6000;
}

// Params 1
// Size: 0x2b
function ref_134c1( var0 )
{
    scripts\asm\asm_bb::bb_requestthrowgrenade( 0 );
    self.bt.instancedata[ var0 ] = undefined;
    self.a.nextgrenadetrytime = gettime() + 3000;
}

// Params 1
// Size: 0xa5
function ref_13485( var0 )
{
    if ( self.arriving )
    {
        return anim.failure;
    }
    
    if ( nullweapon( self.grenadeweapon ) )
    {
        return anim.failure;
    }
    
    if ( isdefined( self.playerpackdataintoomnvar ) )
    {
        if ( scripts\aitypes\throwgrenade::grenadethrowvaliditycheck( level.player, 200 ) )
        {
            return anim.success;
        }
    }
    
    if ( isdefined( self.enemy ) && isdefined( self.enemy.dontgrenademe ) && self.enemy.dontgrenademe )
    {
        return anim.failure;
    }
    
    if ( istrue( self.dontevershoot ) )
    {
        return anim.failure;
    }
    
    if ( isdefined( self.enemy ) && scripts\aitypes\throwgrenade::grenadethrowvaliditycheck( self.enemy, self.minexposedgrenadedist ) )
    {
        return anim.success;
    }
    
    return anim.failure;
}

// Params 1
// Size: 0x37
function ref_13481( var0 )
{
    var1 = self getposoutsidebadplace( 128 );
    
    if ( isdefined( var1 ) )
    {
        self setbtgoalpos( 2, var1 );
        self._blackboard.badplaceavoidstarttime = gettime();
        return anim.success;
    }
    
    return anim.failure;
}

// Params 1
// Size: 0x6c, Type: bool
function ref_13482( var0 )
{
    if ( istrue( var0.hasriotshield ) )
    {
        var1 = self.origin - var0.origin;
        var1 = vectornormalize( ( var1[ 0 ], var1[ 1 ], 0 ) );
        var2 = anglestoforward( var0.angles );
        var3 = vectordot( var2, var1 );
        
        if ( !isdefined( var0.riotshieldmodelstowed ) )
        {
            if ( var3 > 0.766 )
            {
                return true;
            }
        }
        else if ( var3 < -0.766 )
        {
            return true;
        }
    }
    
    return false;
}

// Params 1
// Size: 0xfd
function ref_13497( var0 )
{
    var1 = undefined;
    
    if ( istrue( self.clear_kill_off_flags_after_unload ) )
    {
        var2 = [];
        GscBinSkip0( 0x2e, 0, self );
        // Unknown operator ( 0x2e, iw8, PC )
    }
    
    if ( isenemyinfrontofme( var1, self.ref_11bbf ) || unset_force_aitype_rpg( var1 ) )
    {
        var2 = var1;
    }
    
    if ( isdefined( var2 ) && isalive( var2 ) )
    {
        var7 = 30;
        
        if ( isdefined( self.meleedamageoverride ) )
        {
            var7 = self.meleedamageoverride;
        }
        else if ( nullweapon( self.weapon ) )
        {
            var7 = self.unarmedmeleedamageoverride;
        }
        
        if ( ref_13482( var2 ) )
        {
            return undefined;
        }
        
        if ( isplayer( var2 ) && var2 scripts\common\utility::isprotectedbyaxeblock( self ) )
        {
            return undefined;
        }
        
        var2 dodamage( var7, self.origin, self, self, "MOD_MELEE", self.weapon );
        return var2;
    }
    
    return undefined;
}

// Params 2
// Size: 0x3a, Type: bool
function isenemyinfrontofme( var0, var1 )
{
    var2 = vectornormalize( ( var0.origin - self.origin ) * ( 1, 1, 0 ) );
    var3 = anglestoforward( self.angles );
    var4 = vectordot( var2, var3 );
    return var4 > var1;
}

// Params 1
// Size: 0xad, Type: bool
function unset_force_aitype_rpg( var0 )
{
    var1 = self.origin[ 2 ] + self.height;
    
    if ( var0.origin[ 2 ] < var1 )
    {
        return false;
    }
    
    var2 = self.origin[ 2 ] + self.height + 2 * self.radius;
    
    if ( var0.origin[ 2 ] > var2 )
    {
        return false;
    }
    
    if ( isplayer( var0 ) )
    {
        var3 = var0 getvelocity()[ 2 ];
        
        if ( abs( var3 ) > 12 )
        {
            return false;
        }
    }
    
    var4 = 15;
    
    if ( isdefined( var0.radius ) )
    {
        var4 = var0.radius;
    }
    
    var5 = self.radius + var4;
    var5 *= var5;
    
    if ( distance2dsquared( self.origin, var0.origin ) > var5 )
    {
        return false;
    }
    
    return true;
}

// Params 1
// Size: 0x2d
function ref_13498( var0 )
{
    if ( getdvarint( "scr_br_ai_spawnPerformance", 0 ) == 0 )
    {
        return anim.failure;
    }
    
    if ( istrue( self.hasplayedvignetteanim ) )
    {
        return anim.failure;
    }
    
    return anim.running;
}

// Params 1
// Size: 0x19
function ref_13487( var0 )
{
    if ( !istrue( self.scripted_mode ) )
    {
        return anim.failure;
    }
    
    return anim.running;
}

