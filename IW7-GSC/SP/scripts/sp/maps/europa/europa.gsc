/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\europa\europa.gsc
*********************************************/

main() {
  if(getdvarint("r_reflectionprobegenerate")) {
    var_0 = getEntArray("armory_doors", "targetname");

    foreach(var_2 in var_0) {
      var_3 = spawn("script_model", var_2.origin);
      var_3.angles = var_2.angles;
      var_3 setModel(var_2.model);
    }

    var_5 = getEnt("base_door", "targetname");

    if(isDefined(var_5)) {
      var_5 hide();
    }

    scripts\sp\maps\europa\europa_armory::_id_8EAA();
  }

  setsaveddvar("sm_sunsamplesizenear", 0.5);
  setsaveddvar("sm_spotdistcull", 900);
  setsaveddvar("r_umbraMinObjectContribution", 0);
  setdvarifuninitialized("kleenex", 0);
  setdvarifuninitialized("no_defend", 0);
  setdvarifuninitialized("debug_ent_count", 0);
  setdvarifuninitialized("skip_outro", 0);
  setdvarifuninitialized("skip_outro_fadeup", 0);
  setdvarifuninitialized("music_enable", 1);
  setomnvar("ui_chyron", 0);
  scripts\sp\utility::_id_116CB("europa");
  scripts\sp\maps\europa\gen\europa_art::main();
  scripts\sp\maps\europa\europa_fx::main();
  scripts\sp\maps\europa\europa_precache::main();
  scripts\sp\maps\europa\europa_anim::main();
  level.primary = "iw7_m4+acogm4+fastaim+silencer";
  _id_FA53();
  _id_D7FB();
  _id_6E3A();
  scripts\sp\maps\europa\europa_intro::_id_9AB6();
  _id_0F1E::main();
  _id_0F1F::main();
  scripts\sp\utility::_id_1263F("europa_fatty_tr");
  scripts\sp\load::main();
  _id_0F21::main();
  _id_EDEB();
  scripts\engine\pipes::main();
  level.pipesdamage = 0;
  thread scripts\sp\maps\europa\europa_util::_id_4ED5();
  level thread _id_0A2F::_id_3D61();
  scripts\engine\utility::array_call(getEntArray("notsolid_on_load", "script_noteworthy"), ::notsolid);
  scripts\engine\utility::array_call(getnodearray("disconnect_on_load", "script_noteworthy"), ::_meth_80AC);
  scripts\engine\utility::array_thread(getEntArray("hide_on_load", "script_noteworthy"), scripts\sp\utility::_id_8E7E);
  scripts\engine\utility::array_thread(getEntArray("delete_linked", "targetname"), scripts\sp\maps\europa\europa_util::_id_5168);
  scripts\engine\utility::array_thread(getEntArray("sunscale_triggers", "targetname"), ::_id_1122F);
  scripts\engine\utility::array_thread(getEntArray("glass_break_trigger", "targetname"), scripts\sp\maps\europa\europa_util::_id_83C7);
  scripts\engine\utility::array_thread(getEntArray("ally_advance_trigger", "script_noteworthy"), scripts\sp\maps\europa\europa_labs::_id_1CC5);
  scripts\sp\utility::_id_28D7("axis");
  thread footsteps();
  level.player setweaponammostock("seeker", 0);

  if(scripts\sp\utility::_id_93A6()) {
    level.player _id_0E42::giveperk("specialty_extraequipment");
  } else {
    setomnvar("ui_hud_ability_primary", 0);
    setomnvar("ui_hud_ability_secondary", 0);
  }

  setsaveddvar("r_mbenable", 1);
  setsaveddvar("r_mbvelocityscale", 0.3);
  _id_5000();
  soundsettimescalefactor("music_lr", 0);
  soundsettimescalefactor("music_lsrs", 0);
  soundsettimescalefactor("weap_plr_fire_1_2d", 0.15);
  soundsettimescalefactor("weap_plr_fire_2_2d", 0.15);
  soundsettimescalefactor("weap_plr_fire_3_2d", 0.15);
  soundsettimescalefactor("weap_plr_fire_4_2d", 0.15);
  soundsettimescalefactor("weap_plr_fire_overlap_2d", 0.15);
  soundsettimescalefactor("weap_plr_fire_lfe_2d", 0);
  soundsettimescalefactor("weap_plr_fire_alt_1_2d", 0.15);
  soundsettimescalefactor("weap_plr_fire_alt_2_2d", 0.15);
  soundsettimescalefactor("weap_plr_fire_alt_3_2d", 0.15);
  soundsettimescalefactor("weap_plr_fire_alt_4_2d", 0.15);
  soundsettimescalefactor("weap_npc_main_3d", 0.2);
  soundsettimescalefactor("weap_npc_mech_3d", 0.2);
  soundsettimescalefactor("weap_npc_mid_3d", 0.2);
  soundsettimescalefactor("weap_npc_lfe_3d", 0);
  soundsettimescalefactor("weap_npc_dist_3d", 0.2);
  soundsettimescalefactor("weap_npc_lo_3d", 0.2);
  soundsettimescalefactor("explo_1_3d", 0.2);
  soundsettimescalefactor("explo_2_3d", 0.2);
  soundsettimescalefactor("explo_3_3d", 0.2);
  soundsettimescalefactor("explo_4_3d", 0.2);
  soundsettimescalefactor("bulletflesh_1_unres_3d_lim", 0.2);
  soundsettimescalefactor("bulletflesh_2_unres_3d_lim", 0.2);
  soundsettimescalefactor("bulletflesh_lfe_unres_2d_lim", 0);
  soundsettimescalefactor("bulletflesh_npc_1_unres_3d_lim", 0.2);
  soundsettimescalefactor("bulletflesh_npc_2_unres_3d_lim", 0.2);
  soundsettimescalefactor("bulletflesh_npcnpc1_unres_3d_lim", 0.2);
  soundsettimescalefactor("bulletflesh_npcnpc2_unres_3d_lim", 0.2);
  soundsettimescalefactor("bulletimpact_unres_3d_lim", 0.2);
  soundsettimescalefactor("bulletimpact_lo_unres_3d_lim", 0.2);
  soundsettimescalefactor("bullet_ricochets_unres_3d_lim", 0.2);
  soundsettimescalefactor("physics_lo_unres_3d_lim", 0.2);
  soundsettimescalefactor("foley_npc_step_3d", 0.2);
  soundsettimescalefactor("whizby_out_unres_3d_lim", 0.2);
  soundsettimescalefactor("whizby_in_unres_3d_lim", 0.2);
  soundsettimescalefactor("special_lo_unres_1_2d", 0.15);
  soundsettimescalefactor("voice_plr_breath_2d", 0.15);
  soundsettimescalefactor("scn_fx_res_2d", 0);
  soundsettimescalefactor("scn_lfe_unres_2d", 0);
  soundsettimescalefactor("pa_speaker", 0.15);
  soundsettimescalefactor("amb_bed_2d", 0.25);
  soundsettimescalefactor("amb_elm_unres_3d", 0.25);
  soundsettimescalefactor("amb_elm_int_unres_3d", 0.25);
  soundsettimescalefactor("amb_elm_ext_special_unres_3d", 0.25);
}

_id_49C4() {
  wait 0.2;
  thread scripts\sp\utility::_id_12641("europa_fatty_tr");
  level.player dontinterpolate();
  level.player setOrigin((29050, -4630, 4020), 1);
}

_id_5000() {
  setsaveddvar("r_mbradialoverridestrength", 0.002);
  setsaveddvar("r_mbRadialoverridechromaticAberration", 0.85);
}

footsteps() {
  var_0 = "soldier";
  scripts\anim\utility::_id_F715(var_0, "snow", loadfx("vfx/iw7/core/footstep/vfx_footstep_snow_medium.vfx"));
  scripts\anim\utility::_id_F715(var_0, "ice", loadfx("vfx/iw7/core/footstep/vfx_footstep_snow_medium.vfx"));
  scripts\anim\utility::_id_F716(var_0, "snow", loadfx("vfx/iw7/core/footstep/vfx_footstep_snow_medium.vfx"));
  scripts\anim\utility::_id_F716(var_0, "ice", loadfx("vfx/iw7/core/footstep/vfx_footstep_snow_medium.vfx"));
}

_id_FA53() {
  scripts\sp\utility::_id_F343("dropship");
  var_0 = ["europa_fatty_tr"];
  scripts\sp\utility::_id_1749("dropship", scripts\sp\maps\europa\europa_intro::_id_5DF1, "Dropship Flyin", scripts\sp\maps\europa\europa_intro::_id_5DEF, var_0, scripts\sp\maps\europa\europa_intro::_id_5DF0);
  scripts\sp\utility::_id_1749("dropship_jump", scripts\sp\maps\europa\europa_intro::_id_5E25, "Dropship jump", scripts\sp\maps\europa\europa_intro::_id_5E21, var_0, scripts\sp\maps\europa\europa_intro::_id_5E22);
  scripts\sp\utility::_id_1749("cliffjumper", scripts\sp\maps\europa\europa_intro::_id_4212, "Cliff Jumper", scripts\sp\maps\europa\europa_intro::_id_4209, var_0, scripts\sp\maps\europa\europa_intro::_id_420C);
  scripts\sp\utility::_id_1749("underground", scripts\sp\maps\europa\europa_labs::_id_12B8F, "underground", scripts\sp\maps\europa\europa_labs::_id_12B8C, var_0, scripts\sp\maps\europa\europa_labs::_id_12B8D);
  scripts\sp\utility::_id_1749("takedown", scripts\sp\maps\europa\europa_labs::_id_1146B, "takedown", scripts\sp\maps\europa\europa_labs::_id_1145E, var_0, scripts\sp\maps\europa\europa_labs::_id_11462);
  scripts\sp\utility::_id_1749("lab_exterior", scripts\sp\maps\europa\europa_labs::_id_A780, "Lab Exterior", scripts\sp\maps\europa\europa_labs::_id_A77D, var_0, scripts\sp\maps\europa\europa_labs::_id_A77E);
  scripts\sp\utility::_id_1749("lab_enter", scripts\sp\maps\europa\europa_labs::_id_A770, "Lab Entrance", scripts\sp\maps\europa\europa_labs::_id_A76D, var_0, scripts\sp\maps\europa\europa_labs::_id_A76E);
  scripts\sp\utility::_id_1749("airlock peek", scripts\sp\maps\europa\europa_labs::_id_A746, "Lab Airlock", scripts\sp\maps\europa\europa_labs::_id_A744, var_0, scripts\sp\maps\europa\europa_labs::_id_A745);
  scripts\sp\utility::_id_1749("Glass Bridge", scripts\sp\maps\europa\europa_labs::_id_A797, "LabWalk", scripts\sp\maps\europa\europa_labs::_id_A793, var_0, scripts\sp\maps\europa\europa_labs::_id_A794);
  scripts\sp\utility::_id_1749("Wonder Room", scripts\sp\maps\europa\europa_labs::_id_E1C7, "Enter Research", scripts\sp\maps\europa\europa_labs::_id_E1C3, var_0, scripts\sp\maps\europa\europa_labs::_id_E1C4);
  scripts\sp\utility::_id_1749("Office Fight", scripts\sp\maps\europa\europa_labs::_id_A788, "Office Fight", scripts\sp\maps\europa\europa_labs::_id_A786, var_0, scripts\sp\maps\europa\europa_labs::_id_A787);
  scripts\sp\utility::_id_1749("Cutter room approach", scripts\sp\maps\europa\europa_labs::_id_A76C, "Cutter room approach", scripts\sp\maps\europa\europa_labs::_id_A767, var_0, scripts\sp\maps\europa\europa_labs::_id_A769);
  scripts\sp\utility::_id_1749("armory", scripts\sp\maps\europa\europa_armory::_id_224A, "Armory", scripts\sp\maps\europa\europa_armory::_id_21A4, var_0, scripts\sp\maps\europa\europa_armory::_id_21CC);
  scripts\sp\utility::_id_1749("selfdestruct", scripts\sp\maps\europa\europa_armory::_id_2891, "Base Self Destruct", scripts\sp\maps\europa\europa_armory::_id_288C, var_0, scripts\sp\maps\europa\europa_armory::_id_288D);
  scripts\sp\utility::_id_1749("c12", scripts\sp\maps\europa\europa_armory::_id_3568, "C12", scripts\sp\maps\europa\europa_armory::_id_355D, var_0, scripts\sp\maps\europa\europa_armory::_id_355E);
  scripts\sp\utility::_id_1749("decompression", scripts\sp\maps\europa\europa_armory::_id_21DB, "Decompression", scripts\sp\maps\europa\europa_armory::_id_21DA, var_0);
  scripts\sp\utility::_id_1749("outro", scripts\sp\maps\europa\europa_outro::_id_C7D3, "Outro", scripts\sp\maps\europa\europa_outro::_id_C7B4, undefined);
}

_id_EDEB() {
  scripts\sp\maps\europa\europa_intro::_id_9ABC();
  scripts\sp\maps\europa\europa_labs::_id_A79C();
  scripts\sp\maps\europa\europa_armory::_id_220C();
  scripts\sp\maps\europa\europa_outro::_id_C7C6();
  _id_0B11::_id_37A9();
  scripts\engine\utility::array_thread(getEntArray("ai_gesture_trig", "targetname"), scripts\sp\maps\europa\europa_util::_id_1968);
}

_id_D7FB() {
  precachemodel("weapon_steeldragon_vm");
  precachemodel("robot_c12");
  precachemodel("veh_mil_air_un_pocketdrone");
  precachemodel("crr_light_overhead_01_off");
  precachemodel("robot_c6");
  precacherumble("light_2s");
  precacherumble("heavy_1s");
  precacherumble("heavy_3s");
  precacherumble("sniper_fire");
  precacherumble("damage_heavy");
  precacherumble("damage_light");
  precacheitem("jackal_mg_projectile");
  precacheitem("antigrav");
  precacheitem("iw7_m4_snow");
  precacheitem("iw7_fhr_snow");
  precachemodel("tactical_knife_iw7_vm");
  precachemodel("veh_mil_air_un_dropship_hero_interior_snow");
  precachemodel("body_hero_t_frost");
  precachemodel("body_hero_sipes_frost");
  precachemodel("head_hero_t_helmet_frost");
  precachemodel("helmet_head_hero_sipes_frost");
  precachemodel("pack_un_jackal_pilots_frost");
  precachemodel("viewmodel_un_jackal_pilots_frost");
  precachemodel("viewmodel_un_jackal_pilots");
  precachemodel("head_hero_t_hqss");
  precachemodel("head_hero_sipes_cine_hqss");
  precachestring(&"EUROPA_OBJECTIVE_ACCESS");
  precachestring(&"EUROPA_OBJECTIVE_FSPAR");
  precachestring(&"EUROPA_OBJECTIVE_ESCAPE");
}

_id_6E3A() {
  scripts\engine\utility::flag_init("entering_labs");
  scripts\engine\utility::flag_init("breach_det_complete");
  scripts\engine\utility::flag_init("lab_walk_c12_scene_salter");
  scripts\engine\utility::flag_init("lab_walk_c12_scene_done");
  scripts\engine\utility::flag_init("flashlights_off");
  scripts\engine\utility::flag_init("airlock_robot_scene_done");
  scripts\engine\utility::flag_init("player_in_combat");
  scripts\engine\utility::flag_init("engineer_scene_start");
  scripts\engine\utility::flag_init("mccallum_rummage_idle");
  scripts\engine\utility::flag_init("salter_rummage_idle");
  scripts\engine\utility::flag_init("mccallum_office_scene_done");
  scripts\engine\utility::flag_init("salter_office_scene_done");
  scripts\engine\utility::flag_init("player_grabbed_drone");
  scripts\engine\utility::flag_init("exit_engineer_office");
  scripts\engine\utility::flag_init("engineer_office_exit_door_open");
  scripts\engine\utility::flag_init("engineer_scene_complete");
  scripts\engine\utility::flag_init("armory_lights_on");
  scripts\engine\utility::flag_init("armory_c6_combat_complete");
  scripts\engine\utility::flag_init("player_opened_vault_door");
  scripts\engine\utility::flag_init("c12_event_player_ready");
  scripts\engine\utility::flag_init("c12_event_salter_ready");
  scripts\engine\utility::flag_init("c12_event_begin");
  scripts\engine\utility::flag_init("c12_fight_begin");
  scripts\engine\utility::flag_init("mccallum_turned_on_maglift");
  scripts\engine\utility::flag_init("mccallum_enters_c12_fight");
  scripts\engine\utility::flag_init("c12_fight_end");
  scripts\engine\utility::flag_init("steal_dragon_handoff");
  scripts\engine\utility::flag_init("player_used_heavy_weapon");
  scripts\engine\utility::flag_init("open_armory_exit_door");
  scripts\engine\utility::flag_init("combat_emp_breach_start");
  scripts\engine\utility::flag_init("combat_emp_breach_done");
  scripts\engine\utility::flag_init("jammed_door_unjammed");
  scripts\engine\utility::flag_init("player_at_broken_door");
  scripts\engine\utility::flag_init("engineer_at_broken_door");
  scripts\engine\utility::flag_init("broken_door_scene_done");
  scripts\engine\utility::flag_init("open_lab_exit_door");
  scripts\engine\utility::flag_init("sd_in_position_for_package");
  scripts\engine\utility::flag_init("sd_package_is_loaded");
  scripts\engine\utility::flag_init("sd_moveto_armory");
  scripts\engine\utility::flag_init("sd_moveto_broken_room");
  scripts\engine\utility::flag_init("sd_allow_jumpoff");
  scripts\engine\utility::flag_init("sd_moveto_lab_combat");
  scripts\engine\utility::flag_init("sd_allow_jumpon");
  scripts\engine\utility::flag_init("sd_moveto_airlock_position");
  scripts\engine\utility::flag_init("sd_moveto_lab_exit");
  scripts\engine\utility::flag_init("sd_reached_broken_door");
  scripts\engine\utility::flag_init("sd_waiting_for_allies");
  scripts\engine\utility::flag_init("sd_reached_defend");
}

_id_1122F() {
  if(!isDefined(level._id_4BC5)) {
    level._id_4BC5 = 3;
  }

  for(;;) {
    self waittill("trigger");
    var_0 = getdvarint("sm_sunsamplesizenear");

    if(self._id_EED6 == level._id_4BC5) {
      continue;
    }
    level._id_4BC5 = self._id_EED6;
    scripts\sp\utility::_id_AB9A("sm_sunsamplesizenear", self._id_EED6, 2);
  }
}

_id_A6F3() {
  if(isDefined(self._id_EDA0)) {
    scripts\engine\utility::flag_wait(self._id_EDA0);
  }

  scripts\engine\utility::trigger_on();
}