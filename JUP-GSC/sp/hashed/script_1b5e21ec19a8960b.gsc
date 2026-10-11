/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_1b5e21ec19a8960b.gsc
*************************************************/

#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\cp\agent_damage;
#using scripts\cp\cp_weapons;
#using scripts\cp\damage;
#using scripts\cp\damagefeedback;
#using scripts\cp\interaction;
#using scripts\cp\killstreaks\sentry_gun_cp;
#using scripts\cp\pickups;
#using scripts\cp\utility;
#using scripts\cp\utility\player;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\killstreaks\sentry_gun;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\sentientpoolmanager;
#using scripts\stealth\debug;
#namespace namespace_4848403b6f5b0da0;

function private function_a3f068b710625af7() {}

function function_936cbcc0667fb087() {
  level._effect["sentry_explode_mp"] = loadfx("vfx/core/mp/killstreaks/vfx_sentry_gun_explosion");
  level._effect["sentry_overheat_mp"] = loadfx("vfx/core/mp/killstreaks/vfx_sg_overheat_smoke");
  level._effect["sentry_sparks_mp"] = loadfx("vfx/core/mp/killstreaks/vfx_sentry_gun_explosion");
  level._effect["sentry_smoke_mp"] = loadfx("vfx/core/mp/killstreaks/vfx_sg_damage_blacksmoke");
  level._effect["sniper_red_laser_bright"] = loadfx("vfx/iw9/core/lasers/vfx_hipaimlaser_red_bright.vfx");
}

function function_f454179adec481d0() {
  function_936cbcc0667fb087();
  level.var_5e765833e3bf4b06 = [];
  level.sentrysettings["dungeon_sentry"] = spawnStruct();
  level.sentrysettings["dungeon_sentry"].health = 999999;
  level.sentrysettings["dungeon_sentry"].maxhealth = 350;
  level.sentrysettings["dungeon_sentry"].burstmin = 20;
  level.sentrysettings["dungeon_sentry"].burstmax = 60;
  level.sentrysettings["dungeon_sentry"].burstmaxtime = 4;
  level.sentrysettings["dungeon_sentry"].var_6265b628c3ed1103 = 3;
  level.sentrysettings["dungeon_sentry"].var_87d927a08cbfdf3f = 1;
  level.sentrysettings["dungeon_sentry"].pausemin = 0.15;
  level.sentrysettings["dungeon_sentry"].pausemax = 0.35;
  level.sentrysettings["dungeon_sentry"].lockstrength = 2;
  level.sentrysettings["dungeon_sentry"].sentrymodeon = "sentry";
  level.sentrysettings["dungeon_sentry"].var_7c46d96a6fedd4cd = "manual_target";
  level.sentrysettings["dungeon_sentry"].sentrymodeoff = "sentry_offline";
  level.sentrysettings["dungeon_sentry"].ammo = 200;
  level.sentrysettings["dungeon_sentry"].timeout = 999999;
  level.sentrysettings["dungeon_sentry"].spinuptime = 0.65;
  level.sentrysettings["dungeon_sentry"].overheattime = 8;
  level.sentrysettings["dungeon_sentry"].rightarc = 80;
  level.sentrysettings["dungeon_sentry"].leftarc = 80;
  level.sentrysettings["dungeon_sentry"].bottomarc = 50;
  level.sentrysettings["dungeon_sentry"].toparc = 60;
  level.sentrysettings["dungeon_sentry"].var_83c1b372bdac7446 = 512;
  level.sentrysettings["dungeon_sentry"].targetrange = 1024;
  level.sentrysettings["dungeon_sentry"].laserrange = 7562500;
  level.sentrysettings["dungeon_sentry"].cooldowntime = 0.1;
  level.sentrysettings["dungeon_sentry"].fxtime = 0.3;
  level.sentrysettings["dungeon_sentry"].streakname = "sentry_gun";
  level.sentrysettings["dungeon_sentry"].weaponinfo = "sentry_turret_jup_dungeons";
  level.sentrysettings["dungeon_sentry"].playerweaponinfo = "sentry_turret_jup_dungeons";
  level.sentrysettings["dungeon_sentry"].scriptable = "ks_sentry_turret_jup_cp";
  level.sentrysettings["dungeon_sentry"].modelbaseground = "wpn_wm_p45_mg_auto_sentry_v0_jup_cp";
  level.sentrysettings["dungeon_sentry"].modeldestroyedground = "wpn_wm_p45_mg_auto_sentry_v0_jup_cp";
  level.sentrysettings["dungeon_sentry"].placementhintstring = &"KILLSTREAKS_HINTS/SENTRY_GUN_PLACE";
  level.sentrysettings["dungeon_sentry"].ownerusehintstring = &"KILLSTREAKS_HINTS/SENTRY_USE";
  level.sentrysettings["dungeon_sentry"].headicon = 1;
  level.sentrysettings["dungeon_sentry"].headiconoffset = (0, 0, 75);
  level.sentrysettings["dungeon_sentry"].teamsplash = "used_sentry_gun";
  level.sentrysettings["dungeon_sentry"].destroyedsplash = "callout_destroyed_sentry_gun";
  level.sentrysettings["dungeon_sentry"].shouldsplash = 0;
  level.sentrysettings["dungeon_sentry"].votimeout = "sentry_gun_teamleader_crash";
  level.sentrysettings["dungeon_sentry"].vodestroyed = "sentry_gun_teamleader_crash";
  level.sentrysettings["dungeon_sentry"].scorepopup = "destroyed_sentry";
  level.sentrysettings["dungeon_sentry"].lightfxtag = "tag_fx";
  level.sentrysettings["dungeon_sentry"].iskillstreak = 1;
  level.sentrysettings["dungeon_sentry"].hitbyvehiclefunc = &scripts\cp\killstreaks\sentry_gun_cp::function_dad8d4cd587ec141;

  setdevdvarifuninitialized(@ "hash_69de6d4d9ba136d1", 0);
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x1c>");
  scripts\common\devgui::function_df648211d66cd3dd("<dev string:x3d>", "<dev string:x51>");
  scripts\common\devgui::function_fe953f000498048f();
}

function setup_enemy_sentry(var_804269875f5062f1, turret_model, var_385e9c9e53753524, team, display_icon, range_override, var_7c8380e5d9af0d5f) {
  sentrytype = default_to(var_385e9c9e53753524, "dungeon_sentry");
  team = default_to(team, "axis");
  config = level.sentrysettings[sentrytype];
  turret = spawnturret("misc_turret", var_804269875f5062f1.origin, level.sentrysettings[sentrytype].weaponinfo);
  turret.team = team;

  if(!isDefined(var_804269875f5062f1.angles)) {
    var_804269875f5062f1.angles = (0, 0, 0);
  }

  turret.angles = var_804269875f5062f1.angles;
  turret.health = config.health;
  turret.maxhealth = config.maxhealth;
  turret.sentrytype = sentrytype;
  turret.turreton = 1;
  turret.display_icon = display_icon;
  turret.objweapon = makeweapon(level.sentrysettings[sentrytype].weaponinfo);
  turret.disable_func = &sentry_disable;
  turret scripts\mp\sentientpoolmanager::registersentient("Killstreak_Static", team);
  turret.turrettype = "sentry_turret";
  turret.heatlevel = 0;
  turret.overheated = 0;
  turret.cooldownwaittime = 2;

  if(isDefined(range_override)) {
    turret function_8bd5f380528bf432(range_override);
    turret.targetrange = range_override;
    turret.var_52edc18a611b938d = squared(range_override);
  } else {
    turret.targetrange = config.targetrange;
    turret.var_52edc18a611b938d = squared(config.targetrange);
  }

  if(isDefined(var_7c8380e5d9af0d5f)) {
    turret.var_83c1b372bdac7446 = var_7c8380e5d9af0d5f;
    turret.var_5af42ba05a97de9a = squared(var_7c8380e5d9af0d5f);
  } else if(isDefined(var_804269875f5062f1.var_7c8380e5d9af0d5f)) {
    turret.var_83c1b372bdac7446 = int(var_804269875f5062f1.var_7c8380e5d9af0d5f);
    turret.var_5af42ba05a97de9a = squared(int(var_804269875f5062f1.var_7c8380e5d9af0d5f));
  } else {
    turret.var_83c1b372bdac7446 = config.var_83c1b372bdac7446;
    turret.var_5af42ba05a97de9a = squared(config.var_83c1b372bdac7446);
  }

  var_804269875f5062f1.turret = turret;

  if(!isDefined(turret_model) && isDefined(config.modelbaseground)) {
    turret_model = config.modelbaseground;
  }

  turret setModel(turret_model);
  turret setturretteam(team);
  turret makeunusable();
  turret setnodeploy(1);
  turret setdefaultdroppitch(0);
  turret setautorotationdelay(0.2);
  turret maketurretinoperable();

  if(isDefined(var_804269875f5062f1.skip_overheat)) {
    turret.skip_overheat = var_804269875f5062f1.skip_overheat;
  }

  leftarc = float(ter_op(isDefined(var_804269875f5062f1.leftarc), var_804269875f5062f1.leftarc, config.leftarc));
  turret setleftarc(leftarc);
  rightarc = float(ter_op(isDefined(var_804269875f5062f1.rightarc), var_804269875f5062f1.rightarc, config.rightarc));
  turret setrightarc(rightarc);
  toparc = float(ter_op(isDefined(var_804269875f5062f1.toparc), var_804269875f5062f1.toparc, config.toparc));
  turret settoparc(toparc);
  bottomarc = float(ter_op(isDefined(var_804269875f5062f1.bottomarc), var_804269875f5062f1.bottomarc, config.bottomarc));
  turret setbottomarc(bottomarc);
  turret setconvergencetime(0.6, "pitch");
  turret setconvergencetime(0.6, "yaw");
  turret setconvergenceheightpercent(0.65);
  turret setturretmodechangewait(0);
  turret solid();
  turret.var_d1f953c063dff1eb = 1;
  turret.trace_tag = turret tagexists("tag_laser") ? "tag_laser" : "tag_flash";
  turret.colmodel = spawn("script_model", turret.origin);
  turret.colmodel.team = turret.team;
  turret.colmodel.owner = turret.owner;
  turret.colmodel setModel("weapon_vm_mg_sentry_turret_invis_base");
  turret.colmodel dontinterpolate();
  turret.colmodel linkTo(turret);
  turret.colmodel.var_d1f953c063dff1eb = 1;
  turret.colmodel.turretowner = turret;

  if(isDefined(config.hitbyvehiclefunc)) {
    turret.hitbyvehiclefunc = config.hitbyvehiclefunc;
  }

  turret.navobstacle = createnavobstaclebybounds(turret.origin, (16, 16, 16), (0, 0, 0));
  turret scripts\cp_mp\emp_debuff::set_start_emp_callback(&sentryturret_empstarted);
  turret scripts\cp_mp\emp_debuff::set_clear_emp_callback(&sentryturret_empcleared);
  turret scripts\cp_mp\emp_debuff::allow_emp(0);

  if(!isDefined(level.killstreak_additional_targets)) {
    level.killstreak_additional_targets = [];
  }

  level.killstreak_additional_targets = array_add(level.killstreak_additional_targets, turret);
  wait 1;
  turret setmode(level.sentrysettings[sentrytype].sentrymodeon);
  turret scripts\cp_mp\emp_debuff::allow_emp(1);
  turret sentryturret_empupdate();
  turret thread sentry_watchfordeath();
  turret thread function_c89de017c526954();
  turret thread sentry_handledeath();

  if(isDefined(var_804269875f5062f1.var_2108ba0559bdaaff)) {
    var_2108ba0559bdaaff = var_804269875f5062f1.var_2108ba0559bdaaff;
  } else {
    var_2108ba0559bdaaff = &function_1adc5a7001847ae6;
  }

  turret.var_2108ba0559bdaaff = var_2108ba0559bdaaff;
  turret thread[[var_2108ba0559bdaaff]]();
  turret setscriptablepartstate("lights", "daytime", 0);

  if(1 && !istrue(var_804269875f5062f1.disable_hack)) {
    turret thread sentry_hack(team);
  }

  if(getdvarint(@ "hash_69de6d4d9ba136d1", 0)) {
    turret thread sentry_debug();
  }

  return turret;
}

function function_c89de017c526954() {
  self endon("death");
  self endon("kill_turret");
  self endon("preplaced_sentry_pickedup");
  level endon("game_ended");
  self setCanDamage(1);
  self setCanRadiusDamage(1);
  self.fake_health = self.maxhealth;

  while(true) {
    self waittill("damage", idamage, eattacker, vdir, vpoint, smeansofdeath, smodelname, stagname, spartname, idflags, objweapon, origin, angles, normal, einflictor, eventid);
    self.health += idamage;

    if(!isDefined(eattacker)) {
      continue;
    }

    if(isDefined(objweapon) && isDefined(objweapon.basename)) {
      var_e36d0c5378e4855b = objweapon.basename;
      var_e36d0c5378e4855b = strip_suffix(var_e36d0c5378e4855b, "_mp");
      var_e36d0c5378e4855b = strip_suffix(var_e36d0c5378e4855b, "_cp");

      if(smeansofdeath != "MOD_MELEE") {
        switch (var_e36d0c5378e4855b) {
          case #"hash_7a7616547d22d1d4":
          case #"hash_cf4e7cba76f5287f":
          case #"hash_ec99c59936c1a84a":
            continue;
        }
      }

      if(smeansofdeath != "MOD_IMPACT") {
        switch (var_e36d0c5378e4855b) {
          case #"hash_1768b8fe4480e4b":
          case #"hash_8059d93d3568c07":
          case #"hash_1b4881cfd42bb6d8":
          case #"hash_42dcb6ce7ecb709c":
          case #"hash_63d44e71602ef0a0":
          case #"hash_752a9051bc22d228":
          case #"hash_8670ac083666f3a4":
          case #"hash_e042760d17966848":
          case #"hash_e1f6f84e4cd950eb":
          case #"hash_fb36696c0708bf42":
            continue;
        }
      }
    }

    if(isDefined(objweapon) && scripts\cp\cp_weapons::isthrowingknife(objweapon.basename)) {
      continue;
    }

    idamage = scripts\cp\damage::handleapdamage(objweapon, smeansofdeath, idamage, eattacker);
    idamage = scripts\cp\damage::handleshotgundamage(objweapon, smeansofdeath, idamage);

    if(issharedfuncdefined("killstreak", "getModifiedAntiKillstreakDamage")) {
      idamage = self[[getsharedfunc("killstreak", "getModifiedAntiKillstreakDamage")]](eattacker, objweapon, smeansofdeath, idamage, self.maxhealth, 1, 1, 1);
    }

    self.fake_health -= idamage;

    if(self.fake_health <= self.maxhealth * 0.5 && !istrue(self.damagedstate)) {
      self.damagedstate = 1;
      self setscriptablepartstate("turret_damage", "on", 0);
    }

    if(!isPlayer(eattacker) && (!isDefined(eattacker.owner) || !isPlayer(eattacker.owner))) {
      continue;
    }

    isplayerdamage = isDefined(eattacker) && isPlayer(eattacker);
    var_7543d4fe49c53684 = isDefined(eattacker.owner) && isPlayer(eattacker.owner);
    var_b4a897b1262ea17c = isDefined(eattacker.classname) && eattacker.classname == "script_vehicle" && isDefined(eattacker.owner) && isPlayer(eattacker.owner);
    var_f3b5d704ca2a9b3d = var_b4a897b1262ea17c && smeansofdeath == "MOD_CRUSH";

    if(isplayerdamage || var_7543d4fe49c53684 || var_f3b5d704ca2a9b3d) {
      if(var_7543d4fe49c53684) {
        eattacker = eattacker.owner;
      }

      scripts\cp\agent_damage::addattacker(self, eattacker, einflictor, objweapon, idamage, vpoint, vdir, undefined, undefined, smeansofdeath);
    }

    scripts\cp\damagefeedback::process_damage_feedback(einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vdir, vdir, spartname, undefined, self);
  }
}

function sentry_watchfordeath() {
  self endon("death");

  while(true) {
    if(!isDefined(self.fake_health)) {
      waitframe();
      continue;
    }

    if(self.fake_health <= 0) {
      self stoploopsound("sentry_gun_hydraulics");
      self notify("death");
    }

    wait 0.1;
  }
}

function sentry_targetlocksound() {
  self endon("death");
  self endon("preplaced_sentry_pickedup");
  self notify("sentrygun_target_lock_sfx");
  self endon("sentrygun_target_lock_sfx");
  self playSound("sentry_gun_target_lock_beep");
}

function sentry_heatmonitor() {
  if(istrue(self.skip_overheat)) {
    return;
  }

  self endon("death");
  self notify("sentry_heat_monitor_start");
  self endon("sentry_heat_monitor_start");
  self endon("preplaced_sentry_pickedup");
  firetime = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
  var_c81d1ae9575cd803 = 0;
  var_6d613d4ed09f7ca = 0;
  overheattime = level.sentrysettings[self.sentrytype].overheattime;
  overheatcooldown = level.sentrysettings[self.sentrytype].cooldowntime;

  for(;;) {
    if(self.heatlevel != var_c81d1ae9575cd803) {
      wait firetime;
    } else {
      self.heatlevel = max(0, self.heatlevel - 0.05);
    }

    if(self.heatlevel > overheattime) {
      self.overheated = 1;
      thread function_fa148e3018078581();

      while(self.heatlevel) {
        self.heatlevel = max(0, self.heatlevel - overheatcooldown);
        wait 0.1;
      }

      self.overheated = 0;
      self notify("not_overheated");
    }

    var_c81d1ae9575cd803 = self.heatlevel;
    wait 0.05;
  }
}

function function_fa148e3018078581() {
  self endon("death");
  self endon("not_overheated");
  self endon("preplaced_sentry_pickedup");
  level endon("game_ended");
  self notify("playing_heat_fx");
  self endon("playing_heat_fx");

  for(;;) {
    playFXOnTag(getfx("sentry_overheat_mp"), self, "tag_flash");
    wait level.sentrysettings[self.sentrytype].fxtime;
  }
}

function function_e11d50e9ff4b9319() {
  self waittill("kill_turret", skipshutdown, wasdestroyed);
  self notify("death");
}

function sentry_handledeath() {
  self endon("preplaced_sentry_pickedup");
  childthread function_e11d50e9ff4b9319();
  self waittill("death");
  self notify("stop_idle_movement");

  if(!isDefined(self)) {
    if(isDefined(self.headiconid)) {
      scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
    }

    if(isDefined(self.useownerobj)) {
      self.useownerobj delete();
    }

    return;
  }

  self setmode("sentry_offline");
  self setscriptablepartstate("explode", "violent");

  if(isDefined(self)) {
    thread sentry_deleteturret();
  }
}

function sentry_deleteturret(skip_fx) {
  self endon("preplaced_sentry_pickedup");
  self notify("sentry_delete_turret");
  self endon("sentry_delete_turret");
  level.killstreak_additional_targets = array_remove(level.killstreak_additional_targets, self);

  if(isDefined(self.navobstacle)) {
    destroynavobstacle(self.navobstacle);
  }

  if(isDefined(self.headiconid)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  }

  if(isDefined(self.useownerobj)) {
    self.useownerobj delete();
  }

  scripts\mp\sentientpoolmanager::unregistersentient(self.sentientpool, self.sentientpoolindex);

  if(!istrue(skip_fx)) {
    wait 1.5;

    if(!isDefined(self)) {
      return;
    }

    playFXOnTag(getfx("sentry_explode_mp"), self, "tag_aim");
    playFXOnTag(getfx("sentry_smoke_mp"), self, "tag_aim");
    self playSound("sentry_explode_smoke");
    wait 0.1;
  }

  self notify("deleting");

  if(isDefined(self.targetent)) {
    self.targetent delete();
  }

  if(isDefined(self.colmodel)) {
    self.colmodel delete();
  }

  if(isDefined(self)) {
    self delete();
  }
}

function private function_bb6e4e3e4ce7dcc8() {}

function sentry_hack(team) {
  self endon("death");
  team = default_to(team, "axis");
  enemy_team = get_enemy_team(team);
  self setscriptablepartstate("hack_usable", "on");
  self waittill("hacked");

  iprintlnbold("<dev string:x68>");

  waitframe();
  self.hacked = 1;
  self setscriptablepartstate("hack_usable", "off");

  if(false) {
    function_d0baca9328e37da4(enemy_team);
  } else if(true) {
    self.owner = undefined;
    self.team = team;
    self setotherent(undefined);
    sentry_shutdown();
  }

  if(false) {
    return;
  }

  hinttag = "tag_aim_pivot";
  hintpos = self gettagorigin(hinttag);
  wait 1;

  if(!isDefined(self.useownerobj)) {
    var_d77d65a274842877 = &"DUNGEONS/HACKED_SENTRY_ON";

    if(false) {
      var_d77d65a274842877 = level.sentrysettings["dungeon_sentry"].ownerusehintstring;
    }

    hinticon = undefined;
    hintduration = undefined;
    var_c463127de55bed3c = undefined;
    hintdist = 250;
    hintfov = undefined;
    usedist = 150;
    usefov = 50;
    self.useownerobj = scripts\cp\utility::createhintobject(hintpos, "HINT_BUTTON", hinticon, var_d77d65a274842877, var_c463127de55bed3c, hintduration, "show", hintdist, hintfov, usedist, usefov);
  } else {
    self.useownerobj function_dfb78b3e724ad620(1);
    self.useownerobj dontinterpolate();
    self.useownerobj.origin = hintpos;
  }

  self.useownerobj linkTo(self, hinttag);

  if(false) {
    foreach(guy in level.players) {
      if(guy != self.owner) {
        self.useownerobj disableplayeruse(guy);
        continue;
      }

      self.useownerobj enableplayeruse(guy);
    }

    self.owner thread sentry_watchpickup(self);
    return;
  }

  if(true) {
    level thread function_46acfb4e6cd7e6af(self, 0);
  }
}

function sentry_shutdown(is_basic) {
  if(!isDefined(is_basic)) {
    is_basic = 0;
  }

  self endon("death");
  self notify("stop_sentry_basic_think");
  self notify("stop_idle_movement");
  self notify("stop_sentry_complex_think");
  self setscriptablepartstate("hack_usable", "off");
  self laseroff();
  self turretfiredisable();

  if(!is_basic) {
    targ_ent = self gettargetentity();

    if(!isDefined(targ_ent) || isDefined(targ_ent) && targ_ent != self.targetent) {
      var_6bc5fa58d62d3120 = self gettagorigin(self.trace_tag);
      var_440719344ec09c5a = self gettagangles(self.trace_tag);
      var_402a7410df372602 = var_6bc5fa58d62d3120 + anglesToForward(var_440719344ec09c5a) * 500;
      self.targetent.origin = var_402a7410df372602;
      self settargetentity(self.targetent);
    }

    self setdefaultdroppitch(70);
    bottom_arc = self getbottomarc();

    if(70 > bottom_arc) {
      self setbottomarc(70);
    }

    function_c2659db9dbffda55(self.var_3c19d396e8243a45, 1);
    function_64109b7cba5261eb(self.var_6b7f5a97c612b748, 1);
  }

  self setmode("sentry_offline");
  self.state = "shutdown";
  self playLoopSound("sentry_gun_hydraulics");
  self setscriptablepartstate("lights", "off");
  self setscriptablepartstate("shutdown", "on");
}

function sentry_disable() {
  self endon("death");
  self notify("stop_idle_movement");
  self notify("stop_sentry_complex_think");
  function_c2659db9dbffda55(self.var_3c19d396e8243a45, 0.25);
  self cleartargetentity();
  self turretfiredisable();
  self setdefaultdroppitch(30);
  self setmode("sentry_offline");
  self laseroff();
  self.state = "disabled";
  self setscriptablepartstate("hack_usable", "off");
  self setscriptablepartstate("lights", "off");
  self setscriptablepartstate("empd", "active");
}

function function_46acfb4e6cd7e6af(turret, infinite_toggle) {
  turret endon("death");

  while(true) {
    turret.useownerobj waittill("trigger", player);
    turret notify("converted");

    if(!isDefined(player)) {
      continue;
    }

    if(!isPlayer(player)) {
      continue;
    }

    if(is_equal(turret.state, "shutdown")) {
      turret.owner = player;
      turret.team = player.team;
      turret setotherent(player);
      turret.state = undefined;
      turret setscriptablepartstate("lights", "daytime");
      turret setscriptablepartstate("shutdown", "off");
      turret.useownerobj function_dfb78b3e724ad620(0);
      turret playLoopSound("sentry_gun_hydraulics");
      turret function_d0baca9328e37da4(player.team);

      if(!istrue(infinite_toggle)) {
        break;
      }

      wait 1;
      turret.useownerobj function_dfb78b3e724ad620(1);
      turret.useownerobj setHintString(&"DUNGEONS/HACKED_SENTRY_OFF");
      continue;
    }

    turret.useownerobj function_dfb78b3e724ad620(0);
    turret sentry_shutdown(1);
    wait 1;
    turret.useownerobj function_dfb78b3e724ad620(1);
    turret.useownerobj setHintString(&"DUNGEONS/HACKED_SENTRY_ON");
  }
}

function function_d0baca9328e37da4(new_team) {
  self setturretteam(new_team);
  self setturretowner(self.owner);
  self.team = new_team;

  if(isDefined(self.colmodel)) {
    self.colmodel.team = new_team;
    self.colmodel.owner = self.owner;
  }

  if(true) {
    self cleartargetentity();
    self turretfireenable();

    if(isDefined(self.targetent)) {
      self.targetent delete();
    }

    self.targetent = undefined;
    self notify("stop_sentry_complex_think");
    thread function_1adc5a7001847ae6();
    self function_8bd5f380528bf432(2000);
  } else {
    self.var_6320b0669bc739aa = 1;
    self.state = undefined;
    self notify("stop_sentry_complex_think");
    self thread[[self.var_2108ba0559bdaaff]]();
  }

  scripts\mp\sentientpoolmanager::unregistersentient(self.sentientpool, self.sentientpoolindex);
  scripts\mp\sentientpoolmanager::registersentient("Killstreak_Static", new_team);
  self makeentitynomeleetarget();

  if(isDefined(self.display_icon)) {
    display_icon = self.display_icon;
  } else if(isDefined(level.sentrysettings[self.sentrytype].headicon)) {
    display_icon = level.sentrysettings[self.sentrytype].headicon;
  } else {
    display_icon = 0;
  }

  if(display_icon) {
    self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 64, undefined, undefined, undefined, 0.1, 1);
  }
}

function sentry_watchpickup(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  turret endon("turret_hacked");
  self endon("disconnect");
  level endon("game_ended");
  turret.streakinfo = level.sentrysettings["sentry_turret"];
  turret.streakinfo.owner = self;
  turret.timeout = level.sentrysettings["sentry_turret"].timeout;

  while(true) {
    turret.useownerobj waittill("trigger", player);

    if(player != self) {
      continue;
    }

    if(issharedfuncdefined("sentry_gun", "allowPickupOfTurret")) {
      if(!player[[getsharedfunc("sentry_gun", "allowPickupOfTurret")]]()) {
        continue;
      }
    }

    turret.useownerobj function_dfb78b3e724ad620(0);

    if(true) {
      function_4c3e8916547a5d90(turret);
      break;
    }

    if(!istrue(scripts\cp_mp\killstreaks\sentry_gun::function_8fbbc6a868621dd5(turret))) {
      continue;
    }

    thread scripts\cp_mp\killstreaks\sentry_gun::sentryturret_setcarried(turret);
  }
}

function function_4c3e8916547a5d90(turret) {
  var_9b12648b9f250b9c = spawnStruct();
  var_9b12648b9f250b9c.scriptablename = "brloot_munition_jup_sentry";
  var_9b12648b9f250b9c.count = 1;
  var_9b12648b9f250b9c.origin = self.origin;
  scripts\cp\pickups::function_b5f5576a0017c089(var_9b12648b9f250b9c, undefined, self, 0);
  turret notify("preplaced_sentry_pickedup");
  turret sentry_deleteturret(1);
}

function private function_1ca7ff589b42e24a() {}

function sentryturret_empstarted(data) {
  sentryturret_empupdate();
}

function sentryturret_empcleared(isdeath) {
  if(isdeath) {
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
  self setmode(level.sentrysettings[self.turrettype].sentrymodeon);
}

function private function_ec8574c037630ff6() {}

function function_1adc5a7001847ae6() {
  self endon("death");
  self endon("stop_sentry_basic_think");
  level endon("game_ended");
  self setmode("sentry");
  self.momentum = 0;
  thread sentry_heatmonitor();

  for(;;) {
    waittill_either("turretstatechange", "cooled");

    if(is_equal(self.state, "engaging") && is_equal(self.team, self.curtarget.team)) {
      if(self.laser_on) {
        self laseroff();
        self.laser_on = 0;
      }

      self stopfiring();
      self notify("stop_shooting");
      waitframe();
      self setmode("sentry");
      self.state = undefined;
      continue;
    }

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

function sentry_spinup(configoverride) {
  self endon("stop_sentry_basic_think");
  thread sentry_targetlocksound();

  while(self.momentum < configoverride.spinuptime) {
    self.momentum += 0.1;
    wait 0.1;
  }
}

function sentry_spindown() {
  self.momentum = 0;
}

function sentry_burstfirestart(configoverride, maxroundsoverride, var_7a4f7bd11952e7bc) {
  self endon("death");
  self endon("stop_shooting");
  self endon("stop_sentry_basic_think");
  level endon("game_ended");
  config = level.sentrysettings[self.sentrytype];
  sentry_spinup(config);
  firetime = weaponfiretime(config.weaponinfo);
  minshots = config.burstmin;
  maxshots = config.burstmax;
  minpause = config.pausemin;
  maxpause = config.pausemax;
  lockstrength = config.lockstrength;

  for(;;) {
    numshots = randomintrange(minshots, maxshots + 1);

    if(isDefined(maxroundsoverride)) {
      numshots = maxroundsoverride;
    }

    for(i = 0; i < numshots && !self.overheated; i++) {
      self shootturret("tag_flash", lockstrength);
      self notify("bullet_fired");
      self.heatlevel += firetime;
      wait firetime;
    }

    if(istrue(var_7a4f7bd11952e7bc)) {
      break;
    }

    wait randomfloatrange(minpause, maxpause);
  }
}

function sentry_burstfirestop() {
  self notify("stop_shooting");
}

function private function_f90ee10011da2bbe() {}

function function_5e66cae8a3e9f368() {
  self endon("death");
  self endon("stop_sentry_complex_think");
  config = level.sentrysettings[self.sentrytype];

  if(!isDefined(self.var_83c1b372bdac7446) && isDefined(config.var_83c1b372bdac7446)) {
    self.var_83c1b372bdac7446 = config.var_83c1b372bdac7446;
    self.var_5af42ba05a97de9a = squared(self.var_83c1b372bdac7446);
  }

  level.sentrysettings[self.sentrytype].sentrymodeon = "manual_target";
  level.sentrysettings[self.sentrytype].sentrymodeoff = "manual_target";
  self setmode("manual_target");
  targettimeout = 0;
  timeout = 5;
  time_interval = 0.5;
  self.laser_on = 0;
  self.overheated = 0;
  self.momentum = 0;
  thread function_3dddad03d8b1c284();
  thread sentry_heatmonitor();

  while(true) {
    if(!istrue(self.turreton) || istrue(self.turretdisabled)) {
      waitframe();
      continue;
    }

    besttarget = sentry_getbesttarget();
    var_1b951c4e47ba5c35 = 1;

    if(isDefined(besttarget)) {
      if(!self.laser_on) {
        self laseron();
        self.laser_on = 1;
        self.state = "engaging";
        self notify("engaging_target");
        self notify("stop_idle_movement");
        thread sentry_targetlocksound();
      }

      if(isPlayer(besttarget) && issharedfuncdefined("player", "isReallyAlive")) {
        if(![[getsharedfunc("player", "isReallyAlive")]](besttarget)) {
          var_1b951c4e47ba5c35 = 0;
        }
      } else if(isagent(besttarget)) {
        if(!isalive(besttarget)) {
          var_1b951c4e47ba5c35 = 0;
        }
      }

      if(var_1b951c4e47ba5c35) {
        if(getdvarint(@ "hash_69de6d4d9ba136d1", 0)) {
          thread scripts\cp_mp\utility\debug_utility::drawline(besttarget.origin, self.origin, 5, (0, 0, 1));
        }

        target_lost = function_2404375517987371(besttarget);

        if(!istrue(target_lost)) {
          scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(config.cooldowntime);
        }
      }
    } else if(self.state != "idle") {
      if(self.state != "lost_LOS") {
        function_30b63fb2cbf3dec7();
      }

      if(getdvarint(@ "hash_69de6d4d9ba136d1", 0)) {
        announcement("<dev string:x76>" + targettimeout + "<dev string:x81>" + timeout);
      }

      wait time_interval;
      targettimeout += time_interval;

      if(targettimeout > timeout) {
        if(self.laser_on) {
          self laseroff();
          self.laser_on = 0;
        }

        thread function_3dddad03d8b1c284();
      } else {
        continue;
      }
    } else {
      wait 1;
      targettimeout = 0;
      continue;
    }

    waitframe();
  }
}

function function_3dddad03d8b1c284() {
  self endon("death");
  self endon("exit_idle");
  self endon("stop_idle_movement");
  self endon("stop_sentry_complex_think");

  if(isDefined(self.state) && self.state == "idle") {
    return;
  }

  self stopfiring();
  self.state = "idle";
  self notify("enter_idle");
  self notify("stop_shooting");

  if(isDefined(self.idle_func)) {
    self[[self.idle_func]]();
    return;
  }

  if(!isDefined(self.targetent)) {
    self.targetent = spawn("script_model", self.origin);
    self.targetent setModel("tag_origin");
  }

  trace_tag = self.trace_tag;
  var_a3849680004d6670 = self gettagorigin(trace_tag);
  var_440719344ec09c5a = self gettagangles(trace_tag);
  var_402a7410df372602 = var_a3849680004d6670 + anglesToForward(var_440719344ec09c5a) * 3000;
  self.targetent.origin = var_402a7410df372602;
  self.targetent dontinterpolate();
  self settargetentity(self.targetent);
  sentry_origin = self.origin;
  sentry_angles = self.angles;
  var_4492485a1ccedc2 = anglestoaxis(sentry_angles);
  var_878bae61aca86fc5 = var_4492485a1ccedc2["forward"];
  var_a1b727d30fc62a0f = var_4492485a1ccedc2["up"];
  var_6232855eba31163a = var_4492485a1ccedc2["right"];
  var_1b77e17a42e2545b = anglestoleft(sentry_angles);
  maxangle = self getleftarc();
  drawdist = 300;
  var_b716ed1e1043d49d = rotatepointaroundvector(var_a1b727d30fc62a0f, var_878bae61aca86fc5, maxangle);
  var_37acb3a5ef4e3396 = vectorNormalize(vectorcross(var_b716ed1e1043d49d, var_a1b727d30fc62a0f));
  var_13b2c03f423eb4f1 = vectorcross(var_37acb3a5ef4e3396, var_b716ed1e1043d49d);
  var_5a8f11024e7733a5 = axistoangles(var_b716ed1e1043d49d, var_37acb3a5ef4e3396, var_13b2c03f423eb4f1);
  var_f4feef348ddcce80 = rotatepointaroundvector(var_a1b727d30fc62a0f, var_878bae61aca86fc5, maxangle * -1);
  var_28a104b41542054b = vectorNormalize(vectorcross(var_f4feef348ddcce80, var_a1b727d30fc62a0f));
  var_71068ef94589e94a = vectorcross(var_28a104b41542054b, var_f4feef348ddcce80);
  var_6b5bd2eb86959740 = axistoangles(var_f4feef348ddcce80, var_28a104b41542054b, var_71068ef94589e94a);
  var_d5c157bf3efda129 = vectortoangles(var_a1b727d30fc62a0f);
  var_3c19d396e8243a45 = vectortoangles(var_878bae61aca86fc5);
  self.var_3c19d396e8243a45 = var_3c19d396e8243a45;
  var_1b15c3a05b795a8e = rotatepointaroundvector(var_6232855eba31163a, var_878bae61aca86fc5, -70);
  var_f30667c02d5b0b71 = vectorNormalize(vectorcross(var_1b15c3a05b795a8e, var_6232855eba31163a));
  var_fb004474b0d5134c = vectorcross(var_f30667c02d5b0b71, var_1b15c3a05b795a8e);
  self.var_6b7f5a97c612b748 = axistoangles(var_1b15c3a05b795a8e, var_f30667c02d5b0b71, var_fb004474b0d5134c);
  newdir = anglesToForward(var_3c19d396e8243a45);
  newpos = var_a3849680004d6670 + newdir * self.targetrange;
  trace = scripts\engine\trace::ray_trace(var_a3849680004d6670, newpos, self);
  end = trace["position"];
  newposfinal = (newpos[0], newpos[1], var_a3849680004d6670[2]);
  vmidpoint = (var_a3849680004d6670 + end) / 2;
  waitframe();

  while(true) {
    function_c2659db9dbffda55(var_5a8f11024e7733a5, 4);
    function_c2659db9dbffda55(var_6b5bd2eb86959740, 4);
  }
}

function function_ae918abfa5c66bd6(var_f095df44cb4d44c3, var_b1912d395068cf48) {
  self endon("death");
  self endon("stop_sentry_complex_think");
  wait 5;

  if(isDefined(var_b1912d395068cf48) && isvector(var_b1912d395068cf48)) {
    self.soundorg = spawn("script_model", var_b1912d395068cf48);
  } else {
    self.soundorg = spawn("script_model", self.origin);
  }

  self.soundorg setModel("tag_origin");
  waitframe();
  self.soundorg linkTo(self, "tag_aim_pivot");
  self.soundorg playLoopSound("cp_laser_mvmt");
}

function function_ccab4a92dcf417e4(var_f095df44cb4d44c3) {
  self.soundorg stoploopsound("cp_laser_mvmt");
  self.soundorg delete();
}

function function_c2659db9dbffda55(angles, timehere) {
  self endon("death");
  self endon("exit_idle");
  self endon("stop_idle_movement");
  self endon("stop_sentry_complex_think");

  if(!isDefined(timehere)) {
    timehere = 4;
  }

  tag = self.trace_tag;
  sentry_origin = self gettagorigin(tag);
  newdir = anglesToForward(angles);
  newpos = sentry_origin + newdir * 500;
  newposfinal = (newpos[0], newpos[1], sentry_origin[2]);
  self.targetent moveTo(newposfinal, timehere);
  wait timehere - 0.1;
}

function function_64109b7cba5261eb(angles, timehere) {
  self endon("death");
  self endon("exit_idle");
  self endon("stop_idle_movement");
  self endon("stop_sentry_complex_think");

  if(!isDefined(timehere)) {
    timehere = 4;
  }

  tag = self.trace_tag;
  newdir = anglesToForward(angles);
  sentry_origin = self gettagorigin(tag) + newdir * 2;
  newpos = sentry_origin + newdir * 666;
  newposfinal = (newpos[0], newpos[1], sentry_origin[2]);
  newposfinal = newpos;
  movetime = timehere * 0.7;
  var_93912c82c941f846 = timehere * 0.15;
  var_dbfa2182fe49a2af = timehere * 0.15;
  self.targetent moveTo(newposfinal, movetime, var_93912c82c941f846, var_dbfa2182fe49a2af);

  if(getdvarint(@ "hash_69de6d4d9ba136d1", 0)) {
    level thread scripts\cp_mp\utility\debug_utility::drawline(self.origin, newposfinal, timehere, (1, 0, 0));
  }

  wait timehere;
}

function function_2404375517987371(besttarget) {
  config = level.sentrysettings[self.sentrytype];
  self.var_4ab52ebab6dddef8 = undefined;

  while(istrue(self.turreton) && function_b5d0a038b8a18782(besttarget)) {
    self settargetentity(besttarget);
    self.curtarget = besttarget;
    self.var_4ab52ebab6dddef8 = gettime();

    if(isPlayer(besttarget)) {
      pauseinterval = config.var_6265b628c3ed1103;
    } else {
      pauseinterval = config.var_87d927a08cbfdf3f;
    }

    function_20817f07e87d580b(config.burstmaxtime, besttarget);

    if(istrue(self.turreton) && !function_b5d0a038b8a18782(besttarget)) {
      self cleartargetentity();
      return true;
    }

    self.var_4ab52ebab6dddef8 = gettime();
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(pauseinterval);
  }

  self cleartargetentity();
  return false;
}

function function_20817f07e87d580b(maxbursttime, potentialtarget) {
  config = level.sentrysettings[self.sentrytype];
  firetime = weaponfiretime(config.weaponinfo);
  minshots = config.burstmin;
  maxshots = config.burstmax;
  minpause = config.pausemin;
  maxpause = config.pausemax;
  lockstrength = config.lockstrength;
  currenttime = 0;
  var_1b951c4e47ba5c35 = 1;
  var_89ca43180ff7115a = undefined;
  sentry_spinup(config);

  while(istrue(self.turreton) && currenttime < maxbursttime && var_1b951c4e47ba5c35) {
    numshots = randomintrange(minshots, maxshots + 1);

    for(i = 0; i < numshots && !self.overheated; i++) {
      if(!istrue(self.turreton)) {
        break;
      }

      target = self getturrettarget(1);

      if(!isDefined(target)) {
        break;
      }

      if(isPlayer(target)) {
        if(!scripts\cp\utility\player::isreallyalive(target) || istrue(target.var_f6f8549c6fd27e85)) {
          break;
        }
      }

      self shootturret("tag_flash", lockstrength);
      self.heatlevel += firetime;
      wait firetime;
      currenttime += firetime;
    }

    if(!istrue(self.turreton)) {
      break;
    }

    randwait = randomfloatrange(minpause, maxpause);
    wait randwait;
    currenttime += randwait;

    if(isPlayer(potentialtarget) && issharedfuncdefined("player", "isReallyAlive")) {
      var_1b951c4e47ba5c35 = [[getsharedfunc("player", "isReallyAlive")]](potentialtarget);
      continue;
    }

    if(isagent(potentialtarget)) {
      var_1b951c4e47ba5c35 = isalive(potentialtarget);
    }
  }
}

function sentry_getbesttarget() {
  potentialtargetlist = [];
  var_66aa7f667c91eef0 = [];
  var_bd57006b6a4d1c98 = [];
  team = default_to(self.team, "axis");
  enemy_team = get_enemy_team(team);
  var_89566990bccf6f7a = [];
  var_ee7516e9ecaf3d16 = [];
  var_3079648614823f39 = [];
  var_89566990bccf6f7a = getaiarrayinradius(self.origin, self.targetrange, enemy_team);

  if(team != "allies" && team != "neutral") {
    foreach(player in level.players) {
      if(distancesquared(self.origin, player.origin) < self.var_52edc18a611b938d) {
        var_ee7516e9ecaf3d16[var_ee7516e9ecaf3d16.size] = player;
      }
    }
  }

  all_turrets = getEntArray("misc_turret", "classname");

  foreach(turret in all_turrets) {
    if(!is_equal(turret.team, enemy_team)) {
      continue;
    }

    if(distancesquared(self.origin, turret.origin) < self.var_52edc18a611b938d) {
      var_3079648614823f39[var_3079648614823f39.size] = turret;
    }
  }

  ents = array_combine(var_89566990bccf6f7a, var_ee7516e9ecaf3d16, var_3079648614823f39);

  foreach(targ in ents) {
    if(array_contains(level.var_5e765833e3bf4b06, targ)) {
      continue;
    }

    if(!issentient(targ)) {
      continue;
    }

    potentialtargetlist = array_add(potentialtargetlist, targ);
  }

  var_66aa7f667c91eef0 = vehicle_getarrayinradius(self.origin, self.targetrange);

  foreach(veh in var_66aa7f667c91eef0) {
    if(is_equal(veh.vehiclename, "assault_drone") && is_equal(veh.team, enemy_team)) {
      var_bd57006b6a4d1c98[var_bd57006b6a4d1c98.size] = veh;
      continue;
    }

    if(!scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_isenemytoteam(veh, team)) {
      continue;
    }

    link_parent = self getlinkedparent();

    if(is_equal(link_parent, veh)) {
      continue;
    }

    if(veh scripts\common\vehicle::isvehiclehusk()) {
      continue;
    }

    var_bd57006b6a4d1c98[var_bd57006b6a4d1c98.size] = veh;
  }

  potentialtargetlist = array_combine_unique(potentialtargetlist, var_bd57006b6a4d1c98);
  besttarget = undefined;
  bestrange = undefined;
  start_tag = self.trace_tag;

  foreach(potentialtarget in potentialtargetlist) {
    validtarget = function_1d3253884542b0e6(potentialtarget);

    if(!istrue(validtarget)) {
      continue;
    }

    startpoint = self gettagorigin(start_tag);
    endpoint = potentialtarget.origin;
    currentrange = distancesquared(startpoint, endpoint);

    if(currentrange <= self.var_52edc18a611b938d) {
      if(!isDefined(besttarget) && !isDefined(bestrange) || currentrange < bestrange) {
        besttarget = potentialtarget;
        bestrange = currentrange;
      }
    }
  }

  return besttarget;
}

function function_1d3253884542b0e6(potentialtarget) {
  config = level.sentrysettings[self.sentrytype];
  pauseinterval = config.var_6265b628c3ed1103;
  var_ad7a3a1d2beff3e = (pauseinterval + 1) * 1000;

  if(istrue(potentialtarget.notarget)) {
    return false;
  }

  if(scripts\cp_mp\emp_debuff::is_empd()) {
    return false;
  }

  if(isPlayer(potentialtarget)) {
    if(issharedfuncdefined("player", "isReallyAlive") && ![[getsharedfunc("player", "isReallyAlive")]](potentialtarget)) {
      return false;
    }

    if(istrue(potentialtarget.var_f6f8549c6fd27e85)) {
      return false;
    }
  }

  if(!function_f391d89f9a5bcd21(potentialtarget)) {
    return false;
  }

  if(distance2dsquared(self.origin, potentialtarget.origin) > self.var_52edc18a611b938d) {
    return false;
  }

  if(isPlayer(potentialtarget) && potentialtarget isswimunderwater()) {
    return false;
  }

  if(isPlayer(potentialtarget) && self.team == "axis" && function_eac0cd99c9c6d8ee() == "hidden") {
    if(isDefined(self.var_4ab52ebab6dddef8)) {
      var_235064ed7598e50b = gettime() - self.var_4ab52ebab6dddef8;

      if(var_235064ed7598e50b < var_ad7a3a1d2beff3e && sentry_canseetarget(potentialtarget)) {
        return true;
      }
    }

    if(isDefined(self.var_5af42ba05a97de9a) && distancesquared(potentialtarget.origin, self.origin) > self.var_5af42ba05a97de9a) {
      return false;
    }
  }

  if(!sentry_canseetarget(potentialtarget)) {
    return false;
  }

  if(isDefined(self.var_f4e212847c7e4497)) {
    if(![[self.var_f4e212847c7e4497]](potentialtarget)) {
      return false;
    }
  }

  return true;
}

function function_8a65ef9c60082965(turret, callback) {
  turret.var_f4e212847c7e4497 = callback;
}

function function_b5d0a038b8a18782(besttarget) {
  if(!isDefined(besttarget)) {
    return false;
  }

  start_tag = self.trace_tag;

  if(distancesquared(self gettagorigin(start_tag), besttarget.origin) > self.var_52edc18a611b938d) {
    return false;
  }

  if(is_equal(besttarget.classname, "misc_turret")) {
    if(is_equal(besttarget.team, self.team)) {
      return false;
    }
  } else if(is_equal(besttarget.classname, "script_vehicle")) {
    if(is_equal(besttarget.vehiclename, "assault_drone")) {
      if(!is_equal(besttarget.team, get_enemy_team(self.team))) {
        return false;
      }

      return true;
    }

    if(!scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_isenemytoteam(besttarget, self.team)) {
      return false;
    }

    if(besttarget scripts\common\vehicle::isvehiclehusk()) {
      return false;
    }
  }

  if(!function_1d3253884542b0e6(besttarget)) {
    return false;
  }

  return true;
}

function function_f391d89f9a5bcd21(potentialtarget) {
  if(within_fov(self.origin, self.angles, potentialtarget.origin, cos(self getleftarc()))) {
    return true;
  }

  return false;
}

function sentry_canseetarget(potentialtarget) {
  contentsoverride = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0, 1, 1);
  targetpoints = ["j_head", "j_mainroot", "tag_origin"];
  canseetarget = 0;

  if(!isalive(potentialtarget)) {
    return 0;
  }

  if(!isDefined(potentialtarget.model)) {
    return 0;
  }

  if(is_equal(potentialtarget.classname, "misc_turret")) {
    targetpoints = ["tag_aim_animated"];
  } else if(is_equal(potentialtarget.classname, "script_vehicle")) {
    targetpoints = ["tag_body", "tag_origin", "tag_trunk", "tag_hood"];
  }

  start_tag = self.trace_tag;

  foreach(point in targetpoints) {
    if(!potentialtarget tagexists(point)) {
      continue;
    }

    canseetarget = trace::ray_trace_passed(self gettagorigin(start_tag), potentialtarget gettagorigin(point), self, contentsoverride);

    if(istrue(canseetarget)) {
      canseetarget = 1;
      break;
    }

    if(is_equal(potentialtarget.classname, "misc_turret") || is_equal(potentialtarget.classname, "script_vehicle")) {
      trace = trace::ray_trace(self gettagorigin(start_tag), potentialtarget gettagorigin(point), self, contentsoverride);

      if(is_equal(trace["entity"], potentialtarget)) {
        canseetarget = 1;
      }
    }
  }

  return canseetarget;
}

function function_30b63fb2cbf3dec7() {
  self.state = "lost_LOS";
  start_tag = self.trace_tag;
  var_d07d9c70eba81715 = self gettagorigin(start_tag);
  var_ee55ee7101d6bb0f = self gettagangles(start_tag);
  var_d6c3f457f5b2e471 = anglesToForward(var_ee55ee7101d6bb0f);

  if(!isDefined(self.targetent)) {
    loc = var_d07d9c70eba81715 + var_d6c3f457f5b2e471 * 300;
    self.targetent = spawn("script_model", loc);
    self.targetent setModel("tag_origin");
  }

  loc = var_d07d9c70eba81715 + var_d6c3f457f5b2e471 * 3000;
  self.targetent.origin = loc;
  self.targetent dontinterpolate();
  self.curtarget = self.targetent;
  self settargetentity(self.targetent);
}

function private function_bb65c9c02e749b6f() {}

function sentry_debug() {
  self endon("<dev string:x85>");
  self endon("<dev string:x8b>");
  level endon("<dev string:x97>");
  interval = 0.05;
  frames = int(interval * 20);
  config = level.sentrysettings[self.sentrytype];

  while(true) {
    health = ter_op(isDefined(self.fake_health), self.fake_health, self.health);
    print3d(self.origin, "<dev string:xa2>" + health + "<dev string:xa7>" + self.maxhealth, (1, 1, 1), 1, 0.5, frames, 1);
    print3d(self.origin + (0, 0, 10), "<dev string:xa9>" + self.heatlevel, (1, 1, 1), 1, 0.5, frames, 1);

    if(isDefined(self.state)) {
      print3d(self.origin + (0, 0, 20), "<dev string:xb0>" + self.state, (1, 1, 1), 1, 0.5, frames, 1);
    }

    if(isDefined(self.var_b85278c2cfcaa5e9)) {
      print3d(self.origin + (0, 0, 30), "<dev string:xb8>" + self.var_b85278c2cfcaa5e9, (1, 1, 1), 1, 0.5, frames, 1);
    }

    if(istrue(self.hacked)) {
      print3d(self.origin + (0, 0, 40), "<dev string:xce>", (0, 1, 0), 1, 0.5, frames, 1);
    }

    left_arc = self getleftarc();
    right_arc = self getrightarc();

    if(isDefined(left_arc) && isDefined(right_arc)) {
      thread scripts\stealth\debug::draw_arc(self.origin, -1 * left_arc, right_arc, self.angles, self.targetrange, 1, 10, (1, 0, 0));

      if(isDefined(self.var_83c1b372bdac7446)) {
        thread scripts\stealth\debug::draw_arc(self.origin, -1 * left_arc, right_arc, self.angles, self.var_83c1b372bdac7446, 1, 10, (1, 1, 0));
      }
    }

    if(isDefined(self.targetent) && isDefined(self.trace_tag)) {
      thread scripts\cp_mp\utility\debug_utility::drawline(self gettagorigin(self.trace_tag), self.targetent.origin, interval, (1, 0, 0));
    }

    wait interval;
  }
}

# /