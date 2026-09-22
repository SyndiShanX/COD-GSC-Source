/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_nest_ee_util.gsc
******************************************************/

_id_50F3() {
  var_0 = common_scripts\utility::_id_46B5("raven_progress", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = common_scripts\utility::_id_46B7(var_0.target, "targetname");
  var_2 = _id_0557::_id_7838("6B Left Hand overcharge", "activate left hand");
  var_3 = _id_0557::_id_7838("7 Voice paintings", "enter code pieces");
  var_4 = _id_0557::_id_7838("5 Right Hand fuses", "tower confirm hand");

  foreach(var_6 in var_1) {
    switch (var_6._id_0165) {
      case "right":
        var_6._id_3F80 = common_scripts\utility::_id_46B5(var_6._id_0165 + "_to_center_fx", "script_noteworthy");

        if(!isDefined(var_6._id_3F80)) {
          return;
        }
        var_6 thread _id_7A8C(var_2, var_3);
        break;
      case "right2":
        var_6 thread _id_7A8C(var_3, var_3);
        break;
      case "left2":
        var_6._id_3F80 = common_scripts\utility::_id_46B5("middle_to_center_fx", "script_noteworthy");

        if(!isDefined(var_6._id_3F80)) {
          return;
        }
        var_6 thread _id_7A8C(var_3, var_3);
        break;
      case "left":
        var_6._id_3F80 = common_scripts\utility::_id_46B5(var_6._id_0165 + "_to_center_fx", "script_noteworthy");

        if(!isDefined(var_6._id_3F80)) {
          return;
        }
        var_6 thread _id_7A8C(var_4, var_3);
        break;
      case "rock_crumble":
        var_6 thread _id_7EB3(var_3);
        break;
    }
  }

  var_8 = getEntArray(var_0.target, "targetname");

  foreach(var_10 in var_8) {
    switch (var_10._id_0165) {
      case "final_boss_tesla_trigger":
        var_10 thread _id_A6A0(var_0, var_3);
        break;
    }
  }
}

_id_7A8C(var_0, var_1) {
  common_scripts\utility::_id_3CA2(var_0, var_1);
  self.angles = (270, 270, 90);

  if(isDefined(self._id_3F80)) {
    var_2 = _id_0547::_id_8FBA(self._id_3F80, "hiltroom_connection");
    _triggerfx(var_2);
    level waittill("end hilt grabbed");
    var_2 delete();
  }
}

_id_7EB3(var_0) {
  for(;;) {
    level waittill("end hilt grabbed", var_1);
    level thread common_scripts\_exploder::_id_088E(222);
    _earthquake(0.3, 7, var_1, 1000);
  }
}

_id_A6CD(var_0) {
  level endon("brute_tesla_skip_cheat");
  common_scripts\utility::_id_3C9F(var_0);
}

_id_A6A0(var_0, var_1) {
  self notsolid();
  _id_A6CD(var_1);
  self solid();
  level._id_4D74 = _id_0547::_id_8FBA(var_0, "zmb_hilt_sphere");
  var_2 = _getEnt("hilt_model", "targetname");
  _triggerfx(level._id_4D74);
  var_2 _id_0378::_id_8D74("aud_start_hilt_sphere_sound");
  wait 5;
  self setCanDamage(1);
  var_3 = [];

  while(var_3.size < level.players.size) {
    var_4 = _id_A6CE(self, "brute tesla activation fail");
    _id_0378::_id_8D74("aud_hilt_destroy");

    if(isDefined(var_4)) {
      if(!common_scripts\utility::_id_0F79(var_3, var_4)) {
        var_3 = common_scripts\utility::_id_0F6F(var_3, var_4);
      }

      if(var_3.size == 1) {
        thread _id_08BD(5, "brute tesla activated", "brute tesla activation fail");
      }

      continue;
    }

    var_3 = [];
  }

  playFX(level._effect["zmb_hilt_sphere_explosion"], var_0.origin, anglesToForward(var_0.angles));
  level._id_4D74 delete();
  var_5 = _getEnt("nest_ee_shard_intro_start_trig", "targetname");
  var_5 common_scripts\utility::_id_9DA3();
  var_6 = undefined;

  foreach(var_8 in level.players) {
    if(var_8 _id_7403()) {
      var_6 = var_8;
    }
  }

  if(!isDefined(var_6)) {
    var_6 = common_scripts\utility::random(level.players);
  }

  var_6 thread _id_0367::_id_8E3B("conv_hiltrecovered");

  if(_id_0557::_id_783E("8A The Hilt", "Use Hilt") && !_id_0557::_id_783E("8A The Hilt", "Shoot Hilt")) {
    _id_0557::_id_7822("8A The Hilt", &"ZOMBIE_NEST_HINT_STEP_TAKE_HILT");
  }

  var_5 setHintString(&"ZOMBIE_NEST_SHARD_INTRO_TRIG");
  var_5 waittill("trigger", var_4);
  var_5 common_scripts\utility::_id_9D9F();
  _id_0378::_id_8D74("aud_pickup_raven_sword");
  common_scripts\utility::flag_set("flag_hilt_collected");

  if(isDefined(var_2)) {
    var_2 delete();
  }

  wait 2;
  level notify("end hilt grabbed", var_4.origin);
  var_4 thread _id_0367::_id_8E3B("conv_hiltroomcollapse");
  wait 5;
  thread _id_3BEC();
  thread _id_3BE6();
  thread _id_1CCC();
  thread _id_1CCA();
  level._id_6654 = 1;
}

_id_4030(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(level._id_6666)) {
    level._id_6666 = 0;
  }

  var_9 = common_scripts\utility::_id_4461(self.origin, level._id_08E3);
  var_10 = 0;

  if(isDefined(var_9) && isDefined(var_9._id_7D24)) {
    if(_isarray(var_9._id_7D24)) {
      var_11 = 0;

      foreach(var_13 in var_9._id_7D24) {
        if(var_4 == var_13) {
          var_11 = 1;
        }
      }

      if(!var_11) {
        var_10 = 1;
      }
    } else if(var_4 != var_9._id_7D24)
      var_10 = 1;
  }

  if(level._id_08E3.size == 0 || common_scripts\utility::_id_562E(self._id_8F2B) || var_10) {
    return;
  }
  if(common_scripts\utility::_id_562E(self._id_AC10)) {
    return;
  }
  if(isDefined(var_9._id_2E37)) {
    var_15 = var_9 gettagorigin(var_9._id_2E37);

    if(isDefined(var_9._id_8C48)) {
      var_15 = var_15 + var_9._id_8C48;
    }
  } else
    var_15 = var_9.origin;

  if(isDefined(var_9._id_8C47)) {
    var_16 = _bullettracepassed(self getEye(), var_15, 0, var_9, var_9._id_8C47);
  } else {
    var_16 = _bullettracepassed(self getEye(), var_15, 0, var_9);
  }

  var_17 = _id_21CF(var_9, var_9._id_696B, var_9._id_6943);

  if(isDefined(var_9) && var_17 && var_16) {
    self._id_8F2B = 1;

    if(level._id_6666 < 5) {
      thread _id_2024(var_9, var_9._id_2E37, var_9._id_2DA5, var_9._id_2DA6);
    }

    if(!common_scripts\utility::_id_562E(self._id_2FDA) && !_id_0547::_id_5565(self._id_0A4B, "zombie_fireman")) {
      _id_865C("scripted_soul_eat", 0);
    }

    var_9._id_AC2C++;
    level notify(var_9._id_695B, var_9);
  }
}

_id_08BD(var_0, var_1, var_2) {
  self endon(var_1);
  wait(var_0);
  self notify(var_2);
}

_id_A6CE(var_0, var_1) {
  if(isDefined(var_1)) {
    var_0 endon(var_1);
  }

  var_0 setCanDamage(1);
  var_2 = undefined;
  var_3 = "";

  while(!issubstr(var_3, "teslagun_zm")) {
    var_0 waittill("damage", var_4, var_2);

    if(isDefined(var_2) && isPlayer(var_2)) {
      var_3 = var_2 getcurrentweapon();
    }
  }

  return var_2;
}

_id_A6CF(var_0, var_1) {
  if(isDefined(var_1)) {
    var_0 endon(var_1);
  }

  var_0 setCanDamage(1);
  var_2 = undefined;
  var_3 = "";

  while(!issubstr(var_3, "teslagun_zm")) {
    if(!common_scripts\utility::_id_562E(var_0._id_8C8C)) {
      var_0 waittill("trigger", var_2);
      var_3 = var_2 getcurrentweapon();
      continue;
    }

    return level.players[0];
  }

  return var_2;
}

_id_9903(var_0, var_1, var_2, var_3) {
  if(issubstr(var_1, "teslagun_zm")) {
    return 1;
  } else {
    return 0;
  }
}

_id_9902(var_0, var_1, var_2, var_3) {
  self notify("death", var_0, var_2, var_1);
}

_id_9EC4() {
  var_0 = _getscriptablearray("village_off", "targetname");

  foreach(var_2 in var_0) {
    wait 0.1;
    var_2 setscriptablepartstate("lightpart", "off");
  }
}

_id_9EC5() {
  var_0 = _getscriptablearray("village_off", "targetname");

  foreach(var_2 in var_0) {
    wait 0.1;
    var_2 setscriptablepartstate("lightpart", "on");
  }
}

_id_3BEC() {
  var_0 = _getscriptablearray("fire_on", "targetname");

  foreach(var_2 in var_0) {
    wait 0.1;
    var_2 setscriptablepartstate("fire", "enable");
  }
}

_id_3BE6() {
  var_0 = _getscriptablearray("fill_on", "targetname");

  foreach(var_2 in var_0) {
    wait 0.1;
    var_2 setscriptablepartstate("fire_fill", "enable_fill");
  }
}

_id_1CCC() {
  var_0 = _getscriptablearray("brute_lighting", "targetname");

  foreach(var_2 in var_0) {
    wait 0.1;
    var_2 setscriptablepartstate("lightpart", "on");
  }
}

_id_1CCA() {
  var_0 = _getscriptablearray("brute_fire", "targetname");

  foreach(var_2 in var_0) {
    wait 0.1;
    var_2 setscriptablepartstate("fire1", "enable");
  }
}

_id_1CCB() {
  var_0 = _getscriptablearray("brute_lighting", "targetname");

  foreach(var_2 in var_0) {
    wait 0.1;
    var_2 setscriptablepartstate("lightpart", "off");
  }
}

_id_1CC9() {
  var_0 = _getscriptablearray("brute_fire", "targetname");

  foreach(var_2 in var_0) {
    wait 0.1;
    var_2 setscriptablepartstate("fire1", "die");
  }
}

_id_283B(var_0) {
  var_1 = newhudelem();
  var_1 setshader("hud_destructibledeathicon", 1, 1);
  var_1.alpha = 1;
  var_1.color = (1, 1, 1);
  var_1.x = var_0.origin[0];
  var_1.y = var_0.origin[1];
  var_1._id_01D9 = var_0.origin[2];
  var_1 setwaypoint(1);
  var_1 settargetEnt(var_0);
  return var_1;
}

_id_7AC3(var_0) {
  var_1 = self getanimentrycount(var_0);
  return randomint(var_1);
}

_id_8579(var_0) {
  self scragentsetscripted(1);
  self scragentsetphysicsmode("noclip");
  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", var_0);
}

_id_442B() {
  for(var_0 = 0; var_0 < self._id_AB4E.size; var_0++) {
    if(self._id_AB4E[var_0] _id_996A()) {
      return self._id_AB4E[var_0];
    }
  }

  return undefined;
}

_id_996A() {
  return !isDefined(self._id_65FB) || !isalive(self._id_65FB);
}

_id_442D(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(!isDefined(var_0[var_1]._id_65FB) || !isalive(var_0[var_1]._id_65FB)) {
      return var_0[var_1];
    }
  }

  return undefined;
}

_id_7402() {
  if(!isDefined(self)) {
    return 0;
  }

  if(!isPlayer(self)) {
    return 0;
  }

  return _id_055A::_id_7413(self, "zone3_1_com") || _id_055A::_id_7413(self, "zone3_2_med") || _id_055A::_id_7413(self, "zone3_3_rnd") || _id_055A::_id_7413(self, "zone4_1_mine");
}

_id_740A() {
  if(!isDefined(self)) {
    return 0;
  }

  if(!isPlayer(self)) {
    return 0;
  }

  return _id_055A::_id_7413(self, "zone1_1_start") || _id_055A::_id_7413(self, "zone1_2_gallows") || _id_055A::_id_7413(self, "zone1_3_riverside") || _id_055A::_id_7413(self, "zone1_4_bridge") || _id_055A::_id_7413(self, "zone1_4_bridge_tower") || _id_055A::_id_7413(self, "zone1_5_rooftops");
}

_id_7403() {
  if(!isDefined(self)) {
    return 0;
  }

  if(!isPlayer(self)) {
    return 0;
  }

  return _id_055A::_id_7413(self, "zone4_2_hilt");
}

_id_56B0(var_0, var_1, var_2, var_3) {
  var_4 = var_0.origin;

  if(isDefined(var_0._id_2E37)) {
    var_4 = var_0 gettagorigin(var_0._id_2E37);
  }

  if(common_scripts\utility::_id_562E(var_3)) {
    var_5 = _sighttracepassed(self.origin, var_4, 0, self, var_0, 0);

    if(!var_5) {
      return 0;
    }
  }

  if(isDefined(var_2)) {
    return _distance2d(var_4, self.origin) < var_1 && _abs(var_4[2] - self.origin[2]) < var_2;
  } else {
    return _distance2d(var_4, self.origin) < var_1 && self.origin[2] < var_4[2];
  }
}

_id_2024(var_0, var_1, var_2, var_3) {
  _id_0378::_id_8D74("aud_zombie_soul_absorb");

  if(!isDefined(level._id_6666)) {
    level._id_6666 = 0;
  }

  self waittill("body_spawned", var_4);

  if(!isDefined(var_4)) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  level._id_6666++;
  var_5 = _func_382("zmb_geistkraft_reg_beam_med", var_4, "j_neck", var_0, var_1);

  if(!isDefined(var_2)) {
    var_6 = "zmb_cart_charge_pnt";
  } else {
    var_6 = var_2;
  }

  if(!isDefined(var_3)) {
    var_7 = var_1;
  } else {
    var_7 = var_3;
  }

  _playFXOnTag(level._effect[var_6], var_0, var_7);
  _playFXOnTag(level._effect["zmb_gk_claw_battery_charge_1"], level._id_3571, "flap1_shroud");
  _playFXOnTag(level._effect["zmb_gk_claw_battery_charge_2"], level._id_3571, "flap2_shroud");
  _playFXOnTag(level._effect["zmb_gk_claw_battery_charge_3"], level._id_3571, "flap3_shroud");
  _id_0378::_id_8D74("zombie_soul_suck", var_4.origin, var_0.origin);
  wait 0.45;
  var_5 delete();
  level._id_6666--;
}

_id_9030(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = spawn("script_model", self.origin);
    var_4 setModel("tag_origin");
    _playFXOnTag(common_scripts\utility::_id_44F5("zmb_elec_trail"), var_4, "tag_origin");
    var_5 = distance(self.origin, var_0.origin) / var_1;
    var_4 moveTo(var_0.origin, var_5);
    wait(var_5);
    var_4 delete();
  }
}

_id_283C(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawn("script_model", var_0);
  var_6.angles = vectortoangles(var_1 + (0, 0, -50) - var_0);
  var_6 setModel(var_4);
  var_6 scriptmodelplayanim(var_5, "", var_2);
  var_6 rotateroll(_randomfloat(var_3), 1, 0.1, 0.1);
  var_6 rotatepitch(-20, 1, 0.1, 0);
  return var_6;
}

_id_9066(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level._effect[var_3])) {
    return;
  }
  var_5 = spawn("script_model", var_2);
  var_5 setModel("tag_origin");
  _playFXOnTag(common_scripts\utility::_id_44F5(var_3), var_5, "tag_origin");
  var_5 linktosynchronizedparent(var_0, var_1);
  var_5 thread _id_36EC(var_3, var_4);
}

_id_36EC(var_0, var_1) {
  level waittill(var_1);
  self delete();
}

_id_282D() {}

_id_649B(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_8 = 8;
  self._id_5787 = 0;

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  if(isDefined(var_4)) {
    self._id_9D02 = var_4;
  }

  for(var_9 = 1; var_9 < var_0.size; var_9++) {
    var_10 = var_0[var_9 - 1];
    var_11 = var_0[var_9];
    var_12 = var_0[var_9 + 1];
    var_13 = _id_0F3B(var_2, var_11);

    if(isDefined(var_4) && !self._id_5787) {
      _id_930B();
    }

    if(!_id_8B8D(var_11) || var_9 + 1 == var_0.size) {
      var_14 = distance(var_11.origin, var_10.origin) / var_1;

      if(var_13) {
        var_15 = var_14 / 3;
      } else {
        var_15 = 0;
      }

      _id_64D3(var_11, var_14, var_15);
    } else {
      var_9 = var_9 + 1;
      var_16 = var_10.origin;
      var_17 = var_11.origin;
      var_18 = var_12.origin;
      _id_64A1(var_16, var_17, var_18, var_8, var_1);
    }

    self waittill("reached node");

    if(var_13) {
      _id_9416();
      _id_A699();
      wait 1;
    }
  }

  if(var_5) {
    var_6 unlink();
    var_19 = vectorNormalize(var_0[var_0.size - 1].origin - var_0[var_0.size - 2].origin);
    var_20 = var_1;
    var_21 = (var_20 * var_19[0], var_20 * var_19[1], var_20 * var_19[2]);
    var_6 setvelocity(var_21);
  }

  _id_9416();
  self notify("path complete");
}

_id_A6AC(var_0) {
  var_1 = common_scripts\utility::_id_8FFC();

  foreach(var_3 in var_0) {
    var_3 thread _id_6815(var_1);
  }

  var_1 waittill("trigger", var_5);
  var_1 delete();
  return var_5;
}

_id_6815(var_0) {
  self waittill("trigger", var_1);
  var_0 notify("trigger", var_1);
}

_id_0FB7() {
  foreach(var_1 in self) {
    var_1 common_scripts\utility::_id_9D9F();
  }
}

_id_0FB8() {
  foreach(var_1 in self) {
    var_1 common_scripts\utility::_id_9DA3();
  }
}

_id_3C28() {
  self endon("flame_jets_done");
  var_0 = common_scripts\utility::_id_46B5("well_explosion", "script_noteworthy");
  var_1 = common_scripts\utility::_id_46B5(var_0.target, "targetname");
  var_2 = common_scripts\utility::_id_46B5(var_1.target, "targetname");
  var_3 = 2;
  var_4 = [];

  for(var_5 = 0; var_5 < var_3; var_5++) {
    var_4[var_5] = [];
    var_4[var_5] = _id_45FF("fire_path_launch_side_" + (var_5 + 1));
  }

  foreach(var_7 in level.players) {
    thread _id_A6A1(var_7, var_0, var_1, var_2, var_4);
  }
}

_id_A6A1(var_0, var_1, var_2, var_3, var_4) {
  self endon("flame_jets_done");
  var_5 = [];

  for(var_6 = 0; var_6 < var_4.size; var_6++) {
    if(!(var_4[var_6][0].targetname == "fire_path_launch_side_1")) {
      var_5 = common_scripts\utility::_id_0F6F(var_5, var_4[var_6]);
    }
  }

  for(;;) {
    var_0 waittill("fire_touched");

    if(!common_scripts\utility::_id_562E(var_0._id_5685) && common_scripts\utility::_id_562E(level._id_665A)) {
      if(_distance2d(var_0.origin, var_1.origin) < var_1.radius) {
        var_0._id_5685 = 1;
        var_0 thread _id_2FAD();
        var_0 thread _id_8CD6(var_1, var_2, var_3);
        continue;
      }

      if(var_0.origin[2] < var_1.origin[2]) {
        var_0._id_5685 = 1;
        var_0 thread _id_2FAD();

        if(common_scripts\utility::_id_562E(level._id_1CBA)) {
          var_0 thread _id_3C25(var_5);
          continue;
        }

        var_0 thread _id_3C25(var_4);
      }
    }
  }
}

_id_2FAD() {
  var_0 = self getcurrentweapon();
  self disableweapons();
  self shellshock("frag_grenade_mp", 1);
  wait 0.25;
  self enableweapons();
}

_id_47C2(var_0, var_1, var_2) {
  wait(var_2);
  _id_0586::_id_0790(var_0);
  self enableweaponswitch();
  _id_0586::_id_078E(var_1);
}

_id_3C25(var_0) {
  var_1 = [];
  var_2 = -1;
  var_3 = undefined;

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    var_5 = distance(self.origin, var_0[var_4][0].origin);

    if(var_2 == -1 || var_5 < var_2) {
      var_3 = var_0[var_4];
      var_2 = var_5;
    }
  }

  var_6 = _id_053F::_id_44A6(var_3[0]._id_0165);

  if(isDefined(var_6) && !common_scripts\utility::_id_562E(var_6._id_6BE1)) {
    return;
  }
  var_7 = var_3;
  var_3 = _id_9DC8(var_3, self);

  if(isDefined(var_3) && var_3.size >= 2) {
    _id_86E4(var_3);
  } else {
    _id_86E4(var_7);
  }
}

_id_9DC8(var_0, var_1) {
  var_2 = 0;
  var_3 = -1;

  for(var_4 = 1; var_4 < var_0.size; var_4++) {
    var_5 = distance(var_1.origin, var_0[var_4].origin);
    var_6 = distance(var_1.origin, var_0[var_2].origin);

    if(var_3 == -1 || var_5 < var_6) {
      var_2 = var_4;
      var_3 = var_5;
    }
  }

  var_7 = [];

  for(var_4 = var_2; var_4 < var_0.size; var_4++) {
    var_7[var_7.size] = var_0[var_4];
  }

  if(var_7.size >= 3) {
    var_7 = common_scripts\utility::_id_0F93(var_7, var_7[0]);
  }

  return var_7;
}

_id_86E4(var_0) {
  var_1 = _id_90A9(self.origin);
  var_1.origin = var_0[0].origin;
  var_1.angles = var_0[0].angles;
  self.origin = var_1.origin;
  self setplayerangles(var_1.angles);
  self playerlinktoabsolute(var_1);
  var_1 thread _id_649B(var_0, 1000, 0, undefined, undefined, 1, self);
  var_1 waittill("path complete");
  self unlink();
  var_1 delete();
}

_id_8CD6(var_0, var_1, var_2) {
  var_3 = 800;
  var_4 = 800;
  var_5 = var_0.origin + (0, 0, 32);
  var_6 = var_5[2] - self.origin[2];

  if(var_6 > 0) {
    var_7 = common_scripts\utility::_id_8FFC();
    self playerlinkTo(var_7);
    var_8 = var_6 / var_4;
    var_7 moveTo((self.origin[0], self.origin[1], var_5[2]), var_8);
    wait(var_8);
    self unlink();
    var_7 delete();
  }

  var_9 = -64;
  var_10 = _abs(var_1.origin[2] - self.origin[2]);
  var_10 = var_10 + var_9;
  var_11 = _abs(_distance2d(var_5, var_2.origin) - _distance2d(var_5, self.origin));
  var_12 = _sqrt(2 * var_3 * var_10);
  var_13 = _abs(_id_8F12(0.5 * var_3, var_12, var_5[2] - self.origin[2]));
  var_14 = var_12 / var_3;
  var_15 = vectorNormalize(self.origin - (var_5[0], var_5[1], self.origin[2]));
  var_16 = var_11 / var_13;
  var_17 = (var_16 * var_15[0], var_16 * var_15[1], var_12);
  var_18 = common_scripts\utility::_id_46B5("nest_ee_arm_fire_objective_angle", "targetname");
  self setvelocity(var_17);
  thread _id_7726(var_14, var_1.origin[2] + var_9);
  thread _id_7722(var_13, _distance2d(var_5, var_2.origin), var_5);
}

_id_A016(var_0, var_1) {
  wait(var_0);
  self unlink();
  var_1 delete();
}

_id_8F12(var_0, var_1, var_2) {
  var_3 = var_1 * var_1 - 4 * var_0 * var_2;
  var_4 = 0;
  var_5 = 0;

  if(var_3 > 0) {
    var_4 = (-1 * var_1 + _sqrt(var_3)) / (2 * var_0);
    var_5 = (-1 * var_1 - _sqrt(var_3)) / (2 * var_0);
  }

  return var_5;
}

_id_7726(var_0, var_1) {
  wait(var_0);
}

_id_7722(var_0, var_1, var_2) {
  wait(var_0);
}

_id_9416() {
  self._id_5787 = 0;
  self stoploopsound(self._id_9D02);
}

_id_930B() {
  self playLoopSound(self._id_9D02);
  self._id_5787 = 1;
}

_id_8B8D(var_0) {
  return var_0 _id_576F();
}

_id_202C() {
  return isDefined(level._id_3571) && common_scripts\utility::_id_562E(level._id_3571._id_692A);
}

_id_64D3(var_0, var_1, var_2) {
  thread _id_321A(var_0, var_1, var_2);
}

_id_321A(var_0, var_1, var_2) {
  self moveTo(var_0.origin, var_1, 0, var_2);
  self rotateTo(var_0.angles, var_1 / 2);
  wait(var_1);
  self notify("reached node");
}

_id_0F3B(var_0, var_1) {
  return var_0 && var_1 _id_56AC();
}

_id_64A1(var_0, var_1, var_2, var_3, var_4) {
  thread _id_38DF(var_0, var_1, var_2, var_3, var_4);
}

_id_38DF(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0;

  for(var_6 = 0; var_6 < var_3; var_6++) {
    var_7 = var_6 / var_3;
    var_8 = _id_1E4C(var_0, var_1, var_2, var_7);
    var_9 = distance(var_8, var_5) / var_4;
    var_5 = var_8;

    if(!(var_9 > 0)) {
      var_9 = 0.1;
    }

    self moveTo(var_8, var_9);
    wait(var_9);
  }

  self notify("reached node");
}

_id_A699(var_0, var_1) {
  if(isDefined(var_0) && !isDefined(var_1)) {
    var_1 = "TAG_ORIGIN";
  }

  if(isDefined(var_0)) {
    _playFXOnTag(common_scripts\utility::_id_44F5(var_0), self, var_1);
  }

  self._id_2DA8 = 1;
  self waittill("destination requirement satisfied");
  self._id_2DA8 = 0;

  if(isDefined(var_0)) {
    _stopFXOnTag(common_scripts\utility::_id_44F5(var_0), self, var_1);
  }
}

_id_56AF(var_0, var_1) {
  return _distance2d(var_0, self.origin) < var_1;
}

_id_5687(var_0) {
  return self.origin[2] < var_0[2];
}

_id_565C(var_0) {
  return self.origin[2] > var_0[2];
}

_id_1E4C(var_0, var_1, var_2, var_3) {
  return var_0 * _squared(1 - var_3) + var_1 * 2 * var_3 * (1 - var_3) + var_2 * _squared(var_3);
}

_id_8B8A(var_0) {
  return distance(self.origin, var_0) < 64 && isalive(self) && !common_scripts\utility::_id_562E(self._id_98EF) && !common_scripts\utility::_id_562E(self._id_AC06);
}

_id_A6BB() {
  while(!isDefined(level.players)) {
    wait 0.1;
  }
}

_id_9484(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_1[var_2] = var_0[var_2].origin;
  }

  return var_1;
}

_id_45FF(var_0) {
  var_1 = common_scripts\utility::_id_46B5(var_0, "targetname");

  for(var_2 = [var_1]; !var_1 _id_5773(); var_2 = common_scripts\utility::_id_0F6F(var_2, var_1)) {
    var_1 = common_scripts\utility::_id_46B5(var_1.target, "targetname");
  }

  return var_2;
}

_id_5773() {
  return isDefined(self._id_0165) && self._id_0165 == "path_end";
}

_id_576F() {
  return isDefined(self._id_0165) && self._id_0165 == "spline_start";
}

_id_56AC() {
  return isDefined(self._id_0165) && self._id_0165 == "destination_point";
}

_id_A16D(var_0) {
  if(isDefined(self._id_3F3F)) {
    self._id_3F3F delete();
  }

  var_1 = undefined;

  switch (var_0) {
    case "red":
      var_1 = "zmb_nest_generator_bulb_red";
      break;
    case "green":
      var_1 = "zmb_nest_generator_bulb_green";
      break;
    default:
      break;
  }

  if(isDefined(var_1)) {
    self._id_3F3F = _spawnfx(common_scripts\utility::_id_44F5(var_1), self.origin, anglesToForward(self.angles), anglestoup(self.angles));
    self._id_2916 = var_0;
  }

  if(gettime() < 500) {
    _triggerfx(self._id_3F3F, 0.5);
  } else {
    _triggerfx(self._id_3F3F);
  }
}

_id_21CF(var_0, var_1, var_2, var_3) {
  return _id_56B0(var_0, var_1, var_2, var_3);
}

_id_865C(var_0, var_1) {
  if(common_scripts\utility::_id_562E(var_1)) {
    self._id_2A9D = var_0;
  } else if(self._id_0BA4 != "traverse") {
    self._id_2A9D = var_0;
  }
}

_id_64DC(var_0, var_1, var_2, var_3) {
  self endon(var_2);
  var_4 = self.origin;
  var_5 = var_1 / var_3;

  for(var_6 = 0; var_6 < var_1; var_6 = var_6 + var_5) {
    self moveTo(_vectorlerp(var_4, var_0, var_6 / var_1), var_5);
    wait(var_5);
  }
}

_id_90A9(var_0) {
  var_1 = spawn("script_model", var_0);
  var_1 setModel("tag_origin");
  return var_1;
}

_id_3E23() {
  self setstance("prone");
  self allowcrouch(0);
  self allowstand(0);
}

_id_1F3D() {
  self allowcrouch(1);
  self allowstand(1);
  thread _id_2CEB(0.5);
}

_id_2CEB(var_0) {
  wait(var_0);
  self setstance("stand");
}

_id_8A64(var_0) {
  _id_0586::_id_078C(var_0);
  _id_0586::_id_078E(var_0);
}

_id_2CDD(var_0) {
  _id_A6BB();
  wait 3;
}

_id_745D(var_0, var_1, var_2) {
  if(!isDefined(level.players)) {
    return [0, undefined];
  }

  foreach(var_4 in level.players) {
    if(_distance2d(var_4.origin, var_0) < var_1 && _abs(var_4.origin[2] - var_0[2]) < var_2 / 2) {
      return [1, var_4];
    }
  }

  return [0, undefined];
}

_id_44C8(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = [];

  if(var_1) {
    var_2[0] = common_scripts\utility::_id_46B5(var_0, "targetname");
  } else {
    var_2[0] = _getEnt(var_0, "targetname");
  }

  while(isDefined(var_2[var_2.size - 1].target)) {
    if(var_1) {
      var_2 = common_scripts\utility::_id_0F6F(var_2, common_scripts\utility::_id_46B5(var_2[var_2.size - 1].target, "targetname"));
      continue;
    }

    var_2 = common_scripts\utility::_id_0F6F(var_2, _getEnt(var_2[var_2.size - 1].target, "targetname"));
  }

  return var_2;
}

_id_73B8() {
  self endon("disconnect");

  for(;;) {
    if(common_scripts\utility::_id_3C77("flag_bunker_lights_off")) {
      if(_id_7402()) {
        if(!isDefined(self._id_3D4C)) {
          _id_0551::_id_3D52(1);
        }
      } else if(isDefined(self._id_3D4C))
        _id_0551::_id_3D52(0);
    } else {
      if(isDefined(self._id_3D4C)) {
        _id_0551::_id_3D52(0);
      }

      common_scripts\utility::_id_3C9F("flag_bunker_lights_off");
    }

    wait 1;
  }
}

#using_animtree("destructibles");

_id_08B0() {
  var_0 = _getanimlength(%zmb_untotenpresse_01_reset);
  var_1 = _getnotetracktimes(%zmb_untotenpresse_01_reset, "create_ww_part");
  var_2 = var_1[0] * var_0;
  var_3 = _getscriptablearray("med_untotenpresse_smasher", "targetname");

  foreach(var_5 in var_3) {
    var_5 setscriptablepartstate("smasher", "working", 0);
    var_5 _id_0378::_id_8D74("aud_start_med_forge");
  }

  wait(_getanimlength(%zmb_untotenpresse_01_activate));

  foreach(var_5 in var_3) {
    var_5 setscriptablepartstate("smasher", "reset", 0);
  }

  wait(var_2);
  level notify("med_create_ww_part");
  wait(var_0 - var_2);

  foreach(var_5 in var_3) {
    var_5 setscriptablepartstate("smasher", "refill", 0);
  }

  wait(_getanimlength(%zmb_untotenpresse_01_refill));

  foreach(var_5 in var_3) {
    var_5 setscriptablepartstate("smasher", "second_idle", 0);
  }
}

_id_08B6() {
  var_0 = % zmb_forge_machine_01_parts_activate_01;
  var_1 = _getanimlength(var_0);
  var_2 = _getnotetracktimes(var_0, "piston_hit");
  var_3 = _getnotetracktimes(var_0, "create_ww_part");
  var_4 = _getnotetracktimes(var_0, "show_ww_part");
  var_5 = [];

  for(var_6 = 0; var_6 < var_2.size; var_6++) {
    var_5[var_6] = var_2[var_6] * var_1;
  }

  var_7 = var_4[0] * var_1;
  var_8 = var_3[0] * var_1;
  var_9 = _getscriptablearray("rnd_forge_machine_parts", "targetname");
  var_9[0] thread _id_7EB0(var_5, var_1);

  foreach(var_11 in var_9) {
    var_11 setscriptablepartstate("pistons", "working", 0);
    var_11 setscriptablepartstate("core", "working", 0);
    var_11 _id_0378::_id_8D74("aud_start_rnd_forge");
  }

  wait(var_7);
  level notify("rnd_show_ww_part");
  wait(var_8 - var_7);
  level notify("rnd_create_ww_part");
  wait(var_1 - (var_8 - var_7));
  level notify("rnd_stop_pistons");

  foreach(var_11 in var_9) {
    var_11 setscriptablepartstate("core", "idle", 0);
    var_11 setscriptablepartstate("pistons", "idle", 0);
  }
}

_id_7EB0(var_0, var_1) {
  level endon("rnd_stop_pistons");

  if(var_0.size == 0) {
    return;
  }
  var_2 = 0;
  var_3 = 0;

  for(;;) {
    if(!isDefined(var_0[var_3])) {
      break;
    }

    wait(var_0[var_3] - var_2);
    var_2 = var_0[var_3];
    var_3++;
    thread _id_74D2();
  }
}

_id_74D2() {
  _earthquake(0.25, 0.25, self.origin, 500);
  _playrumbleonposition("artillery_rumble", self.origin);
}

_id_08A8() {
  var_0 = getEntArray("com_control_elec", "targetname");

  foreach(var_2 in var_0) {
    var_2.schnelleeffects = _spawnfx(level._effect["zmb_electroschnelle_reg_chg_wv"], var_2.origin, anglesToForward(var_2.angles));
    _triggerfx(var_2.schnelleeffects);
  }

  var_4 = _getscriptablearray("workbench_inner", "targetname");
  var_5 = _getanimlength(%zmb_workbench_01_inner_up);
  var_6 = _getanimlength(%zmb_workbench_01_inner_up_idle);
  var_7 = _getanimlength(%zmb_workbench_01_inner_down);

  foreach(var_9 in var_4) {
    var_9 setscriptablepartstate("inner", "up", 0);
  }

  _playFXOnTag(level._effect["zmb_gk_claw_battery_full_1"], level._id_3571, "flap1_shroud");
  _playFXOnTag(level._effect["zmb_gk_claw_battery_full_2"], level._id_3571, "flap2_shroud");
  _playFXOnTag(level._effect["zmb_gk_claw_battery_full_3"], level._id_3571, "flap3_shroud");
  wait(var_5);

  foreach(var_9 in var_4) {
    var_9 setscriptablepartstate("inner", "up_idle", 0);
  }

  wait(var_6);

  foreach(var_9 in var_4) {
    var_9 setscriptablepartstate("inner", "down", 0);
  }

  wait(var_7);

  foreach(var_2 in var_0) {
    var_2.schnelleeffects delete();
  }
}

_id_8A53() {
  var_0 = spawnStruct();
  var_0._id_6FC5 = _getEnt("ww_part_01_pickup", "targetname");
  var_0._id_6FC2 = _getEnt(var_0._id_6FC5.target, "targetname");
  _playFXOnTag(level._effect["zmb_tesla_barrel_prop_idle"], var_0._id_6FC2, "TAG_ORIGIN");
  var_1 = spawnStruct();
  var_1._id_6FC5 = _getEnt("ww_part_02_pickup", "targetname");
  var_1._id_6FC2 = _getEnt(var_1._id_6FC5.target, "targetname");
  _playFXOnTag(level._effect["zmb_tesla_tube_prop_idle"], var_1._id_6FC2, "TAG_ORIGIN");
  var_0._id_6FC5 common_scripts\utility::_id_9D9F();
  var_1._id_6FC5 common_scripts\utility::_id_9D9F();
  var_0._id_6FC5 useTriggerRequireLookAt();
  var_1._id_6FC5 useTriggerRequireLookAt();

  if(isDefined(var_0._id_6FC2) && isDefined(var_1._id_6FC2)) {
    var_0._id_6FC2 hide();
    var_1._id_6FC2 hide();
  }

  var_2 = _getscriptablearray("rnd_forge_machine_parts", "targetname");
  var_0._id_6FC2 linkTo(var_2[0], "input");
  level._id_3E3B = var_0;
  level._id_5981 = var_1;
}

_id_8BEC(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    self._id_6FC5 setHintString(var_3);
  }

  if(isDefined(var_0)) {
    common_scripts\utility::_id_3C9F(var_0);
  }

  self._id_6FC2 show();

  if(isDefined(var_2)) {
    common_scripts\utility::_id_3C9F(var_2);
  }

  self._id_6FC5 common_scripts\utility::_id_9DA3();
  self._id_6FC5 waittill("trigger", var_4);

  if(isDefined(var_1)) {
    common_scripts\utility::flag_set(var_1);
  }

  self._id_6FC5 common_scripts\utility::_id_9D9F();
  self._id_6FC2 hide();
  return var_4;
}

_id_4D76() {
  var_0 = % zmb_hilt_altar_control_activate;
  var_1 = _getanimlength(var_0);
  self scriptmodelplayanim(_debuggetanimname(var_0));
  wait(var_1);
}

_id_4D77(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  switch (var_0) {
    case "off":
      self hidepart("TAG_LIGHT_OFF");
      self hidepart("TAG_LIGHT_ON");
      break;
    case "red":
      self hidepart("TAG_LIGHT_ON");
      self showpart("TAG_LIGHT_OFF");
      break;
    case "green":
      self hidepart("TAG_LIGHT_OFF");
      self showpart("TAG_LIGHT_ON");
      break;
  }
}

_id_4D78(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = _getscriptablearray("hilt_symbol_wheel", "targetname");
  var_2 = _getanimlength(%s2_zom_prop_symbol_wheel_lh_p1);
  var_3 = _getanimlength(%s2_zom_prop_symbol_wheel_lh_p2);
  var_4 = _getanimlength(%s2_zom_prop_symbol_wheel_rh_p1);
  var_5 = _getanimlength(%s2_zom_prop_symbol_wheel_rh_p2);
  var_6 = 1;
  var_7 = 1;
  var_8 = "p4_idle";
  var_9 = "p4_idle";

  switch (var_0) {
    case 0:
      break;
    case 1:
      var_8 = "p1";
      var_6 = var_2;
      var_9 = "p4_idle";
      break;
    case 2:
      var_8 = "p1_idle";
      var_9 = "p1";
      var_7 = var_4;
      break;
    case 3:
      var_8 = "p2";
      var_6 = var_3;
      var_9 = "p2";
      var_7 = var_5;
      break;
  }

  foreach(var_11 in var_1) {
    var_11 thread _id_A197("wheel_l", var_8, var_6);
    var_11 thread _id_A197("wheel_r", var_9, var_7);
  }

  wait(max(var_6, var_7));
}

_id_A197(var_0, var_1, var_2) {
  switch (var_1) {
    case "p4":
    case "p3":
    case "p2":
    case "p1":
      self setscriptablepartstate(var_0, var_1);
      wait(var_2);
      self setscriptablepartstate(var_0, var_1 + "_idle");
      break;
    case "p3_idle":
    case "p2_idle":
    case "p1_idle":
    case "p4_idle":
      self setscriptablepartstate(var_0, var_1);
      break;
  }
}

_id_7212(var_0) {
  var_1 = _id_4649();

  if(isDefined(var_1)) {
    var_1 thread _id_0367::_id_8E3C(var_0);
  }
}

_id_4649() {
  var_0 = _id_440D();
  return common_scripts\utility::random(var_0);
}

_id_440D() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(isalive(var_2) && !var_2.inlaststand) {
      var_0 = common_scripts\utility::_id_0F6F(var_0, var_2);
    }
  }

  return var_0;
}

_id_8A38(var_0, var_1, var_2) {
  var_3 = undefined;

  foreach(var_5 in level._id_A2A0) {
    if(_id_0547::_id_5565(var_5.targetname, var_0)) {
      var_3 = var_5;
    }
  }

  if(isDefined(var_1) && isDefined(var_3._id_9D65)) {
    var_3 _id_0547::_id_A28D(var_1, var_2);
    var_3._id_9D65 setHintString(var_1);
  }

  return var_3;
}

_id_7213(var_0, var_1, var_2, var_3) {
  var_4 = [0, undefined];

  while(!var_4[0]) {
    var_4 = _id_745D(var_1, var_2, var_3);
    wait 1;
  }

  var_4[1] thread _id_0367::_id_8E3C(var_0);
}

_id_720B(var_0, var_1, var_2, var_3) {
  var_4 = [0, undefined];

  while(!var_4[0]) {
    var_4 = _id_745D(var_1, var_2, var_3);
    wait 1;
  }

  var_4[1] thread _id_0367::_id_8E3B(var_0);
}

_id_4462(var_0) {
  var_1 = _id_440D();
  return common_scripts\utility::_id_4461(var_0, var_1);
}

_id_44BA(var_0) {
  var_1 = "mp/zombieSpecialEnemyWaves.csv";
  var_2 = [];
  var_0 = var_0 - 1;
  var_3 = var_0 * 5;
  var_4 = _id_0547::_id_9470(_tablelookupbyrow(var_1, var_3 + 0, 2));
  var_5 = _id_0547::_id_9470(_tablelookupbyrow(var_1, var_3 + 1, 2));
  var_6 = _id_0547::_id_9470(_tablelookupbyrow(var_1, var_3 + 2, 2));
  var_7 = _id_0547::_id_9470(_tablelookupbyrow(var_1, var_3 + 3, 2));
  var_8 = _id_0547::_id_9470(_tablelookupbyrow(var_1, var_3 + 4, 2));

  for(var_9 = 0; var_9 < var_4; var_9++) {
    var_2 = common_scripts\utility::_id_0F6F(var_2, "zombie_generic");
  }

  for(var_9 = 0; var_9 < var_5; var_9++) {
    var_2 = common_scripts\utility::_id_0F6F(var_2, "zombie_berserker");
  }

  for(var_9 = 0; var_9 < var_6; var_9++) {
    var_2 = common_scripts\utility::_id_0F6F(var_2, "zombie_exploder");
  }

  for(var_9 = 0; var_9 < var_7; var_9++) {
    var_2 = common_scripts\utility::_id_0F6F(var_2, "zombie_heavy");
  }

  level._id_2932 = 0;

  for(var_9 = 0; var_9 < var_8; var_9++) {
    level._id_2932++;
  }

  return common_scripts\utility::array_randomize(var_2);
}

_id_44BB(var_0) {
  var_0 = var_0 - 1;
  var_1 = var_0 * 5;
  var_2 = "mp/zombieSpecialEnemyWaves.csv";
  var_3 = _id_0547::_id_9470(_tablelookupbyrow(var_2, var_1, 3));
  return var_3;
}

_id_A7DF() {
  level notify("exited_special_event");
  waitframe();
  _id_0548::_id_A7E5(0);

  foreach(var_1 in level.players) {
    var_1 notify("special_event_update");
  }
}

_id_A7E0() {
  level endon("exited_special_event");
  _id_0548::_id_A7E5(1);

  foreach(var_1 in level.players) {
    var_1 notify("special_event_update");
  }

  for(;;) {
    level waittill("connected", var_1);
    var_1 notify("special_event_update");
  }
}

_id_A725(var_0) {
  self setCanDamage(1);

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(!isPlayer(var_2)) {
      continue;
    }
    if(!isDefined(var_10) || !issubstr(var_10, var_0)) {
      continue;
    }
    break;
  }
}

_id_98ED(var_0, var_1) {
  switch (var_0) {
    case "teslagun_zm":
      var_1 = 2000;
      break;
    case "teslagun_zm_blood":
      var_1 = 3000;
      break;
    case "teslagun_zm_death":
      var_1 = 3000;
      break;
    case "teslagun_zm_moon":
      var_1 = 3000;
      break;
    case "teslagun_zm_storm":
      var_1 = 3000;
      break;
    default:
      break;
  }

  return var_1;
}