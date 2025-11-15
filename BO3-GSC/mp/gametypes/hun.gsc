/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\gametypes\hun.gsc
*************************************************/

#using scripts\mp\_util;
#using scripts\mp\gametypes\_globallogic;
#using scripts\mp\gametypes\_globallogic_audio;
#using scripts\mp\gametypes\_spawning;
#using scripts\mp\gametypes\_spawnlogic;
#using scripts\mp\killstreaks\_supplydrop;
#using scripts\shared\gameobjects_shared;
#using scripts\shared\math_shared;
#using scripts\shared\util_shared;
#namespace hun;

function main() {
  globallogic::init();
  util::registertimelimit(0, 1440);
  util::registerscorelimit(0, 50000);
  util::registerroundlimit(0, 10);
  util::registerroundwinlimit(0, 10);
  util::registernumlives(0, 100);
  globallogic::registerfriendlyfiredelay(level.gametype, 0, 0, 1440);
  level.scoreroundwinbased = 1;
  level.resetplayerscoreeveryround = 1;
  level.onstartgametype = & onstartgametype;
  level.givecustomloadout = & givecustomloadout;
  level.helitime = getgametypesetting("objectiveSpawnTime");
  gameobjects::register_allowed_gameobject("dm");
  game["dialog"]["gametype"] = "ffa_start";
  game["dialog"]["gametype_hardcore"] = "hcffa_start";
  game["dialog"]["offense_obj"] = "generic_boost";
  game["dialog"]["defense_obj"] = "generic_boost";
  globallogic::setvisiblescoreboardcolumns("score", "kills", "deaths", "kdratio", "headshots");
}

function onstartgametype() {
  setclientnamemode("auto_change");
  util::setobjectivetext("allies", & "OBJECTIVES_DM");
  util::setobjectivetext("axis", & "OBJECTIVES_DM");
  if(level.splitscreen) {
    util::setobjectivescoretext("allies", & "OBJECTIVES_DM");
    util::setobjectivescoretext("axis", & "OBJECTIVES_DM");
  } else {
    util::setobjectivescoretext("allies", & "OBJECTIVES_DM_SCORE");
    util::setobjectivescoretext("axis", & "OBJECTIVES_DM_SCORE");
  }
  util::setobjectivehinttext("allies", & "OBJECTIVES_DM_HINT");
  util::setobjectivehinttext("axis", & "OBJECTIVES_DM_HINT");
  spawning::create_map_placed_influencers();
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  spawnlogic::add_spawn_points("allies", "mp_dm_spawn");
  spawnlogic::add_spawn_points("axis", "mp_dm_spawn");
  spawning::updateallspawnpoints();
  level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  spawnpoint = spawnlogic::get_random_intermission_point();
  setdemointermissionpoint(spawnpoint.origin, spawnpoint.angles);
  level.usestartspawns = 0;
  level.displayroundendtext = 0;
  level thread onscoreclosemusic();
  if(!util::isoneround()) {
    level.displayroundendtext = 1;
  }
  level.heliowner = spawn("script_origin", (0, 0, 0));
  initdroplocations();
  registercrates();
  thread cratedropper();
}

function onendgame(winningplayer) {
  if(isDefined(winningplayer) && isplayer(winningplayer)) {
    [[level._setplayerscore]](winningplayer, winningplayer[[level._getplayerscore]]() + 1);
  }
}

function givecustomloadout() {
  self takeallweapons();
  self clearperks();
  weapon = getweapon("pistol_standard");
  self.primaryweapon = weapon;
  self.lethalgrenade = getweapon("hatchet");
  self.tacticalgrenade = undefined;
  self giveweapon(weapon);
  self giveweapon(level.weaponbasemelee);
  self giveweapon(level.weaponbasemeleeheld);
  self giveweapon(self.lethalgrenade);
  self setweaponammostock(weapon, 0);
  self setweaponammoclip(weapon, 5);
  self switchtoweapon(weapon);
  self setspawnweapon(weapon);
  return weapon;
}

function onscoreclosemusic() {
  while(!level.gameended) {
    scorelimit = level.scorelimit;
    scorethreshold = scorelimit * 0.9;
    for(i = 0; i < level.players.size; i++) {
      scorecheck = [
        [level._getplayerscore]
      ](level.players[i]);
      if(scorecheck >= scorethreshold) {
        thread globallogic_audio::set_music_on_team("timeOut");
        return;
      }
    }
    wait(0.5);
  }
}

function inside_bounds(node_origin, bounds) {
  mins = level.mapcenter - bounds;
  maxs = level.mapcenter + bounds;
  if(node_origin[0] > maxs[0]) {
    return false;
  }
  if(node_origin[0] < mins[0]) {
    return false;
  }
  if(node_origin[1] > maxs[1]) {
    return false;
  }
  if(node_origin[1] < mins[1]) {
    return false;
  }
  return true;
}

function initdroplocations() {
  scalar = 0.8;
  bound = (level.spawnmaxs - level.mapcenter) * scalar;
  possible_nodes = getallnodes();
  nodes = [];
  count = 0;
  foreach(node in possible_nodes) {
    if(inside_bounds(node.origin, bound)) {
      nodes[nodes.size] = node;
      count++;
    }
  }
  level.dropnodes = nodes;
}

function registercrates() {
  supplydrop::registercratetype("hunted", "weapon", "smg_standard", 1, & "WEAPON_SMG_STANDARD", undefined, & givehuntedweapon, & huntedcratelandoverride);
  supplydrop::registercratetype("hunted", "weapon", "ar_standard", 1, & "WEAPON_AR_STANDARD", undefined, & givehuntedweapon, & huntedcratelandoverride);
  supplydrop::registercratetype("hunted", "weapon", "lmg_light", 1, & "WEAPON_LMG_LIGHT", undefined, & givehuntedweapon, & huntedcratelandoverride);
  supplydrop::registercratetype("hunted", "weapon", "shotgun_pump", 1, & "WEAPON_SHOTGUN_PUMP", undefined, & givehuntedweapon, & huntedcratelandoverride);
  supplydrop::registercratetype("hunted", "weapon", "pistol_standard", 1, & "WEAPON_PISTOL_STANDARD", undefined, & givehuntedweapon, & huntedcratelandoverride);
  supplydrop::setcategorytypeweight("hunted", "weapon", 4);
  supplydrop::setcategorytypeweight("hunted", "killstreak", 1);
  supplydrop::advancedfinalizecratecategory("hunted");
}

function givehuntedweapon(weapon) {
  if(isDefined(self.primaryweapon)) {
    self takeweapon(self.primaryweapon);
  }
  self.primaryweapon = weapon;
  self giveweapon(weapon);
  self switchtoweapon(weapon);
  self setweaponammostock(weapon, 0);
}

function givehuntedlethalgrenade(weapon) {
  if(self.lethalgrenade == weapon) {
    currstock = self getammocount(weapon);
    self setweaponammostock(weapon, currstock + 1);
    return;
  }
  if(isDefined(self.lethalgrenade)) {
    self takeweapon(self.lethalgrenade);
  }
  self.lethalgrenade = weapon;
  self giveweapon(weapon);
  self setoffhandprimaryclass(weapon);
}

function givehuntedtacticalgrenade(weapon) {
  if(self.tacticalgrenade == weapon) {
    currstock = self getammocount(weapon);
    self setweaponammostock(weapon, currstock + 1);
    return;
  }
  if(isDefined(self.tacticalgrenade)) {
    self takeweapon(self.tacticalgrenade);
  }
  self.tacticalgrenade = weapon;
  self giveweapon(weapon);
  self setoffhandsecondaryclass(weapon);
}

function huntedcratelandoverride(crate, category, owner, team) {
  crate.visibletoall = 1;
  crate supplydrop::crateactivate();
  crate thread supplydrop::crateusethink();
  crate thread supplydrop::crateusethinkowner();
  supplydrop::default_land_function(crate, category, owner, team);
}

function getcratedroporigin() {
  node = undefined;
  time = 10000;
  while(!isDefined(node)) {
    random_index = randomint(level.dropnodes.size);
    if(!isDefined(level.dropnodes[random_index])) {
      continue;
    }
    node_origin = level.dropnodes[random_index].origin;
    if(!bullettracepassed(node_origin + vectorscale((0, 0, 1), 1000), node_origin, 0, undefined)) {
      level.dropnodes[random_index] = undefined;
      continue;
    }
    node = level.dropnodes[random_index];
    break;
  }
  return node.origin;
}

function cratedropper() {
  wait_time = level.helitime;
  time = 10000;
  while(true) {
    wait(wait_time);
    origin = getcratedroporigin();
    self thread supplydrop::helidelivercrate(origin, "hunted", level.heliowner, "free", 0, 0);
  }
}