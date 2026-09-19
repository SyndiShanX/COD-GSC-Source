/**********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_nest_ee_hc_restore_pub_power.gsc
**********************************************************************/

main() {
  _id_0557::_id_4BC9("pub powered", "powering pub", "CONST_HC_ANALYTICS_PUB_POWERED");
  common_scripts\utility::flag_init("flag_nest_hc_ee_record_player_active");
  common_scripts\utility::flag_init("flag_nest_hc_ee_weathervane_switch_shot");
  level._id_A9FC = 3;
  var_0 = _id_52E7();
  var_0 thread _id_7EF1();
}

#using_animtree("destructibles");

_id_8B28(var_0, var_1) {
  var_2 = common_scripts\utility::random(self["switch_scriptables"]);
  var_3 = _func_065(%zmb_obj_glass_fuse_open);

  while(!_id_3B8F(self["weather_vane"], var_2, 30, 1)) {
    self["weather_vane"] _meth_82BA(15, 0.1);
    _id_0378::_id_8D74("aud_weathervane_rotate", "short");
    wait 0.3;
  }

  var_4 = vectortoangles(var_2.origin - self["weather_vane"].origin);
  var_5 = common_scripts\utility::_id_98E7(var_4[1] + 180 > 360, var_4[1] - 180, var_4[1] + 180);
  self["weather_vane"] _meth_82B8((self["weather_vane"].angles[0], var_5, self["weather_vane"].angles[2]), 0.15);
  _id_0378::_id_8D74("aud_weathervane_rotate", "short");
  wait 0.15;
  var_2 _meth_83FA("fuse", "open");
  wait(var_3);
  var_2 _meth_83FA("fuse", "open_idle");
  var_2 waittill("damage");
  _func_147(level._effect["zmb_ee_switch_sparks"], var_2, "tag_origin");
  var_2 _id_0378::_id_8D74("aud_switch_damaged");
  common_scripts\utility::flag_set("flag_nest_hc_ee_weathervane_switch_shot");
  thread _id_8B1C();
}

_id_3B8F(var_0, var_1, var_2, var_3) {
  var_4 = _func_0A7(var_2);
  var_5 = (var_1.origin[0], var_1.origin[1], var_0.origin[2]);
  var_6 = anglesToForward(var_0.angles);
  var_7 = var_5 - var_0.origin;

  if(isDefined(var_3))
    var_7 = var_0.origin - var_5;

  var_6 = var_6 * (1, 1, 0);
  var_7 = var_7 * (1, 1, 0);
  var_7 = vectorNormalize(var_7);
  var_6 = vectorNormalize(var_6);
  var_8 = vectordot(var_7, var_6);

  if(var_8 >= var_4)
    return 1;
  else
    return 0;
}

_id_8B1C() {
  self["electric_panel"] linktosynchronizedparent(self["waterwheel"]);
  level thread common_scripts\_exploder::_id_088E(223);
  self["waterwheel"] _meth_82BB(155, 12, 1, 1);
  thread _id_9419();
  self["waterwheel"] _id_0378::_id_8D74("aud_waterwheel");
  common_scripts\utility::_id_3C9F(_id_0557::_id_7838("5 Right Hand fuses", "lift outter rods"));
  self["electric_panel"] _meth_82C3(1);
  self["electric_panel"] thread maps\mp\gametypes\_damage::_id_8676(1, "head_gibs", maps\mp\mp_zombie_nest_ee_util::_id_9902, maps\mp\mp_zombie_nest_ee_util::_id_9903);
  self["electric_panel"] waittill("death", var_0, var_1, var_2);
  thread _id_77AB();
  playFX(level._effect["zmb_elec_coil_charge"], self["electric_panel"].origin, anglesToForward(self["electric_panel"].angles));
  self["electric_panel"] _id_0378::_id_8D74("aud_wonder_weapon_elec_coil_charge");
  thread _id_08B4();
}

_id_9419() {
  wait 12;
  level thread common_scripts\_exploder::_id_2A6D(223, undefined, 0);
}

_id_77AB() {
  var_0 = _func_21F("hc_publights", "targetname");

  foreach(var_2 in var_0) {
    var_2 _meth_83FA("lightpart", "flicker");
    wait 0.2;
    var_2 _meth_83FA("lightpart", "on");
  }
}

_id_08B4() {
  common_scripts\utility::flag_set("nest_ee_hc_radio_available");
  common_scripts\utility::flag_set("flag_nest_hc_ee_record_player_active");
  _id_0557::_id_4BC8("pub powered");
}

_id_7EF1() {
  switch (level._id_A9FC) {
    case 1:
      self["weather_vane"] thread _id_9485();
      break;
    case 2:
      level waittill("power_on");
      self["weather_vane"] thread _id_9485();
      self["weather_vane"] _id_A787(256);
      break;
    case 3:
      level waittill("power_on");
      self["weather_vane"] thread _id_9485();
      self["weather_vane"] _id_0547::_id_AC41(&"ZOMBIES_EMPTY_STRING");
      self["weather_vane"] waittill("player_used", var_0);
      break;
  }

  self["weather_vane"] notify("stop struggling");
  self["weather_vane"] _meth_82BA(360, 0.7);
  _id_0378::_id_8D74("aud_weathervane_rotate", "long");
  wait 0.75;
  thread _id_8B28();
}

_id_9485() {
  self endon("stop struggling");

  for(;;) {
    self _meth_82BA(-15.0, 0.6);
    _id_0378::_id_8D74("aud_weathervane_rotate", "struggle");
    wait 0.65;
    self _meth_82BA(15.0, 0.1);
    _id_0378::_id_8D74("aud_weathervane_rotate", "struggle");
    wait 0.155;
  }
}

_id_A787(var_0) {
  var_1 = 0;

  while(!var_1) {
    foreach(var_3 in level.players) {
      if(distance(var_3.origin, self.origin) < var_0) {
        var_1 = 1;
        break;
      }
    }

    wait 0.5;
  }
}

_id_52E7() {
  var_0 = common_scripts\utility::_id_46B5("hc_objective_weather_vane_hint_struct", "targetname");
  var_1 = _func_18E(var_0.target, "targetname");
  var_1._id_693D = common_scripts\utility::_id_46B5(var_1.target, "targetname");
  var_2 = common_scripts\utility::_id_46B5("objective_2_possible_locations_struct", "targetname");
  var_3 = _func_21F(var_2.target, "targetname");
  var_4 = common_scripts\utility::_id_44BD("objective_2_waterwheel_struct", "targetname");
  var_5 = common_scripts\utility::_id_44BD(var_4.target, "targetname");
  var_6 = common_scripts\utility::_id_46B5("objective_2_pub_panel", "targetname");
  var_7 = _func_18E(var_6.target, "targetname");
  var_8 = common_scripts\utility::_id_46B5("objective_2_pub_record_player", "targetname");
  var_9 = _func_21F("zmb_phonograph_model", "targetname");
  var_10 = var_9[0];
  var_11["weather_vane"] = var_1;
  var_11["switch_scriptables"] = var_3;
  var_11["waterwheel"] = var_5;
  var_11["electric_panel"] = var_7;
  var_11["record_player"] = var_10;
  return var_11;
}