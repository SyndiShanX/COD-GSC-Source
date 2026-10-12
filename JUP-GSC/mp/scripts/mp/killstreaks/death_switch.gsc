/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\death_switch.gsc
***************************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\hud_util;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\laststand;
#using scripts\mp\utility\damage;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\print;
#using scripts\mp\utility\script;
#using scripts\mp\utility\weapon;
#namespace death_switch;

function init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("death_switch", &tryusedeathswitchfromstruct);

  setdevdvarifuninitialized(@ "hash_7ea8f7418e6bf019", 1);

  level.killstreak_laststand_func = &deathswitch_startpayloadreleasesequence;
}

function tryusedeathswitch() {
  streakinfo = createstreakinfo("death_switch", self);
  return tryusedeathswitchfromstruct(streakinfo);
}

function tryusedeathswitchfromstruct(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo)) {
      return false;
    }
  }

  deployresult = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(streakinfo, makeweapon("ks_gesture_vest_mp"));

  if(!istrue(deployresult)) {
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      return false;
    }
  }

  playkillstreakoperatordialog("death_switch", "use_" + "death_switch", 1);
  utility::trycall(level.matchdata_logkillstreakevent, "death_switch", self.origin);
  thread teamplayercardsplash("used_" + "death_switch", self);
  thread startdeathswitch(streakinfo);
  return true;
}

function weapongivendeathswitch(streakinfo) {
  return true;
}

function startdeathswitch(streakinfo) {
  self endon("disconnect");
  level endon("game_ended");
  self iprintlnbold("If I go down, I'm taking them with me!");
  giveperk("specialty_pistoldeath");
  self.killstreaklaststand = 1;
  self.deathswitchent = spawn("script_model", self gettagorigin("j_helmet"));
  self.deathswitchent setModel("ks_death_switch_mp");
  self.deathswitchent.angles = self.angles;
  self.deathswitchent linkTo(self, "j_helmet", (0, 0, 0), (0, 0, 0));
  thread deathswitch_loopblinkinglight();
}

function deathswitch_loopblinkinglight() {
  self endon("disconnect");
  self endon("deathSwitch_release");

  while(true) {
    self.deathswitchent setscriptablepartstate("blinking_light", "on", 0);
    wait 0.5;
    self.deathswitchent setscriptablepartstate("blinking_light", "off", 0);
  }
}

function debugloc() {
  self endon("<dev string:x1c>");

  while(true) {
    sphere(self.origin, 5, (1, 0, 0), 0, 1);
    waitframe();
  }
}

function deathswitch_startpayloadreleasesequence() {
  laststandweapon = "iw9_me_fists_mp_ls";
  _giveweapon(laststandweapon, undefined, undefined, 1);
  thread scripts\mp\laststand::switchtofists(laststandweapon);
  self.laststandactionset = "laststand_killstreak";
  val::group_set(self.laststandactionset, 0);
  thread deathswitch_payloadrelease(3);
  thread deathswitch_watchbleedout(3);
}

function deathswitch_payloadrelease(var_3b40edf8da5d7be3) {
  self endon("payload_release");
  self endon("disconnect");
  level endon("game_ended");
  payloadtype = 1;

  payloadtype = getdvarint(@ "hash_7ea8f7418e6bf019", 1);

  projectile = _launchgrenade("death_switch_blast_mp", self gettagorigin("j_mainroot"), (0, 0, 0), var_3b40edf8da5d7be3, 1);
  projectile linkTo(self);
  thread deathswitch_payloadreleaseondeath(payloadtype, projectile);

  for(startingwait = 1; var_3b40edf8da5d7be3 > 0; startingwait = 0.05) {
    self iprintlnbold("Death Switch Countdown: " + var_3b40edf8da5d7be3);
    var_3b40edf8da5d7be3 -= startingwait;
    playsoundatpos(self.origin, "death_switch_beep");
    wait startingwait;
    startingwait -= 0.2;

    if(startingwait < 0.05) {}
  }

  deathswitch_payloadreleasetype(payloadtype, projectile);
}

function deathswitch_payloadreleaseondeath(payloadtype, projectile) {
  self endon("payload_release");
  self endon("disconnect");
  level endon("game_ended");
  self notify("watch_switch_on_death");
  self endon("watch_switch_on_death");
  self waittill("death");
  deathswitch_payloadreleasetype(payloadtype, projectile);
}

function deathswitch_payloadreleasetype(payloadtype, projectile) {
  if(isDefined(projectile)) {
    projectile delete();
  }

  switch (payloadtype) {
    case 0:
      thread deathswitch_releaselocalexplosion();
      break;
    case 1:
      thread deathswitch_releaseartilleryexplosion();
      break;
    default:
      assertmsg("<dev string:x25>");
      break;
  }

  self.killstreaklaststand = undefined;
  removeperk("specialty_pistoldeath");
  self notify("payload_release");
}

function deathswitch_releaselocalexplosion() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("deathSwitch_release");
  self.deathswitchent setscriptablepartstate("blinking_light", "off", 0);
  self.deathswitchent setscriptablepartstate("explode", "on", 0);
  self.deathswitchent setentityowner(self);
  self.deathswitchent thread delayentdelete(5);
}

function deathswitch_releaseartilleryexplosion() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("deathSwitch_release");
  launchpoint = self.origin + (0, 0, 20000);
  goalpoint = self.origin;
  missile = _magicbullet(makeweapon("death_switch_proj_mp"), launchpoint, goalpoint, self);
  self.deathswitchent setscriptablepartstate("blinking_light", "off", 0);
  self.deathswitchent thread delayentdelete(5);
}

function deathswitch_watchbleedout(bleedouttime) {
  level endon("game_ended");
  level endon("death_or_disconnect");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(bleedouttime);
  _suicide();
}