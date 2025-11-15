/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_alien_last_fx.gsc
****************************************/

main() {
  level._effect["alien_cloaking"] = loadfx("vfx/gameplay/alien/vfx_alien_tele_trail_01");
  level._effect["alien_uncloaking"] = loadfx("vfx/gameplay/alien/vfx_alien_tele_trail_02");
  level._effect["mammoth_burrow"] = loadfx("vfx/ae/aln_mmth_grnd_brw");
  level._effect["green_light"] = loadfx("vfx/ambient/lights/vfx_green_light_120_nolight");
  level._effect["glow_red_light_100_nolight"] = loadfx("vfx/ambient/lights/vfx_glow_red_light_100_nolight");
  level._effect["challenge_ring"] = loadfx("vfx/_requests/mp_alien_last/vfx_alien_challenge_ring");
  level._effect["amb_gargoyle_swarm_1"] = loadfx("vfx/moments/alien/vfx_last_gargoyle_swarm_01");
  level._effect["alien_nuke"] = loadfx("vfx/ambient/alien/vfx_alien_nuke");
  level._effect["alien_plume_fire_v1"] = loadfx("vfx/ambient/alien/vfx_alien_perif_plume_fire_v1");
  level._effect["raining_ash_01"] = loadfx("vfx/ambient/alien/vfx_alien_falling_ash_01");
  level._effect["falling_debris"] = loadfx("vfx/moments/alien/falling_debris_structures");
  level._effect["fire_med_01"] = loadfx("vfx/ambient/alien/vfx_fire_med_end");
  level._effect["god_rays_01"] = loadfx("vfx/ambient/alien/vfx_alien_godrays_last_01");
  level._effect["alien_gib"] = loadfx("vfx/gameplay/alien/vfx_alien_pipebomb_gib_01");
  level._effect["alien_ark_gib"] = loadfx("vfx/gameplay/alien/vfx_alien_ark_gib_01");
  level._effect["sticky_flare"] = loadfx("vfx/gameplay/alien/sticky_flare_dyn_orange");
  level._effect["ancestor_breakthru_1"] = loadfx("vfx/moments/alien/vfx_alien_ancstr_breakthu_1");
  level._effect["cross_blast"] = loadfx("vfx/moments/alien/vfx_alien_cortex_blast_sm_child_1");
  level._effect["cross_teleport"] = loadfx("vfx/moments/alien/vfx_alien_cross_tele_trail_01");
  level._effect["cortex_glow_1"] = loadfx("vfx/moments/alien/vfx_alien_cortex_glow_01");
  level._effect["cross_ff_1"] = loadfx("vfx/moments/alien/vfx_alien_cross_ff_01");
  level._effect["medusa_blast"] = loadfx("vfx/moments/alien/vfx_alien_medusa_blast_01");
  level._effect["vfx/moments/alien/nuke_fail_screen_flash"] = loadfx("vfx/moments/alien/nuke_fail_screen_flash");
  precacherumble("grenade_rumble");
  level._effect["soul_escape"] = loadfx("vfx/moments/alien/vfx_alien_soul_escape");
  level._effect["eyeball_death"] = loadfx("vfx/_requests/mp_alien_last/vfx_alien_eyeball_death");
  level._effect["collectible_eye"] = loadfx("vfx/_requests/mp_alien_last/collectible_eye");
  level.dig_fx["shrine"]["player"] = loadfx("vfx/moments/alien/vfx_alien_gh_01");
  level.dig_fx["shrine"]["screen"] = loadfx("vfx/moments/alien/vfx_alien_gh_pv_01");
  level thread conduit_fx_on_no_ff(1);
}

conduit_fx_on_no_ff(var_0) {
  if(maps\mp\alien\_utility::is_true(var_0))
    level waittill("spawn_nondeterministic_entities");

  var_1 = getent("ancestor_left_generator_scriptable", "targetname");
  var_1 setscriptablepartstate("base", "on_no_ff");
}

conduit_fx_destroyed() {
  var_0 = getent("ancestor_left_generator_scriptable", "targetname");
  var_0 setscriptablepartstate("base", "destroyed");
}