/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_trigger_spawn.gsc
***********************************************/

function init_trigger_spawns() {
  scripts\engine\utility::flag_init("weapons_free");
  scripts\engine\utility::flag_wait("strike_init_done");
  var_0 = getEntArray("trigger_spawn", "targetname");
  scripts\engine\utility::array_thread(var_0, &setup_trigger_spawn);
  var_0 = getEntArray("trigger_kill_floodspawner", "targetname");
  scripts\engine\utility::array_thread(var_0, &kill_flood_spawner);
}

function setup_trigger_spawn() {
  level endon("game_ended");
  self notify("setup_trigger_spawn");
  self endon("setup_trigger_spawn");
  self endon("death");
  scripts\engine\utility::ent_flag_init("spawning_complete");
  scripts\engine\utility::ent_flag_init("spawning_paused");
  default_trigger_loop();
  wait 1;

  if(!istrue(self.dont_delete)) {
    self delete();
    return;
  }
}

function default_trigger_loop() {
  self endon("death");
  self notify("default_trigger_loop");
  self endon("default_trigger_loop");
  self.spawnpoints = undefined;
  self.guys_spawned = 0;

  if(isDefined(self.target)) {
    self.spawnpoints = scripts\engine\utility::getStructArray(self.target, "targetname");
  }

  var_0 = [];
  var_1 = undefined;

  if(isDefined(self.spawnpoints)) {
    foreach(var_3 in self.spawnpoints) {
      if(!isDefined(var_3.script_label)) {
        continue;
      }

      if(var_3.script_label == "extra") {
        var_0 = var_3;
      }
    }

    var_1 = self.spawnpoints;
  }

  scripts\engine\utility::ent_flag_clear("spawning_complete");

  for(;;) {
    self waittill("trigger", var_5);

    if(scripts\cp\cp_modular_spawning::isambientspawningpaused()) {
      wait 1;
      continue;
    }

    if(!var_5 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(getdvarint("scr_disable_trigger_spawn", 0) == 1) {
      break;
    }

    thread on_trigger_actions(level, self);

    if(!isDefined(var_1)) {
      self notify("spawnpoints_not_found");
      return;
    }

    if(scripts\engine\utility::ent_flag_exist("spawning_paused") && scripts\engine\utility::ent_flag("spawning_paused")) {
      scripts\engine\utility::ent_flag_waitopen("spawning_paused");
    }

    switch (level.players.size) {
      case 1:
        var_1 = scripts\engine\utility::array_remove_array(var_1, var_0);
        break;
      case 2:
        var_0 = scripts\engine\utility::array_randomize(var_0);
        var_0 = [var_0[0], var_0[1]];
        var_1 = scripts\engine\utility::array_combine(var_1, var_0);
        break;
      default:
        break;
    }

    var_6 = 0;

    foreach(var_3 in var_1) {
      var_8 = _spawnsoldier(var_3);
      thread notify_trigger_on_death(var_8, self);
      var_3.lastspawntime = gettime();
      var_8.killofftime = gettime() + 10000;

      if(isDefined(level.enemy_monitor_func) && !istrue(level.disable_enemy_monitor)) {
        var_8 thread[[level.enemy_monitor_func]]("soldier");
      }

      thread respawn_on_death(var_8);
      var_6++;

      if(var_6 % 4 == 0) {
        wait 0.05;
        LOC_0000020b:
      }
      LOC_0000020b:
    }

    break;
  }
}

function notify_trigger_on_death(var_0, var_1) {
  var_0 endon("death");
  var_0.guys_spawned++;
  var_1 waittill("death");
  var_0.guys_spawned--;

  if(var_0.guys_spawned <= 0) {
    var_0 scripts\engine\utility::ent_flag_set("spawning_complete");
    return;
  }
}

function respawn_on_death(var_0) {
  level endon("game_ended");
  var_0 endon("done_spawning");

  if(!isDefined(var_0.count)) {
    return;
  }

  var_0.count = int(var_0.count);
  self endon("game_ended");
  self waittill("death");

  if(isDefined(var_0.count) && var_0.count > 0) {
    var_0.count--;
    wait_to_spawn(var_0);
    thread script_spawnsoldiers(var_0);
    return;
  }
}

function wait_to_spawn(var_0) {
  if(isDefined(var_0.script_wait)) {
    var_0.script_wait = int(var_0.script_wait);
    wait var_0.script_wait;
    return;
  }

  wait 0.1;
}

function on_trigger_actions(var_0, var_1) {
  if(isDefined(var_0.script_label)) {
    level notify("trigger_" + var_0.script_label);
  }

  if(isDefined(var_0.script_function) && isDefined(level.trigger_spawn_func[var_0.script_function])) {
    level thread[[level.trigger_spawn_func[var_0.script_function]]](var_0, var_1);
  }

  if(isDefined(var_0.script_flag)) {
    if(!scripts\engine\utility::flag_exist(var_0.script_flag)) {
      scripts\engine\utility::flag_init(var_0.script_flag);
    }

    scripts\engine\utility::flag_set(var_0.script_flag);
    return;
  }
}

function spawn_enemy(var_0, var_1) {
  var_2 = ["iw8_ar_akilo47_mp", "iw8_ar_mike4_mp", "iw8_sm_mpapa5_mp", "iw8_sm_papa90_mp", "iw8_sm_augolf_mp"];
  var_3 = ["iw8_sn_kilo98_mp"];
  var_4 = ["iw8_sh_dpapa12_mp"];
  var_5 = ["iw8_lm_kilo121_mp"];
  var_6 = ["iw8_la_rpapa7_mp"];
  var_7 = undefined;

  if(!isDefined(var_0.script_noteworthy)) {
    var_0.script_noteworthy = "soldier";
  }

  var_8 = undefined;
  var_9 = undefined;

  if(!isDefined(var_1)) {
    switch (var_0.script_noteworthy) {
      case "rpg":
        var_1 = scripts\engine\utility::random(var_6);
        var_8 = &set_default_rpg_values;
        break;
      case "shotgun":
        var_1 = scripts\engine\utility::random(var_4);
        var_9 = &hunt_player;
        break;
      case "sniper":
        var_1 = scripts\engine\utility::random(var_3);
        var_8 = &set_default_sniper_values;
        break;
      case "lmg":
        var_1 = scripts\engine\utility::random(var_5);
        var_8 = &set_default_sniper_values;
        break;
      default:
        var_1 = scripts\engine\utility::random(var_2);
        break;
    }
  }

  var_1 = scripts\cp\cp_weapon::getcompletenameforweapon(var_1);
  var_7 = spawn_enemy_soldier(var_0, var_1);

  if(isDefined(var_7)) {
    var_7.spawnpoint = var_0;
    var_7.spawnfunc = var_8;
    var_7.combatfunc = var_9;
  }

  return var_7;
}

function spawn_enemy_soldier(var_0, var_1) {
  var_2 = "axis";

  if(isDefined(level.agentteamarray)) {
    if(isDefined(level.agentteamarray["soldier"])) {
      var_2 = level.agentteamarray["soldier"];
    }
  }

  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_3 = (0, var_0.angles[1], 0);
  var_4 = var_0.origin;
  var_5 = undefined;
  var_6 = 0;
  var_7 = "actor_enemy_cp_alq_desert_ar";

  if(var_0.script_noteworthy == "juggernaut") {
    var_7 = "actor_enemy_cp_rus_juggernaut";
  }

  for(;;) {
    var_5 = scripts\mp\mp_agent::spawnnewagentaitype(var_7, var_4, var_3);

    if(isDefined(var_5)) {
      break;
    }

    var_6++;

    if(var_6 > 2) {
      return undefined;
    }

    wait 0.05;
  }

  var_5.spawnpoint = var_0;
  return var_5;
}

function go_fight(var_0) {
  self endon("death");
  self endon("dontfight");
  self.og_goalradius = self.goalradius;
  self.goalradius = 48;
  scripts\asm\asm_bb::bb_requestmovetype("combat");
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  self setgoalpos(getclosestpointonnavmesh(var_1.origin));
  scripts\engine\utility::ref_143a5("goal_reached", "goal");

  if(getdvarint("scr_alerted_hunt_enable") == 1) {
    scripts\cp\cp_agent_patrol::enter_combat();
    return;
  }

  enter_combat();
}

function set_default_values(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_0.groupname)) {
    self.groupname = var_0.groupname;
  }

  if(isDefined(var_1.script_groupname)) {
    self.groupname = var_1.script_groupname;
  }

  if(isDefined(self.unittype) && self.unittype == "juggernaut") {
    return;
  }

  self.health = 125;
  self.maxhealth = 125;
  self.og_health = 125;
  self.goalradius = 4096;
  self.og_goalradius = self.goalradius;
  self.spawnpoint = var_1;
  self.sidearm = scripts\cp\cp_weapon::buildweapon("iw8_pi_golf21_mp", [], "none", "none", -1);
  scripts\common\utility::initweapon(self.primaryweapon);
  scripts\common\utility::initweapon(self.sidearm);
  thread delay_values();

  if(isDefined(self.spawnfunc)) {
    self thread[[self.spawnfunc]]();
  }

  if(istrue(level.use_temp_bc)) {
    self.next_dmg_sound = gettime();
    var_2 = randomintrange(1, 7);
    self.painsound = "generic_pain_enemy_" + var_2;
    self.deathsound = "generic_death_enemy_" + var_2;
    return;
  }
}

function delay_values() {
  self endon("death");
  wait 0.1;
  self.dropweapon = 0;
  self.a.disablelongdeath = 1;
}

function set_default_patrol_values() {
  scripts\asm\asm_bb::bb_requestmovetype("patrol");
  self.og_goalradius = self.goalradius;
  self.goalradius = 48;
  self.ignoreall = 1;
  self.scripted_mode = 1;
  thread exit_patrol_mode();
  thread scripts\cp\cp_modular_spawning::fake_flashlight();
  self.stealth_initialized = 1;
}

function set_default_rpg_values() {
  self endon("death");
  wait 0.5;
  self.goalradius = 300;
  self.og_goalradius = self.goalradius;
  self.rocketammo = 100;
  self.accuracy = 2;
}

function set_default_sniper_values() {
  self endon("death");
  self.no_fallback = 1;
  wait 0.5;
  self.goalradius = 250;
  self.og_goalradius = self.goalradius;
}

function target_patrol_path(var_0) {
  self endon("death");
  self endon("alerted");
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");

  for(;;) {
    self setgoalpos(getclosestpointonnavmesh(var_1.origin));
    scripts\engine\utility::ref_143a5("goal_reached", "goal");

    if(isDefined(var_1.target)) {
      var_2 = scripts\engine\utility::getStruct(var_1.target, "targetname");
      var_1 = var_2;
      continue;
    }

    break;
  }
}

function getscoredpatrolpoint(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_2 = [var_2];
  } else {
    var_2 = [];
  }

  foreach(var_4 in var_1) {
    if(istrue(var_4.cooldown)) {
      var_5 = 999;
    } else if(istrue(var_4.halfcooldown)) {
      var_5 = 500;
    } else {
      var_5 = 99;
    }

    var_6 = scripts\engine\utility::get_array_of_closest(var_0.origin, scripts\cp\cp_agent_utils::getactiveagentsoftype("soldier_agent"), var_2, 5, 512);

    if(var_6.size >= 1) {
      var_5 *= 100 * var_6.size;
    }

    var_5 = clamp(var_5, 0, 999);
    var_4.patrolscore = int(var_5);
  }

  var_8 = scripts\cp\utility::quicksort(var_1);

  foreach(var_4 in var_8) {
    var_4.patrolscore = 0;
  }

  return var_8[0];
}

function setcooldown(var_0, var_1) {
  level endon("game_ended");
  var_2 = 0.5 * var_1;
  var_0.cooldown = 1;
  wait var_2;
  var_0.cooldown = undefined;
  var_0.halfcooldown = 1;
  wait var_2;
  var_0.halfcooldown = undefined;
}

function patrol_path(var_0, var_1) {
  self endon("death");
  self endon("alerted");
  var_2 = scripts\engine\utility::getStructArray("soldier_patrol", "script_noteworthy");
  var_3 = scripts\engine\utility::get_array_of_closest(var_0.origin, scripts\engine\utility::getStructArray("soldier_patrol", "script_noteworthy"), [var_0], 15);

  if(var_3.size < 1) {
    var_2 = scripts\engine\utility::getStructArray(var_0.targetname, "targetname");
    var_3 = scripts\engine\utility::get_array_of_closest(var_0.origin, scripts\engine\utility::getStructArray(var_0.targetname, "targetname"), [var_0], 15);
  }

  var_4 = scripts\engine\utility::getclosest(var_0.origin, var_3, 256);

  if(isDefined(var_4)) {
    var_5 = var_4;
    goto LOC_000000ab;
  }

  for(var_5 = getscoredpatrolpoint(self, var_4);; var_5 = getscoredpatrolpoint(self, var_4, var_5)) {
    thread setcooldown(var_5, var_5);
    self setgoalpos(getclosestpointonnavmesh(var_5.origin));
    scripts\engine\utility::ref_143ba(15, "goal_reached", "goal");

    if(scripts\engine\utility::cointoss()) {
      wait randomfloatrange(2.5, 5);
    }

    if(isDefined(var_5.target)) {
      var_6 = scripts\engine\utility::getStructArray(var_5.target, "targetname")[0];

      if(isDefined(var_6)) {
        var_5 = var_6;
        continue;
      }

      continue;
    }

    if(istrue(var_2)) {
      break;
    }
  }
}

function exit_patrol_mode() {
  self notify("exit_patrol_mode");
  self endon("exit_patrol_mode");
  self endon("death");
  self endon("alerted");

  if(scripts\engine\utility::flag_exist("infil_complete")) {
    scripts\engine\utility::flag_wait("infil_complete");
  }

  thread watch_for_bulletwhizby();
  thread watch_for_weaponsfire();
  thread soldier_player_listener();
  scripts\engine\utility::waittill_any_ents(self, "damage", level, "grenade_explosion", self, "alerted_by_soldier");

  if(getdvarint("scr_alerted_hunt_enable") == 1) {
    scripts\cp\cp_agent_patrol::enter_combat();
  } else {
    enter_combat();
  }

  wait 2.4;
  alert_all_nearby_enemies("heard damage");
}

function watch_for_bulletwhizby() {
  self endon("death");
  self endon("alerted");
  var_0 = "";
  var_1 = 0;
  var_2 = scripts\engine\utility::waittill_any_ents_return(self, "bulletwhizby", self, "door_bashopen");

  if(var_2 == "bulletwhizby") {
    var_0 = "shots heard";
    var_1 = 0;
  } else if(var_2 == "door_bashopen") {
    var_0 = "door heard";
    var_1 = 0;
  }

  if(trigger_temp_stealth_meter(5.1, undefined, var_2, var_1)) {
    if(getdvarint("scr_alerted_hunt_enable") == 1) {
      scripts\cp\cp_agent_patrol::enter_combat();
    } else {
      enter_combat();
    }

    wait 2.4;
    alert_all_nearby_enemies(var_0);
    return;
  }

  thread watch_for_bulletwhizby();
}

function watch_for_weaponsfire() {
  self endon("death");
  self endon("alerted");

  for(;;) {
    level waittill("weapon_fired", var_0, var_1, var_2);
    var_3 = 0;

    foreach(var_5 in var_1.attachments) {
      if(issubstr(var_5, "silencer")) {
        var_3 = 1;
      }
    }

    if(var_3) {
      continue;
    }

    break;
  }

  if(trigger_temp_stealth_meter(2.6, undefined, "weapon_fired", 1)) {
    if(getdvarint("scr_alerted_hunt_enable") == 1) {
      scripts\cp\cp_agent_patrol::enter_combat();
    } else {
      enter_combat();
    }

    wait 2.4;
    alert_all_nearby_enemies("shots heard");
    return;
  }
}

function trigger_temp_stealth_meter(var_0, var_1, var_2, var_3) {
  if(scripts\engine\utility::flag_exist("weapons_free") && scripts\engine\utility::flag("weapons_free")) {
    return false;
  }

  self endon("alerted");

  if(!isDefined(level.is_stealthy)) {
    return true;
  }

  if(!isDefined(var_1)) {
    var_1 = 0.25;
  }

  if(!istrue(self.has_alert_icon)) {
    self.has_alert_icon = 1;
    wait 0.05;
    var_4 = deleteheadicon(self);
    setheadiconfriendlyimage(var_4, "cp_stealth_icon_sus_sv");
    setheadicondrawthroughgeo(var_4, 1);
    setheadiconsnaptoedges(var_4, 29000);
    setheadiconmaxdistance(var_4, 425);
    addclienttoheadiconmask(var_4, 25);
    self.alert_icon = var_4;
    thread temp_stealthicon_initiate(10);
    thread temp_stealth_meter_delete_on_death(var_4);
    var_5 = undefined;

    if(!istrue(var_3)) {
      wait var_1;

      if(var_2 == "can_see") {
        foreach(var_7 in level.players) {
          if(ifcanseeplayer(self, var_7)) {
            var_5 = "can_see";
            thread temp_player_debug_whotriggered(var_7);
          }

          wait 0.05;
        }
      } else {
        var_5 = "default";
      }

      if(isDefined(var_5) && var_5 != "can_see") {
        var_5 = scripts\engine\utility::ref_143be(var_0, var_2, "can_see", "death", "near_me", "damage", "hear_turret");
      }
    }

    if(isDefined(var_5) && (var_5 == var_2 || var_5 == "can_see" || var_5 == "near_me") || istrue(var_3)) {
      thread temp_stealthicon_changecolor(var_0, 2, "cp_stealth_icon_seen");
      return true;
    } else {
      thread detected_temp_stealth_meter(self.alert_icon, 0.01);
      return false;
    }
  }

  return false;
}

function temp_stealthicon_initiate(var_0) {
  self endon("icon_deleted");
  self endon("icon_cancel_delete");
  self endon("alerted");
  self endon("death");

  if(istrue(self.has_alert_icon) || isDefined(self.alert_icon) && self.alert_icon == 0) {
    if(isalive(self)) {
      var_1 = var_0;
      var_2 = 0;

      while(var_1 > 0) {
        var_1--;
        var_2 = !var_2;

        if(var_2 == 1) {
          setheadiconfriendlyimage(self.alert_icon, "cp_stealth_icon_seen");
        } else {
          setheadiconfriendlyimage(self.alert_icon, "cp_stealth_icon_sus_sv");
        }

        wait 0.05;
        wait 0.05;
      }

      if(scripts\engine\utility::flag_exist("weapons_free") && scripts\engine\utility::flag("weapons_free")) {
        setheadiconfriendlyimage(self.alert_icon, "cp_stealth_icon_notify");
        return;
      }

      if(scripts\engine\utility::flag_exist("weapons_free") && !scripts\engine\utility::flag("weapons_free")) {
        setheadiconfriendlyimage(self.alert_icon, "cp_stealth_icon_sus_sv");
        return;
      }

      return;
    }

    return;
  }
}

function temp_stealthicon_changecolor(var_0, var_1, var_2) {
  self endon("icon_deleted");
  self endon("alerted");
  self endon("death");
  var_3 = 1;

  if(isDefined(var_1)) {
    var_3 = var_1;
  }

  for(var_4 = 0; var_4 < var_3; var_4++) {
    if(istrue(self.has_alert_icon) || isDefined(self.alert_icon) && self.alert_icon == 0) {
      if(isalive(self)) {
        self notify("icon_cancel_delete");
        setheadiconfriendlyimage(self.alert_icon, var_2);
        thread detected_temp_stealth_meter(self.alert_icon, var_0 * 5.5);
      }
    }

    wait 0.05;
  }
}

function detected_temp_stealth_meter(var_0, var_1) {
  self notify("icon_cancel_delete");
  self endon("icon_deleted");
  scripts\engine\utility::ref_143ba(var_1, "death", "alerted");
  wait 0.5;
  thread detected_temp_stealth_meter_delete(var_0);
}

function detected_temp_stealth_meter_delete(var_0) {
  self notify("icon_cancel_delete");
  self endon("icon_deleted");
  self endon("icon_cancel_delete");

  if(istrue(self.has_alert_icon) && istrue(self.alert_icon) && istrue(var_0)) {
    self.has_alert_icon = 0;
    setheadiconimage(var_0);
    var_0 = undefined;
    self notify("icon_deleted");
    return;
  }

  if(istrue(self.has_alert_icon)) {
    self.has_alert_icon = 0;
    setheadiconimage(var_0);
    var_0 = undefined;
    self notify("icon_deleted");
    return;
  }
}

function temp_stealth_meter_delete_on_death(var_0) {
  self endon("icon_deleted");
  self waittill("death");
  self notify("icon_cancel_delete");
  var_1 = 0.45;

  if(scripts\engine\utility::flag_exist("weapons_free") && scripts\engine\utility::flag("weapons_free")) {
    var_1 *= 5.5;
  }

  wait var_1;

  if(isDefined(var_0)) {
    self.has_alert_icon = 0;
    setheadiconimage(var_0);
    var_0 = undefined;
    self notify("icon_deleted");
    return;
  }
}

function temp_player_debug_whotriggered(var_0) {
  if(!scripts\engine\utility::flag_exist("weapons_free")) {
    return;
  }

  self notify("new_last_triggered");
  self endon("new_last_triggered");
  var_1 = undefined;

  for(;;) {
    if(!scripts\engine\utility::flag("weapons_free")) {
      var_1 = var_0;
    } else {
      level.debug_last_triggered = var_1;
      return;
    }

    wait 0.1;
  }
}

function enter_combat() {
  self notify("enter_combat");
  self.scripted_mode = 0;
  self.ignoreall = 0;

  if(isDefined(self.ismarked)) {
    self hudoutlinedisable();
  }

  if(isDefined(self.spawnpoint.script_goalvolume)) {
    var_0 = getEnt(self.spawnpoint.script_goalvolume, "script_noteworthy");

    if(!isDefined(var_0)) {
      var_0 = getEnt(self.spawnpoint.script_goalvolume, "targetname");
    }

    if(isDefined(var_0)) {
      self setgoalvolumeauto(var_0);
    }
  }

  foreach(var_2 in level.players) {
    if(!var_2 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    self getenemyinfo(var_2);
  }

  if(isDefined(self.og_goalradius)) {
    self.goalradius = self.og_goalradius;
  } else {
    self.goalradius = 4096;
  }

  scripts\asm\asm_bb::bb_requestmovetype("combat");

  if(isDefined(self.combatfunc)) {
    self thread[[self.combatfunc]]();
  }

  thread temp_sound_init();
}

function temp_sound_init() {
  if(istrue(level.use_temp_bc) && soundexists("dx_cbc_ru1_command_attack")) {
    if(randomint(100) > 50) {
      self playSound("dx_cbc_ru1_command_attack");
    }

    self.next_dmg_sound = gettime() + randomintrange(1000, 3000);
    thread temp_sound_watcher();
    return;
  }
}

function temp_sound_watcher() {
  self notify("temp_sound_watcher");
  self endon("temp_sound_watcher");
  self endon("death");
  var_0 = 5;
  var_1 = 25;
  jumpiffalse(istrue(self.hunting_player)) LOC_0000002f;
  var_0 = 3;
  var_1 = 5;

  for(;;) {
    wait randomintrange(var_0, var_1);
    var_2 = scripts\engine\utility::random(["dx_cbc_ru1_command_attack", "dx_cbc_ru1_contactclock_" + randomintrange(1, 13), "dx_cbc_ru1_inform_suppressed"]);

    if(soundexists(var_2)) {
      self playSound(var_2);
    }
  }
}

function soldier_player_listener() {
  level endon("game_ended");
  self notify("soldier_player_listener");
  self endon("soldier_player_listener");
  self endon("alerted");
  self endon("death");
  self endon("exit_stealth");
  soldier_player_listener_checker();

  if(getdvarint("scr_alerted_hunt_enable") == 1) {
    scripts\cp\cp_agent_patrol::enter_combat();
  } else {
    enter_combat();
  }

  wait 6.96;
  alert_all_nearby_enemies("near player");
}

function soldier_player_listener_checker() {
  level endon("game_ended");
  self notify("soldier_player_listener_checker");
  self endon("soldier_player_listener_checker");
  self endon("alerted");
  self endon("death");
  self endon("exit_stealth");

  for(;;) {
    foreach(var_1 in level.players) {
      if(isplayernearme(self, var_1)) {
        self notify("near_me");

        if(getdvarint("scr_alerted_hunt_enable") == 1) {
          scripts\cp\cp_agent_patrol::enter_combat();
        } else {
          enter_combat();
        }

        wait 0.05;

        if(trigger_temp_stealth_meter(2.6, undefined, "near_me", 1)) {
          wait 2.4;
          alert_all_nearby_enemies("near player");
        }
      } else if(ifcanseeplayer(self, var_1)) {
        self notify("can_see");
        wait 0.05;
        var_2 = scripts\engine\utility::distance_2d_squared(self.origin, var_1.origin);
        var_3 = var_2 / 160000;

        if(var_3 < 0.9) {
          var_3 = 0.9;
        }

        if(trigger_temp_stealth_meter(2.6, var_3, "can_see")) {
          if(isDefined(self.alert_icon)) {
            thread temp_stealthicon_changecolor(2.6, 2, "cp_stealth_icon_seen");
          }

          if(getdvarint("scr_alerted_hunt_enable") == 1) {
            scripts\cp\cp_agent_patrol::enter_combat();
          } else {
            enter_combat();
          }

          wait 2.4;
          alert_all_nearby_enemies("see player");
        }
      }

      wait 0.05;
    }

    wait 0.1;
  }
}

function isplayernearme(var_0, var_1) {
  if(!isDefined(var_1)) {
    return false;
  }

  if(istrue(var_1.ignoreme)) {
    return false;
  }

  var_2 = isPlayer(var_1);
  var_3 = distance(var_1.origin, var_0.origin);
  var_4 = istrue(var_0.damaged);

  if(var_1 getstance() == "crouch") {
    if(var_3 > 35) {
      return false;
    }
  } else if(var_3 > 96) {
    return false;
  }

  var_5 = sighttracepassed(var_0 getEye(), var_1 getEye(), 0, var_0, var_4);

  if(!var_5) {
    return false;
  }

  var_6 = scripts\engine\trace::create_solid_ai_contents(1);

  if(!scripts\engine\trace::ray_trace_passed(var_0 getEye(), var_1 getEye(), var_0, var_6)) {
    return false;
  }

  return true;
}

function ifcanseeplayer(var_0, var_1) {
  if(!isDefined(var_1)) {
    return false;
  }

  if(istrue(var_1.ignoreme)) {
    return false;
  }

  var_2 = isPlayer(var_1);
  var_3 = distance(var_1.origin, var_0.origin);
  var_4 = istrue(var_0.damaged);
  var_5 = 1;
  var_6 = var_1 getvelocity();
  var_7 = length(var_6);

  if(var_7 < 128) {
    var_5 = 0.75;
  } else if(var_7 < 200 || var_2 && var_1.perk_data["stealth_velocity_override"]) {
    var_5 = 1;
  } else {
    var_5 = 1.25;
  }

  if(var_3 > 1500 * var_5) {
    return false;
  }

  var_8 = var_0 cansee(var_1);

  if(var_8) {
    var_9 = cos(75);
    var_10 = scripts\engine\utility::within_fov(var_0 getEye(), var_0 getplayerangles(1), var_1.origin + (0, 0, 40), var_9);

    if(!var_10) {
      return false;
    }

    var_11 = sighttracepassed(var_0 getEye(), var_1 getEye(), 0, var_0, var_4);

    if(!var_11) {
      return false;
    }

    var_12 = scripts\engine\trace::create_solid_ai_contents(1);

    if(!scripts\engine\trace::ray_trace_passed(var_0 getEye(), var_1 getEye(), var_0, var_12)) {
      return false;
    }

    var_13 = scripts\engine\math::get_dot(var_0.origin, anglesToForward(var_0.angles), var_1.origin);
    var_5 = 1;

    if(var_13 >= 0.573576) {
      var_5 -= 0.34;
    }

    if(var_4) {
      var_5 -= 0.34;
    }

    var_14 = var_1 getstance();

    if(var_3 <= int(350 / var_5)) {
      if(var_14 == "prone") {
        return false;
      }

      return true;
    } else if(var_3 <= int(500 / var_5)) {
      if(var_14 == "prone") {
        return false;
      }

      return true;
    } else if(var_3 <= int(950 / var_5)) {
      if(var_14 == "prone" || var_14 == "crouch") {
        return false;
      }

      return true;
    }
  }

  return false;
}

function alert_all_nearby_enemies(var_0) {
  wait 0.1;
  thread temp_stealthicon_changecolor(2.6, 2, "cp_stealth_icon_notify");

  if(scripts\engine\utility::flag_exist("weapons_free") && !scripts\engine\utility::flag("weapons_free")) {
    scripts\engine\utility::flag_set("weapons_free");
    level notify("stop_weapon_fire_monitor");
  }

  var_1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_2 = 16386304;

  foreach(var_4 in var_1) {
    if(!isDefined(var_4) || var_4 == self) {
      continue;
    }

    if(!isDefined(var_4.agent_type) || isDefined(var_4.agent_type) && var_4.agent_type != "soldier_agent") {
      continue;
    }

    if(distance2dsquared(self.origin, var_4.origin) > var_2) {
      continue;
    }

    if(getdvarint("scr_alerted_hunt_enable") == 1) {
      var_4 scripts\cp\cp_agent_patrol::enter_combat();
    } else {
      enter_combat(var_4);
    }

    var_4 notify("alerted");
  }

  thread alert_debug_display(var_0);
}

function alert_debug_display(var_0) {
  wait 0.1;

  foreach(var_2 in level.players) {
    var_3 = " ";

    if(isDefined(level.debug_last_triggered)) {
      var_3 = level.debug_last_triggered.name;
    }

    var_2 iprintlnbold("^2 " + var_3 + "^3 Alerted the Guards! : " + var_0);
    wait 0.05;
  }
}

function are_enemies_nearby(var_0) {
  var_1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_2 = var_0 * var_0;

  foreach(var_4 in var_1) {
    if(!isDefined(var_4) || var_4 == self) {
      continue;
    }

    if(!isDefined(var_4.agent_type) || isDefined(var_4.agent_type) && var_4.agent_type != "soldier_agent") {
      continue;
    }

    var_5 = distance2dsquared(self.origin, var_4.origin);

    if(var_5 > var_2) {
      continue;
    }

    return true;
  }

  return false;
}

function init_fallback_triggers() {
  var_0 = getEntArray("trigger_fallback", "targetname");
  scripts\engine\utility::array_thread(var_0, &setup_fallback_trigger);
}

function setup_fallback_trigger() {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }

    [[level.fallback_trigger_func]](self, var_0);
    break;
  }

  wait 1;
  self delete();
}

function fallback_to_closest_spot(var_0) {
  self endon("death");
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
  var_2 = scripts\engine\utility::getclosest(self.origin, var_1);
  self.goalradius = 128;
  self setgoalpos(getclosestpointonnavmesh(var_2.origin));
  scripts\engine\utility::ref_143a5("goal", "goal_reached");
  self.goalradius = 1500;
}

function script_spawnsoldiers(var_0) {
  if(scripts\cp\cp_modular_spawning::isambientspawningpaused()) {
    return undefined;
  }

  if(!isarray(var_0)) {
    var_1 = _spawnsoldier(var_0);

    if(isDefined(var_1)) {
      thread respawn_on_death(var_1);
    }

    return var_1;
  }

  var_2 = [];
  var_3 = [];
  var_4 = 0;
  var_5 = var_1;

  foreach(var_7 in var_1) {
    if(!isDefined(var_7.script_label)) {
      continue;
    }

    if(var_7.script_label == "extra") {
      var_3 = var_7;
    }
  }

  switch (level.players.size) {
    case 1:
      var_1 = scripts\engine\utility::array_remove_array(var_1, var_3);
      break;
    case 2:
      var_3 = scripts\engine\utility::array_randomize(var_3);
      var_3 = [var_3[0]];

      if(var_3.size == 2) {
        var_3 = [var_3[0], var_3[1]];
      } else if(var_3.size > 2) {
        var_3 = [var_3[0], var_3[1], var_3[2]];
      }

      var_1 = scripts\engine\utility::array_combine(var_1, var_3);
      break;
    default:
      break;
  }

  foreach(var_7 in var_1) {
    var_1 = _spawnsoldier(var_7);

    if(!isDefined(var_1)) {
      continue;
    }

    thread respawn_on_death(var_1);
    var_2 = var_1;
    var_4++;

    if(var_4 % 4 == 0) {
      wait 0.05;
    }
  }

  if(var_2.size) {
    return var_2;
  }

  return undefined;
}

function _spawnsoldier(var_0, var_1, var_2, var_3) {
  if(getdvarint("scr_alerted_hunt_enable") == 1) {
    if(!isDefined(level.host_spawn_point)) {
      return undefined;
    }
  }

  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_4 = var_0 scripts\cp\cp_modular_spawning::spawn_ai();

  if(isDefined(var_4)) {
    var_0 notify("spawn_success", var_0);
    level notify("spawned_group_soldier", var_4);
    thread scripts\cp\cp_modular_spawning::run_ai_post_spawn_init(undefined, var_4, var_0, undefined, undefined, 1, undefined);
    return var_4;
  }
}

function debug_kill_soldier(var_0) {
  var_0 endon("death");
  var_0.nocorpse = 1;
  wait 3;
  var_0 dodamage(var_0.health + 1000, var_0.origin, var_0, var_0, "MOD_SUICIDE");
}

function debug_kill_soldier_after_anim(var_0) {
  var_0.nocorpse = 1;
  var_0 dodamage(var_0.health + 1000, var_0.origin, var_0, var_0, "MOD_SUICIDE");
}

function get_random_spec() {
  var_0 = ["soldier", "soldier", "soldier", "juggernaut", "armored", "armored", "armored", "armored_helmet", "armored_helmet"];
  return var_0;
}

function register_trigger_func(var_0, var_1) {
  if(!isDefined(level.trigger_spawn_func)) {
    level.trigger_spawn_func = [];
  }

  level.trigger_spawn_func[var_0] = var_1;
}

function run_trigger_func(var_0, var_1, var_2) {
  if(isDefined(level.trigger_spawn_func[var_0])) {
    level thread[[level.trigger_spawn_func[var_0]]](var_1, var_2);
    return;
  }
}

function get_ai_by_groupname(var_0) {
  var_1 = [];
  var_2 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  foreach(var_4 in var_2) {
    if(!var_4.isactive) {
      continue;
    }

    if(!isDefined(var_4.groupname)) {
      continue;
    }

    if(var_4.groupname != var_0) {
      continue;
    }

    var_1 = var_4;
  }

  return var_1;
}

function hunt_player_delayed() {
  self endon("death");
  var_0 = randomintrange(25, 60);
  var_1 = randomintrange(10, 15);
  hunt_player(var_0, var_1);
}

function hunt_player(var_0, var_1) {
  self endon("death");
  level endon("game_ended");

  if(isDefined(var_0)) {
    wait var_0;
  }

  while(!should_hunt_player()) {
    wait 1;
  }

  self.hunting_player = 1;
  self.no_fallback = 1;
  self.goalradius = 500;
  thread reduce_goalradius_over_time(var_1);

  for(;;) {
    if(!isDefined(self.enemy)) {
      wait 0.5;
      self.hunting_player = 0;
      continue;
    }

    self.hunting_player = 1;
    self setgoalentity(self.enemy, 3);
    wait 3;
  }
}

function should_hunt_player() {
  var_0 = 0;
  var_1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  foreach(var_3 in var_1) {
    if(isDefined(var_3.hunting_player)) {
      var_0++;
    }
  }

  if(var_0 >= level.players.size) {
    return false;
  }

  return true;
}

function reduce_goalradius_over_time(var_0) {
  self endon("death");

  if(!isDefined(var_0)) {
    var_0 = 2;
  }

  for(;;) {
    if(self.goalradius < 250) {
      self.goalradius = 250;
    } else {
      self.goalradius -= 100;

      if(self.goalradius < 50) {
        self.goalradius = 50;
      }
    }

    wait var_0;
  }
}

function wait_for_group_cleared(var_0) {
  for(;;) {
    var_1 = get_ai_by_groupname(var_0);

    if(!var_1.size) {
      break;
    }

    wait 1;
  }

  level.ambient_spawning_paused = 0;
}

#using_animtree("script_model");

function do_door_spawn(var_0, var_1) {
  if(istrue(var_1.inuse)) {
    return;
  }

  var_1.inuse = 1;
  var_2 = ["sdr_com_inter_rdoor_tac_ex_cqb_a", "sdr_com_inter_rdoor_tac_ex_cqb_b", "sdr_com_inter_rdoor_tac_ex_cqb_c"];
  var_1.og_angles = var_1.angles;

  foreach(var_4 in var_0) {
    thread door_spawn_entrance(var_4, var_4, var_2, var_1);
  }

  var_1.animname = "ai_spawn_door";
  var_1 useanimtree(#animtree);
  var_1 thread scripts\common\anim::anim_single_solo(var_1, "sdr_com_inter_rdoor_tac_ex_cqb_door");
  var_1 playSound("wood_door_kick");
  var_6 = var_0[var_0.size - 1] scripts\asm\asm::asm_lookupanimfromalias("animscripted", var_2[var_0.size - 1]);
  var_7 = var_0[var_0.size - 1] scripts\asm\asm::asm_getxanim("animscripted", var_6);
  wait getanimlength(var_7) + 3;
  var_1.inuse = 0;
}

function door_spawn_entrance(var_0, var_1, var_2, var_3) {
  var_0 endon("death");
  var_0.ignoreall = 1;
  var_0.scripted_mode = 1;
  scripts\asm\shared\mp\utility::burningpartlogic(var_1[var_3], var_2);
  var_0.ignoreall = 0;
  var_0.scripted_mode = 0;
  var_0 scripts\asm\shared\mp\utility::bunkercounteruav();
}

function kill_flood_spawner() {
  var_0 = scripts\engine\utility::getStructArray(self.target, "targetname");

  for(;;) {
    self waittill("trigger", var_1);

    if(!var_1 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    foreach(var_3 in var_0) {
      var_3.count = 0;
    }

    break;
  }

  wait 1;
  self delete();
}

function get_closest_unhunted_player() {
  var_0 = 1073741824;
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var_3)) {
      continue;
    }

    var_4 = distancesquared(self.origin, var_3.origin);

    if(var_3 scripts\cp_mp\utility\player_utility::_isalive() && var_4 < var_0) {
      var_1 = var_3;
      var_0 = var_4;
    }
  }

  return var_1;
}