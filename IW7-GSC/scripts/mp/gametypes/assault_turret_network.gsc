/***********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\gametypes\assault_turret_network.gsc
***********************************************************/

init() {
  if(!isDefined(level.var_23AB)) {
    level.var_23AB = [];
  }

  var_0 = spawnStruct();
  var_0.var_39B = "sentry_minigun_mp";
  var_0.modelbase = "weapon_ceiling_sentry_temp";
  var_0.modelbombsquad = "weapon_sentry_chaingun_bombsquad";
  var_0.modeldestroyed = "weapon_sentry_chaingun_destroyed";
  var_0.maxhealth = 670;
  var_0.burstmin = 20;
  var_0.burstmax = 120;
  var_0.pausemin = 0.15;
  var_0.pausemax = 0.35;
  var_0.timeout = 90;
  var_0.spinuptime = 0.05;
  var_0.overheattime = 4;
  var_0.cooldowntime = 0.1;
  var_0.fxtime = 0.3;
  var_0.lightfxtag = "tag_fx";
  level.var_23AB["turret"] = var_0;
}

func_FAF1(var_0, var_1) {
  wait(5);
  var_2 = getent(var_1, "targetname");
  var_3 = getEntArray(var_0, "targetname");
  var_2.settings = level.var_23AB["turret"];
  var_2.turrets = [];
  var_2.team = "";
  var_4 = 0;
  foreach(var_6 in var_3) {
    var_2.turrets[var_4] = func_108E9(var_6, var_2);
    var_4++;
  }

  func_45CC(var_2);
}

func_108E9(var_0, var_1) {
  var_2 = spawnturret("misc_turret", var_0.origin - (0, 0, 32), var_1.settings.var_39B);
  var_2.angles = var_0.angles;
  if(var_0.model != "") {
    var_0 delete();
  }

  var_2 setModel(var_1.settings.modelbase);
  var_2.var_45C3 = var_1;
  var_2.triggerportableradarping = var_1;
  var_2 setleftarc(80);
  var_2 setrightarc(80);
  var_2 give_crafted_gascan(60);
  var_2 setdefaultdroppitch(15);
  var_3 = spawn("script_model", var_2 gettagorigin("tag_laser"));
  var_3 linkto(var_2);
  var_2.killcament = var_3;
  var_2.killcament setscriptmoverkillcam("explosive");
  var_2 setturretmodechangewait(1);
  var_2 thread func_12A6A();
  var_2 thread func_12A6B();
  var_2 thread func_12A9B();
  var_2 setCanDamage(1);
  var_2 thread func_12A5C(var_1.settings.modelbombsquad);
  return var_2;
}

func_12A53(var_0) {
  self setdefaultdroppitch(15);
  self give_player_session_tokens("sentry");
  self.triggerportableradarping = var_0;
  self setsentryowner(var_0);
  self.team = self.triggerportableradarping.team;
  self setturretteam(self.team);
  thread func_12A59();
  if(isDefined(self.team)) {
    scripts\mp\sentientpoolmanager::registersentient("Killstreak_Ground", var_0);
  }

  thread func_12A5A();
  thread scripts\mp\weapons::doblinkinglight(self.var_45C3.settings.lightfxtag);
  func_12A8E();
  self setturretminimapvisible(1, "sentry");
  func_1862(self getentitynumber());
}

func_12A5D() {
  self setdefaultdroppitch(40);
  self give_player_session_tokens("sentry_offline");
  self setsentryowner(undefined);
  scripts\mp\sentientpoolmanager::unregistersentient(self.sentientpool, self.sentientpoolindex);
  self.triggerportableradarping = undefined;
  self.team = undefined;
  var_0 = self getentitynumber();
  func_E11F(var_0);
  self setturretminimapvisible(0, "sentry");
  func_12A6F();
  scripts\mp\weapons::stopblinkinglight();
  self notify("deactivated");
}

func_12A59() {
  self endon("death");
  level endon("game_ended");
  self.momentum = 0;
  var_0 = self.var_45C3.settings;
  thread func_12A6E(weaponfiretime(var_0.var_39B), var_0.overheattime, var_0.cooldowntime);
  for(;;) {
    scripts\engine\utility::waittill_either("turretstatechange", "cooled");
    if(self getteamarray()) {
      self laseron();
      thread sentry_burstfirestart();
      continue;
    }

    self laseroff();
    sentry_spindown();
    thread sentry_burstfirestop();
  }
}

sentry_burstfirestart() {
  self endon("death");
  self endon("stop_shooting");
  level endon("game_ended");
  sentry_spinup();
  var_0 = self.var_45C3.settings;
  var_1 = weaponfiretime(var_0.var_39B);
  var_2 = var_0.burstmin;
  var_3 = var_0.burstmax;
  var_4 = var_0.pausemin;
  var_5 = var_0.pausemax;
  for(;;) {
    var_6 = randomintrange(var_2, var_3 + 1);
    for(var_7 = 0; var_7 < var_6 && !self.overheated; var_7++) {
      self shootturret();
      self notify("bullet_fired");
      self.heatlevel = self.heatlevel + var_1;
      wait(var_1);
    }

    wait(randomfloatrange(var_4, var_5));
  }
}

sentry_burstfirestop() {
  self notify("stop_shooting");
}

sentry_spinup() {
  thread func_12A98();
  while(self.momentum < self.var_45C3.settings.spinuptime) {
    self.momentum = self.momentum + 0.1;
    wait(0.1);
  }
}

sentry_spindown() {
  self.momentum = 0;
}

func_12A6E(var_0, var_1, var_2) {
  self endon("death");
  self.heatlevel = 0;
  self.overheated = 0;
  var_3 = 0;
  var_4 = 0;
  for(;;) {
    if(self.heatlevel != var_3) {
      wait(var_0);
    } else {
      self.heatlevel = max(0, self.heatlevel - 0.05);
    }

    if(self.heatlevel > var_1) {
      self.overheated = 1;
      playFXOnTag(scripts\engine\utility::getfx("sentry_smoke_mp"), self, "tag_flash");
      while(self.heatlevel) {
        self.heatlevel = max(0, self.heatlevel - var_2);
        wait(0.1);
      }

      self.overheated = 0;
      self notify("cooled");
    }

    var_3 = self.heatlevel;
    wait(0.05);
  }
}

func_12A5C(var_0) {
  var_1 = spawn("script_model", self.origin);
  var_1.angles = self.angles;
  var_1 hide();
  var_1 thread scripts\mp\weapons::bombsquadvisibilityupdater(self.triggerportableradarping);
  var_1 setModel(var_0);
  var_1 linkto(self);
  var_1 setcontents(0);
  self.bombsquadmodel = var_1;
  level notify("update_bombsquad");
  self waittill("death");
  if(isDefined(var_1)) {
    var_1 delete();
  }
}

func_12A8E() {
  if(isDefined(self.bombsquadmodel)) {
    self.bombsquadmodel show();
    level notify("update_bombsquad");
  }
}

func_12A6F() {
  if(isDefined(self.bombsquadmodel)) {
    self.bombsquadmodel hide();
    level notify("update_bombsquad");
  }
}

func_12A6A(var_0) {
  scripts\mp\damage::monitordamage(var_0, "sentry", ::func_12A6C, ::func_12A79, 1);
}

func_12A79(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_3;
  if(var_2 == "MOD_MELEE") {
    var_5 = self.maxhealth * 0.34;
  }

  var_5 = scripts\mp\damage::handlemissiledamage(var_1, var_2, var_5);
  var_5 = scripts\mp\damage::handlegrenadedamage(var_1, var_2, var_5);
  var_5 = scripts\mp\damage::handleapdamage(var_1, var_2, var_5);
  return var_5;
}

func_12A6C(var_0, var_1, var_2, var_3) {}

func_12A9B() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self waittill("emp_damage", var_0, var_1);
    scripts\mp\weapons::stopblinkinglight();
    playFXOnTag(scripts\engine\utility::getfx("emp_stun"), self, "tag_aim");
    self setdefaultdroppitch(40);
    self give_player_session_tokens("sentry_offline");
    wait(var_1);
    self setdefaultdroppitch(15);
    self give_player_session_tokens("sentry");
    thread scripts\mp\weapons::doblinkinglight(self.var_45C3.settings.lightfxtag);
  }
}

func_12A6B() {
  self waittill("death");
  if(!isDefined(self)) {
    return;
  }

  func_12A5D();
  self setModel(self.var_45C3.var_F86F.modeldestroyed);
  self setdefaultdroppitch(40);
  if(isDefined(self.inuseby)) {
    self useby(self.inuseby);
  }

  self playSound("sentry_explode");
  if(isDefined(self.inuseby)) {
    playFXOnTag(scripts\engine\utility::getfx("sentry_explode_mp"), self, "tag_origin");
    playFXOnTag(scripts\engine\utility::getfx("sentry_smoke_mp"), self, "tag_aim");
    self notify("deleting");
    wait(1);
    stopFXOnTag(scripts\engine\utility::getfx("sentry_explode_mp"), self, "tag_origin");
    stopFXOnTag(scripts\engine\utility::getfx("sentry_smoke_mp"), self, "tag_aim");
  } else {
    playFXOnTag(scripts\engine\utility::getfx("sentry_sparks_mp"), self, "tag_aim");
    self playSound("sentry_explode_smoke");
    var_0 = 8;
    while(var_0 > 0) {
      playFXOnTag(scripts\engine\utility::getfx("sentry_smoke_mp"), self, "tag_aim");
      wait(0.4);
      var_0 = var_0 - 0.4;
    }

    playFX(scripts\engine\utility::getfx("sentry_explode_mp"), self.origin + (0, 0, 10));
    self notify("deleting");
  }

  scripts\mp\weapons::equipmentdeletevfx();
  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  self delete();
}

func_12A5A() {
  self endon("death");
  self endon("deactivated");
  level endon("game_ended");
  for(;;) {
    wait(3);
    self playSound("sentry_gun_beep");
  }
}

func_12A98() {
  self endon("death");
  self playSound("sentry_gun_beep");
  wait(0.1);
  self playSound("sentry_gun_beep");
  wait(0.1);
  self playSound("sentry_gun_beep");
}

playheatfx() {
  self endon("death");
  self endon("not_overheated");
  level endon("game_ended");
  self notify("playing_heat_fx");
  self endon("playing_heat_fx");
  for(;;) {
    playFXOnTag(scripts\engine\utility::getfx("sentry_overheat_mp"), self, "tag_flash");
    wait(self.var_45C3.settings.fxtime);
  }
}

func_1862(var_0) {
  level.turrets[var_0] = self;
}

func_E11F(var_0) {
  level.turrets[var_0] = undefined;
}

func_45CC(var_0) {
  var_1 = undefined;
  if(isDefined(var_0.script_noteworthy)) {
    var_1 = getent(var_0.script_noteworthy, "targetname");
  }

  if(!isDefined(var_1)) {
    var_1 = spawn("script_model", var_0.origin);
    var_1 setModel("laptop_toughbook_open_on_iw6");
    var_1.angles = var_0.angles;
  }

  var_1.health = 99999;
  var_0.visuals = var_1;
  var_2 = scripts\mp\gameobjects::createuseobject("axis", var_0, [var_1], (0, 0, 64));
  var_2.label = "control_panel_" + var_0.var_336;
  var_2.id = "use";
  var_2 func_45CD();
  var_0.gameobject = var_2;
}

func_45CF(var_0) {
  self.triggerportableradarping = var_0;
  self.team = var_0.team;
  self.visuals.triggerportableradarping = var_0;
  foreach(var_2 in self.turrets) {
    if(isDefined(var_2) && isalive(var_2)) {
      var_2 thread func_12A53(var_0);
    }
  }

  self.visuals thread scripts\mp\weapons::doblinkinglight("tag_fx");
  thread func_45CA();
}

func_45CB() {
  foreach(var_1 in self.turrets) {
    if(isDefined(var_1) && isalive(var_1)) {
      var_1 thread func_12A5D();
    }
  }

  self.visuals scripts\mp\weapons::stopblinkinglight();
  self.visuals.triggerportableradarping = undefined;
  self.triggerportableradarping = undefined;
  self.team = undefined;
}

func_45CA() {
  self endon("death");
  level endon("game_ended");
  self notify("sentry_handleOwner");
  self endon("sentry_handleOwner");
  self.triggerportableradarping scripts\engine\utility::waittill_any_3("disconnect", "joined_team", "joined_spectators");
  self.gameobject func_45C9(undefined);
}

func_45C6(var_0) {}

func_45C7(var_0, var_1, var_2) {}

func_45C8(var_0) {
  func_E27D(var_0);
  self.trigger func_45CF(var_0);
  func_45CE();
}

func_45C9(var_0) {
  func_E27D(var_0);
  self.trigger func_45CB();
  func_45CD();
}

func_45CD() {
  scripts\mp\gameobjects::allowuse("friendly");
  scripts\mp\gameobjects::setusetime(1);
  scripts\mp\gameobjects::setwaitweaponchangeonuse(1);
  scripts\mp\gameobjects::setusetext(&"MP_BREACH_OPERATE_TURRET_ON_ACTION");
  scripts\mp\gameobjects::setusehinttext(&"MP_BREACH_OPERATE_TURRET_ON");
  self.onbeginuse = ::func_45C6;
  self.onenduse = ::func_45C7;
  self.onuse = ::func_45C8;
}

func_45CE() {
  scripts\mp\gameobjects::allowuse("enemy");
  scripts\mp\gameobjects::setusetime(2);
  scripts\mp\gameobjects::setwaitweaponchangeonuse(1);
  scripts\mp\gameobjects::setusetext(&"MP_BREACH_OPERATE_TURRET_OFF_ACTION");
  scripts\mp\gameobjects::setusehinttext(&"MP_BREACH_OPERATE_TURRET_OFF");
  self.onbeginuse = ::func_45C6;
  self.onenduse = ::func_45C7;
  self.onuse = ::func_45C9;
}

func_E27D(var_0) {
  if(isDefined(var_0)) {
    var_0 setclientomnvar("ui_securing_progress", 1);
    var_0 setclientomnvar("ui_securing", 0);
    var_0.ui_securing = undefined;
  }
}