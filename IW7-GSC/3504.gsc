/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3504.gsc
***************************************/

init() {
  level.func_C1D0 = "aftermath_post";
  level._effect["mons_warp_flash"] = loadfx("vfx\iw7\_requests\mp\vfx_vehicle_nuke_warp_flash.vfx");
  level._effect["mons_warp_in"] = loadfx("vfx\iw7\_requests\mp\vfx_vehicle_nuke_warp_in.vfx");
  level._effect["mons_warp_out"] = loadfx("vfx\iw7\_requests\mp\vfx_vehicle_nuke_warp_out.vfx");
  level._effect["mons_laser_charge"] = loadfx("vfx\iw7\_requests\mp\vfx_nuke_build_lgt_ship_belly.vfx");
  level._effect["mons_laser"] = loadfx("vfx\iw7\_requests\mp\vfx_nuke_laser.vfx");
  level._effect["mons_laser_flash"] = loadfx("vfx\iw7\_requests\mp\vfx_nuke_initial_flash.vfx");
  level._effect["mons_laser_smoke"] = loadfx("vfx\iw7\_requests\mp\vfx_nuke_dust_wave.vfx");
  level._effect["mons_screen_ash"] = loadfx("vfx\iw7\_requests\mp\vfx_nuke_cam_att_ashfall.vfx");
  scripts\mp\killstreaks\killstreaks::registerkillstreak("nuke", ::func_128F0);
  setdvarifuninitialized("scr_nukeTimer", 10);
  setdvarifuninitialized("scr_nukeCancelMode", 0);
  level.func_C1CD = getdvarint("scr_nukeTimer");
  level.func_3883 = getdvarint("scr_nukeCancelMode");
  level.func_C1C5 = spawnStruct();
  level.nukedetonated = undefined;
  level.nukegameover = undefined;
  level.func_C1B2 = undefined;

  if(!scripts\mp\utility\game::istrue(level.func_C1B2))
    level thread onplayerconnect();
}

func_128F0(var_00) {
  if(isDefined(level.nukeincoming)) {
    scripts\mp\hud_message::showerrormessage("KILLSTREAKS_NUKE_ALREADY_INBOUND");
    return 0;
  }

  if(scripts\mp\utility\game::isusingremote() && (!isDefined(level.gtnw) || !level.gtnw))
    return 0;

  thread func_5973(0);
  self notify("used_nuke");
  scripts\mp\matchdata::logkillstreakevent("nuke", self.origin);
  return 1;
}

func_512C(var_00, var_01, var_02) {
  level endon("nuke_cancelled");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_00);
  level thread[[var_01]](var_02);
}

func_5973(var_00) {
  level endon("nuke_cancelled");
  level.func_C1C5.player = self;
  level.func_C1C5.team = self.pers["team"];
  level.nukeincoming = 1;
  level.func_C1B2 = undefined;
  level.func_D8C5 = int(getomnvar("ui_bomb_timer"));
  setomnvar("ui_bomb_timer", 4);
  thread scripts\mp\utility\game::teamplayercardsplash("used_nuke", self);
  var_01 = func_108E6();

  if(!isDefined(var_01)) {
    return;
  }
  var_01 thread func_1395B(self);
  var_01 thread func_1395A();
  var_01 thread func_13959(var_00);
}

func_108E6() {
  var_00 = level.mapcenter;
  var_01 = 0;
  var_02 = (0, var_01, 0);
  var_03 = 24000;
  var_04 = 10000;
  var_05 = 15000;
  var_06 = 5000;
  var_07 = getmonsflightpath(var_00, var_02, var_03, undefined, var_04, var_05, var_06);
  var_08 = var_00 * (1, 1, 0);
  var_09 = var_08 + (0, 0, var_04);
  var_10 = var_7["startPoint"];
  var_11 = vectortoangles(var_09 - var_10);
  var_12 = spawn("script_model", var_10);
  var_12 setModel("veh_mil_air_ca_olympus_mons_mp");
  var_12.angles = var_11;
  var_12.team = self.team;
  var_12.owner = self;
  var_12.func_C96C = var_09;
  var_12 setCanDamage(0);
  var_12 setscriptablepartstate("body", "hide", 0);
  return var_12;
}

getmonsflightpath(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
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

func_1395B(var_00) {
  soundsettimescalefactor("music_lr", 0);
  soundsettimescalefactor("music_lsrs", 0);
  soundsettimescalefactor("weap_plr_fire_1_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_2_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_3_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_4_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_overlap_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_lfe_2d", 0);
  soundsettimescalefactor("weap_plr_fire_alt_1_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_alt_2_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_alt_3_2d", 0.25);
  soundsettimescalefactor("weap_plr_fire_alt_4_2d", 0.25);
  soundsettimescalefactor("scn_fx_unres_3d", 0.15);
  soundsettimescalefactor("scn_fx_unres_2d", 0.15);
  soundsettimescalefactor("spear_refl_close_unres_3d_lim", 0.15);
  soundsettimescalefactor("spear_refl_unres_3d_lim", 0.15);
  soundsettimescalefactor("weap_npc_main_3d", 0.15);
  soundsettimescalefactor("weap_npc_mech_3d", 0.15);
  soundsettimescalefactor("weap_npc_mid_3d", 0.15);
  soundsettimescalefactor("weap_npc_lfe_3d", 0);
  soundsettimescalefactor("weap_npc_dist_3d", 0.15);
  soundsettimescalefactor("weap_npc_lo_3d", 0.15);
  soundsettimescalefactor("melee_npc_3d", 0.15);
  soundsettimescalefactor("melee_plr_2d", 0.15);
  soundsettimescalefactor("special_hi_unres_1_3d", 0.15);
  soundsettimescalefactor("special_lo_unres_1_2d", 0);
  soundsettimescalefactor("bulletflesh_npc_1_unres_3d_lim", 0.15);
  soundsettimescalefactor("bulletflesh_npc_2_unres_3d_lim", 0.15);
  soundsettimescalefactor("bulletflesh_1_unres_3d_lim", 0.15);
  soundsettimescalefactor("bulletflesh_2_unres_3d_lim", 0.15);
  soundsettimescalefactor("foley_plr_mvmt_unres_2d_lim", 0.2);
  soundsettimescalefactor("scn_fx_unres_2d_lim", 0.2);
  soundsettimescalefactor("scn_fx_special_unres_2d", 0);
  soundsettimescalefactor("menu_1_2d_lim", 0);
  soundsettimescalefactor("equip_use_unres_3d", 0.15);
  soundsettimescalefactor("explo_1_3d", 0.15);
  soundsettimescalefactor("explo_2_3d", 0.15);
  soundsettimescalefactor("explo_3_3d", 0.15);
  soundsettimescalefactor("explo_4_3d", 0.15);
  soundsettimescalefactor("explo_5_3d", 0.15);
  soundsettimescalefactor("explo_lfe_3d", 0.15);
  soundsettimescalefactor("vehicle_air_loops_3d_lim", 0.15);
  soundsettimescalefactor("projectile_loop_close", 0.15);
  soundsettimescalefactor("projectile_loop_mid", 0.15);
  soundsettimescalefactor("projectile_loop_dist", 0.15);
  self endon("nuke_ship_exit");
  level endon("game_ended");
  var_00 waittill("disconnect");
  level.func_C1B2 = 1;
  func_C1B5();

  if(level.mapname != "mp_dome_dusk")
    visionsetalternate(-3, 5);

  setslowmotion(1, 1, 0);
  level notify("nuke_cancelled");
  self notify("nuke_ship_exit");
}

func_13959(var_00) {
  self endon("nuke_ship_exit");
  level endon("game_ended");
  thread func_1395C();
  wait 2;
  self moveto(self.func_C96C, 5, 0.2, 2);
  thread func_665A();
  self waittill("near_goal");
  thread func_10DD1();
  level thread func_512C(level.func_C1CD - 7.0, ::func_C1B1, self);
  level thread func_512C(level.func_C1CD - 3.3, ::func_C1CC, self);
  level thread func_512C(level.func_C1CD, ::func_C1CB, self);
  level thread func_512C(level.func_C1CD, ::func_C1CA, self);
  level thread func_512C(level.func_C1CD, ::func_C1BE, self);
  level thread func_512C(level.func_C1CD, ::func_C1BC, self);
  level thread func_512C(level.func_C1CD + 0.25, ::func_C1CE, self);
  level thread func_512C(level.func_C1CD + 1.5, ::func_C1B8, self);
  self waittill("at_goal");
  self scriptmodelplayanimdeltamotion("veh_mil_air_ca_mons_mp_doors_open", 1);

  if(!isDefined(level.func_C1AE)) {
    level.func_C1AE = spawn("script_origin", (0, 0, 1));
    level.func_C1AE hide();
  }

  scripts\mp\rank::addteamrankxpmultiplier(2, level.func_C1C5.team, "nuke");

  if(level.func_3883 && var_00)
    level thread func_3884(level.func_C1C5.player);
}

func_10DD1() {
  level endon("nuke_cancelled");
  setomnvar("ui_nuke_countdown_active", 1);

  if(level.mapname != "mp_dome_dusk")
    visionsetalternate(-1, 10);

  level thread func_12E43();

  if(!isDefined(level.func_C1A7)) {
    level.func_C1A7 = spawn("script_origin", (0, 0, 0));
    level.func_C1A7 hide();
  }

  for(var_00 = level.func_C1CD; var_00 > 0; var_0--) {
    if(var_00 == 1)
      level.func_C1A7 playSound("mp_killstreak_nuclearstrike_alarm_last");
    else
      level.func_C1A7 playSound("mp_killstreak_nuclearstrike_alarm");

    wait 1.0;
  }

  wait 5;
  self notify("nuke_ship_exit");
}

func_665A() {
  self endon("nuke_ship_exit");
  playFX(scripts\engine\utility::getfx("mons_warp_in"), self.func_C96C);
  playLoopSound(self.func_C96C, "ks_nuke_mons_arrive");
  wait 0.545;
  scripts\mp\shellshock::_earthquake(0.8, 0.5, level.mapcenter, 100000);
  playFX(scripts\engine\utility::getfx("mons_warp_flash"), self.func_C96C);
  self setscriptablepartstate("body", "show", 0);
  wait 0.5;
  self setscriptablepartstate("thrusters_burst", "active", 0);
  self playSound("ks_nuke_mons_start");
  wait 4;
  self setscriptablepartstate("thrusters", "active", 0);
  wait 1;
  self setscriptablepartstate("thrusters_burst", "neutral", 0);
}

func_1395C() {
  self endon("nuke_ship_exit");

  for(;;) {
    var_00 = distance(self.origin, self.func_C96C);

    if(var_00 <= 5000 && !isDefined(self.func_BE83)) {
      self notify("near_goal");
      self.func_BE83 = 1;
    }

    if(var_00 == 0) {
      self notify("at_goal");
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

func_1395A() {
  self waittill("nuke_ship_exit");
  playFX(scripts\engine\utility::getfx("mons_warp_out"), self.origin);
  playLoopSound(self.origin, "ks_nuke_mons_ftl_buildup");
  wait 3;
  scripts\mp\shellshock::_earthquake(0.8, 0.5, level.mapcenter, 100000);
  playLoopSound(self.origin, "ks_nuke_mons_ftl_out");
  playFX(scripts\engine\utility::getfx("mons_warp_flash"), self.origin);
  self delete();
  level.nukeincoming = undefined;
}

getpathend() {
  var_00 = 150;
  var_01 = 100000;
  var_02 = self.angles[1];
  var_03 = (0, var_02, 0);
  var_04 = self.origin + anglesToForward(var_03) * var_01;
  return var_04;
}

func_3884(var_00) {
  level waittill("game_ended");
  var_00 scripts\engine\utility::waittill_any("death", "disconnect");
  func_C1B5();
  level.nukeincoming = undefined;
  level notify("nuke_cancelled");
}

func_C1B1(var_00) {
  var_00 endon("nuke_ship_exit");
  level endon("nuke_cancelled");
  playFX(scripts\engine\utility::getfx("mons_laser_charge"), var_0.origin);
  var_00 playSound("ks_nuke_mons_prepare");
  var_01 = 15;
  scripts\mp\shellshock::_earthquake(0.1, var_01, level.mapcenter, 100000);
}

func_C1CC(var_00) {
  var_00 endon("nuke_ship_exit");
  level endon("nuke_cancelled");
}

func_C1CB(var_00) {
  var_00 endon("nuke_ship_exit");
  level endon("nuke_cancelled");

  if(isDefined(level.func_C1AE))
    return;
}

func_C1B5(var_00) {
  var_01 = 0;

  if(isDefined(level.func_D8C5))
    var_01 = level.func_D8C5;

  setomnvar("ui_bomb_timer", var_01);
  setomnvar("ui_nuke_countdown_active", 0);
}

func_C1BE(var_00) {
  var_00 endon("nuke_ship_exit");
  level endon("nuke_cancelled");
  func_C1B5();
  level.nukedetonated = 1;
  var_00 playSound("ks_nuke_mons_laser");
  playFX(scripts\engine\utility::getfx("mons_laser_flash"), var_0.origin - (0, 0, 500));
  playFX(scripts\engine\utility::getfx("mons_laser_smoke"), level.mapcenter);
}

func_C1CA(var_00) {
  var_00 endon("nuke_ship_exit");
  level endon("nuke_cancelled");
  setslowmotion(1.0, 0.25, 0.5);
  level waittill("nuke_death");
  setslowmotion(0.25, 1, 3.0);
}

func_C1CE(var_00) {
  var_00 endon("nuke_ship_exit");
  level endon("nuke_cancelled");
  level.func_C1CF = 1;

  if(level.mapname != "mp_dome_dusk")
    visionsetalternate(-2, 1.5);

  setdvar("r_materialBloomHQScriptMasterEnable", 0);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.5);
  level notify("nuke_aftermath_post_started");
  level waittill("nuke_death");
  var_00 scriptmodelplayanimdeltamotion("veh_mil_air_ca_mons_mp_doors_close", 1);
  level thread func_12EDA();

  foreach(var_02 in level.players) {
    if(scripts\mp\utility\game::isreallyalive(var_02))
      playfxontagforclients(scripts\engine\utility::getfx("mons_screen_ash"), var_02, "tag_eye", var_02);
  }

  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(3.1);

  if(level.mapname != "mp_dome_dusk")
    visionsetalternate(-3, 1);
}

func_C1B8(var_00) {
  var_00 endon("nuke_ship_exit");
  level endon("nuke_cancelled");
  level endon("game_ended");
  level notify("nuke_death");
  scripts\mp\hostmigration::waittillhostmigrationdone();
  var_01 = 0;

  if(level.gametype == "war" || level.gametype == "dm")
    var_01 = 1;

  if(isDefined(level.func_C1C5.player)) {
    foreach(var_03 in level.characters) {
      if(func_C1B3(var_03, var_01)) {
        if(isplayer(var_03)) {
          var_3.nuked = 1;

          if(scripts\mp\utility\game::isreallyalive(var_03)) {
            scripts\mp\damage::addattacker(var_03, level.func_C1C5.player, undefined, "nuke_mp", 0, undefined, undefined, undefined, undefined, undefined);
            var_03 thread scripts\mp\damage::finishplayerdamagewrapper(level.func_C1C5.player, level.func_C1C5.player, 999999, 0, "MOD_EXPLOSIVE", "nuke_mp", var_3.origin, (0, 0, 1), "none", 0, 0, undefined, undefined);
          }
        }
      }
    }

    if(scripts\mp\utility\game::istrue(var_01))
      func_52C5();
    else
      func_52C5(scripts\mp\utility\game::getotherteam(var_0.team));

    scripts\mp\utility\game::printgameaction("killstreak ended - nuke", level.func_C1C5.player);

    if(scripts\mp\utility\game::istrue(var_01)) {
      level.nukegameover = 1;
      var_05 = level.func_C1C5.player;

      if(level.teambased)
        var_05 = level.func_C1C5.player.team;

      thread scripts\mp\gamelogic::endgame(var_05, game["end_reason"]["nuke_end"], 1);
    }
  }

  level.nukeincoming = undefined;
}

func_C1B3(var_00, var_01) {
  if(!isDefined(level.func_C1C5))
    return 0;

  if(scripts\mp\utility\game::istrue(var_01))
    return 1;

  if(level.teambased) {
    if(isDefined(level.func_C1C5.team) && var_0.team == level.func_C1C5.team)
      return 0;
  } else {
    var_02 = isDefined(level.func_C1C5.player) && var_00 == level.func_C1C5.player;
    var_03 = isDefined(level.func_C1C5.player) && isDefined(var_0.owner) && var_0.owner == level.func_C1C5.player;

    if(var_02 || var_03)
      return 0;
  }

  return 1;
}

func_C1BC(var_00) {
  level endon("nuke_cancelled");
  scripts\mp\shellshock::_earthquake(0.2, 1.5, level.mapcenter, 100000);
  level waittill("nuke_death");
  scripts\mp\shellshock::_earthquake(0.4, 0.1, level.mapcenter, 100000);

  foreach(var_02 in level.players)
  var_02 playrumbleonentity("damage_heavy");
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread onplayerspawned();
  }
}

onplayerspawned() {
  self endon("disconnect");
  level endon("nuke_cancelled");

  for(;;) {
    self waittill("spawned_player");

    if(isDefined(level.nukedetonated))
      thread func_FB0F(0.1);
  }
}

func_FB0F(var_00) {
  wait(var_00);

  if(level.mapname != "mp_dome_dusk")
    self _meth_83FD(-3, 0);

  playfxontagforclients(scripts\engine\utility::getfx("mons_screen_ash"), self, "tag_eye", self);
}

func_12E43() {
  level endon("game_ended");
  level endon("disconnect");
  level endon("nuke_cancelled");
  level endon("nuke_death");
  var_00 = level.func_C1CD * 1000 + gettime();
  setomnvar("ui_nuke_end_milliseconds", var_00);
  level waittill("host_migration_begin");
  var_01 = scripts\mp\hostmigration::waittillhostmigrationdone();

  if(var_01 > 0)
    setomnvar("ui_nuke_end_milliseconds", var_00 + var_01);
}

func_12EDA() {
  level endon("game_ended");

  for(;;) {
    level waittill("host_migration_end");
    level func_F7BC(0);
  }
}

func_F7BC(var_00) {
  if(isDefined(level.func_C1BA))
    level thread[[level.func_C1BA]]();
  else if(level.mapname != "mp_dome_dusk")
    visionsetalternate(-3, var_00);
}

func_52C5(var_00) {
  var_01 = "nuke_mp";
  var_02 = level.func_1655;
  var_03 = scripts\mp\perks\perkfunctions::func_7D96();
  var_04 = undefined;

  if(isDefined(var_02) && isDefined(var_03))
    var_04 = scripts\engine\utility::array_combine_unique(var_02, var_03);
  else if(isDefined(var_02))
    var_04 = var_02;
  else if(isDefined(var_03))
    var_04 = var_03;

  if(isDefined(var_04)) {
    foreach(var_06 in var_04) {
      if(isDefined(var_06))
        var_06 scripts\mp\killstreaks\utility::dodamagetokillstreak(10000, level.func_C1C5.player, level.func_C1C5.player, var_00, var_6.origin, "MOD_EXPLOSIVE", var_01);
    }
  }
}