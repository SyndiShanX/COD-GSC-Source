/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2585.gsc
*************************************************/

_id_ECAC() {
  level._effect["tac_cover_destroyed"] = loadfx("vfx/s4/props_destp/vfx_s4_vm_equip_gen_deployable_cover.vfx");

  if(!isDefined(level._id_ECE6)) {
    var_0 = getEntArray("tactical_cover_col", "targetname");

    if(isDefined(var_0)) {
      level._id_ECE6 = var_0[0];
    }
  }

  level._id_ECEB = getEntArray("dcover_blocker", "targetname");
}

_id_ECAF(var_0, var_1) {
  self notify("tac_cover_given");
}

_id_ECB0(var_0, var_1, var_2) {
  self notify("tac_cover_taken");
  self._id_ECE9 = undefined;
}

_id_ECB9(var_0) {
  waitframe();

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

_id_ECAD(var_0, var_1, var_2, var_3) {
  if(self._id_41F5 == "prone") {
    _id_ECA3(undefined, 1);
    return 0;
  }

  var_4 = tac_cover_check_for_placement(var_0, var_1, var_2, var_3, 0);

  if(!var_4) {
    return 0;
  }

  _id_07BC::createfieldupgradechallengeevent("activate");
  self _meth_852A(makeweapon("s4_tac_cover_mp"));
  wait 0.725;
  return tac_cover_check_for_placement(var_0, var_1, var_2, var_3, 1);
}

tac_cover_check_for_placement(var_0, var_1, var_2, var_3, var_4) {
  self._id_ECE9 = 1;
  var_5 = physics_createcontents(["physicscontents_characterproxy", "physicscontents_playerclip", "physicscontents_water", "physicscontents_vehicle"]);
  var_6 = _id_ECAB(self);
  var_7 = anglesToForward(self.angles);
  var_8 = self.origin + var_7 * 32;
  var_9 = self getplayerangles() * (0, 1, 0);
  var_10 = self.origin + (0, 0, 24);
  var_11 = anglesToForward(var_9);
  var_12 = 29.5;
  var_13 = var_10 + var_11 * var_12;
  var_14 = _func_02C1(var_10, var_13, var_5, var_6, 0, "physicsquery_closest", 1);
  var_15 = _id_09C7::_id_CEE7(var_8, 110, 20);
  var_16 = undefined;
  var_17 = 0;

  foreach(var_19 in var_15) {
    var_20 = distancesquared(var_19.origin, var_8);

    if(isDefined(var_16) && var_17 <= var_20) {
      continue;
    }
    var_16 = var_19;
    var_17 = var_20;
  }

  if(isDefined(var_16)) {
    var_22 = self gettagorigin("j_spinelower");
    var_23 = var_16._id_39D7 + (0, 0, 24);
    var_14 = _func_02C1(var_22, var_23, var_5, var_6, 0, "physicsquery_any", 1);

    if(isDefined(var_14) && var_14 > 0) {
      _id_ECA3(1);
      return 0;
    }

    var_24 = var_16 _meth_8730();
    var_25 = abs(var_24) > 65;
    var_26 = undefined;

    foreach(var_28 in var_15) {
      if(var_16 _id_09C7::_id_CEEB(var_28)) {
        var_26 = var_28;
        break;
      }
    }

    var_30 = 1;

    if(isDefined(var_26)) {
      var_31 = var_26 _meth_8730();
      var_30 = abs(var_31) > 65;
    }

    if(var_17 < 2500 && var_25 && var_30) {
      var_16._id_8782 = 1;
      self._id_ECE9 = undefined;

      if(isDefined(var_4) && var_4) {
        thread _id_ECB7(var_16, var_26, var_3, var_5);
        scripts\mp\utility\stats::_id_7DAE("deployableCoverUsed", 1);
      }

      return 1;
    } else if(var_17 < 2500) {
      _id_ECA3(1);
      return 0;
    }
  }

  var_32 = undefined;
  var_33 = undefined;
  var_10 = var_13;
  var_11 = anglestoright(var_9);
  var_12 = 55.5;
  var_34 = var_10 + var_11 * var_12;
  var_14 = _func_02C2(var_10, var_34, 2.5, var_5, var_6, "physicsquery_closest");

  if(isDefined(var_14) && var_14.size > 0) {
    var_35 = var_14[0]["shape_position"];
    var_32 = var_14[0]["fraction"];
  } else
    var_32 = 1;

  var_10 = var_13;
  var_11 = -1 * anglestoright(var_9);
  var_12 = 55.5;
  var_34 = var_10 + var_11 * var_12;
  var_14 = _func_02C2(var_10, var_34, 2.5, var_5, var_6, "physicsquery_closest");

  if(isDefined(var_14) && var_14.size > 0) {
    var_35 = var_14[0]["shape_position"];
    var_33 = var_14[0]["fraction"];
  } else
    var_33 = 1;

  if(var_33 + var_32 < 1) {
    _id_ECA3();
    return 0;
  } else if(var_32 < 0.5)
    var_13 = var_13 + var_11 * var_12 * (0.5 - var_32);
  else if(var_33 < 0.5) {
    var_13 = var_13 + var_11 * var_12 * (0.5 - var_33) * -1;
  }

  var_36 = var_9;
  var_10 = var_13;
  var_11 = (0, 0, -1);
  var_12 = 60;
  var_34 = var_10 + var_11 * var_12;
  var_37 = _func_0047(var_36, (0, 0, 90));
  var_14 = _func_02C3(var_10, var_34, 2.5, 16.8, var_37, var_5, var_6, "physicsquery_closest");

  if(!isDefined(var_14) || var_14.size <= 0) {
    _id_ECA3();
    return 0;
  }

  var_38 = var_14[0]["entity"];

  if(isDefined(var_38) && !_id_EC95(var_38)) {
    _id_ECA3();
    return 0;
  }

  var_39 = var_14[0]["shape_position"];
  var_35 = var_14[0]["position"];
  var_40 = var_39 - (0, 0, 2.5);
  var_41 = 25.025;
  var_42 = _func_01A6(var_41 * 0.14, 2);
  var_43 = var_39;
  var_44 = distance2dsquared(var_43, var_35);
  var_45 = var_39 + anglestoright(var_9) * 14.3 * 1.75;
  var_46 = distance2dsquared(var_45, var_35);
  var_47 = var_39 + anglestoright(var_9) * 14.3 * 1.75 * -1;
  var_48 = distance2dsquared(var_47, var_35);
  var_49 = [];
  var_50 = 0;

  if(var_46 <= var_42 && var_46 < var_44 && var_46 < var_48) {
    var_50++;
    var_49 = [var_43, var_47];
  } else if(var_48 <= var_42 && var_48 < var_44 && var_48 < var_46) {
    var_50++;
    var_49 = [var_43, var_45];
  } else if(var_44 <= var_42) {
    var_50++;
    var_49 = [var_47, var_45];
  } else
    var_49 = [var_43, var_47, var_45];

  var_11 = (0, 0, -1);
  var_12 = 8.5;

  foreach(var_10 in var_49) {
    var_34 = var_10 + var_11 * var_12;
    var_14 = _func_02C1(var_10, var_34, var_5, var_6, 0, "physicsquery_closest", 1);

    if(!isDefined(var_14) || var_14.size <= 0) {
      continue;
    }
    var_38 = var_14[0]["entity"];

    if(isDefined(var_38) && !_id_EC95(var_38)) {
      _id_ECA3();
      return 0;
    }

    var_50++;

    if(var_50 >= 3) {
      break;
    }
  }

  if(var_50 < 3) {
    _id_ECA3();
    return 0;
  }

  self._id_ECE9 = undefined;

  if(isDefined(var_4) && var_4) {
    thread _id_ECB4(var_40, var_36, undefined, var_3, var_5);
    scripts\mp\utility\stats::_id_7DAE("deployableCoverUsed", 1);
  }

  return 1;
}

tac_cover_check_for_ground_removed() {
  self endon("death");
  var_0 = physics_createcontents(["physicscontents_characterproxy", "physicscontents_playerclip", "physicscontents_water", "physicscontents_vehicle"]);

  for(;;) {
    var_1 = self.origin + (0, 0, 24);
    var_2 = self.origin + (0, 0, -0.5);
    var_3 = _func_0047(self.angles, (0, 0, 90));
    var_4 = _func_02C3(var_1, var_2, 2.5, 16.8, var_3, var_0, self._id_3A5F, "physicsquery_closest");

    if(!isDefined(var_4) || var_4.size <= 0) {
      _id_EC9C(undefined, 0);
      return;
    }

    waitframe();
  }
}

_id_EC93(var_0, var_1, var_2) {
  var_3 = _id_ECA6(1, var_0, var_1, var_2, 32);

  if(!isDefined(var_3)) {
    return var_0;
  }

  var_4 = _id_ECA6(0, var_0, var_1, var_2, 32);

  if(!isDefined(var_4)) {
    return var_0;
  }

  var_5 = min(var_3, 15);
  var_6 = anglesToForward(var_1);
  var_7 = var_0 + var_6 * var_5;

  foreach(var_9 in level._id_ECEB) {
    if(_func_011A(var_7 + (0, 0, 20), var_9)) {
      var_7 = var_7 + (0, 0, -6);
      break;
    }
  }

  return var_7;
}

_id_ECA6(var_0, var_1, var_2, var_3, var_4) {
  var_5 = anglestoleft(var_2);
  var_6 = anglesToForward(var_2);
  var_7 = -1 * var_6;
  var_8 = undefined;

  if(var_0) {
    var_8 = var_6 * var_4;
  } else {
    var_8 = var_7 * var_4;
  }

  var_9 = var_1 + (0, 0, 48);
  var_10 = var_9;
  var_11 = var_9 + var_8;
  var_12 = 2.5;
  var_13 = 29.0 + var_4;
  var_14 = _func_0047(var_2, (0, 0, 90));
  var_3 = var_3;
  var_15 = [self];
  var_16 = "physicsquery_closest";
  var_17 = _func_02C3(var_10, var_11, var_12, var_13, var_14, var_3, var_15, var_16);
  var_18 = var_17.size == 0;

  if(var_18) {
    return undefined;
  }

  var_25 = var_17[0]["shape_position"];
  var_26 = distance(var_25, var_9);
  return var_26;
}

_id_ECA3(var_0, var_1) {
  var_2 = "MP/TAC_COVER_CANNOT_PLACE";

  if(istrue(var_0)) {
    var_2 = "MP/TAC_COVER_PLACE_IN_DOORWAY";
  } else if(istrue(var_1)) {
    var_2 = "MP/TAC_COVER_PRONE_BLOCKS_USE";
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]](var_2);
  }

  if(scripts\mp\equipment::_id_755B("equip_tac_cover")) {
    scripts\mp\equipment::incrementequipmentammo("equip_tac_cover", 1);
  }
}

_id_ECA2() {
  thread _id_EC99(0);
}

_id_ECB7(var_0, var_1, var_2, var_3) {
  self endon("death_or_disconnect");
  self endon("tac_cover_taken");
  level endon("game_ended");
  var_4 = anglesToForward(self.angles);
  var_5 = var_0._id_39D6 + (0, 90, 0);
  var_6 = anglesToForward(var_5);
  var_7 = vectordot(var_4, var_6);
  var_8 = var_7 > 0;
  var_9 = var_0 _meth_8730();
  var_0 _id_09C7::_id_4E11(1, "tac_cover_door");

  if(isDefined(var_1)) {
    var_1 _id_09C7::_id_4E11(1, "tac_cover_door");
  }

  var_10 = scripts\engine\utility::ter_op(var_8, (0, 90, 0), (0, -90, 0));
  var_11 = (0, 0, -1);
  var_12 = var_0._id_39D7 + var_11;
  var_13 = _func_0047(var_0._id_39D6, var_10);
  var_14 = undefined;
  _id_ECB4(var_12, var_13, var_14, var_2, var_3, var_0, var_1);
}

_id_0BA9() {
  if(isDefined(self._id_A3E7)) {
    _func_02B1(self._id_A3E7);
  }

  var_0 = _func_02AF(self.origin, (20, 20, 64), self.angles);
  self._id_A3E7 = var_0;
  return var_0;
}

_id_0BBB() {
  if(isDefined(self._id_A3E7)) {
    _func_02B1(self._id_A3E7);
  }

  self._id_A3E7 = undefined;
}

_id_ECB4(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death_or_disconnect");
  self endon("tac_cover_taken");
  level endon("game_ended");
  var_0 = _id_EC93(var_0, var_1, var_4);
  self notify("tac_cover_spawned");
  var_3 = istrue(var_3);
  var_7 = spawn("script_model", var_0);
  var_7.angles = var_1;
  var_7.owner = self;
  var_7.team = self.team;
  var_7._id_DDEF = scripts\mp\equipment::_id_5AEA("equip_tac_cover");
  var_7._id_57CE = 1;
  var_7._id_8A74 = scripts\engine\utility::ter_op(var_3, 1, undefined);
  var_7._id_EB31 = level._id_EB2B._id_E76D["super_tac_cover"]._id_7C8C;
  var_7.weapon_name = "s4_tac_cover_mp";
  var_7 _id_078E::_id_C2B5(2, ::_id_ECA2);
  var_7 _id_0812::_id_C2B2("Tactical_Static", self);
  var_7 setentityowner(self);
  var_7 setotherent(self);
  var_7 setModel("wm_equip_gen_deployable_cover_00");
  var_7 _meth_8851(3, self.team);

  if(isDefined(var_2)) {
    var_7 linkto(var_2);
    var_7 thread _id_ECA1();
  }

  var_8 = _id_ECB5(var_7);
  var_7 _meth_8748(var_8, level._id_ECE6);
  var_7._id_3A5F = var_8;
  var_8._id_011B = var_7;
  var_8._id_A257 = 1;
  var_7 _id_0BA9();

  if(isDefined(var_5)) {
    if(isDefined(var_5._id_2598)) {
      var_5._id_2598 _id_EC9C();
    }

    var_7._id_258D = var_5;
    var_5._id_2598 = var_7;
  }

  if(isDefined(var_6)) {
    var_7._id_258E = var_6;
    var_6._id_2598 = var_7;
  }

  scripts\mp\weapons::_id_AACF(var_7, "equip_tac_cover", ::_id_EC9C);
  thread scripts\mp\weapons::_id_A105(self, var_7);

  if(var_3) {
    var_7 thread _id_EC9E(self);
    var_7 thread _id_ECA0();
  }

  var_7 thread _id_EC9F();
  var_7 thread tac_cover_check_for_ground_removed();

  if(istrue(level.map_uses_gondolas)) {
    var_7 thread tac_cover_destroy_on_gondola_collision();
  }

  thread _id_ECB6(var_7);
  thread scripts\mp\weapons::_id_ACD8(var_7);
  var_7 _meth_86FE("equipment");

  if(level.teambased) {
    var_7 _meth_8706(self.team);
  } else {
    var_7 _meth_8706(self);
  }

  var_7 thread _id_0A69::_id_CA34();
}

_id_ECB6(var_0) {
  var_0 endon("death");

  if(1 && 0) {
    var_0 _id_ECB3(1);
  }

  wait(_id_ECA4());

  if(1 && !0) {
    var_0 _id_ECB3(1);
  }
}

_id_ECB5(var_0) {
  if(!isDefined(level._id_ECE6)) {
    return;
  }
  var_1 = spawn("script_model", var_0.origin);
  var_1 dontinterpolate();
  var_1.angles = var_0.angles;
  var_1 linkto(var_0);
  var_1 setentityowner(self);
  var_1 thread tac_cover_delayed_collision_setup();
  return var_1;
}

tac_cover_delayed_collision_setup() {
  waitframe();
  self clonebrushmodeltoscriptmodel(level._id_ECE6);
}

_id_EC9C(var_0, var_1) {
  var_2 = 0;

  if(!istrue(var_0)) {
    var_2 = 0.2 + _id_ECA5();
  }

  var_3 = self.maxhealth;

  if(isDefined(self._id_014E) && self._id_014E < self.maxhealth) {
    var_3 = self._id_014E;
  }

  self.owner _id_07BC::_id_AAE7("super_tac_cover", int(var_3));
  _id_07A9::_id_9768(self.owner, self._id_EB31, int(var_3), istrue(var_1));
  playFX(level._effect["tac_cover_destroyed"], self.origin);
  _id_0BBB();
  thread _id_EC9D(var_2);
  thread _id_EC99(var_2);
}

_id_EC9D(var_0) {
  if(isDefined(self._id_258D)) {
    self._id_258D _id_09C7::_id_4E11(0, "tac_cover_door");
    self._id_258D._id_2598 = undefined;
  }

  if(isDefined(self._id_258E)) {
    self._id_258E _id_09C7::_id_4E11(0, "tac_cover_door");
    self._id_258E._id_2598 = undefined;
  }

  if(var_0 > 0) {}

  if(isDefined(self._id_3A5F)) {
    self._id_3A5F delete();
  }
}

_id_EC99(var_0) {
  self notify("death");
  level._id_9EE2[self getentitynumber()] = undefined;
  var_1 = self.owner;

  if(isDefined(var_1)) {
    var_1 scripts\mp\weapons::_id_C498(self);
  }

  if(1) {
    _id_07C3::_id_A100();
    self _meth_8406();
  }

  if(isDefined(self._id_3A5F)) {
    self._id_3A5F delete();
  }

  wait(var_0);
  self delete();
}

_id_ECA0() {
  self endon("death");
  wait 150;
  _id_EC9C(undefined, 0);
}

tac_cover_destroy_on_gondola_collision() {
  self endon("death");
  self waittill("gondola_moving_plateform_destroy");
  _id_EC9C(undefined, 0);
}

_id_EC9F() {
  self endon("death");
  level waittill("game_ended");
  _id_EC9C(undefined, 0);
}

_id_ECA1() {
  self endon("death");

  while(isDefined(self _meth_8151())) {
    waitframe();
  }

  _id_EC9C(undefined, 0);
}

_id_ECB3(var_0) {
  if(1) {
    if(var_0) {
      var_1 = scripts\mp\utility\perk::_hasperk("specialty_rugged_eqp");
      var_2 = scripts\engine\utility::ter_op(var_1, 1250, 1000);
      var_3 = "hitequip";
      var_4 = "hitequip";
      thread _id_07C3::_id_A0FF(var_2, var_3, ::_id_ECAA, ::_id_ECA9, 0, undefined, undefined, var_4);
      self _meth_8407();
    } else {
      _id_07C3::_id_A100();
      self _meth_8406();
    }
  }
}

_id_ECA9(var_0) {
  var_1 = _id_EC92(var_0);

  if(isDefined(self.owner)) {
    var_2 = max(self.maxhealth - self._id_014E, 0);
    var_3 = min(var_2, var_1);
    self.owner scripts\mp\supers::_id_3AC1("super_tac_cover", var_3);
  }

  return var_1;
}

_id_EC92(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.objweapon;
  var_3 = var_0._id_9CD6;
  var_4 = var_0.damage;
  var_5 = var_0.point;

  if(var_2.basename == "thermite_av_mp") {
    return 200.0;
  }

  if(var_2.basename == "thermite_bolt_radius_mp") {
    return 83.3333;
  }

  if(var_2.basename == "s4_throwing_knife_mp") {
    return 0;
  }

  if(var_2.basename == "s4_ar_stango44" && var_3 != "MOD_MELEE") {
    return 0;
  }

  if(var_3 == "MOD_IMPACT" && var_2.classname == "grenade") {
    return var_4;
  }

  if(var_3 == "MOD_CRUSH" && isDefined(var_0.inflictor) && var_0.inflictor.classname == "script_vehicle") {
    if(isDefined(var_1) && !scripts\mp\weapons::_id_5FB2(self.owner, var_1)) {
      return var_4;
    }
  }

  if(_func_010F(var_0._id_9CD6)) {
    return 700.0;
  }

  if(var_3 == "MOD_MELEE" || var_3 == "MOD_IMPACT") {
    return 333.333;
  }

  var_4 = _id_07C3::_id_741D(var_2, var_3, var_4);
  var_4 = _id_07C3::_id_7492(var_2, var_3, var_4);
  return var_4;
}

_id_ECAA(var_0) {
  var_1 = var_0.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::_id_B78C(self.owner, var_1))) {
    var_1 notify("destroyed_equipment");
    var_1 thread _id_0A9F::_id_7003("destroyed_equipment");
    var_1 thread scripts\mp\battlechatter_mp::_id_555B(self);
    self.owner thread _id_0A8D::_id_9137("dc_destroyed_s");
  }

  var_2 = scripts\engine\utility::ter_op(isDefined(var_0.objweapon), var_0.objweapon, "");

  if(var_0.attacker.team != self.team && isDefined(self._id_014E) && self._id_014E >= self.maxhealth) {
    var_0.attacker thread _id_07BC::createfieldupgradechallengeevent("destroy", var_2);
  }

  thread _id_EC9C(undefined, 1);
}

_id_EC9A() {
  if(!isDefined(self._id_ECE8)) {
    var_0 = scripts\mp\equipment::_id_5AEA("equip_tac_cover");
    scripts\mp\equipment::_id_153B(var_0, 0, "equip_tac_cover");
    scripts\common\utility::_id_158A(0);
    scripts\mp\utility\player::_id_1543(0);
    self._id_ECE8 = var_0;
  }
}

_id_EC9B() {
  if(isDefined(self._id_ECE8)) {
    var_0 = self._id_ECE8;
    scripts\mp\equipment::_id_153B(var_0, 1, "equip_tac_cover");
    scripts\common\utility::_id_158A(1);
    scripts\mp\utility\player::_id_1543(1);
    self._id_ECE8 = undefined;
  }
}

_id_ECAB(var_0) {
  var_1 = [var_0];

  if(isDefined(level._id_7177)) {
    foreach(var_3 in level._id_7177) {
      if(isDefined(var_3)) {
        var_1[var_1.size] = var_3;
      }
    }
  }

  if(isDefined(level._id_9F7E)) {
    foreach(var_6 in level._id_9F7E) {
      if(isDefined(var_6)) {
        var_1[var_1.size] = var_6;
      }
    }
  }

  if(isDefined(level._id_9EE2)) {
    foreach(var_9 in level._id_9EE2) {
      if(!isDefined(var_9)) {
        continue;
      }
      var_10 = isDefined(var_9.owner) && var_9.owner == var_0;
      var_11 = isDefined(var_9._id_5562) && var_9._id_5562 == "equip_tac_cover";
      var_12 = isDefined(var_9._id_5562) && var_9._id_5562 == "equip_ammo_box";

      if(!var_10 && (var_11 || var_12)) {
        continue;
      }
      var_1[var_1.size] = var_9;

      if(isDefined(var_9._id_3A5F)) {
        var_1[var_1.size] = var_9._id_3A5F;
      }
    }
  }

  return var_1;
}

_id_EC95(var_0) {
  if(isPlayer(var_0)) {
    return 0;
  }

  if(var_0 _meth_8163()) {
    return 0;
  }

  if(istrue(var_0._id_A1C0)) {
    return 0;
  }

  if(isDefined(var_0._id_011B) && isDefined(var_0._id_011B._id_5562) && var_0._id_011B._id_5562 == "equip_tac_cover") {
    return 0;
  }

  if(var_0.classname == "misc_turret") {
    return 0;
  }

  if(var_0.classname == "script_vehicle") {
    return 0;
  }

  return 1;
}

#using_animtree("scriptables");

_id_ECA4() {
  return _func_0079(%wm_deployable_cover_deploy);
}

_id_ECA5() {
  return 0;
}

_id_ECAE() {
  return _id_ECAD(undefined, undefined, undefined, 1);
}

_id_ECB1() {
  _id_ECB0(undefined, undefined, 1);
}

_id_EC9E(var_0) {
  self endon("death");
  var_0 endon("tac_cover_taken");
  var_0 scripts\engine\utility::waittill_any_2("joined_team", "disconnect");
  thread _id_EC9C(undefined, 0);
}