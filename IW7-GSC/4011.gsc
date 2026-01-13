/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 4011.gsc
*********************************************/

main() {
  precachempanim("IW7_cp_frontend_feeding_walk_off_civ");
  precachempanim("IW7_cp_frontend_feeding_walk_off_zom");
  precachempanim("IW7_cp_frontend_mugging_high_cam_z1_01");
  precachempanim("IW7_cp_frontend_mugging_high_cam_z1_02");
  precachempanim("IW7_cp_frontend_mugging_high_cam_z2_01");
  precachempanim("shipcrib_bridge_sitting_officer_idle_01");
  precachempanim("shipcrib_bridge_sitting_officer_idle_02");
  precachempanim("shipcrib_standing_console_idle_17");
  precachempanim("IW7_cp_frontend_mugging_01");
  precachempanim("IW7_cp_frontend_mugging_02");
  precachempanim("IW7_cp_frontend_mugging_03");
  precachempanim("IW7_cp_frontend_dragging_civ_01");
  precachempanim("IW7_cp_frontend_dragging_zom_01");
  precachempanim("IW7_cp_frontend_shoot_civ_01");
  precachempanim("IW7_cp_frontend_shoot_zom_01");
  precachempanim("IW7_cp_frontend_dragging_civ_02");
  precachempanim("IW7_cp_frontend_dragging_zom_02");
  precachemodel("zmb_fortune_teller_machine_jaw_01");
  precachemodel("tag_origin");
  precachemodel("zmb_poster_spaceland");
  precachemodel("zmb_poster_dlc1");
  precachemodel("zmb_poster_dlc2");
  precachemodel("zmb_poster_dlc3");
  precachemodel("zmb_poster_dlc4");
  precachemodel("zmb_female_fullbody_outfit_05");
  precachemodel("zmb_female_fullbody_outfit_03_3");
  precachemodel("zmb_female_fullbody_outfit_04");
  precachemodel("zmb_male_fullbody_outfit_03_3");
  precachemodel("zmb_male_fullbody_outfit_01");
  precachemodel("zmb_male_fullbody_outfit_02_2");
  precachemodel("zmb_female_head_01");
  precachemodel("zmb_female_head_02");
  precachemodel("zmb_male_head_01");
  precachemodel("zmb_male_head_02");
  precachemodel("zmb_female_head_01_hair_boatswaine_blonde");
  precachemodel("zmb_female_head_01_hair_boatswaine");
  precachemodel("c_civ_zur_male_body1_3");
  precachemodel("c_civ_zur_male_body2_4");
  precachemodel("c_civ_zur_female_body4_1");
  precachemodel("c_civ_zur_female_body5_3");
  precachemodel("head_female_bc_01");
  precachemodel("head_female_bc_02");
  precachemodel("head_bg_var_head_male_bc_02_head_male_bc_05");
  precachemodel("head_bg_var_head_male_bc_02_head_male_bc_07");
  precachemodel("weapon_revolver_wm");
  level._effect["zombie_attack"] = loadfx("vfx\iw7\core\zombie\blood\vfx_zmb_blood_frontend.vfx");
  level._effect["shot_impact"] = loadfx("vfx\iw7\core\zombie\blood\vfx_zmb_blood_frontend.vfx");
  level._effect["vfx_zb_sj_smk"] = loadfx("vfx\iw7\core\zombie\pack_a_punch\vfx_zb_sj_smk.vfx");
  level._effect["yellow_eye_glow"] = loadfx("vfx\iw7\core\zombie\vfx_zombie_yellow_eye_loop.vfx");
  level._effect["fnfeyes"] = loadfx("vfx\iw7\core\zombie\vfx_fnf_gloweyes.vfx");
  level._effect["muzzleflash"] = loadfx("vfx\iw7\core\zombie\vfx_frontend_muzzle_flash.vfx");
  level._effect["vfx_zb_pack_grd_d"] = loadfx("vfx\iw7\core\zombie\frontend\vfx_zb_d.vfx");
  level._effect["vfx_zb_pack_grd_e"] = loadfx("vfx\iw7\core\zombie\frontend\vfx_zb_e.vfx");
  level._effect["vfx_zb_pack_grd_c"] = loadfx("vfx\iw7\core\zombie\frontend\vfx_zb_c.vfx");
  level._effect["vfx_zb_pack_grd_b"] = loadfx("vfx\iw7\core\zombie\frontend\vfx_zb_b.vfx");
  level._effect["vfx_zb_pack_grd_a"] = loadfx("vfx\iw7\core\zombie\frontend\vfx_zb_a.vfx");
}