/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\challenges_mp.gsc
***********************************************/

function spawn_enemy_tank(var0) {
  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  var1 = spawnStruct();
  var2 = spawnStruct();
  var1.origin = var0.origin;
  var1.angles = var0.angles;
  var1.spawntype = "GAME_MODE";
  var1.owner = undefined;
  var1.team = "axis";
  var1.faceawayfromowner = 0;
  var1.cancapture = 0;
  var1.cancaptureimmediately = 0;
  var1.spawnmethod = "airdrop_at_position_unsafe";
  var1.activateimmediately = 1;
  var1.cantimeout = 0;
  var1.usealtmodel = 1;
  scripts\cp_mp\vehicles\light_tank::light_tank_initializespawndata(var1);
  var3 = scripts\cp_mp\vehicles\light_tank::light_tank_spawn(var1, var2);

  if(!isDefined(var3)) {
    return;
  }

  wait 10;
  level.enemy_tanks[level.enemy_tanks.size] = var3;
  thread ref_13a3e();
  thread tank_waittill_death();
  thread ref_14350();
  var3 endon("death");
  var3 scripts\cp_mp\vehicles\light_tank::light_tank_activate();
  var4 = scripts\engine\utility::getStructArray("enemy_tank_path", "targetname");
  var5 = sortbydistance(var4, var3.origin)[0];
  var6 = build_tank_path(var5);
  var7 = build_tank_duration(var5);
  var3 startpathnodes(var6, var7);
  setheadiconsnaptoedges(var3.headicon, 8088);
  var8 = scripts\cp_mp\vehicles\vehicle::ref_14192(var3, "tur_bradley_mp");
  var8 scripts\cp_mp\emp_debuff::set_start_emp_callback(&tank_empstarted);
  var8 scripts\cp_mp\emp_debuff::set_clear_emp_callback(&tank_empcleared);
  var9 = scripts\cp_mp\vehicles\vehicle::ref_14192(var3, "tur_gun_lighttank_mp");
  var9 scripts\cp_mp\emp_debuff::set_start_emp_callback(&tank_empstarted);
  var9 scripts\cp_mp\emp_debuff::set_clear_emp_callback(&tank_empcleared);

  if(!isDefined(level.vo_paratroopers)) {
    level.vo_paratroopers = [];
  }

  level.vo_paratroopers = scripts\engine\utility::array_add(level.vo_paratroopers, var3);

  for(;;) {
    var10 = initdragonsbreathusage(var3);
    var11 = var3 scripts\cp\utility::get_closest_living_player(undefined, var10);

    if(!isDefined(var11)) {
      var8 cleartargetentity();
      var9 cleartargetentity();
      wait 1;
      continue;
    }

    ref_13a4f(var8, var11);
    ref_13a4f(var9, var11);

    if(scripts\engine\utility::flag_exist("weapons_free") && !scripts\engine\utility::flag("weapons_free")) {
      scripts\engine\utility::flag_set("weapons_free");
    }

    level notify("weapons_free");
    wait randomfloatrange(3, 5);
  }
}

function initdragonsbreathusage() {
  var0 = level.players;
  var1 = [];

  foreach(var3 in var0) {
    if(istrue(var3.ignoreme)) {
      continue;
    }

    if(istrue(self.ignoreall)) {
      continue;
    }

    if(ref_124f8(var3)) {
      continue;
    }

    var1 = var3;
  }

  return var1;
}

function ref_124f8(var0) {
  var1 = 2000;

  if(istrue(self.alerted)) {
    var1 = 6000;
  }

  if(scripts\engine\utility::flag_exist("weapons_free") && !scripts\engine\utility::flag("weapons_free")) {
    if(isDefined(var0.perk_data["stealth_dist_scalar"])) {
      var1 *= var0.perk_data["stealth_dist_scalar"];
    }
  }

  var2 = var1 * var1;

  if(distancesquared(self.origin, var0.origin) > var2) {
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

function ref_13a4f(var0, var1) {
  var2 = 0;

  if(var0 scripts\cp_mp\emp_debuff::is_empd()) {
    var0 cleartargetentity();
  } else if(istrue(var1.binvehicle) && isDefined(var1.vehicle)) {
    if(var0 turretcantarget(var1.vehicle.origin + (0, 0, 50))) {
      var0 settargetentity(var1.vehicle, (0, 0, 50));
      var2 = 1;
    }
  } else {
    var0 settargetentity(var1);
    var2 = 1;
  }

  if(var2) {
    thread tank_shoot_at_target(var0);
    return;
  }
}

function tank_empstarted(var0) {
  ref_13a49();
}

function tank_empcleared(var0) {
  if(var0) {
    return;
  }

  ref_13a49();
}

function ref_13a49() {
  if(scripts\cp_mp\emp_debuff::is_empd()) {
    self turretfiredisable();
    self laseroff();
    return;
  }

  self turretfireenable();
}

function tank_shoot_at_target(var0, var1) {
  self endon("death");
  var0 endon("death");
  var2 = 1;
  var3 = getcompleteweaponname("tur_bradley_mp");

  if(istrue(var1)) {
    var2 = randomintrange(15, 25);
    var3 = getcompleteweaponname("tur_gun_lighttank_mp");
  }

  var4 = weaponfiretime(var3);

  for(var5 = 0; var5 < var2; var5++) {
    var0 shootturret();
    wait var4;
  }
}

function build_tank_path(var0) {
  self endon("death");
  var1 = [];
  var2 = var0;

  for(var1 = var2.origin; isDefined(var2) && isDefined(var2.target); var1 = var2.origin) {
    var2 = scripts\engine\utility::getStruct(var2.target, "targetname");
  }

  return var1;
}

function build_tank_duration(var0) {
  self endon("death");
  var1 = [];
  var2 = var0;

  for(var1 = 10; isDefined(var2) && isDefined(var2.target); var1 = 10) {
    var2 = scripts\engine\utility::getStruct(var2.target, "targetname");
  }

  return var1;
}

function ref_13a3e() {
  for(var0 = 0; !var0; var0 = 1) {
    self waittill("alerted", var1);

    if(isDefined(var1.attacker.team)) {
      if(var1.attacker.team != self.team) {}
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