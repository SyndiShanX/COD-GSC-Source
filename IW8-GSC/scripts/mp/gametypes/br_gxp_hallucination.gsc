/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gxp_hallucination.gsc
*********************************************************/

function init() {
  if(!getdvarint("scr_br_gxp_fear", 0)) {
    return;
  }

  level.disable_super_in_turret.setsuperisinuse = [];
  level.disable_super_in_turret.setspecialistbonus = [];
  level.disable_super_in_turret.setspecialistbonus[1] = [];
  level.disable_super_in_turret.setspecialistbonus[2] = [];
  level.disable_super_in_turret.setspecialistbonus[3] = [];
  level._effect["vfx_gxp_flies_minor"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_gxp_flies_minor.vfx");
  level._effect["vfx_gxp_flies_major"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_gxp_flies_major.vfx");
  level._effect["vfx_gxp_eyes_minor"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_gxp_eyes_minor.vfx");
  level._effect["vfx_gxp_eyes_major"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_gxp_eyes_major.vfx");
  level._effect["vfx_gxp_mosquitos_minor"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_gxp_mosquitos_minor.vfx");
  level._effect["vfx_gxp_mosquitos_major"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_gxp_mosquitos_major.vfx");
  level._effect["vfx_gxp_heatdist_minor"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_gxp_heatdist_minor.vfx");
  level._effect["vfx_gxp_heatdist_major"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_gxp_heatdist_major.vfx");
  level._effect["vfx_gxp_skulls_major"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_gxp_skulls_major.vfx");
  level._effect["vfx_gxp_skulls_minor"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_gxp_skulls_minor.vfx");
  level._effect["vfx_gxp_molotov_minor"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_gxp_molotov_minor.vfx");
  level._effect["vfx_gxp_tracers_minor"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_gxp_tracers_minor.vfx");
  level._effect["vfx_gxp_tracers_major"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_gxp_tracers_major.vfx");
  level._effect["vfx_ghost_death_3p"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_ghost_death_3p.vfx");
  level._effect["vfx_gxp_chest_bluefire_death"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_gxp_chest_bluefire_death.vfx");
  level._effect["vfx_gxp_corpuscules_minor"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_gxp_corpuscules_minor.vfx");
  level._effect["vfx_gxp_corpuscules_major"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_gxp_corpuscules_major.vfx");
  level._effect["vfx_gxp_cracks_minor"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_gxp_cracks_minor.vfx");
  level._effect["vfx_gxp_cracks_major"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_gxp_cracks_major.vfx");
  level._effect["vfx_gxp_meatholes_minor"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_gxp_meatholes_minor.vfx");
  level._effect["vfx_gxp_meatholes_major"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_gxp_meatholes_major.vfx");
  level._effect["vfx_gxp_splatter_minor"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_gxp_splatter_minor.vfx");
  level._effect["vfx_gxp_splatter_major"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_gxp_splatter_major.vfx");
  level._effect["vfx_gxp_rainbows_minor"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_gxp_rainbows_minor.vfx");
  level._effect["vfx_gxp_rainbows_major"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_gxp_rainbows_major.vfx");
  level._effect["vfx_gxp_crescents_minor"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_gxp_crescents_minor.vfx");
  level._effect["vfx_gxp_crescents_major"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_gxp_crescents_major.vfx");
  level._effect["vfx_gxp_flames_minor"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_gxp_flames_minor.vfx");
  level._effect["vfx_gxp_flames_major"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_gxp_flames_major.vfx");
  level._effect["vfx_gxp_wiggler_01_minor"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_gxp_wiggler_01_minor.vfx");
  level._effect["vfx_gxp_wiggler_01_major"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_gxp_wiggler_01_major.vfx");
  level._effect["vfx_gxp_splashy_minor"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_gxp_splashy_minor.vfx");
  level._effect["vfx_gxp_splashy_major"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_gxp_splashy_major.vfx");
  level._effect["vfx_gxp_streakwiggle_01_major"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_gxp_streakwiggle_01_major.vfx");
  level._effect["vfx_gxp_streakwiggle_01_minor"] = loadfx("vfx/iw8_br/gameplay/hween2/vfx_gxp_streakwiggle_01_minor.vfx");
  level.disable_super_in_turret.setquestindexteamomnvar = spawn("script_model", (0, 0, 0));
  tr_vis_radius_override_lod1();
  battle_tracks_settogglestate();
  team_revive_kbm_override();
  battle_tracks_setmusicstate(2, 0.2, &setspawninstances, ref_1327e("vfx_gxp_flies_minor", 1, 2.5), &ref_119ca, "scr_br_gxp_disable_hallucination_flies_minor", ref_13244(0, 4, "fov_low"));
  battle_tracks_setmusicstate(3, 0.3, &setspawninstances, ref_1327e("vfx_gxp_flies_major", 1, 2.5), &ref_119ca, "scr_br_gxp_disable_hallucination_flies_major", ref_13244(0, 5, "fov_medium"));
  battle_tracks_setmusicstate(2, 0.2, &setspawninstances, ref_1327e("vfx_gxp_eyes_minor", 1, 2.5), &ref_119ca, "scr_br_gxp_disable_hallucination_eyes_minor", ref_13244(0, 4, "fov_low"));
  battle_tracks_setmusicstate(3, 0.3, &setspawninstances, ref_1327e("vfx_gxp_eyes_major", 1, 2.5), &ref_119ca, "scr_br_gxp_disable_hallucination_eyes_major", ref_13244(0, 5, "fov_medium"));
  battle_tracks_setmusicstate(2, 0.2, &setspawninstances, ref_1327e("vfx_gxp_mosquitos_minor", 1, 2.5), &ref_119ca, "scr_br_gxp_disable_hallucination_mosquitos_minor", ref_13244(0, 3, "fov_low"));
  battle_tracks_setmusicstate(3, 0.3, &setspawninstances, ref_1327e("vfx_gxp_mosquitos_major", 1, 2.5), &ref_119ca, "scr_br_gxp_disable_hallucination_mosquitos_major", ref_13244(0, 4, "fov_medium"));
  battle_tracks_setmusicstate(2, 0.2, &setspawninstances, ref_1327e("vfx_gxp_heatdist_minor", 1, 2.5), &ref_119ca, "scr_br_gxp_disable_hallucination_heatdist_minor", ref_13244(0, 3, "fov_low"));
  battle_tracks_setmusicstate(3, 0.3, &setspawninstances, ref_1327e("vfx_gxp_heatdist_major", 1, 2.5), &ref_119ca, "scr_br_gxp_disable_hallucination_heatdist_major", ref_13244(0, 4, "fov_medium"));
  battle_tracks_setmusicstate(2, 0.2, &setspawninstances, ref_1327e("vfx_gxp_skulls_minor", 1, 2.5), &ref_119ca, "scr_br_gxp_disable_hallucination_skulls_minor", ref_13244(0, 2.5, "fov_low"));
  battle_tracks_setmusicstate(3, 0.3, &setspawninstances, ref_1327e("vfx_gxp_skulls_major", 1, 2.5), &ref_119ca, "scr_br_gxp_disable_hallucination_skulls_major", ref_13244(0, 3, "fov_medium"));
  battle_tracks_setmusicstate(2, 0.2, &setspawninstances, ref_1327e("vfx_gxp_corpuscules_minor", 1, 2.5), &ref_119ca, "scr_br_gxp_disable_hallucination_corpuscules_minor", ref_13244(0, 3, "fov_low"));
  battle_tracks_setmusicstate(3, 0.3, &setspawninstances, ref_1327e("vfx_gxp_corpuscules_major", 1, 2.5), &ref_119ca, "scr_br_gxp_disable_hallucination_corpuscules_major", ref_13244(0, 4, "fov_medium"));
  battle_tracks_setmusicstate(2, 0.2, &setspawninstances, ref_1327e("vfx_gxp_cracks_minor", 1, 2.5), &ref_119ca, "scr_br_gxp_disable_hallucination_cracks_minor", ref_13244(0, 4, "fov_low"));
  battle_tracks_setmusicstate(3, 0.3, &setspawninstances, ref_1327e("vfx_gxp_cracks_major", 1, 2.5), &ref_119ca, "scr_br_gxp_disable_hallucination_cracks_major", ref_13244(0, 5, "fov_medium"));
  battle_tracks_setmusicstate(2, 0.2, &setspawninstances, ref_1327e("vfx_gxp_meatholes_minor", 1, 2.5), &ref_119ca, "scr_br_gxp_disable_hallucination_meathole_minor", ref_13244(0, 2, "fov_low"));
  battle_tracks_setmusicstate(3, 0.3, &setspawninstances, ref_1327e("vfx_gxp_meatholes_major", 1, 2.5), &ref_119ca, "scr_br_gxp_disable_hallucination_meathole_major", ref_13244(0, 2, "fov_medium"));
  battle_tracks_setmusicstate(2, 0.2, &setspawninstances, ref_1327e("vfx_gxp_splatter_minor", 1, 2.5), &ref_119ca, "scr_br_gxp_disable_hallucination_splatter_minor", ref_13244(0, 2, "fov_low"));
  battle_tracks_setmusicstate(3, 0.3, &setspawninstances, ref_1327e("vfx_gxp_splatter_major", 1, 2.5), &ref_119ca, "scr_br_gxp_disable_hallucination_splatter_major", ref_13244(0, 2, "fov_medium"));
  battle_tracks_setmusicstate(2, 0.2, &setspawninstances, ref_1327e("vfx_gxp_rainbows_minor", 1, 2.5), &ref_119ca, "scr_br_gxp_disable_hallucination_rainbows_minor", ref_13244(0, 2, "fov_low"));
  battle_tracks_setmusicstate(3, 0.3, &setspawninstances, ref_1327e("vfx_gxp_rainbows_major", 1, 2.5), &ref_119ca, "scr_br_gxp_disable_hallucination_rainbows_major", ref_13244(0, 2, "fov_medium"));
  battle_tracks_setmusicstate(2, 0.2, &setspawninstances, ref_1327e("vfx_gxp_crescents_minor", 1, 2.5), &ref_119ca, "scr_br_gxp_disable_hallucination_crescents_minor", ref_13244(0, 2, "fov_low"));
  battle_tracks_setmusicstate(3, 0.3, &setspawninstances, ref_1327e("vfx_gxp_crescents_major", 1, 2.5), &ref_119ca, "scr_br_gxp_disable_hallucination_crescents_major", ref_13244(0, 2, "fov_medium"));
  battle_tracks_setmusicstate(2, 0.2, &setspawninstances, ref_1327e("vfx_gxp_flames_minor", 1, 2.5), &ref_119ca, "scr_br_gxp_disable_hallucination_flames_minor", ref_13244(0, 2, "fov_low"));
  battle_tracks_setmusicstate(3, 0.3, &setspawninstances, ref_1327e("vfx_gxp_flames_major", 1, 2.5), &ref_119ca, "scr_br_gxp_disable_hallucination_flames_major_major", ref_13244(0, 2, "fov_medium"));
  battle_tracks_setmusicstate(2, 0.2, &setspawninstances, ref_1327e("vfx_gxp_wiggler_01_minor", 1, 2.5), &ref_119ca, "scr_br_gxp_disable_hallucination_wiggler_01_minor", ref_13244(0, 2, "fov_low"));
  battle_tracks_setmusicstate(3, 0.3, &setspawninstances, ref_1327e("vfx_gxp_wiggler_01_major", 1, 2.5), &ref_119ca, "scr_br_gxp_disable_hallucination_wiggler_01_major_major", ref_13244(0, 2, "fov_medium"));
  battle_tracks_setmusicstate(2, 0.2, &setspawninstances, ref_1327e("vfx_gxp_splashy_minor", 1, 2.5), &ref_119ca, "scr_br_gxp_disable_hallucination_splashy_minor", ref_13244(0, 2, "fov_low"));
  battle_tracks_setmusicstate(3, 0.3, &setspawninstances, ref_1327e("vfx_gxp_splashy_major", 1, 2.5), &ref_119ca, "scr_br_gxp_disable_hallucination_splashy_major", ref_13244(0, 2.5, "fov_medium"));
  battle_tracks_setmusicstate(2, 0.2, &setspawninstances, ref_1327e("vfx_gxp_streakwiggle_01_minor", 1, 2.5), &ref_119ca, "scr_br_gxp_disable_hallucination_streakwiggle_01_minor", ref_13244(0, 2, "fov_low"));
  battle_tracks_setmusicstate(3, 0.3, &setspawninstances, ref_1327e("vfx_gxp_streakwiggle_01_major", 1, 2.5), &ref_119ca, "scr_br_gxp_disable_hallucination_streakwiggle_01_major", ref_13244(0, 2.5, "fov_medium"));
  battle_tracks_setmusicstate(1, 0.1, &setsoundsubmixfadetoblackamb, "br_gov_aural_hallucination", &ref_119c9, "scr_br_gxp_disable_hallucination_aural");
  battle_tracks_setmusicstate(1, 0.1, &setsoundsubmixfadetoblackamb, "dx_bra_halu_hallucination_voice", &ref_119c9, "scr_br_gxp_disable_hallucination_halu_voice");
  battle_tracks_setmusicstate(1, 0.1, &setsoundsubmixfadetoblackamb, "dx_bra_hal2_hallucination_voice", &ref_119c9, "scr_br_gxp_disable_hallucination_hal2_voice");
  battle_tracks_setmusicstate(2, 0.2, &setsuperexpended, 5, &ref_119c8, "scr_br_gxp_disable_hallucination_scramble_hud_median");
  battle_tracks_setmusicstate(3, 0.3, &setsuperexpended, 15, &ref_119c8, "scr_br_gxp_disable_hallucination_scramble_hud_major");
  battle_tracks_setmusicstate(2, 0.2, &setquestrewardtier, pavelow_boss_hit_by_emp(2, 0.7, 1.2, 40, 0), &ref_119c5, "scr_br_gxp_disable_hallucination_fake_damage_median");
  battle_tracks_setmusicstate(3, 0.3, &setquestrewardtier, pavelow_boss_hit_by_emp(5, 0.7, 1.5, 60, 0), &ref_119c5, "scr_br_gxp_disable_hallucination_fake_damage_major");
  battle_tracks_setmusicstate(2, 0.2, &setradarparamsonlatejoiner, ref_13233(11, "ta_gov_01", 4.26, 1), &ref_119c4, "scr_br_gxp_disable_hallucination_01");
  battle_tracks_setmusicstate(3, 0.3, &setradarparamsonlatejoiner, ref_13233(12, "ta_gov_02", 5, 1), &ref_119c4, "scr_br_gxp_disable_hallucination_02");
  battle_tracks_setmusicstate(3, 0.3, &setradarparamsonlatejoiner, ref_13233(13, "ta_gov_03", 5, 1), &ref_119c4, "scr_br_gxp_disable_hallucination_03");
  battle_tracks_setmusicstate(3, 0.3, &setradarparamsonlatejoiner, ref_13233(14, "ta_gov_04", 4.1, 1), &ref_119c4, "scr_br_gxp_disable_hallucination_04");
  battle_tracks_setmusicstate(2, 0.2, &setradarparamsonlatejoiner, ref_13233(15, "ta_gov_05", 5, 1), &ref_119c4, "scr_br_gxp_disable_hallucination_05");
  battle_tracks_setmusicstate(2, 0.2, &setradarparamsonlatejoiner, ref_13233(16, "ta_gov_06", 5, 1), &ref_119c4, "scr_br_gxp_disable_hallucination_06");
  battle_tracks_setmusicstate(3, 0.3, &setradarparamsonlatejoiner, ref_13233(17, "ta_gov_07", 5, 1), &ref_119c4, "scr_br_gxp_disable_hallucination_07");
  battle_tracks_setmusicstate(2, 0.2, &setradarparamsonlatejoiner, ref_13233(18, "ta_gov_08", 5, 1), &ref_119c4, "scr_br_gxp_disable_hallucination_08");
  battle_tracks_setmusicstate(3, 0.3, &setradarparamsonlatejoiner, ref_13233(19, "ta_gov_09", 5.06, 1), &ref_119c4, "scr_br_gxp_disable_hallucination_09");
  battle_tracks_setmusicstate(2, 0.2, &setradarparamsonlatejoiner, ref_13233(20, "ta_gov_10", 5.01, 1), &ref_119c4, "scr_br_gxp_disable_hallucination_10");
  battle_tracks_setmusicstate(3, 0.3, &setradarparamsonlatejoiner, ref_13233(21, "ta_gov_11", 3.11, 1), &ref_119c4, "scr_br_gxp_disable_hallucination_11");
  battle_tracks_setmusicstate(2, 0.2, &setradarparamsonlatejoiner, ref_13233(22, "ta_gov_12", 5.01, 1), &ref_119c4, "scr_br_gxp_disable_hallucination_12");
  battle_tracks_setmusicstate(3, 0.3, &setradarparamsonlatejoiner, ref_13233(23, "ta_gov_13", 3.23, 1), &ref_119c4, "scr_br_gxp_disable_hallucination_13");
  battle_tracks_setmusicstate(2, 0.2, &setradarparamsonlatejoiner, ref_13233(24, "ta_gov_14", 5.16, 1), &ref_119c4, "scr_br_gxp_disable_hallucination_14");
  battle_tracks_setmusicstate(2, 0.2, &setradarparamsonlatejoiner, ref_13233(25, "ta_gov_15", 5.19, 1), &ref_119c4, "scr_br_gxp_disable_hallucination_15");
  battle_tracks_setmusicstate(3, 0.3, &setradarparamsonlatejoiner, ref_13233(26, "ta_gov_16", 5.24, 1), &ref_119c4, "scr_br_gxp_disable_hallucination_16");
  battle_tracks_setmusicstate(2, 0.2, &setradarparamsonlatejoiner, ref_13233(27, "ta_gov_17", 5.02, 1), &ref_119c4, "scr_br_gxp_disable_hallucination_17");
  battle_tracks_setmusicstate(3, 0.3, &setradarparamsonlatejoiner, ref_13233(28, "ta_gov_18", 2.39, 1), &ref_119c4, "scr_br_gxp_disable_hallucination_18");
  battle_tracks_setmusicstate(3, 0.3, &setradarparamsonlatejoiner, ref_13233(29, "ta_gov_19", 4.6, 1), &ref_119c4, "scr_br_gxp_disable_hallucination_19");
  battle_tracks_setmusicstate(2, 0.2, &setradarparamsonlatejoiner, ref_13233(30, "ta_gov_20", 5.2, 1), &ref_119c4, "scr_br_gxp_disable_hallucination_20");
  battle_tracks_setmusicstate(3, 0.3, &setradarparamsonlatejoiner, ref_13233(31, "ta_gov_21", 6.2, 1), &ref_119c4, "scr_br_gxp_disable_hallucination_21");
  battle_tracks_setmusicstate(3, 0.3, &setradarparamsonlatejoiner, ref_13233(32, "ta_gov_22", 6.2, 1), &ref_119c4, "scr_br_gxp_disable_hallucination_22");
  ref_13381();
}

function tr_vis_radius_override_lod1() {
  level.disable_super_in_turret.play_3p_anim_non_animscene.immediatecleanup = getdvarint("scr_fear_corpse_vfx_radius", 10000);
  level.disable_super_in_turret.play_3p_anim_non_animscene.illumination_flare_init = getdvarint("scr_fear_corpse_vfx_observer_ms", 5000);
  level.disable_super_in_turret.play_3p_anim_non_animscene.ref_126e5 = getdvarint("scr_fear_player_vfx_radius", 1000);
  level.disable_super_in_turret.play_3p_anim_non_animscene.ref_126e4 = getdvarint("scr_fear_player_vfx_observer_ms_min", 30000);
  level.disable_super_in_turret.play_3p_anim_non_animscene.ref_126e3 = getdvarint("scr_fear_player_vfx_observer_ms_max", 90000);
}

function battle_tracks_settogglestate() {
  var_0 = (1, 0, 0);
  var_1 = (1, 1, 0);
  var_2 = (0, 1, 0);
  var_3 = getdvarfloat("scr_hallucination_trigger_3", 0.75);
  var_4 = getdvarfloat("scr_fear_tier3_tas", 25);
  var_5 = getdvarfloat("scr_fear_tier3_tae", 15);
  var_6 = getdvarfloat("scr_fear_tier3_tv", 5);
  var_7 = getdvarfloat("scr_fear_tier3_ns", 0);
  var_8 = getdvarfloat("scr_fear_tier3_ne", 0);
  var_9 = getdvarfloat("scr_fear_tier3_mins", 0);
  var_10 = getdvarfloat("scr_fear_tier3_mine", 0);
  var_11 = getdvarfloat("scr_fear_tier3_meds", 0.1);
  var_12 = getdvarfloat("scr_fear_tier3_mede", 0.1);
  var_13 = getdvarfloat("scr_fear_tier3_majs", 0.9);
  var_14 = getdvarfloat("scr_fear_tier3_maje", 0.9);
  ref_1324a(var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_0);
  var_3 = getdvarfloat("scr_hallucination_trigger_2", 0.5);
  var_4 = getdvarfloat("scr_fear_tier2_tas", 30);
  var_5 = getdvarfloat("scr_fear_tier2_tae", 20);
  var_6 = getdvarfloat("scr_fear_tier2_tv", 5);
  var_7 = getdvarfloat("scr_fear_tier2_ns", 0.2);
  var_8 = getdvarfloat("scr_fear_tier2_ne", 0.2);
  var_9 = getdvarfloat("scr_fear_tier2_mins", 0.2);
  var_10 = getdvarfloat("scr_fear_tier2_mine", 0.2);
  var_11 = getdvarfloat("scr_fear_tier2_meds", 0.6);
  var_12 = getdvarfloat("scr_fear_tier2_mede", 0.6);
  var_13 = getdvarfloat("scr_fear_tier2_majs", 0.2);
  var_14 = getdvarfloat("scr_fear_tier2_maje", 0.2);
  ref_1324a(var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_0);
  var_3 = getdvarfloat("scr_hallucination_trigger_1", 0);
  var_4 = getdvarfloat("scr_fear_tier1_tas", 40);
  var_5 = getdvarfloat("scr_fear_tier1_tae", 30);
  var_6 = getdvarfloat("scr_fear_tier1_tv", 10);
  var_7 = getdvarfloat("scr_fear_tier1_ns", 0.4);
  var_8 = getdvarfloat("scr_fear_tier1_ne", 0.4);
  var_9 = getdvarfloat("scr_fear_tier1_mins", 0.8);
  var_10 = getdvarfloat("scr_fear_tier1_mine", 0.8);
  var_11 = getdvarfloat("scr_fear_tier1_meds", 0.2);
  var_12 = getdvarfloat("scr_fear_tier1_mede", 0.2);
  var_13 = getdvarfloat("scr_fear_tier1_majs", 0);
  var_14 = getdvarfloat("scr_fear_tier1_maje", 0);
  ref_1324a(var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_0);
}

function team_revive_kbm_override() {}

function onplayerconnect(var_0) {
  var_0.sales_discount_items = [];

  foreach(var_2 in level.disable_super_in_turret.setspecialistbonus) {
    if(var_2.size) {
      var_0.sales_discount_items[var_3] = randomint(var_2.size);
    }
  }
}

function onplayerspawned() {
  if(!level.disable_super_in_turret.placementstatsset) {
    return;
  }

  has_target_player();
}

function ref_1324a(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  var_13 = spawnStruct();
  var_13.ref_13db4 = var_0;
  var_13.time = (var_1, var_2, var_3);
  var_13.initlootvaultkeypad = 0;
  var_14 = 1 - var_4;
  var_15 = 1 - var_5;
  var_13.setpostgamestate = [];
  var_13.setpostgamestate[0] = (var_4, var_5, 0);
  var_13.setpostgamestate[1] = (var_6 * var_14, var_7 * var_15, 0);
  var_13.setpostgamestate[2] = (var_8 * var_14, var_9 * var_15, 0);
  var_13.setpostgamestate[3] = (var_10 * var_14, var_11 * var_15, 0);
  var_13.left_control = var_12;
  level.disable_super_in_turret.setsuperisinuse[level.disable_super_in_turret.setsuperisinuse.size] = var_13;
}

function freight_lift_attacker_internal() {
  foreach(var_1 in level.disable_super_in_turret.setsuperisinuse) {
    var_1.initlootvaultkeypad = randomfloatrange(-1 * var_1.time[2], var_1.time[2]);
  }
}

function remove_fake_guy_from_list(var_0) {
  foreach(var_2 in level.disable_super_in_turret.setsuperisinuse) {
    if(var_2.ref_13db4 <= var_0) {
      return var_3;
    }
  }

  return 0;
}

function run_hotjoin_loadout_thread() {
  var_0 = level.disable_super_in_turret.setsuperisinuse[self.setchainkillstreaks].ref_13db4;
  var_1 = 1;

  if(self.setchainkillstreaks > 0) {
    var_1 = level.disable_super_in_turret.setsuperisinuse[self.setchainkillstreaks - 1].ref_13db4;
  }

  var_2 = (self.setcachedclientomnvar - var_0) / (var_1 - var_0);
  return var_2;
}

function ref_13233(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.length = var_2;
  var_5.cinematic = var_1;
  var_5.moveeffect = var_3;
  var_5.index = var_0;
  var_5.ref_1276e = var_4;
  return var_5;
}

function ref_1327e(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.fx = var_0;
  var_3.ref_1276e = var_1;
  var_3.length = var_2;
  return var_3;
}

function ref_13244(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.watchspawnwallplayerexit = var_0;
  var_3.length = var_1;
  var_3.type = var_2;
  return var_3;
}

function battle_tracks_setmusicstate(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(getdvarint(var_5, 0)) {
    return;
  }

  var_7 = spawnStruct();
  var_7.pity_timer_end_time = var_1;
  var_7.function = var_2;
  var_7.ref_119ab = var_4;
  var_7.data = var_3;
  var_7.playerplunderlosecallback = var_6;
  level.disable_super_in_turret.setspecialistbonus[var_0][level.disable_super_in_turret.setspecialistbonus[var_0].size] = var_7;
}

function ref_13381() {
  foreach(var_1 in level.disable_super_in_turret.setspecialistbonus) {
    level.disable_super_in_turret.setspecialistbonus[var_2] = scripts\engine\utility::array_randomize(var_1);
  }
}

function ref_12348(var_0) {
  var_1 = level.disable_super_in_turret.setsuperisinuse[self.setchainkillstreaks];
  var_2 = randomfloat(1);
  var_3 = 0;
  var_4 = 0;

  for(var_5 = 0; var_5 < 4; var_5++) {
    if(var_5 > 0 && level.disable_super_in_turret.setspecialistbonus[var_5].size) {
      var_4 = var_5;
    }

    var_3 += scripts\engine\math::lerp(var_1.setpostgamestate[var_5][0], var_1.setpostgamestate[var_5][1], var_0);

    if(var_3 >= var_2) {
      return var_4;
    }
  }
}

function ref_12347(var_0) {
  var_1 = undefined;

  if(isDefined(self.sales_discount_items[var_0])) {
    var_1 = self.sales_discount_items[var_0] % level.disable_super_in_turret.setspecialistbonus[var_0].size;
    self.sales_discount_items[var_0]++;
  }

  return var_1;
}

function update(var_0) {
  self endon("death");
  self endon("disconnect");

  if(istrue(self.setbuybackpingmessage)) {
    return;
  }

  self.setcachedclientomnvar = var_0;
  self.setchainkillstreaks = remove_fake_guy_from_list(var_0);
  var_1 = level.disable_super_in_turret.setsuperisinuse[self.setchainkillstreaks];
  var_2 = run_hotjoin_loadout_thread();
  var_3 = (scripts\engine\math::lerp(var_1.time[0], var_1.time[1], var_2) + var_1.initlootvaultkeypad) * 1000;

  if(self.setcachedgameomnvar + var_3 < gettime()) {
    var_4 = ref_12348(var_2);

    if(var_4 != 0) {
      self.setbuybackpingmessage = 1;
      var_5 = ref_12347(var_4);

      if(isDefined(var_5)) {
        var_0 = level.disable_super_in_turret.setspecialistbonus[var_4][var_5];
        ref_13fdb(var_0.playerplunderlosecallback);
        [[var_0.function]](var_0.data);
        scripts\mp\gametypes\br_gxp_fear::placementupdatewait("onPlayerHallucinate", var_0);
      }
    }

    self.setbuybackpingmessage = 0;
    self.setcachedgameomnvar = gettime();
    freight_lift_attacker_internal();
    return;
  }
}

function ref_13fdb(var_0) {
  if(getdvarint("scr_disable_hallucination_fov_shift", 0)) {
    return;
  }

  if(!isDefined(var_0)) {
    return;
  }

  self lerpfovbypreset("hallucination");

  if(var_0.type == "fov_low") {
    self visionsetnakedforplayer("mp_gxp_fov_low", 1);
  } else {
    self visionsetnakedforplayer("mp_gxp_fov_medium", 1);
  }

  thread mp_runner_patch(var_0.length);
  thread has_access_card();

  if(isDefined(var_0.watchspawnwallplayerexit) && var_0.watchspawnwallplayerexit > 0) {
    wait var_0.watchspawnwallplayerexit;
    return;
  }
}

function has_target_player() {
  self.setcachedgameomnvar = gettime();
  self.setcachedclientomnvar = 0;
  self.setchainkillstreaks = 0;
  self.setbuybackpingmessage = 0;
}

function setsoundsubmixfadetoblackamb(var_0) {
  self playsoundtoplayer(var_0, self, self);
  wait 3;
}

function setquestrewardtierteamomnvar(var_0) {
  level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward(var_0, self, 1);
  wait 3;
}

function setroundwinstreakspecialcamos(var_0) {
  self setplayermusicstate(var_0);
  wait 3;
}

function setradarparamsonlatejoiner(var_0) {
  self endon("disconnect");

  if(istrue(var_0.ref_1276e)) {
    ref_12739();
  }

  self setclientomnvar("ui_halloween_event", var_0.index);
  var_1 = 3;
  wait var_0.length;
}

function setspawninstances(var_0) {
  self endon("death");

  if(istrue(var_0.ref_1276e)) {
    ref_12739();
  }

  playfxontagforclients(scripts\engine\utility::getfx(var_0.fx), self, "tag_eye", self);
  wait var_0.length;
}

function setsuperexpended(var_0) {
  scripts\cp_mp\emp_debuff::play_emp_scramble(5);
  thread has_module_met_max_vehicles();
  never_kill_off_old(var_0);
}

function never_kill_off_old(var_0) {
  self endon("death");
  self endon("disconnect");
  wait var_0;
  self notify("end_scramble_hud");
  scripts\cp_mp\emp_debuff::stop_emp_scramble(5);
}

function has_module_met_max_vehicles() {
  self endon("disconnect");
  self endon("end_scramble_hud");
  self waittill("death");
  scripts\cp_mp\emp_debuff::stop_emp_scramble(5);
}

function setreduceregendelayonkill(var_0) {
  var_1 = rungwperif_largeexplosions(var_0);

  if(!isDefined(var_1)) {
    return;
  }

  var_2 = relic_healthpacks_globalfunc(var_1.origin);

  if(!isDefined(var_2)) {
    return;
  }

  playfxontagforclients(level._effect["vfx_ghost_death_3p"], var_1, "j_spineupper", var_2);
  ref_119c2(var_2, "vfx_ghost_death_3p", "corpsevfx");
}

function rungwperif_largeexplosions(var_0) {
  var_1 = gettime();
  var_2 = var_1 + 250;
  var_3 = undefined;

  while(isDefined(var_0) && var_1 < var_2) {
    var_3 = var_0 getcorpseentity();

    if(isDefined(var_3)) {
      return var_3;
    }

    waitframe();
    var_1 = gettime();
  }

  return undefined;
}

function relic_healthpacks_globalfunc(var_0) {
  var_1 = level.disable_super_in_turret.setpreviewuicircle;

  if(isDefined(var_1) && var_1 scripts\mp\gametypes\br_gxp_fear::get_ai_hearing_bomb_plant_sound() && level.disable_super_in_turret.setquestindexomnvar < gettime()) {
    if(distance2dsquared(var_0, var_1.origin) > level.disable_super_in_turret.play_3p_anim_non_animscene.immediatecleanup * level.disable_super_in_turret.play_3p_anim_non_animscene.immediatecleanup) {
      return undefined;
    }

    var_2 = anglesToForward(var_1.angles);
    var_3 = vectorNormalize(var_0 - var_1.origin);

    if(vectordot(var_2, var_3) <= 0) {
      return undefined;
    }

    return var_1;
  }

  var_4 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "getPlayersInRadius")) {
    var_4 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "getPlayersInRadius")]](var_2, level.disable_super_in_turret.play_3p_anim_non_animscene.immediatecleanup);
  }

  var_4 = scripts\engine\utility::array_randomize(var_4);

  foreach(var_3 in var_4) {
    if(!isalive(var_3) || var_3 scripts\mp\gametypes\br_public::ref_125ec() || !var_3 scripts\mp\gametypes\br_gxp_fear::get_ai_hearing_bomb_plant_sound()) {
      continue;
    }

    var_2 = anglesToForward(var_3.angles);
    var_3 = vectorNormalize(var_2 - var_3.origin);

    if(vectordot(var_2, var_3) <= 0) {
      continue;
    }

    level.disable_super_in_turret.setpreviewuicircle = var_3;
    level.disable_super_in_turret.setquestindexomnvar = gettime() + level.disable_super_in_turret.play_3p_anim_non_animscene.illumination_flare_init;
    return var_3;
  }

  return undefined;
}

function ref_11e33() {
  for(;;) {
    var_0 = scripts\engine\utility::array_randomize(level.players);

    foreach(var_2 in var_0) {
      if(!isDefined(var_2) || !isalive(var_2) || var_2 scripts\mp\gametypes\br_public::ref_125ec() || !var_2 scripts\mp\gametypes\br_gxp_fear::get_ai_hearing_bomb_plant_sound()) {
        continue;
      }

      if(isDefined(var_2.setreduceregendelayonkills) && var_2.setreduceregendelayonkills > gettime()) {
        continue;
      }

      var_3 = reset_current_step_count(var_2, level.disable_super_in_turret.play_3p_anim_non_animscene.ref_126e5);

      if(isDefined(var_3)) {
        playfxontagforclients(level._effect["vfx_gxp_chest_bluefire_death"], var_3, "j_spineupper", var_2);
        var_2.setreduceregendelayonkills = gettime() + randomintrange(level.disable_super_in_turret.play_3p_anim_non_animscene.ref_126e4, level.disable_super_in_turret.play_3p_anim_non_animscene.ref_126e3);
        ref_119c2(var_2, "vfx_gxp_chest_bluefire_death", "nearbyplayervfx");
      }

      waitframe();
    }

    waitframe();
  }
}

function setquestrewardtier(var_0) {
  self endon("death");
  var_1 = gettime() + var_0.module_set_goal_height * 1000;
  var_2 = randomfloat(360);
  var_3 = 3000;

  while(var_1 > gettime()) {
    if(randomfloat(1) < var_0.ref_145be) {
      self playsoundtoplayer("", self);
    } else {
      var_4 = angleclamp(var_2 + randomfloat(var_0.building_magic_grenades));
      var_5 = cos(var_4);
      var_6 = sin(var_4);
      var_7 = (var_5, var_6, 0);
      var_8 = self getEye();
      var_9 = var_8 + var_7 * var_3;
      self playsoundtoplayer("bullet_small_flesh_torso_plr", self);
      self.donotmodifydamage = 1;
      self dodamage(1, var_9, level.disable_super_in_turret.setquestindexteamomnvar);
      self.donotmodifydamage = undefined;
    }

    wait randomfloatrange(var_0.trial_race_lap_total_override, var_0.trial_target_requisites);
  }
}

function pavelow_boss_hit_by_emp(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.module_set_goal_height = var_0;
  var_5.trial_race_lap_total_override = var_1;
  var_5.trial_target_requisites = var_2;
  var_5.building_magic_grenades = var_3;
  var_5.ref_145be = var_4;
  return var_5;
}

function reset_current_step_count(var_0, var_1) {
  var_2 = anglesToForward(var_0.angles);
  var_3 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "getPlayersInRadius")) {
    var_3 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "getPlayersInRadius")]](var_0.origin, var_1);
  }

  var_3 = scripts\engine\utility::array_randomize(var_3);

  foreach(var_5 in var_3) {
    if(var_5 == var_0 || var_5 scripts\mp\gametypes\br_public::ref_125ec() || !isalive(var_5)) {
      continue;
    }

    var_6 = vectorNormalize(var_5.origin - var_0.origin);

    if(vectordot(var_2, var_6) <= 0) {
      continue;
    }

    return var_5;
  }

  return undefined;
}

function setquestrewardtieromnvar(var_0) {
  self lerpfovbypreset("hallucination");
  self visionsetnakedforplayer("mp_gxp_fov_shift", 1);
  thread has_access_card();
  mp_runner_patch(var_0);
}

function mp_runner_patch(var_0) {
  self endon("death");
  self endon("disconnect");
  wait var_0;
  self notify("end_fov_hud");
  self lerpfovbypreset("default_fast");
  self visionsetnakedforplayer("", 2);
}

function has_access_card() {
  self endon("disconnect");
  self endon("end_fov_hud");
  self waittill("death");
  self lerpfovbypreset("default");
  self visionsetnakedforplayer("", 0);
}

function ref_12739() {
  self playsoundtoplayer("br_gov_hallucination_sting", self, self);
  wait 0.1;
}

function ref_119c2(var_0, var_1) {
  var_2 = [];
  GscBinSkip0(0x2e, var_2.size, "time_msfrommatchstart");
}

function ref_119c3(var_0) {
  ref_119c2(var_0, "announcer");
}

function ref_119c9(var_0) {
  ref_119c2(var_0, "sound");
}

function ref_119c7(var_0) {
  ref_119c2(var_0, "music");
}

function ref_119c4(var_0) {
  ref_119c2(var_0.cinematic, "cinematic");
}

function ref_119ca(var_0) {
  ref_119c2(var_0, "vfx");
}

function ref_119c8(var_0) {
  ref_119c2(var_0, "scramblehud");
}

function ref_119c5(var_0) {
  ref_119c2(var_0.module_set_goal_height, "fakedamage");
}

function ref_119c6(var_0) {
  ref_119c2(var_0, "fov");
}

function level_ammo_crate_spawn() {
  if(self.setcachedclientomnvar == 0) {
    return (1, 1, 1);
  }

  return level.disable_super_in_turret.setsuperisinuse[self.setchainkillstreaks].left_control;
}