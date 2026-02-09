/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\gametypes\sr.gsc
*************************************************/

#using scripts\mp\_challenges;
#using scripts\mp\_util;
#using scripts\mp\gametypes\_battlechatter;
#using scripts\mp\gametypes\_dogtags;
#using scripts\mp\gametypes\_globallogic;
#using scripts\mp\gametypes\_globallogic_audio;
#using scripts\mp\gametypes\_globallogic_defaults;
#using scripts\mp\gametypes\_globallogic_score;
#using scripts\mp\gametypes\_globallogic_spawn;
#using scripts\mp\gametypes\_globallogic_utils;
#using scripts\mp\gametypes\_hostmigration;
#using scripts\mp\gametypes\_spawning;
#using scripts\mp\gametypes\_spawnlogic;
#using scripts\mp\gametypes\_spectating;
#using scripts\shared\demo_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\gameobjects_shared;
#using scripts\shared\hostmigration_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\math_shared;
#using scripts\shared\medals_shared;
#using scripts\shared\popups_shared;
#using scripts\shared\rank_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\sound_shared;
#using scripts\shared\util_shared;
#namespace sr;

function main() {
  globallogic::init();
  util::registerroundswitch(0, 9);
  util::registertimelimit(0, 1440);
  util::registerscorelimit(0, 500);
  util::registerroundlimit(0, 12);
  util::registerroundwinlimit(0, 10);
  util::registernumlives(0, 100);
  globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
  level.teambased = 1;
  level.overrideteamscore = 1;
  level.onprecachegametype = &onprecachegametype;
  level.onstartgametype = &onstartgametype;
  level.onspawnplayer = &onspawnplayer;
  level.playerspawnedcb = &sr_playerspawnedcb;
  level.onplayerkilled = &onplayerkilled;
  level.ondeadevent = &ondeadevent;
  level.ononeleftevent = &ononeleftevent;
  level.ontimelimit = &ontimelimit;
  level.onroundswitch = &onroundswitch;
  level.getteamkillpenalty = &sr_getteamkillpenalty;
  level.getteamkillscore = &sr_getteamkillscore;
  level.iskillboosting = &sr_iskillboosting;
  level.endgameonscorelimit = 0;
  gameobjects::register_allowed_gameobject("sd");
  gameobjects::register_allowed_gameobject("bombzone");
  gameobjects::register_allowed_gameobject("blocker");
  globallogic_audio::set_leader_gametype_dialog("startSearchAndRescue", "hcStartSearchAndRescue", "objDestroy", "objDefend");
  if(!sessionmodeissystemlink() && !sessionmodeisonlinegame() && issplitscreen()) {
    globallogic::setvisiblescoreboardcolumns("score", "kills", "plants", "defuses", "deaths");
  } else {
    globallogic::setvisiblescoreboardcolumns("score", "kills", "deaths", "plants", "defuses");
  }
}

function onprecachegametype() {
  game["bomb_dropped_sound"] = "fly_bomb_drop_plr";
  game["bomb_recovered_sound"] = "fly_bomb_pickup_plr";
}

function sr_getteamkillpenalty(einflictor, attacker, smeansofdeath, weapon) {
  teamkill_penalty = globallogic_defaults::default_getteamkillpenalty(einflictor, attacker, smeansofdeath, weapon);
  if(isDefined(self.isdefusing) && self.isdefusing || (isDefined(self.isplanting) && self.isplanting)) {
    teamkill_penalty = teamkill_penalty * level.teamkillpenaltymultiplier;
  }
  return teamkill_penalty;
}

function sr_getteamkillscore(einflictor, attacker, smeansofdeath, weapon) {
  teamkill_score = rank::getscoreinfovalue("team_kill");
  if(isDefined(self.isdefusing) && self.isdefusing || (isDefined(self.isplanting) && self.isplanting)) {
    teamkill_score = teamkill_score * level.teamkillscoremultiplier;
  }
  return int(teamkill_score);
}

function onroundswitch() {
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }
  if(game["teamScores"]["allies"] == (level.scorelimit - 1) && game["teamScores"]["axis"] == (level.scorelimit - 1)) {
    aheadteam = getbetterteam();
    if(aheadteam != game["defenders"]) {
      game["switchedsides"] = !game["switchedsides"];
    }
    level.halftimetype = "overtime";
  } else {
    level.halftimetype = "halftime";
    game["switchedsides"] = !game["switchedsides"];
  }
}

function getbetterteam() {
  kills["allies"] = 0;
  kills["axis"] = 0;
  deaths["allies"] = 0;
  deaths["axis"] = 0;
  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];
    team = player.pers["team"];
    if(isDefined(team) && (team == "allies" || team == "axis")) {
      kills[team] = kills[team] + player.kills;
      deaths[team] = deaths[team] + player.deaths;
    }
  }
  if(kills["allies"] > kills["axis"]) {
    return "allies";
  }
  if(kills["axis"] > kills["allies"]) {
    return "axis";
  }
  if(deaths["allies"] < deaths["axis"]) {
    return "allies";
  }
  if(deaths["axis"] < deaths["allies"]) {
    return "axis";
  }
  if(randomint(2) == 0) {
    return "allies";
  }
  return "axis";
}

function onstartgametype() {
  setbombtimer("A", 0);
  setmatchflag("bomb_timer_a", 0);
  setbombtimer("B", 0);
  setmatchflag("bomb_timer_b", 0);
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }
  if(game["switchedsides"]) {
    oldattackers = game["attackers"];
    olddefenders = game["defenders"];
    game["attackers"] = olddefenders;
    game["defenders"] = oldattackers;
  }
  setclientnamemode("manual_change");
  game["strings"]["target_destroyed"] = &"MP_TARGET_DESTROYED";
  game["strings"]["bomb_defused"] = &"MP_BOMB_DEFUSED";
  level._effect["bombexplosion"] = "explosions/fx_exp_bomb_demo_mp";
  util::setobjectivetext(game["attackers"], &"OBJECTIVES_SD_ATTACKER");
  util::setobjectivetext(game["defenders"], &"OBJECTIVES_SD_DEFENDER");
  if(level.splitscreen) {
    util::setobjectivescoretext(game["attackers"], &"OBJECTIVES_SD_ATTACKER");
    util::setobjectivescoretext(game["defenders"], &"OBJECTIVES_SD_DEFENDER");
  } else {
    util::setobjectivescoretext(game["attackers"], &"OBJECTIVES_SD_ATTACKER_SCORE");
    util::setobjectivescoretext(game["defenders"], &"OBJECTIVES_SD_DEFENDER_SCORE");
  }
  util::setobjectivehinttext(game["attackers"], &"OBJECTIVES_SD_ATTACKER_HINT");
  util::setobjectivehinttext(game["defenders"], &"OBJECTIVES_SD_DEFENDER_HINT");
  level.alwaysusestartspawns = 1;
  dogtags::init();
  initspawns();
  thread updategametypedvars();
  thread bombs();
}

function initspawns() {
  spawning::create_map_placed_influencers();
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  spawnlogic::place_spawn_points("mp_sd_spawn_attacker");
  spawnlogic::place_spawn_points("mp_sd_spawn_defender");
  foreach(team in level.teams) {
    spawnlogic::add_spawn_points(team, "mp_tdm_spawn");
  }
  spawning::updateallspawnpoints();
  level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  spawnpoint = spawnlogic::get_random_intermission_point();
  setdemointermissionpoint(spawnpoint.origin, spawnpoint.angles);
  level.spawn_start = [];
  level.spawn_start["axis"] = spawnlogic::get_spawnpoint_array("mp_sd_spawn_defender");
  level.spawn_start["allies"] = spawnlogic::get_spawnpoint_array("mp_sd_spawn_attacker");
}

function onspawnplayer(predictedspawn) {
  self.isplanting = 0;
  self.isdefusing = 0;
  self.isbombcarrier = 0;
  spawning::onspawnplayer(predictedspawn);
  dogtags::on_spawn_player();
}

function sr_playerspawnedcb() {
  level notify("spawned_player");
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  thread checkallowspectating();
  if(isPlayer(attacker) && attacker.pers["team"] != self.pers["team"]) {
    scoreevents::processscoreevent("kill_sd", attacker, self, weapon);
  }
  inbombzone = 0;
  for(index = 0; index < level.bombzones.size; index++) {
    dist = distance2dsquared(self.origin, level.bombzones[index].curorigin);
    if(dist < level.defaultoffenseradiussq) {
      currentobjective = level.bombzones[index];
      inbombzone = 1;
      break;
    }
  }
  if(inbombzone && isPlayer(attacker) && attacker.pers["team"] != self.pers["team"]) {
    if(game["defenders"] == self.pers["team"]) {
      attacker medals::offenseglobalcount();
      attacker thread challenges::killedbaseoffender(currentobjective, weapon);
      self recordkillmodifier("defending");
      scoreevents::processscoreevent("killed_defender", attacker, self, weapon);
    } else {
      if(isDefined(attacker.pers["defends"])) {
        attacker.pers["defends"]++;
        attacker.defends = attacker.pers["defends"];
      }
      attacker medals::defenseglobalcount();
      attacker thread challenges::killedbasedefender(currentobjective);
      self recordkillmodifier("assaulting");
      scoreevents::processscoreevent("killed_attacker", attacker, self, weapon);
    }
  }
  if(isPlayer(attacker) && attacker.pers["team"] != self.pers["team"] && isDefined(self.isbombcarrier) && self.isbombcarrier == 1) {
    self recordkillmodifier("carrying");
  }
  if(self.isplanting == 1) {
    self recordkillmodifier("planting");
  }
  if(self.isdefusing == 1) {
    self recordkillmodifier("defusing");
  }
  should_spawn_tags = self should_spawn_tags(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
  should_spawn_tags = should_spawn_tags && !globallogic_spawn::mayspawn();
  if(should_spawn_tags) {
    level thread dogtags::spawn_dog_tag(self, attacker, &onusedogtag, 0);
  }
}

function should_spawn_tags(einflictor, attacker, idamage, smeansofdeath, sweapon, vdir, shitloc, psoffsettime, deathanimduration) {
  if(isalive(self)) {
    return false;
  }
  if(isDefined(self.switching_teams)) {
    return false;
  }
  if(isDefined(attacker) && attacker == self) {
    return false;
  }
  if(level.teambased && isDefined(attacker) && isDefined(attacker.team) && attacker.team == self.team) {
    return false;
  }
  if(isDefined(attacker) && (!isDefined(attacker.team) || attacker.team == "free") && (attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn")) {
    return false;
  }
  return true;
}

function checkallowspectating() {
  self endon("disconnect");
  wait(0.05);
  update = 0;
  livesleft = !(level.numlives && !self.pers["lives"]);
  if(!level.alivecount[game["attackers"]] && !livesleft) {
    level.spectateoverride[game["attackers"]].allowenemyspectate = 1;
    update = 1;
  }
  if(!level.alivecount[game["defenders"]] && !livesleft) {
    level.spectateoverride[game["defenders"]].allowenemyspectate = 1;
    update = 1;
  }
  if(update) {
    spectating::update_settings();
  }
}

function sr_endgame(winningteam, endreasontext) {
  if(isDefined(winningteam)) {
    globallogic_score::giveteamscoreforobjective_delaypostprocessing(winningteam, 1);
  }
  thread globallogic::endgame(winningteam, endreasontext);
}

function sr_endgamewithkillcam(winningteam, endreasontext) {
  sr_endgame(winningteam, endreasontext);
}

function ondeadevent(team) {
  if(level.bombexploded || level.bombdefused) {
    return;
  }
  if(team == "all") {
    if(level.bombplanted) {
      sr_endgamewithkillcam(game["attackers"], game["strings"][game["defenders"] + "_eliminated"]);
    } else {
      sr_endgamewithkillcam(game["defenders"], game["strings"][game["attackers"] + "_eliminated"]);
    }
  } else {
    if(team == game["attackers"]) {
      if(level.bombplanted) {
        return;
      }
      sr_endgamewithkillcam(game["defenders"], game["strings"][game["attackers"] + "_eliminated"]);
    } else if(team == game["defenders"]) {
      sr_endgamewithkillcam(game["attackers"], game["strings"][game["defenders"] + "_eliminated"]);
    }
  }
}

function ononeleftevent(team) {
  if(level.bombexploded || level.bombdefused) {
    return;
  }
  warnlastplayer(team);
}

function ontimelimit() {
  if(level.teambased) {
    sr_endgame(game["defenders"], game["strings"]["time_limit_reached"]);
  } else {
    sr_endgame(undefined, game["strings"]["time_limit_reached"]);
  }
}

function warnlastplayer(team) {
  if(!isDefined(level.warnedlastplayer)) {
    level.warnedlastplayer = [];
  }
  if(isDefined(level.warnedlastplayer[team])) {
    return;
  }
  level.warnedlastplayer[team] = 1;
  players = level.players;
  for(i = 0; i < players.size; i++) {
    player = players[i];
    if(isDefined(player.pers["team"]) && player.pers["team"] == team && isDefined(player.pers["class"])) {
      if(player.sessionstate == "playing" && !player.afk) {
        break;
      }
    }
  }
  if(i == players.size) {
    return;
  }
  players[i] thread givelastattackerwarning(team);
}

function givelastattackerwarning(team) {
  self endon("death");
  self endon("disconnect");
  fullhealthtime = 0;
  interval = 0.05;
  self.lastmansd = 1;
  enemyteam = game["defenders"];
  if(team == enemyteam) {
    enemyteam = game["attackers"];
  }
  if(level.alivecount[enemyteam] > 2) {
    self.lastmansddefeat3enemies = 1;
  }
  while(true) {
    if(self.health != self.maxhealth) {
      fullhealthtime = 0;
    } else {
      fullhealthtime = fullhealthtime + interval;
    }
    wait(interval);
    if(self.health == self.maxhealth && fullhealthtime >= 3) {
      break;
    }
  }
  self globallogic_audio::leader_dialog_on_player("roundEncourageLastPlayer");
  self playlocalsound("mus_last_stand");
}

function updategametypedvars() {
  level.planttime = getgametypesetting("plantTime");
  level.defusetime = getgametypesetting("defuseTime");
  level.bombtimer = getgametypesetting("bombTimer");
  level.multibomb = getgametypesetting("multiBomb");
  level.teamkillpenaltymultiplier = getgametypesetting("teamKillPenalty");
  level.teamkillscoremultiplier = getgametypesetting("teamKillScore");
  level.playerkillsmax = getgametypesetting("playerKillsMax");
  level.totalkillsmax = getgametypesetting("totalKillsMax");
}

function bombs() {
  level.bombplanted = 0;
  level.bombdefused = 0;
  level.bombexploded = 0;
  trigger = getent("sd_bomb_pickup_trig", "targetname");
  if(!isDefined(trigger)) {
    util::error("");
    return;
  }
  visuals[0] = getent("sd_bomb", "targetname");
  if(!isDefined(visuals[0])) {
    util::error("");
    return;
  }
  if(!level.multibomb) {
    level.sdbomb = gameobjects::create_carry_object(game["attackers"], trigger, visuals, vectorscale((0, 0, 1), 32), &"sd_bomb");
    level.sdbomb gameobjects::allow_carry("friendly");
    level.sdbomb gameobjects::set_2d_icon("friendly", "compass_waypoint_bomb");
    level.sdbomb gameobjects::set_3d_icon("friendly", "waypoint_bomb");
    level.sdbomb gameobjects::set_visible_team("friendly");
    level.sdbomb gameobjects::set_carry_icon("hud_suitcase_bomb");
    level.sdbomb.allowweapons = 1;
    level.sdbomb.onpickup = &onpickup;
    level.sdbomb.ondrop = &ondrop;
  } else {
    trigger delete();
    visuals[0] delete();
  }
  level.bombzones = [];
  bombzones = getEntArray("bombzone", "targetname");
  for(index = 0; index < bombzones.size; index++) {
    trigger = bombzones[index];
    visuals = getEntArray(bombzones[index].target, "targetname");
    name = istring("sd" + trigger.script_label);
    bombzone = gameobjects::create_use_object(game["defenders"], trigger, visuals, (0, 0, 0), name);
    bombzone gameobjects::allow_use("enemy");
    bombzone gameobjects::set_use_time(level.planttime);
    bombzone gameobjects::set_use_text(&"MP_PLANTING_EXPLOSIVE");
    bombzone gameobjects::set_use_hint_text(&"PLATFORM_HOLD_TO_PLANT_EXPLOSIVES");
    if(!level.multibomb) {
      bombzone gameobjects::set_key_object(level.sdbomb);
    }
    label = bombzone gameobjects::get_label();
    bombzone.label = label;
    bombzone gameobjects::set_2d_icon("friendly", "compass_waypoint_defend" + label);
    bombzone gameobjects::set_3d_icon("friendly", "waypoint_defend" + label);
    bombzone gameobjects::set_2d_icon("enemy", "compass_waypoint_target" + label);
    bombzone gameobjects::set_3d_icon("enemy", "waypoint_target" + label);
    bombzone gameobjects::set_visible_team("any");
    bombzone.onbeginuse = &onbeginuse;
    bombzone.onenduse = &onenduse;
    bombzone.onuse = &onuseplantobject;
    bombzone.oncantuse = &oncantuse;
    bombzone.useweapon = getweapon("briefcase_bomb");
    bombzone.visuals[0].killcament = spawn("script_model", bombzone.visuals[0].origin + vectorscale((0, 0, 1), 128));
    if(!level.multibomb) {
      bombzone.trigger setinvisibletoall();
    }
    for(i = 0; i < visuals.size; i++) {
      if(isDefined(visuals[i].script_exploder)) {
        bombzone.exploderindex = visuals[i].script_exploder;
        break;
      }
    }
    level.bombzones[level.bombzones.size] = bombzone;
    bombzone.bombdefusetrig = getent(visuals[0].target, "targetname");
    assert(isDefined(bombzone.bombdefusetrig));
    bombzone.bombdefusetrig.origin = bombzone.bombdefusetrig.origin + (vectorscale((0, 0, -1), 10000));
    bombzone.bombdefusetrig.label = label;
  }
  for(index = 0; index < level.bombzones.size; index++) {
    array = [];
    for(otherindex = 0; otherindex < level.bombzones.size; otherindex++) {
      if(otherindex != index) {
        array[array.size] = level.bombzones[otherindex];
      }
    }
    level.bombzones[index].otherbombzones = array;
  }
}

function onbeginuse(player) {
  if(self gameobjects::is_friendly_team(player.pers["team"])) {
    player playSound("mpl_sd_bomb_defuse");
    player.isdefusing = 1;
    player thread battlechatter::gametype_specific_battle_chatter("sd_enemyplant", player.pers["team"]);
    if(isDefined(level.sdbombmodel)) {
      level.sdbombmodel hide();
    }
  } else {
    player.isplanting = 1;
    player thread battlechatter::gametype_specific_battle_chatter("sd_friendlyplant", player.pers["team"]);
    if(level.multibomb) {
      for(i = 0; i < self.otherbombzones.size; i++) {
        self.otherbombzones[i] gameobjects::disable_object();
      }
    }
  }
  player playSound("fly_bomb_raise_plr");
}

function onenduse(team, player, result) {
  if(!isDefined(player)) {
    return;
  }
  player.isdefusing = 0;
  player.isplanting = 0;
  player notify("event_ended");
  if(self gameobjects::is_friendly_team(player.pers["team"])) {
    if(isDefined(level.sdbombmodel) && !result) {
      level.sdbombmodel show();
    }
  } else if(level.multibomb && !result) {
    for(i = 0; i < self.otherbombzones.size; i++) {
      self.otherbombzones[i] gameobjects::enable_object();
    }
  }
}

function oncantuse(player) {
  player iprintlnbold(&"MP_CANT_PLANT_WITHOUT_BOMB");
}

function onuseplantobject(player) {
  if(!self gameobjects::is_friendly_team(player.pers["team"])) {
    self gameobjects::set_flags(1);
    level thread bombplanted(self, player);
    print("" + self.label);
    for(index = 0; index < level.bombzones.size; index++) {
      if(level.bombzones[index] == self) {
        level.bombzones[index].isplanted = 1;
        continue;
      }
      level.bombzones[index] gameobjects::disable_object();
    }
    thread sound::play_on_players(("mus_sd_planted" + "_") + level.teampostfix[player.pers["team"]]);
    player notify("bomb_planted");
    level thread popups::displayteammessagetoall(&"MP_EXPLOSIVES_PLANTED_BY", player);
    if(isDefined(player.pers["plants"])) {
      player.pers["plants"]++;
      player.plants = player.pers["plants"];
    }
    demo::bookmark("event", gettime(), player);
    player addplayerstatwithgametype("PLANTS", 1);
    globallogic_audio::leader_dialog("bombPlanted");
    scoreevents::processscoreevent("planted_bomb", player);
    player recordgameevent("plant");
  }
}

function onusedefuseobject(player) {
  self gameobjects::set_flags(0);
  player notify("bomb_defused");
  print("" + self.label);
  bbprint("mpobjective", "gametime %d objtype %s label %s team %s playerx %d playery %d playerz %d", gettime(), "sd_bombdefuse", self.label, player.pers["team"], player.origin);
  level thread bombdefused();
  self gameobjects::disable_object();
  for(index = 0; index < level.bombzones.size; index++) {
    level.bombzones[index].isplanted = 0;
  }
  level thread popups::displayteammessagetoall(&"MP_EXPLOSIVES_DEFUSED_BY", player);
  if(isDefined(player.pers["defuses"])) {
    player.pers["defuses"]++;
    player.defuses = player.pers["defuses"];
  }
  player addplayerstatwithgametype("DEFUSES", 1);
  demo::bookmark("event", gettime(), player);
  globallogic_audio::leader_dialog("bombDefused");
  if(isDefined(player.lastmansd) && player.lastmansd == 1) {
    scoreevents::processscoreevent("defused_bomb_last_man_alive", player);
    player addplayerstat("defused_bomb_last_man_alive", 1);
  } else {
    scoreevents::processscoreevent("defused_bomb", player);
  }
  player recordgameevent("defuse");
}

function ondrop(player) {
  if(!level.bombplanted) {
    globallogic_audio::leader_dialog("bombFriendlyDropped", game["attackers"]);
    if(isDefined(player)) {
      print("");
    } else {
      print("");
    }
  }
  player notify("event_ended");
  self gameobjects::set_3d_icon("friendly", "waypoint_bomb");
  sound::play_on_players(game["bomb_dropped_sound"], game["attackers"]);
  if(isDefined(level.bombdropbotevent)) {
    [[level.bombdropbotevent]]();
  }
}

function onpickup(player) {
  player.isbombcarrier = 1;
  player recordgameevent("pickup");
  self gameobjects::set_3d_icon("friendly", "waypoint_defend");
  if(!level.bombdefused) {
    if(isDefined(player) && isDefined(player.name)) {
      player addplayerstatwithgametype("PICKUPS", 1);
    }
    team = self gameobjects::get_owner_team();
    otherteam = util::getotherteam(team);
    globallogic_audio::leader_dialog("bombFriendlyTaken", game["attackers"]);
    print("");
  }
  sound::play_on_players(game["bomb_recovered_sound"], game["attackers"]);
  for(i = 0; i < level.bombzones.size; i++) {
    level.bombzones[i].trigger setinvisibletoall();
    level.bombzones[i].trigger setvisibletoplayer(player);
  }
  if(isDefined(level.bombpickupbotevent)) {
    [[level.bombpickupbotevent]]();
  }
}

function onreset() {}

function bombplantedmusicdelay() {
  level endon("bomb_defused");
  time = level.bombtimer - 30;
  if(getdvarint("") > 0) {
    println("" + time);
  }
  if(time > 1) {
    wait(time);
    thread globallogic_audio::set_music_on_team("timeOut");
  }
}

function bombplanted(destroyedobj, player) {
  globallogic_utils::pausetimer();
  level.bombplanted = 1;
  team = player.pers["team"];
  destroyedobj.visuals[0] thread globallogic_utils::playtickingsound("mpl_sab_ui_suitcasebomb_timer");
  level thread bombplantedmusicdelay();
  level.tickingobject = destroyedobj.visuals[0];
  level.timelimitoverride = 1;
  setgameendtime(int(gettime() + (level.bombtimer * 1000)));
  label = destroyedobj gameobjects::get_label();
  setmatchflag("bomb_timer" + label, 1);
  if(label == "_a") {
    setbombtimer("A", int(gettime() + (level.bombtimer * 1000)));
  } else {
    setbombtimer("B", int(gettime() + (level.bombtimer * 1000)));
  }
  bbprint("mpobjective", "gametime %d objtype %s label %s team %s playerx %d playery %d playerz %d", gettime(), "sd_bombplant", label, team, player.origin);
  if(!level.multibomb) {
    level.sdbomb gameobjects::allow_carry("none");
    level.sdbomb gameobjects::set_visible_team("none");
    level.sdbomb gameobjects::set_dropped();
    level.sdbombmodel = level.sdbomb.visuals[0];
  } else {
    for(index = 0; index < level.players.size; index++) {
      if(isDefined(level.players[index].carryicon)) {
        level.players[index].carryicon hud::destroyelem();
      }
    }
    trace = bulletTrace(player.origin + vectorscale((0, 0, 1), 20), player.origin - vectorscale((0, 0, 1), 2000), 0, player);
    tempangle = randomfloat(360);
    forward = (cos(tempangle), sin(tempangle), 0);
    forward = vectornormalize(forward - vectorscale(trace["normal"], vectordot(forward, trace["normal"])));
    dropangles = vectortoangles(forward);
    level.sdbombmodel = spawn("script_model", trace["position"]);
    level.sdbombmodel.angles = dropangles;
    level.sdbombmodel setModel("p7_mp_suitcase_bomb");
  }
  destroyedobj gameobjects::allow_use("none");
  destroyedobj gameobjects::set_visible_team("none");
  label = destroyedobj gameobjects::get_label();
  trigger = destroyedobj.bombdefusetrig;
  trigger.origin = level.sdbombmodel.origin;
  visuals = [];
  defuseobject = gameobjects::create_use_object(game["defenders"], trigger, visuals, vectorscale((0, 0, 1), 32), istring("sd_defuse" + label));
  defuseobject gameobjects::allow_use("friendly");
  defuseobject gameobjects::set_use_time(level.defusetime);
  defuseobject gameobjects::set_use_text(&"MP_DEFUSING_EXPLOSIVE");
  defuseobject gameobjects::set_use_hint_text(&"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES");
  defuseobject gameobjects::set_visible_team("any");
  defuseobject gameobjects::set_2d_icon("friendly", "compass_waypoint_defuse" + label);
  defuseobject gameobjects::set_2d_icon("enemy", "compass_waypoint_defend" + label);
  defuseobject gameobjects::set_3d_icon("friendly", "waypoint_defuse" + label);
  defuseobject gameobjects::set_3d_icon("enemy", "waypoint_defend" + label);
  defuseobject gameobjects::set_flags(1);
  defuseobject.label = label;
  defuseobject.onbeginuse = &onbeginuse;
  defuseobject.onenduse = &onenduse;
  defuseobject.onuse = &onusedefuseobject;
  defuseobject.useweapon = getweapon("briefcase_bomb_defuse");
  player.isbombcarrier = 0;
  bombtimerwait();
  setbombtimer("A", 0);
  setbombtimer("B", 0);
  setmatchflag("bomb_timer_a", 0);
  setmatchflag("bomb_timer_b", 0);
  destroyedobj.visuals[0] globallogic_utils::stoptickingsound();
  if(level.gameended || level.bombdefused) {
    return;
  }
  level.bombexploded = 1;
  origin = (0, 0, 0);
  if(isDefined(player)) {
    origin = player.origin;
  }
  bbprint("mpobjective", "gametime %d objtype %s label %s team %s playerx %d playery %d playerz %d", gettime(), "sd_bombexplode", label, team, origin);
  explosionorigin = level.sdbombmodel.origin + vectorscale((0, 0, 1), 12);
  level.sdbombmodel hide();
  if(isDefined(player)) {
    destroyedobj.visuals[0] radiusdamage(explosionorigin, 512, 200, 20, player, "MOD_EXPLOSIVE", getweapon("briefcase_bomb"));
    level thread popups::displayteammessagetoall(&"MP_EXPLOSIVES_BLOWUP_BY", player);
    scoreevents::processscoreevent("bomb_detonated", player);
    player addplayerstatwithgametype("DESTRUCTIONS", 1);
    player recordgameevent("destroy");
  } else {
    destroyedobj.visuals[0] radiusdamage(explosionorigin, 512, 200, 20, undefined, "MOD_EXPLOSIVE", getweapon("briefcase_bomb"));
  }
  rot = randomfloat(360);
  explosioneffect = spawnfx(level._effect["bombexplosion"], explosionorigin + vectorscale((0, 0, 1), 50), (0, 0, 1), (cos(rot), sin(rot), 0));
  triggerfx(explosioneffect);
  thread sound::play_in_space("mpl_sd_exp_suitcase_bomb_main", explosionorigin);
  if(isDefined(destroyedobj.exploderindex)) {
    exploder::exploder(destroyedobj.exploderindex);
  }
  defuseobject gameobjects::destroy_object();
  foreach(zone in level.bombzones) {
    zone gameobjects::disable_object();
  }
  setgameendtime(0);
  wait(3);
  sr_endgame(game["attackers"], game["strings"]["target_destroyed"]);
}

function bombtimerwait() {
  level endon("game_ended");
  level endon("bomb_defused");
  hostmigration::waitlongdurationwithgameendtimeupdate(level.bombtimer);
}

function bombdefused() {
  level.tickingobject globallogic_utils::stoptickingsound();
  level.bombdefused = 1;
  setbombtimer("A", 0);
  setbombtimer("B", 0);
  setmatchflag("bomb_timer_a", 0);
  setmatchflag("bomb_timer_b", 0);
  level notify("bomb_defused");
  thread globallogic_audio::set_music_on_team("silent");
  wait(1.5);
  setgameendtime(0);
  sr_endgame(game["defenders"], game["strings"]["bomb_defused"]);
}

function sr_iskillboosting() {
  roundsplayed = util::getroundsplayed();
  if(level.playerkillsmax == 0) {
    return false;
  }
  if(game["totalKills"] > (level.totalkillsmax * (roundsplayed + 1))) {
    return true;
  }
  if(self.kills > (level.playerkillsmax * (roundsplayed + 1))) {
    return true;
  }
  if(level.teambased && (self.team == "allies" || self.team == "axis")) {
    if(game["totalKillsTeam"][self.team] > (level.playerkillsmax * (roundsplayed + 1))) {
      return true;
    }
  }
  return false;
}

function onusedogtag(player) {
  if(player.pers["team"] == self.victimteam) {
    player.pers["rescues"]++;
    player.rescues = player.pers["rescues"];
    if(isDefined(self.victim)) {
      if(!level.gameended) {
        self.victim thread sr_respawn();
      }
    }
  }
}

function sr_respawn() {
  self thread waittillcanspawnclient();
}

function waittillcanspawnclient() {
  for(;;) {
    wait(0.05);
    if(isDefined(self) && (self.sessionstate == "spectator" || !isalive(self))) {
      self.pers["lives"] = 1;
      self thread[[level.spawnclient]]();
      continue;
    }
    return;
  }
}