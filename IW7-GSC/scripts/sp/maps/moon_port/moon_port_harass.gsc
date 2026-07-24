/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\moon_port\moon_port_harass.gsc
**********************************************************/

_id_8B19() {
  precacheshader("white");
  precachemodel("veh_mil_air_ca_jackal_drone_atmos_periph");
  precachemodel("vfx_moon_monorail_buckle");
}

_id_8AFF() {
  scripts\engine\utility::flag_init("return_gravity");
  scripts\engine\utility::flag_init("continue_after_hangar_collapse");
  scripts\engine\utility::flag_init("walkway_enemies_front_lost");
  scripts\engine\utility::flag_init("walkway_enemies_gate_lost");
  scripts\engine\utility::flag_init("walkway_enemies_flee_jackal");
  scripts\engine\utility::flag_init("walkway_get_to_cover");
  scripts\engine\utility::flag_init("walkway_door_vo_done");
  scripts\engine\utility::flag_init("walkway_jackal_firing");
  scripts\engine\utility::flag_init("harass_allies_clear");
  scripts\engine\utility::flag_init("harass_player_pushing_forward");
  scripts\engine\utility::flag_init("harass_allies_at_hangar_door");
  scripts\engine\utility::flag_init("harass_no_sprint_hint");
  scripts\engine\utility::flag_set("harass_no_sprint_hint");
  scripts\engine\utility::flag_init("harass_safe_zone");
  scripts\engine\utility::flag_init("salter_in_decomp_pos");
  scripts\engine\utility::flag_init("marineCO_in_decomp_pos");
  scripts\engine\utility::flag_init("break_pillar_1");
  scripts\engine\utility::flag_init("break_pillar_2");
  scripts\engine\utility::flag_init("break_pillar_3");
  scripts\engine\utility::flag_init("target_redshirt_1");
  scripts\engine\utility::flag_init("target_redshirt_2");
  scripts\engine\utility::flag_init("sfx_jackal_moved");
  scripts\engine\utility::flag_init("player_removed_harass_helmet");
  scripts\engine\utility::flag_init("start_second_jack_appear_ww");
  scripts\engine\utility::flag_init("stop_binks_mp");
  precachemodel("vm_hero_protagonist_helmet_glass_crack");
  precachemodel("vm_hero_protagonist_helmet_glass_crack_01");
  precachemodel("vm_hero_protagonist_helmet_glass_crack_02");
  precachemodel("vm_hero_protagonist_helmet_glass_crack_03");
  scripts\sp\utility::_id_16EB("harass_sprint_hint", &"MOON_PORT_HARASS_SPRINT", ::_id_8B1F);
}

_id_8B1F() {
  if(scripts\engine\utility::flag("harass_no_sprint_hint")) {
    return 1;
  }

  if(scripts\engine\utility::flag("harass_allies_at_hangar_door")) {
    return 1;
  }

  return level.player _meth_8439();
}

_id_42E6() {
  scripts\sp\maps\moon_port\moon_port_util::_id_BC53("start_coast_guard");
  var_0 = ["marineCO", "salter", "eth3n"];
  scripts\sp\maps\moon_port\moon_port_util::_id_BC05("start_coast_guard", var_0);
  var_1 = getspawnerarray("coastguard_c8_fight_mdf");

  foreach(var_3 in var_1) {
    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "door_opener") {
      level._id_3BEC = var_3 scripts\sp\utility::_id_10619(1);
    }
  }

  level.player scripts\sp\utility::_id_F526("relaxed");
  _id_0E4B::_id_8E06(1);
}

_id_42E4() {
  setsaveddvar("sm_roundRobinPrioritySpotShadows", 8);
  scripts\engine\utility::flag_set("player_indoor_p1");
  scripts\sp\utility::_id_2669("coast_guard");
  scripts\engine\utility::delaythread(1, scripts\engine\utility::flag_set, "play_news_bink_mp");
  scripts\engine\utility::exploder("walkway_flak");
  thread _id_88BB();
  thread _id_3450();
  scripts\sp\utility::_id_15F5("cg_meetup_actor_trig");
  thread _id_3BF1();
  thread _id_3BED();
  thread _id_2A9C();
  wait 1;

  foreach(var_1 in level.allies) {
    var_1 scripts\sp\utility::_id_51E1("casual_gun");
  }

  scripts\sp\utility::_id_15F5("cg_color_trig_1");
  level waittill("cg_door_open");
  scripts\sp\utility::_id_15F5("cg_color_trig_2");
  level waittill("get_cg_attention");
  wait 1;
  scripts\sp\utility::_id_15F5("walkway_initial_color_trig");

  foreach(var_1 in level.allies) {
    var_1 scripts\sp\utility::_id_4145();
    wait 0.5;
  }

  scripts\engine\utility::flag_wait("send_fighters_to_walkway");
  level.player scripts\sp\utility::_id_F526("normal");
}

_id_88BB() {
  wait 1;
  var_0 = scripts\sp\utility::_id_8201("walkway_ambient_bs_cap", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3 scripts\sp\vehicle::_id_1080B();
    var_1[var_1.size] = var_4;
  }

  scripts\engine\utility::flag_wait("harras_run_complete");

  foreach(var_4 in var_1) {
    var_4 _id_0BA9::_id_397B();
  }
}

_id_3450() {
  wait 4;
  var_0 = getaiarray("allies");
  var_0 = scripts\engine\utility::array_remove_array(var_0, level.allies);
  var_0 = sortbydistance(var_0, level.player.origin);
  var_0[0] scripts\sp\utility::_id_10347("moon_un1_shitthanks");
}

_id_5999() {
  setmusicstate("mx_206_latelevel");

  while(!isDefined(level._id_3BEC)) {
    wait 0.05;
  }

  var_0 = level._id_3BEC;
  wait 3.5;
  var_0 scripts\sp\utility::_id_10346("moon_un2_ourpeoplearejust");
  var_0 scripts\sp\utility::_id_7799(level.player);
  wait 4;
  var_0 scripts\sp\utility::_id_10346("moon_grd_werecutofffrom");
  level.player scripts\sp\utility::_id_10350("moon_plr_wereallclearbehind");
  var_0 thread scripts\sp\utility::_id_77B9(1);
}

_id_3BED() {
  var_0 = scripts\engine\utility::getStruct("cg_door_open_animnode", "targetname");
  var_1 = level._id_3BEC;
  var_1._id_1FBB = "cg_door_opener";
  var_1.fixednode = 1;
  var_1 thread _id_3BEE(var_0);
  var_0 scripts\sp\anim::_id_1F17(var_1, "moon_coastguard_door");
  thread _id_5999();
  thread _id_C5DE();
  var_0 scripts\sp\anim::_id_1F35(var_1, "moon_coastguard_door");
  var_1 _meth_82EE(getnode("cg_door_final_node", "targetname"));
  scripts\engine\utility::flag_wait("start_decompression");
  var_1 scripts\sp\utility::_id_1101B();
  var_1 delete();
}

_id_3BEE(var_0) {
  while(distance(self.origin, var_0.origin) > 150) {
    wait 0.1;
  }

  scripts\sp\utility::_id_51E1("casual_gun");
}

_id_C5DE() {
  level waittill("cg_door_open");
  level.player scripts\sp\utility::_id_F526("relaxed");
  var_0 = getEnt("cg_right_door", "targetname");
  var_1 = getEnt("cg_left_door", "targetname");
  var_2 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_3 = scripts\engine\utility::getStruct(var_1.target, "targetname");
  var_4 = getEnt(var_2.target, "targetname");
  var_5 = getEnt(var_3.target, "targetname");
  var_4 linkTo(var_0);
  var_5 linkTo(var_1);
  var_6 = var_0.origin;
  var_7 = var_1.origin;
  thread scripts\engine\utility::play_sound_in_space("scn_moon_port_cg_door_open", var_1.origin);
  var_0 moveTo(var_2.origin, 1, 0.25, 0.5);
  var_1 moveTo(var_3.origin, 1, 0.25, 0.5);
  var_4 connectpaths();
  var_5 connectpaths();
  thread _id_13D5A();
  scripts\engine\utility::flag_wait("send_fighters_to_walkway");
  _id_135A9(var_0);
  wait 1;
  var_0 moveTo(var_6, 1, 0.25, 0.5);
  var_1 moveTo(var_7, 1, 0.25, 0.5);
  wait 0.5;
  var_4 disconnectPaths();
  var_5 disconnectPaths();
  scripts\engine\utility::flag_wait("start_decompression");
  var_0 delete();
  var_1 delete();
  var_4 delete();
  var_5 delete();
}

_id_13D5A() {
  var_0 = scripts\sp\utility::_id_8200("final_cg_flier_mb", "targetname");
  var_1 = var_0 scripts\sp\vehicle::_id_1080B();
  var_1 thread _id_E0A5("player_on_stairs_controller");
}

_id_E0A5(var_0) {
  scripts\engine\utility::flag_wait(var_0);
  self delete();
}

_id_135A9(var_0) {
  for(;;) {
    var_1 = 1;

    foreach(var_3 in level.allies) {
      if(distance2d(var_3.origin, level.player.origin) > distance2d(var_0.origin, level.player.origin)) {
        var_1 = 0;
        break;
      }
    }

    if(var_1) {
      break;
    }

    wait 0.5;
  }
}

_id_10767(var_0) {
  var_1 = getspawnerarray(var_0);
  var_2 = scripts\sp\utility::_id_22C6(var_1, 1);

  foreach(var_4 in var_2) {
    var_4 scripts\sp\utility::_id_61C7();
    var_4 scripts\sp\utility::_id_F3B5("y");
    var_4 setgoalpos(var_4.origin);
    var_4.fixednode = 1;
  }

  return var_2;
}

_id_3BF1() {
  var_0 = scripts\engine\utility::getStruct("cg_stairs_animNode", "targetname");
  var_1 = getspawnerarray("cg_stairs_actor");
  var_2 = scripts\sp\utility::_id_22C6(var_1);
  var_0 thread _id_10B4E(var_2);
  var_0 thread _id_6D71(var_2);
  var_0 thread _id_10B4A(var_2);
  return var_2;
}

_id_10B4E(var_0) {
  var_1 = undefined;

  foreach(var_3 in var_0) {
    if(var_3.script_noteworthy == "cg_stairs_waver") {
      var_3._id_1FBB = "cg_stairs_waver";
      var_1 = var_3;
      var_1 thread _id_13BE1();
      var_1 scripts\sp\utility::_id_61C7();
      var_1 scripts\sp\utility::_id_F3B5("y");
      break;
    }
  }

  scripts\sp\anim::_id_1EC3(var_1, "moon_coastguard_stairs");
  scripts\engine\utility::flag_wait("send_fighters_to_walkway");
  thread _id_3BEF();
  scripts\sp\anim::_id_1F35(var_1, "moon_coastguard_stairs");
}

_id_13BE1() {
  level waittill("get_cg_attention");
  scripts\sp\utility::_id_10347("moon_un4_overherewehave");
  level notify("guards_respond");
  level.allies["marineCO"] scripts\sp\utility::_id_10347("moon_omr_moveit");
  level.player scripts\sp\utility::_id_10350("moon_plr_letsmove");
}

_id_6D71(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3.script_noteworthy == "cg_fireman_0" || var_3.script_noteworthy == "cg_fireman_1") {
      var_3 scripts\sp\utility::_id_86E4();
      var_3._id_1FBB = var_3.script_noteworthy;
      var_1[var_1.size] = var_3;
    }
  }

  scripts\sp\anim::_id_1EC1(var_1, "moon_fireman_guard");
  level waittill("cg_door_open");
  scripts\sp\anim::_id_1F2C(var_1, "moon_fireman_guard");
  thread scripts\sp\anim::_id_1EE7(var_1, "moon_fireman_idle", "stop_cg_idles");
  scripts\engine\utility::flag_wait("start_decompression");

  foreach(var_6 in var_1) {
    var_6 delete();
  }
}

_id_10B4A(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(var_3.script_noteworthy == "cg_stairs_guy_0" || var_3.script_noteworthy == "cg_stairs_guy_1") {
      var_3._id_1FBB = var_3.script_noteworthy;
      var_1[var_1.size] = var_3;
    }
  }

  var_0[0] thread _id_86B8();
  thread _id_10B4B();
  thread _id_3BF0(var_1[0], 0);
  thread _id_3BF0(var_1[1], 1);
}

_id_10B4B() {
  level waittill("get_cg_attention");
  self notify("send_fighters_to_walkway");
}

_id_3BEF() {
  wait 1.5;
  scripts\engine\utility::exploder("side_explo");
}

_id_86B8() {
  level waittill("guards_respond");
  thread scripts\sp\utility::_id_10347("moon_un2_letsgo");
  wait 3;
  thread scripts\sp\utility::_id_10347("moon_un4_sdftwelveoclock");
  wait 1;
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moonport_omr_getgunsonemwere");
  wait 4.5;
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_omr_keepafterthem");
  wait 4.5;
  level.allies["eth3n"] scripts\sp\utility::_id_10346("moonport_eth_objectivenag8");
}

_id_3BF0(var_0, var_1) {
  scripts\sp\anim::_id_1EEA(var_0, "moon_coastguard_idle", "send_fighters_to_walkway");
  scripts\sp\anim::_id_1F35(var_0, "moon_coastguard_getup");
  var_0 scripts\sp\utility::_id_51E1("combat");

  if(isDefined(var_1) && var_1) {
    var_0 thread _id_F2F8("cg_green_node", "y", undefined, "green_node_go");
  } else {
    var_0 thread _id_F2F8("cg_blue_node", "y", undefined, "red_node_go");
  }
}

_id_2A9C() {
  level.allies["eth3n"] scripts\sp\utility::_id_61C7();
  level.allies["eth3n"] scripts\sp\utility::_id_F3B5("g");
  level.allies["salter"] scripts\sp\utility::_id_61C7();
  level.allies["salter"] scripts\sp\utility::_id_F3B5("o");
  level.allies["marineCO"] scripts\sp\utility::_id_61C7();
  level.allies["marineCO"] scripts\sp\utility::_id_F3B5("r");
  level waittill("get_cg_attention");

  foreach(var_1 in level.allies) {
    var_1 scripts\sp\utility::_id_54F7();
  }

  level.allies["marineCO"] thread _id_F2F8("cg_red_node");
  level.allies["salter"] thread _id_F2F8("cg_orange_node");
  level.allies["eth3n"] thread _id_F2F8("cg_green_node");
}

_id_F2F8(var_0, var_1, var_2, var_3) {
  var_4 = getnode(var_0, "targetname");
  self.ignoreall = 1;
  var_5 = self.goalradius;
  var_6 = 300;
  self.goalradius = var_6;
  self.fixednode = 1;

  if(isDefined(var_2)) {
    self setgoalpos(self.origin);
    level waittill(var_2);
  }

  scripts\sp\utility::_id_54F7();

  if(distance2d(var_4.origin, self.origin) < var_6) {
    var_4 = getnode(var_4.target, "targetname");
  }

  for(;;) {
    self _meth_82EE(var_4);
    self waittill("goal");

    if(isDefined(var_4.target)) {
      var_4 = getnode(var_4.target, "targetname");
    } else {
      break;
    }

    wait 0.05;

    if(isDefined(var_3)) {
      level notify(var_3);
    }
  }

  scripts\sp\utility::_id_61C7();

  if(!isDefined(var_1)) {
    scripts\sp\utility::_id_F3B5("g");
  } else {
    scripts\sp\utility::_id_F3B5(var_1);
  }

  self.ignoreall = 0;
  self.fixednode = 0;
  self.goalradius = var_5;
}

_id_42E3() {
  scripts\engine\utility::flag_wait("cg_jackal_appear_1");
  var_0 = scripts\sp\utility::_id_8200("ambush_jackal_spawner", "targetname");
  var_1 = _id_792F();
  var_2 = var_0 scripts\sp\utility::_id_10808();
  var_2._id_1FBB = "skelter";
  var_2.ignoreme = 1;
  var_1 thread _id_13D60(var_2);
  var_1 scripts\sp\anim::_id_1F35(var_2, "flyby_1_enter");
  var_1 thread scripts\sp\anim::_id_1EEA(var_2, "flyby_1_idle", "stop_jackal_idle");
  var_1 _id_A1E1(var_2);
  var_1 scripts\sp\anim::_id_1F35(var_2, "flyby_1_exit");
  var_2 delete();
}

_id_42E1() {
  _id_42E2();
}

_id_42E2() {}

_id_1389A() {
  scripts\sp\maps\moon_port\moon_port_util::_id_BC53("start_walkway");
  var_0 = ["marineCO", "salter", "eth3n"];
  scripts\sp\maps\moon_port\moon_port_util::_id_BC05("start_walkway", var_0);
  level.player scripts\sp\utility::_id_F526("normal");
  _id_0E4B::_id_8E06(1);
  scripts\sp\utility::_id_CF8D();
  scripts\sp\utility::_id_28D8();
  _id_10767("mdf_walkway_fighters_jump");

  foreach(var_2 in level.allies) {
    var_2 scripts\sp\utility::_id_61C7();
    var_2 scripts\sp\utility::_id_F3B5("g");
  }

  scripts\engine\utility::exploder("walkway_flak");
  scripts\engine\utility::delaythread(2, scripts\engine\utility::flag_set, "play_news_bink_mp");

  foreach(var_2 in level.allies) {
    var_2 thread scripts\sp\utility::_id_DC45("raise");
  }
}

_id_13896() {
  scripts\sp\utility::_id_28D8("allies");
  scripts\sp\utility::_id_28D8("axis");
  scripts\sp\utility::_id_CF8D();
  scripts\engine\utility::flag_set("player_indoor_p1");
  thread set_spotlights_back_down();
  thread _id_13D5B();
  thread scripts\sp\utility::_id_266F();
  thread _id_13894();
  thread _id_4E7D();
  thread _id_F931();
  scripts\sp\utility::_id_15F5("walkway_initial_color_trig");
  thread _id_13E08();
  thread slow_load_blocker_hangar_halls();
  scripts\sp\utility::_id_12641("moon_port_hangar_halls_tr");
  scripts\engine\utility::flag_wait("finish_walkway_section");
  scripts\sp\utility::_id_28D7("allies");
  scripts\sp\utility::_id_CF8B();
  thread _id_CB88();
}

slow_load_blocker_hangar_halls() {
  if(!level.console) {
    scripts\engine\utility::flag_wait("ww_fb_4");
    waitforalltransients();
  }
}

_id_13E0B() {
  var_0 = getEnt("stop_count_ww_0", "targetname");

  if(!isDefined(var_0)) {
    return;
  } else {
    var_0 waittill("trigger");
    var_1 = scripts\sp\utility::_id_7C84("stop_count_ww_0", "script_noteworthy");

    foreach(var_3 in var_1) {
      var_3.count = 1;
    }

    var_0 = getEnt("stop_count_ww_1", "targetname");
    var_0 waittill("trigger");
    var_1 = scripts\sp\utility::_id_7C84("stop_count_ww_1", "script_noteworthy");

    foreach(var_3 in var_1) {
      var_3.count = 1;
    }
  }
}

_id_13D5B() {
  scripts\engine\utility::flag_wait("start_second_jack_appear_ww");
  var_0 = scripts\sp\utility::_id_8201("final_ww_flier", "targetname");

  foreach(var_2 in var_0) {
    var_3 = var_2 scripts\sp\vehicle::_id_1080B();
    var_3 vehicle_setspeed(randomintrange(30, 90), randomintrange(10, 40), 5);
    var_3 thread _id_E0A5("hangar_player_used_airlock");
  }
}

_id_10B50() {
  var_0 = scripts\engine\utility::getStruct("tracer_sounds_1", "targetname");
  var_1 = scripts\engine\utility::getStruct("tracer_sounds_2", "targetname");
  thread scripts\engine\utility::play_sound_in_space("scn_moon_jackal_outside_expl_01", level.player.origin);
  earthquake(0.25, 2, level.player.origin, 999999);
  level.player playRumbleOnEntity("grenade_rumble");
  wait(randomfloatrange(2.0, 4.0));
  thread scripts\engine\utility::play_sound_in_space("scn_moon_jackal_outside_expl_02", level.player.origin);
  earthquake(0.25, 2, level.player.origin, 999999);
  level.player playRumbleOnEntity("grenade_rumble");
  wait(randomfloatrange(2.0, 4.0));
  thread scripts\engine\utility::play_sound_in_space("scn_moon_jackal_outside_expl_03", level.player.origin);
  earthquake(0.25, 2, level.player.origin, 999999);
  level.player playRumbleOnEntity("grenade_rumble");
  wait(randomfloatrange(2.0, 4.0));
  thread scripts\engine\utility::play_sound_in_space("scn_moon_jackal_outside_expl_04", level.player.origin);
  earthquake(0.25, 2, level.player.origin, 999999);
  level.player playRumbleOnEntity("grenade_rumble");
}

_id_C7DB() {
  scripts\engine\utility::flag_wait("ww_fb_2");
  var_0 = scripts\engine\utility::getStruct("walkway_explosion_1", "targetname");
  var_1 = scripts\engine\utility::getStruct("walkway_explosion_2", "targetname");
  wait(randomfloatrange(2.0, 4.0));
  playFX(level._effect["jet_missile_imp_generic_zg"], var_0.origin);
  thread scripts\engine\utility::play_sound_in_space("scn_moon_jackal_outside_expl_05", var_0.origin);
  earthquake(0.25, 2, level.player.origin, 999999);
  level.player playRumbleOnEntity("grenade_rumble");
  wait(randomfloatrange(2.0, 4.0));
  playFX(level._effect["jet_missile_imp_generic_zg"], var_1.origin);
  thread scripts\engine\utility::play_sound_in_space("scn_moon_jackal_outside_expl_06", var_1.origin);
  earthquake(0.25, 2, level.player.origin, 999999);
  level.player playRumbleOnEntity("grenade_rumble");
}

_id_C7DC() {
  scripts\engine\utility::flag_wait("ww_fb_4");
  var_0 = scripts\engine\utility::getStruct("walkway_explosion_3", "targetname");
  var_1 = scripts\engine\utility::getStruct("walkway_explosion_4", "targetname");
  wait(randomfloatrange(2.0, 4.0));
  playFX(level._effect["jet_missile_imp_generic_zg"], var_0.origin);
  thread scripts\engine\utility::play_sound_in_space("scn_moon_jackal_outside_expl_07", var_0.origin);
  earthquake(0.25, 2, level.player.origin, 999999);
  level.player playRumbleOnEntity("grenade_rumble");
  wait(randomfloatrange(2.0, 4.0));
  playFX(level._effect["jet_missile_imp_generic_zg"], var_1.origin);
  thread scripts\engine\utility::play_sound_in_space("scn_moon_jackal_outside_expl_08", var_1.origin);
  earthquake(0.25, 2, level.player.origin, 999999);
  level.player playRumbleOnEntity("grenade_rumble");
}

set_spotlights_back_down() {
  scripts\engine\utility::flag_wait("ww_fb_1");
  setsaveddvar("sm_roundRobinPrioritySpotShadows", 4);
}

_id_13E08() {
  scripts\sp\utility::_id_22C6(getspawnerarray("first_area_spawner_main"));
  var_0 = getspawner("ww_front_spawn_guy", "targetname") scripts\sp\utility::_id_10619(1);
  var_0.fixednode = 1;
  scripts\engine\utility::flag_wait("ww_fb_1");
  thread _id_10B50();
  thread _id_C7DB();
  thread _id_C7DC();
  scripts\sp\utility::_id_22C6(getspawnerarray("second_area_spawner_main"));
  var_1 = getspawnerarray("ww_back_spawner");

  foreach(var_3 in var_1) {
    var_4 = var_3 scripts\sp\utility::_id_10619(1);
    var_4.fixednode = 1;
    var_4 thread _id_13E0A();
  }

  scripts\engine\utility::flag_wait("ww_fb_2");
  var_1 = getspawnerarray("first_area_spawner_ar");
  var_1 = scripts\sp\utility::_id_22A2(var_1, getspawnerarray("first_area_spawner_smg"));

  foreach(var_3 in var_1) {
    var_3 thread _id_F3EA();
  }

  scripts\engine\utility::flag_wait("ww_fb_3");
  var_1 = getspawnerarray("second_area_spawner_ar");
  var_1 = scripts\sp\utility::_id_22A2(var_1, getspawnerarray("second_area_spawner_smg"));

  foreach(var_3 in var_1) {
    var_3 thread _id_F3EB();
  }
}

_id_F3EA() {
  var_0 = scripts\engine\utility::get_target_ent();
  var_1 = var_0 scripts\engine\utility::get_target_ent();
  self.target = var_1;
  scripts\engine\utility::flag_wait("ww_fb_4");
  var_1 = var_0 scripts\engine\utility::get_target_ent();
  self.target = var_1;
}

_id_F3EB() {
  var_0 = scripts\engine\utility::get_target_ent();
  var_1 = var_0 scripts\engine\utility::get_target_ent();
  self.target = var_1;
}

_id_13E0A() {
  self endon("death");
  level endon("set_final_ww_fb_flag");

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(var_1 == level.player) {
      break;
    }
  }

  scripts\sp\utility::_id_15F5("set_final_ww_fb_flag");
}

_id_13894() {
  scripts\engine\utility::flag_wait("start_second_jack_appear_ww");
  var_0 = scripts\sp\utility::_id_8200("ambush_jackal_spawner", "targetname");
  var_1 = _id_792F();
  var_2 = var_0 scripts\sp\utility::_id_10808();
  var_2._id_1FBB = "skelter";
  var_1 thread _id_13D60(var_2);
  var_2.ignoreme = 1;
  var_1 scripts\sp\anim::_id_1F35(var_2, "flyby_2_enter");
  var_1 thread scripts\sp\anim::_id_1EEA(var_2, "flyby_2_idle", "stop_jackal_idle");
  var_1 _id_A1E1(var_2);
  var_1 scripts\sp\anim::_id_1F35(var_2, "flyby_2_exit");
  var_2 delete();
}

_id_A1E1(var_0) {
  var_1 = scripts\sp\utility::_id_7951(level.player.origin, level.player.angles, var_0.origin);
  var_2 = 0;

  for(;;) {
    if(var_1 > 0.2) {
      break;
    } else if(var_2 >= 5) {
      break;
    }

    var_2++;
    var_1 = scripts\sp\utility::_id_7951(level.player.origin, level.player.angles, var_0.origin);
    wait 1;
  }

  self notify("stop_jackal_idle");
}

_id_13D60(var_0) {
  var_1 = "tag_flash";
  var_2 = anglesToForward(var_0 gettagangles(var_1)) * 5000;
  var_3 = var_0 gettagorigin(var_1) + var_2;
  var_0._id_11536 = scripts\engine\utility::spawn_tag_origin(var_3);
  var_0._id_11536 linkTo(var_0);
  var_0._id_11536.team = "allies";
  var_0 _id_0BDC::_id_19B5(var_0._id_11536);
  thread _id_A274(var_0);
  var_0 _id_0BDC::_id_19AE("shoot_now");
  self waittill("stop_jackal_idle");
  var_0 _id_0BDC::_id_19AE("dont_shoot");
  var_0._id_11536 delete();
}

_id_A274(var_0) {
  self endon("stop_jackal_idle");

  for(;;) {
    var_0 _id_0B76::_id_1992("TAG_FLASH", var_0._id_11536, 1);
    wait(randomfloatrange(1, 4));
  }
}

_id_1388D() {
  thread _id_1388E();
}

_id_1388E() {}

_id_4F81() {
  scripts\engine\utility::flag_init("player_grabbed_salter");
  scripts\engine\utility::flag_init("decompression_finished");
  scripts\engine\utility::flag_init("start_forklift");
  scripts\engine\utility::flag_init("start_decompression");
  scripts\engine\utility::flag_init("do_monorail_mayhem");
  precachemodel("veh_ind_lnd_traditional_forklift_sml");
  precachemodel("building_support_frame_vertical");
  precachemodel("sz_crate_federation_long");
  precacheitem("magic_spaceship_20mm_bullet");
  precacheitem("iw7_gunless");
}

_id_4F8A() {
  scripts\sp\maps\moon_port\moon_port_util::_id_BC53("start_decomp");
  var_0 = ["marineCO", "salter", "eth3n"];
  scripts\sp\maps\moon_port\moon_port_util::_id_BC05("start_harass", var_0);
  _id_0E4B::_id_8E06(1);
  thread _id_CB88();
  thread _id_4E7D();
  scripts\engine\utility::exploder("walkway_flak");

  foreach(var_2 in level.allies) {
    var_2 thread scripts\sp\utility::_id_DC45("raise");
  }
}

_id_4F86() {
  scripts\engine\utility::flag_set("player_indoor_p2_noblur");
  level._id_4F74 = _id_792F();
  thread _id_4F8C();
  _id_4FB3();
  scripts\engine\utility::flag_wait("decompression_finished");
  var_0 = _id_F997();
  scripts\sp\maps\moon_port\moon_port_util::_id_D1E7(undefined, "moon_low_g_exterior", var_0);
}

_id_4F87() {
  playmayhem("mayhem_moon_walkway");
}

_id_792F() {
  var_0 = scripts\engine\utility::getStructArray("decomp_animNode", "targetname");
  var_1 = scripts\engine\utility::getStruct("decompression_anim_node", "targetname");
  var_0 = sortbydistance(var_0, var_1.origin);
  return var_0[0];
}

_id_4FB3() {
  level._id_5A5E = 0;
  thread scripts\sp\utility::_id_2670();
  var_0 = level._id_4F74;

  if(!isDefined(level._id_4F79)) {
    _id_F931();
  }

  thread _id_40DF();
  thread _id_4F89();
  thread _id_A141();
  scripts\engine\utility::flag_wait("start_decompression");
  scripts\engine\utility::flag_set("stop_binks_mp");
  scripts\sp\utility::_id_1264E("moon_port_concourse_tr");
  thread _id_4FB0();
  scripts\sp\utility::_id_15F5("cg_meetup_actor_trig_stop");
  thread _id_F9D1();
  var_0 thread _id_D013();
  var_0 thread _id_8E28();
  var_0 thread _id_7300();
  var_0 thread _id_D0DA();
  var_0 thread _id_468D();
  var_0 thread _id_4F76();
}

_id_4FB0() {
  level waittill("crack_2");
  level.player _meth_82C0("moon_sucked_out", 0.5);
  wait 10.5;
  thread scripts\sp\utility::_id_10350("moon_cmp_oxygendepleted");
}

_id_4FAF() {
  wait 7.2;
  thread _id_0B0B::_id_25BF();
  wait 0.3;
  level.player notify("helmet_off");
}

_id_D013() {
  var_0 = scripts\sp\utility::_id_10639("player_rig");
  var_0.origin = level.player.origin;
  var_0.angles = level.player getplayerangles();
  level.player _meth_84AF(1);
  level.player freezecontrols(1);
  level.player disableweapons();
  level.player scripts\engine\utility::allow_crouch(0);
  level.player scripts\engine\utility::allow_prone(0);
  level.player _meth_80CB(1);
  var_1 = 10;
  level.player playerlinktodelta(var_0, "tag_player", 1, var_1, var_1, var_1, 0, 1);
  var_2 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  var_0 linkTo(var_2);
  var_2 thread scripts\sp\anim::_id_1F35(var_0, "decomp_knockback_relative");
  scripts\engine\utility::flag_set("pause_helmet_hiding");

  if(scripts\sp\utility::_id_93A6()) {
    var_0 thread _id_8E77();
  }

  var_3 = scripts\sp\utility::_id_10639("player_rig");
  var_4 = getanimlength(var_0 scripts\sp\utility::_id_7DC1("decomp_knockback_relative"));
  thread _id_0B0A::_id_583F(0, 20.27, 3, 0, 926.994, 1.75, var_4);
  var_3 hide();
  scripts\sp\anim::_id_1EC3(var_3, "decomp_scene_a");
  var_2 moveTo(var_3.origin, var_4, 0, var_4 * 0.25);
  var_2 rotateTo(var_3.angles, var_4, 0, var_4 * 0.25);
  wait(var_4);
  var_3 delete();
  level notify("start_decomp_scene_anims");
  scripts\sp\anim::_id_1F35(var_0, "decomp_scene_a");

  if(!scripts\engine\utility::flag("player_grabbed_salter")) {
    level notify("player_grab_times_up");
    level.allies["salter"] notify("trigger");
    setslowmotion(0.1, 1, 0.5);
    scripts\sp\anim::_id_1F35(var_0, "decomp_death");
    var_5 = scripts\sp\hud_util::_id_48B7("black", 1, level.player);
    level.player _meth_81D0();
    level waittill("forever");
  }

  level.player playSound("scn_moon_suck_slt_grab");
  scripts\sp\anim::_id_1F35(var_0, "decomp_scene_b");
  var_0 delete();
  level.player _meth_84AF(0);
  level.player freezecontrols(0);
  level.player enableweapons();
  level.player scripts\engine\utility::allow_crouch(1);
  level.player scripts\engine\utility::allow_prone(1);
  level.player _meth_80CB(0);
  scripts\engine\utility::flag_set("decompression_finished");
}

_id_8E77() {
  scripts\sp\specialist_MAYBE::_id_F52F(1);
  wait 0.7;
  thread _id_A27C();
  wait 0.5;
  self hide();
  wait 1.5;
  var_0 = level.player getEye();
  playFX(level._effect["vfx_moon_infil_jeep_explosion_air"], var_0);
  playworldsound("jackal_missile_explosion_plr", var_0);
  scripts\engine\utility::flag_set("player_indoor_p1_noblur");
  setblur(2, 0.3);
  earthquake(1.5, 1, var_0, 500);
  wait 0.3;
  setblur(0, 0.5);
  self show();
}

_id_4F89() {
  var_0 = scripts\engine\utility::getStruct("decompression_anim_node", "targetname");
  setmusicstate("");
  level waittill("crack_1");
  thread _id_0B0A::_id_583D(0.5);
  level waittill("crack_2");

  if(scripts\sp\utility::_id_93A6() && !scripts\sp\specialist_MAYBE::_id_2C95()) {
    level._id_10964 thread scripts\sp\specialist_MAYBE::_id_4E1A(1);
    return;
  }

  thread _id_47A0();
}

_id_8AF3() {
  level.player endon("death");
  scripts\sp\utility::_id_127B3("harass_breathing_efforts");
}

_id_47A0() {
  level.player endon("death");
  thread _id_479F();
  thread _id_47A1();
  var_0 = scripts\engine\utility::spawn_tag_origin(level.player.origin);
  var_0 linkTo(level.player);
  var_0 thread _id_FB32();
  var_1 = 1.1;
  var_2 = 0;

  while(!scripts\engine\utility::flag("hangar_airlock_autocomplete")) {
    level.player playSound("plr_cracked_helmet_inhale_fast");
    wait(var_1);
    level.player playSound("plr_cracked_helmet_exhale_fast");
    wait(var_1);
    var_2++;

    if(var_2 > 8) {
      level.player notify("o2_lvl_2");
      var_1 = randomfloatrange(0.8, 1.2);
    }

    if(var_2 > 13) {
      var_1 = randomfloatrange(0.7, 1.0);
      level.player notify("o2_drone");
    }

    if(var_2 > 17) {
      level.player notify("o2_lvl_3");
    }

    if(var_2 > 22) {
      var_1 = randomfloatrange(0.5, 0.9);
      level.player notify("o2_lvl_4");
    }

    if(var_2 > 30) {
      var_1 = randomfloatrange(0.3, 0.7);
    }
  }

  level.player playSound("plr_cracked_helmet_inhale_fast");
  wait 1;
  level.player playSound("plr_cracked_helmet_exhale_fast");
  wait 0.5;
  var_0 scripts\sp\utility::_id_10460(2.0);
}

_id_FB32() {
  level.player endon("reached_airlock");
  self playLoopSound("plr_helmet_air_leak_lp");
  level.player waittill("death");
  scripts\sp\utility::_id_10460(1.0);
}

_id_47A1() {
  level.player endon("death");
  wait 12;
  var_0 = 0.9;
  var_1 = 0;
  var_2 = "damage_light";

  while(!scripts\engine\utility::flag("hangar_airlock_autocomplete")) {
    level.player playRumbleOnEntity(var_2);
    level.player playSound("scn_moon_suck_heartbeat");
    wait(var_0);
    var_1++;

    if(var_1 > 10) {
      var_0 = 1.0;
    }

    if(var_1 > 20) {
      var_2 = "damage_heavy";
      var_0 = 0.8;
    }

    if(var_1 > 30) {
      var_2 = "damage_heavy";
      var_0 = 0.6;
    }
  }
}

_id_479F() {
  var_0 = spawn("script_origin", level.player.origin);
  var_0 linkTo(level.player);
  var_0 thread _id_FB47();
  level.player scripts\engine\utility::waittill_any("helmet_off", "death");
  var_0 scripts\sp\utility::_id_10460(0.2);
}

_id_FB47() {
  level.player endon("reached_airlock");
  level.player endon("death");
  self playLoopSound("plr_helmet_o2_level_ok_lp");
  level.player waittill("o2_lvl_2");
  wait 0.1;
  self stoploopsound();
  self playLoopSound("plr_helmet_o2_level_low_lp");
  thread scripts\sp\utility::_id_10350("moon_cmp_oxygendepleted");
  level.player waittill("o2_drone");
  self playSound("scn_moon_suck_drone_lr");
  thread scripts\sp\utility::_id_10350("moon_cmp_oxygenlevelcrit");
  level.player waittill("o2_lvl_3");
  self stoploopsound();
  self playLoopSound("plr_helmet_o2_level_critical_lp");
  thread scripts\sp\utility::_id_10350("moon_cmp_oxygenlevelcrit");
  level.player waittill("o2_lvl_4");
  thread scripts\sp\utility::_id_10350("moon_cmp_oxygenlevelcrit");
}

_id_8E28() {
  var_0 = level.allies["salter"];
  var_1 = level.allies["eth3n"];
  var_2 = level.allies["marineCO"];
  var_3 = [var_0];

  foreach(var_5 in var_3) {
    var_5 thread scripts\sp\utility::_id_DC45("lower");
  }

  scripts\sp\anim::_id_1F2C(var_3, "decomp_knockback");
  scripts\engine\utility::flag_set("start_forklift");
  var_3 = [var_0, var_1, var_2];
  scripts\sp\anim::_id_1F2C(var_3, "decomp_scene");
}

_id_7300() {
  scripts\engine\utility::flag_wait("start_forklift");
  var_0 = scripts\sp\utility::_id_10639("decomp_forklift");
  scripts\sp\anim::_id_1F35(var_0, "decomp_scene");
  var_0 delete();
}

_id_4F76() {
  var_0 = scripts\sp\utility::_id_8200("decomp_cap_ship_spawner", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = var_0 scripts\sp\utility::_id_10808();
  var_1._id_1FBB = "decomp_capship";
  scripts\sp\anim::_id_1F35(var_1, "decomp_scene");
  var_1 delete();
}

_id_4E7D(var_0) {
  var_1 = _id_792F();
  var_2 = [];
  var_3 = undefined;

  for(var_4 = 0; var_4 < 10; var_4++) {
    if(var_4 == 7) {
      continue;
    }
    var_2[var_4] = ::scripts\sp\utility::_id_10639("decomp_prop_" + var_4);
  }

  var_2[var_2.size] = ::scripts\sp\utility::_id_10639("decomp_cart");
  var_1 scripts\sp\anim::_id_1EC1(var_2, "decomp_knockback");
  scripts\engine\utility::flag_wait("start_decompression");
  var_1 scripts\sp\anim::_id_1F2C(var_2, "decomp_knockback");
  var_1 scripts\sp\anim::_id_1F2C(var_2, "decomp_scene");

  foreach(var_6 in var_2) {
    var_6 delete();
  }

  if(isDefined(var_3)) {
    var_3 delete();
  }
}

_id_D0DA() {
  level waittill("start_decomp_scene_anims");
  var_0 = scripts\sp\utility::_id_10639("decomp_corpse");
  scripts\sp\anim::_id_1F35(var_0, "decomp_scene");
  var_0 delete();
}

_id_A141() {
  var_0 = level._id_4F74;
  var_1 = scripts\sp\utility::_id_8200("ambush_jackal_spawner", "targetname");
  level._id_8B0B = scripts\sp\vehicle::_id_13237(var_1);
  thread _id_4F88();
  level._id_8B0B._id_55A4 = 1;
  level._id_8B0B hide();
  level._id_8B0E = spawn("script_model", level._id_8B0B.origin);
  level._id_8B0E.angles = level._id_8B0B.angles;
  level._id_8B0E setModel("veh_mil_air_ca_jackal_drone_atmos_periph");
  level._id_8B0E notsolid();
  level._id_8B0E linkTo(level._id_8B0B);
  level._id_8B0B._id_1FBB = "decomp_jackal";
  level._id_8B0B scripts\sp\anim::_id_F64A();
  thread _id_A27C();
  var_0 scripts\sp\anim::_id_1F35(level._id_8B0B, "decomp_intro");
  wait 0.2;
  scripts\engine\utility::flag_set("start_decompression");
  thread _id_4F87();
  var_0 scripts\sp\anim::_id_1F35(level._id_8B0B, "decomp_knockback");
  var_0 scripts\sp\anim::_id_1F35(level._id_8B0B, "decomp_scene");
}

_id_4F88() {
  var_0 = scripts\engine\utility::getStruct("start_decomp", "targetname");
  var_1 = var_0.origin - (150, 50, 0);
  var_2 = _func_313(var_1, (500, 500, 500), (0, 0, 0));
  var_3 = 400;
  var_4 = 1;
  level.player scripts\engine\utility::allow_prone(0);
  level.player scripts\engine\utility::allow_doublejump(0);
  level.player scripts\engine\utility::allow_slide(0);
  level.player scripts\engine\utility::allow_mantle(0);

  while(!scripts\engine\utility::flag("start_decompression")) {
    var_5 = distance2d(level.player.origin, var_1);
    var_6 = var_3 - var_5;

    if(var_6 > 0) {
      var_7 = var_5 / var_3;
      var_7 = 1 - var_7;
    } else
      var_7 = 0.05;

    var_7 = max(var_7, var_4 - 0.1);
    var_4 = var_7;
    level.player thread scripts\sp\utility::_id_D2CD(var_7 * 100, 0.2);
    wait 0.2;
  }

  destroynavobstacle(var_2);
  scripts\sp\utility::_id_D2CA(0.05);
  level.player scripts\engine\utility::allow_prone(1);
  level.player scripts\engine\utility::allow_doublejump(1);
  level.player scripts\engine\utility::allow_slide(1);
  level.player scripts\engine\utility::allow_mantle(1);
}

_id_4F80() {
  wait 2;
  var_0 = scripts\sp\hud_util::_id_48B7("white", 0, level.player);
  var_0 fadeovertime(0.2);
  wait 0.4;
  var_0.alpha = 1;
  var_1 = 0.4;
  var_0 fadeovertime(0.4);
  var_0.alpha = 0;
}

_id_A27C() {
  wait 1.5;
  var_0 = scripts\sp\utility::_id_10639("decomp_missile");
  var_1 = scripts\sp\utility::_id_10639("decomp_missile");
  var_0 thread _id_B818("decomp_intro1");
  var_1 thread _id_B818("decomp_intro2");
  thread _id_4F80();
}

_id_B818(var_0) {
  var_1 = level._id_4F74;
  var_1 scripts\sp\anim::_id_1F35(self, var_0);
  playFXOnTag(level._effect["jet_missile_imp_generic"], self, "tag_origin");
  self playSound("scn_moon_suck_jackal_missile_impt");
  wait 1;
  self delete();
}

_id_40DF() {
  wait 4;
  var_0 = getaiarray("axis");
  var_0 = scripts\sp\utility::array_removedeadvehicles(var_0);

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isalive(var_2)) {
      var_2 _meth_81D0();
    }
  }
}

_id_79F9(var_0) {
  level endon("start_decompression");
  var_0.ignoreall = 1;
  var_0.ignoreme = 1;
  scripts\engine\utility::flag_set(var_0._id_1FBB + "_in_decomp_pos");
}

_id_4F84() {
  level waittill("start_jackal_fire");
  _id_0BDC::_id_B155(99);
  level waittill("stop_jackal_fire");
  self notify("stop_MG_magic");
}

_id_4F83(var_0) {
  level endon("player_grab_times_up");
  var_1 = level.allies["salter"];
  var_2 = "J_Wrist_LE";
  var_1 _id_0E46::_id_48C4(var_2, undefined, &"MOON_PORT_GRAB", undefined, 800, undefined, 1);
  thread _id_0B0A::_id_583F(0, 20.27, 3, 0, 150, 2, 0.25);
  level.player playSound("scn_moon_suck_slomo_01");
  setslowmotion(1, 0.1, 0.5);
  notifyoncommand("used", "+activate");
  notifyoncommand("used", "+usereload");
  level.player waittill("used");
  scripts\engine\utility::flag_set("player_grabbed_salter");
  var_1 notify("trigger");
  setslowmotion(0.1, 1, 0.5);
}

_id_F931() {
  var_0 = getspawnerarray("decompress_corpse");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3 scripts\sp\utility::_id_10619(1);
    var_1[var_1.size] = var_4;
    var_4._id_1FBB = var_3.script_noteworthy;
  }

  var_6 = _id_792F();
  var_6 scripts\sp\anim::_id_1EC1(var_1, "decomp_knockback");
  level._id_4F79 = var_1;
}

_id_468D() {
  scripts\sp\anim::_id_1F2C(level._id_4F79, "decomp_knockback");
  scripts\sp\anim::_id_1F2C(level._id_4F79, "decomp_scene");

  foreach(var_1 in level._id_4F79) {
    var_1 delete();
  }
}

_id_2A1C() {
  level._id_4F75 = scripts\sp\utility::_id_10639("decomp_beam");
  var_0 = _id_792F();
  var_0 scripts\sp\anim::_id_1EC3(level._id_4F75, "decomp_knockback");
  scripts\engine\utility::flag_wait("start_decompression");
  var_0 scripts\sp\anim::_id_1F35(level._id_4F75, "decomp_knockback");
  var_0 scripts\sp\anim::_id_1F35(level._id_4F75, "decomp_scene");
}

_id_4F8C() {
  var_0 = level.allies["salter"];
  var_1 = level.allies["eth3n"];
  var_2 = level.allies["marineCO"];
  var_3 = level.player;
  var_0 scripts\sp\utility::_id_10347("moon_slt_lookoutskelter");
  var_2 scripts\sp\utility::_id_10347("moon_omr_itsfiring");
  scripts\engine\utility::flag_wait("start_decompression");
  var_0 thread scripts\sp\utility::_id_10347("moon_slt_decompression");
  wait 0.5;

  if(!scripts\sp\utility::_id_93A6()) {
    scripts\engine\utility::delaythread(0.5, _id_0B0B::_id_25C2, 0.5, "fast");
    var_3 scripts\sp\utility::_id_10350("moon_plr_breathersdown");
  }

  level waittill("ethen_reachout");
  var_0 scripts\sp\utility::_id_10347("moon_slt_yourmaskyoure");
}

_id_4F77() {
  scripts\engine\utility::flag_set("start_decompression");
  _id_4F78();
}

_id_4F78() {}

_id_8B21() {
  var_0 = scripts\sp\utility::_id_8200("ambush_jackal_spawner", "targetname");
  level._id_8B0B = scripts\sp\vehicle::_id_13237(var_0);
  _id_BC51();
  var_1 = ["marineCO", "salter", "eth3n"];
  scripts\sp\maps\moon_port\moon_port_util::_id_BC05("start_harass", var_1);
  var_2 = _id_F997();
  scripts\sp\maps\moon_port\moon_port_util::_id_D1E7(undefined, "moon_low_g_exterior", var_2);

  foreach(var_4 in level.allies) {
    var_4 scripts\sp\utility::_id_54F7();
  }

  thread _id_CB88();
  thread _id_F9D1();
  scripts\engine\utility::exploder("walkway_flak");
  _id_0E4B::_id_8E06();
  scripts\sp\maps\moon_port\moon_port_anim::_id_479E(level.player);
  level.player scripts\engine\utility::delaycall(0.6, ::playsound, "scn_moon_suck_helmet_glass_worsen_01");
  thread _id_12D85(1);
}

_id_8B0F() {
  scripts\engine\utility::flag_set("player_indoor_p2_noblur");
  level notify("explo_lights_off");
  level notify("coastguard_ammo_cleanup");
  thread _id_8B24();
  thread _id_50CB();
  level._id_470F = 1;
  level.player takeallweapons();
  level.player giveweapon("iw7_gunless");
  level.player switchtoweaponimmediate("iw7_gunless");
  thread _id_8B16();
  level._id_5A5E = 0;
  thread scripts\sp\utility::_id_2670();
  thread _id_8B18();
  thread _id_8B10();
  thread _id_8AEF();
  thread _id_8B0B();
  thread _id_BA40();
  thread _id_8AF3();
  _id_8B1B();

  if(scripts\engine\utility::flag("harass_safe_zone")) {
    scripts\engine\utility::flag_set("harass_player_pushing_forward");
  }

  scripts\engine\utility::flag_set("harass_safe_zone");
  level.player _meth_80CB(0);
  level.player _meth_80A1();
  level._id_5A5E = 1;
  thread _id_8AF5();
}

_id_8B24() {
  var_0 = scripts\engine\utility::getStruct("hangar_halls_airlock_door_cursor_struct", "targetname");
  var_0 endon("trigger");
  var_1 = level.allies["salter"];
  var_2 = level.allies["eth3n"];
  var_3 = level.allies["marineCO"];
  var_4 = level.player;
  wait 0.5;
  var_2 scripts\sp\utility::_id_10347("moon_eth_hangarentrydead");
  var_3 scripts\sp\utility::_id_10347("moon_mco_getyourselvesintothe");
  wait 3;
  var_1 scripts\sp\utility::_id_10347("moon_slt_reesehustle");
  wait 5;
  var_3 scripts\sp\utility::_id_10347("moon_mco_getonthathatch");
  wait 3;
  var_1 scripts\sp\utility::_id_10347("moon_slt_reesesmaskiscode");
  scripts\engine\utility::flag_set("sfx_jackal_moved");
  var_3 thread scripts\sp\utility::_id_10347("moon_mco_efforts1");
  var_2 scripts\sp\utility::_id_10347("moon_eth_backpressuresto");
  var_1 thread scripts\sp\utility::_id_10347("moon_slt_efforts1");
  var_3 scripts\sp\utility::_id_10347("moon_mco_lieutenantreesewe");
  var_1 scripts\sp\utility::_id_10347("moon_slt_sonofabitch");
}

_id_50CB() {
  wait 1;
  thread scripts\sp\utility::_id_266F();
}

_id_F997() {
  var_0 = [];
  var_0["bg_gravity"] = 195;
  var_0["g_speed"] = 86;
  var_0["friction"] = 0.85;
  var_0["bg_fallDamageMinHeight"] = 1000;
  var_0["bg_fallDamageMaxHeight"] = 1500;
  var_0["bg_sprintLoopTimeScale"] = 2.5;
  var_0["jump_slowdownEnable"] = 0;
  var_0["bg_weaponBobAmplitudeStanding"] = "0.5 0.5";
  var_0["bg_weaponBobAmplitudeSprinting"] = "0.5 0.5";
  var_0["mantle_enable"] = 0;
  var_0["doublejump"] = 0;
  var_0["wallrun"] = 0;
  var_0["bobrate"] = 2.75;
  return var_0;
}

_id_8B1B() {
  level.player scripts\engine\utility::allow_crouch(0);
  level.player scripts\engine\utility::allow_prone(0);
  level.player scripts\engine\utility::allow_slide(0);
  wait 0.05;
  scripts\engine\utility::exploder("broken_airlock");
  thread scripts\sp\maps\moon_port\moon_port_util::_id_1AC5("red");
  level.player thread _id_10316();
  scripts\engine\utility::flag_set("do_monorail_mayhem");
  scripts\engine\utility::flag_wait("harass_end_chase");
  level notify("next_fire_position");
  level.player _meth_80CB(0);
  level.player _meth_80A1();
}

_id_8B16() {
  level.player _meth_80CB(1);
  level.player _meth_80D1();

  while(!scripts\engine\utility::flag("harass_end_chase") && !scripts\engine\utility::flag("kill_player_with_harass_jackal")) {
    if(level.player _meth_8525() == 0) {
      level.player _meth_80CB(1);
      level.player _meth_80D1();
    }

    wait 0.05;
  }

  level.player _meth_80CB(0);
  level.player _meth_80A1();
}

_id_10316() {
  level endon("harass_end_chase");

  for(;;) {
    level.player waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(var_4 == "mod_explosive") {
      level.player setmovespeedscale(0.5);
      wait 2;
      level.player setmovespeedscale(1);
    }
  }
}

_id_8AEF() {
  if(!isDefined(level._id_4F74)) {
    level._id_4F74 = _id_792F();
  }

  var_0 = [level.allies["salter"], level.allies["eth3n"], level.allies["marineCO"]];

  foreach(var_2 in var_0) {
    level._id_4F74 thread scripts\sp\anim::_id_1F35(var_2, "harass_run");
  }
}

_id_1D1C(var_0) {
  level._id_4F74 scripts\sp\anim::_id_1F35(var_0, "harass_run");
  var_1 = getEnt("broken_airlock_animnode", "targetname");

  switch (var_0._id_1FBB) {
    case "salter":
      var_1 thread scripts\sp\anim::_id_1EEA(self, "broken_airlock_xo_push_loop", "stop_harass_idles");
      break;
    case "marineCO":
      var_1 thread scripts\sp\anim::_id_1EEA(self, "broken_airlock_mco_push_loop", "stop_harass_idles");
      break;
    case "eth3n":
      var_1 thread scripts\sp\anim::_id_1EEA(self, "broken_airlock_c6i_push_loop", "stop_harass_idles");
      break;
    default:
      break;
  }
}

_id_8B10() {
  var_0 = ["mdf1"];
  scripts\sp\maps\moon_port\moon_port_util::_id_48BF(var_0);

  if(!isDefined(level._id_4F74)) {
    level._id_4F74 = _id_792F();
  }

  var_1 = getspawner("mdf2", "targetname");
  var_1._id_EE5A = 1;
  var_1._id_ED1B = 1;
  var_1 = getspawner("mdf3", "targetname");
  var_1._id_EE5A = 1;
  var_1._id_ED1B = 1;
  var_2 = [];
  var_3 = level.allies["mdf1"];
  var_4 = getspawner("mdf2", "targetname") scripts\sp\utility::_id_10619(1);
  var_4._id_1FBB = "mdf2";
  var_4.name = "Pvt. Vacid";
  var_4 notsolid();
  var_5 = getspawner("mdf3", "targetname") scripts\sp\utility::_id_10619(1);
  var_5._id_1FBB = "mdf3";
  var_5.name = "Pvt. Flazka";
  var_5 notsolid();
  var_2 = [var_3, var_4, var_5];
  level._id_8B1A = [var_4, var_5];

  foreach(var_7 in var_2) {
    if(var_7 != var_3) {
      var_7 thread _id_B50C();
      continue;
    }

    var_7 thread _id_B50A();
  }
}

_id_B50C() {
  level._id_4F74 scripts\sp\anim::_id_1F35(self, "harass_run");
  level._id_4F74 scripts\sp\anim::_id_1EE0(self, "harass_run");
  level waittill("hangar_player_used_airlock");
  self delete();
}

_id_B50A() {
  level endon("hangar_player_used_airlock");
  level._id_4F74 scripts\sp\anim::_id_1F35(self, "harass_run");
  level._id_4F74 scripts\sp\anim::_id_1EEA(self, "harass_run_idle", "stop_idle");
}

#using_animtree("jackal");

_id_8B0B() {
  if(!isDefined(level._id_4F74)) {
    level._id_4F74 = _id_792F();
  }

  if(!isDefined(level._id_8B0B._id_1FBB)) {
    level._id_8B0B._id_1FBB = "decomp_jackal";
    level._id_8B0B scripts\sp\anim::_id_F64A();
  }

  level._id_8B0B thread _id_A609();
  level._id_8B0B thread _id_A201();
  level._id_4F74 thread scripts\sp\anim::_id_1F35(level._id_8B0B, "harass");
  level._id_8B0B _meth_82B1(%moon_suckout_run_jackal, 1.25);
  wait 25.6;

  if(isDefined(level._id_8B0B)) {
    level._id_8B0B delete();
  }
}

_id_A201() {
  self endon("delete");
  var_0 = [];
  var_0[0] = ::scripts\engine\utility::getStruct("hj_pillar_targ_0", "targetname");
  var_0[1] = ::scripts\engine\utility::getStruct("hj_pillar_targ_1", "targetname");
  var_0[2] = ::scripts\engine\utility::getStruct("hj_pillar_targ_2", "targetname");
  var_0[3] = ::scripts\engine\utility::getStruct("hj_pillar_targ_3", "targetname");
  var_0[4] = ::scripts\engine\utility::getStruct("hj_pillar_targ_4", "targetname");

  while(!isDefined(level._id_8B1A)) {
    wait 0.05;
  }

  var_1 = scripts\engine\utility::spawn_tag_origin();
  var_1.team = "allies";
  _id_0BDC::_id_19B5(var_1);
  thread _id_A1C1(var_1);
  scripts\engine\utility::delaythread(2.0, scripts\engine\utility::play_sound_in_space, "scn_moon_jackal_squibs_01", (12660, 13540, -54500));
  scripts\engine\utility::flag_wait("break_pillar_1");
  var_1.origin = var_0[0].origin;
  var_1 playSound("scn_moon_jackal_pillar_hit_01");
  wait 2.5;
  var_1 moveTo(level._id_8B1A[0] gettagorigin("tag_eye"), 0.5, 0.2, 0.2);
  var_1 playSound("scn_moon_jackal_redshirt_hit_01");
  scripts\engine\utility::flag_wait("break_pillar_2");
  var_1 moveTo(var_0[1].origin + (0, 0, 75), 0.5, 0.1, 0.1);
  var_1 playSound("scn_moon_jackal_pillar_hit_02");
  scripts\engine\utility::delaythread(1.0, scripts\engine\utility::play_sound_in_space, "scn_moon_jackal_squibs_02", (13090, 13230, -54500));
  scripts\engine\utility::flag_wait("target_redshirt_1");
  var_1 moveTo(level._id_8B1A[1] gettagorigin("j_spine4"), 0.5, 0.2, 0.2);
  var_1 playSound("scn_moon_jackal_redshirt_hit_02");
  scripts\engine\utility::flag_wait("break_pillar_3");
  var_1 moveTo(var_0[2].origin + (0, 0, 75), 0.5, 0.1, 0.1);
  var_1 playSound("scn_moon_jackal_pillar_hit_03");
  scripts\engine\utility::delaythread(1.0, scripts\engine\utility::play_sound_in_space, "scn_moon_jackal_squibs_03", (13164, 12959, -54400));
  wait 2;
  var_1 moveTo(var_0[3].origin, 2, 0.2, 0.2);
  var_1 playSound("scn_moon_jackal_pillar_hit_04");
  wait 2;
  var_1 moveTo(var_0[4].origin, 2, 0.2, 0.2);
  var_1 playSound("scn_moon_jackal_pillar_hit_05");
  scripts\engine\utility::delaythread(1.0, scripts\engine\utility::play_sound_in_space, "scn_moon_jackal_squibs_02", (13164, 12959, -54400));
  scripts\engine\utility::delaythread(6.5, scripts\engine\utility::play_sound_in_space, "scn_moon_jackal_squibs_03", (13164, 12959, -54400));
}

_id_A1C1(var_0) {
  self endon("player_must_die");
  level.player endon("death");
  _id_0BDC::_id_19AE("shoot_forever");
  scripts\engine\utility::flag_wait("break_pillar_2");
  thread scripts\engine\utility::play_sound_in_space("scn_moon_suck_building_expl_01", var_0.origin);
  _id_0B76::_id_1992("TAG_FLASH", var_0, 1);
  wait 2;
  _id_0BDC::_id_19AE("shoot_forever");
  scripts\engine\utility::flag_wait("break_pillar_3");
  thread scripts\engine\utility::play_sound_in_space("scn_moon_suck_building_expl_02", var_0.origin);
  _id_0B76::_id_1992("TAG_FLASH", var_0, 1);
  wait 2;
  _id_0BDC::_id_19AE("shoot_forever");
  wait 2;
  _id_0BDC::_id_19AE("shoot_now");

  while(isDefined(self)) {
    wait(randomfloatrange(1.5, 4));

    if(!isDefined(self)) {
      break;
    }

    _id_0B76::_id_1992("TAG_FLASH", var_0, 1);

    if(scripts\engine\utility::flag("sfx_jackal_moved")) {
      var_0 scripts\engine\utility::delaythread(0.7, scripts\sp\utility::play_sound_on_entity, "scn_moon_suck_building_expl_generic");
      continue;
    }

    var_0 playSound("scn_moon_suck_building_expl_generic");
  }
}

_id_BC51() {
  level._id_4F74 = _id_792F();
  var_0 = scripts\sp\utility::_id_10639("player_rig");
  level._id_4F74 scripts\sp\anim::_id_1EE0(var_0, "decomp_scene_b");
  level.player setOrigin(var_0.origin);
  level.player setplayerangles(var_0.angles);
  var_0 delete();
}

_id_CB88() {
  var_0 = scripts\engine\utility::getStructArray("mayhem_pillar_struct", "targetname");
  var_1 = [];
  wait 0.5;

  foreach(var_3 in var_0) {
    if(var_3.script_noteworthy == "pillar_0") {
      var_1[0] = spawnmayhem("may_pillar_0", "vfx_mayh_moon_pillar_fragment", var_3.origin, var_3.angles);
      pausemayhem("may_pillar_0");
      continue;
    }

    if(var_3.script_noteworthy == "pillar_1") {
      var_1[1] = spawnmayhem("may_pillar_1", "vfx_mayh_moon_pillar_fragment", var_3.origin, var_3.angles);
      pausemayhem("may_pillar_1");
      continue;
    }

    if(var_3.script_noteworthy == "pillar_2") {
      var_1[2] = spawnmayhem("may_pillar_2", "vfx_mayh_moon_pillar_fragment", var_3.origin, var_3.angles);
      pausemayhem("may_pillar_2");
    }
  }

  scripts\engine\utility::flag_wait("break_pillar_1");
  playmayhem("may_pillar_0");
  scripts\engine\utility::flag_wait("break_pillar_2");
  playmayhem("may_pillar_1");
  scripts\engine\utility::flag_wait("break_pillar_3");
  playmayhem("may_pillar_2");
}

_id_BA40() {
  if(!isDefined(level._id_BA3F)) {
    return;
  }
  thread scripts\engine\utility::play_sound_in_space("scn_moon_suck_building_destr_01", (12550, 13248, -54351));
  thread scripts\engine\utility::play_sound_in_space("scn_moon_suck_bridge_creak", (12500, 13250, -54350));
  level._id_BA3F scripts\sp\anim::_id_1F35(level._id_BA3F, "monorail_buckle");
}

_id_A609() {
  var_0 = scripts\engine\utility::getStruct("hangar_halls_airlock_door_cursor_struct", "targetname");
  var_0 endon("trigger");
  level.player endon("death");
  scripts\engine\utility::flag_wait("kill_player_with_harass_jackal");
  self notify("player_must_die");
  _id_0BDC::_id_19AE("dont_shoot");
  thread _id_A602();
  level.player _meth_80CB(0);
  level.player _meth_80A1();
  _id_0BDC::_id_198A();
  var_1 = scripts\engine\utility::getStruct("harass_player_murder_locaiton", "targetname");
  self _meth_83A1();
  _id_0BDC::_id_19B0("hover");
  _id_0BDC::_id_19AB(90, 20, 40, 10);
  self.goalradius = 512;
  thread _id_8AFC();
  _id_0BDC::_id_19A0(1);
  _id_0BDC::_id_19B5(level.player);
  wait 4;
  _id_0BDC::_id_19AE("shoot_forever");

  for(;;) {
    wait(randomfloatrange(1, 2));
    _id_0B76::_id_1992("TAG_FLASH", level.player, 1);
  }
}

_id_8AFC() {
  var_0 = [];
  var_1 = scripts\engine\utility::getStruct("harass_player_murder_locaiton", "targetname");
  var_0[0] = var_1;

  for(var_2 = 1; var_2 < 99; var_2++) {
    var_0[var_2] = ::scripts\engine\utility::getStruct(var_0[var_2 - 1].target, "targetname");

    if(!isDefined(var_0[var_2].target)) {
      break;
    }
  }

  thread _id_A627();

  for(;;) {
    foreach(var_4 in var_0) {
      thread _id_0BDC::_id_A1EC(var_4.origin, 1, 368);
      wait 5;
    }

    var_0 = scripts\engine\utility::array_reverse(var_0);
  }
}

_id_A627() {
  var_0 = level.player.origin;

  for(;;) {
    var_1 = var_0 - self.origin;
    var_2 = vectortoangles(var_1);
    _id_0BDC::_id_19B2("face angle", var_2);
    wait 0.05;

    if(isalive(level.player)) {
      var_0 = level.player.origin;
    }
  }
}

_id_A602() {
  level.player endon("death");
  level.player waittill("damage");
  wait 1;
  level.player _meth_81D0();
}

_id_8B18() {
  level.player endon("death");
  level endon("got_to_airlock");
  thread _id_8B14();
  level.player thread _id_D332(40);
}

_id_D332(var_0) {
  var_1 = gettime();
  var_2 = scripts\sp\hud_util::_id_48B7("black", 0, level.player);
  level.player thread _id_D0B8();

  while(!scripts\engine\utility::flag("hangar_airlock_push_start")) {
    var_3 = gettime() - var_1;

    if(var_3 > var_0 * 0.75 * 1000) {
      var_4 = 0.5;
      var_5 = 1;
      var_6 = 0.75;
      var_7 = (randomint(3) + 4) * 1.5;
      var_8 = 10;
    } else if(var_3 > var_0 * 0.5 * 1000) {
      var_4 = 1;
      var_5 = 2.5;
      var_6 = 0.5;
      var_7 = (randomint(3) + 4) * 1.2;
      var_8 = 7;
    } else if(var_3 > var_0 * 0.25 * 1000) {
      var_4 = 2.5;
      var_5 = 4;
      var_6 = 0.35;
      var_7 = (randomint(3) + 4) * 0.9;
      var_8 = 5;
    } else {
      var_4 = 4;
      var_5 = 5.5;
      var_6 = 0.15;
      var_7 = (randomint(3) + 4) * 0.75;
      var_8 = 3;
    }

    wait(randomfloatrange(var_4, var_5));
    var_7 = var_7 * 0.25;
    level.player _meth_81DE(65 - var_8, 1);
    var_2 thread scripts\sp\hud_util::_id_6AAB(var_6, 1);

    if(gettime() - var_1 > var_0 * 1000 && !scripts\engine\utility::flag("hangar_airlock_push_start")) {
      setblur(20, 0.25);
      _id_0B60::_id_F322("MOON_PORT_HARASS_DEATH");
      level.player _meth_80CB(0);
      level.player _meth_80A1();
      level.player _meth_81D0();
      continue;
    }

    wait(randomfloatrange(1.5, 2));
    var_2 thread scripts\sp\hud_util::_id_6AAB(0, 1);
    level.player _meth_81DE(65, 2);
  }

  var_2 thread scripts\sp\hud_util::_id_6AAB(0, 1);
  return;
}

_id_12D85(var_0) {
  level endon("hangar_player_used_airlock");
  var_1 = 1000;
  var_2 = floor(2.5);

  if(!isDefined(var_0)) {} else
    var_1 = 800;

  for(;;) {
    setomnvar("ui_helmet_meter_oxygen", var_1);
    wait 0.1;
    var_1 = var_1 - var_2;

    if(var_1 <= 0) {
      setomnvar("ui_helmet_meter_oxygen", 0);
      break;
    }

    if(getdvarint("show_o2_debug") == 1) {
      iprintlnbold(getomnvar("ui_helmet_meter_oxygen"));
    }
  }
}

_id_D0B8() {
  if(!isDefined(self._id_8632)) {
    self._id_8632 = scripts\engine\utility::spawn_tag_origin(level.player.origin, (0, 0, 0));
  }

  level.player _meth_823F(self._id_8632);
  var_0 = [];
  var_0["pitch"]["min"] = -3;
  var_0["pitch"]["max"] = 4;
  var_0["yaw"]["min"] = -8;
  var_0["yaw"]["max"] = 5;
  var_0["roll"]["min"] = 3;
  var_0["roll"]["max"] = 5;

  while(!scripts\engine\utility::flag("harass_end_chase")) {
    var_1 = randomfloatrange(var_0["pitch"]["min"], var_0["pitch"]["max"]);
    var_2 = randomfloatrange(var_0["roll"]["min"], var_0["roll"]["max"]);
    var_3 = randomfloatrange(var_0["yaw"]["min"], var_0["yaw"]["max"]);

    if(randomint(100) < 20) {
      var_1 = var_1 * 1.5;
    }

    var_4 = (var_1, var_3, var_2);
    var_4 = scripts\sp\maps\moon_port\moon_port_util::_id_186F(var_4);
    self._id_8632 rotateTo(var_4, randomfloatrange(5, 9), 0, 0);
    self._id_8632 waittill("rotatedone");
  }

  var_4 = (0, 0, 0);
  var_4 = scripts\sp\maps\moon_port\moon_port_util::_id_186F(var_4);
  self._id_8632 rotateTo(var_4, 1, 0, 0);
  self._id_8632 waittill("rotatedone");
  level.player _meth_823F(undefined);
}

_id_8B14() {
  level waittill("got_to_airlock");
  level waittill("harass_blackout_ended");
  level notify("harass_blackout_ender");
}

_id_D082(var_0) {
  level endon("hangar_airlock_done");
  self endon("death");
  var_1 = 20;
  var_2 = var_1 / var_0;
  var_3 = 65;

  for(var_4 = 0; var_4 < var_0; var_4++) {
    level.player _meth_81DE(var_3 - var_2, 1);
    var_3 = var_3 - var_2;
    wait 1;
  }
}

_id_F9D1() {
  var_0 = getEnt("mco_vault_hurdle", "targetname");
  var_1 = getEnt(var_0.target, "targetname");
  var_2 = _id_792F();
  var_0._id_1FBB = "vault_obj";
  var_0 scripts\sp\anim::_id_F64A();
  var_1 linkTo(var_0);
  var_2 scripts\sp\anim::_id_1EC3(var_0, "mco_vault_obj");
}

_id_8AF4() {
  thread _id_8AF5();
}

_id_8AF5() {
  scripts\engine\utility::flag_wait("hangar_player_used_airlock");

  if(isDefined(level._id_8B0B)) {
    level._id_8B0B notify("stop_periodic_fire");
    level._id_8B0B delete();
  }

  level.player _meth_80A1();
  level.player _meth_80CB(0);
  level.player _meth_80A1();

  foreach(var_1 in level.allies) {
    var_1 scripts\sp\utility::_id_61C7();
  }
}