/*************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_airstrike.gsc
*************************************************/

init() {
  level.airstrikefx = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.airstrikessfx = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.var_1AF6 = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.var_A87D = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.var_BB68 = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.bombstrike = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.var_1A8D = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.var_A3BA = loadfx("vfx\iw7\core\vehicle\jackal\vfx_jackal_death_01_cheap.vfx");
  level._effect["jackal_explosion"] = loadfx("vfx\iw7\core\mp\killstreaks\vfx_veh_exp_warden.vfx");
  level.jackals = [];
  level.dangermaxradius["precision_airstrike"] = 550;
  level.dangerminradius["precision_airstrike"] = 300;
  level.dangerforwardpush["precision_airstrike"] = 2;
  level.dangerovalscale["precision_airstrike"] = 6;
  level.artillerydangercenters = [];
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("precision_airstrike", ::func_128D4, undefined, undefined, undefined, ::func_13C8A);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("jackal", ::func_128D4, undefined, undefined, ::triggerjackalweapon, ::func_13C8A);
  var_00 = ["passive_precision_strike", "passive_increased_speed", "passive_decreased_damage", "passive_split_strike", "passive_increased_cost", "passive_one_plane", "passive_speed_cost"];
  scripts\mp\killstreak_loot::func_DF07("precision_airstrike", var_00);
  var_01 = ["passive_extra_flare", "passive_decreased_duration", "passive_moving_fortress", "passive_no_cannon", "passive_slow_turret", "passive_support_drop"];
  scripts\mp\killstreak_loot::func_DF07("jackal", var_01);
  level.planes = [];
  level thread func_7DE9();
}

func_7DE9() {
  var_00 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_allies_start");
  var_01 = 0;
  var_02 = 0;
  foreach(var_04 in var_00) {
    var_01++;
    var_02 = var_02 + var_04.origin[2];
  }

  level.averagealliesz = var_02 / var_01;
}

func_13C8A(param_00) {
  var_01 = undefined;
  if(param_00.streakname == "precision_airstrike") {
    if(scripts\mp\utility::istrue(level.var_1AF9)) {
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
      return 0;
    }

    if(scripts\mp\killstreaks\_utility::func_A69F(param_00, "passive_precision_strike") || scripts\mp\killstreaks\_utility::func_A69F(param_00, "passive_split_strike")) {
      var_01 = 1;
    }

    scripts\mp\killstreaks\_mapselect::func_10DC2(0, 1, var_01);
  }

  return 1;
}

func_128D4(param_00) {
  if(param_00.streakname == "jackal" && isDefined(level.var_A22D) || level.jackals.size > 0) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    if(scripts\mp\killstreaks\_utility::func_A69F(param_00, "passive_support_drop")) {
      if(isDefined(param_00.var_394) && param_00.var_394 != "none") {
        self notify("killstreak_finished_with_weapon_" + param_00.var_394);
      }
    }

    return 0;
  }

  var_01 = selectairstrikelocation(param_00.lifeid, param_00.streakname, param_00);
  if(!isDefined(var_01) || !var_01) {
    return 0;
  }

  return 1;
}

func_57DD(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  if(param_05 == "precision_airstrike") {
    level.var_1AF9 = 1;
    thread func_1399E();
  }

  var_08 = scripts\common\trace::ray_trace(param_01, param_01 + (0, 0, -1000000));
  var_09 = var_08["position"];
  var_0A = spawnStruct();
  var_0A.origin = var_09;
  var_0A.missionfailed = anglesToForward((0, param_02, 0));
  var_0A.streakname = param_05;
  var_0A.team = param_04;
  callstrike(param_00, param_03, var_09, param_02, param_05, param_06, param_07);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(7.5);
  var_0B = 0;
  var_0C = [];
  if(param_05 == "precision_airstrike") {
    level.var_1AF9 = undefined;
  }

  self notify("airstrike_finished");
  if(param_05 == "precision_airstrike") {
    scripts\mp\utility::printgameaction("killstreak ended - precision_airstrike", param_03);
  }
}

func_1399E() {
  self endon("airstrike_finished");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_3("disconnect", "joined_team");
  if(scripts\mp\utility::istrue(level.var_1AF9)) {
    level.var_1AF9 = undefined;
  }
}

clearprogress(param_00) {
  wait(2);
  level.var_1AF9 = undefined;
}

getairstrikedanger(param_00) {
  var_01 = 0;
  for(var_02 = 0; var_02 < level.artillerydangercenters.size; var_02++) {
    var_03 = level.artillerydangercenters[var_02].origin;
    var_04 = level.artillerydangercenters[var_02].missionfailed;
    var_05 = level.artillerydangercenters[var_02].streakname;
    var_01 = var_01 + getsingleairstrikedanger(param_00, var_03, var_04, var_05);
  }

  return var_01;
}

getsingleairstrikedanger(param_00, param_01, param_02, param_03) {
  if(scripts\mp\utility::func_9F0F(param_03)) {
    if(distancesquared(param_00, param_01) < level.dangermaxradius[param_03]) {
      return 1;
    } else {
      return 0;
    }
  }

  var_04 = param_01 + level.dangerforwardpush[param_03] * level.dangermaxradius[param_03] * param_02;
  var_05 = param_00 - var_04;
  var_05 = (var_05[0], var_05[1], 0);
  var_06 = vectordot(var_05, param_02) * param_02;
  var_07 = var_05 - var_06;
  var_08 = var_07 + var_06 / level.dangerovalscale[param_03];
  var_09 = lengthsquared(var_08);
  if(var_09 > level.dangermaxradius[param_03] * level.dangermaxradius[param_03]) {
    return 0;
  }

  if(var_09 < level.dangerminradius[param_03] * level.dangerminradius[param_03]) {
    return 1;
  }

  var_0A = sqrt(var_09);
  var_0B = var_0A - level.dangerminradius[param_03] / level.dangermaxradius[param_03] - level.dangerminradius[param_03];
  return 1 - var_0B;
}

pointisinairstrikearea(param_00, param_01, param_02, param_03) {
  return distance2d(param_00, param_01) <= level.dangermaxradius[param_03] * 1.25;
}

losradiusdamage(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = scripts\mp\weapons::getdamageableents(param_00, param_01, 1);
  glassradiusdamage(param_00, param_01, param_02, param_03);
  for(var_08 = 0; var_08 < var_07.size; var_08++) {
    if(var_07[var_08].issplitscreen == self) {
      continue;
    }

    var_09 = distance(param_00, var_07[var_08].damagecenter);
    if(var_07[var_08].isplayer || isDefined(var_07[var_08].issentry) && var_07[var_08].issentry) {
      var_0A = !bullettracepassed(var_07[var_08].issplitscreen.origin, var_07[var_08].issplitscreen.origin + (0, 0, 130), 0, undefined);
      if(var_0A) {
        var_0A = !bullettracepassed(var_07[var_08].issplitscreen.origin + (0, 0, 130), param_00 + (0, 0, 114), 0, undefined);
        if(var_0A) {
          var_09 = var_09 * 4;
          if(var_09 > param_01) {
            continue;
          }
        }
      }
    }

    var_07[var_08].var_DA = int(param_02 + param_03 - param_02 * var_09 / param_01);
    var_07[var_08].pos = param_00;
    var_07[var_08].damageowner = param_04;
    var_07[var_08].einflictor = param_05;
    level.airstrikedamagedents[level.airstrikedamagedentscount] = var_07[var_08];
    level.airstrikedamagedentscount++;
  }

  thread airstrikedamageentsthread(param_06);
}

airstrikedamageentsthread(param_00) {
  self notify("airstrikeDamageEntsThread");
  self endon("airstrikeDamageEntsThread");
  while(level.airstrikedamagedentsindex < level.airstrikedamagedentscount) {
    if(!isDefined(level.airstrikedamagedents[level.airstrikedamagedentsindex])) {
      continue;
    }

    var_01 = level.airstrikedamagedents[level.airstrikedamagedentsindex];
    if(!isDefined(var_01.issplitscreen)) {
      continue;
    }

    if(!var_01.isplayer || isalive(var_01.issplitscreen)) {
      var_01 scripts\mp\weapons::damageent(var_01.einflictor, var_01.damageowner, var_01.var_DA, "MOD_PROJECTILE_SPLASH", param_00, var_01.pos, vectornormalize(var_01.damagecenter - var_01.pos));
      level.airstrikedamagedents[level.airstrikedamagedentsindex] = undefined;
      if(var_01.isplayer) {
        wait(0.05);
      }

      continue;
    }

    level.airstrikedamagedents[level.airstrikedamagedentsindex] = undefined;
    level.airstrikedamagedentsindex++;
  }
}

radiusartilleryshellshock(param_00, param_01, param_02, param_03, param_04) {
  var_05 = level.players;
  foreach(var_07 in level.players) {
    if(!isalive(var_07)) {
      continue;
    }

    if(var_07.team == param_04 || var_07.team == "spectator") {
      continue;
    }

    var_08 = var_07.origin + (0, 0, 32);
    var_09 = distance(param_00, var_08);
    if(var_09 > param_01) {
      continue;
    }

    var_0A = int(param_02 + param_03 - param_02 * var_09 / param_01);
    var_07 thread artilleryshellshock("default", var_0A);
  }
}

artilleryshellshock(param_00, param_01) {
  self endon("disconnect");
  if(isDefined(self.beingartilleryshellshocked) && self.beingartilleryshellshocked) {
    return;
  }

  self.beingartilleryshellshocked = 1;
  self shellshock(param_00, param_01);
  wait(param_01 + 1);
  self.beingartilleryshellshocked = 0;
}

func_3786(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_01) || param_01 scripts\mp\utility::iskillstreakdenied()) {
    self notify("stop_bombing");
    return;
  }

  var_04 = 512;
  var_05 = (0, randomint(360), 0);
  var_06 = param_00 + anglesToForward(var_05) * randomfloat(var_04);
  var_07 = bulletTrace(var_06, var_06 + (0, 0, -10000), 0, undefined);
  var_06 = var_07["position"];
  var_08 = distance(param_00, var_06);
  if(var_08 > 5000) {
    return;
  }

  wait(0.85 * var_08 / 2000);
  if(!isDefined(param_01) || param_01 scripts\mp\utility::iskillstreakdenied()) {
    self notify("stop_bombing");
    return;
  }

  if(param_03) {
    playFX(level.var_BB68, var_06);
    level thread scripts\mp\shellshock::func_10F44(var_06);
  }

  thread scripts\mp\utility::playsoundinspace("exp_airstrike_bomb", var_06);
  radiusartilleryshellshock(var_06, 512, 8, 4, param_01.team);
  losradiusdamage(var_06 + (0, 0, 16), 896, 300, 50, param_01, self, "stealth_bomb_mp");
}

func_5A60(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  if(!isDefined(param_01)) {
    return;
  }

  var_0C = 100;
  var_0D = 150;
  var_0E = param_04;
  var_0F = param_05;
  var_10 = "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
  var_11 = scripts\mp\killstreak_loot::getrarityforlootitem(param_0B.variantid);
  if(var_11 != "") {
    var_10 = var_10 + "_" + var_11;
  }

  var_12 = spawn("script_model", var_0E);
  var_12 setModel(var_10);
  var_12.triggerportableradarping = param_01;
  var_12.origin = var_0E;
  var_12.angles = param_08;
  var_12.team = param_01.team;
  var_12.lifeid = param_00;
  var_12.streakinfo = param_0B;
  var_12 setotherent(param_01);
  var_12 _meth_8549();
  var_12 _meth_8594();
  var_12 _meth_8548();
  var_12 scripts\mp\killstreaks\_utility::func_1843(param_09, "Killstreak_Air", param_01, 1, "kill_outline");
  var_12 thread handleemp(param_01);
  if(param_09 == "precision_airstrike") {
    var_13 = "jackal_airstrike_turret_mp";
    var_14 = "vehicle_battle_hind_mg_mp";
    var_15 = "tag_bottom_light";
    var_16 = "icon_minimap_scorcher_friendly";
    if(scripts\mp\killstreaks\_utility::func_A69F(param_0B, "passive_speed_cost")) {
      param_07 = param_07 - 1;
    }

    var_12.minimapid = var_12 scripts\mp\killstreaks\_airdrop::createobjective(var_16, undefined, undefined, 1, 1);
    var_12.turret = spawnturret("misc_turret", var_12 gettagorigin(var_15), var_13);
    var_12.turret setModel(var_14);
    var_12.turret.triggerportableradarping = param_01;
    var_12.turret.angles = var_12.angles;
    var_12.turret linkto(var_12, var_15, (0, 0, 30), (0, 0, 0));
    var_12.turret setturretmodechangewait(0);
    var_12.turret give_player_session_tokens("manual_target");
    var_12.turret setsentryowner(param_01);
    var_12.turrettarget = spawn("script_model", var_12.origin + anglesToForward(var_12.angles) * 1000 - (0, 0, 10000));
    var_12.turrettarget linkto(var_12);
    var_12.var_A87B = spawn("script_model", var_12.turrettarget.origin);
    var_12.var_A87B setModel("ks_scorchers_target_mp");
    var_12.var_A87B setentityowner(param_01);
    var_12.var_A87B.weapon_name = "artillery_mp";
    var_12.var_A87B.streakinfo = param_0B;
    var_12.turret settargetentity(var_12.turrettarget);
  }

  var_12 moveto(var_0F, param_07, 0, 0);
  if(param_09 == "precision_airstrike") {
    var_12 setscriptablepartstate("thrusters", "idle", 0);
    thread func_3788(var_12, var_0F, param_07, param_06 - 1.5, param_01);
    wait(param_06 + 1);
  } else {
    var_12 setscriptablepartstate("thrusters", "idle", 0);
    thread callstrike_bombeffect(var_12, var_0F, param_07, param_06 - 1, param_01, param_02, param_09, param_0A);
    wait(param_06 - 0.75);
  }

  if(param_09 != "jackal") {
    var_12 scriptmodelplayanimdeltamotion("airstrike_mp_roll", 1);
  }

  var_12 thread func_5115(2.5, "kill_outline");
  var_12 endon("death");
  wait(param_07 - param_06);
  var_12 setscriptablepartstate("thrusters", "neutral", 0);
  if(isDefined(var_12.minimapid)) {
    scripts\mp\objidpoolmanager::returnminimapid(var_12.minimapid);
  }

  var_12 notify("delete");
  if(isDefined(var_12.turret)) {
    var_12.turret delete();
  }

  if(isDefined(var_12.turrettarget)) {
    var_12.turrettarget delete();
  }

  if(isDefined(var_12.var_A87B)) {
    var_12.var_A87B delete();
    if(isDefined(var_12.var_A87B.killcament)) {
      var_12.var_A87B.killcament delete();
    }
  }

  if(isDefined(var_12)) {
    var_12 delete();
  }
}

func_5115(param_00, param_01) {
  self endon("death");
  wait(param_00);
  self notify(param_01);
}

handledeath() {
  level endon("game_ended");
  self endon("delete");
  self waittill("death");
  var_00 = anglesToForward(self.angles) * 200;
  playFX(level.harrier_deathfx, self.origin, var_00);
  self delete();
}

addplanetolist(param_00) {
  level.planes[level.planes.size] = param_00;
}

removeplanefromlist(param_00) {
  for(var_01 = 0; var_01 < level.planes.size; var_01++) {
    if(isDefined(level.planes[var_01]) && level.planes[var_01] == param_00) {
      level.planes[var_01] = undefined;
    }
  }
}

callstrike_bombeffect(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  param_00 endon("death");
  wait(param_03);
  if(!isDefined(param_04) || param_04 scripts\mp\utility::iskillstreakdenied()) {
    return;
  }

  var_08 = anglesToForward(param_00.angles);
  var_09 = spawnbomb(param_00.origin, param_00.angles);
  var_09 movegravity(anglesToForward(param_00.angles) * 4666.667, 3);
  var_09.lifeid = param_05;
  var_0A = spawn("script_model", param_00.origin + (0, 0, 100) - var_08 * 200);
  var_09.killcament = var_0A;
  var_09.killcament setscriptmoverkillcam("airstrike");
  var_09.var_1AFE = param_06;
  var_0A.starttime = gettime();
  var_0A thread deleteaftertime(15);
  var_0A.angles = var_08;
  var_0A moveto(param_01 + (0, 0, 100), param_02, 0, 0);
  wait(0.4);
  var_0A moveto(var_0A.origin + var_08 * 4000, 1, 0, 0);
  wait(0.45);
  var_0A moveto(var_0A.origin + var_08 + (0, 0, -0.2) * 3500, 2, 0, 0);
  wait(0.15);
  var_0B = spawn("script_model", var_09.origin);
  var_0B setModel("tag_origin");
  var_0B.origin = var_09.origin;
  var_0B.angles = var_09.angles;
  var_09 setModel("tag_origin");
  wait(0.1);
  var_0C = var_0B.origin;
  var_0D = var_0B.angles;
  if(level.splitscreen) {
    playFXOnTag(level.airstrikessfx, var_0B, "tag_origin");
  } else {
    playFXOnTag(level.airstrikefx, var_0B, "tag_origin");
  }

  wait(0.05);
  var_0A moveto(var_0A.origin + var_08 + (0, 0, -0.25) * 2500, 2, 0, 0);
  wait(0.25);
  var_0A moveto(var_0A.origin + var_08 + (0, 0, -0.35) * 2000, 2, 0, 0);
  wait(0.2);
  var_0A moveto(var_0A.origin + var_08 + (0, 0, -0.45) * 1500, 2, 0, 0);
  wait(0.5);
  if(isDefined(param_07)) {
    param_07 delete();
  }

  var_0E = 12;
  var_0F = 5;
  var_10 = 55;
  var_11 = var_10 - var_0F / var_0E;
  var_12 = (0, 0, 0);
  for(var_13 = 0; var_13 < var_0E; var_13++) {
    var_14 = anglesToForward(var_0D + (var_10 - var_11 * var_13, randomint(10) - 5, 0));
    var_15 = var_0C + var_14 * 10000;
    var_16 = bulletTrace(var_0C, var_15, 0, undefined);
    var_17 = var_16["position"];
    var_12 = var_12 + var_17;
    playFX(level.var_1AF6, var_17);
    thread losradiusdamage(var_17 + (0, 0, 16), 512, 200, 30, param_04, var_09, "artillery_mp");
    if(var_13 % 3 == 0) {
      thread scripts\mp\utility::playsoundinspace("jackal_missile_impact", var_17);
      level thread scripts\mp\shellshock::airstrike_earthquake(var_17);
    }

    wait(0.05);
  }

  var_12 = var_12 / var_0E + (0, 0, 128);
  var_0A moveto(var_09.killcament.origin * 0.35 + var_12 * 0.65, 1.5, 0, 0.5);
  wait(5);
  var_0B delete();
  var_09 delete();
}

spawnbomb(param_00, param_01) {
  var_02 = spawn("script_model", param_00);
  var_02.angles = param_01;
  var_02 setModel("projectile_cbu97_clusterbomb");
  return var_02;
}

func_3788(param_00, param_01, param_02, param_03, param_04) {
  param_00 endon("death");
  wait(param_03);
  if(!isDefined(param_04) || param_04 scripts\mp\utility::iskillstreakdenied()) {
    return;
  }

  var_05 = anglesToForward(param_00.angles);
  var_06 = spawn("script_model", param_00.origin - (0, 0, 100) - var_05 * 200);
  var_06 linkto(param_00);
  param_00.var_A87B.killcament = var_06;
  wait(0.5);
  var_07 = 50;
  var_08 = (0, 0, 0);
  var_09 = var_08;
  param_00.turret setscriptablepartstate("fire", "start", 0);
  param_00.var_A87B setscriptablepartstate("beam impact", "active", 0);
  var_0A = ["explode1", "explode2", "explode3", "explode4", "explode5"];
  var_0B = 0;
  for(var_0C = 0; var_0C < var_07; var_0C++) {
    if(!isDefined(param_04)) {
      break;
    }

    var_0D = scripts\common\trace::ray_trace(param_00.turret gettagorigin("tag_flash"), param_00.turrettarget.origin, level.characters, scripts\common\trace::create_contents(0, 1, 0, 1, 0, 1, 0));
    var_0E = var_0D["position"];
    var_08 = var_0E + (0, 0, 2);
    param_00.var_A87B thread func_BCA4(var_0B, var_08, var_0A);
    param_00.turret shootturret();
    var_09 = var_08;
    if(var_0B < 4) {
      var_0B++;
    } else {
      var_0B = 0;
    }

    wait(0.05);
  }

  param_00.turret setscriptablepartstate("fire", "stop", 0);
}

func_BCA4(param_00, param_01, param_02) {
  self endon("death");
  self.origin = param_01;
  self setscriptablepartstate(param_02[param_00], "active", 0);
  wait(0.1);
  self setscriptablepartstate(param_02[param_00], "neutral", 0);
}

delayplaySound(param_00, param_01) {
  wait(param_00);
  self playLoopSound(param_01);
}

func_D4BD(param_00, param_01, param_02) {
  var_03 = 100;
  if(param_02 != (0, 0, 0)) {
    for(var_04 = 0; var_04 < 3; var_04++) {
      var_05 = vectornormalize(param_01 - param_02);
      var_05 = var_05 * var_03;
      playFX(param_00, param_02 + var_05);
      var_03 = var_03 + 100;
    }

    playFX(param_00, param_01);
  }
}

deleteaftertime(param_00) {
  self endon("death");
  wait(10);
  self delete();
}

playplanefx() {
  self endon("death");
  wait(0.5);
  playFXOnTag(level.fx_airstrike_afterburner, self, "tag_engine_right");
  wait(0.5);
  playFXOnTag(level.fx_airstrike_afterburner, self, "tag_engine_left");
  wait(0.5);
  playFXOnTag(level.fx_airstrike_contrail, self, "tag_right_wingtip");
  wait(0.5);
  playFXOnTag(level.fx_airstrike_contrail, self, "tag_left_wingtip");
}

callstrike_explosivebullets(param_00, param_01, param_02, param_03, param_04) {
  param_00 endon("death");
  wait(param_03);
  if(!isDefined(param_04) || param_04 scripts\mp\utility::iskillstreakdenied()) {
    return;
  }

  var_05 = anglesToForward(param_00.angles);
  var_06 = spawn("script_model", param_00.origin - (0, 0, 100) - var_05 * 200);
  var_06 linkto(param_00);
  param_00.var_A87B.killcament = var_06;
  wait(0.5);
  var_07 = 50;
  var_08 = (0, 0, 0);
  var_09 = var_08;
  var_0A = ["explode1", "explode2", "explode3", "explode4", "explode5"];
  var_0B = 0;
  for(var_0C = 0; var_0C < var_07; var_0C++) {
    if(!isDefined(param_04)) {
      break;
    }

    var_0D = scripts\common\trace::ray_trace(param_00.turret gettagorigin("tag_flash"), param_00.turrettarget.origin, level.characters, scripts\common\trace::create_contents(0, 1, 0, 1, 0, 1, 0));
    var_0E = var_0D["position"];
    var_08 = var_0E + (0, 0, 2);
    param_00.var_A87B thread func_BCA4(var_0B, var_08, var_0A);
    param_00.turret shootturret();
    var_09 = var_08;
    if(var_0B < 4) {
      var_0B++;
    } else {
      var_0B = 0;
    }

    wait(0.1);
  }
}

callstrike(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = undefined;
  var_08 = 0;
  var_09 = (0, param_03, 0);
  var_07 = getent("airstrikeheight", "targetname");
  if(param_04 == "stealth_airstrike") {
    var_0A = 12000;
    var_0B = 4000;
    if(!isDefined(var_07)) {
      var_0C = 950;
      var_08 = 1500;
      if(isDefined(level.airstrikeheightscale)) {
        var_0C = var_0C * level.airstrikeheightscale;
      }
    } else {
      var_0C = var_08.origin[2];
      if(getdvar("mapname") == "mp_exchange") {
        var_0C = var_0C + 1024;
      }

      if(getdvar("mapname") == "mp_rally") {
        var_0C = var_0C + 2500;
      }

      var_08 = getexplodedistance(var_0C);
    }
  } else {
    var_0A = 24000;
    var_0B = 6500;
    if(!isDefined(var_08)) {
      var_0C = 850;
      var_08 = 1500;
      if(isDefined(level.airstrikeheightscale)) {
        var_0C = var_0C * level.airstrikeheightscale;
      }
    } else {
      var_0C = var_08.origin[2];
      if(getdvar("mapname") == "mp_rally") {
        var_0C = var_0C + 2500;
      }

      var_08 = getexplodedistance(var_0C);
    }
  }

  param_01 endon("disconnect");
  var_0D = param_00;
  level.airstrikedamagedents = [];
  level.airstrikedamagedentscount = 0;
  level.airstrikedamagedentsindex = 0;
  if(param_04 == "jackal") {
    param_02 = param_01.origin;
    var_0E = getflightpath(param_02, var_09, var_0A, var_07, var_0C, var_0B, var_08, param_04);
    param_01 scripts\mp\killstreaks\_jackal::func_2A6B(param_00, var_0E["startPoint"], param_02, param_06);
    return;
  }

  if(param_05 == "precision_airstrike") {
    var_0E = getflightpath(param_03, var_0A, var_0B, var_08, var_0D, var_0C, var_09, param_05);
    var_0F = anglestoright(var_09);
    if(scripts\mp\killstreaks\_utility::func_A69F(param_06, "passive_precision_strike")) {
      level thread func_5A60(param_00, param_01, var_0D, param_02, var_0E["startPoint"], var_0E["endPoint"], var_0E["bombTime"], var_0E["flyTime"], var_09, param_04, param_05, param_06);
      playsoundatpos(var_0E["startPoint"], "ks_scorchers_init");
      wait(randomfloatrange(0.8, 1));
      scripts\mp\hostmigration::waittillhostmigrationdone();
      level thread func_5A60(param_00, param_01, var_0D, param_02, var_0E["startPoint"], var_0E["endPoint"], var_0E["bombTime"], var_0E["flyTime"], var_09, param_04, param_05, param_06);
      wait(randomfloatrange(0.8, 1));
      scripts\mp\hostmigration::waittillhostmigrationdone();
      level thread func_5A60(param_00, param_01, var_0D, param_02, var_0E["startPoint"], var_0E["endPoint"], var_0E["bombTime"], var_0E["flyTime"], var_09, param_04, param_05, param_06);
      return;
    }

    if(scripts\mp\killstreaks\_utility::func_A69F(param_06, "passive_split_strike")) {
      level thread func_5A60(param_00, param_01, var_0D, param_02, var_0E["startPoint"], var_0E["endPoint"], var_0E["bombTime"], var_0E["flyTime"], var_09, param_04, param_05, param_06);
      playsoundatpos(var_0E["startPoint"], "ks_scorchers_init");
      return;
    }

    level thread func_5A60(param_00, param_01, var_0D, param_02, var_0E["startPoint"], var_0E["endPoint"], var_0E["bombTime"], var_0E["flyTime"], var_09, param_04, param_05, param_06);
    playsoundatpos(var_0E["startPoint"], "ks_scorchers_init");
    wait(randomfloatrange(0.5, 0.7));
    scripts\mp\hostmigration::waittillhostmigrationdone();
    level thread func_5A60(param_00, param_01, var_0D, param_02, var_0E["startPoint"] + var_0F * 175, var_0E["endPoint"] + var_0F * 175, var_0E["bombTime"], var_0E["flyTime"], var_09, param_04, param_05, param_06);
    wait(randomfloatrange(0.5, 0.7));
    scripts\mp\hostmigration::waittillhostmigrationdone();
    level thread func_5A60(param_00, param_01, var_0D, param_02, var_0E["startPoint"] - var_0F * 175, var_0E["endPoint"] - var_0F * 175, var_0E["bombTime"], var_0E["flyTime"], var_09, param_04, param_05, param_06);
    return;
  }

  var_0E = getflightpath(param_03, var_0A, var_0B, var_08, var_0D, var_0C, var_09, param_05);
  level thread func_5A60(param_00, param_01, var_0D, param_02, var_0E["startPoint"] + (0, 0, randomint(500)), var_0E["endPoint"] + (0, 0, randomint(500)), var_0E["bombTime"], var_0E["flyTime"], var_09, param_04, param_05, param_06);
  wait(randomfloatrange(1.5, 2.5));
  scripts\mp\hostmigration::waittillhostmigrationdone();
  level thread func_5A60(param_00, param_01, var_0D, param_02, var_0E["startPoint"] + (0, 0, randomint(200)), var_0E["endPoint"] + (0, 0, randomint(200)), var_0E["bombTime"], var_0E["flyTime"], var_09, param_04, param_05, param_06);
  wait(randomfloatrange(1.5, 2.5));
  scripts\mp\hostmigration::waittillhostmigrationdone();
  level thread func_5A60(param_00, param_01, var_0D, param_02, var_0E["startPoint"] + (0, 0, randomint(200)), var_0E["endPoint"] + (0, 0, randomint(200)), var_0E["bombTime"], var_0E["flyTime"], var_09, param_04, param_05, param_06);
  if(param_04 == "super_airstrike") {
    wait(randomfloatrange(2.5, 3.5));
    scripts\mp\hostmigration::waittillhostmigrationdone();
    level thread func_5A60(param_00, param_01, var_0D, param_02, var_0E["startPoint"] + (0, 0, randomint(200)), var_0E["endPoint"] + (0, 0, randomint(200)), var_0E["bombTime"], var_0E["flyTime"], var_09, param_04, param_05, param_06);
    return;
  }
}

getflightpath(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  var_08 = param_00 + anglesToForward(param_01) * -1 * param_02;
  if(isDefined(param_03)) {
    var_08 = var_08 * (1, 1, 0);
  }

  var_08 = var_08 + (0, 0, param_04);
  var_09 = param_00 + anglesToForward(param_01) * param_02;
  if(isDefined(param_03)) {
    var_09 = var_09 * (1, 1, 0);
  }

  var_09 = var_09 + (0, 0, param_04);
  var_0A = length(var_08 - var_09);
  var_0B = var_0A / param_05;
  var_0A = abs(var_0A / 2 + param_06);
  var_0C = var_0A / param_05;
  var_0D["startPoint"] = var_08;
  var_0D["endPoint"] = var_09;
  var_0D["bombTime"] = var_0C;
  var_0D["flyTime"] = var_0B;
  return var_0D;
}

getexplodedistance(param_00) {
  var_01 = 850;
  var_02 = 1500;
  var_03 = var_01 / param_00;
  var_04 = var_03 * var_02;
  return var_04;
}

targetgetdist(param_00, param_01) {
  var_02 = targetisinfront(param_00, param_01);
  if(var_02) {
    var_03 = 1;
  } else {
    var_03 = -1;
  }

  var_04 = scripts\engine\utility::flat_origin(param_00.origin);
  var_05 = var_04 + anglesToForward(scripts\engine\utility::flat_angle(param_00.angles)) * var_03 * 100000;
  var_06 = pointonsegmentnearesttopoint(var_04, var_05, param_01);
  var_07 = distance(var_04, var_06);
  return var_07;
}

targetisclose(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = 3000;
  }

  var_03 = targetisinfront(param_00, param_01);
  if(var_03) {
    var_04 = 1;
  } else {
    var_04 = -1;
  }

  var_05 = scripts\engine\utility::flat_origin(param_00.origin);
  var_06 = var_05 + anglesToForward(scripts\engine\utility::flat_angle(param_00.angles)) * var_04 * 100000;
  var_07 = pointonsegmentnearesttopoint(var_05, var_06, param_01);
  var_08 = distance(var_05, var_07);
  if(var_08 < param_02) {
    return 1;
  }

  return 0;
}

targetisinfront(param_00, param_01) {
  var_02 = anglesToForward(scripts\engine\utility::flat_angle(param_00.angles));
  var_03 = vectornormalize(scripts\engine\utility::flat_origin(param_01) - param_00.origin);
  var_04 = vectordot(var_02, var_03);
  if(var_04 > 0) {
    return 1;
  }

  return 0;
}

waitforairstrikecancel() {
  self waittill("cancel_location");
  self setblurforplayer(0, 0.3);
}

selectairstrikelocation(param_00, param_01, param_02) {
  var_03 = (0, 0, 0);
  var_04 = undefined;
  var_05 = self.angles[1];
  var_06 = undefined;
  var_07 = undefined;
  if(!isDefined(level.mapsize)) {
    return;
  }

  var_08 = level.mapsize / 6.46875;
  if(level.splitscreen) {
    var_08 = var_08 * 1.5;
  }

  var_09 = spawn("script_origin", self.origin);
  var_0A = "used_" + param_01;
  var_0B = scripts\mp\killstreak_loot::getrarityforlootitem(param_02.variantid);
  if(var_0B != "") {
    var_0A = var_0A + "_" + var_0B;
  }

  if(param_01 == "precision_airstrike") {
    var_0C = 1;
    var_07 = 1;
    if(scripts\mp\killstreaks\_utility::func_A69F(param_02, "passive_split_strike")) {
      var_0C = 3;
    }

    scripts\engine\utility::allow_weapon_switch(0);
    if(self.team == "allies") {
      var_0D = "UN_";
    } else {
      var_0D = "PD_";
    }

    self playlocalsound("bombardment_killstreak_bootup");
    var_09 playLoopSound("bombardment_killstreak_hud_loop");
    self setsoundsubmix("mp_killstreak_overlay");
    var_04 = scripts\mp\killstreaks\_mapselect::_meth_8112(param_01, var_0C, 1);
    scripts\engine\utility::allow_weapon_switch(1);
  } else if(param_01 == "jackal" && isDefined(level.var_A056) || level.jackals.size > 1) {
    self notify("cancel_location");
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
    if(isDefined(var_09)) {
      var_09 stoploopsound("");
      var_09 delete();
    }

    self clearsoundsubmix();
    return 0;
  }

  if(isDefined(var_04)) {
    if(scripts\mp\utility::istrue(level.var_1AF9)) {
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
      return 0;
    }

    thread func_6CDD(var_04, var_07, param_00, var_03, var_05, param_01, var_06, param_02);
    self playlocalsound("bombardment_killstreak_shutdown");
    self clearsoundsubmix();
  } else if(!isDefined(var_04) && scripts\mp\utility::func_9E90(param_01)) {
    if(isDefined(var_09)) {
      var_09 stoploopsound("");
      var_09 delete();
    }

    self playlocalsound("bombardment_killstreak_shutdown");
    self clearsoundsubmix();
    return 0;
  } else {
    if(param_01 == "jackal") {
      if(scripts\mp\killstreaks\_jackal::getnumownedjackals(self) >= 1) {
        scripts\mp\hud_message::showerrormessage("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
        if(isDefined(var_09)) {
          var_09 stoploopsound("");
          var_09 delete();
        }

        self clearsoundsubmix();
        return 0;
      }
    }

    finishairstrikeusage(param_00, var_03, var_05, param_01, var_06, param_02);
    if(param_01 == "jackal" && scripts\mp\killstreaks\_utility::func_A69F(param_02, "passive_support_drop")) {
      var_0E = scripts\engine\utility::waittill_any_return("called_in_jackal", "cancel_jackal");
      if(!isDefined(var_0E) || var_0E == "cancel_jackal") {
        return 0;
      }
    }
  }

  if(isDefined(var_09)) {
    var_09 stoploopsound("");
    var_09 delete();
  }

  thread scripts\mp\utility::teamplayercardsplash(var_0A, self);
  scripts\mp\matchdata::logkillstreakevent(param_01, var_03);
  return 1;
}

func_6CDD(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  self endon("disconnect");
  foreach(var_0A, var_09 in param_00) {
    param_03 = var_09.location;
    if(scripts\mp\utility::istrue(param_01)) {
      param_04 = var_09.angles;
    }

    finishairstrikeusage(param_02, param_03, param_04, param_05, param_06, param_07);
    if(param_00.size > 1 && var_0A < param_00.size - 1) {
      wait(randomfloatrange(0.8, 1));
    }
  }
}

finishairstrikeusage(param_00, param_01, param_02, param_03, param_04, param_05) {
  self notify("used");
  var_06 = bulletTrace(level.mapcenter + (0, 0, 1000000), level.mapcenter, 0, undefined);
  param_01 = (param_01[0], param_01[1], var_06["position"][2] - 514);
  thread func_57DD(param_00, param_01, param_02, self, self.pers["team"], param_03, param_04, param_05);
}

useairstrike(param_00, param_01, param_02) {}

handleemp(param_00) {
  self endon("death");
  if(param_00 scripts\mp\killstreaks\_emp_common::isemped()) {
    self notify("death");
    return;
  }

  for(;;) {
    level waittill("emp_update");
    if(!param_00 scripts\mp\killstreaks\_emp_common::isemped()) {
      continue;
    }

    self notify("death");
  }
}

airstrikemadeselectionvo(param_00) {
  self endon("death");
  self endon("disconnect");
  switch (param_00) {
    case "precision_airstrike":
      self playlocalsound(game["voice"][self.team] + "KS_ast_inbound");
      break;
  }
}

func_1AFA(param_00, param_01, param_02, param_03) {
  var_04 = param_03 * 20;
  for(var_05 = 0; var_05 < var_04; var_05++) {
    wait(0.05);
  }
}

func_11A82() {
  self endon("death");
  var_00 = self.origin;
  for(;;) {
    thread func_1AFA(var_00, self.origin, (0.5, 1, 0), 40);
    var_00 = self.origin;
    wait(0.2);
  }
}

triggerjackalweapon(param_00) {
  if(scripts\mp\killstreaks\_utility::func_A69F(param_00, "passive_support_drop")) {
    param_00.var_EF88 = "no_fire_weapon";
    param_00.var_394 = "deploy_warden_mp";
  }

  return 1;
}