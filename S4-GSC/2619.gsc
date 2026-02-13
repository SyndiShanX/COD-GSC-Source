/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2619.gsc
*************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::_id_C26A("death_switch", ::_id_F777);
  level._id_8DB6 = ::_id_441C;
}

_id_F776() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::_id_4056("death_switch", self);
  return _id_F777(var_0);
}

_id_F777(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level._id_8DEB)) {
    if(!level[[level._id_8DEB]](var_0)) {
      return 0;
    }
  }

  level thread scripts\mp\battlechatter_mp::_id_F759(self, "use_killstreak_deadman");
  var_1 = _id_09B9::_id_EA01(var_0, makeweapon("ks_gesture_vest_mp"));

  if(!istrue(var_1)) {
    return 0;
  }

  if(isDefined(level._id_8DC6)) {
    if(!level[[level._id_8DC6]](var_0)) {
      return 0;
    }
  }

  scripts\cp_mp\utility\killstreak_utility::_id_B86F("use_" + var_0.streakname, 1);
  scripts\common\utility::_id_F73A(level._id_9BB4, "death_switch", self.origin);
  thread scripts\mp\hud_util::_id_EF8D("used_death_switch", self);
  thread _id_E697(var_0);
  return 1;
}

_id_10D8C(var_0) {
  return 1;
}

_id_E697(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  self iprintlnbold("If I go down, I'm taking them with me!");
  scripts\mp\utility\perk::_id_6FC2("specialty_pistoldeath");
  self._id_8DD9 = 1;
  self._id_441E = spawn("script_model", self gettagorigin("j_helmet"));
  self._id_441E setModel("ks_death_switch_mp");
  self._id_441E.angles = self.angles;
  self._id_441E linkto(self, "j_helmet", (0, 0, 0), (0, 0, 0));
  thread _id_4416();
}

_id_4416() {
  self endon("disconnect");
  self endon("deathSwitch_release");

  for(;;) {
    self._id_441E setscriptablepartstate("blinking_light", "on", 0);
    wait 0.5;
    self._id_441E setscriptablepartstate("blinking_light", "off", 0);
  }
}

_id_44DE() {
  self endon("death");

  for(;;) {
    waitframe();
  }
}

_id_441C() {
  var_0 = "s4_me_fists_mp_ls";
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0, undefined, undefined, 1);
  thread _id_07E8::_id_EC3A(var_0);
  self._id_905F = "laststand_killstreak";
  scripts\mp\playeractions::_id_1596(self._id_905F, 0);
  thread _id_4417(3);
  thread _id_441D(3);
}

_id_4417(var_0) {
  self endon("payload_release");
  self endon("disconnect");
  level endon("game_ended");
  var_1 = 1;
  var_2 = scripts\mp\utility\weapon::_id_0C48("death_switch_blast_mp", self gettagorigin("j_mainroot"), (0, 0, 0), var_0, 1);
  var_2 linkto(self);
  thread _id_4418(var_1, var_2);
  var_3 = 1;

  while(var_0 > 0) {
    self iprintlnbold("Death Switch Countdown: " + var_0);
    var_0 = var_0 - var_3;
    playsoundatpos(self.origin, "death_switch_beep");
    wait(var_3);
    var_3 = var_3 - 0.2;

    if(var_3 < 0.05) {
      var_3 = 0.05;
    }
  }

  _id_4419(var_1, var_2);
}

_id_4418(var_0, var_1) {
  self endon("payload_release");
  self endon("disconnect");
  level endon("game_ended");
  self notify("watch_switch_on_death");
  self endon("watch_switch_on_death");
  self waittill("death");
  _id_4419(var_0, var_1);
}

_id_4419(var_0, var_1) {
  if(isDefined(var_1)) {
    var_1 delete();
  }

  switch (var_0) {
    case 0:
      thread _id_441B();
      break;
    case 1:
      thread _id_441A();
      break;
    default:
      break;
  }

  self._id_8DD9 = undefined;
  scripts\mp\utility\perk::removeperk("specialty_pistoldeath");
  self notify("payload_release");
}

_id_441B() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("deathSwitch_release");
  self._id_441E setscriptablepartstate("blinking_light", "off", 0);
  self._id_441E setscriptablepartstate("explode", "on", 0);
  self._id_441E setentityowner(self);
  self._id_441E thread scripts\mp\utility\script::_id_46C7(5);
}

_id_441A() {
  self endon("disconnect");
  level endon("game_ended");
  self notify("deathSwitch_release");
  var_0 = self.origin + (0, 0, 20000);
  var_1 = self.origin;
  var_2 = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon("death_switch_proj_mp"), var_0, var_1, self);
  self._id_441E setscriptablepartstate("blinking_light", "off", 0);
  self._id_441E thread scripts\mp\utility\script::_id_46C7(5);
}

_id_441D(var_0) {
  level endon("game_ended");
  level endon("death_or_disconnect");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  _id_0A8B::_id_0D8A();
}