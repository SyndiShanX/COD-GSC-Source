/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\europa\europa_labs.gsc
**************************************************/

_id_A79C() {
  scripts\engine\utility::flag_init("entering_c12_research_room");
  scripts\engine\utility::flag_init("entering_preairlock_room");
  scripts\engine\utility::flag_init("airlock_opened_enough");
  scripts\engine\utility::flag_init("antigrav_detonates");
  scripts\engine\utility::flag_init("combat_bridge_argue");
  scripts\engine\utility::flag_init("start_bridge_argue");
  scripts\engine\utility::flag_init("player_scar1_in_airlock");
  scripts\engine\utility::flag_init("player_enters_glass_bridge");
  scripts\engine\utility::flag_init("player_crossing_bridge");
  scripts\engine\utility::flag_init("player_enters_c12_labs");
  scripts\engine\utility::flag_init("combat_end_hall");
  scripts\engine\utility::flag_init("enter_office_door_area");
  scripts\engine\utility::flag_init("enter_cutter_area");
  scripts\engine\utility::flag_init("entering_office_exit");
  scripts\engine\utility::flag_init("cutter_finished");
  scripts\engine\utility::flag_init("wall_cut_finished");
  scripts\engine\utility::flag_init("combat_office_exit");
  scripts\engine\utility::flag_init("office_exit_start_scene");
  scripts\engine\utility::flag_init("player_exit_office_into_armory");
  scripts\engine\utility::flag_init("player_through_airlock_door");
  scripts\engine\utility::flag_init("player_in_cutter_room");
  scripts\engine\utility::flag_init("cutter_bot_battle_finished");
  scripts\engine\utility::flag_init("cancel_door_tap_scene");
  scripts\engine\utility::flag_init("lab_exterior_clear");
  scripts\engine\utility::flag_init("seeker_room_hot");
  scripts\engine\utility::flag_init("seeker_enemies_dead");
  scripts\engine\utility::flag_init("airlock_enemies_dead");
  scripts\engine\utility::flag_init("antigrav_out");
  scripts\engine\utility::flag_init("antigrav_clear");
  scripts\engine\utility::flag_init("takedown_enemy_dead");
  scripts\engine\utility::flag_init("seeker_attacked");
  scripts\engine\utility::flag_init("cliffjumper_vo_finished");
  scripts\engine\utility::flag_init("takedown_finished");
  scripts\engine\utility::flag_init("lab_exterior_vo_finished");
  scripts\engine\utility::flag_init("squad_to_airlock");
  scripts\engine\utility::flag_init("airlock_closing");
  scripts\engine\utility::flag_init("airlock_ready");
  scripts\engine\utility::flag_init("locker_c6s_dead");
  scripts\engine\utility::flag_init("scars_in_cutter_room");
  scripts\engine\utility::flag_init("crash_door");
  scripts\engine\utility::flag_init("office_fight_started");
  scripts\engine\utility::flag_init("allies_kickoff");
  scripts\engine\utility::flag_init("raise_platform");
  scripts\engine\utility::flag_init("platform_guys_dead");
  scripts\engine\utility::flag_init("player_did_alt_scope");
  scripts\engine\utility::flag_init("takedown_vo_complete");
  scripts\engine\utility::flag_init("scars_in_lab");
  scripts\engine\utility::flag_init("straggler_dead");
  scripts\engine\utility::flag_init("base_entrance_snipers_engaged");
  scripts\engine\utility::flag_init("base_entrance_platform_enemies_engaged");
  scripts\sp\utility::_id_22C9("seeker_enemies_ai", ::_id_F11F);
  level.player scripts\sp\utility::_id_65E0("threw_seeker");
  scripts\sp\utility::_id_16EB("seeker_hint", &"EUROPA_SEEKER_HINT", ::_id_F15C);
  precachestring(&"EUROPA_DBL_JUMP1");
  level.player scripts\sp\utility::_id_65E0("pressed_jump_once");
  level.player scripts\sp\utility::_id_65E0("pressed_jump_twice");
  var_0 = getEnt("office_breach_door", "targetname");
  var_1 = scripts\engine\utility::getStruct("office_cutdoor_base_position", "targetname");
  var_0.origin = var_1.origin;
  scripts\engine\utility::array_thread(getEntArray("posed_script_models", "targetname"), ::_id_D6A7);
  thread _id_94E6();
  scripts\engine\utility::trigger_off("takedown_color_moveup", "targetname");
  scripts\engine\utility::trigger_off("enter_airlock_color_move", "targetname");
  scripts\sp\utility::_id_22CA("back_office_enemies", ::_id_2726);
}

_id_56B2() {
  if(scripts\engine\utility::flag("player_crossed_chasm")) {
    return;
  }
  level.player _meth_8496(&"EUROPA_DBL_JUMP1");
  _id_137DC();
  wait 0.5;
  level.player _meth_8497();
}

_id_137DC() {
  level.player endon("doubleJumpBoostBegin");
  scripts\engine\utility::flag_wait("player_crossed_chasm");
}

_id_12B8F() {
  scripts\sp\maps\europa\europa_util::_id_107C5();
  thread scripts\sp\maps\europa\europa_util::_id_8E46(1);
  level.player scripts\sp\maps\europa\europa_util::_id_8E34(1);
  scripts\sp\maps\europa\europa_util::_id_EBC7();
  scripts\sp\utility::_id_F5AF("drop_landing_start", [level._id_EBBB, level._id_EBBC, level.player]);
  scripts\sp\utility::_id_15F5("squad_lands");
  thread scripts\sp\maps\europa\europa_util::_id_67B6(1, "current", &"EUROPA_OBJECTIVE_ACCESS", "entering_seeker_room");
}

_id_12B8C() {
  scripts\sp\utility::_id_2669("tunnels");
  level thread scripts\sp\maps\europa\europa_util::_id_5F7C(level._id_EBCA);
  level._id_EBBC thread _id_115FA();
  thread _id_1146A();
  thread _id_1351D();
  setsaveddvar("player_sprintspeedscale", 1.05);
  thread _id_CF8F();
  scripts\engine\utility::flag_wait("takedown_approach");
}

_id_6743() {
  level.player thread scripts\sp\maps\europa\europa_util::_id_12992();
  level.player scripts\engine\utility::delaythread(5, scripts\sp\maps\europa\europa_util::_id_12970);
}

_id_115FA() {
  self._id_C9BD = 1;

  while(self _meth_81A6())
    wait 0.05;

  wait 0.05;
  scripts\sp\utility::_id_F3B5("b");
  wait 7;
  self._id_C9BD = undefined;
}

_id_1351D() {
  level.player scripts\engine\utility::delaythread(0.15, scripts\sp\utility::_id_D091, "ges_point_firm", level._id_10214);
  var_0 = ["europa_plr_sipestakepoint"];
  scripts\engine\utility::delaythread(1.3, scripts\sp\utility::_id_15F5, "cliffjump_friendlies_clear");
  scripts\sp\maps\europa\europa_util::_id_48BD(var_0);
  scripts\engine\utility::flag_set("cliffjumper_vo_finished");
  wait 1.8;
  scripts\sp\maps\europa\europa_util::_id_D24C(["europa_plr_11toreapersetdefgun", "europa_rpr_copywillrelay"]);
  wait 1;
  wait 0.7;
  scripts\sp\maps\europa\europa_util::_id_134B7("europa_plr_letsgettotheweaponb");
}

_id_9287() {
  var_0 = getEnt("ice_fall_trig", "targetname");
  var_1 = 0;
  var_2 = var_0 scripts\engine\utility::get_target_ent();

  for(;;) {
    var_0 waittill("trigger", var_3);

    if(!var_1) {
      playFX(scripts\engine\utility::getfx("vfx_ice_fall_caves"), var_2.origin);
      var_1 = 1;
    }

    wait 1.5;
    return;
  }
}

_id_9288() {
  scripts\engine\utility::exploder("chunk_2");
}

_id_12B8D() {}

_id_1146B() {
  thread _id_1146A();
  scripts\sp\maps\europa\europa_util::_id_107C5();
  thread scripts\sp\maps\europa\europa_util::_id_8E46(1);
  level.player scripts\sp\maps\europa\europa_util::_id_8E34(1);
  scripts\sp\maps\europa\europa_util::_id_EBC7();
  scripts\sp\utility::_id_F5AF("c6_robot_pods_start", [level._id_EBBB, level._id_EBBC, level.player]);
  scripts\engine\utility::flag_set("takedown_approach");
  scripts\sp\utility::_id_15F5("c6_robot_event_color_move");
  level thread scripts\sp\maps\europa\europa_util::_id_5F7C(level._id_EBCA);
  thread scripts\sp\maps\europa\europa_util::_id_67B6(1, "current", &"EUROPA_OBJECTIVE_ACCESS", "entering_seeker_room");
}

_id_1145E() {
  thread _id_1351A();
  thread scripts\sp\utility::_id_6E7C("takedown_enemy_dead", ::_id_A781);
  scripts\engine\utility::flag_wait("base_arrive");
  thread scripts\sp\utility::_id_AB9A("player_sprintspeedscale", 1.4, 3);
}

_id_CF8F() {
  var_0 = scripts\engine\utility::getclosest(scripts\engine\utility::getStruct("platform_scene", "targetname").origin, level._id_EBCA, 99999);

  if(getdvarint("debug_europa"))
    thread scripts\sp\utility::_id_5B4D(var_0, level.player, 1, 0, 0, 20);

  var_0 thread scripts\sp\maps\europa\europa_util::_id_D2DC(250);
}

_id_1351A() {
  scripts\engine\utility::flag_wait("takedown_finished");
  scripts\sp\maps\europa\europa_util::_id_134B7("europa_sip_hesdown2");
  wait 1;
  scripts\sp\maps\europa\europa_util::_id_134B7("europa_plr_entrypoints30");
  wait 0.5;

  if(scripts\engine\utility::flag("base_arrive")) {
    scripts\engine\utility::flag_set("takedown_vo_complete");
    return;
  }

  var_0 = level.player scripts\sp\utility::_id_D08C("ges_radio");

  if(var_0) {
    level.player scripts\engine\utility::delaycall(0.5, ::playsound, "ges_plr_radio_on");
    level.player allowsprint(0);
    wait 0.8;
  }

  level.player scripts\sp\utility::play_sound_on_entity("europa_plr_reaperweareapp");
  wait 0.1;
  level.player scripts\sp\utility::play_sound_on_entity("europa_rpr_thermalisspotty");

  if(!scripts\engine\utility::flag("base_arrive"))
    level.player scripts\sp\utility::play_sound_on_entity("europa_plr_copy");

  if(var_0) {
    level.player playSound("ges_plr_radio_off");
    level.player stopgestureviewmodel("ges_radio", 1);
    level.player allowsprint(1);
  }

  scripts\engine\utility::flag_set("takedown_vo_complete");
}

_id_11462() {
  scripts\engine\utility::trigger_on("takedown_color_moveup", "targetname");
}

_id_1146A() {
  scripts\sp\utility::_id_22CA("takedown_enemy", ::_id_11466);
  var_0 = scripts\engine\utility::getStruct("takedown_struct", "targetname");
  var_0.enemy = scripts\sp\utility::_id_107EA("takedown_enemy", 1);
  var_0.enemy thread scripts\sp\maps\europa\europa_intro::_id_1081C();
  level._id_EBBC._id_1A29 = var_0.enemy scripts\engine\utility::spawn_tag_origin();
  level._id_EBBC._id_1A29 linkTo(var_0.enemy, "tag_origin", (0, 0, 20), (0, 0, 0));
  scripts\engine\utility::flag_wait("takedown_start");
  level._id_EBBB scripts\sp\utility::_id_61E7();
  level._id_EBBB._id_C9BD = undefined;
  var_0._id_7395 = level._id_EBBB;
  var_0._id_1684 = [var_0._id_7395, var_0.enemy];

  foreach(var_2 in var_0._id_1684) {
    var_2._id_1FBD = spawnStruct();
    var_2._id_1FBD.origin = var_0.origin;
    var_2._id_1FBD.angles = var_0.angles;
  }

  var_0._id_7395._id_1FBD scripts\sp\anim::_id_1F17(var_0._id_7395, "tunnel_takedown");

  if(level._id_EBBB scripts\sp\maps\europa\europa_util::_id_9B77()) {
    level thread _id_1145F(var_0);
    return;
  }

  scripts\sp\utility::_id_15F5("blue_covers_takedown");
  level._id_EBBC._id_C9BD = 1;
  level._id_EBBC scripts\sp\utility::_id_5514();
  level._id_EBBC thread _id_2BD4();
  var_4 = getanimlength(scripts\sp\utility::_id_7DC2("tunnel_takedown", "scar1"));
  var_0._id_7395 thread _id_11467(var_0);
  var_0.enemy thread _id_11465(var_0);

  foreach(var_2 in var_0._id_1684)
  var_2._id_1FBD thread scripts\sp\anim::_id_1F35(var_2, "tunnel_takedown");

  level._id_EBBB scripts\engine\utility::delaycall(1.0, ::playsound, "scn_europa_takedown_boost_npc");
  level.player scripts\engine\utility::delaycall(1.0, ::playsound, "scn_europa_takedown_boost_npc_amb");
  level waittill("interupt_check");

  if(!isDefined(var_0._id_9A92))
    wait 2;

  scripts\engine\utility::flag_set("takedown_finished");
  thread _id_7394();
  level.player scripts\sp\utility::_id_D2D1(190, 5);
}

_id_2BD4() {
  self.dontevershoot = 1;
  self _meth_82DE(level._id_EBBC._id_1A29, 1);
}

_id_11467(var_0) {
  level waittill("interupt_check");

  if(isDefined(var_0._id_9A92)) {
    var_0._id_7395 scripts\sp\maps\europa\europa_util::_id_10FC2();
    var_0._id_7395 scripts\sp\utility::_id_61C7();
  }
}

_id_11465(var_0) {
  self endon("cannot_interupt");

  for(;;) {
    self waittill("damage", var_1, var_2);

    if(isDefined(var_2) && var_2 == level.player) {
      var_0._id_9A92 = 1;
      self.allowdeath = 1;
      self _meth_81D0((0, 0, 0), level.player);
      return;
    }
  }
}

_id_7394() {
  level._id_EBBC clearentitytarget();
  level._id_EBBC._id_1A29 delete();
  level._id_EBBC.dontevershoot = undefined;
  scripts\engine\utility::trigger_on("takedown_color_moveup", "targetname");
  wait 0.05;
  scripts\sp\utility::_id_15F5("takedown_color_moveup");
  level._id_EBBC._id_C9BD = undefined;
  level._id_EBBB scripts\sp\utility::_id_61C7();
}

_id_11464() {
  thread scripts\sp\maps\europa\europa_util::_id_10FC2();
  self.maxsightdistsqrd = squared(8192);
  self.fixednode = 0;
  self.ignoreme = 0;
  self.ignoreall = 0;
  self.newenemyreactiondistsq = squared(512);
  self.allowdeath = 1;
  self.a._id_5605 = 0;
  self.allowpain = 1;
  self._id_28CF = 1;
  self._id_10265 = undefined;
}

_id_1145F(var_0) {
  thread scripts\sp\utility::_id_6E7C("takedown_enemy_dead", scripts\engine\utility::flag_set, "takedown_finished");
  level._id_EBBB._id_C9BD = undefined;
  level._id_EBBB scripts\sp\utility::_id_61C7();
  scripts\engine\utility::trigger_on("takedown_color_moveup", "targetname");
  var_0.enemy notify("takedown_aborted");
  var_0.enemy thread _id_4DFD();
  var_0.enemy thread _id_11460();
  var_0.enemy.maxsightdistsqrd = squared(8192);
  var_0.enemy.fixednode = 1;
  var_0.enemy.ignoreme = 0;
  var_0.enemy.ignoreall = 1;
  var_0.enemy.newenemyreactiondistsq = squared(512);
  var_0.enemy.allowdeath = 1;
  var_0.enemy.a._id_5605 = 0;
  var_0.enemy.allowpain = 1;
  var_0.enemy._id_28CF = 0;
  var_0.enemy._id_10265 = undefined;
  var_0.enemy thread scripts\sp\maps\europa\europa_util::_id_10FC2();
  var_0.enemy.target = "takedown_guy_abort_spot";
  var_0.enemy scripts\sp\utility::_id_51E1("casual_gun");
  var_0.enemy.health = 40;
  var_0.enemy.goalradius = 35;
  var_0.enemy thread scripts\sp\maps\europa\europa_util::_id_10F49();
  var_0.enemy thread _id_0B77::_id_8409();
  var_0.enemy waittill("stealthlight_attack");
  var_0.enemy stopsounds();
  wait 0.05;
  var_0.enemy playSound("stealth_sf0_enemyalerted");
  var_0.enemy notify("stop_going_to_node");
  var_0.enemy scripts\sp\utility::_id_F39C(level.player);
  var_0.enemy scripts\sp\utility::_id_4145();
  var_0.enemy setgoalpos(var_0.enemy.origin);
}

_id_4DFD() {
  scripts\engine\utility::flag_wait("base_arrive");

  if(isalive(self))
    scripts\sp\utility::_id_54C6();
}

_id_11460() {
  self endon("death");
  self endon("stealthlight_attack");
  self playSound("stealth_sf0_searchreport");
  wait 2;
  self playSound("stealth_sf0_confirmclear");
}

_id_11466() {
  self endon("death");
  self endon("takedown_aborted");
  scripts\sp\utility::_id_65E0("no_interupt");
  _id_19D9();
  self._id_1FBB = "takedown_enemy";
  scripts\sp\utility::_id_51E1("casual_gun");
  self._id_ED48 = "takedown_enemy_dead";
  thread _id_0B77::_id_1936();
  self.dropweapon = 0;
}

_id_19D9() {
  self.maxsightdistsqrd = 1;
  self.fixednode = 1;
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.newenemyreactiondistsq = 0;
  self.allowdeath = 0;
  self.a._id_5605 = 1;
  self.allowpain = 0;
  self._id_28CF = 0;
  self._id_10265 = 1;
  self.dropweapon = 0;
}

scale_accuracy_on_level(var_0) {
  var_1 = 1.0;

  switch (level._id_7683) {
    case 1:
    case 0:
      var_1 = 1.0;
      break;
    case 2:
      var_1 = 1.2;
      break;
    case 3:
    default:
      var_1 = 1.35;
      break;
  }

  self._id_2894 = var_1;
}

snipers_get_tough() {
  scale_accuracy_on_level(3.5);
  var_0 = [];
  var_0["prone"] = 400;
  var_0["crouch"] = 600;
  var_0["stand"] = 800;
  var_1 = [];
  var_1["prone"] = 1000;
  var_1["crouch"] = 2000;
  var_1["stand"] = 3000;
  _id_0F27::_id_F353(var_0, var_1);
  self _meth_84F7("attack", level.player, level.player.origin);
}

check_dead_count(var_0) {
  var_1 = 0;

  foreach(var_3 in var_0) {
    if(!isalive(var_3))
      var_1++;
  }

  return var_1;
}

wait_platform_guys_fight_started(var_0) {
  self endon("death");
  level endon("base_entrance_platform_enemies_dead");
  level endon("base_entrance_platform_enemies_engaged");
  level endon("squad_to_base_edge");

  for(;;) {
    if(check_dead_count(var_0) > 0) {
      scripts\engine\utility::flag_set("base_entrance_platform_enemies_engaged");
      return;
    }

    wait 0.1;
  }
}

wait_sniper_fight_started(var_0) {
  self endon("death");
  level endon("base_entrance_snipers_dead");
  level endon("base_entrance_snipers_engaged");

  for(;;) {
    if(check_dead_count(var_0) > 0) {
      scripts\engine\utility::flag_set("base_entrance_snipers_engaged");
      return;
    }

    wait 0.1;
  }
}

_id_A780() {
  scripts\sp\maps\europa\europa_util::_id_107C5();
  scripts\sp\maps\europa\europa_util::_id_EBC7();
  thread scripts\sp\maps\europa\europa_util::_id_8E46(1);
  level.player scripts\sp\maps\europa\europa_util::_id_8E34(1);
  scripts\sp\utility::_id_F5AF("lab_exterior_start", [level._id_EBBB, level._id_EBBC, level.player]);
  scripts\engine\utility::flag_set_delayed("takedown_vo_complete", 2);
  thread _id_A781();
  thread scripts\sp\maps\europa\europa_util::_id_67B6(1, "current", &"EUROPA_OBJECTIVE_ACCESS", "entering_seeker_room");
}

_id_A77D() {
  if(getdvarint("debug_europa"))
    iprintln("exploder le_clouds");

  level._id_A760 = getEnt("base_door", "targetname");
  level._id_A760 hide();
  scripts\sp\utility::_id_28D7("axis");
  scripts\engine\utility::exploder("le_clouds");
  var_0 = scripts\sp\vehicle::_id_1080C("entrance_dropship");
  thread _id_A77F();
  thread _id_28AD();
  scripts\engine\utility::flag_wait("base_arrive");
  thread scripts\sp\maps\europa\europa_util::_id_10181();
  var_0 playSound("scn_lab_reveal_dropship_takeoff");
  thread scripts\sp\vehicle_paths::_id_845A(var_0);
  var_0 thread _id_5EAE();
  setmusicstate("mx_135_base_reveal");

  if(getdvarint("debug_europa"))
    level._id_37CE = 1;

  _id_10F40();
  var_1 = scripts\sp\utility::_id_77DA("base_entrance_snipers");
  level._id_103BD = var_1;

  foreach(var_3 in var_1) {
    if(level._id_7683 > 1)
      var_3.health = 60;
    else
      var_3.health = 20;

    var_3._id_4E46 = ::_id_DC1B;
    var_3 _id_0F19::_id_F30D();
  }

  thread _id_134E5(var_1);
  thread scripts\sp\maps\europa\europa_util::_id_10690("base_entrance");
  thread _id_F156();
  thread scripts\sp\maps\europa\europa_util::_id_10F59(var_1, [level._id_EBBB, level._id_EBBC]);
  thread wait_sniper_fight_started(var_1);

  if(level._id_7683 > 1) {
    scripts\engine\utility::flag_wait("base_entrance_snipers_engaged");
    scripts\engine\utility::flag_wait_or_timeout("base_entrance_snipers_dead", 3);
  } else
    scripts\sp\utility::_id_13754(var_1);

  foreach(var_3 in level._id_EBCA) {
    var_3._id_C9BD = 1;
    var_3 scripts\sp\utility::_id_61E7();
  }

  if(!scripts\engine\utility::flag("base_entrance_platform_enemies_dead")) {
    if(level._id_7683 > 1) {
      var_7 = scripts\sp\utility::_id_77DA("base_entrance_platform_guys");
      thread wait_platform_guys_fight_started(var_7);
      scripts\engine\utility::flag_wait_or_timeout("base_entrance_platform_enemies_engaged", 3);
      scripts\engine\utility::flag_wait_or_timeout("base_entrance_platform_enemies_dead", 6);
    }

    scripts\sp\utility::_id_15F5("squad_to_base_edge");
  }

  scripts\engine\utility::flag_wait("base_entrance_platform_enemies_dead");
  scripts\engine\utility::trigger_on("base_entrnace_moveup", "targetname");
  scripts\engine\utility::trigger_on("friendlies_enter_lab", "targetname");
  scripts\engine\utility::flag_wait("lab_exterior_vo_finished");
  setsaveddvar("ai_linkWeightPerUserMin", 9);
  setsaveddvar("ai_linkWeightPerUserMax", 10);

  if(!scripts\engine\utility::flag("player_crossed_chasm"))
    scripts\sp\utility::_id_15F5("base_entrnace_moveup");

  _id_0F21::_id_F5B6(0);
  thread _id_B99F();
  scripts\engine\utility::delaythread(2, ::_id_56B2);
  scripts\engine\utility::flag_wait("entering_labs");
  setsaveddvar("ai_linkWeightPerUserMin", 0.2);
  setsaveddvar("ai_linkWeightPerUserMax", 0.4);

  foreach(var_3 in level._id_EBCA)
  var_3._id_C9BD = undefined;
}

_id_DC1B() {
  level thread _id_1B31();
  scripts\anim\shared::_id_5D1A();
  self _meth_839B("torso_upper", vectorNormalize(level.player.origin - self.origin + (0, 0, 60)) * 1000);
  wait 10;

  if(isDefined(self))
    self delete();
}

_id_1B31() {
  if(isDefined(level._id_1D54)) {
    return;
  }
  scripts\engine\utility::flag_set("base_entrance_snipers_engaged");
  level._id_1D54 = 1;
  var_0 = scripts\sp\utility::array_removedeadvehicles(level._id_103BD);

  foreach(var_2 in var_0)
  var_2 snipers_get_tough();
}

_id_A77F() {
  if(getdvarint("debug_europa"))
    iprintln("showing base_reveal_vista");

  scripts\sp\maps\europa\europa_util::toggle_cockpit_lights(1);
}

_id_10F40() {
  var_0 = [];
  var_0["prone"] = 1000;
  var_0["crouch"] = 1000;
  var_0["stand"] = 1000;
  var_1 = [];
  var_1["prone"] = 800;
  var_1["crouch"] = 1500;
  var_1["stand"] = 3000;
  _id_0F27::_id_F353(var_0, var_1);
  var_2["sight_dist"] = 5;
  var_2["detect_dist"] = 5;
  var_2["found_dist"] = 5;
  _id_0F19::_id_F30E(var_2);
}

_id_5EAE() {
  self endon("death");
  self._id_EF05 = 1;

  for(;;) {
    var_0 = self vehicle_getspeed() + 10;
    self vehicle_setspeed(var_0, var_0 * 0.8, var_0 * 0.2);
    wait 1;
  }
}

_id_28AD() {
  var_0 = spawnStruct();
  var_0._id_2857 = getEnt("base_entrance_platform", "targetname");
  var_0._id_B926 = getEntArray("base_entrance_platform_models", "targetname");
  var_0._id_5924 = 0;
  var_0.start = scripts\engine\utility::getStruct("platform_start", "targetname").origin;

  foreach(var_2 in var_0._id_B926)
  var_2 linkTo(var_0._id_2857);

  var_0.end = var_0._id_2857.origin;
  var_0._id_10CB8 = getnode("platform_traverse_start1", "script_noteworthy");
  var_0._id_62E2 = getnode("platform_traverse_end1", "script_noteworthy");
  var_0._id_10CB9 = getnode("platform_traverse_start2", "script_noteworthy");
  var_0._id_62E3 = getnode("platform_traverse_end2", "script_noteworthy");
  var_4 = [];

  while(!var_4.size) {
    var_4 = scripts\sp\utility::_id_77DA("base_entrance_platform_guys");
    wait 0.05;
  }

  thread _id_CC60();
  level._id_CC5B = var_0._id_2857;
  scripts\sp\maps\europa\europa_util::_id_10690("base_exterior");
  var_5 = 200;
  var_0._id_2857 dontinterpolate();
  var_0._id_2857.origin = var_0._id_2857.origin - (0, 0, var_5);
  _id_DC46();
  var_6 = 5;
  var_0._id_2857 playSound("scn_europa_lab_platform_rise");
  var_0._id_2857 movez(var_5, var_6, var_6 * 0.2, var_6 * 0.8);
  wait(var_6);
  var_0._id_5924 = 1;
  var_0._id_2857 _meth_80AF(undefined);
  createnavlink("platform1", var_0._id_10CB8.origin, var_0._id_62E2.origin, var_0._id_10CB8);
  createnavlink("platform2", var_0._id_10CB9.origin, var_0._id_62E3.origin, var_0._id_10CB9);
  scripts\engine\utility::exploder("basereveal_platform_fx");
}

_id_CC60() {
  wait 0.05;
  var_0 = scripts\sp\utility::_id_77DA("base_entrance_platform_guys");
  scripts\engine\utility::array_thread(var_0, _id_0F1C::_id_6837, 0);
}

_id_DC46() {
  var_0 = undefined;

  if(level._id_7683 > 1)
    var_0 = scripts\engine\utility::flag_wait_any_return("player_at_edge", "base_entrance_snipers_dead", "base_entrance_snipers_engaged");
  else
    var_0 = scripts\engine\utility::flag_wait_any_return("player_at_edge", "base_entrance_snipers_dead");

  scripts\engine\utility::flag_set("raise_platform");
  _id_10F42();
  var_1 = scripts\sp\utility::_id_77DA("base_entrance_platform_guys");
  var_1 = scripts\sp\utility::array_removedeadvehicles(var_1);

  foreach(var_3 in var_1) {
    var_3 _id_0F1C::_id_6837(1);
    var_3 thread _id_872B();
  }
}

_id_872B() {
  self endon("death");
  scripts\sp\utility::_id_5550();
  wait(randomfloat(2));
  self._id_10E6D._id_B470 = 1;
  self _meth_84F7("attack", level.player, level.player.origin);
  scripts\sp\utility::_id_50E4(randomfloat(0.8), ::_id_2527);
  self.health = 100;
  scale_accuracy_on_level(1.6);
}

_id_5775() {
  self endon("death");
  self.goalradius = 800;

  for(;;) {
    var_0 = self _meth_80E3();

    if(isDefined(var_0)) {
      self.goalradius = 32;
      self _meth_82EE(var_0);
      self waittill("goal");
      self.goalradius = 1000;
      return;
    }

    wait 2;
  }
}

_id_2527() {
  self._id_5951 = undefined;
  var_0 = clamp(5 - level._id_7683, 3, 5);
  wait(var_0);
  self.attackeraccuracy = 5;
}

_id_CC5E() {
  self endon("death");

  while(!self._id_10E6D.state)
    wait 0.05;

  wait(randomfloatrange(0.1, 0.3));
  scripts\sp\maps\europa\europa_util::_id_10FC2();
  self unlink();
}

_id_57B8() {
  if(scripts\engine\utility::flag("did_scope_hint")) {
    return;
  }
  level endon("player_did_alt_scope");
  var_0 = _id_137CE();

  if(!isDefined(var_0)) {
    scripts\engine\utility::flag_set("player_did_alt_scope");
    return;
  }

  childthread _id_387D(level.player getcurrentprimaryweapon());
  thread scripts\sp\maps\europa\europa_util::_id_134B7("europa_tee_closequarterschec");
  wait 1.5;

  if(level.console || level.player usinggamepad())
    scripts\sp\utility::_id_56BA("scope_both");
  else
    scripts\sp\utility::_id_56BA("scope_kb");

  scripts\engine\utility::flag_set("did_scope_hint");

  if(level._id_7683 < 2) {
    level.player scripts\sp\utility::_id_65E8("global_hint_in_use");
    wait 0.5;

    if(level.player scripts\sp\utility::_id_65DB("switched_weapon_during_tutorial")) {
      return;
    }
    thread scripts\sp\utility::_id_56BE("scope_test", 5);
  }

  level.player scripts\sp\utility::_id_65E8("global_hint_in_use");

  if(level.player scripts\sp\utility::_id_65DB("switched_weapon_during_tutorial")) {
    return;
  }
  scripts\engine\utility::flag_set("player_did_alt_scope");
}

_id_137CE() {
  level endon("scope_timeout");
  level thread scripts\sp\utility::_id_C12D("scope_timeout", 10);

  for(;;) {
    var_0 = level.player getcurrentprimaryweapon();
    var_1 = weaponaltweaponname(var_0);

    if(var_1 == "none") {
      wait 0.05;
      continue;
    }

    return 1;
  }
}

_id_387D(var_0) {
  while(level.player getcurrentprimaryweapon() == var_0)
    wait 0.05;

  level.player scripts\sp\utility::_id_65E1("switched_weapon_during_tutorial");
  scripts\engine\utility::flag_set("player_did_alt_scope");
}

_id_A77E() {
  scripts\engine\utility::trigger_on("base_entrnace_moveup", "targetname");
  scripts\engine\utility::trigger_on("friendlies_enter_lab", "targetname");
}

_id_A781() {
  scripts\engine\utility::array_thread([level._id_EBBB, level._id_EBBC], scripts\sp\utility::_id_F415, 1);
  scripts\engine\utility::array_thread([level._id_EBBB, level._id_EBBC], scripts\sp\utility::_id_F416, 1);
  scripts\engine\utility::flag_wait("raise_platform");
  scripts\engine\utility::array_thread([level._id_EBBB, level._id_EBBC], scripts\sp\utility::_id_F415, 0);
  scripts\engine\utility::array_thread([level._id_EBBB, level._id_EBBC], scripts\sp\utility::_id_F416, 0);
}

_id_F164() {
  return level.player scripts\sp\utility::_id_65DB("threw_seeker");
}

_id_134E5(var_0) {
  scripts\engine\utility::flag_wait("base_arrive");

  foreach(var_2 in level._id_EBCA) {
    var_2._id_C9BD = 1;
    var_2 scripts\sp\utility::_id_5514();
  }

  level._id_EBBB._id_C9BD = 1;
  level._id_EBBB scripts\sp\utility::_id_5514();
  scripts\engine\utility::flag_wait("takedown_vo_complete");
  scripts\sp\maps\europa\europa_util::_id_134B7("europa_tee_movementgetdown");
  _id_103B1(var_0);
  var_4 = _id_137EC(4);

  if(!scripts\engine\utility::flag("player_crossed_chasm") && !level.player scripts\sp\utility::_id_65DB("player_has_red_flashing_overlay")) {
    if(isDefined(var_4))
      scripts\sp\maps\europa\europa_util::_id_134B7("europa_plr_got3morecoming");
    else
      scripts\sp\maps\europa\europa_util::_id_134B7("europa_tee_targetsontheplatform");
  }

  scripts\engine\utility::flag_wait("base_entrance_platform_enemies_dead");
  wait 0.8;

  if(!scripts\engine\utility::flag("player_crossed_chasm")) {
    scripts\sp\maps\europa\europa_util::_id_134B7("europa_plr_pressup");
    wait 0.6;
  }

  scripts\engine\utility::flag_set("lab_exterior_vo_finished");

  if(scripts\engine\utility::flag("player_crossed_chasm")) {
    return;
  }
  wait 0.7;
  scripts\sp\maps\europa\europa_util::_id_134B7("europa_tee_deephole");
  scripts\engine\utility::flag_wait("player_crossed_chasm");
  var_5 = ["europa_sip_theyjustexecuted", "europa_tee_sdfwantsweaponsnot"];
  scripts\sp\maps\europa\europa_util::_id_48BD(var_5);
}

_id_103B1(var_0) {
  level endon("raise_platform");
  _id_6DD5(var_0);
  scripts\engine\utility::flag_wait("base_entrance_snipers_dead");
  wait 0.25;

  if(isDefined(level._id_4BC1) && isDefined(level._id_4BC1._id_10306)) {
    return;
  }
  scripts\sp\maps\europa\europa_util::_id_134B7("europa_sip_clear");
  wait 0.3;
  scripts\sp\maps\europa\europa_util::_id_134B7("europa_tee_allclear2");
  return;
}

_id_6DD5(var_0) {
  level endon("stealthtakedown_start");
  level endon("base_entrance_snipers_dead");
  var_1 = 4;
  var_2 = _id_7BB2(var_0, var_1);

  if(isDefined(var_2))
    var_3 = "europa_plr_sniperuptopseco";
  else
    var_3 = "europa_sip_sentriesontheroof";

  var_4 = "europa_tee_wolftakeone";

  if(!scripts\engine\utility::flag("player_crossed_chasm") && !level._id_4BC1._id_10D8F)
    scripts\sp\maps\europa\europa_util::_id_134B7(var_3);

  if(!scripts\engine\utility::flag("player_crossed_chasm") && !level._id_4BC1._id_10D8F)
    scripts\sp\maps\europa\europa_util::_id_134B7(var_4);

  var_5 = ["europa_tee_onyouboss", "europa_tee_quitdossinabout"];

  for(;;) {
    foreach(var_7 in var_5) {
      wait(randomintrange(9, 15));

      if(scripts\engine\utility::flag("player_crossed_chasm") || level._id_4BC1._id_10D8F) {
        return;
      }
      scripts\sp\maps\europa\europa_util::_id_134B7(var_7);
    }

    wait 0.05;
  }
}

_id_137EC(var_0) {
  if(scripts\engine\utility::flag("player_crossed_chasm"))
    return undefined;

  level endon("timeout");
  level thread scripts\sp\utility::_id_C12D("timeout", var_0);
  var_1 = scripts\sp\utility::_id_77DA("base_entrance_platform_guys");

  for(;;) {
    foreach(var_3 in var_1) {
      if(scripts\engine\utility::within_fov(level.player.origin, level.player getplayerangles(), var_3.origin, cos(40))) {
        if(_id_0B1D::_id_385C(level.player getEye(), var_3))
          return 1;
      }
    }

    wait 0.05;
  }
}

_id_7BB2(var_0, var_1) {
  level endon("player_target_timeout");
  level thread scripts\sp\utility::_id_C12D("player_target_timeout", var_1);

  for(;;) {
    foreach(var_3 in var_0) {
      if(scripts\sp\maps\europa\europa_util::_id_D35D(var_3))
        return 1;
    }

    wait 0.15;
  }
}

_id_517A(var_0) {
  var_0 endon("death");
  self waittill("death");
  wait 1;

  if(isDefined(var_0))
    var_0 delete();
}

_id_A770() {
  level._id_A760 = getEnt("base_door", "targetname");
  level._id_A760 hide();
  scripts\sp\maps\europa\europa_util::_id_107C5();
  thread scripts\sp\maps\europa\europa_util::_id_8E46(1);
  thread scripts\sp\maps\europa\europa_util::_id_5F7C(level._id_EBCA);
  thread _id_F156();
  scripts\sp\utility::_id_F5AF("breach_room_start", [level._id_EBBB, level._id_EBBC, level.player]);
  scripts\engine\utility::flag_set("scars_in_lab");
  thread scripts\sp\maps\europa\europa_util::_id_67B6(1, "current", &"EUROPA_OBJECTIVE_ACCESS", "entering_seeker_room");
}

_id_A76D() {
  scripts\sp\maps\europa\europa_util::_id_EBC7();
  thread _id_134E4();
  thread _id_A760();

  if(getdvarint("debug_europa"))
    level._id_37CE = 0;

  level._id_EBBB.ignoreall = 1;
  level._id_EBBC.ignoreall = 1;
  thread _id_6B7F();
  scripts\engine\utility::flag_wait("entering_labs");
  thread _id_9068();
  thread _id_13509();
  scripts\engine\utility::flag_wait("seeker_enemies_dead");
  level._id_EBBC._id_C9BD = undefined;
  scripts\engine\utility::flag_wait("squad_to_airlock");
  setsaveddvar("sm_roundrobinpriorityspotshadows", 8);
  _id_8463();
  scripts\engine\utility::flag_wait("airlock_ready");
}

_id_13509() {
  level endon("seeker_room_hot");
  var_0 = getEnt("seeker_room_vol", "targetname");
  var_1 = var_0 scripts\sp\utility::_id_77E3("axis");
  var_2 = scripts\engine\utility::array_randomize(var_1);
  var_2[1] scripts\sp\utility::_id_10347("europa_sf2_thereslockershe");
  wait 0.1;
  var_2[0] scripts\sp\utility::_id_10347("europa_sf1_complyrightaway");
  wait 1.5;
  var_2[2] scripts\sp\utility::_id_10347("europa_sf3_onlysatowouldle");
  var_2[1] scripts\sp\utility::_id_10347("europa_sf2_whatdoyouexpect");
  wait 1.7;
  var_2[1] scripts\sp\utility::_id_10347("europa_sf2_bringanythingof");
  wait 0.05;
  var_2[0] scripts\sp\utility::_id_10347("europa_sf1_confirmilldeliv");
  var_2[2] scripts\sp\utility::_id_10347("europa_sf3_thatsnotyourtas");
  wait 0.05;
  var_2[0] scripts\sp\utility::_id_10347("europa_sf1_itsnotyourtaske");
  wait 2.5;
  var_2[1] scripts\sp\utility::_id_10347("europa_sf2_keeplookingweve");
  var_2[2] scripts\sp\utility::_id_10347("europa_sf3_ithinktheresemp");
}

_id_A760() {
  var_0 = getEnt("patform_flag_trig", "targetname");
  scripts\engine\utility::flag_wait("scars_in_lab");
  scripts\engine\utility::flag_wait("entering_seeker_room");
  wait 1;
  var_1 = scripts\engine\utility::getStruct("base_door_closed", "targetname");

  while(!_id_3825(var_1))
    wait 0.05;

  level._id_A760.origin = var_1.origin;
  level._id_A760 show();
  setsuncolorandintensity(0);
  scripts\sp\utility::_id_2669("entrance");
}

_id_3825(var_0) {
  if(_id_CFB0(var_0))
    return 0;

  if(!var_0 scripts\sp\math::_id_9C85(level.player.origin))
    return 0;

  if(distance2dsquared(level.player.origin, var_0.origin) < squared(300))
    return 0;

  return 1;
}

_id_CFB0(var_0) {
  var_1 = 0.75;
  var_2 = vectorNormalize(var_0.origin - level.player getEye());
  var_3 = level.player getplayerangles();
  var_4 = anglesToForward(var_3);
  var_5 = 0;
  var_6 = vectordot(var_4, var_2);
  return var_6 >= var_1;
}

_id_B99F() {
  var_0 = getEnt("lab_entrance_trig", "targetname");
  var_1 = 0;
  var_2 = 0;

  for(;;) {
    if(level._id_EBBB istouching(var_0) && !var_1)
      var_1 = 1;

    if(level._id_EBBC istouching(var_0) && !var_2)
      var_2 = 1;

    if(var_1 && var_2) {
      wait 5;
      scripts\engine\utility::flag_set("scars_in_lab");
      return;
    }

    wait 0.4;
  }
}

_id_9068() {
  var_0 = level._id_EBBB;
  var_0 thread scripts\sp\utility::_id_7799(level.player, 2, 2);
  scripts\engine\utility::flag_wait("base_stairs_bottom");
  var_0 scripts\sp\utility::_id_61E7();
  var_0 scripts\sp\utility::_id_77B9(1.25);
  var_1 = scripts\engine\utility::getStruct("seeker_arrive_hold", "targetname");

  if(scripts\engine\utility::flag("entering_seeker_room")) {
    var_0 scripts\sp\utility::_id_61C7();
    return;
  }

  level._id_EBBC._id_C9BD = 1;
  var_1 scripts\sp\anim::_id_1F17(var_0, "hold_up");
  var_1 thread scripts\sp\anim::_id_1F35(var_0, "hold_up");
  wait 1;
  var_0 scripts\sp\utility::_id_61C7();
  var_0 scripts\sp\utility::_id_5514();
}

_id_6B7F() {
  scripts\engine\utility::array_thread(getEntArray("airlock_fan", "targetname"), ::_id_6B80);
}

_id_6B80() {
  self endon("death");
  var_0 = randomfloatrange(8, 16);

  for(;;) {
    self rotatepitch(360, var_0);
    wait(var_0);
  }
}

_id_134E4() {
  scripts\engine\utility::flag_wait("entering_seeker_room");
  _id_F158();
  scripts\engine\utility::flag_wait("seeker_enemies_dead");
  wait 1.6;
  var_0 = ["europa_tee_rightclear", "europa_sip_leftclear"];
  scripts\sp\maps\europa\europa_util::_id_48BD(var_0);
  thread scripts\sp\maps\europa\europa_util::_id_134B7("europa_plr_fanout");
  scripts\engine\utility::flag_set("squad_to_airlock");
  wait 1.5;
  scripts\sp\maps\europa\europa_util::_id_134B7("europa_sip_labsarethroughthis");
  wait 1.5;
  thread _id_57B8();
  scripts\engine\utility::flag_wait("airlock_closing");
  scripts\sp\maps\europa\europa_util::_id_134B7("europa_tee_thinktheyheardt");
  level._id_EBBB thread _id_1F8B();
  wait 2.35;
  scripts\sp\maps\europa\europa_util::_id_134B7("europa_tee_letsgivema");
  scripts\engine\utility::flag_set("airlock_ready");

  if(soundexists("europa_cmp_unsarecognized"))
    level.player scripts\engine\utility::play_sound_in_space("europa_cmp_unsarecognized", level.player getEye() + (0, 0, 45));
}

_id_F158() {
  level endon("seeker_room_hot");
  level thread scripts\sp\utility::_id_C12D("seeker_pullot", 1);
  scripts\sp\maps\europa\europa_util::_id_134B7("europa_sip_eyesonmultipletar");
  scripts\sp\maps\europa\europa_util::_id_134B7("europa_plr_timetogetwetse");
  scripts\sp\maps\europa\europa_util::_id_134B7("europa_sip_copythat");
}

_id_F156() {
  level._id_EF59 = 0;
  var_0 = scripts\engine\utility::getStructArray("rummage_scene", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2 thread _id_E7D3();
    wait 0.05;
  }

  scripts\engine\utility::flag_wait("entering_seeker_room");
  level.player.dontmelee = 1;
  thread scripts\sp\maps\europa\europa_util::_id_67B6(2, "current", &"EUROPA_OBJECTIVE_FSPAR", "tram_move");
  var_4 = getEnt("seeker_room_vol", "targetname");
  var_5 = var_4 scripts\sp\utility::_id_77E3("axis");
  var_6 = scripts\engine\utility::random(var_5).origin;
  thread _id_E6DA();
  _id_D2FC();

  if(level.player scripts\sp\utility::_id_65DB("threw_seeker")) {
    level._id_EBBB _id_875B();
    wait 0.5;
    level._id_EBBC _id_875B();
  } else {}

  scripts\sp\utility::_id_15F5("seekers_thrown");
  scripts\engine\utility::flag_wait("seeker_room_hot");
  var_4 = getEnt("seeker_axis_badplace", "targetname");
  var_7 = createnavobstaclebyent(var_4, "axis");

  if(getdvarint("debug_europa"))
    iprintln("seeker room hot");

  var_8 = "eu_enemy_incoming_" + randomintrange(1, 4);
  playworldsound(var_8, var_6);
  scripts\sp\utility::_id_28D8("axis");
  level._id_EBBB.ignoreall = 0;
  level._id_EBBC.ignoreall = 0;
  scripts\sp\utility::_id_13754(var_5);
  scripts\engine\utility::flag_set("seeker_enemies_dead");
  scripts\sp\utility::_id_28D7("axis");
  destroynavobstacle(var_7);
  level.player.dontmelee = undefined;

  if(getdvarint("debug_europa"))
    iprintln("clear");

  _id_2BCC();
  scripts\sp\utility::_id_10FEC("le_clouds");
  wait 2.5;
  scripts\sp\utility::_id_2669("airlock_go");
}

_id_D2FC() {
  var_0 = level._id_7683 < 2;
  level waittill("seeker_pullot");

  if(var_0) {
    setomnvar("ui_hud_ability_primary", 1);
    level.player giveandfireoffhand("seeker_autohold");
    level.player setweaponammostock("seeker_autohold", 1);
    level.player thread scripts\sp\utility::_id_56BA("seeker_hint");
  } else {
    level.player giveweapon("seeker");
    level.player thread scripts\sp\utility::_id_56BA("seeker_hint");
  }

  if(var_0)
    level.player giveweapon("seeker");

  level.player setweaponammostock("seeker", 4);
  setomnvar("ui_hud_ability_primary", 1);
  _id_137F3();

  if(var_0) {
    level.player takeweapon("seeker_autohold");

    if(level.player scripts\sp\utility::_id_65DB("threw_seeker"))
      level.player setweaponammostock("seeker", 3);
    else
      level.player setweaponammostock("seeker", 4);
  }

  wait 0.15;
}

_id_137F3() {
  thread _id_B992();
  level.player endon("threw_seeker");
  scripts\engine\utility::flag_wait("seeker_room_hot");
}

_id_B992() {
  level endon("seeker_enemies_dead");

  for(;;) {
    while(!level._id_F10A._id_1633.size)
      wait 0.05;

    foreach(var_1 in level._id_F10A._id_1633) {
      if(isDefined(var_1.owner) && var_1.owner == level.player) {
        level.player scripts\sp\utility::_id_65E1("threw_seeker");
        var_1 thread _id_F168();
        wait 0.05;
        return;
      }
    }

    wait 0.05;
  }
}

_id_F168() {
  self endon("death");

  while(!isDefined(self.bt._id_F15D) || self.bt._id_F15D == self.owner)
    wait 0.05;

  if(self.bt._id_F15D _meth_81A6()) {
    self.bt._id_F15D endon("death");

    while(distance2dsquared(self.origin, self.bt._id_F15D.origin) > squared(400))
      wait 0.05;

    self.bt._id_F15D._id_1FBD notify("stop_loop");
    self.bt._id_F15D scripts\sp\utility::anim_stopanimScripted();
    self.bt._id_F15D notify("seeker_attack");
    self.bt._id_F15D scripts\sp\maps\europa\europa_util::_id_1108E();
  }
}

_id_F15C() {
  return level.player scripts\sp\utility::_id_65DB("threw_seeker") || scripts\engine\utility::flag("seeker_enemies_dead");
}

_id_2BCC() {
  wait 2.5;

  foreach(var_1 in level._id_F10A._id_1633) {
    var_1 _id_0C25::_id_EA0E();
    wait 1;
  }
}

_id_875B() {
  level endon("seeker_room_hot");

  if(distance2dsquared(self.origin, level.player.origin) > squared(500)) {
    return;
  }
  _id_0A1E::_id_2307(::_id_11803);
}

#using_animtree("generic_human");

_id_11803() {
  self._id_C382 = self.grenadeweapon;
  self._id_C380 = self.grenadeammo;
  self.grenadeweapon = "seeker";
  self.grenadeammo = 1;
  thread _id_F131();
  self orientmode("face point", scripts\engine\utility::random(getaiarray("axis")).origin);
  wait 0.25;
  self clearanim(%body, 0.2);
  self _meth_82EA("exposed_throw_seeker", %hm_grnd_org_exposed_seeker_throw01, 1.0, 0.2, _id_0C6A::_id_6B9A());
  var_0 = "exposed_throw_seeker";
  thread _id_0A1E::_id_231F("soldier", var_0);
  var_1 = "seeker_grenade_folded";
  var_2 = undefined;
  var_3 = 0;
  var_4 = _id_0C6A::_id_810E("exposed_seeker_throw");

  while(!var_3) {
    self waittill(var_0, var_5);

    if(!isarray(var_5))
      var_5 = [var_5];

    foreach(var_7 in var_5) {
      if(var_7 == "attach_seeker") {
        if(isDefined(var_4))
          thread _id_0C6A::_id_57E0("tag_accessory_left", var_4);
        else
          _id_0C6A::_id_2481(var_0, var_1, "tag_accessory_left");

        self._id_9E33 = 1;
      }

      if(var_7 == "grenade_throw" || var_7 == "grenade throw") {
        var_8 = self gettagorigin("tag_accessory_left");
        var_9 = 400;
        var_10 = anglesToForward(self.angles);
        var_11 = anglestoup(self.angles);
        var_11 = var_11 * 0.6;
        var_12 = vectorNormalize(var_10 + var_11);
        var_13 = var_12 * var_9;
        var_2 = magicgrenademanual(self.grenadeweapon, var_8, var_13, 2);

        if(isDefined(var_2)) {
          if(self.grenadeammo > 0)
            self.grenadeammo--;

          self notify("grenade_fire", var_2, self.grenadeweapon);
        }

        if(isDefined(self._id_F174))
          self._id_F174 delete();

        var_3 = 1;
        continue;
      }

      if(var_7 == "end") {
        self._id_1652.player.numgrenadesinprogresstowardsplayer--;
        self notify("dont_reduce_giptp_on_killanimscript");
      }
    }
  }

  self.grenadeweapon = self._id_C382;
  self.grenadeammo = self._id_C380;
}

_id_F131() {
  while(!isDefined(self._id_F10A))
    wait 0.05;

  self._id_F10A.health = 3000;
  self._id_F10A thread scripts\sp\utility::_id_B14F();
}

_id_E7D3() {
  self endon("seeker_attack");
  var_0 = getspawner("rummage_spawner", "targetname");
  var_0.count = 1;
  var_1 = var_0 scripts\sp\utility::_id_10619(1);
  var_1._id_1FBB = "generic";
  var_2 = strtok(self.script_parameters, " ");
  var_1._id_1FBD = self;
  scripts\sp\anim::_id_1EC3(var_1, var_2[0]);
  var_1.health = 40;
  var_1._id_72CC = 2;
  var_1.grenadeammo = 0;
  scripts\engine\utility::flag_wait("entering_seeker_room");

  if(!isDefined(var_1) || !isalive(var_1)) {
    return;
  }
  var_1 thread _id_3D9C();
  var_1 thread scripts\sp\maps\europa\europa_util::_id_10F49();
  var_1._id_4E46 = ::_id_EF56;
  var_3 = 0;

  if(isarray(level._id_EC85[var_1._id_1FBB][var_2[0]]))
    var_3 = 1;

  if(var_3) {
    var_1 endon("death");
    thread scripts\sp\anim::_id_1EEA(var_1, var_2[0]);
    _id_1373B();
    self notify("stop_loop");

    if(getdvarint("debug_europa")) {}
  } else
    scripts\sp\anim::_id_1F35(var_1, var_2[0]);

  var_1 scripts\sp\anim::_id_1F35(var_1, var_2[1]);
  var_1 scripts\sp\maps\europa\europa_util::_id_1108E();
  scripts\engine\utility::flag_set("seeker_room_hot");

  if(!level.player scripts\sp\utility::_id_65DB("threw_seeker")) {
    var_1._id_2894 = var_1._id_2894 * 1.5;
    var_1.health = var_1.health + 110;
  }

  var_1 thread _id_5775();
}

_id_3D9C() {
  self endon("death");
  var_0 = "melee_seeker_attack_soldier_victim";

  for(;;) {
    if(scripts\asm\asm::asm_getcurrentstate(self.asmname) == var_0) {
      scripts\engine\utility::flag_set("seeker_attacked");
      return;
    }

    wait 0.1;
  }
}

_id_E6DA() {
  var_0 = 0.3;
  scripts\engine\utility::flag_wait("seeker_attacked");

  if(getdvarint("debug_europa"))
    iprintln("Seeker attacked - going hot");

  scripts\engine\utility::flag_set("seeker_room_hot");
}

_id_1373B() {
  level endon("seeker_room_hot");
  self waittill("stealthlight_attack");
}

_id_EF56() {
  scripts\engine\utility::flag_set("seeker_room_hot");

  if(level._id_EF59 == 3)
    return 0;

  self.ignoreme = 1;
  var_0 = 0;
  var_1 = getmovedelta(%hm_grnd_org_long_death_stand_trans_to_crawl, 0, 1);
  var_2 = self localtoworldcoords(var_1);
  var_0 = self maymovetopoint(var_2);

  if(var_0) {
    var_3 = getspawner("rummage_spawner", "targetname");
    var_3.count++;
    var_4 = var_3 scripts\sp\utility::_id_10619(1);

    if(scripts\sp\utility::_id_106ED(var_4)) {
      wait 0.05;
      var_4 = var_3 scripts\sp\utility::_id_10619(1);

      if(scripts\sp\utility::_id_106ED(var_4)) {
        level._id_EF59--;
        return 0;
      }
    }

    self._id_C012 = 1;
    level._id_EF59++;
    var_4 _id_AFDF();
    var_4 _meth_80F1(self.origin, self.angles, 10000);
    var_5 = spawnStruct();
    var_5.origin = self.origin;
    var_5.angles = self.angles;
    var_4 show();
    self delete();
    var_5 scripts\sp\anim::_id_1F35(var_4, "scripted_long_death_start", undefined, undefined, "generic");
    var_4 thread _id_EF58();
    var_4 thread _id_1CF6();
    var_4 _id_EF57();
    var_4 scripts\sp\anim::_id_1F35(var_4, "scripted_long_death_die", undefined, undefined, "generic");
    var_4._id_DC1A = 1;
    var_4 scripts\sp\utility::_id_1101B();
    var_4.allowdeath = 1;
    var_4.a.nodeath = 1;
    var_4 _meth_81D0();
    return 1;
  } else
    return 0;
}

_id_1CF6() {
  self endon("executed");

  for(;;) {
    foreach(var_1 in level._id_EBCA) {
      if(distance2d(self.origin, var_1.origin) < 325) {
        self.ignoreme = 0;
        return;
      }
    }

    wait 0.25;
  }
}

_id_AFDF() {
  self.dontmelee = 1;
  self._id_C012 = 1;
  self.ignoreall = 1;
  self.ignoreme = 1;
  thread scripts\sp\utility::_id_B14F();
  scripts\sp\utility::_id_86E4();
  scripts\sp\utility::_id_F2DA(0);
  self.allowdeath = 0;
  self.a.nodeath = 0;
  self hide();
}

_id_EF57() {
  self endon("executed");

  for(;;) {
    var_0 = getmovedelta(%hm_grnd_org_long_death_crawl01, 0, 1);
    var_1 = self localtoworldcoords(var_0);
    self._id_3898 = self maymovetopoint(var_1);

    if(!self._id_3898)
      self notify("executed");

    scripts\sp\anim::_id_1F35(self, "scripted_long_death_crawl", undefined, undefined, "generic");
  }
}

_id_EF58() {
  self endon("executed");

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(isDefined(var_1) && var_1 == level.player)
      self notify("executed");

    if(isDefined(var_1) && scripts\engine\utility::array_contains(level._id_EBCA, var_1)) {
      self.ignoreme = 1;
      self notify("executed");
    }
  }
}

_id_F11F() {
  self endon("death");
  self.fixednode = 1;
  self._id_72CC = 2;
  self._id_C061 = 1;
  self.health = 40;
  self.grenadeammo = 0;
  self.ignoreall = 1;
  scripts\engine\utility::flag_wait("entering_seeker_room");
  thread scripts\sp\maps\europa\europa_util::_id_10F49();
  thread _id_3D9C();
  thread _id_10FC3();
  self._id_4E46 = ::_id_EF56;
  scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "stealthlight_attack");
  scripts\sp\utility::_id_178D(scripts\engine\utility::flag_wait, "seeker_room_hot");
  scripts\sp\utility::_id_57D6();

  if(getdvarint("debug_europa")) {}

  scripts\engine\utility::flag_set("seeker_room_hot");
  scripts\sp\utility::_id_4145();
  self notify("stop_going_to_node");
  self.fixednode = 0;
  self.goalradius = 800;
  scripts\sp\maps\europa\europa_util::_id_1108E();

  if(!level.player scripts\sp\utility::_id_65DB("threw_seeker")) {
    self._id_2894 = self._id_2894 * 2;
    self.health = self.health + 110;
  }

  thread _id_5775();
}

_id_10FC3() {
  self waittill("damage");
  self _meth_83A1();
}

_id_8463() {
  var_0 = getEnt("lab_airlock_dynpath", "targetname");
  var_0 connectpaths();
  var_0 notsolid();
  scripts\engine\utility::trigger_on("enter_airlock_color_move", "targetname");
  wait 0.05;
  scripts\sp\utility::_id_15F5("enter_airlock_color_move");
  var_1 = scripts\engine\utility::getStruct("lab_airlock_scene", "targetname");

  foreach(var_3 in level._id_EBCA) {
    var_3._id_C9BD = 1;
    var_3 scripts\sp\utility::_id_5514();
  }

  var_5 = level._id_EBBC;
  var_1 scripts\sp\anim::_id_1F17(var_5, "lab_airlock_close_intro");
  var_1 scripts\sp\anim::_id_1F35(var_5, "lab_airlock_close_intro");
  var_1 thread scripts\sp\anim::_id_1EEA(var_5, "lab_airlock_close_idle");
  var_6 = getEnt("lab_entrance_door", "targetname");
  var_7 = getEnt("lab_entrance_airlock_trig", "targetname");
  var_8 = [level.player, level._id_EBBB];
  _id_1378A(var_7, var_8);
  scripts\sp\utility::_id_2669("in_airlock");
  scripts\engine\utility::array_call(getEntArray("airlock_fan", "targetname"), ::delete);
  var_9 = getcorpsearray();

  foreach(var_11 in var_9) {
    if(isDefined(var_11.origin)) {
      if(distance2dsquared(var_11.origin, var_1.origin) < squared(100))
        var_11 delete();
    }
  }

  var_13 = getEnt("lab_entrance_airlock_playerclip", "targetname");
  var_13 show();
  var_13 solid();
  var_14 = [var_5, var_6];
  level.player _meth_82C0("europa_airlock_room", 3.0);
  var_6 scripts\engine\utility::delaythread(1, scripts\sp\utility::play_sound_on_entity, "airlock_entry_door_close");
  var_1 notify("stop_loop");
  scripts\engine\utility::flag_set("airlock_closing");
  var_1 thread scripts\sp\anim::_id_1F2C(var_14, "lab_airlock_close");
  wait 4.9;
  var_5 scripts\sp\utility::_id_61C7();
  level.player playSound("airlock_pressurize_lr");
  setglobalsoundcontext("atmosphere", "", 3.0);

  foreach(var_3 in level._id_EBCA) {
    var_3._id_C9BD = undefined;
    var_3 scripts\sp\utility::_id_61E7();
  }

  var_17 = scripts\engine\utility::getStructArray("airlock_fx", "targetname");

  foreach(var_19 in var_17) {
    var_20 = undefined;

    if(isDefined(var_19.angles))
      var_20 = anglesToForward(var_19.angles);

    var_21 = 0;

    if(isDefined(var_19.script_delay))
      var_21 = var_19.script_delay;

    scripts\engine\utility::noself_delaycall(var_21, ::playfx, scripts\engine\utility::getfx(var_19.script_fxid), var_19.origin, var_20);
  }
}

_id_1AE2() {
  var_0 = getEntArray("europa_lights_airlock_green", "targetname");
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\europa\europa_util::_id_AC86);
  var_0 = getEntArray("europa_lights_airlock_red", "targetname");
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\europa\europa_util::_id_AC87, 30);
  var_1 = getEntArray("europa_lights_airlock_red2", "targetname");
  scripts\engine\utility::array_thread(var_1, scripts\sp\maps\europa\europa_util::_id_AC87, 7);
  scripts\engine\utility::flag_wait("airlock_closing");
  wait 6;
  var_2 = getscriptablearray("airlock_monitor", "targetname");
  scripts\sp\maps\europa\europa_util::_id_EF3F(var_2, "root", "0", "1");
  wait 0.5;
  scripts\sp\maps\europa\europa_util::_id_EF3F(var_2, "root", "1", "2");
  wait 0.5;
  scripts\sp\maps\europa\europa_util::_id_EF3F(var_2, "root", "2", "3");
  wait 0.5;
  scripts\sp\maps\europa\europa_util::_id_EF3F(var_2, "root", "3", "4");
  wait 0.5;
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\europa\europa_util::_id_AC87, 28);
  scripts\engine\utility::array_thread(var_1, scripts\sp\maps\europa\europa_util::_id_AC87, 7);
  scripts\sp\maps\europa\europa_util::_id_EF3F(var_2, "root", "4", "5");
  wait 0.5;
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\europa\europa_util::_id_AC87, 25);
  scripts\engine\utility::array_thread(var_1, scripts\sp\maps\europa\europa_util::_id_AC87, 7);
  scripts\sp\maps\europa\europa_util::_id_EF3F(var_2, "root", "5", "6");
  wait 0.5;
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\europa\europa_util::_id_AC87, 20);
  scripts\engine\utility::array_thread(var_1, scripts\sp\maps\europa\europa_util::_id_AC87, 6);
  scripts\sp\maps\europa\europa_util::_id_EF3F(var_2, "root", "6", "7");
  wait 0.5;
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\europa\europa_util::_id_AC87, 15);
  scripts\engine\utility::array_thread(var_1, scripts\sp\maps\europa\europa_util::_id_AC87, 5);
  scripts\sp\maps\europa\europa_util::_id_EF3F(var_2, "root", "7", "8");
  wait 0.5;
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\europa\europa_util::_id_AC87, 10);
  scripts\engine\utility::array_thread(var_1, scripts\sp\maps\europa\europa_util::_id_AC87, 3);
  scripts\sp\maps\europa\europa_util::_id_EF3F(var_2, "root", "8", "9");
  wait 0.5;
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\europa\europa_util::_id_AC87, 5);
  scripts\engine\utility::array_thread(var_1, scripts\sp\maps\europa\europa_util::_id_AC87, 1);
  scripts\sp\maps\europa\europa_util::_id_EF3F(var_2, "root", "9", "10");
  wait 0.5;
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\europa\europa_util::_id_AC87, 1);
  scripts\engine\utility::array_thread(var_1, scripts\sp\maps\europa\europa_util::_id_AC87, 0.5);
  scripts\sp\maps\europa\europa_util::_id_EF3F(var_2, "root", "10", "11");
  wait 0.5;
  scripts\sp\maps\europa\europa_util::_id_EF3F(var_2, "root", "11", "12");
  var_0 = getEntArray("europa_lights_airlock_red", "targetname");
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\europa\europa_util::_id_AC86);
  var_1 = getEntArray("europa_lights_airlock_red2", "targetname");
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\europa\europa_util::_id_AC86);
  var_0 = getEntArray("europa_lights_airlock_green", "targetname");
  scripts\engine\utility::array_thread(var_0, scripts\sp\maps\europa\europa_util::_id_AC87, 40);
}

_id_1AC0(var_0, var_1) {
  if(isDefined(var_0))
    wait(getanimlength(var_1 scripts\sp\utility::_id_7DC1(var_0)));
  else
    wait 6.0;

  level._id_1AB3 disconnectPaths();
  var_1 scripts\sp\utility::_id_61C7();
}

#using_animtree("script_model");

_id_94E6() {
  var_0 = getEnt("lab_entrance_door", "targetname");
  var_0 _meth_83D0(#animtree);
  var_0._id_1FBB = "door";
  var_0 thread scripts\sp\anim::_id_1EC3(var_0, "lab_airlock_close");
  var_1 = getEnt("lab_airlock_dynpath", "targetname");
  var_1 connectpaths();
  var_1 notsolid();
  createnavobstaclebyent(var_1, "allies");
  level._id_1AB3 = var_1;
  thread _id_1AE2();
}

_id_A76E() {
  scripts\engine\utility::trigger_on("enter_airlock_color_move", "targetname");
  level.player giveweapon("seeker");
  level.player setweaponammostock("seeker", 4);
}

_id_A746() {
  setsaveddvar("sm_roundrobinpriorityspotshadows", 8);
  scripts\sp\maps\europa\europa_util::_id_107C5();
  scripts\sp\maps\europa\europa_util::_id_6244(1);
  thread scripts\sp\maps\europa\europa_util::_id_8E46(1);
  level.player scripts\sp\maps\europa\europa_util::_id_8E34(1);
  scripts\sp\maps\europa\europa_util::_id_EBC7();
  scripts\engine\utility::flag_set("player_did_alt_scope");
  scripts\sp\utility::_id_F5AF("lab_airlock_start", [level._id_EBBB, level._id_EBBC, level.player]);
  wait 0.1;
  scripts\sp\utility::_id_15F5("enter_airlock_color_move");
  thread scripts\sp\maps\europa\europa_util::_id_67B6(1, "done", &"EUROPA_OBJECTIVE_ACCESS");
  thread scripts\sp\maps\europa\europa_util::_id_67B6(2, "current", &"EUROPA_OBJECTIVE_FSPAR", "tram_move");
}

_id_A744() {
  thread scripts\sp\maps\europa\europa_util::_id_10690("lab_airlock");

  if(isDefined(level._id_4074) && isDefined(level._id_4074["lab_exterior"]))
    scripts\sp\utility::_id_4074("lab_exterior");

  foreach(var_1 in level._id_EBCA) {
    var_1._id_C380 = var_1.grenadeammo;
    var_1.grenadeammo = 0;
    var_1.grenadeweapon = "none";
    var_1.grenadeawareness = 0;
  }

  scripts\sp\maps\europa\europa_util::_id_8E72("base_armory_vista_02");
  var_3 = getEntArray("base_reveal_vista", "targetname");
  scripts\engine\utility::array_call(var_3, ::hide);
  scripts\sp\utility::_id_22CA("locker_enemies", ::_id_AF07);
  thread _id_134E3();
  scripts\sp\maps\europa\europa_util::_id_13815("lab_entrance_airlock_trig");
  var_4 = scripts\engine\utility::getStructArray("locker_scenes", "script_noteworthy");
  var_5 = scripts\sp\utility::_id_22CD("locker_enemies", 1);
  thread _id_200E(var_5);
  var_6 = _id_F8BF();
  wait 1.5;
  scripts\engine\utility::flag_wait("player_did_alt_scope");

  if(scripts\sp\utility::_id_93A6())
    scripts\sp\specialist_MAYBE::_id_F53C(1);

  level.player thread _id_0E4B::_id_1348D();
  var_6._id_99F4 _id_0E46::_id_48C4();
  var_6._id_99F4 waittill("trigger");
  level.player _meth_80D1();
  level.player scripts\engine\utility::delaythread(1.55, scripts\sp\maps\europa\europa_util::_id_134B7, "europa_plr_antigravoutonmy");
  thread scripts\sp\maps\europa\europa_util::_id_8E46(0);
  level._id_EBBB thread _id_2014(var_4);
  level.player thread _id_2016(var_6);
  wait 0.4;
  level.player scripts\engine\utility::delaycall(4.2, ::_meth_82C0, "europa_post_airlock_hallway", 1.0);
  level.player scripts\engine\utility::delaycall(5.5, ::clearclienttriggeraudiozone, 3.0);
  var_6 thread scripts\sp\anim::_id_1F2C(var_6._id_1684, "antigrav_breach");
  var_6._id_99F4 _id_0E46::_id_DFE3();
  var_6._id_421F delete();
  var_6._id_4220 delete();
  thread scripts\sp\maps\europa\europa_util::_id_10690("lab_walk");
  scripts\engine\utility::flag_wait("antigrav_detonates");
  thread scripts\sp\utility::_id_6E7C("player_crossing_bridge", scripts\engine\utility::flag_set, "straggler_dead");

  foreach(var_1 in level._id_EBCA) {
    var_1._id_C9BD = undefined;
    var_1 scripts\sp\utility::_id_61E7();
  }

  thread _id_CD69();
  thread _id_EBCC();
  level.player _meth_80A1();
  scripts\sp\utility::_id_13753(var_5);
  scripts\engine\utility::flag_set("airlock_enemies_dead");
  scripts\engine\utility::array_thread(level._id_EBCA, scripts\sp\utility::_id_DC45, "raise");
  scripts\engine\utility::flag_wait("antigrav_clear");

  foreach(var_1 in level._id_EBCA) {
    var_1.grenadeammo = var_1._id_C380;
    var_1.grenadeweapon = "frag";
    var_1.grenadeawareness = 1;
  }

  scripts\sp\utility::_id_15F5("after_two_kill_color_move");
  var_11 = scripts\sp\utility::_id_107EA("locker_enemy_guard");

  if(isDefined(var_11)) {
    scripts\engine\utility::array_thread(level._id_EBCA, scripts\sp\utility::_id_5564);
    var_11 thread _id_110DA();
    var_11 thread _id_54C1();
    var_11.health = 50;
    var_11.attackeraccuracy = 10;
    var_11._id_4E46 = ::_id_4E31;
    var_11.ignoreme = 1;
    var_11.grenadeammo = 0;
    var_11 scripts\engine\utility::delaythread(2, scripts\sp\utility::_id_F416, 0);
  } else
    scripts\engine\utility::flag_set("straggler_dead");
}

_id_110DA() {
  self endon("death");
  wait 1;
  self playSound("europa_sf0_needbackupmylocation");
}

_id_18EA() {
  if(!isDefined(self)) {
    return;
  }
  self.health = 20;
  self endon("death");
  scripts\engine\utility::delaythread(6.5, scripts\sp\utility::_id_54C6);
}

_id_CD69() {
  var_0 = spawn("script_origin", level.player.origin);
  wait 0.05;
  var_0 playLoopSound("emt_euro_alarm_lp");
  scripts\engine\utility::flag_wait("selfdestruct_start");
  var_0 stoploopsound("");
  wait 0.05;
  var_0 delete();
}

_id_4E31() {
  scripts\engine\utility::array_thread(level._id_EBCA, scripts\sp\utility::_id_6224);

  if(isDefined(self._id_D417))
    var_0 = ["europa_plr_hesdown", "europa_plr_watchyourcorners"];
  else
    var_0 = ["europa_plr_watchyourcorners"];

  scripts\engine\utility::flag_set("straggler_dead");
  level scripts\engine\utility::delaythread(1.1, scripts\sp\maps\europa\europa_util::_id_48BD, var_0);
  return 0;
}

_id_54C1() {
  self endon("death");

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(isDefined(var_1) && var_1 == level.player)
      self._id_D417 = 1;

    return;
  }
}

_id_134E3() {
  if(!scripts\sp\utility::_id_9BB5())
    wait 0.5;

  scripts\engine\utility::flag_wait("airlock_enemies_dead");
  wait 0.7;
  scripts\sp\maps\europa\europa_util::_id_134B7("europa_plr_theyredown");
  scripts\engine\utility::flag_wait("antigrav_clear");
  scripts\sp\maps\europa\europa_util::_id_134B7("europa_tee_movingup");
}

_id_1F8B() {
  wait 0.1;
  var_0 = scripts\sp\utility::_id_10639("fhr40", self.origin - (0, 0, 100), self.angles);
  var_1 = getanimlength(scripts\sp\utility::_id_7DC2("airlock_response", self._id_1FBB));
  var_0 scripts\engine\utility::delaycall(var_1, ::delete);
  scripts\sp\anim::_id_1F2C([self, var_0], "airlock_response");
}

_id_EBCC() {
  level._id_EBBB.dontevershoot = 1;
  level._id_EBBC.dontevershoot = 1;
  wait 2;
  level._id_EBBB.dontevershoot = undefined;
  level._id_EBBC.dontevershoot = undefined;
}

_id_2016(var_0) {
  var_1 = 0.4;
  level.player thread scripts\sp\maps\europa\europa_util::_id_D85C();
  level.player _meth_823C(var_0._id_D267, "tag_player", var_1);
  var_0._id_D267 scripts\engine\utility::delaycall(var_1, ::show);
  level.player scripts\engine\utility::delaycall(var_1, ::playerlinktodelta, var_0._id_D267, "tag_player", 1, 1, 1, 1, 1, 1);
  level.player scripts\engine\utility::delaycall(var_1 + 0.05, ::lerpviewangleclamp, 2, 0.1, 1, 10, 10, 10, 0);
  wait(var_0._id_1FB8);
  level.player unlink(1);
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player _meth_84FD();
  level.player scripts\sp\maps\europa\europa_util::_id_8E34(0);
  level.player scripts\sp\maps\europa\europa_util::_id_13013(0, 1);
  level.player enableweapons();
  var_0._id_D267 delete();
}

_id_2014(var_0) {
  level waittill("grenade_appear");
  var_1 = spawn("script_model", self gettagorigin("tag_accessory_left"));
  var_1.angles = self gettagangles("tag_accessory_left");
  var_1 linkTo(self, "tag_accessory_left");
  var_1 setModel("anti_grav_grenade_wm");
  level waittill("grenade_toss");
  var_1 delete();
  var_2 = self gettagorigin("tag_accessory_left") + (0, 0, 5);
  var_3 = [];

  foreach(var_5 in var_0)
  var_3[var_3.size] = var_5.origin;

  var_7 = scripts\engine\utility::getStruct("locker_loop3", "targetname").origin;
  var_8 = var_7 - var_2;
  var_9 = magicgrenademanual("antigrav", var_2, var_8 * 10, 4);
  scripts\engine\utility::flag_wait("door_kick");
  var_10 = getnode("middle_locker_guy", "targetname");
  wait 0.65;
  var_11 = magicgrenade("antigrav", var_10.origin, var_10.origin, 20, 0);
  thread _id_0E21::_id_2013(var_11);
  var_9 delete();

  while(isDefined(var_11))
    wait 0.05;

  var_5 = scripts\engine\utility::getStruct("antigrav_react3", "targetname");
  playFX(scripts\engine\utility::getfx("ag_extra"), var_5.origin);
  scripts\engine\utility::flag_set("antigrav_detonates");
  thread scripts\engine\utility::flag_set_delayed("antigrav_clear", 7);
  thread _id_2019();
}

_id_2019() {
  if(level.player scripts\sp\utility::_id_65DF("player_gravity_off") && level.player scripts\sp\utility::_id_65DB("player_gravity_off")) {
    return;
  }
  playworldsound("slomo_whoosh", level.player.origin);
  wait 0.85;
  level._id_1031B._id_1098F = 0.55;
  scripts\sp\utility::_id_10321();
  wait 0.65;
  scripts\sp\utility::_id_10322();
}

_id_F8BF() {
  var_0 = scripts\engine\utility::getStruct("antigrav_node", "targetname");
  var_0._id_421F = getEnt("antigrav_breach_clip_outer", "targetname");
  var_0._id_4220 = getEnt("antigrav_breach_clip_inner", "targetname");
  var_0._id_99F4 = scripts\engine\utility::getStruct("antigrav_interact", "targetname");
  var_0._id_5978 = getEnt("antigrav_breach_door", "targetname");
  var_0._id_598A = scripts\engine\utility::getStruct("door_collision_marker", "targetname");
  var_0._id_5978._id_1FBB = "antigrav_door";
  var_0._id_5978 _meth_83D0(#animtree);
  _id_CF55(var_0);
  var_0._id_421F linkTo(var_0._id_5978);
  var_0._id_4220 linkTo(var_0._id_5978);
  var_0._id_1684 = [var_0._id_D267, level._id_EBBB, var_0._id_5978];
  return var_0;
}

#using_animtree("player");

_id_CF55(var_0) {
  var_0._id_D267 = scripts\sp\utility::_id_10639("player_rig", var_0.origin);
  var_0 scripts\sp\anim::_id_1EC3(var_0._id_D267, "antigrav_breach");
  var_0._id_D267 hide();
  var_0._id_1FB8 = getanimlength(%europa_airlock_plr_grav_grenade_scene);
}

_id_200E(var_0) {
  var_1 = scripts\engine\utility::getStructArray("antigrav_react", "script_noteworthy");

  foreach(var_4, var_3 in var_1)
  var_0[var_4] thread _id_2018(var_3);
}

_id_2018(var_0) {
  self endon("death");
  self._id_1FBB = "generic";
  var_0 thread scripts\sp\anim::_id_1EC3(self, var_0.animation);
  scripts\engine\utility::flag_wait("door_ajar");
  self.ignoreall = 0;
  self.dontevershoot = undefined;
  scripts\engine\utility::delaycall(randomfloatrange(0.55, 1), ::playsound, "stealth_sf" + randomintrange(0, 4) + "_enemyalerted", self.origin);
  scripts\engine\utility::flag_wait("door_kick");
  var_0 thread scripts\sp\anim::_id_1F35(self, var_0.animation);
  scripts\engine\utility::flag_wait("antigrav_detonates");
  wait 0.3;
  self _meth_83A1();
  self.ignoreme = 0;
  self._id_2894 = 1;
}

_id_AF07() {
  self endon("death");
  self.grenadeawareness = 0;
  self._id_4E46 = ::_id_4C9B;
  self.ignoreme = 1;
  self.dontevershoot = 1;
  self._id_2894 = 0.01;
}

_id_4C9B() {
  var_0 = self.origin;
  var_1 = "generic_death_enemy_" + randomintrange(1, 7);
  level thread scripts\engine\utility::play_sound_in_space(var_1, var_0);
  return 0;
}

_id_1378A(var_0, var_1) {
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

_id_A76F() {
  thread _id_A765();
  var_0 = getEntArray("labs_entrance_lights", "targetname");
  var_0 = sortbydistance(var_0, level.player.origin);
  var_0 = scripts\engine\utility::array_reverse(var_0);

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1] setlightintensity(0);
    wait(randomfloatrange(0, 0.2));
  }

  var_2 = getEntArray("labs_entrance_screens", "targetname");

  foreach(var_4 in var_2) {
    var_5 = randomfloatrange(0, 0.8);
    var_4 scripts\engine\utility::delaycall(var_5, ::delete);
  }

  wait 3;
  var_7 = getEntArray("labs_entrance_light_models", "targetname");
  var_7 = sortbydistance(var_7, level.player.origin);
  var_8 = [];

  foreach(var_10 in var_7) {
    var_11 = var_10.script_index;

    if(!isDefined(var_8[var_11]))
      var_8[var_11] = [];

    var_8[var_11] = scripts\engine\utility::array_add(var_8[var_11], var_10);
  }

  for(var_1 = 0; var_1 < var_8.size; var_1++) {
    foreach(var_14 in var_8[var_1]) {
      var_14 setModel("crr_light_overhead_01_off");
      var_14 thread scripts\sp\utility::play_sound_on_entity("lab_light_off");

      if(isDefined(var_14.target)) {
        var_10 = getEnt(var_14.target, "targetname");
        var_10 setlightintensity(0);
      }
    }

    wait 0.4;
  }
}

_id_A765() {
  var_0 = scripts\engine\utility::getStructArray("lab_emergency_light", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3 scripts\engine\utility::spawn_tag_origin();
    var_1[var_1.size] = var_4;
  }

  while(!scripts\engine\utility::flag("armory_lights_on")) {
    wait 1;

    foreach(var_4 in var_1)
    playFXOnTag(scripts\engine\utility::getfx("vfx_light_emergency_flicker"), var_4, "tag_origin");
  }

  scripts\engine\utility::flag_wait("armory_lights_on");
  scripts\sp\utility::_id_228A(var_1);
}

_id_A745() {
  if(scripts\sp\utility::_id_93A6())
    scripts\sp\specialist_MAYBE::_id_F53C(1);

  level.player thread scripts\sp\utility::_id_DC45("raise");
  scripts\engine\utility::array_call(getEntArray("airlock_fan", "targetname"), ::delete);
  scripts\sp\maps\europa\europa_util::_id_8E72("base_armory_vista_02");
  var_0 = getEntArray("base_reveal_vista", "targetname");
  scripts\engine\utility::array_call(var_0, ::hide);
}

_id_A797() {
  scripts\sp\maps\europa\europa_util::_id_107C5();
  scripts\engine\utility::delaythread(0.6, scripts\sp\maps\europa\europa_util::_id_10690, "lab_airlock");
  scripts\engine\utility::array_thread(level._id_EBCA, scripts\sp\utility::_id_DC45, "raise");
  thread scripts\sp\maps\europa\europa_util::_id_5F7C(level._id_EBCA);
  scripts\sp\maps\europa\europa_util::_id_EBC7();
  scripts\sp\utility::_id_F5AF("lab_walk_start", [level._id_EBBB, level._id_EBBC, level.player]);
  scripts\sp\utility::_id_15F5("after_two_kill_color_move");
  thread scripts\sp\maps\europa\europa_util::_id_67B6(1, "done", &"EUROPA_OBJECTIVE_ACCESS");
  thread scripts\sp\maps\europa\europa_util::_id_67B6(2, "current", &"EUROPA_OBJECTIVE_FSPAR", "tram_move");
  scripts\engine\utility::flag_set("straggler_dead");
}

_id_A793() {
  var_0 = getscriptablearray("monitors", "targetname");
  scripts\sp\maps\europa\europa_util::_id_EF3F(var_0, "part", "healthy", "healthy_blue");
  thread _id_13DA2();
  thread _id_134E8();
  scripts\sp\utility::_id_2669("lab_walk");
  scripts\engine\utility::flag_wait("scars_spawned");
  scripts\engine\utility::flag_wait("player_enters_glass_bridge");
  level._id_EBBC thread _id_26AA();
  scripts\engine\utility::flag_wait("straggler_dead");
  scripts\engine\utility::array_thread(level._id_EBCA, scripts\sp\utility::_id_F415, 1);
  _id_10F41();

  if(scripts\sp\utility::_id_93A6())
    thread scripts\sp\specialist_MAYBE::_id_2683();

  scripts\engine\utility::flag_wait("lab_walk_end");
}

_id_13DA2() {
  var_0 = getEnt("window_c12", "targetname");
  var_0 _id_D6A7();
  scripts\sp\utility::_id_16AE(var_0, "office_fight");
}

_id_10F41() {
  var_0 = [];
  var_0["prone"] = 200;
  var_0["crouch"] = 400;
  var_0["stand"] = 550;
  var_1 = [];
  var_1["prone"] = 800;
  var_1["crouch"] = 1500;
  var_1["stand"] = 3000;
  _id_0F27::_id_F353(var_0, var_1);
}

_id_26AA() {
  scripts\sp\utility::_id_54F7();
  self.target = "office_long_way";
  _id_0B77::_id_8409();
  scripts\sp\utility::_id_61C7();
}

_id_11601() {
  scripts\engine\utility::flag_wait("player_enters_glass_bridge");
  wait 1;
  scripts\engine\utility::play_sound_in_space("SD_2_order_action_coverme", getspawner("bridgerunners", "targetname").origin);
  playworldsound("SD_0_resp_ack_co_gnrc_affirm", getspawner("bridgerunners", "targetname").origin);
}

_id_134E8() {
  scripts\engine\utility::flag_wait("straggler_dead");
  scripts\engine\utility::flag_wait("player_enters_glass_bridge");
  level.player scripts\sp\utility::_id_D090("ges_radio");
  level.player scripts\sp\utility::_id_D2D1(140, 0.5);
  level.player allowsprint(0);
  _id_C806();
  level.player stopgestureviewmodel("ges_radio", 1);
  level.player allowsprint(1);
  level.player scripts\sp\utility::_id_D2D1(190, 3);
  wait 1;

  if(scripts\engine\utility::flag("entering_c12_research_room")) {
    return;
  }
  var_0 = ["europa_tee_eyesonresearchro", "europa_sip_armoryshouldben", "europa_plr_thatsourtarget"];
  scripts\sp\maps\europa\europa_util::_id_48BD(var_0, "entering_c12_research_room");
}

_id_30CF() {
  self endon("death");

  if(scripts\engine\utility::cointoss())
    scripts\sp\utility::_id_51E1("frantic");
  else
    scripts\sp\utility::_id_51E1("sprint");

  self.health = 40;
  self._id_4E46 = ::_id_30CD;

  if(!isDefined(level._id_30CE)) {
    level._id_30CE = self;
    self.ignoreme = 1;
    level waittill("bridgerunner_down");
    wait 2.7;
    self.ignoreme = 0;
  } else {
    self.ignoreme = 1;
    wait 2.7;
    self.ignoreme = 0;
  }
}

_id_30CD() {
  level notify("bridgerunner_down");
  return 0;
}

_id_E1C7() {
  scripts\sp\maps\europa\europa_util::_id_107C5();
  _id_10F41();
  thread scripts\sp\maps\europa\europa_util::_id_5F7C(level._id_EBCA);
  scripts\engine\utility::array_thread(level._id_EBCA, scripts\sp\utility::_id_DC45, "raise");
  scripts\sp\maps\europa\europa_util::_id_EBC7();
  scripts\sp\utility::_id_F5AF("research_start", [level._id_EBBB, level._id_EBBC, level.player]);
  scripts\engine\utility::array_thread(level._id_EBCA, scripts\sp\utility::_id_F415, 1);
  thread _id_13DA2();
  thread scripts\sp\maps\europa\europa_util::_id_67B6(1, "done", &"EUROPA_OBJECTIVE_ACCESS");
  thread scripts\sp\maps\europa\europa_util::_id_67B6(2, "current", &"EUROPA_OBJECTIVE_FSPAR", "tram_move");
}

_id_E1C3() {
  scripts\sp\utility::_id_2669("research");
  thread _id_13500();
  thread scripts\sp\maps\europa\europa_util::_id_10690("office_fight");
  level._id_F10A._id_4C74 = ::_id_F167;
  var_0 = scripts\engine\utility::getStruct("wonder_room_walk1", "targetname");
  thread _id_83FA();
  thread _id_1B2F();
  thread vo_ambient_sdf_research_room();
  scripts\engine\utility::flag_wait("stealth_spotted");
  level._id_EBBB._id_C062 = undefined;
  level._id_EBBC._id_C062 = undefined;
  scripts\sp\utility::_id_15F5("spawn_back_office_enemies");
  scripts\engine\utility::flag_set("office_fight_started");
}

vo_ambient_sdf_research_room() {
  level endon("research_enemies_alerted");
  level endon("office_hot");
  var_0 = ["titan_sf1_enemycontact", "titan_sf2_confirmthatlast", "titan_sf3_prisoner627", "titan_sf4_awaitingorders", "titan_sf1_sectorsweeping", "titan_sf2_statusupdate", "titan_sf2_shootonsight", "titan_sf3_hqrevising"];
  wait 2;
  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = _id_0F27::_id_79F5("office_door_guards");

  for(;;) {
    foreach(var_3 in var_0) {
      if(scripts\engine\utility::flag("office_hot")) {
        return;
      }
      playworldsound(var_3, scripts\engine\utility::random(var_1).origin);
      wait(randomintrange(8, 10));
    }

    wait 0.05;
  }
}

_id_1B2F() {
  wait 1;
  var_0 = _id_0F27::_id_79F5("office_door_guards");
  scripts\engine\utility::array_thread(var_0, ::_id_1374F);
  level waittill("research_enemies_alerted");
  scripts\engine\utility::array_call(var_0, ::_meth_84F7, "attack", level.player, level.player.origin);
}

_id_F167() {
  self endon("death");

  while(!isDefined(self.bt._id_F15D) || self.bt._id_F15D == self.owner)
    wait 0.05;

  self.bt._id_F15D endon("death");

  while(distance2dsquared(self.origin, self.bt._id_F15D.origin) > squared(450))
    wait 0.05;

  self.bt._id_F15D._id_5951 = undefined;

  if(self.bt._id_F15D _meth_81A6())
    self.bt._id_F15D _meth_83A1();

  self.bt._id_F15D _meth_84F7("attack", self, self.origin);
  level notify("research_enemies_alerted");
}

_id_1374F() {
  level endon("research_enemies_alerted");
  self waittill("damage");
  level notify("research_enemies_alerted");
}

_id_83FA() {
  thread _id_26E5();
  scripts\engine\utility::flag_wait_any("office_hot", "axis_close");
  _id_10F42();
  scripts\engine\utility::array_thread(level._id_EBCA, scripts\sp\utility::_id_F415, 0);
  scripts\engine\utility::array_thread(level._id_EBCA, scripts\sp\utility::_id_F416, 0);
}

_id_26E5() {
  var_0 = getEnt("axis_close", "targetname");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isDefined(var_1)) {
      var_1._id_5951 = undefined;

      foreach(var_3 in level._id_EBCA)
      var_3 scripts\sp\utility::_id_F39C(var_1);
    }
  }
}

_id_10F42() {
  var_0 = [];
  var_0["prone"] = 8000;
  var_0["crouch"] = 8000;
  var_0["stand"] = 8000;
  _id_0F27::_id_F353(var_0);
}

_id_13DA3(var_0) {
  level endon("office_fight_started");
  var_0 scripts\sp\anim::_id_1F17(self, "wonder_room_walk");
  var_0 scripts\sp\anim::_id_1F35(self, "wonder_room_walk");
  scripts\sp\utility::_id_61C7();
}

_id_E1C4() {
  level._id_EBBB._id_C062 = undefined;
  level._id_EBBC._id_C062 = undefined;
}

_id_13500() {
  scripts\engine\utility::flag_wait("player_at_c12");

  if(!scripts\engine\utility::flag("office_fight_started"))
    scripts\sp\maps\europa\europa_util::_id_134B7("europa_tee_contact2");
}

_id_C806() {
  level endon("office_fight_started");
  level.player playSound("ges_plr_radio_on");
  wait 0.2;
  scripts\sp\maps\europa\europa_util::_id_134B7("europa_plr_reaperthisis11werein");
  wait 0.05;
  scripts\sp\maps\europa\europa_util::_id_134B7("europa_rpr_copybeadvisedsdf");
  wait 0.05;
  scripts\sp\maps\europa\europa_util::_id_134B7("europa_rpr_oncetheweaponis");
  scripts\sp\maps\europa\europa_util::_id_134B7("europa_plr_copy");
  level.player playSound("ges_plr_radio_off");
}

_id_62D7(var_0, var_1) {
  level endon("player_enters_c12_labs");

  if(isalive(var_0))
    var_0 scripts\sp\utility::play_sound_on_entity("europa_sf1_whyisthatdoorno");

  if(isalive(var_1[0]))
    var_1[0] scripts\sp\utility::play_sound_on_entity("europa_sf3_sireverythingsfro");

  if(isalive(var_0))
    var_0 scripts\sp\utility::play_sound_on_entity("europa_sf1_whyisthatdoorno");

  if(isalive(var_1[0]))
    var_0 scripts\sp\utility::play_sound_on_entity("europa_sf1_iwanteverythingo");
}

_id_E40D() {
  var_0 = [level._id_10214, level._id_113AD];

  foreach(var_2 in var_0) {
    wait(randomfloatrange(1, 3));
    self.grenadeweapon = "seeker";
    self.grenadeammo = 1;
  }
}

_id_19CD() {
  scripts\sp\utility::_id_51E1("casual_gun");
}

_id_19CC() {
  scripts\sp\utility::_id_51E1("casual");
}

_id_A794() {
  setsaveddvar("sm_roundrobinpriorityspotshadows", 6);
}

_id_A788() {
  scripts\sp\maps\europa\europa_util::_id_107C5();
  scripts\sp\utility::_id_15F5("wonder_room_patroller_spawn");
  _id_10F42();
  scripts\engine\utility::array_thread(level._id_EBCA, scripts\sp\utility::_id_DC45, "raise");
  scripts\sp\utility::_id_F5AF("start_lab_office_door", [level._id_EBBB, level._id_EBBC, level.player]);
  thread scripts\sp\maps\europa\europa_util::_id_5F7C(level._id_EBCA);
  scripts\sp\maps\europa\europa_util::_id_EBC7();
  var_0 = [level._id_EBBB, level._id_EBBC];
  scripts\engine\utility::delaythread(1, scripts\sp\maps\europa\europa_util::_id_10690, "office_fight");
  scripts\sp\utility::_id_15F5("office_door_color_trig");
  scripts\sp\utility::_id_15F5("spawn_back_office_enemies");
  thread scripts\sp\maps\europa\europa_util::_id_67B6(1, "done", &"EUROPA_OBJECTIVE_ACCESS");
  thread scripts\sp\maps\europa\europa_util::_id_67B6(2, "current", &"EUROPA_OBJECTIVE_FSPAR", "tram_move");
}

_id_A786() {
  scripts\engine\utility::array_thread(level._id_EBCA, scripts\sp\utility::_id_F415, 0);
  scripts\engine\utility::array_thread(level._id_EBCA, scripts\sp\utility::_id_F416, 0);
  scripts\sp\utility::_id_15F5("office_door_color_trig");
  thread _id_1EDA();
  thread _id_3385();
  var_0 = getaiunittypearray("all", "soldier");
  scripts\engine\utility::array_thread(var_0, scripts\sp\utility::_id_F2DA, 1);
  thread _id_134E6();
  scripts\engine\utility::flag_wait("enter_office_door_area");
  scripts\sp\utility::_id_2669("soldier_combat");
  level notify("stop_catching_up");
  scripts\engine\utility::array_thread(level._id_EBCA, scripts\sp\utility::_id_5514);
  thread _id_4794();
  scripts\engine\utility::flag_wait("entering_office_exit");
  level notify("deploy_c6_lockers");
}

_id_134E6() {
  scripts\sp\maps\europa\europa_util::_id_134B7("europa_plr_goloud");
  scripts\engine\utility::flag_wait("back_office_enemies_dead");
  wait 1.1;
  scripts\sp\maps\europa\europa_util::_id_134B7("europa_plr_keepusmovin");
  scripts\engine\utility::flag_wait("locker_c6s_dead");
  scripts\sp\maps\europa\europa_util::_id_134B7("europa_plr_stayalertwerenotclear");
}

_id_1EDA() {
  scripts\engine\utility::array_thread(getEntArray("anim_hydroponics", "targetname"), ::_id_1FDF);
}

_id_1FDF() {
  self endon("death");
  var_0 = randomfloatrange(30, 40);

  for(;;) {
    self rotateroll(360, var_0);
    wait(var_0);
  }
}

_id_2726() {
  self.pathenemyfightdist = 300;

  if(level._id_7683 < 2)
    self.grenadeammo = 0;
  else if(scripts\engine\utility::cointoss())
    self.grenadeammo = 0;
}

_id_3385() {
  scripts\sp\utility::_id_22CA("c6_locker_spawner", ::_id_AF01);
  scripts\sp\utility::_id_22CA("c6_hacker", ::_id_3371);
  var_0 = 1;
  var_1 = scripts\engine\utility::getStructArray("c6_locker", "script_noteworthy");
  level._id_AF02 = [];

  foreach(var_3 in var_1) {
    var_3 _id_48AD();
    wait 0.06;
  }

  var_5 = 0;
  var_6 = 1;
  scripts\engine\utility::flag_wait("c6_lockers_go");
  var_7 = getEnt("front_office_vol", "targetname") scripts\sp\utility::_id_77E3("axis", "human");

  if(var_7.size < 2) {
    var_5 = 1;
    var_6 = 1;
  }

  if(!var_5)
    scripts\engine\utility::flag_wait("entering_office_exit");

  var_8 = ["europa_tee_wegotincoming", "europa_sip_bots2"];

  if(!var_0)
    thread scripts\sp\maps\europa\europa_util::_id_48BD(var_8);

  var_6 = !var_0;

  if(var_6) {
    scripts\sp\utility::_id_22CD("c6_hacker", 1);
    wait 0.75;
  }

  if(!var_0) {
    var_9 = 0;

    foreach(var_3 in var_1) {
      var_9++;
      var_3 thread _id_FB53(var_9);
      var_3 thread _id_3383();

      if(var_9 == 1) {
        wait 0.5;
        setmusicstate("mx_165_robotfight");
        wait 1;
        continue;
      }

      wait 0.9;
    }

    level notify("c6s_deployed");
    thread _id_3400();

    foreach(var_13 in level._id_EBCA) {
      var_13._id_C9BD = 1;
      var_13 scripts\sp\utility::_id_5514();
    }

    scripts\sp\utility::_id_15F5("c6_fall_back_color");
    scripts\engine\utility::trigger_off("color_move_office_hallway", "targetname");
    scripts\sp\utility::_id_13754(level._id_AF02);
    scripts\engine\utility::flag_set("locker_c6s_dead");

    foreach(var_13 in level._id_EBCA) {
      var_13._id_C9BD = undefined;
      var_13 scripts\sp\utility::_id_5514();
    }
  } else {
    scripts\engine\utility::flag_set("locker_c6s_dead");
    scripts\engine\utility::trigger_off("color_move_office_hallway", "targetname");
    scripts\sp\utility::_id_15F5("engineer_office_color_move");
  }
}

_id_67B7() {
  scripts\sp\maps\europa\europa_util::_id_1368F("office_exit_area", 1);
  setmusicstate("");
}

_id_3371() {
  if(isDefined(self.target)) {
    return;
  }
  self._id_1FBB = "generic";
  self.ignoreme = 1;
  thread scripts\sp\utility::_id_B14F();
  var_0 = scripts\engine\utility::getStruct("hacker", "targetname");
  self.struct = var_0;
  var_0 scripts\sp\anim::_id_1F17(self, "c6_hack_enter");
  thread _id_B279();
  var_0 scripts\sp\anim::_id_1F35(self, "c6_hack_enter");
  var_0 thread scripts\sp\anim::_id_1EEA(self, "c6_hack");
  wait 3;
  self.ignoreme = 0;
  self.target = "hacker_exit";
  self._id_4E46 = undefined;
  var_0 notify("stop_loop");
  _id_0B77::_id_8409();
}

_id_B279() {
  wait 0.05;
  self _meth_82B1(scripts\sp\utility::_id_7DC1("c6_hack_enter"), 1.7);
  wait 2;
  scripts\sp\utility::_id_1101B();
  self._id_4E46 = ::_id_10FC1;
}

_id_10FC1() {
  self _meth_83A1();
  self.struct notify("stop_loop");
  return 0;
}

_id_3400() {
  var_0 = [level.player, level._id_EBBB, level._id_EBBC];
  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = level._id_AF02;

  for(var_2 = 0; var_1.size; var_1 = scripts\sp\utility::array_removedeadvehicles(var_1)) {
    if(!isDefined(var_0[var_2]))
      var_3 = scripts\engine\utility::random(var_0);
    else
      var_3 = var_0[var_2];

    var_1 = scripts\sp\utility::array_removedeadvehicles(var_1);
    var_4 = scripts\engine\utility::getclosest(var_3.origin, var_1);
    var_4.goalradius = 45;
    var_4 notify("stop_going_to_node");
    var_4 setgoalentity(var_3);
    scripts\sp\utility::_id_13753([var_4]);
    wait 2;
    var_2++;
  }
}

_id_48AD() {
  self._id_215D = scripts\sp\utility::_id_10639("locker_arm", self.origin, self.angles);
  scripts\sp\utility::_id_16AE(self._id_215D, "locker_c6s");
  thread scripts\sp\anim::_id_1EC3(self._id_215D, "locker_deploy");
}

_id_3383() {}

_id_520B() {
  wait 0.05;
  self _meth_82B1(scripts\sp\utility::_id_7DC1("locker_deploy"), 1.45);
}

_id_FB53(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case 1:
      var_1 = "scn_europa_c6_locker_deploy_01";
      break;
    case 2:
      var_1 = "scn_europa_c6_locker_deploy_02";
      break;
    case 3:
      var_1 = "scn_europa_c6_locker_deploy_03";
      break;
    case 4:
      var_1 = "scn_europa_c6_locker_deploy_04";
      break;
    default:
      var_1 = "scn_europa_c6_locker_deploy_01";
      break;
  }

  self._id_215D playSound(var_1);
}

_id_3384() {}

#using_animtree("c6");

_id_AF01() {
  self endon("death");
  self._id_1FBB = "c6";
  self.ignoreall = 1;
  self.ignoreme = 1;
  self.grenadeammo = 0;
  thread scripts\sp\utility::_id_B14F();
  scripts\asm\asm::asm_setdemeanoranimoverride("combat", "move", %c6_grnd_red_walk_forward_ar);
  scripts\sp\utility::_id_F2DA(0);
  scripts\sp\utility::_id_F3AF(0);
  scripts\sp\utility::_id_16AE(self, "locker_c6s");
  self waittill("deployed");
  self.ignoreall = 0;
  self.ignoreme = 0;
  thread scripts\sp\utility::_id_1101B();
}

_id_11600() {
  scripts\engine\utility::array_thread(level._id_EBCA, scripts\sp\maps\europa\europa_util::_id_10FC2);
  scripts\engine\utility::array_thread(level._id_EBCA, scripts\sp\utility::_id_61C7);
  var_0 = getspawnerarray("back_office_enemies");
  scripts\engine\utility::play_sound_in_space("eu_enemy_incoming_2", var_0[0].origin);
  playworldsound("eu_enemy_incoming_3", var_0[1].origin);
}

_id_5995() {
  scripts\engine\utility::flag_wait("office_fight_started");

  foreach(var_1 in getaiarray("axis"))
  var_1.grenadeawareness = 0;

  var_3 = scripts\engine\utility::getStruct("frag_start", "targetname");
  var_4 = scripts\engine\utility::getStruct("frag_end", "targetname");
  var_5 = vectorNormalize(var_4.origin + (0, 0, 95) - var_3.origin);
  var_6 = magicgrenademanual("frag", var_3.origin, var_5 * 600, 4);

  while(isDefined(var_6))
    wait 0.05;

  foreach(var_1 in getaiarray("axis"))
  var_1.grenadeawareness = 1;
}

_id_33B1() {
  self endon("death");
  thread scripts\sp\utility::_id_B14F();
  scripts\engine\utility::delaythread(2.5, scripts\sp\utility::_id_1101B);
}

_id_4794() {
  scripts\engine\utility::flag_wait("back_office_enemies_dead");
  level thread scripts\sp\maps\europa\europa_util::_id_5F7C(level._id_EBCA);
}

_id_10009() {
  var_0 = [level._id_EBBB, level._id_EBBC];
  level._id_EBBB._id_114EB = 0;
  level._id_EBBC._id_114EB = 0;
  scripts\engine\utility::array_thread(var_0, ::_id_F3D1);

  if(level._id_EBBB._id_114EB == 1 && level._id_EBBC._id_114EB == 1) {
    if(!scripts\engine\utility::flag("cancel_door_tap_scene")) {
      var_1 = scripts\engine\utility::getStruct("scene_shoulder_tap", "targetname");
      var_1 scripts\sp\anim::_id_1F17(level._id_EBBB, "office_enter_idle");
      var_1 thread scripts\sp\anim::_id_1EEA(level._id_EBBB, "office_enter_idle", "stop_loop");
      var_1 scripts\sp\anim::_id_1F17(level._id_EBBC, "office_enter_tapgo");
      var_1 thread scripts\sp\anim::_id_1F35(level._id_EBBC, "office_enter_tapgo");
      level waittill("nt_notify_tapandgo");
      var_1 notify("stop_loop");
      var_1 thread scripts\sp\anim::_id_1F35(level._id_EBBB, "office_enter_go");
    }
  }
}

_id_F3D1() {
  level endon("enter_cutter_area");
  self._id_114EB = 0;
  self.goalradius = 96;

  if(self == level._id_EBBB)
    self _meth_82EE(getnode("scar1_touch_pos", "targetname"));
  else
    self _meth_82EE(getnode("scar2_touch_pos", "targetname"));

  self waittill("goal");
  self._id_114EB = 1;
}

_id_A787() {}

_id_A76C() {
  scripts\sp\maps\europa\europa_util::_id_107C5();
  thread scripts\sp\maps\europa\europa_util::_id_5F7C(level._id_EBCA);
  scripts\sp\maps\europa\europa_util::_id_EBC7();
  scripts\engine\utility::array_thread(level._id_EBCA, scripts\sp\utility::_id_DC45, "raise");
  scripts\sp\utility::_id_F5AF("lab_engineer_office_start", [level._id_EBBB, level._id_EBBC, level.player]);
  scripts\engine\utility::flag_set("entering_office_exit");
  scripts\engine\utility::delaythread(1, scripts\sp\maps\europa\europa_util::_id_10690, "office_fight");
  scripts\sp\utility::_id_15F5("engineer_office_color_move");
  thread scripts\sp\maps\europa\europa_util::_id_67B6(1, "done", &"EUROPA_OBJECTIVE_ACCESS");
  thread scripts\sp\maps\europa\europa_util::_id_67B6(2, "current", &"EUROPA_OBJECTIVE_FSPAR", "tram_move");
}

_id_A767() {
  _id_A789();
}

_id_A769() {
  scripts\sp\maps\europa\europa_util::_id_8E72("base_armory_vista");
}

_id_A78B() {
  scripts\sp\maps\europa\europa_util::_id_107C5();
  scripts\sp\maps\europa\europa_util::_id_6244(1);
  scripts\sp\maps\europa\europa_util::_id_EBC7();
  scripts\sp\utility::_id_F5AF("lab_office_exit_start", [level._id_EBBB, level._id_EBBC, level.player]);
}

_id_134E7() {
  scripts\engine\utility::flag_wait("enter_cutter_area");
  wait 1;
  scripts\sp\maps\europa\europa_util::_id_134B7("europa_plr_lightemup");
  scripts\engine\utility::flag_wait("cutter_bot_battle_finished");
  wait 0.7;
  scripts\sp\maps\europa\europa_util::_id_134B7("europa_tee_targetsdown2");
  wait 1;
  scripts\sp\maps\europa\europa_util::_id_134B7("europa_rpr_11wereoffthetimeline");
  scripts\sp\maps\europa\europa_util::_id_D24C(["europa_plr_movingonthetargetnow"]);
  scripts\engine\utility::flag_wait("scars_in_cutter_room");

  if(scripts\engine\utility::cointoss())
    scripts\sp\maps\europa\europa_util::_id_134B7("europa_tee_terminalsontheoth");
  else
    scripts\sp\maps\europa\europa_util::_id_134B7("europa_tee_webeatemtoit");

  thread scripts\sp\maps\europa\europa_util::_id_134B7("europa_plr_sipescrashit");
  scripts\engine\utility::flag_set("crash_door");
  scripts\sp\maps\europa\europa_util::_id_8E72("base_armory_vista");
}

_id_A789() {
  thread _id_134E7();
  scripts\engine\utility::flag_wait("entering_office_exit");
  level._id_F10A._id_4C74 = undefined;
  scripts\sp\utility::_id_2669("cutter_room");
  level notify("stop_grenade_think");
  var_0 = scripts\engine\utility::getStruct("scene_cutter_moving_cover", "targetname");
  var_1 = getEnt("moving_lab_desk", "targetname");
  var_2 = getEnt("moving_lab_desk_clip_dyn", "targetname");
  var_2 linkTo(var_1);
  var_1._id_1FBB = "desk";
  var_1 scripts\sp\utility::_id_23B7("desk");
  getnode("moving_desk_node", "targetname") _meth_80AC();
  var_3 = getEnt("engineer_office_enemy3", "targetname") scripts\sp\utility::_id_10619(1);
  var_4 = getEnt("engineer_office_enemy4", "targetname") scripts\sp\utility::_id_10619(1);
  var_5 = [var_3, var_4];

  foreach(var_7 in var_5) {
    var_7._id_1FBB = "generic";
    var_7.allowdeath = 1;
  }

  thread _id_67B7();
  var_0 scripts\sp\anim::_id_1ECA(var_3, "sdf_seeker_pulltable_sc");
  var_0 scripts\sp\anim::_id_1EC3(var_1, "sdf_seeker_pulltable_sc");
  thread _id_13508(var_5);
  scripts\engine\utility::flag_wait("enter_cutter_area");
  scripts\sp\utility::_id_15F5("engineer_office_color_move");
  thread _id_F02F();

  if(isDefined(var_3))
    thread ag_check(var_3);

  if(isalive(var_3)) {
    var_0 thread scripts\sp\anim::_id_1EC7(var_3, "sdf_seeker_pulltable_sc");
    var_0 thread scripts\sp\anim::_id_1F35(var_1, "sdf_seeker_pulltable_sc");
  }

  var_5 = scripts\sp\utility::_id_22B9(var_5);
  scripts\engine\utility::waittill_any_ents(level, "combat_office_exit", var_0, "sdf_seeker_pulltable_sc");

  foreach(var_7 in var_5) {
    if(isDefined(var_7)) {
      var_7.ignoreall = 0;
      var_7.ignoreme = 0;
    }
  }

  if(isalive(var_3)) {
    var_11 = getnode("moving_desk_node", "targetname");
    var_11 _meth_808B();
    var_3 _meth_82EE(var_11);
    var_2 disconnectPaths();
  }

  if(isalive(var_4)) {
    var_4 scripts\sp\utility::_id_4145();
    var_4 scripts\sp\utility::_id_F3DC(var_4.origin);
    var_4.goalradius = 164;
  }

  scripts\sp\utility::_id_15F5("engineer_office_color_move");
  scripts\sp\maps\europa\europa_util::_id_1368F("office_exit_area", 0);
  scripts\sp\utility::_id_15F5("engineer_exit_color_move");
  scripts\engine\utility::delaythread(0.4, scripts\sp\utility::_id_15F5, "engineer_exit_color_move");
  scripts\sp\utility::_id_28D7("axis");
  scripts\engine\utility::flag_set("cutter_bot_battle_finished");
  _id_1C08();
  scripts\engine\utility::flag_wait("player_in_cutter_room");

  foreach(var_13 in level._id_EBCA) {
    var_13._id_C392 = var_13.pushable;
    var_13.pushable = 0;
  }

  scripts\engine\utility::flag_wait("wall_cut_finished");
  scripts\engine\utility::flag_wait("crash_door");
  setsuncolorandintensity(0.784314, 0.937255, 1, 2);
  thread _id_BEFD();
  wait 1;
  var_15 = getEntArray("extra_corridor_klaxon_light", "script_noteworthy");
  scripts\engine\utility::array_thread(var_15, scripts\sp\maps\europa\europa_armory::_id_A6ED);
  scripts\sp\utility::_id_15F5("into_armory_color_move");
  scripts\engine\utility::flag_wait("player_exit_office_into_armory");
  scripts\sp\maps\europa\europa_util::_id_EBC4();
}

ag_check(var_0) {
  var_0 endon("death");

  for(;;) {
    level.player waittill("grenade_fire", var_1, var_2);

    if(isDefined(var_2) && var_2 == "antigrav") {
      if(var_0 _meth_81A6()) {
        var_0 _meth_83A1();
        return;
      }
    }
  }
}

_id_13508(var_0) {
  var_0[0] scripts\sp\utility::_id_10347("europa_sf1_theyreclosing");
  var_0[0] scripts\sp\utility::_id_10347("europa_sf3_getusintherenow");
}

#using_animtree("script_model");

_id_BEFD() {
  var_0 = getEnt("office_breach_door", "targetname");
  var_1 = scripts\engine\utility::getStruct("cutter_door_entry_scene", "targetname");
  var_2 = getstartorigin(var_1.origin, var_1.angles, %europa_armory_seeker_door_fall);
  var_3 = getstartangles(var_1.origin, var_1.angles, %europa_armory_seeker_door_fall);
  var_1._id_59B2 = scripts\sp\utility::_id_10639("tag_origin_mover", var_2, var_3);
  var_1._id_59B2.node = var_1 scripts\engine\utility::spawn_script_origin();
  var_1._id_5978 = var_0;
  var_1._id_5978 linkTo(var_1._id_59B2, "tag_origin");
  var_1._id_1684 = [level._id_EBBB, level._id_EBBC, var_1._id_59B2];
  var_1 scripts\sp\anim::_id_1F17(level._id_EBBC, "new_armory_enter");
  thread _id_5994(var_1);
  var_1._id_59B2.node scripts\engine\utility::delaycall(10, ::delete);
  var_1._id_59B2 scripts\engine\utility::delaycall(10, ::delete);
  var_1 scripts\sp\anim::_id_1F2C(var_1._id_1684, "new_armory_enter");
  level._id_EBBC scripts\sp\utility::_id_61C7();
  scripts\sp\utility::_id_2669("armory_in");

  foreach(var_5 in level._id_EBCA)
  var_5.pushable = scripts\engine\utility::ter_op(isDefined(var_5._id_C392), var_5._id_C392, 1);
}

_id_5994(var_0) {
  scripts\engine\utility::noself_delaycall(1.2, ::playworldsound, "scn_europa_door_fall_start", var_0._id_5978.origin);
  var_0._id_5978 scripts\engine\utility::delaycall(2.3, ::playsound, "scn_europa_door_fall_hit");
  wait 1.2;
  thread scripts\engine\utility::exploder("doorfall_sparks");
  wait 1.1;
  thread scripts\engine\utility::exploder("doorfall_smoke");
  var_1 = getEnt("office_exit_dynpath", "targetname");
  var_1 connectpaths();
  var_1 notsolid();
}

_id_1C08() {
  var_0 = getEnt("allies_at_exit_vol", "targetname");
  var_1 = [level._id_EBBC, level._id_EBBB];
  _id_1378A(var_0, var_1);
  scripts\engine\utility::flag_set("scars_in_cutter_room");
}

_id_F02F() {
  level._id_BCDA = scripts\sp\vehicle::_id_1080C("cutter_script_vehicle");
  var_0 = getEnt("sdf_cutter_device", "targetname");
  var_0.origin = level._id_BCDA.origin;
  var_0 linkTo(level._id_BCDA);
  playFXOnTag(level._effect["welding"], level._id_BCDA, "tag_origin");
  level._id_BCDA startpath();
  var_0 playLoopSound("scn_europa_laser_cutter_lp");
  var_0 _meth_83D0(#animtree);
  var_0._id_1FBB = "cutter";
  var_0 thread scripts\sp\anim::_id_1EEA(var_0, "cutter_crawl", "stop_loop", "tag_origin");
  scripts\engine\utility::flag_wait("cutter_finished");
  var_0 stoploopsound();
  var_0 playSound("scn_europa_laser_cutter_done");
  playworldsound("scn_europa_laser_cutter_smolder", var_0.origin);
  stopFXOnTag(level._effect["welding"], level._id_BCDA, "tag_origin");
  var_0 notify("stop_loop");
  var_0 _meth_83A1();
  var_0 unlink();
  var_0 movey(-2.5, 0.05);
  var_0 waittill("movedone");
  var_1 = scripts\engine\utility::getStruct("seeker_impulse_pos", "targetname");
  var_2 = (0, -40, 0);
  var_0 _meth_841C(1, var_1.origin, var_2);
  scripts\engine\utility::flag_set("wall_cut_finished");
}

_id_A78A() {}

_id_1CC5() {
  var_0 = getEnt(self.target, "targetname");
  var_1 = 0;

  if(isDefined(var_0.script_count))
    var_1 = var_0.script_count;

  var_2 = getEnt(var_0.target, "targetname");
  var_2 endon("trigger");
  self waittill("trigger");

  while(!var_0 scripts\sp\utility::_id_77E3("axis").size)
    wait 1;

  for(;;) {
    var_3 = var_0 scripts\sp\utility::_id_77E3("axis");

    if(var_3.size <= var_1) {
      break;
    }

    wait 0.25;
  }

  var_2 scripts\sp\utility::script_delay();
  var_2 notify("trigger");
}

_id_1CC2(var_0) {
  setdvarifuninitialized("ally_advance_debug", 0);

  if(!getdvarint("ally_advance_debug")) {
    return;
  }
  foreach(var_2 in var_0)
  thread scripts\sp\utility::draw_circle(var_2.origin, 24, (1, 0, 0), 1, 0, 24);
}

_id_D6A7() {
  self._id_1FBB = "script_model";
  scripts\sp\anim::_id_F64A();
  var_0 = self.animation;
  scripts\sp\anim::_id_1EC3(self, var_0, "tag_origin");
}