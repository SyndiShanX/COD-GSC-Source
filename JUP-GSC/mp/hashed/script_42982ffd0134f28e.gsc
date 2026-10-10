/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_42982ffd0134f28e.gsc
*************************************************/

#using script_42982ffd0134f28e;
#using script_570cdb4e38f0225b;
#using script_7cfaa6fd841fb4dd;
#using script_9880b9dc28bc25e;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\gameobjects;
#using scripts\mp\hud_util;
#using scripts\mp\killstreaks\target_marker;
#using scripts\mp\utility\damage;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;
#namespace namespace_5a478c941b69184e;

function function_610dfcbf191b189b() {
  if(flag("defend_turret_initialized")) {
    return;
  }

  flag_set("defend_turret_initialized");

  if(!isDefined(level._effect["turret_muzflash"])) {
    level._effect["turret_muzflash"] = loadfx("vfx/core/muzflash/minigun_flash_cheap.vfx");
  }

  level._effect["defend_turret_shell_eject"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_defend_turret_shej.vfx");
  callback::add("on_zombie_ai_damaged", &on_zombie_ai_damaged);

  level thread function_7c607bba89421210();
}

function sentryturret_gettargetmarker(streakinfo, ignorecancel) {
  assertex(isPlayer(self), "<dev string:x1c>");
  return scripts\mp\killstreaks\target_marker::gettargetmarker(streakinfo, ignorecancel);
}

function sentryturret_createhintobject(hintpos, hinttype, hinticon, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov) {
  return scripts\mp\gameobjects::createhintobject(hintpos, hinttype, hinticon, hintstring, priority, duration, onobstruction, hintdist, hintfov, usedist, usefov);
}

function sentryturret_handledeathdamage(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  config = level.sentrysettings[self.turrettype];
  explosivedamage = 0;

  if(type == "MOD_EXPLOSIVE" || type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH" || type == "MOD_GRENADE_SPLASH") {
    explosivedamage = 1;
  }

  self notify("kill_turret", explosivedamage, 1);
}

function sentryturret_initsentrysettings() {
  level.sentrysettings["defend_turret"] = spawnStruct();
  level.sentrysettings["defend_turret"].health = 999999;
  level.sentrysettings["defend_turret"].maxhealth = 650;
  level.sentrysettings["defend_turret"].burstmin = 35;
  level.sentrysettings["defend_turret"].burstmax = 70;
  level.sentrysettings["defend_turret"].pausemin = 0.15;
  level.sentrysettings["defend_turret"].pausemax = 0.25;
  level.sentrysettings["defend_turret"].lockstrength = 6;
  level.sentrysettings["defend_turret"].sentrymodeon = "sentry";
  level.sentrysettings["defend_turret"].sentrymodeoff = "sentry_offline";
  level.sentrysettings["defend_turret"].timeout = 120;
  level.sentrysettings["defend_turret"].spinuptime = 1.65;
  level.sentrysettings["defend_turret"].overheattime = 8;
  level.sentrysettings["defend_turret"].cooldowntime = 0.3;
  level.sentrysettings["defend_turret"].fxtime = 0.3;
  level.sentrysettings["defend_turret"].streakname = "sentry_gun";
  level.sentrysettings["defend_turret"].weaponinfo = "jup_ob_defend_turret";
  level.sentrysettings["defend_turret"].playerweaponinfo = "jup_ob_defend_turret";
  level.sentrysettings["defend_turret"].modelbaseground = "jup_wm_zm_defend_turret";
  level.sentrysettings["defend_turret"].modeldestroyedground = "jup_wm_zm_defend_turret";
  level.sentrysettings["defend_turret"].placementhintstring = &"KILLSTREAKS_HINTS/SENTRY_GUN_PLACE";
  level.sentrysettings["defend_turret"].ownerusehintstring = &"KILLSTREAKS_HINTS/SENTRY_USE";
  level.sentrysettings["defend_turret"].otherusehintstring = &"KILLSTREAKS_HINTS/SENTRY_OTHER_USE";
  level.sentrysettings["defend_turret"].dismantlehintstring = &"KILLSTREAKS_HINTS/SENTRY_DISMANTLE";
  level.sentrysettings["defend_turret"].headicon = 1;
  level.sentrysettings["defend_turret"].teamsplash = "used_sentry_gun";
  level.sentrysettings["defend_turret"].destroyedsplash = "callout_destroyed_sentry_gun";
  level.sentrysettings["defend_turret"].shouldsplash = 1;
  level.sentrysettings["defend_turret"].votimeout = "sentry_gun_teamleader_crash";
  level.sentrysettings["defend_turret"].vodestroyed = "sentry_gun_teamleader_crash";
  level.sentrysettings["defend_turret"].scorepopup = "destroyed_sentry";
  level.sentrysettings["defend_turret"].lightfxtag = "tag_fx";
  level.sentrysettings["defend_turret"].iskillstreak = 0;
  level.sentrysettings["defend_turret"].headiconoffset = (0, 0, 75);
  level.sentrysettings["defend_turret"].var_39124773ba0a7b75 = 30;
  level.sentrysettings["defend_turret_green"] = level.sentrysettings["defend_turret"];
  level.sentrysettings["defend_turret_green"].weaponinfo = "jup_ob_defend_turret_green";
  level.sentrysettings["defend_turret_green"].playerweaponinfo = "jup_ob_defend_turret_green";
  level.sentrysettings["defend_turret_yellow"] = level.sentrysettings["defend_turret"];
  level.sentrysettings["defend_turret_yellow"].weaponinfo = "jup_ob_defend_turret_yellow";
  level.sentrysettings["defend_turret_yellow"].playerweaponinfo = "jup_ob_defend_turret_yellow";
  level.sentrysettings["defend_turret_orange"] = level.sentrysettings["defend_turret"];
  level.sentrysettings["defend_turret_orange"].weaponinfo = "jup_ob_defend_turret_orange";
  level.sentrysettings["defend_turret_orange"].playerweaponinfo = "jup_ob_defend_turret_orange";
  level.sentrysettings["defend_turret_red"] = level.sentrysettings["defend_turret"];
  level.sentrysettings["defend_turret_red"].weaponinfo = "jup_ob_defend_turret_red";
  level.sentrysettings["defend_turret_red"].playerweaponinfo = "jup_ob_defend_turret_red";
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

function sentryturret_create(turretstruct) {
  sentryturret_initsentrysettings();
  config = level.sentrysettings[turretstruct.turrettype];
  turret = spawnturret("misc_turret", turretstruct.origin, level.sentrysettings[turretstruct.turrettype].weaponinfo);
  turret.owner = turretstruct.owner;
  turret.team = turretstruct.team;
  turret.angles = turretstruct.angles;
  turret.health = 9999;
  turret.maxhealth = config.maxhealth;
  turret.turrettype = turretstruct.turrettype;
  turret.shouldsplash = 1;
  turret.ammocount = config.ammo;
  turret.timeout = config.timeout;
  turret setmode(config.sentrymodeon);
  turret.tag_to_shoot_from = "tag_flash";
  turret.spinuptime = level.sentrysettings[turretstruct.turrettype].spinuptime;
  turret turretsetbarrelspinenabled(1);
  turret.var_12c37b454baa515d = turretstruct.var_12c37b454baa515d;
  turret.var_12e39261f1ccd13c = turretstruct.var_12e39261f1ccd13c;
  turret.invulnerable = turretstruct.invulnerable;

  if(issharedfuncdefined("sentry_gun", "attachXRays")) {
    turret = [[getsharedfunc("sentry_gun", "attachXRays")]](turret);
  }

  if(!isDefined(turret.timeout)) {
    turret.timeout = 99999;
  }

  turret setturretowner(turret.owner);
  turret setturretteam(turret.team);
  turret makeunusable();
  turret setnodeploy(1);
  turret setautorotationdelay(turret.spinuptime);
  turret.momentum = 0;
  turret.heatlevel = 0;
  turret.overheated = 0;
  turret sentryturret_setturretmodel("placed");
  turret laseron();
  turret setCanDamage(1);
  turret setturretmodechangewait(0);
  turret turretfireenable();

  switch (turretstruct.turrettype) {
    case #"hash_ba0744180cd3ed24":
    default:
      turret maketurretinoperable();
      turret setleftarc(200);
      turret setrightarc(200);
      turret setbottomarc(120);
      turret settoparc(140);
      turret setconvergencetime(0.2, "pitch");
      turret setconvergencetime(0.2, "yaw");
      turret setconvergenceheightpercent(0.65);
      hasturret = 0;
      fire_range = 2560;
      var_c8e4f9c808bc6727 = 45;
      fire_delay = 0.1;
      var_5e757e98f6d8d75d = 12;
      var_5e528898f6b2a5a3 = 16;
      var_22724a721b4b206e = 2;
      var_224f3c721b24b9ec = 4;
      var_fe4d3e87a3e97eb2 = 1;
      var_fe2a4887a3c34cf8 = 5;
      var_f44082c731d13340 = 0.1;
      turret.hasturret = hasturret;
      turret.fire_range = fire_range;
      turret.var_b115239d8d69db01 = fire_range;
      turret.var_c8e4f9c808bc6727 = var_c8e4f9c808bc6727;
      turret.var_cc99a14e60508d29 = cos(var_c8e4f9c808bc6727);
      turret.fire_delay = fire_delay;
      turret.var_a9b3f28f2a95607c = var_5e757e98f6d8d75d;
      turret.var_a990e08f2a6ef12e = var_5e528898f6b2a5a3;
      turret.var_22724a721b4b206e = var_22724a721b4b206e;
      turret.var_224f3c721b24b9ec = var_224f3c721b24b9ec;
      turret.var_fe4d3e87a3e97eb2 = var_fe4d3e87a3e97eb2;
      turret.var_fe2a4887a3c34cf8 = var_fe2a4887a3c34cf8;
      turret.var_f44082c731d13340 = var_f44082c731d13340;
      forward_vec = vectorNormalize(anglesToForward(turret.angles));
      turret.var_bf1f9363cf638d46 = turret.origin + forward_vec * 1000;
      turret setdefaultdroppitch(40);
      break;
  }

  turret.colmodel = spawn("script_model", turret.origin);
  turret.colmodel.team = turret.team;
  turret.colmodel.owner = turret.owner;
  turret.colmodel setModel(config.modelbaseground);
  turret.colmodel dontinterpolate();
  turret.colmodel hide();

  if(!istrue(turretstruct.var_6d9f48354b1ae939)) {
    turret function_41073dcb3e50d4d5();
  }

  turret thread sentryturret_monitordamage(turret);
  turret thread sentryturret_watchdeath(turret);
  turret thread function_9e099b94cb9fc336();
  turret thread sentry_beepsounds();
  turret.turreton = 1;
  turret setmode(config.sentrymodeon);

  if(turret getscriptablehaspart("model_damage")) {
    turret setscriptablepartstate("model_damage", "default", 0);
  }

  return turret;
}

function function_2b164bf1240548cd(turret, owner) {
  if(isDefined(turret.damagetaken) && isDefined(turret.maxhealth)) {
    if(turret.damagetaken >= turret.maxhealth) {
      return;
    }
  }

  if(isDefined(owner)) {
    turret.owner = owner;
    turret.team = owner.team;
  }

  if(istrue(turret.active)) {
    turret setscriptablepartstate("power_state", "reset");
    turret setscriptablepartstate("power_state", "active");
    return;
  }

  turret.active = 1;
  turret setscriptablepartstate("power_state", "active");
  turret setscriptablepartstate("lights", "daytime");
  turret thread function_24355aab94ecce49();
  turret.var_fb808fde38193644 = 0;
  turret.var_929dcf82563b5c7b = "activated";
  turret laseron();
  turret setmode("manual_target");
  turret thread function_a03f94132845002a();
}

function sentryturret_setinactive(turret) {
  if(!isDefined(turret)) {
    return;
  }

  turret.active = 0;
  turret laseroff();
  turret setscriptablepartstate("fire_state", "inactive");
  turret setscriptablepartstate("lights", "off");
  turret.rumble_type = "damage_light";
  turret notify("turret_inactive");
  turret setscriptablepartstate("power_state", "inactive");
  turret setscriptablepartstate("turn_state", "inactive");

  if(isDefined(turret.groundtargetent)) {
    forward_vec = vectorNormalize(anglesToForward(turret.angles));
    spawn_pos = turret.origin + forward_vec * 64;
    turret.groundtargetent moveTo(spawn_pos, 1.5, 0.5, 0.5);
    wait 1.5;
    turret.groundtargetent delete();
  }

  turret setmode(level.sentrysettings[turret.turrettype].sentrymodeoff);
}

function sentryturret_watchdeath(turret) {
  turret endon("carried");
  turret waittill("kill_turret", skipshutdown, wasdestroyed);

  if(isDefined(self)) {
    sentryturret_setinactive(turret);
  }

  if(turret getscriptableparthasstate("model_damage", "damaged_destroyed")) {
    turret setscriptablepartstate("model_damage", "damaged_destroyed");
  }

  turret setturretowner(undefined);

  if(isDefined(turret.attractor)) {
    namespace_5381a59d140f4df8::remove_attractor(turret.attractor);
  }

  if(!istrue(skipshutdown)) {
    turret setscriptablepartstate("shutdown", "on");
    turret playSound("sentry_explode_sparks");
    turret playSound("mp_equip_destroyed");

    if(self getscriptablehaspart("explode")) {
      turret setscriptablepartstate("explode", "regular");
    }

    if(level.sentrysettings[self.turrettype].var_39124773ba0a7b75 <= 0) {
      return;
    }

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(level.sentrysettings[self.turrettype].var_39124773ba0a7b75);
  }

  if(self getscriptablehaspart("explode")) {
    turret setscriptablepartstate("explode", "violent");
  }

  function_c51b29117eac2257(turret);
}

function function_c51b29117eac2257(turret) {
  if(self getscriptablehaspart("explode")) {
    turret setscriptablepartstate("explode", "violent");
  }

  turret playSound("mp_equip_box_destroyed");

  if(isDefined(turret.killcament)) {
    turret.killcament delete();
  }

  if(isDefined(turret.useownerobj)) {
    turret.useownerobj delete();
  }

  if(isDefined(turret.useotherobj)) {
    turret.useotherobj delete();
  }

  if(isDefined(turret.colmodel)) {
    turret.colmodel delete();
  }

  if(isDefined(turret.minimapid)) {
    if(issharedfuncdefined("game", "returnObjectiveID")) {
      [[getsharedfunc("game", "returnObjectiveID")]](turret.minimapid);
    }

    turret.minimapid = undefined;
  }

  wait 0.5;
  turret delete();
}

function sentryturret_delayscriptabledelete() {
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(10);
  self delete();
}

function sentryturret_setturretmodel(type) {
  turretmodel = undefined;

  if(type == "placed") {
    turretmodel = level.sentrysettings[self.turrettype].modelbaseground;
  } else {
    turretmodel = level.sentrysettings[self.turrettype].modeldestroyedground;
  }

  modeltype = getdvarint(@ "hash_e19e5d308effeda3", 1);

  if(!modeltype) {
    turretmodel = "<dev string:x53>";
  }

  assertex(isDefined(turretmodel), "<dev string:x71>");
  self setModel(turretmodel);
}

function function_41073dcb3e50d4d5(var_6a0bd931328ce4a) {
  self.attractor = namespace_5381a59d140f4df8::add_attractor(self, 1, 2000, 1, undefined, var_6a0bd931328ce4a);
  namespace_5381a59d140f4df8::function_c7ea973c95733604(self.attractor, self.origin + (0, 0, 40), (32, 32, 40), self.angles);
}

function private function_a03f94132845002a() {
  self endon("death");
  self endon("turret_inactive");
  thread function_be442ba784aa304a();
}

function private function_be442ba784aa304a() {
  self endon("death");
  self endon("turret_inactive");
  var_bae3a983e2b8524b = self.var_bf1f9363cf638d46;
  forward_vec = vectorNormalize(anglesToForward(self.angles));
  spawn_pos = self.origin + forward_vec * 64;
  self.groundtargetent = spawn("script_model", spawn_pos);
  self.groundtargetent setModel("tag_origin");
  self.groundtargetent dontinterpolate();
  self settargetentity(self.groundtargetent);
  self.groundtargetent moveTo(var_bae3a983e2b8524b, 2, 1, 0.5);
  wait 2;
  thread function_d5d3527ec457aab();

  while(true) {
    wait 0.5;

    if(istrue(self.turreton)) {
      function_ac0fab225e39ae0f();

      if(function_f7945d18f7040dc2(self)) {
        self notify("turret_target_acquired");
        self.var_929dcf82563b5c7b = "has_target";
        utility::function_3ab9164ef76940fd("turn_state", "inactive");
        self laseron();
        self turretsetbarrelspinenabled(1);
        thread function_f2ad42531b9ae44c(self.auto_target);
        continue;
      }

      if(!is_equal(self.var_929dcf82563b5c7b, "no_target")) {
        self notify("turret_no_target");
        self.var_929dcf82563b5c7b = "no_target";
        self.rumble_type = "none";
        wait 0.25;
        thread function_b4eba4dcc6448af9(self.var_bf1f9363cf638d46);
        function_d61aa0275e7b9dc1();
        wait 0.25;
      }
    }
  }
}

function function_d5d3527ec457aab(current_target) {
  self endon("turret_inactive");
  current_target = self.auto_target;

  while(true) {
    if(!isDefined(self)) {
      return;
    }

    if(!isalive(self.auto_target) || is_equal(self.var_929dcf82563b5c7b, "no_target")) {
      if(isDefined(self.groundtargetent) && istrue(self.groundtargetent.linked)) {
        self.groundtargetent.linked_target = undefined;
        self.groundtargetent.linked = 0;
        self.groundtargetent unlink();
      }

      wait 0.1;
      continue;
    }

    if(!is_equal(current_target, self.auto_target)) {
      var_7d6e5eb0be062929 = function_887d234688bc2f35(self.auto_target);
      self.groundtargetent moveTo(var_7d6e5eb0be062929, 0.2, 0.05, 0.05);
      current_target = self.auto_target;
      wait 0.2;
      continue;
    }

    if(isDefined(self.auto_target.model) && hastag(self.auto_target.model, "tag_origin")) {
      if(!is_equal(self.groundtargetent.linked_target, self.auto_target)) {
        var_7d6e5eb0be062929 = function_887d234688bc2f35(self.auto_target);
        self.groundtargetent.origin = var_7d6e5eb0be062929;
        function_2dd29ea786fd3b5(self.auto_target);
      }

      wait 0.1;
      continue;
    }

    targetpositionoffset = self.auto_target.origin + self.target_offset;
    self.groundtargetent moveTo(targetpositionoffset, 0.025, 0, 0);
    wait 0.025;
  }
}

function function_5819ff607358241c(current_target) {
  if(!isDefined(current_target)) {
    return "tag_origin";
  }

  if(is_equal(current_target.subclass, "zombie_abom_mega_hvt") || is_equal(current_target.subclass, "zombie_abom_mega")) {
    head_state = namespace_560a8871429928df::function_2945ff43fceb0fc8(current_target, 0);
    head_target = 0;

    if(is_equal(head_state, 0)) {
      head_state = namespace_560a8871429928df::function_2945ff43fceb0fc8(current_target, 2);
      head_target = 2;

      if(is_equal(head_state, 0)) {
        head_state = namespace_560a8871429928df::function_2945ff43fceb0fc8(current_target, 1);
        head_target = 1;
      }
    }

    switch (head_target) {
      case 0:
        return "j_jar_ri";
      case 2:
        return "j_jaw_le";
      default:
        return "j_jaw";
    }
  }

  if(hastag(current_target.model, "j_spinelower")) {
    return "j_spinelower";
  }

  return "tag_origin";
}

function function_c997b9cbc0a3706f(current_target) {
  if(is_equal(current_target.subclass, "zombie_abom_mega_hvt") || is_equal(current_target.subclass, "zombie_abom_mega")) {
    return true;
  }

  return false;
}

function function_64535881ddfd91b0(current_target) {
  self endon("death");
  self endon("turret_inactive");

  if(!isDefined(current_target)) {
    return;
  }

  current_target endon("death");

  while(is_equal(current_target, self.auto_target)) {
    if(is_equal(current_target.subclass, "zombie_abom_mega_hvt") || is_equal(current_target.subclass, "zombie_abom_mega")) {
      head_state = namespace_560a8871429928df::function_2945ff43fceb0fc8(current_target, 0);
      head_target = 0;

      if(is_equal(head_state, 0)) {
        head_state = namespace_560a8871429928df::function_2945ff43fceb0fc8(current_target, 2);
        head_target = 2;

        if(is_equal(head_state, 0)) {
          head_state = namespace_560a8871429928df::function_2945ff43fceb0fc8(current_target, 1);
          head_target = 1;
        }
      }

      switch (head_target) {
        case 0:
          target_tag = "j_jaw_le";
          break;
        case 2:
          target_tag = "j_jaw_ri";
          break;
        default:
          target_tag = "j_jaw";
          break;
      }
    }

    if(!is_equal(self.groundtargetent.linkto_tag, target_tag)) {
      function_2dd29ea786fd3b5(self.auto_target, target_tag);
    }

    wait 1;
  }
}

function function_887d234688bc2f35(current_target) {
  self endon("death");
  self endon("turret_inactive");

  if(!isDefined(current_target)) {
    return (0, 0, 0);
  }

  current_target endon("death");

  if(isent(current_target) && isDefined(current_target.model) && hastag(current_target.model, "j_spinelower")) {
    target_origin = current_target gettagorigin("j_spinelower");
  }

  if(is_equal(current_target.subclass, "zombie_hellhound")) {
    target_origin = current_target gettagorigin("j_spine4");
  }

  if(is_equal(current_target.subclass, "zombie_abom_mega_hvt") || is_equal(current_target.subclass, "zombie_abom_mega")) {
    head_state = namespace_560a8871429928df::function_2945ff43fceb0fc8(current_target, 0);
    head_target = 0;

    if(is_equal(head_state, 0)) {
      head_state = namespace_560a8871429928df::function_2945ff43fceb0fc8(current_target, 2);
      head_target = 2;

      if(is_equal(head_state, 0)) {
        head_state = namespace_560a8871429928df::function_2945ff43fceb0fc8(current_target, 1);
        head_target = 1;
      }
    }

    switch (head_target) {
      case 0:
        target_origin = current_target gettagorigin("tag_fx_jaw_ri");
        break;
      case 2:
        target_origin = current_target gettagorigin("tag_fx_jaw_le");
        break;
      default:
        target_origin = current_target gettagorigin("tag_fx_jaw_center");
        break;
    }
  }

  if(!isDefined(target_origin)) {
    target_origin = current_target.origin + (0, 0, 32);
  }

  return target_origin;
}

function function_2dd29ea786fd3b5(current_target, tag_override) {
  attach_tag = "tag_origin";

  if(!isDefined(tag_override)) {
    attach_tag = thread function_5819ff607358241c(current_target);

    if(function_c997b9cbc0a3706f(current_target)) {
      thread function_64535881ddfd91b0(current_target);
    }
  } else {
    attach_tag = tag_override;
  }

  if(!hastag(current_target.model, attach_tag)) {
    attach_tag = "tag_origin";
  }

  self.groundtargetent.linked = 1;
  self.groundtargetent.linked_target = self.auto_target;
  self.groundtargetent.linkto_tag = attach_tag;
  self.groundtargetent unlink();
  tag_origin = current_target gettagorigin(attach_tag);

  if(isDefined(tag_origin)) {
    self.groundtargetent.origin = tag_origin;
  }

  self.groundtargetent linkTo(self.auto_target, attach_tag);
}

function private function_f2ad42531b9ae44c(current_target) {
  self endon("stop_turret_burst");
  self endon("turret_inactive");
  var_3dcdf4612dca3c06 = randomintrange(self.var_a9b3f28f2a95607c, self.var_a990e08f2a6ef12e);
  self setscriptablepartstate("fire_state", "firing");
  self.rumble_type = "damage_light";

  for(i = 0; i < var_3dcdf4612dca3c06; i++) {
    if(!isDefined(current_target)) {
      break;
    }

    turretposition = self.origin;
    targetposition = current_target getcentroid();

    if(!isvector(targetposition) || !isvector(targetposition)) {
      break;
    }

    targetdirection = targetposition - turretposition;
    targetdistance = length(targetdirection);
    targetdirection /= targetdistance;
    targetleft = vectorcross((0, 0, 1), targetdirection);
    targetup = vectorcross(targetdirection, targetleft);
    var_d8b5bab86498e0a7 = randomfloatrange(0, 360);
    var_3e36f65cdc207066 = axistoangles(targetdirection, targetleft * -1, targetup);
    randomdirection = vectorNormalize((0, randomfloatrange(-1, 1), randomfloatrange(-1, 1)));
    targetoffset = rotatevector(randomdirection, var_3e36f65cdc207066);
    mindistance = 1500;
    maxdistance = 4000;
    var_9532154bf493ac67 = 10;
    var_e7417005e2706e79 = 50;
    var_ee4216abe717df2d = 20;
    var_6e00df1ebf70cc33 = 60;
    assert(maxdistance);
    distancenormalized = clamp((targetdistance - mindistance) / maxdistance, 0, 1);
    minspread = math::lerp(var_9532154bf493ac67, var_e7417005e2706e79, distancenormalized);
    maxspread = math::lerp(var_ee4216abe717df2d, var_6e00df1ebf70cc33, distancenormalized);
    var_c9b00e5616b7a312 = randomfloatrange(minspread, maxspread);
    targetpositionoffset = targetposition + targetoffset * var_c9b00e5616b7a312;

    var_d16fa005c2c5291d = getdvarint(@ "hash_a5451df7c00d0400", 0);

    if(var_d16fa005c2c5291d) {
      duration = 800;
      line(targetposition, targetposition + targetleft * 30, (1, 0, 0), 1, 0, duration);
      line(targetposition, targetposition + targetdirection * 30, (0, 1, 0), 1, 0, duration);
      line(targetposition, targetposition + targetup * 30, (0, 0, 1), 1, 0, duration);
      line(targetposition, targetpositionoffset, (1, 1, 0), 1, 0, duration);
      sphere(targetposition, minspread, (0.17, 1, 1), 0, duration);
      sphere(targetposition, maxspread, (0, 0, 1), 0, duration);
    }

    if(function_d3a3843b10d6f3a8(self, current_target)) {
      self shootturret("tag_flash");
      playFXOnTag(getfx("defend_turret_shell_eject"), self, "tag_mag_fx");
    }

    earthquake(0.1, self.fire_delay, self.origin, 320);
    wait self.fire_delay;
  }

  self notify("turret_burst_complete");
  self setscriptablepartstate("fire_state", "inactive");

  if(istrue(level.var_8135774bdf2cf9f4) && isPlayer(current_target)) {
    damage = ter_op(isDefined(level.var_856931603ae695a6), level.var_856931603ae695a6, 0);
    current_target dodamage(damage, self.origin, self.owner, self);
  }

  wait randomfloatrange(self.var_22724a721b4b206e, self.var_224f3c721b24b9ec);
}

function function_b4eba4dcc6448af9(targetposition) {
  self endon("death");
  self endon("turret_inactive");
  self endon("turret_target_acquired");
  self endon("turret_no_target");
  self.groundtargetent moveTo(targetposition, 2, 0.05, 0.05);
  self.groundtargetent waittill("movedone");
  thread function_6a9ab54415bc867a();
}

function function_6a9ab54415bc867a() {
  self endon("death");
  self endon("turret_inactive");
  self endon("turret_target_acquired");
  self endon("turret_no_target");

  while(true) {
    if(!isDefined(self)) {
      return;
    }

    self setscriptablepartstate("turn_state", "turning");
    pos_offset = (randomfloatrange(-400, 400), 0, randomfloatrange(-400, 400));
    var_cd7a27e625a986e2 = self.var_bf1f9363cf638d46 + pos_offset;
    self.groundtargetent moveTo(var_cd7a27e625a986e2, 1, 0.1, 0.1);
    self.groundtargetent waittill("movedone");
    self setscriptablepartstate("turn_state", "inactive");
    wait randomfloatrange(0.8, 3);
  }
}

function function_b5424d81eab2b513() {
  self endon("turret_burst_complete");
  self endon("stop_shooting");
  self endon("stop_turret_burst");
  self endon("turret_inactive");

  if(isalive(self.auto_target)) {
    targetpositionoffset = self.auto_target.origin + (0, 0, 32);
    self.groundtargetent moveTo(targetpositionoffset, 0.05, 0.05, 0.05);
  }
}

function private function_f7945d18f7040dc2(turret, current_target) {
  turret endon("turret_inactive");

  if(!isalive(turret.auto_target)) {
    return false;
  }

  return true;
}

function function_d61aa0275e7b9dc1() {
  self notify("stop_turret_burst");
  self notify("stop_shooting");
  self notify("turret_burst_complete");
  self setscriptablepartstate("fire_state", "inactive");
  self.rumble_type = "none";
  sentry_spindown();
}

function function_bbffdcb974564968() {
  a_ai = getaiarrayinradius(self.origin, 2600);
  a_vehicles = getentarrayinradius("script_vehicle", "classname", self.origin, 5000);
  a_vehicles = sortbydistance(a_vehicles, self.origin);
  a_ai = sortbydistance(a_ai, self.origin);
  var_8cb4546853fdfcfd = function_ed5702508e97d57d(a_ai);
  var_1ed63603a2bc9586 = function_ed5702508e97d57d(a_vehicles);
  a_targets = array_combine(var_1ed63603a2bc9586, var_8cb4546853fdfcfd);

  if(istrue(level.var_8135774bdf2cf9f4)) {
    a_players = getplayersinradius(self.origin, 2600);
    a_players = sortbydistance(a_players, self.origin);
    var_d2563f6ca686413 = function_ed5702508e97d57d(a_players);
    a_targets = array_combine(var_d2563f6ca686413, a_targets);
  }

  return a_targets;
}

function function_ed5702508e97d57d(a_potential_targets) {
  a_targets = [];
  var_b9d5783a4f34efbc = [];
  var_b9d5783a4f34efbc = array_add(var_b9d5783a4f34efbc, self);
  contentsoverride = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0, 1, 1);
  var_a2baaa82705aff05 = [];
  var_7177a5499623d02d = [];

  for(i = 0; i < 60; i++) {
    var_7177a5499623d02d = array_add(var_7177a5499623d02d, a_potential_targets[i]);
  }

  foreach(potential_target in var_7177a5499623d02d) {
    var_f23a623da55a1ae6 = !is_equal(potential_target.team, "team_hundred_ninety") && !is_equal(potential_target.callingteam, "team_hundred_ninety") && !is_equal(potential_target.team, "team_two_hundred");

    if(potential_target.team == self.team || potential_target.team == "neutral" && !is_equal(potential_target.callingteam, "team_hundred_ninety") || !istrue(level.var_8135774bdf2cf9f4) && var_f23a623da55a1ae6 || array_contains(a_targets, potential_target) || isent(potential_target) && potential_target ent_flag("deadwire_stunned")) {
      continue;
    }

    var_b9d5783a4f34efbc = array_add(var_b9d5783a4f34efbc, potential_target);
    var_432b48cbf84457a3 = potential_target.origin + (0, 0, 24);

    if(isent(potential_target) && isDefined(potential_target.model) && hastag(potential_target.model, "j_spinelower")) {
      var_432b48cbf84457a3 = potential_target gettagorigin("j_spinelower");
    }

    canseetarget = scripts\engine\trace::ray_trace_passed(self.origin + (0, 0, 64), var_432b48cbf84457a3, var_b9d5783a4f34efbc, contentsoverride);

    if(canseetarget) {
      if(is_equal(potential_target.subclass, "zombie_abom_mega_hvt") || is_equal(potential_target.subclass, "zombie_abom_mega")) {
        var_a2baaa82705aff05 = array_add(var_a2baaa82705aff05, potential_target);
        continue;
      }

      a_targets = array_add(a_targets, potential_target);
    }
  }

  var_3b78132bd62a1e7d = array_combine(var_a2baaa82705aff05, a_targets);
  return var_3b78132bd62a1e7d;
}

function function_ac0fab225e39ae0f() {
  self.a_potential_targets = function_bbffdcb974564968();

  if(isDefined(self.auto_target) && isalive(self.auto_target) && array_contains(self.a_potential_targets, self.auto_target) && isDefined(self.a_potential_targets[0]) && isalive(self.a_potential_targets[0])) {
    if(distance2dsquared(self.origin, self.auto_target.origin) < distance2dsquared(self.origin, self.a_potential_targets[0].origin)) {
      return self.auto_target;
    }

    if(gettime() - self.var_fb808fde38193644 < 4000) {
      return self.auto_target;
    }
  }

  if(is_equal(self.a_potential_targets.size, 0)) {
    self.auto_target = undefined;
    return undefined;
  }

  self.auto_target = self.a_potential_targets[0];
  self.var_fb808fde38193644 = gettime();
  return self.auto_target;
}

function private function_93ff5e5ba263fc6d(attacker, targ) {
  target_direction = targ.origin - attacker.origin;
  return vectordot2(target_direction, anglesToForward(attacker.angles), 1);
}

function private function_d3a3843b10d6f3a8(turret, current_target) {
  target_dist = distance2dsquared(turret.groundtargetent.origin, current_target.origin);

  if(target_dist < 6760000) {
    return true;
  }

  return false;
}

function sentry_targetlocksound() {
  self endon("death");
  self playSound("sentry_gun_target_lock_beep");
  wait 0.19;
  self playSound("sentry_gun_target_lock_beep");
}

function sentry_spinup(var_630af5192659dd3b) {
  thread sentry_targetlocksound();
  self notify("found_target");
  self startbarrelspin();

  if(soundexists("weap_dblmg_spinup_npc")) {
    self playSound("weap_dblmg_spinup_npc");
  }

  if(isDefined(self.turrettype)) {
    while(self.momentum < level.sentrysettings[self.turrettype].spinuptime) {
      self.momentum += 0.1;
      wait 0.1;
    }
  }
}

function sentry_spindown() {
  spin_rate = self getbarrelspinrate();

  if(spin_rate > 0) {
    self stopbarrelspin();
    self turretsetbarrelspinenabled(0);

    if(soundexists("weap_dblmg_spindown_npc")) {
      self playSound("weap_dblmg_spindown_npc");
    }

    self.momentum = 0;
  }
}

function sentry_beepsounds() {
  self endon("death");
  self endon("carried");
  self endon("kill_turret");
  level endon("game_ended");

  while(true) {
    wait 3;

    if(self isfiringturret()) {
      waitframe();
      continue;
    }

    self playSound("sentry_gun_beep");
  }
}

function function_9e099b94cb9fc336() {
  self endon("death");
  level waittill("game_ended");

  if(isDefined(self)) {
    self.colmodel delete();
    self delete();
  }
}

function sentryturret_modifydamage(data) {
  if(!isDefined(level.sentrysettings["defend_turret"])) {
    return;
  }

  var_3a8030d138e837c8 = level.sentrysettings["defend_turret"];
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;
  modifieddamage = damage;

  if(!isDefined(self.damagetaken) || istrue(self.invulnerable)) {
    self.damagetaken = 0;
  }

  if(!isDefined(self.var_92bbee4bd337ac4a)) {
    self.var_92bbee4bd337ac4a = 0;
  }

  var_8ed0a351aa70ec7 = self.damagetaken + modifieddamage;

  if(var_8ed0a351aa70ec7 >= var_3a8030d138e837c8.maxhealth * 0.5 && !istrue(self.damagedstate)) {
    self.damagedstate = 1;
    self setscriptablepartstate("turret_damage", "on", 0);
  }

  if(self getscriptablehaspart("model_damage")) {
    switch (self.var_92bbee4bd337ac4a) {
      case 0:
        if(var_8ed0a351aa70ec7 >= var_3a8030d138e837c8.maxhealth * 0.25) {
          self setscriptablepartstate("model_damage", "damaged_25percent", 0);
          self.var_92bbee4bd337ac4a++;
        }

        break;
      case 1:
        if(var_8ed0a351aa70ec7 >= var_3a8030d138e837c8.maxhealth * 0.5) {
          self setscriptablepartstate("model_damage", "damaged_50percent", 0);
          self.var_92bbee4bd337ac4a++;
        }

        break;
      case 2:
        if(var_8ed0a351aa70ec7 >= var_3a8030d138e837c8.maxhealth * 0.75) {
          self setscriptablepartstate("model_damage", "damaged_75percent", 0);
          self.var_92bbee4bd337ac4a++;
        }

        break;
      default:
        break;
    }
  }

  return modifieddamage;
}

function sentryturret_monitordamage(turret) {
  if(!isDefined(level.sentrysettings["defend_turret"])) {
    return;
  }

  turret thread function_281365f70fb776c(turret.maxhealth, "hitequip", &sentryturret_handledeathdamage, &sentryturret_modifydamage, 1);
}

function function_281365f70fb776c(maxhealth, damagefeedback, ondeathfunc, var_d7b6456018542238, biskillstreak, rumble, resetdamagetaken) {
  self endon("death");
  level endon("game_ended");
  self endon("monitorDamageEnd");

  if(!isDefined(rumble)) {
    rumble = 0;
  }

  self setCanDamage(1);
  self.maxhealth = maxhealth;
  self.health = 999999;
  var_f3e89f9924fb5b0d = 0;

  if(!isDefined(self.damagetaken) || istrue(resetdamagetaken)) {
    self.damagetaken = 0;
  }

  for(running = 1; running; running = function_265ff6c0cb7b3248(damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, inflictor, damagefeedback, ondeathfunc, var_d7b6456018542238, biskillstreak)) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);

    if(gettime() < var_f3e89f9924fb5b0d + 124) {
      damage = 0;
    }

    var_f3e89f9924fb5b0d = gettime();
    objweapon = scripts\mp\utility\weapon::mapweapon(objweapon, inflictor);

    if(rumble) {
      self playRumbleOnEntity("damage_light");
    }
  }
}

function function_265ff6c0cb7b3248(damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, inflictor, damagefeedback, ondeathfunc, var_d7b6456018542238, biskillstreak) {
  if(!isDefined(self)) {
    return false;
  }

  if(isDefined(attacker) && isDefined(attacker.owner)) {
    attacker = attacker.owner;
  }

  if(isDefined(attacker) && !scripts\mp\weapons::friendlyfirecheck(self.owner, attacker)) {
    return true;
  }

  if(isPlayer(attacker) && !istrue(level.var_1838f58e6385de74)) {
    return true;
  }

  modifieddamage = damage;

  if(!istrue(self.skipignoredamage) && scripts\mp\utility\damage::non_player_should_ignore_damage(attacker, objweapon, inflictor, meansofdeath)) {
    return true;
  }

  if(isDefined(objweapon)) {
    damagedata = scripts\cp_mp\utility\damage_utility::packdamagedata(attacker, self, damage, objweapon, meansofdeath, inflictor, point, direction_vec, modelname, partname, tagname, idflags);

    if(!isDefined(var_d7b6456018542238)) {
      var_d7b6456018542238 = &sentryturret_modifydamage;
    }

    modifieddamage = self[[var_d7b6456018542238]](damagedata);
  }

  if(!isDefined(modifieddamage) || isDefined(modifieddamage) && modifieddamage <= 0) {
    return true;
  }

  self.wasdamaged = 1;
  self.damagetaken += int(modifieddamage);

  if(isDefined(idflags) && idflags & 8) {
    self.wasdamagedfrombulletpenetration = 1;
  }

  if(isDefined(idflags) && idflags & 256) {
    self.wasdamagedfrombulletricochet = 1;
  }

  if(isDefined(attacker)) {
    if(isPlayer(attacker)) {
      attacker scripts\cp_mp\damagefeedback::updatedamagefeedback(damagefeedback);
    }
  }

  if(self.damagetaken >= self.maxhealth) {
    damagedata = scripts\cp_mp\utility\damage_utility::packdamagedata(attacker, self, damage, objweapon, meansofdeath, inflictor, point, direction_vec, modelname, partname, tagname, idflags);
    self thread[[ondeathfunc]](damagedata);
    self notify("turret_inactive");
    return false;
  }

  return true;
}

function on_zombie_ai_damaged(params) {
  if(isDefined(params.einflictor) && is_equal(params.einflictor.model, "jup_wm_zm_defend_turret") && self.health - params.idamage <= 0 && percent_chance(50)) {
    self.forceannihilate = 1;
  }
}

function function_24355aab94ecce49() {
  self endon("death");
  self endon("turret_inactive");
  self.nearby_players = [];

  while(true) {
    self.nearby_players = scripts\mp\utility\player::getplayersinradius(self.origin, 320);

    foreach(player in self.nearby_players) {
      if(!istrue(player.var_2ef2ab0184ab1341)) {
        player thread function_97b57ba8ec58079a(self);
      }
    }

    wait 0.5;
  }
}

function function_97b57ba8ec58079a(turret) {
  self endon("death");
  self endon("disconnect");
  self.var_2ef2ab0184ab1341 = 1;

  while(true) {
    if(istrue(turret.active) && isarray(turret.nearby_players) && array_contains(turret.nearby_players, self)) {
      if(is_equal("none", turret.rumble_type) && istrue(self.var_f30179b027db50f4)) {
        self stoprumble("damage_light");
        self.var_f30179b027db50f4 = 0;
      } else if(!istrue(self.var_f30179b027db50f4) && !is_equal("none", turret.rumble_type)) {
        self playrumblelooponentity("damage_light");
        self.var_f30179b027db50f4 = 1;
      }

      wait 0.25;
      continue;
    }

    if(istrue(self.var_f30179b027db50f4)) {
      self stoprumble("damage_light");
    }

    self.var_2ef2ab0184ab1341 = 0;
    self.var_f30179b027db50f4 = undefined;
    return;
  }
}

function private function_7c607bba89421210() {
  function_6e7290c8ee4f558b("<dev string:xb9>");
  function_b23a59dfb4ca49a1("<dev string:xca>", "<dev string:xe1>", &function_3dd6982a488173d0);
  function_b23a59dfb4ca49a1("<dev string:xfe>", "<dev string:x111>", &function_bcce652f671ae7ff);
  function_b23a59dfb4ca49a1("<dev string:x12f>", "<dev string:x144>", &function_d8c6bc3638d321a8);
  function_b23a59dfb4ca49a1("<dev string:x164>", "<dev string:x176>", &function_fab5b8af52414726);
  function_b23a59dfb4ca49a1("<dev string:x195>", "<dev string:x1b3>", &function_3b5919d97859ec3c);
  function_fe953f000498048f();
}

function function_3dd6982a488173d0(a_params) {
  if(!isDefined(level.turrets)) {
    level.turrets = [];
  }

  foreach(player in level.players) {
    turretspawn = spawnStruct();
    turretspawn.turrettype = "<dev string:x1d1>";
    turretspawn.origin = player.origin + (200, 0, 0);
    turretspawn.angles = player.angles;
    turretspawn.team = player.team;
    turretspawn.owner = player;
    turret = namespace_8ef157d888576350::sentryturret_create(turretspawn);
    level.turrets = array_add(level.turrets, turret);
  }
}

function function_fab5b8af52414726(a_params) {
  foreach(turret in level.turrets) {
    if(isDefined(turret)) {
      turret notify("<dev string:x1e2>", 0, 1);
    }
  }
}

function function_bcce652f671ae7ff(a_params) {
  foreach(turret in level.turrets) {
    if(isDefined(turret)) {
      namespace_8ef157d888576350::function_2b164bf1240548cd(turret);
    }
  }
}

function function_d8c6bc3638d321a8(a_params) {
  foreach(turret in level.turrets) {
    if(isDefined(turret)) {
      namespace_8ef157d888576350::sentryturret_setinactive(turret);
    }
  }
}

function function_3b5919d97859ec3c(a_params) {
  foreach(player in level.players) {
    turretspawn = spawnStruct();
    turretspawn.origin = player.origin + (200, 0, 0);
    turretspawn.angles = player.angles;
    turret = namespace_64135de19550f047::function_586d4d82f07e0d09(turretspawn);
  }
}

function function_b3818ef99e063667(str_name) {
  foreach(player in level.players) {
    if(player.name == str_name) {
      return player;
    }
  }
}

# /