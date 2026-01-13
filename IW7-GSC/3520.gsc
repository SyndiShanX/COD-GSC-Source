/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3520.gsc
**************************************/

func_105BC() {
  func_105E0();
  func_105BD();
  func_105BE();
}

func_105BD() {
  level._effect["spaceship_death"] = loadfx("vfx\iw7\core\vehicle\jackal\vfx_jackal_death_01_cheap.vfx");
  level._effect["spaceship_dmg"] = loadfx("vfx\iw7\core\vehicle\jackal\vfx_jackal_hit_damage");
  level._effect["spaceship_dmg_trail"] = loadfx("vfx\iw7\core\vehicle\jackal\vfx_jackal_hit_damage_linger");
  level._effect["spaceship_engine_idle"] = loadfx("vfx\iw7\core\vehicle\jackal\vfx_jackal_thrust_idle");
  level._effect["spaceship_engine_max"] = loadfx("vfx\iw7\core\vehicle\jackal\vfx_jackal_thrust_max");
  level._effect["spaceship_hover"] = loadfx("vfx\iw7\core\vehicle\jackal\vfx_jackal_hover");
  level._effect["spaceship_remove"] = loadfx("vfx\iw7\_requests\equipment\retractable_shield\vfx_iw7_equip_retractable_shield_melee_energy_burst.vfx");
  level._effect["cockpit_sparks"] = loadfx("vfx\core\mp\killstreaks\vfx_ims_sparks");
  level._effect["cockpit_smoke"] = loadfx("vfx\core\mp\killstreaks\vfx_helo_damage.vfx");
  level._effect["cockpit_fire"] = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level._effect["cockpit_expl"] = loadfx("vfx\iw7\_requests\mp\vfx_generic_equipment_exp_lg.vfx");
  level._effect["space_particles"] = loadfx("vfx\old\space_fighter\space_particulate_player_oneshot.vfx");
  level._effect["spaceship_trail_f"] = loadfx("vfx\core\vehicles\vfx_jackal_wingtip_trail_b");
  level._effect["spaceship_trail_e"] = loadfx("vfx\core\vehicles\vfx_jackal_wingtip_trail_o");
}

func_105BE() {
  level.var_105C8["explode"] = "exp_helicopter_fuel";
}

func_10588(var_0) {
  func_105BC();
  level.var_A407 = var_0;
  var_0.var_1051B = isDefined(var_0.var_1051B) && var_0.var_1051B;
  thread func_1058C();
  var_0.allowgrenadedamage = !isDefined(var_0.allowgrenadedamage) || var_0.allowgrenadedamage;

  if(var_0.allowgrenadedamage) {
    func_1058A("landingExclusionZone");
  } else {
    func_1058B("landingzone");
  }

  var_0.allowhide = !isDefined(var_0.allowhide) || var_0.allowhide;

  if(var_0.allowhide) {
    func_1058F("summonExclusionZone");
  } else {
    func_10590("spaceship_summon_trigger");
  }

  if(!isDefined(var_0.alliesspawnareas)) {
    var_0.alliesspawnareas = "spaceship_spawner_allies";
  }

  if(!isDefined(var_0.var_26FB)) {
    var_0.var_26FB = "spaceship_spawner_axis";
  }

  level.var_FE33["axis"] = getEntArray(var_0.var_26FB, "targetname");
  level.var_FE33["allies"] = getEntArray(var_0.alliesspawnareas, "targetname");
  var_0.var_10DBB = isDefined(var_0.var_10DBB) && var_0.var_10DBB;

  if(!var_0.var_10DBB) {
    foreach(var_2 in level.var_FE33["axis"]) {
      func_105CB(var_2, "axis");
    }

    foreach(var_2 in level.var_FE33["allies"]) {
      func_105CB(var_2, "allies");
    }
  }

  var_0.var_1C91 = isDefined(var_0.var_1C91) && var_0.var_1C91;
  func_1058E("speedZone");
  thread func_105E2();
}

func_1058C() {
  while(!isDefined(level.gametypestarted) || level.gametypestarted == 0) {
    scripts\engine\utility::waitframe();
  }

  level.healthregendisabled = 1;
}

func_105E0() {
  level.var_105EA = [];
  level.var_1676 = [];
  level.var_105E9 = [];
}

func_105B5(var_0, var_1, var_2) {
  func_1057D(var_1);
  var_1.var_10574 = var_0;
  var_1 scripts\mp\powers::func_D729();
  func_10580(var_0);

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_1 func_0BD3::func_D31A(var_0, undefined, var_2);
  var_0.owner = var_1;
  func_10585(var_0, var_1);
  func_105DE(var_0, 1500, 1500 - var_0.damagetaken);
  thread func_105A5(var_0, var_1);
  thread func_1059F(var_0, var_1);
  var_0 notify("playerEnter");
}

func_105B6(var_0, var_1) {
  var_1 scripts\mp\powers::func_D72F();
  var_1 func_0BD3::func_D05B();
  var_1 getrigindexfromarchetyperef();
  func_105CD(var_0);
  var_0.owner = undefined;
  var_1.var_10574 = undefined;
  var_1.var_105E8 = gettime();
  var_1.var_A9F2 = var_0;
  thread func_105A6(var_0);
}

func_10585(var_0, var_1) {
  level.var_1676 = scripts\engine\utility::array_add(level.var_1676, var_0);
  thread func_1059E(var_0, var_1);
  thread func_105A3(var_0, var_1);
  thread func_105A2(var_0, var_1);
  thread func_105BA(var_0, var_1);
}

func_1057E(var_0) {
  level.var_1676 = scripts\engine\utility::array_remove(level.var_1676, var_0);
  func_105CE(var_0);
}

func_1057C(var_0) {
  if(isDefined(var_0.var_130F2)) {
    var_0.var_130F2 delete();
    var_0.useobject scripts\mp\gameobjects::deleteuseobject();
  }

  func_105C0(var_0);
}

func_1057F(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::waittill_any_in_array_return_no_endon_death(var_2);
  var_1 delete();
}

func_105C3() {
  if(!isDefined(level.var_105BB)) {
    level.var_105BB = scripts\engine\utility::getstruct("player_safe_zone", "targetname");
    level.var_105BB.origin = (0, 0, 0);
  }

  return level.var_105BB;
}

func_105A6(var_0) {
  var_0 endon("death");
  var_0 endon("playerReserved");
  level endon("game_ended");
  var_0 scripts\engine\utility::waittill_any_timeout(20, "spaceshipTimeout");

  while(gettime() - var_0.lastdamagetime < 5000) {
    wait 0.25;
  }

  playFX(scripts\engine\utility::getfx("spaceship_remove"), var_0.origin);
  func_1057C(var_0);
  func_1057B();
}

func_1059E(var_0, var_1) {
  var_1 endon("exit_jackal");
  var_0 endon("death");
  var_1 endon("disconnect");

  if(!isai(var_1)) {
    var_1 notifyonplayercommand("ads_on", "+speed_throw");
    var_1 notifyonplayercommand("ads_off", "-speed_throw");
  }

  var_2 = 0;

  for(;;) {
    var_1 waittill("ads_on");
    var_1 playlocalsound("jackal_hud_ads_on");
    var_1 waittill("ads_off");
    var_1 playlocalsound("jackal_hud_ads_off");
  }
}

func_105CE(var_0) {
  if(isDefined(var_0) && isDefined(var_0.outlineids)) {
    foreach(var_2 in var_0.outlineids) {
      scripts\mp\utility\game::outlinedisable(var_2, var_0);
    }

    var_0.outlineids = undefined;
  }

  func_105DF(var_0, undefined, var_0.var_90E1);
  func_105DF(var_0, undefined, var_0.var_2CCB);
}

func_105A3(var_0, var_1) {
  var_1 endon("exit_jackal");
  var_0 endon("death");
  var_1 endon("disconnect");
  scripts\engine\utility::waitframe();
  func_10575(var_0, var_1);
  var_0.outlineids = [];

  if(level.teambased) {
    var_0.outlineids[0] = ::scripts\mp\utility\game::outlineenableforteam(var_0, "cyan", var_1.team, 1, 0, "equipment");
    var_0.outlineids[1] = ::scripts\mp\utility\game::outlineenableforteam(var_0, "orange", scripts\mp\utility\game::getotherteam(var_1.team), 1, 0, "equipment");
  } else
    var_0.outlineids[0] = ::scripts\mp\utility\game::func_C793(var_0, "orange", 1, 0, "equipment");

  var_0 hudoutlinedisableforclient(var_1);
  func_10575(var_0, var_1);
  var_2 = [];
  var_2["tag_engine_left"] = "spaceship_engine_idle";
  var_2["tag_engine_right"] = "spaceship_engine_idle";
  var_2["tag_vtol_frontrightbottom"] = "spaceship_hover";
  var_2["tag_vtol_frontleftbottom"] = "spaceship_hover";
  var_2["tag_vtol_frontcenterbottom"] = "spaceship_hover";
  var_3 = [];
  var_3["tag_engine_left"] = "spaceship_engine_max";
  var_3["tag_engine_right"] = "spaceship_engine_max";
  var_0.var_90E1 = var_2;
  var_0.var_2CCB = var_3;

  for(;;) {
    func_105DF(var_0, var_2, var_3);
    var_1 waittill("engage boost");
    func_105DF(var_0, var_3, var_2);
    var_1 waittill("disengage boost");
  }
}

func_105DF(var_0, var_1, var_2, var_3) {
  var_0 endon("death");

  while(isDefined(var_0.var_12F6B) && var_0.var_12F6B) {
    scripts\engine\utility::waitframe();
  }

  if(!isDefined(var_0)) {
    return;
  }
  var_0.var_12F6B = 1;

  if(isDefined(var_2) && var_2.size > 0) {
    foreach(var_6, var_5 in var_2) {
      stopFXOnTag(scripts\engine\utility::getfx(var_5), var_0, var_6);
      scripts\engine\utility::waitframe();
    }
  }

  if(isDefined(var_1) && var_1.size > 0) {
    foreach(var_6, var_5 in var_1) {
      if(isDefined(var_3)) {
        playfxontagforclients(scripts\engine\utility::getfx(var_5), var_0, var_6, var_3);
      } else {
        playFXOnTag(scripts\engine\utility::getfx(var_5), var_0, var_6);
      }

      scripts\engine\utility::waitframe();
    }
  }

  var_0.var_12F6B = undefined;
}

func_10575(var_0, var_1) {
  var_2 = [];
  var_2["tag_enginebottom_right"] = "spaceship_trail_f";
  var_2["tag_enginebottom_left"] = "spaceship_trail_f";
  var_3 = [];
  var_3["tag_enginebottom_right"] = "spaceship_trail_e";
  var_3["tag_enginebottom_left"] = "spaceship_trail_e";

  foreach(var_5 in level.var_1676) {
    if(!isDefined(var_5)) {
      continue;
    }
    if(var_5 == var_0) {
      continue;
    }
    if(!isDefined(var_5.owner)) {
      continue;
    }
    if(!level.teambased || var_1.team != var_5.owner.team) {
      thread func_105DF(var_5, var_3, undefined, var_1);
      thread func_105DF(var_0, var_3, undefined, var_5.owner);
      continue;
    }

    thread func_105DF(var_5, var_2, undefined, var_1);
    thread func_105DF(var_0, var_2, undefined, var_5.owner);
  }
}

func_105A2(var_0, var_1) {
  var_0 endon("death");
  var_1 endon("exit_jackal");
  level endon("game_ended");
  var_1 waittill("disconnect");
  func_1057E(var_0);
  func_1057C(var_0);
  func_1057B();
}

func_1057B() {
  level.var_1676 = scripts\engine\utility::array_removeundefined(level.var_1676);
  level.var_105EA = scripts\engine\utility::array_removeundefined(level.var_105EA);
  var_0 = [];

  foreach(var_3, var_2 in level.var_105E9) {
    if(isDefined(var_2)) {
      var_0[var_3] = var_2;
    }
  }

  level.var_105E9 = var_0;
}

func_105A1(var_0) {
  level endon("game_ended");
  var_1 = var_0.var_10483;
  var_2 = var_0.team;
  var_3 = var_0.owner;
  var_0 scripts\engine\utility::waittill_any("death", "spaceship_crashing");
  func_1057E(var_0);
  func_1057C(var_0);
  func_1057B();

  if(isDefined(var_1) && !level.var_A407.var_10DBB) {
    wait 2.0;
    func_105CB(var_1, var_2);
  }
}

func_105A0(var_0) {
  var_0 endon("spaceship_crashing");
  level endon("game_ended");
  var_0.var_10586 = 1500;
  var_0.lastdamagetime = 0;
  var_0 scripts\mp\damage::monitordamage(1500, "", ::func_105AA, ::func_105A9, 0, 1);
}

func_105A9(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self;

  if(scripts\mp\utility\game::isstrstart(var_1, "spaceship")) {
    playFXOnTag(scripts\engine\utility::getfx("spaceship_dmg"), var_5, "tag_origin");
  }

  var_5.lastdamagetime = gettime();

  if(isDefined(var_5.owner)) {
    var_6 = var_5.maxhealth - var_5.damagetaken;
    var_7 = var_6 - var_3;
    func_105DE(var_5, var_6, var_7);
    thread func_10587(var_5);

    if(isDefined(var_0.owner)) {
      var_0 = var_0.owner;
    }
  }

  return var_3;
}

func_105A5(var_0, var_1) {
  self endon("disconnect");
  var_1 endon("exit_jackal");
  level endon("game_ended");
  var_1 waittill("death");

  if(isDefined(var_1.var_10574) && var_1.var_10574 == var_0) {
    level.var_105EA = scripts\engine\utility::array_remove(level.var_105EA, var_0);
    level.var_105E9[var_0 getentitynumber()] = undefined;
    level.var_1676 = scripts\engine\utility::array_remove(level.var_1676, var_0);
    var_0 getrandomarmkillstreak(var_0.health + 1, var_0.origin, var_1, undefined, "MOD_EXPLOSIVE");
    thread func_105B6(var_0, var_1);
  }
}

func_1059F(var_0, var_1) {
  self endon("disconnect");
  var_1 endon("exit_jackal");
  var_0 endon("spaceship_crashing");
  level endon("game_ended");
  var_2 = 100;
  var_3 = 700;
  var_4 = 50;
  var_5 = 200;
  var_6 = 440;

  for(;;) {
    var_0 waittill("spaceship_collision", var_7, var_8, var_9, var_10);
    var_11 = var_1 getnormalizedmovement();
    var_12 = (var_11[0] + 1) / 2;
    var_13 = var_5 + (var_6 - var_5) * var_12;
    var_14 = (var_8 - var_4) / (var_13 - var_4);

    if(var_14 > 1.0) {
      var_14 = 1.0;
    } else if(var_14 < 0.0) {
      var_14 = 0.0;
    }

    var_15 = var_14 * var_7;

    if(var_15 > 0) {
      var_16 = var_2 + (var_3 - var_2) * var_15;
      var_0 getrandomarmkillstreak(var_16, var_10, var_1, var_1, "MOD_IMPACT");
    }
  }
}

func_10587(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 notify("healthRegen");
  var_0 endon("healthRegen");
  wait 5;
  var_1 = 18.75;

  while(var_0.damagetaken > 0) {
    var_2 = 1500 - var_0.damagetaken;
    var_0.damagetaken = var_0.damagetaken - var_1;

    if(var_0.damagetaken < 0) {
      var_0.damagetaken = 0;
    }

    var_3 = 1500 - var_0.damagetaken;
    func_105DE(var_0, var_2, var_3);
    scripts\engine\utility::waitframe();
  }

  func_105CD(var_0);
}

func_105DE(var_0, var_1, var_2) {
  if(!isDefined(var_0.owner)) {
    return;
  }
  if(var_2 < var_1) {
    if(var_2 < 495.0 && var_1 >= 495.0) {
      func_105CD(var_0);
      var_0.var_FE12 = scripts\engine\utility::getfx("cockpit_fire");
      playfxontagforclients(var_0.var_FE12, var_0, "j_stickleft", var_0.owner);
      var_3 = [];
      var_3["tag_thrust_rear1"] = "spaceship_dmg_trail";
      func_105DF(var_0, var_3);
    } else if(var_2 < 990.0 && var_1 >= 990.0) {
      var_0.var_FE12 = scripts\engine\utility::getfx("cockpit_smoke");
      playfxontagforclients(var_0.var_FE12, var_0, "j_stickleft", var_0.owner);
    } else
      playfxontagforclients(scripts\engine\utility::getfx("cockpit_sparks"), var_0, "j_stickleft", var_0.owner);
  } else if(var_2 >= 990.0 && var_1 < 990.0)
    func_105CD(var_0);
  else if(var_2 >= 495.0 && var_1 < 495.0) {
    func_105CD(var_0);
    var_0.var_FE12 = scripts\engine\utility::getfx("cockpit_smoke");
    playfxontagforclients(var_0.var_FE12, var_0, "j_stickleft", var_0.owner);
    var_3 = [];
    var_3["tag_thrust_rear1"] = "spaceship_dmg_trail";
    func_105DF(var_0, [], var_3);
  }
}

func_105CD(var_0) {
  if(isDefined(var_0.var_FE12)) {
    stopFXOnTag(var_0.var_FE12, var_0, "j_stickleft");
    var_0.var_FE12 = undefined;
  }
}

func_105AA(var_0, var_1, var_2, var_3) {
  var_4 = self;

  if(isDefined(var_0.owner)) {
    var_0 = var_0.owner;
  }

  if(isDefined(var_4.var_FE12)) {
    func_105CD(var_4);
  }

  var_4 playSound(level.var_105C8["explode"]);
  playFX(scripts\engine\utility::getfx("spaceship_death"), var_4.origin, anglesToForward(var_4.angles), anglestoup(var_4.angles));

  if(isDefined(var_4.owner)) {
    var_4.owner getrandomarmkillstreak(var_4.health + 1, var_4.owner.origin, var_0, undefined, var_2);
  }

  var_4 notify("spaceship_crashing");
}

func_105BF(var_0) {
  level.var_105EA = scripts\engine\utility::array_add(level.var_105EA, var_0);
  level.var_105E9[var_0 getentitynumber()] = var_0;
}

func_105C0(var_0) {
  if(isDefined(var_0)) {
    level.var_105EA = scripts\engine\utility::array_remove(level.var_105EA, var_0);
    level.var_105E9[var_0 getentitynumber()] = undefined;
    var_0 delete();
  }
}

func_105A4(var_0) {
  var_0 notify("monitorMissileFire");
  var_0 endon("monitorMissileFire");
  var_0 endon("spaceship_crashing");
  var_0 endon("death");

  for(;;) {
    var_0 waittill("missile_fire", var_1, var_2);

    if(var_2 != "spaceship_assault_mp" && var_2 != "spaceship_strike_mp") {
      continue;
    }
    var_1.var_105E6 = var_1.origin;
  }
}

func_3758(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(var_4 != "MOD_IMPACT") {
    if(!isDefined(var_0) || !isDefined(var_0.var_105E6)) {
      return var_2;
    }

    if(var_5 != "spaceship_assault_mp" && var_5 != "spaceship_strike_mp") {
      return var_2;
    }
  }

  if(var_5 == "spaceship_strike_mp") {
    var_12 = var_0;
    var_13 = distance(var_12.origin, var_12.var_105E6);

    if(var_13 < 10000) {
      var_2 = var_2 * 1.0;
    } else if(var_13 < 30000) {
      var_2 = var_2 * 0.5;
    } else {
      var_2 = var_2 * 0.25;
    }
  }

  var_2 = int(max(var_2, 1));
  self vehicle_finishdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);
}

func_105E2() {
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", var_0);

    if(level.var_A407.var_1C91) {
      thread func_105B8(var_0);
    }

    if(level.var_A407.var_10DBB) {
      level thread func_105B1(var_0);
    }
  }
}

func_105B1(var_0) {
  var_0 endon("death");
  var_0 endon("disconnect");

  for(;;) {
    var_1 = func_105C4(var_0.team);
    var_2 = func_105CB(var_1, var_0.team);

    if(isDefined(var_2)) {
      break;
    }
    scripts\engine\utility::waitframe();
  }

  var_0 setplayerangles(var_1.angles);
  var_2 vehicle_teleport(var_2.origin, var_1.angles);
  scripts\engine\utility::waitframe();
  func_105B5(var_2, var_0, 1);
}

func_105CB(var_0, var_1) {
  var_2 = var_0 global_physics_sound_monitor();

  if(!isDefined(var_2)) {
    return undefined;
  }

  var_2.var_10483 = var_0;
  return func_1058D(var_2, var_1);
}

func_105C4(var_0) {
  var_1 = level.var_FE33[var_0];
  var_1 = scripts\engine\utility::array_combine(var_1, level.var_FE33[scripts\mp\utility\game::getotherteam(var_0)]);
  var_2 = undefined;
  var_3 = 0;

  foreach(var_5 in var_1) {
    if(!func_10595(var_5)) {
      continue;
    }
    var_6 = 0;

    foreach(var_8 in level.var_1676) {
      if(isDefined(var_8) && isDefined(var_8.owner) && isDefined(var_8.owner.team) && var_8.owner.team != var_0) {
        var_9 = distancesquared(var_8.origin, var_5.origin);

        if(!isDefined(var_6) || var_9 > var_6) {
          var_6 = var_9;
        }
      }
    }

    if(!isDefined(var_2) || var_6 > var_3) {
      var_3 = var_6;
      var_2 = var_5;
    }
  }

  if(!isDefined(var_2)) {
    var_2 = var_1[randomint(var_1.size)];
  }

  return var_2;
}

func_10595(var_0) {
  if(isDefined(var_0.var_11931) && var_0.var_11931 - gettime() < 3000) {
    return 0;
  }

  foreach(var_2 in level.var_1676) {
    if(!isDefined(var_2)) {
      continue;
    }
    if(distancesquared(var_2.origin, var_0.origin) <= 1600) {
      return 0;
    }
  }

  var_4 = physics_createcontents(["physicscontents_aiavoid", "physicscontents_solid", "physicscontents_structural"]);
  var_5 = physics_getclosestpointtosphere(var_0.origin, 300, 0, var_4, undefined, "physicsquery_any");
  return var_5 == 0;
}

func_105CA(var_0, var_1, var_2) {
  var_3 = _func_26D(var_0, var_1, var_2, "veh_spaceship_mp", "veh_mil_air_ca_jackal_drone_atmos_periph_mp");
  return func_1058D(var_3, var_0.team);
}

func_1058D(var_0, var_1) {
  var_0.team = var_1;
  var_0.var_13CC3 = [];
  var_0.var_13CC3["hover"] = "spaceship_assault_mp";
  var_0.var_13CC3["fly"] = "spaceship_strike_mp";
  var_0.var_13CC3["land"] = var_0.var_13CC3["hover"];
  func_105BF(var_0);
  var_0 _meth_84BC(level.var_A407.var_1051B);
  var_0 _meth_84BE("spaceship");
  thread func_105A1(var_0);
  thread func_105A0(var_0);
  thread func_105A4(var_0);
  var_0.damagecallback = ::func_3758;
  return var_0;
}

func_105C5(var_0, var_1) {
  var_2 = undefined;
  var_2 = spawn("trigger_radius", func_10578(var_0), 0, 150, 200);
  var_0.var_130F2 = var_2;
  var_3 = scripts\mp\gameobjects::createuseobject(var_1, var_2, []);
  var_3 scripts\mp\gameobjects::setusetime(2);
  var_3 scripts\mp\gameobjects::setusetext(&"MP_JACKAL_BOARDING");

  if(var_2.classname == "trigger_use") {
    var_3 scripts\mp\gameobjects::setusehinttext(&"MP_JACKAL_BOARD");
  }

  var_3 scripts\mp\gameobjects::allowuse("friendly");
  var_3 scripts\mp\gameobjects::setvisibleteam("friendly");
  var_3.onuse = ::func_105B3;
  var_3.var_10574 = var_0;
  var_0.useobject = var_3;
}

func_105B3(var_0) {
  var_1 = self.var_10574;

  if(!isDefined(var_1)) {
    return;
  }
  func_105B5(var_1, var_0);
}

func_10580(var_0) {
  if(isDefined(var_0.useobject)) {
    var_0.useobject scripts\mp\gameobjects::setvisibleteam("none");
    var_0.useobject scripts\mp\gameobjects::allowuse("none");
  }
}

func_10583(var_0) {
  if(isDefined(var_0.useobject)) {
    var_0.useobject scripts\mp\gameobjects::setvisibleteam("friendly");
    var_0.useobject scripts\mp\gameobjects::allowuse("friendly");
    var_0.useobject.trigger.origin = func_10578(var_0);
  }
}

func_105E1(var_0, var_1) {
  var_1 endon("death");
  var_1 endon("disconnect");
  level endon("game_ended");

  if(!isai(var_1)) {
    var_1 notifyonplayercommand("exitJackal", "+actionslot 2");
  }

  while(isDefined(var_0.owner)) {
    var_1 waittill("exitJackal");

    if(func_10579(var_0, var_1)) {
      thread func_10581(var_0, var_1);
    }
  }
}

func_10579(var_0, var_1) {
  if(level.var_A407.allowgrenadedamage) {
    if(isDefined(var_0.var_A83C)) {
      if(!isDefined(var_0.var_A83C.team) || var_0.var_A83C.team == var_1.team) {
        var_1 iprintlnbold(&"MP_JACKAL_CANT_LAND");
        return 0;
      }
    }

    return 1;
  } else if(!func_10591(var_0)) {
    var_1 iprintlnbold(&"MP_JACKAL_CANT_LAND");
    return 0;
  }

  return 1;
}

func_10581(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0 endon("death");
  var_3 = func_10584(var_0, var_1);

  if(!isDefined(var_3)) {
    var_1 iprintlnbold(&"MP_JACKAL_CANT_LAND");
    return;
  }

  var_1 setorigin(var_3);
  var_1 setplayerangles(var_0.angles);
  func_105B6(var_0, var_1);
  thread func_1057E(var_0);

  if(isDefined(var_2)) {
    func_105B7(var_1, var_2.origin, var_2.angles);
  }
}

func_10578(var_0) {
  return var_0 gettagorigin("j_cockpit") - (0, 0, 100);
}

func_10584(var_0, var_1) {
  var_2 = anglestoright(var_0.angles);
  var_3 = scripts\engine\trace::create_default_contents(1);
  var_4 = var_0 gettagorigin("j_cockpit");
  var_5 = var_4 - 64 * var_2;
  var_6 = physics_getclosestpointtocharacter(var_5, var_1, 0, var_0.angles, 0, var_3, var_0, "physicsquery_any");

  if(var_6 == 0) {
    return var_5;
  }

  var_5 = var_4 + 64 * var_2;
  var_6 = physics_getclosestpointtocharacter(var_5, var_1, 0, var_0.angles, 0, var_3, var_0, "physicsquery_any");

  if(var_6 == 0) {
    return var_5;
  }

  var_7 = anglesToForward(var_0.angles);
  var_5 = var_4 + 100 * var_7;
  var_6 = physics_getclosestpointtocharacter(var_5, var_1, 0, var_0.angles, 0, var_3, var_0, "physicsquery_any");

  if(var_6 == 0) {
    return var_5;
  }

  return undefined;
}

func_105B8(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("disconnect");

  if(!scripts\mp\utility\game::gameflag("prematch_done")) {
    level waittill("prematch_done");
  }

  thread func_105A7(var_0);

  for(;;) {
    var_0 waittill("useSpaceship");

    if(isDefined(var_0.var_A40D)) {
      continue;
    }
    if(isDefined(var_0.var_10574)) {
      if(func_10579(var_0.var_10574, var_0)) {
        func_10581(var_0.var_10574, var_0);
      } else {
        var_0 iprintlnbold(&"MP_JACKAL_CANT_LAND");
      }

      continue;
    }

    if(!isDefined(var_0.var_A40D)) {
      var_1 = func_10593(var_0);

      if(isDefined(var_1)) {
        func_10576(var_1, var_0);
      } else if(func_1057A(var_0)) {
        func_105CF(var_0);
      }
    }
  }
}

func_105A7(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 endon("disconnect");

  if(!isai(var_0)) {
    var_0 notifyonplayercommand("useButton", "+usereload");
  }

  for(;;) {
    var_0 waittill("useButton");
    var_1 = 0.0001;
    var_0 setclientomnvar("ui_securing", 8);
    var_0 setclientomnvar("ui_securing_progress", var_1);

    while(var_0 usebuttonpressed()) {
      scripts\engine\utility::waitframe();
      var_1 = var_1 + 0.0666667;

      if(var_1 > 1.0) {
        var_1 = 1.0;
      }

      var_0 setclientomnvar("ui_securing_progress", var_1);

      if(var_1 == 1.0) {
        var_0 setclientomnvar("ui_securing", 0);
        var_0 notify("useSpaceship");
        wait 0.25;
        var_1 = 0;
      }
    }

    var_0 setclientomnvar("ui_securing", 0);
  }
}

func_10593(var_0) {
  var_1 = var_0 getEye();
  var_2 = var_0 getplayerangles();
  var_3 = var_1 + 750 * anglesToForward(var_2);
  var_4 = physics_spherecast(var_1, var_3, 15, scripts\engine\trace::create_vehicle_contents(), undefined, "physicsquery_closest");

  if(var_4.size == 0) {
    return undefined;
  }

  var_5 = var_4[0]["entity"];

  if(!func_10592(var_5)) {
    return undefined;
  }

  if(isDefined(var_5.owner)) {
    return undefined;
  }

  return var_5;
}

func_1058B(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  if(var_1.size > 0) {
    level.var_A841 = var_1;

    foreach(var_3 in var_1) {
      func_105E3(var_3);

      if(var_3.var_2699) {
        thread func_105E5(var_3, ::func_105AC, ::func_105B2, ::func_105AF);
      }
    }
  }
}

func_1058A(var_0) {
  var_1 = getEntArray(var_0, "targetname");
  level.var_A83D = var_1;

  if(var_1.size > 0) {
    foreach(var_3 in var_1) {
      func_105E3(var_3);
      thread func_105E5(var_3, ::func_105AB, undefined, ::func_105AE);
    }
  }
}

func_10591(var_0) {
  if(isDefined(level.var_A841)) {
    foreach(var_2 in level.var_A841) {
      if((!isDefined(var_2.team) || var_2.team == var_0.owner.team) && var_0 istouching(var_2)) {
        return 1;
      }
    }

    return 0;
  } else
    return 1;
}

func_105AC(var_0, var_1) {
  var_0.owner forceusehinton(&"MP_JACKAL_EXIT");
}

func_105B2(var_0, var_1, var_2) {
  if(gettime() - var_2 >= 2000) {
    var_3 = var_0 getentitynumber();
    var_1.var_A41D[var_3] = undefined;
    var_1.var_A41E[var_3] = undefined;
    var_4 = var_0.owner;

    if(func_10579(var_0, var_4)) {
      var_5 = func_10596(var_1, var_4);
      thread func_10581(var_0, var_4, var_5);
    }
  }
}

func_105AF(var_0, var_1) {
  if(isDefined(var_0.owner)) {
    var_0.owner getrigindexfromarchetyperef();
  }
}

func_105AB(var_0, var_1) {
  var_0.var_A83C = var_1;
}

func_105AE(var_0, var_1) {
  var_0.var_A83C = undefined;
}

func_10596(var_0, var_1) {
  if(isDefined(var_0.var_D42C)) {
    var_2 = var_1 physics_getcharactercollisioncapsule();
    var_3 = var_2["radius"];
    var_4 = var_2["half_height"];

    foreach(var_6 in var_0.var_D42C) {
      if(isDefined(var_6.var_AA3B) && gettime() - var_6.var_AA3B < 10000) {
        continue;
      }
      if(capsuletracepassed(var_6.origin + (0, 0, var_4), var_3, var_4, var_1, 0, 1)) {
        var_6.var_AA3B = gettime();
        return var_6;
      }
    }
  }

  return undefined;
}

func_10590(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  if(var_1.size > 0) {
    level.var_105ED = var_1;

    foreach(var_3 in var_1) {
      func_105E3(var_3);
    }
  }
}

func_1058F(var_0) {
  var_1 = getEntArray(var_0, "targetname");
  level.var_105EC = var_1;

  if(var_1.size > 0) {
    foreach(var_3 in var_1) {
      func_105E3(var_3);
    }
  }
}

func_1057A(var_0) {
  if(var_0 ismantling() || var_0 isonladder()) {
    var_0 iprintlnbold(&"MP_JACKAL_CANT_SUMMON");
    return 0;
  }

  if(isDefined(var_0.var_105E8) && gettime() - var_0.var_105E8 < 1000) {
    return 0;
  }

  if(level.var_A407.allowhide) {
    foreach(var_2 in level.var_105EC) {
      if(var_0 istouching(var_2)) {
        var_0 iprintlnbold(&"MP_JACKAL_CANT_SUMMON");
        return 0;
      }
    }

    return 1;
  } else if(isDefined(level.var_105ED)) {
    foreach(var_2 in level.var_105ED) {
      if(func_105DD(var_2, var_0)) {
        return 1;
      }
    }
  }

  var_0 iprintlnbold(&"MP_JACKAL_CANT_SUMMON");
  return 0;
}

func_105DD(var_0, var_1) {
  if(isDefined(var_0.team) && var_0.team != var_1.team) {
    return 0;
  }

  return var_1 istouching(var_0);
}

func_105CF(var_0) {
  var_1 = var_0 getEye();
  var_2 = anglesToForward(var_0 getplayerangles());
  var_3 = var_1 + 500 * var_2;
  var_4 = physics_createcontents(["physicscontents_aiavoid", "physicscontents_solid", "physicscontents_structural"]);
  var_5 = physics_charactercast(var_1, var_3, var_0, 0, var_0.angles, var_4, var_0, "physicsquery_any");

  if(var_5) {
    var_0 iprintlnbold(&"MP_JACKAL_CANT_SUMMON");
    return;
  }

  var_6 = 332 * anglestoright(var_0.angles);
  var_7 = var_3 + var_6;
  var_8 = 350;
  var_5 = physics_getclosestpointtosphere(var_7, var_8, 0, var_4, undefined, "physicsquery_any");

  if(var_5) {
    var_7 = var_7 + (0, 0, var_8 + 1);
    var_5 = physics_getclosestpointtosphere(var_7, var_8, 0, var_4, undefined, "physicsquery_any");

    if(var_5) {
      var_0 iprintlnbold(&"MP_JACKAL_CANT_SUMMON");
      return;
    }
  }

  var_9 = func_105CA(var_0, var_7, var_0.angles);
  func_105B7(var_0, var_3, var_0.angles, 0.25);
  func_105B5(var_9, var_0);
}

func_10576(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("death");
  var_1 endon("disconnect");
  var_2 = vectornormalize(var_1.origin - var_0.origin);
  var_3 = anglestoright(var_0.angles);
  var_4 = vectordot(var_2, var_3) > 0;

  if(!var_4) {
    var_3 = -1 * var_3;
  }

  var_5 = var_0 gettagorigin("j_cockpit");
  var_6 = var_5 + 64 * var_3;
  var_0 notify("playerReserved");
  func_105B7(var_1, var_6, var_1.angles);

  if(isDefined(var_0)) {
    func_105B5(var_0, var_1);
  }
}

func_105B7(var_0, var_1, var_2, var_3) {
  level endon("game_ended");

  if(!isDefined(var_3)) {
    var_3 = 0.375;
  }

  var_4 = spawn("script_model", var_0.origin);
  var_4.angles = var_0.angles;
  var_4 setModel("tag_origin");
  var_0.var_A40D = 1;
  var_0 getweaponvariantattachments(var_4, "tag_origin");
  var_5 = var_0 setcontents(0);
  var_4 moveto(var_1, var_3, 0, 0);
  var_4 rotateto(var_2, 0.25 * var_3, 0.05 * var_3, 0);
  wait(var_3);

  if(isDefined(var_0)) {
    var_0 setcontents(var_5);
    var_0 unlink();
    var_0.var_A40D = undefined;
  }

  var_4 delete();
}

func_1057D(var_0) {
  var_1 = var_0.var_A9F2;
  var_0.var_A9F2 = undefined;

  if(isDefined(var_1) && !isDefined(var_1.owner)) {
    var_1 notify("spaceshipTimeout");
  }
}

func_1058E(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  if(var_1.size > 0) {
    level.var_105EB = var_1;

    foreach(var_3 in var_1) {
      func_105E3(var_3);

      if(!isDefined(var_3.var_B4C9)) {
        var_3.var_B4C9 = 0.5;
      }

      thread func_105E5(var_3, ::func_105AD, undefined, ::func_105B0);
    }
  }
}

func_105AD(var_0, var_1) {
  if(isDefined(var_0.owner)) {
    var_0 _meth_8476(var_1.var_B4C9);
  }
}

func_105B0(var_0, var_1) {
  if(isDefined(var_0.owner)) {
    var_0 _meth_8476(1.0);
  }
}

func_105E5(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_0 endon("disable");
  var_0.var_A41D = [];
  var_0.var_A41E = [];
  thread func_105E4(var_0, var_2, var_3);

  for(;;) {
    var_0 waittill("trigger", var_4);

    if(!func_10594(var_4, var_0)) {
      continue;
    }
    var_5 = var_4 getentitynumber();
    var_0.var_A41E[var_5] = var_4;

    if(!isDefined(var_0.var_A41D[var_5])) {
      var_0.var_A41D[var_5] = gettime();

      if(isDefined(var_1)) {
        [[var_1]](var_4, var_0);
      }
    }
  }
}

func_105E4(var_0, var_1, var_2) {
  level endon("game_ended");
  var_0 endon("disable");

  for(;;) {
    wait 0.05;
    waittillframeend;

    foreach(var_6, var_4 in var_0.var_A41D) {
      var_5 = level.var_105E9[var_6];

      if(!isDefined(var_0.var_A41E[var_6])) {
        var_0.var_A41D[var_6] = undefined;

        if(isDefined(var_5) && isDefined(var_2)) {
          [
            [var_2]
          ](var_5, var_0);
        }

        continue;
      }

      if(isDefined(var_1)) {
        [[var_1]](var_5, var_0, var_4);
      }
    }

    var_0.var_A41E = [];
  }
}

func_105E3(var_0) {
  var_0.var_2699 = 0;

  if(!isDefined(var_0.script_noteworthy)) {
    return;
  }
  var_1 = strtok(var_0.script_noteworthy, ",");

  foreach(var_3 in var_1) {
    var_4 = strtok(var_3, "=");

    switch (var_4[0]) {
      case "team":
        var_0.team = var_4[1];
        break;
      case "playerStarts":
      case "spawnpoints":
        var_0.var_D42C = scripts\engine\utility::getstructarray(var_4[1], "targetname");
        break;
      case "jackalStarts":
        var_0.var_A422 = scripts\engine\utility::getstructarray(var_4[1], "targetname");
        break;
      case "autouse":
        var_0.var_2699 = var_4[1] == "true";
        break;
      case "spawners":
        var_0.var_10879 = var_4[1];
        break;
      case "maxSpeed":
        var_0.var_B4C9 = float(var_4[1]);
      default:
        break;
    }
  }
}

func_10594(var_0, var_1) {
  if(!func_10592(var_0)) {
    return 0;
  }

  if(!isDefined(var_0.owner)) {
    return 0;
  }

  if(isDefined(var_1.team) && var_1.team != var_0.team) {
    return 0;
  }

  return 1;
}

func_105B9(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnfxforclient(scripts\engine\utility::getfx(var_2), var_1 getEye() + var_3, var_1);
  triggerfx(var_5);
  var_1 scripts\engine\utility::waittill_any_timeout(var_4, "death", "disconnect");
  var_5 delete();
}

func_105BA(var_0, var_1) {
  var_0 endon("death");
  var_1 endon("exit_jackal");
  var_1 endon("disconnect");
  level endon("game_ended");

  for(;;) {
    var_2 = var_0 vehicle_getvelocity();
    var_3 = lengthsquared(var_2);

    if(var_3 < 100) {
      var_4 = anglesToForward(var_0.angles);
      thread func_105B9(var_0, var_1, "space_particles", var_4 * 300, 3.0);
      wait 0.75;
      continue;
    }

    var_4 = vectornormalize(var_2);
    thread func_105B9(var_0, var_1, "space_particles", var_4 * 256, 1.0);
    wait 0.1;
  }
}

func_10592(var_0) {
  return var_0.classname == "script_vehicle_jackal_mp" || var_0.classname == "script_vehicle" && var_0.model == "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
}

func_105C1(var_0) {
  var_0 scripts\mp\powers::removepower(var_0.var_AE7B);
  var_0 scripts\mp\powers::removepower(var_0.var_AE7D);
}

func_105C2(var_0) {
  var_0 scripts\mp\powers::givepower(var_0.var_AE7B, "primary");
  var_0 scripts\mp\powers::givepower(var_0.var_AE7D, "secondary");
}