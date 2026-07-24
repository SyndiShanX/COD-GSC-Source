/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3629.gsc
**************************************/

_id_112B5() {
  precachemodel("veh_mil_air_un_pocketdrone");
  precachemodel("veh_mil_air_un_pocketdrone_dyn");
  precachemodel("veh_mil_air_un_pocketdrone_shotdown_flight_body_dangle");
  precachemodel("veh_mil_air_un_pocketdrone_shotdown_crash_body_dangle");
  precachemodel("veh_mil_air_un_pocketdrone_timeout_crash_body_4fan");
  precacheitem("supportdrone_trophy_turret");
  precacheitem("supportdrone");
  precacheitem("supportdrone_up2");
  precacheshader("hud_icon_wireless");
  precacheshader("overlay_static");
  precacheshader("icon_ability_drone");
  precacheshader("cb_remotemissile_target_hostile");
  setdvarifuninitialized("support_drone_debug", 0);
  setdvarifuninitialized("scan_ability", 1);
  level._effect["drone_thruster"] = loadfx("vfx/iw7/core/equipment/drone/vfx_drone_down_thrust_child.vfx");
  level._effect["drone_damaged_loop"] = loadfx("vfx/iw7/core/equipment/drone/vfx_drone_damage_malfunction_loop.vfx");
  level._effect["drone_trophy_laser"] = loadfx("vfx/iw7/core/equipment/drone/vfx_drone_muzzle_flash_trophy_r.vfx");
  level._effect["drone_trophy_pop"] = loadfx("vfx/iw7/core/equipment/drone/vfx_drone_trophy_pop.vfx");
  level._effect["drone_shotdown_air_damage"] = loadfx("vfx/iw7/core/equipment/drone/vfx_drone_death_shotdown.vfx");
  level._effect["drone_death_hit_ground"] = loadfx("vfx/iw7/core/equipment/drone/vfx_drone_death.vfx");
  level.player scripts\sp\utility::_id_65E0("player_support_drone_active");
  level.player scripts\sp\utility::_id_65E0("support_drone_spawning");
  level._id_5C19 = [91, 83, 108, 72];
  level._id_5C18 = 0;
  level.player._id_5CA6 = [];
  level.player._id_5C6E = 0;
  level.player._id_5C4F = 0;
  level.player._id_4C29 = [];
  level.player thread _id_5BE1();
  scripts\sp\utility::_id_9189("default_supdrone", 2, "default");
}

_id_5138() {
  scripts\sp\utility::_id_228A(level.player._id_5CA6);
  level.player._id_5CA6 = scripts\engine\utility::array_removeundefined(level.player._id_5CA6);
}

_id_5C9E() {
  self endon("death");
  self endon("support_drone_think");
  var_0 = _id_129A();

  for(;;) {
    self waittill("secondary_equipment_change");
    waittillframeend;

    if(!isDefined(scripts\sp\utility::_id_7C3D()) || scripts\sp\utility::_id_7C3D() != var_0) {
      break;
    }
  }

  scripts\engine\utility::flag_clear("secondary_equipment_in_use");
  self notify("drone_unequipped");
}

_id_112BB() {
  self endon("death");
  self endon("drone_unequipped");
  self notify("support_drone_think");
  self endon("support_drone_think");
  thread _id_5C9E();
  var_0 = _id_112B8();

  for(;;) {
    level._id_112B9 = 0;

    for(;;) {
      self waittill("grenade_fire", var_1, var_2);

      if(var_2 == "supportdrone" || var_2 == "supportdrone_up2") {
        break;
      }
    }

    if(!_id_385A()) {
      wait 0.05;
      continue;
    }

    level.player scripts\sp\utility::_id_65E8("support_drone_spawning");
    level.player scripts\sp\utility::_id_65E1("support_drone_spawning");
    scripts\engine\utility::flag_set("secondary_equipment_in_use");
    level.player scripts\engine\utility::allow_usability(0);
    level.player scripts\sp\utility::_id_65E1("player_support_drone_active");

    if(!getdvarint("player_sustainAmmo", 0)) {
      var_3 = self getammocount(_id_129A());
      self setweaponammoclip(_id_129A(), var_3 - 1);
    }

    self notify("offhand_fired");
    var_4 = _id_112BA(var_0);
    var_4._id_D384 = _id_7B15();
    var_4._id_9180 = var_4._id_D384;
    self._id_4C29[var_4._id_D384] = spawnStruct();
    self._id_4C29[var_4._id_D384]._id_5BD7 = var_4;
    self._id_4C29[var_4._id_D384]._id_51BA = 0;
    self._id_4C29[var_4._id_D384]._id_9A96 = 1;
    self._id_4C29[var_4._id_D384]._id_C7B4 = 0;
    _id_F377(var_4._id_9180, "active");
    _id_5C32(var_4._id_9180, var_4.ammocount);
    level.player scripts\engine\utility::allow_usability(1);
    scripts\engine\utility::flag_clear("secondary_equipment_in_use");
    level.player thread scripts\sp\utility::_id_65DE("support_drone_spawning", 0.05);
  }
}

_id_5BE1() {
  self endon("death");

  for(;;) {
    var_0 = 0;

    for(var_1 = 0; var_1 < 5; var_1++) {
      if(isDefined(self._id_4C29[var_1]) && self._id_4C29[var_1]._id_51BA == 1) {
        self._id_4C29[var_1] = undefined;
        level notify("drone_max_cleanup");
        var_0 = 1;
      }
    }

    if(var_0) {
      var_2 = 0;

      for(var_1 = 0; var_1 < 5; var_1++) {
        if(isDefined(self._id_4C29[var_1]) && isDefined(self._id_4C29[var_1]._id_5BD7)) {
          self._id_4C29[var_1]._id_5BD7._id_D384 = var_2;
          var_2++;
        }
      }
    }

    if(level.player._id_5C6E > 0)
      level.player._id_5C6E = level.player._id_5C6E - 0.05;

    if(level.player._id_5C4F > 0)
      level.player._id_5C4F = level.player._id_5C4F - 0.05;

    wait 0.05;
  }
}

_id_7AC7() {
  if(isDefined(self._id_5CB3))
    return 5;
  else
    return 3;
}

_id_7B32() {
  var_0 = 0;

  for(var_1 = 0; var_1 < _id_7AC7(); var_1++) {
    if(isDefined(self._id_4C29[var_1]))
      var_0++;
  }

  return var_0;
}

_id_7B15() {
  for(var_0 = 0; var_0 < _id_7AC7(); var_0++) {
    if(!isDefined(self._id_4C29[var_0]))
      return var_0;
  }

  return undefined;
}

_id_385A() {
  if(!self _meth_843C() || self isreloading() || !scripts\engine\utility::isoffhandweaponsallowed() || !scripts\engine\utility::isoffhandsecondaryweaponsallowed())
    return 0;

  var_0 = self getammocount(_id_129A());

  if(var_0 <= 0)
    return 0;

  if(_id_7B32() >= _id_7AC7() - 1) {
    thread _id_C808();

    while(_id_7B32() > _id_7AC7() - 1)
      wait 0.05;

    return 1;
  }

  return 1;
}

_id_C808() {
  if(!isDefined(level.player._id_4C29)) {
    return;
  }
  for(;;) {
    var_0 = undefined;
    var_1 = undefined;

    for(var_2 = 0; var_2 < 5; var_2++) {
      if(!isDefined(level.player._id_4C29[var_2])) {
        continue;
      }
      if(isDefined(level.player._id_4C29[var_2]._id_E0EC) && level.player._id_4C29[var_2]._id_E0EC) {
        continue;
      }
      if(isDefined(level.player._id_4C29[var_2]._id_9A96) && level.player._id_4C29[var_2]._id_9A96) {
        continue;
      }
      if(!isDefined(var_0) || level.player._id_4C29[var_2]._id_5BD7.ammocount < var_0) {
        var_0 = level.player._id_4C29[var_2]._id_5BD7.ammocount;
        var_1 = var_2;
      }
    }

    if(isDefined(var_1)) {
      level.player._id_4C29[var_1]._id_5BD7 notify("timeout");
      level.player._id_4C29[var_1]._id_E0EC = 1;
      break;
    }

    wait 0.1;
  }
}

#using_animtree("vehicles");

_id_112BA(var_0) {
  var_1 = getEntArray("support_drone_spawner", "targetname");
  var_2 = var_1[0];
  level.player thread scripts\sp\utility::play_sound_on_entity("support_drone_activate");
  self notify("drone_spawned");
  var_3 = level.player getplayerangles();
  var_4 = scripts\engine\utility::flat_angle(var_3);
  var_5 = level.player getEye();
  var_6 = anglestoup(var_3);
  var_7 = anglestoup(var_4);
  var_8 = anglesToForward(var_4);
  var_9 = 24.0;
  var_10 = 24;
  var_11 = var_5;
  var_12 = scripts\common\trace::ray_trace(var_5, var_5 + var_6 * (var_10 + var_9), undefined, scripts\common\trace::create_solid_ai_contents(1));

  if(var_12["fraction"] != 1.0) {
    var_12 = scripts\common\trace::ray_trace(var_5, var_5 + var_7 * (var_10 + var_9), undefined, scripts\common\trace::create_solid_ai_contents(1));

    if(var_12["fraction"] != 1.0)
      var_11 = var_5 + var_7 * var_10 * var_12["fraction"];
    else
      var_11 = var_5 + var_7 * var_10;
  } else
    var_11 = var_5 + var_6 * var_10;

  var_2.origin = var_11;
  var_2.angles = var_4;
  var_13 = var_2 scripts\sp\utility::_id_10808();
  var_13 _meth_83D0(#animtree);
  var_13 makeentitysentient("allies");
  var_13 makevehiclenotcollidewithplayers(1);
  var_13 setthreatbiasgroup("equipment");
  var_13 setCanDamage(1);
  var_13 scripts\sp\vehicle::_id_8441();
  var_13 _meth_839E();
  var_13._id_6DA5 = 0;
  var_13._id_C181 = 0;
  level.player._id_112AB = var_13;
  var_13.attackeraccuracy = 0.5;
  var_13._id_B00E = spawn("script_origin", (0, 0, 0));
  var_13 setlookatent(var_13._id_B00E);
  var_13._id_D630 = undefined;
  scripts\engine\utility::array_thread(var_0, ::_id_112B7, var_13);
  var_13 notify("stop_kicking_up_dust");
  var_13._id_2654 = 0;
  var_13.ammocount = 20;
  var_13 makeunusable();
  var_13 thread _id_5C1F();
  var_13 thread _id_5C4B(1, 1);

  if(!isDefined(var_13._id_B435))
    var_13._id_B435 = 100;

  var_13._id_1280E = 0;
  var_13 thread _id_112BC();
  var_13 thread _id_5C30();
  var_13 thread _id_5C55();
  var_13 thread _id_5C59();
  var_13 thread _id_5C5C();
  var_13 thread _id_5C3F();
  var_13 thread _id_5BED();
  var_13 thread _id_5C37();
  var_13 thread _id_5BF0();
  var_13 setanimknob(%equip_pocket_drone_hover_loop);
  return var_13;
}

_id_11719(var_0) {
  var_0 endon("death");
  iprintlnbold("Dpad Up: hover");
  iprintlnbold("Dpad Left: damaged");
  iprintlnbold("Dpad Right: death");
  level.player notifyonplayercommand("dpadup", "+actionslot 1");
  level.player notifyonplayercommand("dpaddown", "+actionslot 2");
  level.player notifyonplayercommand("dpadleft", "+actionslot 3");

  for(;;) {
    var_1 = level.player scripts\engine\utility::waittill_any_return("dpadup", "dpaddown", "dpadleft");

    if(var_1 == "dpadup") {
      iprintlnbold("hover");
      var_0 setanimknob(%equip_pocket_drone_hover_loop);
    } else if(var_1 == "dpadleft") {
      iprintlnbold("damaged");
      var_0 setanimknob(%equip_pocket_drone_damaged_loop);
    } else if(var_1 == "dpaddown") {
      iprintlnbold("death");
      var_0 setanimknob(%equip_pocket_drone_death_loop);
    }

    wait 0.25;
  }
}

_id_5C30() {
  if(isDefined(self._id_C93D)) {
    return;
  }
  if(self.team == "allies") {
    scripts\sp\utility::_id_9196(3, 0, 0, "default_supdrone");
    self._id_5CDB scripts\sp\utility::_id_9196(3, 0, 0, "default_supdrone");
  } else if(self.team == "axis") {
    scripts\sp\utility::_id_9196(1, 0, 0, "default_supdrone");
    self._id_5CDB scripts\sp\utility::_id_9196(1, 0, 0, "default_supdrone");
  }
}

_id_112BC() {
  foreach(var_1 in self.mgturret) {
    var_1 setturretteam("allies");
    var_1._id_5041 = "manual";
    var_1 setmode("manual");
    var_1 turretfireenable();
    var_1 setleftarc(90);
    var_1 setrightarc(90);
    var_1 settoparc(90);
    var_1 setbottomarc(90);
    var_1 _meth_82C9(0, "yaw");
    var_1 _meth_82C9(0, "pitch");
  }

  self._id_5CDB = self.mgturret[0];
  self.mgturret[0] show();
  self._id_5CAF = ::_id_5C0F;
}

_id_5C37() {
  self endon("death_anim");
  self endon("death");
  var_0 = 0;

  for(;;) {
    if(_id_D2DD())
      var_0 = 1;
    else if(level.player.ignoreme)
      var_0 = 1;
    else
      var_0 = 0;

    self.ignoreme = var_0;
    wait 0.1;
  }
}

_id_5C4B(var_0, var_1) {
  if(isDefined(var_0) && var_0)
    thread _id_5BD8();

  if(isDefined(var_1) && var_1)
    thread _id_5BDD();
}

_id_5C3F() {
  self endon("death_anim");
  self endon("death");
  wait 100.0;
  self notify("timeout");
}

_id_5BF0() {
  self endon("death_anim");
  self endon("death");
  var_0 = scripts\engine\utility::waittill_any_return("no_ammo", "lethal_damage", "timeout", "vr_delete");

  if(isDefined(level.player._id_4C29[self._id_9180]._id_9A96) && level.player._id_4C29[self._id_9180]._id_9A96) {
    while(level.player._id_4C29[self._id_9180]._id_9A96)
      wait 0.05;
  }

  thread _id_F378(self._id_9180, "off");

  if(var_0 == "no_ammo") {
    wait 1.0;
    thread _id_5BF5(1);
  } else if(var_0 == "lethal_damage")
    thread _id_5BF6();
  else if(var_0 == "timeout")
    thread _id_5BF5();
  else if(var_0 == "vr_delete")
    thread _id_5BF7();
}

_id_5BF5(var_0) {
  self notify("death_anim");

  if(isDefined(var_0) && var_0 == 1)
    _id_F377(self._id_9180, "noammo");
  else
    _id_F377(self._id_9180, "destroyed");

  scripts\sp\utility::_id_9193("default_supdrone");
  self._id_5CDB scripts\sp\utility::_id_9193("default_supdrone");
  self playSound("support_drone_engine_mvmt_death");
  self setanimknob(%equip_pocket_drone_death_loop);
  thread _id_5C0C("veh_mil_air_un_pocketdrone_timeout_crash_body_4fan");
}

_id_5BF7() {
  self notify("death_anim");
  _id_F377(self._id_9180, "destroyed");
  scripts\sp\utility::_id_9193("default_supdrone");
  self._id_5CDB scripts\sp\utility::_id_9193("default_supdrone");
  scripts\engine\utility::waitframe();

  if(isDefined(self._id_B00E))
    self._id_B00E delete();

  self delete();
}

_id_5BF6() {
  self notify("death_anim");
  _id_F377(self._id_9180, "destroyed");
  scripts\sp\utility::_id_9193("default_supdrone");
  self._id_5CDB scripts\sp\utility::_id_9193("default_supdrone");
  self playSound("support_drone_engine_mvmt_death");
  self setanimknob(%equip_pocket_drone_death_loop);

  if(isDefined(self.lastdamagedir))
    var_0 = self.lastdamagedir;
  else
    var_0 = anglestoright(level.player getplayerangles());

  if(var_0 == (0, 0, 0))
    var_0 = (1, 0, 0);

  var_1 = anglestoup(vectortoangles(var_0));
  playFX(level._effect["drone_shotdown_air_damage"], self.origin, var_0, var_1);
  self setModel("veh_mil_air_un_pocketdrone_shotdown_flight_body_dangle");
  thread _id_5C0C("veh_mil_air_un_pocketdrone_shotdown_crash_body_dangle");
}

_id_5C0C(var_0) {
  var_1 = anglesToForward(self.angles + (45, 0, 0) + (0, randomfloat(360), 0));
  var_2 = scripts\common\trace::ray_trace(self.origin, self.origin + var_1 * 999999, undefined, scripts\common\trace::create_solid_ai_contents(1));
  var_3 = distance(self.origin, var_2["position"]);
  var_4 = 0.43;
  var_5 = var_3 * var_4;
  self setneargoalnotifydist(var_5);
  thread _id_5C0D();
  self setmaxpitchroll(60, 60);
  self.angles = (45, 45, 0);
  self setvehgoalpos(var_2["position"], 0);
  self waittill("near_goal");

  if(!isDefined(self)) {
    return;
  }
  var_6 = 0.0568182;
  var_7 = self vehicle_getvelocity();
  var_8 = var_7 * var_6;
  var_9 = 2.5;
  var_10 = spawn("script_model", self.origin + var_8);
  var_10 setModel(var_0);
  var_10 hide();
  var_10.angles = self gettagangles("j_body");
  wait 0.05;
  var_10 show();
  var_10 physicslaunchserver(var_10.origin, var_7 * var_9);

  if(isDefined(self._id_B00E))
    self._id_B00E delete();

  self delete();
  var_11 = 0.1;
  var_12 = 64.0;
  var_13 = var_11 * (var_5 / var_12);
  wait(var_13);
  var_10 playSound("support_drone_engine_mvmt_death_impact_hit");
  playFX(level._effect["drone_death_hit_ground"], var_10.origin, anglesToForward(var_10.angles), anglestoup(var_10.angles));
  level.player._id_5CA6 = scripts\engine\utility::array_removeundefined(level.player._id_5CA6);

  if(level.player._id_5CA6.size >= 5) {
    level.player._id_5CA6[0] delete();
    level.player._id_5CA6 = scripts\engine\utility::array_removeundefined(level.player._id_5CA6);
  }

  level.player._id_5CA6[level.player._id_5CA6.size] = var_10;
  var_10 thread _id_5BE7();
}

_id_5BE7() {
  level.player endon("death");
  self endon("death");
  self endon("entitydeleted");

  for(;;) {
    if(distance(level.player.origin, self.origin) > 2200) {
      break;
    }

    wait 1;
  }

  level.player._id_5CA6 = scripts\engine\utility::array_remove(level.player._id_5CA6, self);
  self delete();
}

_id_5C0D() {
  self endon("death");
  self endon("near_goal");
  self vehicle_setspeed(30, 8, 8);
  wait 0.5;

  if(isDefined(self))
    self vehicle_setspeed(30, 25, 25);
}

_id_5C55() {
  self endon("death_anim");
  self endon("death");
  thread _id_5C44();
  self sethoverparams(2, 10, 10);
  self setyawspeedbyname("instant");
  self setneargoalnotifydist(64.0);
  self vehicle_setspeed(50, 50, 100);
  self._id_8435 = (0, 0, level._id_5C19[level._id_5C18]);
  level._id_5C18++;

  if(level._id_5C18 >= level._id_5C19.size)
    level._id_5C18 = 0;

  var_0 = 1;
  var_1 = (-3000, -3000, -3000);
  var_2 = (-3000, -3000, -3000);
  _id_5C57(var_2);

  for(;;) {
    wait 0.05;
    var_3 = undefined;
    self._id_6FFF = 0;
    var_4 = _id_5C52();

    if(var_4 == "follow") {
      var_5 = scripts\engine\utility::drop_to_ground(level.player.origin, 8.0);

      if(_id_5C56(var_5)) {
        var_3 = _id_5C54();
        var_2 = var_5;
        _id_5C57(var_2);
      } else {
        var_3 = var_1;
        _id_5C5A(var_2);
      }
    } else if(var_4 == "combat") {
      self._id_BE7A = scripts\sp\utility::array_removedeadvehicles(self._id_BE7A);

      if(isDefined(self._id_1155E) && isalive(self._id_1155E) && level.player._id_5C4F > 0)
        var_3 = var_1;
      else
        var_3 = _id_5C53(var_1);
    }

    if(var_1 == var_3) {
      continue;
    }
    var_1 = var_3;
    thread _id_5C61(var_3);
  }
}

_id_5C54() {
  var_0 = anglesToForward(level.player.angles);
  var_1 = anglestoright(level.player.angles);
  var_2 = scripts\engine\utility::drop_to_ground(level.player.origin, 8.0);
  var_3 = self._id_8435[2];
  var_4 = var_2 + (0, 0, var_3);
  var_5 = scripts\common\trace::ray_trace(var_2, var_4, undefined, scripts\common\trace::create_solid_ai_contents(1));

  if(var_5["fraction"] != 1.0)
    var_4 = var_2 + (0, 0, var_5["fraction"] * var_3 - 10.0);

  if(getdvarint("support_drone_debug"))
    thread scripts\engine\utility::draw_line_for_time(var_2, var_4, 0, 1, 1, 0.1);

  var_6 = 1.0;
  var_7 = 1.0;

  if(self._id_D384 == 1)
    var_7 = -1.0;
  else if(self._id_D384 == 2)
    var_6 = -1.0;
  else if(self._id_D384 >= 3) {
    var_6 = -1.0;
    var_7 = -1.0;
  }

  var_8 = 115 * var_6 + self._id_8435[0];
  var_9 = 45 * var_7 + self._id_8435[1];
  var_10 = var_4 + var_0 * var_8 + var_1 * var_9;
  var_5 = scripts\common\trace::ray_trace(var_4, var_10, undefined, scripts\common\trace::create_solid_ai_contents(1));

  if(var_5["fraction"] != 1.0) {
    var_11 = vectorNormalize(var_10 - var_4);
    var_12 = distance(var_10, var_4);
    var_10 = var_4 + var_11 * (var_5["fraction"] * var_12 - 10.0);
  }

  if(getdvarint("support_drone_debug"))
    thread scripts\engine\utility::draw_line_for_time(var_4, var_10, 0, 1, 1, 0.1);

  var_13 = var_10;

  if(getdvarint("support_drone_debug"))
    thread scripts\engine\utility::draw_line_for_time(var_13, var_13 + (0, 0, 16), 0, 0, 1, 0.1);

  var_14 = scripts\common\trace::ray_trace_passed(self.origin, var_13, undefined, scripts\common\trace::create_solid_ai_contents(1));

  if(var_14)
    self._id_6FFF = 1;
  else if(getdvarint("support_drone_debug"))
    thread scripts\engine\utility::draw_line_for_time(self.origin, var_13, 1, 0, 0, 0.1);

  var_15 = scripts\engine\utility::drop_to_ground(var_13, 0);
  var_16 = getclosestpointonnavmesh(var_15);
  var_17 = 1;

  if(distance(var_15, var_16) > 8.0) {
    if(getdvarint("support_drone_debug")) {
      thread scripts\engine\utility::draw_line_for_time(var_15, var_15 + (0, 0, 16), 1, 0, 0, 0.25);
      thread scripts\engine\utility::draw_line_for_time(var_16, var_16 + (0, 0, 16), 0, 1, 0, 0.25);
    }

    if(!self._id_6FFF)
      var_17 = 0;
  }

  var_18 = var_13;

  if(!var_17) {
    if(distance(var_2, var_16) > distance(var_2, var_15))
      var_18 = var_4;
    else
      var_18 = (var_16[0], var_16[1], var_4[2]);
  }

  self._id_1D55 = var_3;
  return var_18;
}

_id_5C57(var_0) {
  self._id_4B2E = 6;
  self._id_4B2F = var_0;
}

_id_5C5A(var_0) {
  var_1 = 4.88;
  self._id_4B2E = min(self._id_4B2E + var_1, 128);

  if(self._id_4B2E != 128) {
    var_2 = self.origin - var_0;
    var_2 = vectorNormalize((var_2[0], var_2[1], 0));
    self._id_4B2F = self._id_4B2F + var_2 * (distance2d(self.origin, var_0) / 2) * 0.8 * 0.05;
  }
}

_id_5C56(var_0) {
  if(getdvarint("support_drone_debug"))
    thread scripts\sp\utility::draw_circle(self._id_4B2F + (0, 0, 16), self._id_4B2E, (1, 0, 0), 1.0, 0, 1);

  if(distance(var_0, self._id_4B2F) >= self._id_4B2E)
    return 1;
  else
    return 0;
}

_id_5C51() {
  self._id_4B2E = 0;
}

_id_5C53(var_0) {
  var_1 = self._id_8435[2];
  var_2 = scripts\engine\utility::drop_to_ground(level.player.origin, 5.0);
  var_2 = var_2 + (0, 0, var_1);
  var_3 = [];
  var_4 = [];

  foreach(var_6 in self._id_BE7A) {
    var_3[var_3.size] = var_6.origin + (0, 0, var_1);
    var_4[var_4.size] = var_6.origin + (0, 0, var_1);
  }

  for(var_8 = 0; var_8 < int(self._id_BE7A.size * 1.5); var_8++)
    var_3[var_3.size] = var_2;

  var_9 = averagepoint(var_3);
  var_10 = averagepoint(var_4);
  var_11 = (0, 0, 0);

  if(var_10 == var_2)
    var_11 = level.player.angles;
  else
    var_11 = vectortoangles(vectorNormalize(var_10 - var_2));

  var_12 = vectorNormalize(var_10 - var_2);
  var_13 = distance(var_9, var_2);

  if(var_13 > 700)
    var_9 = var_2 + var_12 * 700;

  var_14 = anglestoright(var_11);
  var_15 = 90;

  if(self._id_D384 == 0)
    var_9 = var_9 + var_14 * var_15 / 2;
  else if(self._id_D384 == 1)
    var_9 = var_9 - var_14 * var_15 / 2;
  else if(self._id_D384 == 2)
    var_9 = var_9 + var_14 * var_15 * 1.5;
  else if(self._id_D384 >= 3)
    var_9 = var_9 - var_14 * var_15 * 1.5;

  if(isDefined(self._id_1155E) && isalive(self._id_1155E)) {
    var_16 = vectorNormalize(self._id_1155E.origin + (0, 0, var_1) - var_9);
    var_17 = distance(self._id_1155E.origin + (0, 0, var_1), var_9) / 4.0;

    if(var_17 > 100)
      var_17 = 100;

    var_9 = var_9 + var_16 * var_17;
  }

  if(distancesquared(var_9, var_0) < 2500)
    return var_0;
  else
    level.player._id_5C4F = randomfloatrange(0.2, 2.5);

  var_18 = scripts\common\trace::ray_trace_passed(self.origin, var_9, undefined, scripts\common\trace::create_solid_ai_contents(1));

  if(var_18)
    self._id_6FFF = 1;
  else if(getdvarint("support_drone_debug"))
    thread scripts\engine\utility::draw_line_for_time(self.origin, var_9, 1, 0, 0, 0.1);

  var_19 = scripts\engine\utility::drop_to_ground(var_9, 0);
  var_20 = getclosestpointonnavmesh(var_19);
  var_21 = 1;

  if(distance(var_19, var_20) > 8.0) {
    if(getdvarint("support_drone_debug")) {
      thread scripts\engine\utility::draw_line_for_time(var_19, var_19 + (0, 0, 16), 1, 0, 0, 0.25);
      thread scripts\engine\utility::draw_line_for_time(var_20, var_20 + (0, 0, 16), 0, 1, 0, 0.25);
    }

    if(!self._id_6FFF)
      var_21 = 0;
  }

  var_22 = var_9;

  if(!var_21)
    var_22 = (var_20[0], var_20[1], var_20[2] + var_1);

  self._id_1D55 = var_1;
  return var_22;
}

_id_5C52() {
  if(_id_D2DD())
    return "follow";

  self._id_BE7A = scripts\sp\utility::array_removedeadvehicles(self._id_BE7A);

  if(self._id_BE7A.size > 0)
    return "combat";

  return "follow";
}

_id_5C61(var_0) {
  self notify("new_path");
  self endon("new_path");
  self endon("death");

  if(self._id_6FFF == 1) {
    self setvehgoalpos(var_0, 1);

    if(getdvarint("support_drone_debug"))
      thread scripts\engine\utility::draw_line_for_time(self.origin, var_0, 0, 1, 0, 0.25);

    scripts\engine\utility::waittill_any("near_goal", "goal");
    return;
  }

  var_1 = scripts\engine\utility::drop_to_ground(self.origin, 0.0) + (0, 0, 8);
  var_2 = var_0 - (0, 0, self._id_1D55);
  var_3 = level.player findpath(var_1, var_2);
  var_4 = self.origin;

  if(getdvarint("support_drone_debug")) {
    foreach(var_7, var_6 in var_3) {
      thread scripts\engine\utility::draw_line_for_time(var_4, var_6, 0, 1, 0, 0.25);
      var_4 = var_6;
    }
  }

  foreach(var_7, var_6 in var_3) {
    if(getdvarint("support_drone_debug")) {}

    if(isDefined(self._id_1D55))
      var_6 = var_6 + (0, 0, self._id_1D55);

    if(getdvarint("support_drone_debug")) {}

    self setvehgoalpos(var_6, 1);
    scripts\engine\utility::waittill_any("near_goal", "goal");
  }
}

_id_5C44() {
  self endon("death_anim");
  self endon("death");

  for(;;) {
    if(isDefined(self._id_1155E) && isalive(self._id_1155E)) {
      self._id_B00E.origin = self._id_1155E gettagorigin("j_Spine4");
      self._id_5CDB laseron();
    } else {
      var_0 = level.player getEye();
      var_1 = anglesToForward(level.player getplayerangles());
      var_2 = var_0 + var_1 * 5000;
      var_3 = scripts\common\trace::ray_trace(var_0, var_2, level.player);
      self._id_B00E.origin = var_3["position"];
      self._id_5CDB laseroff();
    }

    if(getdvarint("support_drone_debug")) {}

    wait 0.1;
  }
}

_id_5C1F() {
  self endon("death_anim");
  self endon("death");

  if(!isDefined(self._id_BE7A))
    self._id_BE7A = [];

  for(;;) {
    var_0 = [];

    foreach(var_2 in getaiarray("axis")) {
      if(_id_64EA(var_2) && !issubstr(var_2.classname, "c12"))
        var_0[var_0.size] = var_2;
    }

    if(self._id_BE7A.size == 0 && var_0.size > 0)
      self notify("found_enemies");
    else if(self._id_BE7A.size > 0 && var_0.size == 0)
      self notify("no_enemies");

    self._id_BE7A = var_0;
    wait 0.1;
  }
}

_id_64EA(var_0) {
  if(!isalive(var_0) || var_0 scripts\sp\utility::_id_58DA())
    return 0;

  if(distance(var_0.origin, self.origin) > 1200)
    return 0;

  if(isDefined(var_0._id_1CAC))
    return var_0._id_1CAC;

  if(var_0.ignoreme)
    return 0;

  return 1;
}

_id_5C22() {
  self endon("death_anim");
  self endon("death");

  for(;;) {
    var_0 = randomfloatrange(-10.0, 10);
    var_1 = randomfloatrange(-10.0, 10);
    var_2 = randomfloatrange(-10.0, 10);
    self._id_8435 = (var_1, var_2, var_0);
    wait(randomfloatrange(2.0, 4.0));
  }
}

_id_112B8() {
  var_0 = getEntArray("drone_point_of_interest", "targetname");

  foreach(var_2 in var_0) {
    var_3 = scripts\engine\utility::getStructArray(var_2.target, "targetname");

    foreach(var_5 in var_3) {
      var_6 = var_5.origin[2];
      var_5._id_8D12 = (0, 0, var_6);
      var_5.origin = (var_5.origin[0], var_5.origin[1], 0);
    }

    var_2._id_D62F = var_3;
  }

  return var_0;
}

_id_112B7(var_0) {
  if(!_id_1310A()) {
    return;
  }
  var_0 endon("death");
  var_1 = 4000;

  for(;;) {
    scripts\engine\utility::flag_waitopen("stealth_spotted");
    self waittill("trigger");

    if(isDefined(var_0._id_D630)) {
      continue;
    }
    var_2 = gettime();
    var_3 = randomintrange(2500, 5000);
    var_0._id_D630 = scripts\engine\utility::random(self._id_D62F);

    while(level.player istouching(self)) {
      if(scripts\engine\utility::flag("stealth_spotted")) {
        break;
      }

      if(gettime() - var_2 <= var_3) {
        var_0._id_D630 = scripts\engine\utility::random(self._id_D62F);
        var_3 = randomintrange(2500, 5000);
      }

      wait 0.1;
    }

    var_0._id_D630 = undefined;
  }
}

_id_5BED() {
  self endon("death");
  var_0 = 0;
  var_1 = 0;

  for(;;) {
    self waittill("damage", var_2, var_3, var_4, var_5, var_6);
    var_0 = var_0 + var_2;
    self.lastdamagedir = var_4;

    if(var_0 > 600 && !var_1) {
      thread _id_5C05();
      var_1 = 1;
    }

    if(var_0 > 1200)
      self notify("lethal_damage");
  }
}

_id_5C05() {
  self setanimknob(%equip_pocket_drone_damaged_loop);
  scripts\sp\utility::_id_75C4("drone_damaged_loop", "tag_origin");
  scripts\engine\utility::waittill_any("death", "death_anim");

  if(isDefined(self))
    scripts\sp\utility::_id_75F8("drone_damaged_loop", "tag_origin");
}

_id_5BD8() {
  self endon("death_anim");
  self endon("death");
  self endon("entitydeleted");

  if(!scripts\sp\utility::_id_65DF("target_timeout"))
    scripts\sp\utility::_id_65E0("target_timeout");

  if(!scripts\sp\utility::_id_65DF("target_killed_wait"))
    scripts\sp\utility::_id_65E0("target_killed_wait");

  self._id_2654 = 1;
  childthread _id_5BE6();
  thread _id_5BE5();
  wait 2;

  for(;;) {
    self waittill("new_target_enemy");
    self playSound("support_drone_engine_mvmt_fast");
    childthread _id_5C98(self._id_1155E);
  }
}

_id_5BE5() {
  scripts\engine\utility::waittill_any("death_anim", "death", "entitydeleted");
  _id_F378(self._id_9180, "off");
}

_id_5BE6() {
  wait 2;

  for(;;) {
    wait 0.05;
    var_0 = 0;
    var_1 = 0;

    while(level.player._id_5C6E > 0)
      scripts\engine\utility::waitframe();

    while(_id_D2DD())
      wait 0.25;

    if(self._id_BE7A.size == 0) {
      self waittill("found_enemies");
      continue;
    }

    if(isDefined(self._id_1155E) && (!isalive(self._id_1155E) || self._id_1155E scripts\sp\utility::_id_58DA()) || scripts\sp\utility::_id_65DB("target_killed_wait"))
      var_1 = 1;

    if(!var_1 || scripts\sp\utility::_id_65DB("target_timeout"))
      var_0 = 1;

    if(var_0) {
      var_2 = _id_5C1C(self._id_1155E);

      if(!isDefined(var_2)) {
        continue;
      }
      level.player._id_5C6E = randomfloatrange(0.5, 1.5);

      if(isDefined(self._id_1155E) && var_2 == self._id_1155E) {
        continue;
      }
      self notify("stop_hud");
      self._id_1155E = var_2;
      var_2 notify("drone_targeting");
      self notify("new_target_enemy");
      thread _id_5BEB();
      scripts\sp\utility::_id_65DD("target_timeout");
      scripts\sp\utility::_id_65E1("target_killed_wait");
    }
  }
}

_id_5C1C(var_0) {
  self._id_BE7A = scripts\sp\utility::array_removedeadvehicles(self._id_BE7A);

  if(self._id_BE7A.size == 0)
    return undefined;

  var_1 = [];

  foreach(var_3 in self._id_BE7A) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(isDefined(var_3._id_1CAC)) {
      if(var_3._id_1CAC)
        var_1[var_1.size] = var_3;
      else
        continue;
    }

    if(isDefined(var_3.ignoreme) && var_3.ignoreme) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  if(var_1.size == 0)
    return undefined;

  var_5 = [];

  foreach(var_3 in var_1) {
    if(_id_5BE9(var_3))
      var_5[var_5.size] = var_3;
  }

  var_8 = var_5;

  if(var_8.size == 0)
    return undefined;

  if(isDefined(var_0) && scripts\engine\utility::array_contains(var_8, var_0))
    return var_0;

  var_9 = var_8[randomint(var_8.size)];
  return var_9;
}

_id_5BE9(var_0) {
  var_1 = 0;
  var_2 = scripts\common\trace::ray_trace(self.origin, var_0 gettagorigin("j_head"), undefined, scripts\common\trace::create_solid_ai_contents(1));

  if(var_2["fraction"] == 1.0)
    var_1 = 1;

  if(isalive(level.player) && var_1 == 0) {
    var_2 = scripts\common\trace::ray_trace(level.player getEye(), var_0 gettagorigin("j_head"), undefined, scripts\common\trace::create_solid_ai_contents(1));

    if(var_2["fraction"] == 1.0)
      var_1 = 1;
  }

  return var_1;
}

_id_5C98(var_0) {
  self endon("death_anim");
  self endon("death");
  self endon("new_target_enemy");
  self endon("target_enemy_died");
  childthread _id_5C60(var_0);
  thread _id_5C01(var_0);
  wait 0.5;

  while(isDefined(var_0) && isalive(var_0)) {
    if(self._id_1280E) {
      wait 0.05;
      continue;
    }

    var_1 = self._id_5CDB gettagorigin("tag_flash");
    var_2 = var_0 gettagorigin("j_Spine4");
    var_3 = cos(90);

    if(!scripts\engine\utility::within_fov(var_1, self._id_5CDB gettagangles("tag_flash"), var_2, var_3)) {
      wait 0.05;
      continue;
    }

    var_4 = ["j_Head", "j_Spine4", "j_SpineLower"];

    if(var_0.asmname == "seeker")
      var_4 = scripts\engine\utility::array_remove(var_4, "j_SpineLower");

    var_5 = undefined;

    foreach(var_7 in var_4) {
      if(getdvarint("support_drone_debug"))
        thread scripts\engine\utility::draw_line_for_time(var_1, var_0 gettagorigin(var_7), 0.7, 0, 0, 0.1);

      var_8 = scripts\common\trace::ray_trace_detail(var_1, var_0 gettagorigin(var_7), self);

      if(!isDefined(var_8["entity"])) {
        continue;
      }
      if(var_8["entity"] == level.player) {
        return;
      }
      if(var_8["entity"] == var_0) {
        var_5 = var_0 gettagorigin(var_7);
        break;
      }
    }

    if(!isDefined(var_5)) {
      wait 0.05;
      continue;
    }

    var_10 = var_5 - var_0.origin;
    self._id_5CDB settargetentity(var_0, var_10);
    self thread[[self._id_5CAF]]();
    wait 1.2;
    thread _id_5C89();
  }

  self._id_1155E = undefined;
}

_id_5C89() {
  self notify("new_target_timeout");
  self endon("new_target_timeout");
  self endon("death_anim");
  self endon("death");
  self endon("new_target_enemy");
  wait 3;
  scripts\sp\utility::_id_65E1("target_timeout");
}

_id_5C60(var_0) {
  thread scripts\sp\utility::play_sound_on_entity("support_drone_lockon");
  _id_F378(self._id_9180, "lockon", var_0);
}

_id_5C01(var_0) {
  self endon("death_anim");
  self endon("death");
  self endon("new_target_enemy");
  var_0 scripts\engine\utility::waittill_any("death", "entitydeleted", "death_anim");
  self notify("target_enemy_died");
  self._id_1155E = undefined;
  scripts\sp\utility::_id_65E8("target_killed_wait");
  _id_F378(self._id_9180, "off");
}

_id_5BDD() {
  self endon("death_anim");
  self endon("death");
  self._id_11AD3 = [];
  thread _id_5C9C();

  for(;;) {
    self._id_11AD3 = scripts\engine\utility::array_removeundefined(self._id_11AD3);

    if(self._id_11AD3.size <= 0) {
      level waittill("enemy_grenade_fire", var_0);
      wait 0.05;
      continue;
    }

    if(self._id_1280E) {
      wait 0.05;
      continue;
    }

    foreach(var_0 in self._id_11AD3) {
      var_2 = distance(var_0.origin, self.origin);

      if(var_2 <= 800) {
        thread _id_5C9B(var_0);
        self._id_11AD3 = scripts\engine\utility::array_remove(self._id_11AD3, var_0);
        break;
      }
    }

    wait 0.05;
  }
}

_id_5C9C() {
  self endon("death_anim");
  self endon("death");

  for(;;) {
    level waittill("enemy_grenade_fire", var_0);
    self._id_11AD3 = scripts\engine\utility::array_add(self._id_11AD3, var_0);
  }
}

_id_5C9B(var_0) {
  self._id_1280E = 1;
  thread scripts\engine\utility::play_loop_sound_on_entity("support_drone_trophy_scan");
  wait 0.5;

  if(!isDefined(var_0)) {
    self._id_1280E = 0;
    return;
  }

  self notify("trophy_system_engaged");
  thread scripts\engine\utility::stop_loop_sound_on_entity("support_drone_trophy_scan");
  self playSound("support_drone_trophy_fire");
  var_1 = vectorNormalize(var_0.origin - self._id_5CDB gettagorigin("tag_flash"));
  playfxbetweenpoints(level._effect["drone_trophy_laser"], self._id_5CDB gettagorigin("tag_flash"), vectortoangles(var_1), var_0.origin);
  playFX(level._effect["drone_trophy_pop"], var_0.origin);
  playworldsound("support_drone_trophy_impact", var_0.origin);
  var_0 delete();
  self._id_1280E = 0;
}

_id_5C0F() {
  self endon("death_anim");
  self endon("death");
  self endon("new_target_enemy");
  var_0 = self._id_1155E;
  _id_F378(self._id_9180, "fire");
  self.ammocount = self.ammocount - 1;
  _id_5C32(self._id_9180, self.ammocount);

  if(self.ammocount <= 0)
    self notify("no_ammo");

  var_1 = var_0 gettagorigin("j_spine4");
  var_2 = var_1 - var_0.origin;
  var_3 = 4;

  for(var_4 = 0; var_4 < var_3; var_4++) {
    if(self.ammocount <= 0)
      wait 0.1;

    thread _id_5C10();
    self._id_5CDB shootturret();
    wait 0.1;
  }

  wait 0.05;

  if(isDefined(var_0) && (!isalive(var_0) || var_0 scripts\sp\utility::_id_58DA()))
    _id_F378(self._id_9180, "kill");
}

_id_5BEB() {
  self endon("death_anim");
  self endon("death");
  self endon("new_target_enemy");

  for(;;) {
    wait 0.05;

    if(!isDefined(self._id_1155E) || !isalive(self._id_1155E) || self._id_1155E scripts\sp\utility::_id_58DA()) {
      break;
    }
  }

  wait 1.6;
  scripts\sp\utility::_id_65DD("target_killed_wait");
}

_id_5C12() {
  self endon("death_anim");
  self endon("death");
  thread scripts\sp\utility::play_loop_sound_on_tag("support_drone_windup", "tag_origin");
  wait 0.5;
  scripts\engine\utility::delaythread(0.15, scripts\engine\utility::stop_loop_sound_on_entity, "support_drone_windup");
  self.ammocount = self.ammocount - 1;
  _id_5C32(self._id_9180, self.ammocount);

  if(self.ammocount <= 0)
    self notify("no_ammo");

  var_0 = 1;

  for(var_1 = 0; var_1 < var_0; var_1++) {
    if(self.ammocount <= 0)
      wait 0.1;

    self._id_5CDB shootturret();
    wait 0.1;
  }
}

_id_5C10() {
  self endon("death_anim");
  self endon("death");
  self notify("firing");
  self endon("firing");

  if(!self._id_6DA5)
    self._id_6DA5 = 1;

  wait 1;
  self._id_6DA5 = 0;
}

_id_5C59() {
  thread scripts\engine\utility::play_loop_sound_on_entity("support_drone_engine");
  thread scripts\engine\utility::play_loop_sound_on_entity("support_drone_close_lyr");
  scripts\engine\utility::waittill_any("death", "death_anim");

  if(isDefined(self))
    _id_5C58("support_drone_engine", "support_drone_close_lyr");
}

_id_5C58(var_0, var_1) {
  self notify("stop sound" + var_0);
  self notify("stop sound" + var_1);
}

_id_5C5C() {
  scripts\sp\utility::_id_75C4("drone_thruster", "j_fan_front_le");
  scripts\sp\utility::_id_75C4("drone_thruster", "j_fan_front_ri");
  scripts\sp\utility::_id_75C4("drone_thruster", "j_fan_rear_le");
  scripts\sp\utility::_id_75C4("drone_thruster", "j_fan_rear_ri");
  scripts\engine\utility::waittill_any("death", "death_anim");

  if(isDefined(self))
    _id_5C5B();
}

_id_5C5B() {
  scripts\sp\utility::_id_75F8("drone_thruster", "j_fan_front_le");
  scripts\sp\utility::_id_75F8("drone_thruster", "j_fan_front_ri");
  scripts\sp\utility::_id_75F8("drone_thruster", "j_fan_rear_le");
  scripts\sp\utility::_id_75F8("drone_thruster", "j_fan_rear_ri");
}

_id_9C6F() {
  if(!isDefined(level.player._id_4C29))
    return 0;

  if(level.player._id_4C29.size <= 0)
    return 0;

  return 1;
}

get_all_drones() {
  var_0 = [];

  for(var_1 = 0; var_1 < 5; var_1++) {
    if(isDefined(level.player._id_4C29[var_1]) && isDefined(level.player._id_4C29[var_1]._id_5BD7) && isalive(level.player._id_4C29[var_1]._id_5BD7))
      var_0 = scripts\engine\utility::array_add(var_0, level.player._id_4C29[var_1]._id_5BD7);
  }

  return var_0;
}

_id_A5B9() {
  if(!isDefined(level.player._id_4C29) || level.player._id_4C29.size == 0) {
    return;
  }
  foreach(var_1 in level.player._id_4C29)
  var_1._id_5BD7 notify("lethal_damage");
}

_id_5139() {
  if(!isDefined(level.player._id_4C29) || level.player._id_4C29.size == 0) {
    return;
  }
  foreach(var_1 in level.player._id_4C29)
  var_1._id_5BD7 notify("vr_delete");
}

_id_1310A() {
  return level.player scripts\sp\utility::_id_65DF("stealth_enabled") && level.player scripts\sp\utility::_id_65DB("stealth_enabled");
}

_id_D2DD() {
  if(_id_1310A())
    return !scripts\engine\utility::flag("stealth_spotted");

  return 0;
}

_id_F378(var_0, var_1, var_2) {
  if(var_1 == "lockon") {
    setomnvar("ui_supdrone_reticle_" + var_0 + "_target_ent", var_2);
    setomnvar("ui_supdrone_reticle_" + var_0 + "_lock_state", 1);
    scripts\engine\utility::noself_delaycall(0.05, ::setomnvar, "ui_supdrone_reticle_" + var_0 + "_lock_state", 0);
  } else if(var_1 == "fire") {
    setomnvar("ui_supdrone_reticle_" + var_0 + "_lock_state", 2);
    scripts\engine\utility::noself_delaycall(0.05, ::setomnvar, "ui_supdrone_reticle_" + var_0 + "_lock_state", 0);
  } else if(var_1 == "kill") {
    setomnvar("ui_supdrone_reticle_" + var_0 + "_lock_state", 3);
    scripts\engine\utility::noself_delaycall(0.05, ::setomnvar, "ui_supdrone_reticle_" + var_0 + "_lock_state", 0);
  } else if(var_1 == "off") {
    setomnvar("ui_supdrone_reticle_" + var_0 + "_target_ent", undefined);
    setomnvar("ui_supdrone_reticle_" + var_0 + "_lock_state", 0);
  }
}

_id_F377(var_0, var_1) {
  if(var_1 == "active") {
    setomnvarbit("ui_supdrone_bits", var_0, 1);
    setomnvar("ui_supdrone_state_" + var_0, 1);
    level.player._id_4C29[var_0]._id_9A96 = 1;
    level.player scripts\engine\utility::delaythread(1.5, ::_id_F424, var_0);
  } else if(var_1 == "destroyed") {
    setomnvar("ui_supdrone_state_" + var_0, 2);
    scripts\engine\utility::noself_delaycall(1.5, ::setomnvarbit, "ui_supdrone_bits", var_0, 0);
    level.player._id_4C29[var_0]._id_C7B4 = 1;
    level.player scripts\engine\utility::delaythread(1.5, ::_id_F4B1, var_0);
  } else if(var_1 == "noammo") {
    setomnvar("ui_supdrone_state_" + var_0, 3);
    scripts\engine\utility::noself_delaycall(1.5, ::setomnvarbit, "ui_supdrone_bits", var_0, 0);
    level.player._id_4C29[var_0]._id_C7B4 = 1;
    level.player scripts\engine\utility::delaythread(1.5, ::_id_F4B1, var_0);
  }
}

_id_5C32(var_0, var_1) {
  var_1 = scripts\engine\utility::ter_op(var_1 < 0, 0, var_1);
  setomnvar("ui_supdrone_ammo_" + var_0, var_1);
}

_id_F424(var_0) {
  level.player._id_4C29[var_0]._id_9A96 = 0;
}

_id_F4B1(var_0) {
  level.player._id_4C29[var_0]._id_C7B4 = 0;
  level.player._id_4C29[var_0]._id_51BA = 1;
}

_id_129A() {
  if(isDefined(level.player._id_5CB3) && level.player._id_5CB3 == 1)
    return "supportdrone_up2";
  else
    return "supportdrone";
}