/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\zombies\zm_rbz_exfil.gsc
*************************************************/

init() {
  if(!getdvarint("#x3dee089cb49164e4e", 0)) {
    return;
  }
  level thread _id_0991::init("cp/zombies/cp_zod_spawn_managers.json");
  _id_0987::_id_C215("exfil", ::_id_7FBE, ::setup, ::_id_8CE4, ::_id_385C, "exfil", undefined, undefined, 4, undefined, undefined, ::on_player_spawned);
  _id_06CB::_id_AA65(::on_player_spawned);
  level._effect["zm_teleport_intro"] = loadfx("vfx/s4/zombie/vfx_hub_portal_activate_1p.vfx");
  level thread watch_round_complete();
}

_id_7FBE(var_0) {
  var_0._id_529C = 1;
  level._id_570D = var_0;
  var_0._id_E5F6 thread _id_06EF::_id_833B();
  toggle_all_exfil_portal_clip(0);
  var_1 = level._id_570D._id_E5F6.interact_struct;
  var_2 = (var_1.origin[0], var_1.origin[1], -125);
  var_3 = (var_1.origin[0], var_1.origin[1], -175);

  if(_func_0107(var_0._id_3BE8["streamer_exfil_tablet"]) && isDefined(var_0._id_3BE8["streamer_exfil_tablet"][0])) {
    var_1 = var_0._id_3BE8["streamer_exfil_tablet"][0];
    var_2 = (var_1.origin[0], var_1.origin[1], var_1.origin[2]);
    var_4 = var_1.origin[2] - 50;
    var_3 = (var_1.origin[0], var_1.origin[1], var_4);
  }

  var_0.exfil_tablet_ready_streamer_model = _id_06EF::_id_E1E5(var_1, "s4_zm_exfil_start_01_glow_state_01", 0, 1, var_2);
  var_0.exfil_tablet_activated_streamer_model = _id_06EF::_id_E1E5(var_1, "s4_zm_exfil_start_01_glow_state_02", 0, 1, var_3);
}

hide_exfil_interact() {
  if(isDefined(level._id_570D) && isDefined(level._id_570D._id_E5F6)) {
    level notify("hide_exfil");
    level._id_570D._id_5713 = 0;
    level._id_570D._id_E5F6 thread _id_06EF::_id_833C(0);
    level._id_570D._id_E5F6 setscriptablepartstate("fx", "inactive");
    scripts\cp\zombies\zm_hub_portals::remove_start_interact_marker(level._id_570D, level._id_570D._id_E5F6);
  }
}

init_exfil_start_interact() {
  if(isDefined(level._id_570D) && isDefined(level._id_570D._id_E5F6)) {
    level._id_570D._id_5713 = 1;
    level._id_570D._id_E5F6 thread _id_06EF::_id_833C(1);
    level._id_570D._id_E5F6 setscriptablepartstate("fx", "idle");

    if(scripts\engine\utility::is_equal(level.mapname, "cp_zm_oasis")) {
      scripts\cp\zombies\zm_hub_portals::add_start_interact_marker(level._id_570D, level._id_570D._id_E5F6, 50);
    } else {
      scripts\cp\zombies\zm_hub_portals::add_start_interact_marker(level._id_570D, level._id_570D._id_E5F6, 60);
    }

    level thread disallow_exfil_after_exfil_spawn_monitor();
  }
}

setup(var_0) {}

_id_8CE4(var_0) {
  level notify("exfil_radio_interacted");
  level thread scripts\cp\zombies\objective_barriers::toggle_objective_clip(var_0._id_3BE8["prop"], 1);
  level._id_570D._id_E5F6 setscriptablepartstate("fx", "activate");
  thread play_kickoff_vo(var_0);
  _func_01E3("exfil");
  scripts\cp\utility::_id_B8EF("zmb_exfil_start", (0, 0, 0));
  _id_E61A(var_0);
}

play_kickoff_vo(var_0) {
  var_1 = 0;

  if(getdvarint("#x3dee089cb49164e4e", 0) && scripts\engine\utility::is_equal(level.mapname, "cp_zm_oasis")) {
    var_1 = 1;
  }

  wait 2.0;
  thread _id_0720::play_narration(["zm_cmcp_obex_dnrt_estr", "zm_cmcp_obex_dsrx_estr", "zm_cmcp_obex_blkr_estr", "zm_cmcp_obex_dnvk_estr"]);
  level waittill("dialogue_finished");

  if(!var_1) {
    thread _id_0720::play_narration("zm_cmcp_obex_vlst_estt");
    level waittill("dialogue_finished");
  }

  wait 5.0;
  thread _id_0720::play_narration(["zm_cmcp_obex_dnrt_ew1s", "zm_cmcp_obex_dsrx_ew1s", "zm_cmcp_obex_blkr_ew1s", "zm_cmcp_obex_dnvk_ew1s"]);
  level waittill("dialogue_finished");

  if(!var_1) {
    thread _id_0720::play_narration("zm_cmcp_obex_vlst_ew1t");
    level waittill("dialogue_finished");
  }
}

_id_E61A(var_0) {
  level notify("stop_round_spawn");
  var_0 thread _id_570E();
}

_id_570E() {
  self endon("players_dead");
  self endon("game_ended");
  self endon("exfil_complete");
  level endon("exfil_complete");
  level scripts\engine\utility::_id_5C1B("start_rbz_exfil");
  self._id_E5F6 show_activated_start_interact();
  _id_06CB::_id_AA4A(::_id_AA6D);
  scripts\cp\zombies\zm_hub_portals::cleanup_all_active_portals();
  scripts\cp\zombies\zm_hub_unlock::unlock_all_walls();
  thread _id_9A14();
}

update_kill_count_ui(var_0) {
  level endon("game_ended");
  level endon("exfil_complete");

  foreach(var_2 in level.players) {
    if(!isDefined(self.exfil_kill_requirement)) {
      set_exfil_kill_requirement();
    }

    var_2 _id_0987::set_objective_ui_counter(var_0, self.exfil_kill_requirement);
  }
}

_id_5B0F() {
  var_0 = _id_65C2();

  if(var_0 > 0) {
    iprintlnbold("Exfil Complete");
    _id_5707(1);
  } else
    _id_5707(0);
}

_id_5707(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  level thread _id_0987::_id_E8EB();
  level thread _id_0991::_id_E8E2(0);
  thread _id_8D05();

  if(var_0) {
    _func_01E3("none");
    give_exfil_reward();
    level._id_5707 = 1;
    level thread exfil_success_sequence();

    foreach(var_2 in level.players) {
      _id_070F::createexfilevent(var_2);
      scripts\cp\cp_playerstats::incrementcombatstat(var_2, "totalExfils", 1);
      scripts\cp\cp_playerstats::updateonlyifhighercombatstat(var_2, "highestExfilRound", scripts\cp\utility::_id_6871());
    }
  } else {
    self._id_E5F6 setscriptablepartstate("content_interact", "inactive");
    _id_0987::_id_C413("exfill_loc", self._id_5726);
    _func_01E3("none");
    playsoundatpos((0, 0, 0), "zmb_exfil_fail");

    foreach(var_2 in scripts\cp\utility::_id_6C5C()) {
      var_2 _meth_867F("cp_exfil_complete");
    }

    _id_0987::_id_A871(level._id_3BE9._id_0F51, 0, _id_0726::_id_6472("fail"));
  }

  var_6 = spawnStruct();
  var_6._id_2047 = var_0;
  _func_01E3("none");
  level notify("exfil_complete", var_6);
  self notify("stop_spawn");
  self notify("exfil_complete");
  self notify("return");
}

exfil_success_sequence() {
  level thread _id_0987::kill_all_objective_zombies();
  _id_0987::play_objective_complete_sfx();
  _id_0987::set_objective_ui_state(3, 0, 2);

  foreach(var_1 in scripts\cp\utility::_id_6C5C()) {
    var_1 _meth_84AC("safe", "iw8_ges_demeanor_safe");
    playFXOnTag(scripts\engine\utility::getfx("zm_teleport_intro"), var_1, "j_head");
    var_1 _meth_867F("cp_exfil_complete");
    var_1 playSound("zmb_pre_teleport_rise");
    var_1 playLoopSound("zmb_teleport_lp");
  }

  wait 2.25;
  thread play_success_narration();
  wait 5;

  foreach(var_1 in scripts\cp\utility::_id_6C5C()) {
    level thread scripts\cp_mp\utility\game_utility::_id_58C7(var_1, 1, 3);
  }

  level thread remove_fade_to_black();
  wait 3.05;
  level thread _id_0726::_id_52F7("allies", _id_0726::_id_6472("win"));
}

remove_fade_to_black() {
  level waittill("game_ended");

  foreach(var_1 in scripts\cp\utility::_id_6C5C()) {
    level thread scripts\cp_mp\utility\game_utility::_id_58C7(var_1, 0, 0);
  }
}

play_success_narration() {
  level thread _id_0720::play_narration("zm_cmcp_obex_krft_escs");
  level waittill("dialogue_finished");
  level _id_0720::play_event_narration("win");
}

_id_9A14() {
  self endon("players_dead");
  level endon("game_ended");
  self endon("objective_ended");
  self endon("exfil_complete");
  level endon("exfil_complete");
  childthread kill_count_waves();
  childthread watch_spawn_exfil_interact();
  self.exfil_portal_start_time = gettime();
  _id_0987::set_objective_ui_time(120);
  _id_0987::set_objective_ui_state(3, 2, 1);
  _id_0987::_id_E65C(120, "exfil");
  wait 0.5;
  _id_5B0F();
}

kill_count_waves() {
  self.exfil_wave = 1;
  self.exfil_kill_count = 0;
  set_exfil_kill_requirement();
  level _id_06CB::_id_0FA4("zm_spawn_manager_zombie_spawned", ::on_zombie_spawned);
  level thread _id_0991::_id_C9FC("cp_zm_zod_exfil_intensity_01", self._id_3BE8["spawn_manager_spawner"][0]._id_0481);

  for(;;) {
    if(self.exfil_wave == 1 && self.exfil_kill_count > _func_0037(self.exfil_kill_requirement * 0.2)) {
      level thread _id_0991::_id_E8E2(0);
      waittillframeend;
      self.exfil_wave = 2;
      level thread _id_0991::_id_C9FC("cp_zm_zod_exfil_intensity_02", self._id_3BE8["spawn_manager_spawner"][0]._id_0481);
    } else if(self.exfil_wave == 2 && self.exfil_kill_count > _func_0037(self.exfil_kill_requirement * 0.3)) {
      level thread _id_0991::_id_E8E2(0);
      waittillframeend;
      self.exfil_wave = 3;
      level thread _id_0991::_id_C9FC("cp_zm_zod_exfil_intensity_03", self._id_3BE8["spawn_manager_spawner"][0]._id_0481);
      return;
    }

    wait 0.1;
  }
}

set_exfil_kill_requirement() {
  var_0 = getdvarint("#x3b67a9a645f53dc84");
  var_1 = level.players.size;
  var_2 = int(_id_0991::_get_difficulty_rating());
  var_3 = 0;

  switch (var_2) {
    case 2:
      var_3 = int(_func_0037((1 + 0.4 * var_1) * 2));
      break;
    case 3:
      var_3 = int(_func_0037((1 + 0.4 * var_1) * 3));
      break;
    case 4:
      var_3 = int(_func_0037((1 + 0.4 * var_1) * 5));
      break;
    case 5:
      var_3 = int(_func_0037((1 + 0.4 * var_1) * 8));
      break;
    case 6:
      var_3 = int(_func_0037((1 + 0.4 * var_1) * 12));
      break;
    default:
      var_3 = int(_func_0037((1 + 0.4 * var_1) * 0));
      break;
  }

  if(isDefined(var_0) && var_0 > 0) {
    self.exfil_kill_requirement = var_0;
  } else {
    self.exfil_kill_requirement = int(_func_0037((1 + 0.4 * var_1) * 25)) + var_3;
  }

  thread update_kill_count_ui(0);
}

_id_D1F5() {
  var_0 = [];
  var_1 = [];

  foreach(var_3 in self._id_3BE8["exfil_interact"]) {
    var_4 = spawnStruct();
    var_4.exfil_interact = var_3;
    var_4.delta_distance = 0;
    var_4.player_nearby = 0;

    foreach(var_6 in level.players) {
      var_7 = distance2d(var_6.origin, var_3.origin);
      var_4.delta_distance = var_4.delta_distance + var_7;

      if(var_7 < 1500) {
        var_4.player_nearby = 1;
      }
    }

    if(var_4.player_nearby != 1) {
      var_0[var_0.size] = var_4;
    }

    var_1[var_1.size] = var_4;
  }

  var_0 = scripts\engine\utility::_id_1BD6(var_0, ::sort_exfil_interacts_by_delta_distance);
  var_1 = scripts\engine\utility::_id_1BD6(var_1, ::sort_exfil_interacts_by_delta_distance);

  if(var_0.size > 0) {
    var_10 = randomint(var_0.size);
    self._id_5716 = var_0[var_10].exfil_interact;
  } else {
    var_10 = randomint(var_1.size);
    self._id_5716 = var_1[0].exfil_interact;
  }
}

sort_exfil_interacts_by_delta_distance(var_0, var_1) {
  if(var_0.delta_distance > var_1.delta_distance) {
    return 1;
  }

  return 0;
}

_id_E135(var_0, var_1, var_2) {
  var_3 = [];
  var_3 = var_1._id_3BE8["interact_dressing"];

  if(isDefined(var_3) && var_3.size > 0) {
    foreach(var_5 in var_3) {
      _id_06EF::_id_E1E5(var_5, var_5.model, 1);
    }
  }

  var_0 toggle_exfil_portal_clip(1);
  var_7 = _id_06EF::_id_E170(var_0, var_2, ::_id_AA69);
  var_7._id_82FC = var_1;
  var_1._id_E5F6 = var_7;
  playsoundatpos(var_0.origin, "zmb_exfil_portal_open");
  var_8 = spawnStruct();
  var_8._id_E747 = "current";
  var_1._id_5723 = spawn("script_model", var_7.origin);
  var_8.label = &"CP_ZMB_INTERACTIONS/EXFIL";
  var_8._id_96CF = var_1._id_5723;
  var_8._id_11012 = 50;
  var_8._id_7C3B = "v_ui_icons_zombies_waypoint_portal";
  var_1._id_E5F6 setscriptablepartstate("fx", "normal");
  var_1._id_5726 = _id_0987::_id_0FFD("exfill_loc", var_8);
  return var_7;
}

_id_AA69(var_0) {
  var_0 _id_06E5::_id_D259(1);

  if(!_id_1474(self._id_82FC, var_0)) {
    return;
  }
  waittillframeend;
  self setscriptablepartstate("content_interact", "inactive");
  _id_5707(1);
}

_id_1474(var_0, var_1) {
  var_1._id_5713 = 1;
  var_2 = _id_65C2();

  if(var_2 >= 1) {
    return 1;
  }

  return 0;
}

_id_65C2() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    if(scripts\engine\utility::is_equal(var_2._id_5713, 1)) {
      var_0++;
    }
  }

  return var_0;
}

_id_AA6D(var_0) {
  if(isDefined(level._id_570D) && !istrue(self._id_A72E) && !scripts\engine\utility::is_equal(self.damagemod, "MOD_SUICIDE")) {
    level._id_570D update_kill_count();
  }
}

update_kill_count() {
  if(istrue(self.kill_count_reached)) {
    return;
  }
  self.exfil_kill_count = scripts\cp\utility::_id_459B(self.exfil_kill_count, 0);
  self.exfil_kill_count++;
  thread update_kill_count_ui(self.exfil_kill_count);

  if(self.exfil_kill_count == int(self.exfil_kill_requirement / 2)) {
    thread _id_0720::play_narration(["zm_cmcp_obex_dnrt_e50p", "zm_cmcp_obex_dsrx_e50p", "zm_cmcp_obex_blkr_e50p", "zm_cmcp_obex_dnvk_e50p"]);
  }

  if(self.exfil_kill_count >= self.exfil_kill_requirement) {
    thread _id_0720::play_narration(["zm_cmcp_obex_dnrt_erpa", "zm_cmcp_obex_dsrx_erpa", "zm_cmcp_obex_blkr_erpa", "zm_cmcp_obex_dnvk_erpa"]);
    self.kill_count_reached = 1;
    level notify("exfil_kill_count_reached");
  }
}

_id_8D05() {
  level endon("game_ended");
  var_0 = _id_06FE::_id_68A1("axis");

  foreach(var_2 in var_0) {
    var_2 dodamage(var_2.health + 990, var_2.origin);
  }
}

cleanup_exfil_portal_ui() {
  level endon("game_ended");
  wait 3.5;

  foreach(var_1 in level.players) {
    if(!isDefined(var_1.exfil_portal_text)) {
      continue;
    }
    var_1.exfil_portal_text fadeovertime(0.15);
    var_1.exfil_portal_text.alpha = 0;
  }
}

_id_385C() {
  _id_0987::_id_C413("exfill_loc", self._id_5726);
  self._id_5726 = undefined;
  level thread _id_0991::_id_E8E2(1);
  level thread scripts\cp\zombies\objective_barriers::toggle_objective_clip(self._id_3BE8["prop"], 0);

  if(isDefined(self._id_572C)) {
    self._id_572C delete();
  }

  if(isDefined(self._id_5723)) {
    self._id_5723 delete();
  }

  if(isDefined(self._id_EACB) && self._id_EACB) {
    return;
  }
}

show_activated_start_interact() {
  self setscriptablepartstate("content_interact", "activated");
}

on_player_spawned() {
  if(isDefined(level._id_3BE9) && isDefined(level._id_3BE9._id_0F51) && scripts\engine\utility::is_equal(level._id_3BE9._id_0F51._id_3BE5, "exfil")) {
    var_0 = _func_00BE("ui_zm_objective_subobj_id");
    var_0 = scripts\cp\utility::_id_459B(var_0, 0);

    if(var_0 == 0) {
      _id_0987::set_objective_ui_counter(level._id_3BE9._id_0F51.exfil_kill_count, level._id_3BE9._id_0F51.exfil_kill_requirement);
    } else {
      var_1 = 0;

      if(isDefined(level._id_3BE9._id_0F51.exfil_portal_start_time)) {
        var_2 = (gettime() - level._id_3BE9._id_0F51.exfil_portal_start_time) / 1000;
        var_1 = int(_func_0037(120 - var_2));
      }

      _id_0987::set_objective_ui_time(var_1);
    }

    _id_0987::set_objective_ui_state(3, var_0, 1);
  }
}

give_exfil_reward() {
  foreach(var_1 in level.players) {
    var_2 = _id_0756::_id_6D0C("exfil_rank_" + level._id_11049, "xp");
    var_1 _id_0756::giverankxp("exfil_rank_" + level._id_11049, var_2);
    var_1 _id_0756::givebattlepassparticipationxp();
  }
}

toggle_all_exfil_portal_clip(var_0) {
  var_1 = getEntArray("exfil_portal_clip", "script_noteworthy");

  foreach(var_3 in var_1) {
    if(var_0) {
      var_3 _meth_80B5();
      var_3 show();
      continue;
    }

    var_3 _meth_8093();
    var_3 hide();
  }
}

toggle_exfil_portal_clip(var_0) {
  var_1 = getent(self._id_0481 + "_clip", "targetname");

  if(!isDefined(var_1)) {
    return;
  }
  if(var_0) {
    var_1 _meth_80B5();
    var_1 show();
  } else {
    var_1 _meth_8093();
    var_1 hide();
  }
}

watch_round_complete() {
  level endon("game_ended");

  for(;;) {
    level waittill("round_complete");
    var_0 = scripts\cp\utility::_id_459B(level._id_11049, 1);

    if(!is_exfil_round(var_0)) {
      continue;
    }
    if(wait_for_radio_interaction(90)) {
      break;
    }
  }
}

is_exfil_round(var_0) {
  if(var_0 < 10) {
    return 0;
  }

  var_1 = scripts\engine\utility::_id_5C0C("disallow_rbz_exfil") && scripts\engine\utility::_id_5C00("disallow_rbz_exfil");
  var_2 = !var_1;

  if(var_2) {
    if(isDefined(level.specific_exfil_round) && level.specific_exfil_round == var_0) {
      level.specific_exfil_round = undefined;
      return 1;
    }

    if((var_0 - 10) % 5 == 0) {
      level.specific_exfil_round = undefined;
      return 1;
    }
  } else if((var_0 - 10) % 5 == 0) {
    level.specific_exfil_round = var_0 + 1;
    return 0;
  }

  return 0;
}

wait_for_radio_interaction(var_0) {
  init_exfil_start_interact();

  if(level.mapname == "cp_zm_oasis") {
    if(isDefined(level.loadeddestination) && level.loadeddestination != "cp_zm_oasis_drk_tr") {
      if(!scripts\engine\utility::_id_5C00("force_cut_exfil_vo")) {
        thread _id_0720::play_narration(["zm_cpm4_rbm4_krft_mgp0", "zm_cpm4_rbm4_krft_mgp1", "zm_cpm4_rbm4_krft_mgp2", "zm_cpm4_rbm4_krft_mgp3", "zm_cpm4_rbm4_krft_mgp4", "zm_cpm4_rbm4_krft_mgp5", "zm_cpm4_rbm4_krft_mgp6", "zm_cpm4_rbm4_krft_mgp7", "zm_cpm4_rbm4_krft_mgp8", "zm_cpm4_rbm4_krft_mgp9"]);
      }
    }
  } else if(!scripts\engine\utility::_id_5C00("force_cut_exfil_vo"))
    thread _id_0720::play_narration(["zm_cpm4_rbm4_krft_mgp0", "zm_cpm4_rbm4_krft_mgp1", "zm_cpm4_rbm4_krft_mgp2", "zm_cpm4_rbm4_krft_mgp3", "zm_cpm4_rbm4_krft_mgp4", "zm_cpm4_rbm4_krft_mgp5", "zm_cpm4_rbm4_krft_mgp6", "zm_cpm4_rbm4_krft_mgp7", "zm_cpm4_rbm4_krft_mgp8", "zm_cpm4_rbm4_krft_mgp9"]);

  var_1 = level scripts\engine\utility::_id_108A8(var_0, "exfil_radio_interacted", "round_complete");

  if(isDefined(var_1) && (var_1 == "timeout" || var_1 == "round_complete")) {
    hide_exfil_interact();

    if(level.mapname == "cp_zm_oasis") {
      if(isDefined(level.loadeddestination) && level.loadeddestination != "cp_zm_oasis_drk_tr") {
        if(!scripts\engine\utility::_id_5C00("force_cut_exfil_vo")) {
          thread _id_0720::play_narration(["zm_cpm4_rbm4_krft_mgq0", "zm_cpm4_rbm4_krft_mgq1", "zm_cpm4_rbm4_krft_mgq2", "zm_cpm4_rbm4_krft_mgq3", "zm_cpm4_rbm4_krft_mgq4", "zm_cpm4_rbm4_krft_mgq5", "zm_cpm4_rbm4_krft_mgq6", "zm_cpm4_rbm4_krft_mgq7", "zm_cpm4_rbm4_krft_mgq8", "zm_cpm4_rbm4_krft_mgq9"]);
        }
      }
    } else if(!scripts\engine\utility::_id_5C00("force_cut_exfil_vo"))
      thread _id_0720::play_narration(["zm_cpm4_rbm4_krft_mgq0", "zm_cpm4_rbm4_krft_mgq1", "zm_cpm4_rbm4_krft_mgq2", "zm_cpm4_rbm4_krft_mgq3", "zm_cpm4_rbm4_krft_mgq4", "zm_cpm4_rbm4_krft_mgq5", "zm_cpm4_rbm4_krft_mgq6", "zm_cpm4_rbm4_krft_mgq7", "zm_cpm4_rbm4_krft_mgq8", "zm_cpm4_rbm4_krft_mgq9"]);

    return 0;
  }

  return 1;
}

disallow_exfil_after_exfil_spawn_monitor() {
  level endon("exfil_radio_interacted");
  level endon("round_complete");
  level endon("hide_exfil");
  scripts\engine\utility::_id_5C24("disallow_rbz_exfil");
  level thread hide_exfil_interact();
}

watch_spawn_exfil_interact() {
  level waittill("exfil_kill_count_reached");
  level thread _id_0991::_id_E8E2(0);
  _id_D1F5();
  childthread _id_E135(self._id_5716, self, "s4_zm_exfil_end_01");
  wait 1;
  _id_0987::set_objective_ui_state(3, 1, 4);
  var_0 = scripts\engine\utility::getStructArray(self._id_5716._id_0481, "target");
  level thread _id_0991::_id_C9FC("cp_zm_zod_exfil_final", var_0[0]._id_0481);
}

on_zombie_spawned(var_0) {
  if(!isDefined(var_0._id_82FC) || !isDefined(var_0._id_122C) || !isDefined(var_0._id_CE18)) {
    return;
  }
  var_0._id_122C thread watch_zone_enable(var_0._id_CE18);
}

watch_zone_enable(var_0) {
  level endon("game_ended");
  self endon("death");

  while(isalive(self)) {
    var_1 = scripts\cp\zone_manager::get_zone_struct(var_0);

    if(isDefined(var_1) && istrue(var_1.is_enabled)) {
      if(!scripts\aitypes\zombie_common\awareness::is_aware()) {
        scripts\aitypes\zombie_common\awareness::set_aware();
      }

      break;
    } else if(scripts\aitypes\zombie_common\awareness::is_aware())
      scripts\aitypes\zombie_common\awareness::set_unaware();

    wait 1;
  }
}