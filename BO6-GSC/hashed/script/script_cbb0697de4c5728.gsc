/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_cbb0697de4c5728.gsc
****************************************************/

#using scripts\common\callbacks;
#using scripts\cp_mp\crossbow;
#using scripts\cp_mp\operator;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#namespace mtx_weapon;

function function_f877fea1e7d31f31() {
  ismgl = getdvarint(@ "mgl", 0) != 0;
  level.var_40db9032567cfca7 = [];
  level.var_2a53ffec3874a987 = [];
  level.var_6cc157c91ced44eb = [];
  level.var_839fe802490703e4 = [];
  level.var_d8010ce982c6daa5 = [];
  level.var_6cd087ff5695816b = [];
  level.var_8b428a7abd4b5588 = [];
  level.var_f1aeabe082d92591 = [];
  level.var_cc75e39215a1ee5a = [];
  level.var_7c58ad8fa1e541fa = [];
  level.var_c4d8205fc5f06ab5 = [];
  projectname = getprojectname();

  if(isbrgamemode() || ismgl) {
    level._effect["youveBeenNaughty_limb"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_naughty_limb");
    level._effect["youveBeenNaughty_torso"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_naughty_torso");
    level._effect["youveBeenNaughty_head"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_naughty_head");
    level._effect["youveBeenNice_limb"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_nice_limb");
    level._effect["youveBeenNice_torso"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_nice_torso");
    level._effect["youveBeenNice_head"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_nice_head");
    level._effect["vDay_limb"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_vday_limb");
    level._effect["vDay_torso"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_vday_torso");
    level._effect["vDay_head"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_vday_head");
    level._effect["bCell_limb"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_bcell_limb");
    level._effect["bCell_torso"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_bcell_torso");
    level._effect["bCell_head"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_bcell_head");
    level._effect["bCell_nogore_limb"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_bcell_nogore_limb");
    level._effect["bCell_nogore_torso"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_bcell_nogore_torso");
    level._effect["bCell_nogore_head"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_bcell_nogore_head");
    level._effect["paddy_limb"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_paddy_limb");
    level._effect["paddy_torso"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_paddy_torso");
    level._effect["paddy_head"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_paddy_head");
    level._effect["easter_limb"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_easter_limb");
    level._effect["easter_torso"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_easter_torso");
    level._effect["easter_head"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_easter_head");
    level._effect["easter_nogore_limb"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_easter_nogore_limb");
    level._effect["easter_nogore_torso"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_easter_nogore_torso");
    level._effect["easter_nogore_head"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_easter_nogore_head");
    level._effect["scifi_limb"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_scifi_limb");
    level._effect["scifi_torso"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_scifi_torso");
    level._effect["scifi_head"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_scifi_head");
    level._effect["scifi_origin"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_scifi_death_mesh");
    level._effect["scifi2_limb"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_scifi2_limb");
    level._effect["scifi2_torso"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_scifi2_torso");
    level._effect["scifi2_head"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_scifi2_head");
    level._effect["scifi2_origin"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_scifi2_death_mesh");
    level._effect["scifi3_limb"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_scifi3_limb");
    level._effect["scifi3_torso"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_scifi3_torso");
    level._effect["scifi3_head"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_scifi3_head");
    level._effect["scifi3_origin"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_scifi3_death_mesh");
    level._effect["420_death"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_fatal_weed_sh");
    level._effect["hitscan"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_hitscan_fatal");
    level._effect["thor"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_thor_fatal");
    level._effect["thor_chest"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_thor_fatal_chest");
    level._effect["golden_gun_limb"] = loadfxasset("vfx_jup_weapon_mtx_s1_impact_terminus_goldengun_limb");
    level._effect["golden_gun_torso"] = loadfxasset("vfx_jup_weapon_mtx_s1_impact_terminus_goldengun_torso");
    level._effect["golden_gun_head"] = loadfxasset("vfx_jup_weapon_mtx_s1_impact_terminus_goldengun_head");
    level._effect["golden_gun_origin"] = loadfxasset("vfx_jup_weapon_mtx_s1_impact_terminus_goldengun_death_mesh");
    level._effect["soulEater_limb"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_souleater_limb");
    level._effect["soulEater_torso"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_souleater_torso");
    level._effect["soulEater_head"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_souleater_head");
    level._effect["soulEater_death"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_soul_fatal");
    level._effect["crash_limb"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_crash_limb");
    level._effect["crash_torso"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_crash_torso");
    level._effect["crash_head"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_crash_head");
    level._effect["cthulhu_limb"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_cthulhu_limb");
    level._effect["cthulhu_torso"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_cthulhu_torso");
    level._effect["cthulhu_head"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_cthulhu_head");
    level._effect["cthulhu_nogore_limb"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_cthulhu_nogore_limb");
    level._effect["cthulhu_nogore_torso"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_cthulhu_nogore_torso");
    level._effect["cthulhu_nogore_head"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_cthulhu_nogore_head");
    level._effect["akihabara_fatal"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_akihabara_fatal");
    level._effect["hlander_limb"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_hlander_limb");
    level._effect["hlander_torso"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_hlander_torso");
    level._effect["hlander_head"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_hlander_head");
    level._effect["hlander_nogore_limb"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_hlander_nogore_limb");
    level._effect["hlander_nogore_torso"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_hlander_nogore_torso");
    level._effect["hlander_nogore_head"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_hlander_nogore_head");
    level._effect["nicki_limb"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_nicki_limb");
    level._effect["nicki_torso"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_nicki_torso");
    level._effect["nicki_head"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_nicki_head");
    level._effect["ice_limb"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_ice_limb");
    level._effect["ice_torso"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_ice_torso");
    level._effect["ice_head"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_ice_head");
    level._effect["ice_nogore_limb"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_ice_limb_nogore");
    level._effect["ice_nogore_torso"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_ice_torso_nogore");
    level._effect["tomb_limb"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_lara_fatal_limb");
    level._effect["tomb_torso"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_lara_fatal_torso");
    level._effect["tomb_head"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_lara_fatal_head");
    level._effect["tomb_limb_nogore"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_lara_fatal_limb_nogore");
    level._effect["tomb_torso_nogore"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_lara_fatal_torso_nogore");
    level._effect["tomb_head_nogore"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_lara_fatal_head_nogore");
    level._effect["tomb_limb"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_lara_fatal_limb");
    level._effect["tomb_torso"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_lara_fatal_torso");
    level._effect["tomb_head"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_lara_fatal_head");
    level._effect["hips_limb"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_hips_limb");
    level._effect["hips_torso"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_hips_torso");
    level._effect["hips_head"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_hips_head");
    level._effect["hops_limb"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_hops_limb");
    level._effect["hops_torso"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_hops_torso");
    level._effect["hops_head"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_hops_head");
    level._effect["maze_limb"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_maze_limb");
    level._effect["maze_torso"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_maze_torso");
    level._effect["maze_head"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_maze_head");
    level._effect["maze_nogore_limb"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_maze_nogore_limb");
    level._effect["maze_nogore_torso"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_maze_nogore_torso");
    level._effect["maze_nogore_head"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_maze_nogore_head");
    level._effect["bcell6_limb"] = loadfxasset("vfx_iw9_core_operators_reactive_bcell6_mtx_fatal_explode_limb");
    level._effect["bcell6_torso"] = loadfxasset("vfx_iw9_core_operators_reactive_bcell6_mtx_fatal_explode_torso");
    level._effect["bcell6_head"] = loadfxasset("vfx_iw9_core_operators_reactive_bcell6_mtx_fatal_explode_head");
    level._effect["lilith"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_lilith_fatal");
    level._effect["inarius"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_inarius_fatal");
    level._effect["witch"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_witch_s6_impact_fatal");
    level._effect["zombie"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_zombie_s6_impact_fatal");
    level._effect["boys_super_str"] = loadfxasset("vfx_jup_weapon_mtx_s1_death_all_purpose_dismemberment_super_str_01");
    level._effect["40k"] = loadfxasset("vfx_jup_weapon_mtx_s2_impact_40k_flesh_fatal");
    level._effect["blackcell"] = loadfxasset("vfx_jup_weapon_mtx_s3_impact_blackcell_flesh_fatal");
    level._effect["underworld"] = loadfxasset("vfx_jup_weapon_mtx_s6_impact_underworld_flesh_fatal");
    level._effect["wonton"] = loadfxasset("vfx_jup_s4_weapon_mtx_impact_dough_wonton_melee_flesh_fatal");
    level._effect["mandu"] = loadfxasset("vfx_jup_s4_weapon_mtx_impact_dough_mandu_melee_flesh_fatal");
    level._effect["tonfa"] = loadfxasset("vfx_jup_weapon_mtx_s2_impact_tonfa_flesh_fatal");
    level._effect["blackcell_s5"] = loadfxasset("vfx_jup_weapon_mtx_s5_impact_blackcell_melee_flesh_fatal");
    level._effect["gilman"] = loadfxasset("vfx_jup_weapon_mtx_s5_impact_entagled_flesh_fatal");
    level._effect["shapechanger"] = loadfxasset("vfx_jup_weapon_mtx_s5_impact_shapechanger_melee_flesh_fatal");
    level._effect["bikeMelee"] = loadfxasset("vfx_jup_weapon_mtx_s2_impact_michonne_flesh_fatal");
    level._effect["vinyl"] = loadfxasset("vfx_jup_weapon_mtx_s5_impact_vinyl_flesh_fatal_melee");
    level._effect["pineapple"] = loadfxasset("vfx_jup_equip_mtx_s3_thermo_pineapple_flesh_fatal");
    level._effect["vinyl"] = loadfxasset("vfx_jup_weapon_mtx_s5_impact_vinyl_flesh_fatal");
    level._effect["vinyl_heavy"] = loadfxasset("vfx_jup_weapon_mtx_s5_impact_vinyl_flesh_fatal_melee");
    level._effect["voxel"] = loadfxasset("vfx_jup_weapon_mtx_s1_impact_arcade_flesh_fatal");
    level._effect["oreZincMelee"] = loadfxasset("vfx_jup_weapon_mtx_s6_impact_orezinc_melee_flesh_fatal");
    level._effect["mahou_limb"] = loadfxasset("vfx_jup_weapon_mtx_s6_death_echoendo_mahou_explo_limb");
    level._effect["mahou_torso"] = loadfxasset("vfx_jup_weapon_mtx_s6_death_echoendo_mahou_explo_torso");
    level._effect["mahou_head"] = loadfxasset("vfx_jup_weapon_mtx_s6_death_echoendo_mahou_explo_head");
    level._effect["mahou_origin"] = loadfxasset("vfx_jup_weapon_mtx_s6_death_echoendo_mahou_explo_mesh");
  }

  if(projectname == "T10" || projectname == "SAT" || projectname == "WZ2" || projectname == "SAW") {
    if(level.var_6a98fcae23c2e606) {
      level._effect["raygunRepair"] = loadfxasset("vfx_t10_core_mtx_dth_repair_flesh_fatal");
    }

    level._effect["vault"] = loadfxasset("vfx_t10_core_weapons_mtx_death_dth_me_vault");
    level._effect["vault_safe"] = loadfxasset("vfx_t10_core_weapons_mtx_death_dth_me_vault_safe");
    level._effect["steampunk"] = loadfxasset("vfx_t10_dth_mtx_steampunk_fatal");
    level._effect["steampunk_head"] = loadfxasset("vfx_t10_dth_mtx_steampunk_head");
    level._effect["steampunk_torso"] = loadfxasset("vfx_t10_dth_mtx_steampunk_torso");
    level._effect["steampunk_arm_left"] = loadfxasset("vfx_t10_dth_mtx_steampunk_arm_left");
    level._effect["steampunk_arm_right"] = loadfxasset("vfx_t10_dth_mtx_steampunk_arm_right");
    level._effect["steampunk_leg_left"] = loadfxasset("vfx_t10_dth_mtx_steampunk_leg_left");
    level._effect["steampunk_leg_right"] = loadfxasset("vfx_t10_dth_mtx_steampunk_leg_right");
    level._effect["gvibes"] = loadfxasset("vfx_t10_dth_mtx_good_vibes");
    level._effect["deadops"] = loadfxasset("vfx_t10_dth_mtx_deadops_flesh_fatal");
    level._effect["cartoon"] = loadfxasset("vfx_t10_core_weapons_mtx_death_cartoon_dth_fatal");
    level._effect["tmnt_slime"] = loadfxasset("vfx_t10_dth_mtx_tmnt_slime_fatal");
    level._effect["tmnt_don"] = loadfxasset("vfx_t10_dth_mtx_tmnt_donatello");
    level._effect["tmnt_mike"] = loadfxasset("vfx_t10_dth_mtx_tmnt_michelangelo");
    level._effect["tmnt_raph"] = loadfxasset("vfx_t10_dth_mtx_tmnt_melee_raphael");
    level._effect["tmnt_leo"] = loadfxasset("vfx_t10_dth_mtx_tmnt_melee_leo");
    level._effect["bigjoke"] = loadfxasset("vfx_t10_dth_mtx_bigjoke_melee");
    level._effect["bbots"] = loadfxasset("vfx_t10_dth_mtx_bbots_flesh_fatal");
    level._effect["comic_strip"] = loadfxasset("vfx_t10_dth_mtx_comic_strip_flesh_fatal");
    level._effect["bacon"] = loadfxasset("vfx_t10_core_weapons_mtx_death_bacon_fatal");
    level._effect["tomato"] = loadfxasset("vfx_t10_dth_mtx_tomato_fatal");
    level._effect["ssword"] = loadfxasset("vfx_t10_dth_mtx_ssword_fatal");
    level._effect["dino"] = loadfxasset("vfx_t10_dth_mtx_dino_flesh_fatal");
    level._effect["corgi"] = loadfxasset("vfx_t10_dth_mtx_corgi_nachos");
    level._effect["aqueen"] = loadfxasset("vfx_t10_dth_mtx_alien");
    level._effect["hobbyhorse"] = loadfxasset("vfx_t10_mtx_hobbyhorse_impact_med_flesh_fatal");
    level._effect["poodle"] = loadfxasset("vfx_t10_dth_mtx_poodle_fatal");
    level._effect["ikwydls"] = loadfxasset("vfx_t10_dth_mtx_ikwydls");
    level._effect["ahstormare"] = loadfxasset("vfx_t10_dth_mtx_ahstormare_flesh_fatal");
    level._effect["tsoldier"] = loadfxasset("vfx_t10_dth_mtx_tsoldier_flesh_fatal");
    level._effect["wninja"] = loadfxasset("vfx_t10_dth_mtx_wninja_flesh_fatal");
    level._effect["bluntev"] = loadfxasset("vfx_t10_core_weapons_mtx_death_stoner_dth_fatal");
    level._effect["caramel"] = loadfxasset("vfx_t10_dth_mtx_caramel_flesh_fatal");
    level._effect["mskate"] = loadfxasset("vfx_t10_dth_mtx_mskate_fatal");
    level._effect["bostaff_larpers"] = loadfxasset("vfx_t10_mtx_mpug40_death_ch");
    level._effect["cer_LimbDismemberment"] = loadfxasset("vfx_t10_char_generic_dismemberment");
    level._effect["cer_Annihilation"] = loadfxasset("vfx_t10_char_generic_annihilation");
  }

  if(ismgl) {
    level._effect["sbandit_fatal"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_flesh_ftl_bdt");
    level._effect["spider_fatal"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_death_alpha50_spider");
    level._effect["mech_fatal"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_death_svictor_mech");
    level._effect["spaceignition_fatal"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_flesh_fatal_spaceignition");
    level._effect["arcstorm_fatal"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_death_mike4_arcstorm");
    level._effect["yokai_fatal"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_death_aviktor_yokai");
    level._effect["outbreak_fatal"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_death_mcbravo_biohazard");
    level._effect["techwear_fatal"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_flesh_fatal_techwear");
    level._effect["chickentendies_fatal"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_death_ahotel_chickentendies");
    level._effect["d20_fatal"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_death_acharlie300_d20");
    level._effect["brassgolem_fatal"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_death_apapa_brassgolem");
    level._effect["slatedprism_fatal"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_slatedprism_fatal");
    level._effect["crytempest_fatal"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_crystal_tempest_fatal");
    level._effect["cyberviking_fatal"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_flesh_fatal_cyber_viking");
    level._effect["banshee_fatal"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_flesh_fatal_banshee");
    level._effect["cronen_squall_fatal"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_cronen_squall_fatal");
    level._effect["toxic_terror_fatal"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_toxic_terror_fatal");
    level._effect["spectral_ghost_fatal"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_spectral_ghost_fatal");
    level._effect["hades_hands_fatal"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_flesh_fatal_hades_hands");
    level._effect["prismatic_force_fatal"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_flesh_fatal_prismatic_force");
    level._effect["rhino_armor_fatal"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_rhino_armor_fatal");
    level._effect["rhino_armor_fatal_ground"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_rhino_armor_fatal_ground");
    level._effect["rhino_armor_fatal_arm"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_rhino_armor_fatal_arm");
    level._effect["rhino_armor_fatal_head"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_rhino_armor_fatal_head");
    level._effect["vfx_imp_flesh_fatal_gunhead"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_flesh_fatal_gunhead");
    level._effect["vfx_imp_flesh_fatal_gunhead_leg"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_flesh_fatal_gunhead_leg");
    level._effect["vfx_imp_flesh_fatal_gunhead_arm"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_flesh_fatal_gunhead_arm");
    level._effect["vfx_imp_flesh_fatal_gunhead_head"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_flesh_fatal_gunhead_head");
    level._effect["vampire_hunter_fatal"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_vampire_hunter_fatal");
    level._effect["vampire_hunter_fatal_ground"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_vampire_hunter_fatal_ground");
    level._effect["anime_knights_fatal"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_anime_knights_fatal");
    level._effect["anime_knights_fatal_ground"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_anime_knights_fatal_ground");
    level._effect["harlequin_fatal"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_flesh_fatal_harlequin");
    level._effect["sadistic_fatal"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_death_boscar_sadistic");
    level._effect["striker_wizards_fatal"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_striker_wizards_fatal");
    level._effect["striker_wizards_fatal_ground"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_striker_wizards_fatal_ground");
    level._effect["necromancer_fatal"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_death_anov94_necromancer");
    level._effect["eldritch_fatal"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_flesh_fatal_eldritch");
    level._effect["cyberwizard_fatal"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_impact_flesh_fatal_pkilob_cyberwizard");
    level._effect["cyberwizard_fatal"] = loadfxasset("vfx_iw9_core_weapons_impacts_mtx_death_pkilob_cyberwizard");
    level._effect["vault"] = loadfxasset("vfx_t10_core_weapons_mtx_death_dth_me_vault");
    level._effect["vault_safe"] = loadfxasset("vfx_t10_core_weapons_mtx_death_dth_me_vault_safe");
    level._effect["steampunk"] = loadfxasset("vfx_t10_dth_mtx_steampunk_fatal");
    level._effect["steampunk_head"] = loadfxasset("vfx_t10_dth_mtx_steampunk_head");
    level._effect["steampunk_torso"] = loadfxasset("vfx_t10_dth_mtx_steampunk_torso");
    level._effect["steampunk_arm_left"] = loadfxasset("vfx_t10_dth_mtx_steampunk_arm_left");
    level._effect["steampunk_arm_right"] = loadfxasset("vfx_t10_dth_mtx_steampunk_arm_right");
    level._effect["steampunk_leg_left"] = loadfxasset("vfx_t10_dth_mtx_steampunk_leg_left");
    level._effect["steampunk_leg_right"] = loadfxasset("vfx_t10_dth_mtx_steampunk_leg_right");
    level._effect["gvibes"] = loadfxasset("vfx_t10_dth_mtx_good_vibes");
    level._effect["deadops"] = loadfxasset("vfx_t10_dth_mtx_deadops_flesh_fatal");
    level._effect["cartoon"] = loadfxasset("vfx_t10_core_weapons_mtx_death_cartoon_dth_fatal");
    level._effect["tmnt_slime"] = loadfxasset("vfx_t10_dth_mtx_tmnt_slime_fatal");
    level._effect["tmnt_don"] = loadfxasset("vfx_t10_dth_mtx_tmnt_donatello");
    level._effect["tmnt_mike"] = loadfxasset("vfx_t10_dth_mtx_tmnt_michelangelo");
    level._effect["tmnt_raph"] = loadfxasset("vfx_t10_dth_mtx_tmnt_melee_raphael");
    level._effect["tmnt_leo"] = loadfxasset("vfx_t10_dth_mtx_tmnt_melee_leo");
    level._effect["bigjoke"] = loadfxasset("vfx_t10_dth_mtx_bigjoke_melee");
    level._effect["bbots"] = loadfxasset("vfx_t10_dth_mtx_bbots_flesh_fatal");
    level._effect["comic_strip"] = loadfxasset("vfx_t10_dth_mtx_comic_strip_flesh_fatal");
    level._effect["bacon"] = loadfxasset("vfx_t10_core_weapons_mtx_death_bacon_fatal");
    level._effect["tomato"] = loadfxasset("vfx_t10_dth_mtx_tomato_fatal");
    level._effect["ssword"] = loadfxasset("vfx_t10_dth_mtx_ssword_fatal");
    level._effect["dino"] = loadfxasset("vfx_t10_dth_mtx_dino_flesh_fatal");
    level._effect["corgi"] = loadfxasset("vfx_t10_dth_mtx_corgi_nachos");
    level._effect["aqueen"] = loadfxasset("vfx_t10_dth_mtx_alien");
    level._effect["hobbyhorse"] = loadfxasset("vfx_t10_mtx_hobbyhorse_impact_med_flesh_fatal");
    level._effect["poodle"] = loadfxasset("vfx_t10_dth_mtx_poodle_fatal");
    level._effect["ikwydls"] = loadfxasset("vfx_t10_dth_mtx_ikwydls");
    level._effect["ahstormare"] = loadfxasset("vfx_t10_dth_mtx_ahstormare_flesh_fatal");
    level._effect["tsoldier"] = loadfxasset("vfx_t10_dth_mtx_tsoldier_flesh_fatal");
    level._effect["wninja"] = loadfxasset("vfx_t10_dth_mtx_wninja_flesh_fatal");
    level._effect["bluntev"] = loadfxasset("vfx_t10_core_weapons_mtx_death_stoner_dth_fatal");
    level._effect["caramel"] = loadfxasset("vfx_t10_dth_mtx_caramel_flesh_fatal");
    level._effect["mskate"] = loadfxasset("vfx_t10_dth_mtx_mskate_fatal");
    level._effect["bostaff_larpers"] = loadfxasset("vfx_t10_mtx_mpug40_death_ch");
    level._effect["cer_LimbDismemberment"] = loadfxasset("vfx_t10_char_generic_dismemberment");
    level._effect["cer_Annihilation"] = loadfxasset("vfx_t10_char_generic_annihilation");
  }

  function_ee3da014a4117632(#"naughtydeath", &function_3907722283e6b0f8);
  function_ee3da014a4117632(#"nicedeath", &function_4dcedcc964c16d5f);
  function_ee3da014a4117632(#"vday", &function_b4612ce187e9d454);
  function_ee3da014a4117632(#"pshock", &function_d5227e415aefad26);
  function_ee3da014a4117632(#"bcell", &function_9226837f2c138ede);
  function_ee3da014a4117632(#"paddy", &function_e2b3079d82da0de6);
  function_ee3da014a4117632(#"shredder", &function_4acec9eae72b50af);
  function_ee3da014a4117632(#"sbandit", &function_dd39f676c0c099e1);
  function_ee3da014a4117632(#"spider", &function_2f17d26b59e4021f);
  function_ee3da014a4117632(#"arcstorm", &function_688a6360ee004683);
  function_ee3da014a4117632(#"yokai", &function_fca1dd0006b8d105);
  function_ee3da014a4117632(#"outbreak", &function_e0435f3257140865);
  function_ee3da014a4117632(#"chickentendies", &function_875d9576c3d285d7);
  function_ee3da014a4117632(#"d20", &function_bea62625173f2f22);
  function_ee3da014a4117632(#"techwear", &function_31ad67ef393627b1);
  function_ee3da014a4117632(#"hades_hands", &function_2a424a972b512d77);
  function_ee3da014a4117632(#"prismatic_force", &function_47d45fb04a6a6151);
  function_ee3da014a4117632(#"gunhead", &function_430241fe33189a30);
  function_ee3da014a4117632(#"brassgolem", &function_78c680d497103381);
  function_ee3da014a4117632(#"slatedprism", &function_6856bb2d373441ec);
  function_ee3da014a4117632(#"cyberviking", &function_2b8125f68ce7d135);
  function_ee3da014a4117632(#"banshee", &function_b32af13599aae6b8);
  function_ee3da014a4117632(#"cronen_squall", &function_517b342d8a83238e);
  function_ee3da014a4117632(#"toxic_terror", &function_b7f085a894181de2);
  function_ee3da014a4117632(#"spectralghost", &function_ed3e40ce6e799b8c);
  function_ee3da014a4117632(#"dark_avengers", &function_8211ec22561d54ca);
  function_ee3da014a4117632(#"crytempest", &function_7d85d806fae44cb6);
  function_ee3da014a4117632(#"rhino_armor", &function_1fe1dde207b07666);
  function_ee3da014a4117632(#"mech", &function_d2f5fbf15fba705f);
  function_ee3da014a4117632(#"vampire_hunter", &function_f3b248f8f490901b);
  function_ee3da014a4117632(#"anime_knights", &function_4534e7fe41bc0d07);
  function_ee3da014a4117632(#"harlequin", &function_fbb92c11b3a762ef);
  function_ee3da014a4117632(#"eldritch", &function_2dc8a868c2055cf);
  function_ee3da014a4117632(#"striker_wizards", &function_d3e15a40ed423fed);
  function_ee3da014a4117632(#"electricAnime", &function_3dd4cd23f7a40b3b);
  function_ee3da014a4117632(#"easter", &function_156d2e3a006b9e8a);
  function_ee3da014a4117632(#"scifi", &function_10befaf2d75b1318);
  function_ee3da014a4117632(#"scifi2", &function_1e566c57e33c1b2a);
  function_ee3da014a4117632(#"scifi3", &function_71a5badf21c84daf);
  function_ee3da014a4117632(#"420", &function_7bdfb3ffd2ec0432);
  function_ee3da014a4117632(#"hitscan", &function_b4802d28df000a50);
  function_ee3da014a4117632(#"thor", &function_354884b05ce1e6e7);
  function_ee3da014a4117632(#"kd", &function_ead20b21fee118f5);
  function_ee3da014a4117632(#"cdl", &function_4a737c26e8f2af7f);
  function_ee3da014a4117632(#"soulEater", &function_8112584bc0f47cdc);
  function_ee3da014a4117632(#"crash", &mtx_crashdeath);
  function_ee3da014a4117632(#"akihabara", &function_4f239c5dd971f98c);
  function_ee3da014a4117632(#"magma", &function_6f112bc5b64c892b);
  function_ee3da014a4117632(#"cthulhu", &function_48122bf57920846d);
  function_ee3da014a4117632(#"hlander", &function_80325eed89fbbec6);
  function_ee3da014a4117632(#"bnoir", &function_d112506f4f3a72a2);
  function_ee3da014a4117632(#"nicki", &function_acc95e18efa344e6);
  function_ee3da014a4117632(#"ice", &function_526ab8ba3e720951);
  function_ee3da014a4117632(#"traider", &function_59f427e659e59656);
  function_ee3da014a4117632(#"hips", &function_cac6c215604b1bb6);
  function_ee3da014a4117632(#"hops", &function_5b4b07344f52aeac);
  function_ee3da014a4117632(#"blunt", &function_1e14fcd440666401);
  function_ee3da014a4117632(#"maze", &function_b6c61638933fc2b5);
  function_ee3da014a4117632(#"witch", &function_d29abe23b27afa99);
  function_ee3da014a4117632(#"zombie", &function_7881cf4b9ba631d2);
  function_ee3da014a4117632(#"zombiegun", &function_80325eed89fbbec6);
  function_ee3da014a4117632(#"skeletor", &function_bbd222e5d970003d);
  function_ee3da014a4117632(#"bcell6", &function_f5a201517913628c);
  function_ee3da014a4117632(#"inarius", &function_d291d7954e8bd025);
  function_ee3da014a4117632(#"lilith", &function_6ce07cbf124e29ec);
  function_ee3da014a4117632(#"souleatermelee", &function_8112584bc0f47cdc);
  function_ee3da014a4117632(#"noirmelee", &function_d112506f4f3a72a2);
  function_ee3da014a4117632(#"icemelee", &function_526ab8ba3e720951);
  function_ee3da014a4117632(#"traidermelee", &function_59f427e659e59656);
  function_ee3da014a4117632(#"souleaterequip", &function_8112584bc0f47cdc);
  function_ee3da014a4117632(#"iceequip", &function_526ab8ba3e720951);
  function_ee3da014a4117632(#"40kMelee", &function_f93e3f01a1b7a791);
  function_ee3da014a4117632(#"blackcell_s5Melee", &function_101cbff94707b454);
  function_ee3da014a4117632(#"underworldMelee", &function_2b9bf1a3a1bfe13e);
  function_ee3da014a4117632(#"wontonMelee", &function_5e11e3a4b3b78d7d);
  function_ee3da014a4117632(#"manduMelee", &function_fe7e870e73d2d56b);
  function_ee3da014a4117632(#"blackcellmelee", &function_58456461eb2687);
  function_ee3da014a4117632(#"gilmanMelee", &function_e64be728c0e9123c);
  function_ee3da014a4117632(#"shapechangerMelee", &function_8480b4cc59c7eba5);
  function_ee3da014a4117632(#"bikeMelee", &function_9e7383d20f5bf879);
  function_ee3da014a4117632(#"pineapple", &function_ed03f0036ee25688);
  function_ee3da014a4117632(#"tonfa", &function_d178c469de8d12f0);
  function_ee3da014a4117632(#"vinyl", &function_7f3124192d315274);
  function_ee3da014a4117632(#"voxel", &function_63c6b0a82b3a5e78);
  function_ee3da014a4117632(#"oreZincMelee", &function_d7bf9ede0b764fe);

  if(level.var_6a98fcae23c2e606) {
    function_ee3da014a4117632(#"raygunRepair", &function_30f2d11294017281);
  }

  function_ee3da014a4117632(#"hash_849214ec850729a9", &function_a039e2941d94b1fa);
  function_ee3da014a4117632(#"cerannihilate", &function_f7bf5db7589592cd);
  function_ee3da014a4117632(#"vaultmelee", &function_c4bdf31f66b16d0c);
  function_ee3da014a4117632(#"steampunkmelee", &function_8a3e94642281db28);
  function_ee3da014a4117632(#"gvibesmelee", &function_70c79427f7f7b046);
  function_ee3da014a4117632(#"deadopsmelee", &function_e0d25276ba90ddd2);
  function_ee3da014a4117632(#"cartoonmelee", &function_fdef5d3b5ebecefe);
  function_ee3da014a4117632(#"hash_ef445cc36fc4f18c", &function_add52bc88c7f4b5f);
  function_ee3da014a4117632(#"hash_55b6eb9101b2e193", &function_679168476fe4e4e2);
  function_ee3da014a4117632(#"hash_345b7545d4578762", &function_3233f38770168c37);
  function_ee3da014a4117632(#"hash_d3b0705a5ff4f233", &function_8efa8b8c894fca98);
  function_ee3da014a4117632(#"hash_b651841b688039e8", &function_8fcdcad357a21cb3);
  function_ee3da014a4117632(#"bigjokemelee", &function_9ba4703156f6a935);
  function_ee3da014a4117632(#"hash_886a93f35e370183", &function_9cd1f18cc02aa1d4);
  function_ee3da014a4117632(#"hash_94c407fb854900cc", &function_19221b97e8a0fc0d);
  function_ee3da014a4117632(#"hash_327eb4b61aed9b6", &function_a4b186b340f4951d);
  function_ee3da014a4117632(#"baconmelee", &function_b01b5c2c9d832343);
  function_ee3da014a4117632(#"tomatomelee", &function_f1c4db47cbe0c4da);
  function_ee3da014a4117632(#"sswordmelee", &function_88ed32f74f3bde2e);
  function_ee3da014a4117632(#"dinomelee", &function_5cd363f0519189cc);
  function_ee3da014a4117632(#"corgimelee", &function_35bdc6f5345139d8);
  function_ee3da014a4117632(#"aqueenmelee", &function_3efb7c693ed2c9bf);
  function_ee3da014a4117632(#"hobbyhorsemelee", &function_b2235b457eb3ba6d);
  function_ee3da014a4117632(#"poodlemelee", &function_69aabe05bb1d9b65);
  function_ee3da014a4117632(#"ikwydlsmelee", &function_90969660ae379481);
  function_ee3da014a4117632(#"ahstormaremelee", &function_c6cd4b6cb3f433dc);
  function_ee3da014a4117632(#"tsoldiermelee", &function_a15233f558919f6a);
  function_ee3da014a4117632(#"wninjamelee", &function_ad81703b0dbdcfd7);
  function_ee3da014a4117632(#"bluntevmelee", &function_26bd1f44452df27c);
  function_ee3da014a4117632(#"caramelmelee", &function_c408f703e9930131);
  function_ee3da014a4117632(#"mskatemelee", &function_721f1aa368179ac3);
  function_ee3da014a4117632(#"larpersmelee", &function_6c0a75767197569b);
  function_d4f0e25fa6f90008(#"ufosm", &function_afd4ef408179cc, &function_80325eed89fbbec6);
  function_d4f0e25fa6f90008(#"ufolg", &function_c6229012d9ae2e31, &function_80325eed89fbbec6);
  function_d4f0e25fa6f90008(#"goldengun", &function_58a3eb2b8522894f, &function_3d5471b0be7f573);
  function_d4f0e25fa6f90008(#"mahou", &function_1b40b711abb69b0a, &function_cb1be48c5e1c432e);
  function_d4f0e25fa6f90008(#"hlander", &function_2b23a8d93167aaaa, &function_80325eed89fbbec6);

  if(isbrgamemode()) {
    function_d4f0e25fa6f90008(#"ww_dg2", &isdg2death, &function_ff069494f4f8611b);
    function_d4f0e25fa6f90008(#"ww_raygun", &israygundeath, &function_415cef36c96147ee);
  }

  function_1d7e46ad31886165(#"40kmeleetakedown", &function_841b8126b9ad7ec, &function_a27cf61b0f889410);
  function_1d7e46ad31886165(#"underworldmeleetakedown", &function_e201db4a8295f73b, &function_2b9bf1a3a1bfe13e);
  function_1d7e46ad31886165(#"wontonmeleetakedown", &function_8e7d6ecb4e9e5e08, &function_5e11e3a4b3b78d7d);
  function_1d7e46ad31886165(#"mandumeleetakedown", &function_4f86fb39c48e9806, &function_fe7e870e73d2d56b);
  function_1d7e46ad31886165(#"blackcell_s5meleetakedown", &function_339bb8a8f4bc9d61, &function_101cbff94707b454);
  function_1d7e46ad31886165(#"gilmanmeleetakedown", &function_fa7c7cf1fd70bc59, &function_e64be728c0e9123c);
  function_1d7e46ad31886165(#"shapechangermeleetakedown", &function_838bd5b934c22dd0, &function_8480b4cc59c7eba5);
  function_ef6181cda63ee216(#"ubsawmelee", &function_729828fcac8d474, &function_ce694afa144863b0);
  function_694f19fbeb0f3368(#"lilithex", &function_5960fc0fb7bffe3b, &function_6203d97d033830f);
  function_bada7844f46775e6(#"electricanimeequip", &function_f4f1fcbd0e0d34f5, &function_3dd4cd23f7a40b3b);
  function_15c80b945cca8f1e(#"flameskullcharm", &function_13cb3d1273a49150, &function_35770a658413caf2);
  function_15c80b945cca8f1e(#"crystamskullcharm", &function_a7f3d9242195ca49, &function_9ffd745177cd8ddb);
  function_15c80b945cca8f1e(#"starlightcharm", &function_61becbc5fa1954b4, &function_ae7741d6e4d1f456);
  function_15c80b945cca8f1e(#"souleatercharm", &function_1d4b7a9f71cd1964, &function_2908752ba245a596);
  function_15c80b945cca8f1e(#"crowfootcharm", &function_f90d9b5595a003b9, &function_fc7e6109eec28693);
  function_15c80b945cca8f1e(#"pumpkinlanterncharm", &function_b1dd08e3d9d82da4, &function_da14b1fec376399e);
  function_15c80b945cca8f1e(#"weedcreaturecharm", &function_cb9177655cbbfa3c, &function_a577c047e5231896);
  function_15c80b945cca8f1e(#"doomchainsaw", &isdoomchainsaw, &function_b07e6c587f6fcb2f);
  function_15c80b945cca8f1e(#"chainsword", &ischainsword, &function_a064aa18355f1b1c);
  function_15c80b945cca8f1e(#"toothfairy", &function_d7da8fc237e577f5, &function_60e04d6b4e5c151f);
  function_15c80b945cca8f1e(#"wonton_swhiskey", &function_ee1abbdbec1caece, &function_7970767ab0871d72);
  function_e4e6636e8010b028(#"reactive_kill_streak_2stage", &function_8ae0d478f0823d1);
  function_e4e6636e8010b028(#"reactive_kill_streak_3stage", &function_9afba82b040cd45e);
  function_e4e6636e8010b028(#"reactive_kill_streak_4stage", &function_f45ffc37d49a35b3);
  function_e4e6636e8010b028(#"reactive_match_kills_2stage", &function_a6b273451bbcd568);
  function_e4e6636e8010b028(#"reactive_match_kills_3stage", &function_6f778baaa85eb67b);
  function_e4e6636e8010b028(#"reactive_soul_collect_1stage", &function_e04dc23a6cbb586b);
  function_e4e6636e8010b028(#"reactive_movement", &function_33348af539a29bac);
  function_e4e6636e8010b028(#"reactive_enchantment", &function_dbafa6997df9da98);
  function_e4e6636e8010b028(#"reactive_kill_weapon_3stage", &function_4117c7b8928e6f1d);
  function_e4e6636e8010b028(#"reactive_downgradable_kill_streak_3stage", &function_e26db89a9b95d302);
  function_e4e6636e8010b028(#"reactive_kill_cycle_3stage", &function_641c450677a230f2);
  function_e4e6636e8010b028(#"reactive_spawn", &function_70dbe327367e762);
  function_e4e6636e8010b028(#"hash_fbcfe05c7adb1f36", &function_8b51453f4c4e7bae);
  function_4965594dae6249f1(#"reactive_kill");
  function_4965594dae6249f1(#"reactive_soul_collect");
  function_4965594dae6249f1(#"reactive_damage_received");
  function_91d94e2e3ac033ab();
  callback::add(#"player_spawned", &function_34471fca179a2e27);
  callback::add("update_mtx_scriptable", &function_6787f99cc8476ca8);

  thread function_c62e09e8e68ca737();
}

function private function_3aa2c3b5ddc3a921(var_947251de6b33d774) {
  assertmsg("<dev string:x24>" + getxhashsourcename(var_947251de6b33d774) + "<dev string:x5a>");
}

function function_d4f0e25fa6f90008(var_947251de6b33d774, conditionfunc, var_fec5355da8da22c7) {
  if(isDefined(level.var_40db9032567cfca7[var_947251de6b33d774])) {
    function_3aa2c3b5ddc3a921(var_947251de6b33d774);
  }

  level.var_40db9032567cfca7[var_947251de6b33d774] = {
    #deatheffect: var_fec5355da8da22c7, #conditions: conditionfunc
  };
}

function function_ee3da014a4117632(var_947251de6b33d774, var_fec5355da8da22c7) {
  if(isDefined(level.var_2a53ffec3874a987[var_947251de6b33d774])) {
    function_3aa2c3b5ddc3a921(var_947251de6b33d774);
  }

  level.var_2a53ffec3874a987[var_947251de6b33d774] = {
    #deatheffect: var_fec5355da8da22c7
  };
}

function function_ef6181cda63ee216(var_947251de6b33d774, conditionfunc, var_fec5355da8da22c7) {
  if(isDefined(level.var_6cc157c91ced44eb[var_947251de6b33d774])) {
    function_3aa2c3b5ddc3a921(var_947251de6b33d774);
  }

  level.var_6cc157c91ced44eb[var_947251de6b33d774] = {
    #deatheffect: var_fec5355da8da22c7, #conditions: conditionfunc
  };
}

function function_1d7e46ad31886165(var_947251de6b33d774, conditionfunc, var_fec5355da8da22c7) {
  if(isDefined(level.var_839fe802490703e4[var_947251de6b33d774])) {
    function_3aa2c3b5ddc3a921(var_947251de6b33d774);
  }

  level.var_839fe802490703e4[var_947251de6b33d774] = {
    #deatheffect: var_fec5355da8da22c7, #conditions: conditionfunc
  };
}

function function_694f19fbeb0f3368(var_947251de6b33d774, conditionfunc, var_fec5355da8da22c7) {
  if(isDefined(level.var_d8010ce982c6daa5[var_947251de6b33d774])) {
    function_3aa2c3b5ddc3a921(var_947251de6b33d774);
  }

  level.var_d8010ce982c6daa5[var_947251de6b33d774] = {
    #deatheffect: var_fec5355da8da22c7, #conditions: conditionfunc
  };
}

function function_bada7844f46775e6(var_947251de6b33d774, conditionfunc, var_fec5355da8da22c7) {
  if(isDefined(level.var_6cd087ff5695816b[var_947251de6b33d774])) {
    function_3aa2c3b5ddc3a921(var_947251de6b33d774);
  }

  level.var_6cd087ff5695816b[var_947251de6b33d774] = {
    #deatheffect: var_fec5355da8da22c7, #conditions: conditionfunc
  };
}

function function_15c80b945cca8f1e(var_947251de6b33d774, var_6d5927220460026c, var_9331280cb31a213d) {
  function_f105c777ced4e078(var_947251de6b33d774);

  level.var_8b428a7abd4b5588[var_947251de6b33d774] = {
    #var_9331280cb31a213d: var_9331280cb31a213d, #conditionscharm: var_6d5927220460026c
  };
}

function function_e4e6636e8010b028(var_947251de6b33d774, var_9331280cb31a213d) {
  function_f105c777ced4e078(var_947251de6b33d774);

  level.var_cc75e39215a1ee5a[var_947251de6b33d774] = {
    #var_9331280cb31a213d: var_9331280cb31a213d
  };
}

function function_4965594dae6249f1(var_947251de6b33d774) {
  function_f105c777ced4e078(var_947251de6b33d774);

  level.var_c4d8205fc5f06ab5[var_947251de6b33d774] = {};
}

function function_f105c777ced4e078(var_947251de6b33d774) {
  if(isDefined(level.var_8b428a7abd4b5588[var_947251de6b33d774]) || isDefined(level.var_cc75e39215a1ee5a[var_947251de6b33d774]) || isDefined(level.var_c4d8205fc5f06ab5[var_947251de6b33d774])) {
    assertmsg("<dev string:x5f>" + getxhashsourcename(var_947251de6b33d774) + "<dev string:x5a>");
  }
}

function function_91d94e2e3ac033ab() {
  level.var_c7ae0663cc8de27c = [];

  if(!isDefined(level.mapname)) {
    level.mapname = getDvar(@ "g_mapname");
  }

  if(issubstr(level.mapname, "frontend")) {
    level.var_c7ae0663cc8de27c[#"match_kill_thresholds_2stage"] = {
      #stage2: 4, #stage1: 2
    };
    level.var_c7ae0663cc8de27c[#"match_kill_thresholds_3stage"] = {
      #stage3: 6, #stage2: 4, #stage1: 2
    };
    level.var_c7ae0663cc8de27c[#"kill_streak_thresholds_2stage"] = {
      #stage2: 4, #stage1: 2
    };
    level.var_c7ae0663cc8de27c[#"kill_streak_thresholds_3stage"] = function_d6a206a8c16f5885();
    level.var_c7ae0663cc8de27c[#"kill_streak_thresholds_4stage"] = function_b18bff2aa698c276();
    level.var_c7ae0663cc8de27c[#"kill_streak_thresholds_souleater"] = 1;
    return;
  }

  level.var_c7ae0663cc8de27c[#"match_kill_thresholds_2stage"] = function_e394d8492212ddf3();
  level.var_c7ae0663cc8de27c[#"match_kill_thresholds_3stage"] = function_334808ed6fc79ab2();
  level.var_c7ae0663cc8de27c[#"kill_streak_thresholds_2stage"] = function_68a0237aa10a5714();
  level.var_c7ae0663cc8de27c[#"kill_streak_thresholds_3stage"] = function_d6a206a8c16f5885();
  level.var_c7ae0663cc8de27c[#"kill_streak_thresholds_4stage"] = function_b18bff2aa698c276();
  level.var_c7ae0663cc8de27c[#"kill_streak_thresholds_souleater"] = function_fa55d2a6d0191f9d();
  level.var_c7ae0663cc8de27c[#"downgradable_kill_streak_thresholds_3stage"] = function_3ac4b7797bf9b991();
}

function function_34471fca179a2e27(params) {
  function_eb5b8f4d7b9111b2();
  function_738493048a18f5e2();
  function_bb6fc6aabe552b3b();
  thread function_84676d67b776e68();
  thread function_c023dc8adec67cf8();
  thread function_553796ca442c42b9();
}

function function_eb5b8f4d7b9111b2() {
  if(!function_a24e0c2dd531ae1c()) {
    self.var_ba0fee1a3d02f016 = [];
    function_745383dc254e8178(#"match_kills", 0);
    function_745383dc254e8178(#"kill_streak", 0);
    function_745383dc254e8178(#"reactive_kills", 0);
    function_745383dc254e8178(#"souls_collected_count", 0);
    function_745383dc254e8178(#"ghost_radar_active", 0);
    function_745383dc254e8178(#"ghost_finder_sucking", 0);
    function_745383dc254e8178(#"downgradable_kill_streak", 0);
    function_745383dc254e8178(#"kill_streak_weapon", []);
    function_745383dc254e8178(#"movement_state", #"neutral");
    function_745383dc254e8178(#"all_scriptable_disablers", []);
    function_745383dc254e8178(#"direct_scriptable_disablers", []);
    function_745383dc254e8178(#"enchanted_weapons", []);
    function_745383dc254e8178(#"soul_ents_in_flight", []);
    function_745383dc254e8178(#"last_reactive_kill_time", -99999);
    function_745383dc254e8178(#"last_reticle_kill_time", -99999);
    function_745383dc254e8178(#"hash_3590c79834ed6bcc", "off");
    function_ce6577f1ddc5d04e(#"neutral");
    function_849d75d167d2df2f(#"neutral");
    self.var_ba0fee1a3d02f016[#"mtx_scriptable_reactive_ids"] = [];

    foreach(scriptableid, scriptabledata in level.var_cc75e39215a1ee5a) {
      function_97bf7c711098ca98(scriptableid, #"neutral");
    }

    self.var_ba0fee1a3d02f016[#"mtx_scriptable_toggle_ids"] = [];

    foreach(scriptableid, scriptabledata in level.var_c4d8205fc5f06ab5) {
      function_b282f58365d0a8eb(scriptableid);
    }
  }

  if(isPlayer(self)) {
    thread function_d6d20aeac2b839c0();
    thread function_956d4398d9f6e08d();
  }
}

function function_a24e0c2dd531ae1c() {
  return isDefined(self.var_ba0fee1a3d02f016);
}

function function_e394d8492212ddf3() {
  if(level.mtxkillthresholdstage1 > 0 && level.mtxkillthresholdstage2 > 0) {
    return {
      #stage2: level.mtxkillthresholdstage2, #stage1: level.mtxkillthresholdstage1
    };
  }

  return {
    #stage2: 20, #stage1: 10
  };
}

function function_334808ed6fc79ab2() {
  if(level.mtxkillthresholdstage1 > 0 && level.mtxkillthresholdstage2 > 0 && level.var_5b9c78d5e5581287 > 0) {
    return {
      #stage3: level.var_5b9c78d5e5581287, #stage2: level.mtxkillthresholdstage2, #stage1: level.mtxkillthresholdstage1
    };
  }

  return {
    #stage3: 30, #stage2: 20, #stage1: 10
  };
}

function function_68a0237aa10a5714() {
  return {
    #stage2: 5, #stage1: 2
  };
}

function function_d6a206a8c16f5885() {
  return {
    #stage3: 3, #stage2: 2, #stage1: 1
  };
}

function function_b18bff2aa698c276() {
  return {
    #stage4: 9, #stage3: 7, #stage2: 5, #stage1: 2
  };
}

function function_fa55d2a6d0191f9d() {
  return 3;
}

function function_acb6b43a501d7519() {
  return {
    #var_314daddf3f91237c: 8, #stage2: 5, #stage1: 2
  };
}

function function_3ac4b7797bf9b991() {
  stage1killthreshold = 1;
  stage2killthreshold = 2;
  stage3killthreshold = 3;
  var_a30aab00db323c63 = getdvarint(@ "hash_19443de5a3697190", -1);
  var_37e93169943f7a80 = getdvarint(@ "hash_7b707b9e08a2a8fd", -1);
  var_e4051d3c50675b5 = getdvarint(@ "hash_e225d9e8775ceae", -1);

  if(var_a30aab00db323c63 >= 0) {
    stage1killthreshold = var_a30aab00db323c63;
  }

  if(var_37e93169943f7a80 >= 0) {
    stage2killthreshold = var_37e93169943f7a80;
  }

  if(var_e4051d3c50675b5 >= 0) {
    stage3killthreshold = var_e4051d3c50675b5;
  }

  return {
    #stage3: stage3killthreshold, #stage2: stage2killthreshold, #stage1: stage1killthreshold
  };
}

function function_215f432bc7345e71(weapon) {
  function_a047cf54a0568a91(weapon);
  function_1354def060a303cb(weapon);
  function_4715316f60336216();
  function_b4f609769b2429a3();
  function_950d6b4e4595768f(#"reactive_kill_weapon_3stage");
  function_7b3cddcf6bfa5b4b();
  thread function_8b546220b05ec61a();
}

function function_8b546220b05ec61a() {
  self endon("death_or_disconnect");
  self endon("weapon_change");
  waitframe();
  function_67886ef61e58e095();
  function_8d9bee5f6d9e92d();
}

function function_940bfb34e152ae96() {
  function_eb5b8f4d7b9111b2();
  function_7b3cddcf6bfa5b4b();
  function_ae9a5d4b17c9a5b9();
}

function function_df0eeeccd6a86cb5(deathdata) {
  if(isDefined(deathdata.attacker) && isPlayer(deathdata.attacker)) {
    deathdata.attacker function_ba18c5b844baaeae(self, deathdata.objweapon, deathdata.meansofdeath);
  }

  function_bd843c1bb194cf22(deathdata.objweapon, deathdata.meansofdeath);
}

function function_82186dea3b314616(attacker, objweapon, meansofdeath, hitloc, inflictor, executionref, damageflags) {
  return function_25b556f1c287bea0(attacker, objweapon, meansofdeath, hitloc, inflictor, executionref, damageflags);
}

function function_31632334e41cf319(attacker, objweapon, meansofdeath, hitloc, inflictor) {
  if(isPlayer(attacker)) {
    attacker function_ba18c5b844baaeae(self, objweapon, meansofdeath);
  }

  return function_25b556f1c287bea0(attacker, objweapon, meansofdeath, hitloc, inflictor);
}

function function_5da3bf4fd1233318(deathdata) {
  if(isDefined(deathdata.attacker) && isPlayer(deathdata.attacker)) {
    deathdata.attacker function_ba18c5b844baaeae(self, deathdata.objweapon, deathdata.meansofdeath);
  }

  return function_25b556f1c287bea0(deathdata.attacker, deathdata.objweapon, deathdata.meansofdeath, deathdata.hitloc, deathdata.inflictor, deathdata.damageflags);
}

function function_3c5b3042f8d8a4f7() {
  self endon("death_or_disconnect");
  self endon("shockStick_haywireApplied");
  function_6afbbbaa99e9b63a(#"vfx_disabled_for_haywire");
  self waittill("haywire_cleared");
  wait 1;
  function_92a1d0ce843e431(#"vfx_disabled_for_haywire");
}

function function_554ad3c9ed9bc64() {
  function_6afbbbaa99e9b63a(#"vfx_disabled_for_jugg");
}

function function_f890ffd15106d12d() {
  function_92a1d0ce843e431(#"vfx_disabled_for_jugg");
}

function function_61f9d1047d33e77e() {
  function_6afbbbaa99e9b63a(#"vfx_disabled_for_hiding");
}

function function_6e83b6d312e47cb3() {
  function_92a1d0ce843e431(#"vfx_disabled_for_hiding");
}

function function_4bafd0f14b064f2a() {
  function_6afbbbaa99e9b63a(#"hash_d58327d11de60124");
}

function function_7b8972f2b1aa0a67() {
  function_92a1d0ce843e431(#"hash_d58327d11de60124");
}

function function_a7ecd67ebbd6ca43(entity) {
  return isDefined(entity) && isDefined(entity.model) && entity.model == "military_shooting_target_armor_01_assembly";
}

function function_1e26d71a360eed47() {
  return function_e04dc23a6cbb586b();
}

function function_4903b4967df7673f(objweapon) {
  deathfxname = function_765a22b52d7fbd68(objweapon);

  if(isDefined(deathfxname)) {
    return (function_765a22b52d7fbd68(objweapon) == #"souleaterequip");
  }

  return false;
}

function function_7d4bcd24208138bd(meansofdeath, objweapon) {
  if(getdvarint(@ "hash_2bb4e0ec793e3a4c", 1) && isbulletdeath(meansofdeath) && isDefined(objweapon) && function_448a388e17c007b1(objweapon) && function_3773fda9649573ca(objweapon)) {
    return true;
  }

  return false;
}

function function_448a388e17c007b1(weapon) {
  if(!isDefined(weapon)) {
    return 0;
  }

  return function_58e17385a1fd1a9(weapon);
}

function function_5b487a3dc8c6f598(objweapon) {
  deathfxname = function_765a22b52d7fbd68(objweapon);

  if(isDefined(deathfxname)) {
    return (function_765a22b52d7fbd68(objweapon) == #"zombiegun");
  }

  return false;
}

function function_7422699c4b8bf172(idamage, victim) {
  if(getdvarint(@ "hash_f8094d20d531b0b5", 1)) {
    if(isDefined(victim)) {
      if(victim.zombie) {
        idamage *= getdvarint(@ "hash_5c741bd119d504fe", 1);
      } else if(self.issmallufo) {
        idamage *= getdvarint(@ "hash_5b0de654fa5013ba", 1);
      } else if(isDefined(victim.targetname) && victim.targetname == "veh9_ufo_lg") {
        idamage *= getdvarint(@ "hash_335d3b6aa7c7ac96", 1);
      } else if(isDefined(victim.targetname) && victim.targetname == "saba_orb") {
        idamage *= getdvarint(@ "hash_bbf4ac6f9293a467", 1);
      } else if(isDefined(victim.agent_type) && victim.agent_type == "actor_enemy_mp_boss_mummy_minion") {
        idamage *= getdvarint(@ "hash_74b01cccd2b6aaf6", 1);
      } else if(isDefined(victim.agent_type) && (victim.agent_type == "actor_enemy_mp_ar_tier3_affected_ru" || victim.agent_type == "actor_enemy_mp_jugg_affected_ru")) {
        idamage *= getdvarint(@ "hash_4d810bff1f4993c4", 1);
      } else if(isDefined(victim.agent_type) && victim.agent_type == "actor_enemy_mp_boss_swampmonster") {
        idamage *= getdvarint(@ "hash_6267ea49aa81a4d2", 1);
      } else if(isDefined(victim.agent_type) && victim.agent_type == "actor_enemy_mp_boss_butcher") {
        idamage *= getdvarint(@ "hash_b85e4b9bc8f55a8d", 1);
      } else if(isDefined(victim.agent_type) && victim.agent_type == "actor_enemy_mp_boss_mummy") {
        idamage *= getdvarint(@ "hash_ecffb3b94bcd65bd", 1);
      }
    }

    return idamage;
  }

  return idamage;
}

function function_99aa382394d75e94() {
  function_c80dc1fc69011a01(#"reactive_soul_collect");
}

function function_40ef96d3093d9f1e() {
  if(self.var_ba0fee1a3d02f016[#"ghost_radar_active"] && !self.var_ba0fee1a3d02f016[#"ghost_finder_sucking"]) {
    self setscriptablepartstate(#"mtxvfxgunscreen", "ghostFinderActiveImmediate");
    self.var_ba0fee1a3d02f016[#"ghost_finder_sucking"] = 1;
  }
}

function function_1f1496f03d03936d() {
  if(self.var_ba0fee1a3d02f016[#"ghost_finder_sucking"]) {
    self setscriptablepartstate(#"mtxvfxgunscreen", #"neutral");
    self.var_ba0fee1a3d02f016[#"ghost_finder_sucking"] = 0;
  }
}

function function_758b595af36e5a34() {
  if(self.var_ba0fee1a3d02f016[#"ghost_radar_active"]) {
    self setscriptablepartstate(#"mtxvfxgunscreenoneshot", "ghostFinderAbsorbed");
  }
}

function function_8e324d558c3fbc01() {
  var_c1f62dac265ba909 = level.var_c4d8205fc5f06ab5[#"reactive_damage_received"] && self isscriptable() && self getscriptablehaspart(#"reactive_damage_received");

  if(var_c1f62dac265ba909) {
    function_c80dc1fc69011a01(#"reactive_damage_received");
  }
}

function private function_25b556f1c287bea0(attacker, objweapon, meansofdeath, hitloc, inflictor, executionref, damageflags) {
  if(meansofdeath == "MOD_SUICIDE") {
    return 0;
  }

  blueprintdeathfx = function_765a22b52d7fbd68(objweapon);

  if(!function_c9c6145683e2af2(self, blueprintdeathfx)) {
    return 0;
  }

  if(!isDefined(blueprintdeathfx) && getdvarint(@ "hash_4753586a2ac8718f", 0) == 1) {
    blueprintdeathfx = #"voxel";
  }

  if(isDefined(blueprintdeathfx)) {
    assert(isDefined(level.var_2a53ffec3874a987[blueprintdeathfx]), "<dev string:x98>" + getxhashsourcename(blueprintdeathfx) + "<dev string:xa5>");
  }

  if(isbulletdeath(meansofdeath) || iscrushdeath(meansofdeath)) {
    if(isDefined(blueprintdeathfx)) {
      bodydeleted = function_8aedd3bee81657a6(level.var_2a53ffec3874a987, attacker, blueprintdeathfx, hitloc, damageflags);
    } else {
      bodydeleted = function_ea37f6509c4ad7a8(level.var_40db9032567cfca7, attacker, objweapon, hitloc, damageflags);
    }

    return bodydeleted;
  } else if(ismeleedeath(meansofdeath)) {
    ismeleeweapon = isDefined(objweapon) && istrue(objweapon.ismelee);

    if(isDefined(blueprintdeathfx) && ismeleeweapon) {
      return function_8aedd3bee81657a6(level.var_2a53ffec3874a987, attacker, blueprintdeathfx, hitloc, damageflags);
    } else if(getdvarint(@ "hash_4753586a2ac8718f", 0) == 1) {
      blueprintdeathfx = #"voxel";

      if(isDefined(level.var_2a53ffec3874a987[blueprintdeathfx])) {
        return function_8aedd3bee81657a6(level.var_2a53ffec3874a987, attacker, blueprintdeathfx, hitloc);
      }
    } else {
      return function_ea37f6509c4ad7a8(level.var_6cc157c91ced44eb, attacker, objweapon, hitloc, damageflags);
    }
  } else if(function_df398e980fd947c5(meansofdeath)) {
    ismeleeweapon = isDefined(objweapon) && istrue(objweapon.ismelee);

    if(isDefined(blueprintdeathfx) && ismeleeweapon) {
      return function_8aedd3bee81657a6(level.var_2a53ffec3874a987, attacker, blueprintdeathfx, hitloc, damageflags);
    } else {
      return function_ea37f6509c4ad7a8(level.var_839fe802490703e4, attacker, objweapon, hitloc, damageflags);
    }
  } else if(isexecutiondeath(meansofdeath) && isDefined(executionref)) {
    objweapon = spawnStruct();
    objweapon.executionref = executionref;
    return function_ea37f6509c4ad7a8(level.var_d8010ce982c6daa5, attacker, objweapon, hitloc, damageflags);
  } else if(isequipmentdeath(meansofdeath)) {
    if(function_3e33cd3913a893a1(inflictor)) {
      return function_d4ef90a55afa0767(self.body);
    }

    if(isDefined(blueprintdeathfx)) {
      if(blueprintdeathfx == #"blackcell_s5Melee") {
        return 0;
      } else if(blueprintdeathfx == #"gilmanMelee") {
        return 0;
      }

      return function_8aedd3bee81657a6(level.var_2a53ffec3874a987, attacker, blueprintdeathfx, hitloc, damageflags);
    } else {
      return function_ea37f6509c4ad7a8(level.var_6cd087ff5695816b, attacker, objweapon, hitloc, damageflags);
    }
  } else if(isDefined(level.gametype) && level.gametype == "gold_gun") {
    bodydeleted = function_ea37f6509c4ad7a8(level.var_40db9032567cfca7, attacker, objweapon, hitloc, damageflags);
    return bodydeleted;
  } else if(isprojectiledeath(meansofdeath) || iselementaldeath(meansofdeath)) {
    if(isDefined(blueprintdeathfx)) {
      bodydeleted = function_8aedd3bee81657a6(level.var_2a53ffec3874a987, attacker, blueprintdeathfx, hitloc, damageflags);
    } else {
      bodydeleted = function_ea37f6509c4ad7a8(level.var_40db9032567cfca7, attacker, objweapon, hitloc, damageflags);
    }

    return bodydeleted;
  }

  return 0;
}

function private function_c9c6145683e2af2(ai, blueprintdeathfx) {
  if(isDefined(ai)) {
    if(isDefined(ai.aicategory)) {
      if(ai.aicategory == "special" || ai.aicategory == "elite" || ai.aicategory == "hvt" || ai.aicategory == "boss") {
        return false;
      }
    }

    if(ai.var_7bd2fc702f01b407) {
      return false;
    }

    if(isDefined(ai.var_aefddffa9c30aff3[blueprintdeathfx])) {
      return false;
    }
  }

  return true;
}

function private ismeleedeath(meansofdeath) {
  return meansofdeath == "MOD_MELEE";
}

function private function_df398e980fd947c5(meansofdeath) {
  return meansofdeath == "MOD_MELEE_TAKEDOWN";
}

function private isexecutiondeath(meansofdeath) {
  return meansofdeath == "MOD_EXECUTION";
}

function private isbulletdeath(meansofdeath) {
  return meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_EXPLOSIVE_BULLET" || meansofdeath == "MOD_HEAD_SHOT";
}

function private isequipmentdeath(meansofdeath) {
  return meansofdeath == "MOD_IMPACT" || meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_FIRE" || meansofdeath == "MOD_EXPLOSIVE";
}

function private iscrushdeath(meansofdeath) {
  return meansofdeath == "MOD_CRUSH";
}

function private isprojectiledeath(meansofdeath) {
  return meansofdeath == "MOD_PROJECTILE" || meansofdeath == "MOD_PROJECTILE_SPLASH";
}

function private iselementaldeath(meansofdeath) {
  return meansofdeath == "MOD_ELEMENTAL_FIRE" || meansofdeath == "MOD_ELEMENTAL_ELEC" || meansofdeath == "MOD_ELEMENTAL_COLD" || meansofdeath == "MOD_ELEMENTAL_TOXIC" || meansofdeath == "MOD_ELEMENTAL_DARK" || meansofdeath == "MOD_ELEMENTAL_LIGHT";
}

function private function_ea37f6509c4ad7a8(var_a27ab65ddffe7d6f, attacker, objweapon, hitloc, damageflags) {
  foreach(var_4927aa92bc02edef in var_a27ab65ddffe7d6f) {
    if([[var_4927aa92bc02edef.conditions]](objweapon)) {
      corpsedeleted = self[[var_4927aa92bc02edef.deatheffect]](self.body, attacker, hitloc, damageflags);
      assert(isDefined(corpsedeleted), "<dev string:xd3>");
      return corpsedeleted;
    }
  }

  return 0;
}

function private function_8aedd3bee81657a6(var_a91bac50e79fffa8, attacker, blueprintdeathfx, hitloc, damageflags) {
  var_fec5355da8da22c7 = var_a91bac50e79fffa8[blueprintdeathfx].deatheffect;

  if(isDefined(var_fec5355da8da22c7)) {
    corpsedeleted = self[[var_fec5355da8da22c7]](self.body, attacker, hitloc, damageflags);
    assert(isDefined(corpsedeleted), "<dev string:x11d>");
    return corpsedeleted;
  }

  return 0;
}

function private function_765a22b52d7fbd68(objweapon) {
  if(isDefined(objweapon.modifierblueprint.deathfxname) && objweapon.modifierblueprint.deathfxname != "") {
    return objweapon.modifierblueprint.deathfxname;
  }

  if(isDefined(objweapon.receiverblueprint.deathfxname) && objweapon.receiverblueprint.deathfxname != "") {
    return objweapon.receiverblueprint.deathfxname;
  }

  return undefined;
}

function function_ba18c5b844baaeae(victim, weapon, meansofdeath) {
  if(!isenemykill(victim, meansofdeath)) {
    return;
  }

  self.var_ba0fee1a3d02f016[#"match_kills"]++;
  self.var_ba0fee1a3d02f016[#"kill_streak"]++;
  setkillstreakweapon(weapon);
  self.var_ba0fee1a3d02f016[#"downgradable_kill_streak"]++;

  if(self isscriptable()) {
    function_950d6b4e4595768f(#"reactive_kill_streak_2stage");
    function_950d6b4e4595768f(#"reactive_kill_streak_3stage");
    function_950d6b4e4595768f(#"reactive_kill_streak_4stage");
    function_950d6b4e4595768f(#"reactive_kill_weapon_3stage");
    function_950d6b4e4595768f(#"reactive_match_kills_2stage");
    function_950d6b4e4595768f(#"reactive_match_kills_3stage");
    function_950d6b4e4595768f(#"reactive_downgradable_kill_streak_3stage");
    function_950d6b4e4595768f(#"reactive_kill_cycle_3stage");
  }

  thread function_b7ae5a371a7345dd();

  if(isDefined(weapon)) {
    var_c9b45073156db3b5 = function_ebff581d2980bfd0(weapon, meansofdeath);

    if(var_c9b45073156db3b5) {
      thread function_ba2c8132201152f6();
    }

    if(function_d84cf7c6ffe66d22(weapon)) {
      thread function_98452d5852f8dbcb();
    }
  }

  if(getdvarint(@ "hash_69baacf228c08181", 0) == 1 && meansofdeath == "MOD_MELEE" && isDefined(self.perks["specialty_super_strength"])) {
    weapon_utility::function_626fe75ad9d2d09b(victim, #"j_spinelower", "boys_super_str");
  }
}

function private function_bd843c1bb194cf22(objweapon, meansofdeath) {
  function_826a1744af715c95();

  if(self isscriptable()) {
    function_950d6b4e4595768f(#"reactive_kill_streak_2stage");
    function_950d6b4e4595768f(#"reactive_kill_streak_3stage");
    function_950d6b4e4595768f(#"reactive_kill_streak_4stage");
    function_950d6b4e4595768f(#"reactive_kill_weapon_3stage");
    function_950d6b4e4595768f(#"reactive_downgradable_kill_streak_3stage");
  }

  function_4715316f60336216();
  function_6ce55e7812f9db35();
}

function private setkillstreakweapon(weapon) {
  sweap = function_a3021a8d293d6d0c(weapon);

  if(sweap == "none") {
    return;
  }

  if(!isDefined(self.var_ba0fee1a3d02f016[#"kill_streak_weapon"][sweap])) {
    if(self.var_ba0fee1a3d02f016[#"kill_streak_weapon"].size > 8) {
      self.var_ba0fee1a3d02f016[#"kill_streak_weapon"] = function_ad41fa8acd40e0b9(self.var_ba0fee1a3d02f016[#"kill_streak_weapon"]);
    }

    self.var_ba0fee1a3d02f016[#"kill_streak_weapon"][sweap] = 0;
  }

  self.var_ba0fee1a3d02f016[#"kill_streak_weapon"][sweap]++;
}

function private getkillstreakweapon(weapon) {
  sweap = function_a3021a8d293d6d0c(weapon);

  if(sweap == "none") {
    return false;
  }

  return self.var_ba0fee1a3d02f016[#"kill_streak_weapon"][sweap] ?? 0;
}

function private function_a3021a8d293d6d0c(weapon) {
  if(!isDefined(weapon.basename)) {
    return "none";
  }

  if(!isDefined(weapon.variantid)) {
    return weapon.basename;
  }

  return weapon.basename + weapon.variantid;
}

function private function_ad41fa8acd40e0b9(array) {
  newarray = [];
  unequippedskipped = 0;
  primaries = self getweaponslistprimaries();
  var_c3d294ecb2eadef6 = [];

  foreach(weapon in primaries) {
    var_c3d294ecb2eadef6[var_c3d294ecb2eadef6.size] = function_a3021a8d293d6d0c(weapon);
  }

  var_c3d294ecb2eadef6 = arrayremoveduplicates(var_c3d294ecb2eadef6);

  foreach(key, value in array) {
    if(unequippedskipped < 3) {
      if(!arraycontains(var_c3d294ecb2eadef6, key)) {
        unequippedskipped++;
        continue;
      }
    }

    newarray[key] = value;
  }

  return newarray;
}

function private isenemykill(victim, meansofdeath) {
  if(!isDefined(meansofdeath) || "meansOfDeath" == "MOD_SUICIDE") {
    return false;
  }

  if(!isDefined(victim) || victim == self) {
    return false;
  }

  return true;
}

function private function_d6d20aeac2b839c0() {
  self notify("mtx_manageOffhands");
  self endon("mtx_manageOffhands");
  self endon("death_or_disconnect");

  while(true) {
    self waittill("weapon_switch_started");

    if(self isthrowinggrenade()) {
      function_5c269c1df4432eb7(#"vfx_disabled_for_offhand");
      self waittill("offhand_end");
      function_16a067a89a3bca12(#"vfx_disabled_for_offhand");
    }
  }
}

function private function_956d4398d9f6e08d() {
  self notify("mtx_manageMovementDisable");
  self endon("mtx_manageMovementDisable");
  self endon("death_or_disconnect");

  while(true) {
    while(!self isswimsprinting() && !self isskydiving() && !self isparachuting()) {
      utility::waittill_any("swim_sprint_begin", "skydive_deployparachute", "skydive_beginfreefall", "freefall", "open_parachute", "vehicle_enter", "vehicle_exit");
    }

    function_5c269c1df4432eb7(#"vfx_disabled_for_movement");

    while(self isswimsprinting() || self isskydiving() || self isparachuting()) {
      utility::waittill_any("swim_sprint_end", "skydive_end", "parachute_landed", "parachute_complete", "mantle_start", "vehicle_enter", "vehicle_exit");
    }

    function_16a067a89a3bca12(#"vfx_disabled_for_movement");
  }
}

function private function_5c269c1df4432eb7(disabler) {
  if(!isDefined(self.var_ba0fee1a3d02f016)) {
    return;
  }

  if(!arraycontains(self.var_ba0fee1a3d02f016[#"direct_scriptable_disablers"], disabler)) {
    self.var_ba0fee1a3d02f016[#"direct_scriptable_disablers"][self.var_ba0fee1a3d02f016[#"direct_scriptable_disablers"].size] = disabler;
  }

  function_4715316f60336216();
  function_b4f609769b2429a3();
}

function private function_16a067a89a3bca12(disabler) {
  if(!isDefined(self.var_ba0fee1a3d02f016)) {
    return;
  }

  if(arraycontains(self.var_ba0fee1a3d02f016[#"direct_scriptable_disablers"], disabler)) {
    self.var_ba0fee1a3d02f016[#"direct_scriptable_disablers"] = arrayremove(self.var_ba0fee1a3d02f016[#"direct_scriptable_disablers"], disabler);
  }

  function_67886ef61e58e095();
  function_beecabff9ba66b0c();
}

function private function_6afbbbaa99e9b63a(disabler) {
  if(!isDefined(self.var_ba0fee1a3d02f016)) {
    return;
  }

  if(!arraycontains(self.var_ba0fee1a3d02f016[#"all_scriptable_disablers"], disabler)) {
    self.var_ba0fee1a3d02f016[#"all_scriptable_disablers"][self.var_ba0fee1a3d02f016[#"all_scriptable_disablers"].size] = disabler;
  }

  function_4715316f60336216();
  function_de68beacbfc3a070();
}

function private function_92a1d0ce843e431(disabler) {
  if(!isDefined(self.var_ba0fee1a3d02f016)) {
    return;
  }

  if(arraycontains(self.var_ba0fee1a3d02f016[#"all_scriptable_disablers"], disabler)) {
    self.var_ba0fee1a3d02f016[#"all_scriptable_disablers"] = arrayremove(self.var_ba0fee1a3d02f016[#"all_scriptable_disablers"], disabler);
  }

  function_67886ef61e58e095();
  function_738493048a18f5e2();
}

function private function_67886ef61e58e095() {
  var_7103c71e537f7608 = 0;

  if(isDefined(self.currentweapon) && function_7033955c4c118f03()) {
    foreach(scriptableid, scriptabledata in level.var_8b428a7abd4b5588) {
      if([[scriptabledata.conditionscharm]](self.currentweapon)) {
        thread function_1f13d9d15cee4a5c(scriptableid, scriptabledata, self.currentweapon);
        var_7103c71e537f7608 = 1;
        break;
      }
    }
  }

  if(!var_7103c71e537f7608) {
    function_4715316f60336216();
  }
}

function private function_1f13d9d15cee4a5c(scriptableid, scriptabledata, weapon) {
  if(!isDefined(weapon)) {
    return;
  }

  state = [[scriptabledata.var_9331280cb31a213d]](weapon);

  if(!self getscriptableparthasstate(#"mtxvfxcharm", state)) {
    if(!getdvarint(@ "hash_808d350f6f481a67", 0)) {
      println("<dev string:x167>" + getxhashsourcename(state) + "<dev string:x191>");
    }

    return;
  }

  if(self.var_ba0fee1a3d02f016[#"mtx_scriptable_charm_state"] != state) {
    self.var_ba0fee1a3d02f016[#"mtx_scriptable_charm_state"] = state;
    self setscriptablepartstate(#"mtxvfxcharm", state);
  }
}

function private function_4715316f60336216() {
  if(self.var_ba0fee1a3d02f016[#"mtx_scriptable_charm_state"] != #"neutral") {
    self.var_ba0fee1a3d02f016[#"mtx_scriptable_charm_state"] = #"neutral";
    self setscriptablepartstate(#"mtxvfxcharm", #"neutral");
  }
}

function private function_7033955c4c118f03() {
  if(self.var_ba0fee1a3d02f016[#"direct_scriptable_disablers"].size > 0 || self.var_ba0fee1a3d02f016[#"all_scriptable_disablers"].size > 0) {
    return false;
  }

  return true;
}

function private function_beecabff9ba66b0c() {
  var_190dd73bba827d37 = 0;

  if(isDefined(self.currentweapon) && function_b8a09efab8d7c56e()) {
    foreach(scriptableid, scriptabledata in level.var_f1aeabe082d92591) {
      if([[scriptabledata.conditionsgunscreen]](self.currentweapon)) {
        thread function_cf9b62807022191f(scriptableid, scriptabledata, self.currentweapon);
        var_190dd73bba827d37 = 1;
        break;
      }
    }
  }

  if(!var_190dd73bba827d37) {
    function_b4f609769b2429a3();
  }
}

function private function_cf9b62807022191f(scriptableid, scriptabledata, weapon) {
  if(!isDefined(weapon)) {
    return;
  }

  state = [[scriptabledata.var_9331280cb31a213d]](weapon);

  if(self.var_ba0fee1a3d02f016[#"mtx_scriptable_gunscreen_state"] != state) {
    self.var_ba0fee1a3d02f016[#"mtx_scriptable_gunscreen_state"] = state;
    self setscriptablepartstate(#"mtxvfxgunscreen", state);
  }
}

function private function_b4f609769b2429a3() {
  if(self.var_ba0fee1a3d02f016[#"mtx_scriptable_gunscreen_state"] != #"neutral") {
    self.var_ba0fee1a3d02f016[#"mtx_scriptable_gunscreen_state"] = #"neutral";
    self setscriptablepartstate(#"mtxvfxgunscreen", #"neutral");
  }
}

function private function_b8a09efab8d7c56e() {
  if(self.var_ba0fee1a3d02f016[#"direct_scriptable_disablers"].size > 0 || self.var_ba0fee1a3d02f016[#"all_scriptable_disablers"].size > 0) {
    return false;
  }

  return true;
}

function function_6787f99cc8476ca8(sparams) {
  self endon("death_or_disconnect");
  function_6afbbbaa99e9b63a();
  waitframe();
  function_92a1d0ce843e431();
}

function private function_738493048a18f5e2() {
  if(!function_a5fbf10a4f77ef15()) {
    return;
  }

  if(!self isscriptable()) {
    return;
  }

  foreach(scriptableid, scriptabledata in level.var_cc75e39215a1ee5a) {
    if(function_6303e7256453d06c(scriptableid, scriptabledata)) {
      function_9d423d2b8105df4e(scriptableid, scriptabledata);
    }
  }
}

function private function_950d6b4e4595768f(scriptableid) {
  if(!self isscriptable()) {
    return;
  }

  if(function_a5fbf10a4f77ef15()) {
    scriptabledata = level.var_cc75e39215a1ee5a[scriptableid];

    if(function_6303e7256453d06c(scriptableid, scriptabledata)) {
      function_9d423d2b8105df4e(scriptableid, scriptabledata);
    }
  }
}

function private function_ae9a5d4b17c9a5b9() {
  if(!self isscriptable()) {
    return;
  }

  foreach(scriptableid, scriptabledata in level.var_cc75e39215a1ee5a) {
    function_9d423d2b8105df4e(scriptableid, scriptabledata);
  }
}

function private function_7f93d222d34a5a12(scriptableid) {
  if(!self isscriptable()) {
    return;
  }

  function_9d423d2b8105df4e(scriptableid, level.var_cc75e39215a1ee5a[scriptableid]);
}

function private function_9d423d2b8105df4e(scriptableid, scriptabledata) {
  state = [[scriptabledata.var_9331280cb31a213d]]();

  if(!self getscriptableparthasstate(scriptableid, state)) {
    if(!getdvarint(@ "hash_808d350f6f481a67", 0)) {
      println("<dev string:x167>" + getxhashsourcename(state) + "<dev string:x1ba>" + getxhashsourcename(scriptableid));
    }

    return;
  }

  self setscriptablepartstate(scriptableid, state);
  self.var_ba0fee1a3d02f016[#"mtx_scriptable_reactive_ids"][scriptableid] = state;
}

function private function_de68beacbfc3a070() {
  foreach(scriptableid, scriptablestate in self.var_ba0fee1a3d02f016[#"mtx_scriptable_reactive_ids"]) {
    if(scriptablestate != #"neutral") {
      self setscriptablepartstate(scriptableid, #"neutral");
      self.var_ba0fee1a3d02f016[#"mtx_scriptable_reactive_ids"][scriptableid] = #"neutral";
    }
  }
}

function private function_a5fbf10a4f77ef15() {
  if(self.var_ba0fee1a3d02f016[#"all_scriptable_disablers"].size > 0) {
    return false;
  }

  return true;
}

function private function_6303e7256453d06c(scriptableid, scriptabledata) {
  state = [[scriptabledata.var_9331280cb31a213d]]();
  return state != self.var_ba0fee1a3d02f016[#"mtx_scriptable_reactive_ids"][scriptableid];
}

function private function_c80dc1fc69011a01(scriptableid) {
  if(function_ba9b7808408d20c2()) {
    state = self.var_ba0fee1a3d02f016[#"mtx_scriptable_toggle_ids"][scriptableid];

    if(state == #"toggle0") {
      newstate = #"toggle1";
    } else {
      newstate = #"toggle0";
    }

    self setscriptablepartstate(scriptableid, newstate);
    self.var_ba0fee1a3d02f016[#"mtx_scriptable_toggle_ids"][scriptableid] = newstate;
  }
}

function private function_ba9b7808408d20c2() {
  if(self.var_ba0fee1a3d02f016[#"all_scriptable_disablers"].size > 0) {
    return false;
  }

  return true;
}

function function_533fe8b97a62433f(weapon) {
  if(!isDefined(weapon)) {
    return false;
  }

  if(!(isDefined(weapon.basename) && isDefined(weapon.variantid))) {
    return false;
  }

  if(weapon.basename == "iw9_me_sword01_mp" && weapon.variantid == 2) {
    return true;
  }

  return false;
}

function private function_13cb3d1273a49150(weapon) {
  return weapon hasattachmenthash(%"cos_iw9_156");
}

function private function_35770a658413caf2(weapon) {
  return "flameSkullActive";
}

function private function_a7f3d9242195ca49(weapon) {
  return weapon hasattachmenthash(%"cos_iw9_445");
}

function private function_61becbc5fa1954b4(weapon) {
  return weapon hasattachmenthash(%"cos_iw9_465");
}

function private function_1d4b7a9f71cd1964(weapon) {
  return weapon hasattachmenthash(%"cos_iw9_446");
}

function private function_f90d9b5595a003b9(weapon) {
  return weapon hasattachmenthash(%"cos_iw9_501");
}

function private function_b1dd08e3d9d82da4(weapon) {
  return weapon hasattachmenthash(%"cos_iw9_500");
}

function private function_cb9177655cbbfa3c(weapon) {
  return weapon hasattachmenthash(%"cos_iw9_526");
}

function isdoomchainsaw(weapon) {
  if(isDefined(weapon.receiver)) {
    if(weapon.receiver == "rec_pickaxe" && weapon.receivervarindex == 2) {
      return true;
    }
  }

  return false;
}

function ischainsword(weapon) {
  if(isDefined(weapon.receiver)) {
    if(weapon.receiver == "jup_jp23_me_swhiskey_rec" && (weapon.receivervarindex == 1 || weapon.receivervarindex == 4)) {
      return true;
    }
  }

  return false;
}

function function_d7da8fc237e577f5(weapon) {
  if(isDefined(weapon.receiver)) {
    if(weapon.receiver == "jup_evictor_rec" && weapon.receivervarindex == 3) {
      return true;
    }
  }

  return false;
}

function function_ee1abbdbec1caece(weapon) {
  if(isDefined(weapon) && isDefined(weapon.receiver)) {
    if(weapon.receiver == "jup_jp23_me_swhiskey_rec" && weapon.receivervarindex == 6) {
      return true;
    }
  }

  return false;
}

function private function_9ffd745177cd8ddb(weapon) {
  return "crystalSkullActive";
}

function private function_ae7741d6e4d1f456(weapon) {
  return "starlightActive";
}

function private function_2908752ba245a596(weapon) {
  return "soulEaterActive";
}

function private function_fc7e6109eec28693(weapon) {
  return "crowFootActive";
}

function private function_da14b1fec376399e(weapon) {
  return "pumpkinLanternActive";
}

function private function_a577c047e5231896(weapon) {
  return "weedCreatureActive";
}

function private function_b07e6c587f6fcb2f(weapon) {
  return "doomChainsawActive";
}

function private function_a064aa18355f1b1c(weapon) {
  return "ChainSwordActive";
}

function private function_60e04d6b4e5c151f(weapon) {
  return "ToothFairyActive";
}

function private function_7970767ab0871d72(weapon) {
  return "WontonSwhiskeyActive";
}

function private function_a6b273451bbcd568() {
  stages = level.var_c7ae0663cc8de27c[#"match_kill_thresholds_2stage"];
  matchkills = self.var_ba0fee1a3d02f016[#"match_kills"];

  if(matchkills < stages.stage1) {
    state = #"neutral";
  } else if(matchkills < stages.stage2) {
    state = #"stage1";
  } else {
    state = #"stage2";
  }

  debugstates = getdvarint(@ "hash_a0c0a5bf060c7bf2");

  if(debugstates >= 0) {
    switch (debugstates) {
      case 0:
        state = #"neutral";
        break;
      case 1:
        state = #"stage1";
        break;
      case 2:
        state = #"stage2";
        break;
      default:
        assertmsg("<dev string:x1d8>");
        break;
    }
  }

  return state;
}

function private function_6f778baaa85eb67b() {
  stages = level.var_c7ae0663cc8de27c[#"match_kill_thresholds_3stage"];
  matchkills = self.var_ba0fee1a3d02f016[#"match_kills"];

  if(matchkills < stages.stage1) {
    state = #"neutral";
  } else if(matchkills < stages.stage2) {
    state = #"stage1";
  } else if(matchkills < stages.stage3) {
    state = #"stage2";
  } else {
    state = #"stage3";
  }

  debugstates = getdvarint(@ "hash_a0c0a5bf060c7bf2");

  if(debugstates >= 0) {
    switch (debugstates) {
      case 0:
        state = #"neutral";
        break;
      case 1:
        state = #"stage1";
        break;
      case 2:
        state = #"stage2";
        break;
      case 3:
        state = #"stage3";
        break;
      default:
        assertmsg("<dev string:x1d8>");
        break;
    }
  }

  return state;
}

function private function_8ae0d478f0823d1() {
  stages = level.var_c7ae0663cc8de27c[#"kill_streak_thresholds_2stage"];
  kill_streak = self.var_ba0fee1a3d02f016[#"kill_streak"];

  if(kill_streak < stages.stage1) {
    state = #"neutral";
  } else if(kill_streak < stages.stage2) {
    state = #"stage1";
  } else {
    state = #"stage2";
  }

  debugstates = getdvarint(@ "hash_e5d7c5b83ec14d85");

  if(debugstates >= 0) {
    switch (debugstates) {
      case 0:
        state = #"neutral";
        break;
      case 1:
        state = #"stage1";
        break;
      case 2:
        state = #"stage2";
        break;
      default:
        assertmsg("<dev string:x1d8>");
        break;
    }
  }

  return state;
}

function private function_9afba82b040cd45e() {
  stages = level.var_c7ae0663cc8de27c[#"kill_streak_thresholds_3stage"];
  kill_streak = self.var_ba0fee1a3d02f016[#"kill_streak"];

  if(kill_streak < stages.stage1) {
    state = #"neutral";
  } else if(kill_streak < stages.stage2) {
    state = #"stage1";
  } else if(kill_streak < stages.stage3) {
    state = #"stage2";
  } else {
    state = #"stage3";
  }

  debugstates = getdvarint(@ "hash_cefbf3b030b375ab");

  if(debugstates >= 0) {
    switch (debugstates) {
      case 0:
        state = #"neutral";
        break;
      case 1:
        state = #"stage1";
        break;
      case 2:
        state = #"stage2";
        break;
      case 3:
        state = #"stage3";
        break;
      default:
        assertmsg("<dev string:x1ff>");
        break;
    }
  }

  return state;
}

function private function_f45ffc37d49a35b3() {
  stages = level.var_c7ae0663cc8de27c[#"kill_streak_thresholds_4stage"];
  kill_streak = self.var_ba0fee1a3d02f016[#"kill_streak"];

  if(kill_streak < stages.stage1) {
    state = #"neutral";
  } else if(kill_streak < stages.stage2) {
    state = #"stage1";
  } else if(kill_streak < stages.stage3) {
    state = #"stage2";
  } else if(kill_streak < stages.stage4) {
    state = #"stage3";
  } else {
    state = #"stage4";
  }

  debugstates = getdvarint(@ "hash_eac0e1ad1567fd42");

  if(debugstates >= 0) {
    switch (debugstates) {
      case 0:
        state = #"neutral";
        break;
      case 1:
        state = #"stage1";
        break;
      case 2:
        state = #"stage2";
        break;
      case 3:
        state = #"stage3";
        break;
      case 4:
        state = #"stage4";
        break;
      default:
        assertmsg("<dev string:x229>");
        break;
    }
  }

  return state;
}

function private function_4117c7b8928e6f1d() {
  state = #"neutral";
  weaponkillstreak = getkillstreakweapon(self.currentweapon);

  if(weaponkillstreak >= 3) {
    state = #"stage3";
  } else if(weaponkillstreak >= 2) {
    state = #"stage2";
  } else if(weaponkillstreak >= 1) {
    state = #"stage1";
  }

  debugstates = getdvarint(@ "hash_6b3c6361f0f5fdb");

  if(debugstates >= 0) {
    switch (debugstates) {
      case 0:
        state = #"neutral";
        break;
      case 1:
        state = #"stage1";
        break;
      case 2:
        state = #"stage2";
        break;
      case 3:
        state = #"stage3";
        break;
      default:
        assertmsg("<dev string:x1ff>");
        break;
    }
  }

  return state;
}

function private function_641c450677a230f2() {
  state = #"neutral";

  if(self.var_ba0fee1a3d02f016[#"match_kills"] == 0 || self.var_ba0fee1a3d02f016[#"match_kills"] % 3 == 1) {
    state = #"stage1";
  } else if(self.var_ba0fee1a3d02f016[#"match_kills"] % 3 == 2) {
    state = #"stage2";
  } else if(self.var_ba0fee1a3d02f016[#"match_kills"] % 3 == 0) {
    state = #"stage3";
  }

  debugstates = getdvarint(@ "hash_51dcebb527f3dd9b");

  if(debugstates >= 0) {
    switch (debugstates) {
      case 0:
        state = #"neutral";
        break;
      case 1:
        state = #"stage1";
        break;
      case 2:
        state = #"stage2";
        break;
      case 3:
        state = #"stage3";
        break;
      default:
        assertmsg("<dev string:x1ff>");
        break;
    }
  }

  return state;
}

function private function_70dbe327367e762() {
  if(self.var_358acd34f3552d6a) {
    state = #"stage1";
  } else {
    state = #"neutral";
  }

  debugstates = getdvarint(@ "hash_399fdd0fb6b02227");

  if(debugstates >= 0) {
    switch (debugstates) {
      case 0:
        state = #"neutral";
        break;
      case 1:
        state = #"stage1";
        break;
      default:
        assertmsg("<dev string:x256>");
        break;
    }
  }

  return state;
}

function private function_553796ca442c42b9() {
  self endon("death_or_disconnect");

  if(!(isDefined(game["flags"]) && game["flags"]["prematch_done"])) {
    level waittill("prematch_done");
  }

  self.var_358acd34f3552d6a = 0;
  function_950d6b4e4595768f(#"reactive_spawn");
  waitframe();
  self.var_358acd34f3552d6a = 1;
  function_950d6b4e4595768f(#"reactive_spawn");
}

function private function_e26db89a9b95d302() {
  return function_52784db085f31ad7(#"reactive_downgradable_kill_streak_3stage");
}

function private function_52784db085f31ad7(part) {
  stages = level.var_c7ae0663cc8de27c[#"downgradable_kill_streak_thresholds_3stage"];

  if(!isDefined(stages)) {
    return #"neutral";
  }

  stage1killthreshold = stages.stage1;
  stage2killthreshold = stages.stage2;
  stage3killthreshold = stages.stage3;

  if(false) {
    var_a30aab00db323c63 = getdvarint(@ "hash_19443de5a3697190", -1);
    var_37e93169943f7a80 = getdvarint(@ "hash_7b707b9e08a2a8fd", -1);
    var_e4051d3c50675b5 = getdvarint(@ "hash_e225d9e8775ceae", -1);

    if(var_a30aab00db323c63 >= 0) {
      stage1killthreshold = var_a30aab00db323c63;
    }

    if(var_37e93169943f7a80 >= 0) {
      stage2killthreshold = var_37e93169943f7a80;
    }

    if(var_e4051d3c50675b5 >= 0) {
      stage3killthreshold = var_e4051d3c50675b5;
    }
  }

  curstate = self isscriptable() && self getscriptablehaspart(part) ? self getscriptablepartstate(part, 0, 1) : #"hash_17e2f9deb4e986ba";
  state = undefined;

  if(self.var_ba0fee1a3d02f016[#"downgradable_kill_streak"] >= stage3killthreshold) {
    state = #"stage3";
  } else if(self.var_ba0fee1a3d02f016[#"downgradable_kill_streak"] >= stage2killthreshold) {
    switch (curstate) {
      case #"stage3":
      case #"stage2_dec":
        state = #"stage2_dec";
        break;
      default:
        state = #"stage2";
        break;
    }
  } else if(self.var_ba0fee1a3d02f016[#"downgradable_kill_streak"] >= stage1killthreshold) {
    switch (curstate) {
      case #"stage1_dec":
      case #"stage3":
      case #"stage2":
      case #"stage2_dec":
        state = #"stage1_dec";
        break;
      default:
        state = #"stage1";
        break;
    }
  } else {
    state = #"neutral";
  }

  debugstates = getdvarint(@ "hash_e001a97b368816c9");

  if(debugstates >= 0) {
    switch (debugstates) {
      case 0:
        state = #"neutral";
        break;
      case 1:
        state = #"stage1";
        break;
      case 2:
        state = #"stage2";
        break;
      case 3:
        state = #"stage3";
        break;
      default:
        assertmsg("<dev string:x1ff>");
        break;
    }
  }

  thread mtx_monitorReactiveKillstreak3StageDecay();
  return state;
}

function private mtx_monitorReactiveKillstreak3StageDecay() {
  self notify("c2dc734fae37ca16");
  self endon("c2dc734fae37ca16");
  self endon("death_or_disconnect");
  wait 0.1;
  decaytime = getdvarfloat(@ "hash_17bc5fdc392ba0b3", 20000) / 1000;

  while(true) {
    wait decaytime;

    debugstates = getdvarint(@ "hash_e001a97b368816c9");

    if(debugstates >= 0) {
      return;
    }

    self.var_ba0fee1a3d02f016[#"downgradable_kill_streak"]--;

    if(self.var_ba0fee1a3d02f016[#"downgradable_kill_streak"] < 0) {
      self.var_ba0fee1a3d02f016[#"downgradable_kill_streak"] = 0;
    }

    thread function_950d6b4e4595768f(#"reactive_downgradable_kill_streak_3stage");
  }
}

function private function_e04dc23a6cbb586b() {
  stage1killthreshold = level.var_c7ae0663cc8de27c[#"kill_streak_thresholds_souleater"];
  state = #"neutral";

  if(self.var_ba0fee1a3d02f016[#"souls_collected_count"] >= stage1killthreshold) {
    state = #"stage1";
  }

  debugstates = getdvarint(@ "hash_cf86c6012f506ac8");

  if(debugstates >= 0) {
    switch (debugstates) {
      case 0:
        state = #"neutral";
        break;
      case 1:
        state = #"stage1";
        break;
      default:
        assertmsg("<dev string:x270>");
        break;
    }
  }

  return state;
}

function private function_33348af539a29bac() {
  debugstates = getdvarint(@ "hash_beff73861be066d");

  if(debugstates >= 0) {
    switch (debugstates) {
      case 0:
        return #"neutral";
      case 1:
        return #"stage1";
      default:
        assertmsg("<dev string:x294>" + debugstates + "<dev string:x2b4>");
        break;
    }
  }

  return self.var_ba0fee1a3d02f016[#"movement_state"];
}

function private function_8b51453f4c4e7bae() {
  return self.var_ba0fee1a3d02f016[#"hash_3590c79834ed6bcc"];
}

function private getweaponname(weapon) {
  if(isDefined(weapon)) {
    return weapon.basename;
  }

  return "NONE";
}

function private function_dbafa6997df9da98() {
  debugstates = getdvarint(@ "hash_8d73f9a1e40b4f01");

  if(debugstates >= 0) {
    switch (debugstates) {
      case 0:
        return #"neutral";
      case 1:
        return #"stage1";
      default:
        assertmsg("<dev string:x2e8>" + debugstates + "<dev string:x2b4>");
        break;
    }
  }

  weaponname = getweaponname(self.currentweapon);
  weaponstate = self.var_ba0fee1a3d02f016[#"enchanted_weapons"][weaponname];

  if(isDefined(weaponstate) && weaponstate == 1) {
    return #"stage1";
  }

  return #"neutral";
}

function private isiooperator() {
  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref)) {
    if(isxhashasset(self.operatorcustomization.skinref)) {
      return (self.operatorcustomization.skinref == % "io_western_a");
    } else {
      return (self.operatorcustomization.skinref == "io_western_a");
    }
  }

  return false;
}

function private isfalloperator() {
  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref)) {
    if(isxhashasset(self.operatorcustomization.skinref)) {
      return (self.operatorcustomization.skinref == % "jup_mp_fall_skin");
    } else {
      return (self.operatorcustomization.skinref == "jup_mp_fall_skin");
    }
  }

  return false;
}

function private function_8d1f7fa9c4589345() {
  if(isDefined(self.operatorcustomization) && isDefined(self.operatorcustomization.skinref)) {
    if(isxhashasset(self.operatorcustomization.skinref)) {
      return (self.operatorcustomization.skinref == % "t10_gbr_pl_ratcliff_vertigo_skin");
    } else {
      return (self.operatorcustomization.skinref == "t10_gbr_pl_ratcliff_vertigo_skin");
    }
  }

  return false;
}

function private ismovementoperator() {
  if(isiooperator() || isfalloperator() || function_8d1f7fa9c4589345()) {
    return true;
  }

  return false;
}

function private ismovementweapon(weapon) {
  if(isDefined(weapon) && weapon.basename == "iw9_sm_aviktor_mp") {
    return (isDefined(weapon.variantid) && weapon.variantid == 25);
  }

  if(isDefined(weapon) && weapon.basename == "jup_jp25_sm_talpham_mp") {
    return (isDefined(weapon.variantid) && weapon.variantid == 19);
  }

  if(isDefined(weapon) && weapon.basename == "jup_jp36_sn_boscar_mp") {
    return (isDefined(weapon.variantid) && weapon.variantid == 13);
  }

  return false;
}

function private function_8d9bee5f6d9e92d() {
  if(function_e18b3f68f5fae84f(self.currentweapon)) {
    thread function_ec1d5697d6508d9c(self.currentweapon);
    return;
  }

  function_553856f27429d1f4();
}

function private function_e18b3f68f5fae84f(weapon) {
  bypass = getdvarint(@ "hash_d5bfe694a8598141");

  if(bypass == 1) {
    return true;
  }

  if(isDefined(weapon) && weapon.basename == "iw9_sn_india_mp") {
    return (isDefined(weapon.variantid) && weapon.variantid == 14);
  }

  return false;
}

function private function_ec1d5697d6508d9c(weapon) {
  self notify("inspect_update_thread");
  self endon("death_or_disconnect");
  self endon("inspect_update_thread");

  if(!isDefined(self.var_ba0fee1a3d02f016[#"inspect_thread"])) {
    self.var_ba0fee1a3d02f016[#"inspect_thread"] = 1;
  }

  weaponname = weapon.basename;
  function_950d6b4e4595768f(#"reactive_enchantment");

  while(true) {
    self waittill("weapon_inspect");
    function_9fa628511830eeac(weaponname);
    function_950d6b4e4595768f(#"reactive_enchantment");
  }
}

function private function_60786a2af27d8b2c(state) {
  if(!function_e18b3f68f5fae84f(self.currentweapon) || !isDefined(self.var_ba0fee1a3d02f016[#"enchanted_weapons"])) {
    return;
  }

  if(state != 0 && state != 1) {
    assertmsg("<dev string:x30b>" + state + "<dev string:x329>");
  }

  self.var_ba0fee1a3d02f016[#"enchanted_weapons"][getweaponname(self.currentweapon)] = state;
  function_a4685f262bf40708();
}

function private function_9fa628511830eeac(weaponname) {
  currentstate = function_dbafa6997df9da98();

  if(currentstate == #"neutral") {
    function_60786a2af27d8b2c(1);
    return;
  }

  function_60786a2af27d8b2c(0);
}

function private function_553856f27429d1f4() {
  if(self.var_ba0fee1a3d02f016[#"inspect_thread"]) {
    self.var_ba0fee1a3d02f016[#"inspect_thread"] = undefined;
    self notify("inspect_update_thread");
  }
}

function private function_84676d67b776e68() {
  self notify("fd033f06284ad7cf");
  self endon("fd033f06284ad7cf");
  self endon("death_or_disconnect");

  while(true) {
    self waittill("weapon_inspect");
    function_48d94768dd9be408();
  }
}

function private function_48d94768dd9be408() {
  weapon = self getcurrentweapon();

  if(isDefined(level.var_79987b283d0c90da)) {
    var_f5db50aedd501d15 = level.var_79987b283d0c90da[weapon.receiverblueprint.attachmentdata];

    if(isDefined(var_f5db50aedd501d15)) {
      self thread[[var_f5db50aedd501d15]](weapon);
      return;
    }
  }
}

function private function_c023dc8adec67cf8() {
  self notify("a62247d1fc098ccb");
  self endon("a62247d1fc098ccb");
  self endon("death_or_disconnect");

  while(true) {
    self waittill("grenade_pullback");
    self.var_ba0fee1a3d02f016[#"hash_3590c79834ed6bcc"] = "on";
    function_950d6b4e4595768f(#"hash_fbcfe05c7adb1f36");
    var_124efe5d2009b7f7 = 30000;
    utility::waittill_any_timeout(var_124efe5d2009b7f7, "offhand_end");
    self.var_ba0fee1a3d02f016[#"hash_3590c79834ed6bcc"] = #"neutral";
    function_950d6b4e4595768f(#"hash_fbcfe05c7adb1f36");
  }
}

function private function_7b3cddcf6bfa5b4b() {
  if(ismovementoperator() || ismovementweapon(self.currentweapon)) {
    thread function_71237f69b09806c7();
    return;
  }

  function_30baeaaaef09d18();
}

function private function_71237f69b09806c7() {
  self notify("movement_update_thread");
  self endon("death_or_disconnect");
  self endon("movement_update_thread");
  currentstate = self.var_ba0fee1a3d02f016[#"movement_state"];
  var_75af1e9cd8ca46c1 = 0;
  isfalloperator = isfalloperator();

  while(true) {
    movement = self getnormalizedmovement();
    movement = abs(movement[0]) + abs(movement[1]);
    var_75af1e9cd8ca46c1 = movement > 0.7 && !self playerads() > 0 && (self getstance() == "stand" || isfalloperator);

    if(self issprinting() || !self isonground() || self isdiving() || self issprintsliding() || var_75af1e9cd8ca46c1 || isfalloperator && self isshooting()) {
      targetstate = #"neutral";
      delaytime = 0;
    } else {
      targetstate = #"stage1";
      delaytime = 0;
    }

    if(currentstate != targetstate) {
      childthread function_235c0aca8885c616(targetstate, delaytime);
      currentstate = targetstate;
    }

    wait 0.1;
  }
}

function private function_235c0aca8885c616(state, delaytime) {
  self notify("newMovementState");
  self endon("newMovementState");
  wait delaytime;
  self.var_ba0fee1a3d02f016[#"movement_state"] = state;
  function_950d6b4e4595768f(#"reactive_movement");
}

function private function_30baeaaaef09d18() {
  self notify("movement_update_thread");
}

function private function_b7ae5a371a7345dd() {
  self notify("updating_reactive_kills");
  self endon("death_or_disconnect");
  self endon("updating_reactive_kills");

  if(!isDefined(self getscriptablepartstate(#"reactive_kill", 1, 1))) {
    println("<dev string:x34c>");
    return;
  }

  while(true) {
    time = gettime();
    timesincelastkill = time - self.var_ba0fee1a3d02f016[#"last_reactive_kill_time"];

    if(timesincelastkill >= 600) {
      if(self.var_ba0fee1a3d02f016[#"match_kills"] > self.var_ba0fee1a3d02f016[#"reactive_kills"]) {
        function_c80dc1fc69011a01(#"reactive_kill");
        self.var_ba0fee1a3d02f016[#"last_reactive_kill_time"] = time;
        self.var_ba0fee1a3d02f016[#"reactive_kills"]++;
      } else {
        return;
      }

      waittime = 0.6;
    } else {
      waittime = (600 - timesincelastkill) / 1000;
    }

    wait waittime;
  }
}

function private function_fe3c735752e99d6f(weapon) {
  return false;
}

function private function_1354def060a303cb(weapon) {
  if(function_25586e89a1ffe18b(weapon)) {
    thread function_d50e9d52c585daa8(weapon);
    return;
  }

  function_5ca7f3db7a6b1830();
}

function private function_d50e9d52c585daa8(weapon) {
  self notify("doom_gunscreen_thread");
  self endon("death_or_disconnect");
  self endon("doom_gunscreen_thread");
  self endon("weapon_change");

  if(!isDefined(self.var_ba0fee1a3d02f016[#"gunscreen_doom_hide"])) {
    self.var_ba0fee1a3d02f016[#"gunscreen_doom_hide"] = 0;
  }

  if(!isDefined(self.var_ba0fee1a3d02f016[#"gunscreen_doom_active"])) {
    self.var_ba0fee1a3d02f016[#"gunscreen_doom_active"] = 1;
  }

  while(true) {
    if(self issprinting() || self isswimsprinting() || self issprintsliding() || self isdiving()) {
      if(!self.var_ba0fee1a3d02f016[#"gunscreen_doom_hide"]) {
        self.var_ba0fee1a3d02f016[#"gunscreen_doom_hide"] = 1;
        self setclientomnvar("ui_doomscreen_hide", 1);
      }
    } else if(self.var_ba0fee1a3d02f016[#"gunscreen_doom_hide"]) {
      self.var_ba0fee1a3d02f016[#"gunscreen_doom_hide"] = 0;
      self setclientomnvar("ui_doomscreen_hide", 0);
    }

    waitframe();
  }
}

function private function_5ca7f3db7a6b1830() {
  if(self.var_ba0fee1a3d02f016[#"gunscreen_doom_active"]) {
    self notify("doom_gunscreen_thread");
    self.var_ba0fee1a3d02f016[#"gunscreen_doom_hide"] = undefined;
    self.var_ba0fee1a3d02f016[#"gunscreen_doom_active"] = undefined;
    self setclientomnvar("ui_doomscreen_hide", 0);
  }
}

function private function_58e17385a1fd1a9(objweapon) {
  if(objweapon hasattachment("cos_iw9_screen_029")) {
    return true;
  }

  return false;
}

function private function_25586e89a1ffe18b(objweapon) {
  if(objweapon hasattachment("cos_iw9_screen_028")) {
    return true;
  }

  return false;
}

function private function_a047cf54a0568a91(weapon) {
  if(function_260ff05be50eca62(weapon)) {
    function_6379d706b1b60bbd(weapon);
  }
}

function private function_d84cf7c6ffe66d22(weapon) {
  if(!isDefined(weapon)) {
    return false;
  }

  if(function_54d173136e22312f(weapon)) {
    return true;
  }

  if(function_30458c24279ff1cd(weapon)) {
    return true;
  }

  if(function_183e608ffd1e6ff1(weapon)) {
    return true;
  }

  if(function_d8fb3404421d3edf(weapon)) {
    return true;
  }

  if(function_712535c22d72da5(weapon)) {
    return true;
  }

  return false;
}

function private function_842cd4b1a8fbf411(weapon) {
  bypass = getdvarint(@ "hash_d5b99091b7c0443e");

  if(bypass == 1) {
    return true;
  }

  return false;
}

function private function_98452d5852f8dbcb() {
  self setclientomnvar("ui_reticle_mtx_action2", self.var_ba0fee1a3d02f016[#"match_kills"]);
  self.var_ba0fee1a3d02f016[#"last_reticle_kill_time"] = gettime();
}

function private function_9b97bd8af57bf2a1() {
  self setclientomnvar("ui_reticle_mtx_action2", self.var_ba0fee1a3d02f016[#"souls_collected_count"]);
}

function private function_a4685f262bf40708() {
  self setclientomnvar("ui_reticle_mtx_inspect", self.var_ba0fee1a3d02f016[#"enchanted_weapons"][getweaponname(self.currentweapon)]);
}

function private function_762c9b4c30c3d84d() {
  self setclientomnvar("ui_reticle_mtx_focus", self.var_ba0fee1a3d02f016[#"mtx_focus"]);
}

function private function_6379d706b1b60bbd(weapon) {
  function_745383dc254e8178(#"hearts_broken", 0);
  function_745383dc254e8178(#"hearts_broken_incrementing", 0);

  if(function_f8a2a5fae80feee0(weapon)) {
    self setclientomnvar("ui_reticle_mtx_action2", self.var_ba0fee1a3d02f016[#"hearts_broken"]);
    return;
  }

  self setclientomnvar("ui_reticle_mtx_action2", -1);
}

function private function_ba2c8132201152f6() {
  self endon("death_or_disconnect");
  self.var_ba0fee1a3d02f016[#"hearts_broken"]++;

  if(self.var_ba0fee1a3d02f016[#"hearts_broken_incrementing"]) {
    return;
  }

  self.var_ba0fee1a3d02f016[#"hearts_broken_incrementing"] = 1;
  wait 0.1;

  while(true) {
    currentcount = self getclientomnvar("ui_reticle_mtx_action2");

    if(currentcount >= self.var_ba0fee1a3d02f016[#"hearts_broken"]) {
      self.var_ba0fee1a3d02f016[#"hearts_broken_incrementing"] = 0;
      return;
    }

    self setclientomnvar("ui_reticle_mtx_action2", currentcount + 1);
    wait 0.57;
  }
}

function private function_6ce55e7812f9db35() {
  if(isDefined(self.var_ba0fee1a3d02f016[#"hearts_broken"])) {
    self.var_ba0fee1a3d02f016[#"hearts_broken"] = 0;
    self.var_ba0fee1a3d02f016[#"hearts_broken_incrementing"] = 0;
  }
}

function private function_260ff05be50eca62(weapon) {
  return isDefined(weapon.scope) && weapon.scope == "hybrid03" && weapon.scopevarindex == 4;
}

function private function_54d173136e22312f(weapon) {
  return isDefined(weapon.scope) && weapon.scope == "reflex02_tall" && weapon.scopevarindex == 27;
}

function private function_30458c24279ff1cd(weapon) {
  if(isDefined(weapon.scope)) {
    if(gettime() - self.var_ba0fee1a3d02f016[#"last_reticle_kill_time"] > 1770) {
      if(weapon.scope == "reflex07_tall" && weapon.scopevarindex == 18) {
        return true;
      }

      if(weapon.scope == "fourx02" && weapon.scopevarindex == 11) {
        return true;
      }
    }
  }

  return false;
}

function private function_183e608ffd1e6ff1(weapon) {
  return isDefined(weapon.scope) && weapon.scope == "reflex02_tall" && weapon.scopevarindex == 31;
}

function private function_d8fb3404421d3edf(weapon) {
  if(gettime() - self.var_ba0fee1a3d02f016[#"last_reticle_kill_time"] > 1000) {
    return (isDefined(weapon.scope) && weapon.scope == "vzscope_mromeo" && weapon.scopevarindex == 2);
  }
}

function private function_712535c22d72da5(weapon) {
  return isDefined(weapon.scope) && weapon.scope == "reflex02_tall" && weapon.scopevarindex == 44;
}

function private function_cffba97fa52b9199(weapon) {
  return isDefined(weapon.scope) && weapon.scope == "bar_ar_longhvy_scope_p52" && weapon.scopevarindex == 1;
}

function private function_a4fac5e935e0141e(weapon) {
  return isDefined(weapon.scope) && weapon.scope == "fourx04" && weapon.scopevarindex == 13;
}

function private function_30b97aca831f453f(weapon) {
  return false;
}

function private function_db7e85ae063ff29(weapon) {
  if(isDefined(weapon.scope)) {
    if(weapon.scope == "holotherm" && weapon.scopevarindex == 22) {
      return true;
    }

    if(weapon.scope == "fourxtherm01" && weapon.scopevarindex == 2) {
      return true;
    }
  }

  return false;
}

function private function_f8a2a5fae80feee0(weapon) {
  return isDefined(weapon.modifier) && weapon.modifier == "ammo_9s" && weapon.modifiervarindex == 2;
}

function private function_ebff581d2980bfd0(weapon, meansofdeath) {
  return function_260ff05be50eca62(weapon) && function_f8a2a5fae80feee0(weapon) && isDefined(meansofdeath) && meansofdeath != "MOD_MELEE";
}

function private function_c6229012d9ae2e31(objweapon) {
  return isDefined(objweapon.basename) && objweapon.basename == "chopper_gunner_turret_ufo_lg_mp";
}

function private function_afd4ef408179cc(objweapon) {
  return isDefined(objweapon.basename) && objweapon.basename == "chopper_gunner_turret_ufo_mp";
}

function private function_2b23a8d93167aaaa(objweapon) {
  if(isDefined(objweapon.basename) && (objweapon.basename == "super_laser_charge_mp" || objweapon.basename == "high_jump_mp")) {
    return true;
  }

  if(isDefined(objweapon.modifier)) {
    if(objweapon.modifier == "ammo_556n" && objweapon.modifiervarindex == 22) {
      return true;
    }

    if(objweapon.modifier == "ammo_556n_p43" && objweapon.modifiervarindex == 24) {
      return true;
    }

    if(objweapon.modifier == "ammo_5x28" && objweapon.modifiervarindex == 3) {
      return true;
    }
  }

  return false;
}

function private function_729828fcac8d474(objweapon) {
  return isDefined(objweapon) && objweapon hasattachment("jup_ub_saw_01");
}

function private function_841b8126b9ad7ec(objweapon) {
  if(!(isDefined(objweapon.basename) && isDefined(objweapon) && isDefined(objweapon.variantid))) {
    return false;
  }

  return objweapon.basename == "jup_jp23_me_swhiskey_mp" && (objweapon.variantid == 1 || objweapon.variantid == 2);
}

function private function_e201db4a8295f73b(objweapon) {
  if(!isDefined(objweapon) || !isDefined(objweapon.basename) || !isDefined(objweapon.variantid)) {
    return false;
  }

  return objweapon.basename == "jup_jp23_me_spear_mp" && objweapon.variantid == 4;
}

function private function_8e7d6ecb4e9e5e08(objweapon) {
  if(!(isDefined(objweapon.basename) && isDefined(objweapon) && isDefined(objweapon.variantid))) {
    return false;
  }

  return objweapon.basename == "jup_jp23_me_swhiskey_mp" && objweapon.variantid == 6;
}

function private function_4f86fb39c48e9806(objweapon) {
  if(!(isDefined(objweapon.basename) && isDefined(objweapon) && isDefined(objweapon.variantid))) {
    return false;
  }

  return objweapon.basename == "iw9_me_pickaxe" && objweapon.variantid == 3;
}

function private function_339bb8a8f4bc9d61(objweapon) {
  if(!isDefined(objweapon) || !isDefined(objweapon.basename) || !isDefined(objweapon.variantid)) {
    return false;
  }

  return objweapon.basename == "jup_jp23_me_swhiskey_mp" && objweapon.variantid == 10;
}

function private function_fa7c7cf1fd70bc59(objweapon) {
  if(!isDefined(objweapon) || !isDefined(objweapon.basename) || !isDefined(objweapon.variantid)) {
    return false;
  }

  return objweapon.basename == "jup_jp23_me_spear" && objweapon.variantid == 1;
}

function private function_838bd5b934c22dd0(objweapon) {
  if(!isDefined(objweapon) || !isDefined(objweapon.basename) || !isDefined(objweapon.variantid)) {
    return false;
  }

  return objweapon.basename == "jup_jp23_me_swhiskey_mp" && objweapon.variantid == 9;
}

function private function_5960fc0fb7bffe3b(fakeweapon) {
  if(fakeweapon.executionref == "execution_061") {
    return true;
  }

  return false;
}

function private function_3773fda9649573ca(objweapon) {
  if(objweapon hasattachment("cos_iw9_screen_029")) {
    return true;
  }

  return false;
}

function private function_180d748cfae605ec(objweapon) {
  if(function_5b487a3dc8c6f598(objweapon)) {
    return true;
  }

  return false;
}

function private function_58a3eb2b8522894f(objweapon) {
  return isDefined(objweapon) && objweapon.basename == "jup_pi_goldengun_mp";
}

function private function_1b40b711abb69b0a(objweapon) {
  if(!isDefined(objweapon) || !isDefined(objweapon.basename) || !isDefined(objweapon.variantid)) {
    return false;
  }

  return objweapon.basename == "jup_jp17_sn_hsierra_mp" && objweapon.variantid == 16;
}

function private isdg2death(objweapon) {
  return isDefined(objweapon) && objweapon.basename == "jup_ar_dg2_mp";
}

function private israygundeath(objweapon) {
  return isDefined(objweapon) && objweapon.basename == "jup_pi_raygun_mp";
}

function private function_f4f1fcbd0e0d34f5(objweapon) {
  if(isDefined(objweapon.basename)) {
    switch (objweapon.basename) {
      case #"hash_c7a00ceeee2cd52":
      case #"hash_9702698078eb7241":
      case #"hash_b10f0ebdc1fb569b":
      case #"hash_d8fc49c2b6acc257":
        return true;
      default:
        break;
    }
  }

  return false;
}

function private function_3907722283e6b0f8(corpstable, attacker, hitloc, damageflags) {
  function_cffb5550ecd2e3eb(corpstable, "youveBeenNaughty_limb", "youveBeenNaughty_torso", "youveBeenNaughty_head");
  return true;
}

function private function_4dcedcc964c16d5f(corpstable, attacker, hitloc, damageflags) {
  function_cffb5550ecd2e3eb(corpstable, "youveBeenNice_limb", "youveBeenNice_torso", "youveBeenNice_head");
  return true;
}

function private function_b4612ce187e9d454(corpstable, attacker, hitloc, damageflags) {
  function_cffb5550ecd2e3eb(corpstable, "vDay_limb", "vDay_torso", "vDay_head");
  return true;
}

function private function_9226837f2c138ede(corpstable, attacker, hitloc, damageflags) {
  if(isdismembermentenabled()) {
    function_cffb5550ecd2e3eb(corpstable, "bCell_limb", "bCell_torso", "bCell_head");
  } else {
    function_cffb5550ecd2e3eb(corpstable, "bCell_nogore_limb", "bCell_nogore_torso", "bCell_nogore_head");
  }

  return true;
}

function private function_d5227e415aefad26(corpstable, attacker, hitloc, damageflags) {
  function_47e3b72d9cc335d0(corpstable, "purple_shock");
  return false;
}

function private function_e2b3079d82da0de6(corpstable, attacker, hitloc, damageflags) {
  function_cffb5550ecd2e3eb(corpstable, "paddy_limb", "paddy_torso", "paddy_head");
  return true;
}

function private function_4acec9eae72b50af(corpstable, attacker, hitloc, damageflags) {
  function_47e3b72d9cc335d0(corpstable, "shredder");
  return false;
}

function private function_dd39f676c0c099e1(corpstable, attacker, hitloc, damageflags) {
  weapon_utility::function_626fe75ad9d2d09b(self, #"j_spineupper", "sbandit_fatal");
  weapon_utility::function_f1337d8a77853c84(self, corpstable);
  return true;
}

function private function_6856bb2d373441ec(corpstable, attacker, hitloc, damageflags) {
  weapon_utility::function_626fe75ad9d2d09b(self, #"tag_sync", "slatedprism_fatal");
  weapon_utility::function_f1337d8a77853c84(self, corpstable);
  return true;
}

function private function_2f17d26b59e4021f(corpstable, attacker, hitloc, damageflags) {
  weapon_utility::function_626fe75ad9d2d09b(self, #"tag_sync", "spider_fatal");
  weapon_utility::function_f1337d8a77853c84(self, corpstable);
  return true;
}

function private function_688a6360ee004683(corpstable, attacker, hitloc, damageflags) {
  weapon_utility::function_626fe75ad9d2d09b(self, #"tag_sync", "arcstorm_fatal");
  return true;
}

function private function_4534e7fe41bc0d07(corpstable, attacker, hitloc, damageflags) {
  weapon_utility::function_626fe75ad9d2d09b(self, #"tag_origin", "anime_knights_fatal_ground");
  weapon_utility::function_626fe75ad9d2d09b(self, #"j_spineupper", "anime_knights_fatal");
  return false;
}

function private function_fbb92c11b3a762ef(corpstable, attacker, hitloc, damageflags) {
  weapon_utility::function_626fe75ad9d2d09b(self, #"tag_sync", "harlequin_fatal");
  weapon_utility::function_f1337d8a77853c84(self, corpstable);
  return true;
}

function private function_31ad67ef393627b1(corpstable, attacker, hitloc, damageflags) {
  weapon_utility::function_626fe75ad9d2d09b(self, #"tag_sync", "techwear_fatal");
  weapon_utility::function_f1337d8a77853c84(self, corpstable);
  return true;
}

function private function_2ba14e429a0e80ef(corpstable, attacker, hitloc, damageflags) {
  weapon_utility::function_626fe75ad9d2d09b(self, #"tag_sync", "spaceignition_fatal");
  return false;
}

function private function_2dc8a868c2055cf(corpstable, attacker, hitloc, damageflags) {
  weapon_utility::function_626fe75ad9d2d09b(self, #"tag_sync", "eldritch_fatal");
  weapon_utility::function_f1337d8a77853c84(self, corpstable);
  return true;
}

function private function_e0435f3257140865(corpstable, attacker, hitloc, damageflags) {
  weapon_utility::function_626fe75ad9d2d09b(self, #"tag_sync", "outbreak_fatal");
  weapon_utility::function_f1337d8a77853c84(self, corpstable);
  return false;
}

function private function_2b8125f68ce7d135(corpstable, attacker, hitloc, damageflags) {
  weapon_utility::function_626fe75ad9d2d09b(self, #"tag_sync", "cyberviking_fatal");
  return false;
}

function private function_875d9576c3d285d7(corpstable, attacker, hitloc, damageflags) {
  weapon_utility::function_626fe75ad9d2d09b(self, #"tag_sync", "chickentendies_fatal");
  weapon_utility::function_f1337d8a77853c84(self, corpstable);
  return false;
}

function private function_fca1dd0006b8d105(corpstable, attacker, hitloc, damageflags) {
  weapon_utility::function_626fe75ad9d2d09b(self, #"j_spineupper", "yokai_fatal");
  weapon_utility::function_f1337d8a77853c84(self, corpstable);
  return false;
}

function private function_517b342d8a83238e(corpstable, attacker, hitloc, damageflags) {
  weapon_utility::function_626fe75ad9d2d09b(self, #"tag_sync", "cronen_squall_fatal");
  weapon_utility::function_f1337d8a77853c84(self, corpstable);
  return true;
}

function private function_2a424a972b512d77(corpstable, attacker, hitloc, damageflags) {
  weapon_utility::function_626fe75ad9d2d09b(self, #"tag_sync", "hades_hands_fatal");
  weapon_utility::function_f1337d8a77853c84(self, corpstable);
  return true;
}

function private function_47d45fb04a6a6151(corpstable, attacker, hitloc, damageflags) {
  weapon_utility::function_626fe75ad9d2d09b(self, #"tag_sync", "prismatic_force_fatal");
  weapon_utility::function_f1337d8a77853c84(self, corpstable);
  return true;
}

function private function_430241fe33189a30(corpstable, attacker, hitloc, damageflags) {
  weapon_utility::function_626fe75ad9d2d09b(self, #"j_head", "vfx_imp_flesh_fatal_gunhead_head");
  weapon_utility::function_626fe75ad9d2d09b(self, #"j_spinelower", "vfx_imp_flesh_fatal_gunhead");
  weapon_utility::function_626fe75ad9d2d09b(self, #"j_shoulder_ri", "vfx_imp_flesh_fatal_gunhead_arm");
  weapon_utility::function_626fe75ad9d2d09b(self, #"j_shoulder_le", "vfx_imp_flesh_fatal_gunhead_arm");
  weapon_utility::function_626fe75ad9d2d09b(self, #"j_elbow_ri", "vfx_imp_flesh_fatal_gunhead_arm");
  weapon_utility::function_626fe75ad9d2d09b(self, #"j_elbow_le", "vfx_imp_flesh_fatal_gunhead_arm");
  weapon_utility::function_626fe75ad9d2d09b(self, #"j_hip_ri", "vfx_imp_flesh_fatal_gunhead_leg");
  weapon_utility::function_626fe75ad9d2d09b(self, #"j_hip_le", "vfx_imp_flesh_fatal_gunhead_leg");
  weapon_utility::function_f1337d8a77853c84(self, corpstable);
  return true;
}

function private function_d2f5fbf15fba705f(corpstable, attacker, hitloc, damageflags) {
  weapon_utility::function_626fe75ad9d2d09b(self, #"tag_sync", "mech_fatal");
  weapon_utility::function_f1337d8a77853c84(self, corpstable);
  return true;
}

function private function_1fe1dde207b07666(corpstable, attacker, hitloc, damageflags) {
  weapon_utility::function_626fe75ad9d2d09b(self, #"j_spineupper", "rhino_armor_fatal");
  weapon_utility::function_626fe75ad9d2d09b(self, #"tag_sync", "rhino_armor_fatal_ground");
  weapon_utility::function_626fe75ad9d2d09b(self, #"j_head", "rhino_armor_fatal_head");
  weapon_utility::function_626fe75ad9d2d09b(self, #"j_shoulder_ri", "rhino_armor_fatal_arm");
  weapon_utility::function_626fe75ad9d2d09b(self, #"j_shoulder_le", "rhino_armor_fatal_arm");
  weapon_utility::function_626fe75ad9d2d09b(self, #"j_elbow_ri", "rhino_armor_fatal_arm");
  weapon_utility::function_626fe75ad9d2d09b(self, #"j_elbow_le", "rhino_armor_fatal_arm");
  weapon_utility::function_626fe75ad9d2d09b(self, #"j_hip_ri", "rhino_armor_fatal_arm");
  weapon_utility::function_626fe75ad9d2d09b(self, #"j_hip_le", "rhino_armor_fatal_arm");
  weapon_utility::function_626fe75ad9d2d09b(self, #"j_knee_ri", "rhino_armor_fatal_arm");
  weapon_utility::function_626fe75ad9d2d09b(self, #"j_knee_le", "rhino_armor_fatal_arm");
  weapon_utility::function_f1337d8a77853c84(self, corpstable);
  return true;
}

function private function_f3b248f8f490901b(corpstable, attacker, hitloc, damageflags) {
  weapon_utility::function_626fe75ad9d2d09b(self, #"j_spineupper", "vampire_hunter_fatal");
  weapon_utility::function_626fe75ad9d2d09b(self, #"tag_sync", "vampire_hunter_fatal_ground");
  weapon_utility::function_f1337d8a77853c84(self, corpstable);
  return true;
}

function private function_b7f085a894181de2(corpstable, attacker, hitloc, damageflags) {
  weapon_utility::function_626fe75ad9d2d09b(self, #"tag_origin", "toxic_terror_fatal");
  return false;
}

function private function_ed3e40ce6e799b8c(corpstable, attacker, hitloc, damageflags) {
  weapon_utility::function_626fe75ad9d2d09b(self, #"tag_sync", "spectral_ghost_fatal");
  weapon_utility::function_f1337d8a77853c84(self, corpstable);
  return true;
}

function private function_d3e15a40ed423fed(corpstable, attacker, hitloc, damageflags) {
  weapon_utility::function_626fe75ad9d2d09b(self, #"j_spinelower", "striker_wizards_fatal");
  weapon_utility::function_626fe75ad9d2d09b(self, #"tag_sync", "striker_wizards_fatal_ground");
  weapon_utility::function_f1337d8a77853c84(self, corpstable);
  return true;
}

function private function_7d85d806fae44cb6(corpstable, attacker, hitloc, damageflags) {
  weapon_utility::function_626fe75ad9d2d09b(self, #"tag_sync", "crytempest_fatal");
  weapon_utility::function_f1337d8a77853c84(self, corpstable);
  return true;
}

function private function_8211ec22561d54ca(corpstable, attacker, hitloc, damageflags) {
  function_47e3b72d9cc335d0(corpstable, "dark_avengers");
  return false;
}

function private function_78c680d497103381(corpstable, attacker, hitloc, damageflags) {
  weapon_utility::function_626fe75ad9d2d09b(self, #"tag_sync", "brassgolem_fatal");
  return true;
}

function private function_b32af13599aae6b8(corpstable, attacker, hitloc, damageflags) {
  weapon_utility::function_626fe75ad9d2d09b(self, #"tag_sync", "banshee_fatal");
  return false;
}

function private function_bea62625173f2f22(corpstable, attacker, hitloc, damageflags) {
  weapon_utility::function_626fe75ad9d2d09b(self, #"tag_sync", "d20_fatal");
  weapon_utility::function_f1337d8a77853c84(self, corpstable);
  return false;
}

function private function_156d2e3a006b9e8a(corpstable, attacker, hitloc, damageflags) {
  if(isdismembermentenabled()) {
    function_cffb5550ecd2e3eb(corpstable, "easter_limb", "easter_torso", "easter_head");
  } else {
    function_cffb5550ecd2e3eb(corpstable, "easter_nogore_limb", "easter_nogore_torso", "easter_nogore_head");
  }

  return true;
}

function private function_3dd4cd23f7a40b3b(corpstable, attacker, hitloc, damageflags) {
  function_47e3b72d9cc335d0(corpstable, "electricAnime");
  return false;
}

function private function_10befaf2d75b1318(corpstable, attacker, hitloc, damageflags) {
  function_cffb5550ecd2e3eb(corpstable, "scifi_limb", "scifi_torso", "scifi_head");
  weapon_utility::function_626fe75ad9d2d09b(self, #"tag_origin", "scifi_origin");
  return true;
}

function private function_1e566c57e33c1b2a(corpstable, attacker, hitloc, damageflags) {
  function_cffb5550ecd2e3eb(corpstable, "scifi2_limb", "scifi2_torso", "scifi2_head");
  weapon_utility::function_626fe75ad9d2d09b(self, #"tag_origin", "scifi2_origin");
  return true;
}

function private function_71a5badf21c84daf(corpstable, attacker, hitloc, damageflags) {
  function_cffb5550ecd2e3eb(corpstable, "scifi3_limb", "scifi3_torso", "scifi3_head");
  weapon_utility::function_626fe75ad9d2d09b(self, #"tag_origin", "scifi3_origin");
  return true;
}

function private function_7bdfb3ffd2ec0432(corpstable, attacker, hitloc, damageflags) {
  weapon_utility::function_626fe75ad9d2d09b(self, #"j_spineupper", "420_death");
  return false;
}

function private function_b4802d28df000a50(corpstable, attacker, hitloc, damageflags) {
  weapon_utility::function_626fe75ad9d2d09b(self, #"j_spineupper", "hitscan");
  return false;
}

function private function_d29abe23b27afa99(corpstable, attacker, hitloc, damageflags) {
  weapon_utility::function_626fe75ad9d2d09b(self, #"j_spine4", "witch");
  weapon_utility::function_f1337d8a77853c84(self, corpstable);
  return true;
}

function private function_7881cf4b9ba631d2(corpstable, attacker, hitloc, damageflags) {
  if(hitloc == "head" || hitloc == "helmet") {
    weapon_utility::function_626fe75ad9d2d09b(self, #"j_spine4", "zombie");
    weapon_utility::function_f1337d8a77853c84(self, corpstable);
    return true;
  }

  return false;
}

function private function_354884b05ce1e6e7(corpstable, attacker, hitloc, damageflags) {
  weapon_utility::function_626fe75ad9d2d09b(self, #"tag_origin", "thor");
  weapon_utility::function_626fe75ad9d2d09b(self, #"j_spineupper", "thor_chest");
  weapon_utility::function_f1337d8a77853c84(self, corpstable);
  return true;
}

function private function_ead20b21fee118f5(corpstable, attacker, hitloc, damageflags) {
  function_47e3b72d9cc335d0(corpstable, "kd");
  return false;
}

function private function_4a737c26e8f2af7f(corpstable, attacker, hitloc, damageflags) {
  function_47e3b72d9cc335d0(corpstable, "cdl");
  return false;
}

function private function_8112584bc0f47cdc(corpstable, attacker, hitloc, damageflags) {
  deletebody = 0;
  function_cffb5550ecd2e3eb(corpstable, "soulEater_limb", "soulEater_torso", "soulEater_head", undefined, deletebody);
  weapon_utility::function_626fe75ad9d2d09b(self, #"tag_origin", "soulEater_death");
  attacker thread function_404bd1e786a6c87b(corpstable);
  return deletebody;
}

function private mtx_crashdeath(corpstable, attacker, hitloc, damageflags) {
  function_cffb5550ecd2e3eb(corpstable, "crash_limb", "crash_torso", "crash_head");
  return true;
}

function private function_4f239c5dd971f98c(corpstable, attacker, hitloc, damageflags) {
  weapon_utility::function_626fe75ad9d2d09b(self, #"tag_origin", "akihabara_fatal");
  weapon_utility::function_f1337d8a77853c84(self, corpstable);
  return true;
}

function private function_6f112bc5b64c892b(corpstable, attacker, hitloc, damageflags) {
  if(corpstable isscriptable()) {
    corpstable setscriptablepartstate(#"burning", "flareup", 0);
  }

  return false;
}

function private function_48122bf57920846d(corpstable, attacker, hitloc, damageflags) {
  if(isdismembermentenabled()) {
    function_cffb5550ecd2e3eb(corpstable, "cthulhu_limb", "cthulhu_torso", "cthulhu_head");
  } else {
    function_cffb5550ecd2e3eb(corpstable, "cthulhu_nogore_limb", "cthulhu_nogore_torso", "cthulhu_nogore_head");
  }

  return true;
}

function private function_80325eed89fbbec6(corpstable, attacker, hitloc, damageflags) {
  if(isdismembermentenabled()) {
    function_cffb5550ecd2e3eb(corpstable, "hlander_limb", "hlander_torso", "hlander_head");
  } else {
    function_cffb5550ecd2e3eb(corpstable, "hlander_nogore_limb", "hlander_nogore_torso", "hlander_nogore_head");
  }

  return true;
}

function private function_d112506f4f3a72a2(corpstable, attacker, hitloc, damageflags) {
  if(hitloc == "head") {
    function_47e3b72d9cc335d0(corpstable, "bnoir_head");
  } else {
    function_47e3b72d9cc335d0(corpstable, "bnoir");
  }

  return false;
}

function private function_f93e3f01a1b7a791(corpstable, attacker, hitloc, damageflags) {
  tag = function_1c00c343fc5ff4d1(hitloc);
  playFXOnTag(level._effect["40k"], corpstable, tag);
  return false;
}

function private function_2b9bf1a3a1bfe13e(corpstable, attacker, hitloc, damageflags) {
  tag = function_1c00c343fc5ff4d1(hitloc);
  playFXOnTag(level._effect["underworld"], corpstable, tag);
  return false;
}

function private function_5e11e3a4b3b78d7d(corpstable, attacker, hitloc, damageflags) {
  tag = function_1c00c343fc5ff4d1(hitloc);
  playFXOnTag(level._effect["wonton"], corpstable, tag);
  return false;
}

function private function_fe7e870e73d2d56b(corpstable, attacker, hitloc, damageflags) {
  tag = function_1c00c343fc5ff4d1(hitloc);
  playFXOnTag(level._effect["mandu"], corpstable, tag);
  return false;
}

function private function_58456461eb2687(corpstable, attacker, hitloc, damageflags) {
  function_47e3b72d9cc335d0(corpstable, "blackcell_s5Melee");
  return false;
}

function private function_101cbff94707b454(corpstable, attacker, hitloc, damageflags) {
  tag = function_1c00c343fc5ff4d1(hitloc);
  playFXOnTag(level._effect["blackcell_s5"], corpstable, tag);
  return false;
}

function private function_e64be728c0e9123c(corpstable, attacker, hitloc, damageflags) {
  function_47e3b72d9cc335d0(corpstable, "gilmanMelee");
  return false;
}

function private function_8480b4cc59c7eba5(corpstable, attacker, hitloc, damageflags) {
  tag = function_1c00c343fc5ff4d1(hitloc);
  playFXOnTag(level._effect["shapechanger"], corpstable, tag);
  return false;
}

function private function_d178c469de8d12f0(corpstable, attacker, hitloc, damageflags) {
  tag = function_1c00c343fc5ff4d1(hitloc);
  playFXOnTag(level._effect["tonfa"], corpstable, tag);
  return false;
}

function private function_7f3124192d315274(corpstable, attacker, hitloc, damageflags) {
  tag = function_1c00c343fc5ff4d1(hitloc);

  if(isheavymeleedamage(damageflags)) {
    playFXOnTag(level._effect["vinyl_heavy"], corpstable, tag);
  } else {
    playFXOnTag(level._effect["vinyl"], corpstable, tag);
  }

  return false;
}

function private function_a27cf61b0f889410(corpstable, attacker, hitloc, damageflags) {
  function_47e3b72d9cc335d0(corpstable, "40kMelee");
  return false;
}

function private function_4d766e72a2d5a7cf(corpstable, attacker, hitloc, damageflags) {
  function_47e3b72d9cc335d0(corpstable, "underworldMelee");
  return false;
}

function private function_9864bf3a29f8b39c(corpstable, attacker, hitloc, damageflags) {
  function_47e3b72d9cc335d0(corpstable, "wontonMelee");
  return false;
}

function private function_acc7062661ad1992(corpstable, attacker, hitloc, damageflags) {
  function_47e3b72d9cc335d0(corpstable, "manduMelee");
  return false;
}

function private function_bb2096de44b38305(corpstable, attacker, hitloc, damageflags) {
  function_47e3b72d9cc335d0(corpstable, "blackcell_s5Melee");
  return false;
}

function private function_6f4b999be12a23e(corpstable, attacker, hitloc, damageflags) {
  function_47e3b72d9cc335d0(corpstable, "gilmanMelee");
  return false;
}

function private function_fa9a9781c9453b4(corpstable, attacker, hitloc, damageflags) {
  function_47e3b72d9cc335d0(corpstable, "shapechangerMelee");
  return false;
}

function private function_ce694afa144863b0(corpstable, attacker, hitloc, damageflags) {
  function_47e3b72d9cc335d0(corpstable, "ubSawMelee");
  return false;
}

function private function_9e7383d20f5bf879(corpstable, attacker, hitloc, damageflags) {
  tag = function_1c00c343fc5ff4d1(hitloc);
  playFXOnTag(level._effect["bikeMelee"], corpstable, tag);
  return false;
}

function private function_d7bf9ede0b764fe(corpstable, attacker, hitloc, damageflags) {
  tag = function_1c00c343fc5ff4d1(hitloc);
  playFXOnTag(level._effect["oreZincMelee"], corpstable, tag);
  return true;
}

function private function_ed03f0036ee25688(corpstable, attacker, hitloc, damageflags) {
  tag = function_1c00c343fc5ff4d1(hitloc);
  playFXOnTag(level._effect["pineapple"], corpstable, tag);
  return false;
}

function private function_3d5471b0be7f573(corpstable, attacker, hitloc, damageflags) {
  deletedbody = 0;

  if(isdismembermentenabled()) {
    function_cffb5550ecd2e3eb(corpstable, "golden_gun_limb", "golden_gun_torso", "golden_gun_head");
    deletedbody = 1;
  }

  weapon_utility::function_626fe75ad9d2d09b(self, #"tag_origin", "golden_gun_origin");
  return deletedbody;
}

function private function_cb1be48c5e1c432e(corpstable, attacker, hitloc, damageflags) {
  deletedbody = 0;

  if(isdismembermentenabled()) {
    function_cffb5550ecd2e3eb(corpstable, "mahou_limb", "mahou_torso", "mahou_head");
    deletedbody = 1;
  }

  weapon_utility::function_626fe75ad9d2d09b(self, #"tag_origin", "mahou_origin");
  return deletedbody;
}

function private function_acc95e18efa344e6(corpstable, attacker, hitloc, damageflags) {
  function_cffb5550ecd2e3eb(corpstable, "nicki_limb", "nicki_torso", "nicki_head");
  return true;
}

function private function_526ab8ba3e720951(corpstable, attacker, hitloc, damageflags) {
  if(isdismembermentenabled()) {
    function_cffb5550ecd2e3eb(corpstable, "ice_limb", "ice_torso", "ice_head");
  } else {
    function_cffb5550ecd2e3eb(corpstable, "ice_nogore_limb", "ice_nogore_torso", "ice_head");
  }

  return true;
}

function private function_59f427e659e59656(corpstable, attacker, hitloc, damageflags) {
  if(isdismembermentenabled()) {
    function_cffb5550ecd2e3eb(corpstable, "tomb_limb", "tomb_torso", "tomb_head");
  } else {
    function_cffb5550ecd2e3eb(corpstable, "tomb_limb_nogore", "tomb_torso_nogore", "tomb_head_nogore");
  }

  return true;
}

function private function_cac6c215604b1bb6(corpstable, attacker, hitloc, damageflags) {
  function_cffb5550ecd2e3eb(corpstable, "hips_limb", "hips_torso", "hips_head");
  return true;
}

function private function_5b4b07344f52aeac(corpstable, attacker, hitloc, damageflags) {
  function_cffb5550ecd2e3eb(corpstable, "hops_limb", "hops_torso", "hops_head");
  return true;
}

function private function_1e14fcd440666401(corpstable, attacker, hitloc, damageflags) {
  function_47e3b72d9cc335d0(corpstable, "blunt");
  return false;
}

function private function_b6c61638933fc2b5(corpstable, attacker, hitloc, damageflags) {
  if(isdismembermentenabled()) {
    function_cffb5550ecd2e3eb(corpstable, "maze_limb", "maze_torso", "maze_head");
  } else {
    function_cffb5550ecd2e3eb(corpstable, "maze_nogore_limb", "maze_nogore_torso", "maze_nogore_head");
  }

  return true;
}

function private function_6ce07cbf124e29ec(corpstable, attacker, hitloc, damageflags) {
  weapon_utility::function_626fe75ad9d2d09b(self, #"j_spinelower", "lilith");
  weapon_utility::function_f1337d8a77853c84(self, corpstable);
  return true;
}

function private function_6203d97d033830f(corpstable, attacker, hitloc, damageflags) {
  weapon_utility::function_626fe75ad9d2d09b(self, #"j_spine4", "lilith");
  weapon_utility::function_f1337d8a77853c84(self, corpstable);
  return true;
}

function private function_e67203e44711573e(corpstable, attacker, hitloc, damageflags) {
  return false;
}

function private function_bbd222e5d970003d(corpstable, attacker, hitloc, damageflags) {
  function_47e3b72d9cc335d0(corpstable, "skeletor");
  return false;
}

function private function_f5a201517913628c(corpstable, attacker, hitloc, damageflags) {
  function_cffb5550ecd2e3eb(corpstable, "bcell6_limb", "bcell6_torso", "bcell6_head");
  return false;
}

function private function_d291d7954e8bd025(corpstable, attacker, hitloc, damageflags) {
  weapon_utility::function_626fe75ad9d2d09b(self, #"j_spine4", "inarius");
  weapon_utility::function_f1337d8a77853c84(self, corpstable);
  return true;
}

function private function_ff069494f4f8611b(corpstable, attacker, hitloc) {
  weapon_utility::function_626fe75ad9d2d09b(self, #"tag_origin", "thor");
  weapon_utility::function_626fe75ad9d2d09b(self, #"j_spineupper", "thor_chest");
  return false;
}

function private function_415cef36c96147ee(corpstable, attacker, hitloc) {
  if(isdismembermentenabled()) {
    function_cffb5550ecd2e3eb(corpstable, "hlander_limb", "hlander_torso", "hlander_head");
  } else {
    function_cffb5550ecd2e3eb(corpstable, "hlander_nogore_limb", "hlander_nogore_torso", "hlander_nogore_head");
  }

  return true;
}

function private function_63c6b0a82b3a5e78(corpstable, attacker, hitloc, damageflags) {
  tag = function_1c00c343fc5ff4d1(hitloc);
  playFXOnTag(level._effect["voxel"], corpstable, tag);
  return true;
}

function private function_3e33cd3913a893a1(inflictor) {
  if(!isbrgamemode()) {
    return false;
  }

  if(inflictor.var_358fa7a9cb9bb135) {
    return true;
  }

  if(weapon_utility::isinflictorstucktoplayer(inflictor, self, "equip_bunkerbuster")) {
    return true;
  }

  return false;
}

function private function_d4ef90a55afa0767(corpstable) {
  if(isdismembermentenabled()) {
    function_cffb5550ecd2e3eb(corpstable, "hlander_limb", "hlander_torso", "hlander_head");
    return 1;
  }

  return 0;
}

function private function_30f2d11294017281(corpstable, attacker, hitloc, damageflags) {
  if(utility::percent_chance(10)) {
    if(self tagexists(#"j_spinelower")) {
      playFXOnTag(level._effect["raygunRepair"], corpstable, #"j_spinelower");
    }
  }

  return false;
}

function private function_a039e2941d94b1fa(corpstable, attacker, hitloc, damageflags) {
  if(self.type == "zombie") {
    if(utility::percent_chance(75)) {
      return false;
    }
  }

  tag = function_1c00c343fc5ff4d1(hitloc);

  if(self tagexists(tag)) {
    playFXOnTag(level._effect["cer_LimbDismemberment"], corpstable, tag);
  }

  return false;
}

function private function_f7bf5db7589592cd(corpstable, attacker, hitloc, damageflags) {
  if(self.type == "zombie") {
    if(utility::percent_chance(75)) {
      return false;
    }
  }

  if(self tagexists(#"j_spinelower")) {
    playFXOnTag(level._effect["cer_Annihilation"], corpstable, #"j_spinelower");
  }

  return false;
}

function private function_c4bdf31f66b16d0c(corpstable, attacker, hitloc, damageflags) {
  if(isdismembermentenabled()) {
    weapon_utility::function_626fe75ad9d2d09b(self, #"j_spine4", "vault");
    weapon_utility::function_f1337d8a77853c84(self, corpstable);
  } else {
    weapon_utility::function_626fe75ad9d2d09b(self, #"j_spine4", "vault_safe");
  }

  return true;
}

function private function_8a3e94642281db28(corpstable, attacker, hitloc, damageflags) {
  if(self.type == "zombie") {
    if(utility::percent_chance(75)) {
      return false;
    }
  }

  tag = function_1c00c343fc5ff4d1(hitloc);

  if(self tagexists(tag)) {
    playFXOnTag(level._effect["steampunk"], corpstable, tag);
  }

  return false;
}

function private function_70c79427f7f7b046(corpstable, attacker, hitloc, damageflags) {
  if(self.type == "zombie") {
    if(utility::percent_chance(75)) {
      return false;
    }
  }

  tag = function_1c00c343fc5ff4d1(hitloc);

  if(isDefined(level._effect["gvibes"]) && self tagexists(tag)) {
    playFXOnTag(level._effect["gvibes"], corpstable, tag);
  }

  return false;
}

function private function_e0d25276ba90ddd2(corpstable, attacker, hitloc, damageflags) {
  if(self.type == "zombie") {
    if(utility::percent_chance(75)) {
      return false;
    }
  }

  tag = function_1c00c343fc5ff4d1(hitloc);

  if(self tagexists(tag)) {
    playFXOnTag(level._effect["deadops"], corpstable, tag);
  }

  return false;
}

function private function_fdef5d3b5ebecefe(corpstable, attacker, hitloc, damageflags) {
  if(self.type == "zombie") {
    if(utility::percent_chance(75)) {
      return false;
    }
  }

  tag = function_1c00c343fc5ff4d1(hitloc);

  if(self tagexists(tag)) {
    playFXOnTag(level._effect["cartoon"], corpstable, tag);
  }

  return false;
}

function private function_add52bc88c7f4b5f(corpstable, attacker, hitloc, damageflags) {
  if(self.type == "zombie") {
    if(utility::percent_chance(75)) {
      return false;
    }
  }

  tag = function_1c00c343fc5ff4d1(hitloc);

  if(isDefined(level._effect["tmnt_slime"]) && self tagexists(tag)) {
    playFXOnTag(level._effect["tmnt_slime"], corpstable, tag);
  }

  return false;
}

function private function_679168476fe4e4e2(corpstable, attacker, hitloc, damageflags) {
  if(self.type == "zombie") {
    if(utility::percent_chance(75)) {
      return false;
    }
  }

  tag = function_1c00c343fc5ff4d1(hitloc);

  if(isDefined(level._effect["tmnt_don"]) && isDefined(tag) && self tagexists(tag)) {
    playFXOnTag(level._effect["tmnt_don"], corpstable, tag);
  }

  return false;
}

function private function_3233f38770168c37(corpstable, attacker, hitloc, damageflags) {
  if(self.type == "zombie") {
    if(utility::percent_chance(75)) {
      return false;
    }
  }

  tag = function_1c00c343fc5ff4d1(hitloc);

  if(isDefined(level._effect["tmnt_mike"]) && self tagexists(tag)) {
    playFXOnTag(level._effect["tmnt_mike"], corpstable, tag);
  }

  return false;
}

function private function_8efa8b8c894fca98(corpstable, attacker, hitloc, damageflags) {
  if(self.type == "zombie") {
    if(utility::percent_chance(75)) {
      return false;
    }
  }

  tag = function_1c00c343fc5ff4d1(hitloc);

  if(isDefined(level._effect["tmnt_raph"]) && self tagexists(tag)) {
    playFXOnTag(level._effect["tmnt_raph"], corpstable, tag);
  }

  return false;
}

function private function_8fcdcad357a21cb3(corpstable, attacker, hitloc, damageflags) {
  if(self.type == "zombie") {
    if(utility::percent_chance(75)) {
      return false;
    }
  }

  tag = function_1c00c343fc5ff4d1(hitloc);

  if(isDefined(level._effect["tmnt_leo"]) && self tagexists(tag)) {
    playFXOnTag(level._effect["tmnt_leo"], corpstable, tag);
  }

  return false;
}

function private function_9ba4703156f6a935(corpstable, attacker, hitloc, damageflags) {
  if(self.type == "zombie") {
    if(utility::percent_chance(75)) {
      return false;
    }
  }

  tag = function_1c00c343fc5ff4d1(hitloc);

  if(self tagexists(tag)) {
    playFXOnTag(level._effect["bigjoke"], corpstable, tag);
  }

  return false;
}

function private function_9cd1f18cc02aa1d4(corpstable, attacker, hitloc, damageflags) {
  if(self.type == "zombie") {
    if(utility::percent_chance(75)) {
      return false;
    }
  }

  if(isDefined(level._effect["tmnt_slime"]) && self tagexists(#"j_spinelower")) {
    playFXOnTag(level._effect["tmnt_slime"], corpstable, #"j_spinelower");
  }

  return false;
}

function private function_19221b97e8a0fc0d(corpstable, attacker, hitloc, damageflags) {
  if(self.type == "zombie") {
    if(utility::percent_chance(75)) {
      return false;
    }
  }

  tag = function_1c00c343fc5ff4d1(hitloc);

  if(isDefined(level._effect["bbots"]) && self tagexists(tag)) {
    playFXOnTag(level._effect["bbots"], corpstable, tag);
  }

  return false;
}

function private function_a4b186b340f4951d(corpstable, attacker, hitloc, damageflags) {
  if(self.type == "zombie") {
    if(utility::percent_chance(75)) {
      return false;
    }
  }

  tag = function_1c00c343fc5ff4d1(hitloc);

  if(isDefined(level._effect["comic_strip"]) && self tagexists(tag)) {
    playFXOnTag(level._effect["comic_strip"], corpstable, tag);
  }

  return false;
}

function private function_b01b5c2c9d832343(corpstable, attacker, hitloc, damageflags) {
  if(self.type == "zombie") {
    if(utility::percent_chance(75)) {
      return false;
    }
  }

  tag = function_1c00c343fc5ff4d1(hitloc);

  if(isDefined(level._effect["bacon"]) && self tagexists(tag)) {
    playFXOnTag(level._effect["bacon"], corpstable, tag);
  }

  return false;
}

function private function_f1c4db47cbe0c4da(corpstable, attacker, hitloc, damageflags) {
  if(self.type == "zombie") {
    if(utility::percent_chance(75)) {
      return false;
    }
  }

  tag = function_1c00c343fc5ff4d1(hitloc);

  if(isDefined(level._effect["tomato"]) && self tagexists(tag)) {
    playFXOnTag(level._effect["tomato"], corpstable, tag);
  }

  return false;
}

function private function_88ed32f74f3bde2e(corpstable, attacker, hitloc, damageflags) {
  if(self.type == "zombie") {
    if(utility::percent_chance(75)) {
      return false;
    }
  }

  tag = function_1c00c343fc5ff4d1(hitloc);

  if(isDefined(level._effect["ssword"]) && self tagexists(tag)) {
    playFXOnTag(level._effect["ssword"], corpstable, tag);
  }

  return false;
}

function private function_5cd363f0519189cc(corpstable, attacker, hitloc, damageflags) {
  if(self.type == "zombie") {
    if(utility::percent_chance(75)) {
      return false;
    }
  }

  tag = function_1c00c343fc5ff4d1(hitloc);

  if(isDefined(level._effect["dino"]) && self tagexists(tag)) {
    playFXOnTag(level._effect["dino"], corpstable, tag);
  }

  return false;
}

function private function_35bdc6f5345139d8(corpstable, attacker, hitloc, damageflags) {
  if(self.type == "zombie") {
    if(utility::percent_chance(75)) {
      return false;
    }
  }

  tag = function_1c00c343fc5ff4d1(hitloc);

  if(isDefined(level._effect["corgi"]) && self tagexists(tag)) {
    playFXOnTag(level._effect["corgi"], corpstable, tag);
  }

  return false;
}

function private function_3efb7c693ed2c9bf(corpstable, attacker, hitloc, damageflags) {
  if(self.type == "zombie") {
    if(utility::percent_chance(75)) {
      return false;
    }
  }

  tag = function_1c00c343fc5ff4d1(hitloc);

  if(isDefined(level._effect["aqueen"]) && self tagexists(tag)) {
    playFXOnTag(level._effect["aqueen"], corpstable, tag);
  }

  return false;
}

function private function_b2235b457eb3ba6d(corpstable, attacker, hitloc, damageflags) {
  if(self.type == "zombie") {
    if(utility::percent_chance(75)) {
      return false;
    }
  }

  tag = function_1c00c343fc5ff4d1(hitloc);

  if(isDefined(level._effect["hobbyhorse"]) && self tagexists(tag)) {
    playFXOnTag(level._effect["hobbyhorse"], corpstable, tag);
  }

  return false;
}

function private function_69aabe05bb1d9b65(corpstable, attacker, hitloc, damageflags) {
  if(self.type == "zombie") {
    if(utility::percent_chance(75)) {
      return false;
    }
  }

  tag = function_1c00c343fc5ff4d1(hitloc);

  if(isDefined(level._effect["poodle"]) && self tagexists(tag)) {
    playFXOnTag(level._effect["poodle"], corpstable, tag);
  }

  return false;
}

function private function_90969660ae379481(corpstable, attacker, hitloc, damageflags) {
  if(self.type == "zombie") {
    if(utility::percent_chance(75)) {
      return false;
    }
  }

  tag = function_1c00c343fc5ff4d1(hitloc);

  if(isDefined(level._effect["ikwydls"]) && self tagexists(tag)) {
    playFXOnTag(level._effect["ikwydls"], corpstable, tag);
  }

  return false;
}

function private function_c6cd4b6cb3f433dc(corpstable, attacker, hitloc, damageflags) {
  if(self.type == "zombie") {
    if(utility::percent_chance(75)) {
      return false;
    }
  }

  tag = function_1c00c343fc5ff4d1(hitloc);

  if(isDefined(level._effect["ahstormare"]) && self tagexists(tag)) {
    playFXOnTag(level._effect["ahstormare"], corpstable, tag);
  }

  return false;
}

function private function_a15233f558919f6a(corpstable, attacker, hitloc, damageflags) {
  if(self.type == "zombie") {
    if(utility::percent_chance(75)) {
      return false;
    }
  }

  tag = function_1c00c343fc5ff4d1(hitloc);

  if(isDefined(level._effect["tsoldier"]) && self tagexists(tag)) {
    playFXOnTag(level._effect["tsoldier"], corpstable, tag);
  }

  return false;
}

function private function_ad81703b0dbdcfd7(corpstable, attacker, hitloc, damageflags) {
  if(self.type == "zombie") {
    if(utility::percent_chance(75)) {
      return false;
    }
  }

  tag = function_1c00c343fc5ff4d1(hitloc);

  if(isDefined(level._effect["wninja"]) && self tagexists(tag)) {
    playFXOnTag(level._effect["wninja"], corpstable, tag);
  }

  return false;
}

function private function_26bd1f44452df27c(corpstable, attacker, hitloc, damageflags) {
  if(self.type == "zombie") {
    if(utility::percent_chance(75)) {
      return false;
    }
  }

  tag = function_1c00c343fc5ff4d1(hitloc);

  if(isDefined(level._effect["bluntev"]) && self tagexists(tag)) {
    playFXOnTag(level._effect["bluntev"], corpstable, tag);
  }

  return false;
}

function private function_721f1aa368179ac3(corpstable, attacker, hitloc, damageflags) {
  if(self.type == "zombie") {
    if(utility::percent_chance(75)) {
      return false;
    }
  }

  tag = function_1c00c343fc5ff4d1(hitloc);

  if(isDefined(level._effect["mskate"]) && self tagexists(tag)) {
    playFXOnTag(level._effect["mskate"], corpstable, tag);
  }

  return false;
}

function private function_c408f703e9930131(corpstable, attacker, hitloc, damageflags) {
  if(self.type == "zombie") {
    if(utility::percent_chance(75)) {
      return false;
    }
  }

  tag = function_1c00c343fc5ff4d1(hitloc);

  if(isDefined(level._effect["caramel"]) && self tagexists(tag)) {
    playFXOnTag(level._effect["caramel"], corpstable, tag);
  }

  return false;
}

function private function_6c0a75767197569b(corpstable, attacker, hitloc, damageflags) {
  if(self.type == "zombie") {
    if(utility::percent_chance(75)) {
      return false;
    }
  }

  tag = function_1c00c343fc5ff4d1(hitloc);

  if(isDefined(level._effect["bostaff_larpers"]) && self tagexists(tag)) {
    playFXOnTag(level._effect["bostaff_larpers"], corpstable, tag);
  }

  return false;
}

function private function_404bd1e786a6c87b(corpstable) {
  waittillframeend();

  if(self.var_ba0fee1a3d02f016[#"ghost_finder_sucking"]) {
    return;
  }

  soulent = spawn("script_model", corpstable.origin + (0, 0, 40));
  soulent setModel(%"vfx_scriptable_souleater");
  soulent function_474bcbb86b733bef("soulEater", self.team);
  self.var_ba0fee1a3d02f016[#"soul_ents_in_flight"][self.var_ba0fee1a3d02f016[#"soul_ents_in_flight"].size] = soulent;
  success = function_7a929edf3ec1ac4a(soulent);

  if(success) {
    thread souleatersuccess();
  } else {
    souleaterfail(soulent);
  }

  if(isDefined(soulent)) {
    if(isDefined(self) && isDefined(self.var_ba0fee1a3d02f016)) {
      self.var_ba0fee1a3d02f016[#"soul_ents_in_flight"] = arrayremove(self.var_ba0fee1a3d02f016[#"soul_ents_in_flight"], soulent);
    }

    soulent delete();
  }
}

function private function_69c7f36d235265fe() {
  self notify("stop_soulweapon_swap_logic");
  self endon("stop_soulweapon_swap_logic");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(true) {
    self waittill("weapon_switch_started", weapon);

    if(function_765a22b52d7fbd68(weapon) != #"soulEater") {
      self notify("stop_soul_suck");
    }
  }
}

function private function_7a929edf3ec1ac4a(soulent) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  var_78ec8791b63f8c69 = gettime();
  movetime = function_d3ed3d20753b49bd(soulent);
  hovertime = function_bba71cb4a381e2bc(soulent, var_78ec8791b63f8c69, movetime);
  destinationtime = var_78ec8791b63f8c69 + movetime + hovertime;
  soulent.destinationtime = destinationtime;
  soulent setscriptablepartstate(#"soulEater", "hover");
  soulent moveTo(soulent.origin + (0, 0, 15), 0.7);
  wait hovertime / 1000;
  soulent setscriptablepartstate(#"soulEater", "suck");
  var_a40e01b01f05959d = gettime();
  zoffsetmax = undefined;
  yoffsetmax = undefined;
  zoffset = undefined;
  yoffset = undefined;
  baseorigin = soulent.origin;
  thread function_2b1f4efb0ccea208(soulent, movetime);

  while(true) {
    if(!isDefined(self)) {
      return false;
    }

    timepassed = gettime() - var_a40e01b01f05959d;
    remainingtime = movetime - timepassed;
    timefraction = min(1, (timepassed + level.frameduration) / movetime);
    timeslice = level.frameduration * timefraction;

    if(remainingtime > timeslice) {
      movefraction = timeslice / remainingtime;
    } else {
      movefraction = 1;
    }

    if(remainingtime <= 0) {
      break;
    }

    var_3da60901acbb59a7 = math::factor_value(5, 0, self playerads());
    f = anglesToForward(self getplayerangles()) * 20;
    u = anglestoup(self getplayerangles()) * -9;
    r = anglestoright(self getplayerangles()) * var_3da60901acbb59a7;
    targetorigin = self getEye() + f + u + r;
    vectotarget = targetorigin - baseorigin;
    dirtotarget = vectorNormalize(vectotarget);
    dist = length(vectotarget);

    if(!isDefined(zoffsetmax)) {
      zoffsetmax = function_2374da3eb027daa0(dist);
      yoffsetmax = randomfloatrange(-1.5, 1.5) * zoffsetmax;
    }

    zoffset = function_558c7bcb43027f21(movetime, timepassed + level.frameduration, zoffsetmax);
    yoffset = function_558c7bcb43027f21(movetime, timepassed + level.frameduration, yoffsetmax);
    dirr = rotatevector(dirtotarget, (0, 90, 0));
    yoffset = dirr * yoffset;
    zoffset = (0, 0, zoffset);
    offset = dist * movefraction * dirtotarget;
    baseorigin += offset;
    soulent.origin = baseorigin + zoffset + yoffset;
    waitframe();
  }

  return true;
}

function private function_d3ed3d20753b49bd(soulent) {
  dist = length(soulent.origin - self.origin);
  factor = math::normalize_value(300, 2000, dist);
  return math::factor_value(0.4, 1, factor) * 1000;
}

function private function_bba71cb4a381e2bc(soulent, var_78ec8791b63f8c69, movetime) {
  self.var_ba0fee1a3d02f016[#"soul_ents_in_flight"] = function_5713d46873b29625(self.var_ba0fee1a3d02f016[#"soul_ents_in_flight"]);
  var_55bc73b91ac2704d = 700;

  if(self.var_ba0fee1a3d02f016[#"soul_ents_in_flight"][0] == soulent) {
    return var_55bc73b91ac2704d;
  }

  var_b295f0217f2499df = self.var_ba0fee1a3d02f016[#"soul_ents_in_flight"][self.var_ba0fee1a3d02f016[#"soul_ents_in_flight"].size - 2].destinationtime - var_78ec8791b63f8c69;
  var_cae40917d27e3fb4 = var_b295f0217f2499df + 300;
  var_57447b3dfe2ff593 = var_cae40917d27e3fb4 - movetime * 1000;
  return max(var_55bc73b91ac2704d, var_57447b3dfe2ff593);
}

function function_2374da3eb027daa0(var_21c50c9aa2e59321) {
  factor = math::normalize_value(300, 1000, var_21c50c9aa2e59321);
  return math::factor_value(7, 25, factor);
}

function function_558c7bcb43027f21(movetime, timepassed, offsetmax) {
  if(timepassed > movetime) {
    return 1;
  }

  halfmovetime = movetime * 0.5;

  if(timepassed > halfmovetime) {
    frac = (timepassed - halfmovetime) / halfmovetime;
  } else {
    frac = timepassed / halfmovetime;
    frac = 1 - frac;
  }

  frac *= frac;
  frac = 1 - frac;
  return frac * offsetmax;
}

function private souleatersuccess() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  function_c80dc1fc69011a01(#"reactive_soul_collect");
  self.var_ba0fee1a3d02f016[#"souls_collected_count"]++;

  if(isDefined(self.currentweapon) && function_cffba97fa52b9199(self.currentweapon)) {
    function_9b97bd8af57bf2a1();
  }

  wait 0.3;
  function_950d6b4e4595768f(#"reactive_soul_collect_1stage");
}

function private souleaterfail(soulent) {
  soulent setscriptablepartstate(#"soulEater", "vanish");
}

function private unlinkequipment(corpstable) {
  linkedchildren = corpstable getlinkedchildren();

  foreach(child in linkedchildren) {
    if(child.iscrossbowbolt) {
      child crossbow::boltunlink();
    }

    if(isDefined(child.equipmentref)) {
      switch (child.equipmentref) {
        case #"hash_8df9cfc147eb2d86":
        case #"hash_9ba0a6ff6081954e":
        case #"hash_de4641ddbc44a7ba":
        case #"hash_e156752cb79526e8":
        case #"hash_f0907f858c134cb4":
          child unlink();
          break;
        default:
          break;
      }
    }
  }
}

function private function_2b1f4efb0ccea208(ent, movetime) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  delay_time = (movetime - 300) / 1000;
  wait delay_time;

  if(getomnvar("ui_firing_range_has_started") == 1) {
    self playSound(#"iw9_weap_mtx_souleater_absorb");
    return;
  }

  if(isDefined(self.team)) {
    self playsoundtoteam(#"iw9_weap_mtx_souleater_absorb", self.team, undefined, self);
    return;
  }

  self playsoundtoplayer(#"iw9_weap_mtx_souleater_absorb", self);
}

function function_bb6fc6aabe552b3b(params) {
  if(getdvarint(@ "hash_cde633441920a939", 0) == 1) {
    return;
  }

  if(isDefined(self.mimicoriginal)) {
    function_cbbd53b75b2e4905(self.mimicoriginal, self.var_a3d9b28f9e057ec9, self.var_48d562b33d391197);
  }

  if(!isDefined(self.operatorcustomization) || self.operatorcustomization.execution != "jup_mp_execution_thyme_01" && self.operatorcustomization.execution != "jup_mp_execution_thyme_sage_01") {
    return;
  }

  self notify("mimic_restart");
  thread function_8d03dfd9b0369bbe();
  thread function_b1966d7e3804ad18();
}

function function_8d03dfd9b0369bbe() {
  var_53afa5ed5ab849c5 = utility::getsharedfunc(#"customization", #"getoperatorcustomization");

  if(!isDefined(var_53afa5ed5ab849c5)) {
    return;
  }

  if(isDefined(self.mimicoriginal)) {
    return;
  }

  self.mimicoriginal = self[[var_53afa5ed5ab849c5]]();
  self.var_a3d9b28f9e057ec9 = self getcustomizationviewmodel();
  self.var_48d562b33d391197 = self function_fc823f1a3dcd593e();
}

function function_cbbd53b75b2e4905(models, vm, reactive) {
  var_4926928b0d22ff9d = utility::getsharedfunc(#"customization", #"setcharactermodels");

  if(!isDefined(var_4926928b0d22ff9d)) {
    return;
  }

  operator::function_c8490391be6bc57e(models[0], models[1]);
  self[[var_4926928b0d22ff9d]](models[0], models[1], vm);

  if(isDefined(self.operatorcustomization)) {
    self.operatorcustomization.reactiveoperator = reactive;
  }

  if(isDefined(reactive)) {
    self function_184d7ec010cfaa92(reactive);
    return;
  }

  self function_16332a7775f10aa9();
}

function mtx_mimic_execution_cancelled_watcher() {
  self endon("mtx_mimic_got_a_kill");

  while(true) {
    if(!self isinexecutionattack()) {
      self notify("mtx_mimic_execution_cancelled");
      return;
    }

    waitframe();
  }
}

function function_f344e4a0bc2dbc5(customization) {
  self endon("mtx_mimic_execution_cancelled");

  while(true) {
    self waittill("got_a_kill", victim, sweapon, meansofdeath);

    if(meansofdeath != "MOD_EXECUTION" || !isPlayer(victim) && !isbot(victim)) {
      continue;
    }

    vm = victim getcustomizationviewmodel();
    reactive = victim function_fc823f1a3dcd593e();
    function_cbbd53b75b2e4905(customization, vm, reactive);
    self notify("mtx_mimic_got_a_kill");
    return;
  }
}

function function_b1966d7e3804ad18() {
  self endon("death");
  self endon("disconnect");
  self endon("mimic_restart");
  var_53afa5ed5ab849c5 = utility::getsharedfunc(#"customization", #"getoperatorcustomization");

  if(!isDefined(var_53afa5ed5ab849c5)) {
    return;
  }

  while(true) {
    self waittill("execution_begin", victim);

    if(!isDefined(victim) || !isPlayer(victim) && !isbot(victim)) {
      continue;
    }

    if(issubstr(self.suit, "juggernaut")) {
      continue;
    }

    executionref = self.executionref;

    if(!isDefined(executionref) && isDefined(self.operatorcustomization)) {
      executionref = self.operatorcustomization.execution;
    }

    if(executionref != "jup_mp_execution_thyme_01" && self.operatorcustomization.execution != "jup_mp_execution_thyme_sage_01") {
      continue;
    }

    customization = victim[[var_53afa5ed5ab849c5]]();
    self loadcustomization(customization[0], customization[1], 1);
    childthread mtx_mimic_execution_cancelled_watcher();
    childthread function_f344e4a0bc2dbc5(customization);
    utility::waittill_any("mtx_mimic_execution_cancelled", "mtx_mimic_got_a_kill");
  }
}

function private function_cffb5550ecd2e3eb(corpstable, limbfx, torsofx, headfx, sfx, deletebody) {
  if(!isDefined(deletebody)) {
    deletebody = 1;
  }

  weapon_utility::playdeathvfx(self, corpstable, limbfx, torsofx, headfx, sfx, deletebody);
}

function private function_47e3b72d9cc335d0(corpstable, state) {
  if(corpstable isscriptable() && corpstable getscriptablehaspart("mtxDeath") && corpstable getscriptableparthasstate("mtxDeath", state)) {
    corpstable setscriptablepartstate("mtxDeath", state, 0);
  }
}

function private function_1c00c343fc5ff4d1(hitloc) {
  tag = #"j_spinelower";

  if(hitloc == "head" || hitloc == "helmet" || hitloc == "neck") {
    tag = #"j_head";
  } else if(hitloc == "right_arm_upper" || hitloc == "right_arm_lower" || hitloc == "right_hand") {
    tag = #"j_shoulder_ri";
  } else if(hitloc == "left_arm_upper" || hitloc == "left_arm_lower" || hitloc == "left_hand") {
    tag = #"j_shoulder_le";
  } else if(hitloc == "right_leg_upper" || hitloc == "right_leg_lower" || hitloc == "right_foot") {
    tag = #"j_hip_ri";
  } else if(hitloc == "left_leg_upper" || hitloc == "left_leg_lower" || hitloc == "left_foot") {
    tag = #"j_hip_le";
  }

  return tag;
}

function private isheavymeleedamage(damageflags) {
  return isDefined(damageflags) && damageflags & 131072;
}

function private function_ce6577f1ddc5d04e(value) {
  self.var_ba0fee1a3d02f016[#"mtx_scriptable_charm_state"] = value;
}

function private function_849d75d167d2df2f(value) {
  self.var_ba0fee1a3d02f016[#"mtx_scriptable_gunscreen_state"] = value;
}

function private function_97bf7c711098ca98(name, value) {
  if(!isDefined(self.var_ba0fee1a3d02f016[#"mtx_scriptable_reactive_ids"][name])) {
    self.var_ba0fee1a3d02f016[#"mtx_scriptable_reactive_ids"][name] = value;
  }
}

function private function_b282f58365d0a8eb(name, value) {
  if(!isDefined(self.var_ba0fee1a3d02f016[#"mtx_scriptable_toggle_ids"][name])) {
    self.var_ba0fee1a3d02f016[#"mtx_scriptable_toggle_ids"][name] = #"toggle0";
  }
}

function private function_745383dc254e8178(name, value) {
  self.var_ba0fee1a3d02f016[name] = value;
}

function private function_826a1744af715c95() {
  self.var_ba0fee1a3d02f016[#"kill_streak"] = 0;
  self.var_ba0fee1a3d02f016[#"downgradable_kill_streak"] = 0;
  self.var_ba0fee1a3d02f016[#"reactive_kills"] = self.var_ba0fee1a3d02f016[#"match_kills"];
  self.var_ba0fee1a3d02f016[#"kill_streak_weapon"] = [];
  self.var_ba0fee1a3d02f016[#"all_scriptable_disablers"] = [];
  self.var_ba0fee1a3d02f016[#"direct_scriptable_disablers"] = [];
  self.var_ba0fee1a3d02f016[#"souls_collected_count"] = 0;
}

function private shouldkillcycle(currentkills, targetkills) {
  if(currentkills >= targetkills) {
    return true;
  }

  return false;
}

function private killcycleincrement(ref) {
  self.var_ba0fee1a3d02f016[ref]++;
}

function private killcyclereset(ref) {
  self.var_ba0fee1a3d02f016[ref] = 0;
}

function private function_c62e09e8e68ca737() {
  setDvar(@ "hash_a0c0a5bf060c7bf2", -1);
  setDvar(@ "hash_e5d7c5b83ec14d85", -1);
  setDvar(@ "hash_cefbf3b030b375ab", -1);
  setDvar(@ "hash_eac0e1ad1567fd42", -1);
  setDvar(@ "hash_cf86c6012f506ac8", -1);
  setDvar(@ "hash_6b3c6361f0f5fdb", -1);
  setDvar(@ "hash_beff73861be066d", -1);
  setDvar(@ "hash_4db0d2c2cd85d418", -1);
  setDvar(@ "hash_2391c05a8700227f", -1);
  setDvar(@ "hash_e001a97b368816c9", -1);
  setDvar(@ "hash_8d73f9a1e40b4f01", -1);
  setDvar(@ "hash_2ebdafd7eec10a70", -1);
  setDvar(@ "hash_51dcebb527f3dd9b", -1);
  setDvar(@ "hash_399fdd0fb6b02227", -1);
  setDvar(@ "hash_317afde463e47a0e", -1);
  setDvar(@ "hash_d5bfe694a8598141", -1);
  setDvar(@ "hash_d5b99091b7c0443e", -1);
  var_75e3436453aef910 = -1;
  var_ca0bfad57e9cc43d = -1;
  var_e810d76c7c3efd1a = -1;
  var_c706aa344ded9407 = -1;
  var_14c052148d620505 = -1;
  souleaterstate = -1;
  movementstate = -1;
  var_8810972a8c451fde = -1;
  var_4e8a4c9a9f1fc = -1;
  var_39360cb55490c06 = -1;
  spawnstate = -1;

  while(true) {
    var_75e3436453aef910 = function_66a3efb40d32649(#"reactive_match_kills_2stage", @ "hash_a0c0a5bf060c7bf2", var_75e3436453aef910);
    var_ca0bfad57e9cc43d = function_66a3efb40d32649(#"reactive_kill_streak_2stage", @ "hash_e5d7c5b83ec14d85", var_ca0bfad57e9cc43d);
    var_e810d76c7c3efd1a = function_66a3efb40d32649(#"reactive_kill_streak_3stage", @ "hash_cefbf3b030b375ab", var_e810d76c7c3efd1a);
    var_c706aa344ded9407 = function_66a3efb40d32649(#"reactive_kill_streak_4stage", @ "hash_eac0e1ad1567fd42", var_c706aa344ded9407);
    var_14c052148d620505 = function_66a3efb40d32649(#"reactive_kill_weapon_3stage", @ "hash_6b3c6361f0f5fdb", var_14c052148d620505);
    souleaterstate = function_66a3efb40d32649(#"reactive_soul_collect_1stage", @ "hash_cf86c6012f506ac8", souleaterstate);
    movementstate = function_66a3efb40d32649(#"reactive_movement", @ "hash_beff73861be066d", movementstate);
    var_4e8a4c9a9f1fc = function_66a3efb40d32649(#"reactive_enchantment", @ "hash_8d73f9a1e40b4f01", var_4e8a4c9a9f1fc);
    var_8810972a8c451fde = function_66a3efb40d32649(#"reactive_downgradable_kill_streak_3stage", @ "hash_e001a97b368816c9", var_8810972a8c451fde);
    var_39360cb55490c06 = function_66a3efb40d32649(#"reactive_kill_cycle_3stage", @ "hash_51dcebb527f3dd9b", var_39360cb55490c06);
    spawnstate = function_66a3efb40d32649(#"reactive_spawn", @ "hash_399fdd0fb6b02227", spawnstate);
    function_4d0321755fadbee2(#"reactive_kill", @ "hash_4db0d2c2cd85d418");
    function_4d0321755fadbee2(#"reactive_soul_collect", @ "hash_2391c05a8700227f");
    function_4d0321755fadbee2(#"reactive_damage_received", @ "hash_317afde463e47a0e");
    waitframe();
  }
}

function private function_66a3efb40d32649(key, dvar, var_74436294d8157c13) {
  if(getdvarint(dvar) != var_74436294d8157c13) {
    foreach(player in level.players) {
      player function_950d6b4e4595768f(key);
    }
  }

  return getdvarint(dvar);
}

function private function_4d0321755fadbee2(key, dvar) {
  if(getdvarint(dvar) > -1) {
    foreach(player in level.players) {
      player function_c80dc1fc69011a01(key);
    }
  }

  setDvar(dvar, -1);
}

function private function_494e1db9cf223798(corpstable, hitloc) {
  if(hitloc == "head" && isdismembermentenabled()) {
    function_47e3b72d9cc335d0(corpstable, "halloweenHeadpop");
  }
}