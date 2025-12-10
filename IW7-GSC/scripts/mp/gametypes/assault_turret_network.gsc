/***********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\gametypes\assault_turret_network.gsc
***********************************************************/

init() {
  if(!isDefined(level.var_23AB)) {
    level.var_23AB = [];
  }

  var_00 = spawnStruct();
  var_00.var_39B = "sentry_minigun_mp";
  var_00.modelbase = "weapon_ceiling_sentry_temp";
  var_00.modelbombsquad = "weapon_sentry_chaingun_bombsquad";
  var_00.modeldestroyed = "weapon_sentry_chaingun_destroyed";
  var_00.maxhealth = 670;
  var_00.burstmin = 20;
  var_00.burstmax = 120;
  var_00.pausemin = 0.15;
  var_00.pausemax = 0.35;
  var_00.timeout = 90;
  var_00.spinuptime = 0.05;
  var_00.overheattime = 4;
  var_00.cooldowntime = 0.1;
  var_00.fxtime = 0.3;
  var_00.lightfxtag = "tag_fx";
  level.var_23AB["turret"] = var_00;
}

func_FAF1(param_00, param_01) {
  wait(5);
  var_02 = getent(param_01, "targetname");
  var_03 = getEntArray(param_00, "targetname");
  var_02.settings = level.var_23AB["turret"];
  var_02.turrets = [];
  var_02.team = "";
  var_04 = 0;
  foreach(var_06 in var_03) {
    var_02.turrets[var_04] = func_108E9(var_06, var_02);
    var_04++;
  }

  func_45CC(var_02);
}

func_108E9(param_00, param_01) {
  var_02 = spawnturret("misc_turret", param_00.origin - (0, 0, 32), param_01.settings.var_39B);
  var_02.angles = param_00.angles;
  if(param_00.model != "") {
    param_00 delete();
  }

  var_02 setModel(param_01.settings.modelbase);
  var_02.var_45C3 = param_01;
  var_02.triggerportableradarping = param_01;
  var_02 setleftarc(80);
  var_02 setrightarc(80);
  var_02 give_crafted_gascan(60);
  var_02 setdefaultdroppitch(15);
  var_03 = spawn("script_model", var_02 gettagorigin("tag_laser"));
  var_03 linkto(var_02);
  var_02.killcament = var_03;
  var_02.killcament setscriptmoverkillcam("explosive");
  var_02 setturretmodechangewait(1);
  var_02 thread func_12A6A();
  var_02 thread func_12A6B();
  var_02 thread func_12A9B();
  var_02 setCanDamage(1);
  var_02 thread func_12A5C(param_01.settings.modelbombsquad);
  return var_02;
}

func_12A53(param_00) {
  self setdefaultdroppitch(15);
  self give_player_session_tokens("sentry");
  self.triggerportableradarping = param_00;
  self setsentryowner(param_00);
  self.team = self.triggerportableradarping.team;
  self setturretteam(self.team);
  thread func_12A59();
  if(isDefined(self.team)) {
    scripts\mp\sentientpoolmanager::registersentient("Killstreak_Ground", param_00);
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
  var_00 = self getentitynumber();
  func_E11F(var_00);
  self setturretminimapvisible(0, "sentry");
  func_12A6F();
  scripts\mp\weapons::stopblinkinglight();
  self notify("deactivated");
}

func_12A59() {
  self endon("death");
  level endon("game_ended");
  self.momentum = 0;
  var_00 = self.var_45C3.settings;
  thread func_12A6E(weaponfiretime(var_00.var_39B), var_00.overheattime, var_00.cooldowntime);
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
  var_00 = self.var_45C3.settings;
  var_01 = weaponfiretime(var_00.var_39B);
  var_02 = var_00.burstmin;
  var_03 = var_00.burstmax;
  var_04 = var_00.pausemin;
  var_05 = var_00.pausemax;
  for(;;) {
    var_06 = randomintrange(var_02, var_03 + 1);
    for(var_07 = 0; var_07 < var_06 && !self.overheated; var_07++) {
      self shootturret();
      self notify("bullet_fired");
      self.heatlevel = self.heatlevel + var_01;
      wait(var_01);
    }

    wait(randomfloatrange(var_04, var_05));
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

func_12A6E(param_00, param_01, param_02) {
  self endon("death");
  self.heatlevel = 0;
  self.overheated = 0;
  var_03 = 0;
  var_04 = 0;
  for(;;) {
    if(self.heatlevel != var_03) {
      wait(param_00);
    } else {
      self.heatlevel = max(0, self.heatlevel - 0.05);
    }

    if(self.heatlevel > param_01) {
      self.overheated = 1;
      playFXOnTag(scripts\engine\utility::getfx("sentry_smoke_mp"), self, "tag_flash");
      while(self.heatlevel) {
        self.heatlevel = max(0, self.heatlevel - param_02);
        wait(0.1);
      }

      self.overheated = 0;
      self notify("cooled");
    }

    var_03 = self.heatlevel;
    wait(0.05);
  }
}

func_12A5C(param_00) {
  var_01 = spawn("script_model", self.origin);
  var_01.angles = self.angles;
  var_01 hide();
  var_01 thread scripts\mp\weapons::bombsquadvisibilityupdater(self.triggerportableradarping);
  var_01 setModel(param_00);
  var_01 linkto(self);
  var_01 setcontents(0);
  self.bombsquadmodel = var_01;
  level notify("update_bombsquad");
  self waittill("death");
  if(isDefined(var_01)) {
    var_01 delete();
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

func_12A6A(param_00) {
  scripts\mp\damage::monitordamage(param_00, "sentry", ::func_12A6C, ::func_12A79, 1);
}

func_12A79(param_00, param_01, param_02, param_03, param_04) {
  var_05 = param_03;
  if(param_02 == "MOD_MELEE") {
    var_05 = self.maxhealth * 0.34;
  }

  var_05 = scripts\mp\damage::handlemissiledamage(param_01, param_02, var_05);
  var_05 = scripts\mp\damage::handlegrenadedamage(param_01, param_02, var_05);
  var_05 = scripts\mp\damage::handleapdamage(param_01, param_02, var_05);
  return var_05;
}

func_12A6C(param_00, param_01, param_02, param_03) {}

func_12A9B() {
  self endon("death");
  level endon("game_ended");
  for(;;) {
    self waittill("emp_damage", var_00, var_01);
    scripts\mp\weapons::stopblinkinglight();
    playFXOnTag(scripts\engine\utility::getfx("emp_stun"), self, "tag_aim");
    self setdefaultdroppitch(40);
    self give_player_session_tokens("sentry_offline");
    wait(var_01);
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
    var_00 = 8;
    while(var_00 > 0) {
      playFXOnTag(scripts\engine\utility::getfx("sentry_smoke_mp"), self, "tag_aim");
      wait(0.4);
      var_00 = var_00 - 0.4;
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

func_1862(param_00) {
  level.turrets[param_00] = self;
}

func_E11F(param_00) {
  level.turrets[param_00] = undefined;
}

func_45CC(param_00) {
  var_01 = undefined;
  if(isDefined(param_00.script_noteworthy)) {
    var_01 = getent(param_00.script_noteworthy, "targetname");
  }

  if(!isDefined(var_01)) {
    var_01 = spawn("script_model", param_00.origin);
    var_01 setModel("laptop_toughbook_open_on_iw6");
    var_01.angles = param_00.angles;
  }

  var_01.health = 99999;
  param_00.visuals = var_01;
  var_02 = scripts\mp\gameobjects::createuseobject("axis", param_00, [var_01], (0, 0, 64));
  var_02.label = "control_panel_" + param_00.var_336;
  var_02.id = "use";
  var_02 func_45CD();
  param_00.gameobject = var_02;
}

func_45CF(param_00) {
  self.triggerportableradarping = param_00;
  self.team = param_00.team;
  self.visuals.triggerportableradarping = param_00;
  foreach(var_02 in self.turrets) {
    if(isDefined(var_02) && isalive(var_02)) {
      var_02 thread func_12A53(param_00);
    }
  }

  self.visuals thread scripts\mp\weapons::doblinkinglight("tag_fx");
  thread func_45CA();
}

func_45CB() {
  foreach(var_01 in self.turrets) {
    if(isDefined(var_01) && isalive(var_01)) {
      var_01 thread func_12A5D();
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

func_45C6(param_00) {}

func_45C7(param_00, param_01, param_02) {}

func_45C8(param_00) {
  func_E27D(param_00);
  self.trigger func_45CF(param_00);
  func_45CE();
}

func_45C9(param_00) {
  func_E27D(param_00);
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

func_E27D(param_00) {
  if(isDefined(param_00)) {
    param_00 setclientomnvar("ui_securing_progress", 1);
    param_00 setclientomnvar("ui_securing", 0);
    param_00.ui_securing = undefined;
  }
}