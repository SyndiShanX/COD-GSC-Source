/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\townhoused\townhoused_anim.gsc
**************************************************/

main() {
  setdvarifuninitialized("scr_reveal", "0");
  level.customnotetrackhandler = ::customnotetrackhandler;
  generic();
  backyard_intro();
  backyard();
  kitchen();
  dining_room();
  stairtrain1();
  stairtrain2();
  stairtrain3();
  hostage_room();
  second_floor_bedroom();
  bathroom_enemy();
  baby_room();
  bed_guy();
  buddy_down();
  favela_door();
  attic();
  ladder();
  player();
  script_model();
  vehicle();
  scriptable();

  if(getdvarint("LLQQOPKTKM") || getdvarint("SMNRNLNRN")) {
    return;
  }
  ai_gestures();

  if(level.demo)
    level.scr_model["generic_nvgs_on"] = "head_sas_urban_ar_nvg_viewmodel";
  else
    level.scr_model["generic_nvgs_on"] = "head_sas_urban_ar_nvg";

  level.scr_model["price_nvgs_on"] = "hat_hero_price_helmet";
}

#using_animtree("generic_human");

generic() {
  var_0 = "generic";
  level.scr_anim[var_0]["flash_react_knob"] = % thd_generic_flash_react;
  level.scr_anim[var_0]["flash_react"] = % thd_soldier_additive_flash_bang;
}

backyard_intro() {
  var_0 = "kyle";
  var_1 = "price";
  var_2 = "bravo2_1";
  var_3 = "bravo2_2";
  var_4 = "backyard_intro";
  level.scr_anim[var_0][var_4] = % thd_ba_005_intro_kyle;
  level.scr_anim[var_1][var_4] = % thd_ba_005_intro_price;
  level.scr_anim[var_2][var_4] = % thd_ba_005_intro_ally01;
  level.scr_anim[var_3][var_4] = % thd_ba_005_intro_ally02;
  var_4 = "backyard_intro_idle";
  level.scr_anim[var_1][var_4][0] = % thd_ba_005_intro_idle_price;
  level.scr_anim[var_2][var_4][0] = % thd_ba_005_intro_idle_ally01;
  level.scr_anim[var_3][var_4][0] = % thd_ba_005_intro_idle_ally02;
}

backyard() {
  var_0 = "price";
  var_1 = "bravo2_1";
  var_2 = "bravo2_2";
  var_3 = "bravo2_3";
  var_4 = "bravo2_4";
  var_5 = "backyard_alley_move";
  level.scr_anim[var_0][var_5] = % thd_ba_005_entry_alley_price;
  level.scr_anim[var_1][var_5] = % thd_ba_005_entry_alley_ally01;
  level.scr_anim[var_2][var_5] = % thd_ba_005_entry_alley_ally02;
  level.scr_anim[var_3][var_5] = % thd_ba_005_entry_alley_ally03;
  level.scr_anim[var_4][var_5] = % thd_ba_005_entry_alley_ally04;
  var_5 = "backyard_alley_move_idle";
  level.scr_anim[var_0][var_5][0] = % thd_ba_005_entry_alley_idle_price;
  level.scr_anim[var_1][var_5][0] = % thd_ba_005_entry_alley_idle_ally01;
  level.scr_anim[var_2][var_5][0] = % thd_ba_005_entry_alley_idle_ally02;
  level.scr_anim[var_3][var_5][0] = % thd_ba_005_entry_alley_idle_ally03;
  level.scr_anim[var_4][var_5][0] = % thd_ba_005_entry_alley_idle_ally04;
  var_5 = "backyard_move";
  level.scr_anim[var_0][var_5] = % thd_ba_005_entry_yard_price;
  level.scr_anim[var_1][var_5] = % thd_ba_005_entry_yard_ally01;
  level.scr_anim[var_2][var_5] = % thd_ba_005_entry_yard_ally02;
  var_5 = "backyard_move_idle";
  level.scr_anim[var_0][var_5][0] = % thd_ba_020_halligan_arrival_idle_price;
  level.scr_anim[var_1][var_5][0] = % thd_ba_020_halligan_arrival_idle_ally01;
  level.scr_anim[var_2][var_5][0] = % thd_ba_005_entry_yard_idle_ally02;
  level.scr_anim[var_3]["backyard_open_gate"] = % thd_ba_005_entry_yard_open_ally03;
  scripts\common\anim::addnotetrack_customfunction(var_3, "backyard_open_gate_sfx", ::sfx_townhouse_door_audio_backyard_gate, "backyard_open_gate");
  level.scr_anim[var_3]["backyard_open_gate_idle"][0] = level.scr_anim[var_3]["backyard_alley_move_idle"][0];
  var_5 = "backyard_move";
  level.scr_anim[var_4][var_5] = % thd_ba_005_entry_yard_ally04;
  level.scr_anim[var_3][var_5] = % thd_ba_005_entry_yard_ally03;
  var_5 = "backyard_move_idle";
  level.scr_anim[var_4][var_5][0] = % thd_ba_020_halligan_arrival_idle_ally04;
  level.scr_anim[var_3][var_5][0] = % thd_ba_005_entry_yard_idle_ally03;
  var_5 = "backdoor_freeze";
  level.scr_anim[var_0][var_5] = % thd_ba_020_halligan_freeze_price;
  scripts\common\anim::addnotetrack_customfunction(var_0, "grab_halligan", ::grab_halligan, "backdoor_freeze");
  scripts\common\anim::addnotetrack_customfunction(var_0, "halligan_basement_door_prep_sfx", ::sfx_townhouse_door_audio_basement_prep, "backdoor_freeze");
  level.scr_anim[var_1][var_5] = % thd_ba_020_halligan_freeze_ally01;
  var_5 = "backdoor_freeze_idle";
  level.scr_anim[var_0][var_5][0] = % thd_ba_020_halligan_freeze_idle_price;
  level.scr_anim[var_1][var_5][0] = % thd_ba_020_halligan_freeze_idle_ally01;
  level.scr_anim[var_0]["backdoor_freeze_nag"] = % thd_ba_020_halligan_freeze_nag_price;
  var_5 = "backdoor_enter";
  level.scr_anim[var_0][var_5] = % thd_ba_020_halligan_enter_price;
  scripts\common\anim::addnotetrack_customfunction(var_0, "stow_halligan", ::stow_halligan, "backdoor_enter");
  scripts\common\anim::addnotetrack_customfunction(var_0, "halligan_basement_door_sfx", ::sfx_townhouse_door_audio_basement_enter, "backdoor_enter");
  level.scr_anim[var_1][var_5] = % thd_ba_020_halligan_enter_ally01;
  level.scr_anim[var_4][var_5] = % thd_ba_020_halligan_enter_ally04;
  level.scr_face[var_0]["dx_vom_pri_attic_breach_04"] = % dx_vom_pri_attic_breach_04_face;
  var_5 = "backdoor_enter_idle";
  level.scr_anim[var_4][var_5][0] = % thd_ba_020_halligan_enter_idle_ally04;
  var_5 = "backdoor_nag";
  level.scr_anim[var_4][var_5] = % thd_ba_020_halligan_enter_nag_ally04;
  level.scr_face[var_0]["dx_vom_pri_backyard_alleyway_20"] = % dx_vom_pri_backyard_alleyway_20_face;
  var_6 = "bravo3_1";
  var_7 = "bravo3_2";
  var_8 = "bravo3_3";
  var_5 = "side_alley_move";
  level.scr_anim[var_6][var_5] = % thd_ba_010_sas_intro_sas1_arrival;
  level.scr_goaltime[var_6][var_5] = 0.2;
  level.scr_anim[var_7][var_5] = % thd_ba_010_sas_intro_sas2_arrival;
  level.scr_goaltime[var_7][var_5] = 0.2;
  level.scr_anim[var_8][var_5] = % thd_ba_010_sas_intro_sas3_arrival;
  level.scr_goaltime[var_8][var_5] = 0.2;
  var_5 = "side_alley_move_loop";
  level.scr_anim[var_6][var_5][0] = % thd_ba_010_sas_intro_sas1_idle;
  level.scr_anim[var_7][var_5][0] = % thd_ba_010_sas_intro_sas2_idle;
  level.scr_anim[var_8][var_5][0] = % thd_ba_010_sas_intro_sas3_idle;
}

grab_halligan(var_0) {
  var_1 = scripts\engine\sp\utility::getmodel("halligan");

  if(var_0.halliganstowed) {
    var_0.halliganstowed = 0;
    var_0 detach(var_1, var_0.halligan_tag);
  }

  var_0 attach(var_1, "tag_accessory_left");
  var_0.halliganinhand = 1;
}

stow_halligan(var_0) {
  var_1 = scripts\engine\sp\utility::getmodel("halligan");

  if(!var_0.halliganstowed) {
    var_0.halliganstowed = 1;
    var_0 attach(var_1, var_0.halligan_tag);
  }

  if(!isDefined(var_0.halliganinhand)) {
    return;
  }
  var_0 detach(var_1, "tag_accessory_left");
  var_0.halliganinhand = undefined;
}

kitchen() {
  var_0 = "price";
  level.scr_anim[var_0]["kitchen_takedown"] = % thd_1f_040_woman_grabbed_price;
  scripts\common\anim::addnotetrack_customfunction(var_0, "set_nvg_bool", ::set_nvg_bool, "kitchen_takedown");
  scripts\common\anim::addnotetrack_flag(var_0, "can_fastforward", "kitchen_takedown_fastforward", "kitchen_takedown");
  level.scr_anim[var_0]["kitchen_takedown_idle"][0] = % thd_1f_040_woman_idle_price;
  var_1 = "hallway_girl";
  var_2 = "bravo3";
  level.scr_anim[var_1]["kitchen_takedown"] = % thd_1f_040_woman_grabbed_woman01;
  scripts\common\anim::addnotetrack_customfunction(var_1, "use_deathanim_hold", ::kitchen_use_deathanim_hold, "kitchen_takedown");
  scripts\common\anim::addnotetrack_customfunction(var_1, "use_deathanim_tie", ::kitchen_use_deathanim_tie, "kitchen_takedown");
  scripts\common\anim::addnotetrack_customfunction(var_1, "use_deathanim_laying", ::kitchen_use_deathanim_laying, "kitchen_takedown");
  scripts\common\anim::addnotetrack_customfunction(var_1, "use_deathanim", ::kitchen_use_deathanim, "kitchen_takedown");
  scripts\common\anim::addnotetrack_customfunction(var_1, "no_allowdeath", ::no_allowdeath, "kitchen_takedown");
  scripts\common\anim::addnotetrack_customfunction(var_1, "open_door", ::kitchen_open_door, "kitchen_takedown");
  scripts\common\anim::addnotetrack_customfunction(var_1, "kitchen_girl_pre_open_door_sfx", ::sfx_townhouse_door_audio_kitchen_girl_pre, "kitchen_takedown");
  scripts\common\anim::addnotetrack_customfunction(var_1, "kitchen_girl_open_door_sfx", ::sfx_townhouse_door_audio_kitchen_girl, "kitchen_takedown");
  scripts\common\anim::addnotetrack_customfunction(var_1, "switch_to_allies", ::set_as_innocent, "kitchen_takedown");
  level.scr_anim[var_1]["kitchen_takedown_loop"][0] = % thd_1f_040_woman_idle_woman01;
  level.scr_anim[var_2]["kitchen_takedown"] = % thd_1f_040_woman_grabbed_soldier01;
  scripts\common\anim::addnotetrack_customfunction(var_2, "use_deathanim_laying", ::kitchen_use_deathanim_laying_bravo, "kitchen_takedown");
  scripts\common\anim::addnotetrack_customfunction(var_2, "no_react", ::kitchen_no_react, "kitchen_takedown");
  level.scr_anim[var_2]["kitchen_takedown_idle"][0] = % thd_1f_040_woman_idle_soldier01;
  level.scr_anim[var_1]["kitchen_takedown_death_stand"] = % thd_1f_040_woman_death_standing_woman01;
  level.scr_anim[var_2]["kitchen_takedown_death_stand"] = % thd_1f_040_woman_death_standing_soldier01;
  level.scr_anim[var_2]["kitchen_takedown_death_stand_idle"][0] = % thd_1f_040_woman_death_standing_idle_soldier01;
  level.scr_anim[var_1]["kitchen_takedown_death_hold"] = % thd_1f_040_woman_death_hold_woman01;
  level.scr_anim[var_2]["kitchen_takedown_death_hold"] = % thd_1f_040_woman_death_hold_soldier01;
  level.scr_anim[var_2]["kitchen_takedown_death_hold_idle"][0] = % thd_1f_040_woman_death_hold_idle_soldier01;
  level.scr_anim[var_1]["kitchen_takedown_death_tie"] = % thd_1f_040_woman_death_ground_woman01;
  level.scr_anim[var_2]["kitchen_takedown_death_tie"] = % thd_1f_040_woman_death_ground_soldier01;
  level.scr_anim[var_2]["kitchen_takedown_death_tie_idle"][0] = % thd_1f_040_woman_death_ground_idle_soldier01;
  level.scr_anim[var_1]["kitchen_takedown_death_laying"] = % thd_1f_040_woman_death_woman01;
  level.scr_anim[var_2]["kitchen_takedown_death_laying"] = % thd_1f_040_woman_death_soldier01;
  level.scr_face[var_0]["dx_vom_pri_kitchen_window_30"] = % dx_vom_pri_kitchen_window_30_face;
  level.scr_face[var_0]["dx_vom_pri_kitchen_window_40"] = % dx_vom_pri_kitchen_window_40_face;
  level.scr_face[var_0]["dx_vom_pri_kitchen_window_50"] = % dx_vom_pri_kitchen_window_50_face;
}

kitchen_open_door(var_0) {
  var_1 = scripts\sp\door::get_interactive_door("kitchen_girl_door");
  var_1 setscriptablepartstate("main", "open_handle");
  var_1.fndamage = undefined;
}

kitchen_use_deathanim_hold(var_0) {
  var_0.deathanim = undefined;
  var_0.kitchen_death_anime = "kitchen_takedown_death_hold";
  var_0.ally.kitchen_react = "kitchen_takedown_death_hold";

  if(var_0.health == 1) {
    var_0.allowdeath = 1;
    var_0 kill();
  }
}

kitchen_use_deathanim_tie(var_0) {
  var_0.deathanim = undefined;
  var_0.kitchen_death_anime = "kitchen_takedown_death_tie";
  var_0.ally.kitchen_react = "kitchen_takedown_death_tie";
  var_0.allowdeath = 1;

  if(var_0.health == 1)
    var_0 kill();
}

kitchen_use_deathanim_laying(var_0) {
  var_0.skipdeathanim = undefined;
  var_0.noragdoll = 1;
  var_0 scripts\engine\sp\utility::set_deathanim("kitchen_takedown_death_laying");
}

kitchen_no_react(var_0) {
  var_0.no_react = 1;
}

kitchen_use_deathanim_laying_bravo(var_0) {
  var_1 = scripts\engine\sp\utility::get_living_ai("hallway_girl", "animname");

  if(!isalive(var_1)) {
    var_2 = scripts\engine\utility::getStruct("kitchen_animnode", "targetname");
    var_2 scripts\common\anim::anim_single_solo(var_0, "kitchen_takedown_death_laying");
    return;
  }

  var_0.no_react = undefined;
  var_0.kitchen_react = "kitchen_takedown_death_laying";
}

kitchen_use_deathanim(var_0) {
  var_0.noragdoll = 1;
  var_0.deathanim = var_0 scripts\engine\utility::getanim("kitchen_takedown_death_laying");
}

dining_room() {
  var_0 = "dining_enemy1";
  var_1 = "dining_enemy2";
  var_2 = "dining_enemy3";
  level.scr_anim[var_0]["dining_intro"] = % thd_1f_050_dining_room_aq1_idle;
  level.scr_anim[var_0]["dining_loop"][0] = % thd_1f_050_dining_room_aq1_idle;
  level.scr_anim[var_0]["dining_loop_once"] = % thd_1f_050_dining_room_aq1_idle;
  var_3 = "dining_react";
  level.scr_anim[var_0][var_3] = % thd_1f_050_dining_room_aq1_react;
  scripts\common\anim::addnotetrack_customfunction(var_0, "grab_gun", ::pickup_gun, var_3);
  scripts\common\anim::addnotetrack_customfunction(var_0, "remove_deathanim", ::remove_dining_deathanim, var_3);
  scripts\common\anim::addnotetrack_customfunction(var_0, "use_late_long_death", ::use_late_long_death, var_3);
  var_3 = "dining_react_high";
  level.scr_anim[var_0][var_3] = % thd_1f_050_dining_room_aq1_react_high;
  scripts\common\anim::addnotetrack_customfunction(var_0, "grab_gun", ::pickup_gun, var_3);
  scripts\common\anim::addnotetrack_customfunction(var_0, "remove_deathanim", ::remove_dining_deathanim, var_3);
  scripts\common\anim::addnotetrack_customfunction(var_0, "use_late_long_death", ::use_late_long_death, var_3);
  var_3 = "dining_react_pain";
  level.scr_anim[var_0][var_3] = % thd_1f_050_dining_room_aq1_react_pain;
  scripts\common\anim::addnotetrack_customfunction(var_0, "grab_gun", ::pickup_gun, var_3);
  scripts\common\anim::addnotetrack_customfunction(var_0, "remove_deathanim", ::remove_dining_deathanim, var_3);
  scripts\common\anim::addnotetrack_customfunction(var_0, "use_late_long_death", ::use_late_long_death, var_3);
  scripts\common\anim::addnotetrack_customfunction(var_0, "stop_late_long_death", ::stop_late_long_death, var_3);
  var_3 = "dining_death";
  level.scr_anim[var_0][var_3] = % thd_1f_050_dining_room_aq1_death;
  scripts\common\anim::addnotetrack_customfunction(var_0, "allowdeath", ::enable_allowdeath, var_3);
  scripts\common\anim::addnotetrack_customfunction(var_0, "kill_me", ::kill_me_ragdoll_nosound, var_3);
  var_3 = "dining_long_death";
  level.scr_anim[var_0][var_3] = % thd_1f_050_dining_room_aq1_death_long;
  scripts\common\anim::addnotetrack_customfunction(var_0, "chest_fx", ::dining_room_chest_fx, var_3);
  scripts\common\anim::addnotetrack_customfunction(var_0, "allowdeath", ::enable_allowdeath, var_3);
  level.scr_anim[var_0]["dining_long_death_end"] = % thd_1f_050_dining_room_aq1_death_long_end;
  var_3 = "dining_long_death_expire";
  level.scr_anim[var_0][var_3] = % thd_1f_050_dining_room_aq1_death_long_end_02;
  scripts\common\anim::addnotetrack_customfunction(var_0, "kill_me", ::kill_me_ragdoll_nosound, var_3);
  var_3 = "dining_late_long_death";
  level.scr_anim[var_0][var_3] = % thd_1f_050_dining_room_aq1_long_death;
  scripts\common\anim::addnotetrack_customfunction(var_0, "kill_me", ::kill_me_ragdoll_nosound, var_3);
  level.scr_anim[var_1]["dining_intro"] = % thd_1f_050_dining_room_aq2_intro;
  level.scr_anim[var_1]["dining_loop"][0] = % thd_1f_050_dining_room_aq2_idle;
  var_3 = "dining_react";
  level.scr_anim[var_1][var_3] = % thd_1f_050_dining_room_aq2_react;
  scripts\common\anim::addnotetrack_customfunction(var_1, "grab_gun", ::pickup_gun, var_3);
  scripts\common\anim::addnotetrack_customfunction(var_1, "remove_deathanim", ::remove_dining_deathanim, var_3);
  scripts\common\anim::addnotetrack_customfunction(var_1, "use_late_long_death", ::use_late_long_death, var_3);
  var_3 = "dining_react_high";
  level.scr_anim[var_1][var_3] = % thd_1f_050_dining_room_aq2_react_high;
  scripts\common\anim::addnotetrack_customfunction(var_1, "grab_gun", ::pickup_gun, var_3);
  scripts\common\anim::addnotetrack_customfunction(var_1, "remove_deathanim", ::remove_dining_deathanim, var_3);
  scripts\common\anim::addnotetrack_customfunction(var_1, "use_late_long_death", ::use_late_long_death, var_3);
  var_3 = "dining_react_pain";
  level.scr_anim[var_1][var_3] = % thd_1f_050_dining_room_aq2_react_pain;
  scripts\common\anim::addnotetrack_customfunction(var_1, "grab_gun", ::pickup_gun, var_3);
  scripts\common\anim::addnotetrack_customfunction(var_1, "use_late_long_death", ::use_late_long_death, var_3);
  scripts\common\anim::addnotetrack_customfunction(var_1, "stop_late_long_death", ::stop_late_long_death, var_3);
  var_3 = "dining_death";
  level.scr_anim[var_1][var_3] = % thd_1f_050_dining_room_aq2_death;
  scripts\common\anim::addnotetrack_customfunction(var_1, "allowdeath", ::enable_allowdeath, var_3);
  scripts\common\anim::addnotetrack_customfunction(var_1, "kill_me", ::kill_me_ragdoll_nosound, var_3);
  var_3 = "dining_long_death";
  level.scr_anim[var_1][var_3] = % thd_1f_050_dining_room_aq2_death_long;
  scripts\common\anim::addnotetrack_customfunction(var_1, "allowdeath", ::enable_allowdeath, var_3);
  scripts\common\anim::addnotetrack_customfunction(var_1, "kill_me", ::kill_me_ragdoll_nosound, var_3);
  scripts\common\anim::addnotetrack_customfunction(var_1, "can_use_long_death_end", ::use_death_long_end, var_3);
  level.scr_anim[var_1]["dining_long_death_end"] = % thd_1f_050_dining_room_aq2_death_long_end;
  var_3 = "dining_late_long_death";
  level.scr_anim[var_1][var_3] = % thd_1f_050_dining_room_aq2_long_death;
  scripts\common\anim::addnotetrack_customfunction(var_1, "kill_me", ::kill_me_ragdoll_nosound, var_3);
  scripts\common\anim::addnotetrack_customfunction(var_1, "can_use_long_death_end", ::use_death_long_end2, var_3);
  level.scr_anim[var_1]["dining_late_long_death_end2"] = % thd_1f_050_dining_room_aq2_death_long_end_02;
  level.scr_anim[var_2]["dining_intro"] = % thd_1f_050_dining_room_aq3_intro;
  level.scr_anim[var_2]["dining_loop"][0] = % thd_1f_050_dining_room_aq3_idle;
  var_3 = "dining_react";
  level.scr_anim[var_2][var_3] = % thd_1f_050_dining_room_aq3_react;
  scripts\common\anim::addnotetrack_customfunction(var_2, "grab_gun", ::pickup_gun, var_3);
  scripts\common\anim::addnotetrack_customfunction(var_2, "remove_deathanim_ragonly", ::remove_dining_deathanim_ragonly, var_3);
  scripts\common\anim::addnotetrack_customfunction(var_2, "use_late_long_death", ::use_late_long_death, var_3);
  var_3 = "dining_react_high";
  level.scr_anim[var_2][var_3] = % thd_1f_050_dining_room_aq3_react_high;
  scripts\common\anim::addnotetrack_customfunction(var_2, "grab_gun", ::pickup_gun, var_3);
  scripts\common\anim::addnotetrack_customfunction(var_2, "remove_deathanim", ::remove_dining_deathanim, var_3);
  scripts\common\anim::addnotetrack_customfunction(var_2, "use_late_long_death", ::use_late_long_death, var_3);
  var_3 = "dining_react_grenade";
  level.scr_anim[var_2][var_3] = % thd_1f_050_dining_room_aq3_react_grenade;
  scripts\common\anim::addnotetrack_customfunction(var_2, "attach_sidearm", ::attach_sidearm, var_3);
  var_3 = "dining_react_flash";
  level.scr_anim[var_2][var_3] = % thd_1f_050_dining_room_aq3_react_flash;
  scripts\common\anim::addnotetrack_customfunction(var_2, "attach_sidearm", ::attach_sidearm, var_3);
  var_3 = "dining_death";
  level.scr_anim[var_2][var_3] = % thd_1f_050_dining_room_aq3_death;
  scripts\common\anim::addnotetrack_customfunction(var_2, "kill_me", ::kill_me_ragdoll_nosound, var_3);
  scripts\common\anim::addnotetrack_customfunction(var_2, "remove_deathanim", ::remove_dining_deathanim, var_3);
  var_3 = "dining_react_pain";
  level.scr_anim[var_2][var_3] = % thd_1f_050_dining_room_aq3_react_pain;
  scripts\common\anim::addnotetrack_customfunction(var_2, "grab_gun", ::pickup_gun, var_3);
  var_3 = "dining_late_long_death";
  level.scr_anim[var_2][var_3] = % thd_1f_050_dining_room_aq3_long_death;
  scripts\common\anim::addnotetrack_customfunction(var_2, "kill_me", ::kill_me_ragdoll_nosound, var_3);
  var_3 = "demo_death";
  level.scr_anim[var_2][var_3] = % sdr_com_exp_stand_death01_head_med_2;
  level.scr_face[var_1]["dx_vom_aq1_dining_room_aq_convo2_20"] = % dx_vom_aq1_dining_room_aq_convo2_20_face;
  level.scr_face[var_1]["dx_vom_aq1_dining_room_aq_convo2_50"] = % dx_vom_aq1_dining_room_aq_convo2_50_face;
  level.scr_face[var_1]["dx_vom_aq1_dining_room_aq_convo2_100"] = % dx_vom_aq1_dining_room_aq_convo2_100_face;
  level.scr_face[var_1]["dx_vom_aq1_dining_room_aq_convo2_110"] = % dx_vom_aq1_dining_room_aq_convo2_110_face;
  level.scr_face[var_1]["dx_vom_aq1_dining_room_aq_convo2_120"] = % dx_vom_aq1_dining_room_aq_convo2_120_face;
  level.scr_face[var_1]["dx_vom_aq1_dining_room_aq_convo2_130"] = % dx_vom_aq1_dining_room_aq_convo2_130_face;
  level.scr_face[var_1]["dx_vom_aq1_dining_room_aq_convo2_150"] = % dx_vom_aq1_dining_room_aq_convo2_150_face;
  level.scr_face[var_1]["dx_vom_aq1_dining_room_aq_convo2_160"] = % dx_vom_aq1_dining_room_aq_convo2_160_face;
  level.scr_face[var_1]["dx_vom_aq1_dining_room_aq_convo2_170"] = % dx_vom_aq1_dining_room_aq_convo2_170_face;
  level.scr_face[var_1]["dx_vom_aq1_dining_room_aq_convo2_180"] = % dx_vom_aq1_dining_room_aq_convo2_180_face;
  level.scr_face[var_0]["dx_vom_aq3_dining_room_aq_convo2_10"] = % dx_vom_aq3_dining_room_aq_convo2_10_face;
  level.scr_face[var_0]["dx_vom_aq3_dining_room_aq_convo2_30"] = % dx_vom_aq3_dining_room_aq_convo2_30_face;
  level.scr_face[var_0]["dx_vom_aq3_dining_room_aq_convo2_60"] = % dx_vom_aq3_dining_room_aq_convo2_60_face;
  level.scr_face[var_0]["dx_vom_aq3_dining_room_aq_convo2_80"] = % dx_vom_aq3_dining_room_aq_convo2_80_face;
  level.scr_face["price"]["dx_vom_pri_dining_room_entry_20"] = % dx_vom_pri_dining_room_entry_20_face;
  level.scr_face["price"]["dx_vom_pri_dining_room_entry_30"] = % dx_vom_pri_dining_room_entry_30_face;
  level.scr_face["price"]["dx_vom_pri_dining_room_entry_40"] = % dx_vom_pri_dining_room_entry_40_face;
  level.scr_face["price"]["dx_vom_pri_dining_room_entry_50"] = % dx_vom_pri_dining_room_entry_50_face;
  level.scr_face["price"]["dx_vom_pri_dining_room_entry_60"] = % dx_vom_pri_dining_room_entry_60_face;
  level.scr_face["price"]["dx_vom_pri_dining_room_entry_70"] = % dx_vom_pri_dining_room_entry_70_face;
  var_3 = "frontdoor_start";
  level.scr_anim["bravo4_1"][var_3] = % thd_1f_050_door_start_soldier02;
  level.scr_anim["bravo4_2"][var_3] = % thd_1f_050_door_start_soldier03;
  level.scr_anim["bravo4_3"][var_3] = % thd_1f_050_door_start_soldier04;
  var_3 = "frontdoor_start_loop";
  level.scr_anim["bravo4_1"][var_3][0] = % thd_1f_050_door_start_idle_soldier02;
  level.scr_anim["bravo4_2"][var_3][0] = % thd_1f_050_door_start_idle_soldier03;
  level.scr_anim["bravo4_3"][var_3][0] = % thd_1f_050_door_start_idle_soldier04;
  var_3 = "frontdoor_enter";
  level.scr_anim["bravo4_1"][var_3] = % thd_1f_050_door_enter_soldier02;
  scripts\common\anim::addnotetrack_customfunction("bravo4_1", "set_nvg_bool", ::set_nvg_bool, var_3);
  scripts\common\anim::addnotetrack_customfunction("bravo4_1", "front_door_open_sfx", ::sfx_townhouse_door_audio_front_open, var_3);
  level.scr_anim["bravo4_2"][var_3] = % thd_1f_050_door_enter_soldier03;
  scripts\common\anim::addnotetrack_customfunction("bravo4_2", "set_nvg_bool", ::set_nvg_bool, var_3);
  level.scr_anim["bravo4_3"][var_3] = % thd_1f_050_door_enter_soldier04;
  var_3 = "frontdoor_enter_loop";
  level.scr_anim["bravo4_1"][var_3][0] = % thd_1f_060_stairs_start_idle_soldier02;
  level.scr_anim["bravo4_2"][var_3][0] = % thd_1f_060_stairs_start_idle_soldier03;
  level.scr_anim["bravo4_3"][var_3][0] = % thd_1f_060_stairs_start_idle_soldier04;
  level.scr_anim["bravo4_3"]["frontdoor_enter_nag"] = % thd_1f_060_stairs_nag_soldier03;
}

dining_room_chest_fx(var_0) {
  var_1 = scripts\engine\utility::getfx("blood_spurt");
  var_2 = "j_spine4";
  var_3 = var_0 gettagorigin(var_2);
  var_4 = vectortoangles(level.player getEye() - var_3);
  var_5 = var_0 gettagangles(var_2);
  var_6 = anglesToForward(var_5);
  var_7 = anglestoup(var_5);
  var_8 = anglestoright(var_5);
  var_9 = var_3;
  var_9 = var_9 + var_6 * 0;
  var_9 = var_9 + var_7 * -4;
  var_9 = var_9 + var_8 * 3;
  var_10 = scripts\engine\utility::spawn_tag_origin(var_9, var_4);
  var_10 linkTo(var_0, var_2);
  playFXOnTag(var_1, var_10, "tag_origin");
  var_11 = gettime() + 5000;

  while(isalive(var_0)) {
    if(gettime() > var_11) {
      var_11 = gettime() + 5000;
      playFXOnTag(var_1, var_10, "tag_origin");
    }

    waitframe();
  }

  var_10 delete();
}

set_nvg_bool(var_0) {
  var_0.visor_down = 1;
}

use_death_long_end(var_0) {
  var_0.allowdeath = 1;
  var_0.skipdeathanim = undefined;
  var_0 scripts\engine\sp\utility::set_deathanim("dining_long_death_end");
}

use_death_long_end2(var_0) {
  var_0.allowdeath = 1;
  var_0.skipdeathanim = undefined;
  var_0 scripts\engine\sp\utility::set_deathanim("dining_late_long_death_end2");
}

use_late_long_death(var_0) {
  var_0 thread scripts\sp\maps\townhoused\townhoused_inner.gsc::dining_room_late_long_death();
}

stop_late_long_death(var_0) {
  var_0 notify("stop_dining_room_late_long_death");
}

attach_sidearm(var_0) {
  var_0 scripts\anim\shared.gsc::forceuseweapon(var_0.sidearm, "sidearm");
}

pickup_gun(var_0) {
  var_0 scripts\sp\anim_notetrack::gun_pickup_right();
}

remove_dining_deathanim(var_0) {
  var_0.allowdeath = 1;
  var_0 scripts\engine\sp\utility::clear_deathanim();
  var_0 notify("stop_death_react_thread");
}

remove_dining_deathanim_ragonly(var_0) {
  var_0 notify("stop_death_react_thread");
  var_0 scripts\engine\sp\utility::clear_deathanim();
  allowdeath_just_ragdoll(var_0);
}

stairtrain1() {
  var_0 = "price";
  var_1 = "bravo4_1";
  var_2 = "bravo4_2";
  var_3 = "price";
  level.scr_anim[var_3]["stairtrain1_arrive"] = % thd_1f_060_stairs_arrival_soldier01;
  scripts\common\anim::addnotetrack_customfunction(var_3, "try_attack_vo", ::stairtrain1_try_vo, "stairtrain1_arrive");
  level.scr_anim[var_3]["stairtrain1_arrive_loop"][0] = % thd_1f_060_stairs_arrival_idle_soldier01;
  level.scr_anim[var_3]["stairtrain1_start"] = % thd_1f_060_stairs_start_soldier01;
  level.scr_anim[var_3]["stairtrain1_start_idle"][0] = % thd_1f_060_stairs_start_idle_soldier01;
  var_4 = "stairtrain1_ascend";
  level.scr_anim[var_0][var_4] = % thd_1f_060_stairs_soldier01;
  level.scr_anim[var_1][var_4] = % thd_1f_060_stairs_soldier02;
  level.scr_anim[var_2][var_4] = % thd_1f_060_stairs_soldier03;
  scripts\common\anim::addnotetrack_flag(var_2, "delete_clip", "stairtrain1_remove_clip", var_4);
  var_4 = "stairtrain1_ascend_additive_branch";
  level.scr_anim[var_0][var_4] = % townhouse_stair_additives;
  level.scr_anim[var_1][var_4] = % townhouse_stair_additives;
  level.scr_anim[var_2][var_4] = % townhouse_stair_additives;
  var_4 = "stairtrain1_ascend_additive";
  level.scr_anim[var_0][var_4] = % thd_stair_train_idle_forward;
  level.scr_anim[var_1][var_4] = % thd_stair_train_idle_forward;
  level.scr_anim[var_2][var_4] = % thd_stair_train_idle_forward;
  var_4 = "stairtrain1_ascend_settle";
  level.scr_anim[var_0][var_4] = % thd_stair_train_settle_02_forward;
  level.scr_anim[var_1][var_4] = % thd_stair_train_settle_02_forward;
  level.scr_anim[var_2][var_4] = % thd_stair_train_settle_02_forward;
  var_4 = "stairtrain1_ascend_nag";
  level.scr_anim[var_2][var_4] = % thd_stair_train_nag_side_a;
  level.scr_anim["bravo4_4"]["stairtrain1_ascend"] = % thc_ff_060_stairs_soldier02;
  var_5 = "boy";
  level.scr_anim[var_5]["boy_bathroom"] = % thd_2f_010_clear_rooms_arrival_boy_1;
  scripts\common\anim::addnotetrack_flag(var_5, "near_bathroom", "boy_near_bathroom", "boy_bathroom");
  level.scr_anim[var_5]["boy_bathroom_loop"][0] = % thd_2f_010_clear_rooms_idle_boy_1;
  level.scr_anim[var_2]["secure_boy"] = % thd_2f_010_clear_rooms_enter_secure_soldier_3;
  level.scr_anim[var_2]["secure_boy_loop"][0] = % thd_2f_010_clear_rooms_enter_secure_idle_soldier_3;
  level.scr_anim[var_5]["secure_boy"] = % thd_2f_010_clear_rooms_enter_secure_boy_1;
  level.scr_anim[var_5]["secure_boy_loop"][0] = % thd_2f_010_clear_rooms_enter_secure_idle_boy_1;
  level.scr_face[var_3]["dx_vom_pri_stairtrain1_rally_40"] = % dx_vom_pri_stairtrain1_rally_40_face;
  level.scr_face[var_3]["dx_vom_pri_stairtrain1_rally_50"] = % dx_vom_pri_stairtrain1_rally_50_face;
  level.scr_face[var_3]["dx_vom_pri_stairtrain1_rally_60"] = % dx_vom_pri_stairtrain1_rally_60_face;
  level.scr_face[var_3]["dx_vom_pri_stairtrain1_rally_70"] = % dx_vom_pri_stairtrain1_rally_70_face;
  level.scr_face[var_3]["dx_vom_pri_stairtrain1_rally_80"] = % dx_vom_pri_stairtrain1_rally_80_face;
  level.scr_face[var_3]["dx_vom_pri_stairtrain1_rally_90"] = % dx_vom_pri_stairtrain1_rally_90_face;
}

stairtrain_twitch_get() {
  var_0 = [];
  var_0[var_0.size] = % thd_stair_train_twitch_01;
  var_0[var_0.size] = % thd_stair_train_twitch_02;
  var_0[var_0.size] = % thd_stair_train_twitch_03;
  var_0[var_0.size] = % thd_stair_train_twitch_04;
  var_0[var_0.size] = % thd_stair_train_twitch_05;
  var_0[var_0.size] = % thd_stair_train_twitch_06;
  var_0[var_0.size] = % thd_stair_train_twitch_07;
  var_0[var_0.size] = % thd_stair_train_twitch_08;
  var_0[var_0.size] = % thd_stair_train_twitch_09;
  return var_0[randomint(var_0.size)];
}

stairtrain1_try_vo(var_0) {
  if(!scripts\engine\utility::flag("dining_room_react"))
    scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_pri_dining_room_entry_10");

  scripts\engine\utility::flag_set("dining_room_player_should_engage");
}

stairtrain2() {
  var_0 = "price";
  var_1 = "bravo4_1";
  var_2 = "bravo4_2";
  var_3 = "price";
  level.scr_anim[var_3]["stairtrain2_pre_arrive"] = % thd_2f_040_stairs_arrival_a_soldier01;
  level.scr_anim[var_3]["stairtrain2_pre_arrive_loop"][0] = % thd_2f_040_stairs_arrival_a_idle_soldier01;
  level.scr_anim[var_3]["stairtrain2_arrive"] = % thd_2f_040_stairs_arrival_b_soldier01;
  level.scr_anim[var_3]["stairtrain2_arrive_loop"][0] = % thd_2f_040_stairs_idle_soldier01;
  level.scr_anim[var_1]["stairtrain2_arrive"] = % thd_2f_040_stairs_arrival_b_soldier02;
  level.scr_anim[var_1]["stairtrain2_arrive_loop"][0] = % thd_2f_040_stairs_idle_soldier02;
  level.scr_anim[var_2]["stairtrain2_arrive"] = % thd_2f_040_stairs_arrival_b_soldier03;
  scripts\common\anim::addnotetrack_customfunction(var_2, "remove_playerclip", ::stairtrain2_remove_clip, "stairtrain2_arrive");
  level.scr_anim[var_2]["stairtrain2_arrive_loop"][0] = % thd_2f_040_stairs_idle_soldier03;
  var_4 = "stairtrain2_ascend";
  level.scr_anim[var_0][var_4] = % thd_2f_040_stairs_climb_soldier01;
  level.scr_anim[var_1][var_4] = % thd_2f_040_stairs_climb_soldier02;
  level.scr_anim[var_2][var_4] = % thd_2f_040_stairs_climb_soldier03;
  var_4 = "stairtrain2_ascend_additive_branch";
  level.scr_anim[var_0][var_4] = % townhouse_stair_additives;
  level.scr_anim[var_1][var_4] = % townhouse_stair_additives;
  level.scr_anim[var_2][var_4] = % townhouse_stair_additives;
  var_4 = "stairtrain2_ascend_additive";
  level.scr_anim[var_0][var_4] = % thd_stair_train_idle_forward;
  level.scr_anim[var_1][var_4] = % thd_stair_train_idle_forward;
  level.scr_anim[var_2][var_4] = % thd_stair_train_idle_forward;
  var_4 = "stairtrain2_ascend_settle";
  level.scr_anim[var_0][var_4] = % thd_stair_train_settle_02_forward;
  level.scr_anim[var_1][var_4] = % thd_stair_train_settle_02_forward;
  level.scr_anim[var_2][var_4] = % thd_stair_train_settle_02_forward;
  level.scr_face[var_0]["dx_vom_pri_stairtrain2_rally_10"] = % dx_vom_pri_stairtrain2_rally_10_face;
  level.scr_face[var_0]["dx_vom_pri_stairtrain2_rally_20"] = % dx_vom_pri_stairtrain2_rally_20_face;
  level.scr_face[var_0]["dx_vom_pri_stairtrain2_rally_30"] = % dx_vom_pri_stairtrain2_rally_30_face;
  level.scr_face[var_0]["dx_vom_pri_stairtrain2_rally_40"] = % dx_vom_pri_stairtrain2_rally_40_face;
  level.scr_face[var_0]["dx_vom_pri_stairtrain2_rally_50"] = % dx_vom_pri_stairtrain2_rally_50_face;
}

stairtrain2_remove_clip(var_0) {
  var_1 = getEnt("2nd_floor_door_playerclip", "targetname");
  var_1 delete();
}

stairtrain3() {
  var_0 = "price";
  var_1 = "bravo4_4";
  var_2 = "stairtrain3_ascend";
  level.scr_anim[var_0][var_2] = % thd_3f_030_stairs_climb_price;
  level.scr_anim[var_1][var_2] = % thd_3f_030_stairs_climb_sas03;
  var_2 = "stairtrain3_ascend_additive_branch";
  level.scr_anim[var_0][var_2] = % townhouse_stair_additives;
  level.scr_anim[var_1][var_2] = % townhouse_stair_additives;
  var_2 = "stairtrain3_ascend_additive";
  level.scr_anim[var_0][var_2] = % thd_stair_train_idle_forward;
  level.scr_anim[var_1][var_2] = % thd_stair_train_idle_forward;
  var_2 = "stairtrain3_ascend_settle";
  level.scr_anim[var_0][var_2] = % thd_stair_train_settle_02_forward;
  level.scr_anim[var_1][var_2] = % thd_stair_train_settle_02_forward;
  level.scr_face[var_0]["dx_vom_pri_stairtrain3_rally_60"] = % dx_vom_pri_stairtrain3_rally_60_face;
  level.scr_face[var_0]["dx_vom_pri_stairtrain3_rally_70"] = % dx_vom_pri_stairtrain3_rally_70_face;
  level.scr_face[var_0]["dx_vom_pri_stairtrain3_rally_80"] = % dx_vom_pri_stairtrain3_rally_80_face;
  level.scr_face[var_0]["dx_vom_pri_stairtrain3_rally_20"] = % dx_vom_pri_stairtrain3_rally_20_face;
  level.scr_face[var_0]["dx_vom_pri_stairtrain3_rally_30"] = % dx_vom_pri_stairtrain3_rally_30_face;
  level.scr_face[var_0]["dx_vom_pri_stairtrain3_rally_40"] = % dx_vom_pri_stairtrain3_rally_40_face;
}

second_floor_bedroom() {
  var_0 = "price";
  var_1 = "bravo4_1";
  var_2 = "bedroom_enemy";
  var_3 = "bravo4_2";
  level.scr_anim[var_0]["2ndfloor_arrive"] = % thd_2f_010_clear_rooms_arrival_soldier_1;
  level.scr_anim[var_0]["2ndfloor_arrive_loop"][0] = % thd_2f_010_clear_rooms_idle_soldier_1;
  level.scr_anim[var_1]["2ndfloor_bedroom_arrive"] = % thd_2f_010_clear_rooms_arrival_soldier_2;
  level.scr_anim[var_1]["2ndfloor_bedroom_arrive_loop"][0] = % thd_2f_010_clear_rooms_idle_soldier_2;
  level.scr_anim[var_1]["2ndfloor_bedroom_enter"] = % thd_2f_010_clear_rooms_enter_soldier_2;
  scripts\common\anim::addnotetrack_customfunction(var_1, "2nd_floor_bedroom_open_door_sfx", ::sfx_townhouse_door_audio_2nd_floor_bedroom, "2ndfloor_bedroom_enter");
  scripts\common\anim::addnotetrack_customfunction(var_1, "2nd_floor_bedroom_bash_door_sfx", ::sfx_townhouse_door_audio_2nd_floor_bedroom_bash, "2ndfloor_bedroom_enter");
  level.scr_anim[var_1]["2ndfloor_bedroom_enter_loop"][0] = % thd_2f_010_clear_rooms_idle_2_soldier_2;
  scripts\common\anim::addnotetrack_customfunction(var_1, "open_door2", ::second_floor_bedroom_door2, "2ndfloor_bedroom_enter");
  scripts\common\anim::addnotetrack_customfunction(var_1, "check_stop", ::second_floor_bedroom_check_stop, "2ndfloor_bedroom_enter");
  scripts\common\anim::addnotetrack_customfunction(var_1, "scripted_fire", ::second_floor_bedroom_fire, "2ndfloor_bedroom_enter");
  level.scr_anim[var_2]["2ndfloor_bedroom_enter"] = % thd_2f_010_clear_rooms_enter_enemy;
  scripts\common\anim::addnotetrack_customfunction(var_2, "skipdeathanim", ::set_skipdeathanim, "2ndfloor_bedroom_enter");
  scripts\common\anim::addnotetrack_customfunction(var_2, "scripted_fire", ::second_floor_bedroom_fire, "2ndfloor_bedroom_enter");
  scripts\common\anim::addnotetrack_customfunction(var_2, "kill_me", ::kill_me_ragdoll, "2ndfloor_bedroom_enter");
  level.scr_anim[var_3]["2ndfloor_bathroom_arrive"] = % thd_2f_010_clear_rooms_arrival_soldier_3;
  level.scr_anim[var_3]["2ndfloor_bathroom_arrive_loop"][0] = % thd_2f_010_clear_rooms_idle_soldier_3;
  level.scr_anim[var_3]["2ndfloor_bathroom_enter"] = % thd_2f_010_clear_rooms_enter_soldier_3;
  scripts\common\anim::addnotetrack_customfunction(var_3, "2nd_floor_bathroom_open_door_sfx", ::sfx_townhouse_door_audio_2nd_floor_bathroom, "2ndfloor_bathroom_enter");
  level.scr_anim[var_3]["2ndfloor_bathroom_enter_loop"][0] = % thd_2f_010_clear_rooms_idle_2_soldier_3;
}

set_skipdeathanim(var_0) {
  var_0.skipdeathanim = 1;
}

second_floor_bedroom_fire(var_0) {
  var_0 notify("stop_prev_bedroom_fire");
  var_0 endon("stop_prev_bedroom_fire");

  if(getdvarint("scr_reveal") > 0) {
    if(var_0.animname == "bedroom_enemy")
      thread second_floor_bedroom_reveal_fire(var_0);
  } else {
    if(!isDefined(var_0.scriptfirecount))
      var_0.scriptfirecount = 0;

    var_0.scriptfirecount++;

    if(var_0.scriptfirecount < 4)
      level thread second_floor_enemy_bulletshield();

    var_0 thread scripts\anim\notetracks.gsc::shootnotetrack();
  }
}

second_floor_enemy_bulletshield() {
  var_0 = scripts\engine\sp\utility::get_living_ai("bedroom_enemy", "animname");

  if(!isDefined(var_0)) {
    return;
  }
  var_0.damageshield = 1;
  waitframe();
  var_0.damageshield = 0;
}

second_floor_bedroom_reveal_fire(var_0) {
  var_1 = "tag_flash";
  var_2 = var_0 gettagorigin(var_1);
  var_3 = anglesToForward(var_0 gettagangles(var_1));
  var_4 = var_2 + var_3 * 60;
  magicbullet(var_0.weapon, var_2, var_4, var_0);
  playFXOnTag(scripts\engine\utility::getfx("sas_muzzle_flash"), var_0, var_1);
  var_5 = getEntArray("2nd_floor_muzzle_light", "targetname");

  foreach(var_7 in var_5) {
    var_0 thread second_floor_follow_tag_flash(var_7);
    var_7 setlightintensity(0.2);
    var_7 setlightcolor(var_7.flash_color * randomfloatrange(0.98, 1));
  }

  waitframe();

  foreach(var_7 in var_5)
  var_7 setlightintensity(0);
}

second_floor_follow_tag_flash(var_0) {
  if(isDefined(var_0.owner) && var_0.owner == self) {
    return;
  }
  level notify("stop_second_floor_follow_tag_flash");
  level endon("stop_second_floor_follow_tag_flash");
  var_1 = "tag_flash";
  var_2 = 4;

  for(;;) {
    var_3 = anglesToForward(self gettagangles(var_1));
    var_4 = self gettagorigin(var_1) + var_3 * var_2;
    var_5 = anglesToForward(var_0.angles);
    var_4 = var_4 + var_5 * 1;
    var_0.origin = var_4;
    waitframe();
  }
}

second_floor_bedroom_door2(var_0) {
  var_1 = scripts\engine\utility::getStruct("2ndfloor_bedroom_animnode", "targetname");
  var_2 = scripts\sp\door::get_interactive_door("2ndfloor_back_bedroom_door2");
  var_1 thread scripts\sp\maps\townhoused\townhoused_code.gsc::anim_door(var_2, "2ndfloor_bedroom_enter2");
}

second_floor_bedroom_check_stop(var_0) {
  var_1 = getEnt("back_bedroom_volume", "targetname");

  if(level.player istouching(var_1)) {
    var_2 = scripts\engine\utility::getStruct("2ndfloor_bedroom_animnode", "targetname");
    var_2 notify("stop_second_floor_loop");
    scripts\engine\sp\utility::anim_stopanimScripted();
    self setgoalpos(self.origin);
  }
}

hostage_room() {
  var_0 = "hostage_enemy";
  var_1 = "hostage";
  level.scr_anim[var_0]["hostage_loop"][0] = % thd_2f_020_hostage_alqatala_idle;
  level.scr_anim[var_1]["hostage_loop"][0] = % thd_2f_020_hostage_civ_idle;
  level.scr_anim[var_0]["hostage_aim_loop"][0] = % thd_2f_020_hostage_alqatala_aim;
  level.scr_anim[var_1]["hostage_aim_loop"][0] = % thd_2f_020_hostage_civ_aim;
  level.scr_anim[var_0]["hostage_aim_2_knob"] = % thd_hostage_aim_2;
  level.scr_anim[var_0]["hostage_aim_2"] = % thd_2f_020_hostage_alqatala_aim_2;
  level.scr_anim[var_0]["hostage_aim_4_knob"] = % thd_hostage_aim_4;
  level.scr_anim[var_0]["hostage_aim_4"] = % thd_2f_020_hostage_alqatala_aim_4;
  level.scr_anim[var_0]["hostage_aim_5"] = % thd_2f_020_hostage_alqatala_aim;
  level.scr_anim[var_0]["hostage_aim_6_knob"] = % thd_hostage_aim_6;
  level.scr_anim[var_0]["hostage_aim_6"] = % thd_2f_020_hostage_alqatala_aim_6;
  level.scr_anim[var_0]["hostage_aim_8_knob"] = % thd_hostage_aim_8;
  level.scr_anim[var_0]["hostage_aim_8"] = % thd_2f_020_hostage_alqatala_aim_8;
  level.scr_anim[var_0]["enemy_live"] = % thd_2f_020_hostage_alqatala_live;
  level.scr_anim[var_1]["enemy_live"] = % thd_2f_020_hostage_civ_death;
  scripts\common\anim::addnotetrack_customfunction(var_1, "kill_me", ::kill_me_ragdoll, "enemy_live");
  level.scr_anim[var_0]["hostage_live"] = % thd_2f_020_hostage_alqatala_death;
  scripts\common\anim::addnotetrack_customfunction(var_0, "allowdeath", ::enable_allowdeath, "hostage_live");
  scripts\common\anim::addnotetrack_customfunction(var_0, "kill_me", ::kill_me_ragdoll_nosound, "hostage_live");
  scripts\common\anim::addnotetrack_customfunction(var_0, "neck_fx", ::hostage_enemy_fx, "hostage_live");
  level.scr_anim[var_0]["hostage_headshot"] = % sdr_com_exposed_stand_death05_head_md_2;
  level.scr_anim[var_1]["hostage_live"] = % thd_2f_020_hostage_civ_live;
  scripts\common\anim::addnotetrack_attach_gun(var_1, "grab_gun", "hostage_live");
  scripts\common\anim::addnotetrack_customfunction(var_1, "grab_gun", ::hostage_turn_to_enemy, "hostage_live");
  scripts\common\anim::addnotetrack_customfunction(var_1, "use_death", ::remove_skipdeathanim, "hostage_live");
  scripts\common\anim::addnotetrack_customfunction(var_1, "allow_long_death", ::hostage_allow_long_death, "hostage_live");
  var_2 = "hostage_live_long_death";
  level.scr_anim[var_1][var_2] = % thd_2f_020_hostage_civ_death_long;
  scripts\common\anim::addnotetrack_customfunction(var_1, "allowdeath", ::enable_allowdeath, var_2);
  scripts\common\anim::addnotetrack_customfunction(var_1, "kill_me", ::kill_me_ragdoll_nosound, var_2);
  scripts\common\anim::addnotetrack_customfunction(var_1, "hit_wall", ::hostage_hit_wall, var_2);
  scripts\common\anim::addnotetrack_customfunction(var_1, "elbow_hit_wall", ::hostage_elbow_hit_wall, var_2);
  level.scr_anim[var_1]["hostage_live_headshot"] = % thd_2f_020_hostage_civ_death_headshot;
  level.scr_face[var_1]["dx_vom_aqf2_2nd_floor_aq_convo4_30"] = % dx_vom_aqf2_2nd_floor_aq_convo4_30_face;
  level.scr_face[var_1]["dx_vom_aqf2_2nd_floor_bedroom2_60"] = % dx_vom_aqf2_2nd_floor_bedroom2_60_face;
}

hostage_hit_wall(var_0) {}

hostage_elbow_hit_wall(var_0) {}

hostage_enemy_fx(var_0) {
  var_1 = var_0.damagelocation;

  if(!isDefined(var_0.damagelocation)) {
    return;
  }
  switch (var_0.damagelocation) {
    case "left_arm_upper":
    case "torso_upper":
    case "neck":
    case "helmet":
    case "head":
      break;
    default:
      return;
  }

  var_2 = scripts\engine\utility::getfx("blood_spurt");
  var_3 = "j_neck";
  var_4 = var_0 gettagorigin(var_3);
  var_5 = vectortoangles(level.player getEye() - var_4);
  var_6 = var_5 + (0, 90, 0);
  var_7 = scripts\engine\utility::spawn_tag_origin(var_4, var_5);
  var_7 linkTo(var_0, var_3);
  var_8 = anglesToForward(var_6);
  var_9 = getcompleteweaponname("iw8_ar_decalmaker");
  magicbullet(var_9, var_7.origin + var_8 * 20, var_7.origin);
  playFXOnTag(var_2, var_7, "tag_origin");
  var_10 = gettime() + 5000;

  while(isalive(var_0)) {
    if(gettime() > var_10) {
      var_10 = gettime() + 5000;
      playFXOnTag(var_2, var_7, "tag_origin");
    }

    waitframe();
  }

  var_7 delete();
}

hostage_allow_long_death(var_0) {
  var_0.allowdeath = 0;
  var_0.health = 180;
  var_0.skipdeathanim = 1;
  var_0.deathfunction = scripts\sp\maps\townhoused\townhoused_inner.gsc::hostage_death_with_gun;
  var_1 = scripts\engine\utility::getStruct("hostage_animnode", "targetname");
  var_0 thread scripts\engine\utility::thread_on_notify("longdeath", scripts\engine\sp\utility::smart_dialogue, "dx_vom_aqf2_2nd_floor_bedroom2_52");
  var_1 = scripts\engine\utility::getStruct("hostage_animnode", "targetname");
  var_1 thread scripts\sp\maps\townhoused\townhoused_code.gsc::anim_long_death_relative(var_0, "hostage_live_long_death", 10, scripts\sp\maps\townhoused\townhoused_inner.gsc::hostage_death_counter);
}

hostage_ondeath_remove_linkedents(var_0) {
  var_1 = var_0.linkedents;
  var_0 waittill("death");
  wait 0.5;
  scripts\engine\utility::array_delete(var_1);
}

hostage_turn_to_enemy(var_0) {
  var_0.team = "axis";
  var_0 thread scripts\sp\maps\townhoused\townhoused_code.gsc::golden_enemydamage();
  var_0 thread scripts\sp\maps\townhoused\townhoused_code.gsc::golden_enemydeath();
}

bathroom_enemy() {
  var_0 = "bathroom_guy";
  level.scr_anim[var_0]["bathroom_loop"][0] = % thd_2f_030_bathroom_idle;
  level.scr_anim[var_0]["bathroom_shoot"] = % thd_2f_030_bathroom_shoot;
  scripts\common\anim::addnotetrack_customfunction(var_0, "scripted_fire", ::direct_shoot, "bathroom_shoot");
  level.scr_anim[var_0]["bathroom_crouch"] = % thd_2f_030_bathroom_ai;
  scripts\common\anim::addnotetrack_customfunction(var_0, "remove_deathanim", ::bathroom_stop_deathanim, "bathroom_crouch");
  level.scr_anim[var_0]["bathroom_death"] = % thd_2f_030_bathroom_dead;
}

bathroom_stop_deathanim(var_0) {
  remove_deathanim(var_0);
  var_0.deathfunction = undefined;
}

direct_shoot(var_0) {
  var_0 shoot(1, undefined, 1, 1);
}

baby_room() {
  var_0 = "price";
  var_1 = "bravo4_4";
  var_2 = "baby_mom";
  level.scr_anim[var_1]["baby_mom_arrive"] = % thd_4f_010_setup_sas03;
  scripts\common\anim::addnotetrack_customfunction(var_1, "4th_floor_bathroom_open_door_sfx", ::sfx_townhouse_door_audio_4th_floor_bathroom, "baby_mom_arrive");
  scripts\common\anim::addnotetrack_flag(var_1, "allow_end", "fourth_floor_bravo4_4_ready", "baby_mom_arrive");
  level.scr_anim[var_1]["baby_mom_arrive_loop"][0] = % thd_4f_010_setup_idle_sas03;
  level.scr_anim[var_0]["baby_mom_arrive"] = % thd_4f_010_setup_price;
  level.scr_anim[var_0]["baby_mom_breakdown"] = % thd_4f_010_setup_breakdown_price;
  level.scr_anim[var_0]["baby_mom_breakdown_idle"] = % thd_4f_010_setup_breakdown_idle_price;
  level.scr_anim[var_0]["baby_mom_breakdown_idle_as_loop"][0] = % thd_4f_010_setup_breakdown_idle_price;
  level.scr_anim[var_0]["baby_mom_breakdown_nag"] = % thd_4f_010_setup_breakdown_nag_price;
  var_3 = "grab_baby";
  level.scr_anim[var_1][var_3] = % thd_4f_020_baby_enter_ally01;
  scripts\common\anim::addnotetrack_customfunction(var_1, "try_early_mom_death", ::bravo4_4_try_early_mom_death, var_3);
  scripts\common\anim::addnotetrack_customfunction(var_1, "open_door", ::bravo4_4_open_baby_door, var_3);
  scripts\common\anim::addnotetrack_customfunction(var_1, "use_stand_death_react", ::bravo4_4_use_stand_death_react, var_3);
  scripts\common\anim::addnotetrack_customfunction(var_1, "use_death_react", ::bravo4_4_use_death_react, var_3);
  level.scr_anim[var_2][var_3] = % thd_4f_020_baby_enter_civ01;
  scripts\common\anim::addnotetrack_customfunction(var_2, "vo_dx_vom_aqf3_4th_floor_bedroom_70", ::baby_mom_vo, var_3);
  scripts\common\anim::addnotetrack_customfunction(var_2, "switch_to_allies", ::set_as_innocent, var_3);
  scripts\common\anim::addnotetrack_customfunction(var_2, "use_move_death", ::baby_mom_use_move_death, var_3);
  scripts\common\anim::addnotetrack_customfunction(var_2, "remove_deathanim", ::baby_mom_remove_death, var_3);
  scripts\common\anim::addnotetrack_customfunction(var_2, "use_stand_death", ::baby_mom_stand_death, var_3);
  scripts\common\anim::addnotetrack_customfunction(var_2, "use_normal_death", ::baby_mom_normal_death, var_3);
  level.scr_anim[var_1]["grab_baby_loop"][0] = % thd_4f_020_baby_enter_idle_ally01;
  level.scr_anim[var_1]["grab_baby_death"] = % thd_4f_020_baby_death_ally01;
  level.scr_anim[var_1]["grab_baby_death_interrupt"] = % thd_4f_020_baby_interrupt_ally01;
  level.scr_anim[var_1]["grab_baby_death_idle"][0] = % thd_4f_020_baby_death_idle_ally01;
  level.scr_anim[var_1]["grab_baby_stand_death"] = % thd_4f_020_baby_stand_death_ally01;
  level.scr_anim[var_1]["grab_baby_stand_death_idle"][0] = % thd_4f_020_baby_stand_death_idle_ally01;
  level.scr_anim[var_2]["grab_baby_stand_death"] = % thd_4f_020_baby_stand_death_civ01;
  level.scr_model[var_2 + "_head"] = "head_sc_f_daly_blendshape";
  level.scr_face[var_2]["dx_vom_aqf3_4th_floor_bedroom_94"] = % dx_vom_aqf3_4th_floor_bedroom_94_face;
  level.scr_face[var_2]["dx_vom_aqf3_4th_floor_bedroom_95"] = % dx_vom_aqf3_4th_floor_bedroom_95_face;
  level.scr_face[var_2]["dx_vom_aqf3_4th_floor_bedroom_96"] = % dx_vom_aqf3_4th_floor_bedroom_96_face;
  level.scr_anim[var_2]["grab_baby_loop"][0] = % thd_4f_020_baby_enter_idle_civ01;
  level.scr_anim[var_2]["grab_baby_loop_ads_react"] = % thd_4f_020_baby_react_civ01;
  level.scr_anim[var_2]["grab_baby_death"] = % thd_4f_020_baby_death_civ01;
  scripts\common\anim::addnotetrack_customfunction(var_2, "kill_me", ::kill_me_no_anim, "grab_baby_death");
  var_3 = "grab_baby_mom_early_death";
  level.scr_anim[var_1][var_3] = % thd_4f_020_baby_enter_alt_ally01;
  level.scr_anim[var_1]["grab_baby_mom_early_death_idle"][0] = % thd_4f_020_baby_enter_alt_idle_ally01;
  level.scr_anim[var_1]["grab_baby_pickup_early"] = % thd_4f_020_baby_pickup_ally01;
  level.scr_anim[var_2]["grab_baby_pickup_early"] = % thd_4f_020_baby_pickup_civ01;
  scripts\common\anim::addnotetrack_customfunction(var_2, "kill_me", ::kill_me_no_anim, "grab_baby_pickup_early");
  level.scr_face[var_0]["dx_vom_pri_4th_floor_bedroom_110"] = % dx_vom_pri_4th_floor_bedroom_110_face;
  level.scr_face[var_0]["dx_vom_pri_4th_floor_bedroom_120"] = % dx_vom_pri_4th_floor_bedroom_120_face;
  level.scr_face[var_0]["dx_vom_pri_4th_floor_bedroom_130"] = % dx_vom_pri_4th_floor_bedroom_130_face;
  level.scr_face[var_0]["dx_vom_pri_4th_floor_bedroom_140"] = % dx_vom_pri_4th_floor_bedroom_140_face;
}

bravo4_4_open_baby_door(var_0) {
  var_1 = scripts\sp\door::get_interactive_door("baby_room_door");
  var_0 scripts\sp\maps\townhoused\townhoused_code.gsc::ai_try_open_door(var_1);
}

baby_mom_anim_random() {
  var_0 = ["grab_baby"];
  var_1 = var_0[0];

  if(var_0.size > 1) {
    var_0 = scripts\engine\utility::array_randomize(var_0);

    if(getDvar("scr_townhouse_last_babymom_anim") == var_0[0])
      var_1 = var_0[1];
  }

  setDvar("scr_townhouse_last_babymom_anim", var_1);
  return var_1;
}

baby_mom_anim_get(var_0) {
  var_1 = undefined;
  var_1 = spawnStruct();

  switch (var_0) {
    case "grab_baby":
      var_1.startanime = "grab_baby";
      var_1.idleanime = "grab_baby_loop";
      var_1.idlereactanime = "grab_baby_loop_ads_react";
      var_1.deathanime = "grab_baby_death";
      break;
  }

  return var_1;
}

baby_mom_is_ads() {
  return 0;
}

baby_mom_vo(var_0) {
  var_0 endon("death");
  var_0 endon("scripted_death");
  wait(lookupsoundlength("dx_vom_aqf3_4th_floor_bedroom_70") / 1000);
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf3_4th_floor_bedroom_75");
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf3_4th_floor_bedroom_77");
}

baby_mom_use_move_death(var_0) {
  var_0.skipdeathanim = undefined;
}

baby_mom_remove_death(var_0) {
  var_0 scripts\engine\sp\utility::clear_deathanim();
}

bravo4_4_try_early_mom_death(var_0) {
  if(scripts\sp\maps\townhoused\townhoused_code.gsc::isscriptedalive(level.baby_mom))
    var_0.momdeathreact_anime = "grab_baby_death_interrupt";
  else {
    var_1 = scripts\engine\utility::getStruct("baby_room_animnode", "targetname");
    var_0 scripts\engine\sp\utility::anim_stopanimScripted();

    if(!scripts\sp\maps\townhoused\townhoused_code.gsc::isscriptedalive(level.baby_mom) && scripts\engine\utility::flag("baby_picked_up")) {
      var_1 scripts\common\anim::anim_single_solo(var_0, "grab_baby_pickup_early");
      var_2 = spawnStruct();
      var_3 = level.scr_anim[var_0.animname]["grab_baby_mom_early_death_idle"][0];
      var_4 = getstartorigin(var_1.origin, var_1.angles, var_3);
      var_5 = getstartangles(var_1.origin, var_1.angles, var_3);
      var_6 = rotatevectorinverted(var_1.origin - var_4, var_5);
      var_7 = var_1.angles - var_5;
      var_2.origin = var_0.origin + rotatevector(var_6, var_0.angles);
      var_2.angles = var_0.angles + var_7;
      var_2 thread scripts\common\anim::anim_loop_solo(var_0, "grab_baby_mom_early_death_idle");
      return;
    }

    var_1 thread scripts\sp\maps\townhoused\townhoused_code.gsc::anim_then_loop_solo(var_0, "grab_baby_mom_early_death");
  }
}

bravo4_4_use_stand_death_react(var_0) {
  var_0.momdeathreact_anime = "grab_baby_stand_death";
}

bravo4_4_use_death_react(var_0) {
  var_0.momdeathreact_anime = "grab_baby_death";
}

baby_mom_stand_death(var_0) {
  scripts\engine\utility::flag_set("baby_picked_up");
  var_0 scripts\engine\utility::ent_flag_set("can_fastforward");
  var_0.deathanime = "grab_baby_stand_death";
}

baby_mom_normal_death(var_0) {
  var_0.deathanime = "grab_baby_death";
}

baby_pickup_by_allyanim(var_0, var_1) {
  var_0 scripts\common\anim::anim_single_solo(level.baby_mom.baby, var_1);
  thread scripts\sp\maps\townhoused\townhoused_inner.gsc::baby_idle_relative("grab_baby_pickup_early_idle");
}

baby_pickup_early_time_adjust(var_0, var_1) {
  self setanimtime(scripts\engine\utility::getanim(var_0), var_1);
}

baby_room_unlink_baby(var_0) {
  var_1 = getEnt("baby", "targetname");
  var_1 unlink();
}

set_team_axis(var_0) {
  var_0.team = "axis";
  var_0.skipdeathanim = 1;
  var_0.a.nodeath = 1;
}

set_team_allies(var_0) {
  var_0.team = "allies";
}

set_as_innocent(var_0) {
  var_0.team = "allies";
  var_0 thread innocent_damage_thread();
}

innocent_damage_thread() {
  self waittill("damage", var_0, var_1);

  if(!isPlayer(var_1)) {
    return;
  }
  level.custom_friendly_fire_message = 30;
  scripts\sp\player_death::set_custom_death_quote(30);
  scripts\sp\utility::missionfailedwrapper();
}

bed_guy() {
  var_0 = "bed_guy";
  level.scr_anim[var_0]["corner_idle"][0] = % thd_4f_030_bed_start_idle_enemy01;
  level.scr_anim[var_0]["hide_under_bed"] = % thd_4f_030_bed_start_enemy01;
  scripts\common\anim::addnotetrack_customfunction(var_0, "allowdeath", ::bed_guy_deathanim, "hide_under_bed");
  level.scr_anim[var_0]["hide_under_bed_alt"] = % thd_4f_030_bed_start_b_enemy01;
  level.scr_anim[var_0]["hide_under_bed_loop"][0] = % thd_4f_030_bed_idle_enemy01;
  level.scr_anim[var_0]["hide_under_bed_death"] = % thd_4f_030_bed_death_enemy01;
  scripts\common\anim::addnotetrack_customfunction(var_0, "hack_dropgun", ::bed_guy_dropgun, "hide_under_bed_death");
  level.scr_anim[var_0]["under_bed_aim_2_knob"] = % thd_underbed_aim_2;
  level.scr_anim[var_0]["under_bed_aim_4_knob"] = % thd_underbed_aim_4;
  level.scr_anim[var_0]["under_bed_aim_6_knob"] = % thd_underbed_aim_6;
  level.scr_anim[var_0]["under_bed_aim_8_knob"] = % thd_underbed_aim_8;
  level.scr_anim[var_0]["under_bed_aim_fire_knob"] = % thd_underbed_shoot;
  level.scr_anim[var_0]["under_bed_aim_2"] = % thd_4f_030_bed_aim_2_enemy01;
  level.scr_anim[var_0]["under_bed_aim_4"] = % thd_4f_030_bed_aim_4_enemy01;
  level.scr_anim[var_0]["under_bed_aim_5"] = % thd_4f_030_bed_idle_enemy01;
  level.scr_anim[var_0]["under_bed_aim_6"] = % thd_4f_030_bed_aim_6_enemy01;
  level.scr_anim[var_0]["under_bed_aim_8"] = % thd_4f_030_bed_aim_8_enemy01;
  level.scr_anim[var_0]["under_bed_aim_fire"] = % thd_4f_030_bed_shoot_enemy01;
  level.scr_anim[var_0]["under_bed_flash_knob"] = % thd_generic_flash_react;
  level.scr_anim[var_0]["under_bed_flash"] = % thd_soldier_additive_flash_bang;
}

bed_guy_dropgun(var_0) {
  var_0.nodrop = 0;
  var_0 waittill("death");
  var_1 = var_0.weapon;
  var_0 scripts\anim\shared.gsc::detachallweaponmodels();
  var_2 = "tag_weapon_right";
  var_3 = var_0 gettagorigin(var_2) + (0, 0, 2);
  var_4 = var_0 gettagangles(var_2);
  var_5 = spawn("weapon_" + createheadicon(var_1), var_3);
  var_5.angles = var_4;
  waitframe();
  var_6 = var_0 gettagorigin(var_2) + (0, 0, 2);
  var_7 = vectorNormalize(var_3 - var_6) * 40;
  var_5 physicslaunchserveritem(var_5.origin, var_7);
}

bed_guy_deathanim(var_0) {
  var_0.allowdeath = 1;
  var_0.deathanimmode = "noclip";
  var_0.deathfunction = ::bed_guy_blood_pool;
  level thread bed_guy_dropgun(var_0);
  var_0 scripts\engine\sp\utility::set_deathanim("hide_under_bed_death");
}

bed_guy_blood_pool() {
  self.disabledeathorient = 1;
  self.skipbloodpool = 1;
  var_0 = self gettagorigin("j_neck");
  playFX(level._effect["deathfx_bloodpool_generic"], var_0);
  return 0;
}

buddy_down() {
  var_0 = "price";
  var_1 = "bravo4_1";
  var_2 = "bravo4_2";
  var_3 = "bravo4_4";
  var_4 = "buddy_down_intro";
  level.scr_anim[var_0][var_4] = % thd_3f_020_buddy_down_a_price;
  scripts\common\anim::addnotetrack_customfunction(var_0, "3rd_floor_price_push_open_door_sfx", ::sfx_townhouse_door_audio_3rd_floor_price, "buddy_down_intro");
  level.scr_anim[var_1][var_4] = % thd_3f_020_buddy_down_a_sas01;
  level.scr_anim[var_2][var_4] = % thd_3f_020_buddy_down_a_sas02;
  scripts\common\anim::addnotetrack_customfunction(var_2, "3rd_floor_sound_from_above", ::sfx_townhouse_audio_3rd_floor_sound_look_at, "buddy_down_intro");
  var_4 = "buddy_down_intro_loop";
  level.scr_anim[var_0][var_4][0] = % thd_3f_020_buddy_down_a_idle_price;
  level.scr_anim[var_1][var_4][0] = % thd_3f_020_buddy_down_a_idle_sas01;
  level.scr_anim[var_2][var_4][0] = % thd_3f_020_buddy_down_a_idle_sas02;
  var_4 = "buddy_down";
  level.scr_anim[var_1][var_4] = % thd_3f_020_buddy_down_b_sas01;
  level.scr_anim[var_2][var_4] = % thd_3f_020_buddy_down_b_sas02;
  scripts\common\anim::addnotetrack_flag(var_2, "buddy_down_break", "buddy_down_enemy_dead", var_4);
  scripts\common\anim::addnotetrack_flag(var_2, "shoot_buddy_down_vo", "shoot_buddy_down_vo", var_4);
  scripts\common\anim::addnotetrack_flag(var_2, "shoot_buddy_down", "shoot_buddy_down", var_4);
  scripts\common\anim::addnotetrack_flag(var_2, "price_dialogue", "buddy_down_price_dialogue", var_4);
  scripts\common\anim::addnotetrack_customfunction(var_2, "dropgun_scripted", ::buddy_down_dropgun, var_4);
  scripts\common\anim::addnotetrack_customfunction(var_2, "buddy_lookat_sfx", ::sfx_townhouse_audio_3rd_floor_buddy_down_look_at, "buddy_down");
  var_4 = "buddy_down_loop";
  level.scr_anim[var_1][var_4][0] = % thd_3f_020_buddy_down_b_idle_sas01;
  level.scr_anim[var_2][var_4][0] = % thd_3f_020_buddy_down_b_idle_sas02;
  var_4 = "buddy_down_drag";
  level.scr_anim[var_1][var_4] = % thd_3f_020_buddy_down_c_sas01;
  level.scr_anim[var_2][var_4] = % thd_3f_020_buddy_down_c_sas02;
  level.scr_anim[var_3][var_4] = % thd_3f_020_buddy_down_c_sas03;
  scripts\common\anim::addnotetrack_customfunction(var_3, "remove_playerclip", ::buddy_down_remove_playerclip, var_4);
  level.scr_anim[var_3][var_4 + "_loop"][0] = % thd_3f_020_buddy_down_c_idle_sas03;
  var_4 = "buddy_down_drag_loop";
  level.scr_anim[var_1][var_4][0] = % thd_3f_020_buddy_down_c_idle_sas01;
  level.scr_anim[var_2][var_4][0] = % thd_3f_020_buddy_down_c_idle_sas02;
  var_4 = "buddy_down_after";
  level.scr_anim[var_0][var_4] = % thd_3f_020_buddy_down_c_price;
  var_4 = "buddy_down_after_loop";
  level.scr_anim[var_0][var_4][0] = % thd_3f_020_buddy_down_c_idle_price;
  var_5 = "generic";
  level.scr_anim[var_5]["gunner_couch_death"] = % thd_3f_010_couch_death_long_enemy01;
  scripts\common\anim::addnotetrack_customfunction(var_5, "kill_me", ::kill_me_ragdoll_nosound, "gunner_couch_death");
  scripts\common\anim::addnotetrack_customfunction(var_5, "allowdeath", ::enable_allowdeath, var_4);
  level.scr_anim[var_5]["gunner_couch_death_end"] = % thd_3f_010_couch_death_shot_enemy01;
  level.scr_anim[var_5]["fake_flash"] = % thd_3f_010_couch_flash_intro_enemy01;
  level.scr_anim[var_5]["fake_flash_idle"][0] = % thd_3f_010_couch_flash_loop_enemy01;
  level.scr_goaltime[var_5]["fake_flash_react"] = 0.2;
  level.scr_anim[var_5]["fake_flash_react"] = % thd_3f_010_couch_flash_end_enemy01;
  level.scr_anim[var_5]["demo_shotgun_death"] = % sdr_com_exp_stand_death02_head_lg_2;
  level.scr_face[var_0]["dx_vom_pri_3rd_floor_bedroom_20"] = % dx_vom_pri_3rd_floor_bedroom_20_face;
  level.scr_face[var_0]["dx_vom_pri_3rd_floor_bedroom_30"] = % dx_vom_pri_3rd_floor_bedroom_30_face;
  level.scr_face[var_0]["dx_vom_pri_3rd_floor_bedroom_50"] = % dx_vom_pri_3rd_floor_bedroom_50_face;
  level.scr_face[var_0]["dx_vom_pri_3rd_floor_bedroom_60"] = % dx_vom_pri_3rd_floor_bedroom_60_face;
  level.scr_face[var_0]["dx_vom_pri_3rd_floor_bedroom_70"] = % dx_vom_pri_3rd_floor_bedroom_70_face;
  level.scr_face[var_0]["dx_vom_pri_3rd_floor_bedroom_110"] = % dx_vom_pri_3rd_floor_bedroom_110_face;
  level.scr_face[var_0]["dx_vom_pri_3rd_floor_bedroom_120"] = % dx_vom_pri_3rd_floor_bedroom_120_face;
}

buddy_down_dropgun(var_0) {
  var_1 = "iw8_ar_kilo433";
  var_2 = scripts\sp\utility::make_weapon(var_1, ["reflex_west01", "laserir", "rec_kilo433|1", "back_kilo433|1", "barsil_kilo433", "mag_kilo433|1"]);
  var_0 scripts\anim\shared.gsc::forceuseweapon(var_2, "primary");
  var_0 scripts\anim\notetracks_sp.gsc::notetrackgundrop();
}

buddy_down_remove_playerclip(var_0) {
  var_1 = getEnt("3rd_floor_door_playerclip", "targetname");
  var_1 delete();
}

favela_door() {
  var_0 = "generic";
  level.scr_anim[var_0]["faveladoor_fastopen"] = % reb_smtobj_door_r_fastopen;
  level.scr_anim[var_0]["faveladoor_fire1"] = % reb_smtobj_door_r_fire01;
  level.scr_anim[var_0]["faveladoor_fire2"] = % reb_smtobj_door_r_fire02;
  level.scr_anim[var_0]["faveladoor_fire3"] = % reb_smtobj_door_r_fire03;
  level.scr_anim[var_0]["faveladoor_idle"][0] = % reb_smtobj_door_r_loop;
  level.scr_anim[var_0]["faveladoor_kick"] = % reb_smtobj_door_r_kick01;
  level.scr_anim[var_0]["faveladoor_peak"] = % reb_smtobj_door_r_peak;
  level.scr_anim[var_0]["python_enter"] = % thd_3f_010_door_enter_alt_enemy01;
  scripts\common\anim::addnotetrack_customfunction(var_0, "3rd_floor_enemy_pre_enter_sfx", ::sfx_townhouse_door_audio_3rd_floor_python_pre, "python_enter");
  scripts\common\anim::addnotetrack_customfunction(var_0, "3rd_floor_enemy_enter_sfx", ::sfx_townhouse_door_audio_3rd_floor_python_enter, "python_enter");
  var_1 = "python_enter_long_death";
  level.scr_anim[var_0][var_1] = % thd_3f_010_door_alt_death_enemy01;
  scripts\common\anim::addnotetrack_customfunction(var_0, "kill_me", ::kill_me_ragdoll, var_1);
}

attic() {
  var_0 = "price";
  var_1 = "bomber";
  level.scr_face[var_0]["dx_vom_pri_attic_breach_20"] = % dx_vom_pri_attic_breach_20_face;
  level.scr_face[var_0]["dx_vom_pri_attic_breach_30"] = % dx_vom_pri_attic_breach_30_face;
  level.scr_face[var_0]["dx_vom_pri_attic_breach_40"] = % dx_vom_pri_attic_breach_40_face;
  level.scr_anim[var_0]["attic_door_arrive"] = % thd_atc_010_halligan_arrival_price;
  level.scr_anim[var_0]["attic_door_arrive_loop"][0] = % thd_atc_010_halligan_arrival_idle_price;
  level.scr_anim[var_0]["attic_door_open"] = % thd_atc_010_halligan_open_price;
  scripts\common\anim::addnotetrack_customfunction(var_0, "grab_halligan", ::grab_halligan, "attic_door_open");
  scripts\common\anim::addnotetrack_customfunction(var_0, "stow_halligan", ::stow_halligan, "attic_door_open");
  scripts\common\anim::addnotetrack_customfunction(var_0, "halligan_attic_door_prep_sfx", ::sfx_townhouse_door_audio_attic_prep, "attic_door_open");
  scripts\common\anim::addnotetrack_customfunction(var_0, "halligan_attic_door_open_sfx", ::sfx_townhouse_door_audio_attic_open, "attic_door_open");
  level.scr_anim[var_0]["attic_door_open_loop"][0] = % thd_atc_010_halligan_open_idle_price;
  level.scr_anim[var_0]["attic_stairtrain_arrival"] = % thd_4f_030_stairs_arrival_price;
  level.scr_anim[var_0]["attic_stairtrain_arrival_idle"][0] = % thd_4f_030_stairs_arrival_idle_price;
  level.scr_anim[var_0]["attic_stairtrain"] = % thd_4f_030_stairs_climb_price;
  var_2 = "attic_stairtrain_additive_branch";
  level.scr_anim[var_0][var_2] = % townhouse_stair_additives;
  var_2 = "attic_stairtrain_additive";
  level.scr_anim[var_0][var_2] = % thd_stair_train_idle_forward;
  var_2 = "attic_stairtrain_settle";
  level.scr_anim[var_0][var_2] = % thd_stair_train_settle_forward;
  var_3 = "attic_enemy";
  level.scr_model[var_3 + "_head"] = "head_sc_f_walden_blendshape";
  level.scr_anim[var_3]["start_idle"][0] = % thd_atc_010_bomber_start_idle_enemy01;
  level.scr_anim[var_0]["attic_entry"] = % thd_atc_010_bomber_enter_price;
  scripts\common\anim::addnotetrack_flag(var_0, "attic_clip", "attic_playerclip", "attic_entry");
  scripts\common\anim::addnotetrack_customfunction(var_0, "try_dialogue1", ::try_attic_dialogue_shoot_her, "attic_entry");
  level.scr_anim[var_0]["attic_entry_idle"][0] = % thd_atc_010_bomber_enter_idle_price;
  level.scr_anim[var_3]["attic_entry"] = % thd_atc_010_bomber_enter_enemy01;
  scripts\common\anim::addnotetrack_customfunction(var_3, "player_can_shoot", ::attic_player_can_shoot, "attic_entry");
  scripts\common\anim::addnotetrack_customfunction(var_3, "use_ragdoll", ::attic_use_ragdoll, "attic_entry");
  scripts\common\anim::addnotetrack_customfunction(var_3, "use_final_deathanim", ::attic_use_final_deathanim, "attic_entry");
  scripts\common\anim::addnotetrack_customfunction(var_3, "price_shoot", ::attic_price_shoot, "attic_entry");
  level.scr_anim[var_0]["attic_enemy_death"] = % thd_atc_010_bomber_death_price;
  level.scr_anim[var_0]["attic_enemy_death_idle"][0] = % thd_atc_010_bomber_death_idle_price;
  level.scr_anim[var_3]["attic_enemy_death"] = % thd_atc_010_bomber_death_enemy01;
  scripts\common\anim::addnotetrack_customfunction(var_3, "price_shoot", ::attic_price_shoot, "attic_enemy_death");
  scripts\common\anim::addnotetrack_customfunction(var_3, "kill_me", ::kill_me_ragdoll_nosound, "attic_enemy_death");
  level.scr_anim[var_3]["attic_enemy_headshot_death"] = % thd_atc_010_bomber_death_headshot_enemy01;
  level.scr_anim[var_3]["attic_enemy_early_long_death"] = % thd_atc_010_bomber_death_longdeath_enemy01;
  scripts\common\anim::addnotetrack_customfunction(var_3, "kill_me", ::kill_me_ragdoll_nosound, "attic_enemy_early_long_death");
  scripts\common\anim::addnotetrack_customfunction(var_3, "use_deathanim", ::attic_use_deathanim, "attic_enemy_early_long_death");
  level.scr_anim[var_3]["attic_enemy_early_long_death_end"] = % thd_atc_010_bomber_death_longdeath_shot_enemy01;
  level.scr_anim[var_0]["ending"] = % thd_atc_010_bomber_end_price;
  scripts\common\anim::addnotetrack_customfunction(var_0, "detach_prop", ::attic_detach_laptop, "ending");
  scripts\common\anim::addnotetrack_mayhemstart(var_0, "mayhem_start", %thd_atc_010_bomber_end_price_face, "ending");
  scripts\common\anim::addnotetrack_mayhemend(var_0, "mayhem_end", %thd_atc_010_bomber_end_price_face, "ending");
  level.scr_anim[var_1]["ending"] = % thd_atc_010_bomber_end_enemy01;
  scripts\common\anim::addnotetrack_customfunction(var_0, "attach_prop", ::attic_attach_clacker, "ending");
}

try_attic_dialogue_shoot_her(var_0) {
  if(!isalive(level.attic_enemy) || level.attic_enemy.health < 10) {
    return;
  }
  var_0 scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_attic_standoff_25");

  if(!isalive(level.attic_enemy) || level.attic_enemy.health < 10) {
    return;
  }
  level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_attic_standoff_30");
}

attic_detach_laptop(var_0) {
  level.price.laptop unlink();
}

attic_attach_clacker(var_0) {
  var_0 attach(level.clacker.model, "tag_accessory_right");
  level.clacker delete();
}

attic_player_can_shoot(var_0) {
  var_0 notify("stop_early_death");
  var_0.playerbullets--;
}

attic_use_ragdoll(var_0) {
  var_0.health = 5;
  var_0.allowdeath = 1;
  var_0.skipdeathanim = 1;
}

attic_use_final_deathanim(var_0) {
  var_0.health = 5;
  var_0.allowdeath = 1;
  var_0.skipdeathanim = 1;
  var_0.deathfunction = ::attic_final_player_deathanim;
}

attic_final_player_deathanim() {
  var_0 = scripts\engine\utility::getStruct("attic_animnode", "targetname");
  self animmode("noclip");
  self.disabledeathorient = 1;
  scripts\sp\maps\townhoused\townhoused_code.gsc::scripted_deathanim("attic_enemy_death", var_0);
}

attic_use_deathanim(var_0) {
  var_0.allowdeath = 1;
  var_0.skipdeathanim = undefined;
  var_0 scripts\engine\sp\utility::set_deathanim("attic_enemy_early_long_death_end");
}

attic_price_shoot(var_0) {
  if(!isalive(var_0) || var_0.health == 1) {
    return;
  }
  if(!isDefined(var_0.priceshootcount))
    var_0.priceshootcount = 0;

  var_0.damageshield = 1;
  level.price shoot(1, undefined, 1, 1);
  var_0.priceshootcount++;

  if(var_0.priceshootcount == 2)
    var_0 stopsounds();

  waitframe();
  var_0.damageshield = 0;
}

attic_enemy_death(var_0) {
  var_0.a.nodeath = 1;
  var_0 kill();
}

#using_animtree("player");

player() {
  var_0 = "player_rig";
  level.scr_animtree[var_0] = #animtree;
  level.scr_model[var_0] = "viewhands_kyle_sas_urban";
  level.scr_anim[var_0]["backyard_intro"] = % thd_ba_005_intro_plr;
  scripts\common\anim::addnotetrack_customfunction(var_0, "hide_head", ::hide_fakeplayer_head, "backyard_intro");
  scripts\common\anim::addnotetrack_customfunction(var_0, "swap_lock", ::backyard_cut_gate, "backyard_intro");
  level.scr_anim[var_0]["deploy_ladder"] = % thd_vm_tactical_ladder_plr;
  level.scr_anim[var_0]["window_mantle"] = % thd_1f_010_vm_mantle_plr;
  scripts\common\anim::addnotetrack_customfunction(var_0, "give_viewcontrol", ::mantle_give_viewlook, "window_mantle");
  level.scr_anim[var_0]["ending"] = % thd_atc_010_bomber_end_plr;
}

mantle_give_viewlook(var_0) {}

backyard_cut_gate(var_0) {
  level.gatelock setModel(scripts\engine\sp\utility::getmodel("gate_lock_cut"));
}

hide_fakeplayer_head(var_0) {
  level.kyle hidepart("j_head");
  level.kyle hidepart("j_helmet");
}

#using_animtree("script_model");

script_model() {
  var_0 = "door";
  level.scr_animtree[var_0] = #animtree;
  level.scr_model["halligan"] = "misc_vm_halligan_tool";
  level.scr_anim[var_0]["backyard_door_open"] = % thd_backyard_door;
  var_1 = "bolt_cutters";
  level.scr_animtree[var_1] = #animtree;
  level.scr_model[var_1] = "misc_wm_boltcutter";
  var_2 = "gate_lock";
  level.scr_animtree[var_2] = #animtree;
  level.scr_model[var_2] = "tool_security_padlock_01";
  level.scr_model["gate_lock_cut"] = "tool_security_padlock_02_cut";
  level.scr_animtree["gate"] = #animtree;
  level.scr_anim["gate"]["gate_cut"] = % th_wh_015_gate_gate01_cut;
  level.scr_animtree["cellphone_on"] = #animtree;
  level.scr_model["cellphone_on"] = "offhand_wm_cellphone_old_on";
  var_3 = "backyard_intro";
  level.scr_anim[var_1][var_3] = % thd_ba_005_intro_cutters;
  level.scr_anim[var_0][var_3] = % thd_ba_005_intro_gate;
  level.scr_anim[var_2]["backyard_intro_cut_gate"] = % thd_ba_005_intro_lock;
  scripts\common\anim::addnotetrack_customfunction(var_2, "drop", ::backyard_lock_physics, "backyard_intro_cut_gate");
  level.scr_anim[var_0]["backdoor_enter"] = % thd_ba_020_halligan_enter_door;
  level.scr_anim[var_0]["frontdoor_enter"] = % thd_1f_050_door_enter_door01;
  level.scr_anim[var_0]["buddy_down_intro"] = % thd_3f_020_buddy_down_a_door;
  level.scr_anim[var_0]["faveladoor_fastopen"] = % reb_smtobj_door_r_fastopen_rdoor;
  level.scr_anim[var_0]["faveladoor_fire1"] = % reb_smtobj_door_r_fire01_rdoor;
  level.scr_anim[var_0]["faveladoor_fire2"] = % reb_smtobj_door_r_fire02_rdoor;
  level.scr_anim[var_0]["faveladoor_fire3"] = % reb_smtobj_door_r_fire03_rdoor;
  level.scr_anim[var_0]["faveladoor_kick"] = % reb_smtobj_door_r_kick01_rdoor;
  level.scr_anim[var_0]["faveladoor_peak"] = % reb_smtobj_door_r_peak_rdoor;
  var_4 = "cuffs";
  level.scr_animtree[var_4] = #animtree;
  level.scr_model[var_4] = "zip_tie_handcuffs_wm";
  level.scr_anim[var_4]["kitchen_takedown"] = % thd_1f_040_woman_grabbed_cuffs;
  level.scr_anim[var_4]["kitchen_takedown_loop"][0] = % thd_1f_040_woman_idle_cuffs;
  level.scr_anim[var_4]["kitchen_takedown_lookup_loop"][0] = % thd_1f_040_woman_idle_up_cuffs;
  level.scr_anim[var_4]["kitchen_takedown_death"] = % thd_1f_040_woman_death_cuffs;
  level.scr_anim[var_0]["kitchen_takedown"] = % thd_1f_040_woman_grabbed_door01;
  var_5 = "chair";
  level.scr_animtree[var_5] = #animtree;
  level.scr_anim[var_5]["dining_react"] = % thd_1f_050_dining_room_chair1_react;
  level.scr_anim[var_5]["dining_react_high"] = % thd_1f_050_dining_room_chair1_react_high;
  level.scr_anim[var_5]["dining_react_pain"] = % thd_1f_050_dining_room_chair1_react_pain;
  level.scr_anim[var_5]["dining_death"] = % thd_1f_050_dining_room_chair1_death;
  level.scr_anim[var_5]["dining_long_death"] = % thd_1f_050_dining_room_chair1_death_long;
  level.scr_anim[var_5]["dining_long_death_end"] = % thd_1f_050_dining_room_chair1_death_long_end;
  level.scr_anim[var_5]["dining_long_death_expire"] = % thd_1f_050_dining_room_chair1_death_long_end_02;
  level.scr_anim[var_0]["boy_bathroom"] = % thd_2f_010_clear_rooms_arrival_door3;
  level.scr_anim[var_0]["secure_boy"] = % thd_2f_010_clear_rooms_enter_secure_door3;
  level.scr_anim[var_0]["2ndfloor_bedroom_enter"] = % thd_2f_010_clear_rooms_door2;
  level.scr_anim[var_0]["2ndfloor_bedroom_enter2"] = % thd_2f_010_clear_rooms_door4;
  level.scr_anim[var_0]["2ndfloor_bathroom_enter"] = % thd_2f_010_clear_rooms_door3;
  level.scr_anim[var_0]["python_enter"] = % thd_3f_010_door_enter_alt_door01;
  level.scr_anim[var_0]["baby_mom_arrive"] = % thd_4f_010_setup_door01;
  level.scr_model["collision_head"] = "civ_female_scriptable_collision_head";
  level.scr_model["collision_chest"] = "civ_female_scriptable_collision_spine_upper";
  level.scr_model["collision_shoulder"] = "civ_female_scriptable_collision_shoulder";
  level.scr_anim[var_0]["attic_door_open"] = % thd_atc_010_halligan_open_door01;
  scripts\common\anim::addnotetrack_customfunction(var_0, "swap", ::attic_swap_door, "attic_door_open");
  scripts\common\anim::addnotetrack_customfunction(var_0, "swap2", ::attic_swap_door2, "attic_door_open");
  var_6 = "clacker";
  level.scr_model[var_6] = "offhand_vm_clacker";
  level.scr_animtree[var_6] = #animtree;
  var_7 = "laptop";
  level.scr_model[var_7] = "device_laptop_02_open";
  level.scr_animtree[var_7] = #animtree;
  level.scr_model["attic_door_damaged"] = "door_metal_halligan_damaged_right_02_sp";
  level.scr_model["attic_door_damaged2"] = "door_metal_halligan_damaged_right_03_sp";
  var_8 = "baby";
  level.scr_animtree[var_8] = #animtree;
  level.scr_anim[var_8]["root"] = % root;
  level.scr_anim[var_8]["grab_baby"] = % thd_4f_020_baby_enter_baby;
  level.scr_anim[var_8]["grab_baby_loop"][0] = % thd_4f_020_baby_enter_idle_baby;
  level.scr_anim[var_8]["grab_baby_loop_ads_react"] = % thd_4f_020_baby_react_baby;
  level.scr_anim[var_8]["grab_baby_stand_death"] = % thd_4f_020_baby_stand_death_baby;
  level.scr_anim[var_8]["grab_baby_mom_early_death"] = % thd_4f_020_baby_early_death_baby;
  level.scr_anim[var_8]["grab_baby_death"] = % thd_4f_020_baby_death_baby;
  level.scr_anim[var_8]["grab_baby_pickup_early"] = % thd_4f_020_baby_pickup_baby;
  level.scr_anim[var_8]["grab_baby_pickup_early_idle"] = % thd_4f_020_baby_pickup_idle_baby;
  level.scr_anim[var_8]["grab_baby_stand_death_idle"] = % thd_4f_020_baby_pickup_idle_2_baby;
  level.scr_anim[var_8]["baby_idle"] = % thd_4f_020_baby_pickup_idle_3_baby;
}

attic_swap_door(var_0) {
  var_1 = scripts\sp\door::get_interactive_door("attic_door");
  var_1 setModel(scripts\engine\sp\utility::getmodel("attic_door_damaged"));
  var_2 = "j_end";
  var_3 = level.price gettagangles(var_2);
  var_4 = anglesToForward(var_3);
  var_5 = level.price gettagorigin(var_2) + var_4 * -3;
  playFX(scripts\engine\utility::getfx("halligan_attic"), var_5, var_4);
}

attic_swap_door2(var_0) {
  var_1 = scripts\sp\door::get_interactive_door("attic_door");
  var_1 setModel(scripts\engine\sp\utility::getmodel("attic_door_damaged2"));
}

backyard_lock_physics(var_0) {
  var_0.prevorigin = var_0.origin;
  waitframe();
  var_1 = var_0.prevorigin - var_0.origin;
  var_0 scripts\engine\sp\utility::anim_stopanimScripted();
  var_0 physicslaunchserver(var_0.origin, var_1 * 2);
}

gate_lock_swap(var_0) {
  var_0 setModel(scripts\engine\sp\utility::getmodel("gate_lock_cut"));
}

ladder() {
  level.scr_animtree["ladder"] = #animtree;
  level.scr_model["ladder"] = "misc_vm_tactical_ladder_sp";
  level.scr_anim["ladder"]["deploy_ladder"] = % thd_vm_tactical_ladder_prop;
}

vehicle() {}

#using_animtree("scriptables");

scriptable() {
  level.scr_animtree["backyard_car"] = #animtree;
}

ai_gestures() {
  level.scr_gesture = [];
}

customnotetrackhandler(var_0) {
  var_1 = getsubstr(var_0, 0, 3);

  if(var_1 == "dr_") {
    var_2 = getsubstr(var_0, 3);
    thread scripts\sp\maps\townhoused\townhoused_code.gsc::smart_dialogue_or_radio(var_2);
    return;
  }
}

apc_lerp_fov(var_0) {}

kill_me_no_anim(var_0) {
  if(isDefined(var_0.magic_bullet_shield) && var_0.magic_bullet_shield)
    var_0 scripts\common\ai::stop_magic_bullet_shield();

  var_0.damageshield = 0;
  var_0.a.nodeath = 1;
  var_0 kill();
}

kill_me_ragdoll(var_0) {
  if(isDefined(var_0.magic_bullet_shield) && var_0.magic_bullet_shield)
    var_0 scripts\common\ai::stop_magic_bullet_shield();

  var_0.allowdeath = 1;
  var_0.skipdeathanim = 1;
  var_0 kill();
}

kill_me_ragdoll_nosound(var_0) {
  var_0.diequietly = 1;
  kill_me_ragdoll(var_0);
}

allowdeath_just_ragdoll(var_0) {
  var_0.allowdeath = 1;
  var_0.skipdeathanim = 1;
}

remove_deathfunc(var_0) {
  var_0.deathfunction = undefined;
}

remove_skipdeathanim(var_0) {
  var_0.skipdeathanim = undefined;
}

remove_deathanim(var_0) {
  var_0.deathanime = undefined;
  var_0 scripts\engine\sp\utility::clear_deathanim();
}

remove_scripted_deaths(var_0) {
  remove_deathanim(var_0);
  remove_deathfunc(var_0);
}

no_allowdeath(var_0) {
  var_0.allowdeath = 0;
}

enable_allowdeath(var_0) {
  var_0.allowdeath = 1;
}

remove_death_react(var_0) {
  var_0 notify("stop_reaction_death");
  var_0 scripts\engine\sp\utility::clear_deathanim();
}

enable_magic_bullet_shield(var_0) {
  var_0 scripts\common\ai::magic_bullet_shield();
}

disable_magic_bullet_shield(var_0) {
  var_0 scripts\common\ai::stop_magic_bullet_shield();
}

sfx_townhouse_door_audio_backyard_gate(var_0) {
  level thread threaded_sfx_townhouse_door_audio("backyard_open_gate");
}

sfx_townhouse_door_audio_basement_prep(var_0) {
  level thread threaded_sfx_townhouse_door_audio("backdoor_freeze");
}

sfx_townhouse_door_audio_basement_enter(var_0) {
  level thread threaded_sfx_townhouse_door_audio("backdoor_enter");
}

sfx_townhouse_door_audio_kitchen_girl_pre(var_0) {
  level thread threaded_sfx_townhouse_door_audio("kitchen_takedown_pre");
}

sfx_townhouse_door_audio_kitchen_girl(var_0) {
  level thread threaded_sfx_townhouse_door_audio("kitchen_takedown");
}

sfx_townhouse_door_audio_front_open(var_0) {
  level thread threaded_sfx_townhouse_door_audio("frontdoor_enter");
}

sfx_townhouse_door_audio_2nd_floor_bathroom(var_0) {
  level thread threaded_sfx_townhouse_door_audio("2ndfloor_bathroom_enter");
}

sfx_townhouse_door_audio_2nd_floor_bedroom(var_0) {
  level thread threaded_sfx_townhouse_door_audio("2ndfloor_bedroom_enter");
}

sfx_townhouse_door_audio_2nd_floor_bedroom_bash(var_0) {
  level thread threaded_sfx_townhouse_door_audio("2ndfloor_bedroom_enter_bash");
}

sfx_townhouse_door_audio_3rd_floor_price(var_0) {
  level thread threaded_sfx_townhouse_door_audio("3rd_floor_buddy_down_intro");
}

sfx_townhouse_door_audio_3rd_floor_python_pre(var_0) {
  level thread threaded_sfx_townhouse_door_audio("3rd_floor_python_pre_enter");
}

sfx_townhouse_door_audio_3rd_floor_python_enter(var_0) {
  level thread threaded_sfx_townhouse_door_audio("3rd_floor_python_enter");
}

sfx_townhouse_audio_3rd_floor_sound_look_at(var_0) {
  level thread threaded_sfx_townhouse_door_audio("3rd_floor_sound_lookat");
}

sfx_townhouse_audio_3rd_floor_buddy_down_look_at(var_0) {
  level thread threaded_sfx_townhouse_door_audio("3rd_floor_buddy_down_lookat");
}

sfx_townhouse_door_audio_4th_floor_bathroom(var_0) {
  level thread threaded_sfx_townhouse_door_audio("4thfloor_bathroom_enter");
}

sfx_townhouse_door_audio_attic_prep(var_0) {
  level thread threaded_sfx_townhouse_door_audio("attic_prep");
}

sfx_townhouse_door_audio_attic_open(var_0) {
  level thread threaded_sfx_townhouse_door_audio("attic_open");
}

threaded_sfx_townhouse_door_audio(var_0) {
  switch (var_0) {
    case "backyard_open_gate":
      thread scripts\engine\utility::play_sound_in_space("backyard_gate_unlatch", (864, 556, -358));
      wait 1.4;
      thread scripts\engine\utility::play_sound_in_space("backyard_gate_open", (876, 553, -388));
      wait 1.0;
      thread scripts\engine\utility::play_sound_in_space("backyard_gate_hit_wall", (868, 591, -388));
      break;
    case "backdoor_freeze":
      thread scripts\engine\utility::play_sound_in_space("price_halligan_basement_door_prep", (408, 757, -485));
      break;
    case "backdoor_enter":
      thread scripts\engine\utility::play_sound_in_space("price_halligan_basement_door_open", (408, 757, -485));
      wait 2.5;
      thread scripts\engine\utility::play_sound_in_space("price_halligan_basement_door_open_nudge_wide", (408, 757, -485));
      break;
    case "kitchen_takedown_pre":
      thread scripts\engine\utility::play_sound_in_space("kitchen_girl_door_pre_open", (311, 921, -368));
      break;
    case "kitchen_takedown":
      thread scripts\engine\utility::play_sound_in_space("kitchen_girl_door_open", (311, 921, -368));
      wait 0.2;
      level.player clearallsoundsubmixes();
      wait 1.05;
      thread scripts\engine\utility::play_sound_in_space("kitchen_girl_door_open_hitwall", (347, 932, -354));
      break;
    case "frontdoor_enter":
      thread scripts\engine\utility::play_sound_in_space("stairs1_front_door_open", (47, 1250, -379));
      wait 0.2;
      thread audio_front_door_dog_sfx();
      wait 1;
      thread scripts\engine\utility::play_sound_in_space("stairs1_front_door_hitwall", (93, 1246, -379));
      break;
    case "2ndfloor_bathroom_enter":
      thread scripts\engine\utility::play_sound_in_space("2nd_floor_bathroom_door_open", (336, 960, -269));
      break;
    case "2ndfloor_bedroom_enter":
      thread scripts\engine\utility::play_sound_in_space("2nd_floor_bedroom_door_open", (253, 877, -269));
      break;
    case "2ndfloor_bedroom_enter_bash":
      thread scripts\engine\utility::play_sound_in_space("2nd_floor_bedroom_door_open_bash", (291, 873, -243));
      break;
    case "3rd_floor_buddy_down_intro":
      thread scripts\engine\utility::play_sound_in_space("3rd_floor_bathroom_door_open", (369, 916, -142));
      break;
    case "3rd_floor_sound_lookat":
      thread scripts\engine\utility::play_sound_in_space("3rd_floor_sas_look_up_at_sound", (345, 995, -39));
      break;
    case "3rd_floor_buddy_down_lookat":
      thread scripts\engine\utility::play_sound_in_space("3rd_floor_sas_buddy_down_look_at", (345, 995, -39));
      break;
    case "3rd_floor_python_pre_enter":
      thread scripts\engine\utility::play_sound_in_space("3rd_floor_python_door_pre_open", (178, 911, -192));
      break;
    case "3rd_floor_python_enter":
      thread scripts\engine\utility::play_sound_in_space("3rd_flor_python_door_open_bash", (180, 917, -136));
      break;
    case "4thfloor_bathroom_enter":
      thread scripts\engine\utility::play_sound_in_space("2nd_floor_bathroom_door_open", (373, 911, -15));
      break;
    case "attic_prep":
      thread scripts\engine\utility::play_sound_in_space("price_halligan_attic_door_prep", (329, 958, 54));
      break;
    case "attic_open":
      thread scripts\engine\utility::play_sound_in_space("price_halligan_attic_door_open", (329, 958, 54));
      break;
  }
}

audio_front_door_dog_sfx() {
  level.frontdoordog = spawn("script_origin", (60, 1263, -335));
  level.frontdoordog scripts\engine\sp\utility::sound_fade_in("emt_dog_barking_dist_03", 1.0, 0.8, 1);
  level waittill("stop_dog_sounds_front_door");
  level.frontdoordog scripts\engine\sp\utility::sound_fade_and_delete(8.0, 1);
}