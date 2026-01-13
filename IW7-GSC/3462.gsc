/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3462.gsc
**************************************/

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
  level.dangerforwardpush["precision_airstrike"] = 2.0;
  level.dangerovalscale["precision_airstrike"] = 6.0;
  level.artillerydangercenters = [];
  scripts\mp\killstreaks\killstreaks::registerkillstreak("precision_airstrike", ::func_128D4, undefined, undefined, undefined, ::func_13C8A);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("jackal", ::func_128D4, undefined, undefined, ::triggerjackalweapon, ::func_13C8A);
  var_0 = ["passive_precision_strike", "passive_increased_speed", "passive_decreased_damage", "passive_split_strike", "passive_increased_cost", "passive_one_plane", "passive_speed_cost"];
  scripts\mp\killstreak_loot::func_DF07("precision_airstrike", var_0);
  var_1 = ["passive_extra_flare", "passive_decreased_duration", "passive_moving_fortress", "passive_no_cannon", "passive_slow_turret", "passive_support_drop"];
  scripts\mp\killstreak_loot::func_DF07("jackal", var_1);
  level.planes = [];
  level thread func_7DE9();
}

func_7DE9() {
  var_0 = scripts\mp\spawnlogic::getspawnpointarray("mp_tdm_spawn_allies_start");
  var_1 = 0;
  var_2 = 0;

  foreach(var_4 in var_0) {
    var_1++;
    var_2 = var_2 + var_4.origin[2];
  }

  level.averagealliesz = var_2 / var_1;
}

func_13C8A(var_0) {
  var_1 = undefined;

  if(var_0.streakname == "precision_airstrike") {
    if(scripts\mp\utility\game::istrue(level.var_1AF9)) {
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
      return 0;
    }

    if(scripts\mp\killstreaks\utility::func_A69F(var_0, "passive_precision_strike") || scripts\mp\killstreaks\utility::func_A69F(var_0, "passive_split_strike")) {
      var_1 = 1;
    }

    scripts\mp\killstreaks\mapselect::func_10DC2(0, 1, var_1);
  }

  return 1;
}

func_128D4(var_0) {
  if(var_0.streakname == "jackal" && (isDefined(level.var_A22D) || level.jackals.size > 0)) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");

    if(scripts\mp\killstreaks\utility::func_A69F(var_0, "passive_support_drop")) {
      if(isDefined(var_0.weapon) && var_0.weapon != "none") {
        self notify("killstreak_finished_with_weapon_" + var_0.weapon);
      }
    }

    return 0;
  }

  var_1 = selectairstrikelocation(var_0.lifeid, var_0.streakname, var_0);

  if(!isDefined(var_1) || !var_1) {
    return 0;
  }

  return 1;
}

func_57DD(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(var_5 == "precision_airstrike") {
    level.var_1AF9 = 1;
    thread func_1399E();
  }

  var_8 = scripts\engine\trace::ray_trace(var_1, var_1 + (0, 0, -1000000.0));
  var_9 = var_8["position"];
  var_10 = spawnStruct();
  var_10.origin = var_9;
  var_10.forward = anglesToForward((0, var_2, 0));
  var_10.streakname = var_5;
  var_10.team = var_4;
  callstrike(var_0, var_3, var_9, var_2, var_5, var_6, var_7);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(7.5);
  var_11 = 0;
  var_12 = [];

  if(var_5 == "precision_airstrike") {
    level.var_1AF9 = undefined;
  }

  self notify("airstrike_finished");

  if(var_5 == "precision_airstrike") {
    scripts\mp\utility\game::printgameaction("killstreak ended - precision_airstrike", var_3);
  }
}

func_1399E() {
  self endon("airstrike_finished");
  level endon("game_ended");
  scripts\engine\utility::waittill_any("disconnect", "joined_team");

  if(scripts\mp\utility\game::istrue(level.var_1AF9)) {
    level.var_1AF9 = undefined;
  }
}

clearprogress(var_0) {
  wait 2.0;
  level.var_1AF9 = undefined;
}

getairstrikedanger(var_0) {
  var_1 = 0;

  for(var_2 = 0; var_2 < level.artillerydangercenters.size; var_2++) {
    var_3 = level.artillerydangercenters[var_2].origin;
    var_4 = level.artillerydangercenters[var_2].forward;
    var_5 = level.artillerydangercenters[var_2].streakname;
    var_1 = var_1 + getsingleairstrikedanger(var_0, var_3, var_4, var_5);
  }

  return var_1;
}

getsingleairstrikedanger(var_0, var_1, var_2, var_3) {
  if(scripts\mp\utility\game::func_9F0F(var_3)) {
    if(distancesquared(var_0, var_1) < level.dangermaxradius[var_3]) {
      return 1;
    } else {
      return 0;
    }
  }

  var_4 = var_1 + level.dangerforwardpush[var_3] * level.dangermaxradius[var_3] * var_2;
  var_5 = var_0 - var_4;
  var_5 = (var_5[0], var_5[1], 0);
  var_6 = vectordot(var_5, var_2) * var_2;
  var_7 = var_5 - var_6;
  var_8 = var_7 + var_6 / level.dangerovalscale[var_3];
  var_9 = lengthsquared(var_8);

  if(var_9 > level.dangermaxradius[var_3] * level.dangermaxradius[var_3]) {
    return 0;
  }

  if(var_9 < level.dangerminradius[var_3] * level.dangerminradius[var_3]) {
    return 1;
  }

  var_10 = sqrt(var_9);
  var_11 = (var_10 - level.dangerminradius[var_3]) / (level.dangermaxradius[var_3] - level.dangerminradius[var_3]);
  return 1 - var_11;
}

pointisinairstrikearea(var_0, var_1, var_2, var_3) {
  return distance2d(var_0, var_1) <= level.dangermaxradius[var_3] * 1.25;
}

losradiusdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = scripts\mp\weapons::getdamageableents(var_0, var_1, 1);
  glassradiusdamage(var_0, var_1, var_2, var_3);

  for(var_8 = 0; var_8 < var_7.size; var_8++) {
    if(var_7[var_8].entity == self) {
      continue;
    }
    var_9 = distance(var_0, var_7[var_8].damagecenter);

    if(var_7[var_8].isplayer || isDefined(var_7[var_8].issentry) && var_7[var_8].issentry) {
      var_10 = !bullettracepassed(var_7[var_8].entity.origin, var_7[var_8].entity.origin + (0, 0, 130), 0, undefined);

      if(var_10) {
        var_10 = !bullettracepassed(var_7[var_8].entity.origin + (0, 0, 130), var_0 + (0, 0, 114), 0, undefined);

        if(var_10) {
          var_9 = var_9 * 4;

          if(var_9 > var_1) {
            continue;
          }
        }
      }
    }

    var_7[var_8].damage = int(var_2 + (var_3 - var_2) * var_9 / var_1);
    var_7[var_8].pos = var_0;
    var_7[var_8].damageowner = var_4;
    var_7[var_8].einflictor = var_5;
    level.airstrikedamagedents[level.airstrikedamagedentscount] = var_7[var_8];
    level.airstrikedamagedentscount++;
  }

  thread airstrikedamageentsthread(var_6);
}

airstrikedamageentsthread(var_0) {
  self notify("airstrikeDamageEntsThread");
  self endon("airstrikeDamageEntsThread");

  while(level.airstrikedamagedentsindex < level.airstrikedamagedentscount) {
    if(!isDefined(level.airstrikedamagedents[level.airstrikedamagedentsindex])) {} else {
      var_1 = level.airstrikedamagedents[level.airstrikedamagedentsindex];

      if(!isDefined(var_1.entity)) {} else if(!var_1.isplayer || isalive(var_1.entity)) {
        var_1 scripts\mp\weapons::damageent(var_1.einflictor, var_1.damageowner, var_1.damage, "MOD_PROJECTILE_SPLASH", var_0, var_1.pos, vectornormalize(var_1.damagecenter - var_1.pos));
        level.airstrikedamagedents[level.airstrikedamagedentsindex] = undefined;

        if(var_1.isplayer) {
          wait 0.05;
        }
      } else
        level.airstrikedamagedents[level.airstrikedamagedentsindex] = undefined;
    }

    level.airstrikedamagedentsindex++;
  }
}

radiusartilleryshellshock(var_0, var_1, var_2, var_3, var_4) {
  var_5 = level.players;

  foreach(var_7 in level.players) {
    if(!isalive(var_7)) {
      continue;
    }
    if(var_7.team == var_4 || var_7.team == "spectator") {
      continue;
    }
    var_8 = var_7.origin + (0, 0, 32);
    var_9 = distance(var_0, var_8);

    if(var_9 > var_1) {
      continue;
    }
    var_10 = int(var_2 + (var_3 - var_2) * var_9 / var_1);
    var_7 thread artilleryshellshock("default", var_10);
  }
}

artilleryshellshock(var_0, var_1) {
  self endon("disconnect");

  if(isDefined(self.beingartilleryshellshocked) && self.beingartilleryshellshocked) {
    return;
  }
  self.beingartilleryshellshocked = 1;
  self shellshock(var_0, var_1);
  wait(var_1 + 1);
  self.beingartilleryshellshocked = 0;
}

func_3786(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1) || var_1 scripts\mp\utility\game::iskillstreakdenied()) {
    self notify("stop_bombing");
    return;
  }

  var_4 = 512;
  var_5 = (0, randomint(360), 0);
  var_6 = var_0 + anglesToForward(var_5) * randomfloat(var_4);
  var_7 = bulletTrace(var_6, var_6 + (0, 0, -10000), 0, undefined);
  var_6 = var_7["position"];
  var_8 = distance(var_0, var_6);

  if(var_8 > 5000) {
    return;
  }
  wait(0.85 * (var_8 / 2000));

  if(!isDefined(var_1) || var_1 scripts\mp\utility\game::iskillstreakdenied()) {
    self notify("stop_bombing");
    return;
  }

  if(var_3) {
    playFX(level.var_BB68, var_6);
    level thread scripts\mp\shellshock::func_10F44(var_6);
  }

  thread scripts\mp\utility\game::playsoundinspace("exp_airstrike_bomb", var_6);
  radiusartilleryshellshock(var_6, 512, 8, 4, var_1.team);
  losradiusdamage(var_6 + (0, 0, 16), 896, 300, 50, var_1, self, "stealth_bomb_mp");
}

func_5A60(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  if(!isDefined(var_1)) {
    return;
  }
  var_12 = 100;
  var_13 = 150;
  var_14 = var_4;
  var_15 = var_5;
  var_16 = "veh_mil_air_ca_jackal_drone_atmos_periph_mp";
  var_17 = scripts\mp\killstreak_loot::getrarityforlootitem(var_11.variantid);

  if(var_17 != "") {
    var_16 = var_16 + "_" + var_17;
  }

  var_18 = spawn("script_model", var_14);
  var_18 setModel(var_16);
  var_18.owner = var_1;
  var_18.origin = var_14;
  var_18.angles = var_8;
  var_18.team = var_1.team;
  var_18.lifeid = var_0;
  var_18.streakinfo = var_11;
  var_18 setotherent(var_1);
  var_18 _meth_8549();
  var_18 _meth_8594();
  var_18 _meth_8548();
  var_18 scripts\mp\killstreaks\utility::func_1843(var_9, "Killstreak_Air", var_1, 1, "kill_outline");
  var_18 thread handleemp(var_1);

  if(var_9 == "precision_airstrike") {
    var_19 = "jackal_airstrike_turret_mp";
    var_20 = "vehicle_battle_hind_mg_mp";
    var_21 = "tag_bottom_light";
    var_22 = "icon_minimap_scorcher_friendly";

    if(scripts\mp\killstreaks\utility::func_A69F(var_11, "passive_speed_cost")) {
      var_7 = var_7 - 1;
    }

    var_18.minimapid = var_18 scripts\mp\killstreaks\airdrop::createobjective(var_22, undefined, undefined, 1, 1);
    var_18.turret = spawnturret("misc_turret", var_18 gettagorigin(var_21), var_19);
    var_18.turret setModel(var_20);
    var_18.turret.owner = var_1;
    var_18.turret.angles = var_18.angles;
    var_18.turret linkto(var_18, var_21, (0, 0, 30), (0, 0, 0));
    var_18.turret setturretmodechangewait(0);
    var_18.turret give_player_session_tokens("manual_target");
    var_18.turret setsentryowner(var_1);
    var_18.turrettarget = spawn("script_model", var_18.origin + anglesToForward(var_18.angles) * 1000 - (0, 0, 10000));
    var_18.turrettarget linkto(var_18);
    var_18.var_A87B = spawn("script_model", var_18.turrettarget.origin);
    var_18.var_A87B setModel("ks_scorchers_target_mp");
    var_18.var_A87B setentityowner(var_1);
    var_18.var_A87B.weapon_name = "artillery_mp";
    var_18.var_A87B.streakinfo = var_11;
    var_18.turret settargetentity(var_18.turrettarget);
  }

  var_18 moveto(var_15, var_7, 0, 0);

  if(var_9 == "precision_airstrike") {
    var_18 setscriptablepartstate("thrusters", "idle", 0);
    thread func_3788(var_18, var_15, var_7, var_6 - 1.5, var_1);
    wait(var_6 + 1);
  } else {
    var_18 setscriptablepartstate("thrusters", "idle", 0);
    thread callstrike_bombeffect(var_18, var_15, var_7, var_6 - 1.0, var_1, var_2, var_9, var_10);
    wait(var_6 - 0.75);
  }

  if(var_9 != "jackal") {
    var_18 scriptmodelplayanimdeltamotion("airstrike_mp_roll", 1);
  }

  var_18 thread func_5115(2.5, "kill_outline");
  var_18 endon("death");
  wait(var_7 - var_6);
  var_18 setscriptablepartstate("thrusters", "neutral", 0);

  if(isDefined(var_18.minimapid)) {
    scripts\mp\objidpoolmanager::returnminimapid(var_18.minimapid);
  }

  var_18 notify("delete");

  if(isDefined(var_18.turret)) {
    var_18.turret delete();
  }

  if(isDefined(var_18.turrettarget)) {
    var_18.turrettarget delete();
  }

  if(isDefined(var_18.var_A87B)) {
    var_18.var_A87B delete();

    if(isDefined(var_18.var_A87B.killcament)) {
      var_18.var_A87B.killcament delete();
    }
  }

  if(isDefined(var_18)) {
    var_18 delete();
  }
}

func_5115(var_0, var_1) {
  self endon("death");
  wait(var_0);
  self notify(var_1);
}

handledeath() {
  level endon("game_ended");
  self endon("delete");
  self waittill("death");
  var_0 = anglesToForward(self.angles) * 200;
  playFX(level.harrier_deathfx, self.origin, var_0);
  self delete();
}

addplanetolist(var_0) {
  level.planes[level.planes.size] = var_0;
}

removeplanefromlist(var_0) {
  for(var_1 = 0; var_1 < level.planes.size; var_1++) {
    if(isDefined(level.planes[var_1]) && level.planes[var_1] == var_0) {
      level.planes[var_1] = undefined;
    }
  }
}

callstrike_bombeffect(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_0 endon("death");
  wait(var_3);

  if(!isDefined(var_4) || var_4 scripts\mp\utility\game::iskillstreakdenied()) {
    return;
  }
  var_8 = anglesToForward(var_0.angles);
  var_9 = spawnbomb(var_0.origin, var_0.angles);
  var_9 movegravity(anglesToForward(var_0.angles) * 4666.67, 3.0);
  var_9.lifeid = var_5;
  var_10 = spawn("script_model", var_0.origin + (0, 0, 100) - var_8 * 200);
  var_9.killcament = var_10;
  var_9.killcament setscriptmoverkillcam("airstrike");
  var_9.var_1AFE = var_6;
  var_10.starttime = gettime();
  var_10 thread deleteaftertime(15.0);
  var_10.angles = var_8;
  var_10 moveto(var_1 + (0, 0, 100), var_2, 0, 0);
  wait 0.4;
  var_10 moveto(var_10.origin + var_8 * 4000, 1, 0, 0);
  wait 0.45;
  var_10 moveto(var_10.origin + (var_8 + (0, 0, -0.2)) * 3500, 2, 0, 0);
  wait 0.15;
  var_11 = spawn("script_model", var_9.origin);
  var_11 setModel("tag_origin");
  var_11.origin = var_9.origin;
  var_11.angles = var_9.angles;
  var_9 setModel("tag_origin");
  wait 0.1;
  var_12 = var_11.origin;
  var_13 = var_11.angles;

  if(level.splitscreen) {
    playFXOnTag(level.airstrikessfx, var_11, "tag_origin");
  } else {
    playFXOnTag(level.airstrikefx, var_11, "tag_origin");
  }

  wait 0.05;
  var_10 moveto(var_10.origin + (var_8 + (0, 0, -0.25)) * 2500, 2, 0, 0);
  wait 0.25;
  var_10 moveto(var_10.origin + (var_8 + (0, 0, -0.35)) * 2000, 2, 0, 0);
  wait 0.2;
  var_10 moveto(var_10.origin + (var_8 + (0, 0, -0.45)) * 1500, 2, 0, 0);
  wait 0.5;

  if(isDefined(var_7)) {
    var_7 delete();
  }

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
    playFX(level.var_1AF6, var_23);
    thread losradiusdamage(var_23 + (0, 0, 16), 512, 200, 30, var_4, var_9, "artillery_mp");

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
  var_9 delete();
}

spawnbomb(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_2.angles = var_1;
  var_2 setModel("projectile_cbu97_clusterbomb");
  return var_2;
}

func_3788(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("death");
  wait(var_3);

  if(!isDefined(var_4) || var_4 scripts\mp\utility\game::iskillstreakdenied()) {
    return;
  }
  var_5 = anglesToForward(var_0.angles);
  var_6 = spawn("script_model", var_0.origin - (0, 0, 100) - var_5 * 200);
  var_6 linkto(var_0);
  var_0.var_A87B.killcament = var_6;
  wait 0.5;
  var_7 = 50;
  var_8 = (0, 0, 0);
  var_9 = var_8;
  var_0.turret setscriptablepartstate("fire", "start", 0);
  var_0.var_A87B setscriptablepartstate("beam impact", "active", 0);
  var_10 = ["explode1", "explode2", "explode3", "explode4", "explode5"];
  var_11 = 0;

  for(var_12 = 0; var_12 < var_7; var_12++) {
    if(!isDefined(var_4)) {
      break;
    }
    var_13 = scripts\engine\trace::ray_trace(var_0.turret gettagorigin("tag_flash"), var_0.turrettarget.origin, level.characters, scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0));
    var_14 = var_13["position"];
    var_8 = var_14 + (0, 0, 2);
    var_0.var_A87B thread func_BCA4(var_11, var_8, var_10);
    var_0.turret shootturret();
    var_9 = var_8;

    if(var_11 < 4) {
      var_11++;
    } else {
      var_11 = 0;
    }

    wait 0.05;
  }

  var_0.turret setscriptablepartstate("fire", "stop", 0);
}

func_BCA4(var_0, var_1, var_2) {
  self endon("death");
  self.origin = var_1;
  self setscriptablepartstate(var_2[var_0], "active", 0);
  wait 0.1;
  self setscriptablepartstate(var_2[var_0], "neutral", 0);
}

delayplaySound(var_0, var_1) {
  wait(var_0);
  self playLoopSound(var_1);
}

func_D4BD(var_0, var_1, var_2) {
  var_3 = 100;

  if(var_2 != (0, 0, 0)) {
    for(var_4 = 0; var_4 < 3; var_4++) {
      var_5 = vectornormalize(var_1 - var_2);
      var_5 = var_5 * var_3;
      playFX(var_0, var_2 + var_5);
      var_3 = var_3 + 100;
    }

    playFX(var_0, var_1);
  }
}

deleteaftertime(var_0) {
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

callstrike_explosivebullets(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("death");
  wait(var_3);

  if(!isDefined(var_4) || var_4 scripts\mp\utility\game::iskillstreakdenied()) {
    return;
  }
  var_5 = anglesToForward(var_0.angles);
  var_6 = spawn("script_model", var_0.origin - (0, 0, 100) - var_5 * 200);
  var_6 linkto(var_0);
  var_0.var_A87B.killcament = var_6;
  wait 0.5;
  var_7 = 50;
  var_8 = (0, 0, 0);
  var_9 = var_8;
  var_10 = ["explode1", "explode2", "explode3", "explode4", "explode5"];
  var_11 = 0;

  for(var_12 = 0; var_12 < var_7; var_12++) {
    if(!isDefined(var_4)) {
      break;
    }
    var_13 = scripts\engine\trace::ray_trace(var_0.turret gettagorigin("tag_flash"), var_0.turrettarget.origin, level.characters, scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0));
    var_14 = var_13["position"];
    var_8 = var_14 + (0, 0, 2);
    var_0.var_A87B thread func_BCA4(var_11, var_8, var_10);
    var_0.turret shootturret();
    var_9 = var_8;

    if(var_11 < 4) {
      var_11++;
    } else {
      var_11 = 0;
    }

    wait 0.1;
  }
}

callstrike(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = undefined;
  var_8 = 0;
  var_9 = (0, var_3, 0);
  var_7 = getent("airstrikeheight", "targetname");

  if(var_4 == "stealth_airstrike") {
    var_10 = 12000;
    var_11 = 4000;

    if(!isDefined(var_7)) {
      var_12 = 950;
      var_8 = 1500;

      if(isDefined(level.airstrikeheightscale)) {
        var_12 = var_12 * level.airstrikeheightscale;
      }
    } else {
      var_12 = var_7.origin[2];

      if(getdvar("mapname") == "mp_exchange") {
        var_12 = var_12 + 1024;
      }

      if(getdvar("mapname") == "mp_rally") {
        var_12 = var_12 + 2500;
      }

      var_8 = getexplodedistance(var_12);
    }
  } else {
    var_10 = 24000;
    var_11 = 6500;

    if(!isDefined(var_7)) {
      var_12 = 850;
      var_8 = 1500;

      if(isDefined(level.airstrikeheightscale)) {
        var_12 = var_12 * level.airstrikeheightscale;
      }
    } else {
      var_12 = var_7.origin[2];

      if(getdvar("mapname") == "mp_rally") {
        var_12 = var_12 + 2500;
      }

      var_8 = getexplodedistance(var_12);
    }
  }

  var_1 endon("disconnect");
  var_13 = var_0;
  level.airstrikedamagedents = [];
  level.airstrikedamagedentscount = 0;
  level.airstrikedamagedentsindex = 0;

  if(var_4 == "jackal") {
    var_2 = var_1.origin;
    var_14 = getflightpath(var_2, var_9, var_10, var_7, var_12, var_11, var_8, var_4);
    var_1 scripts\mp\killstreaks\jackal::func_2A6B(var_0, var_14["startPoint"], var_2, var_6);
  } else if(var_4 == "precision_airstrike") {
    var_14 = getflightpath(var_2, var_9, var_10, var_7, var_12, var_11, var_8, var_4);
    var_15 = anglestoright(var_9);

    if(scripts\mp\killstreaks\utility::func_A69F(var_6, "passive_precision_strike")) {
      level thread func_5A60(var_0, var_1, var_13, var_2, var_14["startPoint"], var_14["endPoint"], var_14["bombTime"], var_14["flyTime"], var_9, var_4, var_5, var_6);
      playLoopSound(var_14["startPoint"], "ks_scorchers_init");
      wait(randomfloatrange(0.8, 1.0));
      scripts\mp\hostmigration::waittillhostmigrationdone();
      level thread func_5A60(var_0, var_1, var_13, var_2, var_14["startPoint"], var_14["endPoint"], var_14["bombTime"], var_14["flyTime"], var_9, var_4, var_5, var_6);
      wait(randomfloatrange(0.8, 1.0));
      scripts\mp\hostmigration::waittillhostmigrationdone();
      level thread func_5A60(var_0, var_1, var_13, var_2, var_14["startPoint"], var_14["endPoint"], var_14["bombTime"], var_14["flyTime"], var_9, var_4, var_5, var_6);
      return;
    }

    if(scripts\mp\killstreaks\utility::func_A69F(var_6, "passive_split_strike")) {
      level thread func_5A60(var_0, var_1, var_13, var_2, var_14["startPoint"], var_14["endPoint"], var_14["bombTime"], var_14["flyTime"], var_9, var_4, var_5, var_6);
      playLoopSound(var_14["startPoint"], "ks_scorchers_init");
      return;
    }

    level thread func_5A60(var_0, var_1, var_13, var_2, var_14["startPoint"], var_14["endPoint"], var_14["bombTime"], var_14["flyTime"], var_9, var_4, var_5, var_6);
    playLoopSound(var_14["startPoint"], "ks_scorchers_init");
    wait(randomfloatrange(0.5, 0.7));
    scripts\mp\hostmigration::waittillhostmigrationdone();
    level thread func_5A60(var_0, var_1, var_13, var_2, var_14["startPoint"] + var_15 * 175, var_14["endPoint"] + var_15 * 175, var_14["bombTime"], var_14["flyTime"], var_9, var_4, var_5, var_6);
    wait(randomfloatrange(0.5, 0.7));
    scripts\mp\hostmigration::waittillhostmigrationdone();
    level thread func_5A60(var_0, var_1, var_13, var_2, var_14["startPoint"] - var_15 * 175, var_14["endPoint"] - var_15 * 175, var_14["bombTime"], var_14["flyTime"], var_9, var_4, var_5, var_6);
    return;
    return;
  } else {
    var_14 = getflightpath(var_2, var_9, var_10, var_7, var_12, var_11, var_8, var_4);
    level thread func_5A60(var_0, var_1, var_13, var_2, var_14["startPoint"] + (0, 0, randomint(500)), var_14["endPoint"] + (0, 0, randomint(500)), var_14["bombTime"], var_14["flyTime"], var_9, var_4, var_5, var_6);
    wait(randomfloatrange(1.5, 2.5));
    scripts\mp\hostmigration::waittillhostmigrationdone();
    level thread func_5A60(var_0, var_1, var_13, var_2, var_14["startPoint"] + (0, 0, randomint(200)), var_14["endPoint"] + (0, 0, randomint(200)), var_14["bombTime"], var_14["flyTime"], var_9, var_4, var_5, var_6);
    wait(randomfloatrange(1.5, 2.5));
    scripts\mp\hostmigration::waittillhostmigrationdone();
    level thread func_5A60(var_0, var_1, var_13, var_2, var_14["startPoint"] + (0, 0, randomint(200)), var_14["endPoint"] + (0, 0, randomint(200)), var_14["bombTime"], var_14["flyTime"], var_9, var_4, var_5, var_6);

    if(var_4 == "super_airstrike") {
      wait(randomfloatrange(2.5, 3.5));
      scripts\mp\hostmigration::waittillhostmigrationdone();
      level thread func_5A60(var_0, var_1, var_13, var_2, var_14["startPoint"] + (0, 0, randomint(200)), var_14["endPoint"] + (0, 0, randomint(200)), var_14["bombTime"], var_14["flyTime"], var_9, var_4, var_5, var_6);
    }
  }
}

getflightpath(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = var_0 + anglesToForward(var_1) * (-1 * var_2);

  if(isDefined(var_3)) {
    var_8 = var_8 * (1, 1, 0);
  }

  var_8 = var_8 + (0, 0, var_4);
  var_9 = var_0 + anglesToForward(var_1) * var_2;

  if(isDefined(var_3)) {
    var_9 = var_9 * (1, 1, 0);
  }

  var_9 = var_9 + (0, 0, var_4);
  var_10 = length(var_8 - var_9);
  var_11 = var_10 / var_5;
  var_10 = abs(var_10 / 2 + var_6);
  var_12 = var_10 / var_5;
  var_13["startPoint"] = var_8;
  var_13["endPoint"] = var_9;
  var_13["bombTime"] = var_12;
  var_13["flyTime"] = var_11;
  return var_13;
}

getexplodedistance(var_0) {
  var_1 = 850;
  var_2 = 1500;
  var_3 = var_1 / var_0;
  var_4 = var_3 * var_2;
  return var_4;
}

targetgetdist(var_0, var_1) {
  var_2 = targetisinfront(var_0, var_1);

  if(var_2) {
    var_3 = 1;
  } else {
    var_3 = -1;
  }

  var_4 = scripts\engine\utility::flat_origin(var_0.origin);
  var_5 = var_4 + anglesToForward(scripts\engine\utility::flat_angle(var_0.angles)) * (var_3 * 100000);
  var_6 = pointonsegmentnearesttopoint(var_4, var_5, var_1);
  var_7 = distance(var_4, var_6);
  return var_7;
}

targetisclose(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 3000;
  }

  var_3 = targetisinfront(var_0, var_1);

  if(var_3) {
    var_4 = 1;
  } else {
    var_4 = -1;
  }

  var_5 = scripts\engine\utility::flat_origin(var_0.origin);
  var_6 = var_5 + anglesToForward(scripts\engine\utility::flat_angle(var_0.angles)) * (var_4 * 100000);
  var_7 = pointonsegmentnearesttopoint(var_5, var_6, var_1);
  var_8 = distance(var_5, var_7);

  if(var_8 < var_2) {
    return 1;
  } else {
    return 0;
  }
}

targetisinfront(var_0, var_1) {
  var_2 = anglesToForward(scripts\engine\utility::flat_angle(var_0.angles));
  var_3 = vectornormalize(scripts\engine\utility::flat_origin(var_1) - var_0.origin);
  var_4 = vectordot(var_2, var_3);

  if(var_4 > 0) {
    return 1;
  } else {
    return 0;
  }
}

waitforairstrikecancel() {
  self waittill("cancel_location");
  self setblurforplayer(0, 0.3);
}

selectairstrikelocation(var_0, var_1, var_2) {
  var_3 = (0, 0, 0);
  var_4 = undefined;
  var_5 = self.angles[1];
  var_6 = undefined;
  var_7 = undefined;

  if(!isDefined(level.mapsize)) {
    return;
  }
  var_8 = level.mapsize / 6.46875;

  if(level.splitscreen) {
    var_8 = var_8 * 1.5;
  }

  var_9 = spawn("script_origin", self.origin);
  var_10 = "used_" + var_1;
  var_11 = scripts\mp\killstreak_loot::getrarityforlootitem(var_2.variantid);

  if(var_11 != "") {
    var_10 = var_10 + "_" + var_11;
  }

  if(var_1 == "precision_airstrike") {
    var_12 = 1;
    var_7 = 1;

    if(scripts\mp\killstreaks\utility::func_A69F(var_2, "passive_split_strike")) {
      var_12 = 3;
    }

    scripts\engine\utility::allow_weapon_switch(0);

    if(self.team == "allies") {
      var_13 = "UN_";
    } else {
      var_13 = "PD_";
    }

    self playlocalsound("bombardment_killstreak_bootup");
    var_9 playLoopSound("bombardment_killstreak_hud_loop");
    self setsoundsubmix("mp_killstreak_overlay");
    var_4 = scripts\mp\killstreaks\mapselect::_meth_8112(var_1, var_12, 1);
    scripts\engine\utility::allow_weapon_switch(1);
  } else if(var_1 == "jackal" && (isDefined(level.var_A056) || level.jackals.size > 1)) {
    self notify("cancel_location");
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");

    if(isDefined(var_9)) {
      var_9 stoploopsound("");
      var_9 delete();
    }

    self clearsoundsubmix();
    return 0;
  }

  if(isDefined(var_4)) {
    if(scripts\mp\utility\game::istrue(level.var_1AF9)) {
      scripts\mp\hud_message::showerrormessage("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
      return 0;
    }

    thread func_6CDD(var_4, var_7, var_0, var_3, var_5, var_1, var_6, var_2);
    self playlocalsound("bombardment_killstreak_shutdown");
    self clearsoundsubmix();
  } else if(!isDefined(var_4) && scripts\mp\utility\game::func_9E90(var_1)) {
    if(isDefined(var_9)) {
      var_9 stoploopsound("");
      var_9 delete();
    }

    self playlocalsound("bombardment_killstreak_shutdown");
    self clearsoundsubmix();
    return 0;
  } else {
    if(var_1 == "jackal") {
      if(scripts\mp\killstreaks\jackal::getnumownedjackals(self) >= 1) {
        scripts\mp\hud_message::showerrormessage("KILLSTREAKS_AIR_SPACE_TOO_CROWDED");

        if(isDefined(var_9)) {
          var_9 stoploopsound("");
          var_9 delete();
        }

        self clearsoundsubmix();
        return 0;
      }
    }

    finishairstrikeusage(var_0, var_3, var_5, var_1, var_6, var_2);

    if(var_1 == "jackal" && scripts\mp\killstreaks\utility::func_A69F(var_2, "passive_support_drop")) {
      var_14 = scripts\engine\utility::waittill_any_return("called_in_jackal", "cancel_jackal");

      if(!isDefined(var_14) || var_14 == "cancel_jackal") {
        return 0;
      }
    }
  }

  if(isDefined(var_9)) {
    var_9 stoploopsound("");
    var_9 delete();
  }

  thread scripts\mp\utility\game::teamplayercardsplash(var_10, self);
  scripts\mp\matchdata::logkillstreakevent(var_1, var_3);
  return 1;
}

func_6CDD(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self endon("disconnect");

  foreach(var_10, var_9 in var_0) {
    var_3 = var_9.location;

    if(scripts\mp\utility\game::istrue(var_1)) {
      var_4 = var_9.angles;
    }

    finishairstrikeusage(var_2, var_3, var_4, var_5, var_6, var_7);

    if(var_0.size > 1 && var_10 < var_0.size - 1) {
      wait(randomfloatrange(0.8, 1.0));
    }
  }
}

finishairstrikeusage(var_0, var_1, var_2, var_3, var_4, var_5) {
  self notify("used");
  var_6 = bulletTrace(level.mapcenter + (0, 0, 1000000.0), level.mapcenter, 0, undefined);
  var_1 = (var_1[0], var_1[1], var_6["position"][2] - 514);
  thread func_57DD(var_0, var_1, var_2, self, self.pers["team"], var_3, var_4, var_5);
}

useairstrike(var_0, var_1, var_2) {}

handleemp(var_0) {
  self endon("death");

  if(var_0 scripts\mp\killstreaks\emp_common::isemped()) {
    self notify("death");
    return;
  }

  for(;;) {
    level waittill("emp_update");

    if(!var_0 scripts\mp\killstreaks\emp_common::isemped()) {
      continue;
    }
    self notify("death");
  }
}

airstrikemadeselectionvo(var_0) {
  self endon("death");
  self endon("disconnect");

  switch (var_0) {
    case "precision_airstrike":
      self playlocalsound(game["voice"][self.team] + "KS_ast_inbound");
      break;
  }
}

func_1AFA(var_0, var_1, var_2, var_3) {
  var_4 = var_3 * 20;

  for(var_5 = 0; var_5 < var_4; var_5++) {
    wait 0.05;
  }
}

func_11A82() {
  self endon("death");
  var_0 = self.origin;

  for(;;) {
    thread func_1AFA(var_0, self.origin, (0.5, 1, 0), 40);
    var_0 = self.origin;
    wait 0.2;
  }
}

triggerjackalweapon(var_0) {
  if(scripts\mp\killstreaks\utility::func_A69F(var_0, "passive_support_drop")) {
    var_0.var_EF88 = "no_fire_weapon";
    var_0.weapon = "deploy_warden_mp";
  }

  return 1;
}