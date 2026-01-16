/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\koth.gsc
***********************************************/

#include scripts\core_common\challenges_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\contracts_shared;
#include scripts\core_common\demo_shared;
#include scripts\core_common\gameobjects_shared;
#include scripts\core_common\hostmigration_shared;
#include scripts\core_common\hud_util_shared;
#include scripts\core_common\influencers_shared;
#include scripts\core_common\medals_shared;
#include scripts\core_common\persistence_shared;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\popups_shared;
#include scripts\core_common\potm_shared;
#include scripts\core_common\scoreevents_shared;
#include scripts\core_common\sound_shared;
#include scripts\core_common\spawning_shared;
#include scripts\core_common\trigger_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\challenges;
#include scripts\mp_common\gametypes\battlechatter;
#include scripts\mp_common\gametypes\ct_tutorial_skirmish;
#include scripts\mp_common\gametypes\globallogic;
#include scripts\mp_common\gametypes\globallogic_audio;
#include scripts\mp_common\gametypes\globallogic_score;
#include scripts\mp_common\gametypes\globallogic_spawn;
#include scripts\mp_common\gametypes\globallogic_utils;
#include scripts\mp_common\gametypes\hostmigration;
#include scripts\mp_common\gametypes\outcome;
#include scripts\mp_common\gametypes\round;
#include scripts\mp_common\gametypes\spawning;
#include scripts\mp_common\player\player_utils;
#include scripts\mp_common\spawnbeacon;
#include scripts\mp_common\util;

#namespace koth;

event_handler[gametype_init] main(eventstruct) {
  globallogic::init();
  util::registertimelimit(0, 1440);
  util::registerscorelimit(0, 1000);
  util::registernumlives(0, 100);
  util::registerroundswitch(0, 9);
  util::registerroundwinlimit(0, 10);
  globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
  level.doprematch = 1;
  level.overrideteamscore = 1;
  level.kothstarttime = 0;
  level.onstartgametype = &onstartgametype;
  level.playerspawnedcb = &koth_playerspawnedcb;
  player::function_cf3aa03d(&onplayerkilled);
  player::function_3c5cc656(&function_610d3790);
  level.var_c605eb2a = &function_38874bf6;
  clientfield::register("world", "hardpoint", 1, 5, "int");
  clientfield::register("world", "hardpointteam", 1, 5, "int");
  level.zoneautomovetime = getgametypesetting(#"autodestroytime");
  level.zonespawntime = getgametypesetting(#"objectivespawntime");
  level.kothmode = getgametypesetting(#"kothmode");
  level.capturetime = getgametypesetting(#"capturetime");
  level.destroytime = getgametypesetting(#"destroytime");
  level.delayplayer = getgametypesetting(#"delayplayer");
  level.randomzonespawn = getgametypesetting(#"randomobjectivelocations");
  level.scoreperplayer = getgametypesetting(#"scoreperplayer");
  level.timepauseswheninzone = getgametypesetting(#"timepauseswheninzone");
  level.b_allow_vehicle_proximity_pickup = 1;
  level.var_c85170d1 = 1;
  globallogic_spawn::addsupportedspawnpointtype("koth");
  globallogic_audio::set_leader_gametype_dialog("startHardPoint", "hcStartHardPoint", "objCapture", "objCapture", "bbStartHardPoint", "hcbbStartHardPoint");
  game.objective_gained_sound = "mpl_flagcapture_sting_friend";
  game.objective_lost_sound = "mpl_flagcapture_sting_enemy";
  game.objective_contested_sound = "mpl_flagreturn_sting";
  level.zonespawnqueue = [];

  if(util::function_8570168d()) {
    ct_tutorial_skirmish::init();
  }

  level.var_d3a438fb = &function_d3a438fb;
}

private function_14e751e9() {
  level endon(#"game_ended");

  while(true) {
    waitframe(1);

    foreach(player in level.players) {
      if(isDefined(player.var_592f3e3c)) {
        if(isDefined(level.zone.gameobject.iscontested) && level.zone.gameobject.iscontested || !isDefined(player.touchtriggers) || !isDefined(player.touchtriggers[level.zone.gameobject.entnum])) {
          player.var_592f3e3c = undefined;
        }
      }
    }
  }
}

updateobjectivehintmessages(defenderteam, defendmessage, attackmessage) {
  foreach(team, _ in level.teams) {
    if(defenderteam == team) {
      game.strings["objective_hint_" + team] = defendmessage;
      continue;
    }

    game.strings["objective_hint_" + team] = attackmessage;
  }
}

updateobjectivehintmessage(message) {
  foreach(team, _ in level.teams) {
    game.strings["objective_hint_" + team] = message;
  }
}

private function_785d5e6d() {
  foreach(team, _ in level.teams) {
    spawning::add_spawn_points(team, "mp_tdm_spawn");
    spawning::add_spawn_points(team, "mp_multi_team_spawn");
    spawning::place_spawn_points(spawning::gettdmstartspawnname(team));
    spawning::add_start_spawn_points(team, spawning::gettdmstartspawnname(team));
  }

  spawning::updateallspawnpoints();
}

onstartgametype() {
  globallogic_score::resetteamscores();
  level.kothtotalsecondsinzone = 0;
  level.objectivehintpreparezone = #"mp/control_koth";
  level.objectivehintcapturezone = #"mp/capture_koth";
  level.objectivehintdefendhq = #"mp/defend_koth";

  if(getgametypesetting(#"allowovertime")) {
    level.ontimelimit = &function_a2ef4132;
  }

  if(level.zonespawntime) {
    updateobjectivehintmessage(level.objectivehintpreparezone);
  } else {
    updateobjectivehintmessage(level.objectivehintcapturezone);
  }

  function_785d5e6d();

  if(!setupzones()) {
    return;
  }

  updategametypedvars();
  thread kothmainloop();
  thread function_14e751e9();
}

pause_time() {
  if(level.timepauseswheninzone) {
    globallogic_utils::pausetimer();
    level.timerpaused = 1;
  }
}

resume_time() {
  if(level.timepauseswheninzone) {
    globallogic_utils::resumetimerdiscardoverride(int(level.kothtotalsecondsinzone * 1000));
    level.timerpaused = 0;
  }
}

updategametypedvars() {
  level.playercapturelpm = getgametypesetting(#"maxplayereventsperminute");
  level.timepauseswheninzone = getgametypesetting(#"timepauseswheninzone");
}

spawn_first_zone(delay) {
  if(level.randomzonespawn == 1) {
    level.zone = getnextzonefromqueue();
  } else {
    level.zone = getfirstzone();
  }

  if(!isDefined(level.zone)) {
    globallogic_utils::add_map_error("No zones available");
    return;
  }

  print("<dev string:x38>" + level.zone.trigorigin[0] + "<dev string:x4a>" + level.zone.trigorigin[1] + "<dev string:x4a>" + level.zone.trigorigin[2] + "<dev string:x4e>");

    level.zone enable_influencers(1);
  level.zone.gameobject.trigger allowtacticalinsertion(0);
  spawn_beacon::addprotectedzone(level.zone.trig);
  matchrecordroundstart();
}

spawn_next_zone() {
  level.zone.gameobject.trigger allowtacticalinsertion(1);

  if(level.randomzonespawn != 0) {
    level.zone = getnextzonefromqueue();
  } else {
    level.zone = getnextzone();
  }

  matchrecordroundend();

  if(isDefined(level.zone)) {

    print("<dev string:x38>" + level.zone.trigorigin[0] + "<dev string:x4a>" + level.zone.trigorigin[1] + "<dev string:x4a>" + level.zone.trigorigin[2] + "<dev string:x4e>");

      level.zone enable_influencers(1);
    spawn_beacon::addprotectedzone(level.zone.trig);
    matchrecordroundstart();
  }

  level.zone.gameobject.trigger allowtacticalinsertion(0);
}

function_568f7563() {
  level waittill(#"game_ended");
  matchrecordroundend();
}

getnumtouching() {
  numtouching = 0;

  foreach(team, _ in level.teams) {
    numtouching += self.numtouching[team];
  }

  return numtouching;
}

togglezoneeffects(enabled) {
  index = 0;

  if(enabled) {
    index = self.script_index;
  }

  level clientfield::set("hardpoint", index);
  level clientfield::set("hardpointteam", 0);
}

kothcaptureloop() {
  level endon(#"game_ended", #"zone_moved");
  level.kothstarttime = gettime();

  while(true) {
    level.zone.gameobject gameobjects::allow_use(#"any");
    level.zone.gameobject gameobjects::set_use_time(level.capturetime);
    level.zone.gameobject gameobjects::set_use_text(#"mp/capturing_objective");
    numtouching = level.zone.gameobject getnumtouching();
    level.zone.gameobject gameobjects::set_visible_team(#"any");
    level.zone.gameobject gameobjects::set_model_visibility(1);
    level.zone.gameobject gameobjects::must_maintain_claim(0);
    level.zone.gameobject gameobjects::can_contest_claim(1);
    level.zone.gameobject.onuse = &onzonecapture;
    level.zone.gameobject.onbeginuse = &onbeginuse;
    level.zone.gameobject.onenduse = &onenduse;
    level.zone.gameobject.ontouchuse = &ontouchuse;
    level.zone.gameobject.onupdateuserate = &onupdateuserate;
    level.zone togglezoneeffects(1);
    msg = level waittill(#"zone_captured", #"zone_destroyed");

    if(msg._notify == "zone_destroyed") {
      continue;
    }

    ownerteam = level.zone.gameobject gameobjects::get_owner_team();

    foreach(_ in level.teams) {
      updateobjectivehintmessages(ownerteam, level.objectivehintdefendhq, level.objectivehintcapturezone);
    }

    level.zone.gameobject gameobjects::allow_use(#"none");
    level.zone.gameobject.onuse = undefined;
    level.zone.gameobject.onunoccupied = &onzoneunoccupied;
    level.zone.gameobject.oncontested = &onzonecontested;
    level.zone.gameobject.onuncontested = &onzoneuncontested;
    waitresult = level waittill(#"zone_destroyed");

    if(!level.kothmode || level.zonedestroyedbytimer) {
      break;
    }

    thread forcespawnteam(ownerteam);

    if(isDefined(waitresult.destroy_team)) {
      level.zone.gameobject gameobjects::set_owner_team(waitresult.destroy_team);
      continue;
    }

    level.zone.gameobject gameobjects::set_owner_team("none");
  }
}

kothmainloop() {
  level endon(#"game_ended");
  spawn_first_zone();

  while(level.inprematchperiod) {
    waitframe(1);
  }

  pause_time();
  wait 5;
  setbombtimer("A", 0);
  setmatchflag("bomb_timer_a", 0);
  thread hidetimerdisplayongameend();
  thread function_568f7563();

  while(true) {
    resume_time();
    sound::play_on_players("mp_suitcase_pickup");
    globallogic_audio::leader_dialog("kothLocated", undefined, undefined, "gamemode_objective", undefined, "kothActiveDialogBuffer");
    level.zone.gameobject gameobjects::set_model_visibility(1);

    if(level.zonespawntime) {
      level.zone.gameobject gameobjects::set_visible_team(#"any");
      level.zone.gameobject gameobjects::set_flags(1);
      updateobjectivehintmessage(level.objectivehintpreparezone);
      setmatchflag("bomb_timer_a", 1);
      setbombtimer("A", int(gettime() + 1000 + int(level.zonespawntime * 1000)));
      wait level.zonespawntime;
      level.zone.gameobject gameobjects::set_flags(0);
      globallogic_audio::leader_dialog("kothOnline", undefined, undefined, "gamemode_objective", undefined, "kothActiveDialogBuffer");
    }

    setmatchflag("bomb_timer_a", 0);
    waittillframeend();
    updateobjectivehintmessage(level.objectivehintcapturezone);
    sound::play_on_players("mpl_hq_cap_us");
    level.zone.gameobject gameobjects::enable_object();
    objective_onentity(level.zone.gameobject.objectiveid, level.zone.objectiveanchor);
    level.zone.gameobject.capturecount = 0;

    if(level.zoneautomovetime) {
      thread movezoneaftertime(level.zoneautomovetime);
      setmatchflag("bomb_timer_a", 1);
      setbombtimer("A", int(gettime() + 1000 + int(level.zoneautomovetime * 1000)));
    } else {
      level.zonedestroyedbytimer = 0;
    }

    kothcaptureloop();
    ownerteam = level.zone.gameobject gameobjects::get_owner_team();
    pause_time();
    level.zone enable_influencers(0);
    level.zone.gameobject.lastcaptureteam = undefined;
    level.zone.gameobject gameobjects::disable_object();
    level.zone.gameobject gameobjects::allow_use(#"none");
    level.zone.gameobject gameobjects::set_owner_team(#"neutral");
    level.zone.gameobject gameobjects::set_model_visibility(0);
    level.zone.gameobject gameobjects::must_maintain_claim(0);
    level.zone togglezoneeffects(0);
    spawn_beacon::removeprotectedzone(level.zone.trig);
    level notify(#"zone_reset");
    setmatchflag("bomb_timer_a", 0);
    spawn_next_zone();
    wait 0.5;
    thread forcespawnteam(ownerteam);
    wait 0.5;
  }
}

hidetimerdisplayongameend() {
  level waittill(#"game_ended");
  setmatchflag("bomb_timer_a", 0);
}

forcespawnteam(team) {
  players = level.players;

  for(i = 0; i < players.size; i++) {
    player = players[i];

    if(!isDefined(player)) {
      continue;
    }

    if(player.pers[#"team"] == team) {
      player notify(#"force_spawn");
      wait 0.1;
    }
  }
}

updateteamclientfield() {
  ownerteam = self gameobjects::get_owner_team();

  if(isDefined(self.iscontested) && self.iscontested) {
    level clientfield::set("hardpointteam", 3);
    return;
  }

  if(ownerteam == #"neutral") {
    level clientfield::set("hardpointteam", 0);
    return;
  }

  if(ownerteam == #"allies") {
    level clientfield::set("hardpointteam", 1);
    return;
  }

  level clientfield::set("hardpointteam", 2);
}

private iszonecontested(gameobject) {
  if(gameobject.touchlist[game.attackers].size > 0 && gameobject.touchlist[game.defenders].size > 0) {
    return true;
  }

  return false;
}

onupdateuserate() {
  if(!isDefined(self.iscontested)) {
    self.iscontested = 0;
    self.var_464f0169 = 0;
  }

  self.iscontested = iszonecontested(self);

  if(self.iscontested) {
    if(!self.var_464f0169) {
      foreach(playerlist in self.touchlist) {
        if(!isDefined(playerlist)) {
          continue;
        }

        foreach(struct in playerlist) {
          if(!isDefined(struct)) {
            continue;
          }

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

ontouchuse(sentient) {
  if(isplayer(sentient)) {
    self.var_464f0169 = self.iscontested;

    if(iszonecontested(self) && (isDefined(sentient.var_c8d27c06) ? sentient.var_c8d27c06 : 0) < gettime()) {
      sentient playsoundtoplayer(#"mpl_control_capture_contested", sentient);
      sentient.var_c8d27c06 = gettime() + 5000;
    }
  }
}

onbeginuse(sentient) {
  player = sentient;

  if(!isplayer(player)) {
    player = sentient.owner;
  }

  ownerteam = self gameobjects::get_owner_team();

  if(ownerteam == #"neutral") {
    player thread battlechatter::gametype_specific_battle_chatter("hq_protect", player.pers[#"team"]);
    return;
  }

  player thread battlechatter::gametype_specific_battle_chatter("hq_attack", player.pers[#"team"]);
}

onenduse(team, sentient, success) {
  if(!isDefined(sentient)) {
    return;
  }

  player = sentient;

  if(!isplayer(player)) {
    player = sentient.owner;
  }

  player notify(#"event_ended");
}

onzonecapture(sentient) {
  player = sentient;

  if(!isplayer(player)) {
    player = sentient.owner;
  }

  capture_team = player.team;
  capturetime = gettime();

  print("<dev string:x52>");

    pause_time();
  string = #"hash_446b7b0b3e4df72e";
  level.zone.gameobject.iscontested = 0;
  level.usestartspawns = 0;

  if(!isDefined(self.lastcaptureteam) || self.lastcaptureteam != capture_team) {
    touchlist = arraycopy(self.touchlist[capture_team]);
    thread give_capture_credit(touchlist, string, capturetime, capture_team, self.lastcaptureteam);
  }

  level.kothcapteam = capture_team;
  self gameobjects::set_owner_team(capture_team);

  if(!level.kothmode) {
    self gameobjects::set_use_time(level.destroytime);
  }

  foreach(team, _ in level.teams) {
    if(team == capture_team) {
      if(!isDefined(self.lastcaptureteam) || self.lastcaptureteam != team) {
        globallogic_audio::leader_dialog("kothSecured", team, undefined, "gamemode_objective", undefined, "kothActiveDialogBuffer");

        for(index = 0; index < level.players.size; index++) {
          player = level.players[index];

          if(player.pers[#"team"] == team) {
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
      globallogic_audio::leader_dialog("kothCaptured", team, undefined, "gamemode_objective", undefined, "kothActiveDialogBuffer");
    } else if(self.lastcaptureteam == team) {
      globallogic_audio::leader_dialog("kothLost", team, undefined, "gamemode_objective", undefined, "kothActiveDialogBuffer");
    }

    thread sound::play_on_players(game.objective_lost_sound, team);
  }

  self thread awardcapturepoints(capture_team, self.lastcaptureteam);
  self.capturecount++;
  self.lastcaptureteam = capture_team;
  self gameobjects::must_maintain_claim(1);
  self updateteamclientfield();
  level notify(#"zone_captured");
  level notify("zone_captured" + capture_team);
  player notify(#"event_ended");
}

track_capture_time() {}

give_capture_credit(touchlist, string, capturetime, capture_team, lastcaptureteam) {
  waitframe(1);
  util::waittillslowprocessallowed();

  foreach(touch in touchlist) {
    player = gameobjects::function_73944efe(touchlist, touch);

    if(!isDefined(player)) {
      continue;
    }

    player updatecapsperminute(lastcaptureteam);

    if(!isscoreboosting(player)) {
      player challenges::capturedobjective(capturetime, self.trigger);

      if(level.kothstarttime + 3000 > capturetime && level.kothcapteam == capture_team) {
        scoreevents::processscoreevent(#"quickly_secure_point", player, undefined, undefined);
        player stats::function_dad108fa(#"hash_60545a50ce7c9791", 1);
      }

      scoreevents::processscoreevent(#"koth_secure", player, undefined, undefined);
      player recordgameevent("capture");
      player recordgameevent("hardpoint_captured");
      level thread popups::displayteammessagetoall(string, player);

      if(isDefined(player.pers[#"captures"])) {
        player.pers[#"captures"]++;
        player.captures = player.pers[#"captures"];
      }

      player.pers[#"objectives"]++;
      player.objectives = player.pers[#"objectives"];

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

    player iprintlnbold("<dev string:x62>");

  }
}

give_held_credit(touchlist, team) {
  waitframe(1);
  util::waittillslowprocessallowed();

  foreach(touch in touchlist) {
    player = gameobjects::function_73944efe(touchlist, touch);

    if(!isDefined(player)) {
      continue;
    }

    scoreevents::processscoreevent(#"koth_held", player, undefined, undefined);
  }
}

onzoneunoccupied() {
  level notify(#"zone_destroyed");
  level.kothcapteam = #"neutral";
  level.zone.gameobject.wasleftunoccupied = 1;
  level.zone.gameobject.iscontested = 0;
  level.zone.gameobject recordgameeventnonplayer("hardpoint_empty");
  resume_time();
  self updateteamclientfield();
  self.mustmaintainclaim = 0;
}

onzonecontested() {
  zoneowningteam = self gameobjects::get_owner_team();
  self.wascontested = 1;
  self.iscontested = 1;
  self updateteamclientfield();
  self recordgameeventnonplayer("hardpoint_contested");
  resume_time();
  util::function_5a68c330(8, #"free");

  foreach(team, _ in level.teams) {
    if(team == zoneowningteam) {
      thread sound::play_on_players(game.objective_contested_sound, team);
      globallogic_audio::leader_dialog("kothContested", team, undefined, "gamemode_objective", undefined, "kothActiveDialogBuffer");
    }
  }
}

onzoneuncontested(lastclaimteam) {
  assert(lastclaimteam == level.zone.gameobject gameobjects::get_owner_team());
  self.iscontested = 0;
  pause_time();
  self gameobjects::set_claim_team(lastclaimteam);
  self updateteamclientfield();
  self recordgameeventnonplayer("hardpoint_uncontested");
  level notify(#"hardpoint_uncontested");
}

movezoneaftertime(time) {
  level endon(#"game_ended", #"zone_reset");
  level.zonemovetime = gettime() + int(time * 1000);
  level.zonedestroyedbytimer = 0;
  wait time;

  if(isDefined(level.overtime) && level.overtime) {
    return;
  }

  if(!isDefined(level.zone.gameobject.wascontested) || level.zone.gameobject.wascontested == 0) {
    if(!isDefined(level.zone.gameobject.wasleftunoccupied) || level.zone.gameobject.wasleftunoccupied == 0) {
      zoneowningteam = level.zone.gameobject gameobjects::get_owner_team();
      challenges::controlzoneentirely(zoneowningteam);
    }
  }

  level.zonedestroyedbytimer = 1;
  level.zone.gameobject recordgameeventnonplayer("hardpoint_moved");
  level notify(#"zone_moved");
  level.zone.gameobject.onuse = undefined;
  util::function_5a68c330(6, #"free");
}

awardcapturepoints(team, lastcaptureteam) {
  level endon(#"game_ended", #"zone_destroyed", #"zone_reset", #"zone_moved");
  level notify(#"awardcapturepointsrunning");
  level endon(#"awardcapturepointsrunning");

  foreach(player in level.players) {
    player.var_592f3e3c = undefined;
  }

  seconds = 1;
  score = 1;

  while(!level.gameended) {
    wait seconds;
    hostmigration::waittillhostmigrationdone();

    if(!level.zone.gameobject.iscontested) {
      if(level.scoreperplayer) {
        score = level.zone.gameobject.numtouching[team];
      }

      globallogic_score::giveteamscoreforobjective(team, score);
      level.kothtotalsecondsinzone++;

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

        if(!isDefined(player.var_592f3e3c)) {
          player.var_592f3e3c = gettime();
          continue;
        }

        if(player.var_592f3e3c <= gettime() - 5000) {
          player scoreevents::processscoreevent(#"hardpoint_owned", player);
          player.var_592f3e3c = gettime();
        }
      }

      if(isDefined(level.overtime) && level.overtime && isDefined(outcome::function_6d0354e3())) {
        round::function_870759fb();
        thread globallogic::end_round(2);
      }
    }
  }
}

koth_playerspawnedcb() {}

comparezoneindexes(zone_a, zone_b) {
  script_index_a = zone_a.script_index;
  script_index_b = zone_b.script_index;

  if(!isDefined(script_index_a) && !isDefined(script_index_b)) {
    return false;
  }

  if(!isDefined(script_index_a) && isDefined(script_index_b)) {
    println("<dev string:xa9>" + zone_a.origin);
    return true;
  }

  if(isDefined(script_index_a) && !isDefined(script_index_b)) {
    println("<dev string:xa9>" + zone_b.origin);
    return false;
  }

  if(script_index_a > script_index_b) {
    return true;
  }

  return false;
}

getzonearray() {
  zones = getEntArray("koth_zone_center", "targetname");

  if(!isDefined(zones)) {
    return undefined;
  }

  swapped = 1;

  for(n = zones.size; swapped; n--) {
    swapped = 0;

    for(i = 0; i < n - 1; i++) {
      if(comparezoneindexes(zones[i], zones[i + 1])) {
        temp = zones[i];
        zones[i] = zones[i + 1];
        zones[i + 1] = temp;
        swapped = 1;
      }
    }
  }

  return zones;
}

setupzones() {
  zones = getzonearray();

  if(zones.size == 0) {
    globallogic_utils::add_map_error("No zones found for KOTH in map " + util::get_map_name());
  }

  trigs = getEntArray("koth_zone_trigger", "targetname");

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
        zone.trig trigger::function_1792c799(16);
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

    objective_name = #"hardpoint";
    zone.gameobject = gameobjects::create_use_object(#"neutral", zone.trig, visuals, (0, 0, 0), objective_name);
    zone.gameobject gameobjects::set_objective_entity(zone);
    zone.gameobject gameobjects::disable_object();
    zone.gameobject gameobjects::set_model_visibility(0);
    zone.trig.useobj = zone.gameobject;
    zone createzonespawninfluencer();
  }

  if(globallogic_utils::print_map_errors()) {
    return false;
  }

  level.zones = zones;
  level.prevzone = undefined;
  level.prevzone2 = undefined;
  setupzoneexclusions();
  return true;
}

setupzoneexclusions() {
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

getfirstzone() {
  zone = level.zones[0];
  level.prevzone2 = level.prevzone;
  level.prevzone = zone;
  level.prevzoneindex = 0;
  shufflezones();
  arrayremovevalue(level.zonespawnqueue, zone);
  return zone;
}

getnextzone() {
  nextzoneindex = (level.prevzoneindex + 1) % level.zones.size;
  zone = level.zones[nextzoneindex];
  level.prevzone2 = level.prevzone;
  level.prevzone = zone;
  level.prevzoneindex = nextzoneindex;
  return zone;
}

pickrandomzonetospawn() {
  level.prevzoneindex = randomint(level.zones.size);
  zone = level.zones[level.prevzoneindex];
  level.prevzone2 = level.prevzone;
  level.prevzone = zone;
  return zone;
}

shufflezones() {
  level.zonespawnqueue = [];
  spawnqueue = arraycopy(level.zones);

  for(total_left = spawnqueue.size; total_left > 0; total_left--) {
    index = randomint(total_left);
    valid_zones = 0;

    for(zone = 0; zone < level.zones.size; zone++) {
      if(!isDefined(spawnqueue[zone])) {
        continue;
      }

      if(valid_zones == index) {
        if(level.zonespawnqueue.size == 0 && isDefined(level.zone) && level.zone == spawnqueue[zone]) {
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

getnextzonefromqueue() {
  if(level.zonespawnqueue.size == 0) {
    shufflezones();
  }

  assert(level.zonespawnqueue.size > 0);
  next_zone = level.zonespawnqueue[0];
  arrayremoveindex(level.zonespawnqueue, 0);
  return next_zone;
}

function_38874bf6() {
  if(isDefined(level.zone)) {
    return level.zone.origin;
  }
}

function_610d3790(einflictor, victim, idamage, weapon) {
  attacker = self;

  if(!isplayer(attacker) || level.capturetime && !victim.touchtriggers.size && !attacker.touchtriggers.size || attacker.pers[#"team"] == victim.pers[#"team"]) {
    return;
  }

  if(isDefined(weapon) && isDefined(level.iskillstreakweapon)) {
    if([
        [level.iskillstreakweapon]
      ](weapon) || isDefined(weapon.statname) && [
        [level.iskillstreakweapon]
      ](getweapon(weapon.statname))) {
      weaponiskillstreak = 1;
    }
  }

  medalgiven = 0;
  scoreeventprocessed = 0;
  var_1cfdf798 = isDefined(victim.lastattacker) ? victim.lastattacker === attacker : 0;
  ownerteam = undefined;

  if(level.capturetime == 0) {
    if(!isDefined(level.zone)) {
      return;
    }

    ownerteam = level.zone.gameobject.ownerteam;

    if(!isDefined(ownerteam) || ownerteam == #"neutral") {
      return;
    }
  }

  if(victim.touchtriggers.size || level.capturetime == 0 && victim istouching(level.zone.trig)) {
    if(level.capturetime > 0) {
      triggerids = getarraykeys(victim.touchtriggers);
      ownerteam = victim.touchtriggers[triggerids[0]].useobj.ownerteam;
    }

    if(ownerteam != #"neutral") {
      attacker.lastkilltime = gettime();
      team = attacker.pers[#"team"];

      if(team == ownerteam) {
        if(!medalgiven) {
          attacker medals::offenseglobalcount();
          attacker thread challenges::killedbaseoffender(level.zone.trig, weapon, einflictor);
          attacker challenges::function_2f462ffd(victim, weapon, einflictor, level.zone.gameobject);
          attacker.pers[#"objectiveekia"]++;
          attacker.objectiveekia = attacker.pers[#"objectiveekia"];
          attacker.pers[#"objectives"]++;
          attacker.objectives = attacker.pers[#"objectives"];
          medalgiven = 1;
        }

        if(!(isDefined(weaponiskillstreak) && weaponiskillstreak)) {
          scoreevents::processscoreevent(#"hardpoint_kill", attacker, undefined, weapon);
        }

        victim recordkillmodifier("defending");
        scoreeventprocessed = 1;
      } else {
        if(!medalgiven) {
          if(isDefined(attacker.pers[#"defends"])) {
            attacker.pers[#"defends"]++;
            attacker.defends = attacker.pers[#"defends"];
          }

          attacker medals::defenseglobalcount();
          medalgiven = 1;
          attacker thread challenges::killedbasedefender(level.zone.trig);
          attacker challenges::function_2f462ffd(victim, weapon, einflictor, level.zone.gameobject);
          attacker.pers[#"objectiveekia"]++;
          attacker.objectiveekia = attacker.pers[#"objectiveekia"];
          attacker.pers[#"objectives"]++;
          attacker.objectives = attacker.pers[#"objectives"];
          attacker recordgameevent("defending");
        }

        attacker challenges::killedzoneattacker(weapon);

        if(!(isDefined(weaponiskillstreak) && weaponiskillstreak)) {
          scoreevents::processscoreevent(#"hardpoint_kill", attacker, undefined, weapon);
        }

        victim recordkillmodifier("assaulting");
        scoreeventprocessed = 1;
      }
    }
  }

  if(isDefined(level.zone)) {
    if(isDefined(attacker) && isDefined(einflictor) && einflictor != attacker) {
      var_7901de48 = distance2dsquared(level.zone.trig.maxs, level.zone.trig.mins) * 0.5 + 350 * 350;
      dist = distance2dsquared(einflictor.origin, level.zone.origin);

      if(dist > var_7901de48) {
        return;
      }
    }
  }

  if(attacker.touchtriggers.size || level.capturetime == 0 && attacker istouching(level.zone.trig)) {
    if(level.capturetime > 0) {
      triggerids = getarraykeys(attacker.touchtriggers);
      ownerteam = attacker.touchtriggers[triggerids[0]].useobj.ownerteam;
    }

    if(ownerteam != #"neutral") {
      team = victim.pers[#"team"];

      if(team == ownerteam) {
        if(!medalgiven) {
          if(isDefined(attacker.pers[#"defends"])) {
            attacker.pers[#"defends"]++;
            attacker.defends = attacker.pers[#"defends"];
          }

          attacker medals::defenseglobalcount();
          medalgiven = 1;
          attacker thread challenges::killedbasedefender(level.zone.trig);
          attacker recordgameevent("defending");
        }

        if(scoreeventprocessed == 0) {
          attacker challenges::killedzoneattacker(weapon);

          if(!(isDefined(weaponiskillstreak) && weaponiskillstreak)) {
            scoreevents::processscoreevent(#"hardpoint_kill", attacker, undefined, weapon);
          }

          victim recordkillmodifier("assaulting");
          attacker challenges::function_2f462ffd(victim, weapon, einflictor, level.zone.gameobject);
          attacker.pers[#"objectiveekia"]++;
          attacker.objectiveekia = attacker.pers[#"objectiveekia"];
          attacker.pers[#"objectives"]++;
          attacker.objectives = attacker.pers[#"objectives"];
        }
      } else {
        if(!medalgiven) {
          attacker medals::offenseglobalcount();
          medalgiven = 1;
          attacker thread challenges::killedbaseoffender(level.zone.trig, weapon, einflictor);
        }

        if(scoreeventprocessed == 0) {
          if(!(isDefined(weaponiskillstreak) && weaponiskillstreak)) {
            scoreevents::processscoreevent(#"hardpoint_kill", attacker, undefined, weapon);
          }

          victim recordkillmodifier("defending");
          attacker challenges::function_2f462ffd(victim, weapon, einflictor, level.zone.gameobject);
          attacker.pers[#"objectiveekia"]++;
          attacker.objectiveekia = attacker.pers[#"objectiveekia"];
          attacker.pers[#"objectives"]++;
          attacker.objectives = attacker.pers[#"objectives"];
        }
      }
    }
  }

  if(var_1cfdf798 && scoreeventprocessed === 1) {
    attacker challenges::function_82bb78f7(weapon);
  }
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {}

enable_influencers(enabled) {
  enableinfluencer(self.influencer_large, enabled);
  enableinfluencer(self.influencer_small, enabled);
}

createzonespawninfluencer() {
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

updatecapsperminute(lastownerteam) {
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

  if(minutespassed <= 0) {
    self.capsperminute = self.numcaps;
    return;
  }

  self.capsperminute = self.numcaps / minutespassed;

  if(self.capsperminute > self.numcaps) {
    self.capsperminute = self.numcaps;
  }
}

isscoreboosting(player) {
  if(!level.rankedmatch) {
    return false;
  }

  if(player.capsperminute > level.playercapturelpm) {
    return true;
  }

  return false;
}

function_d3a438fb(entity) {
  if(!isDefined(level.zone) || !isDefined(level.zone.trig)) {
    return false;
  }

  if(entity istouching(level.zone.trig)) {
    return true;
  }

  return false;
}

function_a2ef4132() {
  if(isDefined(level.overtime) && level.overtime) {
    return;
  }

  if(isDefined(outcome::function_6d0354e3())) {
    round::function_870759fb();
    thread globallogic::end_round(2);
    return;
  }

  function_841cf30a();
}

function_841cf30a() {
  level.overtime = 1;
  setmatchflag("bomb_timer_a", 0);
  globallogic_audio::leader_dialog("roundOvertime");

  foreach(player in level.players) {
    player luinotifyevent(#"hash_6b67aa04e378d681", 1, 8);
  }
}