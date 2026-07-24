/**************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\pearlharbor\pearlharbor_robots.gsc
**************************************************************/

_id_C9E2() {
  scripts\engine\utility::flag_init("eth3n_boost_jump");
  scripts\engine\utility::flag_init("start_dust_area");
  scripts\engine\utility::flag_init("dust_cloud_hit");
  scripts\engine\utility::flag_init("dust_cloud_triggered");
  scripts\engine\utility::flag_init("player_got_hackdevice");
  scripts\engine\utility::flag_init("player_used_hackdevice");
  scripts\engine\utility::flag_init("hacking_tutorial_finished");
  scripts\engine\utility::flag_init("pod_2_landed");
  scripts\engine\utility::flag_init("pod_1_landed");
  scripts\engine\utility::flag_init("pod_door_landed");
  scripts\engine\utility::flag_init("c6_intro_finished");
  scripts\engine\utility::flag_init("alert_bus_enemies");
  scripts\engine\utility::flag_init("player_opened_cafe_exit");
  scripts\engine\utility::flag_init("move_player_through_reveal_pod");
  scripts\engine\utility::flag_init("stop_cafe_nags");
  scripts\engine\utility::flag_init("turn_on_player_knockback");
  scripts\engine\utility::flag_init("hacked_robot_dealt_damage");
  scripts\engine\utility::flag_init("courtyard_droppods_landed");
  scripts\engine\utility::flag_init("cafe_score_reached");
  scripts\engine\utility::flag_init("cafe_sdf_fallback");
  scripts\engine\utility::flag_init("robot_alley_paths_started");
  scripts\engine\utility::flag_init("robot_alley_runner01_pass");
  scripts\engine\utility::flag_init("robot_alley_runner02_pass");
  scripts\engine\utility::flag_init("robot_alley_runners_pass");
  scripts\engine\utility::flag_init("c6_reveal_ambient_pod_spawned_3");
  scripts\engine\utility::flag_init("robot_alley_final_drop_pod");
  scripts\engine\utility::flag_init("robot_alley_vo_complete");
  scripts\engine\utility::flag_init("c6_reveal");
  scripts\engine\utility::flag_init("c6_reveal_started");
  scripts\engine\utility::flag_init("c6_reveal_impact");
  scripts\engine\utility::flag_init("c6_reveal_player_interacted");
  scripts\engine\utility::flag_init("c6_reveal_complete");
  scripts\engine\utility::flag_init("courtyard_gate_droppod_landed");
  scripts\engine\utility::flag_init("start_peek_execution");
  scripts\engine\utility::flag_init("player_saved_cafe_guys");
  scripts\engine\utility::flag_init("cafe_player_start_peek");
  scripts\engine\utility::flag_init("cafe_droppods_can_fall");
  scripts\engine\utility::flag_init("cafe_looking_at_window");
  scripts\engine\utility::flag_init("cafe_looking_at_window_long");
  scripts\engine\utility::flag_init("cafe_stumble_looking_down");
  scripts\engine\utility::flag_init("cafe_eth3n_ready_to_flip");
  scripts\engine\utility::flag_init("cafe_eth3n_flip_table");
  scripts\engine\utility::flag_init("cafe_eth3n_holding_table");
  scripts\engine\utility::flag_init("cafe_eth3n_idling");
  scripts\engine\utility::flag_init("cafe_eth3n_idling2");
  scripts\engine\utility::flag_init("cafe_vo_done");
  createthreatbiasgroup("robot_alley_left_allies");
  createthreatbiasgroup("robot_alley_bottom_street_enemies");
  setthreatbias("robot_alley_bottom_street_enemies", "robot_alley_left_allies", -500);
  setthreatbias("robot_alley_left_allies", "robot_alley_bottom_street_enemies", -500);
  scripts\sp\utility::_id_16EB("hint_start_hack", &"PHSTREETS_HINT_START_HACK", ::_id_900B);
  getspawner("robot_alley_seeker_civ", "script_noteworthy") scripts\sp\utility::_id_1747(::_id_E575);
  getspawner("c6_reveal_civi_walker", "script_noteworthy") scripts\sp\utility::_id_1747(::_id_339A);
  getspawner("c6_reveal_stumbler", "script_noteworthy") scripts\sp\utility::_id_1747(::_id_33A7);
  scripts\sp\utility::_id_22C9("c6_reveal_alley_runners", scripts\sp\maps\pearlharbor\pearlharbor_util::_id_19C5);
  scripts\sp\utility::_id_22C9("c6_reveal_ambient_droppods", ::_id_3399);
  getspawner("robot_alley_seeker_civ", "script_noteworthy") scripts\sp\utility::_id_1747(scripts\sp\maps\pearlharbor\pearlharbor_util::_id_3FAC);
  getspawner("c6_reveal_civi_walker", "script_noteworthy") scripts\sp\utility::_id_1747(scripts\sp\maps\pearlharbor\pearlharbor_util::_id_3FAC);
  getspawner("c6_reveal_stumbler", "script_noteworthy") scripts\sp\utility::_id_1747(scripts\sp\maps\pearlharbor\pearlharbor_util::_id_3FAC);
  scripts\sp\utility::_id_22C9("c6_reveal_alley_runners", scripts\sp\maps\pearlharbor\pearlharbor_util::_id_3FAC);
  getEnt("robot_courtyard_capitalship", "script_noteworthy") scripts\sp\utility::_id_1747(::_id_E580);
  getEnt("robot_alley_dropoff_dropship", "script_noteworthy") scripts\sp\utility::_id_1747(::_id_E56D);
  getspawner("robot_alley_stairs_jumper", "script_noteworthy") scripts\sp\utility::_id_1747(scripts\sp\maps\pearlharbor\pearlharbor_util::_id_19C5);
  getspawner("robot_alley_stairs_jumper", "script_noteworthy") scripts\sp\utility::_id_1747(::_id_1C04);
  getEnt("courtyard_gate_droppod", "script_noteworthy") scripts\sp\utility::_id_1747(::_id_46D2);
  scripts\sp\utility::_id_22C9("robot_balcony_jumper", ::_id_E57A);
  scripts\sp\utility::_id_22C9("pod_group_0", ::_id_46EA);
  scripts\sp\utility::_id_22C9("pod_group_1", ::_id_46EA);
  scripts\sp\utility::_id_22CA("courtyard_gate_droppod_robots", ::_id_46EA);
  precachemodel("furniture_parasol_open_grey_dustable");
  precacheshellshock("phstreets_c6_reveal");
  precachemodel("veh_mil_air_un_destroyer_detail_05_nova");
  precachemodel("lobby_table_02_dmg");
  precachemodel("lobby_table_02_dmg_01");
  precachemodel("gauntlet_wm");
  precachestring(&"PHSTREETS_HACKING_DEVICE");
  getEnt("aatis_tower_periph", "targetname") dontcastshadows();
  getEnt("aatis_tower_periph", "targetname") notsolid();
  level._effect["vfx_c6_scanner_green"] = loadfx("vfx/iw7/core/robot/vfx_c6_scanner_green.vfx");
  level._effect["vfx_c6_scanner_red"] = loadfx("vfx/iw7/core/robot/vfx_c6_scanner_red.vfx");
  thread _id_33A6();
  thread _id_E57C();
  var_0 = getEnt("cafe_window_nav_clip", "targetname");
  var_0.origin = (68216, 40374, -34370);
  var_0 scripts\engine\utility::delaycall(0.1, ::disconnectpaths);
}

_id_3950() {
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC53("start_cap_crash_dust");
  thread scripts\sp\maps\phstreets\phstreets::_id_F51C("med_battle", 1);
  var_0 = ["admiral", "salter", "eth3n"];
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC05("start_cap_crash_dust", var_0);
}

_id_394F() {
  if(scripts\sp\utility::_id_93A6())
    thread scripts\sp\specialist_MAYBE::_id_2683();

  thread _id_5F66();
  thread _id_D7D5();
  level.allies["eth3n"] scripts\sp\utility::_id_F3B5("y");
  level.allies["salter"] scripts\sp\utility::_id_F3B5("g");
  level.allies["admiral"] scripts\sp\utility::_id_F3B5("b");
  var_0 = getEntArray("before_dust_triggers", "targetname");

  foreach(var_2 in var_0)
  var_2 scripts\engine\utility::trigger_off();

  var_4 = getEntArray("dust_moment_swap_after", "targetname");

  foreach(var_6 in var_4)
  var_6 hide();

  thread _id_5F5D();
  thread _id_6755();
  thread _id_E574();
  scripts\engine\utility::flag_wait("start_dust_area");
  thread _id_5F59();
  thread _id_5F65();
  thread _id_5F3A();
  thread _id_5F67();
  thread _id_3FC0();
  thread _id_5F52(6.0);
  wait 12.5;
  scripts\engine\utility::flag_set("dust_cloud_triggered");

  foreach(var_9 in level.allies) {
    if(var_9._id_1FBB != "eth3n")
      var_9 scripts\sp\utility::_id_51E1("frantic");
  }

  thread _id_42BA();
  thread _id_5F3B();
  thread _id_5F63();
  _id_13747();
  scripts\engine\utility::flag_set("dust_cloud_hit");

  foreach(var_9 in level.allies)
  var_9 scripts\sp\utility::_id_51E1("cqb");

  thread _id_D6CB();
  thread _id_5F68();
  thread _id_5F5B();
  thread _id_D6CA();
  thread _id_42B5();
  thread _id_756E();
  scripts\engine\utility::exploder("dustmoment_floating_papers");
  level.player scripts\sp\utility::_id_F526("relaxed");
  level.player allowsprint(0);
  level.player thread scripts\sp\utility::_id_D2D1(60, 1);
  scripts\engine\utility::delaythread(5, scripts\sp\utility::_id_D2CA, 3);
  thread _id_394E();
  thread _id_394D();
}

_id_D7D5() {
  scripts\sp\utility::_id_127B3("pre_nova_crash_sound");
}

_id_394E() {
  scripts\engine\utility::flag_wait("cap_crash_dust_complete");

  foreach(var_1 in level.allies)
  var_1 scripts\sp\utility::_id_4145();

  level.allies["eth3n"] _id_A5DB();
  level.player notify("dust_complete");
  level.player allowsprint(1);
  visionsetnaked("", 8);
  scripts\sp\utility::_id_10FEC("dustmoment_floating_papers");
  scripts\engine\utility::exploder("alley_floating_papers");
}

_id_756E() {
  wait 2;
  scripts\engine\utility::exploder("dark_debris");
}

_id_D6CB() {
  wait 1.0;
  setaudiotriggerstate("dustystreetcrash", "dust_cloud_all_black", 1.25);
  wait 5.5;
  setaudiotriggerstate("dustystreetcrash", "dust_cloud", 8);
  setglobalsoundcontext("dusty", "yes");
  thread _id_FB31();
  var_0 = getEnt("sfx_amb_clear_dust", "targetname");
  var_0 thread _id_4170();
}

_id_FB31() {
  scripts\engine\utility::delaythread(2, scripts\engine\utility::play_sound_in_space, "car_alarm_horn", (62119, 34316, -34110));
  var_0 = scripts\engine\utility::play_loopsound_in_space("car_alarm_future_04", (63453, 33524, -34084));
  wait 17;
  var_0 stoploopsound();
  var_0 playSound("car_alarm_future_off");
  wait 2;
  var_0 delete();
}

_id_416F() {
  setaudiotriggerstate("dustystreetcrash", "med_battle", 20);
  setglobalsoundcontext("dusty", "");
}

_id_4170() {
  for(;;) {
    self waittill("trigger");
    thread _id_416F();
  }
}

_id_5F66() {
  scripts\engine\utility::flag_wait("start_dust_area");
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0._id_1120D = (-28, 16, 0);
  var_0._id_75AC = (0, 0, 0);
  var_1 = (150000, 0, 0);
  var_1 = rotatevector(var_1, var_0._id_1120D + var_0._id_75AC);
  var_2 = level.player.origin;
  var_0.origin = var_2 + var_1;
  scripts\engine\utility::flag_wait("dust_cloud_hit");
}

_id_5F5D() {
  showmayhem("dust_banner_mayhem");
  scripts\engine\utility::flag_wait("dust_cloud_triggered");
  wait 0;
  playmayhem("dust_banner_mayhem");
  scripts\engine\utility::flag_wait("c6_reveal");
  pausemayhem("dust_banner_mayhem");
  hidemayhem("dust_banner_mayhem");
}

_id_5F63() {
  var_0 = getscriptablearray("foliage_tree_beech", "targetname");
  wait 3.5;

  foreach(var_2 in var_0)
  var_2 setscriptablepartstate("root", "hit");
}

_id_5F3B() {
  var_0 = getEntArray("dust_street_car", "targetname");
  scripts\engine\utility::flag_wait("dust_cloud_triggered");

  foreach(var_2 in var_0)
  var_2 thread _id_5F62();
}

_id_5F62() {
  var_0 = getEnt("smoke", "targetname");
  self._id_1FBB = "car";
  var_1 = scripts\engine\utility::spawn_tag_origin();

  for(var_2 = 9999; var_2 > 3250; var_2 = distance(var_0.origin, self.origin))
    wait 0.05;

  radiusdamage(self.origin, 32, 2, 2);
  self _meth_82A2(scripts\sp\utility::_id_7DC1("dust_push"));
}

_id_5F52(var_0) {
  wait(var_0);
  var_1 = scripts\engine\utility::getStruct("dust_civi_run_node", "targetname");
  var_2 = getspawnerarray("dust_civi_run_spawner");
  var_3 = [];

  for(var_4 = 0; var_4 < 14; var_4++) {
    var_5 = scripts\engine\utility::random(var_2);
    var_5.count++;
    var_6 = var_5 scripts\sp\utility::_id_10619(1, 1);
    var_3[var_3.size] = var_6;
    var_7 = var_4 + 1;

    if(var_7 < 10)
      var_7 = "0" + var_7;

    var_1 thread scripts\sp\anim::_id_1EC7(var_6, "ph_dust_civi_run_" + var_7);
    wait 0.05;
  }

  level waittill("blackfade");

  foreach(var_6 in var_3) {
    var_6 scripts\sp\utility::_id_1101B();
    var_6 delete();
  }
}

_id_6755() {
  var_0 = scripts\engine\utility::getStruct("ethan_tp_point_dust", "targetname");
  var_1 = scripts\engine\utility::getStruct("atom_boost", "targetname");
  var_2 = scripts\engine\utility::getStruct("atom_boost_interact", "targetname");
  var_3 = scripts\engine\utility::spawn_tag_origin(var_2.origin, var_2.angles);
  level.player._id_1E9C = scripts\sp\utility::_id_10639("player_rig", var_1.origin, var_1.angles);
  level.player._id_1E9C hide();
  var_1 scripts\sp\anim::_id_1EC3(level.player._id_1E9C, "ethan_boost_pull");
  var_1 scripts\sp\anim::_id_1F17(level.allies["eth3n"], "ethan_boost_jump");
  level.allies["eth3n"] scripts\sp\utility::_id_F492(1);
  thread _id_6757();
  level.allies["eth3n"] thread scripts\sp\utility::_id_10346("phstreets_eth_thiswaysi");
  scripts\engine\utility::flag_set("eth3n_boost_jump");
  var_1 scripts\sp\anim::_id_1F35(level.allies["eth3n"], "ethan_boost_jump");
  thread _id_EAF7();
  level.allies["eth3n"] thread scripts\sp\utility::_id_7799(level.player);
  var_1 thread scripts\sp\anim::_id_1EEA(level.allies["eth3n"], "ethan_boost_idle", "end_loop");
  thread _id_674A(var_3.origin);
  var_3 _id_0E46::_id_48C4(undefined, undefined, undefined, undefined, 2048, 150);
  var_3 thread _id_6758();
  setsundirection(anglesToForward((-28, 16, 0)));
  var_4 = scripts\engine\utility::flag_wait_any_return("start_dust_area", "player_touching_eth3n_jump");
  setsaveddvar("r_dof_hq", 1);
  thread _id_6759();

  if(!scripts\engine\utility::flag("start_dust_area")) {
    scripts\engine\utility::flag_set("start_dust_area");
    var_3 scripts\engine\utility::delaythread(0.2, _id_0E46::_id_DFE3);
  }

  thread scripts\sp\utility::_id_12651(["geneva_periph_lake_tr", "geneva_periph_south_tr"]);
  var_5 = getEnt("dust_crashing_ship", "targetname");
  var_6 = var_5 scripts\sp\utility::_id_10808();
  var_6 playSound("scn_phstreets_shipdust_flyover_lr");
  var_6 scripts\engine\utility::delaycall(3.5, ::playsound, "scn_phstreets_shipdust_explo_1st_lr");
  var_6 thread _id_482A();
  thread _id_4829();
  var_1 scripts\engine\utility::delaythread(0.05, scripts\sp\anim::_id_1EC3, var_6, "ethan_boost_pull");
  _id_0B0F::_id_1103F("combat_3_ambient_battle", 1, 1);
  level.player disableweapons();
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player cancelmantle();

  if(var_4 == "start_dust_area") {
    level.player _meth_823C(level.player._id_1E9C, "tag_player", 0.5, 0.1, 0.1);
    wait 0.5;
    level.player playerlinktodelta(level.player._id_1E9C, "tag_player", 1.0, 0, 0, 0, 0, 1);
    level.player lerpviewangleclamp(1, 0.25, 0.5, 15, 15, 20, 10);
  } else
    level.player _meth_823C(level.player._id_1E9C, "tag_player", 0.2, 0.1, 0.1);

  var_1 notify("end_loop");
  level.player._id_1E9C show();
  thread _id_CCD8();
  level.allies["eth3n"] thread scripts\sp\utility::_id_77B9(1);
  thread _id_B032(var_1);
  var_1 thread scripts\sp\anim::_id_1F35(level.allies["eth3n"], "ethan_boost_pull");
  level.allies["admiral"] thread _id_188B();
  level.allies["salter"] thread _id_EA5B();
  var_1 thread scripts\sp\anim::_id_1F35(level.player._id_1E9C, "ethan_boost_pull");

  if(var_4 != "start_dust_area") {
    scripts\engine\utility::waitframe();
    var_7 = [level.allies["eth3n"], level.player._id_1E9C];
    scripts\sp\anim::_id_1F27(var_7, "ethan_boost_pull", 4);
    wait 0.1;
    scripts\sp\anim::_id_1F27(var_7, "ethan_boost_pull", 1);
  }

  var_6 thread _id_FD3A(var_1);
  level.player._id_1E9C waittillmatch("single anim", "end");
  level.player enableweapons();
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player unlink();
  level.player._id_1E9C hide();
  level.allies["eth3n"] scripts\sp\utility::_id_61C7();
  setsaveddvar("r_dof_hq", 0);
}

_id_674A(var_0) {
  while(!scripts\engine\utility::flag("start_dust_area")) {
    var_1 = level.player.origin + anglesToForward(level.player.angles) * -50;

    if(scripts\engine\utility::within_fov(var_1, level.player.angles, var_0, 0.5))
      scripts\engine\utility::trigger_on("player_touching_eth3n_jump_trig", "targetname");
    else
      scripts\engine\utility::trigger_off("player_touching_eth3n_jump_trig", "targetname");

    wait 0.05;
  }
}

_id_6759() {
  if(scripts\engine\utility::flag("start_dust_area")) {
    wait 1;
    level.player playRumbleOnEntity("damage_heavy");
  } else {
    wait 0.25;
    level.player playRumbleOnEntity("damage_heavy");
  }
}

_id_EAF7() {
  level endon("player_touching_eth3n_jump");
  level endon("start_dust_area");
  wait 5;
  level.allies["salter"] thread scripts\sp\utility::_id_10346("phstreets_slt_goreyes");
}

_id_188B() {
  var_0 = scripts\engine\utility::getStruct("admiral_dust_cover", "targetname");
  var_1 = scripts\engine\utility::getStruct("admiral_tp_point_dust", "targetname");
  var_2 = getnode("admiral_hide_node", "targetname");
  var_2 _meth_80AC();
  wait 4;
  self _meth_80F1(var_1.origin, var_1.angles);
  var_0 scripts\sp\anim::_id_1F17(self, "admiral_dust_react");
  createnavrepulsor("admiral", 0, self, 50, 1);
  var_0 thread scripts\sp\anim::_id_1F35(self, "admiral_dust_react");
  level waittill("blackfade");
  var_2 _meth_808B();
  self _meth_83A1();
  destroynavrepulsor("admiral");
  scripts\sp\utility::_id_61C7();
}

_id_EA5B() {
  var_0 = scripts\engine\utility::getStruct("salter_dust_cover", "targetname");
  var_1 = scripts\engine\utility::getStruct("salter_tp_point_dust", "targetname");
  var_2 = getnode("salter_hide_node", "targetname");
  var_2 _meth_80AC();
  wait 6.5;
  self _meth_80F1(var_1.origin, var_1.angles);
  var_0 scripts\sp\anim::_id_1F17(self, "salter_dust_react");
  createnavrepulsor("salter", 0, self, 50, 1);
  var_0 thread scripts\sp\anim::_id_1F35(self, "salter_dust_react");
  level waittill("blackfade");
  var_2 _meth_808B();
  wait 0.2;
  self _meth_83A1();
  destroynavrepulsor("salter");
  scripts\sp\utility::_id_61C7();
}

_id_6758() {
  level endon("start_dust_area");
  level endon("player_touching_eth3n_jump");
  self waittill("trigger");
  scripts\engine\utility::flag_set("start_dust_area");
}

_id_6757() {
  wait 2.3;
  scripts\engine\utility::exploder("eth3ndust2");
}

_id_CCD8() {
  wait 6.0;
  playworldsound("scn_phstreets_shipdust_building_debris_lr", (60442, 33401, -34313));
}

_id_B032(var_0) {
  var_1 = getspawnerarray("dust_runner_reinforcements");
  var_2 = [];

  for(var_3 = 0; var_3 < 4; var_3++) {
    var_4 = scripts\engine\utility::random(var_1);
    var_5 = var_4 scripts\sp\utility::_id_10619(1);
    var_4.count = var_4.count + 1;
    var_2[var_3] = var_5;
    var_5._id_1FBB = "civ_" + var_3;
    scripts\engine\utility::waitframe();
  }

  var_2[0] thread _id_B033(var_0, 2.5, "phstreets_fcv1_cmongetuprungo");
  var_2[1] thread _id_B033(var_0, 3.0, "phstreets_civ2_lenaviresebloque");
  var_2[2] thread _id_B033(var_0, 3.5, "phstreets_civ1_getoutofhere");
  var_2[3] thread _id_B033(var_0, 4.0, "phstreets_fcv1_itsgonnacrash");
  level waittill("blackfade");

  foreach(var_5 in var_2)
  var_5 delete();
}

_id_B033(var_0, var_1, var_2) {
  var_0 thread scripts\sp\anim::_id_1F35(self, "dust_lookers");
  wait(var_1);
  scripts\sp\utility::_id_10346(var_2);
}

_id_482A() {
  self._id_1FBB = "destroyer";
  wait 0.05;
  self hide();
  self notsolid();
  self._id_55A4 = 0;
  _id_0BB8::_id_39D0("off");
  _id_0BB8::_id_39CD("off");
  playFXOnTag(level._effect["vfx_ph_ship_damage_un_destroyer_911_01"], self, "tag_origin");
  playFXOnTag(level._effect["un_thruster_down_med_damaged"], self, "fx_thruster_v_l_1");
  playFXOnTag(level._effect["un_thruster_down_lrg_damaged"], self, "fx_thruster_v_l_2");
  scripts\engine\utility::waitframe();
  playFXOnTag(level._effect["vfx_ph_capship_un_thruster_med"], self, "fx_thruster_v_m_4");
  scripts\engine\utility::waitframe();
  playFXOnTag(level._effect["vfx_ph_capship_un_thruster_med"], self, "fx_thruster_v_m_1");
  wait 0.5;
  playFXOnTag(level._effect["un_thruster_down_sml_damaged_1"], self, "fx_small_hurt_01");
  playFXOnTag(level._effect["un_thruster_down_sml_damaged_1"], self, "fx_small_hurt_02");
  playFXOnTag(level._effect["un_thruster_down_sml_damaged_1"], self, "fx_small_hurt_03");
  scripts\engine\utility::waitframe();
  playFXOnTag(level._effect["un_thruster_down_sml_damaged_2"], self, "fx_big_hurt_01");
  playFXOnTag(level._effect["un_thruster_down_sml_damaged_2"], self, "fx_big_hurt_02");
  wait 4;
  playFXOnTag(level._effect["vfx_ph_capship_un_engineexplosion"], self, "fx_thruster_v_l_2");
}

_id_4829() {
  wait 3.3;
  earthquake(0.1, 2.1, level.player.origin, 9999);
  wait 0.3;
  level.player _meth_8244("steady_rumble");
  wait 1;
  earthquake(0.25, 5.5, level.player.origin, 9999);
  wait 2.3;
  level.player stoprumble("steady_rumble");
}

_id_FD3A(var_0) {
  scripts\engine\utility::waitframe();
  self show();
  var_0 scripts\sp\anim::_id_1F35(self, "ethan_boost_pull");
  self delete();
}

_id_5F59() {
  wait 3;
  level.player scripts\sp\utility::_id_10350("phstreets_plr_thatsthenova");
  wait 5.0;
  thread _id_EA90();
  scripts\engine\utility::flag_wait("dust_cloud_triggered");
  wait 2.0;
  scripts\engine\utility::flag_wait("dust_cloud_hit");
  wait 4;
  level.allies["salter"] thread _id_5F5A();
  level.allies["salter"] thread scripts\sp\utility::_id_10346("phstreets_slt_cougheffort1");
  wait 1;
  level.allies["admiral"] thread _id_5F5A();
  level.allies["admiral"] thread scripts\sp\utility::_id_10346("phstreets_adm_coughingeffort1");
  wait 0.25;
  level.player thread scripts\sp\utility::_id_10350("phstreets_plr_coughingsaltwhe");
  wait 3.25;
  level.allies["salter"] thread _id_5F5A();
  level.allies["salter"] thread scripts\sp\utility::_id_10346("phstreets_slt_coughingnoideay");
  wait 1.5;
  level.allies["salter"] thread _id_5F5A();
  level.allies["salter"] thread scripts\sp\utility::_id_10346("phstreets_slt_cougheffort2");
  level.allies["salter"] scripts\engine\utility::delaythread(1.3, ::_id_5F5A);
  level.allies["salter"] scripts\engine\utility::delaythread(2.6, ::_id_5F5A);
  level.allies["salter"] scripts\engine\utility::delaythread(3.9, ::_id_5F5A);
  level.allies["salter"] scripts\engine\utility::delaythread(5.2, ::_id_5F5A);
  level.player thread scripts\sp\utility::_id_10350("phstreets_plr_coughing");
  level.allies["admiral"] thread _id_5F5A();
  level.allies["admiral"] scripts\sp\utility::_id_10346("phstreets_adm_coughingethan");
  level.allies["eth3n"] thread _id_2461();
  level.allies["admiral"] thread _id_5F5A();
  level.allies["admiral"] scripts\sp\utility::_id_10346("phstreets_adm_coughingtakepoi");
  level.allies["eth3n"] thread scripts\sp\utility::_id_10346("phstreets_eth_ayesir");
  level notify("dust_ethan_go");
  level.allies["admiral"] thread _id_5F5A();
  level.allies["admiral"] thread scripts\sp\utility::_id_10346("phstreets_adm_coughingeffort2");
  level.allies["admiral"] scripts\engine\utility::delaythread(1.3, ::_id_5F5A);
  level.allies["admiral"] scripts\engine\utility::delaythread(2.6, ::_id_5F5A);
  scripts\engine\utility::flag_wait("dust_ethan_move_1");
  wait 2;
  level.allies["eth3n"] scripts\sp\utility::_id_10346("phstreets_eth_civiliansupahea");
  level.allies["admiral"] scripts\sp\utility::_id_10346("phstreets_adm_holdyour");
  scripts\engine\utility::flag_wait("dust_ethan_move_2");
  wait 6;

  if(!scripts\engine\utility::flag("cap_crash_dust_complete"))
    level.allies["eth3n"] scripts\sp\utility::_id_10346("phstreets_eth_leftupthestairs");
}

_id_EA90() {
  wait 4.4;
  level.allies["salter"] scripts\sp\utility::_id_10346("phstreets_slt_holyshit");
  level.allies["admiral"] scripts\sp\utility::_id_10346("phstreets_adm_takecover");
}

_id_5F5A() {
  if(1) {
    return;
  }
  if(isDefined(self._id_46A5)) {
    return;
  }
  self._id_46A5 = 1;
  thread scripts\sp\utility::_id_7790(scripts\sp\utility::_id_7DC1("dust_cough"));
  scripts\sp\anim::_id_1EBD(self, "dust_cough_face", level._id_EC88[self._id_1FBB]["dust_cough_face"]);
  wait(getanimlength(level._id_EC88[self._id_1FBB]["dust_cough_face"]));
  self._id_46A5 = undefined;
}

_id_5F3A() {
  wait 0.25;
  level._id_5F56 = [];
  level._id_5F3C = _id_106BB("01", "01");
  scripts\engine\utility::waitframe();
  level._id_5F3D = _id_106BB("02", "02");
  scripts\engine\utility::waitframe();
  level._id_5F3E = _id_106BB("03", "03");
  scripts\engine\utility::waitframe();
  level._id_5F3F = _id_106BB("04", "04");
  scripts\engine\utility::waitframe();
  level._id_5F40 = _id_106BB("05", "05");
  scripts\engine\utility::waitframe();
  level._id_5F41 = _id_106BB("06", "06");
  scripts\engine\utility::waitframe();
  level._id_5F42 = _id_106BB("07", "07");
  scripts\engine\utility::waitframe();
  level._id_5F43 = _id_106BB("08", "08");
  scripts\engine\utility::waitframe();
  level._id_5F44 = _id_106BB("09", "09");
  scripts\engine\utility::waitframe();
  level._id_5F45 = _id_106BB("10", "10");
  scripts\engine\utility::waitframe();
  level._id_5F46 = _id_106BB("01", "11");
  scripts\engine\utility::waitframe();
  level._id_5F47 = _id_106BB("02", "12");
  scripts\engine\utility::waitframe();
  level._id_5F48 = _id_106BB("03", "13");
  scripts\engine\utility::waitframe();
  level._id_5F49 = _id_106BB("04", "14");
  scripts\engine\utility::waitframe();
  level._id_5F4A = _id_106BB("05", "15");
  scripts\engine\utility::waitframe();
  level._id_5F4B = _id_106BB("06", "16");
  scripts\engine\utility::waitframe();
  level._id_5F4C = _id_106BB("07", "17");
  scripts\engine\utility::waitframe();
  level._id_5F4D = _id_106BB("08", "18");
  scripts\engine\utility::waitframe();
  level._id_5F4E = _id_106BB("09", "19");
  scripts\engine\utility::waitframe();
  level._id_5F4F = _id_106BB("10", "20");
  scripts\engine\utility::waitframe();

  foreach(var_1 in level._id_5F56) {
    var_1 notify("start_dust_anim");
    wait 0.2;
  }

  thread _id_5F50();
}

_id_5F50() {
  level endon("blackfade");

  for(;;) {
    if(level._id_5F56.size >= 27) {
      level._id_5F56 = scripts\sp\utility::array_removedeadvehicles(level._id_5F56);
      scripts\engine\utility::waitframe();
      continue;
    }

    _id_5F51();
    wait(randomfloatrange(0.2, 0.5));
  }
}

_id_5F51() {
  var_0 = getspawnerarray("dust_runner_reinforcements");
  var_1 = scripts\engine\utility::random(var_0);
  var_1.count = var_1.count + 1;
  var_2 = var_1 scripts\sp\utility::_id_10619();

  if(isDefined(var_2)) {
    var_2 _meth_855F(64);
    var_2._id_C03F = _id_5F5C();
    var_2 thread _id_5F5E();
    var_2 thread _id_514C();
    level._id_5F56 = scripts\engine\utility::array_add(level._id_5F56, var_2);
  }
}

_id_5F5E() {
  self endon("death");
  var_0 = scripts\engine\utility::getStruct("dust_runner_civs_" + self._id_C03F, "targetname");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_19C5(var_0);

  for(var_1 = scripts\sp\utility::_id_7951(level.player.origin, level.player.angles, self.origin); var_1 >= 0.4; var_1 = scripts\sp\utility::_id_7951(level.player.origin, level.player.angles, self.origin))
    scripts\engine\utility::waitframe();

  self delete();
}

_id_5F5C() {
  var_0 = ["13", "12", "09", "11", "16", "15", "20", "08"];
  var_1 = scripts\engine\utility::array_randomize(var_0);
  return var_1[0];
}

_id_3FCD() {
  level._id_5F3C thread scripts\sp\utility::_id_10346("phstreets_fc1_getoutoftheway");
  wait(randomfloatrange(0.3, 0.5));
  level._id_5F3D thread scripts\sp\utility::_id_10346("phstreets_cv2_questcequecest");
  wait(randomfloatrange(0.3, 0.5));
  level._id_5F3E thread scripts\sp\utility::_id_10346("phstreets_fc2_rungetoutofhere");
  wait(randomfloatrange(0.3, 0.5));
  level._id_5F3F thread scripts\sp\utility::_id_10346("phstreets_cv1_couriraller");
  wait(randomfloatrange(0.3, 0.5));
  level._id_5F40 thread scripts\sp\utility::_id_10346("phstreets_cv3_degagez");
  wait(randomfloatrange(0.3, 0.5));
  level._id_5F41 thread scripts\sp\utility::_id_10346("phstreets_fc1_allezvite");
  wait(randomfloatrange(0.3, 0.5));
  level._id_5F42 thread scripts\sp\utility::_id_10346("phstreets_fc1_getoutoftheway");
  wait(randomfloatrange(0.3, 0.5));
  level._id_5F43 thread scripts\sp\utility::_id_10346("phstreets_cv2_questcequecest");
  wait(randomfloatrange(0.3, 0.5));
  level._id_5F44 thread scripts\sp\utility::_id_10346("phstreets_fc2_rungetoutofhere");
  wait(randomfloatrange(0.3, 0.5));
  level._id_5F45 thread scripts\sp\utility::_id_10346("phstreets_cv1_couriraller");
  wait(randomfloatrange(0.3, 0.5));
  level._id_5F46 thread scripts\sp\utility::_id_10346("phstreets_cv3_degagez");
  wait(randomfloatrange(0.3, 0.5));
  level._id_5F47 thread scripts\sp\utility::_id_10346("phstreets_fc1_allezvite");
  wait(randomfloatrange(0.3, 0.5));
  level._id_5F48 thread scripts\sp\utility::_id_10346("phstreets_fc1_getoutoftheway");
  wait(randomfloatrange(0.3, 0.5));
  level._id_5F49 thread scripts\sp\utility::_id_10346("phstreets_cv2_questcequecest");
  wait(randomfloatrange(0.3, 0.5));
  level._id_5F4A thread scripts\sp\utility::_id_10346("phstreets_fc2_rungetoutofhere");
  wait(randomfloatrange(0.3, 0.5));
  level._id_5F4B thread scripts\sp\utility::_id_10346("phstreets_cv1_couriraller");
  wait(randomfloatrange(0.3, 0.5));
  level._id_5F4C thread scripts\sp\utility::_id_10346("phstreets_cv3_degagez");
  wait(randomfloatrange(0.3, 0.5));
  level._id_5F4D thread scripts\sp\utility::_id_10346("phstreets_fc1_allezvite");
  wait(randomfloatrange(0.3, 0.5));
  level._id_5F4E thread scripts\sp\utility::_id_10346("phstreets_fc1_getoutoftheway");
  wait(randomfloatrange(0.3, 0.5));
  level._id_5F4F thread scripts\sp\utility::_id_10346("phstreets_cv2_questcequecest");
}

_id_106BB(var_0, var_1) {
  var_2 = getspawnerarray("dust_runner");
  var_3 = scripts\engine\utility::random(var_2);
  var_3.count = var_3.count + 1;
  var_4 = var_3 scripts\sp\utility::_id_10619();
  var_4 scripts\sp\utility::_id_F3C0(1);

  if(isDefined(var_4)) {
    var_4 _meth_855F(64);
    var_4._id_1F56 = var_0;
    var_4._id_C03F = var_1;
    var_4 thread _id_5F39();
    var_4 thread _id_514C();
    level._id_5F56 = scripts\engine\utility::array_add(level._id_5F56, var_4);
    return var_4;
  }
}

_id_514C() {
  self endon("death");
  level waittill("blackfade");
  wait 0.5;
  self delete();
}

_id_5F39() {
  self endon("death");
  var_0 = scripts\engine\utility::getStruct("dust_runner_civs_" + self._id_C03F, "targetname");
  self.fixednode = 1;
  self _meth_83B9(var_0.origin, var_0.angles);
  self setgoalpos(var_0.origin);
  self waittill("start_dust_anim");
  self.fixednode = 0;
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_19C5(var_0);

  for(var_1 = scripts\sp\utility::_id_7951(level.player.origin, level.player.angles, self.origin); var_1 >= 0.2; var_1 = scripts\sp\utility::_id_7951(level.player.origin, level.player.angles, self.origin))
    scripts\engine\utility::waitframe();

  self delete();
}

dvarintvalue() {
  var_0 = getspawnerarray("dust_running_civs");

  foreach(var_2 in var_0)
  var_2 scripts\sp\utility::_id_1747(::_id_5F5F);

  foreach(var_2 in var_0) {
    var_2 scripts\sp\utility::_id_10619();
    wait(randomintrange(1, 3));
  }

  wait 6;

  foreach(var_2 in var_0) {
    var_2 scripts\sp\utility::_id_10619();
    wait(randomintrange(1, 3));
  }
}

_id_5F5F() {
  var_0 = scripts\engine\utility::get_target_ent();
  scripts\sp\utility::_id_7227(var_0, 0);
}

_id_5F65() {
  wait 2;
  scripts\engine\utility::exploder("dustmoment_thrust_dust");
  wait 9;
  scripts\engine\utility::exploder("nova_crash_explosion");
  level.player playRumbleOnEntity("damage_heavy");
  earthquake(0.35, 2.5, level.player.origin, 9999);
  playworldsound("scn_phstreets_shipdust_explo_boom_lr", (69810, 31451, -33161));
  playworldsound("scn_phstreets_shipdust_building_windows_lr", (69810, 31451, -33161));
  level.player _meth_8244("steady_rumble");
  wait 0.2;
  visionsetnaked("phstreets_911_explosion", 0.1);
  level.player playRumbleOnEntity("damage_heavy");
  wait 0.3;
  visionsetnaked("", 0.4);
  level.player stoprumble("steady_rumble");
}

_id_3FC0() {
  wait 0.9;
  playworldsound("scn_phstreets_dust_civi_screams", (62327, 33601, -34038));
  wait 0.25;
  playworldsound("scn_phstreets_dust_civi_screams", (62327, 33601, -34038));
  wait 2.0;
  playworldsound("scn_phstreets_dust_civi_screams", (62327, 33601, -34038));
  wait 1.7;
  playworldsound("scn_phstreets_dust_civi_screams", (62327, 33601, -34038));
  scripts\engine\utility::flag_wait("dust_cloud_triggered");
  wait 0.25;
  playworldsound("scn_phstreets_dust_civi_screams", (62327, 33601, -34038));
  wait 0.25;
  playworldsound("scn_phstreets_dust_civi_screams", (62327, 33601, -34038));
  wait 0.25;
  playworldsound("scn_phstreets_dust_civi_screams", (62327, 33601, -34038));
  wait 0.25;
  playworldsound("scn_phstreets_dust_civi_screams", (62327, 33601, -34038));
  wait 0.25;
  playworldsound("scn_phstreets_dust_civi_screams", (62327, 33601, -34038));
  wait 0.25;
  playworldsound("scn_phstreets_dust_civi_screams", (62327, 33601, -34038));
  wait 0.25;
  playworldsound("scn_phstreets_dust_civi_screams", (62327, 33601, -34038));
  wait 0.25;
  playworldsound("scn_phstreets_dust_civi_screams", (62327, 33601, -34038));
  scripts\engine\utility::flag_wait("dust_cloud_hit");
}

_id_42BA() {
  scripts\engine\utility::exploder("dustcloudsim");
  scripts\engine\utility::exploder("dustmoment_windybits");
  var_0 = getEnt("smoke", "targetname");
  var_1 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_1.target = var_0.target;
  var_2 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_2.target = var_0.target;
  var_2 playSound("scn_phstreets_shipdust_dust_whoosh_in_lr");
  var_1 thread _id_10371();
  var_1 thread _id_CB08();
  var_2 thread _id_5F64();
  var_3 = var_0.target;

  for(;;) {
    var_4 = scripts\engine\utility::getStruct(var_3, "targetname");
    var_5 = var_4.speed * 12;
    var_6 = distance(var_0.origin, var_4.origin);
    var_7 = var_6 / var_5;
    var_0 moveTo(var_4.origin, var_7);
    wait(var_7);

    if(!isDefined(var_4.target)) {
      break;
    }

    var_3 = var_4.target;
  }

  level.player notify("cloud_done");
  var_1 delete();
  var_2 delete();
}

_id_CB08() {
  var_0 = self.target;

  for(;;) {
    var_1 = scripts\engine\utility::getStruct(var_0, "targetname");
    var_2 = var_1.speed * 24;
    var_3 = distance(self.origin, var_1.origin);
    var_4 = var_3 / var_2;
    self moveTo(var_1.origin, var_4);
    wait(var_4);

    if(!isDefined(var_1.target)) {
      return;
    }
    var_0 = var_1.target;
  }
}

_id_5F64() {
  var_0 = self.target;

  for(;;) {
    var_1 = scripts\engine\utility::getStruct(var_0, "targetname");
    var_2 = var_1.speed * 18;
    var_3 = distance(self.origin, var_1.origin);
    var_4 = var_3 / var_2;
    self moveTo(var_1.origin, var_4);
    wait(var_4);

    if(!isDefined(var_1.target)) {
      return;
    }
    var_0 = var_1.target;
  }
}

_id_10371() {
  var_0 = physics_volumecreate(self.origin, 750);
  var_0 physics_volumesetasdirectionalforce(1, (-180, 0, -0.5), 5);
  var_0 physics_volumesetactivator(1);
  var_0 physics_volumeenable(1);
  var_0 linkTo(self);
  level.player waittill("cloud_done");
  var_0 physics_volumesetactivator(0);
  var_0 physics_volumeenable(0);
  var_0 delete();
}

_id_5F67() {
  var_0 = scripts\engine\utility::getStruct("dust_umbrella_node", "targetname");
  var_1 = scripts\sp\utility::_id_10639("umbrella", var_0.origin, var_0.angles);
  var_0 scripts\sp\anim::_id_1EC3(var_1, "dust_umbrella");
  scripts\engine\utility::flag_set("dust_cloud_triggered");
  wait 15.0;
  var_0 scripts\sp\anim::_id_1F35(var_1, "dust_umbrella");
  scripts\engine\utility::flag_wait("start_reveal_pod");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA01(var_1);
}

_id_13747() {
  var_0 = getEnt("smoke", "targetname");

  for(var_1 = 9999; var_1 > 4000; var_1 = distance(var_0.origin, level.player.origin))
    wait 0.05;

  level.player _meth_8244("steady_rumble");
  earthquake(0.35, 2.5, level.player.origin, 9999);
}

_id_42B5() {
  level.player scripts\sp\utility::_id_D090("ges_ph_block");
  wait 10;
  level.player scripts\engine\utility::delaycall(0.1, ::playsound, "scn_phstreets_shipdust_plr_wave_foley");
  setsaveddvar("cg_drawPlayerShadow", 1);
  level.player thread scripts\sp\utility::_id_D090("prisoner_vm_gesture_cough");
  scripts\engine\utility::exploder("dustmoment_hanging_dust");
}

_id_5F68() {
  level endon("c6_reveal");
  level.player playSound("scn_phstreets_shipdust_dust_hit_lr");
  visionsetnaked("phstreets_911_dust_dark", 1);
  wait 1;
  thread _id_2B27();
  wait 0.5;
  thread _id_8E8B();
  wait 4.5;
  visionsetnaked("phstreets_911_dust", 6);
  wait 11;
  visionsetnaked("phstreets_911_post", 6);
}

_id_8E8B() {
  wait 1.9;
  setomnvar("ui_hide_hud", 1);
  level.player freezecontrols(1);
  wait 0.05;
  setomnvar("ui_hide_hud", 0);
  wait 0.05;
  setomnvar("ui_hide_hud", 1);
  wait 0.05;
  setomnvar("ui_hide_hud", 0);
  wait 0.05;
  setomnvar("ui_hide_hud", 1);
  wait 0.05;
  setomnvar("ui_hide_hud", 0);
  wait 0.05;
  setomnvar("ui_hide_hud", 1);
  wait 3.0;
  level.player freezecontrols(0);
  wait 2;
  setomnvar("ui_hide_hud", 0);
  wait 0.05;
  setomnvar("ui_hide_hud", 1);
  wait 0.05;
  setomnvar("ui_hide_hud", 0);
  wait 0.05;
  setomnvar("ui_hide_hud", 1);
  wait 0.8;
  setomnvar("ui_hide_hud", 0);
  wait 0.05;
  setomnvar("ui_hide_hud", 1);
  wait 0.05;
  setomnvar("ui_hide_hud", 0);
  wait 0.05;
  setomnvar("ui_hide_hud", 1);
  wait 0.05;
  setomnvar("ui_hide_hud", 0);
}

_id_2B27() {
  earthquake(0.5, 1, level.player.origin, 9999);
  level.player _meth_8244("damage_heavy");
  var_0 = scripts\sp\hud_util::_id_48B7("black", 0, level.player);
  var_0 fadeovertime(0.3);
  var_0.alpha = 1;
  wait 0.3;
  var_0 fadeovertime(0.2);
  var_0.alpha = 0.6;
  wait 0.2;
  var_0 fadeovertime(0.3);
  var_0.alpha = 1;
  wait 0.3;
  var_0 fadeovertime(0.2);
  var_0.alpha = 0.3;
  wait 0.2;
  var_0 fadeovertime(0.2);
  var_0.alpha = 1;
  wait 0.2;
  var_0 fadeovertime(0.2);
  var_0.alpha = 0.6;
  wait 0.2;
  var_0 fadeovertime(0.3);
  var_0.alpha = 1;
  level notify("blackfade");
  wait 0.3;
  level.player stoprumble("steady_rumble");
  level.player stoprumble("damage_heavy");
  level.player _meth_8244("damage_light");
  wait 0.5;
  level.player stoprumble("damage_light");
  wait 3.0;
  var_0 fadeovertime(0.2);
  var_0.alpha = 0.8;
  wait 0.2;
  var_0 fadeovertime(0.1);
  var_0.alpha = 1;
  wait 1.2;
  var_0 fadeovertime(0.2);
  var_0.alpha = 0.8;
  wait 0.2;
  var_0 fadeovertime(0.1);
  var_0.alpha = 1;
  wait 1.3;
  var_0 fadeovertime(0.8);
  var_0.alpha = 0.7;
  wait 0.9;
  var_0 fadeovertime(0.7);
  var_0.alpha = 0.8;
  wait 0.9;
  var_0 fadeovertime(0.8);
  var_0.alpha = 0.5;
  wait 0.9;
  var_0 fadeovertime(0.6);
  var_0.alpha = 0.6;
  wait 0.6;
  var_0 fadeovertime(8);
  var_0.alpha = 0;
}

_id_D6CA() {
  var_0 = getspawner("dust_animated_civilian_male", "targetname");
  var_1 = getspawner("dust_animated_civilian_female", "targetname");
  var_2 = scripts\engine\utility::getStruct("dust_anim_stun_walk_1", "targetname");
  var_3 = scripts\engine\utility::getStruct("dust_anim_stun_walk_2", "targetname");
  var_4 = scripts\engine\utility::getStruct("dust_anim_stun_walk_3", "targetname");
  var_5 = scripts\engine\utility::getStruct("dust_anim_stun_walk_4", "targetname");
  var_6 = scripts\engine\utility::getStruct("dust_anim_stun_walk_5", "targetname");
  var_7 = scripts\engine\utility::getStruct("dust_anim_stun_walk_6", "targetname");
  var_8 = scripts\engine\utility::getStruct("dust_anim_stun_stand", "targetname");
  var_9 = scripts\engine\utility::getStruct("dust_anim_stun_kneel", "targetname");
  level waittill("blackfade");
  wait 5;
  scripts\sp\utility::_id_15F5("turn_on_dust_civs");
  var_0 thread _id_5F55("stun_walk_1", var_2, "phstreets_fcv1_suisjeenviesuisje");
  scripts\engine\utility::waitframe();
  var_0 thread _id_5F53();
  wait 0.1;
  var_0 thread _id_5F54("stun_car_kneel", var_9, "phstreets_civ2_woundedcoughing");
  scripts\engine\utility::waitframe();
  scripts\engine\utility::waitframe();
  var_1 thread _id_5F54("stun_car_stand", var_8, "phstreets_fcv1_cryingwhimpering");
  scripts\engine\utility::waitframe();
  scripts\engine\utility::waitframe();
  var_1 thread _id_5F55("stun_walk_4", var_7, "phstreets_civ3_avezvousvumonfil");
  scripts\engine\utility::waitframe();
  var_1 thread _id_5F55("stun_walk_3", var_6, "phstreets_fcv1_woundedcoughing");
  scripts\engine\utility::waitframe();
  var_1 thread _id_5F55("stun_walk_2", var_4, "phstreets_fcv1_suisjeenviesuisje");
  scripts\engine\utility::waitframe();
  thread _id_676E(var_0, var_1);
  scripts\engine\utility::flag_wait("c6_reveal");
  _id_0B0F::_id_19FE("turn_on_dust_civs");
}

_id_676E(var_0, var_1) {
  var_2 = getEnt("dust_ethan_finished_trigger", "targetname");
  var_3 = scripts\engine\utility::getStruct("dust_civi_run_node", "targetname");
  var_4 = level.allies["eth3n"];
  var_5 = var_0 scripts\sp\utility::_id_10619(1);
  var_6 = var_1 scripts\sp\utility::_id_10619(1);
  var_5 thread _id_678B("ethan_dust_walk_1", "ethan_civ_dust_idle", var_3);
  var_6 thread _id_678B("ethan_dust_walk_2", "stun_walk_3_loop", var_3);
  var_4 scripts\sp\utility::_id_54F7();
  var_3 thread scripts\sp\anim::_id_1EEA(var_4, "ethan_dust_idle_1", "stop_ethan_idle");
  level waittill("dust_ethan_go");
  scripts\engine\utility::flag_wait("dust_ethan_move_1");
  var_5 notify("actor_go");
  var_3 notify("stop_ethan_idle");
  var_3 scripts\sp\anim::_id_1F35(var_4, "ethan_dust_walk_1");

  if(!scripts\engine\utility::flag("dust_ethan_move_1")) {
    var_3 thread scripts\sp\anim::_id_1EEA(var_4, "ethan_dust_idle_1", "stop_ethan_idle");
    scripts\engine\utility::flag_wait("dust_ethan_move_2");
    var_3 notify("stop_ethan_idle");
  }

  var_6 notify("actor_go");
  var_3 scripts\sp\anim::_id_1F35(var_4, "ethan_dust_walk_2");

  if(!scripts\engine\utility::flag("robot_alley_paths_started"))
    var_4 scripts\sp\utility::_id_61C7();

  if(isDefined(var_2))
    var_2 scripts\sp\utility::_id_15F1();

  var_7 = getEntArray("after_dust_triggers", "targetname");

  foreach(var_9 in var_7) {
    if(isDefined(var_9))
      var_9 scripts\engine\utility::trigger_off();
  }
}

_id_678B(var_0, var_1, var_2) {
  self endon("death");
  self._id_1FBB = "civ";

  if(var_1 == "stun_walk_3_loop")
    var_2 thread scripts\sp\anim::_id_1EEA(self, "ethan_civ_pre_dust_idle_2", "stop_loop_2");
  else
    var_2 thread scripts\sp\anim::_id_1EEA(self, "ethan_civ_pre_dust_idle_1", "stop_loop_1");

  self waittill("actor_go");

  if(var_1 == "stun_walk_3_loop")
    var_2 notify("stop_loop_2");
  else
    var_2 notify("stop_loop_1");

  var_2 scripts\sp\anim::_id_1F35(self, var_0);

  if(var_1 == "stun_walk_3_loop")
    thread scripts\sp\anim::_id_1EEA(self, var_1);
  else
    var_2 thread scripts\sp\anim::_id_1EEA(self, var_1);

  scripts\sp\utility::_id_F2A8(1);
  self setCanDamage(1);
  self.forceragdollimmediate = 1;
  scripts\engine\utility::flag_wait("c6_reveal");

  if(isDefined(self))
    self delete();
}

_id_D6C9(var_0) {
  self endon("death");
  var_1 = spawn("trigger_radius", self.origin - (0, 0, 64), 0, 180, 256);
  var_1 waittill("trigger");
  scripts\sp\utility::_id_10346(var_0);
}

_id_5F53() {
  var_0 = [];
  var_1 = scripts\engine\utility::getStruct("dust_anim_car_walk_civi", "targetname");

  for(var_2 = 1; var_2 < 3; var_2++) {
    var_3 = scripts\sp\utility::_id_10619(1);
    self.count = self.count + 1;
    var_3._id_1FBB = "civ" + var_2;
    var_0 = scripts\engine\utility::array_add(var_0, var_3);
    scripts\engine\utility::waitframe();
  }

  var_1 scripts\sp\anim::_id_1F2C(var_0, "dust_help_walk");

  if(isDefined(var_0[0]))
    var_1 thread scripts\sp\anim::_id_1EE7(var_0, "dust_help_walk_loop");

  scripts\engine\utility::flag_wait("c6_reveal");

  foreach(var_3 in var_0) {
    if(isDefined(var_3))
      var_3 delete();
  }
}

_id_5F55(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = spawn("trigger_radius", var_1.origin - (0, 0, 64), 0, 1200, 256);
  var_5 = scripts\sp\utility::_id_10619(1);
  var_5 endon("death");
  self.count = self.count + 1;
  var_3 = scripts\engine\utility::array_add(var_3, var_5);
  var_5._id_1FBB = "civ";
  var_1 scripts\sp\anim::_id_1EC1(var_3, var_0);
  var_4 waittill("trigger");

  if(isDefined(var_2))
    var_5 thread scripts\sp\utility::_id_10346(var_2);

  var_1 scripts\sp\anim::_id_1F30(var_3, var_0);

  if(var_0 == "stun_walk_1" || var_0 == "stun_walk_6")
    var_3[0] thread scripts\sp\anim::_id_1EE7(var_3, "stun_walk_1_loop");
  else
    var_3[0] thread scripts\sp\anim::_id_1EE7(var_3, "stun_walk_2_loop");

  scripts\engine\utility::flag_wait("c6_reveal");
  var_5 delete();
}

_id_5F54(var_0, var_1, var_2) {
  var_3 = scripts\sp\utility::_id_10619(1);
  var_3 endon("death");
  self.count = self.count + 1;
  var_3._id_1FBB = "civ";
  var_1 thread scripts\sp\anim::_id_1EEA(var_3, var_0);
  wait 1;
  var_3 thread _id_D6C9(var_2);
  scripts\engine\utility::flag_wait("c6_reveal");
  var_3 delete();
}

_id_5F5B() {
  var_0 = getEntArray("dust_moment_swap_before", "targetname");
  var_1 = getEntArray("dust_moment_swap_after", "targetname");
  wait 4.5;

  foreach(var_3 in var_0)
  var_3 scripts\sp\utility::_id_8E7E();

  foreach(var_3 in var_1)
  var_3 scripts\sp\utility::_id_100D7();
}

_id_42C1() {
  wait 6;
  level.allies["eth3n"] thread _id_2461();
}

_id_A4C6() {
  wait 1.0;
  var_0 = getnodearray("cloud_hide_nodes", "targetname");
  var_1 = scripts\sp\utility::_id_22C1(var_0, ::_id_10420);
  level.allies["salter"] scripts\sp\utility::_id_51E1("frantic");
  level.allies["admiral"] scripts\sp\utility::_id_51E1("frantic");
  level.allies["eth3n"] scripts\sp\utility::_id_51E1("sprint");
  level.allies["salter"].goalradius = 64;
  level.allies["salter"] _meth_82EE(var_1[1]);
  level.allies["admiral"].goalradius = 64;
  level.allies["admiral"] _meth_82EE(var_1[2]);
}

_id_10420() {
  return distancesquared(self.origin, level.player.origin);
}

_id_2461() {
  self endon("kill_flashlight");
  self endon("death");
  setsaveddvar("r_spotLightEntityShadows", 1);
  self._id_AC92 = spawn("script_model", (0, 0, 0));
  self._id_AC92 setModel("tag_origin");
  self._id_AC92 linkTo(self, "tag_eye", (0, 0, 0), anglesToForward(self.angles) + (0, 0, 0));
  playFXOnTag(level._effect["ethan_headlight"], self._id_AC92, "tag_origin");
  playFXOnTag(level._effect["vfx_ph_flashlight_lensflare"], self._id_AC92, "tag_origin");
}

_id_A5DB() {
  self endon("death");
  self notify("kill_flashlight");
  thread scripts\sp\utility::_id_77B9(0.7);
  killfxontag(level._effect["ethan_headlight"], self._id_AC92, "tag_origin");
  stopFXOnTag(level._effect["vfx_ph_flashlight_lensflare"], self._id_AC92, "tag_origin");
  setsaveddvar("r_spotLightEntityShadows", 0);
}

_id_394C() {
  scripts\engine\utility::flag_set("start_dust_area");
  thread _id_394D();
}

_id_394D() {
  scripts\engine\utility::flag_set("dust_cloud_hit");
  scripts\engine\utility::flag_wait("player_got_hackdevice");
  var_0 = getEntArray("dust_moment_swap_before", "targetname");
  var_1 = getEntArray("dust_moment_swap_after", "targetname");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA02(var_0);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA02(var_1);
}

_id_337D() {
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC53("start_c6_intro");
  thread scripts\sp\maps\phstreets\phstreets::_id_F51C("med_battle", 1);
  var_0 = ["admiral", "salter", "eth3n"];
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC05("start_c6_intro", var_0);
  scripts\engine\utility::noself_delaycall(0.05, ::visionsetnaked, "phstreets_911_post");
  scripts\sp\utility::_id_228A(getEntArray("after_dust_triggers", "targetname"));
  scripts\engine\utility::array_thread(level.allies, scripts\sp\utility::_id_51E1, "cqb");
  setsundirection(anglesToForward((-28, 16, 0)));
  scripts\sp\utility::_id_15F5("c6_reveal_aiambient");
  thread _id_E574();
}

_id_337B() {
  thread _id_E577();
  thread _id_337A();
  scripts\engine\utility::flag_wait("start_reveal_pod");
  scripts\sp\utility::_id_CF8B();
  scripts\sp\utility::_id_28D7("allies");
  scripts\sp\utility::_id_28D7("axis");

  foreach(var_1 in level.allies)
  var_1.ignoreall = 1;

  _id_3397();

  foreach(var_1 in level.allies) {
    var_1.ignoreall = 0;
    var_1 scripts\sp\utility::_id_F417(1);
  }

  thread _id_E47F();
  thread _id_D6BB();
  level._id_33A4 = scripts\sp\utility::_id_22B9(level._id_33A4);
  scripts\sp\utility::_id_178D(scripts\sp\utility::_id_13754, level._id_33A4);
  scripts\sp\utility::_id_178D(scripts\engine\utility::flag_wait, "c6_reveal_done");
  scripts\sp\utility::_id_57D6();

  foreach(var_1 in level.allies)
  var_1 scripts\sp\utility::_id_F417(0);

  foreach(var_8 in level._id_33A4) {
    if(isDefined(var_8) && isalive(var_8))
      var_8 scripts\engine\utility::delaythread(randomfloatrange(0, 1.5), scripts\sp\utility::_id_54C6);
  }

  if(!scripts\engine\utility::flag("c6_reveal_done"))
    scripts\sp\utility::_id_15F5("post_c6_reveal_colortrig");

  scripts\engine\utility::flag_wait("c6_reveal_done");
}

_id_E47F() {
  getEnt("post_c6_reveal_colortrig", "targetname") endon("trigger");
  level endon("c6_reveal_done");
  level._id_339F waittill("death");
  scripts\sp\utility::_id_15F5("reveal_done_colortrig");
}

_id_D6BB() {
  scripts\sp\utility::_id_127B3("post_c6_reveal_vo");
  level.allies["eth3n"] thread scripts\sp\utility::_id_10346("phstreets_eth_commsarestilldo");
}

_id_E577() {
  scripts\engine\utility::flag_wait("c6_reveal_started");
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0._id_1120D = (-47, 74, 0);
  var_0._id_75AC = (0, 0, 0);
  var_1 = (150000, 0, 0);
  var_1 = rotatevector(var_1, var_0._id_1120D + var_0._id_75AC);
  var_2 = level.player.origin;
  var_0.origin = var_2 + var_1;
  scripts\engine\utility::flag_wait("player_opened_cafe_exit");
}

_id_337A() {
  level waittill("c6_droppod_landed_1");
  scripts\sp\utility::_id_10350("phstreets_plr_youhearingthat");
  level.allies["salter"] scripts\sp\utility::_id_10346("phstreets_slt_somethingsincom");
  scripts\engine\utility::flag_wait("c6_reveal_ambient_pod_spawned_3");
  level waittill("c6_droppod_landed_4");
  level.allies["admiral"] scripts\sp\utility::_id_10346("phstreets_adm_theyregettingcl");
  scripts\engine\utility::flag_wait("c6_reveal_started");
  level.allies["eth3n"] thread scripts\sp\utility::_id_10346("phstreets_eth_headsup");
  level waittill("c6_reveal_droppod_impact");
  scripts\sp\utility::_id_10350("phstreets_plr_uhh");
  scripts\engine\utility::flag_wait("c6_reveal_complete");
  wait 0.75;
  level.allies["eth3n"] scripts\sp\utility::_id_10346("phstreets_eth_moreofem");
}

_id_E574() {
  scripts\engine\utility::flag_wait("robot_alley_paths_started");
  level.allies["eth3n"] scripts\sp\utility::_id_F3B5("y");
  level.allies["salter"] scripts\sp\utility::_id_F3B5("b");
  level.allies["admiral"] scripts\sp\utility::_id_F3B5("g");

  foreach(var_1 in level.allies)
  var_1 thread _id_E572();

  scripts\sp\utility::_id_15F5("initial_pod_color_trig");
  scripts\engine\utility::flag_wait_all("robot_alley_runner01_pass", "robot_alley_runner02_pass");
  scripts\engine\utility::flag_set("robot_alley_runners_pass");
}

_id_E572() {
  level endon("c6_reveal_started");
  var_0 = scripts\engine\utility::getStruct("dust_stair_anim_1", "targetname");
  scripts\sp\utility::_id_54F7();
  var_0 scripts\sp\anim::_id_1F17(self, "dust_stairs");
  var_0 scripts\sp\anim::_id_1F35(self, "dust_stairs");
  var_1 = getnode("c6_reveal_path_" + self._id_1FBB, "targetname");
  thread scripts\sp\utility::_id_7226(var_1);
  scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "reached_path_end");
  scripts\sp\utility::_id_178D(scripts\engine\utility::flag_wait, "start_reveal_pod");
  scripts\sp\utility::_id_57D6();
  scripts\sp\utility::_id_61C7();
}

_id_33A6() {
  level._id_3397 = [];
  var_0 = scripts\engine\utility::getStruct("c6_reveal_animNode", "targetname");
  var_1 = getEnt("c6_reveal_dumpster", "targetname");
  level._id_3397["dumpster"] = var_1;
  var_1._id_1FBB = "dumpster";
  var_1 _meth_83D0(level._id_EC87["dumpster"]);
  var_2 = [var_1];
  var_1._id_B926 = [];

  for(var_3 = 0; var_3 < 5; var_3++) {
    var_4 = scripts\sp\utility::_id_10639("trash" + var_3);
    var_1._id_B926[var_1._id_B926.size] = var_4;
    var_2[var_2.size] = var_4;
  }

  var_1.clip = var_1 scripts\sp\utility::_id_7A8E();
  var_1.clip linkTo(var_1);
  var_1.clip connectpaths();
  var_0 scripts\sp\anim::_id_1EC1(var_2, "c6_reveal");
  scripts\engine\utility::waitframe();

  if(isDefined(var_1.clip))
    var_1.clip disconnectPaths();

  scripts\sp\lights::_id_ACD0("robot_alley_fire", "script_noteworthy", 0, (1, 1, 1));
}

_id_3397() {
  var_0 = scripts\engine\utility::getStruct("c6_reveal_animNode", "targetname");
  var_1 = scripts\sp\utility::_id_10639("player_rig");
  var_1 hide();
  var_0 scripts\sp\anim::_id_1EC3(var_1, "c6_reveal");
  var_2 = scripts\sp\utility::_id_10639("droppod");
  var_2 attach("veh_mil_air_ca_drop_pod_large_static_rail_c6", "tag_origin");
  level._id_3397["droppod"] = var_2;
  var_2 hide();
  var_3 = scripts\sp\utility::_id_10639("droppod_door");
  level._id_3397["droppod"].doors = var_3;
  var_3 hide();
  var_4 = [var_2, var_3];
  var_0 scripts\sp\anim::_id_1EC1(var_4, "c6_reveal_land");
  var_5 = getEnt("c6_reveal_dumpster", "targetname");
  scripts\sp\utility::_id_127B3("c6_reveal_trig");
  scripts\engine\utility::flag_set("c6_reveal_started");
  var_6 = ["TAG_THRUSTER_1", "TAG_THRUSTER_2", "TAG_THRUSTER_3", "TAG_THRUSTER_4"];

  foreach(var_8 in var_6)
  var_2 thread scripts\sp\utility::_id_75C4("droppod_thruster_c6_reveal", var_8);

  thread _id_339B();
  scripts\engine\utility::array_call(var_4, ::show);
  var_2 thread _id_339D();
  var_0 _id_33A0(var_4, var_1);

  foreach(var_8 in var_6)
  var_2 thread scripts\sp\utility::_id_75F8("droppod_thruster_c6_reveal", var_8);

  scripts\engine\utility::flag_set("c6_reveal");
  setsaveddvar("cg_drawplayershadow", 0);
  scripts\sp\utility::_id_22C9("c6_reveal_04", ::_id_276D);
  scripts\engine\utility::array_thread(level.allies, scripts\sp\utility::_id_BE49);
  var_0 thread _id_33A4();
  var_4 = [level.allies["salter"], var_3, var_5];
  var_4 = scripts\engine\utility::array_combine(var_4, var_5._id_B926);
  var_0 thread scripts\sp\anim::_id_1F2C(var_4, "c6_reveal");
  thread _id_33A3(var_1, var_2);
  level waittill("c6_reveal_plr_start");

  if(scripts\sp\utility::_id_93A6())
    scripts\sp\specialist_MAYBE::_id_F52F(0);

  level.allies["salter"] thread scripts\sp\utility::_id_4125(1, 1, "iw7_m4");
  getEnt("c6_reveal_sun_trig", "targetname") notify("trigger", level.player);
  level.player scripts\sp\utility::_id_F526("normal");
  thread _id_0B0F::_id_19FE("c6_reveal_aiambient");
  setsaveddvar("r_dof_hq", 1);

  if(level.player ismantling())
    level.player cancelmantle();

  level.player _id_0F3D::_id_D394();
  var_5.clip connectpaths();
  var_12 = gettime();
  var_0 thread scripts\sp\anim::_id_1F35(var_1, "c6_reveal");
  var_1 thread _id_339C();
  var_0 thread _id_33A2(var_1);
  level scripts\engine\utility::waittill_either("c6_reveal_player_interacted", "c6_reveal_player_interact_end");

  if(!scripts\engine\utility::flag("c6_reveal_player_interacted")) {
    level.player notify("c6_reveal_player_interact_fail");

    if(isDefined(level.player.melee._id_B5FE))
      level.player.melee._id_B5FE destroy();

    var_1 waittill("player_reveal_anim_done");
    scripts\engine\utility::flag_set("c6_reveal_complete");
  }

  scripts\engine\utility::flag_wait("c6_reveal_complete");

  if(scripts\sp\utility::_id_93A6())
    scripts\sp\specialist_MAYBE::_id_F52F(1);

  level.allies["salter"] thread scripts\sp\utility::_id_19FA("iw7_m4", "iw7_m8+m8scope_sp", 512, 0);

  foreach(var_14 in level.allies) {
    var_15 = scripts\sp\maps\pearlharbor\pearlharbor_util::_id_7E98("c6_reveal_tele_" + var_14._id_1FBB, "targetname");
    var_14 _meth_80F1(var_15.origin, var_15.angles);
    var_14 setgoalpos(var_15.origin);
    var_14 scripts\sp\utility::_id_61C7();
  }

  var_5.clip scripts\engine\utility::delaycall(2, ::disconnectpaths);
  scripts\engine\utility::array_thread(level.allies, scripts\sp\utility::_id_BE4A);
  level.player unlink();
  level.player _id_0F3D::_id_D3D2();
  var_1 delete();
  getEnt("player_reveal_clip", "targetname") delete();
  setsaveddvar("r_dof_hq", 0);
}

_id_339C() {
  level endon("c6_reveal_player_interacted");
  wait(getanimlength(scripts\sp\utility::_id_7DC1("c6_reveal")));
  wait 0.1;
  self notify("player_reveal_anim_done");
}

_id_276D() {
  self endon("death");
  self waittill("damage");
  self.attackeraccuracy = 1000;
}

_id_33A0(var_0, var_1) {
  var_2 = scripts\engine\utility::spawn_tag_origin();

  foreach(var_4 in var_0)
  var_4 linkTo(var_2);

  var_2 thread scripts\sp\anim::_id_1F2C(var_0, "c6_reveal_land");
  var_6 = getanimlength(var_0[0] scripts\sp\utility::_id_7DC1("c6_reveal_land")) * 1000;
  var_7 = self.origin - var_1.origin;
  var_8 = self.origin[2];
  var_9 = gettime();

  while(gettime() - var_9 <= var_6) {
    var_10 = level.player.origin + var_7;
    var_2.origin = (var_10[0], var_10[1], var_8);
    wait 0.05;
  }

  var_2.origin = self.origin;
  var_2 scripts\engine\utility::delaycall(0.1, ::delete);
}

_id_33A2(var_0) {
  level.player endon("c6_reveal_player_interact_fail");
  level.allies["salter"] thread scripts\sp\utility::_id_10346("phstreets_slt_reyes");
  level.player notifyonplayercommand("c6_reveal_player_interact", "+melee");
  level.player notifyonplayercommand("c6_reveal_player_interact", "+melee_breath");
  level.player notifyonplayercommand("c6_reveal_player_interact", "+melee_zoom");
  var_1 = getanimlength(var_0 scripts\sp\utility::_id_7DC1("c6_reveal"));
  var_2 = getnotetracktimes(var_0 scripts\sp\utility::_id_7DC1("c6_reveal"), "interact_start");
  var_3 = var_1 * var_2[0];
  var_1 = getanimlength(var_0 scripts\sp\utility::_id_7DC1("c6_reveal"));
  var_4 = getnotetracktimes(var_0 scripts\sp\utility::_id_7DC1("c6_reveal"), "interact_start");
  var_5 = var_1 * var_4[0];
  var_6 = getnotetracktimes(var_0 scripts\sp\utility::_id_7DC1("c6_reveal"), "interact_end");
  var_7 = var_1 * var_6[0];
  var_8 = var_7 - var_5;
  level.player.melee = spawnStruct();
  level.player thread _id_0F3D::_id_B610(var_3, var_8);
  level waittill("c6_reveal_player_interact_start");
  level.player waittill("c6_reveal_player_interact");

  if(isDefined(level.player.melee._id_B5FE))
    level.player.melee._id_B5FE destroy();

  scripts\engine\utility::flag_set("c6_reveal_player_interacted");
  level notify("notetrack_fire_stop");
  level.allies["salter"] _meth_83A1();
  var_9 = level.player.origin + level.player.angles * -40;
  level.allies["salter"] _meth_80F1(var_9, level.player.angles);
  var_0 _meth_83A1();
  var_0.angles = self.angles;
  var_0.origin = (63154, 35694, -34078);
  level._id_339E linkTo(var_0, "tag_sync", (0, 0, 0), (0, 0, 0));
  level._id_339E scripts\sp\utility::_id_5564();
  level._id_339E _id_0A1E::_id_2307(::_id_E57F);
  var_0 scripts\sp\anim::_id_1F35(var_0, "c6_reveal_counter");

  if(isDefined(level._id_339E) && isalive(level._id_339E))
    level._id_339E scripts\sp\utility::_id_54C6();

  if(isDefined(level.player.melee))
    level.player.melee = undefined;

  scripts\engine\utility::flag_set("c6_reveal_complete");
}

_id_33A1(var_0) {
  level.player enableweapons();
  level.player _meth_80A6();
}

_id_E57F() {
  self clearanim(_id_0A1E::asm_getbodyknob(), 0.2);
  self _meth_82E4("meleeAnim", scripts\sp\utility::_id_7DC1("c6_reveal_counter"), level._id_EC85[self._id_1FBB]["root"], 1, 0.2, 1);
  thread scripts\sp\anim::_id_10CBF(self, "meleeAnim");
  self waittillmatch("meleeAnim", "end");
}

_id_33A3(var_0, var_1) {
  var_2 = level.player scripts\engine\utility::spawn_tag_origin();
  var_2.origin = level.player.origin;
  var_2.angles = level.player getplayerangles();
  level.player playerlinkTo(var_2, "tag_origin", 1, 0, 0, 0, 0, 0);
  scripts\engine\utility::waitframe();
  var_3 = getanimlength(level._id_339E scripts\sp\utility::_id_7DC1("c6_reveal"));
  var_4 = getnotetracktimes(level._id_339E scripts\sp\utility::_id_7DC1("c6_reveal"), "plr_start_anim");
  var_5 = var_3 * var_4[0];
  var_6 = var_5;
  var_7 = 0;
  level.player _meth_823C(var_0, "tag_player", var_6);
  wait(var_6);
  level.player playerlinktodelta(var_0, "tag_player", 1, 0, 0, 0, 0, 1);
  level.player lerpviewangleclamp(0.4, 0, 0, 15, 20, 30, 0);
  var_0 show();
  var_2 delete();
}

_id_33A4() {
  var_0 = [];

  for(var_1 = 0; var_1 < 4; var_1++) {
    var_0[var_1] = scripts\sp\utility::_id_10639("droppod_arm");
    var_0[var_1]._id_1FBB = "droppod_arm_" + var_1;
  }

  level._id_3397["droppod"]._id_226D = var_0;
  level._id_33A4 = [];
  var_2 = getspawnerarray("c6_reveal_spawner");
  var_2 = scripts\engine\utility::array_add(var_2, getEnt("c6_reveal_choker", "targetname"));
  var_3 = [];

  foreach(var_1, var_5 in var_2) {
    var_6 = var_5.script_noteworthy;
    var_7 = var_5 scripts\sp\utility::_id_10619(1);
    var_7._id_1FBB = var_6;
    var_7.ignoreme = 1;
    var_7.ignoreall = 1;
    var_7.grenadeammo = 0;
    var_7.disablecoverarrivalsonly = 1;
    var_7.dontmelee = 1;
    var_7.laststand = 0;
    var_3[var_3.size] = var_7;

    if(var_7._id_1FBB != "c6_reveal_02") {
      if(isDefined(var_7.melee))
        var_7 scripts\aitypes\melee::melee_destroy();

      var_7 scripts\sp\utility::_id_B14F();
      level._id_33A4[level._id_33A4.size] = var_7;
    }

    if(var_7._id_1FBB == "c6_reveal_01") {
      var_7._id_10265 = 1;
      var_7.forceragdollimmediate = 1;
      var_7 scripts\sp\utility::_id_86E4();
      level._id_339E = var_7;
    } else if(var_7._id_1FBB == "c6_reveal_02") {
      var_7 setCanDamage(1);
      var_7 scripts\sp\utility::_id_F2A8(1);
      var_7 delete();
      continue;
    } else if(var_7._id_1FBB == "c6_reveal_03")
      level._id_339F = var_7;
    else if(var_7._id_1FBB == "c6_reveal_04") {
      var_8 = var_7 scripts\sp\utility::_id_7A96();
      var_7 thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_19C5(var_8);
      var_7.health = int(var_7.health / 3);
      var_7.attackeraccuracy = 10;
    }

    thread _id_33A5(var_7, var_0[var_1]);
  }
}

_id_33A5(var_0, var_1) {
  var_2 = [var_0, var_1];
  scripts\sp\anim::_id_1F2C(var_2, "c6_reveal");

  if(var_0._id_1FBB != "c6_reveal_01") {
    var_0.ignoreme = 0;
    var_0.ignoreall = 0;
  }

  var_0 scripts\sp\utility::_id_1101B();
}

_id_339D() {
  self playSound("droppod_incoming");
  level waittill("c6_reveal_droppod_impact");
  var_0 = getEntArray("c6_reveal_droppod_impact_prestine", "targetname");
  var_1 = getEntArray("c6_reveal_droppod_impact_dmg", "targetname");
  scripts\engine\utility::array_thread(var_1, scripts\sp\utility::_id_100D7);
  scripts\sp\utility::_id_228A(var_0);
  self notify("stop sounddroppod_descend_lp");
  self setModel("veh_mil_air_ca_drop_pod_large_base_landed");
  resetsundirection();
  level.player shellshock("phstreets_c6_reveal", 1.5);
  earthquake(0.5, 1, self.origin, 9999);
  playrumbleonposition("droppod_impact", self.origin);
  playworldsound("scn_phstreets_droppod_reveal_land_impact", self.origin);
  level.player playSound("scn_phstreets_droppod_reveal_debris_lr");
}

_id_339B() {
  level waittill("c6_reveal_droppod_impact");
  thread _id_0B0A::_id_583F(0, 8.11, 6, 0, 250.931, 5, 1.25);
  wait 5;
  thread _id_0B0A::_id_583F(0, 8.11, 6, 500, 700, 5, 3);
  scripts\engine\utility::flag_wait("c6_reveal_complete");
  thread _id_0B0A::_id_583D(2);
}

_id_33A7() {
  scripts\sp\utility::_id_5504();
  scripts\sp\utility::_id_5528();
  scripts\sp\utility::_id_559A();
  scripts\sp\utility::_id_B14F();
  scripts\sp\utility::_id_5564();
  self._id_1FBB = "generic";
  scripts\sp\utility::_id_F48E("combat", "ph_c6_intro_civi02_ambient");
  self._id_1FBB = "stumbler";
  var_0 = scripts\sp\utility::_id_7A96();
  var_0 scripts\sp\anim::_id_1F17(self, "c6_alley_stumble");
  var_0 scripts\sp\anim::_id_1F35(self, "c6_alley_stumble");
  thread scripts\sp\anim::_id_1EEA(self, "c6_alley_stumble_idle");
  scripts\engine\utility::flag_wait("c6_reveal");
  scripts\sp\utility::_id_1101B();
  self delete();
}

_id_3398() {}

_id_339A() {
  scripts\sp\utility::_id_5504();
  scripts\sp\utility::_id_5528();
  scripts\sp\utility::_id_B14F();
  scripts\sp\utility::_id_5564();
  scripts\sp\utility::_id_559A();
  self._id_1FBB = "generic";
  thread scripts\sp\anim::_id_1F35(self, "ph_c6_intro_civi01_ambient");
  wait 9.5;
  self _meth_83A1();
  scripts\sp\utility::_id_1101B();
  scripts\sp\utility::_id_19D3();
}

_id_3399() {
  var_0 = self.spawner;
  var_1 = var_0.index;
  level._id_4B3B = self;
  self._id_BFEB = 1;
  self._id_93D4 = "droppod_c6_reveal_incoming_dist_" + var_0.script_sound;
  self._id_934A = "droppod_c6_reveal_impact_dist_" + var_0.script_sound;
  self._id_1186F = "droppod_thruster_c6_reveal";
  var_1 = var_0.script_index;
  level notify("c6_droppod_spawned_" + var_1);

  if(scripts\engine\utility::flag_exist("c6_reveal_ambient_pod_spawned_" + var_1))
    scripts\engine\utility::flag_set("c6_reveal_ambient_pod_spawned_" + var_1);

  self waittill("death");
  level.player playRumbleOnEntity("artillery_rumble");

  if(level._id_4B3B == self)
    level._id_4B3B = undefined;

  level notify("c6_droppod_landed_" + var_1);
}

_id_1027B() {
  level endon("c6_reveal");
  scripts\engine\utility::flag_wait("robot_alley_moveup_2");
  var_0 = getEntArray("c6_reveal_looping_droppods", "targetname");
  var_1 = var_0;

  for(;;) {
    if(isDefined(level._id_4B3B)) {
      wait(randomfloatrange(1, 3));
      continue;
    }

    var_2 = scripts\engine\utility::random(var_1);
    var_2.speed = 1300;
    var_3 = var_2 scripts\sp\utility::_id_10808();
    var_3._id_BFF7 = 1;
    var_3._id_BFEB = 1;
    var_3._id_93D4 = "droppod_c6_reveal_incoming_dist_far";
    var_3._id_934A = "droppod_land_impact_dist";
    var_3._id_1186F = "droppod_thruster_c6_reveal";
    wait(randomfloatrange(4, 6));
    var_1 = scripts\engine\utility::array_remove(var_0, var_2);
  }
}

_id_3379() {
  scripts\sp\utility::_id_228A(level._id_3397["dumpster"]._id_B926);
  level._id_3397["dumpster"].clip delete();
  level._id_3397["dumpster"] delete();

  if(isDefined(level._id_3397["droppod"])) {
    scripts\sp\utility::_id_228A(level._id_3397["droppod"]._id_226D);
    level._id_3397["droppod"].doors delete();
    level._id_3397["droppod"] delete();
  }

  var_0 = getEnt("player_reveal_clip", "targetname");

  if(isDefined(var_0))
    var_0 delete();

  level._id_3397 = undefined;
  level._id_339F = undefined;
  level._id_339E = undefined;
  level._id_33A4 = undefined;
}

_id_3378() {
  level.allies["eth3n"] scripts\sp\utility::_id_F3B5("y");
  level.allies["salter"] scripts\sp\utility::_id_F3B5("b");
  level.allies["admiral"] scripts\sp\utility::_id_F3B5("g");
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_65D5("mall");
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_65D5("streets");
  scripts\engine\utility::flag_set("c6_reveal_started");
  thread _id_E577();
}

_id_5D50() {
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC53("start_droppods");
  thread scripts\sp\maps\phstreets\phstreets::_id_F51C("med_battle", 1);
  var_0 = ["admiral", "salter", "eth3n"];
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC05("start_droppods", var_0);
  scripts\engine\utility::noself_delaycall(0.05, ::visionsetnaked, "", 6);
}

_id_5D4E() {
  if(scripts\sp\utility::_id_93A6())
    thread scripts\sp\specialist_MAYBE::_id_2683();

  visionsetnaked("", 6);
  level.old_reactive_setting = getdvarint("r_reactiveMotionEffectorStrengthScale");
  setsaveddvar("r_reactiveMotionEffectorStrengthScale", 10);
  thread _id_5D4C();
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EF24("robots_scriptable_cars");
  thread robot_fountain_think();

  if(!getdvarint("E3", 0)) {
    if(getdvarint("exec_review") == 0) {
      var_0 = getEnt("aatis_tower_periph", "targetname");
      var_0 thread scripts\sp\utility::_id_918B("ar_callouts_aatis_tower", 1, (0, 0, 5000));
      var_0 scripts\engine\utility::delaythread(5, scripts\sp\utility::_id_918C);
    }
  }

  scripts\engine\utility::flag_wait("courtyard_droppods");
  thread _id_5D46();
  scripts\sp\utility::_id_CF8D();
  scripts\sp\utility::_id_28D8("allies");
  scripts\sp\utility::_id_28D8("axis");
  scripts\sp\utility::_id_22CA("courtyard_droppod_civis", _id_0B77::_id_10CC6);
  scripts\sp\utility::_id_22CA("courtyard_droppod_civis", scripts\sp\maps\pearlharbor\pearlharbor_util::_id_3FAC);
  scripts\engine\utility::delaythread(2.75, scripts\sp\utility::_id_22CD, "courtyard_droppod_civis", 1);
  thread _id_46E6();
  scripts\engine\utility::array_thread(level.allies, scripts\sp\utility::_id_4145);
  scripts\engine\utility::array_thread(level.allies, ::_id_46D1);
  _id_106AD();
  level._id_D5FE waittill("landed");
  scripts\engine\utility::flag_set("courtyard_droppods_landed");
  thread _id_10429();
  scripts\engine\utility::flag_wait("droppods_complete");
}

_id_46EA() {
  scripts\engine\utility::flag_wait("robot_courtyard_cleared");

  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  if(!isDefined(level._id_46EA))
    level._id_46EA = [];

  level._id_46EA[level._id_46EA.size] = self;
  var_0 = cos(80);

  for(;;) {
    wait 0.25;

    if(!isDefined(self) || !isalive(self)) {
      break;
    }

    if(level._id_46EA.size > 3) {
      continue;
    }
    if(!scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), self gettagorigin("j_spineupper"), var_0)) {
      break;
    }
  }

  level._id_46EA = scripts\engine\utility::array_remove(level._id_46EA, self);

  if(!level._id_46EA.size)
    level._id_46EA = undefined;

  if(isDefined(self) && isalive(self))
    scripts\sp\utility::_id_54C6();
}

_id_5D46() {
  scripts\sp\utility::_id_127B3("courtyard_add");
  scripts\sp\utility::_id_22CA("courtyard_civis_add_del", ::_id_513B);
  scripts\sp\utility::_id_22CA("courtyard_civis_add_del", scripts\sp\maps\pearlharbor\pearlharbor_util::_id_3FAC);
  scripts\sp\utility::_id_22CD("courtyard_civis_add_del", 1);
}

_id_46E6() {
  scripts\engine\utility::flag_wait("robot_courtyard_retreat");
  var_0 = scripts\sp\utility::_id_22CD("courtyard_middle_reinfo", 1, 1);
  scripts\engine\utility::array_thread(var_0, ::_id_46EA);
}

_id_513B(var_0) {
  self endon("death");

  if(isDefined(var_0))
    wait(var_0);

  self waittill("reached_path_end");

  while(isDefined(self) && scripts\sp\utility::_id_CFAC(self))
    wait 0.1;

  if(isalive(self))
    self delete();
}

_id_3FAD() {
  self.attackeraccuracy = 10000;
}

_id_5D4C() {
  scripts\engine\utility::flag_wait("c6_reveal_done");
  level.allies["salter"] scripts\sp\utility::_id_10346("phstreets_slt_atistowersdeada");
  wait 0.05;
  level.allies["admiral"] scripts\sp\utility::_id_10346("phstreets_adm_weregettingclos");
  scripts\engine\utility::flag_wait("courtyard_droppods");
  level.allies["admiral"] scripts\sp\utility::_id_10346("phstreets_eth_c6sdroppinin");
  wait 0.5;
  level.allies["salter"] scripts\sp\utility::_id_10346("phstreets_slt_getgunsonem");
  wait 2;
  scripts\sp\utility::_id_10350("phstreets_plr_botswillbeweak");
  scripts\engine\utility::flag_wait("robot_courtyard_retreat");
  scripts\sp\utility::_id_10350("phstreets_plr_pushthrough");
  scripts\engine\utility::flag_wait("robot_courtyard_cleared");
  level.allies["admiral"] scripts\sp\utility::_id_10346("phstreets_adm_saltertakeusout");
  level.allies["salter"] scripts\sp\utility::_id_10346("phstreets_slt_letsmovethisway");
}

_id_5D47() {
  scripts\sp\utility::_id_54F7();
  var_0 = getnode("robot_courtyard_admiral_turret_node", "targetname");
  thread scripts\sp\utility::_id_7226(var_0);
  scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "stop_using_turret");
  scripts\sp\utility::_id_57D6();
  scripts\sp\utility::_id_61C7();
}

_id_10429() {
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0)
  var_2 thread _id_33A9();

  while(getaiarray("axis").size > 3)
    wait 0.05;

  scripts\engine\utility::array_thread(getaiarray("axis"), ::_id_19DB);
}

_id_33A9() {
  if(issubstr(self.model, "red"))
    var_0 = level._effect["vfx_c6_scanner_green"];
  else
    var_0 = level._effect["vfx_c6_scanner_green"];

  playFXOnTag(var_0, self, "tag_eye");

  while(isalive(self)) {
    playFXOnTag(var_0, self, "tag_eye");
    wait(randomintrange(3, 4));
  }
}

_id_19DB() {
  self endon("death");
  self notify("stop_going_to_node");
  var_0 = 250;
  var_1 = distance(self.origin, level.player.origin);

  for(;;) {
    var_2 = randomfloatrange(3, 6);
    wait(var_2);
    self.goalradius = var_1;
    self setgoalentity(level.player);
    var_1 = var_1 - 175;

    if(var_1 < var_0) {
      var_1 = var_0;
      return;
    }
  }
}

robot_fountain_think() {
  var_0 = spawn("trigger_radius", (64390, 37821, -34030), 0, 80, 128);

  for(;;) {
    scripts\sp\utility::_id_178D(scripts\engine\utility::flag_wait, "hill_player_in_bddy_door");
    var_0 scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "trigger");
    scripts\sp\utility::_id_57D6();

    if(scripts\engine\utility::flag("hill_player_in_bddy_door")) {
      break;
    }

    while(level.player istouching(var_0)) {
      level.player setwatersheeting(1, 0.5);
      wait 0.25;
    }

    level.player setwatersheeting(0, 0.5);
  }

  var_0 delete();
}

_id_E580() {
  self notsolid();
  self playSound("scn_phstreets_courtyard_enemy_capital_ship_flyover");
  thread _id_FB75();
  _id_0BB8::_id_39CD("heavy");
  _id_0BB8::_id_39D0("idle");
  wait 3;
  level notify("drop_first_pods");
}

_id_FB75() {
  wait 1.2;
  playworldsound("scn_phstreets_courtyard_pod_jettison_01", (64309, 37593, -33468));
  wait 0.2;
  playworldsound("scn_phstreets_courtyard_pod_jettison_02", (64333, 38185, -33468));
}

_id_106AD() {
  level._id_D5FD = scripts\sp\vehicle::_id_1080C("pod_section_spawner_0");
  var_0 = level._id_D5FD._id_E4FB;
  wait 0.5;
  level._id_D5FE = scripts\sp\vehicle::_id_1080C("pod_section_spawner_1");
  var_0 = scripts\engine\utility::array_combine(level._id_D5FE._id_E4FB, var_0);
  thread _id_106F0();
}

_id_46D2() {
  self waittill("landed");
  scripts\sp\utility::_id_22CD("courtyard_gate_droppod_robots", 1, 1);
  scripts\engine\utility::flag_set("courtyard_gate_droppod_landed");
}

_id_106F0() {
  wait 1;
  level._id_6AFE = [];

  for(var_0 = 0; var_0 < 2; var_0++) {
    level._id_6AFE[var_0] = scripts\sp\vehicle::_id_1080C("robots_alley_pod_0" + var_0);
    level._id_6AFE[var_0]._id_594A = 1;
    level._id_6AFE[var_0] thread _id_E7C4();
    wait 0.25;
  }
}

_id_E7C4() {
  self waittill("death");
  level.player playRumbleOnEntity("artillery_rumble");
}

_id_46D1() {
  var_0 = getEnt("robot_courtyard_final_colortrig", "script_noteworthy");
  var_1 = getEnt("robot_alley_first_colortrig", "script_noteworthy");
  var_2 = getEnt("alley_robot_friendly_target_trig", "targetname");
  var_3 = scripts\engine\utility::getStruct("robot_alley_friendly_target_pos", "targetname");
  var_0 waittill("trigger");

  while(isDefined(var_2) && !self istouching(var_2)) {
    if(scripts\engine\utility::flag("droppods_complete")) {
      break;
    }

    wait 0.1;
  }

  if(!scripts\engine\utility::flag("droppods_complete")) {
    var_4 = spawn("script_origin", var_3.origin);
    self _meth_82DE(var_4);
    var_1 scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "trigger");
    scripts\sp\utility::_id_178D(scripts\engine\utility::flag_wait, "droppods_complete");
    scripts\sp\utility::_id_57D6();
    self clearentitytarget();
    var_4 delete();
  }

  if(isDefined(var_2))
    var_2 delete();
}

_id_5D4A() {}

_id_E576() {
  scripts\sp\utility::_id_15F3("robot_alley_initial_robot_trigs");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC53("start_robot_alley");
  thread scripts\sp\maps\phstreets\phstreets::_id_F51C("med_battle", 1);
  var_0 = ["admiral", "salter", "eth3n"];
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC05("start_robot_alley", var_0);
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EF24("robots_scriptable_cars");
}

_id_E573() {
  if(scripts\sp\utility::_id_93A6())
    thread scripts\sp\specialist_MAYBE::_id_2683();

  thread _id_E56C();
  thread _id_E56A();
  thread _id_E571();
  scripts\engine\utility::flag_wait("robot_alley_complete");
  scripts\engine\utility::exploder("cafe_explosion");
  thread _id_4070();
  thread _id_E5BE();
}

_id_E56C() {
  scripts\engine\utility::flag_wait("droppods_complete");
  level.allies["eth3n"] thread scripts\sp\utility::_id_10346("phstreets_eth_threatsinbound");
  scripts\engine\utility::flag_wait("robot_alley_final_drop_pod");
  _id_1373C("robot_alley_complete");
  scripts\sp\utility::_id_28D7("allies");
  wait 1;
  level.allies["eth3n"] scripts\sp\utility::_id_10346("phstreets_eth_whyaretheyattacking");
  wait 0.05;
  level.player scripts\sp\utility::_id_1034D("phstreets_plr_tryingtotakecontrol");
  wait 0.05;
  level.allies["salter"] thread scripts\sp\utility::_id_10346("phstreets_slt_wholefleetwasthere");
  scripts\sp\utility::_id_28D8("allies");
  scripts\engine\utility::flag_set("robot_alley_vo_complete");
}

_id_1373C(var_0) {
  while(!scripts\engine\utility::flag(var_0)) {
    if(!getaiarray("axis").size) {
      return;
    }
    wait 0.05;
  }
}

_id_E57A() {
  var_0 = scripts\sp\utility::_id_7A96();
  self._id_1FBB = "c6";
  self.disablecoverarrivalsonly = 1;
  var_0 thread scripts\sp\anim::_id_1F35(self, "hill_robot_ledge_pulldown");
  scripts\engine\utility::waitframe();
  self _meth_82B0(scripts\sp\utility::_id_7DC1("hill_robot_ledge_pulldown"), 0.55);
  self setCanDamage(1);
  scripts\sp\utility::_id_F2A8(1);
}

_id_E575() {
  var_0 = self.spawner;
  self.grenadeawareness = 0;
  self.ignoreme = 0;
  scripts\sp\utility::_id_5564();
  scripts\sp\utility::_id_550C();
  scripts\sp\utility::_id_1101B();
  self._id_1FBB = "generic";
  scripts\sp\utility::_id_F48E("combat", "hm_grnd_red_civ_run_twitch04");
  var_1 = var_0 scripts\sp\utility::_id_7A96();
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_19C5(var_1);
  var_2 = scripts\sp\maps\pearlharbor\pearlharbor_util::_id_CA95(0.75, 1);

  if(!isDefined(var_2)) {
    return;
  }
  var_2 endon("death");

  if(isDefined(self) && isalive(self))
    self waittill("death");

  if(isDefined(var_2))
    var_2 scripts\sp\utility::_id_1101B();
}

_id_E56D() {
  scripts\sp\utility::_id_22CD("robot_alley_dropship_civis", 1);
  scripts\sp\utility::_id_65E0("engage_turret");
  scripts\sp\vehicle::_id_8441();
  self notsolid();
  self makeentitysentient("axis");
  self setthreatbiasgroup("robot_alley_bottom_street_enemies");
  thread _id_E56E();
  scripts\sp\utility::_id_65E3("engage_turret");
  thread _id_E56F();
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_1 = self.mgturret[0];
  var_1 setmode("manual");
  var_1 settargetentity(var_0);
  var_1._id_B319 = var_0;
  thread scripts\sp\mgturret::_id_32B5(var_1, var_0);
  var_1 _id_E570(var_0);
  var_0.origin = (64784, 38784, -34072);
  wait 0.5;
  radiusdamage(var_0.origin, 150, 9999, 9999);
  var_1 notify("stopfiring");
  var_1 setmode("auto_nonai");
  var_1 cleartargetentity();
  var_0 delete();
}

_id_E56F() {
  var_0 = scripts\sp\maps\pearlharbor\pearlharbor_util::_id_B284(level.player);
  var_0 scripts\sp\utility::_id_E7C9(0.2, 5);

  while(isDefined(self) && isalive(self) && distance2dsquared(self.origin, level.player.origin) < squared(2400))
    wait 0.05;

  var_0 scripts\sp\utility::_id_E7C9(0, 5);
  var_0 delete();
}

_id_E56E() {
  scripts\sp\utility::_id_65E3("engage_turret");
  wait 1.5;
  scripts\engine\utility::exploder("dropship_attack_2");
  scripts\sp\utility::_id_65E3("unloaded");
  wait 5;
  scripts\sp\utility::_id_10FEC("dropship_attack_2");
}

_id_E570(var_0) {
  var_1 = spawnStruct();
  var_1.origin = (65512, 39624, -34322.1);
  var_1.radius = 150;
  var_2 = spawnStruct();
  var_2.origin = (64880, 38992, -34161.9);
  var_2.radius = 150;
  var_3 = distance(var_1.origin, var_2.origin);
  var_4 = 30;
  var_5 = int(var_3 / var_4);
  var_6 = var_1.origin;
  var_7 = vectorNormalize(var_2.origin - var_1.origin);
  var_8 = var_1.radius;

  for(var_9 = 0; var_9 < var_5; var_9++) {
    var_10 = randomintrange(1, 3);

    for(var_11 = 0; var_11 < var_10; var_11++) {
      var_12 = scripts\sp\maps\pearlharbor\pearlharbor_util::_id_E45E(var_6, var_8);
      var_12 = scripts\sp\utility::_id_864C(var_12, (0, 0, 1));
      var_0.origin = var_12;
      playworldsound("phstreets_hill_dirt_bullet_impact_jackal", var_12);
      playFX(scripts\engine\utility::getfx("hill_jackal_bullet_impact"), var_12, (0, 0, 1));
      wait 0.05;
    }

    var_6 = var_6 + var_7 * var_4;
  }
}

_id_E56A() {
  level endon("robot_alley_complete");
  scripts\engine\utility::flag_wait("robot_alley_player_taking_side");
  var_0 = scripts\sp\utility::_id_77DA("robot_alley_initial_robots");

  foreach(var_2 in var_0) {
    wait(randomfloatrange(0.25, 1.5));

    if(!isDefined(var_2) || !isalive(var_2)) {
      continue;
    }
    var_2 scripts\sp\utility::_id_54C6();
  }
}

_id_E571() {
  var_0 = getEnt("robot_alley_final_droppod_trig", "targetname");
  var_1 = getEnt("robot_alley_final_droppod", "targetname");
  var_0 waittill("trigger");
  var_2 = 3000;
  var_3 = gettime();
  var_4 = cos(45);

  while(!scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), var_1.origin, var_4)) {
    if(gettime() - var_3 >= var_2) {
      break;
    }

    wait 0.1;
  }

  var_5 = var_1 scripts\sp\utility::_id_10808();
  scripts\engine\utility::flag_set("robot_alley_final_drop_pod");
  scripts\engine\utility::flag_wait("cafe_complete");
  var_5 _id_0BBB::_id_514A();
  var_1 delete();
}

_id_4070() {
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(isalive(var_2)) {
      var_2 _meth_81D0();
      wait(randomfloatrange(0.2, 1));
    }
  }
}

_id_E569() {
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_65D5("robots");
  thread _id_E5BE();
}

_id_36C7() {
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC53("start_cafe");
  thread scripts\sp\maps\phstreets\phstreets::_id_F51C("med_battle", 1);
  var_0 = ["admiral", "salter", "eth3n"];
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC05("start_cafe", var_0);
  scripts\sp\utility::_id_15F1("cafe_color_trig", "targetname");
  scripts\engine\utility::flag_set("robot_alley_vo_complete");
}

_id_36C4() {
  if(scripts\sp\utility::_id_93A6())
    thread scripts\sp\specialist_MAYBE::_id_2683();

  var_0 = _id_0B1E::_id_794D("cafe_peek_door");
  level._id_36CC = var_0.angles;
  thread _id_36B2(var_0);
  _id_8E73();
  thread _id_C9EA();
  thread _id_36C9();
  var_1 = getspawnerarray("cafe_civrunner");

  foreach(var_3 in var_1)
  var_3 scripts\sp\utility::_id_1747(::_id_3FE4);

  var_1 = getspawnerarray("cafe_civrunner_mainroom");

  foreach(var_3 in var_1)
  var_3 scripts\sp\utility::_id_1747(::_id_3FE3);

  thread _id_36AE();
  var_7 = getEntArray("cafe_hack_pristine_damage_door", "targetname");

  foreach(var_9 in var_7)
  var_9 hide();

  var_11 = getEntArray("cafe_hack_door_clip", "targetname");

  foreach(var_13 in var_11)
  var_13 hide();

  if(getdvarint("e3", 0) == 1) {
    scripts\engine\utility::delaythread(0.05, ::_id_10197, "dmg2");
    var_15 = getEnt("hack_window_clip", "targetname");

    if(isDefined(var_15)) {
      var_15 connectpaths();
      var_15 delete();
    }

    var_16 = getEnt("cafe_table", "targetname");
    var_17 = var_16 scripts\engine\utility::get_target_ent();
    var_16 delete();
    var_17 delete();
  }

  thread _id_68E4();
  scripts\engine\utility::flag_wait("cafe_player_start_peek");
  scripts\sp\utility::_id_15F5("cafe_enemies_mainroom");
  getEnt("aatis_tower_periph", "targetname") delete();
  thread scripts\sp\utility::_id_12641("phstreets_tower_ex_tr");
  scripts\engine\utility::flag_wait("player_in_cafe");
  thread _id_C9E9();
  scripts\sp\utility::_id_15F5("cafe_civrunner_hallway");
  scripts\sp\utility::_id_15F5("cafe_allies_enter");
  scripts\sp\utility::_id_28D8("axis");
  scripts\engine\utility::flag_wait("cafe_player_in_mainroom");

  if(getdvarint("e3", 0) == 0) {
    thread _id_36BE();
    thread _id_36B7();
  } else {
    var_18 = scripts\engine\utility::getStruct("cafe_animNode", "targetname");
    level.allies["eth3n"] scripts\sp\utility::_id_F3DD(32);
    var_18 thread scripts\sp\anim::_id_1F17(level.allies["eth3n"], "cafe_table_intro");
    thread _id_36CB();
    level scripts\engine\utility::waittill_any("cafe_enemies_dead", "cafe_do_stumble");
  }

  thread _id_36B5();
}

_id_36B2(var_0) {
  level waittill("door_peek_finished");
  wait 0.5;
  scripts\sp\utility::_id_15F5("cafe_allies_enter");
}

_id_36CB() {
  level endon("cafe_do_stumble");
  var_0 = getaiarray("axis");
  var_0 = scripts\sp\utility::array_removedeadvehicles(var_0);

  while(var_0.size > 0) {
    var_0 = getaiarray("axis");
    var_0 = scripts\sp\utility::array_removedeadvehicles(var_0);
    wait 0.1;
  }

  level notify("cafe_enemies_dead");
}

_id_3FE4() {
  scripts\sp\utility::_id_5528();
  level._id_878B[level._id_878B.size] = self;

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "cafe_civrunner_talk") {
    wait 0.25;
    thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_3FAC();
  }
}

_id_3FE3() {
  scripts\engine\utility::flag_wait("cafe_player_in_mainroom");
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_3FAC();

  if(self.script_index == 3)
    wait 0.25;

  self _meth_82EE(getnode("civrunner_mainroom_goal" + self.script_index, "targetname"));
}

_id_113C6() {
  scripts\engine\utility::flag_wait("cafe_eth3n_idling");
  wait 0.4;
  self setModel("lobby_table_02_dmg");
  scripts\engine\utility::flag_wait("cafe_eth3n_idling2");
  wait 0.4;
  self setModel("lobby_table_02_dmg_01");
}

_id_36C9() {
  var_0 = level.allies["eth3n"];
  var_1 = level.allies["salter"];
  var_2 = level.allies["admiral"];
  scripts\engine\utility::flag_wait("robot_alley_vo_complete");
  wait 0.25;
  thread scripts\engine\utility::play_sound_in_space("scn_phstreets_cafe_int_gunshots", (67362, 39515, -34274));
  wait 0.75;
  var_0 scripts\sp\utility::_id_10346("phstreets_eth_impickingupmove");
  var_1 scripts\sp\utility::_id_10346("phstreets_slt_reyesopenitillc");
  wait 6.0;

  if(!scripts\engine\utility::flag("cafe_player_start_peek"))
    var_1 scripts\sp\utility::_id_10346("phstreets_slt_letsgetgoing");
}

_id_36B5() {
  level endon("cafe_do_stumble");
  var_0 = level.allies["salter"];
  var_1 = getaiarray("axis");
  var_1 = scripts\sp\utility::array_removedeadvehicles(var_1);

  while(var_1.size > 0) {
    var_1 = getaiarray("axis");
    var_1 = scripts\sp\utility::array_removedeadvehicles(var_1);
    wait 0.1;
  }

  wait 1.5;
  var_0 scripts\sp\utility::_id_10346("phstreets_slt_towerisntfarno");
  wait 5.0;
  var_0 scripts\sp\utility::_id_10346("phstreets_slt_letspickupthep");
}

_id_36AE() {
  var_0 = getspawnerarray("hack_civ");
  level._id_878B = [];
  level._id_87BF = [];
  level._id_878A = [];

  foreach(var_2 in var_0)
  level._id_878B[level._id_878B.size] = var_2 _id_3FAE();

  var_0 = getspawnerarray("cafe_civrunner_mainroom");

  foreach(var_2 in var_0)
  level._id_878B[level._id_878B.size] = var_2 _id_3FAE();

  scripts\engine\utility::flag_wait("pod_2_landed");
  scripts\engine\utility::flag_wait("pod_1_landed");
  wait 3.0;
  var_0 = getspawnerarray("hack_civ_exterior");

  foreach(var_2 in var_0)
  level._id_878A[level._id_878A.size] = var_2 _id_3FAE();
}

_id_3FAE() {
  var_0 = scripts\sp\utility::_id_10619();
  var_0._id_1FBB = "cafe_civ";
  var_0 _meth_83B9(self.origin, self.angles);
  var_0 scripts\sp\utility::_id_F3DD(12);
  var_0 setgoalpos(self.origin);

  if(isDefined(self.animation)) {
    var_0 setCanDamage(1);
    var_0 scripts\sp\utility::_id_F3C0(1);
    var_0.health = 10;
    var_0 scripts\sp\utility::_id_F2A8(1);
    var_0._id_10265 = 1;
    var_0.forceragdollimmediate = 1;
    var_0 thread scripts\sp\anim::_id_1EEA(var_0, var_0.animation, "stop_cafe_anim");
  }

  var_0 thread _id_3F97();
  return var_0;
}

_id_B034() {
  level waittill(self.script_noteworthy);
  self notify("stop_cafe_anim");
  self _meth_83A1();
  self _meth_81D0();
}

_id_68E4() {
  scripts\sp\utility::_id_28D7("axis");

  foreach(var_1 in level.allies) {
    var_1.ignoreme = 1;
    var_1.doingambush = 1;
    var_1.script_pushable = 0;
  }

  level.allies["salter"] scripts\sp\utility::_id_51E1("frantic");
  var_3 = scripts\engine\utility::getStruct("cafe_execution_animNode", "targetname");
  var_4 = spawnStruct();
  var_4.angles = var_3.angles;
  var_4.origin = var_3.origin;
  var_5 = _id_F9FC("cafe_peek_civ_0", "peek_civ_1", 1);
  var_6 = _id_F9FC("cafe_peek_civ_1", "peek_civ_2");
  var_7 = _id_F9FC("cafe_peek_civ_2", "peek_civ_3");
  var_8 = _id_F9FC("cafe_peek_sdf_0", "peek_sdf_1");
  var_9 = _id_F9FC("cafe_peek_sdf_1", "peek_sdf_2");
  var_10 = [var_5, var_6, var_7];
  var_11 = [var_8, var_9];
  var_5 notsolid();
  thread _id_59C3(var_10, var_11);
  var_7 scripts\sp\utility::_id_F3C0(1);

  foreach(var_13 in var_10) {
    var_3 thread _id_C9F4(var_13);
    var_13 thread _id_3F97();
  }

  var_4 thread _id_C9F6(var_8, 1, var_6);
  var_3 thread _id_C9F6(var_9, 0, var_7);
  thread _id_0B1E::_id_59BE("cafe_peek_door");
  level waittill("door_peek_start");
  _id_1C09();
  thread _id_C9E9();
  var_15 = getEnt("cafe_peek_weap_clip", "targetname");
  var_15 delete();
  scripts\engine\utility::flag_set("cafe_player_start_peek");
  thread scripts\engine\utility::flag_set_delayed("start_peek_execution", 0.5);
  level._id_5A5E = 0;
  thread scripts\sp\utility::_id_2670();
  level waittill("start_peek_execution");
  thread _id_EB59();
  level scripts\engine\utility::waittill_any("failed_to_save_civies", "player_saved_cafe_guys");
  scripts\sp\utility::_id_28D8("axis");

  foreach(var_1 in level.allies) {
    var_1.ignoreme = 0;
    var_1.doingambush = 0;
    var_1.script_pushable = 1;
  }

  level.allies["salter"] scripts\sp\utility::_id_51E1("combat");
}

_id_1C09() {
  var_0 = getEnt("cafe_peek_area", "targetname");

  if(!level.allies["admiral"] istouching(var_0)) {
    scripts\sp\maps\pearlharbor\pearlharbor_util::_id_1683(level.allies["admiral"], "start_cafe_admiral");
    scripts\sp\utility::_id_15F1("cafe_color_green_move", "targetname");
  }

  if(!level.allies["salter"] istouching(var_0)) {
    scripts\sp\maps\pearlharbor\pearlharbor_util::_id_1683(level.allies["salter"], "start_cafe_salter");
    scripts\sp\utility::_id_15F1("cafe_color_blue_move", "targetname");
  }

  if(!level.allies["eth3n"] istouching(var_0)) {
    scripts\sp\maps\pearlharbor\pearlharbor_util::_id_1683(level.allies["eth3n"], "start_cafe_eth3n");
    scripts\sp\utility::_id_15F1("cafe_color_yellow_move", "targetname");
  }
}

_id_EB59() {
  thread _id_EB58();
  thread _id_EB57();
  thread _id_EB56();
  thread _id_EB55();
}

_id_EB58() {
  level endon("failed_to_save_civies");
  level endon("player_saved_cafe_guys");
  level waittill("door_kick_open");
  scripts\engine\utility::flag_set("player_saved_cafe_guys");
}

_id_EB57() {
  level endon("failed_to_save_civies");
  level endon("player_saved_cafe_guys");
  level.player waittill("weapon_fired");
  scripts\engine\utility::flag_set("player_saved_cafe_guys");
}

_id_EB56() {
  level endon("failed_to_save_civies");
  level endon("player_saved_cafe_guys");

  while(_id_0B1E::_id_794C("cafe_peek_door") <= 45)
    wait 0.05;

  scripts\engine\utility::flag_set("player_saved_cafe_guys");
}

_id_EB55() {
  level endon("failed_to_save_civies");
  level endon("player_saved_cafe_guys");
  level waittill("door_peek_bash_open");
  scripts\engine\utility::flag_set("player_saved_cafe_guys");
}

_id_A5A5() {
  scripts\sp\utility::_id_178D(scripts\engine\utility::flag_wait, "player_saved_cafe_guys");
  level scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "door_kick_open");
  level scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "door_peek_airlock_ally_move");
  scripts\sp\utility::_id_57D6();
}

_id_59C3(var_0, var_1) {
  level endon("player_saved_cafe_guys");
  thread _id_11027(scripts\sp\utility::_id_22A2(var_0, var_1));
  var_2 = _id_0B1E::_id_794D("cafe_peek_door");
  var_3 = spawn("trigger_radius", var_2.origin, 0, 300, 128);
  var_3 waittill("trigger");
  thread _id_C9EA();
  wait 0.25;
  var_0[1] scripts\sp\utility::_id_10346("phstreets_fcv1_screamsatguns");

  if(!scripts\engine\utility::flag("start_peek_execution"))
    thread _id_36CA(var_0, var_1);

  scripts\engine\utility::flag_wait("start_peek_execution");
  var_1[1] thread scripts\sp\utility::_id_10346("phstreets_sf2_himfirst");
  wait 0.5;
  var_0[1] thread scripts\sp\utility::_id_10346("phstreets_fcv1_cryingjeneveux");
  wait 2.0;
  var_1[1] scripts\sp\utility::_id_10346("phstreets_sf2_shutherup");
  level notify("stop_all_peek_sounds");
}

_id_36CA(var_0, var_1) {
  level endon("start_peek_execution");
  level.player endon("death");
  var_0[2] scripts\sp\utility::_id_10346("phstreets_civ2_cryingpleadinga");
  wait 1.5;
  var_1[0] scripts\sp\utility::_id_10346("phstreets_sf1_eyesforwardallof");
  var_0[2] scripts\sp\utility::_id_10346("phstreets_civ1_cryingpleadingd");

  for(;;) {
    wait 2.0;
    var_0[2] scripts\sp\utility::_id_10346("phstreets_civ2_cryingpleadinga");
  }
}

_id_C9EA() {
  level.player _meth_82C2("phstreets_outside_cafe", "filter");
}

_id_C9E9() {
  wait 1.0;
  level.player clearclienttriggeraudiozone(0.9);
}

_id_11027(var_0) {
  level endon("stop_all_peek_sounds");
  level waittill("player_saved_cafe_guys");

  foreach(var_2 in var_0) {
    if(isalive(var_2))
      var_2 stopsounds();
  }
}

_id_3F97() {
  scripts\engine\utility::flag_wait("hill_player_in_bddy_door");

  if(isDefined(self))
    self delete();
}

_id_C9F6(var_0, var_1, var_2, var_3) {
  var_0 endon("death");
  scripts\sp\anim::_id_1EC3(var_0, "peek_execution");
  var_0 scripts\sp\utility::_id_F2A8(1);

  if(isDefined(var_3)) {
    level waittill("start_peek_execution");
    var_4 = var_3 gettagorigin("j_spine4");
    var_0 thread _id_68E7(var_4);
  } else
    level waittill("start_peek_execution");

  if(var_1)
    var_5 = 3.8;
  else
    var_5 = 4.1;

  var_4 = var_2 gettagorigin("j_spine4");
  var_0 thread _id_68E8(var_5, var_4);
  var_0 thread scripts\sp\utility::_id_C12D("disable_react", 5.0);
  thread _id_C9F5(var_0, var_1);
  thread scripts\sp\anim::_id_1F35(var_0, "peek_execution");
  var_6 = level scripts\engine\utility::waittill_any_return("failed_to_save_civies", "player_saved_cafe_guys");

  if(!var_1) {
    var_0 scripts\sp\utility::_id_F3DD(12);
    var_0 _meth_82EE(getnode("cafe_sdf0_cover", "targetname"));
    wait 3.0;
    var_0 scripts\sp\utility::_id_F3DD(1024);
  } else {
    var_0 scripts\sp\utility::_id_F3DD(12);
    var_0 _meth_82EE(getnode("cafe_sdf1_cover", "targetname"));
    wait 3.0;
    var_0 scripts\sp\utility::_id_F3DD(1024);
  }
}

_id_68E8(var_0, var_1) {
  level endon("player_saved_cafe_guys");
  self endon("death");
  wait(var_0);
  _id_68E7(var_1);
}

_id_68E7(var_0) {
  self endon("death");
  magicbullet(getweaponbasename(self.lastweapon), self gettagorigin("tag_flash"), var_0);
  bullettracer(self gettagorigin("tag_flash"), var_0, getweaponbasename(self.lastweapon), 1);
  wait 0.1;
  magicbullet(getweaponbasename(self.lastweapon), self gettagorigin("tag_flash"), var_0);
  bullettracer(self gettagorigin("tag_flash"), var_0, getweaponbasename(self.lastweapon), 1);
  wait 0.1;
  magicbullet(getweaponbasename(self.lastweapon), self gettagorigin("tag_flash"), var_0);
  bullettracer(self gettagorigin("tag_flash"), var_0, getweaponbasename(self.lastweapon), 1);
  level notify("failed_to_save_civies");
}

_id_C9F5(var_0, var_1) {
  var_0 endon("disable_react");
  var_0 endon("death");
  scripts\engine\utility::flag_wait("player_saved_cafe_guys");

  if(!var_1)
    var_0 scripts\engine\utility::delaythread(0.25, scripts\sp\utility::_id_10346, "SD_2_callout_contactclock_10");

  var_0 scripts\sp\anim::_id_1F35(var_0, "peek_execution_react");
}

_id_C9F4(var_0) {
  var_0 endon("death");

  if(var_0._id_1FBB == "peek_civ_1")
    scripts\sp\anim::_id_1EE0(var_0, "peek_execution");
  else {
    scripts\sp\anim::_id_1EC3(var_0, "peek_execution");
    level waittill("start_peek_execution");
    thread scripts\sp\anim::_id_1F35(var_0, "peek_execution");
    level scripts\engine\utility::waittill_any("player_saved_cafe_guys", "failed_to_save_civies");

    if(scripts\engine\utility::flag("player_saved_cafe_guys")) {
      var_0 setCanDamage(1);
      var_0 scripts\sp\utility::_id_F2A8(1);
      var_0._id_10265 = 1;
      var_0.forceragdollimmediate = 1;

      if(var_0._id_1FBB == "peek_civ_2") {
        var_0 scripts\sp\utility::anim_stopanimScripted();
        scripts\sp\anim::_id_1F35(var_0, "peek_execution_save");
        var_0 thread scripts\sp\anim::_id_1EEA(var_0, "peek_execution_save_loop", "forever");
        return;
      }

      thread scripts\sp\anim::_id_1EEA(var_0, "peek_execution_save", "forever");
      return;
      return;
    }

    level notify("failed_to_save_civies");
    var_0.noragdoll = 1;
    var_0.a.nodeath = 1;
    var_0.allowdeath = 1;
    scripts\sp\anim::_id_1F35(var_0, "peek_execution_death");
    scripts\sp\anim::_id_1EE0(var_0, "peek_execution_death");
  }
}

_id_F9FC(var_0, var_1, var_2) {
  var_3 = getspawner(var_0, "targetname");

  if(isDefined(var_2))
    var_3._id_ED1B = 1;

  var_4 = var_3 scripts\sp\utility::_id_10619(1);
  var_4._id_1FBB = var_1;
  return var_4;
}

_id_36B7() {
  level endon("ethen_flipping_table");
  thread _id_36B6();
  thread _id_33FD();
  var_0 = level.allies["eth3n"];
  var_1 = scripts\engine\utility::getStruct("cafe_stumble_struct", "targetname").origin;

  for(;;) {
    wait 0.05;

    if(level.player scripts\sp\utility::_id_3849(var_0.origin, 0) || level.player scripts\sp\utility::_id_3849(var_0.origin + (0, 0, 62), 0)) {
      var_0.moveplaybackrate = 1.0;
      continue;
    }

    var_0.moveplaybackrate = 1.2;
  }
}

_id_36B6() {
  level waittill("ethen_flipping_table");
  var_0 = level.allies["eth3n"];
  var_0.moveplaybackrate = 1.0;
}

_id_36C8() {}

_id_36C2() {
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC53("start_cafe_hacking");
  thread scripts\sp\maps\phstreets\phstreets::_id_F51C("med_battle", 1);
  var_0 = ["admiral", "salter", "eth3n"];
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC05("start_cafe_hacking", var_0);
  var_1 = getEntArray("cafe_hack_pristine_damage_door", "targetname");

  foreach(var_3 in var_1)
  var_3 hide();

  var_5 = getEntArray("cafe_hack_door_clip", "targetname");

  foreach(var_7 in var_5)
  var_7 hide();

  if(getdvarint("e3", 0) == 1) {
    scripts\engine\utility::delaythread(0.05, ::_id_10197, "dmg2");
    var_9 = getEnt("hack_window_clip", "targetname");

    if(isDefined(var_9)) {
      var_9 connectpaths();
      var_9 delete();
    }

    var_10 = getEnt("cafe_table", "targetname");
    var_11 = var_10 scripts\engine\utility::get_target_ent();
    var_10 delete();
    var_11 delete();
  }

  var_12 = getspawnerarray("cafe_civrunner_mainroom");

  foreach(var_14 in var_12)
  var_14 scripts\sp\utility::_id_1747(::_id_3FE3);

  thread _id_36AE();
  _id_8E73();
  scripts\sp\utility::_id_15F1("cafe_allies_to_mainroom", "targetname");

  if(getdvarint("e3", 0) == 0) {
    thread _id_36BE();
    thread _id_36B7();
  }

  var_16 = _id_0B1E::_id_794D("cafe_peek_door");
  level._id_36CC = var_16.angles;
}

_id_36C1() {
  thread _id_36C3();
  scripts\engine\utility::flag_wait("cafe_do_stumble");
  thread _id_5D4F();
  thread _id_36B4();
  scripts\engine\utility::flag_wait("pod_door_landed");
  level.player playRumbleOnEntity("grenade_rumble");
  earthquake(0.35, 0.75, level.player.origin, 200);
  thread _id_425F();
  scripts\sp\utility::_id_15F5("cafe_hacking_color");
  level.allies["salter"] scripts\sp\utility::_id_61ED();
  level.allies["admiral"] scripts\sp\utility::_id_61ED();
  var_0 = getEntArray("cafe_hack_pristine_door", "targetname");

  foreach(var_2 in var_0)
  var_2 hide();

  var_4 = getEntArray("cafe_hack_pristine_damage_door", "targetname");

  foreach(var_2 in var_4)
  var_2 show();

  scripts\engine\utility::flag_set("cafe_eth3n_flip_table");
  var_7 = getaiarray("axis");
  var_7 = scripts\sp\utility::array_removedeadvehicles(var_7);

  if(var_7.size > 0) {
    foreach(var_9 in var_7)
    var_9 _meth_81D0();
  }

  scripts\engine\utility::flag_wait("cafe_eth3n_holding_table");
  var_11 = getEnt("cafe_table_player_clip", "targetname");
  var_11 delete();
  var_11 = getEnt("cafe_table_door_clip", "targetname");
  var_11 delete();
  thread _id_82D5();
  thread _id_87D5();
  thread _id_87A6();
  thread _id_87D2();
  thread scripts\sp\maps\pearlharbor\pearlharbor_hill::_id_8F16();
  thread _id_E5B6();
  scripts\engine\utility::exploder("street_sparks");
  scripts\engine\utility::flag_wait("hacking_tutorial_finished");
  var_12 = getEnt("cafe_window_nav_clip", "targetname");
  var_12 connectpaths();
  var_12 delete();
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_8FC9();
  _id_0B0F::_id_19FF("hill_street_aiambient_trig");
  level.allies["admiral"] _meth_82EE(getnode("start_bus_admiral", "targetname"));
  level.allies["salter"] _meth_82EE(getnode("start_bus_salter", "targetname"));
  level.allies["eth3n"] _meth_82EE(getnode("start_bus_eth3n", "targetname"));
  level.allies["salter"] scripts\sp\utility::_id_551B();
  level.allies["admiral"] scripts\sp\utility::_id_551B();
  scripts\engine\utility::flag_wait("cafe_complete");
  thread _id_36B0();
}

_id_425F() {
  level endon("death");
  _id_1378B(getEnt("everyone_inside_cafe", "targetname"), level.allies);
  var_0 = _id_0B1E::_id_794D("cafe_peek_door");
  var_0 rotateTo(level._id_36CC, 0.25);
}

_id_1378B(var_0, var_1) {
  var_0 endon("death");

  if(!isarray(var_1))
    var_1 = [var_1];

  for(;;) {
    wait 0.1;
    var_2 = 1;

    foreach(var_4 in var_1) {
      if(!var_4 istouching(var_0)) {
        var_2 = 0;
        break;
      }
    }

    if(var_2) {
      break;
    }
  }
}

_id_36C3() {
  var_0 = level.allies["eth3n"];
  var_1 = level.allies["salter"];
  var_2 = level.allies["admiral"];
  scripts\engine\utility::flag_wait("pod_door_landed");
  var_1 stopsounds();
  wait 1.0;
  var_1 scripts\sp\utility::_id_10346("phstreets_slt_bots2");
  scripts\engine\utility::flag_wait("cafe_eth3n_holding_table");
  wait 1.25;
  var_0 scripts\sp\utility::_id_10346("phstreets_eth_usethishijackth");
  thread _id_67A3();
  scripts\engine\utility::flag_wait("player_got_hackdevice");
  level.player scripts\sp\utility::_id_10350("phstreets_plr_whatisit");
  var_0 scripts\sp\utility::_id_10346("phstreets_eth_youhavetohurryl");
  thread _id_33FC();
  level.player scripts\sp\utility::_id_65E3("is_hacked_robot");
  wait 1.8;
  level.player scripts\sp\utility::_id_1034D("phstreets_plr_okayimin");
  var_0 scripts\sp\utility::_id_10346("phstreets_eth_takethemoutquic");
  scripts\engine\utility::flag_wait("hacking_tutorial_finished");
  wait 2.0;
  var_2 scripts\sp\utility::_id_10346("phstreets_adm_goodworklieuten");
  level.player scripts\sp\utility::_id_10350("phstreets_plr_thankyousir");
  var_0 scripts\sp\utility::_id_10346("phstreets_eth_keepitsir");
  scripts\engine\utility::flag_set("cafe_vo_done");
  wait 4.0;

  if(!scripts\engine\utility::flag("cafe_complete"))
    var_2 scripts\sp\utility::_id_10346("phstreets_adm_letsadvance");
}

_id_67A3() {
  level endon("player_got_hackdevice");
  var_0 = 5.0;

  for(var_1 = 0.0; !scripts\engine\utility::flag("player_got_hackdevice"); var_1 = var_1 + var_0) {
    wait(randomfloatrange(5 + var_1, 7 + var_1));

    if(!level.player scripts\sp\utility::_id_65DB("is_hacked_robot"))
      level.allies["eth3n"] thread scripts\sp\utility::_id_10346("phstreets_eth_lieutenantthisl");

    wait(randomfloatrange(7 + var_1, 9 + var_1));

    if(!level.player scripts\sp\utility::_id_65DB("is_hacked_robot"))
      level.allies["eth3n"] thread scripts\sp\utility::_id_10346("phstreets_eth_usethishijackth");
  }
}

_id_36C0() {
  level endon("cafe_do_stumble");
  var_0 = getaiarray("axis");
  var_0 = scripts\sp\utility::array_removedeadvehicles(var_0);

  while(var_0.size > 0) {
    var_0 = getaiarray("axis");
    var_0 = scripts\sp\utility::array_removedeadvehicles(var_0);
    wait 0.1;
  }

  thread _id_33FD();
}

_id_36B3() {
  scripts\engine\utility::flag_wait("pod_door_landed");
  wait 0.2;
  level.player playgestureviewmodel("ges_frag_block", undefined, 1);
  var_0 = scripts\engine\utility::getStruct("cafe_stumble_struct", "targetname");
  var_1 = level.player getEye();
  var_2 = level.player getplayerangles();
  var_3 = distance(var_1, level.player.origin);
  var_4 = 46;
  var_5 = anglestoup(var_2);
  var_6 = var_1 + var_5 * -1 * var_3;

  if(level.player isjumping()) {
    var_7 = scripts\engine\utility::drop_to_ground(level.player.origin, 0, -300);
    var_8 = var_1[2] - var_7[2];
    var_9 = var_8 - var_3;
    var_6 = (var_6[0], var_6[1], var_6[2] - var_9);
  }

  var_10 = scripts\engine\utility::spawn_tag_origin(var_6, var_2);
  var_11 = var_10.origin + var_5 * var_3;
  var_12 = scripts\engine\utility::spawn_tag_origin(var_11, var_2);
  var_10 linkTo(var_12);
  var_13 = level.player getstance();

  if(var_13 == "stand") {
    level.player scripts\engine\utility::allow_crouch(0);
    level.player scripts\engine\utility::allow_prone(0);
  } else if(var_13 == "crouch") {
    level.player scripts\engine\utility::allow_stances(0);
    level.player scripts\engine\utility::allow_prone(0);
  } else {
    level.player scripts\engine\utility::allow_stances(0);
    level.player scripts\engine\utility::allow_crouch(0);
  }

  level.player _meth_823B(var_10);
  var_14 = vectorNormalize(scripts\engine\utility::flatten_vector(level.player.origin - var_0.origin));
  var_15 = anglestoright(var_0.angles);
  var_16 = vectordot(var_14, var_15);
  var_17 = -60;

  if(var_16 < 0)
    var_17 = 0 - var_17;

  var_18 = 0.3;
  var_19 = 0.3;
  var_20 = (50, var_0.angles[1] + var_17, var_0.angles[2]);
  var_12 rotateTo(var_20, var_18, 0.0, var_18 / 3);
  wait(var_18);
  scripts\engine\utility::flag_set("cafe_stumble_looking_down");
  wait(var_19);
  var_21 = 0.9;
  var_22 = 0.8;
  var_23 = scripts\engine\utility::getStruct("cafe_stumble_lookat", "targetname");
  var_24 = vectortoangles(var_23.origin - var_12.origin);
  var_12 rotateTo(var_24, var_21, 0.0, var_21 / 2);
  var_25 = (var_12.origin[0], var_12.origin[1], var_0.origin[2] + var_4);
  wait(var_21 + var_22);
  level.player unlink();

  if(var_13 == "stand") {
    level.player scripts\engine\utility::allow_crouch(1);
    level.player scripts\engine\utility::allow_prone(1);
  } else if(var_13 == "crouch") {
    level.player scripts\engine\utility::allow_stances(1);
    level.player scripts\engine\utility::allow_prone(1);
  } else {
    level.player scripts\engine\utility::allow_stances(1);
    level.player scripts\engine\utility::allow_crouch(1);
  }

  var_10 delete();
  var_12 delete();
}

_id_36B4() {
  level.player scripts\engine\utility::allow_sprint(0);
  scripts\engine\utility::flag_wait("pod_door_landed");
  level.player scripts\engine\utility::allow_sprint(1);
  earthquake(0.4, 1.0, level.player.origin, 9999);
  level.player scripts\engine\utility::delaycall(0.1, ::playgestureviewmodel, "ges_frag_block", undefined, 1);
  wait 0.1;
  level.player scripts\sp\utility::_id_2B76(0.3, 0.2);
  var_0 = scripts\engine\utility::getStruct("hack_door_impulse_struct", "targetname");
  thread ph_player_impulse_from_origin(var_0.origin, 60, 0.15, 0.3);
  wait 1.25;
  level.player scripts\sp\utility::_id_2B76(1.0, 0.5);
}

ph_player_impulse_from_origin(var_0, var_1, var_2, var_3) {
  var_4 = vectorNormalize(level.player.origin + (0, 0, 45) - var_0);
  var_5 = var_4 * var_1;
  thread ph_player_apply_impulse_internal(var_5, var_2, var_3);
}

ph_player_apply_impulse_internal(var_0, var_1, var_2) {
  ph_player_blend_push(var_0, var_1);
  ph_player_blend_push((0, 0, 0), var_2);
}

ph_player_blend_push(var_0, var_1) {
  level.player notify("new_push_impulse");
  level.player endon("new_push_impulse");

  if(!isDefined(level.player._id_DB0C))
    level.player._id_DB0C = (0, 0, 0);

  var_2 = level.player._id_DB0C;

  if(var_1 <= 0.05) {
    ph_set_player_push(var_0);
    return;
  }

  var_3 = var_0 - var_2;
  var_4 = var_3 * (1 / (var_1 + 0.05) * 0.05);

  while(var_1 > 0) {
    var_1 = var_1 - 0.05;
    ph_set_player_push(level.player._id_DB0C + var_4);
    wait 0.05;
  }

  ph_set_player_push(var_0);
}

ph_set_player_push(var_0) {
  level.player._id_DB0C = var_0;

  if(level.player isonground())
    level.player _meth_8251(var_0, 1);
  else
    level.player _meth_8251(var_0 * 0.3, 1);
}

_id_36BE() {
  level endon("pod_door_landed");
  var_0 = scripts\engine\utility::getStruct("cafe_ambient_droppods_origin", "targetname").origin;

  for(;;) {
    var_1 = randomfloatrange(500, 1600);
    var_2 = randomfloatrange(1500, 2700);
    var_3 = randomfloatrange(-1600, 1600);
    var_4 = var_0 + var_1 * anglesToForward(level.player.angles) + var_2 * anglestoup(level.player.angles) + var_3 * anglestoright(level.player.angles);
    thread _id_36BD(var_4);
    wait(randomfloatrange(2.5, 5.5));
  }
}

_id_36BD(var_0) {
  playworldsound("droppod_incoming", var_0);
  wait 1.5;
  playworldsound("droppod_land_impact_dist", var_0);
  earthquake(0.15, 1.0, level.player.origin, 9999);
}

_id_87D5() {
  thread _id_24CF();
  level._id_36BB = 0;
  var_0 = 5;
  var_1 = 1;

  for(var_2 = 0; var_2 < var_0; var_2++) {
    level.player thread _id_3D87();
    level.player scripts\sp\utility::_id_65E3("is_hacked_robot");
    var_3 = getaiarray("axis").size;

    if(var_1) {
      thread _id_3D7A();
      var_1 = 0;
    }

    level.player scripts\sp\utility::_id_65E8("is_hacked_robot");
    level notify("stop_checking_for_damage");

    if(!scripts\engine\utility::flag("hacked_robot_dealt_damage")) {
      var_2--;
      var_4 = level.player getammocount("hackingdevice");
      level.player setweaponammostock("hackingdevice", var_4 + 1);
    }

    scripts\engine\utility::flag_clear("hacked_robot_dealt_damage");
    var_5 = getaiarray("axis").size;

    if(var_5 < var_3) {
      if(level._id_36BB == 1) {
        break;
      }
    }

    if(var_5 <= 0) {
      break;
    }
  }

  level notify("stop_monitoring_bot_status");
  scripts\engine\utility::flag_set("cafe_score_reached");
  scripts\engine\utility::flag_set("hacking_tutorial_finished");
  scripts\engine\utility::flag_set("stop_cafe_nags");
  scripts\sp\utility::_id_229F(getaiarray("axis"));
  level._id_36BB = undefined;
}

_id_3D87() {
  var_0 = getEnt("cafe_hacking_area", "targetname");
  level.player scripts\sp\utility::_id_65E3("is_hacked_robot");
  level.player scripts\sp\utility::_id_65E8("is_controlling_robot");

  if(level.player istouching(var_0))
    level._id_36BB = 1;
  else
    return;

  var_1 = scripts\engine\utility::getStruct("cafe_hack_return_pos", "targetname");
  _id_0E29::_id_87E1(var_1.origin, var_1.angles);
}

_id_3D7A() {
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0)
  var_2 thread _id_3D7B();
}

_id_3D7B() {
  level endon("stop_checking_for_damage");
  self endon("death");
  thread _id_3D7C();
  self waittill("damage");

  if(isDefined(self._id_8804)) {
    return;
  }
  scripts\engine\utility::flag_set("hacked_robot_dealt_damage");
  wait 0.05;
  level notify("stop_checking_for_damage");
}

_id_3D7C() {
  level endon("stop_checking_for_damage");
  self waittill("death");

  if(isDefined(self._id_8804)) {
    return;
  }
  scripts\engine\utility::flag_set("hacked_robot_dealt_damage");
}

_id_24CF() {
  level endon("stop_monitoring_bot_status");

  for(;;) {
    scripts\engine\utility::flag_wait("hacked_robot_dealt_damage");
    var_0 = getaiarray("axis");

    foreach(var_2 in var_0)
    var_2 thread _id_15E3();

    scripts\engine\utility::flag_waitopen("hacked_robot_dealt_damage");
  }
}

_id_15E3() {
  self endon("death");
  var_0 = randomfloatrange(1.5, 4);
  wait(var_0);

  if(isalive(self)) {
    self clearentitytarget();
    self notify("stop_attack_fake_cafe_target");
  }

  scripts\engine\utility::flag_waitopen("hacked_robot_dealt_damage");

  if(isalive(self))
    thread _id_24B5();
}

_id_87D2() {
  scripts\engine\utility::flag_wait("cafe_eth3n_idling2");
  var_0 = scripts\sp\utility::_id_107EA("hack_robot_banger", 1);
  var_1 = scripts\engine\utility::getStruct("hack_banger_animstruct", "targetname");
  var_1.origin = var_1.origin - anglesToForward(var_1.angles) * 12.0;
  var_0 scripts\sp\utility::_id_F2A8(1);
  var_1 thread scripts\sp\anim::_id_1ECC(var_0, "hack_punch_table");
}

_id_33FD() {
  level.allies["eth3n"]._id_DD21 = 1;
  var_0 = scripts\engine\utility::getStruct("cafe_animNode", "targetname");
  var_1 = getEnt("cafe_table", "targetname");
  var_1._id_1FBB = "cafe_table";
  var_2 = var_1 scripts\engine\utility::get_target_ent();
  var_3 = level.allies["eth3n"].goalradius;
  var_4 = scripts\engine\utility::getStruct("cafe_traversal_nav_ob", "targetname");
  var_1 thread _id_113C6();
  var_2 linkTo(var_1);
  var_1 scripts\sp\anim::_id_F64A();
  level.allies["eth3n"] scripts\engine\utility::waittill_any("anim_reach_complete", "ethen_teleport_to_table_flip");
  scripts\engine\utility::flag_wait("cafe_do_stumble");
  var_5 = [];
  var_5["cafe_tablae"] = var_1;
  var_5["eth3n"] = level.allies["eth3n"];
  thread _id_365C(var_0, var_5);
  scripts\engine\utility::flag_wait("cafe_eth3n_flip_table");
  var_6 = createnavobstaclebybounds(var_4.origin, (12, 12, 50), (0, 0, 0));
  level notify("ethen_flipping_table");
  level waittill("ethen_intro_done");
  var_7 = thread scripts\engine\utility::play_loopsound_in_space("scn_phstreets_cafe_table_bullet_impacts", (68240, 40406, -34356));
  scripts\engine\utility::flag_set("cafe_eth3n_idling");
  var_8 = ["forward_anim", "right_anim", "rightback_anim"];
  var_0 thread scripts\sp\anim::_id_2B8C(var_5["eth3n"], level.player, var_8, "stop_table_loop");
  var_0 thread scripts\sp\anim::_id_1EEA(var_5["cafe_tablae"], "cafe_table_idle", "stop_table_loop");
  scripts\engine\utility::flag_wait("player_got_hackdevice");
  var_0 notify("stop_table_loop");
  var_0 scripts\sp\anim::_id_1F2C(var_5, "cafe_table");
  scripts\engine\utility::flag_set("cafe_eth3n_idling2");
  var_0 thread scripts\sp\anim::_id_1EE7(var_5, "cafe_table_idle", "stop_table_loop");
  scripts\engine\utility::flag_wait("hacking_tutorial_finished");
  var_7 stoploopsound();
  var_9 = getaiarray("axis");

  foreach(var_11 in var_9)
  var_11 _meth_81D0();

  var_0 notify("stop_table_loop");
  scripts\engine\utility::delaythread(0.05, ::_id_10197, "dmg2");
  var_13 = getEnt("hack_window_clip", "targetname");

  if(isDefined(var_13)) {
    var_13 connectpaths();
    var_13 delete();
  }

  destroynavobstacle(var_6);
  level.allies["eth3n"] thread scripts\sp\utility::_id_77B9(1);
  var_0 scripts\sp\anim::_id_1F2C(var_5, "cafe_table_outro");
  level.allies["eth3n"] scripts\sp\utility::_id_F3DD(var_3);
  level.allies["eth3n"]._id_DD21 = undefined;
}

_id_365C(var_0, var_1) {
  level.allies["eth3n"] scripts\sp\utility::_id_F3DD(32);
  var_0 thread scripts\sp\anim::_id_1F17(level.allies["eth3n"], "cafe_table_intro");
  wait 0.25;
  var_2 = scripts\engine\utility::getStruct("cafe_stumble_struct", "targetname");
  var_3 = anglesToForward(var_2.angles);
  var_4 = anglesToForward(level.player getplayerangles());

  if(vectordot(var_3, var_4) > 0 && !level.player scripts\sp\utility::_id_3849(var_2.origin + (0, 0, 4), 0) && !level.player scripts\sp\utility::_id_3849(var_2.origin + (0, 0, 62), 0)) {
    var_0 scripts\engine\utility::delaythread(0.05, scripts\sp\anim::_id_1F27, var_1, "cafe_table_intro", 1.3);
    var_0 scripts\engine\utility::delaythread(3.5, scripts\sp\anim::_id_1F27, var_1, "cafe_table_intro", 2.0);
    thread scripts\engine\utility::flag_set_delayed("cafe_eth3n_holding_table", 3.0);
    var_0 scripts\sp\anim::_id_1F2C(var_1, "cafe_table_intro");
    level notify("ethen_intro_done");
  } else {
    level.allies["eth3n"] scripts\engine\utility::waittill_notify_or_timeout("anim_reach_complete", 2.0);
    var_0 scripts\engine\utility::delaythread(0.05, scripts\sp\anim::_id_1F27, var_1, "cafe_table_intro", 1.3);
    var_0 scripts\engine\utility::delaythread(3.5, scripts\sp\anim::_id_1F27, var_1, "cafe_table_intro", 2.0);
    thread scripts\engine\utility::flag_set_delayed("cafe_eth3n_holding_table", 3.0);
    var_0 scripts\sp\anim::_id_1F2C(var_1, "cafe_table_intro");
    level notify("ethen_intro_done");
  }
}

_id_33FE(var_0) {}

_id_10197(var_0) {
  var_1 = getscriptablearray("cafe_hack_shutter", "targetname")[0];
  var_1 setscriptablepartstate("shutter", var_0);
}

_id_82D5() {
  var_0 = spawn("script_model", level.allies["eth3n"].origin);
  var_0 setModel("gauntlet_wm");
  var_0 linkTo(level.allies["eth3n"], "j_mid_ri_1", (0, 0, 0), (0, 0, -90));
  wait 1.1;
  level.allies["eth3n"] _id_0E46::_id_48C4("J_Wrist_RI", (0, 0, 0), &"PHSTREETS_HACKING_DEVICE", undefined, 10000);
  level.allies["eth3n"] _id_0E46::_id_9016();
  level.allies["eth3n"] notify("player_can_hack");
  var_0 delete();
  _id_10883();
  level.player giveweapon("hackingdevice");
  level.player playSound("scn_phstreets_cafe_grab_hack_device");
  _id_0A2F::_id_66A4("hackingdevice");
  thread scripts\sp\utility::_id_266F();
  scripts\engine\utility::flag_set("player_got_hackdevice");
  scripts\sp\utility::_id_56BA("hint_start_hack");
  thread _id_D31D();
}

_id_10883() {
  var_0 = scripts\sp\utility::_id_7C3D();
  var_1 = scripts\sp\utility::_id_7C3E();

  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_1)) {
    return;
  }
  if(var_1 == 0) {
    return;
  }
  var_2 = spawnStruct();
  var_2.origin = level.player.origin;
  var_2.script_noteworthy = var_0 + "_pickup";
  var_2._id_EDE7 = var_1;
  var_2 thread _id_0B04::_id_4842("equipment", 0);
}

_id_900B() {
  if(scripts\engine\utility::flag("player_used_hackdevice"))
    return 1;

  return 0;
}

_id_D31D() {
  while(!level.player secondaryoffhandbuttonPressed())
    wait 0.05;

  scripts\engine\utility::flag_set("player_used_hackdevice");
}

_id_33FC() {
  level endon("stop_cafe_nags");
  var_0 = 5.0;

  for(var_1 = 0.0; !scripts\engine\utility::flag("stop_cafe_nags"); var_1 = var_1 + var_0) {
    wait(randomfloatrange(7 + var_1, 10 + var_1));

    if(!level.player scripts\sp\utility::_id_65DB("is_hacked_robot"))
      level.allies["eth3n"] thread scripts\sp\utility::_id_10346("phstreets_eth_hijackonethroug");
    else
      level.player scripts\sp\utility::_id_65E8("is_hacked_robot");

    wait(randomfloatrange(7 + var_1, 10 + var_1));

    if(!level.player scripts\sp\utility::_id_65DB("is_hacked_robot")) {
      level.allies["eth3n"] thread scripts\sp\utility::_id_10346("phstreets_eth_werestillpinned");
      continue;
    }

    level.player scripts\sp\utility::_id_65E8("is_hacked_robot");
  }
}

_id_577C(var_0) {
  wait 1.6;
  var_0._id_D601 = scripts\sp\vehicle::_id_1080C("cafe_hack_pod_01");
  var_0._id_D601._id_1FBB = "cafe_pod";
  var_0._id_1684[var_0._id_1684.size] = var_0._id_D601;
  var_0._id_D601 thread _id_D603();
  level._id_D5FE = var_0._id_D601;
  wait 0.4;
  var_0._id_D5FF = scripts\sp\vehicle::_id_1080C("cafe_hack_pod_00");
  var_0._id_D5FF._id_1FBB = "cafe_pod2";
  var_0._id_1684[var_0._id_1684.size] = var_0._id_D5FF;
  var_0._id_D5FF thread _id_D604();
  level._id_D5FF = var_0._id_D5FF;
}

_id_5D4F() {
  level._id_36C6 = [];
  scripts\sp\utility::_id_22C9("cafe_hack_pod", ::_id_36BA);
  scripts\sp\utility::_id_22CA("cafe_hack_pod_door", ::_id_36B9);
  var_0 = scripts\sp\vehicle::_id_1080C("cafe_hack_pod_door");
  var_0 thread _id_D60A();
  level._id_36C6[level._id_36C6.size] = var_0;
  wait 2.0;
  var_1 = scripts\sp\vehicle::_id_1080C("cafe_hack_pod_01");
  var_1 thread _id_D604();
  level._id_36C6[level._id_36C6.size] = var_1;
  wait 1.0;
  var_0 = scripts\sp\vehicle::_id_1080C("cafe_hack_pod_00");
  var_0 thread _id_D603();
  level._id_36C6[level._id_36C6.size] = var_0;
}

_id_36BA() {
  self._id_93D4 = "droppod_c6_reveal_incoming_dist_close";
}

_id_36B9() {
  self._id_93D4 = "scn_phstreets_droppod_cafe_incoming_dist_close";
  self._id_934A = "scn_phstreets_droppod_cafe_impact";
}

_id_8E73() {
  var_0 = getEntArray("cafe_pod_destruction_01", "targetname");
  var_1 = getEntArray("cafe_pod_destruction_02", "targetname");
  var_2 = scripts\sp\utility::_id_22A2(var_0, var_1);

  foreach(var_4 in var_2)
  var_4 hide();

  var_6 = getEntArray("cafe_pod_destruction_door", "targetname");

  foreach(var_8 in var_6)
  var_8 hide();
}

_id_D60A() {
  scripts\engine\utility::delaythread(0.2, ::_id_B15D);
  wait 0.5;
  var_0 = scripts\sp\hud_util::_id_48B9("white", 0.25, 1, 1, 2);
  var_0 fadeovertime(2.0);
  var_0.alpha = 0;
  _id_0B0A::_id_583F(1, 1, 0, 0, 40, 5, 0.05);
  scripts\engine\utility::delaythread(0.3, _id_0B0A::_id_583D, 1.0);
  level.allies["eth3n"] notify("ethen_teleport_to_table_flip");
  self waittill("landed");
  scripts\engine\utility::flag_set("pod_door_landed");
  var_1 = getEnt("cafe_table", "targetname");
  glassradiusdamage(var_1.origin + (0, 0, 64), 20000, 1000, 1000);
  scripts\engine\utility::exploder("hacking_droppod_door_debris");
  var_2 = getEntArray("cafe_hack_door_clip", "targetname");

  foreach(var_4 in var_2)
  var_4 show();

  var_6 = getEntArray("cafe_pod_destruction_door", "targetname");

  foreach(var_8 in var_6)
  var_8 show();

  var_10 = getEnt("cafe_pod_prestine_03", "targetname");
  var_10 hide();
  self waittill("entitydeleted");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA01(var_10);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA01(var_1);
  scripts\sp\utility::_id_228A(var_6);
  scripts\sp\utility::_id_228A(var_2);
}

_id_D603() {
  self waittill("landed");
  self notify("pop_doors");
  scripts\engine\utility::flag_set("pod_1_landed");
  var_0 = getEntArray("cafe_pod_destruction_02", "targetname");

  foreach(var_2 in var_0)
  var_2 show();

  var_4 = getEntArray("cafe_pod_prestine_02", "targetname");

  foreach(var_2 in var_4)
  var_2 hide();

  self waittill("entitydeleted");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA02(var_0);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA02(var_4);
}

_id_D604() {
  self waittill("landed");
  self notify("pop_doors");
  scripts\engine\utility::flag_set("pod_2_landed");
  var_0 = getEntArray("cafe_pod_destruction_01", "targetname");

  foreach(var_2 in var_0)
  var_2 show();

  var_4 = getEntArray("cafe_pod_prestine_01", "targetname");

  foreach(var_2 in var_4)
  var_2 hide();

  self waittill("entitydeleted");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA02(var_0);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA02(var_4);
}

_id_E5B6() {
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    var_2 scripts\sp\utility::_id_F415(0);
    var_2 thread _id_24B5();
  }
}

_id_B264() {
  var_0 = getEntArray("cafe_fake_target", "targetname");

  foreach(var_2 in var_0)
  var_2 makeentitysentient("allies");
}

_id_24B5() {
  self endon("death");
  self endon("stop_attack_fake_cafe_target");
  thread _id_24B6();

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "hack_robot")
    var_0 = scripts\engine\utility::getStructArray("cafe_fake_target", "targetname");
  else
    var_0 = scripts\engine\utility::getStructArray("cafe_fake_target_left", "targetname");

  self._id_6B56 = scripts\engine\utility::spawn_tag_origin();

  for(;;) {
    if(var_0.size == 0) {
      wait 0.2;

      if(isDefined(self.script_noteworthy) && self.script_noteworthy == "hack_robot")
        var_0 = scripts\engine\utility::getStructArray("cafe_fake_target", "targetname");
      else
        var_0 = scripts\engine\utility::getStructArray("cafe_fake_target_left", "targetname");

      continue;
    }

    var_1 = var_0[randomint(var_0.size)];

    if(!scripts\common\trace::ray_trace_passed(self.origin + (0, 0, 60), var_1.origin, self, scripts\common\trace::create_solid_ai_contents(1))) {
      var_0 = scripts\engine\utility::array_remove(var_0, var_1);
      wait 0.05;
      continue;
    }

    if(!isDefined(self._id_6B56))
      self._id_6B56 = scripts\engine\utility::spawn_tag_origin();

    self._id_6B56.origin = var_1.origin;
    self _meth_82DE(self._id_6B56);
    var_2 = randomfloatrange(1.0, 3.0);
    wait(var_2);
  }
}

_id_24B6() {
  scripts\engine\utility::waittill_any("death", "stop_attack_fake_cafe_target");
  self._id_6B56 delete();
}

_id_B15D() {
  var_0 = scripts\engine\utility::getStruct("hack_intro_window_bullet", "targetname");
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
  level thread scripts\sp\utility::_id_C12D("stop_magic_firing_window_intro", 2.0);
  level.player endon("death");
  level endon("stop_magic_firing_window_intro");
  scripts\engine\utility::delaythread(0.2, ::_id_10197, "dmg1");

  for(;;) {
    var_2 = var_1[randomint(var_1.size)];
    magicbullet("iw7_ar57", var_0.origin, var_2.origin);
    wait 0.1;
  }
}

_id_87A6() {
  var_0 = _id_0E29::_id_87F3();

  if(isDefined(var_0._id_1389E)) {
    var_0 _meth_83A1();
    var_0 _meth_83B9(var_0.origin, var_0.angles + (0, 95, 0));
  }

  var_1 = var_0.origin + anglesToForward(var_0.angles) * 45;
  var_2 = var_0.angles + (0, 180, 0);
  var_3 = scripts\sp\utility::_id_77DA("hack_exterior_civs");
  var_4 = scripts\engine\utility::random(var_3);
  var_5 = var_4.origin;
  var_4 _meth_83B9(var_1, var_2);
  var_4._id_1FBB = "generic";
  var_4 scripts\sp\anim::_id_1EC3(var_4, "hack_forced_civ");
  wait 0.2;
  var_4 scripts\sp\anim::_id_1F35(var_4, "hack_forced_civ");
  var_6 = getnode("forced_civ_node", "targetname");

  if(isDefined(var_6)) {
    var_4 _meth_82EE(var_6);
    var_4.fixednode = 1;
  } else
    var_4 setgoalpos(var_5);
}

_id_36BF() {
  scripts\engine\utility::flag_set("player_got_hackdevice");
  scripts\engine\utility::flag_set("player_opened_cafe_exit");
  scripts\engine\utility::flag_set("cafe_vo_done");
  scripts\engine\utility::flag_set("cafe_complete");
  getEnt("aatis_tower_periph", "targetname") delete();
  getEnt("cafe_window_nav_clip", "targetname") delete();
  thread _id_36B0();
  scripts\engine\utility::exploder("street_sparks");
}

_id_36B0() {
  scripts\engine\utility::flag_wait("hill_player_in_bddy_door");
  var_0 = _id_0B1E::_id_794D("cafe_peek_door");
  var_1 = getEnt("cafe_hack_pod_00", "targetname");
  var_2 = getEnt("cafe_hack_pod_01", "targetname");
  var_3 = getEnt("cafe_hack_pod_02", "targetname");
  var_4 = getscriptablearray("cafe_shutter", "targetname")[0];
  var_5 = getEnt("cafe_table", "targetname");
  var_6 = var_5 scripts\engine\utility::get_target_ent();
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA01(var_5);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA01(var_6);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA01(var_0);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA01(var_1);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA01(var_2);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA01(var_3);
  wait 0.05;

  if(isDefined(level._id_D5FD))
    level._id_D5FD _id_0BBB::_id_514A();

  if(isDefined(level._id_D5FE))
    level._id_D5FE _id_0BBB::_id_514A();

  if(isDefined(level._id_D5FF))
    level._id_D5FF _id_0BBB::_id_514A();

  if(isDefined(level._id_D600))
    level._id_D600 _id_0BBB::_id_514A();

  level._id_D5FD = undefined;
  level._id_D5FE = undefined;
  level._id_D5FF = undefined;
  level._id_D600 = undefined;

  if(isDefined(level._id_36C6)) {
    foreach(var_8 in level._id_36C6)
    var_8 _id_0BBB::_id_514A();
  }

  level._id_36C6 = undefined;
  level._id_6F36 = undefined;
  level._id_878B = undefined;
  level._id_878A = undefined;
  level._id_87BF = undefined;
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA01(var_4);
  wait 0.05;
  var_10 = getEntArray("cafe_hack_pristine_door", "targetname");
  var_11 = getEntArray("cafe_hack_pristine_damage_door", "targetname");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA02(var_10);
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA02(var_11);

  if(isDefined(level._id_878B)) {
    foreach(var_13 in level._id_878B)
    scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA01(var_13);
  }

  scripts\engine\utility::flag_set("pod_door_landed");
}

_id_1C04() {
  self endon("death");
  wait 0.25;
  self playSound("scn_phstreets_double_jump_enemy");
  wait 1.0;
  self playSound("scn_phstreets_double_jump_stop_enemy");
}

_id_E57C() {
  var_0 = getEntArray("robot_combat_turrets", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_0349))
      var_2 settoparc(var_2._id_0349);

    if(isDefined(var_2._id_006B))
      var_2 setbottomarc(var_2._id_006B);

    if(isDefined(var_2._id_01B8))
      var_2 setleftarc(var_2._id_01B8);

    if(isDefined(var_2.rightarc))
      var_2 setrightarc(var_2.rightarc);
  }
}

_id_E5BE() {
  scripts\engine\utility::flag_wait("cafe_complete");
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EF26("robots_scriptable_cars");
  _id_3379();
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA02(getEntArray("c6_reveal_droppod_impact_prestine", "targetname"));
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA02(getEntArray("c6_reveal_droppod_impact_dmg", "targetname"));
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA02(getEntArray("robot_combat_turrets", "script_noteworthy"));
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_EA02(getEntArray("robot_combat_placed_weapons", "script_noteworthy"));
  level notify("robot_combat_crate_cleanup");
  level._id_6AFE = undefined;
  level._id_5F56 = undefined;
  level._id_5F3C = undefined;
  level._id_5F3D = undefined;
  level._id_5F3E = undefined;
  level._id_5F3F = undefined;
  level._id_5F40 = undefined;
  level._id_5F41 = undefined;
  level._id_5F42 = undefined;
  level._id_5F43 = undefined;
  level._id_5F44 = undefined;
  level._id_5F45 = undefined;
  level._id_5F46 = undefined;
  level._id_5F47 = undefined;
  level._id_5F48 = undefined;
  level._id_5F49 = undefined;
  level._id_5F4A = undefined;
  level._id_5F4B = undefined;
  level._id_5F4C = undefined;
  level._id_5F4D = undefined;
  level._id_5F4E = undefined;
  level._id_5F4F = undefined;
}