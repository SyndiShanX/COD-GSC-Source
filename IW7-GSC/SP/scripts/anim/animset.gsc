/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\animset.gsc
**************************************/

_id_94FD() {
  if(isDefined(anim._id_1FD2)) {
    return;
  }
  anim._id_1FD2 = 1;

  if(!isDefined(anim.archetypes))
    anim.archetypes = [];

  anim.archetypes["soldier"] = [];
  scripts\anim\cover_left::_id_9507();
  scripts\anim\cover_right::_id_950A();
  scripts\anim\cover_prone::_id_9509();
  scripts\anim\cover_wall::_id_950B();
  scripts\anim\reactions::_id_951D();
  scripts\anim\pain::_id_951B();
  scripts\anim\death::_id_9510();
  scripts\anim\combat::_id_9504();
  scripts\anim\move::_id_951A();
  scripts\anim\flashed::_id_9514();
  scripts\anim\stop::_id_9518();
  anim._id_1FD1 = spawnStruct();
  anim._id_1FD1.move = [];
  _id_9513();
  _id_950D();
  _id_951C();
  _id_951F();
  _id_9523();
  _id_9517();
  _id_9511();
  _id_951E();
  _id_9522();
  _id_9512();
  _id_9520();
  _id_9524();
  _id_950C();
  _id_9516();
  _id_9692();
  _id_95D5();
  _id_9515();
  _id_960E();
  _id_9521();
  _id_9503();
}

_id_DEE7(var_0, var_1, var_2) {
  _id_94FD();
  anim.archetypes[var_0] = var_1;

  if(isDefined(var_1["flashed"]))
    anim._id_6EC0[var_0] = 0;

  if(isDefined(var_2) && var_2)
    scripts\anim\init_move_transitions::_id_814D(var_0);
}

_id_2126(var_0) {
  return _func_2ED(var_0) || isDefined(anim.archetypes[var_0]);
}

_id_9520() {}

_id_9516() {}

_id_9524() {}

_id_950C() {}

_id_951C() {}

_id_951F() {}

_id_9523() {}

_id_950D() {}

_id_9517() {}

_id_9515() {}

_id_9513() {}

_id_9511() {}

_id_951E() {}

_id_9522() {}

_id_9512() {}

_id_9506(var_0) {}

_id_950F(var_0, var_1, var_2, var_3) {}

_id_9505(var_0) {}

_id_950E(var_0, var_1, var_2) {}

_id_413F() {
  self.custommoveanimset = undefined;
  self._id_4C8C = undefined;
  self._id_440C = undefined;
  self._id_4400 = undefined;
}

_id_F2C2(var_0) {}

_id_F2C1() {}

_id_F2B9() {}

_id_F2BD() {}

_id_F2B5() {}

_id_F2BB(var_0) {}

_id_F2B4() {}

_id_F2BA(var_0) {}

_id_F2B3() {}

_id_F2B2() {}

_id_F2BE() {
  if(scripts\anim\utility_common::isusingsidearm())
    self.a._id_2274 = scripts\anim\utility::_id_B028("pistol_stand");
  else if(isDefined(self._id_440C))
    self.a._id_2274 = self._id_440C;
  else if(isDefined(self.heat))
    self.a._id_2274 = scripts\anim\utility::_id_B028("heat_stand");
  else if(scripts\anim\utility_common::usingrocketlauncher())
    self.a._id_2274 = scripts\anim\utility::_id_B028("rpg_stand");
  else if(isDefined(self.weapon) && scripts\anim\utility_common::weapon_pump_action_shotgun())
    self.a._id_2274 = scripts\anim\utility::_id_B028("shotgun_stand");
  else if(scripts\anim\utility::_id_9D9B())
    self.a._id_2274 = scripts\anim\utility::_id_B028("cqb_stand");
  else
    self.a._id_2274 = scripts\anim\utility::_id_B028("default_stand");
}

_id_F2B6() {
  if(scripts\anim\utility_common::isusingsidearm())
    scripts\anim\shared::placeweaponon(self.primaryweapon, "right");

  if(isDefined(self._id_4400))
    self.a._id_2274 = self._id_4400;
  else if(scripts\anim\utility_common::usingrocketlauncher())
    self.a._id_2274 = scripts\anim\utility::_id_B028("rpg_crouch");
  else if(isDefined(self.weapon) && scripts\anim\utility_common::weapon_pump_action_shotgun())
    self.a._id_2274 = scripts\anim\utility::_id_B028("shotgun_crouch");
  else
    self.a._id_2274 = scripts\anim\utility::_id_B028("default_crouch");
}

_id_F2BC() {
  if(scripts\anim\utility_common::isusingsidearm())
    scripts\anim\shared::placeweaponon(self.primaryweapon, "right");

  self.a._id_2274 = scripts\anim\utility::_id_B028("default_prone");
}

_id_9692() {}

_id_95D5() {}

_id_960E() {}

_id_9521() {}

_id_FA33() {
  self._id_B4C3 = 130;
  self._id_E878 = 0.461538;
  self._id_E876 = 0.3;
}

_id_9503() {}

_id_F2AC() {
  self.a._id_BCA5["move_l"] = scripts\anim\utility::_id_B027("ambush", "move_l");
  self.a._id_BCA5["move_r"] = scripts\anim\utility::_id_B027("ambush", "move_r");
  self.a._id_BCA5["move_b"] = scripts\anim\utility::_id_B027("ambush", "move_b");
}

_id_8CD8() {
  if(self.weapon != self.primaryweapon)
    return scripts\anim\utility::_id_1F67("reload");

  if(isDefined(self.node)) {
    if(self _meth_8214()) {
      var_0 = undefined;

      if(self.node.type == "Cover Left")
        var_0 = scripts\anim\utility::_id_B027("heat_reload", "reload_cover_left");
      else if(self.node.type == "Cover Right")
        var_0 = scripts\anim\utility::_id_B027("heat_reload", "reload_cover_right");

      if(isDefined(var_0))
        return var_0;
    }
  }

  return scripts\anim\utility::_id_B027("heat_reload", "reload_default");
}