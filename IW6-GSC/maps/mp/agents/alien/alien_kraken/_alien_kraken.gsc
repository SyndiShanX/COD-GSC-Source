/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\alien\alien_kraken\_alien_kraken.gsc
***************************************************************/

precacheanims() {}

getdefinitionvalue(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 2;

  var_2 = tablelookup("mp/alien/alien_kraken_definition.csv", 0, var_0, var_1);

  if(!isstring(var_0)) {
    if(!issubstr(var_2, "."))
      var_2 = int(var_2);
    else
      var_2 = float(var_2);
  }

  return var_2;
}

getarraydefinitionvalue(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 2;

  var_2 = strtok(tablelookup("mp/alien/alien_kraken_definition.csv", 0, var_0, var_1), " ,");

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(!isstring(var_0)) {
      if(!issubstr(var_2[var_3], ".")) {
        var_2[var_3] = int(var_2[var_3]);
        continue;
      }

      var_2[var_3] = float(var_2[var_3]);
    }
  }

  return var_2;
}

getstagearraydefinitionvalues(var_0, var_1) {
  var_2 = "kraken";

  for(var_3 = 0; var_3 < 4; var_3++) {
    var_4 = "stage_" + (var_3 + 1);
    level.alien_types[var_2].attributes[var_4][var_0] = getarraydefinitionvalue(var_1, 2 + var_3);
  }
}

getstagedefinitionvalues(var_0, var_1) {
  var_2 = "kraken";

  for(var_3 = 0; var_3 < 4; var_3++) {
    var_4 = "stage_" + (var_3 + 1);
    level.alien_types[var_2].attributes[var_4][var_0] = getdefinitionvalue(var_1, 2 + var_3);
  }
}

gettentacledefinitionvalues(var_0, var_1) {
  var_2 = "kraken";
  var_3 = level.alien_types[var_2].attributes["tentacle_names"].size;

  for(var_4 = 0; var_4 < var_3; var_4++) {
    var_5 = level.alien_types[var_2].attributes["tentacle_names"][var_4];
    level.alien_types[var_2].attributes[var_5][var_0] = getdefinitionvalue(var_1, 2 + var_4);
  }
}

loadkrakenattributes() {
  var_0 = "kraken";
  level.alien_types[var_0] = spawnStruct();
  level.alien_types[var_0].attributes = [];

  if(maps\mp\alien\_utility::isplayingsolo())
    level.kraken_attribute_table = "mp/alien/alien_kraken_definition_solo.csv";
  else
    level.kraken_attribute_table = "mp/alien/alien_kraken_definition.csv";

  level.alien_types[var_0].attributes["emissive"] = getdefinitionvalue(21.0);
  level.alien_types[var_0].attributes["max_emissive"] = getdefinitionvalue(22.0);
  level.alien_types[var_0].attributes["view_height"] = getdefinitionvalue(23);
  level.alien_types[var_0].attributes["anim_scale"] = getdefinitionvalue(20.0);
  level.alien_types[var_0].attributes["model"] = getdefinitionvalue("2");
  level.alien_types[var_0].attributes["tentacle_model"] = getdefinitionvalue("3");
  level.alien_types[var_0].attributes["starting_health"] = getdefinitionvalue(24);
  level.alien_types[var_0].attributes["movement_radius"] = getdefinitionvalue(25);
  level.alien_types[var_0].attributes["reckless_health_threshold"] = getdefinitionvalue(30.0);
  level.alien_types[var_0].attributes["default_damage_multiplier"] = getdefinitionvalue(70.0);
  level.alien_types[var_0].attributes["vulnerable_multiplier_1p"] = getdefinitionvalue(71.0);
  level.alien_types[var_0].attributes["vulnerable_multiplier_2p"] = getdefinitionvalue(72.0);
  level.alien_types[var_0].attributes["vulnerable_multiplier_3p"] = getdefinitionvalue(73.0);
  level.alien_types[var_0].attributes["vulnerable_multiplier_4p"] = getdefinitionvalue(74.0);
  level.alien_types[var_0].attributes["health_scalar_1p"] = getdefinitionvalue(75);
  level.alien_types[var_0].attributes["health_scalar_2p"] = getdefinitionvalue(76);
  level.alien_types[var_0].attributes["health_scalar_3p"] = getdefinitionvalue(77);
  level.alien_types[var_0].attributes["posture_min_interval"] = getdefinitionvalue(31);
  level.alien_types[var_0].attributes["posture_max_interval"] = getdefinitionvalue(32);
  level.alien_types[var_0].attributes["tentacle_damage_multiplier"] = getdefinitionvalue(78.0);
  level.alien_types[var_0].attributes["heated_smash_volume"] = getdefinitionvalue("90");
  level.alien_types[var_0].attributes["tentacle_names"] = ["L1", "L2", "R1", "R2"];
  getstagedefinitionvalues("spawn_phase_duration", 100.0);
  getstagedefinitionvalues("spawn_phase_health_limit", 101.0);
  getstagedefinitionvalues("charge_phase_duration", 102.0);
  getstagedefinitionvalues("charge_phase_health_limit", 103.0);
  getstagedefinitionvalues("heated_phase_health_threshold", 104.0);
  getstagedefinitionvalues("heated_phase_damage_per_second", 105.0);
  getstagedefinitionvalues("transition_submerge_time", 106.0);
  getstagedefinitionvalues("emerge_teleport_position", "107");
  getstagedefinitionvalues("ship_side", "108");
  getstagedefinitionvalues("emp_loop_duration", 109.0);
  getstagedefinitionvalues("smash_radius", 110);
  getstagedefinitionvalues("smash_inner_damage", 111);
  getstagedefinitionvalues("smash_outer_damage", 112);
  getstagedefinitionvalues("random_smash_min_interval", 113.0);
  getstagedefinitionvalues("random_smash_max_interval", 114.0);
  getstagearraydefinitionvalues("mass_smash_times", 115);
  getstagedefinitionvalues("mass_smash_interval", 116);
  getstagedefinitionvalues("emp_damage_location", "117");
  getstagedefinitionvalues("emp_damage", 118);
  getstagedefinitionvalues("emp_notify", "119");
  getstagedefinitionvalues("encounter_name", "120");
  getstagearraydefinitionvalues("spawn_times", "121");
  getstagedefinitionvalues("heated_smash_tentacle_name", "122");
  getstagedefinitionvalues("smash_trigger_cooldown", 123.0);
  getstagedefinitionvalues("smash_trigger_activation_time", 124.0);
  getstagedefinitionvalues("smash_trigger_deactivation_time", 125.0);
  getstagedefinitionvalues("emp_shock_duration", 126);
  getstagedefinitionvalues("emp_disable_duration", 127);
  level.kraken_safe_spot_volumes = loadkrakenvariablenumberofstringentries("50");
  gettentacledefinitionvalues("port_location", "200");
  gettentacledefinitionvalues("starboard_location", "201");
  gettentacledefinitionvalues("anim_index", 202);
  gettentacledefinitionvalues("port_melee_triggers", "203");
  gettentacledefinitionvalues("starboard_melee_triggers", "204");
  loadspawnwaves();
}

loadspawnwaves() {
  level.kraken_spawn_waves = [];

  for(var_0 = 300; var_0 <= 399; var_0++) {
    var_1 = tablelookup(level.kraken_attribute_table, 0, var_0, 1);

    if(var_1 == "") {
      break;
    }

    level.kraken_spawn_waves[var_1] = [];

    for(var_2 = 2; var_2 < 10; var_2++) {
      var_3 = tablelookup(level.kraken_attribute_table, 0, var_0, var_2);

      if(var_3 == "") {
        break;
      }

      var_4 = level.kraken_spawn_waves[var_1].size;
      level.kraken_spawn_waves[var_1][var_4] = var_3;
    }
  }
}

loadkrakenvariablenumberofstringentries(var_0) {
  var_1 = [];
  var_2 = 0;
  var_3 = int(var_0);

  for(;;) {
    var_4 = "" + (var_3 + var_2);
    var_5 = getdefinitionvalue(var_4);

    if(var_5 == "") {
      break;
    }

    var_6 = getent(var_5, "targetname");

    if(!isDefined(var_6))
      var_6 = common_scripts\utility::getstruct(var_5, "targetname");

    if(isDefined(var_6))
      var_1[var_1.size] = var_6;

    var_2++;
  }

  return var_1;
}

loadkrakenfx() {
  level._effect["kraken_water_spray_emitter"] = loadfx("vfx/gameplay/alien/vfx_alien_kraken_water_spray_emitter");
  level._effect["kraken_rt_water_spray_emitter"] = loadfx("vfx/gameplay/alien/vfx_alien_kraken_rt_water_spray_emitter");
  level._effect["kraken_water_stream_emitter"] = loadfx("vfx/ae/aln_krk_h2o_strm_e");
  level._effect["kraken_water_sweep_rt_emitter"] = loadfx("vfx/gameplay/alien/vfx_alien_kraken_water_sweep_rt_emitter");
  level._effect["kraken_water_roar_emitter1"] = loadfx("vfx/gameplay/alien/vfx_alien_kraken_water_roar_emitter1");
  level._effect["kraken_water_stream_e_lite"] = loadfx("vfx/gameplay/alien/vfx_alien_krak_water_stream_e_lite");
  level._effect["kraken_water_drip"] = loadfx("vfx/gameplay/alien/vfx_alien_kraken_water_drip_emitter");
  level._effect["kraken_back_glow_01"] = loadfx("vfx/gameplay/alien/vfx_alien_krkn_glow_back");
  level._effect["kraken_water_stream_pincers"] = loadfx("vfx/gameplay/alien/vfx_alien_kraken_water_stream_pincers");
  level._effect["kraken_eye_glow_01"] = loadfx("vfx/gameplay/alien/vfx_alien_kraken_eye_glow_01");
  level._effect["kraken_blood_roar_emitter"] = loadfx("vfx/gameplay/alien/vfx_alien_kraken_blood_roar_emitter");
  level._effect["kraken_blood_roar_gurgle"] = loadfx("vfx/gameplay/alien/vfx_alien_kraken_blood_roar_gurgle");
}

initkraken() {
  level.agent_funcs["kraken"] = [];
  level.agent_funcs["kraken"]["spawn"] = ::alienkrakenspawn;
  level.agent_funcs["kraken"]["on_killed"] = ::alienkrakenkilled;
  level.agent_funcs["kraken"]["on_damaged"] = ::alienkrakendamaged;
  level.agent_funcs["kraken"]["on_damaged_finished"] = ::alienkrakendamagefinished;
  level.custom_alien_attribute_table_init = ::loadkrakenattributes;
  common_scripts\utility::flag_init("fx_kraken_water");
  loadkrakenattributes();
  loadkrakenfx();
  common_scripts\utility::flag_init("fx_kraken_water");
  level.kraken_health_padding = 100000;
}

alienkrakenspawn(var_0, var_1) {
  var_2 = 100;
  var_3 = 250;
  var_4 = maps\mp\agents\_agent_common::connectnewagent("kraken", "axis");

  if(!isDefined(var_0) || !isDefined(var_1)) {}

  var_4 setkrakenmodel();
  var_4.onenteranimstate = ::onenterstate;
  var_4 spawnagent(var_0, var_1, "alien_kraken_animclass", var_2, var_3);
  level notify("spawned_agent", var_4);
  var_4 assignkrakenattributes();
  var_4 setkrakenscriptfields(var_0);
  var_4 scragentsetclipmode("agent");
  var_4 scragentsetphysicsmode("noclip");
  var_4 takeallweapons();
  var_5 = getkrakenhealthscalar();
  var_4.health = int(level.alien_types["kraken"].attributes["starting_health"] * var_5 + 100000);
  var_4.maxhealth = int(level.alien_types["kraken"].attributes["starting_health"] * var_5 + 100000);
  var_4 scragentusemodelcollisionbounds();
  var_4.alien_type = "kraken";
  var_4.weakpointstate = [];
  var_4.ignoreme = 1;
  var_4.stage = "stage_1";
  var_4.damage_multiplier = level.alien_types["kraken"].attributes["default_damage_multiplier"];
  var_4.posturing = 0;
  var_4.smashing = 0;
  var_4.masssmashattackavailable = 0;
  var_4 hide();
  return var_4;
}

attachtentacles() {
  foreach(var_1 in level.alien_types["kraken"].attributes["tentacle_names"]) {
    self.tentacles[var_1] = maps\mp\agents\alien\alien_kraken\_alien_kraken_tentacle::alienkrakententaclespawn(var_1);
    self.tentacles[var_1] hide();
  }
}

getkrakenhealthscalar() {
  switch (level.players.size) {
    case 1:
      return level.alien_types["kraken"].attributes["health_scalar_1p"];
    case 2:
      return level.alien_types["kraken"].attributes["health_scalar_2p"];
    case 3:
      return level.alien_types["kraken"].attributes["health_scalar_3p"];
  }

  return 1.0;
}

getkrakendamagemultiplier() {
  switch (level.players.size) {
    case 1:
      return level.alien_types["kraken"].attributes["vulnerable_multiplier_1p"];
    case 2:
      return level.alien_types["kraken"].attributes["vulnerable_multiplier_2p"];
    case 3:
      return level.alien_types["kraken"].attributes["vulnerable_multiplier_3p"];
    case 4:
      return level.alien_types["kraken"].attributes["vulnerable_multiplier_4p"];
  }
}

setkrakenmodel() {
  var_0 = level.alien_types["kraken"].attributes["model"];
  self setModel(var_0);
  self show();
  self motionblurhqenable();
}

setkrakenscriptfields(var_0) {
  self.species = "alien";
  self.enablestop = 1;
  maps\mp\agents\_agent_utility::activateagent();
  self.spawntime = gettime();
  self.attacking_player = 0;
  self.spawnorigin = var_0;
}

assignkrakenattributes() {
  self.alien_type = "kraken";
  self.moveplaybackrate = 1.0;
  self.defaultmoveplaybackrate = self.moveplaybackrate;
  self.animplaybackrate = self.moveplaybackrate;
  self.xyanimscale = level.alien_types[self.alien_type].attributes["anim_scale"];
  self.defaultemissive = level.alien_types[self.alien_type].attributes["emissive"];
  self.maxemissive = level.alien_types[self.alien_type].attributes["max_emissive"];
  thread setinitialemissive();
  self scragentsetviewheight(level.alien_types[self.alien_type].attributes["view_height"]);
}

setinitialemissive() {
  self endon("death");
  wait 1;
  maps\mp\alien\_utility::set_alien_emissive(0.2, 0.85);
}

alienkrakenthink() {
  self.smash_allowed = 0;
  setkrakenhealth();
  self.phases = buildphases();

  for(self.current_stage_num = 1; self.current_stage_num <= 4; self.current_stage_num++) {
    self.stage = "stage_" + self.current_stage_num;
    common_scripts\utility::flag_set("fx_kraken_water");
    self.current_phase = 0;
    runphases();
  }

  thread thin_alien_herd();
  playdeathanims();
  self suicide();
}

thin_alien_herd() {
  var_0 = common_scripts\utility::array_combine(level.seeder_active_turrets, level.agentarray);
  var_1 = getnodesinradius((129, 5985, 1408), 300, 50, 128, "path");

  foreach(var_3 in var_0) {
    if(isDefined(var_3) && var_3 != level.kraken) {
      if(isalive(var_3) || var_3.model == "alien_spore") {
        if(var_3.team == "axis" && isDefined(var_3.alien_type) && var_3.model != "alien_spore")
          var_3 thread waittil_goal_and_suicide(var_1[randomint(var_1.size)]);
        else if(var_3.model == "alien_spore")
          var_3 notify("death");
      }
    }

    wait(randomfloatrange(1, 2));
  }
}

waittil_goal_and_suicide(var_0) {
  self.alien_scripted = 1;
  self notify("alien_main_loop_restart");
  common_scripts\utility::waitframe();
  self scragentsetgoalnode(var_0);
  self scragentsetgoalradius(128);
  common_scripts\utility::waittill_any_timeout(20, "goal_reached");
  self suicide();
}

runphases() {
  while(self.current_phase != self.phases.size) {
    var_0 = self.phases[self.current_phase];
    self.current_phase++;

    if(var_0["in_final_stage"] || self.current_stage_num != 4)
      runphase(var_0["name"], var_0["func"], var_0["melee_allowed"], var_0["run_cycle"], var_0["min_health_percentage"]);
  }
}

buildphases() {
  var_0 = [];
  var_0[0] = setupphase("emerge", ::runemergephase, 0, 0, "spawn_phase_health_limit", 1);
  var_0[1] = setupphase("spawn", ::runspawnphase, 1, 1, "spawn_phase_health_limit", 1);
  var_0[2] = setupphase("charge", ::runchargephase, 0, 0, "charge_phase_health_limit", 1);
  var_0[3] = setupphase("heat", ::runheatedphase, 1, 1, "heated_phase_health_threshold", 1);
  var_0[4] = setupphase("transition", ::runsubmergephase, 0, 0, "heated_phase_health_threshold", 0);
  return var_0;
}

setupphase(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = [];
  var_6["name"] = var_0;
  var_6["func"] = var_1;
  var_6["melee_allowed"] = var_2;
  var_6["run_cycle"] = var_3;
  var_6["min_health_percentage"] = var_4;
  var_6["in_final_stage"] = var_5;
  return var_6;
}

setkrakenhealth(var_0) {
  if(isDefined(level.players) && level.players.size > 0) {
    var_1 = getkrakenhealthscalar();
    self.health = int(level.alien_types["kraken"].attributes["starting_health"] * var_1 + 100000);
  } else
    self.health = level.alien_types["kraken"].attributes["starting_health"];

  self.maxhealth = self.health;
  thread createbosshealthbar();
}

posturemonitor() {
  self endon("death");
  self endon("spawn_phase_complete");
  level endon("game_ended");
  var_0 = gettime() + randomfloatrange(level.alien_types["kraken"].attributes["posture_min_interval"], level.alien_types["kraken"].attributes["posture_max_interval"]) * 1000.0;

  for(;;) {
    if(gettime() > var_0 && !self.smashing && !self.posturing) {
      self.melee_type = "posture";
      performmeleeattack(self.enemy);

      while(self.posturing)
        wait 0.05;

      var_0 = gettime() + randomfloatrange(level.alien_types["kraken"].attributes["posture_min_interval"], level.alien_types["kraken"].attributes["posture_max_interval"]) * 1000.0;
    }

    wait 0.05;
  }
}

masssmashattacktimer() {
  self endon("death");
  self endon("spawn_phase_complete");
  var_0 = gettime() * 0.001;

  for(var_1 = 0; var_1 < level.alien_types[self.alien_type].attributes[self.stage]["mass_smash_times"].size; var_1++) {
    var_2 = gettime() * 0.001;
    var_3 = level.alien_types[self.alien_type].attributes[self.stage]["mass_smash_times"][var_1] + var_0 - var_2;

    if(var_3 > 0)
      wait(var_3);

    masssmashattack();
  }
}

masssmashattack() {
  self.masssmashattackavailable = 1;
  waitforidletentacles();
  var_0 = common_scripts\utility::array_randomize(level.alien_types[self.alien_type].attributes["tentacle_names"]);

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];
    thread attemptsmashattack(self.current_smash_triggers[var_2], var_2);
    wait(level.alien_types[self.alien_type].attributes[self.stage]["mass_smash_interval"]);
  }

  waitforidletentacles();
  self.masssmashattackavailable = 0;
}

start_cycle() {
  level.encounter_name = level.alien_types[self.alien_type].attributes[self.stage]["encounter_name"];
  maps\mp\alien\_spawn_director::start_cycle(level.cycle_count);
  level.cycle_count++;
}

playdeathanims() {
  self.melee_type = "death";
  common_scripts\utility::exploder(104);
  common_scripts\utility::exploder(105);
  performmeleeattack(self.enemy);
}

runphase(var_0, var_1, var_2, var_3, var_4) {
  self.phase = var_0;
  self.smash_allowed = var_2;
  self.min_health_percentage = level.alien_types[self.alien_type].attributes[self.stage][var_4];

  if(var_3)
    start_cycle();

  [[var_1]]();

  if(var_3)
    maps\mp\alien\_spawn_director::end_cycle();
}

runemergephase() {
  if(self.stage == "stage_1")
    thread run_intro_emissive();
  else
    maps\mp\alien\_utility::set_alien_emissive_default(2.0);

  if(level.alien_types["kraken"].attributes[self.stage]["ship_side"] == "port")
    common_scripts\utility::exploder(102);
  else
    common_scripts\utility::exploder(106);

  self.melee_type = "emerge";
  performmeleeattack(self.enemy);
  waitforextendedtentacles();
}

run_intro_emissive() {
  self endon("death");
  var_0 = 0.85;
  var_1 = 2.0;
  maps\mp\alien\_utility::set_alien_emissive(var_1, var_0);
  wait 15;
  maps\mp\alien\_utility::set_alien_emissive_default(var_1);
}

runspawnphase() {
  var_0 = 0.5;
  var_1 = 0.2;
  maps\mp\alien\_utility::set_alien_emissive_default(2.0);
  thread posturemonitor();

  if(level.alien_types[self.alien_type].attributes[self.stage]["mass_smash_times"].size > 0)
    thread masssmashattacktimer();

  thread smashattackmonitor();
  thread timedsmashattackmonitor();
  initializeattacktriggers();
  thread runspawnmonitor();
  level notify("dlc_vo_notify", "kraken_vo", "warn_horde");
  wait(level.alien_types[self.alien_type].attributes[self.stage]["spawn_phase_duration"]);
  self notify("spawn_phase_complete");
  self.smash_allowed = 0;
  self.masssmashattackavailable = 0;
  waitforidletentacles();
  waitforposturetofinish();
  common_scripts\utility::flag_clear("fx_kraken_water");
  wait 0.1;
}

runspawnmonitor() {
  self endon("spawn_phase_complete");
  var_0 = gettime() * 0.001;

  for(var_1 = 0; var_1 < level.alien_types[self.alien_type].attributes[self.stage]["spawn_times"].size; var_1++) {
    var_2 = gettime() * 0.001;
    var_3 = strtok(level.alien_types[self.alien_type].attributes[self.stage]["spawn_times"][var_1], "-");
    var_4 = int(var_3[0]) + var_0 - var_2;

    if(var_4 > 0)
      wait(var_4);

    for(;;) {
      var_5 = findavailabletentacle();

      if(isDefined(var_5)) {
        break;
      }

      wait 0.05;
    }

    var_5 thread maps\mp\agents\alien\alien_kraken\_alien_kraken_tentacle::spawnattack(var_3[1]);
  }
}

waitforidletentacles() {
  var_0 = 0;

  while(!var_0) {
    var_0 = 1;

    foreach(var_2 in self.tentacles) {
      if(istentaclespawning(var_2.tentacle_name) || istentaclesmashing(var_2.tentacle_name)) {
        var_0 = 0;
        break;
      }
    }

    wait 0.05;
  }
}

waitforposturetofinish() {
  while(self.posturing)
    wait 0.05;
}

waitforextendedtentacles() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    var_0 = 1;

    foreach(var_2 in self.tentacles) {
      if(!var_2 maps\mp\agents\alien\alien_kraken\_alien_kraken_tentacle::isextended()) {
        var_0 = 0;
        break;
      }
    }

    if(var_0) {
      return;
    }
    wait 0.05;
  }
}

findavailabletentacle() {
  var_0 = randomint(self.tentacles.size);

  while(self.masssmashattackavailable)
    wait 0.05;

  for(var_1 = 0; var_1 < self.tentacles.size; var_1++) {
    var_2 = level.alien_types["kraken"].attributes["tentacle_names"][var_0];
    var_3 = istentaclespawning(var_2);

    if(!istentaclespawning(var_2) && !istentaclesmashing(var_2))
      return self.tentacles[var_2];

    var_0++;

    if(var_0 >= self.tentacles.size)
      var_0 = 0;
  }

  return undefined;
}

runchargephase() {
  common_scripts\utility::flag_clear("fx_kraken_water");
  self.melee_type = "charge";
  performmeleeattack(self.enemy);
}

runheatedphase() {
  self notify("smash_attack_reset");
  self notify("heat_phase_started", self.stage);
  self setscriptablepartstate("body", "heat_discharge_body_fx_01");
  var_0 = 0.2;
  var_1 = 1.0;
  maps\mp\alien\_utility::set_alien_emissive(var_0, var_1);
  self.melee_type = "heat";
  performmeleeattack(self.enemy);
  self.damage_multiplier = level.alien_types["kraken"].attributes["default_damage_multiplier"];
  self.kraken_heated = 0;
  self.smash_allowed = 0;
}

setupheatedsmashvolume() {
  var_0 = level.alien_types["kraken"].attributes["heated_smash_volume"];
  var_1 = getent(var_0, "targetname");
  var_2 = level.alien_types["kraken"].attributes[self.stage]["heated_smash_tentacle_name"];
  thread attacktriggerwait(var_1, var_2);
}

runsubmergephase() {
  maps\mp\alien\_utility::set_alien_emissive_default(2.0);

  if(level.alien_types["kraken"].attributes[self.stage]["ship_side"] == "port")
    common_scripts\utility::exploder(103);
  else
    common_scripts\utility::exploder(107);

  self.melee_type = "submerge";
  performmeleeattack(self.enemy);
  level thread do_kraken_tilt();
  self playSound("scn_kraken_reemerge");
}

do_kraken_tilt() {
  foreach(var_1 in level.players) {
    if(isalive(var_1))
      earthquake(0.75, 3, var_1.origin, 100);
  }

  wait 3;
}

attemptsmashattack(var_0, var_1) {
  self endon("death");
  self.last_smash_attack_time = gettime();
  self.melee_type = "smash";
  self.smash_tentacle_name = var_1;
  self.smash_trigger = var_0;
  performmeleeattack(self.enemy);
  self.smash_tentacle_name = undefined;
  self.smash_trigger = undefined;

  if(self.phase == "heat")
    self.tentacles[var_1] thread maps\mp\agents\alien\alien_kraken\_alien_kraken_tentacle::heat();
}

timedsmashattackmonitor() {
  self endon("death");
  self endon("smash_attack_reset");
  var_0 = randomfloatrange(level.alien_types["kraken"].attributes[self.stage]["random_smash_min_interval"], level.alien_types["kraken"].attributes[self.stage]["random_smash_max_interval"]) * 1000.0;

  for(;;) {
    if(canperformmelee() && gettime() - var_0 > self.last_smash_attack_time) {
      if(attemptrandomsmashattack())
        var_0 = randomfloatrange(level.alien_types["kraken"].attributes[self.stage]["random_smash_min_interval"], level.alien_types["kraken"].attributes[self.stage]["random_smash_max_interval"]) * 1000.0;
    }

    wait 0.05;
  }
}

attemptrandomsmashattack() {
  var_0 = findavailabletentacle();

  if(!isDefined(var_0))
    return 0;

  attemptsmashattack(self.current_smash_triggers[var_0.tentacle_name], var_0.tentacle_name);
  return 1;
}

smashattackmonitor() {
  self endon("death");
  self notify("smash_attack_reset");
  self endon("smash_attack_reset");
  self.last_smash_attack_time = gettime();

  for(;;) {
    self waittill("smash_trigger_hit", var_0, var_1);
    attemptsmashattack(var_0, var_1);
  }
}

initializeattacktriggers() {
  var_0 = level.alien_types["kraken"].attributes[self.stage]["ship_side"] + "_melee_triggers";

  foreach(var_2 in level.alien_types["kraken"].attributes["tentacle_names"]) {
    var_3 = level.alien_types["kraken"].attributes[var_2][var_0];
    var_4 = getent(var_3, "targetname");
    self.current_smash_triggers[var_2] = var_4;
    thread attacktriggerwait(var_4, var_2);
  }
}

attacktriggerwait(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self endon("smash_attack_reset");
  var_2 = level.alien_types["kraken"].attributes[self.stage]["smash_trigger_cooldown"];

  for(;;) {
    var_0 waittill("touch", var_3);

    if(!isplayer(var_3)) {
      continue;
    }
    if(!canperformmelee() || istentaclespawning(var_1)) {
      continue;
    }
    if(!isDefined(var_0.has_occupant)) {
      monitortargetintrigger(var_0, var_1);
      var_4 = self.tentacles[var_1] maps\mp\agents\alien\alien_kraken\_alien_kraken_tentacle::getsmashanimlength();
      wait(var_4);
    }

    wait(var_2);
  }
}

istentaclespawning(var_0) {
  return self.tentacles[var_0] maps\mp\agents\alien\alien_kraken\_alien_kraken_tentacle::isspawning();
}

istentaclesmashing(var_0) {
  return self.tentacles[var_0] maps\mp\agents\alien\alien_kraken\_alien_kraken_tentacle::issmashing();
}

monitortargetintrigger(var_0, var_1) {
  self endon("death");
  self endon("melee_attack_reset");
  var_2 = level.alien_types["kraken"].attributes[self.stage]["smash_trigger_activation_time"] * 1000.0;
  var_3 = level.alien_types["kraken"].attributes[self.stage]["smash_trigger_deactivation_time"] * 1000.0;
  var_0.has_occupant = 1;
  var_4 = gettime();
  var_5 = var_4 + var_2;
  var_6 = 0;

  for(;;) {
    var_7 = gettime();

    if(var_7 >= var_5) {
      var_6 = 1;
      break;
    }

    if(!canperformmelee() || istentaclespawning(var_1)) {
      break;
    }

    var_8 = var_0 getistouchingentities(level.players);

    if(var_8.size != 0)
      var_4 = var_7;
    else
      var_9 = 1;

    if(var_4 + var_3 < var_7) {
      break;
    }

    wait 0.05;
  }

  var_0.has_occupant = undefined;

  if(var_6)
    self notify("smash_trigger_hit", var_0, var_1);
}

canperformmelee() {
  return self.smash_allowed && !self.masssmashattackavailable;
}

performmeleeattack(var_0) {
  if(!isDefined(var_0)) {
    var_0 = findanenemy();

    if(!isDefined(var_0))
      return;
  }

  self scragentsetgoalpos(self.origin);
  self scragentsetgoalradius(20000);
  self scragentbeginmelee(var_0);
  self waittill("melee_complete");
}

findanenemy() {
  if(isDefined(self.enemy))
    return self.enemy;

  foreach(var_1 in level.players) {
    if(isDefined(var_1))
      return var_1;
  }

  return undefined;
}

alienkrakenkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {}

alienkrakenprocesshitloc(var_0, var_1) {
  if(var_1 != "soft")
    return "armor";

  return var_1;
}

bullethitarmor(var_0, var_1, var_2) {
  if(isplayer(var_2))
    var_2 thread maps\mp\gametypes\_damagefeedback::updatedamagefeedback("hitalienarmor");
}

alienkrakendamaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!maps\mp\alien\_damage::is_alien_agent_damage_allowed(var_0, var_1, var_5, var_4))
    return 0;

  if(var_4 == "MOD_TRIGGER_HURT")
    return 0;

  if(gethealthratio() < self.min_health_percentage)
    var_2 = 0;

  var_8 = alienkrakenprocesshitloc(var_6, var_8);
  var_10 = "hitalienarmor";
  var_11 = 1.0;

  if(isDefined(self.damage_multiplier))
    var_11 = self.damage_multiplier;

  if(isDefined(self.kraken_heated) && self.kraken_heated) {
    if(maps\mp\alien\_utility::is_true(level.zap_multiplier_active)) {
      var_11 = var_11 + 0.4;
      var_10 = "hitaliensoft";
    } else if(var_8 == "soft") {
      var_11 = var_11 + 0.4;
      var_10 = "hitaliensoft";
    } else
      var_10 = "standard";
  } else if(maps\mp\alien\_utility::is_true(level.zap_multiplier_active)) {
    var_11 = var_11 + 0.3;
    var_10 = "hitaliensoft";
  } else if(var_8 == "soft") {
    var_11 = var_11 + 0.4;
    var_10 = "standard";
  }

  var_2 = var_2 * var_11;
  var_12 = var_5 == "iw6_alienminigun_mp" || var_5 == "iw6_alienminigun1_mp" || var_5 == "iw6_alienminigun2_mp" || var_5 == "iw6_alienminigun3_mp";
  var_13 = var_5 == "iw6_alienminigun4_mp";

  if(var_12 || var_13)
    var_2 = var_2 * 0.45;

  var_14 = var_5 == "iw6_alienmk32_mp" || var_5 == "iw6_alienmk321_mp" || var_5 == "iw6_alienmk322_mp" || var_5 == "iw6_alienmk323_mp" || var_5 == "iw6_alienmk324_mp";

  if(var_14)
    var_2 = var_2 * 0.5;

  var_15 = var_5 == "alien_manned_minigun_turret_mp" || var_5 == "alien_manned_minigun_turret1_mp" || var_5 == "alien_manned_minigun_turret2_mp" || var_5 == "alien_manned_minigun_turret3_mp" || var_5 == "alien_manned_minigun_turret4_mp";

  if(var_15)
    var_2 = var_2 * 0.5;

  var_16 = var_5 == "alien_manned_gl_turret_mp" || var_5 == "alien_manned_gl_turret1_mp" || var_5 == "alien_manned_gl_turret2_mp" || var_5 == "alien_manned_gl_turret3_mp" || var_5 == "alien_manned_gl_turret4_mp";

  if(var_16)
    var_2 = var_2 * 0.5;

  if(isDefined(level.custom_scale_alien_damage_func))
    var_2 = [[level.custom_scale_alien_damage_func]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);

  if(var_5 == "alienthrowingknife_mp") {
    var_2 = 0;
    var_0 delete();
  } else if(!var_12 && !var_13)
    var_2 = maps\mp\alien\_damage::set_alien_damage_by_weapon_type(var_4, var_5, var_2);

  if(isplayer(var_1) && !maps\mp\alien\_utility::is_trap(var_0)) {
    var_2 = maps\mp\alien\_damage::scale_alien_damage_by_perks(var_1, var_2, var_4, var_5);
    var_2 = maps\mp\alien\_damage::scale_alien_damage_by_weapon_type(var_1, var_2, var_4, var_5, var_8);
  }

  var_2 = maps\mp\alien\_damage::scale_alien_damage_by_prestige(var_1, var_2);
  var_2 = int(var_2);

  if(isDefined(var_1)) {
    if(isDefined(var_1.owner) && isplayer(var_1.owner))
      var_1.owner thread maps\mp\gametypes\_damagefeedback::updatedamagefeedback(var_10);
    else
      var_1 thread maps\mp\gametypes\_damagefeedback::updatedamagefeedback(var_10);
  }

  if(var_2 <= 0)
    return 0;

  return self[[maps\mp\agents\_agent_utility::agentfunc("on_damaged_finished")]](var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

alienkrakendamagefinished(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_3 = var_3 | level.idflags_no_knockback;
  self finishagentdamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, 0.0, 0);
}

onenterstate(var_0, var_1) {
  onexitanimstate(var_0, var_1);
  self.currentanimstate = var_1;

  switch (var_1) {
    case "idle":
      maps\mp\agents\alien\alien_kraken\_alien_kraken_idle::main();
      break;
    case "melee":
      maps\mp\agents\alien\alien_kraken\_alien_kraken_melee::main();
      break;
  }
}

onexitanimstate(var_0, var_1) {
  self notify("killanimscript");

  switch (var_0) {
    case "melee":
      maps\mp\agents\alien\alien_kraken\_alien_kraken_melee::endscript();
      break;
  }
}

createbosshealthbar() {
  var_0 = 2;
  var_1 = 0;
  var_2 = 0;
  var_3 = 2;
  setomnvar("ui_alien_boss_icon", var_3);
  setomnvar("ui_alien_boss_status", var_0);
  common_scripts\utility::waitframe();
  setomnvar("ui_alien_boss_progression", var_2);
  var_4 = 100000;

  while(self.health > 100000) {
    common_scripts\utility::waittill_any("damage", "hp_update");

    if(!isDefined(self) || self.health <= 0) {
      break;
    }

    var_5 = gethealthratio();
    var_6 = 100 - var_5 * 100;
    var_7 = 0.5;

    if(abs(abs(var_4) - abs(var_6)) > var_7) {
      setomnvar("ui_alien_boss_progression", var_6);
      var_4 = var_6;
    }
  }

  setomnvar("ui_alien_boss_status", var_1);
}

gethealthratio() {
  return max((self.health - level.kraken_health_padding) / (self.maxhealth - level.kraken_health_padding), 0.0);
}

play_kraken_eyeglow1_fx() {
  wait 3.0;
  playFXOnTag(level._effect["kraken_eye_glow_01"], level.kraken, "tag_eye");
  wait 5.0;
  playFXOnTag(level._effect["kraken_back_glow_01"], level.kraken, "j_spineback_up");
}

stop_kraken_eyeglow1_fx() {
  stopFXOnTag(level._effect["kraken_eye_glow_01"], level.kraken, "tag_eye");
  wait 1.0;
  stopFXOnTag(level._effect["kraken_back_glow_01"], level.kraken, "j_spineback_up");
}