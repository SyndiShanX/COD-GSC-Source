/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_nest_pneumos.gsc
******************************************************/

main() {
  common_scripts\utility::flag_init("flag_all_tubes_ridden");
  common_scripts\utility::flag_init("flag_pap_available");
  common_scripts\utility::flag_init("flag_cage_not_moving");
  common_scripts\utility::flag_init("flag_cage_power_outage_triggered");
  common_scripts\utility::flag_init("flag_pneumos_activated");
  level._id_7532[0] = common_scripts\utility::_id_46B5("pneumo_start_1", "targetname");
  level thread _id_6C09();

  if(!isDefined(level._id_7532[0])) {
    return;
  }
  level._id_7532[1] = common_scripts\utility::_id_46B5("pneumo_start_2", "targetname");
  level._id_7532[2] = common_scripts\utility::_id_46B5("pneumo_start_3", "targetname");
  var_0 = _getEnt("pneumo_box_origin", "targetname");
  var_1 = getEntArray("pneumo_tubes_geo", "targetname");

  if(level._id_7532.size > 0) {
    foreach(var_3 in level._id_7532) {
      var_3._id_9E42 = 0;
      var_3._id_3A6A = 0;
      var_3._id_3A6B = 0;
      var_4 = common_scripts\utility::_id_44BE(var_3.target, "targetname");

      foreach(var_6 in var_4) {
        if(!isDefined(var_6._id_0165)) {
          continue;
        }
        var_7 = var_6._id_0165;

        switch (var_7) {
          case "tube_trig":
            var_3._id_A1F7 = var_6;
            break;
          case "tube_fence":
            var_3._id_3A68 = var_6;
            break;
          case "tube_fence_blocker":
            var_3._id_3A69 = var_6;
            break;
          default:
            break;
        }
      }

      var_9 = common_scripts\utility::_id_46B5(var_3._id_3A68.target, "targetname");
      var_10 = maps\mp\mp_zombie_nest_ee_util::_id_44C8("pnuemo_tube_node_begin", 1);
      var_10 = common_scripts\utility::_id_0F6F(var_10, var_9);
      var_3._id_6EB7 = var_10;
      var_3 thread _id_8A3B(var_0);
    }
  }

  thread _id_9E43();
  common_scripts\utility::flag_set("flag_cage_not_moving");
  level._id_6E33 = _id_8A0B();
  var_12 = common_scripts\utility::_id_46B7("cage_button", "targetname");

  foreach(var_14 in var_12) {
    var_15 = common_scripts\utility::_id_44BE(var_14.target, "targetname");

    foreach(var_6 in var_15) {
      if(!isDefined(var_6._id_0165)) {
        continue;
      }
      var_7 = var_6._id_0165;

      switch (var_7) {
        case "cage_button_trig":
          var_14._id_1E2C = var_6;

          if(_id_0547::_id_5565(var_14._id_0165, "first_button")) {
            var_14._id_1E2C setHintString(&"ZOMBIE_NEST_PNEUMO_TUBE_ACTIVATE");
          } else {
            var_14._id_1E2C setHintString(&"ZOMBIES_SWITCH_HINT_GENERIC_BUTTON");
          }

          break;
        case "cage_button_model":
          var_14._id_1E2B = var_6;
          break;
        case "cage_button_light":
          var_14._id_1E2A = var_6;
          break;
        case "cage_light":
          var_14._id_1E2F = var_6;
          break;
      }
    }

    var_14 thread _id_1DE0();
  }

  level._id_1E2E = 0;
  level._id_1E30 = level._id_7532.size + 1;
  thread _id_203D();
  level._id_6E33 thread _id_1E34();
}

#using_animtree("destructibles");

_id_6C09() {
  var_0 = _getscriptablearray("scriptable_pnuemo_tube", "targetname");

  foreach(var_2 in var_0) {
    var_2 setscriptablepartstate("tube_model", "closing");
  }

  wait(_getanimlength(%zmb_pn_tube_01_door_close));

  foreach(var_2 in var_0) {
    var_2 setscriptablepartstate("tube_model", "closed");
  }

  common_scripts\utility::_id_3C9F("flag_pneumos_activated");

  foreach(var_2 in var_0) {
    var_2 setscriptablepartstate("tube_model", "opening");
  }

  wait(_getanimlength(%zmb_pn_tube_01_door_open));

  foreach(var_2 in var_0) {
    var_2 setscriptablepartstate("tube_model", "opened");
  }
}

_id_9E43() {
  var_0 = [];

  while(!common_scripts\utility::_id_3C77("flag_all_tubes_ridden")) {
    var_1 = 1;
    level waittill("pneumo_tube_ridden", var_2);

    if(!common_scripts\utility::_id_0F79(var_0, var_2)) {
      var_2._id_9E42 = 1;
      var_0[var_0.size] = var_2;
    }

    foreach(var_4 in level._id_7532) {
      if(var_4._id_9E42 == 0) {
        var_1 = 0;
      }
    }

    if(var_1) {
      common_scripts\utility::flag_set("flag_all_tubes_ridden");
      break;
    }

    waitframe();
  }
}

_id_64E1() {
  if(self._id_3A6B || self._id_3A6A) {
    return;
  } else {
    self._id_3A6B = 1;
    self._id_3A68 scriptmodelplayanim(self._id_3A68.setflaggedanimknoball);
    wait 1.13333;
    self._id_3A69 notsolid();
    self._id_3A69 connectpaths();
    self._id_3A69 delete();
    self._id_3A6A = 1;
  }
}

_id_63B8(var_0) {
  level endon("flag_pneumos_activated");

  for(;;) {
    var_0 waittill("trigger", var_1);
    _id_0555::issprinting("pneumo_closed", var_1);
  }
}

_id_8A3B(var_0) {
  wait 1;
  self._id_A1F7 setHintString(&"ZOMBIE_NEST_OBJECTIVE_OFFLINE");
  var_1 = _getscriptablearray("scriptable_pnuemo_tube", "targetname");
  var_2 = undefined;

  if(isDefined(var_1) && var_1.size > 0) {
    var_2 = common_scripts\utility::_id_4461(self._id_A1F7.origin, var_1);
  }

  if(isDefined(var_2)) {
    self._id_A1F7 _meth_8660(1, var_2.origin);
  }

  level thread _id_63B8(self._id_A1F7);
  var_3 = undefined;

  if(isDefined(var_2)) {
    var_3 = _id_0552::_id_7BE1(undefined, self._id_A1F7, 1, var_2.origin);
  } else {
    var_3 = _id_0552::_id_7BE1(undefined, self._id_A1F7);
  }

  var_3._id_4028 = _id_0552::_id_44FF("pneumo");
  var_3._id_401E = 250;
  var_3._id_2F74 = 1;

  while(!_id_055A::_id_586A("zone2_2_catacombs")) {
    wait 1;
  }

  common_scripts\utility::_id_3C9F("flag_pneumos_activated");

  if(isDefined(var_3)) {
    var_3._id_2F74 = 0;
    var_3._id_6642 = 1;
  }

  self._id_A1F7 setHintString(&"ZOMBIES_EMPTY_STRING");
  _id_0559::_id_7BE3(self._id_A1F7, "pneumo");

  for(;;) {
    if(isDefined(self._id_A1F7)) {
      [var_5, var_6] = self._id_A1F7 _id_0547::_id_A795();

      if(!isPlayer(var_5)) {
        continue;
      }
      if(_id_0547::_id_577E(var_5)) {
        continue;
      }
      if(_id_055A::_id_586A(self._id_0165)) {
        if(var_5 maps\mp\gametypes\zombies::_id_11C2(250)) {
          if(_id_057E::_id_314D(var_5)) {
            var_5 _id_057E::_id_95CB();
          }

          var_5 thread _id_86E5(self);
          _id_0547::_id_4AE4(var_5, "escape_tubes", 250, "none", "none");
        }
      } else
        wait 1;
    } else
      break;

    wait 0.01;
  }
}

_id_86E5(var_0) {
  _id_0378::_id_8D74("aud_start_pneumo_tube");
  var_1 = var_0._id_6EB7;
  self._id_53F0 = 1;
  var_2 = maps\mp\mp_zombie_nest_ee_util::_id_90A9(self.origin);
  var_2.origin = var_1[0].origin;
  var_2.angles = var_1[0].angles;
  self.origin = var_2.origin;
  thread _id_7533();
  self setplayerangles(var_2.angles);
  self playerlinktoblend(var_2, "tag_origin", 0.8);
  self playerhide();
  maps\mp\mp_zombie_nest_ee_util::_id_3E23();
  var_3 = [];

  for(var_4 = 0; var_4 < var_1.size - 1; var_4++) {
    var_3[var_4] = var_1[var_4];
  }

  var_2 thread maps\mp\mp_zombie_nest_ee_util::_id_649B(var_3, 450, 0);
  _id_38F5();
  var_2 waittill("path complete");
  _id_A072(var_2, var_0);
}

_id_7533() {
  self._id_1782 = _id_2787("black", 1, self, (1, 1, 1));
  self._id_1782 fadeovertime(0.75);
  self._id_1782.alpha = 0;
  wait 0.75;

  if(isDefined(self) && isDefined(self._id_1782)) {
    self._id_1782 destroy();
  }
}

_id_2787(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2)) {
    var_4 = _newclienthudelem(var_2);
  } else {
    var_4 = newhudelem();
  }

  var_4.x = 0;
  var_4.y = 0;
  var_4 setshader(var_0, 640, 480);
  var_4.alignx = "left";
  var_4.aligny = "top";
  var_4.sort = 1;
  var_4._id_00C6 = "fullscreen";
  var_4._id_01CA = "fullscreen";
  var_4.alpha = var_1;
  var_4.foreground = 1;

  if(isDefined(var_3)) {
    var_4.color = var_3;
  }

  return var_4;
}

_id_A072(var_0, var_1) {
  var_2 = var_1._id_6EB7;
  self unlink();
  self setplayerangles(var_2[var_2.size - 1].angles);
  self setOrigin(var_2[var_2.size - 1].origin);
  self playershow();
  maps\mp\mp_zombie_nest_ee_util::_id_1F3D();
  var_3 = 150 * _id_055F::_id_A01F(var_2[var_2.size - 1].angles);
  self setvelocity(var_3);
  var_0 delete();
  level notify("pneumo_tube_ridden", var_1);

  if(!var_1._id_3A6A && !var_1._id_3A6B) {
    var_1 thread _id_64E1();
  }

  for(;;) {
    if(self isonground()) {
      playFX(level._effect["zmb_pneumo_exit_splash"], self.origin + (0, 0, 20));
    }

    break;
  }

  wait 3;
  self._id_53F0 = 0;
}

_id_38F5() {
  wait 2;

  if(self._id_53F0 == 1) {
    _playfxontagforclients(level._effect["zmb_pneumo_tube_exit_cam"], self, "TAG_ORIGIN", self);
  }
}

_id_1DE0() {
  if(_id_0547::_id_5565(self._id_0165, "first_button")) {
    thread _id_17BF();
  }

  self._id_1E2C waittill("trigger", var_0);

  if(_id_0547::_id_5565(self._id_0165, "first_button")) {
    common_scripts\utility::flag_set("flag_pneumos_activated");
  }

  self._id_1E2B _id_0378::_id_8D74("zmb_pap_button");
  self._id_1E2B scriptmodelplayanim("zmb_undg_cage_switch_activate");
  self._id_1E2C setHintString(&"ZOMBIES_EMPTY_STRING");
  self._id_1E2C common_scripts\utility::_id_9D9F();

  if(!common_scripts\utility::_id_3C77("flag_pap_available")) {
    var_1 = 0;

    while(!var_1) {
      if(common_scripts\utility::_id_3C77("flag_cage_not_moving")) {
        common_scripts\utility::_id_3C7B("flag_cage_not_moving");
        _id_7A2D();
        _id_9ED1();
        var_1 = 1;
        common_scripts\utility::flag_set("flag_cage_not_moving");
        continue;
      }

      common_scripts\utility::_id_3C9F("flag_cage_not_moving");
    }
  }

  self._id_1E2C delete();
}

_id_203D() {
  var_0 = _getEnt("cage_dialogue", "targetname");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(!isDefined(var_1._id_6E34) && isPlayer(var_1)) {
      var_1 thread _id_0378::_id_307E("ame_ihavetoliftthisc");
      var_1._id_6E34 = 1;
    }
  }
}

_id_1E34() {
  common_scripts\utility::_id_3C9F("flag_pap_available");
  _id_6E42();

  foreach(var_1 in level.players) {
    var_1._id_6E34 = 1;
  }
}

_id_6E42() {
  foreach(var_1 in level.players) {}

  level._id_400E[level._id_400E.size] = ["raven_set 3 1", "all"];
  level._id_400E[level._id_400E.size] = ["assassin_set 1 -1", "all"];
}

_id_7A2D() {
  var_0 = % zmb_catacombs_cage_up_01;
  var_1 = % zmb_catacombs_cage_up_02;
  var_2 = % zmb_catacombs_cage_up_03;
  var_3 = % zmb_catacombs_cage_up_04;
  var_4 = _getanimlength(var_0);
  var_5 = _getanimlength(var_1);
  var_6 = _getanimlength(var_2);
  var_7 = _getanimlength(var_3);
  var_8 = 0;
  var_9 = undefined;
  var_10 = "idle_0";

  switch (level._id_1E2E) {
    case 0:
      level._id_6E33._id_1E31 _id_0378::_id_8D74("pap_powerup", 1);
      thread _id_203A();
      wait 1;
      level._id_6E33._id_1E31 _id_0378::_id_8D74("zmb_pap_cage_up_1");
      var_8 = var_4;
      var_10 = "up_1";
      break;
    case 1:
      var_8 = var_5;
      _id_1E33();
      level._id_6E33._id_1E31 _id_0378::_id_8D74("zmb_pap_cage_up_2");
      var_10 = "up_2";
      break;
    case 2:
      var_8 = var_6;
      _id_1E33();
      level._id_6E33._id_1E31 _id_0378::_id_8D74("zmb_pap_cage_up_3");
      var_10 = "up_3";
      break;
    case 3:
      var_8 = var_7;
      _id_1E33();
      level._id_6E33._id_1E31 _id_0378::_id_8D74("zmb_pap_cage_up_4");
      var_10 = "up_4";
      break;
    default:
      break;
  }

  wait 0.2;
  level._id_6E33._id_1E31 setscriptablepartstate("cage", var_10);
  wait(var_8);

  if(level._id_1E2E + 1 >= level._id_1E30) {
    _id_3299();
  } else {
    level._id_6E33._id_1E31 _id_0378::_id_8D74("catacombs_scare", "power_down_main");
  }

  level._id_1E2E++;
}

_id_3299(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  level._id_6E33._id_1E2D connectpaths();
  level._id_6E33._id_1E2D notsolid();
  level._id_6E33._id_1E2D delete();

  if(var_0) {
    level._id_6E33._id_1E31 setscriptablepartstate("cage", "up_4");
  }

  common_scripts\utility::flag_set("flag_pap_available");
}

_id_8A0B() {
  var_0 = spawnStruct();
  var_1 = _getscriptablearray("cage", "targetname");
  var_0._id_1E31 = var_1[0];
  var_0._id_1E2D = _getEnt("cage_clip", "targetname");
  return var_0;
}

_id_46BA(var_0, var_1) {
  var_2 = "";

  if(!issubstr(var_1, var_0)) {} else {
    var_2 = getsubstr(var_1, var_0.size, var_1.size);
    var_2 = int(common_scripts\utility::stringtofloat(var_2)) - 1;
  }

  return var_2;
}

_id_9ED1() {
  if(isDefined(self._id_1E2F)) {
    self._id_1E2F setModel("zmb_light_cage_standalone_green_01");
  }

  self notify("cage light enabled");

  if(isDefined(self._id_1E2A)) {
    self._id_1E2A setModel("zmb_light_cage_standalone_green_01");
  }
}

_id_17BF() {
  self endon("cage light enabled");

  for(;;) {
    self._id_1E2A setModel("zmb_light_cage_standalone_red_01");
    wait 0.5;
    self._id_1E2A setModel("zmb_light_cage_standalone_green_01");
    wait 0.5;
  }
}

_id_1E33() {
  var_0 = randomint(level._id_7532.size);

  if(var_0 == 0 && !common_scripts\utility::_id_3C77("flag_cage_power_outage_triggered")) {
    common_scripts\utility::flag_set("flag_cage_power_outage_triggered");
    level._id_6E33._id_1E31 _id_0378::_id_8D74("zmb_pap_fuse");
    thread _id_203B();
    level thread common_scripts\_exploder::_id_088E(207);
    wait 1;
    level._id_6E33._id_1E31 _id_0378::_id_8D74("catacombs_scare", "power_down_main");
    level._id_1E32 = [];
    var_1 = common_scripts\utility::_id_46B7("cage_scare_spawner", "script_noteworthy");

    foreach(var_3 in var_1) {
      var_4 = _id_054D::_id_90BA("zombie_berserker", var_3, "cage zombie", 0, 1, 1);
      thread _id_1E35(var_4);
      level._id_1E32[level._id_1E32.size] = var_4;
    }

    wait 0.5;
    _id_2035();
    level._id_6E33._id_1E31 _id_0378::_id_8D74("catacombs_scare", "power_up_secondary");
    wait 0.5;
    _id_2039();
    level maps\mp\_utility::waitfortimeornotify(30, "cage_zombies_dead");
    level._id_6E33._id_1E31 _id_0378::_id_8D74("catacombs_scare", "power_up_main");
    _id_2037();
  } else {
    level._id_6E33._id_1E31 _id_0378::_id_8D74("catacombs_scare", "cage_move");
    thread _id_203C();
  }
}

_id_1E35(var_0) {
  var_0 waittill("death");
  level._id_1E32 = common_scripts\utility::_id_0F93(level._id_1E32, var_0);

  if(level._id_1E32.size == 0) {
    level notify("cage_zombies_dead");
  }
}

_id_2037() {
  var_0 = _getscriptablearray("switch", "targetname");

  foreach(var_2 in var_0) {
    wait 0.1;
    var_2 setscriptablepartstate("switchlights", "on");
  }

  var_4 = _getscriptablearray("fill", "targetname");

  foreach(var_6 in var_4) {
    wait 0.1;
    var_6 setscriptablepartstate("switchlights2", "on");
  }

  var_8 = _getscriptablearray("switchmid", "targetname");

  foreach(var_10 in var_8) {
    wait 0.1;
    var_10 setscriptablepartstate("switchlightsmid", "on");
  }

  var_12 = _getscriptablearray("charswitch", "targetname");

  foreach(var_14 in var_12) {
    wait 0.01;
    var_14 setscriptablepartstate("switchlights2", "off");
  }
}

_id_2035() {
  var_0 = _getscriptablearray("fill", "targetname");

  foreach(var_2 in var_0) {
    wait 0.04;
    var_2 setscriptablepartstate("switchlights2", "off");
  }

  var_4 = _getscriptablearray("switchmid", "targetname");

  foreach(var_6 in var_4) {
    wait 0.1;
    var_6 setscriptablepartstate("switchlightsmid", "off");
    wait 0.08;
  }

  var_8 = _getscriptablearray("switch", "targetname");

  foreach(var_10 in var_8) {
    wait 0.1;
    var_10 _id_0378::_id_8D74("catacombs_scare", "switch_lights_off");
    var_10 setscriptablepartstate("switchlights", "off");
    wait 0.1;
  }
}

_id_2039() {
  var_0 = _getscriptablearray("charswitch", "targetname");

  foreach(var_2 in var_0) {
    var_2 setscriptablepartstate("switchlights2", "on");
  }

  var_4 = _getscriptablearray("switchmid", "targetname");

  foreach(var_6 in var_4) {
    var_6 setscriptablepartstate("switchlightsmid", "red");
  }

  var_8 = _getscriptablearray("switch", "targetname");

  foreach(var_10 in var_8) {
    var_10 setscriptablepartstate("switchlights", "red");
  }
}

_id_2038() {
  var_0 = _getscriptablearray("switchmid", "targetname");

  foreach(var_2 in var_0) {
    var_2 setscriptablepartstate("switchlightsmid", "shortout");
    wait 0.1;
    var_2 setscriptablepartstate("switchlightsmid", "on");
  }
}

_id_2036() {
  _id_2035();
  wait 0.5;
  _id_2039();
}

_id_203A() {
  _id_2038();
  wait 0.03;
  _id_2038();
  wait 0.02;
  _id_2038();
  wait 0.01;
  _id_2038();
  wait 0.02;
  _id_2038();
  wait 0.01;
  _id_2038();
}

_id_203B() {
  wait 2;
  _id_2038();
  wait 3;
  _id_2038();
  wait 0.2;
  _id_2038();
  wait 0.2;
  _id_2038();
  wait 0.1;
  _id_2038();
  waitframe();
  _id_2038();
  wait 0.03;
  _id_2038();
  wait 0.02;
  _id_2038();
  wait 1.1;
  _id_2038();
  wait 0.5;
  _id_2038();
  wait 0.2;
  _id_2038();
  wait 0.11;
  _id_2038();
  wait 0.02;
  _id_2038();
  wait 0.01;
  _id_2038();
}

_id_203C() {
  wait 0.2;
  _id_2038();
}

_id_516B(var_0, var_1, var_2) {
  if(!isDefined(level._id_17BA)) {
    level._id_17BA = [];
  }

  if(isDefined(level._id_17BA[var_2])) {}

  var_3 = _id_3B66(var_0, var_1);

  foreach(var_5 in var_3) {
    if(isDefined(var_5._id_1CB1)) {
      var_5._id_1CB1 ghost();
    }

    var_5 common_scripts\utility::_id_9D9F();
    var_5 thread _id_0478::_id_9DC3(::_id_72F3, ::_id_72F4);
  }

  level._id_17BA[var_2] = var_3;
}

_id_17B8(var_0) {
  if(!isDefined(var_0._id_17B7)) {
    var_0._id_17B7 = _newclienthudelem(var_0);
    var_0._id_17B7 setshader("black", 640, 480);
    var_0._id_17B7.alignx = "left";
    var_0._id_17B7.aligny = "top";
    var_0._id_17B7.x = 0;
    var_0._id_17B7.y = 0;
    var_0._id_17B7._id_00C6 = "fullscreen";
    var_0._id_17B7._id_01CA = "fullscreen";
    var_0 setclienttriggervisionset("mp_zombie_nest_01_bunker_darkness");
  }

  var_0._id_17B7.alpha = 1;
}

_id_7C76(var_0) {
  if(isDefined(var_0._id_17B7)) {
    var_0._id_17B7.alpha = 0;
    var_0 setclienttriggervisionset("", 1.0);
  }
}

_id_3B66(var_0, var_1) {
  var_2 = getEntArray(var_0, var_1);
  var_3 = [];

  foreach(var_5 in var_2) {
    if(!isDefined(var_5.classname) || var_5.classname != "trigger_multiple") {
      continue;
    }
    if(isDefined(var_5.target)) {
      var_5._id_1CB1 = _getEnt(var_5.target, "targetname");
    }

    var_3[var_3.size] = var_5;
  }

  return var_3;
}

_id_2CFE(var_0, var_1) {
  var_2 = _id_3B66(var_0, var_1);

  foreach(var_4 in var_2) {
    if(isDefined(var_4._id_1CB1)) {
      var_4._id_1CB1 delete();
      var_4._id_1CB1 = undefined;
    }
  }
}

_id_088D(var_0) {
  if(!isDefined(level._id_17BA)) {
    return;
  }
  var_1 = level._id_17BA[var_0];

  if(!isDefined(var_1)) {
    return;
  }
  foreach(var_3 in var_1) {
    var_3 _id_088C();
  }
}

_id_2A6C(var_0) {
  if(!isDefined(level._id_17BA)) {
    return;
  }
  var_1 = level._id_17BA[var_0];

  if(!isDefined(var_1)) {
    return;
  }
  foreach(var_3 in var_1) {
    var_3 _id_2A6B();
  }
}

_id_088C() {
  common_scripts\utility::_id_9DA3();

  if(isDefined(self._id_1CB1)) {
    self._id_1CB1 show();
  }
}

_id_2A6B() {
  common_scripts\utility::_id_9D9F();

  if(isDefined(self._id_1CB1)) {
    self._id_1CB1 ghost();
  }
}

_id_72F3(var_0) {
  if(!isDefined(self._id_17B9)) {
    self._id_17B9 = 0;
  }

  self._id_17B9++;

  if(self._id_17B9 == 1) {
    _id_17B8(self);
  }
}

_id_72F4(var_0) {
  self._id_17B9--;

  if(self._id_17B9 == 0) {
    _id_7C76(self);
  }
}