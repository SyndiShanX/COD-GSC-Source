/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cp_mi_zurich_newworld_util.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_dialog;
#using scripts\cp\_hacking;
#using scripts\cp\_objectives;
#using scripts\cp\_oed;
#using scripts\cp\_skipto;
#using scripts\cp\_util;
#using scripts\cp\cp_mi_zurich_newworld_rooftops;
#using scripts\cp\cybercom\_cybercom_gadget;
#using scripts\cp\cybercom\_cybercom_tactical_rig;
#using scripts\cp\cybercom\_cybercom_util;
#using scripts\shared\ai\archetype_utility;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\gameobjects_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#using scripts\shared\weapons_shared;
#namespace newworld_util;

function autoexec __init__sytem__() {
  system::register("newworld_util", &__init__, undefined, undefined);
}

function __init__() {
  init_client_field_callback_funcs();
}

function init_client_field_callback_funcs() {
  clientfield::register("toplayer", "postfx_futz", 1, 1, "counter");
}

function replace_weapons() {
  if(!isDefined(level.var_ba7d14b0)) {
    level.var_ba7d14b0 = [];
  }
  w_ar = getweapon("ar_fastburst", "suppressed", "acog");
  w_smg = getweapon("smg_fastfire", "extclip");
  w_lmg = getweapon("lmg_light", "acog", "fmj", "fastreload");
  w_shotgun = getweapon("shotgun_pump", "steadyaim", "extbarrel");
  var_a0543d15 = getweapon("pistol_standard", "suppressed", "reflex");
  var_9254de0d = getweapon("pistol_standard", "steadyaim");
  var_ae16e040 = getweapon("pistol_standard", "steadyaim");
  var_6473fc51 = getweapon("pistol_standard", "steadyaim");
  w_frag = getweapon("frag_grenade");
  w_emp = getweapon("emp_grenade");
  switch (level.skipto_current_objective[0]) {
    case "factory_alley":
    case "factory_factory_exterior":
    case "factory_factory_intro_igc":
    case "factory_foundry":
    case "factory_inside_man_igc":
    case "factory_vat_room":
    case "factory_warehouse":
    case "white_infinite_igc": {
      self take_weapons();
      self.primaryloadoutweapon = w_ar;
      self giveweapon(var_a0543d15);
      self giveweapon(w_frag);
      self giveweapon(w_emp);
      break;
    }
    case "chase_apartment_igc":
    case "chase_bridge_collapse":
    case "chase_chase_start":
    case "chase_construction_site":
    case "chase_glass_ceiling_igc":
    case "chase_old_zurich":
    case "chase_rooftops": {
      self take_weapons();
      self.primaryloadoutweapon = w_smg;
      self giveweapon(var_9254de0d);
      self giveweapon(w_frag);
      self giveweapon(w_emp);
      break;
    }
    case "underground_construction":
    case "underground_crossroads":
    case "underground_maintenance":
    case "underground_pinned_down_igc":
    case "underground_staging_room_igc":
    case "underground_subway":
    case "underground_water_plant": {
      if(!self flagsys::get("mobile_armory_in_use") && !isDefined(level.var_ba7d14b0[self getentitynumber()])) {
        self take_weapons();
        self.primaryloadoutweapon = w_lmg;
        self giveweapon(var_ae16e040);
        self giveweapon(w_frag);
        self giveweapon(w_emp);
      } else {
        self thread function_3a7ee040();
      }
      break;
    }
    case "train_detach_bomb_igc":
    case "train_inbound_igc":
    case "train_train_roof":
    case "train_train_start": {
      self take_weapons();
      self.primaryloadoutweapon = w_shotgun;
      self giveweapon(var_6473fc51);
      self giveweapon(w_frag);
      self giveweapon(w_emp);
      break;
    }
    default: {
      break;
    }
  }
  if(isDefined(self.primaryloadoutweapon)) {
    self giveweapon(self.primaryloadoutweapon);
    self switchtoweapon(self.primaryloadoutweapon);
  }
}

function function_3a7ee040() {
  if(!isDefined(level.var_ba7d14b0[self getentitynumber()])) {
    level.var_ba7d14b0[self getentitynumber()] = 1;
    self waittill("disconnect");
    level.var_ba7d14b0[self getentitynumber()] = undefined;
  }
}

function on_player_loadout() {
  if(sessionmodeiscampaignzombiesgame()) {
    return;
  }
  if(self function_c633d8fe() && isDefined(self.primaryloadoutweapon)) {
    return;
  }
  self replace_weapons();
  self replace_cyber_abilities();
  self cybercom_tacrig::takeallrigabilities();
  self cybercom_tacrig::giverigability("cybercom_playermovement", 0);
}

function take_weapons(b_save = 1) {
  a_w_old_weapons = self getweaponslist();
  foreach(w_weapon in a_w_old_weapons) {
    self takeweapon(w_weapon);
  }
  if(b_save) {
    self.a_w_old_weapons = a_w_old_weapons;
  }
}

function replace_cyber_abilities() {
  wait(0.05);
  self cybercom_gadget::takeallabilities();
  switch (level.skipto_current_objective[0]) {
    case "factory_alley":
    case "factory_factory_exterior":
    case "factory_factory_intro_igc":
    case "factory_foundry":
    case "factory_inside_man_igc":
    case "factory_vat_room":
    case "factory_warehouse":
    case "white_infinite_igc": {
      if(isDefined(level.var_b7a27741) && level.var_b7a27741) {
        self cybercom_gadget::giveability("cybercom_hijack", 0);
        self cybercom_gadget::equipability("cybercom_hijack", 1);
      }
      break;
    }
    case "chase_apartment_igc":
    case "chase_bridge_collapse":
    case "chase_chase_start":
    case "chase_construction_site":
    case "chase_glass_ceiling_igc":
    case "chase_old_zurich":
    case "chase_rooftops": {
      if(isDefined(level.var_ebe3b234) && level.var_ebe3b234) {
        self cybercom_gadget::giveability("cybercom_systemoverload", 0);
        self cybercom_gadget::equipability("cybercom_systemoverload", 1);
      }
      break;
    }
    case "underground_construction":
    case "underground_crossroads":
    case "underground_maintenance":
    case "underground_pinned_down_igc":
    case "underground_staging_room_igc":
    case "underground_subway":
    case "underground_water_plant": {
      if(isDefined(level.var_e120c906) && level.var_e120c906) {
        self cybercom_gadget::giveability("cybercom_fireflyswarm", 1);
      }
      if(isDefined(level.var_11d004e5) && level.var_11d004e5) {
        self cybercom_gadget::giveability("cybercom_immolation", 0);
        self cybercom_gadget::equipability("cybercom_immolation", 1);
      }
      break;
    }
    case "train_detach_bomb_igc":
    case "train_inbound_igc":
    case "train_train_roof":
    case "train_train_start": {
      if(isDefined(level.var_fbc6080) && level.var_fbc6080) {
        self cybercom_gadget::giveability("cybercom_concussive", 1);
      }
      self cybercom_gadget::giveability("cybercom_rapidstrike", 0);
      self cybercom_gadget::equipability("cybercom_rapidstrike");
      break;
    }
    default: {
      break;
    }
  }
}

function function_7ee91bc9() {
  foreach(player in level.players) {
    if(player != self) {
      if(isDefined(player.b_tactical_mode_enabled) && player.b_tactical_mode_enabled) {
        return true;
      }
    }
  }
  return false;
}

function function_1cf75ffb() {
  foreach(player in level.players) {
    if(player != self) {
      if(isDefined(player.b_enhanced_vision_enabled) && player.b_enhanced_vision_enabled) {
        return true;
      }
    }
  }
  return false;
}

function function_1943bf79() {
  var_33dcf6cf = 0;
  var_1dedaef1 = 0;
  switch (level.skipto_current_objective[0]) {
    case "factory_factory_exterior":
    case "factory_factory_intro_igc":
    case "white_infinite_igc": {
      if(isDefined(level.var_9ef26e4f) && level.var_9ef26e4f) {
        var_1dedaef1 = 1;
      } else {
        var_1dedaef1 = 0;
      }
      var_33dcf6cf = 0;
      break;
    }
    case "chase_apartment_igc":
    case "chase_bridge_collapse":
    case "chase_chase_start":
    case "chase_construction_site":
    case "chase_glass_ceiling_igc":
    case "chase_old_zurich":
    case "chase_rooftops":
    case "factory_alley":
    case "factory_foundry":
    case "factory_inside_man_igc":
    case "factory_vat_room":
    case "factory_warehouse":
    case "underground_construction":
    case "underground_crossroads":
    case "underground_pinned_down_igc":
    case "underground_subway": {
      var_1dedaef1 = 1;
      if(isDefined(level.var_74f7a02e) && level.var_74f7a02e) {
        var_33dcf6cf = 1;
      } else {
        var_33dcf6cf = 0;
      }
      break;
    }
    case "train_detach_bomb_igc":
    case "train_inbound_igc":
    case "train_train_roof":
    case "train_train_start":
    case "underground_maintenance":
    case "underground_staging_room_igc":
    case "underground_water_plant": {
      var_1dedaef1 = 1;
      var_33dcf6cf = 1;
      break;
    }
    default: {
      break;
    }
  }
  println(((("" + var_1dedaef1) + "") + var_33dcf6cf) + "");
  self function_a7cfc593(var_1dedaef1);
  self function_ba1a260f(var_33dcf6cf);
}

function player_snow_fx() {
  switch (level.skipto_current_objective[0]) {
    case "white_infinite_igc": {
      level clientfield::set("player_snow_fx", 4);
      break;
    }
    case "factory_alley":
    case "factory_factory_exterior":
    case "factory_factory_intro_igc":
    case "factory_foundry":
    case "factory_inside_man_igc":
    case "factory_vat_room":
    case "factory_warehouse": {
      level clientfield::set("player_snow_fx", 1);
      break;
    }
    case "chase_apartment_igc":
    case "chase_bridge_collapse":
    case "chase_chase_start":
    case "chase_construction_site":
    case "chase_glass_ceiling_igc":
    case "chase_old_zurich":
    case "chase_rooftops": {
      level clientfield::set("player_snow_fx", 2);
      break;
    }
    case "underground_construction":
    case "underground_crossroads":
    case "underground_maintenance":
    case "underground_pinned_down_igc":
    case "underground_staging_room_igc":
    case "underground_subway":
    case "underground_water_plant": {
      level clientfield::set("player_snow_fx", 3);
      break;
    }
    case "train_inbound_igc":
    case "train_train_roof":
    case "train_train_start": {
      level clientfield::set("player_snow_fx", 4);
      break;
    }
    case "train_detach_bomb_igc":
    case "waking_up_igc": {
      level clientfield::set("player_snow_fx", 0);
      break;
    }
    default: {
      break;
    }
  }
}

function function_85d8906c() {
  level clientfield::set("player_snow_fx", 0);
}

function ai_death_derez() {
  if(self should_derez_on_death()) {
    self thread derez_when_actor_becomes_corpse();
    self thread derez_on_ragdoll_start();
  }
}

function should_derez_on_death() {
  return !isvehicle(self);
}

function derez_when_actor_becomes_corpse() {
  self endon("ai_derez_death");
  self waittill("actor_corpse", e_corpse);
  if(isDefined(level.player_on_top_of_train) && level.player_on_top_of_train) {
    wait(10);
  }
  if(isDefined(e_corpse)) {
    e_corpse clientfield::set("derez_ai_deaths", 1);
  }
  util::wait_network_frame();
  wait(0.1);
  if(isDefined(e_corpse)) {
    e_corpse delete();
  }
  if(isDefined(self)) {
    self notify("ai_derez_death");
  }
}

function derez_on_ragdoll_start() {
  self endon("ai_derez_death");
  self waittill("start_ragdoll");
  if(isDefined(level.player_on_top_of_train) && level.player_on_top_of_train) {
    wait(10);
  } else if(self.b_balcony_death === 1) {
    wait(4);
  }
  if(isDefined(self)) {
    self clientfield::set("derez_ai_deaths", 1);
  }
  util::wait_network_frame();
  wait(0.1);
  if(isDefined(self)) {
    self delete();
    self notify("ai_derez_death");
  }
}

function function_523cdc93(var_9e5eb4d9 = 1) {
  if(isDefined(var_9e5eb4d9) && var_9e5eb4d9) {
    self waittill("damage", damage, attacker);
    self thread function_91b16538();
    self thread function_4ccc51b5();
  }
  if(isDefined(self)) {
    self clientfield::set("derez_ai_deaths", 1);
  }
  util::wait_network_frame();
  wait(0.25);
  if(isDefined(attacker) && isPlayer(attacker)) {
    attacker thread newworld_rooftops::function_8e9219f();
  }
  if(isDefined(self)) {
    self notify("hash_ed74b5db");
    self delete();
  }
}

function function_91b16538() {
  self endon("hash_ed74b5db");
  self waittill("start_ragdoll");
  wait(0.25);
  if(isDefined(self)) {
    self delete();
    self notify("hash_ed74b5db");
  }
}

function function_4ccc51b5() {
  self endon("hash_ed74b5db");
  self waittill("actor_corpse", e_corpse);
  wait(0.25);
  if(isDefined(e_corpse)) {
    e_corpse delete();
  }
  if(isDefined(self)) {
    self notify("hash_ed74b5db");
  }
}

function wait_till_flag_or_ai_group_ai_count(str_flag, str_aigroup, n_count) {
  if(flag::get(str_flag)) {
    return;
  }
  level endon(str_flag);
  spawner::waittill_ai_group_ai_count(str_aigroup, int(n_count));
}

function function_948d4091(var_81a32895, var_2380d5c = 0, str_endon, b_looping = 1, var_6e6341cf, var_8cb8bcef, var_9e68f294) {
  self endon("death");
  level endon(str_endon);
  if(isDefined(30)) {
    __s = spawnStruct();
    __s endon("timeout");
    __s util::delay_notify(30, "timeout");
  }
  self flag::init(var_81a32895 + "_WW_opened");
  self flag::init(var_81a32895 + "_WW_closed");
  self flag::init(var_81a32895 + "_WW_tutorial");
  if(var_81a32895 == "cybercom_fireflyswarm") {
    var_bcb7a46f = &"CP_MI_ZURICH_NEWWORLD_SELECT_FIREFLY_LINE_1";
  } else if(var_81a32895 == "cybercom_concussive") {
    var_bcb7a46f = &"CP_MI_ZURICH_NEWWORLD_SELECT_CONCUSSIVE_WAVE_LINE_1";
  }
  self thread function_8531ac12(var_81a32895, str_endon);
  self thread function_b95b168e(var_81a32895, str_endon);
  if(isDefined(var_9e68f294)) {
    a_start_flags = array(var_9e68f294, var_81a32895 + "_WW_tutorial");
    self flag::wait_till_any(a_start_flags);
  }
  a_flags = array(var_81a32895 + "_WW_tutorial", var_81a32895 + "_WW_closed");
  while(!self flag::get(var_81a32895 + "_WW_tutorial")) {
    self function_c585d78f(var_81a32895, str_endon);
    self thread util::hide_hint_text(1);
    wait(0.5);
    while(!self flag::get(var_81a32895 + "_WW_tutorial") && self flag::get(var_81a32895 + "_WW_opened")) {
      self thread function_e5122074(var_bcb7a46f, str_endon);
      self flag::wait_till_any_timeout(4, a_flags);
      if(!self flag::get(var_81a32895 + "_WW_tutorial") && self flag::get(var_81a32895 + "_WW_opened")) {
        self flag::wait_till_any_timeout(3, a_flags);
      }
    }
    self thread function_d81a8f6f();
  }
  self thread function_6062e90(var_81a32895, var_2380d5c, str_endon, b_looping, var_6e6341cf, undefined, var_8cb8bcef);
}

function function_c585d78f(var_81a32895, str_endon) {
  self endon("death");
  level endon(str_endon);
  self endon(var_81a32895 + "_WW_opened");
  if(isDefined(30)) {
    __s = spawnStruct();
    __s endon("timeout");
    __s util::delay_notify(30, "timeout");
  }
  self util::hide_hint_text(1);
  while(!self flag::get(var_81a32895 + "_WW_opened")) {
    if(!level.console && !self gamepadusedlast()) {
      self thread util::show_hint_text(&"CP_MI_ZURICH_NEWWORLD_OPEN_CYBERCORE_ABILITY_WHEEL_KB", 0, undefined, 4);
    } else {
      self thread util::show_hint_text(&"CP_MI_ZURICH_NEWWORLD_OPEN_CYBERCORE_ABILITY_WHEEL", 0, undefined, 4);
    }
    self flag::wait_till_timeout(4, var_81a32895 + "_WW_opened");
    if(!self flag::get(var_81a32895 + "_WW_opened")) {
      self flag::wait_till_timeout(3, var_81a32895 + "_WW_opened");
    }
  }
}

function function_e5122074(var_bcb7a46f, str_endon) {
  self endon("death");
  self endon(str_endon);
  self.var_bb5e2d77 = self openluimenu("CyberComTutorial");
  self setluimenudata(self.var_bb5e2d77, "tutorial_line_1", var_bcb7a46f);
  if(level.console || self gamepadusedlast()) {
    self setluimenudata(self.var_bb5e2d77, "tutorial_line_2", &"CP_MI_ZURICH_NEWWORLD_EQUIP_CYBERCORE");
  }
  wait(4);
  self thread function_d81a8f6f();
}

function function_d81a8f6f() {
  self endon("death");
  if(isDefined(self.var_bb5e2d77)) {
    lui::play_animation(self.var_bb5e2d77, "fadeout");
    wait(0.1);
    self closeluimenu(self.var_bb5e2d77);
  }
}

function function_8531ac12(var_81a32895, str_endon) {
  self endon("death");
  level endon(str_endon);
  if(isDefined(30)) {
    __s = spawnStruct();
    __s endon("timeout");
    __s util::delay_notify(30, "timeout");
  }
  while(!self flag::get(var_81a32895 + "_WW_tutorial")) {
    self waittill("menuresponse", menu, response);
    var_66700f08 = strtok(response, ",");
    if(var_66700f08[0] == "opened") {
      self flag::set(var_81a32895 + "_WW_opened");
      self flag::clear(var_81a32895 + "_WW_closed");
    }
  }
}

function function_b95b168e(var_81a32895, str_endon) {
  self endon("death");
  level endon(str_endon);
  if(isDefined(30)) {
    __s = spawnStruct();
    __s endon("timeout");
    __s util::delay_notify(30, "timeout");
  }
  while(true) {
    self waittill("menuresponse", menu, response);
    var_66700f08 = strtok(response, ",");
    if(var_66700f08[0] == "opened") {
      continue;
    }
    if(var_66700f08[0] == var_81a32895) {
      self flag::set(var_81a32895 + "_WW_tutorial");
      break;
    } else {
      self flag::clear(var_81a32895 + "_WW_opened");
      self flag::set(var_81a32895 + "_WW_closed");
    }
  }
}

function function_6062e90(var_81a32895, var_2380d5c = 0, str_endon, b_looping = 1, var_6e6341cf, var_e8551372, var_9e68f294, var_3945b2c8) {
  self endon("death");
  if(isarray(str_endon)) {
    foreach(str_condition in str_endon) {
      level endon(str_condition);
    }
  } else {
    level endon(str_endon);
  }
  if(isDefined(var_3945b2c8)) {
    self endon(var_3945b2c8);
  }
  if(sessionmodeiscampaignzombiesgame()) {
    return;
  }
  self gadgetpowerset(0, 100);
  self gadgetpowerset(1, 100);
  var_279df5c8 = 0;
  if(var_81a32895 == "cybercom_fireflyswarm" || var_81a32895 == "cybercom_rapidstrike" || var_81a32895 == "cybercom_concussive") {
    var_279df5c8 = 1;
  }
  if(isDefined(30)) {
    __s = spawnStruct();
    __s endon("timeout");
    __s util::delay_notify(30, "timeout");
  }
  if(!self flag::exists(var_81a32895 + "_use_ability_tutorial")) {
    self flag::init(var_81a32895 + "_use_ability_tutorial");
  } else {
    self flag::clear(var_81a32895 + "_use_ability_tutorial");
  }
  self thread function_a7a2da7e(var_81a32895, var_2380d5c, str_endon);
  if(isDefined(var_9e68f294)) {
    if(isfloat(var_9e68f294) || isint(var_9e68f294)) {
      n_wait = var_9e68f294;
      wait(n_wait);
    } else {
      if(self flag::exists(var_9e68f294)) {
        self flag::wait_till(var_9e68f294);
      } else if(level flag::exists(var_9e68f294)) {
        level flag::wait_till(var_9e68f294);
      }
    }
  }
  while(!self flag::get(var_81a32895 + "_use_ability_tutorial")) {
    self function_c60fae50(var_81a32895, str_endon, b_looping, var_6e6341cf);
    if(!var_279df5c8) {
      self function_5dca74fc(var_81a32895, str_endon, var_e8551372);
    }
  }
}

function function_c60fae50(var_81a32895, str_endon, b_looping, var_f069395f) {
  self endon("death");
  if(isarray(str_endon)) {
    foreach(str_condition in str_endon) {
      level endon(str_condition);
    }
  } else {
    level endon(str_endon);
  }
  self endon(var_81a32895 + "_primed");
  if(isDefined(30)) {
    __s = spawnStruct();
    __s endon("timeout");
    __s util::delay_notify(30, "timeout");
  }
  while(!self flag::get(var_81a32895 + "_use_ability_tutorial")) {
    if(isDefined(var_f069395f)) {
      self thread util::show_hint_text(var_f069395f, 0, undefined, 4);
    } else {
      self thread util::show_hint_text(&"CP_MI_ZURICH_NEWWORLD_USE_CYBERCORE", 0, undefined, 4);
    }
    if(b_looping === 1) {
      if(!self flag::get(var_81a32895 + "_use_ability_tutorial")) {
        self flag::wait_till_timeout(3, var_81a32895 + "_use_ability_tutorial");
      }
    } else {
      break;
    }
  }
}

function function_5dca74fc(var_81a32895, str_endon, var_e8551372) {
  self endon("death");
  if(isarray(str_endon)) {
    foreach(str_condition in str_endon) {
      level endon(str_condition);
    }
  } else {
    level endon(str_endon);
  }
  self endon(var_81a32895 + "_off");
  if(isDefined(30)) {
    __s = spawnStruct();
    __s endon("timeout");
    __s util::delay_notify(30, "timeout");
  }
  self util::hide_hint_text(1);
  while(!self flag::get(var_81a32895 + "_use_ability_tutorial")) {
    level waittill("ccom_locked_on", ent, e_player);
    if(e_player == self) {
      self function_e52b73c0(var_81a32895, str_endon, var_e8551372);
    }
  }
}

function function_e52b73c0(var_81a32895, str_endon, var_f069395f) {
  self endon("death");
  if(isarray(str_endon)) {
    foreach(str_condition in str_endon) {
      level endon(str_condition);
    }
  } else {
    level endon(str_endon);
  }
  self endon(var_81a32895 + "_off");
  if(isDefined(30)) {
    __s = spawnStruct();
    __s endon("timeout");
    __s util::delay_notify(30, "timeout");
  }
  self endon("hash_5e2557e1");
  self thread function_e84823a9(var_81a32895, str_endon);
  wait(0.8);
  self util::show_hint_text(var_f069395f, 0, undefined, 4);
  if(!self flag::get(var_81a32895 + "_use_ability_tutorial")) {
    self flag::wait_till_timeout(3, var_81a32895 + "_use_ability_tutorial");
  }
}

function function_e84823a9(var_81a32895, str_endon) {
  self endon("death");
  if(isarray(str_endon)) {
    foreach(str_condition in str_endon) {
      level endon(str_condition);
    }
  } else {
    level endon(str_endon);
  }
  self endon(var_81a32895 + "_off");
  if(isDefined(30)) {
    __s = spawnStruct();
    __s endon("timeout");
    __s util::delay_notify(30, "timeout");
  }
  while(true) {
    level waittill("ccom_lost_lock", ent, e_player);
    if(e_player == self) {
      if(isDefined(self.cybercom) && self.cybercom.lock_targets.size < 1) {
        self notify("hash_5e2557e1");
        self util::hide_hint_text(1);
        return;
      }
    }
  }
}

function function_a7a2da7e(var_81a32895, var_2380d5c = 0, str_endon) {
  self endon("death");
  if(isarray(str_endon)) {
    foreach(str_condition in str_endon) {
      level endon(str_condition);
    }
  } else {
    level endon(str_endon);
  }
  if(isDefined(30)) {
    __s = spawnStruct();
    __s endon("timeout");
    __s util::delay_notify(30, "timeout");
  }
  weapon = function_71840183(var_81a32895, var_2380d5c);
  self waittill(weapon.name + "_fired");
  self flag::set(var_81a32895 + "_use_ability_tutorial");
  level notify(var_81a32895 + "_use_ability_tutorial");
  self util::hide_hint_text(1);
}

function function_71840183(var_81a32895, var_2380d5c = 0) {
  weapon = undefined;
  ability = cybercom_gadget::getabilitybyname(var_81a32895);
  if(var_2380d5c == 1) {
    weapon = ability.weaponupgraded;
  } else {
    weapon = ability.weapon;
  }
  return weapon;
}

function function_2e7b4007() {
  self endon("death");
  level endon("hash_982eac9f");
  self.var_8a320fc6 = 0;
  var_6d5d984c = function_71840183("cybercom_immolation");
  var_bb989cf4 = var_6d5d984c.name + "_fired";
  var_239727aa = function_71840183("cybercom_fireflyswarm", 1);
  var_aa2f1c54 = var_239727aa.name + "_fired";
  self thread function_6851db33(var_6d5d984c, var_239727aa);
  while(true) {
    self util::waittill_any(var_bb989cf4, var_aa2f1c54);
    self notify("hash_33cbd3b4");
    self.var_8a320fc6++;
  }
}

function function_6851db33(var_3283f77e, var_239727aa) {
  self endon("death");
  level endon("hash_982eac9f");
  while(true) {
    wait(90);
    if(self.var_8a320fc6 < 1) {
      self notify("hash_6851db33");
      if(self._gadgets_player[0] === var_3283f77e) {
        self thread function_6062e90("cybercom_immolation", 0, "underground_combat_complete", 1, "CP_MI_ZURICH_NEWWORLD_IMMOLATION_TARGET", "CP_MI_ZURICH_NEWWORLD_IMMOLATION_RELEASE");
      } else if(self._gadgets_player[0] === var_239727aa) {
        self thread function_6062e90("cybercom_fireflyswarm", 1, "underground_combat_complete", 1, "CP_MI_ZURICH_NEWWORLD_FIREFLY_SWARM_TUTORIAL");
      }
      self util::waittill_any_timeout(4, "cc_ability_used");
      self thread util::hide_hint_text(1);
    } else {
      return;
    }
  }
}

function function_70176ad6() {
  self endon("death");
  if(self function_c633d8fe()) {
    return;
  }
  if(!isDefined(self.var_98bf72c3)) {
    self.var_98bf72c3 = 0;
  }
  while(self.var_98bf72c3 < 3) {
    self waittill("gadget_denied_activation", n_slot, var_2de327e8);
    if(var_2de327e8 == 1) {
      self.var_98bf72c3++;
      self util::show_hint_text(&"CP_MI_ZURICH_NEWWORLD_CYBERCOM_RECHARGE", 0, undefined, 4);
      level notify("hash_76cbcc2f");
      wait(30);
    }
  }
}

function function_520255e3(str_trigger, time) {
  str_notify = "mufc_" + str_trigger;
  level thread function_901793d(str_trigger, str_notify);
  level thread function_2ffbaa00(time, str_notify);
  level waittill(str_notify);
}

function function_901793d(str_trigger, str_notify) {
  level endon(str_notify);
  e_trigger = getent(str_trigger, "targetname");
  if(isDefined(e_trigger)) {
    e_trigger waittill("trigger");
  }
  level notify(str_notify);
}

function function_2ffbaa00(time, str_notify) {
  level endon(str_notify);
  wait(time);
  level notify(str_notify);
}

function function_f29e6c6d(var_7daa2a51) {
  a_spawners = getEntArray(var_7daa2a51, "targetname");
  for(i = 0; i < a_spawners.size; i++) {
    a_spawners[i] thread function_9a829e81();
  }
}

function function_9a829e81() {
  if(isDefined(self.script_delay)) {
    wait(self.script_delay);
  }
  e_ent = self spawner::spawn();
  e_ent endon("death");
  if(isDefined(e_ent.script_noteworthy) && e_ent.script_noteworthy == "rusher_on_spawn") {
    e_ent ai::set_behavior_attribute("move_mode", "rusher");
    e_ent ai::set_behavior_attribute("sprint", 1);
  }
  if(isDefined(e_ent.target)) {
    e_ent waittill("goal");
  }
  if(isDefined(e_ent.script_noteworthy) && e_ent.script_noteworthy == "rusher_at_goal") {
    e_ent ai::set_behavior_attribute("move_mode", "rusher");
    e_ent ai::set_behavior_attribute("sprint", 1);
  }
}

function function_68b8f4af(e_volume) {
  a_ai = getaiteamarray("axis");
  a_touching = [];
  for(i = 0; i < a_ai.size; i++) {
    if(a_ai[i] istouching(e_volume)) {
      a_touching[a_touching.size] = a_ai[i];
    }
  }
  return a_touching;
}

function function_c478189b(str_trigger, var_390543cc, var_9d774f5d, var_43a68d40) {
  if(isDefined(str_trigger)) {
    e_trigger = getent(str_trigger, "targetname");
    e_trigger waittill("trigger");
  }
  var_441bd962 = getent(var_390543cc, "targetname");
  var_ee2fd889 = getent(var_9d774f5d, "targetname");
  a_ai = getaiteamarray("axis");
  if(!isDefined(var_43a68d40)) {
    var_43a68d40 = a_ai.size;
  }
  if(var_43a68d40 > a_ai.size) {
    var_43a68d40 = a_ai.size;
  }
  for(i = 0; i < var_43a68d40; i++) {
    e_ent = a_ai[i];
    if(e_ent istouching(var_441bd962)) {
      e_ent setgoalvolume(var_ee2fd889);
    }
  }
}

function function_f5363f47(str_trigger) {
  a_triggers = getEntArray(str_trigger, "targetname");
  str_notify = str_trigger + "_waiting";
  for(i = 0; i < a_triggers.size; i++) {
    level thread function_7eb8a7ab(a_triggers[i], str_notify);
  }
  level waittill(str_notify);
}

function function_7eb8a7ab(e_trigger, str_notify) {
  level endon(str_notify);
  e_trigger waittill("trigger");
  level notify(str_notify);
}

function num_players_touching_volume(e_volume) {
  a_players = getplayers();
  num_touching = 0;
  for(i = 0; i < a_players.size; i++) {
    if(a_players[i] istouching(e_volume)) {
      num_touching++;
    }
  }
  return num_touching;
}

function function_e0fb6da9(str_struct, close_dist, wait_time_min, wait_time_max, var_d1b83750, max_ai, var_a70db4af, var_1813646e, var_98e9bc46) {
  a_players = getplayers();
  if(a_players.size > 1) {
    return;
  }
  s_struct = struct::get(str_struct, "targetname");
  var_37124366 = getent(var_1813646e, "targetname");
  var_7d22b48e = getent(var_98e9bc46, "targetname");
  v_forward = anglesToForward(s_struct.angles);
  s_struct.start_time = undefined;
  var_cc06a93d = 0;
  wait_time = randomintrange(wait_time_min, wait_time_max);
  while(true) {
    e_player = getplayers()[0];
    v_dir = s_struct.origin - e_player.origin;
    var_989d1f7c = vectordot(v_dir, v_forward);
    if(var_989d1f7c < -100) {
      return;
    }
    dist = distance(s_struct.origin, e_player.origin);
    if(dist < close_dist) {
      if(!isDefined(s_struct.start_time)) {
        s_struct.start_time = gettime();
      }
    } else {
      s_struct.start_time = undefined;
    }
    if(isDefined(s_struct.start_time)) {
      time = gettime();
      dt = (time - s_struct.start_time) / 1000;
      if(dt > wait_time) {
        a_ai = getaiteamarray("axis");
        a_touching = [];
        for(i = 0; i < a_ai.size; i++) {
          e_ent = a_ai[i];
          if(!isDefined(e_ent.var_db552f4)) {
            if(e_ent istouching(var_37124366)) {
              a_touching[a_touching.size] = e_ent;
            }
          }
        }
        var_d6f9eed8 = randomintrange(var_d1b83750, max_ai + 1);
        if(var_d6f9eed8 > a_touching.size) {
          var_d6f9eed8 = a_touching.size;
        }
        for(i = 0; i < var_d6f9eed8; i++) {
          a_touching[i] setgoal(var_7d22b48e);
          a_touching[i].var_db552f4 = 1;
        }
        s_struct.start_time = undefined;
        var_cc06a93d++;
        if(var_cc06a93d >= var_a70db4af) {
          return;
        }
        wait_time = randomintrange(wait_time_min, wait_time_max);
      }
    }
    wait(0.05);
  }
}

function function_8f7b1e06(str_trigger, var_390543cc, var_9d774f5d) {
  if(isDefined(str_trigger)) {
    e_trigger = getent(str_trigger, "targetname");
    e_trigger waittill("trigger");
  }
  var_441bd962 = getent(var_390543cc, "targetname");
  var_ee2fd889 = getent(var_9d774f5d, "targetname");
  a_ai = getaiteamarray("axis");
  for(i = 0; i < a_ai.size; i++) {
    e_ent = a_ai[i];
    if(e_ent istouching(var_441bd962)) {
      e_ent setgoalvolume(var_ee2fd889);
    }
  }
}

function function_bccc2e65(str_aigroup, var_6ec47843, str_node, goal_radius) {
  spawner::waittill_ai_group_ai_count("aig_water_treatment", var_6ec47843);
  nd_node = getnode(str_node, "targetname");
  a_ai = getEntArray(str_aigroup, "script_aigroup");
  for(i = 0; i < a_ai.size; i++) {
    e_ent = a_ai[i];
    if(issentient(e_ent)) {
      e_ent.goalradius = goal_radius;
      e_ent setgoal(nd_node.origin);
    }
  }
}

function movie_transition(str_movie_name, var_e0017db3 = "fullscreen", var_43656dbb = 0) {
  level post_fx_transitions(str_movie_name, var_e0017db3, var_43656dbb);
}

function post_fx_transitions(str_movie_name, var_e0017db3 = "fullscreen", var_43656dbb) {
  if(var_43656dbb) {
    foreach(player in level.players) {
      player clientfield::increment_to_player("postfx_futz", 1);
    }
  }
  lui::play_movie(str_movie_name, var_e0017db3);
  if(var_43656dbb) {
    foreach(player in level.players) {
      player clientfield::increment_to_player("postfx_futz", 1);
    }
  }
}

function function_30ec5bf7(b_starting = 0) {
  if(b_starting) {
    level flag::set("infinite_white_transition");
    lock_player_controls(1);
    util::screen_fade_out(0, "white", "infinite_white");
  } else {
    level flag::wait_till("infinite_white_transition");
    lui::prime_movie("cp_newworld_fs_whiteinfinite", 1);
    lock_player_controls(1);
    util::screen_fade_out(0.5, "white", "infinite_white");
    level thread lui::play_movie("cp_newworld_fs_whiteinfinite", "fullscreen", 0, 1);
  }
  level flag::wait_till_clear("infinite_white_transition");
  foreach(e_player in level.activeplayers) {
    e_player notify("menuresponse", "FullscreenMovie", "finished_movie_playback");
  }
  util::screen_fade_in(0.5, "white", "infinite_white");
  lock_player_controls(0);
  videostop("cp_newworld_fs_whiteinfinite");
}

function function_43dfaf16(a_ents) {
  foreach(player in level.activeplayers) {
    player notify("menuresponse", "FullscreenMovie", "finished_movie_playback");
  }
}

function lock_player_controls(var_a5efd39d = 1) {
  foreach(player in level.activeplayers) {
    if(var_a5efd39d) {
      player enableinvulnerability();
    } else {
      player disableinvulnerability();
    }
    player util::freeze_player_controls(var_a5efd39d);
  }
}

function function_16dd8c5f(str_triggername, str_type = &"cp_level_newworld_access_door", str_hint = &"CP_MI_ZURICH_NEWWORLD_HACK", var_8baec92b, var_2df3d133, var_d78830f5 = 0) {
  t_interact = getent(str_triggername, "targetname");
  t_interact triggerenable(1);
  if(isDefined(var_8baec92b)) {
    var_69f96d87 = getEntArray(var_8baec92b, "targetname");
  } else {
    var_69f96d87 = [];
  }
  if(!var_d78830f5) {
    s_gameobject = util::init_interactive_gameobject(t_interact, str_type, str_hint, &function_e27a8082, var_69f96d87);
    s_gameobject.var_2df3d133 = var_2df3d133;
    level waittill(var_2df3d133, e_player);
  } else {
    t_interact hacking::init_hack_trigger(1, str_type, str_hint, undefined, var_69f96d87);
    t_interact hacking::trigger_wait();
  }
  if(isDefined(var_2df3d133)) {
    level notify(var_2df3d133);
  }
  if(isDefined(e_player)) {
    return e_player;
  }
}

function function_e27a8082(e_player) {
  self gameobjects::disable_object();
  level notify(self.var_2df3d133, e_player);
}

function function_39c9b63e(b_enable = 1, var_98011344) {
  a_caches = getEntArray("ammo_cache", "script_noteworthy");
  foreach(e_ammo_cache in a_caches) {
    if(isDefined(e_ammo_cache.gameobject) && (e_ammo_cache.script_objective === var_98011344 || !isDefined(var_98011344))) {
      if(!b_enable) {
        e_ammo_cache oed::disable_thermal();
        e_ammo_cache oed::disable_keyline();
        e_ammo_cache.gameobject gameobjects::disable_object();
        continue;
      }
      e_ammo_cache.gameobject gameobjects::enable_object();
      e_ammo_cache oed::enable_thermal();
      e_ammo_cache oed::enable_keyline();
    }
  }
}

function function_95132241() {
  self endon("death");
  b_can_delete = 0;
  while(b_can_delete == 0) {
    wait(1);
    foreach(e_player in level.activeplayers) {
      if(e_player util::is_player_looking_at(self.origin) == 0) {
        b_can_delete = 1;
        continue;
      }
      b_can_delete = 0;
    }
  }
  self util::stop_magic_bullet_shield();
  self kill();
}

function function_c1c980d8(str_trigger) {
  a_enemies = getaiteamarray("axis");
  t_trigger = getent(str_trigger, "targetname");
  assert(isDefined(t_trigger), "");
  foreach(enemy in a_enemies) {
    if(isalive(enemy) && enemy istouching(t_trigger)) {
      enemy thread function_95132241();
    }
  }
  t_trigger delete();
}

function function_c949a8ed(var_b06baa1b = 0) {
  self thread function_e44cc74b(var_b06baa1b);
  self playSound("evt_ai_derez");
  if(var_b06baa1b) {
    self clientfield::increment("cs_rez_in_fx", 2);
  } else {
    self clientfield::increment("cs_rez_in_fx", 1);
  }
}

function function_e44cc74b(var_b06baa1b) {
  self endon("death");
  if(var_b06baa1b) {
    if(self.animname == "hall") {
      self setModel("c_hro_sarah_salvation_reveal");
    } else if(!(isDefined(self.isdying) && self.isdying)) {
      self setModel(("c_hro_" + self.animname) + "_base_rev");
    }
    util::wait_network_frame();
    self show();
    wait(0.5);
    if(self.animname == "hall") {
      self setModel("c_hro_sarah_base");
    } else if(!(isDefined(self.isdying) && self.isdying)) {
      self setModel(("c_hro_" + self.animname) + "_base");
    }
  } else {
    wait(0.4);
    self show();
  }
}

function function_4943984c(var_b06baa1b = 0) {
  self thread function_9ab5a5ab(var_b06baa1b);
  self playSound("evt_ai_derez");
  if(var_b06baa1b) {
    self clientfield::increment("cs_rez_out_fx", 2);
  } else {
    self clientfield::increment("cs_rez_out_fx", 1);
  }
}

function function_9ab5a5ab(var_b06baa1b) {
  self endon("death");
  if(var_b06baa1b) {
    if(self.animname == "hall") {
      self setModel("c_hro_sarah_salvation_reveal");
    } else if(!(isDefined(self.isdying) && self.isdying)) {
      self setModel(("c_hro_" + self.animname) + "_base_rev");
    }
    wait(0.5);
    self ghost();
    if(self.animname == "hall") {
      self setModel("c_hro_sarah_base");
    } else if(!(isDefined(self.isdying) && self.isdying)) {
      self setModel(("c_hro_" + self.animname) + "_base");
    }
  } else {
    wait(0.4);
    self ghost();
  }
}

function function_d0aa2f4f(n_delay = 0.25) {
  self endon("death");
  self function_4943984c();
  wait(0.4);
  self util::delay(n_delay, undefined, &function_c949a8ed);
}

function function_737d2864(str_location, str_time) {
  if(sessionmodeiscampaignzombiesgame()) {
    return;
  }
  self endon("death");
  wait(3);
  self.var_55167309 = self openluimenu("LocationAndTime");
  self setluimenudata(self.var_55167309, "loctime_location", str_location);
  self setluimenudata(self.var_55167309, "loctime_date", str_time);
  wait(5);
  lui::play_animation(self.var_55167309, "fadeout");
  wait(1.3);
  self closeluimenu(self.var_55167309);
}

function function_c633d8fe() {
  if(sessionmodeiscampaignzombiesgame()) {
    return 1;
  }
  assert(isPlayer(self));
  return self getdstat("PlayerStatsByMap", "cp_mi_zurich_newworld", "hasBeenCompleted");
}

function function_81acf083() {
  var_ed60aa22 = 1;
  foreach(player in level.activeplayers) {
    if(!player function_c633d8fe()) {
      var_ed60aa22 = 0;
      break;
    }
  }
  return var_ed60aa22;
}

function function_70aba08e() {
  var_6a25d5b0 = 0;
  foreach(player in level.players) {
    if(player hascybercomability("cybercom_hijack")) {
      var_6a25d5b0 = 1;
      break;
    }
  }
  return var_6a25d5b0;
}

function function_3e37f48b(b_enabled) {
  if(sessionmodeiscampaignzombiesgame()) {
    return;
  }
  level flag::wait_till("all_players_connected");
  if(b_enabled) {
    foreach(e_player in level.activeplayers) {
      if(e_player function_c633d8fe()) {
        continue;
      }
      level notify("enable_cybercom", e_player);
    }
    callback::remove_on_spawned(&function_d17cfcf8);
  } else {
    foreach(e_player in level.activeplayers) {
      if(e_player function_c633d8fe()) {
        continue;
      }
      level notify("disable_cybercom", e_player, 1);
    }
    callback::on_spawned(&function_d17cfcf8);
  }
}

function function_d17cfcf8() {
  if(self function_c633d8fe()) {
    return;
  }
  level notify("disable_cybercom", self, 1);
}

function function_3196eaee(b_enabled = 1) {
  foreach(e_player in level.players) {
    e_player function_a7cfc593(b_enabled);
  }
}

function function_63c3869a(b_enabled = 1) {
  foreach(e_player in level.players) {
    e_player function_ba1a260f(b_enabled);
  }
}

function function_a7cfc593(b_enabled = 1) {
  if(self function_c633d8fe()) {
    return;
  }
  self.b_tactical_mode_enabled = b_enabled;
  if(!b_enabled) {
    self oed::tmode_activate_on_player(0);
  }
}

function function_ba1a260f(b_enabled = 1) {
  if(self function_c633d8fe()) {
    return;
  }
  println((("" + b_enabled) + "") + level.b_enhanced_vision_enabled);
  self.b_enhanced_vision_enabled = b_enabled;
  if(!b_enabled) {
    self oed::set_player_ev(0);
  }
}

function function_2eded728(b_enabled = 1) {
  if(b_enabled) {
    foreach(e_player in level.activeplayers) {
      e_player cybercom::cybercom_armpulse(1);
      e_player clientfield::increment_to_player("hack_dni_fx");
    }
  }
}

function scene_cleanup(str_scene_name) {
  if(scene::is_active(str_scene_name)) {
    scene::stop(str_scene_name, 1);
    util::wait_network_frame();
  }
  struct::delete_script_bundle("scene", str_scene_name);
}

function function_921d7387() {
  self endon("death");
  while(true) {
    level waittill("hash_921d7387");
    if(isDefined(self.var_30a16593) && self.var_30a16593) {
      continue;
    }
    wait(1);
    if(isDefined(self.is_talking) && self.is_talking) {
      continue;
    }
    self notify("scriptedbc", "generic_encourage");
    self.var_30a16593 = 1;
    self thread function_9464547d();
  }
}

function function_9464547d() {
  self endon("death");
  wait(30);
  self.var_30a16593 = 0;
}

function function_606dbca2(params) {
  if(self.team !== "axis") {
    return;
  }
  if(isPlayer(params.eattacker)) {
    level notify("hash_921d7387");
  }
}

function function_83a7d040() {
  util::wait_network_frame();
  util::wait_network_frame();
  util::wait_network_frame();
}