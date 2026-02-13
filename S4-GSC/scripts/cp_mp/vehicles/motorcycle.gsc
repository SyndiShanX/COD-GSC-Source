/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\motorcycle.gsc
*************************************************/

motorcycle_init() {
  var_0 = scripts\cp_mp\vehicles\vehicle::_id_100C1("motorcycle", 1);
  var_0._id_4841 = ::motorcycle_explode;
  motorcycle_initoccupancy();
  motorcycle_initinteract();
  motorcycle_initomnvars();
  motorcycle_initdamage();
  motorcycle_initcollision();
  motorcycle_initfx();
  motorcycle_initanims();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("motorcycle", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("motorcycle", "init")]]();
  }

  motorcycle_initspawning();
  motorcycle_initlate();
}

motorcycle_initlate() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("motorcycle", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("motorcycle", "initLate")]]();
  }
}

motorcycle_initoccupancy() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A3("motorcycle", 1);
  var_0._id_54D6 = ::motorcycle_enterend;
  var_0._id_5790 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10185;
  var_0._id_577B = ::motorcycle_exitend;
  var_0._id_577C["front"] = 45;
  var_0._id_577C["back"] = 45;
  var_0._id_577C["left"] = 28;
  var_0._id_577C["right"] = 28;
  var_0._id_577C["top"] = 45;
  var_0._id_577C["bottom"] = 0;
  var_0._id_5796 = 40;
  var_0.exitusefallback = getdvarint("#x33a95f4cac30aa2cd", 1);
  var_1 = "left";
  var_0._id_5788[var_1] = (-5, 0, 55);
  var_0._id_5778[var_1] = "left";
  var_1 = "right";
  var_0._id_5788[var_1] = (-5, 0, 55);
  var_0._id_5778[var_1] = "right";
  var_1 = "front";
  var_0._id_5788[var_1] = (29, 0, 55);
  var_0._id_5778[var_1] = "front";
  var_1 = "back";
  var_0._id_5788[var_1] = (-35, 0, 45);
  var_0._id_5778[var_1] = "back";
  var_2 = ["driver", "rear"];
  var_3 = "driver";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("motorcycle", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = ["left", "right", "back", "front"];
  var_4._id_C725 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10194();
  var_4._id_18F2 = "tag_seat_0";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_E354 = 10;
  var_4._id_AAC6 = "ping_vehicle_driver";
  var_3 = "rear";
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("motorcycle", var_3, 1);
  var_4._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_3, var_2);
  var_4._id_5780 = ["back", "right", "left", "front"];
  var_4._id_103D2["top"] = 180;
  var_4._id_103D2["bottom"] = 180;
  var_4._id_103D2["left"] = 120;
  var_4._id_103D2["right"] = 120;
  var_4._id_C725 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10191();
  var_4._id_18F2 = "tag_seat_1";
  var_4._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_4._id_18F2);
  var_4._id_AAC6 = "ping_vehicle_rider";
  var_4._id_DC8E = 1;
}

motorcycle_initinteract() {
  var_0 = _id_09E1::_id_100EF("motorcycle", 1);
  var_0._id_CFC0["single"] = ["driver", "rear"];
}

motorcycle_initomnvars() {
  var_0 = _id_09CA::_id_10373("motorcycle", 1);
  var_0._id_7C8C = 4;
  var_0._id_CFC3["driver"] = 0;
  var_0._id_CFC3["rear"] = 1;
}

motorcycle_initdamage() {
  scripts\cp_mp\vehicles\vehicle_damage::_id_10069("motorcycle", 300);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::_id_10041("motorcycle");
  var_0.class = "super_light";
  scripts\cp_mp\vehicles\vehicle_damage::_id_1002C("motorcycle");
  scripts\cp_mp\vehicles\vehicle_damage::_id_10073("motorcycle", 1);

  if(level.gametype == "br") {
    scripts\cp_mp\vehicles\vehicle_damage::_id_10074("motorcycle", 6, "semtex_aalpha12_mp");
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_1006E("motorcycle", ::motorcycle_deathcallback);
}

motorcycle_initcollision() {}

motorcycle_initfx() {
  level._effect["motorcycle_explode"] = loadfx("vfx/s4/vehicle/scriptables/veh_explosion_ar_motorcycle_romeo75");
}

#using_animtree("mp_vehicles_always_loaded");

motorcycle_initanims() {
  level._id_CC31["motorcycle"]["pickup_right"] = % sdr_mp_veh_motorcycle_pickup_right;
  level._id_CC31["motorcycle"]["pickup_left"] = % sdr_mp_veh_motorcycle_pickup_left;
}

motorcycle_create(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_0.modelname = "motorcycle_romeo75_00_mp";
  var_0._id_0481 = "motorcycle";
  var_0._id_04DE = "motorcycle_physics_mp";
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnvehicle(var_0, var_1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  if(getdvarint("#x33a95f4cac30aa2cd", 1)) {
    var_2.filter_damage_to_player = 1;
  }

  scripts\cp_mp\vehicles\vehicle::vehicle_create(var_2, "motorcycle", var_0);
  var_2.objweapon = makeweapon("motorcycle_mp");
  _id_09DE::_id_10018(var_2);
  scripts\cp_mp\vehicles\vehicle::_id_10028(var_2, var_0);
  var_2 thread motorcycle_watchstability();
  var_2 thread motorcycle_watch_damage_states();
  thread scripts\cp_mp\vehicles\vehicle::_id_102E2(var_2, undefined, undefined, "flipped_end");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("motorcycle", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("motorcycle", "create")]](var_2);
  }

  return var_2;
}

motorcycle_watchstability() {
  self endon("death");
  level endon("game_ended");

  if(!self _meth_8679("stability")) {
    return;
  }
  for(;;) {
    self waittill("collision", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
    var_8 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018B(self);

    if(var_8.size == 0) {
      self setscriptablepartstate("stability", "unstable", 1);
    }
  }
}

motorcycle_flippedendcallback(var_0, var_1) {
  thread motorcycle_explode();
}

motorcycle_explode(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "motorcycle_mp";
    var_0._id_9CD6 = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_10060(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_101C5(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10030(undefined, undefined, 1);
  thread motorcycle_deletenextframe();

  if(!istrue(level._id_EBC3)) {
    var_2 = self gettagorigin("tag_origin");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker) && isent(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "MOD_EXPLOSIVE", "motorcycle_mp");
    playFX(scripts\engine\utility::getfx("motorcycle_explode"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    thread motorcycle_explosion_sound();
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("grenade_rumble", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
  }
}

motorcycle_deletenextframe() {
  scripts\cp_mp\vehicles\vehicle::_id_1008F(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("motorcycle", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("motorcycle", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::_id_10090(self);
}

motorcycle_deathcallback(var_0) {
  thread motorcycle_explode(var_0);
  return 1;
}

motorcycle_clearpickupanim(var_0) {
  self endon("death");
  level endon("game_ended");

  if(isDefined(var_0) && var_0 > 0.0) {
    wait(var_0);
  }

  self _meth_8878();
}

motorcycle_enterend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4._id_EACB)) {
    motorcycle_enterendinternal(var_0, var_1, var_2, var_3, var_4);
  }
}

motorcycle_enterendinternal(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 _meth_8094(var_0);

    if(getdvarint("bg_vehEnablePickupAnims", 0) == 1) {
      if(!isDefined(var_2)) {
        var_5 = undefined;

        if(var_0.angles[2] < -20.0) {
          var_5 = level._id_CC31["motorcycle"]["pickup_left"];
        } else if(var_0.angles[2] > 20.0) {
          var_5 = level._id_CC31["motorcycle"]["pickup_right"];
        }

        if(isDefined(var_5)) {
          var_0 _meth_8620(var_5);
          var_0 thread motorcycle_clearpickupanim(_func_0079(var_5));
        }
      }
    }
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015E(var_0, var_1, var_2);
  _id_09CA::_id_10393(var_0, var_2, var_1, var_3);
  var_0 notify("vehicle_enter_exit");
  var_0 thread scripts\mp\teams::outlinefriendlyvehicle_apply(var_3, "enter");

  if(!isDefined(var_2)) {
    var_0 thread scripts\mp\teams::outlinefriendlyvehicle_occupantupdate(var_3, "enter");
  }
}

motorcycle_exitend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4._id_EACB)) {
    motorcycle_exitendinternal(var_0, var_1, var_2, var_3, var_4);
  }
}

motorcycle_exitendinternal(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_0 setotherent(undefined);
    var_0 setentityowner(undefined);

    if(!istrue(var_4._id_B695)) {
      var_3 _meth_8095();
    }
  }

  if(!istrue(var_4._id_B695)) {
    var_3 scripts\cp_mp\vehicles\vehicle_occupancy::_id_10202();
    var_5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101D2(var_3, var_2, var_4);

    if(!var_5) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_occupancy", "handleSuicideFromVehicles")) {
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_occupancy", "handleSuicideFromVehicles")]](var_3);
      } else {
        var_3 suicide();
      }
    }
  }

  _id_09CA::_id_10394(var_0, var_1, var_2, var_3);
  var_0 notify("vehicle_enter_exit");
  var_0 thread scripts\mp\teams::outlinefriendlyvehicle_apply(var_3, "exit");

  if(!isDefined(var_2)) {
    var_0 thread scripts\mp\teams::outlinefriendlyvehicle_occupantupdate(var_3, "exit");
  }
}

motorcycle_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("motorcycle", 1);
  var_0._id_9C7B = 4;
  var_0._id_BD27 = 75;
  var_0._id_6D5D = ::motorcycle_getspawnstructscallback;
  var_0._id_E274 = scripts\cp_mp\utility\script_utility::getsharedfunc("motorcycle", "spawnCallback");
  var_0._id_3923 = 55;
  var_0._id_391F = 45;
  var_0._id_3921 = 55;
}

motorcycle_getspawnstructscallback() {
  var_0 = scripts\engine\utility::getstructarray("motorcycle_spawn", "targetname");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1028A(var_0, 1);

    if(var_0.size > 1) {
      var_0 = scripts\engine\utility::array_randomize(var_0);
    }
  }

  return var_0;
}

motorcycle_watch_damage_states() {
  self endon("death");

  for(;;) {
    var_0 = scripts\cp_mp\vehicles\vehicle_damage::_id_10046();

    switch (var_0) {
      case "pristine":
        break;
      case "light":
        thread light_damage_sound();
        break;
      case "medium":
        thread med_damage_sound();
        break;
      case "heavy":
        thread heavy_damage_sound();
        break;
    }

    self waittill("damage_state_change");
  }
}

light_damage_sound() {
  self playSound("motorcycle_damaged_grey_smoke");
  self playLoopSound("motorcycle_damaged_grey_smoke_lp");
}

med_damage_sound() {
  self playSound("motorcycle_damaged_black_smoke");
  self playLoopSound("motorcycle_damaged_black_smoke_lp");
}

heavy_damage_sound() {
  self playSound("motorcycle_damaged_flame_burst");
  self playLoopSound("motorcycle_damaged_fire_lp");
}

motorcycle_explosion_sound() {
  var_0 = self.origin + (0, 0, 75);
  _id_0847::_id_DF08("motorcycle_damaged_explode", var_0);
}