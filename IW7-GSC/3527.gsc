/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3527.gsc
***************************************/

init() {
  level.radarviewtime = 23;
  level.advradarviewtime = 28;
  level.uavblocktime = 23;
  scripts\mp\killstreaks\killstreaks::registerkillstreak("uav", ::func_1290B);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("counter_uav", ::func_1290B);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("directional_uav", ::func_1290B);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("uav_3dping", ::func_128B2);
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
  level.uavsettings["uav"].func_7631 = loadfx("vfx\misc\jet_engine_ac130");
  level.uavsettings["uav"].func_7637 = loadfx("vfx\core\mp\killstreaks\vfx_3d_world_ping_large");
  level.uavsettings["uav"].fx_leave_tag = "tag_origin";
  level.uavsettings["uav"].fxid_contrail = undefined;
  level.uavsettings["uav"].func_7566 = undefined;
  level.uavsettings["uav"].sound_explode = "ball_drone_explode";
  level.uavsettings["uav"].teamsplash = "used_uav";
  level.uavsettings["uav"].votimeout = "uav_timeout";
  level.uavsettings["uav"].calloutdestroyed = "callout_destroyed_uav";
  level.uavsettings["uav"].func_17C8 = ::func_179A;
  level.uavsettings["uav"].func_E124 = ::func_E0C1;
  level.uavsettings["counter_uav"] = spawnStruct();
  level.uavsettings["counter_uav"].timeout = level.uavblocktime;
  level.uavsettings["counter_uav"].health = 999999;
  level.uavsettings["counter_uav"].maxhealth = 800;
  level.uavsettings["counter_uav"].streakname = "counter_uav";
  level.uavsettings["counter_uav"].modelbase = "veh_mil_air_un_cuav";
  level.uavsettings["counter_uav"].fxid_explode = loadfx("vfx\iw7\core\mp\killstreaks\vfx_veh_exp_uav.vfx");
  level.uavsettings["counter_uav"].func_7631 = loadfx("vfx\misc\jet_engine_ac130");
  level.uavsettings["counter_uav"].fx_leave_tag = "tag_origin";
  level.uavsettings["counter_uav"].fxid_contrail = undefined;
  level.uavsettings["counter_uav"].func_7566 = undefined;
  level.uavsettings["counter_uav"].sound_explode = "ball_drone_explode";
  level.uavsettings["counter_uav"].votimeout = "counter_uav_timeout";
  level.uavsettings["counter_uav"].teamsplash = "used_counter_uav";
  level.uavsettings["counter_uav"].calloutdestroyed = "callout_destroyed_counter_uav";
  level.uavsettings["counter_uav"].func_17C8 = ::func_1799;
  level.uavsettings["counter_uav"].func_E124 = ::func_E0BF;
  level.uavsettings["directional_uav"] = spawnStruct();
  level.uavsettings["directional_uav"].timeout = level.advradarviewtime;
  level.uavsettings["directional_uav"].health = 999999;
  level.uavsettings["directional_uav"].maxhealth = 2000;
  level.uavsettings["directional_uav"].streakname = "directional_uav";
  level.uavsettings["directional_uav"].modelbase = "veh_mil_air_un_auav";
  level.uavsettings["directional_uav"].fxid_explode = loadfx("vfx\iw7\core\mp\killstreaks\vfx_veh_exp_uav.vfx");
  level.uavsettings["directional_uav"].func_7631 = loadfx("vfx\misc\jet_engine_ac130");
  level.uavsettings["directional_uav"].fx_leave_tag = "tag_origin";
  level.uavsettings["directional_uav"].fxid_contrail = undefined;
  level.uavsettings["directional_uav"].func_7566 = "tag_jet_trail";
  level.uavsettings["directional_uav"].sound_explode = "ball_drone_explode";
  level.uavsettings["directional_uav"].votimeout = "directional_uav_timeout";
  level.uavsettings["directional_uav"].teamsplash = "used_directional_uav";
  level.uavsettings["directional_uav"].calloutdestroyed = "callout_destroyed_directional_uav";
  level.uavsettings["directional_uav"].func_17C8 = ::func_179A;
  level.uavsettings["directional_uav"].func_E124 = ::func_E0C1;
  level.uavsettings["uav_3dping"] = spawnStruct();
  level.uavsettings["uav_3dping"].timeout = 63;
  level.uavsettings["uav_3dping"].streakname = "uav_3dping";
  level.uavsettings["uav_3dping"].func_8EF7 = 1.5;
  level.uavsettings["uav_3dping"].func_CB9A = 10.0;
  level.uavsettings["uav_3dping"].func_7636 = loadfx("vfx\core\mp\killstreaks\vfx_3d_world_ping");
  level.uavsettings["uav_3dping"].func_1046A = "oracle_radar_pulse_plr";
  level.uavsettings["uav_3dping"].func_10469 = "oracle_radar_pulse_npc";
  level.uavsettings["uav_3dping"].votimeout = "oracle_gone";
  level.uavsettings["uav_3dping"].teamsplash = "used_uav_3dping";
  var_01 = getEntArray("minimap_corner", "targetname");

  if(var_1.size)
    level.func_12AF6 = scripts\mp\spawnlogic::findboxcenter(var_1[0].origin, var_1[1].origin);
  else
    level.func_12AF6 = (0, 0, 0);

  level.func_12AF5 = spawn("script_model", level.func_12AF6);
  level.func_12AF5 setModel("tag_origin");
  level.func_12AF5.angles = (0, 115, 0);
  level.func_12AF5 hide();
  level.func_12AF5.targetname = "uavrig_script_model";
  level.func_12AF5 thread func_E734(70);
  level.uavrigslow = spawn("script_model", level.func_12AF6);
  level.uavrigslow setModel("tag_origin");
  level.uavrigslow.angles = (0, 115, 0);
  level.uavrigslow hide();
  level.uavrigslow.targetname = "uavrig_script_model";
  level.uavrigslow thread func_E734(90);
  level.func_46B8 = spawn("script_model", level.func_12AF6);
  level.func_46B8 setModel("tag_origin");
  level.func_46B8.angles = (0, 115, 0);
  level.func_46B8 hide();
  level.func_46B8.targetname = "counteruavrig_script_model";
  level.func_46B8 thread func_E734(80);
  level.func_18D2 = spawn("script_model", level.func_12AF6);
  level.func_18D2 setModel("tag_origin");
  level.func_18D2.angles = (0, 115, 0);
  level.func_18D2 hide();
  level.func_18D2.targetname = "advanceduavrig_script_model";
  level.func_18D2 thread func_E734(60);
  level.advanceduavrigslow = spawn("script_model", level.func_12AF6);
  level.advanceduavrigslow setModel("tag_origin");
  level.advanceduavrigslow.angles = (0, 115, 0);
  level.advanceduavrigslow hide();
  level.advanceduavrigslow.targetname = "advanceduavrig_script_model";
  level.advanceduavrigslow thread func_E734(80);
  var_02 = getuavstrengthlevelneutral();

  if(level.multiteambased) {
    for(var_03 = 0; var_03 < level.teamnamelist.size; var_3++) {
      level.radarmode[level.teamnamelist[var_03]] = "normal_radar";
      level.activeuavs[level.teamnamelist[var_03]] = 0;
      level.func_164F[level.teamnamelist[var_03]] = 0;
      level.activeadvanceduavs[level.teamnamelist[var_03]] = 0;
      level.uavmodels[level.teamnamelist[var_03]] = [];
    }
  } else if(level.teambased) {
    level.radarmode["allies"] = "normal_radar";
    level.radarmode["axis"] = "normal_radar";
    level.activeuavs["allies"] = 0;
    level.activeuavs["axis"] = 0;
    level.func_164F["allies"] = 0;
    level.func_164F["axis"] = 0;
    level.activeadvanceduavs["allies"] = 0;
    level.activeadvanceduavs["axis"] = 0;
    level.uavmodels["allies"] = [];
    level.uavmodels["axis"] = [];
  } else {
    level.radarmode = [];
    level.activeuavs = [];
    level.func_164F = [];
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
    scripts\mp\killstreaks\utility::func_12F51();
    level.activeuavs[var_1.guid] = 0;
    level.activeuavs[var_1.guid + "_radarStrength"] = var_00;
    level.func_164F[var_1.guid] = 0;
    level.radarmode[var_1.guid] = "normal_radar";
    var_1.radarstrength = var_00;
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

func_E734(var_00, var_01, var_02) {
  if(isDefined(var_02))
    self endon(var_02);

  if(!isDefined(var_00))
    var_00 = 60;

  if(!isDefined(var_01))
    var_01 = -360;

  for(;;) {
    self rotateyaw(var_01, var_00);
    wait(var_00);
  }
}

func_1290B(var_00) {
  return func_130F4(var_0.streakname, var_00);
}

func_128B2(var_00) {
  var_01 = "uav_3dping";
  thread func_13920(var_01);
  thread func_13921(var_01);
  level thread scripts\mp\utility\game::teamplayercardsplash(level.uavsettings[var_01].teamsplash, self);
  return 1;
}

func_130F4(var_00, var_01) {
  scripts\mp\matchdata::logkillstreakevent(var_00, self.origin);
  var_02 = self.pers["team"];
  var_03 = level.uavsettings[var_00].timeout;
  level thread launchuav(self, var_00, var_01);

  if(!isDefined(self.func_12AF8))
    self.func_12AF8 = [];

  switch (var_00) {
    case "counter_uav":
      self notify("used_counter_uav");
      self.func_12AF8["counter_uav"] = 1;
      break;
    case "directional_uav":
      self.radarshowenemydirection = 1;

      if(level.teambased) {
        foreach(var_05 in level.players) {
          if(var_5.pers["team"] == var_02)
            var_5.radarshowenemydirection = 1;
        }
      }

      self notify("used_directional_uav");
      self.func_12AF8["directional_uav"] = 1;
      break;
    default:
      self notify("used_uav");

      if(level.teambased) {
        var_07 = _getradarstrength(var_02);

        if(var_07 >= getuavstrengthlevelshowenemyfastsweep())
          scripts\mp\missions::func_D991("ch_uav_doubleup");
      }

      self.func_12AF8["uav"] = 1;
      break;
  }

  if(self.func_12AF8.size == 3) {
    self.func_12AF8 = [];
    scripts\mp\missions::func_D991("ch_uav_combo");
  }

  return 1;
}

launchuav(var_00, var_01, var_02) {
  var_03 = var_0.team;
  var_04 = _meth_81E8(var_01, var_02);
  var_05 = spawn("script_model", var_04 gettagorigin("tag_origin") + (0, 0, 5000));
  var_06 = level.uavsettings[var_01].modelbase;
  var_07 = level.uavsettings[var_01].timeout;
  var_08 = level.uavsettings[var_01].maxhealth;
  var_09 = level.uavsettings[var_01].teamsplash;
  var_10 = scripts\mp\killstreak_loot::getrarityforlootitem(var_2.variantid);

  if(var_10 != "") {
    var_06 = var_06 + "_" + var_10;
    var_09 = var_09 + "_" + var_10;
  }

  level thread scripts\mp\utility\game::teamplayercardsplash(var_09, var_00);

  if(var_01 == "uav") {
    if(scripts\mp\killstreaks\utility::func_A69F(var_02, "passive_duration_health")) {
      var_07 = var_07 + 5;
      var_08 = var_08 - 200;
    }

    if(scripts\mp\killstreaks\utility::func_A69F(var_02, "passive_armor_speed"))
      var_07 = var_07 - 5;
  } else if(var_01 == "counter_uav") {
    if(scripts\mp\killstreaks\utility::func_A69F(var_02, "passive_duration_health")) {
      var_07 = var_07 + 5;
      var_08 = var_08 - 200;
    }

    if(scripts\mp\killstreaks\utility::func_A69F(var_02, "passive_disable_hud"))
      var_07 = var_07 - 10;
  } else {
    if(scripts\mp\killstreaks\utility::func_A69F(var_02, "passive_duration_health")) {
      var_07 = var_07 + 5;
      var_08 = var_08 - 500;
    }

    if(scripts\mp\killstreaks\utility::func_A69F(var_02, "passive_vision_sweep"))
      var_07 = var_07 - 5;
  }

  var_05 setModel(var_06);
  var_5.team = var_03;
  var_5.owner = var_00;
  var_5.func_11938 = 0;
  var_5.uavtype = var_01;
  var_5.health = level.uavsettings[var_01].health;
  var_5.maxhealth = var_08;
  var_5.streakinfo = var_02;
  var_05 setotherent(var_00);
  var_05 _meth_8549();
  var_05 _meth_8594();
  var_05 scripts\mp\killstreaks\utility::func_1843(var_01, "Killstreak_Air", var_00);
  var_05 thread damagetracker();
  var_05 thread func_89B7();
  var_05 thread func_CA50();
  var_05 thread monitorowner();
  var_05 thread func_E2E4();
  var_05 setscriptablepartstate("lights", "on", 0);

  if(scripts\mp\killstreaks\utility::func_A69F(var_02, "passive_stealth_vehicle"))
    var_05 setscriptablepartstate("stealth", "active", 0);

  var_11 = randomintrange(5250, 5500);

  if(isDefined(level.spawnpoints))
    var_12 = level.spawnpoints;
  else
    var_12 = level.func_10DF1;

  var_13 = var_12[0];

  foreach(var_15 in var_12) {
    if(var_15.origin[2] < var_13.origin[2])
      var_13 = var_15;
  }

  var_17 = var_13.origin[2];
  var_18 = var_4.origin[2];

  if(var_17 < 0) {
    var_18 = var_18 + var_17 * -1;
    var_17 = 0;
  }

  var_19 = var_18 - var_17;

  if(var_19 + var_11 > 8100.0)
    var_11 = var_11 - (var_19 + var_11 - 8100.0);

  var_20 = randomint(360);
  var_21 = randomint(1000) + 4000;
  var_22 = cos(var_20) * var_21;
  var_23 = sin(var_20) * var_21;
  var_24 = vectornormalize((var_22, var_23, var_11));
  var_24 = var_24 * var_11;
  var_05 linkto(var_04, "tag_origin", var_24, (0, var_20 - 90, 0));
  var_05 thread func_12F50();
  var_05[[level.uavsettings[var_01].func_17C8]]();

  if(isDefined(level.activeuavs[var_03])) {
    foreach(var_26 in level.uavmodels[var_03]) {
      if(var_26 == var_05) {
        continue;
      }
      if(isDefined(var_26.func_11938))
        var_26.func_11938 = var_26.func_11938 + 5;
    }
  }

  var_05 thread handlewiretap();

  if(scripts\mp\killstreaks\utility::func_A69F(var_02, "passive_disable_hud"))
    var_05 thread startsystemshutdown();

  if(scripts\mp\killstreaks\utility::func_A69F(var_02, "passive_emp_blast"))
    var_05 thread startemppulse();

  level notify("uav_update");
  var_05 scripts\mp\hostmigration::waittill_notify_or_timeout_hostmigration_pause("death", var_07);

  if(var_5.damagetaken < var_5.maxhealth) {
    var_05 unlink();
    var_28 = var_5.origin + anglesToForward(var_5.angles) * 20000;
    var_05 moveto(var_28, 60);

    if(isDefined(level.uavsettings[var_01].func_7631) && isDefined(level.uavsettings[var_01].fx_leave_tag))
      playFXOnTag(level.uavsettings[var_01].func_7631, var_05, level.uavsettings[var_01].fx_leave_tag);

    var_05 scripts\mp\hostmigration::waittill_notify_or_timeout_hostmigration_pause("death", 3);

    if(var_5.damagetaken < var_5.maxhealth) {
      var_05 notify("leaving");
      var_05 setscriptablepartstate("trail", "on", 0);
      var_5.isleaving = 1;
      var_05 moveto(var_28, 4, 4, 0.0);
    }

    var_05 scripts\mp\hostmigration::waittill_notify_or_timeout_hostmigration_pause("death", 4 + var_5.func_11938);
  }

  var_05[[level.uavsettings[var_01].func_E124]]();

  if(isDefined(var_5.func_6569)) {
    scripts\mp\objidpoolmanager::returnminimapid(var_5.func_6569);
    var_05 notify("uav_deleteObjective");
  }

  if(isDefined(var_05))
    var_05 delete();

  if(var_01 == "directional_uav") {
    var_0.radarshowenemydirection = 0;

    if(level.teambased) {
      foreach(var_30 in level.players) {
        if(var_30.pers["team"] == var_03)
          var_30.radarshowenemydirection = 0;
      }
    }
  }

  scripts\mp\utility\game::printgameaction("killstreak ended - " + var_01, var_00);
  level notify("uav_update");
}

monitorowner() {
  self endon("death");
  self.owner scripts\engine\utility::waittill_any("disconnect", "joined_team");
  self hide();
  var_00 = anglestoright(self.angles) * 200;
  playFX(level.uavsettings[self.uavtype].fxid_explode, self.origin, var_00);
  self.damagetaken = self.maxhealth;
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
        if(var_1.team != self.team)
          self giveperkequipment(var_01);

        continue;
      }

      if(isDefined(self.owner) && var_01 == self.owner) {
        continue;
      }
      self giveperkequipment(var_01);
    }
  }
}

damagetracker() {
  level endon("game_ended");
  self setCanDamage(1);
  self.damagetaken = 0;

  for(;;) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_10, var_11, var_12, var_13);
    var_09 = scripts\mp\utility\game::func_13CA1(var_09, var_13);

    if(!isplayer(var_01)) {
      if(!isDefined(self))
        return;
    } else {
      if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_01)) {
        continue;
      }
      if(isDefined(var_08) && var_08 & level.idflags_penetration)
        self.wasdamagedfrombulletpenetration = 1;

      if(isDefined(var_08) && var_08 & level.idflags_no_team_protection)
        self.wasdamagedfrombulletricochet = 1;

      self.wasdamaged = 1;
      var_14 = var_00;

      if(isplayer(var_01)) {
        var_01 scripts\mp\damagefeedback::updatedamagefeedback("");

        if(var_04 == "MOD_RIFLE_BULLET" || var_04 == "MOD_PISTOL_BULLET") {
          if(var_01 scripts\mp\utility\game::_hasperk("specialty_armorpiercing"))
            var_14 = var_14 + var_00 * level.armorpiercingmod;
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

      if(isDefined(var_09)) {
        if(scripts\mp\killstreaks\utility::func_A69F(self.streakinfo, "passive_armor_speed")) {
          if(scripts\mp\killstreaks\utility::isexplosiveantikillstreakweapon(var_09))
            var_01 scripts\mp\damagefeedback::updatedamagefeedback("hitblastshield");
        }

        var_14 = scripts\mp\killstreaks\utility::getmodifiedantikillstreakdamage(var_01, var_09, var_04, var_14, self.maxhealth, var_15, var_16, var_17);
        scripts\mp\killstreaks\killstreaks::killstreakhit(var_01, var_09, self, var_04);
        scripts\mp\damage::logattackerkillstreak(self, var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09);
      }

      self.damagetaken = self.damagetaken + var_14;

      if(self.damagetaken >= self.maxhealth) {
        if(isplayer(var_01) && (!isDefined(self.owner) || var_01 != self.owner)) {
          var_18 = scripts\mp\killstreak_loot::getrarityforlootitem(self.streakinfo.variantid);
          var_19 = level.uavsettings[self.uavtype].calloutdestroyed;

          if(var_18 != "")
            var_19 = var_19 + "_" + var_18;

          scripts\mp\damage::onkillstreakkilled(self.uavtype, var_01, var_09, var_04, var_00, "destroyed_" + self.uavtype, self.uavtype + "_destroyed", var_19);

          if(isDefined(self.func_12AF4) && self.func_12AF4 != var_01)
            self.func_12AF4 thread scripts\mp\killstreaks\remoteuav::remoteuav_processtaggedassist();
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
      for(var_00 = 0; var_00 < level.teamnamelist.size; var_0++)
        func_12F3F(level.teamnamelist[var_00]);

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
  foreach(var_01 in level.players) {
    if(isDefined(self.streakname) && (self.streakname == "directional_uav" || self.streakname == "counter_uav")) {
      return;
    }
    if(!var_01 scripts\mp\utility\game::_hasperk("specialty_expanded_minimap")) {
      continue;
    }
    if(var_1.team == self.team) {
      continue;
    }
    thread executewiretapsweeps(var_01);
  }
}

executewiretapsweeps(var_00) {
  level endon("game_ended");
  var_00 endon("disconnect");
  triggeroneoffradarsweep(var_00);
  self waittill("death");
  triggeroneoffradarsweep(var_00);
}

_getradarstrength(var_00) {
  var_01 = 0;
  var_02 = 0;
  var_03 = 0;

  foreach(var_05 in level.uavmodels[var_00]) {
    if(!isDefined(var_05)) {
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
    foreach(var_08 in level.teamnamelist) {
      foreach(var_05 in level.uavmodels[var_08]) {
        if(!isDefined(var_05)) {
          continue;
        }
        if(var_08 == var_00) {
          continue;
        }
        if(var_5.uavtype != "counter_uav") {
          continue;
        }
        var_2++;
      }
    }
  } else {
    foreach(var_05 in level.uavmodels[level.otherteam[var_00]]) {
      if(!isDefined(var_05)) {
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

  if(var_03)
    var_01 = var_15 - getuavstrengthlevelneutral();

  if(var_00 == "axis")
    level.axisactiveuavs = var_01;
  else
    level.alliesactiveuavs = var_01;

  if(var_02 > 0)
    var_16 = var_14;
  else if(var_03 > 0)
    var_16 = var_15;
  else
    var_16 = int(clamp(var_01 + getuavstrengthlevelneutral(), getuavstrengthlevelneutral(), getuavstrengthlevelshowenemyfastsweep()));

  if(var_16 <= var_14)
    var_16 = var_14;
  else if(var_16 >= var_15)
    var_16 = var_15;

  return var_16;
}

_setteamradarstrength(var_00, var_01) {
  func_12F3F(var_00, var_01);
}

func_12F3F(var_00, var_01) {
  var_02 = getuavstrengthmin();
  var_03 = getuavstrengthmax();
  var_04 = getuavstrengthlevelshowenemydirectional();
  var_05 = getuavstrengthlevelneutral();
  var_06 = getuavstrengthlevelshowenemyfastsweep();

  if(isDefined(var_01))
    var_07 = var_01;
  else
    var_07 = _getradarstrength(var_00);

  if(var_00 == "axis")
    var_08 = level.axisactiveuavs;
  else
    var_08 = level.alliesactiveuavs;

  foreach(var_10 in level.players) {
    var_11 = var_07;

    if(var_10.team != var_00) {
      continue;
    }
    if(var_10 scripts\mp\utility\game::_hasperk("specialty_empimmune") && var_07 <= var_05) {
      if(scripts\mp\utility\game::istrue(var_10.radarshowenemydirection))
        var_11 = var_03;

      if(var_11 != var_03)
        var_11 = int(clamp(var_08 + var_05, var_05, var_06));
    }

    if(var_11 <= var_02)
      var_11 = var_02;
    else if(var_11 >= var_03)
      var_11 = var_03;

    var_10.radarstrength = var_11;

    if(var_11 >= var_05)
      var_10.isradarblocked = 0;
    else
      var_10.isradarblocked = 1;

    if(var_11 <= var_05) {
      var_10.hasradar = 0;
      var_10.radarshowenemydirection = 0;

      if(isDefined(var_10.radarmode) && var_10.radarmode == "constant_radar")
        var_10.radarmode = "normal_radar";

      var_10 setclientomnvar("ui_show_hardcore_minimap", 0);
      continue;
    }

    var_10 setradarmode(var_11, var_06, var_04);
    var_10.radarshowenemydirection = var_11 >= var_04;
    var_10.hasradar = 1;
    var_10 setclientomnvar("ui_show_hardcore_minimap", 1);
  }
}

func_12EF2() {
  var_00 = getuavstrengthmin();
  var_01 = getuavstrengthmax();
  var_02 = getuavstrengthlevelshowenemydirectional();
  var_03 = getuavstrengthlevelshowenemyfastsweep();

  foreach(var_05 in level.players) {
    var_06 = level.activeuavs[var_5.guid + "_radarStrength"];

    foreach(var_08 in level.players) {
      if(var_08 == var_05) {
        continue;
      }
      var_09 = level.func_164F[var_8.guid];

      if(var_09 > 0 && !var_05 scripts\mp\utility\game::_hasperk("specialty_empimmune")) {
        var_06 = var_00;
        break;
      }
    }

    if(var_06 <= var_00)
      var_06 = var_00;
    else if(var_06 >= var_01)
      var_06 = var_01;

    var_5.radarstrength = var_06;

    if(var_06 >= getuavstrengthlevelneutral())
      var_5.isradarblocked = 0;
    else
      var_5.isradarblocked = 1;

    if(var_06 <= getuavstrengthlevelneutral()) {
      var_5.hasradar = 0;
      var_5.radarshowenemydirection = 0;

      if(isDefined(var_5.radarmode) && var_5.radarmode == "constant_radar")
        var_5.radarmode = "normal_radar";

      var_05 setclientomnvar("ui_show_hardcore_minimap", 0);
      continue;
    }

    var_05 setradarmode(var_06, var_03, var_02);
    var_5.radarshowenemydirection = var_06 >= var_02;
    var_5.hasradar = 1;
    var_05 setclientomnvar("ui_show_hardcore_minimap", 1);
  }
}

setradarmode(var_00, var_01, var_02) {
  if(var_00 >= var_01)
    self.radarmode = "fast_radar";
  else
    self.radarmode = "normal_radar";

  if(var_00 >= var_02) {
    var_03 = undefined;

    if(level.teambased)
      var_03 = level.uavmodels[self.team];
    else
      var_03 = level.uavmodels;

    foreach(var_05 in var_03) {
      if(isDefined(var_05) && var_5.uavtype == "directional_uav") {
        if(!level.teambased) {
          if(var_5.owner != self)
            continue;
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

func_12F40(var_00) {
  var_01 = _getradarstrength(var_00) >= getuavstrengthlevelshowenemydirectional();

  foreach(var_03 in level.players) {
    if(var_3.team == "spectator") {
      continue;
    }
    var_3.radarmode = level.radarmode[var_3.team];

    if(var_3.team == var_00)
      var_3.radarshowenemydirection = var_01;
  }
}

useplayeruav(var_00, var_01) {
  level endon("game_ended");
  self endon("disconnect");
  self notify("usePlayerUAV");
  self endon("usePlayerUAV");

  if(var_00)
    self.radarmode = "fast_radar";
  else
    self.radarmode = "normal_radar";

  self.hasradar = 1;
  wait(var_01);
  self.hasradar = 0;
}

func_F87B(var_00, var_01) {
  setteamradar(var_00, var_01);
  level notify("radar_status_change", var_00);
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

func_10FA8(var_00, var_01) {
  self endon("death");
  var_02 = distance(self.origin, var_00 getpointinbounds(0, 0, 0));
  var_03 = var_00 getpointinbounds(0, 0, 0);

  for(;;) {
    if(!isDefined(var_00))
      var_04 = var_03;
    else
      var_04 = var_00 getpointinbounds(0, 0, 0);

    var_03 = var_04;
    var_05 = distance(self.origin, var_04);

    if(var_05 < var_02)
      var_02 = var_05;

    if(var_05 > var_02) {
      if(var_05 > 1536) {
        return;
      }
      radiusdamage(self.origin, 1536, 600, 600, var_01, "MOD_EXPLOSIVE", "iw7_lockon_mp");
      playFX(level.func_10FA1, self.origin);
      self hide();
      self notify("deleted");
      wait 0.05;
      self delete();
      var_01 notify("killstreak_destroyed");
    }

    wait 0.05;
  }
}

func_1867() {
  if(level.teambased)
    level.uavmodels[self.team][level.uavmodels[self.team].size] = self;
  else
    level.uavmodels[self.owner.guid + "_" + gettime()] = self;
}

func_E182() {
  var_00 = [];

  if(level.teambased) {
    var_01 = self.team;

    foreach(var_03 in level.uavmodels[var_01]) {
      if(!isDefined(var_03)) {
        continue;
      }
      var_0[var_0.size] = var_03;
    }

    level.uavmodels[var_01] = var_00;
  } else {
    foreach(var_03 in level.uavmodels) {
      if(!isDefined(var_03)) {
        continue;
      }
      var_0[var_0.size] = var_03;
    }

    level.uavmodels = var_00;
  }
}

func_179A() {
  if(level.teambased) {
    level.activeuavs[self.team]++;

    if(self.uavtype == "directional_uav")
      level.activeadvanceduavs[self.team]++;
  } else {
    level.activeuavs[self.owner.guid]++;
    level.activeuavs[self.owner.guid + "_radarStrength"]++;

    if(self.uavtype == "directional_uav") {
      level.activeuavs[self.owner.guid + "_radarStrength"] = level.activeuavs[self.owner.guid + "_radarStrength"] + 2;

      if(!isDefined(level.activeadvanceduavs[self.owner.guid]))
        level.activeadvanceduavs[self.owner.guid] = 0;

      level.activeadvanceduavs[self.owner.guid]++;
    }
  }
}

func_1799() {
  if(level.teambased)
    level.func_164F[self.team]++;
  else
    level.func_164F[self.owner.guid]++;
}

func_E0C1() {
  if(level.teambased) {
    level.activeuavs[self.team]--;

    if(self.uavtype == "directional_uav")
      level.activeadvanceduavs[self.team]--;
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
  if(level.teambased)
    level.func_164F[self.team]--;
  else if(isDefined(self.owner))
    level.func_164F[self.owner.guid]--;
}

spawnfxdelay(var_00, var_01) {
  self endon("death");
  level endon("game_ended");
  wait 0.5;
  playFXOnTag(var_00, self, var_01);
}

func_13920(var_00, var_01) {
  if(isDefined(var_01))
    var_01 endon("death");

  self endon("leave");
  self endon("killstreak_disowned");
  level endon("game_ended");
  var_02 = level.uavsettings[var_00];
  var_03 = var_2.func_CB9A;

  if(level.teambased)
    level.activeuavs[self.team]++;
  else
    level.activeuavs[self.guid]++;

  for(;;) {
    playFX(var_2.func_7636, self.origin);
    self playlocalsound(var_2.func_1046A);
    playLoopSound(self.origin + (0, 0, 5), var_2.func_10469);

    foreach(var_05 in level.participants) {
      if(!scripts\mp\utility\game::isreallyalive(var_05)) {
        continue;
      }
      if(!scripts\mp\utility\game::isenemy(var_05)) {
        continue;
      }
      if(var_05 scripts\mp\utility\game::_hasperk("specialty_noplayertarget")) {
        continue;
      }
      var_05 scripts\mp\hud_message::showmiscmessage("spotted");

      foreach(var_07 in level.participants) {
        if(!scripts\mp\utility\game::isreallyalive(var_07)) {
          continue;
        }
        if(scripts\mp\utility\game::isenemy(var_07)) {
          continue;
        }
        if(isai(var_07)) {
          var_07 scripts\engine\utility::ai_3d_sighting_model(var_05);
          continue;
        }

        var_08 = scripts\mp\utility\game::outlineenableforplayer(var_05, "orange", var_07, 0, 0, "killstreak");
        var_09 = var_2.func_8EF7;
        var_07 thread func_13AA0(var_08, var_05, var_09, var_01);
      }
    }

    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_03);
  }
}

func_13921(var_00) {
  self endon("killstreak_disowned");
  level endon("game_ended");
  var_01 = level.uavsettings[var_00];
  var_02 = var_1.timeout;
  var_03 = self.guid;

  if(level.teambased)
    var_03 = self.team;

  thread func_13922(var_03);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_02);
  scripts\mp\utility\game::leaderdialogonplayer(var_1.votimeout);
  self notify("leave");
  func_4044(var_03);
}

func_13922(var_00) {
  self endon("leave");
  self waittill("killstreak_disowned");
  func_4044(var_00);
}

func_4044(var_00) {
  level.activeuavs[var_00]--;

  if(level.activeuavs[var_00] < 0)
    level.activeuavs[var_00] = 0;
}

func_13AA0(var_00, var_01, var_02, var_03) {
  if(isDefined(var_03))
    var_03 endon("death");

  self endon("disconnect");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_timeout_no_endon_death(var_02, "leave");

  if(isDefined(var_01))
    scripts\mp\utility\game::outlinedisable(var_00, var_01);
}

_meth_81E8(var_00, var_01) {
  var_02 = undefined;

  switch (var_00) {
    case "uav":
      var_02 = level.func_12AF5;
      break;
    case "counter_uav":
      var_02 = level.func_46B8;
      break;
    case "directional_uav":
      var_02 = level.func_18D2;

      if(scripts\mp\killstreaks\utility::func_A69F(var_01, "passive_stealth_vehicle"))
        var_02 = level.advanceduavrigslow;

      break;
    case "default":
      break;
  }

  return var_02;
}

func_CA50() {
  self.owner endon("disconnect");
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
  }

  self.func_6569 = scripts\mp\killstreaks\airdrop::createobjective_engineer(var_00, 1, 1);

  for(;;) {
    foreach(var_02 in level.players) {
      if(!isDefined(var_02)) {
        continue;
      }
      if(!isplayer(var_02)) {
        continue;
      }
      if(self.func_6569 != -1) {
        if(var_02 scripts\mp\utility\game::_hasperk("specialty_engineer") && scripts\mp\utility\game::istrue(scripts\mp\utility\game::playersareenemies(var_02, self.owner))) {
          scripts\mp\objidpoolmanager::minimap_objective_playermask_showto(self.func_6569, var_02 getentitynumber());
          continue;
        }

        scripts\mp\objidpoolmanager::minimap_objective_playermask_hidefrom(self.func_6569, var_02 getentitynumber());
      }
    }

    wait 0.1;
  }
}

startsystemshutdown() {
  level endon("game_ended");

  foreach(var_01 in level.players) {
    if(!scripts\mp\utility\game::isreallyalive(var_01)) {
      continue;
    }
    if(!scripts\mp\utility\game::playersareenemies(self.owner, var_01)) {
      continue;
    }
    if(!var_01 scripts\mp\utility\game::_hasperk("specialty_empimmune"))
      var_01 thread shutdownenemysystem(self);
  }

  thread applyshutdownonspawn();
}

givefriendlyperks(var_00) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  scripts\mp\utility\game::giveperk("specialty_coldblooded");
  scripts\mp\utility\game::giveperk("specialty_tracker_jammer");
  scripts\mp\utility\game::giveperk("specialty_noscopeoutline");
  var_00 waittill("death");
  scripts\mp\utility\game::removeperk("specialty_coldblooded");
  scripts\mp\utility\game::removeperk("specialty_tracker_jammer");
  scripts\mp\utility\game::removeperk("specialty_noscopeoutline");
}

shutdownenemysystem(var_00) {
  self endon("disconnect");
  level endon("game_ended");
  self _meth_85C7(1);
  self playlocalsound("counter_uav_jam_sfx");
  var_00 waittill("death");
  self _meth_85C7(0);
  self playlocalsound("counter_uav_jam_reboot_sfx");
}

applyshutdownonspawn() {
  self endon("death");
  level endon("game_ended");
  var_00 = self.owner;
  var_01 = var_0.team;

  for(;;) {
    level waittill("player_spawned", var_02);

    if(!scripts\mp\utility\game::playersareenemies(var_00, var_02)) {
      continue;
    }
    if(!var_02 scripts\mp\utility\game::_hasperk("specialty_empimmune"))
      var_02 thread shutdownenemysystem(self);
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

  foreach(var_01 in level.players) {
    if(!scripts\mp\utility\game::isreallyalive(var_01)) {
      continue;
    }
    if(!scripts\mp\utility\game::playersareenemies(self.owner, var_01)) {
      continue;
    }
    if(var_01 scripts\mp\utility\game::_hasperk("specialty_empimmune")) {
      continue;
    }
    var_02 = 1;

    if(var_01 scripts\mp\killstreaks\emp_common::isemped())
      var_02 = 0;

    var_03 = 1;

    if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_01))
      var_03 = 0;
    else if(scripts\mp\utility\game::istrue(var_1.visionpulsevisionsetactive))
      var_03 = 0;

    var_01 thread applyuavshellshock(var_03, var_02);
  }

  func_52C5(scripts\mp\utility\game::getotherteam(self.team), self.owner);
}

applyuavshellshock(var_00, var_01) {
  self endon("disconnect");

  if(var_00) {
    self shellshock("flashbang_mp", 0.5);
    thread applyuavshellshockvisionset();
  }

  if(var_01)
    self setscriptablepartstate("emped", "active", 0);

  self playLoopSound("emp_nade_lp");
  var_02 = gettime() + 500.0;

  while(gettime() <= var_02) {
    if(var_01 && scripts\mp\killstreaks\emp_common::isemped())
      var_01 = 0;

    if(!scripts\mp\utility\game::isreallyalive(self)) {
      break;
    }
    scripts\engine\utility::waitframe();
  }

  if(var_01)
    self setscriptablepartstate("emped", "neutral", 0);

  self stoploopsound("emp_nade_lp");
}

applyuavshellshockvisionset() {
  visionsetnaked("coup_sunblind", 0.05);
  scripts\engine\utility::waitframe();
  visionsetnaked("coup_sunblind", 0);
  visionsetnaked("", 0.5);
}

func_52C5(var_00, var_01) {
  var_02 = "nuke_mp";
  var_03 = level.func_1655;
  var_04 = scripts\mp\perks\perkfunctions::func_7D96();
  var_05 = undefined;

  if(isDefined(var_03) && isDefined(var_04))
    var_05 = scripts\engine\utility::array_combine_unique(var_03, var_04);
  else if(isDefined(var_03))
    var_05 = var_03;
  else if(isDefined(var_04))
    var_05 = var_04;

  if(isDefined(var_05)) {
    foreach(var_07 in var_05) {
      if(isDefined(var_07))
        var_07 scripts\mp\killstreaks\utility::dodamagetokillstreak(10000, var_01, var_01, var_00, var_7.origin, "MOD_EXPLOSIVE", var_02);
    }
  }
}