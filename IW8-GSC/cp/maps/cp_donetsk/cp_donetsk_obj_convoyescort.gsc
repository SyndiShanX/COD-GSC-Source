/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_donetsk\cp_donetsk_obj_convoyescort.gsc
**************************************************************/

main() {
  level.convoyescort_interaction = ::register_interactions;
  level.suicide_bomber_combat_func = ::suicide_bomber_combat_func;
  level.convoyescort_obj_func = ::register_convoyescort_objective;
}

register_convoyescort_objective() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");
  var_0 = scripts\cp\cp_objectives::registerobjective;
  [[var_0]]("_encstr_855A11BD89A9BE6CDBB967EDBC95E6B1F64E1D", ::obj_maj_approach_init, ::obj_maj_approach_start, ::obj_maj_approach_end, ::debugbeatobjective, ::debug_start_convoyescort);
  level thread register_spawn_functions();
}

register_interactions() {}

obj_maj_approach_init(var_0) {}

obj_maj_approach_start(var_0) {
  level thread convoy_spawn(var_0);
  wait 99999;
}

obj_maj_approach_end(var_0) {}

debugbeatobjective(var_0) {
  level notify("_encstr_A1A70CA0D21E6361EFFA2D17C4C7" + var_0 + "_encstr_A7A70B7DDE989AAC6CA3D2B359");
}

convoy_spawn(var_0) {
  level.convoy_speed_override = 12;
  var_1 = scripts\engine\utility::getStruct("_encstr_960D10A6406818071709D73B228215B69A22", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_2 = "_encstr_A61D120825E030801BF56FA675C38B1039F870D5";
  var_3 = "_encstr_84AD119760D056D2DB802BE5E89B6B0B981043";
  var_4 = scripts\cp\cp_convoy_manager::spawn_convoy_from_type;
  var_5 = level[[var_4]](var_3, var_2, var_1, var_0);
  level thread convoy_settings(var_5);
  level thread temp_start_and_stop_test();
}

convoy_settings(var_0) {
  var_0 thread scripts\cp\cp_convoy_manager::set_center_compromises(0);
}

temp_start_and_stop_test() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  for(;;) {
    wait 10;
    level thread convoy_stop_all_cars();
    announcement("_encstr_B225160BB12042A3D3A0027EE938233BC833F0943B980BAE");
    wait 2;
    level thread convoy_resume_all_cars();
    announcement("_encstr_8A2F16F5654ACF05C043DFEED7406DCB2FB98A20501304EE");
  }
}

convoy_stop_all_cars() {
  var_0 = level.all_convoys["_encstr_84AD119760D056D2DB802BE5E89B6B0B981043"];

  foreach(var_2 in var_0.spawned_vehicles)
  var_2 vehicle_setspeedimmediate(0, 1, 1);
}

convoy_resume_all_cars() {
  var_0 = level.all_convoys["_encstr_84AD119760D056D2DB802BE5E89B6B0B981043"];

  foreach(var_2 in var_0.spawned_vehicles)
  var_2 resumespeed();
}

register_spawn_functions() {
  var_0 = scripts\cp\cp_modular_spawning::registerambientgroup;
  [[var_0]]("_encstr_84FE10129B386DEBCB48FA61711D3722E83F", 18, 18, 18, 0.1, 0, "_encstr_84FE10129B386DEBCB48FA61711D3722E83F", ::watchforstopwaves, undefined, undefined);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("_encstr_84FE10129B386DEBCB48FA61711D3722E83F", ::setup_manual_goalpos);
}

setup_manual_goalpos(var_0, var_1) {
  var_2 = getclosestpointonnavmesh(self.origin);
  self setgoalpos(var_2);

  switch (var_0.group_name) {
    case "_encstr_84FE10129B386DEBCB48FA61711D3722E83F":
      scripts\cp\cp_modular_spawning::set_goal_radius(512);
      self.goalheight = 64;
      break;
  }
}

watchforstopwaves(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level thread _watchforstopwaves(var_0);
}

_watchforstopwaves(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_8EDB1FDF52B9B79F537B71415F1A18B5A88807B0537093F9FF287A876C7AE0657A");
  level notify("_encstr_97010EC7E9B7736E015835FF73B0AD49" + var_0.moduleid + "_encstr_93D80BF536F6B638D8AC1D95C8");
}

stopwaveandstartthisone(var_0) {
  level notify("_encstr_8EDB1FDF52B9B79F537B71415F1A18B5A88807B0537093F9FF287A876C7AE0657A");
  wait 0.5;
  [[var_0]]();
}

suicide_bomber_combat_func() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = get_closet_alive_player(self);
  self getenemyinfo(var_0);

  for(;;) {
    if(isDefined(self.enemy)) {
      if(isDefined(self.enemy.vehicle_riding_on))
        self.bombertarget = self.enemy.vehicle_riding_on;
      else
        self.bombertarget = undefined;
    }

    wait 0.25;
  }
}

get_closet_alive_player(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }
    if(scripts\cp\cp_laststand::player_in_laststand(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return scripts\engine\utility::getclosest(var_0.origin, var_1);
}

debug_start_convoyescort(var_0) {
  scripts\cp\utility::teleportallplayersinteamtostructs("_encstr_9A8507BA4040188D08", "_encstr_8F8E1DA7B773FB15D1EB17C36ACA14C712CA4AD727477B2BE1A87B3FC02592", 1);
}