/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\death_switch.gsc
***************************************************/

function init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("death_switch", &tryusedeathswitchfromstruct);
  level.killstreak_laststand_func = &deathswitch_startpayloadreleasesequence;
}

function tryusedeathswitch() {
  var0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("death_switch", self);
  return tryusedeathswitchfromstruct(var0);
}

function tryusedeathswitchfromstruct(var0) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var0)) {
      return false;
    }
  }

  level thread scripts\mp\battlechatter_mp::trysaylocalsound(self, "use_killstreak_deadman");
  var1 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(var0, getcompleteweaponname("ks_gesture_vest_mp"));

  if(!istrue(var1)) {
    return false;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var0)) {
      return false;
    }
  }

  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("use_" + var0.streakname, 1);
  scripts\common\utility::ref_13e0a(level.ref_11b2a, "death_switch", self.origin);
  thread scripts\mp\hud_util::teamplayercardsplash("used_death_switch", self);
  thread startdeathswitch(var0);
  return true;
}

function weapongivendeathswitch(var0) {
  return true;
}

function startdeathswitch(var0) {
  self endon("disconnect");
  level endon("game_ended");
  self iprintlnbold("If I go down, I'm taking them with me!");
  scripts\mp\utility\perk::giveperk("specialty_pistoldeath");
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

  for(;;) {
    self.deathswitchent setscriptablepartstate("blinking_light", "on", 0);
    wait 0.5;
    self.deathswitchent setscriptablepartstate("blinking_light", "off", 0);
  }
}

function debugloc() {
  self endon("death");

  for(;;) {
    waitframe();
  }
}

function deathswitch_startpayloadreleasesequence() {
  var0 = "iw8_fists_mp_ls";
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var0, undefined, undefined, 1);
  thread scripts\mp\laststand::switchtofists(var0);
  self.laststandactionset = "laststand_killstreak";
  scripts\mp\playeractions::allowactionset(self.laststandactionset, 0);
  thread deathswitch_payloadrelease(3);
  thread deathswitch_watchbleedout(3);
}

function deathswitch_payloadrelease(var0) {
  self endon("payload_release");
  self endon("disconnect");
  level endon("game_ended");
  var1 = 1;
  var2 = scripts\mp\utility\weapon::_launchgrenade("death_switch_blast_mp", self gettagorigin("j_mainroot"), (0, 0, 0), var0, 1);
  var2 linkTo(self);
  thread deathswitch_payloadreleaseondeath(var1, var2);

  for(var3 = 1; var0 > 0; var3 = 0.05) {
    self iprintlnbold("Death Switch Countdown: " + var0);
    var0 -= var3;
    playsoundatpos(self.origin, "death_switch_beep");
    wait var3;
    var3 -= 0.2;

    if(var3 < 0.05) {}
  }

  deathswitch_payloadreleasetype(var1, var2);
}

function deathswitch_payloadreleaseondeath(var0, var1) {
  self endon("payload_release");
  self endon("disconnect");
  level endon("game_ended");
  self notify("watch_switch_on_death");
  self endon("watch_switch_on_death");
  self waittill("death");
  deathswitch_payloadreleasetype(var0, var1);
}

function deathswitch_payloadreleasetype(var0, var1) {
  if(isDefined(var1)) {
    var1 delete();
  }

  switch (var0) {
    case 0:
      thread deathswitch_releaselocalexplosion();
      break;
    case 1:
      thread deathswitch_releaseartilleryexplosion();
      break;
    default:
      break;
  }

  self.killstreaklaststand = undefined;
  scripts\mp\utility\perk::removeperk("specialty_pistoldeath");
  self notify("payload_release");
}

function deathswitch_releaselocalexplosion() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("deathSwitch_release");
  self.deathswitchent setscriptablepartstate("blinking_light", "off", 0);
  self.deathswitchent setscriptablepartstate("explode", "on", 0);
  self.deathswitchent setentityowner(self);
  self.deathswitchent thread scripts\mp\utility\script::delayentdelete(5);
}

function deathswitch_releaseartilleryexplosion() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("deathSwitch_release");
  var0 = self.origin + (0, 0, 20000);
  var1 = self.origin;
  var2 = scripts\cp_mp\utility\weapon_utility::_magicbullet(getcompleteweaponname("death_switch_proj_mp"), var0, var1, self);
  self.deathswitchent setscriptablepartstate("blinking_light", "off", 0);
  self.deathswitchent thread scripts\mp\utility\script::delayentdelete(5);
}

function deathswitch_watchbleedout(var0) {
  level endon("game_ended");
  level endon("death_or_disconnect");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var0);
  scripts\mp\utility\damage::_suicide();
}