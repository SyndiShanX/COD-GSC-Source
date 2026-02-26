/******************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\gametypes\globallogic_player.gsc
******************************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\bb_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\demo_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\globallogic\globallogic_player;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\hud_message_shared;
#using scripts\core_common\hud_shared;
#using scripts\core_common\persistence_shared;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\struct;
#using scripts\core_common\tweakables_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\weapons_shared;
#using scripts\weapons\weapon_utils;
#using scripts\zm_common\gametypes\globallogic;
#using scripts\zm_common\gametypes\globallogic_audio;
#using scripts\zm_common\gametypes\globallogic_score;
#using scripts\zm_common\gametypes\globallogic_spawn;
#using scripts\zm_common\gametypes\globallogic_ui;
#using scripts\zm_common\gametypes\globallogic_utils;
#using scripts\zm_common\gametypes\hostmigration;
#using scripts\zm_common\gametypes\spawning;
#using scripts\zm_common\gametypes\spawnlogic;
#using scripts\zm_common\gametypes\spectating;
#using scripts\zm_common\util;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_characters;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#namespace globallogic_player;

function freezeplayerforroundend() {
  self hud_message::clearlowermessage();
  self closeingamemenu();
  self val::set(#"round_end", "freezecontrols");
  self val::set(#"round_end", "disablegadgets");
}

function callback_playerconnect() {
  if(!is_true(level.var_6877b1e9)) {
    self thread zm::initialblack();
  }

  thread notifyconnecting();
  self.statusicon = "$default";
  self waittill(#"begin");

  if(isDefined(level.reset_clientdvars)) {
    self[[level.reset_clientdvars]]();
  }

  waittillframeend();
  self.statusicon = "";
  self.guid = self getguid();
  profilelog_begintiming(4, "ship");
  level notify(#"connected", {
    #player: self
  });
  demo::reset_actor_bookmark_kill_times();
  callback::callback(#"on_player_connect");

  if(self ishost()) {
    self thread globallogic::listenforgameend();
  }

  if(!level.splitscreen && !isDefined(self.pers[#"score"])) {
    iprintln(#"mp/connected", self);
  }

  self.pers[#"outcome"] = # "loss";

  if(!isDefined(self.pers[#"score"])) {
    if(level.onlinegame && gamemodeismode(0) && !zm_utility::is_survival()) {
      self.pers[#"lasthighestscore"] = self stats::get_stat(#"higheststats", #"highest_score");
      self thread persistence::adjust_recent_stats();
    }
  }

  if(gamemodeismode(0) && !isDefined(self.pers[#"matchesplayedstatstracked"])) {
    gamemode = util::getcurrentgamemode();
    self globallogic::incrementmatchcompletionstat(gamemode, "played", "started");

    if(!isDefined(self.pers[#"matcheshostedstatstracked"]) && self islocaltohost()) {
      self globallogic::incrementmatchcompletionstat(gamemode, "hosted", "started");
      self.pers[#"matcheshostedstatstracked"] = 1;
    }

    self.pers[#"matchesplayedstatstracked"] = 1;
    self thread persistence::upload_stats_soon();
  }

  lpselfnum = self getentitynumber();
  lpguid = self getguid();
  lpxuid = self getxuid(1);
  bb::function_afcc007d(self.name, lpselfnum, lpxuid);

  if(level.forceradar == 1) {
    self.pers[#"hasradar"] = 1;
    level.activeuavs[self getentitynumber()] = 1;
  }

  if(level.forceradar == 2) {
    self setclientuivisibilityflag("g_compassShowEnemies", level.forceradar);
  } else {
    self setclientuivisibilityflag("g_compassShowEnemies", 0);
  }

  self setclientplayersprinttime(level.playersprinttime);
  self setclientnumlives(isDefined(level.numlives) ? level.numlives : 1);

  if(isDefined(level.player_stats_init)) {
    self[[level.player_stats_init]]();
  }

  self.killedplayerscurrent = [];

  if(!isDefined(self.pers[#"best_kill_streak"])) {
    self.pers[#"killed_players"] = [];
    self.pers[#"killed_by"] = [];
    self.pers[#"nemesis_tracking"] = [];
    self.pers[#"artillery_kills"] = 0;
    self.pers[#"dog_kills"] = 0;
    self.pers[#"nemesis_name"] = "";
    self.pers[#"nemesis_rank"] = 0;
    self.pers[#"nemesis_rankicon"] = 0;
    self.pers[#"nemesis_xp"] = 0;
    self.pers[#"nemesis_xuid"] = "";
    self.pers[#"best_kill_streak"] = 0;
  }

  if(!isDefined(self.pers[#"music"])) {
    self.pers[#"music"] = spawnStruct();
    self.pers[#"music"].spawn = 0;
    self.pers[#"music"].inque = 0;
    self.pers[#"music"].currentstate = "SILENT";
    self.pers[#"music"].previousstate = "SILENT";
    self.pers[#"music"].nextstate = "UNDERSCORE";
    self.pers[#"music"].returnstate = "UNDERSCORE";
  }

  self.leaderdialogqueue = [];
  self.killstreakdialogqueue = [];

  if(!isDefined(self.pers[#"cur_kill_streak"])) {
    self.pers[#"cur_kill_streak"] = 0;
  }

  if(!isDefined(self.pers[#"cur_total_kill_streak"])) {
    self.pers[#"cur_total_kill_streak"] = 0;
    self setplayercurrentstreak(0);
  }

  if(!isDefined(self.pers[#"totalkillstreakcount"])) {
    self.pers[#"totalkillstreakcount"] = 0;
  }

  if(!isDefined(self.pers[#"killstreaksearnedthiskillstreak"])) {
    self.pers[#"killstreaksearnedthiskillstreak"] = 0;
  }

  if(isDefined(level.usingscorestreaks) && level.usingscorestreaks && !isDefined(self.pers[#"killstreak_quantity"])) {
    self.pers[#"killstreak_quantity"] = [];
  }

  if(isDefined(level.usingscorestreaks) && level.usingscorestreaks && !isDefined(self.pers[#"held_killstreak_ammo_count"])) {
    self.pers[#"held_killstreak_ammo_count"] = [];
  }

  self.prevlastkilltime = 0;
  self.lastkilltime = 0;
  self.cur_death_streak = 0;
  self disabledeathstreak();
  self.death_streak = 0;
  self.kill_streak = 0;
  self.gametype_kill_streak = 0;
  self.spawnqueueindex = -1;
  self.deathtime = 0;
  self.lastgrenadesuicidetime = -1;
  self.teamkillsthisround = 0;
  self.killstreak = [];
  player::init_heal(1, 1);

  if(!isDefined(level.livesdonotreset) || !level.livesdonotreset || !isDefined(self.pers[#"lives"])) {
    self.pers[#"lives"] = level.numlives;
  }

  if(!level.teambased) {
    self.pers[#"team"] = undefined;
  }

  self.hasspawned = 0;
  self.waitingtospawn = 0;
  self.wantsafespawn = 0;
  self.deathcount = 0;
  self.wasaliveatmatchstart = 0;

  if(level.splitscreen) {
    setDvar(#"splitscreen_playernum", level.players.size);
  }

  if(game.state == "postgame") {
    self.pers[#"needteam"] = 1;
    self.pers[#"team"] = "spectator";
    self.team = "spectator";
    self.sessionteam = "spectator";
    self setclientuivisibilityflag("hud_visible", 0);
    self[[level.spawnintermission]]();
    self closeingamemenu();
    profilelog_endtiming(4, "gs=" + game.state + " zom=" + sessionmodeiszombiesgame());
    return;
  }

  if(self istestclient()) {
    recordplayerstats(self, "is_bot", 1);
  }

  level endon(#"game_ended");

  if(isDefined(level.hostmigrationtimer)) {
    self thread hostmigration::hostmigrationtimerthink();
  }

  if(level.oldschool) {
    self.pers[#"class"] = undefined;
    self.curclass = self.pers[#"class"];
  }

  if(isDefined(self.pers[#"team"])) {
    self.team = self.pers[#"team"];
  }

  if(isDefined(self.pers[#"class"])) {
    self.curclass = self.pers[#"class"];
  }

  if(!isDefined(self.pers[#"team"]) || isDefined(self.pers[#"needteam"])) {
    self.pers[#"needteam"] = undefined;
    self.pers[#"team"] = "spectator";
    self.team = "spectator";
    self.sessionstate = "dead";

    if(isDefined(level.spawnspectator)) {
      [[level.spawnspectator]]();
    }

    if(isDefined(level.autoassign)) {
      if(level.rankedmatch) {
        [[level.autoassign]](0);
        self thread globallogic_spawn::kickifdontspawn();
      } else {
        [[level.autoassign]](0);
      }
    }

    if(self.pers[#"team"] == "spectator") {
      self.sessionteam = "spectator";
      self thread spectate_player_watcher();
    }

    if(level.teambased) {
      self.sessionteam = self.pers[#"team"];

      if(!isalive(self)) {
        self.statusicon = "hud_status_dead";
      }

      self thread spectating::setspectatepermissions();
    }
  } else if(self.pers[#"team"] == "spectator") {
    if(isDefined(level.spawnspectator)) {
      [[level.spawnspectator]]();
    }

    self.sessionteam = "spectator";
    self.sessionstate = "spectator";
    self thread spectate_player_watcher();
  } else {
    self.sessionteam = self.pers[#"team"];
    self.sessionstate = "dead";

    if(isDefined(level.spawnspectator)) {
      [[level.spawnspectator]]();
    }

    if(globallogic_utils::isvalidclass(self.pers[#"class"]) && isDefined(level.spawnclient)) {
      self thread[[level.spawnclient]]();
    }

    self thread spectating::setspectatepermissions();
  }

  if(self.sessionteam != "spectator") {
    self thread spawning::onspawnplayer_unified(1);
  }

  if(is_true(level.var_e824f826)) {
    zm_characters::set_character();
  }

  profilelog_endtiming(4, "gs=" + game.state + " zom=" + sessionmodeiszombiesgame());

  if(!isDefined(level.players)) {
    level.players = [];
  } else if(!isarray(level.players)) {
    level.players = array(level.players);
  }

  if(!isinarray(level.players, self)) {
    level.players[level.players.size] = self;
  }

  globallogic::updateteamstatus();
}

function spectate_player_watcher() {
  self endon(#"disconnect");
  self.watchingactiveclient = 1;

  while(true) {
    if(self.pers[#"team"] != "spectator" || level.gameended) {
      self val::reset(#"spectate", "freezecontrols");
      self.watchingactiveclient = 0;
      break;
    }

    if(!level.splitscreen && !level.hardcoremode && getdvarint(#"scr_showperksonspawn", 0) == 1 && game.state != "<dev string:x38>" && !isDefined(self.perkhudelem)) {
      if(level.perksenabled == 1) {
        self hud::showperks();
      }
    }

    count = 0;

    for(i = 0; i < level.players.size; i++) {
      if(level.players[i].team != "spectator") {
        count++;
        break;
      }
    }

    if(count > 0) {
      if(!self.watchingactiveclient) {
        self val::reset(#"spectate", "freezecontrols");
        println("<dev string:x44>");
      }

      self.watchingactiveclient = 1;
    } else {
      if(self.watchingactiveclient) {
        if(isDefined(level.onspawnspectator)) {
          [[level.onspawnspectator]]();
        }

        self val::set(#"spectate", "freezecontrols", 1);
      }

      self.watchingactiveclient = 0;
    }

    wait 0.5;
  }
}

function callback_playermigrated() {
  println("<dev string:x5c>" + self.name + "<dev string:x67>" + gettime());

  if(isDefined(self.connected) && self.connected) {}

  self thread inform_clientvm_of_migration();
  level.hostmigrationreturnedplayercount++;

  if(level.hostmigrationreturnedplayercount >= level.players.size * 2 / 3) {
    println("<dev string:x87>");
    level notify(#"hostmigration_enoughplayers");
  }
}

function inform_clientvm_of_migration() {
  self endon(#"disconnect");
  wait 1;
}

function arraytostring(inputarray) {
  targetstring = "";

  for(i = 0; i < inputarray.size; i++) {
    targetstring += inputarray[i];

    if(i != inputarray.size - 1) {
      targetstring += ",";
    }
  }

  return targetstring;
}

function function_7314957c(player, result) {
  lpselfnum = player getentitynumber();
  lpxuid = player getxuid(1);
  bb::function_e0dfa262(player.name, lpselfnum, lpxuid);
  primaryweaponname = # "";
  primaryweaponattachstr = "";
  secondaryweaponname = # "";
  secondaryweaponattachstr = "";

  if(isDefined(player.primaryloadoutweapon)) {
    primaryweaponname = player.primaryloadoutweapon.name;
    primaryweaponattachstr = arraytostring(getarraykeys(player.primaryloadoutweapon.attachments));
  }

  if(isDefined(player.secondaryloadoutweapon)) {
    secondaryweaponname = player.secondaryloadoutweapon.name;
    secondaryweaponattachstr = arraytostring(getarraykeys(player.secondaryloadoutweapon.attachments));
  }

  resultstr = result;

  if(isDefined(player.team) && result == player.team) {
    resultstr = # "win";
  } else if(result == # "allies" || result == # "axis") {
    resultstr = # "lose";
  }

  timeplayed = game.timepassed / 1000;
  var_906bdcf3 = spawnStruct();
  var_906bdcf3.match_id = getdemofileid();
  var_906bdcf3.game_variant = "zm";
  var_906bdcf3.game_mode = level.gametype;
  var_906bdcf3.private_match = sessionmodeisprivate();
  var_906bdcf3.game_map = util::get_map_name();
  var_906bdcf3.player_xuid = player getxuid(1);
  var_906bdcf3.player_ip = player getipaddress();
  var_906bdcf3.season_pass_owned = player hasseasonpass(0);
  var_906bdcf3.dlc_owned = player getdlcavailable();
  var_811ed119 = spawnStruct();
  var_811ed119.match_kills = player.kills;
  var_811ed119.match_deaths = player.deaths;
  var_811ed119.match_score = player.score;
  var_811ed119.match_result = resultstr;
  var_811ed119.match_duration = int(timeplayed);
  var_811ed119.match_hits = player.shotshit;
  var_811ed119.match_streak = player player::function_2abc116("best_kill_streak");
  var_811ed119.match_captures = player player::function_2abc116("captures");
  var_811ed119.match_defends = player player::function_2abc116("defends");
  var_811ed119.match_headshots = player player::function_2abc116("headshots");
  var_811ed119.match_longshots = player player::function_2abc116("longshots");
  var_811ed119.prestige_max = player player::function_2abc116("plevel");
  var_811ed119.level_max = player player::function_2abc116("rank");
  var_a14ea2be = spawnStruct();
  var_a14ea2be.player_gender = isPlayer(player) ? player getplayergendertype() : "male";
  var_a14ea2be.loadout_primary_weapon = primaryweaponname;
  var_a14ea2be.loadout_secondary_weapon = secondaryweaponname;
  var_a14ea2be.loadout_primary_attachments = primaryweaponattachstr;
  var_a14ea2be.loadout_secondary_attachments = secondaryweaponattachstr;
  end_match_zm = spawnStruct();
  end_match_zm.money = player.score;
  end_match_zm.zombie_waves = level.round_number;
  end_match_zm.revives = player player::function_2abc116("revives");
  end_match_zm.doors = player player::function_2abc116("doors_purchased");
  end_match_zm.downs = player player::function_2abc116("downs");
  function_92d1707f(#"hash_4c5946fa1191bc64", #"hash_71960e91f80c3365", var_906bdcf3, #"hash_4682ee0eb5071d2", var_811ed119, #"hash_209c80d657442a83", var_a14ea2be, #"end_match_zm", end_match_zm);
}

function callback_playerdisconnect() {
  profilelog_begintiming(5, "ship");

  if(game.state != "postgame" && !level.gameended) {
    gamelength = globallogic::getgamelength();
    self globallogic::bbplayermatchend(gamelength, "MP_PLAYER_DISCONNECT", 0);
  }

  arrayremovevalue(level.players, self);

  if(level.splitscreen) {
    players = level.players;

    if(players.size <= 1) {
      level thread globallogic::forceend();
    }

    setDvar(#"splitscreen_playernum", isarray(players) ? players.size : 0);
  }

  if(isDefined(self.score) && isDefined(self.pers) && isDefined(self.pers[#"team"])) {
    print("<dev string:xb1>" + self.pers[#"team"] + "<dev string:xc1>" + self.score);

    level.dropteam += 1;
  }

  if(isDefined(level.onplayerdisconnect)) {
    [[level.onplayerdisconnect]]();
  }

  lpselfnum = self getentitynumber();
  function_7314957c(self, #"disconnected");

  for(entry = 0; entry < level.players.size; entry++) {
    if(level.players[entry] == self) {
      while(entry < level.players.size - 1) {
        level.players[entry] = level.players[entry + 1];
        entry++;
      }

      level.players[entry] = undefined;
      break;
    }
  }

  for(entry = 0; entry < level.players.size; entry++) {
    if(isDefined(level.players[entry].pers[#"killed_players"][self.name])) {
      level.players[entry].pers[#"killed_players"][self.name] = undefined;
    }

    if(isDefined(level.players[entry].killedplayerscurrent[self.name])) {
      level.players[entry].killedplayerscurrent[self.name] = undefined;
    }

    if(isDefined(level.players[entry].pers[#"killed_by"][self.name])) {
      level.players[entry].pers[#"killed_by"][self.name] = undefined;
    }

    if(isDefined(level.players[entry].pers[#"nemesis_tracking"][self.name])) {
      level.players[entry].pers[#"nemesis_tracking"][self.name] = undefined;
    }

    if(level.players[entry].pers[#"nemesis_name"] == self.name) {
      level.players[entry] choosenextbestnemesis();
    }
  }

  if(level.gameended) {
    self globallogic::removedisconnectedplayerfromplacement();
  }

  globallogic::updateteamstatus();
  profilelog_endtiming(5, "gs=" + game.state + " zom=" + sessionmodeiszombiesgame());
}

function callback_playermelee(eattacker, idamage, weapon, vorigin, vdir, boneindex, shieldhit, frombehind) {
  hit = 1;

  if(level.teambased && self.team == idamage.team) {
    if(level.friendlyfire == 0) {
      hit = 0;
    }
  }

  self finishmeleehit(idamage, weapon, vorigin, vdir, boneindex, shieldhit, hit, frombehind);
}

function choosenextbestnemesis() {
  nemesisarray = self.pers[#"nemesis_tracking"];
  nemesisarraykeys = getarraykeys(nemesisarray);
  nemesisamount = 0;
  nemesisname = "";

  if(nemesisarraykeys.size > 0) {
    for(i = 0; i < nemesisarraykeys.size; i++) {
      nemesisarraykey = nemesisarraykeys[i];

      if(nemesisarray[nemesisarraykey] > nemesisamount) {
        nemesisname = nemesisarraykey;
        nemesisamount = nemesisarray[nemesisarraykey];
      }
    }
  }

  self.pers[#"nemesis_name"] = nemesisname;

  if(nemesisname != "") {
    for(playerindex = 0; playerindex < level.players.size; playerindex++) {
      if(level.players[playerindex].name == nemesisname) {
        nemesisplayer = level.players[playerindex];
        self.pers[#"nemesis_rank"] = nemesisplayer.pers[#"rank"];
        self.pers[#"nemesis_rankicon"] = nemesisplayer.pers[#"rankxp"];
        self.pers[#"nemesis_xp"] = nemesisplayer.pers[#"prestige"];
        self.pers[#"nemesis_xuid"] = nemesisplayer getxuid();
        break;
      }
    }

    return;
  }

  self.pers[#"nemesis_xuid"] = "";
}

function notifyconnecting() {
  waittillframeend();

  if(isDefined(self)) {
    level notify(#"connecting", {
      #player: self
    });
    self callback::callback(#"on_player_connecting");
  }
}

function recordactiveplayersendgamematchrecordstats() {
  foreach(player in level.players) {
    recordplayermatchend(player);
    recordplayerstats(player, "present_at_end", 1);
  }
}

function figureoutfriendlyfire(victim, attacker) {
  return level.friendlyfire;
}

function function_b2873ebe() {
  globallogic::updateteamstatus(1);
  self notify(#"death");
}