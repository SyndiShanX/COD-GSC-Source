/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\gametypes\sas.gsc
*************************************************/

#using scripts\mp\_util;
#using scripts\mp\gametypes\_globallogic;
#using scripts\mp\gametypes\_globallogic_audio;
#using scripts\mp\gametypes\_globallogic_score;
#using scripts\mp\gametypes\_loadout;
#using scripts\mp\gametypes\_spawning;
#using scripts\mp\gametypes\_spawnlogic;
#using scripts\mp\gametypes\_wager;
#using scripts\shared\array_shared;
#using scripts\shared\gameobjects_shared;
#using scripts\shared\hud_message_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\math_shared;
#using scripts\shared\persistence_shared;
#using scripts\shared\rank_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_weapon_utils;
#namespace sas;

function main() {
  globallogic::init();
  level.weapon_sas_primary_weapon = getweapon("special_crossbow");
  level.weapon_sas_secondary_weapon = getweapon("knife_ballistic");
  level.weapon_sas_primary_grenade_weapon = getweapon("hatchet");
  util::registertimelimit(0, 1440);
  util::registerscorelimit(0, 5000);
  util::registerroundlimit(0, 10);
  util::registerroundwinlimit(0, 10);
  util::registernumlives(0, 100);
  level.onstartgametype = & onstartgametype;
  level.onplayerdamage = & onplayerdamage;
  level.onplayerkilled = & onplayerkilled;
  level.onplayerscore = & onplayerscore;
  level.pointsperprimarykill = getgametypesetting("pointsPerPrimaryKill");
  level.pointspersecondarykill = getgametypesetting("pointsPerSecondaryKill");
  level.pointsperprimarygrenadekill = getgametypesetting("pointsPerPrimaryGrenadeKill");
  level.pointspermeleekill = getgametypesetting("pointsPerMeleeKill");
  level.setbacks = getgametypesetting("setbacks");
  switch (getgametypesetting("gunSelection")) {
    case 0: {
      level.setbackweapon = undefined;
      break;
    }
    case 1: {
      level.setbackweapon = level.weapon_sas_primary_grenade_weapon;
      break;
    }
    case 2: {
      level.setbackweapon = level.weapon_sas_primary_weapon;
      break;
    }
    case 3: {
      level.setbackweapon = level.weapon_sas_secondary_weapon;
      break;
    }
    default: {
      assert(1, "");
      break;
    }
  }
  game["dialog"]["gametype"] = "sns_start";
  game["dialog"]["wm_humiliation"] = "mpl_wager_bankrupt";
  game["dialog"]["wm_humiliated"] = "sns_hum";
  gameobjects::register_allowed_gameobject(level.gametype);
  level.givecustomloadout = & givecustomloadout;
  var_e9a58782 = [];
  if(!isDefined(var_e9a58782)) {
    var_e9a58782 = [];
  } else if(!isarray(var_e9a58782)) {
    var_e9a58782 = array(var_e9a58782);
  }
  var_e9a58782[var_e9a58782.size] = "specialty_fastweaponswitch";
  if(!isDefined(var_e9a58782)) {
    var_e9a58782 = [];
  } else if(!isarray(var_e9a58782)) {
    var_e9a58782 = array(var_e9a58782);
  }
  var_e9a58782[var_e9a58782.size] = "specialty_jetcharger";
  if(!isDefined(var_e9a58782)) {
    var_e9a58782 = [];
  } else if(!isarray(var_e9a58782)) {
    var_e9a58782 = array(var_e9a58782);
  }
  var_e9a58782[var_e9a58782.size] = "specialty_tracker";
  level.var_e9a58782 = var_e9a58782;
  var_f32ba892 = [];
  if(!isDefined(var_f32ba892)) {
    var_f32ba892 = [];
  } else if(!isarray(var_f32ba892)) {
    var_f32ba892 = array(var_f32ba892);
  }
  var_f32ba892[var_f32ba892.size] = "gadget_camo";
  if(!isDefined(var_f32ba892)) {
    var_f32ba892 = [];
  } else if(!isarray(var_f32ba892)) {
    var_f32ba892 = array(var_f32ba892);
  }
  var_f32ba892[var_f32ba892.size] = "gadget_clone";
  level.var_772fe844 = array::random(var_f32ba892);
  globallogic::setvisiblescoreboardcolumns("pointstowin", "kills", "deaths", "tomahawks", "humiliated");
}

function givecustomloadout() {
  self notify("sas_spectator_hud");
  defaultweapon = level.weapon_sas_primary_weapon;
  loadout::setclassnum(self.curclass);
  self wager::setup_blank_random_player(1, 1, defaultweapon);
  self giveperks();
  self giveweapon(defaultweapon);
  self setweaponammoclip(defaultweapon, 6);
  self setweaponammostock(defaultweapon, 6);
  self.primaryloadoutweapon = defaultweapon;
  secondaryweapon = level.weapon_sas_secondary_weapon;
  self giveweapon(secondaryweapon);
  self setweaponammostock(secondaryweapon, 2);
  self.secondaryloadoutweapon = defaultweapon;
  offhandprimary = level.weapon_sas_primary_grenade_weapon;
  self setoffhandprimaryclass(offhandprimary);
  self giveweapon(offhandprimary);
  self setweaponammoclip(offhandprimary, 1);
  self setweaponammostock(offhandprimary, 1);
  self.grenadetypeprimary = offhandprimary;
  self.grenadetypeprimarycount = 1;
  secondaryoffhand = getweapon("null_offhand_secondary");
  secondaryoffhandcount = 0;
  self giveweapon(secondaryoffhand);
  self setweaponammoclip(secondaryoffhand, secondaryoffhandcount);
  self switchtooffhand(secondaryoffhand);
  self.grenadetypesecondary = secondaryoffhand;
  self.grenadetypesecondarycount = secondaryoffhandcount;
  self giveweapon(level.weaponbasemelee);
  self function_9b921991();
  self switchtoweapon(defaultweapon);
  self setspawnweapon(defaultweapon);
  self.killswithsecondary = 0;
  self.killswithprimary = 0;
  self.killswithbothawarded = 0;
  return defaultweapon;
}

function function_9b921991() {
  specialoffhand = self.var_8ed41d1a;
  var_a664ae9a = 0;
  if(!isDefined(specialoffhand)) {
    specialoffhand = getweapon(level.var_772fe844);
    var_a664ae9a = 1;
  }
  specialoffhandcount = specialoffhand.startammo;
  self giveweapon(specialoffhand);
  self setweaponammoclip(specialoffhand, specialoffhandcount);
  self switchtooffhand(specialoffhand);
  self.grenadetypespecial = specialoffhand;
  self.grenadetypespecialcount = specialoffhandcount;
  if(isDefined(var_a664ae9a) && var_a664ae9a) {
    slot = self gadgetgetslot(specialoffhand);
    self gadgetpowerset(slot, 0);
  }
  self.var_8ed41d1a = specialoffhand;
}

function giveperks() {
  foreach(perkname in level.var_e9a58782) {
    self setperk(perkname);
  }
}

function onplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
  if(weapon == level.weapon_sas_primary_weapon && smeansofdeath == "MOD_IMPACT") {
    if(isDefined(eattacker) && isplayer(eattacker)) {
      if(!isDefined(eattacker.pers["sticks"])) {
        eattacker.pers["sticks"] = 1;
      } else {
        eattacker.pers["sticks"]++;
      }
      eattacker.sticks = eattacker.pers["sticks"];
    }
  }
  return idamage;
}

function onplayerscore(event, player, victim) {
  score = player.pers["pointstowin"];
  if(!level.rankedmatch) {
    player thread rank::updaterankscorehud(score - player.pers["score"]);
  }
  player.pers["score"] = score;
  player.score = player.pers["score"];
  recordplayerstats(player, "score", player.pers["score"]);
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  if(isDefined(attacker) && isplayer(attacker) && attacker != self) {
    if(weapon_utils::ismeleemod(smeansofdeath)) {
      attacker globallogic_score::givepointstowin(level.pointspermeleekill);
      onplayerscore(undefined, attacker, undefined);
    } else {
      if(weapon == level.weapon_sas_primary_weapon) {
        attacker.killswithprimary++;
        if(attacker.killswithbothawarded == 0 && attacker.killswithsecondary > 0) {
          attacker.killswithbothawarded = 1;
        }
        attacker globallogic_score::givepointstowin(level.pointsperprimarykill);
        onplayerscore(undefined, attacker, undefined);
      } else {
        if(weapon == level.weapon_sas_primary_grenade_weapon) {
          attacker globallogic_score::givepointstowin(level.pointsperprimarygrenadekill);
          onplayerscore(undefined, attacker, undefined);
        } else {
          if(weapon == level.weapon_sas_secondary_weapon) {
            attacker.killswithsecondary++;
            if(attacker.killswithbothawarded == 0 && attacker.killswithprimary > 0) {
              attacker.killswithbothawarded = 1;
            }
          }
          attacker globallogic_score::givepointstowin(level.pointspersecondarykill);
          onplayerscore(undefined, attacker, undefined);
        }
      }
    }
    if(isDefined(level.setbackweapon) && weapon == level.setbackweapon) {
      self.pers["humiliated"]++;
      self.humiliated = self.pers["humiliated"];
      if(level.setbacks == 0) {
        self globallogic_score::setpointstowin(0);
        onplayerscore(undefined, self, undefined);
      } else {
        self globallogic_score::givepointstowin(level.setbacks * -1);
        onplayerscore(undefined, self, undefined);
      }
      attacker playlocalsound("mpl_fracture_sting_moved");
      attacker addplayerstatwithgametype("HUMILIATE_ATTACKER", 1);
      self thread function_238fd5eb();
    }
  } else {
    self.pers["humiliated"]++;
    self.humiliated = self.pers["humiliated"];
    if(level.setbacks == 0) {
      self globallogic_score::setpointstowin(0);
      onplayerscore(undefined, self, undefined);
    } else {
      self globallogic_score::givepointstowin(level.setbacks * -1);
      onplayerscore(undefined, self, undefined);
    }
    self thread function_238fd5eb();
  }
}

function function_238fd5eb() {
  self endon("disconnect");
  self endon("death");
  self addplayerstatwithgametype("HUMILIATE_VICTIM", 1);
  self waittill("spawned_player");
  self playlocalsound("mpl_assassination_sting");
  var_a40af05c = self hud::createfontstring("default", 2.5);
  var_a40af05c hud::setpoint("CENTER", undefined, 0, -100);
  var_a40af05c.label = & "MP_HUMILIATED";
  var_a40af05c.x = 0;
  var_a40af05c.archived = 1;
  var_a40af05c.alpha = 1;
  var_a40af05c.glowalpha = 0;
  var_a40af05c.hidewheninmenu = 0;
  self thread function_71a0cd6d(var_a40af05c);
  wait(0.1);
  var_a40af05c fadeovertime(0.2);
  var_a40af05c.color = (1, 0, 0);
  var_a40af05c changefontscaleovertime(0.2);
  var_a40af05c.fontscale = 3;
  wait(0.5);
  var_a40af05c fadeovertime(0.5);
  var_a40af05c.color = (1, 1, 1);
  var_a40af05c changefontscaleovertime(0.5);
  var_a40af05c.fontscale = 2.5;
  wait(1);
  self notify("hash_c8d75045");
  var_a40af05c destroy();
}

function function_71a0cd6d(var_a40af05c) {
  self endon("hash_c8d75045");
  self util::waittill_any("disconnect", "death");
  if(isDefined(var_a40af05c)) {
    var_a40af05c destroy();
  }
}

function setupteam(team) {
  util::setobjectivetext(team, & "OBJECTIVES_SAS");
  if(level.splitscreen) {
    util::setobjectivescoretext(team, & "OBJECTIVES_SAS");
  } else {
    util::setobjectivescoretext(team, & "OBJECTIVES_SAS_SCORE");
  }
  util::setobjectivehinttext(team, & "OBJECTIVES_SAS_HINT");
  spawnlogic::add_spawn_points(team, "mp_dm_spawn");
  spawnlogic::place_spawn_points("mp_dm_spawn_start");
  level.spawn_start = spawnlogic::get_spawnpoint_array("mp_dm_spawn_start");
}

function onstartgametype() {
  setdvar("tu29_gametypeOverridesGadget", 1);
  setclientnamemode("auto_change");
  spawning::create_map_placed_influencers();
  level.spawnmins = (0, 0, 0);
  level.spawnmaxs = (0, 0, 0);
  foreach(team in level.teams) {
    setupteam(team);
  }
  spawning::updateallspawnpoints();
  level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
  setmapcenter(level.mapcenter);
  spawnpoint = spawnlogic::get_random_intermission_point();
  setdemointermissionpoint(spawnpoint.origin, spawnpoint.angles);
  level.usestartspawns = 0;
  level.displayroundendtext = 0;
  if(isDefined(game["roundsplayed"]) && game["roundsplayed"] > 0) {
    game["dialog"]["gametype"] = undefined;
    game["dialog"]["offense_obj"] = undefined;
    game["dialog"]["defense_obj"] = undefined;
  }
}

function onwagerawards() {
  tomahawks = self globallogic_score::getpersstat("tomahawks");
  if(!isDefined(tomahawks)) {
    tomahawks = 0;
  }
  self persistence::set_after_action_report_stat("wagerAwards", tomahawks, 0);
  sticks = self globallogic_score::getpersstat("sticks");
  if(!isDefined(sticks)) {
    sticks = 0;
  }
  self persistence::set_after_action_report_stat("wagerAwards", sticks, 1);
  bestkillstreak = self globallogic_score::getpersstat("best_kill_streak");
  if(!isDefined(bestkillstreak)) {
    bestkillstreak = 0;
  }
  self persistence::set_after_action_report_stat("wagerAwards", bestkillstreak, 2);
}