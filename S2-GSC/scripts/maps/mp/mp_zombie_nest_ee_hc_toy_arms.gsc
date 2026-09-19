/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_nest_ee_hc_toy_arms.gsc
*************************************************************/

main() {
  level._id_665D = [];
  level._id_665F = [randomint(12) + 1, randomint(12) + 1, randomint(12) + 1];
  common_scripts\utility::flag_init("flag_nest_hc_ee_record_acquired");
  var_0 = _id_52EE();
  _id_0557::_id_4BC9("toy 0 get");
  _id_0557::_id_4BC9("toy 1 get");
  _id_0557::_id_4BC9("toy 2 get");
  _id_0557::_id_4BC9("toy record get", "obtaining toy record", "CONST_HC_ANALYTICS_TOY_RECORD_GET");
  _id_0557::_id_4BC9("fire monkey down", "grabbing toys", "CONST_HC_ANALYTICS_TOYS_GOTTEN");
  level thread _id_171D(var_0);
  level thread _id_21AF(var_0["trigger"]);
  level thread _id_7E3C(var_0["reward_pickup"], var_0["trigger"]);
}

_id_47A4() {
  level._id_665D[0] = 1;
  level._id_665D[1] = 2;
  level._id_665D[2] = 3;
}

_id_7E3C(var_0, var_1) {
  var_0 hide();
  level waittill("hc_nest_toy_obj_complete");
  var_2 = _getent("nest_hc_record_drawer", "targetname");
  var_3 = common_scripts\utility::_id_46B5(var_2.target, "targetname");
  var_0 show();
  var_0 linktosynchronizedparent(var_2);
  var_2 _id_0378::_id_8D74("aud_spinning_top_drawer_open");
  var_2 moveto(var_3.origin, 1.5, 0, 0.5);
  wait 1.5;
  var_0 unlink();
  var_0 _id_A665(var_1);
  common_scripts\utility::flag_set("flag_nest_hc_ee_record_acquired");
  var_0 delete();
  level._id_4BD3 = 1;
  var_2 _id_0378::_id_8D74("aud_spinning_top_record_obtained");
  _id_0557::_id_4BC8("toy record get");
  getrecordreward();
}

_id_A665(var_0) {
  for(var_1 = 0; !var_1; var_1 = maps\mp\_utility::_id_3B8E(var_2, self, 15))
    var_0 waittill("trigger", var_2);
}

_id_8F6F(var_0, var_1) {
  var_2 = spawn("script_model", self.origin);
  var_2 setModel("zmb_ob_topper_0" + self._id_0165);
  var_2.angles = self.angles;
  var_2.target = self.target;
  var_2._id_0F5E = var_0;
  var_2.targetname = "nest_ee_hc_shootable_arm_spawn";
  var_2 thread _id_8B1B();

  if(common_scripts\utility::_id_562E(var_1))
    var_2 hudoutlineenable(var_0, 0);
}

_id_8573(var_0, var_1) {
  var_2 = common_scripts\utility::_id_46B7(var_0, "targetname");

  foreach(var_4 in var_2) {
    var_5 = common_scripts\utility::_id_44BE(var_4.target, "targetname");

    foreach(var_7 in var_5) {
      if(!isDefined(var_7._id_0165)) {
        continue;
      }
      switch (var_7._id_0165) {
        case "hc_dial_1":
          var_4._id_4BCC = var_7;
          break;
        case "hc_dial_2":
          var_4._id_4BCD = var_7;
          break;
        case "hc_rotor_holder":
          var_4._id_4BD2 = var_7;
          break;
        case "hc_rotor_bow":
          var_4._id_4BD1 = var_7;
          break;
        case "hc_dial_light":
          var_4._id_4BCE = var_7;
          break;
      }
    }
  }

  var_10 = common_scripts\utility::random(var_2);

  foreach(var_4 in var_2) {
    if(var_4 == var_10) {
      continue;
    }
    var_4._id_4BCC delete();
    var_4._id_4BCD delete();
    var_4._id_4BD2 delete();
    var_4._id_4BD1 delete();
  }

  var_10 thread _id_7A50(level._id_665F[var_1]);
  return var_10;
}

_id_8BD3() {
  if(isDefined(self._id_4BCE)) {
    var_0 = _id_0547::_id_8FBA(self._id_4BCE, "zmb_hc_rotor_lighting_fx");
    _triggerfx(var_0);
  }
}

_id_171D(var_0) {
  var_1 = 0;
  var_2 = _id_8573("nest_ee_hc_rotor_red", 2);
  var_3 = _id_8573("nest_ee_hc_rotor_yellow", 0);
  var_4 = _id_8573("nest_ee_hc_rotor_blue", 1);
  waitframe();
  var_2 _id_8BD3();
  var_3 _id_8BD3();
  var_4 _id_4CEA();

  foreach(var_7 in var_0["shootable_arms"]) {
    var_14 = var_1;
    var_1++;
    common_scripts\utility::flag_init("flag_nest_hc_ee_has_arm_" + var_1);
    var_8 = common_scripts\utility::_id_46B7(var_7.target, "targetname");
    var_15 = common_scripts\utility::random(var_8);
    var_15 _id_8F6F(var_14);
  }

  var_17 = _id_4421();
  level._id_47CC = 0;
  var_18 = [];

  for(var_19 = 0; var_19 < 3; var_19++) {
    var_18[var_19] = spawn("script_model", var_0["trigger"]._id_65DD[var_19].origin);
    var_18[var_19].targetname = "nest_ee_hc_top_interact";
    var_18[var_19]._id_65E9 = "zmb_ob_topper_0" + (var_19 + 1);
    var_18[var_19] setModel("tag_origin");
    var_18[var_19].angles = var_17[5].angles;
    var_18[var_19]._id_65E0 = 6;
  }

  var_18[0]._id_65E5 = 0;
  var_18[1]._id_65E5 = 2;
  var_18[2]._id_65E5 = 1;
  var_0["trigger"]._id_7EF9 = var_18;
  var_0["trigger"] thread _id_6803(var_18);

  foreach(var_21 in var_18)
  var_21 thread _id_7EEC(var_17);

  var_23 = _getent("firewell_grab_test", "targetname");
  var_24 = _getent(var_23.target, "targetname");
  level thread _id_4833(var_23, var_4);
}

_id_4CEA() {
  self._id_4BCC hide();
  self._id_4BCD hide();
  self._id_4BD2 hide();
  self._id_4BD1 hide();
}

_id_8BD2() {
  self._id_4BCC show();
  self._id_4BCD show();
  self._id_4BD2 show();
  self._id_4BD1 show();
}

_id_7A50(var_0) {
  var_1[0] = self._id_4BCC;
  var_1[1] = self._id_4BCD;
  var_2 = [0, 0];

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = 0;

    for(var_5 = _pow(10, var_2.size - var_3); var_0 >= var_5 / 10; var_4++)
      var_0 = var_0 - var_5 / 10;

    var_2[var_3] = var_4;
  }

  var_6 = 36.0;

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_7 = var_6 * (var_2[var_3] - 1);
    var_1[var_3] rotateby((0, 0, -1 * var_7), 0.5);
  }
}

_id_6803(var_0) {
  for(;;) {
    self waittill("trigger", var_1);

    foreach(var_3 in var_0) {
      if(maps\mp\_utility::_id_3B8E(var_1, var_3, 15)) {
        var_3 notify("top_interact", var_1);
        break;
      }
    }
  }
}

_id_7EEC(var_0) {
  level endon("hc_nest_toy_obj_complete");
  self._id_65E0 = 6;
  self.angles = var_0[5].angles;
  var_1 = 0;
  var_2 = _getglass("window_shatter_toyshop");

  while(!var_1) {
    self waittill("top_interact", var_3);

    if(isDefined(var_2))
      _destroyglass(var_2);

    if(common_scripts\utility::_id_0F79(level._id_665D, self._id_65E5 + 1)) {
      var_1 = 1;
      level._id_665D = common_scripts\utility::_id_0F93(level._id_665D, self._id_65E5 + 1);
      _id_0378::_id_8D74("aud_spinning_top_place");
    }
  }

  self setModel(self._id_65E9);

  for(;;) {
    self waittill("top_interact", var_3);
    self._id_65E0 = common_scripts\utility::_id_98E7(self._id_65E0 == 12, 1, self._id_65E0 + 1);
    var_4 = var_0[self._id_65E0 - 1].angles;
    _id_0378::_id_8D74("aud_spinning_top_turn");
    self rotateby((-30, 0, 0), 0.05);
    waitframe();

    if(self._id_65E0 == 9)
      self.angles = var_4;

    level notify("nest_ee_arm_code_check");
  }
}

_id_4833(var_0, var_1) {
  var_0 _id_0547::_id_AC41(&"ZOMBIES_EMPTY_STRING");
  var_0 waittill("player_used");
  var_2 = common_scripts\utility::_id_46B5("monkey_hc_dropper", "targetname");
  var_3 = common_scripts\utility::_id_46B7(var_2.target, "targetname");
  var_4 = _getscriptablearray("monkey_destructible", "targetname");
  var_5 = var_4[0];
  var_5 thread _id_2DB2();

  foreach(var_7 in var_3) {
    var_8 = undefined;

    switch (var_7._id_0165) {
      case "zmb_code_dial_01":
        var_8 = "zmb_code_dial_01";
        break;
    }

    if(!isDefined(var_8)) {
      continue;
    }
    var_9 = spawn("script_model", var_7.origin);
    var_9 setModel(var_8);
    var_9.angles = var_7.angles;
  }

  var_1 _id_8BD2();
  var_1 _id_8BD3();
  _id_0557::_id_4BC8("fire monkey down");
}

_id_2DB2() {
  self setscriptablepartstate("Sign", "Fractured");
  waitframe();
  _physicsexplosionsphere(self.origin, 100, 90, 1);
}

_id_8B1B() {
  self setcandamage(1);
  self waittill("damage");
  _id_0378::_id_8D74("aud_spinning_top_shot");
  self._id_65E2 = common_scripts\utility::_id_46B5(self.target, "targetname");
  _id_348C(self._id_65E2);
  _id_0378::_id_8D74("aud_spinning_top_fall");
  _id_0547::_id_AC41(&"ZOMBIES_EMPTY_STRING", (0, 0, 64));
  self waittill("player_used", var_0);

  switch (self._id_0F5E) {
    case 0:
      _id_0557::_id_4BC8("toy 0 get");
      break;
    case 1:
      _id_0557::_id_4BC8("toy 1 get");
      break;
    case 2:
      _id_0557::_id_4BC8("toy 2 get");
      break;
  }

  level._id_665D = common_scripts\utility::_id_0F6F(level._id_665D, self._id_0F5E + 1);
  common_scripts\utility::flag_set("flag_nest_hc_ee_has_arm_" + (self._id_0F5E + 1));
  _id_0547::_id_AC40();
  self delete();
}

_id_348C(var_0) {
  var_1 = (0, 0, -800);
  var_2 = var_0.origin - self.origin;
  var_3 = _sqrt(_abs(var_2[2] * 2 / 800));
  var_4 = 1 / var_3;
  var_5 = var_2 * (var_4, var_4, 0);
  self movegravity(var_5, var_3);
  self rotateby((720, 720, 720), var_3, 0, var_3 / 2);
  wait(var_3);
  self.origin = var_0.origin;

  if(isDefined(var_0.angles))
    self.angles = var_0.angles;
}

_id_21AF(var_0) {
  level endon("hc_nest_toy_obj_complete");
  var_1 = 0;

  while(!isDefined(var_0._id_7EF9))
    waitframe();

  while(var_1 != var_0._id_7EF9.size) {
    level waittill("nest_ee_arm_code_check");
    var_1 = 0;

    for(var_2 = 0; var_2 < var_0._id_7EF9.size; var_2++) {
      if(var_0._id_7EF9[var_2]._id_65E0 == level._id_665F[var_2])
        var_1++;
    }
  }

  level notify("hc_nest_toy_obj_complete");
}

_id_42F3() {
  return "flag_nest_hc_ee_record_acquired";
}

_id_40AC(var_0) {
  return "flag_nest_hc_ee_has_arm_" + var_0;
}

_id_6FCD() {
  var_0 = spawn("trigger_radius", self.origin, 0, 64, 64);
  var_1 = undefined;

  while(!isDefined(var_1) || !isPlayer(var_1))
    var_0 waittill("trigger", var_1);

  var_0 delete();
  self delete();
  var_1 thread _id_057D::_id_4766();
}

_id_4421() {
  var_0 = [];

  for(var_1 = 0; var_1 < 12; var_1++)
    var_0[var_1] = common_scripts\utility::_id_46B5(var_1 + 1 + "oc", "script_noteworthy");

  return var_0;
}

_id_52EE() {
  var_0 = common_scripts\utility::_id_46B5("nest_ee_hc_arm_models_struct", "targetname");
  var_1 = common_scripts\utility::_id_46B7(var_0.target, "targetname");
  var_2 = _getent("nest_ee_hc_arm_trig", "targetname");
  var_3 = maps\mp\mp_zombie_nest_ee_util::_id_44C8("nest_ee_hc_arm_model_window", 1);
  var_2._id_65DD = var_3;
  var_4 = [];
  var_4["trigger"] = var_2;
  var_4["shootable_arms"] = var_1;
  var_4["reward_pickup"] = _getent("nest_hc_record_spawn", "targetname");
  return var_4;
}

getrecordreward() {
  foreach(var_1 in level.players)
  var_1 _id_054C::_id_AC23("record");
}