/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\globallogic_spawn.gsc
*****************************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\gamestate;
#include scripts\core_common\hostmigration_shared;
#include scripts\core_common\hud_message_shared;
#include scripts\core_common\hud_util_shared;
#include scripts\core_common\match_record;
#include scripts\core_common\math_shared;
#include scripts\core_common\oob;
#include scripts\core_common\player\player_loadout;
#include scripts\core_common\player\player_role;
#include scripts\core_common\player\player_shared;
#include scripts\core_common\spawning_shared;
#include scripts\core_common\spectating;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\killstreaks\killstreaks_shared;
#include scripts\mp_common\armor;
#include scripts\mp_common\bots\mp_bot;
#include scripts\mp_common\callbacks;
#include scripts\mp_common\draft;
#include scripts\mp_common\gametypes\battlechatter;
#include scripts\mp_common\gametypes\globallogic;
#include scripts\mp_common\gametypes\globallogic_audio;
#include scripts\mp_common\gametypes\globallogic_defaults;
#include scripts\mp_common\gametypes\globallogic_score;
#include scripts\mp_common\gametypes\globallogic_ui;
#include scripts\mp_common\gametypes\globallogic_utils;
#include scripts\mp_common\gametypes\hostmigration;
#include scripts\mp_common\gametypes\hud_message;
#include scripts\mp_common\player\player_killed;
#include scripts\mp_common\player\player_loadout;
#include scripts\mp_common\player\player_monitor;
#include scripts\mp_common\player\player_utils;
#include scripts\mp_common\teams\teams;
#include scripts\mp_common\userspawnselection;
#include scripts\mp_common\util;

#namespace globallogic_spawn;

autoexec __init__system__() {
  system::register(#"globallogic_spawn", &__init__, undefined, undefined);
}

__init__() {
  level.var_b3c4b7b7 = getgametypesetting(#"hash_4bf99a809542e4ea");
  level.requirespawnpointstoexistinlevel = 0;
  level.spawnsystem.var_3709dc53 = 0;
  spawning::add_default_spawnlist("auto_normal");
  level.spawnentitytypes = [];
  array::add(level.spawnentitytypes, {
    #team: "all", 
    #entityname: "mp_t8_spawn_point"
  });

  if(level.gametype == #"dom") {
    array::add(level.spawnentitytypes, {
      #team: #"allies", 
      #entityname: "mp_t8_spawn_point"
    });
    array::add(level.spawnentitytypes, {
      #team: #"axis", 
      #entityname: "mp_t8_spawn_point"
    });
  }

  array::add(level.spawnentitytypes, {
    #team: #"allies", 
    #entityname: "mp_t8_spawn_point_allies"
  });
  array::add(level.spawnentitytypes, {
    #team: #"axis", 
    #entityname: "mp_t8_spawn_point_axis"
  });
  level.allspawnpoints = [];
  level.spawnpoints = [];
}

getspawnentitytypes() {
  return level.spawnentitytypes;
}

getmpspawnpoints() {
  return level.allspawnpoints;
}

function_82ca1565(spawnpoint, gametype) {
  switch (gametype) {
    case #"ffa":
      return (isDefined(spawnpoint.ffa) && spawnpoint.ffa);
    case #"sd":
      return (isDefined(spawnpoint.sd) && spawnpoint.sd);
    case #"ctf":
      return (isDefined(spawnpoint.ctf) && spawnpoint.ctf);
    case #"dom":
      return (isDefined(spawnpoint.domination) && spawnpoint.domination);
    case #"dem":
      return (isDefined(spawnpoint.demolition) && spawnpoint.demolition);
    case #"gg":
      return (isDefined(spawnpoint.gg) && spawnpoint.gg);
    case #"tdm":
      return (isDefined(spawnpoint.tdm) && spawnpoint.tdm);
    case #"infil":
      return (isDefined(spawnpoint.infiltration) && spawnpoint.infiltration);
    case #"control":
      return (isDefined(spawnpoint.control) && spawnpoint.control);
    case #"uplink":
      return (isDefined(spawnpoint.uplink) && spawnpoint.uplink);
    case #"kc":
      return (isDefined(spawnpoint.kc) && spawnpoint.kc);
    case #"koth":
      return (isDefined(spawnpoint.hardpoint) && spawnpoint.hardpoint);
    case #"frontline":
      return (isDefined(spawnpoint.frontline) && spawnpoint.frontline);
    case #"dom_flag_a":
      return (isDefined(spawnpoint.domination_flag_a) && spawnpoint.domination_flag_a);
    case #"dom_flag_b":
      return (isDefined(spawnpoint.domination_flag_b) && spawnpoint.domination_flag_b);
    case #"dom_flag_c":
      return (isDefined(spawnpoint.domination_flag_c) && spawnpoint.domination_flag_c);
    case #"hash_6056c310624d5afd":
      return (isDefined(spawnpoint.demolition_attacker_a) && spawnpoint.demolition_attacker_a);
    case #"hash_6056c010624d55e4":
      return (isDefined(spawnpoint.demolition_attacker_b) && spawnpoint.demolition_attacker_b);
    case #"hash_6ef2d89ce8ee9a32":
      return (isDefined(spawnpoint.demolition_remove_a) && spawnpoint.demolition_remove_a);
    case #"hash_6ef2d79ce8ee987f":
      return (isDefined(spawnpoint.demolition_remove_b) && spawnpoint.demolition_remove_b);
    case #"dem_overtime":
      return (isDefined(spawnpoint.demolition_overtime) && spawnpoint.demolition_overtime);
    case #"hash_7cb9d0a58715cebe":
      return (isDefined(spawnpoint.demolition_start_spawn) && spawnpoint.demolition_start_spawn);
    case #"hash_6d83e5f1bdefa7dd":
      return (isDefined(spawnpoint.demolition_defender_a) && spawnpoint.demolition_defender_a);
    case #"hash_6d83e2f1bdefa2c4":
      return (isDefined(spawnpoint.demolition_defender_b) && spawnpoint.demolition_defender_b);
    case #"control_attack_add_0":
      return (isDefined(spawnpoint.control_attack_add_a) && spawnpoint.control_attack_add_a);
    case #"control_attack_add_1":
      return (isDefined(spawnpoint.control_attack_add_b) && spawnpoint.control_attack_add_b);
    case #"control_attack_remove_0":
      return (isDefined(spawnpoint.control_attack_remove_a) && spawnpoint.control_attack_remove_a);
    case #"control_attack_remove_1":
      return (isDefined(spawnpoint.control_attack_remove_b) && spawnpoint.control_attack_remove_b);
    case #"control_defend_add_0":
      return (isDefined(spawnpoint.registerlast_mapshouldstun) && spawnpoint.registerlast_mapshouldstun);
    case #"control_defend_add_1":
      return (isDefined(spawnpoint.control_defend_add_b) && spawnpoint.control_defend_add_b);
    case #"control_defend_remove_0":
      return (isDefined(spawnpoint.control_defend_remove_a) && spawnpoint.control_defend_remove_a);
    case #"control_defend_remove_1":
      return (isDefined(spawnpoint.control_defend_remove_b) && spawnpoint.control_defend_remove_b);
    case #"ct":
      return (isDefined(spawnpoint.ct) && spawnpoint.ct);
    case #"escort":
      return (isDefined(spawnpoint.escort) && spawnpoint.escort);
    case #"bounty":
      return (isDefined(spawnpoint.bounty) && spawnpoint.bounty);
    default:
      assertmsg("<dev string:x38>" + gametype + "<dev string:x46>" + spawnpoint.origin[0] + "<dev string:x71>" + spawnpoint.origin[1] + "<dev string:x78>" + spawnpoint.origin[2]);
      break;
  }

  return false;
}

addsupportedspawnpointtype(spawnpointtype, team) {
  if(!isDefined(level.supportedspawntypes)) {
    level.supportedspawntypes = [];
  }

  spawnpointstruct = spawnStruct();
  spawnpointstruct.type = spawnpointtype;

  if(isDefined(team)) {
    spawnpointstruct.team = team;
  }

  array::add(level.supportedspawntypes, spawnpointstruct);
}

function_c40af6fa() {
  level.supportedspawntypes = [];
  level.allspawnpoints = [];
}

function_d3d4ff67(spawn) {
  foreach(var_a24ffdcc in level.supportedspawntypes) {
    supportedspawntype = var_a24ffdcc.type;

    if(function_82ca1565(spawn, supportedspawntype)) {
      return true;
    }
  }

  return false;
}

addspawnsforteamname(teamname, searchentity, &spawnarray, &startspawns) {
  rawspawns = struct::get_array(searchentity, "targetname");

  foreach(spawn in rawspawns) {
    array::add(level.allspawnpoints, spawn);
    spawn.team = teamname;

    foreach(var_a24ffdcc in level.supportedspawntypes) {
      supportedspawntype = var_a24ffdcc.type;

      if(!function_82ca1565(spawn, supportedspawntype)) {
        continue;
      }

      teamname = util::get_team_mapping(teamname);

      if(isDefined(var_a24ffdcc.team)) {
        if(teamname != var_a24ffdcc.team) {
          continue;
        }
      }

      usespawnarray = isDefined(spawn._human_were) ? spawn._human_were : 0 ? startspawns : spawnarray;

      if(!isDefined(usespawnarray[teamname])) {
        usespawnarray[teamname] = [];
      }

      if(!isDefined(spawn.enabled)) {
        spawn.enabled = -1;
      }

      array::add(usespawnarray[teamname], spawn);
    }
  }
}

function_d400d613(targetname, typesarray) {
  returnarray = [];
  rawspawns = struct::get_array(targetname, "targetname");

  foreach(spawn in rawspawns) {
    foreach(supportedspawntype in typesarray) {
      if(!function_82ca1565(spawn, supportedspawntype)) {
        continue;
      }

      if(!isDefined(returnarray[supportedspawntype])) {
        returnarray[supportedspawntype] = [];
      }

      if(!isDefined(returnarray[supportedspawntype])) {
        returnarray[supportedspawntype] = [];
      } else if(!isarray(returnarray[supportedspawntype])) {
        returnarray[supportedspawntype] = array(returnarray[supportedspawntype]);
      }

      returnarray[supportedspawntype][returnarray[supportedspawntype].size] = spawn;
    }
  }

  return returnarray;
}

private function_68312709() {
  spawnstoadd = [];
  startspawns = [];

  foreach(spawnentitytype in level.spawnentitytypes) {
    addspawnsforteamname(spawnentitytype.team, spawnentitytype.entityname, spawnstoadd, startspawns);
  }

  spawnteams = getarraykeys(spawnstoadd);

  foreach(spawnteam in spawnteams) {
    if(spawnteam == "all") {
      if(sessionmodeiswarzonegame()) {
        addspawnpoints("free", spawnstoadd[spawnteam], "auto_normal");
        addspawnpoints(#"axis", spawnstoadd[spawnteam], "fallback");
        addspawnpoints(#"allies", spawnstoadd[spawnteam], "fallback");
        enablespawnpointlist("auto_normal", util::getteammask("free"));
        level.spawnpoints = arraycombine(level.spawnpoints, spawnstoadd[spawnteam], 0, 0);
      } else {
        foreach(team, _ in level.teams) {
          addspawnpoints(team, spawnstoadd[spawnteam], "auto_normal");
          level.spawnpoints = arraycombine(level.spawnpoints, spawnstoadd[spawnteam], 0, 0);
          enablespawnpointlist("auto_normal", util::getteammask(team));
        }
      }

      continue;
    }

    teamforspawns = spawning::function_1bc642b7() ? util::getotherteam(spawnteam) : spawnteam;
    addspawnpoints(teamforspawns, spawnstoadd[spawnteam], "auto_normal");
    otherteam = util::getotherteam(teamforspawns);
    addspawnpoints(otherteam, spawnstoadd[spawnteam], "fallback");
    enablespawnpointlist("auto_normal", util::getteammask(teamforspawns));

    foreach(spawnpoint in spawnstoadd[spawnteam]) {
      array::add(level.spawnpoints, spawnpoint, 0);
    }
  }

  if(!isDefined(level.spawn_start)) {
    level.spawn_start = [];
  }

  var_d74bb7ad = getarraykeys(startspawns);

  foreach(spawnteam in var_d74bb7ad) {
    if(spawnteam == "all") {
      foreach(team, _ in level.teams) {
        if(!isDefined(level.spawn_start[team])) {
          level.spawn_start[team] = [];
        }

        level.spawn_start[team] = arraycombine(level.spawn_start[team], startspawns[spawnteam], 0, 0);
      }

      continue;
    }

    teamforspawns = spawning::function_1bc642b7() ? util::getotherteam(spawnteam) : spawnteam;

    if(!isDefined(level.spawn_start[teamforspawns])) {
      level.spawn_start[teamforspawns] = [];
    }

    level.spawn_start[teamforspawns] = arraycombine(level.spawn_start[teamforspawns], startspawns[spawnteam], 0, 0);
  }
}

function_8acd9309() {
  spawnarray = [];
  startspawns = [];

  if(!isDefined(level.allspawnpoints)) {
    level.allspawnpoints = [];
  }

  foreach(spawnentitytype in level.spawnentitytypes) {
    rawspawns = struct::get_array(spawnentitytype.entityname, "targetname");

    foreach(spawn in rawspawns) {
      array::add(level.allspawnpoints, spawn);

      foreach(var_a24ffdcc in level.supportedspawntypes) {
        supportedspawntype = var_a24ffdcc.type;

        if(!function_82ca1565(spawn, supportedspawntype)) {
          continue;
        }

        usespawnarray = isDefined(spawn._human_were) ? spawn._human_were : 0 ? startspawns : spawnarray;

        if(!isDefined(spawn.enabled)) {
          spawn.enabled = -1;
        }

        array::add(usespawnarray, spawn);
      }
    }
  }

  addspawnpoints("free", spawnarray, "auto_normal");
  enablespawnpointlist("auto_normal", util::getteammask("free"));
  level.spawnpoints = arraycombine(level.spawnpoints, spawnarray, 0, 0);

  if(!isDefined(level.spawn_start)) {
    level.spawn_start = [];
  }

  if(!isDefined(level.spawn_start[#"free"])) {
    level.spawn_start[#"free"] = [];
  }

  level.spawn_start[#"free"] = arraycombine(level.spawn_start[#"free"], startspawns, 0, 0);
}

addspawns() {
  clearspawnpoints("auto_normal");
  clearspawnpoints("fallback");

  if(level.teambased) {
    if(!isDefined(level.supportedspawntypes)) {
      println("<dev string:x7f>");
      addsupportedspawnpointtype("tdm");
    }

    function_68312709();
  } else {
    function_8acd9309();
  }

  calculate_map_center();
  spawnpoint = spawning::get_random_intermission_point();
  setdemointermissionpoint(spawnpoint.origin, spawnpoint.angles);
}

calculate_map_center() {
  if(!isDefined(level.mapcenter)) {
    spawn_points = level.spawnpoints;

    if(isDefined(spawn_points[0])) {
      level.spawnmins = spawn_points[0].origin;
      level.spawnmaxs = spawn_points[0].origin;
    } else {
      level.spawnmins = (0, 0, 0);
      level.spawnmaxs = (0, 0, 0);
    }

    for(index = 0; index < spawn_points.size; index++) {
      origin = spawn_points[index].origin;
      level.spawnmins = math::expand_mins(level.spawnmins, origin);
      level.spawnmaxs = math::expand_maxs(level.spawnmaxs, origin);
    }

    level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
    setmapcenter(level.mapcenter);
  }
}

timeuntilspawn(includeteamkilldelay) {
  if(level.ingraceperiod && isDefined(self.hasspawned) && !self.hasspawned) {
    return 0;
  }

  respawndelay = 0;

  if(isDefined(self.hasspawned) && self.hasspawned) {
    result = self[[level.onrespawndelay]]();

    if(isDefined(result)) {
      respawndelay = result;
    } else {
      respawndelay = level.playerrespawndelay;
    }

    if(isDefined(level.playerincrementalrespawndelay) && isDefined(self.pers[#"spawns"])) {
      respawndelay += level.playerincrementalrespawndelay * self.pers[#"spawns"];
    }

    if(isDefined(self.suicide) && self.suicide && level.suicidespawndelay > 0) {
      respawndelay += level.suicidespawndelay;
    }

    if(isDefined(self.teamkilled) && self.teamkilled && level.teamkilledspawndelay > 0) {
      respawndelay += level.teamkilledspawndelay;
    }

    if(includeteamkilldelay && isDefined(self.teamkillpunish) && self.teamkillpunish) {
      respawndelay += player::function_821200bb();
    }
  }

  if(isDefined(level.deathcirclerespawn) && level.deathcirclerespawn) {
    return self function_ac5b273c(respawndelay);
  }

  wavebased = level.waverespawndelay > 0;

  if(wavebased) {
    return self timeuntilwavespawn(respawndelay);
  }

  if(isDefined(self.usedresurrect) && self.usedresurrect) {
    return 0;
  }

  return respawndelay;
}

allteamshaveexisted() {
  foreach(team, _ in level.teams) {
    if(!teams::function_9dd75dad(team)) {
      return false;
    }

    if(level.everexisted[team] > gettime() + 1000) {
      return false;
    }
  }

  return true;
}

function_38527849() {
  if(level.numlives || level.numteamlives) {
    if(level.numlives && !self.pers[#"lives"]) {
      return false;
    } else if(!level.numlives && level.numteamlives && game.lives[self.team] <= 0) {
      return false;
    } else {
      if(level.teambased) {
        gamehasstarted = allteamshaveexisted();
      } else {
        gamehasstarted = level.maxplayercount > 1 || !util::isoneround() && !util::isfirstround();
      }

      if(gamehasstarted && isDefined(level.var_60507c71) && level.var_60507c71) {
        if(!level.ingraceperiod && !self.hasspawned) {
          return false;
        }
      }
    }
  }

  return true;
}

mayspawn() {
  if(isDefined(level.mayspawn) && !self[[level.mayspawn]]()) {
    return false;
  }

  if(level.playerqueuedrespawn && !isDefined(self.allowqueuespawn) && !level.ingraceperiod && !level.usestartspawns) {
    return false;
  }

  if(game.state == "playing" && level.var_c2cc011f && level.aliveplayers[self.team].size == 0) {
    return false;
  }

  if(isDefined(level.var_75db41a7) && gettime() >= level.var_75db41a7) {
    return false;
  }

  if(isDefined(self.iseliminated) && self.iseliminated) {
    return false;
  }

  return function_38527849();
}

function_ac5b273c(minimumwait) {
  earliestspawntime = gettime() + int(minimumwait * 1000);

  if(!isDefined(level.var_56baa802)) {
    return 0;
  }

  return max(float(level.var_56baa802 - gettime()) / 1000, 0);
}

timeuntilwavespawn(minimumwait) {
  earliestspawntime = gettime() + int(minimumwait * 1000);
  lastwavetime = level.lastwave[self.pers[#"team"]];
  wavedelay = int(level.wavedelay[self.pers[#"team"]] * 1000);

  if(wavedelay == 0) {
    return 0;
  }

  numwavespassedearliestspawntime = (earliestspawntime - lastwavetime) / wavedelay;
  numwaves = ceil(numwavespassedearliestspawntime);
  timeofspawn = lastwavetime + numwaves * wavedelay;

  if(isDefined(self.wavespawnindex)) {
    timeofspawn += 50 * self.wavespawnindex;
  }

  return float(timeofspawn - gettime()) / 1000;
}

stoppoisoningandflareonspawn() {
  self endon(#"disconnect");
  self.inpoisonarea = 0;
  self.inburnarea = 0;
  self.inflarevisionarea = 0;
  self.ingroundnapalm = 0;
}

spawnplayerprediction() {
  self endon(#"disconnect", #"end_respawn", #"game_ended", #"joined_spectators", #"spawned");
  plrs = teams::count_players();
  nolivesleft = level.numlives && !self.pers[#"lives"] || level.numteamlives && game.lives[self.team] > 0;

  if(nolivesleft) {
    return;
  }

  while(true) {
    wait 0.5;
    spawning::onspawnplayer(1);
  }
}

playmatchstartaudio(team) {
  self endon(#"disconnect");

  for(index = 0; index < 5; index++) {
    waitframe(1);
  }

  if(self.pers[#"playedgamemode"] !== 1) {
    if(level.hardcoremode) {
      if(globallogic_utils::function_308e3379()) {
        self globallogic_audio::leader_dialog_on_player(level.leaderdialog.var_d04b3734);
      } else {
        self globallogic_audio::leader_dialog_on_player(level.leaderdialog.starthcgamedialog);
      }
    } else if(globallogic_utils::function_308e3379()) {
      self globallogic_audio::leader_dialog_on_player(level.leaderdialog.var_f6fda321);
    } else {
      self globallogic_audio::leader_dialog_on_player(level.leaderdialog.startgamedialog);
    }

    self.pers[#"playedgamemode"] = 1;
  }

  if(team == game.attackers) {
    self globallogic_audio::leader_dialog_on_player(level.leaderdialog.offenseorderdialog);
    return;
  }

  self globallogic_audio::leader_dialog_on_player(level.leaderdialog.defenseorderdialog);
}

doinitialspawnmessaging(params = undefined) {
  pixbeginevent(#"sound");

  if(sessionmodeismultiplayergame() && !(isDefined(self.var_b279086a) && self.var_b279086a)) {
    self show();
    self solid();
  }

  if(level.gametype !== "bounty") {
    if(isDefined(self.pers[#"music"].spawn) && self.pers[#"music"].spawn == 0) {
      if(game.roundsplayed == 0) {
        self thread globallogic_audio::set_music_on_player("spawnFull");
      } else {
        self thread globallogic_audio::set_music_on_player("spawnShort");
      }

      self.pers[#"music"].spawn = 1;
    }
  }

  if(level.splitscreen) {
    if(isDefined(level.playedstartingmusic)) {
      music = undefined;
    } else {
      level.playedstartingmusic = 1;
    }
  }

  self.playleaderdialog = 1;

  if(isDefined(level.leaderdialog)) {
    self thread playmatchstartaudio(self.pers[#"team"]);
  }

  pixendevent();
}

resetattackersthisspawnlist() {
  self.attackersthisspawn = [];
}

spawnplayer() {
  pixbeginevent(#"spawnplayer_preuts");
  self endon(#"disconnect", #"joined_spectators");
  hadspawned = self.hasspawned;
  self player::spawn_player();

  if(globallogic_utils::getroundstartdelay()) {
    self thread globallogic_utils::applyroundstartdelay();
  }

  if(isDefined(self.spawnlightarmor) && self.spawnlightarmor > 0) {
    self thread armor::setlightarmor(self.spawnlightarmor);
  }

  self.nextkillstreakfree = undefined;
  self.deathmachinekills = 0;
  self resetattackersthisspawnlist();
  self.diedonvehicle = undefined;

  if(isDefined(self.wasaliveatmatchstart) && !self.wasaliveatmatchstart) {
    if(level.ingraceperiod || globallogic_utils::gettimepassed() < int(20 * 1000)) {
      self.wasaliveatmatchstart = 1;
    }
  }

  pixbeginevent(#"onspawnplayer");
  self[[level.onspawnplayer]](0);

  if(isDefined(level.playerspawnedcb)) {
    self[[level.playerspawnedcb]]();
  }

  pixendevent();
  pixendevent();
  level thread globallogic::updateteamstatus();
  pixbeginevent(#"spawnplayer_postuts");
  self val::nuke("disable_oob");
  self thread stoppoisoningandflareonspawn();
  self.sensorgrenadedata = undefined;
  self.var_342564dd = 0;
  self.var_6a9b15ba = undefined;
  self.var_ec59e88c = undefined;

  if(level.var_b3c4b7b7 === 1) {
    self player_role::clear();
    draft::assign_remaining_players(self);
  }

  role = self player_role::get();
  assert(!loadout::function_87bcb1b() || globallogic_utils::isvalidclass(self.curclass));
  assert(player_role::is_valid(role));
  self.pers[#"momentum_at_spawn_or_game_end"] = isDefined(self.pers[#"momentum"]) ? self.pers[#"momentum"] : 0;

  if(loadout::function_87bcb1b()) {
    self loadout::function_53b62db1(self.curclass);
  }

  self loadout::give_loadout(self.team, self.curclass);

  if(sessionmodeismultiplayergame() || sessionmodeiswarzonegame()) {
    specialist = function_b14806c6(role, currentsessionmode());

    if(isDefined(specialist)) {
      self function_6c3348ac(specialist);
    }

    var_be574bd8 = self getcharacterlootid();
    outfitindex = self getcharacteroutfit();
    gender = self getplayergendertype();
    warpaintoutfitindex = self getcharacterwarpaintoutfit();
    var_8fa79650 = self getcharacterwarpaintlootid();
    decallootid = self getcharacterdecallootid();
    var_b3d9cfaa = self function_11d0e790();
    var_f8e6b703 = self match_record::get_player_stat(#"hash_ec4aea1a8bbd82");

    if(isDefined(var_f8e6b703)) {
      self match_record::set_stat(#"lives", var_f8e6b703, #"character_gender", gender);
      self match_record::set_stat(#"lives", var_f8e6b703, #"character_decal_lootid", decallootid);
      self match_record::set_stat(#"lives", var_f8e6b703, #"character_outfit_lootid", var_be574bd8);
      self match_record::set_stat(#"lives", var_f8e6b703, #"character_warpaint_lootid", var_8fa79650);
      self match_record::set_stat(#"lives", var_f8e6b703, #"character_outfit", outfitindex);
      self match_record::set_stat(#"lives", var_f8e6b703, #"character_warpaint_outfit", warpaintoutfitindex);

      for(i = 0; i < var_b3d9cfaa.size; i++) {
        self match_record::set_stat(#"lives", var_f8e6b703, #"hash_20d6751cb2f9ca09", i, var_b3d9cfaa[i]);
      }
    }
  }

  if(level.inprematchperiod) {
    self val::set(#"spawn_player", "freezecontrols");
    self val::set(#"spawn_player", "disablegadgets");

    if(sessionmodeismultiplayergame()) {
      self ghost();
      self notsolid();
    }

    self callback::on_prematch_end(&doinitialspawnmessaging);
  } else {
    self val::reset(#"spawn_player", "freezecontrols");
    self val::reset(#"spawn_player", "disablegadgets");
    self enableweapons();

    if(!(isDefined(hadspawned) && hadspawned) && game.state == "playing") {
      self thread doinitialspawnmessaging();
    }
  }

  if(isDefined(level.scoreresetondeath) && level.scoreresetondeath) {
    self globallogic_score::resetplayermomentumonspawn();
  }

  self.deathtime = 0;
  self.pers[#"deathtime"] = 0;

  if(self hasperk(#"specialty_anteup")) {
    anteup_bonus = getdvarint(#"perk_killstreakanteupresetvalue", 0);

    if(self.pers[#"momentum_at_spawn_or_game_end"] < anteup_bonus) {
      globallogic_score::_setplayermomentum(self, anteup_bonus, 0);
    }
  }

  if(!isDefined(getdvar(#"scr_showperksonspawn"))) {
    setdvar(#"scr_showperksonspawn", 0);
  }

  if(level.hardcoremode) {
    setdvar(#"scr_showperksonspawn", 0);
  }

  if(getdvarint(#"scr_showperksonspawn", 0) == 1 && !gamestate::is_game_over()) {
    pixbeginevent(#"showperksonspawn");

    if(level.perksenabled == 1) {
      self hud::showperks();
    }

    pixendevent();
  }

    if(isDefined(self.pers[#"momentum"])) {
      self.momentum = self.pers[#"momentum"];
    }

  self callback::function_d8abfc3d(#"on_end_game", &on_end_game);
  self setsprintboost(0);
  pixendevent();
  waittillframeend();
  self notify(#"spawned_player");
  callback::callback(#"on_player_spawned");
  self thread player_monitor::monitor();

  print("<dev string:xdb>" + self.origin[0] + "<dev string:xe0>" + self.origin[1] + "<dev string:xe0>" + self.origin[2] + "<dev string:xe4>");

    setdvar(#"scr_selecting_location", "");

  if(gamestate::is_game_over()) {
    assert(!level.intermission);
    self player::freeze_player_for_round_end();
  }

  self util::set_lighting_state();
}

on_end_game() {
  self.pers[#"momentum_at_spawn_or_game_end"] = isDefined(self.pers[#"momentum"]) ? self.pers[#"momentum"] : 0;
}

spawnspectator(origin, angles) {
  self notify(#"spawned");
  self notify(#"end_respawn");
  in_spawnspectator(origin, angles);
}

respawn_asspectator(origin, angles) {
  in_spawnspectator(origin, angles);
}

function_3ee5119e() {
  if(self.pers[#"team"] != #"spectator" && level.spectatetype == 4 && self.spectatorteam == #"invalid") {
    team_players = getplayers(self.team);

    foreach(player in team_players) {
      if(player != self && isalive(player)) {
        self.spectatorteam = player.team;
        println("<dev string:xe8>" + player.team + "<dev string:x105>" + self.name + "<dev string:x10d>" + self.team + "<dev string:x11f>" + player.name + "<dev string:x12b>");
        return;
      }
    }

    foreach(player in team_players) {
      if(player != self && player.spectatorteam != #"invalid") {
        self.spectatorteam = player.spectatorteam;
        println("<dev string:xe8>" + player.spectatorteam + "<dev string:x105>" + self.name + "<dev string:x10d>" + self.team + "<dev string:x11f>" + player.name + "<dev string:x137>");
        return;
      }
    }

    self.spectatorteam = self.team;
    println("<dev string:xe8>" + self.spectatorteam + "<dev string:x105>" + self.name + "<dev string:x10d>" + self.team + "<dev string:x152>");
  }
}

in_spawnspectator(origin, angles) {
  pixmarker("BEGIN: in_spawnSpectator");
  self player::set_spawn_variables();
  self.sessionstate = "spectator";
  self.killcamentity = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
  self.spectatekillcam = 0;
  self.friendlydamage = undefined;

  if(self.pers[#"team"] == #"spectator") {
    self.statusicon = "";
  } else {
    self.statusicon = "hud_status_dead";
  }

  if(level.spectatetype != 4 || self.pers[#"team"] == #"spectator") {
    self.spectatorclient = -1;
    spectating::set_permissions_for_machine();
  }

  function_3ee5119e();
  [[level.onspawnspectator]](origin, angles);

  if(level.teambased && !level.splitscreen) {
    self thread spectatorthirdpersonness();
  }

  level thread globallogic::updateteamstatus();
  pixmarker("END: in_spawnSpectator");
}

spectatorthirdpersonness() {
  self endon(#"disconnect", #"spawned");
  self notify(#"spectator_thirdperson_thread");
  self endon(#"spectator_thirdperson_thread");
  self.spectatingthirdperson = 0;
}

forcespawn(time) {
  self endon(#"death", #"disconnect", #"spawned");

  if(!isDefined(time)) {
    time = 60;
  }

  wait time;

  if(isDefined(self.hasspawned) && self.hasspawned) {
    return;
  }

  if(self.pers[#"team"] == #"spectator") {
    return;
  }

  if(!globallogic_utils::isvalidclass(self.pers[#"class"])) {
    self.pers[#"class"] = "CLASS_CUSTOM1";
    self.curclass = self.pers[#"class"];
  }

  if(!function_8b1a219a()) {
    self globallogic_ui::closemenus();
  }

  self thread[[level.spawnclient]]();
}

kickifdontspawn() {

  if(getdvarint(#"scr_hostmigrationtest", 0) == 1) {
    return;
  }

    if(self ishost()) {
      return;
    }

  self kickifidontspawninternal();
}

kickifidontspawninternal() {
  self endon(#"death", #"disconnect", #"spawned");

  while(true) {
    if(!(isDefined(level.inprematchperiod) && level.inprematchperiod) && self isstreamerready()) {
      break;
    }

    wait 5;
  }

  waittime = 90;

  if(getdvarstring(#"scr_kick_time") != "") {
    waittime = getdvarfloat(#"scr_kick_time", 0);
  }

  mintime = 45;

  if(getdvarstring(#"scr_kick_mintime") != "") {
    mintime = getdvarfloat(#"scr_kick_mintime", 0);
  }

  starttime = gettime();
  kickwait(waittime);
  timepassed = float(gettime() - starttime) / 1000;

  if(timepassed < waittime - 0.1 && timepassed < mintime) {
    return;
  }

  if(isDefined(self.hasspawned) && self.hasspawned) {
    return;
  }

  if(sessionmodeisprivate()) {
    return;
  }

  if(self.pers[#"team"] == #"spectator") {
    return;
  }

  if(!mayspawn() && self.pers[#"time_played_total"] > 0) {
    return;
  }

  globallogic::gamehistoryplayerkicked();
  kick(self getentitynumber(), "EXE/PLAYERKICKED_NOTSPAWNED");
}

kickwait(waittime) {
  level endon(#"game_ended");
  hostmigration::waitlongdurationwithhostmigrationpause(waittime);
}

spawninterroundintermission() {
  self notify(#"spawned");
  self notify(#"end_respawn");
  self player::set_spawn_variables();
  self hud_message::clearlowermessage();
  self val::reset(#"spawn_player", "freezecontrols");
  self val::reset(#"spawn_player", "disablegadgets");
  self.sessionstate = "spectator";
  self.spectatorclient = -1;
  self.killcamentity = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
  self.spectatekillcam = 0;
  self.friendlydamage = undefined;
  self globallogic_defaults::default_onspawnintermission();
  self setorigin(self.origin);
  self setplayerangles(self.angles);
  self clientfield::set_to_player("player_dof_settings", 2);
}

spawnintermission(usedefaultcallback, endgame) {
  self notify(#"spawned");
  self notify(#"end_respawn");
  self endon(#"disconnect");
  self player::set_spawn_variables();
  self hud_message::clearlowermessage();
  self val::reset(#"spawn_player", "freezecontrols");
  self val::reset(#"spawn_player", "disablegadgets");
  self.sessionstate = "intermission";
  self.spectatorclient = -1;
  self.killcamentity = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
  self.spectatekillcam = 0;
  self.friendlydamage = undefined;

  if(isDefined(usedefaultcallback) && usedefaultcallback) {
    globallogic_defaults::default_onspawnintermission();
  } else {
    [[level.onspawnintermission]](endgame);
  }

  self clientfield::set_to_player("player_dof_settings", 2);
}

spawnqueuedclientonteam(team) {
  player_to_spawn = undefined;

  for(i = 0; i < level.deadplayers[team].size; i++) {
    player = level.deadplayers[team][i];

    if(player.waitingtospawn) {
      continue;
    }

    player_to_spawn = player;
    break;
  }

  if(isDefined(player_to_spawn)) {
    player_to_spawn.allowqueuespawn = 1;
    player_to_spawn globallogic_ui::closemenus();
    player_to_spawn thread[[level.spawnclient]]();
  }
}

spawnqueuedclient(dead_player_team, killer) {
  if(!level.playerqueuedrespawn) {
    return;
  }

  util::waittillslowprocessallowed();
  spawn_team = undefined;

  if(isDefined(killer) && isDefined(killer.team) && isDefined(level.teams[killer.team])) {
    spawn_team = killer.team;
  }

  if(isDefined(spawn_team)) {
    spawnqueuedclientonteam(spawn_team);
    return;
  }

  foreach(team, _ in level.teams) {
    if(team == dead_player_team) {
      continue;
    }

    spawnqueuedclientonteam(team);
  }
}

allteamsnearscorelimit() {
  if(!level.teambased) {
    return false;
  }

  if(level.scorelimit <= 1) {
    return false;
  }

  foreach(team, _ in level.teams) {
    if(!(game.stat[#"teamscores"][team] >= level.scorelimit - 1)) {
      return false;
    }
  }

  return true;
}

shouldshowrespawnmessage() {
  if(util::waslastround()) {
    return false;
  }

  if(util::isoneround()) {
    return false;
  }

  if(isDefined(level.livesdonotreset) && level.livesdonotreset) {
    return false;
  }

  if(allteamsnearscorelimit()) {
    return false;
  }

  return true;
}

default_spawnmessage() {
  if(util::getroundsplayed() + 1 < level.roundlimit) {
    hud_message::setlowermessage(game.strings[#"spawn_next_round"]);
    self thread globallogic_ui::removespawnmessageshortly(3);
  }
}

showspawnmessage() {
  if(shouldshowrespawnmessage()) {
    self thread[[level.spawnmessage]]();
  }
}

spawnclient(timealreadypassed) {
  pixbeginevent(#"spawnclient");
  assert(isDefined(self.team));
  assert(!loadout::function_87bcb1b() || globallogic_utils::isvalidclass(self.curclass));

  if(!self mayspawn() && !(isDefined(self.usedresurrect) && self.usedresurrect)) {
    currentorigin = self.origin;
    currentangles = self.angles;
    self showspawnmessage();
    self thread[[level.spawnspectator]](currentorigin + (0, 0, 60), currentangles);
    pixendevent();
    return;
  }

  if(isDefined(self.waitingtospawn) && self.waitingtospawn) {
    pixendevent();
    return;
  }

  self.waitingtospawn = 1;
  self.allowqueuespawn = undefined;

  if(!(isDefined(level.takelivesondeath) && level.takelivesondeath)) {
    game.lives[self.team]--;
  }

  self waitandspawnclient(timealreadypassed);

  if(isDefined(self)) {
    self.waitingtospawn = 0;
  }

  pixendevent();
}

waitandspawnclient(timealreadypassed) {
  self endon(#"disconnect", #"end_respawn");
  level endon(#"game_ended");

  if(!isDefined(timealreadypassed)) {
    timealreadypassed = 0;
  }

  spawnedasspectator = 0;

  if(isDefined(self.teamkillpunish) && self.teamkillpunish) {
    var_821200bb = player::function_821200bb();

    if(var_821200bb > timealreadypassed) {
      var_821200bb -= timealreadypassed;
      timealreadypassed = 0;
    } else {
      timealreadypassed -= var_821200bb;
      var_821200bb = 0;
    }

    if(var_821200bb > 0) {
      hud_message::setlowermessage(#"mp/friendly_fire_will_not", var_821200bb);
      self thread respawn_asspectator(self.origin + (0, 0, 60), self.angles);
      spawnedasspectator = 1;
      wait var_821200bb;
    }

    self.teamkillpunish = 0;
  }

  if(!isDefined(self.wavespawnindex) && isDefined(level.waveplayerspawnindex[self.team])) {
    self.wavespawnindex = level.waveplayerspawnindex[self.team];
    level.waveplayerspawnindex[self.team]++;
  }

  timeuntilspawn = timeuntilspawn(0);

  if(timeuntilspawn > timealreadypassed) {
    timeuntilspawn -= timealreadypassed;
    timealreadypassed = 0;
  } else {
    timealreadypassed -= timeuntilspawn;
    timeuntilspawn = 0;
  }

  if(timeuntilspawn > 0) {
    if(!sessionmodeiswarzonegame()) {
      if(level.playerqueuedrespawn) {
        hud_message::setlowermessage(game.strings[#"you_will_spawn"], timeuntilspawn);
      } else {
        hud_message::setlowermessage(game.strings[#"waiting_to_spawn"], timeuntilspawn);
      }
    }

    if(!spawnedasspectator) {
      spawnorigin = self.origin + (0, 0, 60);
      spawnangles = self.angles;

      if(isDefined(level.useintermissionpointsonwavespawn) && [
          [level.useintermissionpointsonwavespawn]
        ]() == 1) {
        spawnpoint = spawning::get_random_intermission_point();

        if(isDefined(spawnpoint)) {
          spawnorigin = spawnpoint.origin;
          spawnangles = spawnpoint.angles;
        }
      }

      self thread respawn_asspectator(spawnorigin, spawnangles);
    }

    spawnedasspectator = 1;

    if(!sessionmodeiswarzonegame()) {
      self function_6c23d45b(timeuntilspawn, "force_spawn");
    } else {
      self globallogic_utils::waitfortimeornotify(timeuntilspawn, "force_spawn");
    }

    self notify(#"stop_wait_safe_spawn_button");
  }

  wavebased = level.waverespawndelay > 0;

  if(!level.playerforcerespawn && self.hasspawned && !wavebased && !self.wantsafespawn && !level.playerqueuedrespawn) {
    hud_message::setlowermessage(game.strings[#"press_to_spawn"]);

    if(!spawnedasspectator) {
      self thread respawn_asspectator(self.origin + (0, 0, 60), self.angles);
    }

    spawnedasspectator = 1;
    self waitrespawnorsafespawnbutton();
  }

  self.waitingtospawn = 0;
  self hud_message::clearlowermessage();
  self.wavespawnindex = undefined;
  self.respawntimerstarttime = undefined;
  self.pers[#"spawns"]++;
  self thread[[level.spawnplayer]]();
}

function_6c23d45b(time, notifyname) {
  timeleft = time;
  self endon(notifyname);

  while(timeleft > 0) {
    if(level.playerqueuedrespawn) {
      hud_message::setlowermessage(game.strings[#"you_will_spawn"], timeleft);
    } else {
      hud_message::setlowermessage(game.strings[#"waiting_to_spawn"], timeleft);
    }

    if(timeleft > 0 && timeleft < 1) {
      wait timeleft;
    } else {
      wait 1;
    }

    timeleft -= 1;
  }
}

waitrespawnorsafespawnbutton() {
  self endon(#"disconnect", #"end_respawn");

  while(true) {
    if(self usebuttonpressed()) {
      break;
    }

    waitframe(1);
  }
}

waitinspawnqueue() {
  self endon(#"disconnect", #"end_respawn");

  if(!level.ingraceperiod && !level.usestartspawns) {
    currentorigin = self.origin;
    currentangles = self.angles;
    self thread[[level.spawnspectator]](currentorigin + (0, 0, 60), currentangles);
    self waittill(#"queue_respawn");
  }
}

setthirdperson(value) {
  if(!level.console) {
    return;
  }

  if(!isDefined(self.spectatingthirdperson) || value != self.spectatingthirdperson) {
    self.spectatingthirdperson = value;

    if(value) {
      self setclientthirdperson(1);
      self clientfield::set_to_player("player_dof_settings", 2);
    } else {
      self setclientthirdperson(0);
      self clientfield::set_to_player("player_dof_settings", 1);
    }

    self resetfov();
  }
}

function_6f7bedf0(origin, angles, team, gamemode) {
  if(gamemode != level.gametype) {
    return;
  }

  spawnpoint = spawnStruct();

  if(team == "axis") {
    spawnpoint.classname = "mp_t8_spawn_point_axis";
    spawnpoint.targetname = "mp_t8_spawn_point_axis";
  } else if(team == "allies") {
    spawnpoint.classname = "mp_t8_spawn_point_allies";
    spawnpoint.targetname = "mp_t8_spawn_point_allies";
  }

  spawnpoint.origin = origin;
  spawnpoint.angles = angles;
  spawnpoint._human_were = 1;
  spawnpoint.tdm = 1;
  spawnpoint.var_446998f8 = 1;

  if(!isDefined(level.spawn_start)) {
    level.spawn_start = [];
  }

  if(!isDefined(level.spawn_start[team])) {
    level.spawn_start[team] = [];
  }

  if(!isDefined(level.spawn_start[team])) {
    level.spawn_start[team] = [];
  } else if(!isarray(level.spawn_start[team])) {
    level.spawn_start[team] = array(level.spawn_start[team]);
  }

  level.spawn_start[team][level.spawn_start[team].size] = spawnpoint;
}