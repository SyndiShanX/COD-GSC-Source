/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\control.gsc
***********************************************/

#using script_1435f3c9fc699e04;
#using script_335d0650ed05d36d;
#using script_3d703ef87a841fe4;
#using script_3e196d275a6fb180;
#using script_44b0b8420eabacad;
#using script_7a8059ca02b7b09e;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\demo_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\popups_shared;
#using scripts\core_common\potm_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\bb;
#using scripts\mp_common\challenges;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_audio;
#using scripts\mp_common\gametypes\globallogic_defaults;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_spawn;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\gametypes\hud_message;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\gametypes\round;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\spawnbeacon;
#using scripts\mp_common\userspawnselection;
#using scripts\mp_common\util;
#namespace mission_koth;

function event_handler[gametype_init] main(eventstruct) {
  globallogic::init();
  util::registerscorelimit(0, 5000);
  game.objective_gained_sound = "mpl_control_captured_by_friendly";
  game.objective_lost_sound = "mpl_control_captured_by_enemy";

  if(!isDefined(game.var_629fe99f)) {
    game.var_629fe99f = [];
  }

  level.onstartgametype = &on_start_gametype;
  level.onspawnplayer = &on_spawn_player;
  player::function_cf3aa03d(&on_player_killed);
  player::function_3c5cc656(&function_610d3790);
  level.ontimelimit = &on_time_limit;
  level.onendgame = &on_end_game;
  level.ononeleftevent = &ononeleftevent;
  level.onendround = &on_end_round;
  level.gettimelimit = &gettimelimit;
  level.ondeadevent = &on_dead_event;
  level.doprematch = 1;
  level.warstarttime = 0;
  level.var_f5a73a96 = 1;
  level.takelivesondeath = 1;
  level.b_allow_vehicle_proximity_pickup = 1;
  level.zonespawntime = getgametypesetting(#"objectivespawntime");
  level.capturetime = getgametypesetting(#"capturetime");
  level.destroytime = getgametypesetting(#"destroytime");
  level.timepauseswheninzone = getgametypesetting(#"timepauseswheninzone");
  level.dela = getgametypesetting(#"delayplayer");
  level.scoreperplayer = getgametypesetting(#"scoreperplayer");
  level.neutralzone = getgametypesetting(#"neutralzone");
  level.decaycapturedzones = getgametypesetting(#"decaycapturedzones");
  level.capdecay = getgametypesetting(#"capdecay");
  level.extratime = getgametypesetting(#"extratime");
  level.extrasegmenttime = getgametypesetting(#"extrasegmenttime");
  level.playercapturelpm = getgametypesetting(#"maxplayereventsperminute");
  level.autodecaytime = isDefined(getgametypesetting(#"autodecaytime")) ? getgametypesetting(#"autodecaytime") : undefined;
  level.overtimebestteam = getgametypesetting(#"overtimebestteam");
  level.timerpaused = 0;
  level.zonepauseinfo = [];
  level.var_b9d36d8e = [];
  level.var_46ff851e = 0;
  level.numzonesoccupied = 0;
  level.var_1cb1e802 = [];
  level.flagcapturerateincrease = getgametypesetting(#"flagcapturerateincrease");
  level.bonuslivesforcapturingzone = isDefined(getgametypesetting(#"bonuslivesforcapturingzone")) ? getgametypesetting(#"bonuslivesforcapturingzone") : 0;
  register_clientfields();
  callback::on_connect(&on_player_connect);
  level.audiocues = [];
  level.var_10c0e6bb = &function_ea86257d;
  level.var_ce802423 = 1;
  level.var_a8b23f5a = 1;
  level.mission_bundle = getscriptbundle("mission_settings_control");
  game.strings[#"hash_bab7f2001813aa7"] = # "hash_15294f07ee519376";
  game.strings[#"hash_5db475ae2d5164e1"] = # "hash_3a9b595d0bf81f13";
  hud_message::function_36419c2(1, game.strings[#"hash_bab7f2001813aa7"], game.strings[#"hash_5db475ae2d5164e1"]);
  level.audioplaybackthrottle = int(level.mission_bundle.msaudioplaybackthrottle);

  if(!isDefined(level.audioplaybackthrottle)) {
    level.audioplaybackthrottle = 5000;
  }

  level.var_1aef539f = &function_a800815;
  level.var_d3a438fb = &function_d3a438fb;
}

function function_de560341() {
  spawning::function_c40af6fa();
  spawning::addsupportedspawnpointtype("control");
  spawning::function_32b97d1b(&spawning::function_90dee50d);
  spawning::function_adbbb58a(&spawning::function_c24e290c);
  spawning::addspawns();
  level.var_f401aaf9 = [];
  level.var_f401aaf9[#"control_attack_add_1"][#"list"] = "spl1";
  level.var_f401aaf9[#"control_attack_add_1"][#"team"] = game.attackers;
  level.var_f401aaf9[#"control_defend_add_1"][#"list"] = "spl2";
  level.var_f401aaf9[#"control_defend_add_1"][#"team"] = game.defenders;
  level.var_f401aaf9[#"control_attack_remove_0"][#"list"] = "spl3";
  level.var_f401aaf9[#"control_attack_remove_0"][#"team"] = game.attackers;
  level.var_f401aaf9[#"control_defend_remove_0"][#"list"] = "spl4";
  level.var_f401aaf9[#"control_defend_remove_0"][#"team"] = game.defenders;
  level.var_f401aaf9[#"control_attack_add_0"][#"list"] = "spl5";
  level.var_f401aaf9[#"control_attack_add_0"][#"team"] = game.attackers;
  level.var_f401aaf9[#"control_defend_add_0"][#"list"] = "spl6";
  level.var_f401aaf9[#"control_defend_add_0"][#"team"] = game.defenders;
  level.var_f401aaf9[#"control_attack_remove_1"][#"list"] = "spl7";
  level.var_f401aaf9[#"control_attack_remove_1"][#"team"] = game.attackers;
  level.var_f401aaf9[#"control_defend_remove_1"][#"list"] = "spl8";
  level.var_f401aaf9[#"control_defend_remove_1"][#"team"] = game.defenders;
  var_273a84a9 = [];
  keys = getarraykeys(level.var_f401aaf9);
  var_7ed0dafe = spawning::function_d400d613(#"mp_spawn_point", keys);

  if(isDefined(var_7ed0dafe)) {
    foreach(key in keys) {
      if(!isDefined(var_7ed0dafe[key])) {
        continue;
      }

      list = level.var_f401aaf9[key][#"list"];
      team = level.var_f401aaf9[key][#"team"];
      addspawnpoints(team, var_7ed0dafe[key], list);
      spawning::add_default_spawnlist(list);
    }
  }
}

function function_7e5cbc97(flag) {
  list = level.var_f401aaf9[flag][#"list"];
  mask = util::getteammask(level.var_f401aaf9[flag][#"team"]);
  enablespawnpointlist(list, mask);
}

function updatespawns() {
  var_66eb1393 = [];

  if(isDefined(level.zones)) {
    foreach(zone in level.zones) {
      if(!isDefined(zone.gameobject)) {
        continue;
      }

      var_66eb1393[zone.zone_index] = isDefined(zone.gameobject.iscaptured) && zone.gameobject.iscaptured;
    }
  }

  foreach(spawnlist in level.var_f401aaf9) {
    list = spawnlist[#"list"];
    mask = util::getteammask(spawnlist[#"team"]);
    disablespawnpointlist(list, mask);
  }

  if(var_66eb1393.size == 2) {
    if(var_66eb1393[0]) {
      function_7e5cbc97("control_attack_add_0");
      function_7e5cbc97("control_defend_add_0");
    } else {
      function_7e5cbc97("control_attack_remove_0");
      function_7e5cbc97("control_defend_remove_0");
    }

    if(var_66eb1393[1]) {
      function_7e5cbc97("control_attack_add_1");
      function_7e5cbc97("control_defend_add_1");
      return;
    }

    function_7e5cbc97("control_attack_remove_1");
    function_7e5cbc97("control_defend_remove_1");
  }
}

function register_clientfields() {
  clientfield::register("world", "activeZoneTriggers", 1, 5, "int");
  clientfield::register("world", "warzone", 1, 5, "int");
  clientfield::register("world", "warzonestate", 1, 10, "int");
  clientfield::function_5b7d846d("hudItems.missions.captureMultiplierStatus", 1, 2, "int");
  clientfield::function_5b7d846d("hudItems.war.attackingTeam", 1, 2, "int");
  clientfield::register("scriptmover", "scriptid", 1, 5, "int");
}

function on_time_limit() {
  if(level.zones.size == level.capturedzones) {
    level thread globallogic::end_round(1);
    return;
  }

  if(is_true(level.neutralzone)) {
    round::function_870759fb();
  } else {
    round::set_winner(game.defenders);
  }

  thread globallogic::end_round(2);
}

function on_spawn_player(predictedspawn) {
  self function_2ba2d8e5("");
  spawning::onspawnplayer(predictedspawn);
  self.currentzoneindex = undefined;

  if(level.numlives > 0) {
    clientfield::set_player_uimodel("hudItems.playerLivesCount", game.lives[self.team]);
  }
}

function gettimelimit() {
  timelimit = globallogic_defaults::default_gettimelimit();

  if(timelimit <= 0) {
    return 0;
  }

  if(level.usingextratime) {
    timelimit += level.extratime;
  }

  if(isDefined(level.var_9618a3e8) && level.var_9618a3e8 > 0) {
    timelimit += level.var_9618a3e8 / 60;
  }

  return timelimit;
}

function on_end_game(var_c1e98979) {
  if(level.scoreroundwinbased) {
    globallogic_score::function_9779ac61();
    winner = teams::function_d85770f0("roundswon");
  } else {
    winner = teams::function_ef80de99();
  }

  match::function_af2e264f(winner);
}

function on_end_round(var_c1e98979) {
  function_4c593022();
  function_7996e36d();

  if(globallogic::function_8b4fc766(var_c1e98979)) {
    winning_team = round::get_winning_team();
    globallogic_score::giveteamscoreforobjective(winning_team, 1);
  }

  if(var_c1e98979 == 6) {
    winning_team = round::get_winning_team();
    challenges::last_man_defeat_3_enemies(winning_team);
  }

  foreach(team in level.teams) {
    if(!isDefined(game.stat[#"hash_ed468051aee466"][team])) {
      game.stat[#"hash_ed468051aee466"][team] = 0;
    }

    game.stat[#"hash_ed468051aee466"][team] += level.deaths[team];
  }

  if(game.stat[#"teamscores"][#"allies"] == level.roundwinlimit - 1 && game.stat[#"teamscores"][#"axis"] == level.roundwinlimit - 1) {
    bestteam = function_d58274e5();

    if(bestteam === game.defenders) {
      level.roundswitch = 0;
    }
  }

  function_68387604(var_c1e98979);
}

function function_d58274e5() {
  if(level.overtimebestteam === 1) {
    var_d0f35ab1[#"allies"] = game.stat[#"hash_2d36f0ab06fb245e"][#"allies"];
    var_d0f35ab1[#"axis"] = game.stat[#"hash_2d36f0ab06fb245e"][#"axis"];

    if(var_d0f35ab1[#"allies"] > var_d0f35ab1[#"axis"]) {
      return # "allies";
    } else if(var_d0f35ab1[#"axis"] > var_d0f35ab1[#"allies"]) {
      return # "axis";
    }
  }

  totaldeaths[#"allies"] = game.stat[#"hash_ed468051aee466"][#"allies"];
  totaldeaths[#"axis"] = game.stat[#"hash_ed468051aee466"][#"axis"];

  if(totaldeaths[#"allies"] < totaldeaths[#"axis"]) {
    return # "allies";
  }

  if(totaldeaths[#"axis"] < totaldeaths[#"allies"]) {
    return # "axis";
  }

  if(randomint(2) == 0) {
    return # "allies";
  }

  return # "axis";
}

function function_d126ce1b() {
  if(!isDefined(self.touchtriggers)) {
    return true;
  }

  if(self.touchtriggers.size == 0) {
    return true;
  }

  return false;
}

function function_610d3790(einflictor, victim, idamage, weapon) {
  if(idamage.var_4ef33446 === 1) {
    return;
  }

  var_376742ed = 1;

  if(isDefined(weapon) && isDefined(level.iskillstreakweapon)) {
    if([[level.iskillstreakweapon]](weapon) || isDefined(weapon.statname) && [[level.iskillstreakweapon]](getweapon(weapon.statname))) {
      var_376742ed = 0;
    }
  }

  attacker = self;
  var_1cfdf798 = isDefined(idamage.lastattacker) ? idamage.lastattacker === attacker : 0;

  if(!isPlayer(attacker) || level.capturetime && idamage function_d126ce1b() && attacker function_d126ce1b() || attacker.pers[#"team"] == idamage.pers[#"team"]) {
    if(var_376742ed) {
      idamage function_580fd2d5(attacker, weapon, victim, var_1cfdf798);
    }

    return;
  }

  foreach(controlzone in level.zones) {
    if(idamage globallogic_score::function_2e33e275(victim, attacker, weapon, controlzone.trigger)) {
      zone = controlzone;

      if(var_1cfdf798) {
        idamage thread globallogic_score::function_7d830bc(victim, attacker, weapon, controlzone.trigger, controlzone.team);
      }
    }
  }

  ownerteam = undefined;

  if(level.capturetime == 0) {
    if(!isDefined(zone)) {
      return;
    }

    ownerteam = zone.gameobject gameobjects::get_owner_team();

    if(!isDefined(ownerteam) || ownerteam == # "neutral") {
      return;
    }
  }

  if(!idamage function_d126ce1b() || level.capturetime == 0 && idamage istouching(zone.trigger)) {
    if(var_1cfdf798) {
      if(idamage.team == game.attackers && attacker.team == game.defenders) {
        attacker thread challenges::killedbaseoffender(zone.gameobject, weapon, victim);

        if(var_376742ed) {
          attacker thread kill_while_contesting(idamage, weapon);
          scoreevents::processscoreevent(#"kill_enemy_that_is_capping_your_objective", attacker, idamage, weapon);
        }
      }

      if(idamage.team == game.defenders && attacker.team == game.attackers) {
        attacker thread challenges::killedbasedefender(zone.gameobject);

        if(var_376742ed) {
          if(!attacker function_d126ce1b() || level.capturetime == 0 && attacker istouching(zone.trigger)) {
            scoreevents::function_2a2e1723(#"war_killed_enemy_while_capping_control", attacker, idamage, weapon);
          }
        }
      }

      if(var_376742ed) {
        idamage function_580fd2d5(attacker, weapon, victim, var_1cfdf798);
      }
    }

    return;
  }

  if(var_376742ed) {
    idamage function_580fd2d5(attacker, weapon, victim, var_1cfdf798);
  }
}

function on_player_killed(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  if(isDefined(self) && isDefined(self.currentzoneindex)) {
    bb::function_95a5b5c2("exited_control_point_death", self.zoneindex, self.team, self.origin, self);
    self.currentzoneindex = undefined;
    self notify(#"hash_68e3332f714afbbc");
  }

  if(!isDefined(self) || !isDefined(psoffsettime) || !isPlayer(psoffsettime)) {
    return;
  }

  if(psoffsettime != self && psoffsettime.team != self.team) {
    if(isDefined(psoffsettime.pers) && isDefined(psoffsettime.pers[#"hash_22770dcff96626d2"]) && isDefined(psoffsettime.pers[#"hash_2d873e8313116c20"])) {
      if(psoffsettime.team == game.attackers) {
        psoffsettime.pers[#"hash_22770dcff96626d2"]++;
        psoffsettime function_ef823e71(13, psoffsettime.pers[#"hash_22770dcff96626d2"]);
      } else if(psoffsettime.team == game.defenders) {
        psoffsettime.pers[#"hash_2d873e8313116c20"]++;
        psoffsettime function_ef823e71(12, psoffsettime.pers[#"hash_2d873e8313116c20"]);
      }
    }

    if(isDefined(self.pers) && self.pers[#"lives"] == 0) {
      scoreevents::processscoreevent(#"eliminated_enemy", psoffsettime, self, deathanimduration);

      if(!isDefined(level.var_c473f6ca)) {
        level.var_c473f6ca = [];
      }

      if(!isDefined(level.var_c473f6ca[self.team])) {
        level.var_c473f6ca[self.team] = 0;
      }

      level.var_c473f6ca[self.team]++;

      if(level.playercount[self.team] == level.var_c473f6ca[self.team]) {
        psoffsettime stats::function_dad108fa(#"eliminated_final_enemy", 1);
      }
    }
  }
}

function function_a800815(victim, attacker) {
  if(!isDefined(victim.pers) || !isDefined(victim.pers[#"team"])) {
    return false;
  }

  if(!isDefined(attacker.pers) || !isDefined(attacker.pers[#"team"])) {
    return false;
  }

  if(isDefined(victim.touchtriggers) && victim.touchtriggers.size && attacker.pers[#"team"] != victim.pers[#"team"] && victim.pers[#"team"] == game.attackers) {
    triggerids = getarraykeys(victim.touchtriggers);
    zone = victim.touchtriggers[triggerids[0]].useobj;

    if(zone.curprogress > 0) {
      return true;
    }
  }

  return false;
}

function function_d3a438fb(entity) {
  foreach(zone in level.zones) {
    if(!isDefined(zone) || !isDefined(zone.trigger)) {
      continue;
    }

    if(entity istouching(zone.trigger)) {
      return true;
    }
  }

  return false;
}

function function_580fd2d5(attacker, weapon, inflictor, var_1cfdf798) {
  if(!isPlayer(attacker)) {
    return;
  }

  foreach(zone in level.zones) {
    if(!isDefined(zone.trigger)) {
      continue;
    }

    if(!is_true(zone.gameobject.iscaptured) && (self istouching(zone.trigger, (350, 350, 100)) || attacker istouching(zone.trigger, (350, 350, 100)))) {
      if(self.team == game.attackers && attacker.team == game.defenders) {
        if(var_1cfdf798) {
          scoreevents::function_2a2e1723(#"killed_attacker", attacker, self, weapon);
          attacker challenges::function_82bb78f7(weapon, self);
        }

        attacker function_27138bf1(self, weapon, inflictor, zone.gameobject);
      }

      if(self.team == game.defenders && attacker.team == game.attackers) {
        if(var_1cfdf798) {
          scoreevents::function_2a2e1723(#"killed_defender", attacker, self, weapon);
          attacker challenges::function_82bb78f7(weapon, self);
        }

        attacker function_27138bf1(self, weapon, inflictor, zone.gameobject);
      }
    }
  }
}

function function_27138bf1(victim, weapon, inflictor, gameobject) {
  self challenges::function_2f462ffd(victim, weapon, inflictor, gameobject);
  self.pers[#"objectiveekia"]++;
  self.objectiveekia = self.pers[#"objectiveekia"];
  self.pers[#"objectives"]++;
  self.objectives = self.pers[#"objectives"];
  var_1cfdf798 = isDefined(victim.lastattacker) ? victim.lastattacker === self : 0;

  if(isDefined(self.playerrole) && var_1cfdf798) {
    if(self.team == game.attackers) {
      self.pers[#"hash_281165a5744a0185"]++;
      self function_ef823e71(14, self.pers[#"hash_281165a5744a0185"]);
      return;
    }

    if(self.team == game.defenders) {
      self.pers[#"hash_a8c7a84a8f7e333"]++;
      self function_ef823e71(10, self.pers[#"hash_a8c7a84a8f7e333"]);
    }
  }
}

function get_player_userate(use_object) {
  use_rate_multiplier = 1;

  if(isDefined(self.playerrole)) {
    if(self.team == game.attackers) {
      use_rate_multiplier = self.playerrole.attackercapturemultiplier;
    } else if(self.team == game.defenders) {
      use_rate_multiplier = self.playerrole.defenddecaymultiplier;
    }
  }

  return use_rate_multiplier;
}

function on_player_connect() {
  self gameobjects::setplayergametypeuseratecallback(&get_player_userate);
  function_f9bfc5ca(self);
}

function private use_start_spawns() {
  level waittill(#"grace_period_ending");
  spawning::function_7a87efaa();
}

function on_start_gametype() {
  level.usingextratime = 0;
  level.var_9618a3e8 = 0;
  level.wartotalsecondsinzone = 0;
  level.round_winner = undefined;
  function_de560341();
  setup_objectives();
  globallogic_score::resetteamscores();
  level.zonemask = 0;
  level.zonestatemask = 0;
  level.var_9491e8e3 = 0;

  foreach(team in level.teams) {
    if(!isDefined(game.stat[#"hash_2d36f0ab06fb245e"][team])) {
      game.stat[#"hash_2d36f0ab06fb245e"][team] = 0;
    }
  }

  thread use_start_spawns();
  userspawnselection::supressspawnselectionmenuforallplayers();
  setup_zones();
  updatespawns();
  thread set_ui_team();
  thread main_loop();
  thread function_caff2d60();
  thread function_5416d912();
  luinotifyevent(#"round_start");
  level notify(#"hash_d50c83061fcd561");
}

function setup_zones() {
  level.zones = get_zone_array();

  if(level.zones.size == 0) {
    globallogic_utils::print_map_errors();
    return 0;
  }

  if(level.zones.size > 1) {
    level.nzones = level.zones.size;
    trigs = getEntArray("control_zone_trigger", "targetname");
  } else {
    level.nzones = 1;
    trigs = getEntArray("control_zone_trigger", "targetname");
  }

  for(zi = 0; zi < level.nzones; zi++) {
    zone = level.zones[zi];
    errored = 0;
    zone.trigger = undefined;

    for(j = 0; j < trigs.size; j++) {
      if(zone istouching(trigs[j])) {
        if(isDefined(zone.trigger)) {
          globallogic_utils::add_map_error("Zone at " + zone.origin + " is touching more than one \"zonetrigger\" trigger");
          errored = 1;
          break;
        }

        zone.trigger = trigs[j];
        zone.var_b76aa8 = j;
        break;
      }
    }

    if(!isDefined(zone.trigger)) {
      if(!errored) {
        globallogic_utils::add_map_error("Zone at " + zone.origin + " is not inside any \"zonetrigger\" trigger");
        return;
      }
    }

    assert(!errored);
    zone.trigger trigger::add_flags(16);
    zone.trigorigin = zone.trigger.origin;
    zone.objectiveanchor = spawn("script_model", zone.origin);
    visuals = [];
    visuals[0] = zone;

    if(isDefined(zone.target)) {
      othervisuals = getEntArray(zone.target, "targetname");

      for(j = 0; j < othervisuals.size; j++) {
        visuals[visuals.size] = othervisuals[j];
      }
    }

    ownerteam = game.defenders;

    if(is_true(level.neutralzone)) {
      ownerteam = # "neutral";
    }

    zone.gameobject = gameobjects::create_use_object(ownerteam, zone.trigger, visuals, (0, 0, 0), "control_" + zi);
    zone.gameobject gameobjects::set_objective_entity(zone);
    zone.gameobject gameobjects::disable_object();
    zone.gameobject gameobjects::set_model_visibility(0, 1);
    zone.gameobject.owningzone = zone;
    zone.gameobject.var_3517bb1 = 1;
    zone.trigger.useobj = zone.gameobject;
    zone.gameobject.lastteamtoownzone = # "neutral";
    zone.gameobject.currentlyunoccupied = 1;
    zone.gameobject.var_a0ff5eb8 = !level.flagcapturerateincrease;
    zone.zoneindex = zi;
    zone.scores = [];

    foreach(team, _ in level.teams) {
      zone.scores[team] = 0;
    }

    level.var_1cb1e802[zi] = 0;
    zone setup_zone_exclusions();
  }

  if(globallogic_utils::print_map_errors()) {
    return 0;
  }
}

function compare_zone_indicies(zone_a, zone_b) {
  script_index_a = zone_a.script_index;
  script_index_b = zone_b.script_index;

  if(!isDefined(script_index_a) && !isDefined(script_index_b)) {
    return false;
  }

  if(!isDefined(script_index_a) && isDefined(script_index_b)) {
    println("<dev string:x38>" + zone_a.origin);
    return true;
  }

  if(isDefined(script_index_a) && !isDefined(script_index_b)) {
    println("<dev string:x38>" + zone_b.origin);
    return false;
  }

  if(script_index_a > script_index_b) {
    return true;
  }

  return false;
}

function get_zone_array() {
  allzones = getEntArray("control_zone_center", "targetname");

  if(!isDefined(allzones)) {
    globallogic_utils::add_map_error("Cannot find any zone entities");
    return [];
  }

  if(allzones.size == 0) {
    globallogic_utils::add_map_error("There are no control zones defined for this map " + util::get_map_name());
    return [];
  }

  if(allzones.size > 1) {
    zoneindices = [];
    numberofzones = allzones.size;

    for(i = 0; i < numberofzones; i++) {
      fieldname = "zoneinfo" + numberofzones + i + 1;
      index = isDefined(level.mission_bundle.(fieldname)) ? level.mission_bundle.(fieldname) : 0;
      zoneindices[zoneindices.size] = index;
    }

    zones = [];

    for(i = 0; i < allzones.size; i++) {
      ind = allzones[i].script_index;

      if(isDefined(ind)) {
        for(j = 0; j < zoneindices.size; j++) {
          if(zoneindices[j] == ind) {
            zones[zones.size] = allzones[i];
            break;
          }
        }

        continue;
      }

      globallogic_utils::add_map_error("Zone with no script_index set");
    }
  } else {
    zones = getEntArray("control_zone_center", "targetname");
  }

  if(!isDefined(zones)) {
    globallogic_utils::add_map_error("Cannot find any zone entities");
    return [];
  }

  swapped = 1;

  for(n = zones.size; swapped; n--) {
    swapped = 0;

    for(i = 0; i < n - 1; i++) {
      if(compare_zone_indicies(zones[i], zones[i + 1])) {
        temp = zones[i];
        zones[i] = zones[i + 1];
        zones[i + 1] = temp;
        swapped = 1;
      }
    }
  }

  for(i = 0; i < zones.size; i++) {
    zones[i].zone_index = i;
  }

  return zones;
}

function update_objective_hint_message(attackersmsg, defendersmsg) {
  gametype = util::get_game_type();

  foreach(team, _ in level.teams) {
    if(team == game.attackers) {
      game.strings["objective_hint_" + team] = attackersmsg;
      continue;
    }

    game.strings["objective_hint_" + team] = defendersmsg;
  }
}

function setup_objectives() {
  level.objectivehintpreparezone = # "mp/control_koth";
  level.objectivehintcapturezone = # "mp/capture_koth";
  level.objectivehintdefendhq = # "mp/defend_koth";

  if(level.zonespawntime) {
    update_objective_hint_message(level.objectivehintpreparezone);
  } else {
    update_objective_hint_message(level.objectivehintcapturezone);
  }

  game.strings[game.attackers + "_mission_win"] = # "hash_6ed10cd957ecbde6";
  game.strings[game.attackers + "_mission_loss"] = # "hash_504843f8a8fe0230";
  game.strings[game.defenders + "_mission_win"] = # "hash_74e465610ac830ce";
  game.strings[game.defenders + "_mission_loss"] = # "hash_7d37cafde0ab4ecd";
}

function toggle_zone_effects(enabled) {
  if(enabled) {
    level.zonemask |= 1 << self.zone_index;
    level.var_9491e8e3 |= 1 << self.var_b76aa8;
  } else {
    level.zonemask &= ~(1 << self.zone_index);
    level.var_9491e8e3 &= ~(1 << self.var_b76aa8);
  }

  level.zonestatemask &= ~(3 << self.zone_index);
  level clientfield::set("activeZoneTriggers", level.var_9491e8e3);
  level clientfield::set("warzone", level.zonemask);
  level clientfield::set("warzonestate", level.zonestatemask);
}

function main_loop() {
  level endon(#"game_ended");

  while(level.inprematchperiod) {
    waitframe(1);
  }

  thread hide_timer_on_game_end();
  wait 1;

  foreach(zone in level.zones) {
    if(!isDefined(zone.target)) {
      assertmsg("<dev string:x61>" + (isDefined(zone.targetname) ? zone.targetname : "<dev string:xaa>"));
      continue;
    }

    othervisuals = getEntArray(zone.target, "targetname");

    for(j = 0; j < othervisuals.size; j++) {
      othervisuals[j] notsolid();
      othervisuals[j] clientfield::set("scriptid", zone.script_index);
    }

    zone.objectiveanchor clientfield::set("scriptid", zone.script_index);
  }

  sound::play_on_players("mp_suitcase_pickup");

  if(level.zonespawntime && !is_true(level.neutralzone)) {
    foreach(zone in level.zones) {
      zone.gameobject gameobjects::set_flags(1);
    }

    update_objective_hint_message(level.objectivehintpreparezone);
    wait level.zonespawntime;

    foreach(zone in level.zones) {
      zone.gameobject gameobjects::set_flags(0);
    }
  }

  waittillframeend();

  if(is_true(level.neutralzone)) {
    update_objective_hint_message(#"mp/capture_strong", #"mp/capture_strong");
  } else {
    update_objective_hint_message(#"mp/capture_strong", #"mp/defend_strong");
  }

  sound::play_on_players("mpl_hq_cap_us");
  thread function_23bedaa1();

  foreach(zone in level.zones) {
    thread capture_loop(zone);
  }

  level.capturedzones = 0;

  while(level.capturedzones < level.zones.size) {
    res = level waittill(#"zone_captured");
    waitframe(1);
  }
}

function audio_loop() {
  level endon(#"game_ended");
  self notify(#"audio_loop_singleton");
  self endon(#"audio_loop_singleton");

  while(true) {
    foreach(zone in level.zones) {
      if(is_zone_contested(zone.gameobject)) {
        playsoundatposition(#"mpl_zone_contested", zone.gameobject.origin);
        break;
      }
    }

    wait 1;
  }
}

function function_23bedaa1() {
  level endon(#"game_ended");
  self notify(#"hash_5e9e72ecc3fc7569");
  self endon(#"hash_5e9e72ecc3fc7569");

  while(true) {
    for(i = 0; i < level.zones.size; i++) {
      update_timer(i, 0);
    }

    wait 0.1;
  }
}

function function_31c391cf() {
  util::wait_network_frame();
  util::wait_network_frame();
  self toggle_zone_effects(1);
}

function capture_loop(zone) {
  level endon(#"game_ended");
  level.warstarttime = gettime();
  zone.gameobject gameobjects::set_flags(0);
  zone.gameobject gameobjects::enable_object();
  objective_onentity(zone.gameobject.objectiveid, zone.objectiveanchor);
  function_18fbab10(zone.gameobject.objectiveid, zone.gameobject.var_f23c87bd + "_codcaster");
  zone.gameobject.capturecount = 0;
  zone.gameobject gameobjects::allow_use(#"group_enemy");
  zone.gameobject gameobjects::set_use_time(level.capturetime);
  zone.gameobject gameobjects::set_use_text(#"mp/capturing_objective");
  zone.gameobject gameobjects::set_visible(#"group_all");
  zone.gameobject gameobjects::set_model_visibility(1, 1);
  zone.gameobject gameobjects::must_maintain_claim(0);
  zone.gameobject gameobjects::can_contest_claim(1);
  zone.gameobject.decayprogress = 1;
  zone.gameobject gameobjects::set_decay_time(level.capturetime);
  zone.gameobject.autodecaytime = level.autodecaytime;

  if(is_true(level.neutralzone)) {
    zone.gameobject.onuse = &on_zone_capture_neutral;
  } else {
    zone.gameobject.onuse = &on_zone_capture;
  }

  zone.gameobject.onbeginuse = &on_begin_use;
  zone.gameobject.onenduse = &on_end_use;
  zone.gameobject.ontouchuse = &on_touch_use;
  zone.gameobject.onupdateuserate = &function_bcaf6836;
  zone.gameobject.onendtouchuse = &on_end_touch_use;
  zone.gameobject.onresumeuse = &on_touch_use;
  zone.gameobject.stage = 1;

  if(is_true(level.neutralzone)) {
    zone.gameobject.onuseupdate = &on_use_update_neutral;
  } else {
    zone.gameobject.onuseupdate = &on_use_update;
  }

  zone.gameobject.ondecaycomplete = &on_decay_complete;
  zone thread function_31c391cf();
  spawn_beacon::addprotectedzone(zone.trigger);
  level waittill("zone_captured" + zone.zone_index, #"mission_timed_out");
  ownerteam = zone.gameobject gameobjects::get_owner_team();
  profilestart();
  zone.gameobject.lastcaptureteam = undefined;
  zone.gameobject gameobjects::set_visible(#"group_all");
  zone.gameobject gameobjects::allow_use(#"group_none");
  zone.gameobject gameobjects::set_owner_team(#"neutral");
  zone.gameobject gameobjects::set_model_visibility(0, 1);
  zone.gameobject gameobjects::must_maintain_claim(0);
  zone.gameobject.decayprogress = 1;
  zone.gameobject.autodecaytime = level.autodecaytime;
  objective_setstate(zone.gameobject.objectiveid, "done");
  zone toggle_zone_effects(0);
  spawn_beacon::removeprotectedzone(zone.trigger);
  zone.gameobject gameobjects::disable_object();
  profilestop();
}

function private hide_timer_on_game_end() {
  level notify(#"hide_timer_on_game_end");
  level endon(#"hide_timer_on_game_end");
  level waittill(#"game_ended");
  setmatchflag("bomb_timer_a", 0);
}

function private checkifshouldupdateattackerstatusplayback(sentient) {
  if(sentient.team != game.attackers) {
    return;
  }

  if(!isDefined(self.lastteamtoownzone)) {
    return;
  }

  if(self.lastteamtoownzone == sentient.team) {
    return;
  }

  self.needsattackerstatusplayback = 1;
}

function private checkifshouldupdatedefenderstatusplayback(sentient) {
  if(sentient.team != game.defenders) {
    return;
  }

  if(isDefined(self.lastteamtoownzone) && self.lastteamtoownzone == sentient.team) {
    return;
  }

  self.needsdefenderstatusplayback = 1;
}

function private checkifshouldupdatestatusplayback(sentient) {
  if(is_true(level.neutralzone)) {
    self.needsallstatusplayback = 1;
    return;
  }

  checkifshouldupdateattackerstatusplayback(sentient);
  checkifshouldupdatedefenderstatusplayback(sentient);
}

function private function_bcaf6836() {
  if(!isDefined(self.contested)) {
    self.contested = 0;
  }

  var_464f0169 = self.contested;
  self.contested = is_zone_contested(self);

  if(self.contested) {
    if(!var_464f0169) {
      foreach(user in self.users) {
        foreach(var_142bcc32 in user.touching.players) {
          player = var_142bcc32.player;

          if(isDefined(player) && isPlayer(player) && (isDefined(player.var_c8d27c06) ? player.var_c8d27c06 : 0) < gettime()) {
            player playsoundtoplayer(#"mpl_control_capture_contested", player);
            player.var_c8d27c06 = gettime() + 5000;
          }
        }
      }
    }
  }
}

function private on_touch_use(sentient) {
  if(isPlayer(sentient)) {
    if(is_zone_contested(self) && (isDefined(sentient.var_c8d27c06) ? sentient.var_c8d27c06 : 0) < gettime()) {
      sentient playsoundtoplayer(#"mpl_control_capture_contested", sentient);
      sentient.var_c8d27c06 = gettime() + 5000;
    }

    bb::function_95a5b5c2("entered_control_point", self.zoneindex, sentient.team, sentient.origin, sentient);
    self notify(#"hash_68e3332f714afbbc");
    sentient.currentzoneindex = self.zoneindex;
    sentient thread player_use_loop(self);
  }

  self checkifshouldupdatestatusplayback(sentient);
  self update_team_client_field();
}

function private function_88acffae(sentient) {
  sentient endon(#"hash_68e3332f714afbbc");

  if(!isPlayer(sentient)) {
    return;
  }

  waitframe(1);
  waitframe(1);

  if(!isDefined(sentient)) {
    return;
  }

  bb::function_95a5b5c2("exited_control_point_default", self.zoneindex, sentient.team, sentient.origin, sentient);
  sentient.currentzoneindex = undefined;
}

function private on_end_touch_use(sentient) {
  if(!isDefined(sentient)) {
    return;
  }

  sentient notify("use_stopped" + self.owningzone.zone_index);
  self update_team_client_field();
  self thread function_88acffae(sentient);
}

function private on_end_use(team, sentient, success) {
  success notify("event_ended" + self.owningzone.zone_index);
  self update_team_client_field();
}

function private play_objective_audio(audiocue, team) {
  if(isDefined(level.audiocues[audiocue])) {
    if(level.audiocues[audiocue] + level.audioplaybackthrottle > gettime()) {
      return;
    }
  }

  level.audiocues[audiocue] = gettime();
  thread globallogic_audio::leader_dialog(audiocue, team, "gamemode_objective", undefined, "kothActiveDialogBuffer");
}

function private process_zone_capture_audio(zone, capture_team) {
  foreach(team, _ in level.teams) {
    if(team == capture_team) {
      soundkey = "controlZ" + zone.zone_index + 1 + "TakenOfs";
      play_objective_audio(soundkey, team);

      if(level.nzones == 0) {
        soundkey = "controlAllZonesCapOfs";
      } else {
        soundkey = "controlLastZoneOfs";
      }

      play_objective_audio(soundkey, team);
      thread sound::play_on_players(game.objective_gained_sound, team);
      continue;
    }

    soundkey = "controlZ" + zone.zone_index + 1 + "LostDef";
    play_objective_audio(soundkey, team);

    if(level.nzones == 0) {
      soundkey = "controlAllZonesCapDef";
    } else {
      soundkey = "controlLastZoneDef";
    }

    play_objective_audio(soundkey, team);
    thread sound::play_on_players(game.objective_lost_sound, team);
  }
}

function ononeleftevent(team) {
  index = util::function_ff74bf7(team);
  players = level.players;

  if(index == players.size) {
    return;
  }

  player = players[index];
  enemyteam = util::get_enemy_team(team);

  if(function_a1ef346b(enemyteam).size > 2) {
    player.var_66cfa07f = 1;
  }

  util::function_a3f7de13(17, player.team, player getentitynumber());
}

function private on_zone_capture(sentient) {
  level.nzones--;
  level.numzonesoccupied--;
  capture_team = sentient.team;
  capturetime = gettime();
  string = # "hash_6d6f47aad6be619f";

  if(!isDefined(self.lastcaptureteam) || self.lastcaptureteam != capture_team) {
    if(is_true(getgametypesetting(#"contributioncapture"))) {
      var_1dbb2b2b = arraycopy(self.users[capture_team].contributors);
      var_6d7ae157 = arraycopy(self.users[capture_team].touching.players);
      self thread function_ef09febd(var_1dbb2b2b, var_6d7ae157, string, capturetime, capture_team, self.lastcaptureteam);
    } else {
      touchlist = arraycopy(self.users[capture_team].touching.players);
      thread give_capture_credit(touchlist, string, capturetime, capture_team, self.lastcaptureteam);
    }
  }

  level.warcapteam = capture_team;
  level.war_mission_succeeded = 1;
  self gameobjects::set_owner_team(capture_team);

  foreach(team, _ in level.teams) {
    if(team == capture_team) {
      for(index = 0; index < level.players.size; index++) {
        player = level.players[index];

        if(player.pers[#"team"] == team) {
          if(player.lastkilltime + 500 > gettime()) {
            player challenges::killedlastcontester();
          }

          player.pers[#"hash_156cd38474282f8d"]++;
          player function_ef823e71(11, player.pers[#"hash_156cd38474282f8d"]);
        }
      }
    }
  }

  level.var_1cb1e802[self.owningzone.zoneindex]++;
  process_zone_capture_audio(self.owningzone, capture_team);
  self.capturecount++;
  self.lastcaptureteam = capture_team;
  self.iscaptured = 1;
  game.stat[#"hash_2d36f0ab06fb245e"][capture_team]++;
  self gameobjects::must_maintain_claim(1);
  self update_team_client_field();

  if(isPlayer(sentient)) {
    sentient recordgameevent("hardpoint_captured");
    level thread telemetry::function_18135b72(#"hash_540cddd637f71a5e", {
      #player: sentient, #eventtype: # "hardpoint_captured"});
    bb::function_95a5b5c2("exited_control_point_captured", self.zoneindex, sentient.team, sentient.origin, sentient);
    self notify(#"hash_68e3332f714afbbc");
  }

  level.capturedzones++;

  if(level.capturedzones == 1 && [[level.gettimelimit]]() > 0) {
    util::function_a3f7de13(27, sentient.team, -1, function_da460cb8(self.var_f23c87bd));
    level.usingextratime = 1;
    level.var_9618a3e8 += isDefined(level.extrasegmenttime) ? level.extrasegmenttime : 0;

    if(is_true(level.var_2179a6bf)) {
      music::setmusicstate("");
      level thread globallogic_audio::function_4e959ce6();
      level.var_2179a6bf = 0;
    }
  }

  if(level.capturedzones == 1 && (isDefined(level.bonuslivesforcapturingzone) ? level.bonuslivesforcapturingzone : 0) > 0 && capture_team == game.attackers) {
    game.lives[game.attackers] += level.bonuslivesforcapturingzone;
    teamid = "team" + level.teamindex[game.attackers];
    clientfield::set_world_uimodel("hudItems." + teamid + ".livesCount", game.lives[game.attackers]);
  }

  level notify("zone_captured" + self.owningzone.zone_index);
  level notify(#"zone_captured");
  level notify("zone_captured" + capture_team);
  sentient notify("event_ended" + self.owningzone.zone_index);

  if(level.zones.size == level.capturedzones) {
    round::set_winner(game.attackers);
    level thread globallogic::end_round(1);
  } else {
    foreach(zone in level.zones) {
      if(!isDefined(zone.gameobject)) {
        continue;
      }

      if(!is_true(zone.gameobject.iscaptured)) {
        if(zone.gameobject.stage === 3) {
          level notify(#"hash_15b8b6edc4ed3032", {
            #var_7090bf53: 0
          });
        }
      }
    }
  }

  thread updatespawns();
}

function private on_zone_capture_neutral(sentient) {
  capture_team = sentient.team;
  capturetime = gettime();
  string = # "hash_6d6f47aad6be619f";

  if(!isDefined(self.lastcaptureteam) || self.lastcaptureteam != capture_team) {
    if(is_true(getgametypesetting(#"contributioncapture"))) {
      var_1dbb2b2b = arraycopy(self.users[capture_team].contributors);
      var_6d7ae157 = arraycopy(self.users[capture_team].touching.players);
      self thread function_ef09febd(var_1dbb2b2b, var_6d7ae157, string, capturetime, capture_team, self.lastcaptureteam);
    } else {
      touchlist = arraycopy(self.users[capture_team].touching.players);
      thread give_capture_credit(touchlist, string, capturetime, capture_team, self.lastcaptureteam);
    }
  }

  level.warcapteam = capture_team;
  level.war_mission_succeeded = 1;

  if(!is_true(level.decaycapturedzones)) {
    if(self gameobjects::get_owner_team() != capture_team) {
      self thread award_capture_points_neutral(capture_team);
      self gameobjects::set_owner_team(capture_team);
    }
  } else {
    if(self gameobjects::get_owner_team() == # "neutral") {
      self gameobjects::set_owner_team(capture_team);
      self thread award_capture_points_neutral(capture_team);
    }

    if(self gameobjects::get_owner_team() != capture_team) {
      level notify(#"awardcapturepointsrunningneutral");
      self gameobjects::set_owner_team(#"neutral");
    }
  }

  foreach(team, _ in level.teams) {
    if(team == capture_team) {
      for(index = 0; index < level.players.size; index++) {
        player = level.players[index];

        if(player.pers[#"team"] == team) {
          if(player.lastkilltime + 500 > gettime()) {
            player challenges::killedlastcontester();
          }
        }
      }
    }
  }

  process_zone_capture_audio(self.owningzone, capture_team);
  self.capturecount++;
  self.lastcaptureteam = capture_team;
  self gameobjects::must_maintain_claim(1);
  self update_team_client_field();

  if(isPlayer(sentient)) {
    sentient recordgameevent("hardpoint_captured");
    level thread telemetry::function_18135b72(#"hash_540cddd637f71a5e", {
      #player: sentient, #eventtype: # "hardpoint_captured"});
  }

  sentient notify("event_ended" + self.owningzone.zone_index);
}

function private function_ef09febd(var_1dbb2b2b, var_6d7ae157, string, capturetime, capture_team, lastcaptureteam) {
  var_b4613aa2 = [];
  earliestplayer = undefined;

  foreach(contribution in var_1dbb2b2b) {
    if(isDefined(contribution)) {
      contributor = contribution.player;

      if(isDefined(contributor) && isDefined(contribution.contribution)) {
        percentage = 100 * contribution.contribution / self.usetime;
        contributor.var_759a143b = int(0.5 + percentage);
        contributor.var_1aea8209 = contribution.starttime;

        if(percentage < getgametypesetting(#"contributionmin")) {
          continue;
        }

        if(contribution.var_e22ea52b && (!isDefined(earliestplayer) || contributor.var_1aea8209 < earliestplayer.var_1aea8209)) {
          earliestplayer = contributor;
        }

        if(!isDefined(var_b4613aa2)) {
          var_b4613aa2 = [];
        } else if(!isarray(var_b4613aa2)) {
          var_b4613aa2 = array(var_b4613aa2);
        }

        var_b4613aa2[var_b4613aa2.size] = contributor;
      }
    }
  }

  foreach(player in var_b4613aa2) {
    var_a84f97bf = earliestplayer === player;
    var_af8f6146 = 0;

    foreach(touch in var_6d7ae157) {
      if(!isDefined(touch)) {
        continue;
      }

      if(touch.player === player) {
        var_af8f6146 = 1;
        break;
      }
    }

    credit_player(player, string, capturetime, capture_team, lastcaptureteam, var_a84f97bf, var_af8f6146);
  }

  self gameobjects::function_98aae7cf();
}

function private give_capture_credit(touchlist, string, capturetime, capture_team, lastcaptureteam) {
  foreach(touch in touchlist) {
    player = gameobjects::function_73944efe(touchlist, touch);

    if(!isDefined(player)) {
      continue;
    }

    credit_player(player, string, capturetime, capture_team, lastcaptureteam, 0, 1);
  }
}

function private credit_player(player, string, capturetime, capture_team, lastcaptureteam, var_a84f97bf, var_af8f6146) {
  string update_caps_per_minute(lastcaptureteam);

  if(!is_score_boosting(string)) {
    string challenges::capturedobjective(capture_team, self.trigger);
    scoreevents::processscoreevent(#"war_captured_zone", string, undefined, undefined);
    string contracts::increment_contract(#"hash_afec1ad46ac353");
    string recordgameevent("capture");
    level thread telemetry::function_18135b72(#"hash_540cddd637f71a5e", {
      #player: string, #eventtype: # "capture"});

    if(var_a84f97bf) {
      level thread popups::displayteammessagetoall(capturetime, string);
    }

    if(isDefined(string.pers[#"captures"])) {
      string.pers[#"captures"]++;
      string.captures = string.pers[#"captures"];

      if(string.pers[#"captures"] % 3 == 0) {
        string contracts::increment_contract(#"hash_47886fea64d2a151");
      }
    }

    string.pers[#"objectives"]++;
    string.objectives = string.pers[#"objectives"];

    if(level.warstarttime + 500 > capture_team) {
      string challenges::immediatecapture();
    }

    demo::bookmark(#"event", gettime(), string);
    potm::bookmark(#"event", gettime(), string);
    string stats::function_bb7eedf0(#"captures", 1);
    string globallogic_score::incpersstat(#"objectivescore", 1, 0, 1);

    if(is_true(getgametypesetting(#"contributioncapture"))) {
      string luinotifyevent(#"waypoint_captured", 2, self.objectiveid, string.var_759a143b);
      string.var_759a143b = undefined;
    }

    if(var_af8f6146) {
      string stats::function_dad108fa(#"captures_in_capture_area", 1);
      string contracts::increment_contract(#"contract_mp_objective_capture");
      globallogic::function_3305e557(string, "captureInArea", 0);
    }

    return;
  }

  string iprintlnbold("<dev string:xb5>");
}

function private is_zone_contested(gameobject) {
  if(!isDefined(gameobject)) {
    return false;
  }

  if(gameobject gameobjects::get_num_touching(game.attackers) > 0 && gameobject gameobjects::get_num_touching(game.defenders) > 0) {
    return true;
  }

  return false;
}

function award_capture_points_neutral(team) {
  level endon(#"game_ended");
  level notify("awardCapturePointsRunningNeutral" + self.owningzone.zone_index);
  level endon("awardCapturePointsRunningNeutral" + self.owningzone.zone_index);
  seconds = int(level.mission_bundle.msscoreinterval);

  if(!isDefined(seconds)) {
    seconds = 4;
  }

  score = int(level.mission_bundle.msscorevalue);

  if(!isDefined(score)) {
    score = 5;
  }

  while(!level.gameended) {
    wait seconds;
    hostmigration::waittillhostmigrationdone();
    globallogic_score::giveteamscoreforobjective(team, score);
  }
}

function award_capture_points(team) {
  level endon(#"game_ended");
  level notify(#"awardcapturepointsrunning");
  level endon(#"awardcapturepointsrunning");
  seconds = 1;
  score = 1;

  while(!level.gameended) {
    wait seconds;
    hostmigration::waittillhostmigrationdone();

    if(!isDefined(self)) {
      return;
    }

    if(!is_zone_contested(self)) {
      if(level.scoreperplayer) {
        score = self gameobjects::get_num_touching(team);
      }

      globallogic_score::giveteamscoreforobjective(team, score);
      level.wartotalsecondsinzone++;

      foreach(player in function_a1ef346b(team)) {
        if(!isDefined(player.touchtriggers[self.entnum])) {
          continue;
        }

        if(isDefined(player.pers[#"objtime"])) {
          player.pers[#"objtime"]++;
          player.objtime = player.pers[#"objtime"];
        }

        player stats::function_bb7eedf0(#"objective_time", 1);
        player globallogic_score::incpersstat(#"objectivetime", 1, 0, 1);
      }
    }
  }
}

function kill_while_contesting(victim, weapon) {
  self endon(#"disconnect");

  if(!isDefined(self.var_f58d97ed) || self.var_f58d97ed + 5000 < gettime()) {
    self.clearenemycount = 0;
  }

  self.clearenemycount++;
  self.var_f58d97ed = gettime();

  foreach(trigger in victim.touchtriggers) {
    foreach(zone in level.zones) {
      if(trigger == zone.trigger) {
        point = zone.trigger.useobj;
        found = 1;
        break;
      }
    }

    if(found) {
      break;
    }
  }

  waitframe(1);

  if(isDefined(point) && point gameobjects::get_num_touching(game.attackers) == 0 && self.clearenemycount >= 2) {
    scoreevents::processscoreevent(#"clear_2_attackers", self, victim, undefined);
    self challenges::function_e0f51b6f(weapon);
    self.clearenemycount = 0;
    self stats::function_dad108fa(#"hash_70320f43067a9540", 1);
    self stats::function_cc215323(#"hash_3c79e0a509575a03", 1);
  }
}

function setup_zone_exclusions() {
  if(!isDefined(level.levelwardisable)) {
    return;
  }

  foreach(nullzone in level.levelwardisable) {
    mindist = 1410065408;
    foundzone = undefined;

    foreach(zone in level.zones) {
      distance = distancesquared(nullzone.origin, zone.origin);

      if(distance < mindist) {
        foundzone = zone;
        mindist = distance;
      }
    }

    if(isDefined(foundzone) && foundzone == self) {
      if(!isDefined(foundzone.gameobject.exclusions)) {
        foundzone.gameobject.exclusions = [];
      }

      foundzone.gameobject.exclusions[foundzone.gameobject.exclusions.size] = nullzone;
    }
  }
}

function player_use_loop(gameobject) {
  self notify("player_use_loop_singleton" + gameobject.owningzone.zone_index);
  self endon("player_use_loop_singleton" + gameobject.owningzone.zone_index);
  player = self;
  player endon("use_stopped" + gameobject.owningzone.zone_index, "event_ended" + gameobject.owningzone.zone_index, #"death");

  if(!isDefined(player.playerrole)) {
    return;
  }

  fast_capture_threshold = 1.5;
  fast_decay_threshold = 1;
  attacker_capture_multiplier = isDefined(player.playerrole.attackercapturemultiplier) ? player.playerrole.attackercapturemultiplier : 1;
  defend_decay_multiplier = isDefined(player.playerrole.defenddecaymultiplier) ? player.playerrole.defenddecaymultiplier : 1;

  if(attacker_capture_multiplier <= fast_capture_threshold && defend_decay_multiplier <= fast_decay_threshold) {
    return;
  }

  while(true) {
    while(!isDefined(gameobject.userate) || isDefined(gameobject.userate) && gameobject.userate == 0 || !gameobject gameobjects::function_350d0352()) {
      wait 0.2;
    }

    any_capture_progress = 0;
    any_decay_progress = 0;
    measure_progress_end_time = level.time + 5000;

    while(level.time < measure_progress_end_time) {
      prev_progress = gameobject.curprogress;
      wait 1;

      if(gameobject.curprogress > prev_progress) {
        any_capture_progress = 1;
        continue;
      }

      if(gameobject.curprogress < prev_progress) {
        any_decay_progress = 1;
      }
    }

    if(isDefined(gameobject.userate) && gameobject.userate != 0 && gameobject gameobjects::function_350d0352()) {
      if(any_capture_progress && player.pers[#"team"] == game.attackers && attacker_capture_multiplier > fast_capture_threshold) {
        scoreevents::processscoreevent(#"fast_capture_progress", player, undefined, undefined);
        continue;
      }

      if(any_decay_progress && defend_decay_multiplier > fast_decay_threshold) {
        scoreevents::processscoreevent(#"fast_decay_progress", player, undefined, undefined);
      }
    }
  }
}

function private on_begin_use(sentient) {
  self checkifshouldupdatestatusplayback(sentient);
  self update_team_client_field();
}

function private isuserateelevated(touchlist) {
  foreach(touchinfo in touchlist) {
    if(touchinfo.userate > 1) {
      return true;
    }
  }

  return false;
}

function private isplayerinzonewithrole(touchlist, roletype) {
  foreach(touchinfo in touchlist) {
    if(isPlayer(touchinfo.player) && touchinfo.player.playerrole.rolename == roletype) {
      return true;
    }
  }

  return false;
}

function private update_team_userate_clientfield(zone) {
  if(!isDefined(zone)) {
    return;
  }

  if(is_zone_contested(zone)) {
    clientfield::set_world_uimodel("hudItems.missions.captureMultiplierStatus", 0);
    zone.lastteamtoownzone = "contested";
    return;
  }

  if(zone gameobjects::get_num_touching(game.attackers) > 0) {
    if(isplayerinzonewithrole(zone.users[game.attackers].touching.players, "objective")) {
      clientfield::set_world_uimodel("hudItems.missions.captureMultiplierStatus", 1);
    }

    zone.lastteamtoownzone = game.attackers;
    return;
  }

  if(zone gameobjects::get_num_touching(game.defenders) > 0 && zone.curprogress > 0) {
    if(isplayerinzonewithrole(zone.users[game.defenders].touching.players, "objective")) {
      clientfield::set_world_uimodel("hudItems.missions.captureMultiplierStatus", 2);
    }

    zone.lastteamtoownzone = game.defenders;
    return;
  }

  clientfield::set_world_uimodel("hudItems.missions.captureMultiplierStatus", 0);
}

function private update_team_client_field() {
  level.zonestatemask = 0;

  for(zi = 0; zi < level.zones.size; zi++) {
    gameobj = level.zones[zi].gameobject;

    if(!isDefined(gameobj)) {
      continue;
    }

    ownerteam = gameobj gameobjects::get_owner_team();
    state = 0;
    flags = 0;

    if(is_true(level.neutralzone)) {
      if(!gameobj gameobjects::function_350d0352() || !isDefined(level.teamindex[gameobj.var_a4926509])) {
        flags = 0;
      } else {
        flags = level.teamindex[gameobj.var_a4926509];
      }
    } else if(is_zone_contested(gameobj)) {
      state = 3;
    } else if(!gameobj gameobjects::function_350d0352() && gameobj gameobjects::get_num_touching(gameobj.var_a4926509) > 0) {
      if(gameobj.var_a4926509 == game.attackers) {
        state = 2;
        flags = level.teamindex[gameobj.var_a4926509];
      } else {
        state = 1;
      }
    } else if(gameobj gameobjects::function_b64fb43d() > 0) {
      if(ownerteam == game.attackers) {
        state = 2;
        flags = 1;
      } else {
        state = 1;
      }
    }

    level.zonestatemask |= state << zi * 2;
    gameobj gameobjects::set_flags(flags);
  }

  level clientfield::set("warzonestate", level.zonestatemask);
  update_team_userate_clientfield(self);
}

function update_caps_per_minute(lastownerteam) {
  if(!isDefined(self.capsperminute)) {
    self.numcaps = 0;
    self.capsperminute = 0;
  }

  if(!isDefined(lastownerteam) || lastownerteam == # "neutral") {
    return;
  }

  self.numcaps++;
  minutespassed = float(globallogic_utils::gettimepassed()) / 60000;

  if(isPlayer(self) && isDefined(self.timeplayed[#"total"])) {
    minutespassed = self.timeplayed[#"total"] / 60;
  }

  self.capsperminute = self.numcaps / minutespassed;

  if(self.capsperminute > self.numcaps) {
    self.capsperminute = self.numcaps;
  }
}

function is_score_boosting(player) {
  if(!level.rankedmatch) {
    return false;
  }

  if(player.capsperminute > level.playercapturelpm) {
    return true;
  }

  return false;
}

function on_decay_complete() {
  clientfield::set_world_uimodel("hudItems.missions.captureMultiplierStatus", 0);
  self gameobjects::set_flags(0);

  if(!is_true(self.var_670f7a7f)) {
    if(self gameobjects::get_num_touching(game.attackers) == 0 && self gameobjects::get_num_touching(game.defenders) > 0) {
      self.var_670f7a7f = 1;
      touchlist = arraycopy(self.users[game.defenders].touching.players);

      foreach(st in touchlist) {
        player_from_touchlist = gameobjects::function_73944efe(touchlist, st);

        if(!isDefined(player_from_touchlist)) {
          continue;
        }

        scoreevents::processscoreevent(#"hash_abbc936bf9059a6", player_from_touchlist, undefined, undefined);
      }
    }
  }
}

function score_capture_progress(var_277695bd) {
  trig = self.owningzone.trigger;
  players = getplayers();
  var_2a493d33 = undefined;

  for(i = 0; i < players.size; i++) {
    player = players[i];

    if(player.team == game.attackers) {
      player playsoundtoplayer(#"hash_554eb90f62c68b44", player);

      if(player istouching(trig)) {
        scoreevents::processscoreevent(#"war_capture_progress", player);
        player.pers[#"hash_156cd38474282f8d"]++;
        player function_ef823e71(11, player.pers[#"hash_156cd38474282f8d"]);

        if(!isDefined(var_2a493d33)) {
          var_2a493d33 = player;
        }
      }

      bb::function_95a5b5c2("control_segment_complete" + var_277695bd, self.zoneindex, player.team, player.origin, player);
      self notify(#"hash_68e3332f714afbbc");
    }
  }

  self callback::callback(#"hash_7de173a0523c27c9", var_2a493d33);
}

function on_use_update(team, progress, change) {
  if(is_true(level.capdecay) && !is_true(level.neutralzone)) {
    if(progress >= 0.666667) {
      if(self.stage == 2) {
        level.var_1cb1e802[self.owningzone.zoneindex]++;
        self.decayprogressmin = int(0.666667 * self.usetime);
        self score_capture_progress(2);
        self.stage = 3;
        level.var_9618a3e8 += isDefined(level.extrasegmenttime) ? level.extrasegmenttime : 0;
        game.stat[#"hash_2d36f0ab06fb245e"][team]++;
        util::function_a3f7de13(23, team, -1, function_da460cb8(self.var_f23c87bd));

        if(level.capturedzones == 1) {
          level notify(#"hash_15b8b6edc4ed3032", {
            #var_7090bf53: 0
          });
        }
      }
    } else if(progress >= 0.333333) {
      if(self.stage == 1) {
        level.var_1cb1e802[self.owningzone.zoneindex]++;
        self.decayprogressmin = int(0.333333 * self.usetime);
        self score_capture_progress(1);
        self.stage = 2;
        level.var_9618a3e8 += isDefined(level.extrasegmenttime) ? level.extrasegmenttime : 0;
        game.stat[#"hash_2d36f0ab06fb245e"][team]++;
        util::function_a3f7de13(23, team, -1, function_da460cb8(self.var_f23c87bd));
      }
    }
  }

  if(!is_true(level.neutralzone)) {
    update_timer(self.owningzone.zone_index, change);
  }

  if(change > 0 && self.currentlyunoccupied) {
    level.numzonesoccupied++;
    self.currentlyunoccupied = 0;
    players = getplayers();

    foreach(player in players) {
      if(player.team == game.attackers) {
        player playsoundtoplayer(#"hash_3cca41b3702f764a", player);
        continue;
      }

      player playsoundtoplayer(#"hash_2bb2a0ec776ba8f7", player);
    }
  } else if(change == 0 && !self.currentlyunoccupied) {
    level.numzonesoccupied--;
    self.currentlyunoccupied = 1;
  }

  if(progress > 0.05) {
    if(change > 0 && is_true(self.needsattackerstatusplayback)) {
      if(!is_true(level.neutralzone)) {
        if(level.numzonesoccupied <= 1) {
          soundkeyofs = "controlZ" + self.owningzone.zone_index + 1 + "CapturingOfs";
          soundkeydef = "controlZ" + self.owningzone.zone_index + 1 + "LosingDef";
          play_objective_audio(soundkeyofs, game.attackers);
          play_objective_audio(soundkeydef, game.defenders);
        } else {
          play_objective_audio("controlZMCapturingOfs", game.attackers);
          play_objective_audio("controlZMLosingDef", game.defenders);
        }
      }

      self.needsattackerstatusplayback = 0;
    } else if(change < 0 && is_true(self.needsdefenderstatusplayback)) {
      play_objective_audio("warLosingProgressOfs", game.attackers);
      play_objective_audio("warLosingProgressDef", game.defenders);
      self.needsdefenderstatusplayback = 0;
    }
  }

  if(isDefined(self.decayprogressmin) && change == 0 && (progress == 0.333333 || progress == 0.666667)) {
    if(clientfield::get_world_uimodel("hudItems.missions.captureMultiplierStatus") != 0) {
      clientfield::set_world_uimodel("hudItems.missions.captureMultiplierStatus", 0);
    }
  }

  if(change > 0) {
    self.var_670f7a7f = undefined;
  }

  var_beb65940 = self gameobjects::get_num_touching(game.attackers);
  var_d88c1173 = self gameobjects::get_num_touching(game.defenders);

  if(change == 0 && !is_true(self.var_670f7a7f)) {
    if(var_beb65940 == 0 && var_d88c1173 > 0) {
      self.var_670f7a7f = 1;

      foreach(st in self.users[game.defenders].touching.players) {
        scoreevents::processscoreevent(#"zone_progress_drained", st.player, undefined, undefined);
      }
    }
  }

  if(var_beb65940 == 0 && var_d88c1173 > 0) {
    if(!is_true(self.var_8b62ad00) && self.decayprogressmin === self.curprogress) {
      self update_team_client_field();
      self.var_8b62ad00 = 1;
    }

    return;
  }

  self.var_8b62ad00 = undefined;
}

function on_use_update_neutral(team, progress, change) {
  if(progress > 0.05) {
    if(is_true(self.needsallstatusplayback)) {
      if(change > 0) {
        if(self gameobjects::get_owner_team() == # "neutral") {
          play_objective_audio("warCapturingOfs", team);
          play_objective_audio("warCapturingDef", util::getotherteam(team));
          self.needsallstatusplayback = 0;
        } else {
          play_objective_audio("warLosingProgressDef", team);
          play_objective_audio("warLosingProgressOfs", util::getotherteam(team));
          self.needsallstatusplayback = 0;
        }

        return;
      }

      if(change < 0) {
        play_objective_audio("warLosingProgressOfs", team);
        play_objective_audio("warLosingProgressDef", util::getotherteam(team));
        self.needsallstatusplayback = 0;
      }
    }
  }
}

function private set_ui_team() {
  wait 0.05;

  if(game.attackers == # "allies" || is_true(level.neutralzone)) {
    clientfield::set_world_uimodel("hudItems.war.attackingTeam", 1);
    return;
  }

  clientfield::set_world_uimodel("hudItems.war.attackingTeam", 2);
}

function pause_time() {
  if(level.timepauseswheninzone && !is_true(level.timerpaused)) {
    globallogic_utils::pausetimer();
    level.timerpaused = 1;
  }
}

function resume_time() {
  if(level.timepauseswheninzone && is_true(level.timerpaused)) {
    globallogic_utils::resumetimer();
    level.timerpaused = 0;
  }
}

function update_timer(zoneindex, change) {
  if(!isDefined(level.zones[zoneindex].gameobject)) {
    return;
  }

  if(change > 0 || is_zone_contested(level.zones[zoneindex].gameobject)) {
    level.zonepauseinfo[zoneindex] = 1;
    pause_time();
    return;
  }

  level.zonepauseinfo[zoneindex] = 0;

  for(zi = 0; zi < level.zones.size; zi++) {
    if(is_true(level.zonepauseinfo[zi])) {
      return;
    }
  }

  resume_time();
}

function function_caff2d60() {
  level endon(#"game_ended");
  self notify(#"hash_2562ed6d6d163c1a");
  self endon(#"hash_2562ed6d6d163c1a");

  while(true) {
    var_af32dd2d = 1;

    for(i = 0; i < level.zones.size; i++) {
      if(!isDefined(level.zones[i].gameobject)) {
        continue;
      }

      if(!is_zone_contested(level.zones[i].gameobject)) {
        var_af32dd2d = 0;
        level.var_46ff851e = 0;
        break;
      }
    }

    if(var_af32dd2d) {
      if(!is_true(level.var_46ff851e)) {
        level.var_46ff851e = 1;
        play_objective_audio("controlContestedOfsAll", game.attackers);
        play_objective_audio("controlContestedDefAll", game.defenders);
      }
    } else {
      if(is_zone_contested(level.zones[0].gameobject)) {
        if(!is_true(level.var_b9d36d8e[0])) {
          level.var_b9d36d8e[0] = 1;
          play_objective_audio("controlContestedOfsA", game.attackers);
          play_objective_audio("controlContestedDefA", game.defenders);
        }
      } else {
        level.var_b9d36d8e[0] = 0;
      }

      if(is_zone_contested(level.zones[1].gameobject)) {
        if(!is_true(level.var_b9d36d8e[1])) {
          level.var_b9d36d8e[1] = 1;
          play_objective_audio("controlContestedOfsB", game.attackers);
          play_objective_audio("controlContestedDefB", game.defenders);
        }
      } else {
        level.var_b9d36d8e[1] = 0;
      }
    }

    wait 0.2;
  }
}

function function_68387604(var_c1e98979) {
  gamemodedata = spawnStruct();
  gamemodedata.var_20de6a02 = game.lives[#"allies"];
  gamemodedata.var_be1de2ab = game.lives[#"axis"];

  switch (var_c1e98979) {
    case 2:
      gamemodedata.wintype = "time_limit_reached";
      break;
    case 1:
      gamemodedata.wintype = "captured_all_zones";
      break;
    case 6:
      gamemodedata.wintype = "no_lives_left";
      break;
    case 9:
    case 10:
    default:
      gamemodedata.wintype = "NA";
      break;
  }

  gamemodedata.remainingtime = globallogic_utils::gettimeremaining();

  if(gamemodedata.remainingtime < 0) {
    gamemodedata.remainingtime = 0;
  }

  bb::function_bf5cad4e(gamemodedata);
}

function private function_da460cb8(var_b6ec55d) {
  if(var_b6ec55d == "control_0") {
    var_2989dcef = 1;
  } else if(var_b6ec55d == "control_1") {
    var_2989dcef = 2;
  }

  return var_2989dcef;
}

function private on_dead_event(team) {
  if(team != "all") {
    return;
  }

  round::set_flag("tie");
  thread globallogic::end_round(6);
}

function private function_4c593022() {
  roundsplayed = util::getroundsplayed() + 1;

  foreach(player in level.players) {
    if(player.team != # "spectator") {
      player function_ef823e71(8, player.pers[#"damagedone"], roundsplayed);
    }
  }
}

function private function_5416d912(player) {
  level endon(#"game_ended");

  for(timetowait = 0; true; timetowait = 0) {
    timetowait++;

    if(!level.inprematchperiod) {
      var_7f654195 = gettime();

      foreach(player in level.players) {
        if(isalive(player)) {
          globallogic::function_3305e557(player, "timeAlive", 0);
        }
      }

      var_ba0dde27 = gettime() - var_7f654195;
      timetowait -= var_ba0dde27;
    }

    if(timetowait > 0) {
      wait timetowait;
    }
  }
}

function private function_7996e36d() {
  foreach(player in level.players) {
    if(player.team != # "spectator") {
      if(!isDefined(game.var_629fe99f[player.playername])) {
        game.var_629fe99f[player.playername] = [];
      }

      game.var_629fe99f[player.playername][#"timealive"] = player.pers[#"timealive"];
      game.var_629fe99f[player.playername][#"shotsfired"] = player.pers[#"shotsfired"];
      game.var_629fe99f[player.playername][#"shotshit"] = player.pers[#"shotshit"];
      game.var_629fe99f[player.playername][#"hash_281165a5744a0185"] = player.pers[#"hash_281165a5744a0185"];
      game.var_629fe99f[player.playername][#"hash_a8c7a84a8f7e333"] = player.pers[#"hash_a8c7a84a8f7e333"];
      game.var_629fe99f[player.playername][#"hash_22770dcff96626d2"] = player.pers[#"hash_22770dcff96626d2"];
      game.var_629fe99f[player.playername][#"hash_2d873e8313116c20"] = player.pers[#"hash_2d873e8313116c20"];
      game.var_629fe99f[player.playername][#"captureInArea"] = player.pers[#"captureInArea"];
      game.var_629fe99f[player.playername][#"cur_total_kill_streak"] = player.pers[#"cur_total_kill_streak"];
      game.var_629fe99f[player.playername][#"best_kill_streak"] = player.pers[#"best_kill_streak"];
    }
  }
}

function private function_f9bfc5ca(player) {
  if(game.var_629fe99f.size == 0 || !isDefined(game.var_629fe99f[player.playername])) {
    if(!isDefined(player.pers[#"timealive"])) {
      player.pers[#"timealive"] = 0;
    }

    if(!isDefined(player.pers[#"shotsfired"])) {
      player.pers[#"shotsfired"] = 0;
    }

    if(!isDefined(player.pers[#"shotshit"])) {
      player.pers[#"shotshit"] = 0;
    }

    if(!isDefined(player.pers[#"hash_281165a5744a0185"])) {
      player.pers[#"hash_281165a5744a0185"] = 0;
    }

    if(!isDefined(player.pers[#"hash_a8c7a84a8f7e333"])) {
      player.pers[#"hash_a8c7a84a8f7e333"] = 0;
    }

    if(!isDefined(player.pers[#"hash_22770dcff96626d2"])) {
      player.pers[#"hash_22770dcff96626d2"] = 0;
    }

    if(!isDefined(player.pers[#"hash_2d873e8313116c20"])) {
      player.pers[#"hash_2d873e8313116c20"] = 0;
    }

    if(!isDefined(player.pers[#"captureInArea"])) {
      player.pers[#"captureInArea"] = 0;
    }

    return;
  }

  player.pers[#"timealive"] = game.var_629fe99f[player.playername][#"timealive"];
  player.pers[#"shotsfired"] = game.var_629fe99f[player.playername][#"shotsfired"];
  player.pers[#"shotshit"] = game.var_629fe99f[player.playername][#"shotshit"];
  player.pers[#"hash_281165a5744a0185"] = game.var_629fe99f[player.playername][#"hash_281165a5744a0185"];
  player.pers[#"hash_a8c7a84a8f7e333"] = game.var_629fe99f[player.playername][#"hash_a8c7a84a8f7e333"];
  player.pers[#"hash_22770dcff96626d2"] = game.var_629fe99f[player.playername][#"hash_22770dcff96626d2"];
  player.pers[#"hash_2d873e8313116c20"] = game.var_629fe99f[player.playername][#"hash_2d873e8313116c20"];
  player.pers[#"captureInArea"] = game.var_629fe99f[player.playername][#"captureInArea"];
  player.pers[#"cur_total_kill_streak"] = game.var_629fe99f[player.playername][#"cur_total_kill_streak"];
  player.pers[#"best_kill_streak"] = game.var_629fe99f[player.playername][#"best_kill_streak"];
  player setplayercurrentstreak(player.pers[#"cur_total_kill_streak"]);
}

function function_ea86257d(gameobject, starting = 0) {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(gameobject)) {
    return;
  }

  if(starting) {
    self thread function_15cbf89(gameobject);
    return;
  }

  self thread function_4242921c(gameobject);
}

function function_15cbf89(gameobject) {
  self notify("78ab5d20700457ea");
  self endon("78ab5d20700457ea");
  self endon(#"death", #"disconnect", #"hash_580789b91ba9f984");
  gameobject.trigger endon(#"destroyed", #"death");
  level endon(#"game_ended");
  waitframe(1);

  while(true) {
    currentprogress = gameobject.curprogress;
    var_f802a6b1 = gameobject.usetime;
    currentpercentage = currentprogress / var_f802a6b1;
    var_5b37f77b = gameobject.var_a4926509;
    iscontested = isDefined(gameobject.contested) ? gameobject.contested : 0;

    if(iscontested) {
      self function_d24432a4("cap_contested");
      self function_2ba2d8e5("cap_contested");
    } else if(var_5b37f77b != self.team) {
      self function_2ba2d8e5("cap_drain");
    } else if(currentpercentage >= 0.66) {
      self function_d24432a4("cap_high");
      self function_2ba2d8e5("cap_war_percent_75");
    } else if(currentpercentage >= 0.33) {
      self function_d24432a4("cap_mid");
      self function_2ba2d8e5("cap_war_percent_50");
    } else if(currentpercentage >= 0) {
      self function_d24432a4("cap_low");
      self function_2ba2d8e5("cap_war_percent_25");
    }

    waitframe(1);
  }
}

function function_4242921c(gameobject, success = 0) {
  if(isDefined(gameobject.ownerteam) && gameobject.ownerteam === self.team) {
    if(self.var_a022edea != "cap_contested") {
      self function_2ba2d8e5("");
      self notify(#"hash_580789b91ba9f984");
      self.var_b3890fdf = 0;
      return;
    }
  }

  if(success) {
    self function_2ba2d8e5("cap_war_success");
    return;
  }

  self function_2ba2d8e5("cap_exit");
  self notify(#"hash_580789b91ba9f984");
  self.var_b3890fdf = 0;
}

function function_2ba2d8e5(state) {
  if(!isDefined(self.var_a022edea)) {
    self.var_a022edea = "";
  }

  if(is_true(level.var_2179a6bf)) {
    return;
  }

  if(state != self.var_a022edea) {
    self.var_a022edea = state;
    globallogic_audio::function_c246758e(state);
  }
}

function function_d24432a4(state) {
  if(!isDefined(self.var_b3890fdf)) {
    self.var_b3890fdf = 0;
  }

  if(game.state != # "playing") {
    return;
  }

  str_alias = undefined;

  switch (state) {
    case # "cap_low":
      str_alias = # "hash_1c5192b85675532d";
      n_waittime = 2.5;
      break;
    case # "cap_mid":
      str_alias = # "hash_1c5191b85675517a";
      n_waittime = 2.5;
      break;
    case # "cap_high":
      str_alias = # "hash_1c518cb8567548fb";
      n_waittime = 1.25;
      break;
    case # "cap_drain":
      str_alias = # "hash_1c518fb856754e14";
      n_waittime = 2.5;
      break;
    case # "cap_contested":
      str_alias = # "hash_43014e1f7354354f";
      n_waittime = 1.25;
      break;
  }

  if(is_true(level.var_2179a6bf)) {
    n_waittime = 2;
  }

  if(isDefined(str_alias)) {
    var_bb0c6711 = gettime();

    if(self.var_b3890fdf <= var_bb0c6711) {
      if(self.var_b3890fdf === 0) {
        self.var_b3890fdf = var_bb0c6711 - 50;
      }

      self.var_b3890fdf += int(n_waittime * 1000);
      self playlocalsound(str_alias);
    }
  }
}