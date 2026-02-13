/************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_papq.gsc
************************************************************/

init() {
  _id_099C::_id_C211("osspapq", 1, ::init_find_pap, ::do_find_pap, ::cleanup_find_pap, ::debug_find_pap);
  _id_099C::_id_C211("osspapq", 2, ::init_collect_parts, ::do_collect_parts, ::cleanup_collect_parts, ::debug_collect_parts);
  _id_099C::_id_C211("osspapq", 3, ::init_final_fight, ::do_final_fight, ::cleanup_final_fight, ::debug_final_fight);
  level._effect["papq_echo_zmb_trail"] = loadfx("vfx/s4/zombie/vfx_pap_charge_taril");
  level._effect["papq_aether_ambient_fx_01"] = loadfx("vfx/s4/zombie/vfx_pap_aether_mote");
  level._effect["papq_aether_ambient_fx_02"] = loadfx("vfx/s4/zombie/vfx_pap_aether_stream");
  level._effect["papq_pap_charge_fx_01"] = loadfx("vfx/s4/level/cp_zm_oasis/vfx_pap_machine_energy_01");
  level._effect["papq_pap_charge_fx_02"] = loadfx("vfx/s4/level/cp_zm_oasis/vfx_pap_machine_energy_02");
  level._effect["papq_pap_charge_fx_03"] = loadfx("vfx/s4/level/cp_zm_oasis/vfx_pap_machine_energy_03");
  level._effect["papq_pap_charge_fx_04"] = loadfx("vfx/s4/level/cp_zm_oasis/vfx_pap_machine_energy_04");
  level._effect["papq_pap_charge_ambient_top"] = loadfx("vfx/s4/level/cp_zm_oasis/vfx_pap_parts_smk_top");
  level._effect["papq_pap_charge_ambient_med"] = loadfx("vfx/s4/level/cp_zm_oasis/vfx_pap_parts_smk_mid");
  level._effect["papq_pap_charge_ambient_btm"] = loadfx("vfx/s4/level/cp_zm_oasis/vfx_pap_parts_smk_btm");
  level._effect["papq_pap_merge"] = loadfx("vfx/s4/level/cp_zm_oasis/vfx_pap_parts_merge");
  level._effect["papq_pap_part_move"] = loadfx("vfx/s4/level/cp_zm_oasis/vfx_pap_parts_show_smk");
  _id_06CB::_id_AA4E(::onplayerconnect);
}

onplayerconnect() {
  thread papq_hint_watcher();
}

init_find_pap() {
  level.a_mdl_paps = [];
  level.set_pap_mdl_override_func = ::set_pap_machine_model;
  level thread set_pap_unlock();
  level.s_pap_center = scripts\engine\utility::getstruct("papq_pap_center", "script_noteworthy");
  level.s_pap_center.mdl_fx = scripts\cp\utility::_id_E190("tag_origin", level.s_pap_center.origin, level.s_pap_center.angles);
  level.a_mdl_echo_zombies = [];
  level.a_mdl_echo_juggs = [];
  level.s_altar_loc = scripts\engine\utility::getstruct("mq_altar_end_loc", "script_noteworthy");
  level.s_altar_loc _id_0FFD("obj_search_temple", "");
  level thread spawn_echo_zombies();
  level thread pap_distance_watch();
  level thread set_up_aether_aeras();
  level thread find_oasis_pap();
  level thread buy_door_watcher();
  level thread show_explore_temple_hint();
  level thread remove_pap_machine_marker();
  level thread exfil_start_watcher();
  stream_pap_model();
  set_up_loot_crystals();
}

do_find_pap() {
  level waittill("papq_step_one_done");
}

cleanup_find_pap() {
  level.s_altar_loc cleanup_marker("obj_search_temple");
}

debug_find_pap() {
  level notify("papq_step_one_done");
}

set_pap_unlock() {
  level endon("game_ended");
  wait 1;
  level._id_AE13 = 0;
}

stream_pap_model() {
  level.stream_mdl_echo_pap = scripts\cp\utility::_id_E190("s4_zm_machine_weapon_rig_echo", level.s_pap_center.origin + (0, 0, -200));
  level.stream_mdl_solid_pap = scripts\cp\utility::_id_E190("s4_zm_machine_weapon_dim", level.s_pap_center.origin + (0, 0, -200));
}

set_pap_machine_model(var_0) {
  level endon("game_ended");

  if(isDefined(level.mdl_oasis_pap)) {
    return;
  }
  if(!scripts\engine\utility::array_contains(level.a_mdl_paps, var_0._id_9923)) {
    level.a_mdl_paps = scripts\engine\utility::array_add(level.a_mdl_paps, var_0._id_9923);
  }

  level waittill("papq_main_pap_found");

  if(!scripts\engine\utility::is_equal(var_0._id_9923, level.mdl_oasis_pap)) {
    return;
  }
  var_0._id_9923 setModel("s4_zm_machine_weapon_rig_echo");
  var_0._id_9923 _meth_82CB("s4_zm_machine_weapon_set_idle_01_anim");
  playFXOnTag(level._effect["papq_pap_charge_ambient_btm"], var_0._id_9923, "tag_btm");
  var_0._id_9923 thread return_top_part_watcher();
  var_0._id_9923 thread return_med_part_watcher();
  level waittill("papq_parts_returned");
  level waittill("papq_step_three_done");
  var_0._id_9923 setModel("s4_zm_machine_weapon_rig_echo");
  wait 2;
  var_0._id_9923 _meth_82CB("s4_zm_machine_weapon_set_off_anim");
  var_0._id_9923 thread play_pap_merge_fx();
  wait 0.5;
  var_0._id_9923 setModel("s4_zm_machine_weapon_dim");
  var_0._id_9923 _meth_82CB("s4_zm_fxanim_pap_idle_anim");
  playFXOnTag(scripts\engine\utility::getfx("pap_idle"), var_0._id_9923, "tag_origin");

  if(_func_0205("zmb_pap_idle_lp")) {
    var_0._id_9923 playLoopSound("zmb_pap_idle_lp");
  }
}

return_top_part_watcher() {
  level endon("game_ended");
  level waittill("papq_top_part_returned");

  if(scripts\engine\utility::is_equal(level.n_part_collected, 1)) {
    self _meth_82CB("s4_zm_machine_weapon_set_idle_03_anim");
    playFXOnTag(level._effect["papq_pap_charge_ambient_top"], self, "tag_top");
  } else if(scripts\engine\utility::is_equal(level.n_part_collected, 2)) {
    self _meth_82CB("s4_zm_machine_weapon_set_idle_anim");
    playFXOnTag(level._effect["papq_pap_charge_ambient_top"], self, "tag_top");
  }
}

return_med_part_watcher() {
  level endon("game_ended");
  level waittill("papq_med_part_returned");

  if(scripts\engine\utility::is_equal(level.n_part_collected, 1)) {
    self _meth_82CB("s4_zm_machine_weapon_set_idle_02_anim");
    playFXOnTag(level._effect["papq_pap_charge_ambient_med"], self, "tag_mid");
  } else if(scripts\engine\utility::is_equal(level.n_part_collected, 2)) {
    self _meth_82CB("s4_zm_machine_weapon_set_idle_anim");
    playFXOnTag(level._effect["papq_pap_charge_ambient_med"], self, "tag_mid");
  }
}

find_oasis_pap() {
  level endon("game_ended");
  level endon("papq_step_one_done");
  wait 1;
  level.mdl_oasis_pap = scripts\engine\utility::_id_6969(level.s_pap_center.origin, level.a_mdl_paps, 500);
  level notify("papq_main_pap_found");
}

play_pap_merge_fx() {
  level endon("game_ended");
  wait 0.5;
  playFX(level._effect["papq_pap_merge"], level.s_pap_center.origin);
}

spawn_echo_zombies() {
  level endon("game_ended");
  level endon("papq_step_one_done");
  var_0 = scripts\engine\utility::getstructarray("papq_echo_zmb_spawn_loc", "script_noteworthy");
  var_1 = scripts\engine\utility::getstructarray("papq_echo_jugg_spawn_loc", "script_noteworthy");
  var_2 = ["iw7_cp_king_idle_03", "iw7_cp_king_idle_nostaff_01", "ai_s4_zm_zombie_screamer_idle_unaware_01", "ai_s4_zm_zombie_screamer_idle_unaware_03"];
  wait 3;

  foreach(var_4 in var_0) {
    var_5 = scripts\cp\utility::_id_E190(var_4._id_CD99, var_4.origin, var_4.angles);
    level.a_mdl_echo_zombies = scripts\engine\utility::array_add(level.a_mdl_echo_zombies, var_5);
    waitframe();
    var_5 _meth_82CB(var_2[randomint(var_2.size)]);
    var_5 playLoopSound("zmb_zom_ethereal_lp");
  }

  foreach(var_4 in var_1) {
    var_5 = scripts\cp\utility::_id_E190("zom_juggernaut_wholebody_ghost", var_4.origin, var_4.angles);
    level.a_mdl_echo_juggs = scripts\engine\utility::array_add(level.a_mdl_echo_juggs, var_5);
    waitframe();
    var_5 _meth_82CB("ai_s4_zm_zombie_juggernaut_idle_03");
    var_5 playLoopSound("zmb_zom_ethereal_lp");
  }
}

pap_distance_watch() {
  level endon("game_ended");
  level endon("papq_step_one_done");
  wait 5;

  for(;;) {
    foreach(var_1 in level.players) {
      if(distance(var_1.origin, level.s_pap_center.origin) < 500) {
        level notify("papq_step_one_done");
      }
    }

    wait 1;
  }
}

set_up_aether_aeras() {
  level endon("game_ended");
  level endon("papq_step_one_done");
  level.a_s_aether_locs = scripts\engine\utility::getstructarray("papq_aether_area_loc", "script_noteworthy");
}

enter_aether_pocket_watcher() {
  level endon("game_ended");
  level endon("papq_step_three_done");
  level endon("pap_ff_kick_off");

  for(;;) {
    foreach(var_1 in level.players) {
      if(distance(self.origin, var_1.origin) < 500) {
        if(!istrue(var_1.b_in_aether_pocket)) {
          var_1 thread player_in_aether_pocket_watcher(self);
          var_1.b_in_aether_pocket = 1;
          var_1 notify("player_enter_aether_pocket");
        }
      }
    }

    waitframe();
  }
}

player_in_aether_pocket_watcher(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  level endon("papq_step_three_done");
  level endon("pap_ff_kick_off");
  self._id_A25F = self._id_A25F + 0;
  thread _id_073C::_id_FCCC();

  for(;;) {
    if(distance(self.origin, var_0.origin) > 500) {
      self._id_A25F = self._id_A25F - 0;
      self._id_A25F = clamp(self._id_A25F, 1, 999);
      thread _id_073C::_id_FCCC();
      self.b_in_aether_pocket = 0;
      return;
    }

    waitframe();
  }
}

set_up_loot_crystals() {
  var_0 = scripts\engine\utility::getstructarray("papq_aether_loot_crystal_loc", "script_noteworthy");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = _func_03C5("s4_zm_loot_crystal_oasis", var_3.origin, var_3.angles);
    var_4 _id_07A1::_id_CEC7(::destroy_oasis_loot_crystal);
    var_1[var_1.size] = var_4;
  }
}

destroy_oasis_loot_crystal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  if(!isPlayer(var_2) || !isDefined(var_0) || !var_0 _meth_8679("zm_loot_crystal") || var_0 _meth_8575("zm_loot_crystal", 1) == "dead") {
    return;
  }
  var_0 setscriptablepartstate("zm_loot_crystal", "dead");
  var_0 setscriptablepartstate("fx", "destroyed");
  waitframe();

  if(isDefined(var_0)) {
    if(randomint(100) > 25) {
      _id_073D::_id_4FF0("aether_pocket_crystal_loot", var_0.origin, var_0.angles, 30);
    }
  }

  var_0.next_crystal_respawn_round = level._id_11049 + 3;
  var_0 thread respawn_crystal_monitor();
}

respawn_crystal_monitor() {
  level endon("game_ended");
  var_0 = (0, 0, -30);

  while(isDefined(self) && isDefined(self.next_crystal_respawn_round) && level._id_11049 < self.next_crystal_respawn_round) {
    level waittill("round_start");
  }

  if(isDefined(self) && self _meth_8575("zm_loot_crystal", 1) == "dead") {
    playFX(level._effect["zmb_ai_teleport_spawn_in"], self.origin + var_0);
    self setscriptablepartstate("zm_loot_crystal", "healthy");
    self setscriptablepartstate("fx", "idle");
  }
}

buy_door_watcher() {
  level endon("game_ended");
  level endon("papq_step_one_done");
  level scripts\engine\utility::waittill_any_2("door_oasis_temple_to_west_spring_east_bought", "door_oasis_temple_to_east_spring_bought");
  level notify("papq_step_one_done");
}

show_explore_temple_hint() {
  level endon("game_ended");
  wait 2;

  foreach(var_1 in level.players) {
    var_1 thread show_hint_monitor(&"CP_ZM_OASIS/PAPQ_EXPLORE_TEMPLE", "papq_step_one_done");
  }

  scripts\engine\utility::_id_5C1B("show_hint_explore_temple");
  level waittill("papq_step_one_done");
  scripts\engine\utility::_id_5C04("show_hint_explore_temple");
}

papq_hint_watcher() {
  level endon("game_ended");
  self endon("disconnect");
  papq_hint_update();

  for(;;) {
    self waittill("death");

    if(isDefined(self.my_hint)) {
      self.my_hint fadeovertime(0.15);
      self.my_hint.alpha = 0;
      self.my_hint scripts\cp\utility::destroyelem();
    }

    self waittill("spawned");
    papq_hint_update();
  }
}

papq_hint_update() {
  if(scripts\engine\utility::_id_5C00("show_hint_explore_temple")) {
    thread show_hint_monitor(&"CP_ZM_OASIS/PAPQ_EXPLORE_TEMPLE", "papq_step_one_done");
  } else if(scripts\engine\utility::_id_5C00("show_hint_collect_parts")) {
    thread show_hint_monitor(&"CP_ZM_OASIS/PAPQ_COLLECT_PAP_PART", "papq_step_two_done");
  } else if(scripts\engine\utility::_id_5C00("show_hint_assemble_pap")) {
    thread show_hint_monitor(&"CP_ZM_OASIS/PAPQ_ASSEMBLE_PAP", "papq_parts_returned");
  }
}

init_collect_parts() {
  level.n_part_collected = 0;
  _id_0737::_id_C266("papq_part_interact", ::hint_interact_pap_part, ::on_interact_pap_part, ::init_interact_pap_part);
  level thread show_collect_parts_hint();
}

do_collect_parts() {
  level waittill("papq_step_two_done");
}

cleanup_collect_parts() {}

debug_collect_parts() {
  level notify("papq_step_two_done");
}

on_interact_pap_part(var_0, var_1) {
  if(scripts\engine\utility::_id_5C00("start_rbz_exfil")) {
    return;
  }
  var_1 _meth_827A("cp_zm_s2_mq_shield_rumble", var_1.origin);
  playFX(level._effect["papq_pap_part_move"], var_0.mdl_part.mdl_fx.origin);
  scripts\cp\utility::_id_B8EF("zmb_pap_part_teleport_out", var_0.mdl_part.origin);

  if(isDefined(level.s_pap_center) && isDefined(level.s_pap_center.mdl_fx)) {
    playFX(level._effect["papq_pap_part_move"], level.s_pap_center.mdl_fx.origin);
    scripts\cp\utility::_id_B8EF("zmb_pap_part_teleport_in", level.s_pap_center.origin);
  }

  var_0 cleanup_marker(var_0.mdl_loc._id_CE18);

  if(isDefined(var_0.mdl_part)) {
    _func_0130(var_0.mdl_part.mdl_fx);
    var_0.mdl_part delete();
  }

  if(scripts\engine\utility::is_equal(var_0._id_CD99, "papq_pap_charge_ambient_top")) {
    level notify("papq_top_part_returned");
  }

  if(scripts\engine\utility::is_equal(var_0._id_CD99, "papq_pap_charge_ambient_med")) {
    level notify("papq_med_part_returned");
  }

  level.n_part_collected++;

  if(level.n_part_collected == 1) {
    var_1 thread play_got_first_pap_part_vo();
  }

  if(level.n_part_collected == 2) {
    level thread play_got_all_pap_part_vo();
    level notify("papq_step_two_done");
  }

  _id_0737::_id_C3C5(var_0);
}

play_got_first_pap_part_vo() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  wait 1;

  if(isDefined(self)) {
    if(istrue(level._id_493C)) {
      level waittill("dialogue_finished");
    }

    var_0 = ["zm_cpm5_rbm5_dnrt_miea", "zm_cpm5_rbm5_dnrt_mieb", "zm_cpm5_rbm5_dnrt_miec", "zm_cpm5_rbm5_dnrt_mied"];
    var_1 = scripts\engine\utility::random(var_0);
    self setclientomnvar("ui_zm_comms", _id_0720::get_portrait_index(strtok(var_1, "_")[3]));
    _id_0720::_id_B309(self, var_1);
    self setclientomnvar("ui_zm_comms", -1);
  }
}

play_got_all_pap_part_vo() {
  level endon("game_ended");
  wait 1;

  if(istrue(level._id_493C)) {
    level waittill("dialogue_finished");
  }

  var_0 = ["zm_cpm5_rbm5_dnvk_mifa", "zm_cpm5_rbm5_dnvk_mifb", "zm_cpm5_rbm5_dnvk_mifc", "zm_cpm5_rbm5_dnvk_mifd"];
  level thread _id_0720::play_narrations(scripts\engine\utility::random(var_0), 1, 0, "force_quit_current_dialogue");
  level waittill("dialogue_finished");
}

play_parts_returned_pap_vo() {
  level endon("game_ended");

  if(istrue(level._id_493C)) {
    level waittill("dialogue_finished");
  }

  var_0 = ["zm_cpm5_rbm5_dnrt_miga", "zm_cpm5_rbm5_dnvk_migb"];
  var_1 = ["zm_cpm5_rbm5_dnrt_migc", "zm_cpm5_rbm5_dnvk_migd"];
  var_2 = ["zm_cpm5_rbm5_dnrt_mige", "zm_cpm5_rbm5_dnvk_migf"];
  var_3 = ["zm_cpm5_rbm5_dnrt_migg", "zm_cpm5_rbm5_dnvk_migh"];
  level thread _id_0720::play_narrations(scripts\engine\utility::random([var_0, var_1, var_2, var_3]), 1, 0, "force_quit_current_dialogue");
  level waittill("dialogue_finished");
}

play_charge_pap_vo() {
  level endon("game_ended");

  if(istrue(level._id_493C)) {
    level waittill("dialogue_finished");
  }

  var_0 = ["zm_cpm5_rbm5_dnvk_miha", "zm_cpm5_rbm5_dnvk_mihb", "zm_cpm5_rbm5_dnvk_mihc", "zm_cpm5_rbm5_dnvk_mihd"];
  level thread _id_0720::play_narrations(scripts\engine\utility::random(var_0), 1, 0, "force_quit_current_dialogue");
  level waittill("dialogue_finished");
}

play_completed_charge_pap_vo() {
  level endon("game_ended");
  wait 4;

  if(istrue(level._id_493C)) {
    level waittill("dialogue_finished");
  }

  var_0 = ["zm_cpm5_rbm5_vlst_miia", "zm_cpm5_rbm5_vlst_miib", "zm_cpm5_rbm5_vlst_miic", "zm_cpm5_rbm5_vlst_miid"];
  level thread _id_0720::play_narrations(scripts\engine\utility::random(var_0), 1, 0, "force_quit_current_dialogue");
  level waittill("dialogue_finished");
}

init_interact_pap_part(var_0) {
  foreach(var_2 in var_0) {
    var_2.mdl_loc = scripts\engine\utility::getstruct(var_2.target, "targetname");
    var_2.mdl_part = scripts\cp\utility::_id_E190(var_2.mdl_loc._id_CE18, var_2.mdl_loc.origin, var_2.mdl_loc.angles);
    var_2.mdl_part notsolid();
    var_2.mdl_part thread do_bob();
    var_2.mdl_part thread show_hide_outline();
    var_2.mdl_loc _id_0FFD(var_2.mdl_loc._id_CE18, "");
    var_2 thread play_part_ambient_fx();
  }
}

hint_interact_pap_part(var_0, var_1) {
  if(scripts\engine\utility::_id_5C00("start_rbz_exfil")) {
    return "";
  } else {
    return &"CP_ZM_OASIS/PAPQ_COLLECT_PART";
  }
}

play_part_ambient_fx() {
  level endon("game_ended");
  self.mdl_part.mdl_fx = scripts\cp\utility::_id_E190("tag_origin", self.mdl_part.origin + (0, 0, int(self._id_CE18)), self.mdl_part.angles);
  self.mdl_part.mdl_fx linkto(self.mdl_part);
  waitframe();
  playFXOnTag(level._effect[self._id_CD99], self.mdl_part.mdl_fx, "tag_origin");
}

_id_0FFD(var_0, var_1) {
  var_2 = spawnStruct();
  var_2._id_E747 = "current";
  var_2.label = var_1;
  var_2._id_96CF = self.origin;
  var_2._id_11012 = int(self._id_CD99);
  var_2._id_7C3B = "v_ui_icons_zombies_minimap_objective";
  var_2.minimapiconsize = "icon_regular";
  var_2.setbackground = 0;
  var_2.showsdistance = 1;
  self.objective_marker_index = _id_0987::_id_0FFD(var_0, var_2);
  self.objective_param = var_2;
}

cleanup_marker(var_0) {
  _id_0987::_id_C413(var_0, self.objective_marker_index);
  waitframe();
  self.objective_marker_index = undefined;
}

do_bob(var_0) {
  level endon("game_ended");

  if(isDefined(var_0)) {
    level endon(var_0);
  }

  self endon("death");
  var_1 = self.origin + (0, 0, 4);
  var_2 = self.origin + (0, 0, -4);

  for(;;) {
    self moveto(var_1, 1.5, 0, 0);
    self waittill("movedone");
    self moveto(var_2, 1.5, 0, 0);
    self waittill("movedone");
  }
}

show_hide_outline() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    var_0 = 0;

    foreach(var_2 in level.players) {
      if(var_2 scripts\cp\utility::_id_8708()) {
        var_3 = distancesquared(self.origin, var_2.origin);

        if(var_3 <= _func_0219(400) && !istrue(var_0)) {
          var_0 = 1;
        }

        break;
      }
    }

    if(istrue(var_0)) {
      self _meth_81B0("outline_depth_yellow_zm_wider");
    } else {
      self _meth_81AD();
    }

    wait 0.1;
  }
}

show_hint_monitor(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self.my_hint = scripts\cp\utility::createfontstring("default", 1);
  self.my_hint scripts\cp\utility::setpoint("LEFT", undefined, 12, -90);
  self.my_hint.color = (1, 1, 1);
  self.my_hint settext(var_0);
  self.my_hint.alpha = 1;
  level waittill(var_1);

  if(isDefined(self) && isalive(self) && isDefined(self.my_hint)) {
    self.my_hint fadeovertime(0.15);
    self.my_hint.alpha = 0;
    self.my_hint scripts\cp\utility::destroyelem();
  }
}

show_collect_parts_hint() {
  level endon("game_ended");
  wait 5;

  foreach(var_1 in level.players) {
    var_1 thread show_hint_monitor(&"CP_ZM_OASIS/PAPQ_COLLECT_PAP_PART", "papq_step_two_done");
  }

  scripts\engine\utility::_id_5C1B("show_hint_collect_parts");
  level waittill("papq_step_two_done");
  scripts\engine\utility::_id_5C04("show_hint_collect_parts");
}

init_final_fight() {
  level.s_pap_interact = scripts\engine\utility::getstruct("papq_pap_interact", "script_noteworthy");
  level.s_pap_interact.search_2d_dist = 72;
  _id_0737::_id_C266("papq_pap_interact", ::hint_interact_pap_center, ::on_interact_pap_center, ::init_interact_pap_center);
  level.s_pap_center _id_0FFD("assemble_pap", "");
  level thread show_assemble_pap_hint();
  level.jugg_hold_pos = scripts\engine\utility::getstruct("papq_ff_jugg_hold_pos", "script_noteworthy");
  _id_0737::_id_C4AB("weapon_upgrade");
}

do_final_fight() {
  level waittill("pap_ff_done");
  wait 3;
  level thread pap_ff_complete();
  level waittill("papq_step_three_done");
}

cleanup_final_fight() {
  foreach(var_1 in level.a_mdl_echo_zombies) {
    var_1 delete();
    level.a_mdl_echo_zombies = scripts\engine\utility::array_remove(level.a_mdl_echo_zombies, var_1);
  }

  foreach(var_1 in level.a_mdl_echo_juggs) {
    var_1 delete();
    level.a_mdl_echo_juggs = scripts\engine\utility::array_remove(level.a_mdl_echo_juggs, var_1);
  }

  if(isDefined(level.stream_mdl_echo_pap)) {
    level.stream_mdl_echo_pap delete();
  }

  if(isDefined(level.stream_mdl_solid_pap)) {
    level.stream_mdl_solid_pap delete();
  }

  level notify("papq_is_done");
  _func_01E6(1, 1);
}

debug_final_fight() {
  level notify("papq_parts_returned");
  waitframe();
  level notify("pap_ff_done");
  waitframe();
  level notify("papq_step_three_done");
  clean_objective_markers();
}

on_interact_pap_center(var_0, var_1) {
  if(scripts\engine\utility::_id_5C00("start_rbz_exfil")) {
    return;
  }
  level thread ff_start_delay(0);
  level thread play_parts_returned_pap_vo();
  level notify("papq_parts_returned");
  level.s_pap_center cleanup_marker("assemble_pap");
  _id_0737::_id_C3C5(var_0);
}

init_interact_pap_center(var_0) {}

hint_interact_pap_center(var_0, var_1) {
  if(scripts\engine\utility::_id_5C00("start_rbz_exfil")) {
    return "";
  } else {
    return &"CP_ZM_OASIS/PAPQ_RETURN_PAP_PART";
  }
}

ff_start_delay(var_0) {
  level endon("game_ended");
  level endon("papq_step_three_done");
  wait(var_0);
  _func_0130(level.mdl_oasis_pap);
  level thread pap_ff_kick_off();
}

send_fx_trail(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("game_ended");
  var_6 = distance(var_0, var_1) / var_3;

  if(var_6 <= 0) {
    return;
  }
  var_7 = scripts\cp\utility::_id_E190("tag_origin", var_0);
  waitframe();

  if(!isDefined(level.a_trail_sfx_recorder)) {
    level.a_trail_sfx_recorder = [];
  }

  if(isDefined(var_4)) {
    scripts\cp\utility::_id_B8EF(var_4, var_0);
  }

  var_8 = 0;

  if(!scripts\engine\utility::array_contains(level.a_trail_sfx_recorder, var_0)) {
    level.a_trail_sfx_recorder = scripts\engine\utility::array_add(level.a_trail_sfx_recorder, var_0);
    var_7 playLoopSound("zmb_souls_lp");
    var_8 = 1;
  }

  if(isDefined(var_7)) {
    playFXOnTag(level._effect[var_2], var_7, "tag_origin");
    wait 0.2;
    var_7 moveto(var_1, var_6);
    var_7 waittill("movedone");

    if(isDefined(var_5)) {
      scripts\cp\utility::_id_B8EF(var_5, var_1);
    }

    wait 2;
  }

  if(isDefined(var_7)) {
    if(var_8) {
      level.a_trail_sfx_recorder = scripts\engine\utility::array_remove(level.a_trail_sfx_recorder, var_0);
    }

    _func_0130(var_7);
    var_7 delete();
  }
}

pap_ff_kick_off() {
  level endon("game_ended");
  level endon("papq_step_three_done");
  set_ff_music(1);
  scripts\engine\utility::_id_5C04("round_spawn_zombies");
  level thread fadetowhite(0.75, 1);
  level thread set_echo_zmbs();
  wait 0.4;
  _func_0130(level.s_pap_center.mdl_fx);
  level notify("pap_ff_kick_off");
  level.n_ff_kills = 0;
  level.n_ff_kill_requirement = get_kill_requirement();
  _id_06CB::_id_AA4A(::on_zombie_killed_pap_ff);
  level._id_A52A = 1;
  wait 3;
  set_up_zombie_spawning();
  level thread pap_charge_progress_fx_watch();
}

pap_ff_complete() {
  level endon("game_ended");
  set_ff_music(0);
  _id_06CB::_id_C417(::on_zombie_killed_pap_ff);
  level thread fadetowhite(0.75, 1);
  _func_0343();
  _func_0130(level.mdl_oasis_pap);
  wait 1;
  level notify("papq_step_three_done");
  var_0 = _id_06FE::_id_6322();

  foreach(var_2 in var_0) {
    var_2 _meth_81FA();
  }

  if(isDefined(level.s_pap_center.mdl_fx)) {
    _func_0130(level.s_pap_center.mdl_fx);
    level.s_pap_center.mdl_fx delete();
  }

  level._id_AE13 = 1;
  level._id_A52A = 0;
  [[level._id_10D22]]();
  level thread remove_pap_machine_marker(1);
  level thread players_area_monitor();
  _id_06CB::_id_0FA4("zone_changed", ::watch_zone_changed);
  scripts\engine\utility::_id_5C1B("power_on");
  scripts\engine\utility::_id_5C1B("round_spawn_zombies");
}

remove_pap_machine_marker(var_0) {
  level endon("game_ended");

  if(!isDefined(level._id_417B)) {
    level scripts\engine\utility::_id_5C24("introscreen_over");
  }

  var_1 = scripts\engine\utility::getstruct("dark_aether_location_center", "script_noteworthy");

  foreach(var_3 in level._id_417B) {
    if(scripts\engine\utility::is_equal(var_3._id_039B, "weapon_upgrade")) {
      if(!istrue(var_0) || distance2dsquared(var_3.origin, var_1.origin) < 81000000) {
        _id_0987::remove_instanced_objective_marker(var_3.markerlabel, var_3.instanceindex);
        var_3.markerlabel = undefined;
        var_3.instanceindex = undefined;
      }
    }
  }
}

players_area_monitor() {
  level endon("game_ended");
  scripts\engine\utility::_id_5C24("introscreen_over");
  var_0 = scripts\engine\utility::getstruct("dark_aether_location_center", "script_noteworthy");

  if(!isDefined(level._id_146C) || !isDefined(var_0)) {
    return;
  }
  var_1 = 0;
  var_2 = 1;
  var_3 = level.objective_marker_instances["weapon_upgrade"].markerparams;
  var_4 = [];
  var_5 = [];

  foreach(var_7 in level._id_417B) {
    if(!isDefined(var_7._id_039B)) {
      continue;
    }
    switch (var_7._id_039B) {
      case "tome_of_rituals":
        var_4[var_4.size] = var_7;
        break;
      case "covenant_store":
        var_5[var_5.size] = var_7;
        break;
    }
  }

  var_9 = level.objective_marker_instances["tome_of_rituals"].markerparams;
  var_10 = level.objective_marker_instances["covenant_store"].markerparams;

  for(;;) {
    var_11 = 0;
    var_12 = 0;

    foreach(var_14 in level.players) {
      if(distance2dsquared(var_14.origin, var_0.origin) < 81000000) {
        var_12 = 1;
        continue;
      }

      var_11 = 1;
    }

    if(var_12 && var_11) {
      level waittill("zone_changed");
      continue;
    }

    var_16 = [];
    var_17 = [];

    foreach(var_7 in level._id_417B) {
      if(scripts\engine\utility::is_equal(var_7._id_039B, "weapon_upgrade")) {
        if(distance2dsquared(var_7.origin, var_0.origin) < 81000000) {
          var_17[var_17.size] = var_7;
          continue;
        }

        var_16[var_16.size] = var_7;
      }
    }

    if(var_17.size + var_16.size == 0) {
      level waittill("zone_changed");
      continue;
    }

    if(var_12) {
      if(!var_1) {
        foreach(var_21 in var_16) {
          _id_0987::remove_instanced_objective_marker(var_21.markerlabel, var_21.instanceindex);
          var_21.markerlabel = undefined;
          var_21.instanceindex = undefined;
        }

        foreach(var_24 in var_4) {
          _id_0987::remove_instanced_objective_marker(var_24.markerlabel, var_24.instanceindex);
          var_24.markerlabel = undefined;
          var_24.instanceindex = undefined;
        }

        foreach(var_27 in var_5) {
          _id_0987::remove_instanced_objective_marker(var_27.markerlabel, var_27.instanceindex);
          var_27.markerlabel = undefined;
          var_27.instanceindex = undefined;
        }

        var_1 = 1;
      }

      if(var_2) {
        foreach(var_21 in var_17) {
          var_21.markerlabel = "weapon_upgrade";
          var_3._id_96CF = var_21.origin;
          var_21.instanceindex = _id_0987::add_instanced_objective_marker(var_21.markerlabel, var_3);
        }

        var_2 = 0;
      }
    } else {
      if(!var_2) {
        foreach(var_21 in var_17) {
          _id_0987::remove_instanced_objective_marker(var_21.markerlabel, var_21.instanceindex);
          var_21.markerlabel = undefined;
          var_21.instanceindex = undefined;
        }

        var_2 = 1;
      }

      if(var_1) {
        foreach(var_21 in var_16) {
          var_21.markerlabel = "weapon_upgrade";
          var_3._id_96CF = var_21.origin;
          var_21.instanceindex = _id_0987::add_instanced_objective_marker(var_21.markerlabel, var_3);
        }

        foreach(var_24 in var_4) {
          var_24.markerlabel = "tome_of_rituals";
          var_9._id_96CF = var_24.origin;
          var_24.instanceindex = _id_0987::add_instanced_objective_marker(var_24.markerlabel, var_9);
        }

        foreach(var_27 in var_5) {
          var_27.markerlabel = "covenant_store";
          var_10._id_96CF = var_27.origin;
          var_27.instanceindex = _id_0987::add_instanced_objective_marker(var_27.markerlabel, var_10);
        }

        var_1 = 0;
      }
    }

    level waittill("zone_changed");
  }
}

watch_zone_changed(var_0) {
  level notify("zone_changed");
}

set_ff_music(var_0) {
  if(istrue(var_0)) {
    _func_01E3("pap_defend");

    foreach(var_2 in level.players) {
      var_2 _meth_867F("cp_boss_fight", 2);
    }
  } else {
    _func_01E3("none");

    foreach(var_2 in level.players) {
      var_2 _meth_8680("cp_boss_fight", 2);
    }
  }
}

set_echo_zmbs() {
  level endon("game_ended");
  level endon("papq_step_three_done");
  wait 1;

  foreach(var_1 in level.a_mdl_echo_zombies) {
    var_1 delete();
    level.a_mdl_echo_zombies = scripts\engine\utility::array_remove(level.a_mdl_echo_zombies, var_1);
  }

  var_3 = scripts\engine\utility::getstructarray("papq_echo_zmb_spawn_loc", "script_noteworthy");

  foreach(var_5 in var_3) {
    var_6 = _id_09A4::_id_110AD("enemy_base_zombie_cp", var_5.origin, var_5.angles, var_5);
    var_6 thread set_up_echo_zombie();
    scripts\cp\utility::_id_B8EF("zmb_zom_turn_ethereal", var_6.origin);
  }

  foreach(var_1 in level.a_mdl_echo_juggs) {
    var_1 delete();
    level.a_mdl_echo_juggs = scripts\engine\utility::array_remove(level.a_mdl_echo_juggs, var_1);
  }

  var_10 = scripts\engine\utility::getstructarray("papq_echo_jugg_spawn_loc", "script_noteworthy");

  foreach(var_5 in var_10) {
    var_6 = _id_09A4::_id_110AD("enemy_zombie_juggernaut_cp", var_5.origin, var_5.angles, var_5);
    var_6 thread set_up_echo_zombie();
    scripts\cp\utility::_id_B8EF("zmb_zom_turn_ethereal", var_6.origin);
  }
}

set_up_zombie_spawning() {
  var_0 = level.players.size;
  var_1 = [3, 2, 1, 1];
  var_2 = [4, 3, 2, 2];
  var_3 = [15, 15, 12, 12];
  var_4 = [7, 10, 13, 16];
  var_5 = [1, 2, 3, 4];
  var_6 = [1, 1, 1, 1];
  var_7 = [0, 0, 1, 1];
  var_8 = scripts\engine\utility::getstructarray("papq_ff_zmb_spawner", "script_noteworthy");
  level thread spawn_zombie_pap_ff("base", "enemy_base_zombie_cp", var_1[var_0 - 1], var_4[var_0 - 1], undefined, "pap_ff_done", var_8, var_8);
  level thread spawn_zombie_pap_ff("screamer", "enemy_zombie_screamer_cp", var_2[var_0 - 1], var_5[var_0 - 1], undefined, "pap_ff_done", var_8, var_8);
  level thread spawn_zombie_pap_ff("juggernaut", "enemy_zombie_juggernaut_cp", var_3[var_0 - 1], var_6[var_0 - 1], var_7[var_0 - 1], "pap_ff_done", var_8, var_8);
}

spawn_zombie_pap_ff(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon("game_ended");
  level endon(var_5);
  var_8 = 0;

  for(;;) {
    if(isDefined(var_4) && var_8 >= var_4) {
      return;
    }
    if(get_alive_zombies_count(var_0) < var_3) {
      if(scripts\engine\utility::is_equal(var_0, "screamer")) {
        var_9 = pick_random_spawner(var_7);
      } else {
        var_9 = pick_random_spawner(var_6);
      }

      playFX(level._effect["zmb_ai_teleport_spawn_in"], var_9.origin);
      waitframe();
      var_10 = _id_09A4::_id_110AD(var_1, var_9.origin, var_9.angles, var_9);
      var_8++;
      wait 0.5;

      if(isDefined(var_10) && isalive(var_10)) {
        var_10.on_zombie_killed_score_override_func = scripts\cp\maps\cp_zm_oasis\cp_zm_oasis_mq_root::on_zombie_killed_give_no_score;
        var_10.brain_rot_immune = 1;
        var_10._id_4A75 = 1;

        if(scripts\engine\utility::is_equal(var_0, "base")) {
          if(level._id_11049 < 10) {
            var_10[[var_10._id_D603]]("run");
          }
        }

        if(scripts\engine\utility::is_equal(var_0, "juggernaut")) {
          var_10 thread force_go_to_position();
          var_10.b_ignore_cleanup = 1;
        }
      }
    }

    wait(var_2);
  }
}

get_kill_requirement() {
  var_0 = level.players.size;
  var_1 = [15, 18, 23, 30];
  return var_1[var_0 - 1];
}

on_zombie_killed_pap_ff(var_0) {
  if(isPlayer(var_0._id_50FF) && distance(self.origin, level.s_pap_center.origin) < 800) {
    level.n_ff_kills++;

    if(!istrue(level.b_play_charge_pap_vo)) {
      level.b_play_charge_pap_vo = 1;
      level thread play_charge_pap_vo();
    }

    if(level.n_ff_kills == level.n_ff_kill_requirement) {
      level notify("pap_ff_done");
      level thread play_completed_charge_pap_vo();
    }

    level thread send_fx_trail(self gettagorigin("j_spine4"), level.s_pap_center.origin, "papq_echo_zmb_trail", 500, "zmb_soul_release", "zmb_soul_impact");
  }
}

pick_random_spawner(var_0) {
  var_1 = randomint(var_0.size);
  var_2 = var_0[var_1];
  return var_2;
}

get_alive_zombies_count(var_0) {
  var_1 = 0;
  var_2 = _id_06FE::_id_6322();

  foreach(var_4 in var_2) {
    if(scripts\engine\utility::is_equal(var_4._id_110B0, var_0)) {
      var_1++;
    }
  }

  return var_1;
}

fadetowhite(var_0, var_1) {
  level endon("game_ended");
  level notify("FadeToWhite_singleton");
  level endon("FadeToWhite_singleton");

  if(istrue(var_1)) {
    foreach(var_3 in level.players) {
      scripts\cp\utility::_id_B8F4("zmb_clear_blast", var_3);
    }
  }

  _func_01EA("ui_total_fade_color", 1);

  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }
    level thread scripts\cp_mp\utility\game_utility::_id_58C7(var_3, 1, var_0);
  }

  wait(var_0 + 0.3);

  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }
    level thread scripts\cp_mp\utility\game_utility::_id_58C7(var_3, 0, var_0);
  }

  wait(var_0 + 0.3);
  _func_01EA("ui_total_fade_color", 0);
}

pap_charge_progress_fx_watch() {
  level endon("game_ended");
  level endon("papq_step_three_done");
  level endon("pap_ff_done");
  var_0 = int(level.n_ff_kill_requirement / 4);
  var_1 = 0;
  var_2 = ["papq_pap_charge_fx_01", "papq_pap_charge_fx_02", "papq_pap_charge_fx_03", "papq_pap_charge_fx_04"];
  playFXOnTag(level._effect[var_2[var_1]], level.mdl_oasis_pap, "tag_origin");
  var_3 = ["zmb_pap_soul_charge_state_lp_0", "zmb_pap_soul_charge_state_lp_1", "zmb_pap_soul_charge_state_lp_2", "zmb_pap_soul_charge_state_lp_3"];
  level.s_pap_center.mdl_fx playLoopSound(var_3[var_1]);

  for(;;) {
    if(level.n_ff_kills == var_0) {
      stopFXOnTag(level._effect[var_2[var_1]], level.mdl_oasis_pap, "tag_origin");
      level.s_pap_center.mdl_fx stoploopsound(var_3[var_1]);
      var_1++;
      var_0 = var_0 + var_0;
      waitframe();

      if(isDefined(var_2[var_1])) {
        playFXOnTag(level._effect[var_2[var_1]], level.mdl_oasis_pap, "tag_origin");
      }

      if(isDefined(var_3[var_1])) {
        level.s_pap_center.mdl_fx playLoopSound(var_3[var_1]);
      }
    }

    waitframe();
  }
}

show_assemble_pap_hint() {
  level endon("game_ended");
  wait 4;

  foreach(var_1 in level.players) {
    var_1 thread show_hint_monitor(&"CP_ZM_OASIS/PAPQ_ASSEMBLE_PAP", "papq_parts_returned");
  }

  scripts\engine\utility::_id_5C1B("show_hint_assemble_pap");
  level waittill("papq_parts_returned");
  scripts\engine\utility::_id_5C04("show_hint_assemble_pap");
}

set_up_echo_zombie() {
  level endon("game_ended");
  self endon("death");
  wait 0.5;

  if(scripts\engine\utility::is_equal(self._id_110B0, "base")) {
    if(isDefined(self) && isalive(self)) {
      if(level._id_11049 < 10) {
        self[[self._id_D603]]("run");
        self.maxhealth = 800;
        self.health = 800;
      }
    }
  }

  if(scripts\engine\utility::is_equal(self._id_110B0, "juggernaut")) {
    if(isDefined(self) && isalive(self)) {
      thread force_go_to_position();
      self.b_ignore_cleanup = 1;
    }
  }

  self.brain_rot_immune = 1;
  self._id_4A75 = 1;
}

clean_objective_markers() {
  level.s_pap_center cleanup_marker("assemble_pap");
  level.s_altar_loc cleanup_marker("obj_search_temple");
  var_0 = scripts\engine\utility::getstructarray("papq_part_interact", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.mdl_loc) && isDefined(var_2.mdl_loc._id_CE18)) {
      var_2 cleanup_marker(var_2.mdl_loc._id_CE18);
    }
  }
}

exfil_start_watcher() {
  level endon("end_game");
  level waittill("start_rbz_exfil");
  clean_objective_markers();
}

force_go_to_position() {
  self endon("death");
  var_0 = undefined;

  while(!isDefined(var_0)) {
    var_1 = vectortoangles((self.origin[0], self.origin[1], level.jugg_hold_pos.origin[2]) - level.jugg_hold_pos.origin);
    var_2 = anglesToForward(var_1);
    var_0 = level.jugg_hold_pos.origin + var_2 * randomintrange(100, 200);
    var_0 = _func_02A9(var_0, 50);
    waitframe();
  }

  self._id_CF4A = 1;
  self._id_0229 = 1;
  self _meth_8326(var_0);
  scripts\engine\utility::_id_5473("zombie_move_to_defend_position");
  thread check_juggernaut_move_to_defend_position_monitor();
  thread check_juggernaut_get_stuck_when_move_to_defend_position_monitor(var_0);
  scripts\engine\utility::_id_5476("zombie_move_to_defend_position");
  scripts\aitypes\zombie_juggernaut\combat::set_defend_location(var_0);
  self._id_CF4A = 0;
  self._id_0229 = 0;
  thread check_defending_juggernaut_has_no_target_monitor();
}

check_juggernaut_move_to_defend_position_monitor() {
  level endon("game_ended");
  self endon("death");
  self waittill("goal");
  scripts\engine\utility::_id_5474("zombie_move_to_defend_position");
}

check_juggernaut_get_stuck_when_move_to_defend_position_monitor(var_0) {
  level endon("game_ended");
  self endon("death");
  var_1 = var_0;

  while(!scripts\engine\utility::_id_546E("zombie_move_to_defend_position")) {
    if(scripts\engine\utility::is_equal(self _meth_86F8(var_1), (0, 0, 0))) {
      var_2 = undefined;

      while(!isDefined(var_2)) {
        var_3 = vectortoangles((self.origin[0], self.origin[1], level.jugg_hold_pos.origin[2]) - level.jugg_hold_pos.origin);
        var_4 = anglesToForward(var_3);
        var_2 = level.jugg_hold_pos.origin + var_4 * randomintrange(100, 200);
        var_2 = _func_02A9(var_2, 50);
        waitframe();

        if(!isDefined(self)) {
          return;
        }
      }

      self _meth_8326(var_2);
      var_1 = var_2;
    }

    wait 0.5;

    if(!isDefined(self)) {
      return;
    }
  }
}

check_defending_juggernaut_has_no_target_monitor() {
  level endon("game_ended");
  self endon("death");
  var_0 = 3;

  for(;;) {
    if(!isDefined(self._id_0192)) {
      wait(var_0);

      if(!isDefined(self)) {
        return;
      }
    }

    if(!isDefined(self._id_0192)) {
      force_go_to_position();
      return;
    }

    wait 0.5;

    if(!isDefined(self)) {
      return;
    }
  }
}