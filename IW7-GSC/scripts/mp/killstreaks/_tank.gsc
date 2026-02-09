/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_tank.gsc
*********************************************/

init() {}

func_1082D(var_0, var_1, var_2) {
  var_3 = self global_physics_sound_monitor("tank", var_0);
  var_3.health = 3000;
  var_3.var_11568 = 1;
  var_3.team = var_0.team;
  var_3.pers["team"] = var_3.team;
  var_3.owner = var_0;
  var_3 setCanDamage(1);
  var_3.var_10B68 = 12;
  var_3 thread deletepentsonrespawn();
  var_3 func_185E();
  var_3.damagecallback = ::func_3758;
  return var_3;
}

deletepentsonrespawn() {
  self endon("death");
  var_0 = self.origin[2];
  for(;;) {
    if(var_0 - self.origin[2] > 2048) {
      self.health = 0;
      self notify("death");
      return;
    }

    wait(1);
  }
}

func_130E4(var_0) {
  return func_12907();
}

func_12907() {
  if(isDefined(level.var_114E2) && level.var_114E2) {
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
    var_0 = level.var_114E5["allies"] func_1082D(self, "vehicle_bradley");
  } else {
    var_0 = level.var_114E5["axis"] func_1082D(self, "vehicle_bmp");
  }

  var_0 func_10DF8();
  return 1;
}

func_10DF8(var_0) {
  var_1 = getvehiclenode("startnode", "targetname");
  var_2 = getvehiclenode("waitnode", "targetname");
  self.nodes = getvehiclenodearray("info_vehicle_node", "classname");
  level.var_114E2 = 1;
  thread func_114E9(var_1, var_2);
  thread func_114D9();
  level.var_114B1 = self;
  if(level.teambased) {
    var_3 = scripts\mp\objidpoolmanager::requestminimapid(1);
    if(var_3 != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_add(var_3, "invisible", (0, 0, 0));
      scripts\mp\objidpoolmanager::minimap_objective_team(var_3, "allies");
    }

    level.var_114B1.objid["allies"] = var_3;
    var_4 = scripts\mp\objidpoolmanager::requestminimapid(1);
    if(var_4 != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_add(var_4, "invisible", (0, 0, 0));
      scripts\mp\objidpoolmanager::minimap_objective_team(var_4, "axis");
    }

    level.var_114B1.objid["axis"] = var_4;
    var_5 = self.team;
    level.var_114B1.team = var_5;
    level.var_114B1.pers["team"] = var_5;
  }

  var_6 = spawnturret("misc_turret", self.origin, "abrams_minigun_mp");
  var_6 linkto(self, "tag_engine_left", (0, 0, -20), (0, 0, 0));
  var_6 setModel("sentry_minigun");
  var_6.angles = self.angles;
  var_6.owner = self.owner;
  var_6 getvalidattachments();
  self.mgturret = var_6;
  self.mgturret setdefaultdroppitch(0);
  var_7 = self.angles;
  self.angles = (0, 0, 0);
  var_8 = self gettagorigin("tag_flash");
  self.angles = var_7;
  var_9 = var_8 - self.origin;
  thread func_136B0();
  thread func_136B8();
  self.var_118F3 = gettime();
  var_10 = spawn("script_origin", self gettagorigin("tag_flash"));
  var_10 linkto(self, "tag_origin", var_9, (0, 0, 0));
  var_10 hide();
  self.var_BEF5 = var_10;
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

func_F6C4(var_0) {
  if(self.var_376 != var_0) {
    if(var_0 == "forward") {
      func_11096();
      return;
    }

    func_11097();
  }
}

func_F6E3() {
  self endon("death");
  self notify("path_abandoned");
  while(isDefined(self.changingdirection)) {
    wait(0.05);
  }

  var_0 = 2;
  self vehicle_setspeed(var_0, 10, 10);
  self.var_109C6 = "engage";
}

func_F799() {
  self endon("death");
  self notify("path_abandoned");
  while(isDefined(self.changingdirection)) {
    wait(0.05);
  }

  var_0 = 2;
  self vehicle_setspeed(var_0, 10, 10);
  self.var_109C6 = "engage";
}

setstate() {
  self endon("death");
  while(isDefined(self.changingdirection)) {
    wait(0.05);
  }

  self vehicle_setspeed(self.var_10B68, 10, 10);
  self.var_109C6 = "standard";
}

func_F6ED() {
  self endon("death");
  while(isDefined(self.changingdirection)) {
    wait(0.05);
  }

  self vehicle_setspeed(15, 15, 15);
  self.var_109C6 = "evade";
  wait(1.5);
  self vehicle_setspeed(self.var_10B68, 10, 10);
}

func_F6B0() {
  self endon("death");
  while(isDefined(self.changingdirection)) {
    wait(0.05);
  }

  self vehicle_setspeed(5, 5, 5);
  self.var_109C6 = "danger";
}

func_11097() {
  func_4F52("tank changing direction at " + gettime());
  self vehicle_setspeed(0, 5, 6);
  self.changingdirection = 1;
  while(self.var_37A > 0) {
    wait(0.05);
  }

  wait(0.25);
  self.changingdirection = undefined;
  func_4F52("tank done changing direction");
  self.var_37D = "reverse";
  self.var_376 = "reverse";
  self vehicle_setspeed(self.var_10B68, 5, 6);
}

func_11096() {
  func_4F52("tank changing direction at " + gettime());
  self vehicle_setspeed(0, 5, 6);
  self.changingdirection = 1;
  while(self.var_37A > 0) {
    wait(0.05);
  }

  wait(0.25);
  self.changingdirection = undefined;
  func_4F52("tank done changing direction");
  self.var_37D = "forward";
  self.var_376 = "forward";
  self vehicle_setspeed(self.var_10B68, 5, 6);
}

func_3E02() {
  self endon("death");
  var_0 = [];
  var_1 = level.players;
  self.var_C225 = 0;
  for(;;) {
    foreach(var_3 in var_1) {
      if(!isDefined(var_3)) {
        continue;
      }

      if(var_3.team == self.team) {
        wait(0.05);
        continue;
      }

      var_4 = distance2d(var_3.origin, self.origin);
      if(var_4 < 2048) {
        self.var_C225++;
      }

      wait(0.05);
    }

    if(isDefined(self.var_109C6) && self.var_109C6 == "evade" || self.var_109C6 == "engage") {
      self.var_C225 = 0;
      continue;
    }

    if(self.var_C225 > 1) {
      thread func_F6B0();
    } else {
      thread setstate();
    }

    self.var_C225 = 0;
    wait(0.05);
  }
}

func_114E9(var_0, var_1) {
  self endon("tankDestroyed");
  self endon("death");
  if(!isDefined(level.func_848E)) {
    self startpath(var_0);
    return;
  }

  self attachpath(var_0);
  self startpath(var_0);
  var_0 notify("trigger", self, 1);
  wait(0.05);
  for(;;) {
    while(isDefined(self.changingdirection)) {
      wait(0.05);
    }

    var_2 = getnodenearenemies();
    if(isDefined(var_2)) {
      self.endnode = var_2;
    } else {
      self.endnode = undefined;
    }

    wait(0.65);
  }
}

func_3758(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if((var_1 == self || var_1 == self.mgturret || isDefined(var_1.pers) && var_1.pers["team"] == self.team) && var_1 != self.owner || var_4 == "MOD_MELEE") {
    return;
  }

  var_12 = modifydamage(var_4, var_2, var_1);
  self vehicle_finishdamage(var_0, var_1, var_12, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

func_114D9() {
  self endon("death");
  self.var_E1 = 0;
  var_0 = self vehicle_getspeed();
  var_1 = self.health;
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  for(;;) {
    self waittill("damage", var_5, var_6, var_7, var_8, var_9);
    if(isDefined(var_6.classname) && var_6.classname == "script_vehicle") {
      if(isDefined(self.besttarget) && self.besttarget != var_6) {
        self.var_72B8 = var_6;
        thread func_698D();
      }
    } else if(isPlayer(var_6)) {
      var_6 scripts\mp\damagefeedback::updatedamagefeedback("hitHelicopter");
      if(var_6 scripts\mp\utility::_hasperk("specialty_armorpiercing")) {
        var_10 = var_5 * level.armorpiercingmod;
        self.health = self.health - int(var_10);
      }
    }

    if(self.health <= 0) {
      self notify("death");
      return;
    } else if(self.health < var_1 / 4 && var_4 == 0) {
      var_4 = 1;
    } else if(self.health < var_1 / 2 && var_3 == 0) {
      var_3 = 1;
    } else if(self.health < var_1 / 1.5 && var_2 == 0) {
      var_2 = 1;
    }

    if(var_5 > 1000) {
      func_89F2(var_6);
    }
  }
}

func_89F2(var_0) {
  self endon("death");
  var_1 = randomint(100);
  if(isDefined(self.besttarget) && self.besttarget != var_0 && var_1 > 30) {
    var_2 = [];
    var_2[0] = self.besttarget;
    func_698D(1, self.besttarget);
    thread func_1572(var_2);
    return;
  }

  if(!isDefined(self.besttarget) && var_1 > 30) {
    var_2 = [];
    var_2[0] = var_0;
    thread func_1572(var_2);
    return;
  }

  if(var_1 < 30) {
    playFX(level.var_114D8, self.origin);
    thread func_F6ED();
    return;
  }

  self fireweapon();
  self playSound("bmp_fire");
}

func_89D4(var_0) {
  self endon("death");
  var_1 = relative_ads_anims(var_0);
  var_2 = distance(self.origin, var_0.origin);
  if(randomint(4) < 3) {
    return;
  }

  if(var_1 == "front" && var_2 < 768) {
    thread func_F6ED();
    return;
  }

  if(var_1 == "rear_side" || var_1 == "rear" && var_2 >= 768) {
    playFX(level.var_114D8, self.origin);
    thread func_F6ED();
    return;
  }

  if(var_1 == "rear" && var_2 < 768) {
    func_11097();
    func_F6ED();
    wait(4);
    func_11096();
    return;
  }

  if(var_1 == "front_side" || var_1 == "front") {
    playFX(level.var_114D8, self.origin);
    func_11097();
    func_F6ED();
    wait(8);
    func_11096();
    return;
  }
}

relative_ads_anims(var_0) {
  self endon("death");
  var_0 endon("death");
  var_0 endon("disconnect");
  var_1 = anglesToForward(self.angles);
  var_2 = var_0.origin - self.origin;
  var_1 = var_1 * (1, 1, 0);
  var_2 = var_2 * (1, 1, 0);
  var_2 = vectornormalize(var_2);
  var_1 = vectornormalize(var_1);
  var_3 = vectordot(var_2, var_1);
  if(var_3 > 0) {
    if(var_3 > 0.9) {
      return "front";
    } else {
      return "front_side";
    }
  } else if(var_3 < -0.9) {
    return "rear";
  } else {
    return "rear_side";
  }

  var_0 iprintlnbold(var_3);
}

func_13A78() {
  self endon("death");
  for(;;) {
    var_0 = [];
    var_1 = level.players;
    foreach(var_3 in var_1) {
      if(!isDefined(var_3)) {
        wait(0.05);
        continue;
      }

      if(!istarget(var_3)) {
        wait(0.05);
        continue;
      }

      var_4 = var_3 getcurrentweapon();
      if(issubstr(var_4, "at4") || issubstr(var_4, "stinger") || issubstr(var_4, "javelin")) {
        thread func_89D4(var_3);
        wait(8);
      }

      wait(0.15);
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

modifydamage(var_0, var_1, var_2) {
  if(var_0 == "MOD_RIFLE_BULLET") {
    return var_1;
  }

  if(var_0 == "MOD_PISTOL_BULLET") {
    return var_1;
  }

  if(var_0 == "MOD_IMPACT") {
    return var_1;
  }

  if(var_0 == "MOD_MELEE") {
    return 0;
  }

  if(var_0 == "MOD_EXPLOSIVE_BULLET") {
    return var_1;
  }

  if(var_0 == "MOD_GRENADE") {
    return var_1 * 5;
  }

  if(var_0 == "MOD_GRENADE_SPLASH") {
    return var_1 * 5;
  }

  return var_1 * 10;
}

func_5329() {
  self waittill("death");
  if(level.teambased) {
    var_0 = level.var_114B1.team;
    if(level.var_114B1.objid[var_0] != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_state(level.var_114B1.objid[var_0], "invisible");
    }

    if(level.var_114B1.objid[level.otherteam[var_0]] != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_state(level.var_114B1.objid[level.otherteam[var_0]], "invisible");
    }
  }

  self notify("tankDestroyed");
  self vehicle_setspeed(0, 10, 10);
  level.var_114E2 = 0;
  playFX(level.var_10888, self.origin);
  playFX(level.var_114DD, self.origin);
  func_E11C();
  var_1 = spawn("script_model", self.origin);
  var_1 setModel("vehicle_m1a1_abrams_d_static");
  var_1.angles = self.angles;
  self.mgturret delete();
  self delete();
  wait(4);
  var_1 delete();
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

    var_0 = self gettagorigin("tag_flash");
    var_1 = bulletTrace(self.origin, var_0, 0, self);
    if(var_1["position"] != var_0) {
      thread func_698D(0, self.besttarget);
    }

    var_1 = bulletTrace(var_0, self.besttarget.origin, 1, self);
    var_2 = distance(self.origin, var_1["position"]);
    var_3 = distance(self.besttarget.origin, self.origin);
    if(var_2 < 384 || var_2 + 256 < var_3) {
      wait(0.5);
      if(var_2 > 384) {
        func_136F4();
        self fireweapon();
        self playSound("bmp_fire");
        self.var_118F3 = gettime();
      }

      var_4 = relative_ads_anims(self.besttarget);
      thread func_698D(0, self.besttarget);
      return;
    }

    func_136F4();
    self fireweapon();
    self playSound("bmp_fire");
    self.var_118F3 = gettime();
  }
}

func_136F4() {
  self endon("abandonedTarget");
  self endon("killedTarget");
  self endon("death");
  self endon("targetRemoved");
  self endon("lostLOS");
  var_0 = gettime() - self.var_118F3;
  if(var_0 < 1499) {
    wait(1.5 - var_0 / 1000);
  }
}

func_114E1(var_0) {
  self endon("death");
  self endon("leaving");
  var_1 = [];
  for(;;) {
    var_1 = [];
    var_2 = level.players;
    if(isDefined(self.var_72B8)) {
      var_1 = [];
      var_1[0] = self.var_72B8;
      func_1572(var_1);
      self.var_72B8 = undefined;
    }

    if(isDefined(level.harrier) && level.harrier.team != self.team && isalive(level.harrier)) {
      if(func_9FF1(level.var_114B1)) {
        var_1[var_1.size] = level.var_114B1;
      }
    }

    if(isDefined(level.chopper) && level.chopper.team != self.team && isalive(level.chopper)) {
      if(func_9FF1(level.chopper)) {
        var_1[var_1.size] = level.chopper;
      }
    }

    foreach(var_4 in var_2) {
      if(!isDefined(var_4)) {
        wait(0.05);
        continue;
      }

      if(isDefined(var_0) && var_4 == var_0) {
        continue;
      }

      if(istarget(var_4)) {
        if(isDefined(var_4)) {
          var_1[var_1.size] = var_4;
        }

        continue;
      }

      continue;
    }

    if(var_1.size > 0) {
      func_1572(var_1);
      continue;
    }

    wait(1);
  }
}

func_1572(var_0) {
  self endon("death");
  if(var_0.size == 1) {
    self.besttarget = var_0[0];
  } else {
    self.besttarget = getbesttarget(var_0);
  }

  thread func_F6E3();
  thread func_13B74(var_0);
  self setturrettargetent(self.besttarget);
  fireontarget();
  thread func_F7B8();
}

func_F7B8() {
  self endon("death");
  setstate();
  removetargetmarkergroup();
  self setturrettargetent(self.var_BEF5);
}

getbesttarget(var_0) {
  self endon("death");
  var_1 = self gettagorigin("tag_flash");
  var_2 = self.origin;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = 0;
  foreach(var_7 in var_0) {
    var_8 = abs(vectortoangles(var_7.origin - self.origin)[1]);
    var_9 = abs(self gettagangles("tag_flash")[1]);
    var_8 = abs(var_8 - var_9);
    if(isDefined(level.chopper) && var_7 == level.chopper) {
      return var_7;
    }

    if(isDefined(level.harrier) && var_7 == level.harrier) {
      return var_7;
    }

    var_10 = var_7 getweaponslistitems();
    foreach(var_12 in var_10) {
      if(issubstr(var_12, "at4") || issubstr(var_12, "jav") || issubstr(var_12, "c4")) {
        var_8 = var_8 - 40;
      }
    }

    if(!isDefined(var_3)) {
      var_3 = var_8;
      var_4 = var_7;
      continue;
    }

    if(var_3 > var_8) {
      var_3 = var_8;
      var_4 = var_7;
    }
  }

  return var_4;
}

func_13B74(var_0) {
  self endon("abandonedTarget");
  self endon("lostLOS");
  self endon("death");
  self endon("targetRemoved");
  var_1 = self.besttarget;
  var_1 endon("disconnect");
  var_1 waittill("death");
  self notify("killedTarget");
  removetargetmarkergroup();
  setstate();
  thread func_F7B8();
}

func_698D(var_0, var_1) {
  self endon("death");
  self notify("abandonedTarget");
  setstate();
  thread func_F7B8();
  removetargetmarkergroup();
  if(isDefined(var_1)) {
    self.var_275E = var_1;
    func_275F();
  }

  if(isDefined(var_0) && var_0) {}
}

func_275F() {
  self endon("death");
  wait(1.5);
  self.var_275E = undefined;
}

removetargetmarkergroup() {
  self notify("targetRemoved");
  self.besttarget = undefined;
  self.var_A9AF = undefined;
}

func_9FF1(var_0) {
  if(distance2d(var_0.origin, self.origin) > 4096) {
    return 0;
  }

  if(distance(var_0.origin, self.origin) < 512) {
    return 0;
  }

  return func_12A8F(var_0, 0);
}

istarget(var_0) {
  self endon("death");
  var_1 = distancesquared(var_0.origin, self.origin);
  if(!level.teambased && isDefined(self.owner) && var_0 == self.owner) {
    return 0;
  }

  if(!isalive(var_0) || var_0.sessionstate != "playing") {
    return 0;
  }

  if(var_1 > 16777216) {
    return 0;
  }

  if(var_1 < 262144) {
    return 0;
  }

  if(!isDefined(var_0.pers["team"])) {
    return 0;
  }

  if(var_0 == self.owner) {
    return 0;
  }

  if(level.teambased && var_0.pers["team"] == self.team) {
    return 0;
  }

  if(var_0.pers["team"] == "spectator") {
    return 0;
  }

  if(isDefined(var_0.spawntime) && gettime() - var_0.spawntime / 1000 <= 5) {
    return 0;
  }

  if(var_0 scripts\mp\utility::_hasperk("specialty_blindeye")) {
    return 0;
  }

  return self vehicle_canturrettargetpoint(var_0.origin, 1, self);
}

func_12A8F(var_0, var_1) {
  var_2 = var_0 giveperks(self gettagorigin("tag_turret"), self);
  if(var_2 < 0.7) {
    return 0;
  }

  if(isDefined(var_1) && var_1) {
    thread scripts\mp\utility::drawline(var_0.origin, self gettagorigin("tag_turret"), 10, (1, 0, 0));
  }

  return 1;
}

func_9EA1(var_0) {
  self endon("death");
  if(!isalive(var_0) || var_0.sessionstate != "playing") {
    return 0;
  }

  if(!isDefined(var_0.pers["team"])) {
    return 0;
  }

  if(var_0 == self.owner) {
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

  if(isDefined(var_0.spawntime) && gettime() - var_0.spawntime / 1000 <= 5) {
    return 0;
  }

  if(isDefined(self)) {
    var_1 = self.mgturret.origin + (0, 0, 64);
    var_2 = var_0 giveperks(var_1, self);
    if(var_2 < 1) {
      return 0;
    }
  }

  return 1;
}

func_114DF() {
  self endon("death");
  self endon("leaving");
  var_0 = [];
  for(;;) {
    var_0 = [];
    var_1 = level.players;
    for(var_2 = 0; var_2 <= var_1.size; var_2++) {
      if(func_9EA1(var_1[var_2])) {
        if(isDefined(var_1[var_2])) {
          var_0[var_0.size] = var_1[var_2];
        }
      } else {
        continue;
      }

      wait(0.05);
    }

    if(var_0.size > 0) {
      func_1571(var_0);
      return;
    } else {
      wait(0.5);
    }
  }
}

func_7DFD(var_0) {
  self endon("death");
  var_1 = self.origin;
  var_2 = undefined;
  var_3 = undefined;
  foreach(var_5 in var_0) {
    var_6 = distance(self.origin, var_5.origin);
    var_7 = var_5 getcurrentweapon();
    if(issubstr(var_7, "at4") || issubstr(var_7, "jav") || issubstr(var_7, "c4") || issubstr(var_7, "smart") || issubstr(var_7, "grenade")) {
      var_6 = var_6 - 200;
    }

    if(!isDefined(var_2)) {
      var_2 = var_6;
      var_3 = var_5;
      continue;
    }

    if(var_2 > var_6) {
      var_2 = var_6;
      var_3 = var_5;
    }
  }

  return var_3;
}

func_1571(var_0) {
  self endon("death");
  if(var_0.size == 1) {
    self.var_2A97 = var_0[0];
  } else {
    self.var_2A97 = func_7DFD(var_0);
  }

  if(distance2d(self.origin, self.var_2A97.origin) > 768) {
    thread func_F799();
  }

  self notify("acquiringMiniTarget");
  self.mgturret settargetentity(self.var_2A97, (0, 0, 64));
  wait(0.15);
  thread func_6D74();
  thread func_13AD1(var_0);
  thread func_13AD2(var_0);
  thread func_13AD3(self.var_2A97);
}

func_6D74() {
  self endon("death");
  self endon("abandonedMiniTarget");
  self endon("killedMiniTarget");
  var_0 = undefined;
  var_1 = gettime();
  if(!isDefined(self.var_2A97)) {
    return;
  }

  for(;;) {
    if(!isDefined(self.mgturret getturrettarget(1))) {
      if(!isDefined(var_0)) {
        var_0 = gettime();
      }

      var_2 = gettime();
      if(var_0 - var_2 > 1) {
        var_0 = undefined;
        thread func_698C();
        return;
      }

      wait(0.5);
      continue;
    }

    if(gettime() > var_1 + 1000 && !isDefined(self.besttarget)) {
      if(distance2d(self.origin, self.var_2A97.origin) > 768) {
        var_1[0] = self.var_2A97;
        func_1572(var_5);
      }
    }

    var_4 = randomintrange(10, 16);
    for(var_5 = 0; var_5 < var_4; var_5++) {
      self.mgturret shootturret();
      wait(0.1);
    }

    wait(randomfloatrange(0.5, 3));
  }
}

func_13AD1(var_0) {
  self endon("abandonedMiniTarget");
  self endon("death");
  if(!isDefined(self.var_2A97)) {
    return;
  }

  self.var_2A97 waittill("death");
  self notify("killedMiniTarget");
  self.var_2A97 = undefined;
  self.mgturret cleartargetentity();
  func_114DF();
}

func_13AD2(var_0) {
  self endon("abandonedMiniTarget");
  self endon("death");
  for(;;) {
    if(!isDefined(self.var_2A97)) {
      return;
    }

    var_1 = bulletTrace(self.mgturret.origin, self.var_2A97.origin, 0, self);
    var_2 = distance(self.origin, var_1["position"]);
    if(var_2 > 1024) {
      thread func_698C();
      return;
    }

    wait(2);
  }
}

func_13AD3(var_0) {
  self endon("abandonedMiniTarget");
  self endon("death");
  self endon("killedMiniTarget");
  for(;;) {
    var_1 = [];
    var_2 = level.players;
    for(var_3 = 0; var_3 <= var_2.size; var_3++) {
      if(func_9EA1(var_2[var_3])) {
        if(!isDefined(var_2[var_3])) {
          continue;
        }

        if(!isDefined(var_0)) {
          return;
        }

        var_4 = distance(self.origin, var_0.origin);
        var_5 = distance(self.origin, var_2[var_3].origin);
        if(var_5 < var_4) {
          thread func_698C();
          return;
        }
      }

      wait(0.05);
    }

    wait(0.25);
  }
}

func_698C(var_0) {
  self notify("abandonedMiniTarget");
  self.var_2A97 = undefined;
  self.mgturret cleartargetentity();
  if(isDefined(var_0) && var_0) {
    return;
  }

  thread func_114DF();
}

func_185E() {
  level.var_114E3[self getentitynumber()] = self;
}

func_E11C() {
  level.var_114E3[self getentitynumber()] = undefined;
}

getnodenearenemies() {
  var_0 = [];
  foreach(var_2 in level.players) {
    if(var_2.team == "spectator") {
      continue;
    }

    if(var_2.team == self.team) {
      continue;
    }

    if(!isalive(var_2)) {
      continue;
    }

    var_2.var_56E8 = 0;
    var_0[var_0.size] = var_2;
  }

  if(!var_0.size) {
    return undefined;
  }

  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    for(var_5 = var_4 + 1; var_5 < var_0.size; var_5++) {
      var_6 = distancesquared(var_0[var_4].origin, var_0[var_5].origin);
      var_0[var_4].var_56E8 = var_0[var_4].var_56E8 + var_6;
      var_0[var_5].var_56E8 = var_0[var_5].var_56E8 + var_6;
    }
  }

  var_7 = var_0[0];
  foreach(var_2 in var_0) {
    if(var_2.var_56E8 < var_7.var_56E8) {
      var_7 = var_2;
    }
  }

  var_10 = var_7.origin;
  var_11 = sortbydistance(level.func_848E, var_10);
  return var_11[0];
}

func_FAD8() {
  var_0 = [];
  var_1 = [];
  var_2 = [];
  var_3 = [];
  var_4 = getvehiclenode("startnode", "targetname");
  var_0[var_0.size] = var_4;
  var_1[var_1.size] = var_4;
  while(isDefined(var_4.target)) {
    var_5 = var_4;
    var_4 = getvehiclenode(var_4.target, "targetname");
    var_4.var_D886 = var_5;
    if(var_4 == var_0[0]) {
      break;
    }

    var_0[var_0.size] = var_4;
    if(!isDefined(var_4.target)) {
      return;
    }
  }

  var_0[0].var_2F45 = [];
  var_0[0] thread func_897F("forward");
  var_3[var_3.size] = var_0[0];
  var_6 = getvehiclenodearray("branchnode", "targetname");
  foreach(var_8 in var_6) {
    var_4 = var_8;
    var_0[var_0.size] = var_4;
    var_1[var_1.size] = var_4;
    while(isDefined(var_4.target)) {
      var_5 = var_4;
      var_4 = getvehiclenode(var_4.target, "targetname");
      var_0[var_0.size] = var_4;
      var_4.var_D886 = var_5;
      if(!isDefined(var_4.target)) {
        var_2[var_2.size] = var_4;
      }
    }
  }

  foreach(var_4 in var_0) {
    var_11 = 0;
    foreach(var_13 in var_1) {
      if(var_13 == var_4) {
        continue;
      }

      if(var_13.target == var_4.var_336) {
        continue;
      }

      if(isDefined(var_4.target) && var_4.target == var_13.var_336) {
        continue;
      }

      if(distance2d(var_4.origin, var_13.origin) > 80) {
        continue;
      }

      var_13 thread func_8982(var_4, "reverse");
      var_13.var_D886 = var_4;
      if(!isDefined(var_4.var_2F45)) {
        var_4.var_2F45 = [];
      }

      var_4.var_2F45[var_4.var_2F45.size] = var_13;
      var_11 = 1;
    }

    if(var_11) {
      var_4 thread func_897F("forward");
    }

    var_15 = 0;
    foreach(var_11 in var_2) {
      if(var_11 == var_4) {
        continue;
      }

      if(!isDefined(var_4.target)) {
        continue;
      }

      if(var_4.target == var_11.var_336) {
        continue;
      }

      if(isDefined(var_11.target) && var_11.target == var_4.var_336) {
        continue;
      }

      if(distance2d(var_4.origin, var_11.origin) > 80) {
        continue;
      }

      var_11 thread func_8982(var_4, "forward");
      var_11.var_BF2E = getvehiclenode(var_4.var_336, "targetname");
      var_11.var_AB5D = distance(var_11.origin, var_4.origin);
      if(!isDefined(var_4.var_2F45)) {
        var_4.var_2F45 = [];
      }

      var_4.var_2F45[var_4.var_2F45.size] = var_11;
      var_15 = 1;
    }

    if(var_15) {
      var_4 thread func_897F("reverse");
    }

    if(var_15 || var_11) {
      var_3[var_3.size] = var_4;
    }
  }

  if(var_3.size < 3) {
    level notify("end_tankPathHandling");
    return;
  }

  var_14 = [];
  foreach(var_4 in var_0) {
    if(!isDefined(var_4.var_2F45)) {
      continue;
    }

    var_14[var_14.size] = var_4;
  }

  foreach(var_18 in var_14) {
    var_4 = var_18;
    var_19 = 0;
    while(isDefined(var_4.target)) {
      var_1A = var_4;
      var_4 = getvehiclenode(var_4.target, "targetname");
      var_19 = var_19 + distance(var_4.origin, var_1A.origin);
      if(var_4 == var_18) {
        break;
      }

      if(isDefined(var_4.var_2F45)) {
        break;
      }
    }

    if(var_19 > 1000) {
      var_4 = var_18;
      var_1B = 0;
      while(isDefined(var_4.target)) {
        var_1A = var_4;
        var_4 = getvehiclenode(var_4.target, "targetname");
        var_1B = var_1B + distance(var_4.origin, var_1A.origin);
        if(var_1B < var_19 / 2) {
          continue;
        }

        var_4.var_2F45 = [];
        var_4 thread func_897F("forward");
        var_3[var_3.size] = var_4;
        break;
      }
    }
  }

  level.func_848E = func_98A6(var_3);
  foreach(var_4 in var_0) {
    if(!isDefined(var_4.func_848D)) {
      var_4 thread func_C059();
    }
  }
}

dontinterpolate(var_0) {
  var_1 = [];
  foreach(var_4, var_3 in self.var_AD40) {
    if(self.var_AD17[var_4] != var_0) {
      continue;
    }

    var_1[var_1.size] = var_3;
  }

  return var_1[randomint(var_1.size)];
}

func_7FE9(var_0, var_1) {
  var_2 = level.func_848E[self.func_848D];
  var_3 = func_7732(var_2, var_0, undefined, var_1);
  var_4 = var_3[0].var_7646;
  var_5 = func_7732(var_2, var_0, undefined, level.var_C74A[var_1]);
  var_6 = var_5[0].var_7646;
  if(!getdvarint("tankDebug")) {
    var_6 = 9999999;
  }

  if(var_4 <= var_6) {
    return var_3[1];
  }
}

func_897F(var_0) {
  level endon("end_tankPathHandling");
  for(;;) {
    self waittill("trigger", var_1, var_2);
    var_3 = level.func_848E[self.func_848D];
    var_1.node = self;
    var_4 = undefined;
    if(isDefined(var_1.endnode) && var_1.endnode != var_3) {
      var_4 = func_7FE9(var_1.endnode, var_1.var_376);
      if(!isDefined(var_4)) {
        var_1 thread func_F6C4(level.var_C74A[var_1.var_376]);
      }
    }

    if(!isDefined(var_4) || var_4 == var_3) {
      var_4 = var_3 dontinterpolate(var_1.var_376);
    }

    var_5 = var_3.var_AD41[var_4.func_848D];
    if(var_1.var_376 == "forward") {
      var_6 = func_7FE8();
    } else {
      var_6 = func_809A();
    }

    if(var_6 != var_5) {
      var_1 startpath(var_5);
    }
  }
}

func_8982(var_0, var_1) {
  for(;;) {
    self waittill("trigger", var_2);
    if(var_2.var_376 != var_1) {
      continue;
    }

    func_4F52("tank starting path at join node: " + var_0.func_848D);
    var_2 startpath(var_0);
  }
}

func_C059() {
  self.var_7334 = func_7EC4().func_848D;
  self.var_E492 = func_80EF().func_848D;
  for(;;) {
    self waittill("trigger", var_0, var_1);
    var_0.node = self;
    var_0.var_7334 = self.var_7334;
    var_0.var_E492 = self.var_E492;
    if(!isDefined(self.target) || self.var_336 == "branchnode") {
      var_2 = "TRANS";
    } else {
      var_2 = "NODE";
    }

    if(isDefined(var_1)) {
      func_4F50(self.origin, var_2, (1, 0.5, 0), 1, 2, 100);
      continue;
    }

    func_4F50(self.origin, var_2, (0, 1, 0), 1, 2, 100);
  }
}

func_72EA(var_0, var_1, var_2) {
  var_1 endon("trigger");
  var_0 endon("trigger");
  var_2 endon("death");
  var_3 = distancesquared(var_2.origin, var_1.origin);
  var_4 = var_2.var_376;
  func_4F50(var_0.origin + (0, 0, 30), "LAST", (0, 0, 1), 0.5, 1, 100);
  func_4F50(var_1.origin + (0, 0, 60), "NEXT", (0, 1, 0), 0.5, 1, 100);
  var_5 = 0;
  for(;;) {
    wait(0.05);
    if(var_4 != var_2.var_376) {
      func_4F52("tank missed node: reversing direction");
      var_2 thread func_72EA(var_1, var_0, var_2);
      return;
    }

    if(var_5) {
      func_4F52("... sending notify.");
      var_1 notify("trigger", var_2, 1);
      return;
    }

    var_6 = distancesquared(var_2.origin, var_1.origin);
    if(var_6 > var_3) {
      var_5 = 1;
      func_4F52("tank missed node: forcing notify in one frame...");
    }

    var_3 = var_6;
  }
}

func_7EC4() {
  for(var_0 = self; !isDefined(var_0.func_848D); var_0 = var_0 func_7FE8()) {}

  return var_0;
}

func_80EF() {
  for(var_0 = self; !isDefined(var_0.func_848D); var_0 = var_0 func_809A()) {}

  return var_0;
}

func_7FE8() {
  if(isDefined(self.target)) {
    return getvehiclenode(self.target, "targetname");
  }

  return self.var_BF2E;
}

func_809A() {
  return self.var_D886;
}

func_98A6(var_0) {
  var_1 = [];
  foreach(var_3 in var_0) {
    var_4 = spawnStruct();
    var_4.var_AD35 = [];
    var_4.var_AD40 = [];
    var_4.var_AD36 = [];
    var_4.var_AD17 = [];
    var_4.var_AD41 = [];
    var_4.node = var_3;
    var_4.origin = var_3.origin;
    var_4.func_848D = var_1.size;
    var_3.func_848D = var_1.size;
    func_4F50(var_4.origin + (0, 0, 80), var_4.func_848D, (1, 1, 1), 0.65, 2, 100000);
    var_1[var_1.size] = var_4;
  }

  foreach(var_3 in var_0) {
    var_7 = var_3.func_848D;
    var_8 = getvehiclenode(var_3.target, "targetname");
    var_9 = distance(var_3.origin, var_8.origin);
    var_10 = var_8;
    while(!isDefined(var_8.func_848D)) {
      var_9 = var_9 + distance(var_8.origin, var_8.var_D886.origin);
      if(isDefined(var_8.target)) {
        var_8 = getvehiclenode(var_8.target, "targetname");
        continue;
      }

      var_8 = var_8.var_BF2E;
    }

    var_1[var_7] func_17EC(var_1[var_8.func_848D], var_9, "forward", var_10);
    var_8 = var_3.var_D886;
    var_9 = distance(var_3.origin, var_8.origin);
    var_10 = var_8;
    while(!isDefined(var_8.func_848D)) {
      var_9 = var_9 + distance(var_8.origin, var_8.var_D886.origin);
      var_8 = var_8.var_D886;
    }

    var_1[var_7] func_17EC(var_1[var_8.func_848D], var_9, "reverse", var_10);
    foreach(var_12 in var_3.var_2F45) {
      var_8 = var_12;
      var_9 = distance(var_3.origin, var_8.origin);
      var_10 = var_8;
      if(var_8.var_336 == "branchnode") {
        while(!isDefined(var_8.func_848D)) {
          if(isDefined(var_8.target)) {
            var_13 = getvehiclenode(var_8.target, "targetname");
          } else {
            var_13 = var_8.var_BF2E;
          }

          var_9 = var_9 + distance(var_8.origin, var_13.origin);
          var_8 = var_13;
        }

        var_1[var_7] func_17EC(var_1[var_8.func_848D], var_9, "forward", var_10);
        continue;
      }

      while(!isDefined(var_8.func_848D)) {
        var_9 = var_9 + distance(var_8.origin, var_8.var_D886.origin);
        var_8 = var_8.var_D886;
      }

      var_1[var_7] func_17EC(var_1[var_8.func_848D], var_9, "reverse", var_10);
    }
  }

  return var_1;
}

func_17EC(var_0, var_1, var_2, var_3) {
  self.var_AD40[var_0.func_848D] = var_0;
  self.var_AD36[var_0.func_848D] = var_1;
  self.var_AD17[var_0.func_848D] = var_2;
  self.var_AD41[var_0.func_848D] = var_3;
  var_4 = spawnStruct();
  var_4.var_119D3 = var_0;
  var_4.var_119D2 = var_0.func_848D;
  var_4.var_AB5D = var_1;
  var_4.var_F2 = var_2;
  var_4.var_10DCD = var_3;
  self.var_AD35[var_0.func_848D] = var_4;
}

func_7732(var_0, var_1, var_2, var_3) {
  level.var_C62D = [];
  level.var_428F = [];
  var_4 = 0;
  var_5 = [];
  if(!isDefined(var_2)) {
    var_2 = [];
  }

  var_1.var_7646 = 0;
  var_1.var_877B = func_7F0A(var_1, var_0);
  var_1.var_6A62 = var_1.var_7646 + var_1.var_877B;
  func_184C(var_1);
  var_6 = var_1;
  for(;;) {
    foreach(var_8 in var_6.var_AD40) {
      if(scripts\engine\utility::array_contains(var_2, var_8)) {
        continue;
      }

      if(scripts\engine\utility::array_contains(level.var_428F, var_8)) {
        continue;
      }

      if(isDefined(var_3) && var_8.var_AD17[var_6.func_848D] != var_3) {
        continue;
      }

      if(!scripts\engine\utility::array_contains(level.var_C62D, var_8)) {
        addtoopenlist(var_8);
        var_8.var_C8F6 = var_6;
        var_8.var_7646 = func_7EED(var_8, var_6);
        var_8.var_877B = func_7F0A(var_8, var_0);
        var_8.var_6A62 = var_8.var_7646 + var_8.var_877B;
        if(var_8 == var_0) {
          var_4 = 1;
        }

        continue;
      }

      if(var_8.var_7646 < func_7EED(var_6, var_8)) {
        continue;
      }

      var_8.var_C8F6 = var_6;
      var_8.var_7646 = func_7EED(var_8, var_6);
      var_8.var_6A62 = var_8.var_7646 + var_8.var_877B;
    }

    if(var_4) {
      break;
    }

    func_184C(var_6);
    var_10 = level.var_C62D[0];
    foreach(var_12 in level.var_C62D) {
      if(var_12.var_6A62 > var_10.var_6A62) {
        continue;
      }

      var_10 = var_12;
    }

    func_184C(var_10);
    var_6 = var_10;
  }

  var_6 = var_0;
  while(var_6 != var_1) {
    var_5[var_5.size] = var_6;
    var_6 = var_6.var_C8F6;
  }

  var_5[var_5.size] = var_6;
  return var_5;
}

addtoopenlist(var_0) {
  var_0.var_C62E = level.var_C62D.size;
  level.var_C62D[level.var_C62D.size] = var_0;
  var_0.var_4290 = undefined;
}

func_184C(var_0) {
  if(isDefined(var_0.var_4290)) {
    return;
  }

  var_0.var_4290 = level.var_428F.size;
  level.var_428F[level.var_428F.size] = var_0;
  if(!scripts\engine\utility::array_contains(level.var_C62D, var_0)) {
    return;
  }

  level.var_C62D[var_0.var_C62E] = level.var_C62D[level.var_C62D.size - 1];
  level.var_C62D[var_0.var_C62E].var_C62E = var_0.var_C62E;
  level.var_C62D[level.var_C62D.size - 1] = undefined;
  var_0.var_C62E = undefined;
}

func_7F0A(var_0, var_1) {
  return distance(var_0.node.origin, var_1.node.origin);
}

func_7EED(var_0, var_1) {
  return var_0.var_C8F6.var_7646 + var_0.var_AD36[var_1.func_848D];
}

drawpath(var_0) {
  for(var_1 = 1; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1 - 1];
    var_3 = var_0[var_1];
    if(var_2.var_AD17[var_3.func_848D] == "reverse") {
      level thread func_5B7C(var_2.node.origin, var_3.node.origin, (1, 0, 0));
    } else {
      level thread func_5B7C(var_2.node.origin, var_3.node.origin, (0, 1, 0));
    }

    var_4 = var_2.var_AD41[var_3.func_848D];
    level thread func_5B7C(var_2.node.origin + (0, 0, 4), var_4.origin + (0, 0, 4), (0, 0, 1));
    if(var_2.var_AD17[var_3.func_848D] == "reverse") {
      while(!isDefined(var_4.func_848D)) {
        var_5 = var_4;
        var_4 = var_4.var_D886;
        level thread func_5B7C(var_5.origin + (0, 0, 4), var_4.origin + (0, 0, 4), (0, 1, 1));
      }

      continue;
    }

    while(!isDefined(var_4.func_848D)) {
      var_5 = var_4;
      if(isDefined(var_4.target)) {
        var_4 = getvehiclenode(var_4.target, "targetname");
        continue;
      }

      var_4 = var_4.var_BF2E;
      level thread func_5B7C(var_5.origin + (0, 0, 4), var_4.origin + (0, 0, 4), (0, 1, 1));
    }
  }
}

drawgraph(var_0) {}

func_5B7C(var_0, var_1, var_2) {
  level endon("endpath");
  wait(0.05);
}

func_4F52(var_0) {}

debugprint(var_0) {}

func_4F50(var_0, var_1, var_2, var_3, var_4, var_5) {}

func_5B8B() {}