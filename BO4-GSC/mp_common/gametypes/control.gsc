/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\control.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\challenges_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\contracts_shared;
#include scripts\core_common\demo_shared;
#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\globallogic\globallogic_score;
#include scripts\core_common\hostmigration_shared;
#include scripts\core_common\persistence_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\popups_shared;
#include scripts\core_common\potm_shared;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\sound_shared;
#include scripts\core_common\spawning_shared;
#include scripts\core_common\trigger_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\bb;
#include scripts\mp_common\challenges;
#include scripts\mp_common\gametypes\battlechatter;
#include scripts\mp_common\gametypes\ct_tutorial_skirmish;
#include scripts\mp_common\gametypes\globallogic;
#include scripts\mp_common\gametypes\globallogic_audio;
#include scripts\mp_common\gametypes\globallogic_defaults;
#include scripts\mp_common\gametypes\globallogic_score;
#include scripts\mp_common\gametypes\globallogic_spawn;
#include scripts\mp_common\gametypes\globallogic_utils;
#include scripts\mp_common\gametypes\hud_message;
#include scripts\mp_common\gametypes\match;
#include scripts\mp_common\gametypes\round;
#include scripts\mp_common\player\player_utils;
#include scripts\mp_common\spawnbeacon;
#include scripts\mp_common\userspawnselection;
#include scripts\mp_common\util;

#namespace mission_koth;

event_handler[gametype_init] main(eventstruct) {
  globallogic::init();
  util::registertimelimit(0, 1440);
  util::registerscorelimit(0, 2000);
  util::registernumlives(0, 100);
  util::registerroundswitch(0, 9);
  util::registerroundlimit(0, 10);
  util::registerroundwinlimit(0, 10);
  util::registerscorelimit(0, 5000);
  globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
  game.objective_gained_sound = "mpl_flagcapture_sting_friend";
  game.objective_lost_sound = "mpl_flagcapture_sting_enemy";
  level.onstartgametype = &on_start_gametype;
  level.onspawnplayer = &on_spawn_player;
  player::function_cf3aa03d(&on_player_killed);
  player::function_3c5cc656(&function_610d3790);
  level.ontimelimit = &on_time_limit;
  level.onendgame = &on_end_game;
  level.ononeleftevent = &ononeleftevent;
  level.onendround = &on_end_round;
  level.gettimelimit = &gettimelimit;
  level.var_cdb8ae2c = &function_a8da260c;
  level.ondeadevent = &on_dead_event;
  level.doprematch = 1;
  level.overrideteamscore = 1;
  level.warstarttime = 0;
  level.var_f5a73a96 = 1;
  level.takelivesondeath = 1;
  level.b_allow_vehicle_proximity_pickup = 1;
  level.scoreroundwinbased = getgametypesetting(#"cumulativeroundscores") == 0;
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
  level.playercapturelpm = getgametypesetting(#"maxplayereventsperminute");
  level.autodecaytime = isDefined(getgametypesetting(#"autodecaytime")) ? getgametypesetting(#"autodecaytime") : undefined;
  level.timerpaused = 0;
  level.zonepauseinfo = [];
  level.var_b9d36d8e = [];
  level.var_46ff851e = 0;
  level.numzonesoccupied = 0;
  level.flagcapturerateincrease = getgametypesetting(#"flagcapturerateincrease");
  level.bonuslivesforcapturingzone = isDefined(getgametypesetting(#"bonuslivesforcapturingzone")) ? getgametypesetting(#"bonuslivesforcapturingzone") : 0;
  globallogic_audio::set_leader_gametype_dialog("startControl", "hcStartControl", "controlOrdersOfs", "controlOrdersDef", "bbStartControl", "hcbbStartControl");
  register_clientfields();
  callback::on_connect(&on_player_connect);
  level.audiocues = [];
  level.mission_bundle = getscriptbundle("mission_settings_control");
  globallogic_spawn::addsupportedspawnpointtype("control");
  game.strings[#"hash_bab7f2001813aa7"] = #"hash_15294f07ee519376";
  game.strings[#"hash_5db475ae2d5164e1"] = #"hash_3a9b595d0bf81f13";
  hud_message::function_36419c2(1, game.strings[#"hash_bab7f2001813aa7"], game.strings[#"hash_5db475ae2d5164e1"]);
  level.audioplaybackthrottle = int(level.mission_bundle.msaudioplaybackthrottle);

  if(!isDefined(level.audioplaybackthrottle)) {
    level.audioplaybackthrottle = 5000;
  }

  if(util::function_8570168d()) {
    ct_tutorial_skirmish::init();
  }

  level.var_1aef539f = &function_a800815;
  level.var_d3a438fb = &function_d3a438fb;
}

updatespawns() {
  globallogic_spawn::function_c40af6fa();
  globallogic_spawn::addsupportedspawnpointtype("control");
  var_66eb1393 = [];

  foreach(zone in level.zones) {
    if(!isDefined(zone.gameobject)) {
      continue;
    }

    var_66eb1393[zone.zone_index] = isDefined(zone.gameobject.iscaptured) && zone.gameobject.iscaptured;
  }

  if(var_66eb1393.size == 2) {
    if(var_66eb1393[0]) {
      globallogic_spawn::addsupportedspawnpointtype("control_attack_add_1");
      globallogic_spawn::addsupportedspawnpointtype("control_defend_add_1");
    } else {
      globallogic_spawn::addsupportedspawnpointtype("control_attack_remove_0");
      globallogic_spawn::addsupportedspawnpointtype("control_defend_remove_0");
    }

    if(var_66eb1393[1]) {
      globallogic_spawn::addsupportedspawnpointtype("control_attack_add_0");
      globallogic_spawn::addsupportedspawnpointtype("control_defend_add_0");
    } else {
      globallogic_spawn::addsupportedspawnpointtype("control_attack_remove_1");
      globallogic_spawn::addsupportedspawnpointtype("control_defend_remove_1");
    }
  }

  globallogic_spawn::addspawns();
}

register_clientfields() {
  clientfield::register("world", "warzone", 1, 5, "int");
  clientfield::register("world", "warzonestate", 1, 10, "int");
  clientfield::register("worlduimodel", "hudItems.missions.captureMultiplierStatus", 1, 2, "int");
  clientfield::register("worlduimodel", "hudItems.war.attackingTeam", 1, 2, "int");
}

on_time_limit() {
  if(level.zones.size == level.capturedzones) {
    level thread globallogic::end_round(1);
    return;
  }

  if(isDefined(level.neutralzone) && level.neutralzone) {
    round::function_870759fb();
  } else {
    round::set_winner(game.defenders);
  }

  thread globallogic::end_round(2);
}

on_spawn_player(predictedspawn) {
  spawning::onspawnplayer(predictedspawn);
  self.currentzoneindex = undefined;

  if(level.numlives > 0) {
    clientfield::set_player_uimodel("hudItems.playerLivesCount", game.lives[self.team]);
  }
}

gettimelimit() {
  timelimit = globallogic_defaults::default_gettimelimit();

  if(level.usingextratime) {
    return (timelimit + level.extratime);
  }

  return timelimit;
}

on_end_game(var_c1e98979) {
  if(level.scoreroundwinbased) {
    globallogic_score::updateteamscorebyroundswon();
    winner = globallogic::determineteamwinnerbygamestat("roundswon");
  } else {
    winner = globallogic::determineteamwinnerbyteamscore();
  }

  match::function_af2e264f(winner);
}

on_end_round(var_c1e98979) {
  if(globallogic::function_8b4fc766(var_c1e98979)) {
    winning_team = round::get_winning_team();
    globallogic_score::giveteamscoreforobjective(winning_team, 1);
  }

  if(var_c1e98979 == 6) {
    winning_team = round::get_winning_team();
    challenges::last_man_defeat_3_enemies(winning_team);
  }

  function_68387604(var_c1e98979);
}

function_d126ce1b() {
  if(!isDefined(self.touchtriggers)) {
    return true;
  }

  if(self.touchtriggers.size == 0) {
    return true;
  }

  return false;
}

function_610d3790(einflictor, victim, idamage, weapon) {
  if(victim.var_4ef33446 === 1) {
    return;
  }

  var_376742ed = 1;

  if(isDefined(weapon) && isDefined(level.iskillstreakweapon)) {
    if([
        [level.iskillstreakweapon]
      ](weapon) || isDefined(weapon.statname) && [
        [level.iskillstreakweapon]
      ](getweapon(weapon.statname))) {
      var_376742ed = 0;
    }
  }

  attacker = self;
  var_1cfdf798 = isDefined(victim.lastattacker) ? victim.lastattacker === attacker : 0;

  if(!isplayer(attacker) || level.capturetime && victim function_d126ce1b() && attacker function_d126ce1b() || attacker.pers[#"team"] == victim.pers[#"team"]) {
    if(var_376742ed) {
      victim function_580fd2d5(attacker, weapon);
    }

    return;
  }

  foreach(controlzone in level.zones) {
    radius = (controlzone.trigger.maxs[0] - controlzone.trigger.mins[0]) * 0.5;
    var_c7c5e631 = victim thread globallogic_score::function_7d830bc(einflictor, attacker, weapon, controlzone.trigger, radius, controlzone.team, controlzone.trigger);

    if(var_c7c5e631 === 1) {
      zone = controlzone;
    }
  }

  medalgiven = 0;
  scoreeventprocessed = 0;
  ownerteam = undefined;

  if(level.capturetime == 0) {
    if(!isDefined(zone)) {
      return;
    }

    ownerteam = zone.gameobject.ownerteam;

    if(!isDefined(ownerteam) || ownerteam == #"neutral") {
      return;
    }
  }

  if(!victim function_d126ce1b() || level.capturetime == 0 && victim istouching(zone.trigger)) {
    attacker challenges::function_2f462ffd(victim, weapon, einflictor, zone.gameobject);
    attacker.pers[#"objectiveekia"]++;
    attacker.objectiveekia = attacker.pers[#"objectiveekia"];
    attacker.pers[#"objectives"]++;
    attacker.objectives = attacker.pers[#"objectives"];

    if(victim.team == game.attackers && attacker.team == game.defenders) {
      attacker thread challenges::killedbaseoffender(zone.gameobject, weapon, einflictor);

      if(var_1cfdf798 && var_376742ed) {
        attacker thread kill_while_contesting(victim, weapon);
        scoreevents::processscoreevent(#"kill_enemy_that_is_capping_your_objective", attacker, self, weapon);
      }
    }

    if(victim.team == game.defenders && attacker.team == game.attackers) {
      attacker thread challenges::killedbasedefender(zone.gameobject);

      if(var_376742ed) {
        if(var_1cfdf798 && (!attacker function_d126ce1b() || level.capturetime == 0 && attacker istouching(zone.trigger))) {
          scoreevents::processscoreevent(#"war_killed_enemy_while_capping_control", attacker, victim, weapon);
        }

        scoreevents::processscoreevent(#"war_killed_defender_in_zone", attacker, victim, weapon);
      }
    }

    if(var_1cfdf798 && var_376742ed) {
      attacker challenges::function_82bb78f7(weapon);
    }

    return;
  }

  if(var_376742ed) {
    victim function_580fd2d5(attacker, weapon);
  }
}

on_player_killed(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  if(isDefined(self) && isDefined(self.currentzoneindex)) {
    bb::function_95a5b5c2("exited_control_point_death", self.zoneindex, self.team, self.origin, self);
    self.currentzoneindex = undefined;
    self notify(#"hash_68e3332f714afbbc");
  }

  if(!isDefined(self) || !isDefined(attacker) || !isplayer(attacker)) {
    return;
  }

  if(attacker != self && isDefined(self.pers) && self.pers[#"lives"] == 0 && attacker.team != self.team) {
    scoreevents::processscoreevent(#"eliminated_enemy", attacker, self, weapon);

    if(!isDefined(level.var_c473f6ca)) {
      level.var_c473f6ca = [];
    }

    if(!isDefined(level.var_c473f6ca[self.team])) {
      level.var_c473f6ca[self.team] = 0;
    }

    level.var_c473f6ca[self.team]++;

    if(level.playercount[self.team] == level.var_c473f6ca[self.team]) {
      attacker stats::function_dad108fa(#"eliminated_final_enemy", 1);
    }
  }
}

function_a800815(victim, attacker) {
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

function_d3a438fb(entity) {
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

function_580fd2d5(attacker, weapon) {
  if(!isplayer(attacker)) {
    return;
  }

  foreach(zone in level.zones) {
    if(!isDefined(zone.trigger)) {
      continue;
    }

    if(!(isDefined(zone.gameobject.iscaptured) && zone.gameobject.iscaptured) && self istouching(zone.trigger, (350, 350, 100))) {
      if(self.team == game.attackers && attacker.team == game.defenders) {
        scoreevents::processscoreevent(#"killed_attacker", attacker, self, weapon);
      }

      if(self.team == game.defenders && attacker.team == game.attackers) {
        scoreevents::processscoreevent(#"killed_defender", attacker, self, weapon);
      }
    }
  }
}

get_player_userate(use_object) {
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

on_player_connect() {
  self gameobjects::setplayergametypeuseratecallback(&get_player_userate);
}

private use_start_spawns() {
  level waittill(#"grace_period_ending");
  level.usestartspawns = 0;
}

on_start_gametype() {
  level.usingextratime = 0;
  level.wartotalsecondsinzone = 0;
  level.round_winner = undefined;
  setup_objectives();
  globallogic_score::resetteamscores();
  level.zonemask = 0;
  level.zonestatemask = 0;
  thread use_start_spawns();
  userspawnselection::supressspawnselectionmenuforallplayers();
  setup_zones();
  updatespawns();
  thread set_ui_team();
  thread main_loop();
  thread function_caff2d60();
}

setup_zones() {
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
    zone.trigger trigger::function_1792c799(16);
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

    if(isDefined(level.neutralzone) && level.neutralzone) {
      ownerteam = #"neutral";
    }

    zone.gameobject = gameobjects::create_use_object(ownerteam, zone.trigger, visuals, (0, 0, 0), "control_" + zi);
    zone.gameobject gameobjects::set_objective_entity(zone);
    zone.gameobject gameobjects::disable_object();
    zone.gameobject gameobjects::set_model_visibility(0);
    zone.gameobject.owningzone = zone;
    zone.trigger.useobj = zone.gameobject;
    zone.gameobject.lastteamtoownzone = #"neutral";
    zone.gameobject.currentlyunoccupied = 1;
    zone.gameobject.var_a0ff5eb8 = !level.flagcapturerateincrease;
    zone.zoneindex = zi;
    zone.scores = [];

    foreach(team, _ in level.teams) {
      zone.scores[team] = 0;
    }

    zone setup_zone_exclusions();
  }

  if(globallogic_utils::print_map_errors()) {
    return 0;
  }
}

private function_a8da260c() {
  spawning::add_spawn_points(game.attackers, "mp_strong_spawn_attacker_region_1");
  spawning::add_spawn_points(game.defenders, "mp_strong_spawn_defender_region_1");
  spawning::updateallspawnpoints();

  if(level.usestartspawns) {
    spawning::add_start_spawn_points(game.attackers, "mp_war_spawn_attacker_zone_1_start");
    spawning::add_start_spawn_points(game.defenders, "mp_war_spawn_defender_zone_1_start");
  }
}

compare_zone_indicies(zone_a, zone_b) {
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

get_zone_array() {
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

update_objective_hint_message(attackersmsg, defendersmsg) {
  gametype = util::get_game_type();

  foreach(team, _ in level.teams) {
    if(team == game.attackers) {
      game.strings["objective_hint_" + team] = attackersmsg;
      continue;
    }

    game.strings["objective_hint_" + team] = defendersmsg;
  }
}

setup_objectives() {
  level.objectivehintpreparezone = #"mp/control_koth";
  level.objectivehintcapturezone = #"mp/capture_koth";
  level.objectivehintdefendhq = #"mp/defend_koth";

  if(level.zonespawntime) {
    update_objective_hint_message(level.objectivehintpreparezone);
  } else {
    update_objective_hint_message(level.objectivehintcapturezone);
  }

  game.strings[game.attackers + "_mission_win"] = #"hash_6ed10cd957ecbde6";
  game.strings[game.attackers + "_mission_loss"] = #"hash_504843f8a8fe0230";
  game.strings[game.defenders + "_mission_win"] = #"hash_74e465610ac830ce";
  game.strings[game.defenders + "_mission_loss"] = #"hash_7d37cafde0ab4ecd";
}

toggle_zone_effects(enabled) {
  if(enabled) {
    level.zonemask |= 1 << self.zone_index;
  } else {
    level.zonemask &= ~(1 << self.zone_index);
  }

  level.zonestatemask &= ~(3 << self.zone_index);
  level clientfield::set("warzone", level.zonemask);
  level clientfield::set("warzonestate", level.zonestatemask);
}

main_loop() {
  level endon(#"game_ended");

  while(level.inprematchperiod) {
    waitframe(1);
  }

  thread hide_timer_on_game_end();
  wait 1;
  sound::play_on_players("mp_suitcase_pickup");

  if(level.zonespawntime && !(isDefined(level.neutralzone) && level.neutralzone)) {
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

  if(isDefined(level.neutralzone) && level.neutralzone) {
    update_objective_hint_message(#"mp/capture_strong", #"mp/capture_strong");
  } else {
    update_objective_hint_message(#"mp/capture_strong", #"mp/defend_strong");
  }

  sound::play_on_players("mpl_hq_cap_us");
  thread audio_loop();
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

audio_loop() {
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

function_23bedaa1() {
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

function_31c391cf() {
  util::wait_network_frame();
  util::wait_network_frame();
  self toggle_zone_effects(1);
}

capture_loop(zone) {
  level endon(#"game_ended");
  level.warstarttime = gettime();
  zone.gameobject gameobjects::set_flags(0);
  zone.gameobject gameobjects::enable_object();
  objective_onentity(zone.gameobject.objectiveid, zone.objectiveanchor);
  zone.gameobject.capturecount = 0;
  zone.gameobject gameobjects::allow_use(#"enemy");
  zone.gameobject gameobjects::set_use_time(level.capturetime);
  zone.gameobject gameobjects::set_use_text(#"mp/capturing_objective");
  numtouching = zone.gameobject get_num_touching();
  zone.gameobject gameobjects::set_visible_team(#"any");
  zone.gameobject gameobjects::set_model_visibility(1);
  zone.gameobject gameobjects::must_maintain_claim(0);
  zone.gameobject gameobjects::can_contest_claim(1);
  zone.gameobject.decayprogress = 1;
  zone.gameobject gameobjects::set_decay_time(level.capturetime);
  zone.autodecaytime = level.autodecaytime;

  if(isDefined(level.neutralzone) && level.neutralzone) {
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

  if(isDefined(level.neutralzone) && level.neutralzone) {
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
  zone.gameobject gameobjects::set_visible_team(#"any");
  zone.gameobject gameobjects::allow_use(#"none");
  zone.gameobject gameobjects::set_owner_team(#"neutral");
  zone.gameobject gameobjects::set_model_visibility(0);
  zone.gameobject gameobjects::must_maintain_claim(0);
  zone.gameobject.decayprogress = 1;
  zone.autodecaytime = level.autodecaytime;
  objective_setstate(zone.gameobject.objectiveid, "done");
  zone toggle_zone_effects(0);
  spawn_beacon::removeprotectedzone(zone.trigger);
  zone.gameobject gameobjects::disable_object();
  profilestop();
}

private get_num_touching() {
  numtouching = 0;

  foreach(team, _ in level.teams) {
    numtouching += self.numtouching[team];
  }

  return numtouching;
}

private hide_timer_on_game_end() {
  level notify(#"hide_timer_on_game_end");
  level endon(#"hide_timer_on_game_end");
  level waittill(#"game_ended");
  setmatchflag("bomb_timer_a", 0);
}

private give_held_credit(touchlist, team) {
  wait 0.05;
  util::waittillslowprocessallowed();

  foreach(touch in touchlist) {
    player = gameobjects::function_73944efe(touchlist, touch);

    if(!isDefined(player)) {}
  }
}

private checkifshouldupdateattackerstatusplayback(sentient) {
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

private checkifshouldupdatedefenderstatusplayback(sentient) {
  if(sentient.team != game.defenders) {
    return;
  }

  if(isDefined(self.lastteamtoownzone) && self.lastteamtoownzone == sentient.team) {
    return;
  }

  self.needsdefenderstatusplayback = 1;
}

private checkifshouldupdatestatusplayback(sentient) {
  if(isDefined(level.neutralzone) && level.neutralzone) {
    self.needsallstatusplayback = 1;
    return;
  }

  checkifshouldupdateattackerstatusplayback(sentient);
  checkifshouldupdatedefenderstatusplayback(sentient);
}

private function_bcaf6836() {
  if(!isDefined(self.contested)) {
    self.contested = 0;
  }

  var_464f0169 = self.contested;
  self.contested = is_zone_contested(self);

  if(self.contested) {
    if(!var_464f0169) {
      foreach(playerlist in self.touchlist) {
        foreach(struct in playerlist) {
          player = struct.player;

          if(isDefined(player) && isplayer(player) && (isDefined(player.var_c8d27c06) ? player.var_c8d27c06 : 0) < gettime()) {
            player playsoundtoplayer(#"mpl_control_capture_contested", player);
            player.var_c8d27c06 = gettime() + 5000;
          }
        }
      }
    }
  }
}

private on_touch_use(sentient) {
  if(isplayer(sentient)) {
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

private function_88acffae(sentient) {
  sentient endon(#"hash_68e3332f714afbbc");

  if(!isplayer(sentient)) {
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

private on_end_touch_use(sentient) {
  sentient notify("use_stopped" + self.owningzone.zone_index);
  self update_team_client_field();
  self thread function_88acffae(sentient);
}

private on_end_use(team, sentient, success) {
  sentient notify("event_ended" + self.owningzone.zone_index);
  self update_team_client_field();
}

private play_objective_audio(audiocue, team) {
  if(isDefined(level.audiocues[audiocue])) {
    if(level.audiocues[audiocue] + level.audioplaybackthrottle > gettime()) {
      return;
    }
  }

  level.audiocues[audiocue] = gettime();
  thread globallogic_audio::leader_dialog(audiocue, team, undefined, "gamemode_objective", undefined, "kothActiveDialogBuffer");
}

private process_zone_capture_audio(zone, capture_team) {
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

ononeleftevent(team) {
  index = util::function_ff74bf7(team);
  players = level.players;

  if(index == players.size) {
    return;
  }

  player = players[index];
  enemyteam = util::get_enemy_team(team);

  if(level.alivecount[enemyteam] > 2) {
    player.var_66cfa07f = 1;
  }

  util::function_5a68c330(17, player.team, player getentitynumber());
}

private on_zone_capture(sentient) {
  level.nzones--;
  capture_team = sentient.team;
  capturetime = gettime();
  string = #"hash_6d6f47aad6be619f";

  if(!isDefined(self.lastcaptureteam) || self.lastcaptureteam != capture_team) {
    if(isDefined(getgametypesetting(#"contributioncapture")) && getgametypesetting(#"contributioncapture")) {
      var_1dbb2b2b = arraycopy(self.var_1dbb2b2b[capture_team]);
      var_6d7ae157 = arraycopy(self.touchlist[capture_team]);
      self thread function_ef09febd(var_1dbb2b2b, var_6d7ae157, string, capturetime, capture_team, self.lastcaptureteam);
    } else {
      touchlist = arraycopy(self.touchlist[capture_team]);
      thread give_capture_credit(touchlist, string, capturetime, capture_team, self.lastcaptureteam);
    }
  }

  level.warcapteam = capture_team;
  level.war_mission_succeeded = 1;
  util::function_5a68c330(20, sentient.team, -1, function_da460cb8(self.var_f23c87bd));
  self gameobjects::set_owner_team(capture_team);

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
  self.iscaptured = 1;
  self gameobjects::must_maintain_claim(1);
  self update_team_client_field();

  if(isplayer(sentient)) {
    sentient recordgameevent("hardpoint_captured");
    bb::function_95a5b5c2("exited_control_point_captured", self.zoneindex, sentient.team, sentient.origin, sentient);
    self notify(#"hash_68e3332f714afbbc");
  }

  level.capturedzones++;

  if(level.capturedzones == 1 && [[level.gettimelimit]]() > 0) {
    level.usingextratime = 1;
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
  }

  thread updatespawns();
}

private on_zone_capture_neutral(sentient) {
  capture_team = sentient.team;
  capturetime = gettime();
  string = #"hash_6d6f47aad6be619f";

  if(!isDefined(self.lastcaptureteam) || self.lastcaptureteam != capture_team) {
    if(isDefined(getgametypesetting(#"contributioncapture")) && getgametypesetting(#"contributioncapture")) {
      var_1dbb2b2b = arraycopy(self.var_1dbb2b2b[capture_team]);
      var_6d7ae157 = arraycopy(self.touchlist[capture_team]);
      self thread function_ef09febd(var_1dbb2b2b, var_6d7ae157, string, capturetime, capture_team, self.lastcaptureteam);
    } else {
      touchlist = arraycopy(self.touchlist[capture_team]);
      thread give_capture_credit(touchlist, string, capturetime, capture_team, self.lastcaptureteam);
    }
  }

  level.warcapteam = capture_team;
  level.war_mission_succeeded = 1;

  if(!(isDefined(level.decaycapturedzones) && level.decaycapturedzones)) {
    if(self.ownerteam != capture_team) {
      self thread award_capture_points_neutral(capture_team);
      self gameobjects::set_owner_team(capture_team);
    }
  } else {
    if(self.ownerteam == #"neutral") {
      self gameobjects::set_owner_team(capture_team);
      self thread award_capture_points_neutral(capture_team);
    }

    if(self.ownerteam != capture_team) {
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

  if(isplayer(sentient)) {
    sentient recordgameevent("hardpoint_captured");
  }

  sentient notify("event_ended" + self.owningzone.zone_index);
}

private function_ef09febd(var_1dbb2b2b, var_6d7ae157, string, capturetime, capture_team, lastcaptureteam) {
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

private give_capture_credit(touchlist, string, capturetime, capture_team, lastcaptureteam) {
  foreach(touch in touchlist) {
    player = gameobjects::function_73944efe(touchlist, touch);

    if(!isDefined(player)) {
      continue;
    }

    credit_player(player, string, capturetime, capture_team, lastcaptureteam, 0, 1);
  }
}

private credit_player(player, string, capturetime, capture_team, lastcaptureteam, var_a84f97bf, var_af8f6146) {
  player update_caps_per_minute(lastcaptureteam);

  if(!is_score_boosting(player)) {
    player challenges::capturedobjective(capturetime, self.trigger);
    scoreevents::processscoreevent(#"war_captured_zone", player, undefined, undefined);
    player recordgameevent("capture");

    if(var_a84f97bf) {
      level thread popups::displayteammessagetoall(string, player);
    }

    if(isDefined(player.pers[#"captures"])) {
      player.pers[#"captures"]++;
      player.captures = player.pers[#"captures"];
    }

    player.pers[#"objectives"]++;
    player.objectives = player.pers[#"objectives"];

    if(level.warstarttime + 500 > capturetime) {
      player challenges::immediatecapture();
    }

    demo::bookmark(#"event", gettime(), player);
    potm::bookmark(#"event", gettime(), player);
    player stats::function_bb7eedf0(#"captures", 1);
    player globallogic_score::incpersstat(#"objectivescore", 1, 0, 1);

    if(isDefined(getgametypesetting(#"contributioncapture")) && getgametypesetting(#"contributioncapture")) {
      player luinotifyevent(#"waypoint_captured", 2, self.var_f23c87bd, player.var_759a143b);
      player.var_759a143b = undefined;
    }

    if(var_af8f6146) {
      player stats::function_dad108fa(#"captures_in_capture_area", 1);
      player contracts::increment_contract(#"contract_mp_objective_capture");
    }

    return;
  }

  player iprintlnbold("<dev string:x60>");

}

private is_zone_contested(gameobject) {
  if(gameobject.touchlist[game.attackers].size > 0 && gameobject.touchlist[game.defenders].size > 0) {
    return true;
  }

  return false;
}

award_capture_points_neutral(team) {
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

award_capture_points(team) {
  level endon(#"game_ended");
  level notify(#"awardcapturepointsrunning");
  level endon(#"awardcapturepointsrunning");
  seconds = 1;
  score = 1;

  while(!level.gameended) {
    wait seconds;
    hostmigration::waittillhostmigrationdone();

    if(!is_zone_contested(self)) {
      if(level.scoreperplayer) {
        score = self.numtouching[team];
      }

      globallogic_score::giveteamscoreforobjective(team, score);
      level.wartotalsecondsinzone++;

      foreach(player in level.aliveplayers[team]) {
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

kill_while_contesting(victim, weapon) {
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

  if(isDefined(point) && point.touchlist[game.attackers].size == 0 && self.clearenemycount >= 2) {
    scoreevents::processscoreevent(#"clear_2_attackers", self, victim, undefined);
    self challenges::function_e0f51b6f(weapon);
    self.clearenemycount = 0;
  }
}

setup_zone_exclusions() {
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

player_use_loop(gameobject) {
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
    while(!isDefined(gameobject.userate) || isDefined(gameobject.userate) && gameobject.userate == 0 || gameobject.claimteam == "none") {
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

    if(isDefined(gameobject.userate) && gameobject.userate != 0 && gameobject.claimteam != "none") {
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

private on_begin_use(sentient) {
  if(isplayer(sentient)) {
    ownerteam = self gameobjects::get_owner_team();

    if(ownerteam == #"neutral") {
      sentient thread battlechatter::gametype_specific_battle_chatter("hq_protect", sentient.pers[#"team"]);
    } else {
      sentient thread battlechatter::gametype_specific_battle_chatter("hq_attack", sentient.pers[#"team"]);
    }
  }

  self checkifshouldupdatestatusplayback(sentient);
  self update_team_client_field();
}

private isuserateelevated(touchlist) {
  foreach(touchinfo in touchlist) {
    if(touchinfo.userate > 1) {
      return true;
    }
  }

  return false;
}

private isplayerinzonewithrole(touchlist, roletype) {
  foreach(touchinfo in touchlist) {
    if(!isDefined(touchinfo)) {
      continue;
    }

    if(isplayer(touchinfo.player) && isDefined(touchinfo.player.playerrole) && touchinfo.player.playerrole.rolename == roletype) {
      return true;
    }
  }

  return false;
}

private update_team_userate_clientfield(zone) {
  if(is_zone_contested(zone)) {
    clientfield::set_world_uimodel("hudItems.missions.captureMultiplierStatus", 0);
    zone.lastteamtoownzone = "contested";
    return;
  }

  if(zone.touchlist[game.attackers].size > 0) {
    if(isplayerinzonewithrole(zone.touchlist[game.attackers], "objective")) {
      clientfield::set_world_uimodel("hudItems.missions.captureMultiplierStatus", 1);
    }

    zone.lastteamtoownzone = game.attackers;
    return;
  }

  if(zone.touchlist[game.defenders].size > 0 && zone.curprogress > 0) {
    if(isplayerinzonewithrole(zone.touchlist[game.defenders], "objective")) {
      clientfield::set_world_uimodel("hudItems.missions.captureMultiplierStatus", 2);
    }

    zone.lastteamtoownzone = game.defenders;
    return;
  }

  clientfield::set_world_uimodel("hudItems.missions.captureMultiplierStatus", 0);
}

private update_team_client_field() {
  level.zonestatemask = 0;

  for(zi = 0; zi < level.zones.size; zi++) {
    gameobj = level.zones[zi].gameobject;
    ownerteam = gameobj gameobjects::get_owner_team();
    state = 0;
    flags = 0;

    if(isDefined(level.neutralzone) && level.neutralzone) {
      if(gameobj.claimteam == "none" || !isDefined(level.teamindex[gameobj.claimteam])) {
        flags = 0;
      } else {
        flags = level.teamindex[gameobj.claimteam];
      }
    } else if(is_zone_contested(gameobj)) {
      state = 3;
    } else if(gameobj.claimteam != "none" && gameobj.numtouching[gameobj.claimteam] > 0) {
      if(gameobj.claimteam == game.attackers) {
        state = 2;
        flags = level.teamindex[gameobj.claimteam];
      } else {
        state = 1;
      }
    } else if(gameobj.numtouching[ownerteam]) {
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

update_caps_per_minute(lastownerteam) {
  if(!isDefined(self.capsperminute)) {
    self.numcaps = 0;
    self.capsperminute = 0;
  }

  if(!isDefined(lastownerteam) || lastownerteam == #"neutral") {
    return;
  }

  self.numcaps++;
  minutespassed = float(globallogic_utils::gettimepassed()) / 60000;

  if(isplayer(self) && isDefined(self.timeplayed[#"total"])) {
    minutespassed = self.timeplayed[#"total"] / 60;
  }

  self.capsperminute = self.numcaps / minutespassed;

  if(self.capsperminute > self.numcaps) {
    self.capsperminute = self.numcaps;
  }
}

is_score_boosting(player) {
  if(!level.rankedmatch) {
    return false;
  }

  if(player.capsperminute > level.playercapturelpm) {
    return true;
  }

  return false;
}

on_decay_complete() {
  clientfield::set_world_uimodel("hudItems.missions.captureMultiplierStatus", 0);
  self gameobjects::set_flags(0);

  if(!(isDefined(self.var_670f7a7f) && self.var_670f7a7f)) {
    if(self.touchlist[game.attackers].size == 0 && self.touchlist[game.defenders].size > 0) {
      self.var_670f7a7f = 1;

      foreach(st in self.touchlist[game.defenders]) {
        player_from_touchlist = gameobjects::function_73944efe(self.touchlist[game.defenders], st);

        if(!isDefined(player_from_touchlist)) {
          continue;
        }

        scoreevents::processscoreevent(#"hash_abbc936bf9059a6", player_from_touchlist, undefined, undefined);
      }
    }
  }
}

score_capture_progress(var_277695bd) {
  trig = self.owningzone.trigger;
  players = getplayers();

  for(i = 0; i < players.size; i++) {
    player = players[i];

    if(player.team == game.attackers) {
      player playsoundtoplayer(#"hash_554eb90f62c68b44", player);

      if(player istouching(trig)) {
        scoreevents::processscoreevent(#"war_capture_progress", player);
      }

      bb::function_95a5b5c2("control_segment_complete" + var_277695bd, self.zoneindex, player.team, player.origin, player);
      self notify(#"hash_68e3332f714afbbc");
    }
  }
}

on_use_update(team, progress, change) {
  if(isDefined(level.capdecay) && level.capdecay && !(isDefined(level.neutralzone) && level.neutralzone)) {
    if(progress >= 0.666667) {
      if(self.stage == 2) {
        self.decayprogressmin = int(0.666667 * self.usetime);
        self score_capture_progress(2);
        self.stage = 3;
        util::function_5a68c330(23, team, -1, function_da460cb8(self.var_f23c87bd));
      }
    } else if(progress >= 0.333333) {
      if(self.stage == 1) {
        self.decayprogressmin = int(0.333333 * self.usetime);
        self score_capture_progress(1);
        self.stage = 2;
        util::function_5a68c330(23, team, -1, function_da460cb8(self.var_f23c87bd));
      }
    }
  }

  if(!(isDefined(level.neutralzone) && level.neutralzone)) {
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
    if(change > 0 && isDefined(self.needsattackerstatusplayback) && self.needsattackerstatusplayback) {
      if(!(isDefined(level.neutralzone) && level.neutralzone)) {
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
    } else if(change < 0 && isDefined(self.needsdefenderstatusplayback) && self.needsdefenderstatusplayback) {
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

  if(change == 0 && !(isDefined(self.var_670f7a7f) && self.var_670f7a7f)) {
    if(self.touchlist[game.attackers].size == 0 && self.touchlist[game.defenders].size > 0) {
      self.var_670f7a7f = 1;

      foreach(st in self.touchlist[game.defenders]) {
        scoreevents::processscoreevent(#"zone_progress_drained", st.player, undefined, undefined);
      }
    }
  }

  if(self.touchlist[game.attackers].size == 0 && self.touchlist[game.defenders].size > 0) {
    if(!(isDefined(self.var_8b62ad00) && self.var_8b62ad00) && self.decayprogressmin === self.curprogress) {
      self update_team_client_field();
      self.var_8b62ad00 = 1;
    }

    return;
  }

  self.var_8b62ad00 = undefined;
}

on_use_update_neutral(team, progress, change) {
  if(progress > 0.05) {
    if(isDefined(self.needsallstatusplayback) && self.needsallstatusplayback) {
      if(change > 0) {
        if(self.ownerteam == #"neutral") {
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

private set_ui_team() {
  wait 0.05;

  if(game.attackers == #"allies" || isDefined(level.neutralzone) && level.neutralzone) {
    clientfield::set_world_uimodel("hudItems.war.attackingTeam", 1);
    return;
  }

  clientfield::set_world_uimodel("hudItems.war.attackingTeam", 2);
}

pause_time() {
  if(level.timepauseswheninzone && !(isDefined(level.timerpaused) && level.timerpaused)) {
    globallogic_utils::pausetimer();
    level.timerpaused = 1;
  }
}

resume_time() {
  if(level.timepauseswheninzone && isDefined(level.timerpaused) && level.timerpaused) {
    globallogic_utils::resumetimer();
    level.timerpaused = 0;
  }
}

update_timer(zoneindex, change) {
  if(change > 0 || is_zone_contested(level.zones[zoneindex].gameobject)) {
    level.zonepauseinfo[zoneindex] = 1;
    pause_time();
    return;
  }

  level.zonepauseinfo[zoneindex] = 0;

  for(zi = 0; zi < level.zones.size; zi++) {
    if(isDefined(level.zonepauseinfo[zi]) && level.zonepauseinfo[zi]) {
      return;
    }
  }

  resume_time();
}

function_caff2d60() {
  level endon(#"game_ended");
  self notify(#"hash_2562ed6d6d163c1a");
  self endon(#"hash_2562ed6d6d163c1a");

  while(true) {
    var_af32dd2d = 1;

    for(i = 0; i < level.zones.size; i++) {
      if(!is_zone_contested(level.zones[i].gameobject)) {
        var_af32dd2d = 0;
        level.var_46ff851e = 0;
        break;
      }
    }

    if(var_af32dd2d) {
      if(!(isDefined(level.var_46ff851e) && level.var_46ff851e)) {
        level.var_46ff851e = 1;
        play_objective_audio("controlContestedOfsAll", game.attackers);
        play_objective_audio("controlContestedDefAll", game.defenders);
      }
    } else {
      if(is_zone_contested(level.zones[0].gameobject)) {
        if(!(isDefined(level.var_b9d36d8e[0]) && level.var_b9d36d8e[0])) {
          level.var_b9d36d8e[0] = 1;
          play_objective_audio("controlContestedOfsA", game.attackers);
          play_objective_audio("controlContestedDefA", game.defenders);
        }
      } else {
        level.var_b9d36d8e[0] = 0;
      }

      if(is_zone_contested(level.zones[1].gameobject)) {
        if(!(isDefined(level.var_b9d36d8e[1]) && level.var_b9d36d8e[1])) {
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

function_68387604(var_c1e98979) {
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

private function_da460cb8(var_b6ec55d) {
  if(var_b6ec55d == "control_0") {
    var_2989dcef = 1;
  } else if(var_b6ec55d == "control_1") {
    var_2989dcef = 2;
  }

  return var_2989dcef;
}

private on_dead_event(team) {
  if(team != "all") {
    return;
  }

  round::set_flag("tie");
  thread globallogic::end_round(6);
}