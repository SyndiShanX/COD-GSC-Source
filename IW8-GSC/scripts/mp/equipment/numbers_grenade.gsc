
// Params 0
// Size: 0x55
function init()
{
    level._effect[ "vfx_numbers_trail" ] = loadfx( "vfx/iw8_br/island/equip/numb3rs_explosion/vfx_numb3rs_scrnfx_trail.vfx" );
    level._effect[ "vfx_numbers_zombie_explosion" ] = loadfx( "vfx/iw8_br/gameplay/zombie_ai/vfx_zai_explode_death.vfx" );
    game[ "dialog" ][ "numbers_grenade_assist" ] = "numbers_victim_killed";
    level.sê[¬97}ÙÉY›#Ê = spawnstruct();
    init_dvars();
    scripts\mp\utility\sound::besttime( "br_numbers_grenade" );
}

// Params 0
// Size: 0x172
function init_dvars()
{
    level.sê[¬97}ÙÉY›#Ê.«O	Ì×“X#Òê7 = getdvarfloat( "scr_br_numbers_grenade_radius", 452 );
    level.sê[¬97}ÙÉY›#Ê.–İ3ënèês×‘ºœ£–Ûæ = getdvarfloat( "scr_br_numbers_grenade_stun_duration", 2 );
    level.sê[¬97}ÙÉY›#Ê.’…êf½0mÎïqhR_İØòò = getdvarfloat( "scr_br_numbers_grenade_debuff_duration", 8 );
    level.sê[¬97}ÙÉY›#Ê.¢iQş{F'ŞŒu³9£+ˆª•½ = getdvarfloat( "scr_br_numbers_grenade_ai_effect_duration", 15 );
    level.sê[¬97}ÙÉY›#Ê.¡8ƒù_Ú·[yt·¦ç)ÿk§Õ¸Rö = getdvarfloat( "scr_br_numbers_grenade_ai_stagger_duration", 5 );
    level.sê[¬97}ÙÉY›#Ê.±NsWÚÈø—1˜ÄŠ3?ÇÇ = getdvarfloat( "scr_br_numbers_grenade_zombie_delay_min", 2 );
    level.sê[¬97}ÙÉY›#Ê.¸NšÂ¿]Ã}á%Ïë¢’š = getdvarfloat( "scr_br_numbers_grenade_zombie_delay_max", 4 );
    level.sê[¬97}ÙÉY›#Ê.Œ¢’áyáŠxØ)9Ğà_2ß^¿B = getdvarint( "scr_br_numbers_grenade_canceled_by_adrenaline", 1 );
    level.sê[¬97}ÙÉY›#Ê.‡@£/w@ÖßË¾CÒƒœÙÎg5¬ = getdvarint( "scr_br_numbers_grenade_decoy_ping_count", 5 );
    level.sê[¬97}ÙÉY›#Ê.º¹5§ïØ^Ws6ÛZ{QÄşi»Ó0 = getdvarfloat( "scr_br_numbers_grenade_decoy_ping_interval", 2 );
    level.sê[¬97}ÙÉY›#Ê.‹5zÕ÷
HÃo °KQ'Õ+ = getdvarint( "scr_br_numbers_grenade_decoy_ping_radius", 4000 );
    level.sê[¬97}ÙÉY›#Ê.º>v c«İÇ z1—ûèüØéÇ%ëØ	£XcÍ = getdvarfloat( "scr_br_numbers_grenade_shock_interrupt_delay_trim", 2.7 );
    level.sê[¬97}ÙÉY›#Ê.ƒ¯¡¹ĞÍšÿm[W2—
‰Ùy¸ = getdvarfloat( "scr_br_numbers_grenade_stun_resist_scalar", 0.5 );
    level.sê[¬97}ÙÉY›#Ê.‹=u—EûÅóä.ƒÚ+ÂÃ—¾àñ"k = getdvarfloat( "scr_br_numbers_grenade_debuff_resist_scalar", 0.5 );
    level.sê[¬97}ÙÉY›#Ê.„ÒºÑëúï0®dWG[OÂoØBRğIµ‡ˆ = 1000 * getdvarint( "scr_br_numbers_grenade_assist_quip_cooldown", 60 );
}

// Params 1
// Size: 0xf7
function numbers_grenade_used( var0 )
{
    self endon( "disconnect" );
    var0 endon( "explode_end" );
    var0 thread scripts\mp\utility\script::notifyafterframeend( "death", "explode_end" );
    var0 waittill( "explode", var1 );
    
    if ( isdefined( var0.¦PñYm8œ¿böÊ‡KÀB£ ) )
    {
        var2 = create_decoy_ping_data( var0.¦PñYm8œ¿böÊ‡KÀB£, var1, level.sê[¬97}ÙÉY›#Ê.’…êf½0mÎïqhR_İØòò );
        thread decoy_ping_group( level );
        
        foreach ( var4 in var0.¦PñYm8œ¿böÊ‡KÀB£ )
        {
            thread player_effect( var4, var2 );
        }
    }
    
    var6 = getaiarrayinradius( var1, level.sê[¬97}ÙÉY›#Ê.«O	Ì×“X#Òê7 );
    
    foreach ( var8 in var6 )
    {
        var9 = var8 geteye();
        
        if ( istrue( var8.ref_14693 ) )
        {
            thread zombie_effect( var8 );
            continue;
        }
        
        thread ai_effect( var8 );
    LOC_000000ea:
    }
}

// Params 1
// Size: 0x5c, Type: bool
function on_player_damaged( var0 )
{
    if ( var0.meansofdeath == "MOD_IMPACT" )
    {
        return true;
    }
    
    if ( !isdefined( var0.inflictor ) )
    {
        return false;
    }
    
    var1 = var0.inflictor;
    
    if ( !isdefined( var1.¦PñYm8œ¿böÊ‡KÀB£ ) )
    {
        var1.¦PñYm8œ¿böÊ‡KÀB£ = [];
    }
    
    var1.¦PñYm8œ¿böÊ‡KÀB£[ var1.¦PñYm8œ¿böÊ‡KÀB£.size ] = var0.victim;
    return true;
}

// Params 2
// Size: 0x137
function player_effect( var0, var1 )
{
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    
    if ( istrue( self.ª]ò €Z?#ºp“ÒŞ}jM)K ) )
    {
        self notify( "numbers_debuff_end_early" );
        waitframe();
    }
    
    self endon( "numbers_debuff_end_early" );
    thread player_effect_end_watcher( var0, var1 );
    
    if ( level.sê[¬97}ÙÉY›#Ê.Œ¢’áyáŠxØ)9Ğà_2ß^¿B )
    {
        GscBinSkip4( 0x35 );
        // Unknown operator ( 0x35, iw8, PC )
    }
    
    var2 = scripts\mp\utility\perk::_hasperk( "specialty_tac_resist" );
    var3 = scripts\engine\utility::ter_op( var2, level.sê[¬97}ÙÉY›#Ê.ƒ¯¡¹ĞÍšÿm[W2—
‰Ùy¸, 1 );
    var4 = level.sê[¬97}ÙÉY›#Ê.–İ3ënèês×‘ºœ£–Ûæ * var3;
    
    if ( var4 > 0 )
    {
        scripts\cp_mp\utility\shellshock_utility::_shellshock( "numbers_grenade_mp", "stun", var4, 1, calculate_interrupt_delay( var4 ) );
        self.ƒÁLúCnësºÚ&¬“Í¾nº7 = 1;
    }
    
    var5 = scripts\mp\utility\perk::_hasperk( "specialty_tac_resist" );
    var6 = scripts\engine\utility::ter_op( var5, level.sê[¬97}ÙÉY›#Ê.‹=u—EûÅóä.ƒÚ+ÂÃ—¾àñ"k, 1 );
    var7 = level.sê[¬97}ÙÉY›#Ê.’…êf½0mÎïqhR_İØòò * var6;
    thread scripts\mp\gamescore::trackdebuffassistfortime( var1, self, "numbers_grenade_mp", var7, "numbers_debuff_end_early" );
    thread player_death_watcher( var1 );
    self playlocalsound( "dx_bra_bchr_numbers_ambient_sfx" );
    self setscriptablepartstate( "headVFX", "numbersVision" );
    self setscriptablepartstate( "headSFX", "numbers_loop" );
    self.ª]ò €Z?#ºp“ÒŞ}jM)K = 1;
    wait var4;
    remove_stun();
    wait var7 - var4;
    remove_debuff();
    self notify( "numbers_debuff_end" );
}

// Params 0
// Size: 0x12
function adrenaline_watcher()
{
    self waittill( "force_regeneration" );
    self notify( "numbers_debuff_end_early" );
}

// Params 1
// Size: 0x60
function player_death_watcher( var0 )
{
    self endon( "numbers_debuff_end" );
    self endon( "numbers_debuff_end_early" );
    self waittill( "death" );
    
    if ( !isdefined( var0.‡¾îkè¶ûi³x;•mÿˆfç_ ) || gettime() - var0.‡¾îkè¶ûi³x;•mÿˆfç_ > level.sê[¬97}ÙÉY›#Ê.„ÒºÑëúï0®dWG[OÂoØBRğIµ‡ˆ )
    {
        var0.‡¾îkè¶ûi³x;•mÿˆfç_ = gettime();
        level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward( "numbers_grenade_assist", var0, 1, 0.5 );
        return;
    }
}

// Params 0
// Size: 0x18
function remove_stun()
{
    if ( self.ƒÁLúCnësºÚ&¬“Í¾nº7 )
    {
        scripts\cp_mp\utility\shellshock_utility::_stopshellshock( 0 );
        self.ƒÁLúCnësºÚ&¬“Í¾nº7 = 0;
        return;
    }
}

// Params 0
// Size: 0x39
function remove_debuff()
{
    if ( self.ª]ò €Z?#ºp“ÒŞ}jM)K )
    {
        self stoplocalsound( "dx_bra_bchr_numbers_ambient_sfx" );
        self setscriptablepartstate( "headVFX", "neutral" );
        self setscriptablepartstate( "headSFX", "numbers_fade" );
        self.ª]ò €Z?#ºp“ÒŞ}jM)K = 0;
        return;
    }
}

// Params 1
// Size: 0x68
function decoy_ping_group( var0 )
{
    self endon( "death_or_disconnect" );
    var1 = gettime() + var0.¾–í_b¸Q+¨Õ * 1000;
    
    while ( var0.–ß
Oñó+z;ÿõĞ.size > 0 && gettime() < var1 )
    {
        function_0443( var0.¾W	g¾ŞÉ´v¥¹, var0.–ß
Oñó+z;ÿõĞ, level.sê[¬97}ÙÉY›#Ê.‡@£/w@ÖßË¾CÒƒœÙÎg5¬, level.sê[¬97}ÙÉY›#Ê.‹5zÕ÷
HÃo °KQ'Õ+ );
        wait level.sê[¬97}ÙÉY›#Ê.º¹5§ïØ^Ws6ÛZ{QÄşi»Ó0;
    }
}

// Params 2
// Size: 0x3e
function player_effect_end_watcher( var0, var1 )
{
    scripts\engine\utility::ref_143a6( "death_or_disconnect", "numbers_debuff_end_early", "numbers_debuff_end" );
    
    if ( isdefined( var0 ) )
    {
        var0.–ß
Oñó+z;ÿõĞ = scripts\engine\utility::array_remove( var0.–ß
Oñó+z;ÿõĞ, self );
    }
    
    remove_debuff();
    remove_stun();
}

// Params 1
// Size: 0xa6
function ai_effect( var0 )
{
    self endon( "death" );
    level endon( "game_ended" );
    
    if ( istrue( self.ª]ò €Z?#ºp“ÒŞ}jM)K ) )
    {
        self endon( "numbers_debuff_end_early" );
        remove_ai_effect();
    }
    
    self endon( "numbers_debuff_end_early" );
    self.†›×Üº¶L¬NÜëöœZÒÍ±×¬,­ = self.team;
    self.ª]ò €Z?#ºp“ÒŞ}jM)K = 1;
    scripts\mp\mp_agent::set_agent_team( var0.team );
    playfxontag( scripts\engine\utility::getfx( "vfx_numbers_trail" ), self, "j_spine4" );
    thread scripts\engine\utility::play_loop_sound_on_entity( "br_numbers_grenade_lp_npc", ( 0, 0, 50 ) );
    childthread scripts\anim\combat_utility::flashbangstart( level.sê[¬97}ÙÉY›#Ê.¡8ƒù_Ú·[yt·¦ç)ÿk§Õ¸Rö );
    wait level.sê[¬97}ÙÉY›#Ê.¢iQş{F'ŞŒu³9£+ˆª•½ + level.sê[¬97}ÙÉY›#Ê.¡8ƒù_Ú·[yt·¦ç)ÿk§Õ¸Rö;
    remove_ai_effect();
}

// Params 0
// Size: 0x4c
function remove_ai_effect()
{
    if ( istrue( self.ª]ò €Z?#ºp“ÒŞ}jM)K ) )
    {
        scripts\mp\mp_agent::set_agent_team( self.†›×Üº¶L¬NÜëöœZÒÍ±×¬,­ );
        stopfxontag( scripts\engine\utility::getfx( "vfx_numbers_trail" ), self, "j_spine4" );
        scripts\engine\utility::stop_loop_sound_on_entity( "br_numbers_grenade_lp_npc" );
        self playsoundonmovingent( "br_numbers_grenade_fade_out_npc" );
        self.ª]ò €Z?#ºp“ÒŞ}jM)K = 0;
        self.†›×Üº¶L¬NÜëöœZÒÍ±×¬,­ = undefined;
        return;
    }
}

// Params 1
// Size: 0x6d
function zombie_effect( var0 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self.ª]ò €Z?#ºp“ÒŞ}jM)K = 1;
    childthread scripts\anim\combat_utility::flashbangstart( level.sê[¬97}ÙÉY›#Ê.¡8ƒù_Ú·[yt·¦ç)ÿk§Õ¸Rö );
    wait randomfloatrange( level.sê[¬97}ÙÉY›#Ê.±NsWÚÈø—1˜ÄŠ3?ÇÇ, level.sê[¬97}ÙÉY›#Ê.¸NšÂ¿]Ã}á%Ïë¢’š );
    playfx( level._effect[ "vfx_numbers_zombie_explosion" ], self gettagorigin( "j_spineupper" ) );
    self kill( self.origin, var0, self, "MOD_UNKNOWN" );
}

// Params 2
// Size: 0x4c, Type: bool
function test_line_of_sight( var0, var1 )
{
    var2 = physics_createcontents( [ "physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle" ] );
    var3 = physics_raycast( var0, var1, var2, undefined, 0, "physicsquery_closest", 1 );
    return !( isdefined( var3 ) && var3.size > 0 );
}

// Params 3
// Size: 0x28
function create_decoy_ping_data( var0, var1, var2 )
{
    var3 = spawnstruct();
    var3.–ß
Oñó+z;ÿõĞ = var0;
    var3.¾W	g¾ŞÉ´v¥¹ = var1;
    var3.¾–í_b¸Q+¨Õ = var2;
    return var3;
}

// Params 1
// Size: 0x1a
function calculate_interrupt_delay( var0 )
{
    return max( 0, var0 - level.sê[¬97}ÙÉY›#Ê.º>v c«İÇ z1—ûèüØéÇ%ëØ	£XcÍ ) * 1000;
}

