/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_151f37cd7136b363.gsc
*************************************************/

#using script_2dcc22f11f14cb9;
#using script_389a9d54d8274d2a;
#using script_3ef1b643f06851a8;
#using script_49511723a3204d35;
#using script_575fda2758b0a36e;
#using scripts\anim\dialogue;
#using scripts\anim\shared;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\game\sp\door;
#using scripts\sp\gibbing;
#using scripts\sp\hud_util;
#using scripts\sp\outline;
#using scripts\sp\player;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\player_death;
#using scripts\sp\player_rig;
#using scripts\sp\spawner;
#using scripts\sp\stealth\utility;
#using scripts\sp\utility;
#using scripts\stealth\utility;
#namespace namespace_ea4627b0281bb0a7;

function function_6e185e5e9d31a747() {}

function function_f8dd3611e9c34c96() {
  function_109726d29627f8de();
  level thread function_791c2eb990017928();
}

function function_374107677e68907f() {
  set_start_location("s_start_chunnel_intro", array_combine([level.player], level.var_679be75090dd2a47));
  setomnvar("ui_chyron_surge_chunnel", 1);
  flag_set("flg_chunnel_obj_start");
  player_door = getEnt("e_chunnel_intro_player_door_closed", "targetname");
  var_170446bac3ac8498 = getEnt("e_chunnel_intro_player_door_closed_clip", "targetname");
  player_door hide();
  var_170446bac3ac8498 notsolid();
  var_170446bac3ac8498 connectpaths();
  level thread namespace_85a51fd192b9a590::function_b61e1ad458f02511();
  level thread function_35dd19d7376bcf4();
  function_75519ed05932e7ac();
  function_bf06c28b392394ea();
  level.player scripts\sp\player::focusdisable();
  setsaveddvar(@ "hash_fa84e9dc55b9d406", 0);
  registered = "chunnel_intro_drive";
  level.player val::set(registered, "show_weapon_hud", 0);
  level.player val::set(registered, "show_hud", 0);
  level.player val::set(registered, "weapon", 0);
  level.player val::set(registered, "freezecontrols", 1);
  level notify("audio_chunnel_intro_igc_started");
  thread function_d8ff0f5de566c611();
  level thread function_85617ef2484fe085();

  if(!isplatformpc()) {
    setsaveddvar(@ "hash_7cae3a58007c1b7d", "33.33");
  }

  delaythread(30, &function_748164ff55c9ec50);
  function_3b2dcb215a17b132(level.var_46a738a8167e99b5);
  level flag_wait("scene_0400_igc_done");
  level flag_set("surge_chunnel_intro_igc_complete");

  if(!isplatformpc()) {
    setsaveddvar(@ "hash_7cae3a58007c1b7d", "16.66");
  }

  level.player val::set(registered, "show_weapon_hud", 1);
  level.player val::set(registered, "show_hud", 1);
  level.player val::set(registered, "weapon", 1);
  level.player val::set(registered, "freezecontrols", 0);
  setsaveddvar(@ "hash_fa84e9dc55b9d406", 1);
  level.player scripts\sp\player::focusenable();

  level thread function_c4bed616d3a3036c("<dev string:x1c>");
}

function function_d8ff0f5de566c611() {
  setmusicstate("mx_surge_chunnelIGC");
}

function function_bf06c28b392394ea() {
  array_spawn_function_targetname("sp_chunnel_sas_intro_charlie", &function_e8e02cb12ef545bf, "flg_service_tunnel_close");
  level.var_46a738a8167e99b5 = array_spawn_targetname("sp_chunnel_sas_intro_charlie", 1, 1);
}

function function_75aabf38fae94964() {}

function function_3fc8a536dbeae662() {
  function_109726d29627f8de();
  set_start_location("s_start_chunnel_intro", array_combine([level.player], level.var_679be75090dd2a47));
  player_door = getEnt("e_chunnel_intro_player_door_closed", "targetname");
  var_170446bac3ac8498 = getEnt("e_chunnel_intro_player_door_closed_clip", "targetname");
  player_door hide();
  var_170446bac3ac8498 notsolid();
  var_170446bac3ac8498 connectpaths();
  function_75519ed05932e7ac();
  function_bf06c28b392394ea();
  level thread function_791c2eb990017928();
  flag_set("flg_chunnel_obj_start");
  setomnvar("ui_chyron_surge_chunnel", 1);
  level.player setmovespeedscale(0.95);
}

function function_2dcfbff5767f7f73() {
  thread autosave_now();
  level thread namespace_fc0114e844f0b4c::function_91db77148cb4384d(undefined, undefined, "flag_chunnel_advance_stop_nags", "chunnel_advance_player_progress");
  level thread function_e61bffa0e41a86d1();
  level thread function_23d0e83df014aeaa();
  level thread function_23d0e73df014ac77();
  level thread function_73c708ca5e81be9d();
  level thread namespace_85a51fd192b9a590::function_976cfc1a562856ac();
  level thread namespace_85a51fd192b9a590::function_2c3b2fadd33defc1();

  if(level.start_point == "chunnel_advance") {
    while(true) {
      if(isDefined(level.var_d18d63c6d75cd1e) && isDefined(level.var_1dfec668afe59727)) {
        break;
      }

      waitframe();
    }
  }

  flag_clear("stealth_spotted");
  array_spawn_function_targetname("sp_chunnel_sas_intro_alpha", &function_bebee9102c947243);
  level.var_c1e9be5f5e50acc7 = array_spawn_targetname("sp_chunnel_sas_intro_alpha", 1, 1);
  level.var_c1e9be5f5e50acc7 = array_sort_by_script_index(level.var_c1e9be5f5e50acc7);
  level.var_c1e9be5f5e50acc7 function_fe677b3c2b5ce6bb();
  waitframe();
  array_spawn_function_targetname("sp_chunnel_sas_intro_bravo", &function_e8e02cb12ef545bf, "flg_service_tunnel_close");
  level.var_6e9a7059723ba287 = array_spawn_targetname("sp_chunnel_sas_intro_bravo", 1, 1);
  level.ai_ghost.allowstrafe = 1;
  level.ai_ghost thread function_aaa0caf8340c9d8d("nd_chunnel_intro_ghost_1");
  level.var_d18d63c6d75cd1e thread function_aaa0caf8340c9d8d("nd_chunnel_intro_gaz_1");
  level.ai_soap thread function_55ccd613cffb6f89("nd_chunnel_intro_soap_1");
  level.var_d18d63c6d75cd1e thread function_f19d721de81462d("flg_service_tunnel_close");
  level.ai_ghost thread function_f19d721de81462d("flg_service_tunnel_close");
  level thread function_91b576b5eeb70436();
  battlechatter_off("allies");
  flag_wait("flg_chunnel_intro_train_1_driveby");
  level thread function_43d75b4055ca3755();
  level function_87a70036926b2c90("chunnel_advance_player_progress");
  level thread function_8c51d81cc059da92();
  flag_wait("flg_chunnel_intro_first_train_allies_moveup");
  level thread chunnel_intro_track_allies_moveup();
  a_ai_allies = [level.ai_soap];
  a_ai_allies = array_combine(a_ai_allies, level.var_c1e9be5f5e50acc7);
  flag_wait("flg_chunnel_intro_track_start");
  level thread function_3f0c28307fa47c8b();
  autosave_by_name();
  level notify("audio_intro_train_mute_clear");
  level function_87a70036926b2c90("chunnel_advance_player_progress");
  level.var_1181f1897e13785c = [];
  array_spawn_function_targetname("sp_tunnel_intro_konni_track", &function_b40a0ed9ed9a158c);
  var_8f87e5aa4ac84b99 = array_spawn_targetname("sp_tunnel_intro_konni_track", 1, 1);
  level.var_1181f1897e13785c = array_combine(level.var_1181f1897e13785c, var_8f87e5aa4ac84b99);
  level thread function_ce0481962eaf7d5b();
  level thread function_3025ee051d28ec46(var_8f87e5aa4ac84b99, "flg_chunnel_intro_track_early_clear", var_8f87e5aa4ac84b99.size, "flg_chunnel_intro_track_flank");
  level thread function_22269c9927e4b379();
  msg = flag_wait_any_return("flg_chunnel_intro_track_laststand_right", "flg_chunnel_intro_track_laststand_left", "flg_chunnel_intro_track_early_clear");

  if(!flag("flg_chunnel_intro_track_allies_go_loud")) {
    flag_set("flg_chunnel_intro_track_allies_go_loud");
  }

  level thread function_826e1eda7a4c9086();

  if(msg != "flg_chunnel_intro_track_early_clear") {
    if(flag("flg_chunnel_intro_track_alerted")) {
      str_spawner = undefined;

      if(msg == "flg_chunnel_intro_track_laststand_left") {
        if(!flag("train_01_moving")) {
          str_spawner = "sp_tunnel_intro_konni_laststand_left";
          str_ref = "s_tunnel_intro_konni_laststand_left_ref";
        }
      } else {
        str_spawner = "sp_tunnel_intro_konni_laststand_right";
        str_ref = "s_tunnel_intro_konni_laststand_right_ref";
      }
    }
  }

  level.var_1181f1897e13785c = array_removedead(level.var_1181f1897e13785c);

  if(level.var_1181f1897e13785c.size > 0 || flag("flg_chunnel_intro_vents_start") || flag("flg_chunnel_intro_alt_vents_start")) {
    foreach(ai in level.var_1181f1897e13785c) {
      ai utility::set_attackeraccuracy(3);
    }

    while(level.var_1181f1897e13785c.size > 0) {
      if(flag("flg_chunnel_intro_vents_start") || flag("flg_chunnel_intro_alt_vents_start")) {
        break;
      }

      level.var_1181f1897e13785c = array_removedead(level.var_1181f1897e13785c);
      wait 0.5;
    }
  }

  flag_set("flg_chunnel_intro_track_complete");
  level function_d962f42ac75f265f("flag_chunnel_advance_stop_nags");
  level.var_1181f1897e13785c = array_removedead_or_dying(level.var_1181f1897e13785c);

  if(level.var_1181f1897e13785c.size > 0) {
    level thread utility::ai_delete_when_out_of_sight(level.var_1181f1897e13785c, 1024);

    foreach(ai in level.var_1181f1897e13785c) {
      ai ai::function_dd21d67ede8ba22(int(ai.health * 0.25) + 1);
      ai utility::set_baseaccuracy(0.5);
      ai utility::set_attackeraccuracy(5);
    }
  }

  level.var_1181f1897e13785c = undefined;
  level.var_6e9a7059723ba287 = undefined;
  level.var_46a738a8167e99b5 = undefined;
}

function function_73c708ca5e81be9d() {
  e_chunnel_precrossover_tunnel_mask = getEnt("e_chunnel_precrossover_tunnel_mask", "targetname");
  e_chunnel_precrossover_tunnel_mask movez(512, 0.1);
  flag_wait("flg_chunnel_crossover_open_door");
  e_chunnel_precrossover_tunnel_mask delete();
}

function function_e61bffa0e41a86d1() {
  namespace_15910f05e9978caa::function_9e29132d33b8fd8c();
  var_f00ca6de0506181b = getStruct("s_disabled_turret", "targetname");
  var_f00ca6de0506181b.var_2108ba0559bdaaff = &function_5e66cae8a3e9f368;
  level.disabled_turret = setup_enemy_sentry(var_f00ca6de0506181b);
  waitframe();
  level.disabled_turret namespace_15910f05e9978caa::sentry_shutdown();
}

function function_43d75b4055ca3755() {
  level.player endon("death");
  thread function_772e1a80606fed47();
  flag_wait("train_01_near_player");
  level thread function_4b0b7e45185addfb();
  thread play_sound_in_space("evt_surge_chunnel_intro_train_by_engine", (-49781, 50951, 64));
  wait 1;
  earthquake(0.2, 1.5, level.player.origin, 128);
  level.player shellshock("default_nosound", 1.5);
  wait 1;
  level.player forceplaygestureviewmodel("ges_frag_block");
  flag_waitopen("train_01_near_player");
  flag_set("flg_chunnel_intro_track_train_single_passed");
  level.player thread utility::blend_movespeedscale(0.95, 2);
  flag_wait("flg_chunnel_intro_allies_adv_2");
  flag_set("flg_chunnel_intro_first_train_allies_moveup");
  level thread function_42fea5e0c8da990f();
}

function function_42fea5e0c8da990f() {
  player_door = getEnt("e_chunnel_intro_player_door_closed", "targetname");
  var_170446bac3ac8498 = getEnt("e_chunnel_intro_player_door_closed_clip", "targetname");
  flag_wait("flg_service_tunnel_close");
  player_door show();
  var_170446bac3ac8498 solid();
  var_170446bac3ac8498 disconnectPaths();
}

function function_4b0b7e45185addfb() {
  for(i = 0; i < 12; i++) {
    earthquake(0.05 + 0.02 * i, 0.5, level.player.origin, 128);

    if(i > 6) {
      playrumbleonposition("artillery_rumble_light", level.player.origin);
    }

    wait 0.5;
  }
}

function function_22269c9927e4b379() {
  function_ef8cd51a532d7fd3();
  flag_wait("flg_chunnel_intro_train_2_trigger");
  level thread train_loop(level.var_f76b29c280893d5f, "s_train_01_sound_vents");
  var_86646955334da365 = getEntArray("vol_chunnel_intro_track_badplace", "targetname");
  var_be633d99a92450c9 = [];

  foreach(vol in var_86646955334da365) {
    var_be633d99a92450c9[index] = createnavbadplacebyent(vol, "allies");
  }

  a_ai_allies = [level.ai_soap];
  a_ai_allies = array_combine(a_ai_allies, level.var_c1e9be5f5e50acc7);

  while(true) {
    foreach(vol_badplace in var_86646955334da365) {
      var_99b9ea846a2014a3 = vol_badplace utility::get_ai_touching_volume("allies");

      if(var_99b9ea846a2014a3.size > 0) {
        wait 1;
      }
    }

    break;
  }

  flag_set("flg_chunnel_intro_train_2_incoming");
  level thread function_6b30b2e868fbe6bf();
  flag_wait("flg_chunnel_intro_track_complete");
  wait 8;

  foreach(id in var_be633d99a92450c9) {
    destroynavobstacle(id);
  }
}

function function_6b30b2e868fbe6bf() {
  level.player endon("death");
  vol = getEnt("trig_chunnel_intro_track_danger", "targetname");
  utility::flag_init("flg_chunnel_intro_track_train_danger");

  while(!flag("flg_chunnel_crossover_open_door")) {
    utility::flag_wait("train_01_moving");

    while(flag("train_01_moving")) {
      if(level.player istouching(vol) && !flag("flg_chunnel_intro_track_train_danger")) {
        utility::flag_set("flg_chunnel_intro_track_train_danger");
        utility::flag_set("flg_chunnel_intro_track_train_danger_vo");
      } else if(!level.player istouching(vol) && flag("flg_chunnel_intro_track_train_danger")) {
        utility::flag_clear("flg_chunnel_intro_track_train_danger");
        utility::flag_clear("flg_chunnel_intro_track_train_danger_vo");
      }

      wait 0.1;
    }

    utility::flag_clear("flg_chunnel_intro_track_train_danger");
    utility::flag_clear("flg_chunnel_intro_track_train_danger_vo");
    wait 1;
  }

  utility::flag_clear("flg_chunnel_intro_track_train_danger");
  utility::flag_clear("flg_chunnel_intro_track_train_danger_vo");
}

function function_ef8cd51a532d7fd3() {
  level endon("flg_chunnel_intro_track_allies_moveup");
  a_ai_allies = array_add(level.var_c1e9be5f5e50acc7, level.ai_soap);
  a_ai_allies = array_removedead_or_dying(a_ai_allies);
  array_ent_flag_wait(a_ai_allies, "flag_chunnel_track_ally_safe");
}

function function_3f0c28307fa47c8b() {
  level.var_4938bf83ef9826ad = array_add(level.var_c1e9be5f5e50acc7, level.ai_soap);
  level.var_4938bf83ef9826ad = array_removedead_or_dying(level.var_4938bf83ef9826ad);

  foreach(ai in level.var_4938bf83ef9826ad) {
    level thread function_f7edaa070304baf8(ai);
  }

  array_ent_flag_wait(level.var_4938bf83ef9826ad, "flg_service_tunnel_exited");
  flag_set("flg_service_tunnel_close");
}

function function_f7edaa070304baf8(ai) {
  b_exited = 0;
  var_75f5ff84362553e0 = getStructArray("s_start_chunnel_intro", "targetname");

  foreach(struct in var_75f5ff84362553e0) {
    if(isDefined(struct.script_noteworthy) && struct.script_noteworthy == "player") {
      var_30ceb8842dfdfc8c = struct;
    }
  }

  while(isalive(ai) && b_exited == 0) {
    dist = distance2d(ai.origin, var_30ceb8842dfdfc8c.origin);

    if(isDefined(dist) && dist > 300) {
      b_exited = 1;
    }

    wait 0.5;
  }

  if(isalive(ai)) {
    ai ent_flag_set("flg_service_tunnel_exited");
    return;
  }

  level.var_4938bf83ef9826ad = array_removedead_or_dying(level.var_4938bf83ef9826ad);
}

function function_ce0481962eaf7d5b() {
  level endon("flg_chunnel_intro_track_early_clear");
  level endon("flg_chunnel_intro_track_complete");
  flag_wait("flg_chunnel_intro_track_flank");

  if(!flag("flg_chunnel_intro_track_laststand_left")) {
    array_spawn_function_targetname("sp_tunnel_intro_konni_track_flank", &function_b40a0ed9ed9a158c);
    var_57b4507ec976b448 = spawn_targetname("sp_tunnel_intro_konni_track_flank", 1);
    level.var_1181f1897e13785c = array_add(level.var_1181f1897e13785c, var_57b4507ec976b448);
  }

  if(flag("flg_chunnel_intro_track_attack_left") || flag("flg_chunnel_intro_track_attack_right")) {
    var_57b4507ec976b448 scripts\stealth\utility::set_event_override("combat");
    var_57b4507ec976b448 set_favoriteenemy(level.player);
    var_57b4507ec976b448 getenemyinfo(level.player);
  }
}

function function_b40a0ed9ed9a158c() {
  self endon("death");
  self endon("entitydeleted");
  self.goalradius = 32;
  utility::set_battlechatter(0);
  function_f2058bc826a16898();
  thread function_8e379432fdfb4cad("flg_chunnel_intro_track_allies_go_loud");
  msg = flag_wait_any_return("stealth_spotted", "flg_chunnel_intro_track_alerted");
  level scripts\sp\stealth\utility::sixthsense_enable(0);
  wait 0.5;
  flag_set("flg_chunnel_intro_track_alerted");
  scripts\stealth\utility::enable_stealth_for_ai(0);
  self.dontevershoot = 0;
  self.ignoreall = 0;
  self.goalradius = 256;
  demeanor_override("combat");
  self getenemyinfo(level.player);

  if(self.script_noteworthy == "tunnel_intro_konni_track_1") {
    utility::set_goal_pos(self.origin);
    utility::set_goal_radius(32);

    if(flag("flg_chunnel_intro_track_flank")) {
      utility::set_goal_node(getnode("nd_chunnel_track_1_right", "targetname"));
    } else {
      utility::set_goal_node(getnode("nd_chunnel_track_1_left", "targetname"));
    }
  } else if(self.script_noteworthy == "tunnel_intro_konni_track_2") {
    utility::set_goal_pos(self.origin);
    utility::set_goal_radius(32);

    if(flag("flg_chunnel_intro_track_flank")) {
      utility::set_goal_node(getnode("nd_chunnel_track_2_left", "targetname"));
    } else {
      utility::set_goal_node(getnode("nd_chunnel_track_2_right", "targetname"));
    }
  } else {
    utility::set_goal_pos(self.origin);

    if(flag("flg_chunnel_intro_allies_adv_9")) {
      self cleargoalentity();
      self setgoalvolumeauto(getEnt("vol_chunnel_intro_track_back", "targetname"));
    } else if(flag("flg_chunnel_intro_track_flank")) {
      self cleargoalentity();
      self setgoalvolumeauto(getEnt("vol_chunnel_intro_track_right", "targetname"));
    } else {
      self cleargoalentity();
      self setgoalvolumeauto(getEnt("vol_chunnel_intro_track_left", "targetname"));
    }
  }

  flag_wait_any("flg_chunnel_intro_track_laststand_left", "flg_chunnel_intro_track_laststand_right");
  wait randomfloatrange(1, 3);
  set_attackeraccuracy(5);
  ai::function_dd21d67ede8ba22(int(self.health * 0.5) + 1);
}

function function_8e379432fdfb4cad(var_ab5ce247ccacbdbc) {
  self endon("death");
  self endon("entitydeleted");
  flag_wait_any_return("stealth_spotted", var_ab5ce247ccacbdbc);
  self.dontevershoot = 0;
  self.ignoreall = 0;
  set_attackeraccuracy(8);
}

function chunnel_intro_track_allies_moveup() {
  flag_wait_all("flg_chunnel_intro_allies_adv_9", "flg_chunnel_intro_track_complete");
  flag_set("flg_chunnel_intro_track_allies_moveup");
}

function function_8d668a205bad23e8() {
  setomnvar("ui_chyron_surge_chunnel", 1);
  flag_set("flg_chunnel_obj_start");
  flag_set("flg_chunnel_intro_track_complete");
  level thread function_23d0e83df014aeaa();
  level thread function_23d0e73df014ac77();
}

function function_c418781bcb279f1f() {}

function function_db2aeb0917913640() {
  function_109726d29627f8de();
  set_start_location("s_start_chunnel_vents", array_combine([level.player], level.var_679be75090dd2a47));
  function_75519ed05932e7ac();
  level.player setmovespeedscale(0.9);

  while(!isDefined(level.var_1dfec668afe59727)) {
    wait 0.1;
  }

  array_spawn_function_targetname("sp_chunnel_sas_vents_alpha", &function_309d023866601bc0);
  level.var_c1e9be5f5e50acc7 = array_spawn_targetname("sp_chunnel_sas_vents_alpha", 1, 1);
  level.var_c1e9be5f5e50acc7 = array_sort_by_script_index(level.var_c1e9be5f5e50acc7);
  level.var_c1e9be5f5e50acc7 function_fe677b3c2b5ce6bb();
  level thread function_791c2eb990017928();
}

function function_9b7d604d11c44759() {
  autosave_by_name();
  level thread namespace_fc0114e844f0b4c::function_91db77148cb4384d(undefined, undefined, "flag_chunnel_vents_stop_nags", "chunnel_vents_player_progress");
  level.player thread utility::blend_movespeedscale(0.9, 2);
  clip = getEnt("garage_door_clip", "targetname");
  clip disconnectPaths();

  if(level.start_point == "chunnel_vents") {
    while(true) {
      if(isDefined(level.ai_soap) && isDefined(level.var_c1e9be5f5e50acc7) && level.var_c1e9be5f5e50acc7.size > 0) {
        break;
      }

      waitframe();
    }

    level thread function_826e1eda7a4c9086();
  }

  level thread function_19ca5dae7378a648();
  level thread function_c7e13a4c33547e6();
  level thread function_7a582aa967f45114();
  flag_clear("stealth_spotted");
  flag_wait("flg_chunnel_intro_vents_start");
  level thread function_7858124c75557961();
  level thread function_39fe1a402b4febad();
  level function_87a70036926b2c90("chunnel_vents_player_progress");
  level thread namespace_85a51fd192b9a590::function_8b2295f5369ece6d();
  flag_wait("flg_chunnel_intro_vents_13");
  clearallcorpses();
  flag_clear("stealth_spotted");
  level thread function_39fe1a402b4febad();
  level function_87a70036926b2c90("chunnel_vents_player_progress");
  level.var_b680f0b90d32078b = utility::array_spawn_targetname("sp_tunnel_intro_konni_garage", 1);

  foreach(enemy in level.var_b680f0b90d32078b) {
    enemy thread function_91a37530b9d090c6();
    enemy.var_98add129a7ecb962 = 0;
    enemy.stealth.funcs["silenced_shot_impact"] = &function_917b92dbdc280a05;
  }

  level thread function_34d5d706dd8aeb92();
  level thread function_3025ee051d28ec46(level.var_b680f0b90d32078b, "flg_chunnel_intro_garage_complete");
  flag_wait("flg_garage_hostage_takers_engaged");
  level thread function_ccf2916c9ce0684();
  var_beb3da08eb27148 = getnode("nd_chunnel_track_2_left", "targetname");
  level thread function_c01ae6bb604460df(var_beb3da08eb27148.origin, 1000);
  flag_wait("flg_chunnel_intro_garage_start");
  flag_wait("flg_chunnel_intro_garage_complete");
  level function_d962f42ac75f265f("flag_chunnel_vents_stop_nags");
  flag_wait("flg_chunnel_crossover_start");
  level.var_d29b3eb118ddb65e = undefined;
}

function function_7dbb4634438e3a96() {
  flag_set("flg_chunnel_intro_vents_complete");
  flag_set("flg_chunnel_intro_garage_complete");
}

function function_309d023866601bc0() {
  function_c1e075c4168a8bea(1, 0);
  self.allowstrafe = 0;
  self enableavoidance(1);
  function_a8d01dcc629d8524(undefined, 0);
}

function function_826e1eda7a4c9086() {
  a_structs = [];
  a_structs[0] = "s_chunnel_intro_vents_enter_soap";
  a_structs[1] = "s_chunnel_intro_vents_enter_1";
  a_structs[2] = "s_chunnel_intro_vents_enter_2";
  a_structs[3] = "s_chunnel_intro_vents_enter_3";
  a_ai_allies = [level.ai_soap];
  a_ai_allies = array_combine(a_ai_allies, level.var_c1e9be5f5e50acc7);

  for(i = 0; i < a_ai_allies.size; i++) {
    if(isDefined(a_ai_allies[i])) {
      a_ai_allies[i] notify("stop_going_to_node");
      waitframe();
      a_ai_allies[i] utility::set_goal_pos(a_ai_allies[i].origin);
      a_ai_allies[i].allowstrafe = 0;
      a_ai_allies[i] thread function_ed832ca607826c89(a_structs[i]);
    }
  }

  foreach(ai in a_ai_allies) {
    if(isDefined(ai) && isalive(ai)) {
      ai set_force_color("y");
    }
  }
}

function function_7a582aa967f45114() {
  flag_wait("flg_chunnel_intro_garage_01");
  level thread function_dbc15415eab3be23();
  shelf_clip = getEnt("garage_shelf_no_sight_clip", "targetname");
  flag_wait_any("flg_chunnel_intro_garage_04", "stealth_spotted", "begin_firing");
  shelf_clip delete();
}

function function_dbc15415eab3be23() {
  level.player endon("death");
  level endon("flg_chunnel_intro_garage_04");
  level.player waittill_any("weapon_fired", "grenade_fire");
  flag_set("begin_firing");
}

function function_7b14761511a701d6() {}

function chunnel_crossover_start() {
  function_109726d29627f8de();
  set_start_location("s_start_chunnel_crossover", array_combine([level.player], level.var_679be75090dd2a47));
  function_75519ed05932e7ac();
  function_a36a86f1e344125d();
  level thread function_791c2eb990017928();
  level thread function_ccf2916c9ce0684();

  level thread function_c4bed616d3a3036c("<dev string:x1c>");
}

function function_b9a1c98e258e862f() {
  autosave_by_name();
  level thread function_bd20aa7f0cdb525f();
  level thread function_bd20ab7f0cdb5492();
  level thread function_bd20ac7f0cdb56c5();
  level thread function_bd20a57f0cdb4760();
  level thread namespace_fc0114e844f0b4c::function_91db77148cb4384d(120, undefined, "flag_chunnel_crossover_stop_nags", "chunnel_crossover_player_progress");
  level.player thread utility::blend_movespeedscale_default(2);
  level thread function_554b1127c6be10c6();
  thread door_anims();
  var_eccb17617e11cb54 = getEntArray("e_soap_corpse_brush", "targetname");

  foreach(e_soap_corpse_brush in var_eccb17617e11cb54) {
    e_soap_corpse_brush notsolid();
  }

  if(flag("flg_chunnel_garage_vo_start")) {
    flag_wait("flg_chunnel_garage_vo_complete");
  }

  s_crossover_garage_door_interact_ref = getStruct("s_crossover_garage_door_interact_ref", "targetname");
  namespace_fc0114e844f0b4c::function_1847045442fe1eb8(s_crossover_garage_door_interact_ref);
  thread function_409f84b3294f2f02();
  array_spawn_function_targetname("sp_chunnel_new_konni_patrol", &function_f570062d0face34d);
  level.var_337d7d0b877e30c8 = array_spawn_targetname("sp_chunnel_new_konni_patrol", 1);
  level thread function_c4599ade2a1028ef();
  flag_set("flg_chunnel_crossover_open_door");
  level.var_f76b29c280893d5f notify("end_train_loop");
  level.var_b680f0b90d32078b = undefined;
  wait 2;
  garagedoor1 = getEnt("e_main_tunnel_door_entrance_01", "targetname");
  garagedoor1 thread function_218ab5174228dd97();
  level notify("audio_vent_train_mute_clear");
  level thread namespace_85a51fd192b9a590::function_9dc9264d67991d91();
  autosave_by_name();
  level function_87a70036926b2c90("chunnel_crossover_player_progress");
  level.ai_soap.fixednode = 0;
  flag_wait_any("flg_chunnel_veh_train1_approach", "flg_chunnel_crossover_alerted");
  level scripts\sp\stealth\utility::sixthsense_enable(0);
  var_2028491b720b89d1 = getaiarray("allies");
  var_2028491b720b89d1 = array_removedead_or_dying(var_2028491b720b89d1);

  foreach(sfo in var_2028491b720b89d1) {
    if(isDefined(sfo) && isalive(sfo)) {
      sfo.dontevershoot = 1;
      sfo.ignoreall = 1;
    }
  }

  wait 2;
  var_2028491b720b89d1 = getaiarray("allies");
  var_2028491b720b89d1 = array_removedead_or_dying(var_2028491b720b89d1);

  foreach(sfo in var_2028491b720b89d1) {
    if(isDefined(sfo) && isalive(sfo)) {
      sfo.dontevershoot = 0;
      sfo.ignoreall = 0;
    }
  }

  battlechatter_on("allies");
  array_spawn_function_targetname("sp_chunnel_new_konni_1", &function_20799f520968e46d);
  level.var_bfdb5343205d4bf4 = array_spawn_targetname("sp_chunnel_new_konni_1", 1, 1);
  waitframe();

  if(isDefined(level.var_bfdb5343205d4bf4)) {
    if(level.var_bfdb5343205d4bf4.size > 0) {
      foreach(ai in level.var_bfdb5343205d4bf4) {
        ai.fixednode = 1;
      }
    }
  }

  if(isDefined(level.var_bfdb5343205d4bf4)) {
    if(level.var_337d7d0b877e30c8.size > 0) {
      level.var_337d7d0b877e30c8 = array_removedead_or_dying(level.var_337d7d0b877e30c8);

      foreach(ai in level.var_337d7d0b877e30c8) {
        if(isDefined(self.script_noteworthy) && self.script_noteworthy == "sp_chunnel_konni_train") {
          nd_enemy_train_path = getEnt("nd_enemy_train_path", "targetname");
          self.goalradius = 32;
          self.goalnode = nd_enemy_train_path;
          self.fixednode = 1;
        }
      }
    }
  }

  level thread function_d0157d1a9ec65ac4();
  flag_wait("flg_chunnel_middle_crossed");
  autosave_by_name();
  level function_87a70036926b2c90("chunnel_crossover_player_progress");
  level thread function_b3d772d5987c763a();
  thread scripts\sp\spawner::killspawner(4);

  if(isDefined(level.var_bfdb5543205d505a)) {
    if(level.var_bfdb5543205d505a.size > 0) {
      level.var_bfdb5543205d505a = array_removedead_or_dying(level.var_bfdb5543205d505a);

      foreach(ai in level.var_bfdb5543205d505a) {
        ai.goalradius = 64;
        ai setgoalvolumeauto(getEnt("vol_crossover_combat_a_retreat", "targetname"));
      }
    }
  }

  array_spawn_function_targetname("sp_chunnel_konni_combat_a_rusher_1a", &function_e2cdc525916b0351);
  level.var_caf9df67e6e2b5f3 = array_spawn_targetname("sp_chunnel_konni_combat_a_rusher_1a", 1, 1);
  level thread function_24c11d191b9a8364();
  level thread function_41597c13246cf13b();
  level thread function_e43032c365a9cc9();
  flag_wait("flg_crossover_island_a_save");
  level thread function_c8361bd9f9570344();
  flag_wait("flg_crossover_combat_a_enemies_rush");
  var_6bd19437c57424b3 = getaiarray("axis");
  var_6bd19437c57424b3 = array_removedead_or_dying(var_6bd19437c57424b3);

  if(var_6bd19437c57424b3.size > 0) {
    foreach(ai in var_6bd19437c57424b3) {
      ai setgoalentity(level.player);
    }
  }

  flag_wait("flg_crossover_second_combat_area");
  thread function_1e9039fbd525ed0c();
  level thread function_ed94d9f75e34fd74();
  autosave_by_name();
  level function_87a70036926b2c90("chunnel_crossover_player_progress");
  array_spawn_function_targetname("sp_chunnel_konni_jugg_intro", &function_6cca66171b2b63df);
  array_spawn_function_targetname("sp_chunnel_konni_jugg_intro", &function_ebc91201d8beb3fb);
  level.var_5e64b5358f867b1 = spawn_targetname("sp_chunnel_konni_jugg_intro", 1);
  level.var_5e64b5358f867b1 add_spawn_function(&juggernaut_handler);
  level.var_5e64b5358f867b1 add_damage_function(&function_1d34bf290c26a5ac);
  level thread namespace_85a51fd192b9a590::function_a1d01f5ecd7c3c5e();
  flag_set("flg_crossover_intro_juggernaut_spawned");
  level.var_5a419e92fb3fc350 = [level.var_5e64b5358f867b1];
  level thread function_627393ab58d2ddd9();
  level thread function_3c1ac0d5e25a00f7();
  level.var_5e64b5358f867b1.var_c833409fb72d15fb = 1;
  level thread function_c632cf0f2d04d12b();
  level.player.attackeraccuracy = 1;
  flag_wait_any("flg_crossover_combat_b_cqb", "flg_crossover_jugg_intro_killed", "flag_crossover_juggernaut_reinforcement_killed", "flg_chunnel_crossover_jugg_left", "flg_chunnel_crossover_jugg_right");
  array_spawn_function_targetname("sp_crossover_konni_elite_tunnel", &function_20799f520968e46d);
  level.var_bd13a5b8cab9e384 = array_spawn_targetname("sp_crossover_konni_elite_tunnel", 1, 1);
  array_spawn_function_targetname("sp_chunnel_new_konni_9", &function_20799f520968e46d);
  level.var_bfdb4b43205d3a5c = array_spawn_targetname("sp_chunnel_new_konni_9", 1, 1);
  level thread function_af5706297a5a407b();
  flag_wait_any("flg_crossover_combat_b_cqb", "flg_crossover_jugg_intro_killed", "flag_crossover_juggernaut_reinforcement_killed");
  var_936a32a82e145911 = array_spawn_targetname("sp_crossover_konni_elite", 1);
  level thread function_c41db8bd4eb3eb2a();
  flag_wait_any("flg_crossover_final_enemies_rush", "flg_crossover_finale_enter");
  level.var_a8324d317acdb068 = getaiarray("axis");
  level.var_a8324d317acdb068 = array_removedead_or_dying(level.var_a8324d317acdb068);

  foreach(ai in level.var_a8324d317acdb068) {
    ai cleargoalentity();
    waitframe();
    ai.goalradius = 64;
    ai.balwayscoverexposed = 1;
    ai setgoalentity(level.player);
  }

  flag_wait_any("flg_crossover_finale_enter", "flg_crossover_elites_clear");
  autosave_by_name();
  level function_87a70036926b2c90("chunnel_crossover_player_progress");
  flag_wait("flg_crossover_finale_enter");
  level thread function_9065900991499881();
  level.player val::set("player_speedScalingLogic", "sprint", 0);
  level.player val::set("player_speedScalingLogic", "allow_jump", 0);
  level function_d962f42ac75f265f("flag_chunnel_crossover_stop_nags");
  level.player val::set("player_speedScalingLogic", "sprint", 1);
  level.player val::set("player_speedScalingLogic", "allow_jump", 1);
  autosave_by_name();
  level function_87a70036926b2c90("chunnel_crossover_player_progress");
}

function function_d0157d1a9ec65ac4() {
  wait 2;
  level thread train_loop(level.var_f76b29c280893d5f, "s_train_01_sound");
  wait 3;
  array_spawn_function_targetname("sp_chunnel_new_konni_3", &function_20799f520968e46d);
  waitframe();
  level.var_bfdb5543205d505a = array_spawn_targetname("sp_chunnel_new_konni_3", 1, 1);
  level.var_54137b44468822dc = getspawnerarray("sp_chunnel_new_konni_4_flood");

  if(isDefined(level.var_54137b44468822dc) && level.var_54137b44468822dc.size > 0) {
    array_spawn_function(level.var_54137b44468822dc, &function_20799f520968e46d);
    waitframe();
    flood_spawn(level.var_54137b44468822dc);
  }

  level thread train_loop(level.var_f76b2ac280893f92, "s_train_02_sound");
  level thread function_a53103b0a8b840fa();
  var_ae02a71bca5d435b = getaiarray("axis");

  if(var_ae02a71bca5d435b.size > 0) {
    var_ae02a71bca5d435b = array_removedead_or_dying(var_ae02a71bca5d435b);

    if(var_ae02a71bca5d435b.size > 0) {
      if(var_ae02a71bca5d435b.size >= 2) {
        level thread function_3025ee051d28ec46(var_ae02a71bca5d435b, "flg_chunnel_crossover_initial_enemies_cleared", var_ae02a71bca5d435b.size - 2, "flg_chunnel_middle_crossed");
        return;
      }

      level thread function_3025ee051d28ec46(var_ae02a71bca5d435b, "flg_chunnel_crossover_initial_enemies_cleared", 0, "flg_chunnel_middle_crossed");
    }
  }
}

function function_e43032c365a9cc9() {
  wait randomfloatrange(2, 4);
  level thread function_3f5686841216242d();
  wait 0.1;
  thread function_9c042f84a06d478f();
}

function function_c41db8bd4eb3eb2a() {
  wait 4;
  array_spawn_function_targetname("sp_chunnel_new_konni_charge", &function_e2cdc525916b0351);
  level.var_a6d01442086841f2 = array_spawn_targetname("sp_chunnel_new_konni_charge", 1, 1);
  var_65a28e1a63c518f = array_combine(level.var_bfdb4b43205d3a5c, level.var_936a32a82e145911, level.var_bd13a5b8cab9e384, level.var_a6d01442086841f2);
  var_65a28e1a63c518f = array_removedead_or_dying(var_65a28e1a63c518f);
  level thread function_3025ee051d28ec46(var_65a28e1a63c518f, "flg_crossover_elites_clear", var_65a28e1a63c518f.size, "flg_crossover_finale_arrived");
}

function function_1e9039fbd525ed0c() {
  setmusicstate("mx_surge_crossover");
}

function function_409f84b3294f2f02() {
  level.var_f76b29c280893d5f thread function_7d5ed04f007804ff("s_train_01_crossover_first_combat_area", "flg_chunnel_middle_crossed", "r", "r", "trg_safe_zone_crossover_first_combat_area", "flg_ally_crossed_first_combat_area", 1);
  flag_wait("flg_ally_crossed_first_combat_area");
  level.var_f76b29c280893d5f thread function_7d5ed04f007804ff("s_train_01_crossover_second_combat_area", "flg_crossover_second_combat_train_01_area", "r", "b", "trg_safe_zone_crossover_second_combat_area", undefined, 0);
  level.var_f76b2ac280893f92 thread function_7d5ed04f007804ff("s_train_02_crossover_second_combat_area", "flg_crossover_second_combat_train_02_area", "r", "b", "trg_safe_zone_crossover_second_combat_area", undefined, 0);
}

function function_7d5ed04f007804ff(var_952c9de45507396e, var_40f0d66f5b8019de, prev_color, new_color, var_bbb70feaf6f13c3, var_ba8e3cae02229f1b, var_4387fa0405ca2a8f) {
  level endon("ally_successfully_crossed");
  self.var_2c51d63c60938594 = var_952c9de45507396e;
  flag_wait(var_40f0d66f5b8019de);
  var_339c696f0aecb79a = getEntArray("sp_chunnel_sfo_crossover_alpha", "targetname");
  var_339c696f0aecb79a[var_339c696f0aecb79a.size] = level.ai_soap;
  var_339c696f0aecb79a = array_removedead_or_dying(var_339c696f0aecb79a);

  foreach(ally_ai in var_339c696f0aecb79a) {
    if(isDefined(ally_ai) && isalive(ally_ai)) {
      ally_ai set_force_color(prev_color);
      ally_ai.fixednode = 1;
    }
  }

  flag_set("flg_ally_crossing_train_0" + self.train_number + "_tracks");

  if(!flag("train_0" + self.train_number + "_crossed_safe_point")) {
    flag_wait("train_0" + self.train_number + "_crossed_safe_point");
  }

  var_339c696f0aecb79a = array_removedead_or_dying(var_339c696f0aecb79a);

  foreach(ally_ai in var_339c696f0aecb79a) {
    if(isDefined(ally_ai) && isalive(ally_ai)) {
      ally_ai.fixednode = 0;
      ally_ai set_force_color(new_color);
    }
  }

  var_b6c3ac9c4c82f4f0 = getEnt(var_bbb70feaf6f13c3, "targetname");
  var_8ec6c947caa3fea1 = [];
  wait 0.1;

  if(isDefined(var_8ec6c947caa3fea1) && isDefined(var_339c696f0aecb79a)) {
    while(var_8ec6c947caa3fea1.size < var_339c696f0aecb79a.size) {
      var_b6c3ac9c4c82f4f0 waittill("trigger", triggerer);
      var_339c696f0aecb79a = array_removedead_or_dying(var_339c696f0aecb79a);

      if(!array_contains(var_8ec6c947caa3fea1, triggerer) && array_contains(var_339c696f0aecb79a, triggerer)) {
        var_8ec6c947caa3fea1[var_8ec6c947caa3fea1.size] = triggerer;
      }
    }
  } else {
    wait 5;
  }

  flag_clear("flg_ally_crossing_train_0" + self.train_number + "_tracks");

  if(isDefined(var_ba8e3cae02229f1b)) {
    flag_set(var_ba8e3cae02229f1b);
  }

  if(isDefined(var_4387fa0405ca2a8f) && var_4387fa0405ca2a8f == 0) {
    level notify("ally_successfully_crossed");
  }
}

function function_bd20aa7f0cdb525f() {
  level thread function_1adc4df33bce9de9();

  while(!flag("flg_crossover_second_combat_area")) {
    if(flag("flg_crossover_red1") && !flag("flg_color_red1") && flag("spectacle_train_passed")) {
      activate_trigger("trig_crossover_ally_advance_red1", "targetname");
      flag_set("flg_color_red1");
    }

    wait 1;
  }
}

function function_1adc4df33bce9de9() {
  flag_wait("flg_chunnel_crossover_open_door");

  if(flag("train_01_moving")) {
    level.var_f76b29c280893d5f waittill("train_anim_finished");
  }

  flag_wait("train_01_moving");
  flag_wait("train_01_crossed_safe_point");
  flag_set("spectacle_train_passed");
}

function function_bd20ab7f0cdb5492() {
  while(!flag("flg_crossover_second_combat_area")) {
    current_enemies = array_removedead_or_dying(getaiarray("axis"));

    if(flag("flg_crossover_red2") && !flag("flg_color_red2") && current_enemies.size <= 6) {
      activate_trigger("trig_crossover_ally_advance_red2", "targetname");
      flag_set("flg_color_red2");
    }

    wait 1;
  }
}

function function_bd20ac7f0cdb56c5() {
  while(!flag("flg_crossover_second_combat_area")) {
    current_enemies = array_removedead_or_dying(getaiarray("axis"));

    if(flag("flg_crossover_red3") && !flag("flg_color_red3") && current_enemies.size <= 4) {
      activate_trigger("trig_crossover_ally_advance_red3", "targetname");
      flag_set("flg_color_red3");
    }

    wait 1;
  }
}

function function_bd20a57f0cdb4760() {
  while(!flag("flg_crossover_second_combat_area")) {
    current_enemies = array_removedead_or_dying(getaiarray("axis"));

    if(flag("flg_crossover_red4") && !flag("flg_color_red4") && current_enemies.size <= 3) {
      activate_trigger("trig_crossover_ally_advance_red4", "targetname");
      flag_set("flg_color_red4");
    }

    wait 1;
  }
}

function function_ed94d9f75e34fd74() {
  while(!flag("flg_color_yellow50")) {
    if(flag("flg_crossover_combat_b_cqb_color")) {
      activate_trigger("trig_friendly_advance_yellow50", "targetname");
      flag_set("flg_color_yellow50");
    }

    wait 0.5;
  }
}

function train_loop(var_e6d3976099a5c9cf, var_95a60175638eeb98, var_374103a6ca06468e) {
  var_e6d3976099a5c9cf notify("end_train_loop");
  var_e6d3976099a5c9cf endon("end_train_loop");

  if(!isDefined(var_374103a6ca06468e)) {
    var_374103a6ca06468e = 0;
  }

  if(isDefined(var_95a60175638eeb98)) {
    var_e6d3976099a5c9cf.sound_struct = getStruct(var_95a60175638eeb98, "targetname");
  }

  msg = "notify_ventilation_train_is_active";
  level thread function_68b6e53e38036c88(msg);

  while(true) {
    if(flag("train_0" + var_e6d3976099a5c9cf.train_number + "_moving")) {
      flag_waitopen("train_0" + var_e6d3976099a5c9cf.train_number + "_moving");
    }

    var_e6d3976099a5c9cf notify("train_start", var_374103a6ca06468e, 0);
    wait 2;
    level notify(msg);
    var_e6d3976099a5c9cf waittill("train_anim_finished");
    flag_wait_any_timeout(16, "flg_train_vents_tunnel", "flg_ally_crossing_train_0" + var_e6d3976099a5c9cf.train_number + "_tracks");

    if(flag("flg_ally_crossing_train_0" + var_e6d3976099a5c9cf.train_number + "_tracks")) {
      var_8894a7f7c13f322 = randomintrange(10, 15);
      flag_waitopen_or_timeout("flg_ally_crossing_train_0" + var_e6d3976099a5c9cf.train_number + "_tracks", var_8894a7f7c13f322);
      wait randomintrange(4, 8);

      if(flag("flg_ally_crossing_train_0" + var_e6d3976099a5c9cf.train_number + "_tracks")) {
        flag_clear("flg_ally_crossing_train_0" + var_e6d3976099a5c9cf.train_number + "_tracks");
        level notify("ally_successfully_crossed");
      }
    }
  }
}

function function_f570062d0face34d() {
  self endon("death");
  self endon("entitydeleted");
  self.goalradius = 32;
  thread function_be298b3ca6fe0a71();
  function_f2058bc826a16898();
  flag_wait_any("flg_chunnel_crossover_alerted", "flg_chunnel_veh_train1_approach");
  scripts\stealth\utility::enable_stealth_for_ai(0);
  self.dontevershoot = 0;
  self.ignoreall = 0;
  self.goalradius = 256;
  demeanor_override("combat");
  self getenemyinfo(level.player);
}

function function_be298b3ca6fe0a71() {
  self endon("death");
  self endon("entitydeleted");
  waittill_any("stealth_spotted", "bulletwhizby", "damage");
  wait 1.5;

  if(isalive(self) && !istrue(self.in_melee_death)) {
    flag_set("flg_chunnel_crossover_alerted");
    self.ignoreme = 0;
    self.dontattackme = 0;
  }
}

function function_3f5686841216242d() {
  var_cf2f9ce412482b76 = getaiarray("axis");

  while(!flag("flg_crossover_konni_6_spawned")) {
    if(var_cf2f9ce412482b76.size < 5 && !flag("flg_crossover_combat_a_enemies_rush")) {
      array_spawn_function_targetname("sp_chunnel_new_konni_6", &function_20799f520968e46d);
      level.var_bfdb5243205d49c1 = array_spawn_targetname("sp_chunnel_new_konni_6", 1, 1);
      flag_set("flg_crossover_konni_6_spawned");
    }

    var_cf2f9ce412482b76 = array_removedead_or_dying(var_cf2f9ce412482b76);
    wait 1;
  }
}

function function_a53103b0a8b840fa() {
  level endon("flg_crossover_combat_a_enemies_rush");
  flag_wait("flg_chunnel_left_crossed");
  array_spawn_function_targetname("sp_chunnel_new_konni_8", &function_20799f520968e46d);
  level.var_bfdb4c43205d3c8f = array_spawn_targetname("sp_chunnel_new_konni_8", 1, 1);
}

function function_24c11d191b9a8364() {
  level endon("flg_crossover_second_combat_area");

  while(!flag("flg_crossover_ca_rushers_1")) {
    if(level.var_caf9df67e6e2b5f3.size < 1 && !flag("flg_crossover_combat_a_enemies_rush")) {
      array_spawn_function_targetname("sp_chunnel_konni_combat_a_rusher_1b", &function_e2cdc525916b0351);
      level.var_caf9e067e6e2b826 = array_spawn_targetname("sp_chunnel_konni_combat_a_rusher_1b", 1, 1);
      flag_set("flg_crossover_ca_rushers_1");
    }

    level.var_caf9df67e6e2b5f3 = array_removedead_or_dying(level.var_caf9df67e6e2b5f3);
    wait 1;
  }
}

function function_41597c13246cf13b() {
  level endon("flg_crossover_second_combat_area");

  while(!flag("flg_crossover_ca_rushers_2")) {
    flag_wait("flg_crossover_ca_rushers_1");

    if(level.var_caf9e067e6e2b826.size < 1 && !flag("flg_crossover_combat_a_enemies_rush")) {
      wait randomfloatrange(1, 3);
      array_spawn_function_targetname("sp_chunnel_konni_combat_a_rusher_2", &function_e2cdc525916b0351);
      level.var_c93f8d0ebc3443b9 = array_spawn_targetname("sp_chunnel_konni_combat_a_rusher_2", 1, 1);
      flag_set("flg_crossover_ca_rushers_2");
    }

    level.var_caf9e067e6e2b826 = array_removedead_or_dying(level.var_caf9e067e6e2b826);
    wait 1;
  }
}

function function_c4599ade2a1028ef() {
  s_crossover_sentry = getStruct("s_crossover_sentry", "targetname");
  s_crossover_sentry.var_2108ba0559bdaaff = &function_5e66cae8a3e9f368;
  var_e55f101aea78fb4c = setup_enemy_sentry(s_crossover_sentry, undefined, "surge_sentry", "axis", 3000, 3000, 3);
  wait 0.5;
  var_e55f101aea78fb4c sentry_shutdown();
  flag_wait("flg_chunnel_crossover_exit_garage");
  wait 5;
  level.var_bfdb4f43205d4328 = spawn_targetname("sp_chunnel_new_konni_5", 1);
  level.var_bfdb4f43205d4328.animname = "generic";
  level thread function_6a295ebe9395476a();
  var_bc9ca0455514672b = getStruct(level.var_bfdb4f43205d4328.target, "targetname");
  level.var_bfdb4f43205d4328 thread scripts\sp\spawner::go_to_node(var_bc9ca0455514672b);
  f_dist = 999;

  while(isDefined(level.var_bfdb4f43205d4328) && isalive(level.var_bfdb4f43205d4328) && f_dist > 15) {
    if(isDefined(level.var_bfdb4f43205d4328) && isalive(level.var_bfdb4f43205d4328)) {
      f_dist = distance2d(level.var_bfdb4f43205d4328.origin, var_bc9ca0455514672b.origin);
    }

    wait 0.25;
  }

  if(!flag("flg_crossover_konni_5_dead")) {
    thread namespace_f43c40f7bcbe17e7::function_ec3904b43ba2ac4d();
    level thread function_6f80c9a954eea6d5();
    wait 5.05;

    if(flag("flg_crossover_konni_5_dead")) {
      flag_set("flg_crossover_turret_removed");
      return;
    }

    var_e55f101aea78fb4c sentry_startup();
    var_e55f101aea78fb4c thread function_31ef9f8e4704e6da();
    utility::flag_set("flg_crossover_turret_active");
    level.var_bfdb4f43205d4328.dontevershoot = 0;
    level.var_bfdb4f43205d4328.ignoreme = 0;
    level.var_bfdb4f43205d4328 allowedstances("stand", "crouch", "prone");
    waitframe();
    level.var_bfdb4f43205d4328 cleargoalentity();
    waitframe();
    level.var_bfdb4f43205d4328 setgoalvolumeauto(getEnt("vol_crossover_combat_a_retreat", "targetname"));
    level thread function_7542a7d1619df718();
    var_e55f101aea78fb4c waittill_any("death", "hacked");
    flag_set("flg_crossover_turret_removed");
  }
}

function function_31ef9f8e4704e6da() {
  self endon("death");
  self endon("hacked");
  self waittill("flg_crossover_second_combat_area");
  self dodamage(9999);
}

function function_6f80c9a954eea6d5() {
  if(isDefined(level.var_bfdb4f43205d4328) && isalive(level.var_bfdb4f43205d4328)) {
    var_bc9ca0455514672b = getStruct(level.var_bfdb4f43205d4328.target, "targetname");
    var_bc9ca0455514672b thread anim_loop_solo(level.var_bfdb4f43205d4328, "jup_interaction_patrol_tablet_inventory_loop_01", "stop_loop");
    level.var_bfdb4f43205d4328 function_613f82ecdf9b56b8(1);
    wait 5.05;

    if(isDefined(level.var_bfdb4f43205d4328) && isalive(level.var_bfdb4f43205d4328)) {
      if(!flag("flg_crossover_konni_5_dead")) {
        var_bc9ca0455514672b notify("stop_loop");
        level.var_bfdb4f43205d4328 stopanimScripted();
      }
    }
  }
}

function function_6a295ebe9395476a() {
  level.var_bfdb4f43205d4328 waittill_any("death");
  flag_set("flg_crossover_konni_5_dead");
}

function function_ccf2916c9ce0684() {
  level thread function_d44822d42e96e820();
}

function function_c632cf0f2d04d12b() {
  wait randomfloatrange(2, 3.5);
  array_spawn_function_targetname("sp_chunnel_konni_jugg_2", &function_6cca66171b2b63df);
  array_spawn_function_targetname("sp_chunnel_konni_jugg_2", &function_ebc91201d8beb3fb);
  level.var_336492f2b1af40d5 = spawn_targetname("sp_chunnel_konni_jugg_2", 1);
  level.var_336492f2b1af40d5 add_spawn_function(&juggernaut_handler);
  level.var_336492f2b1af40d5 add_damage_function(&function_1d34bf290c26a5ac);
  flag_set("flg_crossover_2nd_juggernaut_spawned");
  level.var_5a419e92fb3fc350 = array_add(level.var_5a419e92fb3fc350, level.var_336492f2b1af40d5);
  thread function_3025ee051d28ec46(level.var_5a419e92fb3fc350, "flg_crossover_juggernaut_one_dead", 1, "flg_crossover_exit_reached");
  thread function_3025ee051d28ec46(level.var_5a419e92fb3fc350, "flg_crossover_juggernaut_both_dead", level.var_5a419e92fb3fc350.size, "flg_crossover_exit_reached");
  level thread function_3aeba59dd4205b9d();
  level thread function_c3de24939097aabb();
}

function function_b3d772d5987c763a() {
  var_ae02a71bca5d435b = getaiarray("axis");

  while(!flag("flg_flood_combat_A_spawn_check") && !flag("flg_crossover_combat_a_enemies_rush")) {
    var_ae02a71bca5d435b = array_removedead_or_dying(var_ae02a71bca5d435b);

    if(var_ae02a71bca5d435b.size < 7 && !flag("flg_crossover_combat_a_enemies_rush")) {
      level.var_400bab88fcb024ca = getspawnerarray("sp_chunnel_konni_flood_combat_area_a");
      array_spawn_function(level.var_400bab88fcb024ca, &function_20799f520968e46d);
      flood_spawn(level.var_400bab88fcb024ca);
      flag_set("flg_flood_combat_A_spawn_check");
    }

    wait 1;
  }

  while(!flag("flg_flood_combat_A_killed_check")) {
    var_ae02a71bca5d435b = array_removedead_or_dying(getaiarray("axis"));

    if(var_ae02a71bca5d435b.size <= 4 || flag("flg_crossover_combat_a_enemies_rush")) {
      thread scripts\sp\spawner::killspawner(11);
      flag_set("flg_flood_combat_A_killed_check");
      ai_delete_when_out_of_sight(level.var_400bab88fcb024ca, 0);
    }

    wait 1;
  }
}

function function_af5706297a5a407b() {
  level endon("flg_crossover_finale_flood_killed");
  level thread function_58f9cdb507700d0();

  while(!flag("flg_flood_combat_B_spawn_check")) {
    var_4cc3fc93056641c4 = array_removedead_or_dying(getaiarray("axis"));
    waitframe();

    if(var_4cc3fc93056641c4.size < 5 && !flag("flg_crossover_jugg_save") && !flag("flg_crossover_finale_flood_killed")) {
      level.var_d0a4be7987e2d899 = getspawnerarray("sp_chunnel_new_konni_flood_left");
      array_spawn_function(level.var_d0a4be7987e2d899, &function_a60818283e20d544);
      waitframe();

      if(level.var_d0a4be7987e2d899.size > 0) {
        flood_spawn(level.var_d0a4be7987e2d899);
      }

      level.var_a197028abd667a3a = getspawnerarray("sp_chunnel_new_konni_flood_right");
      array_spawn_function(level.var_a197028abd667a3a, &function_a60818283e20d544);
      waitframe();

      if(level.var_a197028abd667a3a.size > 0) {
        flood_spawn(level.var_a197028abd667a3a);
      }

      flag_set("flg_flood_combat_B_spawn_check");
    }

    wait 1;
  }
}

function function_58f9cdb507700d0() {
  flag_wait_any("flg_crossover_juggernaut_both_dead", "flg_crossover_exit_reached");

  if(flag("flg_flood_combat_B_spawn_check")) {
    wait 1;
    thread scripts\sp\spawner::killspawner(20);
    thread scripts\sp\spawner::killspawner(21);
  } else {
    thread scripts\sp\spawner::killspawner(20);
    thread scripts\sp\spawner::killspawner(21);
  }

  flag_set("flg_crossover_finale_flood_killed");
}

function function_20799f520968e46d() {
  self endon("death");
  self endon("entitydeleted");
  self.goalradius = 32;
  self.team = "axis";
  self.grenadeammo = 0;
  self.baseaccuracy = 0.5;
}

function function_a60818283e20d544() {
  self endon("death");
  self endon("entitydeleted");
  var_c959dbab8af7a289 = getEnt("vol_crossover_ca_b_left", "targetname");
  var_b3b8b36f4c55caea = getEnt("vol_crossover_ca_b_right", "targetname");
  self.goalradius = 32;
  self.team = "axis";
  self.grenadeammo = 0;
  self.baseaccuracy = 0.5;

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "konni_flood_ca_b_left") {
    self setgoalvolumeauto(var_c959dbab8af7a289);
    return;
  }

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "konni_flood_ca_b_right") {
    self setgoalvolumeauto(var_b3b8b36f4c55caea);
    return;
  }

  self setgoalentity(level.player);
}

function function_e2cdc525916b0351() {
  self endon("death");
  self endon("entitydeleted");
  self.goalradius = 32;
  self.team = "axis";
  self.grenadeammo = 0;
  self.baseaccuracy = 0.7;
  self.attackeraccuracy = 1.2;
  wait randomfloatrange(1, 5);

  if(!flag("vol_crossover_finale_retreat")) {
    self getenemyinfo(level.player);
    self setgoalentity(level.player);
  }
}

function juggernaut_handler() {
  self endon("death");
  self endon("entitydeleted");
  self.goalradius = 32;
  self.team = "axis";
  self.grenadeammo = 0;
  self.baseaccuracy = 2;
  utility::set_attackeraccuracy(0.6);
  var_b1f0bb627172930a = self.health / 3;

  while(true) {
    if(self.health < var_b1f0bb627172930a) {
      set_favoriteenemy(level.player);
      self getenemyinfo(level.player);
      self setgoalpos(level.player.origin);
    }

    wait 1;
  }
}

function function_627393ab58d2ddd9() {
  level.var_5e64b5358f867b1 waittill_any("death");
  flag_set("flg_crossover_jugg_intro_killed");
  autosave_by_name();
  level function_87a70036926b2c90("chunnel_crossover_player_progress");
}

function function_3aeba59dd4205b9d() {
  level.var_336492f2b1af40d5 waittill_any("death");
  flag_set("flag_crossover_juggernaut_reinforcement_killed");
  autosave_by_name();
  level function_87a70036926b2c90("chunnel_crossover_player_progress");
}

function function_3c1ac0d5e25a00f7() {
  flag_wait("flg_crossover_jugg_intro_path_complete");

  if(!flag("flg_crossover_jugg_intro_killed")) {
    level.var_5e64b5358f867b1.var_c833409fb72d15fb = 0;
  }
}

function function_c3de24939097aabb() {
  level.var_336492f2b1af40d5.var_c833409fb72d15fb = 1;
  wait randomfloatrange(5, 8);

  if(!flag("flag_crossover_juggernaut_reinforcement_killed")) {
    level.var_336492f2b1af40d5.var_c833409fb72d15fb = 0;
  }
}

function function_6cca66171b2b63df() {
  self endon("death");
  self endon("entitydeleted");
  var_e3e895706ff4107c = self.health;
  var_e07eabfebbfc494b = float(var_e3e895706ff4107c / 3);
  var_589d1f841f9ca099 = float(var_e07eabfebbfc494b * 2);

  while(self.health > 10) {
    if(self.health < var_589d1f841f9ca099 && self.health > var_e07eabfebbfc494b) {
      utility::set_attackeraccuracy(0.4);
    }

    if(self.health < var_e07eabfebbfc494b) {
      utility::set_attackeraccuracy(0.2);
    }

    wait 1;
  }
}

function function_c8361bd9f9570344() {
  var_587a8475a827b5b9 = getaiarray("axis");

  while(!flag("flg_crossover_combat_a_save")) {
    var_587a8475a827b5b9 = array_removedead_or_dying(var_587a8475a827b5b9);

    if(var_587a8475a827b5b9.size < 1 && flag("flg_crossover_turret_removed")) {
      autosave_by_name();
      level function_87a70036926b2c90("chunnel_crossover_player_progress");
      flag_set("flg_crossover_combat_a_save");
    }

    wait 1;
  }
}

function function_9c042f84a06d478f() {
  level endon("flg_crossover_second_combat_area");

  while(true) {
    var_76cee3ef6e992f95 = getaiarray("axis");
    var_76cee3ef6e992f95 = array_removedead_or_dying(var_76cee3ef6e992f95);

    if(var_76cee3ef6e992f95.size < 3) {
      flag_set("flg_chunnel_crossover_advance_enemies_cleared");
      break;
    }

    wait 1;
  }
}

function function_9065900991499881() {
  level.var_a8324d317acdb068 = array_removedead_or_dying(level.var_a8324d317acdb068);

  foreach(ai in level.var_a8324d317acdb068) {
    ai cleargoalentity();
    waitframe();
    ai setgoalvolumeauto(getEnt("vol_crossover_finale_retreat", "targetname"));
  }

  ai_delete_when_out_of_sight(level.var_a8324d317acdb068, 512);
}

function function_58a8d8eec289795c() {}

function function_befeeff610a09de0() {}

function function_9f8ff5c7872a880d() {
  function_109726d29627f8de();
  set_start_location("s_start_chunnel_finale", array_combine([level.player], level.var_679be75090dd2a47));
  level thread function_791c2eb990017928();
  function_75519ed05932e7ac();
  thread door_anims();
  level thread train_loop(level.var_f76b2ac280893f92, "s_train_02_sound");
  delaythread(3, &train_loop, level.var_f76b29c280893d5f, "s_train_01_sound");
  var_eccb17617e11cb54 = getEntArray("e_soap_corpse_brush", "targetname");

  foreach(e_soap_corpse_brush in var_eccb17617e11cb54) {
    e_soap_corpse_brush notsolid();
  }
}

function function_933c5b68b5a0d566() {
  autosave_by_name();
  level thread namespace_fc0114e844f0b4c::function_91db77148cb4384d(undefined, undefined, "flag_chunnel_finale_stop_nags", "chunnel_finale_player_progress");
  exploder("vfx_finale_device_red_glow_2");
  exploder("vfx_finale_device_red_glow_1");
  exploder("vfx_finale_env");
  level thread function_49def9f50ca04737();
  level thread function_3c450c959e76d5d();
  level thread function_4f90d72eadd3c142();
  level thread function_14e5fdd07a28343b();
  level thread function_720672c985c9e801();
  level thread function_f99d75a81a420b4f();
  level thread function_f99d76a81a420d82();
  level thread function_f99d77a81a420fb5();
  thread function_f9b3b24c9ce60b99();
  var_de2278b60aa9ab33 = getStruct("s_interact_defuse_bomb", "targetname");
  var_3616f81650fe11b6 = getStruct("s_interact_finale_bomb", "targetname");
  var_b6409e25f9087e9c = getStruct("s_struct_bottom_wire", "targetname");
  level thread namespace_85a51fd192b9a590::function_33f9e1adaa635e0e();
  level thread namespace_85a51fd192b9a590::function_700df35a6a18c420();

  while(!isDefined(level.var_f119a54aa1b67293)) {
    waitframe();
  }

  thread function_7efaee8d944d6157();
  level.ai_soap waittill("goal");
  flag_wait("flag_chunnel_finale_wave_1_dead");
  flag_wait("flg_finale_start_defuse");
  level thread function_ea6e1cd9a0f0ef8e("flag_chunnel_finale_wave_1_dead");
  thread scene_0900();
  level thread function_7e22ebf5fe63c225();
  level flag_wait_all("flg_start_wave_two", "flg_player_near_bomb");
  level function_d962f42ac75f265f("flag_chunnel_finale_stop_nags");
  level.var_a75197125609fc63 = 0;
  level thread function_ea6e1cd9a0f0ef8e("flag_chunnel_finale_wave_2_dead");
  level thread function_40440737898c08c4("flag_chunnel_finale_wave_2_dead");
  level thread function_9184ffdb9cd062e7(var_de2278b60aa9ab33.origin);
  level flag_wait("flg_start_enter_nags");
  var_42dbc6c6470a00bc = getStruct("s_crossover_sentry", "targetname");
  level thread function_c01ae6bb604460df(var_42dbc6c6470a00bc.origin, 900);
  var_de2278b60aa9ab33 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"SP_JUP_SURGE/FINALE_SNAKE_CAM", 35, 4000, 100, 0, undefined, undefined, undefined, undefined, undefined, undefined, 180);
  var_de2278b60aa9ab33 thread function_22556c65fe565a();
  var_de2278b60aa9ab33 waittill("trigger");
  registered = "igc_chunnel_defuse_bomb";
  level.player val::set(registered, "show_weapon_hud", 0);
  level.player val::set(registered, "show_hud", 0);
  level flag_set("flg_first_bomb_interact_complete");
  level flag_wait("flg_cable_cut_enter_complete");
  flag_clear("flg_cannot_save_start");
  autosave_by_name();
  function_ccc7c593c3e015cf("flag_defusal_1_success", 1);
  level.var_a75197125609fc63 = 0;
  level thread function_ea6e1cd9a0f0ef8e("flag_chunnel_finale_wave_3_dead");
  level thread function_40440737898c08c4("flag_chunnel_finale_wave_3_dead");
  level thread function_7637e32cba8fb5df(var_de2278b60aa9ab33, "flag_chunnel_finale_wave_3_dead");
  level flag_wait("flg_alt_enter_2_complete");
  thread function_74b501bb14dd7dcd();
  thread function_78efabca8ec83fc3();
  flag_clear("flg_cannot_save_start");
  autosave_by_name();
  function_ccc7c593c3e015cf("flag_defusal_2_success", 0, 1);
  clearallcorpses();
}

function function_49def9f50ca04737() {
  level.ai_soap waittill("start_wave_two_konni");
  flag_set("flg_finale_wave2_ready");
}

function function_9184ffdb9cd062e7(pos) {
  level.player endon("death");
  utility::flag_wait("flag_chunnel_finale_wave_2_dead");
  corpses = getcorpsearrayinradius(pos, 40);

  while(!flag("flg_start_enter_nags") && corpses.size > 0) {
    removed_corpse = 0;
    player_fwd = level.player getplayercameraangles();

    foreach(corpse in corpses) {
      to_corpse = vectorNormalize(corpse.origin - level.player.origin);
      dot = vectordot(player_fwd, to_corpse);

      if(dot > 0.1) {
        corpse delete();
        removed_corpse = 1;
      }
    }

    if(removed_corpse) {
      corpses = getcorpsearrayinradius(pos, 40);
    }

    waitframe();
  }

  foreach(corpse in corpses) {
    corpse delete();
  }
}

function function_720672c985c9e801() {
  var_700d131932adbf02 = getEntArray("e_chunnel_finale_ghost_cover_1", "targetname");

  foreach(e_chunnel_finale_ghost_cover_1 in var_700d131932adbf02) {
    e_chunnel_finale_ghost_cover_1 solid();
    e_chunnel_finale_ghost_cover_1 disconnectPaths();
  }

  var_700d121932adbccf = getEntArray("e_chunnel_finale_ghost_cover_2", "targetname");

  foreach(e_chunnel_finale_ghost_cover_2 in var_700d121932adbccf) {
    e_chunnel_finale_ghost_cover_2 notsolid();
    e_chunnel_finale_ghost_cover_2 connectpaths();
  }
}

function function_64746350130278() {
  var_700d131932adbf02 = getEntArray("e_chunnel_finale_ghost_cover_1", "targetname");

  foreach(e_chunnel_finale_ghost_cover_1 in var_700d131932adbf02) {
    e_chunnel_finale_ghost_cover_1 notsolid();
    e_chunnel_finale_ghost_cover_1 connectpaths();
  }

  var_700d121932adbccf = getEntArray("e_chunnel_finale_ghost_cover_2", "targetname");

  foreach(e_chunnel_finale_ghost_cover_2 in var_700d121932adbccf) {
    e_chunnel_finale_ghost_cover_2 solid();
    e_chunnel_finale_ghost_cover_2 disconnectPaths();
  }
}

function function_ea6e1cd9a0f0ef8e(var_1bcc95a8574384a4) {
  flag_wait(var_1bcc95a8574384a4);

  if(!flag("flg_cannot_save_start")) {
    autosave_by_name();
  }
}

function function_3c450c959e76d5d() {
  level endon("flg_chunnel_pre_bomb_player_on_left");
  var_a4fdd868f4026ce9 = getspawnerarray("ai_chunnel_defuse_sfo_left");
  flag_wait("flg_chunnel_pre_bomb_player_on_right");
  level thread function_a66a4cae910c9eb();
  var_a4fdd868f4026ce9 = array_spawn(var_a4fdd868f4026ce9, 1);

  foreach(ai in var_a4fdd868f4026ce9) {
    ai thread scripts\common\ai::magic_bullet_shield();
    ai enable_dontevershoot();
    ai.goalradius = 32;
    ai.pushable = 0;
    ai.script_pushable = 0;
    ai.grenadeammo = 0;
    ai.baseaccuracy = 0.4;
    ai function_16a594417ddabeb1();
    ai thread function_a8d01dcc629d8524(undefined, 0);
    ai thread function_a17e56d75ec3efbd();
  }

  if(isDefined(var_a4fdd868f4026ce9) && isDefined(var_a4fdd868f4026ce9[0])) {
    level.var_ed5a4d7626f6868 = var_a4fdd868f4026ce9[0];
  }

  level.player waittill_any("weapon_fired", "grenade_fire", "stealth_spotted", "flag_finale_enemies_wave_1_spawns", "flag_finale_walker_at_node");
  flag_set("flag_allies_can_shoot");

  foreach(ai in var_a4fdd868f4026ce9) {
    if(isDefined(ai) && isalive(ai)) {
      ai disable_dontevershoot();
    }
  }

  flag_wait("flg_chunnel_diffuse_done");

  foreach(ai in var_a4fdd868f4026ce9) {
    if(isDefined(ai) && isalive(ai)) {
      ai stop_magic_bullet_shield();
      ai delete();
    }
  }
}

function function_4f90d72eadd3c142() {
  level endon("flg_chunnel_pre_bomb_player_on_right");
  var_c3c127fd4a390cca = getspawnerarray("ai_chunnel_defuse_sfo_right");
  flag_wait("flg_chunnel_pre_bomb_player_on_left");
  level thread function_d194ce06aa7d879e();
  var_c3c127fd4a390cca = array_spawn(var_c3c127fd4a390cca, 1);

  foreach(ai in var_c3c127fd4a390cca) {
    ai thread scripts\common\ai::magic_bullet_shield();
    ai enable_dontevershoot();
    ai.goalradius = 32;
    ai.pushable = 0;
    ai.script_pushable = 0;
    ai.grenadeammo = 0;
    ai.baseaccuracy = 0.4;
    ai function_16a594417ddabeb1();
    ai thread function_a8d01dcc629d8524(undefined, 0);
    ai thread function_a17e56d75ec3efbd();
  }

  if(isDefined(var_c3c127fd4a390cca) && isDefined(var_c3c127fd4a390cca[0])) {
    level.var_ed5a4d7626f6868 = var_c3c127fd4a390cca[0];
  }

  level.player waittill_any("weapon_fired", "grenade_fire", "stealth_spotted", "flag_finale_enemies_wave_1_spawns", "flag_finale_walker_at_node");
  flag_set("flag_allies_can_shoot");

  foreach(ai in var_c3c127fd4a390cca) {
    if(isDefined(ai) && isalive(ai)) {
      ai disable_dontevershoot();
    }
  }

  flag_wait("flg_chunnel_diffuse_done");

  foreach(ai in var_c3c127fd4a390cca) {
    if(isDefined(ai) && isalive(ai)) {
      ai stop_magic_bullet_shield();
      ai delete();
    }
  }
}

function function_a17e56d75ec3efbd() {
  self endon("death");
  flag_wait("flag_chunnel_finale_wave_1_dead");

  if(isDefined(self.script_parameters) && self.script_parameters == "finale_sfo_1") {
    node = getnode("n_chunnel_finale_sfo_guy_1_pos_1", "targetname");
    self.ignoreme = 0;
    self.ignoreall = 0;
    self.goalradius = 32;
    thread scripts\sp\spawner::go_to_node(node);
  }

  if(isDefined(self.script_parameters) && self.script_parameters == "finale_sfo_2") {
    node = getnode("n_chunnel_finale_sfo_guy_2_pos_1", "targetname");
    self.ignoreme = 0;
    self.ignoreall = 0;
    self.goalradius = 32;
    thread scripts\sp\spawner::go_to_node(node);
  }

  if(isDefined(self.script_parameters) && self.script_parameters == "finale_sfo_3") {
    node = getnode("n_chunnel_finale_sfo_guy_3_pos_1", "targetname");
    self.ignoreme = 0;
    self.ignoreall = 0;
    self.goalradius = 32;
    thread scripts\sp\spawner::go_to_node(node);
  }

  if(isDefined(self.script_parameters) && self.script_parameters == "finale_sfo_4") {
    node = getnode("n_chunnel_finale_sfo_guy_4_pos_1", "targetname");
    self.ignoreme = 0;
    self.ignoreall = 0;
    self.goalradius = 32;
    thread scripts\sp\spawner::go_to_node(node);
  }

  level flag_wait("flg_start_wave_two");
  wait 1.5;

  if(isDefined(self.script_parameters) && self.script_parameters == "finale_sfo_2") {
    s_mb_start = getEnt("s_finale_mb_start", "targetname");
    wait 3;
    thread scripts\common\ai::stop_magic_bullet_shield();
    self.health = 1;
    mb_end = self getEye();
    level thread function_1f37c67eddb84617(s_mb_start, mb_end);
    wait 0.5;
    self kill();
  }

  if(isDefined(self.script_parameters) && self.script_parameters == "finale_sfo_3") {
    s_mb_start = getEnt("s_finale_mb_start", "targetname");
    mb_end = self getEye();
    wait 3.5;
    thread scripts\common\ai::stop_magic_bullet_shield();
    self.health = 1;
    mb_end = self getEye();
    level thread function_1f37c67eddb84617(s_mb_start, mb_end);
    wait 0.5;
    self kill();
  }

  if(isDefined(self.script_parameters) && self.script_parameters == "finale_sfo_1") {
    node = getnode("n_chunnel_finale_sfo_guy_1_pos_2", "targetname");
    thread scripts\sp\spawner::go_to_node(node);
  }

  if(isDefined(self.script_parameters) && self.script_parameters == "finale_sfo_4") {
    node = getnode("n_chunnel_finale_sfo_guy_4_pos_2", "targetname");
    thread scripts\sp\spawner::go_to_node(node);
  }

  flag_wait("flg_cable_cut_enter_complete");

  if(isDefined(self.script_parameters) && self.script_parameters == "finale_sfo_1") {
    s_mb_start = getEnt("s_finale_mb_start", "targetname");
    node = getnode("n_chunnel_finale_sfo_guy_1", "targetname");
    teleport_ai(node);
    flag_wait("flag_defusal_1_success");
    wait 3.5;
    thread scripts\common\ai::stop_magic_bullet_shield();
    self.health = 1;
    mb_end = self getEye();
    level thread function_1f37c67eddb84617(s_mb_start, mb_end);
    wait 0.5;
    self kill();
  }

  if(isDefined(self.script_parameters) && self.script_parameters == "finale_sfo_4") {
    s_mb_start = getEnt("s_finale_mb_start", "targetname");
    node = getnode("n_chunnel_finale_sfo_guy_2", "targetname");
    teleport_ai(node);
    flag_wait("flag_defusal_1_success");
    wait 3;
    thread scripts\common\ai::stop_magic_bullet_shield();
    self.health = 1;
    mb_end = self getEye();
    level thread function_1f37c67eddb84617(s_mb_start, mb_end);
    wait 0.5;
    self kill();
  }
}

function function_1f37c67eddb84617(s_mb_start, mb_end) {
  var_3ece7b7d1fb721c5 = 0;
  var_53ec8383ce01d315 = 9;

  while(var_3ece7b7d1fb721c5 < var_53ec8383ce01d315) {
    magicbullet("iw9_ar_akilo_sp", s_mb_start.origin, mb_end);
    var_3ece7b7d1fb721c5 += 1;
    wait 0.1;
  }
}

function function_f30d620a933b6070() {
  var_cfff07c0453cc4f9 = getspawnerarray("ai_chunnel_finale_faction_fight");
  var_cfff07c0453cc4f9 = array_spawn(var_cfff07c0453cc4f9, 1);

  foreach(ai in var_cfff07c0453cc4f9) {
    ai magic_bullet_shield();
  }

  flag_wait("flg_cable_cut_scene_complete");

  foreach(ai in var_cfff07c0453cc4f9) {
    if(isDefined(ai) && isalive(ai)) {
      ai stop_magic_bullet_shield();
      ai delete();
    }
  }
}

function function_f99d75a81a420b4f() {
  var_3ef7ac4c51bb3a60 = getspawnerarray("ai_chunnel_enemies_wave_1");

  foreach(spawner in var_3ef7ac4c51bb3a60) {
    spawner.script_stealthgroup = "ai_chunnel_enemies_wave_1";
  }

  level.var_3ef7ac4c51bb3a60 = array_spawn(var_3ef7ac4c51bb3a60, 1);

  foreach(ai in level.var_3ef7ac4c51bb3a60) {
    ai.goalradius = 32;
    ai.fixednode = 1;
    ai.grenadeammo = 0;
    ai.var_98add129a7ecb962 = 0;

    if(isDefined(ai.script_noteworthy) && ai.script_noteworthy == "konni_chunnel_finale_bomber") {
      level.var_c80b9216ff9840e1 = ai;
      ai set_pacifist(0);
      ai.fixednode = 0;
      ai thread function_5e2fef0b091d328b();
      continue;
    }

    if(isDefined(ai.script_noteworthy) && ai.script_noteworthy == "konni_chunnel_finale_bomb_assistant") {
      ai.animname = "generic";
      ai set_deathanim("sdr_com_exp_crouch_death01_head_med_6");
      level thread function_553624d50b1017a4(ai);
      continue;
    }

    if(isDefined(ai) && isalive(ai) && isDefined(ai.script_noteworthy) && ai.script_noteworthy == "wave_1_walker_right") {
      ai.fixednode = 0;
    }
  }

  flag_wait_any_timeout(7, "flag_allies_can_shoot", "flag_finale_enemies_wave_1_spawns", "flag_finale_walker_at_node");

  if(!flag("flag_allies_can_shoot")) {
    flag_set("flag_allies_can_shoot");
  }

  foreach(ai in level.var_3ef7ac4c51bb3a60) {
    if(isDefined(ai) && isalive(ai)) {
      ai set_pacifist(0);
      ai set_favoriteenemy(level.player);
    }
  }

  if(isDefined(level.ai_soap) && isalive(level.ai_soap)) {
    level.ai_soap function_60e33f7446b138d3(1);
  }

  foreach(ai in level.var_3ef7ac4c51bb3a60) {
    if(isDefined(ai) && isalive(ai) && isDefined(ai.script_noteworthy) && ai.script_noteworthy == "wave_1_front_right") {
      nd_front_right_guy = getnode("nd_front_right_guy", "targetname");
      ai thread scripts\sp\spawner::go_to_node(nd_front_right_guy);
    }
  }

  foreach(ai in level.var_3ef7ac4c51bb3a60) {
    if(isDefined(ai) && isalive(ai) && isDefined(ai.script_noteworthy) && ai.script_noteworthy == "wave_1_front_middle") {
      nd_front_middle_guy = getnode("nd_front_middle_guy", "targetname");
      ai thread scripts\sp\spawner::go_to_node(nd_front_middle_guy);
    }
  }

  foreach(ai in level.var_3ef7ac4c51bb3a60) {
    if(isDefined(ai) && isalive(ai) && isDefined(ai.script_noteworthy) && ai.script_noteworthy == "wave_1_front_left") {
      nd_front_left_guy = getnode("nd_front_left_guy", "targetname");
      ai thread scripts\sp\spawner::go_to_node(nd_front_left_guy);
    }
  }
}

function function_553624d50b1017a4(ai) {
  ai waittill("death");
  ai scripts\anim\shared::detachallweaponmodels();
}

function function_5e2fef0b091d328b() {
  self endon("death");
  self endon("entitydeleted");
  self.animname = "generic";
  var_878df2309ef4e996 = getStruct(self.target, "targetname");
  thread function_5e775d10d57c2fb1();
  level thread function_553624d50b1017a4(self);
  var_878df2309ef4e996 thread anim_loop_solo(self, var_878df2309ef4e996.animation, "stop_loop");
  value = waittill_any_ents_return(self, "damage_nonlethal", self, "damage_lethal", self, "bulletwhizby", self, "bomber_timeout_shoot", level, "flag_finale_enemies_wave_1_spawns");
  self notify("stop_loop");

  if(value == "damage_lethal") {
    var_878df2309ef4e996 anim_single_solo(self, "jup_interaction_patrol_device_low_right_death_6");
    die();
    return;
  }

  function_613f82ecdf9b56b8(1);
  var_878df2309ef4e996 anim_single_solo(self, "jup_interaction_patrol_device_low_right_react_2");
  set_deathanim("sdr_com_exp_stand_death01_gut_med_4");
}

function function_5e775d10d57c2fb1() {
  self endon("death");
  self endon("entitydeleted");
  level endon("flag_finale_enemies_wave_1_spawns");

  while(true) {
    self waittill("damage", amount);

    if(amount < 10) {
      self notify("damage_nonlethal");
      break;
    }

    self notify("damage_lethal");
    break;
  }
}

function function_f99d76a81a420d82() {
  var_3ef7af4c51bb40f9 = getspawnerarray("ai_chunnel_enemies_wave_2");
  var_da6e7ebd96aadcbb = getEnt("vol_chunnel_finale_enemy_wave_2", "targetname");
  flag_wait("flg_start_wave_two");
  thread bombdefuse_music();
  level thread function_4040ac7b205a6a7d();
  flag_wait("chunnel_finale_wave_2_smoke_done");
  level.var_3ef7af4c51bb40f9 = [];

  foreach(ai_spawner in var_3ef7af4c51bb40f9) {
    if(isDefined(ai_spawner.script_noteworthy) && ai_spawner.script_noteworthy == "finale_konni_wave2_visible") {
      ai = ai_spawner spawn_ai(0);
    } else {
      ai = ai_spawner spawn_ai(1);
    }

    if(isDefined(ai)) {
      level.var_3ef7af4c51bb40f9 = array_add(level.var_3ef7af4c51bb40f9, ai);
    }
  }

  level thread function_3025ee051d28ec46(level.var_3ef7af4c51bb40f9, "flag_chunnel_finale_wave_2_dead");

  foreach(ai in level.var_3ef7af4c51bb40f9) {
    ai.goalradius = 250;
    ai.grenadeammo = 0;
    ai.baseaccuracy = 0.3;
    ai demeanor_override("combat");
    ai.var_98add129a7ecb962 = 0;
    ai.health = 100;
    ai setgoalvolumeauto(var_da6e7ebd96aadcbb);
  }

  waittill_dead_or_dying(level.var_3ef7af4c51bb40f9, 11, 50);

  foreach(ai in level.var_3ef7af4c51bb40f9) {
    if(isDefined(ai) && isalive(ai)) {
      ai.ignoresuppression = 1;
      ai thread player_seek_enable();
      ai set_favoriteenemy(level.player);
      ai setgoalentity(level.player);
    }
  }
}

function bombdefuse_music() {
  setmusicstate("mx_surge_bomb1");
}

function function_4040ac7b205a6a7d() {
  first_struct = getStruct("finale_smoke_first", "targetname");
  second_struct = getStruct("finale_smoke_second", "targetname");
  third_struct = getStruct("finale_smoke_third", "targetname");
  end_1 = getgroundposition(first_struct.origin, 1);
  magicgrenade("smoke", first_struct.origin, end_1, 0.01, 0);
  wait 0.5;
  end_2 = getgroundposition(second_struct.origin, 1);
  magicgrenade("smoke", second_struct.origin, end_2, 0.01, 0);
  wait 1.2;
  end_3 = getgroundposition(third_struct.origin, 1);
  magicgrenade("smoke", third_struct.origin, end_3, 0.01, 0);
  flag_set("chunnel_finale_wave_2_smoke_done");
}

function function_f99d77a81a420fb5() {
  var_3ef7ae4c51bb3ec6 = getspawnerarray("ai_chunnel_enemies_wave_3");
  var_32cf69782505bc98 = getEnt("vol_chunnel_finale_enemy_wave_3", "targetname");
  flag_wait("flag_defusal_1_success");
  level.var_3ef7ae4c51bb3ec6 = array_spawn(var_3ef7ae4c51bb3ec6, 1);
  thread function_3025ee051d28ec46(level.var_3ef7ae4c51bb3ec6, "flg_script_set_finale_wave_3_dead");

  foreach(ai in level.var_3ef7ae4c51bb3ec6) {
    ai.goalradius = 250;
    ai.grenadeammo = 0;
    ai.baseaccuracy = 0.3;
    ai.health = 100;
    ai.var_98add129a7ecb962 = 0;
    ai demeanor_override("combat");
    ai setgoalvolumeauto(var_32cf69782505bc98);
  }

  waittill_dead_or_dying(level.var_3ef7ae4c51bb3ec6, 9, 50);

  foreach(ai in level.var_3ef7ae4c51bb3ec6) {
    if(isDefined(ai) && isalive(ai)) {
      ai.ignoresuppression = 1;
      ai thread player_seek_enable();
      ai set_favoriteenemy(level.player);
      ai setgoalentity(level.player);
    }
  }
}

function function_967e11f5b6c7962f() {
  level flag_set("flg_chunnel_diffuse_done");
  exploder("vfx_finale_device_red_glow_2");
  exploder("vfx_finale_device_red_glow_1");
  exploder("vfx_finale_env");
}

function function_a66a4cae910c9eb() {
  while(!isDefined(level.ai_soap)) {
    waitframe();
  }

  var_f9cf2cb94e4ab506 = getStruct("chunnel_finale_soap_left_teleport", "targetname");
  level.ai_soap forceteleport(var_f9cf2cb94e4ab506.origin, var_f9cf2cb94e4ab506.angles);
  level.ai_soap clear_force_color();
  nd_soap_finale_start = getnode("nd_soap_finale_start", "targetname");
  level.ai_soap thread scripts\sp\spawner::go_to_node(nd_soap_finale_start);
}

function function_d194ce06aa7d879e() {
  while(!isDefined(level.ai_soap)) {
    waitframe();
  }

  var_48e774284aea7b5b = getStruct("chunnel_finale_soap_right_teleport", "targetname");
  level.ai_soap forceteleport(var_48e774284aea7b5b.origin, var_48e774284aea7b5b.angles);
  level.ai_soap clear_force_color();
  nd_soap_finale_start = getnode("nd_soap_finale_start", "targetname");
  level.ai_soap thread scripts\sp\spawner::go_to_node(nd_soap_finale_start);
}

function function_7637e32cba8fb5df(var_de2278b60aa9ab33, var_f395945f361db8db) {
  b_repeat = 1;

  while(b_repeat == 1) {
    var_de2278b60aa9ab33 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"SP_JUP_SURGE/FINALE_SNAKE_CAM", 35, 4000, 100, 0, undefined, undefined, undefined, undefined, undefined, undefined, 180);
    var_de2278b60aa9ab33 thread function_22556c65fe565a();
    waittill_any_ents(var_de2278b60aa9ab33, "trigger", level, var_f395945f361db8db);
    var_de2278b60aa9ab33 scripts\sp\player\cursor_hint::remove_cursor_hint();

    if(flag(var_f395945f361db8db)) {
      var_de2278b60aa9ab33 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"SP_JUP_SURGE/FINALE_SNAKE_CAM", 35, 4000, 100, 0, undefined, undefined, undefined, undefined, undefined, undefined, 180);
      var_de2278b60aa9ab33 thread function_22556c65fe565a();
      var_de2278b60aa9ab33 waittill("trigger");
      registered = "igc_chunnel_defuse_bomb";
      level.player val::set(registered, "show_weapon_hud", 0);
      level.player val::set(registered, "show_hud", 0);

      if(var_f395945f361db8db == "flag_chunnel_finale_wave_2_dead") {
        level flag_set("flg_second_bomb_interact_complete");
      } else if(var_f395945f361db8db == "flag_chunnel_finale_wave_3_dead") {
        level flag_set("flg_third_bomb_interact_complete");
      }

      b_repeat = 0;
    } else {
      function_bfd5aaded7fa179f();
    }

    wait 1;
  }
}

function function_40440737898c08c4(var_f395945f361db8db) {
  level endon(var_f395945f361db8db);
  level endon("flg_chunnel_diffuse_done");

  while(!flag(var_f395945f361db8db) && !flag("flg_chunnel_diffuse_done")) {
    level.ai_soap waittill("damage");

    if(!level.ai_soap is_speaking()) {
      if(var_f395945f361db8db == "flag_chunnel_finale_wave_2_dead") {
        function_d04060a5afce9b12();
      } else {
        function_9c04ab74e3a428ad();
      }
    }

    wait 2;
  }
}

function function_74b501bb14dd7dcd() {
  var_7e8e9f5d94dabcca = getspawner("sp_finale_makarov", "targetname");
  level.var_85e0e3c0d71ec871 = var_7e8e9f5d94dabcca spawn_ai(1, 1);
  level.var_85e0e3c0d71ec871 setModel("body_c_jup_sp_villain_makarov_shirt");
  level.var_85e0e3c0d71ec871 detach(level.var_85e0e3c0d71ec871.headmodel);
  level.var_85e0e3c0d71ec871 attach("c_jup_head_hero_makarov", "", 1);
  level.var_85e0e3c0d71ec871.headmodel = "c_jup_head_hero_makarov";
  level.var_85e0e3c0d71ec871.ignoreme = 1;
  level.var_85e0e3c0d71ec871.ignoreall = 1;
  level.var_85e0e3c0d71ec871.animname = "makarov";
  level.var_85e0e3c0d71ec871 set_name("Makarov");
  level.var_85e0e3c0d71ec871.dropweapon = 0;
  level.var_85e0e3c0d71ec871 gun_remove();
  var_2f2ebf3f037bece1 = getspawner("sp_konni_guy_1", "targetname");
  var_d9eed191f4441050 = getspawner("sp_konni_guy_2", "targetname");
  var_c68ba806e0b9a6af = getspawner("sp_konni_guy_3", "targetname");
  var_af395c362ab109f6 = getspawner("sp_konni_guy_4", "targetname");
  level.outro_konni1 = var_2f2ebf3f037bece1 spawn_ai(1, 0);
  level.outro_konni2 = var_d9eed191f4441050 spawn_ai(1, 0);
  level.outro_konni3 = var_c68ba806e0b9a6af spawn_ai(1, 0);
  level.outro_konni4 = var_af395c362ab109f6 spawn_ai(1, 0);
  waitframe();
  level.outro_konni1 setgoalpos(level.outro_konni1.origin);
  level.outro_konni1.fixednode = 1;
  level.outro_konni2 setgoalpos(level.outro_konni2.origin);
  level.outro_konni2.fixednode = 1;
  level.outro_konni3 setgoalpos(level.outro_konni3.origin);
  level.outro_konni3.fixednode = 1;
  level.outro_konni4 setgoalpos(level.outro_konni4.origin);
  level.outro_konni4.fixednode = 1;
  level.var_85e0e3c0d71ec871 setgoalpos(level.var_85e0e3c0d71ec871.origin);
  level.var_85e0e3c0d71ec871.fixednode = 1;
  level.outro_konni1.ignoreme = 1;
  level.outro_konni1.ignoreall = 1;
  level.outro_konni2.ignoreme = 1;
  level.outro_konni2.ignoreall = 1;
  level.outro_konni3.ignoreme = 1;
  level.outro_konni3.ignoreall = 1;
  level.outro_konni4.ignoreme = 1;
  level.outro_konni4.ignoreall = 1;
  level.outro_konni1 context_melee_allow(0);
  level.outro_konni2 context_melee_allow(0);
  level.outro_konni3 context_melee_allow(0);
  level.outro_konni4 context_melee_allow(0);
  level.outro_konni1.animname = "generic";
  level.outro_konni2.animname = "generic";
  level.outro_konni3.animname = "generic";
  level.outro_konni4.animname = "generic";
  level.outro_konni1 set_deathanim("jup_surge_0900_defuse_fight_dead_enemy01");
  level.outro_konni2 set_deathanim("jup_surge_0900_defuse_fight_dead_enemy02");
  level.outro_konni3 set_deathanim("jup_surge_0900_defuse_fight_dead_enemy03");
  level.outro_konni4 set_deathanim("jup_surge_0900_defuse_fight_dead_enemy04");
  level flag_set("flg_fight_scene_enemies_ready");
  level flag_wait("flg_cable_cut_scene_complete");
  array_spawn_function_targetname("sp_finale_konni_shield", &function_3557dfa92181d60b);
  level.var_e36f079077e42ab9 = array_spawn_targetname("sp_finale_konni_shield", 1, 1);

  foreach(var_eee6b70b08de211e in level.var_e36f079077e42ab9) {
    var_eee6b70b08de211e.ignoreme = 1;
    var_eee6b70b08de211e.ignoreall = 1;
    var_eee6b70b08de211e.animname = "generic";
  }

  var_101496445e7d271d = getspawner("sp_finale_konni_shield_3", "targetname");
  level.var_fc28037722b41a8a = var_101496445e7d271d spawn_ai(1, 0);
  level.var_fc28037722b41a8a.ignoreme = 1;
  level.var_fc28037722b41a8a.ignoreall = 1;
  level.var_fc28037722b41a8a disable_pain();

  foreach(var_5957447be5010c29 in level.var_e36f079077e42ab9) {
    if(isDefined(var_5957447be5010c29)) {
      if(isDefined(var_5957447be5010c29.script_noteworthy) && var_5957447be5010c29.script_noteworthy == "finale_konni_left") {
        var_5957447be5010c29 setgoalnode(getnode("nd_chunnel_finale_konni_end_l", "targetname"));
        continue;
      }

      if(isDefined(var_5957447be5010c29.script_noteworthy) && var_5957447be5010c29.script_noteworthy == "finale_konni_right") {
        var_5957447be5010c29 setgoalnode(getnode("nd_chunnel_finale_konni_end_r", "targetname"));
      }
    }
  }

  level.var_fc28037722b41a8a thread function_3f7cfb3ecf12d03f();
  level flag_wait("flg_plr_fight_complete");

  foreach(var_eee6b70b08de211e in level.var_e36f079077e42ab9) {
    var_eee6b70b08de211e.ignoreall = 0;
  }

  wait 3;
  level flag_set("flg_start_bodyguard_retreat");
  var_bee339bdcfc49a26 = getnodearray("nd_chunnel_finale_konni_start", "targetname");

  if(isDefined(level.var_e36f079077e42ab9[0]) && isalive(level.var_e36f079077e42ab9[0])) {
    level.var_e36f079077e42ab9[0] thread scripts\common\anim::anim_single_solo(level.var_e36f079077e42ab9[0], "sdr_com_strafe_jog_start_2");
  }

  if(isDefined(level.var_e36f079077e42ab9[1]) && isalive(level.var_e36f079077e42ab9[1])) {
    level.var_e36f079077e42ab9[1] thread scripts\common\anim::anim_single_solo(level.var_e36f079077e42ab9[1], "sdr_com_strafe_jog_start_2");
  }

  level.var_85e0e3c0d71ec871 waittill("goal");
  flag_set("flg_makarov_gone");

  if(isDefined(level.var_85e0e3c0d71ec871) && isalive(level.var_85e0e3c0d71ec871)) {
    if(isDefined(level.var_85e0e3c0d71ec871.magic_bullet_shield)) {
      level.var_85e0e3c0d71ec871 stop_magic_bullet_shield();
    }

    level.var_85e0e3c0d71ec871 delete();
  }

  foreach(var_eee6b70b08de211e in level.var_e36f079077e42ab9) {
    if(isDefined(var_eee6b70b08de211e) && isalive(var_eee6b70b08de211e)) {
      var_eee6b70b08de211e delete();
    }
  }

  level.var_e36f079077e42ab9 = undefined;
  level.var_fc28037722b41a8a = undefined;
}

function function_3f7cfb3ecf12d03f() {
  self endon("death");
  self endon("entitydeleted");
  set_goalRadius(32);
  disable_pain();
  self setgoalnode(getnode("nd_chunnel_finale_konni_s_3", "targetname"));
  wait 21;
  self.ignoreall = 0;
  s_mb_heroes_gaz = getStruct("s_mb_heroes_gaz", "targetname");
  var_fcd86042abe45d58 = spawn_tag_origin(s_mb_heroes_gaz.origin, s_mb_heroes_gaz.angles);
  self setentitytarget(var_fcd86042abe45d58, 1);
  level flag_wait("flg_plr_fight_complete");
  self clearentitytarget(var_fcd86042abe45d58);
  self setgoalnode(getnode("nd_chunnel_finale_konni_e_3", "targetname"));
}

function function_78efabca8ec83fc3() {
  var_b2926e65e125202e = getspawner("sp_chunnel_finale_gaz", "targetname");
  var_56ba20f1152d5edb = getspawner("sp_chunnel_finale_ghost", "targetname");
  level.var_d18d63c6d75cd1e = var_b2926e65e125202e spawn_ai(1, 1);
  level.ai_ghost = var_56ba20f1152d5edb spawn_ai(1, 1);
  waitframe();
  level.ai_ghost.animname = "ghost";
  level.ai_ghost.script_noteworthy = "ghost";
  level.ai_ghost set_name("Ghost");
  level.ai_ghost.callsign = "Bravo 0-7";
  level.ai_ghost function_c1e075c4168a8bea(0, 0);
  level.var_d18d63c6d75cd1e.animname = "gaz";
  level.var_d18d63c6d75cd1e.script_noteworthy = "gaz";
  level.var_d18d63c6d75cd1e set_name("Gaz");
  level.var_d18d63c6d75cd1e.callsign = "Bravo 6-1";
  level.var_d18d63c6d75cd1e function_c1e075c4168a8bea(0, 0);
  var_c22f1f4f956e1401 = getnode("n_chunnel_finale_gaz_post", "targetname");
  var_cc848cd3c02d5a10 = getnode("n_chunnel_finale_ghost_post", "targetname");
  level.var_d18d63c6d75cd1e forceteleport(var_c22f1f4f956e1401.origin, var_c22f1f4f956e1401.angles);
  level.ai_ghost forceteleport(var_cc848cd3c02d5a10.origin, var_cc848cd3c02d5a10.angles);
  level.var_d18d63c6d75cd1e setgoalnode(var_c22f1f4f956e1401);
  level.ai_ghost setgoalnode(var_cc848cd3c02d5a10);
  level.var_d18d63c6d75cd1e setgoalpos(level.var_d18d63c6d75cd1e.origin);
  level.var_d18d63c6d75cd1e.fixednode = 1;
  level.ai_ghost setgoalpos(level.ai_ghost.origin);
  level.ai_ghost.fixednode = 1;
  level flag_set("flg_fight_scene_ai_ready");
}

function function_cdf46b9810b31846(f_delay, var_53ec8383ce01d315, str_type) {
  self endon("death");
  self endon("entitydeleted");
  wait f_delay;
  mb_finale_dest_allies = getStructArray("mb_finale_dest_allies", "targetname");
  var_be6136b401b004bd = self.primaryweapon;

  if(isDefined(var_be6136b401b004bd)) {
    var_53ec8383ce01d315 = var_53ec8383ce01d315;
    var_12ae061696db5d96 = var_be6136b401b004bd.firetime;
    var_3ece7b7d1fb721c5 = 0;
    var_6a9057a7bee2746 = 0;

    while(true) {
      while(var_3ece7b7d1fb721c5 < var_53ec8383ce01d315) {
        var_467156cf0d0a3dde = array_random(mb_finale_dest_allies);
        magicbullet(var_be6136b401b004bd.basename, self gettagorigin("tag_flash"), var_467156cf0d0a3dde.origin, self, self);
        var_3ece7b7d1fb721c5 += 1;

        if(var_3ece7b7d1fb721c5 == var_53ec8383ce01d315) {
          var_3ece7b7d1fb721c5 = 0;
          wait 0.5;
          continue;
        }

        wait var_12ae061696db5d96;
      }

      waitframe();
    }
  }
}

function function_8f7f23310949fa59() {
  flag_wait("flg_magic_bullet_start");
  var_da979e226383e19a = getStructArray("mb_finale_dest", "targetname");
  var_400cb257849556ed = level.var_d18d63c6d75cd1e.primaryweapon;
  var_53ec8383ce01d315 = 8;
  var_12ae061696db5d96 = var_400cb257849556ed.firetime * 3;
  var_3ece7b7d1fb721c5 = 0;
  var_6a9057a7bee2746 = 0;
  delaythread(3.5, &flag_set, "flg_finale_gaz_no_shoot");
  delaythread(4.5, &flag_clear, "flg_finale_gaz_no_shoot");
  delaythread(8, &flag_set, "flg_finale_gaz_no_shoot");

  while(true) {
    while(var_6a9057a7bee2746 < 99 && !flag("flg_finale_gaz_no_shoot")) {
      while(var_3ece7b7d1fb721c5 < var_53ec8383ce01d315) {
        var_c2b855ab434d98ee = array_random(var_da979e226383e19a);
        magicbullet(var_400cb257849556ed.basename, level.var_d18d63c6d75cd1e gettagorigin("tag_flash"), var_c2b855ab434d98ee.origin, level.var_d18d63c6d75cd1e, level.var_d18d63c6d75cd1e);
        var_3ece7b7d1fb721c5 += 1;

        if(var_3ece7b7d1fb721c5 == var_53ec8383ce01d315) {
          var_6a9057a7bee2746 += 1;
          wait 0.25;
          continue;
        }

        wait var_12ae061696db5d96;
      }

      var_3ece7b7d1fb721c5 = 0;
      wait 0.5;
    }

    var_3ece7b7d1fb721c5 = 0;
    wait 0.01;
  }

  wait 0.01;
}

function function_2b58456d0720372c() {
  flag_wait("flg_magic_bullet_start");
  var_da979e226383e19a = getStructArray("mb_finale_dest", "targetname");
  var_400cb257849556ed = level.ai_ghost.primaryweapon;
  var_53ec8383ce01d315 = 99;
  var_12ae061696db5d96 = var_400cb257849556ed.firetime;
  var_3ece7b7d1fb721c5 = 0;
  delaythread(2.2, &flag_set, "flg_finale_ghost_no_shoot");
  delaythread(3.5, &flag_clear, "flg_finale_ghost_no_shoot");
  delaythread(8, &flag_set, "flg_finale_ghost_no_shoot");

  while(true) {
    while(var_3ece7b7d1fb721c5 < var_53ec8383ce01d315 && !flag("flg_finale_ghost_no_shoot")) {
      var_c2b855ab434d98ee = array_random(var_da979e226383e19a);
      magicbullet(var_400cb257849556ed.basename, level.ai_ghost gettagorigin("tag_flash_silenced"), var_c2b855ab434d98ee.origin, level.ai_ghost, level.ai_ghost);
      var_3ece7b7d1fb721c5 += 1;

      if(var_3ece7b7d1fb721c5 == var_53ec8383ce01d315) {
        wait 1;
        continue;
      }

      wait var_12ae061696db5d96;
    }

    wait 0.1;
  }
}

function function_98fc577b76b69ab9() {
  flag_wait("flg_gaz_ghost_fight_complete");
  var_bb9aad295e433aa8 = getStruct("s_mb_heroes_gaz", "targetname");
  var_10f4914fb2f63fc1 = getStruct("s_mb_heroes_ghost", "targetname");
  var_c4fd7e4bf31e2980 = level.outro_konni2 gettagorigin("J_Head");
  var_c4fd814bf31e3019 = level.outro_konni1 gettagorigin("J_Head");
  var_2c602f5c85c45994 = level.var_d18d63c6d75cd1e.primaryweapon;
  var_f9e52d2131aea27c = 5;
  var_d21e058323440c9f = var_2c602f5c85c45994.firetime;
  var_c84f4d0b644087ec = 0;
  var_8cd1a48c6fa5fb4d = level.ai_ghost.primaryweapon;
  var_f77a2ef7553da985 = 6;
  var_d6922a30d821f576 = var_8cd1a48c6fa5fb4d.firetime;
  var_4374fbfdad5a6bd5 = 0;

  while(var_c84f4d0b644087ec < var_f9e52d2131aea27c) {
    magicbullet(var_2c602f5c85c45994.basename, var_bb9aad295e433aa8.origin, level.outro_konni2 gettagorigin("J_Head"), level.var_d18d63c6d75cd1e, level.var_d18d63c6d75cd1e);
    bullettracer(var_bb9aad295e433aa8.origin, var_c4fd7e4bf31e2980, var_2c602f5c85c45994.basename);
    var_c84f4d0b644087ec += 1;
    wait var_d21e058323440c9f;
  }

  while(var_4374fbfdad5a6bd5 < var_f77a2ef7553da985) {
    magicbullet(var_8cd1a48c6fa5fb4d.basename, var_10f4914fb2f63fc1.origin, level.outro_konni4 gettagorigin("J_Head"), level.ai_ghost, level.ai_ghost);
    bullettracer(var_10f4914fb2f63fc1.origin, var_c4fd814bf31e3019, var_8cd1a48c6fa5fb4d.basename);
    var_4374fbfdad5a6bd5 += 1;
    wait var_d6922a30d821f576;
  }
}

function function_3557dfa92181d60b() {
  self endon("death");
  self endon("entitydeleted");
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.goalradius = 32;
  self getenemyinfo(level.player);
}

function function_ccc7c593c3e015cf(var_4c035c84c3be9449, var_2a82f328138b52e1, var_cfaf0a4e71209afa) {
  if(!isDefined(var_cfaf0a4e71209afa)) {
    var_cfaf0a4e71209afa = 0;
  }

  registered = "igc_chunnel_defuse_bomb";
  bg_hud = newhudelem();
  bg_hud.alignx = "center";
  bg_hud.aligny = "bottom";
  bg_hud.x = 320;
  bg_hud.y = 500;
  bg_hud.alpha = 1;
  bg_hud setshader("black", 9999, 999);
  level thread function_d5ba272ebe7023aa(bg_hud, var_4c035c84c3be9449, var_2a82f328138b52e1, var_cfaf0a4e71209afa);

  if(var_4c035c84c3be9449 == "flag_defusal_1_success") {
    level thread namespace_f43c40f7bcbe17e7::function_7cefb008a23b6fc0();
  } else if(var_4c035c84c3be9449 == "flag_defusal_2_success") {
    level thread namespace_f43c40f7bcbe17e7::function_7cefb308a23b7659();
  }

  flag_wait(var_4c035c84c3be9449);
  wait 1;

  if(var_4c035c84c3be9449 == "flag_defusal_1_success") {
    level.player val::set(registered, "show_weapon_hud", 1);
    level.player val::set(registered, "show_hud", 1);
  }

  thread autosave_now();
}

function function_7a9e566944c668ce() {}

function function_b6cabeecb8392d35() {
  function_109726d29627f8de();
  set_start_location("s_start_chunnel_finale", array_combine([level.player], level.var_679be75090dd2a47));
  function_75519ed05932e7ac();
  thread scene_0900();
  thread door_anims();
  thread function_74b501bb14dd7dcd();
  thread function_78efabca8ec83fc3();
  level thread function_14e5fdd07a28343b();
  level thread function_7e22ebf5fe63c225();
  var_eccb17617e11cb54 = getEntArray("e_soap_corpse_brush", "targetname");

  foreach(e_soap_corpse_brush in var_eccb17617e11cb54) {
    e_soap_corpse_brush notsolid();
  }
}

function function_fd457bdd6c88318b() {
  function_109726d29627f8de();
  set_start_location("s_start_chunnel_finale", array_combine([level.player], level.var_679be75090dd2a47));
  thread function_c934b15d2d610a5f();
}

function function_904a6347b9eaafee() {
  level flag_wait("flg_chunnel_diffuse_done");
  level.var_a75197125609fc63 = 0;
  level thread function_8f7f23310949fa59();
  level thread function_2b58456d0720372c();
  level thread function_98fc577b76b69ab9();
  level.player val::set("no_first_raise", "weapon_first_raise_anims", 0);
  level flag_wait("flg_plr_fight_complete");
  var_eccb17617e11cb54 = getEntArray("e_soap_corpse_brush", "targetname");

  foreach(e_soap_corpse_brush in var_eccb17617e11cb54) {
    e_soap_corpse_brush solid();
  }

  level.player.ignoreme = 0;
  level.var_a75197125609fc63 = 0;
  level.var_faea50695b122e76 = 200;
  level.player allowmovement(1);
  level.player showviewmodel();
  var_80951ee014229db0 = make_weapon("iw9_pi_papa220_sp", ["wounded_pistol"]);
  level.player give_weapon(var_80951ee014229db0, 0, 0, 0, 1);
  level.player switchtoweapon(var_80951ee014229db0);
  level.player val::set("defusal_interrupted", "allow_jump", 1);
  level.player val::set("defusal_interrupted", "sprint", 1);
  level.player val::set("defusal_interrupted", "supersprint", 0);
  level flag_wait("flg_start_bodyguard_retreat");
  function_537e4616fcb30ffb();
  function_c934b15d2d610a5f();
}

function function_c934b15d2d610a5f() {
  level.player scripts\sp\hud_util::fade_out(0, "black");
  hud = scripts\sp\hud_util::get_optional_overlay("black");
  hud.foreground = 0;
  level thread namespace_85a51fd192b9a590::function_449926a23c0a742b();
  flag_set("disable_autosaves");

  foreach(ai in getaiarray()) {
    if(istrue(ai.magic_bullet_shield)) {
      ai stop_magic_bullet_shield();
    }

    ai.diequietly = 1;
    ai delete();
  }

  level.player scripts\sp\player::remove_damage_effects_instantly();
  remove_equipment_immediately();
  val = "igc_chunnel_finale";
  level.player val::set(val, "weapon", 0);
  level.player val::set(val, "freezecontrols", 1);
  level.player val::set(val, "damage", 0);
  level.player val::set(val, "breath_system", 0);
  level.player val::set(val, "cg_drawcrosshair", 0);
  level.player val::set(val, "show_weapon_hud", 0);
  level.player val::set(val, "show_hud", 0);
  bg_hud = newhudelem();
  bg_hud.alignx = "center";
  bg_hud.aligny = "bottom";
  bg_hud.x = 320;
  bg_hud.y = 500;
  bg_hud.alpha = 1;
  bg_hud setshader("black", 9999, 999);
  var_5c59fc44a8dd3434 = 5;
  wait var_5c59fc44a8dd3434;
  bg_hud delaycall(var_5c59fc44a8dd3434, &destroy);

  if(level.start_point == "credits_only") {
    wait 1;
    stopcinematicingame(1);

    while(iscinematicplaying()) {
      println("<dev string:x20>");
      wait 1;
    }
  }

  setsaveddvar(@ "hash_d3ee5a6578fe61de", "1");
  setsaveddvar(@ "hash_b9ff37d084074df3", "1");
  level.player cleardamageindicators();
  cinematicingame("sp_jup_finale_cine");

  while(!iscinematicplaying()) {
    waitframe();
  }

  while(iscinematicplaying()) {
    waitframe();
  }

  level.player function_6a369480dbaf1090("jup_sp_whatthehellkindofnameis");
  var_f36e62daadcb9d9c = namespace_d6cca25f4b0ab62::getlevelindex(level.mapname);
  namespace_d6cca25f4b0ab62::levelprogressioncomplete(var_f36e62daadcb9d9c);
  level.player openmenu("CreditsMenu");

  while(true) {
    level.player waittill("luinotifyserver", message, value);

    if(message == "credits_done") {
      break;
    }
  }

  flag_set("flg_chunnel_finale_done");
  nextmission();
  flag_wait("forever");
}

function function_4ed139ac34b2fca3() {}

function function_d44822d42e96e820() {
  nd_chunnel_crossover_soap_start = getnode("nd_chunnel_crossover_soap_start", "targetname");
  level.ai_soap.goalradius = 32;
  level.ai_soap.fixednodesaferadius = 256;
  level.ai_soap setgoalnode(nd_chunnel_crossover_soap_start);
  level.ai_soap.fixednode = 1;
  level.ai_soap.ignoreme = 0;
  level.ai_soap.ignoreall = 0;
  level.ai_soap.dontevershoot = 0;
  level.ai_soap set_force_color("r");
  level thread function_2ff885a031f52eb3();
}

function function_2ff885a031f52eb3() {
  level endon("chunnel_finale_diag_01");
  level.var_83e08bb99a762330 = getspawnerarray("sp_chunnel_sfo_crossover_alpha");
  level.var_83e08bb99a762330 array_spawn_function_targetname("sp_chunnel_sfo_crossover_alpha", &function_e866514a76786402);
  level thread flood_spawn(level.var_83e08bb99a762330);

  foreach(ai in level.var_83e08bb99a762330) {
    ai.fixednodesaferadius = 256;
    ai.goalradius = 32;
    ai.health = 1;
  }

  flag_wait("flg_chunnel_crossover_open_door");

  if(isDefined(level.var_c1e9be5f5e50acc7)) {
    array_delete(level.var_c1e9be5f5e50acc7);
  }

  level.var_bbb70a5fea0b2038 = getspawnerarray("sp_chunnel_sfo_crossover_bravo");
  level.var_bbb70a5fea0b2038 array_spawn_function_targetname("sp_chunnel_sfo_crossover_bravo", &function_e866514a76786402);
  level thread flood_spawn(level.var_bbb70a5fea0b2038);
  flag_wait("flg_crossover_second_combat_area");
  level.ai_soap set_force_color("b");
  thread scripts\sp\spawner::killspawner(1);
  thread scripts\sp\spawner::killspawner(2);
  var_4d9eb2864c88e1bb = getEntArray("sp_chunnel_sfo_crossover_alpha", "targetname");
  var_4b6db8d7596c2ab3 = getEntArray("sp_chunnel_sfo_crossover_bravo", "targetname");
  waitframe();
  array_delete(var_4d9eb2864c88e1bb);
  array_delete(level.var_83e08bb99a762330);
  var_4d9eb2864c88e1bb = undefined;
  level.var_83e08bb99a762330 = undefined;
  array_delete(var_4b6db8d7596c2ab3);
  array_delete(level.var_bbb70a5fea0b2038);
  var_4b6db8d7596c2ab3 = undefined;
  level.var_bbb70a5fea0b2038 = undefined;
  level.var_4f59c8076113c5ae = getspawnerarray("sp_chunnel_sfo_crossover_charlie");
  level.var_4f59c8076113c5ae array_spawn_function_targetname("sp_chunnel_sfo_crossover_charlie", &function_effb87604067aeff);
  level thread flood_spawn(level.var_4f59c8076113c5ae);
  flag_set("flg_chunnel_crossover_sfo_charlie_spawned");
  flag_wait_all("flg_crossover_intro_juggernaut_spawned", "flg_crossover_2nd_juggernaut_spawned");
  wait 4;
  flag_wait_all("flg_crossover_jugg_intro_killed", "flag_crossover_juggernaut_reinforcement_killed", "flg_color_yellow50");
  level.ai_soap set_force_color("y");
}

function function_e866514a76786402() {
  self.team = "allies";
  function_16a594417ddabeb1();
  thread function_a8d01dcc629d8524(undefined, 0);
  self.dontsyncmelee = 1;
  self.dontmelee = 1;
  self.cannotmelee = 1;
}

function function_effb87604067aeff() {
  self endon("death");
  self endon("entitydeleted");
  self.team = "allies";
  self.goalradius = 128;
  function_16a594417ddabeb1();
  thread function_a8d01dcc629d8524(undefined, 0);
  self.dontsyncmelee = 1;
  self.dontmelee = 1;
  self.cannotmelee = 1;
  flag_wait_all("flg_crossover_jugg_intro_killed", "flag_crossover_juggernaut_reinforcement_killed", "flg_color_yellow50");
  set_force_color("y");
}

function function_aaa0caf8340c9d8d(str_node) {
  var_48779f4e802374b6 = getnode(str_node, "targetname");
  self.goalradius = 32;
  self setgoalnode(var_48779f4e802374b6);
  function_c1e075c4168a8bea(0, 0);
}

function function_55ccd613cffb6f89(str_node) {
  namespace_fc0114e844f0b4c::function_60e33f7446b138d3(1);
  thread function_a2d394a1dcdc952c();
  var_fa734da1e7c2967e = getnode(str_node, "targetname");
  self.goalradius = 32;
  thread scripts\sp\spawner::go_to_node(var_fa734da1e7c2967e);
  level.ai_soap set_movement_speed(178);
  level.ai_soap.dontsyncmelee = 1;
  level.ai_soap.dontmelee = 1;
  level.ai_soap.cannotmelee = 1;
  function_61f8d605d3de4b3c();
  function_c1e075c4168a8bea(1, 0);
  self.allowstrafe = 0;
  self enableavoidance(1);
  thread function_b93f21d1614cf800();
  flag_wait("flg_chunnel_intro_track_start");
  self.allowstrafe = 0;
  ai::set_gunpose("ads", 1);
  thread function_d09284e9fc1f4c59(level.var_1181f1897e13785c, "flg_chunnel_intro_track_allies_go_loud", 1);
  flag_wait("flg_chunnel_intro_track_allies_go_loud");
  thread function_b2f2f578fc6cf99a();
  self.allowstrafe = 1;
  ai::reset_gunpose();
  thread function_d09284e9fc1f4c59(level.var_1181f1897e13785c, "flg_chunnel_intro_track_complete");
}

function function_ed832ca607826c89(str_start) {
  self endon("death");
  var_f01dedc18583a89d = getStruct(str_start, "targetname");
  self.goalradius = 32;
  thread scripts\sp\spawner::go_to_node(var_f01dedc18583a89d);
  function_c1e075c4168a8bea(1, 0);
  self.allowstrafe = 0;
  self enableavoidance(1);
}

function function_e8e02cb12ef545bf(var_1fc8a153cf951377) {
  self endon("death");
  self endon("entitydeleted");
  self.goalradius = 32;
  function_c1e075c4168a8bea(0, 0);
  function_16a594417ddabeb1();
  thread function_a8d01dcc629d8524(undefined, 0);
  function_61f8d605d3de4b3c();
  self.dontsyncmelee = 1;
  self.dontmelee = 1;
  self.cannotmelee = 1;

  if(isDefined(var_1fc8a153cf951377)) {
    thread function_f19d721de81462d(var_1fc8a153cf951377);
  }
}

function function_bebee9102c947243(var_1fc8a153cf951377) {
  self endon("death");
  self endon("entitydeleted");
  self.goalradius = 32;
  self.allowstrafe = 0;
  self enableavoidance(1);
  function_16a594417ddabeb1();
  thread function_a8d01dcc629d8524(undefined, 0);
  self.dontsyncmelee = 1;
  self.dontmelee = 1;
  self.cannotmelee = 1;
  function_c1e075c4168a8bea(1, 0);
  function_61f8d605d3de4b3c();

  if(isDefined(var_1fc8a153cf951377)) {
    thread function_f19d721de81462d(var_1fc8a153cf951377);
  }

  thread function_b93f21d1614cf800();
  thread function_6323c0b324a46589();
  flag_wait("flg_chunnel_intro_track_start");
  thread function_ac29a8f995b25125();
  self.allowstrafe = 0;
  ai::set_gunpose("ads", 1);
  thread function_d09284e9fc1f4c59(level.var_1181f1897e13785c, "flg_chunnel_intro_track_allies_go_loud", 1);
  flag_wait("flg_chunnel_intro_track_allies_go_loud");
  thread function_b2f2f578fc6cf99a();
  self.allowstrafe = 1;
  ai::reset_gunpose();
  thread function_d09284e9fc1f4c59(level.var_1181f1897e13785c, "flg_chunnel_intro_track_complete");
}

function function_d09284e9fc1f4c59(a_ai_enemies, var_9eae206e3da3416f, var_1e73c3c1a72c647a) {
  self endon("death");
  level.player endon("death");
  level endon(var_9eae206e3da3416f);

  if(flag(var_9eae206e3da3416f)) {
    return;
  }

  var_58329261987792ed = default_to(var_1e73c3c1a72c647a, 0);
  wait randomfloatrange(0.1, 0.9);

  if(!isDefined(a_ai_enemies)) {
    a_ai_enemies = getaiarray("axis");
  }

  a_ai_enemies = utility::array_removedead(a_ai_enemies);

  if(a_ai_enemies.size == 0) {
    return;
  }

  ai_target = undefined;

  foreach(ai in a_ai_enemies) {
    if(self canshoot(ai getEye())) {
      ai_target = ai;

      if(!istrue(ai.var_6e2b42a7e53840d6)) {
        break;
      }
    }
  }

  if(!isDefined(ai_target)) {
    ai_target = utility::get_closest_ai(self.origin, "axis");
  }

  if(isDefined(ai_target) && isalive(ai_target)) {
    ai_target.var_6e2b42a7e53840d6 = 1;

    if(istrue(var_1e73c3c1a72c647a)) {
      utility::aim_at(ai_target getEye());
      return;
    }

    stop_aiming();
    utility::set_favoriteenemy(ai_target);
    self getenemyinfo(ai_target);
  }
}

function function_fe677b3c2b5ce6bb() {
  foreach(sfo in self) {
    sfo function_16a594417ddabeb1(1, i);
  }
}

function function_9d1618cfaf1da86c() {}

function function_7e22ebf5fe63c225() {
  level endon("flag_defusal_success");
  flag_wait("flag_defusal_fail");
  wait 0.5;
  level.player val::set("for_death_hint", "show_hud", 1);
  level.player playSound("evt_surge_bomb_explode");
  level.player setsoundsubmix("sp_jup_surg_vo_mute_death");

  if(!flag("flg_chunnel_diffuse_done")) {
    scripts\sp\player_death::set_custom_death_quote(521);
  } else {
    scripts\sp\player_death::set_custom_death_quote(527);
  }

  player_ref = spawn_tag_origin(level.player getEye(), level.player.angles);
  playFXOnTag(level._effect["vfx_hij_cam_explode"], player_ref, "tag_origin");
  wait 0.1;
  thread scripts\sp\hud_util::fade_out(0.01, "white");
  wait 2.5;
  thread scripts\sp\hud_util::fade_in(1, "white");
  thread scripts\sp\hud_util::fade_out(0, "black");
  missionfailedwrapper();
  level waittill("forever");
}

function function_14e5fdd07a28343b() {
  level.player endon("death");
  level endon("flag_defusal_success");
  var_e6aa021e63e1710c = getEntArray("tr_chunnel_bomb_damage", "targetname");
  level.var_a75197125609fc63 = 0;
  level.var_faea50695b122e76 = 750;

  foreach(trigger in var_e6aa021e63e1710c) {
    trigger thread function_508c2919daa305a();
  }

  while(level.var_a75197125609fc63 < level.var_faea50695b122e76) {
    wait 0.1;
  }

  level.player val::set("for_death_hint", "show_hud", 1);
  level.player playSound("evt_surge_bomb_explode");
  level.player setsoundsubmix("sp_jup_surg_vo_mute_death");
  scripts\sp\player_death::set_custom_death_quote(526);
  player_ref = spawn_tag_origin(level.player getEye(), level.player.angles);
  playFXOnTag(level._effect["vfx_hij_cam_explode"], player_ref, "tag_origin");
  wait 0.1;
  thread scripts\sp\hud_util::fade_out(0.01, "white");
  wait 2.5;
  thread scripts\sp\hud_util::fade_in(1, "white");
  thread scripts\sp\hud_util::fade_out(0, "black");
  missionfailedwrapper();
  level waittill("forever");
}

function function_508c2919daa305a() {
  level.player endon("death");
  self endon("entitydeleted");
  level endon("flag_defusal_success");

  while(true) {
    self waittill("damage", amount, attacker);

    if(attacker != level.player) {
      if(flag("flg_finale_bomb_cover_usage")) {
        level.var_a75197125609fc63 += amount;
      }

      continue;
    }

    level.var_a75197125609fc63 += amount;
  }
}

function function_7c20bb88a6ac6ddc() {}

function function_d5ba272ebe7023aa(temp_bg, var_a4f3b5f160cf6ccf, var_2a82f328138b52e1, var_cfaf0a4e71209afa) {
  if(!isDefined(var_cfaf0a4e71209afa)) {
    var_cfaf0a4e71209afa = 0;
  }

  level.player allowmovement(0);
  level.player freezelookcontrols(1);
  level.player ent_flag_set("using_snakecam");
  waitframe();
  level.player freezelookcontrols(0);
  scripts\sp\outline::outline_fade_alpha_for_index(6, 0, 0);
  level.player lerpfovscalefactor(0, 0);
  level.player modifybasefov(45, 0.4);
  level delaythread(0.25, &scripts\game\sp\door::static_burst, 0.5);
  thread function_8b0d9eb4ed0909a2();
  level.player notify("enter_cam");
  level.player.og_origin = level.player.origin;
  level.player.og_angles = level.player getplayerangles();
  level.player.og_stance = level.player getstance();
  level.player freezecontrols(1);
  level.player disableweapons();

  if(flag_exist("hold_context_melee")) {
    flag_set("hold_context_melee");
  }

  level.player.ignore_stealth_sight = 1;
  level.player.ignoreme = 1;
  tag = level.player spawn_tag_origin();
  v_tag_origin = tag.origin;
  v_tag_angles = tag.angles;
  s_snakecam_pov = getStruct("s_snakecam_pov", "targetname");
  tag.origin = s_snakecam_pov.origin - (20, 10, 0);
  s_snakecam_pov.angles += (0, -10, 0);
  tag.angles = s_snakecam_pov.angles;
  wait 0.4;
  scripts\game\sp\door::put_player_on_cam(tag);
  temp_bg destroy();
  level.player.var_b0b9f8fc26d0090f = level.player getweaponslistprimaries();
  level.player.var_875db169cd5e8aaf = level.player.currentweapon;
  level.player.var_e72d7bb4acd9a5d1 = level.player.offhandinventory;
  level.player.var_6f9e2ec2ceae61d8 = [];

  foreach(offhand in level.player.var_e72d7bb4acd9a5d1) {
    level.player.var_6f9e2ec2ceae61d8[offhand.basename] = level.player getweaponammostock(offhand);
  }

  level.player function_6078d3c20d55c620();
  gunlessweapon = make_weapon("iw9_gunless");
  level.player give_weapon(gunlessweapon);
  level.player switchtoweaponimmediate(gunlessweapon);
  level.player val::set("snakeCam", "melee", 0);
  level.player val::set("snakeCam", "ads", 0);
  level.player val::set("snakeCam", "weapon", 1);
  level.player hideviewmodel();
  temp = level.player spawn_script_origin();
  tag.tempmovesoundent = level.player spawn_script_origin();
  tag.rumbleent = level.player spawn_script_origin();
  temp scalevolume(0, 0);
  temp playLoopSound("surge_snakecam_plr_lp");
  temp scalevolume(1, 1);
  tag.tempmovesoundent playLoopSound("surge_snakecam_mvmt_lp");
  tag thread namespace_fc0114e844f0b4c::function_e5c79efcb45ced30();
  scripts\game\sp\door::set_snake_cam_vision("party_snake_cam");
  level.cam_hud = function_a755fcbf9dae40b9();

  if(var_cfaf0a4e71209afa) {
    tag.angles = level.var_69c69eba1e176b13;
    level thread function_2caae3097bda94af("fast");
  } else {
    level thread function_2caae3097bda94af("normal");
  }

  function_5c2dac23c40ce83f(var_a4f3b5f160cf6ccf, var_2a82f328138b52e1);
  level thread scripts\game\sp\door::static_burst(0.1);
  blackoverlay = scripts\sp\hud_util::create_client_overlay("black", 0);
  blackoverlay fadeovertime(0.4);
  blackoverlay.alpha = 1;
  wait 0.5;
  nudge_spot = tag.origin + anglesToForward(tag.angles) * -20;

  if(flag("exit_snakecam_immediately")) {
    tag moveTo(nudge_spot, 0.05);
  } else {
    tag moveTo(nudge_spot, 0.5, 0.125);
  }

  level.var_69c69eba1e176b13 = tag.angles;
  level.player notify("leave_cam");

  foreach(thing in level.cam_hud) {
    thing destroy();
  }

  scripts\sp\outline::outline_fade_alpha_for_index(6, 0.8, 0);
  temp stoploopsound("surge_snakecam_plr_lp");
  tag.tempmovesoundent stoploopsound("surge_snakecam_mvmt_lp");
  visionsetfadetoblack("", 0.05);
  setsaveddvar(@ "hash_83bbe73116f488d6", 0);
  setsaveddvar(@ "hash_ed28298c207316ae", 0);
  setsaveddvar(@ "hash_979b5474be3b9b47", 0);
  setsaveddvar(@ "hash_960ef00238357bbc", 0);

  if(!isDefined(level.fov_default)) {
    level.fov_default = 65;
  }

  level.player modifybasefov(level.fov_default, 0.05);
  level.player lerpfovscalefactor(1, 0);
  wait 0.25;
  function_f32f24facf5bf7bb();
  thread function_35078246baaef7bf(blackoverlay);
  thread function_ae64b40cfd35b6b8();

  if(flag_exist("hold_context_melee")) {
    flag_clear("hold_context_melee");
  }

  level.player.ignore_stealth_sight = undefined;
  level.player.ignoreme = 0;
  tag.tempmovesoundent delete();
  tag.rumbleent delete();
  tag delete();
  temp delete();
  level.player ent_flag_clear("using_snakecam");
  level.player playerenabletriggers();

  if(var_a4f3b5f160cf6ccf == "flag_defusal_1_success") {
    function_b20ae3794c9ab5ec();
    scripts\sp\outline::outline_fade_alpha_for_index(6, 0, 6);
    level.player setOrigin(level.player.og_origin + (-20, 0, 20));
    level.player showviewmodel();
    level.player allowmovement(1);
    level flag_set("flg_start_third_fight");
    return;
  }

  level.player setOrigin(level.player.og_origin + (-20, 0, 20));
  flag_set("flg_chunnel_diffuse_done");
}

function function_2caae3097bda94af(blink_speed) {
  strobe_lights = [];
  flag_wait("scriptables_ready");
  strobe_lights = getEntArray("snake_cam_light", "script_noteworthy");

  if(blink_speed == "normal") {
    strobe_lights[0] setscriptablepartstate("light", "off");
  }

  if(blink_speed == "fast") {
    strobe_lights[0] setscriptablepartstate("light", "off_fast");
  }
}

function function_5c2dac23c40ce83f(var_a4f3b5f160cf6ccf, var_2a82f328138b52e1) {
  if(var_2a82f328138b52e1 == 1) {
    display_hint_forced("snake_cam_control_hint");
  }

  flag_wait(var_a4f3b5f160cf6ccf);
}

function function_ae64b40cfd35b6b8() {
  level.player utility::dof_enable_autofocus(1.8, level.office_weapon, 50, 50, undefined, "tag_eye", undefined, 1);
  wait 2.5;
  level.player utility::dof_enable_autofocus(1.8, level.partner, 50, 50, undefined, "tag_eye", undefined, 1);
  flag_wait("flg_chunnel_diffuse_done");
  level.player utility::dof_disable_autofocus();
}

function function_a755fcbf9dae40b9() {
  crosshair = newhudelem();
  crosshair.archived = 0;
  crosshair.location = 0;
  crosshair.alignx = "center";
  crosshair.aligny = "middle";
  crosshair.foreground = 1;
  crosshair.fontscale = 1;
  crosshair.sort = 20;
  crosshair.alpha = 0.5;
  crosshair.x = 320;
  crosshair.y = 240;
  crosshair settext("+");
  overlay = newhudelem();
  overlay.x = 400;
  overlay.y = 180;
  overlay.alignx = "center";
  overlay.aligny = "middle";
  overlay.font = "smallfixed";
  overlay.fontscale = 0.75;
  goggles = scripts\sp\hud_util::create_client_overlay("nightvision_overlay_goggles_grain", 1);
  visionsetfadetoblack(level.interactive_doors.snakecamvision, 0.05);
  setsaveddvar(@ "hash_83bbe73116f488d6", 0.5);
  setsaveddvar(@ "hash_ed28298c207316ae", 0.2);
  setsaveddvar(@ "hash_979b5474be3b9b47", -0.75);
  setsaveddvar(@ "hash_960ef00238357bbc", 0.011);
  return [crosshair, goggles, overlay];
}

function function_f32f24facf5bf7bb() {
  level.player val::set("snakeCam", "weapon", 0);
  level.player function_6078d3c20d55c620();

  foreach(weapon in level.player.var_b0b9f8fc26d0090f) {
    level.player give_weapon(weapon, 0, 0, 0, 1);
  }

  level.player switchtoweaponimmediate(level.player.var_875db169cd5e8aaf);
  level.player.var_b0b9f8fc26d0090f = undefined;
  level.player.var_875db169cd5e8aaf = undefined;

  foreach(weapon in level.player.primaryweapons) {
    fract = level.player getfractionmaxammo(weapon);

    if(fract < 0.75) {
      level.player givestartammo(weapon);
    }
  }

  equiplist = level.player.var_e72d7bb4acd9a5d1;

  foreach(weapon in equiplist) {
    level.player give_offhand(weapon.basename, level.player.var_6f9e2ec2ceae61d8[weapon.basename]);
  }

  level.player.cam_ent delete();
  flag_wait_or_timeout("exit_snakecam_immediately", 0.25);
  level.player val::reset_all("snakeCam");
}

function function_35078246baaef7bf(blackoverlay) {
  fade_time = 3;
  wait 0.3;
  blackoverlay fadeovertime(fade_time);
  blackoverlay.alpha = 0;
  wait fade_time;
  blackoverlay destroy();
}

function function_8b0d9eb4ed0909a2(var_a8e252f743578437) {
  var_a8e252f743578437 = scripts\sp\hud_util::create_client_overlay("black", 0);
  var_a8e252f743578437.sort = 10;
  var_a8e252f743578437 fadeovertime(0.25);
  var_a8e252f743578437.alpha = 1;
  wait 0.6;
  var_a8e252f743578437 fadeovertime(0.15);
  var_a8e252f743578437.alpha = 0;
  wait 0.15;
  var_a8e252f743578437 destroy();
}

function function_90c266fffb3d7941() {}

function function_8389606a3cec622b() {
  while(true) {
    if(flag("flg_player_on_train_track") && !flag("disable_autosaves")) {
      flag_set("disable_autosaves");
    }

    if(!flag("flg_player_on_train_track") && flag("disable_autosaves")) {
      flag_clear("disable_autosaves");
    }

    waitframe();
  }
}

function function_b6bdc8df73d41601(var_1fc8a153cf951377) {
  if(!isDefined(var_1fc8a153cf951377)) {
    var_1fc8a153cf951377 = "flg_chunnel_crossover_detonate";
  }

  self notify("register_train_corpse");
  self endon("register_train_corpse");
  self endon("entitydeleted");
  level endon(var_1fc8a153cf951377);
  level.player endon("death");

  if(self.animname == "engine") {
    while(true) {
      front_tag = self gettagorigin("tag_train_front");
      corpses = getcorpsearrayinradius(front_tag, 128);

      if(corpses.size > 0) {
        foreach(corpse in corpses) {
          e_vfx = spawn_tag_origin(corpse.origin + (0, 0, 25), corpse.angles);
          thread play_sound_in_space("gib_fullbody", e_vfx.origin);

          if(isdismembermentenabled()) {
            playFXOnTag(getfx("vfx_zb_sos_body_exp_f"), e_vfx, "tag_origin");
          }

          playFXOnTag(getfx("vfx_zai_blood_annihilate_exp_surge"), e_vfx, "tag_origin");
          corpse delete();
        }
      }

      waitframe();
    }
  }
}

function function_5d2b18ef5d71a9ff(train_number, var_ec99d0315dd2567b, var_1fc8a153cf951377) {
  if(!isDefined(var_ec99d0315dd2567b)) {
    var_ec99d0315dd2567b = 0;
  }

  if(!isDefined(var_1fc8a153cf951377)) {
    var_1fc8a153cf951377 = "flg_chunnel_crossover_detonate";
  }

  self notify("register_train_impact");
  self endon("register_train_impact");
  self endon("entitydeleted");
  level endon(var_1fc8a153cf951377);
  level.player endon("death");
  a_triggerer = [];

  while(true) {
    self waittill("touch", triggerer);
    flag_clear("flg_chunnel_player_sees_enemy_die_on_tracks");

    if(!array_contains(a_triggerer, triggerer)) {
      a_triggerer = array_add(a_triggerer, triggerer);

      if(isPlayer(triggerer)) {
        scripts\sp\player_death::set_custom_death_quote(511);
        e_vfx = spawn_tag_origin(level.player.origin, level.player.angles);
        thread play_sound_in_space("gib_fullbody", e_vfx.origin);
        playFXOnTag(getfx("vfx_zai_blood_annihilate_exp_surge"), e_vfx, "tag_origin");

        if(isdismembermentenabled()) {
          playFXOnTag(getfx("vfx_zb_sos_body_exp_f"), e_vfx, "tag_origin");
        }

        if(!isDefined(triggerer.magic_bullet_shield)) {
          triggerer kill(self.origin, self, self, "MOD_IMPACT");
        }

        continue;
      }

      if(isai(triggerer) && !var_ec99d0315dd2567b) {
        if(triggerer.team == "axis") {
          triggerer thread function_c46190387a11636d(train_number);
        }

        if(!isDefined(triggerer.magic_bullet_shield)) {
          e_vfx = spawn_tag_origin(triggerer.origin + (0, 0, 25), triggerer.angles);
          triggerer delete();
          thread play_sound_in_space("gib_fullbody", e_vfx.origin);
          playFXOnTag(getfx("vfx_zai_blood_annihilate_exp_surge"), e_vfx, "tag_origin");

          if(isdismembermentenabled()) {
            playFXOnTag(getfx("vfx_zb_sos_body_exp_f"), e_vfx, "tag_origin");
          }

          continue;
        }

        triggerer notify("invulnerable_ai_train_collision", train_number);
      }
    }
  }
}

function function_a2d394a1dcdc952c() {
  self endon("death");
  level.player endon("death");

  while(true) {
    self waittill("invulnerable_ai_train_collision", train_number);
    var_51adc375c197a35c = self function_8418dd400a9223d7();
    var_d80eb3575c56da73 = self getgoalnode();
    var_32a6a64ffcc0f093 = self getgoalpos();
    var_2b2729461bb8d27d = self getgoalvolume();
    var_3b02883dc7b055fb = spawn_tag_origin();
    self linkTo(var_3b02883dc7b055fb);

    if(train_number == 1) {
      var_573c7a1092b362c = level.var_f76b29c280893d5f.var_573c7a1092b362c;
    } else {
      var_573c7a1092b362c = level.var_f76b2ac280893f92.var_573c7a1092b362c;
    }

    while(self getistouchingentities(var_573c7a1092b362c).size > 0) {
      wait 0.1;
    }

    self unlink();
    var_3b02883dc7b055fb delete();

    if(isDefined(var_51adc375c197a35c)) {
      self setgoalentity(var_51adc375c197a35c);
      continue;
    }

    if(isDefined(var_d80eb3575c56da73)) {
      self setgoalnode(var_d80eb3575c56da73);
      continue;
    }

    if(isDefined(var_32a6a64ffcc0f093)) {
      self setgoalpos(var_32a6a64ffcc0f093);
      continue;
    }

    if(isDefined(var_2b2729461bb8d27d)) {
      self setgoalvolumeauto(var_2b2729461bb8d27d);
    }
  }
}

function function_c7e13a4c33547e6() {
  flag_wait("flg_chunnel_intro_garage_02");
  array_spawn_function_targetname("ai_chunnel_vents_SAS_hostage_cover", &function_a8d01dcc629d8524);
  level.var_e1e31c0a04ad6698 = array_spawn_targetname("ai_chunnel_vents_SAS_hostage_cover", 1, 1);
  flag_wait("flg_player_on_train_track");
  level.var_e1e31c0a04ad6698 = array_removedead_or_dying(level.var_e1e31c0a04ad6698);

  if(level.var_e1e31c0a04ad6698.size > 0) {
    array_delete(level.var_e1e31c0a04ad6698);
  }
}

function function_ebc91201d8beb3fb() {
  self endon("entity_deleted");
  self endon("death");

  while(true) {
    level.player waittill("death", attacker_ent);

    if(self == attacker_ent) {
      scripts\sp\player_death::set_custom_death_quote(529);
    }
  }
}