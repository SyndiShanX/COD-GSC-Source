
// Params 0
// Size: 0xcf
function registerscriptedagent()
{
    var0 = [ [ "molotov_explosion", "vfx/iw8/core/molotov/vfx_molotov_explosion.vfx" ], [ "molotov_explosion_child", "vfx/iw8/core/molotov/vfx_molotov_explosion_child.vfx" ], [ "vfx_burn_sml_low", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_sml_low.vfx" ], [ "vfx_burn_sml_high", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_sml_high.vfx" ], [ "vfx_burn_sml_head_low", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_head_low.vfx" ], [ "vfx_burn_med_low", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_med_low.vfx" ], [ "vfx_burn_med_high", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_med_high.vfx" ], [ "vfx_burn_lrg_low", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_lrg_low.vfx" ], [ "vfx_burn_lrg_high", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_lrg_high.vfx" ] ];
    
    for ( var1 = 0; var1 < var0.size ; var1++ )
    {
        if ( !isdefined( level.g_effect[ var0[ var1 ][ 0 ] ] ) )
        {
            level.g_effect[ var0[ var1 ][ 0 ] ] = loadfx( var0[ var1 ][ 1 ] );
        }
    }
    
    anim.grenadetimers[ "AI_gas_grenade_mp" ] = randomintrange( 0, 20000 );
    initparachutefunctionality();
}

// Params 0
// Size: 0xb
function initparachutefunctionality()
{
    level.£'¡Šã^ø…4™›%ª¨¯Û™èƒ›š· = &scripts\asm\soldier_lw_br\parachutespawn::soldier_br_parachute_setlandingpointbycoord;
}

