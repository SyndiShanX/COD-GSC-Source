/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\carriable.gsc
***********************************************/

function ref_131ea(var0, var1) {
  var2 = "sentry_turret";
  var3 = level.sentrysettings[var2];
  var4 = spawnturret("misc_turret", var0.origin, level.sentrysettings[var2].weaponinfo);
  var4.team = "axis";

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
  var4 setturretteam("axis");
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
  var4 scripts\cp_mp\emp_debuff::set_start_emp_callback(&sentryturret_empstarted);
  var4 scripts\cp_mp\emp_debuff::set_clear_emp_callback(&sentryturret_empcleared);
  var4 scripts\cp_mp\emp_debuff::allow_emp(0);
  var0.turret = var4;

  if(!isDefined(level.vo_paratroopers)) {
    level.vo_paratroopers = [];
  }

  level.vo_paratroopers = scripts\engine\utility::array_add(level.vo_paratroopers, var4);
  wait 1;
  var4 setmode("auto_nonai");
  var4 scripts\cp_mp\emp_debuff::allow_emp(1);
  sentryturret_empupdate(var4);
  thread is_attack_available();
  thread sentry_attacktargets();
  thread sentry_handledeath();
  var4 thread scripts\cp_mp\killstreaks\sentry_gun::sentry_beepsounds();
  return var4;
}

function sentryturret_empstarted(var0) {
  sentryturret_empupdate();
}

function sentryturret_empcleared(var0) {
  if(var0) {
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

    if(var15 || var16 || var18) {
      if(!scripts\cp\utility::tryingtoleave()) {
        if(var16) {
          var1 = var1.owner;
        }

        scripts\cp\cp_agent_damage::addattacker(self, var1, var13, var9, var0, var3, var2, undefined, undefined, var4);
      }
    }

    scripts\cp\cp_damagefeedback::process_damage_feedback(var13, var1, var0, var8, var4, var9, var2, var2, var7, undefined, self);
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
  var0 = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
  var1 = level.sentrysettings[self.sentrytype].burstmin;
  var2 = level.sentrysettings[self.sentrytype].burstmax;
  var3 = level.sentrysettings[self.sentrytype].pausemin;
  var4 = level.sentrysettings[self.sentrytype].pausemax;

  for(;;) {
    var5 = randomintrange(var1, var2 + 1);

    for(var6 = 0; var6 < var5 && !self.overheated; var6++) {
      if(!ref_13024()) {
        break;
      }

      self shootturret();
      self notify("bullet_fired");
      self.heatlevel += var0;
      wait var0;
    }

    wait randomfloatrange(var3, var4);
  }
}

function ref_13024() {
  if(istrue(self.matchdata_logaward)) {
    var0 = self getturrettarget(0);

    if(isDefined(var0) && isPlayer(var0) && var0 isparachuting()) {
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
  level.vo_paratroopers = scripts\engine\utility::array_remove(level.vo_paratroopers, self);

  if(!isDefined(self)) {
    return;
  }

  self setmode("sentry_offline");
  self setscriptablepartstate("explode", "violent");

  if(isDefined(self.attackerdata)) {
    foreach(var1 in level.players) {
      var2 = 0;

      if(isDefined(self.attackerdata[var1.guid]) && isDefined(self.attackerdata[var1.guid].damage)) {
        if(self.attackerdata[var1.guid].damage >= self.maxhealth * 0.1) {
          var2 = 1;
        }

        if(self.attackerdata[var1.guid].damage >= self.maxhealth * 0.2) {
          var2 = 2;
        }

        if(var2 >= 1) {
          var1 thread scripts\cp\drone\emp_drone::giverankxp("destroyed_sentry_gun", scripts\cp\drone\emp_drone::getscoreinfovalue("destroyed_sentry_gun"));
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