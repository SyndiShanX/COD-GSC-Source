/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\training_course.gsc
*******************************************************/

#using scripts\common\create_script_utility;
#using scripts\common\damage_effects;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\equipment;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\bradley_spawner;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\perks\perkpackage;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnscoring;
#using scripts\mp\supers;
#using scripts\mp\utility\dvars;
#using scripts\mp\utility\game;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\weapons;
#namespace training_course;

function main() {
  scripts\mp\globallogic::init();
  scripts\mp\globallogic::setupcallbacks();
  scripts\common\create_script_utility::initialize_create_script();
  scripts\mp\supers::function_22bff45fcf920417(0);
  allowed[0] = getgametype();
  scripts\mp\gameobjects::main(allowed);

  if(isusingmatchrulesdata()) {
    level.initializematchrules = &initializematchrules;
    [[level.initializematchrules]]();
    level thread reinitializematchrulesonmigration();
  } else {
    registerroundswitchdvar(getgametype(), 0, 0, 9);
    registertimelimitdvar(getgametype(), 1200);
    registerscorelimitdvar(getgametype(), 75);
    registerroundlimitdvar(getgametype(), 1);
    registerwinlimitdvar(getgametype(), 1);
    registernumlivesdvar(getgametype(), 0);
    registerhalftimedvar(getgametype(), 0);
    function_704789086c9ad943(getgametype(), 1);
  }

  flag_init("next_event");
  level.onplayerconnect = &player_onconnect;
  updategametypedvars();
  level.teambased = 1;
  level.onstartgametype = &function_7c2ee16bc35afc97;
  level.onnormaldeath = &onnormaldeath;
  level.modeonspawnplayer = &onspawnplayer;
  level.ontimelimit = &ontimelimit;
  level.weapondropfunction = &dropweaponfordeath;
  game["dialog"]["gametype"] = "iw9_mtdm_mode_uktl_name";
  game["dialog"]["boost"] = "iw9_mtdm_mode_uktl_bost";
  game["dialog"]["offense_obj"] = "iw9_mtdm_mode_uktl_bost";
  game["dialog"]["defense_obj"] = "iw9_mtdm_mode_uktl_bost";
  level.tdmanywhere_dropheight = getdvarfloat(@ "hash_c692d2a11dd6615", 1000);
  level.tdmanywhere_perpenoffset = getdvarfloat(@ "hash_631c58033f43c2dc", 2048);
  level.tdmanywhere_distoffset = getdvarfloat(@ "hash_f314048c87ae28aa", 4092);
}

function initializematchrules() {
  setcommonrulesfrommatchrulesdata();
  setdynamicdvar(@ "hash_6e7da31aae47b8e0", 0);
  registerhalftimedvar(getgametype(), 0);
  setdynamicdvar(@ "hash_bb6e8f8d9be104f4", 0);
  level.gametype = "training_course";
  setDvar(@ "hash_c11db9baa9e5bc9b", 1);
  setDvar(@ "scr_skip_infils", 1);
  setDvar(@ "hash_c653d32c30815d2b", 15);
  setDvar(@ "scr_game_matchstarttime", 6);
  setDvar(@ "hash_94af58bec500b3b9", 1);
  setDvar(@ "scr_outofboundstime", 5);
  setDvar(@ "hash_e4187d1543c7477e", 0);
  setDvar(@ "hash_a2e7d8fdf5d91dd9", 1);
  setDvar(@ "hash_e94e38873c94b670", 1);
  level.disablescoreevents = 1;
  level.var_92b187a00d3dd091 = 1;
  level.istrainingcourse = 1;
  level.forcedend = 1;
  level.var_10a1699461d4ad08 = 1;
  level.var_c94add55a8ad5938 = 1;
  level.roundenddelay = 0.5;

  if(getdvarint(@ "hash_19bfa9cf3a838b8") != 1) {
    setDvar(@ "hash_19bfa9cf3a838b8", 1);
  }
}

function init_outofbounds() {
  var_b5c4c97d744e491e = getEntArray("tutorialOOB", "targetname");
  var_4d5cf33d9458b576 = getEntArray("movingOOB", "targetname");
  var_1278addc4f398690 = level.outofboundstriggers;

  if(isDefined(var_b5c4c97d744e491e)) {
    foreach(oobtrigger in var_b5c4c97d744e491e) {
      oobtrigger.oobindex = var_1278addc4f398690.size;
      var_1278addc4f398690[var_1278addc4f398690.size] = oobtrigger;
    }
  }

  level.var_4d5cf33d9458b576 = [];

  if(isDefined(var_4d5cf33d9458b576)) {
    foreach(oobtrigger in var_4d5cf33d9458b576) {
      index = int(oobtrigger.script_noteworthy);
      oobtrigger.oobindex = index;
      level.var_4d5cf33d9458b576[index] = oobtrigger;
      var_1278addc4f398690[var_1278addc4f398690.size] = oobtrigger;
    }
  }

  level.outofboundstriggers = var_1278addc4f398690;
}

function function_7c390d67d182a2b6() {
  if(isDefined(level.var_4d5cf33d9458b576)) {
    foreach(trigger in level.var_4d5cf33d9458b576) {
      trigger.isdisabled = undefined;
    }
  }
}

function function_4f223e0dd031befb(index) {
  if(isDefined(level.var_4d5cf33d9458b576)) {
    oobtrigger = level.var_4d5cf33d9458b576[index];

    if(isDefined(oobtrigger)) {
      oobtrigger.isdisabled = 1;

      if(level.player istouching(oobtrigger)) {
        scripts\mp\outofbounds::disableoob(level.player);
      }
    }
  }
}

function init_gameobjects(var_f50f3f9183c1ad36, objectsarray) {
  level.targets = [];

  foreach(targetindex, target in var_f50f3f9183c1ad36) {
    target.health = 50;
    target.targetindex = targetindex;
    target.team = "axis";
    script_noteworthy = target.script_noteworthy;

    if(isDefined(script_noteworthy)) {
      if(!isDefined(level.targets[script_noteworthy])) {
        level.targets[script_noteworthy] = [];
      }

      level.targets[script_noteworthy] = array_add(level.targets[script_noteworthy], target);
      target function_7776a47aa86745dc();
    }
  }

  init_spawnpoints();
  var_bb4de8520fe416a1 = [];

  foreach(trigger in objectsarray["triggers"]) {
    index = int(trigger.script_noteworthy);
    trigger.index = index;
    var_bb4de8520fe416a1[index] = trigger;
  }

  level.actiontriggers = var_bb4de8520fe416a1;
  level.weaponspawnstruct = objectsarray["weapon"];
  level.var_5372f0b80988f4e5 = objectsarray["care_package"];
  level.objectivemarkers = [];
}

function init_spawnpoints() {
  level.currentspawnpointindex = 1;
  level.var_9317edc858b1ea66 = [];

  for(i = 1; i <= 6; i++) {
    spawnstruct = getStruct("tut_spawn" + i, "targetname");
    spawnstruct.index = i;
    level.var_9317edc858b1ea66[i] = spawnstruct;
  }

  level.var_9317edc858b1ea66[0] = level.var_9317edc858b1ea66[1];
  level.getspawnpoint = &function_e2bf46c0f241711e;
}

function init_weapon() {
  self setOrigin(level.weaponspawnstruct.origin);
  _giveweapon(self.primaryweapon, undefined, undefined, 0);
  level.var_e121c8daae441150 = self dropitem(self.primaryweapon);
  level.var_e121c8daae441150.objweapon = self.primaryweaponobj;
  level.var_e121c8daae441150 itemweaponsetammo(0, weaponmaxammo(level.var_e121c8daae441150));
  self disableweaponpickup();
}

function init_crate(var_5372f0b80988f4e5) {
  level.carepackage = scripts\cp_mp\killstreaks\airdrop::placekillstreakcrate(level.player, "allies", "cruise_predator", var_5372f0b80988f4e5.origin, var_5372f0b80988f4e5.angles);
  level.carepackage.nevertimeout = 1;
}

function function_e2bf46c0f241711e() {
  if(isDefined(level.currentspawnpointindex) && isDefined(level.var_9317edc858b1ea66)) {
    return level.var_9317edc858b1ea66[level.currentspawnpointindex];
  }

  [spawnpoint] = getspawnarray("mp_tdm_spawn_allies_start");
  spawnpoint.origin = getgroundposition(spawnpoint.origin, 15);
  spawnangles = spawnpoint.angles;
  return spawnpoint;
}

function function_4dc27f9df0ba179f(origin) {
  if(!isDefined(self.objidnum)) {
    self.offset3d = (0, 0, 0);
    self.curorigin = self.origin;
    scripts\mp\gameobjects::requestid(1, 1, undefined, 0, 0);
  }

  objective_add_objective(self.objidnum, "current", self.origin);
  update_objective_icon(self.objidnum, "icon_waypoint_sp_generic");
  objective_setbackground(self.objidnum, 1);
  objective_settint(self.objidnum, 224, 224, 224, 1);
  function_f21e9b2e78de984b(self.objidnum, 150, 75);
  objective_set_play_intro(self.objidnum, 0);
}

function function_d2da945656356633() {
  objective_set_play_outro(self.objidnum, 0);
  objective_teammask_removefrommask(self.objidnum, "allies");
  objective_unpin_player(self.objidnum, level.player);
}

function function_b85b74a17beba1aa() {
  foreach(trigger in level.actiontriggers) {
    if(isDefined(trigger.objidnum)) {
      trigger function_d2da945656356633();
    }
  }
}

function private function_520a19b833f9ea69() {
  return getdvarint(@ "hash_25e41dd3f2801f8d", 0) == 1;
}

function private player_onconnect(player) {
  player waittill("spawned");

  if(isbot(player)) {
    return;
  }

  level.player = player;
  function_e5b1655917227a82(player);
}

function private function_e5b1655917227a82(player) {
  player.team = "allies";
  player.pers["team"] = "allies";
  player.sessionteam = "allies";
  level.teamdata[player.team]["aliveCount"] = 1;
  player init_weapon();
  player allowreload(0);
  player disableautoreload();
  player _takeweapon(player.primaryweaponobj);
  player domonitoredweaponswitch(player.secondaryweaponobj, 1, 0);
  player setweaponammostock(player.secondaryweaponobj, weaponmaxammo(player.secondaryweaponobj));
  player setweaponammoclip(player.secondaryweaponobj, 0);
  slot = scripts\mp\equipment::getdefaultslot("equip_frag");

  if(isDefined(slot)) {
    player scripts\mp\equipment::giveequipment("equip_frag", slot);
    player setequipmentslotammo("primary", 0);
  }

  slot = scripts\mp\equipment::getdefaultslot("equip_concussion");

  if(isDefined(slot)) {
    player scripts\mp\equipment::giveequipment("equip_concussion", slot);
    player setequipmentslotammo("secondary", 0);
  }

  player scripts\mp\perks\perkpackage::perkpackage_giveimmediate("super_tac_cover", undefined, undefined, undefined, 0);
  player setOrigin(level.var_9317edc858b1ea66[0].origin);
  player setplayerangles(level.var_9317edc858b1ea66[0].angles);
}

function private function_f3d8585a10979d82() {
  self endon("death_or_disconnect");
  self waittill("giveLoadout");

  if(level.var_35d8c4fb1aeb5cb8 <= 3) {
    _takeweapon(self.primaryweaponobj);
    domonitoredweaponswitch(self.secondaryweaponobj, 1, 0);

    if(level.var_35d8c4fb1aeb5cb8 < 2) {
      self disableweaponpickup();
    }
  }

  if(level.var_35d8c4fb1aeb5cb8 <= 6) {
    if(level.var_35d8c4fb1aeb5cb8 < 6) {
      self allowreload(0);
    }

    self disableautoreload();
    self setweaponammostock(self.secondaryweaponobj, weaponmaxammo(self.secondaryweaponobj));
    self setweaponammoclip(self.secondaryweaponobj, 0);
    self setweaponammostock(self.primaryweaponobj, weaponmaxammo(self.primaryweaponobj));
    self setweaponammoclip(self.primaryweaponobj, 0);
  }

  takeequipment("secondary");

  if(level.var_35d8c4fb1aeb5cb8 == 11) {
    slot = scripts\mp\equipment::getdefaultslot("equip_concussion");

    if(isDefined(slot)) {
      scripts\mp\equipment::giveequipment("equip_concussion", slot);
    }
  }

  if(level.var_35d8c4fb1aeb5cb8 != 20) {
    takeequipment("primary");
  }

  if(level.var_35d8c4fb1aeb5cb8 != 24) {
    scripts\mp\perks\perkpackage::perkpackage_giveimmediate("super_tac_cover", undefined, undefined, undefined, 0);
    return;
  }

  scripts\mp\perks\perkpackage::perkpackage_giveimmediate("super_tac_cover");
}

function private function_ff44c6d5799b3f47(markertype, killingblow, headshot, nonplayer, icontype) {
  if(!isDefined(killingblow)) {
    killingblow = 0;
  }

  if(!isDefined(markertype)) {
    return;
  }

  if(!isDefined(headshot)) {
    headshot = 0;
  }

  if(!isDefined(nonplayer)) {
    nonplayer = 0;
  }

  priority = function_9e26c58a6edd4ac8(markertype);

  if(isDefined(self.lasthitmarkertime) && self.lasthitmarkertime == gettime() && priority <= self.lasthitmarkerpriority && !killingblow) {
    return;
  }

  self.lasthitmarkertime = gettime();
  self.lasthitmarkerpriority = priority;

  if(isDefined(icontype) && !istrue(killingblow)) {
    self setclientomnvar("damage_feedback_icon", icontype);
    self setclientomnvar("damage_feedback_icon_notify", gettime());
  }

  self setclientomnvar("damage_feedback", markertype);
  self setclientomnvar("damage_feedback_notify", gettime());

  if(killingblow) {
    self setclientomnvar("damage_feedback_kill", 1);
  } else {
    self setclientomnvar("damage_feedback_kill", 0);
  }

  if(headshot) {
    self setclientomnvar("damage_feedback_headshot", 1);
  } else {
    self setclientomnvar("damage_feedback_headshot", 0);
  }

  if(nonplayer) {
    self setclientomnvar("damage_feedback_nonplayer", 1);
    return;
  }

  self setclientomnvar("damage_feedback_nonplayer", 0);
}

function private function_9e26c58a6edd4ac8(hitmarkertype) {
  if(!isDefined(level.hitmarkerpriorities[hitmarkertype])) {
    return 0;
  }

  return level.hitmarkerpriorities[hitmarkertype];
}

function private function_321be506fe49028b() {
  level endon("game_ended");
  level endon("training_course_interrupted");
  self endon("disconnect");

  while(true) {
    weapons = self getweaponslistprimaries();

    foreach(weapon in weapons) {
      self givemaxammo(weapon);
      self setweaponammostock(weapon, weaponmaxammo(weapon));
    }

    waitframe();
  }
}

function private function_d591cb24cfb9e613() {
  forward = anglesToForward(self getplayerangles());
  var_67f2d5f225a3f921 = anglebetweenvectors(forward, (0, 0, 1));
  left = anglestoleft(self getplayerangles());
  var_8d28631407d834bb = anglebetweenvectors(left, (1, 0, 0));
  var_f36628a4d70d4a6b = var_67f2d5f225a3f921 <= 70;
  var_c16a2ec0653c4e1e = var_67f2d5f225a3f921 >= 115;
  var_6351aa4d4956cf0 = var_8d28631407d834bb >= 25;
  return var_f36628a4d70d4a6b || var_c16a2ec0653c4e1e || var_6351aa4d4956cf0;
}

function private function_ab39011be023b94() {
  level endon("target_death");

  while(true) {
    self waittill("grenade_fire", grenade);
    wait 1.5;
    setequipmentslotammo("secondary", 1);
  }
}

function private function_d21af14f709b4e9() {
  level endon("target_death");

  while(true) {
    self waittill("grenade_fire", grenade);
    wait 3.5;
    setequipmentslotammo("primary", 1);
  }
}

function private function_e15b215e4fc00932(trigger) {
  self endon("stop_trigger_check");

  while(true) {
    trigger waittill("trigger", player);
    player.var_c74e2a2f7c14d917 = 0;
  }
}

function private function_4e2fe44c3cbe6b24(trigger) {
  self endon("stop_trigger_check");

  while(true) {
    trigger waittill("trigger_exit", player);
    player.var_c74e2a2f7c14d917 = 1;
  }
}

function private function_ea6a9ec867a82c1() {
  self endon("stop_killstreak_check");

  while(true) {
    self waittill("streak_activated", streakname);
    self setclientomnvar("lui_training_course_state", -1);
    wait 1;
    scripts\mp\killstreaks\killstreaks::awardkillstreak(streakname, self);

    if(self getclientomnvar("lui_training_course_state") != level.scriptedevents.size) {
      self setclientomnvar("lui_training_course_state", -1);
      wait 1;
      self setclientomnvar("lui_training_course_state", level.scriptedevents.size);
    }
  }
}

function function_fb4b8c8dec4c8495() {
  level.var_35d8c4fb1aeb5cb8 = 0;
  level.scriptedevents = [ &function_e0f8d1d915cb681b, &function_6cf90f12033c1f1d, &function_e2bbf555c17be641, &function_2f2b7340eced2d89, &function_359bd4b9eca48636, &function_bac1fa083cbe583e, &function_3c1235da36973cb8, &function_249c0b8a2dcb60cc, &function_c546f0a53b1b9975, &function_2e308a2fe4c912e1, &function_284061e8190319c6, &function_dc0f31a23dd05cb8, &function_1773e8decf0f2f6c, &function_8ce66a93e6be27b8, &function_cd9e90285761f4fe, &function_c6892ce5f3e88669, &function_e4edec51c1e3239c, &function_8a6c94d7fd48dc64, &function_45d68507c5ae7072, &function_bf56d16e55747d09, &function_dc70aaa8d8f87297, &function_83a3fb61c8b255a1, &function_e41e02ec0865fb08, &function_aa65e8881adabf98, &function_578c96daacc20f48, &function_a1eb5feb655153e7, &function_2de15530c52467a8, &function_939598706be41c51, &function_f4ec7a2a6a9ee2c0, &function_4ce43f1cc5edb5cf, &function_8aa67e2c556382dc];
}

function function_3e4edf7034db8b19() {
  foreach(var_f50f3f9183c1ad36 in level.targets) {
    foreach(target in var_f50f3f9183c1ad36) {
      if(target function_53580c5eeccb98ab()) {
        target.health = 50;
        continue;
      }

      target rotatepitch(-90, 0.1);
    }
  }

  level.var_9d998250bdb9bcb9 = 0.5;
  level.player thread function_321be506fe49028b();
  level.player dlog_recordplayerevent("dlog_event_training_course_end", ["is_completed", 0]);
  level thread function_1ee6762a88ec543c();
}

function function_1ee6762a88ec543c() {
  level endon("game_ended");
  level endon("training_course_interrupted");
  level.player endon("disconnect");
  wait 6;

  while(level.var_35d8c4fb1aeb5cb8 < level.scriptedevents.size) {
    thread function_92945bd32781da76(level.player, level.var_35d8c4fb1aeb5cb8);
    level.player childthread[[level.scriptedevents[level.var_35d8c4fb1aeb5cb8]]]();
    level.var_35d8c4fb1aeb5cb8 += 1;
    flag_wait("next_event");
    level.player setclientomnvar("lui_training_course_state", -1);
    wait level.var_9d998250bdb9bcb9;
    level.var_9d998250bdb9bcb9 = 0.5;
  }
}

function function_92945bd32781da76(player, eventindex) {
  if(isDefined(level.var_35e511272af146e5)) {
    wait level.var_35e511272af146e5;
  }

  player setclientomnvar("lui_training_course_state", eventindex);
  level.var_35e511272af146e5 = undefined;
}

function function_e0f8d1d915cb681b() {
  flag_clear("next_event");

  self iprintln("<dev string:x1c>");

  while(!function_d591cb24cfb9e613()) {
    waitframe();
  }

  self playSound("mp_jup_training_objective_success");

  self iprintln("<dev string:x39>");

  flag_set("next_event");
}

function function_6cf90f12033c1f1d() {
  flag_clear("next_event");

  self iprintln("<dev string:x54>");

  self enableweaponpickup();
  trigger = level.actiontriggers[1];
  trigger function_4dc27f9df0ba179f(trigger.origin);

  orientedbox(trigger.origin, (183.5, 210.5, 190.5), trigger.angles, (1, 0, 0), 1, 400);

  level.var_e121c8daae441150.outline = outlineenableforplayer(level.var_e121c8daae441150, self, "outline_nodepth_red", "level_script");
  trigger waittill("trigger", player);
  trigger function_d2da945656356633();
  self playSound("mp_jup_training_objective_success");

  self iprintln("<dev string:x7d>");

  flag_set("next_event");
}

function function_e2bbf555c17be641() {
  flag_clear("next_event");

  self iprintln("<dev string:xa4>");

  if(isDefined(level.var_e121c8daae441150)) {
    level.var_e121c8daae441150 makeusable();
    level.var_e121c8daae441150 sethintdisplayrange(128);
    level.var_e121c8daae441150 setuserange(128);
    level.var_e121c8daae441150 childthread scripts\mp\weapons::watchpickup(self);
    self waittill("weapon_pickup", weaponobj, droppeditem);
    outlinedisable(level.var_e121c8daae441150.outline, self);
  }

  self iprintln("<dev string:xc3>");

  flag_set("next_event");
}

function function_2f2b7340eced2d89() {
  flag_clear("next_event");

  self iprintln("<dev string:xe0>");

  while(true) {
    self waittill("weapon_change");

    if(istrue(self.var_d7b7b32fa4c77d0e)) {
      self.var_d7b7b32fa4c77d0e = 0;
      continue;
    }

    break;
  }

  self iprintln("<dev string:xff>");

  flag_set("next_event");
}

function function_359bd4b9eca48636() {
  flag_clear("next_event");

  self iprintln("<dev string:x11c>");

  while(true) {
    self waittill("weapon_change");

    if(istrue(self.var_d7b7b32fa4c77d0e)) {
      self.var_d7b7b32fa4c77d0e = 0;
      continue;
    }

    break;
  }

  self playSound("mp_jup_training_objective_success");

  self iprintln("<dev string:x147>");

  flag_set("next_event");
}

function function_bac1fa083cbe583e() {
  flag_clear("next_event");

  self iprintln("<dev string:x170>");

  self allowreload(1);

  while(true) {
    self waittill("reload");
    currentweaponobj = self getcurrentweapon();

    if(isDefined(currentweaponobj)) {
      break;
    }
  }

  self enableautoreload();
  self playSound("mp_jup_training_objective_success");

  self iprintln("<dev string:x18f>");

  flag_set("next_event");
}

function function_3c1235da36973cb8() {
  flag_clear("next_event");

  self iprintln("<dev string:x54>");

  trigger = level.actiontriggers[20];
  trigger function_4dc27f9df0ba179f(trigger.origin);

  orientedbox(trigger.origin, (183.5, 210.5, 190.5), trigger.angles, (1, 0, 0), 1, 400);

  trigger waittill("trigger", player);
  trigger function_d2da945656356633();
  self playSound("mp_jup_training_objective_success");

  self iprintln("<dev string:x7d>");

  flag_set("next_event");
}

function function_249c0b8a2dcb60cc() {
  flag_clear("next_event");

  self iprintln("<dev string:x1ac>");

  foreach(target in level.targets["Hipfire"]) {
    target function_697e01c482ca4c72();
    target.var_ef356f8bcde74a2d = &function_fdb937421f2f2731;
    target childthread function_2e8e7982711d50f2();
    wait 0.15;
  }

  for(targets = level.targets["Hipfire"].size; targets > 0; targets--) {
    level waittill("target_death");
  }

  self iprintln("<dev string:x1c5>");

  flag_set("next_event");
}

function function_c546f0a53b1b9975() {
  flag_clear("next_event");

  self iprintln("<dev string:x1dc>");

  foreach(target in level.targets["ADS"]) {
    target function_697e01c482ca4c72();
    target.var_ef356f8bcde74a2d = &function_e537f5a00f54b91e;
    target childthread function_2e8e7982711d50f2();
    wait 0.15;
  }

  for(targets = level.targets["ADS"].size; targets > 0; targets--) {
    level waittill("target_death");
  }

  self iprintln("<dev string:x1f1>");

  level.currentspawnpointindex = 2;
  function_4f223e0dd031befb(1);
  flag_set("next_event");
}

function function_2e308a2fe4c912e1() {
  flag_clear("next_event");

  self iprintln("<dev string:x204>");

  trigger = level.actiontriggers[2];
  trigger function_4dc27f9df0ba179f(trigger.origin);

  orientedbox(trigger.origin, (186.5, 623.5, 190.5), trigger.angles, (1, 0, 0), 1, 400);

  trigger waittill("trigger", player);
  trigger function_d2da945656356633();
  self playSound("mp_jup_training_objective_success");

  self iprintln("<dev string:x22e>");

  flag_set("next_event");
}

function function_284061e8190319c6() {
  flag_clear("next_event");

  self iprintln("<dev string:x256>");

  slot = scripts\mp\equipment::getdefaultslot("equip_concussion");

  if(isDefined(slot)) {
    scripts\mp\equipment::giveequipment("equip_concussion", slot);
    childthread function_ab39011be023b94();
  }

  foreach(target in level.targets["Tactical"]) {
    target.health = 1;
    target function_697e01c482ca4c72();
    target.var_ef356f8bcde74a2d = &function_a3c9f518ed376a4a;
    target childthread function_2e8e7982711d50f2();
    wait 0.15;
  }

  for(targets = level.targets["Tactical"].size; targets > 0; targets--) {
    level waittill("target_death");
  }

  self iprintln("<dev string:x276>");

  flag_set("next_event");
}

function function_dc0f31a23dd05cb8() {
  flag_clear("next_event");

  self iprintln("<dev string:x54>");

  trigger = level.actiontriggers[13];
  trigger function_4dc27f9df0ba179f(trigger.origin);

  orientedbox(trigger.origin, (183.5, 210.5, 190.5), trigger.angles, (1, 0, 0), 1, 400);

  trigger waittill("trigger", player);
  trigger function_d2da945656356633();
  self playSound("mp_jup_training_objective_success");

  self iprintln("<dev string:x7d>");

  flag_set("next_event");
}

function function_1773e8decf0f2f6c() {
  flag_clear("next_event");

  self iprintln("<dev string:x294>");

  foreach(target in level.targets["TacticalADS"]) {
    target function_697e01c482ca4c72();
    target.var_ef356f8bcde74a2d = &function_94d7abe1e5cc3a94;
    target childthread function_2e8e7982711d50f2();
    wait 0.15;
  }

  for(targets = level.targets["TacticalADS"].size; targets > 0; targets--) {
    level waittill("target_death");
  }

  self iprintln("<dev string:x2b2>");

  flag_set("next_event");
}

function function_8ce66a93e6be27b8() {
  flag_clear("next_event");

  self iprintln("<dev string:x2ce>");

  laddertrigger = level.actiontriggers[3];
  laddertrigger function_4dc27f9df0ba179f(laddertrigger.origin);

  orientedbox(laddertrigger.origin, (32, 32, 32), laddertrigger.angles, (1, 0, 0), 1, 400);

  laddertrigger waittill("trigger", player);
  laddertrigger function_d2da945656356633();
  function_4f223e0dd031befb(2);
  self playSound("mp_jup_training_objective_success");

  self iprintln("<dev string:x2ec>");

  flag_set("next_event");
}

function function_cd9e90285761f4fe() {
  flag_clear("next_event");

  self iprintln("<dev string:x308>");

  trigger = level.actiontriggers[4];
  trigger function_4dc27f9df0ba179f(trigger.origin);

  orientedbox(trigger.origin, (129, 68.5, 20.5), trigger.angles, (1, 0, 0), 1, 400);

  while(true) {
    trigger waittill("trigger", player);
    playerstance = player getstance();

    if(playerstance == "crouch" || playerstance == "prone") {
      break;
    }
  }

  trigger function_d2da945656356633();
  level.currentspawnpointindex = 3;
  self playSound("mp_jup_training_objective_success");

  self iprintln("<dev string:x32f>");

  flag_set("next_event");
}

function function_c6892ce5f3e88669() {
  flag_clear("next_event");

  self iprintln("<dev string:x354>");

  trigger = level.actiontriggers[5];
  markertrigger = level.actiontriggers[12];
  markertrigger function_4dc27f9df0ba179f(markertrigger.origin);

  orientedbox(trigger.origin, (553.5, 107, 188), trigger.angles, (1, 0, 0), 1, 400);

  trigger waittill("trigger", player);
  markertrigger function_d2da945656356633();
  self playSound("mp_jup_training_objective_success");

  self iprintln("<dev string:x37d>");

  flag_set("next_event");
}

function function_e4edec51c1e3239c() {
  flag_clear("next_event");

  self iprintln("<dev string:x3a4>");

  foreach(target in level.targets["Mount"]) {
    target function_697e01c482ca4c72();
    target childthread function_2e8e7982711d50f2();
    wait 0.15;
  }

  for(targets = level.targets["Mount"].size; targets > 0; targets--) {
    level waittill("target_death");
  }

  self iprintln("<dev string:x3bb>");

  flag_set("next_event");
}

function function_8a6c94d7fd48dc64() {
  flag_clear("next_event");

  self iprintln("<dev string:x3d0>");

  foreach(target in level.targets["Penetration"]) {
    target function_697e01c482ca4c72();
    target childthread function_2e8e7982711d50f2();
    wait 0.15;
  }

  for(targets = level.targets["Penetration"].size; targets > 0; targets--) {
    level waittill("target_death");
  }

  function_4f223e0dd031befb(3);
  function_4f223e0dd031befb(4);

  self iprintln("<dev string:x3f4>");

  flag_set("next_event");
}

function function_45d68507c5ae7072() {
  flag_clear("next_event");

  self iprintln("<dev string:x416>");

  trigger = level.actiontriggers[10];
  trigger function_4dc27f9df0ba179f(trigger.origin);

  orientedbox(trigger.origin, (186.5, 623.5, 190.5), trigger.angles, (1, 0, 0), 1, 400);

  trigger waittill("trigger", player);
  trigger function_d2da945656356633();
  self playSound("mp_jup_training_objective_success");

  self iprintln("<dev string:x43d>");

  flag_set("next_event");
}

function function_bf56d16e55747d09() {
  flag_clear("next_event");

  self iprintln("<dev string:x462>");

  slot = scripts\mp\equipment::getdefaultslot("equip_frag");

  if(isDefined(slot)) {
    scripts\mp\equipment::giveequipment("equip_frag", slot);
    childthread function_d21af14f709b4e9();
  }

  targets = level.targets["Lethal"];

  foreach(target in targets) {
    target function_697e01c482ca4c72();
    target.var_ef356f8bcde74a2d = &function_448aa67e9fe96de6;
    target childthread function_2e8e7982711d50f2();
    wait 0.15;
  }

  level waittill("target_death");

  foreach(target in targets) {
    target setCanDamage(0);
    target function_985e1298e8b97a33();
  }

  self notify("lethal_check_end");
  function_4f223e0dd031befb(5);

  self iprintln("<dev string:x480>");

  flag_set("next_event");
}

function function_dc70aaa8d8f87297() {
  flag_clear("next_event");

  self iprintln("<dev string:x49c>");

  trigger = level.actiontriggers[6];
  trigger function_4dc27f9df0ba179f(trigger.origin);

  orientedbox(trigger.origin, (121, 108.5, 124.5), trigger.angles, (1, 0, 0), 1, 400);

  trigger waittill("trigger", player);
  trigger function_d2da945656356633();
  level.currentspawnpointindex = 4;
  self playSound("mp_jup_training_objective_success");

  self iprintln("<dev string:x4c3>");

  flag_set("next_event");
}

function function_83a3fb61c8b255a1() {
  flag_clear("next_event");

  self iprintln("<dev string:x4e8>");

  foreach(target in level.targets["Prone"]) {
    target function_697e01c482ca4c72();
    target.var_ef356f8bcde74a2d = &function_aea735653060f9b1;
    target childthread function_2e8e7982711d50f2();
    wait 0.15;
  }

  for(targets = level.targets["Prone"].size; targets > 0; targets--) {
    level waittill("target_death");
  }

  function_4f223e0dd031befb(6);

  self iprintln("<dev string:x50c>");

  flag_set("next_event");
}

function function_e41e02ec0865fb08() {
  flag_clear("next_event");

  self iprintln("<dev string:x49c>");

  trigger = level.actiontriggers[11];
  trigger function_4dc27f9df0ba179f(trigger.origin);

  orientedbox(trigger.origin, (119.884, 462.425, 205.5), trigger.angles, (1, 0, 0), 1, 400);

  trigger waittill("trigger", player);
  trigger function_d2da945656356633();
  self playSound("mp_jup_training_objective_success");

  self iprintln("<dev string:x4c3>");

  flag_set("next_event");
}

function function_aa65e8881adabf98() {
  flag_clear("next_event");

  self iprintln("<dev string:x52e>");

  self.var_c74e2a2f7c14d917 = 1;
  scripts\mp\perks\perkpackage::perkpackage_giveimmediate("super_tac_cover");

  foreach(target in level.targets["Field"]) {
    target function_697e01c482ca4c72();
    wait 0.15;
  }

  covertrigger = level.actiontriggers[11];
  covertrigger function_4dc27f9df0ba179f(covertrigger.origin);

  orientedbox(covertrigger.origin, (462.449, 121.103, 205.5), covertrigger.angles, (1, 0, 0), 1, 400);

  childthread function_e15b215e4fc00932(covertrigger);
  childthread function_4e2fe44c3cbe6b24(covertrigger);
  self waittill("tac_cover_spawned");
  self notify("stop_trigger_check");
  self.var_c74e2a2f7c14d917 = undefined;
  covertrigger function_d2da945656356633();
  level.currentspawnpointindex = 5;

  self iprintln("<dev string:x554>");

  flag_set("next_event");
}

function function_578c96daacc20f48() {
  flag_clear("next_event");

  self iprintln("<dev string:x578>");

  foreach(target in level.targets["Field"]) {
    target childthread function_2e8e7982711d50f2();
  }

  for(targets = level.targets["Field"].size; targets > 0; targets--) {
    level waittill("target_death");
  }

  function_4f223e0dd031befb(7);

  self iprintln("<dev string:x5a5>");

  flag_set("next_event");
}

function function_a1eb5feb655153e7() {
  flag_clear("next_event");

  self iprintln("<dev string:x54>");

  trigger = level.actiontriggers[21];
  trigger function_4dc27f9df0ba179f(trigger.origin);

  orientedbox(trigger.origin, (131.5, 74.5, 134.5), trigger.angles, (1, 0, 0), 1, 400);

  trigger waittill("trigger", player);
  trigger function_d2da945656356633();
  self playSound("mp_jup_training_objective_success");
  level thread init_crate(level.var_5372f0b80988f4e5);

  self iprintln("<dev string:x7d>");

  flag_set("next_event");
}

function function_2de15530c52467a8() {
  flag_clear("next_event");

  self iprintln("<dev string:x5d0>");

  trigger = level.actiontriggers[8];
  trigger function_4dc27f9df0ba179f(trigger.origin);

  orientedbox(trigger.origin, (119.34, 111.5, 38.5), trigger.angles, (1, 0, 0), 1, 400);

  while(true) {
    trigger waittill("trigger", player);
    velocity = player getentityvelocity();

    if(velocity[2] < 0) {
      break;
    }
  }

  trigger function_d2da945656356633();
  level.currentspawnpointindex = 6;
  self playSound("mp_jup_training_objective_success");

  self iprintln("<dev string:x5ee>");

  flag_set("next_event");
}

function function_939598706be41c51() {
  flag_clear("next_event");

  self iprintln("<dev string:x60a>");

  trigger = level.actiontriggers[9];
  trigger function_4dc27f9df0ba179f(trigger.origin);

  orientedbox(trigger.origin, (463.534, 173.09, 171.5), trigger.angles, (1, 0, 0), 1, 400);

  trigger waittill("trigger", player);
  trigger function_d2da945656356633();
  self playSound("mp_jup_training_objective_success");

  self iprintln("<dev string:x62b>");

  flag_set("next_event");
}

function function_f4ec7a2a6a9ee2c0() {
  flag_clear("next_event");

  self iprintln("<dev string:x64a>");

  level.var_9d998250bdb9bcb9 = 0;
  level.var_35e511272af146e5 = 2.5;

  while(!isDefined(level.carepackage)) {
    waitframe();
  }

  if(!isDefined(level.carepackage.useobject)) {
    wait 2;
  } else {
    self waittill("received_earned_killstreak");
  }

  self iprintln("<dev string:x64a>");

  flag_set("next_event");
}

function function_4ce43f1cc5edb5cf() {
  flag_clear("next_event");

  self iprintln("<dev string:x66f>");

  level.killstreak_additional_targets = [];

  foreach(target in level.targets["Killstreak"]) {
    target function_697e01c482ca4c72(1);
    target.var_ef356f8bcde74a2d = &function_22b1cabc5ee0e001;
    target childthread function_2e8e7982711d50f2();
    object = spawn("script_model", target.origin + (0, 0, 85));
    object.team = "axis";
    level.killstreak_additional_targets[level.killstreak_additional_targets.size] = object;
    wait 0.15;
  }

  childthread function_ea6a9ec867a82c1();
  targets = level.targets["Killstreak"].size;

  while(targets > 0) {
    level waittill("target_death", target);
    targets--;
    self notify("stop_killstreak_check");
    scripts\mp\killstreaks\killstreaks::clearkillstreaks();
    self setclientomnvar("lui_training_course_state", -1);
    break;
  }

  self iprintln("<dev string:x68f>");

  wait 1;
  flag_set("next_event");
}

function function_8aa67e2c556382dc() {
  flag_clear("next_event");

  self iprintln("<dev string:x6ad>");

  wait 3;
  function_7c82d04922ac1bba();

  self iprintln("<dev string:x6d8>");

  flag_set("next_event");
}

function function_7c2ee16bc35afc97() {
  setclientnamemode("auto_change");
  function_fb4b8c8dec4c8495();

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    oldattackers = game["attackers"];
    olddefenders = game["defenders"];
    game["attackers"] = olddefenders;
    game["defenders"] = oldattackers;
  }

  foreach(entry in level.teamnamelist) {
    setobjectivetext(entry, &"OBJECTIVES/WAR");

    if(level.splitscreen) {
      setobjectivescoretext(entry, &"OBJECTIVES/WAR");
    } else {
      setobjectivescoretext(entry, &"OBJECTIVES/WAR_SCORE");
    }

    setobjectivehinttext(entry, &"OBJECTIVES/WAR_HINT");
  }

  scripts\mp\gametypes\bradley_spawner::inittankspawns();
  level thread function_4c53424afe3c0b01();

  level thread function_13f93acfa5b5c378();
}

function function_4c53424afe3c0b01() {
  level endon("match_start");
  level endon("disconnect");

  while(true) {
    level waittill("matchStartTimer_done");

    if(isDefined(level.player)) {
      function_3e4edf7034db8b19();
      level notify("match_start");
      break;
    }
  }
}

function function_7c82d04922ac1bba() {
  game["winner"] = level.player.team;
  thread scripts\mp\gamelogic::endgame(game["winner"], game["end_reason"]["time_limit_reached"]);
  level.player dlog_recordplayerevent("dlog_event_training_course_end", ["is_completed", 1]);
}

function updategametypedvars() {
  scripts\mp\gametypes\common::updatecommongametypedvars();
}

function onspawnplayer(revivespawn) {
  scripts\mp\hud_message::function_f004ef4606b9efdc("kill");

  if(self.deaths > 0) {
    if(level.var_35d8c4fb1aeb5cb8 > 3) {
      self.var_d7b7b32fa4c77d0e = 1;
    }

    thread function_f3d8585a10979d82();
  }
}

function spawncompare(spawnpoint, spawnteam) {
  if(getdvarint(@ "hash_b5ceec3e3cb419be") != 0) {
    spawnpoints = scripts\mp\spawnlogic::getteamspawnpoints(spawnteam);
    fallbackspawnpoints = [];
    scriptspawnpoint = scripts\mp\spawnscoring::getspawnpoint_legacy(spawnpoints, fallbackspawnpoints);

    if(!isDefined(level.var_3d292942d52b104a)) {
      level.var_3d292942d52b104a = 0;
      level.var_2dc7108159dc1da3 = 0;
      level.var_a065445ba781ddf6 = 0;
    }

    level.var_3d292942d52b104a++;
    println("<dev string:x701>" + scriptspawnpoint.index + "<dev string:x71c>" + scriptspawnpoint.totalscore);

    if(scriptspawnpoint.index == spawnpoint.index) {
      level.var_2dc7108159dc1da3++;
      iprintlnbold("<dev string:x732>" + level.var_2dc7108159dc1da3 / level.var_3d292942d52b104a * 100 + "<dev string:x751>" + "<dev string:x75f>" + level.var_2dc7108159dc1da3 + "<dev string:x764>" + level.var_3d292942d52b104a);
    } else {
      level.var_a065445ba781ddf6++;
      iprintlnbold("<dev string:x769>" + level.var_2dc7108159dc1da3 / level.var_3d292942d52b104a * 100 + "<dev string:x751>" + "<dev string:x75f>" + level.var_2dc7108159dc1da3 + "<dev string:x764>" + level.var_3d292942d52b104a);
    }

    return scriptspawnpoint;
  }
}

function onnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon) {
  scripts\mp\gametypes\common::oncommonnormaldeath(victim, attacker, lifeid, meansofdeath, objweapon, iskillstreakweapon);
}

function dropweaponfordeath(attacker, smeansofdeath, weaponoverride, damage) {}

function ontimelimit() {
  if(!isDefined(level.var_3d06de480d9ef9c4)) {
    game["winner"] = getotherteam(level.player.team)[0];
    thread scripts\mp\gamelogic::endgame(game["winner"], game["end_reason"]["time_limit_reached"]);
    level.var_3d06de480d9ef9c4 = 1;
  }
}

function function_7776a47aa86745dc() {
  self.parts = getEntArray(self.script_linkname, "script_linkto");
  self.parts = array_remove(self.parts, self);

  foreach(part in self.parts) {
    part linkTo(self);
    part.target = "null";
    part.targetname = "null";
  }
}

function function_2e8e7982711d50f2() {
  self endon("target_death");
  self setCanDamage(1);
  data = spawnStruct();
  data.damage = 0;

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, weapon, origin, angles, normal, inflector);
    hitloc = "torso_upper";
    data.attacker = attacker;
    data.victim = self;
    data.origin = self.origin;
    data.attacker = attacker;
    data.meansofdeath = meansofdeath;
    data.weapon = weapon;
    data.hitloc = hitloc;
    data.idflags = idflags;

    if(data.idflags & 262144) {
      weapondamagetype = 2;
    } else {
      weapondamagetype = 0;
    }

    scaleddamage = int(floor(damage * getweaponhitlocdamagemultiplier(data.weapon, hitloc, weapondamagetype)));
    data.damage = scaleddamage;
    function_396516aef4db32c0(data);
  }
}

function function_396516aef4db32c0(var_caf1c9236bfa0831) {
  var_ef356f8bcde74a2d = self.var_ef356f8bcde74a2d;
  cantakedamage = 1;

  if(isDefined(var_ef356f8bcde74a2d)) {
    cantakedamage = self[[var_ef356f8bcde74a2d]](var_caf1c9236bfa0831);
  }

  if(cantakedamage) {
    self.health -= var_caf1c9236bfa0831.damage;
    var_caf1c9236bfa0831.attacker function_ff44c6d5799b3f47("standard", self.health <= 0, var_caf1c9236bfa0831.hitloc == "head", 1, undefined);

    if(self.health <= 0) {
      self setCanDamage(0);
      function_985e1298e8b97a33();

      level.player iprintln("<dev string:x799>");

      self playSound("mp_jup_training_target_success");
      level notify("target_death", self);
      self notify("target_death", self);
    }

    return;
  }

  if(!isDefined(self.failhit)) {
    self.failhit = 0;
  }

  self.failhit++;

  if(self.failhit >= 3) {
    level.player iprintln("<dev string:x7bb>");

    self playSound("mp_jup_training_target_fail");
    self.failhit = 0;
  }
}

function function_53580c5eeccb98ab() {
  return self.health <= 0;
}

function function_697e01c482ca4c72(nooutline) {
  self rotatepitch(90, 0.25, 0.1);
  self playSound("mp_jup_training_target_up");

  if(istrue(nooutline)) {
    return;
  }

  outline = outlineenableforplayer(self, level.player, "outline_nodepth_red", "level_script");
  self.targetoutline = outline;
}

function function_985e1298e8b97a33() {
  self rotatepitch(-90, 0.5, 0.15);
  self playSound("mp_jup_training_target_down");

  if(isDefined(self.targetoutline)) {
    outlinedisable(self.targetoutline, self);
  }
}

function function_94d7abe1e5cc3a94(var_caf1c9236bfa0831) {
  return scripts\common\utility::getdamagetype(var_caf1c9236bfa0831.meansofdeath) == "bullet";
}

function function_dd62dbdc963c6673(var_caf1c9236bfa0831) {
  return scripts\common\damage_effects::function_9ca01a02f4efc7f6(var_caf1c9236bfa0831.meansofdeath);
}

function function_fdb937421f2f2731(var_caf1c9236bfa0831) {
  return !var_caf1c9236bfa0831.attacker isplayerads() && function_94d7abe1e5cc3a94(var_caf1c9236bfa0831);
}

function function_e537f5a00f54b91e(var_caf1c9236bfa0831) {
  player = var_caf1c9236bfa0831.attacker;
  return player isplayerads() && !player function_e7b413144d6cf1cd(var_caf1c9236bfa0831);
}

function function_a3c9f518ed376a4a(var_caf1c9236bfa0831) {
  return function_dd62dbdc963c6673(var_caf1c9236bfa0831) && isDefined(var_caf1c9236bfa0831.weapon) && var_caf1c9236bfa0831.weapon.basename == "concussion_grenade_mp";
}

function function_e7b413144d6cf1cd(var_caf1c9236bfa0831) {
  player = var_caf1c9236bfa0831.attacker;
  return player function_c603bed3b1c8d11(player.currentprimaryweapon) == 1;
}

function function_448aa67e9fe96de6(var_caf1c9236bfa0831) {
  return isDefined(var_caf1c9236bfa0831.weapon) && var_caf1c9236bfa0831.weapon.basename == "jup_frag_grenade_mp" && function_dd62dbdc963c6673(var_caf1c9236bfa0831);
}

function function_aea735653060f9b1(var_caf1c9236bfa0831) {
  return var_caf1c9236bfa0831.attacker getstance() == "prone";
}

function function_22b1cabc5ee0e001(var_caf1c9236bfa0831) {
  return isDefined(var_caf1c9236bfa0831.weapon) && var_caf1c9236bfa0831.weapon.basename == "cruise_proj_mp";
}

function function_c7926861b25a8d49() {
  flag_set("<dev string:x7e1>");
}

function function_13f93acfa5b5c378() {
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x7ef>");
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x808>", "<dev string:x81c>", &function_c7926861b25a8d49);
  scripts\common\devgui::function_fe953f000498048f();
}

# /