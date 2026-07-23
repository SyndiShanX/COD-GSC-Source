/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\payback_sandstorm.gsc
**********************************************/

init_flags_sandstorm() {
  common_scripts\utility::flag_init("start_blackout");
  common_scripts\utility::flag_init("stop_blackout");
  common_scripts\utility::flag_init("ai_heat_is_on");
  common_scripts\utility::flag_init("ai_heat_is_off");
  common_scripts\utility::flag_init("sandstorm_uaz1_vo_ready");
  common_scripts\utility::flag_init("sandstorm_dead_ahead");
  common_scripts\utility::flag_init("spawn_uaz1");
  common_scripts\utility::flag_init("uaz_guys_dead");
  common_scripts\utility::flag_init("blackout_flare_on");
  common_scripts\utility::flag_init("contact_echo");
  common_scripts\utility::flag_init("runners_shot");
  common_scripts\utility::flag_init("sandstorm_runner_see_you");
  common_scripts\utility::flag_init("sandstorm_in_alley");
  common_scripts\utility::flag_init("enemies_right");
  common_scripts\utility::flag_init("lookers_dead");
  common_scripts\utility::flag_init("echo_vo");
  common_scripts\utility::flag_init("sandstorm_end_runners2");
  common_scripts\utility::flag_init("price_at_end_runners");
  common_scripts\utility::flag_init("end_runners_fight");
  common_scripts\utility::flag_init("end_runners_dead");
  common_scripts\utility::flag_init("lighten_sandstorm");
}

lighten_sandstorm() {
  level endon("death");
  level endon("end_sandstorm");
  var_0 = getEntArray("sandstorm_lightener", "script_noteworthy");

  for(;;) {
    common_scripts\utility::flag_wait("lighten_sandstorm");
    var_1 = 0.75;

    foreach(var_3 in var_0) {
      if(maps\_utility::all_players_istouching(var_3)) {
        if(isDefined(var_3._id_6583)) {
          var_1 = var_3._id_6583;
        }
        break;
      }
    }

    var_5 = level._id_566C / var_1;
    _id_5698::_id_5673(var_5);
    common_scripts\utility::flag_waitopen("lighten_sandstorm");
    _id_5698::_id_5673();
  }
}

try_activate(var_0) {
  if(isDefined(var_0) && !isDefined(var_0.trigger_off)) {
    var_0 maps\_utility::activate_trigger();
  }
}

sandstorm_tinroof_listener(var_0) {
  var_1 = getEntArray(var_0, "targetname");
  try_activate(var_1[0]);
}

init_sandstorm_assets() {
  setup_vehicle_light_types();
  precacheturret("heli_spotlight");
  precacheitem("rpg_straight");
}

setup_vehicle_light_types() {
  var_0 = maps\_vehicle::get_light_model("vehicle_uaz_fabric", "script_vehicle_uaz_fabric");
  maps\_vehicle::build_light(var_0, "headlight_right", "TAG_LIGHT_RIGHT_FRONT", "maps/payback/payback_headlights_l", "headlights", 0.2);
  maps\_vehicle::build_light(var_0, "headlight_left", "TAG_LIGHT_LEFT_FRONT", "maps/payback/payback_headlights_l", "headlights", 0.2);
  maps\_vehicle::build_light(var_0, "taillight_right", "TAG_LIGHT_RIGHT_TAIL", "misc/car_taillight_uaz_pb", "headlights", 0.2);
  maps\_vehicle::build_light(var_0, "taillight_left", "TAG_LIGHT_LEFT_TAIL", "misc/car_taillight_uaz_pb", "headlights", 0.2);
  var_1 = [];
  var_1[0] = maps\_vehicle::get_light_model("vehicle_vehicle_pickup_technical_pb_rusted", "script_vehicle_pickup_technical_payback");
  var_1[1] = maps\_vehicle::get_light_model("vehicle_vehicle_pickup_technical_pb_rusted", "script_vehicle_pickup_technical_payback_physics");
  var_1[2] = maps\_vehicle::get_light_model("vehicle_vehicle_pickup_technical_pb_rusted", "script_vehicle_pickup_technical_payback_instant_death");

  foreach(var_0 in var_1) {
    maps\_vehicle::build_light(var_0, "headlight_truck_left", "tag_headlight_left", "maps/payback/payback_headlights_l_sq", "headlights");
    maps\_vehicle::build_light(var_0, "headlight_truck_right", "tag_headlight_right", "maps/payback/payback_headlights_r_sq", "headlights");
    maps\_vehicle::build_light(var_0, "parkinglight_truck_left_f", "tag_parkinglight_left_f", "misc/blank", "headlights");
    maps\_vehicle::build_light(var_0, "parkinglight_truck_right_f", "tag_parkinglight_right_f", "misc/blank", "headlights");
    maps\_vehicle::build_light(var_0, "taillight_truck_right", "tag_taillight_right", "misc/car_taillight_truck_R_pb", "headlights");
    maps\_vehicle::build_light(var_0, "taillight_truck_left", "tag_taillight_left", "misc/car_taillight_truck_L_pb", "headlights");
    maps\_vehicle::build_light(var_0, "brakelight_truck_right", "tag_taillight_right", "misc/car_brakelight_truck_R_pb", "brakelights");
    maps\_vehicle::build_light(var_0, "brakelight_truck_left", "tag_taillight_left", "misc/car_brakelight_truck_L_pb", "brakelights");
  }
}

setup_vehicle_inview_lights() {
  wait 0.2;
  var_0 = maps\_vehicle::get_light_model("vehicle_jeep_rubicon", "script_vehicle_jeep_rubicon_payback");
  level._id_6588 thread maps\_vehicle::lights_off_internal();
  level._id_6589 maps\_vehicle::lights_off_internal();
  maps\_vehicle::build_light(var_0, "headlight_truck_right", "tag_headlight_right", "maps/payback/payback_headlights_view", "headlights");
  maps\_vehicle::build_light(var_0, "headlight_truck_left", "tag_headlight_left", "maps/payback/payback_headlights_view", "headlights");
  level._id_6588 maps\_vehicle::lights_on_internal();
  level._id_6589 maps\_vehicle::lights_on_internal();
}

start_sandstorm() {
  maps\_audio::aud_send_msg("s2_sandstorm");
  common_scripts\utility::exploder(6000);
  thread maps\payback_streets_const::post_rappel_light();
  maps\payback_util::chopper_init_fog_brushes();
  var_0 = getEnt("sslight_01", "targetname");
  var_0 setlightintensity(7);
  var_1 = getEnt("street_light_gate", "targetname");
  var_1 setlightintensity(3);
  level.start_point = "s2_sandstorm";
  var_2 = getEntArray("strconst_fallkill", "targetname");
  common_scripts\utility::array_thread(var_2, common_scripts\utility::trigger_off);
  maps\payback_util::move_player_to_start();

  if(!maps\payback_sandstorm_code::debug_no_heroes()) {
    level.price = maps\payback_util::spawn_ally("price");
    level.soap = maps\payback_util::spawn_ally("soap");
  }

  maps\payback_env_code::_id_6507("s2_sandstorm");
  thread maps\payback_sandstorm_code::set_sandstorm_level("extreme", 0.051);
  level.chopper_fog_brushes = getEntArray("chopper_fog_brush", "targetname");

  foreach(var_4 in level.chopper_fog_brushes) {
    var_4 hide();
    var_4 notsolid();
  }

  objective_state(maps\_utility::obj("obj_kruger"), "done");
  objective_state(maps\_utility::obj("obj_secondary_lz"), "done");
  objective_state(maps\_utility::obj("obj_find_chopper"), "current");
  thread sandstorm();
  wait 1;
  maps\payback_streets_const::post_rappel_gate_open();
  sandstorm_tinroof_listener("allies_into_sandstorm");
  level.price thread maps\_utility::dialogue_queue("payback_pri_cmonlads");
  wait 2;
  sandstorm_tinroof_listener("soap_into_sandstorm");
}

sandstorm_turnoff_ssao() {
  if(!level.console) {
    var_0 = getdvarfloat("r_ssaostrength");

    for(var_1 = 0; var_1 < 40; var_1++) {
      var_2 = var_0 * (1 - var_1 / 39.0);
      setsaveddvar("r_ssaostrength", var_2);
      level common_scripts\utility::waitframe();
    }

    setsaveddvar("r_ssaostrength", 0.0);
  }
}

sandstorm() {
  getEnt("compoundexit_vista", "targetname") delete();
  thread lighten_sandstorm();
  thread sandstorm_contact_echo_vo();
  level._id_658E = 0;
  maps\_audio::aud_send_msg("s2_sandstorm");
  maps\_audio::aud_send_msg("sandstorm_start");
  maps\payback_sandstorm_code::sandstorm_skybox_show();
  thread sandstorm_turnoff_ssao();
  maps\_compass::setupminimap("compass_map_payback_sandstorm", "sandstorm_minimap_corner");

  if(!maps\_utility::is_specialop()) {
    maps\payback_fx_sp::_id_6504();
  }
  common_scripts\utility::flag_wait("sandstorm_script_trigger");
  maps\_utility::autosave_by_name("save_sandstorm");
  setsunflareposition((-29, 313.993, 0));
  maps\_utility::battlechatter_off("allies");
  thread uaz1_handler();
  thread ambient_pickups();
  thread sandstorm_blackout();
  thread watertower_thread("sandstorm_water_tower", "sandstorm_watertower_event");
  thread marketstall_thread("sandstorm_market_stall");
  thread scaffold_thread();
  thread moroccan_lamp_thread_2();
  setsaveddvar("objectiveFadeTooFar", 5);

  if(!maps\payback_sandstorm_code::debug_no_heroes()) {
    objective_onentity(maps\_utility::obj("obj_find_chopper"), level.price, (0, 0, 50));
    objective_setpointertextoverride(maps\_utility::obj("obj_find_chopper"), "");
    level.price maps\_utility::enable_pain();
    level.price.ignoreall = 0;
    level.soap.ignoreall = 0;
    level.price.baseaccuracy = 2.0;
    level.soap.baseaccuracy = 2.0;
  }

  thread sandstorm_price_leading_tracker();
  common_scripts\utility::flag_wait("sandstorm_intro_disable_color_end_triggers");
  thread sandstorm_enemy_battlechatter();
  thread sandstorm_runners_thread();
  level thread sandstorm_next_section_wait();
  common_scripts\utility::flag_wait("heat_is_off");

  if(!maps\payback_sandstorm_code::debug_no_heroes()) {
    level.soap maps\_utility::disable_cqbwalk();
    level.price maps\_utility::disable_cqbwalk();
    level.price.moveplaybackrate = 1.0;
    level.soap.moveplaybackrate = 1.0;
    objective_state(maps\_utility::obj("follow"), "invisible");
  }
}

sandstorm_blackout() {
  common_scripts\utility::flag_wait("start_blackout");
  thread maps\_utility::radio_dialogue("payback_mct_cantsee_r");
  thread maps\payback_sandstorm_code::set_sandstorm_level("blackout", 5);
  maps\_utility::delaythread(30, common_scripts\utility::flag_set, "stop_blackout");
  var_0 = maps\payback_util::array_spawn_targetname_allow_fail("flare_guy");
  var_1 = common_scripts\utility::array_combine(level.uaz_riders, var_0);
  thread sandstorm_move_to_alley(var_1);
  thread uaz_guys_on(var_0);
  common_scripts\utility::array_thread(var_0, ::uaz1_unload_guys);
  common_scripts\utility::array_thread(var_0, ::wait_till_shot);
  var_2 = var_0[0];

  foreach(var_4 in var_0) {
    var_4.ignoreall = 1;
    var_4 maps\_utility::disable_ai_color();
    var_4.pathrandompercent = 0;
    var_4.moveplaybackrate = 1;
    var_4.goalradius = 8;
    var_4.walkdist = 0;
    var_4.disablearrivals = 1;

    if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == "the_flare_guy") {
      var_2 = var_4;
      var_5 = getEnt("uaz_fight_volume", "targetname");
      var_6 = common_scripts\utility::getStruct("sstorm_flare_anim", "targetname");
      var_4 setgoalpos(var_6.origin);
      var_4 setgoalvolume(var_5);
      continue;
    }

    level._id_6591 = var_4;
  }

  thread flare_notify(var_2);
  common_scripts\utility::flag_wait("stop_blackout");
  wait 1.5;
}

flare_notify(var_0) {
  var_0 endon("death");
  var_0 maps\_utility::set_run_anim("payback_pmc_sandstorm_stumble_2");
  var_0 thread maps\_anim::anim_generic(var_0, "deploy_flare");
  var_1 = getEnt("sand_flare_01", "targetname");
  common_scripts\utility::waitframe();
  level.blackout_flare = spawn("script_model", var_0.origin);
  level.blackout_flare.owner = var_0;
  level.blackout_flare setModel("mil_emergency_flare");
  level.blackout_flare linkTo(var_0, "TAG_INHAND", (0, 0, 0), (0, 0, 0));
  playFXOnTag(common_scripts\utility::getfx("flare_ambient"), level.blackout_flare, "TAG_ORIGIN");
  var_1 thread maps\_utility::manual_linkto(level.blackout_flare);
  var_0 thread detach_flare_on_death();
  maps\_audio::aud_send_msg("flare_audio_start", var_0.origin);
  var_0 waittillmatch("single anim", "end");
  common_scripts\utility::flag_set("blackout_flare_on");
  level.blackout_flare unlink();
}

detach_flare_on_death() {
  self addaieventlistener("death");
  self addaieventlistener("projectile_impact");
  self waittill("ai_event", var_0);
  var_1 = maps\_utility::groundpos(level.blackout_flare.origin);
  level.blackout_flare unlink();
  level.blackout_flare moveTo(var_1, 0.5, 0.05, 0);
}

uaz1_unload_guys() {
  self.ignoreall = 1;
  self.baseaccuracy = 0.25;
  self.animname = "generic";

  switch (randomint(3)) {
    case 0:
      maps\_utility::set_run_anim("payback_pmc_sandstorm_stumble_1");
      break;
    case 1:
      maps\_utility::set_run_anim("payback_pmc_sandstorm_stumble_2");
      break;
    case 2:
      maps\_utility::set_run_anim("payback_pmc_sandstorm_stumble_3");
      break;
  }
}

ambient_pickups() {
  var_0 = getEntArray("sandstorm_amb_pickup", "targetname");
  common_scripts\utility::array_thread(var_0, maps\_vehicle::vehicle_lights_on);
}

sandstorm_allies_sprint() {
  if(!maps\payback_sandstorm_code::debug_no_heroes()) {
    level.price maps\_utility::disable_cqbwalk();
    level.soap maps\_utility::disable_cqbwalk();
    level.price.moveplaybackrate = 1.0;
    level.soap.moveplaybackrate = 1.0;
  }
}

sandstorm_allies_cqb() {
  if(!maps\payback_sandstorm_code::debug_no_heroes()) {
    level.price maps\_utility::enable_cqbwalk();
    level.soap maps\_utility::enable_cqbwalk();
    level.price.moveplaybackrate = 1.1;
    level.soap.moveplaybackrate = 1.1;
  }
}

sandstorm_ally_needs_to_catch_up() {
  var_0 = level.player.origin - self.origin;
  var_1 = length(var_0);

  if(var_1 < 600) {
    return 0;
  }
  var_0 = vectorNormalize(var_0);
  var_2 = vectorNormalize(self.goalpos - self.origin);
  var_3 = vectordot(var_2, var_0);

  if(var_3 < -0.5) {
    return 0;
  }
  return 1;
}

sandstorm_price_leading_tracker() {
  level.player endon("death");
  var_0 = 0;

  if(maps\payback_sandstorm_code::debug_no_heroes()) {
    return;
  }
  for(;;) {
    if(var_0) {
      if(!level.price sandstorm_ally_needs_to_catch_up()) {
        sandstorm_allies_cqb();
        var_0 = 0;
      }
    } else if(level.price sandstorm_ally_needs_to_catch_up()) {
      sandstorm_allies_sprint();
      var_0 = 1;
    }

    wait 1;
  }
}

sandstorm_runners_thread() {
  level endon("sandstorm_section_end");
  common_scripts\utility::flag_wait("sandstorm_runners");
  thread sandstorm_window_lookers();
  thread sandstorm_end_runners2();
  thread vo_echo_team_reports_in();
  var_0 = getEnt("sandstorm_runners_clear_volume", "targetname");
  level.sandstorm_runners_in_volume = maps\_utility::array_spawn_targetname("sandstorm_runner");
  thread sandstorm_runner_guys_handler(level.sandstorm_runners_in_volume);
  thread sandstorm_runner_vo();
  thread sandstorm_runner_clear_watch(var_0);
  thread sandstorm_runner_see_you();
  wait 2;

  while(level.sandstorm_runners_in_volume.size > 0) {
    var_1 = randomintrange(0, level.sandstorm_runners_in_volume.size);
    var_2 = level.sandstorm_runners_in_volume[var_1];

    if(isDefined(var_2) && isalive(var_2)) {
      var_2 maps\_utility::custom_battlechatter("order_move_combat");
      wait(randomfloatrange(0.1, 0.3));
      continue;
    }

    level.sandstorm_runners_in_volume = maps\_utility::array_removedead(level.sandstorm_runners_in_volume);
    wait 0.05;
  }

  maps\_utility::autosave_by_name("runners_past");
  sandstorm_allies_cqb();
  maps\_utility::activate_trigger("sandstorm_post_runsquad", "targetname");
  thread maps\_utility::radio_dialogue("payback_pri_moveout_r");
}

sandstorm_runner_vo() {
  var_0 = common_scripts\utility::getStruct("sandstorm_runner_vo_spot", "targetname");
  common_scripts\utility::play_sound_in_space("payback_mrc1_foundchopper", var_0.origin);
  maps\_utility::radio_dialogue("payback_pri_getdown_r");
  wait 1;
  maps\_utility::radio_dialogue("payback_pri_foundnikolai_r");

  if(!common_scripts\utility::flag("runners_shot")) {
    common_scripts\utility::play_sound_in_space("payback_afm_keepsearching", var_0.origin);
  }
}

sandstorm_runner_runner_vo() {
  var_0 = common_scripts\utility::getStruct("sandstorm_runner_vo_spot", "targetname");
  common_scripts\utility::play_sound_in_space("payback_mrc1_foundchopper", var_0.origin);
  wait 0.5;

  if(!common_scripts\utility::flag("runners_shot")) {
    common_scripts\utility::play_sound_in_space("payback_afm_keepsearching", var_0.origin);
  }
}

sandstorm_runner_see_you() {
  common_scripts\utility::flag_wait("sandstorm_runner_see_you");
  sandstorm_allies_cqb();

  foreach(var_1 in level.sandstorm_runners_in_volume) {
    if(isDefined(var_1) && isalive(var_1)) {
      level notify("runners_shot");
      var_1.ignoreall = 0;
      var_1.ignoreme = 0;
    }
  }
}

sandstorm_runner_guys_handler(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_noteworthy)) {
      var_3 = getnode(var_2.script_noteworthy, "targetname");

      if(isDefined(var_3)) {
        var_2._id_65A1 = var_2.goalradius;
        var_2 maps\_utility::set_goal_radius(var_3.radius);
        var_2 setgoalnode(var_3);
      }
    }

    var_2.ignoreall = 1;
    var_2.ignoreme = 1;
    var_2.baseaccuracy = 0.25;
    var_2 thread awake_on_shot();
    var_2 maps\_utility::enable_sprint();

    if(randomfloat(10) > 5) {
      var_2 maps\payback_sandstorm_code::flashlight_on_guy();
    }
    var_2 thread remove_at_end(350);
  }

  level waittill("runners_shot");

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isalive(var_2) && distancesquared(var_2.origin, level.player.origin) < 360000 || randomfloat(10) > 5) {
      var_2 sandstorm_runners_fight();
    }
  }
}

sandstorm_runners_fight(var_0) {
  self endon("death");
  self notify("fighting_time");
  wait 0.2;

  if(isDefined(self) && isalive(self)) {
    if(!isDefined(var_0)) {
      wait(randomfloatrange(0.25, 1.0));
    }
    self.ignoreall = 0;
    self.ignoreme = 0;
    maps\_utility::set_goal_radius(self._id_65A1);
    maps\_utility::disable_sprint();
    self.alertlevel = "combat";

    if(isDefined(var_0)) {
      self getenemyinfo(var_0);
    }
    self.baseaccuracy = 0.15;

    if(isDefined(self) && isalive(self)) {
      self setgoalpos(self.origin);
    }
    var_1 = getEnt("fight_zone", "targetname");
    var_2 = getnode(var_1.target, "targetname");

    if(isDefined(self) && isalive(self) && self istouching(var_1)) {
      self setgoalnode(var_2);
      self setgoalvolume(var_1);
    }
  }
}

remove_at_end(var_0) {
  self endon("death");
  self endon("fighting_time");
  wait 0.5;
  self waittill("goal");
  var_1 = distancesquared(self.origin, level.player.origin);

  if(var_1 > var_0 * var_0 && !maps\payback_util::raven_player_can_see_ai(self)) {
    self delete();
  } else {
    self notify("got_to_end");
    self.ignoreall = 0;
    self.ignoreme = 0;
    self getenemyinfo(level.player);
    self.alertlevel = "combat";
  }
}

awake_on_shot() {
  self endon("death");
  self endon("got_to_end");
  self addaieventlistener("grenade danger");
  self addaieventlistener("gunshot");
  self addaieventlistener("silenced_shot");
  self addaieventlistener("bulletwhizby");
  self addaieventlistener("projectile_impact");
  self waittill("ai_event", var_0);
  sandstorm_runners_fight(level.player);
  level notify("runners_shot");
  common_scripts\utility::flag_set("runners_shot");
}

sandstorm_runner_clear_watch(var_0) {
  while(level.sandstorm_runners_in_volume.size > 0) {
    foreach(var_2 in level.sandstorm_runners_in_volume) {
      if(!isalive(var_2) || !var_2 istouching(var_0)) {
        level.sandstorm_runners_in_volume = common_scripts\utility::array_remove(level.sandstorm_runners_in_volume, var_2);
      }
    }

    wait 0.1;
  }
}

sandstorm_next_section_wait() {
  common_scripts\utility::flag_wait("sandstorm_section_end");
  level notify("sandstorm_section_end");
  maps\payback_rescue::rescue_thread();
}

sandstorm_enemy_battlechatter() {
  level endon("sandstorm_section_end");
  level.player endon("death");

  while(!common_scripts\utility::flag("sandstorm_section_end")) {
    var_0 = getaiarray("axis");
    var_0 = maps\_utility::array_removedead(var_0);

    if(var_0.size > 0) {
      var_1 = randomintrange(0, var_0.size);
      var_2 = var_0[var_1];
      var_2 maps\_utility::custom_battlechatter("order_move_combat");
    }

    wait(randomfloatrange(1.5, 5.0));
  }
}

marketstall_thread(var_0) {
  level endon("sandstorm_section_end");
  var_1 = getEnt(var_0, "targetname");
  var_1.animname = "marketstall";
  var_1 maps\_anim::setanimtree();
  var_1 thread maps\_anim::anim_loop_solo(var_1, "payback_sstorm_market_stall_loop", "end_market_stall_loop");
  common_scripts\utility::flag_wait(var_0 + "_tear");
  var_1 notify("end_market_stall_loop");
  maps\_audio::aud_send_msg("sandstorm_market_tear", var_1);
  thread market_explosion();
  var_1 maps\_anim::anim_single_solo(var_1, "payback_sstorm_market_stall_tear");
  var_1 maps\_anim::anim_single_solo(var_1, "payback_sstorm_market_stall_exit");
}

market_explosion() {
  wait 1;
  var_0 = common_scripts\utility::getStructArray("wind_physics", "targetname");
  var_1 = 0.25;

  foreach(var_3 in var_0) {
    physicsexplosionsphere(var_3.origin, 50, 40, var_1);
    wait(randomfloatrange(0.15, 0.35));
    var_1 = var_1 + 0.5;
  }
}

watertower_thread(var_0, var_1) {
  level endon("sandstorm_section_end");
  var_2 = common_scripts\utility::getStruct(var_1, "targetname");
  var_3 = getEnt(var_0, "targetname");
  var_3.animname = "watertower";
  var_3 maps\_anim::setanimtree();
  var_2 thread maps\_anim::anim_loop_solo(var_3, "payback_sstorm_water_tower_idle", "end_water_tower");
  common_scripts\utility::flag_wait(var_1 + "_fall");
  var_2 notify("end_water_tower");
  maps\_audio::aud_send_msg("sandstorm_watertower_fall", var_3);
  var_2 maps\_anim::anim_single_solo(var_3, "payback_sstorm_water_tower_fall");
}

scaffold_thread() {
  level endon("sandstorm_section_end");
  common_scripts\utility::flag_wait("sandstorm_scaffold_fall");
  var_0 = common_scripts\utility::getStruct("sandstorm_construction_anim_origin", "targetname");
  var_1 = getEnt("sandstorm_scaffolding_collapse", "targetname");
  var_1.animname = "payback_scaffolding_collapse";
  var_1 useanimtree(level.scr_animtree[var_1.animname]);
  maps\_audio::aud_send_msg("payback_scaffolding_collapse", var_1);
  var_0 thread maps\_anim::anim_single_solo(var_1, "payback_scaffolding_collapse");
}

moroccan_lamp_thread() {
  level endon("sandstorm_section_end");
  level.sandstorm_swinging_lamps = getEntArray("sandstorm_swinging_lamps", "targetname");

  foreach(var_1 in level.sandstorm_swinging_lamps) {
    var_1.animname = "moroccan_lamp";
    var_1 maps\_anim::setanimtree();
    var_1 thread maps\_anim::anim_loop_solo(var_1, "wind_heavy", "end_lamp_swing");
    playFXOnTag(level._effect["lights_point_white_payback"], var_1, "tag_light");
    wait(randomfloatrange(0.1, 0.25));
  }
}

moroccan_lamp_thread_2() {
  level endon("sandstorm_section_end");
  level.sandstorm_swinging_lamps = getEntArray("sandstorm_swinging_lamps", "targetname");

  foreach(var_1 in level.sandstorm_swinging_lamps) {
    if(isDefined(var_1.target)) {
      var_1.animname = "moroccan_lamp";
      var_1 maps\_anim::setanimtree();
      var_1 thread maps\_anim::anim_loop_solo(var_1, "wind_heavy", "end_lamp_swing");
      var_2 = getEnt(var_1.target, "targetname");
      var_3 = common_scripts\utility::spawn_tag_origin();
      var_3 linkTo(var_1, "tag_light", (0, 0, 0), (0, 0, 0));
      var_2 thread maps\_utility::manual_linkto(var_3);
      playFXOnTag(level._effect["lights_point_white_payback"], var_1, "tag_light");
      wait(randomfloatrange(0.1, 0.25));
    }
  }
}

uaz1_handler(var_0, var_1) {
  level endon("sandstorm_section_end");
  common_scripts\utility::flag_wait("spawn_uaz1");
  var_2 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("uaz1");
  var_2 thread maps\payback_sandstorm_code::handle_vehicle_lights();
  var_2 thread uaz1_vo_handler();
  level._id_65AF = 0;
  var_2 thread init_uaz_riders();
  var_2 waittill("damage", var_3, var_4);
  level._id_658E = 1;

  if(var_4 == level.player) {
    var_2 vehicle_setspeed(0, 35);
    var_5 = var_2 maps\_vehicle::vehicle_unload();

    foreach(var_7 in var_5) {
      var_7.ignoreme = 0;
      var_7.ignoreall = 0;
      var_7 getenemyinfo(var_4);
      var_7.baseaccuracy = 0.25;
    }
  }
}

init_uaz_riders() {
  wait 0.25;
  level.uaz_riders = self.riders;

  foreach(var_1 in level.uaz_riders) {
    if(isDefined(var_1) && isalive(var_1)) {
      var_1.ignoreall = 1;
      var_1 maps\_utility::disable_ai_color();
      var_1.pathrandompercent = 0;
      var_1.moveplaybackrate = 1;
      var_1.goalradius = 8;
      var_1.walkdist = 0;
      var_1.disablearrivals = 1;
      var_1.animname = "generic";

      switch (randomint(3)) {
        case 0:
          var_1 maps\_utility::set_run_anim("payback_pmc_sandstorm_stumble_1");
          break;
        case 1:
          var_1 maps\_utility::set_run_anim("payback_pmc_sandstorm_stumble_2");
          break;
        case 2:
          var_1 maps\_utility::set_run_anim("payback_pmc_sandstorm_stumble_3");
          break;
      }

      var_1 thread sandstorm_uaz_unload();
      var_1 thread wait_till_shot();
    }
  }

  self waittill("reached_end_node");
  thread uaz_guys_on(level.uaz_riders);
}

sandstorm_uaz_unload() {
  self endon("death");
  var_0 = getnode(self.script_noteworthy, "targetname");
  self waittill("jumpedout");

  if(level._id_658E) {
    self.ignoreall = 0;
    maps\payback_sandstorm_code::flashlight_on_guy();
  } else {
    self.goalradius = 8;
    self setgoalnode(var_0);
    self waittill("goal");

    if(isalive(self) && !level._id_65AF) {
      maps\_anim::anim_generic(self, self.animation);
    }
  }
}

wait_till_shot() {
  level endon("uaz1_guys_fighting");
  self addaieventlistener("grenade danger");
  self addaieventlistener("gunshot");
  self addaieventlistener("silenced_shot");
  self addaieventlistener("bulletwhizby");
  self addaieventlistener("projectile_impact");
  self waittill("ai_event", var_0);
  level._id_65AF = 1;
  self stopanimScripted();
  maps\_utility::clear_run_anim();
  self setgoalpos(self.origin);
  self.ignoreall = 0;
  self.ignoreme = 0;
  self.baseaccuracy = 0.25;
  wait 0.1;
  var_1 = getEnt("uaz_fight_volume", "targetname");
  var_2 = common_scripts\utility::getStruct("sstorm_flare_anim", "targetname");
  self setgoalpos(var_2.origin);
  self setgoalvolume(var_1);
  level notify("uaz1_guys_fighting");
}

uaz_guys_on(var_0) {
  level waittill("uaz1_guys_fighting");

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isalive(var_2)) {
      var_2 stopanimScripted();
      var_2 orientmode("face default");
      var_2 maps\_utility::enable_ai_color();
      var_2.ignoreall = 0;
      self.goalradius = 200;
      var_2.baseaccuracy = 0.15;
      var_2.alertlevel = "combat";
    }
  }
}

sandstorm_move_to_alley(var_0) {
  if(var_0.size > 0) {
    thread maps\payback_util::ai_array_killcount_flag_set(var_0, var_0.size, "uaz_guys_dead");
    common_scripts\utility::flag_wait("uaz_guys_dead");
  } else {
    common_scripts\utility::flag_set("uaz_guys_dead");
  }
  sandstorm_tinroof_listener("sandstorm_move_to_alley");
  wait 2;
  common_scripts\utility::flag_set("stop_blackout");
}

uaz1_vo_handler() {
  common_scripts\utility::flag_wait("sandstorm_uaz1_vo_ready");
  maps\_utility::autosave_by_name_silent("see_jeep");
  sandstorm_allies_cqb();
  var_0 = getEnt("sandstorm_intro_after_vehicle", "targetname");
  thread maps\_utility::radio_dialogue("payback_pri_vehiclecoming_r");
  try_activate(var_0);
  thread blackout_vo();
}

blackout_takedown_vo() {
  common_scripts\utility::flag_wait("blackout_flare_on");
  level.price maps\_utility::dialogue_queue("payback_pri_takeemout");
  wait 0.5;
  blackout_soap_price_fight();
}

blackout_soap_price_fight() {
  level.soap.baseaccuracy = 10;
  level.price.baseaccuracy = 10;
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {}
  var_2.ignoreme = 0;

  if(isDefined(var_0[0]) && isalive(var_0[0])) {
    level.soap getenemyinfo(var_0[0]);
    level.price getenemyinfo(var_0[0]);
  }
}

blackout_vo() {
  common_scripts\utility::flag_wait("sandstorm_dead_ahead");
  var_0 = level.soap.baseaccuracy;
  var_1 = level.price.baseaccuracy;
  maps\_utility::radio_dialogue("payback_mct_deadahead_r");
  level.price.animname = "price";

  if(level._id_65AF == 0) {
    thread blackout_takedown_vo();
  } else {
    level.price maps\_utility::dialogue_queue("payback_pri_takeemout");
    blackout_soap_price_fight();
  }

  common_scripts\utility::flag_wait("uaz_guys_dead");
  level.soap.baseaccuracy = var_0;
  level.price.baseaccuracy = var_1;
  maps\_utility::autosave_by_name("blackout_done");
  sandstorm_allies_sprint();
  maps\_utility::radio_dialogue("payback_mct_wereclear_r");
  level.price maps\_utility::dialogue_queue("payback_pri_gottamove");
  wait 0.5;
  common_scripts\utility::flag_set("contact_echo");
}

sandstorm_contact_echo_vo() {
  common_scripts\utility::flag_wait("contact_echo");
  level.price maps\_utility::dialogue_queue("payback_pri_echoteam2");
  wait 0.25;
  maps\_utility::radio_dialogue("payback_eol_locatedchopper");
}

sandstorm_window_lookers() {
  common_scripts\utility::flag_wait("sandstorm_runner_see_you");
  thread callout_lookers();
  thread lookers_autosave();
  var_0 = getEnt("ss_window_guy_c", "targetname");
  var_1 = var_0 maps\_utility::spawn_ai(1);
  var_1 thread maps\payback_sandstorm_code::flashlight_on_guy();
  var_1.animname = "generic";
  var_1 maps\_utility::set_run_anim("payback_pmc_sandstorm_stumble_3");
  var_2 = getnode("ss_middle_search_node", "targetname");
  var_0 = getEnt("ss_window_guy_l", "targetname");
  var_3 = var_0 maps\_utility::spawn_ai(1);
  var_3 thread maps\payback_sandstorm_code::attachflashlight("alley_fight");
  var_4 = getEnt("ss_left_search_guy", "targetname");
  var_0 = getEnt("ss_window_guy_r", "targetname");
  var_5 = var_0 maps\_utility::spawn_ai(1);
  var_5 thread maps\payback_sandstorm_code::attachflashlight("alley_fight");
  var_6 = getEnt("ss_right_search_guy", "targetname");
  var_7 = [var_1, var_3, var_5];
  thread handle_unawares(var_7, "alley_fight");
  var_1 setgoalnode(var_2);
  thread left_looker(var_3);
  right_looker(var_5);
  thread maps\payback_util::ai_array_killcount_flag_set(var_7, var_7.size, "lookers_dead");

  if(common_scripts\utility::flag("sandstorm_in_alley")) {
    if(!common_scripts\utility::flag("alley_fight") && !common_scripts\utility::flag("lookers_dead")) {
      maps\_utility::radio_dialogue("payback_mct_theyknow_r");
      common_scripts\utility::flag_set("alley_fight");
    }
  } else {
    level notify("lookers_deleted");

    foreach(var_9 in var_7) {
      if(isDefined(var_9) && isalive(var_9)) {
        var_9 delete();
      }
    }
  }
}

lookers_autosave() {
  level endon("lookers_deleted");
  common_scripts\utility::flag_wait("alley_fight");
  common_scripts\utility::flag_wait("lookers_dead");
  maps\_utility::autosave_by_name_silent("window_lookers");
}

callout_lookers() {
  level endon("death");
  level endon("lookers_deleted");
  common_scripts\utility::flag_wait("enemies_right");

  if(!common_scripts\utility::flag("alley_fight")) {
    common_scripts\utility::flag_wait("lookers_dead");
    maps\_utility::radio_dialogue("payback_mct_thatwaseasy_r");
  }
}

left_looker(var_0) {
  var_0 endon("death");
  var_0 maps\_anim::anim_generic(var_0, "active_patrolwalk_pause");
  var_0 maps\_anim::anim_generic(var_0, "active_patrolwalk_turn_180");
}

right_looker(var_0) {
  var_0 endon("death");
  var_0 maps\_anim::anim_generic(var_0, "active_patrolwalk_v5");
  var_0 maps\_anim::anim_generic(var_0, "active_patrolwalk_v5");
  var_0 maps\_anim::anim_generic(var_0, "active_patrolwalk_turn_180");
}

vo_echo_team_reports_in() {
  common_scripts\utility::flag_wait("echo_vo");
  maps\_utility::radio_dialogue("payback_tm2_reachednikolai");
  wait 0.5;
  level.price maps\_utility::dialogue_queue("payback_pri_hangon");
}

sandstorm_end_runners2() {
  common_scripts\utility::flag_wait("sandstorm_end_runners2");
  thread _id_5698::_id_5683(5);
  var_0 = maps\payback_util::array_spawn_targetname_allow_fail("sandstorm_end_runners2");
  var_1 = maps\payback_util::array_spawn_targetname_allow_fail("sandstorm_end_wavers2");
  var_2 = common_scripts\utility::array_combine(var_0, var_1);
  thread handle_unawares(var_2, "end_runners_fight");
  var_3 = getnode("sandstorm_end_runners2_node", "targetname");
  common_scripts\utility::array_thread(var_0, ::do_end_runners, var_3);
  common_scripts\utility::array_thread(var_1, ::do_end_wavers, var_3);
  var_4 = maps\payback_util::array_spawn_targetname_allow_fail("sandstorm_end_runners3");
  common_scripts\utility::array_thread(var_4, ::do_end_runners, var_3);
  thread maps\payback_util::ai_array_killcount_flag_set(var_2, var_2.size, "end_runners_dead");
  thread boost_sstorm_allies_combat_accuracy("end_runners_fight", "end_runners_dead");
  var_5 = common_scripts\utility::getStruct("sandstorm_waver_vo_spot", "targetname");
  thread common_scripts\utility::play_sound_in_space("payback_afm_hurry", var_5.origin);
  wait 1.5;
  level.price maps\_utility::dialogue_queue("payback_mct_headingfornik");

  if(!common_scripts\utility::flag("end_runners_fight")) {
    level.price maps\_utility::dialogue_queue("payback_pri_dropem");
    wait 1;
    common_scripts\utility::flag_set("end_runners_fight");
  }

  common_scripts\utility::flag_wait("end_runners_dead");
  maps\_utility::autosave_by_name("end_runners_dead");
  sandstorm_allies_sprint();
  common_scripts\utility::trigger_off("ss_allies_wavers1", "targetname");
  sandstorm_tinroof_listener("ss_allies_wavers2");
  maps\_utility::radio_dialogue("payback_mct_wereclear_r");
}

boost_sstorm_allies_combat_accuracy(var_0, var_1) {
  var_2 = level.soap.baseaccuracy;
  var_3 = level.price.baseaccuracy;
  common_scripts\utility::flag_wait(var_0);
  level.soap.baseaccuracy = 1000;
  level.price.baseaccuracy = 1000;
  common_scripts\utility::flag_wait(var_1);
  level.soap.baseaccuracy = var_2;
  level.price.baseaccuracy = var_3;
}

do_end_runners(var_0) {
  if(randomfloat(100) < 75) {
    maps\payback_sandstorm_code::flashlight_on_guy();
  }
  maps\_utility::set_goal_radius(10);
  self setgoalpos(self.origin);
  wait 2;

  if(isDefined(self) && isalive(self)) {
    run_and_delete(var_0, "end_runners_fight");
  }
}

do_end_wavers(var_0) {
  self endon("death");
  self endon("end_runners_fight");
  var_1 = common_scripts\utility::getStruct(self.script_noteworthy, "targetname");
  var_1 maps\_anim::anim_generic_teleport(self, self.animation);
  var_1 maps\_anim::anim_generic(self, self.animation);
  run_and_delete(var_0, "end_runners_fight");
}

run_and_delete(var_0, var_1) {
  self endon("death");

  if(isDefined(var_1) && (!isDefined(self.script_noteworthy) || isDefined(self.script_noteworthy) && self.script_noteworthy != "no_intterupt")) {
    level endon(var_1);
  }
  maps\_utility::set_goal_radius(100);
  self setgoalnode(var_0);
  wait 1;
  self waittill("goal");
  wait 0.2;

  if(maps\payback_util::raven_player_can_see_ai(self)) {
    self.ignoreall = 0;
    self.ignoreme = 0;
    wait 1;
    self getenemyinfo(level.player);
  } else {
    self delete();
  }
}

handle_unawares(var_0, var_1) {
  level endon("death");
  self endon("deleted");

  foreach(var_3 in var_0) {}
  var_3 thread handle_unaware_shot(var_1);

  level waittill(var_1);
  common_scripts\utility::array_thread(var_0, ::unawares_attack);
}

handle_unaware_shot(var_0) {
  self endon("death");
  self endon("deleted");
  level endon(var_0);
  self addaieventlistener("grenade danger");
  self addaieventlistener("gunshot");
  self addaieventlistener("silenced_shot");
  self addaieventlistener("bulletwhizby");
  self addaieventlistener("projectile_impact");
  self waittill("ai_event", var_1);
  unawares_attack(level.player);
  level notify(var_0);
  common_scripts\utility::flag_set(var_0);
}

unawares_attack(var_0) {
  self endon("death");
  self endon("deleted");

  if(!isDefined(var_0)) {
    wait(randomfloatrange(0.5, 2.0));
  }
  if(isDefined(self) && isalive(self)) {
    self.ignoreme = 0;
    self.ignoreall = 0;
    self.baseaccuracy = 0.2;
    self stopanimScripted();
    self setgoalpos(self.origin);

    if(isDefined(var_0)) {
      self getenemyinfo(var_0);
    } else {
      self getenemyinfo(level.player);
    }
  }
}