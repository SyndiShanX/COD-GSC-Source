/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: 58304.gsc
***********************************************/

function init() {
  thread supply_crate_vo_when_used();
}

function supply_crate_vo_when_used() {
  level._effect["sentry_overheat_mp"] = loadfx("vfx/core/mp/killstreaks/vfx_sg_overheat_smoke");
  level.ref_13D65 = [];

  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  var_0 = scripts\engine\utility::getStructArray("trial_enemy_sentry_turret", "targetname");

  while(!isDefined(level.sentrysettings)) {
    waitframe();
  }

  level.sentrysettings["trial_sentry_turret"] = level.sentrysettings["sentry_turret"];
  level.sentrysettings["trial_sentry_turret"].spinuptime = level.sentrysettings["trial_sentry_turret"].spinuptime * 2;
  level.sentrysettings["trial_sentry_turret"].health = 150;

  foreach(var_2 in var_0) {
    waitframe();
    level.ref_13D65[level.ref_13D65.size] = ref_131EA(var_2);
  }

  level.ref_13022 = 1;
}

function ref_131EA(var_0, var_1) {
  var_2 = "trial_sentry_turret";
  var_3 = level.sentrysettings[var_2];
  var_4 = spawnturret("misc_turret", var_0.origin, level.sentrysettings[var_2].weaponinfo);
  var_4.team = scripts\mp\utility\game::getotherteam(level.trial["team"])[0];

  if(!isDefined(var_0.angles)) {
    var_0.angles = (0, 0, 0);
  }

  var_4.angles = var_0.angles;
  var_4.health = var_3.maxhealth;
  var_4.maxhealth = var_3.maxhealth;
  var_4.sentrytype = var_2;
  var_4.momentum = 0;
  var_4.heatlevel = 0;
  var_4.overheated = 0;
  var_4.cooldownwaittime = 2;
  var_4.turrettype = "sentry_turret";

  if(!isDefined(var_1)) {
    var_1 = "weapon_wm_mg_sentry_turret";
  }

  var_4 setModel(var_1);
  var_4 setturretteam(var_4.team);
  var_4 makeunusable();
  var_4 setnodeploy(1);
  var_4 setdefaultdroppitch(0);
  var_4 setautorotationdelay(0.2);
  var_4 maketurretinoperable();
  var_4 setleftarc(80);
  var_4 setrightarc(80);
  var_4 setbottomarc(50);
  var_4 settoparc(60);
  var_4 setconvergencetime(0.6, "pitch");
  var_4 setconvergencetime(0.6, "yaw");
  var_4 setconvergenceheightpercent(0.65);
  var_4 setdefaultdroppitch(-89);
  var_4 setturretmodechangewait(1);
  var_4 solid();
  var_0.turret = var_4;
  wait 1;
  var_4 setmode("auto_nonai");
  thread is_attack_available();
  thread sentry_attacktargets();
  thread sentry_handledeath();
  thread sentry_handledamage();
  var_4 thread scripts\cp_mp\killstreaks\sentry_gun::sentry_beepsounds();
  var_4.helperdrone_isbeingpingedbydrone = spawn("script_model", var_4.origin);
  var_4.helperdrone_isbeingpingedbydrone setModel("weapon_vm_mg_sentry_turret_invis_base");
  var_4.helperdrone_isbeingpingedbydrone dontinterpolate();
  var_4.helperdrone_isbeingpingedbydrone.angles = var_4.angles;
  var_4.helperdrone_isbeingpingedbydrone.origin = var_4.origin;
  var_4.helperdrone_isbeingpingedbydrone linkTo(var_4, "tag_aim_pivot");
  var_5 = "icon_minimap_sentry";
  var_4.minimapid = var_4.helperdrone_isbeingpingedbydrone scripts\mp\objidpoolmanager::createobjective(var_5, var_4.team, undefined, 1, 1);

  if(isDefined(level.ref_13D85)) {
    var_4 thread[[level.ref_13D85]]();
  }

  return var_4;
}

function node_fields_after_goal_skit() {
  self endon("death");
  self endon("kill_turret");
  level endon("game_ended");
  var_0 = self.origin;
  var_1 = 0.05;
  var_2 = int(var_1 * 20);

  for(;;) {
    wait var_1;
  }
}

function is_attack_available() {
  self endon("death");
  self endon("kill_turret");
  level endon("game_ended");
  self setCanDamage(1);

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);

    if(!isDefined(var_1) || !isPlayer(var_1) && (!isDefined(var_1.owner) || !isPlayer(var_1.owner))) {
      continue;
    }

    if(isDefined(var_9.basename)) {
      if(issubstr(var_9.basename, "emp_drone")) {}
    }

    var_15 = isDefined(var_1) && isPlayer(var_1);
    var_16 = isDefined(var_1.owner) && isPlayer(var_1.owner);
    var_17 = isDefined(var_1.classname) && var_1.classname == "script_vehicle" && isDefined(var_1.owner) && isPlayer(var_1.owner);
    var_18 = var_17 && var_4 == "MOD_CRUSH";
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
  var_0 = 4 * weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
  var_1 = level.sentrysettings[self.sentrytype].burstmin;
  var_2 = level.sentrysettings[self.sentrytype].burstmax;
  var_3 = level.sentrysettings[self.sentrytype].pausemin;
  var_4 = level.sentrysettings[self.sentrytype].pausemax;

  for(;;) {
    var_5 = randomintrange(var_1, var_2 + 1);

    for(var_6 = 0; var_6 < var_5 && !self.overheated; var_6++) {
      self shootturret();
      self notify("bullet_fired");
      self.heatlevel += var_0;
      wait var_0;
    }

    wait randomfloatrange(var_3, var_4);
  }
}

function sentry_burstfirestop() {
  self notify("stop_shooting");
}

function sentry_heatmonitor() {
  if(istrue(self.ref_133BC)) {
    return;
  }

  self endon("death");
  var_0 = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
  var_1 = 0;
  var_2 = 0;
  var_3 = level.sentrysettings[self.sentrytype].overheattime;
  var_4 = level.sentrysettings[self.sentrytype].cooldowntime;

  for(;;) {
    if(self.heatlevel != var_1) {
      wait var_0;
    } else {
      self.heatlevel = max(0, self.heatlevel - 0.05);
    }

    if(self.heatlevel > var_3) {
      self.overheated = 1;
      thread playheatfx();

      while(self.heatlevel) {
        self.heatlevel = max(0, self.heatlevel - var_4);
        wait 0.1;
      }

      self.overheated = 0;
      self notify("not_overheated");
    }

    var_1 = self.heatlevel;
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

  if(isDefined(level.ref_13D84)) {
    if(isDefined(self.cave_combat) && gettime() < self.cave_combat + 4000) {
      self[[level.ref_13D84]]();
    }
  }

  if(isDefined(self)) {
    thread sentry_deleteturret();
    return;
  }
}

function sentry_handledamage() {
  for(;;) {
    self waittill("damage", var_0, var_1);

    if(var_1 == level.player) {
      var_1 scripts\mp\damagefeedback::updatedamagefeedback("hitequip");
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