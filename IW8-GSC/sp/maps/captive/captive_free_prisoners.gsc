/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\captive\captive_free_prisoners.gsc
******************************************************/

free_prisoners_flags() {
  scripts\engine\utility::flag_init("approaching_prisoners");
  scripts\engine\utility::flag_init("pressed_cell_door_button");
  scripts\engine\utility::flag_init("commented_on_locker");
  scripts\engine\utility::flag_init("opened_gun_locker");
  scripts\engine\utility::flag_init("near_weapons_locker");
  scripts\engine\utility::flag_init("women_have_guns");
  scripts\engine\utility::flag_init("set_locker_goal");
}

free_prisoners_start() {
  scripts\engine\sp\utility::set_start_location("player_spawn_free_prisoners", [level.player]);
  scripts\sp\maps\captive\captive_util.gsc::setup_noisemaker_pickups();
  scripts\sp\maps\captive\captive_util.gsc::enable_context_melee();
  scripts\sp\player\teenagefarah::teenage_farah_stealth_setup();
  var_0 = scripts\sp\utility::make_weapon("iw8_pi_golf21_tfarah");
  level.player giveweapon(var_0);
  level.player switchtoweapon(var_0);
  level.player scripts\sp\utility::take_weapon("iw8_farahspoon_sp");
  thread scripts\sp\maps\captive\captive_vo.gsc::vo_walla_guards_alert();
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("hadir_cell");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("main_cell");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("break_final");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("waterboarding");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("pre_explosion");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_on("post_explosion");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("fallen_grate");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_on("upstairs");
}

free_prisoners_main() {
  var_0 = getEnt("ai_locker_idle_clip", "targetname");
  var_0 notsolid();
  setsaveddvar("NPONLLLSPL", 0.78);
  level.weaponslockerref = scripts\engine\utility::getStruct("weapons_locker_ref", "targetname");
  level.akproxies = [];

  for(var_1 = 1; var_1 <= 9; var_1++) {
    var_2 = scripts\engine\utility::getStruct("gun_proxy_" + var_1, "targetname");
    var_3 = scripts\engine\sp\utility::spawn_anim_weapon("ak", var_2.origin, var_2.angles);
    var_3 hidepart("tag_rail");
    level.akproxies[level.akproxies.size] = var_3;

    if(var_1 != 6)
      level.weaponslockerref thread scripts\common\anim::anim_first_frame_solo(var_3, "setpos_gun" + var_1);
  }

  scripts\sp\utility::context_melee_set_silent_kill(1);
  level.lockersceneclip = getEnt("clip_locker_scene", "targetname");
  level.lockersceneclip thread wait_toggle_clip();
  level.weaponlocker = getEnt("weapons_locker", "targetname");
  level.weaponlocker.animname = "weapons_locker";
  level.weaponlocker scripts\engine\sp\utility::assign_animtree();
  level.weaponslockerref thread scripts\common\anim::anim_first_frame_solo(level.weaponlocker, "weapon_locker_open");
  setsaveddvar("NPONLLLSPL", 0.78);
  scripts\sp\maps\captive\captive_util.gsc::spawn_prisoners();

  foreach(var_5 in level.allprisoners) {
    var_5 scripts\common\ai::gun_remove();
    var_5 thread scripts\sp\utility::civilianfailwrapper();
  }

  level.weaponslockerref thread scripts\common\anim::anim_loop(level.allprisoners, "cell_idle", "end_cell_idle");
  level thread check_open_gun_locker();
  thread scripts\sp\maps\captive\captive_vo.gsc::mus_far_free_sisters();
  var_7 = scripts\engine\utility::getStruct("upper_cell_door_button_interact", "targetname");
  var_7 thread upper_cell_door_button_check();
  scripts\engine\utility::flag_wait("approaching_prisoners");
  scripts\engine\sp\objectives::objective_update("objective", "current", scripts\engine\utility::getStruct("upper_cell_door_button_objective", "targetname").origin, &"CAPTIVE/OBJ_FREE_PRISONERS_DESC", &"CAPTIVE/OBJ_FREE_PRISONERS");
  level thread women_spot_farah();
  scripts\engine\utility::flag_wait("pressed_cell_door_button");
  var_0 solid();

  if(scripts\engine\utility::flag("opened_gun_locker")) {
    scripts\engine\sp\objectives::objective_update("objective", "current", scripts\engine\utility::getStruct("setup_ambush_objective", "targetname").origin, &"CAPTIVE/OBJ_SETUP_AMBUSH_DESC", &"CAPTIVE/OBJ_SETUP_AMBUSH");
    level thread women_get_guns_from_open_locker();
  } else {
    scripts\engine\sp\objectives::objective_update("objective", "current", scripts\engine\utility::getStruct("open_gun_locker_objective", "targetname").origin, &"CAPTIVE/OBJ_GUN_LOCKER_DESC", &"CAPTIVE/OBJ_GUN_LOCKER");
    scripts\engine\utility::flag_set("set_locker_goal");
    level thread women_move_to_gun_locker();
  }

  scripts\engine\utility::flag_wait("women_have_guns");
  level thread scripts\sp\maps\captive\captive_vo.gsc::vo_ff_ambush();
  scripts\engine\sp\utility::array_notify(level.allprisoners, "stop_civilian_fail_wrapper");
  var_0 delete();

  if(scripts\engine\utility::flag("set_locker_goal"))
    scripts\engine\sp\objectives::objective_update("objective", "current", scripts\engine\utility::getStruct("setup_ambush_objective", "targetname").origin, &"CAPTIVE/OBJ_SETUP_AMBUSH_DESC", &"CAPTIVE/OBJ_SETUP_AMBUSH");

  level thread scripts\engine\sp\utility::autosave_by_name("factory_floor");
}

free_prisoners_catchup() {
  if(level.start_point == "bink_speech") {
    return;
  }
  level thread close_and_lock_door();
  scripts\engine\sp\objectives::objective_update("objective", "current", scripts\engine\utility::getStruct("setup_ambush_objective", "targetname").origin, &"CAPTIVE/OBJ_SETUP_AMBUSH_DESC", &"CAPTIVE/OBJ_SETUP_AMBUSH");
}

women_spot_farah() {
  level endon("pressed_cell_door_button");

  if(!scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), scripts\engine\utility::getStruct("check_facing_prisoners", "targetname").origin, cos(30)))
    wait 0.5;

  level.player scripts\engine\sp\utility::set_player_demeanor("relaxed");
  level.weaponslockerref notify("end_cell_idle");
  level.weaponslockerref scripts\common\anim::anim_single(level.allprisoners, "cell_response");
  level.weaponslockerref thread scripts\common\anim::anim_loop(level.allprisoners, "cell_aware_idle", "end_cell_aware_idle");
}

upper_cell_door_button_check() {
  scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"CAPTIVE/CURSOR_PRESS", 180, 256, 64);
  self waittill("trigger");
  scripts\engine\utility::flag_set("pressed_cell_door_button");
  var_0 = scripts\engine\utility::getStruct("button_push_ref", "targetname");
  var_0 scripts\sp\player_rig::link_player_to_rig("cell_open", "stand", 1, 0.3);
  var_1 = getEnt("cell_door_button_upstairs", "script_noteworthy");
  var_1.animname = "button";
  var_1 scripts\common\anim::setanimtree();
  var_1 thread wait_upper_cell_door_button_switch();
  var_0 scripts\common\anim::anim_single_solo(level.player_rig, "cell_open");
  scripts\sp\player_rig::unlink_player_from_rig();
}

wait_upper_cell_door_button_switch() {
  level waittill("cell_button_switch");
  thread scripts\engine\utility::play_sound_in_space("alm_open_cell_buzzer", self.origin);
  thread scripts\common\anim::anim_single_solo(self, "button_push");
  getEnt("cell_door_button_lights_upstairs", "script_noteworthy") setModel("electrical_cell_door_button_lights_green");

  foreach(var_1 in level.uppercelldoors)
  var_1 thread open_upper_cell_door();
}

open_upper_cell_door() {
  switch (self.script_wtf) {
    case "6":
      self playSound("captive_jail_cell_door_06_open");
      self moveTo(self.open_pos.origin, 3, 1, 0.5);
      break;
    case "7":
      self playSound("captive_jail_cell_door_07_open");
      self moveTo(self.open_pos.origin, 3, 1, 0.5);
      break;
    case "8":
      self playSound("captive_jail_cell_door_08_open");
      self moveTo(self.open_pos.origin, 3, 1, 0.5);
      break;
    default:
      self moveTo(self.open_pos.origin, 3, 1, 0.5);
      break;
  }

  wait 3;
  self.collision connectpaths();
}

check_open_gun_locker() {
  var_0 = getEnt("weapons_locker_door_left_clip_open", "targetname");
  var_0 notsolid();
  var_1 = getEnt("weapons_locker_door_right_clip_open", "targetname");
  var_1 notsolid();
  var_2 = scripts\engine\utility::getStruct("weapon_locker_interact", "targetname");
  var_2 thread scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"CAPTIVE/CURSOR_USE", 180, 240, 64);
  var_2 waittill("trigger");
  level thread scripts\sp\player\teenagefarah::teenage_farah_combat_setup();
  var_3 = getEnt("weapons_locker_door_left_clip", "targetname");
  var_3 delete();
  var_4 = getEnt("weapon_locker_door_right_clip", "targetname");
  var_4 delete();
  var_0 solid();
  var_1 solid();
  level.weaponslockerref scripts\sp\player_rig::link_player_to_rig("weapon_locker_open", "stand", 1, 0.5, undefined, undefined, undefined, undefined, undefined, 1);
  var_5 = scripts\engine\sp\utility::spawn_anim_model("key");
  level thread close_and_lock_door();
  level notify("started_open_locker");
  level notify("kill_all_anim_instructions");
  level.weaponslockerref notify("end_locker_idle");
  level.weaponslockerref notify("end_ayah_locker_idle");
  level.weaponslockerref notify("end_darine_locker_idle");

  if(scripts\engine\utility::flag("pressed_cell_door_button")) {
    if(scripts\engine\utility::flag("saved_azadeh")) {
      level thread women_get_guns_from_locker();
      level notify("enable_clip");
      level.weaponslockerref thread scripts\common\anim::anim_single([var_5, level.weaponlocker], "weapon_locker_open");
      level.weaponslockerref scripts\common\anim::anim_single_solo(level.player_rig, "weapon_locker_open");
    } else {
      level thread women_get_guns_from_locker_no_azadeh();
      level notify("enable_clip");
      level.weaponslockerref thread scripts\common\anim::anim_single([var_5, level.weaponlocker], "weapon_locker_open_no_azadeh");
      level.weaponslockerref scripts\common\anim::anim_single_solo(level.player_rig, "weapon_locker_open_no_azadeh");
    }
  } else {
    level notify("end_clip_wait");
    level.lockersceneclip delete();
    level.weaponslockerref thread scripts\common\anim::anim_single([var_5, level.weaponlocker], "weapon_locker_open_pre_cell_open");
    level.weaponslockerref scripts\common\anim::anim_single_solo(level.player_rig, "weapon_locker_open_pre_cell_open");
  }

  var_5 delete();
  scripts\sp\player_rig::unlink_player_from_rig();
  scripts\engine\utility::flag_set("opened_gun_locker");
  var_6 = scripts\engine\utility::getStruct("frag_grenades_interact", "targetname");
  var_6 thread check_take_frag_grenade();
  scripts\engine\sp\utility::transient_unload("captive_basement_tr");
  scripts\engine\sp\utility::transient_load("captive_exterior_tr");
}

women_move_to_gun_locker() {
  level endon("started_open_locker");
  var_0 = [level.nadia, level.ghalia];

  if(scripts\engine\utility::flag("saved_azadeh"))
    var_0[var_0.size] = level.azadeh;

  level.weaponslockerref notify("end_cell_aware_idle");
  level.weaponslockerref thread scripts\common\anim::anim_loop(level.allprisoners, "cell_aware_idle", "end_button_idle");
  wait 1;
  level.weaponslockerref notify("end_button_idle");
  var_0 thread scripts\sp\maps\captive\captive_util.gsc::play_group_single_anim_into_idle_anim(level.weaponslockerref, "cell_open", "weapon_locker_idle", "end_locker_idle");
  level.ayah thread scripts\sp\maps\captive\captive_util.gsc::play_single_anim_into_idle_anim(level.weaponslockerref, "cell_open", "weapon_locker_idle", "end_ayah_locker_idle");
  level.darine thread scripts\sp\maps\captive\captive_util.gsc::play_single_anim_into_idle_anim(level.weaponslockerref, "cell_open", "weapon_locker_idle", "end_darine_locker_idle");
  wait 15;
  scripts\engine\utility::flag_waitopen("near_weapons_locker");
  level.weaponslockerref notify("end_ayah_locker_idle");
  level.ayah thread scripts\sp\maps\captive\captive_util.gsc::play_single_anim_into_idle_anim(level.weaponslockerref, "weapon_locker_nag", "weapon_locker_idle", "end_ayah_locker_idle");
  wait 8;
  scripts\engine\utility::flag_waitopen("near_weapons_locker");
  level.weaponslockerref notify("end_darine_locker_idle");
  level.darine thread scripts\sp\maps\captive\captive_util.gsc::play_single_anim_into_idle_anim(level.weaponslockerref, "weapon_locker_nag", "weapon_locker_idle", "end_darine_locker_idle");
  wait 10;
  scripts\engine\utility::flag_waitopen("near_weapons_locker");
  level thread scripts\sp\maps\captive\captive_vo.gsc::vo_ff_weaponlocker_nag();
}

women_get_guns_from_open_locker() {
  level.weaponslockerref notify("end_cell_aware_idle");
  level.weaponslockerref thread scripts\common\anim::anim_loop(level.allprisoners, "cell_aware_idle", "end_button_idle");
  wait 1.75;
  var_0 = [[level.ayah, 1, 7], [level.darine, 3, 3], [level.ghalia, 4, 2], [level.nadia, 5, 8]];

  if(scripts\engine\utility::flag("saved_azadeh"))
    var_0 = [[level.ayah, 1, 7], [level.azadeh, 2, 9], [level.darine, 3, 3], [level.ghalia, 4, 2], [level.nadia, 5, 8]];

  foreach(var_2 in var_0)
  var_2[0] thread wait_give_gun(var_2[1], var_2[2]);

  level.weaponslockerref notify("end_button_idle");
  level.weaponslockerref scripts\common\anim::anim_single(level.allprisoners, "cell_open_locker_open");
  scripts\engine\utility::flag_set("women_have_guns");
}

women_get_guns_from_locker() {
  var_0 = [[level.ayah, 1, 3], [level.azadeh, 2, 5], [level.darine, 3, 4], [level.ghalia, 4, 2], [level.nadia, 5, 1]];

  foreach(var_2 in var_0)
  var_2[0] thread wait_give_gun(var_2[1], var_2[2]);

  level.weaponslockerref scripts\common\anim::anim_single(level.allprisoners, "weapon_locker_open");
  scripts\engine\utility::flag_set("women_have_guns");
}

women_get_guns_from_locker_no_azadeh() {
  var_0 = [[level.ayah, 1, 3], [level.darine, 3, 4], [level.ghalia, 4, 2], [level.nadia, 5, 1]];

  foreach(var_2 in var_0)
  var_2[0] thread wait_give_gun(var_2[1], var_2[2]);

  level.weaponslockerref scripts\common\anim::anim_single(level.allprisoners, "weapon_locker_open_no_azadeh");
  scripts\engine\utility::flag_set("women_have_guns");
}

wait_give_gun(var_0, var_1) {
  level waittill("unhide_weapon_ally0" + var_0);
  level.akproxies[var_1 - 1] delete();
  scripts\common\ai::gun_recall();
}

wait_toggle_clip() {
  level endon("end_clip_wait");
  self notsolid();
  level waittill("enable_clip");
  self solid();
  level waittill("delete_clip");
  self delete();
}

check_take_frag_grenade() {
  thread scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"CAPTIVE/TAKE_FRAG_GRENADES", 180, 64, 48);
  self waittill("trigger");
  var_0 = getEntArray("frag_grenade", "targetname");

  foreach(var_2 in var_0)
  var_2 delete();

  level.player scripts\engine\sp\utility::give_offhand("frag_farah", 3);
}

close_and_lock_door() {
  var_0 = scripts\sp\door::get_interactive_door("basement_door");
  var_0 scripts\sp\door::reset_door();
  var_0 scripts\sp\door::remove_open_ability();
}