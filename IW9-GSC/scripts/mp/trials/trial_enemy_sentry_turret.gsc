/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\trials\trial_enemy_sentry_turret.gsc
***********************************************************/

init() {
  thread init_internal();
}

init_internal() {
  level._effect["sentry_overheat_mp"] = loadfx("vfx/core/mp/killstreaks/vfx_sg_overheat_smoke");
  level.trial_sentry_turrets = [];

  while(!isDefined(level.struct_class_names))
    waitframe();

  _id_9E4E1482CB40C9C5 = scripts\engine\utility::getStructArray("trial_enemy_sentry_turret", "targetname");

  while(!isDefined(level.sentrysettings))
    waitframe();

  level.sentrysettings["trial_sentry_turret"] = level.sentrysettings["sentry_turret"];
  level.sentrysettings["trial_sentry_turret"].spinuptime = level.sentrysettings["trial_sentry_turret"].spinuptime * 2;
  level.sentrysettings["trial_sentry_turret"].health = 150;

  foreach(struct in _id_9E4E1482CB40C9C5) {
    waitframe();
    level.trial_sentry_turrets[level.trial_sentry_turrets.size] = setup_enemy_sentry(struct);
  }

  level.sentry_init_done = 1;
}

setup_enemy_sentry(_id_804269875F5062F1, _id_076BA9E808A42F81) {
  sentrytype = "trial_sentry_turret";
  config = level.sentrysettings[sentrytype];
  turret = spawnturret("misc_turret", _id_804269875F5062F1.origin, level.sentrysettings[sentrytype].weaponinfo);
  turret.team = scripts\mp\utility\game::getotherteam(level.trial["team"])[0];

  if(!isDefined(_id_804269875F5062F1.angles))
    _id_804269875F5062F1.angles = (0, 0, 0);

  turret.angles = _id_804269875F5062F1.angles;
  turret.health = config.maxhealth;
  turret.maxhealth = config.maxhealth;
  turret.sentrytype = sentrytype;
  turret.momentum = 0;
  turret.heatlevel = 0;
  turret.overheated = 0;
  turret.cooldownwaittime = 2;
  turret.turrettype = "sentry_turret";

  if(!isDefined(_id_076BA9E808A42F81))
    _id_076BA9E808A42F81 = "weapon_wm_mg_sentry_turret";

  turret setModel(_id_076BA9E808A42F81);
  turret setturretteam(turret.team);
  turret makeunusable();
  turret setnodeploy(1);
  turret setdefaultdroppitch(0);
  turret setautorotationdelay(0.2);
  turret maketurretinoperable();
  turret setleftarc(80);
  turret setrightarc(80);
  turret setbottomarc(50);
  turret settoparc(60);
  turret setconvergencetime(0.6, "pitch");
  turret setconvergencetime(0.6, "yaw");
  turret setconvergenceheightpercent(0.65);
  turret setdefaultdroppitch(-89.0);
  turret setturretmodechangewait(1);
  turret solid();
  _id_804269875F5062F1.turret = turret;
  wait 1;
  turret setmode("auto_nonai");
  turret thread damage_feedback_watch();
  turret thread sentry_attacktargets();
  turret thread sentry_handledeath();
  turret thread sentry_handledamage();
  turret.colmodel = spawn("script_model", turret.origin);
  turret.colmodel setModel("weapon_vm_mg_sentry_turret_invis_base");
  turret.colmodel dontinterpolate();
  turret.colmodel.angles = turret.angles;
  turret.colmodel.origin = turret.origin;
  turret.colmodel linkTo(turret, "tag_aim_pivot");
  _id_F96E4256F03C5F42 = "hud_icon_minimap_killstreak_sentry";
  turret.minimapid = turret.colmodel scripts\mp\objidpoolmanager::createobjective(_id_F96E4256F03C5F42, turret.team, undefined, 1, 1);

  if(isDefined(level.trial_turret_thread_func))
    turret thread[[level.trial_turret_thread_func]]();

  return turret;
}

enemy_sentry_debug() {
  self endon("death");
  self endon("kill_turret");
  level endon("game_ended");
  org = self.origin;
  interval = 0.05;
  _id_1AAD8F38CB38F703 = int(interval * 20);

  for(;;)
    wait(interval);
}

damage_feedback_watch() {
  self endon("death");
  self endon("kill_turret");
  level endon("game_ended");
  self setCanDamage(1);

  for(;;) {
    self waittill("damage", idamage, eattacker, vdir, vpoint, smeansofdeath, _id_9E834FE6754A9C98, _id_1D3F20A69CED2DD5, _id_920FF4456CE9A2FC, idflags, objweapon, origin, angles, normal, einflictor, eventid);

    if(!isDefined(eattacker) || !isPlayer(eattacker) && (!isDefined(eattacker.owner) || !isPlayer(eattacker.owner))) {
      continue;
    }
    if(isDefined(objweapon.basename)) {
      if(issubstr(objweapon.basename, "emp_drone")) {}
    }

    _id_379485F96865DB6D = isDefined(eattacker) && isPlayer(eattacker);
    _id_7543D4FE49C53684 = isDefined(eattacker.owner) && isPlayer(eattacker.owner);
    _id_B4A897B1262EA17C = isDefined(eattacker.classname) && eattacker.classname == "script_vehicle" && isDefined(eattacker.owner) && isPlayer(eattacker.owner);
    _id_F3B5D704CA2A9B3D = _id_B4A897B1262EA17C && smeansofdeath == "MOD_CRUSH";
  }
}

sentry_attacktargets() {
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

sentry_targetlocksound() {
  self endon("death");
  level.player playSound("sentry_gun_beep");
  wait 0.1;
  level.player playSound("sentry_gun_beep");
  wait 0.1;
  level.player playSound("sentry_gun_beep");
}

sentry_spinup() {
  thread sentry_targetlocksound();

  while(self.momentum < level.sentrysettings[self.sentrytype].spinuptime) {
    self.momentum = self.momentum + 0.1;
    wait 0.1;
  }
}

sentry_spindown() {
  self.momentum = 0;
}

sentry_burstfirestart() {
  self endon("death");
  self endon("stop_shooting");
  level endon("game_ended");
  sentry_spinup();
  firetime = 4 * weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
  _id_3746EC1BEFD86AE8 = level.sentrysettings[self.sentrytype].burstmin;
  _id_3E92CD336A99CE02 = level.sentrysettings[self.sentrytype].burstmax;
  _id_5F622C39D6661B23 = level.sentrysettings[self.sentrytype].pausemin;
  _id_42AE243CD994C3BD = level.sentrysettings[self.sentrytype].pausemax;

  for(;;) {
    _id_89F949A75D92E1A4 = randomintrange(_id_3746EC1BEFD86AE8, _id_3E92CD336A99CE02 + 1);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_89F949A75D92E1A4 && !self.overheated; _id_AC0E594AC96AA3A8++) {
      self shootturret();
      self notify("bullet_fired");
      self.heatlevel = self.heatlevel + firetime;
      wait(firetime);
    }

    wait(randomfloatrange(_id_5F622C39D6661B23, _id_42AE243CD994C3BD));
  }
}

sentry_burstfirestop() {
  self notify("stop_shooting");
}

sentry_heatmonitor() {
  if(istrue(self.skip_overheat)) {
    return;
  }
  self endon("death");
  firetime = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
  _id_C81D1AE9575CD803 = 0;
  _id_06D613D4ED09F7CA = 0;
  overheattime = level.sentrysettings[self.sentrytype].overheattime;
  overheatcooldown = level.sentrysettings[self.sentrytype].cooldowntime;

  for(;;) {
    if(self.heatlevel != _id_C81D1AE9575CD803)
      wait(firetime);
    else
      self.heatlevel = max(0, self.heatlevel - 0.05);

    if(self.heatlevel > overheattime) {
      self.overheated = 1;
      thread playheatfx();

      while(self.heatlevel) {
        self.heatlevel = max(0, self.heatlevel - overheatcooldown);
        wait 0.1;
      }

      self.overheated = 0;
      self notify("not_overheated");
    }

    _id_C81D1AE9575CD803 = self.heatlevel;
    wait 0.05;
  }
}

playheatfx() {
  self endon("death");
  self endon("not_overheated");
  level endon("game_ended");
  self notify("playing_heat_fx");
  self endon("playing_heat_fx");

  for(;;) {
    playFXOnTag(scripts\engine\utility::getfx("sentry_overheat_mp"), self, "tag_flash");
    wait(level.sentrysettings[self.sentrytype].fxtime);
  }
}

sentry_beepsounds() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    wait 3.0;

    if(!isDefined(self.carriedby))
      self playSound("sentry_gun_beep");
  }
}

sentry_handledeath() {
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  self setmode("sentry_offline");
  self setscriptablepartstate("explode", "violent");

  if(isDefined(self.attackerdata)) {
    foreach(player in level.players) {
      _id_54351D786449EE9E = 0;

      if(self.attackerdata[player.guid].damage >= self.maxhealth * 0.1)
        _id_54351D786449EE9E = 1;

      if(self.attackerdata[player.guid].damage >= self.maxhealth * 0.2)
        _id_54351D786449EE9E = 2;

      if(_id_54351D786449EE9E >= 1) {}
    }
  }

  if(isDefined(level.trial_turret_kill_func))
    self[[level.trial_turret_kill_func]]();

  if(isDefined(self))
    thread sentry_deleteturret();
}

sentry_handledamage() {
  for(;;) {
    self waittill("damage", damage, attacker);

    if(attacker == level.player)
      attacker _id_5762AC2F22202BA2::updatedamagefeedback("hitequip");
  }
}

sentry_deleteturret() {
  self notify("sentry_delete_turret");
  self endon("sentry_delete_turret");

  if(isDefined(self.colmodel))
    self.colmodel delete();

  wait 1.5;
  playFXOnTag(scripts\engine\utility::getfx("sentry_explode_mp"), self, "tag_aim");
  playFXOnTag(scripts\engine\utility::getfx("sentry_smoke_mp"), self, "tag_aim");
  self playSound("sentry_explode_smoke");
  wait 0.1;
  self notify("deleting");

  if(isDefined(self))
    self delete();
}