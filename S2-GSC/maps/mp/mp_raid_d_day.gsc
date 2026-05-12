/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_raid_d_day.gsc
*********************************************/

func_00F9() {
  lib_04B9::func_F9();
  lib_0420::func_F9();
  lib_04B8::func_F9();
  maps\mp\_audio_submixes::func_524C();
  maps\mp\_load::func_F9();
  maps\mp\mp_raid_d_day_lighting::func_F9();
  maps\mp\mp_raid_d_day_aud::func_F9();
  maps\mp\_water::func_D5();
  maps\mp\_compass::func_8A2F("compass_map_mp_raid_d_day");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level.var_6C5F = "mp_raid_d_day_osp";
  level.var_6C5E = "mp_raid_d_day_osp";
  level.var_3445 = "mp_raid_d_day_drone";
  level.var_343A = "mp_raid_d_day_drone";
  level.var_A853 = "mp_raid_d_day_warbird";
  level.var_A852 = "mp_raid_d_day_warbird";
  level.var_75EE = 7;
  level.botsdestructionobjectivedefenseradius = 800;
  level.var_A16 = 0;
  level.var_A4B5["intensity"] = 0.2;
  level.var_A4B5["falloff"] = 1.2;
  level.var_A4B5["scaleX"] = 1;
  level.var_A4B5["scaleY"] = 1;
  level.var_A4B5["squareAspectRatio"] = 0;
  level.var_A4B5["lerpDuration"] = 0.1;
  level.var_A4BE["intensity"] = 0.5;
  level.var_A4BE["falloff"] = 1.2;
  level.var_A4BE["scaleX"] = 1;
  level.var_A4BE["scaleY"] = 1;
  level.var_A4BE["squareAspectRatio"] = 0;
  level.var_A4BE["lerpDuration"] = 0.4;
  level.var_6465["velocityscaler"] = 0.35;
  level.var_6465["cameraRotationInfluence"] = 0;
  level.var_6465["cameraTranslationInfluence"] = 0;
  maps\mp\_special_weapons::func_D5();
  level.var_BC2 = [];
  level.var_6071 = 20;
  lib_04FA::func_52FD(3);
  level.var_7919 = ::maps\mp\mp_raid_d_day_vo::func_A617;
  level.var_696E = ["capture_bunkers", "bunker_hp_a", "bunker_hp_b", "comm_equipment", "destroy_guns", "gun_01", "gun_02", "end"];
  level.var_696F = ["capture_bunkers", "comm_equipment", "destroy_guns", "end"];
  var_00 = lib_0501::func_4647("capture2x_time");
  var_01 = lib_0501::func_4647("bomb_timer");
  var_02 = lib_0501::func_4647("bomb_defuseTime");
  lib_04FF::func_86DA("bunker_hp_a", "captureTimeSec", var_00);
  lib_04FF::func_86DA("bunker_hp_b", "captureTimeSec", var_00);
  lib_04FF::func_86DA("gun_01", "fuseTime", var_01);
  lib_04FF::func_86DA("gun_02", "fuseTime", var_01);
  lib_04FF::func_86DA("gun_01", "defuseTime", var_02);
  lib_04FF::func_86DA("gun_02", "defuseTime", var_02);
  lib_04FF::func_86DA("gun_01", "onMultiBombExplodeFunc", ::ongunexplode);
  lib_04FF::func_86DA("gun_02", "onMultiBombExplodeFunc", ::ongunexplode);
  lib_04FF::func_86DA("comm_equipment", "grenadeDamageMult", 0.4);
  maps\mp\_utility::func_3FA3("started_vignettes", 1);
  maps\mp\_utility::func_3FA3("finished_intro_vignette_allies", 0);
  maps\mp\_utility::func_3FA3("finished_intro_vignette_axis", 0);
  thread initvignettemgs();
  thread maps\mp\mp_raid_d_day_vo::func_5366();
  thread func_7F89();
  thread func_7FC0();
  thread func_7FCF();
  thread func_7F86();
  thread setupartilleryguns();
  thread func_7F94();
  thread func_A90A();
  thread maps\mp\mp_raid_d_day_vo::func_7FDF();
  thread func_7FCC();
  thread patchupdatebarbedwireexplosivemodel();
  level.var_611["mortar_explosion_lrg"] = loadfx("vfx/explosion/mortar_explosion_lrg_sand_01");
  level.var_611["blood_impact"] = loadfx("vfx/blood/blood_impact_burst_non_attached");
  level.var_611["cannon_flash"] = loadfx("vfx/map/mp_raid_d_day/r_dday_cannon_muzzleflash");
  level thread runbeachladdersetup();
  level.botgetmaxturretdistscalar = ::botgetmaxturretdistscalar;
  level.botgetincreasedturretchance = ::botgetincreasedturretchance;
  func_54D6();
  func_54DE();
  func_6C8C();
  func_6C93();
  thread watchplayerconnect();
}

watchplayerconnect() {
  level endon("game_ended");
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread toggleocean();
  }
}

toggleocean() {
  var_00 = getEntArray("ocean", "targetname");
  var_01 = getent("ocean_disable", "targetname");
  var_02 = getent("ocean_enable", "targetname");
  level endon("game_ended");
  self endon("disconnect");
  common_scripts\utility::func_F71(var_00, ::showtoclient, self);
  self.hideddayocean = 0;
  var_03 = randomfloatrange(1, 3);
  wait(var_03);
  for(;;) {
    wait(3);
    if(self istouching(var_01)) {
      if(!self.hideddayocean) {
        common_scripts\utility::func_F71(var_00, ::hidefromclient, self);
        self.hideddayocean = 1;
      }

      continue;
    }

    if(self.hideddayocean) {
      common_scripts\utility::func_F71(var_00, ::showtoclient, self);
      self.hideddayocean = 0;
    }
  }
}

enableocean() {
  var_00 = getEntArray("ocean", "targetname");
  common_scripts\utility::func_F71(var_00, ::method_805B);
}

func_54D6() {
  lib_0505::func_5310();
  var_00 = ["mp_raids_normandy_allies_start_player01", "mp_raids_normandy_allies_start_player02", "mp_raids_normandy_allies_start_player03", "mp_raids_normandy_allies_start_player04", "mp_raids_normandy_allies_start_player05", "mp_raids_normandy_allies_start_player06"];
  var_01 = ["mp_raids_normandy_allies_start_cam01", "mp_raids_normandy_allies_start_cam02", "mp_raids_normandy_allies_start_cam03", "mp_raids_normandy_allies_start_cam05", "mp_raids_normandy_allies_start_cam06", "mp_raids_normandy_allies_start_cam07"];
  var_02 = [::func_0BF8, ::func_0BF9, ::func_0BFA, ::func_0BFC, ::func_0BFD, ::func_0BFE];
  level.var_54D0["allies"].var_8F2 = "attackers";
  level.var_54D0["allies"].var_8F53 = common_scripts\utility::func_46B5("anim_allies_start", "targetname");
  level.var_54D0["allies"].var_73B4 = var_00;
  level.var_54D0["allies"].var_8097 = 25;
  level.var_54D0["allies"].var_1F03 = var_01;
  level.var_54D0["allies"].var_1F05 = var_02;
  level.var_54D0["allies"].var_92D5 = ::func_54D7;
  level.var_54D0["allies"].var_765B = ::introvignette_allies_precleanup;
  level.var_54D0["allies"].var_2381 = ::func_54D3;
  level.var_54D0["allies"].var_73E6 = ::func_54D4;
  level.var_54D0["allies"].var_13B7 = ::func_54D2;
  level.var_54D0["allies"].var_6F27 = 1;
  level.var_54D0["allies"].setthreatdetectedfunc = ::introvignette_allies_setthreatdetectedfunc;
}

func_54D7() {
  level endon("kill_allies_intro");
  lib_0378::func_8D74("aud_intro_start_sfx");
  thread animate_background_boats();
  if(isDefined(level.var_543B)) {
    common_scripts\utility::func_F71(level.var_543B, ::delete);
  }

  if(isDefined(level.bucket01)) {
    level.bucket01 delete();
  }

  if(isDefined(level.bucket02)) {
    level.bucket02 delete();
  }

  var_00 = level.var_54D0["allies"].var_116;
  var_01 = level.var_54D0["allies"].var_1D;
  var_02 = level.var_54D0["allies"].var_8097;
  var_03 = lib_0502::func_4627(game["attackers"]);
  var_04 = getent("allies_intro_blocker", "targetname");
  if(isDefined(var_04)) {
    var_04 method_805C();
  }

  var_05 = [];
  var_06 = ["mp_raids_normandy_allies_start_boat01", "mp_raids_normandy_allies_start_boat02", "mp_raids_normandy_allies_start_boat03", "mp_raids_normandy_allies_start_boat04"];
  var_07 = [0, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3];
  var_08 = undefined;
  foreach(var_0C, var_0A in var_06) {
    var_0B = spawn("script_model", var_00);
    var_0B setModel("vehicle_usa_boat_higgins_mp");
    var_0B method_8495(var_0A, var_00, var_01, "boat0" + var_0C);
    if(var_0C == 0) {
      var_0B thread lib_04B8::func_4D35("boat0" + var_0C);
    } else {
      var_0B thread lib_04B8::higgins_intro_splashes_cheap(var_07[var_0C], "boat0" + var_0C);
    }

    if(var_0C == 1) {
      var_08 = var_0B;
    }

    var_05[var_05.size] = var_0B;
  }

  var_0D = spawn("script_model", var_00);
  var_0D setModel("usa_fighter_thunderbolt");
  var_0D method_8495("mp_raids_normandy_allies_start_plane01", var_00, var_01);
  var_0E = spawn("script_model", var_00);
  var_0E setModel("usa_fighter_thunderbolt");
  var_0E method_8495("mp_raids_normandy_allies_start_plane02", var_00, var_01);
  var_0F = [1, 51, 1, 1, 1, 0];
  var_10 = [3, 52, 3, 3, 3, 0];
  var_11 = [9, 53, 9, 9, 9, 9];
  var_12 = [13, 54, 13, 13, 13, 0];
  var_13 = [16, 57, 16, 16, 16, 16];
  var_14 = [1, 51, 1, 1, 1, 0];
  var_15 = [3, 52, 3, 3, 3, 0];
  var_16 = [9, 53, 9, 9, 9, 9];
  var_17 = [13, 54, 13, 13, 13, 0];
  var_18 = [16, 57, 16, 16, 16, 16];
  var_19 = [1, 51, 1, 1, 1, 0];
  var_1A = spawn("script_model", var_00);
  var_1A.var_267E = var_0F;
  var_1A setcostumemodels(var_1A.var_267E, "allies");
  var_1A method_8495("mp_raids_normandy_allies_start_driver", var_00, var_01, "driver");
  var_1A thread lib_04B8::boat_driver_fx("driver");
  var_1A method_805C();
  foreach(var_1C in var_03) {
    var_1A showtoclient(var_1C);
  }

  var_1E = [];
  var_1F = 0;
  foreach(var_0C, var_0B in var_05) {
    if(var_0C == 0) {} else {
      if(var_0B == var_08) {
        var_1F = var_1E.size;
      }

      var_1E[var_1E.size] = spawn_npc_on_boat_tag_and_play_anim(var_05[var_0C], "tag_driver", "mp_raids_higgins_boat_idle_underfire_driver", var_1A.var_267E);
      var_1E[var_1E.size] = spawn_npc_on_boat_tag_and_play_anim(var_05[var_0C], "tag_guy35", "mp_raids_higgins_boat_idle_underfire_npc01", var_10);
      var_1E[var_1E.size] = spawn_npc_on_boat_tag_and_play_anim(var_05[var_0C], "tag_guy21", "mp_raids_higgins_boat_idle_underfire_npc02", var_11);
      var_1E[var_1E.size] = spawn_npc_on_boat_tag_and_play_anim(var_05[var_0C], "tag_guy20", "mp_raids_higgins_boat_idle_underfire_npc03", var_12);
      var_1E[var_1E.size] = spawn_npc_on_boat_tag_and_play_anim(var_05[var_0C], "tag_guy15", "mp_raids_higgins_boat_idle_underfire_npc04", var_13);
      var_1E[var_1E.size] = spawn_npc_on_boat_tag_and_play_anim(var_05[var_0C], "tag_guy14", "mp_raids_higgins_boat_idle_underfire_npc05", var_14);
      var_1E[var_1E.size] = spawn_npc_on_boat_tag_and_play_anim(var_05[var_0C], "tag_guy6", "mp_raids_higgins_boat_idle_underfire_npc06", var_15);
      var_1E[var_1E.size] = spawn_npc_on_boat_tag_and_play_anim(var_05[var_0C], "tag_guy5", "mp_raids_higgins_boat_idle_underfire_npc07", var_16);
      var_1E[var_1E.size] = spawn_npc_on_boat_tag_and_play_anim(var_05[var_0C], "tag_guy33", "mp_raids_higgins_boat_idle_underfire_npc08", var_17);
      var_1E[var_1E.size] = spawn_npc_on_boat_tag_and_play_anim(var_05[var_0C], "tag_guy10", "mp_raids_higgins_boat_idle_underfire_npc09", var_18);
      var_1E[var_1E.size] = spawn_npc_on_boat_tag_and_play_anim(var_05[var_0C], "tag_guy16", "mp_raids_higgins_boat_idle_underfire_npc10", var_19);
      if(var_0B == var_08) {}
    }
  }

  foreach(var_22 in var_1E) {
    var_22 method_805C();
    foreach(var_1C in var_03) {
      var_22 showtoclient(var_1C);
    }
  }

  level.var_C6F = spawnStruct();
  level.var_C6F.var_543A = var_04;
  level.var_C6F.boats = var_05;
  level.var_C6F.boat_npc = var_1E;
  level.var_C6F.var_33F3 = var_1A;
  level.var_C6F.var_702B = var_0D;
  level.var_C6F.var_702C = var_0E;
}

animate_background_boats() {
  var_00 = getEntArray("higgins_boats_background", "targetname");
  var_01 = ["sea_usa_higgins_casual01_idle_boat", "sea_usa_higgins_casual01_idle_boat1", "sea_usa_higgins_casual01_idle_boat2", "sea_usa_higgins_casual01_idle_boat3"];
  foreach(var_03 in var_00) {
    var_04 = randomint(var_01.size);
    var_03 method_8495(var_01[var_04], var_03.var_116, var_03.var_1D);
    wait(randomfloatrange(0.25, 0.75));
  }
}

npc_allies_intro_fx(param_00) {
  playFXOnTag(common_scripts\utility::func_44F5("r_dday_intro_water_grit"), self, "tag_origin");
  self waittill(param_00, var_01);
  if(common_scripts\utility::func_9467(var_01, "start_wake")) {
    playFXOnTag(common_scripts\utility::func_44F5("r_dday_body_wake_cinematic"), self, "tag_origin");
  }
}

spawn_npc_on_boat_tag_and_play_anim(param_00, param_01, param_02, param_03) {
  var_04 = spawn("script_model", param_00.var_116);
  var_04.var_267E = param_03;
  var_04 setcostumemodels(param_03, "allies");
  var_04 method_8495(param_02, param_00.var_116, param_00.var_1D, param_01);
  var_04 method_8449(param_00, param_01, (0, 0, 0), (0, 0, 0));
  if(param_01 != "tag_driver") {
    playFXOnTag(common_scripts\utility::func_44F5("r_dday_intro_water_grit"), var_04, "tag_origin");
  }

  return var_04;
}

func_0C03(param_00) {
  level endon("truck_finished");
  self endon("death");
  for(;;) {
    var_01 = self gettagorigin(param_00);
    playFX(common_scripts\utility::func_44F5("tank_tread_dust"), var_01);
    wait(0.4);
  }
}

func_0C01(param_00) {
  level endon("game_ended");
  self endon("death");
  for(;;) {
    var_01 = self gettagorigin(param_00);
    playFX(common_scripts\utility::func_44F5("tank_tread_dust"), var_01);
    wait(0.2);
  }
}

func_54D4(param_00) {
  lib_0378::func_8D74("aud_intro_allies_mixing");
  playFXOnTag(common_scripts\utility::func_44F5("r_dday_intro_water_grit"), self, "tag_origin");
}

func_54D2(param_00, param_01) {
  self endon("death");
  var_02 = 1;
  var_03 = 1;
  var_04 = 1;
  setdvarifuninitialized("scr_introquake_dist", 100);
  setdvarifuninitialized("scr_introquake_scale", 0.25);
  setdvarifuninitialized("scr_introquake_duration", 0.4);
  playFXOnTag(common_scripts\utility::func_44F5("r_dday_intro_water_grit"), self, "tag_origin");
  self waittill(param_01, var_05);
  if(common_scripts\utility::func_9467(var_05, "start_wake")) {
    playFXOnTag(common_scripts\utility::func_44F5("r_dday_body_wake_cinematic"), self, "tag_origin");
  }
}

introvignette_allies_setthreatdetectedfunc() {
  self method_86B8(1);
}

func_0BF8(param_00) {
  var_01 = lib_0502::func_4627(game["attackers"]);
  foreach(var_03 in var_01) {
    var_03 method_808C();
  }

  var_05 = [];
  var_05 = lib_0505::func_3187(var_05, 1, 200, 2, 4, 0);
  thread lib_0505::func_3188(param_00, var_05);
  var_06 = % mp_raids_normandy_allies_start_cam01;
  thread lib_0505::fovnotetracksaddtolistall(var_06, param_00);
}

func_0BF9(param_00) {
  var_01 = lib_0502::func_4627(game["attackers"]);
  foreach(var_03 in var_01) {
    var_03 method_808C();
  }

  var_05 = [];
  var_05 = lib_0505::func_3187(var_05, 1.5, 300, 2, 4, 0);
  thread lib_0505::func_3188(param_00, var_05);
  var_06 = % mp_raids_normandy_allies_start_cam02;
  thread lib_0505::fovnotetracksaddtolistall(var_06, param_00);
}

func_0BFA(param_00) {
  var_01 = lib_0502::func_4627(game["attackers"]);
  foreach(var_03 in var_01) {
    var_03 method_808C();
  }

  var_05 = [];
  var_05 = lib_0505::func_3187(var_05, 2, 1000, 2, 4, 0);
  var_05 = lib_0505::func_3187(var_05, 2, 700, 2, 4, 2);
  thread lib_0505::func_3188(param_00, var_05);
  var_06 = % mp_raids_normandy_allies_start_cam03;
  thread lib_0505::fovnotetracksaddtolistall(var_06, param_00);
}

func_0BFB(param_00) {
  var_01 = lib_0502::func_4627(game["attackers"]);
  foreach(var_03 in var_01) {
    var_03 method_808C();
  }

  var_05 = [];
  var_05 = lib_0505::func_3187(var_05, 1.5, 200, 2, 4, 0);
  var_05 = lib_0505::func_3187(var_05, 1.5, 105, 2, 4, 1.5);
  thread lib_0505::func_3188(param_00, var_05);
  var_06 = % mp_raids_normandy_allies_start_cam04;
  thread lib_0505::fovnotetracksaddtolistall(var_06, param_00);
}

func_0BFC(param_00) {
  var_01 = lib_0502::func_4627(game["attackers"]);
  foreach(var_03 in var_01) {
    var_03 method_808C();
  }

  var_05 = [];
  var_05 = lib_0505::func_3187(var_05, 1.75, 120, 10, 4, 0);
  var_05 = lib_0505::func_3187(var_05, 1.75, 70, 10, 4, 3);
  thread lib_0505::func_3188(param_00, var_05);
  var_06 = % mp_raids_normandy_allies_start_cam05;
  thread lib_0505::fovnotetracksaddtolistall(var_06, param_00);
}

func_0BFD(param_00) {
  var_01 = lib_0502::func_4627(game["attackers"]);
  foreach(var_03 in var_01) {
    var_03 method_808C();
  }

  var_05 = [];
  var_05 = lib_0505::func_3187(var_05, 1.5, 100, 10, 4, 0);
  var_05 = lib_0505::func_3187(var_05, 1.5, 300, 10, 4, 1.5);
  thread lib_0505::func_3188(param_00, var_05);
  var_06 = % mp_raids_normandy_allies_start_cam06;
  thread lib_0505::fovnotetracksaddtolistall(var_06, param_00);
}

func_0BFE(param_00) {
  var_01 = lib_0502::func_4627(game["attackers"]);
  foreach(var_03 in var_01) {
    var_03 method_808C();
  }

  var_05 = % mp_raids_normandy_allies_start_cam07;
  thread lib_0505::fovnotetracksaddtolistall(var_05, param_00);
  var_06 = lib_0505::getmaxintroavatars();
  for(var_07 = 0; var_07 < var_06; var_07++) {
    var_08 = level.var_54D0[param_00].var_8CA7[var_07].var_13AF;
    if(isDefined(var_08) && !var_08) {
      var_09 = level.var_54D0[param_00].var_8CA7[var_07].var_13B3;
      if(isDefined(var_09)) {
        var_09 method_86B8(0);
      }
    }
  }
}

introvignette_allies_precleanup() {}

func_54D3() {
  if(isDefined(level.var_C6F)) {
    if(isDefined(level.var_C6F.var_543A)) {
      level.var_C6F.var_543A delete();
    }

    level.var_C6F.var_702B delete();
    level.var_C6F.var_702C delete();
    level.var_C6F.var_33F3 delete();
    common_scripts\utility::func_F71(level.var_C6F.boat_npc, ::delete);
    level.var_543B = level.var_C6F.boats;
    foreach(var_02, var_01 in level.var_543B) {
      var_01 setModel("vehicle_usa_boat_higgins_mp_outro");
      if(var_02 == 0) {
        var_01 method_8495("ndy_intro_higgins_exit01_idle_boat_v2", var_01.var_116, var_01.var_1D);
        level.bucket01 = spawn("script_model", var_01.var_116);
        level.bucket02 = spawn("script_model", var_01.var_116);
        level.bucket01 setModel("npc_usa_m1919_higgins_bucket_turret");
        level.bucket02 setModel("npc_usa_m1919_higgins_bucket_turret");
        level.bucket01 linkto(var_01, "TAG_TURRET_R", (0, 2, -8), (0, 0, 0));
        level.bucket02 linkto(var_01, "TAG_TURRET_L", (0, -2, -8), (0, 0, 0));
        continue;
      }

      var_01 method_8495("sea_usa_higgins_underfire01_idle_boat", var_01.var_116, var_01.var_1D);
    }

    level.var_C6F = undefined;
  }

  lib_0505::deletefakenameplates();
  level notify("kill_allies_intro");
}

func_54DE() {
  lib_0505::func_5310();
  var_00 = ["mp_raids_normandy_axis_start_player_01", "mp_raids_normandy_axis_start_player_02", "mp_raids_normandy_axis_start_player_03", "mp_raids_normandy_axis_start_player_04", "mp_raids_normandy_axis_start_player_05", "mp_raids_normandy_axis_start_player_06"];
  var_01 = ["mp_raids_normandy_axis_start_camera_01", "mp_raids_normandy_axis_start_camera_02", "mp_raids_normandy_axis_start_camera_03", "mp_raids_normandy_axis_start_camera_04", "mp_raids_normandy_axis_start_camera_05", "mp_raids_normandy_axis_start_camera_06"];
  var_02 = [::func_147F, ::func_1480, ::func_1481, ::func_1482, ::func_1483];
  level.var_54D0["axis"].var_8F2 = "defenders";
  level.var_54D0["axis"].var_8F53 = common_scripts\utility::func_46B5("anim_axis_start", "targetname");
  level.var_54D0["axis"].var_73B4 = var_00;
  level.var_54D0["axis"].var_8097 = 14;
  level.var_54D0["axis"].var_1F03 = var_01;
  level.var_54D0["axis"].var_1F05 = var_02;
  level.var_54D0["axis"].var_92D5 = ::func_54E1;
  level.var_54D0["axis"].var_765B = ::introvignette_axis_precleanup;
  level.var_54D0["axis"].var_2381 = ::func_54D9;
  level.var_54D0["axis"].var_73E6 = ::func_54DC;
  level.var_54D0["axis"].var_13B7 = ::func_54D8;
}

func_54E1() {
  level endon("kill_axis_intro");
  var_00 = level.var_54D0["axis"].var_8F53.var_116;
  var_01 = (0, 0, 0);
  if(isDefined(level.var_54D0["axis"].var_8F53.var_1D)) {
    var_01 = level.var_54D0["axis"].var_8F53.var_1D;
  }

  var_02 = lib_0502::func_4627(game["defenders"]);
  var_03 = [];
  var_04 = spawn("script_model", var_00);
  var_04 setcostumemodels([2, 1, 2, 2, 2, 0], "axis");
  var_04 method_8495("mp_raids_normandy_axis_start_npc_shot_01", var_00, var_01);
  var_05 = spawn("weapon_mp40_mp", (0, 0, 0), 1);
  var_05 linkto(var_04, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
  var_03[var_03.size] = var_05;
  level.shot_soldier = [];
  level.shot_soldier["soldier"] = var_04;
  level.shot_soldier["weapon"] = var_05;
  var_06 = [];
  var_07 = ["mp_raids_normandy_axis_start_player_01", "mp_raids_normandy_axis_start_player_02", "mp_raids_normandy_axis_start_player_03", "mp_raids_normandy_axis_start_player_04", "mp_raids_normandy_axis_start_player_05", "mp_raids_normandy_axis_start_player_06"];
  level waittill("next_anim1");
  for(var_08 = 0; var_08 < 6; var_08++) {
    var_09 = level.var_54D0["axis"].var_8CA7[var_08].var_13B3;
    if(isDefined(var_09)) {
      var_09 method_8495(var_07[var_08] + "_shot02", var_00, var_01);
    }
  }

  level waittill("next_anim2");
  for(var_08 = 0; var_08 < 6; var_08++) {
    var_09 = level.var_54D0["axis"].var_8CA7[var_08].var_13B3;
    if(isDefined(var_09)) {
      var_09 method_8495(var_07[var_08] + "_shot03", var_00, var_01);
    }
  }

  level waittill("next_anim3");
  for(var_08 = 0; var_08 < 6; var_08++) {
    var_09 = level.var_54D0["axis"].var_8CA7[var_08].var_13B3;
    if(isDefined(var_09)) {
      var_09 method_8495(var_07[var_08] + "_shot04", var_00, var_01);
    }
  }

  level waittill("next_anim4");
  for(var_08 = 0; var_08 < 6; var_08++) {
    var_09 = level.var_54D0["axis"].var_8CA7[var_08].var_13B3;
    if(isDefined(var_09)) {
      var_09 method_8495(var_07[var_08] + "_shot05", var_00, var_01);
    }
  }

  level.axisintrovignette = spawnStruct();
  level.axisintrovignette.shot_soldier = var_04;
  level.axisintrovignette.axis_soldiers = var_06;
  level.axisintrovignette.var_A9E7 = var_03;
}

introvignette_axis_precleanup() {}

func_54D9() {
  if(isDefined(level.axisintrovignette)) {
    var_00 = level.axisintrovignette.boats;
    var_01 = level.axisintrovignette.axis_soldiers;
    var_02 = level.axisintrovignette.var_A9E7;
    common_scripts\utility::func_F71(var_01, ::delete);
    common_scripts\utility::func_F71(var_02, ::delete);
  }

  if(isDefined(level.shot_soldier) && isarray(level.shot_soldier)) {
    foreach(var_04 in level.shot_soldier) {
      if(isDefined(var_04)) {
        var_04 delete();
      }
    }
  }

  level notify("kill_axis_intro");
}

func_54DC(param_00) {
  lib_0378::func_8D74("aud_intro_axis_mixing");
}

func_54D8(param_00, param_01) {
  self endon("death");
  for(;;) {
    self waittill(param_01, var_02);
    if(!isDefined(level.var_54D0) || !isDefined(level.var_54D0["axis"])) {
      continue;
    }

    var_03 = level.var_54D0["axis"].var_8CA7[param_00].var_721C;
    if(!isDefined(var_03)) {
      continue;
    }

    var_04 = self.var_116;
    var_05 = "step";
    if(common_scripts\utility::func_9467(var_02, "footstep_left")) {
      var_05 = function_036D(var_02, "footstep_left_");
      var_04 = self gettagorigin("J_Ankle_LE");
    } else if(common_scripts\utility::func_9467(var_02, "footstep_right")) {
      var_05 = function_036D(var_02, "footstep_right_");
      var_04 = self gettagorigin("J_Ankle_RI");
    } else if(var_02 == "end") {
      var_05 = "none";
    }

    switch (var_05) {
      case "none":
        break;

      case "step":
        lib_04F3::func_79CB("step_run_dirt", var_04);
        break;

      case "truck":
        lib_04F3::func_79CB("step_land_lt_metal_vehicle", var_04);
        common_scripts\utility::func_2CB4(0.15, ::lib_04F3::func_79CF, "gear_rattle_sprint", self);
        break;

      case "land":
        lib_04F3::func_79CB("step_land_hv_dirt", var_04);
        common_scripts\utility::func_2CB4(0.1, ::lib_04F3::func_79CF, "gear_rattle_crouch_drop", self);
        break;

      case "scuff":
      case "scrape":
        lib_04F3::func_79CB("step_scrape_dirt", var_04);
        break;
    }

    if(var_05 != "none") {
      common_scripts\utility::func_2CB4(0.2, ::lib_04F3::func_79CF, "gear_rattle_sprint", self);
    }
  }
}

func_147F(param_00) {
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 1.75, 100, 2, 4, 0);
  thread lib_0505::func_3188(param_00, var_01);
  var_02 = % mp_raids_normandy_axis_start_camera_01;
  thread lib_0505::fovnotetracksaddtolistall(var_02, param_00);
}

func_1480(param_00) {
  level notify("next_anim1");
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 3, 130, 2, 4, 0);
  thread lib_0505::func_3188(param_00, var_01);
  var_02 = % mp_raids_normandy_axis_start_camera_02;
  thread lib_0505::fovnotetracksaddtolistall(var_02, param_00);
}

func_1481(param_00) {
  level notify("next_anim2");
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 1.75, 130, 2, 4, 0);
  var_01 = lib_0505::func_3187(var_01, 1.75, 170, 2, 4, 1.5);
  thread lib_0505::func_3188(param_00, var_01);
  var_02 = % mp_raids_normandy_axis_start_camera_03;
  thread lib_0505::fovnotetracksaddtolistall(var_02, param_00);
}

func_1482(param_00) {
  level notify("next_anim3");
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 3, 130, 2, 4, 0);
  thread lib_0505::func_3188(param_00, var_01);
  var_02 = % mp_raids_normandy_axis_start_camera_04;
  thread lib_0505::fovnotetracksaddtolistall(var_02, param_00);
}

func_1483(param_00) {
  level notify("next_anim4");
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 2, 50, 2, 4, 0);
  var_01 = lib_0505::func_3187(var_01, 3, 500, 2, 4, 2);
  thread lib_0505::func_3188(param_00, var_01);
  var_02 = % mp_raids_normandy_axis_start_camera_05;
  thread lib_0505::fovnotetracksaddtolistall(var_02, param_00);
}

func_6C8C() {
  lib_0505::func_5325();
  var_00 = ["mp_raids_normandy_ally_end_npc_00", "mp_raids_normandy_ally_end_npc_01", "mp_raids_normandy_ally_end_npc_02", "mp_raids_normandy_ally_end_npc_03", "mp_raids_normandy_ally_end_npc_04", "mp_raids_normandy_ally_end_npc_05", "mp_raids_normandy_ally_end_npc_06"];
  var_01 = ["mp_raids_normandy_ally_end_camera_01", "mp_raids_normandy_ally_end_camera_02", "mp_raids_normandy_ally_end_camera_03"];
  var_02 = [::func_6C87, ::func_6C88, ::func_6C89, undefined];
  level.var_6C86["allies"].var_8F2 = "attackers";
  level.var_6C86["allies"].var_8F53 = common_scripts\utility::func_46B5("anim_allies_win", "targetname");
  level.var_6C86["allies"].var_73B4 = var_00;
  level.var_6C86["allies"].var_8097 = 12;
  level.var_6C86["allies"].var_1F03 = var_01;
  level.var_6C86["allies"].var_1F05 = var_02;
  level.var_6C86["allies"].var_92D5 = ::func_6C8D;
  level.var_6C86["allies"].var_2381 = ::func_6C8B;
  level.var_6C86["allies"].var_1F06 = "genericprop_x3";
  level.var_6C86["allies"].var_1F08 = "j_prop_1";
}

func_6C87(param_00) {
  level notify("next_anim");
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 1.5, 500, 2, 4, 0);
  var_01 = lib_0505::func_3187(var_01, 2.5, 45, 2, 4, 2.5);
  thread lib_0505::func_3188(param_00, var_01);
}

func_6C88(param_00) {
  level notify("next_anim");
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 2, 150, 2, 4, 0);
  var_01 = lib_0505::func_3187(var_01, 2, 27, 2, 4, 2.5);
  thread lib_0505::func_3188(param_00, var_01);
}

func_6C89(param_00) {
  level notify("next_anim");
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 2, 70, 2, 4, 0);
  var_01 = lib_0505::func_3187(var_01, 2, 30, 2, 4, 1);
  var_01 = lib_0505::func_3187(var_01, 2, 300, 2, 4, 2.5);
  thread lib_0505::func_3188(param_00, var_01);
}

func_6C8D() {
  thread lib_04B8::allies_win_out();
  var_00 = "vignette_notify";
  lib_0378::func_8D74("aud_allies_victory_sfx");
  level.ddaytank method_805C();
  level.ddaytank.var_9EDD method_805C();
  var_01 = level.var_6C86["allies"].var_116;
  var_02 = level.var_6C86["allies"].var_1D;
  var_03 = ["mp_raids_normandy_ally_end_plane_00", "mp_raids_normandy_ally_end_plane_01", "mp_raids_normandy_ally_end_plane_02"];
  var_04 = common_scripts\utility::func_46B5("plane_spawn", "targetname");
  var_05 = [];
  var_06 = [];
  var_07 = ["mp_raids_normandy_ally_end_ally_npc_06", "mp_raids_normandy_ally_end_ally_npc_10", "mp_raids_normandy_ally_end_ally_npc_11", "mp_raids_normandy_ally_end_ally_npc_12", "mp_raids_normandy_ally_end_ally_npc_14", "mp_raids_normandy_ally_end_ally_npc_15"];
  var_08 = lib_0502::func_4627(game["attackers"]);
  var_08 = common_scripts\utility::func_F92(var_08);
  for(var_09 = 0; var_09 < var_07.size; var_09++) {
    var_0A = spawn("script_model", var_01);
    var_0B = "m1garand_mp";
    if(var_09 < var_08.size && isDefined(var_08[var_09].var_267E)) {
      var_0A setcostumemodels(var_08[var_09].var_267E, "allies");
      var_0B = var_08[var_09] lib_0505::func_470D("m1garand_mp");
    } else {
      var_0A setcostumemodels([1, 1, 1, 1, 1, 0], "allies");
    }

    var_0C = spawn("weapon_" + var_0B, (0, 0, 0), 1);
    var_0C linkto(var_0A, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
    var_06[var_06.size] = var_0C;
    var_0A method_8495(var_07[var_09], var_01, var_02);
    var_05[var_05.size] = var_0A;
  }

  var_0D = [];
  var_0E = ["mp_raids_normandy_ally_end_axis_npc_00", "mp_raids_normandy_ally_end_axis_npc_01", "mp_raids_normandy_ally_end_axis_npc_02", "mp_raids_normandy_ally_end_axis_npc_03", "mp_raids_normandy_ally_end_axis_npc_04", "mp_raids_normandy_ally_end_axis_npc_05", "mp_raids_normandy_ally_end_axis_npc_09", "mp_raids_normandy_ally_end_axis_npc_13", "mp_raids_normandy_ally_end_axis_npc_16", "mp_raids_normandy_ally_end_axis_npc_17"];
  var_0F = lib_0502::func_4627(game["defenders"]);
  var_0F = common_scripts\utility::func_F92(var_0F);
  for(var_09 = 0; var_09 < var_0E.size; var_09++) {
    var_10 = spawn("script_model", var_01);
    var_0B = "mp40_mp";
    if(var_09 < var_0F.size && isDefined(var_0F[var_09].var_267E)) {
      var_10 setcostumemodels(var_0F[var_09].var_267E, "axis");
      var_0B = var_0F[var_09] lib_0505::func_470D("mp40_mp");
    } else {
      var_10 setcostumemodels([2, 1, 2, 2, 2, 0], "axis");
    }

    if(var_09 != 8) {
      var_0C = spawn("weapon_" + var_0B, (0, 0, 0), 1);
      var_0C linkto(var_10, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
      var_06[var_06.size] = var_0C;
    }

    var_10 method_8495(var_0E[var_09], var_01, var_02);
    var_0D[var_0D.size] = var_10;
  }

  level thread outrovignette_allies_handle_jump_shots(var_0D, var_05, var_0E, var_07, var_01, var_02);
  level.var_C70 = spawnStruct();
  level.var_C70.var_C71 = var_05;
  level.var_C70.var_148D = var_0D;
  level.var_C70.var_A9E7 = var_06;
  level waittillmatch("4", "camRigCut");
}

outrovignette_allies_handle_jump_shots(param_00, param_01, param_02, param_03, param_04, param_05) {
  level waittill("next_anim");
  param_00[0] method_8495(param_02[0] + "_shot_02", param_04, param_05);
  param_00[3] method_8495(param_02[3] + "_shot_02", param_04, param_05);
  param_00[4] method_8495(param_02[4] + "_shot_02", param_04, param_05);
  param_00[5] method_8495(param_02[5] + "_shot_02", param_04, param_05);
  param_01[0] method_8495(param_03[0] + "_shot_02", param_04, param_05);
  param_01[5] method_8495(param_03[5] + "_shot_02", param_04, param_05);
  level waittill("next_anim");
  param_00[0] method_8495(param_02[0] + "_shot_03", param_04, param_05);
  param_00[3] method_8495(param_02[3] + "_shot_03", param_04, param_05);
  param_00[4] method_8495(param_02[4] + "_shot_03", param_04, param_05);
  param_00[5] method_8495(param_02[5] + "_shot_03", param_04, param_05);
  param_01[0] method_8495(param_03[0] + "_shot_03", param_04, param_05);
  param_01[1] method_8495(param_03[1] + "_shot_03", param_04, param_05);
  param_01[5] method_8495(param_03[5] + "_shot_03", param_04, param_05);
}

func_6C8B() {
  if(isDefined(level.var_C70)) {
    var_00 = level.var_C70.var_C71;
    var_01 = level.var_C70.var_148D;
    var_02 = level.var_C70.var_A9E7;
    level.var_C70 = undefined;
    common_scripts\utility::func_F71(var_02, ::delete);
    common_scripts\utility::func_F71(var_00, ::delete);
    common_scripts\utility::func_F71(var_01, ::delete);
  }
}

func_0C07(param_00) {
  self endon("death");
  for(;;) {
    self waittill(param_00, var_01);
    switch (var_01) {
      case "hit_fx":
        lib_04F3::func_79CF("flak88_explo", self, "tag_brass");
        break;

      case "fire_artillery":
        lib_04F3::func_79CF("tank_sherman_turret_fire", self, "tag_flash");
        break;

      case "switch_to_destroyed_model":
        self setModel(self.var_106 + "_destroyed");
        break;
    }
  }
}

func_6C93() {
  lib_0505::func_5325();
  var_00 = ["mp_raids_normandy_axiswin_camera_01"];
  var_01 = [::func_6C8E, undefined];
  level.var_6C86["axis"].var_8F2 = "defenders";
  level.var_6C86["axis"].var_8F53 = common_scripts\utility::func_46B5("anim_allies_start", "targetname");
  level.var_6C86["axis"].var_8097 = 12;
  level.var_6C86["axis"].var_1F03 = var_00;
  level.var_6C86["axis"].var_1F05 = var_01;
  level.var_6C86["axis"].var_92D5 = ::func_6C94;
  level.var_6C86["axis"].var_2381 = ::func_6C92;
  level.var_6C86["axis"].var_1F06 = "genericprop_x3";
  level.var_6C86["axis"].var_1F08 = "j_prop_1";
}

func_6C8E(param_00) {
  level notify("next_anim");
  var_01 = [];
  var_01 = lib_0505::func_3187(var_01, 1.5, 1500, 2, 4, 0);
  thread lib_0505::func_3188(param_00, var_01);
}

func_6C94() {
  thread lib_04B8::axis_win_out();
  lib_0378::func_8D74("aud_axis_victory_sfx");
  var_00 = "vignette_notify";
  level.var_148C = spawnStruct();
  enableocean();
  var_01 = level.var_6C86["axis"].var_116;
  var_02 = level.var_6C86["axis"].var_1D;
  var_03 = common_scripts\utility::func_46B5("anim_allies_start", "targetname");
  if(!isDefined(var_03)) {
    return;
  }

  var_04 = var_03.var_116;
  if(!isDefined(var_04)) {
    var_04 = (0, 0, 0);
  }

  var_05 = var_03.var_1D;
  if(!isDefined(var_05)) {
    var_05 = (0, 0, 0);
  }

  var_06 = [];
  var_07 = ["mp_raids_normandy_axiswin_hero_higgins_01", "mp_raids_normandy_axiswin_ambient_ending_higgins_01", "mp_raids_normandy_axiswin_ambient_ending_higgins_02", "mp_raids_normandy_axiswin_ambient_ending_higgins_03", "mp_raids_normandy_axiswin_ambient_ending_higgins_04", "mp_raids_normandy_axiswin_ambient_ending_higgins_05", "mp_raids_normandy_axiswin_ambient_ending_higgins_06", "mp_raids_normandy_axiswin_ambient_ending_higgins_07", "mp_raids_normandy_axiswin_ambient_ending_higgins_08"];
  foreach(var_09 in var_07) {
    var_0A = spawn("script_model", var_04);
    var_0A setModel("vehicle_usa_boat_higgins_mp");
    var_0A method_8495(var_09, var_04, var_05);
    var_06[var_06.size] = var_0A;
  }

  var_0C = [1, 51, 1, 1, 1, 0];
  var_0D = [3, 52, 3, 3, 3, 0];
  var_0E = [9, 53, 9, 9, 9, 9];
  var_0F = [13, 54, 13, 13, 13, 0];
  var_10 = [16, 57, 16, 16, 16, 16];
  var_11 = [1, 51, 1, 1, 1, 0];
  var_12 = [3, 52, 3, 3, 3, 0];
  var_13 = [9, 53, 9, 9, 9, 9];
  var_14 = [13, 54, 13, 13, 13, 0];
  var_15 = [16, 57, 16, 16, 16, 16];
  var_16 = [1, 51, 1, 1, 1, 0];
  var_17 = [];
  foreach(var_0B, var_0A in var_06) {
    if(var_0B == 0) {
      continue;
    } else {
      var_17[var_17.size] = spawn_npc_on_boat_tag_and_play_anim(var_06[var_0B], "tag_driver", "mp_raids_higgins_boat_idle_underfire_driver", var_0C);
      var_17[var_17.size] = spawn_npc_on_boat_tag_and_play_anim(var_06[var_0B], "tag_guy35", "mp_raids_higgins_boat_idle_underfire_npc01", var_0D);
      var_17[var_17.size] = spawn_npc_on_boat_tag_and_play_anim(var_06[var_0B], "tag_guy21", "mp_raids_higgins_boat_idle_underfire_npc02", var_0E);
      var_17[var_17.size] = spawn_npc_on_boat_tag_and_play_anim(var_06[var_0B], "tag_guy20", "mp_raids_higgins_boat_idle_underfire_npc03", var_0F);
      var_17[var_17.size] = spawn_npc_on_boat_tag_and_play_anim(var_06[var_0B], "tag_guy15", "mp_raids_higgins_boat_idle_underfire_npc04", var_10);
      var_17[var_17.size] = spawn_npc_on_boat_tag_and_play_anim(var_06[var_0B], "tag_guy14", "mp_raids_higgins_boat_idle_underfire_npc05", var_11);
      var_17[var_17.size] = spawn_npc_on_boat_tag_and_play_anim(var_06[var_0B], "tag_guy6", "mp_raids_higgins_boat_idle_underfire_npc06", var_12);
      var_17[var_17.size] = spawn_npc_on_boat_tag_and_play_anim(var_06[var_0B], "tag_guy5", "mp_raids_higgins_boat_idle_underfire_npc07", var_13);
      var_17[var_17.size] = spawn_npc_on_boat_tag_and_play_anim(var_06[var_0B], "tag_guy33", "mp_raids_higgins_boat_idle_underfire_npc08", var_14);
      var_17[var_17.size] = spawn_npc_on_boat_tag_and_play_anim(var_06[var_0B], "tag_guy10", "mp_raids_higgins_boat_idle_underfire_npc09", var_15);
      var_17[var_17.size] = spawn_npc_on_boat_tag_and_play_anim(var_06[var_0B], "tag_guy16", "mp_raids_higgins_boat_idle_underfire_npc10", var_16);
    }
  }

  var_19 = [];
  var_1A = ["mp_raids_normandy_axiswin_hero_axisturret_gunner_01", "mp_raids_normandy_axiswin_hero_axisturret_gunner_02"];
  var_1B = lib_0502::func_4627(game["defenders"]);
  var_1B = common_scripts\utility::func_F92(var_1B);
  for(var_0B = 0; var_0B < var_1A.size; var_0B++) {
    var_1C = spawn("script_model", var_01);
    var_1C setcostumemodels([2, 1, 2, 2, 2, 0], "axis");
    var_1C method_8495(var_1A[var_0B], var_01, var_02);
    var_19[var_19.size] = var_1C;
  }

  var_1D = [];
  var_1E = getEntArray("armored_mg", "script_noteworthy");
  common_scripts\utility::func_F71(var_1E, ::method_805C);
  var_1F = ["mp_raids_normandy_axiswin_hero_axis_turret_01", "mp_raids_normandy_axiswin_hero_axis_turret_02"];
  foreach(var_21 in var_1F) {
    var_22 = spawn("script_model", var_01);
    var_22 setModel("npc_ger_mg42_apc_halftrack_shield_turret");
    var_22 method_8495(var_21, var_01, var_02);
    var_1D[var_1D.size] = var_22;
  }

  var_24 = [];
  var_25 = [];
  var_26 = ["mp_raids_normandy_axiswin_player_01", "mp_raids_normandy_axiswin_player_02", "mp_raids_normandy_axiswin_player_03", "mp_raids_normandy_axiswin_player_04", "mp_raids_normandy_axiswin_player_05", "mp_raids_normandy_axiswin_player_06", "mp_raids_normandy_axiswin_player_07", "mp_raids_normandy_axiswin_player_08", "mp_raids_normandy_axiswin_player_09", "mp_raids_normandy_axiswin_player_10", "mp_raids_normandy_axiswin_player_11", "mp_raids_normandy_axiswin_player_12", "mp_raids_normandy_axiswin_player_13", "mp_raids_normandy_axiswin_player_14", "mp_raids_normandy_axiswin_player_15", "mp_raids_normandy_axiswin_higgins_death_guy01", "mp_raids_normandy_axiswin_higgins_death_guy03", "mp_raids_normandy_axiswin_higgins_death_guy04", "mp_raids_normandy_axiswin_higgins_death_guy05", "mp_raids_normandy_axiswin_higgins_death_guy06", "mp_raids_normandy_axiswin_higgins_death_guy07", "mp_raids_normandy_axiswin_higgins_death_guy08", "mp_raids_normandy_axiswin_higgins_death_guy09", "mp_raids_normandy_axiswin_higgins_death_guy10"];
  foreach(var_28 in var_26) {
    var_29 = spawn("script_model", var_01);
    var_29 setcostumemodels([1, 1, 1, 1, 1, 0], "allies");
    var_29 method_8495(var_28, var_01, var_02);
    var_25[var_25.size] = var_29;
    var_2A = spawn("weapon_m1garand_mp", (0, 0, 0), 1);
    var_2A linkto(var_29, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
    var_24[var_24.size] = var_2A;
  }

  level.var_148C = spawnStruct();
  level.var_148C.axis_soldiers = var_19;
  level.var_148C.var_9F96 = var_1D;
  level.var_148C.ally_soldiers = var_25;
  level.var_148C.boats = var_06;
  level.var_148C.boat_npc = var_17;
  level.var_148C.var_A9E7 = var_24;
}

outrovignette_axis_anim_custom(param_00, param_01, param_02, param_03) {
  level waittill("next_anim");
  foreach(var_06, var_05 in param_00) {
    var_05 method_8495(param_01[var_06] + "_shot02", param_02, param_03);
  }

  level waittill("next_anim");
  param_00[0] method_8495(param_01[0] + "_shot03", param_02, param_03);
}

func_6C92() {
  if(isDefined(level.var_148C)) {
    var_00 = level.var_148C.axis_soldiers;
    var_01 = level.var_148C.var_9F96;
    var_02 = level.var_148C.ally_soldiers;
    var_03 = level.var_148C.boats;
    var_04 = level.var_148C.boat_npc;
    var_05 = level.var_148C.var_A9E7;
    level.var_148C = undefined;
    common_scripts\utility::func_F71(var_00, ::delete);
    common_scripts\utility::func_F71(var_01, ::delete);
    common_scripts\utility::func_F71(var_02, ::delete);
    common_scripts\utility::func_F71(var_03, ::delete);
    common_scripts\utility::func_F71(var_04, ::delete);
    common_scripts\utility::func_F71(var_05, ::delete);
  }
}

func_1487(param_00) {
  self endon("death");
  for(;;) {
    self waittill(param_00, var_01);
    thread func_1488(param_00, var_01);
  }
}

func_1488(param_00, param_01) {
  self endon("death");
  switch (param_01) {
    case "hit_fx":
      lib_04F3::func_79CF("b17_mid_air_expl_close", self, "tag_origin");
      lib_04F3::func_79CF("b17_death_fall", self, "tag_origin");
      wait(2.333);
      break;

    case "fire_artillery":
      lib_04F3::func_79CB("flak88_fire", self gettagorigin("tag_flash") + (0, 0, 8));
      break;

    default:
      break;
  }
}

func_9DC5(param_00, param_01) {
  wait(param_01);
  triggerfx(param_00, 1);
}

func_7FC0() {
  level endon("game_ended");
  waittillframeend;
  func_7F92();
  lib_0502::func_7B35();
  rundestroycommequipment();
  lib_0502::func_7B35();
  func_7FA6();
  lib_0502::func_7B35();
  lib_0502::func_7F9A();
}

func_7FCF() {
  setgamespawnpointactivelabel("A", "A", "A");
  thread func_7F98();
  thread func_7F82();
  level waittill("bunkers_done");
  thread func_8B04();
  thread func_8B02();
  level waittill("comm_equipment_done");
  level thread func_8B03();
  level thread func_8B01();
  level waittill("guns_done");
}

func_7F98() {
  level endon("game_ended");
  level endon("bunkers_done");
  level waittill("objectiveComplete", var_00);
  if(var_00 == "bunker_hp_a") {
    lib_0502::func_90A4("B");
    return;
  }

  lib_0502::func_90A4("C");
}

func_7F82() {
  level waittill("objectiveComplete");
  lib_0502::func_90A4(undefined, "Z");
}

func_8B04() {
  level thread lib_0502::func_90A4("D");
  wait(0.1);
  level endon("objectiveComplete");
  maps\mp\gametypes\_hostmigration::func_A6F5(14.9);
  level thread lib_0502::func_90A4("E");
}

func_8B02() {
  wait(0.1);
  level endon("objectiveComplete");
  maps\mp\gametypes\_hostmigration::func_A6F5(14.9);
  level thread lib_0502::func_90A4(undefined, "E");
}

func_8B03() {
  level thread lib_0502::func_90A4("G");
}

func_8B01() {
  maps\mp\gametypes\_hostmigration::func_A6F5(20);
  lib_0502::func_90A4(undefined, "G");
}

func_7F92() {
  level notify("runBunkersObjective");
  thread func_7F84();
  lib_04FF::func_6972("capture_bunkers");
  level.bots_build_walls_radius = 2000;
  setomnvar("ui_raid_objective_index_allies", 0);
  setomnvar("ui_raid_objective_index_axis", 3);
  maps\mp\_utility::func_3FA5("prematch_done");
  lib_0502::func_86DE(lib_0501::func_4647("capture2x_objectiveTime"), 1);
  var_00 = lib_0502::func_6514();
  lib_04FF::func_6982("capture_bunkers");
  level.bots_build_walls_radius = undefined;
  level thread lib_0500::func_1E85(game["defenders"], 15, "comm_equipment");
  lib_0502::func_697A("capture_bunkers");
  level notify("bunkers_done");
}

rundestroycommequipment() {
  level notify("run_objective_comm_equipment");
  thread func_7FA5();
  var_00 = "comm_equipment";
  lib_04FF::func_6972(var_00);
  lib_0502::func_697F(var_00);
  setomnvar("ui_raid_objective_index_allies", 1);
  setomnvar("ui_raid_objective_index_axis", 4);
  lib_0502::func_86DE(lib_0501::func_4647("destroy_objectiveTime"), 2);
  lib_04FF::func_6982(var_00);
  level thread lib_0500::func_1E85(game["defenders"], 15, "gun_01");
  level notify("comm_equipment_done");
}

func_7FA6() {
  setomnvar("ui_raid_objective_index_allies", 2);
  setomnvar("ui_raid_objective_index_axis", 5);
  lib_04FF::func_6972("destroy_guns");
  thread func_7F97();
  var_00 = common_scripts\utility::func_46B7("gun_muzzle", "targetname");
  foreach(var_02 in level.artilleryguntop) {
    thread func_1F62(var_02);
  }

  lib_0502::func_86DE(lib_0501::func_4647("multibomb_objectiveTime"), 3);
  lib_04FF::func_6982("destroy_guns");
  lib_0502::func_697A("destroy_guns");
  level notify("guns_done");
}

setupartilleryguns() {
  level.artilleryguntop = getEntArray("artillery_top", "targetname");
  level.artillerygunbottom = getEntArray("artillery_bottom", "targetname");
  foreach(var_01 in level.artilleryguntop) {
    var_01 scriptmodelplayanim("mp_raids_german_artillery_idle", "end_anim");
  }

  var_03 = common_scripts\utility::func_46B7("multiBombObjective", "script_noteworthy");
  foreach(var_01 in var_03) {
    var_05 = undefined;
    var_06 = getEntArray(var_01.var_1A2, "targetname");
    foreach(var_08 in var_06) {
      if(isDefined(var_08.var_165) && var_08.var_165 == "trigger") {
        var_05 = var_08;
      }
    }

    var_0A = getEntArray(var_05.var_1A2, "targetname");
    foreach(var_08 in var_0A) {
      if(isDefined(var_08.var_165) && var_08.var_165 == "bomb_model") {
        var_08.var_116 = var_08.var_116 - (0, 0, 500);
      }
    }
  }
}

func_1F62(param_00) {
  level endon("game_ended");
  level endon("guns_done");
  param_00 endon("stop_firing");
  var_01 = spawn("script_origin", param_00.var_116);
  var_02 = param_00 gettagorigin("TAG_FLASH");
  var_03 = param_00 gettagangles("TAG_FLASH");
  var_04 = anglesToForward(var_03);
  for(;;) {
    wait(randomintrange(20, 30));
    param_00 scriptmodelplayanim("mp_raids_german_artillery_fire", "end_anim");
    playFX(common_scripts\utility::func_44F5("cannon_flash"), var_02, var_04);
    var_01 lib_0378::func_8D74("aud_cannon_firing");
  }
}

checknojipscore() {
  if(!game["switchedsides"]) {
    return;
  }

  if(!common_scripts\utility::func_562E(self.ismultibomb)) {
    return;
  }

  if(!common_scripts\utility::func_562E(self.var_651B)) {
    return;
  }

  var_00 = self.var_6E78;
  var_01 = undefined;
  foreach(var_03 in level.var_79AE.var_8DB) {
    if(var_03.var_695A == var_00) {
      var_01 = var_03;
      break;
    }
  }

  if(!isDefined(var_01)) {
    return;
  }

  var_05 = 0;
  var_06 = 0;
  foreach(var_08 in var_01.var_94CE) {
    var_05 = var_05 + var_08.numbombsplanted;
    var_06 = var_06 + var_08.numbombsrequired;
  }

  if(var_06 <= 0) {
    return;
  }

  if(var_05 / var_06 < 0.5) {
    return;
  }

  setnojipscore(1);
}

ongunexplode(param_00) {
  var_01 = [];
  var_01[1] = ["day_german_artillery_01_top_des03_rig", "day_german_artillery_01_bot_des03_rig", "mp_raids_german_artillery_transition", "r_dday_cannon_explosion_rnr", "r_dday_bunker_rolling_smoke"];
  var_01[2] = ["day_german_artillery_01_top_des01_rig", "day_german_artillery_01_bot_des01_rig", "mp_raids_german_artillery_transition", "r_dday_cannon_explosion_rnr", "r_dday_cannon_fire_a"];
  var_01[3] = ["day_german_artillery_01_top_des02_rig", "day_german_artillery_01_bot_des02_rig", "mp_raids_german_artillery_destroyed_a", "r_dday_gun_exp_final_state", "r_dday_cannon_smoke_black"];
  var_02 = undefined;
  var_03 = undefined;
  foreach(var_05 in level.artilleryguntop) {
    if(var_05.var_165 == self.var_1A5) {
      var_02 = var_05;
    }
  }

  foreach(var_08 in level.artillerygunbottom) {
    if(var_08.var_165 == self.var_1A5) {
      var_03 = var_08;
    }
  }

  playFXOnTag(common_scripts\utility::func_44F5(var_01[param_00.numbombsplanted][3]), var_02, "TAG_YAW");
  playFXOnTag(common_scripts\utility::func_44F5(var_01[param_00.numbombsplanted][4]), var_02, "TAG_YAW");
  var_02 setModel(var_01[param_00.numbombsplanted][0]);
  var_02 scriptmodelplayanim(var_01[param_00.numbombsplanted][2], "end_anim");
  var_03 setModel(var_01[param_00.numbombsplanted][1]);
  if(param_00.numbombsplanted == 3) {
    stopFXOnTag(common_scripts\utility::func_44F5("r_dday_bunker_rolling_smoke"), var_02, "TAG_YAW");
    stopFXOnTag(common_scripts\utility::func_44F5("r_dday_cannon_fire_a"), var_02, "TAG_YAW");
    var_02 notify("stop_firing");
  }

  lib_0378::func_8D74("aud_cannon_bombed", var_02.var_116, var_03.var_116, param_00.numbombsplanted);
  checknojipscore();
  var_0A = getEntArray("bomb_dmg", "targetname");
  var_0A = function_01AC(var_0A, var_02.var_116);
  wait(0.25);
  foreach(var_0C in level.var_744A) {
    if(var_0C istouching(var_0A[0])) {
      var_0C dodamage(99999, var_0A[0].var_116, undefined, undefined, "MOD_EXPLOSIVE", "bomb_site_mp");
    }
  }
}

func_7F84() {
  level waittill("kill_axis_intro");
  level.var_16ED = common_scripts\utility::func_46B7("ally_beach_spawn", "targetname");
  for(var_00 = 0; var_00 < 20; var_00++) {
    var_01 = common_scripts\utility::func_46B5(level.var_16ED[var_00].var_1A2, "targetname");
    func_0C72(level.var_16ED[var_00], var_01);
  }

  thread func_16EC();
  thread func_7B74();
}

func_16EC() {
  level endon("bunkers_done");
  for(;;) {
    while(level.var_BC2.size >= level.var_6071) {
      wait(0.5);
    }

    if(level.var_6071 <= 0) {
      break;
    }

    var_00 = common_scripts\utility::func_7A33(level.var_16ED);
    var_01 = common_scripts\utility::func_46B5(var_00.var_1A2, "targetname");
    wait 0.05;
    func_0C72(var_00, var_01);
    wait 0.05;
  }
}

func_7B74() {
  while(level.var_6071 > 0) {
    wait(8);
    level.var_6071 = max(0, level.var_6071 - 2);
  }
}

func_0C72(param_00, param_01) {
  var_02 = getgroundposition(param_00.var_116, 8);
  var_03 = [[level.var_A4D]]("beach_ally", game["attackers"], undefined, var_02, param_00.var_1D, undefined, 0, 0, "recruit");
  if(isDefined(var_03)) {
    if(var_03.var_1A7 == "axis") {
      var_03 switchcustomizationteam(1);
    }

    var_03 method_8528(1, "allies");
    var_03 thread func_0C73(param_00, param_01);
    level.var_BC2[level.var_BC2.size] = var_03;
  }
}

func_0C73(param_00, param_01) {
  var_02 = getnodesinradiussorted(param_01.var_116, 256, 0);
  var_03 = ["J_Hip_LE", "J_Neck", "J_Head", "J_Shoulder_RI"];
  var_04 = randomintrange(0, 3);
  var_05 = undefined;
  self botsetpathingstyle("default");
  self botsetscriptgoal(var_02[0].var_116, 16, "critical");
  self.var_9 = undefined;
  self.agentspeedscale = 0.8;
  maps\mp\gametypes\_weapons::func_A13B();
  self.var_CA = 1;
  self.var_BC = 55;
  thread func_6366(param_00, param_01);
  thread func_0C6E();
}

func_0C6E() {
  self endon("death");
  level endon("game_ended");
  wait(randomintrange(15, 20));
  var_00 = randomintrange(0, 10);
  if(var_00 < 4) {
    var_01 = "MOD_EXPLOSIVE";
    playFX(common_scripts\utility::func_44F5("mortar_explosion_lrg"), self.var_116);
    lib_0378::func_8D74("aud_beach_mortar_explode_npc");
  } else {
    var_01 = "MOD_RIFLE_BULLET";
    playFXOnTag(common_scripts\utility::func_44F5("blood_impact"), self, "J_Head");
    lib_0380::func_6844("bullet_flesh_whiz_plr_shared", undefined, self, 0, 1);
    wait(0.1);
  }

  self dodamage(9999, self.var_116, undefined, undefined, var_01);
  lib_0380::func_6844("generic_death_american_1", undefined, self, 0, 1);
}

func_6366(param_00, param_01) {
  self waittill("death");
  level.var_BC2 = common_scripts\utility::func_F93(level.var_BC2, self);
}

runbeachcompletecleanup() {
  var_00 = common_scripts\utility::func_46B5("destroy_shingle_1", "targetname");
  var_01 = common_scripts\utility::func_46B5("destroy_shingle_2", "targetname");
  var_02 = common_scripts\utility::func_46B5("destroy_shingle_3", "targetname");
  lib_04F7::func_5A4F(var_00.var_116, 128);
  lib_04F7::func_5A4F(var_01.var_116, 128);
  lib_04F7::func_5A4F(var_02.var_116, 128);
  var_03 = common_scripts\utility::func_46B5("destroy_beach_bunker_doors", "targetname");
  lib_04F7::func_5A4F(var_03.var_116, 300);
  lib_04F7::func_2F99(var_03.var_116, 300);
  wait(1);
  var_04 = getEntArray("beach_post_gameplay_ladders", "script_noteworthy");
  foreach(var_06 in var_04) {
    if(var_06.var_3A == "script_brushmodel") {
      var_06 solid();
      var_07 = lib_04F7::func_440F();
      var_08 = common_scripts\utility::func_40B0(var_06.var_116, var_07);
      var_09 = var_08[0];
      lib_04F7::disable_wall(var_09);
      var_0A = var_09 lib_0502::func_207C("build_ladder_traversal_start")[0];
      var_0B = getnode(var_0A.var_1A2, "targetname");
      disconnectnodepair(var_0A, var_0B, 1);
      var_0C = var_09 lib_0502::func_207C("ladder_traversal_start")[0];
      var_0D = getnode(var_0C.var_1A2, "targetname");
      connectnodepair(var_0C, var_0D, 1);
      continue;
    }

    if(var_06.var_3A == "script_model") {
      var_06 method_805B();
    }
  }
}

runbeachladdersetup() {
  var_00 = getEntArray("beach_post_gameplay_ladders", "script_noteworthy");
  foreach(var_02 in var_00) {
    if(var_02.var_3A == "script_brushmodel") {
      var_02 notsolid();
      continue;
    }

    if(var_02.var_3A == "script_model") {
      var_02 method_805C();
    }
  }
}

func_7FA5() {
  thread runbeachcompletecleanup();
  var_00 = getnodearray("guns_mortars", "targetname");
  var_01 = common_scripts\utility::func_46B5("guns_artillery", "targetname");
  var_02 = common_scripts\utility::func_46B5(var_01.var_1A2, "targetname");
  var_03 = getnodesinradius(var_01.var_116, 310, 0, 200);
  for(var_04 = 0; var_04 < var_03.size; var_04++) {
    var_05 = var_03[var_04];
    if(!nodeexposedtosky(var_05, 1)) {
      var_03 = common_scripts\utility::func_F93(var_03, var_05);
      var_04--;
    }
  }

  var_06 = spawnplane("script_model", var_01.var_116);
  var_07 = spawnplane("script_model", var_01.var_116);
  thread maps\mp\killstreaks\_v2_missle_strike::func_8C0B("missile_strike", undefined, var_06, var_07, game["defenders"]);
  var_08 = 10000;
  var_09 = gettime();
  while(gettime() - var_09 < var_08) {
    var_0A = var_02.var_116 + (randomfloatrange(-200, 200, 0), randomfloatrange(-200, 200, 0), 0);
    var_0B = var_03[randomint(var_03.size)].var_116;
    var_0C = magicartillery("missile_strike_projectile_axis_mp", var_0A, var_0B, 2.5, 3200);
    var_0C thread func_1000(var_01.var_116);
    var_0C lib_0378::func_8D74("aud_interlude_artillery");
    wait(randomfloatrange(0.5, 1));
  }

  wait(2);
  thread func_2378(var_06, var_07);
}

func_1000(param_00) {
  self waittill("explode", var_01);
  foreach(var_03 in level.var_744A) {
    if(var_03.var_1A7 == game["defenders"]) {
      continue;
    }

    if(!maps\mp\_utility::func_57A0(var_03)) {
      continue;
    }

    var_04 = distancesquared(param_00, var_03.var_116);
    var_05 = 250000;
    var_06 = var_05 - var_04 / var_05;
    if(var_06 > 0) {
      var_07 = 50 + 500 * var_06;
      var_03 dodamage(var_07, param_00, undefined, undefined, "MOD_EXPLOSIVE");
    }
  }
}

func_2378(param_00, param_01) {
  if(isDefined(param_00)) {
    param_00 method_8352(100, 0);
  }

  if(isDefined(param_01)) {
    param_01 method_8352(100, 0);
  }

  wait(0.1);
  thread maps\mp\killstreaks\_v2_missle_strike::func_238B(param_00, param_01);
}

func_7F8D() {
  level notify("runObjectiveBuildBarricade");
  thread func_7F97();
  setomnvar("ui_raid_objective_index_allies", 2);
  setomnvar("ui_raid_objective_index_axis", 5);
  lib_04FF::func_6972("build_barricade");
  lib_0502::func_86DE(4, 3);
  lib_04FF::func_6982("build_barricade");
  lib_0502::func_697A("build_barricade");
}

func_6368() {
  var_00 = 48;
  var_01 = 110;
  var_02 = common_scripts\utility::func_46B5("build_barricade", "targetname");
  var_03 = getEntArray("build_barricade_model", "targetname");
  level.var_15CD = 0;
  foreach(var_05 in var_03) {
    if(isDefined(var_05.var_1A2)) {
      var_06 = getEntArray(var_05.var_1A2, "targetname");
      if(var_06.size) {
        foreach(var_08 in var_06) {
          var_08 linkto(var_05);
        }
      }
    }

    var_05.var_92F0 = var_05.var_116;
    if(var_05.var_81E1 < 3) {
      var_05.var_116 = var_05.var_116 - (0, 0, var_00);
      continue;
    }

    var_05.var_116 = var_05.var_116 - (0, 0, var_01);
  }

  level waittill("guns_done");
  for(var_0B = 1; var_0B < 6; var_0B++) {
    var_02 waittill("flag_captured");
    level notify("barricade_section_built");
    level.var_15CD++;
    foreach(var_05 in var_03) {
      if(var_0B == var_05.var_81E1) {
        var_05 moveto(var_05.var_92F0, 3, 1, 1);
      }
    }
  }
}

func_7F95() {
  level notify("runBunkersObjective");
  thread func_7F97();
  lib_0502::func_697F("counterAttackObjective");
  lib_04FF::func_6972("counter_attack");
  setomnvar("ui_raid_objective_index_allies", 2);
  setomnvar("ui_raid_objective_index_axis", 5);
  var_00 = lib_0502::func_6514();
  var_00 thread lib_0502::func_6517("counter_attack", ::lib_04FF::func_6982, "counter_attack");
  level waittill("objectiveComplete", var_01);
  lib_0502::func_6936();
  lib_04FF::func_6935(var_01);
  lib_0502::func_697A("counterAttackObjective");
}

func_1BB2() {
  var_00 = getEntArray("break_objects_tank", "targetname");
  var_01 = getEntArray("break_objects_tank_collision", "targetname");
  self waittill("trigger");
  foreach(var_03 in var_00) {
    var_03 method_805C();
  }

  foreach(var_03 in var_01) {
    var_03 notsolid();
  }
}

func_7F97() {
  var_00 = getent("counter_tank", "targetname");
  var_01 = getent("counter_tank", "targetname");
  level.ddaytank = func_2A3A(var_01);
  var_02 = getent("tank_turret_trigger", "targetname");
  level.ddaytank thread func_2A3B(var_02, game["defenders"]);
  if(isDefined(level.ddaytank.var_9EDD)) {
    level.ddaytank.var_9EDD thread lib_0504::func_9F9B(game["defenders"]);
  }

  level.ddaytank method_8280(0, 15, 5);
  wait(2);
  level.ddaytank startpath(level.ddaytank.var_92ED);
  var_03 = getvehiclenode("break_objects", "targetname");
  var_03 thread func_1BB2();
  for(;;) {
    level.ddaytank method_8280(0, 15, 5);
    while(!isDefined(level.ddaytank.var_9EDD.var_73C9)) {
      wait(0.1);
    }

    level.ddaytank method_8280(5, 15, 5);
    while(isDefined(level.ddaytank.var_9EDD.var_73C9)) {
      wait(0.1);
      var_04 = level.ddaytank method_84C8();
      if(!isDefined(var_04.var_1A2)) {
        level.ddaytank.reachedendnode = 1;
      }
    }
  }
}

func_7F89() {
  waittillframeend;
  maps\mp\_utility::func_3FA5("prematch_done");
  lib_04F4::func_863D("allies_A", "active", 5);
  lib_04F4::func_863D("axis_A", "active", 5);
  lib_04F4::func_863D("axis_B", "active", 5);
  lib_04F4::func_863D("axis_C", "active", 5);
  lib_04F4::func_8BEF(["allies_A", "axis_A"]);
  level waittill("bunkers_done");
  lib_04F4::func_863D("axis_A", "inactive");
  lib_04F4::func_7D4E();
  lib_04F4::func_8BEF(["allies_B", "axis_B"]);
  level thread lib_04F4::func_9C77("allies_B", 20);
  level waittill("comm_equipment_done");
  lib_04F4::func_863D("axis_B", "inactive");
  lib_04F4::func_7D4E();
  lib_04F4::func_8BEF(["allies_C", "axis_C"]);
  level thread lib_04F4::func_9C77("allies_C2", 20);
  lib_04F4::func_8C13("allies_C", 1);
  maps\mp\gametypes\_hostmigration::func_A6F5(20);
  lib_04F4::func_8C13("allies_C", 0);
}

func_7F86() {
  level endon("bunkers_done");
  var_00 = getnodearray("beach_mortar", "targetname");
  maps\mp\gametypes\_hostmigration::func_A6F5(30);
  for(;;) {
    wait(randomintrange(5, 8));
    var_01 = 3;
    var_00 = common_scripts\utility::func_F92(var_00);
    var_02 = [];
    foreach(var_04 in var_00) {
      foreach(var_06 in level.var_744A) {
        if(distancesquared(var_04.var_116, var_06.var_116) >= 262144) {
          var_02[var_02.size] = var_04;
        }

        break;
      }

      if(var_02.size >= var_01) {
        break;
      }
    }

    for(var_09 = 0; var_09 < var_02.size; var_09++) {
      var_0A = var_02[var_09].var_116;
      var_0A = (var_0A[0], var_0A[1], 0);
      thread maps\mp\killstreaks\_v2_missle_strike::func_3216(-1, var_0A, undefined, "axis", "mortar_strike", "axis", "mortar_strike_projectile_d_day_mp");
      wait(maps\mp\killstreaks\_v2_missle_strike::func_46E0("mortar_strike"));
    }

    wait 0.05;
  }
}

func_7F94() {
  level endon("game_ended");
  var_00 = getEntArray("counterattack_hp_border", "targetname");
  foreach(var_02 in var_00) {
    var_02 method_805C();
  }

  level waittill("guns_done");
  foreach(var_02 in var_00) {
    var_02 method_805B();
  }
}

func_A90A() {
  level endon("game_ended");
  var_00 = common_scripts\utility::func_46B7("shingle", "targetname");
  foreach(var_02 in var_00) {
    var_02 thread func_63E1();
  }

  level waittill("shingle_breached");
  level thread lib_0500::func_1E85(game["attackers"], 5, "capture_bunkers");
}

func_63E1() {
  level endon("game_ended");
  self.var_1D33 = "waypoint_buildable_active_map";
  waittillframeend;
  self.var_1D34 = self.var_116;
  objective_position(self.var_6989, self.var_1D34);
  self waittill("trigger");
  if(self.var_6989 >= 0) {
    objective_state(self.var_6989, "invisible");
  }

  level notify("shingle_breached");
}

func_2A3A(param_00) {
  var_01 = function_01E0(param_00.var_106, param_00.var_1A5, param_00.var_1C8, param_00.var_116, param_00.var_1D);
  var_01.var_1C8 = param_00.var_1C8;
  var_01 makeunusable();
  var_01 setCanDamage(0);
  var_01.var_1A2 = param_00.var_1A2;
  var_01.var_A045 = ::lib_0504::func_A3FE;
  var_01.var_A3EF = 1;
  var_01 method_867B(1);
  var_01 thread lib_0502::func_2FC4();
  var_01.var_4881 = 1;
  var_01.var_37D8 = var_01 getentitynumber();
  var_01.var_92ED = getvehiclenode(var_01.var_1A2, "targetname");
  lib_0502::func_9FF(var_01);
  var_02 = undefined;
  if(var_01.var_1C8 == "ger_tank_king_tiger_mp") {
    var_02 = "TAG_TURRET_4";
  }

  lib_0504::func_794B(var_01, var_02, "npc_ger_mg42_tigerii_bucket_mp", "turretweapon_mg42_bucket_mp", game["defenders"]);
  self.var_A2C8 = var_01;
  self.var_5DC0 = self.var_A2C8;
  waittillframeend;
  var_01 attachpath(var_01.var_92ED);
  return var_01;
}

func_2A3B(param_00, param_01) {
  param_00 endon("death");
  param_00 makeunusable();
  param_00 enablelinkto();
  param_00 method_83EF();
  param_00 sethintstring(&"RAIDS_USE_TANK_TURRET");
  param_00 setcursorhint("HINT_NOICON");
  if(!isDefined(self.var_9EDD)) {
    return;
  }

  param_00 linkto(self);
  param_00.var_9EDD = self.var_9EDD;
  param_00 thread lib_0504::func_9F9B(param_01);
  param_00.var_6DB2 = param_01;
  level.var_79C2.var_9F96[level.var_79C2.var_9F96.size] = param_00;
  for(;;) {
    param_00 makeusable();
    self.var_9EDD.var_73C9 = undefined;
    param_00 waittill("trigger", var_02);
    var_02 thread maps\mp\_audio_submixes::func_8A9D("mp_war_vehicle_turret", 0.1);
    waittillframeend;
    if(!isDefined(var_02)) {
      continue;
    }

    if(var_02 common_scripts\_plant_weapon::func_5855()) {
      continue;
    }

    self.var_9EDD useby(var_02);
    var_02 method_86AA(1);
    self.var_9EDD.var_73C9 = var_02;
    param_00 makeunusable();
    self.var_9EDD waittill("turretownerchange");
    if(isDefined(var_02)) {
      var_02 thread maps\mp\_audio_submixes::func_8A9F("mp_war_vehicle_turret", 0.1);
      var_02 method_86AA(0);
    }
  }
}

func_9487() {
  wait 0.05;
  maps\mp\_utility::func_3FA5("prematch_done");
  wait(5);
  maps\mp\_utility::func_3FA4("finished_intro_vignette_allies");
  maps\mp\_utility::func_3FA4("finished_intro_vignette_axis");
}

func_7FCC() {
  thread func_7F85();
  thread runantenaambience();
  thread func_7F91();
}

func_7F85() {}

func_7F87() {
  level endon("bunkers_done");
  thread func_90B7();
}

func_90B7() {
  wait(25);
  var_00 = common_scripts\utility::func_46B7("struct_vista_planes", "targetname");
  foreach(var_02 in var_00) {
    var_03 = spawn("script_model", self.var_116);
    var_03 setModel("usa_bomber_b17_raid");
    var_03 moveto(common_scripts\utility::func_46B5(self.var_1A2, "targetname").var_116, 20);
    wait(20);
    var_03 delete();
  }
}

runantenaambience() {
  level waittill("bunkers_done");
}

func_7F91() {
  level waittill("comm_equipment_done");
  thread runparatrooperfx();
}

runparatrooperfx() {
  var_00 = common_scripts\utility::func_46B7("paratrooper_fx_spawn", "targetname");
  foreach(var_02 in var_00) {
    playFX(common_scripts\utility::func_44F5("paratrooper_deploy"), var_02.var_116, anglesToForward(var_02.var_1D));
  }
}

func_7F88() {
  var_00 = common_scripts\utility::func_46B7("struct_vista_smoke", "script_noteworthy");
  foreach(var_02 in var_00) {
    playFX(common_scripts\utility::func_44F5("large_fire_smoke_mp"), var_02.var_116);
  }
}

func_7F90() {
  wait(5);
  level.var_1DA4 = common_scripts\utility::func_46B7("ally_bunker_spawn", "targetname");
  for(var_00 = 0; var_00 < level.var_1DA4.size; var_00++) {
    var_01 = common_scripts\utility::func_46B5(level.var_1DA4[var_00].var_1A2, "targetname");
    func_0C72(level.var_1DA4[var_00], var_01);
  }
}

initvignettemgs() {
  var_00 = getEntArray("raid_turret_static", "targetname");
  foreach(var_02 in var_00) {
    if(isDefined(var_02.var_8260) && var_02.var_8260 == "d_day_vignette_mg") {
      var_02 thread watchvignettemguse();
    }
  }
}

watchvignettemguse() {}

patchupdatebarbedwireexplosivemodel() {
  wait(5);
  foreach(var_01 in level.var_79C2.var_159A) {
    if(isDefined(var_01.explosivemodel)) {
      if(distancesquared(var_01.explosivemodel.var_116, (1188.3, -16319.4, -582.8)) < 16384) {
        var_01.explosivemodel.var_116 = (1199.2, -16306.1, -612.8);
        var_01.explosivemodel.var_1D = (66.2977, 40.0982, -0.00115356);
        continue;
      }

      if(distancesquared(var_01.explosivemodel.var_116, (876.2, -16060, -601.1)) < 16384) {
        var_01.explosivemodel.var_116 = (876.2, -16059.5, -601.1);
        var_01.explosivemodel.var_1D = (43.3811, 30.3943, -19.9651);
        continue;
      }

      if(distancesquared(var_01.explosivemodel.var_116, (710.6, -16633, -480.8)) < 16384) {
        var_01.explosivemodel.var_116 = (721.1, -16632, -504.3);
        var_01.explosivemodel.var_1D = (37.3524, 302.787, -30.8398);
        continue;
      }

      if(distancesquared(var_01.explosivemodel.var_116, (-767.8, -16040.9, -559.9)) < 16384) {
        var_01.explosivemodel.var_116 = (-748.4, -16026.7, -581.9);
        var_01.explosivemodel.var_1D = (46.861, 30.5971, -35.8907);
        continue;
      }

      if(distancesquared(var_01.explosivemodel.var_116, (-929.699, -16746.2, -450.5)) < 16384) {
        var_01.explosivemodel.var_116 = (-929.699, -16744.7, -450.5);
        var_01.explosivemodel.var_1D = (52.0888, 36.98, -20.7503);
      }
    }
  }
}

botgetmaxturretdistscalar(param_00) {
  if(param_00.var_1B9 == "trigger_on_vehicle" && isDefined(param_00.var_9EDD.var_A2C8)) {
    if(!common_scripts\utility::func_562E(param_00.var_9EDD.var_A2C8.reachedendnode)) {
      return 2;
    }
  }

  return 1;
}

botgetincreasedturretchance(param_00) {
  if(param_00.var_1B9 == "trigger_on_vehicle" && isDefined(param_00.var_9EDD.var_A2C8)) {
    if(!common_scripts\utility::func_562E(param_00.var_9EDD.var_A2C8.reachedendnode)) {
      return 25;
    }
  }

  return 0;
}