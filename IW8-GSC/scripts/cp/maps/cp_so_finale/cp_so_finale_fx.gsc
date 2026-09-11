/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_so_finale\cp_so_finale_fx.gsc
************************************************************/

function main() {
  level._effect["vfx_mortar_explosion"] = loadfx("vfx/iw8/weap/_explo/mortar/vfx_mortar_explosion.vfx");
  level._effect["vfx_emb_flash_mortar"] = loadfx("vfx/iw8/level/embassy/vfx_emb_flash_mortar.vfx");
  level._effect["vfx_smktrail_mortar"] = loadfx("vfx/test/norris/vfx_smktrail_mortar.vfx");
  level._effect["vfx_mortar_trail"] = loadfx("vfx/iw8/level/highway/vfx_mortar_trail.vfx");
  level._effect["vfx_mortar_fire"] = loadfx("vfx/iw8/level/embassy/vfx_mortar_fire.vfx");
  level._effect["vfx_mortar_impact"] = loadfx("vfx/iw8/level/highway/vfx_mortar_impact.vfx");
  level._effect["vfx_tank_death_exp"] = loadfx("vfx/iw8_mp/killstreak/vfx_tank_death_exp.vfx");
  level._effect["cp_trials_tank_smoke"] = loadfx("vfx/iw8_cp/trials/cp_trials_tank_smoke.vfx");
  level._effect["smoke_grenade_fx"] = loadfx("vfx/iw8_mp/equipment/smoke_grenade/vfx_st_grenade_smoke.vfx");
  level._effect["smoke_grenade_explosion"] = loadfx("vfx/iw8_mp/equipment/smoke_grenade/vfx_smoke_gren_ch.vfx");
}