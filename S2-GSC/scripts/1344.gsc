/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1344.gsc
**************************************/

init() {
  setdvarifuninitialized("debug_falling_zombies", 0);
}

#using_animtree("zombie_generic");

_id_A26F(var_0, var_1, var_2) {
  var_3 = var_0._id_A27C;
  var_4 = "";
  var_5 = 0;
  var_6 = 0;

  if(!isDefined(var_1))
    var_1 = "spawn_drop";

  if(!isDefined(var_3)) {
    var_3 = spawnStruct();
    var_3._id_9919 = -1;
    var_3._id_0ED2 = [];
    var_3._id_0886 = [];
    var_0._id_A27C = var_3;
  }

  if(isDefined(var_3._id_0886[var_1]))
    return var_3._id_0886[var_1];

  var_7 = undefined;

  if(!isDefined(var_7))
    var_7 = 15;

  var_8 = _func_082(var_0.origin, var_7, 64, 64);
  var_0._id_487C = var_8;

  if(!_func_2E6(var_8)) {
    var_4 = "Sky Spawner not on Nav Mesh for entities of radius " + var_7 + "\n";
    var_9 = _func_2E1(var_8);
    var_5 = 1;
  }

  if(!var_5) {
    foreach(var_11 in maps\mp\agents\_scripted_agent_anim_util::_id_4081(var_1, "zombie_generic", #animtree)) {
      var_12 = _func_286(var_11);
      var_13 = maps\mp\agents\_scripted_agent_anim_util::_id_446A(var_11);

      if(!_func_066(var_11, "jump_start") || !_func_066(var_11, "jump_end")) {
        continue;
      }
      var_14 = maps\mp\agents\_scripted_agent_anim_util::_id_45B9(var_11, "jump_end");

      if(var_13 <= var_14) {}

      var_15 = _func_083(var_11, var_14, var_13);
      var_16 = _func_084(var_11, var_14, 0);
      var_15 = _func_112(var_15, (0, var_16, 0));
      var_17 = var_15 + var_8;

      if(_func_2E6(var_17) && _func_2DE(var_8, var_17)) {
        var_3._id_0ED2[var_12] = 1;
        var_6++;
        continue;
      }

      var_4 = var_4 + (var_12 + " does not fit on mesh for entities of radius " + var_7 + "\n");
    }
  }

  if(var_4 != "") {
    if(isDefined(var_2))
      var_4 = var_2 + "\n" + var_4;
  }

  var_3._id_0886[var_1] = var_6 > 0;
  return var_3._id_0886[var_1];
}

_id_ABA4(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");

  if(!(common_scripts\utility::_id_562E(var_4.ignorehidingskyspawner) && common_scripts\utility::_id_562E(level.st_142418))) {
    self _meth_805C();
    waitframe();
    self _meth_805B();
  }

  if(isDefined(var_4) && common_scripts\utility::_id_562E(var_4.asssassinspawn))
    [[level.assassin_validation_func]](var_4, var_3);
  else if(isDefined(var_4))
    _id_A26F(var_4, var_3);

  if(!isDefined(var_2))
    var_2 = 2500;

  var_2 = var_0[2] + var_2;
  var_6 = _func_082(var_0, self.radius, 64, 64);

  if(!isDefined(var_3))
    var_3 = "spawn_drop";

  var_7 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_3);
  var_8 = -1;
  var_9 = 0;
  var_10 = undefined;
  var_11 = undefined;
  var_12 = undefined;
  var_13 = undefined;
  var_14 = 0;
  var_15 = [];
  var_16 = undefined;
  var_14 = undefined;
  var_9 = undefined;
  var_17 = undefined;
  var_18 = self _meth_83DB(var_7);

  for(var_19 = 0; var_19 < var_18; var_19++)
    var_15[var_15.size] = var_19;

  var_15 = common_scripts\utility::array_randomize(var_15);

  foreach(var_21 in var_15) {
    var_13 = self _meth_83D8(var_7, var_21);
    var_22 = _func_286(var_13);

    if(isDefined(var_4) && isDefined(var_4._id_A27C) && isDefined(var_4._id_A27C._id_0886[var_3]) && !common_scripts\utility::_id_562E(var_4._id_A27C._id_0ED2[var_22])) {
      continue;
    }
    if(!_func_066(var_13, "jump_start") || !_func_066(var_13, "jump_end")) {
      continue;
    }
    var_17 = _func_065(var_13);
    var_9 = maps\mp\agents\_scripted_agent_anim_util::_id_45B9(var_13, "jump_start");
    var_9 = _func_0D5(var_9 * var_17 * 20) / (var_17 * 20);
    var_14 = maps\mp\agents\_scripted_agent_anim_util::_id_45B9(var_13, "jump_end");
    var_23 = (0, _func_084(var_13, var_14, 0), 0);
    var_11 = _func_111(var_6, var_1, (0, 0, 0), (0, 0, 0), _func_083(var_13, var_14, 0), var_23);
    var_24 = _func_112(_func_083(var_13, 0, var_9), var_11["angles"]);
    var_25 = _func_112(_func_083(var_13, 0, 1), var_11["angles"]);
    var_26 = var_11["origin"];
    var_27 = (0, 0, var_2 - var_26[2]);
    var_12 = var_26 + var_27;
    var_10 = var_12 + var_24;
    var_28 = _func_082(var_26 + var_25, self.radius);
    var_29 = (0, 0, 4);
    var_30 = self _meth_83EB(var_10, var_6 + var_29, self.radius, self._id_00BD, 1, 1);
    var_31 = _func_2E6(var_6, self) && _func_2DE(var_6, var_28, self);

    if(var_30["fraction"] < 1) {
      continue;
    }
    if(!var_31) {
      continue;
    }
    var_8 = var_21;
    var_11["origin"] = var_12;
    var_33 = var_24[2] + var_26[2] - var_6[2];
    var_34 = var_33 + var_27[2];
    var_16 = var_34 / var_33;
    break;
  }

  if(var_8 == -1) {
    _id_056D::_id_5A86();
    return;
  }

  if(isDefined(var_4))
    var_4 thread _id_17EE(self);

  self setOrigin(var_11["origin"], 1);
  self _meth_839C("anim deltas");
  self _meth_839B("face angle abs", var_11["angles"]);
  self _meth_839D("noclip");
  self _meth_83A2(1);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "FallingZombie");
  maps\mp\agents\_scripted_agent_anim_util::_id_8415(var_7, var_8);
  var_36 = var_17 * var_9;
  wait(var_36);
  var_37 = _func_0D9(1 / var_16);
  var_38 = (var_14 - var_9) * var_17;
  var_39 = var_38 / var_37;

  if(isDefined(var_5)) {
    var_40 = (var_5 - gettime()) * 0.001;
    var_39 = max(0.1, _func_0AF(var_39, var_40));
  }

  var_39 = _func_0D4(var_39 * 20 + 0.5) * 0.05;
  var_37 = var_38 / var_39;
  var_41 = 1 / _func_0DA(var_37);
  self _meth_839A(1, var_16);
  self _meth_85D4(var_37);
  wait(var_39);
  _id_0378::_id_8D74("zombie_fall_impact");
  var_42 = _func_22E(self.angles);
  playFX(common_scripts\utility::_id_44F5("ground_impact"), self.origin, var_42["forward"], var_42["up"]);
  self notify("zombie_fall_impact");
  self _meth_839A(1, 1);
  self _meth_85D4(1);
  self _meth_839D("gravity");
  var_43 = (1 - var_14) * var_17;
  wait(var_43);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "FallingZombie");
  self _meth_83A2(0);
  _id_0547::_id_84CB();

  if(_func_0AE(var_0[2] - self.origin[2]) > 32)
    _id_056D::_id_5A86();
}

_id_17EE(var_0) {
  self._id_3A1B = 1;
  var_0 common_scripts\utility::_id_A70A("death", "zombie_fall_impact");
  self._id_3A1B = undefined;
}