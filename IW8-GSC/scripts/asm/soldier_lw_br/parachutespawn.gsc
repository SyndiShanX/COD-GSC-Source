
// Params 3
// Size: 0x6f
function soldier_br_spawnparatrooper( var0, var1, var2 )
{
    var3 = randomint( 360 );
    var4 = getdvarint( "scr_br_ai_parachuteSpawnRadius", 1000 );
    self.•â‚kóÀ1†g”'ï = getdvarint( "scr_br_ai_parachuteDropHeight", 12000 );
    var5 = ( cos( var3 ) * var4, sin( var3 ) * var4, self.•â‚kóÀ1†g”'ï );
    self setorigin( self.origin + var5, 1 );
    var6 = vectortoangles( self.¥ásòÍ¡–qAíh0# - self.origin );
    self setplayerangles( ( 0, var6[ 1 ], 0 ) );
    thread soldier_br_startparatrooper();
}

// Params 0
// Size: 0x2d
function soldier_br_startparatrooper()
{
    self endon( "death" );
    thread soldier_br_parachute_watchfordeath();
    soldier_br_parachute_setspawnvalues();
    soldier_br_parachute_getpath();
    soldier_br_parachute_skydive();
    soldier_br_parachute_spawn();
    soldier_br_parachute_deploy();
    soldier_br_parachute_idle();
}

// Params 0
// Size: 0x68
function soldier_br_parachute_setspawnvalues()
{
    self allowedstances( "stand" );
    self.ΩÎ6€"p≥ÄøOp©>™ç≈›œ = self.ignoreme;
    self.ignoreme = 1;
    self.é·8‰¨l’é≤˙Kvõ∑N¨,∆c = self.ignoreall;
    self.ignoreall = 1;
    self.scripted_mode = 1;
    self.playing_skit = 1;
    self.do_immediate_ragdoll = 1;
    self asmsetstate( self.asmname, "parachute_freefall" );
    self._blackboard.ref_121d3 = "freefall";
    self show();
}

// Params 0
// Size: 0x44
function soldier_br_parachute_getpath()
{
    self endon( "death" );
    var0 = ( self.origin - self.¥ásòÍ¡–qAíh0# ) / 5;
    self.™ˆ≤Å8…í´sC?C:	hH+ = min( 1500, self.•â‚kóÀ1†g”'ï - 50 );
    self.skydive_dest = self.¥ásòÍ¡–qAíh0# + ( var0[ 0 ], var0[ 1 ], self.™ˆ≤Å8…í´sC?C:	hH+ );
}

// Params 0
// Size: 0x80
function soldier_br_parachute_skydive()
{
    self endon( "death" );
    self.anchor = spawn( "script_origin", self.origin );
    self.anchor.angles = ( self.angles[ 0 ], self.angles[ 1 ], 0 );
    self linkto( self.anchor );
    var0 = ( self.•â‚kóÀ1†g”'ï - self.™ˆ≤Å8…í´sC?C:	hH+ ) * 12 / 10500;
    var1 = max( var0 + randomfloatrange( -2, 2 ), 5 + randomfloat( 2 ) );
    self.anchor moveto( self.skydive_dest, var1 );
    wait var1 - 5;
}

// Params 0
// Size: 0x63
function soldier_br_parachute_spawn()
{
    var0 = spawn( "script_model", self gettagorigin( "j_spine4" ) );
    var0.angles = self gettagangles( "j_spine4" );
    var0 setmodel( "misc_wm_parachute_mercenary_extraction" );
    var0 linkto( self, "j_spine4", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    self.chute = var0;
    thread soldier_br_parachute_unlinkonaideath( var0 );
}

// Params 0
// Size: 0x36
function soldier_br_parachute_deploy()
{
    self.chute scriptmodelplayanim( "sdr_com_parachute_pullcord" );
    self._blackboard.ref_121d3 = "parachuting";
    self asmsetstate( self.asmname, "parachute_deploy" );
    thread soldier_br_parachute_delayeventfired();
}

// Params 0
// Size: 0xe
function soldier_br_parachute_idle()
{
    thread soldier_br_parachute_move();
    thread soldier_br_parachute_idleinternal();
}

// Params 0
// Size: 0x1d
function soldier_br_parachute_idleinternal()
{
    self endon( "death" );
    wait 1.5;
    self.chute scriptmodelplayanim( "sdr_com_parachute_idle" );
}

// Params 0
// Size: 0x7e
function soldier_br_parachute_move()
{
    self endon( "death" );
    var0 = max( self.™ˆ≤Å8…í´sC?C:	hH+ * 6 / 1500, 5 );
    self.anchor moveto( self.¥ásòÍ¡–qAíh0#, var0, var0 / 2, var0 / 2 );
    wait var0 - 1.5;
    self._blackboard.ref_121d3 = "landing";
    self.chute scriptmodelplayanim( "sdr_com_parachute_prepare_for_landing" );
    wait 3.4;
    self.chute delete();
    self.chute notify( "parachute_detached" );
    thread soldier_br_parachute_dolanding();
}

// Params 0
// Size: 0xb9
function soldier_br_parachute_dolanding()
{
    self endon( "death" );
    self.anchor.origin = self.¥ásòÍ¡–qAíh0#;
    self unlink();
    self setplayerangles( ( 0, self.anchor.angles[ 1 ], 0 ) );
    
    if ( isdefined( self.anchor ) )
    {
        self.anchor delete();
    }
    
    self allowedstances( "prone", "stand", "crouch" );
    self.playing_skit = undefined;
    self.ignoreall = self.é·8‰¨l’é≤˙Kvõ∑N¨,∆c;
    self.é·8‰¨l’é≤˙Kvõ∑N¨,∆c = undefined;
    self.ignoreme = self.ΩÎ6€"p≥ÄøOp©>™ç≈›œ;
    self.ΩÎ6€"p≥ÄøOp©>™ç≈›œ = undefined;
    self.scripted_mode = 0;
    self.¨Èú„€òé0Pxã≤’« = 0;
    self.hasplayedvignetteanim = 1;
    self notify( "delete_chute" );
    wait 0.1;
    self.do_immediate_ragdoll = undefined;
    self._blackboard.ref_121d3 = "done";
}

// Params 1
// Size: 0x24
function soldier_br_parachute_setlandingpointbycoord( var0 )
{
    self.¥ásòÍ¡–qAíh0# = getgroundposition( var0 + ( 0, 0, 128 ), 64 );
    self.¨Èú„€òé0Pxã≤’« = 1;
}

// Params 1
// Size: 0x2a
function soldier_br_parachute_setlandingpointbystruct( var0 )
{
    self.¥ásòÍ¡–qAíh0# = getgroundposition( var0.origin + ( 0, 0, 128 ), 64 );
    self.¨Èú„€òé0Pxã≤’« = 1;
}

// Params 4
// Size: 0x1e, Type: bool
function soldier_br_shouldparachutespawn( var0, var1, var2, var3 )
{
    if ( getdvarint( "scr_br_ai_parachuteSpawn", 0 ) == 0 )
    {
        return false;
    }
    
    return istrue( self.¨Èú„€òé0Pxã≤’« );
}

// Params 0
// Size: 0x24
function soldier_br_parachute_watchfordeath()
{
    self endon( "parachute_detached" );
    self waittill( "death" );
    
    if ( isdefined( self.anchor ) )
    {
        self.anchor delete();
        return;
    }
}

// Params 4
// Size: 0x24, Type: bool
function soldier_br_parachute_transitionstate( var0, var1, var2, var3 )
{
    return isdefined( self._blackboard.ref_121d3 ) && self._blackboard.ref_121d3 == var3;
}

// Params 0
// Size: 0x1e
function soldier_br_parachute_delayeventfired()
{
    self endon( "death" );
    wait 3.5;
    self asmfireevent( self.asmname, "finish" );
}

// Params 1
// Size: 0x29
function soldier_br_parachute_unlinkonaideath( var0 )
{
    self endon( "death" );
    var0 waittill( "death" );
    self unlink();
    self movez( 100, 2 );
    wait 2;
    self delete();
}

// Params 3
// Size: 0x49
function soldier_br_parachute_playanimstate( var0, var1, var2 )
{
    self endon( var1 + "_finished" );
    var3 = scripts\asm\asm::asm_getanim( var0, var1 );
    self aisetanim( var1, var3 );
    var4 = scripts\asm\asm::asm_donotetracks( var0, var1, scripts\asm\asm::asm_getnotehandler( var0, var1 ) );
    
    if ( var4 == "code_move" )
    {
        var4 = scripts\asm\asm::asm_donotetracks( var0, var1, scripts\asm\asm::asm_getnotehandler( var0, var1 ) );
        return;
    }
}

