/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: vehicle_scripts\_fighter_mp.gsc
*******************************************/

main(var_0, var_1, var_2) {
  _id_764D();
}

_id_764D() {
  level._effect["p47_dmg_impact"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_impacts_lrg");
  level._effect["p47_dmg_impact_notrail"] = loadfx("vfx/vehicle/fighter_dmg_impact_notrail");
  level._effect["p47_dmg_light"] = loadfx("vfx/vehicle/p47_dmg_light");
  level._effect["p47_dmg_heavy"] = loadfx("vfx/vehicle/p47_dmg_heavy");
  level._effect["p47_contrail"] = loadfx("vfx/vehicle/p47_contrail");
  level._effect["p47_wing_evap"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_p47_wing_evap");
  level._effect["p47_exhaust"] = loadfx("vfx/vehicle/p47_exhaust");
  level._effect["bf109_wing_evap"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_wing_evap");
  level._effect["bf109_exhaust"] = loadfx("vfx/vehicle/p47_exhaust");
  level._effect["bf109_contrail_ext_vel"] = loadfx("vfx/vehicle/p47_contrail_ext_vel");

  if(getdvarint("fighter_firing_mode") == 1) {
    level._effect["p47_muzzle01"] = loadfx("vfx/vehicle/p47_muzzle01");
    level._effect["p47_muzzle02"] = loadfx("vfx/vehicle/p47_muzzle02");
  }

  level._effect["p47_death"] = loadfx("vfx/scorestreaks/ss_fighter_plane_death");
  level._effect["20mm_metal_impact_1"] = loadfx("vfx/weaponimpact/20mm_metal_impact_1");
  level._effect["p47_dmg_impact_ext_vel"] = loadfx("vfx/map/mp_raid_bomber/mp_raid_fighter_spark_impact_rnr");
  level._effect["p47_contrail_ext_vel"] = loadfx("vfx/vehicle/p47_contrail_ext_vel");

  if(getdvarint("fighter_firing_mode") == 1) {
    level._effect["p47_muzzle01_ext_vel"] = loadfx("vfx/vehicle/p47_muzzle01_ext_vel");
    level._effect["p47_muzzle02_ext_vel"] = loadfx("vfx/vehicle/p47_muzzle02_ext_vel");
  }
}

fighterinitmg(var_0) {
  var_1 = 0;

  if(isDefined(self._id_81FD))
    var_1 = self._id_81FD;

  self._id_615C = [];

  foreach(var_3 in var_0) {
    var_4 = self _meth_8181(var_3._id_95A6);
    var_5 = self gettagorigin(var_3._id_95A6);
    var_6 = _func_110(var_4, (0, -1 * var_1, 0));
    var_7 = undefined;

    if(isDefined(var_3._id_6A1B))
      var_7 = var_5 + _func_112(var_3._id_6A1B, var_4);
    else
      var_7 = var_5;

    var_8 = _func_016(var_3._id_231A, var_7, var_3._id_5135);
    var_8._id_01D1 = var_3._id_5135;
    var_8.angles = var_6;
    var_8 _meth_808C();

    if(isDefined(var_3._id_6A1B))
      var_8 _meth_8055(self, var_3._id_95A6, var_3._id_6A1B, (0, -1 * var_1, 0));
    else
      var_8 _meth_8055(self, var_3._id_95A6, (0, 0, 0), (0, -1 * var_1, 0));

    var_8 setModel(var_3.model);
    var_8._id_5847 = 1;
    var_8._id_6DB3 = self;
    var_8 makeusable();

    if(isDefined(var_3._id_00FC))
      var_8._id_00FC = var_3._id_00FC;

    self._id_615C[self._id_615C.size] = var_8;
  }
}

buildfighterturret(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level._id_A372))
    level._id_A372 = [];

  var_5 = level._id_A635;
  var_6 = spawnStruct();
  var_6._id_231A = var_0;
  var_6._id_5135 = var_1;
  var_6._id_95A6 = var_2;
  var_6.model = var_3;

  if(isDefined(var_4) && var_4 == 1)
    var_6._id_9B81 = 1;
  else
    var_6._id_9B81 = 0;

  return var_6;
}

_id_8A4D(var_0) {
  var_1 = [];
  var_2 = buildfighterturret("misc_turret", var_0, "TAG_TURRET_ATTACH_LEFT", "usa_fighter_thunderbolt_turret", 1);
  var_1[var_1.size] = var_2;
  var_2 = buildfighterturret("misc_turret", var_0, "TAG_TURRET_ATTACH_RIGHT", "usa_fighter_thunderbolt_turret", 1);
  var_1[var_1.size] = var_2;
  fighterinitmg(var_1);
}

destroyturrets() {
  foreach(var_1 in self._id_615C) {
    var_1 _meth_80B3();
    var_1 delete();
  }

  self._id_615C = undefined;
}

deathcleanup() {
  _id_36B3();
  _id_941A();

  if(0)
    _id_93FF();
}

_id_51FB(var_0) {
  _id_8A4D(var_0);
  self._id_2A89 = "tag_trail_fx";
  self._id_9BDD = "tag_trail_fx";

  if(self _meth_8445("tag_trail_fx") < 0)
    self._id_2A89 = "tag_origin";

  if(self _meth_8445("tag_trail_fx") < 0)
    self._id_9BDD = "tag_origin";

  if(0)
    thread _id_721B();

  thread _id_3F3B();
  thread _id_3F5D();
  thread fx_speed_handler();
  thread _id_6DB8();
}

spawn_tag_origin_internal() {
  if(isDefined(level._id_5FEB))
    var_0 = spawn("script_model", level._id_5FEB);
  else
    var_0 = spawn("script_model", (0, 0, 0));

  var_0 setModel("tag_origin");

  if(isDefined(self.origin))
    var_0.origin = self.origin;

  if(isDefined(self.angles))
    var_0.angles = self.angles;

  return var_0;
}

_id_6DB8() {
  self endon("death");
  var_0 = self _meth_8251();

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(self._id_29B1)) {
    self._id_29B1 = [];
    thread _id_6DB7();
  }

  var_1 = 0;
  var_2 = common_scripts\utility::_id_44F5("20mm_metal_impact_1");
  var_3 = -1;
  var_4 = 3;

  for(;;) {
    self waittill("damage", var_5, var_6, var_7, var_8, var_9);

    if(!isDefined(var_8)) {
      continue;
    }
    if(isDefined(var_6) && var_6 == self) {
      continue;
    }
    _id_02F2::_id_7FFA("raid_hit_air_dmg_plr", var_8, undefined, undefined, undefined, undefined, [var_0]);
    var_10 = level.players;
    var_10 = common_scripts\utility::_id_0F93(var_10, var_0);

    if(var_10.size > 0)
      _id_02F2::_id_7FFA("raid_hit_air_dmg_npc", var_8, undefined, undefined, undefined, undefined, var_10);

    var_1 = 1;
    var_2 = common_scripts\utility::_id_44F5("20mm_metal_impact_1");
    var_3 = 1.5;
    var_4 = 9;

    if(self._id_29B1.size < var_4) {
      var_11 = spawn_tag_origin_internal();
      var_11.fx = var_2;
      var_11.origin = var_8;
      var_11.angles = self _meth_8181(self._id_9BDD);
      var_11 _meth_8055(self, self._id_9BDD);
      self._id_29B1[self._id_29B1.size] = var_11;
      _func_147(var_11.fx, var_11, "tag_origin");

      if(var_3 > 0)
        thread _id_6DB9(var_3, var_11);
    }
  }
}

_id_6DB7() {
  self waittill("death");

  if(isDefined(self._id_29B1)) {
    foreach(var_1 in self._id_29B1) {
      if(isDefined(var_1)) {
        _func_148(var_1.fx, var_1, "tag_origin");
        var_1 delete();
      }
    }

    self._id_29B1 = undefined;
  }
}

_id_6DB9(var_0, var_1) {
  wait(var_0);

  if(isDefined(var_1) && isDefined(self) && isDefined(self._id_29B1)) {
    _func_148(var_1.fx, var_1, "tag_origin");
    self._id_29B1 = common_scripts\utility::_id_0F93(self._id_29B1, var_1);
  }

  if(isDefined(var_1))
    var_1 delete();
}

_id_721B() {
  self endon("death");
  self endon("stop_engineeffects");
  common_scripts\utility::_id_3799("engineeffects");
  common_scripts\utility::_id_379A("engineeffects");
  var_0 = undefined;

  if(self._id_01C8 == "usa_fighter_thunderbolt_player_mp")
    var_0 = common_scripts\utility::_id_44F5("p47_exhaust");
  else if(self._id_01C8 == "ger_fighter_bf109_player_mp")
    var_0 = common_scripts\utility::_id_44F5("bf109_exhaust");

  if(isDefined(var_0)) {
    for(;;) {
      common_scripts\utility::_id_379C("engineeffects");
      _func_147(var_0, self, self._id_9BDD);
      common_scripts\utility::_id_37A1("engineeffects");
      _func_148(var_0, self, self._id_9BDD);
    }
  }
}

_id_93FF() {
  common_scripts\utility::_id_3796("engineeffects");
}

_id_720A() {
  var_0 = undefined;

  if(self._id_01C8 == "usa_fighter_thunderbolt_player_mp")
    var_0 = common_scripts\utility::_id_44F5("p47_contrail_ext_vel");
  else if(self._id_01C8 == "ger_fighter_bf109_player_mp")
    var_0 = common_scripts\utility::_id_44F5("bf109_contrail_ext_vel");

  if(isDefined(var_0))
    _func_147(var_0, self, self._id_9BDD);
}

_id_93FB() {
  var_0 = undefined;

  if(self._id_01C8 == "usa_fighter_thunderbolt_player_mp")
    var_0 = common_scripts\utility::_id_44F5("p47_contrail_ext_vel");
  else if(self._id_01C8 == "ger_fighter_bf109_player_mp")
    var_0 = common_scripts\utility::_id_44F5("bf109_contrail_ext_vel");

  if(isDefined(var_0))
    _func_148(var_0, self, self._id_9BDD);
}

_id_36B3() {
  self notify("end_contrails");
  self endon("death");
  _id_93FB();
}

_id_74EE() {
  var_0 = undefined;

  if(self._id_01C8 == "usa_fighter_thunderbolt_player_mp")
    var_0 = common_scripts\utility::_id_44F5("p47_wing_evap");
  else if(self._id_01C8 == "ger_fighter_bf109_player_mp")
    var_0 = common_scripts\utility::_id_44F5("bf109_wing_evap");

  if(isDefined(var_0))
    _func_147(var_0, self, self._id_9BDD);
}

_id_941A() {
  var_0 = undefined;

  if(self._id_01C8 == "usa_fighter_thunderbolt_player_mp")
    var_0 = common_scripts\utility::_id_44F5("p47_wing_evap");
  else if(self._id_01C8 == "ger_fighter_bf109_player_mp")
    var_0 = common_scripts\utility::_id_44F5("bf109_wing_evap");

  if(isDefined(var_0))
    _func_148(var_0, self, self._id_9BDD);
}

_id_36EF() {
  self notify("end_wing_evap");
  self endon("death");
  waitframe();
  _id_941A();
}

_id_3F3B() {
  level endon("death");
  self endon("end_contrails");
  self endon("death");
  var_0 = 0;
  var_1 = 15;
  var_2 = 25;

  while(isDefined(self)) {
    var_3 = self.angles;
    var_4 = var_3[0];
    var_5 = var_3[2];
    var_6 = 0;

    if(var_5 > var_1 && var_5 < 360 - var_1 || var_5 < -1 * var_1 && var_5 > -1 * (360 - var_1))
      var_6 = 1;

    if(var_4 > var_2 && var_4 < 360 - var_2 || var_4 < -1 * var_2 && var_4 > -1 * (360 - var_2))
      var_6 = 1;

    if(var_6 && !var_0) {
      _id_720A();
      var_0 = 1;
    } else if(!var_6 && var_0) {
      _id_93FB();
      var_0 = 0;
    }

    waitframe();
  }
}

fx_speed_handler() {
  level endon("death");
  self endon("death");
  var_0 = self _meth_8251();

  if(!isDefined(var_0)) {
    return;
  }
  if(isbot(var_0) || _func_1EF(var_0)) {
    return;
  }
  var_1 = 0;

  while(isDefined(self)) {
    var_2 = var_0 _meth_82F9()[0];

    if(var_2 >= 0.5) {
      if(!var_1) {
        _func_14D(level._effect["mp_raid_bomber_speedup"], self, self._id_9BDD, var_0);
        var_1 = 1;
      }
    } else if(var_1) {
      _func_294(level._effect["mp_raid_bomber_speedup"], self, self._id_9BDD, var_0);
      var_1 = 0;
    }

    waitframe();
  }
}

_id_3F5D() {
  level endon("death");
  self endon("end_wing_evap");
  self endon("death");
  var_0 = 0;
  var_1 = 30;
  var_2 = 40;

  while(isDefined(self)) {
    var_3 = self.angles;
    var_4 = var_3[2];
    var_5 = 0;

    if(var_4 > var_1 && var_4 < 360 - var_1 || var_4 < -1 * var_1 && var_4 > -1 * (360 - var_1))
      var_5 = 1;

    if(var_5 && !var_0) {
      _id_74EE();
      var_0 = 1;
    } else if(!var_5 && var_0) {
      _id_941A();
      var_0 = 0;
    }

    waitframe();
  }
}

_id_996C() {
  self endon("death");

  for(;;) {
    self waittill("veh_collision", var_0, var_1, var_2);

    if(!isDefined(var_2) || !isPlayer(var_2)) {
      if(isDefined(self._id_6703) && !self._id_6703)
        self notify("veh_collision_except_player");

      continue;
    }

    var_3 = 0;
  }
}