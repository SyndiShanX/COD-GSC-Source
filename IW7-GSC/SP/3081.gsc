/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: SP\3081.gsc
*********************************************/

func_97F9() {
  self.var_71A1 = ::func_5673;
  self.var_719D = ::func_4D6D;
  lib_0A15::setupdestructibledoors();
}

func_4D6D(var_0) {
  var_1 = 0;
  switch (var_0.updategamerprofileall) {
    case "hip_pack_left":
    case "hip_pack_right":
    case "torso":
    case "head":
      break;

    case "right_arm":
    case "left_arm":
      var_1 = 1;
      break;
  }

  lib_0A0B::func_98C9(var_0.updategamerprofileall);
  if(self._blackboard.scriptableparts[var_0.updategamerprofileall].state == "dismember") {
    return;
  }

  var_2 = "dmg_" + var_0.spawnscriptitem;
  var_3 = 0;
  if(var_1) {
    if(self._blackboard.scriptableparts[var_0.updategamerprofileall].state == "dmg_upper" || self._blackboard.scriptableparts[var_0.updategamerprofileall].state == "dmg_lower") {
      var_3 = 1;
    }
  }

  if(var_3) {
    self func_847D(var_0.updategamerprofileall);
    return;
  }

  lib_0A0B::func_F592(var_0.updategamerprofileall, var_2);
  if(var_1 && var_0.spawnscriptitem == "upper" && self.var_13CC3[strtok(var_0.updategamerprofileall, "_")[0]] == "rocket") {
    lib_0C47::func_10907();
  }
}

func_5673(var_0) {
  var_1 = 1;
  switch (var_0.updategamerprofileall) {
    case "left_arm":
      func_5668();
      break;

    case "right_arm":
      func_5675();
      break;

    case "left_leg":
      func_566A();
      break;

    case "right_leg":
      func_5677();
      break;

    case "hip_pack_left":
      func_5669();
      var_1 = 0;
      break;

    case "hip_pack_right":
      func_5676();
      var_1 = 0;
      break;

    case "head":
      func_5666();
      break;

    case "torso":
      break;

    default:
      break;
  }

  if(isDefined(self.var_C925) && isDefined(self.var_C925[var_0.updategamerprofileall])) {
    self.var_C925[var_0.updategamerprofileall] delete();
    self.var_C925 = scripts\sp\utility::func_22B2(self.var_C925, var_0.updategamerprofileall);
  }

  self notify(var_0.updategamerprofileall + "_dismembered");
  if(self getthreatbiasgroup() != "c12" && issubstr(var_0.updategamerprofileall, "arm") || issubstr(var_0.updategamerprofileall, "leg")) {
    thread func_6620();
  }

  func_5674(var_0.updategamerprofileall, var_1);
}

func_5674(var_0, var_1) {
  lib_0A0B::func_98C9(var_0);
  if(lib_0A0B::func_7C35(var_0) == "dismember") {
    return;
  }

  if(isDefined(self.bt.var_55CF)) {
    return;
  }

  var_2 = 0.25;
  if(var_0 == "head") {
    var_2 = 0;
  }

  thread lib_0A0B::func_F592(var_0, "dismember", var_2);
  lib_0A0B::func_F6C9(var_0);
  thread func_3544(var_0);
  if(isDefined(self.bt.var_55CE)) {
    return;
  }

  if(var_1) {
    scripts\asm\asm::asm_setstate("dismember");
  }
}

func_5666() {
  scripts\asm\asm_bb::bb_setselfdestruct(1);
  playrumbleonposition("light_1s", self gettagorigin("j_neck"));
}

func_5668() {
  var_0 = "left";
  if(self.var_13CC3[var_0] == "rocket" && isDefined(self.var_E601)) {
    self.var_E601 delete();
  }

  lib_0A05::func_3555(var_0, 0);
  scripts\asm\asm_bb::bb_setcanrodeo(var_0);
  if(getdvarint("c12_slowturn")) {
    lib_0A05::func_3609(0.05);
  }

  if(func_9D45("left_arm")) {
    func_5678();
  }

  playrumbleonposition("light_1s", self gettagorigin("j_clavicle_le"));
}

func_5675() {
  var_0 = "right";
  if(self.var_13CC3[var_0] == "rocket" && isDefined(self.var_E601)) {
    self.var_E601 delete();
  }

  lib_0A05::func_3555(var_0, 0);
  scripts\asm\asm_bb::bb_setcanrodeo(var_0);
  if(getdvarint("c12_slowturn")) {
    lib_0A05::func_3609(0.05);
  }

  if(func_9D45("right_arm")) {
    func_5678();
  }

  playrumbleonposition("light_1s", self gettagorigin("j_clavicle_ri"));
}

func_566A() {
  if(func_9D45("left_leg")) {
    func_5678();
  }

  playrumbleonposition("light_1s", self gettagorigin("j_mainroot2"));
}

func_5677() {
  if(func_9D45("right_leg")) {
    func_5678();
  }

  playrumbleonposition("light_1s", self gettagorigin("j_mainroot2"));
}

func_5669() {}

func_5676() {}

func_9E23(var_0) {
  return 0;
}

func_9D45(var_0) {
  var_1 = ["left_arm", "right_arm", "left_leg", "right_leg"];
  var_1 = scripts\engine\utility::array_remove(var_1, var_0);
  foreach(var_3 in var_1) {
    if(scripts\asm\asm_bb::ispartdismembered(var_3)) {
      return 1;
    }
  }

  return 0;
}

func_5678() {
  scripts\asm\asm_bb::bb_setselfdestruct(1);
  if(!isDefined(self.script_noteworthy) || self.script_noteworthy != "enemy_hill_intro_c12") {
    lib_0A05::func_3634("c12AchievementSelfdestruct");
  }
}

func_6620() {
  var_0 = level.player getthreatbiasgroup();
  if(!threatbiasgroupexists("c12")) {
    createthreatbiasgroup("c12");
  }

  if(!threatbiasgroupexists("player")) {
    createthreatbiasgroup("player");
  }

  self give_zombies_perk("c12");
  level.player give_zombies_perk("player");
  setthreatbias("player", "c12", 99999);
  self waittill("death");
  if(var_0 != "") {
    level.player give_zombies_perk(var_0);
    return;
  }

  level.player give_zombies_perk();
}

func_3544(var_0) {
  if(var_0 == "right_arm" || var_0 == "left_arm") {
    self playSound("c12_dismember_arm");
  }

  if(var_0 == "right_leg" || var_0 == "left_leg") {
    self playSound("c12_dismember_leg");
  }
}