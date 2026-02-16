/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\open_jeep.gsc
*************************************************/

open_jeep_init() {
  var_0 = scripts\cp_mp\vehicles\vehicle::_id_100C1("open_jeep", 1);
  var_0._id_4841 = ::open_jeep_explode;
  open_jeep_initoccupancy();
  open_jeep_initinteract();
  open_jeep_initomnvars();
  open_jeep_initdamage();
  open_jeep_initcollision();
  open_jeep_initfx();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("open_jeep", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("open_jeep", "init")]]();
  }

  open_jeep_initspawning();
  open_jeep_initlate();
}

open_jeep_initlate() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("open_jeep", "initLate")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("open_jeep", "initLate")]]();
  }
}

open_jeep_initoccupancy() {
  var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A3("open_jeep", 1);
  var_0._id_54D6 = ::open_jeep_enterend;
  var_0._id_5790 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10185;
  var_0._id_577B = ::open_jeep_exitend;
  var_0._id_C725 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10191();
  var_0._id_577C["front"] = 85;
  var_0._id_577C["back"] = 82;
  var_0._id_577C["left"] = 34;
  var_0._id_577C["right"] = 34;
  var_0._id_577C["top"] = 82;
  var_0._id_577C["bottom"] = 0;
  var_0._id_5788["front"] = (58, 0, 55);
  var_0._id_5778["front"] = "front";
  var_0._id_5788["back"] = (-65, 0, 65);
  var_0._id_5778["back"] = "back";
  var_1 = [];
  var_1[var_1.size] = "driver";
  var_1[var_1.size] = "fr_passenger";
  var_1[var_1.size] = "br_passenger";
  var_1[var_1.size] = "bl_passenger";
  var_2 = "driver";
  var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("open_jeep", var_2, 1);
  var_3._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_2, var_1);
  var_3._id_C725 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_10194();
  var_3._id_18F2 = "tag_seat_0";
  var_3._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_3._id_18F2);
  var_3._id_5780 = [var_2, "bl_passenger", "back", "fr_passenger", "front"];
  var_0._id_5788[var_2] = (10, 13, 48);
  var_0._id_5778[var_2] = "left";
  var_3._id_E354 = 10;
  var_3._id_AAC6 = "ping_vehicle_driver";
  var_2 = "fr_passenger";
  var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("open_jeep", var_2, 1);
  var_3._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_2, var_1);
  var_3._id_5780 = [var_2, "br_passenger", "back", "driver", "front"];
  var_0._id_5788[var_2] = (10, -13, 48);
  var_0._id_5778[var_2] = "right";
  var_3._id_103D2["top"] = 24;
  var_3._id_103D2["bottom"] = 42;
  var_3._id_103D2["left"] = 101;
  var_3._id_103D2["right"] = 122;
  var_3._id_18F2 = "tag_seat_1";
  var_3._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_3._id_18F2);
  var_3._id_7917 = 1;
  var_3._id_AAC6 = "ping_vehicle_rider";
  var_2 = "bl_passenger";
  var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("open_jeep", var_2, 1);
  var_3._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_2, var_1);
  var_3._id_5780 = [var_2, "driver", "back", "br_passenger", "front"];
  var_0._id_5788[var_2] = (-25, 13, 55);
  var_0._id_5778[var_2] = "left";
  var_3._id_103D2["top"] = 24;
  var_3._id_103D2["bottom"] = 42;
  var_3._id_103D2["left"] = 122;
  var_3._id_103D2["right"] = 122;
  var_3._id_18F2 = "tag_seat_2";
  var_3._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_3._id_18F2);
  var_3._id_7917 = 1;
  var_3._id_AAC6 = "ping_vehicle_rider";
  var_2 = "br_passenger";
  var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_101A2("open_jeep", var_2, 1);
  var_3._id_CFC5 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1018A(var_2, var_1);
  var_3._id_5780 = [var_2, "fr_passenger", "back", "bl_passenger", "front"];
  var_0._id_5788[var_2] = (-25, -13, 55);
  var_0._id_5778[var_2] = "right";
  var_3._id_103D2["top"] = 24;
  var_3._id_103D2["bottom"] = 42;
  var_3._id_103D2["left"] = 122;
  var_3._id_103D2["right"] = 122;
  var_3._id_18F2 = "tag_seat_3";
  var_3._id_5795 = scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015F(var_3._id_18F2);
  var_3._id_7917 = 1;
  var_3._id_AAC6 = "ping_vehicle_rider";
}

open_jeep_initinteract() {
  var_0 = _id_09E1::_id_100EF("open_jeep", 1);
  var_0._id_CFC0["single"] = ["driver", "fr_passenger", "bl_passenger", "br_passenger"];
}

open_jeep_initomnvars() {
  var_0 = _id_09CA::_id_10373("open_jeep", 1);
  var_0._id_7C8C = 10;
  var_0._id_CFC3["driver"] = 0;
  var_0._id_CFC3["fr_passenger"] = 1;
  var_0._id_CFC3["bl_passenger"] = 2;
  var_0._id_CFC3["br_passenger"] = 3;
}

open_jeep_initdamage() {
  scripts\cp_mp\vehicles\vehicle_damage::_id_10069("open_jeep", 1200);
  var_0 = scripts\cp_mp\vehicles\vehicle_damage::_id_10041("open_jeep");
  var_0.class = "light";
  scripts\cp_mp\vehicles\vehicle_damage::_id_1002C("open_jeep");
  scripts\cp_mp\vehicles\vehicle_damage::_id_10073("open_jeep", 4);

  if(level.gametype == "br") {
    scripts\cp_mp\vehicles\vehicle_damage::_id_10074("open_jeep", 8, "semtex_aalpha12_mp");
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_1006E("open_jeep", ::open_jeep_deathcallback);
}

open_jeep_initcollision() {}

open_jeep_initfx() {
  level._effect["open_jeep_explode"] = loadfx("vfx/s4/vehicle/scriptables/veh_explosion_ar_jeep_jo");
}

open_jeep_create(var_0, var_1) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_0.modelname = "veh_s4_mil_lnd_m151";
  var_0._id_0481 = "open_jeep";
  var_0._id_04DE = "open_jeep_physics_mp";
  var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnvehicle(var_0, var_1);

  if(!isDefined(var_2)) {
    return undefined;
  }

  scripts\cp_mp\vehicles\vehicle::vehicle_create(var_2, "open_jeep", var_0);
  var_2.objweapon = makeweapon("open_jeep_mp");
  _id_09DE::_id_10018(var_2);
  scripts\cp_mp\vehicles\vehicle::_id_10028(var_2, var_0);
  thread open_jeep_watchflipped(var_2, undefined, scripts\cp_mp\vehicles\vehicle::_id_100AA);
  var_2 thread open_jeep_watch_damage_states();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("open_jeep", "create")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("open_jeep", "create")]](var_2);
  }

  return var_2;
}

open_jeep_watchflipped(var_0, var_1, var_2, var_3) {
  var_0 endon("death");
  level endon("game_ended");

  if(isDefined(var_3)) {
    var_0 endon(var_3);
  }

  var_4 = 0;
  var_5 = undefined;
  var_6 = undefined;

  for(;;) {
    var_7 = 0;
    var_8 = anglestoup(var_0.angles)[2];

    if(var_8 <= 0.0872) {
      if(!isDefined(var_5)) {
        var_5 = gettime() + 3000;
      }

      if(gettime() > var_5) {
        var_7 = 1;
        var_5 = undefined;
      }
    } else {
      if(var_4) {
        _id_09E1::_id_100E5(var_0, 1);
        var_4 = 0;
      }

      var_7 = 0;
      var_5 = undefined;
    }

    if(var_7) {
      if(isDefined(var_1)) {
        thread[[var_1]](var_0);
      }

      if(!var_4) {
        _id_09E1::_id_100E5(var_0, 0);
        var_4 = 1;
      }

      scripts\cp_mp\vehicles\vehicle_occupancy::_id_1017D(var_0);
      var_9 = 0;
      var_6 = gettime() + 3000;

      for(;;) {
        if(gettime() >= var_6) {
          var_9 = 1;
          break;
        }

        waitframe();
      }

      var_6 = undefined;

      if(isDefined(var_2)) {
        thread[[var_2]](var_0, var_9);
      }
    }

    waitframe();
  }
}

open_jeep_explode(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.inflictor = self;
    var_0.objweapon = "open_jeep_mp";
    var_0._id_9CD6 = "MOD_EXPLOSIVE";
  }

  scripts\cp_mp\vehicles\vehicle_damage::_id_10060(var_0);
  scripts\cp_mp\vehicles\vehicle_occupancy::_id_101C5(self, var_0);
  scripts\cp_mp\vehicles\vehicle_damage::_id_10030(undefined, undefined, 1);
  thread open_jeep_deletenextframe();

  if(!istrue(level._id_EBC3)) {
    var_2 = self gettagorigin("tag_origin");
    var_3 = scripts\engine\utility::ter_op(isDefined(var_0.attacker), var_0.attacker, self);
    self radiusdamage(var_2, 256, 140, 70, var_3, "MOD_EXPLOSIVE", "open_jeep_mp");
    playFX(scripts\engine\utility::getfx("open_jeep_explode"), var_2, anglesToForward(self.angles), anglestoup(self.angles));
    thread jeep_explosion_sound();
    earthquake(0.4, 800, var_2, 0.7);
    playrumbleonposition("grenade_rumble", var_2);
    physicsexplosionsphere(var_2, 500, 200, 1);
  }
}

open_jeep_deletenextframe() {
  scripts\cp_mp\vehicles\vehicle::_id_1008F(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("open_jeep", "delete")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("open_jeep", "delete")]](self);
  }

  waitframe();
  scripts\cp_mp\vehicles\vehicle::_id_10090(self);
}

open_jeep_deathcallback(var_0) {
  thread open_jeep_explode(var_0);
  return 1;
}

open_jeep_enterend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4._id_EACB)) {
    open_jeep_enterendinternal(var_0, var_1, var_2, var_3, var_4);
  }
}

open_jeep_enterendinternal(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_0 setotherent(var_3);
    var_0 setentityowner(var_3);
    var_3 _meth_8094(var_0);
  }

  var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_1015E(var_0, var_1, var_2);
  _id_09CA::_id_10393(var_0, var_2, var_1, var_3);
  var_0 notify("vehicle_enter_exit");
  var_0 thread scripts\mp\teams::outlinefriendlyvehicle_apply(var_3, "enter");

  if(!isDefined(var_2)) {
    var_0 thread scripts\mp\teams::outlinefriendlyvehicle_occupantupdate(var_3, "enter");
  }
}

open_jeep_exitend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4._id_EACB)) {
    open_jeep_exitendinternal(var_0, var_1, var_2, var_3, var_4);
  }
}

open_jeep_exitendinternal(var_0, var_1, var_2, var_3, var_4) {
  if(var_1 == "driver") {
    var_0 setotherent(undefined);
    var_0 setentityowner(undefined);
  }

  if(!istrue(var_4._id_B695)) {
    if(var_1 == "driver") {
      var_3 _meth_8095();
    }

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

open_jeep_initspawning() {
  var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle("open_jeep", 1);
  var_0._id_9C7B = 2;
  var_0._id_BD27 = 75;
  var_0._id_6D5D = ::open_jeep_getspawnstructscallback;
  var_0._id_E274 = scripts\cp_mp\utility\script_utility::getsharedfunc("open_jeep", "spawnCallback");
  var_0._id_3923 = 120;
  var_0._id_391F = 82;
  var_0._id_3921 = 120;
}

open_jeep_getspawnstructscallback() {
  var_0 = scripts\engine\utility::getStructArray("openjeep_spawn", "targetname");

  if(var_0.size > 0) {
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1028A(var_0, 1);

    if(var_0.size > 1) {
      var_0 = scripts\engine\utility::array_randomize(var_0);
    }
  }

  return var_0;
}

open_jeep_watch_damage_states() {
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
  self playSound("jeep_damaged_grey_smoke");
  self playLoopSound("jeep_damaged_grey_smoke_lp");
}

med_damage_sound() {
  self playSound("jeep_damaged_black_smoke");
  self playLoopSound("jeep_damaged_black_smoke_lp");
}

heavy_damage_sound() {
  self playSound("jeep_damaged_flame_burst");
  self playLoopSound("jeep_damaged_fire_lp");
}

jeep_explosion_sound() {
  var_0 = self.origin + (0, 0, 40);
  _id_0847::_id_DF08("jeep_damaged_explode", var_0);
}