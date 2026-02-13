/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2518.gsc
*************************************************/

_id_93D5() {
  level.vehicle._id_94C4 = spawnStruct();
  level.vehicle._id_94C4._id_3146 = 1;
  level.vehicle._id_94C4._id_1F25 = 11;
  level.vehicle._id_94C4._id_31F7 = 1;
  level.vehicle._id_94C4._id_F230 = 165;
  level.vehicle._id_94C4._id_31F0 = 1;
  level.vehicle._id_94C4._id_DCB0 = 1;
  level.vehicle._id_94C4._id_DCB1 = 0;
  var_0 = scripts\cp_mp\vehicles\vehicle::_id_100C1("light_tank", 1);
  var_0._id_FC21 = ::_id_9427;
  var_0._id_4841 = ::_id_93C6;
  _id_93DC();
  _id_93DA();
  _id_93DD();
  _id_93D6();
  _id_93D7();
  _id_93D8();
  _id_93DF();
  _id_93E1();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("light_tank", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "init")]]();
  }

  _id_93DE();
  thread _id_93DB();
}

_id_93DB() {
  waitframe();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("light_tank", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "initLate")]]();
  }
}

_id_93DC() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A3("light_tank", 1);
  var_0._id_54E3 = ::_id_93C3;
  var_0._id_54D6 = ::_id_93C1;
  var_0._id_5790 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10185;
  var_0._id_577B = ::_id_93C4;
  var_0._id_C187 = ::_id_9416;
  var_0._id_FD57 = ::_id_9439;
  var_0._id_FCE4 = ::_id_9436;
  var_0._id_048B = "Killstreak_Ground";
  var_0._id_577C["front"] = 125;
  var_0._id_577C["back"] = 115;
  var_0._id_577C["left"] = 70;
  var_0._id_577C["right"] = 70;
  var_0._id_577C["top"] = 130;
  var_0._id_577C["bottom"] = 0;
  var_1 = "front";
  var_0._id_5788[var_1] = (90, 0, 75);
  var_0._id_5778[var_1] = "front";
  var_1 = "back_left";
  var_0._id_5788[var_1] = (-90, 30, 60);
  var_0._id_5778[var_1] = "left";
  var_1 = "back_right";
  var_0._id_5788[var_1] = (-90, -30, 60);
  var_0._id_5778[var_1] = "right";
  var_1 = "back";
  var_0._id_5788[var_1] = (-90, -12, 60);
  var_0._id_5778[var_1] = "back";
  var_2 = ["driver", "gunner"];
  var_3 = "driver";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("light_tank", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = [var_3, "gunner", "back_left", "back_right", "front"];
  var_0._id_5788[var_3] = (35, 15, 60);
  var_0._id_5778[var_3] = "left";
  var_4._id_C725 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10194();
  var_4._id_C725 = scripts\engine\utility::array_remove(var_4._id_C725, "fire");
  var_4._id_790C = 1;
  var_4._id_430F = 0;
  var_4._id_103D2["top"] = 30;
  var_4._id_103D2["bottom"] = 35;
  var_4._id_103D2["left"] = 180;
  var_4._id_103D2["right"] = 180;
  var_4._id_18F2 = "tag_seat_0";
  var_4._id_E354 = 10;
  var_4._id_F88B = makeweapon("tur_bradley_mp");
  var_4._id_AAC6 = "ping_vehicle_driver";
  var_3 = "gunner";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("light_tank", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = [var_3, "back_left", "back_right", "driver", "front"];
  var_0._id_5788[var_3] = (-90, -12, 60);
  var_0._id_5778[var_3] = "back";
  var_4._id_C725 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101AF();
  var_4._id_F88B = makeweapon("tur_gun_lighttank_mp");
  var_4._id_AAC6 = "ping_vehicle_gunner";
}

_id_93DA() {
  var_0 = _id_09E1::_id_100EF("light_tank", 1);
  var_0._id_CFC0["single"] = ["driver", "gunner"];
}

_id_93DD() {
  var_0 = _id_09CA::_id_10373("light_tank", 1);
  var_0._id_7C8C = 1;
  var_0._id_CFC3["driver"] = 0;
  var_0._id_CFC3["gunner"] = 1;
  var_0._id_171A["turret"] = 0;
  var_0._id_171A["missile"] = 1;
  var_0._id_171A["smoke"] = 2;
  var_0._id_C930[0] = 0;
  var_0._id_C930[1] = 1;
  var_0._id_C931["driver"]["lighttank_mp"] = 0;
  var_0._id_C931["driver"]["tur_gun_lighttank_mp"] = 1;
  var_0._id_C931["driver"]["tur_gun_lighttank_ks_mp"] = 1;
  var_0._id_C931["gunner"]["tur_bradley_mp"] = 0;
  var_0._id_C931["gunner"]["tur_bradley_ks_mp"] = 0;
  var_0._id_C931["gunner"]["tur_gun_lighttank_mp"] = 1;
  var_0._id_C931["driver"]["tur_gun_lighttank_ks_mp"] = 1;
}

_id_93D6() {
  scripts\cp_mp\vehicles\vehicle_damage::_id_10069("light_tank", 1500);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::_id_10041("light_tank");
  var_0.class = "super_heavy";
  scripts\cp_mp\vehicles\vehicle_damage::_id_1002C("light_tank");
  scripts\cp_mp\vehicles\vehicle_damage::_id_10073("light_tank", 15);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10071("light_tank", ::_id_9415);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10070("light_tank", ::_id_9414);
  scripts\cp_mp\vehicles\vehicle_damage::_id_1006E("light_tank", ::_id_93B8);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10076("lighttank_tur_mp", 2);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10076("lighttank_tur_ks_mp", 2);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10076("bradley_tow_proj_mp", 7);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10076("bradley_tow_proj_ks_mp", 7);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10076("lighttank_mp", 5);
}

#using_animtree("script_model");

_id_93D7() {
  level._id_CC34["ac130"] = #animtree;
  level._id_CC31["ac130"]["light_tank_drop"] = % mp_bromeo_drop_acharlie130;
  level._id_CC32["ac130"]["light_tank_drop"] = "mp_bromeo_drop_acharlie130";
  level._id_CC34["parachute"] = #animtree;
  level._id_CC31["parachute"]["light_tank_drop"] = % mp_bromeo_drop_parachute;
  level._id_CC32["parachute"]["light_tank_drop"] = "mp_bromeo_drop_parachute";
  _id_93E0();
}

#using_animtree("mp_vehicles_always_loaded");

_id_93E0() {
  level._id_CC34["light_tank"] = #animtree;
  level._id_CC31["light_tank"]["light_tank_drop"] = % mp_bromeo_drop_bromeo;
}

_id_93D8() {
  level._effect["light_tank_cannon_dust"] = loadfx("vfx/iw8_mp/weap_kickup/vfx_wk_tank_cannon_dust_w.vfx");
  level._effect["light_tank_explode"] = loadfx("vfx/iw8_mp/killstreak/vfx_tank_death_exp.vfx");
  level._effect["light_tank_explode_alt"] = loadfx("vfx/iw8_mp/killstreak/vfx_tank_death_exp_east.vfx");
  level._effect["light_tank_land"] = loadfx("vfx/iw8_mp/killstreak/vfx_tank_dropoff_dust.vfx");
}

_id_93DF() {
  var_0 = _id_93CF();
  var_0._id_5065 = scripts\engine\utility::getstructarray("lighttank_drop", "targetname");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("light_tank", "filterDropSpawns")) {
    var_0._id_5065 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "filterDropSpawns")]](var_0._id_5065);
  }
}

_id_93E1() {
  game["dialog"]["light_tank_low_fuel"] = "light_tank_timeout_reminder";
  game["dialog"]["light_tank_destruct"] = "light_tank_self_destruct";
  game["dialog"]["light_tank_entry"] = "light_tank_chatter_01";
  game["dialog"]["light_tank_chatter_01"] = "light_tank_chatter_02";
  game["dialog"]["light_tank_chatter_02"] = "light_tank_chatter_03";
}

_id_93B3(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  if(istrue(var_0._id_FE22)) {
    var_0.modelname = "veh8_mil_lnd_coscar_east";
  } else {
    var_0.modelname = "veh8_mil_lnd_coscar_west";
  }

  var_0._id_0481 = "light_tank";
  var_0._id_04DE = "veh_bradley_mp";
  var_0._id_31A0 = 1;
  var_0._id_E728 = 0;
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnvehicle(var_0, var_1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  var_2._id_8872 = var_0.spawntype == "KILLSTREAK";
  var_3 = _id_93B4(var_2, var_0);
  var_3._id_9F7F = 2;
  var_3._id_9016 = 0;
  scripts\cp_mp\vehicles\vehicle::_id_10240(var_2, var_3, makeweapon("tur_bradley_mp"), 1);
  var_3 = _id_93B5(var_2, var_0);
  scripts\cp_mp\vehicles\vehicle::_id_10240(var_2, var_3, makeweapon("tur_gun_lighttank_mp"));
  scripts\cp_mp\vehicles\vehicle::vehicle_create(var_2, "light_tank", var_0);
  var_2.objweapon = makeweapon("lighttank_mp");
  var_2 _id_942E();
  var_4 = scripts\cp_mp\vehicles\vehicle_damage::_id_1003E(var_2, 1);
  var_4._id_4861 = "none";

  if(_id_09E1::_id_100F8(var_2)) {
    var_2 _id_09E1::_id_100E5(var_2, 0);
  }

  scripts\cp_mp\vehicles\vehicle::_id_10028(var_2, var_0);
  var_2 scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015D(0);
  var_2 scripts\cp_mp\vehicles\vehicle_damage::_id_1006D(0);
  thread scripts\cp_mp\vehicles\vehicle::_id_102E2(var_2, undefined, ::_id_93CA, "flipped_end");
  var_2 thread _id_93E7();
  var_2 thread _id_93E8();
  var_2 thread _id_93EA();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("light_tank", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "create")]](var_2);
  }

  return var_2;
}

_id_93B4(var_0, var_1) {
  var_2 = _id_93CF();
  var_3 = undefined;

  if(var_0._id_8872) {
    var_3 = "tur_bradley_ks_mp";
  } else {
    var_3 = "tur_bradley_mp";
  }

  var_4 = spawnturret("misc_turret", var_0 gettagorigin("tag_turret"), var_3, 0);
  var_4 linkto(var_0, "tag_turret", (0, 0, 0), (0, 0, 0));

  if(istrue(var_1._id_FE22)) {
    var_4 setModel("veh8_mil_lnd_coscar_east_turret");
  } else {
    var_4 setModel("veh8_mil_lnd_coscar_west_turret");
  }

  var_4 setmode("sentry_offline");
  var_4 setsentryowner(undefined);
  var_4 makeunusable();
  var_4 setdefaultdroppitch(0);
  var_4 _meth_839D(1);
  var_4.angles = var_0.angles;
  var_4.vehicle = var_0;
  return var_4;
}

_id_93B5(var_0, var_1) {
  var_2 = _id_93CF();
  var_3 = scripts\cp_mp\vehicles\vehicle::_id_100CC(var_0, "tur_bradley_mp");
  var_4 = undefined;

  if(var_0._id_8872) {
    var_4 = "tur_gun_lighttank_ks_mp";
  } else {
    var_4 = "tur_gun_lighttank_mp";
  }

  var_5 = spawnturret("misc_turret", var_3 gettagorigin("turret_animate_jnt"), var_4, 0);
  var_5 linkto(var_3, "turret_animate_jnt", (0, 0, 0), (0, 0, 0));

  if(istrue(var_1._id_FE22)) {
    var_5 setModel("veh8_mil_lnd_coscar_east_turret_gun");
  } else {
    var_5 setModel("veh8_mil_lnd_coscar_west_turret_gun");
  }

  var_5 setmode("sentry_offline");
  var_5 setsentryowner(undefined);
  var_5 makeunusable();
  var_5 setdefaultdroppitch(0);
  var_5 _meth_839D(1);
  var_5.angles = var_0.angles;
  var_5.vehicle = var_0;
  return var_5;
}

_id_9395() {
  if(istrue(self._id_872F)) {
    return;
  }
  self._id_872F = 1;
  var_0 = _id_93CF();
  scripts\cp_mp\vehicles\vehicle_damage::_id_1006D(1);
  var_1 = undefined;

  if(scripts\cp_mp\utility\game_utility::_id_89EC()) {
    var_1 = 0;
  } else if(isDefined(self._id_E293._id_DCB0)) {
    var_1 = self._id_E293._id_DCB0;
  } else {
    var_1 = var_0._id_DCB0;
  }

  if(var_1) {
    _id_93B6();
    _id_942E();
  }

  scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015D(1);
  _id_09E1::_id_100E5(self, 1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("light_tank", "activate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "activate")]](self);
  }
}

_id_93C6(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;

  if(isDefined(var_0)) {
    var_4 = var_0.inflictor;
    var_6 = var_0._id_9CD6;
    var_7 = "bradley";
    var_3 = var_0.attacker;
    var_5 = var_0.objweapon;
    var_8 = undefined;
    var_9 = var_0.damage;
    var_10 = "destroyed_" + var_7;
    var_11 = var_7 + "_destroyed";
    var_12 = "callout_destroyed_" + var_7;
    var_13 = 1;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "onKillstreakKilled")) {
      var_14 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "onKillstreakKilled")]](var_7, var_3, var_5, var_8, var_9, var_10, var_11, var_12, var_13);
    }
  } else {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "lighttank_mp";
    var_0._id_9CD6 = "MOD_EXPLOSIVE";
  }

  if(isDefined(self.owner) && isDefined(self.streakinfo)) {
    self.streakinfo._id_57A7 = 1;

    if(!istrue(self._id_C143)) {
      self.owner scripts\cp_mp\utility\killstreak_utility::_id_C14A(self.streakinfo);
    }
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_10060(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_101C5(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10030(undefined, undefined, 1);
  thread _id_93B9();

  if(!istrue(level._id_EBC3)) {
    var_15 = self gettagorigin("body_animate_jnt");

    if(!isDefined(var_3)) {
      var_3 = self;
    }

    self radiusdamage(var_15, 256, 140, 70, var_3, "MOD_EXPLOSIVE", "lighttank_mp");
    var_16 = self gettagorigin("tag_origin");
    var_17 = undefined;

    if(istrue(self._id_E293._id_FE22)) {
      var_17 = "light_tank_explode_alt";
    } else {
      var_17 = "light_tank_explode";
    }

    playFX(scripts\engine\utility::getfx(var_17), var_16, anglesToForward(self.angles));
    playsoundatpos(var_16, "veh_bradley_expl_destr");
    earthquake(0.4, 0.7, var_16, 800);
    playrumbleonposition("grenade_rumble", var_16);
    physicsexplosionsphere(var_16, 500, 200, 1);
  }
}

_id_93B9() {
  scripts\cp_mp\vehicles\vehicle::_id_1008F(self);

  if(istrue(self._id_7EAB)) {
    self _meth_84FD();
    self._id_7EAB = undefined;
  }

  thread _id_93BF(self);
  _id_93BA();

  if(isDefined(self._id_A901)) {
    _id_93BB(self._id_A901);
    self._id_A901 = undefined;
  }

  if(isDefined(self.streakinfo) && isDefined(level._id_8DD3)) {
    level thread[[level._id_8DD3]](self.streakinfo);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("light_tank", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "delete")]](self);
  }

  waitframe();

  if(isDefined(self._id_5062)) {
    self._id_5062._id_8800 = undefined;
    self._id_5062 = undefined;
  }

  scripts\cp_mp\vehicles\vehicle::_id_10090(self);
}

_id_93E2(var_0, var_1) {
  playFX(scripts\engine\utility::getfx("light_tank_land"), var_0, anglesToForward(var_1));
  earthquake(0.3, 0.7, var_0, 800);
  playrumbleonposition("grenade_rumble", var_0);
  physicsexplosionsphere(var_0, 800, 400, 0.5);
}

_id_93D9(var_0) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
  }

  if(!isDefined(var_0._id_E325)) {
    var_0._id_E325 = "airdrop_at_position_unsafe";
  }

  if(!isDefined(var_0._id_3151)) {
    var_0._id_3151 = 0;
  }

  if(!isDefined(var_0._id_3152)) {
    var_0._id_3152 = 0;
  }

  if(!isDefined(var_0._id_0EF4)) {
    var_0._id_0EF4 = 1;
  }

  if(!isDefined(var_0._id_587C)) {
    var_0._id_587C = 0;
  }

  return var_0;
}

_id_93A5(var_0, var_1) {
  var_1._id_E325 = var_0._id_E325;
  var_1._id_3151 = var_0._id_3151;
  var_1._id_3152 = var_0._id_3152;
  var_1._id_0EF4 = var_0._id_0EF4;
  var_1._id_587C = var_0._id_587C;
  var_1._id_31F7 = var_0._id_31F7;
  var_1._id_DCB0 = var_0._id_DCB0;
}

_id_941A(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_0 = _id_93D9(var_0);
  var_8 = issubstr(var_0._id_E325, "_unsafe");
  var_9 = issubstr(var_0._id_E325, "airdrop_");

  if(var_8) {
    var_3 = var_0.origin;
    var_4 = var_0.angles;

    if(isDefined(var_0.owner) && istrue(var_0._id_587C)) {
      var_10 = var_3 - var_0.owner.origin;

      if(_func_0134(var_10) > 0) {
        var_4 = vectortoangles(var_3 - var_0.owner.origin);
      } else {
        var_4 = var_0.owner getplayerangles(1);
      }
    }
  } else {
    if(isDefined(var_0.owner) && var_0._id_E325 == "airdrop_from_player") {
      var_3 = _id_93CB(var_0.owner);
    } else {
      var_3 = var_0.origin;
    }

    var_7 = _id_93CC(var_3, var_0);

    if(isDefined(var_7)) {
      if(!isDefined(var_7.angles)) {
        var_7.angles = (0, 0, 0);
      }

      var_3 = var_7.origin;
      var_5 = var_7.origin;
      var_6 = anglestoup(var_7.angles);

      if(isDefined(var_0.owner) && istrue(var_0._id_587C)) {
        var_10 = var_3 - var_0.owner.origin;

        if(_func_0134(var_10) > 0) {
          var_4 = vectortoangles(var_3 - var_0.owner.origin);
        } else {
          var_4 = var_0.owner getplayerangles(1);
        }
      }

      var_4 = _id_93CD(var_4, var_7);

      if(var_9) {
        var_3 = var_3 + (0, 0, 150);
      } else {
        var_3 = var_3 + (0, 0, 60);
      }
    } else {
      if(isDefined(var_1)) {
        var_1._id_58CA = "no_spawns_found";
      }

      return undefined;
    }
  }

  if(!isDefined(var_4)) {
    var_4 = (0, randomint(360), 0);
  } else {
    var_4 = var_4 * (0, 1, 0);
  }

  var_11 = undefined;

  if(var_9) {
    var_11 = _id_939A(var_3, var_4, var_5, var_6, var_0, var_1);

    if(isDefined(var_11) && isDefined(var_7)) {
      var_11._id_5062 = var_7;
      var_7._id_8800 = 1;
    }
  } else
    var_11 = _id_9411(var_3, var_4, var_0, var_1);

  if(isDefined(var_11) && isDefined(var_0.owner) && isDefined(var_2)) {
    var_11.streakinfo = var_2;
    var_12 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](var_0.owner, var_2.streakname);
      var_12 = 2.0;
    }

    var_0.owner thread scripts\cp_mp\utility\killstreak_utility::_id_B86F("use_bradley", 1, var_12);
  }

  return var_11;
}

_id_9411(var_0, var_1, var_2, var_3) {
  var_4 = var_2.origin;
  var_5 = var_2.angles;
  var_2.origin = var_0;
  var_2.angles = var_1;
  var_6 = _id_93B3(var_2, var_3);
  var_2.origin = var_4;
  var_2.angles = var_5;

  if(!isDefined(var_6)) {
    return undefined;
  }

  if(var_2._id_3151) {
    if(var_2._id_3152) {
      thread _id_941B(var_6, var_2.owner, var_2.team);
    }
  } else if(var_2._id_0EF4)
    var_6 thread _id_9395();

  return var_6;
}

_id_93CB(var_0) {
  var_1 = var_0 getEye();
  var_2 = var_0 getplayerangles();
  var_3 = max(-5, min(_func_000B(var_2[0]), 45));
  var_2 = (_func_000A(var_3), var_2[1], var_2[2]);
  var_4 = anglesToForward(var_2);
  var_5 = anglesToForward(var_2 * (0, 1, 0));
  var_6 = var_1;
  var_7 = var_1 + var_4 * 1800;
  var_8 = physics_createcontents(["physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_playerclip", "physicscontents_vehicleclip"]);
  var_9 = _func_02C1(var_6, var_7, var_8, undefined, 0, "physicsquery_closest", 1);

  if(isDefined(var_9) && var_9.size > 0) {
    var_7 = var_9[0]["position"];
  }

  var_10 = vectordot(var_7 - var_6, var_5);

  if(var_10 < 400) {
    var_10 = 400;
  }

  var_7 = var_6 + var_5 * var_10;
  return var_7;
}

_id_939A(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_4.origin;
  var_7 = var_4.angles;
  var_4.origin = var_0;
  var_4.angles = var_1;
  var_8 = _id_93B3(var_4, var_5);
  var_4.origin = var_6;
  var_4.angles = var_7;

  if(!isDefined(var_8)) {
    return undefined;
  }

  var_8._id_18AF = "light_tank";
  var_8 _meth_8449();
  var_8 hide();
  var_9 = scripts\cp_mp\vehicles\vehicle::_id_100CD(var_8);

  foreach(var_11 in var_9) {
    var_11 hide();
  }

  var_13 = spawn("script_model", var_0);
  var_13.angles = var_1;
  var_13 setModel("tag_origin");
  var_14 = undefined;

  if(isDefined(var_2)) {
    if(!scripts\cp_mp\utility\game_utility::_id_89EC()) {
      var_14 = _id_93B7(var_2, var_3, var_4);
      var_8._id_A901 = var_14;
    }
  }

  var_15 = spawn("script_model", var_0);
  var_15.angles = var_1;
  var_15._id_18AF = "parachute";
  var_15 setModel("veh8_mil_lnd_bromeo_parachute");
  var_15 _id_06C6::_id_D47B();
  var_15 hide();
  var_16 = spawn("script_model", var_0);
  var_16.angles = var_1;
  var_16._id_18AF = "ac130";
  var_16 setModel("veh8_mil_air_acharlie130_ks_carrier");
  var_16 _id_06C6::_id_D47B();
  var_16 hide();
  var_13.vehicle = var_8;
  var_13._id_AE18 = var_15;
  var_13._id_32D5 = var_16;
  var_13._id_A901 = var_14;
  var_17 = gettime() + level._id_01E2;
  var_13._id_534E = gettime();
  var_13._id_102FF = var_17 + _func_0079(level._id_CC31["light_tank"]["light_tank_drop"]) * 1000;

  if(var_13._id_102FF > var_13._id_534E) {
    var_13._id_534E = var_13._id_102FF;
  }

  var_13._id_AE2D = var_17 + _func_0079(level._id_CC31["parachute"]["light_tank_drop"]) * 1000;

  if(var_13._id_AE2D > var_13._id_534E) {
    var_13._id_534E = var_13._id_AE2D;
  }

  var_13._id_32D9 = var_17 + _func_0079(level._id_CC31["ac130"]["light_tank_drop"]) * 1000;

  if(var_13._id_32D9 > var_13._id_534E) {
    var_13._id_534E = var_13._id_32D9;
  }

  var_13 thread _id_939B();
  return var_8;
}

_id_939B() {
  _id_06C6::_id_17C2(self.vehicle, "light_tank_drop");
  _id_06C6::_id_17C2(self._id_AE18, "light_tank_drop");
  _id_06C6::_id_17C2(self._id_32D5, "light_tank_drop");
  waitframe();

  if(isDefined(self.vehicle)) {
    self.vehicle show();
    var_0 = scripts\cp_mp\vehicles\vehicle::_id_100CD(self.vehicle);

    foreach(var_2 in var_0) {
      var_2 show();
    }

    thread _id_06C6::_id_1845(self.vehicle, "light_tank_drop");
  }

  if(isDefined(self._id_AE18)) {
    self._id_AE18 show();
    thread _id_06C6::_id_1845(self._id_AE18, "light_tank_drop");
  }

  if(isDefined(self._id_32D5)) {
    self._id_32D5 show();
    self._id_32D5 playLoopSound("iw8_bradley_drop_c130");
    self._id_32D5 setscriptablepartstate("lights2", "on", 0);
    self._id_32D5 setscriptablepartstate("contrails", "on", 0);
    thread _id_06C6::_id_1845(self._id_32D5, "light_tank_drop");
  }

  while(gettime() <= self._id_534E) {
    if(!isDefined(self.vehicle) || istrue(self.vehicle._id_87FB) || gettime() >= self._id_102FF) {
      thread _id_93BC(self.vehicle);
    }

    if(isDefined(self._id_AE18) && gettime() >= self._id_AE2D) {
      self._id_AE18 delete();
    }

    if(isDefined(self._id_32D5) && gettime() >= self._id_32D9) {
      self._id_32D5 delete();
    }

    waitframe();
  }

  thread _id_93BC(self.vehicle);

  if(isDefined(self._id_AE18)) {
    self._id_AE18 delete();
  }

  if(isDefined(self._id_32D5)) {
    self._id_32D5 delete();
  }

  self delete();
}

_id_93BC(var_0) {
  self.vehicle = undefined;

  if(isDefined(var_0)) {
    var_0 _meth_844A();
    var_0 thread _id_941C();
  }

  if(isDefined(self._id_A901)) {
    _id_93BB(self._id_A901);
    self._id_A901 = undefined;
  }
}

_id_941C() {
  self endon("death");
  self._id_7EAB = 1;
  self physics_registerforcollisioncallback();
  waitframe();
  var_0 = gettime() + 5000;
  var_1 = undefined;
  var_2 = undefined;

  while(gettime() < var_0) {
    if(!isDefined(var_1)) {
      var_1 = vectordot(self _meth_8431(), (0, 0, -1));
    } else {
      var_3 = vectordot(self _meth_8431(), (0, 0, -1));
      var_4 = (var_3 - var_1) / level._id_5F3A;

      if(isDefined(var_2)) {
        if(var_2 - var_4 >= 300) {
          _id_93E2(self.origin, self.angles);
          break;
        }
      }

      var_1 = var_3;
      var_2 = var_4;
    }

    waitframe();
  }

  self._id_7EAB = undefined;
  self _meth_84FD();

  while(_func_0135(self _meth_8431()) > 400) {
    waitframe();
  }

  var_5 = scripts\cp_mp\vehicles\vehicle_tracking::_id_6E3F(self);

  if(isDefined(self._id_5062)) {
    self._id_5062._id_8800 = undefined;
    self._id_5062 = undefined;
  }

  if(var_5._id_3151) {
    if(var_5._id_3152) {
      thread _id_941B(self, self.owner, self.team);
    }
  } else if(var_5._id_0EF4)
    thread _id_9395();
}

_id_93B7(var_0, var_1, var_2) {
  var_3 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "requestObjectiveID")]](99);
  var_4 = spawn("script_model", var_0);
  var_4 setModel("ks_airstrike_marker_mp");
  var_5 = (1, 0, 0);
  var_6 = _func_025B(var_5, var_1);
  var_5 = _func_025B(var_1, var_6);
  var_7 = _func_0017(var_5, var_6, var_1);
  var_4.angles = var_7;

  if(var_3 != -1) {
    var_4._id_A906 = var_3;
    _func_0160(var_3, var_4);
    _func_015D(var_3, "icon_waypoint_tank");
    _func_0161(var_3, 55);
    _func_0172(var_3, 0);
    _func_0173(var_3, 0);
    _func_017A(var_3, 1);
    _func_018C(var_3);
    _func_016B(var_3, "current");

    if(level.teambased) {
      var_8 = var_2.team;

      if(!isDefined(var_8) || var_8 == "neutral") {
        if(isDefined(var_2.owner)) {
          var_8 = var_2.owner.team;
        }
      }

      if(!isDefined(var_8) || var_8 == "neutral") {
        _func_0188(var_3);
        var_4 setscriptablepartstate("marker_placed", "onEveryone", 0);
      } else {
        _func_0187(var_3, var_8);
        _id_9418(var_4, var_8);
        var_4 setscriptablepartstate("marker_placed", "onTeam", 0);
      }
    } else if(!isDefined(var_2.owner)) {
      _func_0188(var_3);
      var_4 setscriptablepartstate("marker_placed", "onEveryone", 0);
    } else {
      _func_0181(var_3, var_2.owner);
      _func_0185(var_3, var_2.owner);
      var_4 setotherent(var_2.owner);
      var_4 setscriptablepartstate("marker_placed", "on", 0);
    }
  }

  return var_4;
}

_id_93BB(var_0) {
  if(isDefined(var_0._id_A906)) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](var_0._id_A906);
  }

  var_0 delete();
}

_id_9418(var_0, var_1) {
  var_0 notify("light_tank_setTeamOtherEnt");
  var_0 endon("light_tank_setTeamOtherEnt");
  var_2 = undefined;

  foreach(var_4 in level.players) {
    if(var_4.team == var_1) {
      var_2 = var_4;
      break;
    }
  }

  if(isDefined(var_2)) {
    var_0 setotherent(var_2);
    childthread _id_93EC(var_0, var_2);
    childthread _id_93EB(var_0, var_2);
  }
}

_id_93EC(var_0, var_1) {
  var_0 endon("death");
  var_2 = var_1.team;
  var_1 scripts\engine\utility::waittill_any_2("joined_team", "joined_spectators");
  thread _id_9418(var_0, var_2);
}

_id_93EB(var_0, var_1) {
  var_2 = var_1.team;
  var_1 waittill("disconnect");
  thread _id_9418(var_0, var_2);
}

_id_941B(var_0, var_1, var_2) {
  var_3 = _id_93CF();

  if(var_3._id_31F0) {
    var_0 scripts\cp_mp\vehicles\vehicle_damage::_id_1006D(1);
  }

  var_4 = undefined;

  if(scripts\cp_mp\utility\game_utility::_id_89EC()) {
    var_4 = 0;
  } else if(isDefined(var_0._id_E293._id_DCB0)) {
    var_4 = var_0._id_E293._id_DCB0;
  } else {
    var_4 = var_3._id_DCB0;
  }

  if(var_4) {
    var_0 _id_93B6(1);
    var_0 _id_942E(var_1, var_2);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("light_tank", "startCapture")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "startCapture")]](var_0, var_1, var_2);
  }
}

_id_93BF(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("light_tank", "endCapture")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "endCapture")]](var_0);
  }
}

_id_93A1(var_0, var_1) {
  thread _id_93BF(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_101FC(var_0, var_1.team);
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_101FB(var_0, var_1);
  thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_1017E(var_0, "driver", var_1);
  var_0 thread _id_9395();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("light_tank", "capture")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "capture")]](var_1, var_0);
  }
}

_id_9427(var_0) {
  if(scripts\cp_mp\vehicles\vehicle::_id_8AF7()) {
    return;
  }
  _id_943A();
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_1020B("driver");
}

_id_93E7() {
  self endon("death");
  var_0 = scripts\cp_mp\vehicles\vehicle::_id_100CC(self, "tur_bradley_mp");
  var_0 endon("death");
  var_0._id_DA6A = 8;
  _id_942B();
  _id_9434();

  for(;;) {
    var_1 = var_0 scripts\engine\utility::_id_10897("turret_fire", "turret_reload");

    if(var_1 == "turret_reload") {
      var_0._id_DA6A = 0;
      _id_942B();
      _id_93BD();
      continue;
    }

    _id_9426();
    _id_9397(-1);
    var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101AC(self, "driver");

    if(var_0._id_DA6A <= 0) {
      _id_93BD();
    }
  }
}

_id_93E8() {
  self endon("death");
  var_0 = scripts\cp_mp\vehicles\vehicle::_id_100CC(self, "tur_bradley_mp");
  var_0 endon("death");

  for(;;) {
    var_0 waittill("turret_fire", var_1);
    var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101AC(self, "driver");
    var_1 thread _id_9440(var_2);

    if(isDefined(self.streakinfo)) {
      var_1.streakinfo = self.streakinfo;
      self.streakinfo._id_DA63++;
    }
  }
}

_id_9440(var_0) {
  level endon("game_ended");
  self waittill("explode", var_1);

  if(!isDefined(var_0)) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("spawn", "addSpawnDangerZone")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("spawn", "addSpawnDangerZone")]](var_1, 175, 175, var_0.team, 1, var_0, 1);
  }
}

_id_93E9(var_0) {
  self endon("death");
  var_1 = scripts\cp_mp\vehicles\vehicle::_id_100CC(self, "tur_bradley_mp");

  if(isDefined(var_0)) {
    var_0 endon("vehicle_change_seat");
    var_0 endon("vehicle_seat_exit");
    var_0 endon("death_or_disconnect");

    while(var_0 reloadbuttonpressed()) {
      waitframe();
    }

    var_2 = getdvarint("#x374b6dca2a5ac069b", 250) / 1000;

    for(;;) {
      var_3 = 0.0;
      var_4 = var_0 _meth_874B();

      while(var_0 reloadbuttonpressed()) {
        if(!var_0 usinggamepad() && var_1._id_DA6A < 8) {
          var_1 notify("turret_reload");
          break;
        } else {
          if(var_1._id_DA6A < 8 && var_4 > 0 && var_3 >= var_2) {
            var_1 notify("turret_reload");
          }

          var_3 = var_3 + level._id_5F3A;
          waitframe();
        }
      }

      if(var_0 usinggamepad() && var_1._id_DA6A < 8 && (var_4 == 0 && var_3 > 0.0 && var_3 < 0.2 || var_4 > 0 && var_3 >= var_2)) {
        var_1 notify("turret_reload");
      }

      waitframe();
    }
  }
}

_id_9397(var_0) {
  var_1 = scripts\cp_mp\vehicles\vehicle::_id_100CC(self, "tur_bradley_mp");
  var_1._id_DA6A = var_1._id_DA6A + var_0;
  var_1._id_DA6A = int(clamp(var_1._id_DA6A, 0, 8));
  _id_942B();
}

_id_942B() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101AC(self, "driver");

  if(isDefined(var_0)) {
    var_1 = scripts\cp_mp\vehicles\vehicle::_id_100CC(self, "tur_bradley_mp");
    _id_09CA::_id_10382("light_tank", "turret", var_1._id_DA6A, var_0);
  }
}

_id_93BD() {
  var_0 = scripts\cp_mp\vehicles\vehicle::_id_100CC(self, "tur_bradley_mp");
  var_0 _meth_8410();
  var_1 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101AC(self, "driver");

  if(isDefined(var_1)) {
    thread _id_93BE(var_1, "weap_bradley_reload_plr", "weap_bradley_reload_npc");
  }

  wait 2.7;
  _id_9397(8);
  wait 0.15;
  var_0 _meth_8411();
}

_id_93BE(var_0, var_1, var_2) {
  var_0 playlocalsound(var_1);
  var_0 playSound(var_2, var_0);
}

_id_943F() {
  self notify("watch_missile_input_change");
  self endon("watch_missile_input_change");

  for(;;) {
    var_0 = _id_93D0();
    self notifyonplayercommand("light_tank_missile", var_0);
    var_1 = scripts\engine\utility::_id_1089F("input_type_changed", "missile_handling_ended");
    self _meth_824C("light_tank_missile", var_0);

    if(!isDefined(var_1) || var_1 == "missile_handling_ended") {
      break;
    }
  }
}

_id_9421() {
  self notify("missile_handling_ended");
}

_id_93D0() {
  return "+frag";
}

_id_93E5(var_0) {
  self endon("death");
  self endon("light_tank_driver_exit");

  for(;;) {
    var_0 waittill("light_tank_missile");
    var_1 = scripts\cp_mp\vehicles\vehicle::_id_100CC(self, "tur_bradley_mp");

    if(gettime() - var_1._id_9016 >= 1330.0) {
      if(var_1._id_9F7F > 0) {
        var_1._id_9016 = gettime();
        scripts\cp_mp\vehicles\vehicle_occupancy::_id_10186(var_0);
        _id_93C7(var_0, var_0._id_E85C);
        _id_9398(-1);
        continue;
      }
    }
  }
}

_id_93C7(var_0, var_1) {
  wait 0.33;
  var_2 = scripts\cp_mp\vehicles\vehicle::_id_100CC(self, "tur_bradley_mp");
  var_3 = var_2 gettagorigin("tag_flash");
  var_4 = var_2 gettagangles("tag_flash");
  var_5 = var_3 + anglesToForward(var_4);
  var_0 childthread _id_9413();
  var_2 setscriptablepartstate("towMissileFX", "active", 0);
  var_6 = undefined;

  if(istrue(self._id_8872)) {
    var_6 = "bradley_tow_proj_ks_mp";
  } else {
    var_6 = "bradley_tow_proj_mp";
  }

  if(isDefined(self.streakinfo)) {
    self.streakinfo._id_DA63++;
  }

  var_7 = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon(var_6), var_3, var_5, var_0);
  var_7.vehicle = self;
  var_7.streakinfo = self.streakinfo;

  if(isDefined(var_1)) {
    var_7 missile_settargetent(var_1);
    thread scripts\cp_mp\utility\weapon_utility::_id_10C14(var_1, var_7);
  }
}

_id_9398(var_0) {
  var_1 = scripts\cp_mp\vehicles\vehicle::_id_100CC(self, "tur_bradley_mp");
  var_1._id_9F7F = var_1._id_9F7F + var_0;
  var_1._id_9F7F = int(clamp(var_1._id_9F7F, 0, 2));
  _id_9434();
}

_id_9434() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101AC(self, "driver");

  if(isDefined(var_0)) {
    var_1 = scripts\cp_mp\vehicles\vehicle::_id_100CC(self, "tur_bradley_mp");
    _id_09CA::_id_10382("light_tank", "missile", var_1._id_9F7F, var_0);
  }
}

_id_9413() {
  self endon("disconnect");
  self _meth_82EE(0.333, 0.1);
  wait 0.15;
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_101B4();
  wait 0.35;
  _id_93C0();
}

_id_93C0(var_0) {
  if(!istrue(var_0)) {
    self _meth_82EE(0.0, 0.1);
  } else {
    self _meth_82EE(0.0, 0.0);
  }
}

_id_93EA() {
  self endon("death");
  var_0 = scripts\cp_mp\vehicles\vehicle::_id_100CC(self, "tur_gun_lighttank_mp");

  for(;;) {
    var_0 waittill("turret_fire");

    if(isDefined(self.streakinfo)) {
      self.streakinfo._id_DA63++;
    }
  }
}

_id_9428(var_0) {
  var_1 = _id_93CF();

  if(var_1._id_3146) {
    if(istrue(self._id_1F24)) {
      _id_09CA::_id_10390("burningDown", var_0, "light_tank");
    } else {
      _id_09CA::_id_1037B("burningDown", var_0, "light_tank");
    }
  } else
    _id_09CA::_id_1037B("burningDown", var_0, "light_tank");
}

_id_943B(var_0, var_1) {
  var_2 = _id_93CF();

  if(_id_939E()) {
    if(!isDefined(var_1)) {
      var_1 = (var_2._id_F230 - self._id_F20D) / var_2._id_F230;
      var_1 = clamp(var_1, 0, 1);
    }

    _id_09CA::_id_10389(var_1, var_0);
    _id_09CA::_id_1038F(var_0);
  } else {
    _id_09CA::_id_1036C(var_0);
    _id_09CA::_id_1037A(var_0);
  }
}

_id_943A() {
  if(_id_939E()) {
    if(!isDefined(self._id_F20D)) {
      self._id_F20D = 0;
    }

    if(istrue(self._id_872F)) {
      self._id_F20D = self._id_F20D + level._id_5F3A;
      var_0 = _id_93CF();
      var_1 = (var_0._id_F230 - self._id_F20D) / var_0._id_F230;
      var_1 = int(_func_0037(clamp(var_1, 0, 1) * 100));

      if(self._id_F20D >= var_0._id_F230) {
        thread _id_9423();
        return;
      }

      var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018B(self);

      foreach(var_4 in var_2) {
        _id_943B(var_4, var_1);
      }

      return;
    } else {
      var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018B(self);

      foreach(var_4 in var_2) {
        _id_943B(var_4, 1);
      }
    }
  } else
    self._id_F20D = undefined;
}

_id_9423() {
  if(_id_939D()) {
    thread _id_939C();
    var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018B(self);

    foreach(var_2 in var_0) {
      _id_943B(var_2, undefined);
    }
  } else
    thread _id_93C6(undefined, 0, 1);
}

_id_93C3(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "gunner") {
    scripts\cp_mp\vehicles\vehicle_occupancy::_id_101B3(var_3, "tur_gun_lighttank_mp", var_4, 1);
  }
}

_id_93C1(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4._id_EACB)) {
    thread _id_93C2(var_0, var_1, var_2, var_3, var_4);
  } else if(!istrue(var_4._id_B695) && !istrue(var_4._id_B68D)) {
    if(var_1 == "gunner") {
      _id_9417(var_3);
      thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_10206(var_3, var_0, "tur_gun_lighttank_mp", var_4, 1);
    }
  }
}

_id_93C2(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_1017C(var_3, 0.1);
    var_5 = scripts\cp_mp\vehicles\vehicle::_id_100CC(var_0, "tur_bradley_mp");
    var_5.owner = var_3;
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 _meth_8094(var_0);
    var_5 = scripts\cp_mp\vehicles\vehicle::_id_100CC(var_0, "tur_bradley_mp");
    var_5 setotherent(var_3);
    var_5 setentityowner(var_3);
    var_5 setsentryowner(var_3);
    var_3 _meth_828F(var_5);
    var_3 scripts\cp_mp\utility\killstreak_utility::_id_8DBE();
    var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015E(var_0, var_1, var_2);
  } else if(var_1 == "gunner") {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_1017C(var_3, 0);
    var_5 = scripts\cp_mp\vehicles\vehicle::_id_100CC(var_0, "tur_gun_lighttank_mp");
    var_5.owner = var_3;
    var_5 setotherent(var_3);
    var_5 setentityowner(var_3);
    var_5 setsentryowner(var_3);
    var_3 _meth_80AF();
    var_3 controlturreton(var_5);
    _id_9396(var_3);
  }

  if(!isDefined(var_2)) {
    var_0 _id_942F(var_3);
  }

  _id_09CA::_id_10393(var_0, var_2, var_1, var_3);
  _id_9437(var_0, var_2, var_1, var_3);

  if(var_1 == "driver") {
    var_0 thread _id_93E9(var_3);
  }
}

_id_93C4(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4._id_EACB)) {
    thread _id_93C5(var_0, var_1, var_2, var_3, var_4);
  }
}

_id_93C5(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_0 notify("light_tank_driver_exit");
    var_5 = scripts\cp_mp\vehicles\vehicle::_id_100CC(var_0, "tur_bradley_mp");
    var_5.owner = undefined;
    var_0 setotherent(undefined);
    var_0 setentityowner(undefined);

    if(!istrue(var_4._id_B695)) {
      var_5 _meth_8399(var_3.origin);
      var_3 _meth_8290(var_5);
      var_3 _meth_8095();

      if(!istrue(var_4._id_B68D)) {
        var_3 _id_93C0(1);
      }

      var_3 scripts\cp_mp\utility\killstreak_utility::_id_8DBA();
    }

    var_5 setotherent(undefined);
    var_5 setentityowner(undefined);
    var_5 setsentryowner(undefined);
  } else if(var_1 == "gunner") {
    var_5 = scripts\cp_mp\vehicles\vehicle::_id_100CC(var_0, "tur_gun_lighttank_mp");

    if(!istrue(var_4._id_B695)) {
      var_3 _meth_80E2();
      var_3 _meth_8292(var_5);
      thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_1016A(var_3, var_4._id_B68D);

      if(!istrue(var_4._id_B68D)) {
        thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_10206(var_3, var_0, "tur_gun_lighttank_mp", var_4, 1);
      }
    }

    var_5.owner = undefined;
    var_5 setotherent(undefined);
    var_5 setentityowner(undefined);
    var_5 setsentryowner(undefined);
    _id_9417(var_3);
  }

  if(!istrue(var_4._id_B695)) {
    if(!isDefined(var_2)) {
      var_0 _id_942F(var_3);
    }

    var_3 scripts\cp_mp\vehicles\vehicle_occupancy::_id_10202();
    var_6 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101D2(var_3, var_2, var_4);

    if(!var_6) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "handleSuicideFromVehicles")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "handleSuicideFromVehicles")]](var_3);
      } else {
        var_3 suicide();
      }
    }
  }

  _id_09CA::_id_10394(var_0, var_1, var_2, var_3);
}

_id_9416(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_2) && var_2 == "gunner") {
    thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_10206(var_3, var_0, "tur_gun_lighttank_mp", var_4, 1);
  }
}

_id_9396(var_0) {
  if(isDefined(var_0._id_72BF)) {
    return;
  }
  var_0 _id_09BF::_id_10A2("ltGunnerMissileRedux", 0.4, 0, ::_id_93D2);
}

_id_9417(var_0) {
  if(!isDefined(var_0._id_72BF)) {
    return;
  }
  var_0._id_72BF = undefined;
  var_0 _id_09BF::_id_C48A("ltGunnerMissileRedux", 0);
}

_id_93D2(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(var_4 != "MOD_PROJECTILE_SPLASH" && var_4 != "MOD_GRENADE_SPLASH") {
    return 1;
  }

  if(!isDefined(var_5)) {
    return 1;
  }

  switch (var_5.basename) {
    case "iw8_la_rpapa7_mp":
    case "iw8_la_kgolf_mp":
    case "bradley_tow_proj_ks_mp":
    case "tur_apc_rus_mp":
    case "iw8_la_gromeo_mp":
    case "tur_bradley_ks_mp":
    case "lighttank_tur_mp":
    case "tur_bradley_mp":
    case "s4_la_walpha2_mp":
    case "iw8_la_juliet_mp":
    case "iw8_la_gromeoks_mp":
    case "bradley_tow_proj_mp":
      return 0;
    default:
      return 1;
  }
}

_id_943E(var_0) {
  self endon("death");
  self.owner endon("disconnect");
  level waittill("game_ended");
  self._id_C143 = 1;
  self.owner scripts\cp_mp\utility\killstreak_utility::_id_C14A(var_0);
}

_id_9415(var_0) {
  if(scripts\cp_mp\vehicles\vehicle_damage::_id_10054(self, var_0)) {
    return 0;
  }

  var_1 = self.origin - var_0.point;
  var_2 = anglestoup(self.angles);
  var_3 = vectordot(var_1, var_2);
  var_4 = var_0.point + var_2 * var_3;
  var_5 = vectornormalize(var_4 - self.origin);
  var_6 = anglesToForward(self.angles);
  var_7 = anglestoright(self.angles);

  if(vectordot(var_5, var_6) < -0.83) {
    var_0._id_89EE = _id_320D(var_0);
  }

  return 1;
}

_id_320D(var_0) {
  if(isDefined(var_0.inflictor) && isDefined(var_0.inflictor.weapon_name) && var_0.inflictor.weapon_name == "gl") {
    return isDefined(var_0._id_9CD6) && var_0._id_9CD6 == "MOD_GRENADE";
  }

  if(isDefined(var_0.objweapon) && isDefined(var_0.objweapon.basename)) {
    switch (var_0.objweapon.basename) {
      case "lighttank_tur_mp":
      case "lighttank_tur_ks_mp":
        return isDefined(var_0._id_9CD6) && (var_0._id_9CD6 == "MOD_PROJECTILE" || var_0._id_9CD6 == "MOD_RIFLE_BULLET");
      case "iw8_la_rpapa7_mp":
      case "tur_apc_rus_mp":
      case "iw8_la_gromeo_mp":
      case "pac_sentry_turret_mp":
      case "iw8_la_gromeoks_mp":
        return isDefined(var_0._id_9CD6) && var_0._id_9CD6 == "MOD_PROJECTILE";
      case "iw8_la_kgolf_mp":
        return isDefined(var_0._id_9CD6) && var_0._id_9CD6 == "MOD_GRENADE";
    }
  }

  return 0;
}

_id_9414(var_0) {
  if(istrue(var_0._id_89EE)) {
    var_0.damage = int(var_0.damage * 1.6);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "updateScrapAssistData")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "updateScrapAssistData")]](var_0.attacker, var_0.damage);
  }

  return 1;
}

_id_93B8(var_0) {
  thread _id_93C6(var_0);
  return 1;
}

_id_939C(var_0) {
  self endon("death");
  self notify("flipped_end");

  if(!istrue(self._id_1F24)) {
    self._id_1F24 = 1;

    if(!scripts\common\utility::iscp()) {
      var_1 = scripts\cp_mp\vehicles\vehicle_damage::_id_1003D(self);
      self.health = int(min(self.health, var_1));
      _id_09CA::_id_10392(self);
      scripts\cp_mp\vehicles\vehicle_damage::_id_10079();
    } else {
      var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018B(self);

      foreach(var_4 in var_2) {
        _id_9428(var_4);
      }

      wait 5.5;
      thread _id_93C6(undefined, undefined, 1);
    }
  }
}

_id_9426() {
  var_0 = physics_createcontents(["physicscontents_itemclip", "physicscontents_water", "physicscontents_glass", "physicscontents_item"]);
  var_1 = self _meth_8150();

  if(!isDefined(var_1)) {
    var_1 = [];
  }

  var_1[var_1.size] = self;
  var_2 = scripts\cp_mp\vehicles\vehicle::_id_100CC(self, "tur_bradley_mp");
  var_3 = var_2 gettagorigin("tag_flash");
  var_4 = var_3 + (-0, -0, -200);
  var_5 = _func_02C1(var_3, var_4, var_0, var_1, 0, "physicsquery_closest", 1);

  if(!isDefined(var_5) || !var_5.size) {
    return;
  }
  var_6 = anglesToForward(var_2 gettagangles("tag_flash") * (0, 1, 0));
  var_7 = var_5[0]["normal"];
  var_8 = _func_025B(var_6, var_7);
  var_7 = _func_025B(var_8, var_6);
  var_9 = _func_0017(var_6, var_8, var_7);
  playFX(scripts\engine\utility::getfx("light_tank_cannon_dust"), var_5[0]["position"], anglesToForward(var_9), anglestoup(var_9));
}

_id_93B6(var_0) {
  var_1 = self._id_75E9;

  if(!isDefined(var_1)) {
    var_2 = scripts\cp_mp\vehicles\vehicle::_id_100CC(self, "tur_bradley_mp");
    var_1 = var_2 _id_078F::_id_D592();

    if(!isDefined(var_1)) {
      return 0;
    }

    self._id_75E9 = var_1;
    _func_035D(var_1, 55);
  }

  self._id_75F1 = istrue(var_0);
  var_3 = scripts\engine\utility::ter_op(istrue(var_0), 0, 0);
  var_4 = scripts\engine\utility::ter_op(istrue(var_0), 2250, 2250);
  var_5 = scripts\engine\utility::ter_op(istrue(var_0), 1, 0);
  var_6 = scripts\engine\utility::ter_op(istrue(var_0), 1, 0);
  _func_0359(var_1, var_3);
  _func_035A(var_1, var_4);
  _func_035C(var_1, var_5);
  _func_035B(var_1, var_6);
}

_id_93BA() {
  _id_078F::_id_D593(self._id_75E9);
  self._id_75E9 = undefined;
  self._id_75F6 = undefined;
  self._id_75F8 = undefined;
}

_id_942E(var_0, var_1) {
  if(!isDefined(self._id_75E9)) {
    return;
  }
  if(isDefined(var_0)) {
    if(_func_0121(var_0) && var_0 == "none") {
      self._id_75F6 = undefined;
    } else {
      self._id_75F6 = var_0;
    }
  }

  if(isDefined(var_1)) {
    if(var_1 == "none") {
      self._id_75F8 = undefined;
    } else {
      self._id_75F8 = var_1;
    }
  }

  _id_9432();
  _id_9433();
  _id_9431();

  foreach(var_3 in level.players) {
    _id_942F(var_3);
  }
}

_id_942F(var_0) {
  if(!isDefined(self._id_75E9)) {
    return;
  }
  var_1 = var_0 scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(var_1) && var_1 == self) {
    _id_078F::_id_D599(self._id_75E9, var_0);
  } else {
    var_2 = undefined;

    if(isDefined(self._id_75F6)) {
      var_2 = self._id_75F6;
    } else {
      var_2 = self.owner;
    }

    var_3 = undefined;

    if(isDefined(self._id_75F8)) {
      var_3 = self._id_75F8;
    } else {
      var_3 = self.team;
    }

    var_4 = _id_93CF();

    if(level.teambased) {
      if(var_3 == "neutral") {
        if(!isDefined(var_2)) {
          if(1) {
            _id_078F::_id_D590(self._id_75E9, var_0);
          } else {
            _id_078F::_id_D599(self._id_75E9, var_0);
          }

          return;
        } else
          var_3 = var_2.team;
      }

      if(_func_010E(var_3, var_0.team)) {
        if(istrue(var_4._id_DCB1)) {
          _id_078F::_id_D590(self._id_75E9, var_0);
        } else {
          _id_078F::_id_D599(self._id_75E9, var_0);
        }
      } else
        _id_078F::_id_D590(self._id_75E9, var_0);
    } else {
      if(!isDefined(var_2)) {
        if(1) {
          _id_078F::_id_D590(self._id_75E9, var_0);
        } else {
          _id_078F::_id_D599(self._id_75E9, var_0);
        }

        return;
      }

      if(var_0 != var_2) {
        if(var_4._id_DCB1) {
          _id_078F::_id_D590(self._id_75E9, var_0);
          return;
        }

        _id_078F::_id_D599(self._id_75E9, var_0);
        return;
        return;
      }

      _id_078F::_id_D590(self._id_75E9, var_0);
    }
  }
}

_id_9430(var_0) {
  var_1 = scripts\cp_mp\vehicles\vehicle_tracking::_id_102BC("light_tank");

  foreach(var_3 in var_1) {
    var_3 _id_942F(var_0);
  }
}

_id_9432() {
  if(level.teambased) {
    return 0;
  }

  var_0 = undefined;

  if(isDefined(self._id_75F6)) {
    var_0 = self._id_75F6;
  } else {
    var_0 = self.owner;
  }

  if(isDefined(var_0)) {
    _func_0365(self._id_75E9, var_0);
  } else {
    _func_0365(self._id_75E9, undefined);
  }

  return 1;
}

_id_9433() {
  if(!level.teambased) {
    return;
  }
  var_0 = _id_93CE();

  if(isDefined(var_0) && var_0 != "neutral") {
    _func_0364(self._id_75E9, var_0);
  } else {
    _func_0364(self._id_75E9, undefined);
  }
}

_id_9431() {
  var_0 = _id_93CF();
  var_1 = scripts\engine\utility::ter_op(istrue(self._id_75F1), 1, 1);

  if(var_1) {
    _func_0356(self._id_75E9, level._id_5897);

    if(1) {
      _func_0358(self._id_75E9, level._id_5896);
    }

    if(var_0._id_DCB1) {
      _func_0357(self._id_75E9, level._id_5896);
    }
  } else {
    var_2 = scripts\engine\utility::ter_op(istrue(self._id_75F1), 1, 1);
    var_3 = scripts\engine\utility::ter_op(istrue(self._id_75F1), 0, var_0._id_DCB1);
    var_4 = scripts\engine\utility::ter_op(istrue(self._id_75F1), "hud_icon_killstreak_bradley_friendly", "hud_icon_killstreak_bradley_friendly");
    var_5 = scripts\engine\utility::ter_op(istrue(self._id_75F1), "hud_icon_killstreak_bradley", "hud_icon_killstreak_bradley");
    var_6 = scripts\engine\utility::ter_op(istrue(self._id_75F1), "hud_icon_killstreak_bradley_enemy", "hud_icon_killstreak_bradley_enemy");
    _func_0356(self._id_75E9, var_4);

    if(var_2) {
      _func_0358(self._id_75E9, var_5);
    }

    if(var_3) {
      _func_0357(self._id_75E9, var_6);
    }
  }
}

_id_93CE() {
  var_0 = undefined;

  if(isDefined(self._id_75F6)) {
    var_0 = self._id_75F6;
  } else {
    var_0 = self.owner;
  }

  var_1 = undefined;

  if(isDefined(self._id_75F8)) {
    var_1 = self._id_75F8;
  } else {
    var_1 = self.team;
  }

  var_2 = var_1;

  if(!isDefined(var_2) || var_1 == "neutral") {
    if(isDefined(var_0)) {
      var_2 = var_0.team;
    }
  }

  return var_2;
}

_id_9424() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::_id_4056("bradley", self);
  return _id_9425(var_0);
}

_id_9425(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level._id_8DEB)) {
    if(!level[[level._id_8DEB]](var_0)) {
      return 0;
    }
  }

  var_1 = makeweapon("ks_gesture_generic_mp");
  var_2 = _id_09B9::_id_EA01(var_0, var_1);

  if(!istrue(var_2)) {
    return 0;
  }

  if(isDefined(level._id_8DC6)) {
    if(!level[[level._id_8DC6]](var_0)) {
      return 0;
    }
  }

  if(scripts\cp_mp\vehicles\vehicle_tracking::_id_102B9("light_tank", self, self.team)) {
    return 0;
  }

  var_3 = spawnStruct();
  _id_93D9(var_3);
  var_3._id_E325 = "airdrop_from_player";
  var_3._id_587C = 1;
  var_3._id_3151 = 1;
  var_3._id_3152 = 1;
  var_3.team = self.team;
  var_3.owner = self;
  var_3.spawntype = "KILLSTREAK";

  if(scripts\cp_mp\utility\player_utility::_id_6C67(self) == 1) {
    var_3._id_FE22 = 1;
  }

  var_4 = spawnStruct();
  var_5 = _id_941A(var_3, var_4, var_0);

  if(!isDefined(var_5)) {
    if(isDefined(var_4._id_58CA)) {
      switch (var_4._id_58CA) {
        case "code":
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
            self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/TOO_MANY_VEHICLES");
          }

          break;
        case "total_limit_exceeded":
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
            self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/TOO_MANY_VEHICLES");
          }

          break;
        case "no_spawns_found":
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
            self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/NOT_ENOUGH_SPACE");
          }

          break;
        case "no_spawns_in_map":
          break;
      }
    }

    return 0;
  }

  if(isDefined(var_0)) {
    var_5.streakinfo = var_0;
    var_6 = scripts\cp_mp\vehicles\vehicle::_id_100CD(var_5);

    foreach(var_8 in var_6) {
      var_8.streakinfo = var_0;
    }

    var_5 thread _id_943E(var_0);
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_10037(var_5);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]]("bradley", self.origin);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_bradley", self);
  }

  return 1;
}

_id_93D3() {
  var_0 = _id_93CF();

  if(isDefined(var_0)) {
    return var_0._id_5065.size > 0;
  }

  return undefined;
}

_id_93CC(var_0, var_1) {
  var_2 = _id_93CF();

  if(var_2._id_5065.size > 0) {
    var_3 = _func_0204(var_2._id_5065, var_0);
    var_4 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("light_tank", "getDropSpawnIgnoreList")) {
      var_4 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "getDropSpawnIgnoreList")]](var_4);
    }

    foreach(var_6 in var_3) {
      if(istrue(var_6._id_8800)) {
        continue;
      }
      var_7 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1026A(var_6.origin, "light_tank", undefined, var_4);

      if(var_7) {
        return var_6;
      }
    }
  }

  return undefined;
}

_id_93CD(var_0, var_1) {
  var_0 = var_0 * (0, 1, 0);

  if(!isDefined(var_1._id_03EA) || var_1._id_03EA & 0) {
    var_2 = var_1.angles * (0, 1, 0);
    var_3 = vectordot(anglesToForward(var_0), anglesToForward(var_2));

    if(var_3 < 0) {
      var_0 = (0, _func_000B(var_2[1] + 180), 0);
    }
  }

  return var_0;
}

_id_93DE() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("light_tank", 1);
  var_0._id_9C7B = 4;
  var_0._id_BD27 = 75;
  var_0._id_6D5D = ::_id_93D1;
  var_0._id_E274 = scripts\cp_mp\utility\script_utility::getsharedfunc("light_tank", "spawnCallback");
  var_0._id_3923 = 130;
  var_0._id_391F = 1000;
  var_0._id_3921 = 130;
}

_id_93D1() {
  var_0 = scripts\engine\utility::getstructarray("lighttank_spawn", "targetname");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1028A(var_0, 1);

    if(var_0.size > 1) {
      var_0 = scripts\engine\utility::array_randomize(var_0);
    }
  }

  return var_0;
}

_id_93CF() {
  return level.vehicle._id_94C4;
}

_id_9439(var_0, var_1, var_2) {
  var_3 = scripts\cp_mp\vehicles\vehicle::_id_100CD(var_0);

  foreach(var_5 in var_3) {
    var_5.team = var_1;
  }

  if(isDefined(var_0._id_75E9)) {
    if(var_2) {
      var_0 _id_9433();
      var_0 _id_9431();

      foreach(var_8 in level.players) {
        var_0 _id_942F(var_8);
      }
    }
  }
}

_id_9436(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0._id_75E9)) {
    if(var_2) {
      var_0 _id_9432();
    }

    if(var_3) {
      var_0 _id_9433();
      var_0 _id_9431();
    }

    if(var_2 || var_3) {
      foreach(var_5 in level.players) {
        var_0 _id_942F(var_5);
      }
    }
  }
}

_id_9419(var_0) {
  if(!_id_939D()) {
    return 0;
  }

  var_1 = _id_93CF();

  if(var_1._id_1F25 > 0) {
    var_2 = max(self.health - var_0.damage, 0);
    return floor(var_2 / self.maxhealth * 100) <= var_1._id_1F25;
  } else
    return 0;
}

_id_939D() {
  if(istrue(self._id_1F24)) {
    return 0;
  }

  var_0 = _id_93CF();

  if(!var_0._id_3146) {
    return 0;
  }

  return 1;
}

_id_939E() {
  if(!_id_93A0()) {
    return 0;
  }

  var_0 = scripts\cp_mp\vehicles\vehicle_tracking::_id_6E3F(self);

  if(isDefined(var_0._id_31F7) && var_0._id_31F7 == 0) {
    return 0;
  }

  var_1 = _id_93CF();

  if(!var_1._id_31F7) {
    return 0;
  }

  if(var_1._id_F230 <= 0) {
    return 0;
  }

  return 1;
}

_id_93A0() {
  if(istrue(self._id_1F24)) {
    return 0;
  }

  return 1;
}

_id_9422(var_0) {
  return _id_93D3();
}

_id_9437(var_0, var_1, var_2, var_3) {
  if(var_2 == "driver") {
    var_0 _id_942B();
    var_0 _id_9434();
  }

  var_0 _id_943B(var_3);
  var_0 _id_9428(var_3);
}

_id_93CA(var_0, var_1) {
  if(var_1) {
    var_0 _id_9423();
  }
}