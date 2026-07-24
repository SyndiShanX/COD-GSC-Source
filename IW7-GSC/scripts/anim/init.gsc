/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\init.gsc
**************************************/

_id_98E1(var_0) {
  self.weaponinfo[var_0] = spawnStruct();
  self.weaponinfo[var_0].position = "none";
  self.weaponinfo[var_0]._id_8BDE = 1;

  if(getweaponclipmodel(var_0) != "") {
    self.weaponinfo[var_0]._id_13053 = 1;
  } else {
    self.weaponinfo[var_0]._id_13053 = 0;
  }
}

_id_A000(var_0) {
  return isDefined(self.weaponinfo[var_0]);
}

_id_F724() {
  anim.covercrouchleanpitch = 55;
  anim._id_1A52 = 10;
  anim._id_1A50 = 4096;
  anim._id_1A51 = 45;
  anim._id_1A44 = 20;
  anim._id_C88B = 25;
  anim._id_C889 = anim._id_1A50;
  anim._id_C88A = anim._id_1A51;
  anim._id_C87D = 30;
  anim._id_B480 = 65;
  anim._id_B47F = 65;
}

_id_68BD() {
  if(scripts\anim\utility_common::isshotgun(self.secondaryweapon)) {
    return 1;
  }

  if(weaponclass(self.primaryweapon) == "rocketlauncher") {
    return 1;
  }

  return 0;
}

_id_FAFB() {
  self endon("death");
  scripts\engine\utility::flag_wait("load_finished");

  if(isDefined(anim._id_13CC8) && isDefined(anim._id_13CC8[self.unittype])) {
    self[[anim._id_13CC8[self.unittype]]]();
  } else {
    _id_5031();
  }
}

#using_animtree("generic_human");

main() {
  self.a = spawnStruct();
  self.a.laseron = 0;
  self.primaryweapon = self.weapon;
  _id_6DE9();

  if(!scripts\engine\utility::flag_exist("load_finished")) {
    scripts\engine\utility::flag_init("load_finished");
  }

  if(self.primaryweapon == "") {
    self.primaryweapon = "none";
  }

  if(self.secondaryweapon == "") {
    self.secondaryweapon = "none";
  }

  if(self._id_101B4 == "") {
    self._id_101B4 = "none";
  }

  self._id_E6E6 = % root;
  self.a._id_2C13 = % body;
  thread begingrenadetracking();
  self.a.pose = "stand";
  self.a._id_85E2 = "stand";
  self.a.movement = "stop";
  self.a.state = "stop";
  self.a._id_10930 = "none";
  self.a._id_870D = "none";
  self.a._id_D8BD = -1;
  self.dropweapon = 1;
  self._id_B781 = 750;
  thread _id_FAFB();
  self.a.needstorechamber = 0;
  self.a.combatendtime = gettime();
  self.a.lastenemytime = gettime();
  self.a._id_112CB = 0;
  self.a.disablelongdeath = !self isbadguy();
  self.a._id_AFFF = 0;
  self.a._id_C888 = 0;
  self.a._id_A9ED = 0;
  self.a.nextgrenadetrytime = 0;
  self.a.reacttobulletchance = 0.8;
  self.a._id_D707 = undefined;
  self.a._id_10B53 = "stand";
  self._id_3EF3 = scripts\anim\utility::_id_3EF2;
  self._id_117C = 0;
  self._id_1300 = 0;
  thread _id_6568();
  self._id_2894 = 1;
  self.a._id_B8D6 = 0;
  self.a.nodeath = 0;
  self.a._id_B8D6 = 0;
  self.a._id_B8D8 = 0;
  self.a._id_5605 = 0;
  self._id_154E = 1;
  self._id_3D4B = 0;
  self._id_101E7 = 0;
  self._id_101E6 = 1;
  self._id_BE8B = 1;
  self._id_504E = 55;
  scripts\sp\utility::_id_F6FE("asm");
  self.a._id_BFAF = 0;

  if(!isDefined(self.script_forcegrenade)) {
    self.script_forcegrenade = 0;
  }

  _id_FAF2();
  self.lastenemysighttime = 0;
  self._id_440E = 0;
  self._id_112C8 = 0;
  self._id_112CA = 0;

  if(self.team == "allies") {
    self.suppressionthreshold = 0.5;
  } else {
    self.suppressionthreshold = 0.0;
  }

  if(self.team == "allies") {
    self._id_DCAF = 0;
  } else {
    self._id_DCAF = 256;
  }

  self.ammocheatinterval = 8000;
  self.ammocheattime = 0;
  scripts\anim\animset::_id_FA33();
  self.exception = [];
  self.exception["corner"] = 1;
  self.exception["cover_crouch"] = 1;
  self.exception["stop"] = 1;
  self.exception["stop_immediate"] = 1;
  self.exception["move"] = 1;
  self.exception["exposed"] = 1;
  self.exception["corner_normal"] = 1;
  var_0 = getarraykeys(self.exception);

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    scripts\engine\utility::clear_exception(var_0[var_1]);
  }

  self._id_DD23 = 0;
  self._id_FFD3 = 0;

  if(!isDefined(level._id_55FE)) {
    thread scripts\anim\combat_utility::_id_B9D9();
  }

  thread ondeath_clearscriptedanim();

  if(getdvarint("ai_iw7", 0) == 1 && !getdvarint("r_reflectionProbeGenerate")) {
    self _meth_8250(0);
    scripts\aitypes\bt_util::bt_init();
    _id_0A1E::_id_234D(self._id_1FA9, self._id_1FA8);
    thread _id_19F7();
    self._id_1FA9 = undefined;
    self._id_1FA8 = undefined;
  }

  thread _id_F7AC();
}

_id_1929() {
  return self._blackboard._id_444A;
}

_id_100B4(var_0, var_1) {
  if(!var_0 || self.unittype != "soldier" && self.unittype != "c6") {
    return 1;
  }

  var_2 = int(gettime() / 50) % 2;
  return var_1 == var_2;
}

_id_1001A() {
  return isDefined(self.bt._id_72EB) && self.bt._id_72EB;
}

_id_19F7() {
  self endon("terminate_ai_threads");
  self endon("entitydeleted");
  thread _id_0A1E::_id_51B8();
  thread _id_0A1E::traversehandler();
  var_0 = 1;
  var_1 = self getentitynumber() % 2;

  for(;;) {
    var_2 = 0;

    if(_id_1001A()) {
      scripts\aitypes\bt_util::bt_tick();
      var_2 = 1;
      self.bt._id_72EB = undefined;
    } else if(var_0) {
      if(!_id_1929()) {
        scripts\aitypes\bt_util::bt_tick();
        var_2 = 1;
      }
    }

    if(var_2) {
      scripts\asm\asm::_id_2314();
    }

    if(isDefined(self.asm._id_10E23)) {
      scripts\asm\asm::asm_clearevents(self.asm._id_10E23);
      self.asm._id_10E23 = undefined;
    }

    scripts\asm\asm::_id_2389();
    wait 0.05;

    if(!isDefined(self)) {
      break;
    }

    var_0 = _id_100B4(var_2, var_1);
  }
}

_id_13CC7(var_0) {
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

_id_F7AC() {
  self endon("death");

  if(!isDefined(level._id_AE64)) {
    level waittill("loadout complete");
  }

  scripts\sp\names::_id_7B05();
  thread scripts\anim\squadmanager::_id_185C();
}

pollallowedstancesthread() {
  for(;;) {
    if(self _meth_81BF("stand")) {
      var_0[0] = "stand allowed";
      var_1[0] = (0, 1, 0);
    } else {
      var_0[0] = "stand not allowed";
      var_1[0] = (1, 0, 0);
    }

    if(self _meth_81BF("crouch")) {
      var_0[1] = "crouch allowed";
      var_1[1] = (0, 1, 0);
    } else {
      var_0[1] = "crouch not allowed";
      var_1[1] = (1, 0, 0);
    }

    if(self _meth_81BF("prone")) {
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

_id_FAF2() {
  if(!isDefined(self.animplaybackrate) || !isDefined(self.moveplaybackrate)) {
    _id_F2B0();
  }
}

_id_F2B0() {
  self.animplaybackrate = 0.97 + randomfloat(0.13);
  self._id_BD22 = 0.97 + randomfloat(0.13);
  self.moveplaybackrate = self._id_BD22;
  self._id_101BB = 1.35;
}

_id_94AC(var_0, var_1, var_2, var_3) {
  anim waittill("new exceptions");
}

empty(var_0, var_1, var_2, var_3) {}

_id_6568() {
  self endon("death");

  if(1) {
    return;
  }
  for(;;) {
    self waittill("enemy");

    if(!isalive(self.enemy)) {
      continue;
    }
    while(isPlayer(self.enemy)) {
      if(scripts\anim\utility::_id_8BED()) {
        level._id_A9D0 = gettime();
      }

      wait 2;
    }
  }
}

_id_98E4() {
  level._id_13D57[0] = -36.8552;
  level._id_13D57[1] = -27.0095;
  level._id_13D57[2] = -15.5981;
  level._id_13D57[3] = -4.37769;
  level._id_13D57[4] = 17.7776;
  level._id_13D57[5] = 59.8499;
  level._id_13D57[6] = 104.808;
  level._id_13D57[7] = 152.325;
  level._id_13D57[8] = 201.052;
  level._id_13D57[9] = 250.244;
  level._id_13D57[10] = 298.971;
  level._id_13D57[11] = 330.681;
}

_id_6DE9() {
  if(getdvarint("ai_iw7", 0) == 1) {
    _id_6DEA();
    return;
  }

  if(isDefined(anim._id_C122)) {
    return;
  }
  anim._id_C122 = 1;
  scripts\anim\animset::_id_94FD();
  anim._id_13086 = 0;
  _id_0B5F::_id_965A();
  level._id_BF83 = randomint(3);
  level._id_A9D0 = 100;
  anim.defaultexception = ::empty;
  _id_97F8();
  setdvarifuninitialized("scr_expDeathMayMoveCheck", "on");
  scripts\sp\names::_id_F9E6();
  anim._id_1FB5 = 0;
  scripts\anim\init_move_transitions::_id_98A0();
  anim.combatidlepreventoverlappingplayer = 10000;
  anim.combatmemorytimeconst = 6000;
  _id_9811();
  _id_97C0();

  if(!isDefined(anim.optionalstepeffectfunction)) {
    anim.optionalstepeffectsmallfunction = scripts\anim\notetracks::_id_D480;
    anim.optionalstepeffectfunction = scripts\anim\notetracks::playfootstepeffect;
  }

  if(!isDefined(anim.optionalstepeffects)) {
    anim.optionalstepeffects = [];
  }

  if(!isDefined(anim.optionalstepeffectssmall)) {
    anim.optionalstepeffectssmall = [];
  }

  if(!isDefined(anim.shootenemywrapper_func)) {
    anim.shootenemywrapper_func = scripts\anim\utility::_id_FE9D;
  }

  if(!isDefined(anim._id_FED3)) {
    anim._id_FED3 = scripts\anim\utility::_id_FED2;
  }

  anim.fire_notetrack_functions["scripted"] = ::scripts\anim\notetracks::fire_straight;
  anim.fire_notetrack_functions["cover_right"] = ::scripts\anim\notetracks::shootnotetrack;
  anim.fire_notetrack_functions["cover_left"] = ::scripts\anim\notetracks::shootnotetrack;
  anim.fire_notetrack_functions["cover_crouch"] = ::scripts\anim\notetracks::shootnotetrack;
  anim.fire_notetrack_functions["cover_stand"] = ::scripts\anim\notetracks::shootnotetrack;
  anim.fire_notetrack_functions["move"] = ::scripts\anim\notetracks::shootnotetrack;
  scripts\anim\notetracks::registernotetracks();

  if(!isDefined(level.flag)) {
    scripts\common\flags::init_flags();
  }

  scripts\sp\gameskill::_id_F848();
  level._id_C870 = undefined;
  scripts\anim\setposemovement::_id_98BF();
  scripts\anim\face::initlevelface();
  anim._id_32BF = scripts\anim\utility::_id_2274(1, 2, 2, 2, 3, 3, 3, 3, 4, 4, 5);
  anim._id_6B93 = scripts\anim\utility::_id_2274(2, 3, 3, 3, 4, 4, 4, 5, 5);
  anim._id_F217 = scripts\anim\utility::_id_2274(1, 2, 2, 3, 3, 4, 4, 4, 4, 5, 5, 5);
  anim._id_2759 = [];
  anim._id_2755 = 0;
  anim.player = getEntArray("player", "classname")[0];
  _id_97DA();
  _id_98E4();
  scripts\anim\cqb::_id_FA9F();
  _id_97F5();
  _id_F724();
  anim._id_A955 = -100000;
  anim._id_BF91 = 10000;
  _id_FAE3();
  level.player thread scripts\anim\combat_utility::_id_13B22();
  thread _id_1B08();
}

_id_97F8() {}

_id_97DA() {
  if(!isDefined(anim.player.team)) {
    anim.player.team = "allies";
  }

  scripts\anim\squadmanager::_id_9763();
  anim.player thread scripts\anim\squadmanager::_id_1811();
  anim.player thread scripts\anim\squadmanager::_id_D362();
  scripts\anim\battlechatter::_id_9542();
  anim.player thread scripts\anim\battlechatter_ai::_id_185D();
  _id_0E4E::_id_96F1();
  anim thread scripts\anim\battlechatter::_id_29C9();
}

_id_97F5() {
  anim._id_C222 = randomintrange(0, 15);
  anim._id_C221 = randomintrange(0, 10);
  anim._id_BF77 = gettime() + randomintrange(0, 20000);
  anim._id_BF78 = gettime() + randomintrange(0, 10000);
  anim._id_BF76 = gettime() + randomintrange(0, 15000);
}

_id_9811() {
  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    var_1 = level.players[var_0];
    var_1.grenadetimers["fraggrenade"] = randomintrange(1000, 20000);
    var_1.grenadetimers["frag"] = randomintrange(1000, 20000);
    var_1.grenadetimers["frag_main"] = randomintrange(1000, 20000);
    var_1.grenadetimers["frag_vr"] = randomintrange(1000, 20000);
    var_1.grenadetimers["flash_grenade"] = randomintrange(1000, 20000);
    var_1.grenadetimers["emp"] = randomintrange(1000, 20000);
    var_1.grenadetimers["antigrav"] = randomintrange(1000, 20000);
    var_1.grenadetimers["seeker"] = randomintrange(1000, 20000);
    var_1.grenadetimers["c8_grenade"] = randomintrange(1000, 10000);
    var_1.grenadetimers["double_grenade"] = randomintrange(1000, 60000);
    var_1.numgrenadesinprogresstowardsplayer = 0;
    var_1._id_A990 = -1000000;
    var_1.lastfraggrenadetoplayerstart = -1000000;
    var_1 thread _id_F7B3();
  }

  anim.grenadetimers["AI_fraggrenade"] = randomintrange(0, 20000);
  anim.grenadetimers["AI_frag"] = randomintrange(0, 20000);
  anim.grenadetimers["AI_seeker"] = randomintrange(0, 20000);
  anim.grenadetimers["AI_frag_main"] = randomintrange(0, 20000);
  anim.grenadetimers["AI_frag_vr"] = randomintrange(0, 20000);
  anim.grenadetimers["AI_flash_grenade"] = randomintrange(0, 20000);
  anim.grenadetimers["AI_smoke_grenade_american"] = randomintrange(0, 20000);
  anim.grenadetimers["AI_emp"] = randomintrange(0, 20000);
  anim.grenadetimers["AI_antigrav"] = randomintrange(0, 20000);
  anim.grenadetimers["AI_c8_grenade"] = randomintrange(0, 10000);
  scripts\anim\combat_utility::_id_9812();
}

_id_97C0() {
  level._id_A936 = [];
  level._id_A936["axis"] = 0;
  level._id_A936["allies"] = 0;
  level._id_A936["team3"] = 0;
  level._id_A936["neutral"] = 0;
  level._id_A934 = [];
  level._id_A934["axis"] = (0, 0, 0);
  level._id_A934["allies"] = (0, 0, 0);
  level._id_A934["team3"] = (0, 0, 0);
  level._id_A934["neutral"] = (0, 0, 0);
  level._id_A935 = [];
  level._id_A935["axis"] = (0, 0, 0);
  level._id_A935["allies"] = (0, 0, 0);
  level._id_A935["team3"] = (0, 0, 0);
  level._id_A935["neutral"] = (0, 0, 0);
  level._id_A933 = [];
  level._id_18D5 = [];
  level._id_18D5["axis"] = 0;
  level._id_18D5["allies"] = 0;
  level._id_18D5["team3"] = 0;
  level._id_18D5["neutral"] = 0;
  level._id_18D7 = 30000;
  level._id_18D6 = 3;
}

_id_9897() {
  anim._id_B5F8["c6"] = 0;
  anim._id_B5F5["c6"] = 9000;
  anim._id_B5F7["c6"] = 0;
  anim._id_B5F6["c6"] = 15000;
  anim._id_B5F8["seeker"] = 0;
  anim._id_B5F5["seeker"] = 9000;
  anim._id_B5F7["seeker"] = 0;
  anim._id_B5F6["seeker"] = 15000;
}

_id_1B08() {
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

_id_F7B3() {
  waittillframeend;

  if(isDefined(self.gs._id_D397)) {
    var_0 = int(self.gs._id_D397 * 0.7);

    if(var_0 < 1) {
      var_0 = 1;
    }

    self.grenadetimers["frag"] = randomintrange(0, var_0);
    self.grenadetimers["flash_grenade"] = randomintrange(0, var_0);
    self.grenadetimers["seeker"] = randomintrange(0, var_0);
  }

  if(isDefined(self.gs._id_D382)) {
    var_0 = int(self.gs._id_D382);
    var_1 = int(var_0 / 2);

    if(var_0 <= var_1) {
      var_0 = var_1 + 1;
    }

    self.grenadetimers["double_grenade"] = randomintrange(var_1, var_0);
  }
}

begingrenadetracking() {
  if(isDefined(level._id_55F1)) {
    return;
  }
  self endon("death");

  for(;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(isDefined(var_0) && scripts\engine\utility::is_true(var_0._id_8589)) {
      continue;
    }
    if(isDefined(level.func["ai_grenade_thrown"])) {
      level thread[[level.func["ai_grenade_thrown"]]](var_0);
    }

    switch (var_1) {
      case "frag":
        thread _id_0B1D::_id_734F(var_0);
        break;
      case "emp":
        thread _id_0E25::_id_615B(var_0);
        break;
      case "seeker":
        thread _id_0E26::_id_F135(var_0);
        break;
      case "antigrav":
        thread _id_0E21::_id_2013(var_0);
        break;
      default:
        var_0 thread scripts\sp\utility::grenade_earthquake();
        break;
    }
  }
}

_id_FAE3() {
  anim._id_DCB3 = 60;
  anim._id_DCB2 = [];

  for(var_0 = 0; var_0 < anim._id_DCB3; var_0++) {
    anim._id_DCB2[var_0] = var_0;
  }

  for(var_0 = 0; var_0 < anim._id_DCB3; var_0++) {
    var_1 = randomint(anim._id_DCB3);
    var_2 = anim._id_DCB2[var_0];
    anim._id_DCB2[var_0] = anim._id_DCB2[var_1];
    anim._id_DCB2[var_1] = var_2;
  }
}

ondeath_clearscriptedanim() {
  if(isDefined(level._id_5613)) {
    return;
  }
  self waittill("death");

  if(!isDefined(self)) {
    if(isDefined(self.a.usingworldspacehitmarkers)) {
      self.a.usingworldspacehitmarkers delete();
    }
  }
}

_id_6DEA() {
  if(isDefined(anim._id_C122)) {
    return;
  }
  anim._id_C122 = 1;
  anim._id_13086 = 0;
  _id_0B5F::_id_965A();
  level._id_BF83 = randomint(3);
  level._id_A9D0 = 100;
  anim.defaultexception = ::empty;

  if(!isDefined(level._id_7649)) {
    level._id_7649 = [];
  }

  _id_97F8();
  scripts\sp\names::_id_F9E6();
  anim._id_1FB5 = 0;
  anim.combatidlepreventoverlappingplayer = 10000;
  anim.combatmemorytimeconst = 6000;
  anim._id_13CC8 = [];
  anim._id_13CC8["c12"] = ::_id_363B;
  anim._id_5667 = [];
  anim._id_13CD3 = scripts\anim\shared::_id_CB29;
  _id_9811();
  _id_97C0();
  _id_9897();

  if(!isDefined(anim.optionalstepeffectfunction)) {
    anim.optionalstepeffectsmallfunction = scripts\anim\notetracks::_id_D480;
    anim.optionalstepeffectfunction = scripts\anim\notetracks::playfootstepeffect;
  }

  if(!isDefined(anim.optionalstepeffects)) {
    anim.optionalstepeffects = [];
  }

  if(!isDefined(anim.optionalstepeffectssmall)) {
    anim.optionalstepeffectssmall = [];
  }

  if(!isDefined(anim.shootenemywrapper_func)) {
    anim.shootenemywrapper_func = scripts\anim\utility::_id_FE9D;
  }

  if(!isDefined(anim._id_FED3)) {
    anim._id_FED3 = scripts\anim\utility::_id_FED2;
  }

  anim.fire_notetrack_functions = [];
  scripts\anim\notetracks::registernotetracks();

  if(!isDefined(level.flag)) {
    scripts\common\flags::init_flags();
  }

  scripts\sp\gameskill::_id_F848();
  level._id_C870 = undefined;
  scripts\anim\setposemovement::_id_98BF();
  scripts\anim\face::initlevelface();
  anim._id_32BF = scripts\anim\utility::_id_2274(1, 2, 2, 2, 3, 3, 3, 3, 4, 4, 5);
  anim._id_6B93 = scripts\anim\utility::_id_2274(2, 3, 3, 3, 4, 4, 4, 5, 5);
  anim._id_F217 = scripts\anim\utility::_id_2274(1, 2, 2, 3, 3, 4, 4, 4, 4, 5, 5, 5);
  anim._id_2759 = [];
  anim._id_2755 = 0;

  if(!isDefined(anim._id_3D4B)) {
    if(scripts\engine\utility::player_is_in_jackal()) {
      anim.player = level._id_D127;
    } else {
      anim.player = getEntArray("player", "classname")[0];
    }

    _id_97DA();
  }

  _id_98E4();
  scripts\anim\cqb::_id_FA9F();
  _id_97F5();
  anim._id_A955 = -100000;
  _id_FAE3();
  level.player thread scripts\anim\combat_utility::_id_13B22();
}

_id_5031() {
  _id_98E1(self.primaryweapon);
  _id_98E1(self.secondaryweapon);
  _id_98E1(self._id_101B4);
  self _meth_82D0();
  self.a.weaponpos["left"] = "none";
  self.a.weaponpos["right"] = "none";
  self.a.weaponpos["chest"] = "none";
  self.a.weaponpos["back"] = "none";
  self.a.weaponposdropping["left"] = "none";
  self.a.weaponposdropping["right"] = "none";
  self.a.weaponposdropping["chest"] = "none";
  self.a.weaponposdropping["back"] = "none";
  self.lastweapon = self.weapon;
  var_0 = scripts\anim\utility_common::usingrocketlauncher();
  self.a._id_BEF9 = var_0;

  if(var_0) {
    thread scripts\anim\shared::_id_E775();
  }

  self.a.rockets = 3;
  self.a.rocketvisible = 1;
  scripts\anim\shared::placeweaponon(self.primaryweapon, "right");

  if(scripts\anim\utility_common::isshotgun(self.secondaryweapon)) {
    scripts\anim\shared::placeweaponon(self.secondaryweapon, "back");
  }

  if(self.team != "allies") {
    self._id_8B95 = 1;
  }

  scripts\anim\weaponlist::refillclip();
}

_id_3597() {
  if(scripts\anim\utility_common::usingrocketlauncher()) {
    return "rocket";
  } else if(scripts\anim\utility_common::usingriflelikeweapon()) {
    return "minigun";
  }

  return undefined;
}

_id_363B() {
  self._id_13CC3 = [];

  if(self.primaryweapon != "" && self.primaryweapon != "none") {
    self.weapon = self.primaryweapon;
    self._id_13CC3["right"] = _id_3597();
  }

  if(self.secondaryweapon != "" && self.secondaryweapon != "none") {
    self.weapon = self.secondaryweapon;
    self._id_13CC3["left"] = _id_3597();
  }

  self.weapon = "";
  self.bulletsinclip = 1;
}