/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\carriable.gsc
***********************************************/

function ref_131ea(var_0, var_1) {
  var_2 = "sentry_turret";
  var_3 = level.sentrysettings[var_2];
  var_4 = spawnturret("misc_turret", var_0.origin, level.sentrysettings[var_2].weaponinfo);
  var_4.team = "axis";

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
  var_4 setturretteam("axis");
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
  var_4 scripts\cp_mp\emp_debuff::set_start_emp_callback(&sentryturret_empstarted);
  var_4 scripts\cp_mp\emp_debuff::set_clear_emp_callback(&sentryturret_empcleared);
  var_4 scripts\cp_mp\emp_debuff::allow_emp(0);
  var_0.turret = var_4;

  if(!isDefined(level.vo_paratroopers)) {
    level.vo_paratroopers = [];
  }

  level.vo_paratroopers = scripts\engine\utility::array_add(level.vo_paratroopers, var_4);
  wait 1;
  var_4 setmode("auto_nonai");
  var_4 scripts\cp_mp\emp_debuff::allow_emp(1);
  sentryturret_empupdate(var_4);
  thread is_attack_available();
  thread sentry_attacktargets();
  thread sentry_handledeath();
  var_4 thread scripts\cp_mp\killstreaks\sentry_gun::sentry_beepsounds();
  return var_4;
}

function sentryturret_empstarted(var_0) {
  sentryturret_empupdate();
}

function sentryturret_empcleared(var_0) {
  if(var_0) {
    return;
  }

  sentryturret_empupdate();
}

function sentryturret_empupdate() {
  if(scripts\cp_mp\emp_debuff::is_empd()) {
    self turretfiredisable();
    self setmode(level.sentrysettings[self.turrettype].sentrymodeoff);
    self laseroff();
    return;
  }

  self turretfireenable();
  self setmode("auto_nonai");
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

    if(var_15 || var_16 || var_18) {
      if(!scripts\cp\utility::tryingtoleave()) {
        if(var_16) {
          var_1 = var_1.owner;
        }

        scripts\cp\cp_agent_damage::addattacker(self, var_1, var_13, var_9, var_0, var_3, var_2, undefined, undefined, var_4);
      }
    }

    scripts\cp\cp_damagefeedback::process_damage_feedback(var_13, var_1, var_0, var_8, var_4, var_9, var_2, var_2, var_7, undefined, self);
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
  self playSound("sentry_gun_beep");
  wait 0.1;
  self playSound("sentry_gun_beep");
  wait 0.1;
  self playSound("sentry_gun_beep");
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
  var_0 = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
  var_1 = level.sentrysettings[self.sentrytype].burstmin;
  var_2 = level.sentrysettings[self.sentrytype].burstmax;
  var_3 = level.sentrysettings[self.sentrytype].pausemin;
  var_4 = level.sentrysettings[self.sentrytype].pausemax;

  for(;;) {
    var_5 = randomintrange(var_1, var_2 + 1);

    for(var_6 = 0; var_6 < var_5 && !self.overheated; var_6++) {
      if(!ref_13024()) {
        break;
      }

      self shootturret();
      self notify("bullet_fired");
      self.heatlevel += var_0;
      wait var_0;
    }

    wait randomfloatrange(var_3, var_4);
  }
}

function ref_13024() {
  if(istrue(self.matchdata_logaward)) {
    var_0 = self getturrettarget(0);

    if(isDefined(var_0) && isPlayer(var_0) && var_0 isparachuting()) {
      return false;
    }
  }

  return true;
}

function sentry_burstfirestop() {
  self notify("stop_shooting");
}

function sentry_heatmonitor() {
  if(istrue(self.ref_133bc)) {
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
  level.vo_paratroopers = scripts\engine\utility::array_remove(level.vo_paratroopers, self);

  if(!isDefined(self)) {
    return;
  }

  self setmode("sentry_offline");
  self setscriptablepartstate("explode", "violent");

  if(isDefined(self.attackerdata)) {
    foreach(var_1 in level.players) {
      var_2 = 0;

      if(isDefined(self.attackerdata[var_1.guid]) && isDefined(self.attackerdata[var_1.guid].damage)) {
        if(self.attackerdata[var_1.guid].damage >= self.maxhealth * 0.1) {
          var_2 = 1;
        }

        if(self.attackerdata[var_1.guid].damage >= self.maxhealth * 0.2) {
          var_2 = 2;
        }

        if(var_2 >= 1) {
          var_1 thread scripts\cp\drone\emp_drone::giverankxp("destroyed_sentry_gun", scripts\cp\drone\emp_drone::getscoreinfovalue("destroyed_sentry_gun"));
        }
      }
    }
  }

  if(isDefined(self)) {
    thread sentry_deleteturret();
    return;
  }
}

function sentry_deleteturret() {
  self notify("sentry_delete_turret");
  self endon("sentry_delete_turret");
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