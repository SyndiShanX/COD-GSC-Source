/***********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_nest_ee_hc_tools_of_the_trade.gsc
***********************************************************************/

main() {
  common_scripts\utility::flag_init("flag_nest_hc_ee_sword_acquired");
  level._id_9A93 = 1;
  var_0 = _id_52EC();
  var_0 thread _id_9A92();
  _id_0557::_id_4BC9("r.medal A get");
  _id_0557::_id_4BC9("r.medal B get");
  _id_0557::_id_4BC9("r.sword get", "obtaining sword", "CONST_HC_ANALYTICS_R_SWORD_GET");
  _id_0557::_id_4BC9("circuit found");
  _id_0557::_id_4BC9("circuit shot by tesla", "finding and shooting circuit", "CONST_HC_ANALYTICS_CIRCUIT_SHOT");
}

_id_52EC() {
  var_0 = common_scripts\utility::_id_46B5("nest_ee_hc_com_fuse_struct", "targetname");
  var_1 = _func_18E(var_0.target, "targetname");
  var_2 = _func_18E("nest_ee_hc_com_door_trig", "targetname");
  level._id_6874 = 0;
  var_3 = common_scripts\utility::_id_46B7("nest_ee_hc_safe_struct", "targetname");

  foreach(var_5 in var_3) {
    var_6 = common_scripts\utility::_id_44BE(var_5.target, "targetname");
    var_7 = _func_21F(var_5.target, "targetname");
    var_5._id_801E = var_7[0];
    var_5._id_3B9C = [];

    for(var_8 = 0; var_8 < 5; var_8++)
      var_5._id_3B9C[var_8] = undefined;

    foreach(var_10 in var_6) {
      switch (var_10._id_0165) {
        case "nest_ee_hc_safe_fingerprint":
          var_5._id_3B9C[_id_0547::_id_9470(var_10._id_819A) - 1] = var_10;
          break;
        case "nest_ee_hc_safe_trigger":
          var_5._id_9D65 = var_10;
          var_5._id_9D65 common_scripts\utility::_id_9D9F();
          break;
        case "nest_ee_hc_safe_sentry_trig_offset":
          var_5._id_9DA2 = var_10;
          break;
        case "nest_ee_hc_safe_door":
          var_5._id_8021 = var_10;
          break;
        case "nest_ee_hc_safe_blood_message":
          var_5._id_17F7 = var_10;
          var_5._id_17F7 _meth_805C();
          break;
        case "nest_ee_hc_safe_raven_key":
          var_5._id_7A79 = var_10;
          var_5._id_7A79 _meth_805C();
          break;
        default:
          break;
      }
    }
  }

  var_13 = getEntArray("zmb_bloodraven_key_inserts", "targetname");

  foreach(var_15 in var_13)
  var_15 _meth_805C();

  var_17 = common_scripts\utility::_id_46B5("nest_ee_hc_com_power_struct", "targetname");
  var_18 = _func_18E(var_17.target, "targetname");
  var_19 = common_scripts\utility::_id_46B5("nest_ee_hc_com_power_door_struct", "targetname");
  var_20 = _func_18E(var_19.target, "targetname");
  var_21["original_objective_trigs"] = level._id_358E;
  var_21["fuse_trigger"] = var_2;
  var_21["secret_door"] = var_1;
  var_21["power_box"] = var_18;
  var_21["power_box_door"] = var_20;
  var_21["sentry_safes"] = var_3;
  var_21["secret_door"] _id_857F();
  return var_21;
}

_id_8B98() {
  return 1;
}

_id_9A92() {
  self["fuse_trigger"] common_scripts\utility::_id_9D9F();
  common_scripts\utility::_id_3C9F(_id_0557::_id_7838("5 Right Hand fuses", "tower confirm hand"));
  _id_A64A(self["original_objective_trigs"]);
  thread _id_7EFB();
}

_id_760C() {
  var_0 = maps\mp\mp_zombie_nest_ee_cart::_id_8A2B("light_zm_objective", "light_zm_puzzle", "on", "lightoff", "puzzlelight");
  var_1 = maps\mp\mp_zombie_nest_ee_cart::_id_8A2B("beam_zm_objective", "light_zm_lgtbeam", "lightbeam", "lightbeamoff", "glow");
  self["power_box_door"] thread maps\mp\mp_zombie_nest_ee_hc_raven_weapon_upgrades::_id_6C01();
  playFX(common_scripts\utility::_id_44F5("zmb_ee_switch_sparks"), self["power_box"].origin, anglesToForward(self["power_box"].angles), anglestoup(self["power_box"].angles));
  self["power_box"]._id_0A33 = common_scripts\utility::_id_0F73(var_0, var_1);
  self["power_box"] _meth_82C3(1);
  self["power_box"]._id_8259 = self;
  self["power_box"] thread maps\mp\gametypes\_damage::_id_8676(1, "head_gibs", maps\mp\mp_zombie_nest_ee_util::_id_9902, ::_id_2575);
}

_id_2575(var_0, var_1, var_2, var_3) {
  var_4 = common_scripts\utility::_id_46B5("nest_ee_hc_com_power_struct", "targetname");
  var_5 = _func_18E(var_4.target, "targetname");
  var_6 = anglesToForward(var_5.angles);

  if(common_scripts\utility::_id_562E(level._id_665E))
    return 1;

  if(issubstr(var_1, "teslagun")) {
    _id_0557::_id_4BC8("circuit shot by tesla");

    if(!isDefined(self._id_177E) || level._id_A980 > self._id_177E) {
      if(!isDefined(self._id_177E))
        self._id_177E = level._id_A980;

      playFX(level._effect["zmb_elec_coil_charge"], var_5.origin, var_6);
      var_5 _id_0378::_id_8D74("aud_wonder_weapon_elec_coil_charge");
      thread _id_4BD0();
    } else if(!(self._id_177E > level._id_A980)) {}
  }

  return 0;
}

_id_4BD0() {
  if(isDefined(self._id_0A33))
    level thread maps\mp\mp_zombie_nest_ee_cart::_id_A0EF(self._id_0A33, 0);

  level thread _id_7E3E();
  common_scripts\utility::flag_set("flag_bunker_lights_off");
  common_scripts\utility::flag_set("flag_bunker_lights_off");
  _id_0378::_id_8D74("aud_bunker_lights", "off");
  level._id_9A93 = 1;
  wait 30;
  common_scripts\utility::_id_3C7B("flag_bunker_lights_off");
  _id_0378::_id_8D74("aud_bunker_lights", "on");
  level._id_9A93 = 0;
  level thread _id_4D0A();

  if(isDefined(self._id_0A33))
    level thread maps\mp\mp_zombie_nest_ee_cart::_id_A0EF(self._id_0A33, 1);

  self._id_177E = level._id_A980;
}

_id_4D0A() {
  level notify("com lights on");
  waitframe();
  var_0 = common_scripts\utility::_id_46B7("nest_ee_hc_safe_struct", "targetname");

  foreach(var_2 in var_0) {
    if(!common_scripts\utility::_id_562E(var_2._id_8026))
      var_2._id_8021 thread maps\mp\mp_zombie_nest_ee_hc_raven_weapon_upgrades::_id_2441();
  }
}

_id_7E3E() {
  var_0 = common_scripts\utility::_id_46B7("nest_ee_hc_safe_struct", "targetname");

  foreach(var_2 in var_0) {
    if(!common_scripts\utility::_id_562E(var_2._id_8026)) {
      var_2._id_8021 thread maps\mp\mp_zombie_nest_ee_hc_raven_weapon_upgrades::_id_6C01();
      var_2 thread _id_11C0();
    }
  }
}

_id_11C0() {
  thread _id_8027();
  _id_057E::_id_0984(self, self._id_9DA2, ::_id_6BA1);
}

_id_8027() {
  level waittill("com lights on");
  _id_057E::_id_7CC2(self);
}

#using_animtree("destructibles");

_id_6BA1(var_0, var_1) {
  var_0._id_8026 = 1;
  var_0._id_8026 = 1;
  var_0._id_2E71 = [];
  var_2 = var_0 _id_80D6();
  var_0._id_8026 = 1;
  var_0._id_17F7 _meth_805B();
  var_0._id_9D65 common_scripts\utility::_id_9DA3();
  _id_057E::_id_7CC2(self);
  var_0 _id_A680(var_2, var_0._id_9D65, var_0._id_2E71);
  var_0._id_7A79 _meth_805B();
  var_0._id_801E _meth_83FA("machine_main", "opening");
  wait(_func_065(%zmb_ob_safe_open));
  var_0._id_801E _meth_83FA("machine_main", "opened");
  var_0._id_9D65 waittill("trigger", var_3);
  var_3 _id_0378::_id_8D74("zmb_ravens_key_pickup");
  var_0._id_7A79 _meth_805C();
  _id_7E67();
}

_id_80D6() {
  var_0 = [];

  for(var_1 = 0; var_1 < 5; var_1++)
    var_0[var_1] = randomint(10);

  for(var_1 = 0; var_1 < var_0.size; var_1++)
    self._id_801E _meth_83FA("dial_0" + (var_1 + 1), "idle_" + var_0[var_1]);

  wait 0.15;

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    self._id_2E71[var_1] = self._id_3B9C[var_1].origin;
    self._id_3B9C[var_1]._id_65DB = spawn("script_model", self._id_2E71[var_1]);
    self._id_3B9C[var_1]._id_65DB.angles = self._id_3B9C[var_1].angles;
    self._id_3B9C[var_1]._id_65DB setModel("zmb_finger_print_0" + (randomint(4) + 1));
  }

  var_2 = [];

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_3 = self._id_801E _meth_8181("dial_0" + (var_1 + 1));
    var_4 = self._id_801E gettagorigin("dial_0" + (var_1 + 1));
    var_5 = self._id_3B9C[var_1]._id_65DB.origin;
    var_6 = distance(var_4, var_5);
    self._id_3B9C[var_1]._id_65DB _meth_8055(self._id_801E, "dial_0" + (var_1 + 1));
  }

  return var_0;
}

_id_A680(var_0, var_1, var_2) {
  var_3 = [];

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    var_3[var_4] = randomint(10);
    self._id_801E _meth_83FA("dial_0" + (var_4 + 1), "idle_" + var_3[var_4]);
  }

  var_5 = 0;

  while(!var_5) {
    var_1 waittill("trigger", var_6);
    var_7 = _id_3B8A(var_6, var_2, 5);
    var_3[var_7] = common_scripts\utility::_id_98E7(var_3[var_7] < 9, var_3[var_7] + 1, 0);
    self._id_801E _meth_83FA("dial_0" + (var_7 + 1), "idle_" + var_3[var_7]);
    wait 0.15;
    var_8 = 0;

    for(var_4 = 0; var_4 < var_0.size; var_4++) {
      if(var_0[var_4] == var_3[var_4])
        var_8++;
    }

    if(var_8 == var_0.size)
      return;
  }
}

_id_3B8A(var_0, var_1, var_2) {
  var_3 = -1;
  var_4 = 0;

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    var_6 = _func_0A7(var_2);
    var_7 = anglesToForward(var_0.angles);
    var_8 = var_1[var_5] - var_0.origin;
    var_7 = var_7 * (1, 1, 0);
    var_8 = var_8 * (1, 1, 0);
    var_8 = vectorNormalize(var_8);
    var_7 = vectorNormalize(var_7);
    var_9 = vectordot(var_8, var_7);

    if(var_9 > var_3) {
      var_3 = var_9;
      var_4 = var_5;
    }
  }

  return var_4;
}

_id_7E67() {
  level._id_6874++;
  var_0 = getEntArray("zmb_bloodraven_key_inserts", "targetname");
  var_0[level._id_6874 - 1] _meth_805B();

  switch (level._id_6874) {
    case 1:
      _id_0557::_id_4BC8("r.medal A get");
      break;
    case 2:
      _id_0557::_id_4BC8("r.medal B get");
      break;
  }

  if(level._id_6874 < 2) {
    return;
  }
  var_1 = _func_18E("nest_hc_sword_door_trig", "targetname");
  var_2 = _func_18E(var_1.target, "targetname");
  var_2._id_6C02 = 0;
  level._id_665E = 1;

  for(;;) {
    var_1 waittill("trigger", var_3);

    if(!var_2._id_6C02) {
      var_2 _id_0378::_id_8D74("aud_open_raven_door");

      foreach(var_5 in var_0)
      var_5 _meth_82B9(90, 2);

      wait 2;

      foreach(var_5 in var_0)
      var_5 _meth_82B4(-128, 4);

      var_2 _meth_82B4(-128, 4);
      var_2._id_6C02 = 1;
    }

    var_3 _id_6FDA();
    _id_0378::_id_8D74("aud_pickup_raven_sword");
  }
}

_id_6FDA() {
  var_0 = 0;

  if(_id_057E::_id_314D(self))
    var_0 = 1;

  _id_0586::_id_078C("raven_sword_zm");
  _id_0586::_id_078E("raven_sword_zm");
  common_scripts\utility::flag_set("flag_nest_hc_ee_sword_acquired");
  _id_0557::_id_4BC8("r.sword get");
  getswordreward();
}

_id_42EF() {
  return "flag_nest_hc_ee_sword_acquired";
}

_id_7EFB() {
  var_0 = 0;
  var_1 = undefined;
  var_2 = 0;

  while(!var_0) {
    self["secret_door"] _id_8580();
    self["fuse_trigger"] common_scripts\utility::_id_9DA3();
    var_0 = _id_11C1(30);

    if(!var_0) {
      self["fuse_trigger"] common_scripts\utility::_id_9D9F();
      self["secret_door"] _id_857F();
      _id_A64A(self["original_objective_trigs"]);
    }
  }

  self["secret_door"] _id_857C();
  self["fuse_trigger"] common_scripts\utility::_id_9D9F();
  _id_0557::_id_4BC8("circuit found");
  thread _id_760C();
}

_id_857D() {
  self _meth_83FA("part_dial", "dial_to_on");
  wait(_func_065(%zmb_circuit_puzzle_dial_off_to_on));
  self _meth_83FA("part_dial", "dial_on");
}

_id_857E() {
  self _meth_83FA("part_dial", "dial_to_off");
  wait(_func_065(%zmb_circuit_puzzle_dial_on_to_off));
  self _meth_83FA("part_dial", "dial_off");
}

_id_8580() {
  self _meth_83FA("cbreaker", "opening");
  wait(_func_065(%zmb_circuit_puzzle_open));
  self _meth_83FA("cbreaker", "opened_idle");
  thread _id_8582();
}

_id_857F() {
  thread _id_8583();
  self _meth_83FA("cbreaker", "closing");
  wait(_func_065(%zmb_circuit_puzzle_open));
  self _meth_83FA("cbreaker", "closed");
}

_id_857C() {
  _id_857D();
  thread _id_8581();
}

_id_8583() {
  self _meth_83FA("green_light", "off");
  self _meth_83FA("red_light", "off");
}

_id_8581() {
  self _meth_83FA("green_light", "on");
  self _meth_83FA("red_light", "off");
}

_id_8582() {
  self _meth_83FA("green_light", "off");
  self _meth_83FA("red_light", "on");
}

_id_11C1(var_0) {
  self["fuse_trigger"] endon("time_out");
  thread _id_9A01(var_0);
  self["fuse_trigger"] waittill("trigger", var_1);
  return isDefined(var_1);
}

_id_9A01(var_0) {
  wait(var_0);
  self["fuse_trigger"] notify("trigger", undefined);
}

_id_A64A(var_0) {
  var_1 = 0;
  maps\mp\mp_zombie_nest_ee_enigma::_id_7D6C();
  maps\mp\mp_zombie_nest_ee_enigma::_id_7AAC();

  while(!_id_3789(var_0)) {
    var_3 = common_scripts\utility::_id_A70B(var_0, "trigger");
    var_3 _id_0378::_id_8D74("aud_enigma_switch_activate");
    var_3._id_5F59 thread maps\mp\mp_zombie_nest_ee_enigma::_id_8717();
    var_3._id_08A9 = 1;
    common_scripts\utility::flag_set(var_3._id_8260);
    var_3 common_scripts\utility::_id_9D9F();
  }
}

_id_3789(var_0) {
  var_1 = 0;

  foreach(var_3 in var_0) {
    if(common_scripts\utility::_id_562E(var_3._id_08A9))
      var_1++;
  }

  return var_1 == var_0.size;
}

getswordreward() {
  if(!isDefined(level.players_have_aquired_hc_sword))
    level.players_have_aquired_hc_sword = 1;
  else
    return;

  foreach(var_1 in level.players)
  var_1 _id_054C::_id_AC23("ravensword");
}