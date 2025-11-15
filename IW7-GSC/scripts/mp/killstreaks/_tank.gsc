/********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_tank.gsc
********************************************/

init() {}

func_1082D(param_00, param_01, param_02) {
  var_03 = self global_physics_sound_monitor("tank", param_00);
  var_03.health = 3000;
  var_03.var_11568 = 1;
  var_03.team = param_00.team;
  var_03.pers["team"] = var_03.team;
  var_03.triggerportableradarping = param_00;
  var_03 setCanDamage(1);
  var_03.var_10B68 = 12;
  var_03 thread deletepentsonrespawn();
  var_03 func_185E();
  var_03.damagecallback = ::func_3758;
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

    wait(1);
  }
}

func_130E4(param_00) {
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
    var_00 = level.var_114E5["allies"] func_1082D(self, "vehicle_bradley");
  } else {
    var_00 = level.var_114E5["axis"] func_1082D(self, "vehicle_bmp");
  }

  var_00 func_10DF8();
  return 1;
}

func_10DF8(param_00) {
  var_01 = getvehiclenode("startnode", "targetname");
  var_02 = getvehiclenode("waitnode", "targetname");
  self.nodes = getvehiclenodearray("info_vehicle_node", "classname");
  level.var_114E2 = 1;
  thread func_114E9(var_01, var_02);
  thread func_114D9();
  level.var_114B1 = self;
  if(level.teambased) {
    var_03 = scripts\mp\objidpoolmanager::requestminimapid(1);
    if(var_03 != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_add(var_03, "invisible", (0, 0, 0));
      scripts\mp\objidpoolmanager::minimap_objective_team(var_03, "allies");
    }

    level.var_114B1.objid["allies"] = var_03;
    var_04 = scripts\mp\objidpoolmanager::requestminimapid(1);
    if(var_04 != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_add(var_04, "invisible", (0, 0, 0));
      scripts\mp\objidpoolmanager::minimap_objective_team(var_04, "axis");
    }

    level.var_114B1.objid["axis"] = var_04;
    var_05 = self.team;
    level.var_114B1.team = var_05;
    level.var_114B1.pers["team"] = var_05;
  }

  var_06 = spawnturret("misc_turret", self.origin, "abrams_minigun_mp");
  var_06 linkto(self, "tag_engine_left", (0, 0, -20), (0, 0, 0));
  var_06 setModel("sentry_minigun");
  var_06.angles = self.angles;
  var_06.triggerportableradarping = self.triggerportableradarping;
  var_06 getvalidattachments();
  self.mgturret = var_06;
  self.mgturret setdefaultdroppitch(0);
  var_07 = self.angles;
  self.angles = (0, 0, 0);
  var_08 = self gettagorigin("tag_flash");
  self.angles = var_07;
  var_09 = var_08 - self.origin;
  thread func_136B0();
  thread func_136B8();
  self.var_118F3 = gettime();
  var_0A = spawn("script_origin", self gettagorigin("tag_flash"));
  var_0A linkto(self, "tag_origin", var_09, (0, 0, 0));
  var_0A hide();
  self.var_BEF5 = var_0A;
  thread func_114E1();
  thread func_5329();
  thread func_114DF();
  thread func_3E02();
  thread func_13A78();
}

func_136B0() {
  self endon("death");
  self.triggerportableradarping endon("disconnect");
  self.triggerportableradarping waittill("joined_team");
  self.health = 0;
  self notify("death");
}

func_136B8() {
  self endon("death");
  self.triggerportableradarping waittill("disconnect");
  self.health = 0;
  self notify("death");
}

func_F6C4(param_00) {
  if(self.var_376 != param_00) {
    if(param_00 == "forward") {
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

  var_00 = 2;
  self vehicle_setspeed(var_00, 10, 10);
  self.var_109C6 = "engage";
}

func_F799() {
  self endon("death");
  self notify("path_abandoned");
  while(isDefined(self.changingdirection)) {
    wait(0.05);
  }

  var_00 = 2;
  self vehicle_setspeed(var_00, 10, 10);
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
  var_00 = [];
  var_01 = level.players;
  self.var_C225 = 0;
  for(;;) {
    foreach(var_03 in var_01) {
      if(!isDefined(var_03)) {
        continue;
      }

      if(var_03.team == self.team) {
        wait(0.05);
        continue;
      }

      var_04 = distance2d(var_03.origin, self.origin);
      if(var_04 < 2048) {
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

func_114E9(param_00, param_01) {
  self endon("tankDestroyed");
  self endon("death");
  if(!isDefined(level._meth_848E)) {
    self startpath(param_00);
    return;
  }

  self attachpath(param_00);
  self startpath(param_00);
  param_00 notify("trigger", self, 1);
  wait(0.05);
  for(;;) {
    while(isDefined(self.changingdirection)) {
      wait(0.05);
    }

    var_02 = getnodenearenemies();
    if(isDefined(var_02)) {
      self.endnode = var_02;
    } else {
      self.endnode = undefined;
    }

    wait(0.65);
  }
}

func_3758(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if((param_01 == self || param_01 == self.mgturret || isDefined(param_01.pers) && param_01.pers["team"] == self.team) && param_01 != self.triggerportableradarping || param_04 == "MOD_MELEE") {
    return;
  }

  var_0C = modifydamage(param_04, param_02, param_01);
  self vehicle_finishdamage(param_00, param_01, var_0C, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B);
}

func_114D9() {
  self endon("death");
  self.var_E1 = 0;
  var_00 = self vehicle_getspeed();
  var_01 = self.health;
  var_02 = 0;
  var_03 = 0;
  var_04 = 0;
  for(;;) {
    self waittill("damage", var_05, var_06, var_07, var_08, var_09);
    if(isDefined(var_06.classname) && var_06.classname == "script_vehicle") {
      if(isDefined(self.besttarget) && self.besttarget != var_06) {
        self.var_72B8 = var_06;
        thread func_698D();
      }
    } else if(isplayer(var_06)) {
      var_06 scripts\mp\damagefeedback::updatedamagefeedback("hitHelicopter");
      if(var_06 scripts\mp\utility::_hasperk("specialty_armorpiercing")) {
        var_0A = var_05 * level.armorpiercingmod;
        self.health = self.health - int(var_0A);
      }
    }

    if(self.health <= 0) {
      self notify("death");
      return;
    } else if(self.health < var_01 / 4 && var_04 == 0) {
      var_04 = 1;
    } else if(self.health < var_01 / 2 && var_03 == 0) {
      var_03 = 1;
    } else if(self.health < var_01 / 1.5 && var_02 == 0) {
      var_02 = 1;
    }

    if(var_05 > 1000) {
      func_89F2(var_06);
    }
  }
}

func_89F2(param_00) {
  self endon("death");
  var_01 = randomint(100);
  if(isDefined(self.besttarget) && self.besttarget != param_00 && var_01 > 30) {
    var_02 = [];
    var_02[0] = self.besttarget;
    func_698D(1, self.besttarget);
    thread func_1572(var_02);
    return;
  }

  if(!isDefined(self.besttarget) && var_01 > 30) {
    var_02 = [];
    var_02[0] = param_00;
    thread func_1572(var_02);
    return;
  }

  if(var_01 < 30) {
    playFX(level.var_114D8, self.origin);
    thread func_F6ED();
    return;
  }

  self fireweapon();
  self playSound("bmp_fire");
}

func_89D4(param_00) {
  self endon("death");
  var_01 = relative_ads_anims(param_00);
  var_02 = distance(self.origin, param_00.origin);
  if(randomint(4) < 3) {
    return;
  }

  if(var_01 == "front" && var_02 < 768) {
    thread func_F6ED();
    return;
  }

  if(var_01 == "rear_side" || var_01 == "rear" && var_02 >= 768) {
    playFX(level.var_114D8, self.origin);
    thread func_F6ED();
    return;
  }

  if(var_01 == "rear" && var_02 < 768) {
    func_11097();
    func_F6ED();
    wait(4);
    func_11096();
    return;
  }

  if(var_01 == "front_side" || var_01 == "front") {
    playFX(level.var_114D8, self.origin);
    func_11097();
    func_F6ED();
    wait(8);
    func_11096();
    return;
  }
}

relative_ads_anims(param_00) {
  self endon("death");
  param_00 endon("death");
  param_00 endon("disconnect");
  var_01 = anglesToForward(self.angles);
  var_02 = param_00.origin - self.origin;
  var_01 = var_01 * (1, 1, 0);
  var_02 = var_02 * (1, 1, 0);
  var_02 = vectornormalize(var_02);
  var_01 = vectornormalize(var_01);
  var_03 = vectordot(var_02, var_01);
  if(var_03 > 0) {
    if(var_03 > 0.9) {
      return "front";
    } else {
      return "front_side";
    }
  } else if(var_03 < -0.9) {
    return "rear";
  } else {
    return "rear_side";
  }

  param_00 iprintlnbold(var_03);
}

func_13A78() {
  self endon("death");
  for(;;) {
    var_00 = [];
    var_01 = level.players;
    foreach(var_03 in var_01) {
      if(!isDefined(var_03)) {
        wait(0.05);
        continue;
      }

      if(!istarget(var_03)) {
        wait(0.05);
        continue;
      }

      var_04 = var_03 getcurrentweapon();
      if(issubstr(var_04, "at4") || issubstr(var_04, "stinger") || issubstr(var_04, "javelin")) {
        thread func_89D4(var_03);
        wait(8);
      }

      wait(0.15);
    }
  }
}

func_3E2E() {
  if(!isDefined(self.triggerportableradarping) || !isDefined(self.triggerportableradarping.pers["team"]) || self.triggerportableradarping.pers["team"] != self.team) {
    self notify("abandoned");
    return 0;
  }

  return 1;
}

modifydamage(param_00, param_01, param_02) {
  if(param_00 == "MOD_RIFLE_BULLET") {
    return param_01;
  }

  if(param_00 == "MOD_PISTOL_BULLET") {
    return param_01;
  }

  if(param_00 == "MOD_IMPACT") {
    return param_01;
  }

  if(param_00 == "MOD_MELEE") {
    return 0;
  }

  if(param_00 == "MOD_EXPLOSIVE_BULLET") {
    return param_01;
  }

  if(param_00 == "MOD_GRENADE") {
    return param_01 * 5;
  }

  if(param_00 == "MOD_GRENADE_SPLASH") {
    return param_01 * 5;
  }

  return param_01 * 10;
}

func_5329() {
  self waittill("death");
  if(level.teambased) {
    var_00 = level.var_114B1.team;
    if(level.var_114B1.objid[var_00] != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_state(level.var_114B1.objid[var_00], "invisible");
    }

    if(level.var_114B1.objid[level.otherteam[var_00]] != -1) {
      scripts\mp\objidpoolmanager::minimap_objective_state(level.var_114B1.objid[level.otherteam[var_00]], "invisible");
    }
  }

  self notify("tankDestroyed");
  self vehicle_setspeed(0, 10, 10);
  level.var_114E2 = 0;
  playFX(level.var_10888, self.origin);
  playFX(level.var_114DD, self.origin);
  func_E11C();
  var_01 = spawn("script_model", self.origin);
  var_01 setModel("vehicle_m1a1_abrams_d_static");
  var_01.angles = self.angles;
  self.mgturret delete();
  self delete();
  wait(4);
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
    if(var_01["position"] != var_00) {
      thread func_698D(0, self.besttarget);
    }

    var_01 = bulletTrace(var_00, self.besttarget.origin, 1, self);
    var_02 = distance(self.origin, var_01["position"]);
    var_03 = distance(self.besttarget.origin, self.origin);
    if(var_02 < 384 || var_02 + 256 < var_03) {
      wait(0.5);
      if(var_02 > 384) {
        func_136F4();
        self fireweapon();
        self playSound("bmp_fire");
        self.var_118F3 = gettime();
      }

      var_04 = relative_ads_anims(self.besttarget);
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
  var_00 = gettime() - self.var_118F3;
  if(var_00 < 1499) {
    wait(1.5 - var_00 / 1000);
  }
}

func_114E1(param_00) {
  self endon("death");
  self endon("leaving");
  var_01 = [];
  for(;;) {
    var_01 = [];
    var_02 = level.players;
    if(isDefined(self.var_72B8)) {
      var_01 = [];
      var_01[0] = self.var_72B8;
      func_1572(var_01);
      self.var_72B8 = undefined;
    }

    if(isDefined(level.harrier) && level.harrier.team != self.team && isalive(level.harrier)) {
      if(func_9FF1(level.var_114B1)) {
        var_01[var_01.size] = level.var_114B1;
      }
    }

    if(isDefined(level.chopper) && level.chopper.team != self.team && isalive(level.chopper)) {
      if(func_9FF1(level.chopper)) {
        var_01[var_01.size] = level.chopper;
      }
    }

    foreach(var_04 in var_02) {
      if(!isDefined(var_04)) {
        wait(0.05);
        continue;
      }

      if(isDefined(param_00) && var_04 == param_00) {
        continue;
      }

      if(istarget(var_04)) {
        if(isDefined(var_04)) {
          var_01[var_01.size] = var_04;
        }

        continue;
      }

      continue;
    }

    if(var_01.size > 0) {
      func_1572(var_01);
      continue;
    }

    wait(1);
  }
}

func_1572(param_00) {
  self endon("death");
  if(param_00.size == 1) {
    self.besttarget = param_00[0];
  } else {
    self.besttarget = getbesttarget(param_00);
  }

  thread func_F6E3();
  thread func_13B74(param_00);
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

getbesttarget(param_00) {
  self endon("death");
  var_01 = self gettagorigin("tag_flash");
  var_02 = self.origin;
  var_03 = undefined;
  var_04 = undefined;
  var_05 = 0;
  foreach(var_07 in param_00) {
    var_08 = abs(vectortoangles(var_07.origin - self.origin)[1]);
    var_09 = abs(self gettagangles("tag_flash")[1]);
    var_08 = abs(var_08 - var_09);
    if(isDefined(level.chopper) && var_07 == level.chopper) {
      return var_07;
    }

    if(isDefined(level.harrier) && var_07 == level.harrier) {
      return var_07;
    }

    var_0A = var_07 getweaponslistitems();
    foreach(var_0C in var_0A) {
      if(issubstr(var_0C, "at4") || issubstr(var_0C, "jav") || issubstr(var_0C, "c4")) {
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

func_13B74(param_00) {
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

func_698D(param_00, param_01) {
  self endon("death");
  self notify("abandonedTarget");
  setstate();
  thread func_F7B8();
  removetargetmarkergroup();
  if(isDefined(param_01)) {
    self.var_275E = param_01;
    func_275F();
  }

  if(isDefined(param_00) && param_00) {}
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

func_9FF1(param_00) {
  if(distance2d(param_00.origin, self.origin) > 4096) {
    return 0;
  }

  if(distance(param_00.origin, self.origin) < 512) {
    return 0;
  }

  return func_12A8F(param_00, 0);
}

istarget(param_00) {
  self endon("death");
  var_01 = distancesquared(param_00.origin, self.origin);
  if(!level.teambased && isDefined(self.triggerportableradarping) && param_00 == self.triggerportableradarping) {
    return 0;
  }

  if(!isalive(param_00) || param_00.sessionstate != "playing") {
    return 0;
  }

  if(var_01 > 16777216) {
    return 0;
  }

  if(var_01 < 262144) {
    return 0;
  }

  if(!isDefined(param_00.pers["team"])) {
    return 0;
  }

  if(param_00 == self.triggerportableradarping) {
    return 0;
  }

  if(level.teambased && param_00.pers["team"] == self.team) {
    return 0;
  }

  if(param_00.pers["team"] == "spectator") {
    return 0;
  }

  if(isDefined(param_00.spawntime) && gettime() - param_00.spawntime / 1000 <= 5) {
    return 0;
  }

  if(param_00 scripts\mp\utility::_hasperk("specialty_blindeye")) {
    return 0;
  }

  return self vehicle_canturrettargetpoint(param_00.origin, 1, self);
}

func_12A8F(param_00, param_01) {
  var_02 = param_00 giveperks(self gettagorigin("tag_turret"), self);
  if(var_02 < 0.7) {
    return 0;
  }

  if(isDefined(param_01) && param_01) {
    thread scripts\mp\utility::drawline(param_00.origin, self gettagorigin("tag_turret"), 10, (1, 0, 0));
  }

  return 1;
}

func_9EA1(param_00) {
  self endon("death");
  if(!isalive(param_00) || param_00.sessionstate != "playing") {
    return 0;
  }

  if(!isDefined(param_00.pers["team"])) {
    return 0;
  }

  if(param_00 == self.triggerportableradarping) {
    return 0;
  }

  if(distancesquared(param_00.origin, self.origin) > 1048576) {
    return 0;
  }

  if(level.teambased && param_00.pers["team"] == self.team) {
    return 0;
  }

  if(param_00.pers["team"] == "spectator") {
    return 0;
  }

  if(isDefined(param_00.spawntime) && gettime() - param_00.spawntime / 1000 <= 5) {
    return 0;
  }

  if(isDefined(self)) {
    var_01 = self.mgturret.origin + (0, 0, 64);
    var_02 = param_00 giveperks(var_01, self);
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
    for(var_02 = 0; var_02 <= var_01.size; var_02++) {
      if(func_9EA1(var_01[var_02])) {
        if(isDefined(var_01[var_02])) {
          var_00[var_00.size] = var_01[var_02];
        }
      } else {
        continue;
      }

      wait(0.05);
    }

    if(var_00.size > 0) {
      func_1571(var_00);
      return;
    } else {
      wait(0.5);
    }
  }
}

func_7DFD(param_00) {
  self endon("death");
  var_01 = self.origin;
  var_02 = undefined;
  var_03 = undefined;
  foreach(var_05 in param_00) {
    var_06 = distance(self.origin, var_05.origin);
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

func_1571(param_00) {
  self endon("death");
  if(param_00.size == 1) {
    self.var_2A97 = param_00[0];
  } else {
    self.var_2A97 = func_7DFD(param_00);
  }

  if(distance2d(self.origin, self.var_2A97.origin) > 768) {
    thread func_F799();
  }

  self notify("acquiringMiniTarget");
  self.mgturret settargetentity(self.var_2A97, (0, 0, 64));
  wait(0.15);
  thread func_6D74();
  thread func_13AD1(param_00);
  thread func_13AD2(param_00);
  thread func_13AD3(self.var_2A97);
}

func_6D74() {
  self endon("death");
  self endon("abandonedMiniTarget");
  self endon("killedMiniTarget");
  var_00 = undefined;
  var_01 = gettime();
  if(!isDefined(self.var_2A97)) {
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

      wait(0.5);
      continue;
    }

    if(gettime() > var_01 + 1000 && !isDefined(self.besttarget)) {
      if(distance2d(self.origin, self.var_2A97.origin) > 768) {
        var_01[0] = self.var_2A97;
        func_1572(var_05);
      }
    }

    var_04 = randomintrange(10, 16);
    for(var_05 = 0; var_05 < var_04; var_05++) {
      self.mgturret shootturret();
      wait(0.1);
    }

    wait(randomfloatrange(0.5, 3));
  }
}

func_13AD1(param_00) {
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

func_13AD2(param_00) {
  self endon("abandonedMiniTarget");
  self endon("death");
  for(;;) {
    if(!isDefined(self.var_2A97)) {
      return;
    }

    var_01 = bulletTrace(self.mgturret.origin, self.var_2A97.origin, 0, self);
    var_02 = distance(self.origin, var_01["position"]);
    if(var_02 > 1024) {
      thread func_698C();
      return;
    }

    wait(2);
  }
}

func_13AD3(param_00) {
  self endon("abandonedMiniTarget");
  self endon("death");
  self endon("killedMiniTarget");
  for(;;) {
    var_01 = [];
    var_02 = level.players;
    for(var_03 = 0; var_03 <= var_02.size; var_03++) {
      if(func_9EA1(var_02[var_03])) {
        if(!isDefined(var_02[var_03])) {
          continue;
        }

        if(!isDefined(param_00)) {
          return;
        }

        var_04 = distance(self.origin, param_00.origin);
        var_05 = distance(self.origin, var_02[var_03].origin);
        if(var_05 < var_04) {
          thread func_698C();
          return;
        }
      }

      wait(0.05);
    }

    wait(0.25);
  }
}

func_698C(param_00) {
  self notify("abandonedMiniTarget");
  self.var_2A97 = undefined;
  self.mgturret cleartargetentity();
  if(isDefined(param_00) && param_00) {
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
  var_00 = [];
  foreach(var_02 in level.players) {
    if(var_02.team == "spectator") {
      continue;
    }

    if(var_02.team == self.team) {
      continue;
    }

    if(!isalive(var_02)) {
      continue;
    }

    var_02.var_56E8 = 0;
    var_00[var_00.size] = var_02;
  }

  if(!var_00.size) {
    return undefined;
  }

  for(var_04 = 0; var_04 < var_00.size; var_04++) {
    for(var_05 = var_04 + 1; var_05 < var_00.size; var_05++) {
      var_06 = distancesquared(var_00[var_04].origin, var_00[var_05].origin);
      var_00[var_04].var_56E8 = var_00[var_04].var_56E8 + var_06;
      var_00[var_05].var_56E8 = var_00[var_05].var_56E8 + var_06;
    }
  }

  var_07 = var_00[0];
  foreach(var_02 in var_00) {
    if(var_02.var_56E8 < var_07.var_56E8) {
      var_07 = var_02;
    }
  }

  var_0A = var_07.origin;
  var_0B = sortbydistance(level._meth_848E, var_0A);
  return var_0B[0];
}

func_FAD8() {
  var_00 = [];
  var_01 = [];
  var_02 = [];
  var_03 = [];
  var_04 = getvehiclenode("startnode", "targetname");
  var_00[var_00.size] = var_04;
  var_01[var_01.size] = var_04;
  while(isDefined(var_04.target)) {
    var_05 = var_04;
    var_04 = getvehiclenode(var_04.target, "targetname");
    var_04.var_D886 = var_05;
    if(var_04 == var_00[0]) {
      break;
    }

    var_00[var_00.size] = var_04;
    if(!isDefined(var_04.target)) {
      return;
    }
  }

  var_00[0].var_2F45 = [];
  var_00[0] thread func_897F("forward");
  var_03[var_03.size] = var_00[0];
  var_06 = getvehiclenodearray("branchnode", "targetname");
  foreach(var_08 in var_06) {
    var_04 = var_08;
    var_00[var_00.size] = var_04;
    var_01[var_01.size] = var_04;
    while(isDefined(var_04.target)) {
      var_05 = var_04;
      var_04 = getvehiclenode(var_04.target, "targetname");
      var_00[var_00.size] = var_04;
      var_04.var_D886 = var_05;
      if(!isDefined(var_04.target)) {
        var_02[var_02.size] = var_04;
      }
    }
  }

  foreach(var_04 in var_00) {
    var_0B = 0;
    foreach(var_0D in var_01) {
      if(var_0D == var_04) {
        continue;
      }

      if(var_0D.target == var_04.var_336) {
        continue;
      }

      if(isDefined(var_04.target) && var_04.target == var_0D.var_336) {
        continue;
      }

      if(distance2d(var_04.origin, var_0D.origin) > 80) {
        continue;
      }

      var_0D thread func_8982(var_04, "reverse");
      var_0D.var_D886 = var_04;
      if(!isDefined(var_04.var_2F45)) {
        var_04.var_2F45 = [];
      }

      var_04.var_2F45[var_04.var_2F45.size] = var_0D;
      var_0B = 1;
    }

    if(var_0B) {
      var_04 thread func_897F("forward");
    }

    var_0F = 0;
    foreach(var_11 in var_02) {
      if(var_11 == var_04) {
        continue;
      }

      if(!isDefined(var_04.target)) {
        continue;
      }

      if(var_04.target == var_11.var_336) {
        continue;
      }

      if(isDefined(var_11.target) && var_11.target == var_04.var_336) {
        continue;
      }

      if(distance2d(var_04.origin, var_11.origin) > 80) {
        continue;
      }

      var_11 thread func_8982(var_04, "forward");
      var_11.var_BF2E = getvehiclenode(var_04.var_336, "targetname");
      var_11.var_AB5D = distance(var_11.origin, var_04.origin);
      if(!isDefined(var_04.var_2F45)) {
        var_04.var_2F45 = [];
      }

      var_04.var_2F45[var_04.var_2F45.size] = var_11;
      var_0F = 1;
    }

    if(var_0F) {
      var_04 thread func_897F("reverse");
    }

    if(var_0F || var_0B) {
      var_03[var_03.size] = var_04;
    }
  }

  if(var_03.size < 3) {
    level notify("end_tankPathHandling");
    return;
  }

  var_14 = [];
  foreach(var_04 in var_00) {
    if(!isDefined(var_04.var_2F45)) {
      continue;
    }

    var_14[var_14.size] = var_04;
  }

  foreach(var_18 in var_14) {
    var_04 = var_18;
    var_19 = 0;
    while(isDefined(var_04.target)) {
      var_1A = var_04;
      var_04 = getvehiclenode(var_04.target, "targetname");
      var_19 = var_19 + distance(var_04.origin, var_1A.origin);
      if(var_04 == var_18) {
        break;
      }

      if(isDefined(var_04.var_2F45)) {
        break;
      }
    }

    if(var_19 > 1000) {
      var_04 = var_18;
      var_1B = 0;
      while(isDefined(var_04.target)) {
        var_1A = var_04;
        var_04 = getvehiclenode(var_04.target, "targetname");
        var_1B = var_1B + distance(var_04.origin, var_1A.origin);
        if(var_1B < var_19 / 2) {
          continue;
        }

        var_04.var_2F45 = [];
        var_04 thread func_897F("forward");
        var_03[var_03.size] = var_04;
        break;
      }
    }
  }

  level._meth_848E = func_98A6(var_03);
  foreach(var_04 in var_00) {
    if(!isDefined(var_04._meth_848D)) {
      var_04 thread func_C059();
    }
  }
}

dontinterpolate(param_00) {
  var_01 = [];
  foreach(var_04, var_03 in self.var_AD40) {
    if(self.var_AD17[var_04] != param_00) {
      continue;
    }

    var_01[var_01.size] = var_03;
  }

  return var_01[randomint(var_01.size)];
}

func_7FE9(param_00, param_01) {
  var_02 = level._meth_848E[self._meth_848D];
  var_03 = func_7732(var_02, param_00, undefined, param_01);
  var_04 = var_03[0].var_7646;
  var_05 = func_7732(var_02, param_00, undefined, level.var_C74A[param_01]);
  var_06 = var_05[0].var_7646;
  if(!getdvarint("tankDebug")) {
    var_06 = 9999999;
  }

  if(var_04 <= var_06) {
    return var_03[1];
  }
}

func_897F(param_00) {
  level endon("end_tankPathHandling");
  for(;;) {
    self waittill("trigger", var_01, var_02);
    var_03 = level._meth_848E[self._meth_848D];
    var_01.target_getindexoftarget = self;
    var_04 = undefined;
    if(isDefined(var_01.endnode) && var_01.endnode != var_03) {
      var_04 = func_7FE9(var_01.endnode, var_01.var_376);
      if(!isDefined(var_04)) {
        var_01 thread func_F6C4(level.var_C74A[var_01.var_376]);
      }
    }

    if(!isDefined(var_04) || var_04 == var_03) {
      var_04 = var_03 dontinterpolate(var_01.var_376);
    }

    var_05 = var_03.var_AD41[var_04._meth_848D];
    if(var_01.var_376 == "forward") {
      var_06 = func_7FE8();
    } else {
      var_06 = _meth_809A();
    }

    if(var_06 != var_05) {
      var_01 startpath(var_05);
    }
  }
}

func_8982(param_00, param_01) {
  for(;;) {
    self waittill("trigger", var_02);
    if(var_02.var_376 != param_01) {
      continue;
    }

    func_4F52("tank starting path at join node: " + param_00._meth_848D);
    var_02 startpath(param_00);
  }
}

func_C059() {
  self.var_7334 = func_7EC4()._meth_848D;
  self.var_E492 = _meth_80EF()._meth_848D;
  for(;;) {
    self waittill("trigger", var_00, var_01);
    var_00.target_getindexoftarget = self;
    var_00.var_7334 = self.var_7334;
    var_00.var_E492 = self.var_E492;
    if(!isDefined(self.target) || self.var_336 == "branchnode") {
      var_02 = "TRANS";
    } else {
      var_02 = "NODE";
    }

    if(isDefined(var_01)) {
      func_4F50(self.origin, var_02, (1, 0.5, 0), 1, 2, 100);
      continue;
    }

    func_4F50(self.origin, var_02, (0, 1, 0), 1, 2, 100);
  }
}

func_72EA(param_00, param_01, param_02) {
  param_01 endon("trigger");
  param_00 endon("trigger");
  param_02 endon("death");
  var_03 = distancesquared(param_02.origin, param_01.origin);
  var_04 = param_02.var_376;
  func_4F50(param_00.origin + (0, 0, 30), "LAST", (0, 0, 1), 0.5, 1, 100);
  func_4F50(param_01.origin + (0, 0, 60), "NEXT", (0, 1, 0), 0.5, 1, 100);
  var_05 = 0;
  for(;;) {
    wait(0.05);
    if(var_04 != param_02.var_376) {
      func_4F52("tank missed node: reversing direction");
      param_02 thread func_72EA(param_01, param_00, param_02);
      return;
    }

    if(var_05) {
      func_4F52("... sending notify.");
      param_01 notify("trigger", param_02, 1);
      return;
    }

    var_06 = distancesquared(param_02.origin, param_01.origin);
    if(var_06 > var_03) {
      var_05 = 1;
      func_4F52("tank missed node: forcing notify in one frame...");
    }

    var_03 = var_06;
  }
}

func_7EC4() {
  for(var_00 = self; !isDefined(var_00._meth_848D); var_00 = var_00 func_7FE8()) {}

  return var_00;
}

_meth_80EF() {
  for(var_00 = self; !isDefined(var_00._meth_848D); var_00 = var_00 _meth_809A()) {}

  return var_00;
}

func_7FE8() {
  if(isDefined(self.target)) {
    return getvehiclenode(self.target, "targetname");
  }

  return self.var_BF2E;
}

_meth_809A() {
  return self.var_D886;
}

func_98A6(param_00) {
  var_01 = [];
  foreach(var_03 in param_00) {
    var_04 = spawnStruct();
    var_04.var_AD35 = [];
    var_04.var_AD40 = [];
    var_04.var_AD36 = [];
    var_04.var_AD17 = [];
    var_04.var_AD41 = [];
    var_04.target_getindexoftarget = var_03;
    var_04.origin = var_03.origin;
    var_04._meth_848D = var_01.size;
    var_03._meth_848D = var_01.size;
    func_4F50(var_04.origin + (0, 0, 80), var_04._meth_848D, (1, 1, 1), 0.65, 2, 100000);
    var_01[var_01.size] = var_04;
  }

  foreach(var_03 in param_00) {
    var_07 = var_03._meth_848D;
    var_08 = getvehiclenode(var_03.target, "targetname");
    var_09 = distance(var_03.origin, var_08.origin);
    var_0A = var_08;
    while(!isDefined(var_08._meth_848D)) {
      var_09 = var_09 + distance(var_08.origin, var_08.var_D886.origin);
      if(isDefined(var_08.target)) {
        var_08 = getvehiclenode(var_08.target, "targetname");
        continue;
      }

      var_08 = var_08.var_BF2E;
    }

    var_01[var_07] func_17EC(var_01[var_08._meth_848D], var_09, "forward", var_0A);
    var_08 = var_03.var_D886;
    var_09 = distance(var_03.origin, var_08.origin);
    var_0A = var_08;
    while(!isDefined(var_08._meth_848D)) {
      var_09 = var_09 + distance(var_08.origin, var_08.var_D886.origin);
      var_08 = var_08.var_D886;
    }

    var_01[var_07] func_17EC(var_01[var_08._meth_848D], var_09, "reverse", var_0A);
    foreach(var_0C in var_03.var_2F45) {
      var_08 = var_0C;
      var_09 = distance(var_03.origin, var_08.origin);
      var_0A = var_08;
      if(var_08.var_336 == "branchnode") {
        while(!isDefined(var_08._meth_848D)) {
          if(isDefined(var_08.target)) {
            var_0D = getvehiclenode(var_08.target, "targetname");
          } else {
            var_0D = var_08.var_BF2E;
          }

          var_09 = var_09 + distance(var_08.origin, var_0D.origin);
          var_08 = var_0D;
        }

        var_01[var_07] func_17EC(var_01[var_08._meth_848D], var_09, "forward", var_0A);
        continue;
      }

      while(!isDefined(var_08._meth_848D)) {
        var_09 = var_09 + distance(var_08.origin, var_08.var_D886.origin);
        var_08 = var_08.var_D886;
      }

      var_01[var_07] func_17EC(var_01[var_08._meth_848D], var_09, "reverse", var_0A);
    }
  }

  return var_01;
}

func_17EC(param_00, param_01, param_02, param_03) {
  self.var_AD40[param_00._meth_848D] = param_00;
  self.var_AD36[param_00._meth_848D] = param_01;
  self.var_AD17[param_00._meth_848D] = param_02;
  self.var_AD41[param_00._meth_848D] = param_03;
  var_04 = spawnStruct();
  var_04.var_119D3 = param_00;
  var_04.var_119D2 = param_00._meth_848D;
  var_04.var_AB5D = param_01;
  var_04.var_F2 = param_02;
  var_04.var_10DCD = param_03;
  self.var_AD35[param_00._meth_848D] = var_04;
}

func_7732(param_00, param_01, param_02, param_03) {
  level.var_C62D = [];
  level.var_428F = [];
  var_04 = 0;
  var_05 = [];
  if(!isDefined(param_02)) {
    param_02 = [];
  }

  param_01.var_7646 = 0;
  param_01.var_877B = func_7F0A(param_01, param_00);
  param_01.var_6A62 = param_01.var_7646 + param_01.var_877B;
  func_184C(param_01);
  var_06 = param_01;
  for(;;) {
    foreach(var_08 in var_06.var_AD40) {
      if(scripts\engine\utility::array_contains(param_02, var_08)) {
        continue;
      }

      if(scripts\engine\utility::array_contains(level.var_428F, var_08)) {
        continue;
      }

      if(isDefined(param_03) && var_08.var_AD17[var_06._meth_848D] != param_03) {
        continue;
      }

      if(!scripts\engine\utility::array_contains(level.var_C62D, var_08)) {
        addtoopenlist(var_08);
        var_08.var_C8F6 = var_06;
        var_08.var_7646 = func_7EED(var_08, var_06);
        var_08.var_877B = func_7F0A(var_08, param_00);
        var_08.var_6A62 = var_08.var_7646 + var_08.var_877B;
        if(var_08 == param_00) {
          var_04 = 1;
        }

        continue;
      }

      if(var_08.var_7646 < func_7EED(var_06, var_08)) {
        continue;
      }

      var_08.var_C8F6 = var_06;
      var_08.var_7646 = func_7EED(var_08, var_06);
      var_08.var_6A62 = var_08.var_7646 + var_08.var_877B;
    }

    if(var_04) {
      break;
    }

    func_184C(var_06);
    var_0A = level.var_C62D[0];
    foreach(var_0C in level.var_C62D) {
      if(var_0C.var_6A62 > var_0A.var_6A62) {
        continue;
      }

      var_0A = var_0C;
    }

    func_184C(var_0A);
    var_06 = var_0A;
  }

  var_06 = param_00;
  while(var_06 != param_01) {
    var_05[var_05.size] = var_06;
    var_06 = var_06.var_C8F6;
  }

  var_05[var_05.size] = var_06;
  return var_05;
}

addtoopenlist(param_00) {
  param_00.var_C62E = level.var_C62D.size;
  level.var_C62D[level.var_C62D.size] = param_00;
  param_00.var_4290 = undefined;
}

func_184C(param_00) {
  if(isDefined(param_00.var_4290)) {
    return;
  }

  param_00.var_4290 = level.var_428F.size;
  level.var_428F[level.var_428F.size] = param_00;
  if(!scripts\engine\utility::array_contains(level.var_C62D, param_00)) {
    return;
  }

  level.var_C62D[param_00.var_C62E] = level.var_C62D[level.var_C62D.size - 1];
  level.var_C62D[param_00.var_C62E].var_C62E = param_00.var_C62E;
  level.var_C62D[level.var_C62D.size - 1] = undefined;
  param_00.var_C62E = undefined;
}

func_7F0A(param_00, param_01) {
  return distance(param_00.target_getindexoftarget.origin, param_01.target_getindexoftarget.origin);
}

func_7EED(param_00, param_01) {
  return param_00.var_C8F6.var_7646 + param_00.var_AD36[param_01._meth_848D];
}

drawpath(param_00) {
  for(var_01 = 1; var_01 < param_00.size; var_01++) {
    var_02 = param_00[var_01 - 1];
    var_03 = param_00[var_01];
    if(var_02.var_AD17[var_03._meth_848D] == "reverse") {
      level thread func_5B7C(var_02.target_getindexoftarget.origin, var_03.target_getindexoftarget.origin, (1, 0, 0));
    } else {
      level thread func_5B7C(var_02.target_getindexoftarget.origin, var_03.target_getindexoftarget.origin, (0, 1, 0));
    }

    var_04 = var_02.var_AD41[var_03._meth_848D];
    level thread func_5B7C(var_02.target_getindexoftarget.origin + (0, 0, 4), var_04.origin + (0, 0, 4), (0, 0, 1));
    if(var_02.var_AD17[var_03._meth_848D] == "reverse") {
      while(!isDefined(var_04._meth_848D)) {
        var_05 = var_04;
        var_04 = var_04.var_D886;
        level thread func_5B7C(var_05.origin + (0, 0, 4), var_04.origin + (0, 0, 4), (0, 1, 1));
      }

      continue;
    }

    while(!isDefined(var_04._meth_848D)) {
      var_05 = var_04;
      if(isDefined(var_04.target)) {
        var_04 = getvehiclenode(var_04.target, "targetname");
        continue;
      }

      var_04 = var_04.var_BF2E;
      level thread func_5B7C(var_05.origin + (0, 0, 4), var_04.origin + (0, 0, 4), (0, 1, 1));
    }
  }
}

drawgraph(param_00) {}

func_5B7C(param_00, param_01, param_02) {
  level endon("endpath");
  wait(0.05);
}

func_4F52(param_00) {}

debugprint(param_00) {}

func_4F50(param_00, param_01, param_02, param_03, param_04, param_05) {}

func_5B8B() {}