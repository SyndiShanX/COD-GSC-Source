/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\payback_sandstorm.gsc
**********************************************/

_id_6582() {
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

_id_6509() {
  level endon("death");
  level endon("end_sandstorm");
  var_0 = getEntArray("sandstorm_lightener", "script_noteworthy");

  for(;;) {
    common_scripts\utility::flag_wait("lighten_sandstorm");
    var_1 = 0.75;

    foreach(var_3 in var_0) {
      if(maps\_utility::_id_277B(var_3)) {
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

_id_6584(var_0) {
  if(isDefined(var_0) && !isDefined(var_0.trigger_off)) {
    var_0 maps\_utility::_id_2703();
  }
}

_id_6585(var_0) {
  var_1 = getEntArray(var_0, "targetname");
  _id_6584(var_1[0]);
}

_id_6586() {
  _id_5A14();
  precacheturret("heli_spotlight");
  precacheitem("rpg_straight");
}

_id_5A14() {
  var_0 = maps\_vehicle::_id_2B1A("vehicle_uaz_fabric", "script_vehicle_uaz_fabric");
  maps\_vehicle::_id_2AAD(var_0, "headlight_right", "TAG_LIGHT_RIGHT_FRONT", "maps/payback/payback_headlights_l", "headlights", 0.2);
  maps\_vehicle::_id_2AAD(var_0, "headlight_left", "TAG_LIGHT_LEFT_FRONT", "maps/payback/payback_headlights_l", "headlights", 0.2);
  maps\_vehicle::_id_2AAD(var_0, "taillight_right", "TAG_LIGHT_RIGHT_TAIL", "misc/car_taillight_uaz_pb", "headlights", 0.2);
  maps\_vehicle::_id_2AAD(var_0, "taillight_left", "TAG_LIGHT_LEFT_TAIL", "misc/car_taillight_uaz_pb", "headlights", 0.2);
  var_1 = [];
  var_1[0] = maps\_vehicle::_id_2B1A("vehicle_vehicle_pickup_technical_pb_rusted", "script_vehicle_pickup_technical_payback");
  var_1[1] = maps\_vehicle::_id_2B1A("vehicle_vehicle_pickup_technical_pb_rusted", "script_vehicle_pickup_technical_payback_physics");
  var_1[2] = maps\_vehicle::_id_2B1A("vehicle_vehicle_pickup_technical_pb_rusted", "script_vehicle_pickup_technical_payback_instant_death");

  foreach(var_0 in var_1) {
    maps\_vehicle::_id_2AAD(var_0, "headlight_truck_left", "tag_headlight_left", "maps/payback/payback_headlights_l_sq", "headlights");
    maps\_vehicle::_id_2AAD(var_0, "headlight_truck_right", "tag_headlight_right", "maps/payback/payback_headlights_r_sq", "headlights");
    maps\_vehicle::_id_2AAD(var_0, "parkinglight_truck_left_f", "tag_parkinglight_left_f", "misc/blank", "headlights");
    maps\_vehicle::_id_2AAD(var_0, "parkinglight_truck_right_f", "tag_parkinglight_right_f", "misc/blank", "headlights");
    maps\_vehicle::_id_2AAD(var_0, "taillight_truck_right", "tag_taillight_right", "misc/car_taillight_truck_R_pb", "headlights");
    maps\_vehicle::_id_2AAD(var_0, "taillight_truck_left", "tag_taillight_left", "misc/car_taillight_truck_L_pb", "headlights");
    maps\_vehicle::_id_2AAD(var_0, "brakelight_truck_right", "tag_taillight_right", "misc/car_brakelight_truck_R_pb", "brakelights");
    maps\_vehicle::_id_2AAD(var_0, "brakelight_truck_left", "tag_taillight_left", "misc/car_brakelight_truck_L_pb", "brakelights");
  }
}

_id_6587() {
  wait 0.2;
  var_0 = maps\_vehicle::_id_2B1A("vehicle_jeep_rubicon", "script_vehicle_jeep_rubicon_payback");
  level._id_6588 thread maps\_vehicle::_id_2ABB();
  level._id_6589 maps\_vehicle::_id_2ABB();
  maps\_vehicle::_id_2AAD(var_0, "headlight_truck_right", "tag_headlight_right", "maps/payback/payback_headlights_view", "headlights");
  maps\_vehicle::_id_2AAD(var_0, "headlight_truck_left", "tag_headlight_left", "maps/payback/payback_headlights_view", "headlights");
  level._id_6588 maps\_vehicle::_id_2AB6();
  level._id_6589 maps\_vehicle::_id_2AB6();
}

_id_658A() {
  maps\_audio::aud_send_msg("s2_sandstorm");
  common_scripts\utility::exploder(6000);
  thread maps\payback_streets_const::_id_658B();
  maps\payback_util::_id_64D4();
  var_0 = getent("sslight_01", "targetname");
  var_0 setlightintensity(7);
  var_1 = getent("street_light_gate", "targetname");
  var_1 setlightintensity(3);
  level._id_1F19 = "s2_sandstorm";
  var_2 = getEntArray("strconst_fallkill", "targetname");
  common_scripts\utility::array_thread(var_2, common_scripts\utility::trigger_off);
  maps\payback_util::move_player_to_start();

  if(!maps\payback_sandstorm_code::_id_6485()) {
    level._id_4877 = maps\payback_util::_id_594A("price");
    level._id_54E0 = maps\payback_util::_id_594A("soap");
  }

  maps\payback_env_code::_id_6507("s2_sandstorm");
  thread maps\payback_sandstorm_code::_id_6486("extreme", 0.051);
  level._id_64D5 = getEntArray("chopper_fog_brush", "targetname");

  foreach(var_4 in level._id_64D5) {
    var_4 hide();
    var_4 notsolid();
  }

  objective_state(maps\_utility::_id_2816("obj_kruger"), "done");
  objective_state(maps\_utility::_id_2816("obj_secondary_lz"), "done");
  objective_state(maps\_utility::_id_2816("obj_find_chopper"), "current");
  thread _id_658D();
  wait 1;
  maps\payback_streets_const::_id_658C();
  _id_6585("allies_into_sandstorm");
  level._id_4877 thread maps\_utility::_id_168C("payback_pri_cmonlads");
  wait 2;
  _id_6585("soap_into_sandstorm");
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

_id_658D() {
  getent("compoundexit_vista", "targetname") delete();
  thread _id_6509();
  thread _id_65B9();
  level._id_658E = 0;
  maps\_audio::aud_send_msg("s2_sandstorm");
  maps\_audio::aud_send_msg("sandstorm_start");
  maps\payback_sandstorm_code::_id_5C03();
  thread sandstorm_turnoff_ssao();
  maps\_compass::setupminimap("compass_map_payback_sandstorm", "sandstorm_minimap_corner");

  if(!maps\_utility::_id_0A36()) {
    maps\payback_fx_sp::_id_6504();
  }
  common_scripts\utility::flag_wait("sandstorm_script_trigger");
  maps\_utility::_id_1425("save_sandstorm");
  setsunflareposition((-29, 313.993, 0));
  maps\_utility::_id_265A("allies");
  thread _id_65AE();
  thread _id_6596();
  thread _id_658F();
  thread _id_65AA("sandstorm_water_tower", "sandstorm_watertower_event");
  thread _id_65A8("sandstorm_market_stall");
  thread _id_65AB();
  thread _id_65AD();
  setsaveddvar("objectiveFadeTooFar", 5);

  if(!maps\payback_sandstorm_code::_id_6485()) {
    objective_onentity(maps\_utility::_id_2816("obj_find_chopper"), level._id_4877, (0, 0, 50));
    objective_setpointertextoverride(maps\_utility::_id_2816("obj_find_chopper"), "");
    level._id_4877 maps\_utility::_id_1071();
    level._id_4877.ignoreall = 0;
    level._id_54E0.ignoreall = 0;
    level._id_4877._id_20AF = 2.0;
    level._id_54E0._id_20AF = 2.0;
  }

  thread _id_659A();
  common_scripts\utility::flag_wait("sandstorm_intro_disable_color_end_triggers");
  thread _id_65A7();
  thread _id_659B();
  level thread _id_65A6();
  common_scripts\utility::flag_wait("heat_is_off");

  if(!maps\payback_sandstorm_code::_id_6485()) {
    level._id_54E0 maps\_utility::_id_109E();
    level._id_4877 maps\_utility::_id_109E();
    level._id_4877._id_0FC6 = 1.0;
    level._id_54E0._id_0FC6 = 1.0;
    objective_state(maps\_utility::_id_2816("follow"), "invisible");
  }
}

_id_658F() {
  common_scripts\utility::flag_wait("start_blackout");
  thread maps\_utility::_id_11F4("payback_mct_cantsee_r");
  thread maps\payback_sandstorm_code::_id_6486("blackout", 5);
  maps\_utility::delaythread(30, common_scripts\utility::flag_set, "stop_blackout");
  var_0 = maps\payback_util::_id_5DD7("flare_guy");
  var_1 = common_scripts\utility::array_combine(level._id_6590, var_0);
  thread _id_65B4(var_1);
  thread _id_65B3(var_0);
  common_scripts\utility::array_thread(var_0, ::_id_6595);
  common_scripts\utility::array_thread(var_0, ::_id_65B2);
  var_2 = var_0[0];

  foreach(var_4 in var_0) {
    var_4.ignoreall = 1;
    var_4 maps\_utility::_id_123B();
    var_4.pathrandompercent = 0;
    var_4._id_0FC6 = 1;
    var_4.goalradius = 8;
    var_4.walkdist = 0;
    var_4._id_117F = 1;

    if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == "the_flare_guy") {
      var_2 = var_4;
      var_5 = getent("uaz_fight_volume", "targetname");
      var_6 = common_scripts\utility::getstruct("sstorm_flare_anim", "targetname");
      var_4 setgoalpos(var_6.origin);
      var_4 setgoalvolume(var_5);
      continue;
    }

    level._id_6591 = var_4;
  }

  thread _id_6592(var_2);
  common_scripts\utility::flag_wait("stop_blackout");
  wait 1.5;
}

_id_6592(var_0) {
  var_0 endon("death");
  var_0 maps\_utility::_id_26F7("payback_pmc_sandstorm_stumble_2");
  var_0 thread maps\_anim::_id_11C1(var_0, "deploy_flare");
  var_1 = getent("sand_flare_01", "targetname");
  common_scripts\utility::waitframe();
  level._id_6593 = spawn("script_model", var_0.origin);
  level._id_6593.owner = var_0;
  level._id_6593 setModel("mil_emergency_flare");
  level._id_6593 linkto(var_0, "TAG_INHAND", (0, 0, 0), (0, 0, 0));
  playFXOnTag(common_scripts\utility::getfx("flare_ambient"), level._id_6593, "TAG_ORIGIN");
  var_1 thread maps\_utility::_id_2765(level._id_6593);
  var_0 thread _id_6594();
  maps\_audio::aud_send_msg("flare_audio_start", var_0.origin);
  var_0 waittillmatch("single anim", "end");
  common_scripts\utility::flag_set("blackout_flare_on");
  level._id_6593 unlink();
}

_id_6594() {
  self addaieventlistener("death");
  self addaieventlistener("projectile_impact");
  self waittill("ai_event", var_0);
  var_1 = maps\_utility::_id_1277(level._id_6593.origin);
  level._id_6593 unlink();
  level._id_6593 moveto(var_1, 0.5, 0.05, 0);
}

_id_6595() {
  self.ignoreall = 1;
  self._id_20AF = 0.25;
  self._id_1032 = "generic";

  switch (randomint(3)) {
    case 0:
      maps\_utility::_id_26F7("payback_pmc_sandstorm_stumble_1");
      break;
    case 1:
      maps\_utility::_id_26F7("payback_pmc_sandstorm_stumble_2");
      break;
    case 2:
      maps\_utility::_id_26F7("payback_pmc_sandstorm_stumble_3");
      break;
  }
}

_id_6596() {
  var_0 = getEntArray("sandstorm_amb_pickup", "targetname");
  common_scripts\utility::array_thread(var_0, maps\_vehicle::_id_2B17);
}

_id_6597() {
  if(!maps\payback_sandstorm_code::_id_6485()) {
    level._id_4877 maps\_utility::_id_109E();
    level._id_54E0 maps\_utility::_id_109E();
    level._id_4877._id_0FC6 = 1.0;
    level._id_54E0._id_0FC6 = 1.0;
  }
}

_id_6598() {
  if(!maps\payback_sandstorm_code::_id_6485()) {
    level._id_4877 maps\_utility::_id_109B();
    level._id_54E0 maps\_utility::_id_109B();
    level._id_4877._id_0FC6 = 1.1;
    level._id_54E0._id_0FC6 = 1.1;
  }
}

_id_6599() {
  var_0 = level.player.origin - self.origin;
  var_1 = length(var_0);

  if(var_1 < 600) {
    return 0;
  }
  var_0 = vectornormalize(var_0);
  var_2 = vectornormalize(self.goalpos - self.origin);
  var_3 = vectordot(var_2, var_0);

  if(var_3 < -0.5) {
    return 0;
  }
  return 1;
}

_id_659A() {
  level.player endon("death");
  var_0 = 0;

  if(maps\payback_sandstorm_code::_id_6485()) {
    return;
  }
  for(;;) {
    if(var_0) {
      if(!level._id_4877 _id_6599()) {
        _id_6598();
        var_0 = 0;
      }
    } else if(level._id_4877 _id_6599()) {
      _id_6597();
      var_0 = 1;
    }

    wait 1;
  }
}

_id_659B() {
  level endon("sandstorm_section_end");
  common_scripts\utility::flag_wait("sandstorm_runners");
  thread _id_65BA();
  thread _id_65C0();
  thread _id_65BF();
  var_0 = getent("sandstorm_runners_clear_volume", "targetname");
  level._id_659C = maps\_utility::_id_272C("sandstorm_runner");
  thread _id_65A0(level._id_659C);
  thread _id_659D();
  thread _id_65A5(var_0);
  thread _id_659F();
  wait 2;

  while(level._id_659C.size > 0) {
    var_1 = randomintrange(0, level._id_659C.size);
    var_2 = level._id_659C[var_1];

    if(isDefined(var_2) && isalive(var_2)) {
      var_2 maps\_utility::_id_1EFE("order_move_combat");
      wait(randomfloatrange(0.1, 0.3));
      continue;
    }

    level._id_659C = maps\_utility::_id_1361(level._id_659C);
    wait 0.05;
  }

  maps\_utility::_id_1425("runners_past");
  _id_6598();
  maps\_utility::_id_2703("sandstorm_post_runsquad", "targetname");
  thread maps\_utility::_id_11F4("payback_pri_moveout_r");
}

_id_659D() {
  var_0 = common_scripts\utility::getstruct("sandstorm_runner_vo_spot", "targetname");
  common_scripts\utility::play_sound_in_space("payback_mrc1_foundchopper", var_0.origin);
  maps\_utility::_id_11F4("payback_pri_getdown_r");
  wait 1;
  maps\_utility::_id_11F4("payback_pri_foundnikolai_r");

  if(!common_scripts\utility::flag("runners_shot")) {
    common_scripts\utility::play_sound_in_space("payback_afm_keepsearching", var_0.origin);
  }
}

_id_659E() {
  var_0 = common_scripts\utility::getstruct("sandstorm_runner_vo_spot", "targetname");
  common_scripts\utility::play_sound_in_space("payback_mrc1_foundchopper", var_0.origin);
  wait 0.5;

  if(!common_scripts\utility::flag("runners_shot")) {
    common_scripts\utility::play_sound_in_space("payback_afm_keepsearching", var_0.origin);
  }
}

_id_659F() {
  common_scripts\utility::flag_wait("sandstorm_runner_see_you");
  _id_6598();

  foreach(var_1 in level._id_659C) {
    if(isDefined(var_1) && isalive(var_1)) {
      level notify("runners_shot");
      var_1.ignoreall = 0;
      var_1.ignoreme = 0;
    }
  }
}

_id_65A0(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_noteworthy)) {
      var_3 = getnode(var_2.script_noteworthy, "targetname");

      if(isDefined(var_3)) {
        var_2._id_65A1 = var_2.goalradius;
        var_2 maps\_utility::_id_2724(var_3.radius);
        var_2 setgoalnode(var_3);
      }
    }

    var_2.ignoreall = 1;
    var_2.ignoreme = 1;
    var_2._id_20AF = 0.25;
    var_2 thread _id_65A4();
    var_2 maps\_utility::_id_2712();

    if(randomfloat(10) > 5) {
      var_2 maps\payback_sandstorm_code::_id_648A();
    }
    var_2 thread _id_65A3(350);
  }

  level waittill("runners_shot");

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isalive(var_2) && distancesquared(var_2.origin, level.player.origin) < 360000 || randomfloat(10) > 5) {
      var_2 _id_65A2();
    }
  }
}

_id_65A2(var_0) {
  self endon("death");
  self notify("fighting_time");
  wait 0.2;

  if(isDefined(self) && isalive(self)) {
    if(!isDefined(var_0)) {
      wait(randomfloatrange(0.25, 1.0));
    }
    self.ignoreall = 0;
    self.ignoreme = 0;
    maps\_utility::_id_2724(self._id_65A1);
    maps\_utility::_id_2713();
    self.alertlevel = "combat";

    if(isDefined(var_0)) {
      self getenemyinfo(var_0);
    }
    self._id_20AF = 0.15;

    if(isDefined(self) && isalive(self)) {
      self setgoalpos(self.origin);
    }
    var_1 = getent("fight_zone", "targetname");
    var_2 = getnode(var_1.target, "targetname");

    if(isDefined(self) && isalive(self) && self istouching(var_1)) {
      self setgoalnode(var_2);
      self setgoalvolume(var_1);
    }
  }
}

_id_65A3(var_0) {
  self endon("death");
  self endon("fighting_time");
  wait 0.5;
  self waittill("goal");
  var_1 = distancesquared(self.origin, level.player.origin);

  if(var_1 > var_0 * var_0 && !maps\payback_util::_id_64F6(self)) {
    self delete();
  } else {
    self notify("got_to_end");
    self.ignoreall = 0;
    self.ignoreme = 0;
    self getenemyinfo(level.player);
    self.alertlevel = "combat";
  }
}

_id_65A4() {
  self endon("death");
  self endon("got_to_end");
  self addaieventlistener("grenade danger");
  self addaieventlistener("gunshot");
  self addaieventlistener("silenced_shot");
  self addaieventlistener("bulletwhizby");
  self addaieventlistener("projectile_impact");
  self waittill("ai_event", var_0);
  _id_65A2(level.player);
  level notify("runners_shot");
  common_scripts\utility::flag_set("runners_shot");
}

_id_65A5(var_0) {
  while(level._id_659C.size > 0) {
    foreach(var_2 in level._id_659C) {
      if(!isalive(var_2) || !var_2 istouching(var_0)) {
        level._id_659C = common_scripts\utility::array_remove(level._id_659C, var_2);
      }
    }

    wait 0.1;
  }
}

_id_65A6() {
  common_scripts\utility::flag_wait("sandstorm_section_end");
  level notify("sandstorm_section_end");
  maps\payback_rescue::_id_650E();
}

_id_65A7() {
  level endon("sandstorm_section_end");
  level.player endon("death");

  while(!common_scripts\utility::flag("sandstorm_section_end")) {
    var_0 = getaiarray("axis");
    var_0 = maps\_utility::_id_1361(var_0);

    if(var_0.size > 0) {
      var_1 = randomintrange(0, var_0.size);
      var_2 = var_0[var_1];
      var_2 maps\_utility::_id_1EFE("order_move_combat");
    }

    wait(randomfloatrange(1.5, 5.0));
  }
}

_id_65A8(var_0) {
  level endon("sandstorm_section_end");
  var_1 = getent(var_0, "targetname");
  var_1._id_1032 = "marketstall";
  var_1 maps\_anim::_id_1244();
  var_1 thread maps\_anim::_id_124E(var_1, "payback_sstorm_market_stall_loop", "end_market_stall_loop");
  common_scripts\utility::flag_wait(var_0 + "_tear");
  var_1 notify("end_market_stall_loop");
  maps\_audio::aud_send_msg("sandstorm_market_tear", var_1);
  thread _id_65A9();
  var_1 maps\_anim::_id_1246(var_1, "payback_sstorm_market_stall_tear");
  var_1 maps\_anim::_id_1246(var_1, "payback_sstorm_market_stall_exit");
}

_id_65A9() {
  wait 1;
  var_0 = common_scripts\utility::getStructArray("wind_physics", "targetname");
  var_1 = 0.25;

  foreach(var_3 in var_0) {
    physicsexplosionsphere(var_3.origin, 50, 40, var_1);
    wait(randomfloatrange(0.15, 0.35));
    var_1 = var_1 + 0.5;
  }
}

_id_65AA(var_0, var_1) {
  level endon("sandstorm_section_end");
  var_2 = common_scripts\utility::getstruct(var_1, "targetname");
  var_3 = getent(var_0, "targetname");
  var_3._id_1032 = "watertower";
  var_3 maps\_anim::_id_1244();
  var_2 thread maps\_anim::_id_124E(var_3, "payback_sstorm_water_tower_idle", "end_water_tower");
  common_scripts\utility::flag_wait(var_1 + "_fall");
  var_2 notify("end_water_tower");
  maps\_audio::aud_send_msg("sandstorm_watertower_fall", var_3);
  var_2 maps\_anim::_id_1246(var_3, "payback_sstorm_water_tower_fall");
}

_id_65AB() {
  level endon("sandstorm_section_end");
  common_scripts\utility::flag_wait("sandstorm_scaffold_fall");
  var_0 = common_scripts\utility::getstruct("sandstorm_construction_anim_origin", "targetname");
  var_1 = getent("sandstorm_scaffolding_collapse", "targetname");
  var_1._id_1032 = "payback_scaffolding_collapse";
  var_1 useanimtree(level._id_1245[var_1._id_1032]);
  maps\_audio::aud_send_msg("payback_scaffolding_collapse", var_1);
  var_0 thread maps\_anim::_id_1246(var_1, "payback_scaffolding_collapse");
}

_id_6508() {
  level endon("sandstorm_section_end");
  level._id_65AC = getEntArray("sandstorm_swinging_lamps", "targetname");

  foreach(var_1 in level._id_65AC) {
    var_1._id_1032 = "moroccan_lamp";
    var_1 maps\_anim::_id_1244();
    var_1 thread maps\_anim::_id_124E(var_1, "wind_heavy", "end_lamp_swing");
    playFXOnTag(level._effect["lights_point_white_payback"], var_1, "tag_light");
    wait(randomfloatrange(0.1, 0.25));
  }
}

_id_65AD() {
  level endon("sandstorm_section_end");
  level._id_65AC = getEntArray("sandstorm_swinging_lamps", "targetname");

  foreach(var_1 in level._id_65AC) {
    if(isDefined(var_1.target)) {
      var_1._id_1032 = "moroccan_lamp";
      var_1 maps\_anim::_id_1244();
      var_1 thread maps\_anim::_id_124E(var_1, "wind_heavy", "end_lamp_swing");
      var_2 = getent(var_1.target, "targetname");
      var_3 = common_scripts\utility::spawn_tag_origin();
      var_3 linkto(var_1, "tag_light", (0, 0, 0), (0, 0, 0));
      var_2 thread maps\_utility::_id_2765(var_3);
      playFXOnTag(level._effect["lights_point_white_payback"], var_1, "tag_light");
      wait(randomfloatrange(0.1, 0.25));
    }
  }
}

_id_65AE(var_0, var_1) {
  level endon("sandstorm_section_end");
  common_scripts\utility::flag_wait("spawn_uaz1");
  var_2 = maps\_vehicle::_id_2881("uaz1");
  var_2 thread maps\payback_sandstorm_code::_id_6489();
  var_2 thread _id_65B5();
  level._id_65AF = 0;
  var_2 thread _id_65B0();
  var_2 waittill("damage", var_3, var_4);
  level._id_658E = 1;

  if(var_4 == level.player) {
    var_2 vehicle_setspeed(0, 35);
    var_5 = var_2 maps\_vehicle::_id_2514();

    foreach(var_7 in var_5) {
      var_7.ignoreme = 0;
      var_7.ignoreall = 0;
      var_7 getenemyinfo(var_4);
      var_7._id_20AF = 0.25;
    }
  }
}

_id_65B0() {
  wait 0.25;
  level._id_6590 = self._id_0A39;

  foreach(var_1 in level._id_6590) {
    if(isDefined(var_1) && isalive(var_1)) {
      var_1.ignoreall = 1;
      var_1 maps\_utility::_id_123B();
      var_1.pathrandompercent = 0;
      var_1._id_0FC6 = 1;
      var_1.goalradius = 8;
      var_1.walkdist = 0;
      var_1._id_117F = 1;
      var_1._id_1032 = "generic";

      switch (randomint(3)) {
        case 0:
          var_1 maps\_utility::_id_26F7("payback_pmc_sandstorm_stumble_1");
          break;
        case 1:
          var_1 maps\_utility::_id_26F7("payback_pmc_sandstorm_stumble_2");
          break;
        case 2:
          var_1 maps\_utility::_id_26F7("payback_pmc_sandstorm_stumble_3");
          break;
      }

      var_1 thread _id_65B1();
      var_1 thread _id_65B2();
    }
  }

  self waittill("reached_end_node");
  thread _id_65B3(level._id_6590);
}

_id_65B1() {
  self endon("death");
  var_0 = getnode(self.script_noteworthy, "targetname");
  self waittill("jumpedout");

  if(level._id_658E) {
    self.ignoreall = 0;
    maps\payback_sandstorm_code::_id_648A();
  } else {
    self.goalradius = 8;
    self setgoalnode(var_0);
    self waittill("goal");

    if(isalive(self) && !level._id_65AF) {
      maps\_anim::_id_11C1(self, self.animation);
    }
  }
}

_id_65B2() {
  level endon("uaz1_guys_fighting");
  self addaieventlistener("grenade danger");
  self addaieventlistener("gunshot");
  self addaieventlistener("silenced_shot");
  self addaieventlistener("bulletwhizby");
  self addaieventlistener("projectile_impact");
  self waittill("ai_event", var_0);
  level._id_65AF = 1;
  self stopanimscripted();
  maps\_utility::_id_140C();
  self setgoalpos(self.origin);
  self.ignoreall = 0;
  self.ignoreme = 0;
  self._id_20AF = 0.25;
  wait 0.1;
  var_1 = getent("uaz_fight_volume", "targetname");
  var_2 = common_scripts\utility::getstruct("sstorm_flare_anim", "targetname");
  self setgoalpos(var_2.origin);
  self setgoalvolume(var_1);
  level notify("uaz1_guys_fighting");
}

_id_65B3(var_0) {
  level waittill("uaz1_guys_fighting");

  foreach(var_2 in var_0) {
    if(isDefined(var_2) && isalive(var_2)) {
      var_2 stopanimscripted();
      var_2 orientmode("face default");
      var_2 maps\_utility::_id_2686();
      var_2.ignoreall = 0;
      self.goalradius = 200;
      var_2._id_20AF = 0.15;
      var_2.alertlevel = "combat";
    }
  }
}

_id_65B4(var_0) {
  if(var_0.size > 0) {
    thread maps\payback_util::_id_596C(var_0, var_0.size, "uaz_guys_dead");
    common_scripts\utility::flag_wait("uaz_guys_dead");
  } else {
    common_scripts\utility::flag_set("uaz_guys_dead");
  }
  _id_6585("sandstorm_move_to_alley");
  wait 2;
  common_scripts\utility::flag_set("stop_blackout");
}

_id_65B5() {
  common_scripts\utility::flag_wait("sandstorm_uaz1_vo_ready");
  maps\_utility::_id_25F3("see_jeep");
  _id_6598();
  var_0 = getent("sandstorm_intro_after_vehicle", "targetname");
  thread maps\_utility::_id_11F4("payback_pri_vehiclecoming_r");
  _id_6584(var_0);
  thread _id_65B8();
}

_id_65B6() {
  common_scripts\utility::flag_wait("blackout_flare_on");
  level._id_4877 maps\_utility::_id_168C("payback_pri_takeemout");
  wait 0.5;
  _id_65B7();
}

_id_65B7() {
  level._id_54E0._id_20AF = 10;
  level._id_4877._id_20AF = 10;
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {}
  var_2.ignoreme = 0;

  if(isDefined(var_0[0]) && isalive(var_0[0])) {
    level._id_54E0 getenemyinfo(var_0[0]);
    level._id_4877 getenemyinfo(var_0[0]);
  }
}

_id_65B8() {
  common_scripts\utility::flag_wait("sandstorm_dead_ahead");
  var_0 = level._id_54E0._id_20AF;
  var_1 = level._id_4877._id_20AF;
  maps\_utility::_id_11F4("payback_mct_deadahead_r");
  level._id_4877._id_1032 = "price";

  if(level._id_65AF == 0) {
    thread _id_65B6();
  } else {
    level._id_4877 maps\_utility::_id_168C("payback_pri_takeemout");
    _id_65B7();
  }

  common_scripts\utility::flag_wait("uaz_guys_dead");
  level._id_54E0._id_20AF = var_0;
  level._id_4877._id_20AF = var_1;
  maps\_utility::_id_1425("blackout_done");
  _id_6597();
  maps\_utility::_id_11F4("payback_mct_wereclear_r");
  level._id_4877 maps\_utility::_id_168C("payback_pri_gottamove");
  wait 0.5;
  common_scripts\utility::flag_set("contact_echo");
}

_id_65B9() {
  common_scripts\utility::flag_wait("contact_echo");
  level._id_4877 maps\_utility::_id_168C("payback_pri_echoteam2");
  wait 0.25;
  maps\_utility::_id_11F4("payback_eol_locatedchopper");
}

_id_65BA() {
  common_scripts\utility::flag_wait("sandstorm_runner_see_you");
  thread _id_65BC();
  thread _id_65BB();
  var_0 = getent("ss_window_guy_c", "targetname");
  var_1 = var_0 maps\_utility::_id_166F(1);
  var_1 thread maps\payback_sandstorm_code::_id_648A();
  var_1._id_1032 = "generic";
  var_1 maps\_utility::_id_26F7("payback_pmc_sandstorm_stumble_3");
  var_2 = getnode("ss_middle_search_node", "targetname");
  var_0 = getent("ss_window_guy_l", "targetname");
  var_3 = var_0 maps\_utility::_id_166F(1);
  var_3 thread maps\payback_sandstorm_code::_id_5387("alley_fight");
  var_4 = getent("ss_left_search_guy", "targetname");
  var_0 = getent("ss_window_guy_r", "targetname");
  var_5 = var_0 maps\_utility::_id_166F(1);
  var_5 thread maps\payback_sandstorm_code::_id_5387("alley_fight");
  var_6 = getent("ss_right_search_guy", "targetname");
  var_7 = [var_1, var_3, var_5];
  thread _id_65C5(var_7, "alley_fight");
  var_1 setgoalnode(var_2);
  thread _id_65BD(var_3);
  _id_65BE(var_5);
  thread maps\payback_util::_id_596C(var_7, var_7.size, "lookers_dead");

  if(common_scripts\utility::flag("sandstorm_in_alley")) {
    if(!common_scripts\utility::flag("alley_fight") && !common_scripts\utility::flag("lookers_dead")) {
      maps\_utility::_id_11F4("payback_mct_theyknow_r");
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

_id_65BB() {
  level endon("lookers_deleted");
  common_scripts\utility::flag_wait("alley_fight");
  common_scripts\utility::flag_wait("lookers_dead");
  maps\_utility::_id_25F3("window_lookers");
}

_id_65BC() {
  level endon("death");
  level endon("lookers_deleted");
  common_scripts\utility::flag_wait("enemies_right");

  if(!common_scripts\utility::flag("alley_fight")) {
    common_scripts\utility::flag_wait("lookers_dead");
    maps\_utility::_id_11F4("payback_mct_thatwaseasy_r");
  }
}

_id_65BD(var_0) {
  var_0 endon("death");
  var_0 maps\_anim::_id_11C1(var_0, "active_patrolwalk_pause");
  var_0 maps\_anim::_id_11C1(var_0, "active_patrolwalk_turn_180");
}

_id_65BE(var_0) {
  var_0 endon("death");
  var_0 maps\_anim::_id_11C1(var_0, "active_patrolwalk_v5");
  var_0 maps\_anim::_id_11C1(var_0, "active_patrolwalk_v5");
  var_0 maps\_anim::_id_11C1(var_0, "active_patrolwalk_turn_180");
}

_id_65BF() {
  common_scripts\utility::flag_wait("echo_vo");
  maps\_utility::_id_11F4("payback_tm2_reachednikolai");
  wait 0.5;
  level._id_4877 maps\_utility::_id_168C("payback_pri_hangon");
}

_id_65C0() {
  common_scripts\utility::flag_wait("sandstorm_end_runners2");
  thread _id_5698::_id_5683(5);
  var_0 = maps\payback_util::_id_5DD7("sandstorm_end_runners2");
  var_1 = maps\payback_util::_id_5DD7("sandstorm_end_wavers2");
  var_2 = common_scripts\utility::array_combine(var_0, var_1);
  thread _id_65C5(var_2, "end_runners_fight");
  var_3 = getnode("sandstorm_end_runners2_node", "targetname");
  common_scripts\utility::array_thread(var_0, ::_id_65C2, var_3);
  common_scripts\utility::array_thread(var_1, ::_id_65C3, var_3);
  var_4 = maps\payback_util::_id_5DD7("sandstorm_end_runners3");
  common_scripts\utility::array_thread(var_4, ::_id_65C2, var_3);
  thread maps\payback_util::_id_596C(var_2, var_2.size, "end_runners_dead");
  thread _id_65C1("end_runners_fight", "end_runners_dead");
  var_5 = common_scripts\utility::getstruct("sandstorm_waver_vo_spot", "targetname");
  thread common_scripts\utility::play_sound_in_space("payback_afm_hurry", var_5.origin);
  wait 1.5;
  level._id_4877 maps\_utility::_id_168C("payback_mct_headingfornik");

  if(!common_scripts\utility::flag("end_runners_fight")) {
    level._id_4877 maps\_utility::_id_168C("payback_pri_dropem");
    wait 1;
    common_scripts\utility::flag_set("end_runners_fight");
  }

  common_scripts\utility::flag_wait("end_runners_dead");
  maps\_utility::_id_1425("end_runners_dead");
  _id_6597();
  common_scripts\utility::trigger_off("ss_allies_wavers1", "targetname");
  _id_6585("ss_allies_wavers2");
  maps\_utility::_id_11F4("payback_mct_wereclear_r");
}

_id_65C1(var_0, var_1) {
  var_2 = level._id_54E0._id_20AF;
  var_3 = level._id_4877._id_20AF;
  common_scripts\utility::flag_wait(var_0);
  level._id_54E0._id_20AF = 1000;
  level._id_4877._id_20AF = 1000;
  common_scripts\utility::flag_wait(var_1);
  level._id_54E0._id_20AF = var_2;
  level._id_4877._id_20AF = var_3;
}

_id_65C2(var_0) {
  if(randomfloat(100) < 75) {
    maps\payback_sandstorm_code::_id_648A();
  }
  maps\_utility::_id_2724(10);
  self setgoalpos(self.origin);
  wait 2;

  if(isDefined(self) && isalive(self)) {
    _id_65C4(var_0, "end_runners_fight");
  }
}

_id_65C3(var_0) {
  self endon("death");
  self endon("end_runners_fight");
  var_1 = common_scripts\utility::getstruct(self.script_noteworthy, "targetname");
  var_1 maps\_anim::_id_122F(self, self.animation);
  var_1 maps\_anim::_id_11C1(self, self.animation);
  _id_65C4(var_0, "end_runners_fight");
}

_id_65C4(var_0, var_1) {
  self endon("death");

  if(isDefined(var_1) && (!isDefined(self.script_noteworthy) || isDefined(self.script_noteworthy) && self.script_noteworthy != "no_intterupt")) {
    level endon(var_1);
  }
  maps\_utility::_id_2724(100);
  self setgoalnode(var_0);
  wait 1;
  self waittill("goal");
  wait 0.2;

  if(maps\payback_util::_id_64F6(self)) {
    self.ignoreall = 0;
    self.ignoreme = 0;
    wait 1;
    self getenemyinfo(level.player);
  } else {
    self delete();
  }
}

_id_65C5(var_0, var_1) {
  level endon("death");
  self endon("deleted");

  foreach(var_3 in var_0) {}
  var_3 thread _id_65C6(var_1);

  level waittill(var_1);
  common_scripts\utility::array_thread(var_0, ::_id_65C7);
}

_id_65C6(var_0) {
  self endon("death");
  self endon("deleted");
  level endon(var_0);
  self addaieventlistener("grenade danger");
  self addaieventlistener("gunshot");
  self addaieventlistener("silenced_shot");
  self addaieventlistener("bulletwhizby");
  self addaieventlistener("projectile_impact");
  self waittill("ai_event", var_1);
  _id_65C7(level.player);
  level notify(var_0);
  common_scripts\utility::flag_set(var_0);
}

_id_65C7(var_0) {
  self endon("death");
  self endon("deleted");

  if(!isDefined(var_0)) {
    wait(randomfloatrange(0.5, 2.0));
  }
  if(isDefined(self) && isalive(self)) {
    self.ignoreme = 0;
    self.ignoreall = 0;
    self._id_20AF = 0.2;
    self stopanimscripted();
    self setgoalpos(self.origin);

    if(isDefined(var_0)) {
      self getenemyinfo(var_0);
    } else {
      self getenemyinfo(level.player);
    }
  }
}