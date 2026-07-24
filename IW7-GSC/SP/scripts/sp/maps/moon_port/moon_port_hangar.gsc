/**********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\moon_port\moon_port_hangar.gsc
**********************************************************/

_id_8AAE() {
  precachemodel("veh_mil_air_un_jackal_drone_atmos_periph");
  precachemodel("nopack_nohelmet_shadow");
}

_id_8A57() {
  scripts\engine\utility::flag_init("hangar_salter_at_airlock");
  scripts\engine\utility::flag_init("hangar_player_used_airlock");
  scripts\engine\utility::flag_init("hangar_airlock_autocomplete");
  scripts\engine\utility::flag_init("hangar_airlock_done");
  scripts\engine\utility::flag_init("hangar_halls_done");
  scripts\engine\utility::flag_init("hangar_initial_dialogue_done");
  scripts\engine\utility::flag_init("hangar_door_closed");
  scripts\engine\utility::flag_init("hangar_airlock_push_start");
  scripts\engine\utility::flag_init("hangar_doors_open");
  scripts\engine\utility::flag_init("hangar_post_airlock_dialogue_finished");
  scripts\engine\utility::flag_init("player_grabbed_emps");
  scripts\engine\utility::flag_init("player_grabbed_lmg");
  scripts\engine\utility::flag_init("player_grabbed_shotgun");
  scripts\engine\utility::flag_init("player_grabbed_weapons");
  scripts\engine\utility::flag_init("player_used_terminal");
  scripts\engine\utility::flag_init("armory_dialog_active");
  scripts\engine\utility::flag_init("armory_exit_active");
  scripts\engine\utility::flag_init("armory_exit_open");
  scripts\engine\utility::flag_init("armory_action_active");
  scripts\engine\utility::flag_init("armory_guard_interaction");
  scripts\engine\utility::flag_init("armory_salter_nagging");
  scripts\engine\utility::flag_init("armory_intro_done");
  scripts\engine\utility::flag_init("hangar_emps_used");
  scripts\engine\utility::flag_init("hangar_activate_door");
  scripts\engine\utility::flag_init("secure_player_opened_door");
  scripts\engine\utility::flag_init("hangar_elevator_go");
  scripts\engine\utility::flag_init("hangar_end_done");
  scripts\engine\utility::flag_init("salter_unlock_ordered");
  scripts\engine\utility::flag_init("harass_end_chase");
  scripts\engine\utility::flag_init("secure_outer_mco_done");
  scripts\engine\utility::flag_init("jackal_hangar_bays_open");
  scripts\engine\utility::flag_init("capture_mount");
  scripts\sp\utility::_id_16EB("hint_airlock_mash", &"MOON_PORT_MASH", ::_id_8FE3);
  scripts\sp\utility::_id_16EB("hint_airlock_mash_pc", &"MOON_PORT_MASH_PC", ::_id_8FE3);
  scripts\sp\utility::_id_16EB("hint_emp_tutorial", &"MOON_PORT_HANGAR_EMP_HINT", ::_id_615C);
  createthreatbiasgroup("player_and_salter");
  createthreatbiasgroup("hangar_bravo");
  createthreatbiasgroup("hangar_enemies_bottom");
  createthreatbiasgroup("hangar_enemies_top");
}

_id_8A66() {
  scripts\sp\maps\moon_port\moon_port_util::_id_BC53("start_hangar_halls");
  thread scripts\sp\maps\moon_port\moon_port_util::_id_D1E7(undefined, "moon_low_g_exterior");
  level.player takeallweapons();
  level.player giveweapon("iw7_gunless");
  level.player switchtoweaponimmediate("iw7_gunless");
  var_0 = ["marineCO", "salter", "eth3n", "mdf1"];
  scripts\sp\maps\moon_port\moon_port_util::_id_BC05("start_hangar_halls", var_0);
  wait 0.1;
  scripts\engine\utility::delaythread(1, scripts\engine\utility::flag_set, "harras_run_complete");
  level.player thread scripts\sp\maps\moon_port\moon_port_util::_id_D252();
  scripts\engine\utility::flag_set("harass_end_chase");
  scripts\engine\utility::exploder("broken_airlock");
  _id_0E4B::_id_8E06();
  scripts\sp\maps\moon_port\moon_port_anim::_id_479E(level.player);
}

_id_8A63() {
  scripts\engine\utility::flag_set("player_indoor_p2_noblur");
  scripts\sp\maps\moon_port\moon_port_util::_id_968A();
  thread scripts\sp\maps\moon_port\moon_port_util::_id_BB2C("hangar");
  scripts\engine\utility::flag_wait("harass_end_chase");
  scripts\sp\utility::_id_10FEC("walkway_flak");
  thread _id_8A5C();
  thread _id_8A65();
  scripts\engine\utility::flag_wait("hangar_airlock_done");
  level.player scripts\engine\utility::allow_crouch(1);
  level.player scripts\engine\utility::allow_prone(1);
  level.player scripts\engine\utility::allow_slide(1);
  level.player _meth_81DE(65, 2);
  thread _id_8A61();

  foreach(var_1 in level.allies)
  var_1 scripts\sp\utility::_id_F3B5("g");

  scripts\engine\utility::delaythread(4, scripts\engine\utility::flag_set, "player_indoor_p2");
  scripts\sp\maps\moon_port\moon_port_util::_id_15F6("hangar_halls_allies_1");
  scripts\engine\utility::flag_wait("hangar_at_armory");
  thread _id_8A60();
}

_id_8A65() {
  var_0 = getEnt("player_is_in_hangar_scanner", "targetname");
  var_1 = scripts\engine\utility::getStruct("hangar_scanner_repulsor", "targetname");
  var_0 waittill("trigger");
  var_2 = createnavobstaclebybounds(var_1.origin, (55, 55, 55), (0, 0, 0), "axis", "allies");

  while(level.player istouching(var_0))
    scripts\engine\utility::waitframe();

  destroynavobstacle(var_2);
}

_id_8A5C() {
  scripts\engine\utility::flag_wait("harras_run_complete");
  var_0 = scripts\engine\utility::getStruct("hangar_halls_airlock_door_cursor_struct", "targetname");
  var_0 _id_0E46::_id_48C4(undefined, undefined, undefined, 40, 300, 120);
  var_1 = getEnt("hangar_broken_airlock_door", "targetname");
  var_1._id_1FBB = "broken_airlock_door";
  var_1 scripts\sp\anim::_id_F64A();
  var_2 = getEnt("broken_airlock_animnode", "targetname");
  var_2 notify("stop_harass_idles");
  var_2 scripts\sp\anim::_id_1EC3(var_1, "broken_airlock_push");
  var_3 = scripts\engine\utility::getStruct("buddy_door_animnode", "targetname");

  if(isDefined(var_3))
    var_3 notify("stop_idle");

  var_3 = scripts\engine\utility::getStruct("infil_airlock_animnode", "targetname");

  if(isDefined(var_3))
    var_3 notify("stop_idle");

  var_2 = getEnt("broken_airlock_animnode", "targetname");
  level.allies["salter"] thread _id_30EF(var_2, "broken_airlock_xo_enter", "broken_airlock_xo_push_loop", "xo");
  level.allies["marineCO"] thread _id_30EF(var_2, undefined, "broken_airlock_mco_push_loop", "mco");
  level.allies["eth3n"] thread _id_30EF(var_2, undefined, "broken_airlock_c6i_push_loop", "eth3n");
  scripts\engine\utility::flag_wait("player_close_to_airlock");
  level.player playSound("scn_moon_harass_airlock_lerp");
  var_0 _id_0E46::_id_DFE3();
  level._id_470F = undefined;
  scripts\engine\utility::flag_set("hangar_player_used_airlock");
  thread _id_728C();
  thread scripts\sp\maps\moon_port\moon_port_util::_id_D1E6(1.0);

  foreach(var_5 in level.allies) {
    var_5 scripts\sp\utility::_id_4169("combat");
    var_5 scripts\sp\utility::_id_51E1("casual_gun");
  }

  var_7 = scripts\sp\utility::_id_10639("player_rig");
  var_7 hide();
  var_8 = scripts\sp\utility::_id_10639("broken_airlock_helmet");
  level._id_8E10 = "none";
  var_8 hide();
  var_9 = 65536;
  level.allies["marineCO"] setgoalpos(level.allies["marineCO"].origin);
  level.allies["salter"] setgoalpos(level.allies["salter"].origin);
  level.allies["eth3n"] setgoalpos(level.allies["eth3n"].origin);
  level.allies["mdf1"] setgoalpos(level.allies["mdf1"].origin);
  level.player disableweapons();
  level.player setstance("stand");
  level.player scripts\engine\utility::allow_jump(0);
  level.player scripts\engine\utility::allow_crouch(0);
  level.player scripts\engine\utility::allow_prone(0);
  var_2 scripts\sp\anim::_id_1EC1([var_7], "broken_airlock_push");
  level.player _meth_823C(var_7, "tag_player", 0.5, 0.5, 0);
  wait 0.5;
  level.player playerlinktodelta(var_7, "tag_player", 1, 0, 0, 0, 0, 1);
  level.player _id_30F1(var_2, var_7, var_8, var_1);
  level.player unlink();
  var_7 delete();
  level.player enableweapons();
  level.player setstance("stand");
  level.player scripts\engine\utility::allow_jump(1);
  level.player scripts\engine\utility::allow_crouch(1);
  level.player scripts\engine\utility::allow_prone(1);
  scripts\engine\utility::flag_set("hangar_airlock_done");
  level notify("got_to_airlock");
  level.player scripts\sp\utility::_id_F526("relaxed");
  level.player takeallweapons();
  scripts\sp\utility::_id_12651(["moon_port_concourse_tr", "moon_port_periph_tr", "moon_port_harass_tr"]);
  level.allies["eth3n"] scripts\sp\utility::_id_4145();
  wait 2;
  level.allies["mdf1"] scripts\sp\utility::_id_4145();
  wait 1.75;
  level.allies["marineCO"] scripts\sp\utility::_id_4145();
  wait 1.25;
  level.allies["salter"] scripts\sp\utility::_id_4145();
}

_id_30EF(var_0, var_1, var_2, var_3) {
  self notify("stop_idle");
  self notify("stop_salter_idle");
  var_0 thread scripts\sp\anim::_id_1EEA(self, var_2, var_3 + "_end_loop");
  scripts\engine\utility::flag_wait("hangar_airlock_autocomplete");
  var_0 notify(var_3 + "_end_loop");
}

_id_728C() {
  var_0 = [];
  scripts\engine\utility::array_combine(var_0, getEntArray("script_vehicle_capitalship_destroyer_ca_cheap", "classname"));
  scripts\engine\utility::array_combine(var_0, getEntArray("script_vehicle_capitalship_destroyer_un_cheap", "classname"));
  scripts\engine\utility::array_combine(var_0, getEntArray("script_vehicle_capitalship_retribution_cheap", "classname"));

  foreach(var_2 in var_0)
  var_2 _id_0BA9::_id_397B();
}

#using_animtree("player");

_id_30F1(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4[var_4.size] = level.allies["salter"];
  var_4[var_4.size] = level.allies["marineCO"];
  var_4[var_4.size] = level.allies["eth3n"];
  var_4[var_4.size] = level.allies["mdf1"];
  var_4[var_4.size] = var_3;
  var_4[var_4.size] = var_2;
  var_1 show();
  var_5 = getanimlength(%moon_team_airlock_plr_push);
  var_6 = 1.2;
  var_7 = scripts\sp\maps\moon_port\moon_port_harass::_id_792F();
  var_7 notify("stop_idle");
  var_0 thread scripts\sp\anim::_id_1F2C([var_1, var_2], "broken_airlock_push");
  wait(var_6);
  scripts\sp\anim::_id_1F27([var_1, var_2], "broken_airlock_push", 0.0);
  level.player._id_8DDB = var_2;

  if(level.player scripts\engine\utility::is_player_gamepad_enabled())
    scripts\sp\utility::_id_56BA("hint_airlock_mash");
  else
    scripts\sp\utility::_id_56BA("hint_airlock_mash_pc");

  while(!self useButtonPressed())
    wait 0.05;

  scripts\engine\utility::flag_set("hangar_airlock_push_start");
  level.player notify("reached_airlock");
  level.player playSound("scn_moon_harass_airlock_open");
  scripts\engine\utility::delaythread(3, scripts\engine\utility::flag_set, "hangar_airlock_autocomplete");
  scripts\engine\utility::delaythread(8, ::_id_1102E);
  scripts\engine\utility::delaythread(8, scripts\engine\utility::flag_set, "player_removed_harass_helmet");
  thread _id_12965();
  scripts\engine\utility::delaythread(1, scripts\engine\utility::exploder, "broken_airlock_1");
  scripts\engine\utility::delaythread(2.5, scripts\engine\utility::exploder, "broken_airlock_2");
  scripts\engine\utility::delaythread(3.2, scripts\engine\utility::exploder, "broken_airlock_3");
  scripts\engine\utility::delaythread(6.5, scripts\sp\utility::_id_10FEC, "broken_airlock_1");
  scripts\engine\utility::delaythread(6.5, scripts\sp\utility::_id_10FEC, "broken_airlock_2");
  scripts\engine\utility::delaythread(6.5, scripts\sp\utility::_id_10FEC, "broken_airlock_3");
  level.player thread _id_30ED();
  thread scripts\sp\maps\moon_port\moon_port_harass::_id_4FAF();
  scripts\engine\utility::delaythread(var_6, scripts\sp\anim::_id_1F27, [var_1], "broken_airlock_push", 1.0);
  scripts\engine\utility::delaythread(var_6, scripts\sp\anim::_id_1F27, [var_2], "broken_airlock_push", 1.0);
  var_0 thread scripts\sp\anim::_id_1F2C(var_4, "broken_airlock_push");

  if(scripts\sp\utility::_id_93A6())
    scripts\engine\utility::delaythread(7.25, scripts\sp\specialist_MAYBE::_id_915F);

  wait(var_5 - var_6);
  level.player _meth_8573("nopack_nohelmet_shadow");
  scripts\engine\utility::flag_set("hangar_airlock_done");
  level notify("got_to_airlock");
}

_id_12965() {
  setomnvar("ui_helmet_meter_forceVisible", 0);
  wait 2.9;
  thread scripts\sp\hud::_id_8DFB("oxygen", 0.1, 90);
}

_id_1102E() {
  level.player notify("stop_random_blur");
}

_id_30ED() {
  var_0 = 0;
  var_1 = 0.66;
  var_2 = 6.0;
  var_3 = 45;
  var_4 = 185;
  var_5 = 1.6;
  var_6 = 2.0;
  wait 7.5;
  thread _id_0B0A::_id_583F(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
  wait 8.5;
  thread _id_0B0A::_id_583D(3.0);
}

_id_8FE3() {
  return scripts\engine\utility::flag("hangar_airlock_autocomplete");
}

_id_EAD2() {
  var_0 = getEnt("broken_airlock_animnode", "targetname");
  var_0 scripts\sp\anim::_id_1F17(self, "broken_airlock_in");
  scripts\engine\utility::flag_set("hangar_salter_at_airlock");
  var_0 scripts\sp\anim::_id_1F35(self, "broken_airlock_in");
  scripts\engine\utility::flag_set("hangar_salter_on_airlock_door");
  var_0 thread scripts\sp\anim::_id_1EEA(self, "broken_airlock_idle", "stop_loop");
  scripts\engine\utility::flag_wait("hangar_player_used_airlock");
  var_0 notify("stop_loop");
}

_id_EAF8(var_0) {
  var_0 scripts\sp\anim::_id_1EC3(self, "broken_airlock_in");
  var_0 scripts\sp\anim::_id_1F35(self, "broken_airlock_in");
  scripts\engine\utility::flag_set("hangar_salter_on_airlock_door");
}

_id_8A61() {
  wait 2;
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moonport_omr_earthsintrouble");
  level.allies["eth3n"] scripts\sp\utility::_id_10346("moon_eth_cantwocapitalsh");
  scripts\sp\utility::_id_1034D("moon_plr_negativetheynee");
  level.allies["salter"] scripts\sp\utility::_id_10346("moon_mco_nonetakenweneed");
  wait 0.2;
  level.allies["mdf1"] scripts\sp\utility::_id_10346("moon_mdf3_illtakeyouto");
  scripts\engine\utility::flag_wait("hangar_halls_bravo_dialog_trigger");
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_mco_bravoonealphason");
  level.player playSound("moon_ksh_movingyourwayac");
  wait 3;
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_mco_copyout");
  scripts\engine\utility::flag_set("hangar_post_airlock_dialogue_finished");
}

_id_8A5E() {
  level endon("hangar_player_used_airlock");
  wait 8.0;
  level.allies["salter"] scripts\sp\utility::_id_10346("moon_slt_cmon");
  wait 8.0;
  level.allies["salter"] scripts\sp\utility::_id_10346("moon_slt_cmon");
  wait 4.0;
  scripts\sp\utility::_id_B8D1();
}

_id_8A60() {
  var_0 = getEnt("hangar_broken_airlock_fx", "targetname");
  var_0 delete();
}

_id_8A5F() {
  scripts\engine\utility::flag_set("hangar_at_armory");
  _id_8A60();
}

_id_8A20() {
  scripts\sp\maps\moon_port\moon_port_util::_id_968A();
  thread scripts\sp\maps\moon_port\moon_port_util::_id_BB2C("hangar");
  scripts\sp\maps\moon_port\moon_port_util::_id_BC53("start_hangar_armory");
  var_0 = ["marineCO", "salter", "eth3n", "mdf1"];
  scripts\sp\maps\moon_port\moon_port_util::_id_BC05("start_hangar_armory", var_0);
  level.allies["marineCO"] scripts\sp\utility::_id_F3B5("g");
  wait 0.1;
  scripts\sp\utility::_id_15F5("hangar_halls_allies_to_armory");
  scripts\engine\utility::flag_set("hangar_post_airlock_dialogue_finished");
  level.player scripts\sp\utility::_id_F526("relaxed");
  level.player takeallweapons();
}

_id_8A1F() {
  scripts\engine\utility::flag_set("player_indoor_p2");
  var_0 = getEnt("armory_exit_door", "targetname");
  var_0 hidepart("tag_unlocked");
  var_1 = scripts\engine\utility::getStruct("armory_scene", "targetname");
  level._id_2242 = var_1;
  scripts\engine\utility::flag_wait("hangar_at_armory");
  _id_223B(var_1);

  if(isDefined(level.player.helmet))
    level.player.helmet delete();

  thread _id_8A1D();
  thread _id_21E1();
  level waittill("armory_door_open");
  thread _id_222C();
  thread _id_222A();
  thread _id_B6AF();
  level.allies["salter"] thread scripts\sp\utility::_id_4125(1, 0, "iw7_m4");
  scripts\engine\utility::delaythread(1, scripts\sp\utility::_id_12641, "moon_port_hangar_tr");

  foreach(var_3 in level.allies) {
    var_3 scripts\sp\utility::_id_5522();
    var_3.demeanoroverride = "casual_gun";
    var_3 _meth_8250(1);
  }

  var_1 scripts\sp\anim::_id_1EC1(level.allies, "armory_enter");
  level.allies["marineCO"] thread _id_221B(var_1);
  level.allies["salter"] thread _id_223A(var_1);
  level.allies["eth3n"] thread _id_21EE(var_1);
  level.allies["mdf1"] thread _id_21FD(var_1);
  wait 0.1;
  thread _id_222B(var_1);
  scripts\engine\utility::flag_wait("armory_exit_open");
  var_1 notify("armory_mco_idle_end");

  foreach(var_3 in level.allies) {
    var_3 _meth_8250(0);
    var_3 scripts\sp\utility::_id_51E1("combat");
  }

  level.player scripts\sp\utility::_id_F526("normal");
  level.allies["eth3n"] scripts\sp\utility::_id_61C7();
  level.allies["salter"] scripts\sp\utility::_id_F3B5("r");
  level.allies["marineCO"] scripts\sp\utility::_id_F3B5("g");
  level.allies["mdf1"] scripts\sp\utility::_id_F3B5("g");
  wait 0.1;
  scripts\sp\utility::_id_15F5("hangar_allies_leave_armory");
  scripts\sp\utility::_id_15F3("hangar_spawn_bravo");
  wait 0.1;
  scripts\sp\utility::_id_15F5("hangar_bravo_init_color");
  thread slow_load_blocker_hangar();
  scripts\sp\utility::_id_12641("moon_port_hangar_end_tr");
  thread _id_8A1C();
}

slow_load_blocker_hangar() {
  if(!level.console) {
    scripts\engine\utility::flag_wait("player_at_hangar_window");
    waitforalltransients();
  }
}

_id_B6AF() {
  scripts\engine\utility::flag_wait("player_grabbed_lmg");
  wait 0.1;
  var_0 = level.player getcurrentweapon();
  level.player setweaponammostock(var_0, 320);
}

_id_8A1D(var_0) {
  if(!scripts\engine\utility::flag("hangar_player_in_armory"))
    level.allies["mdf1"] thread _id_8A1E();

  scripts\engine\utility::flag_wait("armory_intro_done");
  scripts\engine\utility::flag_wait("armory_exit_active");
  level.player notify("player_finished_armory");
  scripts\engine\utility::flag_waitopen("armory_action_active");
  scripts\sp\utility::_id_1034D("moon_plr_imgoodletsgetmo");
  level notify("mco_start_armory_exit");
  level waittill("armory_mco_finished");
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_mco_wereonthemove");
}

_id_21E1() {
  var_0 = getEnt("armory_door_blocker", "targetname");

  if(isDefined(var_0))
    var_0 notsolid();

  level waittill("armory_door_open");

  if(isDefined(var_0))
    var_0 solid();

  wait 5.0;
  var_1 = getEntArray("generic_door", "script_noteworthy");

  foreach(var_3 in var_1) {
    if(isDefined(var_3.script_parameters) && var_3.script_parameters == "armory")
      var_3 rotateYaw(90, 0.8, 0.1, 0.1);
  }

  wait 0.5;

  if(isDefined(var_0))
    var_0 delete();
}

_id_8A1E() {
  level endon("armory_door_start_open");
  wait 8;
  scripts\sp\utility::_id_10346("moon_ms3_heresthearmoryc");
  wait 14;
  scripts\sp\utility::_id_10346("moon_ms3_afteryousir");
}

_id_221B(var_0) {
  level._id_B4FF = scripts\sp\utility::_id_10639("armory_emp", var_0.origin, var_0.angles);
  level._id_2242 scripts\sp\anim::_id_1EC3(level._id_B4FF, "armory_mco_emp");
  scripts\sp\anim::_id_17F6(self._id_1FBB, "start_emp_anim", ::_id_221C);
  var_0 scripts\sp\anim::_id_1F35(self, "armory_enter");
  var_0 thread scripts\sp\anim::_id_1EEA(self, "armory_mco_idle", "armory_mco_idle_end");

  if(!scripts\engine\utility::flag("armory_exit_active"))
    scripts\engine\utility::flag_waitopen("armory_action_active");

  if(scripts\engine\utility::flag("player_grabbed_emps"))
    var_1 = 1;
  else
    var_1 = 0;

  for(;;) {
    if(!scripts\engine\utility::flag("armory_exit_active"))
      scripts\engine\utility::flag_wait("armory_action_active");

    if(!scripts\engine\utility::flag("armory_exit_active") && !scripts\engine\utility::flag("armory_intro_done")) {
      if(var_1 == 0 && scripts\engine\utility::flag("player_grabbed_emps") && !scripts\engine\utility::flag("armory_guard_interaction")) {
        var_1 = 1;
        var_0 notify("armory_mco_idle_end");
        var_0 scripts\sp\anim::_id_1F35(self, "armory_mco_grenade_interact");
        var_0 thread scripts\sp\anim::_id_1EEA(self, "armory_mco_idle", "armory_mco_idle_end");
        scripts\engine\utility::flag_clear("armory_action_active");
      }
    } else {
      level waittill("mco_start_armory_exit");
      scripts\engine\utility::flag_set("armory_exit_open");
      scripts\engine\utility::flag_waitopen("armory_action_active");
      scripts\engine\utility::flag_set("armory_action_active");
      var_0 notify("armory_mco_idle_end");
      var_0 scripts\sp\anim::_id_1F35(self, "armory_mco_exit");
      var_0 notify("armory_mco_idle_end");
      scripts\engine\utility::flag_clear("armory_action_active");
      break;
    }

    scripts\engine\utility::flag_waitopen("armory_action_active");
  }

  scripts\engine\utility::waitframe();
  var_0 notify("armory_mco_idle_end");
  var_0 thread scripts\sp\anim::_id_1EEA(self, "armory_mco_exit_idle", "armory_mco_exit_idle_end");
  level notify("armory_mco_finished");
  scripts\engine\utility::flag_wait("leaving_armory");
  var_0 notify("armory_mco_exit_idle_end");
  scripts\sp\utility::_id_61C7();
}

_id_221C(var_0) {
  level._id_2242 scripts\sp\anim::_id_1F35(level._id_B4FF, "armory_mco_emp");
}

_id_223B(var_0) {
  level._id_EADC = scripts\sp\utility::_id_10639("armory_shotgun", var_0.origin, var_0.angles);
  level._id_2242 scripts\sp\anim::_id_1EC3(level._id_EADC, "armory_xo_shotgun");
  level._id_EAB9 = scripts\sp\utility::_id_10639("armory_lmg", var_0.origin, var_0.angles);
  level._id_2242 scripts\sp\anim::_id_1EC3(level._id_EAB9, "armory_xo_lmg");
}

_id_223A(var_0) {
  scripts\sp\utility::_id_F3DC(var_0.origin);
  scripts\sp\utility::_id_F3DD(1024);
  scripts\sp\anim::_id_17F6(self._id_1FBB, "freeze_gun", ::_id_2264);
  scripts\sp\anim::_id_17F6(self._id_1FBB, "start_shotgun_anim", ::_id_2266);
  scripts\sp\anim::_id_17F6(self._id_1FBB, "stow_shotgun", ::_id_2267);
  scripts\sp\anim::_id_17F6(self._id_1FBB, "start_lmg_anim", ::_id_2265);
  var_0 scripts\sp\anim::_id_1F35(self, "armory_enter");
  var_0 thread scripts\sp\anim::_id_1EEA(self, "armory_xo_idle", "armory_xo_idle_end");

  if(!scripts\engine\utility::flag("armory_exit_active"))
    scripts\engine\utility::flag_waitopen("armory_action_active");

  while(!scripts\engine\utility::flag("armory_exit_active")) {
    scripts\engine\utility::flag_wait_any("armory_action_active", "armory_exit_active");
    scripts\engine\utility::flag_waitopen("armory_action_active");
    wait 0.05;
  }

  var_0 notify("armory_xo_idle_end");
}

_id_2264(var_0) {
  var_1 = spawn("script_model", var_0 gettagorigin("tag_weapon_right"));
  var_1.angles = var_0 gettagangles("tag_weapon_right");
  var_2 = getweaponmodel("iw7_m4");
  var_1 setModel(var_2);
  var_0 scripts\sp\utility::_id_86E4();
  level._id_EACD = var_1;
}

_id_2266(var_0) {
  level._id_2242 scripts\sp\anim::_id_1F35(level._id_EADC, "armory_xo_shotgun");
}

_id_2267(var_0) {
  level._id_EADC linkTo(var_0, "tag_stowed_back");
}

_id_2265(var_0) {
  level._id_2242 scripts\sp\anim::_id_1F35(level._id_EAB9, "armory_xo_lmg");
  level._id_EAB9 delete();
  var_0 scripts\sp\utility::_id_72EC("iw7_m4", "primary");
}

_id_21EE(var_0) {
  scripts\sp\utility::_id_F3DC(var_0.origin);
  scripts\sp\utility::_id_F3DD(1024);
  scripts\sp\anim::_id_17F6(self._id_1FBB, "pvo_moon_eth_theresanupgrade", ::_id_220F);
  var_0 scripts\sp\anim::_id_1F35(self, "armory_enter");
  var_0 thread scripts\sp\anim::_id_1EEA(self, "armory_c6i_idle", "armory_c6i_idle_end");

  if(!scripts\engine\utility::flag("armory_exit_active"))
    scripts\engine\utility::flag_waitopen("armory_action_active");

  thread _id_116E0();
  var_1 = 0;

  for(;;) {
    if(!scripts\engine\utility::flag("armory_exit_active"))
      scripts\engine\utility::flag_wait("armory_action_active");

    if(!scripts\engine\utility::flag("armory_exit_active")) {
      if(var_1 == 0 && scripts\engine\utility::flag("player_used_terminal")) {
        scripts\engine\utility::flag_set("armory_action_active");
        var_1 = 1;
        var_0 notify("armory_c6i_idle_end");
        var_0 scripts\sp\anim::_id_1F35(self, "armory_c6i_terminal_response");
        var_0 thread scripts\sp\anim::_id_1EEA(self, "armory_c6i_idle", "armory_c6i_idle_end");
        scripts\engine\utility::flag_clear("armory_action_active");
      }
    } else {
      var_0 notify("armory_c6i_idle_end");
      var_0 scripts\sp\anim::_id_1F35(self, "armory_c6i_exit");
      scripts\engine\utility::flag_clear("armory_action_active");
      break;
    }

    scripts\engine\utility::flag_waitopen("armory_action_active");
  }

  var_0 notify("armory_c6i_idle_end");
}

_id_116E0() {
  level.player waittill("armory_terminal_start");
  scripts\engine\utility::flag_set("player_used_terminal");
}

_id_220F(var_0) {
  wait 1.5;
  scripts\engine\utility::flag_set("armory_intro_done");
}

_id_21FD(var_0) {
  scripts\sp\utility::_id_F3DC(var_0.origin);
  scripts\sp\utility::_id_F3DD(1024);
  scripts\sp\utility::_id_51E1("casual_gun");
  var_0 scripts\sp\anim::_id_1F35(self, "armory_enter");
  var_0 thread scripts\sp\anim::_id_1EEA(self, "armory_guard_idle", "stop_loop");

  for(;;) {
    if(scripts\engine\utility::flag("armory_exit_open")) {
      scripts\engine\utility::delaythread(4, ::_id_2222);
      var_0 notify("stop_loop");
      var_0 scripts\sp\anim::_id_1F35(self, "armory_guard_exit");
      scripts\engine\utility::flag_clear("armory_action_active");
      break;
    }

    wait 0.1;
  }
}

_id_2222() {
  var_0 = getEnt("armory_exit_door", "targetname");
  var_1 = getEnt("armory_exit_door_clip", "targetname");
  var_1 linkTo(var_0);
  var_0 showpart("tag_unlocked");
  var_0 rotateYaw(-160, 2.5, 0.3, 0.3);
  wait 2.5;
  var_1 connectpaths();
}

_id_222C() {
  var_0 = getEntArray("armory_emp_glow", "targetname");

  foreach(var_2 in var_0)
  var_2 scripts\sp\utility::_id_9196(3, 1, 1, "default");

  wait 1.0;
  var_4 = var_0[0];
  var_5 = scripts\engine\utility::getStructArray("emp_pickup", "script_noteworthy");

  foreach(var_7 in var_5) {
    if(isDefined(var_7.script_linkname) && issubstr(var_7.script_linkname, "armory_emp_interact"))
      var_4 = var_7._id_99F7;
  }

  if(var_4 == var_0[0]) {
    return;
  }
  var_9 = getEnt("armory_rack_shotgun", "targetname");
  var_10 = getEnt("armory_rack_lmg", "targetname");
  var_9 scripts\sp\utility::_id_9196(3, 1, 1, "default");
  var_10 scripts\sp\utility::_id_9196(3, 1, 1, "default");
  var_4 thread _id_83E3(var_0);
  var_9 thread _id_83E7();
  var_10 thread _id_83E6();
}

_id_83E3(var_0) {
  self waittill("trigger");

  foreach(var_2 in var_0)
  var_2 scripts\sp\utility::_id_9193();
}

_id_83E7() {
  scripts\engine\utility::flag_wait("player_grabbed_shotgun");
  scripts\sp\utility::_id_9193();
}

_id_83E6() {
  scripts\engine\utility::flag_wait("player_grabbed_lmg");
  scripts\sp\utility::_id_9193();
}

_id_222A() {
  level endon("player_got_everything");
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = 0;

  for(var_5 = 0; !scripts\engine\utility::flag("armory_exit_active"); var_3 = undefined) {
    var_6 = level.player scripts\engine\utility::waittill_any_return("picked_up_equipment", "weapon_change");

    if(var_6 == "weapon_change") {
      var_4 = 0;
      var_5 = 0;
      var_0 = level.player getweaponslistall();

      if(isDefined(var_0) && var_0.size > 0) {
        foreach(var_8 in var_0) {
          var_9 = getweaponbasename(var_8);

          if(weaponclass(var_9) == "spread") {
            var_4 = 1;
            scripts\engine\utility::flag_set("player_grabbed_shotgun");
          }

          if(weaponclass(var_9) == "mg") {
            var_5 = 1;
            scripts\engine\utility::flag_set("player_grabbed_lmg");
          }

          if(var_4 && var_5)
            scripts\engine\utility::flag_set("player_grabbed_weapons");
        }
      }
    } else if(var_6 == "picked_up_equipment") {
      var_2 = level.player scripts\sp\utility::_id_7BD6();
      var_3 = level.player scripts\sp\utility::_id_7CAF();

      if(isDefined(var_2))
        var_1 = [var_2];

      if(isDefined(var_3)) {
        if(isDefined(var_1))
          var_1 = scripts\engine\utility::array_add(var_1, var_3);
        else
          var_1 = [var_3];
      }

      if(isDefined(var_1) && scripts\engine\utility::array_contains(var_1, "emp")) {
        level.player giveweapon("emp");
        _id_0A2F::_id_66A4("emp");
        scripts\engine\utility::flag_set("player_grabbed_emps");
      }
    }

    if(scripts\engine\utility::flag("player_grabbed_weapons") && scripts\engine\utility::flag("player_grabbed_emps"))
      scripts\engine\utility::flag_set("armory_exit_active");

    scripts\engine\utility::flag_set("armory_action_active");
    scripts\engine\utility::waitframe();
    scripts\engine\utility::flag_clear("armory_action_active");
    var_0 = undefined;
    var_1 = undefined;
    var_2 = undefined;
  }
}

_id_222B(var_0) {
  scripts\engine\utility::flag_wait("armory_intro_done");
  wait 6;
  var_1 = 0;
  var_2 = [24, 48, 60, 120];

  while(!scripts\engine\utility::flag("player_grabbed_lmg") || !scripts\engine\utility::flag("player_grabbed_shotgun") || !scripts\engine\utility::flag("player_grabbed_emps")) {
    if(_id_8AA4(var_0)) {
      wait(var_2[var_1] + randomfloatrange(0, 2));
      var_1 = var_1 + 1;

      if(var_1 >= var_2.size)
        var_1 = var_2.size - 1;
    }

    if(_id_8AA3(var_0)) {
      wait(var_2[var_1] + randomfloatrange(0, 2));
      var_1 = var_1 + 1;

      if(var_1 >= var_2.size)
        var_1 = var_2.size - 1;
    }
  }
}

_id_8AA4(var_0) {
  scripts\engine\utility::flag_waitopen("armory_action_active");

  if(scripts\engine\utility::flag("player_grabbed_shotgun") && scripts\engine\utility::flag("player_grabbed_lmg"))
    return 0;

  scripts\engine\utility::flag_set("armory_action_active");
  var_0 notify("armory_xo_idle_end");
  var_0 scripts\sp\anim::_id_1F35(level.allies["salter"], "armory_xo_gun_nag");

  if(scripts\engine\utility::flag("player_grabbed_shotgun") && scripts\engine\utility::flag("player_grabbed_lmg")) {
    scripts\engine\utility::flag_clear("armory_action_active");
    return 0;
  }

  var_0 thread scripts\sp\anim::_id_1EEA(level.allies["salter"], "armory_xo_idle", "armory_xo_idle_end");
  scripts\engine\utility::flag_clear("armory_action_active");
  return 1;
}

_id_8AA3(var_0) {
  scripts\engine\utility::flag_waitopen("armory_action_active");
  scripts\engine\utility::waitframe();

  if(scripts\engine\utility::flag("player_grabbed_emps"))
    return 0;

  scripts\engine\utility::flag_set("armory_action_active");
  var_0 notify("armory_mco_idle_end");
  var_0 scripts\sp\anim::_id_1F35(level.allies["marineCO"], "armory_mco_grenade_nag");

  if(scripts\engine\utility::flag("player_grabbed_emps")) {
    scripts\engine\utility::flag_clear("armory_action_active");
    return 0;
  }

  var_0 thread scripts\sp\anim::_id_1EEA(level.allies["marineCO"], "armory_mco_idle", "armory_mco_idle_end");
  scripts\engine\utility::flag_clear("armory_action_active");
  return 1;
}

_id_8A1C() {}

_id_8A1B() {
  _id_8A1C();
}

_id_8A2F() {
  scripts\sp\maps\moon_port\moon_port_util::_id_968A();
  thread scripts\sp\maps\moon_port\moon_port_util::_id_BB2C("hangar");
  scripts\sp\maps\moon_port\moon_port_util::_id_BC53("start_hangar_combat");
  var_0 = ["marineCO", "salter", "eth3n", "mdf1"];
  scripts\sp\maps\moon_port\moon_port_util::_id_BC05("start_hangar_combat", var_0);
  level.allies["marineCO"] scripts\sp\utility::_id_F3B5("g");
  level.allies["mdf1"] scripts\sp\utility::_id_F3B5("g");
  wait 0.1;
  scripts\sp\utility::_id_15F5("hangar_allies_leave_armory");
  scripts\sp\utility::_id_15F3("hangar_spawn_bravo");
  wait 0.1;
  scripts\sp\utility::_id_15F5("hangar_bravo_init_color");
  scripts\sp\utility::_id_15F5("hangar_allies_leave_armory");
  level.player assignweaponoffhandsecondary("offhandshield");
  level.player giveweapon("emp");
}

_id_EAFC() {
  for(var_0 = scripts\sp\utility::_id_7951(level.player.origin, level.player.angles, level.allies["salter"].origin); var_0 <= 0.2; var_0 = scripts\sp\utility::_id_7951(level.player.origin, level.player.angles, level.allies["salter"].origin))
    scripts\engine\utility::waitframe();

  if(isDefined(level._id_EADC))
    level._id_EADC hide();

  level.allies["salter"] thread scripts\sp\utility::_id_19FA("iw7_m4", "iw7_m8+m8scope_sp", 1024, 1);
}

_id_8A2D() {
  scripts\engine\utility::flag_set("player_indoor_p2_noblur");
  var_0 = ["brooks", "kashima"];
  scripts\sp\maps\moon_port\moon_port_util::_id_BC05("start_hangar_combat", var_0);
  level.allies["brooks"] scripts\sp\utility::_id_72EC("iw7_ar57+ar57scope", "primary");
  level.allies["kashima"] scripts\sp\utility::_id_72EC("iw7_fhr+reflexsmg", "primary");
  level.allies["salter"] scripts\sp\utility::_id_F3B5("r");
  thread _id_EAFC();
  thread _id_1693();
  thread _id_8A2C();
  thread _id_8AD2();
  thread _id_8A2E();
  scripts\engine\utility::flag_wait("hangar_player_at_entrance");
  scripts\sp\utility::_id_28D8("allies");
  scripts\sp\utility::_id_28D8("axis");
  scripts\sp\utility::_id_CF8D();
  thread _id_618A();

  while(scripts\sp\utility::_id_77DB("hangar_wave_1") > 5 && scripts\engine\utility::flag("hangar_player_at_entrance") && !scripts\engine\utility::flag("hangar_player_rush_wave_1"))
    wait 0.2;

  scripts\sp\maps\moon_port\moon_port_util::_id_F293("hangar_wave_1", "goalvol_second_enemy_front");
  wait 1;
  scripts\sp\utility::_id_15F5("hangar_allies_push_0");
  scripts\engine\utility::delaythread(4.5, scripts\sp\maps\moon_port\moon_port_util::_id_F293, "hangar_wave_1_top", "goalvol_first_enemy_balcony_backroom");
  wait 3;

  while(scripts\sp\utility::_id_77DB("hangar_wave_1") > 4 && !scripts\engine\utility::flag("hangar_first_full_retreat"))
    wait 0.2;

  scripts\sp\maps\moon_port\moon_port_util::_id_F293("hangar_wave_1", "goalvol_third_enemy_front");
  var_1 = scripts\sp\maps\moon_port\moon_port_concourse::_id_78AE();
  var_1 thread scripts\sp\utility::_id_10347("moon_sdf4_fallback");
  scripts\sp\utility::_id_15F3("hangar_second_reinforce");
  thread _id_8AC5();
  scripts\engine\utility::delaythread(2.0, scripts\sp\utility::_id_15F5, "hangar_allies_push_1");
  scripts\sp\utility::_id_15F3("hangar_second_reinforce_top");
  scripts\sp\utility::_id_22CD("hangar_sniper", 1);
  scripts\engine\utility::flag_wait("hangar_spawn_control_room_interior");
  wait 8.0;
  var_2 = getaiarray("axis");
  var_3 = scripts\sp\utility::_id_77DA("hangar_wave_1_top");
  var_4 = scripts\sp\utility::_id_77DA("hangar_back_top");
  var_5 = scripts\sp\utility::_id_77DA("hangar_control_wave");
  var_2 = scripts\engine\utility::array_remove_array(var_2, var_3);
  var_2 = scripts\engine\utility::array_remove_array(var_2, var_4);
  var_2 = scripts\engine\utility::array_remove_array(var_2, var_5);
  var_6 = getEnt("goalvol_third_enemy_front", "targetname");

  foreach(var_8 in var_2)
  var_8 _meth_82F1(var_6);

  var_10 = getEnt("goalvol_first_enemy_balcony_backroom", "targetname");
  var_6 = getEnt("goalvol_second_enemy_balcony_backroom_1", "targetname");
  var_11 = var_10 scripts\sp\utility::_id_77E3("axis");

  foreach(var_8 in var_11) {
    if(var_8._id_1FEC == "generic_human") {
      var_8 _meth_82F1(var_6);
      break;
    }
  }

  scripts\engine\utility::flag_wait("hangar_player_after_first_wallrun");
  thread _id_8AA9();
  thread _id_8AC4();
  wait 5.0;
  var_14 = getEnt("goalvol_third_enemy_front", "targetname");

  for(;;) {
    var_15 = var_14 scripts\sp\utility::_id_77E3("axis");

    if(var_15.size < 4 || scripts\engine\utility::flag("hangar_spawn_control_room_exterior")) {
      break;
    }

    wait 0.5;
  }

  scripts\engine\utility::delaythread(2.5, scripts\sp\utility::_id_15F5, "hangar_allies_push_2");
  scripts\sp\utility::_id_15F3("hangar_control_room_final_reinforcements");
  scripts\sp\maps\moon_port\moon_port_util::_id_F293("hangar_truck_wave", "hangar_back_front_vol");
  scripts\sp\maps\moon_port\moon_port_util::_id_F293("hangar_wave_1", "hangar_back_front_vol");
  scripts\sp\utility::_id_15F5("hangar_killspawner_515");
  scripts\engine\utility::flag_wait("hangar_player_past_back_front");
  wait 8.0;
  var_14 = getEnt("hangar_back_front_vol", "targetname");
  var_6 = getEnt("goalvol_hangar_control_room_inner", "targetname");

  for(;;) {
    if(scripts\engine\utility::flag("hangar_player_pushing_on_control_room")) {
      break;
    }

    var_15 = var_14 scripts\sp\utility::_id_77E3("axis");

    if(var_15.size <= 4) {
      foreach(var_8 in var_15)
      var_8 _meth_82F1(var_6);

      break;
    }

    wait 0.5;
  }

  if(scripts\engine\utility::flag("hangar_player_pushing_on_control_room"))
    setthreatbias("axis", "player", 1000);

  level notify("hangar_skip_truck_front_push");
  var_18 = getEnt("hangar_allies_push_final", "targetname");
  wait 8;

  if(!scripts\engine\utility::flag("hangar_doors_open"))
    scripts\sp\utility::_id_15F5("hangar_allies_push_final");

  var_19 = getnodearray("hangar_node_kill", "script_noteworthy");

  foreach(var_21 in var_19)
  var_21 _meth_80AC();

  scripts\engine\utility::flag_wait("hangar_doors_open");
  thread _id_8A31();
  _id_0B77::_id_A67F(520);
  _id_0B77::_id_A67F(522);
  _id_0B77::_id_A67F(515);
  _id_0B77::_id_A67F(505);
  _id_0B77::_id_A67F(508);
  _id_0B77::_id_A67F(525);
  wait 1;
  scripts\sp\maps\moon_port\moon_port_util::_id_137F8(4);
  var_23 = getaiarray("axis");
  var_24 = getEnt("goalvol_hangar_control_room_inner", "targetname");

  foreach(var_26 in var_23) {
    var_26 _meth_82F1(var_24);
    var_26 thread _id_8A52();
  }

  scripts\sp\maps\moon_port\moon_port_util::_id_137F8(0);
  thread _id_8A2B();
}

_id_1693() {
  var_0 = getEnt("hangar_launcher", "targetname");
  var_0 itemweaponsetammo(1, 2);
}

_id_8A2E() {
  thread _id_8A3A("hangar_peek_door_1");
  thread _id_8A3A("hangar_peek_door_2");
}

_id_8A3A(var_0) {
  thread _id_D053();

  if(var_0 == "hangar_peek_door_1") {
    var_1 = "hangar_peek_door_2";
    var_2 = 60;
  } else {
    var_1 = "hangar_peek_door_1";
    var_2 = 30;
  }

  thread _id_0B1E::_id_59BE(var_0);

  if(var_0 == "hangar_peek_door_2")
    thread _id_59D0(var_0);

  level waittill(var_0 + "door_peek_start");
  level.allies["salter"] scripts\engine\utility::delaythread(1, scripts\sp\utility::_id_10346, "moon_slt_useagrenadereyes");
  createthreatbiasgroup("doorpeekers");
  level.player setthreatbiasgroup("player");
  var_3 = scripts\sp\utility::_id_22CD("hangar_door_peek_enemies");

  foreach(var_5 in var_3) {
    var_5.fixednode = 1;
    var_5 scripts\sp\utility::_id_51E1("combat");
    var_5 setthreatbiasgroup("doorpeekers");
    var_5.health = 50;
  }

  setthreatbias("doorpeekers", "player", 1000);
  var_7 = _id_0B1E::_id_794C(var_0);

  while(var_7 < var_2) {
    var_7 = _id_0B1E::_id_794C(var_0);
    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::flag_set("hangar_doors_open");
  thread _id_11626(var_1);
  _id_0B1E::_id_59D9(var_1, 0.5);
  level waittill(var_0 + "door_peek_finished");
  var_3 = scripts\sp\utility::array_removedeadvehicles(var_3);

  if(var_3.size > 0) {
    foreach(var_5 in var_3) {
      var_5.fixednode = 0;
      var_5 scripts\sp\utility::_id_51E1("frantic");
    }
  }
}

_id_59D0(var_0) {
  scripts\engine\utility::waitframe();
  level._id_5A23[var_0]._id_4C1C = "hangar_door_closed";
  level._id_5A23[var_0]._id_5A2A rotateTo(level._id_5A23[var_0]._id_5A24 + (0, -140, 0), 0.05, 0.0, 0.0);
  level._id_5A23[var_0]._id_5A03 connectpaths();
  scripts\engine\utility::flag_wait("hangar_player_pushing_on_control_room");
  level._id_5A23[var_0]._id_5A2A rotateTo(level._id_5A23[var_0]._id_5A24, 0.5, 0.0, 0.0);
  wait 0.1;
  level._id_5A23[var_0]._id_5978 playSound("scn_doorpeek_door_slam");
  wait 0.4;
  level._id_5A23[var_0]._id_5A03 disconnectPaths();
  var_1 = getcorpsearray();

  foreach(var_3 in var_1) {
    if(distance(var_3.origin, level._id_5A23[var_0]._id_5A2A.origin) < 100)
      var_3 delete();
  }

  scripts\engine\utility::waitframe();
  scripts\engine\utility::flag_set("hangar_door_closed");
}

_id_D053() {
  level endon("hangar_peek_door_1door_peek_finished");
  level endon("hangar_peek_door_2door_peek_finished");
  var_0 = scripts\engine\utility::getStructArray("hangar_peek_door_1", "script_noteworthy");
  var_1 = scripts\engine\utility::getStructArray("hangar_peek_door_2", "script_noteworthy");
  scripts\engine\utility::flag_wait("hangar_player_in_control_room");
  scripts\engine\utility::flag_set("hangar_doors_open");
  scripts\sp\utility::_id_15F5("hangar_allies_push_control_room");
  level.allies["marineCO"] _meth_83B9(var_0[0].origin, var_0[0].angles);
  level.allies["eth3n"] _meth_83B9(var_1[0].origin, var_1[0].angles);
  _id_0B1E::_id_59D9("hangar_peek_door_1", 0.5);
  _id_0B1E::_id_59D9("hangar_peek_door_2", 0.5);
  var_2 = getaiarray("allies");

  foreach(var_4 in var_2)
  var_4 scripts\sp\utility::_id_51E1("cqb");

  wait 5.5;
  var_2 = scripts\sp\utility::array_removedeadvehicles(var_2);

  foreach(var_4 in var_2)
  var_4 scripts\sp\utility::_id_4145();
}

_id_11626(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0, "script_noteworthy");
  scripts\sp\utility::_id_15F5("hangar_allies_push_control_room");
  level.allies["salter"] _meth_83B9(var_1[0].origin, var_1[0].angles);
  level.allies["marineCO"] _meth_83B9(var_1[1].origin, var_1[1].angles);
  level.allies["eth3n"] _meth_83B9(var_1[2].origin, var_1[2].angles);
  var_2 = getaiarray("allies");

  foreach(var_4 in var_2)
  var_4 scripts\sp\utility::_id_51E1("cqb");

  wait 5.5;

  foreach(var_4 in var_2)
  var_4 scripts\sp\utility::_id_4145();
}

_id_8A52() {
  self endon("death");

  if(scripts\common\trace::ray_trace_passed(level.player getEye(), self getEye()))
    wait 5.0;

  var_0 = randomintrange(5, 10);

  for(;;) {
    if(scripts\common\trace::ray_trace_passed(level.player getEye(), self getEye())) {
      wait(randomintrange(3, 6));
      continue;
    }

    if(isDefined(self._id_B14F) && self._id_B14F)
      scripts\sp\utility::_id_1101B();

    self _meth_81D0();
  }
}

_id_618A() {
  level endon("hangar_emps_used");
  thread _id_618C();
  scripts\engine\utility::flag_wait("hangar_initial_dialogue_done");
  level.allies["salter"] scripts\sp\utility::_id_10346("moon_slt_botsonthelowerd");

  if(!isDefined(level.player.melee))
    scripts\sp\utility::_id_56BE("hint_emp_tutorial", 5);
}

_id_615C() {
  return scripts\engine\utility::flag("hangar_emps_used");
}

_id_618C() {
  var_0 = scripts\sp\utility::_id_77DA("hangar_wave_1");

  foreach(var_2 in var_0)
  var_2 thread _id_613F();

  level waittill("enemy_EMPd");
  scripts\engine\utility::flag_set("hangar_emps_used");
  level.allies["salter"] scripts\sp\utility::_id_10346("moon_slt_theyrestunnedkill");
  wait 6.0;
  level waittill("enemy_EMPd");
  level.allies["salter"] scripts\sp\utility::_id_10346("moon_slt_takeemout");
}

_id_613F() {
  self endon("death");

  for(;;) {
    if(isDefined(self._id_9DD2) && self._id_9DD2)
      level notify("enemy_EMPd");

    wait 0.1;
  }
}

_id_8AA9() {
  scripts\engine\utility::flag_wait("hangar_player_first_perch");
  scripts\sp\utility::_id_15F3("hangar_third_reinforce_top");
  wait 30;

  if(!scripts\engine\utility::flag("hangar_player_first_perch")) {
    return;
  }
  var_0 = getEnt("goalvol_second_enemy_balcony_backroom_1", "targetname");

  for(;;) {
    var_1 = var_0 scripts\sp\utility::_id_77E3("axis");

    if(var_1.size <= 2 || scripts\engine\utility::flag("hangar_spawn_control_room_interior")) {
      break;
    }

    wait 0.5;
  }

  var_2 = getEnt("goalvol_first_enemy_balcony_backroom", "targetname");

  if(level.allies["salter"] istouching(var_2)) {
    scripts\sp\utility::_id_15F5("salter_to_third_perch");
    level.allies["salter"] scripts\sp\utility::_id_10346("moon_slt_wehavethemomentum");
  }
}

_id_8AC5() {
  scripts\engine\utility::flag_wait("hangar_spawn_last_perch");
  scripts\sp\utility::_id_15F3("hangar_last_perch_reinforce");
}

_id_8A0F() {
  wait 2;
  scripts\sp\utility::_id_15F5("hangar_allies_push_3");
  level endon("hangar_skip_truck_front_push");
  var_0 = getEnt("goalvol_second_enemy_balcony_backroom_2", "targetname");

  for(;;) {
    var_1 = var_0 scripts\sp\utility::_id_77E3("axis");

    if(var_1.size <= 0) {
      break;
    }

    wait 0.5;
  }
}

_id_8AC4() {
  scripts\engine\utility::flag_wait("hangar_spawn_control_room_interior");

  while(getaicount("all") > 20)
    wait 0.5;

  scripts\sp\utility::_id_15F3("hangar_control_room_enemies_interior");
  scripts\engine\utility::flag_wait("hangar_spawn_control_room_exterior");
  scripts\sp\utility::_id_15F3("hangar_control_room_enemies_exterior");
}

_id_8A31() {
  scripts\engine\utility::flag_wait("hangar_retreat_to_control_room");
  var_0 = getaiarray("axis");
  var_1 = getEnt("goalvol_hangar_control_room_inner", "targetname");

  foreach(var_3 in var_0)
  var_3 _meth_82F1(var_1);

  wait 1;
}

_id_8A2C() {
  var_0 = scripts\engine\utility::getStruct("hangar_grenade_explosion", "targetname");
  scripts\engine\utility::flag_wait("player_at_hangar_window");
  magicgrenade("frag", var_0.origin, var_0.origin, 1, 0);
  setmusicstate("mx_452_moonport_exfil");
  scripts\sp\utility::_id_1034D("moon_plr_wegotalliedtroops");
  level.allies["eth3n"] scripts\sp\utility::_id_10346("moon_eth_goteyesonbravo");
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_omr_brookskashimawhatsyour");
  level.allies["brooks"] scripts\sp\utility::_id_10346("moon_brk_takingheavyfire");
  scripts\sp\utility::_id_1034D("moon_plr_wereatyoursix");
  level.allies["kashima"] scripts\sp\utility::_id_10346("moon_ksh_rogerthat");
  scripts\engine\utility::flag_set("hangar_initial_dialogue_done");
  scripts\engine\utility::flag_wait("hangar_first_full_retreat");
  level.allies["brooks"] scripts\sp\utility::_id_10346("moon_brk_captainstaffser");
  level.allies["kashima"] scripts\sp\utility::_id_10346("moon_ksh_werekneedeepins");
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_omr_hardenupson");
  scripts\engine\utility::flag_wait("hangar_player_past_back_front");
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_omr_allcallsignsalp");
  level waittill("hangar_skip_truck_front_push");
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_omr_wereclearingthem");
}

_id_8A11() {
  var_0 = scripts\engine\utility::getStruct("hangar_antigrav_explosion_1", "targetname");
  var_1 = scripts\engine\utility::getStruct("hangar_antigrav_explosion_2", "targetname");
  scripts\sp\utility::_id_127B3("hangar_antigrav_trigger");
  magicgrenade("antigrav", var_0.origin, var_0.origin, 20, 0);
  wait 5;
  magicgrenade("antigrav", var_1.origin, var_1.origin, 20, 0);
}

_id_8AD2() {
  level.player setthreatbiasgroup("player_and_salter");
  level.allies["salter"] setthreatbiasgroup("player_and_salter");
  level.allies["marineCO"] setthreatbiasgroup("player_and_salter");
  level.allies["eth3n"] setthreatbiasgroup("player_and_salter");
  setthreatbias("hangar_enemies_bottom", "player_and_salter", -500);
  setthreatbias("hangar_enemies_top", "player_and_salter", 800);
  setthreatbias("hangar_enemies_bottom", "hangar_bravo", 800);
  setthreatbias("hangar_enemies_top", "hangar_bravo", -500);
  setthreatbias("hangar_bravo", "hangar_enemies_bottom", 800);
  setthreatbias("player_and_salter", "hangar_enemies_bottom", -500);
  scripts\engine\utility::flag_wait("hangar_player_rush_wave_1");
  level.allies["marineCO"] setthreatbiasgroup("hangar_bravo");
  level.allies["eth3n"] setthreatbiasgroup("hangar_bravo");
}

_id_8A2B() {}

_id_8A2A() {
  var_0 = getEnt("hangar_allies_push_final", "targetname");

  if(isDefined(var_0))
    var_0 delete();

  _id_8A2B();
}

_id_8A4B() {
  scripts\sp\maps\moon_port\moon_port_util::_id_968A();
  thread scripts\sp\maps\moon_port\moon_port_util::_id_BB2C("hangar");
  scripts\sp\maps\moon_port\moon_port_util::_id_BC53("start_hangar_end");
  var_0 = ["marineCO", "salter", "eth3n", "mdf1", "brooks", "kashima"];
  scripts\sp\maps\moon_port\moon_port_util::_id_BC05("start_hangar_end", var_0);
}

_id_8A4A() {
  scripts\engine\utility::flag_set("player_indoor_p2");
  setsaveddvar("sm_roundRobinPrioritySpotShadows", 6);
  scripts\sp\utility::_id_15F5("hangar_squad_take_control_room");
  scripts\sp\utility::_id_15F5("hangar_allies_take_control_room");
  scripts\sp\utility::_id_28D7("allies");
  scripts\sp\utility::_id_28D7("axis");
  scripts\sp\utility::_id_CF8B();

  foreach(var_1 in level.allies) {
    var_1 scripts\sp\utility::_id_F415(1);
    var_1 _meth_8250(1);
    var_1 scripts\sp\utility::_id_414F();
  }

  thread _id_8A49();
  var_3 = getEntArray("hangar_control_room_extra_mdf", "targetname");

  foreach(var_5 in var_3)
  var_5 scripts\sp\utility::_id_10619();

  thread _id_A1FD();
  scripts\engine\utility::flag_wait("hangar_player_in_control_room");
  var_7 = scripts\engine\utility::getStruct("secure_scene", "targetname");
  var_8 = scripts\engine\utility::getStruct("secure_inner_scene", "targetname");
  level.player thread _id_F527(250, var_7, "relaxed");
  level.allies["mdf1"] thread _id_F0D7(var_7, var_8);
  level.allies["eth3n"] thread _id_F0D6(var_7, var_8);
  level.allies["brooks"] thread _id_F0D5();
  level.allies["kashima"] thread _id_F0D8();
  var_9 = getnode("secure_room_outer_mco", "targetname");
  level.allies["marineCO"] thread _id_F34F(225, var_9, "casual_gun");
  level.allies["salter"] thread _id_F0DB(var_7, var_8);
  level.allies["marineCO"] thread _id_F0D9(var_7, var_8);
  var_3 = getEntArray("hangar_control_room_extra_mdf", "targetname");

  foreach(var_5 in var_3)
  var_5 scripts\sp\utility::_id_10619();

  level.doors["hangar_door"] waittill("player_at_door");
  wait 0.5;
  scripts\engine\utility::flag_set("secure_player_opened_door");
  setmusicstate("mx_118_moonport_shutter");
  _id_519B();
  scripts\sp\utility::_id_12651(["moon_port_base_in_tr", "moon_port_hangar_halls_tr", "moon_port_hangar_tr"]);
  scripts\engine\utility::delaythread(2, ::_id_A1FF);
  var_12 = getEnt("hangar_elevator", "targetname");
  var_13 = getEntArray("hangar_elevator_wheels", "targetname");

  foreach(var_15 in var_13)
  var_15 linkTo(var_12);

  level.allies["eth3n"] linkTo(var_12);
  level.allies["salter"] linkTo(var_12);
  level.allies["marineCO"] linkTo(var_12);
  var_12 _meth_80AF(undefined);
  var_17 = getEnt("elevator_upper_door", "targetname");
  var_18 = getEnt("elevator_upper_door_clip", "targetname");
  var_18 hide();
  wait 19.8;
  var_17 thread scripts\sp\utility::play_sound_on_entity("scn_moon_hangar_elevator_door_open");
  var_17 movez(95, 2, 0.2, 0.2);
  var_19 = getEnt("hangar_elevator_volume", "targetname");

  for(;;) {
    var_20 = var_19 scripts\sp\utility::_id_77E3("allies");

    if(level.player istouching(var_19) && var_20.size == 3) {
      break;
    }

    wait 0.5;
  }

  var_18 show();
  var_17 thread scripts\sp\utility::play_sound_on_entity("scn_moon_hangar_elevator_door_close");
  var_17 movez(-95, 0.5, 0.1, 0.1);
  scripts\engine\utility::flag_set("hangar_elevator_go");
  var_12 _meth_83C9();
  var_12 thread _id_FB7C();
  var_12 movez(-208, 10.0, 0.5, 0.5);
  wait 2.0;
  var_12 _meth_80AF(undefined);
  var_21 = getnode("elevator_link_3", "targetname");
  var_22 = getnode("elevator_link_3_end", "targetname");
  createnavlink("elevator_link_3", var_21.origin, var_22.origin, var_21);
  var_23 = getnode("elevator_link_4", "targetname");
  var_24 = getnode("elevator_link_4_end", "targetname");
  createnavlink("elevator_link_4", var_23.origin, var_24.origin, var_23);
  wait 0.1;
  var_25 = getEnt("hangar_window_blocker", "targetname");

  if(isDefined(var_25))
    var_25 show();

  scripts\engine\utility::flag_set("hangar_end_done");
}

_id_FB7C() {
  thread scripts\sp\utility::play_sound_on_entity("scn_moon_hangar_elevator_start_lr");
  thread scripts\engine\utility::play_loop_sound_on_entity("scn_moon_hangar_elevator_loop_lr");
  wait 9.2;
  thread scripts\sp\utility::play_sound_on_entity("scn_moon_hangar_elevator_stop_lr");
  wait 0.5;
  thread scripts\engine\utility::stop_loop_sound_on_entity("scn_moon_hangar_elevator_loop_lr");
}

_id_8A49() {
  setmusicstate("");
  wait 1;
  level.allies["eth3n"] scripts\sp\utility::_id_10346("moon_eth_allclear");
  wait 0.5;
  level.allies["salter"] scripts\sp\utility::_id_10346("moon_slt_clear");
  wait 1.5;
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_mco_clearhangarsecure");
  level waittill("secure_mco_starting");
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_omr_brookskashima");
  scripts\engine\utility::flag_set("secure_outer_mco_done");
}

_id_8AC1() {
  level.doors["hangar_door"] waittill("door_sequence_complete");
  level.allies["salter"] scripts\sp\utility::_id_10346("moon_slt_whosgotclearance");
  level._id_45B5 scripts\sp\utility::_id_10346("moon_ms2_idosir");
  level.allies["salter"] scripts\sp\utility::_id_10346("moon_slt_fireitupweregoing");
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_omr_whatsyourcourse");
  scripts\sp\utility::_id_1034D("moon_plr_airassaultforce");
  level.allies["salter"] scripts\sp\utility::_id_10346("moon_slt_weregonnalaunch");
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_omr_alittlebeltfedd");
  scripts\sp\utility::_id_1034D("moon_plr_goodcauseyourec");
  level.allies["salter"] scripts\sp\utility::_id_10346("moon_slt_wellawareofthat");
  scripts\sp\utility::_id_1034D("moon_plr_thegroundphaseo");
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_omr_yougotspinecapt");
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_omr_myguysholdthisr");
  level.allies["salter"] scripts\sp\utility::_id_10346("moon_slt_noluckinvolvedp");
  level.allies["salter"] scripts\sp\utility::_id_10346("moon_slt_getthatelevator");
  level.allies["salter"] scripts\sp\utility::_id_10346("moon_slt_makesurethosejackals");
  level._id_45B5 scripts\sp\utility::_id_10346("moon_ms2_check");
  level.allies["eth3n"] scripts\sp\utility::_id_10346("moon_eth_whataremyorders");
  scripts\sp\utility::_id_1034D("moon_plr_fallinwithuseth");
  level.allies["eth3n"] scripts\sp\utility::_id_10346("moon_eth_yescaptain");
  level.allies["salter"] scripts\sp\utility::_id_10346("moon_slt_moveout");
}

_id_8A43() {
  wait 1.0;
  scripts\sp\utility::_id_1034D("moon_plr_omaryouridewith");
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_omr_thisisntadrillc");
  scripts\sp\utility::_id_1034D("moon_plr_ivechosenmyteam");
  level.allies["eth3n"] scripts\sp\utility::_id_10346("moon_eth_appreciatetheco");
  scripts\sp\utility::_id_1034D("moon_plr_letsgetairborne");
}

_id_519B() {
  var_0 = getEntArray("generic_door", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_parameters) && var_2.script_parameters == "armory")
      var_2 delete();
  }

  var_2 = getEnt("armory_exit_door", "targetname");
  var_2 delete();
  var_4 = getEnt("armory_rack_shotgun", "targetname");
  var_5 = getEnt("armory_rack_lmg", "targetname");
  var_4 delete();
  var_5 delete();
  var_6 = scripts\engine\utility::getStructArray("locker_node", "targetname");

  foreach(var_8 in var_6) {
    var_9 = getEntArray(var_8.target, "targetname");

    foreach(var_11 in var_9) {
      if(var_11.classname == "script_model")
        var_11 delete();
    }
  }

  clearallcorpses();
}

_id_F0DB(var_0, var_1) {
  self.pushable = 0;
  var_0 scripts\sp\anim::_id_1F17(self, "secure_enter");
  scripts\sp\utility::_id_51E1("casual_gun");
  scripts\engine\utility::flag_set("jackal_hangar_bays_open");
  var_0 scripts\sp\anim::_id_1F35(self, "secure_enter");
  var_0 thread scripts\sp\anim::_id_1EEA(self, "secure_xo_loop", "stop_loop");
  scripts\engine\utility::flag_wait("secure_outer_mco_done");
  wait 1;
  var_0 notify("stop_loop");
  waittillframeend;
  level notify("secure_salter_unlock_order");
  scripts\engine\utility::flag_set("salter_unlock_ordered");
  var_0 scripts\sp\anim::_id_1F35(self, "secure_xo_unlock");
  thread _id_F0DA(var_0);
  scripts\engine\utility::flag_wait("secure_player_opened_door");
  var_1 scripts\sp\anim::_id_1F35(self, "secure_room_xo");
  thread scripts\sp\anim::_id_1EEA(self, "secure_elev_idle", "stop_loop");
  var_2 = getEnt("hangar_elevator_volume", "targetname");
  thread _id_8A46(var_2);
  scripts\engine\utility::flag_wait("hangar_elevator_go");
  self notify("stop_loop");
  scripts\sp\anim::_id_1F35(self, "secure_elev");
  self setgoalpos(self.origin);
  self unlink();
  wait 3;
  self _meth_82EE(getnode("jackal_hangar_salter", "targetname"));
  self.pushable = 1;
}

_id_F0DA(var_0) {
  level endon("secure_player_opened_door");
  self.pushable = 0;

  for(var_1 = 8.0; !scripts\engine\utility::flag("secure_player_opened_door"); self.pushable = 0) {
    wait(var_1);

    if(var_1 < 25)
      var_1 = var_1 + 12;

    level.allies["salter"] scripts\sp\utility::_id_10346("moon_slt_letsgetintherer");
  }
}

#using_animtree("generic_human");

_id_F0D9(var_0, var_1) {
  self _meth_82EE(getnode("secure_room_outer_mco", "targetname"));
  self.goalradius = 8;
  self waittill("goal");
  wait 0.8;
  level notify("secure_mco_starting");
  scripts\engine\utility::flag_set("jackal_hangar_bays_open");
  scripts\engine\utility::flag_wait("secure_player_opened_door");
  scripts\sp\utility::_id_7799(level.player);
  var_1 scripts\sp\anim::_id_1F35(self, "secure_room_mco_enter");
  thread scripts\sp\anim::_id_1EEA(self, "secure_elev_idle", "stop_loop");
  scripts\engine\utility::flag_wait("hangar_elevator_go");
  self notify("stop_loop");
  scripts\sp\anim::_id_1F35(self, "secure_elev");
  self _meth_82A2(%hm_grnd_yel_casual_stand_exit_ar_2);
  self setgoalpos(self.origin);
  self unlink();
  wait 1;
  self _meth_82EE(getnode("jackal_hangar_co", "targetname"));
}

_id_F0D6(var_0, var_1) {
  var_2 = getnode("secure_ethan", "targetname");
  level.allies["eth3n"] thread scripts\sp\utility::_id_7226(var_2);
  thread _id_F34F(255, var_2, "casual_gun");
  scripts\engine\utility::flag_wait("secure_player_opened_door");
  var_1 scripts\sp\anim::_id_1F35(self, "secure_room_c6i");
  thread scripts\sp\anim::_id_1EEA(self, "secure_elev_idle", "stop_loop");
  scripts\engine\utility::flag_wait("hangar_elevator_go");
  self notify("stop_loop");
  scripts\sp\anim::_id_1F35(self, "secure_elev");
  self setgoalpos(self.origin);
  self unlink();
  wait 2;
  self _meth_82EE(getnode("jackal_hangar_eth3n", "targetname"));
}

_id_F0D5() {
  var_0 = getnode("secure_brooks", "targetname");
  level.allies["brooks"] thread scripts\sp\utility::_id_7226(var_0);
  thread _id_F34F(210, var_0, "casual_gun");
  scripts\engine\utility::flag_wait("secure_player_opened_door");
  wait 5.5;
  scripts\sp\maps\moon_port\moon_port_util::_id_1683(self, "secure_teleport_ally2");
  wait 0.1;
  self _meth_82EE(getnode("secure_room_ally2", "targetname"));
}

_id_F0D8() {
  var_0 = getnode("secure_kashima", "targetname");
  level.allies["kashima"] thread scripts\sp\utility::_id_7226(var_0);
  thread _id_F34F(245, var_0, "casual_gun");
  scripts\engine\utility::flag_wait("secure_player_opened_door");
  wait 7.5;
  scripts\sp\maps\moon_port\moon_port_util::_id_1683(self, "secure_teleport_ally1");
  wait 0.1;
  self _meth_82EE(getnode("secure_room_ally1", "targetname"));
}

_id_F0D7(var_0, var_1) {
  self _meth_8250(1);
  var_2 = getnode("secure_room_guard_door", "targetname");
  thread _id_F34F(250, var_2, "casual_gun");
  var_0 scripts\sp\anim::_id_1F0D(self, "secure_guard_unlock");
  self.pushable = 0;
  scripts\engine\utility::flag_wait("salter_unlock_ordered");
  var_3 = getnotetracktimes(level.allies["salter"] scripts\sp\utility::_id_7DC1("secure_xo_unlock"), "start_trooper_anim")[0];
  wait(var_3 * getanimlength(level.allies["salter"] scripts\sp\utility::_id_7DC1("secure_xo_unlock")));
  var_0 scripts\sp\anim::_id_1F17(self, "secure_guard_unlock");
  var_0 scripts\sp\anim::_id_1F35(self, "secure_guard_unlock");
  thread _id_599B();
  self setgoalpos(self.origin);
  scripts\engine\utility::flag_wait("secure_player_opened_door");
  wait 0.7;
  var_4 = scripts\sp\utility::_id_10639("secure_chair", var_1.origin, var_1.angles);
  var_1 thread scripts\sp\anim::_id_1F35(var_4, "secure_room_chair");
  var_1 scripts\sp\anim::_id_1F35(self, "secure_room_guard");
  var_1 thread scripts\sp\anim::_id_1EEA(self, "secure_room_guard_loop", "stop_loop");
}

_id_599B() {
  level.doors["hangar_door"] scripts\sp\utility::_id_65E1("hangar_activate_door");
  level.doors["hangar_door"] showpart("door_unlocked");
  level.doors["hangar_door"] hidepart("door_locked");
  level.doors["hangar_door"] hidepart("door_inactive");
  wait 0.3;
  level.doors["hangar_door"] _meth_84A4(5000);
}

_id_F34F(var_0, var_1, var_2) {
  while(distance(self.origin, var_1.origin) > var_0)
    wait 0.05;

  scripts\sp\utility::_id_51E1(var_2);
}

_id_F527(var_0, var_1, var_2) {
  while(distance(self.origin, var_1.origin) > var_0)
    wait 0.05;

  scripts\sp\utility::_id_F526(var_2);
}

_id_8A46(var_0) {
  level endon("hangar_elevator_go");
  var_1 = [8, 16, 32, 64];
  var_2 = 0;

  while(!level.player istouching(var_0)) {
    wait(var_1[var_2]);
    level.allies["salter"] scripts\sp\anim::_id_1F35(level.allies["salter"], "secure_elev_nag");
    wait 0.1;
    var_2 = var_2 + 1;

    if(var_2 >= 4) {
      break;
    }

    if(var_2 >= var_1.size - 1)
      var_2 = var_1.size - 1;
  }
}

_id_A1FD(var_0) {
  level._id_AA81 = scripts\sp\vehicle::_id_1080E("launch_jackals");
  level._id_AA8C = getEnt("player_jackal", "targetname");
  level._id_AA8C show();
  level._id_AA8C thread _id_A200(1, 3);
  level._id_AA81[0] thread _id_A200(2, 1);
  level._id_AA81[1] thread _id_A200(3, 2);
  level._id_AA81[2] thread _id_A200(4, 4);
  var_1 = 0.25;
  var_2 = 1;
  var_3 = 2;
  var_4 = 4;

  if(scripts\engine\utility::is_true(var_0)) {
    var_1 = 0.5;
    var_2 = 0.5;
    var_3 = 0.5;
    var_4 = 0.5;
  }

  scripts\engine\utility::flag_wait("jackal_hangar_bays_open");
  thread _id_8A9E();
  scripts\engine\utility::delaythread(1.5, scripts\engine\utility::exploder, "moon_hangar_jackal");
  thread _id_A1FE(var_1, "hangar_jackal_door_4");
  thread _id_A1FE(var_2, "hangar_jackal_door_3");
  thread _id_A1FE(var_3, "hangar_jackal_door_2");
  thread _id_A1FE(var_4, "hangar_jackal_door_1");
  scripts\engine\utility::flag_wait("hangar_elevator_go");

  if(!scripts\engine\utility::is_true(var_0))
    wait 5.0;

  thread _id_A1FB(var_1, "hangar_jackal_shield_1", "mn_launch_blastlight_on_4");
  thread _id_A1FB(var_2, "hangar_jackal_shield_2", "mn_launch_blastlight_on_3");
  thread _id_A1FB(var_3, "hangar_jackal_shield_3", "mn_launch_blastlight_on_2");
  thread _id_A1FB(var_4, "hangar_jackal_shield_4", "mn_launch_blastlight_on_1");
}

_id_8A9E() {
  level notify("mn_launch_jacklights_on_1");
  wait 2.0;
  level notify("mn_launch_jacklights_on_2");
  wait 2.0;
  level notify("mn_launch_jacklights_on_3");
  wait 2.0;
  level notify("mn_launch_jacklights_on_4");
}

_id_A1FE(var_0, var_1) {
  wait(var_0);
  var_2 = getEnt(var_1 + "_left", "targetname");
  var_3 = scripts\engine\utility::getStruct(var_1 + "_left", "targetname");
  var_4 = getEnt(var_1 + "_right", "targetname");
  var_5 = scripts\engine\utility::getStruct(var_1 + "_right", "targetname");
  var_6 = 2;
  var_2 thread _id_FB40(var_1);
  var_2 movez(-8, var_6, 0.1, 0.1);
  var_4 movez(-8, var_6, 0.1, 0.1);
  wait(var_6 + 0.2);
  var_6 = 6;
  var_2 thread _id_FB3F(var_6, var_1);
  var_2 moveTo(var_3.origin + (0, 0, 7), var_6, 0.1, 0.1);
  var_4 moveTo(var_5.origin + (0, 0, 7), var_6, 0.1, 0.1);
}

_id_FB3F(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  switch (var_1) {
    case "hangar_jackal_door_1":
      var_2 = "01";
      var_6 = (18351, 18454, -54611);
      break;
    case "hangar_jackal_door_2":
      var_2 = "02";
      var_6 = (18222, 18964, -54611);
      break;
    case "hangar_jackal_door_3":
      var_2 = "03";
      var_6 = (17794, 19039, -54611);
      break;
    case "hangar_jackal_door_4":
      var_2 = "04";
      var_6 = (17787, 19569, -54611);
      break;
    default:
      var_2 = "01";
      var_6 = self.origin;
  }

  var_3 = "scn_moon_hangar_bay_open_start_" + var_2;
  var_4 = "scn_moon_hangar_bay_open_stop_" + var_2;
  var_5 = "scn_moon_hangar_bay_open_lp_" + var_2;
  var_7 = spawn("script_origin", var_6);
  thread scripts\engine\utility::play_sound_in_space(var_3, var_6);
  wait 1.0;
  var_7 thread scripts\engine\utility::play_loop_sound_on_entity(var_5);
  wait(var_0 - 1.3);
  thread scripts\engine\utility::play_sound_in_space(var_4, var_6);
  var_7 thread scripts\engine\utility::stop_loop_sound_on_entity(var_5);
  var_7 delete();
}

_id_FB40(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "hangar_jackal_door_1":
      var_1 = "01";
      var_2 = (18351, 18454, -54611);
      break;
    case "hangar_jackal_door_2":
      var_1 = "02";
      var_2 = (18222, 18964, -54611);
      break;
    case "hangar_jackal_door_3":
      var_1 = "03";
      var_2 = (17794, 19039, -54611);
      break;
    case "hangar_jackal_door_4":
      var_1 = "04";
      var_2 = (17787, 19569, -54611);
      break;
    default:
      var_1 = "01";
      var_2 = self.origin;
  }

  wait 1;
  var_3 = "scn_moon_hangar_bay_steam_" + var_1;
  thread scripts\engine\utility::play_sound_in_space(var_3, var_2);
}

_id_A200(var_0, var_1) {
  var_2 = "jackal_lift_" + var_0;
  var_3 = scripts\engine\utility::getStruct("jackal_hangar_lift_" + var_0, "targetname");

  if(isDefined(self._blackboard)) {
    _id_0BDC::_id_6B4C("none", 1);
    _id_0BDC::_id_19A2();
  }

  var_4 = getEnt("hangar_jackal_platform_" + var_1, "targetname");
  var_4 movez(2, 0.05);
  wait 1.0;
  var_5 = scripts\engine\utility::spawn_tag_origin(var_4.origin + (0, 0, 85), self.angles);
  var_6 = scripts\engine\utility::spawn_tag_origin(var_4.origin + (100, 109, 0), self.angles);
  var_7 = scripts\engine\utility::spawn_tag_origin(var_4.origin + (-220, -240, 0), self.angles);
  var_8 = scripts\sp\utility::_id_10639("launch_jackal_periph", self.origin + (0, 0, -19), self.angles);
  self._id_1FBB = "launch_jackal";
  self hide();
  var_3 scripts\sp\anim::_id_1EC3(var_8, var_2);
  var_3 scripts\sp\anim::_id_1EC3(self, var_2);
  var_4 linkTo(self, "TAG_ORIGIN");
  var_5 linkTo(self, "TAG_ORIGIN");
  var_6 linkTo(self, "TAG_ORIGIN");
  var_7 linkTo(self, "TAG_ORIGIN");
  playFXOnTag(level._effect["vfx_jackal_nitrogen_vent"], var_5, "TAG_ORIGIN");
  playFXOnTag(level._effect["vfx_sc_steam_vent_elevator_med_01"], var_6, "TAG_ORIGIN");
  playFXOnTag(level._effect["vfx_sc_steam_vent_elevator_med_01"], var_7, "TAG_ORIGIN");
  scripts\engine\utility::flag_wait("hangar_elevator_go");
  self show();
  var_8 delete();
  thread _id_A256();
  thread _id_A257(var_2, var_1);

  if(var_0 == 1)
    thread _id_D14A();

  thread _id_A2D3();
  var_3 scripts\sp\anim::_id_1F35(self, var_2);
  var_3 thread scripts\sp\anim::_id_1EEA(self, var_2 + "_idle", "stop_idle");
  wait 0.1;
  var_4 unlink();
  var_4 _meth_80AF(undefined);
}

_id_A2D3() {
  wait 16;
  thread _id_FBAC();
  var_0 = scripts\engine\utility::spawn_tag_origin(self.origin + (0, 0, -19), self.angles);
  var_0 linkTo(self);
  playFXOnTag(level._effect["vfx_jackal_nitrogen_rcs_preflight"], var_0, "TAG_ORIGIN");
}

_id_FBAC() {
  scripts\engine\utility::delaythread(2, scripts\sp\utility::play_sound_on_tag, "jackal_nitrogen_blast_series_02", "tag_spotlight");
  scripts\engine\utility::delaythread(3.5, scripts\sp\utility::play_sound_on_tag, "jackal_nitrogen_blast_dbl_03", "tag_flash");
  scripts\engine\utility::delaythread(4, scripts\sp\utility::play_sound_on_tag, "jackal_nitrogen_blast_single_01", "tag_spotlight");
  scripts\engine\utility::delaythread(4.5, scripts\sp\utility::play_sound_on_tag, "jackal_nitrogen_blast_dbl_long_02", "tag_flash");
  scripts\engine\utility::delaythread(2.2, scripts\sp\utility::play_sound_on_tag, "jackal_nitrogen_blast_series_01", "tag_enginebottom_left");
  scripts\engine\utility::delaythread(2.6, scripts\sp\utility::play_sound_on_tag, "jackal_nitrogen_blast_dbl_01", "tag_enginebottom_left");
  scripts\engine\utility::delaythread(3.3, scripts\sp\utility::play_sound_on_tag, "jackal_nitrogen_blast_dbl_03", "tag_enginebottom_right");
  scripts\engine\utility::delaythread(3.9, scripts\sp\utility::play_sound_on_tag, "jackal_nitrogen_blast_single_02", "tag_enginebottom_left");
  scripts\engine\utility::delaythread(4.2, scripts\sp\utility::play_sound_on_tag, "jackal_nitrogen_blast_dbl_02", "tag_enginebottom_right");
  scripts\engine\utility::delaythread(4.6, scripts\sp\utility::play_sound_on_tag, "jackal_nitrogen_blast_dbl_long_01", "tag_enginebottom_left");
}

_id_D14A() {
  wait 16.5;
  thread _id_0BDC::_id_A208(1);
  thread _id_0BDC::_id_104A6(1);
}

_id_A256() {
  var_0 = scripts\engine\utility::getStruct("jackal_hangar_gas_nodes", "targetname");
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
  var_2 = [];

  foreach(var_4 in var_1) {
    var_5 = var_4.origin - var_0.origin;
    var_6 = scripts\engine\utility::spawn_tag_origin(self.origin + var_5 + (0, 0, -20), var_4.angles);
    var_2[var_2.size] = var_6;
    var_6 linkTo(self);
  }

  wait 4.0;

  foreach(var_9 in var_2) {
    playFXOnTag(level._effect["vfx_jackal_nitrogen_jet"], var_9, "TAG_ORIGIN");
    wait 0.05;
  }
}

_id_A257(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  switch (var_0) {
    case "jackal_lift_1":
      var_6 = 7.9;
      var_7 = 7.9;
      break;
    case "jackal_lift_2":
      var_6 = 0;
      var_7 = 8;
      break;
    case "jackal_lift_3":
      var_6 = 3.5;
      var_7 = 7.2;
      break;
    case "jackal_lift_4":
      var_6 = 6.6;
      var_7 = 7.6;
      break;
    default:
      var_6 = 7.6;
      var_7 = 7.6;
  }

  var_2 = "0" + var_1;
  var_3 = "scn_moon_hangar_jackal_raise_start_" + var_2;
  var_4 = "scn_moon_hangar_jackal_raise_stop_" + var_2;
  var_5 = "scn_moon_hangar_jackal_raise_lp_" + var_2;

  if(var_1 == 4) {
    scripts\engine\utility::delaythread(2.5, scripts\engine\utility::play_sound_in_space, "scn_moon_hangar_jackal_raise_steam_01", self.origin);
    scripts\engine\utility::delaythread(5.5, scripts\engine\utility::play_sound_in_space, "scn_moon_hangar_jackal_raise_steam_02", self.origin);
    scripts\engine\utility::delaythread(7.0, scripts\engine\utility::play_sound_in_space, "scn_moon_hangar_jackal_raise_steam_03", self.origin);
    scripts\engine\utility::delaythread(7.5, scripts\engine\utility::play_sound_in_space, "scn_moon_hangar_jackal_raise_steam_04", (17794, 19039, -54611));
  }

  wait(var_6);
  thread scripts\engine\utility::play_sound_in_space(var_3, self.origin);
  wait 1.0;
  thread scripts\engine\utility::play_loop_sound_on_entity(var_5);
  wait(var_7 - 1);
  thread scripts\engine\utility::play_sound_in_space(var_4, self.origin);
  thread scripts\engine\utility::stop_loop_sound_on_entity(var_5);
}

_id_A1FB(var_0, var_1, var_2) {
  wait(var_0);
  var_3 = getEntArray(var_1, "targetname");

  if(!isDefined(var_3) || var_3.size != 2) {
    return;
  }
  var_4 = var_3[0];
  var_5 = var_3[1];

  if(var_3[0].classname != "script_model") {
    var_4 = var_3[1];
    var_5 = var_3[0];
  }

  var_5 linkTo(var_4);
  var_6 = 5;
  var_4 thread _id_FB4F(var_1);
  var_4 rotatepitch(-45, var_6, 0.2, 0.2);
  wait 0.8;
  level notify(var_2);
}

_id_FB4F(var_0) {
  var_1 = undefined;

  switch (var_0) {
    case "hangar_jackal_shield_1":
      var_1 = "01";
      break;
    case "hangar_jackal_shield_2":
      var_1 = "02";
      break;
    case "hangar_jackal_shield_3":
      var_1 = "03";
      break;
    case "hangar_jackal_shield_4":
      var_1 = "04";
      break;
    default:
      var_1 = "01";
  }

  var_2 = "scn_moon_hangar_blast_plate_raise_" + var_1;
  thread scripts\engine\utility::play_sound_in_space(var_2, self.origin);
}

_id_8A48() {}

_id_8A47() {
  scripts\engine\utility::flag_set("hangar_elevator_go");
  _id_8A48();
}

_id_A283() {
  scripts\sp\maps\moon_port\moon_port_util::_id_968A();
  thread scripts\sp\maps\moon_port\moon_port_util::_id_BB2C("hangar");
  setmusicstate("mx_127_moonport_outro");
  scripts\sp\maps\moon_port\moon_port_util::_id_BC53("start_launch");
  scripts\sp\maps\moon_port\moon_port_util::_id_BC05("jackal_hangar", ["marineCO", "salter", "eth3n"]);
  scripts\engine\utility::flag_set("jackal_hangar_bays_open");
  scripts\engine\utility::flag_set("hangar_elevator_go");
  thread _id_A1FF();
  thread _id_A1FD(1);
  thread _id_1010D();
}

_id_A27F() {
  _id_A283();
  scripts\engine\utility::flag_set("capture_mount");
}

_id_1010D() {
  wait 1.0;
  var_0 = getEnt("hangar_window_blocker", "targetname");
  var_0 show();
}

_id_A281() {
  level.player endon("death");
  scripts\engine\utility::flag_set("player_indoor_p2");
  _id_F9C3();

  if(scripts\engine\utility::flag("capture_mount")) {
    var_0 = getEnt("player_jackal", "targetname");
    var_0 waittill("mount_runway");
    var_1 = getEnt("hangar_jackal_platform_3", "targetname");
    var_1 unlink();
    var_0 unlink();
    var_0 _meth_83A1();
  }

  var_2 = scripts\engine\utility::getStruct("jackal_hangar_lift_1", "targetname");
  var_2 notify("stop_idle");
  _id_0BDC::_id_137CF();
  level.player _meth_82C0("moonport_to_jackal", 0.2);
  setsaveddvar("sm_roundRobinPrioritySpotShadows", 4);

  if(getdvarint("skip_nextmission", 0) == 0 && !scripts\engine\utility::flag("capture_mount")) {
    wait 0.2;
    scripts\sp\utility::_id_BF95();
  } else {
    level.player waittill("mount_link_complete");
    level.player freezecontrols(1);
  }

  level waittill("forever");
}

_id_F9C3() {
  var_0 = level._id_AA81;
  var_1 = "runway_moon";

  if(scripts\engine\utility::flag("capture_mount"))
    var_1 = "runway";

  foreach(var_3 in var_0) {
    var_3 _id_0BDC::_id_F48D("runway_moon");
    var_3 _id_0BDC::_id_104A6(0);
    var_3 _id_0BDC::_id_F5BD("runway");
    var_3 _id_0BDC::_id_F420(10, 10, 10, 0, 0);
  }

  level._id_AA8C thread _id_D160();
  level._id_AA8C _id_0BDC::_id_F48D(var_1);
  level._id_AA8C _id_0BDC::_id_104A6(0);
  level._id_AA8C _id_0BDC::_id_F5BD("runway");
  level._id_AA8C _id_0BDC::_id_F420(1000, 135, -30, 1, 0);
}

_id_D160() {
  wait 3;
  var_0 = newhudelem();
  var_1 = scripts\engine\utility::spawn_tag_origin(self.origin + (375, 0, 0));
  var_1 linkTo(self);
  var_0 setshader("blank");
  var_0 setwaypoint(1, 1, 1, 0);
  var_0 settargetEnt(var_1);
  var_0.alpha = 1;
  var_0 setwaypointiconoffscreenonly();
  _id_0BDC::_id_137CF();
  var_0 destroy();
  wait 0.1;
  var_1 delete();
}

_id_A1FF() {
  scripts\sp\utility::_id_13705();
  level thread scripts\sp\utility::_id_BF98();
  level thread scripts\sp\utility::_id_BF97();
}

_id_AA6C() {}