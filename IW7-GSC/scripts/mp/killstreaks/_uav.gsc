/*******************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\_uav.gsc
*******************************************/

init() {
  level.radarviewtime = 23;
  level.advradarviewtime = 28;
  level.uavblocktime = 23;
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("uav", ::func_1290B);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("counter_uav", ::func_1290B);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("directional_uav", ::func_1290B);
  scripts\mp\killstreaks\_killstreaks::registerkillstreak("uav_3dping", ::func_128B2);
  var_00 = ["passive_increased_duration", "passive_decreased_duration", "passive_decreased_health", "passive_increased_armor", "passive_increased_cost", "passive_extra_assist", "passive_stealth_vehicle", "passive_vision_sweep", "passive_disable_hud", "passive_emp_blast", "passive_duration_health", "passive_armor_speed", "passive_stealth_speed"];
  scripts\mp\killstreak_loot::func_DF07("uav", var_00);
  scripts\mp\killstreak_loot::func_DF07("counter_uav", var_00);
  scripts\mp\killstreak_loot::func_DF07("directional_uav", var_00);
  level.uavsettings = [];
  level.uavsettings["uav"] = spawnStruct();
  level.uavsettings["uav"].timeout = level.radarviewtime;
  level.uavsettings["uav"].health = 999999;
  level.uavsettings["uav"].maxhealth = 800;
  level.uavsettings["uav"].streakname = "uav";
  level.uavsettings["uav"].modelbase = "veh_mil_air_un_uav";
  level.uavsettings["uav"].fxid_explode = loadfx("vfx\iw7\core\mp\killstreaks\vfx_veh_exp_uav.vfx");
  level.uavsettings["uav"].var_7631 = loadfx("vfx\misc\jet_engine_ac130");
  level.uavsettings["uav"].var_7637 = loadfx("vfx\core\mp\killstreaks\vfx_3d_world_ping_large");
  level.uavsettings["uav"].fx_leave_tag = "tag_origin";
  level.uavsettings["uav"].fxid_contrail = undefined;
  level.uavsettings["uav"].var_7566 = undefined;
  level.uavsettings["uav"].sound_explode = "ball_drone_explode";
  level.uavsettings["uav"].teamsplash = "used_uav";
  level.uavsettings["uav"].votimeout = "uav_timeout";
  level.uavsettings["uav"].calloutdestroyed = "callout_destroyed_uav";
  level.uavsettings["uav"].var_17C8 = ::func_179A;
  level.uavsettings["uav"].var_E124 = ::func_E0C1;
  level.uavsettings["counter_uav"] = spawnStruct();
  level.uavsettings["counter_uav"].timeout = level.uavblocktime;
  level.uavsettings["counter_uav"].health = 999999;
  level.uavsettings["counter_uav"].maxhealth = 800;
  level.uavsettings["counter_uav"].streakname = "counter_uav";
  level.uavsettings["counter_uav"].modelbase = "veh_mil_air_un_cuav";
  level.uavsettings["counter_uav"].fxid_explode = loadfx("vfx\iw7\core\mp\killstreaks\vfx_veh_exp_uav.vfx");
  level.uavsettings["counter_uav"].var_7631 = loadfx("vfx\misc\jet_engine_ac130");
  level.uavsettings["counter_uav"].fx_leave_tag = "tag_origin";
  level.uavsettings["counter_uav"].fxid_contrail = undefined;
  level.uavsettings["counter_uav"].var_7566 = undefined;
  level.uavsettings["counter_uav"].sound_explode = "ball_drone_explode";
  level.uavsettings["counter_uav"].votimeout = "counter_uav_timeout";
  level.uavsettings["counter_uav"].teamsplash = "used_counter_uav";
  level.uavsettings["counter_uav"].calloutdestroyed = "callout_destroyed_counter_uav";
  level.uavsettings["counter_uav"].var_17C8 = ::func_1799;
  level.uavsettings["counter_uav"].var_E124 = ::func_E0BF;
  level.uavsettings["directional_uav"] = spawnStruct();
  level.uavsettings["directional_uav"].timeout = level.advradarviewtime;
  level.uavsettings["directional_uav"].health = 999999;
  level.uavsettings["directional_uav"].maxhealth = 2000;
  level.uavsettings["directional_uav"].streakname = "directional_uav";
  level.uavsettings["directional_uav"].modelbase = "veh_mil_air_un_auav";
  level.uavsettings["directional_uav"].fxid_explode = loadfx("vfx\iw7\core\mp\killstreaks\vfx_veh_exp_uav.vfx");
  level.uavsettings["directional_uav"].var_7631 = loadfx("vfx\misc\jet_engine_ac130");
  level.uavsettings["directional_uav"].fx_leave_tag = "tag_origin";
  level.uavsettings["directional_uav"].fxid_contrail = undefined;
  level.uavsettings["directional_uav"].var_7566 = "tag_jet_trail";
  level.uavsettings["directional_uav"].sound_explode = "ball_drone_explode";
  level.uavsettings["directional_uav"].votimeout = "directional_uav_timeout";
  level.uavsettings["directional_uav"].teamsplash = "used_directional_uav";
  level.uavsettings["directional_uav"].calloutdestroyed = "callout_destroyed_directional_uav";
  level.uavsettings["directional_uav"].var_17C8 = ::func_179A;
  level.uavsettings["directional_uav"].var_E124 = ::func_E0C1;
  level.uavsettings["uav_3dping"] = spawnStruct();
  level.uavsettings["uav_3dping"].timeout = 63;
  level.uavsettings["uav_3dping"].streakname = "uav_3dping";
  level.uavsettings["uav_3dping"].var_8EF7 = 1.5;
  level.uavsettings["uav_3dping"].var_CB9A = 10;
  level.uavsettings["uav_3dping"].var_7636 = loadfx("vfx\core\mp\killstreaks\vfx_3d_world_ping");
  level.uavsettings["uav_3dping"].var_1046A = "oracle_radar_pulse_plr";
  level.uavsettings["uav_3dping"].var_10469 = "oracle_radar_pulse_npc";
  level.uavsettings["uav_3dping"].votimeout = "oracle_gone";
  level.uavsettings["uav_3dping"].teamsplash = "used_uav_3dping";
  var_01 = getEntArray("minimap_corner", "targetname");
  if(var_01.size) {
    level.var_12AF6 = scripts\mp\spawnlogic::findboxcenter(var_01[0].origin, var_01[1].origin);
  } else {
    level.var_12AF6 = (0, 0, 0);
  }

  level.var_12AF5 = spawn("script_model", level.var_12AF6);
  level.var_12AF5 setModel("tag_origin");
  level.var_12AF5.angles = (0, 115, 0);
  level.var_12AF5 hide();
  level.var_12AF5.var_336 = "uavrig_script_model";
  level.var_12AF5 thread func_E734(70);
  level.uavrigslow = spawn("script_model", level.var_12AF6);
  level.uavrigslow setModel("tag_origin");
  level.uavrigslow.angles = (0, 115, 0);
  level.uavrigslow hide();
  level.uavrigslow.var_336 = "uavrig_script_model";
  level.uavrigslow thread func_E734(90);
  level.var_46B8 = spawn("script_model", level.var_12AF6);
  level.var_46B8 setModel("tag_origin");
  level.var_46B8.angles = (0, 115, 0);
  level.var_46B8 hide();
  level.var_46B8.var_336 = "counteruavrig_script_model";
  level.var_46B8 thread func_E734(80);
  level.var_18D2 = spawn("script_model", level.var_12AF6);
  level.var_18D2 setModel("tag_origin");
  level.var_18D2.angles = (0, 115, 0);
  level.var_18D2 hide();
  level.var_18D2.var_336 = "advanceduavrig_script_model";
  level.var_18D2 thread func_E734(60);
  level.advanceduavrigslow = spawn("script_model", level.var_12AF6);
  level.advanceduavrigslow setModel("tag_origin");
  level.advanceduavrigslow.angles = (0, 115, 0);
  level.advanceduavrigslow hide();
  level.advanceduavrigslow.var_336 = "advanceduavrig_script_model";
  level.advanceduavrigslow thread func_E734(80);
  var_02 = getuavstrengthlevelneutral();
  if(level.multiteambased) {
    for(var_03 = 0; var_03 < level.teamnamelist.size; var_03++) {
      level.createprintchannel[level.teamnamelist[var_03]] = "normal_radar";
      level.activeuavs[level.teamnamelist[var_03]] = 0;
      level.var_164F[level.teamnamelist[var_03]] = 0;
      level.activeadvanceduavs[level.teamnamelist[var_03]] = 0;
      level.uavmodels[level.teamnamelist[var_03]] = [];
    }
  } else if(level.teambased) {
    level.createprintchannel["allies"] = "normal_radar";
    level.createprintchannel["axis"] = "normal_radar";
    level.activeuavs["allies"] = 0;
    level.activeuavs["axis"] = 0;
    level.var_164F["allies"] = 0;
    level.var_164F["axis"] = 0;
    level.activeadvanceduavs["allies"] = 0;
    level.activeadvanceduavs["axis"] = 0;
    level.uavmodels["allies"] = [];
    level.uavmodels["axis"] = [];
  } else {
    level.createprintchannel = [];
    level.activeuavs = [];
    level.var_164F = [];
    level.activeadvanceduavs = [];
    level.uavmodels = [];
  }

  level thread onplayerconnect();
  level thread func_12AF9();
}

onplayerconnect() {
  var_00 = getuavstrengthlevelneutral();
  for(;;) {
    level waittill("connected", var_01);
    scripts\mp\killstreaks\_utility::func_12F51();
    level.activeuavs[var_01.guid] = 0;
    level.activeuavs[var_01.guid + "_radarStrength"] = var_00;
    level.var_164F[var_01.guid] = 0;
    level.createprintchannel[var_01.guid] = "normal_radar";
    var_01.drawsoundshape = var_00;
    var_01 thread monitorplayerupdate();
  }
}

monitorplayerupdate() {
  self endon("disconnect");
  for(;;) {
    self waittill("spawned_player");
    level notify("uav_update");
  }
}

func_E734(param_00, param_01, param_02) {
  if(isDefined(param_02)) {
    self endon(param_02);
  }

  if(!isDefined(param_00)) {
    param_00 = 60;
  }

  if(!isDefined(param_01)) {
    param_01 = -360;
  }

  for(;;) {
    self rotateyaw(param_01, param_00);
    wait(param_00);
  }
}

func_1290B(param_00) {
  return func_130F4(param_00.streakname, param_00);
}

func_128B2(param_00) {
  var_01 = "uav_3dping";
  thread func_13920(var_01);
  thread func_13921(var_01);
  level thread scripts\mp\utility::teamplayercardsplash(level.uavsettings[var_01].teamsplash, self);
  return 1;
}

func_130F4(param_00, param_01) {
  scripts\mp\matchdata::logkillstreakevent(param_00, self.origin);
  var_02 = self.pers["team"];
  var_03 = level.uavsettings[param_00].timeout;
  level thread launchuav(self, param_00, param_01);
  if(!isDefined(self.var_12AF8)) {
    self.var_12AF8 = [];
  }

  switch (param_00) {
    case "counter_uav":
      self notify("used_counter_uav");
      self.var_12AF8["counter_uav"] = 1;
      break;

    case "directional_uav":
      self.cylinder = 1;
      if(level.teambased) {
        foreach(var_05 in level.players) {
          if(var_05.pers["team"] == var_02) {
            var_05.cylinder = 1;
          }
        }
      }

      self notify("used_directional_uav");
      self.var_12AF8["directional_uav"] = 1;
      break;

    default:
      self notify("used_uav");
      if(level.teambased) {
        var_07 = _getradarstrength(var_02);
        if(var_07 >= getuavstrengthlevelshowenemyfastsweep()) {
          scripts\mp\missions::func_D991("ch_uav_doubleup");
        }
      }

      self.var_12AF8["uav"] = 1;
      break;
  }

  if(self.var_12AF8.size == 3) {
    self.var_12AF8 = [];
    scripts\mp\missions::func_D991("ch_uav_combo");
  }

  return 1;
}

launchuav(param_00, param_01, param_02) {
  var_03 = param_00.team;
  var_04 = _meth_81E8(param_01, param_02);
  var_05 = spawn("script_model", var_04 gettagorigin("tag_origin") + (0, 0, 5000));
  var_06 = level.uavsettings[param_01].modelbase;
  var_07 = level.uavsettings[param_01].timeout;
  var_08 = level.uavsettings[param_01].maxhealth;
  var_09 = level.uavsettings[param_01].teamsplash;
  var_0A = scripts\mp\killstreak_loot::getrarityforlootitem(param_02.variantid);
  if(var_0A != "") {
    var_06 = var_06 + "_" + var_0A;
    var_09 = var_09 + "_" + var_0A;
  }

  level thread scripts\mp\utility::teamplayercardsplash(var_09, param_00);
  if(param_01 == "uav") {
    if(scripts\mp\killstreaks\_utility::func_A69F(param_02, "passive_duration_health")) {
      var_07 = var_07 + 5;
      var_08 = var_08 - 200;
    }

    if(scripts\mp\killstreaks\_utility::func_A69F(param_02, "passive_armor_speed")) {
      var_07 = var_07 - 5;
    }
  } else if(param_01 == "counter_uav") {
    if(scripts\mp\killstreaks\_utility::func_A69F(param_02, "passive_duration_health")) {
      var_07 = var_07 + 5;
      var_08 = var_08 - 200;
    }

    if(scripts\mp\killstreaks\_utility::func_A69F(param_02, "passive_disable_hud")) {
      var_07 = var_07 - 10;
    }
  } else {
    if(scripts\mp\killstreaks\_utility::func_A69F(param_02, "passive_duration_health")) {
      var_07 = var_07 + 5;
      var_08 = var_08 - 500;
    }

    if(scripts\mp\killstreaks\_utility::func_A69F(param_02, "passive_vision_sweep")) {
      var_07 = var_07 - 5;
    }
  }

  var_05 setModel(var_06);
  var_05.team = var_03;
  var_05.triggerportableradarping = param_00;
  var_05.var_11938 = 0;
  var_05.uavtype = param_01;
  var_05.health = level.uavsettings[param_01].health;
  var_05.maxhealth = var_08;
  var_05.streakinfo = param_02;
  var_05 setotherent(param_00);
  var_05 _meth_8549();
  var_05 _meth_8594();
  var_05 scripts\mp\killstreaks\_utility::func_1843(param_01, "Killstreak_Air", param_00);
  var_05 thread damagetracker();
  var_05 thread func_89B7();
  var_05 thread func_CA50();
  var_05 thread monitorowner();
  var_05 thread func_E2E4();
  var_05 setscriptablepartstate("lights", "on", 0);
  if(scripts\mp\killstreaks\_utility::func_A69F(param_02, "passive_stealth_vehicle")) {
    var_05 setscriptablepartstate("stealth", "active", 0);
  }

  var_0B = randomintrange(5250, 5500);
  if(isDefined(level.spawnpoints)) {
    var_0C = level.spawnpoints;
  } else {
    var_0C = level.var_10DF1;
  }

  var_0D = var_0C[0];
  foreach(var_0F in var_0C) {
    if(var_0F.origin[2] < var_0D.origin[2]) {
      var_0D = var_0F;
    }
  }

  var_11 = var_0D.origin[2];
  var_12 = var_04.origin[2];
  if(var_11 < 0) {
    var_12 = var_12 + var_11 * -1;
    var_11 = 0;
  }

  var_13 = var_12 - var_11;
  if(var_13 + var_0B > 8100) {
    var_0B = var_0B - var_13 + var_0B - 8100;
  }

  var_14 = randomint(360);
  var_15 = randomint(1000) + 4000;
  var_16 = cos(var_14) * var_15;
  var_17 = sin(var_14) * var_15;
  var_18 = vectornormalize((var_16, var_17, var_0B));
  var_18 = var_18 * var_0B;
  var_05 linkto(var_04, "tag_origin", var_18, (0, var_14 - 90, 0));
  var_05 thread func_12F50();
  var_05[[level.uavsettings[param_01].var_17C8]]();
  if(isDefined(level.activeuavs[var_03])) {
    foreach(var_1A in level.uavmodels[var_03]) {
      if(var_1A == var_05) {
        continue;
      }

      if(isDefined(var_1A.var_11938)) {
        var_1A.var_11938 = var_1A.var_11938 + 5;
      }
    }
  }

  var_05 thread handlewiretap();
  if(scripts\mp\killstreaks\_utility::func_A69F(param_02, "passive_disable_hud")) {
    var_05 thread startsystemshutdown();
  }

  if(scripts\mp\killstreaks\_utility::func_A69F(param_02, "passive_emp_blast")) {
    var_05 thread startemppulse();
  }

  level notify("uav_update");
  var_05 scripts\mp\hostmigration::waittill_notify_or_timeout_hostmigration_pause("death", var_07);
  if(var_05.var_E1 < var_05.maxhealth) {
    var_05 unlink();
    var_1C = var_05.origin + anglesToForward(var_05.angles) * 20000;
    var_05 moveto(var_1C, 60);
    if(isDefined(level.uavsettings[param_01].var_7631) && isDefined(level.uavsettings[param_01].fx_leave_tag)) {
      playFXOnTag(level.uavsettings[param_01].var_7631, var_05, level.uavsettings[param_01].fx_leave_tag);
    }

    var_05 scripts\mp\hostmigration::waittill_notify_or_timeout_hostmigration_pause("death", 3);
    if(var_05.var_E1 < var_05.maxhealth) {
      var_05 notify("leaving");
      var_05 setscriptablepartstate("trail", "on", 0);
      var_05.isleaving = 1;
      var_05 moveto(var_1C, 4, 4, 0);
    }

    var_05 scripts\mp\hostmigration::waittill_notify_or_timeout_hostmigration_pause("death", 4 + var_05.var_11938);
  }

  var_05[[level.uavsettings[param_01].var_E124]]();
  if(isDefined(var_05.var_6569)) {
    scripts\mp\objidpoolmanager::returnminimapid(var_05.var_6569);
    var_05 notify("uav_deleteObjective");
  }

  if(isDefined(var_05)) {
    var_05 delete();
  }

  if(param_01 == "directional_uav") {
    param_00.cylinder = 0;
    if(level.teambased) {
      foreach(var_1E in level.players) {
        if(var_1E.pers["team"] == var_03) {
          var_1E.cylinder = 0;
        }
      }
    }
  }

  scripts\mp\utility::printgameaction("killstreak ended - " + param_01, param_00);
  level notify("uav_update");
}

monitorowner() {
  self endon("death");
  self.triggerportableradarping scripts\engine\utility::waittill_any_3("disconnect", "joined_team");
  self hide();
  var_00 = anglestoright(self.angles) * 200;
  playFX(level.uavsettings[self.uavtype].fxid_explode, self.origin, var_00);
  self.var_E1 = self.maxhealth;
  self notify("death");
}

func_E2E4() {
  self endon("death");
  for(;;) {
    level waittill("host_migration_end");
    if(level.teambased) {
      var_00 = _getradarstrength("allies");
      var_01 = _getradarstrength("axis");
      _setteamradarstrength("allies", var_00);
      _setteamradarstrength("axis", var_01);
    }
  }
}

func_12F50() {
  self endon("death");
  for(;;) {
    level scripts\engine\utility::waittill_either("joined_team", "uav_update");
    self hide();
    foreach(var_01 in level.players) {
      if(level.teambased) {
        if(var_01.team != self.team) {
          self showtoplayer(var_01);
        }

        continue;
      }

      if(isDefined(self.triggerportableradarping) && var_01 == self.triggerportableradarping) {
        continue;
      }

      self showtoplayer(var_01);
    }
  }
}

damagetracker() {
  level endon("game_ended");
  self setCanDamage(1);
  self.var_E1 = 0;
  for(;;) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A, var_0B, var_0C, var_0D);
    var_09 = scripts\mp\utility::func_13CA1(var_09, var_0D);
    if(!isplayer(var_01)) {
      if(!isDefined(self)) {
        return;
      }

      continue;
    }

    if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_01)) {
      continue;
    }

    if(isDefined(var_08) && var_08 & level.idflags_penetration) {
      self.wasdamagedfrombulletpenetration = 1;
    }

    if(isDefined(var_08) && var_08 & level.idflags_ricochet) {
      self.wasdamagedfrombulletricochet = 1;
    }

    self.wasdamaged = 1;
    var_0E = var_00;
    if(isplayer(var_01)) {
      var_01 scripts\mp\damagefeedback::updatedamagefeedback("");
      if(var_04 == "MOD_RIFLE_BULLET" || var_04 == "MOD_PISTOL_BULLET") {
        if(var_01 scripts\mp\utility::_hasperk("specialty_armorpiercing")) {
          var_0E = var_0E + var_00 * level.armorpiercingmod;
        }
      }
    }

    var_0F = 1;
    var_10 = 1;
    var_11 = 1;
    if(self.uavtype == "directional_uav") {
      var_0F = 5;
      var_10 = 6;
      var_11 = 7;
      if(scripts\mp\killstreaks\_utility::func_A69F(self.streakinfo, "passive_duration_health")) {
        var_0F--;
        var_10--;
        var_11--;
      }
    }

    if(scripts\mp\killstreaks\_utility::func_A69F(self.streakinfo, "passive_armor_speed")) {
      var_0F++;
      var_10++;
      var_11++;
    }

    if(isDefined(var_09)) {
      if(scripts\mp\killstreaks\_utility::func_A69F(self.streakinfo, "passive_armor_speed")) {
        if(scripts\mp\killstreaks\_utility::isexplosiveantikillstreakweapon(var_09)) {
          var_01 scripts\mp\damagefeedback::updatedamagefeedback("hitblastshield");
        }
      }

      var_0E = scripts\mp\killstreaks\_utility::getmodifiedantikillstreakdamage(var_01, var_09, var_04, var_0E, self.maxhealth, var_0F, var_10, var_11);
      scripts\mp\killstreaks\_killstreaks::killstreakhit(var_01, var_09, self, var_04);
      scripts\mp\damage::logattackerkillstreak(self, var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
    }

    self.var_E1 = self.var_E1 + var_0E;
    if(self.var_E1 >= self.maxhealth) {
      if(isplayer(var_01) && !isDefined(self.triggerportableradarping) || var_01 != self.triggerportableradarping) {
        var_12 = scripts\mp\killstreak_loot::getrarityforlootitem(self.streakinfo.variantid);
        var_13 = level.uavsettings[self.uavtype].calloutdestroyed;
        if(var_12 != "") {
          var_13 = var_13 + "_" + var_12;
        }

        scripts\mp\damage::onkillstreakkilled(self.uavtype, var_01, var_09, var_04, var_00, "destroyed_" + self.uavtype, self.uavtype + "_destroyed", var_13);
        if(isDefined(self.var_12AF4) && self.var_12AF4 != var_01) {
          self.var_12AF4 thread scripts\mp\killstreaks\_remoteuav::remoteuav_processtaggedassist();
        }
      }

      self hide();
      var_14 = anglestoright(self.angles) * 200;
      playFX(level.uavsettings[self.uavtype].fxid_explode, self.origin, var_14);
      self notify("death");
      return;
    }
  }
}

func_12AF9() {
  level endon("game_ended");
  for(;;) {
    level waittill("uav_update");
    if(level.multiteambased) {
      for(var_00 = 0; var_00 < level.teamnamelist.size; var_00++) {
        func_12F3F(level.teamnamelist[var_00]);
      }

      continue;
    }

    if(level.teambased) {
      func_12F3F("allies");
      func_12F3F("axis");
      scripts\mp\killstreaks\_utility::func_12F51();
      continue;
    }

    func_12EF2();
  }
}

handlewiretap() {
  foreach(var_01 in level.players) {
    if(isDefined(self.streakname) && self.streakname == "directional_uav" || self.streakname == "counter_uav") {
      return;
    }

    if(!var_01 scripts\mp\utility::_hasperk("specialty_expanded_minimap")) {
      continue;
    }

    if(var_01.team == self.team) {
      continue;
    }

    thread executewiretapsweeps(var_01);
  }
}

executewiretapsweeps(param_00) {
  level endon("game_ended");
  param_00 endon("disconnect");
  triggeroneoffradarsweep(param_00);
  self waittill("death");
  triggeroneoffradarsweep(param_00);
}

_getradarstrength(param_00) {
  var_01 = 0;
  var_02 = 0;
  var_03 = 0;
  foreach(var_05 in level.uavmodels[param_00]) {
    if(!isDefined(var_05)) {
      continue;
    }

    if(var_05.uavtype == "counter_uav") {
      continue;
    }

    if(var_05.uavtype == "remote_mortar") {
      continue;
    }

    if(var_05.uavtype == "directional_uav") {
      var_03++;
      continue;
    }

    var_01++;
  }

  if(level.multiteambased) {
    foreach(var_08 in level.teamnamelist) {
      foreach(var_05 in level.uavmodels[var_08]) {
        if(!isDefined(var_05)) {
          continue;
        }

        if(var_08 == param_00) {
          continue;
        }

        if(var_05.uavtype != "counter_uav") {
          continue;
        }

        var_02++;
      }
    }
  } else {
    foreach(var_05 in level.uavmodels[level.otherteam[param_00]]) {
      if(!isDefined(var_05)) {
        continue;
      }

      if(var_05.uavtype != "counter_uav") {
        continue;
      }

      var_02++;
    }
  }

  var_0E = getuavstrengthmin();
  var_0F = getuavstrengthmax();
  if(var_03) {
    var_01 = var_0F - getuavstrengthlevelneutral();
  }

  if(param_00 == "axis") {
    level.axisactiveuavs = var_01;
  } else {
    level.alliesactiveuavs = var_01;
  }

  if(var_02 > 0) {
    var_10 = var_0E;
  } else if(var_04 > 0) {
    var_10 = var_10;
  } else {
    var_10 = int(clamp(var_02 + getuavstrengthlevelneutral(), getuavstrengthlevelneutral(), getuavstrengthlevelshowenemyfastsweep()));
  }

  if(var_10 <= var_0E) {
    var_10 = var_0E;
  } else if(var_10 >= var_0F) {
    var_10 = var_0F;
  }

  return var_10;
}

_setteamradarstrength(param_00, param_01) {
  func_12F3F(param_00, param_01);
}

func_12F3F(param_00, param_01) {
  var_02 = getuavstrengthmin();
  var_03 = getuavstrengthmax();
  var_04 = getuavstrengthlevelshowenemydirectional();
  var_05 = getuavstrengthlevelneutral();
  var_06 = getuavstrengthlevelshowenemyfastsweep();
  if(isDefined(param_01)) {
    var_07 = param_01;
  } else {
    var_07 = _getradarstrength(param_01);
  }

  if(param_00 == "axis") {
    var_08 = level.axisactiveuavs;
  } else {
    var_08 = level.alliesactiveuavs;
  }

  foreach(var_0A in level.players) {
    var_0B = var_07;
    if(var_0A.team != param_00) {
      continue;
    }

    if(var_0A scripts\mp\utility::_hasperk("specialty_empimmune") && var_07 <= var_05) {
      if(scripts\mp\utility::istrue(var_0A.cylinder)) {
        var_0B = var_03;
      }

      if(var_0B != var_03) {
        var_0B = int(clamp(var_08 + var_05, var_05, var_06));
      }
    }

    if(var_0B <= var_02) {
      var_0B = var_02;
    } else if(var_0B >= var_03) {
      var_0B = var_03;
    }

    var_0A.drawsoundshape = var_0B;
    if(var_0B >= var_05) {
      var_0A.randomint = 0;
    } else {
      var_0A.randomint = 1;
    }

    if(var_0B <= var_05) {
      var_0A.playcinematicforall = 0;
      var_0A.cylinder = 0;
      if(isDefined(var_0A.createprintchannel) && var_0A.createprintchannel == "constant_radar") {
        var_0A.createprintchannel = "normal_radar";
      }

      var_0A setclientomnvar("ui_show_hardcore_minimap", 0);
      continue;
    }

    var_0A setradarmode(var_0B, var_06, var_04);
    var_0A.cylinder = var_0B >= var_04;
    var_0A.playcinematicforall = 1;
    var_0A setclientomnvar("ui_show_hardcore_minimap", 1);
  }
}

func_12EF2() {
  var_00 = getuavstrengthmin();
  var_01 = getuavstrengthmax();
  var_02 = getuavstrengthlevelshowenemydirectional();
  var_03 = getuavstrengthlevelshowenemyfastsweep();
  foreach(var_05 in level.players) {
    var_06 = level.activeuavs[var_05.guid + "_radarStrength"];
    foreach(var_08 in level.players) {
      if(var_08 == var_05) {
        continue;
      }

      var_09 = level.var_164F[var_08.guid];
      if(var_09 > 0 && !var_05 scripts\mp\utility::_hasperk("specialty_empimmune")) {
        var_06 = var_00;
        break;
      }
    }

    if(var_06 <= var_00) {
      var_06 = var_00;
    } else if(var_06 >= var_01) {
      var_06 = var_01;
    }

    var_05.drawsoundshape = var_06;
    if(var_06 >= getuavstrengthlevelneutral()) {
      var_05.randomint = 0;
    } else {
      var_05.randomint = 1;
    }

    if(var_06 <= getuavstrengthlevelneutral()) {
      var_05.playcinematicforall = 0;
      var_05.cylinder = 0;
      if(isDefined(var_05.createprintchannel) && var_05.createprintchannel == "constant_radar") {
        var_05.createprintchannel = "normal_radar";
      }

      var_05 setclientomnvar("ui_show_hardcore_minimap", 0);
      continue;
    }

    var_05 setradarmode(var_06, var_03, var_02);
    var_05.cylinder = var_06 >= var_02;
    var_05.playcinematicforall = 1;
    var_05 setclientomnvar("ui_show_hardcore_minimap", 1);
  }
}

setradarmode(param_00, param_01, param_02) {
  if(param_00 >= param_01) {
    self.createprintchannel = "fast_radar";
  } else {
    self.createprintchannel = "normal_radar";
  }

  if(param_00 >= param_02) {
    var_03 = undefined;
    if(level.teambased) {
      var_03 = level.uavmodels[self.team];
    } else {
      var_03 = level.uavmodels;
    }

    foreach(var_05 in var_03) {
      if(isDefined(var_05) && var_05.uavtype == "directional_uav") {
        if(!level.teambased) {
          if(var_05.triggerportableradarping != self) {
            continue;
          }
        }

        if(scripts\mp\killstreaks\_utility::func_A69F(var_05.streakinfo, "passive_vision_sweep")) {
          self.createprintchannel = "constant_radar";
          break;
        }
      }
    }
  }
}

func_2BBC() {
  self endon("disconnect");
  self notify("blockPlayerUAV");
  self endon("blockPlayerUAV");
  self.randomint = 1;
  wait(level.uavblocktime);
  self.randomint = 0;
}

func_12F40(param_00) {
  var_01 = _getradarstrength(param_00) >= getuavstrengthlevelshowenemydirectional();
  foreach(var_03 in level.players) {
    if(var_03.team == "spectator") {
      continue;
    }

    var_03.createprintchannel = level.createprintchannel[var_03.team];
    if(var_03.team == param_00) {
      var_03.cylinder = var_01;
    }
  }
}

useplayeruav(param_00, param_01) {
  level endon("game_ended");
  self endon("disconnect");
  self notify("usePlayerUAV");
  self endon("usePlayerUAV");
  if(param_00) {
    self.createprintchannel = "fast_radar";
  } else {
    self.createprintchannel = "normal_radar";
  }

  self.playcinematicforall = 1;
  wait(param_01);
  self.playcinematicforall = 0;
}

func_F87B(param_00, param_01) {
  setteamradar(param_00, param_01);
  level notify("radar_status_change", param_00);
}

func_89B7() {
  level endon("game_ended");
  self endon("death");
  for(;;) {
    level waittill("stinger_fired", var_00, var_01, var_02);
    if(!isDefined(var_02) || var_02 != self) {
      continue;
    }

    var_01 thread func_10FA8(var_02, var_00);
  }
}

func_10FA8(param_00, param_01) {
  self endon("death");
  var_02 = distance(self.origin, param_00 getpointinbounds(0, 0, 0));
  var_03 = param_00 getpointinbounds(0, 0, 0);
  for(;;) {
    if(!isDefined(param_00)) {
      var_04 = var_03;
    } else {
      var_04 = param_00 getpointinbounds(0, 0, 0);
    }

    var_03 = var_04;
    var_05 = distance(self.origin, var_04);
    if(var_05 < var_02) {
      var_02 = var_05;
    }

    if(var_05 > var_02) {
      if(var_05 > 1536) {
        return;
      }

      radiusdamage(self.origin, 1536, 600, 600, param_01, "MOD_EXPLOSIVE", "iw7_lockon_mp");
      playFX(level.var_10FA1, self.origin);
      self hide();
      self notify("deleted");
      wait(0.05);
      self delete();
      param_01 notify("killstreak_destroyed");
    }

    wait(0.05);
  }
}

func_1867() {
  if(level.teambased) {
    level.uavmodels[self.team][level.uavmodels[self.team].size] = self;
    return;
  }

  level.uavmodels[self.triggerportableradarping.guid + "_" + gettime()] = self;
}

func_E182() {
  var_00 = [];
  if(level.teambased) {
    var_01 = self.team;
    foreach(var_03 in level.uavmodels[var_01]) {
      if(!isDefined(var_03)) {
        continue;
      }

      var_00[var_00.size] = var_03;
    }

    level.uavmodels[var_01] = var_00;
    return;
  }

  foreach(var_03 in level.uavmodels) {
    if(!isDefined(var_03)) {
      continue;
    }

    var_00[var_00.size] = var_03;
  }

  level.uavmodels = var_00;
}

func_179A() {
  if(level.teambased) {
    level.activeuavs[self.team]++;
    if(self.uavtype == "directional_uav") {
      level.activeadvanceduavs[self.team]++;
      return;
    }

    return;
  }

  level.activeuavs[self.triggerportableradarping.guid]++;
  level.activeuavs[self.triggerportableradarping.guid + "_radarStrength"]++;
  if(self.uavtype == "directional_uav") {
    level.activeuavs[self.triggerportableradarping.guid + "_radarStrength"] = level.activeuavs[self.triggerportableradarping.guid + "_radarStrength"] + 2;
    if(!isDefined(level.activeadvanceduavs[self.triggerportableradarping.guid])) {
      level.activeadvanceduavs[self.triggerportableradarping.guid] = 0;
    }

    level.activeadvanceduavs[self.triggerportableradarping.guid]++;
  }
}

func_1799() {
  if(level.teambased) {
    level.var_164F[self.team]++;
    return;
  }

  level.var_164F[self.triggerportableradarping.guid]++;
}

func_E0C1() {
  if(level.teambased) {
    level.activeuavs[self.team]--;
    if(self.uavtype == "directional_uav") {
      level.activeadvanceduavs[self.team]--;
      return;
    }

    return;
  }

  if(isDefined(self.triggerportableradarping)) {
    level.activeuavs[self.triggerportableradarping.guid]--;
    level.activeuavs[self.triggerportableradarping.guid + "_radarStrength"]--;
    if(self.uavtype == "directional_uav") {
      level.activeuavs[self.triggerportableradarping.guid + "_radarStrength"] = level.activeuavs[self.triggerportableradarping.guid + "_radarStrength"] - 2;
      level.activeadvanceduavs[self.triggerportableradarping.guid]--;
      return;
    }
  }
}

func_E0BF() {
  if(level.teambased) {
    level.var_164F[self.team]--;
    return;
  }

  if(isDefined(self.triggerportableradarping)) {
    level.var_164F[self.triggerportableradarping.guid]--;
  }
}

spawnfxdelay(param_00, param_01) {
  self endon("death");
  level endon("game_ended");
  wait(0.5);
  playFXOnTag(param_00, self, param_01);
}

func_13920(param_00, param_01) {
  if(isDefined(param_01)) {
    param_01 endon("death");
  }

  self endon("leave");
  self endon("killstreak_disowned");
  level endon("game_ended");
  var_02 = level.uavsettings[param_00];
  var_03 = var_02.var_CB9A;
  if(level.teambased) {
    level.activeuavs[self.team]++;
  } else {
    level.activeuavs[self.guid]++;
  }

  for(;;) {
    playFX(var_02.var_7636, self.origin);
    self playlocalsound(var_02.var_1046A);
    playsoundatpos(self.origin + (0, 0, 5), var_02.var_10469);
    foreach(var_05 in level.participants) {
      if(!scripts\mp\utility::isreallyalive(var_05)) {
        continue;
      }

      if(!scripts\mp\utility::isenemy(var_05)) {
        continue;
      }

      if(var_05 scripts\mp\utility::_hasperk("specialty_noplayertarget")) {
        continue;
      }

      var_05 scripts\mp\hud_message::showmiscmessage("spotted");
      foreach(var_07 in level.participants) {
        if(!scripts\mp\utility::isreallyalive(var_07)) {
          continue;
        }

        if(scripts\mp\utility::isenemy(var_07)) {
          continue;
        }

        if(isai(var_07)) {
          var_07 scripts\engine\utility::ai_3d_sighting_model(var_05);
          continue;
        }

        var_08 = scripts\mp\utility::outlineenableforplayer(var_05, "orange", var_07, 0, 0, "killstreak");
        var_09 = var_02.var_8EF7;
        var_07 thread func_13AA0(var_08, var_05, var_09, param_01);
      }
    }

    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_03);
  }
}

func_13921(param_00) {
  self endon("killstreak_disowned");
  level endon("game_ended");
  var_01 = level.uavsettings[param_00];
  var_02 = var_01.timeout;
  var_03 = self.guid;
  if(level.teambased) {
    var_03 = self.team;
  }

  thread func_13922(var_03);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_02);
  scripts\mp\utility::leaderdialogonplayer(var_01.votimeout);
  self notify("leave");
  func_4044(var_03);
}

func_13922(param_00) {
  self endon("leave");
  self waittill("killstreak_disowned");
  func_4044(param_00);
}

func_4044(param_00) {
  level.activeuavs[param_00]--;
  if(level.activeuavs[param_00] < 0) {
    level.activeuavs[param_00] = 0;
  }
}

func_13AA0(param_00, param_01, param_02, param_03) {
  if(isDefined(param_03)) {
    param_03 endon("death");
  }

  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_timeout_no_endon_death_2(param_02, "leave");
  if(isDefined(param_01)) {
    scripts\mp\utility::outlinedisable(param_00, param_01);
  }
}

_meth_81E8(param_00, param_01) {
  var_02 = undefined;
  switch (param_00) {
    case "uav":
      var_02 = level.var_12AF5;
      break;

    case "counter_uav":
      var_02 = level.var_46B8;
      break;

    case "directional_uav":
      var_02 = level.var_18D2;
      if(scripts\mp\killstreaks\_utility::func_A69F(param_01, "passive_stealth_vehicle")) {
        var_02 = level.advanceduavrigslow;
      }
      break;

    case "default":
      break;
  }

  return var_02;
}

func_CA50() {
  self.triggerportableradarping endon("disconnect");
  self endon("uav_deleteObjective");
  switch (self.uavtype) {
    case "uav":
      var_00 = "icon_minimap_uav_enemy";
      break;

    case "counter_uav":
      var_00 = "icon_minimap_counter_uav_enemy";
      break;

    case "directional_uav":
      var_00 = "icon_minimap_advanced_uav_enemy";
      break;

    default:
      var_00 = "icon_minimap_uav_enemy";
      break;
  }

  self.var_6569 = scripts\mp\killstreaks\_airdrop::createobjective_engineer(var_00, 1, 1);
  for(;;) {
    foreach(var_02 in level.players) {
      if(!isDefined(var_02)) {
        continue;
      }

      if(!isplayer(var_02)) {
        continue;
      }

      if(self.var_6569 != -1) {
        if(var_02 scripts\mp\utility::_hasperk("specialty_engineer") && scripts\mp\utility::istrue(scripts\mp\utility::playersareenemies(var_02, self.triggerportableradarping))) {
          scripts\mp\objidpoolmanager::minimap_objective_playermask_showto(self.var_6569, var_02 getentitynumber());
          continue;
        }

        scripts\mp\objidpoolmanager::minimap_objective_playermask_hidefrom(self.var_6569, var_02 getentitynumber());
      }
    }

    wait(0.1);
  }
}

startsystemshutdown() {
  level endon("game_ended");
  foreach(var_01 in level.players) {
    if(!scripts\mp\utility::isreallyalive(var_01)) {
      continue;
    }

    if(!scripts\mp\utility::playersareenemies(self.triggerportableradarping, var_01)) {
      continue;
    }

    if(!var_01 scripts\mp\utility::_hasperk("specialty_empimmune")) {
      var_01 thread shutdownenemysystem(self);
    }
  }

  thread applyshutdownonspawn();
}

givefriendlyperks(param_00) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  scripts\mp\utility::giveperk("specialty_coldblooded");
  scripts\mp\utility::giveperk("specialty_tracker_jammer");
  scripts\mp\utility::giveperk("specialty_noscopeoutline");
  param_00 waittill("death");
  scripts\mp\utility::removeperk("specialty_coldblooded");
  scripts\mp\utility::removeperk("specialty_tracker_jammer");
  scripts\mp\utility::removeperk("specialty_noscopeoutline");
}

shutdownenemysystem(param_00) {
  self endon("disconnect");
  level endon("game_ended");
  self _meth_85C7(1);
  self playlocalsound("counter_uav_jam_sfx");
  param_00 waittill("death");
  self _meth_85C7(0);
  self playlocalsound("counter_uav_jam_reboot_sfx");
}

applyshutdownonspawn() {
  self endon("death");
  level endon("game_ended");
  var_00 = self.triggerportableradarping;
  var_01 = var_00.team;
  for(;;) {
    level waittill("player_spawned", var_02);
    if(!scripts\mp\utility::playersareenemies(var_00, var_02)) {
      continue;
    }

    if(!var_02 scripts\mp\utility::_hasperk("specialty_empimmune")) {
      var_02 thread shutdownenemysystem(self);
    }
  }
}

startemppulse() {
  self endon("death");
  level endon("game_ended");
  wait(2);
  self playSound("jammer_drone_charge");
  playFXOnTag(scripts\engine\utility::getfx("jammer_drone_charge"), self, "tag_origin");
  wait(1.5);
  stopFXOnTag(scripts\engine\utility::getfx("jammer_drone_charge"), self, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("jammer_drone_shockwave"), self, "tag_origin");
  self playSound("jammer_drone_shockwave");
  foreach(var_01 in level.players) {
    if(!scripts\mp\utility::isreallyalive(var_01)) {
      continue;
    }

    if(!scripts\mp\utility::playersareenemies(self.triggerportableradarping, var_01)) {
      continue;
    }

    if(var_01 scripts\mp\utility::_hasperk("specialty_empimmune")) {
      continue;
    }

    var_02 = 1;
    if(var_01 scripts\mp\killstreaks\_emp_common::isemped()) {
      var_02 = 0;
    }

    var_03 = 1;
    if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_01)) {
      var_03 = 0;
    } else if(scripts\mp\utility::istrue(var_01.visionpulsevisionsetactive)) {
      var_03 = 0;
    }

    var_01 thread applyuavshellshock(var_03, var_02);
  }

  func_52C5(scripts\mp\utility::getotherteam(self.team), self.triggerportableradarping);
}

applyuavshellshock(param_00, param_01) {
  self endon("disconnect");
  if(param_00) {
    self shellshock("flashbang_mp", 0.5);
    thread applyuavshellshockvisionset();
  }

  if(param_01) {
    self setscriptablepartstate("emped", "active", 0);
  }

  self playLoopSound("emp_nade_lp");
  var_02 = gettime() + 500;
  while(gettime() <= var_02) {
    if(param_01 && scripts\mp\killstreaks\_emp_common::isemped()) {
      param_01 = 0;
    }

    if(!scripts\mp\utility::isreallyalive(self)) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  if(param_01) {
    self setscriptablepartstate("emped", "neutral", 0);
  }

  self stoploopsound("emp_nade_lp");
}

applyuavshellshockvisionset() {
  visionsetnaked("coup_sunblind", 0.05);
  scripts\engine\utility::waitframe();
  visionsetnaked("coup_sunblind", 0);
  visionsetnaked("", 0.5);
}

func_52C5(param_00, param_01) {
  var_02 = "nuke_mp";
  var_03 = level.var_1655;
  var_04 = scripts\mp\perks\_perkfunctions::func_7D96();
  var_05 = undefined;
  if(isDefined(var_03) && isDefined(var_04)) {
    var_05 = scripts\engine\utility::array_combine_unique(var_03, var_04);
  } else if(isDefined(var_03)) {
    var_05 = var_03;
  } else if(isDefined(var_04)) {
    var_05 = var_04;
  }

  if(isDefined(var_05)) {
    foreach(var_07 in var_05) {
      if(isDefined(var_07)) {
        var_07 scripts\mp\killstreaks\_utility::dodamagetokillstreak(10000, param_01, param_01, param_00, var_07.origin, "MOD_EXPLOSIVE", var_02);
      }
    }
  }
}