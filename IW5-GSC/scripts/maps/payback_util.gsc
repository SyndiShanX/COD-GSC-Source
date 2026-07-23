/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\payback_util.gsc
*****************************************/

bravo_bullet_shield(var_0) {
  var_1 = self;

  if(isDefined(self.melee)) {
    while(isalive(self) && isDefined(self.melee)) {
      wait 0.1;
    }
  }

  if(!isDefined(self) || !isalive(self)) {
    level waittill(var_0);

    switch (var_0) {
      case "hannibal_spawned":
        var_1 = level.hannibal;
        break;
      case "barracus_spawned":
        var_1 = level.barracus;
        break;
      case "murdock_spawned":
        var_1 = level.murdock;
        break;
    }
  }

  if(isDefined(var_1) && isalive(var_1) && !isDefined(var_1.magic_bullet_shield)) {
    var_1 thread maps\_utility::magic_bullet_shield();
  }
}

bravo_invulnerability(var_0) {
  if(var_0 == 1) {
    level.murdock maps\_utility::magic_bullet_shield();
    level.barracus maps\_utility::magic_bullet_shield();
    level.hannibal maps\_utility::magic_bullet_shield();
  } else {
    level.murdock maps\_utility::stop_magic_bullet_shield();
    level.barracus maps\_utility::stop_magic_bullet_shield();
    level.hannibal maps\_utility::stop_magic_bullet_shield();
  }
}

start_sandstorm_streets_fx() {
  level._id_6495 = [];
  var_0 = (-1613.14, -9162.08, 419.447);
  var_1 = (0, 268.001, 1.99871);
  var_2 = anglestoup(var_1);
  var_3 = anglesToForward(var_1);
  var_4 = spawnfx(level._effect["sand_wall_payback_still_md"], var_0, var_3, var_2);
  triggerfx(var_4, -2240);
  level._id_6495[level._id_6495.size] = var_4;
}

start_sandstorm_post_interrogation() {
  level._id_6495 = [];
  var_0 = (-1613.14, -7862.08, 419.447);
  var_1 = (0, 268.001, 1.99871);
  var_2 = anglestoup(var_1);
  var_3 = anglesToForward(var_1);
  var_4 = spawnfx(level._effect["sand_wall_payback_still_md"], var_0, var_3, var_2);
  triggerfx(var_4, -2240);
  level._id_6495[level._id_6495.size] = var_4;
}

toggle_chopper_fx() {
  if(level._id_5671 < 2) {
    sandstorm_fx(2);
    texploder(2300, -2240);
  } else {
    sandstorm_fx(3, -2240);
    texploder(5300, -2240);
  }
}

sandstorm_fx(var_0, var_1) {
  if(var_0 == 4) {
    delay_delete_wall(5);
  } else if(isDefined(level._id_6495)) {
    level._id_6495 = common_scripts\utility::array_removeundefined(level._id_6495);
    maps\_utility::array_delete(level._id_6495);
  }

  if(!isDefined(var_0)) {
    var_0 = 0;
  }
  if(var_0 == 1) {
    start_sandstorm_intro_fx();
  } else if(var_0 == 2) {
    start_sandstorm_streets_fx();
  } else if(var_0 == 3) {
    if(!isDefined(var_1)) {
      start_sandstorm_construction_fx();
    } else {
      start_sandstorm_construction_fx(var_1);
    }
  } else if(var_0 == 4) {
    start_sandstorm_post_interrogation();
  }
}

delay_delete_wall(var_0) {
  if(isDefined(level._id_6495)) {
    level._id_6495 = common_scripts\utility::array_removeundefined(level._id_6495);
    var_1 = level._id_6495;
    wait(var_0);
    maps\_utility::array_delete(var_1);
    common_scripts\utility::array_removeundefined(level._id_6495);
  }
}

start_sandstorm_intro_fx() {
  level._id_6495 = [];
  var_0 = (3329.18, -7502.85, 1257.04);
  var_1 = (359.318, 352.837, 0.881786);
  var_2 = anglestoup(var_1);
  var_3 = anglesToForward(var_1);
  var_4 = spawnfx(level._effect["sand_wall_payback_still_lg"], var_0, var_3, var_2);
  triggerfx(var_4, -2240);
  level._id_6495[level._id_6495.size] = var_4;
}

start_sandstorm_construction_fx(var_0) {
  level._id_6495 = [];
  var_1 = (-737.243, -2444.67, 531.125);
  var_2 = (0, 258, 0);
  var_3 = anglestoup(var_2);
  var_4 = anglesToForward(var_2);
  var_5 = spawnfx(level._effect["sand_wall_payback_still"], var_1, var_4, var_3);
  var_1 = (1091.39, -2842.78, 245.922);
  var_2 = (357.269, 272.002, 0.534172);
  var_3 = anglestoup(var_2);
  var_4 = anglesToForward(var_2);
  var_6 = spawnfx(level._effect["sand_wall_payback_still"], var_1, var_4, var_3);
  var_1 = (-3324.35, -2031.53, 415.489);
  var_2 = (0, 242, 0);
  var_3 = anglestoup(var_2);
  var_4 = anglesToForward(var_2);
  var_7 = spawnfx(level._effect["sand_wall_payback_still"], var_1, var_4, var_3);

  if(!isDefined(var_0)) {
    triggerfx(var_5);
    triggerfx(var_6);
    triggerfx(var_7);
  } else {
    triggerfx(var_5, var_0);
    triggerfx(var_6, var_0);
    triggerfx(var_7, var_0);
  }

  level._id_6495[level._id_6495.size] = var_5;
  level._id_6495[level._id_6495.size] = var_6;
  level._id_6495[level._id_6495.size] = var_7;
}

disable_hands() {
  level.player disableweapons();
  level.player disableweaponswitch();
  level.player disableoffhandweapons();
}

enable_hands() {
  level.player enableweapons();
  level.player enableweaponswitch();
  level.player enableoffhandweapons();
}

spawn_smoke(var_0) {
  var_1 = common_scripts\utility::getfx("thick_black_smoke_L");
  playFXOnTag(var_1, var_0, "tag_origin");

  if(!isDefined(level._id_649E)) {
    level._id_649E = [];
  }
  var_0._id_649F = var_1;
  level._id_649E[level._id_649E.size] = var_0;
}

remove_smokes() {
  if(isDefined(level._id_649E)) {
    for(var_0 = 0; var_0 < level._id_649E.size; var_0++) {
      var_1 = level._id_649E[var_0];

      if(isDefined(var_1)) {
        stopFXOnTag(var_1._id_649F, var_1, "tag_origin");
      }
    }

    level._id_649E = [];
  }
}

waittill_spawn_finished() {
  if(!isDefined(self.finished_spawning) || !self.finished_spawning) {
    self waittill("finished spawning");
  }
}

get_nikolai_chopper() {
  if(!isDefined(level.chopper)) {
    nikolai_chopper_init();
  }
  return level.chopper;
}

nikolai_chopper_init() {
  if(!isDefined(level.chopper)) {
    level.chopper = maps\_vehicle::spawn_vehicle_from_targetname("heli_nikolai");
  }
  level.chopper.repulsor = missile_createrepulsorent(level.chopper, 5000, 800);
  level.chopper setCanDamage(0);
  level.chopper setvehicleteam("allies");
  level.chopper.ignoreall = 1;
  level.chopper setmaxpitchroll(30, 30);
  level.chopper setturningability(1.0);
  level.chopper setjitterparams((1000, 1000, 500), 0.25, 0.75);
  level.chopper sethoverparams(100, 20, 10);
  var_0 = level.chopper gettagorigin("tag_origin");
  var_1 = level.chopper gettagorigin("tag_ground");
  level.chopper.originheightoffset = var_0[2] - var_1[2] + 22;
  thread maps\payback_aud::_id_5623();
  return level.chopper;
}

nikolai_init() {
  if(!isDefined(level.nikolai)) {
    level.nikolai = spawn_ally("nikolai", "nikolai_spawn_point");
  }
  if(!isDefined(level.nikolai_in_chopper)) {
    get_nikolai_chopper() maps\_vehicle::vehicle_load_ai_single(level.nikolai);
    level.nikolai_in_chopper = 1;
  }
}

tag_vicinity_check(var_0, var_1, var_2, var_3) {
  level endon(var_3);
  waittillframeend;
  var_4 = var_2 * var_2;

  for(;;) {
    var_5 = var_0 gettagorigin(var_1);

    if(distancesquared(var_5, self.origin) <= var_4) {
      level notify(var_3);
    }
    wait 0.05;
  }
}

hide_hud_for_scripted_sequence() {
  setsaveddvar("compass", 0);
  setsaveddvar("ammoCounterHide", 1);
  setsaveddvar("hud_showstance", 0);
  setsaveddvar("actionSlotsHide", 1);
}

show_hud_after_scripted_sequence() {
  setsaveddvar("compass", 1);
  setsaveddvar("ammoCounterHide", 0);
  setsaveddvar("hud_showstance", 1);
  setsaveddvar("actionSlotsHide", 0);
}

move_player_to_start(var_0) {
  if(!isDefined(var_0)) {
    var_0 = level.start_point + "_playerstart";
  }
  return move_player_to_scriptstruct(var_0, "targetname");
}

move_player_to_scriptstruct(var_0, var_1) {
  var_2 = common_scripts\utility::getStruct(var_0, var_1);

  if(isDefined(var_2)) {
    level.player setOrigin(var_2.origin);
    level.player setplayerangles(var_2.angles);
    return 1;
  }

  return 0;
}

spawn_ally(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = level.start_point + "_" + var_0;
  }
  var_2 = spawn_noteworthy_at_struct_targetname(var_0, var_1);
  return var_2;
}

ai_array_killcount_flag_set(var_0, var_1, var_2, var_3) {
  maps\_utility::waittill_dead_or_dying(var_0, var_1, var_3);
  common_scripts\utility::flag_set(var_2);
}

array_spawn_allow_fail(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    var_4.count = 1;
    var_5 = var_4 maps\_utility::spawn_ai(var_1);

    if(isDefined(var_5)) {
      var_2[var_2.size] = var_5;
    }
  }

  return var_2;
}

array_spawn_targetname_allow_fail(var_0) {
  var_1 = getEntArray(var_0, "targetname");
  return array_spawn_allow_fail(var_1);
}

spawn_noteworthy_at_struct_targetname(var_0, var_1) {
  var_2 = getEnt(var_0, "script_noteworthy");
  var_3 = common_scripts\utility::getStruct(var_1, "targetname");
  var_2.origin = var_3.origin;

  if(isDefined(var_3.angles)) {
    var_2.angles = var_3.angles;
  }
  var_4 = var_2 maps\_utility::spawn_ai();
  return var_4;
}

setup_spawn_funcs() {
  level.custom_spawn_funcs = [];
  level.custom_spawn_funcs["chopper_street_runners"] = ::spawn_func_chopper_street_runners;
  level.custom_spawn_funcs["respawn_on_death_flashlights"] = ::spawn_func_respawn_on_death_flashlights;
  level.custom_spawn_funcs["flashlight_runner"] = ::spawn_func_flashlight_searcher_delete_at_path_end;
  level.custom_spawn_funcs["flashlight_runner_delete_at_path_end"] = ::spawn_func_flashlight_runner;
  level.custom_spawn_funcs["crush_player"] = ::spawn_func_crushplayer;
  level.custom_spawn_funcs["sandstorm_combat"] = ::spawn_func_flashlight_runner_delete_at_path_end;
  level.custom_spawn_funcs["sandstorm_combat_delete"] = ::spawn_func_sandstorm_combat_delete;
  level.custom_spawn_funcs["sandstorm_combat_rusher"] = ::spawn_func_sandstorm_combat_rusher;
  level.custom_spawn_funcs["sandstorm_combat_pather"] = ::spawn_func_sandstorm_combat_pather;
  level.custom_spawn_funcs["sandstorm_combat_flood"] = ::spawn_func_sandstorm_combat;
  level.custom_spawn_funcs["ignore_till_path_end"] = ::spawn_func_ignore_till_path_end;
  level.custom_spawn_funcs["delete_at_path_end"] = ::spawn_func_delete_at_path_end;
  level.custom_spawn_funcs["respawn_on_death"] = ::spawn_func_respawn_on_death;
  level.custom_spawn_funcs["target_escape_chopper"] = ::spawn_func_target_escape_chopper;
  level.custom_spawn_funcs["ignore_til_pathend_or_damage_spawners"] = ::chase_ignore_til_pathend_or_damage;
  level.custom_spawn_funcs["chopper_drop_off_land"] = ::spawn_func_chopper_drop_off_land;
  var_0 = getarraykeys(level.custom_spawn_funcs);

  foreach(var_2 in var_0) {
    var_3 = getEntArray(var_2, "script_noteworthy");

    if(isDefined(var_3) && var_3.size) {
      maps\_utility::array_spawn_function_noteworthy(var_2, level.custom_spawn_funcs[var_2]);
    }
  }

  var_5 = getspawnerteamarray("axis");
  var_6 = [];

  foreach(var_8 in var_5) {
    if(!isDefined(var_8.script_parameters)) {
      continue;
    }
    var_6[var_6.size] = var_8;
  }

  if(var_6.size > 0) {
    maps\_utility::array_spawn_function(var_6, ::process_ai_script_parameters);
  }
}

randomize_normal(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = level.custom_spawn_funcs[var_1];

    foreach(var_4 in var_0) {
      if(isalive(var_4)) {
        var_4 thread[[var_2]]();
      }
    }
  }
}

spawn_func_chopper_street_runners() {
  self endon("death");
  maps\payback_sandstorm_code::flashlight_on_guy();
  maps\_utility::enable_cqbwalk();
  common_scripts\utility::waittill_either("goal", "damage");
  maps\_utility::disable_cqbwalk();
}

spawn_func_respawn_on_death_flashlights() {
  maps\payback_sandstorm_code::flashlight_on_guy();
  thread spawn_func_force_respawn_on_death();
  waittill_spawn_finished();
  self.baseaccuracy = 0.15;
}

spawn_func_flashlight_searcher_delete_at_path_end() {
  self.sprint = 1;
  maps\payback_sandstorm_code::flashlight_on_guy();
}

spawn_func_flashlight_runner() {
  spawn_func_flashlight_searcher_delete_at_path_end();
  spawn_func_delete_at_path_end();
}

spawn_func_crushplayer() {
  var_0 = !isDefined(self.script_fixednode) || !self.script_fixednode;
  activate_crush_player_mode(var_0);
}

spawn_func_flashlight_runner_delete_at_path_end() {
  maps\payback_sandstorm_code::flashlight_on_guy();
  waittill_spawn_finished();
  self.baseaccuracy = 0.01;
}

spawn_func_sandstorm_combat_delete() {
  self endon("death");
  thread spawn_func_flashlight_runner_delete_at_path_end();
  combat_runner_enable();
  thread spawn_func_delete_at_path_end();
}

spawn_func_sandstorm_combat() {
  thread spawn_func_flashlight_runner_delete_at_path_end();
  thread spawn_func_respawn_on_death();
}

spawn_func_sandstorm_combat_rusher() {
  self endon("death");
  thread spawn_func_flashlight_runner_delete_at_path_end();
  self setgoalentity(level.player);
  combat_runner_enable();
  maps\_utility::enable_sprint();
  var_0 = 512;
  var_1 = var_0 * var_0;

  for(;;) {
    if(distancesquared(self.origin, level.player.origin) <= var_1) {
      combat_runner_disable();
      return;
    }

    wait 0.2;
  }
}

spawn_func_sandstorm_combat_pather() {
  self endon("death");
  thread spawn_func_flashlight_runner_delete_at_path_end();
  combat_runner_enable();
  self waittill("reached_path_end");
  combat_runner_disable();
}

spawn_func_ignore_till_path_end() {
  self.ignoreall = 1;
  self clearenemy();
  self waittill("reached_path_end");
  self.ignoreall = 0;
}

spawn_func_delete_at_path_end() {
  self endon("death");
  self waittill("reached_path_end");

  if(isDefined(self)) {
    self delete();
  }
}

spawn_func_chopper_drop_off_land() {
  maps\_utility::ent_flag_init("drop_off");
  maps\_utility::ent_flag_wait("drop_off");
  maps\_utility::vehicle_detachfrompath();
  wait 0.1;
  maps\_utility::vehicle_land();
  maps\_vehicle::vehicle_unload();
  maps\_utility::ent_flag_wait("unloaded");
  thread maps\_utility::vehicle_liftoff();
  wait 0.5;
  maps\_utility::vehicle_resumepath();
}

chase_ignore_til_pathend_or_damage() {
  self endon("death");
  ignore_everything();
  common_scripts\utility::waittill_either("reached_path_end", "damage");
  clear_ignore_everything();
}

ignore_everything() {
  self.ignoreall = 1;
  self.grenadeawareness = 0;
  self.ignoreexplosionevents = 1;
  self.ignorerandombulletdamage = 1;
  self.ignoresuppression = 1;
  self.fixednode = 0;
  self.disablebulletwhizbyreaction = 1;
  maps\_utility::disable_pain();
  self.og_newenemyreactiondistsq = self.newenemyreactiondistsq;
  self.newenemyreactiondistsq = 0;
}

clear_ignore_everything() {
  self.ignoreall = 0;
  self.grenadeawareness = 1;
  self.ignoreexplosionevents = 0;
  self.ignorerandombulletdamage = 0;
  self.ignoresuppression = 0;
  self.fixednode = 1;
  self.disablebulletwhizbyreaction = 0;
  maps\_utility::enable_pain();

  if(isDefined(self.og_newenemyreactiondistsq)) {
    self.newenemyreactiondistsq = self.og_newenemyreactiondistsq;
  }
}

spawn_func_respawn_on_death() {
  var_0 = self.spawner;

  if(isDefined(var_0) && isDefined(var_0.script_parameters)) {
    level endon(var_0.script_parameters);
  }
  common_scripts\utility::waittill_either("death", "pain_death");
  wait 1;
  var_1 = undefined;

  while(!isDefined(var_1) && isDefined(var_0) && isDefined(var_0.count) && var_0.count > 0) {
    var_1 = var_0 maps\_utility::spawn_ai();
    wait 1;
  }
}

spawn_func_force_respawn_on_death() {
  var_0 = self.spawner;

  if(isDefined(var_0) && isDefined(var_0.script_parameters)) {
    level endon(var_0.script_parameters);
  }
  common_scripts\utility::waittill_either("death", "pain_death");
  wait 1;
  var_1 = undefined;

  while(!isDefined(var_1) && isDefined(var_0) && isDefined(var_0.count) && var_0.count > 0) {
    var_1 = var_0 maps\_utility::spawn_ai(1);
    wait 1;
  }
}

spawn_func_target_escape_chopper() {
  if(issentient(self)) {
    thread thread_target_escape_chopper();
  } else if(isDefined(self.riders)) {
    waittillframeend;

    foreach(var_1 in self.riders) {
      if(isDefined(var_1) && isalive(var_1)) {
        var_1 thread thread_target_escape_chopper();
      }
    }
  }
}

thread_target_escape_chopper() {
  self notify("thread_target_escape_chopper");
  self endon("thread_target_escape_chopper");
  self endon("death");
  common_scripts\utility::flag_wait("escape_chopper_took_off");
  self setentitytarget(get_nikolai_chopper());
}

trigger_activate_targetname_safe(var_0) {
  var_1 = getEnt(var_0, "targetname");

  if(isDefined(var_1)) {
    var_1 notify("trigger");
  }
}

array_wait_any(var_0, var_1, var_2) {
  var_3 = "array_wait_any_" + var_1;

  foreach(var_5 in var_0) {}
  var_5 thread array_wait_set(var_1, var_3);

  if(!isDefined(var_2)) {
    level waittill(var_3);
  } else {
    level common_scripts\utility::waittill_any_timeout(var_2, var_3);
  }
}

array_wait_set(var_0, var_1) {
  self waittill(var_0);
  level notify(var_1);
}

ally_chase_setup() {
  maps\_utility::disable_cqbwalk();
  self.grenadeawareness = 1;
  self.ignoreexplosionevents = 1;
  self.ignorerandombulletdamage = 1;
  self.disablebulletwhizbyreaction = 1;
  maps\_utility::disable_pain();
  maps\_utility::disable_surprise();
  self.pathenemylookahead = 1024;
  maps\_utility::enable_heat_behavior(1);
  self.baseaccuracy = 50;
}

ally_chase_setup_clear() {
  self.grenadeawareness = 0;
  self.ignoreexplosionevents = 0;
  self.ignorerandombulletdamage = 0;
  self.disablebulletwhizbyreaction = 0;
  maps\_utility::enable_pain();
  maps\_utility::enable_surprise();
  maps\_utility::disable_heat_behavior();
  self.moveplaybackrate = 1;
}

custom_move_to(var_0, var_1, var_2) {
  maps\_utility::disable_cqbwalk();
  maps\_utility::set_generic_run_anim(var_1, 1);
  self.disablearrivals = 1;
  self.disableexits = 1;
  self.goalradius = 32;
  self setgoalnode(var_0);
  self waittill("goal");
  self setgoalpos(self.origin);

  if(isDefined(var_2) && var_2 == 1) {
    custom_move_reset();
  }
}

custom_move_reset() {
  maps\_utility::clear_run_anim();
  self.disablearrivals = 0;
  self.disableexits = 0;
}

activate_crush_player_mode(var_0) {
  if(!isDefined(self._id_64C9)) {
    self._id_64C9 = 1;
    self._id_64CA = 1;

    if(isalive(self)) {
      self.health = self.health * 3;
    }
    self.maxhealth = self.maxhealth * 3;

    if(!threatbiasgroupexists("player")) {
      createthreatbiasgroup("player");
      level.player._id_64CB = level.player getthreatbiasgroup();
    }

    if(!threatbiasgroupexists("crush_player")) {
      createthreatbiasgroup("crush_player");
      setthreatbias("crush_player", "player", 10000);
    }

    level.player setthreatbiasgroup("player");
    self._id_64CB = self getthreatbiasgroup();
    self setthreatbiasgroup("crush_player");

    if(isDefined(var_0) && var_0) {
      thread maps\_utility::player_seek();
    }
  }
}

activate_crush_player_mode_all(var_0) {
  var_1 = getaiarray("axis");
  common_scripts\utility::array_thread(var_1, ::activate_crush_player_mode, var_0);
}

deactivate_crush_player_mode() {
  if(isDefined(self._id_64C9)) {
    self._id_64C9 = undefined;
    self._id_64CA = 0;
    self.maxhealth = int(self.maxhealth / 3);

    if(isalive(self)) {
      var_0 = int(max(1, int(min(self.health, self.maxhealth))));
      self.health = var_0;
    }

    self setthreatbiasgroup(self._id_64CB);
    var_1 = getaiarray("axis");

    foreach(var_3 in var_1) {
      if(isalive(var_3) && isDefined(var_3._id_64C9)) {
        return;
      }
    }

    level.player setthreatbiasgroup(level.player._id_64CB);
  }
}

deactivate_crush_player_mode_all() {
  var_0 = getaiarray("axis");
  common_scripts\utility::array_thread(var_0, ::deactivate_crush_player_mode);
}

init_color_trigger_listeners(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }
  if(var_1) {
    if(!isDefined(level.payback_color_trigger_disable_previous)) {
      level.payback_color_trigger_disable_previous = [];
    }
    level.payback_color_trigger_disable_previous[var_0] = 1;
  }

  var_2 = getEntArray(var_0, "script_noteworthy");

  foreach(var_4 in var_2) {
    if(var_1) {
      var_5 = strtok(var_4.targetname, "_");
      var_6 = var_5[var_5.size - 1];
      var_4._id_64D1 = int(var_6);
    }

    var_4 thread payback_color_trigger_listener();
  }
}

payback_color_trigger_listener() {
  self endon("disable_trigger");
  self._id_64D3 = 1;
  self waittill("trigger");
  var_0 = [];

  if(isDefined(level.payback_color_trigger_disable_previous) && isDefined(level.payback_color_trigger_disable_previous[self.script_noteworthy])) {
    var_1 = getEntArray(self.script_noteworthy, "script_noteworthy");

    foreach(var_3 in var_1) {
      if(var_3._id_64D3 && var_3._id_64D1 <= self._id_64D1) {
        var_0[var_0.size] = var_3;
        var_3._id_64D3 = 0;
      }
    }
  } else {
    var_0 = getEntArray(self.targetname, "targetname");
  }
  foreach(var_3 in var_0) {
    var_3 notify("disable_trigger");
    var_3 common_scripts\utility::trigger_off();
  }
}

chopper_init_fog_brushes() {
  level.chopper_fog_brushes = getEntArray("chopper_fog_brush", "targetname");

  foreach(var_1 in level.chopper_fog_brushes) {
    var_1 hide();
    var_1 notsolid();

    if(isDefined(level.chopper)) {
      var_1.origin = level.chopper.origin;
      var_1 linkTo(level.chopper);
    }
  }
}

notify_on_trigger(var_0) {
  common_scripts\utility::flag_init(var_0);
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1) {}
  var_3 thread notify_on_trigger_thread(self, var_0);
}

notify_on_trigger_thread(var_0, var_1) {
  var_0 endon(var_1);
  self waittill("trigger", var_2);
  thread maps\_utility::flag_set_delayed(var_1, 0.05);
  level notify(var_1, var_2);
  var_0 notify(var_1, var_2);
}

explosion_ragdoll_fling(var_0, var_1, var_2, var_3) {
  var_4 = getaispeciesarray(var_0, "all");

  foreach(var_6 in var_4) {
    if(isDefined(var_6) && distance(var_6.origin, var_1) <= var_2) {
      var_6._id_648F = 2.0;
      var_6 notify("flashlight_off_delayed");
      var_6 startragdoll();
      var_6 dodamage(var_6.health, (0, 0, 0));
    }
  }

  wait 0.1;
  physicsexplosionsphere(var_1 - (0, 0, var_2 / 4), var_2, var_2 / 2, var_3);
}

_id_64D9(var_0, var_1) {
  var_2 = vectorNormalize((randomfloatrange(-1, 1), randomfloatrange(-1, 1), randomfloatrange(-1, 1)));
  var_3 = 1;

  if(vectordot(var_2, var_0) < 0) {
    var_3 = -1;
  }
  var_4 = (1.0 - var_1) * var_0;
  var_5 = var_3 * var_1 * var_2;
  return vectorNormalize(var_4 + var_5);
}

wait_till_stopped(var_0) {
  wait 0.1;

  if(!isDefined(var_0)) {
    var_0 = 0.1;
  }
  for(;;) {
    var_1 = self.origin;
    var_2 = self.angles;
    wait(var_0);

    if(var_1 == self.origin && var_2 == self.angles) {
      break;
    }
  }
}

oscillate_entity(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_4 = self.origin;
  var_0 = vectorNormalize(var_0);
  var_5 = 1.0 / var_2;

  if(isDefined(var_3)) {
    thread tv_death();
  }
  for(;;) {
    self moveTo(var_4 + var_0 * var_1, var_5, 0.05, 0.05);
    wait(var_5);
    self moveTo(var_4 + var_0 * var_1 * -1, var_5, 0.05, 0.05);
    wait(var_5);
  }
}

tv_death() {
  self endon("death");

  for(;;) {
    wait 0.05;
  }
}

drop_to_floor() {
  var_0 = bulletTrace(self.origin + (0, 0, 32), self.origin, 0, undefined);
  self.origin = var_0["position"];
}

combat_runner_enable() {
  self.grenadeawareness = 0;
  self.notarget = 1;
  self.ignoreme = 1;
  self.ignoresuppression = 1;
  self.suppressionwait_old = self.suppressionwait;
  self.suppressionwait = 0;
  self.disablebulletwhizbyreaction = 1;
}

combat_runner_disable() {
  self.grenadeawareness = 1;
  self.notarget = 0;
  self.ignoreme = 0;
  self.ignoresuppression = 0;
  self.suppressionwait = self.suppressionwait_old;
  self.suppressionwait_old = undefined;
  self.disablebulletwhizbyreaction = 0;
}

temp_dialogue(var_0, var_1, var_2) {
  level notify("temp_dialogue", var_0, var_1, var_2);
  level endon("temp_dialogue");

  if(!isDefined(var_2)) {
    var_2 = 4;
  }
  if(isDefined(level.tmp_subtitle)) {
    level.tmp_subtitle destroy();
    level.tmp_subtitle = undefined;
  }

  level.tmp_subtitle = newhudelem();
  level.tmp_subtitle.x = -60;
  level.tmp_subtitle.y = -62;
  level.tmp_subtitle settext("^2" + var_0 + ": ^7" + var_1);
  level.tmp_subtitle.fontscale = 1.46;
  level.tmp_subtitle.alignx = "center";
  level.tmp_subtitle.aligny = "middle";
  level.tmp_subtitle.horzalign = "center";
  level.tmp_subtitle.vertalign = "bottom";
  level.tmp_subtitle.sort = 1;
  wait(var_2);
  thread temp_dialogue_fade();
}

temp_dialogue_fade() {
  level endon("temp_dialogue");

  for(var_0 = 1.0; var_0 > 0.0; var_0 = var_0 - 0.1) {
    level.tmp_subtitle.alpha = var_0;
    wait 0.05;
  }

  level.tmp_subtitle destroy();
}

set_black_fade(var_0, var_1) {
  level notify("set_black_fade", var_0, var_1);
  level endon("set_black_fade");

  if(!isDefined(var_0)) {
    var_0 = 1;
  }
  var_0 = max(0.0, min(1.0, var_0));

  if(!isDefined(var_1)) {
    var_1 = 1;
  }
  var_1 = max(0.01, var_1);

  if(!isDefined(level.hud_black)) {
    level.hud_black = newhudelem();
    level.hud_black.x = 0;
    level.hud_black.y = 0;
    level.hud_black.horzalign = "fullscreen";
    level.hud_black.vertalign = "fullscreen";
    level.hud_black.foreground = 1;
    level.hud_black.sort = -999;
    level.hud_black setshader("black", 650, 490);
    level.hud_black.alpha = 0.0;
  }

  level.hud_black fadeovertime(var_1);
  level.hud_black.alpha = max(0.0, min(1.0, var_0));

  if(var_0 <= 0) {
    wait(var_1);
    level.hud_black destroy();
    level.hud_black = undefined;
  }
}

greater_dot(var_0, var_1) {
  return var_0.dot > var_1.dot;
}

lesser_dot(var_0, var_1) {
  return var_0.dot < var_1.dot;
}

insert_in_array(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = 0;

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    if(!var_4) {
      if([[var_2]](var_0[var_5], var_1)) {
        var_3[var_3.size] = var_1;
        var_4 = 1;
      }
    }

    var_3[var_3.size] = var_0[var_5];
  }

  if(!var_4) {
    var_3[var_3.size] = var_1;
  }
  return var_3;
}

get_array_within_fov(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4[1] = [];
  var_4[0] = [];
  var_5[1] = ::lesser_dot;
  var_5[0] = ::lesser_dot;

  for(var_6 = 0; var_6 < var_2.size; var_6++) {
    var_7 = var_2[var_6];
    var_8 = vectorNormalize(var_7.origin - var_0);
    var_9 = vectordot(var_1, var_8);
    var_7.dot = var_9;
    var_10 = var_9 >= var_3;
    var_4[var_10] = insert_in_array(var_4[var_10], var_7, var_5[var_10]);
  }

  return var_4;
}

get_cantrace_array(var_0) {
  var_1 = [];
  var_2 = self getEye();

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    if(!bullettracepassed(var_2, var_0[var_3] gettagorigin("tag_eye"), 0, undefined)) {
      continue;
    }
    var_1[var_1.size] = var_0[var_3];
  }

  return var_1;
}

unlimited_ammo_till(var_0, var_1) {
  self notify("unlimited_ammo_till");
  self endon("unlimited_ammo_till");

  if(isDefined(var_0)) {
    level endon(var_0);
    self endon(var_0);
  }

  var_2 = 0;

  for(;;) {
    if(isDefined(var_1) && var_2 >= var_1) {
      return;
    }
    var_3 = self getcurrentweapon();

    if(var_3 != "none") {
      var_4 = self getcurrentweaponclipammo();
      var_5 = weaponclipsize(var_3);

      if(isDefined(var_5)) {
        var_6 = var_5 - var_4;

        if(isDefined(var_6) && var_6 > 0) {
          self setweaponammoclip(var_3, var_4 + var_6);
        }
      }
    }

    wait 0.05;
    var_2 = var_2 + 0.05;
  }
}

phantom_pressure(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level notify("phantom_pressure");
  level endon("phantom_pressure");

  for(;;) {
    if(!isDefined(var_0)) {
      return;
    }
    var_8 = 500;
    var_9 = var_2[randomint(var_2.size)];

    if(isDefined(var_9.radius)) {
      var_8 = var_9.radius;
    }
    var_10 = vectorNormalize((randomfloatrange(-1, 1), randomfloatrange(-1, 1), randomfloatrange(-1, 1)));

    if(vectordot(var_10, (0, 0, 1)) < 0) {
      var_10 = var_10 * -1;
    }
    var_10 = var_10 * randomfloatrange(0, var_8);
    var_11 = var_9.origin + var_10;
    var_12 = var_11 - var_0.origin;
    var_13 = length(var_12);
    var_12 = vectorNormalize(var_12);
    var_14 = vectortoangles(var_12);
    var_14 = anglestoup(var_14);
    var_14 = _id_64D9(var_14, 0.6);
    var_15 = 200;

    if(randomint(4) == 0) {
      var_14 = var_14 * -1;
      var_15 = 50;
    }

    if(isDefined(var_7)) {
      var_15 = var_15 * (1.0 / var_7);
    }
    var_14 = var_14 * randomfloatrange(var_15, var_15 + 50);
    var_16 = var_0.origin + var_14 + var_12 * -1000;
    var_17 = bulletTrace(var_11, var_16, 1);
    var_18 = var_17["entity"];

    if(!isDefined(var_18) || !isDefined(var_18.team) || var_18.team != level.player.team) {
      magicbullet(var_1, var_11, var_16);
      maps\_audio::aud_send_msg("magic_bullet_fire", var_11);
    }

    var_19 = randomfloatrange(var_3, var_3 * 2);
    var_20 = (var_13 - var_5) / (var_6 - var_5);

    if(var_20 > 0) {
      var_21 = var_4 - var_3 * 2;
      var_19 = var_19 + randomfloatrange(var_21 * 0.5, var_21);
    }

    wait(var_19);
  }
}

moderate_ai_moveplaybackrate(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  level endon(var_0);
  var_13 = var_4 - var_3;
  var_14 = var_2 - var_1;
  var_15 = var_6 - var_5;
  var_16 = var_8 - var_7;

  for(;;) {
    var_17 = (0, 0, 0);
    var_18 = [];

    foreach(var_22, var_20 in var_12) {
      var_17 = var_17 + var_20.origin;
      var_21 = distance(var_20.origin, level.friendly_endpoint);
      var_18[var_22] = var_21 + var_11[var_22];
    }

    var_17 = var_17 / var_12.size;
    var_23 = 99999999;

    foreach(var_21 in var_18) {
      if(var_21 < var_23) {
        var_23 = var_21;
      }
    }

    var_26 = [];

    foreach(var_22, var_21 in var_18) {}
    var_18[var_22] = var_18[var_22] - var_23;

    var_28 = 0;

    foreach(var_21 in var_18) {
      if(var_21 > var_28) {
        var_28 = var_21;
      }
    }

    var_31 = var_28 * var_9 / var_10;
    var_31 = var_31 * 0.5;

    if(var_31 > var_9) {
      var_31 = var_9;
    }
    var_32 = var_28 * 0.5;
    var_26 = [];

    foreach(var_22, var_21 in var_18) {
      var_21 = var_21 - var_32;
      var_21 = var_21 / abs(var_32);
      var_26[var_22] = var_21 * var_31;
    }

    var_34 = distance(var_17, level.friendly_endpoint);
    var_35 = distance(level.player.origin, level.friendly_endpoint);
    var_21 = var_35 - var_34;
    level notify("player_dist_from_squad", var_21);
    var_36 = var_21;
    var_21 = var_21 - var_3;
    var_37 = var_21 / var_13;

    if(var_37 < 0) {
      var_37 = 0;
    } else if(var_37 > 1) {
      var_37 = 1;
    }
    var_37 = 1 - var_37;
    var_38 = var_1 + var_14 * var_37;
    var_21 = var_36 - var_7;
    var_37 = var_21 / var_16;

    if(var_37 < 0) {
      var_37 = 0;
    } else if(var_37 > 1) {
      var_37 = 1;
    }
    var_39 = var_5 + var_15 * var_37;
    setsaveddvar("player_sprintSpeedScale", var_39);

    if(1) {
      foreach(var_22, var_20 in var_12) {
        var_20.moveplaybackrate = var_38 + var_26[var_22];

        if(var_20.moveplaybackrate > 1.15) {
          var_20.moveplaybackrate = 1.15;
        }
      }
    }

    wait 0.05;
  }
}

process_ai_script_parameters() {
  if(!isDefined(self.script_parameters)) {
    return;
  }
  var_0 = strtok(self.script_parameters, ":;, ");

  foreach(var_2 in var_0) {
    var_2 = tolower(var_2);

    if(var_2 == "balcony") {
      self.deathfunction = ::try_balcony_death;
    }
  }
}

try_balcony_death() {
  if(!isDefined(self)) {
    return 0;
  }
  if(self.a.pose == "prone") {
    return 0;
  }
  if(!isDefined(self.prevnode)) {
    return 0;
  }
  if(!isDefined(self.prevnode._id_64EE)) {
    return 0;
  }
  var_0 = self.angles[1];
  var_1 = self.prevnode.angles[1];
  var_2 = abs(angleclamp180(var_0 - var_1));

  if(var_2 > 45) {
    return 0;
  }
  var_3 = distance(self.origin, self.prevnode.origin);

  if(var_3 > 16) {
    return 0;
  }
  if(isDefined(level._id_64EF)) {
    var_4 = gettime() - level._id_64EF;

    if(var_4 < 5000) {
      return 0;
    }
  }

  var_5 = getEntArray("trigger_balcony", "targetname");

  foreach(var_7 in var_5) {
    var_3 = distance(var_7.origin, self.origin);

    if(var_3 < 48) {
      var_7 notify("trigger");
    }
  }

  glassradiusdamage(self.origin, 48, 500, 500);
  level._id_64EF = gettime();
  var_9 = maps\_utility::getgenericanim("balcony_death");
  self.deathanim = var_9[randomint(var_9.size)];
  return 0;
}

wait_until_enemies_in_volume(var_0, var_1) {
  var_2 = getEnt(var_0, "targetname");
  var_3 = var_2 maps\_utility::get_ai_touching_volume("axis");
  var_4 = var_3.size;

  while(var_4 > var_1) {
    wait 1;
    var_3 = var_2 maps\_utility::get_ai_touching_volume("axis");
    var_4 = var_3.size;

    if(var_4 - var_1 < 3) {
      foreach(var_6 in var_3) {
        if(var_6 maps\_utility::doinglongdeath() || var_6.delayeddeath) {
          var_4--;
        }
      }
    }
  }
}

moderate_reset(var_0) {
  setsaveddvar("player_sprintSpeedScale", 1.5);

  foreach(var_3, var_2 in var_0) {}
  var_2.moveplaybackrate = 1;
}

payback_array_waittill_combat(var_0, var_1) {
  foreach(var_3 in var_0) {}
  thread payback_waittill_combat_internal(var_3, var_1);

  level waittill("sandstorm_combat_" + var_1);
}

payback_waittill_combat_internal(var_0, var_1) {
  var_0 common_scripts\utility::waittill_any("enemy", "death", "damage");
  level notify("sandstorm_combat_" + var_1);
}

play_vo(var_0, var_1) {
  level maps\_utility::function_stack(::play_vo_internal, self, var_0, var_1);
}

play_vo_internal(var_0, var_1, var_2) {
  if(isDefined(var_2) && var_2) {
    var_0 maps\_utility::radio_dialogue(var_1);
  } else {
    var_0 maps\_utility::dialogue_queue(var_1);
  }
}

raven_player_can_see_ai(var_0, var_1) {
  var_2 = gettime();

  if(!isDefined(var_1)) {
    var_1 = 0;
  }
  if(isDefined(var_0.playerseesmetime) && var_0.playerseesmetime + var_1 >= var_2) {
    return var_0.playerseesme;
  }
  var_0.playerseesmetime = var_2;

  if(!maps\_utility::within_fov(level.player.origin, level.player.angles, var_0.origin, 0.766)) {
    var_0.playerseesme = 0;
    return 0;
  }

  var_3 = level.player getEye();
  var_4 = var_0.origin;

  if(sighttracepassed(var_3, var_4, 0, level.player)) {
    var_0.playerseesme = 1;
    return 1;
  }

  var_5 = var_0 getEye();

  if(sighttracepassed(var_3, var_5, 0, level.player)) {
    var_0.playerseesme = 1;
    return 1;
  }

  var_6 = (var_5 + var_4) * 0.5;

  if(sighttracepassed(var_3, var_6, 0, level.player)) {
    var_0.playerseesme = 1;
    return 1;
  }

  var_0.playerseesme = 0;
  return 0;
}

tv_trigger_wait_enter(var_0, var_1) {
  self notify("tv_trigger_wait_enter");
  self endon("tv_trigger_wait_enter");

  for(;;) {
    self waittill("trigger", var_2);
    level thread tv_movies_play(var_0, var_1);
    tv_trigger_wait_leave(var_2);
  }
}

tv_trigger_wait_leave(var_0) {
  self notify("tv_trigger_wait_leave");
  self endon("tv_trigger_wait_leave");
  level endon("tv_movies_played");

  while(isalive(var_0) && var_0 istouching(self)) {
    wait 0.05;
  }
  tv_movies_stop();
  level.tv_movie_name = undefined;
  level.tv_sound_name = undefined;
}

tv_movies_play(var_0, var_1) {
  level notify("tv_movies_play");
  level endon("tv_movies_play");
  level endon("tv_movies_stop");

  if(isDefined(var_0)) {
    level.tv_movie_name = var_0;
  }
  if(isDefined(var_1)) {
    level.tv_sound_name = var_1;
  }
  while(isDefined(level.tv_movie_name) && level.tv_movie_name != "") {
    level notify("tv_movies_played");
    setsaveddvar("cg_cinematicFullScreen", "0");
    cinematicingame(level.tv_movie_name);
    var_2 = getEntArray("interactive_tv", "targetname");

    foreach(var_4 in var_2) {
      if(!isDefined(var_4._id_64FC)) {
        if(isDefined(level.tv_sound_name) && level.tv_sound_name != "") {
          var_4 playLoopSound(level.tv_sound_name);
        }
        var_4 thread oscillate_entity_debug();
      }
    }

    wait 0.05;

    while(iscinematicplaying()) {
      wait 1;
    }
  }
}

tv_movies_stop() {
  level notify("tv_movies_stop");
  stopcinematicingame();
  var_0 = getEntArray("interactive_tv", "targetname");

  foreach(var_2 in var_0) {
    var_2 notify("tv_death");
    var_2 stoploopsound();
  }
}

oscillate_entity_debug() {
  self notify("tv_death");
  self endon("tv_death");
  common_scripts\utility::waittill_any("death", "destroyed");
  self._id_64FC = 1;
  self stoploopsound();
}

custom_in_game_movie(var_0, var_1, var_2) {
  level notify("custom_in_game_movie");
  level endon("custom_in_game_movie");
  tv_movies_stop();

  if(isDefined(var_1) && var_1 > 0) {
    wait(var_1);
  }
  setsaveddvar("cg_cinematicFullScreen", "0");
  cinematicingame(var_0);
  wait(var_2);
  level thread tv_movies_play();
}

texploder(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0.05;
  }
  var_0 = var_0 + "";

  if(!isDefined(level.triggerfxarray)) {
    level.triggerfxarray = [];
  }
  level.triggerfxarray["num"] = [];

  for(var_2 = 0; var_2 < level.createfxent.size; var_2++) {
    var_3 = level.createfxent[var_2];

    if(isDefined(var_3) && var_3.v["type"] == "exploder" && var_3.v["exploder"] + "" == var_0) {
      var_4 = var_3.v["origin"];
      var_5 = anglestoup(var_4);
      var_6 = var_3.v["angles"];
      var_7 = anglesToForward(var_6);
      var_8 = spawnfx(level._effect[var_3.v["fxid"]], var_3.v["origin"], var_7, var_5);
      triggerfx(var_8, var_1);
      level.triggerfxarray["num"][level.triggerfxarray["num"].size] = var_8;
    }
  }
}

texploder_delete(var_0) {
  if(isDefined(level.triggerfxarray["num"])) {
    level.triggerfxarray["num"] = common_scripts\utility::array_removeundefined(level.triggerfxarray["num"]);
    var_1 = level.triggerfxarray["num"];
    maps\_utility::array_delete(level.triggerfxarray["num"]);
    common_scripts\utility::array_removeundefined(level.triggerfxarray["num"]);
  }
}

toggle_hud_elements(var_0, var_1, var_2, var_3, var_4) {
  if(var_0 == 0) {
    setsaveddvar("compass", 0);
  } else {
    setsaveddvar("compass", 1);
  }
  if(var_1 == 0) {
    setsaveddvar("ammoCounterHide", 1);
  } else {
    setsaveddvar("ammoCounterHide", 0);
  }
  if(var_2 == 0) {
    setsaveddvar("hud_showstance", 0);
  } else {
    setsaveddvar("hud_showstance", 1);
  }
  if(var_3 == 0) {
    setsaveddvar("actionSlotsHide", 1);
  } else {
    setsaveddvar("actionSlotsHide", 0);
  }
  if(var_4 == 0) {
    setsaveddvar("hud_drawhud", 0);
  } else {
    setsaveddvar("hud_drawhud", 1);
  }
}