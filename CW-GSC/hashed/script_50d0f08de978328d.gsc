/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_50d0f08de978328d.gsc
***********************************************/

#using script_1435f3c9fc699e04;
#using script_335d0650ed05d36d;
#using script_44b0b8420eabacad;
#using script_7a8059ca02b7b09e;
#using script_7d712f77ab8d0c16;
#using scripts\core_common\array_shared;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\demo_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\hostmigration_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\medals_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\popups_shared;
#using scripts\core_common\potm_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\sound_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\mp_common\challenges;
#using scripts\mp_common\gametypes\cranked;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\globallogic_utils;
#using scripts\mp_common\gametypes\outcome;
#using scripts\mp_common\gametypes\round;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\util;
#namespace namespace_d150537f;

function init() {
  util::registerscorelimit(0, 1000);
  level.doprematch = 1;
  level.kothstarttime = 0;
  level.onstartgametype = &onstartgametype;
  level.scoremodifiercallback = &function_903a84d4;
  player::function_3c5cc656(&function_610d3790);
  clientfield::register("scriptmover", "zone_id", 1, 5, "int");
  clientfield::register("scriptmover", "zone_state", 1, 3, "int");
  level.zoneautomovetime = getgametypesetting(#"autodestroytime");
  level.zonespawntime = getgametypesetting(#"objectivespawntime");
  level.shownextzoneobjective = getgametypesetting(#"shownextzoneobjective");
  level.var_37bc0271 = getgametypesetting(#"hash_17be9fd145bd1153");
  level.kothmode = getgametypesetting(#"kothmode");
  level.capturetime = getgametypesetting(#"capturetime");
  level.destroytime = getgametypesetting(#"destroytime");
  level.delayplayer = getgametypesetting(#"delayplayer");
  level.randomzonespawn = getgametypesetting(#"randomobjectivelocations");
  level.scoreperplayer = getgametypesetting(#"scoreperplayer");
  level.var_5e8ffd3b = isDefined(getgametypesetting(#"hash_38d6e4d91bbc82ee")) ? getgametypesetting(#"hash_38d6e4d91bbc82ee") : 0;
  level.timepauseswheninzone = getgametypesetting(#"timepauseswheninzone");
  level.var_a495fcf1 = max(getgametypesetting(#"hash_c0beb1e5a80c25c"), 1);

  if(getdvarint(#"hash_5795d85dc4b1b0d9", 0)) {
    level.var_49a15413 = getdvarint(#"hash_5795d85dc4b1b0d9", 0);
  }

  level.var_1be269a9 = getgametypesetting(#"hash_4a10303376ed2d10");

  if(level.var_1be269a9 == 0) {
    level.var_1be269a9 = level.var_a495fcf1;
  }

  level.timerpaused = 0;
  level.b_allow_vehicle_proximity_pickup = 1;
  level.var_c85170d1 = 1;
  level.var_10c0e6bb = &function_41224c9d;
  level.var_ab24f23b = 1;
  spawning::addsupportedspawnpointtype("koth");
  spawning::function_754c78a6(&function_259770ba);
  spawning::function_754c78a6(&function_40c08152);
  spawning::function_32b97d1b(&spawning::function_90dee50d);
  spawning::function_adbbb58a(&spawning::function_c24e290c);

  spawning::function_a860c440(&function_ed2b0a19);

  game.objective_gained_sound = "mpl_flagcapture_sting_friend";
  game.objective_lost_sound = "mpl_flagcapture_sting_enemy";
  game.objective_contested_sound = "mpl_flagreturn_sting";
  level.zonespawnqueue = [];
  level.active_zones = [];
  level.var_6d2f376a = &function_6d2f376a;
  level.var_e80a117f = 0;
  level.var_f7a3b880 = # "hardpoint";

  if(isDefined(level.var_71f9a7ea)) {
    level.var_f7a3b880 = level.var_71f9a7ea;
  }

  level callback::add_callback(#"on_end_game", &on_end_game);
  callback::on_connect(&function_e3aab320);
  callback::on_spawned(&on_player_spawned);
}

function on_end_game() {
  matchrecordroundend();
  setmatchflag("bomb_timer_a", 0);
}

function private function_941e9a96() {
  level endon(#"game_ended");

  while(true) {
    waitframe(1);

    foreach(player in level.players) {
      if(isDefined(player.var_592f3e3c)) {
        foreach(zone in level.active_zones) {
          if(isDefined(player.var_592f3e3c[zone.script_index])) {
            if(is_true(zone.gameobject.iscontested) || !isDefined(player.touchtriggers) || !isDefined(player.touchtriggers[zone.gameobject.entnum])) {
              player.var_592f3e3c[zone.script_index] = undefined;
            }
          }
        }
      }

      if(player.var_b1ff3894 !== 1 && !isDefined(player function_2ff26e21())) {
        player.var_b1ff3894 = 1;
      }
    }
  }
}

function onstartgametype() {
  globallogic_score::resetteamscores();
  level.kothtotalsecondsinzone = 0;
  luinotifyevent(#"round_start");
  spawning::function_fac242d0(10, "koth_zone_", &function_9dc6016e);

  if(getgametypesetting(#"allowovertime")) {
    level.ontimelimit = &function_35088f57;
  }

  if(!setup_zones()) {
    return;
  }

  function_5b2a2486();

  foreach(zone in level.zones) {
    if(isDefined(zone.target)) {
      var_ae149778 = getEntArray(zone.target, "targetname");

      foreach(visual in var_ae149778) {
        visual notsolid();
      }
    }
  }

  thread function_ee725386();
  thread function_941e9a96();

  if(isDefined(level.var_84a07819)) {
    [[level.var_84a07819]]();
  }
}

function pause_time() {
  if(level.timepauseswheninzone) {
    globallogic_utils::pausetimer();
    level.timerpaused = 1;
  }
}

function resume_time() {
  if(level.timepauseswheninzone) {
    globallogic_utils::resumetimerdiscardoverride(int(level.kothtotalsecondsinzone * 1000));
    level.timerpaused = 0;
  }
}

function function_5b2a2486() {
  level.playercapturelpm = getgametypesetting(#"maxplayereventsperminute");
  level.timepauseswheninzone = getgametypesetting(#"timepauseswheninzone");
}

function function_9695c3e3() {
  assert(level.var_73377ee4.size > 0);
  count = 0;

  foreach(obj_id in level.var_73377ee4) {
    count++;

    if(level.randomzonespawn != 0) {
      nextzoneindex = function_ac4c0c88(1, count - 1);
      nextzone = level.zonespawnqueue[nextzoneindex];
    } else {
      nextzoneindex = function_ac4c0c88(0, count);
      nextzone = level.zones[nextzoneindex];
    }

    objective_setstate(obj_id, "invisible");

    if(isDefined(nextzone)) {
      objective_onentity(obj_id, nextzone.objectiveanchor);
      level.var_e89ee661 = 1;
      continue;
    }

    level.var_e89ee661 = 0;
  }
}

function function_9f81bb75() {
  assert(level.var_73377ee4.size > 0);

  if(is_true(level.var_e89ee661) && !is_true(level.overtime)) {
    foreach(obj_id in level.var_73377ee4) {
      objective_setstate(obj_id, "active");
    }
  }
}

function function_785aa606(var_5ed6bcb0, var_514c251c) {
  if(level.randomzonespawn != 0 && !is_true(var_514c251c)) {
    zone = function_1949044f();
  } else {
    zone = [[var_5ed6bcb0]]();
  }

  if(!isDefined(zone)) {
    globallogic_utils::add_map_error("No zones available");
    return;
  }

  print("<dev string:x38>" + zone.trigorigin[0] + "<dev string:x4b>" + zone.trigorigin[1] + "<dev string:x4b>" + zone.trigorigin[2] + "<dev string:x50>");

  zone enable_influencers(1);
  zone.gameobject.trigger allowtacticalinsertion(0);

  if(!isDefined(level.active_zones)) {
    level.active_zones = [];
  } else if(!isarray(level.active_zones)) {
    level.active_zones = array(level.active_zones);
  }

  level.active_zones[level.active_zones.size] = zone;
}

function function_86a05ad0(delay) {
  var_7cd85719 = int(level.var_1be269a9);

  if(!function_14c852b6()) {
    function_785aa606(&get_first_zone, 1);
    var_7cd85719--;
  }

  for(i = 0; i < var_7cd85719; i++) {
    function_785aa606(&get_next_zone);
  }

  matchrecordroundstart();

  if(function_469127d2()) {
    function_d04e9e07();
  }

  if(isDefined(level.var_73377ee4) && level.var_73377ee4.size > 0) {
    function_9695c3e3();
  }
}

function function_5bd81f4f() {
  foreach(zone in level.active_zones) {
    zone.gameobject.trigger allowtacticalinsertion(1);
  }

  matchrecordroundend();

  for(i = 0; i < level.var_a495fcf1; i++) {
    function_785aa606(&get_next_zone);
  }

  matchrecordroundstart();

  if(function_469127d2()) {
    function_d04e9e07();
  }
}

function function_14c852b6() {
  return level.randomzonespawn == 1 || level.randomzonespawn == 3;
}

function function_469127d2() {
  return level.randomzonespawn == 3 || level.randomzonespawn == 4;
}

function function_fbce3808(enabled) {
  index = 0;

  if(enabled) {
    index = self.script_index;
    self.objectiveanchor clientfield::set("zone_state", 1);
    return;
  }

  self.objectiveanchor clientfield::set("zone_state", 0);
}

function function_e221a1d1(zone) {
  zone.gameobject gameobjects::allow_use(#"group_all");
  zone.gameobject gameobjects::set_use_time(level.capturetime);
  zone.gameobject gameobjects::set_use_text(#"mp/capturing_objective");
  zone.gameobject gameobjects::set_visible(#"group_all");
  zone.gameobject gameobjects::must_maintain_claim(0);
  zone.gameobject gameobjects::can_contest_claim(1);
  zone.gameobject set_model_visibility(1);
  zone.gameobject.onuse = &function_631c3afc;
  zone.gameobject.onbeginuse = &function_b4ae9ca4;
  zone.gameobject.onenduse = &function_11e8bc02;
  zone.gameobject.ontouchuse = &function_ab09ff18;
  zone.gameobject.onendtouchuse = &function_6a4aadd;
  zone.gameobject.onupdateuserate = &function_9d7664e3;

  foreach(visual in zone.gameobject.visuals) {
    visual notsolid();
  }

  zone function_fbce3808(1);
}

function function_50a7f9ac(zone) {
  level endon(#"game_ended", #"zone_moved");
  level.kothstarttime = gettime();

  while(true) {
    function_e221a1d1(zone);
    msg = zone waittill(#"zone_captured", #"zone_destroyed");

    if(msg._notify == "zone_destroyed") {
      continue;
    }

    ownerteam = zone.gameobject gameobjects::get_owner_team();
    zone.gameobject gameobjects::allow_use(#"group_none");
    zone.gameobject.onuse = undefined;
    zone.gameobject.onunoccupied = &function_32b7bf67;
    zone.gameobject.oncontested = &function_e4bd126f;
    zone.gameobject.onuncontested = &function_2a6caaff;
    waitresult = zone waittill(#"zone_destroyed");

    if(!level.kothmode || level.zonedestroyedbytimer) {
      break;
    }

    thread function_7828f363(ownerteam);

    if(isDefined(waitresult.destroy_team)) {
      zone.gameobject gameobjects::set_owner_team(waitresult.destroy_team);
      continue;
    }

    zone.gameobject gameobjects::set_owner_team("none");
  }
}

function function_ee725386() {
  level endon(#"game_ended");

  if(isDefined(level.var_5747998d)) {
    flag::wait_till(level.var_5747998d);
  }

  function_86a05ad0();

  while(level.inprematchperiod) {
    waitframe(1);
  }

  if(util::function_7f7a77ab()) {
    while(function_bfd92dc5() || level.var_e80a117f) {
      waitframe(1);
    }
  }

  wait 5;
  luinotifyevent(#"hardpoint_unlocked");

  foreach(zone in level.zones) {
    if(isDefined(zone.target)) {
      othervisuals = getEntArray(zone.target, "targetname");

      foreach(visual in othervisuals) {
        visual clientfield::set("zone_id", zone.script_index);
      }
    }

    zone.objectiveanchor clientfield::set("zone_id", zone.script_index);
    zone.objectiveanchor clientfield::set("zone_state", 0);
  }

  waitframe(1);
  setbombtimer("A", 0);
  setmatchflag("bomb_timer_a", 0);

  while(true) {
    if(util::function_7f7a77ab()) {
      globallogic::function_411eb759(1);
    }

    resume_time();
    sound::play_on_players("mp_suitcase_pickup");
    globallogic_audio::leader_dialog("kothLocated", undefined, "gamemode_objective", undefined, "kothActiveDialogBuffer");

    foreach(zone in level.active_zones) {
      zone.gameobject set_model_visibility(1);

      foreach(visual in zone.gameobject.visuals) {
        visual notsolid();
      }
    }

    setmatchflag("bomb_timer_a", 0);
    waittillframeend();
    sound::play_on_players("mpl_hq_cap_us");
    util::function_a3f7de13(6, #"none");

    foreach(zone in level.active_zones) {
      zone.gameobject gameobjects::enable_object();
      function_18fbab10(zone.gameobject.objectiveid, #"hash_3f7d871e78c8264f");
      objective_onentity(zone.gameobject.objectiveid, zone.objectiveanchor);
      zone.gameobject.capturecount = 0;
    }

    thread function_899cf0b8();

    if(level.zoneautomovetime) {
      thread function_4a415293(level.zoneautomovetime);
      setmatchflag("bomb_timer_a", 1);
      setbombtimer("A", int(gettime() + 1000 + int(level.zoneautomovetime * 1000)));
    } else {
      level.zonedestroyedbytimer = 0;
    }

    foreach(var_c40e7bb5 in level.active_zones) {
      thread function_50a7f9ac(var_c40e7bb5);
    }

    level waittill(#"zone_moved");
    var_2db50872 = [];

    foreach(zone in level.active_zones) {
      if(!isDefined(var_2db50872)) {
        var_2db50872 = [];
      } else if(!isarray(var_2db50872)) {
        var_2db50872 = array(var_2db50872);
      }

      var_2db50872[var_2db50872.size] = zone.gameobject gameobjects::get_owner_team();
    }

    pause_time();

    foreach(zone in level.active_zones) {
      zone enable_influencers(0);
      zone.gameobject.lastcaptureteam = undefined;
      zone.gameobject gameobjects::disable_object();
      zone.gameobject gameobjects::allow_use(#"group_none");
      zone.gameobject gameobjects::set_owner_team(#"neutral");
      zone.gameobject gameobjects::must_maintain_claim(0);
      zone.gameobject set_model_visibility(0);
      zone function_fbce3808(0);
    }

    level notify(#"zone_reset");
    setmatchflag("bomb_timer_a", 0);
    level.active_zones = [];
    function_5bd81f4f();
    wait 0.5;

    foreach(team in var_2db50872) {
      thread function_7828f363(team);
    }

    wait 0.5;

    if(level.zonespawntime) {
      resume_time();
      setmatchflag("bomb_timer_a", 1);
      setbombtimer("A", int(gettime() + 1000 + int(level.zonespawntime * 1000)));
      wait level.zonespawntime;
    }

    if(isDefined(level.var_73377ee4) && level.var_73377ee4.size > 0) {
      function_9695c3e3();
    }
  }
}

function function_899cf0b8() {
  wait 0.1;
  luinotifyevent(#"hardpoint_unlocked");
}

function function_7828f363(team) {
  players = level.players;

  for(i = 0; i < players.size; i++) {
    player = players[i];

    if(!isDefined(player)) {
      continue;
    }

    if(player.pers[# "team"] == team) {
      player notify(#"force_spawn");
      wait 0.1;
    }
  }
}

function private is_zone_contested(gameobject) {
  if(gameobject gameobjects::get_num_touching(game.attackers) > 0 && gameobject gameobjects::get_num_touching(game.defenders) > 0) {
    return true;
  }

  return false;
}

function function_9d7664e3() {
  if(!isDefined(self.iscontested)) {
    self.iscontested = 0;
    self.var_464f0169 = 0;
  }

  self.iscontested = is_zone_contested(self);

  if(self.iscontested) {
    if(!self.var_464f0169) {
      foreach(user in self.users) {
        if(!isDefined(user.touching.players)) {
          continue;
        }

        foreach(struct in user.touching.players) {
          if(!isDefined(struct)) {
            continue;
          }

          player = struct.player;

          if(isDefined(player) && isPlayer(player) && (isDefined(player.var_c8d27c06) ? player.var_c8d27c06 : 0) < gettime()) {
            player playsoundtoplayer(#"mpl_control_capture_contested", player);
            player.var_c8d27c06 = gettime() + 5000;
          }
        }
      }
    }
  }
}

function function_ab09ff18(sentient) {
  if(isPlayer(sentient)) {
    self.var_464f0169 = self.iscontested;

    if(is_zone_contested(self)) {
      if((isDefined(sentient.var_c8d27c06) ? sentient.var_c8d27c06 : 0) < gettime()) {
        sentient playsoundtoplayer(#"mpl_control_capture_contested", sentient);
        sentient.var_c8d27c06 = gettime() + 5000;
      }
    } else if(sentient.team !== self gameobjects::get_owner_team()) {
      battlechatter::function_98898d14(sentient, self);
    }
  }

  if(level.var_ac25d260 === 1) {
    sentient cranked::function_d6e487ba(self, is_zone_contested(self));
  }
}

function function_6a4aadd(sentient) {
  if(level.var_ac25d260 === 1) {
    sentient cranked::function_330029b4(self, is_zone_contested(self));
  }
}

function function_b4ae9ca4(sentient) {}

function function_11e8bc02(team, sentient, success) {
  if(!isDefined(success)) {
    return;
  }

  player = success;

  if(!isPlayer(player)) {
    player = success.owner;
  }

  player notify(#"event_ended");
}

function function_631c3afc(sentient) {
  player = sentient;

  if(!isPlayer(player)) {
    player = sentient.owner;
  }

  capture_team = player.team;
  capturetime = gettime();

  print("<dev string:x55>");

  pause_time();
  string = # "hash_446b7b0b3e4df72e";
  zone = self.zone;
  assert(isDefined(zone));
  self.iscontested = 0;
  spawning::function_7a87efaa();

  if(!isDefined(self.lastcaptureteam) || self.lastcaptureteam != capture_team) {
    touchlist = arraycopy(self.users[capture_team].touching.players);
    self thread give_capture_credit(touchlist, string, capturetime, capture_team, self.lastcaptureteam);
  }

  self.kothcapteam = capture_team;
  self gameobjects::set_owner_team(capture_team);

  if(!level.kothmode) {
    self gameobjects::set_use_time(level.destroytime);
  }

  foreach(team, _ in level.teams) {
    if(team == capture_team) {
      if(!isDefined(self.lastcaptureteam) || self.lastcaptureteam != team) {
        globallogic_audio::leader_dialog("kothSecured", team, "gamemode_objective", undefined, "kothActiveDialogBuffer");

        foreach(player in level.players) {
          if(player.pers[# "team"] == team) {
            if(player.lastkilltime + 500 > gettime()) {
              player challenges::killedlastcontester();
            }
          }
        }
      }

      thread sound::play_on_players(game.objective_gained_sound, team);
      continue;
    }

    if(!isDefined(self.lastcaptureteam)) {
      if(!(isDefined(getgametypesetting(#"hash_711d9928e505c6c9")) ? getgametypesetting(#"hash_711d9928e505c6c9") : 0)) {
        globallogic_audio::leader_dialog("kothCaptured", team, "gamemode_objective", undefined, "kothActiveDialogBuffer");
      }
    } else if(self.lastcaptureteam == team) {
      if(!(isDefined(getgametypesetting(#"hash_711d9928e505c6c9")) ? getgametypesetting(#"hash_711d9928e505c6c9") : 0)) {
        globallogic_audio::leader_dialog("kothLost", team, "gamemode_objective", undefined, "kothActiveDialogBuffer");
      }
    }

    thread sound::play_on_players(game.objective_lost_sound, team);
  }

  zone thread award_capture_points(capture_team, self.lastcaptureteam);
  self.capturecount++;
  self.lastcaptureteam = capture_team;
  self gameobjects::must_maintain_claim(1);
  zone notify(#"zone_captured");
  zone notify("zone_captured" + capture_team);
  player notify(#"event_ended");
}

function track_capture_time() {}

function give_capture_credit(touchlist, string, capturetime, capture_team, lastcaptureteam) {
  waitframe(1);
  util::waittillslowprocessallowed();

  foreach(touch in touchlist) {
    player = gameobjects::function_73944efe(touchlist, touch);

    if(!isDefined(player)) {
      continue;
    }

    player update_caps_per_minute(lastcaptureteam);

    if(!is_score_boosting(player)) {
      challenges::function_783313d8(player);
      player challenges::capturedobjective(capturetime, self.trigger);

      if(level.kothstarttime + 3000 > capturetime && self.kothcapteam == capture_team) {
        scoreevents::processscoreevent(#"quickly_secure_point", player, undefined, undefined);
        player stats::function_dad108fa(#"hash_60545a50ce7c9791", 1);
        player stats::function_cc215323(#"hash_2c800d9270aea253", 1);
      }

      scoreevents::processscoreevent(#"koth_secure", player, undefined, undefined);
      player recordgameevent("capture");
      level thread telemetry::function_18135b72(#"hash_540cddd637f71a5e", {
        #player: player, #eventtype: # "capture"});
      player recordgameevent("hardpoint_captured");
      level thread telemetry::function_18135b72(#"hash_540cddd637f71a5e", {
        #player: player, #eventtype: # "hardpoint_captured"});
      battlechatter::function_924699f4(player, self);

      if(level.var_bc5a3eed !== 1) {
        level thread popups::displayteammessagetoall(string, player);
      }

      if(isDefined(player.pers[# "captures"])) {
        player.pers[# "captures"]++;
        player.captures = player.pers[# "captures"];
      }

      player.pers[# "objectives"]++;
      player.objectives = player.pers[# "objectives"];

      if(level.kothstarttime + 500 > capturetime) {
        player challenges::immediatecapture();
      }

      demo::bookmark(#"event", gettime(), player);
      potm::bookmark(#"event", gettime(), player);
      player stats::function_bb7eedf0(#"captures", 1);
      player stats::function_bb7eedf0(#"captures_in_capture_area", 1);
      player contracts::increment_contract(#"contract_mp_objective_capture");
      continue;
    }

    player iprintlnbold("<dev string:x66>");
  }
}

function function_32b7bf67() {
  self.zone notify(#"zone_destroyed");
  self.kothcapteam = # "neutral";
  self.wasleftunoccupied = 1;
  self.iscontested = 0;
  self recordgameeventnonplayer("hardpoint_empty");
  level thread telemetry::function_18135b72(#"hash_540cddd637f71a5e", {
    #eventtype: # "capture"});
  resume_time();
  self.mustmaintainclaim = 0;
}

function function_e4bd126f() {
  zoneowningteam = self gameobjects::get_owner_team();
  self.wascontested = 1;
  self.iscontested = 1;
  self recordgameeventnonplayer("hardpoint_contested");
  level thread telemetry::function_18135b72(#"hash_540cddd637f71a5e", {
    #eventtype: # "hardpoint_contested"});
  resume_time();
  util::function_a3f7de13(8, #"none");

  foreach(team, _ in level.teams) {
    if(team == zoneowningteam) {
      thread sound::play_on_players(game.objective_contested_sound, team);

      if(!(isDefined(getgametypesetting(#"hash_711d9928e505c6c9")) ? getgametypesetting(#"hash_711d9928e505c6c9") : 0)) {
        globallogic_audio::leader_dialog("kothContested", team, "gamemode_objective", undefined, "kothActiveDialogBuffer");
      }
    }
  }
}

function function_2a6caaff(lastclaimteam) {
  assert(lastclaimteam == self gameobjects::get_owner_team());
  self.iscontested = 0;
  pause_time();
  self gameobjects::set_claim_team(lastclaimteam);
  self recordgameeventnonplayer("hardpoint_uncontested");
  level notify(#"hardpoint_uncontested");
  level thread telemetry::function_18135b72(#"hash_540cddd637f71a5e", {
    #eventtype: # "hardpoint_uncontested"});
}

function function_4a415293(time) {
  level endon(#"game_ended", #"zone_reset");
  level.zonemovetime = gettime() + int(time * 1000);
  level.zonedestroyedbytimer = 0;

  if(isDefined(level.var_73377ee4) && level.var_73377ee4.size > 0) {
    if(level.shownextzoneobjective == 31) {
      level.shownextzoneobjective = time;
    }

    var_f03a7dfd = time;
    var_9217cadc = 0;

    if(level.var_37bc0271 == 0) {
      var_f03a7dfd -= level.shownextzoneobjective;
      var_9217cadc = level.shownextzoneobjective;
    }

    if(var_f03a7dfd <= 0) {
      function_9f81bb75();
      wait time;
    } else if(var_f03a7dfd > time) {
      wait time;
    } else {
      wait var_f03a7dfd;
      function_9f81bb75();
      wait var_9217cadc;
    }
  } else {
    wait time;
  }

  if(is_true(level.overtime)) {
    return;
  }

  level.zonedestroyedbytimer = 1;

  foreach(zone in level.active_zones) {
    if(!isDefined(zone.gameobject.wascontested) || zone.gameobject.wascontested == 0) {
      if(!isDefined(zone.gameobject.wasleftunoccupied) || zone.gameobject.wasleftunoccupied == 0) {
        zoneowningteam = zone.gameobject gameobjects::get_owner_team();
        challenges::controlzoneentirely(zoneowningteam);
      }
    }

    zone.gameobject recordgameeventnonplayer("hardpoint_moved");
  }

  level thread telemetry::function_18135b72(#"hash_540cddd637f71a5e", {
    #eventtype: # "hardpoint_moved"});
  playsoundatposition(#"mpl_hardpoint_move", (0, 0, 0));

  foreach(zone in level.active_zones) {
    zone.gameobject.onuse = undefined;
  }

  level notify(#"zone_moved");
}

function function_a84bac48(team) {
  score = 1;

  if(level.scoreperplayer) {
    score = self.gameobject gameobjects::get_num_touching(team);
  }

  globallogic_score::giveteamscoreforobjective(team, score);

  foreach(player in function_a1ef346b(team)) {
    if(!isDefined(player.touchtriggers[self.gameobject.entnum])) {
      continue;
    }

    if(isDefined(player.pers[# "objtime"])) {
      player.pers[# "objtime"]++;
      player.objtime = player.pers[# "objtime"];
      player contracts::increment_contract(#"hash_78c9a64d04286f61", 1);

      if(player.pers[# "objtime"] % 60 == 0) {
        player contracts::increment_contract(#"hash_92db988270f4f67");
        player stats::function_dad108fa(#"hash_11840e244dff52d3", 1);
      }
    }

    var_998771f0 = "hardpoint" + self.script_index;

    if(!isDefined(player.pers[var_998771f0])) {
      player.pers[var_998771f0] = 0;
    }

    player.pers[var_998771f0]++;
    player function_ef823e71(3, player.pers[var_998771f0], self.script_index - 1);
    player stats::function_bb7eedf0(#"objective_time", 1);
    player globallogic_score::incpersstat(#"objectivetime", 1, 0, 1);
    player function_ef823e71(2, player.pers[# "objtime"]);

    if(!isDefined(player.var_592f3e3c[self.script_index])) {
      player.var_592f3e3c[self.script_index] = gettime();
      continue;
    }

    if(player.var_592f3e3c[self.script_index] <= gettime() - 5000) {
      if(!isDefined(player.var_b1ff3894)) {
        player.var_b1ff3894 = 1;
      }

      player scoreevents::processscoreevent(#"hardpoint_owned", player);
      player.var_592f3e3c[self.script_index] = gettime();
      player.var_b1ff3894 = min(player.var_b1ff3894 + 1, 5);
    }
  }
}

function award_capture_points(team, lastcaptureteam) {
  level endon(#"game_ended", #"zone_reset", #"zone_moved");
  self endon(#"zone_destroyed");
  level notify("award_capture_pointsRunning" + self.script_index);
  level endon("award_capture_pointsRunning" + self.script_index);

  foreach(player in level.players) {
    if(!isDefined(player.var_592f3e3c)) {
      player.var_592f3e3c = [];
    }

    player.var_592f3e3c[self.script_index] = undefined;
  }

  if(level.active_zones.size > 1) {
    time = gettime();
    var_560f3751 = 0;

    foreach(zone in level.active_zones) {
      if(isDefined(zone.var_72767cc4) && time - zone.var_72767cc4 < 1000) {
        wait float(1000 - time - zone.var_72767cc4) / 1000;
        break;
      }
    }
  }

  seconds = 1;

  while(!level.gameended) {
    self.var_72767cc4 = gettime();
    wait seconds;
    hostmigration::waittillhostmigrationdone();

    if(level.var_5e8ffd3b) {
      var_95e19dc6 = self.gameobject gameobjects::function_e4cad37();

      if(var_95e19dc6.size > 0) {
        level.kothtotalsecondsinzone++;

        foreach(var_215dac08 in var_95e19dc6) {
          self function_a84bac48(var_215dac08);
        }
      }

      continue;
    }

    if(!self.gameobject.iscontested) {
      level.kothtotalsecondsinzone++;
      self function_a84bac48(lastcaptureteam);

      if(is_true(level.overtime) && isDefined(outcome::function_6d0354e3())) {
        round::function_870759fb();
        thread globallogic::end_round(2);
      }
    }
  }
}

function private function_903a84d4(type, score) {
  if(isDefined(level.var_49a15413)) {
    if(type === # "ekia" || type === # "hardpoint_kill") {
      return (score + level.var_49a15413);
    }
  }

  if(type === # "hardpoint_owned" && isDefined(self.var_b1ff3894)) {
    return int(score * self.var_b1ff3894);
  }

  return score;
}

function function_3c70f13f(zone_a, zone_b) {
  script_index_a = zone_a.script_index;
  script_index_b = zone_b.script_index;

  if(!isDefined(script_index_a) && !isDefined(script_index_b)) {
    return false;
  }

  if(!isDefined(script_index_a) && isDefined(script_index_b)) {
    println("<dev string:xae>" + zone_a.origin);
    return true;
  }

  if(isDefined(script_index_a) && !isDefined(script_index_b)) {
    println("<dev string:xae>" + zone_b.origin);
    return false;
  }

  if(script_index_a > script_index_b) {
    return true;
  }

  return false;
}

function get_zone_array() {
  zones = getEntArray("koth_zone_center", "targetname");

  if(!isDefined(zones)) {
    return undefined;
  }

  swapped = 1;

  for(n = zones.size; swapped; n--) {
    swapped = 0;

    for(i = 0; i < n - 1; i++) {
      if(function_3c70f13f(zones[i], zones[i + 1])) {
        temp = zones[i];
        zones[i] = zones[i + 1];
        zones[i + 1] = temp;
        swapped = 1;
      }
    }
  }

  return zones;
}

function setup_zones() {
  zones = get_zone_array();

  if(zones.size == 0) {
    globallogic_utils::add_map_error("No zones found for KOTH in map " + util::get_map_name());
  }

  trigs = getEntArray("koth_zone_trigger", "targetname");
  var_4cb5e04 = getEntArray("koth_zone_trigger", "script_noteworthy");
  trigs = arraycombine(trigs, var_4cb5e04);
  assert(zones.size == trigs.size, "<dev string:xd8>");

  for(i = 0; i < zones.size; i++) {
    errored = 0;
    zone = zones[i];
    zone.trig = undefined;

    for(j = 0; j < trigs.size; j++) {
      if(zone istouching(trigs[j])) {
        if(isDefined(zone.trig)) {
          globallogic_utils::add_map_error("Zone at " + zone.origin + " is touching more than one \"zonetrigger\" trigger");
          errored = 1;
          break;
        }

        zone.trig = trigs[j];
        zone.var_b76aa8 = j;
        zone.trig trigger::add_flags(16);
        break;
      }
    }

    if(!isDefined(zone.trig)) {
      if(!errored) {
        globallogic_utils::add_map_error("Zone at " + zone.origin + " is not inside any \"zonetrigger\" trigger");
        continue;
      }
    }

    assert(!errored);
    zone.trigorigin = zone.trig.origin;
    zone.objectiveanchor = spawn("script_model", zone.origin);
    visuals = [];
    visuals[0] = zone;

    if(isDefined(zone.target)) {
      othervisuals = getEntArray(zone.target, "targetname");

      for(j = 0; j < othervisuals.size; j++) {
        visuals[visuals.size] = othervisuals[j];
      }
    }

    foreach(visual in visuals) {
      visual setforcenocull();
    }

    zone.gameobject = gameobjects::create_use_object(#"neutral", zone.trig, visuals, (0, 0, 0), level.var_f7a3b880);
    zone.gameobject gameobjects::set_objective_entity(zone);
    zone.gameobject gameobjects::disable_object();
    zone.gameobject set_model_visibility(0);
    zone.gameobject.var_3517bb1 = 1;
    zone.gameobject.zone = zone;
    zone.trig.useobj = zone.gameobject;
    zone function_3098a12f();
  }

  if(is_true(level.shownextzoneobjective)) {
    level.var_e89ee661 = 0;
    level.var_73377ee4 = [];

    for(i = 0; i < level.var_a495fcf1; i++) {
      obj_id = gameobjects::get_next_obj_id();
      objective_add(obj_id, "invisible", undefined, #"hardpoint_next");
      function_18fbab10(obj_id, #"hash_1ff7adbf21cf79eb");

      if(!isDefined(level.var_73377ee4)) {
        level.var_73377ee4 = [];
      } else if(!isarray(level.var_73377ee4)) {
        level.var_73377ee4 = array(level.var_73377ee4);
      }

      level.var_73377ee4[level.var_73377ee4.size] = obj_id;
    }
  }

  if(globallogic_utils::print_map_errors()) {
    return false;
  }

  level.zones = zones;
  level.prevzone = undefined;
  level.prevzone2 = undefined;
  setup_zone_exclusions();
  return true;
}

function setup_zone_exclusions() {
  if(!isDefined(level.levelkothdisable)) {
    return;
  }

  foreach(nullzone in level.levelkothdisable) {
    mindist = 1410065408;
    foundzone = undefined;

    foreach(zone in level.zones) {
      distance = distancesquared(nullzone.origin, zone.origin);

      if(distance < mindist) {
        foundzone = zone;
        mindist = distance;
      }
    }

    if(isDefined(foundzone)) {
      if(!isDefined(foundzone.gameobject.exclusions)) {
        foundzone.gameobject.exclusions = [];
      }

      foundzone.gameobject.exclusions[foundzone.gameobject.exclusions.size] = nullzone;
    }
  }
}

function set_model_visibility(visibility) {
  if(!isDefined(self)) {
    return;
  }

  foreach(visual in self.visuals) {
    if(visibility === 1) {
      visual show();
      continue;
    }

    visual ghost();
  }
}

function function_ac4c0c88(var_6075f900, count) {
  if(var_6075f900) {
    if(!isDefined(count)) {
      count = 0;
    }

    if(level.zonespawnqueue.size == 0) {
      function_d04e9e07();
      count = 0;
    } else if(count >= level.zonespawnqueue.size) {
      function_d04e9e07(0);
    }

    assert(level.zonespawnqueue.size > 0);
    return count;
  }

  if(!isDefined(count)) {
    count = 1;
  }

  return (level.prevzoneindex + count) % level.zones.size;
}

function get_first_zone() {
  zone = level.zones[0];
  level.prevzone2 = level.prevzone;
  level.prevzone = zone;
  level.prevzoneindex = 0;
  function_d04e9e07();
  arrayremovevalue(level.zonespawnqueue, zone);
  return zone;
}

function get_next_zone() {
  nextzoneindex = function_ac4c0c88(0);
  zone = level.zones[nextzoneindex];
  level.prevzone2 = level.prevzone;
  level.prevzone = zone;
  level.prevzoneindex = nextzoneindex;
  return zone;
}

function function_a65ee551() {
  level.prevzoneindex = randomint(level.zones.size);
  zone = level.zones[level.prevzoneindex];
  level.prevzone2 = level.prevzone;
  level.prevzone = zone;
  return zone;
}

function function_7c9bf7e1(zone) {
  foreach(var_c40e7bb5 in level.active_zones) {
    if(zone == var_c40e7bb5) {
      return true;
    }
  }

  return false;
}

function function_d04e9e07(var_4b52ff2c = 1) {
  if(var_4b52ff2c) {
    level.zonespawnqueue = [];
  }

  spawnqueue = arraycopy(level.zones);

  foreach(var_cde01382 in level.zonespawnqueue) {
    arrayremovevalue(spawnqueue, var_cde01382);
  }

  for(total_left = spawnqueue.size; total_left > 0; total_left--) {
    index = randomint(total_left);
    valid_zones = 0;

    for(zone = 0; zone < level.zones.size; zone++) {
      if(!isDefined(spawnqueue[zone])) {
        continue;
      }

      if(valid_zones == index) {
        if(level.zonespawnqueue.size == 0 && function_7c9bf7e1(spawnqueue[zone]) && !function_469127d2()) {
          continue;
        }

        level.zonespawnqueue[level.zonespawnqueue.size] = spawnqueue[zone];
        spawnqueue[zone] = undefined;
        break;
      }

      valid_zones++;
    }
  }
}

function function_1949044f() {
  nextzoneindex = function_ac4c0c88(1);
  next_zone = level.zonespawnqueue[nextzoneindex];
  arrayremoveindex(level.zonespawnqueue, nextzoneindex);
  level.prevzone2 = level.prevzone;
  level.prevzone = next_zone;
  level.prevzoneindex = nextzoneindex;
  return next_zone;
}

function function_2ff26e21() {
  foreach(var_c40e7bb5 in level.active_zones) {
    if(self istouching(var_c40e7bb5.trig)) {
      return var_c40e7bb5;
    }
  }

  return undefined;
}

function function_610d3790(einflictor, victim, idamage, weapon) {
  attacker = self;

  if(!isPlayer(attacker) || level.capturetime && !idamage.touchtriggers.size && !attacker.touchtriggers.size || attacker.pers[# "team"] == idamage.pers[# "team"]) {
    return;
  }

  if(isDefined(weapon) && isDefined(level.iskillstreakweapon)) {
    if([[level.iskillstreakweapon]](weapon) || isDefined(weapon.statname) && [[level.iskillstreakweapon]](getweapon(weapon.statname))) {
      weaponiskillstreak = 1;
    }
  }

  medalgiven = 0;
  scoreeventprocessed = 0;
  var_47f09325 = 0;
  var_1cfdf798 = isDefined(idamage.lastattacker) ? idamage.lastattacker === attacker : 0;
  ownerteam = undefined;

  if(level.capturetime == 0) {
    if(level.active_zones.size == 0) {
      return;
    }

    var_56bf37df = 0;

    foreach(zone in level.active_zones) {
      ownerteam = zone.gameobject gameobjects::get_owner_team();

      if(isDefined(ownerteam) && ownerteam != # "neutral") {
        var_56bf37df = 1;
        break;
      }
    }

    if(!var_56bf37df) {
      return;
    }
  }

  zone = idamage function_2ff26e21();

  if(isDefined(zone) && (idamage.touchtriggers.size || level.capturetime == 0)) {
    if(level.capturetime > 0) {
      triggerids = getarraykeys(idamage.touchtriggers);
      ownerteam = idamage.touchtriggers[triggerids[0]].useobj gameobjects::get_owner_team();
    }

    if(ownerteam != # "neutral") {
      attacker.prevlastkilltime = attacker.lastkilltime;
      attacker.lastkilltime = gettime();
      team = attacker.pers[# "team"];

      if(team == ownerteam) {
        if(!medalgiven) {
          if(var_1cfdf798) {
            attacker medals::offenseglobalcount();
            attacker thread challenges::killedbaseoffender(zone.trig, weapon, victim);
          }

          attacker challenges::function_2f462ffd(idamage, weapon, victim, zone.gameobject);
          attacker.pers[# "objectiveekia"]++;
          attacker.objectiveekia = attacker.pers[# "objectiveekia"];
          attacker.pers[# "objectives"]++;
          attacker.objectives = attacker.pers[# "objectives"];
          medalgiven = 1;
        }

        if(var_1cfdf798) {
          if(!is_true(weaponiskillstreak)) {
            scoreevents::function_2a2e1723(#"hardpoint_kill", attacker, idamage, weapon);
          }

          attacker function_5493affc(idamage, weapon, zone);
          var_47f09325 = 1;
          level thread telemetry::function_18135b72(#"hash_37f96a1d3c57a089", {
            #player: idamage, #var_bdc4bbd2: # "defending"});
        }

        scoreeventprocessed = 1;
      } else {
        if(!medalgiven) {
          if(var_1cfdf798) {
            if(isDefined(attacker.pers[# "defends"])) {
              attacker.pers[# "defends"]++;
              attacker.defends = attacker.pers[# "defends"];
            }

            attacker medals::defenseglobalcount();
            attacker thread challenges::killedbasedefender(zone.trig);
            attacker recordgameevent("defending");
            level thread telemetry::function_18135b72(#"hash_540cddd637f71a5e", {
              #player: attacker, #eventtype: # "defending"});
          }

          attacker challenges::function_2f462ffd(idamage, weapon, victim, zone.gameobject);
          attacker.pers[# "objectiveekia"]++;
          attacker.objectiveekia = attacker.pers[# "objectiveekia"];
          attacker.pers[# "objectives"]++;
          attacker.objectives = attacker.pers[# "objectives"];
          medalgiven = 1;
        }

        if(var_1cfdf798) {
          attacker challenges::killedzoneattacker(weapon);

          if(!is_true(weaponiskillstreak)) {
            scoreevents::function_2a2e1723(#"hardpoint_kill", attacker, idamage, weapon);
          }

          attacker function_5493affc(idamage, weapon, zone);
          var_47f09325 = 1;
        }

        scoreeventprocessed = 1;
        level thread telemetry::function_18135b72(#"hash_37f96a1d3c57a089", {
          #player: idamage, #var_bdc4bbd2: # "assaulting"});
      }
    }
  }

  if(isDefined(zone)) {
    if(isDefined(attacker) && isDefined(victim) && victim != attacker) {
      var_7901de48 = distance2dsquared(zone.trig.maxs, zone.trig.mins) * 0.5 + sqr(350);
      dist = distance2dsquared(victim.origin, zone.origin);

      if(dist > var_7901de48) {
        if(var_47f09325) {
          attacker challenges::function_82bb78f7(weapon, idamage);
        }

        return;
      }
    }
  }

  zone = attacker function_2ff26e21();

  if(isDefined(zone) && (attacker.touchtriggers.size || level.capturetime == 0)) {
    if(level.capturetime > 0) {
      triggerids = getarraykeys(attacker.touchtriggers);
      ownerteam = attacker.touchtriggers[triggerids[0]].useobj gameobjects::get_owner_team();
    }

    if(ownerteam != # "neutral") {
      team = idamage.pers[# "team"];

      if(team == ownerteam) {
        if(!medalgiven) {
          if(isDefined(attacker.pers[# "defends"])) {
            attacker.pers[# "defends"]++;
            attacker.defends = attacker.pers[# "defends"];
          }

          if(var_1cfdf798) {
            attacker medals::defenseglobalcount();
            attacker thread challenges::killedbasedefender(zone.trig);
            attacker recordgameevent("defending");
            level thread telemetry::function_18135b72(#"hash_540cddd637f71a5e", {
              #player: attacker, #eventtype: # "defending"});
          }

          medalgiven = 1;
        }

        if(scoreeventprocessed == 0) {
          if(var_1cfdf798) {
            attacker challenges::killedzoneattacker(weapon);

            if(!is_true(weaponiskillstreak)) {
              scoreevents::function_2a2e1723(#"hardpoint_kill", attacker, idamage, weapon);
            }

            var_47f09325 = 1;
            level thread telemetry::function_18135b72(#"hash_37f96a1d3c57a089", {
              #player: idamage, #var_bdc4bbd2: # "assaulting"});
          }

          attacker challenges::function_2f462ffd(idamage, weapon, victim, zone.gameobject);
          attacker.pers[# "objectiveekia"]++;
          attacker.objectiveekia = attacker.pers[# "objectiveekia"];
          attacker.pers[# "objectives"]++;
          attacker.objectives = attacker.pers[# "objectives"];
        }
      } else {
        if(!medalgiven && var_1cfdf798) {
          attacker medals::offenseglobalcount();
          medalgiven = 1;
          attacker thread challenges::killedbaseoffender(zone.trig, weapon, victim);
        }

        if(scoreeventprocessed == 0) {
          if(var_1cfdf798) {
            if(!is_true(weaponiskillstreak)) {
              scoreevents::function_2a2e1723(#"hardpoint_kill", attacker, idamage, weapon);
            }

            var_47f09325 = 1;
            level thread telemetry::function_18135b72(#"hash_37f96a1d3c57a089", {
              #player: idamage, #var_bdc4bbd2: # "defending"});
          }

          attacker challenges::function_2f462ffd(idamage, weapon, victim, zone.gameobject);
          attacker.pers[# "objectiveekia"]++;
          attacker.objectiveekia = attacker.pers[# "objectiveekia"];
          attacker.pers[# "objectives"]++;
          attacker.objectives = attacker.pers[# "objectives"];
        }
      }
    }
  }

  if(var_47f09325) {
    attacker challenges::function_82bb78f7(weapon, idamage);
  }
}

function private function_5493affc(victim, weapon, zone) {
  if(!isPlayer(self)) {
    return;
  }

  if(!isDefined(self.var_f58d97ed)) {
    self.var_f58d97ed = 0;
  }

  elapsedtime = gettime() - self.var_f58d97ed;

  if(elapsedtime > int(5 * 1000) || self.var_1920c043 !== zone) {
    self.clearenemycount = 0;
  }

  self.clearenemycount++;
  self.var_f58d97ed = gettime();
  self.var_1920c043 = zone;

  if(isDefined(zone.gameobject) && zone.gameobject gameobjects::get_num_touching(victim.team) <= 1 && self.clearenemycount >= 2) {
    scoreevents::processscoreevent(#"clear_2_attackers", self, victim, undefined);
    self challenges::function_e0f51b6f(weapon);
    self stats::function_dad108fa(#"hash_70320f43067a9540", 1);
    self stats::function_cc215323(#"hash_3c79e0a509575a03", 1);
    self.clearenemycount = 0;
  }
}

function enable_influencers(enabled) {
  if(is_true(level.var_3d984b4c)) {
    enableinfluencer(self.influencer_large, enabled);
    enableinfluencer(self.influencer_small, enabled);
  }
}

function function_3098a12f() {
  if(!is_true(level.var_3d984b4c)) {
    return;
  }

  self.influencer_large = self influencers::create_influencer("koth_large", self.gameobject.curorigin, 0);
  self.influencer_small = influencers::create_influencer("koth_small", self.gameobject.curorigin, 0);
  self enable_influencers(0);

  if((isDefined(self.influencer_radius_small) ? self.influencer_radius_small : 0) > 0) {
    function_2e07e8f9(self.influencer_small, self.influencer_radius_small);
  }

  if((isDefined(self.influencer_radius_large) ? self.influencer_radius_large : 0) > 0) {
    function_2e07e8f9(self.influencer_large, self.influencer_radius_large);
  }
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

  if(isPlayer(self) && isDefined(self.timeplayed[# "total"])) {
    minutespassed = self.timeplayed[# "total"] / 60;
  }

  if(minutespassed <= 0) {
    self.capsperminute = self.numcaps;
    return;
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

function function_6d2f376a(entity) {
  foreach(zone in level.active_zones) {
    if(isDefined(zone.trig) && entity istouching(zone.trig)) {
      return true;
    }
  }

  return false;
}

function function_35088f57() {
  if(is_true(level.overtime)) {
    return;
  }

  if(isDefined(outcome::function_6d0354e3())) {
    round::function_870759fb();
    thread globallogic::end_round(2);
    return;
  }

  function_e7392e03();
}

function function_e7392e03() {
  level.overtime = 1;
  setmatchflag("bomb_timer_a", 0);
  globallogic_audio::leader_dialog("roundOvertime");

  foreach(player in level.players) {
    player luinotifyevent(#"hash_6b67aa04e378d681", 1, 8);
  }

  if(is_true(level.var_e89ee661)) {
    foreach(obj_id in level.var_73377ee4) {
      objective_setstate(obj_id, "invisible");
    }
  }
}

function private function_9dc6016e(var_f99d1b44) {
  switch (var_f99d1b44) {
    case 0:
      return "spl1";
    case 1:
      return "spl2";
    case 2:
      return "spl3";
    case 3:
      return "spl4";
    case 4:
      return "spl5";
    case 5:
      return "spl6";
    case 6:
      return "spl7";
    case 7:
      return "spl8";
    case 8:
      return "spl9";
    case 9:
      return "fallback";
  }

  return "auto_normal";
}

function private function_259770ba(e_player) {
  if(spawning::usestartspawns() || level.active_zones.size > 1 || !isDefined(level.active_zones[0].script_index)) {
    return undefined;
  }

  return function_9dc6016e(level.active_zones[0].script_index);
}

function private function_40c08152(e_player) {
  if(spawning::usestartspawns()) {
    return undefined;
  }

  return "auto_normal";
}

function private function_e3aab320() {
  for(index = 0; index < 5; index++) {
    var_998771f0 = "hardpoint" + index + 1;

    if(index < level.zones.size) {
      if(!isDefined(self.pers[var_998771f0])) {
        self.pers[var_998771f0] = 0;
      }
    } else if(!isDefined(self.pers[var_998771f0])) {
      self.pers[var_998771f0] = -1;
    }

    self function_ef823e71(3, self.pers[var_998771f0], index);
  }
}

function on_player_spawned() {
  self function_4a5572c3("");

  if(util::function_7f7a77ab()) {
    if(is_true(level.var_e80a117f)) {
      util::function_256dd160(self);
    }
  }
}

function function_ed2b0a19() {
  for(index = 0; index < 10; index++) {
    spawning::function_25e7711a(function_9dc6016e(index), #"none", "<dev string:x119>" + index + "<dev string:x128>", "<dev string:x12f>");
  }
}

function function_41224c9d(gameobject, starting = 0) {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(gameobject)) {
    return;
  }

  if(starting) {
    self thread function_90fdfef6(gameobject);
    return;
  }

  self thread function_dd2fc4c3(gameobject);
}

function function_90fdfef6(gameobject) {
  self notify("131d8d21c84fb532");
  self endon("131d8d21c84fb532");
  self endon(#"death", #"disconnect", #"hash_580789b91ba9f984");
  gameobject.trigger endon(#"destroyed", #"death");
  level endon(#"game_ended");
  level notify(#"hash_d50c83061fcd561");
  waitframe(1);

  while(true) {
    currentpercentage = function_896e36e0();
    iscontested = isDefined(gameobject.contested) ? gameobject.contested : 0;

    if(is_true(gameobject.iscontested)) {
      self function_a38cc2d7("cap_contested");
      self function_4a5572c3("cap_contested");
    } else if(currentpercentage >= 0.8) {
      self function_4a5572c3("cap_war_percent_90");
    } else if(currentpercentage >= 0.6) {
      self function_4a5572c3("cap_war_percent_75");
    } else if(currentpercentage >= 0.4) {
      self function_4a5572c3("cap_war_percent_50");
    } else if(currentpercentage >= 0.2) {
      self function_4a5572c3("cap_war_percent_25");
    } else if(currentpercentage >= 0) {
      self function_4a5572c3("cap_war_percent_0");
    }

    waitframe(1);
  }
}

function function_dd2fc4c3(gameobject, success = 0) {
  if(success) {
    self function_4a5572c3("cap_success");
    return;
  }

  self function_4a5572c3("cap_exit");
  self notify(#"hash_580789b91ba9f984");
  self.var_b3890fdf = 0;
}

function function_4a5572c3(state) {
  if(!isDefined(self.var_a022edea)) {
    self.var_a022edea = "";
  }

  if(is_true(level.var_2179a6bf)) {
    return;
  }

  if(is_true(level.var_d39752e6)) {
    return;
  }

  if(state != self.var_a022edea) {
    self.var_a022edea = state;
    globallogic_audio::function_c246758e(state);
  }
}

function function_a38cc2d7(state) {
  if(!isDefined(self.var_b3890fdf)) {
    self.var_b3890fdf = 0;
  }

  if(game.state != # "playing") {
    return;
  }

  str_alias = undefined;

  switch (state) {
    case # "cap_low":
      str_alias = # "hash_1c518fb856754e14";
      n_waittime = 2.5;
      break;
    case # "hash_736eee50e5b4b564":
      str_alias = # "hash_1c5192b85675532d";
      n_waittime = 2.5;
      break;
    case # "cap_mid":
      str_alias = # "hash_1c5191b85675517a";
      n_waittime = 2.5;
      break;
    case # "hash_3b47899904bb9c9e":
      str_alias = # "hash_1c518cb8567548fb";
      n_waittime = 2.5;
      break;
    case # "cap_high":
      str_alias = # "hash_1c518cb8567548fb";
      n_waittime = 1.25;
      break;
    case # "cap_contested":
      str_alias = # "hash_43014e1f7354354f";
      n_waittime = 1.25;
      break;
  }

  if(is_true(level.var_2179a6bf)) {
    str_alias = # "hash_1c518cb8567548fb";
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

function function_896e36e0() {
  if(!isDefined(level.teams)) {
    return 0;
  }

  scorelimit = level.scorelimit < 0 ? 1 : level.scorelimit;
  var_ab9897d4 = [];

  foreach(team in level.teams) {
    array::add(var_ab9897d4, getteamscore(team) / scorelimit);
  }

  array::sort_by_value(var_ab9897d4);
  return var_ab9897d4[0];
}