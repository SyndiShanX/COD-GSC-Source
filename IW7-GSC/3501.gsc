/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3501.gsc
***************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("minijackal", ::func_12889, undefined, undefined, undefined, ::func_13C16, undefined, ::invalid_use_minijackal);
  level._effect["miniJackal_eyeglow"] = loadfx("vfx\iw7\_requests\mp\vfx_venom_glint");
  level._effect["miniJackal_explosion"] = loadfx("vfx\iw7\core\mp\killstreaks\vfx_apex_dest_exp.vfx");
  level._effect["miniJackal_hover_thrusters"] = loadfx("vfx\iw7\core\mp\killstreaks\vfx_apex_thrusters.vfx");
  level._effect["miniJackal_antenna_enemy"] = loadfx("vfx\iw7\core\mp\killstreaks\vfx_apex_light_ping_en.vfx");
  level._effect["miniJackal_antenna_friendly"] = loadfx("vfx\iw7\core\mp\killstreaks\vfx_apex_light_ping_fr.vfx");
  level._effect["miniJackal_boost_thrusters"] = loadfx("vfx\iw7\core\mp\killstreaks\vfx_apex_thrusters_boost.vfx");
  level._effect["miniJackal_hover_thrusters_light"] = loadfx("vfx\iw7\core\mp\killstreaks\vfx_apex_thrusters_light.vfx");
  level._effect["miniJackal_boost_thrusters_light"] = loadfx("vfx\iw7\core\mp\killstreaks\vfx_apex_thrusters_boost_light.vfx");
  level.func_B7AD = [];
  var_00 = ["passive_increased_armor", "passive_decreased_duration", "passive_auto_missiles", "passive_long_reload", "passive_twin_dragons", "passive_armor_duration"];
  scripts\mp\killstreak_loot::func_DF07("minijackal", var_00);
  level.minijackalsincoming = [];
}

func_13C16(var_00) {
  var_01 = 0;
  var_02 = 0;

  foreach(var_04 in level.minijackalsincoming) {
    if(level.teambased) {
      if(self.team == var_4.team) {
        var_1++;
      }

      continue;
    }

    var_2++;
  }

  if(var_01 >= 1) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_MINIJACKAL_MAX");
    return 0;
  }

  if(var_02 >= 2) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_MINIJACKAL_MAX");
    return 0;
  }

  if(isDefined(level.func_B7AD)) {
    var_06 = 0;
    var_07 = 0;

    foreach(var_09 in level.func_B7AD) {
      if(level.teambased) {
        if(self.team == var_9.owner.team) {
          var_6++;
        }

        continue;
      }

      var_7++;
    }

    if(var_06 + var_01 >= 1) {
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS_MINIJACKAL_MAX");
      return 0;
    }

    if(var_07 + var_02 >= 2) {
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS_MINIJACKAL_MAX");
      return 0;
    }
  }

  self setclientomnvar("ui_remote_control_sequence", 1);
  incrementminijackalsincoming(self);
}

invalid_use_minijackal(var_00) {
  decrementminijackalsincoming(self);
}

incrementminijackalsincoming(var_00) {
  var_01 = "ent_" + var_00 getentitynumber();
  level.minijackalsincoming[var_01] = var_00;
  var_00 thread watchforinterrupt(var_01);
}

watchforinterrupt(var_00) {
  self endon("received_playremote_result");
  level endon("game_ended");
  scripts\engine\utility::waittill_any("death", "disconnect");
  decrementminijackalsincoming(var_00);
}

decrementminijackalsincoming(var_00) {
  var_01 = undefined;

  if(isplayer(var_00)) {
    var_01 = "ent_" + var_00 getentitynumber();
  }
  else {
    var_01 = var_00;
  }

  level.minijackalsincoming[var_01] = undefined;
}

func_12889(var_00) {
  var_01 = scripts\mp\killstreaks\killstreaks::func_D507(var_00);
  self notify("received_playremote_result");

  if(!var_01) {
    decrementminijackalsincoming(self);
    return 0;
  }

  var_02 = func_6C9B(80, 35, 20);

  if(!isDefined(var_02)) {
    decrementminijackalsincoming(self);
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_NOT_ENOUGH_SPACE");
    thread scripts\mp\killstreaks\killstreaks::func_11086();
    return 0;
  }

  scripts\engine\utility::allow_usability(0);
  scripts\engine\utility::allow_weapon_switch(0);
  var_03 = "veh_mil_air_ca_oblivion_drone_mp";
  var_04 = "veh_minijackal_mp";
  var_05 = "used_minijackal";
  var_06 = 60;
  var_07 = "minijackal_strike_mp";
  var_08 = 1;
  var_09 = scripts\mp\killstreak_loot::getrarityforlootitem(var_0.variantid);

  if(var_09 != "") {
    var_03 = var_03 + "_" + var_09;
    var_05 = var_05 + "_" + var_09;
  }

  if(scripts\mp\killstreaks\utility::func_A69F(var_00, "passive_armor_duration")) {
    var_06 = var_06 - 5;
  }

  if(scripts\mp\killstreaks\utility::func_A69F(var_00, "passive_twin_dragons")) {
    var_07 = "minijackal_assault_mp";
    var_04 = "veh_minijackal_beam_mp";
    var_08 = 2;
  }

  var_10 = spawnvehicle(var_03, "minijackal", var_04, var_02, self.angles, self);
  level.func_B7AD[level.func_B7AD.size] = var_10;
  decrementminijackalsincoming(self);
  var_10 give_player_tickets(1);
  var_10 getrandomweaponfromcategory();
  var_10.func_13CC3 = [];
  var_10.func_13CC3["hover"] = "minijackal_assault_mp";
  var_10.func_13CC3["fly"] = var_07;
  var_10.func_13CC3["land"] = var_10.func_13CC3["hover"];
  var_10 _meth_84BE("minijackal_mp");
  var_10 _meth_849E(var_10.func_13CC3["fly"]);
  func_0BCE::func_A2B2(var_10, undefined, "hover");
  self _meth_8490("disable_mode_switching", 1);
  self _meth_8490("disable_juke", 1);
  self _meth_8490("disable_guns", 0);
  self _meth_8490("disable_boost", 0);
  self.restoreangles = self getplayerangles();
  self.ignoreme = 0;
  self _meth_85A2("apex_mp");
  var_10.func_10E4C = func_495B();
  var_10.func_EDD7 = 2250;
  var_10.max_health = 2250;
  var_10.func_11A34 = 0;
  var_10.streakname = var_0.streakname;
  var_10.owner = self;
  var_10.team = self.team;
  var_10.func_B8B0 = 4;
  var_10.streakinfo = var_00;
  self.func_B7AA = var_10;
  var_10 scripts\mp\killstreaks\utility::func_1843(var_0.streakname, "Killstreak_Ground", var_10.owner, 1);
  var_10 scripts\mp\killstreaks\utility::func_FAE4("minijackal_end", "apex_mp");
  var_10 thread func_B9A4(self);
  var_10 thread func_B9A5(self);
  var_10 thread func_B97F(self);
  var_10 thread func_B95F(self);
  var_10 thread func_B961(self);
  var_10 thread func_B95E(self);
  var_10 thread func_B9A9(var_06);
  var_10 thread func_B968(self);
  var_10 thread func_B963(self);
  var_10 thread func_B969(self);
  var_10 thread func_5119(self);
  var_10 setscriptablepartstate("thrusters", "hover", 0);
  var_10 setscriptablepartstate("team_light", "idle", 0);
  var_10 setscriptablepartstate("dust", "active", 0);
  var_10 setscriptablepartstate("hud", "active", 0);
  scripts\mp\matchdata::logkillstreakevent(var_0.streakname, var_10.origin);
  level thread scripts\mp\utility\game::teamplayercardsplash(var_05, self);
  self setclientomnvar("ui_minijackal_controls", var_08);
  self setclientomnvar("ui_killstreak_countdown", gettime() + int(var_06 * 1000));
  self setclientomnvar("ui_killstreak_health", var_10.func_EDD7 / var_10.max_health);
  self thermalvisionfofoverlayon();
  self.func_209D = gettime();
  return 1;
}

func_B9A4(var_00) {
  var_00 endon("disconnect");
  level endon("game_ended");
  self endon("minijackal_end");

  for(;;) {
    var_00 waittill("engage boost");
    self setscriptablepartstate("thrusters", "boost", 0);
  }
}

func_B9A5(var_00) {
  var_00 endon("disconnect");
  level endon("game_ended");
  self endon("minijackal_end");

  for(;;) {
    var_00 waittill("disengage boost");
    self _meth_8491("hover");
    self setscriptablepartstate("thrusters", "hover", 0);
  }
}

func_B9AF(var_00) {
  var_00 endon("disconnect");
  level endon("game_ended");
  self endon("minijackal_end");
  var_00 notifyonplayercommand("ks_switch_weapons", "+weapnext");
  var_01 = self.func_13CC3["hover"];

  for(;;) {
    var_00 waittill("ks_switch_weapons");
    self _meth_849E(var_01);

    if(var_01 == self.func_13CC3["fly"]) {
      var_01 = self.func_13CC3["hover"];
      continue;
    }

    var_01 = self.func_13CC3["fly"];
  }
}

monitor_health(var_00) {
  var_00 endon("disconnect");
  level endon("game_ended");
  self endon("minijackal_end");

  for(;;) {
    var_01 = float(float(self.func_11A34) / float(self.max_health));
    var_01 = clamp(var_01, 0, 1);
    self.func_10E4C.alpha = var_01;
    scripts\engine\utility::waitframe();
  }
}

func_B97A(var_00) {
  var_00 endon("disconnect");
  level endon("game_ended");
  self endon("minijackal_end");
  var_00 notifyonplayercommand("ks_lockon", "+speed_throw");
  var_00 notifyonplayercommand("ks_lockoff", "-speed_throw");

  for(;;) {
    var_00 waittill("ks_lockon");
    self _meth_849E(self.func_13CC3["hover"]);
    var_00 waittill("ks_lockoff");
    self _meth_849E(self.func_13CC3["fly"]);
  }
}

func_B97F(var_00) {
  var_00 endon("disconnect");
  level endon("game_ended");
  self endon("minijackal_end");
  var_00 notifyonplayercommand("minijackal_missile_fire", "+frag");
  var_01 = ["tag_missile1", "tag_missile2", "tag_missile3", "tag_missile4"];
  var_02 = "ui_minijackal_reload";

  if(scripts\mp\killstreaks\utility::func_A69F(self.streakinfo, "passive_auto_missiles")) {
    var_02 = "ui_minijackal_reload_long";
  }

  for(;;) {
    var_00 waittill("minijackal_missile_fire");

    if(scripts\mp\utility\game::istrue(self.func_DF58)) {
      continue;
    }
    var_03 = self.func_B8B0;
    var_00 setclientomnvar(var_02, 1);

    for(var_04 = 0; var_04 < var_03; var_4++) {
      var_05 = self gettagorigin(var_1[var_04]);
      var_06 = self gettagorigin("tag_camera") + anglesToForward(self.angles) * 1000;
      var_07 = scripts\mp\utility\game::_magicbullet("shockproj_mp", var_05, var_06, var_00);
      var_7.streakinfo = self.streakinfo;
      var_07 setentityowner(self);

      if(scripts\mp\killstreaks\utility::func_A69F(self.streakinfo, "passive_auto_missiles")) {
        var_07 trackmissiletargetinview(var_05, self);
      }

      self setscriptablepartstate("missile_pod_" + (var_04 + 1), "fire", 0);
      var_07 thread func_13A22();
      var_07 thread scripts\mp\killstreaks\utility::watchsupertrophynotify(var_00);
      self.func_B8B0--;
      scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.2);
    }

    thread func_B894(var_00);
  }
}

trackmissiletargetinview(var_00, var_01) {
  var_02 = scripts\mp\killstreaks\utility::func_7E92(var_1.owner);
  var_03 = undefined;
  var_04 = 999999999;
  var_05 = var_00;
  var_06 = anglesToForward(var_1.angles);
  var_07 = [self, var_01, var_1.owner];
  var_08 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_vehicle", "physicscontents_item"]);

  foreach(var_10 in var_02) {
    if(!scripts\mp\killstreaks\utility::manualmissilecantracktarget(var_10)) {
      continue;
    }
    if(scripts\mp\utility\game::istrue(var_10.apextargetted)) {
      continue;
    }
    var_11 = var_10.origin;
    var_12 = vectornormalize(var_11 - var_05);
    var_7[var_7.size] = var_10;
    var_13 = distance2d(var_05, var_11);

    if(scripts\engine\trace::ray_trace_passed(var_05, var_11, var_07, var_08) && vectordot(var_06, var_12) > 0.75 && var_13 <= var_04) {
      var_04 = var_13;
      var_03 = var_10;
    }
  }

  if(isDefined(var_03)) {
    self missile_settargetent(var_03, (0, 0, 40));
    self missile_setflightmodedirect();
    var_3.apextargetted = 1;
    var_03 thread watchtarget(self);
  }
}

watchtarget(var_00) {
  self endon("disconnect");

  for(;;) {
    if(!scripts\mp\killstreaks\utility::manualmissilecantracktarget(self)) {
      break;
    }
    if(!isDefined(var_00)) {
      break;
    }
    scripts\engine\utility::waitframe();
  }

  self.apextargetted = undefined;

  if(isDefined(var_00)) {
    var_00 missile_cleartarget();
  }
}

func_13A22() {
  self waittill("explode", var_00);
  playLoopSound(var_00, "wrist_rocket_explode");
}

func_B894(var_00) {
  var_00 endon("disconnect");
  level endon("game_ended");
  self endon("minijackal_end");
  self.func_DF58 = 1;
  var_01 = 0.8;
  var_02 = "ui_minijackal_reload";

  if(scripts\mp\killstreaks\utility::func_A69F(self.streakinfo, "passive_auto_missiles")) {
    var_01 = 1.05;
    var_02 = "ui_minijackal_reload_long";
  }

  while(self.func_B8B0 < 4) {
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_01);
    self.func_B8B0++;
    self setscriptablepartstate("missile_pod_" + self.func_B8B0, "neutral", 0);
  }

  var_00 setclientomnvar(var_02, 0);
  self.func_DF58 = undefined;
}

func_B95F(var_00) {
  var_00 endon("disconnect");
  level endon("game_ended");
  self endon("minijackal_end");
  var_01 = 3;
  var_02 = 4;
  var_03 = 5;

  if(scripts\mp\killstreaks\utility::func_A69F(self.streakinfo, "passive_armor_duration")) {
    var_1++;
    var_2++;
    var_3++;
  }

  for(;;) {
    self waittill("damage", var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17);
    var_13 = scripts\mp\utility\game::func_13CA1(var_13, var_17);

    if(isDefined(var_05) && var_5.classname != "trigger_hurt") {
      if(isDefined(var_5.owner)) {
        var_05 = var_5.owner;
      }

      if(isDefined(var_5.team) && var_5.team == self.team && var_05 != self.owner) {
        continue;
      }
    }

    if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_05)) {
      continue;
    }
    if(isDefined(var_13)) {
      var_04 = scripts\mp\killstreaks\utility::getmodifiedantikillstreakdamage(var_05, var_13, var_08, var_04, self.max_health, var_01, var_02, var_03, 1);

      if(scripts\mp\killstreaks\utility::func_A69F(self.streakinfo, "passive_armor_duration")) {
        if(scripts\mp\killstreaks\utility::isexplosiveantikillstreakweapon(var_13)) {
          var_05 scripts\mp\damagefeedback::updatedamagefeedback("hitblastshield");
        }
      }
    }

    self.func_EDD7 = self.func_EDD7 - var_04;
    self.func_11A34 = self.func_11A34 + var_04;

    if(self.func_EDD7 < 0) {
      self.func_EDD7 = 0;
    }

    var_00 setclientomnvar("ui_killstreak_health", self.func_EDD7 / self.max_health);

    if(isDefined(var_08)) {
      var_00 func_4CF1(self, var_08);
    }

    if(isplayer(var_05)) {
      var_05 scripts\mp\damagefeedback::updatedamagefeedback("");
      scripts\mp\killstreaks\killstreaks::killstreakhit(var_05, var_13, self, var_08);
      scripts\mp\damage::logattackerkillstreak(self, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13);

      if(self.func_EDD7 <= 0) {
        var_05 notify("destroyed_killstreak", var_13);
        var_18 = "callout_destroyed_" + self.streakname;
        var_19 = scripts\mp\killstreak_loot::getrarityforlootitem(self.streakinfo.variantid);

        if(var_19 != "") {
          var_18 = var_18 + "_" + var_19;
        }

        scripts\mp\damage::onkillstreakkilled("minijackal", var_05, var_13, var_08, var_04, "destroyed_" + self.streakname, self.streakname + "_destroy", var_18, 1);
      }
    }

    if(self.func_EDD7 <= 0) {
      self notify("minijackal_end");
    }
  }
}

func_4CF1(var_00, var_01) {
  switch (var_01) {
    case "MOD_GRENADE_SPLASH":
    case "MOD_GRENADE":
    case "MOD_PROJECTILE":
    case "MOD_EXPLOSIVE_BULLET":
    case "MOD_PISTOL_BULLET":
    case "MOD_RIFLE_BULLET":
      func_3239(var_00);
      break;
    case "MOD_PROJECTILE_SPLASH":
    case "MOD_IMPACT":
    case "MOD_EXPLOSIVE":
      func_69E6(var_00);
      break;
    default:
  }
}

func_3239(var_00) {
  self earthquakeforplayer(0.2, 0.25, var_0.origin, 50);
  self playrumbleonentity("damage_light");
  thread func_1349D(var_00, 0.4);
}

func_69E6(var_00) {
  self earthquakeforplayer(0.5, 0.45, var_0.origin, 1000);
  self playrumbleonentity("damage_heavy");
  thread func_1349D(var_00, 0.7);
}

func_1349D(var_00, var_01) {
  self endon("disconnect");
  level endon("game_ended");
  var_00 endon("minijackal_end");

  for(var_0.func_10E4C.alpha = var_01; var_01 > 0; var_0.func_10E4C.alpha = var_01) {
    scripts\engine\utility::waitframe();
    var_01 = var_01 - 0.1;
  }
}

func_495B() {
  var_00 = newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 0;
  var_00 setshader("white", 640, 480);
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.sort = 1;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 0;
  var_0.foreground = 1;
  return var_00;
}

func_B961(var_00) {
  level endon("game_ended");
  self waittill("minijackal_end");
  self stoploopsound();
  var_01 = self.origin + anglesToForward(self.angles) * 100;
  playLoopSound(self.origin, "frag_grenade_explode");
  playFX(scripts\engine\utility::getfx("miniJackal_explosion"), self.origin);

  if(isDefined(var_00)) {
    if(scripts\mp\utility\game::isreallyalive(var_00)) {
      var_00 earthquakeforplayer(0.6, 1, self.origin, 500);
    }

    var_00 func_0BCE::func_A2B1(self);
    var_00 setclientomnvar("ui_minijackal_controls", 0);
    var_00 setclientomnvar("ui_killstreak_missile_warn", 0);
    var_00 setclientomnvar("ui_killstreak_countdown", 0);
    var_00 setclientomnvar("ui_killstreak_health", 0);
    var_00 setclientomnvar("ui_minijackal_reload", 0);
    var_00 setclientomnvar("ui_minijackal_reload_long", 0);
    var_00 setplayerangles(var_0.restoreangles);
    var_00 _meth_85A2("");
    var_00 thermalvisionfofoverlayoff();
    var_00 thread scripts\mp\killstreaks\killstreaks::func_11086();
    var_00 scripts\engine\utility::allow_usability(1);
    var_00 scripts\engine\utility::allow_weapon_switch(1);
    var_02 = (gettime() - var_0.func_209D) / 1000;
    var_00 scripts\mp\missions::func_D991("ch_apex_pilot", int(var_02));
  }

  if(isDefined(self.func_115D6)) {
    self.func_115D6 delete();
  }

  if(isDefined(self.func_C7FF)) {
    self.func_C7FF delete();
  }

  if(isDefined(self.func_10E4C)) {
    self.func_10E4C destroy();
  }

  scripts\mp\utility\game::printgameaction("killstreak ended - minijackal", var_00);
  self delete();
  level.func_B7AD = scripts\engine\utility::array_removeundefined(level.func_B7AD);
}

func_B95E(var_00) {
  var_00 endon("disconnect");
  level endon("game_ended");
  self endon("minijackal_end");

  for(;;) {
    self waittill("spaceship_collision", var_01, var_02, var_03, var_04);
    var_05 = var_00 getnormalizedmovement();
    var_06 = (var_5[0] + 1) / 2;
    var_07 = 16 + 19 * var_06;
    var_08 = (var_02 - 4) / (var_07 - 4);

    if(var_08 > 1.0) {
      var_08 = 1.0;
    }
    else if(var_08 < 0.0) {
      var_08 = 0.0;
    }

    var_09 = var_08 * var_01;

    if(var_09 > 0) {
      var_00 earthquakeforplayer(var_09, 0.5, self.origin, 100);
      var_10 = 10 + 240 * var_09;

      if(self.func_EDD7 - var_10 < 150) {
        var_10 = self.func_EDD7 - 150;
      }
    }
  }
}

func_B9A9(var_00) {
  self.owner endon("disconnect");
  level endon("game_ended");
  self endon("host_migration_lifetime_update");
  self endon("minijackal_end");
  thread scripts\mp\killstreaks\utility::watchhostmigrationlifetime("minijackal_end", var_00, ::func_B9A9);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_00);
  self.owner scripts\mp\utility\game::playkillstreakdialogonplayer("minijackal_timeout", undefined, undefined, self.owner.origin);
  self notify("minijackal_end");
}

func_B968(var_00) {
  var_00 endon("disconnect");
  level endon("game_ended");
  self endon("minijackal_end");
  thread scripts\mp\killstreaks\killstreaks::allowridekillstreakplayerexit("minijackal_end");
  self waittill("killstreakExit");
  self notify("minijackal_end");
}

func_B963(var_00) {
  level endon("game_ended");
  self endon("minijackal_end");
  var_00 scripts\engine\utility::waittill_any("joined_team", "disconnect", "joined_spectators");
  self notify("minijackal_end");
}

func_B969(var_00) {
  level endon("game_ended");
  self endon("minijackal_end");

  for(;;) {
    self waittill("emp_damage", var_01, var_02, var_03, var_04, var_05);
    scripts\mp\killstreaks\utility::dodamagetokillstreak(100, var_01, var_01, self.team, var_03, var_05, var_04);

    if(!scripts\mp\utility\game::istrue(self.disabled)) {
      thread disable_minijackal(var_02);
    }
  }
}

disable_minijackal(var_00) {
  level endon("game_ended");
  self endon("minijackal_end");
  self.disabled = 1;
  self setscriptablepartstate("team_light", "neutral", 0);
  playFXOnTag(scripts\engine\utility::getfx("emp_stun"), self, "tag_origin");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_00);
  self setscriptablepartstate("team_light", "idle", 0);
  stopFXOnTag(scripts\engine\utility::getfx("emp_stun"), self, "tag_origin");
  self.disabled = undefined;
}

func_C77B(var_00) {
  var_00 endon("disconnect");
  level endon("game_ended");
  self endon("minijackal_end");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.0);
  var_01 = scripts\mp\utility\game::outlineenableforplayer(var_00, "cyan", var_00, 0, 0, "killstreak");
  thread func_E066(var_01, var_00);
}

func_E066(var_00, var_01, var_02) {
  if(isDefined(var_01)) {
    var_01 endon("disconnect");
  }

  level endon("game_ended");
  var_03 = ["leave", "death"];

  if(isDefined(var_02)) {
    scripts\engine\utility::waittill_any_in_array_or_timeout_no_endon_death(var_03, var_02);
  }
  else {
    scripts\engine\utility::waittill_any_in_array_return_no_endon_death(var_03);
  }

  if(isDefined(var_01)) {
    scripts\mp\utility\game::outlinedisable(var_00, var_01);
  }
}

func_B7AC(var_00) {
  scripts\mp\utility\game::setusingremote(var_00);
}

func_B7AB() {
  if(isDefined(self)) {
    scripts\mp\utility\game::clearusingremote();
  }
}

func_6C9B(var_00, var_01, var_02) {
  var_03 = anglesToForward(self.angles);
  var_04 = anglestoright(self.angles);
  var_05 = self getEye();
  var_06 = var_05 + (0, 0, var_01);
  var_07 = var_06 + var_00 * var_03;

  if(func_3DCF(var_05, var_07, var_02)) {
    return var_07;
  }

  var_07 = var_06 - var_00 * var_03;

  if(func_3DCF(var_05, var_07, var_02)) {
    return var_07;
  }

  var_07 = var_07 + var_00 * var_04;

  if(func_3DCF(var_05, var_07, var_02)) {
    return var_07;
  }

  var_07 = var_06 - var_00 * var_04;

  if(func_3DCF(var_05, var_07, var_02)) {
    return var_07;
  }

  var_07 = var_06;

  if(func_3DCF(var_05, var_07, var_02)) {
    return var_07;
  }

  scripts\engine\utility::waitframe();
  var_07 = var_06 + 0.707 * var_00 * (var_03 + var_04);

  if(func_3DCF(var_05, var_07, var_02)) {
    return var_07;
  }

  var_07 = var_06 + 0.707 * var_00 * (var_03 - var_04);

  if(func_3DCF(var_05, var_07, var_02)) {
    return var_07;
  }

  var_07 = var_06 + 0.707 * var_00 * (var_04 - var_03);

  if(func_3DCF(var_05, var_07, var_02)) {
    return var_07;
  }

  var_07 = var_06 + 0.707 * var_00 * (-1 * var_03 - var_04);

  if(func_3DCF(var_05, var_07, var_02)) {
    return var_07;
  }

  return undefined;
}

func_3DCF(var_00, var_01, var_02) {
  var_03 = 0;

  if(capsuletracepassed(var_01, var_02, var_02 * 2 + 0.01, undefined, 1, 1)) {
    var_04 = [self];
    var_05 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
    var_06 = physics_raycast(var_00, var_01, var_05, var_04, 0, "physicsquery_closest");

    if(var_6.size == 0) {
      var_03 = 1;
    }
  }

  return var_03;
}

func_5119(var_00) {
  var_00 endon("disconnect");
  level endon("game_ended");
  self endon("minijackal_end");
  self.func_C7FF = spawnfxforclient(level._effect["thor_fisheye"], var_00 getEye(), var_00);
  triggerfx(self.func_C7FF);
  self.func_C7FF setfxkilldefondelete();
  thread killfxongameend(self.func_C7FF);
}

killfxongameend(var_00) {
  self endon("minijackal_end");
  level waittill("game_ended");

  if(isDefined(var_00)) {
    var_00 delete();
  }
}