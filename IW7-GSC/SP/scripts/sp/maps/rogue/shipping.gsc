/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\rogue\shipping.gsc
**********************************************/

_id_FE2A() {
  scripts\sp\maps\rogue\rogue_util::_id_BC53("shipping_nd_start_player");
  level._id_10AC8 = scripts\sp\maps\rogue\rogue_util::_id_10626("shipping_nd_start");
  scripts\engine\utility::flag_set("player_is_inside");
  scripts\engine\utility::flag_set("sun_safe_zone");
  scripts\engine\utility::flag_set("pa_active");
  scripts\engine\utility::flag_set("interior_quakes");
  level.doors["creep_exit_doors"] scripts\sp\utility::_id_65E1("door_sequence_complete");
}

_id_F0D1() {}

_id_F0CB() {
  scripts\engine\utility::flag_init("flag_floating_asteroids_visible");
  scripts\engine\utility::flag_init("shipping_done");
  scripts\engine\utility::flag_init("shipping_hall_look_at_the_player");
  scripts\engine\utility::flag_init("shipping_hall_spawn_2");
  scripts\engine\utility::flag_init("shipping_hall_spawn_3");
  scripts\engine\utility::flag_init("shipping_hall_move_up_1");
  scripts\engine\utility::flag_init("shipping_hall_move_up_2");
  scripts\engine\utility::flag_init("shipping_hall_move_up_3");
  scripts\engine\utility::flag_init("shipping_hall_move_up_4");
  scripts\engine\utility::flag_init("shipping_hall_move_up_5");
  scripts\engine\utility::flag_init("shipping_hall_move_up_6");
  scripts\engine\utility::flag_init("shipping_hall_move_up_7");
  scripts\engine\utility::flag_init("shipping_hall_move_up_8");
  scripts\engine\utility::flag_init("command_objective");
  scripts\engine\utility::flag_init("flag_main_dialogue_active");
  scripts\engine\utility::flag_init("flag_retreat_dialogue_active");
  scripts\engine\utility::flag_init("flag_defend_a_start");
  scripts\engine\utility::flag_init("flag_defend_a_early_playerrun");
  scripts\engine\utility::flag_init("flag_defend_a_end");
  scripts\engine\utility::flag_init("flag_proximity_hack_intro");
  scripts\engine\utility::flag_init("flag_shipping_defend_end");
  scripts\engine\utility::flag_init("flag_shipping_defend_exit");
  scripts\engine\utility::flag_init("flag_defend_b_final");
  scripts\engine\utility::flag_init("flag_defend_cleanup");
  scripts\engine\utility::flag_init("flag_player_opening_defend_door");
  scripts\engine\utility::flag_init("proximity_hack_end");
  scripts\engine\utility::flag_init("proximity_hacking_nodegrade");
  scripts\engine\utility::flag_init("ok_to_shut_ship_exit_door");

  if(!scripts\engine\utility::flag_exist("proximity_hacking"))
    scripts\engine\utility::flag_init("proximity_hacking");
}

_id_F0D2() {}

_id_3B89() {
  scripts\engine\utility::flag_set("command_objective");

  foreach(var_1 in level.allies)
  var_1.disableplayeradsloscheck = 0;
}

_id_FE28() {
  scripts\engine\utility::flag_clear("in_creep_hallway");
  thread _id_1DD1();
  thread _id_3BA6();
  scripts\engine\utility::array_thread(level._id_10AC8, scripts\sp\maps\rogue\rogue_util::_id_12984);
  scripts\engine\utility::flag_set("force_flashlights_on");
  scripts\sp\utility::_id_28D7();
  scripts\sp\utility::_id_CF8B();
  thread _id_73BF();
  level.player scripts\sp\utility::_id_D2CA(0.5);
  level.player allowdoublejump(1);
  thread _id_3B89();
  scripts\engine\utility::flag_set("player_is_inside");
  scripts\engine\utility::flag_set("flag_lgt_shipping_start");
  scripts\engine\utility::flag_set("night_kill");
  thread _id_4DE8();
  level._id_13E12 scripts\sp\utility::_id_F3B5("o");
  level._id_B4F9 scripts\sp\utility::_id_F3B5("b");
  level._id_B33B scripts\sp\utility::_id_F3B5("y");
  level._id_B33E scripts\sp\utility::_id_F3B5("r");
  scripts\engine\utility::array_thread(level.allies, scripts\sp\utility::_id_61C7);
  scripts\sp\utility::_id_15F5("initial_airlock_color_trig");
  setglobalsoundcontext("atmosphere", "helmet", 1);

  foreach(var_1 in level._id_10AC8)
  var_1 scripts\sp\utility::_id_51E1("cqb");

  if(level._id_10CDA != "shipping")
    level.doors["creep_exit_doors"] scripts\sp\utility::_id_65E3("begin_opening");

  var_3 = [1, 0.25, 0.09];
  level._id_111C3.light = 30 * vectorNormalize((var_3[0], var_3[1], var_3[2]));
  setsunlight(level._id_111C3.light[0], level._id_111C3.light[1], level._id_111C3.light[2]);
  level._id_111C3.ent linkTo(level._id_111C3._id_C6EA, "tag_origin", (17000, 40000, 0), (0, 0, 0));
  level._id_111C3._id_1EF6 linkTo(level._id_111C3._id_E6E5, "tag_origin", (0, 0, 0), (90, 0, 0));
  thread _id_FE26();
  scripts\sp\maps\rogue\rogue_util::_id_111EA((-44, -46, 0));

  if(level._id_10CDA == "shipping")
    scripts\sp\maps\rogue\rogue_util::_id_111E7(6.75, 50, 10, 250, 100);
  else
    scripts\sp\maps\rogue\rogue_util::_id_111E7(5.5, 50, 10, 250, 100);

  scripts\sp\maps\rogue\rogue_util::_id_111E9(0);
  level.doors["creep_exit_doors"] scripts\sp\utility::_id_65E3("door_sequence_complete");
  thread move_xo_up_safe();
  scripts\sp\maps\rogue\rogue_util::_id_111E9(undefined);
  wait 1.5;
  scripts\engine\utility::array_thread(level._id_10AC8, scripts\sp\maps\rogue\rogue_util::_id_12958);
  thread _id_FE2B();
  thread _id_FA40();
  thread init_defend_a_goals();
  thread scripts\sp\maps\rogue\rogue_util::_id_6E55("shipping_hall_tank_steam", ::_id_68A1);
  scripts\engine\utility::flag_set("shipping_hall_look_at_the_player");
  scripts\engine\utility::flag_wait("shipping_done");
  level notify("shipping_hall_done");
  level.doors["shipping_exit_doors"] scripts\sp\utility::_id_65E3("door_sequence_complete");
  scripts\engine\utility::array_thread(level._id_10AC8, scripts\sp\maps\rogue\rogue_util::_id_12958);
  scripts\engine\utility::flag_clear("interior_quakes");

  foreach(var_1 in level._id_10AC8)
  var_1 scripts\sp\utility::_id_51E1("combat");

  _id_F0CA();
}

move_xo_up_safe() {
  wait 4;
  var_0 = level._id_13E12.goalradius;
  level._id_13E12.goalradius = 64;
  var_1 = getEnt("move_salter_up_in_ship_hall", "targetname");

  if(isDefined(var_1))
    var_1 notify("trigger");

  scripts\engine\utility::waittill_any_timeout(5, "goal");
  level._id_13E12.goalradius = var_0;
}

_id_1DD1() {
  level endon("shipping_hall_done");
  var_0 = getspawnerarray("hallway_outside_spawner");

  for(;;) {
    var_1 = getaiarray("axis");
    var_2 = [];

    foreach(var_4 in var_1) {
      if(isDefined(var_4._id_BEEC))
        var_2[var_2.size] = var_4;
    }

    if(var_2.size < 7 && !scripts\engine\utility::flag("power_off")) {
      var_6 = scripts\engine\utility::random(var_0);
      var_6.count = 1;
      var_7 = var_6 scripts\sp\utility::_id_10619(1);
      var_7._id_BEEC = 1;
      var_7 dontcastshadows();
      _id_0E29::_id_877F(var_7);
      var_7 thread _id_1D7C();
    }

    wait(randomfloatrange(3.6, 6.3));
  }
}

_id_1D7C() {
  var_0 = scripts\engine\utility::getStructArray("ship_hall_climb_node", "targetname");
  var_0 = sortbydistance(var_0, level.player.origin);

  for(;;) {
    var_1 = scripts\engine\utility::random_weight_sorted(var_0);

    if(!isDefined(var_1._id_2A86)) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  var_2 = getnodearray("hall_ambient_bot_goals", "targetname");
  var_3 = scripts\engine\utility::random(var_2);
  self._id_1FBB = "worker_bot";
  self.ignoreall = 1;
  self.ignoreme = 1;
  var_1._id_2A86 = 1;
  var_1 scripts\sp\anim::_id_1F35(self, "climb1");
  var_1._id_2A86 = undefined;
  _id_0A03::_id_13DC1(0);
  self waittill("goal");
  self delete();
}

_id_3BA6() {
  var_0 = getEnt("glassbreaking_robot", "targetname");
  var_1 = getEnt("ceiling_bot_break_trigger", "targetname");
  var_2 = getglass("ceiling_bot_glass");
  var_0 waittill("trigger");
  scripts\sp\utility::_id_22CA("ceiling_break_through_bots", ::bot_disallow_hack_when_animating);
  scripts\sp\utility::_id_22CD("ceiling_break_through_bots");
  var_1 waittill("trigger");
  destroyglass(var_2);
}

bot_disallow_hack_when_animating() {
  self endon("death");
  _id_0E29::_id_877F(self);
  self waittill("single anim");
  wait 1;
  _id_0E29::_id_87D0(self);
}

_id_FE23() {
  wait 1;
  level._id_B33B scripts\sp\utility::_id_10346("asteroid_brk_contact");
  level._id_B33B thread scripts\sp\utility::_id_10346("rogue_ksh_crawlerunderthe");
  wait 0.55;
  _id_2EFB("c6_hostile_burst");
  wait 3.25;
  _id_2EFB("c6_0_inform_incoming_c6");
  wait 1.25;
  _id_2EFB("c6_0_resp_ack_co_gnrc_affirm");
  wait 1.0;
  _id_2EFB("c6_hostile_burst");
  level._id_B4F9 thread scripts\sp\utility::_id_10346("rogue_omr_keepputtinround");
  wait 0.7;
  _id_2EFB("c6_0_inform_incoming_c6");
  wait 0.5;
  _id_2EFB("c6_0_resp_ack_co_gnrc_affirm");
  wait 1.25;
  _id_2EFB("c6_0_resp_ack_co_gnrc_affirm");
  wait 1.0;
  _id_2EFB("c6_hostile_burst");
  wait 1.7;
  _id_2EFB("c6_0_inform_incoming_c6");
}

_id_2EFB(var_0) {
  var_1 = scripts\sp\utility::_id_77DA("enemygroup_shipping");

  if(isDefined(var_1) && var_1.size > 0 && isDefined(var_0))
    var_1[randomint(var_1.size)] playSound(var_0);
}

_id_68A1() {
  scripts\engine\utility::exploder("56");
  wait 1.5;
  scripts\engine\utility::exploder("57");
  thread scripts\engine\utility::play_sound_in_space("mtl_steam_pipe_hit", (27729, 44028, -532));
  thread scripts\engine\utility::play_sound_in_space("mtl_steam_pipe_hit", (27671, 44133, -545));
  wait 0.1;
  thread scripts\engine\utility::play_loopsound_in_space("mtl_steam_pipe_hiss_loop", (27729, 44028, -532));
  thread scripts\engine\utility::play_loopsound_in_space("mtl_steam_pipe_hiss_loop", (27710, 44071, -538));
  thread scripts\engine\utility::play_loopsound_in_space("mtl_steam_pipe_hiss_loop", (27671, 44133, -545));
}

_id_FA40() {
  level._id_FD44 = level.doors["shipping_exit_doors"];
  level._id_FD44._id_901E = (5, 40, 5);
  level._id_FD44._id_9333 = 1;
  level._id_FD44._id_10247 = 1;
  level._id_FD44 scripts\sp\utility::_id_65E1("skip_reach_on_use");
  level._id_FD44 _id_0B1F::_id_5982(scripts\sp\maps\rogue\rogue_anim::_id_FD41, scripts\sp\maps\rogue\rogue_anim::_id_FD43, scripts\sp\maps\rogue\rogue_anim::_id_FD42);
  level._id_FD44 _id_0B1F::_id_59EB("scn_europa_bddy_door_open_grab", "scn_europa_bddy_door_open_start", "scn_europa_bddy_door_open_lp", "scn_europa_bddy_door_shut", "scn_europa_bddy_door_open_finish");
  level._id_FD44._id_28B6 = "tag_bash";
  level._id_FD44._id_9027 = "tag_origin";
  level._id_FD44 scripts\sp\anim::_id_1EC3(level._id_FD44, "ship_hall_idle");
}

_id_FE2B() {
  level notify("notify_allies_attack");
  wait 3.5;
  level._id_13E12 scripts\sp\utility::_id_10346("asteroid_slt_rogerthat");
  level._id_B33B scripts\sp\utility::_id_10346("asteroid_ksh_thisiscrazy");
  level._id_B4F9 scripts\sp\utility::_id_10346("asteroid_omr_pushforward");
  wait 0.5;
  level._id_B33E scripts\sp\utility::_id_10346("asteroid_ksh_whatthehellmanw");
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_CF8D();
  scripts\engine\utility::flag_wait("shipping_hall_spawn_wave_2");
  thread _id_FE23();
}

_id_FE14() {
  wait 0.15;
  var_0 = getscriptablearray("shiphall_on_off", "script_noteworthy");
  thread scripts\sp\maps\rogue\rogue_util::_id_EF3D(var_0, "onoff", "on", "off");
}

_id_FE24() {
  level._id_FD44 scripts\sp\utility::_id_65E1("ship_hall_door_flag");
  var_0 = [level._id_13E12, level._id_B4F9, level._id_B33B, level._id_B33E];
  level._id_FD44 thread _id_0B1F::_id_168A(var_0);
  level.doors["shipping_exit_doors"] scripts\sp\utility::_id_65E3("begin_opening");
  level.player scripts\engine\utility::delaycall(0.7, ::playsound, "scn_rogue_buddy_door_swt_02");
  level.player scripts\engine\utility::delaycall(7, ::playsound, "scn_rogue_buddy_door_swt_close_02");
  thread scripts\sp\maps\rogue\rogue_util::remove_navigating_equipment();
}

_id_FE26() {
  thread _id_3BA5();
  scripts\sp\utility::_id_22C9("hallway_hanging_bot", ::_id_8475);
  thread _id_FE25();
  var_0 = getEntArray("hallway_hanging_bot", "script_noteworthy");
  var_0 = sortbydistance(var_0, level.player.origin);
  var_0[0] scripts\sp\utility::_id_10619(1);
  var_0[1] scripts\sp\utility::_id_10619(1);
  thread _id_12979();
  scripts\engine\utility::flag_wait("shipping_hall_spawn_wave_2");
  var_1 = getEntArray("shipping_hall_reinforcements", "targetname");
  var_2 = scripts\engine\utility::getStructArray("crawl_under_door", "targetname");

  for(var_3 = 0; var_3 < var_1.size; var_3++)
    var_1[var_3] thread _id_4873(var_2[var_3]);

  wait 15;
  level notify("stop_crawling_bots");
  var_4 = getaiarray("axis");

  while(var_4.size > 0) {
    scripts\engine\utility::waitframe();
    var_4 = getaiarray("axis");
    var_4 = scripts\sp\utility::array_removedeadvehicles(var_4);

    foreach(var_6 in var_4) {
      if(isDefined(var_6._id_BEEC))
        var_4 = scripts\engine\utility::array_remove(var_4, var_6);
    }
  }

  scripts\sp\utility::_id_28D7();
  scripts\sp\utility::_id_CF8B();
  scripts\engine\utility::array_thread(level._id_10AC8, scripts\sp\maps\rogue\rogue_util::_id_12958);
  _id_FE24();
}

_id_12979() {
  level.doors["creep_exit_doors"] scripts\sp\utility::_id_65E3("door_sequence_complete");
  scripts\engine\utility::flag_set("sun_vision_blend");
  scripts\engine\utility::flag_set("combat_section_active");
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_CF8D();
}

_id_4873(var_0) {
  level endon("stop_crawling_bots");
  var_1 = 1;

  for(;;) {
    wait(randomfloatrange(0, 2));
    var_2 = "crawl" + randomintrange(1, 4);
    var_3 = scripts\sp\utility::_id_10619(1);
    self.count = 1;
    var_0 thread scripts\sp\anim::_id_1F35(var_3, var_2);
    var_4 = 0.5;
    var_5 = getanimlength(var_3 scripts\sp\utility::_id_7DC1(var_2)) - getanimlength(var_3 scripts\sp\utility::_id_7DC1(var_2)) * var_4;
    var_0 scripts\sp\anim::_id_1F2A([var_3], var_2, var_4);
    var_3 scripts\engine\utility::delaythread(0.05, scripts\sp\anim::_id_1F27, [var_3], var_2, randomfloatrange(1.5, 3.5));
    var_3 scripts\sp\utility::timeout(var_5);

    while(scripts\sp\utility::_id_77DA("enemygroup_shipping").size > 5)
      scripts\engine\utility::waitframe();
  }
}

_id_3BA5() {
  level endon("shipping_hall_done");
  var_0 = scripts\engine\utility::getStructArray("roof_robot_anims", "targetname");

  foreach(var_2 in var_0)
  var_2._id_8749 = 0;

  wait 4;

  for(;;) {
    var_4 = scripts\engine\utility::array_randomize(var_0);

    foreach(var_2 in var_4) {
      if(var_2._id_8749 == 0 && scripts\engine\utility::flag("power_on")) {
        var_2 thread _id_3BA4();
        wait(randomfloatrange(0.9, 5.4));
      }

      wait 0.05;
    }
  }
}

_id_3BA4() {
  var_0 = getEnt("ceiling_robots", "targetname");
  var_1 = "roof_crawl" + randomintrange(1, 5);
  self._id_8749 = 1;
  var_2 = var_0 scripts\sp\utility::_id_10619(1);
  var_0.count = 1;
  var_2 scripts\sp\utility::_id_86E4();
  var_2._id_1FBB = "roof_robot";
  scripts\sp\anim::_id_1F35(var_2, var_1);
  var_2 delete();
  self._id_8749 = 0;
}

_id_FE25() {
  var_0 = getEnt("shipping_hall_move_up_1", "targetname");
  var_1 = getEnt("shipping_hall_move_up_2", "targetname");
  var_2 = getEnt("shipping_hall_move_up_3", "targetname");
  var_3 = getEnt("shipping_hall_move_up_4", "targetname");
  var_4 = getEnt("shipping_hall_move_up_5", "targetname");
  var_5 = getEnt("shipping_hall_move_up_6", "targetname");
  var_6 = getEnt("shipping_hall_move_up_7", "targetname");
  var_7 = getEnt("shipping_hall_move_up_8", "targetname");
  _id_1377C("enemygroup_shipping");
  wait 3;
  scripts\sp\utility::_id_15F5("shipping_hall_color_1");
  scripts\engine\utility::flag_wait("shipping_hall_spawn_wave_2");
  level waittill("stop_crawling_bots");
  _id_1377C("enemygroup_shipping");
  scripts\sp\utility::_id_15F5("shipping_hall_color_9");
  scripts\engine\utility::flag_set("shipping_hall_move_up_8");
  level._id_B4F9 scripts\sp\utility::_id_10346("asteroid_omr_moveup");
}

_id_1381D(var_0) {
  for(;;) {
    var_1 = var_0 scripts\sp\utility::_id_77E3("axis");

    if(isDefined(var_1)) {
      if(var_1.size > 0) {
        foreach(var_3 in var_1) {}

        wait 0.25;
        continue;
      } else
        return 1;
    } else
      return 1;

    wait 0.5;
  }
}

_id_73BF() {
  foreach(var_1 in level._id_10AC8) {
    var_1.ignoreall = 1;
    var_1 scripts\sp\utility::_id_61ED();
  }

  level waittill("notify_allies_attack");

  foreach(var_1 in level._id_10AC8) {
    var_1.ignoreall = 0;
    var_1 scripts\sp\utility::_id_551B();
  }
}

_id_9AA3() {
  self._id_C3FD = self.pathenemyfightdist;
  self._id_74D1 = ::_id_9AA4;
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.pacifist = 1;
  self.pathenemyfightdist = 8;
  self.allowdeath = 1;
  scripts\sp\anim::_id_1EC3(self, "shipping_sleep" + randomintrange(1, 2));
}

_id_9AA4() {
  self endon("death");
  wait(self._id_9827);
  self._id_9827 = 0.25;
  thread scripts\sp\maps\rogue\rogue_util::_id_EBE6();

  if(!isDefined(self._id_9AAD)) {
    _id_0A03::_id_13DC1(0);
    self._id_9AAD = 1;
    _id_1957(level.player, 0.05);
    wait 3;
    thread scripts\sp\utility::_id_77B9(0.5);
    _id_0A1E::_id_2385();
    self.pathenemyfightdist = self._id_C3FD;
    self.ignoreall = 0;
    self.ignoreme = 0;
    self.pacifist = 0;
    _id_0A03::_id_13DC1(1);
  }

  thread scripts\sp\maps\rogue\rogue_util::_id_B5E3();
  scripts\sp\utility::_id_65E1("power_on");
}

#using_animtree("generic_human");

_id_1957(var_0, var_1, var_2) {
  self endon("death");
  self notify("start_gesture_lookat");

  if(isai(self))
    var_3 = scripts\asm\asm::asm_getcurrentstate(self.asmname);
  else
    var_3 = undefined;

  if(isDefined(self._id_9BFC)) {
    _id_0C4C::_id_1964(0.25);
    wait 0.25;
  }

  if(isDefined(var_2))
    self._id_2B71 = var_2;
  else
    self._id_2B71 = 0.7;

  self._id_AFF7 = undefined;
  self._id_AFFA = undefined;
  self._id_B005 = 0;

  if(isDefined(var_1))
    self._id_778E = clamp(var_1, 0, 4.0);
  else
    self._id_778E = 0.5;

  if(self.unittype == "c6")
    _id_0C4C::_id_12FB2();
  else {
    self._id_AFF7 = % prototype_gesture_look_rightleft;
    self._id_AFFA = % prototype_gesture_look_updwn;
    self._id_8C5A = % gesture_head_fwd;
    self._id_8C62 = % gesture_head_right;
    self._id_8C60 = % gesture_head_left;
    self._id_8C63 = % gesture_head_rightback;
    self._id_8C61 = % gesture_head_leftback;
  }

  self._id_77A3 = var_0;

  if(self.unittype == "c6") {
    thread _id_0C4C::_id_1952();
    thread _id_0C4C::_id_1954();
  } else {
    thread _id_0C4C::_id_1951();
    thread _id_0C4C::_id_1953();
  }

  self._id_9BFC = 1;
}

_id_8475() {
  self endon("death");
  self endon("attacked");
  _id_0A03::_id_13DC1(0);
  _id_0E29::_id_877F(self);
  scripts\sp\utility::_id_B14F(1);
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.pacifist = 1;
  self.noragdoll = 1;
  self.a._id_5605 = 1;
  self.allowpain = 0;
  self dontcastshadows();
  self._id_BEEC = 1;
  _id_0E29::_id_877F(self);
  self._id_1EEF = scripts\engine\utility::getStruct(self.target, "targetname");
  self._id_1FBB = "grab_robot";
  var_0["node"] = self._id_1EEF;
  var_0["on"] = "hang_power_on";
  var_0["on_idle"] = "hang_power_on_idle";
  var_0["off"] = "hang_power_off";
  var_0["off_idle"] = "hang_power_off_idle";
  thread scripts\sp\maps\rogue\rogue_util::_id_EBDD(var_0, ::_id_8478, ::_id_8477);
}

_id_8478() {
  thread _id_8476(self._id_1EEF);
}

_id_8477() {
  self notify("power_off");
}

_id_8476(var_0) {
  self endon("death");
  self endon("power_off");
  var_1 = spawn("trigger_radius", self.origin, 0, 40, 64);
  var_1 thread _id_E09E();

  for(;;) {
    var_2 = "hang_grab" + randomintrange(1, 10);
    var_1 waittill("trigger");

    if(!_id_9B6C()) {
      var_0 notify("stop_on_loop");
      thread _id_50C7();
      var_0 scripts\sp\anim::_id_1F35(self, var_2);

      if(scripts\engine\utility::flag("power_on")) {
        var_0 notify("stop_loop");
        var_0 thread scripts\sp\anim::_id_1EEA(self, "hang_power_on_idle");
      }
    }
  }
}

_id_50C7() {
  wait 0.8;

  if(distance2d(self.origin, level.player.origin) <= 64) {
    level.player dodamage(75, self.origin + (0, 0, 64));
    level.player playSound("c6_punch");
  }
}

_id_E09E() {
  level waittill("power_off");
  self delete();
}

_id_9B6C() {
  if(self _meth_850C("left_arm") <= 1) {
    if(self _meth_850C("right_arm") <= 1)
      return 1;

    return 0;
  }

  return 0;
}

_id_83BF() {
  self endon("death");
  self endon("grabbed");
  level endon("stop_glass_bots");
  _id_0A03::_id_13DC1(0);
  _id_0E29::_id_877F(self);
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.pacifist = 1;
  self._id_BEEC = 1;
  _id_0E29::_id_877F(self);
  self._id_1EEF = scripts\engine\utility::getStruct(self.target, "targetname");
  self._id_1FBB = "glass_robot";
  var_0["node"] = self._id_1EEF;
  thread scripts\sp\maps\rogue\rogue_util::_id_EBDD(var_0, ::_id_83C3, ::_id_83C1);
}

_id_83C3() {
  self endon("death");
  level endon("stop_glass_bots");
  var_0 = "bang_on_glass_" + randomintrange(1, 5);
  var_1 = scripts\sp\utility::_id_7DC2(var_0, self._id_1FBB);
  var_2 = var_1[0];
  wait(randomfloatrange(0.1, 2.4));
  self._id_1EEF notify("stop_off_loop");
  self._id_1EEF notify("stop_on_loop");
  self._id_1EEF thread scripts\sp\anim::_id_1EEA(self, var_0, "stop_on_loop");
  self _meth_82B1(var_2, randomfloatrange(1.7, 2.4));
  scripts\engine\utility::flag_wait("power_off");
}

_id_83C1(var_0) {
  self endon("death");
  level endon("stop_glass_bots");
  var_1 = "bang_on_glass_" + randomintrange(1, 5);
  var_2 = scripts\sp\utility::_id_7DC2(var_1, self._id_1FBB);
  var_3 = var_2[0];
  wait(randomfloatrange(0.1, 2.4));
  self._id_1EEF notify("stop_on_loop");
  self._id_1EEF notify("stop_off_loop");
  self notify("power_off");
  thread scripts\sp\utility::_id_77B9(0.7);
  self._id_1EEF thread scripts\sp\anim::_id_1EEA(self, var_1, "stop_off_loop");
  self _meth_82B1(var_3, randomfloatrange(0.1, 1.6));
}

_id_83C0(var_0) {
  self endon("death");
  self endon("power_off");
  level endon("stop_glass_bots");

  if(isDefined(self.script_parameters) && self.script_parameters == "grabber") {
    var_1 = getEnt("glassbreaking_robot", "targetname");
    var_1 waittill("trigger");
    self notify("grabbed");
    _id_83BE(var_0);
  }
}

_id_83BE(var_0) {
  self endon("death");
  var_0 notify("stop_on_loop");
  thread scripts\engine\utility::exploder("c6_glass_punch");
  var_0 scripts\sp\anim::_id_1F35(self, "bang_on_glass_grab");
  var_1 = scripts\engine\utility::getfx("vfx_ra_glow_c6_head_atteck_a");
  var_2 = scripts\engine\utility::getfx("vfx_ra_glow_c6_head_atteck_b");
  killfxontag(var_1, self, "TAG_EYE");
  killfxontag(var_2, self, "TAG_EYE");

  if(scripts\engine\utility::flag("power_off"))
    _id_83C2(var_0);

  for(;;) {
    _id_83C4(var_0);
    _id_83C2(var_0);
  }
}

_id_83C4(var_0) {
  self endon("death");
  var_0 thread scripts\sp\anim::_id_1EEA(self, "bang_on_glass_post_grab_fast", "stop_on_loop");
  scripts\engine\utility::flag_wait("power_off");
  var_0 notify("stop_on_loop");
}

_id_83C2(var_0) {
  self endon("death");
  var_0 thread scripts\sp\anim::_id_1EEA(self, "bang_on_glass_post_grab_slow", "stop_off_loop");
  scripts\engine\utility::flag_wait("power_on");
  var_0 notify("stop_off_loop");
}

_id_FE27(var_0) {
  if(!isDefined(var_0)) {
    if(scripts\engine\utility::flag("power_on"))
      var_0 = 0;
    else
      var_0 = 1;
  }

  if(var_0) {
    thread _id_FD5F(var_0);
    scripts\engine\utility::flag_wait("power_on");
  } else
    thread _id_FD5F(var_0);
}

_id_FD5F(var_0) {
  if(!isDefined(var_0)) {
    if(scripts\engine\utility::flag("power_on"))
      var_0 = 0;
    else
      var_0 = 1;
  }

  if(var_0) {
    foreach(var_2 in level._id_10AC8)
    var_2.ignoreall = 1;

    level._id_B4F9 scripts\sp\utility::_id_10346("asteroid_usf_takecoverpositions");
    level._id_B4F9 scripts\sp\utility::_id_10346("asteroid_usf_oncepowerkickson");
    scripts\sp\maps\rogue\rogue_util::_id_13809(6);

    foreach(var_2 in level._id_10AC8)
    var_2.ignoreall = 0;
  } else
    level._id_B4F9 scripts\sp\utility::_id_10346("asteroid_usf_takecover");

  scripts\sp\maps\rogue\rogue_util::_id_13809(17.5);
  level._id_13E12 scripts\sp\utility::_id_10346("asteroid_slt_holdonuntil");
  scripts\engine\utility::flag_waitopen("power_on");
  level._id_13E12 scripts\sp\utility::_id_10346("asteroid_slt_thepowergoesout");
  wait 1;
  scripts\engine\utility::flag_set("night_kill");
  level._id_B4F9 scripts\sp\utility::_id_10346("asteroid_usf_dontleaveanydroids");
}

_id_1D12() {
  var_0 = getEnt("initial_shipping_move_trig", "targetname");

  if(level._id_111C3.time >= 20 || level._id_111C3.time <= 7) {
    scripts\engine\utility::flag_wait("power_on");
    scripts\engine\utility::flag_waitopen("power_on");
  }

  scripts\engine\utility::flag_waitopen("power_on");
  thread scripts\sp\maps\rogue\rogue_util::_id_E64A(250, 120, 210, 160);
  var_0 notify("trigger");
  wait 1;
  var_0 delete();
  var_0 = getEnt("ship_change_colors_trig", "targetname");
  var_0 waittill("trigger", var_1);
  level._id_B4F9 scripts\sp\utility::_id_F3B5("b");
  level._id_B33B scripts\sp\utility::_id_F3B5("b");
  var_2 = getEnt("ship_revert_colors_trig", "targetname");
  var_2 waittill("trigger", var_1);
  level._id_B4F9 scripts\sp\utility::_id_F3B5("g");
  level._id_B33B scripts\sp\utility::_id_F3B5("g");
  wait 0.5;
  var_2 notify("trigger");
}

_id_3B24() {
  scripts\engine\utility::flag_wait("shipping_done");

  foreach(var_1 in level._id_10AC8) {
    if(distance2d(level.player.origin, var_1.origin) >= 500) {
      var_2 = getnode("post_ship_tp" + var_1._id_111B7, "targetname");
      var_1 _meth_83B9(var_2.origin, var_2.angles);
    }
  }

  var_4 = getEnt("post_ship_tp_trig", "targetname");
  wait 0.1;
  var_4 notify("trigger");
}

_id_973B() {
  level._id_1EBC["crawl_a_l"] = scripts\engine\utility::getStruct("crawl_a_L", "targetname");
  level._id_1EBC["crawl_a_r"] = scripts\engine\utility::getStruct("crawl_a_R", "targetname");
  level._id_1EBC["crawl_b_l"] = scripts\engine\utility::getStruct("crawl_b_L", "targetname");
  level._id_1EBC["crawl_b_r"] = scripts\engine\utility::getStruct("crawl_b_R", "targetname");
  level._id_1EBC["crawl_generic"] = scripts\engine\utility::getStructArray("crawl_generic", "targetname");
  level._id_1EBC["emerge_generic"] = scripts\engine\utility::getStructArray("emerge_generic", "targetname");
  level._id_1EBC["catwalk_generic"] = scripts\engine\utility::getStructArray("catwalk_generic", "targetname");
  level._id_1EBC["chasm_generic"] = scripts\engine\utility::getStructArray("chasm_generic", "targetname");
  level._id_1EBC["climb_b_left"] = scripts\engine\utility::getStructArray("climb_b_left", "targetname");
  level._id_1EBC["climb_b_right"] = scripts\engine\utility::getStructArray("climb_b_right", "targetname");
  level.goals = [];
  level.goals["a"] = getnodearray("node_defend_a_goal", "script_noteworthy");
  level.goals["b_left"] = getnodearray("node_defend_b_goal_L", "script_noteworthy");
  level.goals["b_right"] = getnodearray("node_defend_b_goal_R", "script_noteworthy");
  level._id_8425 = undefined;
  scripts\sp\utility::_id_22C7(scripts\sp\utility::_id_77DF("group_enemy_defend_a_melee"), ::_id_108AA);
  level._id_505C = ["group_enemy_defend_b_melee_left", "group_enemy_defend_b_melee_right", "group_enemy_defend_b_melee_top_left", "group_enemy_defend_b_melee_top_right"];

  foreach(var_1 in level._id_505C)
  scripts\sp\utility::_id_22C7(scripts\sp\utility::_id_77DF(var_1), ::_id_108AA);
}

_id_FE1B() {
  scripts\sp\maps\rogue\rogue_util::_id_BC53("playerstart_defend_a");
  level._id_10AC8 = scripts\sp\maps\rogue\rogue_util::_id_10626("allystart_defend_a");
  scripts\engine\utility::flag_set("force_flashlights_on");
  thread _id_4DE8();
  scripts\engine\utility::flag_clear("player_is_inside");
  thread init_defend_a_goals(1);
}

_id_FE1A() {
  thread _id_6DC8();
  thread _id_5065();
  thread _id_FE29("group_enemy_defend_a_melee");
  thread _id_16EC();
  thread _id_D897();
  var_0 = [1, 0.775, 0.385];
  level._id_111C3.light = 60 * vectorNormalize((var_0[0], var_0[1], var_0[2]));
  setsunlight(level._id_111C3.light[0], level._id_111C3.light[1], level._id_111C3.light[2]);
  scripts\sp\maps\rogue\rogue_util::_id_111E8(7, 16, 1);
  level._id_111C3.ent linkTo(level._id_111C3._id_C6EA, "tag_origin", (17000, 40000, 0), (0, 0, 0));
  level._id_111C3._id_1EF6 linkTo(level._id_111C3._id_E6E5, "tag_origin", (0, 0, 0), (0, 0, 270));
  scripts\sp\maps\rogue\rogue_util::_id_111E7(5.25, 30, 30, 200, 100);
  scripts\engine\utility::array_call(getaiarray("axis", "neutral"), ::delete);
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_CF8D();
  setmusicstate("");
  scripts\engine\utility::flag_clear("player_is_inside");
  scripts\sp\utility::_id_2669("Defend A");
  thread _id_467F();
  scripts\engine\utility::array_thread(getEntArray("defend_solar_panels", "script_noteworthy"), ::_id_103F0);
  scripts\engine\utility::array_thread(getEntArray("defend_solar_panels_d", "script_noteworthy"), ::_id_103EE);
  scripts\sp\utility::_id_15F5("enemytrig_defend_glass");
  thread _id_5425();
  setglobalsoundcontext("atmosphere", "helmet", 1);
  scripts\engine\utility::flag_set("flag_defend_a_start");
  scripts\sp\utility::_id_15F5("allytrig_defend_a_l1");
  var_1 = ["rogue_brk_lookout", "rogue_ksh_onesonme"];
  var_2 = ["rogue_slt_watchit", "rogue_slt_reyeshelp", "rogue_omr_gettingoverrun"];
  thread _id_1CD9("flag_defend_a_allyretreat_right", "allytrig_defend_a_r1", "allytrig_defend_a_r2");
  thread _id_1CD9("flag_defend_a_allyretreat_left", "allytrig_defend_a_l1", "allytrig_defend_a_l2");
  thread _id_6AD3();
  thread _id_28DF("flag_defend_a_end");
  level._id_8425 = ["a"];
  thread _id_E5B2("trig_outside_defend", "group_enemy_defend_a_melee", "flag_shipping_defend_end");
  scripts\sp\utility::_id_15F3("enemytrig_defend_a_flood");
  level waittill("time_8");
  thread _id_5424();
  level waittill("time_12");
  thread _id_5423();
  _id_0B77::_id_A67F(120);
  level waittill("time_16.5");
  scripts\sp\maps\rogue\rogue_util::_id_F5B9(16.5);
  scripts\engine\utility::flag_set("flag_defend_a_end");
  level.player.sun_burn_mega_damage = undefined;
  level notify("notify_stop_retreat_logic");
  level._id_5A5E = 0;
  scripts\sp\utility::_id_2669("Defend Run");
  thread _id_5426();
  scripts\engine\utility::array_thread(level.allies, scripts\sp\utility::_id_F3B5, "r");
  level._id_B4F9 scripts\sp\utility::_id_F3B5("b");
  level._id_B33B scripts\sp\utility::_id_F3B5("b");
  scripts\sp\utility::_id_15F5("allytrig_defend_b_intro");
  var_3 = getnode("node_defend_a_run_left", "targetname");
  var_4 = getnode("node_defend_a_run_right", "targetname");
  var_5 = getnode("node_defend_run_a_slt", "targetname");
  level._id_B4F9 thread _id_722B(var_3, 1);
  level._id_13E12 thread _id_722B(var_5);
  level._id_B33B thread _id_722B(var_4, 1);
  level._id_B33E thread _id_722B(var_4, 1);
  level._id_13E12 thread _id_10349("rogue_slt_comeonreyes", "flag_player_running");
  level thread scripts\sp\maps\rogue\rogue_util::_id_C152("time_4", scripts\engine\utility::flag_set, "flag_player_running");
  scripts\engine\utility::flag_set("night_kill");
  thread _id_6CD0();
  scripts\engine\utility::flag_wait("flag_defend_a_early_playerrun");
  scripts\engine\utility::array_thread(scripts\sp\utility::_id_77DA("group_enemy_defend_a_melee"), scripts\sp\utility::_id_F225, "stop_going_to_node");
  scripts\engine\utility::flag_wait("flag_proximity_hack_intro");
}

init_defend_a_goals(var_0) {
  if(!isDefined(var_0))
    level._id_FD44 scripts\sp\utility::_id_65E3("begin_opening");

  level._id_13E12 scripts\sp\utility::_id_F3B5("o");
  level._id_B4F9 scripts\sp\utility::_id_F3B5("y");
  level._id_B33B scripts\sp\utility::_id_F3B5("y");
  level._id_B33E scripts\sp\utility::_id_F3B5("r");
  scripts\engine\utility::array_thread(level.allies, scripts\sp\utility::_id_F415, 0);
  scripts\engine\utility::array_thread(level.allies, scripts\sp\utility::_id_F416, 0);
  scripts\engine\utility::flag_set("night_kill");
  scripts\sp\utility::_id_15F5("allytrig_defend_a_0");
  scripts\sp\utility::_id_15F5("allytrig_defend_a_1");
  scripts\sp\utility::_id_15F5("allytrig_defend_a_r1");
}

_id_D72C() {
  self endon("death");

  while(self._id_117C)
    wait 1;

  _id_0F3D::_id_236F();
}

_id_D897() {
  level endon("flag_proximity_hack_intro");
  var_0 = getEnt("defend_a_path_cleanup_trig", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = undefined;
  var_2 = var_0 scripts\engine\utility::get_target_ent();

  for(;;) {
    var_0 waittill("trigger", var_3);

    if(!isDefined(var_1))
      var_1 = var_3;
    else if(isalive(var_1) && var_3 != var_1 && var_1 istouching(var_2)) {
      var_1 _meth_847E();
      var_3 = var_1;
    }

    wait 0.05;
  }
}

_id_722B(var_0, var_1) {
  scripts\sp\utility::_id_54F7();
  var_2 = self.maxfaceenemydist;
  self.maxfaceenemydist = 128;

  if(isDefined(var_1) && var_1) {
    scripts\sp\utility::_id_F3E0(128);
    self setgoalpos(var_0.origin);
  } else
    scripts\sp\utility::_id_7226(var_0);

  self waittill("goal");
  self.maxfaceenemydist = var_2;
  scripts\sp\utility::_id_61C7();
}

_id_6AD3() {
  level endon("flag_defend_a_end");
  scripts\engine\utility::flag_wait("flag_defend_a_early_playerrun");
  level.player.sun_burn_mega_damage = 1;
}

_id_6CD0() {
  level._id_1C1B = level.allies.size;
  scripts\engine\utility::array_thread(level.allies, ::_id_6CD1);
  thread scripts\sp\maps\rogue\rogue_util::_id_E64A(500, 450, 400, 330);

  while(level._id_1C1B > 0)
    scripts\engine\utility::waitframe();

  scripts\engine\utility::flag_wait("flag_proximity_hack_intro");
}

_id_6CD1() {
  self._id_C3C7 = self.maxfaceenemydist;
  self.maxfaceenemydist = 256;
  scripts\sp\utility::_id_51E1("sprint");

  while(distance(self.origin, level._id_5061.origin) > 800 && !scripts\engine\utility::flag("proximity_hacking"))
    wait 1;

  scripts\sp\utility::_id_5522();
  level._id_1C1B--;
  self.maxfaceenemydist = self._id_C3C7;
  scripts\sp\utility::_id_51E1("combat");
}

_id_FE1E() {
  scripts\sp\maps\rogue\rogue_util::_id_BC53("playerstart_defend_b_proximity");
  level._id_10AC8 = scripts\sp\maps\rogue\rogue_util::_id_10626("allystart_defend_b");
  thread _id_4DE8();
  thread _id_E5B2("trig_outside_defend", level._id_505C, "flag_shipping_defend_end");
  scripts\engine\utility::flag_set("force_flashlights_on");
  scripts\engine\utility::array_thread(getEntArray("defend_solar_panels", "script_noteworthy"), ::_id_103F0);
  scripts\engine\utility::array_thread(getEntArray("defend_solar_panels_d", "script_noteworthy"), ::_id_103EE);
  var_0 = [1, 0.775, 0.385];
  level._id_111C3.light = 60 * vectorNormalize((var_0[0], var_0[1], var_0[2]));
  setsunlight(level._id_111C3.light[0], level._id_111C3.light[1], level._id_111C3.light[2]);
  scripts\sp\maps\rogue\rogue_util::_id_111E8(7, 16, 1);
  level._id_111C3.ent linkTo(level._id_111C3._id_C6EA, "tag_origin", (17000, 40000, 0), (0, 0, 0));
  level._id_111C3._id_1EF6 linkTo(level._id_111C3._id_E6E5, "tag_origin", (0, 0, 0), (0, 0, 270));
  scripts\sp\maps\rogue\rogue_util::_id_111E7(6, 30, 10, 200, 100);
  scripts\engine\utility::array_thread(level.allies, scripts\sp\utility::_id_F3B5, "r");
  level._id_13E12 scripts\sp\utility::_id_F3B5("r");
  level._id_B33E scripts\sp\utility::_id_F3B5("r");
  level._id_B4F9 scripts\sp\utility::_id_F3B5("b");
  level._id_B33B scripts\sp\utility::_id_F3B5("b");
  scripts\sp\utility::_id_15F5("allytrig_defend_b_intro");
  scripts\engine\utility::flag_set("night_kill");
  thread _id_467F();
  scripts\sp\utility::_id_15F5("enemytrig_defend_glass");
  thread _id_16EC();
  thread _id_5065();
}

_id_FE1D() {
  level._id_5A5E = 0;
  scripts\sp\utility::_id_2669("Defend Proximity Hack");
  thread _id_DAC0();
  setglobalsoundcontext("atmosphere", "helmet", 1);
  scripts\engine\utility::flag_wait("proximity_hacking");
  scripts\sp\utility::_id_15F5("enemytrig_defendb_door");
  thread _id_549D();
  scripts\engine\utility::array_thread(getaiarray("axis"), scripts\sp\utility::_id_F415, 0);
  thread _id_67EF();
  level._id_13E12 scripts\sp\utility::_id_F3B5("b");
  level._id_B4F9 scripts\sp\utility::_id_F3B5("r");
  level._id_B33B scripts\sp\utility::_id_F3B5("r");
  level._id_B33E scripts\sp\utility::_id_F3B5("r");
  scripts\sp\utility::_id_15F5("allytrig_defend_b_rail");
  scripts\sp\utility::_id_2669("Defend Left");
  level notify("notify_dialogue_wave_1_start");
  level._id_8425 = ["b_left"];
  scripts\sp\utility::_id_15F3("enemytrig_defend_b_flood_left");
  scripts\sp\utility::_id_15F3("enemytrig_defend_b_flood_top_left");
  scripts\engine\utility::flag_wait_or_timeout("flag_defend_b_allyretreat_left", 10);
  scripts\sp\utility::_id_15F5("allytrig_defend_b_left");
  thread _id_1CD9("flag_defend_b_allyretreat_left", "allytrig_defend_b_left", "allytrig_defend_b_left_retreat");
  level waittill("time_18");
  stop_following_all_players("group_enemy_defend_b_melee_left", "enemytrig_defend_b_flood_left");
  stop_following_all_players("group_enemy_defend_b_melee_top_left", "enemytrig_defend_b_flood_top_left");
  level waittill("time_6");
  thread _id_54A0();
  level._id_8425 = ["b_right"];
  scripts\engine\utility::array_thread(scripts\sp\utility::_id_77DA("group_enemy_defend_b_melee_left"), scripts\sp\utility::_id_7226, scripts\engine\utility::random(level.goals["b_right"]));
  scripts\sp\utility::_id_2669("Defend Right");
  scripts\sp\utility::_id_15F5("enemytrig_defendb_security_right");
  wait 1;
  level notify("notify_stop_retreat_logic");
  level._id_13E12 scripts\sp\utility::_id_F3B5("r");
  scripts\sp\utility::_id_15F5("allytrig_defend_b_left_side");
  level._id_8425 = ["b_right"];
  level _id_1377C("group_enemy_defend_b_security", 1, undefined, 10, undefined, undefined, ["player_is_outside", "time_12"]);
  scripts\sp\utility::_id_15F3("enemytrig_defend_b_flood_right");
  scripts\sp\utility::_id_15F3("enemytrig_defend_b_flood_top_right");
  thread _id_54A2();
  level._id_13E12 scripts\sp\utility::_id_F3B5("b");
  level._id_B4F9 scripts\sp\utility::_id_F3B5("b");
  level._id_B33B scripts\sp\utility::_id_F3B5("b");
  level._id_B33E scripts\sp\utility::_id_F3B5("r");
  scripts\sp\utility::_id_15F5("allytrig_defend_b_right");
  thread _id_1CD9("flag_defend_b_allyretreat_right", "allytrig_defend_b_right", "allytrig_defend_b_right_retreat");
  level waittill("time_12");
  level._id_8425 = ["b_left", "b_right"];
  scripts\sp\utility::_id_15F3("enemytrig_defend_b_flood_left");
  scripts\engine\utility::flag_wait("proximity_hack_end");
  stop_following_all_players("group_enemy_defend_b_melee_right", "enemytrig_defend_b_flood_right");
  stop_following_all_players("group_enemy_defend_b_melee_top_right", "enemytrig_defend_b_flood_top_right");
  stop_following_all_players("group_enemy_defend_b_melee_left", "enemytrig_defend_b_flood_left");
  scripts\engine\utility::flag_clear("flag_main_dialogue_active");
  var_0 = getaiarray("axis");
  var_0 = scripts\sp\utility::array_removedeadvehicles(var_0);

  foreach(var_2 in var_0)
  var_2 thread _id_505F();

  level notify("notify_stop_retreat_logic");
  level._id_8425 = undefined;
  scripts\engine\utility::flag_waitopen("proximity_hacking");
}

_id_505F() {
  self endon("death");
  var_0 = scripts\sp\utility::_id_7951(level.player.origin, level.player.angles, self.origin);

  if(var_0 >= 0.4)
    wait 5.0;

  var_1 = randomintrange(5, 10);

  for(var_0 = scripts\sp\utility::_id_7951(level.player.origin, level.player.angles, self.origin); var_0 >= 0.4; var_0 = scripts\sp\utility::_id_7951(level.player.origin, level.player.angles, self.origin))
    scripts\engine\utility::waitframe();

  if(isDefined(self._id_B14F) && self._id_B14F)
    scripts\sp\utility::_id_1101B();

  self _meth_81D0();
}

_id_FE21() {
  scripts\sp\maps\rogue\rogue_util::_id_BC53("playerstart_defend_b_proximity");
  level._id_10AC8 = scripts\sp\maps\rogue\rogue_util::_id_10626("allystart_defend_b");
  scripts\engine\utility::flag_set("force_flashlights_on");
  thread _id_4DE8();
  level._id_111C3.ent linkTo(level._id_111C3._id_C6EA, "tag_origin", (17000, 40000, 0), (0, 0, 0));
  level._id_111C3._id_1EF6 linkTo(level._id_111C3._id_E6E5, "tag_origin", (0, 0, 0), (0, 0, 270));
  thread scripts\sp\maps\rogue\rogue_util::_id_111E7(6, 30, 15, 200, 100);
}

_id_FE20() {
  scripts\sp\utility::_id_2669("Defend End");
  scripts\sp\maps\rogue\rogue_util::_id_119AF(1);
  thread _id_0B1F::_id_1AAA("defend_airlock");
  scripts\engine\utility::array_thread(level.allies, scripts\sp\utility::_id_F3B5, "r");
  scripts\sp\utility::_id_15F5("allytrig_defend_end");
  scripts\sp\utility::_id_28D7();
  scripts\sp\utility::_id_CF8B();
  thread _id_5427();
  var_0 = getEnt("airlock_door_collision_2", "targetname");
  var_1 = getEnt("struct_defend_exit_door", "targetname");
  level.player._id_E505 = scripts\sp\utility::_id_10639("player_rig");
  level.player._id_E505 hide();
  var_2 = level._id_5061;
  var_1 scripts\sp\anim::_id_1EC1([level.player._id_E505, var_2], "corpse_hall_scene_1");
  var_2 thread _id_0E46::_id_48C4("tag_ui_back", undefined, undefined, 140, 1024, 48, 1);
  var_2 _id_0E46::_id_9016();

  if(!level.console)
    waitforalltransients();

  foreach(var_4 in getaiarray("axis"))
  var_4 scripts\engine\utility::delaycall(randomfloatrange(0.1, 1), ::_meth_847E);

  scripts\engine\utility::flag_set("flag_player_opening_defend_door");
  thread _id_505B();
  var_2 thread _id_10177();
  var_1 thread scripts\sp\maps\rogue\rogue_util::_id_1EFA("exit_defend", undefined, 0.5);
  wait 0.5;
  level.player playSound("scn_rogue_airlock_door_open");
  var_1 thread scripts\sp\anim::_id_1F35(var_2, "exit_defend");
  level waittill("allies_proceed");
  thread _id_5428();
}

_id_6DC8() {
  var_0 = getEnt("struct_defend_exit_door", "targetname");

  if(!isDefined(level._id_5061)) {
    var_1 = getEnt("defend_exit_door", "targetname");
    var_1._id_1FBB = "airlock_door";
    var_1 scripts\sp\anim::_id_F64A();
  } else
    var_1 = level._id_5061;

  var_0 scripts\sp\anim::_id_1EC3(var_1, "exit_defend");
}

#using_animtree("script_model");

_id_10177() {
  var_0 = getEnt("ally_shut_control_exit_door", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = 0;

  while(var_1 != 4 || !scripts\engine\utility::flag("ok_to_shut_ship_exit_door")) {
    var_0 waittill("trigger", var_2);
    var_1 = 0;

    if(var_2 scripts\sp\utility::_id_65DF("set_to_shut_ship_door") == 0) {
      var_2 scripts\sp\utility::_id_65E0("set_to_shut_ship_door");
      var_2 scripts\sp\utility::_id_65E1("set_to_shut_ship_door");
    }

    foreach(var_2 in level._id_10AC8) {
      if(var_2 scripts\sp\utility::_id_65DF("set_to_shut_ship_door"))
        var_1++;
    }
  }

  scripts\engine\utility::flag_set("disable_alt_vision_calls");
  thread scripts\sp\maps\rogue\rogue_util::remove_navigating_equipment();
  self playSound("airlock_entry_door_close");
  scripts\sp\utility::_id_15F5("control_room_back_blocker");
  self _meth_82A2(%rogue_shipping_proximity_door_open, 1, 0.2, -2);
}

_id_505B() {
  wait 2.7;
  thread scripts\engine\utility::play_sound_in_space("rogue_steam_hiss_medium_close_deep", (29208, 40862, -540));
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0.origin = (29208, 40862, -540);
  var_0.angles = (2, 117, 0);
  var_1 = scripts\engine\utility::spawn_tag_origin();
  var_1.origin = (29208, 40862, -510);
  var_1.angles = (2, 117, 0);
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_2.origin = (29208, 40862, -480);
  var_2.angles = (2, 117, 0);
  playFXOnTag(level._effect["vfx_ra_int_smk_floor"], var_0, "tag_origin");
  playFXOnTag(level._effect["vfx_ra_int_smk_floor"], var_0, "tag_origin");
  playFXOnTag(level._effect["vfx_ra_int_smk_floor"], var_0, "tag_origin");
  playFXOnTag(level._effect["vfx_ra_int_smk_floor"], var_0, "tag_origin");
  wait 2.0;
  playFXOnTag(level._effect["vfx_ra_int_smk_floor"], var_0, "tag_origin");
  playFXOnTag(level._effect["vfx_ra_int_smk_floor"], var_0, "tag_origin");
  playFXOnTag(level._effect["vfx_ra_int_smk_floor"], var_0, "tag_origin");
  stopFXOnTag(level._effect["vfx_escape_ship_steam_jet"], var_0, "tag_origin");
  stopFXOnTag(level._effect["vfx_escape_ship_steam_jet"], var_1, "tag_origin");
  stopFXOnTag(level._effect["vfx_escape_ship_steam_jet"], var_2, "tag_origin");
  wait 0.1;
  stopFXOnTag(level._effect["vfx_ra_int_smk_floor"], var_0, "tag_origin");
  wait 1.0;
  playFXOnTag(level._effect["vfx_ra_int_smk_floor"], var_0, "tag_origin");
  playFXOnTag(level._effect["vfx_ra_int_smk_floor"], var_0, "tag_origin");
  playFXOnTag(level._effect["vfx_ra_int_smk_floor"], var_0, "tag_origin");
  wait 10;
  var_0 delete();
  var_1 delete();
  var_2 delete();
}

_id_108AA() {
  _id_F58F();
  self endon("death");
  self.goal = undefined;
  var_0 = undefined;
  var_1 = 0;

  if(isDefined(self._id_EE52)) {
    self._id_EE52 = tolower(self._id_EE52);
    var_2 = _id_781F(self._id_EE52);

    if(issubstr(self._id_EE52, "crawl")) {
      var_0 = "crawl" + randomintrange(1, 4);
      var_1 = 0.5;
    } else if(issubstr(self._id_EE52, "emerge"))
      var_0 = "emerge1";
    else if(issubstr(self._id_EE52, "climb")) {
      var_0 = "climb1";
      var_1 = 0.5;
    } else if(issubstr(self._id_EE52, "catwalk")) {
      var_0 = "climb1";
      var_1 = 0.5;
    } else if(issubstr(self._id_EE52, "chasm")) {
      var_0 = "climb1";
      var_1 = 0.5;
    } else if(issubstr(self._id_EE52, "glass")) {
      _id_83BF();
      self.pacifist = 0;
      self.ignoreme = 0;
      self.ignoreall = 0;
    }

    if(!isDefined(level._id_1EBB))
      level._id_1EBB = [];

    if(!isDefined(level._id_1EBB[self._id_EE52]))
      level._id_1EBB[self._id_EE52] = [];

    level._id_1EBB[self._id_EE52][level._id_1EBB[self._id_EE52].size] = self;

    if(isDefined(var_2) && isDefined(var_0)) {
      self._id_1FBB = "worker_bot";
      self.allowdeath = 1;
      scripts\engine\utility::delaycall(0.05, ::_meth_82B0, scripts\sp\utility::_id_7DC1(var_0), var_1);
      var_2 scripts\sp\anim::_id_1F35(self, var_0);
      self notify("anim_struct_clear");
      self.allowdeath = 0;

      if(isDefined(var_2.target))
        self.goal = var_2 scripts\engine\utility::get_target_ent();
    }
  }

  if(issubstr(self.classname, "worker") && !isDefined(self.goal) && isDefined(level._id_8425))
    self.goal = scripts\engine\utility::random(level.goals[scripts\engine\utility::random(level._id_8425)]);

  self notify("follow_path");
}

_id_781F(var_0) {
  if(!isDefined(level._id_1EBC[var_0])) {
    return;
  }
  var_1 = undefined;
  var_2 = 0;

  for(;;) {
    if(isarray(level._id_1EBC[var_0])) {
      for(var_3 = 0; var_3 < level._id_1EBC[var_0].size; var_3++)
        var_1 = scripts\engine\utility::random(level._id_1EBC[var_0]);
    } else
      var_1 = level._id_1EBC[var_0];

    if(isDefined(var_1) && !isDefined(var_1.occupied)) {
      break;
    }

    var_2++;
    scripts\engine\utility::waitframe();
  }

  thread _id_1115D(var_1);
  return var_1;
}

_id_1115D(var_0) {
  var_0.occupied = 1;
  scripts\engine\utility::waittill_any("anim_struct_clear", "death", "pain_death");
  var_0.occupied = undefined;
}

_id_1CD9(var_0, var_1, var_2) {
  level endon("notify_stop_retreat_logic");
  level._id_507D["xo"] = ["rogue_slt_goodshotraider", "rogue_slt_thanksfortheass", "rogue_slt_keepitupslick"];
  level._id_507D["MCO"] = ["rogue_omr_thankscaptain", "rogue_omr_niceshot", "rogue_omr_oweyouone"];
  level._id_507D["marine1"] = ["rogue_brk_thanks", "rogue_brk_goodeyecaptain", "rogue_brk_goodcoversir"];
  level._id_507D["marine2"] = ["rogue_ksh_graciascaptain", "rogue_ksh_damnthatwasclos", "rogue_ksh_nice"];
  level._id_507B["xo"] = ["rogue_slt_gotem", "rogue_slt_gotyoursixraide", "rogue_slt_yourewelcome"];
  level._id_507B["MCO"] = ["rogue_omr_gotcha", "rogue_omr_thatwasclose", "rogue_omr_owemeapint"];
  level._id_507B["marine1"] = ["rogue_brk_getoffhim", "rogue_brk_igotyousir", "rogue_brk_closecallcaptai"];
  level._id_507B["marine2"] = ["rogue_ksh_closeonecaptain", "rogue_ksh_gotyoucoveredsi", "rogue_ksh_thankmelater"];
  level._id_507F["xo"] = ["UN_slt_contact_dir_left"];
  level._id_507F["MCO"] = ["UN_omr_contact_dir_left"];
  level._id_507F["marine1"] = ["UN_brk_contact_dir_left"];
  level._id_507F["marine2"] = ["UN_ksh_contact_dir_left"];
  level._id_5080["xo"] = ["UN_slt_contact_dir_right"];
  level._id_5080["MCO"] = ["UN_omr_contact_dir_right"];
  level._id_5080["marine1"] = ["UN_brk_contact_dir_right"];
  level._id_5080["marine2"] = ["UN_ksh_contact_dir_right"];
  level._id_507E["xo"] = [];
  level._id_507E["MCO"] = [];
  level._id_507E["marine1"] = [];
  level._id_507E["marine2"] = [];
  level._id_507C["xo"] = [];
  level._id_507C["MCO"] = [];
  level._id_507C["marine1"] = [];
  level._id_507C["marine2"] = [];
  var_3 = level.allies;
  var_4 = getEnt(var_0, "targetname");
  level._id_A8FA[var_0] = 0;
  level._id_A898[var_0] = 0;
  level._id_A897[var_0] = 0;
  var_5 = 0;

  if(issubstr(var_0, "left"))
    var_5 = 1;

  scripts\engine\utility::array_thread(var_3, scripts\sp\utility::_id_F2D8, 0.2);
  scripts\engine\utility::array_thread(var_3, ::_id_1CDB);

  for(;;) {
    scripts\engine\utility::waitframe();
    level waittill(var_0, var_6);

    if(isDefined(var_6._id_938B)) {
      continue;
    }
    var_7 = _id_1CDA(var_4);
    var_6 thread _id_4E41(var_0);

    if(scripts\engine\utility::flag("flag_main_dialogue_active")) {
      continue;
    }
    if(scripts\engine\utility::flag("flag_retreat_dialogue_active")) {
      continue;
    }
    scripts\engine\utility::flag_set("flag_retreat_dialogue_active");
    scripts\engine\utility::array_thread(var_3, scripts\sp\utility::_id_F2D8, 1);

    if(isDefined(var_2))
      scripts\sp\utility::_id_15F5(var_2);

    if(gettime() - level._id_A8FA[var_0] >= 15000) {
      var_8 = undefined;

      if(var_5)
        var_8 = scripts\engine\utility::random(level._id_507F[var_7._id_1FBB]);
      else
        var_8 = scripts\engine\utility::random(level._id_5080[var_7._id_1FBB]);

      if(isDefined(var_7))
        var_7 scripts\sp\utility::_id_10346(var_8);

      level._id_A8FA[var_0] = gettime();
    }

    scripts\engine\utility::flag_clear("flag_retreat_dialogue_active");
  }
}

_id_4E41(var_0) {
  self._id_938B = 1;
  self waittill("death", var_1);

  if(!isDefined(var_1)) {
    return;
  }
  if(scripts\engine\utility::flag("flag_retreat_dialogue_active")) {
    return;
  }
  if(scripts\engine\utility::flag("flag_main_dialogue_active")) {
    return;
  }
  var_2 = sortbydistance(level.allies, self.origin)[0];
  wait 1;
  scripts\engine\utility::flag_set("flag_retreat_dialogue_active");

  if(var_1 == level.player) {
    if(gettime() - level._id_A898[var_0] >= 15000) {
      level._id_A898[var_0] = gettime();

      if(level._id_507E[var_2._id_1FBB].size == 0)
        level._id_507E[var_2._id_1FBB] = scripts\engine\utility::array_randomize(level._id_507D[var_2._id_1FBB]);

      var_2 scripts\sp\utility::_id_10346(level._id_507D[var_2._id_1FBB][0]);
    }
  } else if(var_1 != var_2) {
    if(gettime() - level._id_A897[var_0] >= 15000) {
      level._id_A897[var_0] = gettime();

      if(level._id_507C[var_2._id_1FBB].size == 0)
        level._id_507C[var_2._id_1FBB] = scripts\engine\utility::array_randomize(level._id_507B[var_2._id_1FBB]);

      var_2 scripts\sp\utility::_id_10346(level._id_507C[var_2._id_1FBB][0]);
    }
  }

  scripts\engine\utility::flag_clear("flag_retreat_dialogue_active");
}

_id_1CDA(var_0) {
  var_1 = var_0 getistouchingentities(level.allies);

  if(!isDefined(var_1))
    return scripts\engine\utility::random(var_1);

  return scripts\engine\utility::random(level.allies);
}

_id_1CDB() {
  level waittill("notify_stop_retreat_logic");
  scripts\sp\utility::_id_F2D8(0.2);
}

_id_28DF(var_0) {
  level endon(var_0);
  scripts\sp\utility::_id_28D7();
  scripts\sp\utility::_id_CF8B();
}

_id_DAC0() {
  thread _id_547D();
  level._id_5061 scripts\engine\utility::delaythread(0.1, scripts\sp\utility::_id_9196, 3, 1, 1, "default");
  level._id_5061 scripts\engine\utility::delaythread(0.25, scripts\sp\utility::_id_9193, "default");
  level._id_5061 scripts\engine\utility::delaythread(0.3, scripts\sp\utility::_id_9196, 3, 1, 1, "default");
  level._id_5061 scripts\engine\utility::delaythread(0.45, scripts\sp\utility::_id_9193, "default");
  level._id_5061 scripts\engine\utility::delaythread(0.5, scripts\sp\utility::_id_9196, 3, 1, 1, "default");
  level._id_5061._id_12F9B _id_0E46::_id_48C4("tag_origin", (0, 0, 0), undefined, 0.5, undefined, undefined, 1);
  level._id_5061._id_12F9B waittill("trigger");
  level.player playgestureviewmodel("ges_door_hack", level._id_5061);
  thread scripts\sp\maps\rogue\rogue_util::_id_111E7(5.25, 30, 2, 200, 100);
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_CF8D();
  level._id_5061 scripts\engine\utility::delaythread(0.2, scripts\sp\utility::_id_9193, "default");
  level._id_5061 scripts\engine\utility::delaythread(0.3, scripts\sp\utility::_id_9196, 3, 1, 1, "default");
  level._id_5061 scripts\engine\utility::delaythread(0.35, scripts\sp\utility::_id_9193, "default");
  level._id_5061 scripts\engine\utility::delaythread(0.4, scripts\sp\utility::_id_9196, 3, 1, 1, "default");
  level._id_5061 scripts\engine\utility::delaythread(0.5, scripts\sp\utility::_id_9193, "default");
  var_0 = 105;
  scripts\engine\utility::flag_set("proximity_hacking_nodegrade");
  thread _id_0B66::_id_DAC0(var_0, level._id_5061, 1024, level._id_5061.origin);
  thread _id_DADA(var_0);
  var_1 = scripts\engine\utility::play_loopsound_in_space("rogue_hack_robotics_lp", level._id_5061.origin);
  setmusicstate("mx_225_rogue_dormitory");
  level._id_5061._id_12F9B _id_DAC5();
  scripts\engine\utility::flag_set("proximity_hack_end");
  level._id_5061 scripts\engine\utility::delaythread(0.1, scripts\sp\utility::_id_9196, 3, 1, 1, "default");
  level._id_5061 scripts\engine\utility::delaythread(0.25, scripts\sp\utility::_id_9193, "default");
  level._id_5061 scripts\engine\utility::delaythread(0.3, scripts\sp\utility::_id_9196, 3, 1, 1, "default");
  level._id_5061 scripts\engine\utility::delaythread(0.45, scripts\sp\utility::_id_9193, "default");
  level._id_5061 scripts\engine\utility::delaythread(0.5, scripts\sp\utility::_id_9196, 3, 1, 1, "default");
  level._id_5061 thread _id_12950();
  var_1 stoploopsound();
  level.player playSound("sa_hack_finish");
  scripts\sp\utility::_id_28D7();
  scripts\sp\utility::_id_CF8B();
  _id_5429();
}

_id_DADA(var_0) {
  thread hacking_signal_anti_save();
  thread load_control_transients();
  var_1 = [];
  var_1[0]["time"] = 0.1;
  var_1[0]["alias"] = "rogue_hud_hackat10percent";
  var_1[1]["time"] = 0.25;
  var_1[1]["alias"] = "rogue_hud_hackat25percent";
  var_1[2]["time"] = 0.37;
  var_1[2]["alias"] = "rogue_hud_hackat37percent";
  var_1[3]["time"] = 0.5;
  var_1[3]["alias"] = "rogue_hud_hackat50percent";
  var_1[4]["time"] = 0.62;
  var_1[4]["alias"] = "rogue_hud_hackat62percent";
  var_1[5]["time"] = 0.75;
  var_1[5]["alias"] = "rogue_hud_hackat75percent";
  var_1[6]["time"] = 0.95;
  var_1[6]["alias"] = "rogue_hud_hackat95percent";

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    while(var_1[var_2]["time"] > getomnvar("ui_hacking_time"))
      wait 0.05;

    level.player playSound(var_1[var_2]["alias"]);
  }

  scripts\engine\utility::flag_waitopen("proximity_hacking");
  level.player playSound("rogue_hud_hackcomplete");
  level notify("stop_checking_signal_status");
  scripts\engine\utility::flag_set("can_save");
}

load_control_transients() {
  var_0 = ["rogue_control_tr", "rogue_depot_tr"];
  scripts\sp\utility::_id_12643(var_0);
}

hacking_signal_anti_save() {
  level endon("stop_checking_signal_status");

  for(;;) {
    wait 0.1;

    if(getomnvar("ui_hacking_time") < 0) {
      if(scripts\engine\utility::flag("can_save"))
        scripts\engine\utility::flag_clear("can_save");

      continue;
    }

    if(!scripts\engine\utility::flag("can_save")) {
      wait 3;

      if(getomnvar("ui_hacking_time") > 0)
        scripts\engine\utility::flag_set("can_save");
    }
  }
}

_id_12950() {
  scripts\engine\utility::flag_wait("flag_player_opening_defend_door");
  scripts\engine\utility::delaythread(0.2, scripts\sp\utility::_id_9193, "default");
  scripts\engine\utility::delaythread(0.3, scripts\sp\utility::_id_9196, 3, 1, 1, "default");
  scripts\engine\utility::delaythread(0.35, scripts\sp\utility::_id_9193, "default");
  scripts\engine\utility::delaythread(0.4, scripts\sp\utility::_id_9196, 3, 1, 1, "default");
  scripts\engine\utility::delaythread(0.5, scripts\sp\utility::_id_9193, "default");
}

_id_DAC5() {
  level endon("proximity_hack_end");

  for(;;) {
    level waittill("proximity_hack_state_change", var_0, var_1);

    switch (var_0) {
      case "in_range":
        if(var_1 != "in_range")
          thread _id_5477();

        level notify("proximity_hack_inrange");
        break;
      case "losing_signal":
        if(var_1 == "in_range") {
          playworldsound("sa_hack_range", level.player.origin);
          thread _id_547B();
        }

        level notify("proximity_hack_losingsignal");
        break;
    }
  }
}

_id_103F0() {
  level endon("flag_defend_cleanup");
  var_0 = scripts\engine\utility::getStruct(self.target, "targetname") scripts\engine\utility::spawn_tag_origin();
  self linkTo(var_0);
  var_1 = 90;
  var_2 = var_0.angles[1];

  for(;;) {
    var_3 = level._id_111C3.time / 24;

    if(var_3 < 0.25 || var_3 > 0.75)
      var_3 = 0;
    else
      var_3 = (var_3 - 0.25) * 4;

    if(var_3 > 1)
      var_3 = 2 - var_3;

    var_4 = var_2 - var_1 * var_3;
    var_0 rotateTo((var_0.angles[0], var_4, var_0.angles[2]), 1);
    scripts\engine\utility::waitframe();

    if(var_4 == var_1 && scripts\engine\utility::flag("flag_defend_b_final"))
      return;
  }
}

_id_103EE() {
  level endon("flag_defend_cleanup");
  var_0 = scripts\engine\utility::getStruct(self.target, "targetname") scripts\engine\utility::spawn_tag_origin();
  self linkTo(var_0);
  var_1 = var_0.angles[1];
  var_2 = 0;

  for(;;) {
    if(level._id_111C3.time < 6 || level._id_111C3.time > 18) {
      scripts\engine\utility::waitframe();
      continue;
    }

    if(var_0.angles[1] != var_1)
      var_3 = var_1;
    else
      var_3 = var_1 - randomfloatrange(10, 20);

    var_4 = randomfloatrange(0.3, 0.7);
    var_0 rotateTo((var_0.angles[0], var_3, var_0.angles[2]), var_4, var_4 * 0.5, var_4 * 0.5);
    wait(var_4);
  }
}

_id_6F48() {
  var_0 = getEnt("org_defend_asteroid", "targetname");
  var_0 scripts\sp\utility::_id_75C4("vfx_ra_spinning_debris_field_02", "tag_origin");
  var_0.origin = var_0.origin + (0, 0, 7000);

  while(!scripts\engine\utility::flag("flag_defend_cleanup"))
    scripts\engine\utility::wait_for_flag_or_time_elapses("flag_defend_cleanup", 120);

  var_0 scripts\sp\utility::_id_75F8("vfx_ra_spinning_debris_field_02", "tag_origin");
}

_id_67EF() {
  while(!level.player scripts\sp\utility::_id_D1DF((27948.8, 42495.3, -36.748), 0.5))
    wait 0.1;

  scripts\engine\utility::exploder("astroid_hit");
  wait 4;
  level notify("asteroid_hit_done");
}

_id_4DE8() {
  level._id_FE18 = [];

  foreach(var_1 in getEntArray("deadciv_shipping", "script_noteworthy")) {
    var_1 scripts\sp\utility::_id_23B7("civ_corpse");
    var_1 scripts\sp\anim::_id_1EC3(var_1, var_1.script_parameters);
    level._id_FE18 = scripts\engine\utility::array_add(level._id_FE18, var_1);
  }

  scripts\engine\utility::flag_wait("flag_defend_cleanup");
  scripts\engine\utility::array_call(level._id_FE18, ::delete);
}

_id_F349(var_0) {
  var_1 = ["group_enemy_defend_b_melee_right", "group_enemy_defend_b_melee_left", "group_enemy_defend_b_melee_top_left", "group_enemy_defend_b_melee_top_right"];

  foreach(var_3 in var_1) {
    foreach(var_5 in scripts\sp\utility::_id_77DF(var_3))
    var_5._id_EF15 = var_0;
  }
}

_id_5425() {
  if(level._id_10CDA == "shipping_defend_a")
    scripts\engine\utility::waitframe();

  scripts\engine\utility::flag_waitopen("flag_main_dialogue_active");
  scripts\engine\utility::flag_set("flag_main_dialogue_active");
  wait 0.3;
  level._id_B4F9 scripts\sp\utility::_id_10346("rogue_omr_weaponsandammo");
  level._id_13E12 scripts\sp\utility::_id_10346("asteroid_slt_allsatobeadvise");
  level.player scripts\sp\utility::_id_1034D("asteroid_plr_thatmaybeourcom");
  scripts\engine\utility::flag_set("command_objective");
  level.player scripts\sp\utility::_id_1034D("rogue_plr_holdforshadow");
  level._id_B33E scripts\sp\utility::_id_10346("rogue_ksh_roofleftside");
  level._id_B33E scripts\sp\utility::_id_10346("rogue_ksh_therestonsofem");
  scripts\engine\utility::flag_clear("flag_main_dialogue_active");
}

_id_5424() {}

_id_5423() {
  scripts\engine\utility::flag_waitopen("flag_main_dialogue_active");
  scripts\engine\utility::flag_set("flag_main_dialogue_active");
  level._id_13E12 scripts\sp\utility::_id_10346("rogue_slt_nightscominstay");
  level._id_B4F9 scripts\sp\utility::_id_10346("rogue_omr_keepputtinround");
  scripts\engine\utility::flag_clear("flag_main_dialogue_active");
}

_id_5426() {
  scripts\engine\utility::flag_waitopen("flag_main_dialogue_active");
  scripts\engine\utility::flag_set("flag_main_dialogue_active");
  level._id_B33B scripts\sp\utility::_id_10346("rogue_brk_weredark");
  level._id_13E12 scripts\sp\utility::_id_10346("rogue_slt_movenow");
  scripts\engine\utility::flag_wait("flag_defend_a_early_playerrun");
  level._id_B33E scripts\sp\utility::_id_10346("asteroid_ksh_whatarethechanc");
  level._id_B4F9 scripts\sp\utility::_id_10346("asteroid_omr_wegettothecomma");
  level._id_13E12 scripts\sp\utility::_id_10346("rogue_slt_checkacivil");
  scripts\engine\utility::flag_clear("flag_main_dialogue_active");
}

_id_547D() {
  scripts\engine\utility::flag_waitopen("flag_main_dialogue_active");
  scripts\engine\utility::flag_set("flag_main_dialogue_active");
  _id_547E();
  wait 2;
  scripts\engine\utility::flag_clear("flag_main_dialogue_active");
}

_id_547E() {
  level endon("notify_stop_dialogue");
  level._id_B33E _id_1034A("asteroid_ksh_controlroomisth");
  level._id_B4F9 _id_1034A("rogue_omr_thebloodythings");
  level._id_B33E _id_1034A("rogue_ksh_damnitidonotwan");
  level._id_13E12 _id_1034A("rogue_slt_wecanhackthroug");
  level._id_B4F9 _id_1034A("rogue_omr_rogerthat");
  level._id_13E12 _id_1034A("rogue_slt_allyoursreyes");
  wait 2;
  level._id_13E12 _id_1034A("rogue_slt_beadvisedcomman");
  level._id_B33B _id_1034A("rogue_brk_copywellcoverhi");
  thread scripts\sp\maps\rogue\rogue_util::_id_B344(4, "notify_dialogue_wave_1_start", "civilians");
  _id_10349(["rogue_slt_allyoursreyes", "rogue_slt_weresetslickhit", "rogue_omr_letsnotgetcorne"], "proximity_hacking", [level._id_13E12, level._id_13E12, level._id_B4F9]);
}

_id_1034A(var_0) {
  scripts\sp\utility::_id_10346(var_0);

  if(scripts\engine\utility::flag("proximity_hacking"))
    level notify("notify_stop_dialogue");
}

_id_549D() {
  scripts\engine\utility::flag_waitopen("flag_main_dialogue_active");
  scripts\engine\utility::flag_set("flag_main_dialogue_active");
  thread _id_549E();
  level waittill("notify_dialogue_wave_1_start");
  level._id_B33B scripts\sp\utility::_id_10346("rogue_brk_mechstwelveoclo");
  level._id_B33E scripts\sp\utility::_id_10346("rogue_ksh_heretheycome");
  level._id_B4F9 scripts\sp\utility::_id_10346("rogue_omr_weaponsfree");
  scripts\engine\utility::flag_clear("flag_main_dialogue_active");
}

_id_549E() {
  level._id_B4F9 scripts\sp\utility::_id_10346("rogue_omr_daycyclesupstay");
  thread _id_549F();
}

_id_549F() {
  scripts\engine\utility::flag_waitopen("power_on");
  level._id_B33B scripts\sp\utility::_id_10346("rogue_ksh_wegotshadow");
  scripts\engine\utility::flag_clear("flag_main_dialogue_active");
}

_id_54A0() {
  scripts\engine\utility::flag_waitopen("flag_main_dialogue_active");
  scripts\engine\utility::flag_set("flag_main_dialogue_active");
  level._id_B33B scripts\sp\utility::_id_10346("rogue_brk_daylightdayligh");
  level._id_13E12 scripts\sp\utility::_id_10346("rogue_slt_gettocover");
  scripts\engine\utility::flag_clear("flag_main_dialogue_active");
}

_id_54A2() {
  scripts\engine\utility::flag_waitopen("flag_main_dialogue_active");
  scripts\engine\utility::flag_set("flag_main_dialogue_active");
  level._id_B33E scripts\sp\utility::_id_10346("rogue_ksh_theyreswarmin");
  level._id_B4F9 scripts\sp\utility::_id_10346("rogue_omr_justdontletemge");
  scripts\engine\utility::flag_clear("flag_main_dialogue_active");
  thread _id_54A1();
}

_id_54A1() {
  scripts\engine\utility::flag_waitopen("power_on");
  level._id_13E12 scripts\sp\utility::_id_10346("rogue_slt_nightcyclegetre");
  level._id_B4F9 scripts\sp\utility::_id_10346("rogue_omr_letsthintheherd");
  scripts\engine\utility::flag_clear("flag_main_dialogue_active");
}

_id_54A3() {
  scripts\engine\utility::flag_waitopen("flag_main_dialogue_active");
  scripts\engine\utility::flag_set("flag_main_dialogue_active");
  level._id_B33B scripts\sp\utility::_id_10346("rogue_brk_sunsrising");
  level._id_13E12 scripts\sp\utility::_id_10346("rogue_slt_hacksalmostdone");
  level._id_B33E scripts\sp\utility::_id_10346("rogue_ksh_theyjustkeepcom");
  level._id_B4F9 scripts\sp\utility::_id_10346("rogue_omr_killeveryoneofe");
  level._id_B33B thread scripts\sp\utility::_id_10346("rogue_brk_oorah");
  level._id_B33E thread scripts\sp\utility::_id_10346("rogue_ksh_oorah");
  scripts\engine\utility::flag_clear("flag_main_dialogue_active");
}

_id_54A4() {
  scripts\engine\utility::flag_waitopen("flag_main_dialogue_active");
  scripts\engine\utility::flag_set("flag_main_dialogue_active");
  level._id_13E12 scripts\sp\utility::_id_10346("rogue_slt_gettingdark");
  level._id_B4F9 scripts\sp\utility::_id_10346("rogue_omr_heresourwindowd");
  scripts\engine\utility::flag_clear("flag_main_dialogue_active");
}

_id_5477() {
  scripts\engine\utility::flag_waitopen("flag_main_dialogue_active");
  scripts\engine\utility::flag_set("flag_main_dialogue_active");
  level._id_13E12 _id_0B6A::_id_EC0E("Hack is back in range.");
  scripts\engine\utility::flag_clear("flag_main_dialogue_active");
}

_id_5427() {
  scripts\engine\utility::flag_waitopen("flag_main_dialogue_active");
  scripts\engine\utility::flag_set("flag_main_dialogue_active");
  level._id_13E12 scripts\sp\utility::_id_F6FE("vignette");
  level._id_13E12 scripts\sp\utility::_id_10346("rogue_slt_grabthedoorreye");

  if(!scripts\engine\utility::flag("flag_player_opening_defend_door"))
    level._id_B4F9 _id_10349("rogue_omr_keepusmovincapt", "flag_player_opening_defend_door");

  wait 0.1;
  level._id_B4F9 scripts\sp\utility::_id_10346("rogue_usf_everyonegood");
  level._id_B33B scripts\sp\utility::_id_10346("rogue_brk_goodtogo");
  level._id_13E12 scripts\sp\utility::_id_10346("rogue_slt_letskeeprollin");
  scripts\engine\utility::flag_clear("flag_main_dialogue_active");
}

_id_547B() {
  scripts\engine\utility::flag_waitopen("flag_main_dialogue_active");
  scripts\engine\utility::flag_set("flag_main_dialogue_active");
  level._id_13E12 scripts\sp\utility::_id_10346("rogue_slt_signalsweakstay");
  scripts\engine\utility::flag_clear("flag_main_dialogue_active");
  var_0 = ["rogue_slt_reyesyouretoofa", "rogue_slt_signalsweakstay"];
  level._id_13E12 thread _id_10349(var_0, "proximity_hack_inrange");
}

_id_5429() {
  level endon("control_cam_effects_go");
  level._id_13E12 scripts\sp\utility::_id_10346("rogue_slt_hacksdone");
  level.player scripts\sp\utility::_id_1034D("rogue_plr_locksdisengaged");

  if(getaicount("axis") > 0)
    level._id_B4F9 scripts\sp\utility::_id_10346("rogue_omr_finishemoffbefo");
}

_id_5428() {}

stop_following_all_players(var_0, var_1) {
  scripts\engine\utility::array_thread(scripts\sp\utility::_id_77DF(var_0), scripts\sp\utility::_id_F225, "stop current floodspawner");
  thread _id_0B77::_id_6F5D(getEnt(var_1, "script_noteworthy"));
}

_id_F58F() {
  self._id_EDB0 = 1;
}

_id_F0CA() {
  scripts\sp\maps\rogue\rogue_util::_id_40BF();
  var_0 = getaiunittypearray("all", "C6");

  foreach(var_2 in var_0)
  var_2 delete();
}

_id_A657(var_0) {
  self endon("death");
  self._id_C3B1 = self._id_2894;
  var_0 = scripts\sp\maps\rogue\rogue_util::_id_2289(var_0);
  var_1 = 0;
  var_2 = undefined;

  for(;;) {
    var_3 = [];

    foreach(var_5 in var_0) {
      var_6 = var_5;

      if(isstring(var_6))
        var_6 = scripts\sp\utility::_id_77DA(var_6);

      var_3 = scripts\engine\utility::array_combine(var_3, var_6);

      if(!var_1) {
        scripts\sp\utility::_id_1938(var_3, 1024);
        var_1 = 1;
      }
    }

    var_3 = scripts\engine\utility::array_removeundefined(var_3);
    var_3 = scripts\sp\utility::_id_DFEB(var_3);

    foreach(var_9 in sortbydistance(var_3, self.origin)) {
      if(!isDefined(var_9) || !isalive(var_9)) {
        continue;
      }
      if(isDefined(var_9._id_A65E) && isDefined(var_2) && !var_2) {
        continue;
      }
      var_2 = 1;
      var_9._id_A65E = self;
      scripts\sp\utility::_id_F39C(var_9);
      scripts\sp\utility::_id_F2D8(10000);
      var_9 scripts\engine\utility::waittill_notify_or_timeout("death", randomfloatrange(2, 4));

      if(isDefined(var_9) && isalive(var_9))
        var_9 _meth_81D0(var_9.origin, self);
    }

    if(!isDefined(var_2))
      var_2 = 0;
    else
      var_2 = undefined;

    scripts\engine\utility::waitframe();
  }

  scripts\sp\utility::_id_F2D8(self._id_C3B1);
}

_id_1377F(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = [];

  foreach(var_9 in var_0) {
    if(isstring(var_9)) {
      var_7 = scripts\engine\utility::array_combine(var_7, scripts\sp\utility::_id_77DA(var_9));
      continue;
    }

    var_7 = scripts\engine\utility::array_add(var_7, var_9);
  }

  _id_1377C(var_7, var_1, var_2, var_3, var_4, var_5, var_6);
}

_id_1377C(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  wait 1;
  var_7 = "waittill_group";

  if(isstring(var_0))
    var_7 = var_7 + ("_" + var_0);

  level notify(var_7);
  level endon(var_7);

  if(isDefined(var_6)) {
    var_6 = scripts\sp\maps\rogue\rogue_util::_id_2289(var_6);

    foreach(var_9 in var_6)
    self endon(var_9);
  }

  var_11 = 0;

  if(isDefined(var_1)) {
    var_11++;
    childthread _id_145C(var_0, var_1, var_7);
  }

  if(isDefined(var_3)) {
    var_11++;
    childthread _id_145D(var_0, var_3, var_7, var_4, var_5);
  }

  if(isDefined(var_2)) {
    if(var_11 == 0) {}

    childthread _id_145B(var_0, var_2, var_7, var_4, var_5);
  }

  if(var_11 == 0)
    childthread _id_145C(var_0, 0, var_7);

  level waittill(var_7);
}

_id_145D(var_0, var_1, var_2, var_3, var_4) {
  level endon(var_2 + "_timeout");
  wait(var_1);

  if(isDefined(var_3)) {
    level notify(var_2 + "_num_killed");

    if(isDefined(var_4))
      [[var_3]](var_4);
    else
      [[var_3]]();

    return;
  }

  level notify(var_2);
}

_id_145B(var_0, var_1, var_2, var_3, var_4) {
  level endon(var_2 + "_num_killed");
  var_5 = level.player._id_10E53["kills"];

  while(level.player._id_10E53["kills"] - var_5 < var_1)
    scripts\engine\utility::waitframe();

  if(isDefined(var_3)) {
    level notify(var_2 + "_timeout");

    if(isDefined(var_4))
      [[var_3]](var_4);
    else
      [[var_3]]();

    return;
  }

  level notify(var_2);
}

_id_145C(var_0, var_1, var_2) {
  level endon(var_2 + "_num_left");
  var_3 = var_0;

  for(;;) {
    if(isstring(var_0))
      var_3 = scripts\sp\utility::_id_77DA(var_0);
    else {
      var_3 = scripts\engine\utility::array_removeundefined(var_3);
      var_3 = scripts\sp\utility::_id_22B9(var_3);
    }

    if(var_3.size <= var_1) {
      break;
    }

    wait 0.5;
  }

  level notify(var_2);
}

_id_E5B2(var_0, var_1, var_2) {
  level endon(var_2);
  var_0 = getEnt(var_0, "targetname");
  var_1 = scripts\sp\maps\rogue\rogue_util::_id_2289(var_1);
  thread _id_E2A7(var_2);

  for(;;) {
    scripts\engine\utility::flag_wait("power_on");
    var_3 = [];

    foreach(var_5 in var_1) {
      var_6 = var_5;

      if(isstring(var_6))
        var_6 = scripts\sp\utility::_id_77DA(var_6);

      var_3 = scripts\engine\utility::array_combine(var_3, var_0 getistouchingentities(var_6));
      scripts\engine\utility::array_thread(var_3, ::_id_E5B4, var_0);
    }

    wait 1;
  }
}

_id_E5B4(var_0) {
  if(isDefined(self._id_1120B) && self._id_1120B == var_0) {
    return;
  }
  self endon("death");
  self._id_1120B = var_0;
  _id_32A2();
  thread _id_4E42();

  for(;;) {
    if(isDefined(self._id_1120B) && !self istouching(self._id_1120B)) {
      self._id_1120B = undefined;
      _id_12B85();
      return;
    } else if(!isDefined(self._id_1120B) && self istouching(self._id_1120B))
      _id_32A2();

    _id_E5B3();
    wait 1;
  }
}

_id_E5B3(var_0, var_1) {
  var_2 = [];

  if(!isDefined(self._id_217E))
    self._id_217E = "none";

  foreach(var_9, var_4 in self._id_4D5D) {
    if(var_9 != "head" && (self _meth_850C(var_9) > 0 || var_9 == "torso"))
      var_2[var_9] = [];
    else
      continue;

    foreach(var_8, var_6 in self._id_4D5D[var_9].partnerheli) {
      var_7 = self _meth_850C(var_9, var_8);

      if(var_7 > 0) {
        var_2[var_9][var_8] = spawnStruct();
        var_2[var_9][var_8].health = var_7;
        var_2[var_9][var_8].maxhealth = self._id_4D5D[var_9].partnerheli[var_8].maxhealth;
        var_2[var_9][var_8]._id_4D6F = self._id_4D5D[var_9].partnerheli[var_8]._id_4D6F;
      }
    }
  }

  var_9 = undefined;
  var_8 = undefined;

  if(var_2.size == 0) {
    return;
  }
  if(isDefined(var_0))
    var_9 = var_0;
  else
    var_9 = scripts\engine\utility::random(getarraykeys(var_2));

  if(var_2[var_9].size == 0) {
    return;
  }
  if(isDefined(var_1))
    var_8 = var_1;
  else
    var_8 = scripts\engine\utility::random(getarraykeys(var_2[var_9]));

  if(!isDefined(var_2[var_9][var_8])) {
    return;
  }
  var_10 = var_2[var_9][var_8].maxhealth;
  self _meth_850B(var_10, var_9, var_8);
  self._id_217E = var_2[var_9][var_8]._id_4D6F;
}

_id_32A2() {
  if(isDefined(self.burning) && self.burning) {
    return;
  }
  self endon("death");
  self.burning = 1;
  self notify("burning");

  if(!isDefined(self._id_3298)) {
    self._id_3298 = scripts\engine\utility::spawn_tag_origin();
    self._id_3298 linkTo(self, "tag_torso", (0, 0, 0), (0, 0, 0));
  }

  playFXOnTag(level._effect["vfx_c6_sun_exposure"], self._id_3298, "tag_origin");
}

_id_E2A7(var_0) {
  level endon(var_0);
  var_1 = 7;

  for(;;) {
    var_2 = [];
    var_3 = getaiarray("axis");

    foreach(var_5 in var_3) {
      if(isDefined(var_5.burning) && var_5.burning)
        var_2[var_2.size] = var_5;
    }

    var_2 = sortbydistance(var_2, level.player.origin);
    var_7 = 0;

    if(var_2.size >= var_1)
      var_7 = var_1;
    else
      var_7 = var_2.size;

    for(var_8 = 0; var_8 < var_7; var_8++)
      playFXOnTag(level._id_7649["c6_shock"], var_2[var_8]._id_3298, "tag_origin");

    wait 1;
  }
}

_id_32A3() {
  self endon("burn_stopped");

  for(;;) {
    playFX(level._id_7649["c6_shock"], (0, 0, 0));
    playFXOnTag(level._id_7649["c6_shock"], self._id_3298, "tag_origin");
    wait 1;
  }
}

_id_12B85() {
  if(!isDefined(self.burning) || !self.burning) {
    return;
  }
  self.burning = undefined;
  self notify("burn_stopped");
  killfxontag(level._effect["vfx_c6_sun_exposure"], self._id_3298, "tag_origin");
}

_id_4E42() {
  self waittill("death");
  killfxontag(level._effect["vfx_c6_sun_exposure"], self._id_3298, "tag_origin");
}

_id_467F() {
  level endon("flag_defend_cleanup");

  for(;;) {
    var_0 = getcorpsearray();

    if(var_0.size - 10 > 0) {
      for(var_1 = 0; var_1 < 10; var_1++) {
        var_2 = scripts\engine\utility::random(var_0);

        if(!level.player scripts\sp\utility::_id_D1DF(var_2.origin, 0.5, 1)) {
          var_0 = scripts\engine\utility::array_remove(var_0, var_2);
          var_2 delete();
        }
      }
    }

    wait 5;
  }
}

_id_10349(var_0, var_1, var_2, var_3) {
  level notify("notify_stop_dialogue_nag");
  level endon("notify_stop_dialogue_nag");

  if(isDefined(var_1))
    level endon(var_1);

  if(!scripts\engine\utility::flag_exist("flag_dialogue_nag_active"))
    scripts\engine\utility::flag_init("flag_dialogue_nag_active");

  scripts\engine\utility::flag_clear("flag_dialogue_nag_active");
  var_0 = scripts\engine\utility::ter_op(isarray(var_0), var_0, [var_0]);

  if(isDefined(var_2)) {}

  if(!isDefined(var_3))
    var_3 = 1;

  var_4 = [];
  var_5 = 0;
  var_6 = 8;
  var_7 = 12;
  var_8 = randomfloatrange(var_6, var_7);
  var_4 = var_0;
  var_9 = 1;

  for(;;) {
    scripts\engine\utility::waitframe();
    var_10 = undefined;

    if(var_5 >= var_8) {
      if(var_4.size == 0) {
        if(!isDefined(var_3) || !var_3) {
          return;
        }
        var_4 = var_0;
        var_6 = 10;
        var_7 = 20;
      }

      if(var_9 && var_4.size == var_0.size) {
        var_10 = var_4[0];
        var_9 = 0;
      } else
        var_10 = scripts\engine\utility::random(var_4);

      var_11 = scripts\engine\utility::array_find(var_4, var_10);
      var_4 = scripts\engine\utility::array_remove(var_4, var_10);
      var_5 = 0;
      var_8 = randomfloatrange(var_6, var_7);
      var_12 = self;

      if(isDefined(var_2))
        var_12 = var_2[var_11];

      var_12 childthread _id_1407(var_0[var_11]);
    }

    if(!scripts\engine\utility::flag("flag_dialogue_nag_active"))
      var_5 = var_5 + 0.05;
  }
}

_id_1407(var_0) {
  scripts\engine\utility::flag_set("flag_dialogue_nag_active");

  if(issubstr(var_0, "tmp"))
    _id_0B6A::_id_EC0E(var_0);
  else if(self == level.player)
    scripts\sp\utility::_id_1034D(var_0);
  else
    scripts\sp\utility::_id_10346(var_0);

  scripts\engine\utility::flag_clear("flag_dialogue_nag_active");
}

_id_75D0() {
  level.player endon("death");
  scripts\engine\utility::flag_wait("flag_defend_a_start");

  for(;;) {
    scripts\engine\utility::exploder("shiprockcrash_00");
    scripts\engine\utility::exploder("shiprockleave_00");

    if(scripts\engine\utility::flag("flag_proximity_hack_intro")) {
      return;
    }
    wait 21;
  }
}

_id_75D1() {
  level.player endon("death");
  scripts\engine\utility::flag_wait("flag_proximity_hack_intro");

  for(;;) {
    scripts\engine\utility::exploder("shiprockcrash_opp_00");
    scripts\engine\utility::exploder("shiprockleave_opp_00");

    if(scripts\engine\utility::flag("proximity_hack_end")) {
      return;
    }
    wait 23;
  }
}

_id_16EC() {
  var_0 = getEntArray("steeldragon_pickup", "targetname");

  foreach(var_2 in var_0)
  var_2 thread _id_746B();
}

_id_746B() {
  var_0 = scripts\engine\utility::spawn_tag_origin(self.origin + (0, 0, 5));
  var_0 _id_0E46::_id_48C4("tag_origin", undefined, undefined, undefined, 750, 0, 1, 0, 0, &"hud_interaction_prompt_center_steel_dragon", 0, 0);

  for(;;) {
    var_1 = level.player scripts\engine\utility::waittill_any_return("weapon_change", "weapon_dropped", "kill_fspar_hint");

    if(issubstr(level.player getcurrentweapon(), "steeldragon")) {
      break;
    } else if(isDefined(var_1) && var_1 == "kill_fspar_hint") {
      break;
    }
  }

  var_0 _id_0E46::_id_DFE3();
  var_0 delete();
}

_id_FE29(var_0) {
  if(gettime() < 5000)
    wait 5;

  for(;;) {
    level scripts\engine\utility::waittill_any("power_on", "power_off", "proximity_hack_end");
    var_1 = scripts\sp\utility::_id_77DF(var_0);

    if(scripts\engine\utility::flag("proximity_hack_end")) {
      foreach(var_3 in var_1) {
        if(isDefined(var_3)) {
          if(!isDefined(var_3._id_10D99))
            var_3._id_10D99 = var_3.count;

          var_3.count = 0;
        }
      }

      break;
    }

    if(scripts\engine\utility::flag("power_off")) {
      foreach(var_3 in var_1) {
        if(isDefined(var_3)) {
          if(!isDefined(var_3._id_10D99))
            var_3._id_10D99 = var_3.count;

          var_3.count = 0;
        }
      }

      continue;
    }

    foreach(var_3 in var_1) {
      if(isDefined(var_3)) {
        if(isDefined(var_3._id_10D99)) {
          var_3.count = var_3._id_10D99;
          continue;
        }

        var_3.count = 999;
      }
    }
  }
}

_id_5065() {
  var_0 = getEnt("defend_hackbot_burn_vol", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  for(;;) {
    level.player scripts\sp\utility::_id_65E3("is_hacked_robot");
    thread _id_FD3E(var_0);
    level._id_880A thread scripts\sp\maps\rogue\rogue_util::_id_E642();
    level.player scripts\sp\utility::_id_65E8("is_hacked_robot");
    level.player notify("no_longer_bot");
    level._id_880A notify("stop_burning_sfx");
  }
}

_id_FD3E(var_0) {
  self endon("no_longer_bot");
  var_1 = 20;
  var_2 = 0.5;

  for(;;) {
    if(level.player istouching(var_0) && scripts\engine\utility::flag("power_on"))
      level.player dodamage(var_1, level._id_111C3.ent.origin * (-1, -1, 1));

    wait(var_2);
  }
}