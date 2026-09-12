/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\challenges_mp.gsc
***********************************************/

function spawn_enemy_tank(var_0) {
  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_1 = spawnStruct();
  var_2 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1.spawntype = "GAME_MODE";
  var_1.owner = undefined;
  var_1.team = "axis";
  var_1.faceawayfromowner = 0;
  var_1.cancapture = 0;
  var_1.cancaptureimmediately = 0;
  var_1.spawnmethod = "airdrop_at_position_unsafe";
  var_1.activateimmediately = 1;
  var_1.cantimeout = 0;
  var_1.usealtmodel = 1;
  scripts\cp_mp\vehicles\light_tank::light_tank_initializespawndata(var_1);
  var_3 = scripts\cp_mp\vehicles\light_tank::light_tank_spawn(var_1, var_2);

  if(!isDefined(var_3)) {
    return;
  }

  wait 10;
  level.enemy_tanks[level.enemy_tanks.size] = var_3;
  thread ref_13A3E();
  thread tank_waittill_death();
  thread ref_14350();
  var_3 endon("death");
  var_3 scripts\cp_mp\vehicles\light_tank::light_tank_activate();
  var_4 = scripts\engine\utility::getStructArray("enemy_tank_path", "targetname");
  var_5 = sortbydistance(var_4, var_3.origin)[0];
  var_6 = build_tank_path(var_5);
  var_7 = build_tank_duration(var_5);
  var_3 startpathnodes(var_6, var_7);
  setheadiconsnaptoedges(var_3.headicon, 8088);
  var_8 = scripts\cp_mp\vehicles\vehicle::ref_14192(var_3, "tur_bradley_mp");
  var_8 scripts\cp_mp\emp_debuff::set_start_emp_callback(&tank_empstarted);
  var_8 scripts\cp_mp\emp_debuff::set_clear_emp_callback(&tank_empcleared);
  var_9 = scripts\cp_mp\vehicles\vehicle::ref_14192(var_3, "tur_gun_lighttank_mp");
  var_9 scripts\cp_mp\emp_debuff::set_start_emp_callback(&tank_empstarted);
  var_9 scripts\cp_mp\emp_debuff::set_clear_emp_callback(&tank_empcleared);

  if(!isDefined(level.vo_paratroopers)) {
    level.vo_paratroopers = [];
  }

  level.vo_paratroopers = scripts\engine\utility::array_add(level.vo_paratroopers, var_3);

  for(;;) {
    var_10 = initdragonsbreathusage(var_3);
    var_11 = var_3 scripts\cp\utility::get_closest_living_player(undefined, var_10);

    if(!isDefined(var_11)) {
      var_8 cleartargetentity();
      var_9 cleartargetentity();
      wait 1;
      continue;
    }

    ref_13A4F(var_8, var_11);
    ref_13A4F(var_9, var_11);

    if(scripts\engine\utility::flag_exist("weapons_free") && !scripts\engine\utility::flag("weapons_free")) {
      scripts\engine\utility::flag_set("weapons_free");
    }

    level notify("weapons_free");
    wait randomfloatrange(3, 5);
  }
}

function initdragonsbreathusage() {
  var_0 = level.players;
  var_1 = [];

  foreach(var_3 in var_0) {
    if(istrue(var_3.ignoreme)) {
      continue;
    }

    if(istrue(self.ignoreall)) {
      continue;
    }

    if(ref_124F8(var_3)) {
      continue;
    }

    var_1 = var_3;
  }

  return var_1;
}

function ref_124F8(var_0) {
  var_1 = 2000;

  if(istrue(self.alerted)) {
    var_1 = 6000;
  }

  if(scripts\engine\utility::flag_exist("weapons_free") && !scripts\engine\utility::flag("weapons_free")) {
    if(isDefined(var_0.perk_data["stealth_dist_scalar"])) {
      var_1 *= var_0.perk_data["stealth_dist_scalar"];
    }
  }

  var_2 = var_1 * var_1;

  if(distancesquared(self.origin, var_0.origin) > var_2) {
    return true;
  }

  return false;
}

function ref_14350() {
  self endon("death");
  wait 5;

  for(;;) {
    wait 1;

    if(self vehicle_getspeed() < 1) {
      self stoppath(1);
      return;
    }
  }
}

function ref_13A4F(var_0, var_1) {
  var_2 = 0;

  if(var_0 scripts\cp_mp\emp_debuff::is_empd()) {
    var_0 cleartargetentity();
  } else if(istrue(var_1.binvehicle) && isDefined(var_1.vehicle)) {
    if(var_0 turretcantarget(var_1.vehicle.origin + (0, 0, 50))) {
      var_0 settargetentity(var_1.vehicle, (0, 0, 50));
      var_2 = 1;
    }
  } else {
    var_0 settargetentity(var_1);
    var_2 = 1;
  }

  if(var_2) {
    thread tank_shoot_at_target(var_0);
    return;
  }
}

function tank_empstarted(var_0) {
  ref_13A49();
}

function tank_empcleared(var_0) {
  if(var_0) {
    return;
  }

  ref_13A49();
}

function ref_13A49() {
  if(scripts\cp_mp\emp_debuff::is_empd()) {
    self turretfiredisable();
    self laseroff();
    return;
  }

  self turretfireenable();
}

function tank_shoot_at_target(var_0, var_1) {
  self endon("death");
  var_0 endon("death");
  var_2 = 1;
  var_3 = getcompleteweaponname("tur_bradley_mp");

  if(istrue(var_1)) {
    var_2 = randomintrange(15, 25);
    var_3 = getcompleteweaponname("tur_gun_lighttank_mp");
  }

  var_4 = weaponfiretime(var_3);

  for(var_5 = 0; var_5 < var_2; var_5++) {
    var_0 shootturret();
    wait var_4;
  }
}

function build_tank_path(var_0) {
  self endon("death");
  var_1 = [];
  var_2 = var_0;

  for(var_1 = var_2.origin; isDefined(var_2) && isDefined(var_2.target); var_1 = var_2.origin) {
    var_2 = scripts\engine\utility::getStruct(var_2.target, "targetname");
  }

  return var_1;
}

function build_tank_duration(var_0) {
  self endon("death");
  var_1 = [];
  var_2 = var_0;

  for(var_1 = 10; isDefined(var_2) && isDefined(var_2.target); var_1 = 10) {
    var_2 = scripts\engine\utility::getStruct(var_2.target, "targetname");
  }

  return var_1;
}

function ref_13A3E() {
  for(var_0 = 0; !var_0; var_0 = 1) {
    self waittill("alerted", var_1);

    if(isDefined(var_1.attacker.team)) {
      if(var_1.attacker.team != self.team) {}
    }
  }

  self.alerted = 1;
}

function tank_waittill_death() {
  self waittill("death");

  if(isDefined(self.headicon)) {
    setheadiconimage(self.headicon);
    self.headicon = undefined;
  }

  level.enemy_tanks = scripts\engine\utility::array_remove(level.enemy_tanks, self);
  level.vo_paratroopers = scripts\engine\utility::array_remove(level.vo_paratroopers, self);
}