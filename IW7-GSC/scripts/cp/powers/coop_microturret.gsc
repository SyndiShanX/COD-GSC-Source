/**************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\powers\coop_microturret.gsc
**************************************************/

init() {
  if(!isDefined(level.sentrysettings)) {
    level.sentrysettings = [];
  }

  level._effect["microturret_lockon"] = loadfx("vfx\iw7\_requests\mp\super\vfx_microturret_lockon.vfx");
  if(!isDefined(level.microturrets)) {
    level.microturrets = [];
  }

  level._effect["shoulder_cannon_charge"] = loadfx("vfx\old\misc\shoulder_cannon_charge");
  level.sentrysettings["sentry_microturret"] = spawnStruct();
  level.sentrysettings["sentry_microturret"].health = 999999;
  level.sentrysettings["sentry_microturret"].maxhealth = 300;
  level.sentrysettings["sentry_microturret"].burstmin = 10;
  level.sentrysettings["sentry_microturret"].burstmax = 20;
  level.sentrysettings["sentry_microturret"].pausemin = 0.5;
  level.sentrysettings["sentry_microturret"].pausemax = 0.75;
  level.sentrysettings["sentry_microturret"].sentrymodeon = "sentry";
  level.sentrysettings["sentry_microturret"].sentrymodeoff = "sentry_offline";
  level.sentrysettings["sentry_microturret"].timeout = 90;
  level.sentrysettings["sentry_microturret"].spinuptime = 0.2;
  level.sentrysettings["sentry_microturret"].overheattime = 8;
  level.sentrysettings["sentry_microturret"].cooldowntime = 0.1;
  level.sentrysettings["sentry_microturret"].fxtime = 0.3;
  level.sentrysettings["sentry_microturret"].streakname = "sentry";
  level.sentrysettings["sentry_microturret"].weaponinfo = "micro_turret_gun_zm";
  level.sentrysettings["sentry_microturret"].modelbase = "vehicle_drone_backup_buddy_gun";
  level.sentrysettings["sentry_microturret"].modelplacement = "weapon_sentry_chaingun_obj";
  level.sentrysettings["sentry_microturret"].modelplacementfailed = "weapon_sentry_chaingun_obj_red";
  level.sentrysettings["sentry_microturret"].modeldestroyed = "vehicle_drone_backup_buddy_gun";
  level.sentrysettings["sentry_microturret"].hintstring = &"SENTRY_PICKUP";
  level.sentrysettings["sentry_microturret"].playerphysicstrace = 1;
  level.sentrysettings["sentry_microturret"].teamsplash = "used_sentry";
  level.sentrysettings["sentry_microturret"].shouldsplash = 0;
  level.sentrysettings["sentry_microturret"].vodestroyed = "sentry_destroyed";
  level.sentrysettings["sentry_microturret"].scorepopup = "destroyed_sentry";
  level.sentrysettings["sentry_microturret"].lightfxtag = "tag_fx";
}

func_E13D() {
  self notify("remove_microTurret");
}

microturret_use(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("remove_microTurret");
  var_1 = "power_microTurret";
  if(!scripts\cp\utility::isreallyalive(self)) {
    var_0 delete();
    return;
  }

  var_0 waittill("missile_stuck", var_2);
  if(isDefined(var_2) && isDefined(var_2.owner)) {
    thread placementfailed(var_0);
    return;
  }

  if(!scripts\cp\cp_weapon::isinvalidzone(var_0.origin, level.invalid_spawn_volume_array, self, undefined, 0)) {
    thread placementfailed(var_0);
    return;
  }

  self notify("powers_microTurret_used");
  self playlocalsound("trophy_turret_plant_plr");
  self playsoundtoteam("trophy_turret_plant_npc", "allies", self);
  self playsoundtoteam("trophy_turret_plant_npc", "axis", self);
  var_3 = spawnturret("misc_turret", var_0.origin, "micro_turret_gun_zm");
  var_3 setModel("micro_turret_wm");
  var_3.angles = var_0.angles;
  var_3.owner = self;
  var_3.team = self.team;
  var_3.weapon_name = "micro_turret_zm";
  var_3 getvalidattachments();
  var_3 makeunusable();
  self.vehicle = var_3;
  var_3.var_1E2D = 100;
  if(level.teambased) {
    var_3 setturretteam(self.team);
  }

  var_3.sentrytype = "sentry_microturret";
  var_3 give_player_session_tokens("sentry_offline");
  var_3 setsentryowner(self);
  var_3 setleftarc(180);
  var_3 setrightarc(180);
  var_3 give_crafted_gascan(90);
  var_3 settoparc(45);
  var_3 func_82C9(0.3, "pitch");
  var_3 func_82C9(0.3, "yaw");
  var_3 func_82C8(0.65);
  var_3 thread func_B6EA();
  var_3 setotherent(self);
  if(isDefined(var_2)) {
    var_3 scripts\cp\cp_weapon::explosivehandlemovers(var_2);
  }

  var_3.var_1A4A = scripts\engine\utility::spawn_tag_origin(var_3.origin, var_3.angles);
  var_3.var_1A4A linkto(var_3, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_3 thread sentry_handledamage();
  var_3 thread sentry_handledeath();
  var_3 thread func_13A7A(self);
  var_3 setCanDamage(0);
  var_3.stunned = 0;
  var_3 thread func_139C8();
  thread watchforplayerdeath(var_3);
  var_0 delete();
}

sentry_handledamage() {
  self endon("death");
  level endon("game_ended");
  self.health = level.sentrysettings[self.sentrytype].health;
  self.maxhealth = level.sentrysettings[self.sentrytype].maxhealth;
  self.var_E1 = 0;
  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    if(!scripts\cp\cp_damage::friendlyfirecheck(self.owner, var_1, 0)) {
      continue;
    }

    if(isDefined(var_8) && var_8 &level.idflags_penetration) {
      self.wasdamagedfrombulletpenetration = 1;
    }

    if(var_4 == "MOD_MELEE") {
      self.var_E1 = self.var_E1 + self.maxhealth;
    }

    var_10 = var_0;
    if(isPlayer(var_1)) {
      var_1 scripts\cp\cp_damage::updatedamagefeedback("sentry");
      if(var_1 scripts\cp\utility::_hasperk("specialty_armorpiercing")) {
        var_10 = var_0 * level.armorpiercingmod;
      }
    }

    if(isDefined(var_1.owner) && isPlayer(var_1.owner)) {
      var_1.owner scripts\cp\cp_damage::updatedamagefeedback("sentry");
    }

    self.var_E1 = self.var_E1 + var_10;
    if(self.var_E1 >= self.maxhealth) {
      if(isPlayer(var_1) && !isDefined(self.owner) || var_1 != self.owner) {
        var_1 notify("destroyed_killstreak");
      }

      if(isDefined(self.owner)) {
        self.owner thread scripts\cp\utility::leaderdialogonplayer(level.sentrysettings[self.sentrytype].vodestroyed, undefined, undefined, self.origin);
      }

      self notify("death");
      return;
    }
  }
}

sentry_handledeath() {
  self waittill("death");
  if(!isDefined(self)) {
    return;
  }

  self freeentitysentient();
  self setModel(level.sentrysettings[self.sentrytype].modeldestroyed);
  sentry_setinactive();
  self setdefaultdroppitch(40);
  if(isDefined(self.carriedby)) {
    self setsentrycarrier(undefined);
  }

  self setsentryowner(undefined);
  self setturretminimapvisible(0);
  if(isDefined(self.ownertrigger)) {
    self.ownertrigger delete();
  }

  self playSound("sentry_explode");
  switch (self.sentrytype) {
    case "gl_turret":
    case "minigun_turret":
      self.forcedisable = 1;
      self turretfiredisable();
      break;

    default:
      break;
  }

  if(isDefined(self)) {
    thread func_F23F();
  }
}

sentry_setinactive() {
  self give_player_session_tokens(level.sentrysettings[self.sentrytype].sentrymodeoff);
  self makeunusable();
  var_0 = self getentitynumber();
  switch (self.sentrytype) {
    case "gl_turret":
      break;

    default:
      func_E11F(var_0);
      break;
  }

  if(level.teambased) {
    scripts\cp\utility::setteamheadicon("none", (0, 0, 0));
    return;
  }

  if(isDefined(self.owner)) {
    scripts\cp\utility::setplayerheadicon(undefined, (0, 0, 0));
  }
}

func_E11F(var_0) {
  level.turrets[var_0] = undefined;
}

func_F23F() {
  self notify("sentry_delete_turret");
  self endon("sentry_delete_turret");
  if(isDefined(self.inuseby)) {
    self.inuseby restoreperks();
    self.inuseby restoreweapons();
    self notify("deleting");
    self useby(self.inuseby);
    wait(1);
  } else {
    wait(1.5);
    self playSound("sentry_explode_smoke");
    wait(0.1);
    self notify("deleting");
  }

  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  if(isDefined(self)) {
    self delete();
  }
}

restoreperks() {
  if(isDefined(self.restoreperk)) {
    scripts\cp\utility::giveperk(self.restoreperk);
    self.restoreperk = undefined;
  }
}

restoreweapons() {
  if(isDefined(self.restoreweapon)) {
    scripts\cp\utility::_giveweapon(self.restoreweapon);
    self.restoreweapon = undefined;
  }
}

watchforplayerdeath(var_0) {
  self notify("turret_deleted");
  self endon("turret_deleted");
  var_0 endon("death");
  scripts\engine\utility::waittill_any("death", "disconnect");
  var_0 delete();
  self notify("microTurret_update", -1);
}

func_13A7A(var_0) {
  self waittill("death");
  var_0 notify("microTurret_update", -1);
}

func_139C8() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self waittill("emp_damage", var_0, var_1);
    func_B713(var_1);
  }
}

func_B713() {
  self give_player_session_tokens("sentry_offline");
  func_B6F1();
}

func_B6EA() {
  self endon("death");
  level endon("game_ended");
  self.var_1E2D = 100;
  wait(1);
  for(;;) {
    if(!self.stunned && !func_B701()) {
      func_B717();
    }

    if(!self.stunned && func_B701()) {
      func_B6EB();
    }

    if(self.stunned) {
      func_B713();
    }

    scripts\engine\utility::waitframe();
  }
}

func_B701() {
  return isDefined(self.var_1A4A) && isDefined(self.var_1A4A.var_23EA);
}

func_B717() {
  self endon("stunned");
  self endon("death");
  if(isDefined(self.owner)) {
    self.owner endon("disconnect");
  }

  self give_player_session_tokens("manual");
  self laseroff();
  if(func_B701()) {
    func_B6F1();
  }

  for(;;) {
    var_0 = anglesToForward(self gettagangles("tag_flash"));
    var_1 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
    var_2 = [];
    var_3 = [];
    foreach(var_5 in var_1) {
      if(!func_B71A(var_5)) {
        continue;
      }

      var_6 = var_5.origin - self gettagorigin("tag_dummy");
      var_7 = vectornormalize(var_6);
      var_8 = vectordot(var_6, var_7);
      var_9 = scripts\engine\utility::anglebetweenvectorsunit(var_0, var_7);
      var_10 = 1 - var_8 / 800;
      var_11 = 1 - var_9 / 180;
      var_12 = var_10 * 0.5 + var_11 * 0.8;
      var_2[var_2.size] = var_5;
      var_3[var_3.size] = var_12;
    }

    for(;;) {
      var_14 = 0;
      for(var_15 = 0; var_15 < var_2.size - 1; var_15++) {
        var_10 = var_2[var_15];
        var_11 = var_3[var_15];
        if(var_11 < var_3[var_15]) {
          var_2[var_15] = var_2[var_15 + 1];
          var_3[var_15] = var_3[var_15 + 1];
          var_2[var_15 + 1] = var_10;
          var_3[var_15 + 1] = var_11;
          var_14 = 1;
        }
      }

      if(!var_14) {
        break;
      }
    }

    for(var_15 = 0; var_15 < var_2.size; var_15++) {
      var_12 = var_2[var_15];
      var_13 = func_B714(var_12);
      if(isDefined(var_13)) {
        func_B70D(var_12, var_13);
        return;
      }
    }

    wait(0.1);
  }
}

func_B70D(var_0, var_1) {
  if(!isDefined(self.var_1A4A)) {
    return 0;
  }

  self.var_1A4A.var_23EA = var_0;
  self.var_1A4A.var_23EB = var_1;
  self.var_1A4A linkto(var_0, var_1, (0, 0, 0), (0, 0, 0));
  self settargetentity(self.var_1A4A);
}

func_B714(var_0) {
  var_1 = undefined;
  var_2 = physics_createcontents(["physicscontents_solid", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_ainosight", "physicscontents_sky"]);
  var_3 = self gettagorigin("tag_dummy");
  if(isDefined(var_0.agent_type) && var_0.agent_type == "zombie_brute") {
    return undefined;
  }

  if(isPlayer(var_0) || isagent(var_0)) {
    var_4 = "j_spine4";
    var_5 = var_0 gettagorigin(var_4);
    if(!isDefined(var_1)) {
      var_6 = physics_raycast(var_3, var_5, var_2, self, 0, "physicsquery_closest");
      var_7 = !isDefined(var_6) || var_6.size == 0;
      var_1 = scripts\engine\utility::ter_op(var_7, var_4, var_1);
    }

    if(!isDefined(var_1)) {
      if(!scripts\cp\utility::has_tag(var_0.model, "tag_eye")) {
        return undefined;
      }

      var_4 = "tag_eye";
      var_5 = var_0 gettagorigin(var_4);
      if(!isDefined(var_1)) {
        var_6 = physics_raycast(var_3, var_5, var_2, self, 0, "physicsquery_closest");
        var_7 = !isDefined(var_6) || var_6.size == 0;
        var_1 = scripts\engine\utility::ter_op(var_7, var_4, var_1);
      }
    }

    if(!isDefined(var_1)) {
      var_5 = var_0.origin;
      if(!isDefined(var_1)) {
        var_6 = physics_raycast(var_3, var_5, var_2, self, 0, "physicsquery_closest");
        var_7 = !isDefined(var_6) || var_6.size == 0;
        var_1 = scripts\engine\utility::ter_op(var_7, var_4, var_1);
      }
    }
  } else {
    var_4 = "tag_origin";
    var_5 = var_1 gettagorigin(var_5);
    if(!isDefined(var_1)) {
      var_6 = physics_raycast(var_3, var_5, var_2, self, 0, "physicsquery_closest");
      var_7 = !isDefined(var_6) || var_6.size == 0;
      var_1 = scripts\engine\utility::ter_op(var_7, var_4, var_1);
    }
  }

  return var_1;
}

func_B6F1() {
  if(isDefined(self.var_1A4A)) {
    self.var_1A4A linkto(self, "tag_origin", (0, 0, 0), (0, 0, 0));
    self.var_1A4A.var_23EA = undefined;
    self.var_1A4A.var_23EB = undefined;
  }

  self cleartargetentity();
}

func_B71A(var_0) {
  if(isPlayer(var_0) || isagent(var_0)) {
    if(!isalive(var_0)) {
      return 0;
    }
  }

  if(self.team == var_0.team) {
    return 0;
  }

  if(distancesquared(var_0.origin, self.origin) > 640000) {
    return 0;
  }

  return 1;
}

func_B6EB() {
  self endon("stunned");
  self endon("lostTarget");
  self give_player_session_tokens("manual");
  self laseron();
  thread func_B721();
  func_B704();
  func_B6EC();
}

func_B6EC() {
  var_0 = weaponfiretime("micro_turret_gun_zm");
  for(;;) {
    if(func_B701()) {
      var_1 = self func_8161(0);
      if(!isDefined(self.var_1A4A)) {
        self settargetentity(self.var_1A4A);
      }

      if(func_B715()) {
        self shootturret();
        self.var_1E2D--;
        if(self.var_1E2D <= 0) {
          self.owner thread func_B6F4(self);
        }
      }

      wait(var_0);
      continue;
    }

    scripts\engine\utility::waitframe();
  }
}

func_B715() {
  return isDefined(self.var_1A4A) && isDefined(self.var_1A4A.var_23EB);
}

func_B6F4(var_0) {
  var_0 notify("death");
}

func_B6F5() {
  self notify("microTurret_destroyAll");
  if(isDefined(self.microturrets)) {
    foreach(var_1 in self.microturrets) {
      func_B6F4(var_1);
    }
  }

  self.microturrets = undefined;
}

func_B721() {
  self endon("death");
  self endon("stunned");
  level endon("game_ended");
  func_B722();
  func_B6F1();
  self notify("lostTarget");
}

func_B704() {
  playFXOnTag(scripts\engine\utility::getfx("microturret_lockon"), self, "tag_flash");
  var_0 = func_B6FD();
  if(isPlayer(var_0) || isagent(var_0)) {
    thread func_B705(var_0);
  }

  wait(0.6);
  self notify("lockOnEnded");
}

func_B705(var_0) {
  self endon("lockOnEnded");
  var_0 endon("death");
  var_0 endon("disconnect");
  var_1 = 0;
  var_2 = 0.2;
  for(;;) {
    var_0 playlocalsound("ball_drone_targeting");
    wait(var_2);
    var_1 = var_1 + var_2;
  }

  var_0 playlocalsound("ball_drone_lockon");
}

func_B6FD() {
  if(func_B701()) {
    return self.var_1A4A.var_23EA;
  }

  return undefined;
}

func_B722() {
  var_0 = func_B6FD();
  var_0 endon("death");
  var_0 endon("disconnect");
  var_1 = undefined;
  var_2 = func_B6FD();
  while(isDefined(var_2) && var_2 == var_0) {
    var_2 = func_B6FD();
    if(!isDefined(var_2) || var_2 != var_0) {
      break;
    }

    if(var_2 scripts\cp\utility::_hasperk("specialty_blindeye")) {
      break;
    }

    if(isDefined(var_1) && gettime() > var_1) {
      break;
    }

    var_3 = func_B714(var_2);
    if(!isDefined(var_3)) {
      if(!isDefined(var_1)) {
        var_1 = gettime() + 1000;
      }

      wait(0.1);
      continue;
    }

    func_B70D(var_2, var_3);
    var_1 = undefined;
    wait(0.1);
  }
}

func_B6EE(var_0) {
  self endon("turret_toggle");
  self endon("death");
  self endon("stop_shooting");
  level endon("game_ended");
  var_1 = self;
  var_2 = level._effect["shoulder_cannon_charge"];
  var_3 = weaponfiretime("micro_turret_gun_zm");
  var_4 = 0.01;
  while(self.var_1E2D > 0) {
    if(self.var_1E2D <= 20) {
      var_5 = self.var_1E2D;
    } else {
      var_5 = randomintrange(10, 20);
    }

    for(var_6 = 0; var_6 < var_5; var_6++) {
      if(isDefined(var_1.inactive) && var_1.inactive) {
        break;
      }

      var_7 = self getturrettarget(1);
      if(isDefined(var_7) && canbetargeted(var_7)) {
        self shootturret();
        wait(var_3);
        self.var_1E2D--;
        if(self.var_1E2D < 0) {
          self.var_1E2D = 0;
        }

        var_0 notify("microTurret_update", self.var_1E2D * var_4);
        if(isDefined(var_0.var_38D8)) {
          var_0.var_38D8 delete();
        }
      }
    }

    wait(randomfloatrange(0.5, 0.75));
  }

  if(self.var_1E2D <= 0) {
    waittillframeend;
    var_0 notify("turret_deleted");
    self delete();
  }
}

balldrone_burstfirestop(var_0, var_1) {
  var_2 = level._effect["shoulder_cannon_charge"];
  playFXOnTag(var_2, self, "tag_flash");
  var_3 = self getturrettarget(0);
  while(var_0 > 0) {
    var_1 playlocalsound("ball_drone_targeting");
    wait(0.2);
    var_0 = var_0 - 0.2;
  }

  var_1 playlocalsound("ball_drone_lockon");
}

func_B6EF() {
  self notify("stop_shooting");
  if(isDefined(self.idletarget)) {
    self setlookatent(self.idletarget);
  }
}

canbetargeted(var_0) {
  var_1 = 1;
  if(isPlayer(var_0)) {
    if(!scripts\cp\utility::isreallyalive(var_0) || var_0.sessionstate != "playing") {
      return 0;
    }
  }

  if(level.teambased && isDefined(var_0.team) && var_0.team == self.team) {
    return 0;
  }

  if(isDefined(var_0.team) && var_0.team == "spectator") {
    return 0;
  }

  if(isPlayer(var_0) && var_0 == self.owner) {
    return 0;
  }

  if(isPlayer(var_0) && isDefined(var_0.spawntime) && gettime() - var_0.spawntime / 1000 <= 5) {
    return 0;
  }

  if(isPlayer(var_0) && var_0 scripts\cp\utility::_hasperk("specialty_blindeye")) {
    return 0;
  }

  if(distancesquared(var_0.origin, self.origin) > 4000000) {
    return 0;
  }

  if(isDefined(var_0.var_9EE2) && var_0.var_9EE2) {
    return 0;
  }

  return var_1;
}

placementfailed(var_0) {
  self notify("powers_microTurret_used", 0);
  scripts\cp\cp_weapon::placeequipmentfailed(var_0.weapon_name, 1, var_0.origin);
  var_0 delete();
}