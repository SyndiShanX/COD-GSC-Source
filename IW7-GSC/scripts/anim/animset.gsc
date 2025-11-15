/************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\anim\animset.gsc
************************************/

func_94FD() {
  if(isDefined(level.var_1FD2)) {
    return;
  }

  anim.var_1FD2 = 1;
  if(!isDefined(level.archetypes)) {
    anim.archetypes = [];
  }

  level.archetypes["soldier"] = [];
  scripts\anim\cover_left::func_9507();
  scripts\anim\cover_right::func_950A();
  scripts\anim\cover_prone::func_9509();
  scripts\anim\cover_wall::func_950B();
  scripts\anim\reactions::func_951D();
  scripts\anim\pain::func_951B();
  scripts\anim\death::func_9510();
  scripts\anim\combat::func_9504();
  scripts\anim\move::func_951A();
  scripts\anim\flashed::func_9514();
  scripts\anim\stop::func_9518();
  anim.var_1FD1 = spawnStruct();
  level.var_1FD1.move = [];
  func_9513();
  func_950D();
  func_951C();
  func_951F();
  func_9523();
  func_9517();
  func_9511();
  func_951E();
  func_9522();
  func_9512();
  func_9520();
  func_9524();
  func_950C();
  func_9516();
  func_9692();
  func_95D5();
  func_9515();
  func_960E();
  func_9521();
  func_9503();
}

func_DEE7(param_00, param_01, param_02) {
  func_94FD();
  level.archetypes[param_00] = param_01;
  if(isDefined(param_01["flashed"])) {
    level.var_6EC0[param_00] = 0;
  }

  if(isDefined(param_02) && param_02) {
    scripts\anim\init_move_transitions::_meth_814D(param_00);
  }
}

func_2126(param_00) {
  return archetypeassetloaded(param_00) || isDefined(level.archetypes[param_00]);
}

func_9520() {}

func_9516() {}

func_9524() {}

func_950C() {}

func_951C() {}

func_951F() {}

func_9523() {}

func_950D() {}

func_9517() {}

func_9515() {}

func_9513() {}

func_9511() {}

func_951E() {}

func_9522() {}

func_9512() {}

func_9506(param_00) {}

func_950F(param_00, param_01, param_02, param_03) {}

func_9505(param_00) {}

func_950E(param_00, param_01, param_02) {}

func_413F() {
  self.custommoveanimset = undefined;
  self.var_4C8C = undefined;
  self.var_440C = undefined;
  self.var_4400 = undefined;
}

func_F2C2(param_00) {}

func_F2C1() {}

func_F2B9() {}

func_F2BD() {}

func_F2B5() {}

func_F2BB(param_00) {}

func_F2B4() {}

func_F2BA(param_00) {}

func_F2B3() {}

func_F2B2() {}

func_F2BE() {
  if(scripts\anim\utility_common::isusingsidearm()) {
    self.a.var_2274 = scripts\anim\utility::func_B028("pistol_stand");
    return;
  }

  if(isDefined(self.var_440C)) {
    self.a.var_2274 = self.var_440C;
    return;
  }

  if(isDefined(self.heat)) {
    self.a.var_2274 = scripts\anim\utility::func_B028("heat_stand");
    return;
  }

  if(scripts\anim\utility_common::usingrocketlauncher()) {
    self.a.var_2274 = scripts\anim\utility::func_B028("rpg_stand");
    return;
  }

  if(isDefined(self.var_394) && scripts\anim\utility_common::weapon_pump_action_shotgun()) {
    self.a.var_2274 = scripts\anim\utility::func_B028("shotgun_stand");
    return;
  }

  if(scripts\anim\utility::func_9D9B()) {
    self.a.var_2274 = scripts\anim\utility::func_B028("cqb_stand");
    return;
  }

  self.a.var_2274 = scripts\anim\utility::func_B028("default_stand");
}

func_F2B6() {
  if(scripts\anim\utility_common::isusingsidearm()) {
    scripts\anim\shared::placeweaponon(self.primaryweapon, "right");
  }

  if(isDefined(self.var_4400)) {
    self.a.var_2274 = self.var_4400;
    return;
  }

  if(scripts\anim\utility_common::usingrocketlauncher()) {
    self.a.var_2274 = scripts\anim\utility::func_B028("rpg_crouch");
    return;
  }

  if(isDefined(self.var_394) && scripts\anim\utility_common::weapon_pump_action_shotgun()) {
    self.a.var_2274 = scripts\anim\utility::func_B028("shotgun_crouch");
    return;
  }

  self.a.var_2274 = scripts\anim\utility::func_B028("default_crouch");
}

func_F2BC() {
  if(scripts\anim\utility_common::isusingsidearm()) {
    scripts\anim\shared::placeweaponon(self.primaryweapon, "right");
  }

  self.a.var_2274 = scripts\anim\utility::func_B028("default_prone");
}

func_9692() {}

func_95D5() {}

func_960E() {}

func_9521() {}

func_FA33() {
  self.var_B4C3 = 130;
  self.var_E878 = 0.4615385;
  self.var_E876 = 0.3;
}

func_9503() {}

func_F2AC() {
  self.a.var_BCA5["move_l"] = scripts\anim\utility::func_B027("ambush", "move_l");
  self.a.var_BCA5["move_r"] = scripts\anim\utility::func_B027("ambush", "move_r");
  self.a.var_BCA5["move_b"] = scripts\anim\utility::func_B027("ambush", "move_b");
}

func_8CD8() {
  if(self.var_394 != self.primaryweapon) {
    return scripts\anim\utility::func_1F67("reload");
  }

  if(isDefined(self.target_getindexoftarget)) {
    if(self getwatcheddvar()) {
      var_00 = undefined;
      if(self.target_getindexoftarget.type == "Cover Left") {
        var_00 = scripts\anim\utility::func_B027("heat_reload", "reload_cover_left");
      } else if(self.target_getindexoftarget.type == "Cover Right") {
        var_00 = scripts\anim\utility::func_B027("heat_reload", "reload_cover_right");
      }

      if(isDefined(var_00)) {
        return var_00;
      }
    }
  }

  return scripts\anim\utility::func_B027("heat_reload", "reload_default");
}