/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\init.gsc
**************************************/

_id_2098(var_0) {
  self.weaponinfo[var_0] = spawnStruct();
  self.weaponinfo[var_0]._id_2099 = "none";
  self.weaponinfo[var_0]._id_209A = 1;

  if(getweaponclipmodel(var_0) != "") {
    self.weaponinfo[var_0]._id_209B = 1;
  } else {
    self.weaponinfo[var_0]._id_209B = 0;
  }
}

_id_209C(var_0) {
  return isDefined(self.weaponinfo[var_0]);
}

_id_209D() {
  anim._id_0CAD = 55;
  anim._id_209E = 10;
  anim._id_209F = 4096;
  anim._id_20A0 = 45;
  anim._id_20A1 = 20;
  anim._id_0D62 = 25;
  anim._id_0D63 = anim._id_209F;
  anim._id_0D64 = anim._id_20A0;
  anim._id_0D65 = 30;
  anim._id_0CC0 = 65;
  anim._id_0CC1 = 65;
}

_id_20A2() {
  if(animscripts\utility::_id_0CEA(self.secondaryweapon)) {
    return 1;

  }
  if(weaponclass(self.primaryweapon) == "rocketlauncher") {
    return 1;

  }
  return 0;
}

#using_animtree("generic_human");

main() {
  self.a = spawnStruct();
  self.a._id_0CDF = 0;
  self.primaryweapon = self.weapon;
  _id_20C5();

  if(self.primaryweapon == "") {
    self.primaryweapon = "none";

  }
  if(self.secondaryweapon == "") {
    self.secondaryweapon = "none";

  }
  if(self.sidearm == "") {
    self.sidearm = "none";

  }
  _id_2098(self.primaryweapon);
  _id_2098(self.secondaryweapon);
  _id_2098(self.sidearm);
  self setdefaultaimlimits();
  self.a._id_0EE4["left"] = "none";
  self.a._id_0EE4["right"] = "none";
  self.a._id_0EE4["chest"] = "none";
  self.a._id_0EE4["back"] = "none";
  self.a._id_20A4["left"] = "none";
  self.a._id_20A4["right"] = "none";
  self.a._id_20A4["chest"] = "none";
  self.a._id_20A4["back"] = "none";
  self._id_1005 = self.weapon;
  self._id_0C56 = % root;
  thread begingrenadetracking();
  var_0 = animscripts\utility::_id_0BB6();
  self.a._id_20A5 = var_0;

  if(var_0) {
    thread animscripts\shared::_id_20A6();

  }
  self.a.rockets = 3;
  self.a._id_0CD2 = 1;
  self.a._id_0D26 = "stand";
  self.a._id_113C = "stand";
  self.a._id_0D2B = "stop";
  self.a._id_0A98 = "stop";
  self.a._id_0D19 = "none";
  self.a._id_20A7 = "none";
  self.a._id_20A8 = -1;
  self.dropweapon = 1;
  self._id_1139 = 750;
  animscripts\shared::_id_0C9B(self.primaryweapon, "right");

  if(animscripts\utility::_id_0CEA(self.secondaryweapon)) {
    animscripts\shared::_id_0C9B(self.secondaryweapon, "back");

  }
  self.a._id_114D = 0;
  self.a._id_20A9 = gettime();
  self.a._id_20AA = gettime();
  self.a._id_20AB = 0;
  self.a._id_0D31 = !self isbadguy();
  self.a._id_20AC = 0;
  self.a._id_0B29 = 0;
  self.a._id_0AA7 = 0;
  self.a._id_113A = 0;
  self.a._id_0FDD = 0.8;

  if(self.team != "allies") {
    self._id_0CDE = 1;

  }
  self.a._id_20AD = undefined;
  self.a.stance = "stand";
  self._id_0FBA = animscripts\utility::_id_10AF;
  self._id_0BA3 = 0;
  self._id_11BE = 0;
  thread _id_20C1();
  self._id_20AF = 1;
  self.a._id_19B8 = 0;
  self.a._id_0D55 = 0;
  self.a._id_19B8 = 0;
  self.a._id_20B0 = 0;
  self.a._id_0D11 = 0;
  self._id_20B1 = 1;
  self._id_0AAB = 0;
  self._id_20B2 = 0;
  self._id_20B3 = 1;
  self._id_20B4 = 1;
  self._id_110F = 55;
  self.a._id_0D14 = 0;

  if(!isDefined(self._id_20B5)) {
    self._id_20B5 = 0;

  }
  _id_20BD();
  animscripts\weaponlist::_id_0CD0();
  self._id_0A7F = 0;
  self._id_0A80 = 0;
  self._id_0A9D = 0;
  self._id_0A9E = 0;

  if(self.team == "allies") {
    self._id_0CFB = 0.5;
  } else {
    self._id_0CFB = 0.0;

  }
  if(self.team == "allies") {
    self._id_20B6 = 0;
  } else {
    self._id_20B6 = 256;

  }
  self._id_20B7 = 8000;
  self._id_10BA = 0;
  animscripts\animset::_id_0CA0();
  self.defaultexception = [];
  self.defaultexception["corner"] = 1;
  self.defaultexception["cover_crouch"] = 1;
  self.defaultexception["stop"] = 1;
  self.defaultexception["stop_immediate"] = 1;
  self.defaultexception["move"] = 1;
  self.defaultexception["exposed"] = 1;
  self.defaultexception["corner_normal"] = 1;
  var_1 = getarraykeys(self.defaultexception);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    common_scripts\utility::clear_exception(var_1[var_2]);

  }
  self._id_1160 = 0;
  thread _id_20BB();
  self._id_20B8 = 0;
  thread animscripts\combat_utility::monitorflash();
  thread ondeath();
}

_id_20BA(var_0) {
  var_1[0] = "m4_grenadier";
  var_1[1] = "m4_grunt";
  var_1[2] = "m4_silencer";
  var_1[3] = "m4m203";

  if(!isDefined(var_0)) {
    return 0;

  }
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(issubstr(var_0, var_1[var_2])) {
      return 1;
    }
  }

  return 0;
}

_id_20BB() {
  self endon("death");

  if(!isDefined(level._id_0A82)) {
    level waittill("loadout complete");

  }
  maps\_names::_id_12A4();
  thread animscripts\squadmanager::_id_0A7E();
}

_id_20BC() {
  for(;;) {
    if(self isstanceallowed("stand")) {
      var_0[0] = "stand allowed";
      var_1[0] = (0, 1, 0);
    } else {
      var_0[0] = "stand not allowed";
      var_1[0] = (1, 0, 0);
    }

    if(self isstanceallowed("crouch")) {
      var_0[1] = "crouch allowed";
      var_1[1] = (0, 1, 0);
    } else {
      var_0[1] = "crouch not allowed";
      var_1[1] = (1, 0, 0);
    }

    if(self isstanceallowed("prone")) {
      var_0[2] = "prone allowed";
      var_1[2] = (0, 1, 0);
    } else {
      var_0[2] = "prone not allowed";
      var_1[2] = (1, 0, 0);
    }

    var_2 = self getshootatpos() + (0, 0, 30);
    var_3 = (0, 0, -10);

    for(var_4 = 0; var_4 < var_0.size; var_4++) {
      var_5 = (var_2[0] + var_3[0] * var_4, var_2[1] + var_3[1] * var_4, var_2[2] + var_3[2] * var_4);

    }
    wait 0.05;
  }
}

_id_20BD() {
  if(!isDefined(self._id_10F7) || !isDefined(self._id_0FC6)) {
    _id_20BE();
  }
}

_id_20BE() {
  self._id_10F7 = 0.9 + randomfloat(0.2);
  self._id_1165 = 0.9 + randomfloat(0.2);
  self._id_0FC6 = 1;
  self._id_0FE0 = 1.35;
}

_id_20BF(var_0, var_1, var_2, var_3) {
  anim waittill("new exceptions");
}

_id_20C0(var_0, var_1, var_2, var_3) {}

_id_20C1() {
  self endon("death");

  if(1) {
    return;
  }
  for(;;) {
    self waittill("enemy");

    if(!isalive(self.enemy)) {
      continue;
    }
    while(isplayer(self.enemy)) {
      if(animscripts\utility::_id_0F8C()) {
        level._id_20C2 = gettime();

      }
      wait 2;
    }
  }
}

_id_20C3() {
  level._id_20C4[0] = -36.8552;
  level._id_20C4[1] = -27.0095;
  level._id_20C4[2] = -15.5981;
  level._id_20C4[3] = -4.37769;
  level._id_20C4[4] = 17.7776;
  level._id_20C4[5] = 59.8499;
  level._id_20C4[6] = 104.808;
  level._id_20C4[7] = 152.325;
  level._id_20C4[8] = 201.052;
  level._id_20C4[9] = 250.244;
  level._id_20C4[10] = 298.971;
  level._id_20C4[11] = 330.681;
}

_id_20C5() {
  if(isDefined(anim._id_20C6)) {
    return;
  }
  anim._id_20C6 = 1;
  animscripts\animset::_id_0C64();
  anim._id_0C3B = 0;
  maps\_load::_id_1F99();
  level.player._id_20C7 = 0;
  level._id_20C8 = randomint(3);
  level._id_20C2 = 100;
  anim.exception = ::_id_20C0;
  _id_20DF();
  setdvar("scr_expDeathMayMoveCheck", "on");
  maps\_names::_id_1299();
  anim._id_20C9 = 0;
  animscripts\init_move_transitions::_id_2087();
  animscripts\reactions::_id_0F1C();
  anim._id_20CA = 10000;
  anim._id_20CB = 6000;
  _id_20E2();
  _id_20E8();
  animscripts\utility::_id_20CC("none");

  if(!isDefined(anim._id_20CD)) {
    anim._id_20CF = animscripts\notetracks::_id_20CE;
    anim._id_20CD = animscripts\notetracks::_id_20D0;
  }

  if(!isDefined(anim._id_20D1)) {
    anim._id_20D1 = [];

  }
  if(!isDefined(anim._id_20D2)) {
    anim._id_20D2 = [];

  }
  anim._id_20D4 = animscripts\utility::_id_20D3;
  anim._id_20D6["scripted"] = animscripts\notetracks::_id_20D5;
  anim._id_20D6["cover_right"] = animscripts\notetracks::_id_20D7;
  anim._id_20D6["cover_left"] = animscripts\notetracks::_id_20D7;
  anim._id_20D6["cover_crouch"] = animscripts\notetracks::_id_20D7;
  anim._id_20D6["cover_stand"] = animscripts\notetracks::_id_20D7;
  anim._id_20D6["move"] = animscripts\notetracks::_id_20D7;
  animscripts\notetracks::_id_1E73();

  if(!isDefined(level.flag)) {
    common_scripts\utility::init_flags();

  }
  maps\_gameskill::_id_1E8E();
  level._id_20D8 = undefined;
  animscripts\setposemovement::_id_20D9();
  animscripts\face::_id_0C55();
  anim._id_20DA = animscripts\utility::_id_0C6D(1, 2, 2, 2, 3, 3, 3, 3, 4, 4, 5);
  anim._id_20DB = animscripts\utility::_id_0C6D(2, 3, 3, 3, 4, 4, 4, 5, 5);
  anim._id_20DC = animscripts\utility::_id_0C6D(1, 2, 2, 3, 3, 4, 4, 4, 4, 5, 5, 5);
  anim._id_1ED7 = [];
  anim._id_20DD = 0;
  anim.player = getEntArray("player", "classname")[0];
  _id_20E0();
  _id_20C3();
  animscripts\flashed::_id_208E();
  animscripts\cqb::_id_107A();
  _id_20E1();
  _id_209D();
  anim.lastcarexplosiontime = -100000;
  _id_20F5();
  level.player thread animscripts\combat_utility::_id_20DE();
  thread _id_20F0();
}

_id_20DF() {}

_id_20E0() {
  animscripts\squadmanager::_id_0A5E();
  anim.player thread animscripts\squadmanager::_id_0A78();
  animscripts\battlechatter::_id_0B6B();
  anim.player thread animscripts\battlechatter_ai::_id_0AA9();
  anim thread animscripts\battlechatter::_id_0B9C();
}

_id_20E1() {
  anim._id_0D43 = randomintrange(0, 15);
  anim._id_0D6B = randomintrange(0, 10);
  anim._id_0D44 = gettime() + randomintrange(0, 20000);
  anim._id_0D42 = gettime() + randomintrange(0, 10000);
  anim._id_0D6C = gettime() + randomintrange(0, 15000);
}

_id_20E2() {
  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    var_1 = level.players[var_0];
    var_1._id_20E3["fraggrenade"] = randomintrange(1000, 20000);
    var_1._id_20E3["flash_grenade"] = randomintrange(1000, 20000);
    var_1._id_20E3["double_grenade"] = randomintrange(1000, 60000);
    var_1._id_20E4 = 0;
    var_1._id_20E5 = -1000000;
    var_1._id_20E6 = -1000000;
    var_1 thread _id_20F1();
  }

  anim._id_20E3["AI_fraggrenade"] = randomintrange(0, 20000);
  anim._id_20E3["AI_flash_grenade"] = randomintrange(0, 20000);
  anim._id_20E3["AI_smoke_grenade_american"] = randomintrange(0, 20000);
  animscripts\combat_utility::_id_20E7();
}

_id_20E8() {
  level._id_20E9 = [];
  level._id_20E9["axis"] = 0;
  level._id_20E9["allies"] = 0;
  level._id_20E9["team3"] = 0;
  level._id_20E9["neutral"] = 0;
  level._id_20EA = [];
  level._id_20EA["axis"] = (0, 0, 0);
  level._id_20EA["allies"] = (0, 0, 0);
  level._id_20EA["team3"] = (0, 0, 0);
  level._id_20EA["neutral"] = (0, 0, 0);
  level._id_20EB = [];
  level._id_20EB["axis"] = (0, 0, 0);
  level._id_20EB["allies"] = (0, 0, 0);
  level._id_20EB["team3"] = (0, 0, 0);
  level._id_20EB["neutral"] = (0, 0, 0);
  level._id_20EC = [];
  level._id_20ED = [];
  level._id_20ED["axis"] = 0;
  level._id_20ED["allies"] = 0;
  level._id_20ED["team3"] = 0;
  level._id_20ED["neutral"] = 0;
  level._id_20EE = 30000;
  level._id_20EF = 3;
}

_id_20F0() {
  var_0 = 0;
  var_1 = 3;

  for(;;) {
    var_2 = getaiarray();

    if(var_2.size == 0) {
      wait 0.05;
      var_0 = 0;
      continue;
    }

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      if(!isDefined(var_2[var_3])) {
        continue;
      }
      var_2[var_3] notify("do_slow_things");
      var_0++;

      if(var_0 == var_1) {
        wait 0.05;
        var_0 = 0;
      }
    }
  }
}

_id_20F1() {
  waittillframeend;

  if(isDefined(self._id_20F2._id_20F3)) {
    var_0 = int(self._id_20F2._id_20F3 * 0.7);

    if(var_0 < 1) {
      var_0 = 1;

    }
    self._id_20E3["fraggrenade"] = randomintrange(0, var_0);
    self._id_20E3["flash_grenade"] = randomintrange(0, var_0);
  }

  if(isDefined(self._id_20F2._id_20F4)) {
    var_0 = int(self._id_20F2._id_20F4);
    var_1 = int(var_0 / 2);

    if(var_0 <= var_1) {
      var_0 = var_1 + 1;

    }
    self._id_20E3["double_grenade"] = randomintrange(var_1, var_0);
  }
}

begingrenadetracking() {
  self endon("death");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);
    var_0 thread maps\_utility::grenade_earthquake();
  }
}

_id_20F5() {
  anim._id_20F6 = 60;
  anim._id_20F7 = [];

  for(var_0 = 0; var_0 < anim._id_20F6; var_0++) {
    anim._id_20F7[var_0] = var_0;

  }
  for(var_0 = 0; var_0 < anim._id_20F6; var_0++) {
    var_1 = randomint(anim._id_20F6);
    var_2 = anim._id_20F7[var_0];
    anim._id_20F7[var_0] = anim._id_20F7[var_1];
    anim._id_20F7[var_1] = var_2;
  }
}

ondeath() {
  if(isDefined(level._id_20F9)) {
    return;
  }
  self waittill("death");

  if(!isDefined(self)) {
    if(isDefined(self.a._id_20FA)) {
      self.a._id_20FA delete();
    }
  }
}