/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\gametypes\tdef.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\mp\_util;
#using scripts\mp\gametypes\_globallogic;
#using scripts\mp\gametypes\_globallogic_audio;
#using scripts\mp\gametypes\_globallogic_score;
#using scripts\mp\gametypes\_spawning;
#using scripts\mp\gametypes\_spawnlogic;
#using scripts\mp\killstreaks\_killstreaks;
#using scripts\mp\teams\_teams;
#using scripts\shared\gameobjects_shared;
#using scripts\shared\math_shared;
#using scripts\shared\popups_shared;
#using scripts\shared\rank_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\sound_shared;
#using scripts\shared\util_shared;
#namespace tdef;

function main() {
  globallogic::init();
  util::registerroundswitch(0, 9);
  util::registertimelimit(0, 1440);
  util::registerscorelimit(0, 10000);
  util::registerroundlimit(0, 10);
  util::registernumlives(0, 100);
  level.matchrules_enemyflagradar = 1;
  level.matchrules_damagemultiplier = 0;
  level.matchrules_vampirism = 0;
  setspecialloadouts();
  level.teambased = 1;
  level.initgametypeawards = & initgametypeawards;
  level.onprecachegametype = & onprecachegametype;
  level.onstartgametype = & onstartgametype;
  level.onplayerkilled = & onplayerkilled;
  level.onspawnplayer = & onspawnplayer;
  level.onroundendgame = & onroundendgame;
  level.onroundswitch = & onroundswitch;
  gameobjects::register_allowed_gameobject(level.gametype);
  gameobjects::register_allowed_gameobject("tdm");
  game["dialog"]["gametype"] = "team_def";
  if(getdvarint("g_hardcore")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }
  game["dialog"]["got_flag"] = "ctf_wetake";
  game["dialog"]["enemy_got_flag"] = "ctf_theytake";
  game["dialog"]["dropped_flag"] = "ctf_wedrop";
  game["dialog"]["enemy_dropped_flag"] = "ctf_theydrop";
  game["strings"]["overtime_hint"] = & "MP_FIRST_BLOOD";
}

function onprecachegametype() {}

function onstartgametype() {
  setclientnamemode("auto_change");
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }
  if(game["switchedsides"]) {
    oldattackers = game["attackers"];
    olddefenders = game["defenders"];
    game["attackers"] = olddefenders;
    game["defenders"] = oldattackers;
  }
  util::setobjectivetext("allies", & "OBJECTIVES_TDEF");
  util::setobjectivetext("axis", & "OBJECTIVES_TDEF");
  if(level.splitscreen) {
    util::setobjectivescoretext("allies", & "OBJECTIVES_TDEF");
    util::setobjectivescoretext("axis", & "OBJECTIVES_TDEF");
  } else {
    util::setobjectivescoretext("allies", & "OBJECTIVES_TDEF_SCORE");
    util::setobjectivescoretext("axis", & "OBJECTIVES_TDEF_SCORE");
  }
  util::setobjectivehinttext("allies", & "OBJECTIVES_TDEF_ATTACKER_HINT");
  util::setobjectivehinttext("axis", & "OBJECTIVES_TDEF_ATTACKER_HINT");
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  spawnlogic::place_spawn_points("mp_tdm_spawn_allies_start");
  spawnlogic::place_spawn_points("mp_tdm_spawn_axis_start");
  spawnlogic::add_spawn_points("allies", "mp_tdm_spawn");
  spawnlogic::add_spawn_points("axis", "mp_tdm_spawn");
  spawning::updateallspawnpoints();
  level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  spawnpoint = spawnlogic::get_random_intermission_point();
  setdemointermissionpoint(spawnpoint.origin, spawnpoint.angles);
  if(!util::isoneround()) {
    level.displayroundendtext = 1;
    if(level.scoreroundwinbased) {
      globallogic_score::resetteamscores();
    }
  }
  tdef();
}

function tdef() {
  level.carryflag["allies"] = teams::get_flag_carry_model("allies");
  level.carryflag["axis"] = teams::get_flag_carry_model("axis");
  level.carryflag["neutral"] = teams::get_flag_model("neutral");
  level.gameflag = undefined;
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  if(!isplayer(attacker) || attacker.team == self.team) {
    return;
  }
  victim = self;
  score = rank::getscoreinfovalue("kill");
  assert(isDefined(score));
  if(isDefined(level.gameflag) && level.gameflag gameobjects::get_owner_team() == attacker.team) {
    if(isDefined(attacker.carryflag)) {
      attacker addplayerstat("KILLSASFLAGCARRIER", 1);
    }
    score = score * 2;
  } else {
    if(!isDefined(level.gameflag) && cancreateflagatvictimorigin(victim)) {
      level.gameflag = createflag(victim);
      score = score + rank::getscoreinfovalue("MEDAL_FIRST_BLOOD");
    } else if(isDefined(victim.carryflag)) {
      killcarrierbonus = rank::getscoreinfovalue("kill_carrier");
      level thread popups::displayteammessagetoall(&"MP_KILLED_FLAG_CARRIER", attacker);
      scoreevents::processscoreevent("kill_flag_carrier", attacker);
      attacker recordgameevent("kill_carrier");
      attacker addplayerstat("FLAGCARRIERKILLS", 1);
      attacker notify("objective", "kill_carrier");
      score = score + killcarrierbonus;
    }
  }
  if(!isDefined(killstreaks::get_killstreak_for_weapon(weapon)) || (isDefined(level.killstreaksgivegamescore) && level.killstreaksgivegamescore)) {
    attacker globallogic_score::giveteamscoreforobjective(attacker.team, score);
  }
  otherteam = util::getotherteam(attacker.team);
  if(game["state"] == "postgame" && game["teamScores"][attacker.team] > game["teamScores"][otherteam]) {
    attacker.finalkill = 1;
  }
}

function ondrop(player) {
  if(isDefined(player) && isDefined(player.tdef_flagtime)) {
    flagtime = int(gettime() - player.tdef_flagtime);
    player addplayerstat("HOLDINGTEAMDEFENDERFLAG", flagtime);
    if(((flagtime / 100) / 60) < 1) {
      flagminutes = 0;
    } else {
      flagminutes = int((flagtime / 100) / 60);
    }
    player addplayerstatwithgametype("DESTRUCTIONS", flagminutes);
    player.tdef_flagtime = undefined;
    player notify("dropped_flag");
  }
  team = self gameobjects::get_owner_team();
  otherteam = util::getotherteam(team);
  self.currentcarrier = undefined;
  self gameobjects::set_owner_team("neutral");
  self gameobjects::allow_carry("any");
  self gameobjects::set_visible_team("any");
  self gameobjects::set_2d_icon("friendly", level.iconcaptureflag2d);
  self gameobjects::set_3d_icon("friendly", level.iconcaptureflag3d);
  self gameobjects::set_2d_icon("enemy", level.iconcaptureflag2d);
  self gameobjects::set_3d_icon("enemy", level.iconcaptureflag3d);
  if(isDefined(player)) {
    if(isDefined(player.carryflag)) {
      player detachflag();
    }
    util::printandsoundoneveryone(team, undefined, & "MP_NEUTRAL_FLAG_DROPPED_BY", & "MP_NEUTRAL_FLAG_DROPPED_BY", "mp_war_objective_lost", "mp_war_objective_lost", player);
  } else {
    sound::play_on_players("mp_war_objective_lost", team);
    sound::play_on_players("mp_war_objective_lost", otherteam);
  }
  globallogic_audio::leader_dialog("dropped_flag", team);
  globallogic_audio::leader_dialog("enemy_dropped_flag", otherteam);
}

function onpickup(player) {
  self notify("picked_up");
  player.tdef_flagtime = gettime();
  player thread watchforendgame();
  score = rank::getscoreinfovalue("capture");
  assert(isDefined(score));
  team = player.team;
  otherteam = util::getotherteam(team);
  if(isDefined(level.tdef_loadouts) && isDefined(level.tdef_loadouts[team])) {
    player thread applyflagcarrierclass();
  } else {
    player attachflag();
  }
  self.currentcarrier = player;
  player.carryicon setshader(level.icon2d[team], player.carryicon.width, player.carryicon.height);
  self gameobjects::set_owner_team(team);
  self gameobjects::set_visible_team("any");
  self gameobjects::set_2d_icon("friendly", level.iconescort2d);
  self gameobjects::set_3d_icon("friendly", level.iconescort2d);
  self gameobjects::set_2d_icon("enemy", level.iconkill3d);
  self gameobjects::set_3d_icon("enemy", level.iconkill3d);
  globallogic_audio::leader_dialog("got_flag", team);
  globallogic_audio::leader_dialog("enemy_got_flag", otherteam);
  level thread popups::displayteammessagetoall(&"MP_CAPTURED_THE_FLAG", player);
  scoreevents::processscoreevent("flag_capture", player);
  player recordgameevent("pickup");
  player addplayerstatwithgametype("CAPTURES", 1);
  player notify("objective", "captured");
  util::printandsoundoneveryone(team, undefined, & "MP_NEUTRAL_FLAG_CAPTURED_BY", & "MP_NEUTRAL_FLAG_CAPTURED_BY", "mp_obj_captured", "mp_enemy_obj_captured", player);
  if(self.currentteam == otherteam) {
    player globallogic_score::giveteamscoreforobjective(team, score);
  }
  self.currentteam = team;
  if(level.matchrules_enemyflagradar) {
    self thread flagattachradar(otherteam);
  }
}

function applyflagcarrierclass() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  if(isDefined(self.iscarrying) && self.iscarrying == 1) {
    self notify("force_cancel_placement");
    wait(0.05);
  }
  self.pers["gamemodeLoadout"] = level.tdef_loadouts[self.team];
  spawnpoint = spawn("script_model", self.origin);
  spawnpoint.angles = self.angles;
  spawnpoint.playerspawnpos = self.origin;
  spawnpoint.notti = 1;
  self.setspawnpoint = spawnpoint;
  self.gamemode_chosenclass = self.curclass;
  self.pers["class"] = "gamemode";
  self.pers["lastClass"] = "gamemode";
  self.curclass = "gamemode";
  self.lastclass = "gamemode";
  self thread waitattachflag();
}

function waitattachflag() {
  level endon("game_ende");
  self endon("disconnect");
  self endon("death");
  self waittill("spawned_player");
  self attachflag();
}

function watchforendgame() {
  self endon("dropped_flag");
  self endon("disconnect");
  level waittill("game_ended");
  if(isDefined(self)) {
    if(isDefined(self.tdef_flagtime)) {
      flagtime = int(gettime() - self.tdef_flagtime);
      self addplayerstat("HOLDINGTEAMDEFENDERFLAG", flagtime);
      if(((flagtime / 100) / 60) < 1) {
        flagminutes = 0;
      } else {
        flagminutes = int((flagtime / 100) / 60);
      }
      self addplayerstatwithgametype("DESTRUCTIONS", flagminutes);
    }
  }
}

function cancreateflagatvictimorigin(victim) {
  minetriggers = getEntArray("minefield", "targetname");
  hurttriggers = getEntArray("trigger_hurt", "classname");
  radtriggers = getEntArray("radiation", "targetname");
  for(index = 0; index < radtriggers.size; index++) {
    if(victim istouching(radtriggers[index])) {
      return false;
    }
  }
  for(index = 0; index < minetriggers.size; index++) {
    if(victim istouching(minetriggers[index])) {
      return false;
    }
  }
  for(index = 0; index < hurttriggers.size; index++) {
    if(victim istouching(hurttriggers[index])) {
      return false;
    }
  }
  return true;
}

function createflag(victim) {
  visuals[0] = spawn("script_model", victim.origin);
  visuals[0] setModel(level.carryflag["neutral"]);
  trigger = spawn("trigger_radius", victim.origin, 0, 96, 72);
  gameflag = gameobjects::create_carry_object("neutral", trigger, visuals, vectorscale((0, 0, 1), 85));
  gameflag gameobjects::allow_carry("any");
  gameflag gameobjects::set_visible_team("any");
  gameflag gameobjects::set_2d_icon("enemy", level.iconcaptureflag2d);
  gameflag gameobjects::set_3d_icon("enemy", level.iconcaptureflag3d);
  gameflag gameobjects::set_2d_icon("friendly", level.iconcaptureflag2d);
  gameflag gameobjects::set_3d_icon("friendly", level.iconcaptureflag3d);
  gameflag gameobjects::set_carry_icon(level.icon2d["axis"]);
  gameflag.allowweapons = 1;
  gameflag.onpickup = & onpickup;
  gameflag.onpickupfailed = & onpickup;
  gameflag.ondrop = & ondrop;
  gameflag.oldradius = 96;
  gameflag.currentteam = "none";
  gameflag.requireslos = 1;
  level.favorclosespawnent = gameflag.trigger;
  level.favorclosespawnscalar = 3;
  gameflag thread updatebaseposition();
  return gameflag;
}

function updatebaseposition() {
  level endon("game_ended");
  while(true) {
    if(isDefined(self.safeorigin)) {
      self.baseorigin = self.safeorigin;
      self.trigger.baseorigin = self.safeorigin;
      self.visuals[0].baseorigin = self.safeorigin;
    }
    wait(0.05);
  }
}

function attachflag() {
  self attach(level.carryflag[self.team], "J_spine4", 1);
  self.carryflag = level.carryflag[self.team];
  level.favorclosespawnent = self;
}

function detachflag() {
  self detach(self.carryflag, "J_spine4");
  self.carryflag = undefined;
  level.favorclosespawnent = level.gameflag.trigger;
}

function flagattachradar(team) {
  level endon("game_ended");
  self endon("dropped");
}

function getflagradarowner(team) {
  level endon("game_ended");
  self endon("dropped");
  while(true) {
    foreach(player in level.players) {
      if(isalive(player) && player.team == team) {
        return player;
      }
    }
    wait(0.05);
  }
}

function flagradarmover() {
  level endon("game_ended");
  self endon("dropped");
  self.portable_radar endon("death");
  for(;;) {
    self.portable_radar moveto(self.currentcarrier.origin, 0.05);
    wait(0.05);
  }
}

function flagwatchradarownerlost() {
  level endon("game_ended");
  self endon("dropped");
  radarteam = self.portable_radar.team;
  self.portable_radar.owner util::waittill_any("disconnect", "joined_team", "joined_spectators");
  flagattachradar(radarteam);
}

function onroundendgame(roundwinner) {
  winner = globallogic::determineteamwinnerbygamestat("roundswon");
  return winner;
}

function onspawnplayer(predictedspawn) {
  self.usingobj = undefined;
  if(level.usestartspawns && !level.ingraceperiod) {
    level.usestartspawns = 0;
  }
  spawning::onspawnplayer(predictedspawn);
}

function onroundswitch() {
  game["switchedsides"] = !game["switchedsides"];
}

function initgametypeawards() {}

function setspecialloadouts() {}