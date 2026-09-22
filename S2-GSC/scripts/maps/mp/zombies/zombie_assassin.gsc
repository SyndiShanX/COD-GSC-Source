/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\zombie_assassin.gsc
*******************************************************/

#using_animtree("zombie_assassin");

init() {
  init_assassin_vfx();
  init_scripted_states();
  init_assassin_phase_handler();
  init_assassin_spawns_and_exits();
  init_assassin_vo_flags();
  maps\mp\agents\_scripted_agent_anim_util::_id_5159("zombie_assassin");
  var_0 = level._id_0A41["zombie"];
  var_0["get_action_params"] = ::assassin_get_action_params;
  var_0["think"] = ::assassin_think;
  var_0["move_mode"] = ::zombie_assassin_move_mode_func;
  var_0["on_damaged"] = ::zombie_assassin_on_damaged;
  var_0["tesla_delayed_dmg"] = ::zombie_assassin_tesla_delayed_dmg;
  level._id_0A41["zombie_assassin"] = var_0;
  var_1 = spawnStruct();
  var_1._id_0A4B = "zombie_assassin";
  var_1._id_0EAE = "zombie_assassin_animclass";
  var_1._id_0E88 = "zombie_assassin";
  var_1._id_0879 = "zombie_assassin";
  var_1._id_5ED2["default look"]["whole_body"] = "zom_assassin_body";
  var_1._id_5ED2["default look"]["heads"] = ["zom_assassin_head"];
  var_1._id_5ED2["boss look"]["whole_body"] = "zom_elite_assassin_body";
  var_1._id_5ED2["boss look"]["heads"] = ["zom_elite_assassin_head"];
  var_1._id_60E2 = 90;
  var_1._id_4C12 = 25;
  _id_0547::_id_0A52(var_1, "zombie_assassin");
  _id_0547::registeranimtree("zombie_assassin", #animtree);
}

init_assassin_phase_handler() {
  var_0 = spawnStruct();
  var_0._id_3F02 = _id_0547::_id_4B2C;
  var_0.value = 0;
  register_assassin_phase("Phase 1: Entrance", "Phase 2: IDLE TRANSITION", ::prowl_timeout_func, [0.2], ["assassin_was_koed", "zmb_assassin_is_alarmed"], [var_0]);
  register_assassin_phase("Phase 2: IDLE TRANSITION", "Phase 2: IDLE", ::assassin_begin_ambush, [], ["assassin_was_koed", "zmb_assassin_is_alarmed"], [var_0]);
  register_assassin_phase("Phase 2: IDLE", "Phase 2: EXIT AMBUSH", ::assassin_continue_ambush, [], ["assassin_was_koed", "zmb_assassin_is_alarmed"], [var_0]);
  register_assassin_phase("Phase 2: EXIT AMBUSH", "Phase 3: ATTACK", ::assassin_execute_ambush, [], ["assassin_was_koed"], [var_0]);
  register_assassin_phase("Phase 3: ATTACK", "Phase 4: EXITING", ::assassin_continue_attack, [], ["assassin_was_koed", "zmb_assassin_fish_out_of_water"], [var_0]);
  register_assassin_phase("Phase 4: EXITING", "Phase 3: ATTACK", ::assassin_revert_to_phase_3, [], undefined, [var_0]);
}

assassin_set_alarmed() {
  common_scripts\utility::_id_379A("zmb_assassin_is_alarmed");
}

move_main() {
  self endon("killanimscript");
  self scragentsetphysicsmode("gravity");
  self._id_5759 = 1;

  if(isDefined(self.assassin_should_execute_voulnerability) && !common_scripts\utility::_id_562E(self.isassassindemo)) {
    setassassinvoulnerable();
  } else {
    maps\mp\agents\humanoid\_humanoid_move::_id_92E9();
  }

  maps\mp\agents\humanoid\_humanoid_move::_id_2603();
}

setassassinvoulnerable() {
  self notify("humanoidmove_endwait_ambush");
  self endon("humanoidmove_endwait_ambush");
  self endon("killanimscript");
  var_0 = 0;

  if(_id_0547::_id_5565(self.assassin_should_execute_voulnerability, "idle_to_atk_asn")) {
    var_0 = 1;
  }

  var_1 = self.assassin_should_execute_voulnerability;
  self.assassin_should_execute_voulnerability = undefined;
  maps\mp\agents\humanoid\_humanoid_move::_id_1F39("");
  self._id_01BB = 1;
  self scragentsetanimmode("anim deltas");
  self scragentsetorientmode("face angle abs", self.angles);
  thread transition_to_motion(var_1);

  if(var_0) {
    childthread dodamageonjoints(["J_poker2_RI", "J_poker2_LE"], 30);
  }

  maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_1, 0, 1.0, "move_start");
  self notify("stop_joint_strike");
}

transition_to_motion(var_0) {
  var_1 = self getanimentry(var_0, 0);
  var_2 = _getanimlength(var_1);
  wait(var_2 * 0.55);
  self scragentsetorientmode("face enemy");
}

register_assassin_phase(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.zmb_asn_agent_phases)) {
    level.zmb_asn_agent_phases = [];
  }

  var_6 = spawnStruct();
  var_6.name = var_0;
  var_6.next_phase = var_1;
  var_6.func_and_data = common_scripts\utility::_id_0F73([var_2], var_3);
  var_6.reasons_to_skip = var_4;
  var_6.reasons_to_block_progress = var_5;
  level.zmb_asn_agent_phases[var_6.name] = var_6;
}

assassin_get_action_params() {
  var_0 = _id_054D::_id_AC22();
  var_0["action_table"] = "zombie_assassin";
  var_0["zombie_subtype"] = "zombie_assassin";
  var_0["move_speed"] = self._id_0108;

  if(self.prowl_timer < 2 && common_scripts\utility::_id_3794("Phase 1: Entrance")) {
    var_0["script_var"] = "looking_to_crouch";
  } else {
    var_0["script_var"] = "walk_to_sprint";
  }

  return var_0;
}

assassin_think() {
  self endon("death");
  level endon("game_ended");
  self endon("owner_disconnect");
  common_scripts\utility::_id_3799("zombie_passive");
  self _meth_85A1("zombie_assassin");
  self.phases = level.zmb_asn_agent_phases;
  self.nomutilate = 1;
  self.nopairmelee = 1;
  self.player_hit_list = [];
  self._id_56EB = 1;
  self._id_2FA4 = 0;
  self._id_509A = 1;
  self._id_6816 = 1;
  self._id_55AB = 1;
  self._id_562B = 1;
  self.customrecyclehandling = maps\mp\zombies\zombie_assassin_spawner_logic::respawnanassassinzombie;
  self.maxstartmovespeed = _id_0547::milesperhour_to_inchespersec(1);
  self.cornerlessturnmindegreeoverride = 70;
  self.useprojectedturnlimiting = 1;
  common_scripts\utility::_id_3799("ready_to_attack");
  self.my_ignore_players_list = [];
  _id_0566::_id_ABB5();
  _id_0547::_id_86C7(80);
  self.attackpointoffset = 28;
  self._id_66EC = 1;
  self.custom_on_melee_func = ::assassin_melee_extension;
  self._id_2FE3[16]["noFx"] = 1;
  childthread override_turn_func();
  childthread ghost_through_passives();
  thread handle_character_sighting_vo();
  thread maps\mp\zombies\zombie_assassin_aud::init_assassin_aud_state_info();
  self.prowl_timer = 4.75;
  init_my_phase_flags();
  common_scripts\utility::_id_3799("Assassin did go idle");
  common_scripts\utility::_id_3799("zmb_assassin_is_alarmed");
  common_scripts\utility::_id_3799("assassin_was_koed");
  common_scripts\utility::_id_3799("zmb_assassin_fish_out_of_water");
  childthread run_alarm_funcs();
  assign_initial_phase();
  var_0 = spawnStruct();
  var_0.check = maps\mp\zombies\zombie_assassin_spawner_logic::assassin_has_teleported;
  var_0._id_3F02 = maps\mp\zombies\zombie_assassin_spawner_logic::unset_assassin_has_teleported;
  var_1 = spawnStruct();
  var_1.check = maps\mp\zombies\zombie_assassin_spawner_logic::assassin_needs_vfx_refresh;
  var_1._id_3F02 = maps\mp\zombies\zombie_assassin_spawner_logic::assassin_vfx_refreshed;

  if(is_an_elite_assassin()) {
    thread maps\mp\mp_zombie_island_fog_zones::run_fog_callbacks(undefined, 1, undefined, undefined, ::on_boss_assassin_enter_fog, ::on_boss_assassin_exit_fog, [var_0, var_1]);
  } else {
    thread maps\mp\mp_zombie_island_fog_zones::run_fog_callbacks(undefined, 1, undefined, undefined, ::on_assassin_enter_fog, ::on_assassin_exit_fog, [var_0]);
  }

  self._id_0EAD._id_6AFE["move"] = ::move_main;
  self.assassin_melee_side = randomint(2);

  for(;;) {
    if(isDefined(self.custom_think_mode)) {
      self[[self.custom_think_mode]]();
    } else {
      if(isDefined(self._id_3043) && !isDefined(self.has_lost_distractiondrone_interest)) {
        childthread lose_interest_in_time(4.5, self._id_3043);
      }

      run_assassin_phase_logic();

      if(assassin_execute_attack()) {} else if(_id_053C::_id_4F9B()) {} else if(_id_053C::_id_4F9A()) {} else
        _id_053C::_id_0647();
    }

    _id_0566::zombie_generic_think_wait();
  }
}

assassin_attack_cooldown(var_0) {
  self endon("death");

  if(common_scripts\utility::_id_562E(self.assassinragecooldown) && !common_scripts\utility::_id_562E(var_0)) {
    return;
  }
  self notify("new_assassin_cooldown");
  self endon("new_assassin_cooldown");
  self.assassinragecooldown = 1;
  common_scripts\utility::_id_A70D(1.85, self, "damage");
  self.assassinragecooldown = 0;
}

lose_interest_in_time(var_0, var_1) {
  wait(var_0);
  self.has_lost_distractiondrone_interest = 1;

  while(isDefined(var_1)) {
    waitframe();
  }

  self.has_lost_distractiondrone_interest = undefined;
}

assassin_melee_extension() {
  self endon("death");
  self endon("assassin_melee_done");
  childthread dodamageonjoints(["J_poker2_RI", "J_poker2_LE"], 30);
}

play_emerge_fx() {
  self endon("death");
  self notify("new_emerge_fx");
  self endon("new_emerge_fx");

  if(isDefined(self.my_emerge_fx)) {
    self.my_emerge_fx delete();
  }

  while(!_id_0547::_id_4B2C()) {
    waitframe();
  }

  self.my_emerge_fx = play_fx_on_zmb_assassin("zmb_isl_fog_zmb_emerge_01", "tag_origin");
}

stop_emerge_fx() {
  if(isDefined(self.my_emerge_fx)) {
    self.my_emerge_fx delete();
    self.my_emerge_fx = undefined;
  }
}

assassin_execute_attack() {
  if(common_scripts\utility::_id_3794("Phase 4: EXITING")) {
    return 0;
  }

  if(assassin_activate_special_ability()) {
    thread assassin_attack_cooldown(1);
    try_to_make_assassin_leave();
    return 1;
  }

  if(assassin_begin_melee()) {
    return 1;
  }

  if(_id_053C::_id_4F84()) {
    if(!isDefined(self._id_28D2.numstandinghits)) {
      self._id_28D2.numstandinghits = 0;
    }

    self._id_28D2.numstandinghits++;

    if(self._id_28D2.numstandinghits > 1) {
      thread assassin_attack_cooldown();
      assassin_ignore_player(self._id_28D2);
      self._id_28D2.numstandinghits = 0;
    }

    thread finish_assassin_extened_melee();
    return 1;
  }

  return 0;
}

try_to_make_assassin_leave() {
  self.remaining_special_activations--;

  if(self.remaining_special_activations <= 0) {
    thread make_assassin_leave_arena(4.5);
  }
}

make_assassin_leave_arena(var_0) {
  self endon("death");
  self endon("assassin_was_koed");

  if(common_scripts\utility::_id_562E(self.assassinabilitysustained)) {
    var_0 = var_0 / 2;
  }

  while(common_scripts\utility::_id_562E(self.assassinabilitysustained)) {
    waitframe();
  }

  self.is_being_asked_to_leave_soon = 1;
  disable_assassin_chest_fx();
  var_0 = _func_2CA(var_0, var_0 * 2.15, 1 / level.players.size);
  wait(var_0);
  disable_assassin_chest_fx();
  self.is_being_asked_to_leave_soon = 0;
  self.assassinmuststopattackingandleave = 1;
}

finish_assassin_extened_melee() {
  self endon("death");
  wait 0.9;
  self notify("assassin_melee_done");
}

enable_assassin_chest_fx() {
  self.assassin_boss_vfx_disabled = 0;
  restart_assassin_boss_vfx();
}

disable_assassin_chest_fx() {
  self.assassin_boss_vfx_disabled = 1;
  remove_assassin_boss_vfx();
}

on_boss_assassin_enter_fog() {
  thread on_assassin_enter_fog();
  display_boss_assassin_chest_fx("ext");
}

on_boss_assassin_exit_fog() {
  thread on_assassin_exit_fog();
  display_boss_assassin_chest_fx("int");
}

display_boss_assassin_chest_fx(var_0) {
  if(common_scripts\utility::_id_562E(self.assassin_boss_vfx_disabled)) {
    return;
  }
  thread play_my_assassin_id_fx(var_0);
}

remove_assassin_boss_vfx() {
  if(isDefined(self.mod_fx)) {
    self.mod_fx delete();
  }
}

restart_assassin_boss_vfx() {
  self.assassin_should_refresh_boss_vfx = 1;
}

on_assassin_enter_fog() {
  thread play_emerge_fx();
}

on_assassin_exit_fog() {
  thread stop_emerge_fx();
}

assign_initial_phase() {
  waitframe();

  if(isDefined(self.optionalinitialstate)) {
    set_assassin_phase(self.optionalinitialstate);
  } else {
    set_assassin_phase("Phase 1: Entrance");
  }
}

run_assassin_phase_logic() {
  if(!assassin_is_in_fog()) {
    if(!common_scripts\utility::_id_562E(self.optionaldisablefogsensitivity)) {
      self.assassinmustleave = 1;
      common_scripts\utility::_id_379A("zmb_assassin_fish_out_of_water");
    }
  }

  foreach(var_1 in level.zmb_asn_agent_phases) {
    if(common_scripts\utility::_id_3794(var_1.name)) {
      phase_handler(var_1);
    }
  }
}

wait_with_endon(var_0, var_1) {
  foreach(var_3 in var_1) {
    self endon(var_3);
  }

  wait(var_0);
}

assassin_activate_special_ability() {
  if(isDefined(self.remaining_special_activations) && self.remaining_special_activations <= 0) {
    return 0;
  }

  if(maps\mp\agents\_scripted_agent_anim_util::_id_57E2()) {
    return 0;
  }

  if(!isDefined(self.assassin_special_wait)) {
    self.assassin_special_wait = 1;
    thread activate_assassin_special_in_time(6.5);
  }

  if(common_scripts\utility::_id_562E(self.dontwaitonfirstattack) || !common_scripts\utility::_id_562E(self.assassin_special_wait) && !common_scripts\utility::_id_562E(self.assassinmustleave) && isDefined(self.assassin_seek_func) && [[self.assassin_seek_func]]() && common_scripts\utility::_id_3794("zmb_assassin_is_alarmed") && !common_scripts\utility::_id_3794("Phase 1: Entrance")) {
    if(common_scripts\utility::_id_562E(self.dontwaitonfirstattack)) {
      self.dontwaitonfirstattack = 0;
    }

    self thread[[self.assassin_attack_func]]();

    if(!common_scripts\utility::_id_562E(self.reverse_assassin_specials_visuals)) {
      disable_assassin_chest_fx();
    } else {
      enable_assassin_chest_fx();
    }

    _id_0547::_id_7D1A("activate_assassin_ability");

    if(common_scripts\utility::_id_562E(self.leaveafterspecial)) {
      self.isassassindemo = 1;
      self.assassinmustleave = 1;
    }

    return 1;
  }

  return 0;
}

activate_assassin_special_in_time(var_0) {
  common_scripts\utility::_id_379C("zmb_assassin_is_alarmed");
  wait(var_0);
  self.assassin_special_wait = 0;
}

run_alarm_funcs() {
  wait 0.125;

  if(!isDefined(self.aggrofuncsoverride)) {
    self.aggrofuncs = spawnStruct();
    self.aggrofuncs._id_3F11 = [];
    self.aggrofuncs._id_3F11[self.aggrofuncs._id_3F11.size] = ::assassin_recieved_damage;
    self.aggrofuncs._id_3F11[self.aggrofuncs._id_3F11.size] = ::players_are_too_close;
    self.aggrofuncs._id_3F11[self.aggrofuncs._id_3F11.size] = ::assassin_ambush_has_timed_out;
    self.aggrofuncs._id_3F11[self.aggrofuncs._id_3F11.size] = ::assassin_wakeup_by_gunshot;
    self.aggrofuncs._id_3F11[self.aggrofuncs._id_3F11.size] = ::there_is_no_fog;
  } else
    self.aggrofuncs = self.aggrofuncsoverride;

  childthread alarm_assassin_on(self.aggrofuncs._id_3F11);
}

assassin_begin_melee() {
  if(maps\mp\agents\_scripted_agent_anim_util::_id_57E2() || common_scripts\utility::_id_562E(self.assassinragecooldown)) {
    return 0;
  }

  self endon("death");

  if(common_scripts\utility::_id_3794("ready_to_attack") && isDefined(self._id_28D2) && isPlayer(self._id_28D2) && is_in_strike_range()) {
    self.start_sprint_override = undefined;

    if(!_id_0547::has_scripted_state_queued("attack_sprint")) {
      thread _id_0547::_id_7D1A("attack_sprint");
    }

    return 1;
  } else
    return 0;
}

is_in_strike_range() {
  return distance(self.origin, self._id_28D2.origin) < 170 && distance(self.origin, self._id_28D2.origin) > 140 && maps\mp\_utility::_id_3B8E(self, self._id_28D2, 60);
}

timeout_attack() {
  wait 1;
  self notify("timeout");
}

all_players_ignored() {
  if(isDefined(self._id_000A) && self._id_000A == level._id_746E) {
    return 1;
  }

  if(!_id_053C::humanoid_has_valid_targets()) {
    self.assassinmuststopattackingandleave = 1;
    return 1;
  } else
    return 0;
}

prowl_timeout_func(var_0) {
  if(!_id_0547::_id_5565(self._id_0BA4, "traverse")) {
    self.prowl_timer = self.prowl_timer - var_0;
  }

  self.readytosprint = 0;

  if(common_scripts\utility::_id_562E(self.isassassindemo)) {
    return 1;
  }

  return self.prowl_timer <= 0;
}

assassin_begin_ambush() {
  self endon("death");

  if(common_scripts\utility::_id_562E(self.optionaldisablecrouchedambush)) {
    return 1;
  }

  self.ambush_scripted_state = "walk_2_crouch";
  _id_0547::_id_7D1A(self.ambush_scripted_state);
  return 1;
}

assassin_continue_ambush() {
  if(common_scripts\utility::_id_562E(self.optionaldisablecrouchedambush)) {
    return 1;
  }

  self.ambush_scripted_state = get_action_for_assassin("Phase 2: IDLE", "idle_stalk_player");
  childthread loop_crouch_position(self.ambush_scripted_state);
  common_scripts\utility::_id_379C("zmb_assassin_is_alarmed");
  return 1;
}

assassin_ready_attack(var_0) {
  self endon("death");
  self endon("ready_to_attack");

  if(isDefined(var_0)) {
    wait(var_0);
  }

  common_scripts\utility::_id_379A("ready_to_attack");
}

assassin_execute_ambush() {
  self endon("death");

  if(!common_scripts\utility::_id_562E(self.readytosprint) && !common_scripts\utility::_id_562E(self.isassassindemo)) {
    self.readytosprint = 1;
  }

  self.assassin_should_execute_voulnerability = "walk_to_sprint_asn";

  if(common_scripts\utility::_id_3794("Assassin did go idle")) {
    if(should_assassin_lounge()) {
      self.assassin_should_execute_voulnerability = "idle_to_atk_asn";
    } else {
      self.assassin_should_execute_voulnerability = "idle_to_vul_asn";
    }
  }

  if(should_move_main()) {
    move_main();
  }

  if(isDefined(self.ambush_scripted_state)) {
    preform_assassin_crouch_interrupt(self.ambush_scripted_state);
  }

  assassin_ready_attack();
  thread run_asssassin_active_timer();
  return 1;
}

should_move_main() {
  if(common_scripts\utility::_id_562E(self.noflurry)) {
    return 0;
  }

  var_0 = self getnegotiationstartnode();

  if(isDefined(var_0)) {
    var_1 = var_0.origin;
  } else {
    var_1 = self getpathgoalpos();
  }

  return isDefined(var_1);
}

run_asssassin_active_timer() {
  self endon("death");
  self notify("new_timer");
  self endon("new_timer");

  if(!isDefined(self.assassinleveltimer)) {
    self.assassinleveltimer = 0;
  }

  for(;;) {
    self.assassinleveltimer = self.assassinleveltimer + 1;
    wait 1;
  }
}

loop_crouch_position(var_0) {
  self endon("zmb_assassin_is_alarmed");

  for(;;) {
    _id_0547::_id_7D1A(var_0);
  }
}

get_action_for_assassin(var_0, var_1) {
  if(!isDefined(self.optionalassassinactionoverrides)) {
    return var_1;
  }

  foreach(var_3 in self.optionalassassinactionoverrides) {
    if(_id_0547::_id_5565(var_3.phase_flag, var_0)) {
      return var_3.override_action;
    }
  }

  return var_1;
}

assassin_continue_attack() {
  self endon("death");

  if(common_scripts\utility::_id_562E(self.isassassindemo)) {
    self.assassinmustleave = 1;
    return 1;
  }

  if(common_scripts\utility::_id_562E(self.assassinmuststopattackingandleave)) {
    self.assassinmustleave = 1;
    return 1;
  }

  if(!isDefined(self.assassinattacktimeout)) {
    childthread assassin_attack_timeout();
  }

  return self.assassinattacktimeout > 17.5 || all_players_ignored();
}

assassin_revert_to_phase_3() {
  if(maps\mp\mp_zombie_island::agent_is_in_secret_room(1)) {
    reset_assassin_intrests();
    self.assassinleveltimer = 0;
    return 1;
  }

  if(!common_scripts\utility::_id_562E(self.readytosprint)) {
    self.readytosprint = 1;
  }

  self.assassinattacktimeout = undefined;
  self.has_exited = 1;
  init_assassin_phase_revert();
  var_0 = get_should_revert_to_previous_phase();

  if(common_scripts\utility::_id_562E(var_0)) {
    reset_assassin_intrests();
    self.assassinleveltimer = 0;
    return 1;
  }

  return var_0;
}

get_should_revert_to_previous_phase() {
  self endon("death");
  self.previoushole = self._id_1928;

  if(has_exits_disabled()) {
    return 1;
  }

  if(maps\mp\mp_zombie_island::agent_is_in_secret_room()) {
    return 1;
  }

  if(is_close_enough_to_exit()) {
    if(common_scripts\utility::_id_3794("assassin_was_koed") || is_sunlight_exposed() || common_scripts\utility::_id_562E(self.isassassindemo) || common_scripts\utility::_id_562E(self.isfirstlethalassassin)) {
      maps\mp\zombies\zombie_assassin_spawner_logic::set_assassin_removed_from_game();
    } else {
      maps\mp\zombies\zombie_assassin_spawner_logic::set_new_assassin_origin(self._id_1928);
    }

    return 1;
  }

  if(must_leave_by_exit()) {
    return 0;
  } else if(assassin_leave_has_timed_out()) {
    return 1;
  } else {
    return 0;
  }
}

assassin_attack_timeout() {
  self notify("new_attack_timeout");
  self endon("new_attack_timeout");
  self.assassinattacktimeout = 0;

  while(isDefined(self.assassinattacktimeout)) {
    self.assassinattacktimeout++;
    wait 1;
  }
}

init_assassin_phase_revert() {
  self endon("death");
  self.readytosprint = 1;
  childthread seek_assassin_level_exit();

  if(!isDefined(self.leavetimer)) {
    thread timeout_assassin_leave();
  }
}

assassin_leave_has_timed_out() {
  return isDefined(self.leavetimer) && self.leavetimer > 7 && !_id_0547::_id_5565(self._id_0BA4, "traverse");
}

player_presence_blocked_exit() {
  return self.leavetimer >= 4.55 && !assassin_is_far_from_players() && !_id_0547::_id_5565(self._id_0BA4, "traverse");
}

is_sunlight_exposed() {
  return common_scripts\utility::_id_3794("zmb_assassin_fish_out_of_water");
}

has_exits_disabled() {
  return common_scripts\utility::_id_562E(self.optionaldisableexits);
}

blocked_from_melee_lunge() {
  return common_scripts\utility::_id_562E(self.melee_cooldown);
}

is_close_enough_to_exit() {
  return isDefined(self._id_1928) && distance(self.origin, self._id_1928.origin) < 96;
}

must_leave_by_exit() {
  return common_scripts\utility::_id_562E(self.assassinmustleave) || common_scripts\utility::_id_562E(self.assassinmuststopattackingandleave);
}

assassin_is_far_from_players() {
  if(self.leavetimer >= 3.5) {
    foreach(var_1 in level.players) {
      if(distance(self.origin, var_1.origin) < 512) {
        return 0;
      }
    }
  }

  return 1;
}

timeout_assassin_leave() {
  self notify("new_timeout");
  self endon("new_timeout");
  self endon("death");
  self.leavetimer = 0;

  while(isDefined(self.leavetimer)) {
    self.leavetimer = self.leavetimer + 0.1;
    wait 0.1;
  }
}

reset_assassin_intrests() {
  self.prowl_timer = 4.75;
  self._id_1928 = undefined;
  self.assassin_attack_enable = 0;
  self.leavetimer = undefined;
  self.looking_for_exit = undefined;
  self.assassinmuststopattackingandleave = undefined;
  self.my_ignore_players_list = [];
}

seek_assassin_level_exit() {
  self endon("death");

  if(isDefined(self._id_1928)) {
    return;
  }
  self._id_1928 = maps\mp\zombies\zombie_assassin_spawner_logic::seek_exit_that_maintains_momentum();

  while(!isDefined(self._id_1928)) {
    self._id_1928 = maps\mp\zombies\zombie_assassin_spawner_logic::seek_exit_that_maintains_momentum();
    waitframe();
  }

  self._id_1928 thread maps\mp\zombies\zombie_assassin_spawner_logic::assassin_spawn_cooldown();
}

override_turn_func() {
  waitframe();
}

ghost_through_passives() {
  for(;;) {
    var_0 = _id_0547::_id_408F();

    foreach(var_2 in var_0) {
      if(common_scripts\utility::_id_562E(self.squatting)) {
        continue;
      }
      if(var_2 == self) {
        continue;
      }
      if(distance(self.origin, var_2.origin) > 64) {
        continue;
      }
      if(_id_0547::_id_5565(var_2._id_0A4B, "zombie_assassin")) {
        continue;
      }
      var_3 = 8 * vectorNormalize(anglestoright(self.angles));
      var_4 = -8 * vectorNormalize(anglestoright(self.angles));

      if(distance(var_2.origin, self.origin + var_3) < distance(var_2.origin, self.origin + var_4)) {
        var_5 = _func_2E1(var_2.origin + var_3);
      } else {
        var_5 = _func_2E1(var_2.origin + var_4);
      }

      var_6 = 0;
      var_2 setOrigin(var_5, var_6);

      if(isDefined(var_2.bufffx)) {
        var_2 maps\mp\zombies\zombie_assassin_frontline::spawn_assassin_frontline_fx();
      }
    }

    waitframe();
  }
}

should_assassin_lounge() {
  if(isDefined(self._id_000A) && self._id_000A == level._id_746E) {
    return 0;
  }

  foreach(var_1 in level.players) {
    if(!isalive(var_1) || common_scripts\utility::_id_562E(var_1._id_5728)) {
      continue;
    }
    if(maps\mp\_utility::_id_3B8E(self, var_1, 35) && distance(self.origin, var_1.origin) < 250) {
      return 1;
    }
  }

  return 0;
}

set_assassin_phase(var_0) {
  foreach(var_2 in self.phases) {
    common_scripts\utility::_id_3796(var_2.name);
  }

  common_scripts\utility::_id_379A(var_0);
}

get_assassin_phase() {
  foreach(var_1 in self.phases) {
    if(common_scripts\utility::_id_3794(var_1.name)) {
      return var_1.name;
    }
  }
}

wait_for_close_player(var_0, var_1) {
  self endon("death");
  self endon("zmb_assassin_is_alarmed");
  var_2 = 0;
  var_3 = 0;

  while(!var_3) {
    if(!assassin_has_valid_target()) {
      return undefined;
    }

    foreach(var_5 in level.players) {
      if(distance(var_5.origin, self.origin) < var_0) {
        return var_5;
      }
    }

    var_2 = var_2 + 0.125;

    if(isDefined(var_1)) {
      if(var_2 >= var_1) {
        return;
      }
    }

    wait 0.125;
  }
}

there_is_close_player(var_0) {
  if(!assassin_has_valid_target()) {
    return 0;
  }

  foreach(var_2 in level.players) {
    if(distance(var_2.origin, self.origin) < var_0) {
      return 1;
    }
  }

  return 0;
}

initalize_assassin_despawners() {
  var_0 = common_scripts\utility::_id_46B7("assassin_despawners", "targetname");

  foreach(var_2 in var_0) {
    var_3 = common_scripts\utility::_id_46B7(var_2.target, "targetname");

    foreach(var_5 in var_3) {
      var_5.getnegotiationnextnode = var_2.getnegotiationnextnode;
    }
  }
}

get_all_special_assassins() {
  var_0 = ["zombie_assassin_frontline", "zombie_assassin_freefire", "zombie_assassin_shellshock", "zombie_assassin_camoflauge"];
  return var_0;
}

zombie_assassin_move_mode_func() {
  if(!common_scripts\utility::_id_562E(self.nochill) && common_scripts\utility::_id_562E(self.assassinragecooldown) && !common_scripts\utility::_id_3794("Phase 4: EXITING") && !common_scripts\utility::_id_562E(self.assassinmustleave) && !common_scripts\utility::_id_562E(self.assassinmuststopattackingandleave)) {
    return "walk";
  }

  if(common_scripts\utility::_id_562E(self.bossintroassassin)) {
    return "walk";
  }

  if(!common_scripts\utility::_id_562E(self.readytosprint) || common_scripts\utility::_id_562E(self.isassassindemo) && !common_scripts\utility::_id_562E(self.isassassindemocansprint)) {
    return "walk";
  }

  return "sprint";
}

init_my_phase_flags() {
  foreach(var_1 in level.zmb_asn_agent_phases) {
    common_scripts\utility::_id_3799(var_1.name);
  }
}

is_boss_assassin() {
  return isDefined(self.assassin_modifier) && !_id_0547::_id_5565(self.assassin_modifier, "zombie_assassin");
}

_id_9A01(var_0) {
  self endon("assassin_has_meleed_players");
  wait(var_0);
  common_scripts\utility::_id_379A("assassin_has_meleed_players");
}

start_assassin_taunt() {
  self endon("death");
  self endon("stop_assassin_vocals");

  while(isDefined(self)) {
    var_0 = common_scripts\utility::random(level.players);
    var_1 = randomint(256) - 128;
    var_2 = randomint(256) - 128;
    var_3 = randomint(256) - 128;
    var_4 = var_0.origin + (var_1, var_2, var_3);
    self.alarm = _id_0380::_id_6842("zmb_movie_projector", undefined, var_0.origin);
    wait 0.4;
    self.alarm _meth_863F(3.75);
    wait 4;
  }
}

handle_character_sighting_vo() {}

play_my_assassin_id_fx(var_0) {
  while(self.model == "tag_origin") {
    waitframe();
  }

  var_1 = get_my_assassin_fx();

  if(isDefined(var_1)) {
    self.mod_fx_id = get_my_assassin_fx() + var_0;
    attach_assassin_mod_fx();
  }
}

attach_assassin_mod_fx() {
  remove_assassin_boss_vfx();

  if(!isDefined(self.mod_fx_id)) {
    return;
  }
  self.mod_fx = play_fx_on_zmb_assassin(self.mod_fx_id, "J_Spine4");
}

get_my_assassin_fx() {
  var_0 = undefined;

  if(!isDefined(self.assassin_modifier)) {
    return var_0;
  }

  switch (self.assassin_modifier) {
    case "zombie_assassin_frontline":
      var_0 = "zmb_assassin_light_frontline_";
      break;
    case "zombie_assassin_freefire":
      var_0 = "zmb_assassin_light_freefire_";
      break;
    case "zombie_assassin_shellshock":
      var_0 = "zmb_assassin_light_shellshock_";
      break;
    case "zombie_assassin_camoflauge":
      var_0 = "zmb_assassin_light_camoflauge_";
      break;
    case "zombie_assassin_hc":
      break;
  }

  return var_0;
}

assassin_has_valid_target() {
  var_0 = _id_053C::_id_4F88();
  var_1 = var_0.size > 0 || isDefined(self._id_3043) || isDefined(self._id_1927) || isDefined(self._id_9B61);
  return var_1;
}

alarm_assassin_on(var_0) {
  self endon("death");
  self endon("zmb_assassin_is_alarmed");

  foreach(var_2 in var_0) {
    childthread assassin_alarm_listener(var_2, "zmb_assassin_is_alarmed");
  }
}

assassin_alarm_listener(var_0, var_1) {
  var_2 = self[[var_0]]();
  self.isassassindemocansprint = 1;
  level notify("assassin_woken", self.origin);
  common_scripts\utility::_id_379A(var_1);
}

assassin_is_in_daylight() {
  return !assassin_is_in_fog();
}

assassin_is_in_fog() {
  return maps\mp\mp_zombie_island_ee_fog_manager::get_is_fog_active();
}

there_is_no_fog() {
  wait 1;

  while(assassin_is_in_fog()) {
    wait 0.125;
  }

  return "Assassin Alarmed! FOG RECEDED!";
}

assassin_recieved_damage() {
  self waittill("damage");
  return "Assassin Alarmed! ASSASSIN TOOK DAMAGE!";
}

players_have_left() {
  while(!_id_055A::_id_586A("isolated_room_zone") || maps\mp\zombies\zombie_assassin_spawner_logic::everyone_in_pommel_room(1)) {
    waitframe();
  }

  return "players left room!";
}

players_are_too_close() {
  var_0 = undefined;

  while(!isDefined(var_0) || distance(self.origin, var_0.origin) > 235) {
    if(isDefined(level.players) && level.players.size > 0) {
      var_0 = common_scripts\utility::_id_4461(self.origin, level.players);
    }

    waitframe();
  }

  return "Assassin Alarmed! PLAYERS TOO CLOSE";
}

assassin_ambush_has_timed_out() {
  wait 34;
  return "Assassin Alarmed! PLAYERS TOOK TO LONG TO ALARM";
}

assassin_wakeup_by_gunshot() {
  self waittill("assassin_gunshot_wakup");
  return "Assassin Alarmed! NEARBY GUNSHOT";
}

assassin_alarm_chain() {
  for(;;) {
    level waittill("assassin_woken", var_0);

    if(distance(self.origin, var_0) < 512) {
      break;
    }
  }
}

assassin_notify_gunshot() {
  self notify("assassin_gunshot_wakup");
}

recharge_special_ability(var_0) {
  self endon("death");
  self.specialoverheated = 1;
  wait(var_0 * 0.8);

  if(!common_scripts\utility::_id_562E(self.reverse_assassin_specials_visuals) && !common_scripts\utility::_id_562E(self.is_being_asked_to_leave_soon)) {
    enable_assassin_chest_fx();
  }

  wait(var_0 * 0.2);

  while(common_scripts\utility::_id_562E(self.is_being_asked_to_leave_soon)) {
    disable_assassin_chest_fx();
    waitframe();
  }

  self.specialoverheated = 0;
}

do_assassin_attack_anim() {
  self endon("death");
  set_assassin_state_scripted();
  play_assassin_anim("assassin_activate_attack");
  unset_assassin_state_scripted();
}

phase_handler(var_0) {
  var_1 = assassin_has_excuse_to_skip(var_0);

  if(!var_1) {
    foreach(var_3 in var_0.reasons_to_block_progress) {
      if(self[[var_3._id_3F02]]() == var_3.value) {
        return;
      }
    }

    var_1 = common_scripts\utility::makeentitysentient(var_0.func_and_data);
  }

  if(var_1) {
    set_assassin_phase(var_0.next_phase);
  }
}

assassin_has_excuse_to_skip(var_0) {
  if(!isDefined(var_0.reasons_to_skip)) {
    return 0;
  }

  foreach(var_2 in var_0.reasons_to_skip) {
    if(common_scripts\utility::_id_3794(var_2)) {
      return 1;
    }
  }

  return 0;
}

assassin_strike_near_players(var_0, var_1) {
  if(!isPlayer(var_0)) {
    return var_1;
  }

  if(distance(self.origin, var_0.origin) > 800) {
    return var_1;
  }

  var_2 = self.attackpointoffset * vectorNormalize(anglesToForward(var_0 _meth_8566()));
  var_3 = var_2 + self.attackpointoffset * vectorNormalize(anglestoright(var_0 _meth_8566()));
  var_4 = _func_2E1(var_0.origin + var_3, self);
  var_5 = var_2 + self.attackpointoffset * vectorNormalize(anglestoright(var_0 _meth_8566() + (0, 180, 0)));
  var_6 = _func_2E1(var_0.origin + var_5, self);

  if(self.assassin_melee_side > 0) {
    return var_6;
  } else {
    return var_4;
  }
}

is_an_elite_assassin() {
  return !_id_0547::_id_5565(self.assassin_modifier, "zombie_assassin");
}

report_damage(var_0, var_1) {
  var_0 waittill("damage");
  level notify(var_1);
}

init_assassin_vo_flags() {
  common_scripts\utility::flag_init("special_assassin_sighting");
  level.asn_dmg_flags = [];
  level.asn_dmg_flags["zombie_assassin"] = "zombie_assassinasn_damaged";
  level.asn_dmg_flags["zombie_assassin_frontline"] = "zombie_assassin_frontlineasn_damaged";
  level.asn_dmg_flags["zombie_assassin_freefire"] = "zombie_assassin_freefireasn_damaged";
  level.asn_dmg_flags["zombie_assassin_shellshock"] = "zombie_assassin_shellshockasn_damaged";
  level.asn_dmg_flags["zombie_assassin_camoflauge"] = "zombie_assassin_camoflaugeasn_damaged";

  foreach(var_1 in level.asn_dmg_flags) {
    common_scripts\utility::flag_init(var_1);
  }
}

zombie_assassin_on_damaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(common_scripts\utility::_id_3794("assassin_was_koed")) {
    return;
  }
  if(isDefined(self.on_damage_override)) {
    [[self.on_damage_override]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    return;
  }

  if(isDefined(self.assassin_special_damage_callback)) {
    [[self.assassin_special_damage_callback]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  }

  if(var_8 == "head" && var_5 != "panzerschreck_zm" && !issubstr(var_5, "fliegerfaust") && !issubstr(var_5, "tesla") && var_5 != "raven_sword_zm") {
    var_2 = var_2 * 0.8;
  } else if(var_5 != "panzerschreck_zm" && !issubstr(var_5, "fliegerfaust") && !issubstr(var_5, "tesla") && var_5 != "raven_sword_zm") {
    var_2 = var_2 * 0.6;
  }

  if(!is_boss_assassin() && !_id_0547::_id_5565(self._id_0BA4, "traverse") && (common_scripts\utility::_id_3794("Phase 3: ATTACK") || common_scripts\utility::_id_3794("Phase 2: EXIT AMBUSH"))) {
    if(!isDefined(self.headshotthreshold)) {
      self.headshotthreshold = 0;
      thread headshot_drain();
    }

    if(!common_scripts\utility::_id_562E(self.assassin_stunned)) {
      if(_id_0547::_id_5565(var_8, "head")) {
        self.headshotthreshold = self.headshotthreshold + 2.7 * var_2;
      } else {
        self.headshotthreshold = self.headshotthreshold + var_2;
      }

      if(!isDefined(self.assassin_stunned)) {
        self.next_assassin_stun = self.maxhealth * 0.15;
      }

      if(self.headshotthreshold > self.next_assassin_stun) {
        self.headshotthreshold = 0;
        self.next_assassin_stun = self.next_assassin_stun * 1.7;
        self endon("death");

        if(isDefined(self._id_28D2) && distance(self.origin, self._id_28D2.origin) < 170 && _id_0547::_id_5565(self._id_0BA4, "move")) {
          self.overrridehitreact = "s2_zom_asn_sprint_hitreact_left";
          self.overrridehitreact = "pain_sprint_lower";
        }

        _id_0547::_id_7D1A("side_stumble_1_forward_left");
        childthread assassin_attack_cooldown(1);
        preform_assassin_ko_interrupt();
        assassin_ignore_player(var_1);
      }
    }
  }

  if(is_boss_assassin() && !common_scripts\utility::_id_562E(self.enable_final_death)) {
    if(!isDefined(self.assassin_boss_health)) {
      self.assassin_boss_health = self.maxhealth;
    }

    if(!isDefined(self._id_3794["assassin_was_koed"]) || common_scripts\utility::_id_3794("assassin_was_koed")) {
      return;
    }
    if(isDefined(var_1) && isPlayer(var_1)) {
      if(_id_0547::_id_5565(var_8, "head")) {
        var_1 thread _id_04C7::_id_A102("headshot");
      } else {
        var_1 thread _id_04C7::_id_A102("standard");
      }
    }

    self.assassin_boss_health = common_scripts\utility::_id_98E7(self.assassin_boss_health - var_2 <= 0, 0, self.assassin_boss_health - var_2);

    if(self.assassin_boss_health <= 0) {
      disable_assassin_chest_fx();
      self.activeassassinboss = 0;
      set_zombie_assassin_boss_ko();
      _id_0547::_id_7D1A("side_stumble_1_forward_left");
    }

    return;
  }

  _id_054D::_id_6BD1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

should_target_others() {
  if(level.players.size == 1) {
    if(!isDefined(self.solo_ignore_counter)) {
      self.solo_ignore_counter = 0;
    }

    if(self.solo_ignore_counter < 1) {
      self.solo_ignore_counter++;
      return 0;
    } else {
      self.solo_ignore_counter = 0;
      return 1;
    }
  }

  foreach(var_1 in level.players) {
    if(_id_0547::_id_5565(var_1, self._id_28D2)) {
      continue;
    }
    if(common_scripts\utility::_id_562E(var_1._id_5728)) {
      continue;
    }
    if(_id_0547::_id_5565(var_1.sessionstate, "spectator")) {
      continue;
    }
    if(distance(self.origin, var_1.origin) > 600) {
      continue;
    }
    return 1;
  }

  return 0;
}

zombie_assassin_tesla_delayed_dmg(var_0, var_1, var_2) {
  return var_0;
}

remove_player_from_list_in_time(var_0) {
  self endon("death");
  wait 6.5;

  if(isDefined(var_0) && isDefined(self.my_ignore_players_list)) {
    self.my_ignore_players_list = common_scripts\utility::_id_0F93(self.my_ignore_players_list, var_0);
  }
}

headshot_drain() {
  self endon("death");

  for(;;) {
    self.headshotthreshold = self.headshotthreshold - int(100 * level.players.size);

    if(self.headshotthreshold < 0) {
      self.headshotthreshold = 0;
    }

    wait 1;
  }
}

set_zombie_assassin_boss_ko() {
  self.optionalinitialstate = "Phase 4: EXITING";
  self.assassinmustleave = 1;
  self.assassinkillonexit = 1;
  common_scripts\utility::_id_379A("zmb_assassin_is_alarmed");
  common_scripts\utility::_id_379A("assassin_was_koed");
}

play_assassin_anim(var_0) {
  var_1 = var_0;
  var_2 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_1);
  var_3 = self getanimentrycount(var_2);
  var_4 = randomint(var_3);
  self scragentsetorientmode("face angle abs", self.angles);
  maps\mp\agents\_scripted_agent_anim_util::isenemyaware(var_2, var_4);
}

set_assassin_state_scripted(var_0) {
  self scragentsetanimmode("anim deltas");
  self scragentsetscripted(1);
}

unset_assassin_state_scripted() {
  self scragentsetscripted(0);
}

preform_assassin_walk_voulnerability() {
  prepare_assassin_action("walk_2_sprint", undefined, "attack_anim");
  preform_assassin_walk_voulnerability_interrupt();
}

preform_assassin_walk_voulnerability_interrupt() {
  self scragentsetscripted(0);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "walk_2_sprint");
}

preform_assassin_crouch_attack() {
  prepare_assassin_action("assassin_spawn_attack");
  preform_assassin_crouch_attack_interrupt();
}

preform_assassin_crouch_attack_interrupt() {
  self scragentsetscripted(0);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "assassin_spawn_attack");
}

preform_assassin_worship_1() {
  prepare_assassin_action("assassin_worship_1");
  preform_assassin_worship_1_interrupt();
}

preform_assassin_worship_1_interrupt() {
  preform_assassin_crouch_interrupt("assassin_worship_1");
}

preform_assassin_worship_2() {
  prepare_assassin_action("assassin_worship_2");
  preform_assassin_worship_2_interrupt();
}

preform_assassin_worship_2_interrupt() {
  preform_assassin_crouch_interrupt("assassin_worship_2");
}

preform_assassin_worship_3() {
  prepare_assassin_action("assassin_worship_3");
  preform_assassin_worship_3_interrupt();
}

preform_assassin_worship_3_interrupt() {
  preform_assassin_crouch_interrupt("assassin_worship_3");
}

preform_assassin_crouch_voulnerability() {
  prepare_assassin_action("assassin_spawn_voulnerability");
  preform_assassin_crouch_voulnerability_interrupt();
}

preform_assassin_crouch_voulnerability_interrupt() {
  self scragentsetscripted(0);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "idle_stalk_player");
}

preform_assassin_trans_to_crouch() {
  transition_to_assassin_idle();
  preform_assassin_trans_to_crouch_interrupt();
}

transition_to_assassin_idle() {
  self endon("death");
  self endon("zmb_assassin_is_alarmed");

  if(common_scripts\utility::_id_562E(self.skipped_straight_to_idle)) {
    _id_053C::_id_06CE(_func_2E1(self.origin, self));
  }

  prepare_assassin_action("walk_2_crouch", undefined, undefined);
  common_scripts\utility::_id_379A("Assassin did go idle");
}

preform_assassin_trans_to_crouch_interrupt() {
  common_scripts\utility::_id_379A("Assassin did go idle");
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "walk_2_crouch");
}

preform_assassin_crouch() {
  thread prepare_assassin_action("idle_stalk_player");
  common_scripts\utility::_id_379C("zmb_assassin_is_alarmed");
  preform_assassin_crouch_interrupt();
  return 1;
}

preform_assassin_crouch_interrupt(var_0) {
  self scragentsetscripted(0);

  if(isDefined(var_0)) {
    maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, var_0);
  } else {
    maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "idle_stalk_player");
  }
}

preform_assassin_ko() {
  self.assassin_stunned = 1;
  prepare_assassin_action("side_stumble_1_forward_left");
  preform_assassin_ko_interrupt();
}

preform_assassin_idle() {
  prepare_assassin_action("idle_noncombat");
  preform_assassin_idle_interrupt();
}

preform_assassin_idle_interrupt() {
  self scragentsetscripted(0);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "idle_noncombat");
}

preform_assassin_ko_interrupt() {
  self scragentsetscripted(0);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "side_stumble_1_forward_left");
  self.assassin_stunned = 0;
}

preform_assassin_ability() {
  prepare_assassin_action(self.assassinabilityactivateaction, self.assassinabilityactivateactionnotetrackhandler);
  preform_assassin_ability_interrupt();
}

preform_assassin_ability_interrupt() {
  self.hasassassinspecialed = 1;
  self scragentsetscripted(0);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, self.assassinabilityactivateaction);
}

preform_assassin_strike() {
  prepare_assassin_action("attack_sprint");
  preform_assassin_strike_interrupt();
}

preform_assassin_strike_interrupt() {
  self scragentsetscripted(0);
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "attack_sprint");
}

prepare_assassin_action(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = "scripted_anim";
  }

  if(isDefined(self.overrridehitreact)) {
    var_0 = self.overrridehitreact;
    self.overrridehitreact = undefined;
  }

  self scragentsetscripted(1);
  self._id_01BB = 1;
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, var_0);
  var_3 = maps\mp\agents\_scripted_agent_anim_util::_id_434D(var_0);
  var_4 = self getanimentrycount(var_3);
  var_5 = randomint(var_4);

  if(!isDefined(self.forcedtarget) && isDefined(self.player_facing_times) && isDefined(self.player_facing_times[var_0])) {
    thread handle_facing_player(self.player_facing_times[var_0]);
  } else {
    self scragentsetorientmode("face angle abs", self.angles);
  }

  self scragentsetanimmode("anim deltas");

  if(isDefined(self.additional_anim) && self.additional_anim[1] == var_0) {
    [[self.additional_anim[0]]]();
    self.additional_anim = undefined;
  }

  maps\mp\agents\_scripted_agent_anim_util::_id_71FA(var_3, var_5, 1.0, var_2, undefined, var_1);
}

handle_facing_player(var_0) {
  self scragentsetorientmode("face enemy");
  wait(var_0);
  self scragentsetorientmode("face angle abs", self.angles);
}

play_fx_on_zmb_assassin(var_0, var_1) {
  var_2 = _spawnlinkedfx(common_scripts\utility::_id_44F5(var_0), self, var_1);
  maps\mp\agents\_agent_utility::deleteentonagentdeath(var_2);
  _triggerfx(var_2);
  return var_2;
}

init_assassin_vfx() {
  common_scripts\utility::_id_092C("zmi_assassin_armor_1", "vfx/zombie/prototype_fx/zmi_assassin_armor_1");
  common_scripts\utility::_id_092C("zmi_assassin_teleport", "vfx/zombie/prototype_fx/assassin/teleport");
  common_scripts\utility::_id_092C("zmi_assassin_buff", "vfx/zombie/prototype_fx/assassin/zmb_buff");
  common_scripts\utility::_id_092C("zmi_assassin_critical_hit", "vfx/zombie/prototype_fx/assassin/critical_hit");
  common_scripts\utility::_id_092C("zmb_assassin_light_frontline", "vfx/zombie/prototype_fx/assassin/light_frontline");
  common_scripts\utility::_id_092C("zmb_assassin_light_freefire", "vfx/zombie/prototype_fx/assassin/light_freefire");
  common_scripts\utility::_id_092C("zmb_assassin_light_shellshock", "vfx/zombie/prototype_fx/assassin/light_shellshock");
  common_scripts\utility::_id_092C("zmb_assassin_light_camoflauge", "vfx/zombie/prototype_fx/assassin/light_camoflauge");
}

init_scripted_states() {
  var_0 = 3.75;
  var_1 = 4;
  _id_0547::_id_7BD0("walk_2_crouch", ::preform_assassin_trans_to_crouch, ::preform_assassin_trans_to_crouch_interrupt, 3.75 + _func_2CA(var_0, var_1, 0.04));
  _id_0547::_id_7BD0("idle_stalk_player", ::preform_assassin_crouch, ::preform_assassin_crouch_interrupt, 3.75 + _func_2CA(var_0, var_1, 0.04));
  _id_0547::_id_7BD0("assassin_worship_1", ::preform_assassin_worship_1, ::preform_assassin_worship_1_interrupt, 3.75 + _func_2CA(var_0, var_1, 0.04));
  _id_0547::_id_7BD0("assassin_worship_2", ::preform_assassin_worship_2, ::preform_assassin_worship_2_interrupt, 3.75 + _func_2CA(var_0, var_1, 0.04));
  _id_0547::_id_7BD0("assassin_worship_3", ::preform_assassin_worship_3, ::preform_assassin_worship_3_interrupt, 3.75 + _func_2CA(var_0, var_1, 0.04));
  _id_0547::_id_7BD0("assassin_spawn_voulnerability", ::preform_assassin_crouch_voulnerability, ::preform_assassin_crouch_voulnerability_interrupt, 3.75 + _func_2CA(var_0, var_1, 0.08));
  _id_0547::_id_7BD0("assassin_spawn_attack", ::preform_assassin_crouch_attack, ::preform_assassin_crouch_attack_interrupt, 3.75 + _func_2CA(var_0, var_1, 0.08));
  _id_0547::_id_7BD0("walk_2_sprint", ::preform_assassin_walk_voulnerability, ::preform_assassin_walk_voulnerability_interrupt, 3.75 + _func_2CA(var_0, var_1, 0.08));
  _id_0547::_id_7BD0("activate_assassin_ability", ::preform_assassin_ability, ::preform_assassin_ability_interrupt, 3.75 + _func_2CA(var_0, var_1, 0.16));
  _id_0547::_id_7BD0("side_stumble_1_forward_left", ::preform_assassin_ko, ::preform_assassin_ko_interrupt, 3.75 + _func_2CA(var_0, var_1, 0.2));
  _id_0547::_id_7BD0("attack_sprint", ::zombie_assassin_charge_run, undefined, 3.75 + _func_2CA(var_0, var_1, 0.12), ::zombie_assassin_charge_cleanup);
  _id_0547::_id_7BD0("idle_noncombat", ::preform_assassin_idle, ::preform_assassin_idle_interrupt, 3.75 + _func_2CA(var_0, var_1, 0.24));
}

zombie_assassin_charge_run() {
  self endon("stop assassin strike");
  self endon("death");
  var_0 = self._id_28D2;
  var_1 = self.origin;
  self scragentsetscripted(1);
  self._id_01BB = 1;
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(1, "attack_sprint");
  common_scripts\utility::_id_3796("ready_to_attack");
  var_2 = 1;
  var_3 = undefined;
  var_4 = 0;
  childthread dodamageonjoints(["J_poker2_RI", "J_poker2_LE"], 30, 1);
  maps\mp\agents\humanoid\_humanoid_melee::_id_3107(var_0, var_0.origin, "attack_run_asn", 0, 0, 1.0, var_4, undefined);
  maps\mp\agents\humanoid\_humanoid_move::_id_86CF("sprint");
}

assassin_ignore_player(var_0) {
  if(!should_target_others()) {
    return;
  }
  if(common_scripts\utility::_id_0F79(self.my_ignore_players_list, var_0)) {
    return;
  }
  self.my_ignore_players_list = common_scripts\utility::_id_0F6F(self.my_ignore_players_list, var_0);
  thread remove_player_from_list_in_time(var_0);
}

dodamageonjoints(var_0, var_1, var_2) {
  self notify("new_joint_strike");
  self endon("new_joint_strike");
  self endon("stop_joint_strike");
  var_3 = [];
  wait 0.15;

  for(;;) {
    waitframe();

    foreach(var_5 in var_0) {
      var_6 = get_final_joint_origin(var_5);

      foreach(var_8 in level.players) {
        var_9 = _distance2d(var_8.origin, var_6);
        var_10 = _abs(var_8.origin[2] - var_6[2]);

        if(!common_scripts\utility::_id_0F79(var_3, var_8) && var_9 < var_1 && var_10 < 230) {
          if(common_scripts\utility::_id_562E(var_2) && randomint(100) > 30) {
            thread assassin_attack_cooldown();
          }

          var_3 = common_scripts\utility::_id_0F6F(var_3, var_8);
          var_8 dodamage(90, var_6, self, self, "MOD_IMPACT");
          assassin_ignore_player(var_8);
        }
      }
    }
  }
}

get_final_joint_origin(var_0) {
  return self gettagorigin(var_0) + 42 * vectorNormalize(anglesToForward(self gettagangles(var_0)));
}

zombie_assassin_charge_cleanup() {
  self scragentsetscripted(0);
  self _meth_85E0(0);
  self scragentsetphysicsmode("gravity");
  maps\mp\agents\_scripted_agent_anim_util::_id_8732(0, "attack_sprint");
  thread assassin_ready_attack(2.5);
  self notify("stop assassin strike");
}

zombie_assassin_spawn_voulnerability_cleanup() {
  self scragentsetscripted(0);
  self _meth_85E0(0);
  self scragentsetphysicsmode("gravity");
}

init_assassin_spawns_and_exits() {
  var_0 = common_scripts\utility::_id_46B7("zmb_assassin_spawnpoint", "targetname");

  foreach(var_2 in var_0) {
    var_2 thread maps\mp\zombies\zombie_assassin_spawner_logic::wait_for_activation();
  }

  initalize_assassin_despawners();
}