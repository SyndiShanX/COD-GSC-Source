/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58304.gsc
***********************************************/

function init() {
  thread supply_crate_vo_when_used();
}

function supply_crate_vo_when_used() {
  level._effect["sentry_overheat_mp"] = loadfx("vfx/core/mp/killstreaks/vfx_sg_overheat_smoke");
  level.ref_13d65 = [];

  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  var0 = scripts\engine\utility::getStructArray("trial_enemy_sentry_turret", "targetname");

  while(!isDefined(level.sentrysettings)) {
    waitframe();
  }

  level.sentrysettings["trial_sentry_turret"] = level.sentrysettings["sentry_turret"];
  level.sentrysettings["trial_sentry_turret"].spinuptime = level.sentrysettings["trial_sentry_turret"].spinuptime * 2;
  level.sentrysettings["trial_sentry_turret"].health = 150;

  foreach(var2 in var0) {
    waitframe();
    level.ref_13d65[level.ref_13d65.size] = ref_131ea(var2);
  }

  level.ref_13022 = 1;
}

function ref_131ea(var0, var1) {
  var2 = "trial_sentry_turret";
  var3 = level.sentrysettings[var2];
  var4 = spawnturret("misc_turret", var0.origin, level.sentrysettings[var2].weaponinfo);
  var4.team = scripts\mp\utility\game::getotherteam(level.trial["team"])[0];

  if(!isDefined(var0.angles)) {
    var0.angles = (0, 0, 0);
  }

  var4.angles = var0.angles;
  var4.health = var3.maxhealth;
  var4.maxhealth = var3.maxhealth;
  var4.sentrytype = var2;
  var4.momentum = 0;
  var4.heatlevel = 0;
  var4.overheated = 0;
  var4.cooldownwaittime = 2;
  var4.turrettype = "sentry_turret";

  if(!isDefined(var1)) {
    var1 = "weapon_wm_mg_sentry_turret";
  }

  var4 setModel(var1);
  var4 setturretteam(var4.team);
  var4 makeunusable();
  var4 setnodeploy(1);
  var4 setdefaultdroppitch(0);
  var4 setautorotationdelay(0.2);
  var4 maketurretinoperable();
  var4 setleftarc(80);
  var4 setrightarc(80);
  var4 setbottomarc(50);
  var4 settoparc(60);
  var4 setconvergencetime(0.6, "pitch");
  var4 setconvergencetime(0.6, "yaw");
  var4 setconvergenceheightpercent(0.65);
  var4 setdefaultdroppitch(-89);
  var4 setturretmodechangewait(1);
  var4 solid();
  var0.turret = var4;
  wait 1;
  var4 setmode("auto_nonai");
  thread is_attack_available();
  thread sentry_attacktargets();
  thread sentry_handledeath();
  thread sentry_handledamage();
  var4 thread scripts\cp_mp\killstreaks\sentry_gun::sentry_beepsounds();
  var4.helperdrone_isbeingpingedbydrone = spawn("script_model", var4.origin);
  var4.helperdrone_isbeingpingedbydrone setModel("weapon_vm_mg_sentry_turret_invis_base");
  var4.helperdrone_isbeingpingedbydrone dontinterpolate();
  var4.helperdrone_isbeingpingedbydrone.angles = var4.angles;
  var4.helperdrone_isbeingpingedbydrone.origin = var4.origin;
  var4.helperdrone_isbeingpingedbydrone linkTo(var4, "tag_aim_pivot");
  var5 = "icon_minimap_sentry";
  var4.minimapid = var4.helperdrone_isbeingpingedbydrone scripts\mp\objidpoolmanager::createobjective(var5, var4.team, undefined, 1, 1);

  if(isDefined(level.ref_13d85)) {
    var4 thread[[level.ref_13d85]]();
  }

  return var4;
}

function node_fields_after_goal_skit() {
  self endon("death");
  self endon("kill_turret");
  level endon("game_ended");
  var0 = self.origin;
  var1 = 0.05;
  var2 = int(var1 * 20);

  for(;;) {
    wait var1;
  }
}

function is_attack_available() {
  self endon("death");
  self endon("kill_turret");
  level endon("game_ended");
  self setCanDamage(1);

  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14);

    if(!isDefined(var1) || !isPlayer(var1) && (!isDefined(var1.owner) || !isPlayer(var1.owner))) {
      continue;
    }

    if(isDefined(var9.basename)) {
      if(issubstr(var9.basename, "emp_drone")) {}
    }

    var15 = isDefined(var1) && isPlayer(var1);
    var16 = isDefined(var1.owner) && isPlayer(var1.owner);
    var17 = isDefined(var1.classname) && var1.classname == "script_vehicle" && isDefined(var1.owner) && isPlayer(var1.owner);
    var18 = var17 && var4 == "MOD_CRUSH";
  }
}

function sentry_attacktargets() {
  self endon("death");
  level endon("game_ended");
  self.momentum = 0;
  self.heatlevel = 0;
  self.overheated = 0;
  thread sentry_heatmonitor();

  for(;;) {
    scripts\engine\utility::waittill_either("turretstatechange", "cooled");

    if(self isfiringturret()) {
      self laseron();
      thread sentry_burstfirestart();
      continue;
    }

    self laseroff();
    sentry_spindown();
    thread sentry_burstfirestop();
  }
}

function sentry_targetlocksound() {
  self endon("death");
  level.player playSound("sentry_gun_beep");
  wait 0.1;
  level.player playSound("sentry_gun_beep");
  wait 0.1;
  level.player playSound("sentry_gun_beep");
}

function sentry_spinup() {
  thread sentry_targetlocksound();

  while(self.momentum < level.sentrysettings[self.sentrytype].spinuptime) {
    self.momentum += 0.1;
    wait 0.1;
  }
}

function sentry_spindown() {
  self.momentum = 0;
}

function sentry_burstfirestart() {
  self endon("death");
  self endon("stop_shooting");
  level endon("game_ended");
  sentry_spinup();
  var0 = 4 * weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
  var1 = level.sentrysettings[self.sentrytype].burstmin;
  var2 = level.sentrysettings[self.sentrytype].burstmax;
  var3 = level.sentrysettings[self.sentrytype].pausemin;
  var4 = level.sentrysettings[self.sentrytype].pausemax;

  for(;;) {
    var5 = randomintrange(var1, var2 + 1);

    for(var6 = 0; var6 < var5 && !self.overheated; var6++) {
      self shootturret();
      self notify("bullet_fired");
      self.heatlevel += var0;
      wait var0;
    }

    wait randomfloatrange(var3, var4);
  }
}

function sentry_burstfirestop() {
  self notify("stop_shooting");
}

function sentry_heatmonitor() {
  if(istrue(self.ref_133bc)) {
    return;
  }

  self endon("death");
  var0 = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
  var1 = 0;
  var2 = 0;
  var3 = level.sentrysettings[self.sentrytype].overheattime;
  var4 = level.sentrysettings[self.sentrytype].cooldowntime;

  for(;;) {
    if(self.heatlevel != var1) {
      wait var0;
    } else {
      self.heatlevel = max(0, self.heatlevel - 0.05);
    }

    if(self.heatlevel > var3) {
      self.overheated = 1;
      thread playheatfx();

      while(self.heatlevel) {
        self.heatlevel = max(0, self.heatlevel - var4);
        wait 0.1;
      }

      self.overheated = 0;
      self notify("not_overheated");
    }

    var1 = self.heatlevel;
    wait 0.05;
  }
}

function playheatfx() {
  self endon("death");
  self endon("not_overheated");
  level endon("game_ended");
  self notify("playing_heat_fx");
  self endon("playing_heat_fx");

  for(;;) {
    playFXOnTag(scripts\engine\utility::getfx("sentry_overheat_mp"), self, "tag_flash");
    wait level.sentrysettings[self.sentrytype].fxtime;
  }
}

function sentry_beepsounds() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    wait 3;

    if(!isDefined(self.carriedby)) {
      self playSound("sentry_gun_beep");
    }
  }
}

function sentry_handledeath() {
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }

  self setmode("sentry_offline");
  self setscriptablepartstate("explode", "violent");

  if(isDefined(level.ref_13d84)) {
    if(isDefined(self.cave_combat) && gettime() < self.cave_combat + 4000) {
      self[[level.ref_13d84]]();
    }
  }

  if(isDefined(self)) {
    thread sentry_deleteturret();
    return;
  }
}

function sentry_handledamage() {
  for(;;) {
    self waittill("damage", var0, var1);

    if(var1 == level.player) {
      var1 scripts\mp\damagefeedback::updatedamagefeedback("hitequip");
      self.cave_combat = gettime();
    }
  }
}

function sentry_deleteturret() {
  self notify("sentry_delete_turret");
  self endon("sentry_delete_turret");

  if(isDefined(self.helperdrone_isbeingpingedbydrone)) {
    self.helperdrone_isbeingpingedbydrone delete();
  }

  wait 1.5;
  playFXOnTag(scripts\engine\utility::getfx("sentry_explode_mp"), self, "tag_aim");
  playFXOnTag(scripts\engine\utility::getfx("sentry_smoke_mp"), self, "tag_aim");
  self playSound("sentry_explode_smoke");
  wait 0.1;
  self notify("deleting");

  if(isDefined(self)) {
    self delete();
    return;
  }
}