/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\townhoused\townhoused_anim.gsc
**********************************************************/

function main() {
  setdvarifuninitialized("scr_reveal", "0");
  level.customnotetrackhandler = &customnotetrackhandler;
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

  if(level.demo) {
    level.scr_model["generic_nvgs_on"] = "head_sas_urban_ar_nvg_viewmodel";
  } else {
    level.scr_model["generic_nvgs_on"] = "head_sas_urban_ar_nvg";
  }

  level.scr_model["price_nvgs_on"] = "hat_hero_price_helmet";
}

#using_animtree("");

function generic() {
  var0 = "generic";
  level.scr_anim[var0]["flash_react_knob"] = % thd_generic_flash_react;
  level.scr_anim[var0]["flash_react"] = $thd_soldier_additive_flash_bang;
}

function backyard_intro() {
  var0 = "kyle";
  var1 = "price";
  var2 = "bravo2_1";
  var3 = "bravo2_2";
  var4 = "backyard_intro";
  level.scr_anim[var0][var4] = % thd_ba_005_intro_kyle;
  level.scr_anim[var1][var4] = % thd_ba_005_intro_price;
  level.scr_anim[var2][var4] = % thd_ba_005_intro_ally01;
  level.scr_anim[var3][var4] = % thd_ba_005_intro_ally02;
  var4 = "backyard_intro_idle";
  level.scr_anim[var1][var4][0] = % thd_ba_005_intro_idle_price;
  level.scr_anim[var2][var4][0] = % thd_ba_005_intro_idle_ally01;
  level.scr_anim[var3][var4][0] = % thd_ba_005_intro_idle_ally02;
}

function backyard() {
  var0 = "price";
  var1 = "bravo2_1";
  var2 = "bravo2_2";
  var3 = "bravo2_3";
  var4 = "bravo2_4";
  var5 = "backyard_alley_move";
  level.scr_anim[var0][var5] = % thd_ba_005_entry_alley_price;
  level.scr_anim[var1][var5] = % thd_ba_005_entry_alley_ally01;
  level.scr_anim[var2][var5] = % thd_ba_005_entry_alley_ally02;
  level.scr_anim[var3][var5] = % thd_ba_005_entry_alley_ally03;
  level.scr_anim[var4][var5] = % thd_ba_005_entry_alley_ally04;
  var5 = "backyard_alley_move_idle";
  level.scr_anim[var0][var5][0] = % thd_ba_005_entry_alley_idle_price;
  level.scr_anim[var1][var5][0] = % thd_ba_005_entry_alley_idle_ally01;
  level.scr_anim[var2][var5][0] = % thd_ba_005_entry_alley_idle_ally02;
  level.scr_anim[var3][var5][0] = % thd_ba_005_entry_alley_idle_ally03;
  level.scr_anim[var4][var5][0] = % thd_ba_005_entry_alley_idle_ally04;
  var5 = "backyard_move";
  level.scr_anim[var0][var5] = % thd_ba_005_entry_yard_price;
  level.scr_anim[var1][var5] = % thd_ba_005_entry_yard_ally01;
  level.scr_anim[var2][var5] = % thd_ba_005_entry_yard_ally02;
  var5 = "backyard_move_idle";
  level.scr_anim[var0][var5][0] = % thd_ba_020_halligan_arrival_idle_price;
  level.scr_anim[var1][var5][0] = % thd_ba_020_halligan_arrival_idle_ally01;
  level.scr_anim[var2][var5][0] = % thd_ba_005_entry_yard_idle_ally02;
  level.scr_anim[var3]["backyard_open_gate"] = % thd_ba_005_entry_yard_open_ally03;
  scripts\common\anim::addnotetrack_customfunction(var3, "backyard_open_gate_sfx", &sfx_townhouse_door_audio_backyard_gate, "backyard_open_gate");
  level.scr_anim[var3]["backyard_open_gate_idle"][0] = level.scr_anim[var3]["backyard_alley_move_idle"][0];
  var5 = "backyard_move";
  level.scr_anim[var4][var5] = % thd_ba_005_entry_yard_ally04;
  level.scr_anim[var3][var5] = % thd_ba_005_entry_yard_ally03;
  var5 = "backyard_move_idle";
  level.scr_anim[var4][var5][0] = % thd_ba_020_halligan_arrival_idle_ally04;
  level.scr_anim[var3][var5][0] = % thd_ba_005_entry_yard_idle_ally03;
  var5 = "backdoor_freeze";
  level.scr_anim[var0][var5] = % thd_ba_020_halligan_freeze_price;
  scripts\common\anim::addnotetrack_customfunction(var0, "grab_halligan", &grab_halligan, "backdoor_freeze");
  scripts\common\anim::addnotetrack_customfunction(var0, "halligan_basement_door_prep_sfx", &sfx_townhouse_door_audio_basement_prep, "backdoor_freeze");
  level.scr_anim[var1][var5] = % thd_ba_020_halligan_freeze_ally01;
  var5 = "backdoor_freeze_idle";
  level.scr_anim[var0][var5][0] = % thd_ba_020_halligan_freeze_idle_price;
  level.scr_anim[var1][var5][0] = % thd_ba_020_halligan_freeze_idle_ally01;
  level.scr_anim[var0]["backdoor_freeze_nag"] = % thd_ba_020_halligan_freeze_nag_price;
  var5 = "backdoor_enter";
  level.scr_anim[var0][var5] = % thd_ba_020_halligan_enter_price;
  scripts\common\anim::addnotetrack_customfunction(var0, "stow_halligan", &stow_halligan, "backdoor_enter");
  scripts\common\anim::addnotetrack_customfunction(var0, "halligan_basement_door_sfx", &sfx_townhouse_door_audio_basement_enter, "backdoor_enter");
  level.scr_anim[var1][var5] = % thd_ba_020_halligan_enter_ally01;
  level.scr_anim[var4][var5] = % thd_ba_020_halligan_enter_ally04;
  level.scr_face[var0]["dx_vom_pri_attic_breach_04"] = % dx_vom_pri_attic_breach_04_face;
  var5 = "backdoor_enter_idle";
  level.scr_anim[var4][var5][0] = % thd_ba_020_halligan_enter_idle_ally04;
  var5 = "backdoor_nag";
  level.scr_anim[var4][var5] = % thd_ba_020_halligan_enter_nag_ally04;
  level.scr_face[var0]["dx_vom_pri_backyard_alleyway_20"] = % dx_vom_pri_backyard_alleyway_20_face;
  var6 = "bravo3_1";
  var7 = "bravo3_2";
  var8 = "bravo3_3";
  var5 = "side_alley_move";
  level.scr_anim[var6][var5] = % thd_ba_010_sas_intro_sas1_arrival;
  level.scr_goaltime[var6][var5] = 0.2;
  level.scr_anim[var7][var5] = % thd_ba_010_sas_intro_sas2_arrival;
  level.scr_goaltime[var7][var5] = 0.2;
  level.scr_anim[var8][var5] = % thd_ba_010_sas_intro_sas3_arrival;
  level.scr_goaltime[var8][var5] = 0.2;
  var5 = "side_alley_move_loop";
  level.scr_anim[var6][var5][0] = % thd_ba_010_sas_intro_sas1_idle;
  level.scr_anim[var7][var5][0] = % thd_ba_010_sas_intro_sas2_idle;
  level.scr_anim[var8][var5][0] = % thd_ba_010_sas_intro_sas3_idle;
}

function grab_halligan(var0) {
  var1 = scripts\engine\sp\utility::getmodel("halligan");

  if(var0.halliganstowed) {
    var0.halliganstowed = 0;
    var0 detach(var1, var0.halligan_tag);
  }

  var0 attach(var1, "tag_accessory_left");
  var0.halliganinhand = 1;
}

function stow_halligan(var0) {
  var1 = scripts\engine\sp\utility::getmodel("halligan");

  if(!var0.halliganstowed) {
    var0.halliganstowed = 1;
    var0 attach(var1, var0.halligan_tag);
  }

  if(!isDefined(var0.halliganinhand)) {
    return;
  }

  var0 detach(var1, "tag_accessory_left");
  var0.halliganinhand = undefined;
}

function kitchen() {
  var0 = "price";
  level.scr_anim[var0]["kitchen_takedown"] = % thd_1f_040_woman_grabbed_price;
  scripts\common\anim::addnotetrack_customfunction(var0, "set_nvg_bool", &set_nvg_bool, "kitchen_takedown");
  scripts\common\anim::addnotetrack_flag(var0, "can_fastforward", "kitchen_takedown_fastforward", "kitchen_takedown");
  level.scr_anim[var0]["kitchen_takedown_idle"][0] = % thd_1f_040_woman_idle_price;
  var1 = "hallway_girl";
  var2 = "bravo3";
  level.scr_anim[var1]["kitchen_takedown"] = % thd_1f_040_woman_grabbed_woman01;
  scripts\common\anim::addnotetrack_customfunction(var1, "use_deathanim_hold", &kitchen_use_deathanim_hold, "kitchen_takedown");
  scripts\common\anim::addnotetrack_customfunction(var1, "use_deathanim_tie", &kitchen_use_deathanim_tie, "kitchen_takedown");
  scripts\common\anim::addnotetrack_customfunction(var1, "use_deathanim_laying", &kitchen_use_deathanim_laying, "kitchen_takedown");
  scripts\common\anim::addnotetrack_customfunction(var1, "use_deathanim", &kitchen_use_deathanim, "kitchen_takedown");
  scripts\common\anim::addnotetrack_customfunction(var1, "no_allowdeath", &no_allowdeath, "kitchen_takedown");
  scripts\common\anim::addnotetrack_customfunction(var1, "open_door", &kitchen_open_door, "kitchen_takedown");
  scripts\common\anim::addnotetrack_customfunction(var1, "kitchen_girl_pre_open_door_sfx", &sfx_townhouse_door_audio_kitchen_girl_pre, "kitchen_takedown");
  scripts\common\anim::addnotetrack_customfunction(var1, "kitchen_girl_open_door_sfx", &sfx_townhouse_door_audio_kitchen_girl, "kitchen_takedown");
  scripts\common\anim::addnotetrack_customfunction(var1, "switch_to_allies", &set_as_innocent, "kitchen_takedown");
  level.scr_anim[var1]["kitchen_takedown_loop"][0] = % thd_1f_040_woman_idle_woman01;
  level.scr_anim[var2]["kitchen_takedown"] = % thd_1f_040_woman_grabbed_soldier01;
  scripts\common\anim::addnotetrack_customfunction(var2, "use_deathanim_laying", &kitchen_use_deathanim_laying_bravo, "kitchen_takedown");
  scripts\common\anim::addnotetrack_customfunction(var2, "no_react", &kitchen_no_react, "kitchen_takedown");
  level.scr_anim[var2]["kitchen_takedown_idle"][0] = % thd_1f_040_woman_idle_soldier01;
  level.scr_anim[var1]["kitchen_takedown_death_stand"] = % thd_1f_040_woman_death_standing_woman01;
  level.scr_anim[var2]["kitchen_takedown_death_stand"] = % thd_1f_040_woman_death_standing_soldier01;
  level.scr_anim[var2]["kitchen_takedown_death_stand_idle"][0] = % thd_1f_040_woman_death_standing_idle_soldier01;
  level.scr_anim[var1]["kitchen_takedown_death_hold"] = % thd_1f_040_woman_death_hold_woman01;
  level.scr_anim[var2]["kitchen_takedown_death_hold"] = % thd_1f_040_woman_death_hold_soldier01;
  level.scr_anim[var2]["kitchen_takedown_death_hold_idle"][0] = % thd_1f_040_woman_death_hold_idle_soldier01;
  level.scr_anim[var1]["kitchen_takedown_death_tie"] = % thd_1f_040_woman_death_ground_woman01;
  level.scr_anim[var2]["kitchen_takedown_death_tie"] = % thd_1f_040_woman_death_ground_soldier01;
  level.scr_anim[var2]["kitchen_takedown_death_tie_idle"][0] = % thd_1f_040_woman_death_ground_idle_soldier01;
  level.scr_anim[var1]["kitchen_takedown_death_laying"] = % thd_1f_040_woman_death_woman01;
  level.scr_anim[var2]["kitchen_takedown_death_laying"] = % thd_1f_040_woman_death_soldier01;
  level.scr_face[var0]["dx_vom_pri_kitchen_window_30"] = % dx_vom_pri_kitchen_window_30_face;
  level.scr_face[var0]["dx_vom_pri_kitchen_window_40"] = % dx_vom_pri_kitchen_window_40_face;
  level.scr_face[var0]["dx_vom_pri_kitchen_window_50"] = % dx_vom_pri_kitchen_window_50_face;
}

function kitchen_open_door(var0) {
  var1 = scripts\sp\door::get_interactive_door("kitchen_girl_door");
  var1 setscriptablepartstate("main", "open_handle");
  var1.fndamage = undefined;
}

function kitchen_use_deathanim_hold(var0) {
  var0.deathanim = undefined;
  var0.kitchen_death_anime = "kitchen_takedown_death_hold";
  var0.ally.kitchen_react = "kitchen_takedown_death_hold";

  if(var0.health == 1) {
    var0.allowdeath = 1;
    var0 kill();
    return;
  }
}

function kitchen_use_deathanim_tie(var0) {
  var0.deathanim = undefined;
  var0.kitchen_death_anime = "kitchen_takedown_death_tie";
  var0.ally.kitchen_react = "kitchen_takedown_death_tie";
  var0.allowdeath = 1;

  if(var0.health == 1) {
    var0 kill();
    return;
  }
}

function kitchen_use_deathanim_laying(var0) {
  var0.skipdeathanim = undefined;
  var0.noragdoll = 1;
  var0 scripts\engine\sp\utility::set_deathanim("kitchen_takedown_death_laying");
}

function kitchen_no_react(var0) {
  var0.no_react = 1;
}

function kitchen_use_deathanim_laying_bravo(var0) {
  var1 = scripts\engine\sp\utility::get_living_ai("hallway_girl", "animname");

  if(!isalive(var1)) {
    var2 = scripts\engine\utility::getStruct("kitchen_animnode", "targetname");
    var2 scripts\common\anim::anim_single_solo(var0, "kitchen_takedown_death_laying");
    return;
  }

  var1.no_react = undefined;
  var1.kitchen_react = "kitchen_takedown_death_laying";
}

function kitchen_use_deathanim(var0) {
  var0.noragdoll = 1;
  var0.deathanim = var0 scripts\engine\utility::getanim("kitchen_takedown_death_laying");
}

function dining_room() {
  var0 = "dining_enemy1";
  var1 = "dining_enemy2";
  var2 = "dining_enemy3";
  level.scr_anim[var0]["dining_intro"] = % thd_1f_050_dining_room_aq1_idle;
  level.scr_anim[var0]["dining_loop"][0] = % thd_1f_050_dining_room_aq1_idle;
  level.scr_anim[var0]["dining_loop_once"] = % thd_1f_050_dining_room_aq1_idle;
  var3 = "dining_react";
  level.scr_anim[var0][var3] = % thd_1f_050_dining_room_aq1_react;
  scripts\common\anim::addnotetrack_customfunction(var0, "grab_gun", &pickup_gun, var3);
  scripts\common\anim::addnotetrack_customfunction(var0, "remove_deathanim", &remove_dining_deathanim, var3);
  scripts\common\anim::addnotetrack_customfunction(var0, "use_late_long_death", &use_late_long_death, var3);
  var3 = "dining_react_high";
  level.scr_anim[var0][var3] = % thd_1f_050_dining_room_aq1_react_high;
  scripts\common\anim::addnotetrack_customfunction(var0, "grab_gun", &pickup_gun, var3);
  scripts\common\anim::addnotetrack_customfunction(var0, "remove_deathanim", &remove_dining_deathanim, var3);
  scripts\common\anim::addnotetrack_customfunction(var0, "use_late_long_death", &use_late_long_death, var3);
  var3 = "dining_react_pain";
  level.scr_anim[var0][var3] = % thd_1f_050_dining_room_aq1_react_pain;
  scripts\common\anim::addnotetrack_customfunction(var0, "grab_gun", &pickup_gun, var3);
  scripts\common\anim::addnotetrack_customfunction(var0, "remove_deathanim", &remove_dining_deathanim, var3);
  scripts\common\anim::addnotetrack_customfunction(var0, "use_late_long_death", &use_late_long_death, var3);
  scripts\common\anim::addnotetrack_customfunction(var0, "stop_late_long_death", &stop_late_long_death, var3);
  var3 = "dining_death";
  level.scr_anim[var0][var3] = % thd_1f_050_dining_room_aq1_death;
  scripts\common\anim::addnotetrack_customfunction(var0, "allowdeath", &enable_allowdeath, var3);
  scripts\common\anim::addnotetrack_customfunction(var0, "kill_me", &kill_me_ragdoll_nosound, var3);
  var3 = "dining_long_death";
  level.scr_anim[var0][var3] = % thd_1f_050_dining_room_aq1_death_long;
  scripts\common\anim::addnotetrack_customfunction(var0, "chest_fx", &dining_room_chest_fx, var3);
  scripts\common\anim::addnotetrack_customfunction(var0, "allowdeath", &enable_allowdeath, var3);
  level.scr_anim[var0]["dining_long_death_end"] = % thd_1f_050_dining_room_aq1_death_long_end;
  var3 = "dining_long_death_expire";
  level.scr_anim[var0][var3] = % thd_1f_050_dining_room_aq1_death_long_end_02;
  scripts\common\anim::addnotetrack_customfunction(var0, "kill_me", &kill_me_ragdoll_nosound, var3);
  var3 = "dining_late_long_death";
  level.scr_anim[var0][var3] = % thd_1f_050_dining_room_aq1_long_death;
  scripts\common\anim::addnotetrack_customfunction(var0, "kill_me", &kill_me_ragdoll_nosound, var3);
  level.scr_anim[var1]["dining_intro"] = % thd_1f_050_dining_room_aq2_intro;
  level.scr_anim[var1]["dining_loop"][0] = % thd_1f_050_dining_room_aq2_idle;
  var3 = "dining_react";
  level.scr_anim[var1][var3] = % thd_1f_050_dining_room_aq2_react;
  scripts\common\anim::addnotetrack_customfunction(var1, "grab_gun", &pickup_gun, var3);
  scripts\common\anim::addnotetrack_customfunction(var1, "remove_deathanim", &remove_dining_deathanim, var3);
  scripts\common\anim::addnotetrack_customfunction(var1, "use_late_long_death", &use_late_long_death, var3);
  var3 = "dining_react_high";
  level.scr_anim[var1][var3] = % thd_1f_050_dining_room_aq2_react_high;
  scripts\common\anim::addnotetrack_customfunction(var1, "grab_gun", &pickup_gun, var3);
  scripts\common\anim::addnotetrack_customfunction(var1, "remove_deathanim", &remove_dining_deathanim, var3);
  scripts\common\anim::addnotetrack_customfunction(var1, "use_late_long_death", &use_late_long_death, var3);
  var3 = "dining_react_pain";
  level.scr_anim[var1][var3] = % thd_1f_050_dining_room_aq2_react_pain;
  scripts\common\anim::addnotetrack_customfunction(var1, "grab_gun", &pickup_gun, var3);
  scripts\common\anim::addnotetrack_customfunction(var1, "use_late_long_death", &use_late_long_death, var3);
  scripts\common\anim::addnotetrack_customfunction(var1, "stop_late_long_death", &stop_late_long_death, var3);
  var3 = "dining_death";
  level.scr_anim[var1][var3] = % thd_1f_050_dining_room_aq2_death;
  scripts\common\anim::addnotetrack_customfunction(var1, "allowdeath", &enable_allowdeath, var3);
  scripts\common\anim::addnotetrack_customfunction(var1, "kill_me", &kill_me_ragdoll_nosound, var3);
  var3 = "dining_long_death";
  level.scr_anim[var1][var3] = % thd_1f_050_dining_room_aq2_death_long;
  scripts\common\anim::addnotetrack_customfunction(var1, "allowdeath", &enable_allowdeath, var3);
  scripts\common\anim::addnotetrack_customfunction(var1, "kill_me", &kill_me_ragdoll_nosound, var3);
  scripts\common\anim::addnotetrack_customfunction(var1, "can_use_long_death_end", &use_death_long_end, var3);
  level.scr_anim[var1]["dining_long_death_end"] = % thd_1f_050_dining_room_aq2_death_long_end;
  var3 = "dining_late_long_death";
  level.scr_anim[var1][var3] = % thd_1f_050_dining_room_aq2_long_death;
  scripts\common\anim::addnotetrack_customfunction(var1, "kill_me", &kill_me_ragdoll_nosound, var3);
  scripts\common\anim::addnotetrack_customfunction(var1, "can_use_long_death_end", &use_death_long_end2, var3);
  level.scr_anim[var1]["dining_late_long_death_end2"] = % thd_1f_050_dining_room_aq2_death_long_end_02;
  level.scr_anim[var2]["dining_intro"] = % thd_1f_050_dining_room_aq3_intro;
  level.scr_anim[var2]["dining_loop"][0] = % thd_1f_050_dining_room_aq3_idle;
  var3 = "dining_react";
  level.scr_anim[var2][var3] = % thd_1f_050_dining_room_aq3_react;
  scripts\common\anim::addnotetrack_customfunction(var2, "grab_gun", &pickup_gun, var3);
  scripts\common\anim::addnotetrack_customfunction(var2, "remove_deathanim_ragonly", &remove_dining_deathanim_ragonly, var3);
  scripts\common\anim::addnotetrack_customfunction(var2, "use_late_long_death", &use_late_long_death, var3);
  var3 = "dining_react_high";
  level.scr_anim[var2][var3] = % thd_1f_050_dining_room_aq3_react_high;
  scripts\common\anim::addnotetrack_customfunction(var2, "grab_gun", &pickup_gun, var3);
  scripts\common\anim::addnotetrack_customfunction(var2, "remove_deathanim", &remove_dining_deathanim, var3);
  scripts\common\anim::addnotetrack_customfunction(var2, "use_late_long_death", &use_late_long_death, var3);
  var3 = "dining_react_grenade";
  level.scr_anim[var2][var3] = % thd_1f_050_dining_room_aq3_react_grenade;
  scripts\common\anim::addnotetrack_customfunction(var2, "attach_sidearm", &attach_sidearm, var3);
  var3 = "dining_react_flash";
  level.scr_anim[var2][var3] = % thd_1f_050_dining_room_aq3_react_flash;
  scripts\common\anim::addnotetrack_customfunction(var2, "attach_sidearm", &attach_sidearm, var3);
  var3 = "dining_death";
  level.scr_anim[var2][var3] = % thd_1f_050_dining_room_aq3_death;
  scripts\common\anim::addnotetrack_customfunction(var2, "kill_me", &kill_me_ragdoll_nosound, var3);
  scripts\common\anim::addnotetrack_customfunction(var2, "remove_deathanim", &remove_dining_deathanim, var3);
  var3 = "dining_react_pain";
  level.scr_anim[var2][var3] = % thd_1f_050_dining_room_aq3_react_pain;
  scripts\common\anim::addnotetrack_customfunction(var2, "grab_gun", &pickup_gun, var3);
  var3 = "dining_late_long_death";
  level.scr_anim[var2][var3] = % thd_1f_050_dining_room_aq3_long_death;
  scripts\common\anim::addnotetrack_customfunction(var2, "kill_me", &kill_me_ragdoll_nosound, var3);
  var3 = "demo_death";
  level.scr_anim[var2][var3] = % sdr_com_exp_stand_death01_head_med_2;
  level.scr_face[var1]["dx_vom_aq1_dining_room_aq_convo2_20"] = % dx_vom_aq1_dining_room_aq_convo2_20_face;
  level.scr_face[var1]["dx_vom_aq1_dining_room_aq_convo2_50"] = % dx_vom_aq1_dining_room_aq_convo2_50_face;
  level.scr_face[var1]["dx_vom_aq1_dining_room_aq_convo2_100"] = % dx_vom_aq1_dining_room_aq_convo2_100_face;
  level.scr_face[var1]["dx_vom_aq1_dining_room_aq_convo2_110"] = % dx_vom_aq1_dining_room_aq_convo2_110_face;
  level.scr_face[var1]["dx_vom_aq1_dining_room_aq_convo2_120"] = % dx_vom_aq1_dining_room_aq_convo2_120_face;
  level.scr_face[var1]["dx_vom_aq1_dining_room_aq_convo2_130"] = % dx_vom_aq1_dining_room_aq_convo2_130_face;
  level.scr_face[var1]["dx_vom_aq1_dining_room_aq_convo2_150"] = % dx_vom_aq1_dining_room_aq_convo2_150_face;
  level.scr_face[var1]["dx_vom_aq1_dining_room_aq_convo2_160"] = % dx_vom_aq1_dining_room_aq_convo2_160_face;
  level.scr_face[var1]["dx_vom_aq1_dining_room_aq_convo2_170"] = % dx_vom_aq1_dining_room_aq_convo2_170_face;
  level.scr_face[var1]["dx_vom_aq1_dining_room_aq_convo2_180"] = % dx_vom_aq1_dining_room_aq_convo2_180_face;
  level.scr_face[var0]["dx_vom_aq3_dining_room_aq_convo2_10"] = % dx_vom_aq3_dining_room_aq_convo2_10_face;
  level.scr_face[var0]["dx_vom_aq3_dining_room_aq_convo2_30"] = % dx_vom_aq3_dining_room_aq_convo2_30_face;
  level.scr_face[var0]["dx_vom_aq3_dining_room_aq_convo2_60"] = % dx_vom_aq3_dining_room_aq_convo2_60_face;
  level.scr_face[var0]["dx_vom_aq3_dining_room_aq_convo2_80"] = % dx_vom_aq3_dining_room_aq_convo2_80_face;
  level.scr_face["price"]["dx_vom_pri_dining_room_entry_20"] = % dx_vom_pri_dining_room_entry_20_face;
  level.scr_face["price"]["dx_vom_pri_dining_room_entry_30"] = % dx_vom_pri_dining_room_entry_30_face;
  level.scr_face["price"]["dx_vom_pri_dining_room_entry_40"] = % dx_vom_pri_dining_room_entry_40_face;
  level.scr_face["price"]["dx_vom_pri_dining_room_entry_50"] = % dx_vom_pri_dining_room_entry_50_face;
  level.scr_face["price"]["dx_vom_pri_dining_room_entry_60"] = % dx_vom_pri_dining_room_entry_60_face;
  level.scr_face["price"]["dx_vom_pri_dining_room_entry_70"] = % dx_vom_pri_dining_room_entry_70_face;
  var3 = "frontdoor_start";
  level.scr_anim["bravo4_1"][var3] = % thd_1f_050_door_start_soldier02;
  level.scr_anim["bravo4_2"][var3] = % thd_1f_050_door_start_soldier03;
  level.scr_anim["bravo4_3"][var3] = % thd_1f_050_door_start_soldier04;
  var3 = "frontdoor_start_loop";
  level.scr_anim["bravo4_1"][var3][0] = % thd_1f_050_door_start_idle_soldier02;
  level.scr_anim["bravo4_2"][var3][0] = % thd_1f_050_door_start_idle_soldier03;
  level.scr_anim["bravo4_3"][var3][0] = % thd_1f_050_door_start_idle_soldier04;
  var3 = "frontdoor_enter";
  level.scr_anim["bravo4_1"][var3] = % thd_1f_050_door_enter_soldier02;
  scripts\common\anim::addnotetrack_customfunction("bravo4_1", "set_nvg_bool", &set_nvg_bool, var3);
  scripts\common\anim::addnotetrack_customfunction("bravo4_1", "front_door_open_sfx", &sfx_townhouse_door_audio_front_open, var3);
  level.scr_anim["bravo4_2"][var3] = % thd_1f_050_door_enter_soldier03;
  scripts\common\anim::addnotetrack_customfunction("bravo4_2", "set_nvg_bool", &set_nvg_bool, var3);
  level.scr_anim["bravo4_3"][var3] = % thd_1f_050_door_enter_soldier04;
  var3 = "frontdoor_enter_loop";
  level.scr_anim["bravo4_1"][var3][0] = % thd_1f_060_stairs_start_idle_soldier02;
  level.scr_anim["bravo4_2"][var3][0] = % thd_1f_060_stairs_start_idle_soldier03;
  level.scr_anim["bravo4_3"][var3][0] = % thd_1f_060_stairs_start_idle_soldier04;
  level.scr_anim["bravo4_3"]["frontdoor_enter_nag"] = % thd_1f_060_stairs_nag_soldier03;
}

function dining_room_chest_fx(var0) {
  var1 = scripts\engine\utility::getfx("blood_spurt");
  var2 = "j_spine4";
  var3 = var0 gettagorigin(var2);
  var4 = vectortoangles(level.player getEye() - var3);
  var5 = var0 gettagangles(var2);
  var6 = anglesToForward(var5);
  var7 = anglestoup(var5);
  var8 = anglestoright(var5);
  var9 = var3;
  var9 += var6 * 0;
  var9 += var7 * -4;
  var9 += var8 * 3;
  var10 = scripts\engine\utility::spawn_tag_origin(var9, var4);
  var10 linkTo(var0, var2);
  playFXOnTag(var1, var10, "tag_origin");
  var11 = gettime() + 5000;

  while(isalive(var0)) {
    if(gettime() > var11) {
      var11 = gettime() + 5000;
      playFXOnTag(var1, var10, "tag_origin");
    }

    waitframe();
  }

  var10 delete();
}

function set_nvg_bool(var0) {
  var0.visor_down = 1;
}

function use_death_long_end(var0) {
  var0.allowdeath = 1;
  var0.skipdeathanim = undefined;
  var0 scripts\engine\sp\utility::set_deathanim("dining_long_death_end");
}

function use_death_long_end2(var0) {
  var0.allowdeath = 1;
  var0.skipdeathanim = undefined;
  var0 scripts\engine\sp\utility::set_deathanim("dining_late_long_death_end2");
}

function use_late_long_death(var0) {
  var0 thread scripts\sp\maps\townhoused\townhoused_inner::dining_room_late_long_death();
}

function stop_late_long_death(var0) {
  var0 notify("stop_dining_room_late_long_death");
}

function attach_sidearm(var0) {
  var0 scripts\anim\shared::forceuseweapon(var0.sidearm, "sidearm");
}

function pickup_gun(var0) {
  var0 scripts\sp\anim_notetrack::gun_pickup_right();
}

function remove_dining_deathanim(var0) {
  var0.allowdeath = 1;
  var0 scripts\engine\sp\utility::clear_deathanim();
  var0 notify("stop_death_react_thread");
}

function remove_dining_deathanim_ragonly(var0) {
  var0 notify("stop_death_react_thread");
  var0 scripts\engine\sp\utility::clear_deathanim();
  allowdeath_just_ragdoll(var0);
}

function stairtrain1() {
  var0 = "price";
  var1 = "bravo4_1";
  var2 = "bravo4_2";
  var3 = "price";
  level.scr_anim[var3]["stairtrain1_arrive"] = % thd_1f_060_stairs_arrival_soldier01;
  scripts\common\anim::addnotetrack_customfunction(var3, "try_attack_vo", &stairtrain1_try_vo, "stairtrain1_arrive");
  level.scr_anim[var3]["stairtrain1_arrive_loop"][0] = % thd_1f_060_stairs_arrival_idle_soldier01;
  level.scr_anim[var3]["stairtrain1_start"] = % thd_1f_060_stairs_start_soldier01;
  level.scr_anim[var3]["stairtrain1_start_idle"][0] = % thd_1f_060_stairs_start_idle_soldier01;
  var4 = "stairtrain1_ascend";
  level.scr_anim[var0][var4] = % thd_1f_060_stairs_soldier01;
  level.scr_anim[var1][var4] = % thd_1f_060_stairs_soldier02;
  level.scr_anim[var2][var4] = % thd_1f_060_stairs_soldier03;
  scripts\common\anim::addnotetrack_flag(var2, "delete_clip", "stairtrain1_remove_clip", var4);
  var4 = "stairtrain1_ascend_additive_branch";
  level.scr_anim[var0][var4] = % townhouse_stair_additives;
  level.scr_anim[var1][var4] = % townhouse_stair_additives;
  level.scr_anim[var2][var4] = % townhouse_stair_additives;
  var4 = "stairtrain1_ascend_additive";
  level.scr_anim[var0][var4] = % thd_stair_train_idle_forward;
  level.scr_anim[var1][var4] = % thd_stair_train_idle_forward;
  level.scr_anim[var2][var4] = % thd_stair_train_idle_forward;
  var4 = "stairtrain1_ascend_settle";
  level.scr_anim[var0][var4] = % thd_stair_train_settle_02_forward;
  level.scr_anim[var1][var4] = % thd_stair_train_settle_02_forward;
  level.scr_anim[var2][var4] = % thd_stair_train_settle_02_forward;
  var4 = "stairtrain1_ascend_nag";
  level.scr_anim[var2][var4] = % thd_stair_train_nag_side_a;
  level.scr_anim["bravo4_4"]["stairtrain1_ascend"] = % thc_ff_060_stairs_soldier02;
  var5 = "boy";
  level.scr_anim[var5]["boy_bathroom"] = % thd_2f_010_clear_rooms_arrival_boy_1;
  scripts\common\anim::addnotetrack_flag(var5, "near_bathroom", "boy_near_bathroom", "boy_bathroom");
  level.scr_anim[var5]["boy_bathroom_loop"][0] = % thd_2f_010_clear_rooms_idle_boy_1;
  level.scr_anim[var2]["secure_boy"] = % thd_2f_010_clear_rooms_enter_secure_soldier_3;
  level.scr_anim[var2]["secure_boy_loop"][0] = % thd_2f_010_clear_rooms_enter_secure_idle_soldier_3;
  level.scr_anim[var5]["secure_boy"] = % thd_2f_010_clear_rooms_enter_secure_boy_1;
  level.scr_anim[var5]["secure_boy_loop"][0] = % thd_2f_010_clear_rooms_enter_secure_idle_boy_1;
  level.scr_face[var3]["dx_vom_pri_stairtrain1_rally_40"] = % dx_vom_pri_stairtrain1_rally_40_face;
  level.scr_face[var3]["dx_vom_pri_stairtrain1_rally_50"] = % dx_vom_pri_stairtrain1_rally_50_face;
  level.scr_face[var3]["dx_vom_pri_stairtrain1_rally_60"] = % dx_vom_pri_stairtrain1_rally_60_face;
  level.scr_face[var3]["dx_vom_pri_stairtrain1_rally_70"] = % dx_vom_pri_stairtrain1_rally_70_face;
  level.scr_face[var3]["dx_vom_pri_stairtrain1_rally_80"] = % dx_vom_pri_stairtrain1_rally_80_face;
  level.scr_face[var3]["dx_vom_pri_stairtrain1_rally_90"] = % dx_vom_pri_stairtrain1_rally_90_face;
}

function stairtrain_twitch_get() {
  var0 = [];
  GscBinSkip0(0x2e, var0.size, %thd_stair_train_twitch_01);
}

function stairtrain1_try_vo(var0) {
  if(!scripts\engine\utility::flag("dining_room_react")) {
    scripts\engine\sp\utility::smart_radio_dialogue("dx_vom_pri_dining_room_entry_10");
  }

  scripts\engine\utility::flag_set("dining_room_player_should_engage");
}

function stairtrain2() {
  var0 = "price";
  var1 = "bravo4_1";
  var2 = "bravo4_2";
  var3 = "price";
  level.scr_anim[var3]["stairtrain2_pre_arrive"] = % thd_2f_040_stairs_arrival_a_soldier01;
  level.scr_anim[var3]["stairtrain2_pre_arrive_loop"][0] = % thd_2f_040_stairs_arrival_a_idle_soldier01;
  level.scr_anim[var3]["stairtrain2_arrive"] = % thd_2f_040_stairs_arrival_b_soldier01;
  level.scr_anim[var3]["stairtrain2_arrive_loop"][0] = % thd_2f_040_stairs_idle_soldier01;
  level.scr_anim[var1]["stairtrain2_arrive"] = % thd_2f_040_stairs_arrival_b_soldier02;
  level.scr_anim[var1]["stairtrain2_arrive_loop"][0] = % thd_2f_040_stairs_idle_soldier02;
  level.scr_anim[var2]["stairtrain2_arrive"] = % thd_2f_040_stairs_arrival_b_soldier03;
  scripts\common\anim::addnotetrack_customfunction(var2, "remove_playerclip", &stairtrain2_remove_clip, "stairtrain2_arrive");
  level.scr_anim[var2]["stairtrain2_arrive_loop"][0] = % thd_2f_040_stairs_idle_soldier03;
  var4 = "stairtrain2_ascend";
  level.scr_anim[var0][var4] = % thd_2f_040_stairs_climb_soldier01;
  level.scr_anim[var1][var4] = % thd_2f_040_stairs_climb_soldier02;
  level.scr_anim[var2][var4] = % thd_2f_040_stairs_climb_soldier03;
  var4 = "stairtrain2_ascend_additive_branch";
  level.scr_anim[var0][var4] = % townhouse_stair_additives;
  level.scr_anim[var1][var4] = % townhouse_stair_additives;
  level.scr_anim[var2][var4] = % townhouse_stair_additives;
  var4 = "stairtrain2_ascend_additive";
  level.scr_anim[var0][var4] = % thd_stair_train_idle_forward;
  level.scr_anim[var1][var4] = % thd_stair_train_idle_forward;
  level.scr_anim[var2][var4] = % thd_stair_train_idle_forward;
  var4 = "stairtrain2_ascend_settle";
  level.scr_anim[var0][var4] = % thd_stair_train_settle_02_forward;
  level.scr_anim[var1][var4] = % thd_stair_train_settle_02_forward;
  level.scr_anim[var2][var4] = % thd_stair_train_settle_02_forward;
  level.scr_face[var0]["dx_vom_pri_stairtrain2_rally_10"] = % dx_vom_pri_stairtrain2_rally_10_face;
  level.scr_face[var0]["dx_vom_pri_stairtrain2_rally_20"] = % dx_vom_pri_stairtrain2_rally_20_face;
  level.scr_face[var0]["dx_vom_pri_stairtrain2_rally_30"] = % dx_vom_pri_stairtrain2_rally_30_face;
  level.scr_face[var0]["dx_vom_pri_stairtrain2_rally_40"] = % dx_vom_pri_stairtrain2_rally_40_face;
  level.scr_face[var0]["dx_vom_pri_stairtrain2_rally_50"] = % dx_vom_pri_stairtrain2_rally_50_face;
}

function stairtrain2_remove_clip(var0) {
  var1 = getEnt("2nd_floor_door_playerclip", "targetname");
  var1 delete();
}

function stairtrain3() {
  var0 = "price";
  var1 = "bravo4_4";
  var2 = "stairtrain3_ascend";
  level.scr_anim[var0][var2] = % thd_3f_030_stairs_climb_price;
  level.scr_anim[var1][var2] = % thd_3f_030_stairs_climb_sas03;
  var2 = "stairtrain3_ascend_additive_branch";
  level.scr_anim[var0][var2] = % townhouse_stair_additives;
  level.scr_anim[var1][var2] = % townhouse_stair_additives;
  var2 = "stairtrain3_ascend_additive";
  level.scr_anim[var0][var2] = % thd_stair_train_idle_forward;
  level.scr_anim[var1][var2] = % thd_stair_train_idle_forward;
  var2 = "stairtrain3_ascend_settle";
  level.scr_anim[var0][var2] = % thd_stair_train_settle_02_forward;
  level.scr_anim[var1][var2] = % thd_stair_train_settle_02_forward;
  level.scr_face[var0]["dx_vom_pri_stairtrain3_rally_60"] = % dx_vom_pri_stairtrain3_rally_60_face;
  level.scr_face[var0]["dx_vom_pri_stairtrain3_rally_70"] = % dx_vom_pri_stairtrain3_rally_70_face;
  level.scr_face[var0]["dx_vom_pri_stairtrain3_rally_80"] = % dx_vom_pri_stairtrain3_rally_80_face;
  level.scr_face[var0]["dx_vom_pri_stairtrain3_rally_20"] = % dx_vom_pri_stairtrain3_rally_20_face;
  level.scr_face[var0]["dx_vom_pri_stairtrain3_rally_30"] = % dx_vom_pri_stairtrain3_rally_30_face;
  level.scr_face[var0]["dx_vom_pri_stairtrain3_rally_40"] = % dx_vom_pri_stairtrain3_rally_40_face;
}

function second_floor_bedroom() {
  var0 = "price";
  var1 = "bravo4_1";
  var2 = "bedroom_enemy";
  var3 = "bravo4_2";
  level.scr_anim[var0]["2ndfloor_arrive"] = % thd_2f_010_clear_rooms_arrival_soldier_1;
  level.scr_anim[var0]["2ndfloor_arrive_loop"][0] = % thd_2f_010_clear_rooms_idle_soldier_1;
  level.scr_anim[var1]["2ndfloor_bedroom_arrive"] = % thd_2f_010_clear_rooms_arrival_soldier_2;
  level.scr_anim[var1]["2ndfloor_bedroom_arrive_loop"][0] = % thd_2f_010_clear_rooms_idle_soldier_2;
  level.scr_anim[var1]["2ndfloor_bedroom_enter"] = % thd_2f_010_clear_rooms_enter_soldier_2;
  scripts\common\anim::addnotetrack_customfunction(var1, "2nd_floor_bedroom_open_door_sfx", &sfx_townhouse_door_audio_2nd_floor_bedroom, "2ndfloor_bedroom_enter");
  scripts\common\anim::addnotetrack_customfunction(var1, "2nd_floor_bedroom_bash_door_sfx", &sfx_townhouse_door_audio_2nd_floor_bedroom_bash, "2ndfloor_bedroom_enter");
  level.scr_anim[var1]["2ndfloor_bedroom_enter_loop"][0] = % thd_2f_010_clear_rooms_idle_2_soldier_2;
  scripts\common\anim::addnotetrack_customfunction(var1, "open_door2", &second_floor_bedroom_door2, "2ndfloor_bedroom_enter");
  scripts\common\anim::addnotetrack_customfunction(var1, "check_stop", &second_floor_bedroom_check_stop, "2ndfloor_bedroom_enter");
  scripts\common\anim::addnotetrack_customfunction(var1, "scripted_fire", &second_floor_bedroom_fire, "2ndfloor_bedroom_enter");
  level.scr_anim[var2]["2ndfloor_bedroom_enter"] = % thd_2f_010_clear_rooms_enter_enemy;
  scripts\common\anim::addnotetrack_customfunction(var2, "skipdeathanim", &set_skipdeathanim, "2ndfloor_bedroom_enter");
  scripts\common\anim::addnotetrack_customfunction(var2, "scripted_fire", &second_floor_bedroom_fire, "2ndfloor_bedroom_enter");
  scripts\common\anim::addnotetrack_customfunction(var2, "kill_me", &kill_me_ragdoll, "2ndfloor_bedroom_enter");
  level.scr_anim[var3]["2ndfloor_bathroom_arrive"] = % thd_2f_010_clear_rooms_arrival_soldier_3;
  level.scr_anim[var3]["2ndfloor_bathroom_arrive_loop"][0] = % thd_2f_010_clear_rooms_idle_soldier_3;
  level.scr_anim[var3]["2ndfloor_bathroom_enter"] = % thd_2f_010_clear_rooms_enter_soldier_3;
  scripts\common\anim::addnotetrack_customfunction(var3, "2nd_floor_bathroom_open_door_sfx", &sfx_townhouse_door_audio_2nd_floor_bathroom, "2ndfloor_bathroom_enter");
  level.scr_anim[var3]["2ndfloor_bathroom_enter_loop"][0] = % thd_2f_010_clear_rooms_idle_2_soldier_3;
}

function set_skipdeathanim(var0) {
  var0.skipdeathanim = 1;
}

function second_floor_bedroom_fire(var0) {
  var0 notify("stop_prev_bedroom_fire");
  var0 endon("stop_prev_bedroom_fire");

  if(getdvarint("scr_reveal") > 0) {
    if(var0.animname == "bedroom_enemy") {
      thread second_floor_bedroom_reveal_fire(var0);
      return;
    }

    return;
  }

  if(!isDefined(var0.scriptfirecount)) {
    var0.scriptfirecount = 0;
  }

  var0.scriptfirecount++;

  if(var0.scriptfirecount < 4) {
    thread second_floor_enemy_bulletshield();
  }

  var0 thread scripts\anim\notetracks::shootnotetrack();
}

function second_floor_enemy_bulletshield() {
  var0 = scripts\engine\sp\utility::get_living_ai("bedroom_enemy", "animname");

  if(!isDefined(var0)) {
    return;
  }

  var0.damageshield = 1;
  waitframe();
  var0.damageshield = 0;
}

function second_floor_bedroom_reveal_fire(var0) {
  var1 = "tag_flash";
  var2 = var0 gettagorigin(var1);
  var3 = anglesToForward(var0 gettagangles(var1));
  var4 = var2 + var3 * 60;
  magicbullet(var0.weapon, var2, var4, var0);
  playFXOnTag(scripts\engine\utility::getfx("sas_muzzle_flash"), var0, var1);
  var5 = getEntArray("2nd_floor_muzzle_light", "targetname");

  foreach(var7 in var5) {
    thread second_floor_follow_tag_flash(var0);
    var7 setlightintensity(0.2);
    var7 setlightcolor(var7.flash_color * randomfloatrange(0.98, 1));
  }

  waitframe();

  foreach(var7 in var5) {
    var7 setlightintensity(0);
  }
}

function second_floor_follow_tag_flash(var0) {
  if(isDefined(var0.owner) && var0.owner == self) {
    return;
  }

  level notify("stop_second_floor_follow_tag_flash");
  level endon("stop_second_floor_follow_tag_flash");
  var1 = "tag_flash";
  var2 = 4;

  for(;;) {
    var3 = anglesToForward(self gettagangles(var1));
    var4 = self gettagorigin(var1) + var3 * var2;
    var5 = anglesToForward(var0.angles);
    var4 += var5 * 1;
    var0.origin = var4;
    waitframe();
  }
}

function second_floor_bedroom_door2(var0) {
  var1 = scripts\engine\utility::getStruct("2ndfloor_bedroom_animnode", "targetname");
  var2 = scripts\sp\door::get_interactive_door("2ndfloor_back_bedroom_door2");
  var1 thread scripts\sp\maps\townhoused\townhoused_code::anim_door(var2, "2ndfloor_bedroom_enter2");
}

function second_floor_bedroom_check_stop(var0) {
  var1 = getEnt("back_bedroom_volume", "targetname");

  if(level.player istouching(var1)) {
    var2 = scripts\engine\utility::getStruct("2ndfloor_bedroom_animnode", "targetname");
    var2 notify("stop_second_floor_loop");
    scripts\engine\sp\utility::anim_stopanimScripted();
    self setgoalpos(self.origin);
    return;
  }
}

function hostage_room() {
  var0 = "hostage_enemy";
  var1 = "hostage";
  level.scr_anim[var0]["hostage_loop"][0] = % thd_2f_020_hostage_alqatala_idle;
  level.scr_anim[var1]["hostage_loop"][0] = % thd_2f_020_hostage_civ_idle;
  level.scr_anim[var0]["hostage_aim_loop"][0] = % thd_2f_020_hostage_alqatala_aim;
  level.scr_anim[var1]["hostage_aim_loop"][0] = % thd_2f_020_hostage_civ_aim;
  level.scr_anim[var0]["hostage_aim_2_knob"] = % thd_hostage_aim_2;
  level.scr_anim[var0]["hostage_aim_2"] = % thd_2f_020_hostage_alqatala_aim_2;
  level.scr_anim[var0]["hostage_aim_4_knob"] = % thd_hostage_aim_4;
  level.scr_anim[var0]["hostage_aim_4"] = % thd_2f_020_hostage_alqatala_aim_4;
  level.scr_anim[var0]["hostage_aim_5"] = % thd_2f_020_hostage_alqatala_aim;
  level.scr_anim[var0]["hostage_aim_6_knob"] = % thd_hostage_aim_6;
  level.scr_anim[var0]["hostage_aim_6"] = % thd_2f_020_hostage_alqatala_aim_6;
  level.scr_anim[var0]["hostage_aim_8_knob"] = % thd_hostage_aim_8;
  level.scr_anim[var0]["hostage_aim_8"] = % thd_2f_020_hostage_alqatala_aim_8;
  level.scr_anim[var0]["enemy_live"] = % thd_2f_020_hostage_alqatala_live;
  level.scr_anim[var1]["enemy_live"] = % thd_2f_020_hostage_civ_death;
  scripts\common\anim::addnotetrack_customfunction(var1, "kill_me", &kill_me_ragdoll, "enemy_live");
  level.scr_anim[var0]["hostage_live"] = % thd_2f_020_hostage_alqatala_death;
  scripts\common\anim::addnotetrack_customfunction(var0, "allowdeath", &enable_allowdeath, "hostage_live");
  scripts\common\anim::addnotetrack_customfunction(var0, "kill_me", &kill_me_ragdoll_nosound, "hostage_live");
  scripts\common\anim::addnotetrack_customfunction(var0, "neck_fx", &hostage_enemy_fx, "hostage_live");
  level.scr_anim[var0]["hostage_headshot"] = % sdr_com_exposed_stand_death05_head_md_2;
  level.scr_anim[var1]["hostage_live"] = % thd_2f_020_hostage_civ_live;
  scripts\common\anim::addnotetrack_attach_gun(var1, "grab_gun", "hostage_live");
  scripts\common\anim::addnotetrack_customfunction(var1, "grab_gun", &hostage_turn_to_enemy, "hostage_live");
  scripts\common\anim::addnotetrack_customfunction(var1, "use_death", &remove_skipdeathanim, "hostage_live");
  scripts\common\anim::addnotetrack_customfunction(var1, "allow_long_death", &hostage_allow_long_death, "hostage_live");
  var2 = "hostage_live_long_death";
  level.scr_anim[var1][var2] = % thd_2f_020_hostage_civ_death_long;
  scripts\common\anim::addnotetrack_customfunction(var1, "allowdeath", &enable_allowdeath, var2);
  scripts\common\anim::addnotetrack_customfunction(var1, "kill_me", &kill_me_ragdoll_nosound, var2);
  scripts\common\anim::addnotetrack_customfunction(var1, "hit_wall", &hostage_hit_wall, var2);
  scripts\common\anim::addnotetrack_customfunction(var1, "elbow_hit_wall", &hostage_elbow_hit_wall, var2);
  level.scr_anim[var1]["hostage_live_headshot"] = % thd_2f_020_hostage_civ_death_headshot;
  level.scr_face[var1]["dx_vom_aqf2_2nd_floor_aq_convo4_30"] = % dx_vom_aqf2_2nd_floor_aq_convo4_30_face;
  level.scr_face[var1]["dx_vom_aqf2_2nd_floor_bedroom2_60"] = % dx_vom_aqf2_2nd_floor_bedroom2_60_face;
}

function hostage_hit_wall(var0) {}

function hostage_elbow_hit_wall(var0) {}

function hostage_enemy_fx(var0) {
  var1 = var0.damagelocation;

  if(!isDefined(var0.damagelocation)) {
    return;
  }

  switch (var0.damagelocation) {
    case "left_arm_upper":
    case "torso_upper":
    case "neck":
    case "helmet":
    case "head":
      break;
    default:
      return;
  }

  var2 = scripts\engine\utility::getfx("blood_spurt");
  var3 = "j_neck";
  var4 = var0 gettagorigin(var3);
  var5 = vectortoangles(level.player getEye() - var4);
  var6 = var5 + (0, 90, 0);
  var7 = scripts\engine\utility::spawn_tag_origin(var4, var5);
  var7 linkTo(var0, var3);
  var8 = anglesToForward(var6);
  var9 = getcompleteweaponname("iw8_ar_decalmaker");
  magicbullet(var9, var7.origin + var8 * 20, var7.origin);
  playFXOnTag(var2, var7, "tag_origin");
  var10 = gettime() + 5000;

  while(isalive(var0)) {
    if(gettime() > var10) {
      var10 = gettime() + 5000;
      playFXOnTag(var2, var7, "tag_origin");
    }

    waitframe();
  }

  var7 delete();
}

function hostage_allow_long_death(var0) {
  var0.allowdeath = 0;
  var0.health = 180;
  var0.skipdeathanim = 1;
  var0.deathfunction = &scripts\sp\maps\townhoused\townhoused_inner::hostage_death_with_gun;
  var1 = scripts\engine\utility::getStruct("hostage_animnode", "targetname");
  var0 thread scripts\engine\utility::thread_on_notify("longdeath", &scripts\engine\sp\utility::smart_dialogue, "dx_vom_aqf2_2nd_floor_bedroom2_52");
  var1 = scripts\engine\utility::getStruct("hostage_animnode", "targetname");
  var1 thread scripts\sp\maps\townhoused\townhoused_code::anim_long_death_relative(var0, "hostage_live_long_death", 10, &scripts\sp\maps\townhoused\townhoused_inner::hostage_death_counter);
}

function hostage_ondeath_remove_linkedents(var0) {
  var1 = var0.linkedents;
  var0 waittill("death");
  wait 0.5;
  scripts\engine\utility::array_delete(var1);
}

function hostage_turn_to_enemy(var0) {
  var0.team = "axis";
  var0 thread scripts\sp\maps\townhoused\townhoused_code::golden_enemydamage();
  var0 thread scripts\sp\maps\townhoused\townhoused_code::golden_enemydeath();
}

function bathroom_enemy() {
  var0 = "bathroom_guy";
  level.scr_anim[var0]["bathroom_loop"][0] = % thd_2f_030_bathroom_idle;
  level.scr_anim[var0]["bathroom_shoot"] = % thd_2f_030_bathroom_shoot;
  scripts\common\anim::addnotetrack_customfunction(var0, "scripted_fire", &direct_shoot, "bathroom_shoot");
  level.scr_anim[var0]["bathroom_crouch"] = % thd_2f_030_bathroom_ai;
  scripts\common\anim::addnotetrack_customfunction(var0, "remove_deathanim", &bathroom_stop_deathanim, "bathroom_crouch");
  level.scr_anim[var0]["bathroom_death"] = % thd_2f_030_bathroom_dead;
}

function bathroom_stop_deathanim(var0) {
  remove_deathanim(var0);
  var0.deathfunction = undefined;
}

function direct_shoot(var0) {
  var0 shoot(1, undefined, 1, 1);
}

function baby_room() {
  var0 = "price";
  var1 = "bravo4_4";
  var2 = "baby_mom";
  level.scr_anim[var1]["baby_mom_arrive"] = % thd_4f_010_setup_sas03;
  scripts\common\anim::addnotetrack_customfunction(var1, "4th_floor_bathroom_open_door_sfx", &sfx_townhouse_door_audio_4th_floor_bathroom, "baby_mom_arrive");
  scripts\common\anim::addnotetrack_flag(var1, "allow_end", "fourth_floor_bravo4_4_ready", "baby_mom_arrive");
  level.scr_anim[var1]["baby_mom_arrive_loop"][0] = % thd_4f_010_setup_idle_sas03;
  level.scr_anim[var0]["baby_mom_arrive"] = % thd_4f_010_setup_price;
  level.scr_anim[var0]["baby_mom_breakdown"] = % thd_4f_010_setup_breakdown_price;
  level.scr_anim[var0]["baby_mom_breakdown_idle"] = % thd_4f_010_setup_breakdown_idle_price;
  level.scr_anim[var0]["baby_mom_breakdown_idle_as_loop"][0] = % thd_4f_010_setup_breakdown_idle_price;
  level.scr_anim[var0]["baby_mom_breakdown_nag"] = % thd_4f_010_setup_breakdown_nag_price;
  var3 = "grab_baby";
  level.scr_anim[var1][var3] = % thd_4f_020_baby_enter_ally01;
  scripts\common\anim::addnotetrack_customfunction(var1, "try_early_mom_death", &bravo4_4_try_early_mom_death, var3);
  scripts\common\anim::addnotetrack_customfunction(var1, "open_door", &bravo4_4_open_baby_door, var3);
  scripts\common\anim::addnotetrack_customfunction(var1, "use_stand_death_react", &bravo4_4_use_stand_death_react, var3);
  scripts\common\anim::addnotetrack_customfunction(var1, "use_death_react", &bravo4_4_use_death_react, var3);
  level.scr_anim[var2][var3] = % thd_4f_020_baby_enter_civ01;
  scripts\common\anim::addnotetrack_customfunction(var2, "vo_dx_vom_aqf3_4th_floor_bedroom_70", &baby_mom_vo, var3);
  scripts\common\anim::addnotetrack_customfunction(var2, "switch_to_allies", &set_as_innocent, var3);
  scripts\common\anim::addnotetrack_customfunction(var2, "use_move_death", &baby_mom_use_move_death, var3);
  scripts\common\anim::addnotetrack_customfunction(var2, "remove_deathanim", &baby_mom_remove_death, var3);
  scripts\common\anim::addnotetrack_customfunction(var2, "use_stand_death", &baby_mom_stand_death, var3);
  scripts\common\anim::addnotetrack_customfunction(var2, "use_normal_death", &baby_mom_normal_death, var3);
  level.scr_anim[var1]["grab_baby_loop"][0] = % thd_4f_020_baby_enter_idle_ally01;
  level.scr_anim[var1]["grab_baby_death"] = % thd_4f_020_baby_death_ally01;
  level.scr_anim[var1]["grab_baby_death_interrupt"] = % thd_4f_020_baby_interrupt_ally01;
  level.scr_anim[var1]["grab_baby_death_idle"][0] = % thd_4f_020_baby_death_idle_ally01;
  level.scr_anim[var1]["grab_baby_stand_death"] = % thd_4f_020_baby_stand_death_ally01;
  level.scr_anim[var1]["grab_baby_stand_death_idle"][0] = % thd_4f_020_baby_stand_death_idle_ally01;
  level.scr_anim[var2]["grab_baby_stand_death"] = % thd_4f_020_baby_stand_death_civ01;
  level.scr_model[var2 + "_head"] = "head_sc_f_daly_blendshape";
  level.scr_face[var2]["dx_vom_aqf3_4th_floor_bedroom_94"] = % dx_vom_aqf3_4th_floor_bedroom_94_face;
  level.scr_face[var2]["dx_vom_aqf3_4th_floor_bedroom_95"] = % dx_vom_aqf3_4th_floor_bedroom_95_face;
  level.scr_face[var2]["dx_vom_aqf3_4th_floor_bedroom_96"] = % dx_vom_aqf3_4th_floor_bedroom_96_face;
  level.scr_anim[var2]["grab_baby_loop"][0] = % thd_4f_020_baby_enter_idle_civ01;
  level.scr_anim[var2]["grab_baby_loop_ads_react"] = % thd_4f_020_baby_react_civ01;
  level.scr_anim[var2]["grab_baby_death"] = % thd_4f_020_baby_death_civ01;
  scripts\common\anim::addnotetrack_customfunction(var2, "kill_me", &kill_me_no_anim, "grab_baby_death");
  var3 = "grab_baby_mom_early_death";
  level.scr_anim[var1][var3] = % thd_4f_020_baby_enter_alt_ally01;
  level.scr_anim[var1]["grab_baby_mom_early_death_idle"][0] = % thd_4f_020_baby_enter_alt_idle_ally01;
  level.scr_anim[var1]["grab_baby_pickup_early"] = % thd_4f_020_baby_pickup_ally01;
  level.scr_anim[var2]["grab_baby_pickup_early"] = % thd_4f_020_baby_pickup_civ01;
  scripts\common\anim::addnotetrack_customfunction(var2, "kill_me", &kill_me_no_anim, "grab_baby_pickup_early");
  level.scr_face[var0]["dx_vom_pri_4th_floor_bedroom_110"] = % dx_vom_pri_4th_floor_bedroom_110_face;
  level.scr_face[var0]["dx_vom_pri_4th_floor_bedroom_120"] = % dx_vom_pri_4th_floor_bedroom_120_face;
  level.scr_face[var0]["dx_vom_pri_4th_floor_bedroom_130"] = % dx_vom_pri_4th_floor_bedroom_130_face;
  level.scr_face[var0]["dx_vom_pri_4th_floor_bedroom_140"] = % dx_vom_pri_4th_floor_bedroom_140_face;
}

function bravo4_4_open_baby_door(var0) {
  var1 = scripts\sp\door::get_interactive_door("baby_room_door");
  var0 scripts\sp\maps\townhoused\townhoused_code::ai_try_open_door(var1);
}

function baby_mom_anim_random() {
  var0 = ["grab_baby"];
  var1 = var0[0];

  if(var0.size > 1) {
    var0 = scripts\engine\utility::array_randomize(var0);

    if(getDvar("scr_townhouse_last_babymom_anim") == var0[0]) {
      var1 = var0[1];
    }
  }

  setDvar("scr_townhouse_last_babymom_anim", var1);
  return var1;
}

function baby_mom_anim_get(var0) {
  var1 = undefined;
  var1 = spawnStruct();

  switch (var0) {
    case "grab_baby":
      var1.startanime = "grab_baby";
      var1.idleanime = "grab_baby_loop";
      var1.idlereactanime = "grab_baby_loop_ads_react";
      var1.deathanime = "grab_baby_death";
      break;
  }

  return var1;
}

function baby_mom_is_ads() {
  return false;
}

function baby_mom_vo(var0) {
  var0 endon("death");
  var0 endon("scripted_death");
  wait lookupsoundlength("dx_vom_aqf3_4th_floor_bedroom_70") / 1000;
  var0 scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf3_4th_floor_bedroom_75");
  var0 scripts\engine\sp\utility::smart_dialogue("dx_vom_aqf3_4th_floor_bedroom_77");
}

function baby_mom_use_move_death(var0) {
  var0.skipdeathanim = undefined;
}

function baby_mom_remove_death(var0) {
  var0 scripts\engine\sp\utility::clear_deathanim();
}

function bravo4_4_try_early_mom_death(var0) {
  if(scripts\sp\maps\townhoused\townhoused_code::isscriptedalive(level.baby_mom)) {
    var0.momdeathreact_anime = "grab_baby_death_interrupt";
    return;
  }

  var1 = scripts\engine\utility::getStruct("baby_room_animnode", "targetname");
  var0 scripts\engine\sp\utility::anim_stopanimScripted();

  if(!scripts\sp\maps\townhoused\townhoused_code::isscriptedalive(level.baby_mom) && scripts\engine\utility::flag("baby_picked_up")) {
    var1 scripts\common\anim::anim_single_solo(var0, "grab_baby_pickup_early");
    var2 = spawnStruct();
    var3 = level.scr_anim[var0.animname]["grab_baby_mom_early_death_idle"][0];
    var4 = getstartorigin(var1.origin, var1.angles, var3);
    var5 = getstartangles(var1.origin, var1.angles, var3);
    var6 = rotatevectorinverted(var1.origin - var4, var5);
    var7 = var1.angles - var5;
    var2.origin = var0.origin + rotatevector(var6, var0.angles);
    var2.angles = var0.angles + var7;
    var2 thread scripts\common\anim::anim_loop_solo(var0, "grab_baby_mom_early_death_idle");
    return;
  }

  var1 thread scripts\sp\maps\townhoused\townhoused_code::anim_then_loop_solo(var0, "grab_baby_mom_early_death");
}

function bravo4_4_use_stand_death_react(var0) {
  var0.momdeathreact_anime = "grab_baby_stand_death";
}

function bravo4_4_use_death_react(var0) {
  var0.momdeathreact_anime = "grab_baby_death";
}

function baby_mom_stand_death(var0) {
  scripts\engine\utility::flag_set("baby_picked_up");
  var0 scripts\engine\utility::ent_flag_set("can_fastforward");
  var0.deathanime = "grab_baby_stand_death";
}

function baby_mom_normal_death(var0) {
  var0.deathanime = "grab_baby_death";
}

function baby_pickup_by_allyanim(var0, var1) {
  var0 scripts\common\anim::anim_single_solo(level.baby_mom.baby, var1);
  thread scripts\sp\maps\townhoused\townhoused_inner::baby_idle_relative("grab_baby_pickup_early_idle");
}

function baby_pickup_early_time_adjust(var0, var1) {
  self setanimtime(scripts\engine\utility::getanim(var0), var1);
}

function baby_room_unlink_baby(var0) {
  var1 = getEnt("baby", "targetname");
  var1 unlink();
}

function set_team_axis(var0) {
  var0.team = "axis";
  var0.skipdeathanim = 1;
  var0.a.nodeath = 1;
}

function set_team_allies(var0) {
  var0.team = "allies";
}

function set_as_innocent(var0) {
  var0.team = "allies";
  thread innocent_damage_thread();
}

function innocent_damage_thread() {
  self waittill("damage", var0, var1);

  if(!isPlayer(var1)) {
    return;
  }

  level.custom_friendly_fire_message = 30;
  scripts\sp\player_death::set_custom_death_quote(30);
  scripts\sp\utility::missionfailedwrapper();
}

function bed_guy() {
  var0 = "bed_guy";
  level.scr_anim[var0]["corner_idle"][0] = % thd_4f_030_bed_start_idle_enemy01;
  level.scr_anim[var0]["hide_under_bed"] = % thd_4f_030_bed_start_enemy01;
  scripts\common\anim::addnotetrack_customfunction(var0, "allowdeath", &bed_guy_deathanim, "hide_under_bed");
  level.scr_anim[var0]["hide_under_bed_alt"] = % thd_4f_030_bed_start_b_enemy01;
  level.scr_anim[var0]["hide_under_bed_loop"][0] = % thd_4f_030_bed_idle_enemy01;
  level.scr_anim[var0]["hide_under_bed_death"] = % thd_4f_030_bed_death_enemy01;
  scripts\common\anim::addnotetrack_customfunction(var0, "hack_dropgun", &bed_guy_dropgun, "hide_under_bed_death");
  level.scr_anim[var0]["under_bed_aim_2_knob"] = % thd_underbed_aim_2;
  level.scr_anim[var0]["under_bed_aim_4_knob"] = % thd_underbed_aim_4;
  level.scr_anim[var0]["under_bed_aim_6_knob"] = % thd_underbed_aim_6;
  level.scr_anim[var0]["under_bed_aim_8_knob"] = % thd_underbed_aim_8;
  level.scr_anim[var0]["under_bed_aim_fire_knob"] = % thd_underbed_shoot;
  level.scr_anim[var0]["under_bed_aim_2"] = % thd_4f_030_bed_aim_2_enemy01;
  level.scr_anim[var0]["under_bed_aim_4"] = % thd_4f_030_bed_aim_4_enemy01;
  level.scr_anim[var0]["under_bed_aim_5"] = % thd_4f_030_bed_idle_enemy01;
  level.scr_anim[var0]["under_bed_aim_6"] = % thd_4f_030_bed_aim_6_enemy01;
  level.scr_anim[var0]["under_bed_aim_8"] = % thd_4f_030_bed_aim_8_enemy01;
  level.scr_anim[var0]["under_bed_aim_fire"] = % thd_4f_030_bed_shoot_enemy01;
  level.scr_anim[var0]["under_bed_flash_knob"] = % thd_generic_flash_react;
  level.scr_anim[var0]["under_bed_flash"] = % thd_soldier_additive_flash_bang;
}

function bed_guy_dropgun(var0) {
  var0.nodrop = 0;
  var0 waittill("death");
  var1 = var0.weapon;
  var0 scripts\anim\shared::detachallweaponmodels();
  var2 = "tag_weapon_right";
  var3 = var0 gettagorigin(var2) + (0, 0, 2);
  var4 = var0 gettagangles(var2);
  var5 = spawn("weapon_" + createheadicon(var1), var3);
  var5.angles = var4;
  waitframe();
  var6 = var0 gettagorigin(var2) + (0, 0, 2);
  var7 = vectorNormalize(var3 - var6) * 40;
  var5 physicslaunchserveritem(var5.origin, var7);
}

function bed_guy_deathanim(var0) {
  var0.allowdeath = 1;
  var0.deathanimmode = "noclip";
  var0.deathfunction = &bed_guy_blood_pool;
  thread bed_guy_dropgun(level);
  var0 scripts\engine\sp\utility::set_deathanim("hide_under_bed_death");
}

function bed_guy_blood_pool() {
  self.disabledeathorient = 1;
  self.skipbloodpool = 1;
  var0 = self gettagorigin("j_neck");
  playFX(level._effect["deathfx_bloodpool_generic"], var0);
  return false;
}

function buddy_down() {
  var0 = "price";
  var1 = "bravo4_1";
  var2 = "bravo4_2";
  var3 = "bravo4_4";
  var4 = "buddy_down_intro";
  level.scr_anim[var0][var4] = % thd_3f_020_buddy_down_a_price;
  scripts\common\anim::addnotetrack_customfunction(var0, "3rd_floor_price_push_open_door_sfx", &sfx_townhouse_door_audio_3rd_floor_price, "buddy_down_intro");
  level.scr_anim[var1][var4] = % thd_3f_020_buddy_down_a_sas01;
  level.scr_anim[var2][var4] = % thd_3f_020_buddy_down_a_sas02;
  scripts\common\anim::addnotetrack_customfunction(var2, "3rd_floor_sound_from_above", &sfx_townhouse_audio_3rd_floor_sound_look_at, "buddy_down_intro");
  var4 = "buddy_down_intro_loop";
  level.scr_anim[var0][var4][0] = % thd_3f_020_buddy_down_a_idle_price;
  level.scr_anim[var1][var4][0] = % thd_3f_020_buddy_down_a_idle_sas01;
  level.scr_anim[var2][var4][0] = % thd_3f_020_buddy_down_a_idle_sas02;
  var4 = "buddy_down";
  level.scr_anim[var1][var4] = % thd_3f_020_buddy_down_b_sas01;
  level.scr_anim[var2][var4] = % thd_3f_020_buddy_down_b_sas02;
  scripts\common\anim::addnotetrack_flag(var2, "buddy_down_break", "buddy_down_enemy_dead", var4);
  scripts\common\anim::addnotetrack_flag(var2, "shoot_buddy_down_vo", "shoot_buddy_down_vo", var4);
  scripts\common\anim::addnotetrack_flag(var2, "shoot_buddy_down", "shoot_buddy_down", var4);
  scripts\common\anim::addnotetrack_flag(var2, "price_dialogue", "buddy_down_price_dialogue", var4);
  scripts\common\anim::addnotetrack_customfunction(var2, "dropgun_scripted", &buddy_down_dropgun, var4);
  scripts\common\anim::addnotetrack_customfunction(var2, "buddy_lookat_sfx", &sfx_townhouse_audio_3rd_floor_buddy_down_look_at, "buddy_down");
  var4 = "buddy_down_loop";
  level.scr_anim[var1][var4][0] = % thd_3f_020_buddy_down_b_idle_sas01;
  level.scr_anim[var2][var4][0] = % thd_3f_020_buddy_down_b_idle_sas02;
  var4 = "buddy_down_drag";
  level.scr_anim[var1][var4] = % thd_3f_020_buddy_down_c_sas01;
  level.scr_anim[var2][var4] = % thd_3f_020_buddy_down_c_sas02;
  level.scr_anim[var3][var4] = % thd_3f_020_buddy_down_c_sas03;
  scripts\common\anim::addnotetrack_customfunction(var3, "remove_playerclip", &buddy_down_remove_playerclip, var4);
  level.scr_anim[var3][var4 + "_loop"][0] = % thd_3f_020_buddy_down_c_idle_sas03;
  var4 = "buddy_down_drag_loop";
  level.scr_anim[var1][var4][0] = % thd_3f_020_buddy_down_c_idle_sas01;
  level.scr_anim[var2][var4][0] = % thd_3f_020_buddy_down_c_idle_sas02;
  var4 = "buddy_down_after";
  level.scr_anim[var0][var4] = % thd_3f_020_buddy_down_c_price;
  var4 = "buddy_down_after_loop";
  level.scr_anim[var0][var4][0] = % thd_3f_020_buddy_down_c_idle_price;
  var5 = "generic";
  level.scr_anim[var5]["gunner_couch_death"] = % thd_3f_010_couch_death_long_enemy01;
  scripts\common\anim::addnotetrack_customfunction(var5, "kill_me", &kill_me_ragdoll_nosound, "gunner_couch_death");
  scripts\common\anim::addnotetrack_customfunction(var5, "allowdeath", &enable_allowdeath, var4);
  level.scr_anim[var5]["gunner_couch_death_end"] = % thd_3f_010_couch_death_shot_enemy01;
  level.scr_anim[var5]["fake_flash"] = % thd_3f_010_couch_flash_intro_enemy01;
  level.scr_anim[var5]["fake_flash_idle"][0] = % thd_3f_010_couch_flash_loop_enemy01;
  level.scr_goaltime[var5]["fake_flash_react"] = 0.2;
  level.scr_anim[var5]["fake_flash_react"] = % thd_3f_010_couch_flash_end_enemy01;
  level.scr_anim[var5]["demo_shotgun_death"] = % sdr_com_exp_stand_death02_head_lg_2;
  level.scr_face[var0]["dx_vom_pri_3rd_floor_bedroom_20"] = % dx_vom_pri_3rd_floor_bedroom_20_face;
  level.scr_face[var0]["dx_vom_pri_3rd_floor_bedroom_30"] = % dx_vom_pri_3rd_floor_bedroom_30_face;
  level.scr_face[var0]["dx_vom_pri_3rd_floor_bedroom_50"] = % dx_vom_pri_3rd_floor_bedroom_50_face;
  level.scr_face[var0]["dx_vom_pri_3rd_floor_bedroom_60"] = % dx_vom_pri_3rd_floor_bedroom_60_face;
  level.scr_face[var0]["dx_vom_pri_3rd_floor_bedroom_70"] = % dx_vom_pri_3rd_floor_bedroom_70_face;
  level.scr_face[var0]["dx_vom_pri_3rd_floor_bedroom_110"] = % dx_vom_pri_3rd_floor_bedroom_110_face;
  level.scr_face[var0]["dx_vom_pri_3rd_floor_bedroom_120"] = % dx_vom_pri_3rd_floor_bedroom_120_face;
}

function buddy_down_dropgun(var0) {
  var1 = "iw8_ar_kilo433";
  var2 = scripts\sp\utility::make_weapon(var1, ["reflex_west01", "laserir", "rec_kilo433|1", "back_kilo433|1", "barsil_kilo433", "mag_kilo433|1"]);
  var0 scripts\anim\shared::forceuseweapon(var2, "primary");
  var0 scripts\anim\notetracks_sp::notetrackgundrop();
}

function buddy_down_remove_playerclip(var0) {
  var1 = getEnt("3rd_floor_door_playerclip", "targetname");
  var1 delete();
}

function favela_door() {
  var0 = "generic";
  level.scr_anim[var0]["faveladoor_fastopen"] = % reb_smtobj_door_r_fastopen;
  level.scr_anim[var0]["faveladoor_fire1"] = % reb_smtobj_door_r_fire01;
  level.scr_anim[var0]["faveladoor_fire2"] = % reb_smtobj_door_r_fire02;
  level.scr_anim[var0]["faveladoor_fire3"] = % reb_smtobj_door_r_fire03;
  level.scr_anim[var0]["faveladoor_idle"][0] = % reb_smtobj_door_r_loop;
  level.scr_anim[var0]["faveladoor_kick"] = % reb_smtobj_door_r_kick01;
  level.scr_anim[var0]["faveladoor_peak"] = % reb_smtobj_door_r_peak;
  level.scr_anim[var0]["python_enter"] = % thd_3f_010_door_enter_alt_enemy01;
  scripts\common\anim::addnotetrack_customfunction(var0, "3rd_floor_enemy_pre_enter_sfx", &sfx_townhouse_door_audio_3rd_floor_python_pre, "python_enter");
  scripts\common\anim::addnotetrack_customfunction(var0, "3rd_floor_enemy_enter_sfx", &sfx_townhouse_door_audio_3rd_floor_python_enter, "python_enter");
  var1 = "python_enter_long_death";
  level.scr_anim[var0][var1] = % thd_3f_010_door_alt_death_enemy01;
  scripts\common\anim::addnotetrack_customfunction(var0, "kill_me", &kill_me_ragdoll, var1);
}

function attic() {
  var0 = "price";
  var1 = "bomber";
  level.scr_face[var0]["dx_vom_pri_attic_breach_20"] = % dx_vom_pri_attic_breach_20_face;
  level.scr_face[var0]["dx_vom_pri_attic_breach_30"] = % dx_vom_pri_attic_breach_30_face;
  level.scr_face[var0]["dx_vom_pri_attic_breach_40"] = % dx_vom_pri_attic_breach_40_face;
  level.scr_anim[var0]["attic_door_arrive"] = % thd_atc_010_halligan_arrival_price;
  level.scr_anim[var0]["attic_door_arrive_loop"][0] = % thd_atc_010_halligan_arrival_idle_price;
  level.scr_anim[var0]["attic_door_open"] = % thd_atc_010_halligan_open_price;
  scripts\common\anim::addnotetrack_customfunction(var0, "grab_halligan", &grab_halligan, "attic_door_open");
  scripts\common\anim::addnotetrack_customfunction(var0, "stow_halligan", &stow_halligan, "attic_door_open");
  scripts\common\anim::addnotetrack_customfunction(var0, "halligan_attic_door_prep_sfx", &sfx_townhouse_door_audio_attic_prep, "attic_door_open");
  scripts\common\anim::addnotetrack_customfunction(var0, "halligan_attic_door_open_sfx", &sfx_townhouse_door_audio_attic_open, "attic_door_open");
  level.scr_anim[var0]["attic_door_open_loop"][0] = % thd_atc_010_halligan_open_idle_price;
  level.scr_anim[var0]["attic_stairtrain_arrival"] = % thd_4f_030_stairs_arrival_price;
  level.scr_anim[var0]["attic_stairtrain_arrival_idle"][0] = % thd_4f_030_stairs_arrival_idle_price;
  level.scr_anim[var0]["attic_stairtrain"] = % thd_4f_030_stairs_climb_price;
  var2 = "attic_stairtrain_additive_branch";
  level.scr_anim[var0][var2] = % townhouse_stair_additives;
  var2 = "attic_stairtrain_additive";
  level.scr_anim[var0][var2] = % thd_stair_train_idle_forward;
  var2 = "attic_stairtrain_settle";
  level.scr_anim[var0][var2] = % thd_stair_train_settle_forward;
  var3 = "attic_enemy";
  level.scr_model[var3 + "_head"] = "head_sc_f_walden_blendshape";
  level.scr_anim[var3]["start_idle"][0] = % thd_atc_010_bomber_start_idle_enemy01;
  level.scr_anim[var0]["attic_entry"] = % thd_atc_010_bomber_enter_price;
  scripts\common\anim::addnotetrack_flag(var0, "attic_clip", "attic_playerclip", "attic_entry");
  scripts\common\anim::addnotetrack_customfunction(var0, "try_dialogue1", &try_attic_dialogue_shoot_her, "attic_entry");
  level.scr_anim[var0]["attic_entry_idle"][0] = % thd_atc_010_bomber_enter_idle_price;
  level.scr_anim[var3]["attic_entry"] = % thd_atc_010_bomber_enter_enemy01;
  scripts\common\anim::addnotetrack_customfunction(var3, "player_can_shoot", &attic_player_can_shoot, "attic_entry");
  scripts\common\anim::addnotetrack_customfunction(var3, "use_ragdoll", &attic_use_ragdoll, "attic_entry");
  scripts\common\anim::addnotetrack_customfunction(var3, "use_final_deathanim", &attic_use_final_deathanim, "attic_entry");
  scripts\common\anim::addnotetrack_customfunction(var3, "price_shoot", &attic_price_shoot, "attic_entry");
  level.scr_anim[var0]["attic_enemy_death"] = % thd_atc_010_bomber_death_price;
  level.scr_anim[var0]["attic_enemy_death_idle"][0] = % thd_atc_010_bomber_death_idle_price;
  level.scr_anim[var3]["attic_enemy_death"] = % thd_atc_010_bomber_death_enemy01;
  scripts\common\anim::addnotetrack_customfunction(var3, "price_shoot", &attic_price_shoot, "attic_enemy_death");
  scripts\common\anim::addnotetrack_customfunction(var3, "kill_me", &kill_me_ragdoll_nosound, "attic_enemy_death");
  level.scr_anim[var3]["attic_enemy_headshot_death"] = % thd_atc_010_bomber_death_headshot_enemy01;
  level.scr_anim[var3]["attic_enemy_early_long_death"] = % thd_atc_010_bomber_death_longdeath_enemy01;
  scripts\common\anim::addnotetrack_customfunction(var3, "kill_me", &kill_me_ragdoll_nosound, "attic_enemy_early_long_death");
  scripts\common\anim::addnotetrack_customfunction(var3, "use_deathanim", &attic_use_deathanim, "attic_enemy_early_long_death");
  level.scr_anim[var3]["attic_enemy_early_long_death_end"] = % thd_atc_010_bomber_death_longdeath_shot_enemy01;
  level.scr_anim[var0]["ending"] = % thd_atc_010_bomber_end_price;
  scripts\common\anim::addnotetrack_customfunction(var0, "detach_prop", &attic_detach_laptop, "ending");
  scripts\common\anim::addnotetrack_mayhemstart(var0, "mayhem_start", %thd_atc_010_bomber_end_price_face, "ending");
  scripts\common\anim::addnotetrack_mayhemend(var0, "mayhem_end", %thd_atc_010_bomber_end_price_face, "ending");
  level.scr_anim[var1]["ending"] = % thd_atc_010_bomber_end_enemy01;
  scripts\common\anim::addnotetrack_customfunction(var0, "attach_prop", &attic_attach_clacker, "ending");
}

function try_attic_dialogue_shoot_her(var0) {
  if(!isalive(level.attic_enemy) || level.attic_enemy.health < 10) {
    return;
  }

  var0 scripts\engine\sp\utility::smart_dialogue("dx_vom_pri_attic_standoff_25");

  if(!isalive(level.attic_enemy) || level.attic_enemy.health < 10) {
    return;
  }

  level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_kyle_attic_standoff_30");
}

function attic_detach_laptop(var0) {
  level.price.laptop unlink();
}

function attic_attach_clacker(var0) {
  var0 attach(level.clacker.model, "tag_accessory_right");
  level.clacker delete();
}

function attic_player_can_shoot(var0) {
  var0 notify("stop_early_death");
  var0.playerbullets--;
}

function attic_use_ragdoll(var0) {
  var0.health = 5;
  var0.allowdeath = 1;
  var0.skipdeathanim = 1;
}

function attic_use_final_deathanim(var0) {
  var0.health = 5;
  var0.allowdeath = 1;
  var0.skipdeathanim = 1;
  var0.deathfunction = &attic_final_player_deathanim;
}

function attic_final_player_deathanim() {
  var0 = scripts\engine\utility::getStruct("attic_animnode", "targetname");
  self animmode("noclip");
  self.disabledeathorient = 1;
  scripts\sp\maps\townhoused\townhoused_code::scripted_deathanim("attic_enemy_death", var0);
}

function attic_use_deathanim(var0) {
  var0.allowdeath = 1;
  var0.skipdeathanim = undefined;
  var0 scripts\engine\sp\utility::set_deathanim("attic_enemy_early_long_death_end");
}

function attic_price_shoot(var0) {
  if(!isalive(var0) || var0.health == 1) {
    return;
  }

  if(!isDefined(var0.priceshootcount)) {
    var0.priceshootcount = 0;
  }

  var0.damageshield = 1;
  level.price shoot(1, undefined, 1, 1);
  var0.priceshootcount++;

  if(var0.priceshootcount == 2) {
    var0 stopsounds();
  }

  waitframe();
  var0.damageshield = 0;
}

function attic_enemy_death(var0) {
  var0.a.nodeath = 1;
  var0 kill();
}

function player() {
  var0 = "player_rig";
  level.scr_animtree[var0] = #animtree;
  level.scr_model[var0] = "viewhands_kyle_sas_urban";
  level.scr_anim[var0]["backyard_intro"] = $thd_ba_005_intro_plr;
  scripts\common\anim::addnotetrack_customfunction(var0, "hide_head", &hide_fakeplayer_head, "backyard_intro");
  scripts\common\anim::addnotetrack_customfunction(var0, "swap_lock", &backyard_cut_gate, "backyard_intro");
  level.scr_anim[var0]["deploy_ladder"] = % thd_vm_tactical_ladder_plr;
  level.scr_anim[var0]["window_mantle"] = % thd_1f_010_vm_mantle_plr;
  scripts\common\anim::addnotetrack_customfunction(var0, "give_viewcontrol", &mantle_give_viewlook, "window_mantle");
  level.scr_anim[var0]["ending"] = % thd_atc_010_bomber_end_plr;
}

function mantle_give_viewlook(var0) {}

function backyard_cut_gate(var0) {
  level.gatelock setModel(scripts\engine\sp\utility::getmodel("gate_lock_cut"));
}

function hide_fakeplayer_head(var0) {
  level.kyle hidepart("j_head");
  level.kyle hidepart("j_helmet");
}

function script_model() {
  var0 = "door";
  level.scr_animtree[var0] = #animtree;
  level.scr_model["halligan"] = "misc_vm_halligan_tool";
  level.scr_anim[var0]["backyard_door_open"] = $thd_backyard_door;
  var1 = "bolt_cutters";
  level.scr_animtree[var1] = #animtree;
  level.scr_model[var1] = "misc_wm_boltcutter";
  var2 = "gate_lock";
  level.scr_animtree[var2] = #animtree;
  level.scr_model[var2] = "tool_security_padlock_01";
  level.scr_model["gate_lock_cut"] = "tool_security_padlock_02_cut";
  level.scr_animtree["gate"] = #animtree;
  level.scr_anim["gate"]["gate_cut"] = % th_wh_015_gate_gate01_cut;
  level.scr_animtree["cellphone_on"] = #animtree;
  level.scr_model["cellphone_on"] = "offhand_wm_cellphone_old_on";
  var3 = "backyard_intro";
  level.scr_anim[var1][var3] = % thd_ba_005_intro_cutters;
  level.scr_anim[var0][var3] = % thd_ba_005_intro_gate;
  level.scr_anim[var2]["backyard_intro_cut_gate"] = % thd_ba_005_intro_lock;
  scripts\common\anim::addnotetrack_customfunction(var2, "drop", &backyard_lock_physics, "backyard_intro_cut_gate");
  level.scr_anim[var0]["backdoor_enter"] = % thd_ba_020_halligan_enter_door;
  level.scr_anim[var0]["frontdoor_enter"] = % thd_1f_050_door_enter_door01;
  level.scr_anim[var0]["buddy_down_intro"] = % thd_3f_020_buddy_down_a_door;
  level.scr_anim[var0]["faveladoor_fastopen"] = % reb_smtobj_door_r_fastopen_rdoor;
  level.scr_anim[var0]["faveladoor_fire1"] = % reb_smtobj_door_r_fire01_rdoor;
  level.scr_anim[var0]["faveladoor_fire2"] = % reb_smtobj_door_r_fire02_rdoor;
  level.scr_anim[var0]["faveladoor_fire3"] = % reb_smtobj_door_r_fire03_rdoor;
  level.scr_anim[var0]["faveladoor_kick"] = % reb_smtobj_door_r_kick01_rdoor;
  level.scr_anim[var0]["faveladoor_peak"] = % reb_smtobj_door_r_peak_rdoor;
  var4 = "cuffs";
  level.scr_animtree[var4] = #animtree;
  level.scr_model[var4] = "zip_tie_handcuffs_wm";
  level.scr_anim[var4]["kitchen_takedown"] = % thd_1f_040_woman_grabbed_cuffs;
  level.scr_anim[var4]["kitchen_takedown_loop"][0] = % thd_1f_040_woman_idle_cuffs;
  level.scr_anim[var4]["kitchen_takedown_lookup_loop"][0] = % thd_1f_040_woman_idle_up_cuffs;
  level.scr_anim[var4]["kitchen_takedown_death"] = % thd_1f_040_woman_death_cuffs;
  level.scr_anim[var0]["kitchen_takedown"] = % thd_1f_040_woman_grabbed_door01;
  var5 = "chair";
  level.scr_animtree[var5] = #animtree;
  level.scr_anim[var5]["dining_react"] = % thd_1f_050_dining_room_chair1_react;
  level.scr_anim[var5]["dining_react_high"] = % thd_1f_050_dining_room_chair1_react_high;
  level.scr_anim[var5]["dining_react_pain"] = % thd_1f_050_dining_room_chair1_react_pain;
  level.scr_anim[var5]["dining_death"] = % thd_1f_050_dining_room_chair1_death;
  level.scr_anim[var5]["dining_long_death"] = % thd_1f_050_dining_room_chair1_death_long;
  level.scr_anim[var5]["dining_long_death_end"] = % thd_1f_050_dining_room_chair1_death_long_end;
  level.scr_anim[var5]["dining_long_death_expire"] = % thd_1f_050_dining_room_chair1_death_long_end_02;
  level.scr_anim[var0]["boy_bathroom"] = % thd_2f_010_clear_rooms_arrival_door3;
  level.scr_anim[var0]["secure_boy"] = % thd_2f_010_clear_rooms_enter_secure_door3;
  level.scr_anim[var0]["2ndfloor_bedroom_enter"] = % thd_2f_010_clear_rooms_door2;
  level.scr_anim[var0]["2ndfloor_bedroom_enter2"] = % thd_2f_010_clear_rooms_door4;
  level.scr_anim[var0]["2ndfloor_bathroom_enter"] = % thd_2f_010_clear_rooms_door3;
  level.scr_anim[var0]["python_enter"] = % thd_3f_010_door_enter_alt_door01;
  level.scr_anim[var0]["baby_mom_arrive"] = % thd_4f_010_setup_door01;
  level.scr_model["collision_head"] = "civ_female_scriptable_collision_head";
  level.scr_model["collision_chest"] = "civ_female_scriptable_collision_spine_upper";
  level.scr_model["collision_shoulder"] = "civ_female_scriptable_collision_shoulder";
  level.scr_anim[var0]["attic_door_open"] = % thd_atc_010_halligan_open_door01;
  scripts\common\anim::addnotetrack_customfunction(var0, "swap", &attic_swap_door, "attic_door_open");
  scripts\common\anim::addnotetrack_customfunction(var0, "swap2", &attic_swap_door2, "attic_door_open");
  var6 = "clacker";
  level.scr_model[var6] = "offhand_vm_clacker";
  level.scr_animtree[var6] = #animtree;
  var7 = "laptop";
  level.scr_model[var7] = "device_laptop_02_open";
  level.scr_animtree[var7] = #animtree;
  level.scr_model["attic_door_damaged"] = "door_metal_halligan_damaged_right_02_sp";
  level.scr_model["attic_door_damaged2"] = "door_metal_halligan_damaged_right_03_sp";
  var8 = "baby";
  level.scr_animtree[var8] = #animtree;
  level.scr_anim[var8]["root"] = % root;
  level.scr_anim[var8]["grab_baby"] = % thd_4f_020_baby_enter_baby;
  level.scr_anim[var8]["grab_baby_loop"][0] = % thd_4f_020_baby_enter_idle_baby;
  level.scr_anim[var8]["grab_baby_loop_ads_react"] = % thd_4f_020_baby_react_baby;
  level.scr_anim[var8]["grab_baby_stand_death"] = % thd_4f_020_baby_stand_death_baby;
  level.scr_anim[var8]["grab_baby_mom_early_death"] = % thd_4f_020_baby_early_death_baby;
  level.scr_anim[var8]["grab_baby_death"] = % thd_4f_020_baby_death_baby;
  level.scr_anim[var8]["grab_baby_pickup_early"] = % thd_4f_020_baby_pickup_baby;
  level.scr_anim[var8]["grab_baby_pickup_early_idle"] = % thd_4f_020_baby_pickup_idle_baby;
  level.scr_anim[var8]["grab_baby_stand_death_idle"] = % thd_4f_020_baby_pickup_idle_2_baby;
  level.scr_anim[var8]["baby_idle"] = % thd_4f_020_baby_pickup_idle_3_baby;
}

function attic_swap_door(var0) {
  var1 = scripts\sp\door::get_interactive_door("attic_door");
  var1 setModel(scripts\engine\sp\utility::getmodel("attic_door_damaged"));
  var2 = "j_end";
  var3 = level.price gettagangles(var2);
  var4 = anglesToForward(var3);
  var5 = level.price gettagorigin(var2) + var4 * -3;
  playFX(scripts\engine\utility::getfx("halligan_attic"), var5, var4);
}

function attic_swap_door2(var0) {
  var1 = scripts\sp\door::get_interactive_door("attic_door");
  var1 setModel(scripts\engine\sp\utility::getmodel("attic_door_damaged2"));
}

function backyard_lock_physics(var0) {
  var0.prevorigin = var0.origin;
  waitframe();
  var1 = var0.prevorigin - var0.origin;
  var0 scripts\engine\sp\utility::anim_stopanimScripted();
  var0 physicslaunchserver(var0.origin, var1 * 2);
}

function gate_lock_swap(var0) {
  var0 setModel(scripts\engine\sp\utility::getmodel("gate_lock_cut"));
}

function ladder() {
  level.scr_animtree["ladder"] = #animtree;
  level.scr_model["ladder"] = "misc_vm_tactical_ladder_sp";
  level.scr_anim["ladder"]["deploy_ladder"] = % thd_vm_tactical_ladder_prop;
}

function vehicle() {}

#using_animtree("scriptables");

function scriptable() {
  level.scr_animtree["backyard_car"] = #animtree;
}

function ai_gestures() {
  level.scr_gesture = [];
}

function customnotetrackhandler(var0) {
  var1 = getsubstr(var0, 0, 3);

  if(var1 == "dr_") {
    var2 = getsubstr(var0, 3);
    thread scripts\sp\maps\townhoused\townhoused_code::smart_dialogue_or_radio(var2);
    return;
  }
}

function apc_lerp_fov(var0) {}

function kill_me_no_anim(var0) {
  if(isDefined(var0.magic_bullet_shield) && var0.magic_bullet_shield) {
    var0 scripts\common\ai::stop_magic_bullet_shield();
  }

  var0.damageshield = 0;
  var0.a.nodeath = 1;
  var0 kill();
}

function kill_me_ragdoll(var0) {
  if(isDefined(var0.magic_bullet_shield) && var0.magic_bullet_shield) {
    var0 scripts\common\ai::stop_magic_bullet_shield();
  }

  var0.allowdeath = 1;
  var0.skipdeathanim = 1;
  var0 kill();
}

function kill_me_ragdoll_nosound(var0) {
  var0.diequietly = 1;
  kill_me_ragdoll(var0);
}

function allowdeath_just_ragdoll(var0) {
  var0.allowdeath = 1;
  var0.skipdeathanim = 1;
}

function remove_deathfunc(var0) {
  var0.deathfunction = undefined;
}

function remove_skipdeathanim(var0) {
  var0.skipdeathanim = undefined;
}

function remove_deathanim(var0) {
  var0.deathanime = undefined;
  var0 scripts\engine\sp\utility::clear_deathanim();
}

function remove_scripted_deaths(var0) {
  remove_deathanim(var0);
  remove_deathfunc(var0);
}

function no_allowdeath(var0) {
  var0.allowdeath = 0;
}

function enable_allowdeath(var0) {
  var0.allowdeath = 1;
}

function remove_death_react(var0) {
  var0 notify("stop_reaction_death");
  var0 scripts\engine\sp\utility::clear_deathanim();
}

function enable_magic_bullet_shield(var0) {
  var0 scripts\common\ai::magic_bullet_shield();
}

function disable_magic_bullet_shield(var0) {
  var0 scripts\common\ai::stop_magic_bullet_shield();
}

function sfx_townhouse_door_audio_backyard_gate(var0) {
  thread threaded_sfx_townhouse_door_audio(level);
}

function sfx_townhouse_door_audio_basement_prep(var0) {
  thread threaded_sfx_townhouse_door_audio(level);
}

function sfx_townhouse_door_audio_basement_enter(var0) {
  thread threaded_sfx_townhouse_door_audio(level);
}

function sfx_townhouse_door_audio_kitchen_girl_pre(var0) {
  thread threaded_sfx_townhouse_door_audio(level);
}

function sfx_townhouse_door_audio_kitchen_girl(var0) {
  thread threaded_sfx_townhouse_door_audio(level);
}

function sfx_townhouse_door_audio_front_open(var0) {
  thread threaded_sfx_townhouse_door_audio(level);
}

function sfx_townhouse_door_audio_2nd_floor_bathroom(var0) {
  thread threaded_sfx_townhouse_door_audio(level);
}

function sfx_townhouse_door_audio_2nd_floor_bedroom(var0) {
  thread threaded_sfx_townhouse_door_audio(level);
}

function sfx_townhouse_door_audio_2nd_floor_bedroom_bash(var0) {
  thread threaded_sfx_townhouse_door_audio(level);
}

function sfx_townhouse_door_audio_3rd_floor_price(var0) {
  thread threaded_sfx_townhouse_door_audio(level);
}

function sfx_townhouse_door_audio_3rd_floor_python_pre(var0) {
  thread threaded_sfx_townhouse_door_audio(level);
}

function sfx_townhouse_door_audio_3rd_floor_python_enter(var0) {
  thread threaded_sfx_townhouse_door_audio(level);
}

function sfx_townhouse_audio_3rd_floor_sound_look_at(var0) {
  thread threaded_sfx_townhouse_door_audio(level);
}

function sfx_townhouse_audio_3rd_floor_buddy_down_look_at(var0) {
  thread threaded_sfx_townhouse_door_audio(level);
}

function sfx_townhouse_door_audio_4th_floor_bathroom(var0) {
  thread threaded_sfx_townhouse_door_audio(level);
}

function sfx_townhouse_door_audio_attic_prep(var0) {
  thread threaded_sfx_townhouse_door_audio(level);
}

function sfx_townhouse_door_audio_attic_open(var0) {
  thread threaded_sfx_townhouse_door_audio(level);
}

function threaded_sfx_townhouse_door_audio(var0) {
  switch (var0) {
    case "backyard_open_gate":
      thread scripts\engine\utility::play_sound_in_space("backyard_gate_unlatch", (864, 556, -358));
      wait 1.4;
      thread scripts\engine\utility::play_sound_in_space("backyard_gate_open", (876, 553, -388));
      wait 1;
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

function audio_front_door_dog_sfx() {
  level.frontdoordog = spawn("script_origin", (60, 1263, -335));
  level.frontdoordog scripts\engine\sp\utility::sound_fade_in("emt_dog_barking_dist_03", 1, 0.8, 1);
  level waittill("stop_dog_sounds_front_door");
  level.frontdoordog scripts\engine\sp\utility::sound_fade_and_delete(8, 1);
}