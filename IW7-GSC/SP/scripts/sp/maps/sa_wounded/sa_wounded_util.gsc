/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\sa_wounded\sa_wounded_util.gsc
**********************************************************/

_id_556B() {
  level.player disableweapons();
  level.player freezecontrols(1);
  level.player setstance("stand");
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player allowsprint(0);
  level.player _meth_80D1();
}

_id_6227() {
  level.player enableweapons();
  level.player allowsprint(1);
  level.player freezecontrols(0);
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player _meth_80A1();
}

_id_1D07() {
  self._id_1FBB = "jackal_ally";
  scripts\sp\vehicle::_id_8441();
}

_id_1D04() {
  self endon("death");

  while(!isDefined(level._id_9ADD))
    scripts\engine\utility::waitframe();

  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;

  if(self == level._id_A06B) {
    var_0 = (6200, 2600, -2450);
    var_5 = (6200, 2600, 1900);
    var_1 = 600;
    var_2 = 0.1;
    var_3 = 1800;
    var_4 = 0.2;
    var_6 = 1;
    var_7 = 1.0;
  } else if(self == level._id_A06C) {
    var_0 = (5800, -2100, -1556);
    var_5 = (5800, -2100, 900);
    var_1 = 600;
    var_2 = 0.1;
    var_3 = 1800;
    var_4 = 0.2;
    var_6 = 2;
    var_7 = 1.5;
  } else if(self == level._id_A06D) {
    var_0 = (5600, -1024, -1500);
    var_5 = (5600, -1024, 1512);
    var_1 = 600;
    var_2 = 0.1;
    var_3 = 1800;
    var_4 = 0.2;
    var_6 = 3.8;
    var_7 = 3.0;
  }

  _id_0BDC::_id_19AB(600);
  thread _id_0BDC::_id_1994(level._id_D127, var_0, var_1, var_2, var_3, var_4);
  scripts\engine\utility::flag_wait("allies_rise");
  _id_0BDC::_id_199D(var_7, var_5, var_1, var_2, var_3, var_4);
  level._id_9ADD scripts\sp\utility::_id_65E3("hellas_jackals_spawned");
  var_8 = scripts\engine\utility::getStruct("jackal_intro_pos_ally" + self.script_parameters, "targetname");
  wait(var_6);
  _id_0BDC::_id_19B7();
  scripts\engine\utility::waitframe();
  _id_0BDC::_id_A1EC(var_8.origin, 0, 2000, var_8.angles);
  self waittill("near_goal");
  _id_0BDC::_id_19B3("patrol", "axis_patrol");
  _id_0BDC::_id_19B3("escape", "axis_dogfight");
  _id_0BDC::_id_1990(1);
}

getplayerkills() {
  self endon("death");
  self endon("deleted");

  while(isDefined(self)) {
    self.spaceship_vel = level._id_D127.spaceship_vel;
    scripts\engine\utility::waitframe();
  }
}

_id_1CFC() {
  _id_0BDC::_id_19B0("fly");
  self _meth_851C(0);
  _id_0BDC::_id_19A2();
  _id_0BDC::_id_19AB(randomfloatrange(150.0, 200.0));
  var_0 = scripts\engine\utility::getStruct("jackal_pos_ally" + self.script_parameters, "targetname");
  _id_0BDC::_id_19B2("face angle", var_0.angles);
  thread _id_0BDC::_id_A1EC(var_0.origin, 1, 384, var_0.angles);
  wait 9.0;
  var_1 = "allies_jackal_carrier_path" + self.script_parameters;
  thread _id_0BDC::_id_A1EF(scripts\sp\utility::_id_7C9A(var_1), undefined, 64.0);
  thread _id_19B6(0.75, 0.5, 0.25, 1.5, 1000, 2000);
  var_2 = scripts\engine\utility::waittill_any_return("carrier_path1_done", "door_destroyed");
  self notify("disable_speed_control");

  if(var_2 == "carrier_path1_done") {
    _id_0BDC::_id_19A2();
    _id_0BDC::_id_19AB(200.0);
    var_0 = scripts\engine\utility::getStruct("jackal_pos_ally" + self.script_parameters + "c", "targetname");
    _id_0BDC::_id_19B2("face angle", var_0.angles);
    thread _id_0BDC::_id_A1EC(var_0.origin, 1, 384, var_0.angles);
  }

  level.player scripts\sp\utility::_id_65E3("flag_player_dismounting");

  if(self == level._id_A06C) {
    self delete();
    scripts\sp\maps\sa_wounded\sa_wounded::_id_106C5();
    level._id_EA2C = _id_1062A("rappel_start_salter", "salter", "salter", "red");
    level._id_1CB7 = _id_1062A("rappel_start_ally1", "ally1", "ally1", "green");
    level notify("ally_jackal2_landed");
    scripts\engine\utility::flag_set("ally_" + level._id_A06C.script_parameters + "_landed");
    return;
  }

  var_0 = scripts\engine\utility::getStruct("jackal_pos_ally" + self.script_parameters + "d", "targetname");

  if(isDefined(var_0)) {
    _id_0BDC::_id_19B2("face angle", var_0.angles);
    thread _id_0BDC::_id_A1EC(var_0.origin, 1, 384, var_0.angles);
  }
}

_id_19B6(var_0, var_1, var_2, var_3, var_4, var_5) {
  self notify("disable_speed_control");
  self endon("disable_speed_control");
  self endon("intro_path_done");
  self endon("death");

  if(!isDefined(var_0))
    var_0 = 1.5;

  if(!isDefined(var_1))
    var_1 = 1.0;

  if(!isDefined(var_2))
    var_2 = 0.5;

  if(!isDefined(var_3))
    var_3 = 2.5;

  while(!isDefined(level._id_D127))
    wait 0.1;

  if(!isDefined(var_4))
    var_4 = 5000;

  if(!isDefined(var_5))
    var_5 = 9000;

  for(;;) {
    var_6 = vectorNormalize(level._id_D127.origin - self.origin);
    var_7 = anglesToForward(self.angles);
    var_8 = vectordot(var_7, var_6);
    var_9 = distance2d(level._id_D127.origin, self.origin);

    if(var_8 < 0) {
      if(var_9 <= var_4)
        self _meth_8485(var_0);
      else if(var_9 > var_4 && var_9 <= var_5)
        self _meth_8485(var_1);
      else if(var_9 > var_5)
        self _meth_8485(var_2);
    } else if(var_8 >= 0)
      self _meth_8485(var_3);

    wait 0.33;
  }
}

_id_5889(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 0;

  var_0 = getEnt(var_0, "targetname");

  if(isDefined(var_0)) {
    var_3 = var_0 scripts\sp\utility::_id_10808();
    var_3 _id_0BDC::_id_19B1(0);
    var_3 thread _id_0BDC::_id_A36D();
    var_0.count = 1;
    level._id_6496 = scripts\engine\utility::add_to_array(level._id_6496, var_3);
    var_3 waittill("death");
    level._id_6496 = scripts\engine\utility::array_remove(level._id_6496, var_3);
  }
}

_id_52BA() {
  var_0 = getEnt("turret_killer", "targetname");
  scripts\engine\utility::flag_wait("capital_ship_spawned");
  level._id_3965 waittill("turrets_spawned");

  for(var_1 = 0; var_1 < level._id_3965.turrets["cap_turret_med_flak"].size; var_1++) {
    if(level._id_3965.turrets["cap_turret_med_flak"][var_1] istouching(var_0))
      level._id_3965.turrets["cap_turret_med_flak"][var_1] delete();
  }

  for(var_1 = 0; var_1 < level._id_3965.turrets["cap_turret_small_constant"].size; var_1++) {
    if(level._id_3965.turrets["cap_turret_small_constant"][var_1] istouching(var_0))
      level._id_3965.turrets["cap_turret_small_constant"][var_1] delete();
  }

  level._id_3965.turrets["cap_turret_med_flak"] = scripts\engine\utility::array_removeundefined(level._id_3965.turrets["cap_turret_med_flak"]);
  level._id_3965.turrets["cap_turret_small_constant"] = scripts\engine\utility::array_removeundefined(level._id_3965.turrets["cap_turret_small_constant"]);
  scripts\engine\utility::waitframe();
  scripts\engine\utility::flag_set("wounded_turrets_destroyed");
}

_id_3982() {
  level._id_3965._id_11578 = 1;
  level._id_3965 thread _id_0BB6::_id_39F0(undefined, undefined, 1, 1);
}

_id_39D1() {
  level._id_13534 = [];
  level._id_13534["left"] = getEntArray("chase_missile_left", "targetname");
  level._id_13534["right"] = getEntArray("chase_missile_right", "targetname");
  level._id_1678 = [];
  level waittill("missile_doors_open");
  scripts\engine\utility::array_thread(level._id_13534["left"], ::_id_B801);
  scripts\engine\utility::array_thread(level._id_13534["right"], ::_id_B801);
  scripts\sp\utility::_id_10350("sa_wounded_un1_missilesincomin");
}

_id_B801() {
  var_0 = 3;
  var_1 = 8;
  var_2 = -8000;
  var_3 = 8000;
  var_4 = -8000;
  var_5 = 8000;
  var_6 = -8000;
  var_7 = 8000;
  var_8 = [];
  var_8[var_8.size] = level._id_D127;
  var_8[var_8.size] = level._id_A06B;
  var_8[var_8.size] = level._id_A06D;
  wait(randomfloatrange(0.5, 1));

  while(!scripts\engine\utility::flag("hanger_allies_go")) {
    var_9 = self.origin + (0, 0, 200);
    var_10 = scripts\engine\utility::random(var_8);

    if(isDefined(var_9) && scripts\engine\utility::cointoss()) {
      var_11 = var_10.origin;
      var_12 = magicbullet("spaceship_homing_missile_yard", var_9, var_11, level.player);
      level._id_1678 = scripts\engine\utility::array_add(level._id_1678, var_12);
      var_13 = randomfloatrange(var_2, var_3);
      var_14 = randomfloatrange(var_4, var_5);
      var_15 = randomfloatrange(var_6, var_7);
      var_12 missile_settargetEnt(var_10, (var_13, var_14, var_15));
    }

    wait(randomfloatrange(var_0, var_1));
  }
}

_id_6CF4(var_0, var_1) {
  var_2 = magicbullet("spaceship_homing_missile_yard", var_0, var_1, level.player);
  var_2 thread _id_5EFC(var_1);
  var_2 thread _id_B81D();
}

_id_B81D() {
  scripts\engine\utility::waittill_any("damage", "destroyed", "death");
  level notify("salter_missile_hit");
}

_id_5EFC(var_0) {
  self endon("death");
  self endon("deleted");
  var_1 = 0.5;
  var_2 = 0.1;
  var_3 = 320;
  var_4 = -500;
  var_5 = 2500;
  wait(var_1);
  var_6 = 25000000;
  var_7 = var_5 * var_5;
  var_8 = (0, 0, var_4);
  var_9 = -1 * var_3;

  while(isDefined(self) && var_6 > var_7) {
    var_10 = randomfloatrange(var_9, var_3);
    var_11 = randomfloatrange(var_9, var_3);
    var_12 = randomfloatrange(var_9, var_3);
    var_13 = var_0 + (var_10, var_11, var_12);
    self missile_settargetpos(var_13);
    var_6 = scripts\engine\utility::distance_2d_squared(self.origin, var_0);
    wait(var_2);
  }

  if(isDefined(self))
    self missile_settargetpos(var_0 + var_8);
}

_id_91C3() {
  level._id_59AE = [];

  for(var_0 = 1; var_0 <= 6; var_0++) {
    var_1 = setup_door("animated_missile_port" + var_0);
    var_1.tag thread scripts\sp\anim::_id_1EC3(var_1, "sa_moon_deck_missilebaydoors_open", "tag_origin");
    var_2 = setup_door("animated_missile_star" + var_0, 1);
    var_2.tag thread scripts\sp\anim::_id_1EC3(var_2, "sa_moon_deck_missilebaydoors_open", "tag_origin");
    level._id_59AE[level._id_59AE.size] = var_1;
    level._id_59AE[level._id_59AE.size] = var_2;
    scripts\engine\utility::waitframe();
  }

  for(var_0 = 1; var_0 <= 6; var_0++) {
    var_1 = getEnt("animated_missile_port" + var_0, "script_noteworthy");
    var_1.tag thread scripts\sp\anim::_id_1F35(var_1, "sa_moon_deck_missilebaydoors_open", "tag_origin");
    var_2 = getEnt("animated_missile_star" + var_0, "script_noteworthy");
    var_2.tag thread scripts\sp\anim::_id_1F35(var_2, "sa_moon_deck_missilebaydoors_open", "tag_origin");
    level._id_59AE[level._id_59AE.size] = var_1;
    level._id_59AE[level._id_59AE.size] = var_2;
    wait 1;
  }

  level notify("missile_doors_open");
}

#using_animtree("script_model");

setup_door(var_0, var_1) {
  var_2 = getEnt(var_0, "script_noteworthy");
  var_2._id_1FBB = "missile_hatch";
  var_2 _meth_83D0(#animtree);

  if(isDefined(var_1)) {
    var_3 = -90;
    var_4 = -17;
  } else {
    var_3 = 90;
    var_4 = 17;
  }

  var_2.tag = scripts\engine\utility::spawn_tag_origin(var_2.origin + (0, var_4, 40.5), (0, var_3, 0));
  var_5 = getEnt(var_2.target, "targetname");
  var_5 linkTo(var_2, "tag_origin", (0, 0, 0), (0, var_3, 0));
  return var_2;
}

_id_B80B() {
  wait 0.75;
  var_0 = scripts\engine\utility::waittill_any_timeout(0.25, "trigger");

  if(isDefined(var_0) && var_0 != "timeout")
    level.player _meth_81D0();
}

_id_1062A(var_0, var_1, var_2, var_3) {
  if(isstring(var_0))
    var_4 = scripts\engine\utility::getStruct(var_0, "targetname");
  else
    var_4 = var_0;

  var_5 = getEnt(var_1, "targetname");
  var_5.origin = var_4.origin;

  if(isDefined(var_4.angles))
    var_5.angles = var_4.angles;
  else
    var_5.angles = (0, 0, 0);

  var_6 = scripts\sp\utility::_id_107EA(var_1, 1);
  var_6._id_1FBB = var_2;
  var_6 scripts\sp\utility::_id_F3B5(var_3);
  var_6 thread scripts\sp\utility::_id_B14F();
  var_6.goalradius = 16;
  var_6.ignoreall = 1;
  var_6.ignoreme = 1;
  return var_6;
}

_id_9716() {
  var_0 = [];
  var_0["sa_armory_room_vol"] = "sa_armory_start";
  var_0["sa_hubstern_vol"] = "sa_hubstern_start";
  var_0["sa_portjunction_rooma_vol"] = "sa_portjunction_rooma_start";
  var_0["sa_midship_room_vol"] = "sa_midship_start";
  var_0["sa_portmid_room_vol"] = "sa_portmid_start";
  var_1 = [];
  var_1["sa_armory_room_vol"] = "hot";
  var_1["sa_hubstern_vol"] = "hot";
  var_1["sa_portjunction_rooma_vol"] = "hot";
  var_1["sa_midship_room_vol"] = "alert";
  var_1["sa_portmid_room_vol"] = "hot";
  var_2 = [];
  var_2["sa_armory_room_vol"] = "sa_armory_combat_vol";
  var_2["sa_hubstern_vol"] = "sa_hubstern_combat_vol";
  var_2["sa_portjunction_rooma_vol"] = "sa_portjunction_rooma_combat_vol";
  var_2["sa_midship_room_vol"] = "sa_midship_combat_vol";
  var_2["sa_portmid_room_vol"] = "sa_portmid_combat_vol";
  _id_0F0C::_id_E9E4(var_0, var_1, var_2, ::_id_79F8, ::_id_7B73);
}

_id_79F8(var_0) {
  var_1 = [];

  switch (var_0) {
    case "sa_hubstern_vol":
      var_1["ar"] = 3;
      var_1["smg"] = 3;
      var_1["lmg"] = 1;
      break;
    case "sa_portjunction_rooma_vol":
      var_1["ar"] = 1;
      var_1["smg"] = 1;
      break;
    case "sa_armory_room_vol":
      var_1["ar"] = 6;
      var_1["smg"] = 4;
      break;
    default:
      break;
  }

  return var_1;
}

_id_7B73(var_0) {
  var_1 = [];

  switch (var_0) {
    case "sa_hubstern_vol":
      var_1["ar"] = 1;
      var_1["smg"] = 1;
      break;
    case "sa_portjunction_rooma_vol":
      var_1["smg"] = 1;
      break;
    case "sa_armory_room_vol":
      var_1["ar"] = 2;
      var_1["smg"] = 1;
      break;
    default:
      break;
  }

  return var_1;
}

_id_13DD0(var_0) {
  _id_0BDC::_id_A15C();
  _id_0BDC::_id_A153();
  _id_0BDC::_id_A155();
  _id_0BDC::_id_A156();
  _id_0BDC::_id_A164();
  _id_0BDC::_id_A14A();
  level._id_D127 _meth_8491("hover");
  _id_0BDC::_id_A224(1);
  var_1 = 250;
  var_2 = 500;
  var_3 = 5000;
  var_4 = level._id_D127.origin[2] - var_0.origin[2];
  var_5 = clamp(var_4, var_1, var_2);
  var_6 = 152;
  var_7 = scripts\engine\utility::spawn_tag_origin();
  var_8 = scripts\engine\utility::spawn_tag_origin();
  var_7.origin = level._id_D127.origin;
  var_8.origin = var_7.origin + anglesToForward(var_0.angles) * var_3;
  var_9 = 2.0;
  var_7 moveTo(var_0.origin + anglestoup(var_0.angles) * var_5, var_9, var_9 * 0.4);
  _id_0BDC::_id_D165(var_8, 0.4, 0, 1);
  _id_0BDC::_id_D16C(var_7, 0.625, 0, 1, 1);
  var_10 = 600;
  var_11 = var_9;

  for(;;) {
    var_12 = distance(level._id_D127.origin, var_7.origin);
    var_13 = vectordot(anglesToForward(level._id_D127.angles), vectorNormalize(var_8.origin - level._id_D127.origin));
    var_14 = scripts\sp\math::_id_C097(var_10, 2000, var_12);
    var_15 = scripts\sp\math::_id_6A8E(0.1, 0.6, var_14);

    if(var_12 < var_10 && var_13 > 0.75 && var_11 < 0) {
      break;
    }

    var_11 = var_11 - 0.05;
    wait 0.05;
  }

  _id_0BDC::_id_A14D();
  var_9 = 0.5;
  var_7 moveTo(var_0.origin, var_9, var_9 * 0.4);
  var_8 moveTo(var_7.origin + anglesToForward(var_0.angles) * var_3, var_9, var_9 * 0.4);
  var_16 = undefined;

  for(;;) {
    var_4 = level._id_D127.origin[2] - var_0.origin[2];

    if(!isDefined(var_16))
      var_16 = var_4 - var_6;

    var_17 = scripts\sp\math::_id_C097(20, var_16, var_4 - var_6);
    var_15 = scripts\sp\math::_id_6A8E(0.6, 0.625, var_17);
    _id_0BDC::_id_D16C(var_7, var_15, 0, 1, 1);

    if(var_4 <= var_6) {
      break;
    }

    wait 0.05;
  }

  earthquake(0.3, 0.45, level._id_D127.origin, 3000);
  level.player playRumbleOnEntity("damage_heavy");
  level._id_D127 _meth_8491("land");
  level._id_D127 notify("jackal_touchdown");
  var_18 = level._id_D127.origin;
  var_19 = (0, level._id_D127.angles[1], 0);
  var_20 = var_0.origin[2] + 102;
  var_7.origin = (var_18[0], var_18[1], var_20);
  var_8.origin = var_7.origin + anglesToForward(var_19) * 5000;
  _id_0BDC::_id_D165(var_8, 1.0, 0, 0.15, 1);
  _id_0BDC::_id_D16C(var_7, 1.0, 0, 0.15, 1);
  wait 1;
  _id_0BDC::_id_A224(0);
  _id_0BDB::_id_E073();
}

_id_E353(var_0, var_1, var_2, var_3) {
  var_4 = getEnt(var_0, "targetname");
  var_5 = var_4 scripts\sp\utility::_id_77E3("axis");
  var_6 = getEnt(var_1, "targetname");
  var_7 = getnode(var_6.target, "targetname");

  foreach(var_9 in var_5)
  var_9 thread _id_E355(var_7, var_6, var_2, var_3);
}

_id_E355(var_0, var_1, var_2, var_3) {
  wait(randomfloatrange(var_2, var_3));

  if(isDefined(self) && isalive(self)) {
    self.fixednode = 0;
    self.pathrandompercent = randomintrange(50, 100);

    if(isDefined(var_0))
      self _meth_82EE(var_0);

    self _meth_82F0(var_1);
  }
}

_id_19BA(var_0, var_1, var_2, var_3) {
  if(!scripts\engine\utility::flag_exist(var_2))
    scripts\engine\utility::flag_init(var_2);

  scripts\sp\utility::_id_13754(var_0, var_1, var_3);
  scripts\engine\utility::flag_set(var_2);
}

_id_11685(var_0, var_1, var_2, var_3) {
  if(getdvarint("loc_warnings", 0)) {
    return;
  }
  if(!isDefined(level._id_545A))
    level._id_545A = [];

  var_4 = 0;

  for(;;) {
    if(!isDefined(level._id_545A[var_4])) {
      break;
    }

    var_4++;
  }

  var_5 = "^3";

  if(!isDefined(var_2))
    var_2 = 1;

  var_2 = max(1, var_2);
  level._id_545A[var_4] = 1;
  var_6 = scripts\sp\hud_util::createfontstring("default", 1.0);
  var_6.location = 0;
  var_6.alignx = "left";
  var_6.aligny = "top";
  var_6.foreground = 1;
  var_6.sort = 20;
  var_6.alpha = 0;
  var_6 fadeovertime(0.5);
  var_6.alpha = 1;
  var_6.x = 40;
  var_6.y = 260 + var_4 * 18;
  var_6.label = " " + var_5 + "< " + var_0 + " > ^7" + var_1;
  var_6.color = (1, 1, 1);

  if(isDefined(level.player) && !scripts\engine\utility::is_true(var_3))
    level.player thread _id_116C1();

  wait(var_2);
  var_7 = 10.0;
  var_6 fadeovertime(0.5);
  var_6.alpha = 0;

  for(var_8 = 0; var_8 < var_7; var_8++) {
    var_6.color = (1, 1, 0 / (var_7 - var_8));
    wait 0.05;
  }

  wait 0.25;
  var_6 destroy();
  level._id_545A[var_4] = undefined;
}

_id_116C1() {
  self endon("death");

  for(var_0 = 0; var_0 < 4; var_0++) {
    self playSound("ui_text_type");
    wait 0.1;
  }
}