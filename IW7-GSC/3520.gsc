/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3520.gsc
***************************************/

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
  level.func_105C8["explode"] = "exp_helicopter_fuel";
}

func_10588(var_00) {
  func_105BC();
  level.func_A407 = var_00;
  var_0.func_1051B = isDefined(var_0.func_1051B) && var_0.func_1051B;
  thread func_1058C();
  var_0.allowgrenadedamage = !isDefined(var_0.allowgrenadedamage) || var_0.allowgrenadedamage;

  if(var_0.allowgrenadedamage) {
    func_1058A("landingExclusionZone");
  }
  else {
    func_1058B("landingzone");
  }

  var_0.allowhide = !isDefined(var_0.allowhide) || var_0.allowhide;

  if(var_0.allowhide) {
    func_1058F("summonExclusionZone");
  }
  else {
    func_10590("spaceship_summon_trigger");
  }

  if(!isDefined(var_0.alliesspawnareas)) {
    var_0.alliesspawnareas = "spaceship_spawner_allies";
  }

  if(!isDefined(var_0.func_26FB)) {
    var_0.func_26FB = "spaceship_spawner_axis";
  }

  level.func_FE33["axis"] = getEntArray(var_0.func_26FB, "targetname");
  level.func_FE33["allies"] = getEntArray(var_0.alliesspawnareas, "targetname");
  var_0.func_10DBB = isDefined(var_0.func_10DBB) && var_0.func_10DBB;

  if(!var_0.func_10DBB) {
    foreach(var_02 in level.func_FE33["axis"]) {
    func_105CB(var_02, "axis");
    }

    foreach(var_02 in level.func_FE33["allies"]) {
    func_105CB(var_02, "allies");
    }
  }

  var_0.func_1C91 = isDefined(var_0.func_1C91) && var_0.func_1C91;
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
  level.func_105EA = [];
  level.func_1676 = [];
  level.func_105E9 = [];
}

func_105B5(var_00, var_01, var_02) {
  func_1057D(var_01);
  var_1.func_10574 = var_00;
  var_01 scripts\mp\powers::func_D729();
  func_10580(var_00);

  if(!isDefined(var_02)) {
    var_02 = 0;
  }

  var_01 func_0BD3::func_D31A(var_00, undefined, var_02);
  var_0.owner = var_01;
  func_10585(var_00, var_01);
  func_105DE(var_00, 1500, 1500 - var_0.damagetaken);
  thread func_105A5(var_00, var_01);
  thread func_1059F(var_00, var_01);
  var_00 notify("playerEnter");
}

func_105B6(var_00, var_01) {
  var_01 scripts\mp\powers::func_D72F();
  var_01 func_0BD3::func_D05B();
  var_01 getrigindexfromarchetyperef();
  func_105CD(var_00);
  var_0.owner = undefined;
  var_1.func_10574 = undefined;
  var_1.func_105E8 = gettime();
  var_1.func_A9F2 = var_00;
  thread func_105A6(var_00);
}

func_10585(var_00, var_01) {
  level.func_1676 = scripts\engine\utility::array_add(level.func_1676, var_00);
  thread func_1059E(var_00, var_01);
  thread func_105A3(var_00, var_01);
  thread func_105A2(var_00, var_01);
  thread func_105BA(var_00, var_01);
}

func_1057E(var_00) {
  level.func_1676 = scripts\engine\utility::array_remove(level.func_1676, var_00);
  func_105CE(var_00);
}

func_1057C(var_00) {
  if(isDefined(var_0.func_130F2)) {
    var_0.func_130F2 delete();
    var_0.useobject scripts\mp\gameobjects::deleteuseobject();
  }

  func_105C0(var_00);
}

func_1057F(var_00, var_01, var_02) {
  var_00 scripts\engine\utility::waittill_any_in_array_return_no_endon_death(var_02);
  var_01 delete();
}

func_105C3() {
  if(!isDefined(level.func_105BB)) {
    level.func_105BB = scripts\engine\utility::getstruct("player_safe_zone", "targetname");
    level.func_105BB.origin = (0, 0, 0);
  }

  return level.func_105BB;
}

func_105A6(var_00) {
  var_00 endon("death");
  var_00 endon("playerReserved");
  level endon("game_ended");
  var_00 scripts\engine\utility::waittill_any_timeout(20, "spaceshipTimeout");

  while(gettime() - var_0.lastdamagetime < 5000) {
    wait 0.25;
  }

  playFX(scripts\engine\utility::getfx("spaceship_remove"), var_0.origin);
  func_1057C(var_00);
  func_1057B();
}

func_1059E(var_00, var_01) {
  var_01 endon("exit_jackal");
  var_00 endon("death");
  var_01 endon("disconnect");

  if(!isai(var_01)) {
    var_01 notifyonplayercommand("ads_on", "+speed_throw");
    var_01 notifyonplayercommand("ads_off", "-speed_throw");
  }

  var_02 = 0;

  for(;;) {
    var_01 waittill("ads_on");
    var_01 playlocalsound("jackal_hud_ads_on");
    var_01 waittill("ads_off");
    var_01 playlocalsound("jackal_hud_ads_off");
  }
}

func_105CE(var_00) {
  if(isDefined(var_00) && isDefined(var_0.outlineids)) {
    foreach(var_02 in var_0.outlineids) {
    scripts\mp\utility\game::outlinedisable(var_02, var_00);
    }

    var_0.outlineids = undefined;
  }

  func_105DF(var_00, undefined, var_0.func_90E1);
  func_105DF(var_00, undefined, var_0.func_2CCB);
}

func_105A3(var_00, var_01) {
  var_01 endon("exit_jackal");
  var_00 endon("death");
  var_01 endon("disconnect");
  scripts\engine\utility::waitframe();
  func_10575(var_00, var_01);
  var_0.outlineids = [];

  if(level.teambased) {
    var_0.outlineids[0] = ::scripts\mp\utility\game::outlineenableforteam(var_00, "cyan", var_1.team, 1, 0, "equipment");
    var_0.outlineids[1] = ::scripts\mp\utility\game::outlineenableforteam(var_00, "orange", scripts\mp\utility\game::getotherteam(var_1.team), 1, 0, "equipment");
  } else
    var_0.outlineids[0] = ::scripts\mp\utility\game::func_C793(var_00, "orange", 1, 0, "equipment");

  var_00 hudoutlinedisableforclient(var_01);
  func_10575(var_00, var_01);
  var_02 = [];
  var_2["tag_engine_left"] = "spaceship_engine_idle";
  var_2["tag_engine_right"] = "spaceship_engine_idle";
  var_2["tag_vtol_frontrightbottom"] = "spaceship_hover";
  var_2["tag_vtol_frontleftbottom"] = "spaceship_hover";
  var_2["tag_vtol_frontcenterbottom"] = "spaceship_hover";
  var_03 = [];
  var_3["tag_engine_left"] = "spaceship_engine_max";
  var_3["tag_engine_right"] = "spaceship_engine_max";
  var_0.func_90E1 = var_02;
  var_0.func_2CCB = var_03;

  for(;;) {
    func_105DF(var_00, var_02, var_03);
    var_01 waittill("engage boost");
    func_105DF(var_00, var_03, var_02);
    var_01 waittill("disengage boost");
  }
}

func_105DF(var_00, var_01, var_02, var_03) {
  var_00 endon("death");

  while(isDefined(var_0.func_12F6B) && var_0.func_12F6B) {
    scripts\engine\utility::waitframe();
  }

  if(!isDefined(var_00)) {
    return;
  }
  var_0.func_12F6B = 1;

  if(isDefined(var_02) && var_2.size > 0) {
    foreach(var_06, var_05 in var_02) {
      stopFXOnTag(scripts\engine\utility::getfx(var_05), var_00, var_06);
      scripts\engine\utility::waitframe();
    }
  }

  if(isDefined(var_01) && var_1.size > 0) {
    foreach(var_06, var_05 in var_01) {
      if(isDefined(var_03)) {
        playfxontagforclients(scripts\engine\utility::getfx(var_05), var_00, var_06, var_03);
      }
      else {
        playFXOnTag(scripts\engine\utility::getfx(var_05), var_00, var_06);
      }

      scripts\engine\utility::waitframe();
    }
  }

  var_0.func_12F6B = undefined;
}

func_10575(var_00, var_01) {
  var_02 = [];
  var_2["tag_enginebottom_right"] = "spaceship_trail_f";
  var_2["tag_enginebottom_left"] = "spaceship_trail_f";
  var_03 = [];
  var_3["tag_enginebottom_right"] = "spaceship_trail_e";
  var_3["tag_enginebottom_left"] = "spaceship_trail_e";

  foreach(var_05 in level.func_1676) {
    if(!isDefined(var_05)) {
      continue;
    }
    if(var_05 == var_00) {
      continue;
    }
    if(!isDefined(var_5.owner)) {
      continue;
    }
    if(!level.teambased || var_1.team != var_5.owner.team) {
      thread func_105DF(var_05, var_03, undefined, var_01);
      thread func_105DF(var_00, var_03, undefined, var_5.owner);
      continue;
    }

    thread func_105DF(var_05, var_02, undefined, var_01);
    thread func_105DF(var_00, var_02, undefined, var_5.owner);
  }
}

func_105A2(var_00, var_01) {
  var_00 endon("death");
  var_01 endon("exit_jackal");
  level endon("game_ended");
  var_01 waittill("disconnect");
  func_1057E(var_00);
  func_1057C(var_00);
  func_1057B();
}

func_1057B() {
  level.func_1676 = scripts\engine\utility::array_removeundefined(level.func_1676);
  level.func_105EA = scripts\engine\utility::array_removeundefined(level.func_105EA);
  var_00 = [];

  foreach(var_03, var_02 in level.func_105E9) {
    if(isDefined(var_02)) {
      var_0[var_03] = var_02;
    }
  }

  level.func_105E9 = var_00;
}

func_105A1(var_00) {
  level endon("game_ended");
  var_01 = var_0.func_10483;
  var_02 = var_0.team;
  var_03 = var_0.owner;
  var_00 scripts\engine\utility::waittill_any("death", "spaceship_crashing");
  func_1057E(var_00);
  func_1057C(var_00);
  func_1057B();

  if(isDefined(var_01) && !level.func_A407.func_10DBB) {
    wait 2.0;
    func_105CB(var_01, var_02);
  }
}

func_105A0(var_00) {
  var_00 endon("spaceship_crashing");
  level endon("game_ended");
  var_0.func_10586 = 1500;
  var_0.lastdamagetime = 0;
  var_00 scripts\mp\damage::monitordamage(1500, "", ::func_105AA, ::func_105A9, 0, 1);
}

func_105A9(var_00, var_01, var_02, var_03, var_04) {
  var_05 = self;

  if(scripts\mp\utility\game::isstrstart(var_01, "spaceship")) {
    playFXOnTag(scripts\engine\utility::getfx("spaceship_dmg"), var_05, "tag_origin");
  }

  var_5.lastdamagetime = gettime();

  if(isDefined(var_5.owner)) {
    var_06 = var_5.maxhealth - var_5.damagetaken;
    var_07 = var_06 - var_03;
    func_105DE(var_05, var_06, var_07);
    thread func_10587(var_05);

    if(isDefined(var_0.owner)) {
      var_00 = var_0.owner;
    }
  }

  return var_03;
}

func_105A5(var_00, var_01) {
  self endon("disconnect");
  var_01 endon("exit_jackal");
  level endon("game_ended");
  var_01 waittill("death");

  if(isDefined(var_1.func_10574) && var_1.func_10574 == var_00) {
    level.func_105EA = scripts\engine\utility::array_remove(level.func_105EA, var_00);
    level.func_105E9[var_00 getentitynumber()] = undefined;
    level.func_1676 = scripts\engine\utility::array_remove(level.func_1676, var_00);
    var_00 getrandomarmkillstreak(var_0.health + 1, var_0.origin, var_01, undefined, "MOD_EXPLOSIVE");
    thread func_105B6(var_00, var_01);
  }
}

func_1059F(var_00, var_01) {
  self endon("disconnect");
  var_01 endon("exit_jackal");
  var_00 endon("spaceship_crashing");
  level endon("game_ended");
  var_02 = 100;
  var_03 = 700;
  var_04 = 50;
  var_05 = 200;
  var_06 = 440;

  for(;;) {
    var_00 waittill("spaceship_collision", var_07, var_08, var_09, var_10);
    var_11 = var_01 getnormalizedmovement();
    var_12 = (var_11[0] + 1) / 2;
    var_13 = var_05 + (var_06 - var_05) * var_12;
    var_14 = (var_08 - var_04) / (var_13 - var_04);

    if(var_14 > 1.0) {
      var_14 = 1.0;
    }
    else if(var_14 < 0.0) {
      var_14 = 0.0;
    }

    var_15 = var_14 * var_07;

    if(var_15 > 0) {
      var_16 = var_02 + (var_03 - var_02) * var_15;
      var_00 getrandomarmkillstreak(var_16, var_10, var_01, var_01, "MOD_IMPACT");
    }
  }
}

func_10587(var_00) {
  level endon("game_ended");
  var_00 endon("death");
  var_00 notify("healthRegen");
  var_00 endon("healthRegen");
  wait 5;
  var_01 = 18.75;

  while(var_0.damagetaken > 0) {
    var_02 = 1500 - var_0.damagetaken;
    var_0.damagetaken = var_0.damagetaken - var_01;

    if(var_0.damagetaken < 0) {
      var_0.damagetaken = 0;
    }

    var_03 = 1500 - var_0.damagetaken;
    func_105DE(var_00, var_02, var_03);
    scripts\engine\utility::waitframe();
  }

  func_105CD(var_00);
}

func_105DE(var_00, var_01, var_02) {
  if(!isDefined(var_0.owner)) {
    return;
  }
  if(var_02 < var_01) {
    if(var_02 < 495.0 && var_01 >= 495.0) {
      func_105CD(var_00);
      var_0.func_FE12 = scripts\engine\utility::getfx("cockpit_fire");
      playfxontagforclients(var_0.func_FE12, var_00, "j_stickleft", var_0.owner);
      var_03 = [];
      var_3["tag_thrust_rear1"] = "spaceship_dmg_trail";
      func_105DF(var_00, var_03);
    } else if(var_02 < 990.0 && var_01 >= 990.0) {
      var_0.func_FE12 = scripts\engine\utility::getfx("cockpit_smoke");
      playfxontagforclients(var_0.func_FE12, var_00, "j_stickleft", var_0.owner);
    } else
      playfxontagforclients(scripts\engine\utility::getfx("cockpit_sparks"), var_00, "j_stickleft", var_0.owner);
  } else if(var_02 >= 990.0 && var_01 < 990.0)
    func_105CD(var_00);
  else if(var_02 >= 495.0 && var_01 < 495.0) {
    func_105CD(var_00);
    var_0.func_FE12 = scripts\engine\utility::getfx("cockpit_smoke");
    playfxontagforclients(var_0.func_FE12, var_00, "j_stickleft", var_0.owner);
    var_03 = [];
    var_3["tag_thrust_rear1"] = "spaceship_dmg_trail";
    func_105DF(var_00, [], var_03);
  }
}

func_105CD(var_00) {
  if(isDefined(var_0.func_FE12)) {
    stopFXOnTag(var_0.func_FE12, var_00, "j_stickleft");
    var_0.func_FE12 = undefined;
  }
}

func_105AA(var_00, var_01, var_02, var_03) {
  var_04 = self;

  if(isDefined(var_0.owner)) {
    var_00 = var_0.owner;
  }

  if(isDefined(var_4.func_FE12)) {
    func_105CD(var_04);
  }

  var_04 playSound(level.func_105C8["explode"]);
  playFX(scripts\engine\utility::getfx("spaceship_death"), var_4.origin, anglesToForward(var_4.angles), anglestoup(var_4.angles));

  if(isDefined(var_4.owner)) {
    var_4.owner getrandomarmkillstreak(var_4.health + 1, var_4.owner.origin, var_00, undefined, var_02);
  }

  var_04 notify("spaceship_crashing");
}

func_105BF(var_00) {
  level.func_105EA = scripts\engine\utility::array_add(level.func_105EA, var_00);
  level.func_105E9[var_00 getentitynumber()] = var_00;
}

func_105C0(var_00) {
  if(isDefined(var_00)) {
    level.func_105EA = scripts\engine\utility::array_remove(level.func_105EA, var_00);
    level.func_105E9[var_00 getentitynumber()] = undefined;
    var_00 delete();
  }
}

func_105A4(var_00) {
  var_00 notify("monitorMissileFire");
  var_00 endon("monitorMissileFire");
  var_00 endon("spaceship_crashing");
  var_00 endon("death");

  for(;;) {
    var_00 waittill("missile_fire", var_01, var_02);

    if(var_02 != "spaceship_assault_mp" && var_02 != "spaceship_strike_mp") {
      continue;
    }
    var_1.func_105E6 = var_1.origin;
  }
}

func_3758(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11) {
  if(var_04 != "MOD_IMPACT") {
    if(!isDefined(var_00) || !isDefined(var_0.func_105E6)) {
      return var_02;
    }

    if(var_05 != "spaceship_assault_mp" && var_05 != "spaceship_strike_mp") {
      return var_02;
    }
  }

  if(var_05 == "spaceship_strike_mp") {
    var_12 = var_00;
    var_13 = distance(var_12.origin, var_12.func_105E6);

    if(var_13 < 10000) {
      var_02 = var_02 * 1.0;
    }
    else if(var_13 < 30000) {
      var_02 = var_02 * 0.5;
    }
    else {
      var_02 = var_02 * 0.25;
    }
  }

  var_02 = int(max(var_02, 1));
  self vehicle_finishdamage(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11);
}

func_105E2() {
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", var_00);

    if(level.func_A407.func_1C91) {
      thread func_105B8(var_00);
    }

    if(level.func_A407.func_10DBB) {
      level thread func_105B1(var_00);
    }
  }
}

func_105B1(var_00) {
  var_00 endon("death");
  var_00 endon("disconnect");

  for(;;) {
    var_01 = func_105C4(var_0.team);
    var_02 = func_105CB(var_01, var_0.team);

    if(isDefined(var_02)) {
      break;
    }
    scripts\engine\utility::waitframe();
  }

  var_00 setplayerangles(var_1.angles);
  var_02 vehicle_teleport(var_2.origin, var_1.angles);
  scripts\engine\utility::waitframe();
  func_105B5(var_02, var_00, 1);
}

func_105CB(var_00, var_01) {
  var_02 = var_00 global_physics_sound_monitor();

  if(!isDefined(var_02)) {
    return undefined;
  }

  var_2.func_10483 = var_00;
  return func_1058D(var_02, var_01);
}

func_105C4(var_00) {
  var_01 = level.func_FE33[var_00];
  var_01 = scripts\engine\utility::array_combine(var_01, level.func_FE33[scripts\mp\utility\game::getotherteam(var_00)]);
  var_02 = undefined;
  var_03 = 0;

  foreach(var_05 in var_01) {
    if(!func_10595(var_05)) {
      continue;
    }
    var_06 = 0;

    foreach(var_08 in level.func_1676) {
      if(isDefined(var_08) && isDefined(var_8.owner) && isDefined(var_8.owner.team) && var_8.owner.team != var_00) {
        var_09 = distancesquared(var_8.origin, var_5.origin);

        if(!isDefined(var_06) || var_09 > var_06) {
          var_06 = var_09;
        }
      }
    }

    if(!isDefined(var_02) || var_06 > var_03) {
      var_03 = var_06;
      var_02 = var_05;
    }
  }

  if(!isDefined(var_02)) {
    var_02 = var_1[randomint(var_1.size)];
  }

  return var_02;
}

func_10595(var_00) {
  if(isDefined(var_0.func_11931) && var_0.func_11931 - gettime() < 3000) {
    return 0;
  }

  foreach(var_02 in level.func_1676) {
    if(!isDefined(var_02)) {
      continue;
    }
    if(distancesquared(var_2.origin, var_0.origin) <= 1600) {
      return 0;
    }
  }

  var_04 = physics_createcontents(["physicscontents_aiavoid", "physicscontents_solid", "physicscontents_structural"]);
  var_05 = physics_getclosestpointtosphere(var_0.origin, 300, 0, var_04, undefined, "physicsquery_any");
  return var_05 == 0;
}

func_105CA(var_00, var_01, var_02) {
  var_03 = _func_26D(var_00, var_01, var_02, "veh_spaceship_mp", "veh_mil_air_ca_jackal_drone_atmos_periph_mp");
  return func_1058D(var_03, var_0.team);
}

func_1058D(var_00, var_01) {
  var_0.team = var_01;
  var_0.func_13CC3 = [];
  var_0.func_13CC3["hover"] = "spaceship_assault_mp";
  var_0.func_13CC3["fly"] = "spaceship_strike_mp";
  var_0.func_13CC3["land"] = var_0.func_13CC3["hover"];
  func_105BF(var_00);
  var_00 _meth_84BC(level.func_A407.func_1051B);
  var_00 _meth_84BE("spaceship");
  thread func_105A1(var_00);
  thread func_105A0(var_00);
  thread func_105A4(var_00);
  var_0.damagecallback = ::func_3758;
  return var_00;
}

func_105C5(var_00, var_01) {
  var_02 = undefined;
  var_02 = spawn("trigger_radius", func_10578(var_00), 0, 150, 200);
  var_0.func_130F2 = var_02;
  var_03 = scripts\mp\gameobjects::createuseobject(var_01, var_02, []);
  var_03 scripts\mp\gameobjects::setusetime(2);
  var_03 scripts\mp\gameobjects::setusetext(&"MP_JACKAL_BOARDING");

  if(var_2.classname == "trigger_use") {
    var_03 scripts\mp\gameobjects::setusehinttext(&"MP_JACKAL_BOARD");
  }

  var_03 scripts\mp\gameobjects::allowuse("friendly");
  var_03 scripts\mp\gameobjects::setvisibleteam("friendly");
  var_3.onuse = ::func_105B3;
  var_3.func_10574 = var_00;
  var_0.useobject = var_03;
}

func_105B3(var_00) {
  var_01 = self.func_10574;

  if(!isDefined(var_01)) {
    return;
  }
  func_105B5(var_01, var_00);
}

func_10580(var_00) {
  if(isDefined(var_0.useobject)) {
    var_0.useobject scripts\mp\gameobjects::setvisibleteam("none");
    var_0.useobject scripts\mp\gameobjects::allowuse("none");
  }
}

func_10583(var_00) {
  if(isDefined(var_0.useobject)) {
    var_0.useobject scripts\mp\gameobjects::setvisibleteam("friendly");
    var_0.useobject scripts\mp\gameobjects::allowuse("friendly");
    var_0.useobject.trigger.origin = func_10578(var_00);
  }
}

func_105E1(var_00, var_01) {
  var_01 endon("death");
  var_01 endon("disconnect");
  level endon("game_ended");

  if(!isai(var_01)) {
    var_01 notifyonplayercommand("exitJackal", "+actionslot 2");
  }

  while(isDefined(var_0.owner)) {
    var_01 waittill("exitJackal");

    if(func_10579(var_00, var_01)) {
      thread func_10581(var_00, var_01);
    }
  }
}

func_10579(var_00, var_01) {
  if(level.func_A407.allowgrenadedamage) {
    if(isDefined(var_0.func_A83C)) {
      if(!isDefined(var_0.func_A83C.team) || var_0.func_A83C.team == var_1.team) {
        var_01 iprintlnbold(&"MP_JACKAL_CANT_LAND");
        return 0;
      }
    }

    return 1;
  } else if(!func_10591(var_00)) {
    var_01 iprintlnbold(&"MP_JACKAL_CANT_LAND");
    return 0;
  }

  return 1;
}

func_10581(var_00, var_01, var_02) {
  level endon("game_ended");
  var_00 endon("death");
  var_03 = func_10584(var_00, var_01);

  if(!isDefined(var_03)) {
    var_01 iprintlnbold(&"MP_JACKAL_CANT_LAND");
    return;
  }

  var_01 setorigin(var_03);
  var_01 setplayerangles(var_0.angles);
  func_105B6(var_00, var_01);
  thread func_1057E(var_00);

  if(isDefined(var_02)) {
    func_105B7(var_01, var_2.origin, var_2.angles);
  }
}

func_10578(var_00) {
  return var_00 gettagorigin("j_cockpit") - (0, 0, 100);
}

func_10584(var_00, var_01) {
  var_02 = anglestoright(var_0.angles);
  var_03 = scripts\engine\trace::create_default_contents(1);
  var_04 = var_00 gettagorigin("j_cockpit");
  var_05 = var_04 - 64 * var_02;
  var_06 = physics_getclosestpointtocharacter(var_05, var_01, 0, var_0.angles, 0, var_03, var_00, "physicsquery_any");

  if(var_06 == 0) {
    return var_05;
  }

  var_05 = var_04 + 64 * var_02;
  var_06 = physics_getclosestpointtocharacter(var_05, var_01, 0, var_0.angles, 0, var_03, var_00, "physicsquery_any");

  if(var_06 == 0) {
    return var_05;
  }

  var_07 = anglesToForward(var_0.angles);
  var_05 = var_04 + 100 * var_07;
  var_06 = physics_getclosestpointtocharacter(var_05, var_01, 0, var_0.angles, 0, var_03, var_00, "physicsquery_any");

  if(var_06 == 0) {
    return var_05;
  }

  return undefined;
}

func_105B8(var_00) {
  level endon("game_ended");
  var_00 endon("death");
  var_00 endon("disconnect");

  if(!scripts\mp\utility\game::gameflag("prematch_done")) {
    level waittill("prematch_done");
  }

  thread func_105A7(var_00);

  for(;;) {
    var_00 waittill("useSpaceship");

    if(isDefined(var_0.func_A40D)) {
      continue;
    }
    if(isDefined(var_0.func_10574)) {
      if(func_10579(var_0.func_10574, var_00)) {
        func_10581(var_0.func_10574, var_00);
      }
      else {
        var_00 iprintlnbold(&"MP_JACKAL_CANT_LAND");
      }

      continue;
    }

    if(!isDefined(var_0.func_A40D)) {
      var_01 = func_10593(var_00);

      if(isDefined(var_01)) {
        func_10576(var_01, var_00);
      }
      else if(func_1057A(var_00)) {
        func_105CF(var_00);
      }
    }
  }
}

func_105A7(var_00) {
  level endon("game_ended");
  var_00 endon("death");
  var_00 endon("disconnect");

  if(!isai(var_00)) {
    var_00 notifyonplayercommand("useButton", "+usereload");
  }

  for(;;) {
    var_00 waittill("useButton");
    var_01 = 0.0001;
    var_00 setclientomnvar("ui_securing", 8);
    var_00 setclientomnvar("ui_securing_progress", var_01);

    while(var_00 usebuttonpressed()) {
      scripts\engine\utility::waitframe();
      var_01 = var_01 + 0.0666667;

      if(var_01 > 1.0) {
        var_01 = 1.0;
      }

      var_00 setclientomnvar("ui_securing_progress", var_01);

      if(var_01 == 1.0) {
        var_00 setclientomnvar("ui_securing", 0);
        var_00 notify("useSpaceship");
        wait 0.25;
        var_01 = 0;
      }
    }

    var_00 setclientomnvar("ui_securing", 0);
  }
}

func_10593(var_00) {
  var_01 = var_00 getEye();
  var_02 = var_00 getplayerangles();
  var_03 = var_01 + 750 * anglesToForward(var_02);
  var_04 = physics_spherecast(var_01, var_03, 15, scripts\engine\trace::create_vehicle_contents(), undefined, "physicsquery_closest");

  if(var_4.size == 0) {
    return undefined;
  }

  var_05 = var_4[0]["entity"];

  if(!func_10592(var_05)) {
    return undefined;
  }

  if(isDefined(var_5.owner)) {
    return undefined;
  }

  return var_05;
}

func_1058B(var_00) {
  var_01 = getEntArray(var_00, "targetname");

  if(var_1.size > 0) {
    level.func_A841 = var_01;

    foreach(var_03 in var_01) {
      func_105E3(var_03);

      if(var_3.func_2699) {
        thread func_105E5(var_03, ::func_105AC, ::func_105B2, ::func_105AF);
      }
    }
  }
}

func_1058A(var_00) {
  var_01 = getEntArray(var_00, "targetname");
  level.func_A83D = var_01;

  if(var_1.size > 0) {
    foreach(var_03 in var_01) {
      func_105E3(var_03);
      thread func_105E5(var_03, ::func_105AB, undefined, ::func_105AE);
    }
  }
}

func_10591(var_00) {
  if(isDefined(level.func_A841)) {
    foreach(var_02 in level.func_A841) {
      if((!isDefined(var_2.team) || var_2.team == var_0.owner.team) && var_00 istouching(var_02)) {
        return 1;
      }
    }

    return 0;
  } else
    return 1;
}

func_105AC(var_00, var_01) {
  var_0.owner forceusehinton(&"MP_JACKAL_EXIT");
}

func_105B2(var_00, var_01, var_02) {
  if(gettime() - var_02 >= 2000) {
    var_03 = var_00 getentitynumber();
    var_1.func_A41D[var_03] = undefined;
    var_1.func_A41E[var_03] = undefined;
    var_04 = var_0.owner;

    if(func_10579(var_00, var_04)) {
      var_05 = func_10596(var_01, var_04);
      thread func_10581(var_00, var_04, var_05);
    }
  }
}

func_105AF(var_00, var_01) {
  if(isDefined(var_0.owner)) {
    var_0.owner getrigindexfromarchetyperef();
  }
}

func_105AB(var_00, var_01) {
  var_0.func_A83C = var_01;
}

func_105AE(var_00, var_01) {
  var_0.func_A83C = undefined;
}

func_10596(var_00, var_01) {
  if(isDefined(var_0.func_D42C)) {
    var_02 = var_01 physics_getcharactercollisioncapsule();
    var_03 = var_2["radius"];
    var_04 = var_2["half_height"];

    foreach(var_06 in var_0.func_D42C) {
      if(isDefined(var_6.func_AA3B) && gettime() - var_6.func_AA3B < 10000) {
        continue;
      }
      if(capsuletracepassed(var_6.origin + (0, 0, var_04), var_03, var_04, var_01, 0, 1)) {
        var_6.func_AA3B = gettime();
        return var_06;
      }
    }
  }

  return undefined;
}

func_10590(var_00) {
  var_01 = getEntArray(var_00, "targetname");

  if(var_1.size > 0) {
    level.func_105ED = var_01;

    foreach(var_03 in var_01) {
    func_105E3(var_03);
    }
  }
}

func_1058F(var_00) {
  var_01 = getEntArray(var_00, "targetname");
  level.func_105EC = var_01;

  if(var_1.size > 0) {
    foreach(var_03 in var_01) {
    func_105E3(var_03);
    }
  }
}

func_1057A(var_00) {
  if(var_00 ismantling() || var_00 isonladder()) {
    var_00 iprintlnbold(&"MP_JACKAL_CANT_SUMMON");
    return 0;
  }

  if(isDefined(var_0.func_105E8) && gettime() - var_0.func_105E8 < 1000) {
    return 0;
  }

  if(level.func_A407.allowhide) {
    foreach(var_02 in level.func_105EC) {
      if(var_00 istouching(var_02)) {
        var_00 iprintlnbold(&"MP_JACKAL_CANT_SUMMON");
        return 0;
      }
    }

    return 1;
  } else if(isDefined(level.func_105ED)) {
    foreach(var_02 in level.func_105ED) {
      if(func_105DD(var_02, var_00)) {
        return 1;
      }
    }
  }

  var_00 iprintlnbold(&"MP_JACKAL_CANT_SUMMON");
  return 0;
}

func_105DD(var_00, var_01) {
  if(isDefined(var_0.team) && var_0.team != var_1.team) {
    return 0;
  }

  return var_01 istouching(var_00);
}

func_105CF(var_00) {
  var_01 = var_00 getEye();
  var_02 = anglesToForward(var_00 getplayerangles());
  var_03 = var_01 + 500 * var_02;
  var_04 = physics_createcontents(["physicscontents_aiavoid", "physicscontents_solid", "physicscontents_structural"]);
  var_05 = physics_charactercast(var_01, var_03, var_00, 0, var_0.angles, var_04, var_00, "physicsquery_any");

  if(var_05) {
    var_00 iprintlnbold(&"MP_JACKAL_CANT_SUMMON");
    return;
  }

  var_06 = 332 * anglestoright(var_0.angles);
  var_07 = var_03 + var_06;
  var_08 = 350;
  var_05 = physics_getclosestpointtosphere(var_07, var_08, 0, var_04, undefined, "physicsquery_any");

  if(var_05) {
    var_07 = var_07 + (0, 0, var_08 + 1);
    var_05 = physics_getclosestpointtosphere(var_07, var_08, 0, var_04, undefined, "physicsquery_any");

    if(var_05) {
      var_00 iprintlnbold(&"MP_JACKAL_CANT_SUMMON");
      return;
    }
  }

  var_09 = func_105CA(var_00, var_07, var_0.angles);
  func_105B7(var_00, var_03, var_0.angles, 0.25);
  func_105B5(var_09, var_00);
}

func_10576(var_00, var_01) {
  level endon("game_ended");
  var_01 endon("death");
  var_01 endon("disconnect");
  var_02 = vectornormalize(var_1.origin - var_0.origin);
  var_03 = anglestoright(var_0.angles);
  var_04 = vectordot(var_02, var_03) > 0;

  if(!var_04) {
    var_03 = -1 * var_03;
  }

  var_05 = var_00 gettagorigin("j_cockpit");
  var_06 = var_05 + 64 * var_03;
  var_00 notify("playerReserved");
  func_105B7(var_01, var_06, var_1.angles);

  if(isDefined(var_00)) {
    func_105B5(var_00, var_01);
  }
}

func_105B7(var_00, var_01, var_02, var_03) {
  level endon("game_ended");

  if(!isDefined(var_03)) {
    var_03 = 0.375;
  }

  var_04 = spawn("script_model", var_0.origin);
  var_4.angles = var_0.angles;
  var_04 setModel("tag_origin");
  var_0.func_A40D = 1;
  var_00 getweaponvariantattachments(var_04, "tag_origin");
  var_05 = var_00 setcontents(0);
  var_04 moveto(var_01, var_03, 0, 0);
  var_04 rotateto(var_02, 0.25 * var_03, 0.05 * var_03, 0);
  wait(var_03);

  if(isDefined(var_00)) {
    var_00 setcontents(var_05);
    var_00 unlink();
    var_0.func_A40D = undefined;
  }

  var_04 delete();
}

func_1057D(var_00) {
  var_01 = var_0.func_A9F2;
  var_0.func_A9F2 = undefined;

  if(isDefined(var_01) && !isDefined(var_1.owner)) {
    var_01 notify("spaceshipTimeout");
  }
}

func_1058E(var_00) {
  var_01 = getEntArray(var_00, "targetname");

  if(var_1.size > 0) {
    level.func_105EB = var_01;

    foreach(var_03 in var_01) {
      func_105E3(var_03);

      if(!isDefined(var_3.func_B4C9)) {
        var_3.func_B4C9 = 0.5;
      }

      thread func_105E5(var_03, ::func_105AD, undefined, ::func_105B0);
    }
  }
}

func_105AD(var_00, var_01) {
  if(isDefined(var_0.owner)) {
    var_00 _meth_8476(var_1.func_B4C9);
  }
}

func_105B0(var_00, var_01) {
  if(isDefined(var_0.owner)) {
    var_00 _meth_8476(1.0);
  }
}

func_105E5(var_00, var_01, var_02, var_03) {
  level endon("game_ended");
  var_00 endon("disable");
  var_0.func_A41D = [];
  var_0.func_A41E = [];
  thread func_105E4(var_00, var_02, var_03);

  for(;;) {
    var_00 waittill("trigger", var_04);

    if(!func_10594(var_04, var_00)) {
      continue;
    }
    var_05 = var_04 getentitynumber();
    var_0.func_A41E[var_05] = var_04;

    if(!isDefined(var_0.func_A41D[var_05])) {
      var_0.func_A41D[var_05] = gettime();

      if(isDefined(var_01)) {
        [[var_01]](var_04, var_00);
      }
    }
  }
}

func_105E4(var_00, var_01, var_02) {
  level endon("game_ended");
  var_00 endon("disable");

  for(;;) {
    wait 0.05;
    waittillframeend;

    foreach(var_06, var_04 in var_0.func_A41D) {
      var_05 = level.func_105E9[var_06];

      if(!isDefined(var_0.func_A41E[var_06])) {
        var_0.func_A41D[var_06] = undefined;

        if(isDefined(var_05) && isDefined(var_02)) {
          [[var_02]](var_05, var_00);
        }

        continue;
      }

      if(isDefined(var_01)) {
        [[var_01]](var_05, var_00, var_04);
      }
    }

    var_0.func_A41E = [];
  }
}

func_105E3(var_00) {
  var_0.func_2699 = 0;

  if(!isDefined(var_0.script_noteworthy)) {
    return;
  }
  var_01 = strtok(var_0.script_noteworthy, ",");

  foreach(var_03 in var_01) {
    var_04 = strtok(var_03, "=");

    switch (var_4[0]) {
      case "team":
        var_0.team = var_4[1];
        break;
      case "playerStarts":
      case "spawnpoints":
        var_0.func_D42C = scripts\engine\utility::getstructarray(var_4[1], "targetname");
        break;
      case "jackalStarts":
        var_0.func_A422 = scripts\engine\utility::getstructarray(var_4[1], "targetname");
        break;
      case "autouse":
        var_0.func_2699 = var_4[1] == "true";
        break;
      case "spawners":
        var_0.func_10879 = var_4[1];
        break;
      case "maxSpeed":
        var_0.func_B4C9 = float(var_4[1]);
      default:
        break;
    }
  }
}

func_10594(var_00, var_01) {
  if(!func_10592(var_00)) {
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

func_105B9(var_00, var_01, var_02, var_03, var_04) {
  var_05 = spawnfxforclient(scripts\engine\utility::getfx(var_02), var_01 getEye() + var_03, var_01);
  triggerfx(var_05);
  var_01 scripts\engine\utility::waittill_any_timeout(var_04, "death", "disconnect");
  var_05 delete();
}

func_105BA(var_00, var_01) {
  var_00 endon("death");
  var_01 endon("exit_jackal");
  var_01 endon("disconnect");
  level endon("game_ended");

  for(;;) {
    var_02 = var_00 vehicle_getvelocity();
    var_03 = lengthsquared(var_02);

    if(var_03 < 100) {
      var_04 = anglesToForward(var_0.angles);
      thread func_105B9(var_00, var_01, "space_particles", var_04 * 300, 3.0);
      wait 0.75;
      continue;
    }

    var_04 = vectornormalize(var_02);
    thread func_105B9(var_00, var_01, "space_particles", var_04 * 256, 1.0);
    wait 0.1;
  }
}

func_10592(var_00) {
  return var_0.classname == "script_vehicle_jackal_mp" || var_0.classname == "script_vehicle" && var_0.model == "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
}

func_105C1(var_00) {
  var_00 scripts\mp\powers::removepower(var_0.func_AE7B);
  var_00 scripts\mp\powers::removepower(var_0.func_AE7D);
}

func_105C2(var_00) {
  var_00 scripts\mp\powers::givepower(var_0.func_AE7B, "primary");
  var_00 scripts\mp\powers::givepower(var_0.func_AE7D, "secondary");
}