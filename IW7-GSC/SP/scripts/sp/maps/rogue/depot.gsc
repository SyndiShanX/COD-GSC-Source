/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\rogue\depot.gsc
*******************************************/

_id_5251() {
  scripts\sp\maps\rogue\rogue_util::_id_BC53("depot_start_player");
  level._id_10AC8 = scripts\sp\maps\rogue\rogue_util::_id_10626("depot_start", ["Salter"]);
  scripts\engine\utility::flag_set("player_is_inside");
  scripts\engine\utility::flag_set("sun_safe_zone");
  scripts\engine\utility::flag_set("pa_active");
  scripts\engine\utility::flag_set("open_depot_airlock");
  scripts\engine\utility::flag_set("ctrl_room_done");
  scripts\engine\utility::flag_set("interior_quakes");
  scripts\engine\utility::flag_set("disable_sun_logic");
  scripts\engine\utility::flag_clear("sun_vision_blend");
  scripts\sp\maps\rogue\rogue_util::_id_11206(1);
}

_id_F0D1() {
  precachemodel("ind_light_led_worklight");
  precachemodel("ind_light_led_worklight_on");
}

_id_F0CB() {
  scripts\engine\utility::flag_init("depot_combat_engage");
  scripts\engine\utility::flag_init("depot_combat_started");
  scripts\engine\utility::flag_init("depot_end");
  scripts\engine\utility::flag_init("open_depot_airlock");
  scripts\engine\utility::flag_init("start_unaware");
  scripts\engine\utility::flag_init("activate_peek_bots");
  scripts\engine\utility::flag_init("peek_guy_dead");
  scripts\engine\utility::flag_init("flag_dialogue_pit_done");
  scripts\engine\utility::flag_init("breaking_bridge");
  scripts\engine\utility::flag_init("MCO_jump_depot_pit");
  scripts\engine\utility::flag_init("player_in_depot");
  scripts\engine\utility::flag_init("player_in_depot_pit");
  scripts\engine\utility::flag_init("stop_depot_cam_fx");
  scripts\engine\utility::flag_init("no_power_sfx");
}

_id_F0D2() {}

_id_3B54() {
  foreach(var_1 in level.allies) {
    var_1.disableplayeradsloscheck = 0;
  }
}

_id_5244() {
  thread additional_light_fixtures();
  thread _id_57A3();
  _id_0A03::_id_F728(0, 0.05);
  thread _id_524F();
  level._id_5A5E = 0;
  thread scripts\sp\utility::_id_2669();
  thread _id_523D();
  thread _id_3B54();
  scripts\engine\utility::array_thread(level._id_10AC8, scripts\sp\maps\rogue\rogue_util::_id_12984);
  _id_1ABA();
  level.player scripts\sp\utility::_id_F526("normal");

  foreach(var_1 in level._id_10AC8) {
    var_1 _meth_8250(1);
  }

  thread _id_0B1F::_id_1AAA("depot_exit_airlock");
  thread _id_1D12();
  thread _id_EF27();
  thread _id_524B();
  thread _id_5243();
  thread _id_CBE4();
  setglobalsoundcontext("atmosphere", "helmet", 1);
  scripts\engine\utility::flag_wait_any("peek_guy_dead", "power_off_depot_stairs");
  scripts\sp\maps\rogue\rogue_util::_id_119AF(0);
  thread _id_523E();
  scripts\engine\utility::array_thread(level._id_10AC8, scripts\sp\maps\rogue\rogue_util::_id_12958);
  _id_523B();
  _id_523C();
  scripts\engine\utility::flag_wait("depot_combat_finished");

  foreach(var_1 in level._id_10AC8) {
    var_1 _meth_8250(0);
  }

  thread scripts\sp\maps\rogue\rogue_util::_id_B344(1, undefined, "stratcom");
  _id_F0CA();
}

_id_6ED3() {
  if(!isDefined(self._id_AC92)) {
    self._id_AC92 = spawn("script_model", (0, 0, 0));
    self._id_AC92 setModel("tag_origin");
    self._id_AC92 _meth_81E2(self, "tag_flash", (5, 0, -5), (0, 0, 0), 1);
  }

  while(!scripts\engine\utility::flag("player_in_depot_pit")) {
    wait(randomfloatrange(0.75, 1.5));

    if(scripts\engine\utility::flag("power_on")) {
      killfxontag(level._effect["ra_flashlight"], self._id_AC92, "tag_origin");
    } else {
      playFXOnTag(level._effect["ra_flashlight"], self._id_AC92, "tag_origin");
    }

    var_0 = level scripts\engine\utility::waittill_any_return("power_on", "power_off", "player_in_depot_pit");
  }

  killfxontag(level._effect["ra_flashlight"], self._id_AC92, "tag_origin");
}

_id_524C() {
  wait 25;
  var_0 = "rogue_steam_hiss_medium_close_deep";
  var_1 = (80, 800, 500);

  while(!scripts\engine\utility::flag("breaking_bridge")) {
    if(scripts\engine\utility::cointoss()) {
      var_0 = "rogue_steam_hiss_medium_close_deep";
    } else if(scripts\engine\utility::cointoss()) {
      var_0 = "scn_rogue_finale_dropship_impt_shake";
    } else if(scripts\engine\utility::cointoss()) {
      var_0 = "pnr_capship_settle";
    } else {
      var_0 = "finale_doors_open_fast";
    }

    if(scripts\engine\utility::cointoss()) {
      var_1 = (80, 800, 500);
    } else if(scripts\engine\utility::cointoss()) {
      var_1 = (-800, 0, -800);
    } else if(scripts\engine\utility::cointoss()) {
      var_1 = (-10, -800, 800);
    } else {
      var_1 = (0, 0, 800);
    }

    thread scripts\engine\utility::play_sound_in_space(var_0, level.player.origin + var_1);
    wait(randomfloatrange(0.3, 9.5));
  }
}

_id_523E() {
  wait 19;
  _id_5239("c6_hostile_burst");
  wait 2.25;
  _id_5239("c6_0_inform_incoming_c6");
  wait 3.25;
  _id_5239("c6_0_resp_ack_co_gnrc_affirm");
  wait 2.25;
  _id_5239("c6_0_inform_incoming_c6");
  wait 3.25;
  _id_5239("c6_0_resp_ack_co_gnrc_affirm");
  wait 2.25;
  _id_5239("c6_0_inform_incoming_c6");
  wait 3.25;
  _id_5239("c6_0_resp_ack_co_gnrc_affirm");
  wait 2.25;
  _id_5239("c6_0_inform_incoming_c6");
  wait 1.25;
  _id_5239("c6_0_resp_ack_co_gnrc_affirm");
}

_id_5239(var_0) {
  var_1 = getaiarray("axis");

  if(isDefined(var_1) && var_1.size > 0 && isDefined(var_0)) {
    var_1[randomint(var_1.size)] playSound(var_0);
  }
}

_id_523D() {
  var_0 = getspawnerarray("door_peek_spawners");
  level waittill("door_handle_down");
  thread scripts\sp\maps\rogue\rogue_util::remove_navigating_equipment();
  thread _id_59C2();

  foreach(var_2 in var_0) {
    var_3 = var_2 scripts\sp\utility::_id_10619(1);
    thread _id_59C1(var_3);
  }
}

_id_59C2() {
  scripts\engine\utility::flag_set("no_power_sfx");
  wait(randomintrange(1, 3));
  thread scripts\engine\utility::play_sound_in_space("c6_0_inform_incoming_generic", (32769, 38933, -423));
  wait(randomintrange(2, 4));
  thread scripts\engine\utility::play_sound_in_space("c6_hostile_burst", (32769, 38933, -423));
}

_id_59C1(var_0) {
  var_0 thread _id_135F4();
  var_0.dontmelee = 1;
  var_0.ignoreall = 1;
  var_0.ignoreme = 1;
  var_0.fixednode = 1;

  while(_id_0B1E::_id_794C("depot_airlock_door") <= 32) {
    wait 0.05;
  }

  scripts\engine\utility::flag_set("activate_peek_bots");
  scripts\engine\utility::flag_set("combat_section_active");

  if(isalive(var_0)) {
    var_0.ignoreall = 0;
    var_0.ignoreme = 0;
    var_0.fixednode = 0;
    var_0 waittill("death");
  }

  scripts\engine\utility::flag_set("peek_guy_dead");
}

_id_135F4() {
  level endon("activate_peek_bots");
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(var_1 == level.player) {
      break;
    }
  }

  scripts\engine\utility::flag_set("activate_peek_bots");
}

_id_523B() {
  thread _id_2D15();
  thread _id_10A4E();
  var_0 = getEntArray("initial_depot_sec_spawner", "targetname");
  var_1 = getEntArray("initial_depot_snipers", "targetname");
  var_2 = getglassarray("depot_sniper_glass");

  foreach(var_4 in var_0) {
    var_4.count = 5;
  }

  scripts\sp\utility::_id_6F54(var_0);

  foreach(var_7 in level._id_10AC8) {}

  level.player.ignoreme = 1;
  wait 0.05;
  var_9 = getaiarray("axis");
  _id_135FB();
  level notify("depot_power_up");
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_CF8D();
  thread _id_107DD();
  level.player.ignoreme = 0;

  foreach(var_7 in level._id_10AC8) {
    var_7.ignoreall = 0;
    var_7.ignoreme = 0;
  }

  level.player.ignoreme = 0;
  thread _id_5241();
  wait 2.5;

  foreach(var_13 in var_2) {
    destroyglass(var_13, (0, 90, 0));
  }
}

_id_5241() {
  wait 1;
  var_0 = getaiarray("axis");
  var_0 = scripts\sp\utility::array_removedeadvehicles(var_0);

  foreach(var_2 in var_0) {
    if(var_2.classname == "actor_enemy_c6_sniper") {
      var_2.fixednode = 1;
    }
  }
}

_id_107DD() {
  var_0 = getEnt("depot_lower_sniper", "targetname");
  var_1 = var_0 scripts\sp\utility::_id_10619(1);
  var_1.fixednode = 1;
}

_id_523C() {
  scripts\engine\utility::flag_wait("depot_spawn_wave_2");
  var_0 = getEntArray("depot_wave_2_spawner", "targetname");

  foreach(var_2 in var_0) {
    var_2.count = 3;
  }

  scripts\sp\utility::_id_6F54(var_0);
}

_id_135FB() {
  scripts\engine\utility::flag_wait("kickoff_enemy_bots_depot");
  thread _id_10AC0();
  thread scripts\sp\utility::_id_2669();
  level._id_5A5E = 1;
  level notify("timer_stop");
  scripts\engine\utility::flag_set("start_unaware");
}

_id_10AC0() {
  var_0 = getEnt("sprint_contain_spawner", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  scripts\sp\utility::_id_22CA("sprint_contrain_spawn", ::_id_F5A7);
  wait 5;
  var_0 delete();
}

_id_F5A7() {
  self endon("death");
  self.fixednode = 1;
  var_0 = spawn("trigger_radius", self.origin, 0, 150, 384);

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(var_1 == level.player) {
      var_2 = self._id_2894;
      self._id_2894 = 9999;
      thread _id_9359();

      while(distance(level.player.origin, self.origin) <= 150) {
        wait 0.1;
      }

      self._id_2894 = var_2;
      self notify("stop_improving_damage");
    }
  }
}

_id_9359() {
  self endon("stop_improving_damage");
  self endon("death");

  for(;;) {
    level.player waittill("damage", var_0, var_1);

    if(var_1 == self) {
      level.player dodamage(var_0 * 2, self.origin, self);
    }
  }
}

_id_7C42() {
  level endon("timer_stop");
  scripts\engine\utility::flag_wait("start_watcher_countdown");
  wait 12;
  scripts\engine\utility::flag_set("start_watcher_countdown");
}

_id_2D15() {
  var_0 = getEnt("depot_bot_blocker", "targetname");
  var_0.origin = var_0.origin - (0, 0, 30);
  var_0 connectpaths();
  var_0.origin = var_0.origin + (0, 0, 200);
  scripts\sp\utility::_id_127B3("depot_bot_blocker_trig");

  while(!scripts\engine\utility::flag("depot_combat_finished")) {
    scripts\engine\utility::flag_wait("depot_bot_blocker_flag");
    var_0.origin = var_0.origin - (0, 0, 200);
    var_0 disconnectPaths();
    scripts\engine\utility::flag_waitopen("depot_bot_blocker_flag");
    var_0 connectpaths();
    var_0.origin = var_0.origin + (0, 0, 200);
  }
}

_id_1ABA() {
  foreach(var_1 in level._id_10AC8) {
    var_1 _meth_82EE(getnode("depot_start" + var_1._id_111B7, "targetname"));
  }

  var_3 = scripts\sp\maps\rogue\rogue_util::_id_F943("canyon_airlock_door");
  var_4 = getEnt("cr_exit_clip", "targetname");
  thread _id_0B1E::_id_59BE("depot_airlock_door");
  level waittill("door_peek_blend_complete");
  scripts\engine\utility::flag_clear("scbt_ignore_combat");
  thread _id_523F();
  level notify("light_depot_off");
  scripts\sp\utility::_id_10FEC("ra_02");
  var_3 rotateYaw(120, 0.05, 0, 0);
  thread _id_11612();

  while(_id_0B1E::_id_794C("depot_airlock_door") <= 42) {
    wait 0.05;
  }

  scripts\engine\utility::flag_set("player_in_depot");

  foreach(var_1 in level._id_10AC8) {
    if(isDefined(var_1._id_1FBD)) {
      var_1._id_1FBD notify("stop_cr_loop");
    }
  }

  wait 0.05;
  var_4 disconnectPaths();
}

_id_11612() {
  foreach(var_1 in level.allies) {
    if(!isDefined(level._id_13E12) || var_1 != level._id_13E12) {
      var_1 _meth_83A1();
      var_2 = "depot_start" + var_1._id_111B7;
      var_3 = getnode(var_2, "targetname");
      var_1 _meth_80F1(var_3.origin, var_3.angles);
    }
  }
}

_id_523F() {
  scripts\engine\utility::flag_set("disable_sun_logic");
  scripts\engine\utility::flag_clear("sun_vision_blend");
  scripts\sp\maps\rogue\rogue_util::_id_11206(1);
  thread scripts\sp\maps\rogue\rogue_util::_id_9A6C(30, 6, 1, "power_off_depot_stairs", 0.05);
  var_0 = gettime();
  scripts\engine\utility::flag_wait("power_off_depot_stairs");

  if(var_0 < 5000) {
    wait(5000 - var_0);
  }

  thread scripts\sp\maps\rogue\rogue_util::_id_9A6C(30, 4, 0, "kickoff_enemy_bots_depot", 0.05);
  level waittill("kickoff_enemy_bots_depot");
}

_id_1D12() {
  foreach(var_1 in level._id_10AC8) {
    var_1 scripts\sp\utility::_id_54F7();
  }

  var_3 = getEnt("initial_depot_color_trig", "targetname");
  var_3 notify("trigger");
  var_4 = [level._id_B4F9, level._id_B33B, level._id_B33E];
  var_5 = 0.1;

  foreach(var_1 in var_4) {
    var_1 scripts\engine\utility::delaythread(var_5, scripts\sp\utility::_id_61C7);
    var_5 = var_5 + 1.5;
  }

  thread scripts\sp\maps\rogue\rogue_util::_id_B344(10, "player_in_depot_pit", "mines");
}

_id_5250() {
  var_0 = getscriptablearray("scriptable_onoff", "script_noteworthy");
  thread scripts\sp\maps\rogue\rogue_util::_id_EF3D(var_0, "screen", "on", "off");
}

_id_524B() {
  var_0 = scripts\engine\utility::getStructArray("depot_fx_topper", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread _id_CE6C();
  }
}

_id_CE6C() {
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0.origin = self.origin;

  for(;;) {
    scripts\engine\utility::flag_wait("power_on");
    playFXOnTag(level._effect["vfx_red_strobe"], var_0, "tag_origin");
    scripts\engine\utility::flag_waitopen("power_on");
    killfxontag(level._effect["vfx_red_strobe"], var_0, "tag_origin");
  }
}

_id_5243() {
  var_0 = getEntArray("depot_light_ent", "targetname");
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\rogue\rogue_lights::_id_4CBB, 4, 0.01, "power_on", "power_off", "depot_end");
}

_id_2C83() {
  level endon("player_in_pit");
  var_0 = undefined;

  while(!isDefined(var_0)) {
    var_1 = getaiarray("axis");

    foreach(var_3 in var_1) {
      if(isDefined(var_3.script_parameters) && var_3.script_parameters == "bonus_guy") {
        var_0 = var_3;
        break;
      }
    }

    wait 1;
  }

  var_0 endon("death");

  for(;;) {
    var_0 waittill("damage", var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);

    if(var_6 == level.player && _id_7AD4() <= 3) {
      var_15 = scripts\sp\utility::_id_15F5("bonus_wave_trig");
      break;
    }
  }
}

_id_7AD4() {
  level endon("player_in_pit");
  var_0 = getaiarray("axis");
  var_0 = scripts\sp\utility::array_removedeadvehicles(var_0);
  var_1 = 0;

  foreach(var_3 in var_0) {
    if(var_3.classname == "actor_enemy_c6_worker") {
      var_1++;
    }
  }

  return var_1;
}

_id_EF27() {
  wait 1;
  var_0 = getscriptablearray("depot_cart", "targetname");

  while(!scripts\engine\utility::flag("flag_cvl_door")) {
    scripts\engine\utility::flag_wait("power_on");

    foreach(var_2 in var_0) {
      var_2 setscriptablepartstate("onoff", "on");
    }

    scripts\engine\utility::flag_waitopen("power_on");

    foreach(var_2 in var_0) {
      var_2 setscriptablepartstate("onoff", "off");
    }
  }
}

_id_10A4E() {
  scripts\sp\utility::_id_127B3("depot_split_group_off_trig");
  level._id_B33B scripts\sp\utility::_id_F3B5("o");
}

_id_F922() {
  var_0 = scripts\engine\utility::getStruct("depot_corpse_node1", "targetname");
  var_1 = scripts\sp\maps\rogue\rogue_util::_id_F9D4("miner_corpse", 3, "head_rorke_assault_injured");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_0 scripts\sp\anim::_id_1EC3(var_1[var_2], "depot_corpse_" + var_2);
  }
}

_id_11613() {
  if(!scripts\engine\utility::flag("tp_depot_flag_catwalk") || !scripts\engine\utility::flag("tp_depot_flag_stairs")) {
    scripts\engine\utility::flag_wait_any("tp_depot_flag_catwalk", "tp_depot_flag_stairs");
  }

  if(scripts\engine\utility::flag("tp_depot_flag_catwalk")) {
    var_0 = getnode("tp_depot_nodeMCO_catwalk", "targetname");
    var_1 = getnode("tp_depot_nodeMarine1_catwalk", "targetname");
    var_2 = getnode("tp_depot_nodeMarine2_catwalk", "targetname");
    var_3 = "do_not_teleport_depot_catwalk";
  } else {
    var_0 = getnode("tp_depot_nodeMCO_stairs", "targetname");
    var_1 = getnode("tp_depot_nodeMarine1_stairs", "targetname");
    var_2 = getnode("tp_depot_nodeMarine2_stairs", "targetname");
    var_3 = "do_not_teleport_depot_stairs";
  }

  level._id_B4F9 thread _id_1161D(var_0, var_3);
  level._id_B33B thread _id_1161D(var_1, var_3);
  level._id_B33E thread _id_1161D(var_2, var_3);
}

_id_1161D(var_0, var_1) {
  level endon("player_in_depot_pit");

  if(scripts\sp\utility::_id_65DF(var_1) == 0) {
    while(scripts\sp\utility::_id_CFAC(self)) {
      wait 0.1;
    }

    if(isDefined(self.melee)) {
      self.melee._id_2720 = 1;
    }

    wait 0.1;
    self _meth_80F1(var_0.origin, var_0.angles);
  }
}

_id_57A3() {
  var_0 = getEnt("do_not_teleport_depot_catwalk", "targetname");
  var_1 = getEnt("do_not_teleport_depot_stairs", "targetname");
  var_0 thread _id_57A4();
  var_1 thread _id_57A4();
  scripts\engine\utility::flag_wait_any("tp_depot_flag_catwalk", "tp_depot_flag_stairs");
  wait 1;
  var_0 delete();
  var_1 delete();
}

_id_57A4() {
  level endon("tp_depot_flag_catwalk");
  level endon("tp_depot_flag_stairs");

  for(;;) {
    self waittill("trigger", var_0);

    if(var_0 scripts\sp\utility::_id_65DF(self.targetname) == 0) {
      var_0 scripts\sp\utility::_id_65E0(self.targetname);
      var_0 scripts\sp\utility::_id_65E1(self.targetname);
    }
  }
}

_id_F0CA() {
  scripts\sp\maps\rogue\rogue_util::_id_75D6();
  scripts\sp\maps\rogue\rogue_util::_id_40BF();
}

_id_3B55() {
  scripts\engine\utility::flag_set("depot_finished");

  foreach(var_1 in level.allies) {
    var_1.disableplayeradsloscheck = 1;
  }
}

_id_5249() {
  scripts\sp\maps\rogue\rogue_util::_id_BC53("depot_pit_start_player");
  level._id_10AC8 = scripts\sp\maps\rogue\rogue_util::_id_10626("depot_pit_start", ["Salter"], 1);
  scripts\engine\utility::flag_set("player_is_inside");
  scripts\engine\utility::flag_set("sun_safe_zone");
  scripts\engine\utility::flag_set("pa_active");
  scripts\engine\utility::flag_set("disable_sun_logic");
  scripts\engine\utility::flag_clear("sun_vision_blend");
  scripts\sp\maps\rogue\rogue_util::_id_11206(1);
  thread scripts\sp\maps\rogue\rogue_util::_id_9A6C(12, 12, 1);
  thread _id_CBE4();
  thread scripts\sp\maps\rogue\rogue_util::_id_B344(4, undefined, "stratcom");
}

_id_5248() {
  foreach(var_1 in level.allies) {
    var_1.disableplayeradsloscheck = 1;
  }

  thread _id_4069();
  scripts\sp\maps\rogue\rogue_util::_id_119AF(1);
  thread _id_11613();
  level._id_B33B scripts\sp\utility::_id_F3B5("b");
  level._id_B33E scripts\sp\utility::_id_F3B5("r");
  scripts\sp\utility::_id_15F5("depot_pit_bk_movement_start");
  thread _id_B4FD();
  scripts\engine\utility::array_thread(level._id_10AC8, scripts\sp\utility::_id_51E1, "sprint");
  scripts\sp\utility::_id_15F5("allytrig_lava_start");
  scripts\engine\utility::flag_set("player_is_inside");
  scripts\sp\utility::_id_28D7();
  scripts\sp\utility::_id_CF8B();
  thread scripts\sp\utility::_id_2669();
  thread _id_6873();
  thread _id_CBE6();
  thread _id_CBE8();
  setglobalsoundcontext("atmosphere", "helmet", 1);
  scripts\engine\utility::flag_wait("depot_finished");
  scripts\engine\utility::array_thread(level._id_10AC8, scripts\sp\utility::_id_F3B5, "g");
  scripts\sp\utility::_id_15F5("allytrig_civ_door");
  _id_F0CA();
}

_id_4069() {
  var_0 = getaiarray("axis");
  var_0 = scripts\sp\utility::array_removedeadvehicles(var_0);

  foreach(var_2 in var_0) {
    var_2 thread _id_A5D1();
  }
}

_id_A5D1() {
  self endon("death");
  var_0 = scripts\sp\utility::_id_7951(level.player.origin, level.player getplayerangles(), self.origin);

  while((var_0 > 0.2 || distance2d(level.player.origin, self.origin) >= 384) && !scripts\engine\utility::flag("player_in_depot_pit")) {
    var_0 = scripts\sp\utility::_id_7951(level.player.origin, level.player getplayerangles(), self.origin);
    wait 3;
  }

  wait(randomfloatrange(1, 4));
  self _meth_81D0();
}

_id_B4FD() {
  level._id_B4F9 scripts\sp\utility::_id_54F7();
  var_0 = scripts\engine\utility::getStruct("struct_ally_tankstop", "targetname");
  level._id_B4F9 setgoalpos(var_0.origin);
  scripts\engine\utility::flag_wait("MCO_jump_depot_pit");
  level._id_B4F9 scripts\sp\utility::_id_61C7();
  level._id_B4F9 scripts\sp\utility::_id_F3B5("y");
  scripts\sp\utility::_id_15F5("depot_pit_post_tank_crash");
}

_id_6873() {
  var_0 = getEnt("depot_pit_fuel_tank", "targetname");
  var_0._id_1FBB = "tank";
  var_1 = var_0 scripts\engine\utility::get_target_ent();
  var_2 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  var_0 scripts\sp\anim::_id_F64A();
  var_1 linkTo(var_0);
  var_2 scripts\sp\anim::_id_1EC3(var_0, "pit_collapse");
  scripts\engine\utility::flag_wait("clean_up_depot_enemies");

  if(!level.console) {
    waitforalltransients();
  }

  scripts\engine\utility::flag_clear("combat_section_active");
  var_2 thread scripts\sp\anim::_id_1F35(var_0, "pit_collapse");
  thread _id_5471();
  wait 2.5;
  var_0 playSound("scn_rogue_tank_crash");
  wait 1.25;
  scripts\engine\utility::flag_set("breaking_bridge");
  scripts\engine\utility::exploder("exploder_tank_sink");
  scripts\engine\utility::array_call(level._id_5247, ::show);

  foreach(var_4 in level._id_5246) {
    var_4 rotatevelocity((randomfloatrange(50, 100), randomfloatrange(50, 100), randomfloatrange(50, 100)), 1);
  }

  scripts\engine\utility::array_call(level._id_5246, ::movegravity, (100, -100, 0), 1);
  scripts\engine\utility::flag_wait_or_timeout("flag_depot_pit_jump", 5);
  scripts\engine\utility::flag_set("force_flashlights_on");
  scripts\engine\utility::array_thread(level._id_10AC8, scripts\sp\utility::_id_51E1, "sprint");
  scripts\engine\utility::delaythread(2, scripts\sp\utility::_id_10FEC, "exploder_tank_hit");
  scripts\engine\utility::flag_wait("flag_cvl_door");
  var_2 delete();
  var_1 delete();
  var_0 delete();
}

_id_5471() {
  level.player endon("death");
  scripts\engine\utility::flag_wait("breaking_bridge");
  level._id_B4F9 scripts\sp\utility::_id_10346("rogue_omr_backupbackup");
  scripts\engine\utility::flag_set("MCO_jump_depot_pit");
  level._id_B4F9 scripts\sp\utility::_id_10346("rogue_omr_wellhavetojump");
  level._id_B33B scripts\sp\utility::_id_10346("rogue_brk_dontlookdownkash");
  level._id_B33E scripts\sp\utility::_id_10346("rogue_ksh_cmonmanwhyyou");
  scripts\engine\utility::flag_wait("flag_depot_pit_jump");

  while(!level.player isonground()) {
    scripts\engine\utility::waitframe();
  }

  level.player scripts\sp\utility::_id_D090("ges_radio");
  level.player scripts\engine\utility::delaycall(0.5, ::playsound, "ges_plr_radio_on");
  level.player allowsprint(0);
  level._id_B33B scripts\sp\utility::_id_10346("asteroid_brk_wereclose");
  level.player scripts\sp\utility::_id_10350("asteroid_plr_feverraiderwere");
  level.player scripts\sp\utility::_id_10350("asteroid_slt_upandawaycontac");
  level.player playSound("ges_plr_radio_off");
  level.player scripts\sp\utility::_id_1102B();
  level.player allowsprint(1);
  scripts\engine\utility::flag_set("flag_dialogue_pit_done");
}

_id_1079C() {
  var_0 = [];
  var_1 = getEntArray("pit_bot_spawner", "targetname");
  var_0 = scripts\sp\utility::_id_22C6(var_1);
  scripts\engine\utility::array_thread(var_0, ::_id_CBE3);
  return var_0;
}

_id_CBE8() {
  level endon("depot_finished");

  while(!scripts\engine\utility::flag("depot_finished")) {
    while(scripts\engine\utility::flag("play_earthquakes_in_depot")) {
      var_0 = level.player.origin;
      playrumbleonposition("grenade_rumble", var_0);
      earthquake(0.3, 2, var_0, 400);
      wait(randomfloatrange(3, 4.5));
    }

    wait 0.2;
  }
}

_id_CBE6() {
  scripts\sp\utility::_id_127B3("depot_pit_jump_exploder_trig");
  scripts\engine\utility::exploder("depo_lava_burst_big");
}

_id_CBE3() {
  self.ignoreme = 1;
  self.ignoreall = 1;
}

_id_CBE4() {
  var_0 = getEntArray("depot_pit_corpse", "targetname");

  foreach(var_2 in var_0) {
    var_2._id_1FBB = "miner_corpse";
    var_2 scripts\sp\anim::_id_F64A();
    var_2 scripts\sp\anim::_id_1EC3(var_2, var_2.animation);
  }

  level.doors["civilian_buddydoor"] waittill("buddydoor_pull_complete");

  foreach(var_2 in var_0) {
    var_2 delete();
  }
}

_id_524F() {
  wait 0.2;
  var_0 = getscriptablearray("depot_screen_scriptable", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2 thread _id_524E();
  }
}

_id_524E() {
  while(!scripts\engine\utility::flag("stop_depot_cam_fx")) {
    var_0 = level scripts\engine\utility::waittill_any_return("power_on", "power_on");

    if(scripts\engine\utility::flag("power_on")) {
      self setscriptablepartstate("screen", "on");
      continue;
    }

    self setscriptablepartstate("screen", "off");
  }
}

additional_light_fixtures() {
  var_0 = [];
  var_0["jLight"]["ent"] = getEnt("depot_light_Jsong", "targetname");
  var_0["jLight"]["on"] = "ind_light_led_worklight_on";
  var_0["jLight"]["off"] = "ind_light_led_worklight";

  while(!scripts\engine\utility::flag("flag_cvl_start")) {
    foreach(var_2 in var_0) {
      if(scripts\engine\utility::flag("power_on") && isDefined(var_0["jLight"]["ent"])) {
        var_0["jLight"]["ent"] setModel(var_0["jLight"]["on"]);
        continue;
      }

      if(isDefined(var_0["jLight"]["ent"])) {
        var_0["jLight"]["ent"] setModel(var_0["jLight"]["off"]);
      }
    }

    level scripts\engine\utility::waittill_any("power_on", "power_off", "flag_cvl_start");
  }

  foreach(var_2 in var_0) {
    var_0["jLight"]["ent"] delete();
  }
}