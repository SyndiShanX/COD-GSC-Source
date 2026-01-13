/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\anim\init.gsc
*********************************************/

func_98E1(var_0) {
  self.var_39B[var_0] = spawnStruct();
  self.var_39B[var_0].weaponisauto = "none";
  self.var_39B[var_0].var_8BDE = 1;
  if(getweaponclipmodel(var_0) != "") {
    self.var_39B[var_0].var_13053 = 1;
    return;
  }

  self.var_39B[var_0].var_13053 = 0;
}

func_A000(var_0) {
  return isDefined(self.var_39B[var_0]);
}

func_F724() {
  anim.covercrouchleanpitch = 55;
  anim.var_1A52 = 10;
  anim.var_1A50 = 4096;
  anim.var_1A51 = 45;
  anim.var_1A44 = 20;
  anim.var_C88B = 25;
  anim.var_C889 = level.var_1A50;
  anim.var_C88A = level.var_1A51;
  anim.var_C87D = 30;
  anim.var_B480 = 65;
  anim.var_B47F = 65;
}

func_68BD() {
  if(scripts\anim\utility_common::isshotgun(self.secondaryweapon)) {
    return 1;
  }

  if(weaponclass(self.primaryweapon) == "rocketlauncher") {
    return 1;
  }

  return 0;
}

func_FAFB() {
  self endon("death");
  scripts\engine\utility::flag_wait("load_finished");
  if(isDefined(level.var_13CC8) && isDefined(level.var_13CC8[self.unittype])) {
    self[[level.var_13CC8[self.unittype]]]();
    return;
  }

  func_5031();
}

main() {
  self.a = spawnStruct();
  self.a.laseron = 0;
  self.primaryweapon = self.var_394;
  func_6DE9();
  if(!scripts\engine\utility::flag_exist("load_finished")) {
    scripts\engine\utility::flag_init("load_finished");
  }

  if(self.primaryweapon == "") {
    self.primaryweapon = "none";
  }

  if(self.secondaryweapon == "") {
    self.secondaryweapon = "none";
  }

  if(self.var_101B4 == "") {
    self.var_101B4 = "none";
  }

  self.var_E6E6 = % root;
  self.a.var_2C13 = % body;
  thread begingrenadetracking();
  self.a.pose = "stand";
  self.a.var_85E2 = "stand";
  self.a.movement = "stop";
  self.a.state = "stop";
  self.a.var_10930 = "none";
  self.a.var_870D = "none";
  self.a.var_D8BD = -1;
  self.iscinematicplaying = 1;
  self.var_B781 = 750;
  thread func_FAFB();
  self.a.needstorechamber = 0;
  self.a.combatendtime = gettime();
  self.a.lastenemytime = gettime();
  self.a.var_112CB = 0;
  self.a.disablelongdeath = !self gettargetchargepos();
  self.a.var_AFFF = 0;
  self.a.var_C888 = 0;
  self.a.var_A9ED = 0;
  self.a.nextgrenadetrytime = 0;
  self.a.reacttobulletchance = 0.8;
  self.a.var_D707 = undefined;
  self.a.var_10B53 = "stand";
  self.var_3EF3 = ::scripts\anim\utility::func_3EF2;
  self.var_117C = 0;
  self.var_1300 = 0;
  thread func_6568();
  self.var_2894 = 1;
  self.a.var_B8D6 = 0;
  self.a.nodeath = 0;
  self.a.var_B8D6 = 0;
  self.a.var_B8D8 = 0;
  self.a.var_5605 = 0;
  self.var_154E = 1;
  self.var_3D4B = 0;
  self.var_101E7 = 0;
  self.var_101E6 = 1;
  self.var_BE8B = 1;
  self.var_504E = 55;
  scripts\sp\utility::func_F6FE("asm");
  self.a.var_BFAF = 0;
  if(!isDefined(self.script_forcegrenade)) {
    self.script_forcegrenade = 0;
  }

  func_FAF2();
  self.lastenemysighttime = 0;
  self.var_440E = 0;
  self.var_112C8 = 0;
  self.var_112CA = 0;
  if(self.team == "allies") {
    self.suppressionthreshold = 0.5;
  } else {
    self.suppressionthreshold = 0;
  }

  if(self.team == "allies") {
    self.var_DCAF = 0;
  } else {
    self.var_DCAF = 256;
  }

  self.ammocheatinterval = 8000;
  self.ammocheattime = 0;
  scripts\anim\animset::func_FA33();
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

  self.var_DD23 = 0;
  self.var_FFD3 = 0;
  if(!isDefined(level.var_55FE)) {
    thread scripts\anim\combat_utility::func_B9D9();
  }

  thread ondeath_clearscriptedanim();
  if(getdvarint("ai_iw7", 0) == 1 && !getdvarint("r_reflectionProbeGenerate")) {
    self _meth_8250(0);
    scripts\aitypes\bt_util::opcode::OP_ScriptThreadCallPointer();
    lib_0A1E::func_234D(self.var_1FA9, self.var_1FA8);
    thread func_19F7();
    self.var_1FA9 = undefined;
    self.var_1FA8 = undefined;
  }

  thread func_F7AC();
}

func_1929() {
  return self._blackboard.var_444A;
}

func_100B4(var_0, var_1) {
  if(!var_0 || self.unittype != "soldier" && self.unittype != "c6") {
    return 1;
  }

  var_2 = int(gettime() / 50) % 2;
  return var_1 == var_2;
}

func_1001A() {
  return isDefined(self.bt.var_72EB) && self.bt.var_72EB;
}

func_19F7() {
  self endon("terminate_ai_threads");
  self endon("entitydeleted");
  thread lib_0A1E::func_51B8();
  thread lib_0A1E::traversehandler();
  var_0 = 1;
  var_1 = self getentitynumber() % 2;
  for(;;) {
    var_2 = 0;
    if(func_1001A()) {
      scripts\aitypes\bt_util::opcode::OP_ClearArray();
      var_2 = 1;
      self.bt.var_72EB = undefined;
    } else if(var_0) {
      if(!func_1929()) {
        scripts\aitypes\bt_util::opcode::OP_ClearArray();
        var_2 = 1;
      }
    }

    if(var_2) {
      scripts\asm\asm::func_2314();
    }

    if(isDefined(self.asm.var_10E23)) {
      scripts\asm\asm::asm_clearevents(self.asm.var_10E23);
      self.asm.var_10E23 = undefined;
    }

    scripts\asm\asm::func_2389();
    wait(0.05);
    if(!isDefined(self)) {
      break;
    }

    var_0 = func_100B4(var_2, var_1);
  }
}

func_13CC7(var_0) {
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

func_F7AC() {
  self endon("death");
  if(!isDefined(level.var_AE64)) {
    level waittill("loadout complete");
  }

  scripts\sp\names::func_7B05();
  thread scripts\anim\squadmanager::func_185C();
}

pollallowedstancesthread() {
  for(;;) {
    if(self getteleportlonertargetplayer("stand")) {
      var_0[0] = "stand allowed";
      var_1[0] = (0, 1, 0);
    } else {
      var_0[0] = "stand not allowed";
      var_1[0] = (1, 0, 0);
    }

    if(self getteleportlonertargetplayer("crouch")) {
      var_0[1] = "crouch allowed";
      var_1[1] = (0, 1, 0);
    } else {
      var_0[1] = "crouch not allowed";
      var_1[1] = (1, 0, 0);
    }

    if(self getteleportlonertargetplayer("prone")) {
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

    wait(0.05);
  }
}

func_FAF2() {
  if(!isDefined(self.animplaybackrate) || !isDefined(self.moveplaybackrate)) {
    func_F2B0();
  }
}

func_F2B0() {
  self.animplaybackrate = 0.97 + randomfloat(0.13);
  self.var_BD22 = 0.97 + randomfloat(0.13);
  self.moveplaybackrate = self.var_BD22;
  self.var_101BB = 1.35;
}

func_94AC(var_0, var_1, var_2, var_3) {
  anim waittill("new exceptions");
}

empty(var_0, var_1, var_2, var_3) {}

func_6568() {
  self endon("death");
  if(1) {
    return;
  }

  for(;;) {
    self waittill("enemy");
    if(!isalive(self.isnodeoccupied)) {
      continue;
    }

    while(isplayer(self.isnodeoccupied)) {
      if(scripts\anim\utility::func_8BED()) {
        level.var_A9D0 = gettime();
      }

      wait(2);
    }
  }
}

func_98E4() {
  level.var_13D57[0] = -36.8552;
  level.var_13D57[1] = -27.0095;
  level.var_13D57[2] = -15.5981;
  level.var_13D57[3] = -4.37769;
  level.var_13D57[4] = 17.7776;
  level.var_13D57[5] = 59.8499;
  level.var_13D57[6] = 104.808;
  level.var_13D57[7] = 152.325;
  level.var_13D57[8] = 201.052;
  level.var_13D57[9] = 250.244;
  level.var_13D57[10] = 298.971;
  level.var_13D57[11] = 330.681;
}

func_6DE9() {
  if(getdvarint("ai_iw7", 0) == 1) {
    func_6DEA();
    return;
  }

  if(isDefined(level.var_C122)) {
    return;
  }

  anim.var_C122 = 1;
  scripts\anim\animset::func_94FD();
  anim.var_13086 = 0;
  lib_0B5F::func_965A();
  level.var_BF83 = randomint(3);
  level.var_A9D0 = 100;
  anim.defaultexception = ::empty;
  func_97F8();
  setdvarifuninitialized("scr_expDeathMayMoveCheck", "on");
  scripts\sp\names::func_F9E6();
  anim.var_1FB5 = 0;
  scripts\anim\init_move_transitions::func_98A0();
  anim.combatidlepreventoverlappingplayer = 10000;
  anim.combatmemorytimeconst = 6000;
  func_9811();
  func_97C0();
  if(!isDefined(level.optionalstepeffectfunction)) {
    anim.optionalstepeffectsmallfunction = ::scripts\anim\notetracks::func_D480;
    anim.optionalstepeffectfunction = ::scripts\anim\notetracks::playfootstepeffect;
  }

  if(!isDefined(level.optionalstepeffects)) {
    anim.optionalstepeffects = [];
  }

  if(!isDefined(level.optionalstepeffectssmall)) {
    anim.optionalstepeffectssmall = [];
  }

  if(!isDefined(level.shootenemywrapper_func)) {
    anim.shootenemywrapper_func = ::scripts\anim\utility::func_FE9D;
  }

  if(!isDefined(level.var_FED3)) {
    anim.var_FED3 = ::scripts\anim\utility::func_FED2;
  }

  level.fire_notetrack_functions["scripted"] = scripts\anim\notetracks::fire_straight;
  level.fire_notetrack_functions["cover_right"] = scripts\anim\notetracks::shootnotetrack;
  level.fire_notetrack_functions["cover_left"] = scripts\anim\notetracks::shootnotetrack;
  level.fire_notetrack_functions["cover_crouch"] = scripts\anim\notetracks::shootnotetrack;
  level.fire_notetrack_functions["cover_stand"] = scripts\anim\notetracks::shootnotetrack;
  level.fire_notetrack_functions["move"] = scripts\anim\notetracks::shootnotetrack;
  scripts\anim\notetracks::registernotetracks();
  if(!isDefined(level.flag)) {
    scripts\common\flags::init_flags();
  }

  scripts\sp\gameskill::func_F848();
  level.var_C870 = undefined;
  scripts\anim\setposemovement::func_98BF();
  scripts\anim\face::initlevelface();
  anim.var_32BF = scripts\anim\utility::func_2274(1, 2, 2, 2, 3, 3, 3, 3, 4, 4, 5);
  anim.var_6B93 = scripts\anim\utility::func_2274(2, 3, 3, 3, 4, 4, 4, 5, 5);
  anim.var_F217 = scripts\anim\utility::func_2274(1, 2, 2, 3, 3, 4, 4, 4, 4, 5, 5, 5);
  anim.var_2759 = [];
  anim.var_2755 = 0;
  anim.player = getEntArray("player", "classname")[0];
  func_97DA();
  func_98E4();
  scripts\anim\cqb::func_FA9F();
  func_97F5();
  func_F724();
  anim.var_A955 = -100000;
  anim.var_BF91 = 10000;
  func_FAE3();
  level.player thread scripts\anim\combat_utility::func_13B22();
  thread func_1B08();
}

func_97F8() {}

func_97DA() {
  if(!isDefined(level.player.team)) {
    level.player.team = "allies";
  }

  scripts\anim\squadmanager::func_9763();
  level.player thread scripts\anim\squadmanager::func_1811();
  level.player thread scripts\anim\squadmanager::func_D362();
  scripts\anim\battlechatter::func_9542();
  level.player thread scripts\anim\battlechatter_ai::func_185D();
  lib_0E4E::func_96F1();
  anim thread scripts\anim\battlechatter::func_29C9();
}

func_97F5() {
  anim.var_C222 = randomintrange(0, 15);
  anim.var_C221 = randomintrange(0, 10);
  anim.var_BF77 = gettime() + randomintrange(0, 20000);
  anim.var_BF78 = gettime() + randomintrange(0, 10000);
  anim.var_BF76 = gettime() + randomintrange(0, 15000);
}

func_9811() {
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
    var_1.grenadetimers["double_grenade"] = randomintrange(1000, -5536);
    var_1.numgrenadesinprogresstowardsplayer = 0;
    var_1.var_A990 = -1000000;
    var_1.lastfraggrenadetoplayerstart = -1000000;
    var_1 thread func_F7B3();
  }

  level.grenadetimers["AI_fraggrenade"] = randomintrange(0, 20000);
  level.grenadetimers["AI_frag"] = randomintrange(0, 20000);
  level.grenadetimers["AI_seeker"] = randomintrange(0, 20000);
  level.grenadetimers["AI_frag_main"] = randomintrange(0, 20000);
  level.grenadetimers["AI_frag_vr"] = randomintrange(0, 20000);
  level.grenadetimers["AI_flash_grenade"] = randomintrange(0, 20000);
  level.grenadetimers["AI_smoke_grenade_american"] = randomintrange(0, 20000);
  level.grenadetimers["AI_emp"] = randomintrange(0, 20000);
  level.grenadetimers["AI_antigrav"] = randomintrange(0, 20000);
  level.grenadetimers["AI_c8_grenade"] = randomintrange(0, 10000);
  scripts\anim\combat_utility::func_9812();
}

func_97C0() {
  level.var_A936 = [];
  level.var_A936["axis"] = 0;
  level.var_A936["allies"] = 0;
  level.var_A936["team3"] = 0;
  level.var_A936["neutral"] = 0;
  level.var_A934 = [];
  level.var_A934["axis"] = (0, 0, 0);
  level.var_A934["allies"] = (0, 0, 0);
  level.var_A934["team3"] = (0, 0, 0);
  level.var_A934["neutral"] = (0, 0, 0);
  level.var_A935 = [];
  level.var_A935["axis"] = (0, 0, 0);
  level.var_A935["allies"] = (0, 0, 0);
  level.var_A935["team3"] = (0, 0, 0);
  level.var_A935["neutral"] = (0, 0, 0);
  level.var_A933 = [];
  level.var_18D5 = [];
  level.var_18D5["axis"] = 0;
  level.var_18D5["allies"] = 0;
  level.var_18D5["team3"] = 0;
  level.var_18D5["neutral"] = 0;
  level.var_18D7 = 30000;
  level.var_18D6 = 3;
}

func_9897() {
  level.var_B5F8["c6"] = 0;
  level.var_B5F5["c6"] = 9000;
  level.var_B5F7["c6"] = 0;
  level.var_B5F6["c6"] = 15000;
  level.var_B5F8["seeker"] = 0;
  level.var_B5F5["seeker"] = 9000;
  level.var_B5F7["seeker"] = 0;
  level.var_B5F6["seeker"] = 15000;
}

func_1B08() {
  var_0 = 0;
  var_1 = 3;
  for(;;) {
    var_2 = getaiarray();
    if(var_2.size == 0) {
      wait(0.05);
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
        wait(0.05);
        var_0 = 0;
      }
    }
  }
}

func_F7B3() {
  waittillframeend;
  if(isDefined(self.gs.var_D397)) {
    var_0 = int(self.gs.var_D397 * 0.7);
    if(var_0 < 1) {
      var_0 = 1;
    }

    self.grenadetimers["frag"] = randomintrange(0, var_0);
    self.grenadetimers["flash_grenade"] = randomintrange(0, var_0);
    self.grenadetimers["seeker"] = randomintrange(0, var_0);
  }

  if(isDefined(self.gs.var_D382)) {
    var_0 = int(self.gs.var_D382);
    var_1 = int(var_0 / 2);
    if(var_0 <= var_1) {
      var_0 = var_1 + 1;
    }

    self.grenadetimers["double_grenade"] = randomintrange(var_1, var_0);
  }
}

begingrenadetracking() {
  if(isDefined(level.var_55F1)) {
    return;
  }

  self endon("death");
  for(;;) {
    self waittill("grenade_fire", var_0, var_1);
    if(isDefined(var_0) && scripts\engine\utility::istrue(var_0._meth_8589)) {
      continue;
    }

    if(isDefined(level.func["ai_grenade_thrown"])) {
      level thread[[level.func["ai_grenade_thrown"]]](var_0);
    }

    switch (var_1) {
      case "frag":
        thread scripts\sp\detonategrenades::func_734F(var_0);
        break;

      case "emp":
        thread lib_0E25::func_615B(var_0);
        break;

      case "seeker":
        thread lib_0E26::func_F135(var_0);
        break;

      case "antigrav":
        thread lib_0E21::func_2013(var_0);
        break;

      default:
        var_0 thread scripts\sp\utility::grenade_earthquake();
        break;
    }
  }
}

func_FAE3() {
  anim.var_DCB3 = 60;
  anim.var_DCB2 = [];
  for(var_0 = 0; var_0 < level.var_DCB3; var_0++) {
    level.var_DCB2[var_0] = var_0;
  }

  for(var_0 = 0; var_0 < level.var_DCB3; var_0++) {
    var_1 = randomint(level.var_DCB3);
    var_2 = level.var_DCB2[var_0];
    level.var_DCB2[var_0] = level.var_DCB2[var_1];
    level.var_DCB2[var_1] = var_2;
  }
}

ondeath_clearscriptedanim() {
  if(isDefined(level.var_5613)) {
    return;
  }

  self waittill("death");
  if(!isDefined(self)) {
    if(isDefined(self.a.usingworldspacehitmarkers)) {
      self.a.usingworldspacehitmarkers delete();
    }
  }
}

func_6DEA() {
  if(isDefined(level.var_C122)) {
    return;
  }

  anim.var_C122 = 1;
  anim.var_13086 = 0;
  lib_0B5F::func_965A();
  level.var_BF83 = randomint(3);
  level.var_A9D0 = 100;
  anim.defaultexception = ::empty;
  if(!isDefined(level.var_7649)) {
    level.var_7649 = [];
  }

  func_97F8();
  scripts\sp\names::func_F9E6();
  anim.var_1FB5 = 0;
  anim.combatidlepreventoverlappingplayer = 10000;
  anim.combatmemorytimeconst = 6000;
  anim.var_13CC8 = [];
  level.var_13CC8["c12"] = ::func_363B;
  anim.var_5667 = [];
  anim.var_13CD3 = ::scripts\anim\shared::func_CB29;
  func_9811();
  func_97C0();
  func_9897();
  if(!isDefined(level.optionalstepeffectfunction)) {
    anim.optionalstepeffectsmallfunction = ::scripts\anim\notetracks::func_D480;
    anim.optionalstepeffectfunction = ::scripts\anim\notetracks::playfootstepeffect;
  }

  if(!isDefined(level.optionalstepeffects)) {
    anim.optionalstepeffects = [];
  }

  if(!isDefined(level.optionalstepeffectssmall)) {
    anim.optionalstepeffectssmall = [];
  }

  if(!isDefined(level.shootenemywrapper_func)) {
    anim.shootenemywrapper_func = ::scripts\anim\utility::func_FE9D;
  }

  if(!isDefined(level.var_FED3)) {
    anim.var_FED3 = ::scripts\anim\utility::func_FED2;
  }

  anim.fire_notetrack_functions = [];
  scripts\anim\notetracks::registernotetracks();
  if(!isDefined(level.flag)) {
    scripts\common\flags::init_flags();
  }

  scripts\sp\gameskill::func_F848();
  level.var_C870 = undefined;
  scripts\anim\setposemovement::func_98BF();
  scripts\anim\face::initlevelface();
  anim.var_32BF = scripts\anim\utility::func_2274(1, 2, 2, 2, 3, 3, 3, 3, 4, 4, 5);
  anim.var_6B93 = scripts\anim\utility::func_2274(2, 3, 3, 3, 4, 4, 4, 5, 5);
  anim.var_F217 = scripts\anim\utility::func_2274(1, 2, 2, 3, 3, 4, 4, 4, 4, 5, 5, 5);
  anim.var_2759 = [];
  anim.var_2755 = 0;
  if(!isDefined(level.var_3D4B)) {
    if(scripts\engine\utility::player_is_in_jackal()) {
      anim.player = level.var_D127;
    } else {
      anim.player = getEntArray("player", "classname")[0];
    }

    func_97DA();
  }

  func_98E4();
  scripts\anim\cqb::func_FA9F();
  func_97F5();
  anim.var_A955 = -100000;
  func_FAE3();
  level.player thread scripts\anim\combat_utility::func_13B22();
}

func_5031() {
  func_98E1(self.primaryweapon);
  func_98E1(self.secondaryweapon);
  func_98E1(self.var_101B4);
  self _meth_82D0();
  self.a.weaponpos["left"] = "none";
  self.a.weaponpos["right"] = "none";
  self.a.weaponpos["chest"] = "none";
  self.a.weaponpos["back"] = "none";
  self.a.weaponposdropping["left"] = "none";
  self.a.weaponposdropping["right"] = "none";
  self.a.weaponposdropping["chest"] = "none";
  self.a.weaponposdropping["back"] = "none";
  self.lastweapon = self.var_394;
  var_0 = scripts\anim\utility_common::usingrocketlauncher();
  self.a.var_BEF9 = var_0;
  if(var_0) {
    thread scripts\anim\shared::func_E775();
  }

  self.a.rockets = 3;
  self.a.rocketvisible = 1;
  scripts\anim\shared::placeweaponon(self.primaryweapon, "right");
  if(scripts\anim\utility_common::isshotgun(self.secondaryweapon)) {
    scripts\anim\shared::placeweaponon(self.secondaryweapon, "back");
  }

  if(self.team != "allies") {
    self.var_8B95 = 1;
  }

  scripts\anim\weaponlist::refillclip();
}

func_3597() {
  if(scripts\anim\utility_common::usingrocketlauncher()) {
    return "rocket";
  } else if(scripts\anim\utility_common::usingriflelikeweapon()) {
    return "minigun";
  }

  return undefined;
}

func_363B() {
  self.var_13CC3 = [];
  if(self.primaryweapon != "" && self.primaryweapon != "none") {
    self.var_394 = self.primaryweapon;
    self.var_13CC3["right"] = func_3597();
  }

  if(self.secondaryweapon != "" && self.secondaryweapon != "none") {
    self.var_394 = self.secondaryweapon;
    self.var_13CC3["left"] = func_3597();
  }

  self.var_394 = "";
  self.bulletsinclip = 1;
}