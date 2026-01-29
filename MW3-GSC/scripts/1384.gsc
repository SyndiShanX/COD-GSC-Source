/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1384.gsc
**************************************/

_id_4345() {
  level._effect["lighthaze_snow_headlights"] = loadfx("misc/lighthaze_snow_headlights");
  level._effect["car_taillight_uaz_l"] = loadfx("misc/car_taillight_uaz_l");
  common_scripts\utility::flag_init("truck_guys_alerted");
  common_scripts\utility::flag_init("jeep_blown_up");
  common_scripts\utility::flag_init("jeep_stopped");
}

_id_4346() {
  self endon("death");
  self endon("enemy");

  for(;;) {
    if(_id_4347()) {
      self.fovcosine = 0.01;
      return;
    }

    wait 0.5;
  }
}

_id_4347() {
  foreach(var_1 in level.players) {
    if(distancesquared(self.origin, var_1.origin) < squared(self.footstepdetectdistsprint)) {
      return 1;
    }
  }

  return 0;
}

_id_4348() {
  thread _id_4355();
  thread _id_4358();
  self waittill("death");
  common_scripts\utility::flag_set("jeep_blown_up");
}

_id_4349() {
  self endon("death");
  level endon("_stealth_spotted");
  self endon("_stealth_attack");
  maps\_utility::_id_1402("jumped_out");
  thread _id_434D();
  var_0 = [];
  var_0["saw"] = ::_id_4350;
  var_0["found"] = ::_id_4350;
  var_1 = [];
  var_1["warning1"] = ::_id_4350;
  var_1["warning2"] = ::_id_4350;
  var_1["attack"] = ::_id_4352;
  var_2 = [];
  var_2["explode"] = ::_id_4351;
  var_2["heard_scream"] = ::_id_4351;
  var_2["doFlashBanged"] = ::_id_4351;
  maps\_stealth_shared_utilities::_id_41CF("animation", "wrapper", ::_id_434F);
  maps\_stealth_utility::_id_4304(var_1);
  maps\_stealth_utility::_id_4309(var_0);

  foreach(var_5, var_4 in var_2) {}
  _id_0563::_id_42C1(var_5, var_4);

  maps\_utility::_id_13DC("_stealth_behavior_reaction_anim");
}

_id_434A(var_0) {
  self endon("_stealth_enemy_alert_level_change");
  level endon("_stealth_spotted");
  self endon("_stealth_attack");
  self endon("death");
  self endon("pain_death");
  thread _id_434B();
  self._id_117F = 0;
  self._id_1199 = 0;
  var_1 = distance(var_0.origin, self.origin);
  self setgoalnode(var_0);
  self.goalradius = var_1 * 0.5;
  wait 0.05;
  maps\_utility::_id_140B("_stealth_patrol_cqb");
  self waittill("goal");

  if(!common_scripts\utility::flag("_stealth_spotted") && (!isDefined(self.enemy) || !self cansee(self.enemy))) {
    _id_434C();
    maps\_stealth_shared_utilities::_id_41F2(var_0);
  }
}

_id_434B() {
  self endon("death");
  self endon("_stealth_attack");
  level endon("_stealth_spotted");
  wait 2;
  self waittill("_stealth_bad_event_listener");
  maps\_stealth_shared_utilities::_id_41EB();
  maps\_utility::_id_13DC("not_first_attack");
}

_id_434C() {
  maps\_utility::_id_109E();
  maps\_utility::_id_140B("patrol_cold_gunup_search", 1);
  self._id_117F = 1;
  self._id_1199 = 1;
}

_id_434D() {
  self endon("death");
  self endon("pain_death");

  for(;;) {
    self waittill("jumpedout");
    maps\_stealth_shared_utilities::_id_41F1(self.origin);
    self._id_434E = self.origin;
    maps\_utility::_id_13DC("jumped_out");
    self waittill("enteredvehicle");
    wait 0.15;
    maps\_utility::_id_13DE("jumped_out");
    maps\_utility::_id_13DC("_stealth_behavior_reaction_anim");
  }
}

_id_434F(var_0) {
  self endon("death");
  self endon("pain_death");
  common_scripts\utility::flag_set("truck_guys_alerted");
  maps\_utility::_id_1654("jumped_out");
  maps\_stealth_shared_utilities::_id_4200(var_0);
}

_id_4350(var_0) {
  self endon("death");
  self endon("pain_death");
  level endon("_stealth_spotted");
  self endon("_stealth_attack");
  common_scripts\utility::flag_set("truck_guys_alerted");
  maps\_utility::_id_1654("jumped_out");

  if(!common_scripts\utility::flag("truck_guys_alerted")) {
    return;
  }
  if(common_scripts\utility::flag_exist("truck_guys_not_going_back") && common_scripts\utility::flag("truck_guys_not_going_back")) {
    return;
  }
  if(!common_scripts\utility::flag("_stealth_spotted") && !maps\_utility::_id_1008("_stealth_attack")) {
    var_1 = maps\_utility::_id_2608(self.origin);
    var_2 = maps\_stealth_shared_utilities::_id_41F3(var_1.origin, 1500, 128);

    if(isDefined(var_2)) {
      thread _id_434A(var_2);
    }
  }

  var_3 = maps\_stealth_shared_utilities::_id_41DB("_stealth_spotted");

  if(common_scripts\utility::flag(var_3)) {
    common_scripts\utility::flag_waitopen(var_3);
  } else {
    self waittill("normal");
  }
}

_id_4351(var_0) {
  self endon("death");
  self endon("pain_death");
  level endon("_stealth_spotted");
  self endon("_stealth_attack");
  common_scripts\utility::flag_set("truck_guys_alerted");
  maps\_utility::_id_1654("jumped_out");

  if(!common_scripts\utility::flag("truck_guys_alerted")) {
    return;
  }
  if(common_scripts\utility::flag_exist("truck_guys_not_going_back") && common_scripts\utility::flag("truck_guys_not_going_back")) {
    return;
  }
  if(!common_scripts\utility::flag("_stealth_spotted") && !maps\_utility::_id_1008("_stealth_attack")) {
    var_1 = self._id_0B6E._id_41ED._id_0EFE._id_4276[var_0];
    var_2 = maps\_stealth_shared_utilities::_id_41F3(var_1, 300, 40);
    thread maps\_stealth_shared_utilities::_id_41F4();

    if(isDefined(var_2)) {
      thread _id_434A(var_2);
    }
  }

  var_3 = maps\_stealth_shared_utilities::_id_41DB("_stealth_spotted");

  if(common_scripts\utility::flag(var_3)) {
    common_scripts\utility::flag_waitopen(var_3);
  } else {
    self waittill("normal");
  }
}

_id_4352(var_0) {
  self endon("death");
  self endon("pain_death");
  common_scripts\utility::flag_set("truck_guys_alerted");
  maps\_utility::_id_1654("jumped_out");
}

_id_4353() {
  self._id_2069 = "patrol_cold_gunup";
  self._id_206A = "patrol_gunup_twitch_weights";
}

_id_4354() {
  var_0 = distance(self.origin, maps\_utility::_id_2608(self.origin).origin);
  var_1 = (var_0 - 200) / 1000;
  var_1 = clamp(var_1, 0, 0.5);
  wait(var_1);
}

_id_4355() {
  self endon("death");
  thread _id_435A();
  thread _id_435E();
  thread _id_4356();
  common_scripts\utility::flag_wait("truck_guys_alerted");
  var_0 = maps\_utility::_id_2641("truck_guys", "script_noteworthy");

  if(var_0.size == 0) {
    self vehicle_setspeed(0, 15);
    return;
  }

  var_1 = common_scripts\utility::random(var_0);
  var_1 maps\_stealth_shared_utilities::_id_41F4();
  self waittill("safe_to_unload");
  self vehicle_setspeed(0, 15);
  wait 1;
  maps\_vehicle::_id_2514();
  common_scripts\utility::flag_set("jeep_stopped");
}

_id_4356() {
  self endon("truck_guys_alerted");

  for(;;) {
    common_scripts\utility::flag_wait("_stealth_spotted");

    foreach(var_1 in level.players) {}
    thread _id_4357(var_1);

    self waittill("player_in_range");

    if(!common_scripts\utility::flag("_stealth_spotted")) {
      continue;
    } else {
      break;
    }
  }

  common_scripts\utility::flag_set("truck_guys_alerted");
}

_id_4357(var_0) {
  self endon("player_in_range");
  var_0 maps\_utility::_id_2793(self, 800);
  self notify("player_in_range");
}

_id_4358() {
  playFXOnTag(level._effect["lighthaze_snow_headlights"], self, "TAG_LIGHT_RIGHT_FRONT");
  playFXOnTag(level._effect["lighthaze_snow_headlights"], self, "TAG_LIGHT_LEFT_FRONT");
  playFXOnTag(level._effect["car_taillight_uaz_l"], self, "TAG_LIGHT_LEFT_TAIL");
  playFXOnTag(level._effect["car_taillight_uaz_l"], self, "TAG_LIGHT_RIGHT_TAIL");
  self waittill("death");

  if(isDefined(self)) {
    _id_4359();
  }
}

_id_4359() {
  stopFXOnTag(level._effect["lighthaze_snow_headlights"], self, "TAG_LIGHT_RIGHT_FRONT");
  stopFXOnTag(level._effect["lighthaze_snow_headlights"], self, "TAG_LIGHT_LEFT_FRONT");
  stopFXOnTag(level._effect["car_taillight_uaz_l"], self, "TAG_LIGHT_LEFT_TAIL");
  stopFXOnTag(level._effect["car_taillight_uaz_l"], self, "TAG_LIGHT_RIGHT_TAIL");
}

_id_435A() {
  level endon("special_op_terminated");
  level endon("jeep_stopped");
  level endon("jeep_blown_up");
  var_0 = 1;

  for(;;) {
    _id_435C();
    var_1 = maps\_utility::within_fov(self.origin, self.angles, self._id_435B.origin, cos(45));

    if(var_1) {
      if(!var_0 && common_scripts\utility::cointoss()) {
        maps\_utility::_id_11F4("cliff_pri_truckcomingback");
      } else {
        maps\_utility::_id_11F4("cliff_pri_truckiscoming");

      }
      var_0 = 0;
      wait 10;
    }

    wait 1;
  }
}

_id_435C() {
  self._id_435B = undefined;

  foreach(var_1 in level.players) {}
  var_1 thread _id_435D(self);

  level waittill("player_in_truck_range");
}

_id_435D(var_0) {
  level endon("player_in_truck_range");
  var_0 maps\_utility::_id_2793(self, 1200);
  var_0._id_435B = self;
  level notify("player_in_truck_range");
}

_id_435E() {
  level endon("special_op_terminated");
  self waittill("unloading");

  if(common_scripts\utility::flag("_stealth_spotted")) {
    return;
  }
  maps\_utility::_id_11F4("cliff_pri_headsup");

  if(common_scripts\utility::flag("_stealth_spotted")) {
    return;
  }
  maps\_utility::_id_11F4("cliff_pri_lookingaround");
}