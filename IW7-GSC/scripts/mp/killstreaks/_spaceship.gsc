/*************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_spaceship.gsc
*************************************************/

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

func_10588(param_00) {
  func_105BC();
  level.var_A407 = param_00;
  param_00.var_1051B = isDefined(param_00.var_1051B) && param_00.var_1051B;
  thread func_1058C();
  param_00.allowgrenadedamage = !isDefined(param_00.allowgrenadedamage) || param_00.allowgrenadedamage;
  if(param_00.allowgrenadedamage) {
    func_1058A("landingExclusionZone");
  } else {
    func_1058B("landingzone");
  }

  param_00.allowhide = !isDefined(param_00.allowhide) || param_00.allowhide;
  if(param_00.allowhide) {
    func_1058F("summonExclusionZone");
  } else {
    func_10590("spaceship_summon_trigger");
  }

  if(!isDefined(param_00.alliesspawnareas)) {
    param_00.alliesspawnareas = "spaceship_spawner_allies";
  }

  if(!isDefined(param_00.var_26FB)) {
    param_00.var_26FB = "spaceship_spawner_axis";
  }

  level.var_FE33["axis"] = getEntArray(param_00.var_26FB, "targetname");
  level.var_FE33["allies"] = getEntArray(param_00.alliesspawnareas, "targetname");
  param_00.var_10DBB = isDefined(param_00.var_10DBB) && param_00.var_10DBB;
  if(!param_00.var_10DBB) {
    foreach(var_02 in level.var_FE33["axis"]) {
      func_105CB(var_02, "axis");
    }

    foreach(var_02 in level.var_FE33["allies"]) {
      func_105CB(var_02, "allies");
    }
  }

  param_00.var_1C91 = isDefined(param_00.var_1C91) && param_00.var_1C91;
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

func_105B5(param_00, param_01, param_02) {
  func_1057D(param_01);
  param_01.var_10574 = param_00;
  param_01 scripts\mp\powers::func_D729();
  func_10580(param_00);
  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  param_01 lib_0BD3::func_D31A(param_00, undefined, param_02);
  param_00.triggerportableradarping = param_01;
  func_10585(param_00, param_01);
  func_105DE(param_00, 1500, 1500 - param_00.var_E1);
  thread func_105A5(param_00, param_01);
  thread func_1059F(param_00, param_01);
  param_00 notify("playerEnter");
}

func_105B6(param_00, param_01) {
  param_01 scripts\mp\powers::func_D72F();
  param_01 lib_0BD3::func_D05B();
  param_01 getrigindexfromarchetyperef();
  func_105CD(param_00);
  param_00.triggerportableradarping = undefined;
  param_01.var_10574 = undefined;
  param_01.var_105E8 = gettime();
  param_01.var_A9F2 = param_00;
  thread func_105A6(param_00);
}

func_10585(param_00, param_01) {
  level.var_1676 = scripts\engine\utility::array_add(level.var_1676, param_00);
  thread func_1059E(param_00, param_01);
  thread func_105A3(param_00, param_01);
  thread func_105A2(param_00, param_01);
  thread func_105BA(param_00, param_01);
}

func_1057E(param_00) {
  level.var_1676 = scripts\engine\utility::array_remove(level.var_1676, param_00);
  func_105CE(param_00);
}

func_1057C(param_00) {
  if(isDefined(param_00.var_130F2)) {
    param_00.var_130F2 delete();
    param_00.useobject scripts\mp\gameobjects::deleteuseobject();
  }

  func_105C0(param_00);
}

func_1057F(param_00, param_01, param_02) {
  param_00 scripts\engine\utility::waittill_any_in_array_return_no_endon_death(param_02);
  param_01 delete();
}

func_105C3() {
  if(!isDefined(level.var_105BB)) {
    level.var_105BB = scripts\engine\utility::getstruct("player_safe_zone", "targetname");
    level.var_105BB.origin = (0, 0, 0);
  }

  return level.var_105BB;
}

func_105A6(param_00) {
  param_00 endon("death");
  param_00 endon("playerReserved");
  level endon("game_ended");
  param_00 scripts\engine\utility::waittill_any_timeout_1(20, "spaceshipTimeout");
  while(gettime() - param_00.lastdamagetime < 5000) {
    wait(0.25);
  }

  playFX(scripts\engine\utility::getfx("spaceship_remove"), param_00.origin);
  func_1057C(param_00);
  func_1057B();
}

func_1059E(param_00, param_01) {
  param_01 endon("exit_jackal");
  param_00 endon("death");
  param_01 endon("disconnect");
  if(!isai(param_01)) {
    param_01 notifyonplayercommand("ads_on", "+speed_throw");
    param_01 notifyonplayercommand("ads_off", "-speed_throw");
  }

  var_02 = 0;
  for(;;) {
    param_01 waittill("ads_on");
    param_01 playlocalsound("jackal_hud_ads_on");
    param_01 waittill("ads_off");
    param_01 playlocalsound("jackal_hud_ads_off");
  }
}

func_105CE(param_00) {
  if(isDefined(param_00) && isDefined(param_00.outlineids)) {
    foreach(var_02 in param_00.outlineids) {
      scripts\mp\utility::outlinedisable(var_02, param_00);
    }

    param_00.outlineids = undefined;
  }

  func_105DF(param_00, undefined, param_00.var_90E1);
  func_105DF(param_00, undefined, param_00.var_2CCB);
}

func_105A3(param_00, param_01) {
  param_01 endon("exit_jackal");
  param_00 endon("death");
  param_01 endon("disconnect");
  scripts\engine\utility::waitframe();
  func_10575(param_00, param_01);
  param_00.outlineids = [];
  if(level.teambased) {
    param_00.outlineids[0] = ::scripts\mp\utility::outlineenableforteam(param_00, "cyan", param_01.team, 1, 0, "equipment");
    param_00.outlineids[1] = ::scripts\mp\utility::outlineenableforteam(param_00, "orange", scripts\mp\utility::getotherteam(param_01.team), 1, 0, "equipment");
  } else {
    param_00.outlineids[0] = ::scripts\mp\utility::func_C793(param_00, "orange", 1, 0, "equipment");
  }

  param_00 hudoutlinedisableforclient(param_01);
  func_10575(param_00, param_01);
  var_02 = [];
  var_02["tag_engine_left"] = "spaceship_engine_idle";
  var_02["tag_engine_right"] = "spaceship_engine_idle";
  var_02["tag_vtol_frontrightbottom"] = "spaceship_hover";
  var_02["tag_vtol_frontleftbottom"] = "spaceship_hover";
  var_02["tag_vtol_frontcenterbottom"] = "spaceship_hover";
  var_03 = [];
  var_03["tag_engine_left"] = "spaceship_engine_max";
  var_03["tag_engine_right"] = "spaceship_engine_max";
  param_00.var_90E1 = var_02;
  param_00.var_2CCB = var_03;
  for(;;) {
    func_105DF(param_00, var_02, var_03);
    param_01 waittill("engage boost");
    func_105DF(param_00, var_03, var_02);
    param_01 waittill("disengage boost");
  }
}

func_105DF(param_00, param_01, param_02, param_03) {
  param_00 endon("death");
  while(isDefined(param_00.var_12F6B) && param_00.var_12F6B) {
    scripts\engine\utility::waitframe();
  }

  if(!isDefined(param_00)) {
    return;
  }

  param_00.var_12F6B = 1;
  if(isDefined(param_02) && param_02.size > 0) {
    foreach(var_06, var_05 in param_02) {
      stopFXOnTag(scripts\engine\utility::getfx(var_05), param_00, var_06);
      scripts\engine\utility::waitframe();
    }
  }

  if(isDefined(param_01) && param_01.size > 0) {
    foreach(var_06, var_05 in param_01) {
      if(isDefined(param_03)) {
        playfxontagforclients(scripts\engine\utility::getfx(var_05), param_00, var_06, param_03);
      } else {
        playFXOnTag(scripts\engine\utility::getfx(var_05), param_00, var_06);
      }

      scripts\engine\utility::waitframe();
    }
  }

  param_00.var_12F6B = undefined;
}

func_10575(param_00, param_01) {
  var_02 = [];
  var_02["tag_enginebottom_right"] = "spaceship_trail_f";
  var_02["tag_enginebottom_left"] = "spaceship_trail_f";
  var_03 = [];
  var_03["tag_enginebottom_right"] = "spaceship_trail_e";
  var_03["tag_enginebottom_left"] = "spaceship_trail_e";
  foreach(var_05 in level.var_1676) {
    if(!isDefined(var_05)) {
      continue;
    }

    if(var_05 == param_00) {
      continue;
    }

    if(!isDefined(var_05.triggerportableradarping)) {
      continue;
    }

    if(!level.teambased || param_01.team != var_05.triggerportableradarping.team) {
      thread func_105DF(var_05, var_03, undefined, param_01);
      thread func_105DF(param_00, var_03, undefined, var_05.triggerportableradarping);
      continue;
    }

    thread func_105DF(var_05, var_02, undefined, param_01);
    thread func_105DF(param_00, var_02, undefined, var_05.triggerportableradarping);
  }
}

func_105A2(param_00, param_01) {
  param_00 endon("death");
  param_01 endon("exit_jackal");
  level endon("game_ended");
  param_01 waittill("disconnect");
  func_1057E(param_00);
  func_1057C(param_00);
  func_1057B();
}

func_1057B() {
  level.var_1676 = scripts\engine\utility::array_removeundefined(level.var_1676);
  level.var_105EA = scripts\engine\utility::array_removeundefined(level.var_105EA);
  var_00 = [];
  foreach(var_03, var_02 in level.var_105E9) {
    if(isDefined(var_02)) {
      var_00[var_03] = var_02;
    }
  }

  level.var_105E9 = var_00;
}

func_105A1(param_00) {
  level endon("game_ended");
  var_01 = param_00.var_10483;
  var_02 = param_00.team;
  var_03 = param_00.triggerportableradarping;
  param_00 scripts\engine\utility::waittill_any_3("death", "spaceship_crashing");
  func_1057E(param_00);
  func_1057C(param_00);
  func_1057B();
  if(isDefined(var_01) && !level.var_A407.var_10DBB) {
    wait(2);
    func_105CB(var_01, var_02);
  }
}

func_105A0(param_00) {
  param_00 endon("spaceship_crashing");
  level endon("game_ended");
  param_00.var_10586 = 1500;
  param_00.lastdamagetime = 0;
  param_00 scripts\mp\damage::monitordamage(1500, "", ::func_105AA, ::func_105A9, 0, 1);
}

func_105A9(param_00, param_01, param_02, param_03, param_04) {
  var_05 = self;
  if(scripts\mp\utility::isstrstart(param_01, "spaceship")) {
    playFXOnTag(scripts\engine\utility::getfx("spaceship_dmg"), var_05, "tag_origin");
  }

  var_05.lastdamagetime = gettime();
  if(isDefined(var_05.triggerportableradarping)) {
    var_06 = var_05.maxhealth - var_05.var_E1;
    var_07 = var_06 - param_03;
    func_105DE(var_05, var_06, var_07);
    thread func_10587(var_05);
    if(isDefined(param_00.triggerportableradarping)) {
      param_00 = param_00.triggerportableradarping;
    }
  }

  return param_03;
}

func_105A5(param_00, param_01) {
  self endon("disconnect");
  param_01 endon("exit_jackal");
  level endon("game_ended");
  param_01 waittill("death");
  if(isDefined(param_01.var_10574) && param_01.var_10574 == param_00) {
    level.var_105EA = scripts\engine\utility::array_remove(level.var_105EA, param_00);
    level.var_105E9[param_00 getentitynumber()] = undefined;
    level.var_1676 = scripts\engine\utility::array_remove(level.var_1676, param_00);
    param_00 dodamage(param_00.health + 1, param_00.origin, param_01, undefined, "MOD_EXPLOSIVE");
    thread func_105B6(param_00, param_01);
  }
}

func_1059F(param_00, param_01) {
  self endon("disconnect");
  param_01 endon("exit_jackal");
  param_00 endon("spaceship_crashing");
  level endon("game_ended");
  var_02 = 100;
  var_03 = 700;
  var_04 = 50;
  var_05 = 200;
  var_06 = 440;
  for(;;) {
    param_00 waittill("spaceship_collision", var_07, var_08, var_09, var_0A);
    var_0B = param_01 getnormalizedmovement();
    var_0C = var_0B[0] + 1 / 2;
    var_0D = var_05 + var_06 - var_05 * var_0C;
    var_0E = var_08 - var_04 / var_0D - var_04;
    if(var_0E > 1) {
      var_0E = 1;
    } else if(var_0E < 0) {
      var_0E = 0;
    }

    var_0F = var_0E * var_07;
    if(var_0F > 0) {
      var_10 = var_02 + var_03 - var_02 * var_0F;
      param_00 dodamage(var_10, var_0A, param_01, param_01, "MOD_IMPACT");
    }
  }
}

func_10587(param_00) {
  level endon("game_ended");
  param_00 endon("death");
  param_00 notify("healthRegen");
  param_00 endon("healthRegen");
  wait(5);
  var_01 = 18.75;
  while(param_00.var_E1 > 0) {
    var_02 = 1500 - param_00.var_E1;
    param_00.var_E1 = param_00.var_E1 - var_01;
    if(param_00.var_E1 < 0) {
      param_00.var_E1 = 0;
    }

    var_03 = 1500 - param_00.var_E1;
    func_105DE(param_00, var_02, var_03);
    scripts\engine\utility::waitframe();
  }

  func_105CD(param_00);
}

func_105DE(param_00, param_01, param_02) {
  if(!isDefined(param_00.triggerportableradarping)) {
    return;
  }

  if(param_02 < param_01) {
    if(param_02 < 495 && param_01 >= 495) {
      func_105CD(param_00);
      param_00.var_FE12 = scripts\engine\utility::getfx("cockpit_fire");
      playfxontagforclients(param_00.var_FE12, param_00, "j_stickleft", param_00.triggerportableradarping);
      var_03 = [];
      var_03["tag_thrust_rear1"] = "spaceship_dmg_trail";
      func_105DF(param_00, var_03);
      return;
    }

    if(param_02 < 990.0001 && param_01 >= 990.0001) {
      param_00.var_FE12 = scripts\engine\utility::getfx("cockpit_smoke");
      playfxontagforclients(param_00.var_FE12, param_00, "j_stickleft", param_00.triggerportableradarping);
      return;
    }

    playfxontagforclients(scripts\engine\utility::getfx("cockpit_sparks"), param_00, "j_stickleft", param_00.triggerportableradarping);
    return;
  }

  if(param_02 >= 990.0001 && param_01 < 990.0001) {
    func_105CD(param_00);
    return;
  }

  if(param_02 >= 495 && param_01 < 495) {
    func_105CD(param_00);
    param_00.var_FE12 = scripts\engine\utility::getfx("cockpit_smoke");
    playfxontagforclients(param_00.var_FE12, param_00, "j_stickleft", param_00.triggerportableradarping);
    var_03 = [];
    var_03["tag_thrust_rear1"] = "spaceship_dmg_trail";
    func_105DF(param_00, [], var_03);
    return;
  }
}

func_105CD(param_00) {
  if(isDefined(param_00.var_FE12)) {
    stopFXOnTag(param_00.var_FE12, param_00, "j_stickleft");
    param_00.var_FE12 = undefined;
  }
}

func_105AA(param_00, param_01, param_02, param_03) {
  var_04 = self;
  if(isDefined(param_00.triggerportableradarping)) {
    param_00 = param_00.triggerportableradarping;
  }

  if(isDefined(var_04.var_FE12)) {
    func_105CD(var_04);
  }

  var_04 playSound(level.var_105C8["explode"]);
  playFX(scripts\engine\utility::getfx("spaceship_death"), var_04.origin, anglesToForward(var_04.angles), anglestoup(var_04.angles));
  if(isDefined(var_04.triggerportableradarping)) {
    var_04.triggerportableradarping dodamage(var_04.health + 1, var_04.triggerportableradarping.origin, param_00, undefined, param_02);
  }

  var_04 notify("spaceship_crashing");
}

func_105BF(param_00) {
  level.var_105EA = scripts\engine\utility::array_add(level.var_105EA, param_00);
  level.var_105E9[param_00 getentitynumber()] = param_00;
}

func_105C0(param_00) {
  if(isDefined(param_00)) {
    level.var_105EA = scripts\engine\utility::array_remove(level.var_105EA, param_00);
    level.var_105E9[param_00 getentitynumber()] = undefined;
    param_00 delete();
  }
}

func_105A4(param_00) {
  param_00 notify("monitorMissileFire");
  param_00 endon("monitorMissileFire");
  param_00 endon("spaceship_crashing");
  param_00 endon("death");
  for(;;) {
    param_00 waittill("missile_fire", var_01, var_02);
    if(var_02 != "spaceship_assault_mp" && var_02 != "spaceship_strike_mp") {
      continue;
    }

    var_01.var_105E6 = var_01.origin;
  }
}

func_3758(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(param_04 != "MOD_IMPACT") {
    if(!isDefined(param_00) || !isDefined(param_00.var_105E6)) {
      return param_02;
    }

    if(param_05 != "spaceship_assault_mp" && param_05 != "spaceship_strike_mp") {
      return param_02;
    }
  }

  if(param_05 == "spaceship_strike_mp") {
    var_0C = param_00;
    var_0D = distance(var_0C.origin, var_0C.var_105E6);
    if(var_0D < 10000) {
      param_02 = param_02 * 1;
    } else if(var_0D < 30000) {
      param_02 = param_02 * 0.5;
    } else {
      param_02 = param_02 * 0.25;
    }
  }

  param_02 = int(max(param_02, 1));
  self vehicle_finishdamage(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B);
}

func_105E2() {
  level endon("game_ended");
  for(;;) {
    level waittill("player_spawned", var_00);
    if(level.var_A407.var_1C91) {
      thread func_105B8(var_00);
    }

    if(level.var_A407.var_10DBB) {
      level thread func_105B1(var_00);
    }
  }
}

func_105B1(param_00) {
  param_00 endon("death");
  param_00 endon("disconnect");
  for(;;) {
    var_01 = func_105C4(param_00.team);
    var_02 = func_105CB(var_01, param_00.team);
    if(isDefined(var_02)) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  param_00 setplayerangles(var_01.angles);
  var_02 vehicle_teleport(var_02.origin, var_01.angles);
  scripts\engine\utility::waitframe();
  func_105B5(var_02, param_00, 1);
}

func_105CB(param_00, param_01) {
  var_02 = param_00 global_physics_sound_monitor();
  if(!isDefined(var_02)) {
    return undefined;
  }

  var_02.var_10483 = param_00;
  return func_1058D(var_02, param_01);
}

func_105C4(param_00) {
  var_01 = level.var_FE33[param_00];
  var_01 = scripts\engine\utility::array_combine(var_01, level.var_FE33[scripts\mp\utility::getotherteam(param_00)]);
  var_02 = undefined;
  var_03 = 0;
  foreach(var_05 in var_01) {
    if(!func_10595(var_05)) {
      continue;
    }

    var_06 = 0;
    foreach(var_08 in level.var_1676) {
      if(isDefined(var_08) && isDefined(var_08.triggerportableradarping) && isDefined(var_08.triggerportableradarping.team) && var_08.triggerportableradarping.team != param_00) {
        var_09 = distancesquared(var_08.origin, var_05.origin);
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
    var_02 = var_01[randomint(var_01.size)];
  }

  return var_02;
}

func_10595(param_00) {
  if(isDefined(param_00.var_11931) && param_00.var_11931 - gettime() < 3000) {
    return 0;
  }

  foreach(var_02 in level.var_1676) {
    if(!isDefined(var_02)) {
      continue;
    }

    if(distancesquared(var_02.origin, param_00.origin) <= 1600) {
      return 0;
    }
  }

  var_04 = physics_createcontents(["physicscontents_aiavoid", "physicscontents_solid", "physicscontents_structural"]);
  var_05 = physics_getclosestpointtosphere(param_00.origin, 300, 0, var_04, undefined, "physicsquery_any");
  return var_05 == 0;
}

func_105CA(param_00, param_01, param_02) {
  var_03 = _func_26D(param_00, param_01, param_02, "veh_spaceship_mp", "veh_mil_air_ca_jackal_drone_atmos_periph_mp");
  return func_1058D(var_03, param_00.team);
}

func_1058D(param_00, param_01) {
  param_00.team = param_01;
  param_00.var_13CC3 = [];
  param_00.var_13CC3["hover"] = "spaceship_assault_mp";
  param_00.var_13CC3["fly"] = "spaceship_strike_mp";
  param_00.var_13CC3["land"] = param_00.var_13CC3["hover"];
  func_105BF(param_00);
  param_00 _meth_84BC(level.var_A407.var_1051B);
  param_00 _meth_84BE("spaceship");
  thread func_105A1(param_00);
  thread func_105A0(param_00);
  thread func_105A4(param_00);
  param_00.damagecallback = ::func_3758;
  return param_00;
}

func_105C5(param_00, param_01) {
  var_02 = undefined;
  var_02 = spawn("trigger_radius", func_10578(param_00), 0, 150, 200);
  param_00.var_130F2 = var_02;
  var_03 = scripts\mp\gameobjects::createuseobject(param_01, var_02, []);
  var_03 scripts\mp\gameobjects::setusetime(2);
  var_03 scripts\mp\gameobjects::setusetext(&"MP_JACKAL_BOARDING");
  if(var_02.classname == "trigger_use") {
    var_03 scripts\mp\gameobjects::setusehinttext(&"MP_JACKAL_BOARD");
  }

  var_03 scripts\mp\gameobjects::allowuse("friendly");
  var_03 scripts\mp\gameobjects::setvisibleteam("friendly");
  var_03.onuse = ::func_105B3;
  var_03.var_10574 = param_00;
  param_00.useobject = var_03;
}

func_105B3(param_00) {
  var_01 = self.var_10574;
  if(!isDefined(var_01)) {
    return;
  }

  func_105B5(var_01, param_00);
}

func_10580(param_00) {
  if(isDefined(param_00.useobject)) {
    param_00.useobject scripts\mp\gameobjects::setvisibleteam("none");
    param_00.useobject scripts\mp\gameobjects::allowuse("none");
  }
}

func_10583(param_00) {
  if(isDefined(param_00.useobject)) {
    param_00.useobject scripts\mp\gameobjects::setvisibleteam("friendly");
    param_00.useobject scripts\mp\gameobjects::allowuse("friendly");
    param_00.useobject.trigger.origin = func_10578(param_00);
  }
}

func_105E1(param_00, param_01) {
  param_01 endon("death");
  param_01 endon("disconnect");
  level endon("game_ended");
  if(!isai(param_01)) {
    param_01 notifyonplayercommand("exitJackal", "+actionslot 2");
  }

  while(isDefined(param_00.triggerportableradarping)) {
    param_01 waittill("exitJackal");
    if(func_10579(param_00, param_01)) {
      thread func_10581(param_00, param_01);
    }
  }
}

func_10579(param_00, param_01) {
  if(level.var_A407.allowgrenadedamage) {
    if(isDefined(param_00.var_A83C)) {
      if(!isDefined(param_00.var_A83C.team) || param_00.var_A83C.team == param_01.team) {
        param_01 iprintlnbold(&"MP_JACKAL_CANT_LAND");
        return 0;
      }
    }

    return 1;
  } else if(!func_10591(param_00)) {
    param_01 iprintlnbold(&"MP_JACKAL_CANT_LAND");
    return 0;
  }

  return 1;
}

func_10581(param_00, param_01, param_02) {
  level endon("game_ended");
  param_00 endon("death");
  var_03 = func_10584(param_00, param_01);
  if(!isDefined(var_03)) {
    param_01 iprintlnbold(&"MP_JACKAL_CANT_LAND");
    return;
  }

  param_01 setorigin(var_03);
  param_01 setplayerangles(param_00.angles);
  func_105B6(param_00, param_01);
  thread func_1057E(param_00);
  if(isDefined(param_02)) {
    func_105B7(param_01, param_02.origin, param_02.angles);
  }
}

func_10578(param_00) {
  return param_00 gettagorigin("j_cockpit") - (0, 0, 100);
}

func_10584(param_00, param_01) {
  var_02 = anglestoright(param_00.angles);
  var_03 = scripts\common\trace::create_default_contents(1);
  var_04 = param_00 gettagorigin("j_cockpit");
  var_05 = var_04 - 64 * var_02;
  var_06 = physics_getclosestpointtocharacter(var_05, param_01, 0, param_00.angles, 0, var_03, param_00, "physicsquery_any");
  if(var_06 == 0) {
    return var_05;
  }

  var_05 = var_04 + 64 * var_02;
  var_06 = physics_getclosestpointtocharacter(var_05, param_01, 0, param_00.angles, 0, var_03, param_00, "physicsquery_any");
  if(var_06 == 0) {
    return var_05;
  }

  var_07 = anglesToForward(param_00.angles);
  var_05 = var_04 + 100 * var_07;
  var_06 = physics_getclosestpointtocharacter(var_05, param_01, 0, param_00.angles, 0, var_03, param_00, "physicsquery_any");
  if(var_06 == 0) {
    return var_05;
  }

  return undefined;
}

func_105B8(param_00) {
  level endon("game_ended");
  param_00 endon("death");
  param_00 endon("disconnect");
  if(!scripts\mp\utility::gameflag("prematch_done")) {
    level waittill("prematch_done");
  }

  thread func_105A7(param_00);
  for(;;) {
    param_00 waittill("useSpaceship");
    if(isDefined(param_00.var_A40D)) {
      continue;
    }

    if(isDefined(param_00.var_10574)) {
      if(func_10579(param_00.var_10574, param_00)) {
        func_10581(param_00.var_10574, param_00);
      } else {
        param_00 iprintlnbold(&"MP_JACKAL_CANT_LAND");
      }

      continue;
    }

    if(!isDefined(param_00.var_A40D)) {
      var_01 = func_10593(param_00);
      if(isDefined(var_01)) {
        func_10576(var_01, param_00);
      } else if(func_1057A(param_00)) {
        func_105CF(param_00);
      }
    }
  }
}

func_105A7(param_00) {
  level endon("game_ended");
  param_00 endon("death");
  param_00 endon("disconnect");
  if(!isai(param_00)) {
    param_00 notifyonplayercommand("useButton", "+usereload");
  }

  for(;;) {
    param_00 waittill("useButton");
    var_01 = 0.0001;
    param_00 setclientomnvar("ui_securing", 8);
    param_00 setclientomnvar("ui_securing_progress", var_01);
    while(param_00 usebuttonpressed()) {
      scripts\engine\utility::waitframe();
      var_01 = var_01 + 0.06666667;
      if(var_01 > 1) {
        var_01 = 1;
      }

      param_00 setclientomnvar("ui_securing_progress", var_01);
      if(var_01 == 1) {
        param_00 setclientomnvar("ui_securing", 0);
        param_00 notify("useSpaceship");
        wait(0.25);
        var_01 = 0;
      }
    }

    param_00 setclientomnvar("ui_securing", 0);
  }
}

func_10593(param_00) {
  var_01 = param_00 getEye();
  var_02 = param_00 getplayerangles();
  var_03 = var_01 + 750 * anglesToForward(var_02);
  var_04 = physics_spherecast(var_01, var_03, 15, scripts\common\trace::create_vehicle_contents(), undefined, "physicsquery_closest");
  if(var_04.size == 0) {
    return undefined;
  }

  var_05 = var_04[0]["entity"];
  if(!func_10592(var_05)) {
    return undefined;
  }

  if(isDefined(var_05.triggerportableradarping)) {
    return undefined;
  }

  return var_05;
}

func_1058B(param_00) {
  var_01 = getEntArray(param_00, "targetname");
  if(var_01.size > 0) {
    level.var_A841 = var_01;
    foreach(var_03 in var_01) {
      func_105E3(var_03);
      if(var_03.var_2699) {
        thread func_105E5(var_03, ::func_105AC, ::func_105B2, ::func_105AF);
      }
    }
  }
}

func_1058A(param_00) {
  var_01 = getEntArray(param_00, "targetname");
  level.var_A83D = var_01;
  if(var_01.size > 0) {
    foreach(var_03 in var_01) {
      func_105E3(var_03);
      thread func_105E5(var_03, ::func_105AB, undefined, ::func_105AE);
    }
  }
}

func_10591(param_00) {
  if(isDefined(level.var_A841)) {
    foreach(var_02 in level.var_A841) {
      if((!isDefined(var_02.team) || var_02.team == param_00.triggerportableradarping.team) && param_00 istouching(var_02)) {
        return 1;
      }
    }

    return 0;
  }

  return 1;
}

func_105AC(param_00, param_01) {
  param_00.triggerportableradarping forceusehinton(&"MP_JACKAL_EXIT");
}

func_105B2(param_00, param_01, param_02) {
  if(gettime() - param_02 >= 2000) {
    var_03 = param_00 getentitynumber();
    param_01.var_A41D[var_03] = undefined;
    param_01.var_A41E[var_03] = undefined;
    var_04 = param_00.triggerportableradarping;
    if(func_10579(param_00, var_04)) {
      var_05 = func_10596(param_01, var_04);
      thread func_10581(param_00, var_04, var_05);
    }
  }
}

func_105AF(param_00, param_01) {
  if(isDefined(param_00.triggerportableradarping)) {
    param_00.triggerportableradarping getrigindexfromarchetyperef();
  }
}

func_105AB(param_00, param_01) {
  param_00.var_A83C = param_01;
}

func_105AE(param_00, param_01) {
  param_00.var_A83C = undefined;
}

func_10596(param_00, param_01) {
  if(isDefined(param_00.var_D42C)) {
    var_02 = param_01 physics_getcharactercollisioncapsule();
    var_03 = var_02["radius"];
    var_04 = var_02["half_height"];
    foreach(var_06 in param_00.var_D42C) {
      if(isDefined(var_06.var_AA3B) && gettime() - var_06.var_AA3B < 10000) {
        continue;
      }

      if(capsuletracepassed(var_06.origin + (0, 0, var_04), var_03, var_04, param_01, 0, 1)) {
        var_06.var_AA3B = gettime();
        return var_06;
      }
    }
  }

  return undefined;
}

func_10590(param_00) {
  var_01 = getEntArray(param_00, "targetname");
  if(var_01.size > 0) {
    level.var_105ED = var_01;
    foreach(var_03 in var_01) {
      func_105E3(var_03);
    }
  }
}

func_1058F(param_00) {
  var_01 = getEntArray(param_00, "targetname");
  level.var_105EC = var_01;
  if(var_01.size > 0) {
    foreach(var_03 in var_01) {
      func_105E3(var_03);
    }
  }
}

func_1057A(param_00) {
  if(param_00 ismantling() || param_00 isonladder()) {
    param_00 iprintlnbold(&"MP_JACKAL_CANT_SUMMON");
    return 0;
  }

  if(isDefined(param_00.var_105E8) && gettime() - param_00.var_105E8 < 1000) {
    return 0;
  }

  if(level.var_A407.allowhide) {
    foreach(var_02 in level.var_105EC) {
      if(param_00 istouching(var_02)) {
        param_00 iprintlnbold(&"MP_JACKAL_CANT_SUMMON");
        return 0;
      }
    }

    return 1;
  } else if(isDefined(level.var_105ED)) {
    foreach(var_04 in level.var_105ED) {
      if(func_105DD(var_04, var_02)) {
        return 1;
      }
    }
  }

  var_02 iprintlnbold(&"MP_JACKAL_CANT_SUMMON");
  return 0;
}

func_105DD(param_00, param_01) {
  if(isDefined(param_00.team) && param_00.team != param_01.team) {
    return 0;
  }

  return param_01 istouching(param_00);
}

func_105CF(param_00) {
  var_01 = param_00 getEye();
  var_02 = anglesToForward(param_00 getplayerangles());
  var_03 = var_01 + 500 * var_02;
  var_04 = physics_createcontents(["physicscontents_aiavoid", "physicscontents_solid", "physicscontents_structural"]);
  var_05 = physics_charactercast(var_01, var_03, param_00, 0, param_00.angles, var_04, param_00, "physicsquery_any");
  if(var_05) {
    param_00 iprintlnbold(&"MP_JACKAL_CANT_SUMMON");
    return;
  }

  var_06 = 332 * anglestoright(param_00.angles);
  var_07 = var_03 + var_06;
  var_08 = 350;
  var_05 = physics_getclosestpointtosphere(var_07, var_08, 0, var_04, undefined, "physicsquery_any");
  if(var_05) {
    var_07 = var_07 + (0, 0, var_08 + 1);
    var_05 = physics_getclosestpointtosphere(var_07, var_08, 0, var_04, undefined, "physicsquery_any");
    if(var_05) {
      param_00 iprintlnbold(&"MP_JACKAL_CANT_SUMMON");
      return;
    }
  }

  var_09 = func_105CA(param_00, var_07, param_00.angles);
  func_105B7(param_00, var_03, param_00.angles, 0.25);
  func_105B5(var_09, param_00);
}

func_10576(param_00, param_01) {
  level endon("game_ended");
  param_01 endon("death");
  param_01 endon("disconnect");
  var_02 = vectornormalize(param_01.origin - param_00.origin);
  var_03 = anglestoright(param_00.angles);
  var_04 = vectordot(var_02, var_03) > 0;
  if(!var_04) {
    var_03 = -1 * var_03;
  }

  var_05 = param_00 gettagorigin("j_cockpit");
  var_06 = var_05 + 64 * var_03;
  param_00 notify("playerReserved");
  func_105B7(param_01, var_06, param_01.angles);
  if(isDefined(param_00)) {
    func_105B5(param_00, param_01);
  }
}

func_105B7(param_00, param_01, param_02, param_03) {
  level endon("game_ended");
  if(!isDefined(param_03)) {
    param_03 = 0.375;
  }

  var_04 = spawn("script_model", param_00.origin);
  var_04.angles = param_00.angles;
  var_04 setModel("tag_origin");
  param_00.var_A40D = 1;
  param_00 playerlinkto(var_04, "tag_origin");
  var_05 = param_00 setcontents(0);
  var_04 moveto(param_01, param_03, 0, 0);
  var_04 rotateto(param_02, 0.25 * param_03, 0.05 * param_03, 0);
  wait(param_03);
  if(isDefined(param_00)) {
    param_00 setcontents(var_05);
    param_00 unlink();
    param_00.var_A40D = undefined;
  }

  var_04 delete();
}

func_1057D(param_00) {
  var_01 = param_00.var_A9F2;
  param_00.var_A9F2 = undefined;
  if(isDefined(var_01) && !isDefined(var_01.triggerportableradarping)) {
    var_01 notify("spaceshipTimeout");
  }
}

func_1058E(param_00) {
  var_01 = getEntArray(param_00, "targetname");
  if(var_01.size > 0) {
    level.var_105EB = var_01;
    foreach(var_03 in var_01) {
      func_105E3(var_03);
      if(!isDefined(var_03.var_B4C9)) {
        var_03.var_B4C9 = 0.5;
      }

      thread func_105E5(var_03, ::func_105AD, undefined, ::func_105B0);
    }
  }
}

func_105AD(param_00, param_01) {
  if(isDefined(param_00.triggerportableradarping)) {
    param_00 _meth_8476(param_01.var_B4C9);
  }
}

func_105B0(param_00, param_01) {
  if(isDefined(param_00.triggerportableradarping)) {
    param_00 _meth_8476(1);
  }
}

func_105E5(param_00, param_01, param_02, param_03) {
  level endon("game_ended");
  param_00 endon("disable");
  param_00.var_A41D = [];
  param_00.var_A41E = [];
  thread func_105E4(param_00, param_02, param_03);
  for(;;) {
    param_00 waittill("trigger", var_04);
    if(!func_10594(var_04, param_00)) {
      continue;
    }

    var_05 = var_04 getentitynumber();
    param_00.var_A41E[var_05] = var_04;
    if(!isDefined(param_00.var_A41D[var_05])) {
      param_00.var_A41D[var_05] = gettime();
      if(isDefined(param_01)) {
        [[param_01]](var_04, param_00);
      }
    }
  }
}

func_105E4(param_00, param_01, param_02) {
  level endon("game_ended");
  param_00 endon("disable");
  for(;;) {
    wait(0.05);
    waittillframeend;
    foreach(var_06, var_04 in param_00.var_A41D) {
      var_05 = level.var_105E9[var_06];
      if(!isDefined(param_00.var_A41E[var_06])) {
        param_00.var_A41D[var_06] = undefined;
        if(isDefined(var_05) && isDefined(param_02)) {
          [
            [param_02]
          ](var_05, param_00);
        }

        continue;
      }

      if(isDefined(param_01)) {
        [[param_01]](var_05, param_00, var_04);
      }
    }

    param_00.var_A41E = [];
  }
}

func_105E3(param_00) {
  param_00.var_2699 = 0;
  if(!isDefined(param_00.script_noteworthy)) {
    return;
  }

  var_01 = strtok(param_00.script_noteworthy, ",");
  foreach(var_03 in var_01) {
    var_04 = strtok(var_03, "=");
    switch (var_04[0]) {
      case "team":
        param_00.team = var_04[1];
        break;

      case "playerStarts":
      case "spawnpoints":
        param_00.var_D42C = scripts\engine\utility::getstructarray(var_04[1], "targetname");
        break;

      case "jackalStarts":
        param_00.var_A422 = scripts\engine\utility::getstructarray(var_04[1], "targetname");
        break;

      case "autouse":
        param_00.var_2699 = var_04[1] == "true";
        break;

      case "spawners":
        param_00.var_10879 = var_04[1];
        break;

      case "maxSpeed":
        param_00.var_B4C9 = float(var_04[1]);
        break;

      default:
        break;
    }
  }
}

func_10594(param_00, param_01) {
  if(!func_10592(param_00)) {
    return 0;
  }

  if(!isDefined(param_00.triggerportableradarping)) {
    return 0;
  }

  if(isDefined(param_01.team) && param_01.team != param_00.team) {
    return 0;
  }

  return 1;
}

func_105B9(param_00, param_01, param_02, param_03, param_04) {
  var_05 = spawnfxforclient(scripts\engine\utility::getfx(param_02), param_01 getEye() + param_03, param_01);
  triggerfx(var_05);
  param_01 scripts\engine\utility::waittill_any_timeout_1(param_04, "death", "disconnect");
  var_05 delete();
}

func_105BA(param_00, param_01) {
  param_00 endon("death");
  param_01 endon("exit_jackal");
  param_01 endon("disconnect");
  level endon("game_ended");
  for(;;) {
    var_02 = param_00 vehicle_getvelocity();
    var_03 = lengthsquared(var_02);
    if(var_03 < 100) {
      var_04 = anglesToForward(param_00.angles);
      thread func_105B9(param_00, param_01, "space_particles", var_04 * 300, 3);
      wait(0.75);
      continue;
    }

    var_04 = vectornormalize(var_02);
    thread func_105B9(param_00, param_01, "space_particles", var_04 * 256, 1);
    wait(0.1);
  }
}

func_10592(param_00) {
  return param_00.classname == "script_vehicle_jackal_mp" || param_00.classname == "script_vehicle" && param_00.model == "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
}

func_105C1(param_00) {
  param_00 scripts\mp\powers::removepower(param_00.var_AE7B);
  param_00 scripts\mp\powers::removepower(param_00.var_AE7D);
}

func_105C2(param_00) {
  param_00 scripts\mp\powers::givepower(param_00.var_AE7B, "primary");
  param_00 scripts\mp\powers::givepower(param_00.var_AE7D, "secondary");
}