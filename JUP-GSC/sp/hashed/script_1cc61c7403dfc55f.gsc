/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_1cc61c7403dfc55f.gsc
*************************************************/

#using script_1031976741eb6674;
#using script_5d5405089d04628b;
#using script_60add030ce1a42b6;
#using script_7295d46a1f0881ad;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\math;
#using scripts\engine\sp\objectives;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\hud_util;
#using scripts\sp\maps\sp_jup_tundra\sp_jup_tundra_fx;
#using scripts\sp\spawner;
#using scripts\sp\utility;
#namespace namespace_5f9a73fb2d310d21;

function function_76c3e2d954ced8c7() {
  level.player thread scripts\sp\hud_util::fade_in(0, "white");
}

function function_edd86bdc9ab6ce10() {
  level endon("scene_0200_igc_skip");
  level.var_7867f48e589b8b2f = getStruct("scene_jup_tun_0200_igc_forest_reveal", "targetname");
  var_35aceabc918fbab = [level.soap, level.gaz, level.shepherd];
  level.var_7867f48e589b8b2f scene::pre_stream(var_35aceabc918fbab, undefined, -1);
  level.player scripts\sp\hud_util::fade_out(0.1, "white");
  wait 3;

  if(isplatformxb3() || isplatformps4()) {
    wait 5;
  }

  level.player scripts\common\utility::letterbox_enable(1, 0);
  setsaveddvar(@ "hash_778bcbeae85e456", 0);
  level notify("audio_clear_vip_rescue_mute");
  level.soap thread function_47ae8adf3a22eefa("stop_soap_anim", "soap");
  level.gaz thread function_47ae8adf3a22eefa("stop_gaz_anim", "gaz");
  level thread function_cb4146f2c8c93b80();
  level thread function_35f101ac76edbed9();
  level thread function_2a0f6f73d9ae3ba4();
  level thread function_3b55a289eb2eb22();
  level.player hideviewmodel();
  level thread namespace_f74ba02cf5fc717a::function_864a8e9188f7b036();
  level.var_7867f48e589b8b2f scene::pre_stream(var_35aceabc918fbab, undefined, 0.1);
  level delaythread(1, &function_76c3e2d954ced8c7);
  level.var_7867f48e589b8b2f scene::play(var_35aceabc918fbab);
  player_start = level.var_7867f48e589b8b2f scene::get_entity("price_igc");
  level.player teleport_player(player_start);
  player_start delete();
  level.player showviewmodel();
  level flag_set("scene_0200_igc_done");
  setsaveddvar(@ "hash_778bcbeae85e456", 1);
  level.shepherd thread function_1a2cafa1538df9a();
}

function scene_0200_igc_skip() {
  level flag_set("scene_0200_igc_skip");
  level.var_7867f48e589b8b2f scene::stop();
  level.player scripts\sp\hud_util::fade_out(0.1, "black");
  wait 4;
  level.player thread scripts\sp\hud_util::fade_in(2, "black");
  set_start_location("s_start_forest_walk", [level.player]);
  set_start_location("s_start_forest_walk", level.tundra_allies);
  level.player showviewmodel();
  level flag_set("scene_0200_igc_done");
  level.player scripts\common\utility::letterbox_enable(0, 1.5);
}

function function_35f101ac76edbed9() {
  level.var_7867f48e589b8b2f scene::init();
  level.var_7867f48e589b8b2f scene::function_8207074e79f22926(self, "swap_tundra_loadout", "price_igc");
  price = level.var_7867f48e589b8b2f scene::get_entity("price_igc");
  soap = level.var_7867f48e589b8b2f scene::get_entity("soap");
  gaz = level.var_7867f48e589b8b2f scene::get_entity("gaz");
  soap gun_remove();
  self waittill("swap_shep_loadout");
  soap gun_recall();
}

function function_cb4146f2c8c93b80() {
  level.var_7867f48e589b8b2f scene::init();
  level.var_7867f48e589b8b2f scene::function_8207074e79f22926(self, "swap_shep_loadout", "shepherd");
  shep = level.var_7867f48e589b8b2f scene::get_entity("shepherd");
  shep setModel("body_c_jup_sp_hero_shepherd_tundra_frost_nobag");
  self waittill("swap_shep_loadout");
  shep setModel("body_c_jup_sp_hero_shepherd_tundra");
}

function function_2a0f6f73d9ae3ba4() {
  level.var_7867f48e589b8b2f scene::init();
  level.var_7867f48e589b8b2f scene::function_8207074e79f22926(self, "scope_hud_on", "shepherd");
  level.var_7867f48e589b8b2f scene::function_8207074e79f22926(self, "scope_hud_off", "shepherd");
  self waittill("scope_hud_on");
  setomnvar("ui_reticle_overlay_visibility", 1);
  self waittill("scope_hud_off");
  waitframe();
  setomnvar("ui_reticle_overlay_visibility", 0);
}

function function_47ae8adf3a22eefa(note_name, actor_name) {
  level.var_7867f48e589b8b2f scene::init();
  level.var_7867f48e589b8b2f scene::function_8207074e79f22926(self, note_name, actor_name);
  self waittill(note_name);
  utility::anim_stopanimScripted();
  thread function_1a2cafa1538df9a();
}

function function_1a2cafa1538df9a() {
  namespace_8339f6377b6ba60e::function_c9317b6d58796509(1, "cqb");
  start_struct = namespace_8339f6377b6ba60e::function_bdc421f433af10c7("s_start_forest_walk");
  thread namespace_ed524932b773201d::function_f47ac0cf45308c8b(start_struct);
}

function function_3b55a289eb2eb22() {
  level.var_7867f48e589b8b2f scene::function_8207074e79f22926(self, "letterbox_end", "shepherd");
  self waittill("letterbox_end");
  level.player scripts\common\utility::letterbox_enable(0, 1.5);
}

function scene_0220() {}

function function_cb6b292df2221e6d() {}

function function_da7a442dfd5f9958() {
  nd_lumbermill_farah_end_teleport = getnode("nd_lumbermill_farah_end_teleport", "targetname");
  var_6b905f8e4fce414d = getStruct("scene_jup_tun_0310_mill_regroup", "targetname");
  var_6b905f8e4fce414d function_8207074e79f22926(level, "farah_on_ground", "farah");
  var_6b905f8e4fce414d function_8207074e79f22926(level, "farah_moving_to_goal", "farah");
  flag_wait("flag_lumbermill_exit_farah_rappel_ready");
  level.farah teleport_ai(nd_lumbermill_farah_end_teleport);
  level.farah thread function_7adcaa4550ec8058();
  playFXOnTag(level._effect["vfx_tun_env_snow_chunks_fall_3"], level.farah, "tag_origin");
  exploder("vfx_snow_stomp");
  var_6b905f8e4fce414d scene::play(level.farah, "shot_010");
}

function function_7adcaa4550ec8058() {
  nd_lumbermill_farah_end_goal = getnode("nd_lumbermill_farah_end_goal", "targetname");
  level waittill("farah_on_ground");
  level.farah setgoalnode(nd_lumbermill_farah_end_goal);
  level utility::flag_set("flag_lumbermill_farah_on_ground");
  level waittill("farah_moving_to_goal");
  level utility::flag_set("flag_lumbermill_farah_moving_to_goal");
}

function function_da87b62dfd6ea893() {}

function scene_0330() {}

function scene_0340() {}

function function_e9926b2e08a74d55() {}

function scene_0510() {}

function scene_0520() {}

function function_f65d0e2e1166a17c() {
  level function_e75147885cfd6230();
  level.var_dffb3cd38cb1accf = getStruct("scene_jup_tun_0530_shipyard_equip", "targetname");
  level.var_dffb3cd38cb1accf scene::function_8207074e79f22926(level.player, "spotter_scope_raised", "player");
  level.var_dffb3cd38cb1accf scene::function_8207074e79f22926(level.player, "spotter_scope_lowered", "player");
  level.var_dffb3cd38cb1accf scene::function_8207074e79f22926(level.player, "apc_fire_1", "player", 1);
  level.var_dffb3cd38cb1accf scene::function_8207074e79f22926(level.player, "apc_fire_2", "player", 1);
  level.var_dffb3cd38cb1accf scene::function_8207074e79f22926(level.player, "apc_fire_3", "player", 1);
  level.var_dffb3cd38cb1accf scene::function_8207074e79f22926(level.player, "end", "player", 1);
  level.var_dffb3cd38cb1accf scene::function_8207074e79f22926(level.ghost, "ghost_drop_flare");
  level flag_wait("flag_finale_player_has_spotter_scope");
  level.var_dffb3cd38cb1accf scene::function_8207074e79f22926(level.soap, "end", "soap");
  level.var_dffb3cd38cb1accf scene::function_8207074e79f22926(level.gaz, "end", "gaz");
  level.var_dffb3cd38cb1accf scene::function_8207074e79f22926(level.farah, "end", "farah");
  level.soap setcanusecover(0);
  level.gaz setcanusecover(0);
  level.farah setcanusecover(0);
  level.var_dffb3cd38cb1accf thread scene::play(undefined, "interact");
  level.player waittill("spotter_scope_raised");
  level function_d379f06b6658f81d(1);
  level.player waittill("spotter_scope_lowered");
  level function_d379f06b6658f81d(0);
  scope = level.var_dffb3cd38cb1accf scene::get_entity("shipyard_scope");
  scope delete();
  level.player waittill("end");
  flag_set("flg_finale_signal_player_released");
  deactivateworldevent("shep_boat", 1);
}

function function_43b27a4ee8fb5fac() {
  self endon("death");
  level endon("flag_finale_player_has_spotter_scope");
  level flag_wait("flag_finale_signal_02");
  shotname = self.animname + "_enter";

  if(isDefined(level.var_dffb3cd38cb1accf)) {
    level.var_dffb3cd38cb1accf childthread scene::play(self, shotname);
  }
}

function function_f658882e116184f3() {
  var_7fa66655bd7548cb = getStruct("scene_jup_tun_0540_shipyard_plant_c4_01", "targetname");
  var_46ffca7b8dfaf809 = getStruct("scene_jup_tun_0540_shipyard_plant_c4_02", "targetname");
  var_6c3d6bd4b20579fa = getStruct("scene_jup_tun_0540_shipyard_plant_c4_03", "targetname");
  var_7fa66655bd7548cb thread function_10c00af5cb056955(level.farah, ["flag_finale_sniper_vanguard_wave_2", "flag_finale_sniper_stop_c4_farah"], 10, 11);
  var_46ffca7b8dfaf809 thread function_10c00af5cb056955(level.gaz, ["flag_finale_sniper_vanguard_wave_2", "flag_finale_sniper_stop_c4_gaz", "flag_finale_enemy_jltv_halfway"], 15, 16);
  var_6c3d6bd4b20579fa thread function_10c00af5cb056955(level.soap, ["flag_finale_sniper_vanguard_wave_2", "flag_finale_sniper_upper_docks_enemies", ""], 20, 22);
}

function function_10c00af5cb056955(var_cb073298c9145a1b, var_2c4e646d778632df, var_b1ef60b4aa0fed6b, var_b1cb76b4a9e7a315) {
  var_b1ef60b4aa0fed6b = default_to(var_b1ef60b4aa0fed6b, 1);
  var_b1cb76b4a9e7a315 = default_to(var_b1cb76b4a9e7a315, 3);
  var_cb073298c9145a1b.disableplayeradsloscheck = 1;
  var_cb073298c9145a1b.allowpain = 0;
  var_cb073298c9145a1b.pushable = 0;
  var_cb073298c9145a1b pushplayer(1);
  unit_vector = vectorNormalize(self.origin - var_cb073298c9145a1b.origin);
  next_position = var_cb073298c9145a1b.origin + unit_vector * 350;
  var_cb073298c9145a1b set_goal_pos(next_position);
  wait 0.05;

  if(isDefined(var_2c4e646d778632df)) {
    if(isarray(var_2c4e646d778632df)) {
      flag_wait_any_array(var_2c4e646d778632df);
    } else {
      flag_wait(var_2c4e646d778632df);
    }
  } else {
    var_96ea09a26af3ce17 = randomintrange(var_b1ef60b4aa0fed6b, var_b1cb76b4a9e7a315);
    wait var_96ea09a26af3ce17;
  }

  var_cb073298c9145a1b ent_flag_set("flag_finale_sniper_ally_plant_c4_end");
  nd_end = var_cb073298c9145a1b function_bdc421f433af10c7("nd_finale_sniper_ally_start");
  var_3d341e21c91a0ffc = var_cb073298c9145a1b function_4d00a50f479bbc96(nd_end);

  if(isDefined(var_3d341e21c91a0ffc)) {
    var_cb073298c9145a1b spawner::go_to_node(var_3d341e21c91a0ffc);
  }

  var_cb073298c9145a1b setgoalpos(var_cb073298c9145a1b.origin);
  var_cb073298c9145a1b setgoalnode(nd_end);
  var_cb073298c9145a1b set_goalRadius(32);
  var_cb073298c9145a1b set_movement_speed(200);
  var_cb073298c9145a1b enable_sprint();
  var_cb073298c9145a1b waittill("goal");
  var_cb073298c9145a1b.disableplayeradsloscheck = 0;
  var_cb073298c9145a1b.allowpain = 1;
  var_cb073298c9145a1b disable_sprint();
  var_cb073298c9145a1b utility::clear_movement_speed();
  var_cb073298c9145a1b.pushable = 1;
  var_cb073298c9145a1b pushplayer(0);
}

function function_4d00a50f479bbc96(nd_end) {
  level.player endon("death");
  vehicle = scripts\engine\sp\utility::get_vehicle("veh_finale_sniper_enemy_jltv_vanguard_right", "targetname");

  if(isDefined(vehicle)) {
    player_enemy = vehicle;
  } else {
    player_enemy = utility::get_closest_ai(level.player.origin, "axis");
  }

  p1 = (self.origin[0], self.origin[1], 0);
  p2 = (nd_end.origin[0], nd_end.origin[1], 0);
  p3 = (level.player.origin[0], level.player.origin[1], 0);
  p4 = (player_enemy.origin[0], player_enemy.origin[1], 0);
  a_results = scripts\engine\utility::closestdistancebetweensegments(p1, p2, p3, p4);

  if(a_results[2] < 1) {
    var_3d341e21c91a0ffc = function_bdc421f433af10c7("s_finale_sniper_ally_alt_path");
    return var_3d341e21c91a0ffc;
  }

  return undefined;
}

function function_1ee4da427d3f7915() {
  switch (self.animname) {
    case #"hash_4ba1525745ce470f":
      var_bef3cec2e7b658de = getStruct("s_finale_c4_farah", "script_noteworthy");
      break;
    case #"hash_fb36726c0708cd6d":
      var_bef3cec2e7b658de = getStruct("s_finale_c4_gaz", "script_noteworthy");
      break;
    case #"hash_df31f98a0b34e496":
    default:
      var_bef3cec2e7b658de = getStruct("s_finale_c4_soap", "script_noteworthy");
      break;
  }

  var_dbaf3398f6b83f78 = spawn("script_model", var_bef3cec2e7b658de.origin);
  var_dbaf3398f6b83f78.angles = var_bef3cec2e7b658de.angles;
  var_dbaf3398f6b83f78 setModel("offhand_2h_c4_prop");
  var_dbaf3398f6b83f78.owner = self;
  level.finale_c4 = array_add(level.finale_c4, var_dbaf3398f6b83f78);
}

function scene_0610() {}

function scene_0620() {}

function function_4e8352e1c130399() {}

function function_2e1a40dfed2f8624() {
  wait 4;
  level.nikolai_heli = self;
  level.nikolai_heli thread function_b53dcf20e51bed1();
  level thread namespace_f74ba02cf5fc717a::function_a08690148d25a40e();
  level.nikolai_heli setlookattext("Nikolai", &"SP_JUP_TUNDRA/YANKEE7");
}

function scene_1000() {
  level flag_set("flag_finale_exfil_heli_land_begin");
  var_3a465e75b646f5d4 = getStruct("scene_jup_tun_1000_igc_outro", "targetname");
  wait 1;
  var_3a465e75b646f5d4 scene::function_8207074e79f22926(level.player, "igc_start_fadeout", "heli");
  var_3a465e75b646f5d4 scene::function_8207074e79f22926(level.player, "heli_near_landing", "heli");
  var_3a465e75b646f5d4 scene::add_spawn_function(&function_2e1a40dfed2f8624, "heli");
  shots = ["sh010", "sh020", "sh030"];
  var_3a465e75b646f5d4 scene::play(undefined, "enter");
  var_3a465e75b646f5d4 thread scene::play(undefined, "idle");
  level.nikolai_heli thread function_b53dcf20e51bed1();
  level flag_set("flag_finale_exfil_heli_land_end");
  level flag_wait("flag_finale_exfil_outro_begin");
  showcinematicletterboxing(1.5, 0);
  wait 0.35;
  level.player hideviewmodel();
  var_3a465e75b646f5d4 thread scene::play(undefined, shots);
  level.player waittill("igc_start_fadeout");
  level thread namespace_f74ba02cf5fc717a::function_fe45177bf22323f9();
  blackoverlay = scripts\sp\hud_util::create_client_overlay("black", 0);
  blackoverlay.alpha = 1;
  var_3a465e75b646f5d4 thread function_52e0f6bb6e242152();
  wait 2;
  blackoverlay destroy();
  hidecinematicletterboxing(1.5, 0);
  level flag_set("flag_finale_exfil_complete");
  level.nikolai_heli = undefined;
}

function function_52e0f6bb6e242152() {
  level.player scripts\common\utility::letterbox_enable(0, 0);
  scene::cleanup(1);
  var_edeb7bcbfc7219ee = getEnt("igc_c4_prop", "targetname");

  if(isDefined(var_edeb7bcbfc7219ee)) {
    var_edeb7bcbfc7219ee delete();
  }

  level.player clearcinematicmotionoverride();
}

function function_13ec8f8aac892fe0() {}

function function_319c2f097ede51e0(targetname, entities, shot, playrate) {
  animnode = getStruct(targetname, "targetname");

  if(isDefined(playrate)) {
    animnode scene::set_anim_rate(playrate);
  }

  animnode scene::play(entities, shot);
}

function function_57ac36ea7abb5af4(targetname, entities, shots) {
  if(isDefined(targetname)) {
    function_319c2f097ede51e0(targetname, entities, shots);
  } else {
    scene::play(entities, shots);
  }

  self notify("scene_complete");
}

function function_96cef8a436875213(targetname, entities) {
  if(isDefined(targetname)) {
    animnode = getStruct(targetname, "targetname");
  } else {
    animnode = self;
  }

  animnode function_57ac36ea7abb5af4(undefined, entities, "enter");
  animnode thread scene::play(entities, "loop");
}

function function_d632c8ec5db9c014(fadeintime, var_8fdcc47e02a1d9d3) {
  fadeintime = default_to(fadeintime, 2);
  var_8fdcc47e02a1d9d3 = default_to(var_8fdcc47e02a1d9d3, 3);
  blackoverlay = scripts\sp\hud_util::create_client_overlay("black", 1);
  wait var_8fdcc47e02a1d9d3;
  blackoverlay fadeovertime(fadeintime);
  blackoverlay.alpha = 0;
  blackoverlay delaycall(fadeintime, &destroy);
}

function function_d3ee4f81e23ab8b4(waittime) {
  self endon("<dev string:x1c>");
  waittime = default_to(waittime, 1);

  while(true) {
    if(!isDefined(self)) {
      break;
    }

    wait waittime;
    draw_circle(self.origin, 20, (241, 255, 0), undefined, undefined, 100);
  }
}

function function_e75147885cfd6230() {
  level function_22ca9da12c92561b();
}

function function_d379f06b6658f81d(b_visible) {
  if(b_visible) {
    level.player scripts\sp\hud_util::fade_out(0.1, "black");
    function_683d335ce7f9c3b2();
    level.player hideviewmodel();
    wait 0.1;
    level.player thread scripts\sp\hud_util::fade_in(0.1, "black");
    return;
  }

  level.player scripts\sp\hud_util::fade_out(0.1, "black");
  function_65231fa5ac96c7e7();
  level.player showviewmodel();
  wait 0.1;
  level.player thread scripts\sp\hud_util::fade_in(0.1, "black");
}

function function_22ca9da12c92561b() {
  overlay = newhudelem();
  overlay.x = 292;
  overlay.y = 60;
  overlay.alignx = "center";
  overlay.aligny = "middle";
  overlay.font = "smallfixed";
  overlay.fontscale = 0.75;
  overlay.alpha = 0;
  goggles = scripts\sp\hud_util::create_client_overlay("nightvision_overlay_goggles_grain", 1);
  goggles.alpha = 0;
  level.var_2d18a67266052588 = [goggles, overlay];
}

function function_65231fa5ac96c7e7() {
  setomnvar("ui_spotter_scope_toggle_visibility", 0);

  if(isDefined(level.var_2d18a67266052588)) {
    foreach(thing in level.var_2d18a67266052588) {
      thing.alpha = 0;
    }
  }
}

function function_683d335ce7f9c3b2() {
  setomnvar("ui_spotter_scope_toggle_visibility", 1);

  if(isDefined(level.var_2d18a67266052588)) {
    foreach(thing in level.var_2d18a67266052588) {
      thing.alpha = 1;
    }
  }
}