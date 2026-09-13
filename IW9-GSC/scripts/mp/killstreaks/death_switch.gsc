/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\death_switch.gsc
***************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("death_switch", ::tryusedeathswitchfromstruct);
  level.killstreak_laststand_func = ::deathswitch_startpayloadreleasesequence;
}

tryusedeathswitch() {
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("death_switch", self);
  return tryusedeathswitchfromstruct(streakinfo);
}

tryusedeathswitchfromstruct(streakinfo) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo))
      return 0;
  }

  _id_9B1DEB5E9D32BBE3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(streakinfo, makeweapon("ks_gesture_vest_mp"));

  if(!istrue(_id_9B1DEB5E9D32BBE3))
    return 0;

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo))
      return 0;
  }

  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("death_switch", "use_death_switch", 1);
  scripts\common\utility::trycall(level.matchdata_logkillstreakevent, "death_switch", self.origin);
  thread scripts\mp\hud_util::teamplayercardsplash("used_death_switch", self);
  thread startdeathswitch(streakinfo);
  return 1;
}

weapongivendeathswitch(streakinfo) {
  return 1;
}

startdeathswitch(streakinfo) {
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

deathswitch_loopblinkinglight() {
  self endon("disconnect");
  self endon("deathSwitch_release");

  for(;;) {
    self.deathswitchent setscriptablepartstate("blinking_light", "on", 0);
    wait 0.5;
    self.deathswitchent setscriptablepartstate("blinking_light", "off", 0);
  }
}

debugloc() {
  self endon("death");

  for(;;)
    waitframe();
}

deathswitch_startpayloadreleasesequence() {
  laststandweapon = "iw9_me_fists_mp_ls";
  scripts\cp_mp\utility\inventory_utility::_giveweapon(laststandweapon, undefined, undefined, 1);
  thread scripts\mp\laststand::switchtofists(laststandweapon);
  self.laststandactionset = "laststand_killstreak";
  _id_3B64EB40368C1450::_id_3633B947164BE4F3(self.laststandactionset, 0);
  thread deathswitch_payloadrelease(3);
  thread deathswitch_watchbleedout(3);
}

deathswitch_payloadrelease(_id_3B40EDF8DA5D7BE3) {
  self endon("payload_release");
  self endon("disconnect");
  level endon("game_ended");
  _id_91BBEC893BA76069 = 1;
  projectile = scripts\mp\utility\weapon::_launchgrenade("death_switch_blast_mp", self gettagorigin("j_mainroot"), (0, 0, 0), _id_3B40EDF8DA5D7BE3, 1);
  projectile linkTo(self);
  thread deathswitch_payloadreleaseondeath(_id_91BBEC893BA76069, projectile);
  _id_614EAF960CF259B0 = 1;

  while(_id_3B40EDF8DA5D7BE3 > 0) {
    self iprintlnbold("Death Switch Countdown: " + _id_3B40EDF8DA5D7BE3);
    _id_3B40EDF8DA5D7BE3 = _id_3B40EDF8DA5D7BE3 - _id_614EAF960CF259B0;
    playsoundatpos(self.origin, "death_switch_beep");
    wait(_id_614EAF960CF259B0);
    _id_614EAF960CF259B0 = _id_614EAF960CF259B0 - 0.2;

    if(_id_614EAF960CF259B0 < 0.05)
      _id_614EAF960CF259B0 = 0.05;
  }

  deathswitch_payloadreleasetype(_id_91BBEC893BA76069, projectile);
}

deathswitch_payloadreleaseondeath(_id_91BBEC893BA76069, projectile) {
  self endon("payload_release");
  self endon("disconnect");
  level endon("game_ended");
  self notify("watch_switch_on_death");
  self endon("watch_switch_on_death");
  self waittill("death");
  deathswitch_payloadreleasetype(_id_91BBEC893BA76069, projectile);
}

deathswitch_payloadreleasetype(_id_91BBEC893BA76069, projectile) {
  if(isDefined(projectile))
    projectile delete();

  switch (_id_91BBEC893BA76069) {
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

deathswitch_releaselocalexplosion() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("deathSwitch_release");
  self.deathswitchent setscriptablepartstate("blinking_light", "off", 0);
  self.deathswitchent setscriptablepartstate("explode", "on", 0);
  self.deathswitchent setentityowner(self);
  self.deathswitchent thread scripts\mp\utility\script::delayentdelete(5);
}

deathswitch_releaseartilleryexplosion() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("deathSwitch_release");
  _id_B0D1C69E44F250EC = self.origin + (0, 0, 20000);
  _id_76A498119F4D69BC = self.origin;
  missile = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon("death_switch_proj_mp"), _id_B0D1C69E44F250EC, _id_76A498119F4D69BC, self);
  self.deathswitchent setscriptablepartstate("blinking_light", "off", 0);
  self.deathswitchent thread scripts\mp\utility\script::delayentdelete(5);
}

deathswitch_watchbleedout(_id_D229E334EC96F738) {
  level endon("game_ended");
  level endon("death_or_disconnect");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(_id_D229E334EC96F738);
  scripts\mp\utility\damage::_suicide();
}