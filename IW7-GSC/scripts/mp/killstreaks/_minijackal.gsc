/**************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_minijackal.gsc
**************************************************/

init() {
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("minijackal", ::func_12889, undefined, undefined, undefined, ::func_13C16, undefined, ::invalid_use_minijackal);
  level._effect["miniJackal_eyeglow"] = loadfx("vfx\iw7\_requests\mp\vfx_venom_glint");
  level._effect["miniJackal_explosion"] = loadfx("vfx\iw7\core\mp\killstreaks\vfx_apex_dest_exp.vfx");
  level._effect["miniJackal_hover_thrusters"] = loadfx("vfx\iw7\core\mp\killstreaks\vfx_apex_thrusters.vfx");
  level._effect["miniJackal_antenna_enemy"] = loadfx("vfx\iw7\core\mp\killstreaks\vfx_apex_light_ping_en.vfx");
  level._effect["miniJackal_antenna_friendly"] = loadfx("vfx\iw7\core\mp\killstreaks\vfx_apex_light_ping_fr.vfx");
  level._effect["miniJackal_boost_thrusters"] = loadfx("vfx\iw7\core\mp\killstreaks\vfx_apex_thrusters_boost.vfx");
  level._effect["miniJackal_hover_thrusters_light"] = loadfx("vfx\iw7\core\mp\killstreaks\vfx_apex_thrusters_light.vfx");
  level._effect["miniJackal_boost_thrusters_light"] = loadfx("vfx\iw7\core\mp\killstreaks\vfx_apex_thrusters_boost_light.vfx");
  level.var_B7AD = [];
  var_0 = ["passive_increased_armor", "passive_decreased_duration", "passive_auto_missiles", "passive_long_reload", "passive_twin_dragons", "passive_armor_duration"];
  scripts\mp\killstreak_loot::func_DF07("minijackal", var_0);
  level.minijackalsincoming = [];
}

func_13C16(var_0) {
  var_1 = 0;
  var_2 = 0;
  foreach(var_4 in level.minijackalsincoming) {
    if(level.teambased) {
      if(self.team == var_4.team) {
        var_1++;
      }

      continue;
    }

    var_2++;
  }

  if(var_1 >= 1) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_MINIJACKAL_MAX");
    return 0;
  }

  if(var_2 >= 2) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_MINIJACKAL_MAX");
    return 0;
  }

  if(isDefined(level.var_B7AD)) {
    var_6 = 0;
    var_7 = 0;
    foreach(var_9 in level.var_B7AD) {
      if(level.teambased) {
        if(self.team == var_9.triggerportableradarping.team) {
          var_6++;
        }

        continue;
      }

      var_7++;
    }

    if(var_6 + var_1 >= 1) {
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS_MINIJACKAL_MAX");
      return 0;
    }

    if(var_7 + var_2 >= 2) {
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS_MINIJACKAL_MAX");
      return 0;
    }
  }

  self setclientomnvar("ui_remote_control_sequence", 1);
  incrementminijackalsincoming(self);
}

invalid_use_minijackal(var_0) {
  decrementminijackalsincoming(self);
}

incrementminijackalsincoming(var_0) {
  var_1 = "ent_" + var_0 getentitynumber();
  level.minijackalsincoming[var_1] = var_0;
  var_0 thread watchforinterrupt(var_1);
}

watchforinterrupt(var_0) {
  self endon("received_playremote_result");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_3("death", "disconnect");
  decrementminijackalsincoming(var_0);
}

decrementminijackalsincoming(var_0) {
  var_1 = undefined;
  if(isplayer(var_0)) {
    var_1 = "ent_" + var_0 getentitynumber();
  } else {
    var_1 = var_0;
  }

  level.minijackalsincoming[var_1] = undefined;
}

func_12889(var_0) {
  var_1 = scripts\mp\killstreaks\_killstreaks::func_D507(var_0);
  self notify("received_playremote_result");
  if(!var_1) {
    decrementminijackalsincoming(self);
    return 0;
  }

  var_2 = func_6C9B(80, 35, 20);
  if(!isDefined(var_2)) {
    decrementminijackalsincoming(self);
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_NOT_ENOUGH_SPACE");
    thread scripts\mp\killstreaks\_killstreaks::func_11086();
    return 0;
  }

  scripts\engine\utility::allow_usability(0);
  scripts\engine\utility::allow_weapon_switch(0);
  var_3 = "veh_mil_air_ca_oblivion_drone_mp";
  var_4 = "veh_minijackal_mp";
  var_5 = "used_minijackal";
  var_6 = 60;
  var_7 = "minijackal_strike_mp";
  var_8 = 1;
  var_9 = scripts\mp\killstreak_loot::getrarityforlootitem(var_0.variantid);
  if(var_9 != "") {
    var_3 = var_3 + "_" + var_9;
    var_5 = var_5 + "_" + var_9;
  }

  if(scripts\mp\killstreaks\_utility::func_A69F(var_0, "passive_armor_duration")) {
    var_6 = var_6 - 5;
  }

  if(scripts\mp\killstreaks\_utility::func_A69F(var_0, "passive_twin_dragons")) {
    var_7 = "minijackal_assault_mp";
    var_4 = "veh_minijackal_beam_mp";
    var_8 = 2;
  }

  var_0A = spawnvehicle(var_3, "minijackal", var_4, var_2, self.angles, self);
  level.var_B7AD[level.var_B7AD.size] = var_0A;
  decrementminijackalsincoming(self);
  var_0A give_player_tickets(1);
  var_0A getrandomweaponfromcategory();
  var_0A.var_13CC3 = [];
  var_0A.var_13CC3["hover"] = "minijackal_assault_mp";
  var_0A.var_13CC3["fly"] = var_7;
  var_0A.var_13CC3["land"] = var_0A.var_13CC3["hover"];
  var_0A _meth_84BE("minijackal_mp");
  var_0A _meth_849E(var_0A.var_13CC3["fly"]);
  lib_0BCE::func_A2B2(var_0A, undefined, "hover");
  self _meth_8490("disable_mode_switching", 1);
  self _meth_8490("disable_juke", 1);
  self _meth_8490("disable_guns", 0);
  self _meth_8490("disable_boost", 0);
  self.restoreangles = self getplayerangles();
  self.ignoreme = 0;
  self _meth_85A2("apex_mp");
  var_0A.var_10E4C = func_495B();
  var_0A.var_EDD7 = 2250;
  var_0A.max_health = 2250;
  var_0A.var_11A34 = 0;
  var_0A.streakname = var_0.streakname;
  var_0A.triggerportableradarping = self;
  var_0A.team = self.team;
  var_0A.var_B8B0 = 4;
  var_0A.streakinfo = var_0;
  self.var_B7AA = var_0A;
  var_0A scripts\mp\killstreaks\_utility::func_1843(var_0.streakname, "Killstreak_Ground", var_0A.triggerportableradarping, 1);
  var_0A scripts\mp\killstreaks\_utility::func_FAE4("minijackal_end", "apex_mp");
  var_0A thread func_B9A4(self);
  var_0A thread func_B9A5(self);
  var_0A thread func_B97F(self);
  var_0A thread func_B95F(self);
  var_0A thread func_B961(self);
  var_0A thread func_B95E(self);
  var_0A thread func_B9A9(var_6);
  var_0A thread func_B968(self);
  var_0A thread func_B963(self);
  var_0A thread func_B969(self);
  var_0A thread func_5119(self);
  var_0A setscriptablepartstate("thrusters", "hover", 0);
  var_0A setscriptablepartstate("team_light", "idle", 0);
  var_0A setscriptablepartstate("dust", "active", 0);
  var_0A setscriptablepartstate("hud", "active", 0);
  scripts\mp\matchdata::logkillstreakevent(var_0.streakname, var_0A.origin);
  level thread scripts\mp\utility::teamplayercardsplash(var_5, self);
  self setclientomnvar("ui_minijackal_controls", var_8);
  self setclientomnvar("ui_killstreak_countdown", gettime() + int(var_6 * 1000));
  self setclientomnvar("ui_killstreak_health", var_0A.var_EDD7 / var_0A.max_health);
  self thermalvisionfofoverlayon();
  self.var_209D = gettime();
  return 1;
}

func_B9A4(var_0) {
  var_0 endon("disconnect");
  level endon("game_ended");
  self endon("minijackal_end");
  for(;;) {
    var_0 waittill("engage boost");
    self setscriptablepartstate("thrusters", "boost", 0);
  }
}

func_B9A5(var_0) {
  var_0 endon("disconnect");
  level endon("game_ended");
  self endon("minijackal_end");
  for(;;) {
    var_0 waittill("disengage boost");
    self _meth_8491("hover");
    self setscriptablepartstate("thrusters", "hover", 0);
  }
}

func_B9AF(var_0) {
  var_0 endon("disconnect");
  level endon("game_ended");
  self endon("minijackal_end");
  var_0 notifyonplayercommand("ks_switch_weapons", "+weapnext");
  var_1 = self.var_13CC3["hover"];
  for(;;) {
    var_0 waittill("ks_switch_weapons");
    self _meth_849E(var_1);
    if(var_1 == self.var_13CC3["fly"]) {
      var_1 = self.var_13CC3["hover"];
      continue;
    }

    var_1 = self.var_13CC3["fly"];
  }
}

monitor_health(var_0) {
  var_0 endon("disconnect");
  level endon("game_ended");
  self endon("minijackal_end");
  for(;;) {
    var_1 = float(float(self.var_11A34) / float(self.max_health));
    var_1 = clamp(var_1, 0, 1);
    self.var_10E4C.alpha = var_1;
    scripts\engine\utility::waitframe();
  }
}

func_B97A(var_0) {
  var_0 endon("disconnect");
  level endon("game_ended");
  self endon("minijackal_end");
  var_0 notifyonplayercommand("ks_lockon", "+speed_throw");
  var_0 notifyonplayercommand("ks_lockoff", "-speed_throw");
  for(;;) {
    var_0 waittill("ks_lockon");
    self _meth_849E(self.var_13CC3["hover"]);
    var_0 waittill("ks_lockoff");
    self _meth_849E(self.var_13CC3["fly"]);
  }
}

func_B97F(var_0) {
  var_0 endon("disconnect");
  level endon("game_ended");
  self endon("minijackal_end");
  var_0 notifyonplayercommand("minijackal_missile_fire", "+frag");
  var_1 = ["tag_missile1", "tag_missile2", "tag_missile3", "tag_missile4"];
  var_2 = "ui_minijackal_reload";
  if(scripts\mp\killstreaks\_utility::func_A69F(self.streakinfo, "passive_auto_missiles")) {
    var_2 = "ui_minijackal_reload_long";
  }

  for(;;) {
    var_0 waittill("minijackal_missile_fire");
    if(scripts\mp\utility::istrue(self.var_DF58)) {
      continue;
    }

    var_3 = self.var_B8B0;
    var_0 setclientomnvar(var_2, 1);
    for(var_4 = 0; var_4 < var_3; var_4++) {
      var_5 = self gettagorigin(var_1[var_4]);
      var_6 = self gettagorigin("tag_camera") + anglesToForward(self.angles) * 1000;
      var_7 = scripts\mp\utility::_magicbullet("shockproj_mp", var_5, var_6, var_0);
      var_7.streakinfo = self.streakinfo;
      var_7 setentityowner(self);
      if(scripts\mp\killstreaks\_utility::func_A69F(self.streakinfo, "passive_auto_missiles")) {
        var_7 trackmissiletargetinview(var_5, self);
      }

      self setscriptablepartstate("missile_pod_" + var_4 + 1, "fire", 0);
      var_7 thread func_13A22();
      var_7 thread scripts\mp\killstreaks\_utility::watchsupertrophynotify(var_0);
      self.var_B8B0--;
      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.2);
    }

    thread func_B894(var_0);
  }
}

trackmissiletargetinview(var_0, var_1) {
  var_2 = scripts\mp\killstreaks\_utility::func_7E92(var_1.triggerportableradarping);
  var_3 = undefined;
  var_4 = 999999999;
  var_5 = var_0;
  var_6 = anglesToForward(var_1.angles);
  var_7 = [self, var_1, var_1.triggerportableradarping];
  var_8 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_vehicle", "physicscontents_item"]);
  foreach(var_0A in var_2) {
    if(!scripts\mp\killstreaks\_utility::manualmissilecantracktarget(var_0A)) {
      continue;
    }

    if(scripts\mp\utility::istrue(var_0A.apextargetted)) {
      continue;
    }

    var_0B = var_0A.origin;
    var_0C = vectornormalize(var_0B - var_5);
    var_7[var_7.size] = var_0A;
    var_0D = distance2d(var_5, var_0B);
    if(scripts\common\trace::ray_trace_passed(var_5, var_0B, var_7, var_8) && vectordot(var_6, var_0C) > 0.75 && var_0D <= var_4) {
      var_4 = var_0D;
      var_3 = var_0A;
    }
  }

  if(isDefined(var_3)) {
    self missile_settargetent(var_3, (0, 0, 40));
    self missile_setflightmodedirect();
    var_3.apextargetted = 1;
    var_3 thread watchtarget(self);
  }
}

watchtarget(var_0) {
  self endon("disconnect");
  for(;;) {
    if(!scripts\mp\killstreaks\_utility::manualmissilecantracktarget(self)) {
      break;
    }

    if(!isDefined(var_0)) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  self.apextargetted = undefined;
  if(isDefined(var_0)) {
    var_0 missile_cleartarget();
  }
}

func_13A22() {
  self waittill("explode", var_0);
  playsoundatpos(var_0, "wrist_rocket_explode");
}

func_B894(var_0) {
  var_0 endon("disconnect");
  level endon("game_ended");
  self endon("minijackal_end");
  self.var_DF58 = 1;
  var_1 = 0.8;
  var_2 = "ui_minijackal_reload";
  if(scripts\mp\killstreaks\_utility::func_A69F(self.streakinfo, "passive_auto_missiles")) {
    var_1 = 1.05;
    var_2 = "ui_minijackal_reload_long";
  }

  while(self.var_B8B0 < 4) {
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_1);
    self.var_B8B0++;
    self setscriptablepartstate("missile_pod_" + self.var_B8B0, "neutral", 0);
  }

  var_0 setclientomnvar(var_2, 0);
  self.var_DF58 = undefined;
}

func_B95F(var_0) {
  var_0 endon("disconnect");
  level endon("game_ended");
  self endon("minijackal_end");
  var_1 = 3;
  var_2 = 4;
  var_3 = 5;
  if(scripts\mp\killstreaks\_utility::func_A69F(self.streakinfo, "passive_armor_duration")) {
    var_1++;
    var_2++;
    var_3++;
  }

  for(;;) {
    self waittill("damage", var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C, var_0D, var_0E, var_0F, var_10, var_11);
    var_0D = scripts\mp\utility::func_13CA1(var_0D, var_11);
    if(isDefined(var_5) && var_5.classname != "trigger_hurt") {
      if(isDefined(var_5.triggerportableradarping)) {
        var_5 = var_5.triggerportableradarping;
      }

      if(isDefined(var_5.team) && var_5.team == self.team && var_5 != self.triggerportableradarping) {
        continue;
      }
    }

    if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_5)) {
      continue;
    }

    if(isDefined(var_0D)) {
      var_4 = scripts\mp\killstreaks\_utility::getmodifiedantikillstreakdamage(var_5, var_0D, var_8, var_4, self.max_health, var_1, var_2, var_3, 1);
      if(scripts\mp\killstreaks\_utility::func_A69F(self.streakinfo, "passive_armor_duration")) {
        if(scripts\mp\killstreaks\_utility::isexplosiveantikillstreakweapon(var_0D)) {
          var_5 scripts\mp\damagefeedback::updatedamagefeedback("hitblastshield");
        }
      }
    }

    self.var_EDD7 = self.var_EDD7 - var_4;
    self.var_11A34 = self.var_11A34 + var_4;
    if(self.var_EDD7 < 0) {
      self.var_EDD7 = 0;
    }

    var_0 setclientomnvar("ui_killstreak_health", self.var_EDD7 / self.max_health);
    if(isDefined(var_8)) {
      var_0 func_4CF1(self, var_8);
    }

    if(isplayer(var_5)) {
      var_5 scripts\mp\damagefeedback::updatedamagefeedback("");
      scripts\mp\killstreaks\_killstreaks::killstreakhit(var_5, var_0D, self, var_8);
      scripts\mp\damage::logattackerkillstreak(self, var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C, var_0D);
      if(self.var_EDD7 <= 0) {
        var_5 notify("destroyed_killstreak", var_0D);
        var_12 = "callout_destroyed_" + self.streakname;
        var_13 = scripts\mp\killstreak_loot::getrarityforlootitem(self.streakinfo.variantid);
        if(var_13 != "") {
          var_12 = var_12 + "_" + var_13;
        }

        scripts\mp\damage::onkillstreakkilled("minijackal", var_5, var_0D, var_8, var_4, "destroyed_" + self.streakname, self.streakname + "_destroy", var_12, 1);
      }
    }

    if(self.var_EDD7 <= 0) {
      self notify("minijackal_end");
    }
  }
}

func_4CF1(var_0, var_1) {
  switch (var_1) {
    case "MOD_GRENADE_SPLASH":
    case "MOD_GRENADE":
    case "MOD_PROJECTILE":
    case "MOD_EXPLOSIVE_BULLET":
    case "MOD_PISTOL_BULLET":
    case "MOD_RIFLE_BULLET":
      func_3239(var_0);
      break;

    case "MOD_PROJECTILE_SPLASH":
    case "MOD_IMPACT":
    case "MOD_EXPLOSIVE":
      func_69E6(var_0);
      break;

    default:
      break;
  }
}

func_3239(var_0) {
  self earthquakeforplayer(0.2, 0.25, var_0.origin, 50);
  self playrumbleonentity("damage_light");
  thread func_1349D(var_0, 0.4);
}

func_69E6(var_0) {
  self earthquakeforplayer(0.5, 0.45, var_0.origin, 1000);
  self playrumbleonentity("damage_heavy");
  thread func_1349D(var_0, 0.7);
}

func_1349D(var_0, var_1) {
  self endon("disconnect");
  level endon("game_ended");
  var_0 endon("minijackal_end");
  var_0.var_10E4C.alpha = var_1;
  while(var_1 > 0) {
    scripts\engine\utility::waitframe();
    var_1 = var_1 - 0.1;
    var_0.var_10E4C.alpha = var_1;
  }
}

func_495B() {
  var_0 = newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 0;
  var_0 setshader("white", 640, 480);
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.sort = 1;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 0;
  var_0.foreground = 1;
  return var_0;
}

func_B961(var_0) {
  level endon("game_ended");
  self waittill("minijackal_end");
  self stoploopsound();
  var_1 = self.origin + anglesToForward(self.angles) * 100;
  playsoundatpos(self.origin, "frag_grenade_explode");
  playFX(scripts\engine\utility::getfx("miniJackal_explosion"), self.origin);
  if(isDefined(var_0)) {
    if(scripts\mp\utility::isreallyalive(var_0)) {
      var_0 earthquakeforplayer(0.6, 1, self.origin, 500);
    }

    var_0 lib_0BCE::func_A2B1(self);
    var_0 setclientomnvar("ui_minijackal_controls", 0);
    var_0 setclientomnvar("ui_killstreak_missile_warn", 0);
    var_0 setclientomnvar("ui_killstreak_countdown", 0);
    var_0 setclientomnvar("ui_killstreak_health", 0);
    var_0 setclientomnvar("ui_minijackal_reload", 0);
    var_0 setclientomnvar("ui_minijackal_reload_long", 0);
    var_0 setplayerangles(var_0.restoreangles);
    var_0 _meth_85A2("");
    var_0 thermalvisionfofoverlayoff();
    var_0 thread scripts\mp\killstreaks\_killstreaks::func_11086();
    var_0 scripts\engine\utility::allow_usability(1);
    var_0 scripts\engine\utility::allow_weapon_switch(1);
    var_2 = gettime() - var_0.var_209D / 1000;
    var_0 scripts\mp\missions::func_D991("ch_apex_pilot", int(var_2));
  }

  if(isDefined(self.var_115D6)) {
    self.var_115D6 delete();
  }

  if(isDefined(self.var_C7FF)) {
    self.var_C7FF delete();
  }

  if(isDefined(self.var_10E4C)) {
    self.var_10E4C destroy();
  }

  scripts\mp\utility::printgameaction("killstreak ended - minijackal", var_0);
  self delete();
  level.var_B7AD = scripts\engine\utility::array_removeundefined(level.var_B7AD);
}

func_B95E(var_0) {
  var_0 endon("disconnect");
  level endon("game_ended");
  self endon("minijackal_end");
  for(;;) {
    self waittill("spaceship_collision", var_1, var_2, var_3, var_4);
    var_5 = var_0 getnormalizedmovement();
    var_6 = var_5[0] + 1 / 2;
    var_7 = 16 + 19 * var_6;
    var_8 = var_2 - 4 / var_7 - 4;
    if(var_8 > 1) {
      var_8 = 1;
    } else if(var_8 < 0) {
      var_8 = 0;
    }

    var_9 = var_8 * var_1;
    if(var_9 > 0) {
      var_0 earthquakeforplayer(var_9, 0.5, self.origin, 100);
      var_0A = 10 + 240 * var_9;
      if(self.var_EDD7 - var_0A < 150) {
        var_0A = self.var_EDD7 - 150;
      }
    }
  }
}

func_B9A9(var_0) {
  self.triggerportableradarping endon("disconnect");
  level endon("game_ended");
  self endon("host_migration_lifetime_update");
  self endon("minijackal_end");
  thread scripts\mp\killstreaks\_utility::watchhostmigrationlifetime("minijackal_end", var_0, ::func_B9A9);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  self.triggerportableradarping scripts\mp\utility::playkillstreakdialogonplayer("minijackal_timeout", undefined, undefined, self.triggerportableradarping.origin);
  self notify("minijackal_end");
}

func_B968(var_0) {
  var_0 endon("disconnect");
  level endon("game_ended");
  self endon("minijackal_end");
  thread scripts\mp\killstreaks\_killstreaks::allowridekillstreakplayerexit("minijackal_end");
  self waittill("killstreakExit");
  self notify("minijackal_end");
}

func_B963(var_0) {
  level endon("game_ended");
  self endon("minijackal_end");
  var_0 scripts\engine\utility::waittill_any_3("joined_team", "disconnect", "joined_spectators");
  self notify("minijackal_end");
}

func_B969(var_0) {
  level endon("game_ended");
  self endon("minijackal_end");
  for(;;) {
    self waittill("emp_damage", var_1, var_2, var_3, var_4, var_5);
    scripts\mp\killstreaks\_utility::dodamagetokillstreak(100, var_1, var_1, self.team, var_3, var_5, var_4);
    if(!scripts\mp\utility::istrue(self.disabled)) {
      thread disable_minijackal(var_2);
    }
  }
}

disable_minijackal(var_0) {
  level endon("game_ended");
  self endon("minijackal_end");
  self.disabled = 1;
  self setscriptablepartstate("team_light", "neutral", 0);
  playFXOnTag(scripts\engine\utility::getfx("emp_stun"), self, "tag_origin");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  self setscriptablepartstate("team_light", "idle", 0);
  stopFXOnTag(scripts\engine\utility::getfx("emp_stun"), self, "tag_origin");
  self.disabled = undefined;
}

func_C77B(var_0) {
  var_0 endon("disconnect");
  level endon("game_ended");
  self endon("minijackal_end");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1);
  var_1 = scripts\mp\utility::outlineenableforplayer(var_0, "cyan", var_0, 0, 0, "killstreak");
  thread func_E066(var_1, var_0);
}

func_E066(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    var_1 endon("disconnect");
  }

  level endon("game_ended");
  var_3 = ["leave", "death"];
  if(isDefined(var_2)) {
    scripts\engine\utility::waittill_any_in_array_or_timeout_no_endon_death(var_3, var_2);
  } else {
    scripts\engine\utility::waittill_any_in_array_return_no_endon_death(var_3);
  }

  if(isDefined(var_1)) {
    scripts\mp\utility::outlinedisable(var_0, var_1);
  }
}

func_B7AC(var_0) {
  scripts\mp\utility::setusingremote(var_0);
}

func_B7AB() {
  if(isDefined(self)) {
    scripts\mp\utility::clearusingremote();
  }
}

func_6C9B(var_0, var_1, var_2) {
  var_3 = anglesToForward(self.angles);
  var_4 = anglestoright(self.angles);
  var_5 = self getEye();
  var_6 = var_5 + (0, 0, var_1);
  var_7 = var_6 + var_0 * var_3;
  if(func_3DCF(var_5, var_7, var_2)) {
    return var_7;
  }

  var_7 = var_6 - var_0 * var_3;
  if(func_3DCF(var_5, var_7, var_2)) {
    return var_7;
  }

  var_7 = var_7 + var_0 * var_4;
  if(func_3DCF(var_5, var_7, var_2)) {
    return var_7;
  }

  var_7 = var_6 - var_0 * var_4;
  if(func_3DCF(var_5, var_7, var_2)) {
    return var_7;
  }

  var_7 = var_6;
  if(func_3DCF(var_5, var_7, var_2)) {
    return var_7;
  }

  scripts\engine\utility::waitframe();
  var_7 = var_6 + 0.707 * var_0 * var_3 + var_4;
  if(func_3DCF(var_5, var_7, var_2)) {
    return var_7;
  }

  var_7 = var_6 + 0.707 * var_0 * var_3 - var_4;
  if(func_3DCF(var_5, var_7, var_2)) {
    return var_7;
  }

  var_7 = var_6 + 0.707 * var_0 * var_4 - var_3;
  if(func_3DCF(var_5, var_7, var_2)) {
    return var_7;
  }

  var_7 = var_6 + 0.707 * var_0 * -1 * var_3 - var_4;
  if(func_3DCF(var_5, var_7, var_2)) {
    return var_7;
  }

  return undefined;
}

func_3DCF(var_0, var_1, var_2) {
  var_3 = 0;
  if(capsuletracepassed(var_1, var_2, var_2 * 2 + 0.01, undefined, 1, 1)) {
    var_4 = [self];
    var_5 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
    var_6 = physics_raycast(var_0, var_1, var_5, var_4, 0, "physicsquery_closest");
    if(var_6.size == 0) {
      var_3 = 1;
    }
  }

  return var_3;
}

func_5119(var_0) {
  var_0 endon("disconnect");
  level endon("game_ended");
  self endon("minijackal_end");
  self.var_C7FF = spawnfxforclient(level._effect["thor_fisheye"], var_0 getEye(), var_0);
  triggerfx(self.var_C7FF);
  self.var_C7FF setfxkilldefondelete();
  thread killfxongameend(self.var_C7FF);
}

killfxongameend(var_0) {
  self endon("minijackal_end");
  level waittill("game_ended");
  if(isDefined(var_0)) {
    var_0 delete();
  }
}