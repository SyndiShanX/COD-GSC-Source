/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\killstreaks\_zombie_squadmate.gsc
*************************************************************/

init() {
  maps\mp\zombies\ranged_elite_soldier::init_ally();
  level.squadmateduration = 45;
  level.killstreakfuncs["zm_squadmate"] = ::tryusezombiesquadmate;
  level.agent_funcs["zm_squadmate"] = level.agent_funcs["zombie"];
  level.agent_funcs["zm_squadmate"]["think"] = ::squadmate_agent_think;
  level.agent_funcs["zm_squadmate"]["spawn"] = maps\mp\zombies\ranged_elite_soldier::onsoldierspawned;
  level.agent_funcs["zm_squadmate"]["onAIConnect"] = ::onsquadmateconnect;
  level.agent_funcs["zm_squadmate"]["on_damaged_finished"] = maps\mp\agents\_agents::agent_damage_finished;
  level.agent_funcs["zm_squadmate"]["on_killed"] = maps\mp\agents\_agents::on_agent_player_killed;
  level.shouldignoreplayerrevive = ::shouldnotreviveplayer;
}

tryusezombiesquadmate(var_0, var_1) {
  if(maps\mp\zombies\_util::arekillstreaksdisabled()) {
    return 0;
  }

  if(maps\mp\agents\_agent_utility::getnumactiveagents("zm_squadmate") >= 1 || isDefined(level.zm_squadmate_waiting_spawn)) {
    self iprintlnbold(&"ZOMBIE_SQUADMATE_AGENT_MAX");
    return 0;
  }

  if(isDefined(level.shouldignoreplayercallback)) {
    if([[level.shouldignoreplayercallback]](self)) {
      return 0;
    }
  }

  if(maps\mp\zombies\_util::isplayerteleporting(self)) {
    return 0;
  }

  level.zm_squadmate_waiting_spawn = 1;
  thread resetvarsondeath();
  self iprintlnbold(&"ZOMBIE_SQUADMATE_SQUADMATE_REQUEST");
  var_2 = 0;
  var_3 = [];
  var_4 = 0;

  while(!var_4) {
    var_5 = maps\mp\zombies\_util::getenemyagents();
    var_6 = maps\mp\zombies\_util::getnumagentswaitingtodeactivate();
    var_2 = var_5.size + var_6 - (maps\mp\zombies\zombies_spawn_manager::getmaxenemycount() - 4);
    var_3 = maps\mp\zombies\_util::getarrayofoffscreenagentstorecycle(var_5);

    if(var_3.size >= var_2) {
      var_4 = 1;
      continue;
    }

    wait 0.05;
  }

  if(var_2 > 0) {
    for(var_3 = common_scripts\utility::array_randomize(var_3); var_2 > 0; var_2--) {
      var_7 = var_3[var_2 - 1];
      var_7 suicide();
    }
  }

  level.maxenemycount = maps\mp\zombies\zombies_spawn_manager::getmaxenemycount() - 4;
  wait 0.5;
  var_8 = getvalidspawnnodesforsquadmate(4);

  if(var_8.size < 4) {
    level.zm_squadmate_waiting_spawn = undefined;
    level.maxenemycount = maps\mp\zombies\zombies_spawn_manager::getmaxenemycount();
    return 0;
  }

  var_9 = self.origin;
  var_10 = self.team;
  var_11 = [];

  while(var_11.size < 4) {
    var_12 = var_8[var_11.size];
    var_13 = var_12.origin;
    var_14 = vectortoangles(var_9 - var_12.origin);
    var_15 = maps\mp\agents\_agent_common::connectnewagent("zm_squadmate", var_10);
    var_15.overridebodymodel = "sentinel_udt_strike_body_a";
    var_15.overrideheadmodel = "sentinel_udt_strike_head_a";
    var_15 maps\mp\agents\_agents::spawn_agent_player(var_13, var_14, self);
    var_15 thread soldierhandlevo();
    var_11[var_11.size] = var_15;
    playFX(common_scripts\utility::getfx("npc_teleport_ally"), var_13, (1, 0, 0), (0, 0, 1));
    wait 0.05;
  }

  self notify("squadmate_succeeded");
  level thread watchsquaddeath(var_11);
  level.zm_squadmate_waiting_spawn = undefined;
  return 1;
}

resetvarsondeath() {
  level endon("game_ended");
  self endon("squadmate_succeeded");
  self waittill("death");
  level.zm_squadmate_waiting_spawn = undefined;
  level.maxenemycount = maps\mp\zombies\zombies_spawn_manager::getmaxenemycount();
}

watchsquaddeath(var_0) {
  level endon("game_ended");
  var_1 = 0;

  while(!var_1) {
    wait 0.05;
    var_1 = 1;

    foreach(var_3 in var_0) {
      if(isalive(var_3) && var_3.agent_type == "zm_squadmate") {
        var_1 = 0;
      }
    }
  }

  level.maxenemycount = maps\mp\zombies\zombies_spawn_manager::getmaxenemycount();
}

onsquadmateconnect() {
  self.agentname = &"ZOMBIE_SQUADMATE_SENTINEL";
}

destroyonownerdisconnect(var_0) {
  self endon("death");
  self endon("disconnect");
  var_0 common_scripts\utility::waittill_any("death", "disconnect");
  self notify("owner_disconnect");

  if(maps\mp\gametypes\_hostmigration::waittillhostmigrationdone()) {
    wait 0.05;
  }

  self suicide();
}

squadmate_agent_think() {
  self endon("death");
  self endon("disconnect");
  self endon("owner_disconnect");
  level endon("game_ended");
  maps\mp\_utility::giveperk("specialty_coldblooded", 0);
  childthread maps\mp\zombies\ranged_elite_soldier::ammorefillprimary();
  childthread maps\mp\zombies\ranged_elite_soldier::ammorefillsecondary();
  childthread maps\mp\bots\_bots::bot_think_revive();
  childthread stay_in_playspace();
  childthread monitorteleporttraversals();
  thread destroyonownerdisconnect(self.owner);
  self.onlydamagedbylargeenemies = 1;
  var_0 = 0;
  var_1 = 0;

  for(var_2 = 0; var_2 < level.squadmateduration; var_2 = var_2 + 0.05) {
    var_3 = [];

    if(isDefined(level.get_breached_zones_func)) {
      var_3 = [[level.get_breached_zones_func]]();
    }

    if(var_3.size > 0 && !maps\mp\bots\_bots_strategy::bot_has_tactical_goal("defuse")) {
      var_4 = undefined;

      foreach(var_6 in var_3) {
        if(isDefined(self.owner.currentzone) && self.owner.currentzone == var_6) {
          var_4 = var_6;
        }
      }

      var_8 = undefined;

      if(isDefined(var_4)) {
        foreach(var_10 in level.breachzones[var_4].defuseobjs) {
          if(var_10.visuals[0].enabled) {
            var_8 = var_10;
            break;
          }
        }
      }

      if(isDefined(var_8)) {
        var_12 = spawnStruct();
        var_12.object = var_8;
        var_12.should_abort = ::zone_no_longer_breached;
        var_12.action_thread = ::defuse_bomb;
        var_12.end_thread = ::stop_defusing;
        maps\mp\bots\_bots_strategy::bot_new_tactical_goal("defuse", var_8.curorigin, 50, var_12);
      }
    }

    if(float(self.owner.health) / self.owner.maxhealth < 0.5 && gettime() > var_1) {
      var_13 = getnodesinradiussorted(self.owner.origin, 256, 0);

      if(var_13.size >= 2) {
        self.defense_force_next_node_goal = var_13[1];
        self notify("defend_force_node_recalculation");
        var_1 = gettime() + 1000;
      }
    } else if(float(self.health) / self.maxhealth >= 0.6) {
      var_0 = 0;
    } else if(!var_0) {
      var_14 = maps\mp\bots\_bots_util::bot_find_node_to_guard_player(self.owner.origin, 350, 1);

      if(isDefined(var_14)) {
        self.defense_force_next_node_goal = var_14;
        self notify("defend_force_node_recalculation");
        var_0 = 1;
      }
    }

    if(!maps\mp\bots\_bots_util::bot_is_guarding_player(self.owner)) {
      var_15["override_goal_type"] = "critical";
      var_15["min_goal_time"] = 20;
      var_15["max_goal_time"] = 30;
      maps\mp\bots\_bots_strategy::bot_guard_player(self.owner, 350, var_15);
    }

    wait 0.05;
  }

  self suicide();
}

stay_in_playspace() {
  self endon("death");
  level endon("game_ended");
  self endon("owner_disconnect");

  for(;;) {
    if(isDefined(level.zone_data) && !maps\mp\zombies\_zombies_zone_manager::iszombieinanyzone(self)) {
      var_0 = self.owner getvalidspawnnodesforsquadmate(1);

      if(var_0.size > 0) {
        var_1 = var_0[0];
        playFX(common_scripts\utility::getfx("npc_teleport_ally"), self.origin, (1, 0, 0), (0, 0, 1));
        self setorigin(var_1.origin, 1);
        self setangles(var_1.angles);
        playFX(common_scripts\utility::getfx("npc_teleport_ally"), var_1.origin, (1, 0, 0), (0, 0, 1));
      }
    }

    wait 0.05;
  }
}

monitorteleporttraversals() {
  if(maps\mp\zombies\_util::getzombieslevelnum() < 4) {
    return;
  }
  for(;;) {
    var_0 = undefined;
    var_1 = self botgetnodesonpath();

    for(var_2 = 0; var_2 < var_1.size - 1; var_2++) {
      if(var_1[var_2].type == "Begin" && var_1[var_2 + 1].type == "End" && var_1[var_2].animscript == "climbup_shaft") {
        var_0 = var_1[var_2];
        break;
      }
    }

    if(isDefined(var_0) && distancesquared(self.origin, var_0.origin) < 256) {
      var_3 = getnode(var_0.target, "targetname");
      playFX(common_scripts\utility::getfx("npc_teleport_ally"), self.origin, (1, 0, 0), (0, 0, 1));
      self setorigin(var_3.origin, 1);
      self setangles(var_3.angles);
      playFX(common_scripts\utility::getfx("npc_teleport_ally"), var_3.origin, (1, 0, 0), (0, 0, 1));
    }

    wait 0.05;
  }
}

zone_no_longer_breached(var_0) {
  if(![[level.zone_is_breached_func]](var_0.object.zonename)) {
    return 1;
  }

  return 0;
}

defuse_bomb(var_0) {
  if(!var_0.object.visuals[0].enabled) {
    return;
  }
  if(isagent(self)) {
    common_scripts\utility::_enableusability();
    var_0.object.visuals[0] enableplayeruse(self);
    wait 0.05;
  }

  var_1 = self.team;
  thread soldierplayvo("defuse");
  maps\mp\bots\_bots_gametype_sd::sd_press_use(level.defusetime + 2, "bomb_defused", 1, 0);

  if(isagent(self)) {
    common_scripts\utility::_disableusability();

    if(isDefined(var_0.object)) {
      var_0.object.visuals[0] disableplayeruse(self);
    }
  }
}

stop_defusing(var_0) {
  self botclearscriptgoal();
}

getvalidspawnnodesforsquadmate(var_0) {
  var_1 = self.origin;

  if(isplayer(self)) {
    var_2 = self getnearestnode();
  } else {
    var_2 = getclosestnodeinsight(var_1);
  }

  if(!isDefined(var_2)) {
    var_3 = getnodesinradius(var_1, 350, 64, 128, "Path");
    var_2 = var_3[0];
  }

  var_4 = undefined;

  if(isDefined(level.zone_data)) {
    var_4 = maps\mp\zombies\_zombies_zone_manager::getlocationzone(var_1);

    if(!isDefined(var_4)) {
      var_4 = maps\mp\zombies\_zombies_zone_manager::getlocationzone(var_1 + (randomfloatrange(-1, 1), randomfloatrange(-1, 1), 0));
    }
  }

  var_5 = getnodesinradius(var_1, 400, 64, 128, "Path");

  if(var_5.size < var_0) {
    return [];
  }

  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    if(isDefined(level.zone_data) && maps\mp\zombies\_util::nodeisinspawncloset(var_5[var_6])) {
      var_5[var_6] = var_5[var_5.size - 1];
      var_5[var_5.size - 1] = undefined;
      var_6--;
    }
  }

  if(var_5.size < var_0) {
    return [];
  }

  var_7 = [];
  var_8 = nodegetsplitgroup(var_2);

  foreach(var_10 in var_5) {
    if(!var_10 doesnodeallowstance("stand")) {
      continue;
    }
    if(maps\mp\zombies\_util::is_true(var_10.nosoldierspawn)) {
      continue;
    }
    var_11 = nodegetsplitgroup(var_10);

    if(var_8 != var_11) {
      continue;
    }
    if(isDefined(level.zone_data) && var_4 != var_10.zombieszone) {
      continue;
    }
    var_7[var_7.size] = var_10;
  }

  if(var_7.size < var_0) {
    return [];
  }

  var_13 = [];
  var_14 = (0, 0, 64);

  for(var_15 = 0; var_15 < var_0; var_15++) {
    for(var_16 = common_scripts\utility::array_randomize(var_7); var_16.size > 5; var_16[var_16.size - 1] = undefined) {}

    var_17 = sortarraybyclosesttoobjects(var_16, var_13);

    for(var_6 = var_17.size - 1; var_6 >= 0; var_6--) {
      var_18 = var_17[var_6];

      if(!self aiphysicstracepassed(var_18.origin + var_14, var_18.origin, 24, 80, 1)) {
        var_18.nosoldierspawn = 1;
        continue;
      }

      var_13[var_13.size] = var_18;
      break;
    }
  }

  while(var_13.size < var_0) {
    var_13[var_13.size] = common_scripts\utility::random(var_13);
  }

  return var_13;
}

sortarraybyclosesttoobjects(var_0, var_1) {
  if(var_1.size == 0) {
    return var_0;
  }

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_0[var_2].temp_distance = 0;

    foreach(var_4 in var_1) {
      var_0[var_2].temp_distance = var_0[var_2].temp_distance + distance(var_0[var_2].origin, var_4.origin);
    }
  }

  var_6 = maps\mp\_utility::quicksort(var_0, ::comparedistancestoobjects);

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_0[var_2].temp_distance = undefined;
  }

  return var_6;
}

comparedistancestoobjects(var_0, var_1) {
  return var_0.temp_distance <= var_1.temp_distance;
}

soldierhandlevo() {
  self endon("death");
  wait 1;

  if(!isDefined(level.sentineldebouncevo)) {
    return;
  }
  var_0 = soldierplayvo("spawn");

  if(var_0) {
    level thread dosentinelconv(self);
  }

  thread soldierdochatter();

  for(;;) {
    var_0 = common_scripts\utility::waittill_any_return_no_endon_death("bot_reviving", "killed_enemy");

    if(var_0 == "bot_reviving") {
      soldierplayvo("revive");
      continue;
    }

    soldierplayvo("kill");
  }
}

soldierdochatter() {
  self endon("death");
  var_0 = 90000;

  for(;;) {
    wait(randomintrange(5, 10));
    var_1 = 0;
    var_2 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");

    foreach(var_4 in var_2) {
      if(var_4.team == level.playerteam) {
        continue;
      }
      var_5 = distancesquared(self.origin, var_4.origin);

      if(var_5 <= var_0) {
        soldierplayvo("chatter");
        break;
      }
    }
  }
}

soldierplayvo(var_0) {
  self endon("death");

  if(!isDefined(self.zmbvoxid)) {
    self.zmbvoxid = "sentinel";
  }

  if(!isDefined(level.sentineldebouncevo)) {
    return 0;
  }

  if(isDefined(level.sentineldebouncevo[var_0]) && level.sentineldebouncevo[var_0] > gettime()) {
    return 0;
  }

  if(maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", var_0)) {
    if(isDefined(level.sentineldebouncevo[var_0])) {
      level.sentineldebouncevo[var_0] = gettime() + 10000;
    }

    return 1;
  }

  return 0;
}

dosentinelconv(var_0) {
  if(maps\mp\zombies\_util::is_true(level.zmbplayedsentinelconv)) {
    return;
  }
  var_0 common_scripts\utility::waittill_notify_or_timeout("done_speaking", 3);
  var_1 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("pilot");

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = var_1 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "sentinel_conv");

  if(var_2) {
    level.zmbplayedsentinelconv = 1;
    var_1 common_scripts\utility::waittill_notify_or_timeout("done_speaking", 8);
  } else {
    return;
  }

  if(level.players.size > 1) {
    var_3 = var_0.owner;

    if(!isDefined(var_3) || isDefined(var_1) && var_3 == var_1) {
      var_4 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("guard");
      var_5 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("exec");
      var_6 = maps\mp\zombies\_zombies_audio::getcharacterbyprefix("it");
      var_3 = var_4;

      if(!isDefined(var_3) || isDefined(var_5) && common_scripts\utility::cointoss()) {
        var_3 = var_5;
      }

      if(!isDefined(var_3) || isDefined(var_6) && common_scripts\utility::cointoss()) {
        var_3 = var_6;
      }

      if(!isDefined(var_3) || isDefined(var_4) && common_scripts\utility::cointoss()) {
        var_3 = var_4;
      }
    }

    var_3 maps\mp\zombies\_zombies_audio::create_and_play_dialog("general", "sentinel_conv");
  }
}

shouldnotreviveplayer(var_0) {
  if(maps\mp\zombies\_util::getnumplayers() == 1) {
    if(isDefined(var_0.curprogress) && isDefined(var_0.usetime) && var_0.curprogress < var_0.usetime) {
      return 1;
    }
  }

  return 0;
}