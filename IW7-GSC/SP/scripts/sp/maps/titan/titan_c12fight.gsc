/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\titan\titan_c12fight.gsc
****************************************************/

main() {
  scripts\engine\utility::flag_init("c12fight_apc_switchnode");
  scripts\engine\utility::flag_init("c12_fight_transition");
  scripts\engine\utility::flag_init("arena_ally_advance_1");
  scripts\engine\utility::flag_init("c12_left_arm_destroyed");
  scripts\engine\utility::flag_init("c12_right_arm_destroyed");
  scripts\engine\utility::flag_init("c12_left_leg_destroyed");
  scripts\engine\utility::flag_init("c12_right_leg_destroyed");
  precacheitem("defaultweapon");
  precachemodel("robot_c12");
  _id_350C();
  vehicle_anims();
  _id_6749();
  _id_3CBD();
  thread _id_663A();
  thread _id_6636();
}

#using_animtree("c12");

_id_350C() {
  level._id_EC87["c12_ally"] = #animtree;
  level._id_EC87["c12_enemy"] = #animtree;
  scripts\sp\anim::_id_17F6("c12_enemy", "pipe_collide", ::_id_5D32);
  level._id_EC85["c12_enemy"]["c12fight_dropoff"] = % titan_c12_fight_enemyc12_dropoff;
  level._id_EC85["c12_ally"]["c12fight_charge"] = % titan_c12_fight_alliedc12_event01;
  level._id_EC85["c12_ally"]["c12fight_charge_loop"][0] = % titan_c12_fight_alliedc12_event01_idle;
  scripts\sp\anim::_id_17FF("c12_enemy", "collide", "c12fight_charge", "c12fight_charge_impact", undefined, "j_spineupper");
  scripts\sp\anim::_id_17F6("c12_enemy", "wall_impact", ::_id_3CCF);
  scripts\sp\anim::_id_17F6("c12_enemy", "wall_impact2", ::_id_3CD0);
  level._id_EC85["c12_enemy"]["c12fight_charge"] = % titan_c12_fight_enemyc12_event01;
  level._id_EC85["c12_ally"]["c12_revive"] = % titan_c12_fight_alliedc12_event01_getup;
  scripts\sp\anim::_id_17FF("c12_enemy", "collide", "c12fight_apc", "c12fight_charge_impact", undefined, "j_spineupper");
  scripts\sp\anim::_id_17F6("c12_enemy", "fire_rocket", ::_id_3570);
  level._id_EC85["c12_enemy"]["c12fight_apc"] = % titan_c12_fight_enemyc12_event02;
  level._id_EC85["c12_ally"]["c12fight_drill"] = % titan_c12_fight_alliedc12_event03;
  level._id_EC85["c12_enemy"]["c12fight_drill"] = % titan_c12_fight_enemyc12_event03;
}

#using_animtree("vehicles");

vehicle_anims() {
  var_0 = "tag_flash";
  level._id_EC87["apc"] = #animtree;
  level._id_EC87["dropship"] = #animtree;
  level._id_EC8C["apc"] = "veh_mil_lnd_un_apc";
  level._id_EC8C["dropship"] = "veh_mil_air_un_dropship_hero";
  scripts\sp\anim::_id_17F6("apc", "die", ::_id_207E);
  level._id_EC85["apc"]["c12fight_apc"] = % titan_c12_fight_apc_event02;
  level._id_EC85["apc"]["c12fight_apc_exit"] = % titan_c12_fight_apc_event03_exit;
  level._id_EC85["dropship"]["c12fight_dropoff"] = % titan_c12_fight_dropship_dropoff;
}

#using_animtree("generic_human");

_id_6749() {
  level._id_EC87["eth3n"] = #animtree;
}

_id_3561(var_0) {
  if(isDefined(level._id_355D)) {
    return;
  }
  scripts\engine\utility::flag_init("c12fight_dropoff");
  scripts\engine\utility::flag_init("c12fight_dropoff_start");
  scripts\engine\utility::flag_init("c12fight_charge_start");
  scripts\engine\utility::flag_init("c12fight_charge_done");
  scripts\engine\utility::flag_init("c12fight_volley");
  scripts\engine\utility::flag_init("c12fight_volley_ally");
  scripts\engine\utility::flag_init("c12fight_volley_done");
  scripts\engine\utility::flag_init("c12fight_apc_start");
  scripts\engine\utility::flag_init("c12fight_apc_ready");
  scripts\engine\utility::flag_init("c12fight_apc_anim");
  scripts\engine\utility::flag_init("c12_ally_revive");
  scripts\engine\utility::flag_init("c12_revive_dialogue_done");
  scripts\engine\utility::flag_init("c12_fight_done");
  scripts\engine\utility::flag_init("c12_fight_ai_cleansed");
  level._id_355D = spawnStruct();
  var_1 = _id_F987();
  var_2 = scripts\sp\utility::_id_107EA("c12enemy_spawner", 1);
  var_2._id_11B06 = 1;
  var_2.onlytakedamagefromplayer = 1;
  var_2 _id_354F(0);
  playFXOnTag(scripts\engine\utility::getfx("c12_light_red_small_a"), var_2, "j_cambody");
  var_2._id_1FBB = "c12_enemy";
  var_1._id_1FBB = "c12_ally";
  createthreatbiasgroup("enemy_c12");
  var_2 setthreatbiasgroup("enemy_c12");
  createthreatbiasgroup("ally_c12");
  var_1 setthreatbiasgroup("ally_c12");
  setthreatbias("enemy_c12", "ally_c12", 2000);
  setthreatbias("ally_c12", "enemy_c12", 2000);
  level._id_355D._id_3659["enemy"] = var_2;
  level._id_355D._id_3659["ally"] = var_1;

  if(isDefined(level._id_2052))
    var_3 = level._id_2052;
  else {
    var_4 = getEnt("apc_spawner", "targetname");
    var_4.script_team = "allies";
    var_3 = var_4 scripts\sp\utility::_id_10808();
    var_3._id_1FBB = "apc";
    var_3 scripts\sp\vehicle::_id_8441();
    var_3.target = "c12fight_apc_path";
    var_3 scripts\sp\vehicle_paths::_id_8023();
    var_3 thread scripts\sp\vehicle_paths::_id_845A();
  }

  level._id_355D._id_2054 = var_3;
  level._id_355D._id_2054 thread _id_2060();
  level._id_355D.spawners = getEntArray("c12fight_enemy_spawners", "targetname");

  if(isDefined(var_0)) {
    return;
  }
  level._id_355D._id_6434 = 0;
  level thread _id_6436();
  thread _id_3567();
  var_5 = scripts\sp\utility::_id_79C8("allies", "r");
  scripts\engine\utility::array_thread(var_5, scripts\sp\utility::_id_E198);
  thread _id_7275();
  var_6 = spawnStruct();
  var_6._id_3508 = _id_7888("enemy");
  _id_0A05::_id_35A8(getEntArray("c12fight_lockon_pickup", "targetname"), var_6, &"hud_interaction_prompt_center_heavy", "c12_dialogue_ended");
  level._id_2429 thread _id_970F();
}

_id_B957() {
  self endon("death");
  var_0 = self _meth_850C("torso", "upper");
  var_1 = self _meth_850C("torso", "lower");

  for(;;) {
    var_2 = self _meth_850C("torso", "upper");
    var_3 = self _meth_850C("torso", "lower");
    var_4 = self _meth_850C("right_arm", "upper") + self _meth_850C("right_arm");
    var_5 = self _meth_850C("left_arm", "upper") + self _meth_850C("left_arm");
  }
}

_id_970F() {
  var_0 = getnode("ethan_prep_revive", "targetname");
  scripts\engine\utility::flag_wait("c12fight_charge_done");
  scripts\engine\utility::flag_wait_any("c12_right_arm_destroyed", "c12_left_arm_destroyed", "c12_right_leg_destroyed", "c12_left_leg_destroyed");
  wait 5;
  scripts\sp\utility::_id_F3D9(var_0);
}

_id_10D4F() {
  [[level.func["titan_spawn_heroes"]]]();
  _id_3561();
  var_0 = [level.player, _id_7888("ally")];
  var_0 = scripts\engine\utility::array_combine(var_0, level._id_10AC8);
  scripts\sp\utility::_id_F5AF("start_c12fight_transition", var_0);
  thread scripts\sp\maps\titan\titan_apc_attack::_id_B99B();
  var_1 = _id_7888("ally");
  var_1 scripts\sp\utility::_id_F3B5("g");
  var_1 scripts\sp\utility::_id_65E0("enable_auto_move");
  var_1 thread scripts\sp\maps\titan\titan_apc_attack::_id_245D(0);
  scripts\engine\utility::flag_set("c12_friendly_activate");
  var_2 = getEnt("arena_door", "targetname");
  var_2 moveTo(var_2.origin + (0, 0, 200), 0.5);
  var_2 connectpaths();
  var_3 = getEnt("arena_door2", "targetname");
  var_3 moveTo(var_3.origin + (0, 0, 0), 0.5);
  var_3 disconnectPaths();
  var_1 thread scripts\sp\maps\titan\titan_apc_attack::_id_35CA();
  thread scripts\sp\maps\titan\titan_apc_attack::_id_7275();
  thread scripts\sp\maps\titan\titan_apc_attack::_id_1064C("apc_axis_c12_arena", "init_arena_squads");
  thread scripts\sp\maps\titan\titan_apc_attack::_id_1064C("apc_axis_c12_arena_reinforce", "fallback_pipes_front");
  thread scripts\sp\maps\titan\titan_apc_attack::_id_1064E("pipes_jeeps", "init_pipe_squads");
  thread _id_FB54();
  var_4 = scripts\sp\utility::_id_7D43("pipes_jeeps", "targetname");

  foreach(var_6 in var_4)
  var_6 thread scripts\sp\maps\titan\titan_apc_attack::_id_A450(var_6.script_noteworthy);

  var_8 = _id_7824();
  var_9 = getvehiclenode("dropship_1_cleared", "script_noteworthy");
  var_8.target = var_9.targetname;
  var_8 vehicle_teleport(var_9.origin, var_9.angles);
  var_8 thread scripts\sp\maps\titan\titan_audio::_id_1194A();
  var_8 scripts\sp\vehicle_paths::_id_8023();
  var_8._id_1C13 = cos(50);
  var_8._id_207D = cos(100);
  level._id_2052 = var_8;
  var_8 scripts\sp\vehicle::_id_8441();
  var_8 thread scripts\sp\maps\titan\titan_apc_attack::_id_2089();
  scripts\engine\utility::flag_set("dropship_1_cleared");
  scripts\engine\utility::flag_set("dropship_2_cleared");
  scripts\engine\utility::flag_set("fallback_to_final");
  scripts\engine\utility::flag_set("fallback_transition");
  thread _id_2151("init_arena_squads", 4, "fallback_pipes_front", "arena_ally_advance_1");
  thread _id_2151("fallback_pipes_front", 0, "fallback_pipes_mid", "arena_ally_advance_2");
  scripts\sp\utility::_id_15F5("trig_ally_color_transition");
  wait 3;
  playworldsound("scn_refinery_roll_up_door", var_3.origin);
  var_3 moveTo(var_3.origin + (0, 0, 216), 2);
  var_3 connectpaths();
  scripts\engine\utility::flag_set("init_arena_squads");
  scripts\engine\utility::flag_set("init_pipe_squads");

  if(!scripts\engine\utility::flag("player_has_td"))
    scripts\sp\maps\titan\titan_apc_attack::_id_8316();
}

_id_FB54() {
  scripts\engine\utility::flag_wait("init_pipe_squads");
  wait 3;
  thread scripts\engine\utility::play_sound_in_space("scn_titan_jeep_skid_01", (-31695, -42748, -65072));
}

_id_12655() {
  wait 1;
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_ksh_wereabouthalfway");
  scripts\engine\utility::flag_wait("fallback_pipes_front");
  _id_3561();
  thread _id_2097();
  var_0 = getnode("c12fight_transition_node", "targetname");
  var_1 = getnode("c12fight_dropoff_node", "targetname");
  var_2 = _id_7888("ally");
  var_2 scripts\sp\utility::_id_54F7();
  var_2 notify("stop_move_along_struct_path");
  var_2.goalradius = 100;
  var_2 _meth_82EE(var_0);
  scripts\engine\utility::flag_wait("c12_fight");
  thread scripts\sp\maps\titan\titan_code::_id_D250(1);
  var_2 scripts\engine\utility::delaythread(3, ::_id_1CD3, var_1);
}

_id_1CD3(var_0) {
  self _meth_82EE(var_0);
}

_id_10BD0() {
  [[level.func["titan_spawn_heroes"]]]();
  _id_3561();
  var_0 = [level.player, _id_7888("ally")];
  scripts\sp\utility::_id_F5AF("start_c12fight_dropoff", var_0);
  scripts\sp\utility::_id_F5AF("start_c12fight_friendlies", level._id_10AC8);
  var_1 = getnode("c12fight_dropoff_node", "targetname");
  var_2 = _id_7888("ally");
  var_2 scripts\sp\utility::_id_54F7();
  var_2 notify("stop_move_along_struct_path");
  var_2.goalradius = 100;
  var_2 _meth_82EE(var_1);
  var_2 thread scripts\sp\maps\titan\titan_apc_attack::_id_245D(1);
  scripts\engine\utility::flag_set("c12_friendly_activate");
  scripts\sp\utility::_id_15F3("c12fight_advance");

  if(!scripts\engine\utility::flag("player_has_td"))
    scripts\sp\maps\titan\titan_apc_attack::_id_8316();
}

_id_5D2E() {
  _id_3561();
  var_0 = _id_7888("enemy");
  var_0 thread _id_354E(0);
  var_0 thread _id_B954();
  var_1 = getEnt("dead_apc_coll", "targetname");
  var_1 notsolid();
  var_1 connectpaths();
  var_2 = _id_796C();
  scripts\sp\utility::_id_22CA("c12fight_dropship", ::_id_D70A);
  var_3 = scripts\sp\vehicle::_id_1080C("c12fight_dropship");
  var_3 notify("turnengineoff");
  var_3._id_8441 = 1;
  var_3 castspotshadows(0);
  var_3 detach("veh_mil_air_ca_dropship_personnel", "tag_connect");
  level._id_C47F scripts\sp\utility::_id_10346("titan_usf_letswipeup");
  level._id_B33B scripts\engine\utility::delaythread(3, scripts\sp\utility::_id_10346, "titan_brk_enemymega");
  level._id_B33E scripts\engine\utility::delaythread(6, scripts\sp\utility::_id_10346, "titan_usf_gettocover");
  var_2._id_11677.origin = var_3.origin + var_2._id_1726;
  var_2._id_11677.angles = var_3.angles + var_2._id_1695;
  var_2._id_11677 linkTo(var_3);
  var_3._id_11677 = var_2._id_11677;
  var_3 playSound("scn_dropship_enemyc12_drop");
  var_3 thread scripts\sp\vehicle_paths::_id_845A();
  setmusicstate("mx_019_mechdrop");
  _id_F38C(5);

  foreach(var_5 in level._id_355D._id_3659)
  var_5 scripts\sp\maps\titan\titan_code::_id_3550("right", 0);

  scripts\engine\utility::flag_wait("c12fight_dropoff");
  thread _id_E034();
  level._id_C47F thread scripts\sp\utility::_id_10346("titan_omr_reyesfindaway");
  scripts\sp\utility::_id_266A("C12_dropoff");
  wait 2;
}

_id_796C() {
  var_0 = spawnStruct();
  var_0.origin = (0, 0, 0);
  var_0.angles = (0, 0, 0);
  var_1 = spawn("script_model", (0, 0, 0));
  var_1 setModel("robot_c12");
  var_1._id_1FBB = "c12_enemy";
  var_1 scripts\sp\anim::_id_F64A();
  var_2 = scripts\sp\utility::_id_10639("dropship");
  var_0 thread scripts\sp\anim::_id_1EC1([var_1, var_2], "c12fight_dropoff");
  wait 0.05;
  var_3 = spawnStruct();
  var_4 = var_1.origin - var_2.origin;
  var_3._id_1726 = rotatevector(var_4, var_2.angles);
  var_3._id_1695 = var_2.angles - var_1.angles;
  var_3._id_11677 = var_1;
  var_2 delete();
  var_3 notify("stop_first_frame");
  return var_3;
}

_id_D70A() {
  self waittill("dropoff_anim");
  self._id_1FBB = "dropship";
  var_0 = "c12fight_dropoff";
  scripts\engine\utility::exploder("fx_c12drop_crash");
  scripts\engine\utility::flag_set("c12_crash_in_physics");
  var_1 = scripts\engine\utility::getStruct("c12_fight_dropoff", "targetname");
  var_2 = getstartorigin(var_1.origin, var_1.angles, scripts\sp\utility::_id_7DC1(var_0));
  var_3 = getstartangles(var_1.origin, var_1.angles, scripts\sp\utility::_id_7DC1(var_0));
  self _meth_83E3(var_2, var_3, 50, 0);
  self waittill("orientto_complete");
  var_4 = _id_7888("enemy");
  var_4 thread _id_3641();
  var_5 = [self, var_4];
  self._id_11677 delete();
  var_4 dontinterpolate();
  self notify("turnengineoff");
  var_1 scripts\sp\anim::_id_1F2C(var_5, "c12fight_dropoff");

  foreach(var_7 in level._id_355D._id_3659)
  var_7 scripts\sp\maps\titan\titan_code::_id_3550("right", 1);

  scripts\engine\utility::flag_set("c12fight_dropoff");
  scripts\engine\utility::flag_set("c12_fight_turn_off_eye_spotlight");
}

_id_3641() {
  if(isDefined(self.bt._id_71C9))
    self[[self.bt._id_71C9]]();

  var_0 = getEnt("c12_enemy_omni_a", "targetname");
  var_1 = getEnt("c12_enemy_omni_b", "targetname");
  var_2 = getEnt("c12_enemy_spot_a", "targetname");
  var_0.origin = (0, 0, 0);
  var_0.angles = (0, 0, 0);
  var_0 linkTo(self, "J_Clavicle_Inner_RI", (10, -7, 1), (0, 0, 0));
  var_1.origin = (0, 0, 0);
  var_1.angles = (0, 0, 0);
  var_1 linkTo(self, "J_Clavicle_Inner_LE", (10, -7, 1), (0, 0, 0));
  self waittill("death");

  if(isDefined(self)) {
    var_0 setlightintensity(0);
    var_1 setlightintensity(0);
    var_2 setlightintensity(0);
    var_0 delete();
    var_1 delete();
    var_2 delete();
  }
}

_id_10BCC() {
  [[level.func["titan_spawn_heroes"]]]();
  _id_3561();
  scripts\sp\utility::_id_F5AF("start_c12fight_default", [level.player]);
  scripts\sp\utility::_id_F5AF("start_c12fight_friendlies", level._id_10AC8);
  var_0 = _id_7888("ally");
  var_0 thread scripts\sp\maps\titan\titan_apc_attack::_id_245D(0);
  scripts\engine\utility::flag_set("c12_friendly_activate");
  scripts\sp\utility::_id_15F3("c12fight_advance");
  var_1 = getEnt("dead_apc_coll", "targetname");
  var_1 notsolid();
  var_1 connectpaths();
}

#using_animtree("player");

_id_3CB7() {
  var_0 = _id_7888("enemy");
  var_0 endon("death");

  if(!isalive(var_0) || var_0 _id_35AB()) {
    return;
  }
  thread _id_3541();
  thread _id_3CC1(var_0);
  var_0 thread _id_B990();
  _id_F38C(2);
  var_1 = level._id_355D._id_3659;
  var_2 = scripts\engine\utility::getStruct("c12_fight_charge", "targetname");

  if(level._id_10CDA == "c12_charge") {
    var_2 thread scripts\sp\anim::_id_1EC1(var_1, "c12fight_charge");
    wait 3;
  } else
    var_2 scripts\sp\anim::_id_1F0A(var_1, "c12fight_charge");

  var_3 = getnodearray("c12fight_charge_nodes", "targetname");
  scripts\engine\utility::array_call(var_3, ::_meth_80AC);
  level._id_2429 scripts\engine\utility::delaythread(1, scripts\sp\utility::_id_10346, "titan_eth_watchit");
  level._id_B33E scripts\engine\utility::delaythread(3, scripts\sp\utility::_id_10346, "titan_ksh_notgoodnotgood");
  level._id_C47F scripts\engine\utility::delaythread(5, scripts\sp\utility::_id_10346, "titan_usf_fallback");
  _id_119BE(var_1["enemy"], 4, 1);
  _id_119BE(var_1["enemy"], 10, 0);
  level._id_355D._id_3659["ally"].ignoreme = 1;

  if(scripts\engine\utility::flag("player_rodeo_enabled")) {
    var_0 scripts\sp\maps\titan\titan_code::_id_10FC2();

    while(scripts\engine\utility::flag("player_rodeo_enabled"))
      scripts\engine\utility::waitframe();

    var_4 = getanimlength(%titan_c12_rodeo_player_dismount);
    wait(var_4);
  }

  if(isDefined(var_0._id_E601) && isalive(var_0._id_E601)) {
    scripts\engine\utility::flag_set("c12_rocket_alive");
    var_2 scripts\sp\anim::_id_1F0A(var_1, "c12fight_charge");
  }

  if(scripts\engine\utility::flag("c12_rocket_alive")) {
    if(isalive(var_0._id_E601))
      return;
  }

  if(!isalive(var_0) || var_0 _id_35AB()) {
    return;
  }
  var_0 _id_0A05::_id_353F();
  var_0 setCanDamage(0);

  if(isDefined(var_0._id_E601))
    var_0._id_E601 setCanDamage(0);

  level notify("charge_anim_go");
  var_2 scripts\sp\anim::_id_1F2C(var_1, "c12fight_charge");
  var_0 setCanDamage(1);

  if(isDefined(var_0._id_E601))
    var_0._id_E601 setCanDamage(1);

  var_0 _id_0A05::_id_353F(0);

  foreach(var_6 in var_1) {
    if(isalive(var_6))
      var_6 setgoalpos(var_6.origin);
  }

  scripts\engine\utility::flag_set("c12fight_charge_done");
  scripts\engine\utility::flag_set("c12fight_apc_start");
  level notify("reinforce_c12_fight");
  var_1["ally"]._id_3CC4 = var_2;
  var_2 thread scripts\sp\anim::_id_1EEA(var_1["ally"], "c12fight_charge_loop", "end_charge_loop");
  level._id_C47F thread scripts\sp\utility::_id_10346("titan_omr_thisthingistoo");
  scripts\sp\utility::_id_266A("C12_charge");
  wait 2;
  level notify("c12_dialogue_ended");
}

_id_B990() {
  scripts\engine\utility::flag_clear("player_rodeo_enabled");
  self waittill("begin_rodeo");
  scripts\engine\utility::flag_set("player_rodeo_enabled");
  scripts\engine\utility::waittill_any("death", "end_rodeo");
  scripts\engine\utility::flag_clear("player_rodeo_enabled");
}

_id_3CC1(var_0) {
  level endon("charge_anim_go");
  level scripts\engine\utility::waittill_any("enemy_c12_right_arm_destroyed", "enemy_c12_left_arm_destroyed", "enemy_c12_right_leg_destroyed", "enemy_c12_left_leg_destroyed");

  while(isalive(var_0))
    scripts\engine\utility::waitframe();

  scripts\engine\utility::flag_set("kill_charge_anim_thread");
  level notify("stop_enemy_count_thread");
  var_1 = getEntArray("c12_refinery_player_volumes", "targetname");
  var_0 thread scripts\sp\maps\titan\titan_code::_id_3558(var_1);
  var_0 notify("stop_player_engagement_controller");
}

_id_3CBD() {
  var_0 = getEntArray("swap_in_1", "targetname");
  var_1 = getEntArray("swap_in_2", "targetname");
  var_2 = getEntArray("swap_out_1", "targetname");
  var_3 = getEntArray("swap_out_2", "targetname");

  foreach(var_5 in var_0)
  var_5 hide();

  foreach(var_5 in var_1)
  var_5 hide();

  foreach(var_5 in var_2)
  var_5 show();

  foreach(var_5 in var_3)
  var_5 show();
}

_id_3CBB() {
  level thread _id_3CC2();
  scripts\engine\utility::exploder("c12fight_charge");
  var_0 = _id_7888("ally");
  var_1 = _id_7888("enemy");
  var_2 = getEntArray("swap_in_1", "targetname");
  var_3 = getEntArray("swap_out_1", "targetname");

  foreach(var_5 in var_2)
  var_5 show();

  foreach(var_5 in var_3)
  var_5 hide();

  screenshake(var_0.origin, 1.5, 3, 0.7, 1, 0.05, 0.8, 700, 30, 5, 5);
  playworldsound("c12fight_charge_impact", var_0.origin + (0, 0, 100));
  var_1 thread scripts\sp\utility::play_sound_on_tag("c12fight_charge_bash", "j_SpineUpper");
  var_1 scripts\engine\utility::delaythread(0.4, scripts\sp\utility::play_sound_on_tag, "c12fight_charge_screech", "j_SpineUpper");
}

_id_3CBC() {
  level thread _id_3CC2();
  scripts\engine\utility::exploder("c12fight_charge2");
  var_0 = _id_7888("enemy");
  var_1 = getEntArray("swap_in_2", "targetname");
  var_2 = getEntArray("swap_out_2", "targetname");

  foreach(var_4 in var_1)
  var_4 show();

  foreach(var_4 in var_2)
  var_4 hide();

  screenshake(var_0.origin, 1.5, 3, 0.7, 1, 0.05, 0.8, 700, 30, 5, 5);
  playworldsound("c12fight_charge_impact", var_0.origin + (0, 0, 100));
  var_0 thread scripts\sp\utility::play_sound_on_tag("c12fight_charge_bash", "j_SpineUpper");
  var_0 scripts\engine\utility::delaythread(0.4, scripts\sp\utility::play_sound_on_tag, "c12fight_charge_screech", "j_SpineUpper");
}

_id_3CC2() {
  var_0 = _id_7888("ally");
  var_1 = squared(120);
  var_2 = 250;

  while(!scripts\engine\utility::flag("c12fight_charge_done")) {
    wait 0.05;
    var_3 = getaiunittypearray("axis");
    var_4 = var_0.origin[2];
    var_5 = var_0.origin[2] + var_2;

    foreach(var_7 in var_3) {
      if(!isalive(var_7)) {
        continue;
      }
      if(var_7.origin[2] <= var_4 || var_7.origin[2] > var_5) {
        continue;
      }
      if(distance2dsquared(var_7.origin, var_0.origin) < var_1)
        var_7 _meth_81D0();
    }
  }
}

_id_10BCA() {
  [[level.func["titan_spawn_heroes"]]]();
  _id_3561();
  scripts\sp\utility::_id_F5AF("start_c12fight_default", [level.player]);
  scripts\sp\utility::_id_F5AF("start_c12fight_friendlies", level._id_10AC8);
  scripts\sp\utility::_id_15F3("c12fight_advance");
  scripts\engine\utility::flag_set("c12fight_charge_done");
  scripts\engine\utility::flag_set("c12fight_apc_start");
  var_0 = _id_7888("ally");
  var_1 = scripts\engine\utility::getStruct("c12_fight_charge", "targetname");
  var_1 thread scripts\sp\anim::_id_1EEA(var_0, "c12fight_charge_loop", "end_charge_loop");
  var_0 thread scripts\sp\maps\titan\titan_apc_attack::_id_245D(0);
  scripts\engine\utility::flag_set("c12_friendly_activate");
  var_2 = getEnt("dead_apc_coll", "targetname");
  var_2 notsolid();
  var_2 connectpaths();
  thread _id_3541();
  level notify("reinforce_c12_fight");
}

_id_2054() {
  var_0 = _id_7888("enemy");
  var_0 endon("death");
  level endon("enemy_c12_right_arm_destroyed");
  var_1 = _id_7824();
  var_2 = [var_0, var_1];
  var_3 = getvehiclenode("c12fight_apc_turnpoint", "script_noteworthy");
  var_4 = scripts\engine\utility::getStruct("c12_fight_apc", "targetname");
  var_5 = scripts\engine\utility::getStruct("c12fight_battle_node", "targetname");
  thread _id_2078(var_0);
  var_0 thread _id_B990();
  _id_F38C(5);

  if(scripts\engine\utility::flag("kill_apc_anim_thread")) {
    return;
  }
  if(!isalive(var_0) || var_0 _id_35AB()) {
    level notify("stop_enemy_count_thread");
    return;
  }

  if(level._id_10CDA == "c12_apc") {
    var_4 thread scripts\sp\anim::_id_1EC1([var_0], "c12fight_apc");
    var_1 vehicle_teleport(var_3.origin, var_3.angles);
    var_1.target = var_3.targetname;
    var_1 scripts\sp\vehicle_paths::_id_8023();
    wait 3;
  } else {
    level._id_C47F thread scripts\sp\utility::_id_10346("titan_usf_putfireonthatmega");
    var_0.goalradius = 32;
    var_0 setgoalpos(var_5.origin);
    var_0 _id_354E(1);
    var_0 waittill("goal");
    wait 2;
    var_0.goalradius = level._id_4FF6;
    var_1.mgturret[0] turretfiredisable();

    if(!isalive(var_0)) {
      return;
    }
    var_0 _id_354E(0);
    var_0 _id_354F(0);
    var_4 scripts\sp\anim::_id_1F0A([var_0], "c12fight_apc");
    scripts\sp\utility::_id_22A4([var_0], "new_anim_reach");
  }

  scripts\engine\utility::flag_set("c12fight_apc_ready");
  thread _id_2066(var_0);

  if(!isDefined(var_1._id_1FBB))
    var_1._id_1FBB = "apc";

  if(scripts\engine\utility::flag("player_rodeo_enabled")) {
    var_0 scripts\sp\maps\titan\titan_code::_id_10FC2();

    while(scripts\engine\utility::flag("player_rodeo_enabled"))
      scripts\engine\utility::waitframe();

    var_6 = getanimlength(%titan_c12_rodeo_player_dismount);
    wait(var_6);
  }

  if(isDefined(var_0._id_E601) && isalive(var_0._id_E601)) {
    scripts\engine\utility::flag_set("c12_rocket_alive");
    var_4 scripts\sp\anim::_id_1F0A([var_0], "c12fight_apc");
  }

  if(scripts\engine\utility::flag("c12_rocket_alive")) {
    if(isalive(var_0._id_E601))
      return;
  }

  if(!isalive(var_0) || var_0 _id_35AB()) {
    level notify("stop_enemy_count_thread");
    return;
  }

  scripts\engine\utility::flag_wait("c12fight_apc_anim");
  var_0 _id_354E(1);
  _id_119BE(var_0, 0.25, 1);
  _id_119BE(var_0, 6, 0);

  if(isalive(var_0) && !var_0 _id_35AB()) {
    var_1 thread _id_2067();
    var_1.mgturret[0] setmode("manual");
    var_1.mgturret[0] settargetentity(var_0, (0, 0, 0));
    var_1.mgturret[0] turretfireenable();
    var_1.mgturret[0] _meth_8398();
    var_7 = getstartangles(var_4.origin, var_4.angles, var_1 scripts\sp\utility::_id_7DC1("c12fight_apc"));
    var_8 = getstartorigin(var_4.origin, var_4.angles, var_1 scripts\sp\utility::_id_7DC1("c12fight_apc"));
    var_1 _meth_83E3(var_8, var_7, 40, 0);
    var_1 waittill("orientto_complete");
    scripts\engine\utility::waitframe();

    if(!isalive(var_0) || var_0 _id_35AB()) {
      return;
    }
    var_0 _id_0A05::_id_353F();
    var_0 setCanDamage(0);

    if(isDefined(var_0._id_E601))
      var_0._id_E601 setCanDamage(0);

    level notify("apc_anim_go");
    var_4 scripts\sp\anim::_id_1F2C(var_2, "c12fight_apc");

    foreach(var_10 in var_2) {
      if(isai(var_10))
        var_10 setgoalpos(var_10.origin);
    }

    var_0 setCanDamage(1);

    if(isDefined(var_0._id_E601))
      var_0._id_E601 setCanDamage(1);

    var_0 _id_0A05::_id_353F(0);

    if(isalive(var_0) && isDefined(var_0.asm._id_4E73)) {
      var_0.allowdeath = 1;
      var_0 _meth_81D0(var_0.origin, level.player);
    }
  }

  level notify("stop_enemy_count_thread");
  var_12 = getEnt("dead_apc_coll", "targetname");
  var_12 disconnectPaths();
  var_13 = getEntArray("c12_refinery_player_volumes", "targetname");
  var_0 thread scripts\sp\maps\titan\titan_code::_id_3558(var_13);
  level waittill("enemy_c12_arm_destroyed");
  var_0 notify("stop_player_engagement_controller");
  scripts\sp\utility::_id_266A("C12_apc");
  wait 2;
}

_id_2078(var_0) {
  var_0 endon("death");
  level endon("apc_anim_go");
  level scripts\engine\utility::waittill_any("enemy_c12_right_arm_destroyed", "enemy_c12_right_leg_destroyed", "enemy_c12_left_leg_destroyed");

  if((scripts\engine\utility::flag("c12_right_arm_destroyed") || scripts\engine\utility::flag("c12_right_leg_destroyed") || scripts\engine\utility::flag("c12_left_arm_destroyed")) && !scripts\engine\utility::flag("c12fight_apc_anim")) {
    while(!scripts\engine\utility::flag("c12fight_apc_start"))
      scripts\engine\utility::waitframe();

    scripts\engine\utility::flag_set("kill_apc_anim_thread");
    var_0 _id_354E(1);
    _id_119BE(var_0, 0.25, 1);
    _id_119BE(var_0, 6, 0);
    level notify("stop_enemy_count_thread");
    var_1 = getEntArray("c12_refinery_player_volumes", "targetname");
    var_0 thread scripts\sp\maps\titan\titan_code::_id_3558(var_1);
    level waittill("enemy_c12_arm_destroyed");
    var_0 notify("stop_player_engagement_controller");
  }
}

_id_2066(var_0) {
  level endon("c12_is_dead");
  wait 1;

  if(!isalive(var_0) || var_0 _id_35AB()) {
    return;
  }
  level.player scripts\sp\utility::play_sound_on_entity("titan_un3_thisisdogtwo");
  wait 0.3;

  if(!isalive(var_0) || var_0 _id_35AB()) {
    return;
  }
  level._id_C47F scripts\sp\utility::_id_10346("titan_usf_nowait");
}

_id_2060() {
  level waittill("cleanup_c12fight_apc");

  if(isDefined(self)) {
    if(isDefined(self._id_129D4))
      self._id_129D4 delete();

    self _meth_83A1();
    self delete();
  }
}

_id_3541() {
  var_0 = _id_7888("enemy");
  thread _id_B955(var_0);
}

_id_B955(var_0) {
  var_0 endon("death");

  for(;;) {
    if(var_0 scripts\asm\asm_bb::ispartdismembered("left_arm")) {
      level notify("enemy_c12_arm_destroyed");
      level notify("enemy_c12_left_arm_destroyed");
      scripts\engine\utility::flag_set("c12_left_arm_destroyed");
    }

    if(var_0 scripts\asm\asm_bb::ispartdismembered("right_arm")) {
      level notify("enemy_c12_arm_destroyed");
      level notify("enemy_c12_right_arm_destroyed");
      scripts\engine\utility::flag_set("c12_right_arm_destroyed");
    }

    if(var_0 scripts\asm\asm_bb::ispartdismembered("left_leg")) {
      level notify("enemy_c12_leg_destroyed");
      level notify("enemy_c12_left_leg_destroyed");
      scripts\engine\utility::flag_set("c12_left_leg_destroyed");
    }

    if(var_0 scripts\asm\asm_bb::ispartdismembered("right_leg")) {
      level notify("enemy_c12_leg_destroyed");
      level notify("enemy_c12_right_leg_destroyed");
      scripts\engine\utility::flag_set("c12_right_leg_destroyed");
    }

    scripts\engine\utility::waitframe();
  }
}

_id_B954() {
  self waittill("death");
  level notify("c12_is_dead");
  thread _id_11991();
  wait 3;
  level notify("stop_enemy_count_thread");
  scripts\engine\utility::flag_set("c12_is_dead");
  wait 3;
  scripts\engine\utility::flag_set("c12_ally_revive");
}

_id_11991() {
  setmusicstate("");
  wait 8;
  setmusicstate("mx_415_titan_mons_tease");
}

_id_E039() {
  level waittill("c12_is_dead");

  if(isDefined(self))
    _id_0E46::_id_DFE3();
}

_id_BE36(var_0, var_1, var_2, var_3) {
  level endon(var_3);
  level endon("c12_is_dead");
  level endon("enemy_c12_arm_destroyed");
  level endon("enemy_c12_left_arm_destroyed");
  level endon("enemy_c12_right_arm_destroyed");
  level endon("enemy_c12_left_leg_destroyed");
  level endon("enemy_c12_right_leg_destroyed");

  if(scripts\engine\utility::flag("c12_right_arm_destroyed") || scripts\engine\utility::flag("c12_right_leg_destroyed") || scripts\engine\utility::flag("c12_left_arm_destroyed") || scripts\engine\utility::flag("c12_left_leg_destroyed")) {
    return;
  }
  wait(var_2);
  var_0 thread scripts\sp\utility::_id_10346(var_1);
}

_id_10CF7() {
  [[level.func["titan_spawn_heroes"]]]();
  _id_3561(0);
  scripts\sp\utility::_id_F5AF("start_c12fight_default", [level.player]);
  scripts\sp\utility::_id_F5AF("start_c12fight_friendlies", level._id_10AC8);
  _id_7275();
  scripts\sp\utility::_id_15F3("c12fight_advance");
  var_0 = _id_7888("ally");
  var_0 thread scripts\sp\maps\titan\titan_apc_attack::_id_245D(0);
  scripts\engine\utility::flag_set("c12_friendly_activate");
  var_1 = _id_7888("enemy");
  var_2 = scripts\engine\utility::getStruct("c12_fight_apc", "targetname");
  var_1 _meth_80F1(var_2.origin);
  var_1 setgoalpos(var_1.origin);
  wait 5;
  var_1.goalradius = 15;
  var_1 setgoalpos(level.player.origin);
  scripts\engine\utility::flag_set("c12fight_charge_done");
}

rodeo() {
  var_0 = _id_7888("enemy");
  thread _id_E5EB();

  if(!isalive(var_0)) {
    wait 3;
    _id_D6BC();
    scripts\engine\utility::flag_set("c12_ally_revive");
    scripts\engine\utility::flag_set("c12_fight_done");
    return;
  }

  var_0 scripts\sp\utility::_id_F39C(level.player);
  var_0 waittill("death");
  level notify("enemy_c12_dead");
  level.player _meth_8497(1);
  scripts\engine\utility::flag_set("c12_ally_revive");
  wait 2.5;
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_ksh_whoonicehit");
  _id_D6BC();
  wait 1;
  scripts\sp\utility::_id_15F1("c12fight_end_colors", "targetname");
  scripts\sp\utility::_id_2669("c12_fight_complete");
}

_id_E5EB() {
  var_0 = _id_7888("enemy");
  var_0 endon("death");
  var_0 endon("begin_rodeo");
  wait 3;

  if(!isalive(var_0)) {
    return;
  }
  level._id_C47F scripts\sp\utility::_id_10346("titan_omr_nowsthetimeto");
  level._id_B33B scripts\sp\utility::_id_10346("titan_brk_howthehelldowe");
  level._id_C47F scripts\sp\utility::_id_10346("titan_omr_reyesgetonits");
  thread _id_BE36(level._id_C47F, "titan_omr_prontowedonthave", 15, "enemy_c12_dead");
  var_1 = squared(350);

  while(distance2dsquared(level.player.origin, var_0.origin) > var_1)
    wait 0.1;

  scripts\sp\utility::_id_1034D("titan_plr_gottagetupclose");
  wait 0.2;
  level._id_B33E scripts\sp\utility::_id_10346("titan_ksh_whatareyou");
}

_id_D6BC() {
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_usf_youdhavemadeonehell");
  wait 0.2;
  scripts\sp\maps\titan\titan_code::_id_134B7("titan_plr_nottoolatefor");
}

_id_10317(var_0, var_1) {
  for(;;) {
    wait(randomfloatrange(var_0, var_1));
    var_2 = getaiunittypearray("axis", "soldier");

    if(var_2.size == 0) {
      break;
    }

    var_2[randomint(var_2.size)] _meth_81D0();
  }
}

_id_10BD3() {
  [[level.func["titan_spawn_heroes"]]]();
  _id_3561();
  scripts\sp\utility::_id_F5AF("start_c12fight_default", [level.player]);
  scripts\sp\utility::_id_F5AF("start_c12fight_friendlies", level._id_10AC8);
  _id_7275();
  scripts\sp\utility::_id_15F3("c12fight_advance");
  scripts\engine\utility::flag_set("c12fight_charge_done");
  scripts\engine\utility::flag_set("c12_ally_revive");
  var_0 = _id_7888("ally");
  var_1 = scripts\engine\utility::getStruct("c12_fight_charge", "targetname");
  var_1 thread scripts\sp\anim::_id_1EEA(var_0, "c12fight_charge_loop", "end_charge_loop");
  var_0 thread scripts\sp\maps\titan\titan_apc_attack::_id_245D(0);
  scripts\engine\utility::flag_set("c12_friendly_activate");
  scripts\sp\utility::_id_10FEC("fx_background_mist_1");
  var_2 = getnode("ethan_prep_revive", "targetname");
  level._id_2429 _meth_80F1(var_2.origin, var_2.angles);
  level._id_2429 _meth_82EE(var_2);
  wait 3.0;
  scripts\engine\utility::flag_set("c12_fight_turn_on_eye_spotlight");
  level notify("stop_enemy_count_thread");
  level notify("c12_is_dead");
}

_id_E494() {
  var_0 = _id_7888("ally");
  var_1 = scripts\engine\utility::getStruct("c12_fight_charge", "targetname");
  var_2 = scripts\engine\utility::getStruct("c12_fight_revive", "targetname");
  var_3 = getEntArray("c12_fight_coll", "targetname");
  scripts\engine\utility::flag_set("c12_fight_done");
  thread _id_4043();

  if(scripts\engine\utility::flag("c12fight_charge_done")) {
    scripts\engine\utility::flag_wait("c12_ally_revive");
    level._id_2429 thread scripts\sp\utility::_id_10346("titan_eth_ifitscircuitsarent");
    var_2 scripts\sp\anim::_id_1F0D(level._id_2429, "c12_revive");
    var_1 scripts\engine\utility::delaythread(3, scripts\sp\anim::_id_1F35, var_0, "c12_revive");
    var_2 scripts\sp\anim::_id_1F35(level._id_2429, "c12_revive");
    var_1 notify("end_charge_loop");

    foreach(var_5 in var_3)
    var_5 notsolid();

    thread _id_E497();
    _id_355F();
    scripts\engine\utility::flag_wait("c12_revive_dialogue_done");
  }

  scripts\engine\utility::flag_wait("c12_fight_ai_cleansed");
}

_id_E497() {
  level._id_B33E scripts\sp\utility::_id_10346("titan_ksh_ourboysstillin");
  level._id_B33B scripts\sp\utility::_id_10346("titan_brk_thatssometoughmetal");
  scripts\engine\utility::flag_set("c12_revive_dialogue_done");
}

_id_355F() {
  scripts\sp\utility::_id_228A(level._id_355D.spawners);
  level._id_355D.spawners = undefined;
  level._id_355D = undefined;
}

_id_5D32(var_0) {
  var_1 = _id_7888("ally");
  var_1 notify("stop_rocket_tracking");
  level.player notify("disable_target_designator");

  if(issubstr(level.player getcurrentweapon(), "apc_target_designator")) {
    level.player takeweapon("apc_target_designator");
    level.player._id_110B3 = level.player scripts\sp\utility::_id_7D74(1);
    level.player switchtoweapon(level.player._id_110B3[0]);
    level.player scripts\sp\maps\titan\titan_apc_attack::_id_5518();
  } else
    level.player takeweapon("apc_target_designator");

  level.player scripts\sp\utility::_id_11425();
}

_id_3570(var_0) {
  var_1 = _id_7824();
  var_2 = var_0 gettagorigin("tag_missile_top_ri");
  magicbullet(var_0.primaryweapon, var_2, var_1.origin);
}

_id_3CCF(var_0) {
  level thread _id_3CBB();
}

_id_3CD0(var_0) {
  wait 2;
  level thread _id_3CBC();
}

#using_animtree("vehicles");

_id_207E(var_0) {
  var_1 = scripts\engine\utility::getStruct("c12_fight_apc", "targetname");
  var_0._id_5946 = 1;
  var_0._id_5960 = 1;
  var_0 scripts\sp\vehicle::_id_8440();
  var_0 _meth_81D0();
  var_0 _meth_83A1();
  var_0 clearanim(%root, 0.2);
  thread _id_207F();
  var_0 waittillmatch("single anim", "end");
  var_0._id_5960 = undefined;
}

_id_207F() {
  level endon("enemy_c12_arm_destroyed");
  level endon("enemy_c12_left_arm_destroyed");
  level endon("enemy_c12_right_arm_destroyed");

  if(scripts\engine\utility::flag("c12_right_arm_destroyed") || scripts\engine\utility::flag("c12_right_leg_destroyed") || scripts\engine\utility::flag("c12_left_arm_destroyed") || scripts\engine\utility::flag("c12_left_leg_destroyed")) {
    return;
  }
  wait 1.2;
  level._id_B33B scripts\sp\utility::_id_10346("titan_brk_dogtwoisdown");
  level._id_B33E scripts\sp\utility::_id_10346("titan_ksh_shitmanwhatdo");
  level._id_C47F scripts\sp\utility::_id_10346("titan_omr_weneedtodisable");
  level._id_2429 scripts\sp\utility::_id_10346("titan_eth_yourheavyweaponscan");
  thread _id_BE36(level._id_C47F, "titan_omr_reyesshootitsarms", 20, "enemy_c12_arm_destroyed");
}

_id_EF49() {
  var_0 = undefined;

  if(isDefined(self.target))
    var_0 = scripts\engine\utility::getStruct(self.target, "targetname");

  var_1 = (0, 0, 0);

  if(isDefined(self.script_angles))
    var_1 = self.script_angles * -1;

  var_2 = 100;

  for(var_3 = 1; isDefined(var_0); var_0 = scripts\engine\utility::getStruct(var_0.target, "targetname")) {
    if(isDefined(var_0.speed))
      var_2 = var_0.speed;

    if(isDefined(var_0._id_EEE5))
      var_4 = var_0._id_EEE5;
    else {
      var_5 = distance(self.origin, var_0.origin);
      var_4 = var_5 / var_2;
    }

    var_6 = 0;

    if(isDefined(var_0.script_accel))
      var_6 = var_0.script_accel;

    var_7 = 0;

    if(isDefined(var_0._id_ED4C))
      var_7 = var_0._id_ED4C;

    if(var_3) {
      var_3 = 0;
      var_6 = var_4;
      var_7 = 0;
    }

    if(isDefined(self.children))
      scripts\engine\utility::array_thread(self.children, ::_id_3E63, var_4, var_6, var_7);

    self rotateTo(var_0.angles + var_1, var_4, var_6, var_7);
    self moveTo(var_0.origin, var_4, var_6, var_7);
    wait(var_4);

    if(!isDefined(var_0.target)) {
      break;
    }
  }
}

_id_3E63(var_0, var_1, var_2) {
  if(!isDefined(self.target)) {
    return;
  }
  var_3 = scripts\engine\utility::getStruct(self.target, "targetname");
  self rotateTo(var_3.angles, var_0, var_1, var_2);
  self moveTo(var_3.origin, var_0, var_1, var_2);

  if(isDefined(var_3.target))
    self.target = var_3.target;
  else
    self.target = undefined;
}

_id_F38C(var_0) {
  level._id_355D._id_6434 = var_0;
}

_id_6436(var_0) {
  level endon("stop_enemy_count_thread");
  level waittill("reinforce_c12_fight");

  foreach(var_2 in level._id_355D.spawners)
  var_2.target = "c12fight_battle_node";

  level._id_355D.spawners = scripts\engine\utility::array_randomize(level._id_355D.spawners);
  var_4 = squared(400);

  while(!scripts\engine\utility::flag("c12_fight_done")) {
    wait 0.5;

    if(_id_9BD1()) {
      continue;
    }
    var_5 = 0;

    foreach(var_2 in level._id_355D.spawners) {
      if(_id_9BD1()) {
        break;
      }

      if(distancesquared(var_2.origin, level.player.origin) < var_4) {
        var_5++;
        continue;
      }

      var_2.count = 1;
      var_7 = var_2 scripts\sp\utility::_id_10619();

      if(isDefined(var_7)) {
        if(scripts\engine\utility::flag("c12fight_dropoff"))
          var_7.grenadeammo = 0;

        var_7.targetname = "c12fight_ai";
        level._id_355D.spawners = scripts\sp\utility::array_remove_index(level._id_355D.spawners, var_5);
        level._id_355D.spawners[level._id_355D.spawners.size] = var_2;
        continue;
      }

      var_5++;
    }
  }
}

_id_4043() {
  var_0 = getEntArray("c12fight_ai", "targetname");

  foreach(var_2 in var_0) {
    if(!isalive(var_2)) {
      continue;
    }
    var_2 _meth_81D0();
  }

  scripts\engine\utility::flag_set("c12_fight_ai_cleansed");
}

_id_9BD1() {
  var_0 = getaiunittypearray("axis", "soldier");
  return var_0.size >= level._id_355D._id_6434;
}

_id_E034() {
  var_0 = getaiunittypearray("axis", "soldier");
  var_1 = getaiunittypearray("allies", "soldier");
  var_2 = scripts\engine\utility::array_combine(var_0, var_1);

  foreach(var_4 in var_2) {
    if(isDefined(var_4))
      var_4.grenadeammo = 0;
  }
}

_id_7275() {
  level._id_2429 scripts\sp\utility::_id_F3B5("o");
  level._id_C47F scripts\sp\utility::_id_F3B5("b");
  level._id_B33B scripts\sp\utility::_id_F3B5("b");
  level._id_B33E scripts\sp\utility::_id_F3B5("b");
}

_id_119BE(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::delaythread(var_1, scripts\sp\utility::_id_F416, var_2);
  var_0 scripts\engine\utility::delaythread(var_1, scripts\sp\utility::_id_F415, var_2);
}

_id_F987() {
  if(!isDefined(level._id_739C)) {
    var_0 = getEnt("friendly_c12_spawner", "targetname");

    if(!isDefined(var_0))
      var_0 = getEnt("c12ally_spawner", "targetname");

    var_1 = var_0 scripts\sp\utility::_id_10619(1);
    var_1 scripts\sp\utility::_id_65E0("enable_auto_move");
    var_1 thread scripts\sp\utility::_id_5131();
    var_1.name = "";
    level._id_739C = var_1;
  } else
    var_1 = level._id_739C;

  var_1.script_noteworthy = "c12_ally";
  return var_1;
}

_id_7888(var_0) {
  return level._id_355D._id_3659[var_0];
}

_id_7824() {
  return level._id_355D._id_2054;
}

_id_3567() {
  var_0 = 1.0;
}

_id_6E57(var_0) {
  self endon("death");
  scripts\engine\utility::flag_wait(var_0);
}

_id_35AB() {
  return _id_0A05::_id_35AC();
}

_id_3606(var_0, var_1, var_2, var_3) {
  _id_0A05::_id_360D(var_0, var_1, var_2, var_3);
}

_id_352C(var_0) {
  _id_0A05::_id_352D(var_0);
}

_id_354E(var_0) {
  _id_0A05::_id_3551(var_0);
}

_id_354F(var_0) {
  _id_0A05::_id_3552(var_0);
}

_id_1358(var_0, var_1, var_2) {
  var_2 = (var_2 - var_0) / (var_1 - var_0);
  return clamp(var_2, 0, 1);
}

_id_2067() {
  self waittill("orientto_complete");
  wait 1.7;
  self.mgturret[0] _meth_83A3();
  self.mgturret[0] turretfiredisable();
  self.mgturret[0] cleartargetentity();
}

_id_2097() {
  var_0 = level._id_355D._id_2054;
  var_0 notify("stop_move_along_struct_path");
  var_0 resumespeed(3);
  scripts\engine\utility::flag_wait("c12fight_apc_switchnode");
  var_1 = getvehiclenode("c12fight_apc_path", "targetname");
  var_0 scripts\sp\vehicle::_id_13245(var_0._id_4BF7, var_1);
}

_id_2151(var_0, var_1, var_2, var_3) {
  scripts\engine\utility::flag_wait(var_0);
  wait 1;

  for(level._id_26E4 = getaiarray("axis"); level._id_26E4.size > var_1; level._id_26E4 = scripts\sp\utility::array_removedeadvehicles(level._id_26E4)) {
    level._id_26E4 = getaiarray("axis");
    wait 1;
  }

  scripts\engine\utility::flag_set(var_2);

  if(isDefined(var_3))
    scripts\sp\utility::_id_15F5(var_3);
}

_id_6636() {}

_id_7997() {
  var_0 = getEntArray();
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isDefined(var_3.classname))
      var_4 = "UNKNOWN WTF?";
    else
      var_4 = var_3.classname;

    if(isDefined(var_3._id_49BD))
      var_4 = "CREATEFX " + var_3.classname;

    if(var_4 == "script_model")
      var_4 = var_4 + (" " + var_3.model);

    if(!isDefined(var_1[var_4]))
      var_1[var_4] = 0;

    var_1[var_4]++;
  }

  var_1 = _id_1041D(var_1);
  return var_1;
}

_id_1041D(var_0) {
  var_1 = getarraykeys(var_0);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    for(var_4 = var_2; var_4 < var_1.size; var_4++) {
      if(var_0[var_1[var_2]] < var_0[var_1[var_4]]) {
        var_5 = var_1[var_4];
        var_1[var_4] = var_1[var_2];
        var_1[var_2] = var_5;
      }
    }
  }

  var_6 = [];

  for(var_2 = 0; var_2 < var_1.size; var_2++)
    var_6[var_1[var_2]] = var_0[var_1[var_2]];

  return var_6;
}

_id_663A() {}

_id_6637() {
  if(!isDefined(level._id_126F))
    level._id_126F = [];

  var_0 = getEntArray();

  foreach(var_2 in var_0) {
    if(!isDefined(var_2)) {
      continue;
    }
    if(!isDefined(var_2.origin)) {
      continue;
    }
    if(!isDefined(var_2._id_65D9)) {
      var_2._id_65D9 = gettime();
      level thread _id_65F3(var_2);
    }
  }
}

_id_65F3(var_0) {
  var_0 endon("death");
  var_1 = 60;
  var_2 = 1;
  var_3 = var_2 / var_1;
  var_4 = (1, 1, 0);
  var_5 = (0.2, 0.2, 0.2);
  var_6 = (var_4 - var_5) / var_1;

  for(var_7 = 0; var_7 < var_1; var_7++) {
    if(!isDefined(var_0)) {
      return;
    }
    var_8 = var_2 - var_3 * var_7;
    var_9 = var_4 - var_6 * var_7;
    var_8 = clamp(var_8, 0, 1);
    wait 0.05;
  }
}