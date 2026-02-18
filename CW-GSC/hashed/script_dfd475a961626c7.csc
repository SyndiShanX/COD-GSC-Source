/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_dfd475a961626c7.csc
***********************************************/

#using script_1cd690a97dfca36e;
#using scripts\core_common\array_shared;
#using scripts\core_common\audio_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\snd;
#using scripts\cp_common\snd_draw;
#using scripts\cp_common\snd_utility;
#namespace namespace_a052577e;

function event_handler[level_preinit] function_b489bb7b(eventstruct) {
  snd::function_d4ec748e(&function_f2a2832d);
  snd::function_ce78b33b(&function_32ab045);
  snd::trigger_init(&_trigger);
  snd::function_5e69f468(&_objective);
}

function event_handler[event_cc819519] function_686b88aa(eventstruct) {
  level.var_b9a192d2 = [];
  level.var_936dc3f3 = 0;
  snd::wait_init();
  snd::waitforplayers();
  function_b6407dd4(1);
  audio::function_21f8b7c3();
  level.var_cffe5f6f = &function_9c9fad4e;
}

function private _objective(objective) {
  switch (objective) {
    case # "tkdn_raid_bar":
      function_b6407dd4(1);
      break;
    case # "tkdn_raid_gearup":
      function_b6407dd4(1);
      break;
    case # "tkdn_raid_apt":
      function_b6407dd4(1);
      break;
    case # "tkdn_raid_capture":
      function_b6407dd4(1);
      break;
    case # "hash_7db5c2bb92c102ae":
      function_b6407dd4(1);
      break;
    case # "tkdn_af_intro":
      function_b6407dd4(0);
      break;
    case # "tkdn_af_hill":
      function_b6407dd4(0);
      level thread function_955f4842();
      level thread function_a43c0d2c();
      level notify(#"hash_50385173feb854f0");
      break;
    case # "tkdn_af_tarmac":
      function_b6407dd4(0);
      level thread function_2d8bbe54(0.1);
      level thread function_a43c0d2c();
      break;
    case # "tkdn_af_chase":
      function_b6407dd4(0);
      function_5ea2c6e3("cp_tkdn_af_chase_mix", 0, 1);
      function_5ea2c6e3("cp_tkdn_af_rc_chase_tires", 0, 1);
      level thread cargo_plane_takeoff();
      level thread function_d1b165f5();
      break;
    case # "tkdn_af_rc_chase":
      function_b6407dd4(0);
      function_5ea2c6e3("cp_tkdn_af_chase_mix", 0, 1);
      level thread function_d1b165f5();
      level thread function_e8df4c70();
      break;
    case # "tkdn_af_skid":
      function_b6407dd4(0);
      break;
    case # "tkdn_af_wreck":
      function_b6407dd4(0);
      break;
    case # "no_game":
    case # "hash_6e531fb9475df744":
      break;
    default:

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:x38>" + objective + "<dev string:x5b>");

      break;
  }
}

function private function_32ab045(ent, name) {
  switch (name) {
    case # "adler":
      level.adler = ent;
      ent waittill(#"death");
      level.adler = undefined;
      break;
    case # "woods":
      level.woods = ent;
      ent waittill(#"death");
      level.woods = undefined;
      break;
    case # "af_flyover":
      plane = ent;
      var_d776868d = snd::play("veh_tkd_airstrip_flyover", plane);
      snd::function_f4f3a2a(var_d776868d, plane, 9);
      break;
    case # "cargo_plane":
      level.cargo_plane = ent;
      ent waittill(#"death");
      level.cargo_plane = undefined;
      break;
    case # "cargo_plane_mover":
      level.cargo_plane_mover = ent;
      ent waittill(#"death");
      level.cargo_plane_mover = undefined;
      break;
    case # "af_truck_plr":
      level.var_5acf72ee = ent;
      function_b3fdcb06(level.var_5acf72ee, "tag_axel_front_up", "veh_tkd_chase_plr_jeep_high_lp");
      function_244835ac(level.var_5acf72ee, "veh_tkd_rcxd_deploy_tires_lp");
      ent waittill(#"death");
      level.var_5acf72ee = undefined;
      break;
    case # "rc_car_plr":
      level.rc_car_plr = ent;
      level thread function_e8df4c70();
      ent waittill(#"death");
      level.rc_car_plr = undefined;
      break;
    case # "af_enemy_chase_veh":
      level.af_enemy_chase_veh = snd::function_4b879845(level.af_enemy_chase_veh, ent);
      function_b3fdcb06(ent, "tag_axel_front_up", "veh_tkd_chase_npc_jeeps_high_lp");
      function_244835ac(ent, "veh_tkd_rcxd_deploy_tires_lp");
      ent waittill(#"death");
      level.af_enemy_chase_veh = snd::function_16b5f116(level.af_enemy_chase_veh, ent);
      break;
    case # "skid_veh":
      function_b3fdcb06(ent, "tag_axel_front_up", "veh_tkd_skid_veh_high_lp");
      function_244835ac(ent, "veh_tkd_skid_veh_tires_skid_lp");
      level thread function_7142e76c(ent);
      break;
    case # "cargo_debris":
      level thread cargo_debris(ent);
      break;
    default:

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:x60>" + snd::function_783b69(name, "<dev string:x5b>"));

      break;
  }
}

function private _trigger(player, trigger, var_ec80d14b) {
  trigger_name = snd::function_ea2f17d1(var_ec80d14b.script_ambientroom, "$default");

  switch (trigger_name) {
    case # "$default":
      break;
    case # "hash_1be9f27129ae7a62":
      break;
    case # "hash_4b729aa87d03cd":
    case # "hash_11867574383ac22a":
    case # "hash_1912faafb2f99437":
      break;
    case # "hash_52c6ce5cc7e45cd":
    case # "hash_137e57cafd9e1316":
    case # "hash_34a277e453b641df":
    case # "hash_3f3ff833c7fba2e7":
    case # "hash_50ea2a1178720bb6":
    case # "hash_5836480b992bf337":
    case # "hash_6da66622baceb34e":
    case # "hash_7cf32b3e3b7bd98b":
      break;
    case # "hash_431834d37daaaf40":
    case # "hash_5f996c7d961a6374":
      break;
    case # "hash_d19cd1aa24166b3":
      break;
    default:

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:x85>" + trigger_name + "<dev string:x5b>");

      break;
  }
}

function private function_f2a2832d(player, msg) {
  switch (msg) {
    case # "triton_on":
      function_b6407dd4(1);
      break;
    case # "triton_off":
      function_b6407dd4(0);
      break;
    case # "intro_trans_out":
      level notify(#"intro_trans_out");
      break;
    case # "hash_443db59c2d746e0f":
      function_5ea2c6e3("cp_takedown_bar_intro");
      break;
    case # "hash_1ef4e0d9441579d":
      function_ed62c9c2("cp_takedown_bar_intro");
      break;
    case # "cp_takedown_raid_af_transition":
      function_5ea2c6e3("cp_takedown_raid_af_transition");
      break;
    case # "cp_takedown_raid_af_transition_complete":
      function_ed62c9c2("cp_takedown_raid_af_transition");
      break;
    case # "hit3_fadein":
      thread function_8881654();
      break;
    case # "af_intro_camera_whoosh":
      snd::play("evt_tkd_af_intro_camera_whoosh");
      break;
    case # "af_intro_done":
      wait 5;
      level notify(#"hash_50385173feb854f0");
      break;
    case # "af_init":
      break;
    case # "snd_overlook_scene":
      thread function_2f088c3f();
      thread function_9c9fad4e();
      break;
    case # "start_sniping":
      level notify(#"start_sniping");
      break;
    case # "hash_1533b6e574c5cfe7":
      thread function_204b1d87();
      thread function_2d5baabb();
      break;
    case # "hash_3620fe1626778dde":
      level notify(#"hash_2501fef6c47895fa");
      break;
    case # "hash_1e58e46360c0a83b":
      level notify(#"hash_1e58e46360c0a83b");
      function_5ea2c6e3("cp_tkdn_af_tarmac_combat", 1, 1);
      break;
    case # "af_truck_plr_in":
      function_ed62c9c2("cp_tkdn_af_tarmac_combat", 4);
      function_5ea2c6e3("cp_tkdn_af_chase_mix", 4, 1);
      snd::play([4, "evt_tkd_chase_start_peel_out"], [level.var_5acf72ee, "tag_axel_front_up"]);
      break;
    case # "plane_chase":
      function_5ea2c6e3("cp_tkdn_af_hill_plane", 0, 1);
      break;
    case # "hash_1bdccb03a5e24d52":
      function_ed62c9c2("cp_tkdn_af_hill_plane", 2);
      break;
    case # "hash_706ce4bbfd6f3342":
      break;
    case # "af_skid":
      break;
    case # "af_skid_starting":
      thread function_41798e8d();
      break;
    case # "af_skid_complete":
      function_ed62c9c2("cp_tkdn_af_chase_mix", 3);
      level notify(#"hash_accff44c369c030");
      break;
    case # "plane_idle":
      thread function_2d8bbe54(0.5);
      break;
    case # "start_plane_rev":
      break;
    case # "hash_164bf872d25545af":
      level notify(#"hash_2b1ea816682de37d");
      level notify(#"hash_6f65948492627624");
      thread function_b5f89c52(level.cargo_plane);
      thread function_b5f89c52(level.var_5acf72ee);
      thread function_b5f89c52(level.rc_car_plr);
      function_ed62c9c2("cp_tkdn_af_chase_rcxd_mix", 0.25);
      level thread function_721eb243();
      break;
    case # "af_wreck":
      break;
    case # "af_wreck_amb":
      level thread af_wreck_amb();
      break;
    case # "af_wreck_amb_end":
      level notify(#"af_wreck_amb_end");
      break;
    case # "end_fadeout":
      thread function_4df43a5e();
      break;
    case # "unlock_all_takedownmus":
      function_2cca7b47(0, #"musictrack_cp_takedown_1");
      function_2cca7b47(0, #"musictrack_cp_takedown_2");
      function_2cca7b47(0, #"musictrack_cp_takedown_3");
      function_2cca7b47(0, #"musictrack_cp_takedown_4");
      function_2cca7b47(0, #"musictrack_cp_takedown_5");
      function_2cca7b47(0, #"musictrack_cp_takedown_6");
      function_2cca7b47(0, #"musictrack_cp_takedown_7");
      break;
    default:

      snd::function_81fac19d(snd::function_d78e3644(), "<dev string:xa9>" + snd::function_783b69(msg, "<dev string:x5b>"));

      break;
  }
}

function xhair() {
  self endon(#"death");
  self endon(#"hash_2caeecd393c68946");

  while(isDefined(self) && isDefined(self.origin) && isDefined(self.angles)) {
    snd::debugcrosshair(self.origin, 24, self.angles, (1, 1, 1), 1, 0, 1);
    waitframe(1);
  }
}

function function_5f2fe011() {
  level notify(#"hash_35cd09591f62802f");
  level endon(#"hash_35cd09591f62802f");

  while(true) {
    if(snd::function_95c9af4b() >= 2) {
      foreach(var_15df3e17 in level.var_b9a192d2) {
        if(isDefined(var_15df3e17) && isDefined(var_15df3e17.var_90c86b97)) {
          velocity = var_15df3e17.var_90c86b97 getvelocity();

          if(isvec(velocity)) {
            speed = length(velocity);
            txt = "<dev string:xc7>" + snd::function_d6053a8f(speed, 1);
            pos = var_15df3e17.origin + (0, 0, 6);
            snd::print3dplus(txt, pos, 0.333, "<dev string:xd2>");
          }
        }
      }
    }

    waitframe(1);
  }
}

function function_b3fdcb06(ent, var_9e542947, var_e03252b9) {
  if(snd::function_a6779cbd(ent.var_726d44d2)) {
    return;
  }

  ent.var_726d44d2 = snd::play(var_e03252b9, [ent, var_9e542947]);
  snd::function_f4f3a2a(ent.var_726d44d2, ent);

  if(!isinarray(level.var_b9a192d2, ent.var_726d44d2)) {
    level.var_b9a192d2[level.var_b9a192d2.size] = ent.var_726d44d2;
  }
}

function function_244835ac(ent, var_7eaf9fa5) {
  var_1cafb128 = [[ent, "tag_wheel_front_left"], [ent, "tag_wheel_front_right"], [ent, "tag_wheel_back_left"], [ent, "tag_wheel_back_right"]];

  if(isarray(ent.var_f4728878) && ent.var_f4728878.size > 0) {
    return;
  }

  ent.var_f4728878 = [];

  foreach(var_60213bf0 in var_1cafb128) {
    var_d3d66b01 = snd::play(var_7eaf9fa5, var_60213bf0);
    snd::function_f4f3a2a(var_d3d66b01, ent);
    ent.var_f4728878[ent.var_f4728878.size] = var_d3d66b01;

    if(!isinarray(level.var_b9a192d2, var_d3d66b01)) {
      level.var_b9a192d2[level.var_b9a192d2.size] = var_d3d66b01;
    }
  }
}

function function_d942b1c8(ent, var_9e542947, sndalias) {
  if(snd::function_a6779cbd(ent.var_726d44d2)) {
    return;
  }

  sndtarget = [ent, var_9e542947];
  ent.var_726d44d2 = snd::play(sndalias, sndtarget);
  snd::function_f4f3a2a(ent.var_726d44d2, ent);

  if(!isinarray(level.var_b9a192d2, ent.var_726d44d2)) {
    level.var_b9a192d2[level.var_b9a192d2.size] = ent.var_726d44d2;
  }
}

function function_721eb243(fade_out = 0.5) {
  arrayremovevalue(level.var_b9a192d2, undefined);

  foreach(var_15df3e17 in level.var_b9a192d2) {
    snd::stop(var_15df3e17, fade_out);
  }

  level.var_b9a192d2 = [];
}

function function_8881654() {
  audio::snd_set_snapshot("cp_tkdn_hit3_intro_fadein");
  wait 20;
  level notify(#"hash_27298c361adda6c1");
}

function function_2f088c3f() {
  wait 5;
  function_5ea2c6e3("cp_tkdn_af_hill");
  level waittill(#"start_sniping");
  function_ed62c9c2("cp_tkdn_af_hill");
}

function function_9c9fad4e() {
  level endoncallback(&function_d111fa29, #"start_sniping");
  player = getlocalplayers()[0];
  player endon(#"death");
  function_5ea2c6e3("cp_tkdn_af_hill_binoculars", 0, 0);
  setsoundcontext("vehicle", "interior");

  while(true) {
    camera_zoom = player waittill(#"camera_zoom");
    function_672403ca("cp_tkdn_af_hill_binoculars", float(player function_8e4cd43b()) / 1000, camera_zoom.pct);
  }
}

function function_d111fa29(str_notify) {
  function_ed62c9c2("cp_tkdn_af_hill_binoculars");
}

function function_2d5baabb() {
  function_5ea2c6e3("cp_tkdn_af_hill_bullettime");
  level waittill(#"hash_2501fef6c47895fa");
  function_ed62c9c2("cp_tkdn_af_hill_bullettime", 1);
}

function function_41798e8d() {
  function_5ea2c6e3("cp_tkdn_af_skid");
  level waittill(#"hash_accff44c369c030");
  function_ed62c9c2("cp_tkdn_af_skid");
}

function function_4df43a5e() {
  function_5ea2c6e3("cp_tkdn_end_fadeout");
}

function function_a43c0d2c() {
  walla_pos = (-49666.6, -55444, -25160.2);
  var_2a88513c = (-49790, -55098, -25110.7);
  walla = snd::play("emt_tkd_walla_plane_workers_lp", walla_pos);
  loaders = snd::play("emt_tkd_cargo_loading_vehicles_lp", var_2a88513c);
  level waittill(#"hash_1e58e46360c0a83b");
  snd::stop(walla, 1);
  snd::stop(loaders, 1);
  wait 1.1;
  var_913d2991 = snd::play("emt_tkd_walla_runway_panic", walla_pos);
}

function function_5be14e40() {
  while(!isDefined(level.cargo_plane)) {
    waitframe(1);
  }
}

function function_53c8ee41() {
  while(!isDefined(level.cargo_plane_mover)) {
    waitframe(1);
  }
}

function function_955f4842() {
  if(is_true(level.var_1c393e86)) {
    return;
  }

  level.var_1c393e86 = 1;
  function_5be14e40();
  start = snd::play("veh_tkd_af_cargo_plane_start", [level.cargo_plane, (288, 0, 108)]);
  thread function_2d8bbe54(3);
}

function function_2d8bbe54(wait_time) {
  if(is_true(level.var_3f10e8f2)) {
    return;
  }

  level.var_3f10e8f2 = 1;
  function_5be14e40();
  wait_time = snd::function_ea2f17d1(wait_time, 0.5);
  level.var_2d8bbe54 = snd::play("veh_tkd_af_cargo_plane_idle_lp", [level.cargo_plane, (288, 0, 108)]);
  snd::set_volume(level.var_2d8bbe54, 0);
  snd::set_pitch(level.var_2d8bbe54, 1);
  wait wait_time;
  snd::set_volume(level.var_2d8bbe54, 1, 0.5);
  level waittill(#"cargo_plane_takeoff");
  snd::set_pitch(level.var_2d8bbe54, 2, 1.5);
  snd::stop(level.var_2d8bbe54, 5);
}

function function_e9cf99c1() {
  if(is_true(level.var_b2f77aec)) {
    return;
  }

  level.var_b2f77aec = 1;
  function_5be14e40();
  snd::play("veh_tkd_af_cargo_plane_accelerate", [level.cargo_plane, (288, 0, 108)]);
  level notify(#"hash_5b80aed93a868b80");
}

function cargo_plane_takeoff() {
  if(is_true(level.var_72cef6cb)) {
    return;
  }

  level.var_72cef6cb = 1;
  function_53c8ee41();
  snd::play("veh_tkd_af_cargo_plane_takeoff", [level.cargo_plane_mover, (288, 0, 108)]);
  waitframe(3);
  level notify(#"cargo_plane_takeoff");
}

function function_d1b165f5() {
  if(is_true(level.var_ea29c588)) {
    return;
  }

  level.var_ea29c588 = 1;
  function_53c8ee41();
  level thread function_b3fdcb06(level.cargo_plane_mover, (288, 0, 108), "veh_tkd_af_cargo_plane_high_lyr1_lp");
}

function function_204b1d87() {
  snd::play("evt_bullettime_shot_main");
}

function function_4e08ef9b() {
  wait 4;
  snd::play("evt_tkd_chase_start_peel_out");
}

function function_b5f89c52(veh) {
  if(isDefined(veh) && isDefined(veh.var_e59bc220)) {
    veh notify(#"hash_79d732c6bc0d7bd1");
    snd::stop(veh.var_e59bc220, 0.5);
    veh.var_e59bc220 = undefined;
  }
}

function function_81191c8a() {
  while(!isDefined(level.rc_car_plr)) {
    waitframe(1);
  }
}

function function_e8df4c70() {
  if(is_true(level.var_b7589e37)) {
    return;
  }

  level.var_b7589e37 = 1;
  function_81191c8a();
  snd::play([1.1, "wpn_tkd_rcxd_deploy_drop", 0], level.rc_car_plr);
  function_5ea2c6e3("cp_tkdn_af_chase_rcxd_mix", 1, 1);
  function_d942b1c8(level.rc_car_plr, "tag_suspension_front", "wpn_tkd_rcxd_veh_high_lp");
  function_ed62c9c2("cp_tkdn_af_rc_chase_tires", 3);
}

function function_b233d29e(wait_time = 1, fade_time = 0) {
  var_f3c1505b = snd::play("wpn_tkd_rcxd_static_fuzz_lp");
  wait wait_time;
  snd::stop(var_f3c1505b, fade_time);
  var_f3c1505b = undefined;
}

function function_7142e76c(veh) {
  level endon(#"hash_2b1ea816682de37d");

  while(isentity(veh)) {
    snd::play("veh_tkd_chase_npc_jeeps_skid_stop", [veh, (0, 0, 9)]);
    wait 1;
  }
}

function cargo_debris(ent) {
  if(!isDefined(ent.var_a107d844)) {
    var_a107d844 = snd::play("phy_tkd_prop_vel_debris_lp", ent);
    snd::function_f4f3a2a(var_a107d844, ent);
  }
}

function af_wreck_amb() {
  var_a27674c9 = snd::play("emt_tkd_wreck_fire_01_lp", (10461, -54901, -25182));
  var_d96e62bc = snd::play("emt_tkd_wreck_fire_02_lp", (10738, -54523, -25136));
  var_c6a73d2e = snd::play("emt_tkd_wreck_fire_03_lp", (10648, -55102, -25155));
  metal = snd::play("emt_tkd_wreck_metal_lp", (10261, -54762, -25082));
  var_47cd46cf = snd::play("emt_tkd_wreck_sirens_01_lp", (10491, -53575, -25003));
  var_630e7d51 = snd::play("emt_tkd_wreck_sirens_02_lp", (15160, -54833, -24566));
  var_f07a182a = snd::play("emt_tkd_wreck_sirens_03_lp", (-4034, -49059, -24440));
  level waittill(#"af_wreck_amb_end");
  snd::stop(var_a27674c9, 3);
  snd::stop(var_d96e62bc, 3);
  snd::stop(var_c6a73d2e, 3);
  snd::stop(metal, 3);
  snd::stop(var_47cd46cf, 3);
  snd::stop(var_630e7d51, 3);
  snd::stop(var_f07a182a, 3);
}