/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58339.gsc
***********************************************/

function registerscriptedagent() {
  var_0 = [["molotov_explosion", "vfx/iw8/core/molotov/vfx_molotov_explosion.vfx"], ["molotov_explosion_child", "vfx/iw8/core/molotov/vfx_molotov_explosion_child.vfx"], ["vfx_burn_sml_low", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_sml_low.vfx"], ["vfx_burn_sml_high", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_sml_high.vfx"], ["vfx_burn_sml_head_low", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_head_low.vfx"], ["vfx_burn_med_low", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_med_low.vfx"], ["vfx_burn_med_high", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_med_high.vfx"], ["vfx_burn_lrg_low", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_lrg_low.vfx"], ["vfx_burn_lrg_high", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_lrg_high.vfx"]];

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(!isDefined(level.g_effect[var_0[var_1][0]])) {
      level.g_effect[var_0[var_1][0]] = loadfx(var_0[var_1][1]);
    }
  }

  anim.grenadetimers["AI_gas_grenade_mp"] = randomintrange(0, 20000);
  initparachutefunctionality();
}

function initparachutefunctionality() {
  level.fnbrsoldierparachutespawn = &scripts\asm\soldier_lw_br\parachutespawn::soldier_br_parachute_setlandingpointbycoord;
}