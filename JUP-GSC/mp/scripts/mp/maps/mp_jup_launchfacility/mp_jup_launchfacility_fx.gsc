/******************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_jup_launchfacility\mp_jup_launchfacility_fx.gsc
******************************************************************************/

#namespace mp_jup_launchfacility_fx;

function main() {
  level._effect["vfx_tracer_lmg_wheelson_w"] = loadfx("vfx/iw8/weap/_tracer/vfx_tracer_lmg_wheelson_w.vfx");
  level._effect["vfx_nightwar_amb_aafire_01"] = loadfx("vfx/jup/level/mp_jup_launchfacility/vfx_jup_launchfacility_nightwar_amb_aafire_01.vfx");
  level._effect["vehicle_flares"] = loadfx("vfx/iw8_mp/killstreak/vfx_apache_angel_flares.vfx");
  level._effect["ied_explosion"] = loadfx("vfx/iw8/level/highway/ied_explosion.vfx");
  level._effect["vfx_jup_launchfacility_missile_launch"] = loadfx("vfx/jup/level/mp_jup_launchfacility/vfx_jup_launchfacility_missile_launch.vfx");
  level._effect["bomb_explosion"] = loadfx("vfx/iw9/dmz/bombsite/vfx_dmz_bombsite_expl.vfx");
  level._effect["blima_flares"] = loadfx("vfx/iw9/core/flare/vfx_blima_angel_flares.vfx");
  level._effect["vfx_jup_launchfacility_building_exp_lrg"] = loadfx("vfx/jup/level/mp_jup_launchfacility/vfx_jup_launchfacility_building_exp_lrg.vfx");
  level._effect["talfa_explosion"] = loadfx("vfx/jup/level/mp_jup_launchfacility/vfx_jup_launchfacility_derail_veh_talfa_explosion_rnr.vfx");
  level._effect["sandbag_built"] = loadfx("vfx/jup/level/mp_jup_launchfacility/vfx_jup_lf_sandbags_debris_02.vfx");
  level._effect["tank_damaged"] = loadfx("vfx/iw8/veh/scriptables/vfx_veh_fire_engine_onfire.vfx");
  level._effect["tank_repaired"] = loadfx("vfx/iw8/veh/scriptables/vfx_veh_fire_engine_flareup.vfx");
  level._effect["tank_body_smk"] = loadfx("vfx/jup/level/mp_jup_launchfacility/vfx_jup_lf_tank_body_smk.vfx");
  level._effect["tank_track_dust"] = loadfx("vfx/jup/level/mp_jup_launchfacility/vfx_jup_lf_tank_track_dust.vfx");
  level._effect["care_package"] = loadfx("vfx/iw8_mp/killstreak/vfx_smk_signal_carepackage.vfx");
  level._effect["tank_drop_zone"] = loadfx("vfx/iw9/level/mp_dmz_hydro/vfx_smk_signal_dmz.vfx");
  level._effect["wall_explode"] = loadfx("vfx/jup/level/mp_jup_launchfacility/vfx_jup_lf_buildwall_exp.vfx");
  level._effect["turret_fixed"] = loadfx("vfx/jup/level/mp_jup_launchfacility/vfx_jup_lf_machinegun_repaired_glow.vfx");
  level._effect["infil_heli_hited"] = loadfx("vfx/jup/level/mp_jup_launchfacility/vfx_jup_lf_heli_blima_dmg_heavy_low.vfx");
  level._effect["infil_heli_explosion"] = loadfx("vfx/jup/level/mp_jup_launchfacility/vfx_jup_lf_veh_blima_explosion.vfx");
  level._effect["infil_heli_crashed"] = loadfx("vfx/jup/level/mp_jup_launchfacility/vfx_jup_lf_scrap_blima_fire.vfx");
  level._effect["attacker_outro_icbm_explo"] = loadfx("vfx/jup/level/mp_jup_launchfacility/vfx_jup_lf_missile_icbm_exp.vfx");

  if(getDvar(@ "clientsideeffects") != "<dev string:x1c>") {}
}