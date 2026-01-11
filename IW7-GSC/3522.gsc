/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3522.gsc
***************************************/

init() {
  return;
}

func_1082D(var_00, var_01, var_02) {
  var_03 = self global_physics_sound_monitor("tank", var_00);
  var_3.health = 3000;
  var_3.func_11568 = 1;
  var_3.team = var_0.team;
  var_3.pers["team"] = var_3.team;
  var_3.owner = var_00;
  var_03 setCanDamage(1);
  var_3.func_10B68 = 12;
  var_03 thread deletepentsonrespawn();
  var_03 func_185E();
  var_3.damagecallback = ::func_3758;
  return var_03;
}

deletepentsonrespawn() {
  self endon("death");
  var_00 = self.origin[2];

  for(;;) {
    if(var_00 - self.origin[2] > 2048) {
      self.health = 0;
      self notify("death");
      return;
    }

    wait 1.0;
  }
}

func_130E4(var_00) {
  return func_12907();
}

func_12907() {
  if(isDefined(level.func_114E2) && level.func_114E2) {
    self iprintlnbold("Armor support unavailable.");
    return 0;
  }

  if(!isDefined(getvehiclenode("startnode", "targetname"))) {
    self iprintlnbold("Tank is currently not supported in this level, bug your friendly neighborhood LD.");
    return 0;
  }

  if(!vehicle_getspawnerarray().size) {
    return 0;
  }

  if(self.team == "allies") {
    var_00 = level.func_114E5["allies"] func_1082D(self, "vehicle_bradley");
  }
  else {
    var_00 = level.func_114E5["axis"] func_1082D(self, "vehicle_bmp");
  }

  var_00 func_10DF8();
  return 1;
}

func_10DF8(var_00) {
  var_01 = getvehiclenode("startnode", "targetname");
  var_02 = getvehiclenode("waitnode", "targetname");
  self.nodes = getvehiclenodearray("info_vehicle_node", "classname");
  level.func_114E2 = 1;
  thread func_114E9(var_01, var_02);
  thread func_114D9();
  level.func_114B1 = self;

  if(level.teambased) {
    var_03 = scripts\mp\objidpoolmanager::requestminimapid(1);

    if(var_03 != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_add(var_03, "invisible", (0, 0, 0));
      scripts\mp\objidpoolmanager::minimap_objective_team(var_03, "allies");
    }

    level.func_114B1.objid["allies"] = var_03;
    var_04 = scripts\mp\objidpoolmanager::requestminimapid(1);

    if(var_04 != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_add(var_04, "invisible", (0, 0, 0));
      scripts\mp\objidpoolmanager::minimap_objective_team(var_04, "axis");
    }

    level.func_114B1.objid["axis"] = var_04;
    var_05 = self.team;
    level.func_114B1.team = var_05;
    level.func_114B1.pers["team"] = var_05;
  }

  var_06 = spawnturret("misc_turret", self.origin, "abrams_minigun_mp");
  var_06 linkto(self, "tag_engine_left", (0, 0, -20), (0, 0, 0));
  var_06 setModel("sentry_minigun");
  var_6.angles = self.angles;
  var_6.owner = self.owner;
  var_06 maketurretinoperable();
  self.mgturret = var_06;
  self.mgturret setdefaultdroppitch(0);
  var_07 = self.angles;
  self.angles = (0, 0, 0);
  var_08 = self gettagorigin("tag_flash");
  self.angles = var_07;
  var_09 = var_08 - self.origin;
  thread func_136B0();
  thread func_136B8();
  self.func_118F3 = gettime();
  var_10 = spawn("script_origin", self gettagorigin("tag_flash"));
  var_10 linkto(self, "tag_origin", var_09, (0, 0, 0));
  var_10 hide();
  self.func_BEF5 = var_10;
  thread func_114E1();
  thread func_5329();
  thread func_114DF();
  thread func_3E02();
  thread func_13A78();
}

func_136B0() {
  self endon("death");
  self.owner endon("disconnect");
  self.owner waittill("joined_team");
  self.health = 0;
  self notify("death");
}

func_136B8() {
  self endon("death");
  self.owner waittill("disconnect");
  self.health = 0;
  self notify("death");
}

func_F6C4(var_00) {
  if(self.veh_pathdir != var_00) {
    if(var_00 == "forward") {
      func_11096();
    }
    else {
      func_11097();
    }
  }
}

func_F6E3() {
  self endon("death");
  self notify("path_abandoned");

  while(isDefined(self.changingdirection)) {
    wait 0.05;
  }

  var_00 = 2;
  self vehicle_setspeed(var_00, 10, 10);
  self.func_109C6 = "engage";
}

func_F799() {
  self endon("death");
  self notify("path_abandoned");

  while(isDefined(self.changingdirection)) {
    wait 0.05;
  }

  var_00 = 2;
  self vehicle_setspeed(var_00, 10, 10);
  self.func_109C6 = "engage";
}

setstate() {
  self endon("death");

  while(isDefined(self.changingdirection)) {
    wait 0.05;
  }

  self vehicle_setspeed(self.func_10B68, 10, 10);
  self.func_109C6 = "standard";
}

func_F6ED() {
  self endon("death");

  while(isDefined(self.changingdirection)) {
    wait 0.05;
  }

  self vehicle_setspeed(15, 15, 15);
  self.func_109C6 = "evade";
  wait 1.5;
  self vehicle_setspeed(self.func_10B68, 10, 10);
}

func_F6B0() {
  self endon("death");

  while(isDefined(self.changingdirection)) {
    wait 0.05;
  }

  self vehicle_setspeed(5, 5, 5);
  self.func_109C6 = "danger";
}

func_11097() {
  func_4F52("tank changing direction at " + gettime());
  self vehicle_setspeed(0, 5, 6);
  self.changingdirection = 1;

  while(self.veh_speed > 0) {
    wait 0.05;
  }

  wait 0.25;
  self.changingdirection = undefined;
  func_4F52("tank done changing direction");
  self.veh_transmission = "reverse";
  self.veh_pathdir = "reverse";
  self vehicle_setspeed(self.func_10B68, 5, 6);
}

func_11096() {
  func_4F52("tank changing direction at " + gettime());
  self vehicle_setspeed(0, 5, 6);
  self.changingdirection = 1;

  while(self.veh_speed > 0) {
    wait 0.05;
  }

  wait 0.25;
  self.changingdirection = undefined;
  func_4F52("tank done changing direction");
  self.veh_transmission = "forward";
  self.veh_pathdir = "forward";
  self vehicle_setspeed(self.func_10B68, 5, 6);
}

func_3E02() {
  self endon("death");
  var_00 = [];
  var_01 = level.players;
  self.func_C225 = 0;

  for(;;) {
    foreach(var_03 in var_01) {
      if(!isDefined(var_03)) {
        continue;
      }
      if(var_3.team == self.team) {
        wait 0.05;
        continue;
      }

      var_04 = distance2d(var_3.origin, self.origin);

      if(var_04 < 2048) {
        self.func_C225++;
      }

      wait 0.05;
    }

    if(isDefined(self.func_109C6) && (self.func_109C6 == "evade" || self.func_109C6 == "engage")) {
      self.func_C225 = 0;
      continue;
    }

    if(self.func_C225 > 1) {
      thread func_F6B0();
    }
    else {
      thread setstate();
    }

    self.func_C225 = 0;
    wait 0.05;
  }
}

func_114E9(var_00, var_01) {
  self endon("tankDestroyed");
  self endon("death");

  if(!isDefined(level._meth_848E)) {
    self startpath(var_00);
    return;
  }

  self attachpath(var_00);
  self startpath(var_00);
  var_00 notify("trigger", self, 1);
  wait 0.05;

  for(;;) {
    while(isDefined(self.changingdirection)) {
      wait 0.05;
    }

    var_02 = getnodenearenemies();

    if(isDefined(var_02)) {
      self.endnode = var_02;
    }
    else {
      self.endnode = undefined;
    }

    wait 0.65;
  }
}

func_3758(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11) {
  if((var_01 == self || var_01 == self.mgturret || isDefined(var_1.pers) && var_1.pers["team"] == self.team) && (var_01 != self.owner || var_04 == "MOD_MELEE")) {
    return;
  }
  var_12 = modifydamage(var_04, var_02, var_01);
  self vehicle_finishdamage(var_00, var_01, var_12, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11);
}

func_114D9() {
  self endon("death");
  self.damagetaken = 0;
  var_00 = self vehicle_getspeed();
  var_01 = self.health;
  var_02 = 0;
  var_03 = 0;
  var_04 = 0;

  for(;;) {
    self waittill("damage", var_05, var_06, var_07, var_08, var_09);

    if(isDefined(var_6.classname) && var_6.classname == "script_vehicle") {
      if(isDefined(self.besttarget) && self.besttarget != var_06) {
        self.func_72B8 = var_06;
        thread func_698D();
      }
    } else if(isplayer(var_06)) {
      var_06 scripts\mp\damagefeedback::updatedamagefeedback("hitHelicopter");

      if(var_06 scripts\mp\utility\game::_hasperk("specialty_armorpiercing")) {
        var_10 = var_05 * level.armorpiercingmod;
        self.health = self.health - int(var_10);
      }
    }

    if(self.health <= 0) {
      self notify("death");
      return;
    } else if(self.health < var_01 / 4 && var_04 == 0)
      var_04 = 1;
    else if(self.health < var_01 / 2 && var_03 == 0) {
      var_03 = 1;
    }
    else if(self.health < var_01 / 1.5 && var_02 == 0) {
      var_02 = 1;
    }

    if(var_05 > 1000) {
      func_89F2(var_06);
    }
  }
}

func_89F2(var_00) {
  self endon("death");
  var_01 = randomint(100);

  if(isDefined(self.besttarget) && self.besttarget != var_00 && var_01 > 30) {
    var_02 = [];
    var_2[0] = self.besttarget;
    func_698D(1, self.besttarget);
    thread func_1572(var_02);
  } else if(!isDefined(self.besttarget) && var_01 > 30) {
    var_02 = [];
    var_2[0] = var_00;
    thread func_1572(var_02);
  } else if(var_01 < 30) {
    playFX(level.func_114D8, self.origin);
    thread func_F6ED();
  } else {
    self fireweapon();
    self playSound("bmp_fire");
  }
}

func_89D4(var_00) {
  self endon("death");
  var_01 = relative_ads_anims(var_00);
  var_02 = distance(self.origin, var_0.origin);

  if(randomint(4) < 3) {
    return;
  }
  if(var_01 == "front" && var_02 < 768) {
    thread func_F6ED();
  }
  else if(var_01 == "rear_side" || var_01 == "rear" && var_02 >= 768) {
    playFX(level.func_114D8, self.origin);
    thread func_F6ED();
  } else if(var_01 == "rear" && var_02 < 768) {
    func_11097();
    func_F6ED();
    wait 4;
    func_11096();
  } else if(var_01 == "front_side" || var_01 == "front") {
    playFX(level.func_114D8, self.origin);
    func_11097();
    func_F6ED();
    wait 8;
    func_11096();
  }
}

relative_ads_anims(var_00) {
  self endon("death");
  var_00 endon("death");
  var_00 endon("disconnect");
  var_01 = anglesToForward(self.angles);
  var_02 = var_0.origin - self.origin;
  var_01 = var_01 * (1, 1, 0);
  var_02 = var_02 * (1, 1, 0);
  var_02 = vectornormalize(var_02);
  var_01 = vectornormalize(var_01);
  var_03 = vectordot(var_02, var_01);

  if(var_03 > 0) {
    if(var_03 > 0.9) {
      return "front";
    }
    else {
      return "front_side";
    }
  } else if(var_03 < -0.9)
    return "rear";
  else {
    return "rear_side";
  }

  var_00 iprintlnbold(var_03);
}

func_13A78() {
  self endon("death");

  for(;;) {
    var_00 = [];
    var_01 = level.players;

    foreach(var_03 in var_01) {
      if(!isDefined(var_03)) {
        wait 0.05;
        continue;
      }

      if(!istarget(var_03)) {
        wait 0.05;
        continue;
      }

      var_04 = var_03 getcurrentweapon();

      if(issubstr(var_04, "at4") || issubstr(var_04, "stinger") || issubstr(var_04, "javelin")) {
        thread func_89D4(var_03);
        wait 8;
      }

      wait 0.15;
    }
  }
}

func_3E2E() {
  if(!isDefined(self.owner) || !isDefined(self.owner.pers["team"]) || self.owner.pers["team"] != self.team) {
    self notify("abandoned");
    return 0;
  }

  return 1;
}

modifydamage(var_00, var_01, var_02) {
  if(var_00 == "MOD_RIFLE_BULLET") {
    return var_01;
  }
  else if(var_00 == "MOD_PISTOL_BULLET") {
    return var_01;
  }
  else if(var_00 == "MOD_IMPACT") {
    return var_01;
  }
  else if(var_00 == "MOD_MELEE") {
    return 0;
  }
  else if(var_00 == "MOD_EXPLOSIVE_BULLET") {
    return var_01;
  }
  else if(var_00 == "MOD_GRENADE") {
    return var_01 * 5;
  }
  else if(var_00 == "MOD_GRENADE_SPLASH") {
    return var_01 * 5;
  }
  else {
    return var_01 * 10;
  }
}

func_5329() {
  self waittill("death");

  if(level.teambased) {
    var_00 = level.func_114B1.team;

    if(level.func_114B1.objid[var_00] != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_state(level.func_114B1.objid[var_00], "invisible");
    }

    if(level.func_114B1.objid[level.otherteam[var_00]] != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_state(level.func_114B1.objid[level.otherteam[var_00]], "invisible");
    }
  }

  self notify("tankDestroyed");
  self vehicle_setspeed(0, 10, 10);
  level.func_114E2 = 0;
  playFX(level.func_10888, self.origin);
  playFX(level.func_114DD, self.origin);
  func_E11C();
  var_01 = spawn("script_model", self.origin);
  var_01 setModel("vehicle_m1a1_abrams_d_static");
  var_1.angles = self.angles;
  self.mgturret delete();
  self delete();
  wait 4;
  var_01 delete();
}

func_C53C() {
  self notify("onTargOrTimeOut");
  self endon("onTargOrTimeOut");
  self endon("turret_on_target");
  self waittill("turret_pitch_clamped");
  thread func_698D(0, self.besttarget);
}

fireontarget() {
  self endon("abandonedTarget");
  self endon("killedTarget");
  self endon("death");
  self endon("targetRemoved");
  self endon("lostLOS");

  for(;;) {
    func_C53C();

    if(!isDefined(self.besttarget)) {
      continue;
    }
    var_00 = self gettagorigin("tag_flash");
    var_01 = bulletTrace(self.origin, var_00, 0, self);

    if(var_1["position"] != var_00) {
      thread func_698D(0, self.besttarget);
    }

    var_01 = bulletTrace(var_00, self.besttarget.origin, 1, self);
    var_02 = distance(self.origin, var_1["position"]);
    var_03 = distance(self.besttarget.origin, self.origin);

    if(var_02 < 384 || var_02 + 256 < var_03) {
      wait 0.5;

      if(var_02 > 384) {
        func_136F4();
        self fireweapon();
        self playSound("bmp_fire");
        self.func_118F3 = gettime();
      }

      var_04 = relative_ads_anims(self.besttarget);
      thread func_698D(0, self.besttarget);
      return;
    }

    func_136F4();
    self fireweapon();
    self playSound("bmp_fire");
    self.func_118F3 = gettime();
  }
}

func_136F4() {
  self endon("abandonedTarget");
  self endon("killedTarget");
  self endon("death");
  self endon("targetRemoved");
  self endon("lostLOS");
  var_00 = gettime() - self.func_118F3;

  if(var_00 < 1499) {
    wait(1.5 - var_00 / 1000);
  }
}

func_114E1(var_00) {
  self endon("death");
  self endon("leaving");
  var_01 = [];

  for(;;) {
    var_01 = [];
    var_02 = level.players;

    if(isDefined(self.func_72B8)) {
      var_01 = [];
      var_1[0] = self.func_72B8;
      func_1572(var_01);
      self.func_72B8 = undefined;
    }

    if(isDefined(level.harrier) && level.harrier.team != self.team && isalive(level.harrier)) {
      if(func_9FF1(level.func_114B1)) {
        var_1[var_1.size] = level.func_114B1;
      }
    }

    if(isDefined(level.chopper) && level.chopper.team != self.team && isalive(level.chopper)) {
      if(func_9FF1(level.chopper)) {
        var_1[var_1.size] = level.chopper;
      }
    }

    foreach(var_04 in var_02) {
      if(!isDefined(var_04)) {
        wait 0.05;
        continue;
      }

      if(isDefined(var_00) && var_04 == var_00) {
        continue;
      }
      if(istarget(var_04)) {
        if(isDefined(var_04)) {
          var_1[var_1.size] = var_04;
        }

        continue;
      }

      continue;
    }

    if(var_1.size > 0) {
      func_1572(var_01);
      continue;
    }

    wait 1;
  }
}

func_1572(var_00) {
  self endon("death");

  if(var_0.size == 1) {
    self.besttarget = var_0[0];
  }
  else {
    self.besttarget = getbesttarget(var_00);
  }

  thread func_F6E3();
  thread func_13B74(var_00);
  self setturrettargetent(self.besttarget);
  fireontarget();
  thread func_F7B8();
}

func_F7B8() {
  self endon("death");
  setstate();
  removetargetmarkergroup();
  self setturrettargetent(self.func_BEF5);
}

getbesttarget(var_00) {
  self endon("death");
  var_01 = self gettagorigin("tag_flash");
  var_02 = self.origin;
  var_03 = undefined;
  var_04 = undefined;
  var_05 = 0;

  foreach(var_07 in var_00) {
    var_08 = abs(vectortoangles(var_7.origin - self.origin)[1]);
    var_09 = abs(self gettagangles("tag_flash")[1]);
    var_08 = abs(var_08 - var_09);

    if(isDefined(level.chopper) && var_07 == level.chopper) {
      return var_07;
    }

    if(isDefined(level.harrier) && var_07 == level.harrier) {
      return var_07;
    }

    var_10 = var_07 getweaponlistitems();

    foreach(var_12 in var_10) {
      if(issubstr(var_12, "at4") || issubstr(var_12, "jav") || issubstr(var_12, "c4")) {
        var_08 = var_08 - 40;
      }
    }

    if(!isDefined(var_03)) {
      var_03 = var_08;
      var_04 = var_07;
      continue;
    }

    if(var_03 > var_08) {
      var_03 = var_08;
      var_04 = var_07;
    }
  }

  return var_04;
}

func_13B74(var_00) {
  self endon("abandonedTarget");
  self endon("lostLOS");
  self endon("death");
  self endon("targetRemoved");
  var_01 = self.besttarget;
  var_01 endon("disconnect");
  var_01 waittill("death");
  self notify("killedTarget");
  removetargetmarkergroup();
  setstate();
  thread func_F7B8();
}

func_698D(var_00, var_01) {
  self endon("death");
  self notify("abandonedTarget");
  setstate();
  thread func_F7B8();
  removetargetmarkergroup();

  if(isDefined(var_01)) {
    self.func_275E = var_01;
    func_275F();
  }

  if(isDefined(var_00) && var_00) {
    return;
  }
  return;
}

func_275F() {
  self endon("death");
  wait 1.5;
  self.func_275E = undefined;
}

removetargetmarkergroup() {
  self notify("targetRemoved");
  self.besttarget = undefined;
  self.func_A9AF = undefined;
}

func_9FF1(var_00) {
  if(distance2d(var_0.origin, self.origin) > 4096) {
    return 0;
  }

  if(distance(var_0.origin, self.origin) < 512) {
    return 0;
  }

  return func_12A8F(var_00, 0);
}

istarget(var_00) {
  self endon("death");
  var_01 = distancesquared(var_0.origin, self.origin);

  if(!level.teambased && isDefined(self.owner) && var_00 == self.owner) {
    return 0;
  }

  if(!isalive(var_00) || var_0.sessionstate != "playing") {
    return 0;
  }

  if(var_01 > 16777216) {
    return 0;
  }

  if(var_01 < 262144) {
    return 0;
  }

  if(!isDefined(var_0.pers["team"])) {
    return 0;
  }

  if(var_00 == self.owner) {
    return 0;
  }

  if(level.teambased && var_0.pers["team"] == self.team) {
    return 0;
  }

  if(var_0.pers["team"] == "spectator") {
    return 0;
  }

  if(isDefined(var_0.spawntime) && (gettime() - var_0.spawntime) / 1000 <= 5) {
    return 0;
  }

  if(var_00 scripts\mp\utility\game::_hasperk("specialty_blindeye")) {
    return 0;
  }

  return self vehicle_canturrettargetpoint(var_0.origin, 1, self);
}

func_12A8F(var_00, var_01) {
  var_02 = var_00 sightconetrace(self gettagorigin("tag_turret"), self);

  if(var_02 < 0.7) {
    return 0;
  }

  if(isDefined(var_01) && var_01) {
    thread scripts\mp\utility\game::drawline(var_0.origin, self gettagorigin("tag_turret"), 10, (1, 0, 0));
  }

  return 1;
}

func_9EA1(var_00) {
  self endon("death");

  if(!isalive(var_00) || var_0.sessionstate != "playing") {
    return 0;
  }

  if(!isDefined(var_0.pers["team"])) {
    return 0;
  }

  if(var_00 == self.owner) {
    return 0;
  }

  if(distancesquared(var_0.origin, self.origin) > 1048576) {
    return 0;
  }

  if(level.teambased && var_0.pers["team"] == self.team) {
    return 0;
  }

  if(var_0.pers["team"] == "spectator") {
    return 0;
  }

  if(isDefined(var_0.spawntime) && (gettime() - var_0.spawntime) / 1000 <= 5) {
    return 0;
  }

  if(isDefined(self)) {
    var_01 = self.mgturret.origin + (0, 0, 64);
    var_02 = var_00 sightconetrace(var_01, self);

    if(var_02 < 1) {
      return 0;
    }
  }

  return 1;
}

func_114DF() {
  self endon("death");
  self endon("leaving");
  var_00 = [];

  for(;;) {
    var_00 = [];
    var_01 = level.players;

    for(var_02 = 0; var_02 <= var_1.size; var_2++) {
      if(func_9EA1(var_1[var_02])) {
        if(isDefined(var_1[var_02])) {
          var_0[var_0.size] = var_1[var_02];
        }
      } else
        continue;

      wait 0.05;
    }

    if(var_0.size > 0) {
      func_1571(var_00);
      return;
    } else
      wait 0.5;
  }
}

func_7DFD(var_00) {
  self endon("death");
  var_01 = self.origin;
  var_02 = undefined;
  var_03 = undefined;

  foreach(var_05 in var_00) {
    var_06 = distance(self.origin, var_5.origin);
    var_07 = var_05 getcurrentweapon();

    if(issubstr(var_07, "at4") || issubstr(var_07, "jav") || issubstr(var_07, "c4") || issubstr(var_07, "smart") || issubstr(var_07, "grenade")) {
      var_06 = var_06 - 200;
    }

    if(!isDefined(var_02)) {
      var_02 = var_06;
      var_03 = var_05;
      continue;
    }

    if(var_02 > var_06) {
      var_02 = var_06;
      var_03 = var_05;
    }
  }

  return var_03;
}

func_1571(var_00) {
  self endon("death");

  if(var_0.size == 1) {
    self.func_2A97 = var_0[0];
  }
  else {
    self.func_2A97 = func_7DFD(var_00);
  }

  if(distance2d(self.origin, self.func_2A97.origin) > 768) {
    thread func_F799();
  }

  self notify("acquiringMiniTarget");
  self.mgturret settargetentity(self.func_2A97, (0, 0, 64));
  wait 0.15;
  thread func_6D74();
  thread func_13AD1(var_00);
  thread func_13AD2(var_00);
  thread func_13AD3(self.func_2A97);
}

func_6D74() {
  self endon("death");
  self endon("abandonedMiniTarget");
  self endon("killedMiniTarget");
  var_00 = undefined;
  var_01 = gettime();

  if(!isDefined(self.func_2A97)) {
    return;
  }
  for(;;) {
    if(!isDefined(self.mgturret getturrettarget(1))) {
      if(!isDefined(var_00)) {
        var_00 = gettime();
      }

      var_02 = gettime();

      if(var_00 - var_02 > 1) {
        var_00 = undefined;
        thread func_698C();
        return;
      }

      wait 0.5;
      continue;
    }

    if(gettime() > var_01 + 1000 && !isDefined(self.besttarget)) {
      if(distance2d(self.origin, self.func_2A97.origin) > 768) {
        var_3[0] = self.func_2A97;
        func_1572(var_03);
      }
    }

    var_04 = randomintrange(10, 16);

    for(var_05 = 0; var_05 < var_04; var_5++) {
      self.mgturret shootturret();
      wait 0.1;
    }

    wait(randomfloatrange(0.5, 3.0));
  }
}

func_13AD1(var_00) {
  self endon("abandonedMiniTarget");
  self endon("death");

  if(!isDefined(self.func_2A97)) {
    return;
  }
  self.func_2A97 waittill("death");
  self notify("killedMiniTarget");
  self.func_2A97 = undefined;
  self.mgturret cleartargetentity();
  func_114DF();
}

func_13AD2(var_00) {
  self endon("abandonedMiniTarget");
  self endon("death");

  for(;;) {
    if(!isDefined(self.func_2A97)) {
      return;
    }
    var_01 = bulletTrace(self.mgturret.origin, self.func_2A97.origin, 0, self);
    var_02 = distance(self.origin, var_1["position"]);

    if(var_02 > 1024) {
      thread func_698C();
      return;
    }

    wait 2;
  }
}

func_13AD3(var_00) {
  self endon("abandonedMiniTarget");
  self endon("death");
  self endon("killedMiniTarget");

  for(;;) {
    var_01 = [];
    var_02 = level.players;

    for(var_03 = 0; var_03 <= var_2.size; var_3++) {
      if(func_9EA1(var_2[var_03])) {
        if(!isDefined(var_2[var_03])) {
          continue;
        }
        if(!isDefined(var_00)) {
          return;
        }
        var_04 = distance(self.origin, var_0.origin);
        var_05 = distance(self.origin, var_2[var_03].origin);

        if(var_05 < var_04) {
          thread func_698C();
          return;
        }
      }

      wait 0.05;
    }

    wait 0.25;
  }
}

func_698C(var_00) {
  self notify("abandonedMiniTarget");
  self.func_2A97 = undefined;
  self.mgturret cleartargetentity();

  if(isDefined(var_00) && var_00) {
    return;
  }
  thread func_114DF();
  return;
}

func_185E() {
  level.func_114E3[self getentitynumber()] = self;
}

func_E11C() {
  level.func_114E3[self getentitynumber()] = undefined;
}

getnodenearenemies() {
  var_00 = [];

  foreach(var_02 in level.players) {
    if(var_2.team == "spectator") {
      continue;
    }
    if(var_2.team == self.team) {
      continue;
    }
    if(!isalive(var_02)) {
      continue;
    }
    var_2.func_56E8 = 0;
    var_0[var_0.size] = var_02;
  }

  if(!var_0.size) {
    return undefined;
  }

  for(var_04 = 0; var_04 < var_0.size; var_4++) {
    for(var_05 = var_04 + 1; var_05 < var_0.size; var_5++) {
      var_06 = distancesquared(var_0[var_04].origin, var_0[var_05].origin);
      var_0[var_04].func_56E8 = var_0[var_04].func_56E8 + var_06;
      var_0[var_05].func_56E8 = var_0[var_05].func_56E8 + var_06;
    }
  }

  var_07 = var_0[0];

  foreach(var_02 in var_00) {
    if(var_2.func_56E8 < var_7.func_56E8) {
      var_07 = var_02;
    }
  }

  var_10 = var_7.origin;
  var_11 = sortbydistance(level._meth_848E, var_10);
  return var_11[0];
}

func_FAD8() {
  var_00 = [];
  var_01 = [];
  var_02 = [];
  var_03 = [];
  var_04 = getvehiclenode("startnode", "targetname");
  var_0[var_0.size] = var_04;
  var_1[var_1.size] = var_04;

  while(isDefined(var_4.target)) {
    var_05 = var_04;
    var_04 = getvehiclenode(var_4.target, "targetname");
    var_4.func_D886 = var_05;

    if(var_04 == var_0[0]) {
      break;
    }
    var_0[var_0.size] = var_04;

    if(!isDefined(var_4.target)) {
      return;
    }
  }

  var_0[0].func_2F45 = [];
  var_0[0] thread func_897F("forward");
  var_3[var_3.size] = var_0[0];
  var_06 = getvehiclenodearray("branchnode", "targetname");

  foreach(var_08 in var_06) {
    var_04 = var_08;
    var_0[var_0.size] = var_04;
    var_1[var_1.size] = var_04;

    while(isDefined(var_4.target)) {
      var_05 = var_04;
      var_04 = getvehiclenode(var_4.target, "targetname");
      var_0[var_0.size] = var_04;
      var_4.func_D886 = var_05;

      if(!isDefined(var_4.target)) {
        var_2[var_2.size] = var_04;
      }
    }
  }

  foreach(var_04 in var_00) {
    var_11 = 0;

    foreach(var_13 in var_01) {
      if(var_13 == var_04) {
        continue;
      }
      if(var_13.target == var_4.targetname) {
        continue;
      }
      if(isDefined(var_4.target) && var_4.target == var_13.targetname) {
        continue;
      }
      if(distance2d(var_4.origin, var_13.origin) > 80) {
        continue;
      }
      var_13 thread func_8982(var_04, "reverse");
      var_13.func_D886 = var_04;

      if(!isDefined(var_4.func_2F45)) {
        var_4.func_2F45 = [];
      }

      var_4.func_2F45[var_4.func_2F45.size] = var_13;
      var_11 = 1;
    }

    if(var_11) {
      var_04 thread func_897F("forward");
    }

    var_15 = 0;

    foreach(var_17 in var_02) {
      if(var_17 == var_04) {
        continue;
      }
      if(!isDefined(var_4.target)) {
        continue;
      }
      if(var_4.target == var_17.targetname) {
        continue;
      }
      if(isDefined(var_17.target) && var_17.target == var_4.targetname) {
        continue;
      }
      if(distance2d(var_4.origin, var_17.origin) > 80) {
        continue;
      }
      var_17 thread func_8982(var_04, "forward");
      var_17.func_BF2E = getvehiclenode(var_4.targetname, "targetname");
      var_17.func_AB5D = distance(var_17.origin, var_4.origin);

      if(!isDefined(var_4.func_2F45)) {
        var_4.func_2F45 = [];
      }

      var_4.func_2F45[var_4.func_2F45.size] = var_17;
      var_15 = 1;
    }

    if(var_15) {
      var_04 thread func_897F("reverse");
    }

    if(var_15 || var_11) {
      var_3[var_3.size] = var_04;
    }
  }

  if(var_3.size < 3) {
    level notify("end_tankPathHandling");
    return;
  }

  var_20 = [];

  foreach(var_04 in var_00) {
    if(!isDefined(var_4.func_2F45)) {
      continue;
    }
    var_20[var_20.size] = var_04;
  }

  foreach(var_24 in var_20) {
    var_04 = var_24;
    var_25 = 0;

    while(isDefined(var_4.target)) {
      var_26 = var_04;
      var_04 = getvehiclenode(var_4.target, "targetname");
      var_25 = var_25 + distance(var_4.origin, var_26.origin);

      if(var_04 == var_24) {
        break;
      }
      if(isDefined(var_4.func_2F45)) {
        break;
      }
    }

    if(var_25 > 1000) {
      var_04 = var_24;
      var_27 = 0;

      while(isDefined(var_4.target)) {
        var_26 = var_04;
        var_04 = getvehiclenode(var_4.target, "targetname");
        var_27 = var_27 + distance(var_4.origin, var_26.origin);

        if(var_27 < var_25 / 2) {
          continue;
        }
        var_4.func_2F45 = [];
        var_04 thread func_897F("forward");
        var_3[var_3.size] = var_04;
        break;
      }
    }
  }

  level._meth_848E = func_98A6(var_03);

  foreach(var_04 in var_00) {
    if(!isDefined(var_4._meth_848D)) {
      var_04 thread func_C059();
    }
  }
}

dontinterpolate(var_00) {
  var_01 = [];

  foreach(var_04, var_03 in self.func_AD40) {
    if(self.func_AD17[var_04] != var_00) {
      continue;
    }
    var_1[var_1.size] = var_03;
  }

  return var_1[randomint(var_1.size)];
}

func_7FE9(var_00, var_01) {
  var_02 = level._meth_848E[self._meth_848D];
  var_03 = func_7732(var_02, var_00, undefined, var_01);
  var_04 = var_3[0].func_7646;
  var_05 = func_7732(var_02, var_00, undefined, level.func_C74A[var_01]);
  var_06 = var_5[0].func_7646;

  if(!getdvarint("tankDebug")) {
    var_06 = 9999999;
  }

  if(var_04 <= var_06) {
    return var_3[1];
  }
}

func_897F(var_00) {
  level endon("end_tankPathHandling");

  for(;;) {
    self waittill("trigger", var_01, var_02);
    var_03 = level._meth_848E[self._meth_848D];
    var_1.node = self;
    var_04 = undefined;

    if(isDefined(var_1.endnode) && var_1.endnode != var_03) {
      var_04 = func_7FE9(var_1.endnode, var_1.veh_pathdir);

      if(!isDefined(var_04)) {
        var_01 thread func_F6C4(level.func_C74A[var_1.veh_pathdir]);
      }
    }

    if(!isDefined(var_04) || var_04 == var_03) {
      var_04 = var_03 dontinterpolate(var_1.veh_pathdir);
    }

    var_05 = var_3.func_AD41[var_4._meth_848D];

    if(var_1.veh_pathdir == "forward") {
      var_06 = func_7FE8();
    }
    else {
      var_06 = _meth_809A();
    }

    if(var_06 != var_05) {
      var_01 startpath(var_05);
    }
  }
}

func_8982(var_00, var_01) {
  for(;;) {
    self waittill("trigger", var_02);

    if(var_2.veh_pathdir != var_01) {
      continue;
    }
    func_4F52("tank starting path at join node: " + var_0._meth_848D);
    var_02 startpath(var_00);
  }
}

func_C059() {
  self.func_7334 = func_7EC4()._meth_848D;
  self.func_E492 = _meth_80EF()._meth_848D;

  for(;;) {
    self waittill("trigger", var_00, var_01);
    var_0.node = self;
    var_0.func_7334 = self.func_7334;
    var_0.func_E492 = self.func_E492;

    if(!isDefined(self.target) || self.targetname == "branchnode") {
      var_02 = "TRANS";
    }
    else {
      var_02 = "NODE";
    }

    if(isDefined(var_01)) {
      func_4F50(self.origin, var_02, (1, 0.5, 0), 1, 2, 100);
      continue;
    }

    func_4F50(self.origin, var_02, (0, 1, 0), 1, 2, 100);
  }
}

func_72EA(var_00, var_01, var_02) {
  var_01 endon("trigger");
  var_00 endon("trigger");
  var_02 endon("death");
  var_03 = distancesquared(var_2.origin, var_1.origin);
  var_04 = var_2.veh_pathdir;
  func_4F50(var_0.origin + (0, 0, 30), "LAST", (0, 0, 1), 0.5, 1, 100);
  func_4F50(var_1.origin + (0, 0, 60), "NEXT", (0, 1, 0), 0.5, 1, 100);
  var_05 = 0;

  for(;;) {
    wait 0.05;

    if(var_04 != var_2.veh_pathdir) {
      func_4F52("tank missed node: reversing direction");
      var_02 thread func_72EA(var_01, var_00, var_02);
      return;
    }

    if(var_05) {
      func_4F52("... sending notify.");
      var_01 notify("trigger", var_02, 1);
      return;
    }

    var_06 = distancesquared(var_2.origin, var_1.origin);

    if(var_06 > var_03) {
      var_05 = 1;
      func_4F52("tank missed node: forcing notify in one frame...");
    }

    var_03 = var_06;
  }
}

func_7EC4() {
  for(var_00 = self; !isDefined(var_0._meth_848D); var_00 = var_00 func_7FE8()) {}

  return var_00;
}

_meth_80EF() {
  for(var_00 = self; !isDefined(var_0._meth_848D); var_00 = var_00 _meth_809A()) {}

  return var_00;
}

func_7FE8() {
  if(isDefined(self.target)) {
    return getvehiclenode(self.target, "targetname");
  }
  else {
    return self.func_BF2E;
  }
}

_meth_809A() {
  return self.func_D886;
}

func_98A6(var_00) {
  var_01 = [];

  foreach(var_03 in var_00) {
    var_04 = spawnStruct();
    var_4.func_AD35 = [];
    var_4.func_AD40 = [];
    var_4.func_AD36 = [];
    var_4.func_AD17 = [];
    var_4.func_AD41 = [];
    var_4.node = var_03;
    var_4.origin = var_3.origin;
    var_4._meth_848D = var_1.size;
    var_3._meth_848D = var_1.size;
    func_4F50(var_4.origin + (0, 0, 80), var_4._meth_848D, (1, 1, 1), 0.65, 2, 100000);
    var_1[var_1.size] = var_04;
  }

  foreach(var_03 in var_00) {
    var_07 = var_3._meth_848D;
    var_08 = getvehiclenode(var_3.target, "targetname");
    var_09 = distance(var_3.origin, var_8.origin);
    var_10 = var_08;

    while(!isDefined(var_8._meth_848D)) {
      var_09 = var_09 + distance(var_8.origin, var_8.func_D886.origin);

      if(isDefined(var_8.target)) {
        var_08 = getvehiclenode(var_8.target, "targetname");
        continue;
      }

      var_08 = var_8.func_BF2E;
    }

    var_1[var_07] func_17EC(var_1[var_8._meth_848D], var_09, "forward", var_10);
    var_08 = var_3.func_D886;
    var_09 = distance(var_3.origin, var_8.origin);

    for(var_10 = var_08; !isDefined(var_8._meth_848D); var_08 = var_8.func_D886) {
      var_09 = var_09 + distance(var_8.origin, var_8.func_D886.origin);
    }

    var_1[var_07] func_17EC(var_1[var_8._meth_848D], var_09, "reverse", var_10);

    foreach(var_12 in var_3.func_2F45) {
      var_08 = var_12;
      var_09 = distance(var_3.origin, var_8.origin);
      var_10 = var_08;

      if(var_8.targetname == "branchnode") {
        while(!isDefined(var_8._meth_848D)) {
          if(isDefined(var_8.target)) {
            var_13 = getvehiclenode(var_8.target, "targetname");
          }
          else {
            var_13 = var_8.func_BF2E;
          }

          var_09 = var_09 + distance(var_8.origin, var_13.origin);
          var_08 = var_13;
        }

        var_1[var_07] func_17EC(var_1[var_8._meth_848D], var_09, "forward", var_10);
        continue;
      }

      while(!isDefined(var_8._meth_848D)) {
        var_09 = var_09 + distance(var_8.origin, var_8.func_D886.origin);
        var_08 = var_8.func_D886;
      }

      var_1[var_07] func_17EC(var_1[var_8._meth_848D], var_09, "reverse", var_10);
    }
  }

  return var_01;
}

func_17EC(var_00, var_01, var_02, var_03) {
  self.func_AD40[var_0._meth_848D] = var_00;
  self.func_AD36[var_0._meth_848D] = var_01;
  self.func_AD17[var_0._meth_848D] = var_02;
  self.func_AD41[var_0._meth_848D] = var_03;
  var_04 = spawnStruct();
  var_4.func_119D3 = var_00;
  var_4.func_119D2 = var_0._meth_848D;
  var_4.func_AB5D = var_01;
  var_4.func_00F2 = var_02;
  var_4.func_10DCD = var_03;
  self.func_AD35[var_0._meth_848D] = var_04;
}

func_7732(var_00, var_01, var_02, var_03) {
  level.func_C62D = [];
  level.func_428F = [];
  var_04 = 0;
  var_05 = [];

  if(!isDefined(var_02)) {
    var_02 = [];
  }

  var_1.func_7646 = 0;
  var_1.func_877B = func_7F0A(var_01, var_00);
  var_1.func_6A62 = var_1.func_7646 + var_1.func_877B;
  func_184C(var_01);
  var_06 = var_01;

  for(;;) {
    foreach(var_09, var_08 in var_6.func_AD40) {
      if(scripts\engine\utility::array_contains(var_02, var_08)) {
        continue;
      }
      if(scripts\engine\utility::array_contains(level.func_428F, var_08)) {
        continue;
      }
      if(isDefined(var_03) && var_8.func_AD17[var_6._meth_848D] != var_03) {
        continue;
      }
      if(!scripts\engine\utility::array_contains(level.func_C62D, var_08)) {
        addtoopenlist(var_08);
        var_8.func_C8F6 = var_06;
        var_8.func_7646 = func_7EED(var_08, var_06);
        var_8.func_877B = func_7F0A(var_08, var_00);
        var_8.func_6A62 = var_8.func_7646 + var_8.func_877B;

        if(var_08 == var_00) {
          var_04 = 1;
        }

        continue;
      }

      if(var_8.func_7646 < func_7EED(var_06, var_08)) {
        continue;
      }
      var_8.func_C8F6 = var_06;
      var_8.func_7646 = func_7EED(var_08, var_06);
      var_8.func_6A62 = var_8.func_7646 + var_8.func_877B;
    }

    if(var_04) {
      break;
    }
    func_184C(var_06);
    var_10 = level.func_C62D[0];

    foreach(var_12 in level.func_C62D) {
      if(var_12.func_6A62 > var_10.func_6A62) {
        continue;
      }
      var_10 = var_12;
    }

    func_184C(var_10);
    var_06 = var_10;
  }

  for(var_06 = var_00; var_06 != var_01; var_06 = var_6.func_C8F6) {
    var_5[var_5.size] = var_06;
  }

  var_5[var_5.size] = var_06;
  return var_05;
}

addtoopenlist(var_00) {
  var_0.func_C62E = level.func_C62D.size;
  level.func_C62D[level.func_C62D.size] = var_00;
  var_0.func_4290 = undefined;
}

func_184C(var_00) {
  if(isDefined(var_0.func_4290)) {
    return;
  }
  var_0.func_4290 = level.func_428F.size;
  level.func_428F[level.func_428F.size] = var_00;

  if(!scripts\engine\utility::array_contains(level.func_C62D, var_00)) {
    return;
  }
  level.func_C62D[var_0.func_C62E] = level.func_C62D[level.func_C62D.size - 1];
  level.func_C62D[var_0.func_C62E].func_C62E = var_0.func_C62E;
  level.func_C62D[level.func_C62D.size - 1] = undefined;
  var_0.func_C62E = undefined;
}

func_7F0A(var_00, var_01) {
  return distance(var_0.node.origin, var_1.node.origin);
}

func_7EED(var_00, var_01) {
  return var_0.func_C8F6.func_7646 + var_0.func_AD36[var_1._meth_848D];
}

drawpath(var_00) {
  for(var_01 = 1; var_01 < var_0.size; var_1++) {
    var_02 = var_0[var_01 - 1];
    var_03 = var_0[var_01];

    if(var_2.func_AD17[var_3._meth_848D] == "reverse") {
      level thread func_5B7C(var_2.node.origin, var_3.node.origin, (1, 0, 0));
    }
    else {
      level thread func_5B7C(var_2.node.origin, var_3.node.origin, (0, 1, 0));
    }

    var_04 = var_2.func_AD41[var_3._meth_848D];
    level thread func_5B7C(var_2.node.origin + (0, 0, 4), var_4.origin + (0, 0, 4), (0, 0, 1));

    if(var_2.func_AD17[var_3._meth_848D] == "reverse") {
      while(!isDefined(var_4._meth_848D)) {
        var_05 = var_04;
        var_04 = var_4.func_D886;
        level thread func_5B7C(var_5.origin + (0, 0, 4), var_4.origin + (0, 0, 4), (0, 1, 1));
      }

      continue;
    }

    while(!isDefined(var_4._meth_848D)) {
      var_05 = var_04;

      if(isDefined(var_4.target)) {
        var_04 = getvehiclenode(var_4.target, "targetname");
      }
      else {
        var_04 = var_4.func_BF2E;
      }

      level thread func_5B7C(var_5.origin + (0, 0, 4), var_4.origin + (0, 0, 4), (0, 1, 1));
    }
  }
}

drawgraph(var_00) {}

func_5B7C(var_00, var_01, var_02) {
  level endon("endpath");

  for(;;) {
    wait 0.05;
  }
}

func_4F52(var_00) {}

debugprint(var_00) {}

func_4F50(var_00, var_01, var_02, var_03, var_04, var_05) {}

func_5B8B() {}