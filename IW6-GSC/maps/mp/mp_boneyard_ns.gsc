/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_boneyard_ns.gsc
**************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

CONST_HORIZONTAL_FIRE = "horizontal rocket fire";

CONST_CRASH_01_LOC = (-752, 96, -112);
CONST_CRASH_02_LOC = (944, 112, -112);
CONST_CRASH_RADIUS = 192;
CONST_CRASH_HEIGHT = 96;

main() {
  maps\mp\mp_boneyard_ns_precache::main();
  maps\createart\mp_boneyard_ns_art::main();
  maps\mp\mp_boneyard_ns_fx::main();

  level.mapCustomCrateFunc = ::boneyardCustomCrateFunc;
  level.mapCustomKillstreakFunc = ::boneyardCustomKillstreakFunc;
  level.mapCustomBotKillstreakFunc = ::boneyardCustomBotKillstreakFunc;

  maps\mp\_load::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_boneyard_ns");
  maps\mp\mp_boneyard_ns_anim::main();

  SetDvar("r_lightGridEnableTweaks", 1);
  SetDvar("r_lightGridIntensity", 1.33);
  setdvar_cg_ng("r_specularColorScale", 2, 4.5);
  setDvar("sm_sunShadowScale", 0.60);
  setDvar("sm_sunSampleSizeNear", 0.35);

  level.alarm2_a = spawn("script_origin", (-93, 1451, 248));
  level.alarm2_vo = spawn("script_origin", (317, 1449, 247));
  level.alarm2_b = spawn("script_origin", (805, 1443, 275));
  level.fire_event_a = spawn("script_origin", (517, 1463, 14));
  level.fire_event_a2 = spawn("script_origin", (517, 1463, 14));
  level.fire_event_a3 = spawn("script_origin", (517, 1463, 14));
  level.fire_event_b = spawn("script_origin", (381, 1463, -18));
  level.fire_event_b2 = spawn("script_origin", (381, 1463, -18));
  level.fire_event_lp = spawn("script_origin", (280, 1471, 9));
  level.fire_event_lpstart = spawn("script_origin", (280, 1471, 9));
  level.fire_event_lpstop = spawn("script_origin", (280, 1471, 9));
  level.launch_vo1 = spawn("script_origin", (1936, 231, 221));
  level.launch_vo2 = spawn("script_origin", (-1028, 534, 368));
  level.launch_command_vo = spawn("script_origin", (2917, 396, 10));

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  while(!isDefined(level.gametypestarted)) {
    wait(0.05);
  }

  maps\mp\mp_boneyard_ns_killstreak::boneyard_killstreak_disable();

  flag_inits();
  if(level.gameType == "sd" || level.gameType == "sr" || level.gameType == "grind") {
    setup_no_events(true, CONST_HORIZONTAL_FIRE);
  }
  else if(level.gameType == "blitz" || level.gameType == "horde" || isMLGSystemLink()) {
    setup_no_events(true);
  }
  else {
    setup_events();
  }

  thread join_sync_exploders();

  if(level.gameType == "horde" || level.gameType == "infect") {
    setup_safeguard();
  }

  level thread initExtraCollision();
}

initExtraCollision() {
  if(level.gametype == "horde" || level.gameType == "infect") {
    collision1 = GetEnt("clip128x128x8", "targetname");
    collision1Ent = spawn("script_model", (-1352, 168, 150));
    collision1Ent.angles = (0, 0, 0);
    collision1Ent CloneBrushmodelToScriptmodel(collision1);
  }

  if(level.xenon || level.xb3) {
    model1 = spawn("script_model", (-136, 1246, 136));
    model1 setModel("comm_desk_part_long");
    model1.angles = (360, 90, 90);

    model2 = spawn("script_model", (-136, 1346, 136));
    model2 setModel("comm_desk_part_long");
    model2.angles = (360, 90, 90);

    model3 = spawn("script_model", (-136, 1446, 136));
    model3 setModel("comm_desk_part_long");
    model3.angles = (360, 90, 90);

    model4 = spawn("script_model", (-136, 1546, 136));
    model4 setModel("comm_desk_part_long");
    model4.angles = (360, 90, 90);

    model5 = spawn("script_model", (-132, 1578, 157));
    model5 setModel("light_post_strip_mall_02");
    model5.angles = (0, 90, 180);
  }
}

flag_inits() {
  flag_init("flag_rocket_countdown");
  flag_init("flag_rocket_countdown_fx");
  flag_init("flag_rocket_launched");

  flag_init("Horizontal_Test_Fired");
  flag_init("Horizontal_Test_Firing");
}

setup_events() {
  thread set_up_building_facade();

  maps\mp\mp_boneyard_ns_killstreak::boneyard_killstreak_setup();
  boneyard_fire_horizontal_setup();

  GetEnt("remd_02_proxy", "targetname") Delete();

  level.rocket_explo = getEntArray("rocket_explo_obj", "targetname");
  foreach(part in level.rocket_explo) {
  part setup_rocket_explo_part();
  }

  tanks = GetScriptableArray("scriptable_toy_com_propane_tank02_cheap", "classname");
  foreach(tank in tanks) {
  tank thread rocket_explo_tank_clip_swap();
  }

  level thread maps\mp\mp_boneyard_ns_killstreak::boneyard_killstreak_activate();
  level thread maps\mp\mp_boneyard_ns_killstreak::boneyard_killstreak_endgame();

  level thread boneyard_fire_horizontal_trigger();

  thread play_and_stop_spotlight_fx();

  thread maps\mp\_dlcalienegg::setupEggForMap("alienEasterEgg");

  delayThread(5, ::event_rocket_success, 10, 3);

  delayThread(60, ::event_rocket_explode, 25, 3);
}

setup_no_events(enable_killstreak, killstreak_exception) {
  GetEnt("rocket_explo_rocket", "targetname") Delete();

  rocket_explo = getEntArray("rocket_explo_obj", "targetname");
  foreach(part in rocket_explo) {
    crash_before = getEntArray(part.target + "_before", "targetname");
    array_call(crash_before, ::Delete);

    crash_delete = getEntArray(part.target + "_delete", "targetname");
    foreach(ent in crash_delete) {
      ent ConnectPaths();
      ent Delete();
    }

    if(isDefined(level.explo_nums["rocket_explo"][part.script_label])) {
      mp_exploder(level.explo_nums["rocket_explo"][part.script_label], -60);
    }
  }

  thread sound_fire_elements();
  level notify("rocket_crash_01");

  GetEnt("remd_02_proxy", "targetname") Delete();
  GetEnt("tunnel_exit_A_mantles", "targetname") Delete();

  facade = getEntArray("unbroken_facade", "targetname");
  array_call(facade, ::Delete);
  mp_exploder(208, -60);

  RadiusDamage((-309, -516, -47), 50, 496, 500);
  level.exploder_queue[5] = spawnStruct();
  level.exploder_queue[5].num = 5;
  level.exploder_queue[5].time = GetTime();
  level.exploder_queue[5].startTime = 0;

  tanks = GetScriptableArray("scriptable_toy_com_propane_tank02_cheap", "classname");
  foreach(tank in tanks) {
  tank thread rocket_explo_tank_clip_swap();
  }

  delayThread(3, ::mp_exploder, 21);

  level thread maps\mp\mp_boneyard_ns_killstreak::boneyard_killstreak_endgame();

  if(isDefined(enable_killstreak) && enable_killstreak) {
    if(isDefined(killstreak_exception)) {
      switch (killstreak_exception) {
        case CONST_HORIZONTAL_FIRE:

          maps\mp\mp_boneyard_ns_killstreak::boneyard_killstreak_setup();
          level thread maps\mp\mp_boneyard_ns_killstreak::boneyard_killstreak_activate();
          break;
        default:
          AssertEx(killstreak_exception == CONST_HORIZONTAL_FIRE, "The killstreak exception must be CONST_HORIZONTAL_FIRE");
          break;
      }
    } else {
      maps\mp\mp_boneyard_ns_killstreak::boneyard_killstreak_setup();
      boneyard_fire_horizontal_setup();

      level thread maps\mp\mp_boneyard_ns_killstreak::boneyard_killstreak_activate();
      level thread boneyard_fire_horizontal_trigger();
    }
  }

  thread maps\mp\_dlcalienegg::setupEggForMap("alienEasterEgg");

  delayThread(5, ::event_rocket_success, 10, 3);

  maps\mp\mp_boneyard_ns_killstreak::boneyard_killstreak_enable(200);
}

setup_safeguard() {
  bottom_node = GetNode("crawler_ladder_bottom_node", "targetname");
  top_node = GetNode("crawler_ladder_top_node", "targetname");
  DisconnectNodePair(top_node, bottom_node);

  ladder = GetEnt("crawler_ladder", "targetname");
  ladder delete();
}

play_and_stop_spotlight_fx() {
  wait 3;

  mp_exploder(21);

  createfx_origin = (5706.71, -2875.28, 456.125);
  createfx_angles = (270, 0, 0);
  fx_up = anglestoup(createfx_angles);
  fx_fwd = anglesToForward(createfx_angles);
  spot1 = SpawnFx(level._effect["vfx_mp_boneyard_rocket_spot"], createfx_origin, fx_fwd, fx_up);
  TriggerFX(spot1);

  createfx_origin2 = (6209.81, -2376.86, 446.79);
  createfx_angles2 = (307.118, 274.46, 85.1872);
  fx_up2 = anglestoup(createfx_angles2);
  fx_fwd2 = anglesToForward(createfx_angles2);
  spot2 = SpawnFx(level._effect["vfx_mp_boneyard_rocket_spot"], createfx_origin2, fx_fwd2, fx_up2);
  TriggerFX(spot2);

  createfx_origin3 = (4493.13, -2993.15, -151.985);
  createfx_angles3 = (302.07, 56.4086, -61.7638);
  fx_up3 = anglestoup(createfx_angles3);
  fx_fwd3 = anglesToForward(createfx_angles3);
  spot3 = SpawnFx(level._effect["vfx_mp_boneyard_rocket_spot"], createfx_origin3, fx_fwd3, fx_up3);
  TriggerFX(spot3);

  createfx_origin4 = (15341.6, -606.557, 2176.76);
  createfx_angles4 = (315.112, 247.696, 110.105);
  fx_up4 = anglestoup(createfx_angles4);
  fx_fwd4 = anglesToForward(createfx_angles4);
  spot4 = SpawnFx(level._effect["vfx_mp_boneyard_rocket_spot"], createfx_origin4, fx_fwd4, fx_up4);
  TriggerFX(spot4);

  createfx_origin5 = (15101, -1212.7, 2176.63);
  createfx_angles5 = (270, 0, 0);
  fx_up5 = anglestoup(createfx_angles5);
  fx_fwd5 = anglesToForward(createfx_angles5);
  spot5 = SpawnFx(level._effect["vfx_mp_boneyard_rocket_spot"], createfx_origin5, fx_fwd5, fx_up5);
  TriggerFX(spot5);

  createfx_origin6 = (15261.2, -2023.07, 2176.63);
  createfx_angles6 = (308.808, 40.8442, -47.1412);
  fx_up6 = anglestoup(createfx_angles6);
  fx_fwd6 = anglesToForward(createfx_angles6);
  spot6 = SpawnFx(level._effect["vfx_mp_boneyard_rocket_spot"], createfx_origin6, fx_fwd6, fx_up6);
  TriggerFX(spot6);

  level waittill("rocket_success_blast_off");
  spot4 delete();
  spot5 delete();
  spot6 delete();

  level waittill("rocket_explo_blast_off");
  spot1 delete();
  spot2 delete();
  spot3 delete();
}

setup_rocket_explo_part() {
  self.clip = GetEnt(self.target, "targetname");
  self.clip LinkTo(self);

  self.crash_delete = getEntArray(self.target + "_delete", "targetname");
  self.crash_before = getEntArray(self.target + "_before", "targetname");
  self.crash_after = getEntArray(self.target + "_after", "targetname");
  self.crash_path = GetNodeArray(self.target + "_traverse", "targetname");

  self.linked_ents = [];
  self.kill_ents = [self.clip];
  if(isDefined(self.clip.target)) {
    foreach(ent in getEntArray(self.clip.target, "targetname")) {
      ent LinkTo(self);
      self.linked_ents[self.linked_ents.size] = ent;

      if(isDefined(ent.script_noteworthy) && ent.script_noteworthy == "push_kill") {
        self.kill_ents[self.kill_ents.size] = ent;
      }
    }
  }

  self.fall_anim = self.script_label;
  self.start_org = GetEnt("rocket_explo_explosion", "targetname");

  self Hide();
  array_call(self.linked_ents, ::Hide);
  self.origin = self.start_org.origin;
  self.angles = self.start_org.angles;
  self.clip delayCall(0.05, ::DisconnectPaths);
  self.clip delayCall(0.05, ::SetAISightLineVisible, 0);

  foreach(ent in self.crash_after) {
    ent Hide();
    ent.origin -= (0, 0, 1024);
  }

  wait(0.1);
  foreach(node in self.crash_path) {
  DisconnectNodePair(node, GetNode(node.target, "targetname"));
  }
}

set_up_building_facade() {
  unbroken = getEntArray("unbroken_facade", "targetname");
  broken = getEntArray("broken_facade", "targetname");
  foreach(piece in broken) {
    piece hide();
  }

  level waittill("break_facade");
  foreach(piece in broken) {
    mp_exploder(205);
    piece show();
  }
  foreach(piece in unbroken) {
    piece hide();
  }

  wait 0.36;
  mp_exploder(206);
  wait 0.3;
  mp_exploder(207);
  wait 0.28;
  mp_exploder(208);
}

rocket_explo_tank_clip_swap() {
  self waittill("death");

  IPrintLn("tank dead");
}

boneyardCustomCrateFunc() {
  level thread maps\mp\mp_boneyard_ns_killstreak::boneyardCustomCrateFunc();
}

boneyardCustomKillstreakFunc() {
  AddDebugCommand("devgui_cmd \"MP/Killstreak/Level Event:5/Care Package/F-1 Engine Test Fire\" \"set scr_devgivecarepackage f1_engine_fire; set scr_devgivecarepackagetype airdrop_assault\"\n");
  AddDebugCommand("devgui_cmd \"MP/Killstreak/Level Event:5/F-1 Engine Test Fire\" \"set scr_givekillstreak f1_engine_fire\"\n");

  level.killStreakFuncs["f1_engine_fire"] = ::tryUseBoneyardKillstreak;
}

boneyardCustomBotKillstreakFunc() {
  AddDebugCommand("devgui_cmd\"MP/Bots(Killstreak)/Level Events:5/F-1 Engine Test Fire\" \"set scr_testclients_givekillstreak f1_engine_fire\"\n");
  maps\mp\bots\_bots_ks::bot_register_killstreak_func("f1_engine_fire", maps\mp\bots\_bots_ks::bot_killstreak_simple_use);
}

tryUseBoneyardKillstreak(lifeId, streakName) {
  if(flag("boneyard_killstreak_active") || !isDefined(level.ks_vertical)) {
    self iPrintLnBold(&"MP_BONEYARD_NS_F1_IN_USE");
    return false;
  }

  level.ks_vertical.uses += 1;
  level notify("boneyard_killstreak_activate", self);

  if(level.ks_vertical.uses >= level.ks_vertical.max_uses) {
    level.ks_vertical.uses = 0;
    return true;
  }

  return false;
}

event_rocket_countdown(count_time, count_sfx) {
  flag_set("flag_rocket_countdown");

  for(i = count_time; i >= 0; i--) {
    if(i == 20) {
      mp_exploder(16);
    }

    if(isDefined(count_sfx[i])) {
      level.launch_vo1 playSound(count_sfx[i]);
      level.launch_vo2 playSound(count_sfx[i]);
    }
    wait(1);
  }

  flag_clear("flag_rocket_countdown");
}

event_rocket_success(count_time, launch_time) {
  level notify("rocket_success_start");

  rocket = GetEnt("rocket_success_rocket", "targetname");

  count_sfx = [];

  rocket thread event_rocket_countdown(count_time, count_sfx);

  wait(count_time - launch_time);
  level notify("rocket_success_launch_init");
  mp_exploder(33);
  rocket playSound("scn_beginning_launch_sfx_dist");

  wait(launch_time);
  level notify("rocket_success_blast_off");
  playFXOnTag(level._effect["vfx_rocket_shuttle_smoke_geotrail_xlarge"], rocket, "tag_origin");
  rocket ScriptModelPlayAnimDeltaMotion(level.anim_names["rocket_success"]["launch"]);

  wait(GetAnimLength(level.animations["rocket_success"]["launch"]));
  level notify("rocket_success_finished");

  thread audio_command_vo();

  rocket ScriptModelClearAnim();
  up_vector = AnglesToUp(rocket.angles);
  rocket MoveTo(up_vector * 62512.5, 64);
  wait 64;
  stopFXOnTag(level._effect["vfx_rocket_shuttle_smoke_geotrail_xlarge"], rocket, "tag_origin");
  rocket Delete();
}

audio_command_vo() {
  wait 25;
  level.launch_command_vo playSound("mp_boneyard_fd_attentionallpersonelthis");
}

event_rocket_explode(count_time, launch_time) {
  level notify("rocket_explo_start");
  GetScriptableArray("countdown_clock", "targetname")[0] SetScriptablePartState(0, 1);

  org = GetEnt("rocket_explo_explosion", "targetname");
  rocket = GetEnt("rocket_explo_rocket", "targetname");
  rocket_anim = level.animations["rocket_explo"]["launch"];

  count_sfx = [];
  count_sfx[25] = "mp_boneyard_ld_autosequencestarttminus";
  count_sfx[17] = "mp_boneyard_ld_tminus15";
  count_sfx[13] = "mp_boneyard_ld_tminus10";

  delayThread(57.8, ::mp_exploder, 111);

  mp_exploder(20);

  flag_set("flag_rocket_countdown_fx");
  wait(60 - count_time);
  rocket thread event_rocket_countdown(count_time, count_sfx);

  wait(count_time - launch_time);
  level notify("rocket_explo_launch_init");
  mp_exploder(32);
  rocket playSound("scn_beginning_launch_sfx");

  wait(launch_time);
  level notify("rocket_explo_blast_off");
  flag_set("flag_rocket_launched");
  playFXOnTag(level._effect["vfx_rocket_shuttle_smoke_geotrail_xlarge"], rocket, "control_root");
  rocket ScriptModelPlayAnimDeltaMotion(level.anim_names["rocket_explo"]["launch"]);
  thread sound_wait_for_pre_explosion(rocket);

  thread building_impact_timing();

  foreach(part in level.rocket_explo) {
  part thread rocket_explo_drop_part();
  }

  explo_time = GetAnimLength(rocket_anim) * GetNotetrackTimes(rocket_anim, "rog_hit")[0];
  wait(explo_time);
  level notify("rocket_explo_explode");
  mp_exploder(64);
  stopFXOnTag(level._effect["vfx_rocket_shuttle_smoke_geotrail_xlarge"], rocket, "control_root");

  thread fx_fiery_debris(rocket);

  level.rocket_explo[1] playSound("scn_shuttle_debris_fall_01");
  level.rocket_explo[2] playSound("scn_shuttle_debris_fall_02");
  thread explosion_vo();

  thread remove_mantles();
  thread rocket_explo_destroy_tank();
  thread sound_fire_elements();
  thread sfx_dist_debris();

  thread kill_survivors("rocket_crash_01", CONST_CRASH_01_LOC, CONST_CRASH_RADIUS, CONST_CRASH_HEIGHT);
  thread kill_survivors("rocket_crash_02", CONST_CRASH_02_LOC, CONST_CRASH_RADIUS, CONST_CRASH_HEIGHT);

  wait(GetAnimLength(rocket_anim) - explo_time);
  rocket Delete();

  level notify("rocket_explo_finished");

  maps\mp\_compass::setupMiniMap("compass_map_mp_boneyard_ns_after");

  maps\mp\mp_boneyard_ns_killstreak::boneyard_killstreak_enable(200);
}

fx_fiery_debris(rocket) {
  playFXOnTag(level._effect["vfx_debris_trail_xlarge"], rocket, "j_rocket_004");
  playFXOnTag(level._effect["vfx_debris_trail_xlarge"], rocket, "j_rocket_005");
  waitframe();
  playFXOnTag(level._effect["vfx_debris_trail_xlarge"], rocket, "j_rocket_006");
  playFXOnTag(level._effect["vfx_debris_trail_xlarge"], rocket, "j_rocket_007");
  waitframe();
  playFXOnTag(level._effect["vfx_debris_trail_xlarge"], rocket, "j_rocket_008");
}

sound_wait_for_pre_explosion(rocket) {
  wait 5.5;

  rocket playSound("scn_beggining_launch_explode");
}

building_impact_timing() {
  anim_length = GetAnimLength(level.animations["rocket_explo"]["crash_04"]);
  percent = GetNotetrackTimes(level.animations["rocket_explo"]["crash_04"], "building_hit");
  time = anim_length * percent[0];
  wait time;
  level notify("break_facade");
  thread sound_logic_impacts("building");
}

sfx_dist_debris() {
  level waittill("rocket_crash_01");

  dist_crash_01 = spawn("script_origin", (-1686, 2876, 89));
  dist_crash_02 = spawn("script_origin", (-2445, 1748, 18));
  dist_crash_03 = spawn("script_origin", (-3190, 1477, 55));

  wait 0.4;

  dist_crash_01 playSound("scn_shuttle_dist_debris_01");
  wait 0.1;
  dist_crash_02 playSound("scn_shuttle_dist_debris_02");
  wait 0.3;
  dist_crash_03 playSound("scn_shuttle_dist_debris_06");

  wait 6;
  dist_crash_01 delete();
  dist_crash_02 delete();
  dist_crash_03 delete();
}

sound_fire_elements() {
  level waittill("rocket_crash_01");

  fire_small_1 = spawn("script_origin", (-808, -14, -130));
  fire_small_2 = spawn("script_origin", (-817, 210, -123));
  fire_small_3 = spawn("script_origin", (-1028, 534, 368));
  fire_small_4 = spawn("script_origin", (-599, 276, -117));
  fire_small_5 = spawn("script_origin", (-282, 184, -127));
  fire_small_6 = spawn("script_origin", (-384, 504, -45));
  fire_small_7 = spawn("script_origin", (-69, 923, -81));
  fire_small_8 = spawn("script_origin", (133, 912, -68));
  fire_small_9 = spawn("script_origin", (870, 1, -110));
  fire_small_10 = spawn("script_origin", (880, 229, -115));
  fire_small_11 = spawn("script_origin", (1224, 231, -147));
  fire_small_12 = spawn("script_origin", (1377, 207, -159));
  fire_small_13 = spawn("script_origin", (1340, -15, -149));

  fire_ceiling_01 = spawn("script_origin", (1154, 128, -31));
  fire_ceiling_02 = spawn("script_origin", (-558, 61, 33));
  fire_ceiling_03 = spawn("script_origin", (973, 115, 7));

  fire_small_1 playLoopSound("fire_small_01");
  fire_small_2 playLoopSound("fire_small_01");
  fire_small_3 playLoopSound("fire_small_01");
  fire_small_4 playLoopSound("fire_small_01");
  fire_small_5 playLoopSound("fire_small_01");
  fire_small_6 playLoopSound("fire_small_01");
  fire_small_7 playLoopSound("fire_small_01");
  fire_small_8 playLoopSound("fire_small_01");
  fire_small_9 playLoopSound("fire_small_01");
  fire_small_10 playLoopSound("fire_small_01");
  fire_small_11 playLoopSound("fire_small_01");
  fire_small_12 playLoopSound("fire_small_01");
  fire_small_13 playLoopSound("fire_small_01");

  fire_ceiling_01 playLoopSound("fire_ceiling_small_01");
  fire_ceiling_02 playLoopSound("fire_ceiling_small_01");
  fire_ceiling_03 playLoopSound("fire_small_01");
}

explosion_vo() {
  wait 0.7;
  level.launch_vo1 playSound("mp_boneyard_ld_supplydronehasbeen");
  level.launch_vo2 playSound("mp_boneyard_ld_supplydronehasbeen");
}

rocket_explo_drop_part() {
  array_thread(self.kill_ents, maps\mp\_movers::player_pushed_kill, 0);

  foreach(ent in self.kill_ents) {
    ent.destroyAirdropOnCollision = true;
  }
  array_call(self.linked_ents, ::Show);
  self Show();

  playFXOnTag(level._effect["vfx_debris_trail_xlarge"], self, "tag_origin");

  anim_length = GetAnimLength(level.animations["rocket_explo"][self.fall_anim]);
  self thread rocket_explo_part_ground_hit(anim_length);
  self ScriptModelPlayAnimDeltaMotion(level.anim_names["rocket_explo"][self.fall_anim]);
  wait(anim_length);

  if(maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone()) {
    wait(0.05);
  }

  stopFXOnTag(level._effect["vfx_debris_trail_xlarge"], self, "tag_origin");

  foreach(ent in self.crash_delete) {
    ent ConnectPaths();
    ent Delete();
  }

  self thread rocket_explo_drop_part_safety_check();

  array_thread(self.kill_ents, maps\mp\_movers::stop_player_pushed_kill);
  self.clip delayCall(0.05, ::DisconnectPaths);
  self.clip delayCall(0.05, ::SetAISightLineVisible, 1);

  wait(0.1);
  foreach(node in self.crash_path) {
  ConnectNodePair(node, GetNode(node.target, "targetname"));
  }
}

rocket_explo_drop_part_safety_check() {
  foreach(player in level.players) {
    if(player IsTouching(self.clip)) {
      self.clip maps\mp\_movers::unresolved_collision_owner_damage(player);
    }
  }
}

rocket_explo_part_ground_hit(anim_length) {
  ground_hit = GetNotetrackTimes(level.animations["rocket_explo"][self.fall_anim], "ground_hit");
  wait(anim_length * ground_hit[0]);

  level notify("rocket_" + self.fall_anim);

  if(isDefined(level.explo_nums["rocket_explo"][self.fall_anim])) {
    mp_exploder(level.explo_nums["rocket_explo"][self.fall_anim]);
  }
  Earthquake(0.6, 1.5, self.origin, 800);
  self thread sound_logic_impacts(self.fall_anim);

  array_call(self.crash_before, ::Hide);
  foreach(ent in self.crash_after) {
    ent show();
    ent MoveZ(1024, 0.05);
  }

  wait(0.1);
  array_call(self.crash_before, ::Delete);
}

sound_logic_impacts(piece) {
  switch (piece) {
    case "crash_01":
      self playSound("scn_shuttle_debris_05");
      break;
    case "crash_02":
      self playSound("scn_shuttle_debris_04");
      break;
    case "crash_03a":

      break;
    case "crash_03b":

      break;
    case "crash_04":
      self playSound("scn_shuttle_debris_02");
      break;
    case "building":
      building = spawn("script_origin", (670, 1101, 442));
      building playSound("scn_shuttle_debris_01");
      break;
    case "tank":

      break;
    default:
      break;
  }
}

remove_mantles() {
  level waittill("rocket_crash_02");
  mantles = GetEnt("tunnel_exit_A_mantles", "targetname");
  mantles Delete();
}

rocket_explo_destroy_tank() {
  level waittill("rocket_crash_01");

  self thread sound_logic_impacts("tank");
  RadiusDamage((-309, -516, -47), 50, 496, 500);

  level.exploder_queue[5] = spawnStruct();
  level.exploder_queue[5].num = 5;
  level.exploder_queue[5].time = GetTime();
  level.exploder_queue[5].startTime = 0;
}

kill_survivors(crashNotify, crashLoc, crashRadius, crashRadiusHeight) {
  level endon("game_ended");
  level waittill(crashNotify);

  damage_zone = spawn("trigger_radius", crashLoc, 0, crashRadius, crashRadiusHeight);
  damage_radius_check(damage_zone);
}

damage_radius_check(zone) {
  foreach(player in level.participants) {
    if(player IsTouching(zone)) {
      player DoDamage(1000, player.origin, undefined, undefined, "MOD_CRUSH");
    }
  }

  zone delete();
}

join_sync_exploders() {
  while(1) {
    level waittill("connected", player);

    player thread join_sync_exploders_proc();
  }
}

join_sync_exploders_proc() {
  self endon("disconnect");

  self waittill_any("joined_team", "luinotifyserver");

  if(!isDefined(level.exploder_queue)) {
    return;
  }
  time = GetTime();
  foreach(explo in level.exploder_queue) {
    if(time < explo.time) {
      continue;
    }
    wait(0.05);
    mytime = explo.startTime - GetTime() + explo.time;

    if(myTime > -60000) {
      ActivateClientExploder(explo.num, self, myTime / 1000.0);
    }
    else {
      ActivateClientExploder(explo.num, self, -60);
    }
  }

  if(flag("flag_rocket_launched")) {
    GetScriptableArray("countdown_clock", "targetname")[0] SetScriptablePartState(0, 0);
  }
  else if(flag("flag_rocket_countdown_fx")) {
    self thread join_sync_countdown();
  }
}

join_sync_countdown() {
  self endon("disconnect");

  while(!flag("flag_rocket_launched")) {
    ActivateClientExploder(7, self);
    wait(0.05);
  }
}

mp_exploder(num, startTime) {
  exploder(num, undefined, startTime);

  if(!isDefined(startTime)) {
    startTime = 0;
  }

  if(!isDefined(level.exploder_queue)) {
    level.exploder_queue = [];
  }

  level.exploder_queue[num] = spawnStruct();
  level.exploder_queue[num].num = num;
  level.exploder_queue[num].time = GetTime();
  level.exploder_queue[num].startTime = startTime * 1000;
}

boneyard_fire_horizontal_setup() {
  level.fire_horiz = spawnStruct();
  level.fire_horiz.dam = GetEnt("damage_test_fire_horizontal", "targetname");
  level.fire_horiz.player = undefined;
  level.fire_horiz.team = undefined;
  level.fire_horiz.trig = spawn("script_model", (471, 1601, -17));
  level.fire_horiz.trig setModel("tag_origin");
  level.fire_horiz.trig SetHintString(&"MP_BONEYARD_NS_HORIZONTAL_TEST");

  level.fire_horiz.inflictor = GetEnt("horiz_fire_ent", "targetname");

  flag_init("boneyard_fire_horizontal_active");
  flag_init("fire_horiz_alarm_on");
  flag_init("fire_horiz_firing");
}

boneyard_fire_horizontal_trigger() {
  level endon("game_ended");

  while(1) {
    button_ready = SpawnFx(level._effect["vfx_horz_fire_red_light"], (452, 1596.93, -27.28));
    TriggerFX(button_ready);
    thread sfx_console_beeps_start();

    level.fire_horiz.trig MakeUsable();
    level.fire_horiz.trig waittill("trigger", player);
    level.fire_horiz.trig MakeUnusable();

    thread sfx_console_beeps_stop();

    flag_set("boneyard_fire_horizontal_active");
    level.fire_horiz.player = player;
    level.fire_horiz.team = player.pers["team"];

    button_ready Delete();
    button_cooldown = SpawnFx(level._effect["vfx_horz_fire_amber_light"], (452, 1596.93, -27.28));
    TriggerFX(button_cooldown);

    flag_set("fire_horiz_alarm_on");
    thread fire_horiz_alarm();
    thread fire_horiz_firing_fx();

    wait 4;
    flag_clear("fire_horiz_alarm_on");

    fire_horiz_fire();

    level.fire_horiz.player = undefined;
    level.fire_horiz.team = undefined;
    flag_clear("boneyard_fire_horizontal_active");

    wait(30);
    button_cooldown Delete();
  }
}

fire_horiz_fire() {
  level endon("game_ended");

  flag_set("fire_horiz_firing");
  BadPlace_Brush("bad_horiz_fire", 10, level.fire_horiz.dam, "allies", "axis");

  for(i = 0; i < 20; i++) {
    wait 0.5;
    maps\mp\gametypes\_hostmigration::waitTillHostMigrationDone();

    attacker = level.fire_horiz.player;
    if(!isDefined(level.fire_horiz.player) || !IsPlayer(level.fire_horiz.player)) {
      attacker = undefined;
    }

    thread maps\mp\mp_boneyard_ns_killstreak::damage_characters(level.fire_horiz, attacker, 25);
    thread maps\mp\mp_boneyard_ns_killstreak::damage_targets(level.fire_horiz, attacker, level.remote_uav, 50);
    thread maps\mp\mp_boneyard_ns_killstreak::damage_targets(level.fire_horiz, attacker, level.placedIMS, 50);
    thread maps\mp\mp_boneyard_ns_killstreak::damage_targets(level.fire_horiz, attacker, level.uplinks, 50);
    thread maps\mp\mp_boneyard_ns_killstreak::damage_targets(level.fire_horiz, attacker, level.turrets, 50);
    thread maps\mp\mp_boneyard_ns_killstreak::damage_targets(level.fire_horiz, attacker, level.ballDrones, 50);
    thread maps\mp\mp_boneyard_ns_killstreak::damage_targets(level.fire_horiz, attacker, level.mines, 50);
    thread maps\mp\mp_boneyard_ns_killstreak::damage_targets(level.fire_horiz, attacker, level.deployable_box["deployable_vest"], 50);
    thread maps\mp\mp_boneyard_ns_killstreak::damage_targets(level.fire_horiz, attacker, level.deployable_box["deployable_ammo"], 50);
  }

  flag_clear("fire_horiz_firing");
}

fire_horiz_alarm() {
  level.alarm2_vo playSound("mp_boneyard_cc_rockettestinitiatingin");

  while(flag("fire_horiz_alarm_on")) {
    level.alarm2_a playSound("emt_boneyard_ns_close_alarm_02");
    level.alarm2_b playSound("emt_boneyard_ns_close_alarm_02");
    wait 0.871;
  }
}

fire_horiz_firing_fx() {
  mp_exploder(66);

  wait 4;

  for(i = 0; i < 5; i++) {
    mp_exploder(67);
    wait 2;
  }

  mp_exploder(68);
}

sfx_console_beeps_start() {
  if(!isDefined(level.console_beep)) {
    level.console_beep = spawn("script_origin", (450, 1590.25, -26));

  }

  level.console_beep playLoopSound("emt_boneyard_ns_console_beep_01");
}

sfx_console_beeps_stop() {
  level.console_beep StopLoopSound("emt_boneyard_ns_console_beep_01");
  sfx_console_activate();
}

sfx_console_activate() {
  level.console_beep playSound("scn_boneyard_ns_console_press");
  thread sound_fire_event_logic();
  wait 0.1;
  level.console_beep playSound("emt_boneyard_ns_console_beep_02");
}

sound_fire_event_logic() {
  level.fire_event_a playSound("scn_fire_event_01");
  level.fire_event_b playSound("scn_fire_event_01_b");
  wait 3.8;
  level.fire_event_a2 playSound("scn_fire_event_01p2");
  level.fire_event_lpstart playSound("scn_fire_event_01_lpstart");
  wait 1.5;
  level.fire_event_lp playLoopSound("scn_fire_event_01_lp");
  wait 8;
  level.fire_event_a3 playSound("scn_fire_event_01p3");
  level.fire_event_b2 playSound("scn_fire_event_01_bp2");
  level.fire_event_lpstop playSound("scn_fire_event_01_lpstop");
  level.fire_event_lp StopLoopSound();
}