/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3462.gsc
***************************************/

init() {
  level.airstrikefx = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.airstrikessfx = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.func_1AF6 = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.func_A87D = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.func_BB68 = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.bombstrike = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.func_1A8D = loadfx("vfx\iw7\_requests\mp\vfx_debug_warning.vfx");
  level.func_A3BA = loadfx("vfx\iw7\core\vehicle\jackal\vfx_jackal_death_01_cheap.vfx");
  level._effect["jackal_explosion"] = loadfx("vfx\iw7\core\mp\killstreaks\vfx_veh_exp_warden.vfx");
  level.jackals = [];
  level.dangermaxradius["precision_airstrike"] = 550;
  level.dangerminradius["precision_airstrike"] = 300;
  level.dangerforwardpush["precision_airstrike"] = 2.0;
  level.dangerovalscale["precision_airstrike"] = 6.0;
  level.artillerydangercenters = [];
  scripts\mp\killstreaks\killstreaks::registerkillstreak("precision_airstrike", ::func_128D4, undefined, undefined, undefined, ::func_13C8A);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("jackal", ::func_128D4, undefined, undefined, ::triggerjackalweapon, ::func_13C8A);
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
    var_1++;
    var_02 = var_02 + var_4.origin[2];
  }

  level.averagealliesz = var_02 / var_01;
}

func_13C8A(var_00) {
  var_01 = undefined;

  if(var_0.streakname == "precision_airstrike") {
    if(scripts\mp\utility\game::istrue(level.func_1AF9)) {
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
      return 0;
    }

    if(scripts\mp\killstreaks\utility::func_A69F(var_00, "passive_precision_strike") || scripts\mp\killstreaks\utility::func_A69F(var_00, "passive_split_strike"))
      var_01 = 1;

    scripts\mp\killstreaks\mapselect::func_10DC2(0, 1, var_01);
  }

  return 1;
}

func_128D4(var_00) {
  if(var_0.streakname == "jackal" && (isDefined(level.func_A22D) || level.jackals.size > 0)) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");

    if(scripts\mp\killstreaks\utility::func_A69F(var_00, "passive_support_drop")) {
      if(isDefined(var_0.weapon) && var_0.weapon != "none")
        self notify("killstreak_finished_with_weapon_" + var_0.weapon);
    }

    return 0;
  }

  var_01 = selectairstrikelocation(var_0.lifeid, var_0.streakname, var_00);

  if(!isDefined(var_01) || !var_01)
    return 0;

  return 1;
}

func_57DD(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  if(var_05 == "precision_airstrike") {
    level.func_1AF9 = 1;
    thread func_1399E();
  }

  var_08 = scripts\engine\trace::ray_trace(var_01, var_01 + (0, 0, -1000000.0));
  var_09 = var_8["position"];
  var_10 = spawnStruct();
  var_10.origin = var_09;
  var_10.forward = anglesToForward((0, var_02, 0));
  var_10.streakname = var_05;
  var_10.team = var_04;
  callstrike(var_00, var_03, var_09, var_02, var_05, var_06, var_07);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(7.5);
  var_11 = 0;
  var_12 = [];

  if(var_05 == "precision_airstrike")
    level.func_1AF9 = undefined;

  self notify("airstrike_finished");

  if(var_05 == "precision_airstrike")
    scripts\mp\utility\game::printgameaction("killstreak ended - precision_airstrike", var_03);
}

func_1399E() {
  self endon("airstrike_finished");
  level endon("game_ended");
  scripts\engine\utility::waittill_any("disconnect", "joined_team");

  if(scripts\mp\utility\game::istrue(level.func_1AF9))
    level.func_1AF9 = undefined;
}

clearprogress(var_00) {
  wait 2.0;
  level.func_1AF9 = undefined;
}

getairstrikedanger(var_00) {
  var_01 = 0;

  for(var_02 = 0; var_02 < level.artillerydangercenters.size; var_2++) {
    var_03 = level.artillerydangercenters[var_02].origin;
    var_04 = level.artillerydangercenters[var_02].forward;
    var_05 = level.artillerydangercenters[var_02].streakname;
    var_01 = var_01 + getsingleairstrikedanger(var_00, var_03, var_04, var_05);
  }

  return var_01;
}

getsingleairstrikedanger(var_00, var_01, var_02, var_03) {
  if(scripts\mp\utility\game::func_9F0F(var_03)) {
    if(distancesquared(var_00, var_01) < level.dangermaxradius[var_03])
      return 1;
    else
      return 0;
  }

  var_04 = var_01 + level.dangerforwardpush[var_03] * level.dangermaxradius[var_03] * var_02;
  var_05 = var_00 - var_04;
  var_05 = (var_5[0], var_5[1], 0);
  var_06 = vectordot(var_05, var_02) * var_02;
  var_07 = var_05 - var_06;
  var_08 = var_07 + var_06 / level.dangerovalscale[var_03];
  var_09 = lengthsquared(var_08);

  if(var_09 > level.dangermaxradius[var_03] * level.dangermaxradius[var_03])
    return 0;

  if(var_09 < level.dangerminradius[var_03] * level.dangerminradius[var_03])
    return 1;

  var_10 = sqrt(var_09);
  var_11 = (var_10 - level.dangerminradius[var_03]) / (level.dangermaxradius[var_03] - level.dangerminradius[var_03]);
  return 1 - var_11;
}

pointisinairstrikearea(var_00, var_01, var_02, var_03) {
  return distance2d(var_00, var_01) <= level.dangermaxradius[var_03] * 1.25;
}

losradiusdamage(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  var_07 = scripts\mp\weapons::getdamageableents(var_00, var_01, 1);
  glassradiusdamage(var_00, var_01, var_02, var_03);

  for(var_08 = 0; var_08 < var_7.size; var_8++) {
    if(var_7[var_08].entity == self) {
      continue;
    }
    var_09 = distance(var_00, var_7[var_08].damagecenter);

    if(var_7[var_08].isplayer || isDefined(var_7[var_08].issentry) && var_7[var_08].issentry) {
      var_10 = !bullettracepassed(var_7[var_08].entity.origin, var_7[var_08].entity.origin + (0, 0, 130), 0, undefined);

      if(var_10) {
        var_10 = !bullettracepassed(var_7[var_08].entity.origin + (0, 0, 130), var_00 + (0, 0, 114), 0, undefined);

        if(var_10) {
          var_09 = var_09 * 4;

          if(var_09 > var_01)
            continue;
        }
      }
    }

    var_7[var_08].damage = int(var_02 + (var_03 - var_02) * var_09 / var_01);
    var_7[var_08].pos = var_00;
    var_7[var_08].damageowner = var_04;
    var_7[var_08].einflictor = var_05;
    level.airstrikedamagedents[level.airstrikedamagedentscount] = var_7[var_08];
    level.airstrikedamagedentscount++;
  }

  thread airstrikedamageentsthread(var_06);
}

airstrikedamageentsthread(var_00) {
  self notify("airstrikeDamageEntsThread");
  self endon("airstrikeDamageEntsThread");

  while(level.airstrikedamagedentsindex < level.airstrikedamagedentscount) {
    if(!isDefined(level.airstrikedamagedents[level.airstrikedamagedentsindex])) {} else {
      var_01 = level.airstrikedamagedents[level.airstrikedamagedentsindex];

      if(!isDefined(var_1.entity)) {} else if(!var_1.isplayer || isalive(var_1.entity)) {
        var_01 scripts\mp\weapons::damageent(var_1.einflictor, var_1.damageowner, var_1.damage, "MOD_PROJECTILE_SPLASH", var_00, var_1.pos, vectornormalize(var_1.damagecenter - var_1.pos));
        level.airstrikedamagedents[level.airstrikedamagedentsindex] = undefined;

        if(var_1.isplayer)
          wait 0.05;
      } else
        level.airstrikedamagedents[level.airstrikedamagedentsindex] = undefined;
    }

    level.airstrikedamagedentsindex++;
  }
}

radiusartilleryshellshock(var_00, var_01, var_02, var_03, var_04) {
  var_05 = level.players;

  foreach(var_07 in level.players) {
    if(!isalive(var_07)) {
      continue;
    }
    if(var_7.team == var_04 || var_7.team == "spectator") {
      continue;
    }
    var_08 = var_7.origin + (0, 0, 32);
    var_09 = distance(var_00, var_08);

    if(var_09 > var_01) {
      continue;
    }
    var_10 = int(var_02 + (var_03 - var_02) * var_09 / var_01);
    var_07 thread artilleryshellshock("default", var_10);
  }
}

artilleryshellshock(var_00, var_01) {
  self endon("disconnect");

  if(isDefined(self.beingartilleryshellshocked) && self.beingartilleryshellshocked) {
    return;
  }
  self.beingartilleryshellshocked = 1;
  self shellshock(var_00, var_01);
  wait(var_01 + 1);
  self.beingartilleryshellshocked = 0;
}

func_3786(var_00, var_01, var_02, var_03) {
  if(!isDefined(var_01) || var_01 scripts\mp\utility\game::iskillstreakdenied()) {
    self notify("stop_bombing");
    return;
  }

  var_04 = 512;
  var_05 = (0, randomint(360), 0);
  var_06 = var_00 + anglesToForward(var_05) * randomfloat(var_04);
  var_07 = bulletTrace(var_06, var_06 + (0, 0, -10000), 0, undefined);
  var_06 = var_7["position"];
  var_08 = distance(var_00, var_06);

  if(var_08 > 5000) {
    return;
  }
  wait(0.85 * (var_08 / 2000));

  if(!isDefined(var_01) || var_01 scripts\mp\utility\game::iskillstreakdenied()) {
    self notify("stop_bombing");
    return;
  }

  if(var_03) {
    playFX(level.func_BB68, var_06);
    level thread scripts\mp\shellshock::func_10F44(var_06);
  }

  thread scripts\mp\utility\game::playsoundinspace("exp_airstrike_bomb", var_06);
  radiusartilleryshellshock(var_06, 512, 8, 4, var_1.team);
  losradiusdamage(var_06 + (0, 0, 16), 896, 300, 50, var_01, self, "stealth_bomb_mp");
}

func_5A60(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11) {
  if(!isDefined(var_01)) {
    return;
  }
  var_12 = 100;
  var_13 = 150;
  var_14 = var_04;
  var_15 = var_05;
  var_16 = "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
  var_17 = scripts\mp\killstreak_loot::getrarityforlootitem(var_11.variantid);

  if(var_17 != "")
    var_16 = var_16 + "_" + var_17;

  var_18 = spawn("script_model", var_14);
  var_18 setModel(var_16);
  var_18.owner = var_01;
  var_18.origin = var_14;
  var_18.angles = var_08;
  var_18.team = var_1.team;
  var_18.lifeid = var_00;
  var_18.streakinfo = var_11;
  var_18 setotherent(var_01);
  var_18 _meth_8549();
  var_18 _meth_8594();
  var_18 _meth_8548();
  var_18 scripts\mp\killstreaks\utility::func_1843(var_09, "Killstreak_Air", var_01, 1, "kill_outline");
  var_18 thread handleemp(var_01);

  if(var_09 == "precision_airstrike") {
    var_19 = "jackal_airstrike_turret_mp";
    var_20 = "vehicle_battle_hind_mg_mp";
    var_21 = "tag_bottom_light";
    var_22 = "icon_minimap_scorcher_friendly";

    if(scripts\mp\killstreaks\utility::func_A69F(var_11, "passive_speed_cost"))
      var_07 = var_07 - 1;

    var_18.minimapid = var_18 scripts\mp\killstreaks\airdrop::createobjective(var_22, undefined, undefined, 1, 1);
    var_18.turret = spawnturret("misc_turret", var_18 gettagorigin(var_21), var_19);
    var_18.turret setModel(var_20);
    var_18.turret.owner = var_01;
    var_18.turret.angles = var_18.angles;
    var_18.turret linkto(var_18, var_21, (0, 0, 30), (0, 0, 0));
    var_18.turret setturretmodechangewait(0);
    var_18.turret give_player_session_tokens("manual_target");
    var_18.turret setsentryowner(var_01);
    var_18.turrettarget = spawn("script_model", var_18.origin + anglesToForward(var_18.angles) * 1000 - (0, 0, 10000));
    var_18.turrettarget linkto(var_18);
    var_18.func_A87B = spawn("script_model", var_18.turrettarget.origin);
    var_18.func_A87B setModel("ks_scorchers_target_mp");
    var_18.func_A87B setentityowner(var_01);
    var_18.func_A87B.weapon_name = "artillery_mp";
    var_18.func_A87B.streakinfo = var_11;
    var_18.turret settargetentity(var_18.turrettarget);
  }

  var_18 moveto(var_15, var_07, 0, 0);

  if(var_09 == "precision_airstrike") {
    var_18 setscriptablepartstate("thrusters", "idle", 0);
    thread func_3788(var_18, var_15, var_07, var_06 - 1.5, var_01);
    wait(var_06 + 1);
  } else {
    var_18 setscriptablepartstate("thrusters", "idle", 0);
    thread callstrike_bombeffect(var_18, var_15, var_07, var_06 - 1.0, var_01, var_02, var_09, var_10);
    wait(var_06 - 0.75);
  }

  if(var_09 != "jackal")
    var_18 scriptmodelplayanimdeltamotion("airstrike_mp_roll", 1);

  var_18 thread func_5115(2.5, "kill_outline");
  var_18 endon("death");
  wait(var_07 - var_06);
  var_18 setscriptablepartstate("thrusters", "neutral", 0);

  if(isDefined(var_18.minimapid))
    scripts\mp\objidpoolmanager::returnminimapid(var_18.minimapid);

  var_18 notify("delete");

  if(isDefined(var_18.turret))
    var_18.turret delete();

  if(isDefined(var_18.turrettarget))
    var_18.turrettarget delete();

  if(isDefined(var_18.func_A87B)) {
    var_18.func_A87B delete();

    if(isDefined(var_18.func_A87B.killcament))
      var_18.func_A87B.killcament delete();
  }

  if(isDefined(var_18))
    var_18 delete();
}

func_5115(var_00, var_01) {
  self endon("death");
  wait(var_00);
  self notify(var_01);
}

handledeath() {
  level endon("game_ended");
  self endon("delete");
  self waittill("death");
  var_00 = anglesToForward(self.angles) * 200;
  playFX(level.harrier_deathfx, self.origin, var_00);
  self delete();
}

addplanetolist(var_00) {
  level.planes[level.planes.size] = var_00;
}

removeplanefromlist(var_00) {
  for(var_01 = 0; var_01 < level.planes.size; var_1++) {
    if(isDefined(level.planes[var_01]) && level.planes[var_01] == var_00)
      level.planes[var_01] = undefined;
  }
}

callstrike_bombeffect(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  var_00 endon("death");
  wait(var_03);

  if(!isDefined(var_04) || var_04 scripts\mp\utility\game::iskillstreakdenied()) {
    return;
  }
  var_08 = anglesToForward(var_0.angles);
  var_09 = spawnbomb(var_0.origin, var_0.angles);
  var_09 movegravity(anglesToForward(var_0.angles) * 4666.67, 3.0);
  var_9.lifeid = var_05;
  var_10 = spawn("script_model", var_0.origin + (0, 0, 100) - var_08 * 200);
  var_9.killcament = var_10;
  var_9.killcament setscriptmoverkillcam("airstrike");
  var_9.func_1AFE = var_06;
  var_10.starttime = gettime();
  var_10 thread deleteaftertime(15.0);
  var_10.angles = var_08;
  var_10 moveto(var_01 + (0, 0, 100), var_02, 0, 0);
  wait 0.4;
  var_10 moveto(var_10.origin + var_08 * 4000, 1, 0, 0);
  wait 0.45;
  var_10 moveto(var_10.origin + (var_08 + (0, 0, -0.2)) * 3500, 2, 0, 0);
  wait 0.15;
  var_11 = spawn("script_model", var_9.origin);
  var_11 setModel("tag_origin");
  var_11.origin = var_9.origin;
  var_11.angles = var_9.angles;
  var_09 setModel("tag_origin");
  wait 0.1;
  var_12 = var_11.origin;
  var_13 = var_11.angles;

  if(level.splitscreen)
    playFXOnTag(level.airstrikessfx, var_11, "tag_origin");
  else
    playFXOnTag(level.airstrikefx, var_11, "tag_origin");

  wait 0.05;
  var_10 moveto(var_10.origin + (var_08 + (0, 0, -0.25)) * 2500, 2, 0, 0);
  wait 0.25;
  var_10 moveto(var_10.origin + (var_08 + (0, 0, -0.35)) * 2000, 2, 0, 0);
  wait 0.2;
  var_10 moveto(var_10.origin + (var_08 + (0, 0, -0.45)) * 1500, 2, 0, 0);
  wait 0.5;

  if(isDefined(var_07))
    var_07 delete();

  var_14 = 12;
  var_15 = 5;
  var_16 = 55;
  var_17 = (var_16 - var_15) / var_14;
  var_18 = (0, 0, 0);

  for(var_19 = 0; var_19 < var_14; var_19++) {
    var_20 = anglesToForward(var_13 + (var_16 - var_17 * var_19, randomint(10) - 5, 0));
    var_21 = var_12 + var_20 * 10000;
    var_22 = bulletTrace(var_12, var_21, 0, undefined);
    var_23 = var_22["position"];
    var_18 = var_18 + var_23;
    playFX(level.func_1AF6, var_23);
    thread losradiusdamage(var_23 + (0, 0, 16), 512, 200, 30, var_04, var_09, "artillery_mp");

    if(var_19 % 3 == 0) {
      thread scripts\mp\utility\game::playsoundinspace("jackal_missile_impact", var_23);
      level thread scripts\mp\shellshock::airstrike_earthquake(var_23);
    }

    wait 0.05;
  }

  var_18 = var_18 / var_14 + (0, 0, 128);
  var_10 moveto(var_9.killcament.origin * 0.35 + var_18 * 0.65, 1.5, 0, 0.5);
  wait 5.0;
  var_11 delete();
  var_09 delete();
}

spawnbomb(var_00, var_01) {
  var_02 = spawn("script_model", var_00);
  var_2.angles = var_01;
  var_02 setModel("projectile_cbu97_clusterbomb");
  return var_02;
}

func_3788(var_00, var_01, var_02, var_03, var_04) {
  var_00 endon("death");
  wait(var_03);

  if(!isDefined(var_04) || var_04 scripts\mp\utility\game::iskillstreakdenied()) {
    return;
  }
  var_05 = anglesToForward(var_0.angles);
  var_06 = spawn("script_model", var_0.origin - (0, 0, 100) - var_05 * 200);
  var_06 linkto(var_00);
  var_0.func_A87B.killcament = var_06;
  wait 0.5;
  var_07 = 50;
  var_08 = (0, 0, 0);
  var_09 = var_08;
  var_0.turret setscriptablepartstate("fire", "start", 0);
  var_0.func_A87B setscriptablepartstate("beam impact", "active", 0);
  var_10 = ["explode1", "explode2", "explode3", "explode4", "explode5"];
  var_11 = 0;

  for(var_12 = 0; var_12 < var_07; var_12++) {
    if(!isDefined(var_04)) {
      break;
    }
    var_13 = scripts\engine\trace::ray_trace(var_0.turret gettagorigin("tag_flash"), var_0.turrettarget.origin, level.characters, scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0));
    var_14 = var_13["position"];
    var_08 = var_14 + (0, 0, 2);
    var_0.func_A87B thread func_BCA4(var_11, var_08, var_10);
    var_0.turret shootturret();
    var_09 = var_08;

    if(var_11 < 4)
      var_11++;
    else
      var_11 = 0;

    wait 0.05;
  }

  var_0.turret setscriptablepartstate("fire", "stop", 0);
}

func_BCA4(var_00, var_01, var_02) {
  self endon("death");
  self.origin = var_01;
  self setscriptablepartstate(var_2[var_00], "active", 0);
  wait 0.1;
  self setscriptablepartstate(var_2[var_00], "neutral", 0);
}

delayplaySound(var_00, var_01) {
  wait(var_00);
  self playLoopSound(var_01);
}

func_D4BD(var_00, var_01, var_02) {
  var_03 = 100;

  if(var_02 != (0, 0, 0)) {
    for(var_04 = 0; var_04 < 3; var_4++) {
      var_05 = vectornormalize(var_01 - var_02);
      var_05 = var_05 * var_03;
      playFX(var_00, var_02 + var_05);
      var_03 = var_03 + 100;
    }

    playFX(var_00, var_01);
  }
}

deleteaftertime(var_00) {
  self endon("death");
  wait 10.0;
  self delete();
}

playplanefx() {
  self endon("death");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_afterburner, self, "tag_engine_right");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_afterburner, self, "tag_engine_left");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_contrail, self, "tag_right_wingtip");
  wait 0.5;
  playFXOnTag(level.fx_airstrike_contrail, self, "tag_left_wingtip");
}

callstrike_explosivebullets(var_00, var_01, var_02, var_03, var_04) {
  var_00 endon("death");
  wait(var_03);

  if(!isDefined(var_04) || var_04 scripts\mp\utility\game::iskillstreakdenied()) {
    return;
  }
  var_05 = anglesToForward(var_0.angles);
  var_06 = spawn("script_model", var_0.origin - (0, 0, 100) - var_05 * 200);
  var_06 linkto(var_00);
  var_0.func_A87B.killcament = var_06;
  wait 0.5;
  var_07 = 50;
  var_08 = (0, 0, 0);
  var_09 = var_08;
  var_10 = ["explode1", "explode2", "explode3", "explode4", "explode5"];
  var_11 = 0;

  for(var_12 = 0; var_12 < var_07; var_12++) {
    if(!isDefined(var_04)) {
      break;
    }
    var_13 = scripts\engine\trace::ray_trace(var_0.turret gettagorigin("tag_flash"), var_0.turrettarget.origin, level.characters, scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0));
    var_14 = var_13["position"];
    var_08 = var_14 + (0, 0, 2);
    var_0.func_A87B thread func_BCA4(var_11, var_08, var_10);
    var_0.turret shootturret();
    var_09 = var_08;

    if(var_11 < 4)
      var_11++;
    else
      var_11 = 0;

    wait 0.1;
  }
}

callstrike(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  var_07 = undefined;
  var_08 = 0;
  var_09 = (0, var_03, 0);
  var_07 = getent("airstrikeheight", "targetname");

  if(var_04 == "stealth_airstrike") {
    var_10 = 12000;
    var_11 = 4000;

    if(!isDefined(var_07)) {
      var_12 = 950;
      var_08 = 1500;

      if(isDefined(level.airstrikeheightscale))
        var_12 = var_12 * level.airstrikeheightscale;
    } else {
      var_12 = var_7.origin[2];

      if(getdvar("mapname") == "mp_exchange")
        var_12 = var_12 + 1024;

      if(getdvar("mapname") == "mp_rally")
        var_12 = var_12 + 2500;

      var_08 = getexplodedistance(var_12);
    }
  } else {
    var_10 = 24000;
    var_11 = 6500;

    if(!isDefined(var_07)) {
      var_12 = 850;
      var_08 = 1500;

      if(isDefined(level.airstrikeheightscale))
        var_12 = var_12 * level.airstrikeheightscale;
    } else {
      var_12 = var_7.origin[2];

      if(getdvar("mapname") == "mp_rally")
        var_12 = var_12 + 2500;

      var_08 = getexplodedistance(var_12);
    }
  }

  var_01 endon("disconnect");
  var_13 = var_00;
  level.airstrikedamagedents = [];
  level.airstrikedamagedentscount = 0;
  level.airstrikedamagedentsindex = 0;

  if(var_04 == "jackal") {
    var_02 = var_1.origin;
    var_14 = getflightpath(var_02, var_09, var_10, var_07, var_12, var_11, var_08, var_04);
    var_01 scripts\mp\killstreaks\jackal::func_2A6B(var_00, var_14["startPoint"], var_02, var_06);
  } else if(var_04 == "precision_airstrike") {
    var_14 = getflightpath(var_02, var_09, var_10, var_07, var_12, var_11, var_08, var_04);
    var_15 = anglestoright(var_09);

    if(scripts\mp\killstreaks\utility::func_A69F(var_06, "passive_precision_strike")) {
      level thread func_5A60(var_00, var_01, var_13, var_02, var_14["startPoint"], var_14["endPoint"], var_14["bombTime"], var_14["flyTime"], var_09, var_04, var_05, var_06);
      playLoopSound(var_14["startPoint"], "ks_scorchers_init");
      wait(randomfloatrange(0.8, 1.0));
      scripts\mp\hostmigration::waittillhostmigrationdone();
      level thread func_5A60(var_00, var_01, var_13, var_02, var_14["startPoint"], var_14["endPoint"], var_14["bombTime"], var_14["flyTime"], var_09, var_04, var_05, var_06);
      wait(randomfloatrange(0.8, 1.0));
      scripts\mp\hostmigration::waittillhostmigrationdone();
      level thread func_5A60(var_00, var_01, var_13, var_02, var_14["startPoint"], var_14["endPoint"], var_14["bombTime"], var_14["flyTime"], var_09, var_04, var_05, var_06);
      return;
    }

    if(scripts\mp\killstreaks\utility::func_A69F(var_06, "passive_split_strike")) {
      level thread func_5A60(var_00, var_01, var_13, var_02, var_14["startPoint"], var_14["endPoint"], var_14["bombTime"], var_14["flyTime"], var_09, var_04, var_05, var_06);
      playLoopSound(var_14["startPoint"], "ks_scorchers_init");
      return;
    }

    level thread func_5A60(var_00, var_01, var_13, var_02, var_14["startPoint"], var_14["endPoint"], var_14["bombTime"], var_14["flyTime"], var_09, var_04, var_05, var_06);
    playLoopSound(var_14["startPoint"], "ks_scorchers_init");
    wait(randomfloatrange(0.5, 0.7));
    scripts\mp\hostmigration::waittillhostmigrationdone();
    level thread func_5A60(var_00, var_01, var_13, var_02, var_14["startPoint"] + var_15 * 175, var_14["endPoint"] + var_15 * 175, var_14["bombTime"], var_14["flyTime"], var_09, var_04, var_05, var_06);
    wait(randomfloatrange(0.5, 0.7));
    scripts\mp\hostmigration::waittillhostmigrationdone();
    level thread func_5A60(var_00, var_01, var_13, var_02, var_14["startPoint"] - var_15 * 175, var_14["endPoint"] - var_15 * 175, var_14["bombTime"], var_14["flyTime"], var_09, var_04, var_05, var_06);
    return;
    return;
  } else {
    var_14 = getflightpath(var_02, var_09, var_10, var_07, var_12, var_11, var_08, var_04);
    level thread func_5A60(var_00, var_01, var_13, var_02, var_14["startPoint"] + (0, 0, randomint(500)), var_14["endPoint"] + (0, 0, randomint(500)), var_14["bombTime"], var_14["flyTime"], var_09, var_04, var_05, var_06);
    wait(randomfloatrange(1.5, 2.5));
    scripts\mp\hostmigration::waittillhostmigrationdone();
    level thread func_5A60(var_00, var_01, var_13, var_02, var_14["startPoint"] + (0, 0, randomint(200)), var_14["endPoint"] + (0, 0, randomint(200)), var_14["bombTime"], var_14["flyTime"], var_09, var_04, var_05, var_06);
    wait(randomfloatrange(1.5, 2.5));
    scripts\mp\hostmigration::waittillhostmigrationdone();
    level thread func_5A60(var_00, var_01, var_13, var_02, var_14["startPoint"] + (0, 0, randomint(200)), var_14["endPoint"] + (0, 0, randomint(200)), var_14["bombTime"], var_14["flyTime"], var_09, var_04, var_05, var_06);

    if(var_04 == "super_airstrike") {
      wait(randomfloatrange(2.5, 3.5));
      scripts\mp\hostmigration::waittillhostmigrationdone();
      level thread func_5A60(var_00, var_01, var_13, var_02, var_14["startPoint"] + (0, 0, randomint(200)), var_14["endPoint"] + (0, 0, randomint(200)), var_14["bombTime"], var_14["flyTime"], var_09, var_04, var_05, var_06);
    }
  }
}

getflightpath(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  var_08 = var_00 + anglesToForward(var_01) * (-1 * var_02);

  if(isDefined(var_03))
    var_08 = var_08 * (1, 1, 0);

  var_08 = var_08 + (0, 0, var_04);
  var_09 = var_00 + anglesToForward(var_01) * var_02;

  if(isDefined(var_03))
    var_09 = var_09 * (1, 1, 0);

  var_09 = var_09 + (0, 0, var_04);
  var_10 = length(var_08 - var_09);
  var_11 = var_10 / var_05;
  var_10 = abs(var_10 / 2 + var_06);
  var_12 = var_10 / var_05;
  var_13["startPoint"] = var_08;
  var_13["endPoint"] = var_09;
  var_13["bombTime"] = var_12;
  var_13["flyTime"] = var_11;
  return var_13;
}

getexplodedistance(var_00) {
  var_01 = 850;
  var_02 = 1500;
  var_03 = var_01 / var_00;
  var_04 = var_03 * var_02;
  return var_04;
}

targetgetdist(var_00, var_01) {
  var_02 = targetisinfront(var_00, var_01);

  if(var_02)
    var_03 = 1;
  else
    var_03 = -1;

  var_04 = scripts\engine\utility::flat_origin(var_0.origin);
  var_05 = var_04 + anglesToForward(scripts\engine\utility::flat_angle(var_0.angles)) * (var_03 * 100000);
  var_06 = pointonsegmentnearesttopoint(var_04, var_05, var_01);
  var_07 = distance(var_04, var_06);
  return var_07;
}

targetisclose(var_00, var_01, var_02) {
  if(!isDefined(var_02))
    var_02 = 3000;

  var_03 = targetisinfront(var_00, var_01);

  if(var_03)
    var_04 = 1;
  else
    var_04 = -1;

  var_05 = scripts\engine\utility::flat_origin(var_0.origin);
  var_06 = var_05 + anglesToForward(scripts\engine\utility::flat_angle(var_0.angles)) * (var_04 * 100000);
  var_07 = pointonsegmentnearesttopoint(var_05, var_06, var_01);
  var_08 = distance(var_05, var_07);

  if(var_08 < var_02)
    return 1;
  else
    return 0;
}

targetisinfront(var_00, var_01) {
  var_02 = anglesToForward(scripts\engine\utility::flat_angle(var_0.angles));
  var_03 = vectornormalize(scripts\engine\utility::flat_origin(var_01) - var_0.origin);
  var_04 = vectordot(var_02, var_03);

  if(var_04 > 0)
    return 1;
  else
    return 0;
}

waitforairstrikecancel() {
  self waittill("cancel_location");
  self setblurforplayer(0, 0.3);
}

selectairstrikelocation(var_00, var_01, var_02) {
  var_03 = (0, 0, 0);
  var_04 = undefined;
  var_05 = self.angles[1];
  var_06 = undefined;
  var_07 = undefined;

  if(!isDefined(level.mapsize)) {
    return;
  }
  var_08 = level.mapsize / 6.46875;

  if(level.splitscreen)
    var_08 = var_08 * 1.5;

  var_09 = spawn("script_origin", self.origin);
  var_10 = "used_" + var_01;
  var_11 = scripts\mp\killstreak_loot::getrarityforlootitem(var_2.variantid);

  if(var_11 != "")
    var_10 = var_10 + "_" + var_11;

  if(var_01 == "precision_airstrike") {
    var_12 = 1;
    var_07 = 1;

    if(scripts\mp\killstreaks\utility::func_A69F(var_02, "passive_split_strike"))
      var_12 = 3;

    scripts\engine\utility::allow_weapon_switch(0);

    if(self.team == "allies")
      var_13 = "UN_";
    else
      var_13 = "PD_";

    self playlocalsound("bombardment_killstreak_bootup");
    var_09 playLoopSound("bombardment_killstreak_hud_loop");
    self setsoundsubmix("mp_killstreak_overlay");
    var_04 = scripts\mp\killstreaks\mapselect::_meth_8112(var_01, var_12, 1);
    scripts\engine\utility::allow_weapon_switch(1);
  } else if(var_01 == "jackal" && (isDefined(level.func_A056) || level.jackals.size > 1)) {
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
    if(scripts\mp\utility\game::istrue(level.func_1AF9)) {
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
      return 0;
    }

    thread func_6CDD(var_04, var_07, var_00, var_03, var_05, var_01, var_06, var_02);
    self playlocalsound("bombardment_killstreak_shutdown");
    self clearsoundsubmix();
  } else if(!isDefined(var_04) && scripts\mp\utility\game::func_9E90(var_01)) {
    if(isDefined(var_09)) {
      var_09 stoploopsound("");
      var_09 delete();
    }

    self playlocalsound("bombardment_killstreak_shutdown");
    self clearsoundsubmix();
    return 0;
  } else {
    if(var_01 == "jackal") {
      if(scripts\mp\killstreaks\jackal::getnumownedjackals(self) >= 1) {
        scripts\mp\hud_message::showerrormessage("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");

        if(isDefined(var_09)) {
          var_09 stoploopsound("");
          var_09 delete();
        }

        self clearsoundsubmix();
        return 0;
      }
    }

    finishairstrikeusage(var_00, var_03, var_05, var_01, var_06, var_02);

    if(var_01 == "jackal" && scripts\mp\killstreaks\utility::func_A69F(var_02, "passive_support_drop")) {
      var_14 = scripts\engine\utility::waittill_any_return("called_in_jackal", "cancel_jackal");

      if(!isDefined(var_14) || var_14 == "cancel_jackal")
        return 0;
    }
  }

  if(isDefined(var_09)) {
    var_09 stoploopsound("");
    var_09 delete();
  }

  thread scripts\mp\utility\game::teamplayercardsplash(var_10, self);
  scripts\mp\matchdata::logkillstreakevent(var_01, var_03);
  return 1;
}

func_6CDD(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  self endon("disconnect");

  foreach(var_10, var_09 in var_00) {
    var_03 = var_9.location;

    if(scripts\mp\utility\game::istrue(var_01))
      var_04 = var_9.angles;

    finishairstrikeusage(var_02, var_03, var_04, var_05, var_06, var_07);

    if(var_0.size > 1 && var_10 < var_0.size - 1)
      wait(randomfloatrange(0.8, 1.0));
  }
}

finishairstrikeusage(var_00, var_01, var_02, var_03, var_04, var_05) {
  self notify("used");
  var_06 = bulletTrace(level.mapcenter + (0, 0, 1000000.0), level.mapcenter, 0, undefined);
  var_01 = (var_1[0], var_1[1], var_6["position"][2] - 514);
  thread func_57DD(var_00, var_01, var_02, self, self.pers["team"], var_03, var_04, var_05);
}

useairstrike(var_00, var_01, var_02) {}

handleemp(var_00) {
  self endon("death");

  if(var_00 scripts\mp\killstreaks\emp_common::isemped()) {
    self notify("death");
    return;
  }

  for(;;) {
    level waittill("emp_update");

    if(!var_00 scripts\mp\killstreaks\emp_common::isemped()) {
      continue;
    }
    self notify("death");
  }
}

airstrikemadeselectionvo(var_00) {
  self endon("death");
  self endon("disconnect");

  switch (var_00) {
    case "precision_airstrike":
      self playlocalsound(game["voice"][self.team] + "KS_ast_inbound");
      break;
  }
}

func_1AFA(var_00, var_01, var_02, var_03) {
  var_04 = var_03 * 20;

  for(var_05 = 0; var_05 < var_04; var_5++)
    wait 0.05;
}

func_11A82() {
  self endon("death");
  var_00 = self.origin;

  for(;;) {
    thread func_1AFA(var_00, self.origin, (0.5, 1, 0), 40);
    var_00 = self.origin;
    wait 0.2;
  }
}

triggerjackalweapon(var_00) {
  if(scripts\mp\killstreaks\utility::func_A69F(var_00, "passive_support_drop")) {
    var_0.func_EF88 = "no_fire_weapon";
    var_0.weapon = "deploy_warden_mp";
  }

  return 1;
}