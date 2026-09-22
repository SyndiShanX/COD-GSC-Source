/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1376.gsc
**************************************/

init() {
  _id_52F0();
}

_id_AB82() {
  self notify("set_new_zepplin_behavior", "zepplin_leave_village");
}

_id_AB81() {
  self notify("set_new_zepplin_behavior", "zepplin_brt_cinematic");
}

_id_AB85() {
  self notify("set_new_zepplin_behavior", "zepplin_brt_exit_cinematic");
}

_id_AB84() {
  self notify("set_new_zepplin_behavior", "zepplin_return_village");
}

_id_AB83() {
  self notify("set_new_zepplin_behavior", "zepplin_new_objective");
}

_id_7F59(var_0) {
  level endon("zeppelin_destroyed");
  thread _id_6F17(var_0);
  thread _id_8641(0);

  if(!isDefined(self._id_0F1D)) {
    self._id_0F1D = 1;
  }

  if(common_scripts\utility::_id_562E(var_0)) {
    thread _id_7204(0, 0);
  }

  for(;;) {
    var_1 = _id_A6AD();

    switch (var_1) {
      case "zepplin_brt_cinematic":
        isitemunlocked2();
        break;
      case "zepplin_brt_exit_cinematic":
        isitemunlocked();
        break;
      case "zepplin_new_objective":
        thread _id_7204(self._id_0F1D, 0);
        _id_7D43();
        botfirstavailablegrenade();
        common_scripts\utility::flag_set("sky_rush");
        break;
      case "zepplin_leave_village":
        thread _id_7204(self._id_0F1D, 1);
        self._id_0F1D++;
        _id_8409();
        _id_85FF();
        break;
      case "zepplin_return_village":
        thread _id_7204(self._id_0F1D, 0);
        botfirstavailablegrenade();
        _id_8600();
        break;
    }
  }
}

_id_7D52(var_0) {
  if(common_scripts\utility::_id_562E(var_0)) {
    level._id_6658 = 0;
  }

  _id_53C9();
  common_scripts\utility::flag_set("sky_rush");
  _id_1F46();
}

_id_7D43() {
  self._id_4B8B = 0;
  _id_AB80(3);
  self._id_5704 = 0;
  _id_53C9();
}

#using_animtree("animated_props_zombies");

_id_6BFA(var_0) {
  var_1 = [];
  var_1["zom_zeppelin_panels_01_open"] = % zom_zeppelin_panels_01_open;
  var_1["zom_zeppelin_panels_01_open_idle"] = % zom_zeppelin_panels_01_open_idle;

  if(isDefined(var_0)) {
    var_2 = [var_0];
  } else {
    var_2 = self._id_AAF7;
  }

  foreach(var_4 in var_2) {
    var_4._id_65D8 scriptmodelclearanim();
  }

  foreach(var_4 in var_2) {
    var_4._id_65D8 scriptmodelplayanim("zom_zeppelin_panels_01_open");
  }

  wait(_getanimlength(var_1["zom_zeppelin_panels_01_open"]));

  foreach(var_4 in var_2) {
    var_4._id_65D8 scriptmodelplayanim("zom_zeppelin_panels_01_open_idle");
  }
}

_id_243F(var_0) {
  var_1 = [];
  var_1["zom_zeppelin_panels_01_close"] = % zom_zeppelin_panels_01_close;
  var_1["zom_zeppelin_panels_01_closed_idle"] = % zom_zeppelin_panels_01_closed_idle;

  if(isDefined(var_0)) {
    var_2 = [var_0];
  } else {
    var_2 = self._id_AAF7;
  }

  foreach(var_4 in var_2) {
    var_4._id_65D8 scriptmodelclearanim();
  }

  foreach(var_4 in var_2) {
    var_4._id_65D8 scriptmodelplayanim("zom_zeppelin_panels_01_close");
  }

  wait(_getanimlength(var_1["zom_zeppelin_panels_01_close"]));

  foreach(var_4 in var_2) {
    var_4._id_65D8 scriptmodelplayanim("zom_zeppelin_panels_01_closed_idle");
  }
}

_id_8409() {
  _id_85FC(0);
  _id_85FB(0);
}

botfirstavailablegrenade() {
  _id_7EB8();
  _id_85FC(1);

  if(self._id_1F5D._id_5DDA < 3) {
    _id_85FB(1);
  }
}

_id_85FF() {
  if(!isDefined(level._id_179A._id_1F5D._id_5DDA)) {
    _id_AB80(0);
  } else {
    _id_AB80(self._id_1F5D._id_5DDA - 1);
  }

  self._id_5704 = 1;
}

isitemunlocked2() {
  common_scripts\utility::_id_3799("blimp_cinematic_done");
  self._id_571C = 1;
  var_0 = common_scripts\utility::_id_46B5("final_boss_anim_intro_scripted_node", "targetname");
  level._id_179A _id_71F6("s2_zom_brt_blimp_intro", var_0);
}

isitemunlocked() {
  level._id_179A common_scripts\utility::_id_379A("blimp_cinematic_done");
}

_id_5606() {
  return common_scripts\utility::_id_562E(self._id_5704);
}

_id_8600() {
  level thread maps\mp\mp_zombie_nest_ee_overcharge::_id_86A7(self._id_6655);
  _id_7D52();
  self._id_5704 = 0;
}

_id_85FC(var_0) {
  self._id_1F8D = var_0;
}

_id_85FB(var_0) {
  self._id_1F1F = var_0;
}

_id_AB80(var_0) {
  self._id_1F5D._id_5DDA = var_0;
}

_id_AB7F(var_0, var_1) {
  var_2 = _getEnt("overcharge_trig", "targetname");
  var_3 = 0;

  if(isDefined(var_2)) {
    var_3 = var_2._id_17A9;
  }

  eqoff("s2_zmb_zeppelin_flight_exit_0" + var_0);

  if(common_scripts\utility::_id_562E(level._id_1CBA)) {
    self waittill("cancel blimp wait");
  } else if(!common_scripts\utility::_id_562E(var_1)) {
    _id_A649(level._id_A980, var_2, var_3);
  }
}

_id_3002(var_0) {}

_id_6F17(var_0) {
  level endon("zeppelin_destroyed");
  _id_17AC();
  _id_17A6();
  var_1 = 0;
  var_2 = 0;
  var_3 = 4;

  for(;;) {
    while(_id_0547::_id_585E()) {
      waitframe();
    }

    var_1 = common_scripts\utility::_id_98E7(var_1 + 1 > var_3, 1, var_1 + 1);
    var_2 = common_scripts\utility::_id_98E7(var_1 + 1 > var_3, 1, var_1 + 1);

    if(common_scripts\utility::_id_562E(self._id_571C)) {
      common_scripts\utility::_id_379C("blimp_cinematic_done");
      common_scripts\utility::_id_3796("blimp_cinematic_done");
      self._id_571C = 0;
    }

    eqoff("s2_zmb_zeppelin_flightpath_idle_circle_0" + var_1);

    if(var_0 || _id_5606()) {
      getanimentryalias(var_2, var_0);

      if(common_scripts\utility::_id_562E(var_0)) {
        var_0 = 0;
      }
    }
  }
}

getanimentryalias(var_0, var_1) {
  _id_AB7F(var_0, var_1);

  if(!common_scripts\utility::_id_562E(var_1) && self._id_1F5D._id_5DDA > 0) {
    _id_AB84();
    eqoff("s2_zmb_zeppelin_flight_entrance_0" + var_0);
    var_2 = common_scripts\utility::random(level.players);

    if(isDefined(var_2)) {
      var_2 thread _id_0367::_id_8EA3("zepreturns");
      return;
    }
  } else {
    var_3 = "";

    while(var_3 != "zepplin_new_objective") {
      self waittill("set_new_zepplin_behavior", var_3);
    }

    eqoff("s2_zmb_zeppelin_flight_entrance_0" + var_0);
  }
}

_id_A6AD() {
  self waittill("set_new_zepplin_behavior", var_0);
  return var_0;
}

_id_9009(var_0) {
  if(!isDefined(level._id_179A)) {
    return;
  }
  if(common_scripts\utility::_id_562E(level._id_6657)) {
    return;
  } else {
    level._id_6657 = 1;
  }

  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_1 = common_scripts\utility::_id_46B7("zmb_blimp_pieces_struct", "targetname");

  foreach(var_3 in var_1) {
    var_3._id_57F7 = 0;
  }

  level._id_179A _id_8BFF();
  level._id_179A _id_71FF();
  level._id_179A thread _id_AAEE();
  level._id_179A thread _id_7EB9();
  level._id_179A thread _id_7F59(var_0);
  level._id_179A _id_0378::_id_8D74("blimp_start");
}

_id_52F0() {
  level._id_179A = _getEnt("nest_ee_blimp", "targetname");
  level._id_179A _id_89D3();
  common_scripts\utility::_id_2CB4(5, ::_id_516A);
}

_id_89D3() {
  self._id_9255 = self.origin;
  self._id_9189 = self.angles;
  self hide();
  _id_113A("blimp_door_damage_trigger");
  _id_113E("nest_ee_blimp_attack_gun", "turretweapon_zeppelin_gun_zm");
  _id_113D("blimp_attack_gun_battery");
  self._id_1F5D hide();
}

_id_113A(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    var_3._id_65D8 = _getEnt(var_3.target, "targetname");
    var_4 = common_scripts\utility::_id_46B5(var_3._id_65D8.target, "targetname");
    var_5 = spawn("script_model", var_4.origin);
    var_5 setModel("tag_origin");
    var_3._id_65D9 = var_5;
  }

  foreach(var_8 in var_1) {
    var_8 enablelinkTo();
    var_8 linktosynchronizedparent(self);
    var_8._id_65D8 linktosynchronizedparent(self);
    var_8._id_65D9 linktosynchronizedparent(self);
    var_8._id_65D8 scriptmodelplayanim("zom_zeppelin_panels_01_closed_idle");
  }

  self._id_AAF7 = var_1;
}

_id_113E(var_0, var_1) {
  var_2 = common_scripts\utility::_id_46B5(var_0, "targetname");
  self._id_6655 = var_2 _id_1D62(var_1, var_2._id_0165, ::_id_17B0, ::_id_17B1);
  self._id_6655 linktosynchronizedparent(self);
  self._id_6655 hide();
}

_id_113D(var_0) {
  self._id_1F5D = _getEnt(var_0, "targetname");
  self._id_1F5D linktosynchronizedparent(self);
}

_id_8641(var_0) {
  level._id_179A._id_1F8D = var_0;
}

_id_53C9() {
  thread _id_AAF5();
}

_id_AAF5() {
  self notify("new_battery_primed");
  self endon("new_battery_primed");
  var_0 = undefined;

  foreach(var_2 in self._id_AAF7) {
    var_2 childthread _id_95CA(self);
  }

  self waittill("blimp_weakpoint_destroyed", var_0, var_2);
  playFX(level._effect["zmb_zeppelin_battery_explosion"], var_2.origin);
  self._id_327A = undefined;

  if(!isDefined(level._id_6658)) {
    level._id_6658 = 1;
  } else {
    level._id_6658++;
  }

  maps\mp\mp_zombie_nest_ee_overcharge::_id_86A6();

  if(level._id_179A._id_1F5D._id_5DDA > 1 || common_scripts\utility::_id_562E(level._id_179A._id_4B8B)) {
    level._id_179A _id_AB82();
  }

  _id_9025(var_0);
}

_id_95CA(var_0) {
  level endon("zeppelin_destroyed");
  var_0 endon("blimp_weakpoint_destroyed");

  if(maps\mp\mp_zombie_nest_ee_hc_true_voice::_id_744B()) {
    self._id_A996 = 6500;
  } else {
    self._id_A996 = 4500;
  }

  self._id_A996 = self._id_A996 + 1000 * (level.players.size - 1);
  var_1 = 3375.0;
  var_2 = 2250.0;
  var_3 = 1125.0;
  var_4 = [var_1, var_2, var_3];
  self._id_4C13 = 0;
  var_5 = undefined;

  while(self._id_A996 > 0) {
    self waittill("damage", var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15);

    if(common_scripts\utility::_id_562E(self._id_565B)) {
      continue;
    }
    var_6 = maps\mp\mp_zombie_nest_ee_util::_id_98ED(var_15, var_6);
    self._id_A996 = self._id_A996 - var_6;

    if(self._id_A996 < 0) {
      self._id_A996 = 0;
    }

    for(var_16 = 0; self._id_4C13 < 2 && self._id_A996 < var_4[self._id_4C13]; self._id_4C13++) {
      var_16 = 1;
    }

    if(var_16) {
      _id_2FF3();
    }

    if(randomint(100) < 30) {
      playFX(level._effect["zmb_zeppelin_battery_damage"], self.origin);
    }

    var_7 _id_04C7::_id_A102("standard");
    var_5 = var_7;
  }

  _id_23D4();
  var_0 notify("blimp_weakpoint_destroyed", var_5, self);
}

_id_1D62(var_0, var_1, var_2, var_3) {
  var_4 = _spawnturret("misc_turret", self.origin, var_0);
  var_4.angles = self.angles;
  var_4 setModel(var_1);
  var_4 setdefaultdroppitch(0.0);
  var_4 setmode("auto_nonai");
  var_4 setsentryowner(undefined);
  var_4 setturretminimapvisible(0);
  var_4 maketurretsolid();
  var_4 makeunusable();
  var_4 setturretteam("axis");
  var_4 setentityowner(var_4);
  var_4 set_tool_hudelem(1);

  if(isDefined(var_2)) {
    var_4._id_62AD = var_2;
  }

  if(isDefined(var_3)) {
    var_4._id_6B73 = var_3;
  }

  return var_4;
}

_id_516A() {
  var_0 = common_scripts\utility::_id_46B7("zmb_blimp_pieces_struct", "targetname");

  foreach(var_2 in var_0) {
    var_3 = common_scripts\utility::_id_44BE(var_2.target, "targetname");

    foreach(var_5 in var_3) {
      switch (var_5._id_0165) {
        case "zmb_blimp_pieces_holder":
          var_2._id_4DEA = var_5;
          break;
        case "zmb_blimp_pieces_uber":
          var_2._id_9FE1 = var_5;
          break;
        case "zmb_blimp_pieces_rubble":
          var_2._id_7F40 = var_5;
          break;
        case "zmb_blimp_pieces_clip":
          var_2._id_241F = var_5;
          var_2._id_241F notsolid();
          var_2._id_241F connectpaths();
          var_2._id_241F hide();
          break;
      }
    }
  }
}

_id_A649(var_0, var_1, var_2) {
  level endon("zeppelin_destroyed");
  self endon("cancel blimp wait");

  if(isDefined(var_1)) {
    while(var_2 == var_1._id_17A9) {
      wait 0.1;
    }
  }

  while(level._id_A980 <= var_0) {
    wait 0.1;
  }

  if(!common_scripts\utility::_id_562E(level._id_1CBA)) {
    common_scripts\utility::random(level.players) _id_0378::_id_8D74("dialogue_queue", "zmb_jeff_thezeppelinitsbackmaybeic");
  }
}

_id_8BFF() {
  self show();
  self._id_1F5D show();
  level._id_179A._id_6655 show();
}

_id_17B2(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(isDefined(var_0) && isPlayer(var_0)) {
    var_1 = (0, 0, 0);
  } else {
    var_1 = (0, 0, 0);
  }

  level._id_179A._id_6655 settargetentity(var_0, var_1, 1);
}

_id_17AE() {
  return level._id_179A._id_6655 _meth_80FC();
}

_id_17AD() {
  level._id_179A._id_6655 cleartargetentity();
}

_id_5688(var_0) {
  var_1 = _id_17AE();
  return isDefined(var_1) && var_1 == var_0;
}

_id_17B3() {
  level._id_179A._id_6655 startfiring();
  level._id_179A._id_6655 _id_0378::_id_8D74("blimp_projectile");
}

_id_17B4() {
  level._id_179A._id_6655 stopfiring();
}

_id_17AF() {
  level._id_179A._id_6655 isfiringturret();
}

_id_17B0(var_0) {
  if(!isPlayer(self)) {
    return var_0;
  }

  var_0 = self.maxhealth * 0.95;
  return var_0;
}

_id_17B1(var_0) {
  var_1 = self;
  var_2 = _getweaponexplosionradius("turretweapon_zeppelin_gun_zm");
  var_3 = 1 - distance(var_0.origin, var_1.origin) / var_2;

  if(var_3 < 0) {
    var_3 = 0;
  }

  var_1 _id_0547::_id_7419(var_0.origin, var_3 * var_2 + 100);
  _id_2E76(var_0.origin);
  var_1 _id_0378::_id_8D74("blimp_hit_plr");
}

_id_29D3() {
  self endon("death");
  var_0 = self.health;

  for(;;) {
    self dodamage(var_0 / 3, (0, 0, 0));
    wait 0.5;
  }
}

_id_9025(var_0) {
  if(level._id_179A._id_1F5D._id_5DDA == 1 && !common_scripts\utility::_id_562E(level._id_179A._id_4B8B)) {
    var_1 = level._id_179A._id_6655 _id_180A(var_0, 1);
    level._id_179A _id_AB80(1);
    level._id_179A._id_4B8B = 1;
    level._id_179A _id_8409();
    var_2 = 0;
    var_3 = undefined;

    while(!var_2) {
      foreach(var_5 in level.players) {
        if(distance(var_1.origin, var_5.origin) < 512) {
          var_2 = 1;
          var_3 = var_5;
        }
      }

      wait 0.125;
    }

    var_3 _id_0367::_id_8E3D("uberfly");
    var_1._id_78C5 = _spawnlinkedfx(common_scripts\utility::_id_44F5("temp_klaus_radius"), var_1, "tag_origin");
    _triggerfx(var_1._id_78C5);
    var_1 rotateby((720, 720, 720), 8, 2);
    var_1 _id_0378::_id_8D74("aud_battery_retract");

    for(var_7 = 1; var_7 < 5; var_7 = var_7 + 0.1) {
      var_1 movez(32, 0.1);
      var_8 = _func_382("zmb_electricity_reg_beam_med", var_1, "tag_origin", level._id_179A, "tag_origin");
      wait 0.1;
      var_8 delete();
    }

    for(var_7 = 1; var_7 < 11; var_7 = var_7 + 0.1) {
      var_9 = _vectorlerp(var_1.origin, level._id_179A.origin, var_7 / 10);
      var_10 = distance(var_1.origin, var_9) / (125 + 25 * var_7);
      var_1 moveTo(var_9, var_10);
      var_8 = _func_382("zmb_electricity_reg_beam_med", var_1, "tag_origin", level._id_179A, "tag_origin");
      wait 0.1;
      var_8 delete();
    }

    var_1._id_9FE6 delete();
    var_1._id_78C5 delete();
    var_1 delete();
    level thread maps\mp\mp_zombie_nest_ee_overcharge::_id_86A7(level._id_179A._id_6655);
    level._id_179A botfirstavailablegrenade();
    level._id_179A _id_53C9();
    return;
  } else
    var_1 = level._id_179A._id_6655 _id_180A(var_0);

  var_11 = "zombie_battery_death_" + self.targetname + "_" + _id_45C4();

  if(common_scripts\utility::_id_562E(level._id_1CBA)) {
    maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8606();
  }

  if(_id_8B88()) {
    level thread maps\mp\mp_zombie_nest_ee_overcharge::_id_A788(var_11, var_1);

    if(1) {
      _playFXOnTag(level._effect["zmb_geistkraft_radius_400"], var_1, "TAG_ORIGIN");
    }

    var_12 = 20;
    thread _id_8C16(var_1);
    var_1 maps\mp\mp_zombie_nest_special_event_creator::_id_170B(var_12, 400, 100, var_11, undefined, "tag_fx", "zmb_zep_receiver_charge_pnt", "tag_origin", undefined, var_1._id_34A5._id_7F41, (0, 0, 48));
    level thread maps\mp\gametypes\zombies::orders_and_contracts_report_event("geistcraft_device_powered");

    if(1) {
      _stopFXOnTag(level._effect["zmb_geistkraft_radius_400"], var_1, "TAG_ORIGIN");
    }
  }

  if(common_scripts\utility::_id_562E(level._id_1CBA)) {
    maps\mp\mp_zombie_nest_ee_wave_manipulation::_id_8608();
    _id_0557::_id_7822("8B final boss", &"ZOMBIE_NEST_HINT_STEP_BOSS_UBER_HIT");
  } else
    maps\mp\mp_zombie_nest_ee_overcharge::_id_86A3();

  thread _id_2EB4(var_1.origin);
  _id_0585::_id_8F7E(var_1.origin, undefined, undefined, undefined, "Blimp Battery Hunt");
  var_1._id_9FE6 delete();
  var_1._id_34A5 hudoutlinedisableforclient();
  playFX(loadfx("vfx/explosion/zmb_zeppelin_battery_hide_explosion"), var_1.origin);
  var_1 delete();
}

_id_8C16(var_0) {
  var_1 = [7, 14, 20];
  var_2 = 0;
  var_3 = undefined;

  while(!isDefined(var_0._id_695B)) {
    waitframe();
  }

  for(;;) {
    while(isDefined(var_0) && isDefined(var_0._id_AC2C) && var_0._id_AC2C < var_1[var_2]) {
      level waittill(var_0._id_695B);
      waittillframeend;
    }

    if(var_2 == var_1.size - 1) {
      var_3 delete();
      break;
    }

    if(isDefined(var_3)) {
      var_3 delete();
      waitframe();
    }

    var_3 = _spawnfx(level._effect["gk_raven_hc_ee_uber_stg_" + (var_2 + 1)], var_0._id_9FE6.origin, anglesToForward(var_0._id_9FE6.angles), anglestoup(var_0._id_9FE6.angles));
    _triggerfx(var_3);
    var_2++;
  }
}

_id_2EB4(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = common_scripts\utility::_id_4461(var_0, level.players);
  var_1 thread _id_0367::_id_8E3C("zepuberunlocked");
}

_id_8B88() {
  return 1;
}

_id_45C4() {
  if(!isDefined(level._id_6658)) {
    level._id_6658 = 0;
  }

  return level._id_6658;
}

_id_17AA(var_0, var_1, var_2, var_3) {
  maps\mp\mp_zombie_nest_ee_overcharge::_id_8C89();
  var_3 = maps\mp\mp_zombie_nest_ee_util::_id_98ED(var_1, var_3);

  if(randomint(100) < 30) {
    playFX(level._effect["zmb_zeppelin_battery_damage"], self.origin);
  }

  var_4 = var_3;
  return var_4;
}

_id_17AB(var_0, var_1, var_2, var_3) {
  self notify("death", var_0, var_2, var_1);
  self._id_57B1 = 1;
  self hide();
}

_id_17A7(var_0, var_1, var_2, var_3) {
  maps\mp\mp_zombie_nest_ee_overcharge::_id_8C89();
  var_3 = maps\mp\mp_zombie_nest_ee_util::_id_98ED(var_1, var_3);

  if(randomint(100) < 30) {
    playFX(level._effect["zmb_zeppelin_battery_damage"], self.origin);
  }

  var_4 = var_3;
  return var_4;
}

_id_17A8(var_0, var_1, var_2, var_3) {
  self notify("death", var_0, var_2, var_1);
}

_id_7EB9() {
  level endon("zeppelin_destroyed");
  var_0 = common_scripts\utility::_id_46B5("blimp_rocket_barrage_struct", "targetname");
  var_1 = getEntArray(var_0.target, "targetname");
  var_2 = ["J_searchlight_A_LE_2", "J_searchlight_A_RI_2", "J_searchlight_B_LE_2", "J_searchlight_B_RI_2", "J_searchlight_C_LE_2", "J_searchlight_C_RI_2"];

  foreach(var_4 in var_1) {
    var_4 linktosynchronizedparent(self);
    var_4 thread _id_4A52();
  }

  for(;;) {
    wait 5;

    while(_id_0547::_id_585E()) {
      waitframe();
    }

    if(common_scripts\utility::_id_562E(self._id_1F1F)) {
      foreach(var_4 in var_1) {
        if(common_scripts\utility::_id_562E(var_4._id_57B1)) {
          continue;
        }
        var_7 = common_scripts\utility::random(level.players);
        var_8 = _func_2E1(var_7.origin + (randomint(512) - 256, randomint(512) - 256, 0), var_7);
        var_9 = var_4.origin + var_4 _id_4306();
        var_10 = _bullettracepassed(var_9, var_8, 0, var_4);
        var_11 = _bullettracepassed(var_8, var_9, 0, var_4);

        if(!var_10 || !var_11 || common_scripts\utility::_id_562E(var_4._id_56EF)) {
          continue;
        }
        var_4 thread _id_3BAE(var_7.origin);
        wait 0.25;
      }
    }
  }
}

_id_4306() {
  if(!isDefined(self) || !isDefined(self.angles)) {
    return (0, 0, 0);
  }

  return 64 * vectorNormalize(anglesToForward(self.angles)) + (0, 0, 16);
}

_id_3BAE(var_0) {
  level endon("zeppelin_destroyed");
  self._id_56EF = 1;
  self scriptmodelclearanim();
  self scriptmodelplayanim("zmb_zeppelin_rocket_pod_open");
  wait(_getanimlength(%zmb_zeppelin_rocket_pod_open));
  self scriptmodelplayanim("zmb_zeppelin_rocket_pod_open_idle");
  var_1 = spawn("script_model", self.origin + _id_4306());
  var_1 setModel("npc_usa_bazooka_rocket_base");
  _playFXOnTag(level._effect["zmb_zep_rocket_smoketrail"], var_1, "tag_origin");
  var_1 thread _id_3A12(var_0);
  wait 0.5;
  self scriptmodelplayanim("zmb_zeppelin_rocket_pod_close");
  wait(_getanimlength(%zmb_zeppelin_rocket_pod_close));
  self scriptmodelplayanim("zmb_zeppelin_rocket_pod_close_idle");
  self._id_56EF = 0;
}

_id_7EB8() {
  var_0 = common_scripts\utility::_id_46B5("blimp_rocket_barrage_struct", "targetname");
  var_1 = getEntArray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    var_3 notify("damage", 100000);
    var_3._id_57B1 = 0;
    var_3 show();
  }

  waitframe();

  foreach(var_3 in var_1) {
    var_3 thread _id_4A52();
  }
}

_id_4A52() {
  var_0 = 1000;
  self.health = var_0;
  self._id_93FD = 0;
  self setCanDamage(1);
  self._id_57B1 = 0;
  thread maps\mp\gametypes\_damage::_id_8676(var_0, undefined, ::_id_17AB, ::_id_17AA);
}

_id_3A12(var_0) {
  playsoundatpos(self.origin, "zmb_blimp_mortar_inc");
  var_1 = var_0 - self.origin;
  var_2 = _sqrt(_abs(var_1[2] * 2 / 800));
  var_3 = 1 / var_2;
  var_4 = var_1 * (var_3, var_3, 0);
  self movegravity(var_4, var_2);
  thread _id_7EE7();
  wait(var_2);
  self.origin = var_0;
  playFX(loadfx("vfx/explosion/zmb_zep_rocket_impact"), var_0);
  self notify("zepplin detonate");
  playsoundatpos(var_0, "zmb_blimp_mortar_exp");
  _earthquake(0.55, 0.6, var_0, 200);
  waitframe();
  var_5 = _id_0547::_id_408F();
  var_6 = common_scripts\utility::_id_0F73(var_5, level.players);

  foreach(var_8 in var_6) {
    if(distance(var_0, var_8.origin) < 128) {
      if(isPlayer(var_8)) {
        var_8 setblurforplayer(3, 0.8);
      } else if(common_scripts\utility::_id_562E(var_8._id_A87C)) {
        continue;
      } else {
        var_8._id_A87C = 1;
      }

      if(isPlayer(var_8)) {
        var_8 dodamage(15, var_0, self, self, "MOD_EXPLOSIVE");
        continue;
      }

      var_8 dodamage(15, var_0, self, self, "MOD_RIFLE_BULLET");
    }
  }

  self delete();
}

_id_7EE7() {
  var_0 = self.origin;
  level endon("zeppelin_destroyed");
  self endon("zepplin detonate");

  for(;;) {
    waitframe();
    var_1 = vectortoangles(var_0 - self.origin);
    self.angles = var_1;
    var_0 = self.origin;
  }
}

_id_2DC3() {
  level notify("zeppelin_destroyed");

  if(isDefined(level._id_179A)) {
    level._id_179A._id_6655 delete();
    level._id_179A._id_1F5D delete();

    foreach(var_1 in level._id_179A._id_AAF7) {
      var_1 delete();
      var_1._id_65D8 delete();
    }

    var_3 = common_scripts\utility::_id_46B5("blimp_rocket_barrage_struct", "targetname");
    var_4 = getEntArray(var_3.target, "targetname");

    foreach(var_6 in var_4) {
      var_6 delete();
    }

    level._id_179A delete();
  }
}

_id_AAEE() {
  level endon("zeppelin_destroyed");
  level._id_17A4 = ["zone1_1_start", "zone1_2_gallows", "zone1_4_bridge", "zone1_4_bridge_tower", "zone1_3_riverside", "zone1_5_rooftops"];
  level._id_17A5 = [];

  for(var_0 = 0; var_0 < level._id_17A4.size; var_0++) {
    var_1 = getEntArray(level._id_17A4[var_0], "targetname");
    level._id_17A5 = common_scripts\utility::_id_0F73(level._id_17A5, var_1);
  }

  if(!isDefined(level._id_179A._id_982A)) {
    level._id_179A._id_982A = spawn("script_model", level._id_179A gettagorigin("J_searchlight_A_RI_2"));
    level._id_179A._id_982A setModel("tag_origin");
    level._id_179A._id_982A linktosynchronizedparent(level._id_179A);
  }

  for(;;) {
    wait 3;

    while(_id_0547::_id_585E()) {
      waitframe();
    }

    if(common_scripts\utility::_id_562E(level._id_179A._id_1F8D)) {
      var_2 = undefined;

      while(!isDefined(var_2) || !isalive(var_2)) {
        var_2 = common_scripts\utility::_id_4461(self.origin, level.players);
        var_3 = 0;

        if(!common_scripts\utility::_id_562E(var_2.inlaststand)) {
          for(var_0 = 0; var_0 < level._id_17A5.size; var_0++) {
            if(var_2 istouching(level._id_17A5[var_0])) {
              var_3 = 1;
            }
          }
        }

        if(!var_3) {
          var_2 = undefined;
        }

        wait 0.25;
      }

      _id_17B2(var_2);
      var_4 = level._id_179A._id_6655 gettagorigin("TAG_PITCH");
      var_5 = spawn("script_model", var_4);
      var_5 setModel("Tag_Origin");
      var_5 linktosynchronizedparent(level._id_179A._id_6655);
      var_5 _id_0378::_id_8D74("blimp_charge");
      var_6 = 0;

      while(isalive(var_2)) {
        var_7 = level._id_179A._id_6655 gettagorigin("TAG_AIM");
        var_8 = level._id_179A._id_6655 gettagangles("TAG_AIM");
        var_9 = anglesToForward(var_8);
        var_10 = vectorNormalize(var_2.origin - var_7);
        var_11 = vectordot(var_9, var_10);
        level._id_8C4C = level._id_179A._id_6655 gettagorigin("TAG_AIM");
        var_12 = (var_2.angles[0], var_2.angles[1], var_2.angles[0]);
        var_13 = (128 + randomint(128)) * vectorNormalize(anglesToForward(var_12));
        level._id_8C46 = var_2.origin + var_13;
        level._id_8C4B = _spawnsighttrace(level._id_8C4C, level._id_8C4C, level._id_8C46, 0);
        var_14 = bulletTrace(level._id_179A._id_6655 gettagorigin("TAG_AIM"), level._id_8C46, 0, level._id_179A._id_6655);
        var_15 = _abs(var_14["position"][2] - var_2.origin[2]);

        if(var_15 > 64) {
          level._id_8C46 = var_2.origin;
          level._id_8C4B = _spawnsighttrace(level._id_8C4C, level._id_8C4C, level._id_8C46, 0);

          if(level._id_8C4B >= 0.99 &var_11 >= 0.99) {
            break;
          }
        } else
          break;

        waitframe();
      }

      var_16 = maps\mp\mp_zombie_nest_ee_util::_id_90A9(level._id_8C46 + (0, 0, -12));
      var_14 = bulletTrace(level._id_179A._id_6655 gettagorigin("TAG_AIM"), var_16.origin, 0, level._id_179A._id_6655);
      var_16.origin = var_14["position"];
      var_16.angles = vectortoangles(var_5.origin - var_16.origin);
      _id_17B2(var_16);
      var_17 = _id_7E3A();
      _playFXOnTag(common_scripts\utility::_id_44F5("zmb_zeppelin_shot_charge"), level._id_179A._id_6655, "TAG_YAW");
      _playFXOnTag(common_scripts\utility::_id_44F5("zmb_zeppelin_shot_charge_barrel"), level._id_179A._id_6655, "TAG_AIM");
      var_18 = level._id_179A._id_6655 gettagorigin("TAG_LIGHT");
      var_19 = level._id_179A._id_6655 gettagangles("TAG_LIGHT");
      var_20 = spawn("script_model", var_18);
      var_20 setModel("tag_origin");
      var_20.angles = var_19;
      var_20 linktosynchronizedparent(level._id_179A._id_6655);
      _playFXOnTag(level._effect["zmb_zeppelin_spotlight_assault"], var_20, "tag_origin");
      _playFXOnTag(level._effect["zmb_zeppelin_shot"], var_16, "tag_origin");
      wait 1;
      _stopFXOnTag(level._effect["zmb_zeppelin_spotlight_assault"], var_20, "tag_origin");
      _id_17B3();
      var_21 = _func_382("zmb_tesla_zep_beam", level._id_179A._id_6655, "tag_flash", var_16, "tag_origin");
      wait 1;
      _id_17B4();
      _id_17AD();
      var_20 delete();
      var_5 delete();
      wait 0.15;
      var_21 delete();
      var_16 delete();
      _id_4CFC(var_17);
      continue;
    }

    wait 0.5;
  }
}

_id_7E3A() {
  self notify("door_anim_change");
  self endon("door_anim_change");

  if(maps\mp\mp_zombie_nest_ee_hc_true_voice::_id_744B()) {
    var_0 = common_scripts\utility::random(self._id_AAF7);
    _id_6BFA(var_0);
    var_0._id_65D8 show();
    var_0._id_565B = 0;
    var_0 thread _id_2FF3();
    return var_0;
  } else {
    _id_6BFA();

    foreach(var_2 in self._id_AAF7) {
      var_2._id_65D8 show();
      var_2._id_565B = 0;
      var_2 thread _id_2FF3();
    }
  }
}

_id_2FF3() {
  _id_23D4();
  waitframe();

  if(!isDefined(self._id_4C13)) {
    self._id_4C13 = 0;
  }

  var_0 = "zmb_zeppelin_shot_charge_weak_spot" + (self._id_4C13 + 1);
  var_1 = common_scripts\utility::_id_44F5(var_0);
  self._id_3F44 = var_1;
  _playFXOnTag(var_1, self._id_65D8, "tag_origin");
}

_id_23D4() {
  var_0 = self._id_3F44;

  if(!isDefined(var_0)) {
    return;
  }
  _stopFXOnTag(var_0, self._id_65D8, "tag_origin");
  self._id_3F44 = undefined;
}

_id_4CFC(var_0) {
  self notify("door_anim_change");
  self endon("door_anim_change");

  foreach(var_2 in self._id_AAF7) {
    var_2._id_565B = 1;
    var_2 _id_23D4();
  }

  _id_243F(var_0);
}

_id_2E76(var_0) {
  var_1 = common_scripts\utility::_id_4461(var_0, level.players, 400);

  if(isDefined(var_1) && !common_scripts\utility::_id_562E(var_1._id_5096)) {
    var_1 thread _id_2E96(6);
    var_1 thread _id_2E8E(30);

    if(!common_scripts\utility::_id_562E(level._id_6656)) {
      level._id_6656 = 1;
      var_1 thread _id_0367::_id_8E3B("conv_zepreaction");
    }
  } else if(isDefined(var_1) && level.players.size > 1) {
    var_2 = common_scripts\utility::_id_0F93(level.players, var_1);
    var_1 = common_scripts\utility::_id_4461(var_0, var_2);

    if(isDefined(var_1) && !common_scripts\utility::_id_562E(var_1._id_5096)) {
      var_1 thread _id_2E96(6);
      var_1 thread _id_2E8E(30);
    }

    if(isDefined(var_1) && !common_scripts\utility::_id_562E(level._id_6656)) {
      level._id_6656 = 1;
      var_1 thread _id_0367::_id_8E3B("conv_zepreaction");
    }
  }
}

_id_2E8E(var_0) {
  self._id_5096 = 1;
  wait(var_0);
  self._id_5096 = 0;
}

_id_2E96(var_0) {
  wait(var_0);
  thread _id_0367::_id_8E3C("shootzepguns");
}

_id_17AC() {
  var_0 = common_scripts\utility::_id_46B5("boss_zepplin_scripted_node", "targetname");
  self._id_7B8B = var_0;
  self._id_7B8B.angles = self._id_7B8B.angles - (0, 90, 0);
}

_id_17A6() {
  level._id_179A._id_57A9 = 1;
  eqoff("s2_zmb_zeppelin_flightpath_main_entrance");
}

eqoff(var_0) {
  level._id_179A _id_71F6(var_0);
}

_id_71F6(var_0, var_1) {
  self scriptmodelclearanim();

  if(isDefined(var_1)) {
    self scriptmodelplayanimdeltamotionfrompos(var_0, var_1.origin, var_1.angles);
  } else {
    self scriptmodelplayanimdeltamotionfrompos(var_0, self._id_7B8B.origin, self._id_7B8B.angles);
  }

  _id_A690(var_0);
}

_id_A690(var_0) {
  var_1 = _getanimlength(_id_946F(var_0));
  wait(var_1);
}

_id_946F(var_0) {
  var_1 = % s2_zmb_zeppelin_flightpath_main_entrance;

  switch (var_0) {
    case "s2_zmb_zeppelin_flightpath_main_entrance":
      var_1 = % s2_zmb_zeppelin_flightpath_main_entrance;
      break;
    case "s2_zmb_zeppelin_flight_entrance_01":
      var_1 = % s2_zmb_zeppelin_flight_entrance_01;
      break;
    case "s2_zmb_zeppelin_flight_entrance_02":
      var_1 = % s2_zmb_zeppelin_flight_entrance_02;
      break;
    case "s2_zmb_zeppelin_flight_entrance_03":
      var_1 = % s2_zmb_zeppelin_flight_entrance_03;
      break;
    case "s2_zmb_zeppelin_flight_entrance_04":
      var_1 = % s2_zmb_zeppelin_flight_entrance_04;
      break;
    case "s2_zmb_zeppelin_flight_exit_01":
      var_1 = % s2_zmb_zeppelin_flight_exit_01;
      break;
    case "s2_zmb_zeppelin_flight_exit_02":
      var_1 = % s2_zmb_zeppelin_flight_exit_02;
      break;
    case "s2_zmb_zeppelin_flight_exit_03":
      var_1 = % s2_zmb_zeppelin_flight_exit_03;
      break;
    case "s2_zmb_zeppelin_flight_exit_04":
      var_1 = % s2_zmb_zeppelin_flight_exit_04;
      break;
    case "s2_zmb_zeppelin_flightpath_idle_circle_01":
      var_1 = % s2_zmb_zeppelin_flightpath_idle_circle_01;
      break;
    case "s2_zmb_zeppelin_flightpath_idle_circle_02":
      var_1 = % s2_zmb_zeppelin_flightpath_idle_circle_02;
      break;
    case "s2_zmb_zeppelin_flightpath_idle_circle_03":
      var_1 = % s2_zmb_zeppelin_flightpath_idle_circle_03;
      break;
    case "s2_zmb_zeppelin_flightpath_idle_circle_04":
      var_1 = % s2_zmb_zeppelin_flightpath_idle_circle_04;
      break;
  }

  return var_1;
}

haseq() {
  level._id_179A._id_22F1 = 1;
}

_id_90B9(var_0, var_1) {
  wait(var_1 / 2);
  var_2 = _getEnt("nest_ee_blimp_attack_gun", "targetname");
  var_2 linktosynchronizedparent(level._id_179A);
  var_3 = spawn("script_model", var_2.origin);
  var_3 setModel("tag_origin");
  _playFXOnTag(common_scripts\utility::_id_44F5("zmb_zeppelin_projectile"), var_3, "tag_origin");
  var_3 _id_0378::_id_8D74("blimp_projectile");
  var_3 moveTo(var_0.origin, var_1 / 2);
  wait(var_1 / 2);
  var_3 delete();
}

_id_1F46() {
  level._id_179A notify("cancel blimp wait");
}

_id_2E75(var_0) {
  if(!common_scripts\utility::_id_562E(level._id_1CBA)) {
    var_0 thread _id_0367::_id_8E3C("zepuberdrop");
  }
}

_id_180A(var_0, var_1) {
  thread _id_2E75(var_0);
  var_2 = spawn("script_model", self.origin);
  var_2 setModel("zmb_uberschnalle_battery_chunk_01");
  _playFXOnTag(level._effect["zmb_zep_battery_fire_trail"], var_2, "tag_origin");
  var_2 _id_0378::_id_8D74("blimp_turret_explode");
  var_3 = common_scripts\utility::_id_46B7("zmb_blimp_pieces_struct", "targetname");
  var_4 = (0, 0, -800);
  var_5 = 4;

  if(isDefined(level._id_1CBF)) {
    var_6 = _id_4469(self.origin, level._id_1CBC);
  } else {
    var_6 = _id_4469(self.origin, var_3);
  }

  var_7 = var_6;
  var_8 = var_7._id_4DEA.origin - self.origin;
  var_5 = _sqrt(_abs(var_8[2] * 2 / 800));
  var_9 = 1 / var_5;
  var_10 = var_8 * (var_9, var_9, 0);
  var_2 movegravity(var_10, var_5);

  if(isDefined(var_7._id_4DEA.angles)) {
    var_2 rotateTo(var_7._id_4DEA.angles, var_5);
  }

  wait(var_5);

  if(!common_scripts\utility::_id_562E(var_1)) {
    var_7 hudoutlineenableforclient();
  }

  var_2.origin = var_7._id_4DEA.origin;
  var_2._id_9FE6 = spawn("script_model", var_7._id_9FE1.origin);
  var_2._id_9FE6 setModel("zmb_gp_uber_01");

  if(isDefined(var_7._id_9FE1.angles)) {
    var_2._id_9FE6.angles = var_7._id_9FE1.angles;
  }

  var_2._id_9FE6 linktosynchronizedparent(var_2);

  if(isDefined(level._id_1CBF)) {
    var_2.origin = var_2.origin + (0, 0, 4);
  }

  playFX(level._effect["zmb_zep_battery_land_explosion"], var_7._id_4DEA.origin + (0, 0, -20));
  _id_0378::_id_8D74("blimp_battery_land", var_7._id_4DEA);

  if(!common_scripts\utility::_id_562E(level._id_1CBA)) {
    thread maps\mp\mp_zombie_nest_ee_util::_id_7213("zepuberhint", var_2.origin, 450, 512);
  }

  var_2._id_34A5 = var_7;
  return var_2;
}

_id_4469(var_0, var_1) {
  for(;;) {
    if(var_1.size == 0) {
      return undefined;
    }

    var_2 = common_scripts\utility::_id_4461(var_0, var_1);

    if(!isDefined(var_2._id_57F7) || !var_2._id_57F7) {
      return var_2;
    } else {
      var_1 = common_scripts\utility::_id_0F93(var_1, var_2);
    }
  }
}

hudoutlineenableforclient() {
  var_0 = spawn("script_model", self._id_7F40.origin);

  if(isDefined(self._id_7F40.angles)) {
    var_0.angles = self._id_7F40.angles;
  }

  var_0 setModel("zmb_uberschnalle_battery_rubble_01");
  self._id_7F41 = var_0;
  self._id_241F solid();
  self._id_241F show();
  self._id_241F disconnectPaths();
  var_1 = common_scripts\utility::_id_0F73(level.players, _id_0547::_id_408F());

  foreach(var_3 in var_1) {
    if(_isagent(var_3)) {
      if(var_3._id_0A4B == "zombie_boss_village") {
        continue;
      }
    }

    if(var_3 istouching(self._id_241F)) {
      if(isPlayer(var_3)) {
        var_4 = self.origin;

        if(_canspawn(var_4)) {
          var_3 setOrigin(var_4);
        } else {
          var_5 = _func_2E1(var_4);

          if(_canspawn(var_5)) {
            var_3 setOrigin(var_5);
          } else {
            _id_0488::_id_A047(var_3, 0);
          }
        }

        var_3 dodamage(var_3.health + 666, self._id_7F40.origin, undefined, undefined, "MOD_CRUSH");
        continue;
      }

      var_3 dodamage(var_3.health + 666, self._id_7F40.origin, undefined, undefined, "MOD_EXPLOSIVE");
    }
  }

  self._id_57F7 = 1;
  thread blimp_clip_exploit_listener();
}

hudoutlinedisableforclient() {
  if(isDefined(self._id_7F41)) {
    self._id_7F41 delete();
  }

  self._id_241F connectpaths();
  self._id_241F notsolid();
  self._id_241F hide();
  self._id_57F7 = 0;
  self notify("stop_exploit_listener");
}

blimp_clip_exploit_listener() {
  self endon("stop_exploit_listener");

  if(!isDefined(self._id_241F)) {
    return;
  }
  for(;;) {
    foreach(var_1 in level.players) {
      var_2 = var_1 getgroundentity();

      if(isDefined(var_2) && var_2 == self._id_241F) {
        var_3 = self.origin;

        if(_canspawn(var_3)) {
          var_1 setOrigin(var_3);
        } else {
          var_4 = _func_2E1(var_3);

          if(_canspawn(var_4)) {
            var_1 setOrigin(var_4);
          } else {
            _id_0488::_id_A047(var_1, 0);
          }
        }

        var_1 dodamage(var_1.health + 666, self._id_7F40.origin, undefined, undefined, "MOD_CRUSH");
      }
    }

    wait 0.5;
  }
}

_id_71FF() {
  if(common_scripts\utility::_id_562E(self._id_3F78)) {
    return;
  }
  self._id_3F78 = 1;
  self scriptmodelplayanim("s2_zmb_zeppelin_idle");
  var_0 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_zeppelin_gun_light"), level._id_179A._id_6655, "TAG_YAW");
  _triggerfx(var_0);
  thread deletefxondeath(var_0);
  var_0 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_zeppelin_underlight"), self, "TAG_ORIGIN");
  _triggerfx(var_0);
  thread deletefxondeath(var_0);
  var_0 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_zeppelin_spotlight_nolight"), self, "J_searchlight_A_LE_2");
  _triggerfx(var_0);
  thread deletefxondeath(var_0);
  var_0 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_zeppelin_spotlight"), self, "J_searchlight_B_LE_2");
  _triggerfx(var_0);
  thread deletefxondeath(var_0);
  var_0 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_zeppelin_spotlight_nolight"), self, "J_searchlight_C_LE_2");
  _triggerfx(var_0);
  thread deletefxondeath(var_0);
  var_0 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_zeppelin_spotlight_nolight"), self, "J_searchlight_A_RI_2");
  _triggerfx(var_0);
  thread deletefxondeath(var_0);
  var_0 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_zeppelin_spotlight"), self, "J_searchlight_B_RI_2");
  _triggerfx(var_0);
  thread deletefxondeath(var_0);
  var_0 = _spawnlinkedfx(common_scripts\utility::_id_44F5("zmb_zeppelin_spotlight_nolight"), self, "J_searchlight_C_RI_2");
  _triggerfx(var_0);
  thread deletefxondeath(var_0);
}

deletefxondeath(var_0) {
  var_0 endon("death");
  self waittill("death");
  var_0 delete();
}

_id_7204(var_0, var_1) {
  var_2 = undefined;

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_3 = 10;

  switch (var_0) {
    case 0:
      if(common_scripts\utility::_id_562E(var_1)) {
        var_2 = undefined;
      } else {
        var_2 = "zmb_nst01_rich_youfoolshavenoideawhatyou";
      }

      break;
    case 1:
      if(common_scripts\utility::_id_562E(var_1)) {
        var_2 = "zmb_nst01_rich_thisisjustaprototypestayp";
        var_3 = 3;
      } else
        var_2 = "zmb_nst01_rich_weveunlockedthepowersofgo";

      break;
    case 2:
      if(common_scripts\utility::_id_562E(var_1)) {
        var_2 = "zmb_nst01_rich_imnotdonewithyouyetplaywi";
        var_3 = 3;
      } else {
        var_2 = "zmb_nst01_rich_burnbeneaththerighteousfu";
        var_3 = 15;
      }

      break;
    case 3:
      if(common_scripts\utility::_id_562E(var_1)) {
        var_2 = "zmb_nst01_rich_illseeyouallinhelldamnyou";
        var_3 = 3;
      } else
        var_2 = "zmb_nst01_rich_yourarrivalwaspoorlytimed";

      break;
    default:
      var_2 = undefined;
      break;
  }

  if(isDefined(var_2)) {
    wait(var_3);
    thread blimpvospeaking();
    _id_0378::_id_8D74("play_blimp_dialog", var_2, level._id_179A);
  }
}

blimpvospeaking() {
  level.blimpvoplaying = 1;
  wait 10;
  level.blimpvoplaying = 0;
}