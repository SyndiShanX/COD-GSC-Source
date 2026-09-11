/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_trigger_spawn.gsc
***********************************************/

function init_trigger_spawns() {
  scripts\engine\utility::flag_init("weapons_free");
  scripts\engine\utility::flag_wait("strike_init_done");
  var0 = getEntArray("trigger_spawn", "targetname");
  scripts\engine\utility::array_thread(var0, &setup_trigger_spawn);
  var0 = getEntArray("trigger_kill_floodspawner", "targetname");
  scripts\engine\utility::array_thread(var0, &kill_flood_spawner);
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

  var0 = [];
  var1 = undefined;

  if(isDefined(self.spawnpoints)) {
    foreach(var3 in self.spawnpoints) {
      if(!isDefined(var3.script_label)) {
        continue;
      }

      if(var3.script_label == "extra") {
        var0 = var3;
      }
    }

    var1 = self.spawnpoints;
  }

  scripts\engine\utility::ent_flag_clear("spawning_complete");

  for(;;) {
    self waittill("trigger", var5);

    if(scripts\cp\cp_modular_spawning::isambientspawningpaused()) {
      wait 1;
      continue;
    }

    if(!var5 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(getdvarint("scr_disable_trigger_spawn", 0) == 1) {
      break;
    }

    thread on_trigger_actions(level, self);

    if(!isDefined(var1)) {
      self notify("spawnpoints_not_found");
      return;
    }

    if(scripts\engine\utility::ent_flag_exist("spawning_paused") && scripts\engine\utility::ent_flag("spawning_paused")) {
      scripts\engine\utility::ent_flag_waitopen("spawning_paused");
    }

    switch (level.players.size) {
      case 1:
        var1 = scripts\engine\utility::array_remove_array(var1, var0);
        break;
      case 2:
        var0 = scripts\engine\utility::array_randomize(var0);
        var0 = [var0[0], var0[1]];
        var1 = scripts\engine\utility::array_combine(var1, var0);
        break;
      default:
        break;
    }

    var6 = 0;

    foreach(var3 in var1) {
      var8 = _spawnsoldier(var3);
      thread notify_trigger_on_death(var8, self);
      var3.lastspawntime = gettime();
      var8.killofftime = gettime() + 10000;

      if(isDefined(level.enemy_monitor_func) && !istrue(level.disable_enemy_monitor)) {
        var8 thread[[level.enemy_monitor_func]]("soldier");
      }

      thread respawn_on_death(var8);
      var6++;

      if(var6 % 4 == 0) {
        wait 0.05;
        LOC_0000020b:
      }
      LOC_0000020b:
    }

    break;
  }
}

function notify_trigger_on_death(var0, var1) {
  var0 endon("death");
  var0.guys_spawned++;
  var1 waittill("death");
  var0.guys_spawned--;

  if(var0.guys_spawned <= 0) {
    var0 scripts\engine\utility::ent_flag_set("spawning_complete");
    return;
  }
}

function respawn_on_death(var0) {
  level endon("game_ended");
  var0 endon("done_spawning");

  if(!isDefined(var0.count)) {
    return;
  }

  var0.count = int(var0.count);
  self endon("game_ended");
  self waittill("death");

  if(isDefined(var0.count) && var0.count > 0) {
    var0.count--;
    wait_to_spawn(var0);
    thread script_spawnsoldiers(var0);
    return;
  }
}

function wait_to_spawn(var0) {
  if(isDefined(var0.script_wait)) {
    var0.script_wait = int(var0.script_wait);
    wait var0.script_wait;
    return;
  }

  wait 0.1;
}

function on_trigger_actions(var0, var1) {
  if(isDefined(var0.script_label)) {
    level notify("trigger_" + var0.script_label);
  }

  if(isDefined(var0.script_function) && isDefined(level.trigger_spawn_func[var0.script_function])) {
    level thread[[level.trigger_spawn_func[var0.script_function]]](var0, var1);
  }

  if(isDefined(var0.script_flag)) {
    if(!scripts\engine\utility::flag_exist(var0.script_flag)) {
      scripts\engine\utility::flag_init(var0.script_flag);
    }

    scripts\engine\utility::flag_set(var0.script_flag);
    return;
  }
}

function spawn_enemy(var0, var1) {
  var2 = ["iw8_ar_akilo47_mp", "iw8_ar_mike4_mp", "iw8_sm_mpapa5_mp", "iw8_sm_papa90_mp", "iw8_sm_augolf_mp"];
  var3 = ["iw8_sn_kilo98_mp"];
  var4 = ["iw8_sh_dpapa12_mp"];
  var5 = ["iw8_lm_kilo121_mp"];
  var6 = ["iw8_la_rpapa7_mp"];
  var7 = undefined;

  if(!isDefined(var0.script_noteworthy)) {
    var0.script_noteworthy = "soldier";
  }

  var8 = undefined;
  var9 = undefined;

  if(!isDefined(var1)) {
    switch (var0.script_noteworthy) {
      case "rpg":
        var1 = scripts\engine\utility::random(var6);
        var8 = &set_default_rpg_values;
        break;
      case "shotgun":
        var1 = scripts\engine\utility::random(var4);
        var9 = &hunt_player;
        break;
      case "sniper":
        var1 = scripts\engine\utility::random(var3);
        var8 = &set_default_sniper_values;
        break;
      case "lmg":
        var1 = scripts\engine\utility::random(var5);
        var8 = &set_default_sniper_values;
        break;
      default:
        var1 = scripts\engine\utility::random(var2);
        break;
    }
  }

  var1 = scripts\cp\cp_weapon::getcompletenameforweapon(var1);
  var7 = spawn_enemy_soldier(var0, var1);

  if(isDefined(var7)) {
    var7.spawnpoint = var0;
    var7.spawnfunc = var8;
    var7.combatfunc = var9;
  }

  return var7;
}

function spawn_enemy_soldier(var0, var1) {
  var2 = "axis";

  if(isDefined(level.agentteamarray)) {
    if(isDefined(level.agentteamarray["soldier"])) {
      var2 = level.agentteamarray["soldier"];
    }
  }

  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  var3 = (0, var0.angles[1], 0);
  var4 = var0.origin;
  var5 = undefined;
  var6 = 0;
  var7 = "actor_enemy_cp_alq_desert_ar";

  if(var0.script_noteworthy == "juggernaut") {
    var7 = "actor_enemy_cp_rus_juggernaut";
  }

  for(;;) {
    var5 = scripts\mp\mp_agent::spawnnewagentaitype(var7, var4, var3);

    if(isDefined(var5)) {
      break;
    }

    var6++;

    if(var6 > 2) {
      return undefined;
    }

    wait 0.05;
  }

  var5.spawnpoint = var0;
  return var5;
}

function go_fight(var0) {
  self endon("death");
  self endon("dontfight");
  self.og_goalradius = self.goalradius;
  self.goalradius = 48;
  scripts\asm\asm_bb::bb_requestmovetype("combat");
  var1 = scripts\engine\utility::getStruct(var0.target, "targetname");
  self setgoalpos(getclosestpointonnavmesh(var1.origin));
  scripts\engine\utility::ref_143a5("goal_reached", "goal");

  if(getdvarint("scr_alerted_hunt_enable") == 1) {
    scripts\cp\cp_agent_patrol::enter_combat();
    return;
  }

  enter_combat();
}

function set_default_values(var0, var1) {
  if(isDefined(var0) && isDefined(var0.groupname)) {
    self.groupname = var0.groupname;
  }

  if(isDefined(var1.script_groupname)) {
    self.groupname = var1.script_groupname;
  }

  if(isDefined(self.unittype) && self.unittype == "juggernaut") {
    return;
  }

  self.health = 125;
  self.maxhealth = 125;
  self.og_health = 125;
  self.goalradius = 4096;
  self.og_goalradius = self.goalradius;
  self.spawnpoint = var1;
  self.sidearm = scripts\cp\cp_weapon::buildweapon("iw8_pi_golf21_mp", [], "none", "none", -1);
  scripts\common\utility::initweapon(self.primaryweapon);
  scripts\common\utility::initweapon(self.sidearm);
  thread delay_values();

  if(isDefined(self.spawnfunc)) {
    self thread[[self.spawnfunc]]();
  }

  if(istrue(level.use_temp_bc)) {
    self.next_dmg_sound = gettime();
    var2 = randomintrange(1, 7);
    self.painsound = "generic_pain_enemy_" + var2;
    self.deathsound = "generic_death_enemy_" + var2;
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

function target_patrol_path(var0) {
  self endon("death");
  self endon("alerted");
  var1 = scripts\engine\utility::getStruct(var0.target, "targetname");

  for(;;) {
    self setgoalpos(getclosestpointonnavmesh(var1.origin));
    scripts\engine\utility::ref_143a5("goal_reached", "goal");

    if(isDefined(var1.target)) {
      var2 = scripts\engine\utility::getStruct(var1.target, "targetname");
      var1 = var2;
      continue;
    }

    break;
  }
}

function getscoredpatrolpoint(var0, var1, var2) {
  if(isDefined(var2)) {
    var2 = [var2];
  } else {
    var2 = [];
  }

  foreach(var4 in var1) {
    if(istrue(var4.cooldown)) {
      var5 = 999;
    } else if(istrue(var4.halfcooldown)) {
      var5 = 500;
    } else {
      var5 = 99;
    }

    var6 = scripts\engine\utility::get_array_of_closest(var0.origin, scripts\cp\cp_agent_utils::getactiveagentsoftype("soldier_agent"), var2, 5, 512);

    if(var6.size >= 1) {
      var5 *= 100 * var6.size;
    }

    var5 = clamp(var5, 0, 999);
    var4.patrolscore = int(var5);
  }

  var8 = scripts\cp\utility::quicksort(var1);

  foreach(var4 in var8) {
    var4.patrolscore = 0;
  }

  return var8[0];
}

function setcooldown(var0, var1) {
  level endon("game_ended");
  var2 = 0.5 * var1;
  var0.cooldown = 1;
  wait var2;
  var0.cooldown = undefined;
  var0.halfcooldown = 1;
  wait var2;
  var0.halfcooldown = undefined;
}

function patrol_path(var0, var1) {
  self endon("death");
  self endon("alerted");
  var2 = scripts\engine\utility::getStructArray("soldier_patrol", "script_noteworthy");
  var3 = scripts\engine\utility::get_array_of_closest(var0.origin, scripts\engine\utility::getStructArray("soldier_patrol", "script_noteworthy"), [var0], 15);

  if(var3.size < 1) {
    var2 = scripts\engine\utility::getStructArray(var0.targetname, "targetname");
    var3 = scripts\engine\utility::get_array_of_closest(var0.origin, scripts\engine\utility::getStructArray(var0.targetname, "targetname"), [var0], 15);
  }

  var4 = scripts\engine\utility::getclosest(var0.origin, var3, 256);

  if(isDefined(var4)) {
    var5 = var4;
    goto LOC_000000ab;
  }

  for(var5 = getscoredpatrolpoint(self, var4);; var5 = getscoredpatrolpoint(self, var4, var5)) {
    thread setcooldown(var5, var5);
    self setgoalpos(getclosestpointonnavmesh(var5.origin));
    scripts\engine\utility::ref_143ba(15, "goal_reached", "goal");

    if(scripts\engine\utility::cointoss()) {
      wait randomfloatrange(2.5, 5);
    }

    if(isDefined(var5.target)) {
      var6 = scripts\engine\utility::getStructArray(var5.target, "targetname")[0];

      if(isDefined(var6)) {
        var5 = var6;
        continue;
      }

      continue;
    }

    if(istrue(var2)) {
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
  var0 = "";
  var1 = 0;
  var2 = scripts\engine\utility::waittill_any_ents_return(self, "bulletwhizby", self, "door_bashopen");

  if(var2 == "bulletwhizby") {
    var0 = "shots heard";
    var1 = 0;
  } else if(var2 == "door_bashopen") {
    var0 = "door heard";
    var1 = 0;
  }

  if(trigger_temp_stealth_meter(5.1, undefined, var2, var1)) {
    if(getdvarint("scr_alerted_hunt_enable") == 1) {
      scripts\cp\cp_agent_patrol::enter_combat();
    } else {
      enter_combat();
    }

    wait 2.4;
    alert_all_nearby_enemies(var0);
    return;
  }

  thread watch_for_bulletwhizby();
}

function watch_for_weaponsfire() {
  self endon("death");
  self endon("alerted");

  for(;;) {
    level waittill("weapon_fired", var0, var1, var2);
    var3 = 0;

    foreach(var5 in var1.attachments) {
      if(issubstr(var5, "silencer")) {
        var3 = 1;
      }
    }

    if(var3) {
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

function trigger_temp_stealth_meter(var0, var1, var2, var3) {
  if(scripts\engine\utility::flag_exist("weapons_free") && scripts\engine\utility::flag("weapons_free")) {
    return false;
  }

  self endon("alerted");

  if(!isDefined(level.is_stealthy)) {
    return true;
  }

  if(!isDefined(var1)) {
    var1 = 0.25;
  }

  if(!istrue(self.has_alert_icon)) {
    self.has_alert_icon = 1;
    wait 0.05;
    var4 = deleteheadicon(self);
    setheadiconfriendlyimage(var4, "cp_stealth_icon_sus_sv");
    setheadicondrawthroughgeo(var4, 1);
    setheadiconsnaptoedges(var4, 29000);
    setheadiconmaxdistance(var4, 425);
    addclienttoheadiconmask(var4, 25);
    self.alert_icon = var4;
    thread temp_stealthicon_initiate(10);
    thread temp_stealth_meter_delete_on_death(var4);
    var5 = undefined;

    if(!istrue(var3)) {
      wait var1;

      if(var2 == "can_see") {
        foreach(var7 in level.players) {
          if(ifcanseeplayer(self, var7)) {
            var5 = "can_see";
            thread temp_player_debug_whotriggered(var7);
          }

          wait 0.05;
        }
      } else {
        var5 = "default";
      }

      if(isDefined(var5) && var5 != "can_see") {
        var5 = scripts\engine\utility::ref_143be(var0, var2, "can_see", "death", "near_me", "damage", "hear_turret");
      }
    }

    if(isDefined(var5) && (var5 == var2 || var5 == "can_see" || var5 == "near_me") || istrue(var3)) {
      thread temp_stealthicon_changecolor(var0, 2, "cp_stealth_icon_seen");
      return true;
    } else {
      thread detected_temp_stealth_meter(self.alert_icon, 0.01);
      return false;
    }
  }

  return false;
}

function temp_stealthicon_initiate(var0) {
  self endon("icon_deleted");
  self endon("icon_cancel_delete");
  self endon("alerted");
  self endon("death");

  if(istrue(self.has_alert_icon) || isDefined(self.alert_icon) && self.alert_icon == 0) {
    if(isalive(self)) {
      var1 = var0;
      var2 = 0;

      while(var1 > 0) {
        var1--;
        var2 = !var2;

        if(var2 == 1) {
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

function temp_stealthicon_changecolor(var0, var1, var2) {
  self endon("icon_deleted");
  self endon("alerted");
  self endon("death");
  var3 = 1;

  if(isDefined(var1)) {
    var3 = var1;
  }

  for(var4 = 0; var4 < var3; var4++) {
    if(istrue(self.has_alert_icon) || isDefined(self.alert_icon) && self.alert_icon == 0) {
      if(isalive(self)) {
        self notify("icon_cancel_delete");
        setheadiconfriendlyimage(self.alert_icon, var2);
        thread detected_temp_stealth_meter(self.alert_icon, var0 * 5.5);
      }
    }

    wait 0.05;
  }
}

function detected_temp_stealth_meter(var0, var1) {
  self notify("icon_cancel_delete");
  self endon("icon_deleted");
  scripts\engine\utility::ref_143ba(var1, "death", "alerted");
  wait 0.5;
  thread detected_temp_stealth_meter_delete(var0);
}

function detected_temp_stealth_meter_delete(var0) {
  self notify("icon_cancel_delete");
  self endon("icon_deleted");
  self endon("icon_cancel_delete");

  if(istrue(self.has_alert_icon) && istrue(self.alert_icon) && istrue(var0)) {
    self.has_alert_icon = 0;
    setheadiconimage(var0);
    var0 = undefined;
    self notify("icon_deleted");
    return;
  }

  if(istrue(self.has_alert_icon)) {
    self.has_alert_icon = 0;
    setheadiconimage(var0);
    var0 = undefined;
    self notify("icon_deleted");
    return;
  }
}

function temp_stealth_meter_delete_on_death(var0) {
  self endon("icon_deleted");
  self waittill("death");
  self notify("icon_cancel_delete");
  var1 = 0.45;

  if(scripts\engine\utility::flag_exist("weapons_free") && scripts\engine\utility::flag("weapons_free")) {
    var1 *= 5.5;
  }

  wait var1;

  if(isDefined(var0)) {
    self.has_alert_icon = 0;
    setheadiconimage(var0);
    var0 = undefined;
    self notify("icon_deleted");
    return;
  }
}

function temp_player_debug_whotriggered(var0) {
  if(!scripts\engine\utility::flag_exist("weapons_free")) {
    return;
  }

  self notify("new_last_triggered");
  self endon("new_last_triggered");
  var1 = undefined;

  for(;;) {
    if(!scripts\engine\utility::flag("weapons_free")) {
      var1 = var0;
    } else {
      level.debug_last_triggered = var1;
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
    var0 = getEnt(self.spawnpoint.script_goalvolume, "script_noteworthy");

    if(!isDefined(var0)) {
      var0 = getEnt(self.spawnpoint.script_goalvolume, "targetname");
    }

    if(isDefined(var0)) {
      self setgoalvolumeauto(var0);
    }
  }

  foreach(var2 in level.players) {
    if(!var2 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    self getenemyinfo(var2);
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
  var0 = 5;
  var1 = 25;
  jumpiffalse(istrue(self.hunting_player)) LOC_0000002f;
  var0 = 3;
  var1 = 5;

  for(;;) {
    wait randomintrange(var0, var1);
    var2 = scripts\engine\utility::random(["dx_cbc_ru1_command_attack", "dx_cbc_ru1_contactclock_" + randomintrange(1, 13), "dx_cbc_ru1_inform_suppressed"]);

    if(soundexists(var2)) {
      self playSound(var2);
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
    foreach(var1 in level.players) {
      if(isplayernearme(self, var1)) {
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
      } else if(ifcanseeplayer(self, var1)) {
        self notify("can_see");
        wait 0.05;
        var2 = scripts\engine\utility::distance_2d_squared(self.origin, var1.origin);
        var3 = var2 / 160000;

        if(var3 < 0.9) {
          var3 = 0.9;
        }

        if(trigger_temp_stealth_meter(2.6, var3, "can_see")) {
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

function isplayernearme(var0, var1) {
  if(!isDefined(var1)) {
    return false;
  }

  if(istrue(var1.ignoreme)) {
    return false;
  }

  var2 = isPlayer(var1);
  var3 = distance(var1.origin, var0.origin);
  var4 = istrue(var0.damaged);

  if(var1 getstance() == "crouch") {
    if(var3 > 35) {
      return false;
    }
  } else if(var3 > 96) {
    return false;
  }

  var5 = sighttracepassed(var0 getEye(), var1 getEye(), 0, var0, var4);

  if(!var5) {
    return false;
  }

  var6 = scripts\engine\trace::create_solid_ai_contents(1);

  if(!scripts\engine\trace::ray_trace_passed(var0 getEye(), var1 getEye(), var0, var6)) {
    return false;
  }

  return true;
}

function ifcanseeplayer(var0, var1) {
  if(!isDefined(var1)) {
    return false;
  }

  if(istrue(var1.ignoreme)) {
    return false;
  }

  var2 = isPlayer(var1);
  var3 = distance(var1.origin, var0.origin);
  var4 = istrue(var0.damaged);
  var5 = 1;
  var6 = var1 getvelocity();
  var7 = length(var6);

  if(var7 < 128) {
    var5 = 0.75;
  } else if(var7 < 200 || var2 && var1.perk_data["stealth_velocity_override"]) {
    var5 = 1;
  } else {
    var5 = 1.25;
  }

  if(var3 > 1500 * var5) {
    return false;
  }

  var8 = var0 cansee(var1);

  if(var8) {
    var9 = cos(75);
    var10 = scripts\engine\utility::within_fov(var0 getEye(), var0 getplayerangles(1), var1.origin + (0, 0, 40), var9);

    if(!var10) {
      return false;
    }

    var11 = sighttracepassed(var0 getEye(), var1 getEye(), 0, var0, var4);

    if(!var11) {
      return false;
    }

    var12 = scripts\engine\trace::create_solid_ai_contents(1);

    if(!scripts\engine\trace::ray_trace_passed(var0 getEye(), var1 getEye(), var0, var12)) {
      return false;
    }

    var13 = scripts\engine\math::get_dot(var0.origin, anglesToForward(var0.angles), var1.origin);
    var5 = 1;

    if(var13 >= 0.573576) {
      var5 -= 0.34;
    }

    if(var4) {
      var5 -= 0.34;
    }

    var14 = var1 getstance();

    if(var3 <= int(350 / var5)) {
      if(var14 == "prone") {
        return false;
      }

      return true;
    } else if(var3 <= int(500 / var5)) {
      if(var14 == "prone") {
        return false;
      }

      return true;
    } else if(var3 <= int(950 / var5)) {
      if(var14 == "prone" || var14 == "crouch") {
        return false;
      }

      return true;
    }
  }

  return false;
}

function alert_all_nearby_enemies(var0) {
  wait 0.1;
  thread temp_stealthicon_changecolor(2.6, 2, "cp_stealth_icon_notify");

  if(scripts\engine\utility::flag_exist("weapons_free") && !scripts\engine\utility::flag("weapons_free")) {
    scripts\engine\utility::flag_set("weapons_free");
    level notify("stop_weapon_fire_monitor");
  }

  var1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var2 = 16386304;

  foreach(var4 in var1) {
    if(!isDefined(var4) || var4 == self) {
      continue;
    }

    if(!isDefined(var4.agent_type) || isDefined(var4.agent_type) && var4.agent_type != "soldier_agent") {
      continue;
    }

    if(distance2dsquared(self.origin, var4.origin) > var2) {
      continue;
    }

    if(getdvarint("scr_alerted_hunt_enable") == 1) {
      var4 scripts\cp\cp_agent_patrol::enter_combat();
    } else {
      enter_combat(var4);
    }

    var4 notify("alerted");
  }

  thread alert_debug_display(var0);
}

function alert_debug_display(var0) {
  wait 0.1;

  foreach(var2 in level.players) {
    var3 = " ";

    if(isDefined(level.debug_last_triggered)) {
      var3 = level.debug_last_triggered.name;
    }

    var2 iprintlnbold("^2 " + var3 + "^3 Alerted the Guards! : " + var0);
    wait 0.05;
  }
}

function are_enemies_nearby(var0) {
  var1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var2 = var0 * var0;

  foreach(var4 in var1) {
    if(!isDefined(var4) || var4 == self) {
      continue;
    }

    if(!isDefined(var4.agent_type) || isDefined(var4.agent_type) && var4.agent_type != "soldier_agent") {
      continue;
    }

    var5 = distance2dsquared(self.origin, var4.origin);

    if(var5 > var2) {
      continue;
    }

    return true;
  }

  return false;
}

function init_fallback_triggers() {
  var0 = getEntArray("trigger_fallback", "targetname");
  scripts\engine\utility::array_thread(var0, &setup_fallback_trigger);
}

function setup_fallback_trigger() {
  self endon("death");

  for(;;) {
    self waittill("trigger", var0);

    if(!isPlayer(var0)) {
      continue;
    }

    [[level.fallback_trigger_func]](self, var0);
    break;
  }

  wait 1;
  self delete();
}

function fallback_to_closest_spot(var0) {
  self endon("death");
  var1 = scripts\engine\utility::getStructArray(var0.target, "targetname");
  var2 = scripts\engine\utility::getclosest(self.origin, var1);
  self.goalradius = 128;
  self setgoalpos(getclosestpointonnavmesh(var2.origin));
  scripts\engine\utility::ref_143a5("goal", "goal_reached");
  self.goalradius = 1500;
}

function script_spawnsoldiers(var0) {
  if(scripts\cp\cp_modular_spawning::isambientspawningpaused()) {
    return undefined;
  }

  if(!isarray(var0)) {
    var1 = _spawnsoldier(var0);

    if(isDefined(var1)) {
      thread respawn_on_death(var1);
    }

    return var1;
  }

  var2 = [];
  var3 = [];
  var4 = 0;
  var5 = var1;

  foreach(var7 in var1) {
    if(!isDefined(var7.script_label)) {
      continue;
    }

    if(var7.script_label == "extra") {
      var3 = var7;
    }
  }

  switch (level.players.size) {
    case 1:
      var1 = scripts\engine\utility::array_remove_array(var1, var3);
      break;
    case 2:
      var3 = scripts\engine\utility::array_randomize(var3);
      var3 = [var3[0]];

      if(var3.size == 2) {
        var3 = [var3[0], var3[1]];
      } else if(var3.size > 2) {
        var3 = [var3[0], var3[1], var3[2]];
      }

      var1 = scripts\engine\utility::array_combine(var1, var3);
      break;
    default:
      break;
  }

  foreach(var7 in var1) {
    var1 = _spawnsoldier(var7);

    if(!isDefined(var1)) {
      continue;
    }

    thread respawn_on_death(var1);
    var2 = var1;
    var4++;

    if(var4 % 4 == 0) {
      wait 0.05;
    }
  }

  if(var2.size) {
    return var2;
  }

  return undefined;
}

function _spawnsoldier(var0, var1, var2, var3) {
  if(getdvarint("scr_alerted_hunt_enable") == 1) {
    if(!isDefined(level.host_spawn_point)) {
      return undefined;
    }
  }

  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  var4 = var0 scripts\cp\cp_modular_spawning::spawn_ai();

  if(isDefined(var4)) {
    var0 notify("spawn_success", var0);
    level notify("spawned_group_soldier", var4);
    thread scripts\cp\cp_modular_spawning::run_ai_post_spawn_init(undefined, var4, var0, undefined, undefined, 1, undefined);
    return var4;
  }
}

function debug_kill_soldier(var0) {
  var0 endon("death");
  var0.nocorpse = 1;
  wait 3;
  var0 dodamage(var0.health + 1000, var0.origin, var0, var0, "MOD_SUICIDE");
}

function debug_kill_soldier_after_anim(var0) {
  var0.nocorpse = 1;
  var0 dodamage(var0.health + 1000, var0.origin, var0, var0, "MOD_SUICIDE");
}

function get_random_spec() {
  var0 = ["soldier", "soldier", "soldier", "juggernaut", "armored", "armored", "armored", "armored_helmet", "armored_helmet"];
  return var0;
}

function register_trigger_func(var0, var1) {
  if(!isDefined(level.trigger_spawn_func)) {
    level.trigger_spawn_func = [];
  }

  level.trigger_spawn_func[var0] = var1;
}

function run_trigger_func(var0, var1, var2) {
  if(isDefined(level.trigger_spawn_func[var0])) {
    level thread[[level.trigger_spawn_func[var0]]](var1, var2);
    return;
  }
}

function get_ai_by_groupname(var0) {
  var1 = [];
  var2 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  foreach(var4 in var2) {
    if(!var4.isactive) {
      continue;
    }

    if(!isDefined(var4.groupname)) {
      continue;
    }

    if(var4.groupname != var0) {
      continue;
    }

    var1 = var4;
  }

  return var1;
}

function hunt_player_delayed() {
  self endon("death");
  var0 = randomintrange(25, 60);
  var1 = randomintrange(10, 15);
  hunt_player(var0, var1);
}

function hunt_player(var0, var1) {
  self endon("death");
  level endon("game_ended");

  if(isDefined(var0)) {
    wait var0;
  }

  while(!should_hunt_player()) {
    wait 1;
  }

  self.hunting_player = 1;
  self.no_fallback = 1;
  self.goalradius = 500;
  thread reduce_goalradius_over_time(var1);

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
  var0 = 0;
  var1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

  foreach(var3 in var1) {
    if(isDefined(var3.hunting_player)) {
      var0++;
    }
  }

  if(var0 >= level.players.size) {
    return false;
  }

  return true;
}

function reduce_goalradius_over_time(var0) {
  self endon("death");

  if(!isDefined(var0)) {
    var0 = 2;
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

    wait var0;
  }
}

function wait_for_group_cleared(var0) {
  for(;;) {
    var1 = get_ai_by_groupname(var0);

    if(!var1.size) {
      break;
    }

    wait 1;
  }

  level.ambient_spawning_paused = 0;
}

#using_animtree("script_model");

function do_door_spawn(var0, var1) {
  if(istrue(var1.inuse)) {
    return;
  }

  var1.inuse = 1;
  var2 = ["sdr_com_inter_rdoor_tac_ex_cqb_a", "sdr_com_inter_rdoor_tac_ex_cqb_b", "sdr_com_inter_rdoor_tac_ex_cqb_c"];
  var1.og_angles = var1.angles;

  foreach(var4 in var0) {
    thread door_spawn_entrance(var4, var4, var2, var1);
  }

  var1.animname = "ai_spawn_door";
  var1 useanimtree(#animtree);
  var1 thread scripts\common\anim::anim_single_solo(var1, "sdr_com_inter_rdoor_tac_ex_cqb_door");
  var1 playSound("wood_door_kick");
  var6 = var0[var0.size - 1] scripts\asm\asm::asm_lookupanimfromalias("animscripted", var2[var0.size - 1]);
  var7 = var0[var0.size - 1] scripts\asm\asm::asm_getxanim("animscripted", var6);
  wait getanimlength(var7) + 3;
  var1.inuse = 0;
}

function door_spawn_entrance(var0, var1, var2, var3) {
  var0 endon("death");
  var0.ignoreall = 1;
  var0.scripted_mode = 1;
  scripts\asm\shared\mp\utility::burningpartlogic(var1[var3], var2);
  var0.ignoreall = 0;
  var0.scripted_mode = 0;
  var0 scripts\asm\shared\mp\utility::bunkercounteruav();
}

function kill_flood_spawner() {
  var0 = scripts\engine\utility::getStructArray(self.target, "targetname");

  for(;;) {
    self waittill("trigger", var1);

    if(!var1 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    foreach(var3 in var0) {
      var3.count = 0;
    }

    break;
  }

  wait 1;
  self delete();
}

function get_closest_unhunted_player() {
  var0 = 1073741824;
  var1 = undefined;

  foreach(var3 in level.players) {
    if(scripts\cp\cp_laststand::player_in_laststand(var3)) {
      continue;
    }

    var4 = distancesquared(self.origin, var3.origin);

    if(var3 scripts\cp_mp\utility\player_utility::_isalive() && var4 < var0) {
      var1 = var3;
      var0 = var4;
    }
  }

  return var1;
}