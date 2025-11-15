/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\gametypes\doa.gsc
*************************************************/

#using scripts\cp\_callbacks;
#using scripts\cp\_skipto;
#using scripts\cp\_util;
#using scripts\cp\gametypes\_globallogic;
#using scripts\cp\gametypes\_globallogic_score;
#using scripts\cp\gametypes\_spawning;
#using scripts\cp\gametypes\_spawnlogic;
#using scripts\shared\ai\margwa;
#using scripts\shared\flag_shared;
#using scripts\shared\gameobjects_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\throttle_shared;
#namespace doa;

function autoexec ignore_systems() {
  level.var_be177839 = "";
  system::ignore("cybercom");
  system::ignore("healthoverlay");
  system::ignore("challenges");
  system::ignore("rank");
  system::ignore("hacker_tool");
  system::ignore("grapple");
  system::ignore("replay_gun");
  system::ignore("riotshield");
  system::ignore("oed");
  system::ignore("explosive_bolt");
  system::ignore("empgrenade");
  system::ignore("spawning");
  system::ignore("save");
  system::ignore("hud_message");
  system::ignore("friendlyfire");
}

function main() {
  level.var_e2c19907 = 1;
  globallogic::init();
  level.gametype = tolower(getdvarstring("g_gametype"));
  util::registerroundswitch(0, 9);
  util::registertimelimit(0, 0);
  util::registerscorelimit(0, 0);
  util::registerroundlimit(0, 10);
  util::registerroundwinlimit(0, 0);
  util::registernumlives(0, 100);
  globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
  level.scoreroundwinbased = 0;
  level.teamscoreperkill = 0;
  level.teamscoreperdeath = 0;
  level.teamscoreperheadshot = 0;
  level.teambased = 1;
  level.overrideteamscore = 1;
  level.onstartgametype = & onstartgametype;
  level.onspawnplayer = & onspawnplayer;
  level.onplayerkilled = & onplayerkilled;
  level.playermayspawn = & may_player_spawn;
  level.gametypespawnwaiter = & wait_to_spawn;
  level.noscavenger = 1;
  level.disableprematchmessages = 1;
  level.endgameonscorelimit = 0;
  level.endgameontimelimit = 0;
  level.ontimelimit = & globallogic::blank;
  level.onscorelimit = & globallogic::blank;
  level.onendgame = & onendgame;
  gameobjects::register_allowed_gameobject("coop");
  setscoreboardcolumns("kills", "gems", "skulls", "chickens", "deaths");
  if(!isDefined(level.gib_throttle)) {
    level.gib_throttle = new throttle();
  }
  [[level.gib_throttle]] - > initialize(5, 0.2);
}

function onstartgametype() {
  level.displayroundendtext = 0;
  setclientnamemode("auto_change");
  game["switchedsides"] = 0;
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  foreach(team in level.playerteams) {
    util::setobjectivetext(team, & "OBJECTIVES_COOP");
    util::setobjectivehinttext(team, & "OBJECTIVES_COOP_HINT");
    util::setobjectivescoretext(team, & "OBJECTIVES_COOP");
    spawnlogic::add_spawn_points(team, "cp_coop_spawn");
    spawnlogic::add_spawn_points(team, "cp_coop_respawn");
  }
  spawning::updateallspawnpoints();
  level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  spawnpoint = spawnlogic::get_random_intermission_point();
  setdemointermissionpoint(spawnpoint.origin, spawnpoint.angles);
  level.zombie_use_zigzag_path = 1;
}

function onspawnplayer(predictedspawn, question) {
  pixbeginevent("COOP:onSpawnPlayer");
  pixendevent();
}

function onendgame(winningteam) {
  exitlevel(0);
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {}

function wait_to_spawn() {
  return true;
}

function may_player_spawn() {
  return true;
}