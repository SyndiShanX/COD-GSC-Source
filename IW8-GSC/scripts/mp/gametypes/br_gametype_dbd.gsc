
// Params 0
// Size: 0x18a
function init()
{
    setdvar( "scr_br_altprematchloadout", "classtable_brdbd_prematch" );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "modifyPlayerDamage", &modifyplayerdamage );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "regenHealthAdd", &ref_1264b );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "postMainInit", &ref_12803 );
    scripts\mp\gametypes\br_gametypes::ref_12b11( "playerNakedDropLoadout", &ref_12604 );
    
    if ( getdvarint( "scr_br_dbd_vehicle_littlebird", 0 ) == 0 )
    {
        scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "littleBirdSpawns" );
    }
    
    if ( getdvarint( "scr_br_dbd_vehicle_truck", 0 ) == 0 )
    {
        scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "truckSpawns" );
    }
    
    if ( getdvarint( "scr_br_dbd_vehicle_jeep", 0 ) == 0 )
    {
        scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "jeepSpawns" );
    }
    
    if ( getdvarint( "scr_br_dbd_vehicle_tacrover", 0 ) == 0 )
    {
        scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "tacRoverSpawns" );
    }
    
    if ( getdvarint( "scr_br_dbd_vehicle_atv", 0 ) == 0 )
    {
        scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "atvSpawns" );
    }
    
    if ( getdvarint( "scr_br_dbd_vehicle_motorcycle", 0 ) == 0 )
    {
        scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx( "motorcycleSpawns" );
    }
    
    level.ref_11c95 = &ref_11c95;
    level.disable_super_in_turret.iscodecorrect = getdvarint( "scr_br_dbd_hsdowndistance", 3550 );
    level.disable_super_in_turret.iscontender = getdvarint( "scr_br_dbd_healthregenrate", 1 );
    level.disable_super_in_turret.iscloseto = getdvarfloat( "scr_br_dbd_gasdamagesclar", 2.5 );
    level.disable_super_in_turret.iscrossbowbolt = getdvarint( "scr_br_dbd_stimregenscalar", 4 );
    level.disable_super_in_turret.iscopiedclass = getdvarint( "scr_br_dbd_nononeshotsnprdmg", 275 );
    level.disable_super_in_turret.Çx±Æ'‰V‹G’7ZŸV…7Ö6C‡ = getdvarint( "scr_br_universal_hp_reference", 300 );
    level.disable_super_in_turret.©äpJ˙ƒsUå&¿ã–Ö≈C"Ò:ÀÉÿG = getdvarint( "scr_br_dbd_fixed_snpr_hs_dist_dmg", 0 );
}

// Params 0
// Size: 0x62
function ref_12803()
{
    if ( getdvarint( "scr_dbd_fall_height_modifier_enable", 1 ) == 0 )
    {
        return;
    }
    
    setdvar( "NKTQRKRMTS", getdvarint( "scr_br_dbd_fallheightmin", 1120 ) );
    setdvar( "LKMOLLSKKO", getdvarint( "scr_br_dbd_fallheightmax", 1121 ) );
    setdvar( "OMLLLQKQSR", getdvarint( "scr_br_dbd_fallheightmin", 1120 ) );
    setdvar( "LTMMLKRKTR", getdvarint( "scr_br_dbd_fallheightmax", 1121 ) );
}

// Params 1
// Size: 0x140
function modifyplayerdamage( var0 )
{
    var1 = scripts\mp\utility\weapon::getweaponrootname( var0.objweapon );
    
    if ( var0.objweapon.classname == "sniper" && ( var0.shitloc == "head" || var0.shitloc == "helmet" ) && !usefailvehiclemsg( var1 ) )
    {
        var2 = var0.attacker;
        var3 = var0.victim;
        var4 = var3.br_maxarmorhealth + var3.maxhealth;
        var5 = distancesquared( var2.origin, var3.origin );
        
        if ( level.åyæ7ª˛∏7cIq°S+›)¶è9¿à' == 0 && var0.damage >= level.disable_super_in_turret.Çx±Æ'‰V‹G’7ZŸV…7Ö6C‡ && var5 < level.disable_super_in_turret.iscodecorrect * level.disable_super_in_turret.iscodecorrect )
        {
            return var4;
        }
        
        if ( level.disable_super_in_turret.©äpJ˙ƒsUå&¿ã–Ö≈C"Ò:ÀÉÿG == 1 && var5 < level.disable_super_in_turret.iscodecorrect * level.disable_super_in_turret.iscodecorrect )
        {
            if ( !istrue( var3.isjuggernaut ) )
            {
                return var4;
            }
            else
            {
                return ( var3.br_maxarmorhealth + var3.juggcontext.prevmaxhealth );
            }
        }
        else
        {
            return max( level.disable_super_in_turret.iscopiedclass, var0.damage );
        }
    }
    
    return var0.damage;
}

// Params 1
// Size: 0x5c, Type: bool
function usefailvehiclemsg( var0 )
{
    return var0 == "iw8_sn_delta" || var0 == "iw8_sn_golf28" || var0 == "iw8_sn_mike14" || var0 == "iw8_sn_sbeta" || var0 == "iw8_sn_sksierra" || var0 == "s4_mr_gecho43" || var0 == "s4_mr_m1golf" || var0 == "s4_mr_svictor40" || var0 == "s4_mr_malpha1916";
}

// Params 1
// Size: 0x37
function ref_1264b( var0 )
{
    if ( istrue( self.adrenalinepoweractive ) )
    {
        return int( level.disable_super_in_turret.iscontender * level.disable_super_in_turret.iscrossbowbolt );
    }
    
    return int( level.disable_super_in_turret.iscontender );
}

// Params 1
// Size: 0x15
function ref_11c95( var0 )
{
    return int( var0 * level.disable_super_in_turret.iscloseto );
}

// Params 0
// Size: 0xc
function ref_12604()
{
    scripts\mp\gametypes\br::searchcircleorigin( 0, 1, 0 );
}

