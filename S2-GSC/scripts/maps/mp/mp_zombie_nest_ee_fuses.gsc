/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_nest_ee_fuses.gsc
*******************************************************/

main() {
  common_scripts\utility::flag_init("flag_fuse_entered_correct");
  common_scripts\utility::flag_init("flag_player_inspected_right_hand");
  common_scripts\utility::flag_init("flag_cycle_started_once");
  common_scripts\utility::flag_init("flag_fuses_highlighted");
  common_scripts\utility::flag_init("flag_map_highlighted");
  _id_0557::_id_7846("5 Right Hand fuses", _id_0557::_id_30D8, ["4 cart"], &"ZOMBIE_NEST_HINT_QUEST_FUSE", "ZOMBIE_NEST_HINT_QUEST_FUSE");
  _id_0557::_id_781E("5 Right Hand fuses", "fuse matching start", ::_id_785D, _id_0557::_id_30D8, &"ZOMBIE_NEST_HINT_STEP_EXAMINE_RIGHT_HAND");
  _id_0557::_id_781E("5 Right Hand fuses", "lift center rod", ::_id_784D, _id_0557::_id_30D8, &"ZOMBIE_NEST_HINT_STEP_FIRST_LIGHTNING_ROD");
  _id_0557::_id_781E("5 Right Hand fuses", "lift outter rods", ::_id_7860, _id_0557::_id_30D8, &"ZOMBIE_NEST_HINT_STEP_TWO_LIGHTNING_RODS");
  _id_0557::_id_781E("5 Right Hand fuses", "tower confirm hand", ::_id_785C, _id_0557::_id_30D8, &"ZOMBIE_NEST_HINT_STEP_INTERACT_RIGHT_HAND");
  _id_0557::_id_7848("5 Right Hand fuses");
  _id_52E4();

  if(0) {
    _id_6BFF();
  }
}

_id_784D() {
  level thread _id_0560::_id_9009(1);
  thread _id_2E9D();
  maps\mp\mp_zombie_nest_ee_tower_battle::_id_170D();
}

_id_7860() {
  maps\mp\mp_zombie_nest_ee_tower_battle::_id_1715();
}

_id_785C() {
  var_0 = _getEnt("right_hand_of_god_trig", "targetname");
  var_0 setHintString(&"ZOMBIE_NEST_ENABLE_RIGHT_HAND");
  var_1 = common_scripts\utility::_id_46B5("tower_battle_sfx_top", "targetname");
  var_2 = getEntArray("inner_spire", "targetname");
  var_1 thread _id_0378::_id_8D74("aud_tower_shockwave", var_2);
  wait 2.75;
  level thread maps\mp\gametypes\zombies::_id_08B2(var_1.origin);
  var_3 = common_scripts\utility::_id_40B0(var_1.origin, level.players, undefined, undefined, 3000);

  foreach(var_5 in var_3) {
    var_5 thread _id_9B68(var_1.origin);
  }

  var_1 thread _id_9B69();
  thread _id_9B72();
  _id_7E91(1);
  level thread _id_2E9A();
  _id_A689();
  var_7 = _getEnt("rhog_control", "targetname");

  if(isDefined(var_7)) {
    var_7 thread maps\mp\mp_zombie_nest_ee_util::_id_4D76();
    var_7 thread maps\mp\mp_zombie_nest_ee_util::_id_4D77("green");
  }

  thread maps\mp\mp_zombie_nest_ee_util::_id_4D78(1);
  _id_0557::_id_782D("5 Right Hand fuses", "tower confirm hand");
}

_id_9B69(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 0.45;
  }

  if(!isDefined(var_1)) {
    var_1 = 0.1;
  }

  playFX(common_scripts\utility::_id_44F5("lightning_burst"), self.origin);
  level thread _id_9B71();
  level thread common_scripts\_exploder::_id_088E(213);
  wait 0.1;
  thread _id_0378::_id_8D74("aud_tower_strike");
  level thread _id_9DC1("tower_lightning_chain_A_1", var_0, var_1);
  level thread _id_9DC1("tower_lightning_chain_B_1", var_0, var_1);
  level thread _id_9DC1("tower_lightning_chain_C_1", var_0, var_1);
  level thread _id_9DC1("tower_lightning_chain_F_1", var_0, var_1);
}

_id_9B71() {
  var_0 = _getscriptablearray("lightning", "targetname");

  foreach(var_2 in var_0) {
    var_2 setscriptablepartstate("light", "Lightning_Flash_1");
    wait 0.4;
    var_2 setscriptablepartstate("light", "Lightning_Flash_1");
  }
}

_id_9B72() {
  var_0 = _getscriptablearray("tower_light", "targetname");

  foreach(var_2 in var_0) {
    var_2 setscriptablepartstate("lightpart", "flickerfast");
    wait 5;
    var_2 setscriptablepartstate("lightpart", "on");
  }

  level thread common_scripts\_exploder::_id_088E(254);
}

_id_9B68(var_0) {
  wait 0.25;
  thread _id_9B71();
  _earthquake(0.5, 5, var_0, 3000, self);
  self shellshock("ear_ring_mp", 5, 0);
  self playRumbleOnEntity("artillery_rumble");
  level notify("zone1EarthquakeBegin");
  var_1 = _randomfloatrange(1, 2);
  var_2 = _randomfloatrange(1, 2);
  var_3 = _randomfloatrange(1, 2);
  var_4 = _randomfloatrange(4, 8);
  _id_0378::_id_8D74("zone1Earthquake", "rumble1", var_1);
  wait(var_1);
  _id_0378::_id_8D74("zone1Earthquake", "rumble2", var_2);
  wait(var_2);
  _id_0378::_id_8D74("zone1Earthquake", "rumble3", var_3);
  wait(var_3);
  _id_0378::_id_8D74("zone1Earthquake", "earthquake", var_4);

  if(!common_scripts\utility::_id_3C77("flag_bunker_lights_off")) {
    thread maps\mp\mp_zombie_nest_01::_id_3541(var_4);
  }

  level thread common_scripts\_exploder::_id_088E(207);
  _earthquake(0.3, var_4, var_0, 6000, self);
  _playrumblelooponposition("tank_rumble", self.origin);
  wait(var_4);
  thread _id_9B71();
  _stopallrumbles();
  level notify("zone1EarthquakeEnd");
}

_id_9DC1(var_0, var_1, var_2) {
  var_3 = maps\mp\mp_zombie_nest_ee_util::_id_44C8(var_0, 1);

  for(var_4 = 0; var_4 < var_3.size - 4; var_4++) {
    thread _id_7203("zmb_electricity_reg_beam_lrg", var_3[var_4], var_3[var_4 + 1], var_1);
    wait(var_2);
  }

  for(var_4 = var_3.size - 4; var_4 < var_3.size - 1; var_4++) {
    thread _id_7203("zmb_electricity_reg_beam_med", var_3[var_4], var_3[var_4 + 1], var_1);
    wait(var_2);
  }

  if(var_0 == "tower_lightning_chain_F_1") {
    level thread _id_9DBC("electricity_chain_A_1", 0.1);
  }
}

_id_9DBC(var_0, var_1) {
  var_2 = maps\mp\mp_zombie_nest_ee_util::_id_44C8(var_0, 1);

  for(var_3 = 0; var_3 < var_2.size - 1; var_3++) {
    thread _id_7218(var_2[var_3], var_2[var_3 + 1], var_1);
    wait(var_1);
  }

  level thread common_scripts\_exploder::_id_088E(214);
  var_4 = _getEnt("right_hand_of_god_model", "targetname");
  _playFXOnTag(level._effect["zmb_rhog_on"], var_4, "Tag_Origin");
  var_4 _id_0378::_id_8D74("aud_right_hand_of_god_ready");
}

_id_7203(var_0, var_1, var_2, var_3) {
  var_4 = spawn("script_model", var_1.origin);
  var_4 setModel("tag_origin");
  var_5 = spawn("script_model", var_2.origin);
  var_5 setModel("tag_origin");
  var_4.angles = var_1.angles;
  var_6 = anglesToForward(var_2.angles);
  var_7 = vectortoangles(var_6 * -1);
  var_5.angles = var_7;
  var_8 = _func_382(var_0, var_4, "tag_origin", var_5, "tag_origin");
  thread _id_16FD(var_4, _id_0547::_id_9470(var_1._id_0165), var_3);
  thread _id_16FD(var_5, _id_0547::_id_9470(var_2._id_0165), var_3);
  var_9 = 30;

  for(var_10 = 0; var_10 < var_9 / 2; var_10++) {
    wait(var_3 / var_9);
    var_8 hide();
    wait(var_3 / var_9);
    var_8 show();
  }

  wait(var_3);
  var_8 delete();
  var_4 delete();
  var_5 delete();
}

_id_7218(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_0.origin);
  var_3 setModel("tag_origin");
  var_4 = anglesToForward(var_0.angles);
  var_5 = anglestoup(var_0.angles);

  if(var_0._id_0165 == "wire") {
    playFX(level._effect["zmb_fuse_chain_wire"], var_3.origin, var_4, var_5);
  }

  if(var_0._id_0165 == "fusebox") {
    playFX(level._effect["zmb_fuse_chain_box"], var_3.origin, var_4, var_5);
  }

  var_3 moveTo(var_1.origin, var_2);
  wait(var_2);
  var_3 delete();
}

_id_16FD(var_0, var_1, var_2) {
  var_0 movez(var_1, var_2);
}

_id_A689() {
  var_0 = _getEnt("right_hand_of_god_trig", "targetname");
  var_0 notify("right hand ready");
  var_0 waittill("trigger", var_1);
  var_0 _id_0378::_id_8D74("aud_activate_right_hand_of_god");
  var_1 maps\mp\_utility::_id_2CED(2, _id_0367::_id_8E3C, "righthandgodtouch");
  var_0 common_scripts\utility::_id_9D9F();
  var_2 = _getEnt("right_hand_of_god_model", "targetname");
  _playFXOnTag(level._effect["zmb_rhog_init"], var_2, "Tag_Origin");
}

_id_785D() {
  var_0 = _getEnt("rhog_control", "targetname");

  if(isDefined(var_0)) {
    var_0 thread maps\mp\mp_zombie_nest_ee_util::_id_4D77("red");
  }

  _id_7E91(1);
  _id_52E3();
  level thread _id_5413();
  level thread _id_3F26();

  if(1) {
    if(!1 || 1 && level.players.size == 1) {
      level thread quest_step_match_fuses_helper();
    }
  }
}

quest_step_match_fuses_helper() {
  level endon(_id_0557::_id_7838("5 Right Hand fuses", "fuse matching start"));

  if(!0) {
    var_0 = level._id_A980;
    var_1 = var_0 + 2;

    if(1) {
      wait 200;
    }

    if(1) {
      if(level._id_A980 <= var_1) {
        for(;;) {
          level waittill("zombie_wave_started");

          if(level._id_A980 > var_1) {
            break;
          }
        }
      }
    }

    level.fuse_objective_helper_tripped = 1;
  }
}

_id_7E91(var_0) {
  if(1) {
    if(!isDefined(level._id_7E68)) {
      var_1 = _getEnt("right_hand_of_god_model", "targetname");
      level._id_7E68 = _id_0557::_id_782F(undefined, var_1);
    }

    if(var_0) {
      _id_0557::_id_781D("5 Right Hand fuses", level._id_7E68);
    } else {
      _id_0557::_id_7847("5 Right Hand fuses", level._id_7E68);
    }
  }
}

_id_3F2B(var_0) {
  if(0 || common_scripts\utility::_id_562E(level.fuse_objective_helper_tripped)) {
    var_1 = [];

    foreach(var_3 in level._id_665B) {
      var_1[var_1.size] = var_3._id_5F58;
    }

    if(!isDefined(level._id_3F27)) {
      level._id_3F27 = _id_0557::_id_782F(undefined, var_1);
    }

    if(var_0) {
      if(!common_scripts\utility::_id_3C77("flag_fuses_highlighted")) {
        if(0) {
          foreach(var_6 in var_1) {
            foreach(var_8 in level.players) {
              var_6 hudoutlineenableforclient(var_8, 0, 0);
            }
          }
        } else
          _id_0557::_id_781D("5 Right Hand fuses", level._id_3F27);

        common_scripts\utility::flag_set("flag_fuses_highlighted");
      }
    } else if(common_scripts\utility::_id_3C77("flag_fuses_highlighted")) {
      if(0) {
        foreach(var_6 in var_1) {
          foreach(var_8 in level.players) {
            var_6 hudoutlinedisableforclient(var_8);
          }
        }
      } else
        _id_0557::_id_7847("5 Right Hand fuses", level._id_3F27);

      common_scripts\utility::_id_3C7B("flag_fuses_highlighted");
    }
  }
}

_id_4873(var_0) {
  if(1) {
    if(!isDefined(level._id_7D2C)) {
      var_1 = _getEnt("com_map_frame", "targetname");
      var_2 = _getscriptablearray("fuses_com_map", "targetname");
      level._id_7D2C = _id_0557::_id_782F(undefined, [level._id_22F5, var_2[0], var_1]);
    }

    if(common_scripts\utility::_id_562E(var_0)) {
      if(!common_scripts\utility::_id_3C77("flag_map_highlighted")) {
        _id_0557::_id_781D("5 Right Hand fuses", level._id_7D2C);
        common_scripts\utility::flag_set("flag_map_highlighted");
      }
    } else if(common_scripts\utility::_id_3C77("flag_map_highlighted")) {
      _id_0557::_id_7847("5 Right Hand fuses", level._id_7D2C);
      common_scripts\utility::_id_3C7B("flag_map_highlighted");
    }
  }
}

_id_4874() {
  var_0 = _getEnt("fuse_quest_start_trigger", "targetname");

  if(!common_scripts\utility::_id_562E(var_0._id_4DAE)) {
    var_0 setHintString(&"ZOMBIE_NEST_TURN_FUSE_OBJECTIVE_ON");
    var_0._id_4DAE = 1;
  }

  var_0 common_scripts\utility::_id_9DA3();
  var_0 waittill("trigger", var_1);
  thread _id_2EB6(var_1);
  common_scripts\utility::flag_set("flag_cycle_started_once");
  var_0 common_scripts\utility::_id_9D9F();
}

_id_3F26() {
  _id_8A1E();
  level endon("nest_ee_fuses_complete");
  level thread _id_21C8();
  var_0 = 0;

  for(var_1 = 1; !var_0; var_0 = common_scripts\utility::_id_562E(var_2)) {
    if(!var_1) {
      _id_6B34();
    }

    setclienttriggeraudiozonepartial();

    if(!var_1) {
      _id_4874();
      _id_4873(0);
      _id_0557::_id_7822("5 Right Hand fuses", &"ZOMBIE_NEST_HINT_STEP_MATCH_FUSES");
      _id_3F2B(1);
    } else
      var_1 = 0;

    _id_9ED3();
    _id_9ED6();
    var_2 = _id_9E1F();
  }

  foreach(var_4 in level._id_665B) {
    var_4._id_1F20 = 0;
  }
}

_id_9ED6() {
  level._id_22F5 _id_856A(level._id_24A2);
  var_0 = _getscriptablearray("fuses_com_map", "targetname");
  var_0[0] getusableentity(level._id_24A2);
}

_id_4303() {
  return _id_0557::_id_7838("5 Right Hand fuses", "tower confirm hand", 1);
}

_id_8A1E() {
  _id_4874();
  _id_4873(0);
  _id_0557::_id_7822("5 Right Hand fuses", &"ZOMBIE_NEST_HINT_STEP_MATCH_FUSES");

  foreach(var_1 in level._id_665B) {
    var_2 = _getscriptablearray(var_1.target, "targetname");

    if(var_2.size > 0) {
      var_1._id_5F58 = var_2[0];
    }

    var_3 = common_scripts\utility::_id_44BE(var_1.target, "targetname");

    foreach(var_5 in var_3) {
      if(!isDefined(var_5.setlookatent)) {
        continue;
      }
      var_6 = var_5.setlookatent;

      switch (var_6) {
        case "needle":
          var_1._id_6643 = var_5;
          break;
        case "needle_empty":
          var_1._id_6646 = var_5;
          break;
        case "needle_full":
          var_1._id_6647 = var_5;
          break;
      }
    }

    var_1 thread _id_4AC4();
  }

  _id_3F2B(1);

  foreach(var_1 in level._id_665B) {
    if(_id_0547::_id_9470(var_1._id_0165) != 1) {
      var_1 thread _id_2E9E();
    }
  }

  _id_3875();
  _id_8A58();
}

_id_9E1F() {
  level endon("nest_ee_fuses_complete");
  level endon("flag_fuse_entered_correct");

  if(level.players.size > 1) {
    var_0 = 65;
  } else {
    var_0 = 75;
  }

  foreach(var_2 in level._id_665B) {
    var_2 thread _id_92D6(var_0);
  }

  for(var_4 = 0; var_4 < var_0; var_4++) {
    wait 1;
  }

  level notify("nest_ee_fuse_off");
  return 0;
}

_id_92D6(var_0) {
  level endon("nest_ee_fuses_complete");

  if(!isDefined(self._id_6643) || !isDefined(self._id_6646) || !isDefined(self._id_6647)) {
    return;
  }
  self._id_6643 moveTo(self._id_6647.origin, 0.1, 0, 0);
  wait 0.1;
  self._id_6643 moveTo(self._id_6646.origin, var_0 - 0.1, 0, 0);
}

_id_868D() {
  if(!isDefined(self._id_6643) || !isDefined(self._id_6647)) {
    return;
  }
  self._id_6643 moveTo(self._id_6647.origin, 0.5, 0, 0);
}

_id_868C() {
  if(!isDefined(self._id_6643) || !isDefined(self._id_6646)) {
    return;
  }
  self._id_6643 moveTo(self._id_6646.origin, 0.5, 0, 0);
}

_id_9ED3() {
  level._id_665B[0] thread _id_868E("open", "blinking");
  level._id_665B[0] _id_9ED4();
}

_id_6B34() {
  common_scripts\utility::_id_0FB2(level._id_665B, ::_id_868C);
  _id_0557::_id_7822("5 Right Hand fuses", &"ZOMBIE_NEST_HINT_STEP_RESET_FUSES");
  _id_3F2B(0);
  _id_4873(1);
  thread _id_2EA4();

  foreach(var_1 in level._id_665B) {
    var_1._id_1F20 = 1;
  }
}

_id_2EA4() {
  var_0 = common_scripts\utility::random(level.players);
  var_0 thread _id_0367::_id_8E3C("circuitmapfail");
}

_id_2E9A() {
  wait 2;
  var_0 = _getEnt("inner_spire", "targetname");

  if(isDefined(var_0)) {
    foreach(var_2 in level.players) {
      if(_distance2d(var_2.origin, var_0.origin) < 750) {
        var_2 thread _id_0367::_id_8E3C("lightningrodscomplete");
      }
    }
  }

  wait 9;

  if(isDefined(var_0)) {
    foreach(var_2 in level.players) {
      if(_distance2d(var_2.origin, var_0.origin) < 750) {
        var_2 thread _id_0367::_id_8E3C("lightningflow");
      }
    }
  }

  var_2 = maps\mp\mp_zombie_nest_ee_util::_id_4649();
  var_2 thread _id_0367::_id_8E3B("conv_righthandaltarfinish");
}

setclienttriggeraudiozonepartial() {
  foreach(var_1 in level._id_665B) {
    var_1 thread _id_868E("close", "off");
    var_1 _id_9ECC();
  }

  level._id_22F5 _id_856A(undefined, 1);
  var_3 = _getEnt("fuses_com_map", "targetname");
  var_3 getusableentity(undefined, 1);
}

_id_868E(var_0, var_1) {
  if(!isDefined(self._id_5F58._id_2916)) {
    self._id_5F58._id_2916 = "off";
  }

  switch (var_0) {
    case "blue":
    case "green":
    case "red":
      self._id_5F58 _id_864C(var_0);
      self._id_5F58 thread _id_864A(var_0);
      break;
    case "open":
      if(!common_scripts\utility::_id_562E(self._id_5F58._id_3297)) {
        self._id_5F58 _id_864C(undefined);
        self._id_5F58 thread _id_864A(undefined);
        self._id_5F58._id_3297 = 1;
        self._id_5F58 thread _id_864B(var_0);
      }

      break;
    case "close":
      if(common_scripts\utility::_id_562E(self._id_5F58._id_3297)) {
        self._id_5F58._id_3297 = 0;
        self._id_5F58 thread _id_864B(var_0);
      }

      break;
    default:
      break;
  }

  _id_0547::_id_A6F6();

  if(isDefined(var_1)) {
    self._id_5F58 thread _id_864D(var_1);
  }
}

_id_864D(var_0) {
  self setscriptablepartstate("power_light", var_0);
}

#using_animtree("destructibles");

_id_864A(var_0) {
  var_1 = [];
  var_1["off_to_red"] = % zmb_circuit_breaker_01_dial_red;
  var_1["red"] = % zmb_circuit_breaker_01_dial_blue_to_red;
  var_1["green"] = % zmb_circuit_breaker_01_dial_green;
  var_1["blue"] = % zmb_circuit_breaker_01_dial_blue;

  if(isDefined(var_0)) {
    if(self._id_2916 == "off" && var_0 == "red") {
      self setscriptablepartstate("dial", "off_to_red");
      wait(_getanimlength(var_1["off_to_red"]));
    } else {
      self setscriptablepartstate("dial", "to_" + var_0);
      wait(_getanimlength(var_1[var_0]));
    }

    self setscriptablepartstate("dial", "on_" + var_0);
    self._id_2916 = var_0;
  } else {
    self setscriptablepartstate("dial", "on_off");
    self._id_2916 = "off";
  }
}

_id_864B(var_0) {
  self notify("door_state_change");
  self endon("door_state_change");

  if(var_0 == "close") {
    _id_0378::_id_8D74("fuse_color_switch_door_close");
    self setscriptablepartstate("door", "up");
    wait(_getanimlength(%zmb_circuit_breaker_01_cover_up));
    self setscriptablepartstate("door", "up_idle");
  } else if(var_0 == "open") {
    _id_0378::_id_8D74("fuse_color_switch_door_open");
    self setscriptablepartstate("door", "down");
    wait(_getanimlength(%zmb_circuit_breaker_01_cover_down));
    self setscriptablepartstate("door", "down_idle");
  }
}

_id_864C(var_0) {
  self setscriptablepartstate("light_blue", "off");
  self setscriptablepartstate("light_green", "off");
  self setscriptablepartstate("light_red", "off");

  if(isDefined(var_0)) {
    self setscriptablepartstate("light_" + var_0, "on");
  }

  thread _id_3D63();
}

_id_3D63() {
  self setscriptablepartstate("graph", "off");
  wait 0.15;
  self setscriptablepartstate("graph", "on");
}

_id_98A3() {
  wait 1.5;
  level.players[0] setOrigin((954.139, -3445.2, 1502.04));
  level.players[0] setplayerangles((0, -152.705, 0));
}

_id_3F29() {
  foreach(var_1 in level.players) {
    var_1 _id_054C::_id_AC23("righthandofgod");
    var_1 _id_0378::_id_8D74("objective_complete", "righthandofgod");
  }
}

_id_6BFF() {
  while(!isDefined(level._id_AC1D) && !isDefined(level.players)) {
    waitframe();
  }

  foreach(var_1 in level._id_AC1D) {
    if(var_1.getnegotiationnextnode == "safe_haven_to_bridge") {
      var_1 notify("open", level.players[0]);
    }
  }
}

_id_5413() {
  var_0 = _getEnt("right_hand_of_god_trig", "targetname");
  var_0._id_4D91 = _id_0559::_id_7BE3(var_0, "rhog");
  var_0 endon("right hand ready");
  var_0 setHintString(&"ZOMBIES_SWITCH_HINT_GENERIC_EXAMINE");
  var_0 waittill("trigger", var_1);
  var_0 setHintString(&"ZOMBIES_EMPTY_STRING");

  if(common_scripts\utility::_id_24A6()) {
    var_1 thread _id_0367::_id_8E3C("righthandaltar");
  } else {
    var_1 thread _id_0367::_id_8E3B("conv_righthandaltarclue");
  }

  common_scripts\utility::flag_set("flag_player_inspected_right_hand");

  if(!common_scripts\utility::_id_3C77("flag_cycle_started_once")) {
    _id_0557::_id_7822("5 Right Hand fuses", &"ZOMBIE_NEST_HINT_STEP_ROUTE_TO_TOWER");
    _id_4873(1);
    _id_7E91(0);
    thread _id_3F28();
  }
}

_id_3F28() {
  var_0 = _getEnt("power_grid_hint_trig", "targetname");

  if(isDefined(var_0)) {
    for(;;) {
      var_0 waittill("trigger", var_1);

      if(isPlayer(var_1)) {
        break;
      }
    }
  }

  if(!common_scripts\utility::_id_3C77("flag_cycle_started_once")) {
    _id_0557::_id_7822("5 Right Hand fuses", &"ZOMBIE_NEST_HINT_STEP_RESET_FUSES");
  }
}

_id_2E9E() {
  level endon("nest_ee_fuses_complete");

  foreach(var_1 in level.players) {
    if(!isDefined(var_1._id_306C)) {
      var_1._id_306C = 0;
    }
  }

  for(;;) {
    foreach(var_1 in level.players) {
      if(!var_1._id_306C) {
        if(distance(self.origin, var_1.origin) < 128) {
          var_4 = var_1 _id_0367::_id_8E3D("circuitclue");

          if(isDefined(var_4)) {
            var_1._id_306C = 1;
          }
        }
      }
    }

    wait 1;
  }
}

_id_2E9D() {
  wait 13;
  var_0 = undefined;

  foreach(var_2 in level.players) {
    if(var_2 maps\mp\mp_zombie_nest_ee_util::_id_740A()) {
      var_0 = var_2;
      break;
    }
  }

  if(isDefined(var_0)) {
    var_0 _id_0367::_id_8E3B("conv_lightningtower");
  }
}

_id_4AC4() {
  level endon("nest_ee_fuses_complete");

  for(;;) {
    self waittill("trigger", var_0);

    if(self._id_3F2A && isDefined(level._id_24A2)) {
      _id_9A82(var_0);
      continue;
    }

    if(common_scripts\utility::_id_562E(self._id_1F20)) {
      var_0 thread _id_0367::_id_8E3C("circuitlocked");
    }
  }
}

_id_2EB6(var_0) {
  var_1 = "";

  if(!isDefined(var_0._id_3071)) {
    if(common_scripts\utility::_id_24A6()) {
      var_1 = "circuitmap";
    } else {
      var_1 = "mapinteract";
    }

    var_2 = var_0 _id_0367::_id_8E3D(var_1);

    if(isDefined(var_2)) {
      var_0._id_3071 = 1;
    }
  }
}

_id_8A58() {
  var_0 = _id_689E(-1);
  level._id_292A = [var_0, var_0, var_0, var_0];
}

_id_3875() {
  level._id_24A2 = [];
  var_0 = [];
  var_0 = [];
  var_1 = "";
  var_2 = _getEnt("fuses_reset_button", "targetname");

  for(var_3 = 0; var_3 < 4; var_3++) {
    var_4 = randomint(3);

    if(var_0.size != 0) {
      var_4 = _id_A274(var_4, var_0);
    }

    var_0[var_0.size] = var_4;
    var_5 = _id_689E(var_4);
    var_1 = var_1 + (var_5 + " ");
    level._id_24A2[var_3] = var_5;
    level._id_292A[var_3] = _id_689E(-1);
  }
}

_id_856A(var_0, var_1) {
  var_2 = ["red", "green", "blue"];

  if(common_scripts\utility::_id_562E(var_1)) {
    var_0 = ["black", "black", "black", "black"];
    self setscriptablepartstate("dial", "off");

    for(var_3 = 0; var_3 < 4; var_3++) {
      thread _id_9ED5(var_3);
    }

    thread _id_310F();
  } else {
    self setscriptablepartstate("dial", "on");

    for(var_3 = 0; var_3 < 4; var_3++) {
      thread _id_9ECD(var_3);
    }

    thread _id_320B();
  }

  var_4 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    for(var_5 = 0; var_5 < var_2.size; var_5++) {
      var_6 = var_2[var_5] + "_" + (var_3 + 1);

      if(var_2[var_5] != var_0[var_3]) {
        self setscriptablepartstate(var_6, "off");
        continue;
      }

      self setscriptablepartstate(var_6, "on");
      var_4[var_3] = var_2[var_5];
    }
  }

  _id_0378::_id_8D74("circuit_map_reveal_machine_lights", var_4);
}

getusableentity(var_0, var_1) {
  var_2 = ["red", "green", "blue"];

  if(common_scripts\utility::_id_562E(var_1)) {
    var_0 = ["off", "off", "off", "off"];
  }

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = "indicator_0" + common_scripts\utility::_id_9AAD(var_3 + 1);
    self setscriptablepartstate(var_4, var_0[var_3]);
  }
}

_id_320B() {
  self setscriptablepartstate("button", "on");
  wait(_getanimlength(%zmb_circuit_map_machine_button_press_on));
  self setscriptablepartstate("button", "on_idle");
}

_id_310F() {
  self setscriptablepartstate("button", "off");
  wait(_getanimlength(%zmb_circuit_map_machine_button_reverse));
  self setscriptablepartstate("button", "off_idle");
}

_id_9ED5(var_0) {
  var_0 = var_0 + 1;
  var_1 = [];
  var_1[0] = % zmb_circuit_map_machine_needle_01_dial_on;
  var_1[1] = % zmb_circuit_map_machine_needle_02_dial_on;
  var_1[2] = % zmb_circuit_map_machine_needle_03_dial_on;
  var_1[3] = % zmb_circuit_map_machine_needle_04_dial_on;
  self setscriptablepartstate("needle_0" + var_0, "on");
  wait(_getanimlength(var_1[var_0 - 1]));
  self setscriptablepartstate("needle_0" + var_0, "on_idle");
}

_id_9ECD(var_0) {
  var_0 = var_0 + 1;
  var_1 = [];
  var_1[0] = % zmb_circuit_map_machine_needle_01_dial_off;
  var_1[1] = % zmb_circuit_map_machine_needle_02_dial_off;
  var_1[2] = % zmb_circuit_map_machine_needle_03_dial_off;
  var_1[3] = % zmb_circuit_map_machine_needle_04_dial_off;
  self setscriptablepartstate("needle_0" + var_0, "off");
  wait(_getanimlength(var_1[var_0 - 1]));
  self setscriptablepartstate("needle_0" + var_0, "off_idle");
}

_id_310E() {
  self setscriptablepartstate("button", "press");
}

_id_9A82(var_0) {
  if(!isDefined(self._id_2904)) {
    self._id_2904 = -1;
  }

  self._id_2904 = common_scripts\utility::_id_98E7(self._id_2904 == 2, 0, self._id_2904 + 1);
  level._id_292A[self._id_65E5] = _id_689E(self._id_2904);
  thread _id_868E(level._id_292A[self._id_65E5]);
  thread _id_1C89(var_0);
  _id_0378::_id_8D74("circuit_set_fuse_color_switch", self._id_65E5, level._id_292A[self._id_65E5]);
}

_id_1C89(var_0) {
  self notify("broadcasted change");
  self endon("broadcasted change");
  wait 2.5;
  level notify("fuse code changed", var_0, self._id_65E5);
}

_id_7D5F() {
  self._id_2904 = -1;
}

_id_9ED4() {
  self._id_3F2A = 1;
  self._id_65DC._id_4028 = _id_0552::_id_44FF("fuse_change_state");
  self._id_65DC._id_2F74 = 0;
  self._id_65DC._id_6642 = 1;
  self._id_65DC.interact_disabled = 0;
}

_id_9ECC() {
  self._id_3F2A = 0;
  self._id_65DC._id_4028 = _id_0552::_id_44FF("fuse_not_active");
  self._id_65DC._id_2F74 = 0;
  self._id_65DC._id_6642 = 1;
  self._id_65DC.interact_disabled = 1;
  level._id_292A[self._id_65E5] = _id_689E(-1);
  _id_7D5F();
  _id_0378::_id_8D74("circuit_clear_fuse_color_switch", self._id_65E5);
}

_id_36B8() {
  common_scripts\utility::flag_set("flag_fuse_entered_correct");
  setclienttriggeraudiozonepartial();
  common_scripts\utility::_id_0FB2(level._id_665B, ::_id_868D);
  _id_0557::_id_782D("5 Right Hand fuses", "fuse matching start");
  level notify("nest_ee_fuses_complete");
}

_id_A274(var_0, var_1) {
  var_2 = 0;

  while(!var_2) {
    if(!_id_582F(var_0, var_1)) {
      var_0 = common_scripts\utility::_id_98E7(var_0 == 2, 0, var_0 + 1);
      continue;
    }

    var_2 = 1;
  }

  return var_0;
}

_id_582F(var_0, var_1) {
  var_2 = 2;
  var_3 = 0;

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    if(var_1[var_4] == var_0) {
      var_3++;
    }
  }

  return var_3 < var_2;
}

_id_8749() {
  self[0] _id_8C06();
  self[1] _id_4D0F();
  self[2] _id_4D0F();
}

_id_874E() {
  self[0] _id_4D0F();
  self[1] _id_4D0F();
  self[2] _id_4D0F();
}

_id_8BF2() {
  for(;;) {
    level waittill("fuse code changed", var_0, var_1);

    if(isDefined(level._id_24A2)) {
      for(var_2 = 0; var_2 < level._id_24A2.size; var_2++) {
        if(level._id_292A[var_2] == level._id_24A2[var_2]) {
          if(var_2 == var_1) {
            _func_351("zm_ctcms_fuse", undefined, var_0.origin);
          }
        }
      }
    }
  }
}

_id_21C8() {
  var_0 = 0;

  while(!var_0) {
    level waittill("fuse code changed", var_1, var_2);
    var_0 = _id_44F4(var_1);

    if(var_0) {
      _id_36B8();
      continue;
    }
  }
}

_id_44F4(var_0) {
  if(!common_scripts\utility::_id_562E(level._id_665C)) {
    level._id_665C = 0;
  }

  if(!isDefined(level._id_24A2)) {
    return 0;
  }

  var_1 = 1;
  var_2 = "";
  var_3 = 1;
  var_4 = 1;

  for(var_5 = 0; var_5 < level._id_24A2.size; var_5++) {
    if(level._id_292A[var_5] != level._id_24A2[var_5]) {
      var_2 = var_2 + "0";
      var_4 = 0;
      var_1 = 0;
      continue;
    }

    if(var_4) {
      if(var_5 == 0 && !level._id_665C) {
        var_0 thread _id_0367::_id_8E3C("circuit1");
        level._id_665C = 1;
      }

      var_2 = var_2 + "1";
      var_3++;
    }
  }

  for(var_5 = 0; var_5 < level._id_665B.size; var_5++) {
    if(var_5 < var_3) {
      level._id_665B[var_5] _id_9ED4();

      if(var_5 == var_3 - 1) {
        level._id_665B[var_5] thread _id_868E("open", "blinking");
      } else {
        level._id_665B[var_5] thread _id_868E("open", "on");
      }

      level notify("open fuse doors " + var_5);
      continue;
    }

    level._id_665B[var_5] _id_9ECC();
    level._id_665B[var_5] thread _id_868E("close", "off");
  }

  return var_1;
}

_id_689E(var_0) {
  if(var_0 == 0) {
    return "red";
  }

  if(var_0 == 1) {
    return "green";
  }

  if(var_0 == 2) {
    return "blue";
  }

  return "no color";
}

_id_250B(var_0) {
  if(var_0 == "red") {
    return 0;
  }

  if(var_0 == "green") {
    return 1;
  }

  if(var_0 == "blue") {
    return 2;
  }

  return 3;
}

_id_8C06() {
  self show();
}

_id_4D0F() {
  self hide();
}

_id_52E4() {
  level thread _id_8BF2();
  var_0 = getEntArray("nest_ee_fuse_trigger", "targetname");
  var_0 = common_scripts\utility::_id_0FA5(var_0, ::enableweapons);
  var_1 = _getEnt("rhog_control", "targetname");

  if(isDefined(var_1)) {
    var_1 thread maps\mp\mp_zombie_nest_ee_util::_id_4D77("off");
  }

  level._id_665B = var_0;

  for(var_2 = 0; var_2 < level._id_665B.size; var_2++) {
    level._id_665B[var_2]._id_65E5 = var_2;
  }

  var_3 = _getEnt("fuse_quest_start_trigger", "targetname");
  var_3 setHintString(&"ZOMBIE_NEST_OBJECTIVE_OFFLINE");
  level._id_22F5 = _getEnt("fuses_reset_button", "targetname");
  level._id_22F5 _id_856A(undefined, 1);
  var_4 = _getEnt("fuses_com_map", "targetname");
  var_4 getusableentity(undefined, 1);
}

_id_52E3() {
  for(var_0 = 0; var_0 < level._id_665B.size; var_0++) {
    level._id_665B[var_0]._id_65E5 = var_0;
    level._id_665B[var_0]._id_65DC = _id_0552::_id_7BE1(undefined, level._id_665B[var_0]);
    level._id_665B[var_0]._id_65DC._id_2F74 = 1;
  }
}

enableweapons(var_0, var_1) {
  return _id_0547::_id_9470(var_0._id_0165) < _id_0547::_id_9470(var_1._id_0165);
}