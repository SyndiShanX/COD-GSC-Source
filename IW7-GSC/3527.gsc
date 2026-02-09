/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3527.gsc
**************************************/

init() {
  level.radarviewtime = 23;
  level.advradarviewtime = 28;
  level.uavblocktime = 23;
  scripts\mp\killstreaks\killstreaks::registerkillstreak("uav", ::func_1290B);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("counter_uav", ::func_1290B);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("directional_uav", ::func_1290B);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("uav_3dping", ::func_128B2);
  var_0 = ["passive_increased_duration", "passive_decreased_duration", "passive_decreased_health", "passive_increased_armor", "passive_increased_cost", "passive_extra_assist", "passive_stealth_vehicle", "passive_vision_sweep", "passive_disable_hud", "passive_emp_blast", "passive_duration_health", "passive_armor_speed", "passive_stealth_speed"];
  scripts\mp\killstreak_loot::func_DF07("uav", var_0);
  scripts\mp\killstreak_loot::func_DF07("counter_uav", var_0);
  scripts\mp\killstreak_loot::func_DF07("directional_uav", var_0);
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
  level.uavsettings["uav_3dping"].var_CB9A = 10.0;
  level.uavsettings["uav_3dping"].var_7636 = loadfx("vfx\core\mp\killstreaks\vfx_3d_world_ping");
  level.uavsettings["uav_3dping"].var_1046A = "oracle_radar_pulse_plr";
  level.uavsettings["uav_3dping"].var_10469 = "oracle_radar_pulse_npc";
  level.uavsettings["uav_3dping"].votimeout = "oracle_gone";
  level.uavsettings["uav_3dping"].teamsplash = "used_uav_3dping";
  var_1 = getEntArray("minimap_corner", "targetname");

  if(var_1.size) {
    level.var_12AF6 = scripts\mp\spawnlogic::findboxcenter(var_1[0].origin, var_1[1].origin);
  } else {
    level.var_12AF6 = (0, 0, 0);
  }

  level.var_12AF5 = spawn("script_model", level.var_12AF6);
  level.var_12AF5 setModel("tag_origin");
  level.var_12AF5.angles = (0, 115, 0);
  level.var_12AF5 hide();
  level.var_12AF5.targetname = "uavrig_script_model";
  level.var_12AF5 thread func_E734(70);
  level.uavrigslow = spawn("script_model", level.var_12AF6);
  level.uavrigslow setModel("tag_origin");
  level.uavrigslow.angles = (0, 115, 0);
  level.uavrigslow hide();
  level.uavrigslow.targetname = "uavrig_script_model";
  level.uavrigslow thread func_E734(90);
  level.var_46B8 = spawn("script_model", level.var_12AF6);
  level.var_46B8 setModel("tag_origin");
  level.var_46B8.angles = (0, 115, 0);
  level.var_46B8 hide();
  level.var_46B8.targetname = "counteruavrig_script_model";
  level.var_46B8 thread func_E734(80);
  level.var_18D2 = spawn("script_model", level.var_12AF6);
  level.var_18D2 setModel("tag_origin");
  level.var_18D2.angles = (0, 115, 0);
  level.var_18D2 hide();
  level.var_18D2.targetname = "advanceduavrig_script_model";
  level.var_18D2 thread func_E734(60);
  level.advanceduavrigslow = spawn("script_model", level.var_12AF6);
  level.advanceduavrigslow setModel("tag_origin");
  level.advanceduavrigslow.angles = (0, 115, 0);
  level.advanceduavrigslow hide();
  level.advanceduavrigslow.targetname = "advanceduavrig_script_model";
  level.advanceduavrigslow thread func_E734(80);
  var_2 = getuavstrengthlevelneutral();

  if(level.multiteambased) {
    for(var_3 = 0; var_3 < level.teamnamelist.size; var_3++) {
      level.radarmode[level.teamnamelist[var_3]] = "normal_radar";
      level.activeuavs[level.teamnamelist[var_3]] = 0;
      level.var_164F[level.teamnamelist[var_3]] = 0;
      level.activeadvanceduavs[level.teamnamelist[var_3]] = 0;
      level.uavmodels[level.teamnamelist[var_3]] = [];
    }
  } else if(level.teambased) {
    level.radarmode["allies"] = "normal_radar";
    level.radarmode["axis"] = "normal_radar";
    level.activeuavs["allies"] = 0;
    level.activeuavs["axis"] = 0;
    level.var_164F["allies"] = 0;
    level.var_164F["axis"] = 0;
    level.activeadvanceduavs["allies"] = 0;
    level.activeadvanceduavs["axis"] = 0;
    level.uavmodels["allies"] = [];
    level.uavmodels["axis"] = [];
  } else {
    level.radarmode = [];
    level.activeuavs = [];
    level.var_164F = [];
    level.activeadvanceduavs = [];
    level.uavmodels = [];
  }

  level thread onplayerconnect();
  level thread func_12AF9();
}

onplayerconnect() {
  var_0 = getuavstrengthlevelneutral();

  for(;;) {
    level waittill("connected", var_1);
    scripts\mp\killstreaks\utility::func_12F51();
    level.activeuavs[var_1.guid] = 0;
    level.activeuavs[var_1.guid + "_radarStrength"] = var_0;
    level.var_164F[var_1.guid] = 0;
    level.radarmode[var_1.guid] = "normal_radar";
    var_1.radarstrength = var_0;
    var_1 thread monitorplayerupdate();
  }
}

monitorplayerupdate() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");
    level notify("uav_update");
  }
}

func_E734(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    self endon(var_2);
  }

  if(!isDefined(var_0)) {
    var_0 = 60;
  }

  if(!isDefined(var_1)) {
    var_1 = -360;
  }

  for(;;) {
    self rotateyaw(var_1, var_0);
    wait(var_0);
  }
}

func_1290B(var_0) {
  return func_130F4(var_0.streakname, var_0);
}

func_128B2(var_0) {
  var_1 = "uav_3dping";
  thread func_13920(var_1);
  thread func_13921(var_1);
  level thread scripts\mp\utility\game::teamplayercardsplash(level.uavsettings[var_1].teamsplash, self);
  return 1;
}

func_130F4(var_0, var_1) {
  scripts\mp\matchdata::logkillstreakevent(var_0, self.origin);
  var_2 = self.pers["team"];
  var_3 = level.uavsettings[var_0].timeout;
  level thread launchuav(self, var_0, var_1);

  if(!isDefined(self.var_12AF8)) {
    self.var_12AF8 = [];
  }

  switch (var_0) {
    case "counter_uav":
      self notify("used_counter_uav");
      self.var_12AF8["counter_uav"] = 1;
      break;
    case "directional_uav":
      self.radarshowenemydirection = 1;

      if(level.teambased) {
        foreach(var_5 in level.players) {
          if(var_5.pers["team"] == var_2) {
            var_5.radarshowenemydirection = 1;
          }
        }
      }

      self notify("used_directional_uav");
      self.var_12AF8["directional_uav"] = 1;
      break;
    default:
      self notify("used_uav");

      if(level.teambased) {
        var_7 = _getradarstrength(var_2);

        if(var_7 >= getuavstrengthlevelshowenemyfastsweep()) {
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

launchuav(var_0, var_1, var_2) {
  var_3 = var_0.team;
  var_4 = func_81E8(var_1, var_2);
  var_5 = spawn("script_model", var_4 gettagorigin("tag_origin") + (0, 0, 5000));
  var_6 = level.uavsettings[var_1].modelbase;
  var_7 = level.uavsettings[var_1].timeout;
  var_8 = level.uavsettings[var_1].maxhealth;
  var_9 = level.uavsettings[var_1].teamsplash;
  var_10 = scripts\mp\killstreak_loot::getrarityforlootitem(var_2.variantid);

  if(var_10 != "") {
    var_6 = var_6 + "_" + var_10;
    var_9 = var_9 + "_" + var_10;
  }

  level thread scripts\mp\utility\game::teamplayercardsplash(var_9, var_0);

  if(var_1 == "uav") {
    if(scripts\mp\killstreaks\utility::func_A69F(var_2, "passive_duration_health")) {
      var_7 = var_7 + 5;
      var_8 = var_8 - 200;
    }

    if(scripts\mp\killstreaks\utility::func_A69F(var_2, "passive_armor_speed")) {
      var_7 = var_7 - 5;
    }
  } else if(var_1 == "counter_uav") {
    if(scripts\mp\killstreaks\utility::func_A69F(var_2, "passive_duration_health")) {
      var_7 = var_7 + 5;
      var_8 = var_8 - 200;
    }

    if(scripts\mp\killstreaks\utility::func_A69F(var_2, "passive_disable_hud")) {
      var_7 = var_7 - 10;
    }
  } else {
    if(scripts\mp\killstreaks\utility::func_A69F(var_2, "passive_duration_health")) {
      var_7 = var_7 + 5;
      var_8 = var_8 - 500;
    }

    if(scripts\mp\killstreaks\utility::func_A69F(var_2, "passive_vision_sweep")) {
      var_7 = var_7 - 5;
    }
  }

  var_5 setModel(var_6);
  var_5.team = var_3;
  var_5.owner = var_0;
  var_5.var_11938 = 0;
  var_5.uavtype = var_1;
  var_5.health = level.uavsettings[var_1].health;
  var_5.maxhealth = var_8;
  var_5.streakinfo = var_2;
  var_5 setotherent(var_0);
  var_5 func_8549();
  var_5 func_8594();
  var_5 scripts\mp\killstreaks\utility::func_1843(var_1, "Killstreak_Air", var_0);
  var_5 thread damagetracker();
  var_5 thread func_89B7();
  var_5 thread func_CA50();
  var_5 thread monitorowner();
  var_5 thread func_E2E4();
  var_5 setscriptablepartstate("lights", "on", 0);

  if(scripts\mp\killstreaks\utility::func_A69F(var_2, "passive_stealth_vehicle")) {
    var_5 setscriptablepartstate("stealth", "active", 0);
  }

  var_11 = randomintrange(5250, 5500);

  if(isDefined(level.spawnpoints)) {
    var_12 = level.spawnpoints;
  } else {
    var_12 = level.var_10DF1;
  }

  var_13 = var_12[0];

  foreach(var_15 in var_12) {
    if(var_15.origin[2] < var_13.origin[2]) {
      var_13 = var_15;
    }
  }

  var_17 = var_13.origin[2];
  var_18 = var_4.origin[2];

  if(var_17 < 0) {
    var_18 = var_18 + var_17 * -1;
    var_17 = 0;
  }

  var_19 = var_18 - var_17;

  if(var_19 + var_11 > 8100.0) {
    var_11 = var_11 - (var_19 + var_11 - 8100.0);
  }

  var_20 = randomint(360);
  var_21 = randomint(1000) + 4000;
  var_22 = cos(var_20) * var_21;
  var_23 = sin(var_20) * var_21;
  var_24 = vectornormalize((var_22, var_23, var_11));
  var_24 = var_24 * var_11;
  var_5 linkto(var_4, "tag_origin", var_24, (0, var_20 - 90, 0));
  var_5 thread func_12F50();
  var_5[[level.uavsettings[var_1].var_17C8]]();

  if(isDefined(level.activeuavs[var_3])) {
    foreach(var_26 in level.uavmodels[var_3]) {
      if(var_26 == var_5) {
        continue;
      }
      if(isDefined(var_26.var_11938)) {
        var_26.var_11938 = var_26.var_11938 + 5;
      }
    }
  }

  var_5 thread handlewiretap();

  if(scripts\mp\killstreaks\utility::func_A69F(var_2, "passive_disable_hud")) {
    var_5 thread startsystemshutdown();
  }

  if(scripts\mp\killstreaks\utility::func_A69F(var_2, "passive_emp_blast")) {
    var_5 thread startemppulse();
  }

  level notify("uav_update");
  var_5 scripts\mp\hostmigration::waittill_notify_or_timeout_hostmigration_pause("death", var_7);

  if(var_5.damagetaken < var_5.maxhealth) {
    var_5 unlink();
    var_28 = var_5.origin + anglesToForward(var_5.angles) * 20000;
    var_5 moveto(var_28, 60);

    if(isDefined(level.uavsettings[var_1].var_7631) && isDefined(level.uavsettings[var_1].fx_leave_tag)) {
      playFXOnTag(level.uavsettings[var_1].var_7631, var_5, level.uavsettings[var_1].fx_leave_tag);
    }

    var_5 scripts\mp\hostmigration::waittill_notify_or_timeout_hostmigration_pause("death", 3);

    if(var_5.damagetaken < var_5.maxhealth) {
      var_5 notify("leaving");
      var_5 setscriptablepartstate("trail", "on", 0);
      var_5.isleaving = 1;
      var_5 moveto(var_28, 4, 4, 0.0);
    }

    var_5 scripts\mp\hostmigration::waittill_notify_or_timeout_hostmigration_pause("death", 4 + var_5.var_11938);
  }

  var_5[[level.uavsettings[var_1].var_E124]]();

  if(isDefined(var_5.var_6569)) {
    scripts\mp\objidpoolmanager::returnminimapid(var_5.var_6569);
    var_5 notify("uav_deleteObjective");
  }

  if(isDefined(var_5)) {
    var_5 delete();
  }

  if(var_1 == "directional_uav") {
    var_0.radarshowenemydirection = 0;

    if(level.teambased) {
      foreach(var_30 in level.players) {
        if(var_30.pers["team"] == var_3) {
          var_30.radarshowenemydirection = 0;
        }
      }
    }
  }

  scripts\mp\utility\game::printgameaction("killstreak ended - " + var_1, var_0);
  level notify("uav_update");
}

monitorowner() {
  self endon("death");
  self.owner scripts\engine\utility::waittill_any("disconnect", "joined_team");
  self hide();
  var_0 = anglestoright(self.angles) * 200;
  playFX(level.uavsettings[self.uavtype].fxid_explode, self.origin, var_0);
  self.damagetaken = self.maxhealth;
  self notify("death");
}

func_E2E4() {
  self endon("death");

  for(;;) {
    level waittill("host_migration_end");

    if(level.teambased) {
      var_0 = _getradarstrength("allies");
      var_1 = _getradarstrength("axis");
      _setteamradarstrength("allies", var_0);
      _setteamradarstrength("axis", var_1);
    }
  }
}

func_12F50() {
  self endon("death");

  for(;;) {
    level scripts\engine\utility::waittill_either("joined_team", "uav_update");
    self hide();

    foreach(var_1 in level.players) {
      if(level.teambased) {
        if(var_1.team != self.team) {
          self giveperkequipment(var_1);
        }

        continue;
      }

      if(isDefined(self.owner) && var_1 == self.owner) {
        continue;
      }
      self giveperkequipment(var_1);
    }
  }
}

damagetracker() {
  level endon("game_ended");
  self setCanDamage(1);
  self.damagetaken = 0;

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    var_9 = scripts\mp\utility\game::func_13CA1(var_9, var_13);

    if(!isPlayer(var_1)) {
      if(!isDefined(self)) {
        return;
      }
    } else {
      if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_1)) {
        continue;
      }
      if(isDefined(var_8) && var_8 &level.idflags_penetration) {
        self.wasdamagedfrombulletpenetration = 1;
      }

      if(isDefined(var_8) && var_8 &level.idflags_no_team_protection) {
        self.wasdamagedfrombulletricochet = 1;
      }

      self.wasdamaged = 1;
      var_14 = var_0;

      if(isPlayer(var_1)) {
        var_1 scripts\mp\damagefeedback::updatedamagefeedback("");

        if(var_4 == "MOD_RIFLE_BULLET" || var_4 == "MOD_PISTOL_BULLET") {
          if(var_1 scripts\mp\utility\game::_hasperk("specialty_armorpiercing")) {
            var_14 = var_14 + var_0 * level.armorpiercingmod;
          }
        }
      }

      var_15 = 1;
      var_16 = 1;
      var_17 = 1;

      if(self.uavtype == "directional_uav") {
        var_15 = 5;
        var_16 = 6;
        var_17 = 7;

        if(scripts\mp\killstreaks\utility::func_A69F(self.streakinfo, "passive_duration_health")) {
          var_15--;
          var_16--;
          var_17--;
        }
      }

      if(scripts\mp\killstreaks\utility::func_A69F(self.streakinfo, "passive_armor_speed")) {
        var_15++;
        var_16++;
        var_17++;
      }

      if(isDefined(var_9)) {
        if(scripts\mp\killstreaks\utility::func_A69F(self.streakinfo, "passive_armor_speed")) {
          if(scripts\mp\killstreaks\utility::isexplosiveantikillstreakweapon(var_9)) {
            var_1 scripts\mp\damagefeedback::updatedamagefeedback("hitblastshield");
          }
        }

        var_14 = scripts\mp\killstreaks\utility::getmodifiedantikillstreakdamage(var_1, var_9, var_4, var_14, self.maxhealth, var_15, var_16, var_17);
        scripts\mp\killstreaks\killstreaks::killstreakhit(var_1, var_9, self, var_4);
        scripts\mp\damage::logattackerkillstreak(self, var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
      }

      self.damagetaken = self.damagetaken + var_14;

      if(self.damagetaken >= self.maxhealth) {
        if(isPlayer(var_1) && (!isDefined(self.owner) || var_1 != self.owner)) {
          var_18 = scripts\mp\killstreak_loot::getrarityforlootitem(self.streakinfo.variantid);
          var_19 = level.uavsettings[self.uavtype].calloutdestroyed;

          if(var_18 != "") {
            var_19 = var_19 + "_" + var_18;
          }

          scripts\mp\damage::onkillstreakkilled(self.uavtype, var_1, var_9, var_4, var_0, "destroyed_" + self.uavtype, self.uavtype + "_destroyed", var_19);

          if(isDefined(self.var_12AF4) && self.var_12AF4 != var_1) {
            self.var_12AF4 thread scripts\mp\killstreaks\remoteuav::remoteuav_processtaggedassist();
          }
        }

        self hide();
        var_20 = anglestoright(self.angles) * 200;
        playFX(level.uavsettings[self.uavtype].fxid_explode, self.origin, var_20);
        self notify("death");
        return;
      }
    }
  }
}

func_12AF9() {
  level endon("game_ended");

  for(;;) {
    level waittill("uav_update");

    if(level.multiteambased) {
      for(var_0 = 0; var_0 < level.teamnamelist.size; var_0++) {
        func_12F3F(level.teamnamelist[var_0]);
      }

      continue;
    }

    if(level.teambased) {
      func_12F3F("allies");
      func_12F3F("axis");
      scripts\mp\killstreaks\utility::func_12F51();
      continue;
    }

    func_12EF2();
  }
}

handlewiretap() {
  foreach(var_1 in level.players) {
    if(isDefined(self.streakname) && (self.streakname == "directional_uav" || self.streakname == "counter_uav")) {
      return;
    }
    if(!var_1 scripts\mp\utility\game::_hasperk("specialty_expanded_minimap")) {
      continue;
    }
    if(var_1.team == self.team) {
      continue;
    }
    thread executewiretapsweeps(var_1);
  }
}

executewiretapsweeps(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  triggeroneoffradarsweep(var_0);
  self waittill("death");
  triggeroneoffradarsweep(var_0);
}

_getradarstrength(var_0) {
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;

  foreach(var_5 in level.uavmodels[var_0]) {
    if(!isDefined(var_5)) {
      continue;
    }
    if(var_5.uavtype == "counter_uav") {
      continue;
    }
    if(var_5.uavtype == "remote_mortar") {
      continue;
    }
    if(var_5.uavtype == "directional_uav") {
      var_3++;
      continue;
    }

    var_1++;
  }

  if(level.multiteambased) {
    foreach(var_8 in level.teamnamelist) {
      foreach(var_5 in level.uavmodels[var_8]) {
        if(!isDefined(var_5)) {
          continue;
        }
        if(var_8 == var_0) {
          continue;
        }
        if(var_5.uavtype != "counter_uav") {
          continue;
        }
        var_2++;
      }
    }
  } else {
    foreach(var_5 in level.uavmodels[level.otherteam[var_0]]) {
      if(!isDefined(var_5)) {
        continue;
      }
      if(var_5.uavtype != "counter_uav") {
        continue;
      }
      var_2++;
    }
  }

  var_14 = getuavstrengthmin();
  var_15 = getuavstrengthmax();

  if(var_3) {
    var_1 = var_15 - getuavstrengthlevelneutral();
  }

  if(var_0 == "axis") {
    level.axisactiveuavs = var_1;
  } else {
    level.alliesactiveuavs = var_1;
  }

  if(var_2 > 0) {
    var_16 = var_14;
  } else if(var_3 > 0) {
    var_16 = var_15;
  } else {
    var_16 = int(clamp(var_1 + getuavstrengthlevelneutral(), getuavstrengthlevelneutral(), getuavstrengthlevelshowenemyfastsweep()));
  }

  if(var_16 <= var_14) {
    var_16 = var_14;
  } else if(var_16 >= var_15) {
    var_16 = var_15;
  }

  return var_16;
}

_setteamradarstrength(var_0, var_1) {
  func_12F3F(var_0, var_1);
}

func_12F3F(var_0, var_1) {
  var_2 = getuavstrengthmin();
  var_3 = getuavstrengthmax();
  var_4 = getuavstrengthlevelshowenemydirectional();
  var_5 = getuavstrengthlevelneutral();
  var_6 = getuavstrengthlevelshowenemyfastsweep();

  if(isDefined(var_1)) {
    var_7 = var_1;
  } else {
    var_7 = _getradarstrength(var_0);
  }

  if(var_0 == "axis") {
    var_8 = level.axisactiveuavs;
  } else {
    var_8 = level.alliesactiveuavs;
  }

  foreach(var_10 in level.players) {
    var_11 = var_7;

    if(var_10.team != var_0) {
      continue;
    }
    if(var_10 scripts\mp\utility\game::_hasperk("specialty_empimmune") && var_7 <= var_5) {
      if(scripts\mp\utility\game::istrue(var_10.radarshowenemydirection)) {
        var_11 = var_3;
      }

      if(var_11 != var_3) {
        var_11 = int(clamp(var_8 + var_5, var_5, var_6));
      }
    }

    if(var_11 <= var_2) {
      var_11 = var_2;
    } else if(var_11 >= var_3) {
      var_11 = var_3;
    }

    var_10.radarstrength = var_11;

    if(var_11 >= var_5) {
      var_10.isradarblocked = 0;
    } else {
      var_10.isradarblocked = 1;
    }

    if(var_11 <= var_5) {
      var_10.hasradar = 0;
      var_10.radarshowenemydirection = 0;

      if(isDefined(var_10.radarmode) && var_10.radarmode == "constant_radar") {
        var_10.radarmode = "normal_radar";
      }

      var_10 setclientomnvar("ui_show_hardcore_minimap", 0);
      continue;
    }

    var_10 setradarmode(var_11, var_6, var_4);
    var_10.radarshowenemydirection = var_11 >= var_4;
    var_10.hasradar = 1;
    var_10 setclientomnvar("ui_show_hardcore_minimap", 1);
  }
}

func_12EF2() {
  var_0 = getuavstrengthmin();
  var_1 = getuavstrengthmax();
  var_2 = getuavstrengthlevelshowenemydirectional();
  var_3 = getuavstrengthlevelshowenemyfastsweep();

  foreach(var_5 in level.players) {
    var_6 = level.activeuavs[var_5.guid + "_radarStrength"];

    foreach(var_8 in level.players) {
      if(var_8 == var_5) {
        continue;
      }
      var_9 = level.var_164F[var_8.guid];

      if(var_9 > 0 && !var_5 scripts\mp\utility\game::_hasperk("specialty_empimmune")) {
        var_6 = var_0;
        break;
      }
    }

    if(var_6 <= var_0) {
      var_6 = var_0;
    } else if(var_6 >= var_1) {
      var_6 = var_1;
    }

    var_5.radarstrength = var_6;

    if(var_6 >= getuavstrengthlevelneutral()) {
      var_5.isradarblocked = 0;
    } else {
      var_5.isradarblocked = 1;
    }

    if(var_6 <= getuavstrengthlevelneutral()) {
      var_5.hasradar = 0;
      var_5.radarshowenemydirection = 0;

      if(isDefined(var_5.radarmode) && var_5.radarmode == "constant_radar") {
        var_5.radarmode = "normal_radar";
      }

      var_5 setclientomnvar("ui_show_hardcore_minimap", 0);
      continue;
    }

    var_5 setradarmode(var_6, var_3, var_2);
    var_5.radarshowenemydirection = var_6 >= var_2;
    var_5.hasradar = 1;
    var_5 setclientomnvar("ui_show_hardcore_minimap", 1);
  }
}

setradarmode(var_0, var_1, var_2) {
  if(var_0 >= var_1) {
    self.radarmode = "fast_radar";
  } else {
    self.radarmode = "normal_radar";
  }

  if(var_0 >= var_2) {
    var_3 = undefined;

    if(level.teambased) {
      var_3 = level.uavmodels[self.team];
    } else {
      var_3 = level.uavmodels;
    }

    foreach(var_5 in var_3) {
      if(isDefined(var_5) && var_5.uavtype == "directional_uav") {
        if(!level.teambased) {
          if(var_5.owner != self) {
            continue;
          }
        }

        if(scripts\mp\killstreaks\utility::func_A69F(var_5.streakinfo, "passive_vision_sweep")) {
          self.radarmode = "constant_radar";
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
  self.isradarblocked = 1;
  wait(level.uavblocktime);
  self.isradarblocked = 0;
}

func_12F40(var_0) {
  var_1 = _getradarstrength(var_0) >= getuavstrengthlevelshowenemydirectional();

  foreach(var_3 in level.players) {
    if(var_3.team == "spectator") {
      continue;
    }
    var_3.radarmode = level.radarmode[var_3.team];

    if(var_3.team == var_0) {
      var_3.radarshowenemydirection = var_1;
    }
  }
}

useplayeruav(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self notify("usePlayerUAV");
  self endon("usePlayerUAV");

  if(var_0) {
    self.radarmode = "fast_radar";
  } else {
    self.radarmode = "normal_radar";
  }

  self.hasradar = 1;
  wait(var_1);
  self.hasradar = 0;
}

func_F87B(var_0, var_1) {
  setteamradar(var_0, var_1);
  level notify("radar_status_change", var_0);
}

func_89B7() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    level waittill("stinger_fired", var_0, var_1, var_2);

    if(!isDefined(var_2) || var_2 != self) {
      continue;
    }
    var_1 thread func_10FA8(var_2, var_0);
  }
}

func_10FA8(var_0, var_1) {
  self endon("death");
  var_2 = distance(self.origin, var_0 getpointinbounds(0, 0, 0));
  var_3 = var_0 getpointinbounds(0, 0, 0);

  for(;;) {
    if(!isDefined(var_0)) {
      var_4 = var_3;
    } else {
      var_4 = var_0 getpointinbounds(0, 0, 0);
    }

    var_3 = var_4;
    var_5 = distance(self.origin, var_4);

    if(var_5 < var_2) {
      var_2 = var_5;
    }

    if(var_5 > var_2) {
      if(var_5 > 1536) {
        return;
      }
      radiusdamage(self.origin, 1536, 600, 600, var_1, "MOD_EXPLOSIVE", "iw7_lockon_mp");
      playFX(level.var_10FA1, self.origin);
      self hide();
      self notify("deleted");
      wait 0.05;
      self delete();
      var_1 notify("killstreak_destroyed");
    }

    wait 0.05;
  }
}

func_1867() {
  if(level.teambased) {
    level.uavmodels[self.team][level.uavmodels[self.team].size] = self;
  } else {
    level.uavmodels[self.owner.guid + "_" + gettime()] = self;
  }
}

func_E182() {
  var_0 = [];

  if(level.teambased) {
    var_1 = self.team;

    foreach(var_3 in level.uavmodels[var_1]) {
      if(!isDefined(var_3)) {
        continue;
      }
      var_0[var_0.size] = var_3;
    }

    level.uavmodels[var_1] = var_0;
  } else {
    foreach(var_3 in level.uavmodels) {
      if(!isDefined(var_3)) {
        continue;
      }
      var_0[var_0.size] = var_3;
    }

    level.uavmodels = var_0;
  }
}

func_179A() {
  if(level.teambased) {
    level.activeuavs[self.team]++;

    if(self.uavtype == "directional_uav") {
      level.activeadvanceduavs[self.team]++;
    }
  } else {
    level.activeuavs[self.owner.guid]++;
    level.activeuavs[self.owner.guid + "_radarStrength"]++;

    if(self.uavtype == "directional_uav") {
      level.activeuavs[self.owner.guid + "_radarStrength"] = level.activeuavs[self.owner.guid + "_radarStrength"] + 2;

      if(!isDefined(level.activeadvanceduavs[self.owner.guid])) {
        level.activeadvanceduavs[self.owner.guid] = 0;
      }

      level.activeadvanceduavs[self.owner.guid]++;
    }
  }
}

func_1799() {
  if(level.teambased) {
    level.var_164F[self.team]++;
  } else {
    level.var_164F[self.owner.guid]++;
  }
}

func_E0C1() {
  if(level.teambased) {
    level.activeuavs[self.team]--;

    if(self.uavtype == "directional_uav") {
      level.activeadvanceduavs[self.team]--;
    }
  } else if(isDefined(self.owner)) {
    level.activeuavs[self.owner.guid]--;
    level.activeuavs[self.owner.guid + "_radarStrength"]--;

    if(self.uavtype == "directional_uav") {
      level.activeuavs[self.owner.guid + "_radarStrength"] = level.activeuavs[self.owner.guid + "_radarStrength"] - 2;
      level.activeadvanceduavs[self.owner.guid]--;
    }
  }
}

func_E0BF() {
  if(level.teambased) {
    level.var_164F[self.team]--;
  } else if(isDefined(self.owner)) {
    level.var_164F[self.owner.guid]--;
  }
}

spawnfxdelay(var_0, var_1) {
  self endon("death");
  level endon("game_ended");
  wait 0.5;
  playFXOnTag(var_0, self, var_1);
}

func_13920(var_0, var_1) {
  if(isDefined(var_1)) {
    var_1 endon("death");
  }

  self endon("leave");
  self endon("killstreak_disowned");
  level endon("game_ended");
  var_2 = level.uavsettings[var_0];
  var_3 = var_2.var_CB9A;

  if(level.teambased) {
    level.activeuavs[self.team]++;
  } else {
    level.activeuavs[self.guid]++;
  }

  for(;;) {
    playFX(var_2.var_7636, self.origin);
    self playlocalsound(var_2.var_1046A);
    playLoopSound(self.origin + (0, 0, 5), var_2.var_10469);

    foreach(var_5 in level.participants) {
      if(!scripts\mp\utility\game::isreallyalive(var_5)) {
        continue;
      }
      if(!scripts\mp\utility\game::isenemy(var_5)) {
        continue;
      }
      if(var_5 scripts\mp\utility\game::_hasperk("specialty_noplayertarget")) {
        continue;
      }
      var_5 scripts\mp\hud_message::showmiscmessage("spotted");

      foreach(var_7 in level.participants) {
        if(!scripts\mp\utility\game::isreallyalive(var_7)) {
          continue;
        }
        if(scripts\mp\utility\game::isenemy(var_7)) {
          continue;
        }
        if(isai(var_7)) {
          var_7 scripts\engine\utility::ai_3d_sighting_model(var_5);
          continue;
        }

        var_8 = scripts\mp\utility\game::outlineenableforplayer(var_5, "orange", var_7, 0, 0, "killstreak");
        var_9 = var_2.var_8EF7;
        var_7 thread func_13AA0(var_8, var_5, var_9, var_1);
      }
    }

    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_3);
  }
}

func_13921(var_0) {
  self endon("killstreak_disowned");
  level endon("game_ended");
  var_1 = level.uavsettings[var_0];
  var_2 = var_1.timeout;
  var_3 = self.guid;

  if(level.teambased) {
    var_3 = self.team;
  }

  thread func_13922(var_3);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_2);
  scripts\mp\utility\game::leaderdialogonplayer(var_1.votimeout);
  self notify("leave");
  func_4044(var_3);
}

func_13922(var_0) {
  self endon("leave");
  self waittill("killstreak_disowned");
  func_4044(var_0);
}

func_4044(var_0) {
  level.activeuavs[var_0]--;

  if(level.activeuavs[var_0] < 0) {
    level.activeuavs[var_0] = 0;
  }
}

func_13AA0(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    var_3 endon("death");
  }

  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_timeout_no_endon_death(var_2, "leave");

  if(isDefined(var_1)) {
    scripts\mp\utility\game::outlinedisable(var_0, var_1);
  }
}

func_81E8(var_0, var_1) {
  var_2 = undefined;

  switch (var_0) {
    case "uav":
      var_2 = level.var_12AF5;
      break;
    case "counter_uav":
      var_2 = level.var_46B8;
      break;
    case "directional_uav":
      var_2 = level.var_18D2;

      if(scripts\mp\killstreaks\utility::func_A69F(var_1, "passive_stealth_vehicle")) {
        var_2 = level.advanceduavrigslow;
      }

      break;
    case "default":
      break;
  }

  return var_2;
}

func_CA50() {
  self.owner endon("disconnect");
  self endon("uav_deleteObjective");

  switch (self.uavtype) {
    case "uav":
      var_0 = "icon_minimap_uav_enemy";
      break;
    case "counter_uav":
      var_0 = "icon_minimap_counter_uav_enemy";
      break;
    case "directional_uav":
      var_0 = "icon_minimap_advanced_uav_enemy";
      break;
    default:
      var_0 = "icon_minimap_uav_enemy";
  }

  self.var_6569 = scripts\mp\killstreaks\airdrop::createobjective_engineer(var_0, 1, 1);

  for(;;) {
    foreach(var_2 in level.players) {
      if(!isDefined(var_2)) {
        continue;
      }
      if(!isPlayer(var_2)) {
        continue;
      }
      if(self.var_6569 != -1) {
        if(var_2 scripts\mp\utility\game::_hasperk("specialty_engineer") && scripts\mp\utility\game::istrue(scripts\mp\utility\game::playersareenemies(var_2, self.owner))) {
          scripts\mp\objidpoolmanager::minimap_objective_playermask_showto(self.var_6569, var_2 getentitynumber());
          continue;
        }

        scripts\mp\objidpoolmanager::minimap_objective_playermask_hidefrom(self.var_6569, var_2 getentitynumber());
      }
    }

    wait 0.1;
  }
}

startsystemshutdown() {
  level endon("game_ended");

  foreach(var_1 in level.players) {
    if(!scripts\mp\utility\game::isreallyalive(var_1)) {
      continue;
    }
    if(!scripts\mp\utility\game::playersareenemies(self.owner, var_1)) {
      continue;
    }
    if(!var_1 scripts\mp\utility\game::_hasperk("specialty_empimmune")) {
      var_1 thread shutdownenemysystem(self);
    }
  }

  thread applyshutdownonspawn();
}

givefriendlyperks(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  scripts\mp\utility\game::giveperk("specialty_coldblooded");
  scripts\mp\utility\game::giveperk("specialty_tracker_jammer");
  scripts\mp\utility\game::giveperk("specialty_noscopeoutline");
  var_0 waittill("death");
  scripts\mp\utility\game::removeperk("specialty_coldblooded");
  scripts\mp\utility\game::removeperk("specialty_tracker_jammer");
  scripts\mp\utility\game::removeperk("specialty_noscopeoutline");
}

shutdownenemysystem(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  self func_85C7(1);
  self playlocalsound("counter_uav_jam_sfx");
  var_0 waittill("death");
  self func_85C7(0);
  self playlocalsound("counter_uav_jam_reboot_sfx");
}

applyshutdownonspawn() {
  self endon("death");
  level endon("game_ended");
  var_0 = self.owner;
  var_1 = var_0.team;

  for(;;) {
    level waittill("player_spawned", var_2);

    if(!scripts\mp\utility\game::playersareenemies(var_0, var_2)) {
      continue;
    }
    if(!var_2 scripts\mp\utility\game::_hasperk("specialty_empimmune")) {
      var_2 thread shutdownenemysystem(self);
    }
  }
}

startemppulse() {
  self endon("death");
  level endon("game_ended");
  wait 2;
  self playSound("jammer_drone_charge");
  playFXOnTag(scripts\engine\utility::getfx("jammer_drone_charge"), self, "tag_origin");
  wait 1.5;
  stopFXOnTag(scripts\engine\utility::getfx("jammer_drone_charge"), self, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("jammer_drone_shockwave"), self, "tag_origin");
  self playSound("jammer_drone_shockwave");

  foreach(var_1 in level.players) {
    if(!scripts\mp\utility\game::isreallyalive(var_1)) {
      continue;
    }
    if(!scripts\mp\utility\game::playersareenemies(self.owner, var_1)) {
      continue;
    }
    if(var_1 scripts\mp\utility\game::_hasperk("specialty_empimmune")) {
      continue;
    }
    var_2 = 1;

    if(var_1 scripts\mp\killstreaks\emp_common::isemped()) {
      var_2 = 0;
    }

    var_3 = 1;

    if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_1)) {
      var_3 = 0;
    } else if(scripts\mp\utility\game::istrue(var_1.visionpulsevisionsetactive)) {
      var_3 = 0;
    }

    var_1 thread applyuavshellshock(var_3, var_2);
  }

  func_52C5(scripts\mp\utility\game::getotherteam(self.team), self.owner);
}

applyuavshellshock(var_0, var_1) {
  self endon("disconnect");

  if(var_0) {
    self shellshock("flashbang_mp", 0.5);
    thread applyuavshellshockvisionset();
  }

  if(var_1) {
    self setscriptablepartstate("emped", "active", 0);
  }

  self playLoopSound("emp_nade_lp");
  var_2 = gettime() + 500.0;

  while(gettime() <= var_2) {
    if(var_1 && scripts\mp\killstreaks\emp_common::isemped()) {
      var_1 = 0;
    }

    if(!scripts\mp\utility\game::isreallyalive(self)) {
      break;
    }
    scripts\engine\utility::waitframe();
  }

  if(var_1) {
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

func_52C5(var_0, var_1) {
  var_2 = "nuke_mp";
  var_3 = level.var_1655;
  var_4 = scripts\mp\perks\perkfunctions::func_7D96();
  var_5 = undefined;

  if(isDefined(var_3) && isDefined(var_4)) {
    var_5 = scripts\engine\utility::array_combine_unique(var_3, var_4);
  } else if(isDefined(var_3)) {
    var_5 = var_3;
  } else if(isDefined(var_4)) {
    var_5 = var_4;
  }

  if(isDefined(var_5)) {
    foreach(var_7 in var_5) {
      if(isDefined(var_7)) {
        var_7 scripts\mp\killstreaks\utility::dodamagetokillstreak(10000, var_1, var_1, var_0, var_7.origin, "MOD_EXPLOSIVE", var_2);
      }
    }
  }
}